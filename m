Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F87C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADDA20674
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tzBd2PDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADDA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD026E0A2;
	Thu, 23 Jul 2020 14:43:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085906E0A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 14:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc4q2QMiIS88crjNUwBAqL7j/JSN7uirO7uxX8Z5/POc3De5oaP06bJilf7BUNa9ZxKeW6o0ooSJSbh/SNdMWqVPKav+QJQqTIkwJG6SO70xaBimfruF+5h8qWPXZjKSZBgTRqARrQzMJQuPMmjeAJZX5kmi4a7ryDs8+//C85G7VmIDUJv/o1zBI2nOggwcbQlnasm9/pz0ni38hBtu7+b9LD5Mu375a6olQ9pCs7PhOFVZzfqMH+55aN13dyDV+7vuVRdlK1iCveipCMang9ncopLvUlKCBVZPpJK3brCmbwVvCOF5L0RiYgcT0fOuFo+7zP8rpr1EeswmN7VbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rSz5z9WjBP1Y2hTRkqrcYkieTugH4jS8W+4nyofjPw=;
 b=CmrC+0QTkxfo290JictIcottE5U+tJFX4xDJwMGdun7LgP6XUppIhSCilEQLCspwqKTs7FrzysVgzxoIxEQwu80SUfvzOy6W7UtfHlueZMRIINPND+u35zw7xZOuA/UxP0zxOswCfzzm80YMm9I3yFeMjR3AfEdLosWP+yBpgqxhX1xVhhSYUjgY1RpnhiwpUk0c1029M+wqDIQUenhatOzPDbr40VHQrdlHfXP6zUQw4XuePrtwgo3aHFCPsKs/eC7lqH6UL1mTPq6C2h2GI8/YGObXzI39PF0u6r4p3XHw1m7G3SB4CkLtnWBEQoDLhNUNeyY0WEx+GmYGMYGWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rSz5z9WjBP1Y2hTRkqrcYkieTugH4jS8W+4nyofjPw=;
 b=tzBd2PDvqUf4fc7eiQBHk/ulAb0Rx+p1xAPrmUSL4FAehC8UxSoejUKcTPxP0UASsce5r9V/2zgG0ZFSbohQ8/PFBOh42RBLFj0miyPIMUwxwxyr2ICQaeXU996XCBlB4ksSxefrEStii00J5n1H2RWjt9xcFitXjDCBvcQ83vo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 14:43:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 14:43:51 +0000
Subject: Re: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
From: Nirmoy <nirmodas@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20200710145047.52383-1-nirmoy.das@amd.com>
 <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
 <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
