Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD016C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 05:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D4D10E0AD;
	Wed, 11 May 2022 05:44:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517CA10E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkdLpbRYSs4COcsWL9Xc959FPSRL2wLhGjagIWHM8yyZX8kL5H6dRM/tANev31ivdXuNteEw6ikRzvro23fr/o/BWy8LLE0v0PxJ0YahHevmG0PFZOgW622BesEFnZVHa8ws7FC2UaI5qQJa5KKu33l9xEazvIVqkTiQ9cn3hxaERU1VUek03kxyGZ0ekyBtzTwCMC1FheolEB6Fzz7ay4V/6RnN2/O15ghFm38J7OWtbuTW5+ngYMoA9b2i5kNpG7HlN+K/ZMOvgvZVyb4jrPxHRonpfZlRZKWxnYZW5Aiuq8+dNajxR8694v4mv23eIhXvhBw0yDI2t1kbP/bDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kFxWSxYIXLxnAUFm/r8CdZimW+5mZpb7h4YdMc4UZg=;
 b=lWlf9AhcB08UCdJ3YQV/AdsKHNSD6XHXo8QwPFvfRoUg6v/EjzkPmYVh3fxjKJxWwRRaxVq4k3DhZ8kV3jOy3j0zs0g1wugl9ceJTTCblTIaI8yHkdBM0Odn7fqXNuypDYISYQZcQsvvHBNzhkFK4pfS59B5c3/tyiYxvlTfN7JtNpNiQshIScfQLqRRMjmzydpvpWLNK3FoSeYfv5SnR1pzrG8pXghvHxyhZ7aB/Ncqwk/q1FUtklGNAAhzPNCZlo7fb55OjqoCGWsf3dL53vLPQUHMAcPekpu1bxmgUP0OU/dPB9X4q1KNj9RIoMqFJzgRqXp5bCT6Ayc6XhCvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kFxWSxYIXLxnAUFm/r8CdZimW+5mZpb7h4YdMc4UZg=;
 b=X4s6O8ylKcRSH1QX6YqH3BucyAWGs0ww0/2a8Ivryyi/ZinnnVS+9ZI0eb2PCpSbvXmIzbJYzAZbMqoskwFbK8BKKIidUl3q7VMVeVME3JnmcraGrfxsyuFOBwJi7QYxnHDoWOauagsn/94oGYG55UrNFH0exwMSQfDUvMqSapc=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Wed, 11 May 2022 05:44:34 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8e) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 05:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 05:44:34 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 00:44:32 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] amdgpu/pm: Fix possible array out-of-bounds if SCLK
 levels != 2
Date: Wed, 11 May 2022 01:44:17 -0400
Message-ID: <20220511054417.25819-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511054417.25819-1-darren.powell@amd.com>
References: <20220511054417.25819-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 161530d8-6bae-4229-13c4-08da331153dc
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5399EDCF3DF1874EC3A521B5F0C89@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpSe99JpEKxyrUv+uvz9/F7cg2pxQHgXI52/Sd73cPg3sZF9kc3HfP1eJZjixTwdp0Q4QKv38zKOxfVpcfPbVz7BKX33j1UyTI9Ncmm7CRB3TKUXwrWaSEdthAQ1Ip9J1OQSOxNridWSsSnTdQvR+IBbtfqQs6wowfjIMtVJwukoio8yGNX8twBCcf8CxMk7Q3bBDbsWGbNQKDiPmi1zOgSkaTsthZPU3URCmTlHgfsWItX8pOnrijvT9zTa95v9bPHzrySbaOQFym2GpI7L0HgQHtKFqwRkxtdEmfLnAk4+3ltGGUB6YlcfjIuOReQ/E5kSwD1RiGH4DI81us5Xnjw8oZUt9RGoJ6gpZ5VNJR+v9o1Pfea1hGwLuiTXCRwxfWnBAtsy9n4/Iue+pu8vzddlb18h9n6hC0dCFJNEOVKyFTokuPKy1b5Nq+iEEjliDDdldgvh+DGGwUHkbkFqhzOtOhv7pvO8IKn/EW7am0R13R1LPy5S0d1k/ehWM0aYrRNc34dKljuPRgC33fjpxD2t1GVeUmCtrHrJ7CwDXla9VJ3Po7oSPK5aMmJGL2KrZ+0Yb6gZwQcjfEWXNXuIpYqp+UPJEox5srrVlWygAaI1OhEV/qoTEaHZkbO1VhfiM+QmKatAL/b+evqUv1Ii+NSAxFab1FYddAj8D6zml3ctusSomHONFjcjKIy7MBGWlsN7XxAJVfnCv+CW9QpImA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(508600001)(316002)(81166007)(4326008)(8676002)(86362001)(70206006)(356005)(426003)(70586007)(6916009)(83380400001)(1076003)(16526019)(36860700001)(47076005)(186003)(40460700003)(6666004)(26005)(2616005)(7696005)(336012)(36756003)(82310400005)(44832011)(8936002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 05:44:34.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161530d8-6bae-4229-13c4-08da331153dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Cc: kevin1.wang@amd.com, lijo.lazar@amd.com, Le.Ma@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, kenneth.feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 [v2]
simplified fix after Lijo's feedback
 removed clocks.num_levels from calculation of loop count
   removed unsafe accesses to shim table freq_values
 retained corner case output only min,now if
   clocks.num_levels == 1 && now > min

 [v1]
added a check to populate and use SCLK shim table freq_values only
   if using dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL or
                         AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM
removed clocks.num_levels from calculation of shim table size
removed unsafe accesses to shim table freq_values
   output gfx_table values if using other dpm levels
added check for freq_match when using freq_values for when now == min_clk

== Test ==
LOGFILE=aldebaran-sclk.test.log
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_od_clk_voltage
pp_dpm_sclk"

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6a4fca47ae53..3eb82bc88890 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -740,7 +740,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t display_levels;
+	int display_levels;
 	uint32_t freq_values[3] = {0};
 	uint32_t min_clk, max_clk;
 
@@ -772,7 +772,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		display_levels = clocks.num_levels;
+		display_levels = (clocks.num_levels == 1) ? 1 : 2;
 
 		min_clk = pstate_table->gfxclk_pstate.curr.min;
 		max_clk = pstate_table->gfxclk_pstate.curr.max;
@@ -782,30 +782,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 
 		/* fine-grained dpm has only 2 levels */
 		if (now > min_clk && now < max_clk) {
-			display_levels = clocks.num_levels + 1;
+			display_levels++;
 			freq_values[2] = max_clk;
 			freq_values[1] = now;
 		}
 
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		if (display_levels == clocks.num_levels) {
-			for (i = 0; i < clocks.num_levels; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-					freq_values[i],
-					(clocks.num_levels == 1) ?
-						"*" :
-						(aldebaran_freqs_in_same_level(
-							 freq_values[i], now) ?
-							 "*" :
-							 ""));
-		} else {
-			for (i = 0; i < display_levels; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-						freq_values[i], i == 1 ? "*" : "");
-		}
+		for (i = 0; i < display_levels; i++)
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+				freq_values[i],
+				(display_levels == 1) ?
+					"*" :
+					(aldebaran_freqs_in_same_level(
+						 freq_values[i], now) ?
+						 "*" :
+						 ""));
 
 		break;
 
-- 
2.35.1

