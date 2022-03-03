Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1D3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA2D10EDBD;
	Thu,  3 Mar 2022 08:06:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EAAC10EDBD
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXcmDmvs7Cd5QPLpdfmnt1EifcaP87jkJjqEhjMmPPPffVnUHegFtUvzj7P7/bxk4m5giyr+BmEsk3UCmF4ZYrCeRjk2klkvXIAToublKaOe1gIfXgMc6pG83E4xLZF/cud1L0irJdSoVIUc13OICdRhd8R53OwGCe2CrNbzQjlnNFA3lS/oMYuMu7t0wOdSmrQ4w3CLgeNN0dhieWl2EgrAOwgAVmbl0BbOVYwN3+WcDJXlWU9rfPL7NltkumxSpI3MRsg4ol4CDfNJmXJz9NkJtK2yv+g3wOkwuKUuYOGB73KfPNOI4TZOWPm1RVGochn5IyZ5YVXBPI1V4tef8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUsijA19rNox/PeDO1VDcO9As/g3TkrGFIzC7W05qs0=;
 b=VPBA+DzJWCzT5yEsrYVvqFN1n7k0LEwLsn2IxTJdZNUTix1hqRVwRhZs6wewqizs1X1PWLe1GUWAaq0t55sU5fsKBx7/vPlhrt5Q9EmJPHRLNc/a5ykK7QSpodE3W9WmUEoCH5sKqvsY+bir7YPMS/FOpUQHqXFCsPcyB5BEMMGHMcifxXXCB+JYEgGyBBaZZ8V/H6n8yULtZMzTtZHegtvXIzEYLiXWq4lDqM/GDbtXfcl0i451UkhSxQrBy4RmtLAJB4uJeB2TJfZ5BxNZlGqZ21owUZpikMlxUmABriJ+Hnzp2ZEXrnIOKZN0oiwJFJa+fCzAxfJ12/0nFb2wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUsijA19rNox/PeDO1VDcO9As/g3TkrGFIzC7W05qs0=;
 b=Vkrn73bAm5sSxUMyc7cwWyXJCxPOwaierNxHCHT6T9nBObBWlAYI5y4Zbs2tvGyQzwjuW2cc1qYp3ia2AVVsNdOosf/r+5wCwdGnomc16Pfirzeknr/fCoV0C8k45sWc//iNvv8V8sSQdhC4REtAxAseuOF85DkaWqY18eO9mIs=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by BN6PR12MB1122.namprd12.prod.outlook.com (2603:10b6:404:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 08:06:00 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::d5) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 08:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 08:06:00 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 02:05:57 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: implement get_atc_vmid_pasid_mapping_info for
 gfx10.3
Date: Thu, 3 Mar 2022 16:05:14 +0800
Message-ID: <20220303080514.680150-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303080514.680150-1-yifan1.zhang@amd.com>
References: <20220303080514.680150-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 304f85ab-5bfd-49d5-7aa3-08d9fceca774
X-MS-TrafficTypeDiagnostic: BN6PR12MB1122:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1122C80140D5AD7039C806EEC1049@BN6PR12MB1122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PJREY2slxTSZNHQ4hOmQKst74fGuZ5MB1YMOR5892jhSEcL3/4bjPCVa7pTwokOfYOmALMSZhdKWpeRRJZRa8OX6BnxVnYq6eDIDx+qvH/zLGLUkZ73xJyGvw74BdrLkg1cUVPRD9c8vS2P8cBQ+TmJbSLawoce7f6LocwZtBmqVxfKm2uBTUF5y3bWjXRvciTOI94cobvI6ejE3mkgvFRFqEHWzNk5Q0uXncXbTHxUtvlip4lWnnagUZaWUIzckaBHX76lQAhy1jUQ6dTmSWBsE3QaBf3lYmgDD57Qoqdz1EUy9u6JN9X0gLz89kF7VXZ87wNpxLMwMnHqUTgE0sRkiS9nk0zUM/YDVeaIi2HWzwkfxTbuCZ7Hxe0rXV4JCBhN3Iz3lXDTtR01XKOExgqTxH7VyFzbBIR1orKTfCgh1yRC0GhtZCxX6wAmmRHji2uI6fz2aO+2wJSf0jrDHV3Nnq7GGW7RWsGaaHZqa7eyi2498HAAFi1pV4N7kqCNkYJdPgyyjPIn9HVS/rx2hMYj2TA9twHgq6FrY2TXgpx8vW0xtkEcKlDxxtkDEfZE+pC8S16mA5SjMZ6qhi62jEhu3gpe/zliWFR60qed+on4IYXHpQfgka14elHLuSj04RYlyz5npCWGwqkw0olsXrv8Fc6MT1/Y1EttQqQlB6K+eeVTU5PKiit1zh2nY9QfISEvydLmIiNI8jdM03eKZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(508600001)(82310400004)(7696005)(36860700001)(2906002)(36756003)(86362001)(47076005)(8936002)(16526019)(40460700003)(83380400001)(5660300002)(26005)(2616005)(1076003)(426003)(336012)(186003)(316002)(6916009)(70206006)(356005)(8676002)(4326008)(70586007)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 08:06:00.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f85ab-5bfd-49d5-7aa3-08d9fceca774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1122
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch implements get_atc_vmid_pasid_mapping_info for gfx10.3

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index e9c80ce13f3e..ba21ec6b35e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -26,6 +26,8 @@
 #include "gc/gc_10_3_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
 #include "oss/osssys_5_0_0_sh_mask.h"
+#include "athub/athub_2_1_0_offset.h"
+#include "athub/athub_2_1_0_sh_mask.h"
 #include "soc15_common.h"
 #include "v10_structs.h"
 #include "nv.h"
@@ -606,6 +608,18 @@ static int wave_control_execute_v10_3(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool get_atc_vmid_pasid_mapping_info_v10_3(struct amdgpu_device *adev,
+					uint8_t vmid, uint16_t *p_pasid)
+{
+	uint32_t value;
+
+	value = RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPING)
+		     + vmid);
+	*p_pasid = value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
+
+	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
+}
+
 static void set_vm_context_page_table_base_v10_3(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t page_table_base)
 {
@@ -788,7 +802,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.hqd_destroy = hqd_destroy_v10_3,
 	.hqd_sdma_destroy = hqd_sdma_destroy_v10_3,
 	.wave_control_execute = wave_control_execute_v10_3,
-	.get_atc_vmid_pasid_mapping_info = NULL,
+	.get_atc_vmid_pasid_mapping_info = get_atc_vmid_pasid_mapping_info_v10_3,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
 	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
 #if 0
-- 
2.25.1

