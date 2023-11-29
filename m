Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F8AC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 12:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6838810E1C7;
	Wed, 29 Nov 2023 12:37:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7331510E1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 12:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNh8W3gGCkIgAcCqV1P5/HFtyzJ2J9yrGwK0jnI/dTcgbSGShBx95VFsliBQuLOhnYWF6Xg34Dkg6O1e5y/DZBFlT+A/mJVZESTvm6YNzSIodszgI2Yst/wWUD7RPS1z9Urfq6lYyOARwLwl9F1g6TSyZxwWhHTjOXNmhpxY1Py4rOHaL7XIhFxlNzkB8yBUECyemGfMsTSmVeO87BrwlG6xLIJz24LkygR8v4pKY6+fQGuYNrll1qxIwitDVF6NlyP45LRvDWw1kjLfQkGcE7slUq6Byr6nb2IaysamwzhacRZAQi2zvz3U571p1ctyYms96LQWTvQzunGhJPhDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LAPwg8/5TISpuI73iJN1AqkH1d35KiXgob95m4lHIo=;
 b=ZYEwZINjMjov41BqJOBbRUA4fePr29OWovjIK00NTve2VpT5dfKD1pdGm5rdTzEh8Nov2iCycLthQMJrst5BT4tPdgrBb0YKhfTyiT6GBtXpx/C6FdRxm0blbor8bz7h1HkwLCPxt3xovdgj0c5Q0qk15cTyTgTxisJvksPkk3ZKatT+u/OuV6Q5ZDRiw/wEy86RiIO7mFuyBuiRbt22V0P1zHqSdKwPLC+Z8pURANqXK9TadAkVMcO7Ydk6expeQGOt4Ufl0zlvmYdrJgJDMuRpQA92PmDzG2dKvtKHHIB7RGOr5+PCRzZGe/6dJthSSbJlgKAj8MqafN0HiXc32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LAPwg8/5TISpuI73iJN1AqkH1d35KiXgob95m4lHIo=;
 b=rAzL3JPg4h8KQU8hV5pwSO7ANX5XOVktTkrBGQOS3lpM2PnYJtqw0YVnwpni/LSipZ6GZ2ZHeg6+mqqUu+Hk5U9njAp+iI+BGhgQFA5EMZL8BtYD2O70BLePh9sDm8L/V3XP9GWjSMj6rpMmdQ0RXEPkJ36q/59WmniMy6NBm5Y=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 12:37:12 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::6a) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 12:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 12:37:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 06:37:10 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6
Date: Wed, 29 Nov 2023 18:06:55 +0530
Message-ID: <20231129123655.1161175-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: e682d745-7eb4-49a4-38be-08dbf0d7e948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSzjoMm5Z/qmx6JRGfS5GD3/d249pRA47UHIfBAIReHV8JRBHX5A6dDLUR8XsCnotShNECyAE6XigAbEmez2xnE2yYbzPPzI679YeP8X5lBvQprSDnKTqH0uTdXkuBI+2ovObDkKslp3t/zAZ56dAUw1yINuoLcAFClhO56T/c9y5ek4uvpuVydg3ZFOmXsG+EIJ9d/mZiDt/T7kGBMosHrL+f+AwV86FHfjQkiQBIEFC+HTOVCakK68SJI3ITBG0lQ1eFVrwDyI4j9Im/viYgDc5VRwONggIeqS1uD5LL/GoFfpTT54sPG18CoIb90i/q92RTEDVyjuCC3skdsyhRNDZ5IG4VwbqtPWp5gmaKmVYuXleMjypOx3YCYXwnILNHa6RbpfbrmqtZ9IAycZc7NmrXWWv8d/+fOd3tnAzkWIRbiov5n05R7Xc4eoaZhF+SyjKTHeoftvTitm8R6/9JDu9soHADzyQ1orvC0DawptrCAVW2WTeWHWW+mAC/irsvDtFDxh6Va4kxgQztExNxWcGC0UZXtwX1H6H58EuwrQl5+6WOFTfl0+kfiUcWZ1K2zxyFxF2838iP8DZGVskHpuoSPSIzX6qGWy2CR8/ye3+Lg+rZdDuCe9BwzqtxdAfhDjJszL8vWNgBW0TBSHyUgHr0BpiTK60bb4iQnsg5BmExmvcRhQyiy4vIDVui5ruc3239Yy+/yDv+ChiPD5nF+eOqNoq23K+wagyYEz63KPi/7gCqn+LUu3/SHJ3YYi0OcpHIBv+cyNoop0cHcEHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(7696005)(83380400001)(81166007)(47076005)(356005)(82740400003)(426003)(8936002)(5660300002)(336012)(8676002)(478600001)(316002)(36860700001)(6916009)(70206006)(70586007)(54906003)(44832011)(86362001)(4326008)(2906002)(36756003)(41300700001)(40480700001)(6666004)(1076003)(16526019)(2616005)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 12:37:12.4422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e682d745-7eb4-49a4-38be-08dbf0d7e948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
Cc: Alexander.Deucher@amd.com, Mario.Limonciello@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only PSPv13.0.6 SOCs take a longer time to reach steady state. Other
PSPv13 based SOCs don't need extended wait. Also, reduce PSPv13.0.6 wait
time.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 32048b805200..d335d1d2e93e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -60,7 +60,7 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 #define GFX_CMD_USB_PD_USE_LFB 0x480
 
 /* Retry times for vmbx ready wait */
-#define PSP_VMBX_POLLING_LIMIT 20000
+#define PSP_VMBX_POLLING_LIMIT 3000
 
 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
@@ -161,14 +161,18 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
-	int retry_loop, ret;
+	int retry_loop, retry_cnt, ret;
 
+	retry_cnt =
+		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) ?
+			PSP_VMBX_POLLING_LIMIT :
+			10;
 	/* Wait for bootloader to signify that it is ready having bit 31 of
 	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
 	 * If there is an error in processing command, bits[7:0] will be set.
 	 * This is applicable for PSP v13.0.6 and newer.
 	 */
-	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
+	for (retry_loop = 0; retry_loop < retry_cnt; retry_loop++) {
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
 			0x80000000, 0xffffffff, false);
-- 
2.25.1

