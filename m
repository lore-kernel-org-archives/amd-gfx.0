Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5C4C001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA1710E482;
	Wed, 14 Dec 2022 20:22:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE4310E47B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpP3MprvH8egXmzTqafnIfyZrOpwuEBH1/5RBYw+Y8sGVcDPDkQwkjTMtFj4MsFHd0dSAy6JenL09MfEtxxr9sQFwQlZeTxbyfvwxURt9FXyh5wweKuJa/yETMDYv0Msb9hF7GwuczuXOrIqwJ8IrF3ZQ6hPV3l7QcCbU3rfvKk7BH+MSeu5081/F4zhBeQmllyUvFNmfvXzM7D9dYH1CEz7XO92ecJr5/fthGNIPBbflpKElCExEuhfHWIpzo5j3eRrISUIWkRVlHcXsjWNHrHWUPOYJueHH/ksDod8R14ASNR1UlHMRa4Y8updZJpJaPxlIKIPIhoKKdaGxIBh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1azI4XnMWsLodAmxKYITlfEG8zxgPaNOFSsgKp4VYU=;
 b=UorQXrdjPDDuMmk0OM30Bd9P7ZHgVmINqTLCPGjbZg0Byw+WRA3YQyBbY92HdFFNeJPGEh1YhM73ng95OzwdeUjtCfREqShdZr1qQM2rgMls6MOonUGWg0nES9dpy9oYC0jwAeCH6l7FX1Uvxc/Jt8BTjv2OcymySwaHWvWITgDemwJklqjFUBH0HhxOdE0ZWe+tzGPHeQ/DJFxy+6IoAEAFSNqD6rP2Qa47ECCy8J/ymzDr5TzYlhnTot5iSFXP7pH1wBkrEBIZiukfh98JRjJJMmJ2Rn7MH++S1wMxx6JODdRUDXyNTMXL76OGr2JIy7rQhmkbprQ1LXSgNgHNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1azI4XnMWsLodAmxKYITlfEG8zxgPaNOFSsgKp4VYU=;
 b=AeN5KzQ5Gx9P1Y0mh5QfAy0lfZAR3T0b2zfMPwy3kBdMUrd31Pj3Za/b75OoNzLvR2JJuhs3fUknYYPik9LPVW9OdoN2o5l07mbxnfIF6oIGTDiTA5ZrplNRg3gCZtrfLe7m5gsyeZqoRUecHR4mHNL3CmwsvmuJnG5brknZ4Rc=
Received: from MW4PR03CA0118.namprd03.prod.outlook.com (2603:10b6:303:b7::33)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Wed, 14 Dec 2022 20:22:04 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::df) by MW4PR03CA0118.outlook.office365.com
 (2603:10b6:303:b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:59 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:59 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/18] drm/amd/display: fix dc_get_edp_link_panel_inst to only
 consider links with panels
Date: Wed, 14 Dec 2022 15:21:33 -0500
Message-ID: <20221214202141.1721178-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: cde69986-7020-4c90-11ab-08dade10dd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tUliMa+lhmNS27N6lb/Q46p0Gp4BE5QUYzjZVKz3+fnCsDoiGyeB2JH7I9ctC7ewCBhXQKPeVduz+WOH3L4xbSclP893E9iSwIRgidd+eTxixkhnGzH2J9I986M5/nLve/TjZwFkqmP9VLOaszth41GPJhBWdEjXpcbLf6iqjmWLSGZNFLLBdEvXOT4MpyE/H3Sqc4pggotymUTxoR0SwJXDLQE8XGLuf3Nd9ZssGJ96CzhkRzOjUQQzc5zZJLgNjfAMXxXt1HgyB1PxyEoZ/14xIoc3Jsa84grbN1Vo2+osucBR+VmDgFpoc3OGyGAgB+m26pdQYM9CxAULchE/CpTEkMdUL6b2UhenLRIZ+P9K3SG1l5DqhRNBay8Rr+BugxPjOFzU+1ybdJJ94kVZ3SOsPNYaqxzyTHqzc4O3SXlekBf+Q3+GmdBeaI4mdhxy2TlU8rUeRK9QUmU3wG8fzsikLR4m9Gs3iC4YTPjuuXoAs6GN6YXrOK7Bn6Z33xeMnEyiQJKPjZKaJIfjrx21rMjHJPgl1iA0d5LXQ3ptErRQ2SA1qHsATVbwu8c5INtFCkfpoBc/AwsHePd0LNp2zFcY0CjqUvrmGGFfT4Hzj/iIME7w+Bs8FmIyv6XNWbQ9K9wOSdmM4FB73kcJ7YvUUtusRTqvM1XPme+O5c+0npDRK7GwLE+nasALuAYL+aRW1HyKMk+6Uodi3YZf294rzXVThRrdu/90L40UXl83f4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(86362001)(40460700003)(8676002)(4326008)(316002)(70586007)(356005)(82740400003)(81166007)(36860700001)(26005)(426003)(336012)(54906003)(2906002)(44832011)(83380400001)(40480700001)(6666004)(7696005)(70206006)(478600001)(186003)(6916009)(8936002)(1076003)(2616005)(5660300002)(41300700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:03.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde69986-7020-4c90-11ab-08dade10dd3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This function is meant to be used on multi-edp systems and only makes sense
if only links with connected panels are considered.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 2e18bcf6b11a..8565bbb75177 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -335,15 +335,18 @@ static inline bool dc_get_edp_link_panel_inst(const struct dc *dc,
 		unsigned int *inst_out)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
-	int edp_num;
+	int edp_num, i;
 
-	if (link->connector_signal != SIGNAL_TYPE_EDP)
+	*inst_out = 0;
+	if (link->connector_signal != SIGNAL_TYPE_EDP || !link->local_sink)
 		return false;
 	get_edp_links(dc, edp_links, &edp_num);
-	if ((edp_num > 1) && (link->link_index > edp_links[0]->link_index))
-		*inst_out = 1;
-	else
-		*inst_out = 0;
+	for (i = 0; i < edp_num; i++) {
+		if (link == edp_links[i])
+			break;
+		if (edp_links[i]->local_sink)
+			(*inst_out)++;
+	}
 	return true;
 }
 
-- 
2.39.0

