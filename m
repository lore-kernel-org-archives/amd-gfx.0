Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48922C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D119F10E4E2;
	Thu,  4 Jan 2024 15:53:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FAA10E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzL4CZWT+rCwasa0nrcTnMt68Xd/5wWD0yvuwlLfYa7oajkSf1gbs1MgGYtnWSmMoiP2ugONcf75ssa37mRfSDsrw28aUZGiMb5/moqXStEO4k8dZe8Zuua6MeYHVHmz4nrR443kKNxjBb9+nsalFlEnIVNx3KZDkQt+QhraEbynfCRxPB4gNsHEpzloqcgSYMWDPw3I+aG4kBSZaTxYtYewiqmIDthWsviNXz705OfDttPgojxxYIpx+DuVAjkXTnl6olEoDvTpMTIkQOzUuPIZVMe2kktAO9QMbVW0VPdWiXWWUmySBf2DNgEVhAhGv3AmTSBiFkFrRGo6dtyh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdzawEDvA1hCdNBA9S012qi/0yzbYs/7zASoF2MUK3w=;
 b=ZVTsQw6eZ8lNH8wz0O0jWoiUC3Hid1Ujfx5HfUscj5GM9cXsQK5FFv5tnHqjjtMhELqa9Py6DxxKlWkdx/4jooMj/COVKnNhiX5Ds9NQUmbK684kQGPn/VyXEdgxzD0awpj1ckX7SgCl2gIrtOhDHTvqc/Nzq2yVrBnxIEevbSPuSSxAo/Ro9u0ACGS9vIi5wU/V4HWfBnTb8IXDP9CLyMPSsxv8MZEBkOkRYsbZAFGRl6azGE2L4ORAS+coplLBZEIYmZJLYtxnfU49h81EPlyBlVf7m53hyDhdN4YJkScc6mmfZ//enBmR56+d/9DE58FgJ4ubUWOt6KI/6smAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdzawEDvA1hCdNBA9S012qi/0yzbYs/7zASoF2MUK3w=;
 b=XXif/NWuGIbfn29vzc9ajd8fDRIWSHXdaDqyWK8PhxZX2UpWSnpAVNRM5R/mOINTVCY4hZWkggFFqkRgBGHOFY0ukWV7X/9+8NVATqU02x+5TqGLx92Jb8azUH81pxjaIo2AEPC1aVv4TR4R3GyoOXwUMo9XDYWpjcEf1wwVVGI=
