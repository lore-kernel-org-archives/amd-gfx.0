Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5900EC27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BA410EAE3;
	Thu,  6 Jun 2024 21:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TyQOdnRz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF97A10EAD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REB+QHTEJloTQchxnTKTkNcYhNB2LcDMMB7Cs7ZZ+TQIleS+ueNih6AR8nJ/TF/u1EAZtVZDBF1HOLsh6XrEhO5S/uv5Y7FVqEZ2XEMAFjQA7L5doz8M5zhqXTJDqQb3v44GT6J6ogFc/IVZqSnYya3KUjRVQYJayepqEWbF7cUvgnUUCTudhD6aQQFOjVSOdSyiehHFJ3FnZM8CYSxNbZVkLlkCTfQQu+b1lGQAAKlR41Id4QK04+C3qpNti75g/hKbPK6DqoDAbomiRXWxCMFp0CRgUU0Vif53oVuHU8/HbloBbkcuZvGqKc/q9BHBL1k39vyk/L1HcZzZXXJx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lORDzSohIgp3iqqW27E5Guex4BH7Ns8GXamXs291qJ4=;
 b=QEkksxlLliBU4+DlUx9dUaPCmdUW4/KiKnUUNv7k1N5VO0AxYKWCRNCMGkapP58viQfCAV4fVacqnPmqyIRrHBA+0CuK+5Vx4FIoiRf9yNetthVEqfQQgwkOfiHzC4siLhV5w0ENOivVz8GsGaRVYuVdA+gs+FYXu4ydKChd08dy7k4NkHnFMGS2RKH4/5o/dWExpiodGGohBNZAn+mofn4gqDR/S5Ac3+OgnqAMc+NLxXOaVoN1xJXOA0WBHi9QeQR7rSP7YElYiKUc/8vg2dPkhIqgugQyTlYBi7pDbQMapAzucZrj25K3HjICmJGFWoP0MNp7UxQ9zHaUMjuhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lORDzSohIgp3iqqW27E5Guex4BH7Ns8GXamXs291qJ4=;
 b=TyQOdnRzi83boDsz1iLUQXdNaMomY8LEfN6c1PzdOVQDyKSmkI/LO0JYxvABixZqF25bHj0q1+8zgLgweUPI0+RRvpD3fvQgfpkQVj8TEP085JfP9RxTRNtX15xtoagRYK5TTlgtkuRW4mvjiG6kIuXgkjiAILaT5CCIrj372B8=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:36 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::fb) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:36 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:34 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 24/67] drm/amd/display: Ignore UHBR13.5 cable ID cap for
 passive cable max link rate
