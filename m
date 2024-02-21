Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B754CC5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 17:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F8710E279;
	Wed, 21 Feb 2024 17:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cr3DBBl5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5510E139
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 17:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzLkI2srrvO2WX0Co2Lh9HiLO5mBGLRZdNsPbCFm8ElEWcdcsw8WEx6wcomtJCMvfOF+T0tJMPekXWX7KYrOzSZJAnwQdY2RpoiFUKtcHY+cNzl8Yd1QH5qnH2/PY3gTi7pb0TrrHMIF4qM2w/WgGY7pRBeYgPwY7DqflSJF5wPEcWazmzkQRDaFaeWlGxAAMWCqqgmJVLmoFjsYzydR4QVJWs6gxRASU7xHVeWyuurvMw8XWUaPlvUFt80cGJlcZFV/JVbBzLLAHFsiEuoWVE8y1ObGMu8Ks4Ql47KyLuxsYfdX3XkF+m9ShZsJH5ulzjhJxfgo/EHogunZ0iUiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qfuz/6W5xH9CzfXz0NJepAbpS+gc13XYeo5dfQZwb0=;
 b=UxzR1rPEwJm91/dYL5GG3pg9rnJUfCtKu9qmA+F+nrHI8AogS0xXRI30CbYFViXkiEKFVJDJzFQ2jblaXhxobefT9VAIKyaIJB7BC2l01X4jZPMyrCiV734kR4/czG3pO4/WOeETu4I3f7S7Pzj2vrF0YSoY03nRZuV23CNmhY3I36D6m6nk0FvlDZk55a3i0gd43vTJxHnsWKoXekGj1TjXbsvTp08Uevdg8dqiCDo3RM9PxTAnKx/HgNBRaCZffVBipX6NiFOSOXekJdUZzpwKVxyFT7yhnBnxOZeQpUYx9dgk3LyMv65lATl8BqCrCKxraHUZmupPbqE27t121g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qfuz/6W5xH9CzfXz0NJepAbpS+gc13XYeo5dfQZwb0=;
 b=cr3DBBl5IkYHKetkIF8xQMbr7mwqqsc3OZpQetOJGh4sz16B0OwbenLYoIfIVxsl8XyjtITS8HpRlhTFz5ATe395s9ZWl+k0bfP/3HKk/5NhwazfmYH8rHxB2EmjDfaVQyW8BTP89nrmIJq8rygfnuNFmrK0EY4GoWViHsc3mDA=
Received: from CH2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:52::20)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 17:00:33 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::67) by CH2PR04CA0010.outlook.office365.com
 (2603:10b6:610:52::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 17:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 17:00:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 11:00:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/soc21: Enabling PG and CG flags for VCN 4.0.6
Date: Wed, 21 Feb 2024 12:00:14 -0500
Message-ID: <20240221170015.8866-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221170015.8866-1-alexander.deucher@amd.com>
References: <20240221170015.8866-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 71032d31-b5d5-4c70-e769-08dc32fe9d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTjBlJs7Sl+mEK9gmJPSM5jSzbzuQiKd6/RFEUwBD0rbbuJ3/XYz5ZT09Gm22Sb1hRq9fEJXg1ciNlbRj15HNYpMmfimDllS9FS30n3DGEKbTq0H8an1ttK1kCKvci7T67fGtJR1ayw6t0kQRQrYWuV14QF8PtnRtDS7UL79INA2WZve0Amz+BAEyOqVOTJ0KRq976vqWReMdKa0QHxdpvlFuwto0kgzGORCdYM7qFkCYNVc3lSKuizheCzjuHkaWFZ1nwBZVgDEiEvHCRDFO1GqJ1msDjlU9QXRNj/AwxnU+oyFnZz+UTzU2xTvPedaDD9zATpV47qeUit7fI13955ydoY7tzjroZvs3xcp4crY0JvL5a/g0w38I3YoLlvhegr5JZBxCHptHf/0yS4ge4XHdF0jn5Psbbx0aC+YPPlCOTL44o9qgQfLRXdfl2weL23OA5ADdzQMWnsOFmEfw7BjpsG3DoKLPP6K+M3ngrFIoQ+r82p0wVdpRuy385snMHyPSkaLQXJ2PJgK3Izg7RfCnaxs95gXm3CO/48yTB6XnuDYMQRhAqpO1GfH85k0Q3S92TZIgQx3dvbechHBOrAeZuXqb39MXV8BNnwHBIgpDMI3XDwlI4OMobotF/jsanDGaukrEfpP3mModdZUDUFnTIlxyjd5thvzLUSU1TA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:00:32.1565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71032d31-b5d5-4c70-e769-08dc32fe9d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Enabled the VCN Power Gating and Clock Gating flags for VCN 4.0.6.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c663cf3a169d..b92fd6760fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -742,9 +742,14 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS;
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-			AMD_PG_SUPPORT_GFX_PG;
+			AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0xc1;
 		break;
 	default:
-- 
2.43.2

