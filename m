Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCFCC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA1B10E98A;
	Fri, 25 Apr 2025 18:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HNXlMGTj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2968710E33A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbhEyz/lTjFUyejXYxZb+OyLEh0CowojJ1j2NSnYlft3j9C/nvU5cJU82zddRjvTX0d3pFjSFqWMf/Qeo8JTnAStLNpjEVKwPsc9eapiqskj5u7+J9dmdb6va5lDbULo55vBW1nwGEohSi2hwS+HgdfBOmQeITzOn5kbNDa1vqjozUvU7aGJ7GVw3SnMFavmXpNyImu2Qu3L1m65UDoOZL4ZF1OzdU4H28WLQWz4KLDfTktY4lu376zudKxZUpxSCfMtkNFf7Xr6moa4mJlJOsswLmo6smneNP169y2PFkw+VDyl9L4zo4EcXxJyladJlToZVnGA/K83LX4M1TLNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM4TFGum+T8C7zi/HBEbTC6LXVz/QfX3UdHkUkW4l38=;
 b=F4a4J0uwjemXuLBo+gStvrmgTXew+iyV9QvHeuiJhEQvFEasnQD+6NG5KPLhDbPsjIqIDvYa55aBUIABtC5dm6EijeiVtulIjDoH3OKrB3nkDl7hKFWKPlmIuo1wsSn7v9wFTMXmbWBN2DiQb+yoA474DthefnXjsfi/X+76U00XO1k0vmz2Q4eH3xehilk+cD3LONORCxk7eDvvUcVXo881NJy/jltdEHdhuE4b4YKXUIQE/1X3pg+LB6E260S4Vbwr02FV8zvtRI68mEbI7IuFxJglkvQrcfd/rJ+G4VdvDzeWNpQCtt2Bw22cRoYQvZLuaGaRCV0vYCXDJNgjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM4TFGum+T8C7zi/HBEbTC6LXVz/QfX3UdHkUkW4l38=;
 b=HNXlMGTj4DHO64Fk+vzrX7HWrKCfj1qXCUOKb+bInok3Hnk5TRIijWI/P7KDZn0ySKqF+2k8bd4CZV9RYQuNfIQtyiBe3If+4c3XV2cEU4iHmKQF8wryBRZnipDHDCRPM7uXsr0bfgwwZsD52drjq9RCzA/Ai0JNgC3TcOQujuY=
Received: from DS7PR03CA0308.namprd03.prod.outlook.com (2603:10b6:8:2b::31) by
 DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 18:39:13 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::d8) by DS7PR03CA0308.outlook.office365.com
 (2603:10b6:8:2b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 25 Apr 2025 18:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 25 Apr 2025 14:38:54 -0400
Message-ID: <20250425183855.165199-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 059af430-ac8b-41f7-7262-08dd8428797f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eoshwKXS+zYfvP8ghikWktn85f1fbNoAzHbU9XpIjZ0Xv3WbhDwdIo2HZJac?=
 =?us-ascii?Q?W+2p6x3Ox3iP2D3Rcd3UH7FtQzAPrp5EwPplKqxwSmeWFsbJMnhHJznV4vKv?=
 =?us-ascii?Q?TSFUM7MhR6pj5Lh4t7K/NMFDRKXVl3lxlTISnImS50waQu2XX+oc30gmZUW9?=
 =?us-ascii?Q?4+M/LqYevuuaLEQzqfneurxGx1kwGeBT+mHBSamu0pzo3IB9dggch7x8bPHw?=
 =?us-ascii?Q?pm/euXu7QYs55spqJdeHZ61XSGWTeaMdaBHJwUpf1F09SS/g4wG8/WB6HpKG?=
 =?us-ascii?Q?SHQYFxDK1/e7698LyUGKDC+IE1w+M2PpiWe+d/ceE6YElM449e4nMRqEyqoW?=
 =?us-ascii?Q?xhTaArrRMmppxgi2SFzwIqY47Xq6ql9FqU9bnqFrNmNeznArgwxacRpHy9Bg?=
 =?us-ascii?Q?nVXLaQlSmWcfaTqoxmGLGdx2B/2dW04PUuoV67oD3xzg/VbppynRheyrjETI?=
 =?us-ascii?Q?jj+dfpUa1SCLvzIfGXsDi71CAn+HLcuqGo6wdxIDBxJtq1M50TpaQ3m9jlGF?=
 =?us-ascii?Q?U7iiH2pRBP6LhilTOs8Jg15eFKqKQV0QpxXtmnL+mnaplqTKMlNWnJ9J//2p?=
 =?us-ascii?Q?iXxM8KaceuPbUGPelwHfR4RCawcsXiTd1Jg24WcgerG2MG9CO/7N8owHoe04?=
 =?us-ascii?Q?S+QSWtUjKTUINwqHbLBu6NtY8OTmd/7R0Aq+iFZO0qQ5yxTQ39kwxzL7iB1h?=
 =?us-ascii?Q?m7++KAS7bvlw1Oxki83JRQaMyUR5sSdmODZXCqyaJvaOy9LOQHh823wSsYeo?=
 =?us-ascii?Q?r6ppaUO/sVrLzzjjr5+CHZmByqnYtqFPrPEjcah+vgfC+HfWDLYxUc9FlBiS?=
 =?us-ascii?Q?x5INBypjCJ/+yQrxcuw8+7G0fygDv4ChqYrlFdAiNVh+DC7Q0zPM+29YMu/W?=
 =?us-ascii?Q?MUfqBjJrrLPoCoDNRIsQSJ8O42FuVkcoCb24nAcRIAjSvFxpcRzYDtu2Mns8?=
 =?us-ascii?Q?EW8cG7UReMz6HR6HlLnArQRZPZKWlDM2/0QhtLUcJznr73jkWpVeLWDHWz4M?=
 =?us-ascii?Q?d3OUGtvnAOLE1/9IfDPC1sHCsYRQ+wgdWiaPMP1Kb33g8rZhQL8E45Y4wZnD?=
 =?us-ascii?Q?ZQHDXIR1SHnuS8b5z/0jtWKbe6wQOiMv+MRAnFV+K4hDxaWxz+rlaqojO1JX?=
 =?us-ascii?Q?pbAOJiu//khzxenZHUHvxBlZloMrAPrt0i3hBBYTG74HgCjSd5RNvUvSs3Bq?=
 =?us-ascii?Q?8wWi3C7RXZlrsJ2WvPijOzVtX5O9DNVpqKS8UAGp+fZ0KCo4dNRIXB9RMPTD?=
 =?us-ascii?Q?WjFULbQP8xjAwcKjtOxq6az4PVQ9H5x2Cwo1oj+1vqCzaOwMERIckv3Ycr1Z?=
 =?us-ascii?Q?LmqixqfGlUNy/4j/TzefgeooLnrRkVN1EJgWoINg+EDUO96YqLtTqcc9hsix?=
 =?us-ascii?Q?hTdePawTnI0BdXtt6bepWwKk5yqvdRrrHTfHvAcVQpghI9lXZcQcNMxoOeyh?=
 =?us-ascii?Q?0oROHqrFD64rSamCEAOZuMwBSFwKmBt3euKo32LM+oCt8P+OiA2Swg738QVr?=
 =?us-ascii?Q?bHuIPfLrv8C5+65TaY5sjh0+5Pi+Jbj/+MrY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:12.7652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059af430-ac8b-41f7-7262-08dd8428797f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1fd96474e64c0..56f052a10ff38 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.49.0