Message-ID: <43411c44-dce7-e215-5b7e-994d4ff4d1d1@amd.com>
Date: Thu, 23 Jul 2020 16:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.122.24) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Thu, 23 Jul 2020 14:43:50 +0000
X-Originating-IP: [217.86.122.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e900c89f-0b3d-41da-5ceb-08d82f16d0ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314F278A1868CCC33E68BF08B760@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIKM5Leg7uquMvovW7ix3vKKyGT6UqPBpVrzEo5BlYbJH/5D9keFbdCF88PydiMvJFh4p6IQRmdJLDhCHiIiPMr0xR/+ZydeCP24EAVd+kX6UNMqvpKUtBUNKrbTaztsitizI/r6DBD0ivJqws+ooduesUO64BW6aXm2i49g4+RPT4oQP2i/MHiYZkz9lrd3fIpfp5fYboAC22aXbNQNtUC6HVMFR+fNrkWiWJWagqVhp5NJexFak0+tQT/q5PfxUqpqJr/HOCWdXA1w7eGkB7RkoCSJuBnzOvYN6ahQfS2hp25UvR8RjKEoj3ASJfEP/1BksXhku4Zo75Bdn/kuB/BE+hKxm56BuuZv7d7TdikKZ6pNdKtSZuhQ/X2k924yXLDsiQCED3yb/AA0L6Ldf7i89MsFR9MiVp94E6ZQnGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(956004)(2616005)(66556008)(66476007)(66946007)(186003)(26005)(16526019)(6666004)(31696002)(52116002)(6636002)(54906003)(110136005)(478600001)(2906002)(16576012)(53546011)(45080400002)(83380400001)(36756003)(5660300002)(966005)(8676002)(8936002)(6486002)(316002)(4326008)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: znjgADquhn10A4lhZ25v8c5CxGVExtlSsbzCHYjlwpVrxM8rbZoTjSfsX9ze4ABjI7w1aYlwN/u//nykIQOE8a9oKm/Uadc3siQd739Kbm3RO1VbQVKErxlZNn4VT7AU6KKRqdG4+1Q6Ya/U9aqUAGdJ9EG5RqeoE8ARgt0LTOs3taRC5OKxllTqJn734mFPWXP3P6JZvxTBfG0Sse3HJOk8sicSryXtITHNmoZ99PL65RMVCcPeqLQWvsi6kax4rEKTfmdoWs1ishbUvMWskyNjIGFKHt0Par2PsrrFhXns+q3v+TKWT3UnbxhKu95tgBwqlNwAYhZb6jzo/AKvh1TOYRjEhVt+uQa8Ma2zhPQN+rnvTpAkhU0tAGOU6K4KoJVp8C+zMP2gwLwfsAJNXspVhmsUMqUFi4IrcIjYxa64yiYhgBbbiU6qCd1RJ/K1Z4EecNyBAD8XaxG97si6bibFcKRVQQ+NRlRpNxmYeZ8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e900c89f-0b3d-41da-5ceb-08d82f16d0ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 14:43:51.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8nc+GLrGaQB/1q5h8UKhfJ1Yak4qPaOPL5xqK/c7OLbK8SQ0rFW/VRCMg2KNTp/rtRv3mbqnUxEjkpcg3Iamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGVzdGVkIERldmljZSBwYXNzdGhyb3VnaCB3aXRoIHBvbGFyaXMocnggNTcwKSwgdGhlIHBhdGNo
IGhhZCBubyBlZmZlY3QuCgpXaXRoIG9yIHdpdGhvdXQgdGhlIHBhdGNoIEkgY291bGQgb25seSBk
byBwYXNzdGhyb3VnaCAzIHRpbWVzIGJlZm9yZSB0aGUgCmhvc3QgdGhyb3dzCgpJT01NVSBlcnJv
ci4KCgpbIDIxMC43NjIxNTBdIHZmaW8tcGNpIDAwMDA6MDE6MDAuMTogY2FuJ3QgY2hhbmdlIHBv
d2VyIHN0YXRlIGZyb20gRDAgdG8gCkQzaG90IChjb25maWcgc3BhY2UgaW5hY2Nlc3NpYmxlKQoK
WyAyMTAuNzYyNzMyXSB2ZmlvLXBjaSAwMDAwOjAxOjAwLjA6IGNhbid0IGNoYW5nZSBwb3dlciBz
dGF0ZSBmcm9tIEQwIHRvIApEM2hvdCAoY29uZmlnIHNwYWNlIGluYWNjZXNzaWJsZSkKClsgMjEw
Ljg5OTczNV0gQU1ELVZpOiBDb21wbGV0aW9uLVdhaXQgbG9vcCB0aW1lZCBvdXQKClsgMjExLjAy
MjgyNF0gQU1ELVZpOiBDb21wbGV0aW9uLVdhaXQgbG9vcCB0aW1lZCBvdXQKClsgMjExLjE0NTQz
NF0gQU1ELVZpOiBDb21wbGV0aW9uLVdhaXQgbG9vcCB0aW1lZCBvdXQKClsgMjExLjI2ODI1MF0g
QU1ELVZpOiBDb21wbGV0aW9uLVdhaXQgbG9vcCB0aW1lZCBvdXQKClsgMjExLjc3ODU5M10gaW9t
bXUgaXZoZDA6IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT1RMQl9JTlZfVElNRU9VVCAKZGV2aWNl
PTAxOjAwLjAgYWRkcmVzcz0weDEwN2Q1ZmI1MF0KClsgMjEyLjc4MDQ5NF0gaW9tbXUgaXZoZDA6
IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT1RMQl9JTlZfVElNRU9VVCAKZGV2aWNlPTAxOjAwLjAg
YWRkcmVzcz0weDEwN2Q1ZmI5MF0KClsgMjEyLjc4MTA2MF0gaW9tbXUgaXZoZDA6IEFNRC1WaTog
RXZlbnQgbG9nZ2VkIFtJT1RMQl9JTlZfVElNRU9VVCAKZGV2aWNlPTAxOjAwLjAgYWRkcmVzcz0w
eDEwN2Q1ZmJiMF0KCgpSZWdhcmRzLAoKTmlybW95CgpPbiA3LzIzLzIwIDQ6MjIgUE0sIE5pcm1v
eSB3cm90ZToKPiBIaSBBbGV4LAo+Cj4gT24gNy8yMy8yMCAzOjU5IFBNLCBBbGV4IERldWNoZXIg
d3JvdGU6Cj4+IENhbiB5b3UgY2hlY2sgYW5kIG1ha2Ugc3VyZSB0aGlzIGRvZXNuJ3QgYnJlYWsg
cG9sYXJpcyBvciBzb21lIG90aGVyIAo+PiBnZW5lcmF0aW9uPwo+Cj4KPiBEbyB5b3UgbWVhbiBi
cmVha2luZyBkZXZpY2UgcGFzc3Rocm91Z2ggb3Igbm9ybWFsIG9wZXJhdGlvbiA/IEkgaGF2ZSBh
IAo+IHJ4IDU3MCwKPgo+IEkgY2FuIHRlc3Qgb24gdGhhdC4KPgo+Cj4gUmVnYXJkcywKPgo+IE5p
cm1veQo+Cj4KPj4KPj4gQWxleAo+Pgo+PiBPbiBXZWQsIEp1bCAxNSwgMjAyMCBhdCAxOjEyIEFN
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiB3cm90ZToKPj4+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPj4+Cj4+PiBBY2tlZC1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPj4+Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+Pj4gRnJvbTogTmlybW95IERhcyA8bmlybW95LmFpZW1kQGdtYWlsLmNvbT4KPj4+
IFNlbnQ6IEZyaWRheSwgSnVseSAxMCwgMjAyMCAxMDo1MSBQTQo+Pj4gVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbiAKPj4+IDxFdmFuLlF1YW5AYW1kLmNvbT47IERh
cywgTmlybW95IDxOaXJtb3kuRGFzQGFtZC5jb20+Cj4+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IGRvIG5vdCBkaXNhYmxlIFNNVSBvbiB2bSByZWJvb3QKPj4+Cj4+PiBGb3IgcGFzc3Ro
cm91Z2ggZGV2aWNlLMKgIHdlIGRvIGJhY28gcmVzZXQgYWZ0ZXIgMXN0IHZtIGJvb3Qgc28KPj4+
IGlmIHdlIGRpc2FibGUgU01VIG9uIDFzdCBWTSBzaHV0ZG93biBiYWNvIHJlc2V0IHdpbGwgZmFp
bCBmb3IKPj4+IDJuZCB2bSBib290Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMg
PG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMKPj4+IGluZGV4IGQxYWRiYzQ1ZDM3Yi4uMDdiZTYxY2U5NjlhIDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+IEBAIC0x
MTc4LDcgKzExNzgsOCBAQCBhbWRncHVfcGNpX3NodXRkb3duKHN0cnVjdCBwY2lfZGV2ICpwZGV2
KQo+Pj4gwqDCoCAqIHVuZm9ydHVuYXRlbHkgd2UgY2FuJ3QgZGV0ZWN0IGNlcnRhaW4KPj4+IMKg
wqAgKiBoeXBlcnZpc29ycyBzbyBqdXN0IGRvIHRoaXMgYWxsIHRoZSB0aW1lLgo+Pj4gwqDCoCAq
Lwo+Pj4gLWFkZXYtPm1wMV9zdGF0ZSA9IFBQX01QMV9TVEFURV9VTkxPQUQ7Cj4+PiAraWYgKCFh
bWRncHVfcGFzc3Rocm91Z2goYWRldikpCj4+PiArYWRldi0+bXAxX3N0YXRlID0gUFBfTVAxX1NU
QVRFX1VOTE9BRDsKPj4+IMKgIGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZChhZGV2KTsKPj4+IMKg
IGFkZXYtPm1wMV9zdGF0ZSA9IFBQX01QMV9TVEFURV9OT05FOwo+Pj4gwqAgfQo+Pj4gLS0gCj4+
PiAyLjI3LjAKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJG
bGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NOaXJtb3kuRGFzJTQwYW1kLmNv
bSU3Q2Y0MDE4Y2EzMWJkZjQ4MWUwYmJhMDhkODJmMTA5NmI4JTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzMxMTA5NTU5MTM0MjEwMyZhbXA7c2RhdGE9UHZS
VkVNekhQZVFuUUMlMkJmN0RJMVkzdm5FWkxucDlBZiUyRjA3S0FJUWpLc00lM0QmYW1wO3Jlc2Vy
dmVkPTAgCj4+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
