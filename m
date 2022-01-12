Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D68AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 10:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA15113C47;
	Wed, 12 Jan 2022 10:39:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F9D113C47
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 10:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfTJPP83B/38XKnOCMGzz+HeGzDzzAk5NcPWPYXJUY1mzGxDwOTsoHjMyduxQkFaL6yDH4IXgI3bE3Uw+lb5R6MOn/bkvSYn/5p0ExcxLS7k8IXo1q72uLTa1q8dZR8pHU3i3NpR+W1tRfkLM140In+1FVSS+luk1qZbsnJIc8k459iFFqj6gzW7462MO7C/0TE2VTTuK39fjTqhXnwjUI2oTmXyY1b/S1JneMSpPzh1OeNZhFJZm/0LEKFwmkb1Y+ilvO1NaYiea9LBkSO+V+AV2WkwZkurAG8Sh9OKpZqSF4C2ylKMVg//p/841erGY9EQtjv+1Zg8uwP2uEmNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU/KnroFhflwMJbhUkm9dsrRPx0B5FeKx73JoM0sr7Y=;
 b=eO0a+6EKma7e4YIDmnaP86m4bV3l0YNJTTHKFwg6SAFn/19oK+WwjlzC6E81Kex/DkygA0hEzRHSyQhiOvWNF5mrOt2u+FbVXFmy1VbRQYWA7uYnk45pCPuWYN+pKBKevpuRypBwZCp1wVh+JwEp5lLdQefZy4JkKgltChHFmOaS0WZ5gRK3VeVVs2US+Ab8b+n9GPqevXdEJ+QdOl94LsdSjrqRKsGoq2R2vCwI8CAiWzU/SOHiKg6Lj+4h8oJ+OtX6qvUzH4LfZ5sBgTXqPwM6m5GR9urOixHDC3d9nJU88gRCWFXquYg3kphH1yQfa+gIxZaO0L4g0+wUuTb6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU/KnroFhflwMJbhUkm9dsrRPx0B5FeKx73JoM0sr7Y=;
 b=cPDCgiTxrJycWvCBuIT1tMSfk5alwoIm+EuEiXT1olhBWTUklJwHK1XCQSevEj4kO5j65aFq9u0ipUPwMBnpLg/h6nu4nnNnSKJIzr59h/zz1VGlFszKnFI8uzexiDxuPA0q5UDYG7qL9ZbipDgAzTiiwSlrl1R3Uj5mJTwBnMg=
Received: from DM3PR11CA0019.namprd11.prod.outlook.com (2603:10b6:0:54::29) by
 BN8PR12MB2851.namprd12.prod.outlook.com (2603:10b6:408:9f::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Wed, 12 Jan 2022 10:39:13 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::3d) by DM3PR11CA0019.outlook.office365.com
 (2603:10b6:0:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 10:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 10:39:13 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 04:39:11 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Add ras supported check for
 register_ras_block
Date: Wed, 12 Jan 2022 18:38:31 +0800
Message-ID: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e898a9fd-596f-4dbd-fcc7-08d9d5b7c660
X-MS-TrafficTypeDiagnostic: BN8PR12MB2851:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2851072334C930CECA4047A2FC529@BN8PR12MB2851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwXY14WzmyE3CWAxQIusXodKK2jCScUsw9hSLCL46IWIC+e8mlUaT2spOpmTEukONdxUyJMOGhSYHllx5+Bezsmc94FkzlKZd+scy1KQwsv2v5lKyUiI7YHqbjLkYgOjzW1mrgSsn4xdth6n2QokPw1C8YgmW8JUnguiiops+oRFHW8ORMkm7jSUotd9KLAP8Lz1yPCupF+Tc2/ZTbMiTUux0HoWE09I1Wev7dc2kBpI+F/dwpvo4CnyGn6oKYLZV90YFS8FDZBc5zTciinJ/O84t4AEzIZpyTu8QISTKGnkYmFGHerghiS+EYvM02yTfCXVN8nr8+8TUMf5AHQBjGsvfILbE228SPrP6Q1Ge8fVeB9IIvNNOrR0aGVIEy+dZP9p6kh8AVGv1uOfYgcQ9AAcyN8fSst/uMdpuHYbrw+uN8QaqeSdGKmbUKPYxUomBkvZSB5jvS8gdIYencSDvgtRGvOgH1dFqNSKX7Lteuna5vJegBUdPK7lqzmE/FFsUnW+kamrrpfBPtatmhido/GWr3OezhOFKSmTCMtRP5yvUsQou2+C/aCmUnG2r8fX/eRRT1lSH0asPLm1fJBJR3IQNuzR7loflKOCykovrNDYORJNyro6Znd7oSv9u9CZCdScq3+1x5L0YC35oSWGQxoUsGrgfqzIArqsxmVptRzd/iBDN87ad/l/EiraWnNjKXICU6FmxTwt8X4Bnz7GvcMhVujraSWkUZeLbOGNt1TSzyJa6OmYcHuYd6qsBDsShIcRPOmouY9pl1uBcgP6yGQQbK4OxyhN2yUJnToEgFFrZvbn8Rv1Se++56pyEjmQHrPBU9DRY1UJMhPDQt3UaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(2616005)(5660300002)(6916009)(8936002)(81166007)(4744005)(36756003)(40460700001)(356005)(6666004)(186003)(70206006)(26005)(8676002)(47076005)(70586007)(36860700001)(54906003)(508600001)(83380400001)(336012)(4326008)(7696005)(1076003)(16526019)(316002)(82310400004)(426003)(86362001)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:39:13.2831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e898a9fd-596f-4dbd-fcc7-08d9d5b7c660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2851
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras supported check for register_ras_block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1bedfd4febc..614ae8455c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2757,6 +2757,9 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
+	if (!amdgpu_ras_asic_supported(adev))
+		return 0;
+
 	INIT_LIST_HEAD(&ras_block_obj->node);
 	list_add_tail(&ras_block_obj->node, &adev->ras_list);
 
-- 
2.25.1

