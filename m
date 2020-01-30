Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E03C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0615820707
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lwf0af04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0615820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32B589FEC;
	Thu, 30 Jan 2020 22:11:47 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9139E89FEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk7Vik/JhGKhRuGhp1Lc92ELW+LWuShZLW7vZXFzpLuzPM0SpW/tnLe3oUL82MPJLkBeHZOj5NEW69dvR5qwuOV4NlYrGPKmd43xbJmhKXw3MAYdAp6pbTmUnlqBDen/pTa8AR31dofC+zRJFrPjGolNgoDRPj1Meh3pa8HOihmuC4uYoLxkVc2DGRI9xKVbV0CKHxJVstiF6J4RXwjBOu8mSqRSP5qDFYCJYro4Al4AVIsuvshoHFA/0/Kk9NYMR6zDHU3cDC11a8X8QRjQQjO+gl4wvSvDY9vuMw80RjKWRc4Jyw6RSV9VAu3RQCmFgeleaC81kLiRT6S/iPHhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fhawSyHrxStgU9lqPwBFWnoFfQw71i5gvE5L49AsUk=;
 b=hqB8WDz58a39AbosfltJXaK36jaSSZPhQg15vuffm9jDJtzmRO/Hk+t3Yrt/4Fa8D/RU/jpE1adpH66Df2dcVCIOwA2TnvY1yRut6/KDcXewkIuq0CVgHvFRwnvoBP9LVDUtWWyd5TX/SDJb4mnHug2Yz1QfRIcSTdjx6ScdYSAPMarKMpz9IcvhrV8V7PEjvq/rqF0LqOCIe23Wm/r/TBcPORegedUDrLGPjbLb3cfp/qLxEzIpiNKpCTVf3uJtj4DJTd92/sOVE5s58QXytS34OO+UlmH5pU5KADc7x84zWw5cJIyyL7ri61sEAHKQS78lW66Zn7sfxhVw1oFGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fhawSyHrxStgU9lqPwBFWnoFfQw71i5gvE5L49AsUk=;
 b=lwf0af04L72XHOYNo2cwbuzD8xcv5XGaGLDHnfw/2uY4b2copgZHnf+sV7yYLiel/49wmNL6el0cPe3+2uEE0lVyDUH36+GdVvqh2VGkqJiDMYUAEwKvl6thU/VTwhaxvw3xTgt+ityGKFbVKUV2yRJooZ8P5eHmgGSNhnpCnys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com (10.174.255.8) by
 MWHPR1201MB2477.namprd12.prod.outlook.com (10.172.99.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 22:11:44 +0000
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707]) by MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707%11]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 22:11:44 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: fix braces in amdgpu_vm_update_ptes
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200130124940.30380-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <43ecd5a5-6087-0cb6-4ba0-adf0d4b3ac07@amd.com>
Date: Thu, 30 Jan 2020 17:11:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200130124940.30380-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MWHPR1201MB0095.namprd12.prod.outlook.com
 (2603:10b6:301:4e::8)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Thu, 30 Jan 2020 22:11:43 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83adff77-bcfb-4990-c8bf-08d7a5d163f4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2477ADCE43B51EF86B614D6492040@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(66476007)(66556008)(66946007)(86362001)(66574012)(6486002)(26005)(956004)(316002)(52116002)(5660300002)(53546011)(478600001)(2616005)(2906002)(16576012)(8676002)(31686004)(31696002)(36756003)(16526019)(8936002)(186003)(44832011)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB2477;
 H:MWHPR1201MB0095.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWDtcShFIbFnnzMy9IpeTJ0DRZILxZxKLKzlrdzRNIKSDcxLT6qWQWdu1/1T6Pw5g1RL5yVO+clzXGqUb9+528Q/s+szoynMbpn6/9t4aNyNU9xJTz9NQmsPABrCVvyeUJm3+lYh5F8RCK322HMY2fx+S5GYE7aamZzkxqdhhe7YmTGRN5aZz03Aqc5ZXbHm1vA/8aB4zbbtlZLz81lafhDnzgpmj8YCqoU9a5aGrqLh2a18gzQEUD6HZt5L1prYy/+JxrDesV2F56cZNDrA8pKGvpxUSB+8j9tYQgv5NPy9rYJPycSySh7ZInnwZ74TESEoCr2RURnWGKovd9lAH2TvzN2EtEKBECO0CKdufypgeTgwtnFxPUnN9N9uwKVUzmjcnGMu9cnIPcVY7z31i1R0x/aeEiyLiRhbLdQmeLNI42jhtTLSy2hV8Iv+jqWO
X-MS-Exchange-AntiSpam-MessageData: r2QUbwwKHAbXEH2EsoqZrIPenC2j02HIXOShjFv/LVcX/P031H1gjenx6WdwnEWX3+JgCsQXrdbeIsHMorKY/8C0AdmJ/Z1JoXZ2BSQ5WtoQROGe++L0HBdNj3krafO3fUx1nG+zbpodWjuOH/rjGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83adff77-bcfb-4990-c8bf-08d7a5d163f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:11:44.3877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRDGglDF2UvPBSQc9BakixuSUGxx9KbbCUWP3tW7lHg9/XixwjUjo5CNKXHee/KiXh8ZZ13COjjaUn+QyPxoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDEtMzAgNzo0OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBGb3IgdGhlIHJv
b3QgUEQgbWFzayBjYW4gYmUgMHhmZmZmZmZmZiBhcyB3ZWxsIHdoaWNoIHdvdWxkCj4gb3ZlcnJ1
biB0byAwIGlmIHdlIGRvbid0IGNhc3QgaXQgYmVmb3JlIHdlIGFkZCBvbmUuCllvdSdyZSBmaXhp
bmcgcGFyZW50aGVzZXMsIG5vdCBicmFjZXMuCgpQYXJlbnRoZXNlczogKCkKQnJhY2tldHM6IFtd
CkJyYWNlczoge30KCldpdGggdGhlIHRpdGxlIGZpeGVkLCB0aGlzIHBhdGNoIGlzCgpSZXZpZXdl
ZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cgo+Cj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFRl
c3RlZC1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNWNiMTgyMjMxZjVkLi40YmE2YTVlNWQwOTQgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xNDg3LDcgKzE0
ODcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3Zt
X3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJaW5jciA9ICh1aW50NjRfdClBTURHUFVfR1BV
X1BBR0VfU0laRSA8PCBzaGlmdDsKPiAgIAkJbWFzayA9IGFtZGdwdV92bV9lbnRyaWVzX21hc2so
YWRldiwgY3Vyc29yLmxldmVsKTsKPiAgIAkJcGVfc3RhcnQgPSAoKGN1cnNvci5wZm4gPj4gc2hp
ZnQpICYgbWFzaykgKiA4Owo+IC0JCWVudHJ5X2VuZCA9ICh1aW50NjRfdCkobWFzayArIDEpIDw8
IHNoaWZ0Owo+ICsJCWVudHJ5X2VuZCA9ICgodWludDY0X3QpbWFzayArIDEpIDw8IHNoaWZ0Owo+
ICAgCQllbnRyeV9lbmQgKz0gY3Vyc29yLnBmbiAmIH4oZW50cnlfZW5kIC0gMSk7Cj4gICAJCWVu
dHJ5X2VuZCA9IG1pbihlbnRyeV9lbmQsIGVuZCk7Cj4gICAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