Date: Thu, 6 Jun 2024 17:55:49 -0400
Message-ID: <20240606215632.4061204-25-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e96a34-b254-4a6f-0731-08dc8673ad10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NLNnkQhK4qRLSRkTAkhuWTFCTMXOVqgx+jqlu8aXBkPxD+GsWMnUetTZ2lhI?=
 =?us-ascii?Q?06w0EDPuAPwRNADgZxJl7er54fRGJICcEbttbu1ikXTiWd1WqubvNa4CGhX5?=
 =?us-ascii?Q?rDMA/WdWkSjKLy5BVdbT6yCAGGoCknleBcI2LMRUDHMp0FiOzoo26g9w10aq?=
 =?us-ascii?Q?DVFyu4GmyTrRnpFcyc2BMPNwrTN70MtnT8zDe9yl2hPECvtD1YVKn3CjheYO?=
 =?us-ascii?Q?j/zuQugFeC8UIZqlOf3LEb2RdRgmLBlS4hEaEbPH6E/WeufjdFnGc8CGgGZG?=
 =?us-ascii?Q?PucXTxmss2omlfH0lUW6k0L7T15aajsOvw53pOdzp7TOHYWLuIu3RLjLcLXL?=
 =?us-ascii?Q?4OiHVlyUbt/oDMxgeh8wbZuAvhShxHWMbw6vz13l1Ecs+94Kf4RhcLFdTawC?=
 =?us-ascii?Q?EyWw+US9bDis5fFe/ZMjlcPdx5r78vtJ19DWvbQOKL/PK69kDPFfLxl7uJnf?=
 =?us-ascii?Q?wskPCM3zNqgFiG1Kqo1v0aaDVoeBMBwq8I3iMsffC6a5hhOEpgW9xcX8ok8j?=
 =?us-ascii?Q?YbUvx5t5fSh4xVxtZJMPWH7ilx7/w0vQ9/bs2kOiKVZWiU81AlfmotvLhcQq?=
 =?us-ascii?Q?O9gKGDU+u3jprQIgo7+LJTfQrdvW8vNc4qFcsV+qqbYT+ckqoK1vN+j24hT6?=
 =?us-ascii?Q?GM+6msuc+l56qGlGEO1A3K3AFPmDXTDTiL35rwinifwW5UQ2RovAiKhs1Xjl?=
 =?us-ascii?Q?muHCf0IiEyWcrRVdXpF+BeAgcR3k1OAZUwspaJFOEvPgGjBPvqRuWKPpAqbP?=
 =?us-ascii?Q?l0E0I7jYQoVGyRueTQuRDhTFeApS8WpoP+Wt4iFmP9e5+KovjsU07it171+i?=
 =?us-ascii?Q?y0VSv9Lswq/im0DaN9zGf/h4jEkAWDD801meVhZjl41FplVD++edJrajZWsc?=
 =?us-ascii?Q?7rs8p8Vde/7Sl6tsY2Uoqupi5EfKrOc00JqP0CLTDYvaDJnAIfmo3KCrCcoO?=
 =?us-ascii?Q?1U0tLPaLxxE2CPf1T9M2J2QRMKneRqVQex7wWXRJc8mmmzZLK9uHR4LFwOXf?=
 =?us-ascii?Q?KBXUnaQyLl2g8mrEavjGzj4QSvWGKJxGXTGoUZAIdgghUncJfwaSYDv/6kr5?=
 =?us-ascii?Q?vk56GjAL1dXdrcuBP/oIZy/WcgVaUbSD3sz8hiZbDyOlx/r293eC3qNHhhN9?=
 =?us-ascii?Q?hwV6JKDN6NykblLI97S1n7gft2quLuGgIy5KPQXQz0CToKW1aKSNRTGMaire?=
 =?us-ascii?Q?mavw51Sd4tc1aAaZVflCqIuyt+M8Fge5YdOFMWQpyUq5OIt8c0k24RpEbVl4?=
 =?us-ascii?Q?wBR1y1+dElGrd0cYHKin1zgbXKj3hDaaWwGjWudAbskPu/oiA9mRkcQ3DpyQ?=
 =?us-ascii?Q?LfXwKvdPWV77UIwvLCgCQmlFVMKEtA354QeYX+5sh/dRYAb2jj06FMLX9r7X?=
 =?us-ascii?Q?aYQ9hGff7MvafsJFisFms1YLS1OECVo2ryiBh9XoXBQOmob5dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:36.2012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e96a34-b254-4a6f-0731-08dc8673ad10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Passive DP40 cables were updated in the latest DP spec to support
UHBR13.5 link rate. Current max link rate logic checks against the
cable ID DPCD even for passive cables.

[How]
Ignore UHBR13.5 cable ID DPCD cap in get_max_link_rate logic.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 1ff9876e3ca3..41bdadc585b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2124,7 +2124,8 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 		if (cable_max_link_rate < max_link_cap.link_rate)
 			max_link_cap.link_rate = cable_max_link_rate;
 
-		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY)
+		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY &&
+				link->dpcd_caps.cable_id.bits.CABLE_TYPE >= 2)
 			is_uhbr13_5_supported = false;
 	}
 
-- 
2.34.1

