Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77481C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AD161185
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AD161185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6EF6ECC3;
	Thu, 29 Apr 2021 08:22:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FC46ECC3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SheSSK4wiaKap/A8SrIMPWEaZrq3PbAwvN/4TmwixULVv+3S+M+QqhzxMfkgsC5givFx5LIyE94CqGYEDBVLFO59c5SpcQipGUtdfEEAzmpuCUToByfvRc58wGMfCIlAA7FTcUNo7jkqMr+7okXABMFVF0nxb8EGzmaJi0rZ568hq76ETEj40zRq0LZ+z2iZHKupNPgAyVBIuf3/poymaLxK7rm/QYJ16ls6TOoZh6y1Q+jBYr4Sdzdv7siDDl+umLAxeE24jg/b/3p7Pqoc0u3WBnn0P6dzsUDKHFPtMffx+fWofm0Y2JGQ/IpuqXR5rqoQGaULXnw57Zq1sRL0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0cXmak0v/1B2Q2Moa3kSCu19BuDde1LlfA3d8xhafs=;
 b=ccLkOGmgXg2KypcMpimDxcmm+gtuV1UqEF2aIDedAIMT1cmTcVjPv4Xg+PEjhXB6LPkyzT9XHq7ZNNyL/rUx+XcLEjtFW5i1Q6WwFY0ivXQ/erLDbn1p15Z09lTSXxiw3Eqn+b6b//uMY1Ya5V4LKZs/cSrxSWVTl7QGGl4A5U6o5JBteeVExAk1PFUdukXKknrhAOjANYDenh3zPBUlJrbGJ9O1YZhYfS/KnS2sIgMdGTZ9Yv9RJ362wURCHNlHBMXgXiTlFrXuskpgIt3b/rN5Pv3ysWX7jWbt3j4wJIyleIhGefoSqJvweUfqUwzGqEYy6NvdHZiRkFIh5dVq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0cXmak0v/1B2Q2Moa3kSCu19BuDde1LlfA3d8xhafs=;
 b=B7A7siquWCbx1zPaKAdTQ34OZhV1LnW64QP24vNeE9Pt+iLvls1kO9ExPKUJt5Yy5hx2euQQCUmQji512EGGkQzL1qM33Q7M2CLlRiUnXZn6UVnULRclnbUsDkAcuahlLmEzdK0FIYzMXE6HjHm4S2407gj/2VKlgAwAbGPjPQs=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:22:32 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:22:32 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini
