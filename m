Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED52CD5BC7
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 14:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39F010E277;
	Tue, 19 Sep 2023 14:17:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D25110E277
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 14:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU6FfxzZM+xVEFklExfTKT29oUqw/of/VN/z90C/6ObnX1SjIXehXPgi1YF7WwP5aAkbuVshXb2bu+e/rKC8IwCUa7dMeYdS+abowgyWIZU5tW5ZamBnHz+EaOwFHGw8f5zGG+MQ17FGD/B6iO9LgqpEllMRSOzZx/UqNIVb8IJmdtJFT2/5KOFdO7GUPTAAPMLywW95sDUaDb//uo8j/s1DcTFh1GQt9zgHrpTSbCvSnzkw+CtbIGOO9XcMcR+6JLLD9PRP90KPf8leg3iQKuKR8GZXYHhaMmdJa8UGBE6cj9Bdn1kdpnPQ5esbopnjwNzq5+HIbl5mx4o4crfijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8F8+ZTRzr86Qt8exuJHD/5Y+Nt/Z0W9641+3a98Y8Q=;
 b=hlDB4at+s6ZezGjBuR06Hb02BWmHqypxwQSXisgZY6IfQz10tve4RM1LpgTsHWufOFUnxtGZRzS7tWwhyRuWdLBtbrMbxJSUPnYRxK8OZp3eN1AP+4+0FHb7i+IqM1YM5zXp9sTtXIIoyjRwOO2Ku3EtDknjZzPjoIrp11nt7ldNgUrUm5cog0Br4kinAW3TeYCGGLfYy2q16gk7szemid79M3L8j4wRMXHmhk2yYGkOLKM68PKiDrNAbIW+ymH5KKgBQRk3w7u5mQa3Te3lPmrifubb4dFD2gmzJRScauzYHDeDActEzsWfG6uq4meSWqHSzhUojitg9E2P0lfjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8F8+ZTRzr86Qt8exuJHD/5Y+Nt/Z0W9641+3a98Y8Q=;
 b=HPadbSi00qdSqUJvENlztqkGUSJ72UP71T3YEStVMe2qZNWcpypAmgkhKUxdK9aJ/gm4FDTBxjLoLwBSIUT6rBX/qrvg1ql14yS4d3UVpaM9PHZB+mSsobqMtnHS3UiBLnxy2tlP6RhV8KfWrKfb1XMxtGjqdpkAThcX6StQ6wA=
Received: from PA7P264CA0449.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::8)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 19 Sep
 2023 14:17:33 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10a6:102:398:cafe::d6) by PA7P264CA0449.outlook.office365.com
 (2603:10a6:102:398::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 14:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 14:17:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 09:17:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3 dGPU
Date: Tue, 19 Sep 2023 10:17:02 -0400
Message-ID: <20230919141702.12654-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230915193409.18822-1-Philip.Yang@amd.com>
References: <20230915193409.18822-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: f26a9f31-bad3-4245-31dc-08dbb91b29a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUSbBRLtp58p5ZCBanrCgoQIPrXgXw4GbI9igurx91qj8cd5Hnp+Q3TRXAeKQkskggsNwRIp/7Ysq/ddbn8VDRIVbMTIfa9RH04qI3YPa0U9KHC9mWKJOlqr5udFEJmcXvxNhRuUMR/NUP4XA4T4NhGR1mzf13noFNWPQrBdLGWU5lcChuRVbLayXb2bKpvV+nHMofe9in/znjSUPJ+D6I59c0vb8ImdTCq5GOIfwUkR1XYExhGBVRSWpF74xgKioOKOoE55EiJXbCjke3g5vYgDSYm7Uon9qBBZtrT9GI+JoLHaKZoWoCzLpz+9tjxgnNhCubCt5J0asht0L05AddYEo2sATZBYE0wKSQ6a3Bkozcb/D1P4tt53O4JaDXKm7WkVXaf7LtVTvcAssTkYQnjOI+I+sO2evocV5Ynxg+TSJ3TQU8fXW4VLY6iftzeKL5XbgQNnDe7NnsNjqsMuiBWvFb/6BQ1T0IM3XG/p1XYy9iuTSSo4+iOjk8aHGmilnvyosZ+886r0mKC3lOC8ZoXHNWUeS5PbVpniVUGTVSg78i9BlShWJxCh9KdGPmecDlwpg+gGDHJRrh8aZ+Y1c4Vp5IBGVKU7YpFboVomu2cYf98xF3TibMZ55gX0ho9jDZwJFKQ9MNjhRy6qQ5CwZt788IjiRhmPbzh8uJtMEaID5l1gdk8tpQDxhBvEf+pK03D/a8fkTPiOy3UgVD6FRw+FuU7qSlWfsekelvMFbU09j9DS+tvVw3jzycLM34o/7k6TBZlYawNX2Zef2Msa4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(36756003)(41300700001)(40460700003)(7696005)(6916009)(6666004)(70206006)(478600001)(2906002)(356005)(316002)(86362001)(54906003)(70586007)(4744005)(5660300002)(2616005)(47076005)(81166007)(1076003)(8936002)(8676002)(26005)(16526019)(83380400001)(4326008)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:17:31.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26a9f31-bad3-4245-31dc-08dbb91b29a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX v9.4.3 dGPU, applications have random timeout failure when XNACK
on, dmesg log has "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
because dGPU mode has 272 cam entries. After increasing IH soft ring
to 512 entries, no more IH soft ring overflow message and application
passed.

Fixes: eb3220ab4793 ("drm/amdgpu: Increase soft IH ring size")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 6c6184f0dbc1..508f02eb0cf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -28,7 +28,7 @@
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
 #define IH_RING_SIZE	(256 * 1024)
-#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
+#define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
 
 struct amdgpu_device;
 struct amdgpu_iv_entry;
-- 
2.35.1

