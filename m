Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E4FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39155208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qkaHSvYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39155208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805416EA38;
	Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBB56E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Z50HWOFy2XCM4ELLDs/7UZp29C6gpWvhE953f6x6rrNNZXmEf/Vu9oEByK45W9yxhNC7vi0MDsHEsZNHvyRjOMb2ZDR4iiYM+P3nzjIJPICqYqdg/n+9n6fJs//pwCRO06MIMiUsZQ0VvZbw/yi9/FHxh9bPV2OPsUx5Gps+NpR2qI3lduEM7s9AseXcjPOTy3kRAPuEV/4Q46NFS3j+/jpHN56AjLvXLyGcmuIBWxNPfYFYvx4BpQZx/duv2v8n2H8Ww2CtW7lJ8yL1V/psZ/5E0jGJFhMMHjLVJfblUnscVVNhtcgNHkEcL/gPymsGZty3MkHdT8/YYCGBsgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crh+toC5kN2aAWicLSLUcSjwXpO/N7Hi6W9TQTI6O5E=;
 b=BmBSAovQuT/DZ/0Xd7/P1n443mMmzMSTPu5WNgqzENXVkEsis6pYrC4lzQVhlwOs/MKJBXuD+wGPWmWn2dUVxE9eCW7I2W9/SEvfSI7Im5QhHPwODgwU3JWPD9pLSat+SMvcw0UppQrHYiwxI+Hwdcxb3esfAS6FcNTq3wNpzq1UNR3V9HplDDv+Vn/YbyF17WUHsFsnQD8wPBA+vW3zz/NUnxpeofnDvYboMsW/Jm7cMqVHYoSb4t2lKch3DJodlMe18rU4vJNuP3JgzRUZNSsZpq0j1sk+QVoAfgGJ6X6DnOwmeOaZ7l262wxJtAIyyDGMYrlhcN/NQ7+UfOZIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crh+toC5kN2aAWicLSLUcSjwXpO/N7Hi6W9TQTI6O5E=;
 b=qkaHSvYRD5GNV5faPteGSXI8i5jAGkc2dh91g4k/uJ1rE1JXCe4+Ubv08rC+rmFURFyH4/3cceJJgD1axtKTRx73c8f+jk9dkrlsaqWqh+kcqEBIPonCR5lqtndNHv6cKPw3RP5z9Ai6+38jKhCrOx/3ruiuyANRIhYqYfKOuDI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:52 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/30] drm/amd/display: enable assr
Date: Fri, 19 Jun 2020 16:11:59 -0400
Message-Id: <20200619201222.2916504-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:52 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba140d8f-602f-42b9-a042-08d8148d2558
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408718F859AB1DA65E49AF1398980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWMYs+o+Wltsu3qur35AkPIpfde3q5Nj9J8sClYbgAewijSjupvrkyRSQshFDKUjOKZiuM7E1HKNCmCW12v/mAL6Z0oT9zxRgY7HvzdxPQF2Uy76NforLiwVTJSQvAJP5t/pD1cfZncoL902lmZCXle+l+Sd1RfWa406R8yGR0I/QVXqOuYmFdFWjq5Wwsf8iNR+qsUlZCldJXTflqXfPllP8ysk/Y1cf2RM5N1zkOZ0CGoMgfZzZCj/6Dyqtnm5GyyOX+xXh3+Gj1NkwsLGj/Z3AukhODRWJJMcTZcTthbg5mR8UDIaLouyk2p6VQg0E7e0tKCZGeTPvkOZiIpnQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ki+i2VyG3WLbh9bB1EDVe2Us00KKuED7IxOhlVEdOogQ7pJtUMa/cmC2I2jqLzgrW37/1tAtitJTshWfnzX/U2cI5NPrpPa4Wo7QZYtVPCmkGZC7tx1c1dKUZVZsnLYsHN+kN01UgQdNntTni8jm7/yeH5B9+bibTJEJ+oDSdqa+PhzqdxmCoOfNQRAKbv7rKoG/AWqI0ctHRK7bValcgYo5s6o6HozShCy+BZfhsmNc50ce70Tom+va1qlr/Xg6mla4GYDFnZmUvL1BKv0gazwrq+livfzZjikAb7ynD10SxnG3h1odQv1KIJxEkHTVyNBrjG0TXHn9vt544VzSvIKawbMAyx4AM+gtE6k2watiGFyolmadhMdwy6b3KEprCFUDeXu9Nlim0iq9GVPGmbb/Eml4fHpI946aI+J5cM3nDUQLesEgFp47hFZjZ4Ic4QlH1tFOm50nhcBo0JtHyUyrWEwiuYbYBwSw8/7MGYjtmUIfbzFWuBihF6OQbfVH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba140d8f-602f-42b9-a042-08d8148d2558
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:52.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wWvps1yadP6UI1nApy0fSYJdOOyGcruHqGBTr43kUncWBj+VTi5wlx00BoF/iLeEIUs1ZwWooht7csCcYSKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
assr is content protection for eDP, in order to use it we need to call
psp ta (dtm)

[How]
We have a enable_assr callback, hook into this and call the correct psp
cmd id to enable assr.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 37 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index dcf84a61de37..a8ee42d30911 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -390,6 +390,42 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
 	kfree(hdcp_work);
 }
 
+
+static bool enable_assr(void *handle, struct dc_link *link)
+{
+
+	struct hdcp_workqueue *hdcp_work = handle;
+	struct mod_hdcp hdcp = hdcp_work->hdcp;
+	struct psp_context *psp = hdcp.config.psp.handle;
+	struct ta_dtm_shared_memory *dtm_cmd;
+	bool res = true;
+
+	if (!psp->dtm_context.dtm_initialized) {
+		DRM_INFO("Failed to enable ASSR, DTM TA is not initialized.");
+		return false;
+	}
+
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+
+	mutex_lock(&psp->dtm_context.mutex);
+	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
+
+	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE;
+	dtm_cmd->dtm_in_message.topology_assr_enable.display_topology_dig_be_index = link->link_enc_hw_inst;
+	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+
+	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
+		DRM_INFO("Failed to enable ASSR");
+		res = false;
+	}
+
+	mutex_unlock(&psp->dtm_context.mutex);
+
+	return res;
+}
+
 static void update_config(void *handle, struct cp_psp_stream_config *config)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
@@ -599,6 +635,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	}
 
 	cp_psp->funcs.update_stream_config = update_config;
+	cp_psp->funcs.enable_assr = enable_assr;
 	cp_psp->handle = hdcp_work;
 
 	/* File created at /sys/class/drm/card0/device/hdcp_srm*/
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 968c46dfb506..5da7677627a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -38,6 +38,7 @@ struct cp_psp_stream_config {
 };
 
 struct cp_psp_funcs {
+	bool (*enable_assr)(void *handle, struct dc_link *link);
 	void (*update_stream_config)(void *handle, struct cp_psp_stream_config *config);
 };
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
