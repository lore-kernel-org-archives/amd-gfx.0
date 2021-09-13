Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F32C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250C560F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 250C560F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E846E122;
	Mon, 13 Sep 2021 07:56:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B356E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 07:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbJIQ2/HglgAidGHAwRnz1fVYF5q2w/XDDAAa+ka8STOLvvjqMzvyCBV93Zhgo6uF/4knlO2o1S4mjDWEFbjoK3auXhcbXdyChj3g2d/qTN6EHE+GeFzlAuT1avtBPkxqVPziHHfL1NAvaj8ja1fpcnm66Dl/N1gdD/RHWecizfBMWlX4zuRpCQEZ4CmlnYSm34mhmrk5AIoUEm5dU3qEA4OdOWADDnEilpue9V1XLbhRV1lRp8LDMt+LfMXbmPfO0QLepFF8oBs2qpAwed4ks75Ub7LdPDnB313ZUSZctRHWNAcSr+D6LW1xVIe0rGf6G2vhZfwuOGHGYmjfYgmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=z/bl55mYBngHjto9uWuYv0udXQhRibqWByEYzPNy8OE=;
 b=IkjJtTyrBzJEAfBzw/G3NKtB9RRxFYCa4i0e7AS5RgsRo8KDWQCLtV6oKJznusTM26IQV9HD4ZOXIlEWRY3lTI5udWzBVSEJaW1KMQZMPJwxXzicpZ/PCWnwXIAkmnqefUYm0x7nuab1E0kkWc0ya03Zpeu5t2iBa29XRPz93poUUHfwSK4MZx+l4ktGDMmR72ldlC9tf926qwYZu2fy2xDsrR5fzYu+g8F5Pc9JDT0vKhFmJPOOgXHR9RU2qr41z7qCsPRz+qdpY4xMbdTzKx4SdQFnmrFw/TB6ZB22Zu+TEFVhFeE40QVU6+Bf/mMSMwPjWfNqw29WouSNqY9r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/bl55mYBngHjto9uWuYv0udXQhRibqWByEYzPNy8OE=;
 b=1HQ9oVw8zt9FOvvHPVlNKPDkltq8v+xPh76kPmjR68oBSddD0U7mPdHgay+D8G425N8jQs+7gXOH8bedsU5Rn8b9UnOpwFSiG8COq+tSHIpD+SSMSKuipG3cyj01QUkFBF0ClWFJoxy69Hs67VPmogZW+JmH57fLE86gq+kBhmE=
Received: from DM5PR13CA0016.namprd13.prod.outlook.com (2603:10b6:3:23::26) by
 BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Mon, 13 Sep 2021 07:56:09 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::a7) by DM5PR13CA0016.outlook.office365.com
 (2603:10b6:3:23::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Mon, 13 Sep 2021 07:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 07:56:09 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 02:56:07 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Update PSP TA unload function
Date: Mon, 13 Sep 2021 15:55:51 +0800
Message-ID: <20210913075551.24045-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d307e0d0-4bea-46cf-8e06-08d9768bf2d8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-Microsoft-Antispam-PRVS: <BL0PR12MB245130BCF3B250D0A74332EB91D99@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekOIh/LqQ3J/4DfowU7cowe13uadGFeI239VcU+flqJyYSD53EkHtkkAPN7o/HXApLeGQ+C1YPX1KcqoXmWPav3WYn+oXTlG3Hyoalvk4dNczIGBoXDIJCsCuqH7XpQxmVjcH2FvOOHgTMN/YUCIiON/vWa8wM7RU0k5VF7GTdg+B2BzAmMAftKwq+UKJ7Icg2B7+fVq7Sz0bkLBbxusCNYW+z1r3USlalsnUiFJQKPfvLPRT392dvIMIiYVywf5B3XsxkKLNqF/qaBCYrtkEZDyQzagB88XmZMQJaIIOC5DrIKbYD9AdpYa3Pyxn1hiwQ/RaBuKLtsqr42BXevil8DboL61iR037II749LjIklcLDaRoxTMUr7XO1L+iXezq7woOX0mL5dheZtvetb+irsOREytogC5enSMy0Ar0hIaxA9yblTUrQw8Vo/Qzq9PICXc6fwz++3cH/wI6L/7fl24pyExM+bSJungmyZonGAiHH4gqdzr1GH4ZGrd2KCObO77Z9bnJlajM88zPBGofMS8skM+tSX3jTfrf9PaSNjH0khAN4CjLHZyWFgGj2Sm/43vHo1r7iyIu0rTaLfuofjyhNnQEvh2BouPidw9TFaEfsXlbonmeexJeV8DbSrxuoXfzotGvoPK7taspqhAnSeHZTm5ZVQ6wtR5Xa4iQqTcsO0va+BqAGfvC2f3UR3OGhRTIkXzSZijLf+ChAVGcpQvZR4azqbC8YXEHl4IffY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(70206006)(1076003)(36756003)(70586007)(8936002)(54906003)(8676002)(15650500001)(316002)(2616005)(26005)(7696005)(336012)(81166007)(356005)(82740400003)(2906002)(36860700001)(82310400003)(83380400001)(5660300002)(47076005)(6666004)(4326008)(186003)(426003)(478600001)(16526019)(6916009)(44832011)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 07:56:09.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d307e0d0-4bea-46cf-8e06-08d9768bf2d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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

Update PSP TA unload function to use PSP TA context as input argument.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bc861f2fe0ecf6..7d09b28889afef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,7 +46,7 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
 static int psp_load_smu_fw(struct psp_context *psp);
-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *context);
 static int psp_ta_load(struct psp_context *psp, struct ta_context *context);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -816,12 +816,12 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_unload_ta.session_id = session_id;
 }
 
-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, context->session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
@@ -832,7 +832,7 @@ static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)
 
 static int psp_asd_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->asd_context.session_id);
+	return psp_ta_unload(psp, &psp->asd_context);
 }
 
 static int psp_asd_terminate(struct psp_context *psp)
@@ -984,7 +984,7 @@ static int psp_xgmi_load(struct psp_context *psp)
 
 static int psp_xgmi_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
+	return psp_ta_unload(psp, &psp->xgmi_context.context);
 }
 
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1275,7 +1275,7 @@ static int psp_ras_load(struct psp_context *psp)
 
 static int psp_ras_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->ras_context.context.session_id);
+	return psp_ta_unload(psp, &psp->ras_context.context);
 }
 
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1540,7 +1540,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 
 static int psp_hdcp_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->hdcp_context.context.session_id);
+	return psp_ta_unload(psp, &psp->hdcp_context.context);
 }
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1632,7 +1632,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 
 static int psp_dtm_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->dtm_context.context.session_id);
+	return psp_ta_unload(psp, &psp->dtm_context.context);
 }
 
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1690,7 +1690,7 @@ static int psp_rap_load(struct psp_context *psp)
 
 static int psp_rap_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->rap_context.context.session_id);
+	return psp_ta_unload(psp, &psp->rap_context.context);
 }
 
 static int psp_rap_initialize(struct psp_context *psp)
@@ -1805,7 +1805,7 @@ static int psp_securedisplay_load(struct psp_context *psp)
 
 static int psp_securedisplay_unload(struct psp_context *psp)
 {
-	return psp_ta_unload(psp, psp->securedisplay_context.context.session_id);
+	return psp_ta_unload(psp, &psp->securedisplay_context.context);
 }
 
 static int psp_securedisplay_initialize(struct psp_context *psp)
-- 
2.17.1

