Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F12B10E3F0;
	Thu,  9 Dec 2021 16:52:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6232489ABE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9kO0drSqmdmuLC4sr8SoDXOZZS5sHTef5pKGuAYJ/RHC/8ePsyGGUJz7Wa9Gde83xkV8Ph9hp/C8FNrsmIawCs4SpchPbb820gBSjV8QcNMZH9OgaEfMdO2GZ77U9rO5Lahkqme2n8bdxF2hIHihaISQNetcWi0tN9qhy5ZtMnFQBq2hzxgLjUwepCv2pOydxYNCy4TNz1dT0ux0k/kMxmc/SSe9VDqaI7ulMHJJI/vgx1Pfp5EX2hdvIZ4bcwSVDJLSkGgECM/nCTfsPqnL36TVHJjKHCaYn2h1ym4VAQO+6mNnekGe7MfVJqNeCc7V9q393mwHhN4kGYiVIHWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUFr+j7ZhSKiTxC7ZNvzeeCZtRBCkrigZbRIqahgIk0=;
 b=ACTYSU4ZYqL1EU0V0FBxOe5D3Jfde10EH989hbbJ4tG6yr//bayWQ3SRoYNCDCt7NUhhyP0iClusRdCQjmTv7MfihdzR/rauCe5m6j5lscRJxqQn4jGOVfjumE3JQn/SUT753NQhr+a4/H9YqlUVKwEzf7WWkd7OFie4KWt5VwslMyv7/DLlxvDO3FJWBi2rggsle4WFbEWbeMkC4hwLVztZ6ZpikwdMBrCeye+vCP8hSWND1uUckv2beFBusgVRkfGWqH1pA4OjcBGr3kPuiwqSfC8dmxTk1VJXJ5anhQbNPM77GoT+WKPIHbnry9gfWxq8M25lcdBA0f/vJ3DaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUFr+j7ZhSKiTxC7ZNvzeeCZtRBCkrigZbRIqahgIk0=;
 b=LZqBLKube9qEazhkolnXT/Nm/b4+HRm3N0zuFrzJWsxZJA5TaxOjCcuB/JcrqjQY/y3Yk2ovRH4zd8s7guHgJFEkd9iankGKBh+kQ+h2trgpIrkUKsiy80NkdHsgRLrKjs97oDmx6E3CLouVuEhNCYA9ByMKqwPYREy+HP2unrw=
Received: from BN6PR13CA0057.namprd13.prod.outlook.com (2603:10b6:404:11::19)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 9 Dec
 2021 01:52:31 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::49) by BN6PR13CA0057.outlook.office365.com
 (2603:10b6:404:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10 via Frontend
 Transport; Thu, 9 Dec 2021 01:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 01:52:31 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 19:52:29 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Date: Thu, 9 Dec 2021 09:51:21 +0800
Message-ID: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb078b9-8baf-4a33-b6e2-08d9bab6903a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5151:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51512309FEF8A729E2677082FB709@DM4PR12MB5151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEueG4LW6dbN+DSrR+UJVFqaHYz4AKljzjCHacVrdEd+gdQTPlC3sBl/C7QRbc5ATtOpQvZwiwLaXtsjmxAIeGVq7naXun2CihHZcEO/BkoQmFL1vv7wlsQfMmuKx5N8fCQU5jAojzvinG5goh93CnEwsQENmhCwpjUAbXluq9Zzv/jC59Orjtc5ZpsAvmlmdsim5ArErlavCq8YxIys2JLOZD4W1Js0ub/s+EJ4t71y/XlhlnVA6uYhuZ6rbw5qEWz87+7gEo5J8PxAs4x5I2SuIcRSTsQ0NfVvdkW3m3E7ujYymU8cXu/+qN3mcXAERWdGKrlNGPqx7XJIzBdo6qta/+6PdXyKvo/yjbrNNVyN8hTzTyEmHGYwI0xleHF7lE83NB684O1Tvtvi/gHhwTgFXNIFBhvtAzkzggQ45f7z/27MzBsYg4ylroeKtUg1SAS6stlbERxskA+jiSWIiIkXSm2ZJQo+Nmywmn3dw8/PGRCT/DOUmXdI9MAtpQK6ooF/9Be2ukT4Vm7wMLRKvUqNUspbnabjPV0o7gr6DHBLe6+X+fqGWSKjYmy0Ybbnec/FCom1TqN4iKIbpKl/1lno2wfzHVvv9/hTjkAPFhT2PLpg7DhSaaHpEq9gCwGUzYUJVr0BGA/DoIkaJbY5mMOMzfH/+JvksIDQhQxnRM1r2ERzmmD/cgNWCfRLycUwHi57YNR89i5JEcfCtRuQ9sp9kzBPWIWxw2OMZ8efrGEDxsAogfcXRR//E5vuTzqBDFoc/4uQ40pTVSzPhXkzsNMoW+MNLdNCi1NcsVFLx7T55nQBCDPHiSnQQqh287RaI4UWk4GUezONBBpoctF0pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(186003)(26005)(6916009)(2616005)(2906002)(316002)(36860700001)(81166007)(336012)(82310400004)(70206006)(7696005)(70586007)(40460700001)(15650500001)(8676002)(8936002)(4744005)(83380400001)(4326008)(5660300002)(47076005)(6666004)(426003)(508600001)(356005)(86362001)(36756003)(16526019)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 01:52:31.5748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb078b9-8baf-4a33-b6e2-08d9bab6903a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com, Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the s0ix entry need retain gfx in the gfxoff state,we don't
disable gfx cgpg in the suspend so there is also needn't enable
gfx cgpg in the s0ix resume.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5839918..185269f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1607,7 +1607,8 @@ static int smu_resume(void *handle)
 		return ret;
 	}
 
-	if (smu->is_apu)
+	/* skip gfx cgpg in the s0ix suspend-resume case*/
+	if (smu->is_apu && !adev->in_s0ix)
 		smu_set_gfx_cgpg(&adev->smu, true);
 
 	smu->disable_uclk_switch = 0;
-- 
2.7.4

