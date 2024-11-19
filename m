Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F1BD591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B8010E5CB;
	Tue, 19 Nov 2024 06:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcUnDdBC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4064E10E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5I8dveHT1CUhnaGIR9NQMtjxibOv6dLLDb1dgTYniNbZIbgP5Ca/Tkc09Vc/ZkqsiLK/QfgroeAfnB+olAukqqwyWUu9g1uDAROxshEtLDtRj0/7NwnY93I2U2Y2EZxqN0DiXxyEQXZD6x9XjXL20lI+2Vhpicd7UNmB+ZV6d8CUk3ptuUfTgYsN7mKH0uZJeLTe1jpnKWZwNVKdBtRZ9hjAiijtOzG9rVEWLgtdnsUtCiQIx87gOKjxjCK1JZcSyjSomNHsnUk6tDdLYIeiES6vDvQ4xPtIfbW0cc8g/dnCUJxlwQvtTIXG8gOcyq7nKGgFidShZL9zNKcZjbEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWlWF5rZQj1B7FN7nkpcGpqIxQngDHiy8LF2q6+bcqA=;
 b=uTlcM45iCFh+ue8cBSCqi1wpYyePdMc6t0o42hoT91teD0m/ZzYdUF1941YR+dT2YZHCQfEtttZHxp9gvQpGSvVXrEcv4dkPT3BLg4rYD76ehcIZg9Xv6toGIDc572sqRiGvqPy0KS/w71vAdHtRrsmMB9MqHxgRqhSuyw/wQ4WHnYu22Azz4GG444lJb8Qo8ur74uwJ7lvC7QCfo44t90qnzUASHsGMgvmCaiDVBA2NVyyP+1x8XrfqmL4LbsYUOgvzSC4Q6IF7OGARpmLBg1o8GHG5qPoaLxwGonYgM/uQyDXilU0UZUR0bl2RFwRwLTNYyjck9BHO50X4fEL4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWlWF5rZQj1B7FN7nkpcGpqIxQngDHiy8LF2q6+bcqA=;
 b=IcUnDdBC/ENxEEWyhoEZsMrglE4fYiokJuA4S4esl1FNeFK2y2kJti7wg5h3C3I6hQOWqzamzUlEzDXuvBOCigH3zZSITSEtD6PRY0cfxWZgr+yqmGEBpb2vrqhiN1ppDh9gIxWwwkGPNlLEkSVdfcYfN6HQyVWgI2f+ks7SZX0=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:36 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::81) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:36 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:32 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 09/21] drm/amdgpu: do RAS MCA2PA conversion in device init
 phase
Date: Tue, 19 Nov 2024 14:35:52 +0800
Message-ID: <20241119063604.81461-9-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: a5962fd8-3dad-4aa2-1434-08dd08648414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4D1ty3B6A/zXP+CzM+Dott+pPW9iRrjJWtUMPk1K/dErAX8Vlca5/cH8LRGV?=
 =?us-ascii?Q?TwXZf5SWsMsfebGhxgbV3DXL4xzCbRzF6rft4g0/vQ74dd55vpJk2sAjGFT4?=
 =?us-ascii?Q?ittvTrPBT5ZnsVu3bqzABUAoC9pzmOxUa/pBTfPUZcLUjhfu8AA+rXC1z/+5?=
 =?us-ascii?Q?nW7JNtZSVIzKv6ZoJrOpUtDGCRccjsWTBVSTpd0qxWP/+pgcltXtJDAmlJnQ?=
 =?us-ascii?Q?DD0ix2UeJ0ItpzE3+4L9HyKcLVr7t2TmbjS5cDECKJ3Hm7PZ5xq8WoWW9K1A?=
 =?us-ascii?Q?9u19YD1jBQxCqAG+XvlUNNVKQTdqiC4oMYngZzSnfGxoz7wmbjsrJ5vo+j8Y?=
 =?us-ascii?Q?JnNetWJoPchmWETAjCORKIZQepL+A91j78acHtVc1M0erG8C0jpzX3o4mPG9?=
 =?us-ascii?Q?Sv2Pj5GWzXz6ppTj3c3DDimyqarr24+p9b3s+8WS2xNQLl6/4fJbH3oMzc5f?=
 =?us-ascii?Q?ahYFQYtaTdQWFtocPSugtvhROpUxfTZMIK9VgGZxnp17ZyD/pAqmRKiORfXJ?=
 =?us-ascii?Q?dQy82+CxRQRaM5dQKVFIJblUMPZ2Od9Tfh9+eVMsn0odYVmMJvG2FJasHTYT?=
 =?us-ascii?Q?49Mg2wFCCT3GuUKIgyQCKr/IKPWqdIRdve7YGvoVt3vSq/9K2lSn4UnLlClW?=
 =?us-ascii?Q?0Ktn9i5ZeKHd6mF29drWfO6BIiNVO999yYIqEpXhoA4cCgU/E9P82LVuDReN?=
 =?us-ascii?Q?a0Zo+rreZWwg3LwZVeByz9hWyABv/i0GuI7bZEWAwnuqtd+6dTEqvz7Z3Woj?=
 =?us-ascii?Q?lHr/kaTNbeFr/g6xxFP0ga/wxNwlmh9rTpSIImEOE5Us4iJFv+HRQo4A0hk9?=
 =?us-ascii?Q?06uLqQCgkZNCeout0Vf0dfSfVBn0psJE4f7YYl4UgmN6zV58RgDLrFgj5Xpj?=
 =?us-ascii?Q?3h/XWfcD9I8MMaOVZ4bs4pDegma2HQbWdMFBFl5LMiG9yV5YwTCzL5ZcIkBH?=
 =?us-ascii?Q?Z4H4+aCbu5SuWiSc0c9TmmlpCELS3FUDcoFgoHgF/I98Ne0nqcmFxbLxbWz6?=
 =?us-ascii?Q?9ly5GHYASet2x7j2V+sj87P6eF5TqwKRUib4+c8Hm6T+5nEJ4fMJuRl13ZHL?=
 =?us-ascii?Q?o56mtTFPNbIrF8AJqv0YbvKXKL85kiR9fVrJbyCoH4BEFYTiZY9Ce/ZSoonx?=
 =?us-ascii?Q?iCx8Fvpi19GWBodapx2N2KLVpZTOr5ZlQa7WMqG0Kgn2WI9aMCE/e7zyHrYC?=
 =?us-ascii?Q?evEQnZ9A2qGwz6H3bHHmMGNQzIw+Qh9YFi887mHs2Qkvp4THQsI70QmbWfoZ?=
 =?us-ascii?Q?XYPMbbmkExeVp6f4E7Ql8EqFxknn2gJW2ij+NYjQ5lNdDTzEpSkS6SfHL4CE?=
 =?us-ascii?Q?1IbEPXnPl0KvhFNhGP/Obej2/hHsmtvf912Cw18URDqHN7RpYPgq/Ln+oR8a?=
 =?us-ascii?Q?P5EAQi5KBoq4I5qO7rP+5K8Q7imHCrTrEORxOHYLLKHYnEYM3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:36.0107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5962fd8-3dad-4aa2-1434-08dd08648414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
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

