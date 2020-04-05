Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6006BC2BABC
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB4220644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EckPM4Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB4220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DA26E22E;
	Sun,  5 Apr 2020 20:41:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12E46E297
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJxBOTNOtn6TJP3rQqtslf6us7esiFEIjzCV8+XUM1KPzhoNDqhGf2tqWCKFQAosIy2syRTftpRiWEA6JBh+RdcsERv+cZtWr2BwPz4kTuYIwEyYlC3ZhTlodtOC3qS5A2WdZpkcNJaL69LVCFKqhFZIzs5YFgTF0/TjPtNmtPbCEkSdHc6CNKzaFcI0tCog4VdXtl0z16HEJx61XxgMc5oI05w0vW5rTpMkhHBkIf30RkDJa4x3YjOOVfwf4w1QGQTqioyIXrDQkLMPqjJgH/77q7EIEsagU8f7lZGtBQl1pE2r0FQr7VD4RSlO8O2yA/3GvkFIY0kCf/jSGLbSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOVrna4sU2FerkAIhyfEYDIEfx6C1SodNkZdhTJO98o=;
 b=ngxEbB4HR+2vM75oAOjGKAPsM+YLmGWVSDJ3exiX5v4A/z7SfgVMS0+Hl8nC/PyqTqomi/ez0qp9k8j4CcGxtDnG1+81W2OvbM6cx3whwhSSmwGo19W5nn7Hfs3MLmFZvnlJBkXyiWHXmUXvEbtmE03cKYRYQxKYCpk4dbb8ACrGqqE2WHVQ1nwSzFSwTDzWs413S70FP++CyCOO3a5/jKQtOV0lHqzsfmudo7S+baCtxSmby22PyQ7CE5ECM2CVoKUcS0/J+aRKnQT5dWJZCrWIV1gkuSV7IJ+OoZtYwJcG9p6LAkm8ToTat8/acXjEs/QE38zfnY7ruTfzXx/2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOVrna4sU2FerkAIhyfEYDIEfx6C1SodNkZdhTJO98o=;
 b=EckPM4JswYQL9z2FoFUfw8BVwdbSz8jQ4xjj5bObbh8JIuA5u3dDzNhsI67a31a7DjXiHCGsymZR/B/s5jLQtPYkQ14+s+7aKQlZvHAuzfwoisR+WjO1Na8mZdifJQc4cl0CoLTz/B+oHpiCfuv/CkiB1UgOIB4xV0sz4bDtE/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/36] drm/amd/display: Fix ABM config copy for dmcub
Date: Sun,  5 Apr 2020 16:40:52 -0400
Message-Id: <20200405204115.683559-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:51 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b040786-ee17-4c83-516c-08d7d9a1c528
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555533C9B78E3C450C6224898C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T9vAjXlEXhedjjRlJ+2ZLaHn051nrmDJDe5qE+6D7jnMPvtVzCjvvpm0sKST5tCmmKQEWdRgkbK0dJWK1aEBq3k8YTojwqq1NLvMM9ZHj6wo7IqlBX/buO/YvGhLGdb1dnNhSRPUMjapjbSqs9F06gJIKeMTyCMn1Bwl/ad2SRvY+/X5LYFzcUhNZjqUFIlYujlQxa+d/XrRfK3G4XluVR8CvVAx3IJo9Y0NhxxA7jdd6dCW4hQ48uGeZp/FEFXuhG6IA8Io+3rYwVfOUj+mF8hgph6Z/9cOCIGHJsMAAu6O2SGyx3dTuLKVP1q/LktC3N6HhsA9rUXZOe2EN353dfxhJy1C04nYaAZ3fOAdxlhlpXuMpwzMCv6JkqsA9jOdpVNWBgmumc8ajOQmrvK3ptwG4RxzSPeGQGCHNmn81a4lzkTdl5oaa1H8U1igtHW
X-MS-Exchange-AntiSpam-MessageData: ZrIENNLL8L28NGVh6Obc8sUwZ3vtNXeMQfszSzwFWcw/W5vMVLUDkEaoQqb7o/7fYCwuodhdA8/isKEJ+tO8PSerkxqiP1U0fdwBVKAQD2iOlhDtdx72s1HadM1AzFuNGwmJ8ati75CZZ/yndxVIXLeDtIU2irLQPaFCp4HLcMc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b040786-ee17-4c83-516c-08d7d9a1c528
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:51.8899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubub+fkAxE0jX2nYba9Q1KJ6S7Ih+mKCYFOp5OWgnQ3EkXpDH+Ua/U1TkOC5njZ1L3SPJmYPOvy9MEnriCSjjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

Decouple dmcub config copy from dmcu iram copy.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 30 ++++++++++++-------
 .../amd/display/modules/power/power_helpers.h |  3 ++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index c1a95da6706f..dd1517684c90 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -651,14 +651,31 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 			params, ram_table);
 }
 
+bool dmub_init_abm_config(struct abm *abm,
+	struct dmcu_iram_parameters params)
+{
+	unsigned char ram_table[IRAM_SIZE];
+	bool result = false;
+
+	if (abm == NULL)
+		return false;
+
+	memset(&ram_table, 0, sizeof(ram_table));
+
+	fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+	result = abm->funcs->init_abm_config(
+		abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+
+	return result;
+}
+
 bool dmcu_load_iram(struct dmcu *dmcu,
 	struct dmcu_iram_parameters params)
 {
 	unsigned char ram_table[IRAM_SIZE];
 	bool result = false;
-	struct abm *abm = dmcu->ctx->dc->res_pool->abm;
 
-	if (dmcu == NULL && abm == NULL)
+	if (dmcu == NULL)
 		return false;
 
 	if (dmcu && !dmcu->funcs->is_dmcu_initialized(dmcu))
@@ -666,14 +683,7 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 
 	memset(&ram_table, 0, sizeof(ram_table));
 
-	// In the case where abm is implemented on dmcub,
-	// dmcu object will be null.
-	// ABM 2.4 and up are implemented on dmcub
-	if (dmcu == NULL) {
-		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
-		result = abm->funcs->init_abm_config(
-			abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
-	} else if (dmcu->dmcu_version.abm_version == 0x24) {
+	if (dmcu->dmcu_version.abm_version == 0x24) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
 			result = dmcu->funcs->load_iram(
 					dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index e54157026330..46fbca2e2cd1 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -26,6 +26,7 @@
 #define MODULES_POWER_POWER_HELPERS_H_
 
 #include "dc/inc/hw/dmcu.h"
+#include "dc/inc/hw/abm.h"
 
 
 enum abm_defines {
@@ -44,5 +45,7 @@ struct dmcu_iram_parameters {
 
 bool dmcu_load_iram(struct dmcu *dmcu,
 		struct dmcu_iram_parameters params);
+bool dmub_init_abm_config(struct abm *abm,
+		struct dmcu_iram_parameters params);
 
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
