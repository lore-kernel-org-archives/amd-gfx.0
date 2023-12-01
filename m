Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F241CC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 07:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD17E10E800;
	Fri,  1 Dec 2023 07:39:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6787A10E7FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 07:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYVkgAJC3Uq4a2i8a/k5B4EfiW6qmw6xUU5K3n+TQ65BV/P9t76vQ+6Km6yDFEIusKU7US6PhJQsU4SDIEJufP16RG/qWZPtOfAR3368BV6IShqb8HVNF3LMWeHIOXidDyoa3sC64Lw7P6tmPd1tDs0BoAQpbUqxnkjXtU5d6MPFjGMekhCq4jhLtEqpChPq3pNc/a04bpNuugNuX7ForxQMbJWvHyEdqoYkWQ743WVfHxQl3QtvQo6WfsGSOKMujC+mdUGXGCCnk9BBkTShA6qHV1kAwK6brAbfxKguMBw5SgwmTw6E6l+vF7OABSs07uw8ZLkPhids23n3trFPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ebHo1Ve4O3OtyRqjJ0hqmpuVhmodUapdYWGCnuJx14=;
 b=B/CQGGCaVsX1KTskQnhpzXkuO2RUDPS6EbcP+N2QoUnd2tPZb23Bo6JvJynAlDNHkjTDN/BTLEG9gfE9gKpTZ/YaEWPU5JAecfuo7YNXlkccZqk2t/OupxO7tIWKg7WgUMnISjbbP+7jG/1dVwMimBIqUWZ9iH3cMoy+I6mfCPAj8ai/7mcOjlbAS2cPK58Uhv8UQFI+UbecEIpsytlJK16OGmHllUBqINxEoUpDdJzrSrB1RV3azFX0u9I1VVmNpCDtSOgp7rWXMGzuF1zkZNBsuf3flmRCS3SmwrTxw5ieJLhmeHICQ7R9QgAthw1NFZThD1kSAQ6Z/nubiuHP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ebHo1Ve4O3OtyRqjJ0hqmpuVhmodUapdYWGCnuJx14=;
 b=h7cHHhagxUQEP++OPVI5glLsB4tKzeCNRUSYl2I2g01T+fx5BHbVT3GSUNUVpLqaFz3cabx2x5n4FPfu5pZDE63XrdhM97/cWk2puVGE3GbusZsA0W5p+5Jkpy+R47+gS+5EDCuIsS4MCBbr32DvfOcYjl3tJmMxGfzlU6psycg=
Received: from CH2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:610:58::25)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 07:37:29 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::93) by CH2PR20CA0015.outlook.office365.com
 (2603:10b6:610:58::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Fri, 1 Dec 2023 07:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 07:37:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 01:37:27 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Update HDP 4.4.2 clock gating flags
Date: Fri, 1 Dec 2023 13:06:35 +0530
Message-ID: <20231201073636.1190113-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201073636.1190113-1-lijo.lazar@amd.com>
References: <20231201073636.1190113-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1da806-4563-4aa3-e4a1-08dbf2405f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IaibnXxqf+xQhPHBjkwDehGPM72rHIRewdfoNmTaT91uAlWwmrHo9Qn/WN0DYDPj9Gh6DmS/mtnVaBj25xVCtCw5wD+EVtpLdTZK+nxYxm/XwHk1+mAd5PIPQG5mwjb66I4qmfJ9AkBzWQFoG7LsU0ok4WaWdy4aQGK4GnA+3hiYkq1YmVqcupHqoBbrvoa0BgkGggdDMhwgXnEWTd9E7xkr28snsPC++O3TbcW5TsmzMoQ2jsHgL8T/UZ+kw2XQJJYrosx6M6U0rzNhhCZ8Jk/+eHLFLg4tyiIWxeA35dbF2/RB4DNp0sxulbq63YY60ZOFgIIAqcxPewF1aNvLVs28RL0/qYEwcnuWAiCEuJs2OKltXULIF1gNY2a8PHXHtb3nJPtVc/oglQN89FzopWhTw7UjFsWkctoaQTN7Aie3DUNr8hyyLZB1v5CMkA0e7usEjdrCe1lTjA32n7yhG0n4FO9yxNfLbFhyijmhZ+DBG6Rxe5yNM36WvUIM3u0ig124wqKo1GFygEvwrCA2jKuRy04qA6wQ/KnZeylkG9xakwN6PYXiMzoZcrvpoj+wH91JGFhpsj9M1nufsAX9RRyT9zLgui8bQGUh/Q4LWj5DEFokP2vCuDMiDJP8e9e/kzO15vekOBSAmYoYnypQ8UYdcDjn94weGWQPRYgTKHD7p7Kh6b0Z8mua9H7uDLw5hNSDgqOYOrPCeG3SUvkpQymcOTrrEUGGfKNHy01ov6OgaRFAwDzQbojuFfEd0K+2E7wj/PlNja5xUWZ8zTRvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(47076005)(356005)(83380400001)(1076003)(16526019)(2616005)(26005)(70206006)(15650500001)(70586007)(40460700003)(4744005)(54906003)(7696005)(8676002)(44832011)(2906002)(5660300002)(4326008)(86362001)(8936002)(6916009)(316002)(41300700001)(36756003)(6666004)(478600001)(81166007)(426003)(336012)(82740400003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:37:28.9768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1da806-4563-4aa3-e4a1-08dbf2405f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HDP 4.4.2 clockgating is enabled by default, update the flags
accordingly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 49e934975719..4db6bb73ead4 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -129,6 +129,11 @@ static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
 {
 	int data;
 
+	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 2)) {
+		/* Default enabled */
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+		return;
+	}
 	/* AMD_CG_SUPPORT_HDP_LS */
 	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
 	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
-- 
2.25.1

