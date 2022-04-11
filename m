Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20FAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 11:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B9E10E31D;
	Mon, 11 Apr 2022 11:08:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E1110E31D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 11:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQmFm2hB44NOVBzUACSbWmxpmhOFXrQp3sqXz0486Q3RV9/tkF06DhwtjKQ/RBKsOAwH5NRRD8x59U+I6rhPbzWVCbfPP6OcUi+sFVn3+y3avMvTfBdaQWu/n4DVIoknSbPZNXEBbU+hadaSlozTULxaWznIIjE1Jgjm8ZFOUX7//nYftVD/QI6E/wrY81vumEWBcuLQ30Z5PDgPXyJPKnjzXLhGE3jNRk1a4Cm2R5JGWXqc7jejzvjdOp1pujhGYTDSChFtOxGYogJiVXByIq/LIPsDEjCd2UySSEVwqPHUCPKE+tb5v/NC6Rnc2MxY8Po2FUU4dM+9FTyF5lij3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8vDeSdA7+WN8bvxwsL2w+zOFHdXSPtu/mJqjomUYYU=;
 b=X0AQke94yf0m6S+NO6kwLAQCtnHlX44TRfXUKPPg1MPaEXMju7kv4nzHBn8a6F4rmbJLrNqOqrGlL1IOC/UMjwhnPBiBjJZx5KMl909nZkwHnW5OoS7UNdX77wYfFcXqwbK4V0geSae/MgPLhpwI4oXQiTbYuLrOA2y7HvnGdAPs8CFn1daeAvLcjsLCf2d0cWhG+AkgXedkuXHw5sbEbhsHXvpub3r/UQO9A954CcNlJKebdxOzFTw7fX17hiXa1PwZb8clBTz9tD3Agv5intE27LMLoVA/88Sye02vKJaHoo4I58pVo8OksUk14NJ7qxaGEnBP5ZCuETrNcCDotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8vDeSdA7+WN8bvxwsL2w+zOFHdXSPtu/mJqjomUYYU=;
 b=s0sT97bAU6+0v0DidL/8vRFx5M2a/LoE0pyAA1rSHdltgn++RVlKFnVuOoOYJmXq0XrLLL+QYbim/QavnFhyyri3IfPvJsqK7Yii1mEqCvO390tQkTSiu9KFbWjsTnkZY7JC61JRL1REN77RDZps/s7n61uxL3iy4DcTi8grnzA=
Received: from BN6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:405:75::22)
 by MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:08:52 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::26) by BN6PR17CA0033.outlook.office365.com
 (2603:10b6:405:75::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 11:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 11:08:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 06:08:50 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <Mohammadzafar.Ziya@amd.com>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: implement RAS interrupt handler for
 non-poison type
Date: Mon, 11 Apr 2022 19:08:24 +0800
Message-ID: <20220411110825.18808-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110825.18808-1-tao.zhou1@amd.com>
References: <20220411110825.18808-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed78b56-e780-40b5-5afc-08da1baba97f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB358342B083C50E5615CAA1A2B0EA9@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QJRcT41CbGapRAIenlTPzXfDVEDg9lFaq1tf+NET2VyNgVJdKp0hJqdYSzkebzxnjO0KV18pr4XxQGQnOnvvR7cwQeYFjAJrWXVO1tTOi47bltizMdHOgbYotPG+1XQvO5wDtFdSWHPImF7SDLEODqwGINrKCLrLYhrrFbPJEsRrGShJ+32UvICVbEy5E1VTj1x0BR8EQyz6nFrx6Rip08jGoSSevyp3sMoIE9Tejw4rUlUkiqYdEHYqkrVJ6l+zrYYc2yUuOBC2UyBHL+OoAKMpVmOIejQ1Gf855b/dMKhUWxkyxel7BujMcQ6JSfi7gmBFRS4hf8JawQu4l6UqGRXd1O7WXAzw4nYx25dO371bTzJzOqCFh9H/eFNFGDi3TvHZXux41VlRTbB8bwrex+ZWwb5g9KuZ8uM6qtGxkvIOIMbxIN0uOIyx9ZZs8NRgN54ZT2o30fsMhbaJDzMCfYcgJ2k24hLbHxIf14x5xattoNKzvzhVU+5z7ookEgGYRssCkiiuU5+Hk2guRUwWCe/ZNK/A5eYDxZpYBJg3DwmHYuEBPw9BqVYOzqxVYFSceBuiF4LHN1tBj5AKWhfxOdZeCif4laffxcEx7tT/ynwXnRs+pDbJKN4seZHqZ36GWVSOzabR4oSfj+dk2gjQRc/YJzPDlxHewHAQstRBl5MTwZrARlv1l79UnAtDfbHva2xKEtK0NOG1XUQYxWRAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(82310400005)(356005)(8936002)(83380400001)(6666004)(6636002)(40460700003)(2906002)(316002)(36860700001)(7696005)(110136005)(8676002)(1076003)(4326008)(2616005)(70206006)(70586007)(5660300002)(508600001)(36756003)(186003)(16526019)(26005)(47076005)(336012)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:08:52.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed78b56-e780-40b5-5afc-08da1baba97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for the implementation of poison interrupt handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++-----------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4bbed76b79c8..863bc282292d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,12 +1515,44 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+static void ras_interrupt_handler_non_poison(struct ras_manager *obj,
+				struct amdgpu_iv_entry *entry)
+{
+	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	int ret;
+
+	if (!data->cb)
+		return;
+
+	if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
+	    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+		dev_info(obj->adev->dev,
+			"Poison is created, no user action is needed.\n");
+	else {
+		/* Let IP handle its data, maybe we need get the output
+		 * from the callback to udpate the error type/count, etc
+		 */
+		ret = data->cb(obj->adev, &err_data, entry);
+		/* ue will trigger an interrupt, and in that case
+		 * we need do a reset to recovery the whole system.
+		 * But leave IP do that recovery, here we just dispatch
+		 * the error.
+		 */
+		if (ret == AMDGPU_RAS_SUCCESS) {
+			/* these counts could be left as 0 if
+			 * some blocks do not count error number
+			 */
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
+		}
+	}
+}
+
 static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 {
 	struct ras_ih_data *data = &obj->ih_data;
 	struct amdgpu_iv_entry entry;
-	int ret;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	while (data->rptr != data->wptr) {
 		rmb();
@@ -1531,31 +1563,7 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		if (data->cb) {
-			if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
-			    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
-				dev_info(obj->adev->dev,
-						"Poison is created, no user action is needed.\n");
-			else {
-				/* Let IP handle its data, maybe we need get the output
-				 * from the callback to udpate the error type/count, etc
-				 */
-				memset(&err_data, 0, sizeof(err_data));
-				ret = data->cb(obj->adev, &err_data, &entry);
-				/* ue will trigger an interrupt, and in that case
-				 * we need do a reset to recovery the whole system.
-				 * But leave IP do that recovery, here we just dispatch
-				 * the error.
-				 */
-				if (ret == AMDGPU_RAS_SUCCESS) {
-					/* these counts could be left as 0 if
-					 * some blocks do not count error number
-					 */
-					obj->err_data.ue_count += err_data.ue_count;
-					obj->err_data.ce_count += err_data.ce_count;
-				}
-			}
-		}
+		ras_interrupt_handler_non_poison(obj, &entry);
 	}
 }
 
-- 
2.35.1

