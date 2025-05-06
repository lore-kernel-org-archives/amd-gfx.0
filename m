Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F244C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFD410E644;
	Tue,  6 May 2025 09:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4nTjNO7I";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD3310E641
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1RS5a/yzsIBSzeeykGQilc8gXAs/GXIssdelLoeD8yUllqEoUvNwkA3OdZsHGS33JqvOKs+eNfaMSAlBS30/F27PVSz+Ui7KZlpVhR7lbJ7VkmNTiQbDoctUg+g5cjUl3aqMtCI4cVBzE2DhKW1etqw8knuhZbjlMG6Kmphwjhug6HX2vps+b7ZXRR7xsEoy7Zbj9bqVANQNMm75smCnb2zq0xUGsg2+seffVuOfIEapW62EnIRD36x6LxyWw4UEqwGMtD1oJRo7R4q46gBAbOTIZlJq0nUgD2mQX2QAIIMso8zspMAY+t1/LNWw3JpMtc2tTnGDCQqUX4ItdPKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANIbU67jx9RfHJziRkQtMPbmBPqbYTypUhyp1eqHpas=;
 b=FihgtbVNzlxcYHa/n7lD4UBicqMolG/T7LHfH7ufH4QMpQPd/Jbewzh0fvRsHOGv2/djP7dpEo1Y8Bsb4R/WdKUZ6mLTAHhxQJn0zBbYQg2k7iWnNNoepfKkeHqQ0f+uEcwS0wVnabj7Cga6dmob9dHA4/oyEntl8iu9diu2Npa08B+SCRJQsuQ39SRbDJk+k24Jvn3NeRGan2IB1ajS+D9/0tiQL0sjDd0nrf7mh0FMTesKF9QRi59ZhAj9TWtSdVF6lfGIEJMKC15F+nw/T43dK0zBiQa/dbD3B/sdTTBy3FKps39OGGbzpKCU6+pMxyohH7SvMjxS2wfLDjdnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANIbU67jx9RfHJziRkQtMPbmBPqbYTypUhyp1eqHpas=;
 b=4nTjNO7IkV0sbSaX/ZNs0/pMlP/rKXg9fGQKX7b4SCbIlFT5eZkzxH2pEdqPUJw/Djiy+ibKFLeMSkUbgjc1VglGgVRADIj2WwQfolu7cd2+HltesKT+FLMFllsucVxKmNunc/qcgVTlQuB9bQSDpfDr1DM+MvHlm8f+yon17Po=
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Tue, 6 May 2025 09:38:25 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::5) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 6 May 2025 09:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:24 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:22 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v3 7/7] drm/amdgpu: remove cached gpu addr:
 psp_context.cmd_buf_mc_addr
