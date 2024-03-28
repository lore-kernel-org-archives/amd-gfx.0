Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A2C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 08:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C963311234D;
	Thu, 28 Mar 2024 08:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4iMfmeml";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D415D11234E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 08:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krZXf/Iw+wDCQ9HcH3X0+h3fgQZBLIFZje8J5TkuNm7ZvhjD94Mj0P6yJ4XbIq3E1ZlpvxWJ8QkfdR3jQHxmw8jq/JO0sT2H0ziYYa2zsxhiwzQEZG9y6zTRtpFVl2rvS8z/VKfQiDv9IZJRUXkd8J4IBAzrwWjorjKi+zufaQ4p3wkDDXgezSaC0eVI2kdAwfr/h/3mtw2/V1iRqqvDFLAFeF3/I3C9T3vlsppi6DoYKAhqervMSTjNxTwl4AShbDY7DgiVc6GpfLTI0UWPvjUVx6u0ttTcZpDZ/PGkfXOFa+aoEOSKpg9ZjqmwRM+9hfmYuO+9Tr86qKhys6i3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAqnP/h4lI/ZZTlZ2c6v3HJbcHJXe+kut1GocTE5PvQ=;
 b=WW6/dxcTB0kZ93CVqKNBISKT3hCBkz0h1j5y5gNtr8O8WNViNxwNNRZCurRWW88IxjWrw6ekboxhLzQk+uIrdfBX6O0g4Wb0Vq6ift6yukRidd+QsWNeys3Jryd30sf6/RTeCYROa2krqTC0aDCZtwhuNtz7NmxNJYVLVNmNUJSIWLLVLP4U9hChxmiTOeO0/ejyRtZODvok995SilnKM7qvaQTwUz0+JdiJazehJbvSRXtmo+yd47/JN9v6YXwowAuwGcIbPVHeHOm4TN1mWDknT3TQnuF7pK/mOVIb4LXlilJTkxaip/52UTSlIrCChGZfSxArb+HZv3vDTz43+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAqnP/h4lI/ZZTlZ2c6v3HJbcHJXe+kut1GocTE5PvQ=;
 b=4iMfmemlH+2Vf7Z5/kSSXNMXKcbDR75JzMRajZVqbj40Tdy23TUVBaNRQJo0lYlsAaksP6D2kqnimng6CL2GhMnAtz65XwbTsa0AtEFU++KvZfy/qTsmPx2PiLJIM+9OP+gROhcPJbJAFn3w0nkyT8M9/8/sg7zzavVp/CxyrIs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 08:01:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:01:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amd/pm: Categorize RAS messages on SMUv13.0.6
Thread-Topic: [PATCH v2 4/4] drm/amd/pm: Categorize RAS messages on SMUv13.0.6
Thread-Index: AQHagLjF0I5ls5kJiUCi/kP4bGc0IbFMytzg
Date: Thu, 28 Mar 2024 08:01:54 +0000
Message-ID: <BN9PR12MB5257D024D880E5461C2A1752FC3B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
 <20240328023544.820248-4-lijo.lazar@amd.com>
