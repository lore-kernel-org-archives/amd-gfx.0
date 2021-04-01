Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD210C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 11:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EE461041
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 11:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EE461041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BF96EC88;
	Thu,  1 Apr 2021 11:13:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AB06EC88
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 11:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbE2d/qLPZWoCAb4dcvgxSD3r8PktvPsfgyKBBLLoFYWtXrNZUoeYs0pGI7As96miQIxlOd/zQaIVL9ozJhDCQhUu8eu6q9pUPVxmn9E6zqb1JUmSKDVDIQLWKw9MXv8wpPx5NgM9G540dlEHkyhFRfjtJThBSh0/xq+ym45fgEsaWkAhFY5IqNmzbUKbjRLWwvuu61xpGw9DJQymyy6KvjN7YGeccQEf29UfAgBgK8FHR968u2W9Al/P898bYZXVfpDpL38z0n8BsqDC7eJK8JSkZY27h+v6sMQby2S/ae+7E08JnDx2u+AOXkRMdd4XVDER3VmRfvwjkD2qOOGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rHGUFSNA7pMrFXVtjhX5ejByQHnPY9Oei6NzDbtlFI=;
 b=K7tL043Dzw4mAvu1+UDsvxQlEDb/1510i0v77RWe66AlgGXwh59uLv3PPcGUeTRS4TvGDS+48TaruILSYIWhsx07EOJEaVJxm7OAN3QB0EcBsBz0VaEXZ7wXld2Zf04rHzghVRnJrazhIbBNbQydETiAtYR3H5tosGNs8uvHa1t8J8f3DoUyRPUOYiknl58Mt5yyN0SDoeLU/xxIdGGB7kOt47BPXQsxDpszJCLOTAzKAMNucx7b5HhLSLLjss4j3Sj8ej1ksesS4Z7nlNoIvc25EVzqgXbkdgOg3RXJgDO6+sncxZtDxTvgO5aXHEb7yv+DUavW5585zAl/ZJkSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rHGUFSNA7pMrFXVtjhX5ejByQHnPY9Oei6NzDbtlFI=;
 b=mRgvDTcq6VxgfCwEnWymNnLBKhbVEuKd/SKsrUlQBde4FlaWLDk9qQ+FDFmEZb9hMAdG2X0LdA5277JIKTZUi76a8dvvIyKbZZeZK4lwquIMLau46FatjMkDDZiDWGkqLQvArDavapM48nEfUzi2s8n/+uBTANE7ecnRXSB+evY=
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 1 Apr
 2021 11:13:48 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::33) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Thu, 1 Apr 2021 11:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 11:13:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 1 Apr 2021
 06:13:47 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Thu, 1 Apr 2021 06:13:45 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: support sdma error injection
Date: Thu, 1 Apr 2021 19:13:44 +0800
Message-ID: <20210401111344.29431-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30156609-3df9-4578-7bf4-08d8f4ff38cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30814C6634999C0FEADCA60C9A7B9@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHnJUW1QSKOH1mkTEom+UZWIUTnBFkSzG0odCeJwA17UOfTdcFtc55P1eCoJ5OqUxSe16xwjt+FZlVFXaIu5PNECdHugzueThJ3rz646sJcax/6KYVdxoqePWjUkgp+/AhPZFrOIJJyDx7o9twIluWX8fyYD9BwERoWhGFMld6VLLlIUx2O18E+JkYTOmjvTxUFJPsBwetdgb4pgy+iyZL8JDWsbBuXMeF5Us22C7pGNvjHXZ72oT3Uq4y6Cchs4i27EloZR1AoSn7CYUrpF7aY4u+IAoq51y9OsRtG7KBhyFcEWFNKTI3rsTBoRfvqGRXHaj/FEsmsfOFjGM+k+oo7+Q4fjudJY3a2pzDhUnMxearStU3nN2GCvy27R9YL4Dkwuj4a/WGDu0rwnBS/HsgaH6nG7PY/KivYHvpdWNiBEHj9PUt/V/UB9yunf2PAHqnJdUWs86Td8Wt6cwpqvudRu+mmiPGMoSjhbzaNYW6DfyqOPnzkS0XhOM/iKqQykhBZcbHkTen4VBdtb/5F4QqnjJKVa2qBHTSx88ykYXyKRDjp+7qM4YyP1jAEo0Yudc04voQWkm5Up0wCWlfbTI9b7TEHZ619L+AkK98Wlj7l0irwBmLJrLSvNF56fjR1wfeqId9CqHN9jFa2w7QbyzhMEhrOa1lfNFxedDDNxY1UR/Zv9TVT//iE/zB8NY0SN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(36756003)(1076003)(36860700001)(5660300002)(4744005)(86362001)(70586007)(316002)(356005)(7696005)(8676002)(4326008)(82310400003)(8936002)(47076005)(83380400001)(82740400003)(2906002)(2616005)(186003)(336012)(426003)(478600001)(26005)(70206006)(6916009)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:13:47.9172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30156609-3df9-4578-7bf4-08d8f4ff38cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, john.clements@amd.com,
 dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0e16683876aa..d9d292c79cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -927,6 +927,7 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 			ret = -EINVAL;
 		break;
 	case AMDGPU_RAS_BLOCK__UMC:
+	case AMDGPU_RAS_BLOCK__SDMA:
 	case AMDGPU_RAS_BLOCK__MMHUB:
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		ret = psp_ras_trigger_error(&adev->psp, &block_info);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
