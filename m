Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC57EE49AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB3A10E5D8;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60AA10E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ0ze1hbDcji8Aaw5+qt0gYeADGxGfb9cjNldz4Qo2+TLdEZsjsyFRDv6eKAYH0Io/8YPthYWY2OH3qunAQT3lfabmrWac6WvCGsjR3OGhp4g/c1N7CmCfZPEJwN5Hf33FIQBLBkB299Az4kCawL7BezvNnDjIpPk6qx2xBpASydJBM2ACcMMIrZlH8sj2J6ep2WlcA3vhrRIV6wBN+7OyuaBo7+LyiBJa5JN6fHF+8jygsILqoqwfy0LpV4b5KLz7FVciG9SoBKUR2BF7l71PPdWpzfAlwDCcrmcIWtdb+TMLQGy6rbIlJMsayUZuqlLUkYJDWDZ1Uh5r0urn8zSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud1Ohy6Uq/kEwzoxKIdnW9bdB+lBj1u4Wqi9ZPVHIG0=;
 b=VZupIgZO8tK201SGpTSf28kiczJK1R8CFDzdbOyrk1Kb2cdpVkMZWU30yyXidvS3x2RJ4UVsPf3JuMisx21ay+rDRIA4dSIAcWNfwJP3UlwK+XND7IVtUdNF2a1Rx9izL6fq1npDcZqeZFeK9sWCr63yh8+Zgj4AsTzKKJu8wvV1M260/yITRE8ajJ8jPgo6ZxZQv+fXLnUDBr7xJHp+yxPHbIFxtufouCQHEGgHyvtBsqWdLS2pqHl6moVGIbChXU37JaPR4J21zJAgDKUYVv93FcKxFKGGEOiBHlq5587Tz7CF/JIOa5uQUJEs5bM17nmD+7gIrQXPmTTdHfFJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud1Ohy6Uq/kEwzoxKIdnW9bdB+lBj1u4Wqi9ZPVHIG0=;
 b=wWNofkjuynFHhuphFTK+eH1BfWP+8YJ2DDvwOCDx3WG38vgUAddT366zjZRhP6ZnxPA25M4Lu5nnrhyWhnIvd2WGg56okQafp6tlFFlMh3ynPpYrepuJayfVqv7ZPhNwNHN/z7G0Sat1MmG5vo0wz0sZ4SxBUoLyF1H+d1aJGUQ=
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::49) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amdgpu: add nbio callback for VPE
Date: Thu, 24 Aug 2023 17:31:21 -0400
Message-ID: <20230824213127.2725850-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 564df9f5-66a2-4d04-529b-08dba4e9892c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQEaXkZ/wXmAW4Z5USaouxEUEyPeTm0vfi+G4o0G1YvysxMuoNLSc8dTF1hH3/5I7sLcy8tWarRqnAtOoZ0vFh6VGxMA4XG54CR6K7XXtn8yYl2IXxoeVlSWGjOggryrc9L8NXeXDF+uoDhlvRUguEkmxPZ/cJ8leLlnE0xCUXucWc81+H71r4qxjEf85B+WzXLHZELtQ/82t/lCTpjmdjxBF2a0W9DF99wrTLpJrLeuIPPVy5KKBj3mLxDXHdQPeAvFJXcbUlHGJTFyIcbnHYvvtqU6Ef+8OWIoDHEVKI8FZUnjfOWuA+SDZaLyBSd6YqBpxrICOGGljVn2azW+vgswbWqBVQhDAmtQzxE75mvSwkqgZBEhKwu2psjCDvBCAt7sHqana8/yVAU+QgNTZRJuLEixaDa0OWnV0q8t5WMcUsClj9x4sn9ezn7piUuq9JwxihFnivHCIILyF0YZFHEI3ZGGSAKea3OG0eqPkZuJnrqyHa1HjGVpfB/U/0Jg9KOnIO+8yRLlWJDHHp5TzhgfUEJBJBXmsCd4vNN9sKRFfgdM0FXudA3nt1ihGFsDicUESxcqcdRFXJCn4ewdl8AKNDY2m/q4SUz6CYurV+IwKao6MntL5PoblnSkU1AeqSSL8K5uQ4ZQJ3EwB901wXgWuOMOK3DrPO076PXkdEalo1SbiheAsNNFGEBal5EmuMjWyK8W/SgAhsoBWM+H4+d50bHewSrRRqvTRGystMRlcaEdcLWxd6ctQmPHPBOEU4xOcuqnp7A56LzXNg5VoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:53.7369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564df9f5-66a2-4d04-529b-08dba4e9892c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add nbio callback to configure doorbell settings.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 6cf7a8829a52..65e35059de40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -69,6 +69,8 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_memsize)(struct amdgpu_device *adev);
 	void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size);
+	void (*vpe_doorbell_range)(struct amdgpu_device *adev, int instance,
+			bool use_doorbell, int doorbell_index, int doorbell_size);
 	void (*vcn_doorbell_range)(struct amdgpu_device *adev, bool use_doorbell,
 				   int doorbell_index, int instance);
 	void (*gc_doorbell_init)(struct amdgpu_device *adev);
-- 
2.41.0