In-Reply-To: <20240328023544.820248-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=890b77c9-1b77-462a-be6f-2b46f56dc379;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T08:01:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6646:EE_
x-ms-office365-filtering-correlation-id: d940dec0-ea7e-4a87-eb15-08dc4efd5560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GqUmD8XFca+mokYVXoficAoWoxWNVJlDVb0cecqq2p4tEpA5PbcZ3+fEr4iW4xjaKZG0SLPQsR+q0n0poCGREtFITMk1RwcXu20SK3ycaYa2H8E1e2C860dHWHSjPggT4dGbVJk9XAuI1iUsVU0MrWEMtQkPhKWr03776OHL4t6CMWvq/arQufvGXBIMPb4V5eFBAY+216ohPxvTIp3hRg65JijKAA+xqpxEJ9JHawPHM7jjApQH2btAGqqouwjky5T1+OFaZI2wCVUC4/h6GCE0Bg869b/iQdT7HYre4OxGZXHuPBSZJGuWs+UiG9Xhfk0dVx84+HVDp+JodPSATg+Ge0fbwRkv8T25Rj3d30Ly+REuAx/D4BvGKQR7sL7Ku5zqHCeltmDKqruD00iBUmQ+qQYnrvvpBh4Q079hMYNK7j6HuFB49xF5lBjxjIEuLSYoHVymAuToW3WtJKWT+tahs8+PheuqWfIurQ0i4BUtANRkg41UPgZgSHI8GeVlr8gHDiKjR+79RgZEhp5aNJgCL/RFEE9TpXbII9ftFquXzV5w9TpuvaoiEf5E22AQekV+/T6YdbX52jIXbjcKd0XFRpQ6aGkngJKg4CdEex+yEDGPgNYn8OtJiQOROGTlzfc/upnP/M8tUWXXHhDZAkf7+PIJ/nTonAHaT2i8FKaOmepQ9+x4Ket7XKR/ZHE/xZ+BiuOv9IFmKnNrYFNEXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ZQ5rcUC3VJja2/6TJgOdWWrtl6SNfLvYOBD3jPw8nAtSSw4fRGIVJ5DeBAB?=
 =?us-ascii?Q?hdVdVVxEvVTig7bSrr43R41TSSE5n4c+dSA5VwKWWaU77AnyM4i7rKr36uHE?=
 =?us-ascii?Q?Xbiaz4G2JSCCtuyPgPNsAdWCK2ILSlofuGKbii/kwwqYgFwKvvlUazK4z3jQ?=
 =?us-ascii?Q?4zy0GIthfA0cUa070J67BiITYX3SZLAgVoF8Ih7x7Sj3yjiwreSgWcPveE0+?=
 =?us-ascii?Q?f3z4HQa5bypzTYdxz5hTunBgLOrRMQmVEybKs0v/ljyHDCd1tL8z/dzO5v3w?=
 =?us-ascii?Q?7Po9Yi4+70h1ASsFeVyyclcbKl/jzCJzrysHRPtxHtEyoCjr5IbBbPRaOI9h?=
 =?us-ascii?Q?f5PMbbM3XeV1z2E0IqrqLdPe39R3BRMReJikaaKHEXY/gyTn9Sbg3DS+j2j5?=
 =?us-ascii?Q?iceCbjQ2mm3WFQSwtQDpXvx5NaNNIL9DcHLM7qk9lm7uBtnrpXVcZVNKOZHf?=
 =?us-ascii?Q?5+1K8vlOmP9VDmuWMHCObCnq028pdwY2Axr8shfxdKdYIgd131A2azOnCbeB?=
 =?us-ascii?Q?afFo4E45ZSUuBb29JnbX+vSDGTlVoL8I8xRHM+nuWza2eNkK1lLysYSZKmLL?=
 =?us-ascii?Q?HHupRgjlzCJSBJqBIiUAMZFSy4T7mx833OoMaqYH/HeNTG5pkph7QfFzyEAh?=
 =?us-ascii?Q?xZM3Lw3LcjulVJU3X0Yy80s359WR1LeIeJ0SAkoxwrD7NO8hvqBmkUUkATpe?=
 =?us-ascii?Q?laFDPN5Lo1UaQho6o4y4OcSB3EuhIvwYsB+ZtUsZu7bioPy09uzXONV7MoAy?=
 =?us-ascii?Q?cs1YGHWHWUNHjmfvh2DjDeUooQ9THRe8cDpJMcezsRVIq9pST8lqiAOAfwr3?=
 =?us-ascii?Q?Oj5CEH4T1/OizsdZk38yz4jRlp4N+eeWxI0dlz7wQ2d39aGmx2zhZtw+e1BS?=
 =?us-ascii?Q?Wy7I19YquD+rQnt6AalrUGOn626hs206cGO4D0ZSFEfIwkeqVxRGTpx/mSiY?=
 =?us-ascii?Q?5LOrUIsasTRp4XMX8WdztlgVrNLhTCmDvINifvhhvQvGS3apkxhUvNJlpbw5?=
 =?us-ascii?Q?BPWoz+2aChSesog7CQN92eW1BZScwQ2JH3qSbmY5ecRS9idOKAqtCaoKJT3j?=
 =?us-ascii?Q?gGhMpZt3poZ0EAmIdyaP0YGuJcCrqeXpKio6nPB2Z5zgdb51WtcZIqQrAl8h?=
 =?us-ascii?Q?ifxVnAvi+RBXi0uKy0Ccq+Kvy0Ip5COaVieaBzO993BzMFsrRWYPjGh1UQ1c?=
 =?us-ascii?Q?rOTqwmQxoLgzO3WX5Yb/NvQGE3kN3QzrS7empb7H4W85RAKrZ9EXtw3r+n/p?=
 =?us-ascii?Q?p6AIvddgm1qlZPQosXHT638QT/bQ5sdbt4+7xrgDlUnUggA9WeRRfXR2EIJ7?=
 =?us-ascii?Q?uBti/eUgUBgOO7URL8eeyWUzBfSmXbWtp/3adDP64XS+u5J/RTSl7U6wKk86?=
 =?us-ascii?Q?j/IfMldU5FpnNa5JVHHBs5IED6jVVSJ3UtW0ZTog6OuwJZllEqn5zHFJNzp2?=
 =?us-ascii?Q?zjiApJTg7jFZZThrrYqaIKflx6xDacFPzA/b1sKUyIl5Ns0SFWsITT85cVlt?=
 =?us-ascii?Q?KO2wCh7O/d3XlXAGJsAgxDBMFFC/XLkOoIWii1AglEYAXy/t0u0d1x8kFjqg?=
 =?us-ascii?Q?ecAyz+4xtJLNWzg4StM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d940dec0-ea7e-4a87-eb15-08dc4efd5560
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 08:01:54.5290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBXJyQWbEngaDpuN9exXX0TWdP6k1EQvhhpVF58mQT4Bm/mgz0bROeML4M+HviWdHCXZbIRgMP7V60W8ax8zwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 28, 2024 10:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2 4/4] drm/amd/pm: Categorize RAS messages on SMUv13.0.6

