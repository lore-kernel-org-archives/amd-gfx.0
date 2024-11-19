Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63363D591D3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E969310E5CC;
	Tue, 19 Nov 2024 06:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUxGKuFE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF0510E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaU46Ku1qK49NOp0EbmFlmPl1bHTdTOK9vOCGxLZqkLiUnJRc3rYynC0fgYwZTWlY+rhsJYgLtjeIgKydAb81YNBqbrzePgmYZ6eV9roAaspuIuYnClcV6rq9q49LJLlx/rL8iM8c842y/8iY07sNq9RDMG1sRv2d8ycF9BzzJcJPjAIUIuIbx8R58io85S9OJVvFcuvtI8IsB/RSvf0HXvQa1EGuSzRTcUPUXXGR1ctzfXfyEKm5r9WTqMlTkS2/Eb99ho4IKeqEpiKD5nwR7trZ7FtHzt81Mwk3L7fhoJDcfVWQfvbp/XLBZXbbz2bRD7wHvVJxoY/5eRfyqJTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pC6vhtgBKsyctprreikO/kb26WmpnSO0A9R0b9ezB4=;
 b=ber3e6C8JHP8OxVRBy/6Ne7go0Fb9roQOr73GClCGH7o4flMlfQSzXGp0YFUEwE7bZkvnkm2aQ5CA6nUT8KGtSjUPEmlfzQJxCquAcb+26++2sFkp8Ek/34suCbmcTyvn3lqJoFzA6KSXNxX2Kvwp7CACbaIfmd+2JJ7X3tZEgCrdpxXkp0ZnW46BAZog3x7bzRrlsJi5cJx0YI79xjm6lq5SuROTPwxNpiLjwqN7vJMCYyjFieRtxyJJb9TKtCmp5fUE4e+R2nqHGA+AOibeOzdd2auq9j1YXcOQOhOxhgyhe4uG//Axvno4YvmhPCMrQS2LRUK4x92umi9GdIy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pC6vhtgBKsyctprreikO/kb26WmpnSO0A9R0b9ezB4=;
 b=nUxGKuFEgeGGLPUsRbSMBiT40Ar7POsKPBIW3TTs2QIT+Hi/aVQz09VVQ/4XURG8TJdFa1OLro5WBOWNPN+FQce/qq8/tjC4rBOIpfmU4cvDOwtKdDTCAzalpF1BMT7iz6fgFXGFD9UTgKycz6XHSz3mOFecmNnUl16DJDUiueo=
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:35 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::28) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:35 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:30 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 08/21] drm/amdgpu: add flag to indicate the type of RAS eeprom
 record
Date: Tue, 19 Nov 2024 14:35:51 +0800
Message-ID: <20241119063604.81461-8-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: f12c8278-8784-42fa-06c7-08dd08648385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ew6SvEgZL4fazo8fbAyJgjX5qUP/1a+1hsnLIQRGkEB1qWFosEvR+j74XlZH?=
 =?us-ascii?Q?fFMBB/T1Cfmk1sutQrDTE5QqGZVGdc51ZkMrG1ZtXB/km7b+Txx7SZW9NB9k?=
 =?us-ascii?Q?ntK3Jfwmu2sDv6IeMC2EC1DJkCChzoJ/1pSgxtt7kO1Cl8pJIYcAgBIc5l71?=
 =?us-ascii?Q?YWO4iNofRvfw3ZQkuNFSg6X09QtcwHNy53d1Mnwuw3+sh9ik/1eJ50zUK/bY?=
 =?us-ascii?Q?BSkR+P7EnsplUjGL3uhMnH9ZlHdLqWRg6QcIi+cBoSRedecF/zXtZTmcoNt/?=
 =?us-ascii?Q?fY3WP5UQVjCyV1xXqBNCfHmOULjuXzjjqXy8U/Pc0dWlChSykLrXdCZWMiBs?=
 =?us-ascii?Q?dIGKng6cnJfv+aamqRmSovqaf+k/Nl6nfBzYj8yEpvv4pkCMnoFQexGjvd1s?=
 =?us-ascii?Q?yfSrjxzWd1iLIdwWCEaTbWBHBmqkWz/Y0elyg3g5ULy/Mb7VplLguVtZUGWB?=
 =?us-ascii?Q?Vse7CvGa1oQe9mof2VbXgxyjxt8rCUuBkhFbMyeq1Vw7P1c+TsFbIn5bhM1q?=
 =?us-ascii?Q?ON4D1OrtxVHgQctt6ngv76jy9VxluMDiAUZlpWu8AGNBBjctb+9uEm4ZHZE5?=
 =?us-ascii?Q?gCAUx5cW5ROV2GM2fE6mpk3y8fR8/NIZ7nbSLrqSz87dfsKRzP9rO9BZSOES?=
 =?us-ascii?Q?yoUZ5ExoTg1k4uwoudfXlfjdQMsOxT99C61xQcFj8zx110A4Qqmex9NZZ5HO?=
 =?us-ascii?Q?QNPJN8k4Rwt6I+4wmwnXnfNeqUKBwoKb4DUs76dIondEySi8RiP2NcfEftq5?=
 =?us-ascii?Q?ptXZHS3Jgtinmo/cKW8STEs4Fb5kWPiqFOZjstqyID9RV0eH8rd8/X5E7yBh?=
 =?us-ascii?Q?dVDmHj7D6hOkM8ZrUGSiuGchGITQby6XKaIS2R4/pzpHYv59cuVD+O5SudoB?=
 =?us-ascii?Q?kOJn5NNaEvT/uiMhsws0kw2CaDvjNc5G+xSvRHj1CPyYu6m8xMf32OIhXpVL?=
 =?us-ascii?Q?Cn2eQKwnkOJy8NxlEaNsAjRDP3Gv/5t22+esFPitYfkSrIoiSc4CkF/JCGJb?=
 =?us-ascii?Q?46IHY/n4ZFNrf2QsNOmCG3qicLCs7lFk17xSHq60VIu3pQxmMbYSwPpxVSgo?=
 =?us-ascii?Q?2a7hguAUl/0ZzpcZQZU55Mutrv5mjX/KO1FS0ZUH7HV2vXJHA7xAJ1FrDzFW?=
 =?us-ascii?Q?6+T/sJJQ7IIegKD2ypcYpMX4iGol1mGbYmH0dwr1HfyR2FrvbToM5opS6IWO?=
 =?us-ascii?Q?ivRZk3greeRDHejvVRSLKPz6qZwaCIUW0bqFeQ3gdIRINZDA604+2eUd/vNa?=
 =?us-ascii?Q?VMrC+rsAabodzdTu2PFMWOaxRPQPUcFHOejYic7x9I/wFY8Rti4NS1AAjgR2?=
 =?us-ascii?Q?NkKmUbb0pA2PmxnyF0Z8mno5xRo0JoVaYNI2uh1wSY2Eo/8BPf12q8jqNxZl?=
 =?us-ascii?Q?K1V/ZzdAwT+18qe2p4yQuaWETH251vMq4OBSQEs8F0ipDOIUPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:35.1044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12c8278-8784-42fa-06c7-08dd08648385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

