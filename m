Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B7C2BB55
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 10:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D73206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 10:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iznPUgW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D73206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF916E959;
	Wed, 15 Apr 2020 10:36:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE3E6E959
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 10:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCbfl2nMyHUR/q7p0nra+933siWHh6kRLR9PgHmmDF0X1yQbzD8gl/J70mlkf9mVhkyb2XZ+/90lbCiL6ZFUWM87efrtWPZQgYaPgqqeQl8Ui/0C+zCrzFu/PeIFpPhXbMT8iNomm2GWIDt9TDXnWhFQ1ifybb4BvFcY7aNumgXBxWuvONIxct8ZhEZO9qylNQk2wkCtKVxpMO4Px5OSZWNswF6qQSog6BihRiZpZI7OS/vUaJZU1qb64Bkhy95RMFHyYeiBD0abq6HMgkBnKacCUJKJEXtcAUzpYU6HrjrO2uwlQSWnQiaIbAVuCxwxnWa+8wErsswUd8NN6ZOX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c37YSc32IZGlKIZWjNNy8Y8LFnGbiLIeEp8vTcZP7Vw=;
 b=Qaw66zP6kTQnRQaZKC0CvcmoUJkZKNL/UmCIKy3ORAmVA+e9OJ0XijK5gSSw99VGXtY1qrQe1tVfNtki5agBC6MqDTsulG0gsg/WnkRtcWKaMlnK6v4lNnhWFq3COaEcetv6eXcCiTgH2qAmgGTeLypvGEz6BZkCc8i5ixDSRKIzbHCrTJTj2V+9Ypnq5EImJZIU+MFZvJUiMyBGpvdw5j7xd8e7NKyZUoXHF4oWLSwYmQ9lioaGi61YqckWeST81oJ2onZfWdIOfxCWGfiUX9Tza3UOmQYrcywvHTmhXFsbxRo6ECBWHrDhvD9VPRe7nD9Oeq14cQN8RlQ6ncKmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c37YSc32IZGlKIZWjNNy8Y8LFnGbiLIeEp8vTcZP7Vw=;
 b=iznPUgW5YpVEvWXDmK6aOJY8JD8aoNMGoNuhlNw1J29R/Xo9xzW0EEUlcEUVRkoJ3gZhLPEjDfwcUNvNUMv27kuoeHjJvNe/Z6gdr+/dku5G9EkDtdwx4/AkL4hckzCrlRZFkD+2uxs55fhed7A4JXfpg8Pgy5/x8uFKelZUpzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3451.namprd12.prod.outlook.com (2603:10b6:5:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 10:36:05 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 10:36:05 +0000
Subject: Re: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200414142217.5736-1-kent.russell@amd.com>
 <404ae73e-fb1c-bbcf-5037-4afbc2f66410@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2f1ac780-43b3-e58d-c45d-0dd69c2443f0@amd.com>
Date: Wed, 15 Apr 2020 12:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <404ae73e-fb1c-bbcf-5037-4afbc2f66410@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::16) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0075.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 10:36:03 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bb4d41d-610f-4a15-8d9c-08d7e128cce3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3451:|DM6PR12MB3451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3451EA7EEBE4C25EF41F92DA83DB0@DM6PR12MB3451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(81156014)(86362001)(31686004)(16526019)(110136005)(6486002)(2616005)(66476007)(6666004)(5660300002)(186003)(478600001)(8676002)(316002)(66556008)(36756003)(52116002)(31696002)(8936002)(66946007)(53546011)(2906002)(66574012);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmqTkshXw69AKGfUtADzEHWI2NU9SazPi7SEjYtX+Hjg5X/DSIg2w9ejTsAZDyxb7bsyNvwL8xYmv5otfJZ4fnqJUBLrU3HbiQGehtTa0btTK+OSuuOVLOvdvdnzB2C6Ze5NCvTfl1lEVrLOwlLwd4/wibRJ5u6qK6V2qpjlcq1NdKtle6P9UL9REUhF32xhrJqdi1yVT5WZZ8NvffoHMhg+LwaWoMFNPZrYeJ36gPxorY+PIMUzVZ9Mp1I1rvIAQWlO68Fzl94aFMfFMOtXHtvQrfOEd3ozeuwbMzo2gCzVh5LQmZ3ZUkT82FJJhLAJgR2awoLfxyVn45Z3r9Vf8E7j4qpbt5vk0eXVEkFLccKcJ97RNHwKvU3XsVq1JvdYKWaekVPkD70M2AqL119vUO3ZjOegQYxpaVgy9VMCrKQI+VaYkVrtst78lb1vheU0
X-MS-Exchange-AntiSpam-MessageData: 7gWbnYeBGCPNFbsiOfjpDGVyU8Ij75bfjCncZr4ifs9WQGENpI1T738V/eHD1YmSUgFNMok54g5kpkiVbih5Ia4f7Qu8IlIhFlbXksfTTo3MN4jZirVQcx9XpWROKCt/AZL12y1CDb4AaMpyv30w85xxK5QSVK9JJPBmwhZjEFtK6D75CjGADFiLZWYz0rPkESosEMrBwRKfopCzCYS2Ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4d41d-610f-4a15-8d9c-08d7e128cce3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 10:36:05.4584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGUAenjr+MH5gjr1JPaW0VFz+d5HV563iONpXXmBRcT8JNX2KZOnsj26J3ZYgGZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3451
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

