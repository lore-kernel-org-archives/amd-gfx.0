Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC4BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C99820866
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1PGmw4UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C99820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276336E9B6;
	Thu, 13 Aug 2020 11:06:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375D76E9BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 11:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQEvs1bWP4XY9hndzTF7GlFuj144ljenbkSjcPMmKV385ugJYY2gQqA6VV9N5o9K6vjRb/lO8CGNCCzt/6d4mxYz6UfWlt/bzvO2Fh+c1TiJO6ZTuxSZoCzO83yIKxkbiw1bJYR0Cku7REbkfjzkyC87RPa3McWOed9/FSSxz+N76m9v0nyRaPDOtfX/GB09xWO4adm18huN22Jc0FYZm6gw5tNmdopu+OqAvwqjDDuS3tYGjpmvUkbGKqv+hzESgLP9al4dbLMIOWe197WFOOb3mk7IxDEeFLnMtUvC0JfP15NIU7zaMwhpXD/iCi+ojJqEnq2VmTWtNlm6z+8rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEVVW1iWFAdlYFdjezHbQDE0yBa/TqXHWfQwjo4H61A=;
 b=QKV9cNIWgqx5Jz6C/fIVeyc4D8rlZHobw5ypqoCdq7lBpO3WEsB+ZjZk0i97px9wROBEksx6X9pA4k9HluV6cm0opYnBW9CE9oTpBod5vhKmCUtjPoDupwCYiyF19E7JS8yb3EH86iVtikvUnZCqF+7TGAgQFpAYj2PYPbb0WEW1j8BE48EBXHIJdJ5dkB9YllppSar2GErH3rnHXhtvc4Vzt2k8a2VzdhBUsYlmORyArNqVu+OjDcTnjTgmKr16hPbuGIbYvmXYUz8hXD87GL1DGhOicRGyY4REmlZ/HIBaS0ZNkvLuJzGqERrSz3yD7Yk38HES3EAKrSNCfboqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEVVW1iWFAdlYFdjezHbQDE0yBa/TqXHWfQwjo4H61A=;
 b=1PGmw4UFsXtX3BNLUcPJAMSigcdFZbC5FRJhS2M51LQCDJ2In+grumiHjb4gsAKtic4ACCjoczOUcUag410lIB9YcuPuRXoP1UAyky0EqUCZabKR4tMb20XZpskREggbWF/Zjft1p6qzWEIsi5dF10kI8n7T+ZQyptwtF/cqoss=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 11:05:57 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::718b:874b:e858:382c]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::718b:874b:e858:382c%2]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 11:05:57 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
