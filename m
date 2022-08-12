Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A531C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AF1AF57D;
	Sat, 13 Aug 2022 02:13:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B595AB952
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db80oGN+3ekXcwsQj2qQ+V+7vAp71YqLh3/b2hE9CeKm5R5UBD4BElmMiyoAcdNqN93rfCL54ai1J3I4HgohPO1lOz+Cbuwsf6hgTRyVV53izY7PCRzhbHOIP4ER7G/z4tYV+WKzP2NiQqIprA9IScsYATMxtxuhbIwM2NnXPUKtR9jqD4AweywG4lUBTQRaJnLHljFKx+WWvexHneayOKsMu9HIKnDTY43yuog5YHsJmIiUVI05JnkdrQ2d8q5iQwxy/jxpyYPVDb0dOQRy+FPagZHPa/jyx1/xyIqjWvTxjTq8iMgoYPpXkSMgn+Krrl4GERwlSivc7uXKDB2x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3mTkc/t5HfKb5Ah0fihUe+9JSD10K7pyNf4T++ahp0=;
 b=n6JJG8j0PnRjcv/7i7mN8mgKhjKFaGItFuKeiea3IaLKSKHF+ujWnKv5RgGS62bGUygFmutpXrDRoWfWcXn6kx9ZY/fq6Hgzpai/+b/zfaj9MIsnPfV7rLHvU01jWDbWwoJV0q0kfkP5H7qdr1HgsjONt6X9DIPFLWlSPnwV6HZeoFMhvN5JWighJp++yuECFDCBsKuy20BIbaGhzAkcJI+vfCmzFjh/Q7bEGtdtB//bbVQWM6NldDp1zaYHo+82z53TijRmlJg0l2yAq+zy7oH0PkOH4rEH5oWXvWdnN2uutQ6h1d5P1laafkzauPeQ6p2YWAS4KNwQC3b5EP81/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3mTkc/t5HfKb5Ah0fihUe+9JSD10K7pyNf4T++ahp0=;
 b=ncl6daGpL3ZHYlZmSRMz32QknShmHRdiZf9C8p/DQwp/73s8Dx17m6xpPZq5aDg8J/joEEzuUPgFnra9ZKfCjsy0foFMEF+D0Q7nMXJwgyRHZatIMGUi3TLlYuonQo+A3qn++AgMomj0S0Nj5N/o3KONX0hfukNVVEzSzDYSBEo=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by MWHPR12MB1824.namprd12.prod.outlook.com (2603:10b6:300:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 13 Aug
 2022 02:12:53 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.14 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:29 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:25
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] Add reserved dc_log_type.
Date: Sat, 13 Aug 2022 06:12:12 +0800
Message-ID: <20220812221222.1700948-5-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5596fa75-4621-4cd9-3677-08da7cd1544e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1824:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0d5USomP53M9gTL+HOGrQykUoT1e9/x0RIoSL6fdPo54kt5yYSBIg2nrQWdiJstbsXXB1OZwYy5gKL17xqboE760VxK6E4ZzzhXktuTUwkU4Qp6u7OckFGD7RM0G2Uo71hHOX767L75BgtvEF7iPYtZyR27XLA7YxzJGIItqgE5n19Pje+eqjhEhZcaKl+349ZQhUssuo9vDykqF3mKB1fHc+6HV+7SGzpC65Q3+qn1dUunx/CoVCdKXoENGdmHAlLF8uTMckIkc0LjcI+rOQYGS6eR7oqosBFGcjOGpv59OzbGCxyYOMQYwP54PLvjJc1lCAbTI4KVGTfsqkVFmjUVAiApTbyIi0N86qp1ozB5TT1uqFPm7SRUWwzPvKu5rdKWJY5FXrnRSeFdD3C8U/PihT6JGOJRXnYK6co0i07idMCAqAkwZW6WTwEVU6iST3aZa093KOvw9WvpQqLBEej7CFKzf7Tkxyaj4Rao2J1o8/Xmxjera1LNbOOVIAXXXl8IAaLApaYfmQFx5XzwrSg1zt2wgj1now/1zqt8Wo02uSiA8SdcS5/dzX5gB+didh1biVtrF9na5E4MDtHZomoMsciORpZzCC3g9qV3S/sdBLCeHJrGSgBOLgc+5MW/sZBWkF5Er7drIR741GVr8046xq5LCOqDpeM2wSm3W57bdSvQpYiNMfzIRjSCqz27OnQT8G2kJag3B9w9A7IGTGaJ6xKOrSMZyshnSrhR78SGBHtginw2zBPmCRnoIVTUsNZqxOnsjQiV9RJI1kwScgm1Pp8BrWBK02dHnXTitjJVHUFwdhZeeAm/trQJ7xvSW46C2F/qUy6wau8ba3Heqq5KRVqMEpa/jUexvM8FnSY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(81166007)(356005)(36860700001)(7696005)(6666004)(40480700001)(83380400001)(26005)(41300700001)(70586007)(82740400003)(82310400005)(40460700003)(70206006)(336012)(186003)(8676002)(426003)(1076003)(2616005)(47076005)(4326008)(478600001)(5660300002)(316002)(54906003)(6916009)(86362001)(8936002)(4744005)(36756003)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:52.9673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5596fa75-4621-4cd9-3677-08da7cd1544e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1824
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/include/logger_types.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index f093b49c5e6e..3bf08a60c45c 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -119,13 +119,15 @@ enum dc_log_type {
 	LOG_HDMI_RETIMER_REDRIVER,
 	LOG_DSC,
 	LOG_SMU_MSG,
+	LOG_DC2RESERVED4,
+	LOG_DC2RESERVED5,
 	LOG_DWB,
 	LOG_GAMMA_DEBUG,
 	LOG_MAX_HW_POINTS,
 	LOG_ALL_TF_CHANNELS,
 	LOG_SAMPLE_1DLUT,
 	LOG_DP2,
-	LOG_SECTION_TOTAL_COUNT
+	LOG_DC2RESERVED12,
 };
 
 #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
-- 
2.25.1

