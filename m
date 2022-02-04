Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73996C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED70110E7E3;
	Fri,  4 Feb 2022 19:04:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A456010E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VudwxQMa+wqdEp+nqvsDeIbzj7i0w1ZDZHfADlPPj5bq9Ym8H8Xg2s6pzYYOgfz7irNRVp3K9uCJqoNn7ri1s41HuY6/wpkErOgYPBlMKqs19pq+gP2oIEuBkBw6rKzhg9oLbXmpMlWGx1tdjTHEw4nGpgqZpO7fyNYW+zDF8jXjyAULM3UF+NCkVCiNQbTZWvpjMwH345yVvw0CoCe/2HHe81SjHA22812Fme1iMrtUCEgMQoV25mR9Udp8k3Yyk1OGbZyYMbCMtOii3gpwxAj0eodFAHUkm8xrerl4QJlvj4CcyOdlUA7/i3v17UfV+SDkQBOnYS2QlqlxDA9tpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=lEr2OTAEOlSaUJo8dk4eqFU6ysTEuyI1pqizlGYCXwPwfGQ4OYu3Mpjwkc4lz6r4fNGtMXDyrbyDTJLsrCeRnVkzoZHkkandsqTQsphSXNNHqoe/6QI3ul97CX5Y4qmFUO4s/pmm2EO7u0vHl7+I5496HFPkS/z/Dh0L/vuZsxg/hqXrLpjr1SaWpRf9GECtV8e9oeQcXHTw193RodzVvETjJe6zW4VoN3TgTH9aZGv0erCU0+PkX0wfEMJBZd8Zcz7vned0EmsXUe2F7/rD3ZUxCYOTE1N0owAzQbqD407SEg0bJur1/pxwTqCMkjFA6RyApX4VVcVYjb/+9bJIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=YL3RS96p2lGx3u4Ckm/UVyacYJ1cBZKlL6kIFRxROurHEwyUBS6eh+bZu8ktC6ECgByEsha+5x7Dm8mIMgigCmsq4Qmklx25zp3hJGLgnz4k3YqUAdCQFBA2wBiMiUNhtKndboUz2IBbrLZ+7sry6S5vBbuXdZx+reynuURgDaU=
Received: from MWHPR13CA0041.namprd13.prod.outlook.com (2603:10b6:300:95::27)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 19:04:17 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::60) by MWHPR13CA0041.outlook.office365.com
 (2603:10b6:300:95::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Fri, 4 Feb 2022 19:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:04:17 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 13:04:14 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Fix for variable may be used
 uninitialized error
Date: Fri, 4 Feb 2022 14:03:45 -0500
Message-ID: <20220204190357.94538-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204190357.94538-1-jdhillon@amd.com>
References: <20220204190357.94538-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1c9d77-3a03-462b-8c41-08d9e8112494
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15195DCEE311B3B9DA0AC55AFB299@MWHPR12MB1519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qr7sFxWZ49TBZz/b9Bj/HPbVzfD12q57rXJcRcooUr1DvHDdq3Wyk8/QDupQiFF0mZpXi0v8J6Isxdw8sYUED6b+LDvb3Wgb7m6QJ62J5rGr74rl2GcN5gDDM2II/wIGYUE+UMM3vjJpZCfeT/5dd4Ji9GRas8baBCjG7G0rbiZ6wD3IVNahLdRxo+tlgxie6o5AvxaufZeKsnWmG5cUsJmeCx1XfgHkzE9IvaFpxav+WMtbK/hL+3hcCggY6e1hH67w05iQ97oSqTHHQE6bp0M9/O9GaoX4Rq+bAS8aT9G4gmGcJl8bPaknDQj4KuLNerX3Pc83u2HGCIx8Wsri4v+jRnhQGkD92AqLkScsmryZG55FlR+CPcFCiCj/BQFPhV80+VEzkEhJS0bnpDNzqSaItCmOPggAAtKRczL3KgVGulcCvw0z6BtLYNHoUevZg3ZEb1c03P93VvkWgUkzR139hVmdGpHKLPN3w4FhA78baQLFD3Xw6Nd0z8LpwSU+tAwN5kPoca3PgWyJ5w2/z8RnbTSctchFY+EiTlS2QfBXAq/dXYGLsjbiQJudYjbxby48IIX6EDcnJ4FrNSliy3Urmtd4taGcuuF2JKnMNdUDs2nKXRNUaqveR6AVz0IoaWgRiMJKThENI4xIc30C+lpYJFthhULwxwcxk0+OmqefOqqovQFHbp3FaJR4hq1ODjsWr9bASMPNSImguAMBSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(8936002)(336012)(83380400001)(2616005)(36756003)(26005)(1076003)(82310400004)(426003)(36860700001)(47076005)(16526019)(70586007)(70206006)(186003)(6916009)(54906003)(4326008)(508600001)(316002)(2906002)(40460700003)(6666004)(4744005)(356005)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:04:17.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c9d77-3a03-462b-8c41-08d9e8112494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Build failure due to ‘status’ may be used uninitialized

[How]
Initialize status to LINK_TRAINING_SUCCESS

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 18fe8f77821a..d0cb40df60a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3199,7 +3199,7 @@ static bool dp_verify_link_cap(
 	bool success = false;
 	bool skip_video_pattern;
 	enum clock_source_id dp_cs_id = get_clock_source_id(link);
-	enum link_training_result status;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union hpd_irq_data irq_data;
 	struct link_resource link_res;
 
-- 
2.25.1

