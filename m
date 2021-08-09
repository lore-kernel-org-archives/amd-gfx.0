Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1BC432BE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD7461004
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AD7461004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E982189B38;
	Mon,  9 Aug 2021 05:25:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2067289B38
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 05:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkNDxcxis+4HgEWDPdZ4PveW6b7fp5wKsr/uEaA0qRxtZ7jM7oEnnYG77WG06cQp/FLwM7JnaE769vV23tmJY3qZMlkaowFSCb4+HMBuGr9flRXKBv0Wba4XXWxaC/qN4yv8kHyYrvbB35q/gi/B9A2LzmuQsC/k4jjCOuB7c/yYGyS+N5uijg2V/VKMT9qdUbavaaFG36LnCClJ8K3gccinm6CfyQvnfqDXbfVmFvEVq9Vi+XaPzk3yYI0WJSvIcCSjMrrflC2ZfkhqPxjrgcvyALWOpRydqirAdohjnUx4xFCP/8dpcDRO+wwdoEtbKLd5GFP8RftD+ypU4WgDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM0RLJhIds+U1h/JB40xMnogTw3HHZVhqX3s9DqJOxs=;
 b=YAJeoqdB7C7D/q4GecA0FHri0vh8urVBtnr+MLCTygJvk0XQ3ZK6wTsog5GmR3Dzh+Y0PDXHivK9NQekC08LiEzJkh/5OvXkcEgWD1wZC1gd65Bta61E0oKLck8Uijv2fnB8jfrX+d7D2gF0HkP8W1sQyizen2/65MEmmAQRAXX6HcOueNO6Z7+frny3eKZvrrrslwGIVShUH4lft/5HNyfW8gnJye2SER/VJDSE9kWTYqS6qppd20muPgzLD3nyiRMvfpzN7baPqgzTV2D79rDI1Wm32ZveNdR11u3PAaVBOJIQF3KWXPk3ehUqswwlxCOCiARGYPIPHWOHgF9mMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM0RLJhIds+U1h/JB40xMnogTw3HHZVhqX3s9DqJOxs=;
 b=IHm4JCaUs0+58lCpYbsYQaxVlWebll6XMFgeoEG8Gsu3219+3W/cSrUd3EQirwimFzV5s9I7gh1fq62u9FWssZzb9jx7QUDx6GQ4YEG9TBlbST45qyrZlZf7+UZLoMMoe60bUSk1xzFSYYih6WjjCyoMbaEeL/a8pp5t8dvQMNg=
Received: from BN6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:405:70::11)
 by BN8PR12MB3044.namprd12.prod.outlook.com (2603:10b6:408:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 05:25:36 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::21) by BN6PR12CA0025.outlook.office365.com
 (2603:10b6:405:70::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 05:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 05:25:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 00:25:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 8 Aug
 2021 22:25:35 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12 via Frontend
 Transport; Mon, 9 Aug 2021 00:25:34 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Extend full access wait time in guest
Date: Mon, 9 Aug 2021 13:25:25 +0800
Message-ID: <20210809052525.3537-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94120807-41db-41f0-f9ef-08d95af61e0f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3044:
X-Microsoft-Antispam-PRVS: <BN8PR12MB30441A3CB102307F8FDA2E42F8F69@BN8PR12MB3044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXzvhOKGJkOnidaYTFDl9QFxfzWszMNv2bv96QAvxCaEAx2Ss0cwQ9Lkp/ky5xCQ+nCliYQuEI9jWSXBNawaAHVeX6LFjGxAxx63J1TZmdJWoGxdvuhJU0JR2V9y8oxOnVwZVilKCI/lKzWGSv6fQeMBNkBda4Q7rwPxQAOU2OWn/vUawsAF6LCqQltYn06Y4MMnlpidc/TkjnolpS7vcJdZIyIlGW64igIWcg5UM+UXZufB/KssPH5HaFFif4QmCDCFHS0rYhkCmIGJMPlIv0/fWxjGI+AH0zXIC3TI1Qi9Wi2dQ14pRMAs0NKgRQeIzMy3VUfErpcGmiKOuZO8B1vLPavcRk4Vhncekpwpen/V5crVvmfMSrMbh/39D0vQal2qjtkujEa0ATNswJY/yG8PDV1E1FBADHNEeSyCOd3URYJXqEY0ZT8hvAYb98w4cF9yWCKBPqMFu3zAymENP+eJ4vkeis/sdtaWDQbRmdU2UlNQm47DGen1eo0ax8NXxXcqZKJQ4VYhVtCpBmAexT+2kKSTGIwjbDRYfbeHAO6jJEkxVlaUPbvmxDFXXMhpj1UGyarETSd2qsuWo8blwVsdOCqyMSz812dN/ENP96RVn653/I0oKs5DtB0h1i+UC64M/w8IH7SVsXgZFumt7YEkgXH5S98+tURkaHnsVI3s6PPx1iidlobWB9gvaFlOCc6bfH5nyHCV6TdTLMp3IPPvR+h9QBeNnjDLrP914wh1hhVIBOabgpoHXM/9FLTrgjSyIhIfaoTZp/zaLcqyOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(426003)(1076003)(5660300002)(316002)(336012)(47076005)(356005)(82310400003)(2616005)(36756003)(81166007)(36860700001)(6916009)(26005)(83380400001)(478600001)(186003)(82740400003)(2906002)(8936002)(4326008)(7696005)(34020700004)(70586007)(54906003)(86362001)(6666004)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 05:25:36.1984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94120807-41db-41f0-f9ef-08d95af61e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3044
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Zhao <Victor.Zhao@amd.com>

- Extend wait time and add retry, currently 3s * 4times
- Change timing algorithm

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 9f7aac435d69..b48e68f46a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -96,7 +96,11 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 
 static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
-	int r, timeout = NV_MAILBOX_POLL_MSG_TIMEDOUT;
+	int r;
+	uint64_t timeout, now;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	timeout = now + NV_MAILBOX_POLL_MSG_TIMEDOUT;
 
 	do {
 		r = xgpu_nv_mailbox_rcv_msg(adev, event);
@@ -104,8 +108,8 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 			return 0;
 
 		msleep(10);
-		timeout -= 10;
-	} while (timeout > 1);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (timeout > now);
 
 
 	return -ETIME;
@@ -149,9 +153,10 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 					enum idh_request req)
 {
-	int r;
+	int r, retry = 1;
 	enum idh_event event = -1;
 
+send_request:
 	xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
 
 	switch (req) {
@@ -170,6 +175,9 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 	if (event != -1) {
 		r = xgpu_nv_poll_msg(adev, event);
 		if (r) {
+			if (retry++ < 2)
+				goto send_request;
+
 			if (req != IDH_REQ_GPU_INIT_DATA) {
 				pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
 				return r;
-- 
2.17.1

