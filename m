Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ADFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5599A64FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599A64FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042056E08E;
	Wed, 10 Mar 2021 05:09:11 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354886E08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 05:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwKc4qwk6UYfRRRTSvn2DW7hSOCp9VwAcPdtyIe6ikrove5YkBTv1BDo3t0cHEXrEqS6sQQJHGMFT45FS3uakZL7dedQgKBefvYMvDkHvmMxBzkCLYK2hfChl91b6EruzUinzz2GQO8l5oYNS49ef1gUZsjoSVpQWbJcQJRteTIpqbPtXAJCwhH8nq0nb8E/qbGqW1hp5OtF/SRYPdB3EbLyrM+ryitlD58MmvV4ISYlII8Cc73vqjR7niFEjTkP0s9F5yqNflU042grLPAw5oddEtm2+af3GAAHo30YhnBmsngcNGgKOoOj4NGaWvIBY3/5/Ve+4+7OUxZo+cuhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PfFVMSmWDUQ0VTSOLyFQNc/aS9NSrEfy/a/QbjK4dA=;
 b=Ef84CDXXsU/a0k7u2voTwrc9y6W0USZg5exfkwOzW0ogS3CmvbfExTJI41L8ZcoRW6OTqs+Ebnirh8j2+he9GrJtBquEaB8wWtdurQsIILbISA5eVpWrXVvRAA7IvF1hwEUIjUDv43Oq99le5ctzdY+2AwBuLKYus3CKmMlTrNyG0uskrPOwvXkq+7tPaDRG6f16xx4D9rheYvt/v2gIm+jGbSDj81IOacPdbtOOZw7HgRGvwe1aC1m2eyPkSCYKph10dAsGJAUjuiF1jlZ8lUGY9TFTXr4gKYOE68frIFTKVvy0Wh0EfGrNuHQx8t9Z6yImC0UZ0DKEHR3wazaLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PfFVMSmWDUQ0VTSOLyFQNc/aS9NSrEfy/a/QbjK4dA=;
 b=BAG9gEO4WRRM3SUxnQPpOnXlTKm5H/fQXSzDdylcsk2GogAD9jdA6okfyD9fGt045uf16TEqfozPiegyIsbrKlxD+NVuy2nJ0w4RBCIaGlsbQlyMwj9eIwwPx1ro38pJ1xf+HC+ELf+4b88mrg0mnEUivGNZ+/6e14oPN8iPuXw=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1877.namprd12.prod.outlook.com (2603:10b6:903:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 05:09:06 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3912.028; Wed, 10 Mar 2021
 05:09:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query
Thread-Index: AQHXFWOOnwkPfhcmNkSQR3gFb5SL+ap8q94A
Date: Wed, 10 Mar 2021 05:09:06 +0000
Message-ID: <CY4PR12MB128739D8D7AB95F2C0F61AB1F1919@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210310041150.289806-1-alexander.deucher@amd.com>
In-Reply-To: <20210310041150.289806-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T05:09:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=627d8632-6f1d-4174-a807-1ddfd319176f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cbfad96-ccb4-427e-c836-08d8e382a174
x-ms-traffictypediagnostic: CY4PR12MB1877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1877208A7071B99813D9A123F1919@CY4PR12MB1877.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HX5C92yicf0Bsodh3I1Ro7nO80QrryHr1FgqnCjFxg91VMqJMmB+TbKa4HVwPPJ3a2E+NU48xNWPgMUVEn3lw3SVWjVXo1qgK0DK+Y7bf28Ux81WI8Llz57/dbdY7tEhEvmGUoHf92cSH2TyhjEgOPqEk7LyAnfXMgAD4zgd6X/+Tj1rOiMF+V26PzLuxxQtUuSYae+cmGlDxsVytEK0PJET6Yhpw0mW9iuIqv3E2lq/SLF3QujN1KHn48sdtiOv1alBcEpyQWYvbWxD+eTXnNTr8AnyNFB8Q9OXOvEbPXQubp672J+HHqrzisHmZHqjHXr3pj8cy8uP9R4ykWp9rb26dDhPMkEV2ZjKVlRayB61+ZYfgUleJepGTU1wwIS2c4+4knhepe4TAjc3+3DrPlmzxU7iSAB/X4SoO0luhrLddqWaTswXBdHED6f39wI4GGJjv4GF0m7lu1F6frLjaBGnmrh0W9Itgi9QToDrgMVrSzZENzSPGf7o2XPlEBHtukdIr9UymmZ6h1PGjxPyXCnXcXRq4vezNjldgeQKW26ABEfMtE8rrlwgMmCjNwph
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(45080400002)(8676002)(316002)(66946007)(2906002)(33656002)(76116006)(5660300002)(66556008)(53546011)(6506007)(26005)(66476007)(7696005)(83380400001)(71200400001)(66446008)(8936002)(4326008)(110136005)(9686003)(86362001)(55016002)(52536014)(966005)(186003)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HZ9Skyke5BDq72cVbdSXzPvn+kvlp6677/fg/BWH+iJddI3CVTvTY0ELtSQT?=
 =?us-ascii?Q?+wvBzhuamYs/dWjQNPsYDt58EB4uoncWkQh7/R5D+qiYOizaH1tsu6FGD5wS?=
 =?us-ascii?Q?IGzCcLr7sEsPvxEKOnsmyKIpJHp4+EHO5AQ/HANL7FPUkZe4P9OvleTAXLuU?=
 =?us-ascii?Q?heVhsQppxpna4uQ/g8D7Dd0goSx3lAnkEqTOeLAK9iCLp3ZQvbS3e4yP9Ttp?=
 =?us-ascii?Q?oUNY0AEgcpCQjiXcoEXR/BjCMa+aarc37llfcvMuEBoRCKuoib9A4QDqML3g?=
 =?us-ascii?Q?oMyiuohobbL0O0y2DXA/i+j9qbiNhg/eIUkRwHhY20QDQN9QddqpR6klyGEO?=
 =?us-ascii?Q?EmxM0GzjfnzSdJIK1I/7tOFlyyh/sMAdgUDge9elPH/bpMreR0nbqcQZGwTm?=
 =?us-ascii?Q?J8dGclQTrFgcbCPZ16ao35byULSRMyVUqi2bhzjeW3yqJwr2z++fX+mAkqZz?=
 =?us-ascii?Q?zQrYYsDcZidAYCkSvQm0R/M2lotPg91LwXsoDDVTKGI8mF75cZxtEdxfMYm4?=
 =?us-ascii?Q?26EhbfHLeHLycjabEXymj4W3ELvon5FbEIdzpVunOLeXVrMqMaQ9lpFjC2JF?=
 =?us-ascii?Q?9Fnwv3J5YqLgiz36mqvbHOHALO7uu3aDeEi24OO6U1mpl+0II0p3PHfshLgj?=
 =?us-ascii?Q?SUbKODSfTalAkZszJfagvMpVnQKxWDEUoJk03aD9ExCJxmjn81iY/pvNZWNX?=
 =?us-ascii?Q?Uw3Y1+jPQvucbHc1pgzTWCQ2EOb5t94Ff/BoGSBOO62/fVAup89VaP8vt2Wg?=
 =?us-ascii?Q?QjV/FtB1V/iaKVRzHUv8gJ6Dy2h1dBM8Ypvt+9t7pCmov9VCkBS0VBNMjEco?=
 =?us-ascii?Q?5NRaD7N6LS/IcS6AXKLH2giHia78wxAEpDlmZWrQuBFfmvCdXs8csnquUu3r?=
 =?us-ascii?Q?a+8PCIxDE0Cpze8DQUZvWX/Rv1GqOKG1xJxsFt4ja1dBjkS7M3Jjjxcw3R36?=
 =?us-ascii?Q?bsxEZ31YhTIgez4UQf1KEF8pqJ8u1p13w5raZXRwxJoyupT9yTZ+8wG2mMfZ?=
 =?us-ascii?Q?e6o5ekPjjzwcd2uRkbKr6brAtQ/RxyzRXtYjduQIVxdkCJbKmc2p0v/1QhHE?=
 =?us-ascii?Q?LS9t9yLtOv9agsvza8EotX06aCsdoVs8eQF2+SDSyKuKtd2W3JDJ7gBdYSG7?=
 =?us-ascii?Q?8V3x1X8EfjR7hPQ9+PlFhYSK+UtQBh/0qAz7F6N4SBLqHpck+rB2CCIMqWE7?=
 =?us-ascii?Q?3ti7qVSm62vYdK3Xik0ZDpJfXuyHmPOeZL6MQLvW5Krtf3a4DKSsaQVsCSbT?=
 =?us-ascii?Q?raW5ioikOajJpo3HYyNttimFqeBvstuM373FnKpTx2ON2XU19xIWdQojD1KC?=
 =?us-ascii?Q?QrIk9clTEzE75IYwciUk3Asy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbfad96-ccb4-427e-c836-08d8e382a174
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:09:06.6264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NDXhtbhz94PSC7GbnV6WSFQrkt0hg+tNHyWGV+VbTmEiyTpNho7XSxcf5m/4c8hPzSwpOBrZlFXuSK+P6qupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1877
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+		} else {
+			return -EOPNOTSUPP;
+		}
+		break;

