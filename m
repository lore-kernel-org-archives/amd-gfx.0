Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C01AC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3846510E86F;
	Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E161510E466
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4FADu/UV3/7WgFnUkFwGD4b8v1OiKTVW2DGZTdu5T2qJrFHRuh3ymes1Q84lq3qDQ/QhlUsiazfLx9AGohYYWoheLit6pz0LCg5zk1euWOG6mtqVE8zbTWAUXw4IUMD0o/mtXKnYFiUp/z+JUxCuAvh63LAyPcp8ovZrqDCFja1gWyi+r3kNnOk3a7jcpCzXLyHeI44ORcYOjW/47FapMG5x/y/+vP+Hck6bWE1KBsUrC6ytKevhiwtdDK3uNs8G4NVoTKmPh3y/GBZBAo/TwQOX1f8zGAyL++51Z9lMcwIU2FmnLAX1kTaWZxinVlKZLsJTEn0rFawOn9ICGEJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/7bgw1NXjzqFKfexCyT8nZhhS1Q2JP642UUcRg3jyg=;
 b=G5GJWt0BvKc/zu8ljABguORmA8pgbzReDK+0TJL4GwtgXHkYzHuvZGbwn/OEdKwd1hA6Ebp7wuL6RjK/T2+nztX5RX66sor2hVOqxyzJUBiq2aShitxw96Y0GNbQP3YvBdsS35ClwJn7GItxKBQYztEg3zTFFJlYElg8jaKX7pyksI8EyROVDHhUFtoyYbUXkBqbKhqVbsilggal68b3IRkzFpEo24LfDkT52W1pRSXsV4rHnmhdkrGLsTE91gxczekmwkqLINoCfRaGJq6VsQmGv/ATWhkbfl0c9GWUrMJjuPeDRa7Bh1VmLMj3Y1H6dnD8S2zjzh5CNwPLGXHAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/7bgw1NXjzqFKfexCyT8nZhhS1Q2JP642UUcRg3jyg=;
 b=wwLbiMo5aRJGWB2HYyMvv1vlXZnf8ufNQVmAEpapy5gxi1sOuIWstzTZwpXlr+N2EeDYLR/+zuhe8Ixb/wQHeD6ykwbdlTFLab6R4wmckX+CJM1VUL2MacQpbthA9cmIx9nacWStJDXo0a9HLw1a+rZ8xOsSKcdRrtDZnJ0Fslo=
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:12 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ed) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:11 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:06 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/24] drm/amd/display: Basic support with device ID
Date: Sun, 23 Jan 2022 13:20:10 -0500
Message-ID: <20220123182021.4154032-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7399e981-59e3-4caa-550b-08d9de9d2285
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB505327FA4AD1348FEDC5BD9C985D9@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ywmh8X2HRt68uVpWsDh8zOaBWM84XT9gnAUa8yMQ4t0gs92QQxwmT0KxwgNiVzDttx7N/017jid5yc2NhwUb/m33UwpFzUGx/S7QH8zlqBpS5N1L3TLXKm/jUxI0mI/okXVDROdhqpn1n3khaZsxqegPMQG8Ie+JojV4xaRXEnljzoRrwbvsM+pRsTQX3DgY13rTonme/vZv0g8g9Afljk5quXjkQs/BEjQkeUxp4U70ZxDSNbSZ0kQPgoMfd977lXuVBMUy0Y7G+b3Gm5yF33lan/cmrGfKmugOw8ve3eoGX6EYdq1iuA6l/WOLfRuR9pfFxQdv2Cw4WgtPiZFLQzvPGo4aQA+AxAyY4Pjc9fUmw3nWO4R/UmDpBsXOkimX8QA8BK5ct+UI7JHBJaho5KKyLGQiJIcXGtfyx9vAkKpLmHKI90lMF2AT4s00PMWJrgeMwYyLy0G8z7etKNrvXpW/pSXz8RgkX9DgqF1ILOIwBFfv8cDofRfaygt/08dSmKUX7IfFrnYaHFlysaV+IJ4XDBLTSt5rIk+o1ZNSEFa82pTQS9YYyTvC5IpKr/x0Jof+U0BtDqRz+IwDCRiycJRqLldfWLeMVrmVhF3yPPbHk9MRzZeFafa0iqBO4g6ftrtNnCF55jvCZt/ORnjn+HJ9dGZyjeWobg+621slrArz9vvfm7xZRahVv9/pbHndOc5dOXEVmOD3i3S+uK3QgYAAirvnnTAzJUigwqzTSdNp5myKdeHFKcADbMsqcPY129qvRencbQp/5JpcFBDxwi2XEE76ExFeFzQvSDR1BE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(86362001)(26005)(8936002)(8676002)(6666004)(82310400004)(6916009)(2906002)(83380400001)(81166007)(356005)(47076005)(316002)(36756003)(5660300002)(2616005)(40460700003)(36860700001)(336012)(70586007)(70206006)(1076003)(508600001)(54906003)(4326008)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:11.9562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7399e981-59e3-4caa-550b-08d9de9d2285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Need to add Cyan Skillfish support by adding the correct Device ID

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3aa6d347d73c..5642f93a7c76 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -131,7 +131,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+
+		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_1400) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..707abe96f928 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -255,6 +255,8 @@ enum {
 #define DEVICE_ID_TEMASH_9839 0x9839
 #define DEVICE_ID_TEMASH_983D 0x983D
 
+#define DEVICE_ID_NV_NAVI10_LITE_P_1400			0x1400 // CYAN_SKILLFISH
+
 /* RENOIR */
 #define DEVICE_ID_RENOIR_1636 0x1636
 
-- 
2.25.1

