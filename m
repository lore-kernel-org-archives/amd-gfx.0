Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ADDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 06:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEAE10E5A9;
	Fri, 14 Jan 2022 06:54:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2C910E596
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlUwfqU+NhcdZSForHGxLcO/hLCkGF9r414WCUY4h9XvgDVCjDliovDvPQ8A464XH7fTJPsRAnfv5JZy512dfiqNbeOjaUqqskbAgQpfdvcnDwq1Zv853Xc4QlvReDuDmyS9xn4gQyPsnQD/vh5zzfwHmPTNN9DYRARfDtZU+vp2cS9Ro6oM9nMCHCJVnlzhoqRjyzWOgdVyZ3lQ38JClnfWI1UYfPb0CESYgRXgjlVzQOS/zvSG13450lLUPePP29Vbx/MASOjBuQn1eUWcifHK83kdkFgXJOVTAXNErSuCE3kuGvo1DSaMCzBAQfE06oPYgtCPJLo8ZOvRQADDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUhu0nGc5kyk6TCMW87xhwtUrCN5A4EdFvTgN8BHYak=;
 b=G1sl95pfvXaAKu1LrTn8axPxJ1XRUy/5hn1qvPKr+svW7hSDuGOuyiGb5BISXeBlUDL7M3chOZx37BKgjUILPRrlsRnLPdkP6WHYarRVh6VxJU+7y6mo0pPHLodaUxZdRbtl5hnw1Fu3T5rbW062t2KVesiUJyTLNNBLTGKJgU47a9m4fdku/4VHQoD4QZkX2rBC659WtfwEjH1mnvicZ/huUNJQ3BPpptgYk8XeDiNJmEtl2/aAEj1emwE51H4gsrk431UudMUUCANpqANczbPjxJx6OX8ucAszdq6lnPz5BnAOamjnqEj7EQ+eqcjEBXs5TB9XAm0oNlnJnWnzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUhu0nGc5kyk6TCMW87xhwtUrCN5A4EdFvTgN8BHYak=;
 b=aUv9KCV3i7DqmOXjR4/TM8w1AkERo6oDPDXSrVwW4+tdwX8x8YiVCPRIns24pQ+5maAZzsgd5Aj9CssEB7R8cce63CKh4CGH2iQmHjtUCRE9+jlh2TRD1d/o/WAKSjijRLjYfMTGUO+0cQynDLKhfbb3TkdDN6xZBSeKWiXL06M=
Received: from BN6PR19CA0115.namprd19.prod.outlook.com (2603:10b6:404:a0::29)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Fri, 14 Jan 2022 06:54:46 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::15) by BN6PR19CA0115.outlook.office365.com
 (2603:10b6:404:a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 06:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 06:54:45 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 00:54:43 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Date: Fri, 14 Jan 2022 14:54:19 +0800
Message-ID: <20220114065418.130056-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9192dbc1-bfc2-4163-a5b1-08d9d72abfe7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB549466BCE9B6D38192EEE1B2B7549@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vOhP0w4A5yrCfLu+nNX0QG1pe+9yjSIFIg4vwIs9rbKcEUpVPrjRWMLYe/Wx5N6WuH2i0KkuldQj7HOrLhkcbnMuvpaZWx/tDuLUXVmwJJEVhY/Okz1FRCKG+TCjbUkFvb1S3+OmxO+ChKx2VlZ6+BsZH9+QEqo16lXBTjDfbl2ghk2/Y6SbMCVe6z3rubvzGeFPmW6IQopC/AR9CHArha/GSxKC7VCgMqU8vjTPIzyGn7Qx7COKq4iRy1o+WRxF6o1VTCezsGcNPyu2bmuuHxi4uDQSg9E1LLio+XaqogW0VO6P/OJVLXD/gwLbxxOpQCZkpAlLqMzwYDLzkeFzzoO+21I8zAtd6wFtNsoIByzuLZthlzEyNrxijoFtIvLkQ1kE4FZdbHKr0arrXA07qCQF0XHNOPohsjb7aFXtA/5m78vpEm0dxy8KIgUIju35+s3SJSiDNIQPm0M9ZYJKX32+dMu8nq5l1X2gtznrhMcTj0Hrx45hjw6CVeWxOVdcBpsNYgvYZ5sj2fEI72MfQ3P5mxsA4tYEWXx4cpNzX/UMvVzxhbiPo8T/jKnUW/RZY8Ar+YJ6hVpVcEMfyzNxFni96uPjYLibZsNycTiB6XFQckma5NkfFedy4/0RwEijLnqxqvoW0s+YUg1/QY5b95Z0DY5BRx90brf/YA9o3ZgIdvvqNj+WXqJmPzocmYOJnxmtI72UNA5V1sqeJdjey7JxRE2ycLoFsM6vzTYLGxBHgwQsUW7eUlJUacalSC+YxuwhVCjgV/GGRX4AQ4MnqLdHvmDqZk4cJ9FXpsp7qk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(83380400001)(40460700001)(86362001)(356005)(70586007)(508600001)(54906003)(316002)(70206006)(8936002)(82310400004)(8676002)(81166007)(6916009)(7696005)(36756003)(186003)(36860700001)(4326008)(16526019)(426003)(2616005)(336012)(47076005)(2906002)(6666004)(5660300002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 06:54:45.7394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9192dbc1-bfc2-4163-a5b1-08d9d72abfe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
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
Cc: horace.chen@amd.com, victor.skvortsov@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc
sw_init. patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to
set the right base in the right sequence.

v2:
call amdgpu_virt_init_data_exchange after gmc sw_init to make data
exchange workqueue run

v3:
clean up the code logic

v4:
add some comment and make the code more readable

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da3348fa7b0e..5610eae8ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,7 +2353,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_data_exchange(adev);
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 894444ab0032..07bc0f504713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,20 +625,20 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->bios != NULL) {
-		adev->virt.vf2pf_update_interval_ms = 2000;
+	if (adev->mman.fw_vram_usage_va != NULL) {
+		/* go through this logic in ip_init and reset to init workqueue*/
+		amdgpu_virt_exchange_data(adev);
 
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
+	} else if (adev->bios != NULL) {
+		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
 
 		amdgpu_virt_read_pf2vf_data(adev);
 	}
-
-	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-	}
 }
 
 
@@ -674,12 +674,6 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 				if (adev->virt.ras_init_done)
 					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 			}
-	} else if (adev->bios != NULL) {
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
 	}
 }
 
-- 
2.30.2

