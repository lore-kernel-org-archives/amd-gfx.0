Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBDC2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E738520644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m5lAdFm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E738520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819016E2BD;
	Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0504289FE6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbBGNhhX4nhbTBcLsE9F7vhmtOCxIGggozd9jAyeb6IOfRCnQHhm6yxHbBxC808saS05/ud5Ram5gCgQe95m2xcEpy44E7vS+vV39o251tNEbWwBvOPJiacoH41mN6gNl4ohpdJXs+CinfeQn5/UIMyvJ7BGbB6uoD7NpVbGTzUVfbCfYLmRmC9Lmr617h2nS5DwF1s20tmC+RkNJq8gUSE7jkQbcLWJ/Mq2003rb/AgamazCFageRnssSLJr36E/ZKPp2rqf75MidpSvX4zWtHEyVzIKAeOF1YvGmL9QZktU0t3nYXtFOKVzNKrZvksBZ3ALpLliOr+hPz6yBvk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6ZNASRKZiCS+Bs7tn60rFZwUC8MNsuuNKm7DzI8X+4=;
 b=RfTQXXwIUfyD4XBmV3IP9NEA9/jW4ianoZF3SUPXCDTqCJoZcwR2/l2YC4atfjo8O6FhZ7R6BmFOknsDT8AWOC6KzVcAqIYd5RerTryzpF8MwZCG1x+fs0xVtPdoYMkFnpkWmc3QN/2WgTZUY8gPpqIA3ELP5pp3/MBJm6lG945XXuK6aC9XT/Xf4/3KtSuqISdvk7qdCsS1V0c/YurVD3q4EpaNJMm370O8jyJWw2Jpq/T3ZAiPfFFfkq1cft5ugDLjW6738aV1X1lUpzDDknyxrexNyrgMYL1nhuGiwNJYLqWAhBOviw1AGyftSlZp/qM0RnLZ8i47kGKwbX6IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6ZNASRKZiCS+Bs7tn60rFZwUC8MNsuuNKm7DzI8X+4=;
 b=m5lAdFm9qObUGKnPGm2li8fj7mpkPgL3zSzqwuQWIFUkfBsZI7Svv8X1YG3hPLB/h8PAO5ghBGH3W7FK0qZgnaRyDSHy2tlVsUwCeEibRZlX2MVsgscCsf9r3r0dUbByk6Po3DZkAKI0gKxzW0Ss8nkxZJBYtIYyGhop0CMvp+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/36] drm/amd/display: Make DMCUB bss/data firmware blob
 optional
Date: Sun,  5 Apr 2020 16:41:14 -0400
Message-Id: <20200405204115.683559-36-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:42:12 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7137ebd2-fc76-4da5-4a97-08d7d9a1d223
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25554FD0A23D5B12B485E04998C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
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
X-Microsoft-Antispam-Message-Info: cQSYh9PodMGOoFfGqaXhmlPQuVN32gTQehj0/VbbwPIs1rG/DB7gnggqTZunm+wu89M33thEqo38Sw3jOxXAkOcX5dTSK/s0bSrr1wjzHwc0o/NJwHwVMQc/1yn+/T2t5Be2hx/D2x3pb9qOgXlIqGb0cf0lQWxXAqNXSnXaUiguQ7iacLBlguEt0AyvCtkFnFZauvUD9GFM8SxkwE4OYQ2ewqQCyC6kaNp2T2T5BWnvSVfnjFsiauxexpgQV8Mjq/u4nB4LepH0l+U6GkLIUKgfrwX6XkpUbOb+I7WTDGYLqohqIOZH8Da8XC9aOfbqCQmf6byOBNfBvoG2hPpfof6ckv9H7BxvDBJQXoaIQe/BxJCeUmob3fG1yJ4Kq9tvaJ/Ai7v4NHf0naVD2xUwEVOqVIvGTW/ASZKr266LjKzLKwtXU89KIG1ThSEleC6O
X-MS-Exchange-AntiSpam-MessageData: Xlk4KanHkrBWT0sOWt72PIDbo589hiwRSU41aufarYyyS2RDiJocLX7xUk0qlWQKIERuEPQ+/iQ6KRHD1JX2l1looiVz3qnsScnl6H6zcO0/gTqZ/1WS36A8gFHjnZsJwLC+qLHxNKAQuI0q7oehdMfX3TqLEHWV5GjhtOBjl6E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7137ebd2-fc76-4da5-4a97-08d7d9a1d223
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:13.6833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV+jGTGd7ENVrvETnSRiVnnHfjznOVUnd3Rj/7zRM1K8Fy7HYEZjOCxQuc4jV/COXF3/qlXxikhUziojuuijaw==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
By moving everything out of .data into the other regions we can drop
the requirement for the second blob and unify it all into the inst/const
blob.

