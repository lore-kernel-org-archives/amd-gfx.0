Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ECC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136C9206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRSZjpXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136C9206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71BA89DB4;
	Wed,  6 May 2020 06:39:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700071.outbound.protection.outlook.com [40.107.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1449389DB4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXYhB7szNa0hpZ8U7qczzbKCmhrIeDPGjb52w19bUd4/TsIqBYFOU+HOm8DX7wbPkibv8B61HoIFq7toXQs3PrxWotJkjnHmBl0xZri83UtRjruu2oIi39r+1zvk4xImymWDJ7ywHtZmYLAmR51RfRb9Fait2n4Nr5UNuQ4L8LmOrnmr3cjz8HIAfuQYTpFxsEavLSctY/MliTTiV2UzrKS37m3vjNw1PwRVn9Uq8vZ8EHvwmhMFoDadycJabgrvT2LwiKhXgNi1n8bfgSlErridP2HepP3iB8kLrTgADlEc5luviJQQH9KdrEwn4EWyFeNI2EIwHD4gl/QgJsl/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF1kUs30XkFjnrEeKVGySmMKGgPI5GNqCPMSLdxPY+k=;
 b=X7+BXdCwsdScf/zMerAVK/ujt+IauLXpkeEgyP1uANt1GnwBkqu0K8PnEQ0PIevcPzTFHzpCj5/vS0b3oacAR7iZfuhYYwXocazou4SoBM3Jp30xaeSOF6UgfP1fUghZBFeBoCqatuM6bnNKRHzUdUoN1Cse2nO9CllIaujKq9yzbUe48pJY4xg4egq9G5Gby070qeqOHoyYUY06lHAEPMJL1nin0mPcq34IJByxFGmqTyjv32DDh+VI/LSizAe772V33enOmGIjiuLYTjS5yq47+uAfMeuT7hMx5V0ZAr7gmUsllanhNXnuJo/OfY+KmXKUSTvdvDDIXnjtNZ2JvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF1kUs30XkFjnrEeKVGySmMKGgPI5GNqCPMSLdxPY+k=;
 b=gRSZjpXu8UYR6PYwW/ON2QhT7TYzkq0qvXYJA9mU2lW2TSWoMNLjH1IfdHYvs9jT1yPL31cnV6a2OQ7EJKpd3NRr4m/wWMe3062hJa2w7FcLWJ+PilaGoMgW1PwZZkVrnqQobq9vvoD+yza3QeV3Xbt1X6E0lmIVcKFGsO89gS4=
Received: from DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) by
 MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Wed, 6 May 2020 06:39:38 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::ec) by DM5PR20CA0008.outlook.office365.com
 (2603:10b6:3:93::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Wed, 6 May 2020 06:39:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 06:39:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:36 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:36 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 01:39:34 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Dennis Li <Dennis.Li@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: switch to common ras ta helper
Date: Wed, 6 May 2020 14:39:21 +0800
Message-ID: <20200506063923.22772-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506063923.22772-1-Hawking.Zhang@amd.com>
References: <20200506063923.22772-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(33430700001)(2616005)(426003)(47076004)(86362001)(26005)(186003)(36756003)(6666004)(336012)(6636002)(478600001)(70206006)(7696005)(4326008)(356005)(81166007)(70586007)(110136005)(82740400003)(5660300002)(8676002)(2906002)(1076003)(8936002)(316002)(82310400002)(33440700001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0efcd15-3f05-41cc-eeb5-08d7f1883f44
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663C233C9468E7A4269DCBFFCA40@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwnQ/crIb0AEv6/jUJcTTiOF5jki9b08kDu6kdeUEUjofesRbyoPjJ+tCKUjxYC8adQFu6e/dvMEqB5mD08Z1KXQLIQYic9Uzb+7SDh1ITb/CnOYL/z0LY9ebMkLKJB2Y3IKjT5rDdAL+sPJq2EmzRsOScCMVVM8W1mgYFr6htT7UBpC00kArrUhWkR+MTcnH/LB0/uLuPaRae4/QMzcNZl5H6tTgyQqVFTygrzAU2St8i71L3C4QO4u3F8MUlkIanu7rxhqHeQWLD3u8CRXTfO9HpWBgMb13Mwn0SvpdM3u9kMY9wYqm+8CRfhCkoCY6NzN9bUh0n9jKCD/JwnkaZ/TouX7kkzE7oa6c/bCUS1+1f0AwCnrwzgv7oElQDxLe2tVzST3MrcwJmzF0yNRAHZIS+yTLgNTb3eG0+hwwx5AcfFLxlIzgUm/NIN7U2hlf+mA1MGlytnP/rsRQtNQFvcUICvj04KJ9A7iJh54P/nb9LUmEjQbhXAdvCV7RYjh9rl9M8hfkzJ6xvmJ0stONTLdwGKG9wgMk+CFQyLmFl3Za8rqLGvXseCzAR9gkq8cEun9v8xfpZCnaEDdbsbl7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:39:37.4713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0efcd15-3f05-41cc-eeb5-08d7f1883f44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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

TRIGGER_ERROR is common ras ta command for all the
ASICs that support RAS feature. switch to common helper
to avoid duplicate implementation per IP generation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 28 ----------------------------
 3 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bb5b510..19f09b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -978,6 +978,33 @@ static int psp_ras_initialize(struct psp_context *psp)
 
 	return 0;
 }
+
+int psp_ras_trigger_error(struct psp_context *psp,
+			  struct ta_ras_trigger_error_input *info)
+{
+	struct ta_ras_shared_memory *ras_cmd;
+	int ret;
+
+	if (!psp->ras.ras_initialized)
+		return -EINVAL;
+
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras.ras_shared_buf;
+	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+	ras_cmd->cmd_id = TA_RAS_COMMAND__TRIGGER_ERROR;
+	ras_cmd->ras_in_message.trigger_error = *info;
+
+	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
+	if (ret)
+		return -EINVAL;
+
+	/* If err_event_athub occurs error inject was successful, however
+	   return status from TA is no long reliable */
+	if (amdgpu_ras_intr_triggered())
+		return 0;
+
+	return ras_cmd->ras_status;
+}
 // ras end
 
 // HDCP start
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 263bd8e..14802b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,8 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*ras_trigger_error)(struct psp_context *psp,
-			struct ta_ras_trigger_error_input *info);
 	int (*ras_cure_posion)(struct psp_context *psp, uint64_t *mode_ptr);
 	int (*rlc_autoload_start)(struct psp_context *psp);
 	int (*mem_training_init)(struct psp_context *psp);
