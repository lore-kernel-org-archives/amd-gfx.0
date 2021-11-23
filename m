Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684E9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 11:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFD76E212;
	Tue, 23 Nov 2021 11:34:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBDD6E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 11:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYPCYSLqeOXT1Lp08v8r1XnAvdFp06Pu+moWqPCbXZv40IvoZE+4I0q26YNmJahz7eLsN1mt15VS5cbbpAvZr6eh5lizQi/UjTiQi4haZKs9rYZbs/xQ5bi7wWvzNiDG934yzCrwfrLiaeul/QsHFOqOawrUpez0cZ6fZz5jhCk5ePAJnF8TnnnrZvMflORrvPWD0Ke4ej2vmNi+JMHM5rSI3bNxCv7gghBRJGkoGPcbse0XbIcQjGxGhlk136VNmv5x031u3FNQjVWOwQIxcDnFCbnukYPwOFl0roBMr1MvATuYVBl9+d0wO4+eOFYZzPnS8eDD14Dyn6G/WyQ7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqJ8tZ21Ygn4qGj+UfePsVD8JsG/Mm8kOIb6MoEDIQU=;
 b=AVWQnnDVXai8CH2hjLqUDO7l7IFL133whdX1WtBZI8zS7U09AGVoUTikZAkvbo7h+LK2z+6XUJsgl/HVsZUUdcCzA/Zpbmxe+/jY3tPSBvMtyf7Hti537nzTzIr+4oC1zOYepiPEDN0uMpj3wSedC7tMTnNRcEbLMlCHxRbVQLd9ecAJranc6Hfz1QZBqjyhPJt8WDoLNJrVgKvaYlXpF7MPQXZH7k1vy2rUsBfcVqUCpzSr70Gb68is0D6LNqZbgfsSjC5vucWcaKSLCV38YVuo0KzJyWYdBA3hinwekKr3ztg7cp++iKwBei3cfo39x1JyN1njl8zpqR+zFAFkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJ8tZ21Ygn4qGj+UfePsVD8JsG/Mm8kOIb6MoEDIQU=;
 b=drzPV/fuWwpfDU3qsdJSuHuP64Fjmou+3v4ndKVgEts0rQV5jXdWNFW7o9w0xGJZbUy61FaiKnodmiOqDazx3CgLniVQ2FSfKZdxbBk9KrFvkfbJEJibMpYiKKZU4lnv2b3Tg3gW9t5XqR3WU2RcZvrnUC+IHUqiBeALHMwkBaE=
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 11:34:44 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c1) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 11:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 11:34:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 05:34:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 05:34:43 -0600
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 05:34:41 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <guchun.chen@amd.com>, <jingwen.chen2@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip init
 for SIENNA_CICHLID
Date: Tue, 23 Nov 2021 19:34:38 +0800
Message-ID: <20211123113438.5200-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea890887-fa87-48fd-3e50-08d9ae753f12
X-MS-TrafficTypeDiagnostic: BN8PR12MB3538:
X-Microsoft-Antispam-PRVS: <BN8PR12MB353847F3A79E7F3D792530B1FF609@BN8PR12MB3538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb8XunRAu7a2L5gTELQqiuM0IU598wfa8pp3YB9N7IVKluRMdCvBdO/Y3Zbs6KwqHPEhVTOCEUMIz4ooV6bns5LNDXknSNytOaWzi7WxvWVsGJeI15rlJZZwriAnCidDGqrC2UuNgOjcas+cN8a/udSCuGV0LDxhkzBpgS398hx9Ic8VuV/XKs5HHAtzFHTBRlVX4OlvTlg1B3JCu5qzHBLuWP1CELFADyN+cyWS9HdXEEFhKjxqWwp9RkjhecKX10xUFkXJLQdtjUwuy4el/Mwmy7gPxJ01h3NgnB3fKO0EgjtxGVjX3I4UR0LdoWemHH129KfCq5zYZDg8wQ9S3rOJg7rhoqDUDGvLl023NldGVD2XnsYNKWtPXYkwc7DgSFETbHkuLoRk+M4zyBFVu2hhUhjpsZK0bZtdcAqQ8SFhFPo/SppwGszzpzUdwEifdACe6xyYEC19w2yZhiLB9YnbKO/2O9w94s7TqT4GN0d58TKTdiKtP/CjOF3F7tdwSRmYtFBLekqujH4hXFFksTeAG8kJ5Ws1YPJBlm9m3zZ50rvlKyi/IRG//EV2XyAgXO1nmjCP2DDKNo2H+oYIfXOUg3KR8O0y4FYmlo4vtESlj7AZkZNn0XoVj6mhRAO2nIAt+iINCwImzGtbNZAc3PkH49H1rVOkv4JQPC/hXT30iTQyavWIE1AU0vTp6cpWlTUdn69zFeoM1PvLEMRoyiAuuZ9bCKVT9stMLRrgA2+0LetZc9G89jfWZZ3BKTb7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(36756003)(8676002)(26005)(70586007)(426003)(36860700001)(8936002)(5660300002)(70206006)(110136005)(356005)(2906002)(336012)(86362001)(6666004)(7696005)(4326008)(316002)(6636002)(47076005)(83380400001)(508600001)(1076003)(82310400004)(186003)(2616005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 11:34:44.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea890887-fa87-48fd-3e50-08d9ae753f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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
Cc: Jane.Jian@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
skip ip revision match case and continue use asic type to check

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..0a91e53f520c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			return r;
 	}
 
-	r = amdgpu_discovery_set_mm_ip_blocks(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(adev))
+		r = amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+	else
+		r = amdgpu_discovery_set_mm_ip_blocks(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4f7c70845785..87f56b61be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
+	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(adev)) {
+		fw_name = FIRMWARE_SIENNA_CICHLID;
+		goto next;
+	}
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(1, 0, 0):
 	case IP_VERSION(1, 0, 1):
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+next:
+
 	r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"\n",
-- 
2.17.1

