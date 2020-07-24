Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E32C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC05206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LT4syWph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC05206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B31F6EA09;
	Fri, 24 Jul 2020 21:07:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2DE46EA09
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID7acs0tb65pR2yBsqhnmQiMfLDVV5sCJpJk8fCwHoNhMA+YOuUhcNyohMX86Xc4J1M+TkZFcclJDujfAYuL+M74qgX/7gqhd/b0FKiASQ3xjkJnlmYe6PYCQlJiA5fFnK0LxTHyTN/eDlwo0rmJwkwWLSn4PGdixvJY4l+ADxZiFbHPpIrIdJu+gZLYCFpiqtWVbIC+MaDCGdk0dXnawDTkX1U7MVHs5aMrtQLoH/yaklqCPXeLChLs6ESv3aa0xTubJJs7sOPq1y3K4KBVsuZPOatxVZVNI+whFV8d8ATtyTJ3UpCpgNMBygfYOJ/Xa544uYTWAitg+4EftQQWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxguRn6SiHM6+nqAlNfk102O5oLUgb7QwfZlS28cNkk=;
 b=BgGspYa4jSksFwkaevHldVHsVGCal5zAs6yye2eGDuCPDzGlO4kCwJFKF9PqpkQpaF2WWHsHt8p3w3Nji0/MSH4BKCVaAqs7X3RpeQaH+oC12Si2bDGbIBI6j1L+Vfkmh8Ac8c78ZUrtIJRFPi9BtI+qLsaVq6NOC1OCbsJw12xNV8/gb3r9j5SFQE+YjwfdEGQVh9miiXeOxXJgIJR7JmGNsFgZJ9Ih9B6bjdHmC4DBvNq4OVfq5yaaFKUQxR1U1wbK0wvBScfAksQqEdG9G4E6SbWvxIG06f06HhqAhwWMU/GU1cJmMP+kOoiCY6t1a7VHg1Zx1mhTUvEuVuu6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxguRn6SiHM6+nqAlNfk102O5oLUgb7QwfZlS28cNkk=;
 b=LT4syWphR84aRQgXG4UypRLtQlR//ghQh6AlWc7tngFqd72cGRQAKli7yBjWEtoQFiLYQ7qiH80XQX49E3+NJd5l5qjhPOZnvH/bAcj3XcFG41stmyBHbIE31uRhyRX9g082+k1otBpxkLtWHqcJZ3sHmP3SUAj2DFTBSIWun4w=
Received: from MWHPR19CA0058.namprd19.prod.outlook.com (2603:10b6:300:94::20)
 by MWHPR12MB1647.namprd12.prod.outlook.com (2603:10b6:301:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Fri, 24 Jul
 2020 21:07:05 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::ab) by MWHPR19CA0058.outlook.office365.com
 (2603:10b6:300:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:04 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:03 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:06:53 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: Fix naming of DSC Debugfs entry
Date: Fri, 24 Jul 2020 17:06:06 -0400
Message-ID: <20200724210618.2709738-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f8b882-6efa-4dd1-c43d-08d83015847a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1647:
X-Microsoft-Antispam-PRVS: <MWHPR12MB164757B2F06CD197B38E7029E5770@MWHPR12MB1647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrxYZ3liicUcHGWadGbs7JrmAhf1gcEkg+hrK/KRa8uKo9Qf9DW2vAvIK+DbBHdYfvQLTQNOTbA5l1Sc3jn4oTsXPxDFwAxh1WAipI9oxmyTHClmLPdM+MuDYrpthsxqjIZIaNX0HHyPJJM9ygS1fx1unczuej2vTzv9iHvxhMZQpXgF9cTAnTHONYdBpWDpBi7sXsSmNcW2HL4WfJImX0BM/474G07lP1vYMtPPOVD2FlOHbcpDxQhyX1jeL0odt1pTj85D24i4RalSg5V4goqcKA3g12Xi4rZiPnoBV37k55vMPt4PXmpgYpHMZQd56MTr3HjlAytpO9GbP8xKq1WcTBzwSSnITp3X2z8cJlcMmY4/AShu346BmBCCsgsrz/+0FUkaLJQC5abSRhjtlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(70206006)(5660300002)(47076004)(2906002)(36756003)(4326008)(8676002)(356005)(6666004)(70586007)(6916009)(2616005)(44832011)(54906003)(186003)(86362001)(316002)(426003)(82740400003)(26005)(83380400001)(8936002)(1076003)(336012)(81166007)(82310400002)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:04.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f8b882-6efa-4dd1-c43d-08d83015847a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1647
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Fix naming and return bits rather than bytes per pixel for
naming consistency. Because registers return Bytes per pixel,
but DSC Config structure is expecting bits per pixel as input.
So when returning the value convert from bytes into bits.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 3dd7da16cc18..65e9ee64c70c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -35,6 +35,7 @@
 #include "dmub/dmub_srv.h"
 #include "resource.h"
 #include "dsc.h"
+#include "dc_link_dp.h"
 
 struct dmub_debugfs_trace_header {
 	uint32_t entry_count;
@@ -1168,7 +1169,7 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	return result;
 }
 
-static ssize_t dp_dsc_bytes_per_pixel_read(struct file *f, char __user *buf,
+static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
@@ -1479,9 +1480,9 @@ static const struct file_operations dp_dsc_slice_height_debugfs_fops = {
 	.llseek = default_llseek
 };
 
-static const struct file_operations dp_dsc_bytes_per_pixel_debugfs_fops = {
+static const struct file_operations dp_dsc_bits_per_pixel_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_bytes_per_pixel_read,
+	.read = dp_dsc_bits_per_pixel_read,
 	.llseek = default_llseek
 };
 
@@ -1572,7 +1573,7 @@ static const struct {
 		{"dsc_clock_en", &dp_dsc_clock_en_debugfs_fops},
 		{"dsc_slice_width", &dp_dsc_slice_width_debugfs_fops},
 		{"dsc_slice_height", &dp_dsc_slice_height_debugfs_fops},
-		{"dsc_bytes_per_pixel", &dp_dsc_bytes_per_pixel_debugfs_fops},
+		{"dsc_bits_per_pixel", &dp_dsc_bits_per_pixel_debugfs_fops},
 		{"dsc_pic_width", &dp_dsc_pic_width_debugfs_fops},
 		{"dsc_pic_height", &dp_dsc_pic_height_debugfs_fops},
 		{"dsc_chunk_size", &dp_dsc_chunk_size_debugfs_fops},
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
