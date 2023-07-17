Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556E5EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032FF10E27B;
	Mon, 17 Jul 2023 15:59:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970A910E27B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAV1fX3JSELobrpii1Jnjnp5SjegFuCrcGnr9AEaexn4I5NNzmZXFEn5YcmLRr7Ve0a20KM82ERzC77K/p2HIiWqcFMUvWz7TrzuX6uxM66RLC9wpLrmGLTq/wWdx/O/F7zKhUVuTDxCcDWnmNZWFCH72N3xTNDn2741RpqUeXuh9SJr6pEt4sQww6ITYCC4/MlHYwLupCQvcmJ4xdZmBSt8sAQudzRDUBYTBGgFGK1VsTNPqIcIbC57fmUstygBvaPpeIriO7Im/7PvlEJeN6VoWxl71ljKgglAImolJ30vNPsXnLTL919zNezxFFea96nlV+nzKC8K2SJIj4rKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=WY1ZnXyxxPvxLvusJqDiZipdg5T8Fp51a3ohalMtJzoroPlC5x9YCVTBUKCCA1u04AwPIf5dCGA5JbfzQPfbdYQFx1/1i+6JEIvn/fQH8MAE5g4OlrnL53Zc8gx0GoLB3zmPVg+/83sr5A3KGSteNgeycpcKVL2wNFc+myWYgofB3DrIyoEorCAmEA1DyA0xcg6CZE4sD51cRfGa1EtMDdGCQtJLYt9iArb0h0R7lMZHM9DBNqjOp36AwOs2tc4YTjk9Qx+1+KtNuCySPv6agiMKTa+0S6E9ge2YLrjajNdKYKy9xn/3w1iFiCpguOx6Kuv4H7EEv6mj8YsV7DlVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=VuVi3htfi1d2S/SyrjB7m3DwNaZiHRpUIDLo4239Fs6t0jDyl01MvqP6SxBFaZKb7ENRl8/jFGBLmUd6JkibXXFKBMG80F6EBfZIYvM17SLzll+J7oPcOwlNtSpu6FsQwY+M6Is7ZkERUF4Uis/WN6l7ZNACX608YDlHYAi53p0=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 15:59:11 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::10) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:10 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:10 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu/vcn : Skip vcn power-gating change for sriov
Date: Mon, 17 Jul 2023 11:58:36 -0400
Message-ID: <20230717155841.758516-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0850f5c2-16f7-4e8f-b081-08db86dec2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIeBg9wqF3+UYVcyNnCYn+4DJHv0zqKhbv5GSDhLiCQ9UBJt7hve8CMFaW4LQRb08T5+ba6Qdqbe+wgUGs/D+CZ5zTZlbx6lVWkbR/ZgHUoso5t6cac/FvPlpocWe4DQTCZ7oimBsOL64pMn6eb3pfCFI79M9qt/x4XKQZXw5wjouZAe/KIiE+EUjbHwekD5AmxapiEQOdzVSG584P5WntJetxEAtGfVtpbE4rt3IzWx0R4orPNwnB96ayGDKTSRAiW0DoisuxmrDbMEIRkIFcVaEiaFT5uw4r1ie801/6pUWGKq21e7xAW1wMASxTMc0KUjtL+V2rOsOu3lxWQXpJC4+xkvhXBiQhgYqXWcLqJukABIxAtCzZYMpH+7HdZcaM8NwwQYPW1k6k4hFXGCj1VZXeCZtfg2INoHzp1Ds7vmjSF9Tvemv4YEQGxxIhT5gLMr4pGwcQry+n995K9rq11beTEIJvFT/KCO/gYAHswvYnXPY8XQHC/2P5fKptYp50qXPR5ztp0mwNWFV9tBHFVHaxu3tQoQvr6XnmnMOGaCZQSyjRkA/WAOwh6/q+OtM3VWwTD8tE2Frm6djon24fF2Zzf3LEd948KMWdiu4LTjnEdy8xpnqDhywqTK2P+rP1c14wpuQTDfZAEPFIbVkU057LtI99Oamdn3EpPV5EImzvfVFlMhIbc5oAfK/wUkgy6dyXD6phC9dTTZqJ7/6oBGVWFuyZOsXqkh5socKSiQSVyNpr3rd8oABhTeCjiOvAjXe6Nz6U6vVeiCxK6Ndw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7696005)(40460700003)(6666004)(36860700001)(2616005)(36756003)(16526019)(336012)(186003)(83380400001)(47076005)(426003)(86362001)(81166007)(356005)(82740400003)(26005)(1076003)(40480700001)(70586007)(5660300002)(70206006)(8936002)(8676002)(41300700001)(4744005)(6916009)(4326008)(316002)(44832011)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:10.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850f5c2-16f7-4e8f-b081-08db86dec2c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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
Cc: Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 550ac040b4be..411c1d802823 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1317,6 +1317,15 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.34.1

