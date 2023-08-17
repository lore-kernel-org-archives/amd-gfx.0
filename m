Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2802DEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 09:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56E310E057;
	Thu, 17 Aug 2023 09:02:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA79210E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 09:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTj4Pemco1bCtue7h6MrWV3GuVUdBXb9BJWGE35shMW5o0pI+6ARCP2a6x/hnXm6HxZmOZtu6EoeFPL8PeFD0zU4Wjrm9WLU5OMqTDCxExSLc9LNvykWmPy+CLNPkhnVnOdIAUIA13Zg1fxhVONfL79RiA/1JyJRyNpQv5Nc6JfRKwFrrbifRV3Lo6sjEvlUu8Qd4PlGl7bbQlQ25yv5EulJdZkT6Mz4cqYN2ystoRuslNfU8/G1b+7od6g3SF4rcwCvKrnzlKO0LEpB8u3CnZPeAzduYCyW1y28f/LBxxePYgopZcAJdDWUKPEmLkJbzrPTFQXSHNIqGNG9zFDbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz9AFuV0K7ezZiP+jvN6pdEV3dBZEUYOjpAyxxibvds=;
 b=dHQ6GyAFbXOW1PgofFXeN1R6oLjIkF/luKwA/ikW11vxvXuOM4eXAbdZPfuu2FT04XJS4pxkxCGjIl4YRL9hKL2nqFpWiC8aYQpzFnQosvF9YqPBerzWYaBdGe16ZIOkAbmqXQHydGKFnVwZ0W2/Mlmj+nYDTgUpTvVufnsyBzuYXL0Tj8Zh//JAabnzRYvqTH/YBoHF3esmxcUCndDQDjC/KFJ2q4sv8g9+apyUBjYnTTsUcHiydLVSq7TugTFBs7FMDPjej9ClUR9QscCSGImt6T/3ac/tURmK656HRMODhG0OXFsVV9gL7PK/zRQqkRCl7kZZItL6iQbFGc5opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz9AFuV0K7ezZiP+jvN6pdEV3dBZEUYOjpAyxxibvds=;
 b=yFkHM0wZqOKJGMc3w8L1TKVNHN2KFoULR4LbvqLJKdCwpDKpZjqDwgN5QKMR3d8COBQaVh6LjYS1SYpm52FRb2zjAkP0MyxT+k0ITHGGQUVNpnwe2aiqcl+pi17nC9z1eAjasogkFyykxr74URGF6eOYA9COpgvAAhBws0WoegQ=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 09:02:15 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::f1) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 09:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.5 via Frontend Transport; Thu, 17 Aug 2023 09:02:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 04:02:13 -0500
Received: from qdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 04:02:11 -0500
From: Kun Liu <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Vangogh: Get average_* from average field of
 gpu_metrics_table
