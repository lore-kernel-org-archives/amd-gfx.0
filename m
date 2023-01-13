Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B19C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BE610E996;
	Fri, 13 Jan 2023 06:55:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5AA10E995
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAcq+OSsRbSdMKT3Pj4auxWHWAEeXv6x95kfKtlXlJTkvb3D30HAVXX/Vkpb8oncODBVC++vw9ty69s8/TKHKcW9I1JsyjibOsDMym+dhb0iLL/FCIAfYuZ07okIGkKi4dszdcK01fhPJgvK/zeSrYOiOxh5sIbrQRNgIWS/PDajlIi0jyiZxSVi1B4v5vm68pmro64raSLkN96LSjb2Rm35Oir2yoO/nG/lhXbYBbrN3Pt/dePqRvWwquQx7zcSBhWmT+aKuQ8om0iRGo1R5Y3KBVpeqvnS54khvt8V3F81g8YN51MDcXZhQGZqXuFz59+oBqage2Cf9B9JqLPZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UH0Jtp9+u/lQYbRPr02AOtptpgStwnFEn7Y5P+8aYI=;
 b=ikzEOmJuKSAGvX444vMIsBaJqj06+bZk6HAo7D+w3XgeMswD1F9cqvpANwJNBjyBgG+ebh7BVAnr41IgrCtATeFkCuWOHq7d8vqO8/FerAd/AhHzoyXf/su1op1if+c4rBsmmJTGRBMgCRcGSw+p5FYgMv+BZiEl1z9YKn3o4cKsfE62EmSSXNVhYA4zCmVquu/W3/vhPRPqqTykq/nKr9/m+I4Vf0I4vXWjJmWGfQzid2jKC0A+tck8hp9N6xtY1JgDug6Kb1klBg05aeQJC2OVSHwZIsQPE8r7nHQW//5uPswSr6wj1nTYUaWeIDDNlpurd192CKPzvYOFt4pLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UH0Jtp9+u/lQYbRPr02AOtptpgStwnFEn7Y5P+8aYI=;
 b=lCtCRNdmULWw4ml7CTetX6s9E7PhNmtU7bWwmB7cLmQ77PJ1P3b+4qR2wE9+PXtm1MRCWmR9HjXSp7gjzWw1UhzQZmVTwpewFGOf1gRo6lwJH5arLPMbOR/cKwa8hjkhu4ej0a7urv4fgOJYsQOoq6o8UShrVO2efGh3ZOzbs1Q=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:55:19 +0000
Received: from DS1PEPF0000E64B.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ee) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 06:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64B.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 13 Jan 2023 06:55:19 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:55:16 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Adjust ras support check condition for
 special asic
Date: Fri, 13 Jan 2023 14:54:15 +0800
Message-ID: <20230113065415.1727983-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113065415.1727983-1-YiPeng.Chai@amd.com>
References: <20230113065415.1727983-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64B:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 144f1c48-39c3-4266-993b-08daf533224c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suYYzvu/QNe/dQ1CmbDLCa71cLDA7Fe+S94dYQEUA/VUViVPHPGBmIQN6gSspN8XykoeZ/Yrx8JbCNG6g+zjWWeK2duByByr/Bnl9ryCVDwd9j1SteUEGuUB8jg/yyUBzAtZOebFoz9DLsdLayYGKFAawCXMRH8rcGw148xPEBGM4ae3Rh6qZ4iNuP6JzteM72b0XZNSdVO12cZO/sy/ftwMi9fzkRrRwzpm+Q9Mp3Ha8S8JhYi2aiyd1ZrdB8y9qfNvutu35VvTyCKzMd8ILPxms0nzW5sbuVRIMFJhyWURAbyLW23w6j59zw9++AkMvLILrUHXnVqMvj6q3/sMz8Xg81wQrnzJG/m9cVTl8dUV03+g7qLvrlTsdEtX7o6Flb8Gd+vTHV4t6DfWrFWoV+hETMK9efvHAZx4O/8FDgd4XMeu5XUFo1ouQcdiiU53vngm2yGNf3HhjGIWGREaa5ERi/c98WaC1Yhq7qn3jGqUbLEllPUVBiJqmHjeTdiE5J4eUbHUxoBrsx58AoXNHbuHsnhrAULb7c87zWu+jEHxrcCAjEOJrBXk+gXCJZFpt4ukrdWXZ7OvX8vcT8J5FcXQOn+16wH1lRMPkMWgiS3/9J1B2jBEy3tK5dIAF6Dvug1/zzbM5NhNiqDxPHqcxXS7mqPeMnR9XhGJJBFY/y0DNn5Gkv2VMVSdr/UBU0WImdzeVISglIc0Fc+B2wBx5nHS5Dj4q2gLLHH1wH3UAok=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(2616005)(54906003)(36756003)(40480700001)(4326008)(8676002)(36860700001)(82740400003)(70206006)(336012)(2906002)(41300700001)(426003)(6916009)(47076005)(316002)(70586007)(1076003)(40460700003)(356005)(5660300002)(82310400005)(8936002)(81166007)(86362001)(83380400001)(478600001)(16526019)(26005)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:55:19.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144f1c48-39c3-4266-993b-08daf533224c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]:
     Amdgpu ras uses amdgpu_ras_is_supported to check whether
  the ras block supports the ras function. amdgpu_ras_is_supported
  uses .ras_enabled to determine whether the ras function of the
  block is enabled.
     But for special asic with mem ecc enabled but sram ecc not
  enabled, some ras blocks support poison mode but their ras function
  is not enabled on .ras_enabled, these ras blocks will run abnormally.

[How]:
    If the ras block is not supported on .ras_enabled but the asic
  supports poison mode and the ras block has ras configuration, it
  can be considered that the ras block supports ras function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f1e987bdf83..6e543558386d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3022,11 +3022,26 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_co
 int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 		unsigned int block)
 {
+	int ret = 0;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (block >= AMDGPU_RAS_BLOCK_COUNT)
 		return 0;
-	return ras && (adev->ras_enabled & (1 << block));
+
+	ret = ras && (adev->ras_enabled & (1 << block));
+
+	/* For the special asic with mem ecc enabled but sram ecc
+	 * not enabled, even if the ras block is not supported on
+	 * .ras_enabled, if the asic supports poison mode and the
+	 * ras block has ras configuration, it can be considered
+	 * that the ras block supports ras function.
+	 */
+	if (!ret &&
+	    amdgpu_ras_is_poison_mode_supported(adev) &&
+	    amdgpu_ras_get_ras_block(adev, block, 0))
+		ret = 1;
+
+	return ret;
 }
 
 int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
-- 
2.25.1

