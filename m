Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77D1C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 05:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA1810FA94;
	Tue, 23 Apr 2024 05:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ee6q2UXo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD45910FA94
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuGapf8QEuY4LmruQG1PbFopwHNOpCWdw8Lu0dqcN4Bobf1j8fd4fat3RIuhh8hN+puuQa2eAZBTWtN4x+Q/GYlgx/rh8ECuZirkwia2AQOSmhqHyR8hcQlOczkZDOaw4nYZdTVVI9MbVDvXdPzPu4Lz47iar5HbnRTVlAWJWVF/5lbAcvsUl562IxZy3I8llktygejWjSuQ/0LvhohLAp0zBYglvqjGFJH8RSwtS4da9EfZVYb4PyL4zQFh0hRgjjiN8UB3IDpADQJCUDb4F6FyG5Fr76KH150DdcVLbvlGp3Z+VzcgUvzkIWuPexn0ZOg1UwscTD8dmFn95L+e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0K4hl41Nt36E5xGojbYgix4WztTomVOXh7YuB2FxaE=;
 b=YqEYGjIWFqjZibv+HB8rYefNTEcA5W/jJ89rM0Cu8/LWqbXolZXzcDevq96ahIOvM9MH8UQNg1rlF8wimxoFRE+PoNNIEiBUjM3QGDRFYxaiP/0PWTs8qrKTvjo9FOjtBg6jUhXqDcaQMDh9t8i6ozuQoa7iicejRDlgccOaSQN1W95YpKuveW6vir3B5YnNrIt5LwJNHF0VAFcfQhPmPYNbHNkYjlJcrgnBF34FuJ0rS9F0J2OV36anvi/+mbA8Esa4wKx9OX2Dx+sjztNhKCPjW2dyn4ngwWfDyboco+AQjHEUgPwSWwNRHdQdMvcp84eLBnlGnU4HHByWu/Wkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0K4hl41Nt36E5xGojbYgix4WztTomVOXh7YuB2FxaE=;
 b=ee6q2UXo1+KHtZPwj9bgpPC3YAloo9zPpE5PB3qXNUMXu0c+KrMTA5j7s42EDZUZrGEJ+uksIusr3sOyNZ6oVBV8UZ2adiDwbmyqLbo6RI6Bl0gk4Bj+BBU+twMFHK7k/VWRGxjzOj9Ptq7v9zwOzvVD37ZQIUE3PUwE9z7Te8w=
Received: from SA9PR13CA0152.namprd13.prod.outlook.com (2603:10b6:806:28::7)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:33:37 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::19) by SA9PR13CA0152.outlook.office365.com
 (2603:10b6:806:28::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Tue, 23 Apr 2024 05:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 05:33:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:33:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:33:36 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 00:33:35 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Date: Tue, 23 Apr 2024 13:33:34 +0800
Message-ID: <20240423053334.884670-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: ed02cd5e-dee8-4050-091c-08dc6356ed0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3g7pxqlRNA2AOUuQX5LAIHhehBBWMWdyOtdvxWEjaZHeIL14XWoTmEXfEdl?=
 =?us-ascii?Q?aA5kOHXwJJvpXCcNR9Fd65r+wsovI0/ffwkYD/Drxe5ZCyFvrQjm+69fjrhW?=
 =?us-ascii?Q?+lUEPxgMtc2uaKkyK9fgcJYRYlZuxBz8OWQe3U7v8uBKeXa5SYsEXeAnnf7A?=
 =?us-ascii?Q?ls9cAAglNie8y24xDb56dd0E3xTLXBqnpL9vePjMFt3Qp86KBVCf5h0YZQme?=
 =?us-ascii?Q?GBDjzpKXLhV+2dc2GxIevMWsya0NImnv+RsvzbxecTQfpV1BAJmd0dVYJkqx?=
 =?us-ascii?Q?sSJNI/S1CKnIa9cN4xh1WYpzqPmprkLZCBe4tYBYuOtpw+EPdmaaTaf5lSyS?=
 =?us-ascii?Q?LEzN5YivOvODOJVnEOOYy2nriGzOdCE5is2LDDusIz0cGjN8b2tPem8t50Nm?=
 =?us-ascii?Q?5pW3O30JlRNyJxuBERbe5g42zUfYh3XftBoRFoTiRzsEQ893IlDrpzz5pmZ+?=
 =?us-ascii?Q?TAHMwuLb6ocYtvXYiCb6bHUS/ViQRS7t+zkXSFHm00040rG/HH62MPRD+yuO?=
 =?us-ascii?Q?Tsq69A65HonmBAEvjAP6wkClv/SuTeAEOKcTSKiGOJSlnLaa1u9chLYqoMR/?=
 =?us-ascii?Q?yfatx1As98g9K29MfwUOQ7+KCLYsiPyqgyiudxHQLSGbgD/6gl1srMd61WbC?=
 =?us-ascii?Q?OHDWNAucD1MNnaBNSG2T3rzr4GnXeY40awa5AJddb3unOt1gmA50cPRZzJen?=
 =?us-ascii?Q?XZTNSxjNt+0dM+smi1wDL0WBimpr4Bq4dCVvvD1alCT8c+Jw6tmuAPLPFH8p?=
 =?us-ascii?Q?XG9dZtKMVwVzJblpGmrczzYxbzEhnbNEMDa/VcaBycPrJCIXieKwhoce72lZ?=
 =?us-ascii?Q?2CtvS9otMbh/e7VWNpYUAbLN5qCZza4OjlLcHS8Zig25RaB5XrYnNDF4JPLh?=
 =?us-ascii?Q?d3cXF9R5wFy9kfyc43aEyq8jG9BrW19ZFhNpIxtQFtFW/sE1eCicPv1XoY3d?=
 =?us-ascii?Q?e9E2eQFBtVmny5J2o9FYSCFjp0NDOVEs5LiCWXIryQB1Y+aJ92yy8ry+5xiK?=
 =?us-ascii?Q?LG55AQvztpaRjEVVTU5L6yPsBwbEAUc/9pubaVT6KAAS0crwkO4iiTCSHlID?=
 =?us-ascii?Q?zWbfftEgvwzLfeKjIqOw8Xy/xJ2S9l1bQiDVEiIxxSiEVtJtPJfVdcfs/sv3?=
 =?us-ascii?Q?mv2s0yU5wyM95OtMNjHbVhylqoFWL6wm7mhx4cY8IP0MU8sIcGloJoDyS38E?=
 =?us-ascii?Q?lP6jxabnTNy/WcjqqfksI0FtFv1V9MtbhUXlNF+E8D7ngtZqgRcXWQhqVnHx?=
 =?us-ascii?Q?e9O0vc05elqgzRFTk+fuIa/EzPlgAtjwPnnSfg0+uiQtVDO6HmmjHWg9Hg05?=
 =?us-ascii?Q?6+uid4j8dtmLHgqA9FNIul8VdQaUmShDsG2f0taKy20qJlTjzcO5Hj9J5jA5?=
 =?us-ascii?Q?JZfBpsnh9m9NFBhNQB108/yXXu0O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:33:37.4509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed02cd5e-dee8-4050-091c-08dc6356ed0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

Because the val isn't initialized, a random variable is set by amdgpu_i2c_put_byte.
So fix the uninitialized issue.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 82608df43396..d4d2dc792b60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -368,7 +368,7 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
 void
 amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector)
 {
-	u8 val;
+	u8 val = 0;
 
 	if (!amdgpu_connector->router.cd_valid)
 		return;
-- 
2.34.1

