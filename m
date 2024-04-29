Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA8DC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E5D10E988;
	Mon, 29 Apr 2024 15:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="InG9gupW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7102D10E922
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVVVqn5OtQKJEaKNgtX3SSzn3hPEi8+HQrQTBhscIszLIrHj5H5WKeoFwHQf8w5VQUqIJrQ9qVkiJa6dMQEmy089N2oxZyjI70VUgqIXVTfPVG/nl3FW5Cld9BV+byeiHzjDJkqilulxRtZOVgPayqioA2ndbSPS/f41mZYnFougReP8r3HJogNNowS1wavBYhYEcvnq22SrxhsG2ZWReSLUFnWjUKKwNHR0PwXmNHH6xVlsEw/6oGu3nNYFEyzi5Zb9prOrUzqpFlzs6/sWCq/FyYZHmujEhe9F5pVwu36CsBOUXxsMF+01Yr+7iQCqyIh7ilUZKOarIExb6Q5mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhZKVkN7lT+4VWHiavqJcdSAU0MgoQ7RRaeRhTzjNz4=;
 b=RsmbrhAblEhcijNy+OWYk0dNgZfM3gZkplhJJxPELhpGsfinBbVsi5JzYwojv/o90W0iftnC5QdQ14i5D3e0weV3i5hkQtIm0urZUt/h96v4jMCDQ//D6/pC3+pZ+A3NV2qN+HwNxJqFtCHM5MUDdudRUyo/O7dbq7igeQL7dkb/XbUKmHmXvtz/n8n8wwK6UvVf6KfI/Eug7ya6EDcUYo2w7oAFX/wR1J1Bf0St8lnHCEkF7CRAdMIAhxvHtICuJkMsi5VHMk61yX4Jytj8/uYati+saFSAaJa6eaiZJE6tJQMlT/GPhNIo06zTQ+W0qc8dkkH2O+Rb/lYJ3REulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhZKVkN7lT+4VWHiavqJcdSAU0MgoQ7RRaeRhTzjNz4=;
 b=InG9gupWaI8pEEQZvVWiGDFLaL1fYuA2dzbDbpeQ9TVuVHpG8k4GVf9Bj10lckLaMwoE8e1FXjmNzee496dL2usLauDUjAv7c9KH1oY845IGpR7NcqVm3kGHWVIvhuDABLJzngaIG/Gaomg6KEAzZqHW+mDjueQFF0fKfxdjoyA=
Received: from BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:37 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::75) by BL1PR13CA0192.outlook.office365.com
 (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 01/11] drm/amdgpu/mes: add uni_mes fw loading support