Set RAS priority handling capability for SMUv13.0.6 SOCs and categorize RAS=
 priority messages allowed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Move setting FW capability flags to IP specific code (Kevin)

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..6e06729fb2e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -144,7 +144,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqBy=
Index,               1),
        MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     0),
        MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,=
                     1),
-       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  0),
+       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI),
        MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDr=
amAddrHigh,          0),
        MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDr=
amAddrLow,           0),
        MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDr=
amSize,              0),
@@ -167,10 +167,10 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_=
message_map[SMU_MSG_MAX_COU
        MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,=
                     0),
        MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottle=
rLimit,              0),
        MSG_MAP(ClearMcaOnRead,                      PPSMC_MSG_ClearMcaOnRe=
ad,                  0),
-       MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMc=
aCount,              0),
-       MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMc=
aCeCount,            0),
-       MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpD=
W,                   0),
-       MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 0),
+       MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMc=
aCount,              SMU_MSG_RAS_PRI),
+       MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMc=
aCeCount,            SMU_MSG_RAS_PRI),
+       MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpD=
W,                   SMU_MSG_RAS_PRI),
+       MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 SMU_MSG_RAS_PRI),
        MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMo=
de,                  0),
        MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),
 };
@@ -3218,6 +3218,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D smu_v13_0_6_feature_mask_map;
        smu->table_map =3D smu_v13_0_6_table_map;
        smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
        amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
--
2.25.1

