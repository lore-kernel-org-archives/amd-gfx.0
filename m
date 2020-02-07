Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB40C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7497120720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AgwKPugw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7497120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9066FD0F;
	Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2823F6FD11
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd9chAKx91Bz6Dc7FodiIEu7mtNCWG5tVcoMBcV5LiRqL0kmfCPjZSPemE5EyHoByI67WVAl/qhFHermBZXL3SJV7n2A3ZC37TzsSKSdzehzbm1JrXV/zaHS+P52vA9D0VompNlJ5TpGeq5sDyjLrS1JYP6fBNp4ygt0nro75PPE1y0JGTuCFFznhZ8ZK5T98Jr14zQ9WJVoFwYk1D5MjRywh46A4p7O6Jngwoq94RsgnAedI0G+GPc3gKvovqciGY6bbxEPwekSlqwRA9SYBD++OTJdGQ8qVOjkVMd5t6xlGrTQ+UHbXMPtiWwVSssnqQnhgcrU/8KqWdm0B60Uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hWws5yvM2mep57OZ7MyWd8aJNL4OP+Cl7v8JTiZrMM=;
 b=PgafPx1m/nBiN+2JXmemfJ7yPTlQXCMTZM0lYaFAti7mVQQrQQpUBs3XNt9v3PHNekit2dRVtMoQvnFavim0+O7rD/YiZYhtCAahMYEOioi7aIMJXvFh6XR28SgQtHYgO4PlUeh4NjNJtC/ws3GorBnWagdxjVLfXzK6FYQOhciy6aW+LPWRPsjjnR2vTcL1Vh/OWE1nkkqjW2cvzl7i6ap50atYBpCyDIZ1Kg23XcVtFxQWI81q42UQK8yXw0m55KBzFdXaB8M8n8dvZVw+amRjXGUz/Hpefcf1VTq23+ufkJvrMV1TBpuv0RVqKQ5KBfG+X0GR78PRqW/c1JGKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hWws5yvM2mep57OZ7MyWd8aJNL4OP+Cl7v8JTiZrMM=;
 b=AgwKPugw4c8RmNZHJuk1aesSJcQSCSu23uSxRKePY7VJWGu3BQ7+p00PUVSjawEwtJ0HncmmFge6t56PDd/FGLeN+RznaP4i6AD0xcdhXhNBEpM3WjLDudhfG4rfwv1IC4fEPQxXyoSniCfZMrIW1fDBvqhudM58VOcp3ecHNzM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:51 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/17] drm/amd/display: Add psr get_state call
Date: Fri,  7 Feb 2020 10:50:08 -0500
Message-Id: <20200207155010.1070737-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4722c416-a409-4d4d-7c06-08d7abe58197
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440BB5D2FAD3BC7A5CA2548981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McXd710QRkGOc+0a2rQJz6ph3cbdpRnv7v8kuWykNoFYatwbwcX7KI2kmPHA82BWBCXAlwOvPJgsnEcGzdR0nbREGIDpc/kYIj1i3K9vjL0Hqr4KMRVelX7nE6Z8c6RnCkQilVTPIxX9cDx/SKpyei88G0+qEZfgA2l6Qpg5g5sEG+aw6zsFzX+OWvnSgMgHAzCcWBUgvEj6jzm9+LirPT89UTE4pLbhkd8hdZ4oMLB7F12XzFl9VGJaQqsCPVzZ+j+NFQ45v9AocwFdE4rhymqm8w150VsCnziMYjsFPLObaKOWx5KDiD7Tohpc1GGs19I41L6YzpyGaUp+r+ZMy5UysZc+g6X8JHY3rBzOHVfy/2Sae8Kfe0erjD5s9EfkA7MwjD+nNqezsjyU7M6I8UgDnmOEtfHpjWmUzFmwDQjEtjWXVQ6GXbLSzMlH9WDy
X-MS-Exchange-AntiSpam-MessageData: /RUVGdPoykAxuS4wgPuen8M2976IGBxr2w3mdhWu2NOc5MDVDcnA2P5/06uDs4AaDLO7h15N8vjYBw/pf+MsKLiut5GPi2Z48MzWakbpudK9WAN9uKNaTrkXU8c+gzgMKPNThN6sb5WENAdlx5PK4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4722c416-a409-4d4d-7c06-08d7abe58197
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:50.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/C4Prw9tqq4Vkb8DsovSErIyk3CNj1FFKdpOGJ2iBGYH6mS49i9ZiUk2QyC1zZEet3bFA1yR2DiaJDWsg7Nsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Driver needs to know PSR state.

[How]
Use GPINT to call to firmware and get psr state.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 13 ++++++++-----
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 66d8d56f6abd..24d99849be5e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2451,7 +2451,7 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 	struct dmub_psr *psr = dc->res_pool->psr;
 
 	if (psr != NULL && link->psr_feature_enabled)
-		psr->funcs->psr_get_state(psr_state);
+		psr->funcs->psr_get_state(psr, psr_state);
 	else if (dmcu != NULL && link->psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, psr_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index cacb46979f31..22cd68f7dca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -29,17 +29,20 @@
 #include "../../dmub/inc/dmub_srv.h"
 #include "dmub_fw_state.h"
 #include "core_types.h"
-#include "ipp.h"
 
 #define MAX_PIPES 6
 
 /**
  * Get PSR state from firmware.
  */
-static void dmub_psr_get_state(uint32_t *psr_state)
+static void dmub_psr_get_state(struct dmub_psr *dmub, uint32_t *psr_state)
 {
-	// Not yet implemented
-	// Trigger GPINT interrupt from firmware
+	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+
+	// Send gpint command and wait for ack
+	dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
+
+	dmub_srv_get_gpint_response(srv, psr_state);
 }
 
 /**
@@ -100,7 +103,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 	uint32_t psr_state = 0;
 	struct dc_context *dc = dmub->ctx;
 
-	dmub_psr_get_state(&psr_state);
+	dmub_psr_get_state(dmub, &psr_state);
 
 	if (psr_state == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 5e8553d450c9..3de7b9439f42 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -36,7 +36,7 @@ struct dmub_psr {
 struct dmub_psr_funcs {
 	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
 	void (*psr_enable)(struct dmub_psr *dmub, bool enable);
-	void (*psr_get_state)(uint32_t *psr_state);
+	void (*psr_get_state)(struct dmub_psr *dmub, uint32_t *psr_state);
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
 };
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
