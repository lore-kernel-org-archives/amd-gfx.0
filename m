Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C52C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635C2613AA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635C2613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053E66EE28;
	Fri, 14 May 2021 07:27:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8B76EE25
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2S9bSmxQqgwPwLLQukNFHIDBV8hzLkQi8K9oGEjF9dnODqBzChndVIm0nuNz7sOTCEkVYKk9e9Kmz0wXKd23i84XIdubyfSHMwhVApdP+sZ5pOy3kr8DakCqhvOYi2ET+rCcsVF3nZ0RvmL3PKKayTl8hfAvyjQkIepcl7WMel6wpGaaNWneAbqD2M3sDl7oX1GZIGYlAqZybCSsZlbueNJqjRcaPlr1r50FyfImDKZm7MXOZND9rD3CUBqqwu1mZZVji62uD/vECcus4vLH4ATojjoGC9q8CpHwTnKjhcuw3zBHYIRmfPt2sauMywaiPTHOH2iwGoq/kRf41PpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=bUnp19Pi3A9wbE4J56rRg1NK4c3pzKFinFE3sDDKFIOP3QjdUnlJsxu5szSlfpBdOhivUm04pGaGxJGDtkPYG2SN0FcfcJTRvpxm9aHg3UfqBKxVk9suU6wZK6Dv5tgAXUVhA/u+8L0dnkSoCdTUfEZea1IDxUA1iO+BWAMbjvcoDSG0SSim91Zz9P/8elPa8emUSoxeXY1GB5P6i8NLZeX3BIWpAQ2qd1IAMiIDCejUkuAdVA1+bfe4JYh6k2co4muDroYn6erQzflgO83arGnRBmOdYqaHsi5T8A4LgHck8tMAYQH5r3Qs5w1Zbahi4KpO3A/E0eNKgjTdH60rSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=DvCdAJuEFuJATLuZ8T1NdAKbUDPEfS4PWDvq7j44DpvaKs2VwDUAIVIHl4E09/r+saP6N92yseh5iAdvdh1za1IAWUcCXlWGJrpMEjzfaaPaeC9YAjBi85wBSbWAgjvqhf4ZJWF1DqU7oGh+deJMm1dVLU1w1B1cl9lqjcFVvDY=
Received: from MWHPR04CA0040.namprd04.prod.outlook.com (2603:10b6:300:ee::26)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 07:27:30 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::e8) by MWHPR04CA0040.outlook.office365.com
 (2603:10b6:300:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:28 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:27 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 13/16] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in
 SRIOV
Date: Fri, 14 May 2021 15:27:03 +0800
Message-ID: <20210514072706.4264-13-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d81a40-f37a-4424-cd17-08d916a9bb8b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2825A7435189E2ED046E077DF8509@DM6PR12MB2825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkf9+UDg43BrJCd8T7i1MIZ0a56VM4goEOlvCKDK4MpIIhnbIjv2TQNrgJ3AHoQMI3l5FRGFhAS6nmceVkwwqMln49IrO0Vk8Gqx6qLdkVGKaFT6mvqMti4E2YhtZ6Wjg6u6HH7mvDayaC//2JUvKq6U+H9OB0kMaiE4IhNRoVSSg+zHNW7hplJj6gpycvMRg8YqdxnMImryi/ImVvI3EJvxcHk0gkIuWD7XeGZXm7uuBZED+XvK9kVgo6QyKvH8qmzjCu9PsBUHRk7FjUBUpAvRLTt+1Dx6WXHz4IA0pcZ0cDpjKVGoRMnKfJelnrRk/A64hoqIgW7jfGVMCyVpvmx9yNJRLKILwn95nvx+hqfoDCYw5R10sAv4GPriZOmTnbzzX5CCSvkEwZ9e8wviqwx/LioG6xeO5hc2YTsy5rhiDOP9jrZvqDSv1wlG0F2tVwFs89dEnHkzXRnuaR19J/02o78/NOqYGzBwXL/8XBMsVBYeKQc5OTTx04O/A0+JzuL2vpX5mQQEHwDCAuN+/HehV5jpY7ZMd2OTj3tJpSPcAkvn+WGElGK1NBF/i8pOu0t7oblHUPiIZYgtFtLt5fjFiJPIfsRc3hGGfWAOZQMs6yIttFh5+Govo4EZeC/9QFyWyJNDVDE4r3dm8YXGCMyZgVvetnOdCM0EX5nsov4aAh+/8Bi3OUjSOOKbvKGm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(26005)(2906002)(5660300002)(1076003)(6666004)(4326008)(70586007)(70206006)(478600001)(6916009)(186003)(7696005)(426003)(336012)(47076005)(8936002)(36756003)(8676002)(2616005)(36860700001)(82740400003)(81166007)(316002)(86362001)(356005)(82310400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:29.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d81a40-f37a-4424-cd17-08d916a9bb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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

KMD should not program these registers, the value were
defined in the host, so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index e24225b3d42a..422d106a650b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -197,12 +197,12 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev)) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
