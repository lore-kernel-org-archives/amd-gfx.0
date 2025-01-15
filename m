Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B59C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 09:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A349F10E5A8;
	Wed, 15 Jan 2025 09:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNKBnj9z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2429D10E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 09:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDf/HoAHnQj2bv5spSHCKVGDdJtQ4n6Ib2FvntCcegqLyaR2UBaE11JJxR77qDhkLVDftQF1efznDbXpToEXFBg73AKgPNolSb/u9oBAk+KqDZlKLniF3Ek916ocFMNoqlaLLAMf4kbdlH1u3dxRTw8x1xvDAy5MjuqMu/RBdLDrQjW2MlFnIzPFvvmpnOr/4dvg0UmYcoFsRC0g2a9H30IcLq/7xH4TTGeVLLo+pHrfgexJ9uO5CpzmlDntp5MiZt0YUUwFwI01EHKRgwcZrPIfifcdlJ7nyiLIPH85oh3Ashq1C2g6A4GNCtAt/OuH4AXTi+1BwEu4vp3XVsP1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D8eIvC1AxgmHr6Sr3UPJxeKqg9Pma0sFCkc822LlHs=;
 b=YT+55o60npI5jQ1Mi4Pee2E0L4jzeGaXi/vosqWCNveLyGvE76PpxwHl/0UCKG+m7GCNZaXQu/xkUd8oJvIjqIPLXFCzNKxlsAgOe4OKNS66L6QmFe5Ibqj4WS403mMp5UopVlOFZVZ3BDms6BbmLbqMQPY20CMCkzX4fiFEG8Esbm2p31Q+xwdYujebznmSlOEQvm2gBEatA6vhtcIiGFs+cEb35uXX57L+a/3M2cDIDLnkReIMFyXlEQW7Arh0Cbj7GvWDG5GWgEySYRuiQblDzqWOXzqq6RkILT5WhViSjk4oJ5cUz9A0pF8UAE6ylZHmvAkuzBC6Ewv823TTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D8eIvC1AxgmHr6Sr3UPJxeKqg9Pma0sFCkc822LlHs=;
 b=WNKBnj9zuwjFme16+bY1nfzHGGd0FEmPteD4Q7F+yPyaoJ5pK2yuK7aEe/iVZx7I+hKM1nQzLMkL/grmuINdiAyNhpBT2V+6d9akoxHSBuY6Jfc1mgAcdElJ399Ni8jL+ZyatvXFJ3n16XloNpo3dySVSLMUNbLSDahBc9HeyhA=
Received: from SA1PR05CA0015.namprd05.prod.outlook.com (2603:10b6:806:2d2::24)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 09:48:30 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::4a) by SA1PR05CA0015.outlook.office365.com
 (2603:10b6:806:2d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 09:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 09:48:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 03:48:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 15 Jan 2025 03:48:22 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 3/3 V2] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Date: Wed, 15 Jan 2025 17:48:21 +0800
