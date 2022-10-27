Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C44ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE4F10E6D4;
	Thu, 27 Oct 2022 18:41:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320B710E6D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij4SM7NuDp20vr0BfxuNFNRCbM6gd+zSMx3vyM8PMbl7sNxyf4NrD7pmpBzW6wVhP6wchfFwGxZHLOf2J5lQQ7mIuDNS0GypcauliKACzpHjExyqyjVnSqqBs/gY9QThwkzzii/0vq5kUarm2NFjFhJhj54/D9OnlKKXC623DLjr80UwH5qzLg9IBjFTIw8KFPYxColV5zU75NGWbLi0BdgPq5G8ONhRqtVtBFbydDkVi2Uu/kdRELhKHZsBtQkYRIqmtMYADOmktz+o9dU+FRENWyqmMYwru7kIrqMXDXjZ0GUC2C2g2lL0QGivfGXO5lwsnTezr4NbvN/fADUbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTa463r/5zT5y7R+2lIjNAV4GMQocBKcdgNC7OzJee4=;
 b=VNhrxubh20JdH/QQMc3GI9B8YJnWGf8f6MsZ5Uh2UkxoKS+1D/QXamAJ0P62tmhdVmSFo3KbtA+Ha2oBBBufYgtqqstQOGy06ytUO3wMd7oJ6xmYMzbrBU8m8AD3685+MBlLpvKTKiqJbuCvSXYX+atkQpLGwsjs0WUogeKRV+eCQJe8lrGQqq3EEEBXGiJ3uLXcj+TNUSbqEV0i1A93BDrqBlidD18uV/bydpFxJspJVuhZ3HTfrsy8AfiFHYqf5FX005U5CSdchDUudQfWpxBxau7Pfz/6dzdoZEEV0dCk+9hCnhHRXs7IW+ETZQlgL+a+6BBkBIfa/6/FBKj5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTa463r/5zT5y7R+2lIjNAV4GMQocBKcdgNC7OzJee4=;
 b=Ba342iMhQuPi8KgAFtriSOQq/O9e5HWIugjpxbdDyk9yit8jL4/k7pcf16Psb9OiRNqC13/uqpoQjvRjF1b8IltbTNiDVHWCIzbMX74h6UuDoZyBN6Ll0+XJkpnBmonyLHH759KVVXYJmgsvbs8hNUWACwy2QWBHMTuvIaGtnB0=
Received: from BN9PR03CA0174.namprd03.prod.outlook.com (2603:10b6:408:f4::29)
 by MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:41:27 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::40) by BN9PR03CA0174.outlook.office365.com
 (2603:10b6:408:f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 18:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:41:26 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:41:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/18] drm/amd/display: Fix DCN32 DSC delay calculation
Date: Thu, 27 Oct 2022 12:35:37 -0600
Message-ID: <20221027183543.1117976-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MW3PR12MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e4d433-5af4-4ac6-b10a-08dab84adaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wtLI68duJOFV99xjIfy6BMJesN6AJ8IvcGVgdAfLSZ4WHhc15s7wIJDn1ZIrTBP41BSdzKbJGjeIHA3pB9IciA06du2n14YGuftNum7wEy0BRaMMZmjvoKLhhLYAl4M+o9n+tmLqB3w1hIHWxctsgGr+eISSJeXnE/b45ykiD/5KAwuMnDV6YHSji2HSgpPpYkaC+F/Vg0gR8e8LcYQtx1c172ur7JdkLVRsKvS6i4e2rTUXuNfYRnElfSuIlCejhgXyTZp0UL9iVrgFtVftZ13SMnIkpF/JhMsdsGgLKynV8i9AzcKYhnfBJjp8RmbsPzVvGHTOlHziCkZInuhM/ywgRP9dy6lcDy2pkUybcJDEX66FsmEXQDFqvnusZMzt5MfBLfxYzFC8seMG4+SOiMqVWyIgVKl7Vm8qKKCKGE9OC/lK385/FgoGK/K5NNvJj/xzI5QjIs7U7H5V6RZJRj0cv4cL2rsJL6pTRUYKH5X2wETjttAEflcZe9y1K8C+sdSZCsR280+SEZQDZ8PN+ByyMgvjQqxJ12pQkZebWpSr1h09Uv7gX58qCtEzkLjbEWI1KbOfRPjf0YcZSpO7KZZ9I9zP4pgs4T5z30JnzL1CQW8kswVghhhEZyqdPaKHHSuOL00AwZ+yORyvzW3P8oH9AMhksPtTkHSyH+A6xxrA1pzJxzxehOHZRKV5iIxYbcFuopSII8IuqQGS6KMGVqv0R7/1V7Dts1EBRhL6kNgil3CLXnJdJAsndtxxJHANyZEBEYtENV/A3Woqxjsoe4r4D0TwrHpD/dzP0gxg67xsJNeOMEbZ38QtDcT6g4r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82740400003)(81166007)(356005)(47076005)(186003)(44832011)(83380400001)(40460700003)(40480700001)(2906002)(16526019)(426003)(1076003)(6666004)(7696005)(2616005)(478600001)(336012)(36860700001)(26005)(82310400005)(4326008)(316002)(6916009)(54906003)(70586007)(70206006)(8676002)(41300700001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:41:26.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e4d433-5af4-4ac6-b10a-08dab84adaae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
DCN32 DSC delay calculation had an unintentional integer division,
resulting in a mismatch against the DML spreadsheet.

[How]
Cast numerator to double before performing the division.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ad66e241f9ae..4a3e7a5d2758 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1746,7 +1746,7 @@ unsigned int dml32_DSCDelayRequirement(bool DSCEnabled,
 		}
 
 		DSCDelayRequirement_val = DSCDelayRequirement_val + (HTotal - HActive) *
-				dml_ceil(DSCDelayRequirement_val / HActive, 1);
+				dml_ceil((double)DSCDelayRequirement_val / HActive, 1);
 
 		DSCDelayRequirement_val = DSCDelayRequirement_val * PixelClock / PixelClockBackEnd;
 
-- 
2.38.1

