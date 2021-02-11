Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFEAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C656186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C656186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52416EE67;
	Thu, 11 Feb 2021 21:45:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFBD6EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsc6iEjhOEimW2sB7wGRm3/nH3AGow6/Yo3Hu3PQyhUXAfEhU/wSYKlFIMSsFuJ9Q0I2YrUftyxzpGg1K+4KFcuriexa+ypB0aJ3s5YP5lm5+/txXb8pToQoPOQ2fsXBniYvnSDawseMbJnq4WsFZVfniATNCFixLqK3adEEAYR2DTiaHLzCdd8YAVOM5dEHkGx70ORikKMGCZ9kwzj7zXxZx/CDm8bYCiGepk92ksKMiMHmU0UiMmD3h/dN4sv5l5I2OfCC1LD/+UyJat/iXEA/ykOCcxLLer8tORbDoDkD+jQheU2QnF8SXnJkFUDZg4T/7tP48JUFtdopzRBWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIixiVQXpRaKujiQYK7+4ImZ7WEmN4Aj8A1ll4RdUag=;
 b=g9haWVULV7FQbJBAp4IM+9j/jcXUjlpVe9wu19ijT2LztLX3FG9oJYboTxU+fGQkSzwqo+2UEvxsCLWBI70t9a0ACWYBryOqp9nGaOQQyG2VPX9toGjCX8Xo+FRohWyI8uGy982OWgdJ+VIfbcLVxiQgedLKGiwC0xYvwxyoUgSxNw/0sIPK4IGJcrpt2Nec3KKNMncRBAY8rkoYyTC9fGHdBeB20ezQT9fk3o6q9Po7inHgeG4xKkqaeQ0WOVOuS94N3XLrj1wlIKP0HktSoiAbuFIzfOZGoyxsj7wQ0WMi0PgB0AUpZTlOxe9gW/80OKw0pRBSlQENEjCp7sHpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIixiVQXpRaKujiQYK7+4ImZ7WEmN4Aj8A1ll4RdUag=;
 b=lFeSmcYM9AB0s5hEcwPmB+ZW89bwnXEYt4whlXWNdIFuTQox6N2OC79e3dtsHuHzPvnH7LqfYAZZyWTwYhMBOy5Fizl2Z75hOMkMPvnT8va18nkvChPn+k6TuwZ7DxxMvsixzF9JZBZ00UPq1VqtkW6M8LbHaEuVxz/GVWeeLi0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:03 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:03 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amd/display: Add dc_dmub_srv helpers for in/out
 DMCUB commands
