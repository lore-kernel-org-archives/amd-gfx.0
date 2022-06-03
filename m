Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB50C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFF6112441;
	Fri,  3 Jun 2022 20:13:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BBA11243A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQRTUQ4dNFqMQY4HYuanZsWckvBnIK1SveqMEWtbR7pfNxileG+u6qrdUF9BWIc0ihH+7J3Sm/WB0zdTumej0bbL9kOctk14VJ2n7onzyGpDuXB4jsJ8yE6WqaCBL3+V9xLA3Xs1S0tfRctFwxOwvi+JYEVtVdbyPxicx8DkzSn/2K2uIJpRzuWbCkkAMYBunsf9+G4cTINwry2rLhf5L8dqUR2bF1dUpzgtRnP8J7SQ/QkGf4nc+2ArxzwnndpbtU39L5QgvKpN6fP4Qv37/5rVYNvQZVMh994f/MaQny+viPMFq1jZaW62Y4sG/jjmVy1ObCd5nK6fdVhcHzphjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+VLt0M23CeyWTWfFMJ4oilVYQ8Urgvny6FbmNZa1bA=;
 b=SbfL/XF1hz9c9u6xudKX+/Hj4BHsvmSExKq+exG5g40PFMPfOrULFWv5g0AL6Hnb29Szrt6W9utpJqjRa0G/Uoe/g82IuQPzflplJFNR9Ir2g2SSG7BsnRitLOtBTrv9EvsuhxHILfWHJZq5/CaKSlv2iv9/0BR7236jbdZXN+vE1zVrAEwP5M7IEOOi7W5VhpQxhvfRajgmOZs4fFISsZNTHU0P3YGmfqbhEv3ntEtcDd4jhDtdxkSUpVbmTWkDEnapGDLIZKlYv+1BMoepviQMy9VKPY4G7it8/8y66Adt7AKEPltEZY8zulHtfogUrq/7K5Qnjekb8+eXnPNqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+VLt0M23CeyWTWfFMJ4oilVYQ8Urgvny6FbmNZa1bA=;
 b=JbAge2OGjz2y2jZFmDmzrCk9KMXOfyKtniEU4Fyao1r0/uUUaSqxlMM/yY6b3PD4DTI4jPIQareJYK03eMwCU5dxBTZqFScZ8v6CodzpFRPvWakVpiNdAPeMjxW6luDrVOwDPSx1ltnwuoEmPgl0QCg+m31iPuCqcfx7auryf5g=
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by BL0PR12MB2579.namprd12.prod.outlook.com (2603:10b6:207:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 20:13:03 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::4c) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 20:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:13:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:47 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: Add HDMI member to DTO
Date: Fri, 3 Jun 2022 16:11:46 -0400
Message-ID: <20220603201147.121817-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1525f6ac-b245-4ee6-bb70-08da459d76bb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2579:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2579AAE6E4A7C145F325C9F5F4A19@BL0PR12MB2579.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWxoGKtbMbqdVfvClX2FI5gi1uNwCZsj2KI1yUR+4umPtdI1Eqqptt7rhBUQ2wdjgoN32Vmkewxa4K0or8LYt7HLmlvjMGqwV2QgkrspzYCkbtYAPMb73o35Phfc7aE3q6oytoAgFoO0it9uLld0oUu4cflQ23phNAMsiZyw1B/vtfYHfIGdNBvY6OtYlAcm7OrRlX2fHcxNyyM6be+Q7NzfZSp6Rvsb/3Ka+un6Z+ySTHGDxGCRGN3dcErOhvJsFcbsKkgutfhPkeeG1lLPLjY4rWeV8zUOM2nRwy0xKCcjzpaBXgtVcWotctmvMgWtJN0W1Nduk341AlTOO3MKGLu02Fbxvnv5nM14CJZt8AOrbi/JGFV0wunfMv/3Fu+0Gu+39AmMVFaIw5JRP50be1iEnJGb2iXQpC3hMzsKVmySeuP98Yh09vSHOVTxRvrMt/605Ya4w+cHBkB6ITrgq47yWi0ebcro2vjwXSo5h8SdNqh3wj/LW+eaDsX/DjRTYJvYVTdhU7H8VnuK6Ww1rL09oP5DLdpjxOzb+bMZEpxHPi3QToseocskTy6iPawInPhd0FulJbXbTnUvMYELejRtbxNx8IKNMcvORUXP+p6r2kl39BXT93mPw9Cz+4E9G73fm9YslIAI/KiMQGZfbg/26C35dO5Ac9Ov3hLDBdRx7JNcT/00KqQPlqXAzX1Zvzlg2JbFTokdY3nMwU3zig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(26005)(44832011)(2906002)(356005)(5660300002)(47076005)(82310400005)(2616005)(1076003)(426003)(4744005)(36756003)(8936002)(316002)(186003)(16526019)(4326008)(8676002)(86362001)(336012)(70586007)(70206006)(6916009)(54906003)(508600001)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:13:02.9605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1525f6ac-b245-4ee6-bb70-08da459d76bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2579
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
For Pixel Rate control, when on HDMI, HDMI DTO
should be selected instead of DP DTO.

[How]
Add HDMI member to dtbclk_dto_params, so it can be used tell apart HDMI
and DP DTO in the future.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index c1023cc84f55..c02f300884a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -72,6 +72,7 @@ struct dtbclk_dto_params {
 	int req_audio_dtbclk_khz;
 	int num_odm_segments;
 	int ref_dtbclk_khz;
+	bool is_hdmi;
 };
 
 struct dccg_funcs {
-- 
2.36.1

