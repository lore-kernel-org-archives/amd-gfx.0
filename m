Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F397C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 12:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFC9613F0
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 12:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFC9613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E7C6EE85;
	Thu, 29 Apr 2021 12:24:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8536EE8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 12:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OauKfEwjL/9N9j1743dSCJt2pzFkv0gUEea4Cma7of0YTOYdKUn6IDD/Z5dnvu52c5RRcO5dKD5QJ1OwOXX94gMiqtydidiHuLJFlWUqFvUqJ6hEeqtjN+sEzTBrVx79ThdGayEh6ptLwmoMBeurRKP4gm2MP+SO4mbBwWMocxENQNJWsdHh9nxScgoPdG3XIkXFnNg44L5kyPrSD6tSSZdC2ht4uTMcjns3zIY5u4dnYp3sP5DwwP/P1tcXgtFXs0T58XhNuC/O27W1HquSpQYlAAQMt3lMRf7pkzvA24cbG2AYKYyWfZ5r/BeXRoB8uRy7QTxCgbsiJuANDUVR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pc5/BjMSDNZgNk2AJ2mPU5QHc/gl1aEYwO78tXwW+w=;
 b=QsVE1JjaCtEf7TFoOekkGiE+dgA3M2GFYKh+JCpEA/eFeIxXKg01S4P5+oDcE0ID4RzKIsY/2iKwsyF84lZGNddHsCqaUZTSH8BPi/tUYDmCYFot+SJBsAIPl/sKcX3yeLdiWGN2QTFgpcF1lymxOuSY7sdAl99CprirXlM0vjI8wG7zu9/pQ96PhE8Qf5VvWR6tz4LQnjXs6LSVxvQaIYf28AcF0UmpAU8+oyyhzJtAXB8PuqmqhQhBfn+zxPG6kZgqmNg0fKLFJeXfEq9wliYTZda/2IuKiX1JKvytwNztjhldOS/LtlIRFtwVWEH6dNaYL3bTSyesUxjO8/wVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pc5/BjMSDNZgNk2AJ2mPU5QHc/gl1aEYwO78tXwW+w=;
 b=BDe0GIx82Jge8JNlhsrA99+1jZvlR7Lex2o8O0Cha9mBpmt9zolOdayB7fxfKZ5xlp+onTY6Vw5nDJuOsEkd+DYeUayOByE2SmEwg/VEBUwCff7nE1wU6PpXKP1jpTtLYtNZgan53gP2niELsIseG9bco2/mStmm5Nn4pfvp7/A=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 29 Apr
 2021 12:24:10 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 12:24:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini
Thread-Topic: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini
Thread-Index: AQHXPMCEgEpB0zD1FEGjAGaV4wp5kKrLKBeAgABA+ZA=
Date: Thu, 29 Apr 2021 12:24:10 +0000
Message-ID: <BN9PR12MB53685BC8B770ADF580BA13FCFC5F9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-2-git-send-email-Hawking.Zhang@amd.com>
 <BL1PR12MB5350612990AAB35347E7B144ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5350612990AAB35347E7B144ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-29T12:24:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=49a74e87-fe15-41cd-b0ee-3ada1fbf11e1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2992462-05a9-453b-fe49-08d90b09b142
