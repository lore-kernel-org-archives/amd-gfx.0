Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D93C19F2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 03:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DAEE58C3;
	Wed, 10 Aug 2022 03:22:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54B3E58A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 03:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8N8PY/jxtNSlzgv+qqMMx5wqObPjj6jOhrbBPwg1WrADrdS1CCpKXS2JkvfGGR+qalSHwMplpPggfZorFP+AkbVXlUOEHxwqV4HDVmTbZ0N3LUeEB3e5Qyh94lTPP+9N/VOQHW57XPHQZAyz54JG+/+jOAtzqBG7g6wC0WOjKFrzN/ilrldmqAafso1CGA0bdE6Qn0SXUSQRUwoON3+IAF4oyVYqO/pq5FC7JNzufdIdi17JunpWqSsLvJ6v80acm/X/+BU2VR6v+JJba9xSihgh8k3kHX0uLYyV7c+mz3tR2zXrStVN5A67NqYpYBpluTz4lL3kAdLAsmUxVH7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAbGY4BKt0JPg3g2WcDMOMlPXiKR9y6QBzgETs0c2BI=;
 b=eSenwnGOK/50T0ll9ZxY4cvHCpQPGI4ZZphz2EmSDIEFaR4JNkiAGXfasXuoooB2rHojnXoCXWKFD6qUasZrbjrxBqrngq889LhW4mmo+njcAIAo4kjtDyZOcAsEC343C5Mo9hJEb+y0hdKRKPayGcnrYB1u80J2Bo95I8Gyok5rPtIdvZ025WRLjJ5wldEjl/P07IIdqEFvpxYjejtsqfjbbZSH7z60apPJ2Qp1OownteFqcSnqP0dORlY7G7YQ/dsVdHrI92Vg/SljLfVy3WZz4Q9jbs5EbgVJH0+n7WZFbVWp6SDhxr7y3+icpQZouA3mZIR4Unw5wcAKmBxtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAbGY4BKt0JPg3g2WcDMOMlPXiKR9y6QBzgETs0c2BI=;
 b=GtEO8FN1fCtnXmkzNVAAnhT3SjqmdUWR+oMX0fmFDN50OLe9HNYpN8ttN8Ne1jhVr/Hym9SUrVbrZunhpWLg+WQ7kpo0A5dfLLvT1DBk3N58azfX2JovMaQdU63zG3kcUW358/TVtBs1tgZMoae15gTZ8DwNfYiGoTvu8/JP81Q=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 03:22:00 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::99) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 10 Aug 2022 03:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 03:21:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 22:21:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: add missing ->fini_xxxx interfaces for some
 SMU13 asics
Date: Wed, 10 Aug 2022 11:21:22 +0800
Message-ID: <20220810032122.1774860-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220810032122.1774860-1-evan.quan@amd.com>
References: <20220810032122.1774860-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed85360-5fb8-442b-773c-08da7a7f7c6c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acgKBs28w5iomWayF2fLjFYHCamYcIuziCEsgOWgeaV3ALfq6xKi+nVVLILucpNMoNMKd1/2Re3iBwh8/OgW2m3myGQ73qSLWrQuUg1W+htNIS5zFsX8Su7ZN74MqItw7L/mnww2imfZxPHludyG35jgS1R6g40bRHtmgchJynxtr2qpgebawi2U29lXzvQMq+3Lherc8bx3iImma2VtdhiCgF6Etq2XQ/LggwsucjDk/tt/PfZL0iSl3jR2sW1tMheGRy4KaCu8a3JccE7UEZtDBghhwadCJeXivzSDF2IsoR5pyl+eO44B24QaulG7/pNwbM1hjrMJoPZAG346wHudmDLj2j28KOaTe1Jwza+J/py9PG0NCTDN9ZOmghiEMsCz11Jjs7uAL99E+vChAxbPLx871IpslVMiy41/90BVfA019keHHnsSUEjrAkSNQcIPx/qGlyRtnNLgigGSk1ulnt3mcGctRTga3+j/A2MAdf5pwlq82zfxTsS+fXPCW8c3Y3720ZcgYymOBmWUfrD1fHRJYMb+SaOsdMM/UzYVuIr9MdmTQYODBSrU1+UR8eX4fq3VxVoeODDg6deAcvNRvBFgnGIYL9oGIdINyRPweDMXXFLRtBUdOxpe6X6u3So9Sxo/6Bny02+C+KE9G7fIpjHro/2GVIeta74wI7t2BRWNkifn7SDfoA5NOLVK1lmnrwy/lPz/+RAE2kZ0hACoS7trGyFqCFWG/KnQ8jlbCw7Pzt7JM0BiJDwUk2oaedNGs3UeCqsc9sRXOuHzxGQuC7Z9SfLlL2jGkA/WJhw0rcDIErnb8HbUvU71KrygzNL2GZ1GHAJ6g3lp+QeBOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(44832011)(70206006)(82310400005)(70586007)(1076003)(478600001)(2616005)(8936002)(36860700001)(5660300002)(6916009)(336012)(16526019)(186003)(54906003)(82740400003)(40480700001)(316002)(47076005)(426003)(6666004)(4326008)(86362001)(7696005)(36756003)(26005)(356005)(81166007)(40460700003)(2906002)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 03:21:59.1546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed85360-5fb8-442b-773c-08da7a7f7c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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

Without these, potential memory leak may be induced.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ied7cd204d44d739dece11774c9d29e7a192fd341
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1bbeceeb9e3c..df4a47acd724 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1792,7 +1792,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.dump_pptable = smu_v13_0_0_dump_pptable,
 	.init_microcode = smu_v13_0_init_microcode,
 	.load_microcode = smu_v13_0_load_microcode,
+	.fini_microcode = smu_v13_0_fini_microcode,
 	.init_smc_tables = smu_v13_0_0_init_smc_tables,
+	.fini_smc_tables = smu_v13_0_fini_smc_tables,
 	.init_power = smu_v13_0_init_power,
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_check_fw_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9dd56e73218b..d78375d9a141 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1574,7 +1574,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.dump_pptable = smu_v13_0_7_dump_pptable,
 	.init_microcode = smu_v13_0_init_microcode,
 	.load_microcode = smu_v13_0_load_microcode,
+	.fini_microcode = smu_v13_0_fini_microcode,
 	.init_smc_tables = smu_v13_0_7_init_smc_tables,
+	.fini_smc_tables = smu_v13_0_fini_smc_tables,
 	.init_power = smu_v13_0_init_power,
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_7_check_fw_status,
-- 
2.29.0

