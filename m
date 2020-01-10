Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDAC33CA5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EDC2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B4Vozl+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EDC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483846EA37;
	Fri, 10 Jan 2020 14:47:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151176EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAevzd7uAK35hKwrFIhlm5NC8c9Zn2uiE/4a2+0T3FvrROLC7zQu+1KlCSysTm/9detyg21u+5RU31l6LZtgcSuGbOgS8BC1D5OcXEtvSb3iBAq28eqxBW0eUBHUyLshHJHy/dP8TWl6yKvFy2rvD+YzxqpHXNGBgzSxmUt+ywyOiyhGTIG9aRaARd0xxUwaeneW5TXM1LsZ6u4DUc5MYJJsm5RNy3FTL5nGExOskmO7mVLITFNRseOOmsuSN3Ofb/GgMw1GaskGOGq1Gj5Bl6w/Ooatd6CG6y1N7wxtbNbphmkdjWdpBlIZKanCEKLnhMWXwsX3oE3lDqXDT8ihbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PangUCZV4K3xTZfPX4SMWX5T8oJKJYRmRpjdl+DINXY=;
 b=TY1m/5ZQIYvUzyeJ+8Rld7cwqpI6bJR8VdhOtjSsacnA9w0gvGpt95E98DiFKx2iShk807gfpi/MXUsZZzw6onts5G/qlOjpTlPxRjvaGCFhveLJvZZlNez/NuxJLtqCexbQIRqtI/R2jx7DSlxYo6izcELYwMu8ax4yhJPJM0TypOGO42efHpIGhvTxxC4+JjIbPleamtYcuaFCYIRwVhK3eJ4iHb9JYyXhF3K/uVYws1a81jd7EYVt2mwKWPSbs+tolkS6+S5CZDcHgsXIun1XfDXQglzAPxqtdN4OCInJwJNugIB+rLiOyfSSvtq42mS+R53n0vUpukWy+cycvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PangUCZV4K3xTZfPX4SMWX5T8oJKJYRmRpjdl+DINXY=;
 b=B4Vozl+ovpCbJiVt2EBiqViYr8Sfj2xhI9H8K7PH75YfMBgf5OtsHpT20iLjbZYlLPF8DKNWqKUkP4K1rCQ+HLK3ujljb5H8RCgDCRau4qRyoo5++wS/Gzfc+xI57vDNyF0kJ2wU9BzePLl+yiGVeDZ9/7poUQ8tTC5SsWdI7ZE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:27 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/43] drm/amd/display: Flush framebuffer data before passing
 to DMCUB
Date: Fri, 10 Jan 2020 09:46:20 -0500
Message-Id: <20200110144655.55845-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:26 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9d37a97-2ce7-4754-3dab-08d795dc0332
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25249D607C44F377AE530DAC98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw8bCwUMBsyQco/dKCdJN7x3tW2Wa9W4KO8X23/mKjJF1/EnveEz1sIx70Rg8dibs1N4atjkUC+q/7uwdJDmeT1eODdjExknXT1aw2D0dCvjbfgrCykGDZ7GCfjcYD+8MZkUpEsl/w9hLqZdZZmCTlDWI1yjUwY7oMuy8FXE7xNRHgEhnMULGzo+s93TYQTvisA+Wz522QMpZVAHyU5aeGwVyvsb9tRopSZsGljR9NWxCvCJwMVk8zHSz+agzjtlbqYEPYa1LLcjhKCKQfu8LRLQLBS+MBnGb85TBVGJEabgcyNQfMMJZVsqEk9dFllCi7SsxazdTIn/hvGMSFPotfSfwmB70xLXkvOJU6wnfs3gLUS2MrOdi1OxjoplXCEa9jwRKCxgyLx92vWnuCNB9t3Q7CgiDCUZTvBgUzvPpc0ztjm/8axRNarxLJJ3PB/i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d37a97-2ce7-4754-3dab-08d795dc0332
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:27.7451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KSEdFNNX7CEvesPrcQZuoSZzckZxPzllHySNg3ttT5djpgKq9p4BRFqAdbllSuw9613OWBR+049q3kiucGCHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
There's a data race that can occur between when we update the
inbox write pointer vs when the memory for the command actually gets
flushed from the map to the framebuffer.

