Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D915EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 03:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1BB10E27E;
	Tue,  4 Jul 2023 03:39:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B282510E27E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 03:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7nXUPGtFsGsyjTrnXPE25B+TJ2nQBGtXr7MXJOnAQN+g859eijliP4yPVsZUJbqOmqnocAO/L2uxeupKAybIhHK2vh2hF3De9ngX+6Vo2vw+Kcv+++Icchhgt6HIch4IEesApUPWyvdqy6ndtlVh4JJkYi8k4lr1pAVJ+gIvb1TjwCzbfeJQM/rZO7PedUREdUfpZ6ow1ZslSf4jY02r2SRAwYoHwZJlzNyu+zEtnqvxoJGfFYeEDl+/qpuli6ZvGvVjpfURjz8hUSUUWF48Z3gcwK+YH/pMbH+KyzpVr4DsaKUlY8AwRgSqfuitzCVx17kdvCQbDa3EyjTQfNHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkKrvcAWJLUtRW2xtdU54gZVGmbk8p4YVdjUD28HqwA=;
 b=E+D8veWJSvYQnjxivU6uHKwHINet3a1TBGnQATmvOVcc+SKJRtn4VlFSsmQqiuxIkETibo0l4FIUcGkfiZlBhbiBo0S4yaH7NSKPFBnshr3l7KkRJagJi7OnW5uPz9+mu34aqFsTYSKaSoemr59W/ByqwRT/MRXwUFyHKTobbQP8n9Oy4h3/pVVdT8A+S7kLRHsUYyzxEppyLlPaGqS1IMrJd65QrTCaB7ODCrrkoD0xrUYUIHISnzB7LBX0U6brNIF+zLhHCpR4y3HGW6RNzYbVD4+FpiJQ+LOEFr0hDsLeiVtiXN1mdc0F4cjkbYVljPMd4qJSs+FN/lpDTiTztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkKrvcAWJLUtRW2xtdU54gZVGmbk8p4YVdjUD28HqwA=;
 b=CzxSVT3sJbyLWRZFPeHe/vgQIYw5qJSpnzIPpj61VlotdsXUJqtw9INff5Xum5Z1WEyveChQqNu+pIabHapItakI0+jXMcYValWeogy8CO4uRXQXsq3BY/Xta4nF3MhJc88lU2vha5mCclvAgkCQj6siM7FKeliwkGWXhpPKodY=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 03:39:38 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::1c) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Tue, 4 Jul 2023 03:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 03:39:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Jul
 2023 22:39:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3
Date: Tue, 4 Jul 2023 09:09:20 +0530
Message-ID: <20230704033920.2732815-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d166a5-e16e-444c-8cde-08db7c404b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exu5c6LvxaD2CWuUkwwdA1RfyOde/+MuI4VVmA3pXqocwENO2wx4Jc7tfY/f0M5Wyi+iVYV1mSN82LXvdF9bXsjqdeEEUQsl+Mnu9wNOpGOBT2nZbBDl9GFs4s2mA6oDskKNMFsJ0S+3Jt26f+ueExiQx1+MEDwal835Ds33iW+WZfomP4cM3QQ72DS5ihj0m8D1Kjz5ccRZOXL83oED1FnYP7jM+H5EwwF1VrsmiDfCBZYlRfN3TG0E3KxTeSVZksAYo0oMh9wV/6X+sRyJwea8hPn0MT7Jc2e9wAanLEqkRleVeVQsFYY+TDxi29/L54nFzr6hbikxIpVct5gmb5KXYRGxKehmTw6O7v5Bu6yQ0g9CofuOXbzNGc10Y3Tp1veyWNZFeRAvYldSNDHfK9tJIPEiZZrRVroNpzm5uRkZDHZi9Xh94AzubpI/ClKIF/txNdpQ5xPiaO8i8DTxceZoNHGIVmbZeuvSm+nzQnQAniAgOdeI7UsmoViv5vRUOHV6WzIKvQvFBvdJJ5B66Gc8X9G98jn+OHTuX4Jco0bzinI4jIBnBNrip93JrfjIZpIqOehLtU7k640fnKpLPKbDCrszEcSXy4mM0BToZ/tE9XcwIveS3y2UpdQpHwhJa9QcRH+pEsDS8RcHT1g5o9ITE42Ea91h4gBTVs5GZNEvGfZACL9lQ2wje/9rJ9Zj8ZJ+qcQx7nOfOpeZqdv7E3dyiCFxmPsfJ+Xc8VtTUoKfBxUfgvxK/s1gIrwuZfsB73cfBoR6RaHAbuUfapfkUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(2906002)(478600001)(26005)(16526019)(86362001)(6666004)(7696005)(41300700001)(44832011)(8936002)(8676002)(5660300002)(36756003)(316002)(40460700003)(70586007)(4326008)(6916009)(70206006)(1076003)(82740400003)(40480700001)(356005)(81166007)(2616005)(186003)(83380400001)(336012)(82310400005)(426003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 03:39:38.3676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d166a5-e16e-444c-8cde-08db7c404b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Mangesh.Gadre@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the settings applicable for A0. GRBM_MCM_ADDR setting will be
applied by firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c1e3625ad136..51532d0dd7a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -195,14 +195,11 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		dev_inst = GET_INST(GC, i);
-		if (dev_inst >= 2)
-			WREG32_SOC15(GC, dev_inst, regGRBM_MCM_ADDR, 0x4);
 
+		WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
+			     GOLDEN_GB_ADDR_CONFIG);
 		/* Golden settings applied by driver for ASIC with rev_id 0 */
 		if (adev->rev_id == 0) {
-			WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
-				     GOLDEN_GB_ADDR_CONFIG);
-
 			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
 					      REDUCE_FIFO_DEPTH_BY_2, 2);
 		}
-- 
2.25.1