[How]
We need to still support the blob being there and not being there for
backwards compatibility.

Look for the DMCUB metadata section in the end of the inst/const blob
instead of bss/data is missing.

Clear CW2 if we don't have the data blob so we don't hang when
transitioning between data blob/blobless firmwares.

Don't memcpy the blob into CW2 region if it doesn't exist.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++++--
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 24 ++++++++++++-------
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 23 +++++++++++++-----
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ca7489cbba94..05d9f46c33b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -825,8 +825,9 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 				fw_inst_const_size);
 	}
 
-	memcpy(fb_info->fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr, fw_bss_data,
-	       fw_bss_data_size);
+	if (fw_bss_data_size)
+		memcpy(fb_info->fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr,
+		       fw_bss_data, fw_bss_data_size);
 
 	/* Copy firmware bios info into FB memory. */
 	memcpy(fb_info->fb[DMUB_WINDOW_3_VBIOS].cpu_addr, adev->bios,
@@ -1265,6 +1266,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		le32_to_cpu(hdr->inst_const_bytes);
+	region_params.fw_inst_const =
+		adev->dm.dmub_fw->data +
+		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+		PSP_HEADER_BYTES;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index af678462f0e6..e40d1cdbcfaa 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -151,6 +151,7 @@ struct dmub_srv_region_params {
 	uint32_t inst_const_size;
 	uint32_t bss_data_size;
 	uint32_t vbios_size;
+	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 63bb9e2c81de..45638d61b73d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -186,14 +186,22 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 
 	dmub_dcn20_get_fb_base_offset(dmub, &fb_base, &fb_offset);
 
-	dmub_dcn20_translate_addr(&cw2->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, cw2->region.base);
-	REG_SET_2(DMCUB_REGION3_CW2_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW2_TOP_ADDRESS, cw2->region.top,
-		  DMCUB_REGION3_CW2_ENABLE, 1);
+	if (cw2->region.base != cw2->region.top) {
+		dmub_dcn20_translate_addr(&cw2->offset, fb_base, fb_offset,
+					  &offset);
+
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, offset.u.high_part);
+		REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, cw2->region.base);
+		REG_SET_2(DMCUB_REGION3_CW2_TOP_ADDRESS, 0,
+			  DMCUB_REGION3_CW2_TOP_ADDRESS, cw2->region.top,
+			  DMCUB_REGION3_CW2_ENABLE, 1);
+	} else {
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_TOP_ADDRESS, 0);
+	}
 
 	dmub_dcn20_translate_addr(&cw3->offset, fb_base, fb_offset, &offset);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 0be8a54cc475..0a1a851741c5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -91,17 +91,29 @@ void dmub_flush_buffer_mem(const struct dmub_fb *fb)
 }
 
 static const struct dmub_fw_meta_info *
-dmub_get_fw_meta_info(const uint8_t *fw_bss_data, uint32_t fw_bss_data_size)
+dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
 {
 	const union dmub_fw_meta *meta;
+	const uint8_t *blob = NULL;
+	uint32_t blob_size = 0;
+
+	if (params->fw_bss_data) {
+		/* Legacy metadata region. */
+		blob = params->fw_bss_data;
+		blob_size = params->bss_data_size;
+	} else if (params->fw_inst_const) {
+		/* Combined metadata region. */
+		blob = params->fw_inst_const;
+		blob_size = params->inst_const_size;
+	}
 
-	if (fw_bss_data == NULL)
+	if (!blob || !blob_size)
 		return NULL;
 
-	if (fw_bss_data_size < sizeof(union dmub_fw_meta) + DMUB_FW_META_OFFSET)
+	if (blob_size < sizeof(union dmub_fw_meta) + DMUB_FW_META_OFFSET)
 		return NULL;
 
-	meta = (const union dmub_fw_meta *)(fw_bss_data + fw_bss_data_size -
+	meta = (const union dmub_fw_meta *)(blob + blob_size -
 					    DMUB_FW_META_OFFSET -
 					    sizeof(union dmub_fw_meta));
 
@@ -247,8 +259,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	mail->base = dmub_align(bios->top, 256);
 	mail->top = mail->base + DMUB_MAILBOX_SIZE;
 
-	fw_info = dmub_get_fw_meta_info(params->fw_bss_data,
-					params->bss_data_size);
+	fw_info = dmub_get_fw_meta_info(params);
 
 	if (fw_info) {
 		fw_state_size = fw_info->fw_region_size;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
