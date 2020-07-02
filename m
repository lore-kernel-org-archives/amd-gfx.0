Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE00C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 18:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7087520771
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MlO+v4dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7087520771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2687C6E104;
	Thu,  2 Jul 2020 18:48:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A9C6E104
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 18:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSUfTMggwIDtskr0MyfmJls5JCHRPy4cSbfjJoLUtSMifAnKKRyyqMFN48Ep023EZlxUQoZkarQsrbRtxTPfgzQFOKgd+t1KX8PYzQwplPKzhd601JW01mlxWSxs/GDIVZz+9iEiG5PMYDNCqCd2Z/QuOmVSApbulKv1hCCSVziFDhZNb2nYuHOx5oQxHnfbuXrPuH/TJF2HpiXY+jnvoYWLmyubAkOfWY1UOrcbf1oxW4qOK8/5VRhr9V2QtXmowcOLdD7wT5XBGo/ybntvOKT419s3XhK0wjy+hysmm+yfq+WRNm0Rfl8RAwYChMiB5Ad0yJ0wzfS4sfxRUM+UHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTyqONefzlZFqlSEoi8JkxU+lJMWNwIZ7eUpuHi0Q0I=;
 b=MuVu/++NQ6vPfu+SdThi5O2FXJSwOcx2AdCLTMYhsBlhA0J8hTRvW1OZsT8XNUUw+Ry1d71ops9e4Uph6oyS6/SWuUx00ozy/E8wE38aD3Qe7gCZyKWvUjVoTyblIYsXltVgCM0gNSNLHzC8HWu/Kgq46LoXhC05q+lXgMdJQTCSnQUMTDjMlF0lyqSAhhsoa7m2y5DyrEvjl3qojgjKdZVyi88sPs7/LQQKhtqqogNHIEqfd2Gq/tD2no13y3D+UPfl0QtBWNW2LaEtkLKaE5MmU8Is33IAgRF7PO5+jT/CrOCzsYL5e/p0tVkJcSrL5gi3uJlEy4e1966Tmv6LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTyqONefzlZFqlSEoi8JkxU+lJMWNwIZ7eUpuHi0Q0I=;
 b=MlO+v4djryU55SL7VoOPg9OTSB3DwXVTJHPzteTnaqb+3aKL/FuI/Tb9iD0M4p+BZ7/4JpMp76UMGZz8jhuSr2/wtsysw8SLtdTE99nrKsT/EqwKRhSR5cZ/aQvBCkLaCp+sieGUPezRiiO3klSUQp5pHVuRvfIUISfIJSnzW8Y=
Received: from MWHPR13CA0011.namprd13.prod.outlook.com (2603:10b6:300:16::21)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 18:48:17 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::da) by MWHPR13CA0011.outlook.office365.com
 (2603:10b6:300:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.12 via Frontend
 Transport; Thu, 2 Jul 2020 18:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 18:48:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Jul 2020
 13:48:16 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Jul 2020 13:48:15 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amd/display: Add missing reg mask for dcn3
Date: Thu, 2 Jul 2020 14:48:13 -0400
Message-ID: <20200702184813.20695-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(1076003)(316002)(110136005)(54906003)(478600001)(8676002)(47076004)(82740400003)(82310400002)(36756003)(83380400001)(356005)(86362001)(81166007)(186003)(426003)(2616005)(70206006)(336012)(2906002)(26005)(70586007)(4326008)(5660300002)(8936002)(7696005)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27557fb0-447d-40f2-45a1-08d81eb87bf7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37306630012DC15BD50A80D1F96D0@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvajY/gWRNF0UEV2qj3mbcuHpVlGeu6nMdBGqvKkB0rwswJHDCz75Hy21ds2fqo/Evytu0v79zXkcSt5zfDTgnfc79vs6D2HBWHVP9WDe/DkJq7GMnq0p5qaa8E1WDkJ98s16ziZfYciqz+fa2UYTtemgGeevTIp1yfe9hNZNondUWNFTNc6SEydqDYLttuJ4llb/GNw9zVAZhPJRXULwa7Na4rkYCJ7c3/fmx4RA19DENQtr96uPvchI7tEiTddPzetA+zy7XPTNjTiafnjbjjz6eVLEAf11e0re5ZKImyB/pqNIHkw+rDV5btF+3TaKlidh22+0LZYvyNDb1jkuGsrDcpCCr+l/aaSp6HJkVkRrD9lICk6Y7U635bdI0Vx9AuzdKG/49IuFiPyx1oNAGCQtCtzNyxUkpcabEi9GFg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 18:48:17.3464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27557fb0-447d-40f2-45a1-08d81eb87bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This mask is missing for dcn3 so add it from dcn20.

enc2_set_dynamic_metadata() trys to sets this and we get a
generic_reg warning since the mask is not defined.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index 8db6d76a1131..0b1755f1dea8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -248,6 +248,7 @@
 	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_ENABLE, mask_sh),\
 	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE_REFERENCE, mask_sh),\
 	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mask_sh),\
+	SE_SF(DIG0_DIG_FE_CNTL, DOLBY_VISION_EN, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_COMBINE, mask_sh),\
 	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh),\
 	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
