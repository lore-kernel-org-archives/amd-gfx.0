Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ABCC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 09:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2263F10E165;
	Tue, 19 Dec 2023 09:24:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F0210E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 09:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJpBUwY/8wX3QfZM7qyifkgPu0SRAKJC7p4VigwvpI/rtdF+B6MHLdJLSYPxoKb3/J4r4FLrlaLnUi7T/bBaii2ZdCtuvhAqr1RG6gslw8qdxacZl9Zot3BETPo8Qp0rzCWaaAA6f7IXulT1Xb5J/7Lw3nh3ItRTKbdtKvtCCaixu8mYCfpl/nTthhFbe2Y9k+CJybflYtuSzleGTiRLJmirtAtoF5iYy92c81to0pBUqu+iWPsyez5vceJYZTZUawO/WuoXG0XyZ17du844NEXKSFSQW7kgNruoQ220mYySQQ8AHB+vqUmAxk6DZssf1MEBmDnnYzIHiO1/vEAtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpgBztd5lcTzgQj2a4Y4Dw4wHGZX1jM+f9ruFcH7QQk=;
 b=n+XUjlTjBoOvLMTYcF2J7eu6rkivmBQ016IpalfZxBw8VWNBmIs+GuOmVbG3rVeAYQPrNqz7ZNYN37Q5JXJUCMdUgLX/5PUuEbGcnJCl5QU76UL5U/Q5oOTvx/HKpBnKuhGRjR9JzgSayK1tcjw1j5Cw6ldN6fbk6/83am1lNmtr/R/YhIP85J8APWAtlNFSiS7krG/O5jKGGMru+Nj2p2EA9nq+if55qmVYfWu0EZUZ+zL8cSfWBHeX+Q1ysYJmxeKVU0mBltvLfm1pUO7w4nPxmWpe0oi7nDhrIqByCfZIWFsYRzOcmweUmk/coWaKhuE2oiEPKBSJzXctYxgtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpgBztd5lcTzgQj2a4Y4Dw4wHGZX1jM+f9ruFcH7QQk=;
 b=4Ci2OGgIQet5ze7Nvrz/ag/2B/jZnvLn2rp4INQpTJ0GMJtX9g8a7FqVWoWy5THUg2FpRmwHKJo5ejp3Qnnr/KeZpw9aGJKzNrYBN/NgQMfkw2ZzndHKBGjRYqOEl14wCbTGdMIcRkFOgeiI7Vb19KcjWSf8BRvo7avXwsBSUxM=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:24:06 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::e2) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 09:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 09:24:05 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 03:24:03 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Date: Tue, 19 Dec 2023 17:23:40 +0800
Message-ID: <20231219092340.1601929-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f6d1b-cc78-47a6-51ee-08dc00743f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCNFBJwSAzekmYpVrl0Q3qcANIDXKx6ECubNDpj4GR3+UyAwoPtTWSfU/i0a/QLY8IucFiaq0L161JJ0XrxziZYOkGfxjhZNvFMyGzdLSdQJIDaFr0ToUvxE0GDZgXIriQJXAb4lY1au5KOVG2hAoWzUCmRJCWEXGHoaVmdXIxCilO6RRk0q8eRWQYXKRLGOEeF6eGe6MeExKMu7b/N1F9KuR/sUbr1KH1yaUEKjUY2ghcS1eLJbf3GeyTSp17qxyseZzaCPd/qYoBcKR5IGsAogb50CZeX7GG0gbp/MWpHNERdvF9ZnTVrJztwRiTK8Uy9AiLBCJxE6yb9DfXfc8zeFbLCA4BLCSdvYvE82mX/ut/wNYIQZu6GRVOu97mhZi35lZ3Goa5dTLria9qfbs5+WADjKmiUCUjN4QcEnHA/gYHFvT3/ffkABOJx8znr7dJ+c7b7QVgQ7VwkRcsikYE+NtkUm320wvHMebFdpOsgYLZdQzTAQlTqWBZ7FZJ6YH5JM3dHf1vwaqp20i8EVrlyjqApLuP630IPCm/9RHuOGfaSoiaVL0lmXnZyXRmFjniy9RbOkpCcsgcj/7Sqooagp6UTxbJSLT4BX1LeIgFcbVYcX4QEN3hyBc5nlY9rg/nzNPbzWKL7L1UCk9YaSVmS7BmPFguNgzb9hNQ0oRsT2wYqyEK0DVhrVK96QlhFD80h/F4EbvMONhR+IX+qSs8XWYTaccRQpyjiynjTbwRrcqvhXN9Xd9D9uj0Uze3NGXRMhnDc4SYpZY8LmvSzBAq/prEhqf9z/NEm29CJ4720=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(2906002)(6666004)(4326008)(8936002)(8676002)(110136005)(81166007)(356005)(5660300002)(70586007)(70206006)(6636002)(316002)(36860700001)(40460700003)(478600001)(82740400003)(1076003)(41300700001)(16526019)(2616005)(26005)(36756003)(83380400001)(47076005)(426003)(336012)(7696005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:24:05.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f6d1b-cc78-47a6-51ee-08dc00743f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's required to take the gfx mutex before access to CP_VMID_RESET,
for there is a race condition with CP firmware to write the register.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bdcf96df69e6..ae3370d34d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4518,6 +4518,22 @@ static int gfx_v11_0_soft_reset(void *handle)
 		}
 	}
 
+	/* Try to require the gfx mutex before access to CP_VMID_RESET */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* Request with MeId=2, PipeId=0 */
+		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, 1);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
+		WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+		if (RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX) == tmp)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		printk("Failed to require the gfx mutex during soft reset\n");
+		return -EINVAL;
+	}
+
 	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);
 
 	// Read CP_VMID_RESET register three times.
@@ -4526,6 +4542,10 @@ static int gfx_v11_0_soft_reset(void *handle)
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 
+	/* release the gfx mutex */
+	tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, REQUEST, 0);
+	WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
 		    !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
-- 
2.41.0