Thread-Topic: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini
Thread-Index: AQHXPMCE/X2FC9VWHEOrECb/W9kI3qrLJqHQ
Date: Thu, 29 Apr 2021 08:22:31 +0000
Message-ID: <BL1PR12MB5350612990AAB35347E7B144ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-2-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-2-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:22:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4893c940-7ac0-4c27-b3a2-aa60c833101b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e651ca22-13c7-46e5-6203-08d90ae7ef80
x-ms-traffictypediagnostic: BL1PR12MB5048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5048599B55B3F240C7EB5BC8ED5F9@BL1PR12MB5048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppHcRkXaeKXQasLTPLQAp8bhQ74jQ1sBaFrOdMo7gF7xdHpAEPFnWy/rmQPwKRGrVLLJl23CfbZfF9ztVftU6FJ6pUCCc9Rq+OWojjvkf7uWnRId23eYqQ2WipxKmBFQXOpHIN/JwlizxZFwUEWSOdVIElKCrf0pNFQxgeiMdW4Vr4JGBU+3y4YLtENZyp/ZA63dwoefZcaT+OKwSz44+jfL9uIUEa7DVcaQWIOXpdr/RYTQXiouJaiG2GOv8s/gX46BNDb6ptBE8sG6k9QqSWxhL7QzES7EDwwQmD48SekAqvMTBNb/45325mjNyGVtLq1eeZlWKNRZAQqQXgOWZPtEK4cQBYC6ba/taCLPnYI4wPLLG+oXhD5xEOvoOWCgTgHDmkiqJlVGfCFjuvFjFQRkytDwJ5kEupH97o1VAnsoKRyHxA99VrHu2SFRyqjAW9KmOzExu5o4ttATV/3Y+xc3QPXdx7SmZ5I9j5N5xKTByC8Uxh3x6KIacdgW7tqUDwoJeKbY1k5R5T4vQDbI+MaHBABwDKa0xYXoYV+sGAWCT+RrDM47uPvTzHtXP50+xO4Em9CB24HoKcJtWNGolW5vMd1Dg13k865rO2hioNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(9686003)(64756008)(7696005)(110136005)(186003)(316002)(26005)(66446008)(478600001)(33656002)(86362001)(38100700002)(8676002)(66556008)(66946007)(55016002)(53546011)(5660300002)(66476007)(8936002)(83380400001)(4326008)(76116006)(122000001)(2906002)(6506007)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?b1N0dnFHTWtVOTRyZHowU0gyMjY2N0psREFWTVA0Zm55SGRxdWN5YmFRY0NB?=
 =?utf-8?B?T3dWbmJ4T2srZnNsaUlJSzd5ei9iVlJqU3pvN3ZwNzRWSXR0K0F5UjVXL0dM?=
 =?utf-8?B?WlNOeFBmS3F5MjNDK3p1TVRKN0VjMURsOVpzejA0VmpBd0Rtd2lUbmgwdVA0?=
 =?utf-8?B?dlVFTjNQRC9vVW9jMXZ6YVNaUnE4OUpDdTVNZjRQT1M2c3lPaVJLQ29CeEtl?=
 =?utf-8?B?N1pwN0NxRE5nOE40WUxNQmN0WDFrTVd5VXhxTC9Yc3ZIMVlUYzYwMjA3QW5h?=
 =?utf-8?B?SVpMaHhIWU1QczFyZHRGRVFCbkIxUElBSHNFSjFJekp4dVVnNVg0SEt2Qzhz?=
 =?utf-8?B?SFBvTmpJZWwzRWFhc3hpZUhEVW96dnJ3RG4ydXlnR1BZSGFFdlZYeWVrdEJm?=
 =?utf-8?B?TUFDT29sT2xBMFNsSzZsZDVUQWNXUTNSY1lXRCt0NUp0dDZucWMrNkk2VzdW?=
 =?utf-8?B?bUZTVFRqditKZWZZT0hpWFJxYWd1RGVQd0oxNWVROUR1TkNUaUdiUnpiOVNx?=
 =?utf-8?B?N1RGRTRmd1VsQjcxa2VhYTlpN000UEdFcEwvRTBlMFVaaVEwSUZaRmVMRGlS?=
 =?utf-8?B?TE1Ca0c4VlFUWmgzajhyV0RJTmlNcDJpOTBXak15djcwdEg1OXF5d2NMRFBV?=
 =?utf-8?B?MHpNVjV4b1RNdUFjUTlTQUNxZUxIZkFUTTJtNWxIcW44cDRWWUY3MHBFdUpH?=
 =?utf-8?B?cE9yaFdxYVRVSkp4RmdlSEVBbFRCblA4aUNZSjlqdlFFWW5OVGV3OGFmbFo2?=
 =?utf-8?B?NzVKTFdmSTBXV01EMW5ZaEtyTWtvZGRHa1cwYnp5dXZHaGphSkJNYXRxcWY0?=
 =?utf-8?B?b3ZiK3VhblVFMHVwc1pvUWxUQm1nc0NVVUhCWDlHd250b1ZaRDRPc2pHNTBT?=
 =?utf-8?B?ZW1MTjNSYmtHTTJoK2x4a0pveEpPWkZzZ01EbCtkdWQvTGhiSTBMT1l3NVEv?=
 =?utf-8?B?NFJrMnNqcVNqTnUyTUdhVXJBUFR6eVBINHJzV2J6WEJ3ZTIzbXE2NUFMS01x?=
 =?utf-8?B?ZXkrVmErbEhWc0FPZmJabGFJYWpCa20wZFNwWDRqcFJMVVA3R1orTVNUcVRV?=
 =?utf-8?B?ZnNtZXZqMkJwWk9zNWt2cjd0VlJMWGxZUHc1Y0pBVmczbXR5UGVweEJNYTkz?=
 =?utf-8?B?UkhPcFB3dDZsN0x6RElyZ2o0UkhMUk9ydk1XNGtHNEptK3NVTUFVckJRZXo5?=
 =?utf-8?B?NzNnQkVkNElHYi9EdnJWcVpGdjh6WWt3NFpPaDhQSGVYMjlrczhiRzF0UEMv?=
 =?utf-8?B?dzNlSGtGTUdOWElLTXBlcFlBRi9zRUxVdFhDTDVFOUNzTml6QWpjRFBMVWFw?=
 =?utf-8?B?M1F2OTBQeWNNakxMZXNCVXdzWWUzOHoxVXZzc1hGb290NlpTL1FLQUkxL2Yv?=
 =?utf-8?B?bXBZdVY3OUh6NVdKRHh1b1hFM0QrbUtHL1NjMWpGbXY4bVkyRUZwOU5TbGwz?=
 =?utf-8?B?d1R0akdwUzhWSGN6V1dtN0Z0b3BjZTI5YkZBUHB6NWp2Q3FjczRmM1RZcXJF?=
 =?utf-8?B?YUFKdVpLUllnQ0k0MVQzMjhQWFFPalBJR2JPd0w1RkJDV08xTjVjK0ovRVgr?=
 =?utf-8?B?NmJxRFF6S0xIM2cxY0o1ZmVSdzBXWTJmQ0twbEZNUU1sRUVOdGhFaitMWDRi?=
 =?utf-8?B?UENHaE9DKzJLY3MwcGV5dTJoRVFGeCtlK1I4bVBKajlaMDQyT05sR21PTGQy?=
 =?utf-8?B?cklHUDJsNExUc0ZQSkZBV1VkTUNHcUFheC8wQ2hxU1F4UFlFN2JsMzNzREI4?=
 =?utf-8?Q?a5OFKbU6HWL90rdxUkFyxZoDmVxCSADzrN7PBLi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e651ca22-13c7-46e5-6203-08d90ae7ef80
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:22:31.9585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVXl4YfzT+fE6IVwCpYZYHZViIIpz5PFBUGWMMUs1YZnMSPIcIft73opfaqlQ6LV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>>+	r = amdgpu_ras_late_init(adev, adev->hdp.ras_if,
>>+				 &fs_info, &ih_info);
>>+	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
>>+		kfree(adev->hdp.ras_if);
>>+		adev->hdp.ras_if = NULL;
>>+	}