Date: Thu, 11 Feb 2021 16:44:36 -0500
Message-Id: <20210211214444.8348-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09c3f1e8-e787-404c-bd29-08d8ced649f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42356126F583BD3924FE236EFB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjEqyXVl5kc4BpPgnPaCPtZuC4u+gU2pyUtJJfOBT/iNZKzBhonnd5k/XOa0e19FI5F+hzzO4PSQNiUoJGYCovMQ+SbUyFYK11xYGPCTSTD3Zh+SLskkRtVEyiPffaAYEExIG1EJxBxiQadegZexnMYQE39AKoGiUHh0yAdDbOQ/xsOjNtJZF/0pdsQM2PRQ+CCuBFMEE0ERJGKhnaKwqvQqBxpERSMQCe3FQOEtOzNTnfXMfDe3+YTNKJfGIygf8oP6QDY1u2UQD8EVNzT3fvGMhtULN2HRk8tPa+iJHvaoHRpUqvRPYF9iFDUe7ScnnZr8sYYID7fo3UfSBrjWqS/hkMoCQ2IzE9S1Xy4o9y6EyY14UjzdNYN7gUsVrUmzZJV7mnhwGclIYZbaLtzNpHA4bStnyAND/Lc5tJVU+d+xXC0wsapx3Np2VnT1fRFsjZeacxgBupipVeepmFcidRGGJUi8Ms3+AzdtqErirHu5rffrNhnPtpZjdCFblrECWIIzvNc6n/ESCQK6kGB3x0pvOUMiF0o2SQg0rFh2N4LXNSvd7m4wCjDcbyotFRKgE55OCjlWZXaFHxB1TnL+8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x91RbKBLLYhaD3TZ148SbA2JWAcp31OLkCBf/IRcAGSNyj6FIRuOwrWffUUQ?=
 =?us-ascii?Q?2ZeFQoZJjK8Um5uy1lxl9yMI+0crbMaL1Jx206TF7o3iMCKF76Q1WrTuvvRj?=
 =?us-ascii?Q?luN0H/Kspu3xrjevcD3zrII9eGofEqYkgHYJ3eHx7TU76wmQkI343Jq8b0L0?=
 =?us-ascii?Q?FvCbGhZxUNprOdJhAWTzGsI4/Cpoih9LJzjZ7+HIbcE8HCOcs25SGyKc4xDB?=
 =?us-ascii?Q?w8tubg6objzMKWTg9/iT2MYt1Nu2+E75gRzWZ5dDz68EKWG7Fcd8WZxvp8Tx?=
 =?us-ascii?Q?WlcJ+JZnlpC9kqE/GU/ZNp9bK0ZjIfzC8IvKlYcxgFG/yeEGgAtcyYpCep6q?=
 =?us-ascii?Q?yGikblE28iagI1uzJfWgsvwvBodwF3NjfMMyVwYDZPJIgzHC5RW3XhbH8tYB?=
 =?us-ascii?Q?wLie3SwUhpJfRb0uxrLFkKWezeEp5+tYyT8WRGbqOwaTfCPTfLmnFDUC8d8D?=
 =?us-ascii?Q?WQkUZbZkNK5YcseeYALSJQSsbOGwD6dJi41EQdeyfuFV0Wpi7sFumd0jzipa?=
 =?us-ascii?Q?ukyvSH2iBdbQ6rUeCpiMH02DxO+DegIfhqPMLAEATlQHSGI+1TdMC6QLeOia?=
 =?us-ascii?Q?+WVSjscB/ZWrK3da2wkNuQAY+epM48ZjMG+6et18pAPBjLqbKehuTbjz7cNm?=
 =?us-ascii?Q?sPQddYe3NtnrABIA98jTYUuz77ngOmzFfflKCOhCL6Cju3ofbUIVdloZyb19?=
 =?us-ascii?Q?faFLRoAFDgDwZkAJA7a7ybzSaCzYDyGsEynV9j2BXtN8VwBFDRnYP75sZjVR?=
 =?us-ascii?Q?ef6pr2UgxcxqOtGYCM8tyXNdAYV4fb+RvCrZrXWOmA321BdQna8FWf6QeefC?=
 =?us-ascii?Q?gawQRYoDykFtG/sUa6PXs6mRdLGXWktXlINffMr5mK6xXJBIjihMphOf4ZjW?=
 =?us-ascii?Q?WBmnFOLr6zevZq/JZazAPaqXo6QYqMARnPPySdVFxmTf59IGm6Cg8stT2Dbu?=
 =?us-ascii?Q?aeNjNxdsfGfp+YOVsvQ3RanC3cSpBBgLyDzt4L98RYYPy3oZEUlyY7n11Ays?=
 =?us-ascii?Q?oJdYviw3QqQeKC8m3ALfMlae+SS56mhNrbNsq0SW3o9VkoorlzpjVrc5WB2U?=
 =?us-ascii?Q?xyIgVcT5XBy7cAYbIXCDDOsESxhoWj78PPF2/RxCQst+k7jxRVfVBc6Gv9CE?=
 =?us-ascii?Q?c58xTwt9YmW1FhxE4TlW11M0Xk3ElDbY2SqkEndrDZiNTqC9ChL5d+0pSL6w?=
 =?us-ascii?Q?qwhsHQf04v1L91JUudFMqZ7QFUg4TngUPG/1J3oG8haKZgZFC2yPE9Ex/GIn?=
 =?us-ascii?Q?iB5l/AndnbagjvOv0Gj+6clt6y0NedCHyEZ5RcY0beLU7KU6cS6P31eHlNBj?=
 =?us-ascii?Q?vdJEhB969YnL1NQ52rAsq9wx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c3f1e8-e787-404c-bd29-08d8ced649f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:03.5238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCz4zEYWYCgdjGsjP1sE1NBeAK3q8BfQcOJFjMbhqiRRA4UgSdv39Xu+P9kIE+ks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We added these in DMCUB for runtime feature detection
but we didn't have helpers to call these with DC error
handling/logging.

[How]
Add helpers.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 22 ++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b98754811977..421af1a19dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -27,6 +27,9 @@
 #include "dc_dmub_srv.h"
 #include "../dmub/dmub_srv.h"
 
+#define CTX dc_dmub_srv->ctx
+#define DC_LOGGER CTX->logger
+
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
 {
@@ -106,6 +109,25 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 }
 
+bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd)
+{
+	struct dmub_srv *dmub;
+	enum dmub_status status;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dmub = dc_dmub_srv->dmub;
+
+	status = dmub_srv_cmd_with_reply_data(dmub, cmd);
+	if (status != DMUB_STATUS_OK) {
+		DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
+		return false;
+	}
+
+	return true;
+}
+
 void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
 {
 	struct dmub_srv *dmub = dc_dmub_srv->dmub;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index bb4ab61887e4..d76f9f2410cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,8 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
 
+bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd);
+
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask);
 #endif /* _DMUB_DC_SRV_H_ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
