Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD625C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 10:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6613210E4FB;
	Fri, 28 Jan 2022 10:43:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F4C10E4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 10:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxYQCpOemtGF0MRgQf52keaNAyTjyTeGUAWF0S0OVO4+7z0YdM+7oZL32sjNFe09xRgLZQXZ5ewaFEUtKXkRoy45c1vNZSyLhLYmH8tafipwwMgva57enZ3X093NPgeVTyOKlZ5VuG11DyGwb5MvavJvaRxQ6JaYQZ1SRfH+x+HuQc51VAOOSwrST31reGcxorJkUmIO2zqmkYqEcBWdbQKqbFs/PCjESRNeJKvobzmwqW5NXfFZikqi0BRpJGP/V8Bl7z1c16hKTPxZatjLo2va0bwdRKog/g6cI2AjvCcWAWUDCoP19Jvhc9bX6+SWOWX0zQQGBL5cPawJnmi4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1YXlZKuCzTqgr96M27WZuea9PPdj/Xtbz/kW/5sxBE=;
 b=aXw1H/aGNmEw3jDtwSQaIbvN8C77aCcwtht8ePOkNJE0JOnDNhmLjPHkg/JXdc3dohugLMNUcBKBAG0cfWMsKJFRBI8kd+AksJG0vgsz3TiALWeA4kR9FdlhQO4f9gAehmctCBtA1Xdlcu5Y18ogJGGmUuXM0mmBLx4Vr6DfM/0AkMvURpe6hs92GMB34RkfSym6zF++/aas+CUAXWyODgQzaDtK2hxXtwW4FJJPGN4JEzbOiWglh2KbQPrnUaSYKOEwDzzB33arLsRv0r1rDRnYYbl/cfOrsaPtL2Ao+EtqppxM/jGng45dHkmDY0byA/jeDnebJ/PPHYOR7TRz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1YXlZKuCzTqgr96M27WZuea9PPdj/Xtbz/kW/5sxBE=;
 b=USRR21FwYG5tIucM2xENXNYgkArOgKm44FNOXR87T/rjWNigOA7pldaxJWWnVkf+RAoz9FeS+U6+cIpjDyhH0/AM7joTKTV7Yre6ENTs+fObL101mbOedp0veVU3IqpPBDgincCTxxEuT87JiLsMrQdtwejBB+BthfhEX4efcmg=
Received: from CO2PR04CA0131.namprd04.prod.outlook.com (2603:10b6:104:7::33)
 by DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Fri, 28 Jan 2022 10:43:50 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::ba) by CO2PR04CA0131.outlook.office365.com
 (2603:10b6:104:7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 10:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 10:43:49 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 04:43:47 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix a potential GPU hang on cyan skillfish
Date: Fri, 28 Jan 2022 18:43:23 +0800
Message-ID: <20220128104323.1565796-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19752ecf-8445-486f-f213-08d9e24b11df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1226:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12262E34FB72F98430C16CA9FB229@DM5PR12MB1226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPA6Uf2OqoZ+9sd6Hzs0N4GaIG5q0QBIGo05VUyBbcPjUd7WOyBee4S9ibqbBNbBrh7b10VclIklxJtnPEAlElLSgVP3R2ronOFbXfxltkzo1gWox37filgOcundyZEXsavk946gNwX+5DqGvKGPVH33UPaHdhz3MUe0y/rSd68fq9ZtJP6igBLNmH2qIguguHZhrhoiFteZW93E2w4dqCSIfuoWxcJ2GrPqsNv2MS4VO/YHGgeoCOK4SvKc7wE98RyEnv36Djk8XTwhyuT0PjSr8lXhpHu9mdLzYKqZZZ70zHxrTgOrfMuJWa67mb+RBt5yUAv/6v/Bt+Zrt002A9e+mo2xXXHHBYjfojNvRzqtWj7xQvgwCYnJCOmJRE7zIVDcxzjNS3fxS0Le3yozg/tXfEU/3xT/d+YygxZJJFA1idL04ZIruWwtTvh7++O/XTzoBW6QNJEC72NmtEot1YAGHEHXe/4XWA3alEz5MdKXL/xjX4a6IkKLUshfHsaPHjwcvwNnZSn0bwCfuMC7E5CrqCeILSktcMDU2WPicU8E6wx6eKO0cWdZnG09LrQ7YIWvy+1LEmnIUFN601m0vdiFQPuRDmnrubvz5VxMhMWcaGsPvAFsx6OrXxcXm6Rq0xJTGFD3zyzWrspw7LPuiwY96/ra4UTaEElJwtTvyFJPQFpyoCA9wU/TpeFm1eav/VfoHZmKdiqX4yn3DEAIhHnOg2HTc5Up4xSGOIO51O+IoNg7em4KRkIViRFwSbGE2+uXNeZJXLNrYzVVU+ZTQxQHc2sGSB/vcLhm8kojsmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(26005)(1076003)(36860700001)(508600001)(70206006)(7696005)(40460700003)(6666004)(356005)(2616005)(16526019)(70586007)(86362001)(186003)(2906002)(8936002)(5660300002)(6916009)(83380400001)(316002)(4744005)(81166007)(47076005)(54906003)(336012)(82310400004)(4326008)(36756003)(8676002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 10:43:49.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19752ecf-8445-486f-f213-08d9e24b11df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We observed a GPU hang when querying GMC CG state(i.e.,
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
skillfish doesn't support any CG features.

Just prevent cyan skillfish from accessing GMC CG registers.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..bddaf2417344 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
+		return;
+
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
 	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
-- 
2.25.1

