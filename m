Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE72CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9923D10E42F;
	Thu, 12 Oct 2023 07:41:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC12510E42F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6SB4F7WulXLE34oq86q9omztu8E+8ASFdxHl0IJZWraOYKNYA3tif5qpLWtkfyAVTQKO8M12ctvQuEEXIOevT/XXSAGsdtpMNE1SmKjCEHlDmaD8e1k7Xg/fobB1Z0yLPVIqUZfPPzrgunMnCVXvGtrenTktk8BXP8knX6cu8CjWwxxL7OreYAShsglCqIo1oso43vYzF27SWJcd/msvGXVyKRlMI64q/nurhMa3q1/ehSM3Ak//NzG5PZbtbavlR1X7yfYLRhIGk14hF/O3VB+Ke48amd7bT1TlBUtuReKG+Pez1AlcHYOSnQyCzOl5u4OKSEKJdoFTJzrR0rsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLu5Du3XZeQJ0veo+Qcoh3097pVtQwzg1weCVVDQ2jI=;
 b=AbjxMA0QUIojh5ljWIZ5wl52dhPYMciYgFk36lTxaVP/oeqCMWXnAjTgKQIWaSLgaBupZMVYAa5fN1aCrd1TbtEjUVh5hNnE4nDVcwhpbgB3kxxsFDdFGsxDFjhtK5/+hbqcb+jPAY9H5caobw3frEyr4TsPBDshy6q93WyIrZsPUZeFYLAVIgKY8Lp68sLfoFaUe7LW91CDJGN6CEZClG2jVNyR8QDdWNp76pKBZOvY39JW3PhO2PLTgzC6Fj8kU6gqe5H91QEzXVnkXa8S27p733sCFwD9XT63AQL4i8tM8WuuOIH4TSu0cce57SE50eQ9fbCI5NJDeVf3yCWKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLu5Du3XZeQJ0veo+Qcoh3097pVtQwzg1weCVVDQ2jI=;
 b=Dcl1GKjFcuvzeZY4ezLt+d5hotsNcVl+fbURbtKDVQMLJfM/v+i2DYu7xRwHyzYl5l9WeXTrLaTcXLGsfErOy69D+tEdDPobpXhErLxQ1UksPaZPMZ5xzLVB9y915q02oQBpueUUbG8P5eio0flKYe3TxedKSFtQElqKY+JrKLs=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 07:41:33 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::fd) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 07:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 07:41:33 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 02:41:29 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: flush the correct vmid tlb for specific pasid
Date: Thu, 12 Oct 2023 15:41:15 +0800
Message-ID: <20231012074115.660773-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a8f4e1-a5de-4ff0-f0a9-08dbcaf6a80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiW4h0ict1tgq7hcTt4JqOwbadtEAaFFjaPD5J45BP6tACaMc6gXcDHv9wNxNx1L5qj0bUuE++PJm1yTuXuTVjSzb92E2so7CzYef7pgUfbJc3suqpwRJgA2A8xTT1enmHCvzreVBKOystIH26okrGZy6NPv189KqcCz+N7Q52lC3wgFtXrpXL1mCMrjBNhTweVAKhO8kf0U9UgfcL0DOAczhp0b/5FTJ2xeyceX8SYVpfmQxN+TvpXXhheoTKw1tajcCnJqf0BdyTmKoJHYeraLlcwdW4Qkj/gNj6PNbSr6sF+i7sXPxNAEKjDkKxE6xbXylf/tmgttYhUESlkpW9JcFYHSFbwICRjfXwrNtPkls4z6OieFNqg+dmz8MIVn+oYGlVqXsSl+2dBOp8jjaOFCwOo68b6QBqq4vFnNO/s82LJc6+ZF3op1gob78E4GF9QtesjlwCVEAa8LASZ6R1dx7ELXQha1v5t8K6FwdiSGU/VFwEI4YJ0j3yF7au5U68RZBlOWWevg3u8BwTGPf4OhCh8q3lie35989aOSo9N7arTLZZvJfHIB0/BAJTqt2PaYoFxJctyy4jETlHOmprLX9O+D6H18H+DgHAuVN1MXiSu+iJC5m51LJvxHh9h5eqiMgSFDK2ZtwzPOfwW75lKDVh/cSulf7AcEjFrY+TGRbgl0tOE5rVj/BJnt1YA8xWszVUcmzK3bzJG7X838Er89d6XA3JysRy8+E0NetqUn36jZWopFID3QSoGBa86Ld7gvq9dK/MYrWUvdFQ6wBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(86362001)(2906002)(40480700001)(6916009)(5660300002)(54906003)(4744005)(316002)(70586007)(40460700003)(1076003)(2616005)(41300700001)(7696005)(6666004)(478600001)(47076005)(336012)(426003)(70206006)(26005)(16526019)(36860700001)(4326008)(83380400001)(81166007)(8676002)(82740400003)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:41:33.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a8f4e1-a5de-4ff0-f0a9-08dbcaf6a80d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

flush the correct vmid tlb for specific pasid on gmc 11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f4bb3886d1bc..19eaada35ede 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -314,7 +314,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
 							      &queried);
-		if (!valid || queried == pasid)
+		if (!valid || queried != pasid)
 			continue;
 
 		if (all_hub) {
-- 
2.37.3

