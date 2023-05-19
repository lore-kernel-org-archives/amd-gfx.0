Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BB5C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 01:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B62A10E59A;
	Fri, 19 May 2023 01:53:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD1610E59A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 01:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPaQL37KKws98cZ1yKJ/Zz2+1ieHOexhngnO3tv61OKvhIY9IzVA1UYfNmjfDn+7VZHVoWsms2yQAmzFa5DUk2PDQipPX0zRc3DGsA5ZVb+Lst9EQQij4ylMb2K/ptILKd5LDXnk6uaXwyCVuJi4O9ZDMA/4CwA+cfwGLDKcZ0WFXZrP0F3wLRSpj96DQzw8jKQW5WBZIuTOtfD7xcrTKrJzTglAGy6wJNLam50Hx5y9DYD9bxQcj2WEjoWyFbH3iYY2JvHJMS1iaLqcuwVgvTdXL3hljY9jq6IP+ipsFKwAsmQbEGqj/BX/RDpSEIgp6hdW2f+h192PT0OQhzOgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODB7IqpYSzhXg6NATkJbNMbZl/wAjbToPy8DlIfNHHg=;
 b=NpinD80q1xNXtcsKKKtT0brGNDl+9wtmkYXEp2RSsEOnH9i5rQ1Mp/YSbYgqVriozMVqgRkM/1JQAavxZfHbS9lV5hxGIaWaMTamyPW0BSvJPUfL0qgmmEvu90Ea12lZI7Lo0rOSVXxUF4WP8/lCmmMvlFc6y0E4LWNSvnIs6eeIIekgJExtTKtIN4TlGRyJEQp9NyZsjE3MFah7x89Yt30p/NZ2cp1kx6w9TL2nn2RAR6j2mEg7GKCo+K2GgB9Y4sxwFts0BrLeScsOTjXsaVNNMayutvILSZKm+G/K/LPOIFv2/AwH3UtVZXMCKn/bhxypZGg+TZn+N5xXDtS50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODB7IqpYSzhXg6NATkJbNMbZl/wAjbToPy8DlIfNHHg=;
 b=IIoSD82RfWl4kVsL2kpZ9mniFcEghbMadl5PoHq4jRdrg4cFEUZh5UHkORC8pPorYmcJRHnTCd39sFlyuRu+uv4bSqzkDmDUOAkfi4FmZRxuRG4Rn+IT5zY1MYc1sM/LLv0iH59lRs1OFrjt8zSiGH+fDjJMmfy1+BQdkLXse6U=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 01:52:55 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e4) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 01:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 01:52:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 20:52:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 18:52:54 -0700
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 18 May 2023 20:52:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdmgpu: don't enable secure display on incompatible
 platforms
Date: Fri, 19 May 2023 09:52:51 +0800
Message-ID: <20230519015251.1057627-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a77c28-dcde-4ec9-a582-08db580bc3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1uuRcFw4fG45Yhy/YaQ7DVZbmk8ZJ6nQnvFAKuRY3nHWdaHXMBHILyFuXjr08dbwbO+Wm8FvzXjxShlamh9jjWa4D9SAaajETm8d72gLtQFCX8h2aH1Eb5S9030ZdstTx2bI8b5GsMD193RJwLuu4RVyNIyZAqufmFIRK/q4AyQznQzMHGX7Q197ckYpF6bvBhKkzPB45rKwIiBUus8q5SIopjym/uOSy6RQmGxuGH+mMDQBUCrB7NkTLCQDnMGB7tDRH0y6BhdObNP6by3OzVFHeB5+Ov/bjHNgEtGy/LInbxrguhqPSOz6Vf0TTuhgmYsf8EN9RJgpJUUOMT6nT60Mh0knIiVsliQp4XsGEankuHVT3LOlOEvIFhckb5cSbkhHHRFM5qGrpPMM3rhWdt8rFPmYKoU3vKKkGJgFW71076eR88Mf6c/cb8YMz5nIzvjLOnKejq3G5tkGWZPP/jp4MxzcGIvyQIg81ah62jDMLn7mMQC9w5NsXZ716L3LVaiy9g9ZnudE+peUjiqbbXN0rSzdvK551Os2zllHLMcdwFUashCp2/xuucEWreac1+YDdfVpg1EAtXHO1hitgrIvohx33eCx2faNY9Infz/OvVn4eHm1C2+5ELTMlC2S+gGlGOfkNAxrZRIZtbYnXA5sboKTTt59wkkU+dSGPX2A0daoe4fyKMyE5NM4eaH7GSvIA7eg1+k9GSk+mT1o/2gnyLinYoyI1alXzy5r6h3hSzX23A+ITU0aBgEzL5wlWt1ZWG/7j+cZ+WSxtbJNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(70206006)(70586007)(6636002)(4326008)(316002)(54906003)(37006003)(478600001)(186003)(41300700001)(5660300002)(40460700003)(1076003)(44832011)(40480700001)(8936002)(26005)(6862004)(8676002)(36756003)(426003)(47076005)(2616005)(336012)(83380400001)(2906002)(36860700001)(82740400003)(82310400005)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 01:52:55.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a77c28-dcde-4ec9-a582-08db580bc3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
Cc: Jesse Zhang <jesse.zhang@amd.com>, shadi.shavakh@amd.com,
 andrew.strauss@amd.com, amd-gfx@lists.freedesktop.org,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
[drm] psp gfx command LOAD_TA(0x1) failed and response status is (0x7)
[drm] psp gfx command INVOKE_CMD(0x3) failed and response status is (0x4)
amdgpu 0000:04:00.0: amdgpu: Secure display: Generic Failure.

[how]
don't enable secure display on incompatible platforms

Suggested-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Jesse zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index e1b7fca09666..5f10883da6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -57,7 +57,13 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
-	return psp_init_ta_microcode(psp, ucode_prefix);
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 1, 0)) &&
+		(adev->pdev->revision == 0xa1) &&
+		(psp->securedisplay_context.context.bin_desc.fw_version >= 0x27000008)) {
+		adev->psp.securedisplay_context.context.bin_desc.size_bytes = 0;
+	}
+	return err;
 }
 
 static int psp_v10_0_ring_create(struct psp_context *psp,
-- 
2.25.1