One UMC MCA address could map to multiply physical address (PA):

AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address, PA
is not cared about

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 33 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 14 ++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6de61e7b4256..a529aec19527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2768,10 +2768,20 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	ret = amdgpu_ras_eeprom_read(control, bps, control->ras_num_recs);
-	if (ret)
+	if (ret) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
-	else
+	} else {
+		if (control->ras_num_recs > 1 &&
+		    adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+			if ((bps[0].address == bps[1].address) &&
+			    (bps[0].mem_channel == bps[1].mem_channel))
+				control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
+			else
+				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		}
+
 		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs);
+	}
 
 	kfree(bps);
 	return ret;
@@ -3160,13 +3170,14 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control;
 	int ret;
 
 	if (!con || amdgpu_sriov_vf(adev))
 		return 0;
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-
+	control = &con->eeprom_control;
+	ret = amdgpu_ras_eeprom_init(control);
 	if (ret)
 		return ret;
 
@@ -3174,17 +3185,25 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (amdgpu_ras_is_rma(adev))
 		return -EHWPOISON;
 
-	if (con->eeprom_control.ras_num_recs) {
+	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
+		control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
+
+	/* default status is MCA storage */
+	if (control->ras_num_recs <= 1 &&
+	    adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+
+	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
 			return ret;
 
 		amdgpu_dpm_send_hbm_bad_pages_num(
-			adev, con->eeprom_control.ras_num_recs);
+			adev, control->ras_num_recs);
 
 		if (con->update_channel_flag == true) {
 			amdgpu_dpm_send_hbm_bad_channel_flag(
-				adev, con->eeprom_control.bad_channel_bitmap);
+				adev, control->bad_channel_bitmap);
 			con->update_channel_flag = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b9ebda577797..d3a6f7205a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -43,6 +43,19 @@ enum amdgpu_ras_eeprom_err_type {
 	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
+/*
+ * one UMC MCA address could map to multiply physical address (PA),
+ * such as 1:16, we use eeprom_table_record.address to store MCA
+ * address and use eeprom_table_record.retired_page to save PA.
+ *
+ * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
+ * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
+ */
+enum amdgpu_ras_eeprom_rec_type {
+	AMDGPU_RAS_EEPROM_REC_PA,
+	AMDGPU_RAS_EEPROM_REC_MCA,
+};
+
 struct amdgpu_ras_eeprom_table_header {
 	uint32_t header;
 	uint32_t version;
@@ -102,6 +115,7 @@ struct amdgpu_ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
+	enum amdgpu_ras_eeprom_rec_type rec_type;
 };
 
 /*
-- 
2.34.1

