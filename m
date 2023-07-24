Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA23BC0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 06:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FA110E040;
	Mon, 24 Jul 2023 06:42:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E17210E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 06:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3R01PsNQBYjXaKmDJHLojy5qgLx8lk9HTnat7HLW+aitvY93qgOKlW3lw93JpXUrZwtI3Fq4EzH5s3z7gFwNQBc7NuL0/TKpXnnzGNn4dGNawbrCTyF+hqiTDFEdxUIlKzFDhduPM5dS1MoYckBzg0KxPmEUGcEqTIDQsR9/pTEk1a3vMVFJewhaBsnHGfJ2wBo/SCtggZvKlbqbKJYVnz7igZWaTAJvdBFXV+a05g/NxrEvbaWEiwKseV6BRGbs7bXVhv+jIJrKmLzmWjeUdRdP7wFESc+XvqZrwkWIViKHsFHFnyMpuV2ld/VrAoHvdXG1cbGwHdKcZlGGg8s7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrdYH5ZQczeNLDGd4iXXYYMCQzWBTe12p5xWX13fI/U=;
 b=BEkiyRex+p1f+Qn53XkU/EMaOQauBAGSQVWFGN5mlndIJXVe4Bc2TcI5SHZMHSz7cjUvoUx6sWwiySKMJMhWatn+yRBvcWvthNvoL0LfyobT+75KxflljQY3YQr9AKmN1c/bIT8j7J/tRqSGMVnlmYZQ9mLxlv+FtatPMcSZU0Zf52gJ4c4dRp5o1B/kUk+YuUZfvOi7mwnxYhd7ty4lNJqM/d4ASDWsQpI2XYrHu+90M1TQQ6vy2f/1eJHWG151zWAD944Y4+ZV07k78keNswbZT94u4F8Zmksal/22EJxZAUUSJ5LogGQuq/u5B+OqTGFxfvC3opetWykmexGZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrdYH5ZQczeNLDGd4iXXYYMCQzWBTe12p5xWX13fI/U=;
 b=WnXYH39sGBGyKdZN+MSN1eiku7JUe7i3y0iaHmLLNmNSsE4uFuOihofxLi8LylwnGQJZTxYouBEUshAWo8UH5UMa3zG3SS7m8EsbRZYirTEjtmczSdRzeSPnXvnAG6OsI9tK4NbgmyQ6dYu8DSBZ79Ba8qxqHRvWz9C8eUcw5pc=
Received: from MW4PR04CA0052.namprd04.prod.outlook.com (2603:10b6:303:6a::27)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:42:54 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::20) by MW4PR04CA0052.outlook.office365.com
 (2603:10b6:303:6a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Mon, 24 Jul 2023 06:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 06:42:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 01:42:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 01:42:52 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 01:42:49 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: remove repeat variable domain
Date: Mon, 24 Jul 2023 14:42:48 +0800
Message-ID: <20230724064248.447145-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: b423bd11-fea2-4b80-ddfc-08db8c113546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6aJ9FN3MrACt6XdcBRw1XJgVno0McoH9jOYq89QvRPnnVpTubgrnAVI6MbZjCZDUiln0QxnLXqni4fUsIjHt7y5Xd4oBGvgsIMmNzBK4NZxNiidNewNpG5OQPXdSufPPfxvwqpbqTwSyKFVQ0mytPs6x4DpwyPxwCld1kj6x0St+LFF7mhdlVGtEI08oX2EU/6HAMb6yDZqYw+IjrolkRaM1mrtIoJx0iosLsoPYmi9Sqccjkfg9TvSCpZMckAv8srkJkhYYuu4PIizpSdoSdl4W2EA2W1wmaZ69P/BM6ZjutTL4DB2CE782yYQNIqJAAw6W66pqeTXaqnNcpwPljzKYlAt/w7jIN3qiQIMKA3tAGYDvjYasJjKwJCHxLwjXGZ3/o9Do51JXNwdQuX7O/2j17uA7Hn4WDDG7PD8GJpEb8ZO+o37kcdvFwf9lUGk2vY5YGFLyVLv1o/zw8qUuzcrpLbtuY1Nl+OwPsfluArQEgEy9se7JM6BBU0cY1IfRDY8K5QoAbFOj8w+OOQGi9Hjdk1Ij7vmZZdAm3e7JY5ywEVNC1c6dpiuMdUun56pmQbinEiutp9hQvOKzYn2qmD+h0Kf53W+AiYB8uwNZSqitQEY6dbiLv5ym6kDXzXBttn4RahMs8bJpeGrFJy1LIcnauewtAp2X5wca/VbMw8PhaYVxr2XV3Z70JOmRCLruqrXCb22ZZMdsSZuV4VO18JZ4vlphxuH+I0K9gOZFMAT5zJBvCr0rLhkYH2pkidQHQpjsKTgQh1ia2KJlhsXcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(478600001)(54906003)(110136005)(186003)(2616005)(1076003)(26005)(4744005)(44832011)(2906002)(41300700001)(70586007)(6636002)(336012)(4326008)(70206006)(5660300002)(316002)(8676002)(8936002)(356005)(82740400003)(81166007)(36756003)(40460700003)(36860700001)(86362001)(426003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:42:53.7507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b423bd11-fea2-4b80-ddfc-08db8c113546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
Cc: Bob Zhou <bob.zhou@amd.com>, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

building with gcc and W=1 reports
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1618:15:
error: unused variable 'domain' [-Werror=unused-variable]
unsigned int domain;
             ^~~~~~

The variable domain is repeated, so remove it.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5ac7544cc068..3f98174fb764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
-	unsigned int domain;
 	const char *placement;
 	unsigned int pin_count;
 	u64 size;
-- 
2.34.1

