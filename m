Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03B8C7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FAF10E356;
	Mon, 23 Jun 2025 09:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ctJpV80q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC43E10E354
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrbpvYur3OffuSKvsXSo/b5tfgyqE3YxIoqZI3E+WjSyu1uwATCUGZwEEaigttJ2Dl+5Pg8sgR8zlm1SiLkj2PyB9Girx3XQyhIRjlcQdH/0STr36bfiDa/yHx++rzcwGojT0d+iW8f1I0CFTGaiSti8++BANmG6s/sKtqVUsKpgCfi699BpphjD1JdQuZTifg2gx7WRB4aJDfjLvXffkaTy4ZpdxGDwJNd3N0i8wRjWvreJu+lB+Nhy4vVriQtEEGOsyAavN1BQso0eBl9PdTDJXBS4L9DqFN9M0ZsP4fiqdsp2l/41b/RjX0SOqmq3hxg/iykRK/k3Bs1liqMR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=GpDYcTvqvGstD2C0ewtpz90AJnqzplyLOoxDpqwHNqJhnqvUoQ810esX6ch59s2wc8DuaynpI4qtCzAYRZSe9ZZwnpS0VXJm7VeVaUY8f3V1aYSQXmIVWpEb2ImrjENNDmgFL/g9cdA3mxCxl24RFjcclaaJ5BDNumvlqVCNNlHGCKezjrHg4lJN4ZNiG20XHfsSVz/3CiBiLdomdDB9TXmNY3x/YofSAgUf5Cv5Q0Symd07Grw+LV2UdgOMyHf3r93dvQBMfG5ocHhwshutcOWzxqFjz6554G6/u915w9QpaCo5/UOY+LLZQpGPznCFqXp10Asg5yzt8C+hK6IRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=ctJpV80qkmW6WTUHaNIUbx2gX/Sv7Jf7XQxmxGhUNRY0zwbbxnCOpEM5Z5WpLE3ryoL6WZOWSzTKZyqn9woV6osGnIYjIhZH5KWORKRr5QCEEbM8VeD0/UWF4DzjqUNu7aLfrIP9EB2gLDBdZgv3oW6tlrhL5An2wrcPytM3Xnk=
Received: from DM6PR02CA0066.namprd02.prod.outlook.com (2603:10b6:5:177::43)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 09:52:20 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::c2) by DM6PR02CA0066.outlook.office365.com
 (2603:10b6:5:177::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 09:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 10/11] drm/amdgpu: only bound the eviction fence to userq bo
