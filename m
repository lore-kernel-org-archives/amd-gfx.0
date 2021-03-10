Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85288C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3581864FDD
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3581864FDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B886B6E9CD;
	Wed, 10 Mar 2021 07:40:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DDE6E9CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 07:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJG4mHHBMxzS7s3h3EFnWkWQMM18r0hYfz145q2229e1CzpVHrIQaT431qiAxv10EoVnfBJZ3PyFheqmDjmjWfuvlEG3GqgHcN/pNmYL0OlDoi6cMFOwTNVnQI5uSP/RrH6CCc54YaFmxYal+NvLmP0Igj5rOsHOdbG4GQhdbQ7UC89qqelucN3Vhb2fvUdgnw6hZeubQqE2WbLzcXnoC3Rm/iPAYu6ulAL0wih5RZh8BryfY6qYTDXfO0yAp5VdPGYKbIYn3y6+L88Bkm1s24D4Tgs9GKGRJSzA1TwlLcuR1Mu/SImN3EGpv6TbqrRBivC0MfBYH9ag4lShGR+OWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Ahal95P8xwWhS3Qme0H3uUwVfa7DT3olK1a/l1vjQ=;
 b=n9iQC7iBV+AhT+5neHMOCcymsTZw5Gp0EQDSzOMWelSZHkPknN7GwOsXe0gFC96fllLHUzkIgStJ2XAYXzFzwP8tPrmRqVyVw5wkWF9kzbFepDWKCps9AM7tdRx/it5CAZsMfuZFSVS/UZ7NcjK81GSbZjy78pu6PRsUATidJLU2Q5pE0z0LmqLebya/KN6+5fYSQ9db3Nqi+Fo+RMof1vdDBXdAW+01kgzmwQ5RgTKNkeVl9N7jX3Uaqx4HxVRdSULU/gNFXx7IvvBhEvf5igxJOW7MrFgWolOY7g96z8Dvxo1MDrcxp0xpa/+Sg33h0c3IXsddGC4NVzuv/NLsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Ahal95P8xwWhS3Qme0H3uUwVfa7DT3olK1a/l1vjQ=;
 b=aNbCSmccYTrP8nhjkgwy+1V7t5pwmLjMLhlAFK/PuDKErdQs9xXvdPwTov5mrENV7KlptdiVsihXaZaeukVLYHUIhoeQ3iNFmCs/EeyMmqooEC5JHuhQZPFR3tKuw+/GXQnwor8y140X7q1LbvUB5zgCpTx3KdxafNSj4AbFdus=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Wed, 10 Mar 2021 07:40:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 07:40:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query
