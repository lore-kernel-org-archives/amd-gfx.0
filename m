Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08B2CCFA13
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B60410E69C;
	Wed,  5 Nov 2025 02:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dH/ZVvrL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957B810E69A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXipCmjfsnFlxaY4mNkUEvXtbqyvi81vuhOX07+DlE7E0FXfH+WjktEU+A8iyYPUJhjwB4WvLUrWUpbxP/TLz4qYvbGZ1iV+238jHdx09A0w+BX4mGa3USHjiKRNFMFnLCNADz2k5QIAhkazaCw5xvTyM6olOvEQ+PEdPk+q8RIJTLrBjjLfQ6qiTDePPcVLoB9+Jy72d4rnZIqLLDsVRZ635dV+lDFJsmIVJJ9TbcBT2sr6ph2NfQIOdSeC2zzyRe3s3IutsipVNjMrTXexO08KhdJxa54Pw8mzO79IrHziDRrbjn4BTyOvvDkapiA+62g1kyIdXpYFooj1MQPq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euzZDFNTYWqD0pJZ+xvKmD6f75bNR8QNuekp+eRoGwE=;
 b=eZF6ER6lfMqFn/uLek3xnXcBZEOIQ50UiUZf6NX1+JnAdrnS4Sal2JWNW6TIslJpP8c4PcK9IKIpxzHLD4AMEwgWuk6wBmclvt3rOsPOxcI5GD+cPkrApde7weSHbt8HHCv/FiEBHJLmTfYTBc2n9yxBa147wW2sOBupOFfP89q0KmxxRqVfVGzRr7dj8HgUybuprL5cZ/ajmaPcCYpRDhGRrJo2pUm7yIRg9uPD+QckhTA/gc9mp8AvoBIhaGfhR42fi88bPwrpkvCa2iDhvw5i4KNtesTjnRCWeoL6M5zBnHjlQaJton/Z+Wqk40nzcjxUj0/ScnWImXc4r/6lZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euzZDFNTYWqD0pJZ+xvKmD6f75bNR8QNuekp+eRoGwE=;
 b=dH/ZVvrLsjhQV9YDbXO/57reXyF+Bqs9T8ulfN/lOjfkoiQke04ekoUDcuERbIS8SYxcqsjY/H6HAdVcj4OKSP8z6ZLHOj/bST4O8Jdg+7yixPUvSTs5Pf8kZO3ynaBwxh0D2/lQDtci9ROI4gnXQ/bUYB2b5wocYu2dBH5xoAI=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 02:05:02 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::6c) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 02:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:05:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:04:57 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: skip writing eeprom when PMFW manages RAS data
