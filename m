Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B8C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 10:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AA12076E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 10:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FA089C09;
	Wed, 27 Jan 2021 10:01:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF79D89BAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 10:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmXpGUOb5IrqTjRGG70UgG2S0Zj5XjEpMxmbzqBYThFqaPlQYrlb6mEShYjn8JIIs+zMt8VJbH/YcLS3Yi85kBRGkYM90ul8SWU1TdQDIhxhwv6pfhhbcevVv32VDfyOB1Q+m3DggBszn98M1XohezMm+SvNs456685SKglJGCukalwWreWSslPJ/XfUgcv8nafHyTaPC8w5UBYEXrvtm6RdtQ81eLW9ExDzUuLOAzDjC/CkX3jJBjmdaB6epABgPDOE1RQv8tx4Wh58cDRgQgPvDnGqPlm94Xujq6pAydCdnyfkMxSbJI8eAjo7ZLD1QCTIAJgIVLng0IGrQvvnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQVPC/RF4vvNmcbQa6k3lF+opV/6nClP+A5+DVlP/5g=;
 b=ltj2r26TFrmwNOpbDdPHOkfGFtyQiKvWUCxBZ7wQ0wvz6noKlD03ZrfANqd0n5ncUe8sGl0ZcnIQtIQadVeWdiel8O7ch2sRYm+ExrjkcWPkXjOZtn6VIUshGPmj+EvF6LBLYdIn2zZcXB9H+HyDnksy3q51y9+BpqVUqC7fpRh+w3Xv/3G16ztno46Cb5iIp7KtB2TZP+QX9YN5hhb2AHBUoyl+kiVl2X+wq+G2u29or/mbkJTN8F+igYS+XmmTQFk2vtnRpnab6lTx8PeIoHf9GYHw8wYV0tKP2QpLDlB49/MxvABIAc+6X8teXpmgz+v7Rv0DfVckzJpzWAsnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQVPC/RF4vvNmcbQa6k3lF+opV/6nClP+A5+DVlP/5g=;
 b=hNjEn0OOGUEzKD44/9hI/jEpoOcj2TTJ6tWeJk+22uXzJCcElpCr219O30+4+91oCMkqJ+kjYTTbw2NJo3mE2qn1bWDWBagZ0/1v8MOprXCaGlUj01kzTf5Kvcpu2piK10GmfkxArpFrGTHS0hPx7bFARHXG0qYryWz5WcXxcJM=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 10:01:52 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 10:01:52 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9ITZljdToPh2c0eymjf5lIJVS6o7POVQ
