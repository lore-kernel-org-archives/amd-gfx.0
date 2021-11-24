Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6561C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 04:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F144E6EA96;
	Wed, 24 Nov 2021 04:37:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B048A6EA95
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 04:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdSbsgHoMn/ARHQdEHonttkM1q38X8F0cVUi4uL0+oua64yAeP5PlqE1hUeSN5lNquthfJKWvcZ7aNgOoBA3Vvqi5+4YPOfb+aON9TjA3MDwoWEOqiMwuyX5lTgyMGOM9tA14xpgTgVdBqX8QluqwDPmRdOb1OeitzXyrHeJCTtJXPBITMiS1ggUvsYNCR+jGm/P1ymqk+KM04H9Vidun50PE+Xk7K/uFp+tkzZSRu2J+IbvIgX2uHZg9keQOWQjmKFXDVH6QeUhl7LWzNsE7X42RMguAGy+QhhVb+68lrLzSHisgpXs4f5kpjv0bqPgCSKg5/i8fuXM3sCfbsoFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2arh3yrCmnWEJSwopi3PCbAa87yNi+UhvqIZODg1CQ4=;
 b=cPCLAQOgBJxaGwf1NVE4RQ1znEebOOgBKIdQu+oOS2hpAkB1qyOFUpECAMiF4hER2CB5uMRprsa0nqcAZKuRBzAgNjWq9vBnOJKwKUN0TgNxYUVgrMIuX/f2oGu5qYGxNJp/ZUDQiVs06sn/0HQ+yl9hahsIOprgDd8pP204A3RG/kxWmOa4sBzk2kCHYom9ojEDREXNtjWw6xpsMfBb9pmtNlNChXYmVtdX7WYziVvVFWEBUvhUXjC1GFArLHPnXZ0J7dnV6O8MuACqzVLbNGtWNl2Mho9hOlrJxX7ZMsJLEHcq3Wbmq4fztmOpLveQNzaQhDJmPflXMYfA6ELykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2arh3yrCmnWEJSwopi3PCbAa87yNi+UhvqIZODg1CQ4=;
 b=JZ+WviVroCcJwTezgdooQlhwmwMtzCW7kcXIpkFQ19ntqSjEStsXH7++wLZ8gimmDrRrvBfydcNJVIE6VfIvcl7h5Avgaz9+iBi11UYPCOS3zm5VtCBtl2YYm/vjo0JKb8eKkglbr6jqLGml2SkCBm16ux36fv+YJndM+f0gPo8=
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 04:37:41 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::4d) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Wed, 24 Nov 2021 04:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 04:37:40 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 22:37:37 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix byteorder error in amdgpu discovery
Date: Wed, 24 Nov 2021 12:37:09 +0800
Message-ID: <20211124043709.2651699-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26df03fd-5c5e-4b04-27d8-08d9af042628
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18831E03D0A90EBC4A9DC27082619@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TB2KayBinw7tcHqM+25HQPXuQXOj9eZXi4Z8DsW1n3DuRaQs+XwbfI9eKwC07H9yJFcReP8x4I3a6w3AGoc8HNafjq3vZWRaoGyC4qvpxW5lrqfUw87cIbDIodQRhcQIBysZDfQOLH1Q7cwgLAs3shyFihc8vcqk54eGBoTqbPyzMprawHN++EkWC31ex8j2P07XBpPRV7x1YJjVwSQG5RY2wkKhapmbRPM3UFcxBCK3JSolY/i8rb9GzqeUloNdXSENX78kf6zlMPAk9CVmJB1Te0Q2EJMWeDzn7reO/drE+u37hTn16Aq2RQ47LAeJBGDxUbw8YaSL4KxFYYdZgjoGYBL2UZaamxHsgvYlc1FOSGByDvbsotgevkrJvUBCOZgvoJAoGTxGZqwHfExzimiDqJMO1LmYdOKc108WQoNFwO+/qn1DpB+AzGgIxezHEZPuGAah1ufprNLx++fAvfy40+UOD9oh56Z5Cy9QSqqyY3U6PpkostsMyeF0gvyZSNK1q9aa7Nh4BWdr6kFA3v350QdAKjmjF+jZy6rFRwVwtab0FgI2eJq5TzDsBj98R8A4Pbpk13zXc/kEngCHocVIn9g/3qNar42HjpsPbLA5L6B8+eas7gjfkrXer/nmVdPT80BDFdVO/f5QCzzPvfcST5W9hfOoxmZe/AxCq4ONc8ZWq4BRKAMoS9giZBb/XVE8nw3KKTFOff1KcLT9bR5ITgGECfJpxSoNyuujKD0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(7696005)(1076003)(83380400001)(70206006)(6666004)(8676002)(426003)(36860700001)(6916009)(8936002)(356005)(81166007)(2616005)(86362001)(316002)(36756003)(47076005)(2906002)(508600001)(70586007)(186003)(82310400004)(4326008)(26005)(16526019)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:37:40.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26df03fd-5c5e-4b04-27d8-08d9af042628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix some byteorder issues about amdgpu discovery.
This will result in running errors on the big end system. (e.g:MIPS)

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..503995c7ff6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -248,8 +248,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	offset = offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
-	size = bhdr->binary_size - offset;
-	checksum = bhdr->binary_checksum;
+	size = le16_to_cpu(bhdr->binary_size) - offset;
+	checksum = le16_to_cpu(bhdr->binary_checksum);
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
@@ -270,7 +270,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	}
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-					      ihdr->size, checksum)) {
+					      le16_to_cpu(ihdr->size), checksum)) {
 		DRM_ERROR("invalid ip discovery data table checksum\n");
 		r = -EINVAL;
 		goto out;
@@ -282,7 +282,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	ghdr = (struct gpu_info_header *)(adev->mman.discovery_bin + offset);
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-				              ghdr->size, checksum)) {
+				              le32_to_cpu(ghdr->size), checksum)) {
 		DRM_ERROR("invalid gc data table checksum\n");
 		r = -EINVAL;
 		goto out;
@@ -489,10 +489,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
 
 	for (i = 0; i < 32; i++) {
-		if (le32_to_cpu(harvest_info->list[i].hw_id) == 0)
+		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
 			break;
 
-		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
+		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
 			vcn_harvest_count++;
 			if (harvest_info->list[i].number_instance == 0)
-- 
2.25.1

