Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A41C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 06:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CB472F08;
	Fri,  3 Dec 2021 06:54:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7172F08
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 06:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT1qvj4CKN68Kh+1y9hgc8sI6YAuU85YO1PJYWLJuvsPk9aVvU8v4p2DPhP403iWXEoL+gl0aOUeIh/K1PLGtatafe9g6pQbTXlmBYD7G89aU/QyNkXt44cWVkhrjcUxFfEzqTNUnzePtIXvWSo33N1VCjSXGsRUSJ8y3tXjX7bH61iAAsTEwlO5k0Ks4QVk/wEm/hmsgBkSDwBknQaPgKaaPWF/+oqoZTn7JgHv9OzxBCJIhzX+4Jn7Jrget8ySDl9LBR8TfpzCSfga0Su5v7qk+n8rqH4mwpnnOz2EHyuA+tHEGQjl4w4/BBzfvW0y+rT2YafkjDfO9plfosYlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBoEXC6Wl/YkHhlbs3CvNugC7LZbX3S/szEtp/+/kjA=;
 b=bu2bskIn5PQtmgKywfT8ZSqAqor1+xaPJ2tM3qvAAzokpouRIFHXPsJ/oLXWtt5XEY0WF1bNMCrjb4+lMoEGe66GubDgK8PMomzTve8vDbSxW0LKJsOruJaeoEU8+MyPpyfoMbe0iZeUWqcf3qOPCDs7VIGjsLvraQpQdutk0FHvLQ4HvcRMuQbvOAxG7QjGA5j91SbiPICFL9yUd77XxP41ASTTttcm17HQd++wc70o6fL2dtIrESiCcMmnOhSEMvE0zSlMXBaHMvY7Nn1XFTAJl/OEmnQ3QWGgJbPD6TiWw8cwtxdVulgqD2A5eDa0pbNJ/Wjwq+tpUujQsxTcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBoEXC6Wl/YkHhlbs3CvNugC7LZbX3S/szEtp/+/kjA=;
 b=vTnmptvp45d/HReW0rUKO94r6WiXF5D0eMKDfGiZhtOG4ofyoP3YEIRrUL1zDHtY0yqPoinuDH4e/c22ifmsuqRyT4CYuIoK2TDQ+1Wfjq/zib0J/P2GYsmxsaG2QFCNfGj2xf3q5t6lKFO136hpUg5Ny7W3V6g4SzgeO6o9tew=
Received: from CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24) by
 MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Fri, 3 Dec 2021 06:54:24 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::40) by CO2PR04CA0146.outlook.office365.com
 (2603:10b6:104::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 06:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 06:54:24 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 00:54:22 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when dpm
 is disabled
Date: Fri, 3 Dec 2021 14:54:07 +0800
Message-ID: <20211203065407.3714697-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203065407.3714697-1-lang.yu@amd.com>
References: <20211203065407.3714697-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73e05176-20aa-4db8-b8a9-08d9b629be18
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:
X-Microsoft-Antispam-PRVS: <MW3PR12MB442784FC3AECC57644AABABBFB6A9@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ul6ZKWLT6n7cNQUnaeKaGyx3f+XD3DvOiHQDg67oFmiID9UA7/X1SXHYXTBMiyRiVr6p0YvfnoumOuvNgidodEQuXLnZreXDIx/bz2h7ILLWnqjn0v7yEudA5wQwXT/LmBqyow3rpoN+hkEgAYAcvLq5lTCs48TuJpHd+S5eZ7Br6KE9k4WvwKI9dbXrsGNu3mcOVgpxEai7pbEF66hYW4KOBLitJa2A+Sc3ugJcx059OKPQMqS5Pmb0RfNoS5b5ILMmEHmRix6JDSc28cJXhpcYYPQKZLNU2+M0QlvQm64Oy5qnAvM7Orxo0iNpG7cQ5KAks7N6IyLkl8owmV35icKtXi6Q3PhhDEa0ACJrvTgfvI+7/vBuy4UW3cWkADrMHXbwnFnm5hPbGqB4D2E/h261tOFG/L/CpSjXGcAIEEWfvWKUdnwlBk8n6mSbdw5Rnak1Rm6qj06xEKGPnAPD/rjRupioXZZ7eS8GwuyBSIHf4zGRBgxf72S6pQ2uQH1QrQmO4WZvMUZy2vgvTZAVMp0m/sn2vatRmEgO8TvgkNJwMAKOgbYYOXu+NusYTRdr9LPq9jAKqMSWxNXv3RHKWvwxmusHfM0lvWYHzgkoLk7NgG79BX8Qt93GJlnXBCdA2cW/NZWVrDJIxk1FmEAuum6TatgHyfU5fz4xcU31PdEdvbPufv/k78+Lve0MlBzoq74nXa4PdIdFrygG+2Frrk9BYxFT/PUO0qBPZSXjGndEX02W3SDbQyPPy0c5nnYFA/z3W3b5y6GvouOPscW+3E7yP4FEjllzAehc/PClo0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(40460700001)(26005)(47076005)(70586007)(15650500001)(4326008)(83380400001)(82310400004)(2906002)(36756003)(7696005)(6666004)(186003)(36860700001)(6916009)(356005)(316002)(16526019)(2616005)(336012)(426003)(1076003)(44832011)(508600001)(86362001)(8676002)(5660300002)(81166007)(70206006)(8936002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 06:54:24.7279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e05176-20aa-4db8-b8a9-08d9b629be18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The general hw fini sequence is SMU-> ... ->SDMA-> ...
We need to send power gate message to power off SDMA(in SDMA hw_fini())
afer dpm is disabled(in SMU hw_fini()). Allow that for APU.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2d718c30c8eb..285a237f3605 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+	if (!smu->pm_enabled || (!smu->is_apu && !smu->adev->pm.dpm_enabled)) {
 		dev_WARN(smu->adev->dev,
 			 "SMU uninitialized but power %s requested for %u!\n",
 			 gate ? "gate" : "ungate", block_type);
-- 
2.25.1