Date: Mon, 23 Jun 2025 17:51:53 +0800
Message-ID: <20250623095154.1150830-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: df1210c4-781c-46b4-b645-08ddb23ba598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/fvyaWpMi95W29ptja37cqaNMMbLd0E8/iO1Rkfsv4ZiAguVfOSXLs1Yf2l4?=
 =?us-ascii?Q?aVqUBncHw7XuP1cy1WKHk2131wScNdCboslLfu4sKkzmYtozPmi0qi5wwCBg?=
 =?us-ascii?Q?gdzvCknKtbzMNUH8I/woEW3+flp+zVQaJ0j00dVIT2S85d4ILLcEijgWpzm7?=
 =?us-ascii?Q?8JSOJ0RSzSdjVYcPFe0QU1FGPPdSi7iv+G8rzqwT8FHN0WhH9KzTDRvzFQyl?=
 =?us-ascii?Q?bBbco2mxH8XJTgrVYuAIs/o1b1AYVoL0UYaN02nRTQnnOHtvk06gOfraB4s/?=
 =?us-ascii?Q?uD/pXiHBj19b4KxI2Q48Lf9ys7cANmhu9xRe6MVekZgCYdBvnU5tisdJBJya?=
 =?us-ascii?Q?QeQJ2V3KqIVcBQcuWLFzP28WwaL+Z1RfUKYZJmoXNbiGanxXsyjidEmTHT2z?=
 =?us-ascii?Q?QshrUf+fN9fR4vsKCcnVgWE0ZWHyKsh8u7+P/tq25EPv/8My85by4l2yBXwk?=
 =?us-ascii?Q?6rEApFYhfiLTJi5CHi0bm/hc83hCx9LZHkXiWWGttlLxraQ8559TLWa9UKwJ?=
 =?us-ascii?Q?Mh31MxxEPJs+VwMPXw0r92zskp8vmqRo825K4tyiDHYd63IDDlDKqbGRw4We?=
 =?us-ascii?Q?BlbwIywCWovPY4+YLbyRMxT4Y90ALTOfghrEekJdsOtkibnZQ4H+1g3lJPid?=
 =?us-ascii?Q?TBXKEmPG2My/ykkQhxJWbV/+tL1abHFe9abbyVTuuCeAdgtG4ODp8fk0nbPx?=
 =?us-ascii?Q?qHWfaj7wHm6VvHG0pkLwku6RPyiC1RVglaUy6oblrsn08Hi4UcB9KAT9v3z/?=
 =?us-ascii?Q?qWzw2cVwDKfKrqg44yIksPb9P3dXpjQK6Adcqxdu60cHVbn8VYioG7AZoVGz?=
 =?us-ascii?Q?2QctyZqCwpvE59P80RHtHeWhM1d4Ba0rf1KIAOMGABk93k+PBOz0YdyQVJ5q?=
 =?us-ascii?Q?TXRbQWawQqmeJMqR0khyRhH9Mt3TJ9kKthYjZciZprHemQ9gsp0Bn0XnSvyb?=
 =?us-ascii?Q?5np5R1P2vg+PycQiR34nMBn/oM20yAmxH1BmfVtgyA7ylqAkgTLyBJlb5IKn?=
 =?us-ascii?Q?tqYeutFzkrOP5XKKH1N2XwLBPos+Mp6MfZITH/iIuSBhOJBl7HygKwYz97tr?=
 =?us-ascii?Q?Qk1vxIUPiDNr6Y7r2D95mfYTtFgudvx6tK90ikfz9VWq4go0V0mQMH2kXeBz?=
 =?us-ascii?Q?zkCV0m77oaW0eWCWhxC3LluCprkpU4A/TDpp7mPQu/zOwRArBCPcJJzcYblh?=
 =?us-ascii?Q?7TKtOjbULh3KUzb1OXtjTsX1oNlmJ50Nn38x+PlLho6inzMs3V5ofHyVcDgs?=
 =?us-ascii?Q?xvvA85PVo3QkOXsOpiYkvMxMCSdyMIXRPJvIwtF6BxBiVEQMBTHIfo0PmxYV?=
 =?us-ascii?Q?WS+nXWbibnIoidw3ufRhBWWM8GCwP5b+DLJbHq0R4o56Gvjl2Q63uA7d+qyi?=
 =?us-ascii?Q?OYlfOSsaowfLU46WL2q+sFA2iL/0h7Cm0s4ZXyaN6/+xRW7JBuiXu1ljf/IW?=
 =?us-ascii?Q?m/WQmRhXciwKiKe5p8TWe7fpgkJvv9iKAuymkJuhpi4c1bB8f0qyTFHxAPWk?=
 =?us-ascii?Q?ZoLob5+5JkjmPN5TvSp++0i5NUAMRKLcuuau?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:20.6740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1210c4-781c-46b4-b645-08ddb23ba598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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

It doesn't need to attach the invalid eviction fence
to non-userq's BOs.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..50356aa23a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		amdgpu_bo_unreserve(abo);
-		return r;
+	/* attach gfx eviction fence when userq created*/
+	if (vm->is_userq_context) {
+		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
+		if (r) {
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+			amdgpu_bo_unreserve(abo);
+			return r;
+		}
 	}
 
 	amdgpu_bo_unreserve(abo);
@@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_context)
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-- 
2.34.1

