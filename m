Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA072C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7127410EC47;
	Wed, 29 Mar 2023 20:15:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9141510EC3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRXV/AG6fZcKZbsikNl5oT2ohpADnIyou4RpmnMgg9tMOoMiufHA0dgv4r9cL1b/I6E9S6EO5QMbEd4BFNJmAu3B9LPYMP+k919fqRSmCH0t/bp9SZb+1A8S/3oK4A/eDMeoZwRvwfFH+PunHnHhnVZZ/I6cbgmfQgvZJXRmhEhSl+x2RmY9KdAaiNm24SxSHCZL1IDizkvID03MdWRhyyr9TJghilOOfZ4b+t6UXZKhftzkQIhALL0+64Xokl1HY+MADGRC5SH0DXB5624V4CFlSsEU2U8xofg0ryGwlHF0I6b+RmL8WNj+gUJUFYoEELD8CZUSiaiV5/TKzpILcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSPVQnSYGkd1S5+6yBPJqUDq6vrnsCptT1k99zTn7ME=;
 b=dZTli+lMDry0BTdIcniVqTN2GbrZZS1yrL8Uob1Da3ph7TkEl9y4yzyIQzrrgUOUQrb2z27lrY3/Tmo4UTShEpgblQz+duvN0wUCcK0aSnnTTqoKYaVVdjQntUAMSVAiR694LttNBqVM7NybKwewgG+IUAPwApfJLr6lyUrr1+eGml0CDESbGi+7eBV0RaBE46CI4oy2farLzA/asAClZyJRqzTEXbW29G2HZdVpRnWxi7Y26r4tahGUolTgAd063LYbx9tKHgEDV0V6amKYkPUhy4vWlrAbE7Ffeq886/tCejxHwL0wXxfoJoZLQLb7q6P+jp4tH5Sx7olv3T6h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSPVQnSYGkd1S5+6yBPJqUDq6vrnsCptT1k99zTn7ME=;
 b=4JxedaQosKQy63Nhs+S62kuYhcjgDNXuscdLwBneW4JPxxOvML/8jOyipgL+YQZjpyvdovk8cWnO+UUgDaGtEp3qXllo1cYHBUMkrvQJwO3sUFKScUis/KrdPYDt0yBFTH7bIWy4JQhHPiue61n5QokgRHSW82qOZ4UC7cRKsiw=
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 20:14:53 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::65) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: Fix register access on GC v9.4.3
Date: Wed, 29 Mar 2023 16:14:26 -0400
Message-ID: <20230329201426.1982669-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f518e3-4e20-44ef-472f-08db309241bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fzVnHO9AKWKWiJGEJnf2H2Eh6giqRMQXl0kVDqgFBIeG94IVjVcJtWTPCnTC1saneUh3AM4af2P+rwh77Q2P9NIxVQmoskE6frw0JjMiHuaWakfeyIKK1OE11N7KPaIlcRa8l3oqI4ZuinMengrTZq2MO67MsWU4VW5bPbvqCoPZY8CP4oA67+/N0JmTPOeQkLpzZgwNQKeWx/NJISRE4bRXnYwrFq5KON4yUV6EMcSRRz/sVLdz5tos/YzGTICSwZ8x198x4eMQN9OIqLsj+pVWAc+U4C645YzTifPxc4vYJviD6FewwEMIjnfjHCQiRMPzoUQsA+wiT2mQtkhJJyxSO5P4RGYgM/AYW6P299vpE3ZmQy4J7NvuxVzHb0++FDt/scW4+z7Uq3aO4/FOM3I5UraWkX4GS4ArgTAb3vRMOj1kT44QoSG6LBRZpX3m+JKKRWnF8DdAdZfTzQ1cVPw5U2vUX6rMYDAbBD8zKknDk8YYKv35SogcqZOnCXKVG2Zh8C/XKtfywj9gX3RgDSbIC2O7pmNpwl5KaMwQRykU1l6ViZv3ex5Lz84gZ5ZQ07fGzXuacV2dmC4sYE57Xwx56ypAJsVISleha+ww90hq7814+BXVSGbI5ATTMkMt3nwHxZoO2e5hcCTYs7N6qSjF3lWmNwS1fhTlU0m8VlmARMwrgvFdwXPOnHXa1e+HEKrQ601rmXv+/czs43HJ6vxS8d74q1rPlg4qg9rI+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(41300700001)(478600001)(54906003)(6916009)(4326008)(8676002)(316002)(82310400005)(5660300002)(356005)(81166007)(7696005)(336012)(26005)(1076003)(40460700003)(186003)(82740400003)(426003)(8936002)(83380400001)(40480700001)(2616005)(16526019)(36860700001)(36756003)(86362001)(6666004)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:52.8064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f518e3-4e20-44ef-472f-08db309241bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

In GC v9.4.3 there are multiple XCCs. It's required to use
physical instance number to get the right register offset. Use
GET_INST API for that.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c80d0c2954e7..caa0b3e1c877 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1605,7 +1605,7 @@ static int gfx_v9_4_3_kiq_init_register(struct amdgpu_ring *ring, int xcc_id)
 	int j;
 
 	/* disable wptr polling */
-	WREG32_FIELD15_PREREG(GC, xcc_id, CP_PQ_WPTR_POLL_CNTL, EN, 0);
+	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR,
 	       mqd->cp_hqd_eop_base_addr_lo);
@@ -1698,7 +1698,7 @@ static int gfx_v9_4_3_kiq_init_register(struct amdgpu_ring *ring, int xcc_id)
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
-		WREG32_FIELD15_PREREG(GC, xcc_id, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_STATUS, DOORBELL_ENABLE, 1);
 
 	return 0;
 }
-- 
2.39.2

