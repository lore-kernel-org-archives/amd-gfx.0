Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105DDC19F2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 03:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E443EE588B;
	Wed, 10 Aug 2022 03:21:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF7BE5860
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 03:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGgDs6RBdB1ceBhVXGD1mcpcUMT9KAApXqtV6ScYLxWSOljkFzo12fJl4g6KlhcLRQTI9FOZ65AhFdWreWQzfwDBiXwZbztr/pY36zrmlXE8qYe/QJohWMqs0zTjbQyt8AikBfiuttuSSw0EmqxcqkZ26jipMxshdV1mmc8vKpOdG2KnIliShmRaVKoeASNdHEoOwmgEVfmIfFbm9kGrYPg+N5lx5IbOkX22O28lAI44EuaZ8wHXwMKQw++OxRoPSXSv+6ITkLUhjsVy8jKiydcuXTH0KrOvXLqXFWVIlNSteIebmdXEhBX23lfc9VISMmMhKcx++24Zaq/EMNLQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkeuWdPO4jYWlIa6IddIO9HKnH5ULqXbnfg2A1/X/jo=;
 b=dahPURw5DiTB5Y1FZz/oF2A44Mt834WO6/OWJtSwukVdlPoZQ+ChTa8rno4R1YtcoVLECgNCr3CDYJ7WfqsZQu6KMIj3q3dlki9b42TVsVVjmG3KjatugdMJ44UMU8YdtxJkit1f2FKfhxWUJN9zMltPz/X9i84H2tOMBXdyFurBm8MocI1X05agrhV1TONMd3eJA8NqtSAkyWSaxAGjyDn9/fZB82AsLHoYIX3TjdM/UW6SDjSwO1Jae+WsHNzLW0Rh604iJtlHRuKpbZrkYeZuSHcfmhmwusX8K1NjEUvdp12yqvscYToBN8s6L7lpjgyOuq4NqNyUMStg8Wg64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkeuWdPO4jYWlIa6IddIO9HKnH5ULqXbnfg2A1/X/jo=;
 b=oxmqZD/B/PAzaMqk/lGchJLebAnQGq5U6eqMAYWESAVgCqEEV8LLBz/bk2mLflhfsprxJTdJNytxShT7KeQxpRi1FxpMXRa2WWUld53hZpvv+nL+Cj1OhPbjjvxbpLwBcm95bWq9KlJdVyWu1URnNRXXhM/DQHAA/hXPjlUZ+Fk=
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 03:21:45 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1d) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 10 Aug 2022 03:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 03:21:44 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 22:21:42 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: disable 3DCGCG/CGLS temporarily due to
 stability issue
Date: Wed, 10 Aug 2022 11:21:20 +0800
Message-ID: <20220810032122.1774860-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acf9297-bd89-47b8-71c5-08da7a7f73e9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zcy9uV4r4ZFGnNHUnFxcImQK/JqEXbbTsWTbrd3NjkPkghh1UzHb3zpugRd1S+iTL82sEwsoqaIVAoLHxaTlw2DAh6r/qWSPy4dxNWoiJpOB224sW6NOoJ/oTicTqMdoLfKW8cfeK89vmeYbpYESn9ydzTuuVpdBvjjY4L6K2szcHIw5LH/5I2zd3NLckXNCnZuMfz4HkSxzydw2VBgiNycM2xMiS7yMDqA4QhLOHF4+CHtbSO2aUAIAvYQGhs22wZmpASjLkEQkWcO4rFOA+QpG9hoqPK1Mzgo/V32KXGXBUw8Mj9MlHCRmmW45fSKZjMizDGRl3O6o1zf5zadkEt4FwPwaIardCvI61wio7EUCPcDia6g3CXMGn3327mKlBBF3QmOBMvu43HJVfjtFJgsj0qkCI27fhmU2wfKH8IA4HlvNl4zTtebpIrzJV/iiKSUvszsTwG2sB8jRhsKwRPgJ9dQZj/vZlkssi9WfOwZ10py95pupPb8JHUOarlmq7Dk4p85bRrEB6wA0C4LUsZfcWKczp32lSVnV3Jdhs/YaRNe7bQV2wSbZE5/BkG57FnC2kKsVZTzYH7pxdP50XUqb8XdfxvJPHWJEYfs3L9ERiEZ5bsKMPFoifr0SCnFnI1SY1m/h4c+JAXTUbICvwNo34HM5iErRL3a+fm7ek2X0otbg5v24o+aPsv75c0OJbrZpaT7Z5dy15S/HN4d6OEzmoP4k892DXIK7T35qY2R0xFt8Y+WVhnRNwHbF87Z34WTnIvIx6Obb8fSxutbfjl84FaNhBo/zzD7ceklLJkVyMm8fPogFG2vvt25kz26e+YWMIb7rUbGbAKkiyirZtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(40470700004)(6666004)(478600001)(36756003)(81166007)(82740400003)(356005)(16526019)(426003)(186003)(2616005)(1076003)(336012)(47076005)(26005)(41300700001)(54906003)(86362001)(40480700001)(82310400005)(7696005)(6916009)(70586007)(5660300002)(8676002)(4326008)(4744005)(70206006)(40460700003)(316002)(44832011)(36860700001)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 03:21:44.8585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf9297-bd89-47b8-71c5-08da7a7f73e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some stability issues were reported with these features.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I5fccae63bd530d6ff9e4167bb1c44319830806f9
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index bbbf760f8ad2..77d549dbe2a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -546,8 +546,10 @@ static int soc21_common_early_init(void *handle)
 	case IP_VERSION(11, 0, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
+#if 0
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
+#endif
 			AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
 			AMD_CG_SUPPORT_GFX_FGCG |
-- 
2.29.0

