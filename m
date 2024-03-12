Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F97EC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0243A112BF6;
	Tue, 12 Mar 2024 09:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOupOcv+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A092112BF6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvGyBumy7TymCmI84oLNSFrNn93auyP1VNMdEpodVUYH6SB72ppdHVOIAdcPj+q0rfOKZio5dEt4ov4MNLXfZrfPN68Rr0j5DMJV+8/3B823e7wx/MqDRH3i5IDK5oup4WNbfQNNl4K+XqTtP24jzp0GXP03NicTl22oSy9BRO9Wak0sDv1rmhlyD2UbJPq9DyhBr6mN0PZos7uRlYgk74X9w+ClWjyfWHfzLltE3INcfpnejWaMxM4OFjgqI9l3hvcHSjjU4fei5FgnqKAPhvkyErtHBekG89NdMf4+LqaIa/oz1Yq4qNspGzvm0HskI+rdJdwjsrAiIkhCRSjUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UobipCcM+imZRfHB5c/2TqbficlI5SbFgUtNHTHyWwA=;
 b=ayKRk0XDp3yi0bIu6WN/qzl0/lGzLUcvNJclXBpprrAoYgeFPRpS0n7rZeHwFzn7HLMx7QyhbX19oSGyjx39ZiLGzBIwTsds71oikbRuv3yi1TdmtIyJAyG1dSxlZrHpHXApV0HbYXMJXdPuUT9DQwoc/y2Eg4/069pb49EXlHj8g0sQaPJ1apb4sFTn3Ii4+NUCfQX9+LNdJp2vro4U5e4hI238jn/fuHSZP/dfGoV1L1kW1nP1D+w09whjR1xYiH2FajoHZm61J7yP4obM6tH6Op9MsxwmuhEYYH5Ie1FeMNVAlyGlRNFXt4yhFHzrz0L5MSb18TB/cA3IAy7HHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UobipCcM+imZRfHB5c/2TqbficlI5SbFgUtNHTHyWwA=;
 b=OOupOcv+9L4OdQiEDusQIF62yFqrLuybNLDyW25yHkcRgfyFkqKPwKKlZ0Jh+jDaHF1d5Xky33FeTT4nY94McBjEQiBVpFeLWy5Il94UWA5S/xLv0nbuBvArvc9sWK4On6RpFOZF5/V4zQu0lKlVgLNkblVnQKQXRTYUisyvP78=
Received: from CH2PR18CA0057.namprd18.prod.outlook.com (2603:10b6:610:55::37)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:23:08 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::3a) by CH2PR18CA0057.outlook.office365.com
 (2603:10b6:610:55::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:07 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 21/43] drm/amd/display: add stream clock source to DP DTO
 params
Date: Tue, 12 Mar 2024 17:20:14 +0800
Message-ID: <20240312092036.3283319-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cbb8a4-1783-4ada-e4ec-08dc427607a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDPQs6NAQJmEsmbSeNrjvg5FkFEW7tOwSzXHGIA9DqmzQHupWT9qOKN/T/IxKCc/kRsQTTYnIH2Px5IsGR9pdv4pSSLvbdc9VXvqx8SAl6m9db/PLFFHiBBrWiDY2Y9vibgq7ChQmPOwLtikUNEY3HSEpXFRRUn7+RWJ2CfzlaISOvUIePwAAEmiDla5g1aTwiQV8nfOmxc3qu+gIas/cUA7sRG6wsfA/8oJ7XCJtDpeINRdc04+E0b46aCUfugSGJc6rzWHGvuVm29Xa5TcmEqlA33QRlco6jmiRG16ilksehQtfrJRK07M4QmezIKbVmXChp72/dLqOdWi1WPqMThh/b9Xn2xFIrR6EP82fmmfCRDU2lfblU1B8osPnC9JcRd0iYesiYJ6kQjUeGyM8PtChsk5TsTSCFxdaUSCfWELvQFBRTijEQZV9hkdY9dyxtsZSJG0eG9cHyIi9QgUkGe+j60W5Nhjx9q8qvB02c68EIyY5r7lTLGtQ9MokPK/Rr0ugMEfM0FdcXRhg3h4zU9zfoJfgAJoX6KO2YXuy5mkXRtn/w2FH1zz+OzFtLmHGfBroVX5zj2VP60Q98NT169BzR5JV6Ze/uQgwt/vrEuPpDW4LpBrYGPQiGsg44cmlrq+xFbnscy4Tcfax3r19HsMd6CorTEatrxkGBH/TVIzHHjzG8j9RqAd4qZ5nNSxrp5PGZ9XorFmt8UD3VqxIXdUvu7sSSmgltMEK6nz6Le3QygxVC690RxUDjGv0R5p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:08.0742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cbb8a4-1783-4ada-e4ec-08dc427607a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Stream clock source is a required parameter for DP DTO programming.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index b9a06bf84cc9..722eff84ccfd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -59,6 +59,7 @@ enum dentist_dispclk_change_mode {
 struct dp_dto_params {
 	int otg_inst;
 	enum signal_type signal;
+	enum streamclk_source clk_src;
 	uint64_t pixclk_hz;
 	uint64_t refclk_hz;
 };
-- 
2.37.3