x-ms-traffictypediagnostic: BN9PR12MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB520922AF471DE3BF8A8EC168FC5F9@BN9PR12MB5209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7tujQpozbQTHryEFjiWtIRZYgCVzdnHI/oGu0VvxkqzVdBW2TD96mGE7QMePJ22wJVusCjqVkTTW1w2UKtx83jlZiTDu9ldd/zF4wRqmLBOqS5o8VFAGg3ScVESo+SXE4AOUbXOPZLKgAX9jmitSw4uKwPpICrhWYGyfg6yXY4dmEAYk2hjxTsixsiV7alwLnSXD1XDFLjcN7sW+Os3XRNweMYATOIoheO0qLTBlgIt1XLpN5+t3WWU4YaaczsJjJoJ4D6skLqc4e7dC9pI6X7rBhDsgTCKRF5Es4ngi5t/0HP4h6QtvWHJUvt0ZFy2OU2gFIHURmz1rC+0l+mM5L+mc00n/V0RkobylQa42gmhE0Hj30sCoWLigfr0bh9i6AMZalUzLxYOX8u8fSKIfyKUTxqm4mIyVrSjmeBHA4B29Z1eQgLNzyTMZ3ur8TUAgZiJcplTLnnjiTVwrHzExSC6HZVJ3B8/S5h0u5yUnsw6jKNukyvhxSXCy744YiJlnWl9LOQRJD9HFzgPUGnw5CTXkuataiG/7Fc0kJeyGHZ3vKY2tjHM7Cg9Oc9q8VviS16ppI/nag4zE4bDI8dCf/zMd4a1R4bCkrd6U8HOeMQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(55016002)(7696005)(53546011)(9686003)(110136005)(5660300002)(6506007)(2906002)(316002)(478600001)(8936002)(86362001)(26005)(33656002)(8676002)(186003)(83380400001)(64756008)(52536014)(66556008)(66476007)(66946007)(71200400001)(38100700002)(122000001)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MVE4OHdDdFNpbFlEeG1sbHdFLzFXZTI0VndJK2V1WDgrU1IxL2srd0lZSmpl?=
 =?utf-8?B?N253R1ZGV0dmSjYrY01IZWU0d3VLRG5qcmVyaTJnSlpDWHo2Z0R4L3F1SGw3?=
 =?utf-8?B?T2dnelEwcTZFQllRSndYVlAxMGFVYllVU0lZdjBkbEFkMlErQWhtVTNoRG1G?=
 =?utf-8?B?NzgwTTlLRzlXZS9KZFo0Y3dRRlVkMU5VSkJyWUdweFI3LzNPQUlacnVZN3BS?=
 =?utf-8?B?V3o4a1VzanNVY1QxTEtYZUY4Mm5BWWFUYy9mVVFvWjE4bm5XVnMraVZkL0dQ?=
 =?utf-8?B?elRzZHVRSVhsT3k4aFJYTDJreDVhU1U1cjlvZW1nbkdVOXVXTTM4YXZHVGw5?=
 =?utf-8?B?TTl1WElqTnBKeVRWUTdUaVBDbFVOZ1c1Q3REdW9WZUxESWVYaU1rVWNXTkpQ?=
 =?utf-8?B?Wkd4S0d6M2xSL1dZZGw5TmZuMy9WVGpPSHBxY25ReGlhaUJGTTFOcUkwcG9T?=
 =?utf-8?B?WXZIUi9PQzVOaTUyVWlKNFRZRElqT2RKT2lDNFR3TDNhVDdXL1d5YjF3ZUF1?=
 =?utf-8?B?TXlxeVIrV21tZlRYbGdvR21qZnQ1ZlJHQXVPZ1A0L1ZSWDFyQm42VWFSY09Y?=
 =?utf-8?B?dHFCeEp1ZVRzMVk3SHVtUEFrWCtIWGVzRG0reDFBNU01SnNXSDVJTkp1dldr?=
 =?utf-8?B?NkNTMERuVUQ0c3NnV2U3dDBCUWdjQTRyZnRaZEliT25MQTJqb252Ry9nMDI1?=
 =?utf-8?B?bnRJSVZuc3QxMVUzVXlSQkd5bXhWTS84Q2JwRzBqditEcnl5YmRoL3JXYWNa?=
 =?utf-8?B?bkRKSlFmOUIzNXdpUHF0dXd3NkZhc0l2Wm5PUlRKNW1ybkdNeEhnaWJsank0?=
 =?utf-8?B?M3FCYTBiTzFpamNPQmRMbkZxcmpCTE02Y0dTR3ZsSmdOM1pzQm1Sdnd1ekF2?=
 =?utf-8?B?UlU4ZDF1L25PaEhoZ2ZscG5JWjJMWVZTRGJZZFFDdWJ4aTVZWjl1ejdhTCtX?=
 =?utf-8?B?Q2tueDJvVC9FR1pqMGI4eGJ1NVVZSXhSTElBT24ySlFFTlc1aUFxV05nOUxX?=
 =?utf-8?B?aGgrb2kya1pyWE9LbzBjWU8wZ2xNTnE3MXZFazBWY1NXVllWUkNUNHVpb0NX?=
 =?utf-8?B?RUFWWFAvM2RiYUkzT1FBbUxvM2VFbGZuU0JWam44VXBBd3dqMVQ3bE9GSUhl?=
 =?utf-8?B?MmpRN3BsbTJvN3dJZWszaEVaSitzVTJqR3ZTU3NxV1d0SXUrUUVTVWFVb1Bj?=
 =?utf-8?B?UkVoeTY1ekNCWnVBYzI4ZnF1YVhiR3FCV2JIZFNiSFNqWmM0MXVsay9HazJB?=
 =?utf-8?B?enhEQlB0N3phNG9JTW1OcFlIa0JnZmxJdHV3WlhvL1ptdzlTWFFDMm1xclJW?=
 =?utf-8?B?d0ljRUQzTzI5QksyaEFaMmIvei9QdUcyWU9qSkxvaklNT0dWalp1L3dQZWhX?=
 =?utf-8?B?ZXF6RTJmOHQxSStpNFB3TDBUcTE1RGJFU0ZOaXYybWYxOHlIaTVZNUNySTNo?=
 =?utf-8?B?YjRwcW5hV3hYL0NQQUJGaEVIdW9UdndBLzg1NHRGVTBzVWhNdUczTXVnTnJp?=
 =?utf-8?B?akxoc0ZOdTk0UUdCOVp3a2dKZ0hxZEVNUmJiTGl3ZnZ0MWZqc1hMRDYwNlgz?=
 =?utf-8?B?RFFVZmRsQ0hZRUZlNE5qZWZ3dFFVSitRV0ZUMHJWanAvTnYrN2hjT04zUjBZ?=
 =?utf-8?B?MnFOaU4rWlg4NzRaZXROMkxJUzFRaUNvZGxtWTQ3OUJQRFBSYi9GNTBIMDZN?=
 =?utf-8?B?aTUzTWd6a2U1VnZrMkcraVU2ckw4anVLTjVwOGhTZ2F4VXVpQzNod3pYbFYv?=
 =?utf-8?Q?aZ7tSMTLZUlsoyWyt318PqMWiVu3svyBvdCice8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2992462-05a9-453b-fe49-08d90b09b142
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 12:24:10.4054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbvAjoVZkVNkB8nOiFQovf64wNipd+HA1Nu6ayY7xM1kkiSW6HVY+61N2rGJ+zMMta22i0BZHIEMmY64KA7NjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Dennis,

The memory allocation for ras_if is needed even the block mask is not set, because kernel need to issue disable_feature command to RAS TA in amdgpu_ras_late_init. e.g. to set GFX EDC mode to bypass mode. 

Regards,
Hawking

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Thursday, April 29, 2021 16:23
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini

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
