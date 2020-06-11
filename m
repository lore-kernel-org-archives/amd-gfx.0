Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995AC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 10:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B5B20760
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 10:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FHTptzJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B5B20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB9A6E8EC;
	Thu, 11 Jun 2020 10:24:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46FF6E8EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 10:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBRo5D26eXV+XZyd+C6QzecspsFTzSd+ZXrfQOcm/OUgyCEOJfcy+7dXSSYaJYVmVmUyNYzh+KBU/hMSx1ujpmuu9zE+x+VV/iM8VNI6T0jTjou2XctFr6vog5iF/Xjq1sD0eQ2mZSqBPwlxb/bocqF2DlMUECuSkcMRrkriyeSkdHyfv8FrY/SHv1BBjd6Od8quBp52zf7OqwZKSR0IcjI8Ko6sJ6Q0XTVP+V2zkZppiyAniLoq+E++larNiZxaXWm/BTOWy4hOVWV2CexdjbNYglZrbArR4LCNDSYGBaVsVM/y8f8ft3acVyxOTT9Qf/50ILYIiJWigqihEqt7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL3AXkMRAWr7s3wC7xe5W6HsQ1xqeZE/8eyk0XKyp+4=;
 b=A9TA+LTx8TlcobWAulQWmT14u5/aOGfmoAXEVG3lOYIW7MDZ05T8S7D6vppEpHDkLA4mbLXN/ynE2BSoDIdkpWoMnG3MLee3XjkCf7B5dy3fHoJSnR3BBrfgslf3no8mURyfoa9O4L2+J0etXcfhF5Edhx8KnhiX8OlIkL3U80GZvZloO+Q5jQ1utQPmJSoKaY5zwL1mlDWSckoslHqxLExEnhrkkl4hgGN0SE1S6DcdS9RqTH1EMFbHk8T/qcGnMwoeOaGIMaPsL2HiO4fPC1nVG7KhI7m4iGwJ0Fs0bdmhLFjbpUaFOlTyFeOQQbGCEczkV7W85jad+fckp0cU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL3AXkMRAWr7s3wC7xe5W6HsQ1xqeZE/8eyk0XKyp+4=;
 b=FHTptzJLrtVQsGb+aqpUFnTLiz1Jf3YCHep98lD1Wne5xs1bA79fkoRa46BAj6XaLdCaFZLf74rfjV4nqqiNCv32BZ8ZIdqa9jRaLbkidcMfudAj57HVyuP7isnRQtmft+7H6mk9DLuqJVnFim05qfxuE85YpTilRQ0El2WxzDM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 10:24:48 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3088.018; Thu, 11 Jun
 2020 10:24:47 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Xinhui.Pan@amd.com, Dennis.Li@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: correct ras query as part of ctx query