The 'break' looks useless, as no chance arriving here.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, March 10, 2021 12:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query

Was added in newer versions of the firmware.  Add support for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
index 4c7e08ba5fa4..171f12b82716 100644
--- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
@@ -84,6 +84,7 @@
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
 #define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_MSG_GetGfxBusy                    0x3D
 #define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c932b632ddd4..52fcdec738e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			  void *value, int *size)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
-	uint32_t sclk, mclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t sclk, mclk, activity_percent;
+	bool has_gfx_busy;
 	int ret = 0;
 
+	/* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
+	if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
+	    (hwmgr->smu_version >= 0x41e3b))
+		has_gfx_busy = true;
+	else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		 (hwmgr->smu_version >= 0x1e5500))
+		has_gfx_busy = true;
+	else
+		has_gfx_busy = false;
+
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk); @@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		if (has_gfx_busy) {
+			ret = smum_send_msg_to_smc(hwmgr,
+						   PPSMC_MSG_GetGfxBusy,
+						   &activity_percent);
+			if (!ret) {
+				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+			} else {
+				activity_percent = 50;
+			}
+			*((uint32_t *)value) = activity_percent;
+			return 0;
+		} else {
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C4ae33de1e1cb46155eef08d8e37aaf58%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509463372230606%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=MuROLcwbCeFRI8RWtgPSnrz5J4CEfG6R8yvbk8mqy%2Bg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
