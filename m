Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCA6C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D473C10E18C;
	Fri,  9 Sep 2022 03:14:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C1E10E18C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW04iyMsCKirCLVyOX7PyjUkZpNguoPrB1NHacOSQXvq4EFdJTncZ2EZE6qqL8p62Zy0nTovxMSuiZ4qeVh0BC7wz7WujHAMZAtrRneXV/oHRvXzxaRB769T4+K2i/9nAx+hDCbf85NLq9xLtB0k9R2J/EGlOf1qW5PfwAkTnMugOIIj0dxYpMFkVcCfw2CaO5zuiIkjQiRK5urX4ro/qlWhO4uz2fGdKsVEUJWqNbOwqw0y4R/ESZzugGqdyhbXz28sJpqROEwE1TlnuoEoM0vZaGo8nfEeZdHNbLC7DP6X81dI2mZq2sQn9cAwsMUY2D21oKL9d+VkkSk0TFEdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYIhu+Dl21Mzm+FWerFmjvBhrPwZtcIuuCpWG7+kiW0=;
 b=mxS7Fg5ASbXtNl8G5zgB1ZbsON4ENbBiZ4goV1yIWRi3cS5yrnS9BF/Ru2lY8/tP9SqX+UDi7H1e2ffz4SfI7gzJg5yef5BEPQh5a5mf82s5dTTHPG5fVHN++FA4qz5pkiW+ksDpewPOnjjyJ5QULrXhR26D/oDjAL/DoJwju+8ywt470X7zua6KPfEtUW7B+0MojwlGQy0nwMd1kJMccTK7iBTEfXOMk7G/twfPb9GWMais2Z8MCThz94TszM7hK9lI7UziB1edpNUBE/cpl1yJYPfjCsVpgOyODVjv2yxRH+abYNxwM1Zay4wu2pkhxMV9bmVngDlGRRFGM2kExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYIhu+Dl21Mzm+FWerFmjvBhrPwZtcIuuCpWG7+kiW0=;
 b=1Cl0rkuQ3IhD6bQJ9Q12nlh5/ppxovI44TS+j0oSDaYhqGn9jNtD/1k2jpTYUSQjvmDtP1J1woKlhoWSJKIbJVOxaI9pW0G6Uw9UxbuDe88RtLVHv3+0uO7VJF26Vv6ohJO/tgrsqMBh2u1Puk6KWekcBfMX7A085GD8vcbGRdo=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 03:14:51 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::4d) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 03:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 03:14:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 22:14:48 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change the alignment size of TMR BO to 1M
Date: Fri, 9 Sep 2022 11:14:28 +0800
Message-ID: <20220909031428.3147161-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2ada48-096b-43bc-8f6f-08da92117584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVk/YvIvfRro83YbcaLYuWy5tl3YUNAIHIZ3P2azjFiUBSEGDDCEJgzsufMMIxcmXG1jChK88hIhFRR3QmzJ0Yo4oZ3mhVNmg6KT2b24dUDgP6ZzqsW/kqItvnVgFWM7ijmTnO6oHj+CsyyeG1U6QAMo2PaolnKsfn2QhfClV1jr1U5uqHHg7wnk180tu0HQLJ2eRribWkw8wmKJmgw5V64+ee/3MfQFwubr99WaeFh8p0FXpBzSC18s8P9nyh94eeGByPfcIGk926PqUfn3l/5gvJuv64uZcBdzuK+LTSMnMfTDxTq9JqI7GyxKhUc690+flUnDO6pMyWANwsgZ5odR+zTMKMZaL/t4vd4KQfFJrW1mtQiugN6xuwAqe7u2mhtKTXCAWe8xgg5+1Mzd8gacfgY0c1f5twRfyS/51x1yGXZlKFOTmZcc98Grvj43WkruZ2vDVehq1eipXrNY6OtFSpQeeJMMe+w5djYzG379P2m8cRVqh6cAHwIb8k/Csy4F+o+21PdKIPhUp4xuUlCzxpncctlKpTzuw5CCq2PNxNDw7UKwd1T8eT26Op7/PKAHoQR+CibhxFvYeP3MoMDncqaQPs7o6s+jdS75qlfOFj9jv3zjLPWpYpSI+F7JRMhZ0yncdq3I75zu8VN5FRrP4kXDRVB0oPXLKkBF57eApwzrz4Ty4MdCB6cjGvkd9bBbp9dPiF7WZ7tiQ+GoNDqbTtDM9tdn9j1Vop/LXopg0FUYGXBH30Lv4VLRWEBmyyFWIvKCUCGiDEVjyZB6Kc0BhJ0vwIKib1y8fhfeyAhuR9NQ0wHnfr4+QcEKIlz6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(40470700004)(36840700001)(40480700001)(47076005)(83380400001)(82310400005)(36756003)(86362001)(70206006)(70586007)(1076003)(2616005)(16526019)(186003)(4326008)(426003)(336012)(2906002)(81166007)(36860700001)(4744005)(8676002)(478600001)(356005)(5660300002)(7696005)(41300700001)(316002)(54906003)(6916009)(6666004)(82740400003)(26005)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 03:14:50.8192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2ada48-096b-43bc-8f6f-08da92117584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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
Cc: Yang Wang <KevinYang.Wang@amd.com>, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cfcaf890a6a1..5585cda8d24b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	}
 
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(psp->adev),
+	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, SZ_1M,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-- 
2.25.1

