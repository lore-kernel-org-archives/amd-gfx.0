Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF09CC6B2D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 02:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8F310E2FA;
	Thu, 15 Oct 2026 02:10:26 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D9E10E2FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNUyfQkbuQL1lBW/AvTbslrt4cG7Kq0BzkxY+bLugo6uZ23AgPHbFgfxiFyEeEyyws06thW372x+F1+8MfcYRJNQc0tcYN4n2Fd572N3jilXqbYdO0ldPx6DhJc7ykhTd34n/KD92AI+Ot0Bjxjd+qv52QTmb3Kg6Cmo4DojcUWjLtQmoaydlfy6X063+d1JHrf67RJj0gEUbjK8sOp9ZC+A6FuIN/QCs+a6nJKBZbtbA3yJ6xDxbFjSGdn/1C91GW+fx7L4kIkoOnuOhfDulUHaieBArQiHB2P7dC5PIuG9ToRoBb6J2qmpUk24WuulMyIo+TJyaIEZjoQF6XoxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJC4Xhu9j6oMbqBN5K2wCL4gXZF3+SQbIlPdohajNGM=;
 b=i7c4zd4ScZ/X6q3TQ1V0c5tOIUPCRln41aTki4Tw7Jxbr1BjPIZstiUNh3bo3U2vuFdgkwP2hGQsWzUgO0Qj0RgwhDSt5udGqjJ7D2MoYOR3V/v/q/usFtzlFHvYRqjgTUzM0skwnChD5NYT125OmI76JVpV2xx8BOAxXjDX8KU0RE8y4tnzViRtW/SLcFIhVVjmOUg3KzyMbn1vepe/wTnVdGiTZxZ7t2GVFTTYFKRqmpz/CBdNRqz6PsPK6qqquuUeTHDe15tNakcFMynKVfhatmRxURrE+zBEWNN6sVvhwI6/4COulYlHF1CmBnfLS1XGeBqlUHTeFCC7EZFg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJC4Xhu9j6oMbqBN5K2wCL4gXZF3+SQbIlPdohajNGM=;
 b=roDtkVvFnLiQceiZVEwtOElcO/XjVKkYp0nqC99RtF3XEeGFZpYoIWHxCOIjP973uvS+fpz1gyZPGRHixr4eYry6OJo2iVQPgTQb5xzsSfJUS9GX4N0s9Bii4PkIFCnkeF2VVufvvZ6RkhJrCkzncletBGD7lUkcRhL+IkwjneY=
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 02:10:15 +0000
Received: from SJ1PEPF000037BA.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::9a) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 02:10:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037BA.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 02:10:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 21:10:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 21:10:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: return copy errors from AMDGPU_INFO_UQ_FW_AREAS
Date: Thu, 15 Oct 2026 10:09:35 +0800
Message-ID: <20261015021011.3221624-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BA:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dab79d3-dfe6-4ae7-62c0-08df2a61736e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|261009223027099003|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: tMzHsbegQ+qHfD24YmOQVLx8jH+FlMs9SMO1Nvn+2U4+A8RBhUnrK8xRY2dQ13mmzHnpvwvSZEKnQ6Z876ExrF0vro30QGSmoLX3TU9vqNnGEE5m7KMzQeA3U+celOOk0fJUiLa6Kx8pi4adS/WxFGMz+vkeshYdI6Zmakf5lqMV16WC9RI6eruiDpHDJKdYJVF9pCnUVvHvKgtIasBiNjXmTvRyFL/Lretz1iQKHhhvgbuy9k/z/sXxWuzVvkK6CTLhGVwX4juwfcLaqmjJAEW6F3O7bm/genwpoi++R2A4JvYcu9DaqpkZ6WlfGr1H84ZcoQt95rf4VzagevQwAwmN81SPAS3HZnNDopcDTbcB24zvEPbzxalvc7ZulzLKCQwB/K31K61PZuA5zvbdd3n5vAjHaWXEVg6HDoQiS5Upl6yo/LlSyNUYalFrj0BfrRycC04/7ojt9gWsMq6/x5M4J/hhUojWt1ObHywA0+7MgU2aldZEo2BkulIz8QPPFW8IgdjHzDyQ4uuSNB82vW+yP3qYU9eKFCuWeF90bHps7YTy3C/QSMWy+7EtjnPct+m1VWjXxOaCfXlb9bidfk5JSKwrR4CHr1E3eLfEqcIj0vbfPqEC05ZB8nOe0N+BgKCAS0WyOz+5uo5VQWR41l/WYAiuJqgEN6hoN3ZJZAgJqWW9hqttP5vVOE2BdSTGPUxlhwb1rTqzCZs68Dfk2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: un/HxjyPwbjAnkP79nFU2mI8CsZcHS256VnnW10bL9zUoT2h0RVn5m+cqVsZWSNVLJnRWK5G9n1p3VVVxMbLZNl6ePE+OIw6rmAbeHCRkYVS6fRv1riSm/FwG7ezww0ozBt8DMko+ZB6qBApXe/Y80WAkjVzWq6MDH0CbNMLKkqNVQiKDR116Gi9vtBKgxYH4UpAh75uXpd+5fUVtZ0k4iYvU51YyIQX/mnn6VvP6tznCeeFp80YHAZzSGMtYVUe2Yr3a1+Ovl0JcJUoJhPStrmhspE+y2Os/lopFSWGl/GxTzkhhriGJKMxMiqyLbwDehDTkCtv2N5iTboB3xjMJKlppEWZjjmweg7BmFzt8sKWGZO3yyFVHoephr/TrAWzsDJVXruDjrnUJI3zExjUBLbOdIdNFH9eHPwnQlcyDbZoXfwq8kYPW/z9BpXlErRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:10:14.5407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab79d3-dfe6-4ae7-62c0-08df2a61736e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

The GFX, compute and SDMA branches of AMDGPU_INFO_UQ_FW_AREAS work out
-EFAULT when the result can't be copied to userspace but return 0 all
the same, so the caller goes on with a buffer that was never written.

On navi31, querying any of the three into a read-only page returns 0,
while e.g. AMDGPU_INFO_DEV_INFO returns -EFAULT for the same page.

Return the result of the copy.

v2: return copy_to_user() ? -EFAULT : 0 directly (Christian)

Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq objects")
Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for compute")
Fixes: 0030595c3e8b ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 084d8517c194..54e3cd04e7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1431,24 +1431,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				return ret;
 
 			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+					   min((size_t)size, sizeof(meta_info)));
+			return ret ? -EFAULT : 0;
 		case AMDGPU_HW_IP_COMPUTE:
 			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
 			if (ret)
 				return ret;
 
 			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+					   min((size_t)size, sizeof(meta_info)));
+			return ret ? -EFAULT : 0;
 		case AMDGPU_HW_IP_DMA:
 			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
 			if (ret)
 				return ret;
 
 			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+					   min((size_t)size, sizeof(meta_info)));
+			return ret ? -EFAULT : 0;
 		default:
 			return -EINVAL;
 		}
-- 
2.50.1

