Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F8ACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E2F10E572;
	Mon, 22 Jun 2026 08:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KmFZHcnI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15BC10E572
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKftqLnweHbUtAxaQQPJYhC+lDhqsBXAgBUMyuSag4SD5K98rcPusYO4uAYvRyovJennDjjR+DviOcICMCnbzOsswXOjYcI4TETQTWKAOFm1MLOn94bgeVMjjhuGDREoPstJilOZ2Bsg8VQjdqR0gyAwcKJ75rJIzYfC18GW/2Whe7tD7a45H89/ayBJOoecZj4168PXC8zhjOUdueRNuOX9SITvvOINlGs6e164Y5SfnOo7kZlz2eO6bBAMetlNoIb/MuvyilWh5yA7lVUnFeFGTmM+X4/vZNIM7hrS/Ipamotjhb4bepzjZl5fW1vBCacghuVWabTfcXVOSPOWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=siIxPMP5jZXVDqhihGuCv0XhiXXYQUYYEBwWgH1tpEOvt7jRbQuMxp3KrZaGfpVHouJmDZfZ9B0Ppv/2ETcSDGFlQSlExGKuXAZkdX5EkSxD7TDI5s43YvqcSEE8h2t2NYJAAAw7H3A2BA26w9+yDfAdLRt1HUlDmHOjPJFeHBb9vbXa8yQ+IkrM3fEEtAQKekjjVqBp9KpCUBYhouUlqGNVUrpK1pj7+i/4v+I7jFvItSM0iDPwYD6+T7K890v4Mdda6VKM0j1tjYSQf3rMdj7badwwg1dCuzGx2yDROSqO06vYiRzegDpOGRbdCzzRUSfJZDDpiYEeNpgKSCWb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu2riU0nOC+yL2Auw38ntJINvlj7M8B6Je+X6w0AnY0=;
 b=KmFZHcnIs72IhmYr582YjCuHtAxFA9KVTxsa/oMQI8Dv2KxpsS6BBpFa2LERcO5wwAeTwDXroNd5ptFKaHhSF0Xlf7xzTQ709JKt7R6c6PB5CPfI/aivpN59fZGR8gCHLQ/8Q1o4s5Gu/x6EzgJx8DjUdUTSv6RZc47txEX8aaU=
Received: from PH8P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::25)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:10 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::a2) by PH8P223CA0029.outlook.office365.com
 (2603:10b6:510:2db::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:09 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:06 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 30/48] drm/amdgpu: retire legacy PMFW eeprom RAS bad page
 handling
Date: Mon, 22 Jun 2026 16:44:32 +0800
Message-ID: <350aae2f3af1d45117b7df6b3dce49812ef293dd.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c83e27-e1b8-4c9d-2ac4-08ded03ab526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5FrhAYUPjEfQFZeHoFK0q9xaGwPI/epbv3STp8vPB0Okl4dNmGGvzagVV5WPwBrH39+gtY0IdDNw1GhkT/GgZNAL2XtNeyeTsMwChUfz/tqaHK+tzNfdkY2ODOywfrFx3MzBoDMGAiU1eLEsKqHvWt1e88BDYOMLEDgnfx1p79ZHmc6BTSubcrUNLroIkZe0QGUKeTKeQ5U39dB8ee/fOVTIaAPa9RsjM6wZNFJQFIvRxUYb33ZrenKUM/Krw31FZtAUonTQFSogPdorKvzy8QY0+9weWck5NSTX00QhyI8NdSGzu9e0wIIyV0G0guucX3aM70RQMVxKruFeO/ElfRbgbWAvElX320o2RVmADH6IJsGg3SCEMwtttOlDk7TcDpsb9NuyWe5YIvYSKhXW1Qgu+CiSqsrAQE0rXIwYPxc250E2auEgffHczBmLauqD4dADddmz+JKHcxDzKgBEuOFVmvB8lKZmIQGMfS6s87Zq8I+EsDo+eQiQ0zNG8nN8IPU2OPFtd9U9KBXbXd4cS3OxvolhaYroIOe60z05+8XYteUFuR9fn+2UkReubm9kLMYZJtDPSBqvSs6WlGbQ7ukfeg2mhbaXZ4/KA080zcl3QeTVlRKVhGyvZ5OHGEWp3bEjJ/kwFEPP+oWy14JGAnhp8GPQaoygEAMv9tubJtgcEq0l7NP/kVwp2xQo0cXods9c2dYP0F7bGcu3/L2KHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 33hJF8sy5v91oi0L4GIfrdygtpACr2msKIOESR2gMg7NRxv8nQN4c67I/I2oIjz7JfFoIAoWakfr2XpsEzPguFKM+9E3kSRPD44ddJsRDsAFo1XQyip/G2XmX1diQSP0fc2ZyIPDRIWDlOvlDecNRqEb9fpqRUOufsf+YgZMuuv7zaMAE7kbtiEVoGJ11aErAppRzk6+irIl/xImFetVHF1vxeNmnZJ36kOxWShsU7EUmTKafyiSyJLYgGz1Y8B/eHh7p5/1OPo0dvwlMf0oco6wqelsV4qWtXOF8glLYD/PKwKNh7OhJUUwJ/1elrEvSHbtBQnXrRiI0k5DRYp1ogEaRoUZwxKb1e4q005sWaG4R4Ta7YGDZQv5+T4Q25tpDzN8qBSw4w0fGwyFL/v9ENj/Hdl6H7hgaEdACXjVubvGijmBogElyfMYFco7wCBI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:09.8175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c83e27-e1b8-4c9d-2ac4-08ded03ab526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
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

retire legacy PMFW eeprom RAS bad page handling

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 33 ++-----------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 292d76021644..d28e8958b0ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -916,33 +916,6 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
-static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev) || !con)
-		return 0;
-
-	control->ras_num_bad_pages = con->bad_page_num;
-
-	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
-		dev_warn(adev->dev,
-			"Saved bad pages %d reaches threshold value %d\n",
-			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
-
-		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
-			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
-
-		if ((amdgpu_bad_page_threshold != -1) &&
-		    (amdgpu_bad_page_threshold != -2))
-			con->is_rma = true;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -961,15 +934,13 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !con)
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_append(control);
-
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
-- 
2.34.1