Message-ID: <20250115094821.3736827-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0616c0-40f5-4cc0-a100-08dd3549c457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E2mnPIaCCVEh+5nNmrZ+Kl0phYqU1SlZ1o0pxPVHxNC/S08FHsjtJCrC7Ca3?=
 =?us-ascii?Q?iilWyWXdcHq76NLPRhEh/0hPe1C8sYaw9kuBX+ChUIgL1zCgwfD+ndt59R+a?=
 =?us-ascii?Q?Ty+s/4/2bcxJ+bSYYSt8GdU0KeoBRB+TwbM+SlvAZQ9fQwqKZ6rUbPuuPRz+?=
 =?us-ascii?Q?lehRXOscEqcGSIEQ+lGZMrdLI57HGkdhEXqZj6CnKv8tC+2W+Af9IFu8+sGs?=
 =?us-ascii?Q?XuqKHOnjOkLmROokmZTwvItY6Y4EoGxiKaDMurp61BtHlBjalKlBawngRreE?=
 =?us-ascii?Q?CXxRUdxNzmAm8h4k1ZvukLbov2lG9rvpJKy7dWtdcK1PsIbsGd/xN3KvBXBv?=
 =?us-ascii?Q?foBEzae9w7VXvca8bE1hoQzufIp8snObL7lFBYk1k6tf5bUbTs0dpxs6NHU/?=
 =?us-ascii?Q?uGreTZ2rncmaefSL3anDZ6Ff0AfX7w2j7ldcl2pHtdjod8kkP62dFtBkvo1e?=
 =?us-ascii?Q?OVll0KLwMhnB9pkYfideCLBrBOT+a257IFzxp6NvnyLZTRGa5J8GpOq1065q?=
 =?us-ascii?Q?FhIGH/vJKh/npbk0tXS13TiKrOdPu9wAjvTidJrh6ko9PpWs/6S+JWZpweOC?=
 =?us-ascii?Q?BieqKHp670iN3uTkwMyGno2S1OvioTZKsfc4oN54Bo4J8CZaqLYuv6tIo0iv?=
 =?us-ascii?Q?e+Cb2681rK9pSviIpgMRX9tCuaJDfpBDEhLDTVZt2Nn2rppZ3jAh72K/w1kM?=
 =?us-ascii?Q?r7ykciPQd4vbJUnROoo8QU1zPH2j5kIgu/SyhyJSUlPOHPM9/bphMVUzeD1T?=
 =?us-ascii?Q?KidstWSqPPgBd4S1Kx7tl4lPXdjmbSh7zHxYGVXipEhUlijD4r9SLxy6ILF2?=
 =?us-ascii?Q?hPWu5REpOT8QXV6GZDCFbuhdBkYRWwNJAnsMViml1FsUBq4PeZP7winkV2DJ?=
 =?us-ascii?Q?ZKF7OV1a1u3lm2kkowpYHk9NeZMAv/KE9UYZCS/ajSafhN8pIwNIUC+ODmoO?=
 =?us-ascii?Q?KUJTk3iO6jd00vp5gOqcGRhcdIBHznZoihlGvNFbuOWGeEFywAx3ZzPJeSbp?=
 =?us-ascii?Q?G0qV4eYAqyTijt24TAiYiaj7NQh4mTJscH353ZslCzdqAGL3FANvzvSGApcR?=
 =?us-ascii?Q?Mn7HeuBGA1L29gHwWRjFGsD7lDPex9FqOAHwKBouQ2Bw1SYdkYgUFyJMhZdr?=
 =?us-ascii?Q?zVjnmKomdhq1oMxxKX0waJjQjaMieKG+HZImZdxd52Yd4amrxJ6CfSOryLGJ?=
 =?us-ascii?Q?Pt5OL2FUsmMLliEbHi5QBz0fTZCxmvwIt9uirsw9HSJL8G3ogyCu2fACY4Zb?=
 =?us-ascii?Q?zwLpSJ3nIbDQfNHBNpXCAyiXHpGgjvGnoyZEoohdRLUPzz1E/QNt9cxzWd3v?=
 =?us-ascii?Q?hOeyjV3KK3MnT87p0fwyXjQ0INP+UBTjP1NJCAbramb/YYtdOS8934FIF9r9?=
 =?us-ascii?Q?8OoUIV6rSyJTgmDgi+hGYUAi0/kUe69TZuVHtAPGgvx8lUJUiAJmbd5cXgtP?=
 =?us-ascii?Q?21Idd1jUAOIN4+i1KqSp3LB347VR2/q5ljBXEyldmAhvEOej4OBRpZiVZsGG?=
 =?us-ascii?Q?UApnGB3BYekkz+8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:48:29.8659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0616c0-40f5-4cc0-a100-08dd3549c457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
to support multiple SMU programs with different firmware version thresholds.

V2: return -EOPNOTSUPP for unspported pmfw

Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 650aa9d0548a..f68282238303 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2745,12 +2745,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
-		return 0;
+	uint32_t smu_program;
+
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	/* the message is only valid on SMU 13.0.6 with these pmfw and above */
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
+		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
+		((smu_program == 4) && (smu->smc_fw_version < 0x4557000)) ||
+		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||
+		((smu_program == 7) && (smu->smc_fw_version < 0x7550700))) {
+		dev_err(smu->adev->dev,
+		"ResetSDMA not supported: SMU program %u requires PMFW >= 0x%x\n"
+		"Current PMFW version: 0x%x\n",smu_program,
+		smu_program == 0 ? 0x00557900 : smu_program == 4 ? 0x4557000 :
+		smu_program == 5 ? 0x5551200 : smu_program == 7 ? 0x7550700 : 0,
+		smu->smc_fw_version);
+		return -EOPNOTSUPP;
+	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_ResetSDMA, inst_mask, NULL);
-- 
2.25.1

