Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20633C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 23:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE28610A2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 23:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE28610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B04A6EAD8;
	Thu, 22 Apr 2021 23:20:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790546EADC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 23:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNaDYQtBzr3viwnPeV2XIZpfgAnG/9OGZiQ4mUd06Ip+NxQCjHrikIripTDOA4DDY6Q51LztTUI8XMVJpEOt3niIa9ceaJ4GhTbiSYOLpBzYiMxmMupsg2f3vKjZ2EEZvbfhoNW8PH7cKcvNdLd3Hj80EEJ7Owkoi1fP77AxWkGZRWk7h7MW3gJgIUMkiiOanUjcw+zcGh+2ltJDt/3Fb1i69Y4JJmtF8RBO3Q9/p19V5JzCbN86W00kaKdzx2qZDtvvzwiXc2QEUKVVidcaBvmgcl1ARL9VNX6JT+Zctgcbxs+Dzxqf8QGSYXXN9sr7NjBXYR4uEYJC54J9Ol+NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpLSDaGcTwsdO1EpMUKCoVAJNlu6lhf9dqIsM6zbmus=;
 b=Vtbkc+tPSl0O5nRYoBCju9JcAoOQOhM/MOi/AoZNaf9gowDM61Nk+7QYaRcFihHpuZZiCv1gre/gUg9Ej2kZ294yse5+152WM8Tes5G9hmg8iK5zfGpDd4wxdpXhG9bmIfQSVAG3YO1DOk3AsAtT5/wqei2eXvI2CqsBl10XdivAc+6wESrPH2QutcNyRxNyAVNT+CvL7+4+V89wESexfy8qOrdU1saZ4/wszmq9fi0NzrpcdhddSz0VF6x+UOHz3T4CbxnFDHh954Zec3sv2/e+DpodzGBAO75fgAs7Ye1T+8DPE/BH+Mj9iu8Vt/U5xyk5F8iTSxd+H4/RqNGqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpLSDaGcTwsdO1EpMUKCoVAJNlu6lhf9dqIsM6zbmus=;
 b=eRP/Zhd2AbmeRUGCalZvkgvXKTmH4cpyuIVA+dt3R6EBK8Zc4mDJ2ICtl3ttL0zFetuVQEwXUBkNJUyrT56DL+S/BKB+uYJXOK3pAnMN0u+viglzZU7ivX05bmYhRi1UdOvgZCL36SfbUqveRacoyUBO1J8bh+7NQl3zdVwhDNk=
Received: from MWHPR1401CA0019.namprd14.prod.outlook.com
 (2603:10b6:301:4b::29) by BL0PR12MB4689.namprd12.prod.outlook.com
 (2603:10b6:208:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Thu, 22 Apr
 2021 23:20:46 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::76) by MWHPR1401CA0019.outlook.office365.com
 (2603:10b6:301:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 23:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 23:20:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 18:20:45 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Apr 2021 18:20:45 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Roman.Li@amd.com>, <hersenxs.wu@amd.com>, <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Reject non-zero src_y and src_x for video
 planes
Date: Thu, 22 Apr 2021 19:20:34 -0400
Message-ID: <20210422232034.1200474-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ed9dad-e7ba-4283-eea7-08d905e54242
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-Microsoft-Antispam-PRVS: <BL0PR12MB46891F06D34473C1A2D4C3B38C469@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCMKOH41U5z59T9uItyuWG+JaWn1rpUANjMjbVh+CecO95SYRdzs4TCkJXrMyizjdNFl6ZeZpnPcBHdgZjMxXTA5hzye2X3S4GULrVEDdYSJgRlVhIQj2YhHwmOJa3kkVLA4Mdr5TowDakQuN3JnbDscgyp0mAtxG3bLBmewEBVxkogqrc/HJwdlenLyJdJpeqJ06a4lOHp5OmjaoCXeCK27hjL43NyBZdsPTA/w7qQHhL9J5EqN/OucjSAH/UMX7vHnyC081+tAwFmo2/2dAX5PUUVanjmVIgUx7TfPxssvQWcA4wtkvw8PEwzjtrV22OeMM8R4UZfs7U5ol9ou7Rm8z5wAhzFqublaJKFemBVxa8Tkz7A/cfGpnCd3+LyIQjzHkabaW8eb3IiyySqe6YvfULhfAZ7H4TI4ouk/6uQtk4aPFa4lqQLStsC1WGbCFLVvjNRqrvyuLNMnMC6fr5PbuAY+LkhyBEZ2jYpJNwd7/I5fK850ke72kfeCWAdNQ25jJVhoBYCxCDXAUlWQcLoTARG0+RymR7Fjzik73w3LjKhQdRkZr1BKu4eFfaVZoylN/7+mLt6w2Elpj8Lu0S/+ZKUls/qGhkth+YusEgZXuH7S1kWSl3YviGG7zAznM6knq9JdmJYOXz1FKOinLl2o1pnXeJCUEm4mBn+lefJAFtYwurc5biEBnqZqDDIrv/wb2S1EQb4Forg/Gj/uqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(86362001)(47076005)(426003)(82740400003)(36860700001)(2906002)(6666004)(5660300002)(1076003)(81166007)(356005)(8936002)(44832011)(186003)(26005)(6636002)(82310400003)(70206006)(4326008)(316002)(2616005)(110136005)(7696005)(8676002)(36756003)(478600001)(336012)(70586007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 23:20:46.5419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ed9dad-e7ba-4283-eea7-08d905e54242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This hasn't been well tested and leads to complete system hangs on DCN1
based systems, possibly others.

The system hang can be reproduced by gesturing the video on the YouTube
Android app on ChromeOS into full screen.

[How]
Reject atomic commits with non-zero drm_plane_state.src_x or src_y values.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Change-Id: I5e951f95fc87c86517b9ea6e094d73603184f00b
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b3b9599aaf7..99fd555ebb91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2825,6 +2825,13 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	scaling_info->src_rect.x = state->src_x >> 16;
 	scaling_info->src_rect.y = state->src_y >> 16;
 
+
+	if (state->fb &&
+	    state->fb->format->format == DRM_FORMAT_NV12 &&
+	    (scaling_info->src_rect.x != 0 ||
+	     scaling_info->src_rect.y != 0))
+		return -EINVAL;
+
 	scaling_info->src_rect.width = state->src_w >> 16;
 	if (scaling_info->src_rect.width == 0)
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
