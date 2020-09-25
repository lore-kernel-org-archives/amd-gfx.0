Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4542FC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D4D21741
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EoDxqhdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D4D21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678226E02D;
	Fri, 25 Sep 2020 19:01:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6076E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 19:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBsR80EhEXhQmpfxJWyLM5wpVIGPvcYh08xU45eYfsaNGC75MBtV1HSCvU0yqYvQsZIBqcbHQD8hmnSchee47v7Cw+LH4jT4zsBVBFUqY4rBxBArupOT7OgVeQLX2goEClaL322cG+EAGCYAFQl7Hcetopx6aET6P2afk9UdLpVYDQIp3F47fRoLsrycFcjob7A+RsHYYZpXjRxA+ZHtyxCYYdV6NWsVfsHMmWWTGlZFQeb0SY4gWyZJcLQCjviuxEEiMSHbR+XWsSdiJgBvSca96WqrHlHAHMRiY7PXVjbHMfUXMsVUlqLfLsOpFvQp4MZVzXI/t/gTIiC6TH4Glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdET6bxffH5kH1PLpv9k3hLSu2BeVk7WF3Srmf6G9+w=;
 b=Vv9ZE0vXC/4nr6sppm9FcTu7+7RJzGGoOEZTX4I+z2TxEoXqPpFY3oEbXswUIQ4VTlZc3OpTaOtfhHoCfoZWnFjrXqdOX6mb+Yh7Jj+z1UYr+QgqqToKzVKMxEpsBJFCOnuOf/8+oDIx6XhXhd6jhNo0gIafqvTeCwzCDKAQkXzB2vz7QkB71vkUiVqrm51VSpQFg16tF/9zmKioNHQ6c0AnNlNr50ZQWEEeNLUCpeW+CuN9aNANfiP+1CJdl+6/sHQnkTfuKN5NCsEERylJhIznsG6KgX981nQx+i3X3Pot1gdcyYWssKxZfqyXzrpwqpAkDkv5Dvz088tAUn3WWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdET6bxffH5kH1PLpv9k3hLSu2BeVk7WF3Srmf6G9+w=;
 b=EoDxqhdPjjzKIwzT6cQe/PL5QMh4FcOjsRrIO/7ctCia/IhgwHCCbrknc8yKc0zOQ4Eo+Effj6VmPnl4a+HSsClUfCoPSlBtl4BzGGEpELu4FFLbheBGU6D5brI8xpFS4pMpg0qgbKfqC3fEO7g146ImSdFim+ta8nOxkP8C0OI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 19:01:14 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 19:01:13 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925143127.1588029-1-alexander.deucher@amd.com>
 <41d3580f-9267-308b-dcff-e2b828812348@amd.com>
 <990614f9-3a57-0a25-f672-5ffcf9e26989@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <8708b820-ea7b-c2a8-54a5-24e496d0a5e2@amd.com>