Date: Thu, 13 Aug 2020 13:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.124.70) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.13 via Frontend Transport; Thu, 13 Aug 2020 11:05:56 +0000
X-Originating-IP: [217.86.124.70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c74ac81-df12-4c47-f79c-08d83f78db0a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4215F40E3932510AD55544668B430@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ml4uJLajixmxoqRYY4ZnEnNg2zdWaEokJo2mwORdkqGQQrw+vbjZ405ptqzdnMwGicU9DkEol0dIuWg+ekTZgDF2/yCBkY5ADC5iOE6SZUb/zO/KaszRRm5tEYZqtDj7QPhRNo1je8AEsrpUwH3PWNghDhdJ6W+Ksm5nhQTQ6OISzob82P7VHIDiG0uQsfjTBWuVJkISlM0mYzhOAfjtBa4Yq11X9yydkkjPmMDwUh3apGefIa/S5IPiiaSctWOoxXfUQxC23AvrG9zOrBcEk5ZNbqiM/SVtdBvf+C3xXcZcE6OtSLEfloK6wSl/iSTFqBBi2Npzqe7D41AnzC94rV4zBILje9MZLO6dgz5cxMWz7UJxib3r42DsqGFiGXJFBeMZOuNv0DzrI5Cx4TyeOgJE0hASUNRPCEUD0aMPa26gfzaheTC7VDWI1piLaoGNvdErwAwnMIo9e7gP7fSHag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(6486002)(2616005)(53546011)(36756003)(8936002)(2906002)(4326008)(31686004)(110136005)(316002)(16576012)(8676002)(956004)(31696002)(66946007)(186003)(66476007)(83380400001)(16526019)(966005)(5660300002)(6666004)(52116002)(66556008)(478600001)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: alPi+742Rvmyo9PivOw7R0CVOpkDDe9/1Tl5AR0j3v7t02ArK2Jsa9V3K1xEKaI9jo2hdiY5zuNczGIo0pcqhCcYm1LkgSfKMUTyG59eDZbaNlBHWoZod25bpBI7YpfHybTY5R5s5GdVjUoVUrqPm5iSFIOUSuh+g9wR694Mucqi+geWsS90Q2PbZWwcMGyFDIjhitt6uouyAKgnJ1uWHl3noESVvyoXpoFVhiz5MUuTapNoTN1V77P+qJ23z9bo6mAEyFYx36DxtENAVIpfz9G8OyGyjW6hwjpXopB5FovdRz5fjujymtkz31sSJGykj36LrUxPaiwboq27Hv6+GGXvc3tUvaKDfJhV1VYzrcIi+274+nqiFVhCoJ+p6P/NHfUwkrqXF0CLmEX+8bKNtseyNwIWNKASFBw5UieXS+626qgpsBsF9mHYTO3R/yI0+zoL5Hre+kwRvEnAwv7UCRH891+1CkC/FMCxEvCGbYR2C+D9nVeGvaXZGyUEJwjY3vrlQytz3k/S29S9srPwFLJ5y5CBNTBK03kly2DUf7Hw5jaNaFWtkVj2ZUjv+SaNEmNEwZ6pmN15xjy61nOj5hiwmjbo0oGdG5qfI6Xhv275MOmE6UFm5UFR2ydcHWJj+F7SUZ5NBoGXfmXYSg0UWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c74ac81-df12-4c47-f79c-08d83f78db0a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3911.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 11:05:57.7888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqCALw+SSXfHLMeKMxVKAm1hL8zIo35AK/7GrrE2M8s2ecrWQev22+adbjVOjmyO4/uuNeGMVxGEuQoVngcbWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMTIvMjAgNDo1MiBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4KPiBPbiA4LzEx
LzIwIDk6MzAgQU0sIE5pcm1veSBEYXMgd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggd2lsbCBpZ25vcmUg
bm9uLWZhdGFsIGVycm9ycyBhbmQgdHJ5IHRvCj4+IHN0b3AgYW1kZ3B1J3Mgc3cgc3RhY2sgb24g
ZmF0YWwgZXJyb3JzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFz
QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKystCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCA1NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiBpbmRleCBjMTIxOWFmMmU3ZDYuLjJiOWVkZTMw
MDBlZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiBA
QCAtMzUsNiArMzUsNyBAQAo+PiDCoCAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+PiDC
oCAjaW5jbHVkZSA8bGludXgvdmdhX3N3aXRjaGVyb28uaD4KPj4gwqAgI2luY2x1ZGUgPGRybS9k
cm1fcHJvYmVfaGVscGVyLmg+Cj4+ICsjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWNfaGVscGVyLmg+
Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KPj4gwqAgwqAgI2luY2x1ZGUg
ImFtZGdwdS5oIgo+PiBAQCAtMTUxNiw2ICsxNTE3LDU4IEBAIHN0YXRpYyBzdHJ1Y3QgZHJtX2Ry
aXZlciBrbXNfZHJpdmVyID0gewo+PiDCoMKgwqDCoMKgIC5wYXRjaGxldmVsID0gS01TX0RSSVZF
Ul9QQVRDSExFVkVMLAo+PiDCoCB9Owo+PiDCoCArc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYW1k
Z3B1X3BjaV9lcnJfZGV0ZWN0ZWQoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9jaGFubmVsX3N0YXRlX3Qg
c3RhdGUpCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRf
ZHJ2ZGF0YShwZGV2KTsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRl
di0+ZGV2X3ByaXZhdGU7Cj4+ICvCoMKgwqAgaW50IGk7Cj4+ICvCoMKgwqAgaW50IHJldCA9IFBD
SV9FUlNfUkVTVUxUX0RJU0NPTk5FQ1Q7Cj4+ICsKPj4gK8KgwqDCoCBzd2l0Y2ggKHN0YXRlKSB7
Cj4+ICvCoMKgwqAgY2FzZSBwY2lfY2hhbm5lbF9pb19ub3JtYWw6Cj4+ICvCoMKgwqDCoMKgwqDC
oCByZXQgPSBQQ0lfRVJTX1JFU1VMVF9DQU5fUkVDT1ZFUjsKPj4gK8KgwqDCoMKgwqDCoMKgIGJy
ZWFrOwo+PiArwqDCoMKgIGRlZmF1bHQ6Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBEaXNhYmxlIHBv
d2VyIG1hbmFnZW1lbnQgKi8KPj4gK8KgwqDCoMKgwqDCoMKgIGFkZXYtPnJ1bnBtID0gMDsKPj4g
K8KgwqDCoMKgwqDCoMKgIC8qIFN1c3BlbmQgYWxsIElPIG9wZXJhdGlvbnMgKi8KPj4gK8KgwqDC
oMKgwqDCoMKgIGFtZGdwdV9mYmRldl9zZXRfc3VzcGVuZChhZGV2LCAxKTsKPj4gKyBjYW5jZWxf
ZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPj4gK8KgwqDCoMKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3Nb
aV07Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyaW5nIHx8ICFyaW5nLT5z
Y2hlZC50aHJlYWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
Cj4+ICsKPj4gKyBhbWRncHVfam9iX3N0b3BfYWxsX2pvYnNfb25fc2NoZWQoJnJpbmctPnNjaGVk
KTsKPgo+Cj4gWW91IG5lZWQgdG8gY2FsbCBkcm1fc2NoZWRfc3RvcCBmaXJzdCBiZWZvcmUgY2Fs
bGluZyB0aGlzCj4KPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGFkZXYtPm1vZGVfaW5mby5tb2RlX2NvbmZpZ19pbml0aWFsaXplZCkgewo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikp
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX2hlbHBlcl9mb3JjZV9kaXNh
YmxlX2FsbChhZGV2LT5kZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9hdG9taWNfaGVscGVyX3NodXRkb3du
KGFkZXYtPmRkZXYpOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqDCoMKgwqDC
oCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmkoYWRldik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRn
cHVfZmJkZXZfZmluaShhZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qIFRyeSB0byBjbG9zZSBk
cm0gZGV2aWNlIHRvIHN0b3AgYXBwbGljYXRpb25zCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogZnJv
bSBvcGVuaW5nIGRyaSBmaWxlcyBmb3IgZnVydGhlciBJTyBvcGVyYXRpb25zLgo+PiArwqDCoMKg
wqDCoMKgwqDCoCAqIFRPRE86IFRoaXMgd2lsbCB0aHJvdyB3YXJuaW5nIGFzIHR0bSBpcyBub3QK
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBjbGVhbmVkIHBlcnBlcmx5ICovCj4+ICvCoMKgwqDCoMKg
wqDCoCBkcm1fZGV2X2ZpbmkoZGV2KTsKPgo+Cj4gSSB0aGluayB1c2VyIG1vZGUgYXBwbGljYXRp
b25zIG1pZ2h0IHN0aWxsIGhvbGQgcmVmZXJlbmNlIHRvIHRoZSBkcm0gCj4gZGV2aWNlIHRocm91
Z2ggdGhyb3VnaCBkcm1fZGV2X2dldCBlaXRoZXIgYnkgZGlyZWN0bHkgb3BlbmluZwo+IHRoZSBk
ZXZpY2UgZmlsZSBvciBpbmRpcmVjdGx5IHRocm91Z2ggaW1wb3J0aW5nIERNQSBidWZmLCBpZiBz
byB3aGVuIAo+IHRoZSBsYXN0IG9mIHRoZW0gdGVybWluYXRlIAo+IGRybV9kZXZfcHV0LT5kcm1f
ZGV2X3JlbGVhc2UtPi4uLi0+ZHJtX2Rldl9maW5pCj4gbWlnaHQgZ2V0IGNhbGxlZCBhZ2FpbiBj
YXVzaW5nIHVzZSBhZnRlciBmcmVlIGUudC5jIGlzc3Vlcy4gTWF5YmUgCj4gYmV0dGVyIHRvIGNh
bGwgaGVyZSBkcm1fZGV2X3B1dCB0aGVuIGFuZCBzbyBkcm1fZGV2X2Zpbmkgd2lsbCBnZXQgCj4g
Y2FsbGVkIHdoZW4gdGhpcwo+IGxhc3QgdXNlciBjbGllbnQgcmVsZWFzZXMgaGlzIHJlZmVyZW5j
ZS4KCgpkcm1fZGV2X2ZpbmkoKSBzZWVtcyB0byBiZSBjbGVhbmVyLiBQcm9ibGVtIGlzwqAgd2lu
ZG93IG1hbmFnZXIoc3dheSkgCm5ldmVyIGdldHMgdGVybWluYXRlZCBhZnRlciB0aGUgQUVSIGVy
cm9yIGFuZCBkcm0gZmlsZXMgcmVtYWlucyBhY3RpdmUuIApTaW1wbGUgY2F0IG9uIGRyaSBmaWxl
cwoKZ29lcyB0aG91Z2ggYW1kZ3B1IGFuZCBzcGl0cyBvdXQgbW9yZSBlcnJvcnMuCgoKPgo+IEFs
c28gYSBnZW5lcmFsIHF1ZXN0aW9uIC0gaW4gbXkgd29yayBvbiBEUEMgcmVjb3ZlcnkgZmVhdHVy
ZSB3aGljaCAKPiB0cmllcyB0byByZWNvdmVyIGFmdGVyIFBDSWUgZXJyb3IgLSBvbmNlIHRoZSBQ
Q0kgZXJyb3IgaGFzIGhhcHBlbmVkIAo+IE1NSU8gcmVnaXN0ZXJzIGJlY29tZQo+IHVuYWNjZXNz
aWJsZSBmb3Igci93IGFzIHRoZSBQQ0kgbGluayBpcyBkZWFkIHVudGlsIGFmdGVyIHRoZSBQQ0kg
bGluayAKPiBpcyByZXNldCBieSB0aGUgRFBDIGRyaXZlciAoc2VlIAo+IGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L1BDSS9wY2ktZXJyb3ItcmVjb3ZlcnkuaHRtbCAKPiBz
ZWN0aW9uIDYuMS40KS4KPiBZb3VyIGNhc2UgaXMgdG8gdHJ5IGFuZCBncmFjZWZ1bGx5IHRvIGNs
b3NlIHRoZSBkcm0gZGV2aWNlIG9uY2UgZmF0YWwgCj4gZXJyb3IgaGFwcGVuZWQsIGRpZG4ndCB5
b3UgZW5jb3VudGVyIGVycm9ycyBvciB3YXJuaW5ncyB3aGVuIGFjY2Vzc2luZyAKPiBIVyByZWdp
c3RlcnMgZHVyaW5nIGFueSBvZiB0aGUgb3BlcmF0aW9ucwo+IGFib3ZlID8KCgpBcyBkaXNjdXNz
ZWQgb3ZlciBjaGF0LCBpdCBzZWVtcyBhZXIgZ2VuZXJhdGVkIHdpdGggYWVyLWluamVjdCB0b29s
IGp1c3QgCnRyaWdnZXJzIGtlcm5lbCBQQ0kgZXJyb3IgQVBJcyBidXQgdGhlIGRldmljZSBpcyBz
dGlsbCBhY3RpdmUgc28gSSAKZGlkbid0IGVuY291bnRlciBhbnkgZXJyb3JzIHdoZW4gYWNjZXNz
aW5nIEhXIHJlZ2lzdGVycy4KCgpOaXJtb3kKCgo+Cj4gQW5kcmV5Cj4KPgo+PiArwqDCoMKgwqDC
oMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4g
K30KPj4gKwo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXJyb3JfaGFuZGxlcnMgYW1kZ3B1
X2Vycl9oYW5kbGVyID0gewo+PiArwqDCoMKgwqDCoMKgIC5lcnJvcl9kZXRlY3RlZCA9IGFtZGdw
dV9wY2lfZXJyX2RldGVjdGVkLAo+PiArfTsKPj4gKwo+PiArCj4+IMKgIHN0YXRpYyBzdHJ1Y3Qg
cGNpX2RyaXZlciBhbWRncHVfa21zX3BjaV9kcml2ZXIgPSB7Cj4+IMKgwqDCoMKgwqAgLm5hbWUg
PSBEUklWRVJfTkFNRSwKPj4gwqDCoMKgwqDCoCAuaWRfdGFibGUgPSBwY2lpZGxpc3QsCj4+IEBA
IC0xNTIzLDEwICsxNTc2LDkgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGFtZGdwdV9rbXNf
cGNpX2RyaXZlciAKPj4gPSB7Cj4+IMKgwqDCoMKgwqAgLnJlbW92ZSA9IGFtZGdwdV9wY2lfcmVt
b3ZlLAo+PiDCoMKgwqDCoMKgIC5zaHV0ZG93biA9IGFtZGdwdV9wY2lfc2h1dGRvd24sCj4+IMKg
wqDCoMKgwqAgLmRyaXZlci5wbSA9ICZhbWRncHVfcG1fb3BzLAo+PiArwqDCoMKgIC5lcnJfaGFu
ZGxlciA9ICZhbWRncHVfZXJyX2hhbmRsZXIsCj4+IMKgIH07Cj4+IMKgIC0KPj4gLQo+PiDCoCBz
dGF0aWMgaW50IF9faW5pdCBhbWRncHVfaW5pdCh2b2lkKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAg
aW50IHI7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
