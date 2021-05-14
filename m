Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC187C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88767613AA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88767613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5456EE2B;
	Fri, 14 May 2021 07:27:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F876EE29
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtWhHbFl3YWqZC9lBSgTNPyegzGlu96TaPUi4tRgvcKt3bFivxmsbzMyKwYL54y2llyk3h6F5e6m0oN5kmDSBUgm2/qMNk94Z3cqPfo1j7Q7PgClehrz6SgyuyN056UGDMNgCrW47UQ3by1/NrmVkSqKr2kRLKJkhZB0F2FxvE/a4/VmaskQAbivlB0fcYahGLbdbAXoUHBJEpaUpq/jzSyontqjApFAiQEMvieVSlss5RV8F8W0IkjM6LGhU50OpwsHbVY5DO20d+1r/8fCKIyAElVl3HfDlqywJQC/40ellFDdB8N/4zUtO+h7xxggwS8vywNsV3C/0AJ8irHY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQnvxQwFPi4+K8rXpZjv4ePGXFw9k76g5Lq3tzyPBD0=;
 b=Vukz4MMIKvOCFjEqo3/vQ5iYaYnW8rQWuy2qzymYuu+UjfaO7OGgosMYlxqrWiA2zn2Ii9KkJ8TjseLQJZUACUvzablx48+feBusTr2B6C6xh0ZOTWxDUU5KUSbROFAEN+94zJ0OAxRHMxeyRra99PhxPKWEL4GlnLF3N64tYhhaecZg9glwIygd1Ut/5sN8F1JtIKos1SSmCskj5J6v5Zs38l1mMP/NLqjRFGS5gBRgP/HR85Zhxd8DyvvfBX2HGSU+pR6hqaOmiafFQM4gW+YcgSkjz7FyViWe6eX/9C3PLK/oH3lV20d8jxg6hg5uUFwq/KpWAYUrdZL66OhzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQnvxQwFPi4+K8rXpZjv4ePGXFw9k76g5Lq3tzyPBD0=;
 b=MMbJwN8pUWy7l6XOUGxMCJpSX6iEoYBWaL1i4YDaVi40S+WUjrDkCyAxBp26IJcPvx2Aa5ScpLMCI+83jaogW/vh3zbYjJQQdkSAB8ibchrtMQix9bYlAKODk1RgqWEKc58xNZq9/hoIU+lNsF10+RbP4oV4/Mxgtf3Uabw0QyA=
Received: from DM5PR18CA0080.namprd18.prod.outlook.com (2603:10b6:3:3::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 07:27:42 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::39) by DM5PR18CA0080.outlook.office365.com
 (2603:10b6:3:3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 14 May 2021 07:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:29 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:28 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 14/16] drm/amdgpu: Skip the program of GRBM_CAM* in SRIOV
Date: Fri, 14 May 2021 15:27:04 +0800
Message-ID: <20210514072706.4264-14-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4576bcff-ca7e-4a39-93d6-08d916a9c2a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2358E2D0049F1B7DA81AE04AF8509@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FONKoqHyzZc+sZrrUT5NuNsFsypNUZEK5bWvtMWxxfPZTYuCCZlVDVOEnL+POdmkfS51S2Kp+diyJmv2/cdaRE9tnFx1CWTRu8i/FYQBR5qHIGdBU/F67gBZP1InrOaRJw3ROWSDl0wMggIFn4b0EvOiP+mqjgLBzfB/Y03aZFg/Z2HIMFO8duvd5fbapw+lqQ7cc0HDj/CtN4aoPEV+LZZ2HX69E7z3E96ZEmgWKeoYbQNafohn9PYInlqYw9OYiW5Ej0VPUnk3AR0sbsQFpaB7HPFpNJMTxL4cOlDKFxTCp7rVLhE/LIn3ULHU7rDcEi4plzlBl/pFivYzsY6lxssqnn2TY/usNA/xLROKTQylQrWuvlzMdwl6dmWFCEcS8hBlcri1NxTG2ifLGUUByLaxsogvHj4c7j1XGPi/BcRhi669SltY4SBo/XZy+r6PuigcNdl+AZCCN/ZIfycir4/mjca7/8wkiLJPaKxj+bbcH/GoJlWt6SlYBcDiDLymNfGkwiGLYHw5AN+wvANIv7snwdEAZUKrZN2hUrl8CjOnixHY7Lzf29A8/kU1L1hI5P+RLcP+Q7L4UqDnC2qhfAznADqzE3o3UE9O+B6uJ/ua8LylNTsQ+WVIDCOWxH+e57WiI5vqcSZ18+rDKVd9f9CyuWAZdTN0zeM1f+QgXtUgaMvS33R2vBBNQ2+7i8Zh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(70586007)(36860700001)(82310400003)(7696005)(6666004)(6916009)(4744005)(36756003)(426003)(2616005)(26005)(8936002)(478600001)(316002)(356005)(2906002)(1076003)(81166007)(5660300002)(82740400003)(186003)(86362001)(8676002)(70206006)(336012)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:41.9375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4576bcff-ca7e-4a39-93d6-08d916a9c2a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not the program these registers,
so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 67db0197c882..952a2f0f2f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7114,6 +7114,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
