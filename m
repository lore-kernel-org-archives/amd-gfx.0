Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D97C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819FF6191B
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819FF6191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80A76E043;
	Wed, 31 Mar 2021 05:20:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38EE6E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 05:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx9ZKyaCxCNSSF3PkbIY9TerYPDB20YmegtacXcLSceuYBzXrSBjALeeQ5kjEkFrKtgp25tN4oYOMLBziVEhnbte1Bp302JLJ1x47fnE3nIu0iUoSUfTh5E3tOhe2yASS7wJO2SSgy64NqkYK5TWjJrcBgCzBl/AHUjL79jRz+5O0bI0fzdMEPJ740iTQCgPpPgjPz1J5lHR6hCEmmP0i5341LJvNwdVMvJy4NR0me0tEVEe0TzU5s2+hKxDX+vOVbGP8Q3mbgaSojqlGaKcZqtElr3JuE7NajvkpJQs+IpXD3liulFtjBhhG77nHAMCugr0ZdbcDYeiXQe5hBTD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9xxEFFDgrUQpxD6vqjt6ah+kqNjxIT43rbL9sd+UhM=;
 b=mztSECiRb8eppoB1aQuJUjEtsq4npGyA4SQ9OixdxJrxde+7VCWfGTDz0/ofkMs3H822nIrUsb4rwJL+mSMusUUswdFBiuHR1tONW1mc4iQSoAKgCJdZiS5a3G/ZDgwo2FE/sMTRjfeeVQpBjay0ZPKeyzqEYwaZ3usPw36NegGfGeT7pzecPCkR8bsQxfWTTP5HXEkTc0flFk5+lOg5NZTFwF7Coh7ljoc2bDYWJ63apOVODnld+Ur5DVNfuotxOXDIf3B/WVQwLU/gurmFrc2VNH83sv98FSdEsJAkxDmBU8YwHWYfG7Ozflfq2kleYlaIZ4LSl3JFtqvwJ9kQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9xxEFFDgrUQpxD6vqjt6ah+kqNjxIT43rbL9sd+UhM=;
 b=m9YNJDy+4gIdLIwdphnEFmyvjZrV2A5DQBHFDq/nRmjyeOL/BsPCy+ctGfce++/sU/Jpqe/g68D2PZcl6EyjBiU9CIeq/z/qivhb6JWJFrQXFV3PXX3rJUfBGj0MTmMWoV7uOt4t6pzBPvB9cQa2211ZtNhYiIk74LKMnBfDtWo=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by DM6PR12MB3883.namprd12.prod.outlook.com (2603:10b6:5:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Wed, 31 Mar
 2021 05:20:45 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::2) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Wed, 31 Mar 2021 05:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 05:20:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 00:20:44 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Wed, 31 Mar 2021 00:20:43 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: indirect register access for nv12 sriov
Date: Wed, 31 Mar 2021 13:20:22 +0800
Message-ID: <20210331052025.24200-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aacdd57-f19e-451f-f84b-08d8f404bc9b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3883:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3883FF8A485E5BFD71A07192F87C9@DM6PR12MB3883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyXWSqG6/pp7OJun5aKBaKQVsBhKi6CMquFAkzIiAWdaMo5CvuxZzw6cCqdAqqJnMXiehkaWdg//aVVzTs3Xuvul7G8G+D/52Zo3iO8e5lJ2wA4fEL+Tp9mHhG33BjkT9buWRZ1PfQaD2lXgLClHWz2X3sRCDMlYdV0sNNDApS2I0zykBsPpCH03l7cTkj0xtdJSRzkxXIAJGR67ggqdY6sx2dm+Lfmq5/vZzTLFow40pda62KNXCD70MxqRDnqk6ROh5ws5Cfh9DlYRoscBffgkVLYvhPlm+q9eRGcQNhyZxiaLRFJ2XSKLpezLOLCwR6iRoa6XZtCllp+DN7gOx152NfAS4He8bWMBRD/8ZeA6kgf/rmdcJfJoL5atVSPPcdfxOB+Igvoh3uD0s5/fzviKT9XVFxg19q1SrX72SKjEZnpMIKHIdjwzavFmfFAxPVJBMX513ca+MyVisyONpZcfZaoChB79rUHMEHci6W+rRTt3TmgcrNzUb6XxqVgje7kCoD5HS1h7u0rr/toP8kJoHXxyG3rMfBWqahhNtVJpI2uTJLw9mGvDGKVYIN0tSdE9awvoSmwJJvp5k5s3asI5XAMVydIK+a3VMKutonnd5Ffx4kOHsK2OSUyhgdFn5+h8kH6MxdyexoUfsiO46TYCFtdC+Vf11kMhgA/QtL+o2tqkE2OaWFh0I8+bLrnq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(478600001)(4326008)(70206006)(5660300002)(6916009)(86362001)(36756003)(1076003)(47076005)(2616005)(186003)(70586007)(81166007)(336012)(426003)(36860700001)(26005)(8676002)(356005)(8936002)(2906002)(316002)(6666004)(4744005)(7696005)(54906003)(83380400001)(82740400003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 05:20:45.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aacdd57-f19e-451f-f84b-08d8f404bc9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3883
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
Cc: jianzh@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

unify host driver and guest driver indirect access
control bits names

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 097af4d3b6b1..3580a746ad9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -110,11 +110,11 @@ enum AMDGIM_FEATURE_FLAG {
 
 enum AMDGIM_REG_ACCESS_FLAG {
 	/* Use PSP to program IH_RB_CNTL */
-	AMDGIM_FEATURE_IH_REG_PSP_EN = (1 << 0),
+	AMDGIM_FEATURE_IH_REG_PSP_EN     = (1 << 0),
 	/* Use RLC to program MMHUB regs */
-	AMDGIM_FEATURE_RLC_MMHUB_EN  = (1 << 1),
+	AMDGIM_FEATURE_MMHUB_REG_RLC_EN  = (1 << 1),
 	/* Use RLC to program GC regs */
-	AMDGIM_FEATURE_RLC_GC_EN     = (1 << 2),
+	AMDGIM_FEATURE_GC_REG_RLC_EN     = (1 << 2),
 };
 
 struct amdgim_pf2vf_info_v1 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
