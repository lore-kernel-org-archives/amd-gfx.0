Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4165C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC70073E4E;
	Mon,  6 Dec 2021 10:20:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1DB6E8F6
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 11:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn65QNFwSpDt1qoi6Jv+ivFIJk22sibMbG0r77IgRrEMkZU9II0j5TpIqnKayxAPlwz3kqHlb8wDlVxPFur4avBgq1Axx8dfXgy8muPxV2YapxHkj4ZD3bvwBEI97a5PJgCob18iLRy3sV1iOAk/hWHfS2LNpv5SJN1uVVYH1bo7ZYKbEuL1iZsmuogYOIvuEntjKCSk77SSBCd2py276qA++WiLV8n9tTdHHdJtjlw75qH+lbyl0+loOOTiGED+qX1oJPE8aUhlJCgVdh31MNwzRKtS3zj2IYstRJrMh6wG4GlOG9cFKde2SsXy6/2CZTpS54jND8A/lpcHlCMO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1c7O8/+XKJm4ORWhS1YKiGXMh4WbFs0zWikShgl52Q=;
 b=BYr1qfDmGZtZFYbb4NXSv4SiCfzpBa1LHh2ihJTkw11eBLQZ0600BZ3ZdwDv0F+6Nx3NJ9ogXWoosBT4ymFUIiNm+RDnSLJ/BeW1GyfDYJx34CPX4RodYDzwGJnam8zX5t6FzRSwFB37Bnr8zDNrU/TWAQo5lklY/tnqKuHiqK2DpTi3r/cCsnHTeEoszxOF/ya7lql7C1chXprDgNTm/fKPRfc5A4b5I+soeusC4wPEl3z8gKrSzn8vbw9oc4vdBfySLUlEnrPgEG0Trp2MIQELxyrWlZAIKws1PVMYzfOf83H5RWAaLAMrLdB4jf4xQk77uejyFXqVoT2CU47SAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1c7O8/+XKJm4ORWhS1YKiGXMh4WbFs0zWikShgl52Q=;
 b=bFyrk3X2JNMNq5LTBWbOoInjw/PelM5d92TH9rlhLhTf7qQBD4ejbk+b7wSnPbroQJwf9+ZYX/MxbpRvLjQhH0nrYrpoamJyF3WamLAaHmZQHCvXzp3ExCuh8N/l+9JBv9yY3mAyGMbVboP4D5CqHNok8x2zSD9zKs7YqQ7fnnI=
Received: from CO2PR04CA0104.namprd04.prod.outlook.com (2603:10b6:104:6::30)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Sat, 4 Dec
 2021 11:02:41 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::a5) by CO2PR04CA0104.outlook.office365.com
 (2603:10b6:104:6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 11:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 11:02:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:02:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:02:39 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.17 via Frontend Transport; Sat, 4 Dec 2021 05:02:33 -0600
From: Le Ma <Le.Ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct register access for RLC_JUMP_TABLE_RESTORE
Date: Sat, 4 Dec 2021 19:02:26 +0800
Message-ID: <20211204110226.15556-1-Le.Ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3a32e5-83e6-4612-fd0d-08d9b7159769
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4925832CD204337391FCEA07F66B9@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWZLir5JVHOJ6gXeBSrnHENEQ2ibpQmcg+x4F4xI5iwmZRTPQR1XtSt2HF8MQjVHRXmv4L7+wNJKF4q4Ty7ZAKVfu8opdEvobVXqg/Jzy1kbIWW+51EK75Z/o4wKGmLYfRJ3xS74orOdeNKSNUvsZHvQ0VDDutg+qWZ2mDBV6HiAxTqQUuiD8VihpLVtJDuMy+nkNfeQ7lmevZaYwu07ngxhqLRx/d1DoZrAJsd8GiYcB2NQqG+sA7rs+oA+8mMBge5SuMSNK7VQsRqWkSArIsNUCV03gMQROHNNxhzaa4GnNuqoUX2GykyHTdiMPC4lE7OU3VkYORYpogxwDCeCNWu3ebeHdg9RWlXiFITUbQp1wckWPEQGTaxy43MY4kp1xWDFEmGVanrKLYua3GfBjaF3cbX65Z7kzG2ebp4NUXKPKMLTj2OX4Tgits5T2gog1ewqTKBCiQ1VO4GbrFtxymohpGE9ozE0sT8dW4+xYpbBGWx0Crr9zpy/nDQvbPQgNY03bI/wYVbRVerNBlFkTilrCbvORLxSGgcUxjHKaab3NXohrFfXCpu37EbqXzENPfz+hylJAkRU8C7I+vwG6ww7bjkryfSAwjMrh2qX3OBr2DXcWAGjR4bYl516ZaWgWFStotx6aLhBtwtIRrIXCmfX+vEKp6LgwItgwaVQFEuSCTGTCVnczqtorfdb60iOuJs9kUahmuqs1Ah/V5Rk1tNNCkxD8x7F9IV8GgkG4AkcCw2cqyp11WWsuBIDRLQKH8BsizztG7JoVnq/3MkkO9QSwdPgJ/qAwdnViMKTHD8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(356005)(4744005)(82310400004)(86362001)(81166007)(2616005)(2906002)(5660300002)(26005)(8676002)(6666004)(7696005)(336012)(8936002)(186003)(4326008)(54906003)(47076005)(508600001)(36756003)(36860700001)(40460700001)(6916009)(83380400001)(1076003)(316002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 11:02:41.0565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3a32e5-83e6-4612-fd0d-08d9b7159769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

should count on GC IP base address

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b305fd39874f..edb3e3b08eed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3070,8 +3070,8 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *adev)
 			      AMD_PG_SUPPORT_CP |
 			      AMD_PG_SUPPORT_GDS |
 			      AMD_PG_SUPPORT_RLC_SMU_HS)) {
-		WREG32(mmRLC_JUMP_TABLE_RESTORE,
-		       adev->gfx.rlc.cp_table_gpu_addr >> 8);
+		WREG32_SOC15(GC, 0, mmRLC_JUMP_TABLE_RESTORE,
+			     adev->gfx.rlc.cp_table_gpu_addr >> 8);
 		gfx_v9_0_init_gfx_power_gating(adev);
 	}
 }
-- 
2.17.1

