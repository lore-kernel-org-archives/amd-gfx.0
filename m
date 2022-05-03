Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA4910EF0C;
	Tue,  3 May 2022 20:29:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684F710ED52
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnFhmeS4wfWRUghhRPvqKCjLbN1W5JgOugN5TxYOygVcsnCkwM7CYogv9/LhKlBrUv+6WCBRBbh386x47zNI2tDHoIAjVd/dQvJ4Vvm/NxKOMei2uvb4lpwd20iYntf42nfUY6xoSuY/gww9IUrPvAPV6MHiRgy6wgenRbYoNYIYnTaCJIYvuunAPiZfmpQ6usWAtWDgH9cgwovkRRNAWs3S3Fy5tP51FE7FreXfO+9ZDBWHl9rH94JEcQ/F+QcUrJpHzvYsPPLXaYxWHKNB+1vjeb+rEIhL3pdfBoWe9tw//c5VIRJBofUh8NiVV2aaDOxdZmzsPZHH4h6E5lWvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62AwWD/FOtdVexcRHyZIF9r9GVUrCb2sN7W+tgAGFSE=;
 b=O01Z4TiijvAkvGlqbmUyT+B9PLbH/nbsCPBPYp2n2DnpqeHF3fNga2shSn6ru5IEVfJUsyeH00z6RLUXSVQmhkooNwhPzKB2Qxgn1GjbCSOI41erIY+HLOoGTkEsiYElVc4mpwIybyjHLZB/5FpB9a0jJmmP05KkBeLhEc2e9zbXmbIQyPq/DBVa0beRw9kgL18XM4RSAY75YIxWAUzMCIfA2IzFylOmBWlgQAL3H+fJu0O2fIFmT/iHF/QxqEM8bZPun+t7U7RWkglYQLTXJ5F58aI1d62MoHrnVF4PIyLDPZ9zoxveuKx5qGmY2jiamyFOVkBu6pkIRU7AfpcpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62AwWD/FOtdVexcRHyZIF9r9GVUrCb2sN7W+tgAGFSE=;
 b=Rst5gtlTPLLjuE5d97c7VNU6+WLZoIvhIsDaWcjQcqcFR+wLK7hWKm6gvixNSKJZ7T5/5rFbhg7sAk14uKWF2V8waY/mDJGv4ttRi32utjI4T8gMVqy+AhnaxRWzdC+Zm6tWKvB+UgdU6dSHZ4YpLz4iUYE55ONojbYwwXto10o=
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 MWHPR12MB1648.namprd12.prod.outlook.com (2603:10b6:301:11::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Tue, 3 May 2022 20:29:27 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::89) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.12 via Frontend
 Transport; Tue, 3 May 2022 20:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp13: add support for MP0 13.0.7
Date: Tue, 3 May 2022 16:28:51 -0400
Message-ID: <20220503202912.1211009-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be08013f-0997-4a07-d8a2-08da2d439ea1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1648:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16487E8238AA531A64938607F7C09@MWHPR12MB1648.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amExfZhNh6e/KKd9eDseFBVRDC+0QB0KsoZWhOhhLKvx/wMVX8qMcfe51Yyd3HcS06GfxQNQxLnKfCHlGd1IrBnoOHMpL++xgbX36FSJmKHe4qxwKFxsCLz+jFGOiNDR6RCwkuVtOVxFO+ZqiZJHy9QNF0O6DtXqyjhW4u0zqSprv0S2sR5ux9b6BJ1t8z3d3kGLstBtFUMECRPyfVH+aLUu93f/4idQh4UehFTSD9H8dRIFrqLRN9l0Sxar65cSuNLou8lmxgy22+chNWZ6cipqE94Vwe9NrVeBFjcUavHKLaHRFBcE23NEjNi1PA2u9+TSk/KvFbprnxlMqLMJWKUiMzK3uk55zYnZMliMepxSJOM8VAx0oENJgipZDvkSvi3p9P18NKyFWDhp2dUNqPPZobHEMUYdg12mPh1zFU0M8xh5WCvMuwX2KjTOq6nfZvDDMRuJg7W7M0jkUp2I2VQZJe81Wx+8RH77F4SbpYDlcBbMo3PwCXOwc0auMSSPNX2UYCUtCFysB2JWUWfRSFi2sqnnlFRMTaAsNyI0Qztp5UDfwWM5RS7XSn322RNVgx+05LiTv2PzJvKxL1wDd1rUEOE1J0sXctI/SHfLUfjgzkmbZq2OfsHNW9NKUFSChhmWhOi/XdnAQ3TerILY9wotBnLZR0d6kXblr/vB8sb2ne1zhVscJOvXUB9J1psSS63YHEOQLwslEwmF5FGdIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(2616005)(40460700003)(1076003)(86362001)(26005)(36756003)(70586007)(70206006)(316002)(82310400005)(4326008)(54906003)(47076005)(186003)(336012)(426003)(16526019)(8676002)(356005)(7696005)(6666004)(81166007)(2906002)(83380400001)(508600001)(5660300002)(8936002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:27.2562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be08013f-0997-4a07-d8a2-08da2d439ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1648
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chengming Gui <Jack.Gui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Enable support in psp code.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7f9ab12ae1ab..25c90ad2c0b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -84,6 +84,7 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 7):
 		psp->pmfw_centralized_cstate_management = true;
 		break;
 	default:
@@ -144,6 +145,7 @@ static int psp_early_init(void *handle)
 		}
 		break;
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 8d3cdfe17f56..9beb94681dd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -42,6 +42,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -94,6 +95,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.35.1

