Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3FCC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 07:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F91C61373
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 07:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F91C61373
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F9A6E160;
	Wed, 25 Aug 2021 07:44:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E233A6E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 07:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lblXjhPpUov5P38JTiE0q4lsT2CUBP5+YAn5OHkKhON7YzoGncuUzO/pdmk5atKHaaDy1NDGVdX7KP0/v3LK+vtYsGHNaqWyCQbQVlRmh5/upu6f2KRLflJgZ+FUB/PCm8gtV0ONH+wM//8eLzec7n5gR3EQdViPzF7wtSp5hloKBhAOLv7ZieNGEFiVbGxvIa94O7aeNq9FS4oCl1wngpW5wXt7LJzpprg5idn0o5fa7EZDeFu5UI5mP+3gCq2DD9rmuD3Yac6kc9WD4wtVU0Npf3NG3p2eeXSJp3apug33h6kerAKW6ESlOkNy5ibhUbWaSXwVsiiiIWXi2RpwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcLUNXsyEWAC0npSAFbOOdaw7YVvCkp6acQeeSFbgNE=;
 b=TYm7NBXhuMNf8qsJjU9gUAP0y8rYkMhRnPVdBNPdgLcOPbAZeXKiN56/3zI0Q+uH2LKRWy5Fwcc+FTt9Mn+FS+xmk661JOje3u3dH5/CkWZd6NVlyrBqd0aSThpQ6Vq9rTBo+GiI1QnlOSNHyHUpWTFUFU8M3m0iQTt0H8hjwdEFINCgrauBAqztdeBOgAnUb0dr57bFc4hTQz0Me01knEZ5fpmgh8Qjv1/Q+fx7/+mTmCErdAA/Zv20PSdZHcDpZIUzilBwr3nRCVOzX3XN8qbiPv3+iClivTx7voVEQetBbwXAmEAERe8oeQ2MkjxmHLT5sfoSrczMS33CbdLq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcLUNXsyEWAC0npSAFbOOdaw7YVvCkp6acQeeSFbgNE=;
 b=uDHowEcS60Hz8UTmTpRhm9mhkhX/kJ4RsWGWpyz4LMJI28sfUL7ClBXAU8BNnTQVultD8i138ZQqaZAnStDL112O0BpM3oFUtdIsFULFqFN0dcTti58/Xxj76euoc/k4KrOmObnbQGnvN7iWQ1fOIlGi8VhXoXrr2a+3IZYPEOQ=
Received: from BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12)
 by BN8PR12MB3617.namprd12.prod.outlook.com (2603:10b6:408:47::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Wed, 25 Aug
 2021 07:44:30 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f8) by BN9PR03CA0067.outlook.office365.com
 (2603:10b6:408:fc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 07:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 07:44:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 02:44:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 02:44:28 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 25 Aug 2021 02:44:27 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
Date: Wed, 25 Aug 2021 15:44:24 +0800
Message-ID: <20210825074424.170859-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6749d8-4f37-4a93-6ccd-08d9679c2bc8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3617:
X-Microsoft-Antispam-PRVS: <BN8PR12MB361775F3F2874C7389C870FCC1C69@BN8PR12MB3617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFjlm3BbtrtCTXVcg6B2rAbtJ2n8JGpUQGygoEMKXti9M0GrRRTb7whSNFMZeoAzcrICpjdbu8Hlvw2gMZBXbHJduxjYiGgxpa9BPwfSA8BIzIv1+Q70HOPPfP98iRxjQatl1CWCDUEzhNV3e7e6SEKlnMKnVUe83Yms06uVivMr8xr1n2OzLFM5rB+or9C5jz8Tfn9kDgQ47xouEkrStyEo0RcIm8Gf0idYR1+11Lz4S4y5F/HFMFmQqVaBHoxEzdtj5v135gj9Rc+lRHnezGd20kdux7uCBaaYTwoouzcRqp/r6A32tz26+yX+7andASJpIyzoM0ECrs1jvzOqgK4Jv/+ciUWnv9QoB734w9D7+VsHeMeVSfoLPmIsUSODr4HBGa6hGt2AuXd+iwRbCqIgz/DGTEan7VXUQnUJxLIU4rn3qgJdntHiz2CfXcvhK79JqE6mjw/RWHbqH30LtnAU7xQeBok8RnzudRtTLT6BVEiy49Ru7pQUFTCM3iQMwHajKMJVbwELzDp6luE436y8aLigfTaWCVYRshhZw1uDRfqKjIfP6GtpVFambvypWiB+MJaqlvklpSAfbPW06cXW0mVsZgM9Z0Xw8mNzlpCFQ4eFx+ImcyNuXky2Yqg06GGeaExQXukblpLIx+6UVp15OoQiqs/KxvHcGABNLYu64ClNwlvepdNNEOqURBp8gQ9WPVaR7pe0C9txGhjKauM144ki59opLGGnd3tc7rY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(70586007)(4744005)(36860700001)(86362001)(478600001)(70206006)(83380400001)(2616005)(6916009)(7696005)(2906002)(81166007)(8676002)(82740400003)(426003)(82310400003)(356005)(336012)(4326008)(47076005)(54906003)(8936002)(186003)(5660300002)(316002)(6666004)(26005)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:44:29.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6749d8-4f37-4a93-6ccd-08d9679c2bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3617
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

amdgpu_bo_get_preferred_pin_domain was added to handle system memory
page tables. Since system memory pt/pd is disabled now, remove preferred
domain judgement to avoid confusion.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0b893aa21ffe..764822edba18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -926,7 +926,6 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.size = amdgpu_vm_bo_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
-- 
2.25.1

