Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE22AC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2627310F1C7;
	Wed, 23 Sep 2026 21:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wHE1hhjS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD35C10F1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXpIvGwEQ981DaYfz8uCdZPbErNBl+L1WPyrlYkwUh4qNMJxagWkYdEaU2bEg2q3nhPnoPSAlxwxQgOL+B5X8ewwI3nXFnnoiGWvNLvykH80VHNQc6xiRUP76HIdNGUOrVphD4StBeGpJDKwjY+QTxzFcKJTcvn3MAbCo1PGlirOkN6ItEnZwWgY+N0A5/v3p1tAGcxdQMJTUKJ9sCFLMGZyj1/Nqjw+DvybVHAq3uVxv7y6fGpr31PNurt9tfndzsPNx5CNRbH8KQ41eL2B90WWrMdYAb0uex9QlKNBN6XPNYll+l/vzKXJKGqgEDvZ3B32WcyuXqcA8fBosbjjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZaPkWzyxZpT73cMOIERDD/NLUgFutC3JCEeTGzm+TY=;
 b=s/aMhKa5oeMPXkudzjFehmkiRg6ph4s+EjN9Zgeko8aRr8SNiz8YhmB4piTIsMikeajqSD+HsPSFQoawevl5FgyJ7fVqttXYUGXSdVVGI6PPVQUZ706qvUt3y54QvS3ymkpVr3x22VQYnSc391Ql6jjRwN+ycfeJBCV+EBhv8pKsubcIG0khfkGDyoWXOiNhI+wEvk14r1l9UR9R40HOZwF6Oee8Q7+xIaZQx7FzUDz1nCH5Nmge1n2ziv9SbezgM2GQINlwndvKL/Qn5DTDp9oM2fUC9KvxxWWQytDRVCiQu4DF5JjQTtc+mHUKo+hjXpah/iJzDtziZqjq0X1hWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZaPkWzyxZpT73cMOIERDD/NLUgFutC3JCEeTGzm+TY=;
 b=wHE1hhjSxh5/oLEnsPNHiQINoZAxknXzF7zbrgR5MkGGtaeARgoSSb8hOz77IaSp4eElhfjIQMXZa/r3w76n17RVQwj8HLQHyW4usUwxgTC9DVQ2cC+Vg2WEwc3z73yDYA0OXOKfrPoex7WQPU+gLTyUSWN4/1o4vdTzWKq21Qk=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:29:02 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::1f) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.9 via Frontend Transport; Wed, 23
 Sep 2026 21:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:29:01 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:28:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, <Christian.Koenig@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
Date: Wed, 23 Sep 2026 17:28:37 -0400
Message-ID: <20260923212838.1421843-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5f5cd0-45a5-42bb-3f60-08df19b9afb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|5023799004|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: LCKrXy3+yzvRVIyEPOHVgnB4qXjnSv8koJgGIrdVumQ+MjRJPKBQ4mYvXbTzptikFWYGJHGeULGXOqTClrM3FL2iX4rf547sncJgKPGfAJpCbjVY2uIAdzUpxw7QIfjT8+dcdaCkCm5S9sxfr5g+NLMESQCbYaIKF+JRaESyYvp2dil/VHUPWq+1BXM9OA65D7lsh5naqHdfiV3pZoQGaZit6xmTEV2l8NuIBiuuymhzuNcNoil/oGHbOVjEN/cH5oQ01mCBbq0Csj+vKmnRNVh+XgsrgNniKsrMrvJ0OPFXsrrLzuDxHNFt+XSUsM7FxeGZ54LHiOejKFwv7xn4rbeytUWv6T10GMIgXnO40lY1Kh2i7gfWIBFGIVEIK2kFpy8wmhKlVJSgW+05ic2pWzbUtNK2IsKL+NVW2o0y0qV6TDrtnQxjdOZDy9P/NNh5gCTAzaWT+m7h5HVLJMysGhLwJ5cwlVVDFGEuX/s2hKx5d7DRD1AgRm0gcgOQRYMT6e2nrMbEXkejN6ZiOg7fViFat3XNz9OXl0yxoOEccGOSBxvRFyhYQAOn5TXQVPb3u6lynhMhtpBxevqVbt0gvpJksqiz0s3wSszaVPRDN9q5sTEVwAJeoaf0zughXJjsN395oxGQlf4LUYSwQtSAOUXSBd4OE0IUk+0PVHgDtEQELfJ5JZa6GFbecsSg0fXeCFDhMai2lY2CgXIEHV6CpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MEUBTU+aVuMrVCcu9E9T8H5a8fVRFUbMQyUCPmgxwSsUg8E3QzqiUc9uyGI69QitzxODvSxABN3/0qOexO8NODs6HKPa6CdQg6MU+bpTrMxPPRNIevzWXfExiViTN+aQbk0NKHiTbhdPZ06ZjX2fy9dk5KXqj1jGMyeiNafdqBZ9OtFfJhMup2kXZUIOF/ZmSUqagOAgYvHA2rXtIdpQmJkC+AspGE0zzR1u2B9PKDwNxmOxqld1Y1+hFFoXP0V1ocrxmXVuWYu+QJstOWgv2vLDKPIJBfOqXCGIQj+LgJ+YIP5pTTCt8YbU33FwQ2YspSE+cZ3p+Q+kDU3j9nnLwuK/VWg5JrhKPv327EMp3GhYbqVbEmll/S95I8sB+S0lW1Fh7gH83lZW3ysEo53V3mQrnV9U2Ylc+1NJLSy08JVIvfdaPRS4L6ONSlk8uh8X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:29:01.6090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5f5cd0-45a5-42bb-3f60-08df19b9afb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

An imported dma-buf BO backed by a VRAM-capable exporter holds no host
pages of its own, yet when validated into TTM_PL_TT it is charged against
the GTT page budget; importing many such buffers can exhaust that budget
and fail with -ENOMEM even though no host memory is used. Set
AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
domain instead, which is GTT-like and still bound (keeping the exporter
resident) but carries no host-page limit.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 4031ebe075d8..5bac2474af03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 					 AMDGPU_GEM_CREATE_COHERENT |
 					 AMDGPU_GEM_CREATE_EXT_COHERENT |
 					 AMDGPU_GEM_CREATE_UNCACHED);
+
+		/*
+		 * A VRAM-capable import is backed by the exporter's device
+		 * memory, not host pages of its own. Place it in the PREEMPT
+		 * domain (GTT-like, but with no host-page budget) so many such
+		 * imports cannot exhaust the GTT limit.
+		 */
+		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
+			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
 	}
 
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
-- 
2.55.0