U29ycnkgZm9yIHRoZSBob2xpZGF5L3ZhY2F0aW9uL0NPVklELTE5IGRlbGF5LiBJJ3ZlIGp1c3Qg
cHVzaGVkIHRoaXMgCnBhdGNoIGludG8gZHJtLW1pc2MtZml4ZXMuCgpJIGFzc3VtZSBpdCBhbHJl
YWR5IGxhbmRlZCBpbiBvdXIgaW50ZXJuYWwgYnJhbmNoZXM/CgpUaGFua3MsCkNocmlzdGlhbi4K
CkFtIDE0LjA0LjIwIHVtIDE2OjMzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4gUmV2aWV3
ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+Cj4g
QW5kcmV5Cj4KPiBPbiA0LzE0LzIwIDEwOjIyIEFNLCBLZW50IFJ1c3NlbGwgd3JvdGU6Cj4+IEZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4KPj4gV2Ug
YXJlIHJhY2luZyB0byBpbml0aWFsaXplIHNjaGVkLT50aHJlYWQgaGVyZSwganVzdCBhbHdheXMg
Y2hlY2sgdGhlCj4+IGN1cnJlbnQgdGhyZWFkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IFJldmlld2VkLWJ5OiBLZW50
IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMKPj4gaW5kZXggOGU3MzFlZDBkOWQ5Li4yZjMxOTEwMmFlOWYgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+IEBAIC02NzYsNyAr
Njc2LDcgQEAgZHJtX3NjaGVkX2dldF9jbGVhbnVwX2pvYihzdHJ1Y3QgCj4+IGRybV9ncHVfc2No
ZWR1bGVyICpzY2hlZCkKPj4gwqDCoMKgwqDCoMKgICovCj4+IMKgwqDCoMKgwqAgaWYgKChzY2hl
ZC0+dGltZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCAmJgo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgIWNhbmNlbF9kZWxheWVkX3dvcmsoJnNjaGVkLT53b3JrX3RkcikpIHx8Cj4+IC3CoMKgwqDC
oMKgwqDCoCBfX2t0aHJlYWRfc2hvdWxkX3Bhcmsoc2NoZWQtPnRocmVhZCkpCj4+ICvCoMKgwqDC
oMKgwqDCoCBrdGhyZWFkX3Nob3VsZF9wYXJrKCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gTlVMTDsKPj4gwqAgwqDCoMKgwqDCoCBzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2Nr
KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
