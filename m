Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF128CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 20:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7FD10E12A;
	Wed, 20 May 2026 20:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ba44dgxH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8463410E12A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 20:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGETN3R/6gbDSz/TJoU3ErTGRFBnwCwrD7mU56H65rtdGHK/zFUqdibTNFHu6otjm0NA7u14ZUhBlCRMmW0HT2tDaNuVWj0s6svIpaq078qM3a3jAVZjRrxUTykJ7E9ficoVBlzNp/tOScQfCqKdQ5WyUumfQgZhvwtjDI2FalRj/PkU3o2B2AEFfo2pvl3oJiA2RgLvRbXt0R3A/F90asxVMpupkQbiU3m0Xd/b0CEwC4eCj4Q/60iWd0x21VIg5sunLf7nlvErwACo5BCXpn3eQMRihKx19ckGUgNxyBoc8/5bhVnR0md9YvEcjaupthlGE+UGaBi8ej0ESNi/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPT46K6zxjpR4D7wkwTA+VXZVlEiGASUJceTGeDT6wM=;
 b=cX6oH3liVrse5VfcM8v2oimepvZviVdrfMH9PzctUdVKP+ospn/fpKfDdiTvuSoJfvFSURnY7Yq1frrmT5VE5Lu2VjjQT0P+DCdz2kBoggq/kAsWmeq3TN+aNIMfyfnN0N4dSIhwWiKlmQylaJeiLT2QKLe8oPjfduX0cmnxp4DQmjwmmXC5/hEpYeScj8ivKaSdcfPzLGESwr1j/t3Y83VGLqFb0ipgCvCK1C4SYJlYTfXDwjoLqnHXNrDkBSCJemnJHCdNpHzAKBdZVZ6ghi16kD084jCdCFK8ls6NwxURbTAP0heAMYxUK+BRpQkVGz6WngcDf2rzVrrBN9en1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPT46K6zxjpR4D7wkwTA+VXZVlEiGASUJceTGeDT6wM=;
 b=ba44dgxHn/SZGQzYjVj7XfJT5Iy73IxffPPFpfXiLs6XDcQbQHgSt+iKmJN5TeNn+cHb40LXgHPGMDk/XqMdfVKVWgGK5lZ24uGVGOzoiQhJtntAskwfA+0Osipb+Vi4oj1Yr1OaYDZWvRxO9Gy/GYOGrq3GulA0ixtxoXpci70=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 20:29:35 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::8e) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:29:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 15:29:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 13:29:33 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 15:29:33 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v6 01/15] drm/amd/display: Initialize dsc_caps to 0
Date: Wed, 20 May 2026 16:29:14 -0400
Message-ID: <20260520202929.555119-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520202929.555119-1-harry.wentland@amd.com>
References: <20260520202929.555119-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 450afa13-d086-4ddd-ad00-08deb6ae8173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: VuAMPhhvdwgI6LryF9gODj5u30VOGwsXu2sPBJ71RSe5LbgINbGmalNqLDQbCVH98NCI31/UMQaPQMN7KMQ6swZkbiXN6SFVaYGiEii8hwZqwzmluBZVDUNprvqxbhYEcG/nLKYR72du60NtzT8XFkXiKY3xUVUPYm48jrIAj01+7PJAHDoizVFCk57g8iVAlY70Yn3SFanxLuv2i8nqUUiVxDVGZvqBI+v+1lvz4LKmeP9/SkScZNuUS1iNyBg7t/ul9AUhLW+iTmmJ7LLjjR9f7B6xTZcxrEgBPce61Ht4NasCUs1Eo/CwMCI0GI+ZT0rmR/kIoLQcq4+jsutjbkUSYX6JA66Mpbo869rA/M4Hc1E10uRuxSUKbTh1yV72nHRDqd6NRU5T12BIl3W0GiCvIRGdQOGn7IUdGLgPlbFPzqg2u+cPkOXJD5BRHnVbe1xA5TYFwSkmgZ0UIeJAW1zwf3cEw31SmstUPouROlorbIbMDODsYUPn4sZsWk2bF80vJ9BFjjxjJvJjSPyZKtQHTxKtEG41mo1x/rhghQeWEE41GM37KuaUr4Zq5wH59Be3k2X+KwJ+YY1CDywPLQpKvvSQSwTcPQh/SfMHkglDQWva3cBErjgByy3XsbZlIRklL00ZON5cSY2qGaT/kKvqaVMw2k4SlmdOvBxSdfEzusz0N8sJ3aJyuz7AQ9ptLGaRSIQq6DSSmWC2VpdPEJMbL5J9HAD0b9jD43vQxUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H9g2FV7FpMzZ1liVMvgzzvTL49BOzQ7glvFtVf2i4OZOH9wbvNB1yYUK18pLqpzryx9MhVq28wvrLK2cAqueQC3MdTRIMZn3+DlwuuEVqTQjasXo5ucN4chGHMqMoXDgc8Mwjnls11NaWAdDgHwQZHKjoJAUi8BpHnKJnJuwi0/QPdm/dM9jRA4M/k52oo1BAbHve1m1GT/3gFHu30kgbxaAbtDBPKTC+lFCA+TYp/J4CFYSKUBnks7kxK4gQ5QlTF+n/4KoCp7PXVwTrsRvmo3LTHvROa3EZPCy6IEWBrpAhPtNv0bUppX6yIVcQ/m08H0p+Is8/p1DCjQQM2wSUG1Aau0sWni/a+h9gByb6nThP9YfqSAkX8GaTl92ChJyTdENuIrkkTEjTcJRqdxTqGs3xvmdtnNSnb/U/VrUmOe0xEUB/NB8ZsBYP+tUccXH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:29:34.4985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450afa13-d086-4ddd-ad00-08deb6ae8173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
If we don't do that we make DSC decisions based on random
inputs, which might result in disallowing DSC when the
monitor and HW support it.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af0af7519517..d6eba4c37647 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7469,7 +7469,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	int preferred_refresh = 0;
 	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 #if defined(CONFIG_DRM_AMD_DC_FP)
-	struct dsc_dec_dpcd_caps dsc_caps;
+	struct dsc_dec_dpcd_caps dsc_caps = {0};
 #endif
 	struct dc_link *link = NULL;
 	struct dc_sink *sink = NULL;
-- 
2.54.0

