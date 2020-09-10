Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E820C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484C921D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1YmOYYwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484C921D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2CC6E951;
	Thu, 10 Sep 2020 13:48:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7B86E951
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGd9BLMWfPno4i99syEF8Zp31z/nCwxmzHxFTWKMCIVyVHysEBYI1DdgQbNDE/AT5T0ihx2qPIHoA4ADtdu+uoHMA7u/auDGmuJZPGvRezOMe8n3bwCYl030XMgbi9jtyxDjEKhji188+xXyp729i6tsmeXVcS/geYeIGQFUUBXM3OXXqk5c0pqyJOblAlURnyAUXuhI1afP6XnW+45UgIHgW03QTKn6f2vS8WPMP3qgmHxbLcoTwhHeDcD9yZ9G+SI3YtjCLrvnzdF69wcVGOEdLQUvzJw73HsIxYv6V9vDQjjxExp5+wRq8+8e04mWGviB+Dr0NscDXUYJBC4mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc3o4VKLEVc+GAEen4M9nD+0RUKSPvF4tfk5FWSn3XE=;
 b=W6JoJtfLDkRx4wrzFPfwIyVIXmCU0BQ1vZQiIh5/B2z8SEK+uz6hAE26i6cVTrQ2+2/9qNg8+oDIE0Z2CjheVXCVsGiPNv56LzJQHQrEUM99F2aqSJKxXZPLrwvYOQhSNzPjY7Gn7af95+Jg1n+DP+6fzp+Xqk6JxEbP+Y5H+LuVgFoUvUv0dvu+IAvvUErERLOB/FDcoWd+SzZvxObxdPKUZnf6ExdzVhWKL34BRUd8mZHVVFgGcYWo9+1O1kktBeqa5aX7P0SoA+lAVcwN5L3u9yAkNFJEmUHhjp/0QPeB0KuM6YB+ifp9Z33SbGXAy2sbFBPCpvWQi4W+pURYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc3o4VKLEVc+GAEen4M9nD+0RUKSPvF4tfk5FWSn3XE=;
 b=1YmOYYwSNzWu+EJJ0a+GVyTDi35dqLbXPZNLxDitkZlH2BRcsgv5ZFNt82qCzJBidIj6EfCaDEWEPwp4LT2p6yRpeIRg0PMvtbWWlvAdEdTo/ZyoHgRB466pz5o9Y7DNZco6NeJndSf+L5U47Tvx8UbOdm9VVasJPumsd67FWzw=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:01 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::d3) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:02 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:01 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/42] drm/amd/display: Return the number of bytes parsed than
 allocated
Date: Thu, 10 Sep 2020 09:47:14 -0400
Message-ID: <20200910134723.27410-34-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288d12ae-9b95-4a3c-e55c-08d8559022f4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2401:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24014C1ACD6CD1D007B1B5418B270@BL0PR12MB2401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRQ6LLz+LBllBSCHq955S/Y8jNC2zUfx0RvTYB7BtFAS+cFVCjMHH8kOMmrde07JoUVwk5NODYkA281b2cp/hTIJSQ9OKGD6sNyQq3LqLTH0U6Z5PZymWHUY+kyDo70MQRaSyCKM4MKCmoaQnwiOLs1jmOsLn+5JdCVdcw2nC7CXe8ZwTO/5N27Cq9MKjJyBCD5oCuPlF+VPBiVmHmSoV+PlZffrXs0Wk1wNPVWg8iUsIWukb2mV/2uwLKNY1rH3QnKtbm4uwpkZkMFEMZ7BD0mtFkT9e7I/DN98T6YrQ9vgk7aeY/eSIFaajYEtk4QJkZAXuEoOGpwM8pD+10byUo6gYj74d1+XK6DLN3WrVEQDpVVNil0rhi3sMRpstsxs4m9fb7BvEaXHgDMrLy/doQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966005)(2616005)(5660300002)(316002)(8676002)(44832011)(2906002)(26005)(478600001)(186003)(336012)(8936002)(54906003)(426003)(356005)(81166007)(86362001)(4326008)(36756003)(6916009)(1076003)(82740400003)(47076004)(7696005)(70586007)(70206006)(83380400001)(82310400003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:02.2611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d12ae-9b95-4a3c-e55c-08d8559022f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2401
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why & how]
Previously we were returning the number of bytes allocated
for a write buffer from debugfs and when manually used it wouldn't
rise any errors, but it wouldn't match the size of the parameters
passed from userspace.

In successful case return the size passed by usermode otherwise
the error code is returned. That simplifies the parser helper
and removes a potential error of returning mismatched input size.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7c7f937166dc..240a4fc403df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -264,7 +264,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -423,7 +423,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -575,7 +575,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -1090,7 +1090,7 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 						(long *)param, buf,
 						max_param_num,
 						&param_nums))
@@ -1269,7 +1269,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1423,7 +1423,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1572,7 +1572,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1714,7 +1714,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf, size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