Date: Thu, 17 Aug 2023 17:02:10 +0800
Message-ID: <20230817090210.3215438-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a87d542-3615-49ae-15b4-08db9f00a6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OahlzzS6k2ihNf3VGkKdXoKk52LTpWj2Sc0uL8LwCY6K7+m2Miy8s16ir8gx4dDWWWFRGUMTMijc+m7OKBn0UKmW9bvCF6s9FTjCvKMaj/XVq/kxWNFLy9x+1uasLqD4JlwkewrRpQHKvxQiqRol99FcW8cHUJHkVXa8U/mulzrMcQHUfeaEXF0Kb+aeA2QUfAgCL0+Xv0aDppu/9IZYhbpqxEvHVcE7EaAXV/pr+67MAUqtJNHJMtougse+yBKNAzxCCRnGfS4+EBGPVgTHwoeaOyyz/wsuMjxvXGMY0Ct/lCRzNi41FgI26NN8QhGG9n9882tjk0a2uVmgc7ZWqcAFf+Mcrp660lF2vvdtg/S7WzK1b/OCA9eJFzAkaMLrJat2xpteNeWD1OATLZbyK1FbhRqk8Iz/3Yo8VF/HIorE2XyyVNAlBlTA/U0WslIXcAcTw39Qzhb5yxcGP63vbsz//dveyLSQ/kG+dvrx3f40p1Yg+KUHR1LWixXF5l1/uLs4dY4P0wetQX2LKh2sWcm9N7buUHOaKux8VX/eO4gW+L5LefhRunKgjo6ZFQjJTyAT0BpHuhyWAOX55TeSWXNcK2jEfOEnE586OLJ5R9KOws37PrV/XlkKmBG5F3Xhz4TjynY9gxJBcfzEKBJJd41dtnGDuxDeYWNJqAB8n3RBWNqw7vzJgjPUdkJSgIcrKnSuebmXo+TXGPOTlhcrWLhYt4gahTNq8mSHPmg03mNDwg5JnSayVCfFCI1i9KjNXrWTj3Ll+MampMN+KzavMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(36756003)(7696005)(2616005)(1076003)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(70206006)(70586007)(81166007)(6916009)(4326008)(8676002)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:02:14.7393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a87d542-3615-49ae-15b4-08db9f00a6b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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
Cc: Lijo.Lazar@amd.com, WenYou.Yang@amd.com, Li.Ma@amd.com,
 Alexander.Deucher@amd.com, Evan.Quan@amd.com, Richardqi.Liang@amd.com,
 Kun Liu <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for older BIOS, smu won't fill average field of gpu_metrics_table, so we acquire
average_* from current field. but now average value is available in gpu_metrics_v2_4

Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 185d0b50e..28b738adc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1883,21 +1883,21 @@ static ssize_t vangogh_get_gpu_metrics_v2_4(struct smu_context *smu,
 	       sizeof(uint16_t) * 4);
 	gpu_metrics->average_temperature_l3[0] = metrics.Average.L3Temperature[0];
 
-	gpu_metrics->average_gfx_activity = metrics.Current.GfxActivity;
-	gpu_metrics->average_mm_activity = metrics.Current.UvdActivity;
+	gpu_metrics->average_gfx_activity = metrics.Average.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.Average.UvdActivity;
 
-	gpu_metrics->average_socket_power = metrics.Current.CurrentSocketPower;
-	gpu_metrics->average_cpu_power = metrics.Current.Power[0];
-	gpu_metrics->average_soc_power = metrics.Current.Power[1];
-	gpu_metrics->average_gfx_power = metrics.Current.Power[2];
+	gpu_metrics->average_socket_power = metrics.Average.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Average.Power[0];
+	gpu_metrics->average_soc_power = metrics.Average.Power[1];
+	gpu_metrics->average_gfx_power = metrics.Average.Power[2];
 
-	gpu_metrics->average_cpu_voltage = metrics.Current.Voltage[0];
-	gpu_metrics->average_soc_voltage = metrics.Current.Voltage[1];
-	gpu_metrics->average_gfx_voltage = metrics.Current.Voltage[2];
+	gpu_metrics->average_cpu_voltage = metrics.Average.Voltage[0];
+	gpu_metrics->average_soc_voltage = metrics.Average.Voltage[1];
+	gpu_metrics->average_gfx_voltage = metrics.Average.Voltage[2];
 
-	gpu_metrics->average_cpu_current = metrics.Current.Current[0];
-	gpu_metrics->average_soc_current = metrics.Current.Current[1];
-	gpu_metrics->average_gfx_current = metrics.Current.Current[2];
+	gpu_metrics->average_cpu_current = metrics.Average.Current[0];
+	gpu_metrics->average_soc_current = metrics.Average.Current[1];
+	gpu_metrics->average_gfx_current = metrics.Average.Current[2];
 
 	memcpy(&gpu_metrics->average_core_power[0],
 	       &metrics.Average.CorePower[0],
-- 
2.34.1

