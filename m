Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0433CCCD184
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 07:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9926A10EB41;
	Fri, 17 Oct 2025 07:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FkqT9aP9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8742610EB3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 07:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdEKe586LwT3bRk0h2GHLMoH/SLEq0aQyFu4QTaLkC75LjetIdC0YKroH5yf1zMGQCNESh/52DffwyxiJv+7Abfckwo1rxG0/EgH1h4N4cixyAvJpasLWJU5yzShrriFZpyI/BYdzNBiB/fsWO1Sl8skgYSnRm2bcYcTNvWYm4flTc/yl8bGeBZO2Zr1GW+Wum5JjVU9inyN3XCI48VtzvUNBtApVzX+2CZEqflqbA0FS4kDWCCvkmfYAV78smeL7MY2Mazm1pZ30bboBkLWqKCLGrcueDhlBLfzhQPddQkeKnYCOjXV5QMgHrHhf1QxOvOPmz3gIXUd5B46sEOttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iOgjeNLgbTfOW1v+hiJDVG1RjPXtn8p+GE3qhRl3z4=;
 b=k8xAzz/TT4OrFz6SwRda7hMTG74nEV0tVTvt3/m5m3hDou1lhVPBb7VReMA0/DeruZqJ7uKPjJaK1gHYlz7DcqS1HKl/ZYTpQ1x1c0nuoFEIL2/gaSTlnyQlrAtfeC9wq2X/3nkXPKD9Xt+LhZLZNnvAor36Jnndjdne24omiuBzSdMa4i6rmjnsc2+66tLZEPvIjuCdJT/17H1c6BbIa4yLjGbuf2kIp9H2QO3KxFFHj5I3OVNKkwSgVF6prMNdhgBNi73M6eAFQfx9aMjjg13goaIGTnJWUWlZZ2OovFL5tsYDdsoJ3SLXgpmAyl2us5Hs7EolKqEHn5L/7fYMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iOgjeNLgbTfOW1v+hiJDVG1RjPXtn8p+GE3qhRl3z4=;
 b=FkqT9aP9baOCZuk009koUSypHK5OgZUayXnpEEKMCTdrQHXOTH1Tji09nHIr5K+4J1aSrFzGbrO75wBtbgDk3462OBSciFnKYfsTIl08MWpvMijVv3vYJg3krbZGizQWzC4L/ef22I956pDScsEeQfunpw4UTTHxhA2xmIIx2e0=
