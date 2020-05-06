Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4CEC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1E9206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zArT0dOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1E9206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11DA6E287;
	Wed,  6 May 2020 06:39:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9E56E287
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRpipm5ibGggvF2zYdZeFTlkZA5rmcF8a6b4wty/90AQa6chM0GVoQyYdU7OoJqphpxc188giBlaMgAGDBnZcPHL+VA478Wudmy7pEVfKCp1NV3pw77N21gIXQWEKAUxfFE0j8GN16543Exion7tjq+675jM/kIazQjcK5H2iPY0PU/8n9Ygw0n+D8L8vRuhO7tQAXH2oJ2pVO4aE0dX78ggZJrXsk93bIYbTeheFxVOQI3kKbgSzkq6FPxhDoKrIDTDZzXhoLynfMyyX2ATjAd4K7olVm7zdSKXohU6+M/9QCW6dQTmsG7Eq8HP47qdcIGNe1Ypp1WuVoYFLd/g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wKW1EUkWa876fM4FM9tmwVOr8hPvJqnqyXtER7cDbE=;
 b=U7dkJUIVvW3TnwsfdGuNQzrDl6wfHLCukiS9M7wmTG5TfagtWlz5Tu5L5UoVTHdTTL2HsLlZRM+H9esRghXfPY7dC/2XlXp7UpwGls/6IKHJUcvigE3T7eijYgE4eO/xObYJBFcs/gLp8iCa6BLw3CRp7su1CbuW8cv01cKN6tPsRbZi+f7qNcmbcUL+EZb2t+i2y418idIIJELx1I2M7ReqJJgN/iB/R3qtcfgIbAg4pS4QzsgpQ1jcloIn0XdceqDJUi4GGuTwQuaxCDFhbVBvHkUBvGppaqEzFt0Kh3JOFiXEIKF7AUw/zBRFPoikVuHIyINs/5x3idfYBH9Zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wKW1EUkWa876fM4FM9tmwVOr8hPvJqnqyXtER7cDbE=;
 b=zArT0dOTNgFo8DdOBWOKgdQJ3G+FJt5DNG3eEFPCcDzSfSQBRplIWP5M/0o5ybnGP+qf6F+e0iXLqeadJV2EmP9SxGugkbMjKFNa7j6smoHFBziFwP552vjKVvR5OMeSasx+6F/B84C2lfqTeXGoE3aw/yrCKnB/s4EPhTuXN14=
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 06:39:46 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::87) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Wed, 6 May 2020 06:39:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 06:39:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:45 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 01:39:42 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Dennis Li <Dennis.Li@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: switch to common rlc_autoload helper
Date: Wed, 6 May 2020 14:39:23 +0800
Message-ID: <20200506063923.22772-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506063923.22772-1-Hawking.Zhang@amd.com>
References: <20200506063923.22772-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(46966005)(33430700001)(26005)(2906002)(1076003)(316002)(36756003)(110136005)(186003)(478600001)(8676002)(8936002)(5660300002)(86362001)(7696005)(81166007)(336012)(6636002)(82310400002)(2616005)(70586007)(6666004)(356005)(70206006)(47076004)(82740400003)(4326008)(426003)(33440700001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9742b2-74ad-4952-920c-08d7f1884446
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579B89189708824E2FE4282FCA40@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gozw9el8L+J+jTWBIlMzWydOUjon9plQcbNUt2rqGxYLBJnzRFez2tJGh8S3XlDugLr8c47pjxn4SnLX/qzQFiYbE770QvV37FQdH4pnjClws1BR6AtRz7N5ZFQvynKoB3gV1iwwSRbcKc/DtCbykyEnuiRUQqrLaK1UFp22ahZZhGdgEzPWCGFf7BU4z5zHuQpHXaRUFNLjWR2Tcvtg65zugwRsB/Bbz1Iw5TdOZwiEl/89j8SAdWR1L++iSBhN1oR1kA7eMvg+XkRKT1UyHqbUcFFKUS8RTy5LWDSQxdMB0zLjzFGgk5dSWf55kdv2ZLrs8nrEZCHs60k2fDkcCqfc11FhTLZUwQJ8zcjOsQftc39U27hjSEPljhDjkazPxmKKP1nLkOOmCHeeoAsMHzrGba/4jCkWIR/r/n0Y3kad0T9mLpjnavGyU8WQtiV6P8j3ahqsprTt6w6oVCigjzXguxnMt7Vy+z750awRLYHlaCjKGSwxux2qzZSgXl2p3ZEG1cqdBEDCFLnH/BKa5UDM/0Zv+pfHrvx+3aEo5hgwDSc0/JTbsykJ7HpNFQveE3sKDFrBjh+KIDlKnDDLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:39:45.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9742b2-74ad-4952-920c-08d7f1884446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drop IP specific psp functon for rlc autoload since
the autoload_supported was introduced to mark ASICs
that support rlc_autoload

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 3 ---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 6 ------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 19f09b4..5146542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1646,7 +1646,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 		/* Start rlc autoload after psp recieved all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
 		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_G)) {
-			ret = psp_rlc_autoload(psp);
+			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
 				DRM_ERROR("Failed to start rlc autoload\n");
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46bd85f..2a56ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,7 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*rlc_autoload_start)(struct psp_context *psp);
 	int (*mem_training_init)(struct psp_context *psp);
 	void (*mem_training_fini)(struct psp_context *psp);
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
@@ -307,8 +306,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)
 #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false)
-#define psp_rlc_autoload(psp) \
-		((psp)->funcs->rlc_autoload_start ? (psp)->funcs->rlc_autoload_start((psp)) : 0)
 #define psp_mem_training_init(psp) \
 	((psp)->funcs->mem_training_init ? (psp)->funcs->mem_training_init((psp)) : 0)
 #define psp_mem_training_fini(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index cfbf30a..1de89cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -524,11 +524,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_v11_0_rlc_autoload_start(struct psp_context *psp)
-{
-	return psp_rlc_autoload_start(psp);
-}
-
 static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 {
 	int ret;
@@ -825,7 +820,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
 	.mem_training_init = psp_v11_0_memory_training_init,
 	.mem_training_fini = psp_v11_0_memory_training_fini,
 	.mem_training = psp_v11_0_memory_training,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
