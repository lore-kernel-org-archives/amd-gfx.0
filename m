Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98535ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E2610E80E;
	Wed, 14 Sep 2022 03:53:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE44710E80E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0aaVcXzQLVP+Xm1GyxNQws0pCKjh+COrYmCYS7dvQOxFfu1EySfHmQkO0sNynsIx8Mz/EmIo8eePtwTvZyiWcppqesJbgs3VjUl6M7zlpmyo084AC4RK5xZC10nuUsiDdyqaSftfA5LPrkELJ4sk4626QfX57iStBqCTP5dTR9N/DKL1xiEKS24xmF6teVAHap32IQgBhiRcSq1iBO6vLGuZ+6gDuhzuYhKOXwx3DfuwmqCiEIuMS7J40z5SjXkNd8uz9N7eZq/ZeQH05iUGaOjdR3JqdiHOrbP86USzolKMUAm46opRozMuY6GHSaIWrAvOg3m2FQpTgeeX5aTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=nrPMsNrn/+VEJ6jUHLCCpZcCbHuCi7woN2/sp0AgME+hkdbOqlZzUglgogsZHCfn1OgRZ3Mcb3Rr2dwKxLFL56d3yz6jd8Mp3XE+k8LwQj/FK9Uf6Grg6b30t8F0/jysPr+wC1skEDMyzHBnm7IOqDlz8Iqeq59CqkeLZmL1BU/n2knvxF0PSIbkGCiPIPAbCB+/Vxz9RICgj+QKY6e4PvfGy71k0z1xq3x3tod5NSM3nKpuXJw99qF2Q+cDhE+jxST2cP6NZthecCw/0xP5dMBB15aSstdxBVcQal6z1vhgZGaU7bFO70phslz7x5aN+9REU3Cq9vB8ARbCXQzFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=TwsP0FXplnKzjYp0nl/Mvz4xUbnFeLWvcwATQ+3SrJscDut8HQp0s7lRlAnooOFoeD1UwL/g1hMWV4wBfKtz9Zr0iQBP1jx2RKQXA1tF1A6uJsRQq31Zjx5pVxBhjkipAveKyF5XFtti+bCXi3E1MgBFMN+NiwSEYrv+dm3PIjw=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:53:29 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::50) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:53:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:53:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 22/47] drm/amd/display: Uncomment SubVP pipe split
 assignment in driver
Date: Wed, 14 Sep 2022 11:47:43 +0800
Message-ID: <20220914034808.1093521-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: e69fb7a9-2a5f-4f8d-2b81-08da9604aefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP1+bD37FhXEe2BOYCfGR6mTeAPUYryAPXDpv09s3ctpg1d6WsIUgbZBy8FbX7+VNMOxURJPrchhq3igeQi70UaDO1fM2M8pOr8hg3k9Sw/KhhP85+FQzq78kw/M6Nje5A4xnKeMo+/dxkVtyGF+F5dy3QVxd2aTMgEU7gLmPaAfPZ202VYBzoEHMvS2yZajwrzz+Ba0UBs5N7Z6cZv2Lj5vcIb4QMcts1AA00AqC2U52vSJ9vPoYWv1QXIBZYMy6B1NLGKpiMMZoRtSrFSa2BPpvCTH171rVT1GR6om3gC97/0Ci74DUCOI6FjBBhM2LrsaULxfB72ukwk/kHv8dB1NvWZmH9ygkxbJl9LqkNxO2IEF73xkAdHXx3MKleu0A7k1S3DQIoCkhTXNvviKN9XXIs/XRT6D8DXw8acL9LkT5UApIKIu2BOl6mpBzmfRj+1wdXZFcdOq2AzYFyCGle30o5Em47gdUzGNfp6ezrsFmeUvb5xWdQ7jcbjgpENfmLEkJZYoEhm8T7g9CVTrcUQAZhLFfUfeb8qMdwISsGbCF98Wzfxoen3Nhg64gtxpqfy6qDwi8fzYzYp+qXszL50+7iJ483QCPEgpzy/ywpa71hHuBOIVyagAaVSuBj2n5i2LafV4X+EYGbHy5kLAfe2vrfjx47QyeLJMrNv+zWSCwaVodzd/QmW4DtateJJKbJkN2bAKemOBwbMIdfuWmmjj0vpp88EMlvZRxIIC2Be+kRnxZEGVrNPB9v5Vii/2PqP/MoDX3QsPdpApCtu9Hk3MWeGJ+Nc88eHuS4XcGzUa8dRVYGCDXqqWLjV1wLm+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(86362001)(82740400003)(8676002)(336012)(70206006)(5660300002)(40460700003)(26005)(70586007)(81166007)(7696005)(426003)(356005)(316002)(6916009)(8936002)(6666004)(41300700001)(47076005)(4326008)(2616005)(36860700001)(2906002)(83380400001)(40480700001)(36756003)(1076003)(186003)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:53:28.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69fb7a9-2a5f-4f8d-2b81-08da9604aefa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Uncomment SubVP pipe split assignment in driver since FW headers
are now promoted

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f09a3ddcf30d..89d7d3fd3321 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -675,7 +675,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 
-	/* TODO: Uncomment once FW headers are promoted
 	if (subvp_pipe->bottom_pipe) {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->bottom_pipe->pipe_idx;
 	} else if (subvp_pipe->next_odm_pipe) {
@@ -683,7 +682,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	} else {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0;
 	}
-	*/
 
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -691,7 +689,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 		if (phantom_pipe->stream == subvp_pipe->stream->mall_stream_config.paired_stream) {
 			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->pipe_idx;
-			/* TODO: Uncomment once FW headers are promoted
 			if (phantom_pipe->bottom_pipe) {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->pipe_idx;
 			} else if (phantom_pipe->next_odm_pipe) {
@@ -699,7 +696,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			} else {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0;
 			}
-			*/
 			break;
 		}
 	}
-- 
2.37.3