@@ -319,9 +317,6 @@ struct amdgpu_psp_funcs {
 #define psp_mem_training(psp, ops) \
 	((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
 
-#define psp_ras_trigger_error(psp, info) \
-	((psp)->funcs->ras_trigger_error ? \
-	(psp)->funcs->ras_trigger_error((psp), (info)) : -EINVAL)
 #define psp_ras_cure_posion(psp, addr) \
 	((psp)->funcs->ras_cure_posion ? \
 	(psp)->funcs->ras_cure_posion(psp, (addr)) : -EINVAL)
@@ -365,6 +360,9 @@ int psp_xgmi_set_topology_info(struct psp_context *psp,
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
+int psp_ras_trigger_error(struct psp_context *psp,
+			  struct ta_ras_trigger_error_input *info);
+
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 4f6c0df..9e4f582 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -524,33 +524,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_v11_0_ras_trigger_error(struct psp_context *psp,
-		struct ta_ras_trigger_error_input *info)
-{
-	struct ta_ras_shared_memory *ras_cmd;
-	int ret;
-
-	if (!psp->ras.ras_initialized)
-		return -EINVAL;
-
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras.ras_shared_buf;
-	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-	ras_cmd->cmd_id = TA_RAS_COMMAND__TRIGGER_ERROR;
-	ras_cmd->ras_in_message.trigger_error = *info;
-
-	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
-	if (ret)
-		return -EINVAL;
-
-	/* If err_event_athub occurs error inject was successful, however
-	   return status from TA is no long reliable */
-	if (amdgpu_ras_intr_triggered())
-		return 0;
-
-	return ras_cmd->ras_status;
-}
-
 static int psp_v11_0_ras_cure_posion(struct psp_context *psp, uint64_t *mode_ptr)
 {
 #if 0
@@ -878,7 +851,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.ras_trigger_error = psp_v11_0_ras_trigger_error,
 	.ras_cure_posion = psp_v11_0_ras_cure_posion,
 	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
 	.mem_training_init = psp_v11_0_memory_training_init,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
