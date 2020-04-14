Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44468C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E55220768
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TK92esb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E55220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80486E197;
	Tue, 14 Apr 2020 14:59:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472A26E197
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDTEJ2pZEjQKpetS+G5vhGF7vy+lVGU3bnqnsAA12csn+ELts2Hdu0BglqhWu9vDWzzUpmlS6e4vQT1vb4uXMc9YP66MZKcUv1FDC2Yfkp5P8FQOpyIX/d06xU27KRy4kGjxGzvmFdYKNCzL1uLqgBecNHb2Ox40Uj8n8Fw9owt0bUBMT/IWR1N1j75WqjzHIytxY6BZ42rWGEg64FfyxRXEIKwhNwiGIBmqsNUG0QbhEqe7lAqWF4gPGls3s9dIMgN850WOd8EHUhTe/A3u4PJLJ9hBc9wTC8wc2JvQiR38OX3ZiSo4mw61B2rMsIgPx8yHTj5sa4aprsUjyQyNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWP2M5PQg6HEteC3OLRgoeOT9rl94/a+pznIB0P34JM=;
 b=CFr+z6oHvtTL0kF61v6PMjRtJsJhVXlx4zu8kAWc3VL9w/0SHw/BKjB6zZicGqTtFzAe4T7qsl6ysaGxKLZQxi64gmvDTMlysTZzKNZoSBDKIUyitmh+C8gEkaF66s4W2p287Sf/7N5QYJycF8+EJA8ihwuQFnIeEoqCO+D/e9r2h9iZ12lZJBmxPHAjD6KnY3Rmvr97YkpOlhYbTLxRDTJKZaYlFPDiKVyn+8ktUR1/T0gg+9kLHjrY+/MQoMvSsOKlsfxQFAHegLySb3E6mvZjfPtxndF556wpBS0Hpi86RdD7hJUYFQEabtv7LuQ/s6x1T5zCbDgs051zGEdLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWP2M5PQg6HEteC3OLRgoeOT9rl94/a+pznIB0P34JM=;
 b=TK92esb25CjMUAyFb16Upl7VsCtWFK6sn0NWknSFWj8KLhmMQcuR+ZaGKf/77+a4NDXhkjkHwDW45oOeLFN0Es/dbY4+KbuxS9ZG/ETvyxDxQub+YLjNufvpHBUBMtVELZ/4z/zBFG0+e5fqrHFON1Rn+1NBumSXC6rVIoA30+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Tue, 14 Apr 2020 14:59:52 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:59:52 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
From: James Zhu <jamesz@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
Organization: AMD RTG
Message-ID: <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
Date: Tue, 14 Apr 2020 10:59:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 14:59:52 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f1743a8-2a5a-4963-26a9-08d7e0847c81
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:|DM5PR12MB1692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16928B28A8AE2316924178BDE4DA0@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(66476007)(956004)(8676002)(45080400002)(66946007)(478600001)(52116002)(16576012)(66556008)(26005)(2616005)(36756003)(6486002)(4326008)(36916002)(5660300002)(8936002)(6636002)(316002)(966005)(81156014)(110136005)(54906003)(31696002)(2906002)(186003)(16526019)(53546011)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CYJbxDqv2zZFEEt5bihsag9bW13eXNtFG4X86lNrPDUYY1No/J+EJq7oG6zpmqJ4FIVJ5aQ17g6kTkvlkBb1AxpbqWQJqq+B/J5KecmcBnbfnKrnag2ZZMWH9w96as9knSwxasb9SGsZiKJOLhzRKovyCswst80PT/CBU2UXvAvTsv0jzFmxr317mJDXigpP3YXh1qIK36OmqP4OiA8iPbnse0+eNTpBLWopzFPR2PoCwoccwuaywuGv+Rdd2+723XImjge/4QPccjj25/wd2/4S93EbELJKPQM2K7d2Om/+Ayn5Az1rn1NXwXIEvPzfj9XZHh9WLrxowQL+mus9EwbzAc0FhfExctPBFN4uASrHfygkCtVHbexpgSVJzyrYwl/XmMkxIL3A9iYB/dNyDD5FzUIRc7WTmdvDD+NWHj0htqe3w7C7RsjhVTMRCqK/7khKLR9qsly2ILTqhNlMCpOqWgbU+e94cNVs3GTjsk=
X-MS-Exchange-AntiSpam-MessageData: Kf9rMRhMd+zPxqLTxyH4R03ODoqNSziyldJYW7bsuVromjCcejYqCl+W6qRy3eIWNTWm87Zd9sFA50UjXRyA2wMfqM214/Mg7u0TcVKy5mTT8Q0bM9rpLcERB0LPJcWtWoCrTfHHVaTW7NXJLg6cTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1743a8-2a5a-4963-26a9-08d7e0847c81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 14:59:52.7177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zh41YoCWAM5aNcZmHS6BLL4GcpRJuz2eA6GW5WroNzlP3FtpSCGhYyyjcA5nFuAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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
Cc: changzhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

