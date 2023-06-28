Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5CEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF0B10E397;
	Wed, 28 Jun 2023 21:24:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B00B10E397
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqvalkBQFIsWncMwuZFYco0nt/grHRIb7QDYRs2DlWXAtF29p1e1AhSMSOA6zvRjYQOoi0Nt0/H53JNqAzlEukrqg8BH0gQNBp+KT08QM24Ftn+LHhplJd1DVJGG39O25+GX6FeL9QVX7vhMSgB6rFHyivxKhlltEAojD4mcDXol+jPYkze1ds2rrXdeEVyClTmXmOpN5fnjeJ0nyqx1Aq8HYcME0167NcDnP9mUhBHjMOuvl0lxTY8bBl7234fxk/dryOPaAs09AOZeB5ZH8vPEmOtN0vOVxalJ3GBBXNdkRaEGD1haEnkGpXZMaI/V+ueXQRIh1BtqT1rQLgfh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky5MOL4pP1dYDE63zXEuXoJ1A6JCEWqWFbqG5lKb3lI=;
 b=Spozr2fB/irX+LORr/IkA/2rU9AfPMqw+aFrGPPL4jNg6VjogK5IivdIEwrZTVCO/GX2EiRQ9xupuzSIe2NLQMX7i5FYoXkz6AvEWssYkja3MOO3koLQbJw2+gW168iqlMWE4BWrrsKOUxtKx1qughMdQ8PssMNCRDZWzcTqvVEqS/CBLo9f+085hK8iBsoVhiwLTuBl7Yz17B9T8jzbtq6ekU6IjqWZEE3MFmaSzAHyWZ1n8k5FHuzhKKqLrEn21Jqqkwa92FGp3idEiICJLOoDd7P/O2zsEeu59Lcq0AQ3oHXCCoIij7l63sLetTXVwNLJowrNO6znjtxar0/RNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky5MOL4pP1dYDE63zXEuXoJ1A6JCEWqWFbqG5lKb3lI=;
 b=OVAn24xLmWEvzVI3vEbjeeTztwnGIbRUkQeyMbVtUrDmsqoXY+2M/jXcR2Rgd+7eHmjrVZoHNnBoYTH/3+5DqS3rPdh4x85HCDximrfokSlucR17nuLEVyPh9Y2XY/RRqlj9lt1TNjaF+F0713axd+PACWfKidgmPxwo4rA3rpY=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 21:24:02 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::be) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 21:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:24:01 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:24:00 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Date: Wed, 28 Jun 2023 17:23:21 -0400
Message-ID: <20230628212323.248650-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628212323.248650-1-jinhuieric.huang@amd.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 898a64b7-536c-4880-f590-08db781dfe0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OqjfduvLF3wX4Vjcm8eaWeXBI4MFP0F5g+uq90/rbrCSHwhCJkCyAGPWyOrdY8VpLmyk4wSbz+fDwsVYlej9mBBe497r6xIjnX0hVKs/7+PA7uVjDIvARaUZkkP0hrDhW7M8phzUNG3HbvvXx0yNfd9e95AGwEu8ZCq5LdzVH9ktu3sg8Vp79mDUorp30SIHKyOThLFVTYzy0xN0U0j8uMcK/pmnJcI+lzpeiTPHcJ84ExOPN5mCHcmzvvZaAd4BL4NEJ0QpoHTc9ml8v0Mr/U2J5GydgGzMOHePFI8f9ZKJtqhSIc8KoUHPVMXoGNleIvSgIqSjX98zPSfSfoNbRykltVhuIf5pPM8HmGbONcZqDe2EBWAF1aZ83ouZqR1zMreqPCblLWZY3+IcERuoBIGhTu4LiXfLPePpyE5w1Jt5w+E/CVH1Zj8u4QJCja6xh/PJecdZTzZsC2FBSM7TdYxqQczgpS3RmFLrCd1doGWL2HvjQQYHkBzpCZ5KzHhmLUYkbBi4Du0lfk3XX8dnyBF/q6pte2yxndx0y5OCMUEPAtYgjN6x6MVoBGbwfRydLWbBUjcTwyerAPn8rJ6rpS/oP+piIpOWJM3G3raPoRVxQdoqYKLNYWNG7kMODpKsM28GzNoYXbIk4mMSEomhMABVVeapH+LlWsT6rkyXcp4FlaNhiUaXKcQ/nqImsu9++A9AZ+xcHvagEprp6fbNC2ONKzbQYOKDcJM7ZysgAkVK9zS1i6MwtCC/TYdqPeDcQIHNCGWY0t1eWFtmfQwxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(26005)(82310400005)(6916009)(82740400003)(356005)(40460700003)(70206006)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(5660300002)(70586007)(40480700001)(47076005)(36756003)(6666004)(186003)(2906002)(83380400001)(54906003)(1076003)(16526019)(7696005)(426003)(478600001)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:24:01.3857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898a64b7-536c-4880-f590-08db781dfe0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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
Cc: Amber Lin <amber.lin@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Harish
 Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The additional information that the KFD reports to the debugger was
destroyed when the following commit was merged:
"drm/amdkfd: convert switches to IP version checking"

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Acked-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 61fc62f3e003..1a4cdee86759 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1932,8 +1932,14 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
 
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
-		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
-						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
+		else
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
 		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
 			dev->node_props.debug_prop |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index cba2cd5ed9d1..dea32a9e5506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -32,9 +32,12 @@
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 7
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
 #define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
 			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3 \
+			(30 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.34.1