Date: Thu, 11 Jun 2020 18:24:23 +0800
Message-Id: <20200611102423.32346-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Thu, 11 Jun 2020 10:24:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 280a6758-9743-432e-c075-08d80df1aac8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB11587B6ED005FA664AA5424CF1800@CY4PR12MB1158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RrG4Oo9Whpl0QUbgpzMawyOxqFIbiPrQv1LXlSn/VLkUhLX7ouG9EZiRnMzNbTZAZ94p04ZbpTOV8AUbRfGhVoI7WSfav6VY5D3ZEWcCthrtXphVAVoFMPoi+4UvNqOR9ulpwA06mvF2ycP1ibaCmDB727wv9pqgAz5yxwyQZ38i/aZ3B+GlFOn4HNAwScomCR4/aNWGanobCICnhVqdqn4WKBOG109zhTVSHxC3snnr4b8jzH1dK37/PmC0HF2hsRxj/6GlgCB0VlgV3NDAtrO4dHRuXu4y8TmMyDw23RHCtH62+WpDMO9jv0uUs+pECzyXSOBh241exNiM1ME1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(7696005)(52116002)(186003)(316002)(4326008)(16526019)(6486002)(2906002)(6636002)(956004)(8676002)(2616005)(478600001)(8936002)(86362001)(26005)(5660300002)(66476007)(44832011)(66556008)(1076003)(83380400001)(6666004)(66946007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QSJ0OaD+yGL5sBailpiZFQSunqo0cPkrwsZ6rfZil7QF0Yl/0jGGe7Erx4W43cz3V1uMeNAsI6yLSiTo2B6sBdwd8Y8QonAX3bARRJ8M0srHlcg3tBD0zPqhlmdp8Ae2WMpf24lfoHE8RCBnGrguSQDGMg9rUHIFCmSui5+fr8SGx53zB8BS4tvBM7Kc3kQof1pIXneOJxzCaGnbi11iQ5BdIdJv3TXdsXTMRAyFk8TDvhnI2p4ON+aEkKLOJxGCYDRuY+QTg5pIgeDPWoSgmvl534ba6A/sdndZgBqqlKNlVUGH2b9K/+jxK/kTubuk7+s5rV5iXQiZldjTzeW+xzF2QtzaUB5nw5G05Aj1BwTJwe6u9nhEJVQmraCosgiCS4zCPUL/u+VFK84vnZvCU1ljJlY61NB9SvTKb4k+UE2lhAYsy1mJYxCoJB4tHf9E4McmyWoJ96M4yBAdwOc5mWfwHJGH4xzix/TjEP2VLwHErAuuEfhm6RYCMr+beIdC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a6758-9743-432e-c075-08d80df1aac8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:24:47.8766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEPMcUHhOF7wtAzIKAeGQcUBAJMtbwkiE7uOLaGYp/KAaTVlvY4s2FutSDA9eeWO7KKxe4zw/Tq7/IH7pXUlrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Almost error count registers are automatically cleared
after reading once, so both CE and UE count needs to be
read in one loop.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++--
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c06cb06398b1..29fa6b6b9d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -335,7 +335,7 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 {
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
-	unsigned long ras_counter;
+	unsigned long ras_counter_ue, ras_counter_ce;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -360,19 +360,17 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
-	/*query ue count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, false);
+	/*query both ue and ce count*/
+	amdgpu_ras_query_error_count(adev, &ras_counter_ue, &ras_counter_ce);
 	/*ras counter is monotonic increasing*/
-	if (ras_counter != ctx->ras_counter_ue) {
+	if (ras_counter_ue != ctx->ras_counter_ue) {
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
-		ctx->ras_counter_ue = ras_counter;
+		ctx->ras_counter_ue = ras_counter_ue;
 	}
 
-	/*query ce count*/
-	ras_counter = amdgpu_ras_query_error_count(adev, true);
-	if (ras_counter != ctx->ras_counter_ce) {
+	if (ras_counter_ce != ctx->ras_counter_ce) {
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
-		ctx->ras_counter_ce = ras_counter;
+		ctx->ras_counter_ce = ras_counter_ce;
 	}
 
 	mutex_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 337bf2da7bdc..109eff2869b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -861,15 +861,18 @@ int amdgpu_ras_error_cure(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+		unsigned long *ue_cnt, unsigned long *ce_cnt)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	struct ras_err_data data = {0, 0};
 
+	*ue_cnt = 0;
+	*ce_cnt = 0;
+
 	if (!con)
-		return 0;
+		return;
 
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
@@ -877,13 +880,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		};
 
 		if (amdgpu_ras_error_query(adev, &info))
-			return 0;
+			continue;
 
 		data.ce_count += info.ce_count;
 		data.ue_count += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	*ue_cnt = data.ue_count;
+	*ce_cnt = data.ce_count;
 }
 /* query/inject/cure end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e7df5d8429f8..733eab5bc512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -487,8 +487,8 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+		unsigned long *ue_cnt, unsigned long *ce_cnt);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