Received: from PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 15:53:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::8d) by PH0P220CA0027.outlook.office365.com
 (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:27 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amd/display: Dpia hpd status not in sync after S4
Date: Thu, 4 Jan 2024 08:51:05 -0700
Message-ID: <20240104155238.454117-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: dce06bd0-d99d-472c-7718-08dc0d3d4c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7osKx3k4zLDUqt2PAqrr0XjfMHb8ldotGfJdDTl3JmyaSofPI2Ab3vnhwJOIo/tlwSVJF6WooVLGrDH05XBwCX04YG1svaiFAJ6CtYO72+kowZboxF4u2q9Os2+g9bTagUY5Dv9xPKd3WeTjgLMCVTHJr5crbmIZKaqiU5ZTaImmM7G6EA1M8bv+JqgMdMNGMkjA7Ey+C9lUTRwYq4DR8vEUaftTYY34wDK5hd4Gc3ENprMt2Ctw100Qq/rXQ07Jzzphdv+MC+qkkD0e2Txd43+07nC5U1uw7Q747ZTwIMrayJLqZHu8VFvoktNnGjTxwZsa6wfkooNHk0kvXPqwb6lKpYBRw/e6N3MubHoti2Xe2sda11tn+0vQunyNyH0ooQ8cbYOLi7VCVvjbitqaURMDPTTua0ScMLSoFFpDmBahKhlOc9NsfmV4gyg2un74/i35QCypJl9OBk5iO2teGor+HTi0keIeQPW9v8BM0TmduOIZRAqLdgiMjJuV7CoHTCVJ1cy0FSREfHpLhrvaW7BwGhgfHV0M2dQeOzITAdwiSVdyRGkPZe9NcqKFu2bB6dUYKc0sL41ng/wt/4nK9DLm3zBmTmqLcD2/TYYljb12VdT2HKd6QpEMLhpHa46RppSg9cHPa7Gr81IkkicKw92t5RvIlTwqsZbU95IkI4WUdRJYuHY80F4rx9ug7rCcGwIs+FNs8xav9+cl/P+KM7y8YhCfGfxd2Uu1rEGjU/0VVFQ/dNFwXgMWCjMeIvJnd1WVAL+sxFEmjM3gDtMcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(46966006)(36840700001)(40470700004)(86362001)(336012)(2616005)(26005)(1076003)(426003)(6666004)(16526019)(478600001)(36860700001)(83380400001)(47076005)(2906002)(5660300002)(70586007)(41300700001)(70206006)(8676002)(8936002)(4326008)(6916009)(316002)(54906003)(356005)(81166007)(82740400003)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:30.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce06bd0-d99d-472c-7718-08dc0d3d4c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Dpia hpd status not in sync causing driver not enabling BW Alloc after
S4.

[How]
Update hpd_status of the link when querying hpd state from dmub in
dpia_query_hpd_status().

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 .../display/dc/link/protocols/link_dp_dpia.c  | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index 982eda3c46f5..6af42ba9885c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -82,25 +82,33 @@ bool dpia_query_hpd_status(struct dc_link *link)
 {
 	union dmub_rb_cmd cmd = {0};
 	struct dc_dmub_srv *dmub_srv = link->ctx->dmub_srv;
-	bool is_hpd_high = false;
 
 	/* prepare QUERY_HPD command */
 	cmd.query_hpd.header.type = DMUB_CMD__QUERY_HPD_STATE;
 	cmd.query_hpd.data.instance = link->link_id.enum_id - ENUM_ID_1;
 	cmd.query_hpd.data.ch_type = AUX_CHANNEL_DPIA;
 
-	/* Return HPD status reported by DMUB if query successfully executed. */
-	if (dc_wake_and_execute_dmub_cmd(dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) &&
-	    cmd.query_hpd.data.status == AUX_RET_SUCCESS)
-		is_hpd_high = cmd.query_hpd.data.result;
-
-	DC_LOG_DEBUG("%s: link(%d) dpia(%d) cmd_status(%d) result(%d)\n",
-		__func__,
-		link->link_index,
-		link->link_id.enum_id - ENUM_ID_1,
-		cmd.query_hpd.data.status,
-		cmd.query_hpd.data.result);
-
-	return is_hpd_high;
+	/* Query dpia hpd status from dmub */
+	if (dc_wake_and_execute_dmub_cmd(dmub_srv->ctx, &cmd,
+		DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) &&
+	    cmd.query_hpd.data.status == AUX_RET_SUCCESS) {
+		DC_LOG_DEBUG("%s: for link(%d) dpia(%d) success, current_hpd_status(%d) new_hpd_status(%d)\n",
+			__func__,
+			link->link_index,
+			link->link_id.enum_id - ENUM_ID_1,
+			link->hpd_status,
+			cmd.query_hpd.data.result);
+		link->hpd_status = cmd.query_hpd.data.result;
+	} else {
+		DC_LOG_ERROR("%s: for link(%d) dpia(%d) failed with status(%d), current_hpd_status(%d) new_hpd_status(0)\n",
+			__func__,
+			link->link_index,
+			link->link_id.enum_id - ENUM_ID_1,
+			cmd.query_hpd.data.status,
+			link->hpd_status);
+		link->hpd_status = false;
+	}
+
+	return link->hpd_status;
 }
 
-- 
2.43.0