Received: from BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::22)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 07:52:48 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::23) by BN9P222CA0017.outlook.office365.com
 (2603:10b6:408:10c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 07:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 07:52:48 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 00:52:46 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: query block error count of ras module
Date: Fri, 17 Oct 2025 15:51:31 +0800
Message-ID: <20251017075131.23939-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017075131.23939-1-YiPeng.Chai@amd.com>
References: <20251017075131.23939-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 84078648-9947-40b2-9009-08de0d522a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s0gRRMPryN8Zda5JFnNtS9UXkmuEkrZ2BimgTAVkPxX9WWPVZX6dObSsSJrn?=
 =?us-ascii?Q?EN5Un+v47h8mhle5l2hMqR+jp/h0tmrUdq13+tokD7OIu8XQjOVu4ApKJqgg?=
 =?us-ascii?Q?oYY0j/xAv9q5PTAZ4b8htW8iSDxq3edm/uSLJPc0sF8tQXgqs7Ju60s9ZqNb?=
 =?us-ascii?Q?fG42YnfGleI2Gd388fKkeFmPxOFIQdyPVTKwMpUHR/InY64xLeMzeYUBdt3n?=
 =?us-ascii?Q?qijvTdh340NJWSzLoDx3Te3/RDhYFrZsr37B3u69eWaYL+ilOgliLI8DCjWt?=
 =?us-ascii?Q?Lz9z1BsOITqV8vMeNBEMp452MLp8Vq6IUSiQA1JjwIPXLkYBgKqPNsYnE5Im?=
 =?us-ascii?Q?Iosj3DrU/TQRCONh/t+rfba/Tu4qnlOrUgsJGkyBePmdmIkWT/6rFNd803+f?=
 =?us-ascii?Q?OyJuBWVFb9FBS0NsdT/PR7t7c1ud5y6YxXH0DcmcvMfa7mVj8waeFnt/HGqe?=
 =?us-ascii?Q?9qIX7UEpWrrxre/la5/HW9JTpx+c4QJ5P1QUtm5jOI+6ysF6huWLssXB6x/x?=
 =?us-ascii?Q?1EfUFzmbQgLV+weqV5wDybh5QisIB6JYMH/VfWEnz8/UzujoWS3e5k5Lcb8+?=
 =?us-ascii?Q?BDBY4PpcdIOPMV1Vrs+mqCx+mToYFLjVsl9PuGV+h3wvO9bkOLRHNhnWuvxc?=
 =?us-ascii?Q?wDMBrKqpPaZnqmmnQUpg3rkhg53tfy30e3jxKs8LkSaaeWmxP1WJ+uBM4/Lp?=
 =?us-ascii?Q?3m2OrydUFMInP7J81n5vHM4tOpoxvmdl/0anCvsyb+WBlQVZSXDT48Kl5EJL?=
 =?us-ascii?Q?x3+aSdSr20/J3PIrlZtK/dkJ5pXJNGCs57jEnGeRgdrI4cPVWYKL1qfEqhEo?=
 =?us-ascii?Q?1IeWEMeCAliI0Qg2X+3DIMVMQt1OLEIemwfKKF3lpVSS3001lxBAemrqeFid?=
 =?us-ascii?Q?TXi/9Irde84jPfvyS5K8giUL36i3LD3jYTeMgnDNLI3cW8z3N/VWD1a3n4vJ?=
 =?us-ascii?Q?LkUerDf36jJcqgGMYAB4XrngAQ28SfKdqgQgz2kg4bfeM+AbQQk0qX3UuQjA?=
 =?us-ascii?Q?cafWRnMpJqy9cQaEwwQlhtN0HIXqI95pL4l9hr8HxWrRY2Sh84VGQyBe1nkg?=
 =?us-ascii?Q?wQAOMcoeJHydlywCeAoz5JZIhSwhSMMuitFVLYkNh2/MVCoubobMuQ+QKKdN?=
 =?us-ascii?Q?RAk0djtWWDmeMuKwI2GeQFY0hnGaqYqMK//5SLxVjoYNO/5hhrVrKgBAWiT7?=
 =?us-ascii?Q?HKbcIpL9bZMcIm+LErBKUcmchdSrgQKDLdUAaVRNkaM3fO4BA5Jj9dbuzfWd?=
 =?us-ascii?Q?zx6vkY2CFDaMNW7r+CuuTMPiQea7BSnkc+brhTduFh0ICP3qXy8g8bTuEUZ8?=
 =?us-ascii?Q?H4sMwZI7LaEf3EBzbyGLaeycwsH5oxR0l4KeuDeL6RebqgIqCM9coWMqiMCS?=
 =?us-ascii?Q?ThjNAVwFoqB3GKY3gnBbucSpXZe1Qiq5vwmfzgsW8p/tBRDeQd89x/wVUzcu?=
 =?us-ascii?Q?vrtsNn+M93rnAwhIhdi3ilPDPcnaf5BRS1Lsi7DnbzUDrK57khNDNzQtgnBj?=
 =?us-ascii?Q?Y+P+C1/t/1NcwT+aU+wlIPozvjH9Q2JciawXWUDHTnvw6/1a2/R9XYMRrIlM?=
 =?us-ascii?Q?074fseIkLzkA3qyR9WM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:52:48.5877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84078648-9947-40b2-9009-08de0d522a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

Query block error count of ras module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 ++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5d5e1c0154b2..3150d736a4e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1543,9 +1543,36 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_uniras_query_block_ecc(struct amdgpu_device *adev,
+			struct ras_query_if *info)
+{
+	struct ras_cmd_block_ecc_info_req req = {0};
+	struct ras_cmd_block_ecc_info_rsp rsp = {0};
+	int ret;
+
+	if (!info)
+		return -EINVAL;
+
+	req.block_id = info->head.block;
+	req.subblock_id = info->head.sub_block_index;
+
+	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BLOCK_ECC_STATUS,
+				&req, sizeof(req), &rsp, sizeof(rsp));
+	if (!ret) {
+		info->ce_count = rsp.ce_count;
+		info->ue_count = rsp.ue_count;
+		info->de_count = rsp.de_count;
+	}
+
+	return ret;
+}
+
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_if *info)
 {
-	return amdgpu_ras_query_error_status_with_event(adev, info, RAS_EVENT_TYPE_INVALID);
+	if (amdgpu_uniras_enabled(adev))
+		return amdgpu_uniras_query_block_ecc(adev, info);
+	else
+		return amdgpu_ras_query_error_status_with_event(adev, info, RAS_EVENT_TYPE_INVALID);
 }
 
 int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
-- 
2.34.1