Date: Tue, 6 May 2025 17:36:29 +0800
Message-ID: <20250506093629.249792-7-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: b30daaaf-436a-470a-dc1e-08dd8c81bf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dVtxntJeMa/He75lDRyLAvJwONhTBg+V7Iae/+rEvo+ZquqnPFxA5kXoewX?=
 =?us-ascii?Q?dapr56f0U8t0Ifs+9i9yzlwxNpDwcpo+UH6IusrupAK7km7hHWrLRQymqtso?=
 =?us-ascii?Q?Gg+tZieDUesbh7/HUFXu+i2Zley1LnJ206Opboa9+Ou1pAASBlZzvladUkIC?=
 =?us-ascii?Q?Gzx3rQ/rG+Zg4OAEjc4sT5oiHonwsjcn+gx25lZQ6IouUGUoZhysAgX8Cnni?=
 =?us-ascii?Q?l2Gabt7UtvjTUHoBU6HL6S7Od2ovqdlOc3Zia3FiEal3VHJ6pmFJk/fF0JsI?=
 =?us-ascii?Q?eKzz4e469xW/wUk01mU/GyjADC7H1MWwtNF5qZH8ORQv1UFJYuQetQZmQTTs?=
 =?us-ascii?Q?F2uqB1Z76ajbsHxIhx6vI1qh47TahrEfXtCKc89ykPtpOWzr+Q3nxdHz8SAn?=
 =?us-ascii?Q?RgpJU1gOMv5eTWzg3VY0X4EtsTrirFtCtFWxEgPl74fuIzolxmIv9VgjGKyl?=
 =?us-ascii?Q?8JsX2TbxOUsgUXXR0POLrbPVHmV8woIsqtigazAknwlvZ0IQR/f/qJh+MS0p?=
 =?us-ascii?Q?RkYnwOPthK1BsYtsl3TkC0u+wnbjhYSZBWlKV/gjjJH3r8rWxGiY+Q/Nbr1E?=
 =?us-ascii?Q?3kJOlPZMjR9sqDHde539F1esP2TeXdKjizaxL18/sDbUkT94wpIt/50eacl1?=
 =?us-ascii?Q?JDP/QpQIIUaH31VlC9KtFirLUciL2uQHunyb/bWToPASDtjqvqcG039z/TVJ?=
 =?us-ascii?Q?HwLgZbnoAVgVZvDdeOOy8YVnnG2jw6mGw81gfHC1XbU6pJ4jOZcf2tAo2wj5?=
 =?us-ascii?Q?4SuHNprubmod1v2jP+2RtDAE3BPETNUlp00mavfpTwcwkUyEqwOANut5UIiJ?=
 =?us-ascii?Q?l/Mz/nQoMiKWXb1XQ+DtxywvMzVUixeMKH7Q6sQ3SdPSGpBXinKqA46/3rX6?=
 =?us-ascii?Q?CKY+pvW/2dFtr0MWzuKepGmdW03nTzgdO07fVs0julia4Hx9y02TXpPMekKQ?=
 =?us-ascii?Q?4QR0cSVNv7aWyZ4Vcwck2mF++dTczmYfopPCuu+HCi8VTREUYeymkmzxe+2n?=
 =?us-ascii?Q?B4tZfBW3fpwTD2EeEvZn70if43KKYXfa8nR5Bl1VVPcuz4ydkf/qnysXlZ8J?=
 =?us-ascii?Q?XQGOm7wOJGf79sSPEAMJI7q1W0qYULc5wSS+PR/fNx2Rm4dKq90w523eedYw?=
 =?us-ascii?Q?KzdwxbpnCym1/uPZJp7hOx0Mnt4pvMT724qj7okeNYH5vA+ZXGSociNpcewu?=
 =?us-ascii?Q?WEXLSbI0XmepGuVPQLwvwKOnLGkC23o2dqqgAJakJP9zzsl25H/2NYKf0nC5?=
 =?us-ascii?Q?qvzOyQgGS51hl3D4oRBilOKSQQefLKYTs2J9t+ogHO/7+HYnMeiZeP9XsEv/?=
 =?us-ascii?Q?ySyaYJk0UWwLUe3+lT9CJjCgUuJ3maKDZo25UPO25Ysfe85FzB2PSAhkm5iW?=
 =?us-ascii?Q?K/hM6Ian31yDEvFrRZviFETb+EJ6+W1hYsJiK3iEPpk1n1qHQtVt7pEdDyP5?=
 =?us-ascii?Q?JecYSNzOWN3vprHM12df4c0eSGGqulC00e0YG1lsaJjHpg/jI9XpK4Q5Zxix?=
 =?us-ascii?Q?TZ7AlZ6WABXrcgyRD05SDzG0bIetP9PO/2iM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:24.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30daaaf-436a-470a-dc1e-08dd8c81bf9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3b71ff298f21..c89e593d4819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -524,7 +524,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+				      &psp->cmd_buf_bo, NULL,
 				      (void **)&psp->cmd_buf_mem);
 	if (ret)
 		goto failed2;
@@ -567,7 +567,7 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
-	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, NULL,
 			      (void **)&psp->cmd_buf_mem);
 
 	return 0;
@@ -682,6 +682,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = psp->adev->psp_timeout;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	uint64_t cmd_buf_mc_addr;
 
 	if (psp->adev->no_hw_access)
 		return 0;
@@ -691,7 +692,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
 
 	index = atomic_inc_return(&psp->fence_value);
-	ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr, fence_mc_addr, index);
+	cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
+	ret = psp_ring_cmd_submit(psp, cmd_buf_mc_addr, fence_mc_addr, index);
 	if (ret) {
 		atomic_dec(&psp->fence_value);
 		goto exit;
@@ -2344,7 +2346,6 @@ static void psp_update_gpu_addresses(struct amdgpu_device *adev)
 	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
 		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
 		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
-		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
 	}
 	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
 		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d3f5c17ead7e..491697e1f141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -365,7 +365,6 @@ struct psp_context {
 
 	/* cmd buffer */
 	struct amdgpu_bo		*cmd_buf_bo;
-	uint64_t			cmd_buf_mc_addr;
 	struct psp_gfx_cmd_resp		*cmd_buf_mem;
 
 	/* fence value associated with cmd buffer */
-- 
2.43.5

