Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6DCC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9225710F00B;
	Thu, 30 Mar 2023 19:49:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27910F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrPRkjHlB8PNGugp2KZ1HsMJ/+ukdFnYXzKz5SuS5VPcxonfRBvJaFUSGTChdmtiMO45b4A2ZJyJUyVMSg6TPAXBa8pwiYLlYyUHI+6BVhZmSbkj3Yy//vxMb+clN5RHyZ94VaBzf6m3gYTi9cOICf1sNenD/Ir15zWYNCL1dNONzeTNc4LGdXW6tHMnXlbpEx+n8JenTKlUFqjjKNgNu9vdb0yQVdhuV9L97pijwCt8Ara/qdJ8zIyZhY62N9AbHE6Uq500Gkpp+nfF+LjB+4z5q3EbV8Pu1wJGRigptW3OgX7EaJYKozQaQGOWouAyQvTdUKuyMXTqzNP4DdKYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P4iI6XgFkCTY8jVWeSFwJEzeqOu8gXkblydgRUP5yY=;
 b=VWBnpIib600mjN4oMb0EY53Wg0Wap0qk2/uV3GpZAw1t4jGlJFwaRKMZpApJmDmJCbjm9pvB17Gv5Qc9rKfN7FwjEYY7vrStXOslrmbr2zxz2Uf28qR0BraCDGF33jjcaiIlJ83SosDjtAhItbNQdPdjgovYcqulRAY4N4vchzitaQQD4GtAiZeAI1XWlSPKajI2Y6D6pBNfL8s5tadkjdgxq3ohg/J8wQh6zaiQPZ9kwlIuyMc2rL6LwrjZWvN+FGXieKZmiTkD86H5ykyOP0CMSLlcLOBh9i90e3Ok8gjGVdt6du1vW0MxFIi9/UjUG2aeBadw45CiZmglHGrcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P4iI6XgFkCTY8jVWeSFwJEzeqOu8gXkblydgRUP5yY=;
 b=jJIgTcePJY/IyGlvavRALV+CRDOwL+ylBJdqr2No1bWWCsPhc2Pu8gMNd/HwMt3MNVAC3LWnJrgXTOA48VIXUj0jlmjEX/ubGt5c+644j1jgMRNDkrl8RpT/Vc+Q5+XGMsoWaWzMFGrlqMKBO1uKLDXlUdjcI0Q4jIfjydrJ+is=
Received: from CY5PR15CA0142.namprd15.prod.outlook.com (2603:10b6:930:67::8)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Thu, 30 Mar
 2023 19:48:58 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::e5) by CY5PR15CA0142.outlook.office365.com
 (2603:10b6:930:67::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: Keep SDMAv4.4.2 active during reset
Date: Thu, 30 Mar 2023 15:48:39 -0400
Message-ID: <20230330194843.1136162-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a77242a-cc74-4481-fb96-08db3157cd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCjPj4xdOe9g1w+vcL6c/dkiVJAOyNe3MVDaT9piN0SV5T3eA9LFpazmCFH5wFdNpnxcX737NW6xjcYaMAyY5sSFYnUwZMUAOlby0fZXWhDeOZcgQo4xl+KTHTXu5t5i/0gEJayOMM6B5eBnBV2/Te/rTJ1FGT7HEZMvSeg/YfLdF4iQ51SUxiCjBhurckAHjyurxbMfg+sAEj8+0KP2U6Vg/nx1IQlsFs0z9nZOx7thu8TOAYqGHTA9JGsqAIaPr0lJ5NiFffAmmI5zaycQXe9+wIbTRrDRAO6x9LUhz2aCavJr2jn7K9Qc7d++asLMs3Kshy6k1bs+H1fBKD+v9eKvcAE2WMxNfx28kWeMz0zxMWoK4J6E2GBqGso8H/R/3zhOtLKKV2TmVunyecU8ldajTXEGVTaJgZJbIEarVBzJpCcfCI7NL2tfL36+qsBBNNNohO0H32phzgINsCOjksl2VAeeRSq5gSN2jOsEg8KBEChYKhEozFvEYCupfDomfqZyE1nkZbW3LMcr9sdkJmAOxYZE6HEHFUE/gNK4E+a9cWJmZBkDZobOxWTg3bdBzESTpJPbZnqIbUCd5jo/xGu5m4KUsDwOWQX+iSum92A1M89VzKreXu4okXHuCagXDLDIB/DNif2CEaKcJbKXkPj8TwxyK+eirRJ+iAsLx8rz7AMRTm081AevSF24onB4IdDu1PSHwIvHKlwrWk+XD+qMXzAfb1EGIKDBbBdd9n4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(2906002)(336012)(2616005)(83380400001)(426003)(54906003)(70586007)(4326008)(70206006)(8676002)(478600001)(16526019)(26005)(1076003)(316002)(82310400005)(6666004)(186003)(7696005)(36756003)(86362001)(36860700001)(40460700003)(40480700001)(5660300002)(356005)(81166007)(82740400003)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:57.8974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a77242a-cc74-4481-fb96-08db3157cd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

During ASIC wide reset, SDMA shouldn't be clockgated and be ready to
accept freeze requests from PMFW. For that, don't stop SDMA engine
during reset and keep the clocks active.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7c91cbd91ac8..729e26a4a2e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -566,6 +566,11 @@ static void sdma_v4_4_2_inst_enable(struct amdgpu_device *adev, bool enable,
 		sdma_v4_4_2_inst_rlc_stop(adev, inst_mask);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_4_2_inst_page_stop(adev, inst_mask);
+
+		/* SDMA FW needs to respond to FREEZE requests during reset.
+		 * Keep it running during reset */
+		if (!amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+			return;
 	}
 
 	for_each_inst(i, inst_mask) {
@@ -1435,6 +1440,9 @@ static int sdma_v4_4_2_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_in_reset(adev))
+		sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+
 	return sdma_v4_4_2_hw_fini(adev);
 }
 
-- 
2.39.2

