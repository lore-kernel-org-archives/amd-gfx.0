Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82595C2D0CA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE2E246AA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eDzNVa4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE2E246AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6F26EAF6;
	Fri, 13 Dec 2019 16:11:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969D16EAF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 16:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOl/Ndte9PZV8u1fS16w2O1nG/gdVb6mOmS33SCu1em9xUWZcJcNnq5eed6A1cqGIdxguUxG1YrRHSLuPJem1HnnNx+sgTQ0NOsOHi+EMjjgztSdgEfwKkZQ3GCe0H/m/xDsIGzht8W3jGCRCVDNKyrv9jH04Mbe56q1q16rXyo7nofP5Jtwa0ngLx4vOWLw46fbUqrmPjXcK2ZQpUj1JvVSMHgmAHa234H8E/YWcyCfATj7NIbJGpcRlP+cewFhkhT2SA3/vA3zExXE9FzsKBoeIhFAoMQQ8N67W1XUl4bUOo3fRlEHH/A1ogUJnlrLkrFrMrDBcWrLe4HsMOAMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/18NmepNzr8p0fgyZ5jb4Bc1ropNQyropxR26n5fMxs=;
 b=RD4hS34Y1RM6ltneFUN7zBnv2BbJwYSa4B/ikNcpravi0PuK+RnA/pYu6LPU/m/jufeiLFjg9EzdAWws95lZpGekazMaS5jMYALJC4Z1UURV+2/FG2ochC9HujP2C4ubPhYYeGyLT1G6aOlF4dZlC/CxdaP27msKmwxramM7hmjNFtKwpbDhqFbIjcOiKC/oDd8xwx4LIWpg1njavFoPG6c9/hLoR1fc2zQfCtsHonBmqZsCAL+3BGdFHQ8Vmoikmd8uHaomZFDIpcOlGBPuW3sSGObnGtC2a484fWTB7qMFX052qZCXDd8RjZ4jSafU8sJLtg7/dVupwrNIfyZhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/18NmepNzr8p0fgyZ5jb4Bc1ropNQyropxR26n5fMxs=;
 b=eDzNVa4HXLwO+T64bFMq1rS6Jy/BAkiTUgt/iM3vNOUeIY/1n1r7g5DjwEWDfxAIBViC04NIQFb3+Faab7Wsvzww3+mO2Qv2rvMWOa8Og8A7K4BuU7hKyR3e8olSqxXOOnzA8OTuNOPACbz4DuxiBX6lAGEJe5Ca2h1nwKbBSNI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4155.namprd12.prod.outlook.com (10.141.8.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 16:11:37 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 16:11:37 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, hersenxs.wu@amd.com,
 Alexander.Deucher@amd.com, Kevin1.Wang@amd.com, Evan.Quan@amd.com,
 Tianci.Yin@amd.com
Subject: [PATCH v3] drm/amd/powerplay: Copy watermark to SMU
Date: Fri, 13 Dec 2019 11:11:24 -0500
Message-Id: <20191213161124.24622-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a4e8a60-3e3e-4282-b4db-08d77fe7214a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:|DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB415523FC82A3F327057104DB9E540@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(2906002)(44832011)(52116002)(86362001)(316002)(4326008)(8936002)(81156014)(81166006)(8676002)(6666004)(2616005)(36756003)(6512007)(66476007)(5660300002)(66556008)(1076003)(66946007)(6486002)(6506007)(478600001)(186003)(26005)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooL1/i8xbE4gAD+BmWoktRiGZJ2rsn/jnFtQ0TelHoNWmeXANxhgjVY7/+xm5RTRaOvnh8ZOyb5xmRa3DzfkOoy7/lZL03glyLtcyH+9c8lkH89Vx19S+W6RFF6DG22pevGlbUiQ9yMl8LjVz4XH/3JVKr3r5mFzXTHFjQt1M5dc0V/2l66KtBfAg1+VNYk9WFwqOopxPdQO/QGCdi1Q4GE6AJuPWvE7PDLvzaqbpeTtGAispvA2FR66uJZUoEU5bYpFG/6NBgmnNGitQTmRuweENMHbP6hooX8irv82NLEuKoYzGYP8NRXltYvBNL2oBOLlnytSpIxZB6fVaMI26joUHE0LbQgcnnV56xd8VvrpvDdRgF89u8uZoau17/epzMLZMdONMT3E3sQvuTCrfAH5HaDApSzPrRb4JRLtRKmZdGlkX0HI2UI9xFhsRKuK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4e8a60-3e3e-4282-b4db-08d77fe7214a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:11:37.1260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVpIbT7IvxEpjxyKXmsmvgoBNZuSBuanAguKPHJPifEMCksVX7bi/SgFaTVaSVC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Zhan Liu <zhan.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Watermark value was expected to copy to SMU
within navi10_display_config_changed(). But
navi10_display_config_changed() is never called.
As a result, the watermark value is never
copied to SMU.

[How]
At end of navi10_set_watermarks_table,
copy watermark to SMU.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 15403b7979d6..f4cdd78492fa 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1472,6 +1472,17 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	/* Pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		int ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

Fix a typo here.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