It is better to move amdgpu_ras_is_supported more early, to avoid redundant memory allocation when HDP doesn't support RAS. Except  this, it looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini

hdp ras init/fini are common functions that can be shared among hdp generations

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 69 +++++++++++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 +
 3 files changed, 72 insertions(+), 1 deletion(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee85e8a..418e674 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -56,7 +56,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
new file mode 100644
index 0000000..1d50d53
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev) {
+	int r;
+	struct ras_ih_if ih_info = {
+		.cb = NULL,
+	};
+	struct ras_fs_if fs_info = {
+		.sysfs_name = "hdp_err_count",
+	};
+
+	if (!adev->hdp.ras_if) {
+		adev->hdp.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
+		if (!adev->hdp.ras_if)
+			return -ENOMEM;
+		adev->hdp.ras_if->block = AMDGPU_RAS_BLOCK__HDP;
+		adev->hdp.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->hdp.ras_if->sub_block_index = 0;
+		strcpy(adev->hdp.ras_if->name, "hdp");
+	}
+	ih_info.head = fs_info.head = *adev->hdp.ras_if;
+	r = amdgpu_ras_late_init(adev, adev->hdp.ras_if,
+				 &fs_info, &ih_info);
+	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
+		kfree(adev->hdp.ras_if);
+		adev->hdp.ras_if = NULL;
+	}

It is better to move amdgpu_ras_is_supported more early, to avoid redundant memory allocation when HDP doesn't support RAS. 

+
+	return r;
+}
+
+void amdgpu_hdp_ras_fini(struct amdgpu_device *adev) {
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
+	    adev->hdp.ras_if) {
+		struct ras_common_if *ras_if = adev->hdp.ras_if;
+		struct ras_ih_if ih_info = {
+			.cb = NULL,
+		};
+
+		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
+		kfree(ras_if);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index c89cf8d..ba6f272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -47,4 +47,6 @@ struct amdgpu_hdp {
 	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
 };
 
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev); void 
+amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
