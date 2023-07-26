Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455AC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 14:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6D10E482;
	Wed, 26 Jul 2023 14:17:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC94310E480
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 14:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwqQk52na53MTlrGWZLv4nM8Tt0obja1RfCqq7Gx99QtV5VedaokeXaJibixvnTJhY/lgTPo+9EWwhmVJ21ulWDR9SjucJX6pXGmbrqTwJ99nvVwcg2R6rF/02dvdzgoRtEUFt0D86Cu5SaMXRnc5KZni4cce7OFtgZZxYfRPymRybmR2UifT6k+kxmoecUi/7pdduP8DFfs7mhHq73kDxdnYa0yq7E0VugJY+k8bBSjjgdrdAj6IsoVRT5snKAnZ1tbECbfD01Dm1ZudxaExkVsriHUozqS4Wx9Eds+DFAaeEyweq98hsxmpKSJMFd0s57djFPPqK5mF5q2Ww9xkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZgb6HgmDIUGZWUiPCyrYyMuK27qaEUmaC/7ghac1hk=;
 b=jrL8+JwB2nLab4hzeOR5ExEbcbWqkzLb5jMLR6Vaqq+BxVbdlL11m4zUYn9CLL45k13Zi7ZtjEMlmekH2cCSSVlfIe9649L2Pm4GdJZNN8Wp4CRVawYBcKnxMzX6ani6IJvUDj6GlOCMN8wt8GlurxTU5xTXBU4z2J1fLlmCBCmo8FQIMQMZwTNPukbdSmBXshogUR2ijZTjyMRzs3XWmiWr2ULDxvrNVS8GGOIAvg7Ty8z9rOQV3ATfR6nruJKGTgzHIIErbT5f/TEqPxRH293sM1to2Gep1YindTXtxNfVDpltsuUNtO+wPcaWFfQAaqZeFHAmHWS+GXpUCGf8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZgb6HgmDIUGZWUiPCyrYyMuK27qaEUmaC/7ghac1hk=;
 b=dQIurFM5CcBAuHP7aHtrfEnygP6PhTCuqpqMjtndx1qV3Lif5BhEYbgYsspAaMAPhBRuGvP/nY6LUOKxnALUZQMD4HD5fCKPb11/lmRjajfqLxvdy+ol01Ph4MdPQKilApVGJIii5FrxKbidoCKRDSUMA6CnfNktZknOTH91eJY=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 14:16:55 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:12b:cafe::46) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 14:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 14:16:54 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 09:16:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/radeon: Fix ENOSYS with better fitting error codes in
 radeon_gem.c
Date: Wed, 26 Jul 2023 19:46:36 +0530
Message-ID: <20230726141636.2474263-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: f11dd576-c1ec-4ec5-e53e-08db8de2f6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mdg0LoowCATH/1NG5xjABi8LU/2qbAOiWqZpyMF+vLv/0zdtMzBcn1KNAPoPlA8BP6mHnA5ZqGhDIhCl4RFwZZNKK1t8fllaFo0/3LurA7V2q+dNxixbmQYHmMhbsoqEhptkpyH/PQcERYaX2eGY3Gexv58sF53CzFb3wEc8v+ffiaUxODv7J6QJYA76knhy+jN30WRPK66pq/ECRjWqkOFRuXB4FprTK+fVs64SDPjP9/lbT24YHqx+jgk+2G20BTbnq8C7Er0DnwqTgV6R/3rgjI8hhRAi5zi3f/8R3Y15qps2Nm01mTWjCfVgC9hWqjH/g2o5ia7uTpcnITLEW4nfykkh9iopFsOh9A4jFVPLPuRrW9esBlZQTVAADIWcxNIgYBNKrorNyi55+6tAsgslP7mFiwy4pLT7zjhNhTCmyPbd266sdaIHZoGtNYAcLCtZdtZB2KgGzGj9YwxmyHQvyGgSRCpU5l1VJMj7miC7aRXxk4rQyhJ1GbYPl/8ydtw1ZIwli8HiY9zgGXsFHloBbpgJJ5QiOlrkqgGFK/tZDUQN/wNoJcEMKUnUMFXSFwSHGx9b6KtPM9A1jPW0rulr9LU8aHGt429NlOOJQK5Sxw04KfElL4NlQCFDD2WxzXud2r0gboanZyN7tvCvCigbY/noz/IKfm+ZKPMDoWc/WT/aHRnqaz+pEcSO+dIi3hAn2XN11JnJ4Hufue7bRhsxx9RUyUFR3EpsaxHvme/CIDWWNfaV274OLKzHh5HWGMjEriaMSL+JUQ/b+7wCOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(54906003)(7696005)(6666004)(110136005)(478600001)(47076005)(66574015)(2616005)(426003)(26005)(186003)(336012)(1076003)(16526019)(2906002)(6636002)(4326008)(316002)(70206006)(70586007)(8936002)(44832011)(5660300002)(8676002)(41300700001)(82740400003)(81166007)(36756003)(40460700003)(356005)(86362001)(83380400001)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:16:54.6088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11dd576-c1ec-4ec5-e53e-08db8de2f6e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the error code from 'ENOSYS' to 'EOPNOTSUPP' for unimplemented
radeon_gem_pread_ioctl & radeon_gem_pwrite_ioctl

Fixes the following:

WARNING: ENOSYS means 'invalid syscall nr' and nothing else.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index d0119c5f7eb3..358d19242f4b 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -316,7 +316,7 @@ int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
 {
 	/* TODO: implement */
 	DRM_ERROR("unimplemented %s\n", __func__);
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
@@ -324,7 +324,7 @@ int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 {
 	/* TODO: implement */
 	DRM_ERROR("unimplemented %s\n", __func__);
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
-- 
2.25.1