Date: Fri, 25 Sep 2020 21:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <990614f9-3a57-0a25-f672-5ffcf9e26989@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.126.213]
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.213) by
 AM3PR05CA0119.eurprd05.prod.outlook.com (2603:10a6:207:2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Fri, 25 Sep 2020 19:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f3f4c19-e900-4bba-9ea9-08d861855f94
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707C9DD25E356B139D300808B360@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bupgdvyEuTsK103FbN+zH3vFXpp18iJmkm4CYrhxYkNiMHajli3gHZc/cdUIwV2rraLmgWmWhbpvhIruIImhLc2Wqg3Oye8y/GYNRu9tltEhiVhhDCOUAT4WXS2TvFQnmzjoWBq8nduJQ2b9tLtS4dfPi5mt/dSQjWsoTYo49imhfLeNfjmZBsHuT4SPEOcRTLwr8jw2y8ua4jbGW7kQ9yp3EhDEDGO0wZIBNSZJX/mrO7BJCtjkTrOD6xJFa0oOcHXF29ikb49h4yuBthRDmYSlVI5lczX32rhQZ1An9i1dzBg/ncw0Y74qAnArcsbm4EirCK/3+rrHyensTm+t0JZPHHDaL1aVGOKdP5um7LDobcK2eJoggdNelNBxfS5Cb7hUJBLOGp5AX0EvvzFU5Ynxz6Z78HCDk/0JzVaqeKFnrDDzaWLTticWTbqXta3qp/Ga9mXCYPhIuORpqwh9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(26005)(52116002)(16526019)(8936002)(53546011)(16576012)(956004)(66476007)(2616005)(66556008)(6666004)(316002)(31696002)(110136005)(186003)(45080400002)(66946007)(5660300002)(6486002)(4326008)(966005)(36756003)(31686004)(2906002)(83380400001)(478600001)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aczsX+CebpU9nYPOzjqbsjapMYkKSw2e1NiQOzzrcAfhbn2jR34B62kCkVcMmLgAPss1rDw4JBtNwXA4sU3nri/ISTmsP+SO0/Gf/HhCDu7ltnT/d5Z5e80JPOCon9N80Funxdmcz1nV1SSNBkL91/3VAv3E4SnymcgD+mizChZrX1ENHR/TFkECSYTe8un1Hj14ArSEZVJHmwZxiRj5NozLm92byHZzOwG6qeW0edLE4ZlzXJ6yt1JboMYmhhlQowhL3ALfd8BoH1dl3hGKCkE7f2uAnIK92AM6jAvDRaw3ZlCeb3Zu45nYjZBEI75TSOp7EwqRrs2W5kOxHHOUNd6/qNc1bsOQ+lvGvpLna3uG6Ls4tRrRxNMBFG/M6E7rAelPYzAsuGebO09FhBk8fVqETObhhicL2e3G3LluP8eoMmYNSe+3g6yQYz2f4jaXj7hYHOeRhw3jg0pS3BofNDf/vdbgOgYVQJvG6KAOrbj/aOFonjZJb+VfibWlKDLwoLFxXOiTY+0mcoiJJQHHsEPKvaUQ3CBH+Dr3vEj8Fxf1e7w2H4a4tFoUnpHudhqwetwOwgTn9aFe1xyKU9yt8GcAUxMnazKrf1Tt7jzA2WQS7VLPqrN4FPzSN+XOEY/6lesVIaf6bGrNHwOLYA4w6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f4c19-e900-4bba-9ea9-08d861855f94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:01:13.7983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ7tzf1lt8uDSn7bzsxOsa8FvZsBW10YoAgh2wA17hepNxq0m7JS5k+biH5raqLJe7slQ0z1DCbS0H0xpN+i5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDkvMjUvMjAgNzozNiBQTSwgTHViZW4gVHVpa292IHdyb3RlOgo+IE9uIDIwMjAtMDktMjUg
MTE6MDAsIE5pcm1veSB3cm90ZToKPj4gQWNrZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNA
YW1kLmNvbT4KPj4KPj4gT24gOS8yNS8yMCA0OjMxIFBNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+
PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmM6IEluIGZ1bmN0aW9uIOKA
mGFtZGdwdV9yYXNfZnNfaW5pdOKAmToKPj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYzoxMjg0OjI6IHdhcm5pbmc6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiDigJhz
eXNmc19jcmVhdGVfZ3JvdXDigJksIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIHdhcm5fdW51c2Vk
X3Jlc3VsdCBbLVd1bnVzZWQtcmVzdWx0XQo+Pj4gICAgMTI4NCB8ICBzeXNmc19jcmVhdGVfZ3Jv
dXAoJmFkZXYtPmRldi0+a29iaiwgJmdyb3VwKTsKPj4+ICAgICAgICAgfCAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+PiAtLS0KPj4+Cj4+PiBE
byB3ZSBjYXJlIHdoZXRoZXIgdGhpcyBmYWlscyBvciBub3Q/Cj4+Cj4+IEkgdGhpbmsgd2Ugc2hv
dWxkLiBGYWlsdXJlIGluIHN5c2ZzX2NyZWF0ZV9ncm91cCgpIG1lYW5zIG1lbW9yeSBzdGFydmVk
Cj4+Cj4+IHN5c3RlbSBvciB3ZSBhcmUgZG9pbmcgc29tZXRoaW5nIGluIHRoZSBkcml2ZXIgY29k
ZS4KPj4KPj4gSU1PIGluIGJvdGggY2FzZXMsIHdlIHNob3VsZCBlcnJvciBvdXQuCj4gSSBkaXNh
Z3JlZS4gV2Ugc2hvdWxkIHRyeSB0byBicmluZyB1cCBhIGRpc3BsYXkgYXMgbXVjaCBhcyBwb3Nz
aWJsZS4KPiBzeXNmcyBmYWlsaW5nIHNob3VsZG4ndCBuZWNlc3NhcmlseSBicmluZyBkb3duIHRo
ZSBzeXN0ZW0uCj4gVGhlIHN5c3RlbSBzaG91bGQgYmUgYXMgcmVzaWxpZW50IGFzIHBvc3NpYmxl
IGFuZCB0cnkgdG8gc3Vydml2ZQo+IGFzIG11Y2ggYXMgcG9zc2libGUuCgoKVHJ1ZSwgdGhlcmUg
aXMgbm8gdXNlIG9mIHByaW50aW5nIGVycm9yIGlmIHdlIGNhbid0IHNlZSB0aGF0LgoKCkFsZXgs
CgoKV2Ugc2hvdWxkIHRoZW4gYXQgbGVhc3QgdGhyb3cgYSB3YXJuaW5nIGFuZCByZXR1cm4gdm9p
ZCBpbiAKYW1kZ3B1X3Jhc19mc19pbml0KCkuCgoKVGhhbmtzLAoKTmlybW95CgoKCj4KPiBJZiBp
bmRlZWQgd2UgaGFkIGhhZCBhIG1lbW9yeSBzdGFydmF0aW9uLCBvdGhlciB0aGluZ3Mgd291bGQg
ZmFpbCwKPiBiZWZvcmUgb3IgYWZ0ZXIgdGhpcyBzZXF1ZW5jZS4gQW5kIGlmIHRob3NlIHRoaW5n
cyBhcmUgdGVybWluYWwsCj4gd2hpY2ggc3lzZnMgaXMgbm90LCB0aGVuIGxldCB0aG9zZSBvdGhl
ciBlcnJvcnMsIHN1Y2ggYXMgbm8gbWVtb3J5Cj4gZm9yIEJPcywgYnJpbmcgdGhlIGRpc3BsYXkg
YnJpbmctdXAgZG93bi4KPgo+IFJlZ2FyZHMsCj4gTHViZW4KPgo+Cj4+Cj4+IE5pcm1veQo+Pgo+
Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArLS0tCj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+Pj4gaW5kZXggNDlkMTAz
MzBiZjY0Li42NzcyNDA0OWEwZmMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwo+Pj4gQEAgLTEyODEsOSArMTI4MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3Jhc19mc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gICAgCQlzeXNmc19i
aW5fYXR0cl9pbml0KGJpbl9hdHRyc1swXSk7Cj4+PiAgICAJfQo+Pj4gICAgCj4+PiAtCXN5c2Zz
X2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+Pj4gLQo+Pj4gLQlyZXR1
cm4gMDsKPj4+ICsJcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAm
Z3JvdXApOwo+Pj4gICAgfQo+Pj4gICAgCj4+PiAgICBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbHVi
ZW4udHVpa292JTQwYW1kLmNvbSU3Q2QzYTI5ZWIzMjIzYjRiNThmZjZiMDhkODYxNjNjOGE5JTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM2NjQyODU2MDI0
NTcxMiZhbXA7c2RhdGE9YllXamsyazhJZUVvbEcyd2NKTEE3SiUyQngyZCUyRk9TWE5JT3BMT2Jr
JTJGM2pTUSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