DMCUB can read stale or partially invalid data when this race occurs.

[How]
Before updating the write pointer we can read back all pending commands
to ensure that we stall for the writes to be flushed to framebuffer.

We don't need to worry about choosing HDP vs VM flush with this
mechanism.

Drop the dmub_srv_cmd_submit() while we're updating this to work
correctly since nothing was actually using this API and the caller
should be explicit about the API flow here - by doing this on execute
we can give some extra time for the flush to finish while
preparing other commands.

We should try to avoid writing single commands
because of this overhead.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    | 17 +++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   | 19 ------------
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 30 +++++--------------
 3 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
index ac22744eaa94..ade688fd32f0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
@@ -113,6 +113,23 @@ static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 	return true;
 }
 
+static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
+{
+	uint8_t buf[DMUB_RB_CMD_SIZE];
+	uint32_t rptr = rb->rptr;
+	uint32_t wptr = rb->wrpt;
+
+	while (rptr != wptr) {
+		const uint8_t *data = (const uint8_t *)rb->base_address + rptr;
+
+		dmub_memcpy(buf, data, DMUB_RB_CMD_SIZE);
+
+		rptr += DMUB_RB_CMD_SIZE;
+		if (rptr >= rb->capacity)
+			rptr %= rb->capacity;
+	}
+}
+
 static inline void dmub_rb_init(struct dmub_rb *rb,
 				struct dmub_rb_init_params *init_params)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index f34a50dd36ea..8e23a7017588 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -444,25 +444,6 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
  */
 enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub);
 
-/**
- * dmub_srv_cmd_submit() - submits a command to the DMUB immediately
- * @dmub: the dmub service
- * @cmd: the command to submit
- * @timeout_us: the maximum number of microseconds to wait
- *
- * Submits a command to the DMUB with an optional timeout.
- * If timeout_us is given then the service will attempt to
- * resubmit for the given number of microseconds.
- *
- * Return:
- *   DMUB_STATUS_OK - success
- *   DMUB_STATUS_TIMEOUT - wait for submit timed out
- *   DMUB_STATUS_INVALID - unspecified error
- */
-enum dmub_status dmub_srv_cmd_submit(struct dmub_srv *dmub,
-				     const struct dmub_cmd_header *cmd,
-				     uint32_t timeout_us);
-
 /**
  * dmub_srv_wait_for_auto_load() - Waits for firmware auto load to complete
  * @dmub: the dmub service
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9a959f871f11..23ca1fe97757 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -405,33 +405,17 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
+	/**
+	 * Read back all the queued commands to ensure that they've
+	 * been flushed to framebuffer memory. Otherwise DMCUB might
+	 * read back stale, fully invalid or partially invalid data.
+	 */
+	dmub_rb_flush_pending(&dmub->inbox1_rb);
+
 	dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
 	return DMUB_STATUS_OK;
 }
 
-enum dmub_status dmub_srv_cmd_submit(struct dmub_srv *dmub,
-				     const struct dmub_cmd_header *cmd,
-				     uint32_t timeout_us)
-{
-	uint32_t i = 0;
-
-	if (!dmub->hw_init)
-		return DMUB_STATUS_INVALID;
-
-	for (i = 0; i <= timeout_us; ++i) {
-		dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
-		if (dmub_rb_push_front(&dmub->inbox1_rb, cmd)) {
-			dmub->hw_funcs.set_inbox1_wptr(dmub,
-						       dmub->inbox1_rb.wrpt);
-			return DMUB_STATUS_OK;
-		}
-
-		udelay(1);
-	}
-
-	return DMUB_STATUS_TIMEOUT;
-}
-
 enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 					     uint32_t timeout_us)
 {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
