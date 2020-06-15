Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B14C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 03:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8C220739
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 03:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CvHeSlY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8C220739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B3989C9A;
	Mon, 15 Jun 2020 03:37:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C0189C9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 03:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMETjlR6hdP0geNZxpXLrMGKYf0Xnqr95OvexOK0hhO3wW0JMf5takT2oZeTBDJSoXTIO8c7hxsz64ZJkyI9wMiyL8A8LDwaGELSg8SYCS7ghgeIUaYn+zmObF415lAF21DB/Ju09LVivPy0OY4rgmsoRt7t3KRvRPqFC50cRlsCwxBa1PbSgScdcDArmLyOUCoa/ZUSJXobneMLrNdIlfKWeUyhlM1gZ+fP0K4wmTljijgLUMhl1O1AF4rYinGLdbOLLs9c6i2+tlL+RoE6o7ODxAkSUG+/7HO3wCBsfuH4OwQUXekd4TRrBDcAqhqMFW1GbAtGFoKWB8UP9W7ouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA6xBpsvtQHLGUeKVDlZ/7tiaRDKDnsGkmHUyZUM8pQ=;
 b=XWVlORF4GMDprkG8hpZGasGs06lGNVm7i2AhtmhMsEL4AScpVbHBHUepzMFRB3zPlvw7CNcl9fH/YpoSFY8rJAMXCbLwK1NlzhQheLuTV0JmjyHMih9FLJyBaZdt3fSHcXYjsYD1GuzaM+PU8eDODSIWfccW3hYFgMwTA7qkrk6+GRAKi+4X0ALMElk13eqyUbDbOnEgkJgNwJjApkc/6Fkco/SAE/lSvDifEA/MzwMbxY1eIA86VaC/kIYcs9nTD3KrqS43exzqSvmkMHLMyUIUxj0EhnK61pvSvwQXgyae26zBerHv/tGmNQ31hOnPBmGhvGLfLZb97rrLjUxrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA6xBpsvtQHLGUeKVDlZ/7tiaRDKDnsGkmHUyZUM8pQ=;
 b=CvHeSlY46jgSScFi/a2drCWoDX/P9b6sfDeqhnpUdjBKhxBXwyK+N2Q9NadXPmqLiPv8ESP6k/3dD160R7Br1jTMbUxr2DlRjVbPTke+WN6CKKi7PGtqsC1DxrDgbAJCXBVnWNza7rD3PX5CYfBMaEZPYpZGQfYKBF4cFGMsjQY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1510.namprd12.prod.outlook.com (2603:10b6:910:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 03:37:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3088.028; Mon, 15 Jun
 2020 03:37:14 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Xinhui.Pan@amd.com, Dennis.Li@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: improve ras query as part of ctx query
Date: Mon, 15 Jun 2020 11:36:53 +0800
Message-Id: <20200615033653.22793-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:202:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 03:37:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 422c38d8-4f24-4225-f700-08d810dd652b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB151074E79A3977FA40977D16F19C0@CY4PR12MB1510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq5FqFYlTao1lcsinhYTSWZCCEItk/1dLRJ5p2YDfpRf38rd+J82i/fI3/LPgpgcORwN+MaSVWBYhzhwbd2unQGseGzKDUhtfzIvAW5xm3kqBTWdjeLqrrFF8nFxAhReUXQOnKOAFDy+UUTVIgILOiu96LUaaCQkNnX4HVn+8RtMJLr/4giuZsMmtVI338RYfOtC8uZ9EZhEZprwX38vy0dDpnEiVD8j311p1O71CYKXC+gKsWS3iBXFMqIzT2iQ73KOp2EbpQBEhslQYUaBHPQ6vGAcRXaaCdxOnOWJ1kN1jFgTKnhq5S50CjmAWKcgLwJNme13HvaYDtgYQkllcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(316002)(8936002)(8676002)(1076003)(6666004)(5660300002)(44832011)(4326008)(2616005)(956004)(478600001)(26005)(186003)(16526019)(36756003)(83380400001)(7696005)(52116002)(66946007)(66476007)(66556008)(86362001)(6486002)(6636002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6PKj42JscAO63RYeqwMprM9qmejI2cv24aY8buaCpRJmV6uZcS00Lo9FWUYsBBhKykTsff3IPTibczdVOM24/tqUEs1amFjACGWi4h6MfAa+JMcweKR5KeL6jzkKFnh782jm7nokeSskCMlHVTbXOAMmpP7JjsVh+7zmZw3OnTlLWal28T6PnEiU61mh5Yp0TcKCPym7E1yyd9FJ9OQVLrASfyuAt7CiVLZqmh5xiqeIo9Ib9UsXVgs0NWDn3DmbgOdtHy2hMCdcdw09ytUsdaxRKYp3opEfAgRB1hVE0bUjJJAd+4kzLNoHtnankPLiZx3RHva0C/Ua6PsnWTQBqTs/lUY2SzMnHAa1IBBFHtBPMGZzCR5e69XvZRL3xNq//Dw6zeYeMLdl4zE7de1WmDNjN45KKohlYUA5BRHjG/beqJJyY4mSOFTA9chL2vcN2NSfgcN3oM0K6pfqoVPCgKi4UfvFHestEtnBWUe/iKY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422c38d8-4f24-4225-f700-08d810dd652b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 03:37:14.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqO4NXNetN/2LkBQjRAW1zoeI8iGwbRMQfy0gExq0JIHUmgBzpRCJwTfRdZLCxEm2B70xNSeWq7NtKx8Izqn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
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
after reading once, so immediate successive ras query is
redudant. Merge both CE and UE count read in one calling
to fix this.

v2: correct commit message to avoid confusion.

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
