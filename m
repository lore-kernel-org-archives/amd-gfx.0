Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FD606FAA7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PiYgmlMI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4C910F2C2;
	Tue,  3 Nov 2026 08:31:44 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B3110F44D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ3wHwq88ppnUM5a/YGuFAji8nXr2kFfnDab3edUpjZfKLX6/DBfv+EWlya9Ww3tVDG36wMe8Chk2ZpuNTuxv9GCesYkXsWua2YlpKG4jyQgKDVb6+XibcBzi9/n9px5cQ4yittqBEz4Q9zW4ba1pFBn9o28OHNcidwYBeOgVgM/CNZjPsCVMz+W84NY5P8p8+NbYJqjo1FO/EA2deyJU6fJ2UH4l9nR0vfMz3yNtYsfNVTxlmCD89Zn9DS7Vg/MHFoC2hqul0sZ09urtR1dhN0zZfpvEibfGj93Afx4ll8f44A5x4z9ifSGFEnwHros8Vm7Qk2iVXrIKbf8XUkNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7LfjtE57Xyz8WD70kdiI6tW7NyzPTaNYZKKoD5fxL8=;
 b=qa3fAU68I756nf76ipIb1dc3GjWXMg4YWsq6ahKqXvxAsv10kbkgVGs9g7hZMx/yv1p3sm7H9ojaFzp3LF994Kr5grUw9fTwuvZWm0GoE5PAkDHNaDqb1pn30+J5LxEnrrT+x+xI1JiY85Pvvj/khYurcCnVQoVCZRhD/qDSU3F4MHTVn3fWylQAAaWqQg97C9R4/2JlheYnLvyqJlQgvtf/1PIYwEaxx9n6iM1rsxT/ifrlNZknhi7Q92NwgbrLot4WfRm1IcUxGNggFbrZxiPgeoLnq6m0L/LDf9ucDVHiEXN1Vsu+qhDf+KS+y9L+NYAS1oTq9sCbtsp+u7W5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7LfjtE57Xyz8WD70kdiI6tW7NyzPTaNYZKKoD5fxL8=;
 b=PiYgmlMIcN3QT6epxj9sGXwi+UBwk59OBgrcqGNfRSyFXejEZa8PbWEntJzj9K6wBtRoWxj6XJOrA3PaNSFEsp0NDi7bValuBB5Gj72NSJM33SE1od0zCyMsozHtx7cg9v7/zAsWJzq9cWukwvUKx1wlMFR8GpslN2qGBhUsKAA=
Received: from PH7P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::31)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 08:31:35 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::1b) by PH7P221CA0024.outlook.office365.com
 (2603:10b6:510:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 08:31:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 08:31:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:31:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:31:33 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 02:31:32 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: don't walk the CS chunks when allocating them
 failed
Date: Tue, 3 Nov 2026 16:31:13 +0800
Message-ID: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f9536-59e3-4c2a-6680-08df3984df0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|18002099003|56012099006|11063799006|261021123027099003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261021135927099003|261009223027099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: ED7/rwqXmglDILKNAyCsawQzUAXCkxPtm+H5ogUBLNvgaC28/UsqU1v4XsHQcAFsz6DbxQQSHu5VrhaX0lLY6E/Q5BautNvMzMDMQS5DMo4Qv4Pfu0umNNvgHf0LKdsLdWl2aazoWvPKs2g6x9T3t1w61G56/weKRmG3c93yTqyCU3SV0yga34vnzI3H/ObdHQx7ktOydGqvyQcrYZOf4r+uP2temdiMAj+fDBbLOAz/15JmfRMjNfD3SHB5aeo46ZU1eWQq2kDUyqEJKGu0wOFcF1LViRt/nA6lbX6144h4HWA8gflcLffk0hNdHM1CztrbjWhEoEYIEbN0ud5mkNo0L7tuvLFDLUbU6hAPekSk3L/wglV0smSKPrLPMWOmg7OvGle9fMGBROjcL2d32RG4gmazIi2G3+UvfuslYiTZfTeCSab1KfCrjj9FE8NGTiFNqkeYBKGAox9NrEUJ64q8udiN7Xpx38C5MUvd8tBYWeKDaC1jlBm3vlZnPYPZyBJ+H5YnlYQJiQdqDsMOtuuU0CBts/GVhrACntFU7H8Speuh0nX0hlCww7o6CxqwqMtjVYBe26Xf9SFx7xaodTHIAcCm8Y9kiKHDjDWgLyUZNDhAEfgkPx16Lo5iO3hIMQQc02UlBFnGjcu7tTj22/+7Db7ge0dvR8T4doOjRRzxnsEAS8fN9ue6As05Byj0XioFg91ZM3RT0YeWChhpgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021135927099003)(261009223027099003)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MdHJLWJL6WwSazf8WuJWjQBzLhN8kZkZS2d6IpXx56jJavoDw/IO3tKoOGm10N61VJHflv7Oe/XA38yc5DHOqKgTHaoTyND7irB6cd5Ax8X2wkNqcOYoBX1/7eukhPxuJz0dkmARCpEQum/QOwcCY5iV/GAYTOo2NeY7IMwcukbTDn9hKEVeT21wQOLrK+4hCSgmCVUIbZHmfpCeVp+cU/JUNAEVJC573QombO7Ia50eLZDIWUzy3dvE8paZ6RSp13kNsKtJk/FX3eL+lCUvCZDsWXeleZQgc5RlRbBCEOtTNzSbhMVdslNzp1KWSb8LM8k4Lmbw/AV+wdKpFcKofUFlEn6U17XmUteuoh8F2T1oxjFzpznEyfkd78lCbF1WhVZBkQ41RCdZoS5CQMib1kL32LpzQkLMKzzHbP4NWxnJF/2V64RoPRU5pQHFkX0+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:31:34.9965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f9536-59e3-4c2a-6680-08df3984df0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

amdgpu_cs_pass1() sets p->nchunks before allocating p->chunks, and the
allocation failure path skips resetting it. amdgpu_cs_parser_fini() then
frees the kdata of nchunks chunks from a NULL array. On navi48 with the
chunk array allocation failed through failslab:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:amdgpu_cs_parser_fini+0x35d/0x710 [amdgpu]
   amdgpu_cs_ioctl+0xcae/0x7a20 [amdgpu]
   drm_ioctl_kernel+0x180/0x320 [drm]

Set nchunks once the array exists.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2d0cfe723cdf..b4555d8d108d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -203,12 +203,13 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	if (IS_ERR(chunk_array))
 		return PTR_ERR(chunk_array);
 
-	p->nchunks = cs->in.num_chunks;
-	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, p->nchunks);
+	/* parser_fini() walks nchunks chunks, set it once they exist */
+	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, cs->in.num_chunks);
 	if (!p->chunks) {
 		ret = -ENOMEM;
 		goto free_chunk;
 	}
+	p->nchunks = cs->in.num_chunks;
 
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
-- 
2.50.1

