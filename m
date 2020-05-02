Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE07C47256
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAC22072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O1JMTuT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAC22072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3EC6E169;
	Sat,  2 May 2020 21:35:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E896E169
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moxdk/YtZi9keh83IiRekHJCLDZz3aKKLegDyS8TOyz5YHo/awIh7yJxmJ254QhSn7Q8OPB2TwZuXMaHBWVRYhssxMp6VS1UxATCvfafXkwx3Ss/OJqKHYTCndwIjCsFKGUhA0dPuxDkZD7FDH6cZRNwyU8lP5g2ujtpuiIPlHJDFE/7KouUUWeeeZ3DyipRqWV+3F89pgbWaIAhawrPZPivGKpzY6lfuAGloF+3ovziPi4X43XzZE1VTosE2IJGCsxFC1C1Qu4mfVLtRbk8s5b2bMjICR40oO74F5DUXWkJ+Y4HKxv+r6oeAPDBUAyrDmp6QTcvdIW0liBHfXZwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0slnnlPBDWQXvAyTsmEzygdcY+OLtyJ7o2KhWHuAlM=;
 b=fQHVTn8pdyA63yWA0++p0HW80BL+uvFW9ENZJsGDrnkb3lEXsh9rx9kyeOrMwO0G3dVosRud9i8giw3mEdgCF0+xlK7dUhjJHvXNqXVaihP80LVNbj3M6Wwxe+X8jY9m6m2oDS3vXDDLjhJm3zZDsG8rgBMo/wKtBIX/TMiaYw9lCNJo0UKULt0LAMoPXpFuhRstKIVwdOW2kexK3ZGbPMGxZSoccx1yzYPF55DhgyFhYmfDip58B1gS2UTFFClsMXGSULjbif/QP4ChW9Ghen7bjRGulJ8gklrV2iKMe18RjzwwKtCaIsBGS4MnX+HwYR289YwffT3a5pLJIWA9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0slnnlPBDWQXvAyTsmEzygdcY+OLtyJ7o2KhWHuAlM=;
 b=O1JMTuT1r/HaNfk+sprd4Xdb/8TaQGhTLjT8B06H3jyqiufSf6tb28rGqirNLJ7xw8L9WdnCEHSK6f83PqnzBZ+/oKR29/t1aWQUZjFTtBzLBsgM3ZEbPSf9nyBhGMP8XPOL7dC6uoU6rBmDRSPTcfwqAMN0CtA26r7F2Rcb3bI=
Received: from MWHPR1601CA0005.namprd16.prod.outlook.com
 (2603:10b6:300:da::15) by BYAPR12MB2966.namprd12.prod.outlook.com
 (2603:10b6:a03:df::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:56 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::3c) by MWHPR1601CA0005.outlook.office365.com
 (2603:10b6:300:da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 21:34:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:53 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:53 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Support FP16 pixel format
Date: Sat, 2 May 2020 17:34:34 -0400
Message-ID: <20200502213443.39232-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(316002)(478600001)(336012)(7696005)(44832011)(4326008)(70586007)(82740400003)(70206006)(356005)(82310400002)(6916009)(186003)(86362001)(81166007)(47076004)(2616005)(54906003)(426003)(26005)(6666004)(2906002)(36756003)(1076003)(8676002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171260f8-87ac-4e93-37db-08d7eee0a75a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2966:
X-Microsoft-Antispam-PRVS: <BYAPR12MB296685D220A0B41921DAC8928BA80@BYAPR12MB2966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQidA3U45SEDHDIkBPnjXLie1zpdnL4I7TOJEk3PwuKvJ5DAPTTeQwfemTT4oi1A5fXyuE+HXxPihIdXhe0gqRMNV/KPG74TJ5opQjL+R+OeG37LdVpzHo0jHa3BkjNZyVhVrLn1AfztFHFQrX8zXrAmn3MaE+GF8gHrVQ7aoJByVYT4Vd84wTzSmHlCsl4869sToVAu+VM+STrk30Gpm0V42qOf4ZW0KxD61OCsVII7OjB6mloFqA0t3SFhPINa4O5EhU6G7o5gLtUqFkduU0b2cqrf7JDQCShadaP0ijofU9rfri4U8gex9qiCGo8Qd93vYI911fTbmyQhnekIVFP8VtKmm1/vG65TcSn7H7OOWLLG12RsFuZyvYmdfx6/YK388QPc7h0xkPIelYV1I7VaZi0mxYP3rlL+9ErLkYklwXdg9CMQsA7LzKVdF5lcllRzZFGhZrsy0S0Q+qFZ3aJ57HV/FXAU5i7ZeQpWEJR7kp37YzjPCOKoo4/po0fZdtByaqAPc9J0ozAU/cA6Aw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:54.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171260f8-87ac-4e93-37db-08d7eee0a75a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
FP16 pixel format is not declared to DRM in Linux DM.

[How]
Add FP16 format to the support list presented to DRM from Linux DM.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ebdea5f051b9..98446372c3b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3734,6 +3734,10 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 	case DRM_FORMAT_P010:
 		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
 		break;
+	case DRM_FORMAT_XRGB16161616F:
+	case DRM_FORMAT_ARGB16161616F:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F;
+		break;
 	default:
 		DRM_ERROR(
 			"Unsupported screen format %s\n",
@@ -5663,6 +5667,10 @@ static int get_plane_formats(const struct drm_plane *plane,
 			formats[num_formats++] = DRM_FORMAT_NV12;
 		if (plane_cap && plane_cap->pixel_format_support.p010)
 			formats[num_formats++] = DRM_FORMAT_P010;
+		if (plane_cap && plane_cap->pixel_format_support.fp16) {
+			formats[num_formats++] = DRM_FORMAT_XRGB16161616F;
+			formats[num_formats++] = DRM_FORMAT_ARGB16161616F;
+		}
 		break;
 
 	case DRM_PLANE_TYPE_OVERLAY:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
