Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBD5C561E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14D610E81F;
	Fri, 20 Feb 2026 19:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VL24wLl+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429B910E376
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQbZr8pIx3UXPoE4J/H+osbljcOL4PzjF3niZM6a3J2yvzspKKJOXjyH64dGdXyc5JsE23qCkiHdEvdoqPG1aer2zWuGrlZR5qbYq30zQib5Z3Ar3XFj6PB+zgPy4i7LlDIP/IwcUuymqYn42udAFaomfRH/7HqiUs6pJnGcY42X3c7LrXvHIRbAH0Fe0uO8UY7aMy+TUHumx/c9cqX41lzbL2P/ZF/AnKVOOUilHNZdUC3Xc9mwCK9T3le5Zo1C8FV+IU+jaDGXazQLTkQBQVGgnTnCdTZ87azvj94UyJyBLKt2A45kxkQruuzgFGSU48ESxVMqbSiNZFhIULwt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c5egDjul4peuawtVrm4z6NedE6QjjlasGsuUip+Al0=;
 b=mxTw8PFQkay2mLCJbIJKTEJqwHFvIyN4mgJc5Ht9TSp4WN3KoomDsCxhi/1o7UCnVNhldsPXne1ClM/nQnVjjmSyj0Z3gBi1vFCMfMcQDn2VcSrhlqsj/aCwu2PAbwKfqA5/sMCnmXxDqdSTiU+WdO5CrpUSRI5BUDoOnRvrKuFhOLh1WTwax78HJ19aA4MF0GuxgSkjeM6ZHqzZOh+o9WiPhv1SDo381h2THXivv/c7JIPW9vVdLXgC6YDtcxL6T/m+aLXEM8RKhsBFhmKCzlJoGlj/EBdAcQjjAwnT28+2/M0bsuRIPHPYdpoe1om8cECW6O87qaekMFp8v2Z41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c5egDjul4peuawtVrm4z6NedE6QjjlasGsuUip+Al0=;
 b=VL24wLl+oa/CzjEXwSDufJf2B7W6jY7C1IGLEJkTPOLg/yReTtIEM/mL3RlmRvIwlQXlpuwaY7ahCOvHQ1Nm/dIFd1l7Sc4IwCpn6xWlhUdI8Tp8k8s1EgMKOS/jIQyddOIoyvjBN2xRkU2TUaehUMCUVXCIEilXF1ry06+nNwg=
