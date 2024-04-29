Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A9FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2591C10E37F;
	Mon, 29 Apr 2024 14:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgSvDveC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD8E10E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFKS5rtHzfM3rnxeOHdQspH4pf1L52rbyTcFIl4MSs/CLsx68eBghCAs7pa7VPDtakBy8f9Vo56q6TNsYPcpn/kyUnGFYdRvxG31Bteh1CGg3MXNqW96MmJ0XtRiMuhMSsDjqA4A28h7HU7aStKvNvnh4ljTEieAUsm4H6/QYZFer7NLaE+KugOlF4DE5sh68aUu0uR32IyBjtEDYdkyjSG7A7KK7slImXO39wm96jU/g9mguS+UkGiNLG4TMx58HGdtvFJUTuPPJZimluIvfQofezpIk36P+jlpIts++OyvpzBKYNSD1g4EGy9oz6CILRQpKZI/snrOJEWeth03vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+PYHAJ3mFBdUsOZfOzOfuJ4Vkd/N1ATNmcSNGUlxD0=;
 b=kbW+8qeHuCSr2R51VXfpww+GpO94pqZrOtadvBv51TJY03hs58tlLdHspSBOQpT4mOxP4WUU3DD5uaD0JlSqJestoLvNfpwzJhwiT0/caIDcBLr5vDR71XB849cht3e1dxidBs2lDgiRVHeP5+ApJK379o6l4Vib4oGTJ9ggbyvjcgHp7ksquiyOAR251Ugi+LJt3KaQHBNCmzJmyZVAH/MuScbGn3qSn0qtDVoVoB/rFT1/qukFjJfvnNDfd/LCHub2JSQRe9YVinC/egR0MNlZ88abTtxUNQV9vSHJiW7/Xi7vvLARLDeZqYO5v89QK2LriPSOqju/NWqYrW6VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+PYHAJ3mFBdUsOZfOzOfuJ4Vkd/N1ATNmcSNGUlxD0=;
 b=dgSvDveCkr4hWTsETbtgPdqQehroCwd4+xdS3z3ATCux7xofBfeJjfzzcxgg62tvQyv9kIR4lj/XbNPjvdWtwdzvE5C+tDWEjtY8wOXuDvzg2wk9+nbKgC+TqX83wkxHWC9sMw5wrjH0M4D9gKHOV97UsEnteJ45hX5IM7pQTUo=
Received: from SJ0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:a03:39c::11)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:04 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::47) by SJ0PR03CA0336.outlook.office365.com
 (2603:10b6:a03:39c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 04/31] drm/amdgpu: add new TOC structure
