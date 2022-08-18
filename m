Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1993C25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 03:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983D7B4518;
	Thu, 18 Aug 2022 03:27:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BADB450A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 03:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN8n2QUYJv8GLuH5aqjuelOAJRLQGzpD5L8sC9Ary0ArGd6LcYW9wbVXwUKbKY7JdXbkwbKH+ui+oXam3KfY6cl11S+87ZDqmahPF0ecKvOOJ8xpWGz4ElPoomD+JwmSso9bp5Zxa/8Ka1BYsbjKTeNMrMFJFlc5rwodBC98EOBjij2FrMHTGEaQ0zsTgG2BqkXt5DW2JoPdxlnomHaAbaktomqes+p2ll/59rhFnM2f8jjgNWyS2G3dpn1NHfMZGr+ONiEEJEyNgW3EWvsUubHiYKDRVQTjrBS2fqkzfTXVbsXfZgYi9lrVvvLlQ/2hDwro8jgUUgWEz9vLibuX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmycWQGhRa4UUk3yuDFGoHdRz5tConvA53d2RyqU/lE=;
 b=mbrXuzK4IIZTfeT2DDusDzYGDEGO7IZAYVuJEdgBUnKgBpAg6gFsaC7lJQfGbRlI9onUP+gKb/CNCKWkDEvJpfY6l0A1Wfq/Da+TKeti+mVC8iwYXAD4IcpiaaUsumlmfwTHvzDjWfkdN/1BSmsg9nkQfvXXm06WZc/On+zZNASf7ByOhkFvqiDrBuK3ODvK9aTy+vbzHNGMQePADNtnXLd9ehsGqODXYFSlS/PH3VvkN0Jwmeme3V4NOjwPej/unFqvoX40ocXUX9LGJU9TpfKqfRvOg01P2f+NoDOy4gnVEXHIE3JjaLM06Z2ey0kpC6RPlo6vAj3rxD9zSTFMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmycWQGhRa4UUk3yuDFGoHdRz5tConvA53d2RyqU/lE=;
 b=GjiCu45eez2O3B2ztH771wO5b2uIb+AdAWkNgNyj5qtv0kE5HaYBECeFYcsTwZOYGhWpsWl5izK2YqQBgwOACkpq8A4UeErc/Bsgolgw+29A07qBvH065ghchrpK/9NYM8QApLID+XwFjL2YHkH8MmbtqTSSoKl+jEOmkaeD774=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 03:26:54 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::86) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 18 Aug 2022 03:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 03:26:53 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 22:26:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.
Date: Thu, 18 Aug 2022 11:25:57 +0800
Message-ID: <20220818032557.30044-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cffd3403-c20b-4fd7-0d83-08da80c97f6e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1MhJJRnqZoKGxQj4DcMmdpHSZddIMFdYECZLkQIYQemjQP3Sd+LreHtGgnDk2C+E8GSi2CtD6B7icPQK7Zu2zz3tQ+wPNRbG2ZtCDC93f6+PVxj9eZKxpiIFkZZAZ/fCVwnqC66zl82s5+r1fDcdDImQTnWiGslUdaZmZ4VViFEbgaRxs5FhjcJXNQkO5J1mkBl3pODQxVsyMCfcM1uULk2qrj2pn0MXjnHEJLkT5eiWnz+GWbtmeiU/ZepQgafu9LJE7DMpfJjm/G0wl4OTJPGap3/OCo2w44DEWnTQiiPE2tA4gnYnlitX+Zxavql8Jf69NIyPpTXRWj64lPyEGOD00au5PlcyomXssnOyYs+3/kGIa5rwLPsf1gP8/hn3yeYd0w9MiPtqxzn/txFMQLloqqBzZ5JJTaq+E3MJJt8PcozAP/ndYDJwFmu4HHbZeyZZakHTVLuqxnIWjujDMh1uunHnWB8K9h08dcX3zs5jOn9/4Lz2PpI/MTeHdzXb8MbhGir8fpzrlYbTfFK/E27n+Cg08/w360PvDdLVQeTAh/LszAVN80CfOL4WCxta5B5a1QNfjpv6G8mmpNH1WGUTdveDUm9kqbEURx10bJ+B4BRNbA2YFbI27hZ1SOh4M2UxO/rwAopusO+lVb9ptIhSywj5QH7znegh6q6TjSHLiPAN+X9MJoZluVUsteonOJpuhP3UEMBJRug65EslKtbp87UfTX5X1rjuVUc5lFWFkbMtcguEsZUp8ahZKQAm1AX2KGjedLGrs39jaWrtrr4gZxVxUxwFw70wgXFYX4+84VFu6CIW6GlLxqR1E4a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(47076005)(1076003)(426003)(336012)(83380400001)(81166007)(82740400003)(356005)(16526019)(70206006)(316002)(5660300002)(186003)(70586007)(8676002)(4744005)(8936002)(86362001)(82310400005)(44832011)(7696005)(2616005)(6916009)(2906002)(4326008)(26005)(478600001)(36756003)(40480700001)(36860700001)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 03:26:53.9172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cffd3403-c20b-4fd7-0d83-08da80c97f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to set up rb when no gfx rings.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f187558220e9a..1d6d3a852a0b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2597,7 +2597,8 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 
 	gfx_v9_0_tiling_mode_table_init(adev);
 
-	gfx_v9_0_setup_rb(adev);
+	if (adev->gfx.num_gfx_rings)
+		gfx_v9_0_setup_rb(adev);
 	gfx_v9_0_get_cu_info(adev, &adev->gfx.cu_info);
 	adev->gfx.config.db_debug2 = RREG32_SOC15(GC, 0, mmDB_DEBUG2);
 
-- 
2.17.1

