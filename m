Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0009C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BF51123DC;
	Fri,  3 Jun 2022 20:12:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBC21123D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDMFX44TqKKxFqEFd2PNEnlAWDu7oZeLbhb2t/2wo7Ogt0m8A3PwaX0sitpHtzQB89mROBpdoghmSAkIU9EIVeE0iz2PkAUdiBLIQ8AA3bE0i0Bk7A56RlafYNumFt06iu1KNQFgQLbuEGAgAULecTUKALPpHyFTwcqK1WGoJxk+40GOQQS4i1w8Y3dcTOW6hp2tuXyRxTMAIA+zLaI8kQdnqqqf5kMHuBefWKbIyZCVJKb5//O3UHSWq2eHxCsI6ggSXt7QXYFTYswvzWh0D+HrrugOj7+KXyg+jVItHiAe4nEGdUEZthhH/e8hKuA/hSPrhC8ouwkNm4KhwlhY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bTDMjlVzdLdlUYIsKJzBl+HlI3UQngLJrd3ecevxnY=;
 b=CN80/XHxfK1p21QnW13q/dbT1CsThjGwsi4CxjH7pTjC5jXwkpt++vkxMlpb6p9CpkRexiN8EPh13SzsZJ76r9CBYVNE1iMImfst5YvtTRaVn8FrC6NR8Pchw+w8gR4A30zzcU3xEHpW8qHRyK3S4CQzNtqSqzpZa1Y9pgb8uaXelC0QjkzOP1ci2+1VIBMPqc2jCIiIoHH0lTePQVXDj04ukYtwnoegi0ZgQ+8IkeXh6FhdZAIpCB2RO7c1/7h42puWtSVSt90UBlAG3irpjENPfYXMIM9gGoJH2lPGQYy4A9vuwyKsuXGwcCM48Zt2wsKm7fFuAdk5sH7dWePBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bTDMjlVzdLdlUYIsKJzBl+HlI3UQngLJrd3ecevxnY=;
 b=Q5LlK3OHPD3IStJrMkWUTYW4JBiLkWQRyd624YnrGCW1O+4Sri+BXy/bwtifyeyfbmRafK7PUO4Y/AEZQb4/npnFsJTGT8stGLN3dk7j6RXqvSTwiWQ6IrfYUQKiCf9WyUFF6fx/kIh7DW6eSGWQ4fZVpbqdzPbmFZd974NZya0=
Received: from DM5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:3:c0::12) by
 CH2PR12MB4823.namprd12.prod.outlook.com (2603:10b6:610:11::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:34 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::db) by DM5PR16CA0002.outlook.office365.com
 (2603:10b6:3:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:34 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:32 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Correct min comp buffer size
Date: Fri, 3 Jun 2022 16:11:36 -0400
Message-ID: <20220603201147.121817-6-hamza.mahfooz@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75f3d646-4df6-43fd-da98-08da459d6592
X-MS-TrafficTypeDiagnostic: CH2PR12MB4823:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48233E555E834739E881D904F4A19@CH2PR12MB4823.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tjux2ISnAN2s2QzT2R1cTpuVigRYa215IQYS5usnan9h3ajoA08LISZuZRxmeDYwCtgPLMSTuUsP0jKuyaFZaDj42OAUZbUFTzsgRmX2qwpgqCqfUbX8aYgBXzuWf+rdLAMsT7ngbLt88VfpXcfPJbAfZfK8ouhxYflNsuq6aDzcqWmZvYReurKznnuYpdWTC4szARjl08SXkjNhZ3vhkRdIG833IT9mjEWgZaNRQ6FTkf4V4N7s0andLtnVf0rH/zZsT9SXXIRMlk/3KNKbVCbt53eb/IeWeghezUv9ld4AUAkQNd/UbLI1i9bh4pzjonDQ2dcgsGNdCZetDISUt45CufS10dS+q080qN3mqDlrF4VfP5TKSYH93r5Ja6LvlpnD+uChz4eU213eVwH2f0xh8dwMShTzupaB8ZI+a8rBc2GZIZuM6q3tFsEbdSFYPp/yYPvnlURlwyHvrNQv6b3IL9fSF0RGpG+potsT3pV1JG4wJkmxaVu1HG1q5QZo7rZ7imguIr7+eHH7WtX4nhE3DCVq6XPsyxAY2JDVmefWa95NdKb79fucUoR/ZAwRRbwkFP5Z3Y+exoRYkXGoQBZ5Ogi0GvUVxLxUVWjfIGJtIUu9eK9sYi9Cndttod+xoxgPuxGGmHqdwozOxEHWMYH1ROE94HMlPVAYjjGQdeyqQIW0DW7gRj3lXLeV3qdJDl8VKunkTBjmSVyKx8brQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(86362001)(5660300002)(6916009)(8936002)(8676002)(4326008)(82310400005)(54906003)(70586007)(81166007)(356005)(40460700003)(70206006)(36860700001)(2906002)(44832011)(16526019)(36756003)(47076005)(83380400001)(426003)(336012)(508600001)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:34.1245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f3d646-4df6-43fd-da98-08da459d6592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4823
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
In 3-way mpo pipes, there is a case that we
overbook the CRB buffer size. At rare instances,
overbooking the crb will cause underflow. This only
happens when det_size changes dynamically
based on pipe_cnt.

[How]
Set min compbuff size to 1 segment when preparing BW.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 54db2eca9e6b..1b02f0ebe957 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -201,7 +201,7 @@ struct _vcs_dpi_ip_params_st dcn3_15_ip = {
 	.hostvm_max_page_table_levels = 2,
 	.rob_buffer_size_kbytes = 64,
 	.det_buffer_size_kbytes = DCN3_15_DEFAULT_DET_SIZE,
-	.min_comp_buffer_size_kbytes = DCN3_15_MIN_COMPBUF_SIZE_KB,
+	.min_comp_buffer_size_kbytes = 64,
 	.config_return_buffer_size_in_kbytes = 1024,
 	.compressed_buffer_segment_size_in_kbytes = 64,
 	.meta_fifo_size_in_kentries = 32,
@@ -297,6 +297,7 @@ struct _vcs_dpi_ip_params_st dcn3_16_ip = {
 	.hostvm_max_page_table_levels = 2,
 	.rob_buffer_size_kbytes = 64,
 	.det_buffer_size_kbytes = DCN3_16_DEFAULT_DET_SIZE,
+	.min_comp_buffer_size_kbytes = 64,
 	.config_return_buffer_size_in_kbytes = 1024,
 	.compressed_buffer_segment_size_in_kbytes = 64,
 	.meta_fifo_size_in_kentries = 32,
-- 
2.36.1

