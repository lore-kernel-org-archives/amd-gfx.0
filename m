Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8611C6FA86
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 09:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8222C10E7DA;
	Fri, 23 Sep 2022 09:21:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067B710E7D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 09:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey2Z/imkvCBVlONP7JrWSXK/CTBhf+iP8qpSf6Fs6Xrvgf19BFtOoSDy1cVbKSpe/R2f/AaLNncgGTbXBGMAfyk5ZiqIoDJjIqpUXDRved7XAsKnI7dxmVeHiI0aOjtNWM9XHc7L67ljxbSr9/6YnRyADeT3z8rtdEf5q7xyJHABsVCo5hCFV1YkHaHzeHOne8SUMdkLjgN//cudzgKVHdde3hukrGRGdBZ94bYTsqZDN3XgO1pJ5xHoIJq2GkFfMQBoog0CZf8S9ru0QaOZLDbiugJQGwaQZOiVxJU9/x19DAeFq/td1Ng3Hx3xm3m/gigXJsuZtj/Wemxa0YJQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FOGeCEUORZV16EpPLgF4KsNkM90Q98mGPkL1f/64Ps=;
 b=cRrzlndW++BaGra8DnJ7jVFtN4ykZaUe/BMyLajccxYL/JY+vM1z7y3lUveOo2Q8VpxgDXmH2/D9inwKhEZz/ElE2MET+bf8e5MiaxcsoiN3buWVa2XYPbuhpJ0RaDLq6RNa4jCA/apHu/1XDidg1DTerSgXlcwfuvM9VpXjljfNTfiDRFlCEvc1o2JOX4Wx42ezl2RHRh9PjM9rv9t8UMWzPuX5pS4YGWEA6qlVMeK/SiqXOOH3agRPXxfttlpAO7Ig80wmMG7YBE2Wq0P9Ofxem5d32DBiMSWK+IPaxa8WrbDsODWJEcSznmUoubbmbV38kCHZYraqzmijcn+9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FOGeCEUORZV16EpPLgF4KsNkM90Q98mGPkL1f/64Ps=;
 b=KvtVOytIjWdEg/KsQoLjvwERbMZ58bJCC/U4cISSh8/9Fh1IecDnPe4fkygYRW1pnvX81VwQxYalK66ssxOm2PoGk/KK9HeUx5XsxmnGNF0VC6/V+07ferIpjQySZscpP9QvLgPqWgjjymMz62icXRKurA2MGEsYAGfJqzsXL8c=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 09:21:29 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::b8) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 09:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 09:21:28 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 04:21:25 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: use RAS error address query api in mca
 notifier
Date: Fri, 23 Sep 2022 17:21:11 +0800
Message-ID: <20220923092112.14141-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220923092112.14141-1-tao.zhou1@amd.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: fa97b1f6-ce2c-4e40-3b11-08da9d44ff15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6UJkxBKstUSFdBc0yFKKN3W9zfxxjQjvesZq8BRiMMBfWomEZ2+H/RTxBLZyyxLoNSrH/THJIzmZk7ZKdWIBxsDLVDArmL9+LaSQE0G28tt3q9v9+KTVOxzm+OdYy/3qmdFAguonWmCRwy0z+wNX0waVnzUA2I/fV3Af4RjQxJbNxB3WufqSuX3Txq0YHUF+zB3hSYqAFSzzY6N5IQAdlQnPdB8LkwJUlo7a0Ttj4iz7mRwg7+HAqN1dJ3BkfP7AVP5i6VQ+c7D8pfG2wDH248/Q8QLtMgnURuwXdb+abAoKKlgQeMoISvr7VcvXFzxLPDBd3YSc+rRQ9zWk+3aQN4MymbHHkFUFQAP0TbTquPMbJLd5GdH/YKBBYqL7alVCLTdiqhciKAwA15/heqHQkuDij45JZo/Kos66X944LjgIzjLCFeGVK0bYt5Rbfqz71lM7gOrZFhlDi1N2LyyTIAhwdyLnDTYkNX7VhBl+kgHC9VYFnAIVgMQ5tQ58jFsXrtxS0g2uFtaIwgk02RVf7kZBSWnbo2PDHVfCa0THy5RfjESeADPuw5lFm2NwmXbwUERcUN2wnQ+p8esHXyWkQ/NfCJJcnzz5VGru2cDHQyXe3BlqjYOCHUq4T2K2sMgYSQ94eNhvs9V0h8Zk1rOP0P7SJdxg4vA2GmbytslABWtz1vHFqfsDztLX9/lUZ1PP0pHvMB11Imue4I4C7m5VvD0F2MkDgGxIj4vJQMo56oLQLS8teTRPQi5p6wZ88yjNkXKAll6S//0VxbROg+xbOqkK3suxBd8Qf7gPWpwO7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(82310400005)(36756003)(316002)(70586007)(26005)(47076005)(83380400001)(4326008)(40480700001)(82740400003)(6636002)(2906002)(5660300002)(110136005)(86362001)(8936002)(8676002)(41300700001)(70206006)(426003)(16526019)(356005)(186003)(336012)(81166007)(2616005)(478600001)(40460700003)(36860700001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:21:28.6765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa97b1f6-ce2c-4e40-3b11-08da9d44ff15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

Use the query interface to simplify code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 ++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3deb716710e6..ae2248340ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2834,11 +2834,8 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	struct mce *m = (struct mce *)data;
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
-	uint32_t umc_inst = 0;
-	uint32_t ch_inst, channel_index = 0;
+	uint32_t umc_inst = 0, ch_inst = 0;
 	struct ras_err_data err_data = {0, 0, 0, NULL};
-	struct eeprom_table_record err_rec;
-	uint64_t retired_page;
 
 	/*
 	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
@@ -2877,21 +2874,22 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
 			     umc_inst, ch_inst);
 
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if(!err_data.err_addr) {
+		dev_warn(adev->dev, "Failed to alloc memory for "
+				"umc error address record in mca notifier!\n");
+		return NOTIFY_DONE;
+	}
+
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num
-					  + ch_inst];
-
-	retired_page = ADDR_OF_8KB_BLOCK(m->addr) |
-			ADDR_OF_256B_BLOCK(channel_index) |
-			OFFSET_IN_256B_BLOCK(m->addr);
-
-	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
-	err_data.err_addr = &err_rec;
-	amdgpu_umc_fill_error_record(&err_data, m->addr,
-			retired_page, channel_index, umc_inst);
+	if (adev->umc.ras &&
+	    adev->umc.ras->query_error_address_per_channel)
+		adev->umc.ras->query_error_address_per_channel(adev,
+			&err_data, 0, ch_inst, umc_inst, m->addr);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
@@ -2899,6 +2897,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 		amdgpu_ras_save_bad_pages(adev);
 	}
 
+	kfree(err_data.err_addr);
 	return NOTIFY_OK;
 }
 
-- 
2.35.1

