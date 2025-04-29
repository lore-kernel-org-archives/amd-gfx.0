Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF57C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B0110E402;
	Tue, 29 Apr 2025 19:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CTqnZ6fm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B64E10E402
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3uzy8ciGznySGDMxbr/RHOr7y9q5Hl3mQrIy4j8UrFwjFoA48e6Gb1IMolk9o4UHsqpftV/KlesiFHP8yuV/h0oxbzZLVmptkwY4F9qFg5P2/0BLsBm0z9YOFkT142auaLQ0/WDBdfnq+SdhaIFWyxJzpXnp2iweFeq2lZvynV067gU0XcTLXSbLwW9l/isGFy+jy3sGyw2hJ3j1rIBfg+zPJjfr4JDY6E1WE+j2/hFLiXG27yykoaRg0xrFdrH75Lquouaon0WdyZIiPkuWfOFsQnfleRlg1YHMo8Bll8qkeEMU+1hla7LtFJQ+2730pNZ2a224zV7JeiAGTZ36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH5Cid4UXDoMDZZyWTUfOb1Cu02eLTxJIFkUSRE3KcA=;
 b=D1KKNthU0xiRx3ytLFxbcia88kd0j3zIOSZEcsdg2ptoaVuHMY9qgGBPIZgu4s7Xmp0kSzjHbSv+UHFSQq76VLjdJGM1jjm6q3f2XFYB3P0KWSJB6nuisbatgREQEUq/kImoVOrCq7FiRKH/ikedkG9mAeqtoUMGfPtpTYI3cyN8SyULbglPXm6vDvtoyWlH2Noj8IKYs3cxlsuzEV5smxUYCsr+Sz/+87pUESzicKiQ1njxaVx5qXz8Nlud6s462yqX6fGW5HQHW7nIhVTCmY85wJ1+MqQPhjh4gqGwGLa6IFwRDrqHC0M1XIZNLTn3EyJ+ljc+rorVKN/PbAJn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH5Cid4UXDoMDZZyWTUfOb1Cu02eLTxJIFkUSRE3KcA=;
 b=CTqnZ6fmHhGXVsGbGaejk/Uv7Vpr2kkRuyKlQhKwo5k7aLsUPlp9gnr6RhFM2eyr9UeGOl2LysCue58+miijIvptDkkVzct34FdUNwkS4Jfsk69Mfy1IecWsfYQR2l/rT3g+4KxAyk7f0qLE8LbgSNd5YOkdxUnRLiSa7BuYNss=
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 19:05:57 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::67) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 19:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 19:05:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 14:05:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Michael Chen
 <Michael.Chen@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: use AMDGPU_MES_SCHED_PIPE for reset
 queues
