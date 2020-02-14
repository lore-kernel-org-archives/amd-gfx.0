Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18582C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3572082F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qYiz0+hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3572082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A176EB81;
	Fri, 14 Feb 2020 14:07:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED7E06E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS0HkjMU2isvXSLK5xwjYDJLdYCT4QwSSzr4eZsL6OZsvgXSLwhAiysy7KqPvc7XzjVjj9TuKKebHxUR5eDinSFEE1OMjoRJddzL1LPu/spZGvk4QQn8SispvXa00uKl9AGVuhWiSMxLS/eItbtrsm9xoaPYfoWmmctf70ViP1UgTc3qbecxQiuZlmEGdWykmOmW+JzVB5YS9DSCkmWRPQdlWG/tM+Y2j7SRsVx+KdBRonj9C8kobeXE6t5W/dTpvdUFhnEiCcrc5hQlEBKSnEeycgCT4EmQF5eIOiAjxtyTJCg4lzr4EJiQ/FuUDdxSwl6f+fbwXzVQDUdTGbiiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H907+lWqM/MOyqFMlNItVMLvq4UvVYgBDV83SUs2/I=;
 b=kQp4o2RdS8NlrxBmivmuLGaX9ZoFooGEJev6h8pmSVJiLnDTPnu7jLjLuHC6yxoraJbMhO7hyoxq1Q4oy32v74NrpELdIn37E2QsMkGn4bbsq9VFMUZQY+9TzEoR+6cb/oBeHFHxg7ANtp4u+cNZG9sPZB4YcZtiwauRCTiwRLZ+eB3nbpSYDmANO/5PNvbwgpf6c3xqLNcmP15f1E7YqUa07rPk/KKs026ROoZgu+l5ftCrkRC9lVAtuRixV4Q8nFNeK5w8CPgYUn7Kq7f1gAWtGFxpo6t1mElG/3QXJu4TT/jVSP//e58p2KdTL1Bx9qrVhtoxo+N/sTitikpn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H907+lWqM/MOyqFMlNItVMLvq4UvVYgBDV83SUs2/I=;
 b=qYiz0+hXnI1n+EeEhEFpEOE4AwD4lOn1xf2U7K8uuDfcXVwSBlaLV/SI7a2848QJpdrxW2upEKon0KWKG+QhVyrwrcOb7nOPFLxR7bN6Mv9DQSHOnnzlfZcCJ37f/4WwTC619Cvx/Z337azWpUTEWHF2vmlaJ0zcJlO+EtahHHY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3110.namprd12.prod.outlook.com (20.178.53.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 14 Feb 2020 14:07:08 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 14:07:08 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 1/2] drm/amdgpu: log on non-zero error conter per IP before
 GPU reset
Date: Fri, 14 Feb 2020 22:06:49 +0800
Message-Id: <20200214140650.2133-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0196.apcprd02.prod.outlook.com (2603:1096:201:21::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Fri, 14 Feb 2020 14:07:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e67500c-2c05-4764-5d49-08d7b1572dcf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3110:|BYAPR12MB3110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3110E4A2D6DA33BCB1C80309F1150@BYAPR12MB3110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(52116002)(66476007)(66556008)(66946007)(478600001)(7696005)(5660300002)(6636002)(6666004)(1076003)(316002)(81156014)(4326008)(2906002)(2616005)(36756003)(86362001)(8676002)(44832011)(8936002)(81166006)(6486002)(186003)(26005)(16526019)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3110;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6TnKIpfw8CdyZls8aE62ZQhH3SUiHysvo5JyzpsK3xKLtHZPzcaaG8Bg1aXNdWBbkwGCYC41Dc/8FSuyvHllRUM4fxAP2TEYZ2FuHUVo3134uZcY32ALLfjGRIOoPWRHXnW1oN8lHMeWsPuGOFun3C+RhajpNKnRz/tTcc3gQzI1NS5BsiZ3MOih6in/DNNAyysk2nez4C7rhfxO/7nU8ACt/fteqto3SUQP6krK8gebnMbZkW6dr/kycOrNcBEBe/gjVEIY3FzVqp1arjURUITTT4UG90TGjIwXzV+1zRqtQ1NI3nE4s4Z6aysHnG+CdcN9RMmh864Rmx2Rrlm02L/ljm4PkyvLVYeV0drNDYzuPT1C6vSCno9vg7DTIN8EFJ0KNrqedWPHF8PnlaXGm4dqHwGU8v/gaHRPGMHnId9fvj/SzmjvSMNko1TDutN
X-MS-Exchange-AntiSpam-MessageData: dxDo+o72q3uU5xqpqXgwJw3txoYLGD2QouaJgu2s/0Jn/i8zhoQNmdK5Ad1gdaXYEnWdXSNyba0H9I6wnxImkzhi5dGPxgCQY++AXvb81FpCofNH9iiwwEJJxeTv7ijeC4zrjq7+k+0KvJDdddPgKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e67500c-2c05-4764-5d49-08d7b1572dcf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:07:08.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVpr8lDIQ+17315EjGNSfXKwbaa1ZcTDAVANSDuziqNjXIc4cif2uGTmvP5AcoKTcncYpxIycVqU2CYqZjz8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3110
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

Once sync flood interrupt is triggered by RAS error, before
actual GPU recovery job, it's necessary to log on and print
non-zero error counter, this will help user knows where the
RAS error source is from quickly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index cef94e2169fe..6a9a45d6b9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1319,6 +1319,33 @@ static int amdgpu_ras_interrupt_remove_all(struct amdgpu_device *adev)
 }
 /* ih end */
 
+/* traversal all IPs except NBIO to query error counter */
+static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *obj;
+
+	if (!con)
+		return;
+
+	list_for_each_entry(obj, &con->head, node) {
+		struct ras_query_if info = {
+			.head = obj->head,
+		};
+
+		/*
+		 * PCIE_BIF IP has one different isr by ras controller
+		 * interrupt, the specific ras counter query will be
+		 * done in that isr. So skip such block from common
+		 * sync flood interrupt isr calling.
+		 */
+		if (info.head.block == AMDGPU_RAS_BLOCK__PCIE_BIF)
+			continue;
+
+		amdgpu_ras_error_query(adev, &info);
+	}
+}
+
 /* recovery begin */
 
 /* return 0 on success.
@@ -1373,6 +1400,12 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_ras *ras =
 		container_of(work, struct amdgpu_ras, recovery_work);
 
+	/*
+	 * Query and print non zero error counter per IP block for
+	 * awareness before recovering GPU.
+	 */
+	amdgpu_ras_log_on_err_counter(ras->adev);
+
 	if (amdgpu_device_should_recover_gpu(ras->adev))
 		amdgpu_device_gpu_recover(ras->adev, 0);
 	atomic_set(&ras->in_recovery, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
