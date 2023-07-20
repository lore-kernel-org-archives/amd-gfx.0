Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23ADEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C47910E553;
	Thu, 20 Jul 2023 05:42:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED3310E554
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm2lIaReThz/dobtSVHLBCei7I0+3KPCe9KCliJLayCDliHsLxyGpEvBwf7nhWFQUY4SISAsMxv2ipIc3qGG/EwivEwfUbRi55X1THjn3wVYFmX7E+WxXDy/l8NueKT2AFCk+455cOHWUZVbTjjicc/2DJO8vyOyqJV9XGNLcfBRHs7d+aOacS+k/zigRaS9YQNgmleQrr99hBDoIOjS8xl8mgdWSnQsYDdpV388Pgwg0WEqg5TENhh7+OXway/JBITTdkKYMSdnPda0TEN7z6fQtD6DNzxlxO9MrzRXGirfhZ+HmcjI+hNiBanQVrj7lFrKKg7PhVl2fOXddaj0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4cNHIDuE3B9qdFsPr3mLpOvCj7E/xt9v70GTrNoR/A=;
 b=cIS0V2utXQLoLfP+ujYoB/0m3iU3Zd8qZIlN6y6nHcF601fNFi0t9XhVrLKcitP2I0PDWHivqBXi/oEXkVKcck2vS+LeMMbLm15n3PVJ34RuorsmrysSIhBRXyQwps/+rNKvLCi+J8i1UVNyYcyhOgxYpRTl3iv7NzGlqnFisQhTT9dDiL0HRDrGFpcht27y9RL88dZEYcLKUT+hi4yfobBy3xExB+3jH4kl+5WVnqJCZ8hKBWYNqQtVceSpTnneqASU6aTKN0keWK7uMWRp4vmx/g1fUGZs1Tl3GVcxvwZJIByvp63q8HweNENp+TCIfggSySYrhd3o3i9ZQvs7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4cNHIDuE3B9qdFsPr3mLpOvCj7E/xt9v70GTrNoR/A=;
 b=H7vLXDpZC0VmcD2v87RUFmRcUBuKOUFqL6y9SPW1QRW3xrUFYlBv9uHbYINCBqIu+UqrK43mapuXb7/l+bk9reAkZHqXJh2nq1VGbP4GwxbcESogkEIG/qNY+KwRbIdBD4//7tWEUaw1ivJVXhLWBp86c1OUhjtdYXbTQyg4l1Q=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 05:41:57 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e8) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 05:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 05:41:56 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 00:41:53 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index
Date: Thu, 20 Jul 2023 13:41:34 +0800
Message-ID: <20230720054134.1187589-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720054134.1187589-1-YiPeng.Chai@amd.com>
References: <20230720054134.1187589-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: bbef4b03-b26d-4175-871c-08db88e407c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMxXzztCPIWLDhg3gMeKrIN6j/yYk5mex32KXCr2FZhP7hicAoFruaaW2SvY8pgoHF0xoyJfbb0XxLS0gn4Vx+lCEz44/zWj0nngTmQIR/vXJUiGPYSAw1a9td4rXabTzihxHjHT/FiA0zLCAH+eZz7wEl0OqB3dOvhhOWQTv35GU8ycBwmOHu7eOsW1l8WXoUUsn+gADEhOZG0H1YCT5H0TyutvJMSCiEnvDK0hub4eP55bH9tX7kw1pa2dgUaEDO24XSeyBaZpYhoQWHMxo6I6dEFrtnDrbFgB60CfoZTzJi2M2R03ST5UY5X5mLzZqVzki1aI9/aRCJFwxDIz03Z8YZcsQ05MZSjZeOjGUK88NpZYtWwZP3+h/v6pLmhYdb5GnRCGAIxUf6GZjmrqCkaxQtnUDMjfj4UkXi2B1RDmLiruNGCTRGz4NkktvHiQ9QddDpPphKo+BlcCQzw3FZvuVYT1dG+6k5EezEVajytHR3Wm+DpT7W5cFPIukhkqj8u6l8Jyie/EvFHfOvNesmPli6bV+IK8W4/ft43mn+sP/z66uAA2amowdewpi7+lnSViHv44PomV75f3RRIjQTXDwNVbb16b42kAas/J0SuMz6Ld81pRMyHBtLmJwbtZFrzB0tEXFVMxe3t8+2a9bszFrA8OwEBbFNVN990vX3MkiqZEmAbAGj5ye39t5nZCTDs5St2yP3ew+7RkM4ouZ9z9oLnCULJDE8d7eoqlQqcVy0f3Kbzkd1W07DqxQY+aZX7DrqEMzBil2hqdvNJfug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(4744005)(54906003)(478600001)(47076005)(40480700001)(1076003)(26005)(16526019)(36756003)(6666004)(86362001)(336012)(7696005)(186003)(2906002)(2616005)(4326008)(6916009)(316002)(5660300002)(70586007)(70206006)(81166007)(356005)(82740400003)(8676002)(8936002)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:41:56.5579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbef4b03-b26d-4175-871c-08db88e407c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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

Fix incorrect vmhub index.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d04fc0f19a29..c0b588e5d6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -97,10 +97,13 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
+	struct amdgpu_vmhub *hub;
 	uint32_t status = 0;
 	u64 addr;
 
+	hub = entry->vmid_src ?
+	  &adev->vmhub[AMDGPU_MMHUB0(0)] : &adev->vmhub[AMDGPU_GFXHUB(0)];
+
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
-- 
2.34.1

