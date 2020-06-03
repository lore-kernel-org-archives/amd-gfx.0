Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE4CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AC520738
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j4SZnuSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AC520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49FC6E4AD;
	Wed,  3 Jun 2020 02:07:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A354E6E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 02:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii7K+QoVFcqcavk78qAj6EXIjuPnLZo2qZxeY5BDkr7DvX7946pvb6SRPmoZmWl5Hzp3MdFnZlNoIBrJraTnJv86eIdQbAswDA2bXHHotk1qg+fX4gJ4Le11QQUJfuOMsnnV2vvhA3yBhzIVEn1/bJpJfGD2Q6TAJqxAdS7l8YkpHyBv4CL+osCjT+owbr6zbZGB/1ac+Cxm0FMDkHAe3fKfn4a7ufI21z3foIv6sV/pezTaAAzfwb7ix33vgJTixdnsw2xUDSgeNzr4X5qihkCCrbI9hiS1eVhAcVw/Pb7cwBFpZe9HGuRHXtNdtojeGSgdME1/Jik8/JQ+0ZndMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cebb+l2+taa8kIC2KVSVvTGZa8p5TxChwZseRPGP5TE=;
 b=Od4C4rpLjPEDYMUiD9mJFJuZJIgeQ5w9fzTZhpoimYcxr+u5BQsLTdk/FWz2YWEIICCGxsuP8HEAXpZ8Sl462dfZzTCVzQ0uPtBNeXMwUfEQmQCDwIiGUK92FU53384v0YPVLUEJzsD6mKJk7/b4UNAW7FjNWYZ9cxXcAf9ZehNsFFAehTi0+RSTQ/OxbXgH4RS9/nM0856BaXaCZ9Jav14dRfBxEUizxj290L35O84HBukAbQx3aVcOeodIsloUKZWoIsM/XunK0m7PurmLB6tn3CIsj/SqU+Ga7QTGBal520iq79zlBC0WcZvUDKkNr5QpMHb/N87MNjQW9IKO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cebb+l2+taa8kIC2KVSVvTGZa8p5TxChwZseRPGP5TE=;
 b=j4SZnuSY3oSmr++dLaXlEqi0z3ujw5kGUVD+/YZBcYVqRHG25d1SAJ/YzpmFeomIhZR/BM3gdcq39XMF5tEzyLlGfuY6bNjIEwXC0HGCjz30RldSmI/1Vfq1W446vDK2ZUQhPYvwa34fpidFWXATHK05OdLVlALmmE5sK/8JtZ0=
Received: from BN6PR22CA0067.namprd22.prod.outlook.com (2603:10b6:404:ca::29)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 02:07:55 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::fc) by BN6PR22CA0067.outlook.office365.com
 (2603:10b6:404:ca::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 02:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 02:07:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 21:07:53 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 21:07:53 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 2 Jun 2020 21:07:51 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: temporarily read bounding box from gpu_info fw
 for navi12
Date: Wed, 3 Jun 2020 10:07:49 +0800
Message-ID: <20200603020749.27189-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39840400004)(136003)(346002)(46966005)(54906003)(26005)(5660300002)(316002)(2616005)(336012)(426003)(8936002)(1076003)(6916009)(8676002)(7696005)(86362001)(47076004)(356005)(478600001)(70206006)(44832011)(36756003)(2906002)(186003)(82310400002)(70586007)(81166007)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6504b2fb-86f5-44a9-ac33-08d80762ed90
X-MS-TrafficTypeDiagnostic: MW3PR12MB4474:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44743EE15E4FCCB0E1D666F195880@MW3PR12MB4474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFqgkAruWx0Z+RrqWqtXfEgAtNY7beqy9TAZ7GyqS1OsYPjwypKkbD/aez3opI8gtBVB9jFaDGTeusJrdu0Hf3MHm0bjX9+//LSD7fu/BnHpp+YBvARUoeap+Hk+q+oedXcBvjnB7qMYWGPaXXvOETtppnm659B1W9NIoe/eofzKaW3JgpWt/pqdj5nV/xbP18F+9hgcfdBpl+sggW+Bo1jmkK5Flm5l1XorEx4tpiwBob68AQlifreDVRZxGEUTnuOnckaIngKAOUTjYLDZFb/z5VETeXYcqpSZb6TxFmhJQJB+uiJZwyaCPaOoRAhm2SZcNYd5vsBrQCRoVId6ijDe2/gHuFrvKvrMCQfRbhMJqQJwC8r3v53sWkVCyKqftY2ljVfcEWA8m4KLRQ6Zvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 02:07:54.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504b2fb-86f5-44a9-ac33-08d80762ed90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Cc: Deucher Alexander <Alexander.Deucher@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Pauline Li <pauline.li@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The bounding box is still needed by Navi12, temporarily read it from gpu_info
firmware. Should be droped when DAL no longer needs it.

Change-Id: Ifc330ec860f9b0665134a81df2fc80ca91c41a33
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 15de344438d2..1df28b7bf22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1537,7 +1537,14 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	if (adev->discovery_bin) {
 		amdgpu_discovery_get_gfx_info(adev);
-		return 0;
+
+		/*
+		 * FIXME: The bounding box is still needed by Navi12, so
+		 * temporarily read it from gpu_info firmware. Should be droped
+		 * when DAL no longer needs it.
+		 */
+		if (adev->asic_type != CHIP_NAVI12)
+			return 0;
 	}
 
 	switch (adev->asic_type) {
@@ -1627,6 +1634,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 			(const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
 								le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
+		/*
+		 * Should be droped when DAL no longer needs it.
+		 */
+		if (adev->asic_type == CHIP_NAVI12)
+			goto parse_soc_bounding_box;
+
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
 		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
@@ -1655,6 +1668,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 				le32_to_cpu(gpu_info_fw->num_packer_per_sc);
 		}
 
+parse_soc_bounding_box:
 		/*
 		 * soc bounding box info is not integrated in disocovery table,
 		 * we always need to parse it from gpu info firmware if needed.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