Date: Wed, 5 Nov 2025 10:04:41 +0800
Message-ID: <20251105020445.1423034-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bdaad2-d4ce-4551-cf25-08de1c0fbad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BZ7jpyt0JoiBwgItmSRqib7BXA/HUmeKk2HOoTYN7lv36h9jXU0Y0BLM3+cj?=
 =?us-ascii?Q?HqlqJsfEATlcb1PzjuKkwNUVsvDfx88bGQdbNh0ffp0WeE4+Qn1rq59X8GvV?=
 =?us-ascii?Q?XwuebcpvlUNt3rxHI4r6/8AxII10msANhWFAjt/Ja4QDkvd4q5yGz3q45r+Q?=
 =?us-ascii?Q?dSToOJPRNLXWRutSz1e1k7UEFwuix+JzL4EwdM7mr0BAOP+dSyZ97ukOppKU?=
 =?us-ascii?Q?POZT/a7JqGKdx8fFZE3Mcam+fpo/JJU+9fsT39FK9/OC3yUFmRH929PccC/F?=
 =?us-ascii?Q?XY6os86OPE7qjKHF8fZMtyyRJY75C4f6bNV4EQ5jvOy4z+p1wc6zrZIBsNV9?=
 =?us-ascii?Q?dYiS66IrEL8Nrmcd4JSkapoM/qHS7zqnig67JgzMDyO/OUy74iNd2kFba2US?=
 =?us-ascii?Q?uCZiniNwIdXpwhyD78ZnB5d1UvWWBxzn7NTQRp7d4QAheNW/zPiJVwaduN1o?=
 =?us-ascii?Q?mwQFwErRy++oqrj9bfnwSxDWbvwEhda0qMn5pdlEc0r+nFs9k+h3v3VTBlyg?=
 =?us-ascii?Q?K89iyAklOwQWyX2sWPnkHGf4xn39f45o0lHfb+x7e7qJ3KCdP5ugQg1Yqatw?=
 =?us-ascii?Q?/sLQ15Q36+Eu18IaW104ceZLJjylMIGVxK8Qk6pLJmCQAwKORJQUZ7zxS86s?=
 =?us-ascii?Q?1aeY0BDIiYAC/amhv7b8DS6lMhgW1C2CVC80BxmLLMJ9owAGdpsBhK02gE++?=
 =?us-ascii?Q?SrlYXKYKKBl/UM7fzOnzyELq3jG65LR18tZYRo/ONkBBGJmT/SIW+6rMZFzm?=
 =?us-ascii?Q?em75KjOlThb4kRFph95OmaSKt38r5odif4vbLTzjGW2bR2MmMY7d979T+aTW?=
 =?us-ascii?Q?OtJ3L1+EalQT/OrN46I339Ebrv3StSoJzgObtBK0fyRHWRd3iqt9buDWIeKn?=
 =?us-ascii?Q?CSxqAmLQBFazxUpdmyNoTshq1Abmp/t2uhPbqMywXZdFgHH36JiwzDH4MK9P?=
 =?us-ascii?Q?kE+EOgFB3G2wQp09AObWKvIoj3jOPpldZyR0sTiFloNK2lIJcK/LtZj+qyuZ?=
 =?us-ascii?Q?9+Ozh1E26ydvMRSAbd3OiVjNPxby+pDPtsHOJq6FFe6PkthBOiAFuu40e78J?=
 =?us-ascii?Q?Gs89paLQFb4A2K/gm4ClrCIeaoJo23OQWKPqWX47DBlHMshx4yRq2HBO3hwQ?=
 =?us-ascii?Q?ILFX/rDJFBKcBEo39/q6q8a05y7vQjvu2ONHDzxAr9cYSZjq6LZXogJZi4sq?=
 =?us-ascii?Q?dwOBedcO+aWwSAZTbATJGuBCkJkrh67aj/yE183C3PIcExGlWm1COGoVexvM?=
 =?us-ascii?Q?3g8T5mYATLOpY9FEZmXLTbpTBatyQyKLjRguGujv6bYsbBxJduv5cB46VVLV?=
 =?us-ascii?Q?NpnZGebSx6hi8r6AoHODxORaUiIMwRdO+1xr0KpSOGlJGoZvtcubIwIeBiRO?=
 =?us-ascii?Q?7XU33+H55DWXVvmm4hynrXgB2ZXq8+gagvsyNKv1lBVl4NczoIdK4J8U3HoG?=
 =?us-ascii?Q?SMLznwl0ZS8Yc5s28OiHIEbJG2pZCg6WYTeangLVPcqcvlMaKyj9dcOUgU7X?=
 =?us-ascii?Q?rTw2YtQ5pmMQ+VLWoVxJXEivxWf8BNSZ9Vh4E9PSQOUxFf/8irFKMaNslSup?=
 =?us-ascii?Q?L4h3KvYVcnhMdp8XlYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:05:01.6641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bdaad2-d4ce-4551-cf25-08de1c0fbad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

Only update bad page number in legacy eeprom write path.

v2: add null pointer check for con.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 47f292557a0c..64c004a2b767 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -871,6 +871,18 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_recs_old = control->ras_num_recs;
+	return amdgpu_ras_smu_get_badpage_count(adev,
+			&(control->ras_num_recs), 12);
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -889,12 +901,18 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !con)
 		return 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev)) {
+		control->ras_num_bad_pages = con->bad_page_num;
+		return 0;
+	}
+
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index e881007f715b..2e5d63957e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,6 +82,7 @@ struct amdgpu_ras_eeprom_control {
 	/* Number of records in the table.
 	 */
 	u32 ras_num_recs;
+	u32 ras_num_recs_old;
 
 	/* the bad page number is ras_num_recs or
 	 * ras_num_recs * umc.retire_unit
@@ -190,6 +191,8 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