Thread-Index: AQHXFWOO/6be7y71G0Kta5nba7CWL6p81mIA
Date: Wed, 10 Mar 2021 07:40:47 +0000
Message-ID: <DM6PR12MB261978DDDF04B6F2536315FCE4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210310041150.289806-1-alexander.deucher@amd.com>
In-Reply-To: <20210310041150.289806-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T07:40:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dd5e8ac0-3d79-4407-8578-232b5b10f203;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbac0d6e-a553-41d2-de80-08d8e397d21c
x-ms-traffictypediagnostic: DM6PR12MB4960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49602EF83BB857B66EADD8CEE4919@DM6PR12MB4960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOnNCwGl44TU1mU3kAm21tENt7IaN007H/sTqOYH8jBTEsDGiv+S6pgMGEGZ+A+FA6RRXK584MfRIbFX88Ae0jMvxPePCeTrDLHPACalhn90slx4WpiOC0uqwqIEikVNiTn0dN3Q1lXfTM0L1xBw8mbW+uquS22BLeCkm7J/UTSnjQhKjw5ACuntPhEIkqeKgPqccwXoi4gu7EREgkkD7wR/+sWWf0uZJe0o0thRuPwjy+zPmet/R0UbZ5FHgBqcW5EW/kObLACSRPVpPPU/uHjx2AtGRDjxWldfhNsYWBlNsywsouZ0Ca8bFcNKVFbLDdZv0A2cLeRRzEndgPV/FjZAc7ICk6AEit8HdnQTHDyv2q3g6U940uaGvIrJ/nTLQzF4Gk4F78CU2oJPQxSV8xWLvHws5qxHzYpm7QywCBLY4xJFq+ney2B/i95xlRntZyb1wdOzxKFWLE9r41ZrPeddXX4Z4IKK3gqCjNkkkeFWBQDj2Ds5q+oFMs3+wvTqc/La16l8oW0/ZT+sk5NLitfyTAKDjyFkbL6tC2n78jIxH1+TXfXnGkXVbWrZqZLY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(5660300002)(8676002)(45080400002)(2906002)(86362001)(7696005)(4326008)(55016002)(76116006)(110136005)(66446008)(6506007)(8936002)(9686003)(186003)(33656002)(53546011)(478600001)(71200400001)(966005)(316002)(66556008)(52536014)(66476007)(26005)(64756008)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?owvO9GegcgOZj0vMdavR7ifJBdtinaIzGxolFjN56uEfjCJyjB8egRroG4vj?=
 =?us-ascii?Q?tfMLQ8UzGMonGGCfEqwSuQj0VMiaDlkAhf01QyKO7ESItyGOB8qtkyILgAy2?=
 =?us-ascii?Q?Rc1Spq9PdxzywlYDzn8kT0QcBJCRuefdU0HLt1nyLLkrRCiSBJiXXhYuF9vA?=
 =?us-ascii?Q?KtgtbHRs1hEcZhznrQMeRaVoXbktih1OlyMh0EVkcvGR8us4blBIJKqNhrBP?=
 =?us-ascii?Q?7koPo7qQULm8ulmyzB+o5LDQ+quPZ67nq0wUSGbIdhh1cWfTLmWgmBNx0zkr?=
 =?us-ascii?Q?O7rxpkYwlE4lXa02AP2IQFoC+0l4pHo1ZsQpuZyNkYoW0Xwec3Xs/NTH6CjI?=
 =?us-ascii?Q?N9GAg1b5bm/xSWWeYBrrbMlEOWSnpCU5fLfaiH5n/RFLkK3RMgRlCQwx9xhT?=
 =?us-ascii?Q?dfKZlTWeR8mWhxtE3d1JrMKEvSbTDD39i/lxXgodvXgtZIrx6CjFPvLkBQTp?=
 =?us-ascii?Q?9OW/JtSw0C7FbFcVxLew7tYkzio4FTLhGQ6AVZonKsk/1Uhezf/u9en4Xauk?=
 =?us-ascii?Q?npMyoxU5M5dj5uWeOzUsma4kJkVO6SwxCsW5B2XSscv7FDW04P3ISicHL/NW?=
 =?us-ascii?Q?XLuMM2paQ0On6AYaD551vMIaSmKR1gRRqGRaxgPtrr03QeIWfdUaGHBLJ0rz?=
 =?us-ascii?Q?t+xVgTrZ3UlC1SRMOZItCzx9zJ/MbNE0GvrDwpygh86wXBlY1Stre6DADdMj?=
 =?us-ascii?Q?k2p6RUYfeqAGqK67z3k8X2/7+/+9Ptsxba16pCt4ZWr9GW/7zhInVj9Tw4tc?=
 =?us-ascii?Q?+evcUa7kW06MyL/oPJRskdX+OYhjR4NKXZfb/RwWol6eR4DAOXo/j/mIqPpc?=
 =?us-ascii?Q?4mXnwnfQTgE7MqRUigoRvEC/Y31MW6G3tVQSN0CpMOnjkWNdTInfkO18Zbed?=
 =?us-ascii?Q?qcgbJbGdWquNPTAC5YEiz1hH8JfInxX4/y/Tje9+flG4Gob2z91eSPA37gZ3?=
 =?us-ascii?Q?aK/L48iT06xBTtj+4CkQauhfnpHwWRv2PukJir1ksL+KdLyiuytfMMXCLYXr?=
 =?us-ascii?Q?g1xD26QaZuoE/nEIaXMEXoeBht0wV104MUCQ1bFEaOB1pMst4ybJN1iwM3qy?=
 =?us-ascii?Q?B/MpFtQZCjZQclFebS1yvq36ooMk8CSyYryuptiNvm4XM1pBN+XL9z2jsKSj?=
 =?us-ascii?Q?gKzVPP1KMv9s6fQWz0dLaNp++MkkBEnNJ8y9BCjR1LpHDVVB6DdG9svhmzJ+?=
 =?us-ascii?Q?SMm2sWRNRPz9Qv2qO1lGB5YByRx5cMkt42Pr5RNKpsv4Y+vuSrUIdwW7MshN?=
 =?us-ascii?Q?agm90qWUiA0PLw1bYg4lFSVG1GjX356NC7Pvvod4lSkciv+KIl26caQEqQsN?=
 =?us-ascii?Q?9ybR9Q5/fxKY4lCcdC+sJtW3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbac0d6e-a553-41d2-de80-08d8e397d21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 07:40:47.6539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dk6alcXbUGseSE6LY/YAsLTJl3SUafDAl5pv5JEiuCcSXogYf08JCYA6P+zJ6AAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C4ae33de1e1cb46155eef08d8e37aaf58%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509463371167218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mqAGA9lYO8lu5ZLC6CI7Cc7In6v7%2BWiyUwcaG6iQI%2F4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
