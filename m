Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE16C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 05:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E1A10E5C4;
	Fri, 19 May 2023 05:54:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172D910E5C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN2Ut4KkJ1IvG7U37sT1GsOoefLhT2VkJWt9gHxm/yp7I7r8YjeHMvCwFkVlcfjDpnah5c/MFr4suyVV3fiSEl4daSnk2+W1kY8B2TbZio8LNKgC7c9putfyztSLjnK7051jlsb8Uta+zaGfUfrYcQPEBC/W1/+/whZjagEN0PrB9rxoFGs7ogFAG+FDcrKNcp97ZqoAW8LDYo4ZNKqvOTbnNdXLg36vWKdbjAXuEXuAsj/b+nOp/rMzUkvMzbSyIjwfPj+4rz7QchjfilVTesi+B94qncJ5brw207QqK2mPGJ/0SusTWd6Gs38C0l0zHAHuhuZQMHCKG+Nrfa9Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrYtetzMpyiHnSOaasqwGEQHlhMEBR6QafkBruTTaSU=;
 b=RDuYRuhi7YQURtieQuPxaiT60MgdUCIgO7EGpPtJYN5WPbwoo3t6ZBvwajC01EvO1fVZCoRj/CdQandhZQpFEVbWdroDNpImsFdmppyo2nnorCizHwiHwcnSs22a+pTalRNtIMyyO0E9zGalDWeq1vJDZA1hWXi7VMuom+2pUIAHS+1E+vk/+KsMKHoKMUTxMplXkJ/4PdgZBfk8Fn0vSnY4JLKCViQp9sNXE7vq2FPcWcRPAUsx7YsGCdX1xATlMY5gRrvA8L+3RnjHs0mWeEvxSRNv2xQQVOvE3SJm/haETkxw+AjfC2yzwz0Tch1MV+DNk8iINwsKglfMpZGf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrYtetzMpyiHnSOaasqwGEQHlhMEBR6QafkBruTTaSU=;
 b=W11SO7KTTwsZtxjcyLtX46gHLF0Hp4t+11c10HYhz3cYKEx+jnH+uhuLhp+xHybQt2XQfhbMj+P4RgQztPrrbh+pSCeChXs0wTG85KVJGTpbUEIgFHLpas75S5hpJ2XhpJd2sKXuTNulDJNAxAtRc98KD3UHvxe/oogaUFzE0YA=
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 05:54:28 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::d9) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 05:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 05:54:27 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 00:54:25 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused definition
Date: Fri, 19 May 2023 13:54:16 +0800
Message-ID: <20230519055416.13910-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c12176-fadc-4df5-6700-08db582d81f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qlf/vdFxBuIx8TzTBMFGtc0byG6tm+RDhcn4eKWiv+kOoMyQslQMSR5p/pOl2CsYSV/mRqZ77oi6iyTOqe7Ouf5nqq/a4LpYAV6An3//mfcm4EmIehOgJNZGIe9DILi8AdGjKBXUNQX9QxWqNx9hIB3+/6HS+N6hqKCTDokW6IRjjAmD966DqPi/3PSdpvmxMrqroPyu08sMshouKH0iJLJfhUyPR7CgyxxppELcaJwpO72t0C/mOz6etY1AtmIgmz1vwWXKbpaa/kBxVjMSy1pb2m8ZOr0nOAduAOOyIHE9O5IfEvV1YsDZr74B0eGJ3xMU/INDTf25OlGzebENwtXWy9AiBxFJeBapmnwNAvgoNMYDBbBzf0twDe8HmJKNl4VMByoLCM5y/Z+Qg9keMBUKPriYy7sznc/GDUtk6TN3sOehXVVORcs1Eq4xY1pWKXgSDQi2yKnAMnoKvOBmD9V8S+9mfNpe9Hm1vQwWWvGAKGegvJSacIxy8JZQgoqorFGY4VsxuP2cSwJWGmI8Ih9TF3tuJpU3Djre/ApZBNOx8H9WHM+P+4VHmoRrhVMERD8p9cRm7G4XLEIizI0LSjF4eGfPwM1iJHnrOow22UUNbOo6eRIuR90MR1nj1+RaEP3QZ3QLTjLwUvztBFsNSSl1JB+9Rq5d5BbsKvcIOFLNUrETHVD1YIOcN1iSlbWpI09/49HlGaTQ7h3zLTuHvUx9JDpsF8wfFWdkEtX7lYRRn77dLy5obBeIkpzlkN3yqmawkU/QhJRiYRJ7AfZ4+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(7696005)(478600001)(6636002)(70206006)(4326008)(70586007)(110136005)(54906003)(316002)(86362001)(36756003)(83380400001)(47076005)(36860700001)(426003)(186003)(16526019)(336012)(1076003)(2616005)(26005)(41300700001)(8676002)(2906002)(5660300002)(8936002)(6666004)(40480700001)(82310400005)(4744005)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:54:27.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c12176-fadc-4df5-6700-08db582d81f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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
Cc: Tao Zhou <tao.zhou1@amd.com>, srinivasan.shanmugam@amd.com, kernel test
 robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mmhub_v1_8_mmea_cgtt_clk_cntl_reg is defined but not used.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3648994724c2..00e7e5db7c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -757,14 +757,6 @@ static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_query_ras_err_status(adev, i);
 }
 
-static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
-	regMMEA0_CGTT_CLK_CTRL,
-	regMMEA1_CGTT_CLK_CTRL,
-	regMMEA2_CGTT_CLK_CTRL,
-	regMMEA3_CGTT_CLK_CTRL,
-	regMMEA4_CGTT_CLK_CTRL,
-};
-
 static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
 						 uint32_t mmhub_inst)
 {
-- 
2.35.1

