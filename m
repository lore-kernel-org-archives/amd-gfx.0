Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34187EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 10:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBF710E1DF;
	Mon, 19 Jun 2023 10:23:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4221D10E1DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 10:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYTnbXceywaWErt3vZ1R1ovkZZSlTRFEwSi/j4Oq6Iv04WlxGeAV1faYoKys54HqO7qSGLyZhqd2u80zTVd4l4k2oKlTl2gaZG18pnAkXadVhyuKfAV1droG+87gLA5tf6PFQNxeHS+f9GdtKuMkCUKSi7IPcYkq5ABE94Smom2PrDdpCfqwdZbSCAtOoERTd5QX0gt7u/3FrmKw87gGc+a120QBgWs5c7OaKqUxrPcmA+HTefgNAOyX6hFNSigc7HJTYzBBA/bevK/1en/VnU6HxZLEp0uGh56f9bKdu6cUaWA4hqUb1kz0a+JE+gmB/bBNWSU9AbxRBeqqKMkAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmGspNlImIQUaqTHYk8+f1SdSj/CXWJD0D4zoosfoF0=;
 b=FHZPmMLQeWc54MfPd/z1byaXxoBwMj3vjJw5tdCPuBcQtGn5AQVeXN10eqccPb1CZLIfDcBNJU70dqzMz5IGSYI+jpoNLW77X6EYwLUSy1AsHKfMJ0heIV+9vk7MJiaZ1UQIdU0/i7ybboQnHCV8bw9KkfXd/DwSicGfP33ee5w8a3EjMxswsLBOEBe6OmK2jXwSuxL6rlb79wrjGTEvXf+DjLpL1ERqtDlRYzMZhbe7OW6YU19wGp2AZe1CSYAsO2U85aauHXBBzKWWSRSOOcb1uexMP566M+F6j70RRpy+ZF8/7cuOrw2k1tvBXjH0QrJv9Yi8Sf+RQ2uNbavWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmGspNlImIQUaqTHYk8+f1SdSj/CXWJD0D4zoosfoF0=;
 b=wouTh9sgx8jljDVYXcvFESJn+dUoRG8UEAnPAcdcAlHLBaSKSgG/fc7VXlrS92YFhpaDFoi9QQo5wSa/OpqooAeEPqbRpbnrTofH8tX0hUinCgxAwnFMSHL2YYhrfJ7JWPawzhNgU31pRbSouenGuKty250qfTsJrb3m6Gw9CyQ=
Received: from CYXPR03CA0015.namprd03.prod.outlook.com (2603:10b6:930:d0::10)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 10:23:39 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::4e) by CYXPR03CA0015.outlook.office365.com
 (2603:10b6:930:d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 10:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.20 via Frontend Transport; Mon, 19 Jun 2023 10:23:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 05:23:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 05:23:37 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 19 Jun 2023 05:23:36 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
Date: Mon, 19 Jun 2023 18:23:34 +0800
Message-ID: <20230619102334.2264865-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: b07eb082-f930-4988-d3de-08db70af3f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6rUMrLL3b0pv25PD3W/B4gaupUb7kj2E5xNtFtxOIByoxkHTk43PTGVGqEeUWeo6rU2Oyg2II47cZ8+JwuEsxyPdo3tgbNaD99RxsAbfG2DYBFrg6PKCkc/1v7JrbTEsDEoR6ju/VGHFs1ml48uSEpNbNZZr4nHGGeREHEbTxJ85XF/RRwxJAYN5vfhDkswKZzfYiYJOVHI591RcrrUqCdVDZLIRUlbUSyZiKRHSZak3Y+jXgCDm8V9OMWAQi6YFJSebiUAgM+Dygtk/YWfU9N6wc7x54XuOQQDoBFdp2GjGuA/zIqA+d37tbIfRvdDM/xGJI6WDPnPJqghM7fMli88asbi9dF4ezPDJN6GvZDdGuDKQgDYEz32H+0nM/jtAmtamsSC5WLK7XHZYTnnU+lzVDfZydewvzz7Mv91t/tewtUyDqI1bX10mSjNj7Y0N53AwsUA/WHDwlB9dckZUlSz4Pn3n0P/eBCnFq41sdqj6LSGNw2S/C0sK32IRz8tWKL3cdCjbOqfuQSl+1L/SR/aFj0LoP94Biil6vneGoDxs08S7ed0P+FfPOhli4VJr4LULxBq3JQz5iBPXCIkDHaw/b11TaH14IcpX41Dmb3XqfhPc7YybOg4+of6KSOds9dPqeB/KvVgpU9mT7cIbFMTNbYF7DMT5BvQtelpVkobDoqTGUYxKg/DkPpaD9pYYt6IGT+ht7vSdiazyrNeFBZzfvTVcxLatIM/dgRYV39WZypxAodsuXDGDLrDUc5+n/9oqcFYnLyVZwKGYASTyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(186003)(82310400005)(70206006)(8676002)(70586007)(8936002)(82740400003)(5660300002)(40460700003)(4326008)(7696005)(316002)(478600001)(41300700001)(36756003)(26005)(1076003)(6916009)(40480700001)(336012)(426003)(356005)(81166007)(47076005)(86362001)(2906002)(4744005)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:23:38.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07eb082-f930-4988-d3de-08db70af3f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to pause dpg first, or it will hit follow error during stop dpg:
"[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000000n"

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b48bb5212488..259795098173 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
  */
 static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
+	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.36.1