Date: Mon, 29 Apr 2024 10:33:12 -0400
Message-ID: <20240429143339.3450256-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a7c223-f02f-4a75-32cb-08dc68596b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2a7CoimTcf4mv3vg/7OB7vuovli4TRzS4cz+4G6IyWl7mzYmdA/grcexdIU0?=
 =?us-ascii?Q?PolwCSqsnAfVjDSwN4H6HEi6x47aFWpAss6dOQVqBEj+xR7ylufzsiWXQhYK?=
 =?us-ascii?Q?KVDbwzPontpp87Ac34ciZRWdMvfUAKlbqXwoYSYVyM8z44gEswDh1HBIHnzn?=
 =?us-ascii?Q?JKLTRWYkqqLpAYRQCWoa4X6Xw7XcS87U9kuBX7F5qCWUB+llf77kWreHSnLa?=
 =?us-ascii?Q?XlUOTcy8yklVUyy/QUFUu9UTDzuBz0Ex2e6jGG3DTm2licMdVM/ujhPoPi5N?=
 =?us-ascii?Q?dMhZtggmP749erkrEZdOM4ybQ0Okgnk6UjM/7Z3ckO5Rzxwk7VijfgbTrNGO?=
 =?us-ascii?Q?u5PP62wXdqq2OMuNtFQbEWaN6t3jmA3NfBb+KfsS3n35WkvC9P21ZSn35Ge9?=
 =?us-ascii?Q?2z0JrJnQe43bZG9TIcyAZnCI33fyuIRGer9wZIH087xmRBOtcRiGN3m2iufz?=
 =?us-ascii?Q?uF8CL13F3/CFPCuAXT0qG8ir/DeUj6bz7ZEoInAHsEx4wmwug3I2W2kUuxAI?=
 =?us-ascii?Q?zHGx9iEMUTAs4DUjSZxXNfoD6PhNWnoSOi9+0/OrloP+67/Z28qtpmeUY/3w?=
 =?us-ascii?Q?qTp6XbwR87gsloeSZPh4xZmbm3CqdkXYLj4bDnxcI5mC4DGmsDXkzPqFSZzA?=
 =?us-ascii?Q?Qo9OQMoh4M+bDO8w7nhm2Fda3h2jg6DXdd1cfed25pVPge6FC9AdhRvHBlRD?=
 =?us-ascii?Q?nGDLsNL9wPk/IkGiFNyDFicEdkzsdQNoFX3A+SsXE54CEk9uoirb/vsV2AIC?=
 =?us-ascii?Q?kCcd1PSqA0+a8r3MbFocgJVaLhzPF0pUbRxmltbtnjGMo47cLXjT3IKxKzBT?=
 =?us-ascii?Q?j9Opowv95oXYZGazVZUq5GKgKvn7MwPnvk3RuQE5Tzk+86BAR88yd0N+sZUn?=
 =?us-ascii?Q?E4UNOSj22FWhx+RugeVY9qVFlobnfBQ6lfWEc/5zkd+KVjNAuHYoskcQAsr/?=
 =?us-ascii?Q?uxNSJUXo8xARY8wpPfaD9lhPNRo0gejpZuWZ2pxGB7YbnMSomvOP8NTDLB5z?=
 =?us-ascii?Q?ZD6tuSTPh1oNpB4+IeNKjfYVEDEVHQbpi5DoxToni7aHaOKTanU++75rMHr4?=
 =?us-ascii?Q?W34UW7wi0k9Q5fQxqZH0uoEPBkahkRV2F7ZxDqpd3/e4Jxf1gO9ZYlKuA58U?=
 =?us-ascii?Q?Z3lCm257+WEziV11CovXa2jWsOohqjaAzyLHIhDBORLM4NB79N3NonPdtqcx?=
 =?us-ascii?Q?RZ8MeFql6n+l+wkM6mpTZceXttZ47WoCrYqnZRF+IFKjqzcpOmM+B3mmuXB9?=
 =?us-ascii?Q?wXbBCrk1j0BW3B5HteK5WmkASLRphBPdByDjvuXvddCy5ul6Pqa7aDoaUuKr?=
 =?us-ascii?Q?UhWJ8or4bwqEu3YhCp3sRSGqYOqsMYn3sX/3lEh+ti5Dk7AKFqstxv5p++Ol?=
 =?us-ascii?Q?gpZRCo+RWUO843ED/RIsmWJC4ABv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:04.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a7c223-f02f-4a75-32cb-08dc68596b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

From: Likun Gao <Likun.Gao@amd.com>

Add new RLC_TABLE_OF_CONTENT structure definition.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 5a17e0ff2ab89..0614de6c122cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -155,6 +155,33 @@ typedef struct _RLC_TABLE_OF_CONTENT {
 	};
 } RLC_TABLE_OF_CONTENT;
 
+typedef struct _RLC_TABLE_OF_CONTENT_V2 {
+	union {
+		unsigned int    DW0;
+		struct {
+			uint32_t offset         : 25;
+			uint32_t id             : 7;
+		};
+	};
+
+	union {
+		unsigned int    DW1;
+		struct {
+			uint32_t reserved0              : 1;
+			uint32_t reserved1              : 1;
+			uint32_t reserved2              : 1;
+			uint32_t memory_destination     : 2;
+			uint32_t vfflr_image_code       : 4;
+			uint32_t reserved9              : 1;
+			uint32_t reserved10             : 1;
+			uint32_t reserved11             : 1;
+			uint32_t size_x16               : 1;
+			uint32_t reserved13             : 1;
+			uint32_t size                   : 18;
+		};
+	};
+} RLC_TABLE_OF_CONTENT_V2;
+
 #define RLC_TOC_MAX_SIZE		64
 
 struct amdgpu_rlc_funcs {
-- 
2.44.0