K0hhd2tpbmcKCkhpIEhhd2tpbmcsCgpjYW4gd2UgZHJvcCB0aGlzIFdBPwoKVGhhbmtzIQoKSmFt
ZXMKCk9uIDIwMjAtMDQtMTQgMTA6NTIgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+ICtSZXgKPgo+
IFRoaXMgaXMgaW50cm9kdWNlIGJ5IGJlbG93IHBhdGNoLgo+Cj4gY29tbWl0IDNmZGVkMjIyZjRi
ZjdmNGM1NmVmNDg1NDg3MmEzOWE0ZGUwOGY3YTgKPiBBdXRob3I6IFJleCBaaHUgPFJleC5aaHVA
YW1kLmNvbT4KPiBEYXRlOsKgwqAgRnJpIEp1bCAyNyAxNzowMDowMiAyMDE4ICswODAwCj4KPiDC
oMKgwqAgZHJtL2FtZGdwdTogRGlzYWJsZSBnZnggb2ZmIGlmIFZDTiBpcyBidXN5Cj4KPiDCoMKg
wqAgdGhpcyBwYXRjaCBpcyBhIHdvcmthcm91bmQgZm9yIHRoZSBncHUgaGFuZwo+IMKgwqDCoCBh
dCB2aWRlbyBiZWdpbi9lbmQgdGltZSBpZiBnZnggb2ZmIGlzIGVuYWJsZWQuCj4KPiDCoMKgwqAg
UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiDCoMKg
wqAgU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgo+IMKgwqDCoCBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPgo+
IE9uIDIwMjAtMDQtMTQgMTA6MjIgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBUdWUs
IEFwciAxNCwgMjAyMCBhdCA4OjA1IEFNIEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+IHdy
b3RlOgo+Pj4gVHVybiBvZmYgZ2Z4b2ZmIGNvbnRyb2wgd2hlbiB2Y24gaXMgZ2F0ZWQuCj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgOCArKysrKy0t
LQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+IGlu
ZGV4IGRhYjM0ZjYuLmFhOWE3YTUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYwo+Pj4gQEAgLTM2OSw5ICszNjksMTEgQEAgdm9pZCBhbWRncHVfdmNuX3Jp
bmdfYmVnaW5fdXNlKHN0cnVjdCAKPj4+IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4gY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgIG11dGV4X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+PiAtwqDCoMKgwqDC
oMKgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+Pj4gLcKgwqDCoMKgwqDCoCBh
bWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCAKPj4+IEFNRF9JUF9C
TE9DS19UWVBFX1ZDTiwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURfUEdfU1RB
VEVfVU5HQVRFKTsKPj4+ICvCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnZjbi5jdXJfc3RhdGUgPT0g
QU1EX1BHX1NUQVRFX0dBVEUpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFt
ZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgCj4+
PiBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEFNRF9QR19TVEFURV9VTkdBVEUpOwo+Pj4gK8KgwqDCoMKgwqDCoCB9
Cj4+Pgo+PiBXaHkgYXJlIHdlIHRvdWNoaW5nIGdmeG9mZiB3aXRoIFZDTj/CoCBXYXMgdGhpcyBh
IGxlZnRvdmVyIGZyb20gYnJpbmcKPj4gdXA/wqAgQ2FuIHdlIGp1c3QgZHJvcCBhbGwgb2YgdGhp
cyBnZnhvZmYgc3R1ZmYgZnJvbSBWQ04gaGFuZGxpbmc/wqAgSQo+PiBkb24ndCBzZWUgd2h5IHRo
ZXJlIHdvdWxkIGJlIGEgZGVwZW5kZW5jeS4KPj4KPj4gQWxleAo+Pgo+Pj4gwqDCoMKgwqDCoMKg
wqDCoCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKcKgwqDCoCB7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHBnX3BhdXNlX3N0
YXRlIG5ld19zdGF0ZTsKPj4+IC0tIAo+Pj4gMi43LjQKPj4+Cj4+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVl
ZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdD
MDElN0NKYW1lcy5aaHUlNDBhbWQuY29tJTdDM2RkOTEzNWM3MTdhNGIzMDExZTMwOGQ3ZTA3ZjUy
YjYlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjI0NzA5
NzYzMzkxODQ1JmFtcDtzZGF0YT1ZJTJCdHNKUU5CMVRYQ1E5djg2RFclMkYwRkM2M2dPU0hzZnp6
WkZ1ME1EdkNIdyUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
