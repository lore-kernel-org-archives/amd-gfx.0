Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F6FC7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 12:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1B910E0BE;
	Mon,  5 Jun 2023 12:27:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C9710E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 12:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avTY3pZ1c8O9vg8fYqLmH+5V+tK9APUznvDPkfjbZxvudD46L/12U5aIu0q1K1GN9B/TFIg3Gnad6ZKUqN7rBEgXzYVG0cVI+qtybds+tD04rTqPUrnIQ0A6U6BGC8IR5igC5A+Hx+1lTMn8eBgQ14P15kNqIAVFaCcakwCv12TSjR3YYYezp/Hgf4tt/0MM0gAymMlBQNFoJLK9wZmJC0iXuuoNh3u0qtXftYt70dXod0imE8s+PfinvgCtg1aYf8SjYIFo87vIbtmiX8RkGwCGUMUQRWOe/hhqmCjX+bWBwkdiL6kQHGf1fXcpZB8W88OGj0qW+fqrTCC2EAWlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2rQgrTN6hpDKYmP7KwUiFnC3sWQlqKhrNTskUtOrOM=;
 b=NLHM0XGpEka9ZKgeVxewBr+xPuPAJDwW1l1aWO++SprpPseKgywxtjOhKS+yIeJ/sy7HOHqkoxETWbOV5nhZtu2U/jwGdQnmPmMYZzX/Ci0I2B1IrODicHOAn5l2j7iv8LTL7RyW16Of9K2xn6uFNUFgHFDKNROS7f2+7p0j+V4OtLvrZQYjjmGkhH9+zu4AFr+nGJYcO79j9U4St22FzsTacp/99a3ifer69Xi8aqXX4O5D1fPDD8yMSBUD4KOFdiZ4yDLXSLHalHKqYpledOVfmntlU+/Hh3NaMS6FbdH7Klcnnx53EfOamWRnJ3QfGkbvHSk8ZxwhCXEmIdEK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2rQgrTN6hpDKYmP7KwUiFnC3sWQlqKhrNTskUtOrOM=;
 b=UffJVeQO6njGODPe/bu5+Od8iZuy7bjg5tUwMeN9+gqwoMya6t5wzL0hyIdL5zgRHVdSJ4CKantGfzT5mD7LLipjf/uCXSvqVmFiiRUHx+DGROFBh738oi6cp6388FX8UcLGM1YRFZGOSTvBxqZOgWho75uNDgpWDwI9BX0VJi4=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 12:27:50 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::b4) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 12:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 12:27:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 07:27:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 05:27:49 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Jun 2023 07:27:49 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review V2 2/3] drm/amdgpu: support check vcn jpeg block mask
Date: Mon, 5 Jun 2023 20:27:43 +0800
Message-ID: <20230605122744.3484-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605122744.3484-1-Stanley.Yang@amd.com>
References: <20230605122744.3484-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6f0914-57f1-42e7-e1fc-08db65c04734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwUhnpRZ6wf3T78eVbU+nIbyQAZ24XDDvCkesMBUvuG3E+Bpcgbr0oSo9RWzdgOY2xrl56h0EGjx85tTcWMthSOmj0mwr+Kk6e2kCTZIpG1/YYMTtKiLvatWTxD+eUeREYsP24VkT9fFkS6zwjXJUGWHgsV+OBiqCcai3gQB/0PISRh5Kx22Ih+nuZ2o2kx5mfMls/gsd/dLje8lmxVAYcIupzF0IutZpM36mCxk6Z+BVqqxzSrpdxOebvrvKGDtc5ixMk6Y3bMzTh9KWJDf7iYczeCkqirlmlKShoNaRkul039xVtcIlVqPta1/C81m4p12ypEfuUgyuyBRnZ4lFyk5Z7QW/8tfXR1/HqkcN/26JOXqQUkOPKlFXYFkLj2gQkMfawJrortlHMGLGhjSeItGU1+Y7p15gpCiFo1F9xNQ+vzD1lfslripZxJD0DSQlLqNm1WcXfdtCLN1BGBuA1OeaoFlKP+VnQQscQjgV3m/Q2R2ssy6KidpzeE/ICd6RZYnfKAPCHcrnXCKkJPGAMs5csdMHD5C7Rm5MmpjeGjkqf7sxTtl2jjdn+Lag550gizvyb2w1eQogkEtT6U6hkFI2SjEIG9dD+xKss4+hQUU0RWJxwipTGD+M1f8ZLmtcsFKaJA+Jj+KBKcKn1VCVRDD3xgtjqw1bx5dad6tPLh43pDh0wTDQAAs1jtUSZUdk0Ia1rULOQPj0/k4ecg0/FS2OQ7nxQQSpRFP8HM0HWA42Ye0PT+aTs4dsdc5JVAhPiqbNKLYxyLmAf8GRwv4oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(26005)(40460700003)(36860700001)(36756003)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(81166007)(356005)(82740400003)(186003)(2616005)(40480700001)(41300700001)(2906002)(4744005)(478600001)(70586007)(70206006)(6916009)(4326008)(8936002)(8676002)(316002)(5660300002)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 12:27:50.5362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6f0914-57f1-42e7-e1fc-08db65c04734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support VCN/JPEG instance mask checking, pass logical
mask directly except GFX/SDMA/VCN/JPEG blocks.

Changed from V1:
	correct a typo

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index eb3630e480f3..c56a5a6f9e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -360,8 +360,12 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__SDMA:
 		mask = GENMASK(adev->sdma.num_instances - 1, 0);
 		break;
+	case AMDGPU_RAS_BLOCK__VCN:
+	case AMDGPU_RAS_BLOCK__JPEG:
+		mask = GENMASK(adev->vcn.num_vcn_inst - 1, 0);
+		break;
 	default:
-		mask = 0;
+		mask = inst_mask;
 		break;
 	}
 
-- 
2.17.1

