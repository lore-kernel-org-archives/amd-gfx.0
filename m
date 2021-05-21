Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C36C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF19611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF19611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7CF6E525;
	Fri, 21 May 2021 17:37:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC266E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SguW/Nw5yxMmmHZtJfstyoeXw+VrD9uoVsL/euPXKHJIBrpsMsYGoLMt4DpqU6on4DyJV5be+NCD5i0eqPJyoTYU8RDYuz9GlrdSiHq3tcRNjJDH8YVgb9Q3oyDGDkLNlAUlAG6DvxZEBjM/HmGU4sS6w6ie/DtFbPNRktr3H8aGsXh0WOS3NM7j6KSO/siB0GK+HX5+DYjhEWR6EYT3V6B8hsDBV2JfDdqBVp6UmJAle1mkquZo+VWFjW2/I8GscXxe/GMC+BhxZ6exyqlV+RZ+3c+HLMleV2/c05V1tfPKt2nDaQCTrrA63861lfYlZC3we0XDdqz3EEl+HY/EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXYDWoX2NZYzf/v62CNiDqPC0ZBe90wV3EcpyFMTNKk=;
 b=joZhKCHYjl2+QVJZaHbwhdLyCxNtCpZutPAXrLuSv7k7OtwcFW8y6rRZBjdFCILjFf4WKT4IhiB+4HCjydEv1qirX88zf9aQ3j9VZs9/RZsgsaBjSkteoYq3stSxIaLiWMNzb/I1V0tC8Z0cZg+jmnvJgvUp7Fe21kMV+G8IVWA8gocVdGReDqNVYw+e0X5vaL5s9pBIisyysTXctess0ACs1mov0CxXZeYDHvqS0QWlXsDf2MzjPODlO7TakPiW8ZFteEzo0ZnR1gahH/eeLcdIDqnWt4tgOJsaXOd9C2YmTDPZealsnd/nh6rPM7BeCsOo2NE9T5DiiYI6EwiNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXYDWoX2NZYzf/v62CNiDqPC0ZBe90wV3EcpyFMTNKk=;
 b=cGNMastNOgAq1hZ4I8AKprBpjBq1PT3E9YJ0Bo0wNgASSe9+yNryXHo3XuL7WgR428A4VempMPyK7x5BxWGlnbgHzigwtndR5vC/FEQBqGORt1w/hnVIoRQJ3m31wyyBZpbiFpY2ld2fQqop/FF2jOu0fzshDPbcs3zSpU2DQqw=
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:37:04 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::a8) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Fri, 21 May 2021 17:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:03 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/15] drm/amd/display: Implement INBOX0 usage in driver
Date: Fri, 21 May 2021 13:36:39 -0400
Message-ID: <20210521173646.1140586-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0eaae8f-68d1-4620-5d54-08d91c7f0c77
X-MS-TrafficTypeDiagnostic: CH0PR12MB5139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB513994AE0154F97CABC98642FB299@CH0PR12MB5139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7DtytCgSs8h3ptr7H28VDXmeGoAtxY1B4SmURlzzZ02Sc3tdu03Xvn/8C69udTqWFeTPhb/rV0ln2oPz1zwfAQ6Zd94RtZfi2riwANLTKNOqddn2Yq4JgfmQKTWfzlTv7HdJiFbhLByM+tj4W2dGlm67Wsi1wN/pzshrv/vkw2YXL4a9jiHSCoo+s/3UauZHshFOKo8/2Jya7yz0mKXGPFXRriqBCRsnreA5Zv2v8/gp5hep0PkBzgWCZYPBAYQdoHTnBNN+bz7k0eykMEuQpBTq91mZH84I1B+rm4FOHWRUxqwS3Ezvi7AQFkn4fwYAGHLUjAJJNvkuPb9FpxBL79rwuCZ7M3VpKUxO9kj458Aohrmtmb+oBAkqf6HxhZ4BoyCHIkR7HYhHpNF2nMq0k5CCgsxoCQAGg5+q/cVgpO0fpnQ4h7Y4tFQ91/LvESA8xPU90ufOlUMKWGJZVwo8CCnS8z/uhPxWkbtqrtYZMj+fCDOhECIvPF140yter5DTQDrWUAOHc4jqHG1tzdy9MYYmUWZVULKIp6XelX8+TNZVYlmg5HUg41CjybuFdsMIiVpQ9V0X+xIWIo37kXvB0Mj6T2FnBoNSnUUIOhvbUc9zXQTlRkkrQoQyC/CzoHdiILvKiw6xF2JZj+QhHC+zGDwVQEMZ764mo0tKKYL+QJpkqZ/DE/v0ejrA0oihcAi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(1076003)(26005)(2906002)(336012)(2616005)(36860700001)(4326008)(82740400003)(6666004)(8936002)(426003)(16526019)(47076005)(186003)(54906003)(44832011)(478600001)(70206006)(70586007)(82310400003)(83380400001)(36756003)(86362001)(81166007)(5660300002)(8676002)(316002)(6916009)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:04.4769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eaae8f-68d1-4620-5d54-08d91c7f0c77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why]
Start using INBOX0 for HW Lock command

[How]
- Implement initial interface for INBOX0 HW lock message

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h | 3 +++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           | 1 +
 5 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c5dc3a947020..4b2854d1d981 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -110,6 +110,15 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 }
 
+void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
+		union dmub_inbox0_data_register data)
+{
+	struct dmub_srv *dmub = dmub_srv->dmub;
+	if (dmub->hw_funcs.send_inbox0_cmd)
+		dmub->hw_funcs.send_inbox0_cmd(dmub, data);
+	// TODO: Add wait command -- poll register for ACK
+}
+
 bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd)
 {
 	struct dmub_srv *dmub;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 338f776990db..f615e3a76d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -66,4 +66,6 @@ bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_bu
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
+void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index c97ee5abc0ef..9baf8ca0a920 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -52,6 +52,14 @@ void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 	dc_dmub_srv_wait_idle(dmub_srv);
 }
 
+void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
+		union dmub_inbox0_cmd_lock_hw hw_lock_cmd)
+{
+	union dmub_inbox0_data_register data = { 0 };
+	data.inbox0_cmd_lock_hw = hw_lock_cmd;
+	dc_dmub_srv_send_inbox0_cmd(dmub_srv, data);
+}
+
 bool should_use_dmub_lock(struct dc_link *link)
 {
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
index bc5906347493..5a72b168fb4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -34,6 +34,9 @@ void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 				union dmub_hw_lock_flags *hw_locks,
 				struct dmub_hw_lock_inst_flags *inst_flags);
 
+void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
+		union dmub_inbox0_cmd_lock_hw hw_lock_cmd);
+
 bool should_use_dmub_lock(struct dc_link *link);
 
 #endif /*_DMUB_HW_LOCK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 79ff68c13902..ed58abc5b3f9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -324,6 +324,7 @@ struct dmub_srv_hw_funcs {
 
 	uint32_t (*get_gpint_response)(struct dmub_srv *dmub);
 
+	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
