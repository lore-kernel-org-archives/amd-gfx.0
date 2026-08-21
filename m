Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C85C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E894710F47C;
	Fri, 21 Aug 2026 19:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPHliW/L";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3445710F47C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5VI40JGMTRBGnrhzqwQk576BwQwDg3H8bMUni3d/cy2hWz8+/dXqjfIUjGasUczwkfUYnOwwtpjCJeBq/38bzKhRNJyNO7PvMBF8Vh1DiZwxatDF1QqN/CWEZ1gWlen93TGLHCzhElKr/j5kDOEyib7ZmCavWZ65DI93QjCXVkc6oMHsAOvubRCL8br9vL7OA35yJbT8mCdxXkRtPgcerHxmW5vGwgw24gSHaJ6n9TIBlYk6/GzS98Tzkq5NJXaxlIGTAjqOruzT2llcObtccrDxSMmyn6Be8CQ5KieMYRonIauRE1djl4DRdhhVgZBy7g1aqW9vqJmzAnKFboUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfO1XJKJgJAzhJCjB5H0t0ghftvWFVrT8yTI2DE3zN4=;
 b=Cka+GlSb96xg1w7Sq4oOeQlN4ivciHxBf+BhSINLPHD4h6PVtPGfU57lb6wLXqWZA6R8jV/srX3wnH7HFYXRIsENS+obVb+GkZ8qkJXFzvfyr9dYeUo3Nv7Ft6YzzDh9P5A/dafAMpLFzviFumPf5SOts7OdzZDX6aFqX36+AZ0o33EGrtSoxuiL9qVsTmIyP0ZoB5G7hqX+DeQSoQxkcD8soK1iWrFRD3HTbS08e/bJfUa4iZXH+PxKfLQIjcBVta3sgJKc7VhMt1t50Y245L+quhxLr4ZOSpBziOUqCxOu1zHQPxa10Jf9EDqPu7sYMAUCKCblHpFF+VpAc2bv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfO1XJKJgJAzhJCjB5H0t0ghftvWFVrT8yTI2DE3zN4=;
 b=VPHliW/LW2CKNaJ07ykt5YVqBxGDxysyTI4a1f5tf2Yv3TZqwuFU3ZnUeoAdHSL/RjAbSZK/dkq7IozWD0uHL3iiy/uHhYwU7VBsEfr4zN8UVtOKDQN0T2+ZuzWaWZK+tjCx/xWeQOGlvn1IvlDme95OulKciTPmr5VFPNmjhZ0=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:47 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::35) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 45/95] drm/amdgpu: Control NPA DMA-buf importing
Date: Fri, 21 Aug 2026 15:34:08 -0400
Message-ID: <20260821193458.808626-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2e0246-03df-4ff4-efff-08deffbb65fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7xMcysBo/rqiM6uBbni7PfR2nnxqtE9LOzvq2crtZXXYQz05ODXMRRAAfsT1SQhyQpaaLpRdxrGq/HAYE9l5b1NwbSIwjCaxOoxr/YsrwJG+sqFfiRT3LoUH8nEjU5W443WpZch9qbBy8/w8xIRm7hTz2vnDTIXeoSSfMZtkp0gPQayPC8oSyGWlkCjx4D3vl31KYPaYgTWS9RA4s927+SAQ+xwqqLIzJCBUKPtpwmg2dwtxZVtkKFNpzhbC2mwPYJTro0HMVbucJBkckjxTeUGnULnXDsDQm2uEl+0pNPcbA/HMOo5VPPAT7W3MCrXS7w6f8tILQF6NtbvDBuEvHQaOiDn3DM1kC9qqhJTyCL/4VdEgSEgigqgCgS58SokiPkD8SX/uL8W4FdYajcAtxCUu947ALNwApXeqN+mKslB2SWnwCubRA8SAP12JKZruhdLW1MQOjlrnv6qfZwV+YMIq0aEk2teiFki9vBRlYPbencA9SmCWKoEbb8i2lo9Yr9S/Ft+qJHlVpUTpWbGKfTfPzEbSKeb0YsHKyyjhgQEpo6UlREt1pTT8jOJ902TK2rzM6xvvNSNuqvV4hLACBKC6i03YBzmhpMxqaKOJ1zOo6/6JMpJzgt842s16i9hOmz0+1EgQW6/6xBw+7ELHUAf3sUNtrxuj+thpQvPCjYKoUCE3YnLh28xe1Ql/3n+ugSWJN20N2oyoO/b7U6mFPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uo1OCAIeLT/5nt7gPvbckSZAnoth5ldleNFsKQ/fyxp4zPCoikCxvV4VVE+Jg1U70HZLNM9hTUoWQxxk+zXpPXsIFt8d4S5Y6uwaHF7xGgSktDB4DBt6MmQVuiVLYkv6Xz4brc72kmBXaJK4hvDyfbLav3gXjbDRn6DgOTvR6Dy58c2PR7251svG9L3C+vQsUCxDWjsIX8BQ2R11k8B4KgF+NdNK6YdX25+UhJQtVbVOzZpy/cJqBVN94t0hb4aopDAq7VvwzHogiY9yA7OxU6zASdVktpcKlXt9PTCfnT3WUPeHkDU1a3caKYW7ffhA5082XCNB983vMeRWpaM6MKCvl3PSHfIdudEBR/qEKlcI9/PRw7PjHVy0MNiqxOEhfLtcP0hbd6T6LgQa03pMhva/vy2RTK6hrciEneqUYi9iHOLAg27OCmfRY8KXRv8Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:46.8067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2e0246-03df-4ff4-efff-08deffbb65fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D
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

From: Mukul Joshi <mukul.joshi@amd.com>

NPA DMA-Bufs can only be imported on the same device as the
original BO. In source-identification mode NPA addresses are
importer-specific. Each GPU needs to import the UALink handle
by themselves. Sharing the NPA addresses between devices is
meaningless and potentially dangerous. Put controls to ensure
this is not violated.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2e..b4fbd8a407f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -558,6 +558,11 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 			 */
 			drm_gem_object_get(obj);
 			return obj;
+		} else {
+			struct ttm_resource *mem = gem_to_amdgpu_bo(obj)->tbo.resource;
+			/* NPA DMA-buf can only be imported on the same device. */
+			if (mem && mem->mem_type == AMDGPU_PL_NPA)
+				return ERR_PTR(-EPERM);
 		}
 	}
 
-- 
2.55.0

