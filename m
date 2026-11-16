Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB99606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OORu8wVU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2528B10EA5D;
	Mon, 16 Nov 2026 16:13:34 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCF110EA5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ndw+4BhPnQ9qpu7skdrXEpS3r+pEsy+1+IFDq2p3k0+a/7PHG9J5fxVToUdHBoCaZ2OptcMLzQPgQEJe6kTTz6SomNxQMMUkdF2phXwAKWcYguRqWhWGxltaQWf0CiPf4DxHfY3r5hjJX/I8QPso9ZKX85eVXOfe++2CYQNf+rT7zazEyRpDbooMh9T6Lh6+WM+3RpcXzyFzjmz49E20un0P7S6d9fQ6fPukXKS0DPhd7sBkCIoEcWPCtjPsR+2KHG9mGYVYjQHTzfT4pOfKBq8nMhslbT6FvtoWejtIxDMm+rjDAEyxJfH5aKJc+tjOpSeHvr1S2VhWF2L4X/Opmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7II7fXRgLxaRla0ZloUFpE9PGk37k5F2fusq/3g6srw=;
 b=CIlqinlAz6jo1d34VoQEumtybsWuomHj09QRa0OJu9FPDp/2pD3hDviDKIMQAtmsoKLA8UbYkLkirrFpR71Xh7FCj2WTr7nEoFKzjxBArlIeASwceqPZVsh73oVlH7pP6uWC5LbJyyfEg3MPv9SFmBxjpAA5mHezZLO9HGRU4FVbFxJ718bvxqcB762TQplTxj1CSkV8om0OZD/izgbZ78D9zZZSZNaoUJADtb3ROj0V8SEvPTJB9WiXgZ4sbKCukHstJ1gF40DTCNep8Hnl5y9ihQT5Qy+wPH6bcbkeYpokBGncvcbDCe3JZCR5AYLyxl/qeB+MD+yfPynU7Evr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7II7fXRgLxaRla0ZloUFpE9PGk37k5F2fusq/3g6srw=;
 b=OORu8wVUvo07yMazlJWNcU7k38Qqzt29m52aMPzyl32lwqwwlSYLwgV76CW1GmuCnNwQnMMwDsuN8yWFsEOKDcR3h2KH/etD15eWaVRx6BafSQ02TEWZ2oQFCEb0FfvdRPXqxKC9pwniGxNfAXmzZKWraDq/9m0gr4NI2rosJcY=
Received: from PH7P220CA0088.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::32)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:13:25 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::32) by PH7P220CA0088.outlook.office365.com
 (2603:10b6:510:32c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 16:13:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 16 Nov 2026 16:13:24 +0000
Received: from siweihe2-Desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:13:22 -0600
From: Siwei He <siwei.he@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <siwei.he@amd.com>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use logical XCC indices in
 AMDGPU_INFO_CU_BITMAP
Date: Mon, 16 Nov 2026 11:13:10 -0500
Message-ID: <20261116161310.3664509-2-siwei.he@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116161310.3664509-1-siwei.he@amd.com>
References: <20261116161310.3664509-1-siwei.he@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: b914562d-cbdd-47cc-2a3b-08df43fc8a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|56012099006|11063799006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1EmDlfTLgjP/3XuH7ADslT9SnXmpIYQHBWPKkxYyzfoqMrnz76et0oovH6Mi3Dv16+mlx7uYIYUIrp7rJSaKHQ5jQubaVvinT/WLbqp9DYOknTPqrdFG9oEJoBwrgCQ0we4YPtQnU49KfoJeFLuDNyalPgjVwvQ69N+j3dBxshYqEDX0Ja+5K5T16T9ViBFl5d8ht6GpSQICjt+6ct+zPFqa8Z93sfBau7JqcK5x+RsDC3JfHpWw2NRBvcGfD8EQkQGkiqikqC50XBKeTVohnjnlNiz8l8osNq/ssRZqyKz7IR3wSS+PjzjNdVgC2ATxwCDw+FXTP3BhPNeCfyExjct0siG9kflhJfg/4rhZaOnwmUTjnek7LzlFxg6lpOVMbDJV/KckJHBTlVSPsWosCflnf9qTk9b3FKfU1ssjob3nqkA1Z0JV88TInVmIZFanZj3Plyy8+/trP3z40StWFYhzGnC+FoJiWNR1jouo83P4AF5CDuqXeS0SBDoHwzHLz2Gwjsx1ah4mzvMCq89QPUfNr7JcALAGsaJc7ukl1xWyq0S2d2cOYVUSd4th3LNl8HhGfIW/FBQzYMvT6Vw3ikCNK1HP6v/xmB2o0yxrqUOh3E0TlPR9L9cQdixR6NhTpZtwQTWB0sxvL2dZGK97W8OoWDgHzuXTWxfy9UWzmWgnlzBRnHxqUvYmumeZgc6TJgbdnG3uF5ypoihy2XKh9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bou5WrqGDmbzlKiuiLFPKrQIlGihvq7iUzLZ0QqvP4EVaBByuJU5IUWyDL46Wlea2VCQlBnMiEOdbd+uC+gjLHJYcigYtwDV8Qd1Kl+iHGFetKvRZnD/7BXtDjIoThgJBlvW5rkUj62Lay9S00iDnDAnUN/WxStb51dIFX7O3alNAkS1mi56o/A/EntW/EA5+3RenUZ2+ArfdiT0N23g88x+H76Cs65rp687/zkoHqnChS3sLaWdmoYpWWDExd04s6VWehh1nv00WBB0ypG28Iah+f0yzo3WUqpROLQz8/TX0DCT4mB2hBXxWKjNKmb8Ko6fPDo2OCqnVylO1zXSuYMu9z8wBAf+Fgx6rHGH8tsmQbJV8AGXj/JGhHfxkcqw29E85Gtlwkx0CAySARhtkFJJ4WRNwoj+FJWmniW+m+Zjoguzk0ibtBgsYundyhOd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:13:24.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b914562d-cbdd-47cc-2a3b-08df43fc8a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use logical XCC indices in AMDGPU_INFO_CU_BITMAP in no-partition
fallback. Also, stop clamping inst_mask to AMDGPU_MAX_GC_INSTANCES.
Reject with -EOPNOTSUPP so the caller can fall back.

Signed-off-by: Siwei He <siwei.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7a0a1d5542ee..850de3be1659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2072,11 +2072,17 @@ int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device *adev, u32 inst_mask,
 	u32 num_se, num_sa, sh_mul, se, sa, n = 0;
 	int xcc;
 
-	/* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
-	inst_mask &= GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
 	if (!inst_mask)
 		return -ENODEV;
 
+	/* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
+	if (inst_mask & ~GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0)) {
+		dev_warn_once(adev->dev,
+			      "CU bitmap: %u XCCs exceeds %u slots\n",
+			      hweight32(inst_mask), AMDGPU_MAX_GC_INSTANCES);
+		return -EOPNOTSUPP;
+	}
+
 	num_se = config->max_shader_engines;
 	num_sa = config->max_sh_per_se;
 	if (!num_se || !num_sa)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a8ebc85c9b88..50943ec18b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1469,10 +1469,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 		} else {
-			inst_mask = adev->gfx.xcc_mask ? adev->gfx.xcc_mask : 1;
+			/* inst_mask is a logical mask */
+			inst_mask = adev->gfx.xcc_mask ?
+				GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0) : 1;
 		}
 
-		inst_mask &= GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
 		num_xcc = hweight32(inst_mask);
 		num_se = adev->gfx.config.max_shader_engines;
 		num_sa = adev->gfx.config.max_sh_per_se;
-- 
2.43.0

