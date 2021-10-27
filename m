Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCB960231
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DCB960231
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1961A6E570;
	Wed, 27 Oct 2021 22:40:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942246E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 22:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqmEsgEXqhA9UZE3DSY8JSGjyslCDmWtp3qzGmHyzr/dQW1lp4QxaVLcs7XyYcqFh1LKoEFgkbFshqIogjVGFVbMg+iyozIsTSrgEQci7RbE690JXw3mx/xXJ6Kr+w0fW/g1S3jtjEIBwqCMGCyDSjHRuO3gIcMwaWFQvtpqXemcPv9gsx1qyQYygqpOb59qHBQ4afgfqZ8AixmesHGLoW7WNk1RS02tFwPzrUdxuEVQBNS8gAC8TTf9JtbQ+gGvZH2qg1QjlhN/xbZe9n5LxrEgF8J9XdUiITOugI2sy0q28BT2Oy+SlY6JWrS7P2v3VnXYogkfM0W4G2gisSCPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtWh4YetGteHAsfzC7GptGsOkg4ky02Efy4FtrOJS6c=;
 b=Qag94SQtNK+4S/5fYjwjZGs4mcnk7kFFHsx140Zmoq/OYpCdpiA8vgHYpuqCXXA1h6zSfYcdtKL1Buu38CpCrKW9PT9FJ9YgHTA9/1dGlzGESLeZva7mOls0Xn9a5KWBRSdIqPctPa854cbIAxja+ZD4kk4373UyinB7dWNk4TiBq+uay4fmcNpnv2zjIKAsCuT8oM1A0hFXP9Eo04jeISrHDG5hinBdF28brcxnVUc+xZD74LkoAlgx768WPqwyRTBR7SctrnE7G1OsUDw5j47GBiobPHCW/wcVfJdjysQ/NNnsWAeIN9zyH4/I9uP0JuB/l+D+Y+1etSIGPPd1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtWh4YetGteHAsfzC7GptGsOkg4ky02Efy4FtrOJS6c=;
 b=3kOxnVPlnaDwXT34C1INu7boJbgvSSCQ0LE31bE6rDieA745s6M5/0nspQ8C4D4JLxQQ4JoYqGFjLt8V9pZtM9Twwgow6QLwAS1Dh61PV176Q3H6AlxUzXHMbfnoj3tite0TshFxcr15dmCq91kF7XuHzkUNQK03iBlGj0F3sdg=
Received: from DM6PR12CA0011.namprd12.prod.outlook.com (2603:10b6:5:1c0::24)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 22:40:11 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d) by DM6PR12CA0011.outlook.office365.com
 (2603:10b6:5:1c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Wed, 27 Oct 2021 22:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 22:40:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 17:40:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN is
 not set
Date: Wed, 27 Oct 2021 18:39:53 -0400
Message-ID: <20211027223953.1776162-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027223953.1776162-1-alexander.deucher@amd.com>
References: <20211027223953.1776162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e63ede-1d24-44ff-f34f-08d9999abc44
X-MS-TrafficTypeDiagnostic: BN6PR12MB1809:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1809D1FE06782692749D348DF7859@BN6PR12MB1809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFzcHTSmGiu4RqDU/5ET7lGHx1akKjHaOFSkEMwo2hcxsUMfktj06ZylUFnCXCwdb5BNny6sNgCviZNLvIf8YgBSF5VfytJvLPWiRJGBOzkX7RtVrzxwA0wFubLrUKQ0zYznKbR8cbTwMyo00sydGSTqIOlyqOajvZHZfgAr+DUMNuTPoij+sXtbs+3DgKpKO7NKFew2nOk48O753TRXQeWGHoFo2ho1/J0v8nuCOHIEvaYpasILLM6LssxvWIocHM51GCMrzwDgcOOkLCTh8uH22V3PiXlfgCLuzlzs6YGJe/ygHwb+NW9ZFjGl4yO6aCPIy2Mh+vC2OoDD0Ci0Durvbh6QMyMsOsD0OBrr7HNsMwrkxXQ0AhE9FygY0gcM6mkwMTyC/CpIZaELgEyoYYWPwRadIjOv5t/a2EFbgDFVDXSF1LB9csy8bmN4FULKiHcm3wQyO2GHfp+Mcne19Sg+CKYFfsU4/D5e62qZLqYsD/yvo0lDgqNlHmt4aQcxPyYEWEH352t9hRMtrD+GA6ufOG4KGBc0e3NEHvl2/t+4dVO+2/EcBXTVL5zSpfnheAg+tFcl0kSrnOTkoHoPbmw3/re/2QwSlpFdqK/nWQct3DTFFf/Tx5OTIhct4sqXWao/AOqf1a6EF7NJ7kUkkeBSW8pWLDSFALBdG1JXMda+apBSBmNCnhuMTO3c98x87lFCNQggov57LpLYmYPFgJX9Q9cMiSh+QKT+bc2CrR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(16526019)(4744005)(5660300002)(2616005)(1076003)(6666004)(426003)(336012)(508600001)(186003)(81166007)(36860700001)(8676002)(82310400003)(4326008)(6916009)(2906002)(7696005)(70206006)(26005)(86362001)(8936002)(70586007)(36756003)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 22:40:11.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e63ede-1d24-44ff-f34f-08d9999abc44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to guard some things with CONFIG_DRM_AMD_DC_DCN.

Fixes: 707021dc0e16f6 ("drm/amd/display: Enable dpia in dmub only for DCN31 B0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3f36dbb2c663..6dd6262f2769 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1108,7 +1108,9 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case CHIP_YELLOW_CARP:
 		if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
 			hw_params.dpia_supported = true;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 			hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
+#endif
 		}
 		break;
 	default:
-- 
2.31.1

