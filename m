Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95830C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 18:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF3D10E665;
	Mon, 24 Jan 2022 18:57:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9FA10E665
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 18:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9bnFubIAMk32Syyjs+40MJaYl7FWBX6YQm14Eja57zx3z17cmjVnu1jxnOT2oK28zRbB367qLphG7ws/f2BMdSXFrKgcvmdHzx3WIovRwcVot7qs+kWxIGRPF/qZ+7XIGvpKHXpEKD2E3KFkKM4uakLK/FP7iMtlVc8IdGsYkeW65fZ4m1FW8c7x2BdkANur49aJbMYKDW6yFMGJ/2FqIs3tzIgHss0YF0SnN3+sq9RJ9YJM7U7/zOtZ66J1beGz38x9CGSJX5wmiOQRXLj+gV7xrW/JOJn5UUN/fmT5ETRagmA9a0rC8X9Zh00daaVoSxNRbykp4Kp8zRF5AncfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYchtXKH71er6TBD+z23jUp7ZN1vcfTyJFXlo8CyNUY=;
 b=LCcRFlyeV0busV/+Z7w+Nu1kiKlbKqJCh+anPB1gw6BRz6d1M3wuNp/vn2EtymJBHycvC+Ms8RXMzyn/l4v34/eNB0/z30dBRUQKgsmj/8TGXfd8iIQ7hSrWsNF0BJHkBks8u2wEUF+iFuZQty1Pf77X8TWE5dSHRd5cYDTlSCP0d9qwrsJQR00+LbOb3zUKw5R4tFXVUc3HTg1wRAYHNsrwlupJd0IU4t2k4Udj1Ejo8527BjMtIcDWgr8E7GObRTYxfhXuNnQUS/eSIVRkHq9gKL5LvoJzm2cUcl9nycmPZuxRgBUIttn12CINcX03sLtFfYm/yVvcDwtp2vedcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYchtXKH71er6TBD+z23jUp7ZN1vcfTyJFXlo8CyNUY=;
 b=xSJdOcaLqYNJSUS6RjtnZMItp/TQ1pIUdxIHbbLG1DNPoO9SpA7rMDbi1+QuGhd++jdbA93eZettNFTyv2NINKz/fGnyUXVQqGM54ecYEEc4CkdsP95HmpuGTTu8nr0KyUE41IDvwwJnLRW8WnMRH/eIQN7uPL7KbQGVqY6JIaA=
Received: from MWHPR21CA0067.namprd21.prod.outlook.com (2603:10b6:300:db::29)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 18:57:12 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::65) by MWHPR21CA0067.outlook.office365.com
 (2603:10b6:300:db::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.4 via Frontend
 Transport; Mon, 24 Jan 2022 18:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 18:57:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 12:57:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 10:57:10 -0800
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 24 Jan 2022 12:57:09 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Call dc_stream_release for remove link enc
 assignment
Date: Mon, 24 Jan 2022 13:57:01 -0500
Message-ID: <20220124185701.54981-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6630ed73-4d0a-4ecd-a9a8-08d9df6b5442
X-MS-TrafficTypeDiagnostic: CH2PR12MB5516:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5516CBC489E4B1BDD6B38771EC5E9@CH2PR12MB5516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +O8b76zBo5TviUb5iWk7D+7dO7xxDqylFRjtf+rdH8YN0VrYLIY5ccHMEEBrGyAMx/ybkXa4HgOJssXW5hz5hsDc8B000Rz+Z1Ei9n7WVDUkeTuiWuXY27qIO8E0JiTS1CGBny84myNMDV1SHOw8hbMUdZ7/vw84W/8EO1T9QuBNAXTd+FdCVeUVNlN5h1Vb0Gyze/jkXQGuiF+waCaIqVD2WxGBpn+sSufk+xAZ/ziCTvYSM7RJvtmgK4H5+s1bvRYfOjKAvppL5NC8MNjBgizgS5cedRUg6rmXr1xBXlugAgLpkN00BEAPgntbkH481OdZsTDnKfymwbOzNWQMvLvnvcoyHmd/PJHFBdWHj86ArZsIppPoF7loRwt82HSsEv2WYozYs8xr3iEiza0l9+A9r5tZFc6YeQwnQeAMY0+2XCwB4LOc36IEK0DhfQ5QqiIZ+twYSsnDjYsVhc7S9ohqpq+/dkXiquSyPvqFr47ds6uUD/bkOKCPSZBi7AqBTHfdhS3qYL6J9ND5zYcivbwPjyo+QjMpvBjqg/Of1xBHYlPBvLwTskzT7T3zTZvwJiIDCkPwg4kEZVVxa7FQnrEjmvNRVPET0bjtYOWZdsHBiwH9jwcIeLTz7AKW+Tbl8rceVEv08uXkwGmCmn6dkuYLXSMH47hO4Oz7p1hcjexEq0k6HLYmP46MeZoBMb8wHwM82eXq4jb2bu7/kcGuFZpFZx/OGV4lBZicyVchsKDIhY3ilQ2lviY5Lk3kLD9a0m8UDYCS09/zdROhPGZe2W5bTX+hokoxZ7aX+TcmoUw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(82310400004)(40460700003)(44832011)(336012)(4326008)(508600001)(5660300002)(47076005)(26005)(186003)(426003)(6916009)(2616005)(36756003)(86362001)(316002)(54906003)(356005)(81166007)(2906002)(70206006)(8676002)(70586007)(6666004)(1076003)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:57:11.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6630ed73-4d0a-4ecd-a9a8-08d9df6b5442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
A porting error resulted in the stream assignment for the link
being retained without being released - a memory leak.

[How]
Fix the porting error by adding back the dc_stream_release() intended
as part of the original patch.

Fixes: 2e45b19dd882 ("drm/amd/display: retain/release at proper places in link_enc assignment")

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index a55944da8d53..00f72f66a7ef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -122,6 +122,7 @@ static void remove_link_enc_assignment(
 				stream->link_enc = NULL;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
+				dc_stream_release(stream);
 				break;
 			}
 		}
-- 
2.25.1