Date: Wed, 27 Jan 2021 10:01:52 +0000
Message-ID: <MN2PR12MB454931CA99FE2C11C818EBB397BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210127081648.28759-1-kenneth.feng@amd.com>
In-Reply-To: <20210127081648.28759-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T10:01:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=052e8533-e2f2-4877-b73d-44264c50793a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.208.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61af219c-a781-4e26-1020-08d8c2aa9247
x-ms-traffictypediagnostic: MN2PR12MB4520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB452048D853836C096D54100597BB9@MN2PR12MB4520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkl1Aneo6MPB7VNMHr5aW92HmqRjq3CQXK/ig4sa/7izmw4D7IEHpJBsGrZWlKm+dq2Zj6LFTC74cxN55faIWM4AtRrfbXCltgsJYSqc+UEeT7tCpH5DTZagtM4S0a/eWj+iEGTT64CiVVTJr1B5nEXVjuKlQy+8MdkhnZsls/HkOGkeCbtKDU7Ak68bNNcuKCpFrVNaCvy/ZIqeeSFAL/3DiJ4s70uVwoDMGJwtB9BPowI5AIeSMaJ34KjjOSIdIJ5B0ns9oHE+XLmdsHajm/aWYCsaFRb1dqI6SOFtFvvdmj+ovIPSxQ1VEUbkV/H6btkPiBpz/yEfRfnQV0Tjf8yEYzXSYOcKBe5biV+UC1ocMx5R57eHsFyCD8YnxKnze8kogCjxxzBNw7gBm6DzTl5bzdsz/Ptj7GrKyZ2MKrndiUd8Ap2K2abqctdMWU97/xurwB9B89F1a9Z89/GjVuyP8UTnDoXGyqgr3SVsIuO8P4ldD990x/xCNpuMqcqcvJYH77JmhE28+b6Il3K3I6fMiP1NxnCO7d5quDP1WMFPHTlONro+EGeA55I+Yw8B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(52536014)(83380400001)(66556008)(66476007)(66946007)(76116006)(45080400002)(478600001)(5660300002)(66446008)(8676002)(33656002)(966005)(64756008)(2906002)(8936002)(86362001)(55016002)(7696005)(186003)(9686003)(6506007)(53546011)(110136005)(55236004)(26005)(54906003)(71200400001)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N711yDeHcMF10T2lVcdA8dVJQh8Br3/zCbvZ98dIlQ2J77SlXKKVtI3nnEIO?=
 =?us-ascii?Q?ZMgWG+MebsftWRM9T75J07yY2vefJEI0U2uKDVHhmuLwPh5cWNCjA2sS00pl?=
 =?us-ascii?Q?eNSya5k7W2l4A8PTARsCYZ2s+ENmOd2KhT5xR6FyayrcA9CcUZmviw5hCIr1?=
 =?us-ascii?Q?i50JDn0o/MZ03A1LRVBC26wsU9vKN78g46dNy2t8t+OG+Ys+fem/WuYxIiJC?=
 =?us-ascii?Q?Y/mXOZ/GeaOhLS7Fqc/9rcNbR8ErBFZPAL6oMkyff/tZHHZvQQrzJKjO8Nfp?=
 =?us-ascii?Q?5RPiYIy7S6rkgsihrhbecl9xU6I69A83yqDpww+KJScOeqcLnwvxzKnSo7lG?=
 =?us-ascii?Q?sBmBXUQDa6gBZqI6rAFSKjIBQGGfY6bdw04MA0Nb+ehFU11JmZEEkZzOFqy5?=
 =?us-ascii?Q?I+q7TEC0gMZyhlHtQah5W3bDozjU2q/sBUGnwa5hlgOA2jtugfmOQ02OGON0?=
 =?us-ascii?Q?ucI7EYeKjZvKd9DK51gRBPO5rUkhTcka8eQ9MtEtTHr3/hr+vdKvZBIn5xG7?=
 =?us-ascii?Q?zb291TZ+DFXMkMeVedHtZjMyRJq+s2Dh0tAT727I/5z0e475Ci/oGbcwUsfZ?=
 =?us-ascii?Q?TAgPvmLa5mh6mERvPXS+vK20X3r34xPa3h0KsTfqTq47sx29vgoZQ3llJdEc?=
 =?us-ascii?Q?ouw6wAwPeThRU2SaStQBlu1mtd0sS0nmwgEGYpeuzssMKECUTomWgJ4nsxXe?=
 =?us-ascii?Q?sCjKuSPCC5FqMjtpJu41m6V2zyfX009qSAj6KUIe3AGCGIjkh0kylxvMnXFS?=
 =?us-ascii?Q?GNo0zaoyPTAiWZucovU0YIDGXy8S3orOB11I+IpHruzkNO3cZF63t0WWvY/v?=
 =?us-ascii?Q?7W5KHPhCIy/TrVSwKbjQ0c/0tGz1ThjZzbt9PRX7lJlpHcXNLOuG4icVJ5zw?=
 =?us-ascii?Q?nJ8lhk3ZAp4rQCrtH89YZ6LRPQ56efACu0BoxeBL6rKtkk1kGyOTzqZHDsqn?=
 =?us-ascii?Q?Tt2BXM0EsNMmEdoM72BltyJXNYxwVZ8AOM+mo1ATlayEP2OQUbU4FdPokwgk?=
 =?us-ascii?Q?a+QRNd4uFKrFuyBL5poLdPdbI6bkaEeO6kNwxNuywaQPW22BgLWCr61blt1x?=
 =?us-ascii?Q?r6Z+4NeC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af219c-a781-4e26-1020-08d8c2aa9247
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 10:01:52.6239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18p8sgJCrUnbur7T2viNcdBruYGZQYb5Xx8Zoz5+OA6ykbXOswS9jhbholJvw7+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Have some comments, please find inline <>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Wednesday, January 27, 2021 1:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: Enable gfx DCS feature

Background:
Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
When the current/power/temperature exceeds the limit with the heavy workload, the gfx core can be shut off and powered on back and forth.
The ON time and OFF time is determined by the firmware according to the accumulated power credits.
This feature is different from gfxoff.Gfxoff is applied in the idle case and DCS is applied in the case with heavey workload.There are two types of DCS:
Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D fullscreen and VR workload.
Since we only supports Async DCS now,disalbe DCS when the 3D fullscreen or the VR workload type is chosen.

Verification:
The power is lowerer or the perf/watt is increased in the throttling case.
To be simplified, the entry/exit counter can be observed from the firmware.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c              |  8 ++++++--
 drivers/gpu/drm/amd/include/amd_shared.h             |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 82c2fa8a67cd..186bbe139bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;  uint amdgpu_sdma_phase_quantum = 32;  char *amdgpu_disable_cu = NULL;  char *amdgpu_virtual_display = NULL;
-/* OverDrive(bit 14) disabled by default*/ -uint amdgpu_pp_feature_mask = 0xffffbfff;
+
+/*
+ * OverDrive(bit 14) disabled by default
+ * GFX DCS(bit 19) disabled by default
+ */
+uint amdgpu_pp_feature_mask = 0xfff7bfff;

<> This  will cause a problem for other ASICS. This could be disabling feature bits which are no related.

 uint amdgpu_force_long_training;
 int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9676016a37ce..43ed6291b2b8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
 	PP_ACG_MASK = 0x10000,
 	PP_STUTTER_MODE = 0x20000,
 	PP_AVFS_MASK = 0x40000,
+	PP_GFX_DCS_MASK = 0x80000,
 };
 
 enum DC_FEATURE_MASK {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..dffdcebc80e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) && adev->asic_type > CHIP_SIENNA_CICHLID)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
 					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
@@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
 
+	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
+	if ((smu->adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
+	    smu->adev->asic_type > CHIP_SIENNA_CICHLID) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
+			WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
+		if (ret)
+			return ret;
+	}

<> Is it guaranteed that power profile mode is set before running any 3D app? It seems optional and what happens if a 3D app is run without calling this?

Thanks,
Lijo

 	return ret;
 }
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C5dd84f799fc0473018cd08d8c29bfb25%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473322482922116%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Jl46H%2FxoSADMp8D0FPFELtQWeW3xACKobGygJ%2BY1SUc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
