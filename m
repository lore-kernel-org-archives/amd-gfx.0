Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF2EE7FF3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 13:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E62710E8B0;
	Fri,  8 Sep 2023 13:22:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943A010E8B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 13:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbpWxx85P2ifvsCXaqLgcHiJG2syhGKmA1TPWpN1NdtOhRxNvkpqhhDfR3K1dzmP/HNbuHY8ZbFm+oFeSKbo1oLxkrEc622H44fE68+LxilVwplTyAmjSybnUI0u2kdPfSgcY+DN3dPIOELYbikLpi1AvHCjl2BzUuiApvPDVK/fRzvNTkjusGqueXxruneROgveJXvD3+Rv53WRF9KeCoXIyP2WLCeHbCgZRn24smaYeW3Thfw2ZmgQ4Yz5KsaiXFmCU4t7XMRjLjF+uM+4+OaxfMDsjriduPiGeBG2P9SmKprC4wgwBJvFGejm/mZN3VzQpsNCTH1jf6pntJ6h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2GS1CIFc6Q6hJuhMrO5kwcZZ7co6EJ/ZWRAoFVy9ow=;
 b=hey+cBT0vuHmsgFo8ET7Cx6XmoDNyG6Hr9/71QeBzqD+Q9K5MvjkU/XHJJxxCvz/QWbPe5V3q3/eV8CzqI+AcC2P/O4hAdR81iz9K0L47FjufF51p29Ufaf3lBGrwSMGD0bV2Kau1Q2m4XX0AhzLe4AFJ+qSKbbVhIQrxEjUr6F7dVUJMqOT3xC+jWMMVvbjYLaJGxZiZ55m8pFARv/h4aOv34JmIr9baBB9MjdpxLTKVFq1Bu6wz7CHWvceK2N7UcM44Qo1KSMctLjAwQU9wGa7+2W0wadIZSkorfxjIAM/LNoUHYQv8I0h4o7rMfL9pP0ZLSGfyTrF3LmbFEn4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2GS1CIFc6Q6hJuhMrO5kwcZZ7co6EJ/ZWRAoFVy9ow=;
 b=AVPLyBsak3y2PTKQmBRnOEq21P15qtMy4oCeA0yQht7AAGj3u6JOxIojOgC10KuSRM6iHgOojv+ydAcfOn1wPKxSesXqBFq7Igfb5b/0e1ByfCHonBMlvsuKTaSPoYyY8FoyppOd0KoRrnQU+zogEQNsjy0D/7IB4Fz6oCwUoi0=
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 13:22:53 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a3) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 13:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 13:22:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 08:22:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 08:22:32 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Fri, 8 Sep 2023 08:22:31 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Date: Fri, 8 Sep 2023 21:22:29 +0800
Message-ID: <20230908132229.9569-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7907558b-0118-45f9-953e-08dbb06eb4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nloe1k7Sdj8gCq1/6VEJc5f82pEFTbcRAJVDFYtjnp1sZLy/jcQkHjS7TCPKo/Apvpw+EJWU/g5GSdRcl5CCpbnu7Uk7HauZPV6NMQ1jFMaWOAepelN3YlffDCW7ERt28Gk+Bq2ps5CAki52ZAA//zrqkkHtppqp4ctf+vf2RU6g14AuhPB631HMJlaHEYUM/hy7ujE5FCJcP/TXo5KELlZbFhYu45Sgxpdr4QMO2zApxu0s88oYqIHLoeU+VYFg2mn93S7whEHy1HXPgLnxv5zoaBEWTKkpcRA4sVJiY+8GYlsnNb74P4EHDLm3qHG5+pdo6qsGDMHrUuFaRveocPDM6yrsFtreaAByFcSU4qkEOdVI0q2NAAq98E7nBeLN0LpsaavHjBI++HyTFtnd/vMsB0jnjkUD0g7CZIqDZK8yfhAJfnoijLHgY55OLe2iHD1ykzjocJU6vdMwxTmg0PuzON7mAr7qDBwkrUUb/DyB9ELpIYigWkR5/AYLMxXS1c6x8T6bOqVctxRnlW2q9+rrd7T5eS0btEdXJewqGyNr9aoWOKmrn43M7kuXtsLdi+/enybSGs5jWlvJ/tTMeo6ff6VW/a9aKRd8nM8xj7+3NtcTVanYfO1cibXFYXvBi/8/Vx+DimQMS2GTnl7UY9YlDCSoa6MvAi1jZT86yYSAML0ReSlf5DiZhSmYHWjdX7Ne21GQ0EHIeCaVIan+ulHpDdX7sjIaM7gGGa09fpobXEe49RU2r/OQ/B3HW+HZzHbiIRvTYBPd/nUMw2MqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(40480700001)(36756003)(86362001)(40460700003)(478600001)(2906002)(110136005)(8936002)(8676002)(7696005)(4326008)(5660300002)(70586007)(316002)(6636002)(70206006)(15650500001)(41300700001)(47076005)(36860700001)(83380400001)(2616005)(336012)(426003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:22:52.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7907558b-0118-45f9-953e-08dbb06eb4b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So driver doesn't generate incorrect message until
the new format is settled down for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8eb6f6943778..632478874f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1053,7 +1053,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		if (adev->smuio.funcs &&
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id &&
 		    adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
@@ -1073,7 +1074,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 	}
 	if (err_data.ue_count) {
-		if (adev->smuio.funcs &&
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id &&
 		    adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
-- 
2.17.1