Date: Mon, 29 Apr 2024 11:12:09 -0400
Message-ID: <20240429151219.3466531-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: df46816d-6f73-4160-ee95-08dc685ecd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mxp+0udUHkLyEnPQBSxBMC3tTy7eOHiMl9BRbQHyRUljK5CWC0QQdlCpyqmC?=
 =?us-ascii?Q?GBVQRGYWCU5DBJXo5gShWgqZWBop4WsFT5uDZjrU+80bM5bpLTypdW5TONe1?=
 =?us-ascii?Q?ChdEKa+sVBv4wVCBQN7i0MxBPSjO0Pf8iR9tNIbymrBbjqQ5cL8LCQebAgww?=
 =?us-ascii?Q?pzqcp+BgTSVIv2oiVLPsWIls86e/rPjcohWWEw8TwlJ8GxmbNH+eH/t3WkOX?=
 =?us-ascii?Q?3ExcWXrvYEgtDARxqHgF1GwWYHQu5o73FHtWTWzaqD0FofTI7NqA+3R9qGgu?=
 =?us-ascii?Q?HjXMQVC8Sdp8bH/sImUXMttsLZ6Jj4kYPDMGBR+xSXdfdJ58PL3rRRCFVuF7?=
 =?us-ascii?Q?g5y3yWZxWDSr8ShggT1qkkkiwCo+4C9moFpCpzSxTI/3DAyfUiGwp1RS0hxI?=
 =?us-ascii?Q?cfPE9qqiZX03HcmLiqy6wdKwfAVwWlcvp0pv8WhadTI5BW6ROrKO95yRaliM?=
 =?us-ascii?Q?JIjrPTuw6rTpqhw8HahBy1b67/Z3CqCV6xEM35ED8giE6tIGL4/pT0ntZ0Bg?=
 =?us-ascii?Q?pN1RjSvpQ6a/iWRCPxEZDoTa94TmAG/5Yq3trcl1kitjNDXqw94xVn63ssgj?=
 =?us-ascii?Q?S7D3SIpix0oyfojKlfWfaXR6j2zqhB8RQnXDuzoouJfzOeXx5duA8CShDLnc?=
 =?us-ascii?Q?hkLW3u5u88+nF1U1ptqk9AJsQEz9lqYaJIzJNGpQGyKiGJ6LLqHfbchRBMsg?=
 =?us-ascii?Q?BhYKmAov1m8gjBZjhGrnYke1RdyOIH1nGsOp/Mbv+fRNkT0ZDNyS9vftaXFK?=
 =?us-ascii?Q?CSCS9FGa9aqldef6kV3QshL7JE5Oq4dXsoxECXj/9d/2bYc9nEaEgkNbsKD3?=
 =?us-ascii?Q?iHOe03KuCE5nCytGjSWKpWr2e0euMvRb9a187TqJus4mIBw08tZdF1T0NvW3?=
 =?us-ascii?Q?1H6FZI9XPbfAL0nH6qoy3qeABOwnZKx8c7Vr9/wYymX9JVJz6/Kwb1XQU5AY?=
 =?us-ascii?Q?J9Ij2kHg43Pk13LKmRXEZljryBHrtzyCeoLHr0JmDIS0R25b1UptJciDP5an?=
 =?us-ascii?Q?a4XEZq9ipEZ0I8ZXAaMhmyD+bbD172M/9roGkHZ4kifUr3OqR1uc7zHeOkHz?=
 =?us-ascii?Q?HL8cHlQJmVjTMnKuZixA867fs6hjZcq8sjJ8uYnfU/44XQtvyz/vNziAngKL?=
 =?us-ascii?Q?4CfyqxXEHlN/q6g3uwK/553WSOqoynGaa70tc6jD65uLGXPOBaZ+3ym1/o1N?=
 =?us-ascii?Q?yAHg58R8I7HdFKXAAGUf/+z8aNzCibiv4wNd6yQUncD18k6XkCYK15ZjVZck?=
 =?us-ascii?Q?L8KSg5VONw44kijKvW02E36wtLJ3xjfRC82hFSCPjt6kWbAcwy0NdBxeqMov?=
 =?us-ascii?Q?CuW7XGYD7ooYMWLjJXENMLE7tJ2fUl4GuUnVdo2PLCZIt9lSc0bz0uogUdX+?=
 =?us-ascii?Q?LkbXRcYrDKuxIiyyG34LK7bI34VG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:36.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df46816d-6f73-4160-ee95-08dc685ecd6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add the unified mes firmware loading support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3d..c4355d72df02e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1046,6 +1046,7 @@ struct amdgpu_device {
 	/* mes */
 	bool                            enable_mes;
 	bool                            enable_mes_kiq;
+	bool                            enable_uni_mes;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ea06f8be133e0..62edf63285667 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1511,7 +1511,10 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	if (adev->enable_uni_mes && pipe == AMDGPU_MES_SCHED_PIPE) {
+		snprintf(fw_name, sizeof(fw_name),
+			 "amdgpu/%s_uni_mes.bin", ucode_prefix);
+	} else if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
 			 ucode_prefix,
-- 
2.44.0

