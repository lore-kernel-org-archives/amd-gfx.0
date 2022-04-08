Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57901C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D660B10E1E7;
	Fri,  8 Apr 2022 02:27:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160FC10E1EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDMlvwXklBZuckrrxjN/P2gh4DaXScWgC9YhZ2MwnL4ysO7r1aml9c6myuPT9t2kuVsUCNHG20Z2u/jXQrzyZI5G6Ngm89+clz2PG36xmM+UoK0kFVVrjgeqEKYhxmQieQegOXsTROBRoTn95yPsKYZeagI6iVqOaQbJAx+gLq6bmXjsfIaUVX6fQC7/dPsU+7d1iI026yniFisjneqApyJa20sWIsSBvreSaDv3DrF5rptDxdo2QssXHa93dCinL5x3GuaQ5bSWpwhZLBT/cSIoVJcueYL2fsdO43c0VvAqQHP5KEH9dGt9AJ/H244HfY2SRXp9mZr7hT0AOVySrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTYfyZKVa6W9fCHIqGV1TP0cvT8CfSzC3TM9vBjkoF4=;
 b=IMczrwltZY8+ez6JPcaxoZzM0lvuPC6ZaxS4qj/zOUb2z5uwKHYs3flyoXgmpzWlZVqlbLoS3a0RnqXE02mxelzDbYecYApdnwPZoLqVihglKKaGqGgEx88gijxTXgz+i6QAXTETTAqjdtJFmlK0RFPu1/mMQz2+fO7TzPCq7NSOqfWQx5xuZi3+O944y87Tv6NoA8c4QBrxncbOZG9IXHV6VG1x74AeECs79BULgaQSnaYNwYcUflbMR+CmjQlzBRLcLR4pplgzqrmrNzR4sDK8rkul5hmlPYpdnAFfccZ96POfupTCNWkrBU2h/G8VgZhdyKDjkAeO8gHoaWrDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTYfyZKVa6W9fCHIqGV1TP0cvT8CfSzC3TM9vBjkoF4=;
 b=5WWNo4heaMlQyC7mC1SpfKxfyQwhG2v9SfPpTjjdd+V6KgDxHsn3eztNy5DxQLMP8YKX6EJCQ0dXxusZqG314hTRd9KNSyzs9KOmbLiA3dRnKeQstmY337ZYdG2p9A/9lLP8lJvJl3zC6dDRnX8C+sDz11tDArN9cuIAhaTA50A=
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:27:12 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::99) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Fri, 8 Apr 2022 02:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:27:10 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:27:09 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling in
 send_smc_mesg
Date: Thu, 7 Apr 2022 22:26:39 -0400
Message-ID: <20220408022639.7909-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae0f46c-21e9-48e8-c4e8-08da1907493d
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54888069F7AC93458DB1E639F0E99@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbnA7MkQBtrQwPcyLAAOQAfBf1Rto8VXT5Bh2k4QlHGsETCv8HXBmE0RSMBDjxyTa1ZzPC1JVRkyGNhiKCmTAGgmpwkK8UvcT1NGhWyBu24h4mHfcyZiAr5rgiywAxovY5i+tMq5FrSGqM+sY4BmDQlYCCx7qjE2yZDdN1tkHW6Rzg65hvxGq+dys4DSpSBY8AKSwxAVSSrc5NaL7EYS9SY/SXBtkFTPqGy3uTuq2SCCPM22Z3hCIyD8qI8omK2j26KOdrHUnkO+YrzYO6HDBS2bGbPGH9cszhnS6k6vBtjI4KpXSQSoxiHhy2uxVWjZqmj9gqDbtyQ4G+wzAlY0uz/Tvij+rdpx2BrAhUAw5yD93ivFpaFIr/yL7EUFgV504VXXpCj0kAUabccsVQnqhfSxhTOG9CJaN+akPa53FUlEx2BBcycDphzo5LaWsORsqRiOCJh09/rLNCHOUoeYyaZ7WpQv2Oymg0+RbvMrGqhAOMtRqGqynGCHt+JlGxU1meiY6DFOq4ibLsdSDzM+yeQD7zDf0rX75Eznk0cbxztejgLxE3PF9+jjB78xvAaaJHULpWvmV8sZU2k/6p9u4QXvRRI7i0fxlSg9/8ihPhdwr36aDKgoO5WeVD7mmLRxCZrX24xw4AtIN7FnTf3foePQlqCfI2zt0RlQ9y3vsK+ez5uG2fcvXAI44J06wYfbdpIx8oCAiOljN79HITBWkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(8676002)(47076005)(5660300002)(336012)(426003)(7696005)(81166007)(356005)(2906002)(508600001)(70586007)(83380400001)(70206006)(6916009)(54906003)(82310400005)(4326008)(1076003)(36860700001)(44832011)(40460700003)(6666004)(16526019)(26005)(86362001)(36756003)(2616005)(186003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:27:10.9971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae0f46c-21e9-48e8-c4e8-08da1907493d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Cc: luben.tuikov@amd.com, evan.quan@amd.com,
 Darren Powell <darren.powell@amd.com>, Wenhui.Sheng@amd.com,
 andrey.grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
 cases exist where messages are silently dropped with no error returned
 to the caller. These cases occur in unusual situations where either:
  1. the caller is a virtual GPU, or
  2. a PCI recovery is underway and the HW is not yet in sync with the SW

 For more details see
  commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
  commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b8d0c70ff668..b1bd1990c88b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
  * completion of the command, and return back a value from the SMU in
  * @read_arg pointer.
  *
- * Return 0 on success, -errno on error, if we weren't able to send
+ * Return 0 on success, or if the message is dropped.
+ * On error, -errno is returned if we weren't able to send
  * the message or if the message completed with some kind of
  * error. See __smu_cmn_reg2errno() for details of the -errno.
  *
  * If we weren't able to send the message to the SMU, we also print
- * the error to the standard log.
+ * the error to the standard log. Dropped messages can be caused
+ * due to PCI slot recovery or attempting to send from a virtual GPU,
+ * and do not print an error.
  *
  * Command completion status is printed only if the -errno is
  * -EREMOTEIO, indicating that the SMU returned back an

base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7
-- 
2.35.1

