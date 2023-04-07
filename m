Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE02FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 09:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FB610E108;
	Fri,  7 Apr 2023 09:17:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7FE10E289
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 09:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eylc3wp/OYWLschCFbnUrdIh+jtU3JaYDTDTacA/YzjjuVORjB5AzzsD7H9VixU25KT6XNUb2RpWXxdmZ3YCj8XlgaxR9HRDQhKjEemZwGsoANAlEgZQlg51Q+uI8DGZGqP4NSS6cWUYW3GJFeX4KNI0N9S556JpkrE5tH6Bk+BC7RDolzARMgj7Ig8/SvTZSyLhLm9CgNRKF/3qu9Xu8xX+q/L8+MabnqwUY9B7uthf+/KJC5KJyFFj8YVOEq6RUkNuro4CsF8ZpyMKzTt7fbpN1Vj1vD9ekukvk1sUk95zMTdSuioLoODBS/tyOUK3z67M8DnF9EYG75EUvnj+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgscBrKFpzJPeyaZZ8QLGEYh3nJ7GvsRmbA4y/9W0Y8=;
 b=O9qXDsvphJxU/vRFqY92yz1ai4u9n084LWVDY3vfz86RyEUOyIcP9MdV85rGvgFVA3eSJvz8dLnGlWbSSElHNLq5yAGj1ye0gd4mLAyoxmMUrE+0YZFg3A8RqB0+gKhgb2GJv+WOyM5dNPQ8xjPJPz2x6drySVMXAufh6PXamIBzVveVpKvXf2lElGQRVgJMSWCx7XKqdf02kRN82VAZYZwDLISSrzxbcZWtKUKD3nLesw13p08iW8Fz7uL19loKLAtTSXpFqWItkPr5TmGzetq79uesiiXNNrFRaVf55bjfVHaD1hlGf9qVU75wSCich4KQMRwhDK4I1juDU9fRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgscBrKFpzJPeyaZZ8QLGEYh3nJ7GvsRmbA4y/9W0Y8=;
 b=cV/ymcWGBDhvwCl9kGAfgYY6Fkg0xh40yHxxGCuFBIyvkD5dVUX8i7JpyEWwG/ZfGq5ChVWa6XGO/frg2iBUBqz+WAC4tJxYeTW126IAETptw3WULez6iNt7gCXxyH4Vk4MuCS4x3CsMd5GZhXRM2c9FrPlyyw0CJUvOIhC+UH4=
Received: from DS7PR03CA0128.namprd03.prod.outlook.com (2603:10b6:5:3b4::13)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 09:17:00 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::94) by DS7PR03CA0128.outlook.office365.com
 (2603:10b6:5:3b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Fri, 7 Apr 2023 09:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 09:17:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 04:16:42 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the pcie link state check for SMU13
Date: Fri, 7 Apr 2023 17:16:23 +0800
Message-ID: <20230407091623.23174-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2996d818-a2e9-4a17-4587-08db3748d7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +V6s8dxMIwyTsl6JfEOlVjRxFWIo4i+SomIQo7GRB9jZvqRKRUSi1lj4Y6x4r/UagtxOdcZdljVBbgDVEzlHJsKIdIOgUuCYBkMPGxhQfflrweoItN91aQ7T4B78kCrAJs5clAoQFVZuzTDxbQ7DMNjmuR6QhySrV0imGd6TvErKHol/v2wtUD2B8vC4HBqyGS5JS+52jz4lfVD+W03nYjnp01lwbEmbOPUWvnggjggHyKt7UptWx5deBh8T+ATCVbJ6U4iSQtuPYqU998Lvwg9CjipL4iNWeAS3PLEu4fi5OTGB5LxVRt7Vx8slyKf5lGmUhKMXpBEHdTmIzveoTe7sFiQ+6sOmN+BKRoBO5fEddsUJdokGz+QByEYyUYpOhk7FiePnchV6b6IyAMQt7sON5eZHOK6FQUWGU4mwhoGArNZcE4diPpibUVMcTr80SY14f3VEeHoA+ZzJrgEaWRO8zMUnJv9X30jCxUGMqCPEMnhySirclSeH9leu5sjsmLvVS6U9iIr8gPZd0LyHz9MffIQ0FwUQuXtkrd/WxKg3+1VcsODomFaqw4zA7KIb55/EzzmhETRbnpRJgL9C2cJGgUPEniZaHe+0zfUqxubTQ1590w/xh82Hu+FhxihBQxMrcCDrJzJJOSQEMibdkpXnHKyIk5W8H4v8LIIspCMO71Tc4ou3u//JATnV9z6PeRelDAB3G68xv8x+WYvvL1wiDNFkf36JH8ih5YSVZ/c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(426003)(336012)(2616005)(47076005)(83380400001)(478600001)(7696005)(6666004)(16526019)(186003)(26005)(54906003)(1076003)(5660300002)(44832011)(2906002)(40460700003)(36756003)(81166007)(356005)(70206006)(70586007)(82740400003)(4326008)(6916009)(41300700001)(8676002)(8936002)(86362001)(82310400005)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 09:17:00.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2996d818-a2e9-4a17-4587-08db3748d7df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the driver implementations to fit those data exposed
by PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8579f6b22fb586bb52a6c97b8edfc13c493bd484
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 60c719a726ce..e9b14237ae19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -62,6 +62,12 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
+static const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
+static const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+
+#define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
+#define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
+
 struct smu_13_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 29c5200356bb..48ba6e2c683c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1149,8 +1149,8 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_lane[i] == 5) ? "x12" :
 					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
 					pcie_table->clk_freq[i],
-					((gen_speed - 1) == pcie_table->pcie_gen[i]) &&
-					(lane_width == link_width[pcie_table->pcie_lane[i]]) ?
+					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
+					(lane_width == DECODE_LANE_WIDTH(link_width[pcie_table->pcie_lane[i]])) ?
 					"*" : "");
 		break;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0559bc88f44c..c0067272651b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1079,8 +1079,8 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_lane[i] == 5) ? "x12" :
 					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
 					pcie_table->clk_freq[i],
-					(gen_speed == pcie_table->pcie_gen[i]) &&
-					(lane_width == pcie_table->pcie_lane[i]) ?
+					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
+					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
 					"*" : "");
 		break;
 
-- 
2.34.1

