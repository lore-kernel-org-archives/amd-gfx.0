Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D85C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 17:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FF610E0E6;
	Fri, 29 Jul 2022 17:42:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7674210E0E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 17:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuIwADiV2qlJsTL/eRmOPMa0+b9a6sZVNY8WmUaNsV0vcNaenACmRr48eUgtPFcXctlyanAOpFZ4pW6XFtvImB3FtKh4h/kL50SYjEyhjJWj4sOkVHWe6ZrAzD30PRKMe8EW8/9hnL4McW5StFK56yPRUozlEekHbQu0+1qtxqTco5w3eub2zFidsthsAAwj1aeTtqcB8r4+/RtU8kS2LIJ3Yb3xY1OhGHt+hfqI8tk9E2ZcoN3aEdwyMvazqcBx9jIff63pWXT/qFQqr6+48d1cr0vYZIZS8zxKkyc+WgljLgSGYSLrJFhXSyhU2zfESlsaXgPgaV8VCkhbmg+UMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Dj8SV6J+bs/4uX5+cYyvSwc3NhMxZkx35PC4uI7ec=;
 b=RbNLkQML1gjH8DdlerqE/wKi9kaWIcmCo+/Z/d7pyoXugJQ+BNcuKsIJFPMinIivUrC7Dpe2ZYFj7+uUCAIWgetGzsi4rDVeDtX+CLiMvGi1mFJFYq/DoGBWcnMKVYyUB3zJKGtle2Iyb4qtjVxVsONIOjjIsG3kmUp5QKs9X88awDaf36lUMUGlgLNQckJthnJb3nnylcuycyvIILgB8NJWmZVIj2I+0a871rxw9AoZMQ7/b7E1f0fg7wmOWSfHrqkJnkvPpGa5rzTMVhiwZ7Y5AkQrCZvfwo+ut3GVfgy6lNs+wxBdj/WK3rjAvERmykIV2/jI1EJOmKj+QAEZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Dj8SV6J+bs/4uX5+cYyvSwc3NhMxZkx35PC4uI7ec=;
 b=z81NR4+BUnRDmuRFXNbJfB+lkyYzeWm7Is3VWRrgwmYsBdf/tm1sK5ieG8B1HTw+JhqcwWa0eaeCJA2jSLmHXrop5Sm78SU9iXScCw/5S7xAxItFdikk3MbEvhOKNxf6kA47Uzx4GqDKFbK8HgEeDUXplCJBAjhxvRdTq9G+/Wc=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Fri, 29 Jul 2022 17:41:59 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f5) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Fri, 29 Jul 2022 17:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 17:41:58 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 12:41:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 10:41:57 -0700
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 29 Jul 2022 12:41:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add a missing register field for HPO DP
 stream encoder
Date: Fri, 29 Jul 2022 13:41:56 -0400
Message-ID: <20220729174156.346685-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc40ae5-914c-4aee-cc8c-08da7189a2ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB4303:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IAhUkpzFCD2bhGcK/pUWeegtwLMAsKp3xkHrfoaIv6EbtGMN0+hBld3UWWs2oq4lQoIoFitSU4hgMS3pjxUXE7xvnavYUIQk3e2/9GIpEud8oKjVDkXrdyNpPujqKzTqGPFUhGGGkToUcxT5B7pvxTv9lfQrO3Raxm/d6OUwWLCisMLICWZN2agoIniN9OfdfoQGZOrNtgHx/If3KWUggWjh2BIEdwIcsKq/0v1PS/csfoLuHP73FU8FqzT3bzyULJz07PUTcYdPEJ+mHxMmYoirkWPQkiQN+fsiufFJ21n+PSxW7uMXMkfhmYWTebQBfRXnE0wJRSa5Hl3nyCVxI8CFip1AOf5MqJP7u1DSJhowtwn1eyeh343YrXsgydaWpM40TxIvkW3TGgK+1/6SuvQ6XHAtq1k7xrAjTRDSr7UGjklxfJm9d+W27DDDVElkJUO7oWRspPlNw6X7X6XE2AxPrJbiY6InpMoyfo0hELyK3FeOBLh0+x7VLT3IcB6bmpmnSqNVwLbhj9HvonDD9lZqbHQR6ovPlAGHB7u+oEUa/YhhXLPQHH8ilYwyJy4IWCXk+EB0qhiQryPWXAYlb1XC1kUssGMsrSNc/AtM1T2CYa9y6lCXsKhBjsFgGskJeIT5RIAbokxXjdhDIqvTe8b5+z4ttCB+uTWM2MZICmQF0qspVe1WHM++MBrTb9tIrqnKKz5DiQU4BkqwG+NAO87va8esj6NEECyLk/ZXyZRaTjHm+KHZmImL2W9Q5NziSiFS+3ptjq/zeSPAjlBcZtfO5xX1bdZRw/hUIokQAzNx/g8IBf/ddYXxfvnAEv8Ln+I0vJceRBPPSmtmAK3aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(41300700001)(478600001)(7696005)(26005)(40480700001)(336012)(83380400001)(426003)(1076003)(82310400005)(2616005)(186003)(40460700003)(44832011)(8676002)(36756003)(4326008)(5660300002)(70206006)(70586007)(86362001)(8936002)(81166007)(82740400003)(356005)(54906003)(316002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 17:41:58.1172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc40ae5-914c-4aee-cc8c-08da7189a2ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: alexdeucher@gmail.com, aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Add the missing definition to set the register field
HBLANK_MINIMUM_SYMBOL_WIDTH

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
index 7c77c71591a0..82c3b3ac1f0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
@@ -162,7 +162,8 @@
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AIP_ENABLE, mask_sh),\
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ACM_ENABLE, mask_sh),\
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh)
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh)
 
 
 #define DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(type) \
-- 
2.37.1