NPS mode is introduced, the value of memory physical address (PA)
related to a MCA address varies per nps mode. We need to rely on
MCA address and convert it into PA accroding to nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 97 ++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a529aec19527..f2018c3e96a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2664,40 +2664,113 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+			struct eeprom_table_record *bps,
+			struct ras_err_data *err_data)
+{
+	struct ta_ras_query_address_input addr_in;
+	uint32_t socket = 0;
+	int ret = 0;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		socket = adev->smuio.funcs->get_socket_id(adev);
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = bps->address;
+	addr_in.ma.socket_id = socket;
+	addr_in.ma.ch_inst = bps->mem_channel;
+	/* tell RAS TA the node instance is not used */
+	addr_in.ma.node_inst = TA_RAS_INV_NODE;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
+				&addr_in, NULL, false);
+
+	return ret;
+}
+
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
+	struct ras_err_data err_data;
+	struct eeprom_table_record *err_rec;
+	struct amdgpu_ras_eeprom_control *control =
+		&adev->psp.ras_context.ras->eeprom_control;
 	int ret = 0;
-	uint32_t i;
+	uint32_t i, j, loop_cnt = 1;
+	bool is_mca_add = true;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
 
+	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr) {
+		is_mca_add = false;
+	} else {
+		if ((pages > 1) &&
+		    (bps[0].address == bps[1].address) &&
+		    (bps[0].mem_channel == bps[1].mem_channel))
+			is_mca_add = false;
+	}
+
 	mutex_lock(&con->recovery_lock);
 	data = con->eh_data;
 	if (!data)
 		goto out;
 
-	for (i = 0; i < pages; i++) {
-		if (amdgpu_ras_check_bad_page_unlock(con,
-			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
-			continue;
-
-		if (!data->space_left &&
-			amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+	if (is_mca_add) {
+		err_data.err_addr =
+			kcalloc(adev->umc.retire_unit,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+		if(!err_data.err_addr) {
+			dev_warn(adev->dev, "Failed to alloc UMC error address record in "
+					"mca2pa conversion!\n");
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		amdgpu_ras_reserve_page(adev, bps[i].retired_page);
+		loop_cnt = adev->umc.retire_unit;
+	}
+
+	for (i = 0; i < pages; i++) {
+		if (is_mca_add) {
+			if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data))
+				goto free;
+
+			err_rec = err_data.err_addr;
+		} else {
+			err_rec = &bps[i];
+		}
+
+		for (j = 0; j < loop_cnt; j++) {
+			if (amdgpu_ras_check_bad_page_unlock(con,
+				err_rec[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+				continue;
+
+			if (!data->space_left &&
+			    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+				ret = -ENOMEM;
+				goto free;
+			}
+
+			amdgpu_ras_reserve_page(adev, err_rec[j].retired_page);
 
-		memcpy(&data->bps[data->count], &bps[i], sizeof(*data->bps));
-		data->count++;
-		data->space_left--;
+			memcpy(&data->bps[data->count], &(err_rec[j]),
+					sizeof(struct eeprom_table_record));
+			data->count++;
+			data->space_left--;
+		}
 	}
+
+free:
+	if (is_mca_add)
+		kfree(err_data.err_addr);
 out:
 	mutex_unlock(&con->recovery_lock);
 
-- 
2.34.1

