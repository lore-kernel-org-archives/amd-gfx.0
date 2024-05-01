Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E1C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC201130B1;
	Wed,  1 May 2024 07:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFpcV2Ym";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7861130B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACPztoB2GY67t+8qaUSHhXwGuA8R+cDJRHwJ8CUGGntGeJVN3+3H5CCFF7dh23T8uR8G/usBzMpw2EbQHd2kdx9E9pydOG2OzjEKl+ppMirrgxAzFxEu+6YzROMhD1jPmuQVAeDMmWCwr7o/FuhHX3qOCPFLUHTGwKBN15kLthlBq3+UuBGVqTltdEaf1eraqPSjBnYZtIk3pSnZ4gt2cMF5ugo8kgDgkJBQZ4mmUT3Xw5Gl095dWW60YhIxZRPCR9LAjXAnKGzEYtOjBU2xxrgi/cJ8t/eC/Jymt8N7vnKRkLKF4VdauLsSx5/UEOxtM8JvAMVuNh1n6V1qxWdRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wXqr7SRFbDGU0qX5a93EbPaCj8JAWYWTnvCH5wA5F4=;
 b=OVH2yiV8hG90uEgQapJ3OzrVB6hSWEkQ88LBb5kir9FrKrZ4qENj5NhsvCSCRFlKcpBm2ppcxeLsKtpSDuPFeFb29qgitFiRP67AmzUArkHmGvKD2tYHZVnK+E6NFp8SFg1xXWOgroh2mVq52RqIT6ihDgK6942UqqDw9MuvW+zr+o86SKVH644P9FAyULqHGaShMbwvOeouFj1bqOG9mBWzi7N7m/8ZS+p312HmtChXuhwULt9QDX67sTYILq1FRdK8DBQ1lfHMVDC1brRvb5mDB2ZUi8hTOH0gshQ/iuosMrdg9FKvRb4ZlUDkKVHsdYKr1OfgVvWbc/PKAFfJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wXqr7SRFbDGU0qX5a93EbPaCj8JAWYWTnvCH5wA5F4=;
 b=ZFpcV2YmpdKMuipR8fOysKT4KGlMTMj+HwWtoLLmJdwo4cppkjSlts4Zxt638InlqJP+aC8pGNxUTb8IGAYa5SWbBbVKmevvDgdoD5PeUa2xWh04n3WvI5haWTbGc475X4zPKKToyEP+MvfCNkb22EnJTrmQ4MTKJ7zmOR+BM0A=
Received: from CH0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:610:e5::12)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:17:20 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::42) by CH0PR03CA0247.outlook.office365.com
 (2603:10b6:610:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:18 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 05/45] drm/amd/display: remove panel replay initialization for
 DCN316
Date: Wed, 1 May 2024 15:16:11 +0800
Message-ID: <20240501071651.3541919-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 363e46af-3563-44e6-d2ae-08dc69aebd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QPkkdbVDSZXlvzoYBZ2d5QY31zZ+GhP+dMgWptNYW/1RZ1R/vsOfySaBmcpL?=
 =?us-ascii?Q?sWptgegb+V5l2//0IRPSq+rnppwyFuBBKmj1R8HbT/rw1nsx0ls8J9FJQRMw?=
 =?us-ascii?Q?BWyyOd5P5X8EOxt2gYCsFWn9AgaOOaSi2ieMgXZWpGH4BPaQEbG+2tPETrLa?=
 =?us-ascii?Q?5JtG+1RxnXgCU5VRbr7dmDPsJsBYfep+g/vA1Y/1awHSLtBfLsoo/I6LtdAc?=
 =?us-ascii?Q?oQ8r08yFqy5bwC+B/jxgEWGDe4x7zR9V39qOH5ExQoSj7eFaPSL0JwAd8Jgo?=
 =?us-ascii?Q?Ow/kfEZLI4xa5o2wYZL1WUeCl4JtTa1R9lBMLN0HHbrgA+g231vFI0jH+Uyl?=
 =?us-ascii?Q?oMd2yCbZK3Cl2L0EEGdtU4ZzEyp1ov70unyzZJd9WMWxsiazfsCF+3w3LyYr?=
 =?us-ascii?Q?5bpE7VZociH77G9FZh1lIJGcyf0uFfGY92rFqVj7UDgQ9Y/x4F21o+Aj+pIX?=
 =?us-ascii?Q?eopZFKfMyx4k9dqnXYy7eZo2AtN3RFieO/4n5GjXR4F+Yw9OYK2ho4/e36wZ?=
 =?us-ascii?Q?9tF7K9aBMOV0gRyPDSKNXlU3VN9Kl8+XaYL6CqFLhGPWuFYcKGSLZA+/z/dO?=
 =?us-ascii?Q?VaZjUwpmmwmfAUHGy6P+azCavtS1d2hgQYAnGnD6m5xQ53SWm+OlVZaB7dy+?=
 =?us-ascii?Q?MwvBeQFCcB1qCXq9W4DRp9DQ7aUF6+A1F6VG/WW2A4VND1mapbwIKoRtdl83?=
 =?us-ascii?Q?hySoCrOWuk6kTAd/ieLUgzAddaAqiLv45Af/GEf9fh93jVXML6s2rf+58nqK?=
 =?us-ascii?Q?LNM9jM03WyojmRD7F29XbdW91h8I59MAdfS8IM3czEN5h02pH1oCvgIwEZ63?=
 =?us-ascii?Q?aY4WYV9R8AYhAX05jN+bTbi/LO8CNcPIK3DSZc5Dqx4iAn60T9ALvSsjajaU?=
 =?us-ascii?Q?pxoqgNoGrTFVrbDK5OI5KFIWuITDqNNQlAT+BlJU+cWbxtoiM95OJncaGlmS?=
 =?us-ascii?Q?21TSI28aA0PaP+VQ6kBIukYZKVhw/V+TqCNv1DmlY6xoKIcWkzjEDpQJZQ1F?=
 =?us-ascii?Q?8Lwcdz7h+9tlr4O8/8O/Q7GdfCVYV0bqxNEBfoR9Sivae00rUWGud/j2bY4n?=
 =?us-ascii?Q?PY1BuBJuw/9OCoeCrzOoaWafmJ+Dgi4m7W7Mew65hlUROAjDC2Pzg+rulGzE?=
 =?us-ascii?Q?HnNyoHsJtztX4j5C7r+UfZRYAyu30RtSRKpONNnmesNX/mbJqm2lTn1SsTw5?=
 =?us-ascii?Q?XaPiWYPR6q9oTsVbaGVlZG7GY4hw7NUjMh5+dkkGEzruQeSXy7uJ40slQSu5?=
 =?us-ascii?Q?fXOZt/4fL8Cv3EplMNFUnWfawzgLX5RN/e8Kv3reWzJgx3Xl17c1s1ki4/uP?=
 =?us-ascii?Q?68le2jVcHMw7tGqoJLct8m2+dbux3n5hU5kuvnuZncBrd/vOvFTp5mWqLMjr?=
 =?us-ascii?Q?/K/9/w1Gw3kpgzue4VpAtUZ1RXNm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:19.9838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363e46af-3563-44e6-d2ae-08dc69aebd45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

[Why & How]
Remove the panel replay initialization for DCN316.
Because currently DCN316 does not support the panel replay feature.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8245cc63712f..5d4716d7a55e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4583,7 +4583,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
-- 
2.34.1

