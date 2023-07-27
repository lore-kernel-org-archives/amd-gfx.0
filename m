Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54239C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 07:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936CE10E514;
	Thu, 27 Jul 2023 07:57:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF6E10E50E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 07:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnqggzRjgR4mqp5kX+CsvkfLq6oc3HDtQzgFtSK3sjpOM2JjOFVcmsyaa7H9D0h/i1EPm+yBzayHbTH00S2med4wOmuLQc13DFgkfIfN0GeE7WVeR4IK0f4vUlKU70L/ZH1wpBw1tJ8XJaS2QfCdf9VfugGbqUYdFHRdBDxP4TWM4WPeIsypKPrddjB46D+3+rPlj9VrY2Lyg0Q38CClxUt+wwUCSI3dZ74IBmJPj9qGTcUkV6wEK096Q5AFO2Z9v9l1ygGyh5NyJC95PAw4NPpdJi8mdqWRgOAdStzCof7ghbhte4UngCnBB59mbwVorhxOOv4MA81ous7L5O+Jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PDBTlkDiV04EeTRvJnqYWjCphBThHGRcaVYQHAuOQM=;
 b=SKjQU7OVHCFDObW/vpXptsc8FXv+igfR28TfKxAfnNQ1SIGojjk+TZcXcyw5ikyQNmwpXXib4q0uXaaYMxWS+7sWNFxhTzf7VbKdkC2/PNVoD4CnrrZ0ZebHSWJ/pNall+C7gKm6xCIGqcjCx5Ih7dBWf2a2lTle9fkdnvMaG3sPRXldUUQjRz0cawNb8LfCYwZRxZ9isAHaGMwDZs/I/hAggyZVNtxITuhNR3qDG32/pPklZNIHdGCvqyOSO7YqGKDLEkeImvSpTxnn2M7Gd92sZtw2s9Ewt2N+i0bfTpxn24Ri6MGadWvViYNkTZmqLt4i5ritR+sS5HQ4ZQsm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PDBTlkDiV04EeTRvJnqYWjCphBThHGRcaVYQHAuOQM=;
 b=Mavmf5ktjednhstWXsAqOXT74Ug+gXYfWKJNpDkb8EbnywksadmRzZvwQaVCC7LHIymv/JA/TW/1RFrgIg3UzyhOGOh+W0Iu7irfraisI3pH327nSLOxxgzzdMWI7//xfJ1iChcV6pzWJy3u5jvkbE6XYb5YLvTDIRYMtVGsels=
Received: from MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:56:57 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::9c) by MW4PR03CA0222.outlook.office365.com
 (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:56:57 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 02:56:38 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use amdgpu_bo_create_kernel_at() to create
 large TMR for APU
Date: Thu, 27 Jul 2023 15:56:20 +0800
Message-ID: <20230727075620.728235-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727075620.728235-1-Lang.Yu@amd.com>
References: <20230727075620.728235-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 502f0ec5-f641-42a5-62a4-08db8e770cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0NYcoCjKwQLUMWZvbT56kRHfbvuUNonI3uawLt05JJ6oqe72TnMFALdeTwaMGotKQOfLi8Ds3b3MHIzrMnkvNU3FhYd7u/afmz634f9iGTTVDGBad2x6YgXjdYk2RIUYAZKMGorJz0YxUQNWz0yHqn9U7s9b2rUL5c1ircJLIRfgl2bEBKGrpDJK90X5WfN/iuWD7Oqrkalma5SV99LK6RSwPPqQPzdSNmjdjtCYWUJkPI2e4A9XoK9G2wutcCJxDTdShIDGziEy0YaXZsg08VtERo06N1Ob/PqKTdgz59x7x7KPKJL3EDdcsjdj6GdqAYTExOzErTet0kPW0zthMbaiRc7S/HxWd0NLIky72qmtMi347eFwkb90kLsb7AjdSO1iYWvJTNAbT4JPHxxBugxYUD7pTKqr+rm8cUqFmgd4xl1Qsx4+yKOvsQ8aYohtA4mv2pYCEpfxbfV6hgwt9kEuT/hlrxdyyfmq93IBZlQ4Us6egYvXHgUs7S7jKX7fr2yF/jiZUaYeF8qYVePu1ck0L0qCENdg1tL+C/PsivEwiXE8CoIy+tG6aHiQn4b+/1gGhJrBRhntEgicWZmCpUa6tDHZVz8INVr1eYXmN9ve6Tm4Ir+ob/jf9W3rtyGoLsR388BoBEAKxiVKTlVXniIWk4Xf/lgeTyegJhYDfumXQsEk8VAOv9Bslou6mVexPYTOF+woftfA8VD81gHtuZ2NL89JrrH7HzmntKZNxt+idqHfEbr1Ng3PamIUHbmaRtguicqsHQY5tgrTYRqGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(70206006)(41300700001)(4326008)(6916009)(6666004)(7696005)(316002)(40480700001)(2906002)(40460700003)(36756003)(81166007)(70586007)(82740400003)(356005)(478600001)(54906003)(426003)(2616005)(83380400001)(16526019)(186003)(336012)(47076005)(36860700001)(5660300002)(8676002)(8936002)(1076003)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:56:57.1835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f0ec5-f641-42a5-62a4-08db8e770cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang
 Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TMR requires physical contiguous memory, amdgpu_bo_create_kernel()
can't satisfy large(>128MB) physical contiguous memory allocation
request with default 512MB VRAM on APU.

When requested TMR size > 128MB, use amdgpu_bo_create_kernel_at()
to create the TMR BO at offset 64MB.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 ++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 15217e33b51d..2eac82113d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -783,13 +783,38 @@ static bool psp_boottime_tmr(struct psp_context *psp)
 	}
 }
 
+static inline int psp_create_tmr_bo(struct psp_context *psp, int tmr_size)
+{
+	void *tmr_buf;
+	void **pptr;
+	int ret;
+
+	if (psp->tmr_bo)
+		return 0;
+
+	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+
+	if (psp->adev->flags & AMD_IS_APU && tmr_size > 0x8000000)
+		ret = amdgpu_bo_create_kernel_at(psp->adev, 0x4000000, tmr_size,
+						 &psp->tmr_bo, &psp->tmr_mc_addr,
+						 pptr);
+	else
+		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
+					      PSP_TMR_ALIGNMENT,
+					      AMDGPU_HAS_VRAM(psp->adev) ?
+					      AMDGPU_GEM_DOMAIN_VRAM :
+					      AMDGPU_GEM_DOMAIN_GTT,
+					      &psp->tmr_bo, &psp->tmr_mc_addr,
+					      pptr);
+
+	return ret;
+}
+
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
 	int ret = 0;
 	int tmr_size;
-	void *tmr_buf;
-	void **pptr;
 
 	/*
 	 * According to HW engineer, they prefer the TMR address be "naturally
@@ -813,18 +838,7 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	if (!psp->tmr_bo) {
-		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
-					      PSP_TMR_ALIGNMENT,
-					      AMDGPU_HAS_VRAM(psp->adev) ?
-					      AMDGPU_GEM_DOMAIN_VRAM :
-					      AMDGPU_GEM_DOMAIN_GTT,
-					      &psp->tmr_bo, &psp->tmr_mc_addr,
-					      pptr);
-	}
-
-	return ret;
+	return psp_create_tmr_bo(psp, tmr_size);
 }
 
 static bool psp_skip_tmr(struct psp_context *psp)
-- 
2.25.1

