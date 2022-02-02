Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE65C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 09:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563D010E73F;
	Wed,  2 Feb 2022 09:07:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4468D10E740
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 09:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0me5x1uuqjPelv62n7Y5e9AnIrlpCqfbb30dLM60n3nRaa+wTGjRtz0RMvh+AeYR97k/NkKUkkt0TJ0l0e521BFrugz7ME7c43QE8M4czvXuNjv6yiEzk5VwtH5S7RDTx5KUupVBz0rn2yjL/SI1GGndFNGB2Wh3yjnHTjYoQPT1yETo1odrAiCBm4+8j7pizMAwKQ7JdTDtyIgbw0mn/PFWDnZ5cSngBwQJH+kruIW5WliJOyo736841yWR3Zm+XrSPulAFtUmzZHdG5dVdIiBvgFWL47Kba7CP92TWCWPDI9GOiXw5NqGfIQmrcJfrDOpWMG0EYCrbJKcWhGHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVovrMr/wEstSxq0p6czEhB5e0Rcd4icTi9Hw1soZ7k=;
 b=lEkZUdTkQqHyDGcB1ogns+4kBzxOd8IC3PxywginWASPvt6sxoEDGkqjo68Ti9miFG81rzSHNPfgDWB/NU8vtyg4RislMXR3pwMRrlBmqHlxq3ccpAfq6s5CghZpUJ2j+bjq0xwEnHoa67ld/tZfWD4dO3uz7bE0Q7J7RwmbXU6vcso27n6FhA/XrSo1Dz1HqtmXvg4uDbC8krm0VXIohFybrpvZiVJnOLrKMoj9MFZjrC/hdgQcZSlfdFfeAc//Uao7MNpT8J7TdL2kfC3sNmVPNVHCgOFeBGRG/D86/IeLdznPZwheiX1jrN+YSABZE1duCqI93sKJ2OR7phw2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVovrMr/wEstSxq0p6czEhB5e0Rcd4icTi9Hw1soZ7k=;
 b=1M+AksdyfeKHvu9N76+peOYOzH1n/+pqLj+PgZvduJzMJJKAKAzAYPj/ebdbDiBTOr3an4IWx8eGk7T5EtVLg7TJ3V3cOFGiV2P37iiujU8xrJyFcrfsW1eX+sA7Lpam4i2bb5z1G+Dhbf+CMKCYkEs+q0S4538NhewnVzmrA8k=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by BN8PR12MB3235.namprd12.prod.outlook.com (2603:10b6:408:6e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 09:07:16 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::1e) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Wed, 2 Feb 2022 09:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 09:07:15 +0000
Received: from ETHANOL-DEBUG-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 03:07:12 -0600
From: Rajib Mahapatra <rajib.mahapatra@amd.com>
To: <Prike.Liang@amd.com>, <Mario.Limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
Date: Wed, 2 Feb 2022 14:36:44 +0530
Message-ID: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac211d69-05e7-4bc0-9752-08d9e62b685a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3235:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3235B743F90181429F05B55AF2279@BN8PR12MB3235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDTxPsJyloyQYLLIvkE2S4MzaVFSnRHGBI38oEJPYT7xHLyTulP3eN4Fq8hIDfqtiJOZwd7DwnKkYIEfVf+QSOFSSXohyAhXJh8QED8D0LBa0oTHvFoSnl1Vk4RjNy/BBLdnRkXpQR9KfplsuOMt8ePVQV2KWGkuxXfrEXKsrMKFfOByfL5Ou9Wp4H6aFXQWJAHKugDq8BYuld7Jr1E3clm7lDsxAeJeWz8Fv4cnj0wgdHuCWkgX8KOs+kp6HM4FaS1TF62sEZBi5cjFl8oeROsX1G/8KbKj6XR2fCePs0GhIJi3NU0+qIfm1eG0H5gQcxW7YVm9PR2Q+lqYfjecn0lU4QF7H4q3tf9sWIoVi1nM0VpzFtiopd2EZ9pSEs3kDSNgiMGw1ayMTtEA0NbiWfd1Tmm+eej5Wkd9IMDO8fvZ+3brNAMu5vZsX5p1hKjU9FSJR5bJYk8fXE+IxTciTXXXPg8fdDdtlWfq0LZZ0lsU7ZilFgETnettTgjSnCr0k8ln9cJtHsdZLWCa2r6wfJusmCLU2QAssRyBoj7O2tdSLBFuL0v9VwwGHXShTyR2zC/ZHpbjj2EQXqLjCNGL9ICuODk3UPoAcPsH7135YVP34+qI5Kz56gjW7E79hmh843naw/nvz1Vd2ous24N/5svBbrGAqUjXptH4pHzJ0zN1K/cOtVwpQQxeYcwZDFCqi06KKLFDTnHxgNGxwZe6PU5eN8TmeT2W+EIhgptQJup7VF3qDAyPz788M/UhbsXzmKE15VvOV+h7plkfolPLvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(82310400004)(16526019)(1076003)(2616005)(426003)(336012)(186003)(5660300002)(26005)(36860700001)(15650500001)(47076005)(83380400001)(40460700003)(316002)(7696005)(6666004)(8936002)(356005)(6636002)(36756003)(44832011)(8676002)(2906002)(4326008)(54906003)(70206006)(81166007)(110136005)(70586007)(508600001)(21314003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 09:07:15.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac211d69-05e7-4bc0-9752-08d9e62b685a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3235
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
Cc: Rajib Mahapatra <rajib.mahapatra@amd.com>, amd-gfx@lists.freedesktop.org,
 shirish.s@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
amdgpu error observed if suspend is aborted during S0i3
resume.

[How]
If suspend is aborted for some reason during S0i3 resume
cycle, it follows amdgpu errors in resume.
Skipping SDMA ip in suspend solves the issue on RENOIR
(green sardine apu) chip. This time, the system is
able to resume gracefully even the suspend is aborted.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7931132ce6e3..f01b1dffff7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2927,6 +2927,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
 			continue;
 
+		/* skip suspend of sdma for S0ix
+		 * Resume has issues if the suspend is aborted during S0i3 cycle.
+		 * Skipping sdma for RN/CZN/BRC chip - green sardine apu.
+		 */
+		if (adev->in_s0ix &&
+		    (adev->asic_type == CHIP_RENOIR &&
+		     (adev->pdev->device == 0x15e7 || adev->pdev->device == 0x1638) &&
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.25.1

