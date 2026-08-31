Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F7C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F72C10EA9A;
	Mon, 31 Aug 2026 18:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPiBWGoM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C521810EA7A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox3H3fQi+Pqdo1IIQYMScKt8e2iVZGEb+jnBLoq+y2P71epd7rDvC/X/pQmSCd13EuK4iMezCAL0JDlxVe7qhF5kraVoAFKHPb1tBEWDsCy+MOTW/GYGminEvgSjwH9qVx2Rt+ZdjVXPRCYVB9OpBE8pjcY2F2q+eIaTjhkx+wHY8tpZqFyXftK7Okfr/GRf5F9OO/XQceN8K6fJ1J8x2jVyISrhYPm5oMkycmcqeaBZuzjxdHu4/5vbKIHWANfDN9PG8RBsdRdU4yQDhewj6YrUpMVeGMj/7aq3yVXJ1aj+lop0Gv0LF0kSl+if/PSwKO2KNhRc2L4dqfiVxK/+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ82I2jG7bib0VUJdvzYdgig9/FpEAiZA0W+TPtKebI=;
 b=kbKiaY+IhKp5S472jd7cd68nQu5Gj+eaFCdtBhQvq7Oz6EEERs3w009N3EgehUqmrytYm6GFVykhyRfNJ7YICxZ8Z+ezInzf3sDJD6D1d+vy0Stk8yyuHbx6dbaRWKabH+8sopUNyMO5w4+XFtNpPgWES1skcixzn5aGhEgv/ibdnzoDPgr5vShGxQlgpG73tKWGY9swVBdQ3JIFVOUkFkazvALfP1kscvOIlBhGc16mMYnMGUOhXFYbaUzZ+RJtCaGCiliki+ca8nt0vw3IMRrMoUd4Rzzyf4oNS4ceEhxZis04KRvR5d5E9PjOR1DG5Ka18RWp3uSWSkIKnyucDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ82I2jG7bib0VUJdvzYdgig9/FpEAiZA0W+TPtKebI=;
 b=RPiBWGoMPzfgbNvwKW/oqbnXpRMARoaEfATAcvd98Uj3qzwPe7FeGNLSuU20KRuddBSwshBy5/cboty/BfGtHfNCPzaFBKVFrwFSTFBB4u9lZgf1vfMNg6wuqJlmlNDAiPpZ59L+3ggxpmIkbeShU2Z7WAi/WGxuIUBEKeuVFdY=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:41 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::9d) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 18:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 87/95] drm/amdgpu: Add name for ualink ip block
Date: Mon, 31 Aug 2026 14:27:46 -0400
Message-ID: <20260831182754.1089811-88-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4a4f74-a9d2-4556-8f09-08df078dd254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /6bDeq2d7eAW9Qdjn5jXdDOQ85L/Kw2izwgVE6IgokdQ2JC3Ga5rY1Mxwy1Kf4PAsNTOiXCi6FNxcsTvmvIbpsauUj8mSqXyfueUfpr1OUgtH+wGfQxn94AG++O0cJySF2W5Fmf3+qQ9fbn5SjRiqKBRUs8L7et3NDeWBSIRHkgwtF8XlbYQolyXK+icgsBtAyCeWg9evaYCceb+AqZmio90lR8eUf9ImanRYA2VrbgFycpXS64hec6gcy0kanI6VWWFIAzManwba4vtfl/jr7KWjb+A+LFddU+UQ6T/+ulm+8I2gt5ae8DFIz+cr6cabt8aMSDvdLz0mLYdkP0XbVstXmuIesFCIiKWMeggXAAZeTT6rmr0nVI/oLToagwpWIW7oUw/0f3+YJO1Lf+3uwPPoC0EL0CxBd+Dv3WSwzDhisinG34LSbUv/eS/tfL0+5ViXoMvTrsnwLSaIIIimdM5r1VGm6RT5k56EbvZkxgJaHsaNoK0/Lb0O2mHYA5DSl+85St3D9rESlyYAA2wEpGc+B7L7rUHV+AEtfKxZ/Cq9HbB5C4d5U45kZgo3Q8YTBQUmD7InL513udL7EGaJ9xk1LUCJW0FvsdYIgbDyZJ8Z2ympQ1L8uAvGkWrRoVJKaHAPp4uf1JHzSyqBLeM/0WXZb70sMLZ5Q3kdf+PLC7R+IpXiv6oB1f0Ts6i0nQKkiQwQRXAjBu2gIZnEPQHcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0NqVsxmSrFzwLyLfomAGd25SJP0N7hiMTBeFPVek/pcNi8Dx4LcGPKvEBGygZU37GRpGPawYKLL1tRepft+Q3Da22btWsFOCS8MdoQZJdBwlNIfZwJwqZ8gTbihAWslWBoxwRw165pCVObFytgs++MBI7KQCgZvc/rsm5CU9RPNmonRT8+cH12AVpt05wt2Jk+5i7pvbGAc3qCcSReNAFMIo19AIi18nPPrYYG52t11aNWxFYaM3HKEX6DCLiOzsr8RcPoAeGChivhCRyh31S+ULZyy3pVN92VC4ybyaaKsTM5c+aZMjwDGR4fVXlXa2BRyWFYRr7dIzFghz/OZI2nMfjzgZ0Fu5x1LBZqtA17QegZXKRNQZLCATFUPtJ0SVqvUhvDSCbJoYs1HXwcFgkH2tltQD/5Kcb1Q3qrhn/2kbpKC/UnfLCn5Quj64kPWN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:40.9995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4a4f74-a9d2-4556-8f09-08df078dd254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add namestring for ualink

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 922f4b15619d5..a426327f21416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -198,6 +198,7 @@ static const char *const ip_block_names[] = {
 	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
 	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
 	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
+	[AMD_IP_BLOCK_TYPE_UALINK] = "ualink",
 };
 
 static const char *ip_block_name(struct amdgpu_device *adev,
-- 
2.55.0

