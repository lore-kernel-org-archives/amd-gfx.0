Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3FAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE87710E47D;
	Fri, 19 Apr 2024 13:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRkbvc7S";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8097310E47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 13:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnYeFC4lmyZ3xzU4GbCyHTVhSpPRIhNPDOj0nmdHrhgr1qRFJOEICu2fxnZ4wLPnV0lscvp4Me/pzbkFLabxfHCeNbRJW0FDiq2x97DgR6lOxOpYXqIk4SOxysGDa6kIqAOfQBcYYbadyzgm06ltyZiYmnStWdYOnHsu6GPzDg7X97aTww6HGxHJti5X0MOrB7PNkm3AXKfS2G3NThT7N2oW0sWdPyN2IMtVLOg2QIatl/AIIWP60DIvLHFINeua7IO6IXtoJxIFHYT/WKvxXmlEIBn2c46VnWJGBwKt6pzL9rjoJzltrbm7x/ev+TqAwDjt3cF1RV/o3wzFVUmUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuvyCNUVdAN6TlAfPnG4jiPx59ACAm9zmrY5Fyr3bEc=;
 b=Gy2A230rO31GL6csQigWFVb9fbtxC2DSRYxmJ6CoyMAfuDVXRrkazrSpZcONYCfxbNugS6pOG9OCY3XkQbXciK/wcAcX6RSnb/6PzrQuIlzBMc9xR9JwSH0gmztuNoTPzt/4RzW463gvDvRYXQQHGNfww6tdc/H22QhFmoYf4kdj/KIzPfuG3ps9bdgSLJq36rp9S8Tghehno++Qcdi2aZHMZfIpLO2/CkcgVxX/L14VKGcIWJAH4k41yElcK9LrsRUWLFimXUgjKFmQcztMAGT04YXobV6eeiILX4SqFk4PANTe5MA6WRRKvWKLt99gnn1VFLssi8qLUGGMcXQnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuvyCNUVdAN6TlAfPnG4jiPx59ACAm9zmrY5Fyr3bEc=;
 b=bRkbvc7SAcR9cQJnURbRi9guM2o8JymoO5LTJj4wWCJ6GJPQBKSSN3jCqMnywJgRtXz0y3RN+efy12LfI7DMMMjgz+m3hMrMmmdidZsTwfn95mdbZd+qcfcSMzW2U7K1bVcZH8bAa4ZB7iKf/mmx8/i0Iz+RjUzV3sYvbiCEDm8=
Received: from BL1PR13CA0351.namprd13.prod.outlook.com (2603:10b6:208:2c6::26)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 13:48:15 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::23) by BL1PR13CA0351.outlook.office365.com
 (2603:10b6:208:2c6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12 via Frontend
 Transport; Fri, 19 Apr 2024 13:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 13:48:15 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 08:48:13 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2] drm/amdgpu/vcn: fix unitialized variable warnings
Date: Fri, 19 Apr 2024 15:45:37 +0200
Message-ID: <20240419134802.302539-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee7b0a9-153e-4ba1-ac29-08dc60775ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QGnVHAIPG6l3ldInGVtmnot6oSuebAU2J373xE04U2Cepb6VpYf4KgVv0d51ySKVvtVKT1Y3w3WmPk6k9u2s+jmh8kKyV06M4cmta4NSeMK0pZqdQuZAcoeU5DqVA8hDETZ+mID7CzNz+tugyMF7iqcf31uHAqA1TIVQOyB4N3OLb/v1nmLGfWJSW9rAvPNj86DpBcGc69a0/1v2jeTEcNaUJc8mS+ti4E3z9Jn/MD72yCorETomG0G2zDbj1+6a3UTBvhr1lHRAsV8HAy1Q7bZpDr8OuYE8o7Wp2uQgUECAdrMslMbE8Cae1v0BD2Vvu/BAXcwtpJXhgr+DAffMbi99oCUQo8xX0hhBcD3u9hwo39/GDUahrr7hZACdO+qn/0i3CGoSasMhVzhS/aJ+s2Hw95moXuFDi1kkoJPVwf2//92ZIBIVKgc7LcaiEMZ61hmzxZVGz5InXcSjl9XAJcRZt0kfWCHbv2LHYwMD+xxHrRP4fsz8VV2PIuhfyhdPdhaM1sNbe33IcV2dyu9nXP4s99rdLPLfkJo+CAZdhdpM473pF+pzPSJGBfSroaqLod4ISlIjf6iYsdNc9ZIdYvY2NNCvgUUjFvIOlYW0hfnlXCZjiRDYlfcbi/ATLdy+hx7+BQkK0/YeSszvumqxzU9+6rQCrfA/7Q4U7YRdJcBuM5L24SPKZTj+ivRsywMhyccgvY6+yUU+hLIvvTDZrWJ3MWIJUMDYqdlsTbhH5jcbjvcjpnTTbUgs6C77EgZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 13:48:15.4670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee7b0a9-153e-4ba1-ac29-08dc60775ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
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

Avoid returning an uninitialized value if we never enter the loop.
This case should never be hit in practice, but returning 0 doesn't
hurt.

The same fix is applied to the 4 places using the same pattern.

v2: - fixed typos in commit message (Alex)
    - use "return 0;" before the done label instead of initializing
      r to 0

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 8f82fb887e9c..26e63f01250a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -359,6 +359,7 @@ static int vcn_v3_0_hw_init(void *handle)
 		}
 	}
 
+	return 0;
 done:
 	if (!r)
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 832d15f7b5f6..aff1a4d8d393 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -288,6 +288,7 @@ static int vcn_v4_0_hw_init(void *handle)
 		}
 	}
 
+	return 0;
 done:
 	if (!r)
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 501e53e69f2a..8f2bcce13339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -237,6 +237,7 @@ static int vcn_v4_0_5_hw_init(void *handle)
 			goto done;
 	}
 
+	return 0;
 done:
 	if (!r)
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index bc60c554eb32..b226306164bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -203,6 +203,7 @@ static int vcn_v5_0_0_hw_init(void *handle)
 			goto done;
 	}
 
+	return 0;
 done:
 	if (!r)
 		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-- 
2.41.0

