Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF515C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 03:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C99D10F106;
	Wed, 20 Apr 2022 03:53:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DF510F106
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 03:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myByH3NRyU+6U/seC10rhhieXV5GkKmVv4iSwnQB11+wkYtz+8lYA3aki9SRQrt1c8RX+lsZk6cBRmCA2K2YSNxQSaDe35CE2/YdDBVOhoZbBb7Tw1M3MdQ+psgCi+N0Pl29dhP5k/TsjU+44/JF03nyxL/mKiTGs61Qgnycwr3Ge0JO6f1o6R9g+N1i3Oq/skXhsF77ek3aQWbfxtGi+W4HYj1gE3RqQmcmTqTbzqzsMFXEsu4YBq3LwLTOmFiGmrG9KCmzNMidu0N6gntefPE3sWMs0Feu+jrjxUlD7a5QksbY3JJwbBwvYCTrBlT12HfBQlUy4niF4YsZ64PaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmYQX1f5GNMauXEA3+cIKJFuOvos0jxEl2iLKYv8WOo=;
 b=C6mGG+OGSH2oYe+skpThnJVX3Q7SmkhsxR00PhekStE280EAF/vtmUgciviiMFqj04GEpiAn2noF67mAQin3GuVNPZTZ3zkhMY8puPENe/lcRJabLL0pXFiYd7hltv1/65w9L+K3BYNk9scliQQXNNbNZhsJsC88ojacIgFlJMh0+Ul853W+7vNaKR5LtmId683GXfydhPmVODY84rE5wPcaQDbTDjC9BAuCQcY78IRnhfb/RNUcQui2F2ZmGN6Yc8e7IxnDde8As+kuUhVytHJkhEddCSj30HJUK0qxnWtRYBaMLJmFcZeY6+KV7WVHXrkEyedJmJDqBf/UJclPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmYQX1f5GNMauXEA3+cIKJFuOvos0jxEl2iLKYv8WOo=;
 b=h3nTvCUVODRhhTTyq3U7ww/51ixxZgebGFVnc5kBS/v6CL+K6rAn1kMgRMMQ/4LH0nnymQ3YSgw2h6fi/5quvNKIIhRSdHxcYfrpXd64CwP2GIjq88n9L7al12KoFniLJmRPvD1MYyv3mvIxh6D0EeBTRCFncP0sUDJ66Tp4zoQ=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:53:31 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::db) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 03:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 03:53:30 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 22:53:27 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for poison
 creation
Date: Wed, 20 Apr 2022 11:53:15 +0800
Message-ID: <20220420035317.4008-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3932360d-595d-4e7d-efe7-08da2281552d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB134632FE5623A2C7016E0FDFB0F59@BN6PR12MB1346.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f89sl27IlnjA4Y9VVpl8fhkc3rElIGiYjH5bZ6klpXrrLPxya3aLK6Y0AONfrc8A6saaBQgKTbtphH27MT97WUddUEEpnNNKwn4jjxsMCmxjFq8K/g4ZYOGtfsQOoRZjlLSk4zaOUWQaA2mRktRTPgoJEO5zAGiSUMFxqMQgaC3whjmh4sy6rGMfMrk3MAJIsIeZNGXDiQ4Sr7wh9kE/YZu+tlX8UpKadf4kpCWNIp6yEcXixhBBIU0KzipwqlThusw39rR9ngzBLvU2JGbjn/nxwfSvEkp30/OeRwQ5PVNffJaSBO8fuFW8gpEK9EDN+ReBEALqzNvMd3XDLGyOV3Cmj++qe+lNjiiJFweXrAewr5PspFP5aksf5ST053n5Y09JWlf7mgrJTwDUBAKjKyzZmvFA4CIeM0d5k3eEOMTxQMY8wWSxnhmoArpLnXaHHP2FvANU1OkTq/vXKc4Kv8lGMcakV1iFYAqtXT70iLB8WD/ZnkZ6fz2frOVvHOUobRFwjffo3bGDehuswkZ58VCBM3cA64fIaP4nbMyye2phxDOP1fFgLC+nl088nOjGxGMcN5S3hOB42xC9gLzgWszuSFerB8PwJ2zsDZXHhmK4yJoijN+ebrNDevbWlt/Zow+vvgoM+exNPHi9DixYgVB6LqiihVErDxD7EIxeYF7FP7SZIVqUDXXJY1PAhrF6WYj1pxP6f0VIlKP///n5eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(36756003)(81166007)(70586007)(426003)(47076005)(336012)(6636002)(110136005)(82310400005)(36860700001)(316002)(4326008)(8676002)(356005)(1076003)(26005)(508600001)(86362001)(186003)(5660300002)(40460700003)(83380400001)(7696005)(6666004)(16526019)(8936002)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:53:30.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3932360d-595d-4e7d-efe7-08da2281552d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
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

Prepare for the implementation of poison consumption handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++-----------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4bbed76b79c8..2d066cff70ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,12 +1515,44 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+static void ras_interrupt_poison_creation_handler(struct ras_manager *obj,
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
+		 * from the callback to update the error type/count, etc
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
+		ras_interrupt_poison_creation_handler(obj, &entry);
 	}
 }
 
-- 
2.35.1