Received: from PH1PEPF0001330B.namprd07.prod.outlook.com (2603:10b6:518:1::1a)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:05 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF0001330B.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:05 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:53 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 08/17] drm/amdgpu: add profiler/spm interrupt handler
Date: Fri, 20 Feb 2026 14:22:27 -0500
Message-ID: <20260220192236.3121556-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1611a4-e46c-497c-2ee3-08de70b578ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1NHBrvpcnUHUvsQvChsz0S3jukmSLaoQK1Ua4gpVZjPFVqawa9KqaNZs+KMu?=
 =?us-ascii?Q?HrvedeyxKDa/sqEJP0/QK1WpX2HaMueVQfiJ6BZEWoIY/bZEDvz3eXebX/hy?=
 =?us-ascii?Q?LBgxpa8km/3S4Q7ScCAJstuIXd0aK1BULgI3XFDWkD/Tu58ERBT8icHAPl5y?=
 =?us-ascii?Q?+FbVN6teQZJV5wbX8iAjIzLgpq77AlJo84j4lKqXmvp1HRMe0OABCa/wjW7/?=
 =?us-ascii?Q?0SIJc2Y7Y3aJZq4Y+TSVE03zWzCnrow6FWnxy7DBy9SDli8dDVqHpe3G6QYa?=
 =?us-ascii?Q?2LjPO8+bZ+N4pFzlxGtkQnYdmM4yQUz9HS+Z6JUtyK8/XZBBePKKy6AtqLXS?=
 =?us-ascii?Q?RBwPhmc131xXLSg8FiVB5UJJznO3z7u1gA113Jjhh2iLhUTdxQP2XBbdnRMh?=
 =?us-ascii?Q?JCGmic8M9tl45UXNUrjWNu/HwSoY70ijrORNI1dIUGnfotg7qDmjW4bap5op?=
 =?us-ascii?Q?GBh+QRU0mgz5TIwqZuCJSCxKzS77mMKK+9Y7l1MgRbtc9oub41XucRlIF8vI?=
 =?us-ascii?Q?hzAspk7gkxX+Qm8m3tJdKQ+BI+E0bTkmV+z9SjtudsNzu91gsBpzXIXGNp97?=
 =?us-ascii?Q?obdBnPbHRnz69ZMCC9TGxCt6jYfmLpwPK6ox/ZnrBg8t0+jQQB8LdVORo99x?=
 =?us-ascii?Q?4xNEAX5GbrNxry7xYTJFvRhTeNonY0f0cgO/H8U1cQvnNTlO97rqZaLwEH4H?=
 =?us-ascii?Q?fAp8ElzkOlfrJus7TBnYbURci89tTM6ckgUVQm4Oh6/EDIclk2MJX6764Q4v?=
 =?us-ascii?Q?sO7qIPDJunPfHj6LQeR/7qPpOWCd9H5wz0E6SHK5zkJePqJBeoxoDjApmEER?=
 =?us-ascii?Q?PQCBxCgrI3xmRYPHSimd/Qs+cOHa0ywG61NV3FBFuLF9HYNbBcyF3GT38gOZ?=
 =?us-ascii?Q?dG3HfssUJbR9H0a+PgT+/hIAgvYKxwM4QEs5v+ChkZvZEBNKozUBQEzweQ+t?=
 =?us-ascii?Q?g5gQDxNoWMrnqWl7ZEp0EhbOBdrLaLODCWbdHK9+yBFe/dKE/83Yq8zAAZz3?=
 =?us-ascii?Q?9Dtzfo4IwJ9PLjcFQAUyTHay2dq47AIIve244dQzpnxLMvR2hqo1zlli+vEH?=
 =?us-ascii?Q?XDN5guYBVR5GhAOZmxMeYAZUXcaZZr+27/rHt1vswDu6ojHEwpCMG8g2vxDi?=
 =?us-ascii?Q?bvTNWTV2NP98HSvuB9njhL1AQtjN+hY1St+6kq23rV7pxW3Zn2x9yBhGP2KS?=
 =?us-ascii?Q?SMj2UfRmMbfDEx91Sy92BQcImhWm57jFXrSPVt+kKweBFNYDw3uvZPA7R+jD?=
 =?us-ascii?Q?QhX1dtHldAAjMDwk/KxZrdiaNEkSqOJD8Zu+Z8/9KwD1cZekQba/dkms2+aZ?=
 =?us-ascii?Q?qJQJnhxyZjCL7//Zz4rSDs7sHhaM2OQg5x0/XLbGsz07U9qh+CBPqiEGqRRP?=
 =?us-ascii?Q?ldgWhBWNVsDSbOpnoDeVUmMIHwVCop05dmXbaSgyTLFX1pT6pvEaKv2aKHj1?=
 =?us-ascii?Q?/iYGmJw7KAg7+gkak5Rl38x6YrnYq3uZL4ucUN9HUnSHzliJu8uj92+3Sqi0?=
 =?us-ascii?Q?BBBbCwNoKcBtub64PE9ZzkzDyjrZv7fyVazqmxH/KbQ5KN46fbHLC+bZEo7I?=
 =?us-ascii?Q?kWfLTqP+cbdiZIJCXvFJ/+MCIaN420+Rqh1nUXDMj2Es5st8Rw1LU9b04kCp?=
 =?us-ascii?Q?jv3aMZ/zWlYATpRNOueQq1QG6nwcVXY1kFH+wwN7jSuDuRayPNWM/ng4Vu0G?=
 =?us-ascii?Q?arPG7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ALxj1NjgUv0xVrb2Wv+PskgaOSv1ZCG0sTGgLm7CHf/Wb5L49++9sJACd0tMCqJ7aXINmvaNI9AiIXnPwnbJRFmZK/JpQepmRBnwgPwVbSBXCYWaESKLNFHm5XEt9sRkZ93yCJcVL478EXiBGPUnnJ1OEzNf1c+DcJizKn5vr+UFOXwFM2SxpzmsSB5Hk9+AtzOFkhH6ebmqQhaPD4i6Uf+XPhkWGZtuGzoPBa/vuVNZKxlujSJr6KWuQrXyj2dKA9mAbbbx92pbZW1Fb6o+/wuuyT+OPNnIgVBfgOgG6YOY7Gy/boqkngBK4f9e3gF2ztml75OAaeBrPHl0sBI6Rnl8s4Ntar31GErR3m3lBUkPWy5aqsiPOgkYkcxjIxdySGinixEaWCC3pnL2L2hgZfjpjKVeU7yZke5qDpS3d6tqmemmnxdy4Dtfixfu5w1K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:05.2649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1611a4-e46c-497c-2ee3-08de70b578ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

for RLC SPM interface.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 08d62183b2e3..531d6370bb94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -618,5 +618,5 @@ void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgp
 void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 {
 	if (adev->kfd.dev)
-		return;	/* TODO: */
+		amdgpu_spm_interrupt(adev, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 181aca333151..619ff4ce0773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -60,3 +60,21 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 		spm_mgr->file = NULL;
 	}
 }
+
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	uint8_t  xcp_id;
+	struct amdgpu_spm_mgr *spm_mgr;
+
+	xcp_id = adev->xcp_mgr ?
+		fls(amdgpu_xcp_get_partition(adev->xcp_mgr, AMDGPU_XCP_GFX, xcc_id)) - 1 : 0;
+
+	spm_mgr = &(adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr);
+
+	if (!spm_mgr) {
+		dev_dbg(adev->dev, "%s XCP ID = %d", __func__, xcp_id);
+		return;
+	}
+
+	/* TODO */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index e8a44fc1d278..1460b87dc55d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -29,5 +29,6 @@ struct amdgpu_spm_mgr {
 
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 
 #endif
-- 
2.34.1

