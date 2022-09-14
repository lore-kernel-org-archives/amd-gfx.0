Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49165ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B4E10E7EE;
	Wed, 14 Sep 2022 03:31:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3E310E7F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkNnHHq5jCTeIjbowwFfnwZuqHv9jnHu8opedMrpFGJhCojB4rD3uoB1Ne4B6Xa+Ffq85jO6UbxU7FL3J03Tjb12FmHW3wxGTncYw5xmlCqP/JlLa3qvZuPYq9+0TOLlMau8RETrxHNp4bDsqKBTlqluyvd8hSz6sFwAb/oq0VP10T5EWWpsyfPYRFTIwTqL4bVMNVTloP75zHfzWLkMCSZat/Z/KmibmsbaVdb0Ymq0LgNlLx7JOxymHAB1IpBKYLv95CZEC7TmfikR53sdrZNYllv+8pSJTs6kLPCs6n1d1Zw8AzuK7+wTHyhS1N/+uAyD9yaWoqTa43M8B+xRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=f8D1upSKp7WagIVdOoaX579Y14NXfuKnL2rqbWjBb7tfjIRJLMtODp7d+YEcqnb0/oLTy17SDPgM6NM6vKizEln4k1CyypXpQy+LYKxU/62Uy/yfCUJ/cj9V5SQywcBhJmMurKqvrR/8WoZxGlx+jTprMflIuPSDIYN4npZOqDm4aCIMJy7/QNKRzc/FDgP7HvxL62Va4xCU923UVWbr5ob1Asm7R2Au55lCglUYaeb723oj15VUBdyy5+OdpkpKqfJJSyDyhquuIztdQ0xrw8wFHNYFVjpmQpSMYIuvanTuY56NynvUIrUwGezxVKqs47/+X7wLxE7PMj80Du943A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=5N2aW0MWk0oXQZjCyO9EEpWdj+VnkRu6cYJ6JBMrHMwT6dJ6hbLxZJyBvMEBgGnYYtI4MfSLVLG70s+9c+SGlivZoN6YR5p2FrbLkTKdt6SAKpph8t1+PGkJodamdflOsb9Vu9Wn1VF4XTjfSyHXF0fZ2biDIVtZCRffF1lmxv4=
Received: from BN8PR16CA0034.namprd16.prod.outlook.com (2603:10b6:408:4c::47)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:31:06 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::bb) by BN8PR16CA0034.outlook.office365.com
 (2603:10b6:408:4c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:31:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:31:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:30:47 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:30:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/47] drm/amd/display: [FW Promotion] Release 0.0.134.0
Date: Wed, 14 Sep 2022 11:24:11 +0800
Message-ID: <20220914032441.1075031-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b536624-2b69-4ecf-4de1-08da96018e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hC/s9yNbHf5MLXnyNBnedm3IPihD9+nhfAubBXfWRWLwfaJN44uH232H5mmZp/7VDI7w/omxP8SWw3+63Buy+t0GotguEqZ9zb9iZ6aI/oENd6oiSFy+/gEszOyrHCJ8b/hHxCjVtYU43wxNAc8Vxzw/a+tjv3umjiL+PiXEJqUlV6J2FERrc9hf6cRV3uopMb+uFI1+MauHDyR96S5QM056YxPJjnR3cFNYcZDHDLGFsdW1r7Yl9XcSYO2QilZpjFvnSlZZLsjDJJREMEsIx6WPkZQD1UN/eWmbTTIJ2WzZs42dFqmt2Mz/daS7yk2JrxnMddpp/wceGaaAfHij5bXx53pOedcl4DjmGWpdHd38uyyqurL2i7WWGJPapnxC8CgkyGgt5gpV58fkvTU6fBCITLaFQ8N8R+kWNEyIujBLoYF6Ts8Fyz20YpkyRwcA/+AAN5H7Q6w7aUGjdQs5vT0RrhHpmeUyb4qTivmf3SVOP+algXepgOkJvCScLJxmjH/WLP4s6vQPCXT0JPLJmOb4VsNy76d2noS+nyFS2858FVRxgGG8s0PLLvYDJbIsO9/X3K/HFQ/zRtbdpjutBPALpC/C9uvpYF3pCpn1E+onEeTKov5zakPBYiS07C8nSNuv2YsTFdpPFf8woO0W3e3td9G5znPohYVGsrCH+LsEIb9zb4s9BTqz+HIddrgiWwSXHnS+HWgrYU8WJBqZ6WAj5w0njG8C+AEpYOMUVAyB+vvzL0v4papLC8S8Y5ogw4BmceqyyC+kyak0FmIB0qjXg2wHSLsb1N7PF/aCZo6+84lvPp49W+k7Z+ZKHUj5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(86362001)(4326008)(7696005)(478600001)(2616005)(8676002)(4744005)(426003)(26005)(47076005)(40460700003)(5660300002)(316002)(2906002)(41300700001)(6666004)(70586007)(36860700001)(83380400001)(81166007)(82740400003)(36756003)(54906003)(40480700001)(6916009)(82310400005)(336012)(1076003)(8936002)(70206006)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:31:05.2744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b536624-2b69-4ecf-4de1-08da96018e54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Handle pipe split case for SubVP:
  Pass in pipe split index for main and phantom pipes

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7cddbc431b57..6b9a529e9f12 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -998,7 +998,8 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint8_t scale_factor_numerator;
 			uint8_t scale_factor_denominator;
 			uint8_t is_drr;
-			uint8_t pad[2];
+			uint8_t main_split_pipe_index;
+			uint8_t phantom_split_pipe_index;
 		} subvp_data;
 
 		struct {
-- 
2.37.3

