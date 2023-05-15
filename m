Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D7C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 07:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD3D10E154;
	Mon, 15 May 2023 07:18:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC3010E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzCQZBhCg0YlP+020qeEmOkQsBIvQ+t0idpP1zyrXRFxslhGYwvvWGKvfPDXMMxAtrkpPQYzvgxSkO6S/4rW2HcUcmFmcVkk85EocUDjoN1h6hH+xfbEK8cQs3t3pBa69PVlSUywCVFvYpHsVaibCuJQp4sHuJ0s2aoehHezZp1XZlZ8Kqn5jGihHVwwqZ4d/SblIM67TuPCLqlRpvdgEBOKdI25rBVLrOFCKX/oY6FojBFr1nMFWO3vGiy9W8D5T6B9ZiyQvsdi3iXxfyFBgJ99G5uyuzftHcKMDI611nr6daw8hWTYBFQJOBgtNqP1g2UYfBHYR+zbVOZe39vOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9TpCvLGEDS0KHf+kbEcY7IuF8Mj6zh6oD0jEdWsbwg=;
 b=bkUMcBIf55AU2QMfSuz91vsboLbAK6JbwoYFwk/STC/90k1CgjCWpLlvYjRzLRqukniaoSxDUddXRF6fGtXxdySi6FUngTMJEdRhkLN+a3wC1tadD0a0dw7Tgw9NYVfvl1EFRh6h5l8tfWByLdR7t0Mw1nWXKYGt970QNbDBfcq0fnX3LEBHo5pJkZSQp0GoZhS8f9LwjdZc6/tnRClaShKOUXBrs3R9Hmk4sKD9EHtFUOGk+T3+3w08D+KLXmJ114G6ksOKowen1cP4yARy8ULtgDhif6YLiIUDSZ0c1KbshCurtAr0B8Yhye3z1dy17lmreTepF/ayyeQvnVFRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9TpCvLGEDS0KHf+kbEcY7IuF8Mj6zh6oD0jEdWsbwg=;
 b=n8hvenBwVWD7nigTBtfvzXEYGa+8OBk9hyX0TKqk3daCjeWrOvhBe6jXSWSHLD1wo6VJwuIrpbyKmSS9irufkOJoimBuec6giYUQyYK7qzk2c9VdXtZyISyXS4ss7TQ8mB5DH/6SW6F7LSO/nkXNPOnNWAAwHudstzO707HtyTY=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 15 May
 2023 07:18:41 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b2) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 07:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 07:18:40 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 02:18:38 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] amd/amdgpu: perform soft reset for sdma fed error
Date: Mon, 15 May 2023 15:16:58 +0800
Message-ID: <20230515071658.1911808-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 83591ad2-1198-479a-7b8f-08db55149c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuhKTdOd5NqNxJX05pD/NW2/g1XOch1drkIRZuCIXU7y8Kf2BxFVEcNbDM6evzHtt0ZRm5fmQnlUGhZmKYUQ9f0hJ9CBKJBjFv4MVLmiZkneYbDaQ4Db+Bud28RdYXduaqKBTiZselxl14My1jAl/rFyAdyxSlnKmhnXJVbRNg3DNpB70KQnz8lWPA5DDI7x/roe5cg5ufyg/YvVkKIvSkShQjDYjvJU+l0Kwk7kWHzMU3+/AzUofSUfbhff1ppGdTIYDZ8WcwmaffdTTdChRyknnyNH2RdpO2WOmKl59wprmwxQpVeiP/P9Z4zDHteooKgwGT/ZlpJiRtHB+L49nY3XdBCtxYrDRH3Ep/Cv5rJThXCUcbG0RvhM5OX5ZM/ZHHLaZrBBWHJmg3D1jTc6WWtQx3PoyFPcTpOC5KoeyL1cMGjWSflWZbtSHIh+qwnOqPecWMocUNbvcgrIxd25FZopDUaNrhpWL/L9YqM+Z94H5GsyKZg2ngblVNWKVnGE5cD0YY62q8UAySITH0V4iBdreQIFS/k+w696bSvoEqxqj45kd9mQGDFJWg5vB/pfUZ+H+O8EHYUf89igcHQ7+V8rsDAPippO4Kd4fsrheeYfrh6whLB1X1aNtweutqT7BC6V8z0MoUeHsyVf9j3eg/2XmckOdZ3EatX3oFg9lccQ1Uf9HChHb4NZR9cPNzspRymsK9TnxY3B1hEWdAJLJJQUnD0S555tSkVNcADAmcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(8676002)(36756003)(40460700003)(6916009)(70586007)(70206006)(426003)(83380400001)(5660300002)(316002)(86362001)(40480700001)(356005)(8936002)(2906002)(41300700001)(47076005)(82740400003)(81166007)(336012)(7696005)(2616005)(16526019)(26005)(186003)(1076003)(478600001)(54906003)(6666004)(82310400005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:18:40.9579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83591ad2-1198-479a-7b8f-08db55149c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When testing sdma ib ring fails to detect sdma
hang for sdma fed error, force to perform soft
reset.

V2:
  Add poison mode support check for special code
  path.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3d9a80511a45..94b1364d743e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -53,6 +53,12 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 #define SDMA0_HYP_DEC_REG_START 0x5880
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
+#define regRLC_RLCS_FED_STATUS_0                     0x4eff
+#define regRLC_RLCS_FED_STATUS_0_BASE_IDX            1
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR_MASK    0x00000040L
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR_MASK    0x00000080L
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR__SHIFT  0x6
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR__SHIFT  0x7
 
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev);
@@ -768,6 +774,19 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
 			return true;
 	}
 
+	/* Soft reset should be performed for sdma fed error to
+	 * recover sdma engine, so when testing sdma ib ring fails
+	 * to detect sdma hang, force to perform soft reset.
+	 */
+	if (amdgpu_ras_is_poison_mode_supported(adev)) {
+		uint32_t rlc_status0 = 0;
+
+		rlc_status0 = RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
+		if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+		    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR))
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.34.1