Date: Tue, 29 Apr 2025 15:05:42 -0400
Message-ID: <20250429190542.1896100-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429190542.1896100-1-alexander.deucher@amd.com>
References: <20250429190542.1896100-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9b3e1a-9c90-49b6-5435-08dd8750df89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mH8bmbhmZjXHJIVuC2R88o+86M4n1ee3lFaCv+096r+Upv3o/MpUnQDjRkUb?=
 =?us-ascii?Q?G9iTMC6GsRV0GRrjCcdWH1oC5FxkfePBTzFY1HdEFu4kD8ZULNDyS5Ul0MpY?=
 =?us-ascii?Q?91ripvL2k1vShXS3W9lsOXXGxpLLPadDIP0PuqdMuAY3BjZL8B0nWsOgmQiB?=
 =?us-ascii?Q?vd8w8vD3O6DNBlgbanXx59tc7s8K3gZunyn34SP9Tt00axYmn1nZ1QVVdz/P?=
 =?us-ascii?Q?NDI76F/GdSJHIQcB3WfApTw0JymsvOav9WKkJgXsDS8GYKsrPwcld08jZNJW?=
 =?us-ascii?Q?9XG+qwAnOTcbPeWyk9A6QzD1KiqTRZ6tvDEluZhTsv5WCjczKA/cVXkKu/T+?=
 =?us-ascii?Q?MRS6gCgVWmr+yhhwXtU3P3UvBoBxgq5xMG3PlvXklGvkLnwfvapCMVZfANbq?=
 =?us-ascii?Q?oi2x+w80kYaa0UldPt8pLspkmzp5NwWLJTsBweQJWEzQZUGKiHZBAJ1KMDx1?=
 =?us-ascii?Q?VO9+TJ6Ml8TwzB3LjL0w2qnNPszF9TXfEWvQ91NLsF+0udeyDzZP460VmY9z?=
 =?us-ascii?Q?VoASUQnitn7RuZzNJXuw7vNDos3UHMJY6U8OeFk0Ow/KdjUbuae01ko+LSe/?=
 =?us-ascii?Q?BZXuLFlB59f/YgvSdiKIEB3ofHWHd5ZQDxOiixzf0szWz5vFBK8OzGzRE9Sy?=
 =?us-ascii?Q?hNwRtFExGqj2cgQj4v2vVmO1aXEu7vrmyqm3LuAOJKtTC1QgnZyQe9Y54Taj?=
 =?us-ascii?Q?cyXvASset7iIEZvOCRR8hkFQLGbxABdvxwziSdYteQ3JVW3LSzwRVP9hkOan?=
 =?us-ascii?Q?jE5o2BYlcQIY62VV5O3GqCboFWvnLSn100UHVhZ7uy2DyapJcRGqAad93URS?=
 =?us-ascii?Q?z61ee6Wsw/lCOjEKLyxS2aIFgq819/VV7kFihZb8v4qKqwWIHW76CFp0AC78?=
 =?us-ascii?Q?QQIWIce9Hk6PL100mSBwp0rVdEekfvt0hW/pCbob+c0LGs0ABmVdZdA7v4Om?=
 =?us-ascii?Q?1juEUv9G7vNyJ2GmR6+tf90KGqn2V63P/vvAAkjD8UXAdS4rIFwUmD0YmXyF?=
 =?us-ascii?Q?jjqN3qXm/DDtVr67KcllHTZkwLLTUG/r+5WAjyPNy3svlzuC0ZHtR1HuRokf?=
 =?us-ascii?Q?wJP78ExMO7xVi3EMqdr4aAhlQ5jPJG1RCT+v/4U1BRvExfmvwBl3sr8s/LnH?=
 =?us-ascii?Q?L/nzaT5w92U2f3TF4FQ4qYo4lgKKKYiENXwtnZolJY/7MVGL5mQDvlQSDuxd?=
 =?us-ascii?Q?y8e7DtAYNzcLg9VJaxC453MILwmGdnisBzxWly/B3vVN5jSkfKvjogG3Lw9u?=
 =?us-ascii?Q?h3H5HBqptDE71D5siS/vtVSLfrzU24LMAPQNlnWhs4hwP+yDMLrbwvSiZst4?=
 =?us-ascii?Q?1QNCgH9SGl/8fcCXpVTLyD2Gw7jeIlMso0l5S9Lyt4+gxn5GnDrLnzdI2PIW?=
 =?us-ascii?Q?t+1+B9Ag52jZbX7RinlfiwSSRh89UhGDCa6At6cLduEqhotuwSCe68di6BcY?=
 =?us-ascii?Q?5kMbodYEnVVBesSrIurd7tKdL5bXNSPhK0j/Pyiuhh9rrd1JcNQ3j9a3zDwc?=
 =?us-ascii?Q?/hyVRQ0X+3/BzO7DUxk1YJHh218axV109wdu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:05:57.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9b3e1a-9c90-49b6-5435-08dd8750df89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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

We should use the MES_SCHED_PIPE for everything queue related.

Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 83136fcbd50ff..e0dbce5976d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -828,7 +828,6 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
-	int pipe;
 
 	if (input->use_mmio)
 		return mes_v12_0_reset_queue_mmio(mes, input->queue_type,
@@ -857,12 +856,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
-
-	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
 			offsetof(union MESAPI__RESET, api_status));
 }
-- 
2.49.0

