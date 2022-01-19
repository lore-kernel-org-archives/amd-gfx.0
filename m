Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F404C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34B210E8A4;
	Wed, 19 Jan 2022 06:42:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8260B10E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myZLfTosidAJSrGmy5AYTs/I9WXa0+kl9SigqkaepqRhj0Uc9qhdZgwgjOQgDbhOY2onmlGY7z+kieLAzw3gcaw0JlasjKfwnwPEfcGngIAhnahmZCy1sGfw7RjHkLc5Xzd6uAJgpR3yNH9hjkptORh3h3f3Ig1W0f/ZKhSDMOQrEXG+u9J6qBE72S7CYPllfPuedeDsdQpxI3JBU6EH3kD251QZh8IHoY9GK7PnXPFZISPvbCKWV9X8gkKIhgpH/Qy2fqDQPfPOY0V17Q0HO2Ni4UIiKVFklu3iyzSV7o9R9y1PDGElMkvBhsGgF7we+8spiTO4azWoakXsZqFwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ89+FP5u/6DSzu+OMVcVpLSOvI3IgvGgSaXIdSIQlw=;
 b=Uhe584XPrycaEj0j0yV1YQ40C4sqU7gMPUwPEZ1pzufAIO7Ad7n0RQAScCtUB0juNUrY2oRSP99+aanqy93Fb9putyQxUwrd8yPFTN4o/omxRK8lBkCk8kiD0IzbyZ48Vnj9B26j92AOQN0WP6X/GNdGacr5kWnNAXt+oYijAhTBOAn/h+XXbj3umKzf/kTzvtPFdaTRREsBijG2aREavnjbGLZrNa2G2oQuO0eFGVHcPBBa5c/1RBhVbtf6xC3PuAMEUAOsoPKASZ5V0kQC9mVx14T2U2agz1S/UV3Bk08KiwY2aEn09ouTIKAYnljmlRpJ96jHsWmzqH14LDmDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ89+FP5u/6DSzu+OMVcVpLSOvI3IgvGgSaXIdSIQlw=;
 b=M5aUuDW7jl0gYU3drB4FF8IE7yljVulfe+P/K2zuCGtP6/YveTy3qsDPYDne4NoRqTpuV+TtVEeHarbBDJTE9UhUw3pGHtscHlCxeG3+mL3VZNBFkUmlTDckHYWOmjG+jxJzTPUE6NnlOc/7229i3Y9hJj8ti8Bb+e4iPszpO/U=
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 CY4PR12MB1397.namprd12.prod.outlook.com (2603:10b6:903:41::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Wed, 19 Jan 2022 06:42:48 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::c) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 06:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 06:42:48 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 00:42:45 -0600
From: mziya <Mohammadzafar.ziya@amd.com>
To: <Hawking.Zhang@amd.com>, <lijo.lazar@amd.com>, <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused variable
Date: Wed, 19 Jan 2022 14:42:30 +0800
Message-ID: <20220119064230.2903518-1-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed36fb4-4924-49c8-d526-08d9db16e855
X-MS-TrafficTypeDiagnostic: CY4PR12MB1397:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13975E581A9C8BCA272D281B98599@CY4PR12MB1397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQUNg63/C6o1wd2+UZnyJrfptsdz/cudIa4xAsc/GW+6qol+1XLrGXXeMgkCiTKiwhCFrm7VVUJ6/c/CEIBUMuW0rpkffnykbUVdeMHp9lvT6mLYROUnFoKCLLbUHvgq+eVswp6dYeeYrHQ5j1Q3ld68u42IPrJogFtDL3x5UTHjGeLO1r5BdE2JvRSwx3KthaDhOMUCks8qgV/TInvwkvm80u6RA4sCszFeTnsASY8tjAJIvXG0GIdI/t8t06/HK4oaxhjbocSTfxStVa7kUAXRzX+IJBvKbC3ZJSI7DgRpfyU7NkjWvvS/OIZysbZoZhbeEZC/eUH1eApTEGRFWPWXrl8QsA1AbRG005APwvCekwWhpA/R1nWSOWXOQpRJBi5LZwMTaPGwAHwngu+nT49d1Sh9McdeILbIgSI9ReV/boPj862+CnZ0n0FDaurpmuT6zLxWVj1VRv+KeTBNdY2of7opA9SG68otVRqKgIS7B7h24XQxWweZLz7xGjNo1aZ6tAQYarkxcYCZrL8ppt+ofEBe9QXhSIRy57tMS1C/6ODu8+mlfa9Mr1+hRurXmx6cyBqcCwvo8uGGSkuCTjZdfPN7JwvU2fM3AEUQMVFWG9X0atxJj/p73Oqym2gfUarhHLRPh5qjXeL+tGP3tlWED4JOPIbFk9cFsKyanFsxafUfN6K1AWZjEpwPjcexHXpH6oL/rfzjCc4S4wZJocqxbWv3jbn1Chyj7yzxX5NXN676V8qAebsjEYHx5cFBBdf29/OZCjlPrZwCftUEEVwLq5dASNERZKf1lWBTM4+o48ux3GmVIimz7uT+wk9D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(8936002)(8676002)(36860700001)(6636002)(40460700001)(36756003)(6666004)(47076005)(1076003)(508600001)(4326008)(16526019)(186003)(86362001)(316002)(356005)(5660300002)(2616005)(336012)(2906002)(7696005)(426003)(110136005)(70586007)(83380400001)(26005)(81166007)(54906003)(70206006)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 06:42:48.2401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed36fb4-4924-49c8-d526-08d9db16e855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1397
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
Cc: mziya <Mohammadzafar.ziya@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove set but unused variable.
warning: variable 'umc_reg_offset' set but not used

Signed-off-by: mziya <Mohammadzafar.ziya@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 291b37f6db4e..05f79eea307c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -94,16 +94,12 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
 	uint32_t channel_index   = 0;
 
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
 		channel_index = get_umc_v8_7_channel_index(adev,
 							umc_inst,
 							ch_inst);
-- 
2.25.1

