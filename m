Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A9CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1CB2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WT1/eTNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1CB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686976E991;
	Fri, 31 Jul 2020 02:43:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35D16E991
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmI3cGGK6vfCVMpo0/23aQULhWcd/jh4Qn9RM+kOghCGHM9rqf5xDMSvJ0urd6MUVV1nGI6+LO6tK/uuryXGjWMc8wCpfNy+BhN8ky52llbCR8hQm5sMKq4QBUI/0R8oJNjY07NgrucV+AIZR/vt320OrDsmBLHVibRJ7SU3Ds2n8knPubMgnm7zF4GiAGT2iFHfWantXdIT4qV3Of4X/4/GPpL7sMjuUYQpLkNlzc0CP9kMmPAiNFUQ0s9f+XIscArESrSfhUQaeVRIe5dbugzcwQFczaShkGLG+BFlEbB++9xd6Sl1GhhhQaZCgclGF1lRfA99Zr/BMQ90x+1NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT5eGUcnVpfS+MrGOycoa1X+MWLE4dF9vXN6Fm7wzoQ=;
 b=SKUlrTLgGzEeQefaYpeyuN+O87dGUjeb+HoAJmJ4GdglHC041xjG6niNv+okQNY5klO8jyO+qR45/ldc7ql4qfP9o/cJlgDLAWf2HD1jt7ap8TJyK/sxTvzRmp+PclsKutFmP0dYJ5XFtBaSkgrySsX9YdHbEg4Wq2DRpXxYZOVuI4MKK3xJcvU8KflC/9zCYEnuDcZ+Dvxtrtz6QhOBNQM2Fyag4wLP+NoR3zi4XNkpqrQ7/AN/zYob0dK2BRjufZotSlyxrrGSfryBEhTRadRYORSb2HdriMwDPvK0mlSvIAYu3+tmXOT8fXu69L2jyicmNt0vy7ZZIpVE7HkgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT5eGUcnVpfS+MrGOycoa1X+MWLE4dF9vXN6Fm7wzoQ=;
 b=WT1/eTNi0OJ6eqcKrFK92ZtvlQurdi2OoE0onRh2bDfM7pnuxxscW4v9xa2OvYiX+bs6YRdAHeHj6IrGq9SiSqcn9Vt0uPlzwaqUJymkQxWri+wj/YlzcK1ZX0lfhphJsJLK6y8QfeOH+H2ZCqZRdleJLoEHp/8Tc99hxOLPEM4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:43:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:43:39 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/17] drm/amd/powerplay: define an universal data structure
 for gpu metrics (V4)
Date: Fri, 31 Jul 2020 10:43:00 +0800
Message-Id: <20200731024316.28324-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:43:37 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adfe4112-fec5-491c-3f55-08d834fb87de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435248D103025C1D60374D7E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRTN22RH9rFWlN6YAPZ7bmLgXJ1ptEJIM4fKpZxvLy9+1vil76ZP2Eg44/fOT294zpeBA62FYUTwckIaB4r/dEszNJf0QNIQIA6pXFmgQrkkkXeurT+NgrcQceXyopT68nJva3vpA/V2Fjf7eX7MPPFMdqXDjof/nskmB2GAaR1RUASc0JWvuodbxb4gEuy49U1U84Lcu6gKygiqO1Up80riZ6A4ENx306uU5BBZ7khBiYaSC54GpexDEl7iMAqsMTVfpLsIr5rJ30O4SdCswTRDa/vuDs5LnPRyxahqwMW5AExgOQlywU41iH8EIL/1u46OcM6f1r6Wyz02UVQKqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Jn/FRdi3mUt2SkFgW9p4BwYusqV6BSn5u/XE7vJ8scw8I1HYOVLxKQkqmOir81TTXVEOgFfHGRb+L/e3EiR7qUzBmlt6EPUWdgA0ejoQWlQXR+e3wCXkO6L+2BvNf1G4TY7b6uTLK1QskYyAz73OfGzv5/x6bb1yK1ZYzjw5qPmqSVhtjUI509xxpGLdw6NC4zX+5hyyme9BgKR2McCLUzSLSN4YUEMU4mzzse0iEtUwTJQO93IA8BU5Kh9sMRp+eL2zFPI21pJknOx3SkkKslCeJJOX5Zwvx0wd3znN9yoQ538FiqCExvmU2EbBxyrUYrzt+v8xGd15/pnFP2oW8XqaEpTYzJv2nkRUsUH0suHeMJi6+BDDYNwcL+GnnF0EFl8zaqIknA10qaANueCR1b4LDFXGiprK+T021396qDkfTLKa9xRbX91/WXvhCYj6JFR5V4E+817eVat2zEs4RvVatdXoKgvC3K0GH1K5jQS2lGBL3wTTKoLGyJmU4FVqcOi+nXE3lGM28IwJJXIGFm8eXw+Q21dqnWMP+M3A7FnsinsJ8IMg+IJLTNv7tQiiJnEH2H9xT73rjkGjnlTYDjcxpn5kXZPnphUPohM5npqVrQceCmjyWUBQ1C13juXhI5iGWuZic3CAn+ChSQHyLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe4112-fec5-491c-3f55-08d834fb87de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:43:39.5649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qbv8jLZGpQMJEVZApFM4OLNBouH7FeKQRd4OfRzfoIcFC+FyvBeQ+lqYVSCBcV9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thus we can provide an interface for UMD to retrieve gpu metrics data.

V2: better naming and comments
V3: two structures created for dGPU and APU separately
V4: add driver attached timestamp

Change-Id: Ibc2d5c642eff732c082f8447348749a44dc35be3
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a7f92d0b3a90..5f38ee62c103 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -324,4 +324,112 @@ struct amd_pm_funcs {
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 };
 
+struct metrics_table_header {
+	uint16_t			structure_size;
+	uint8_t				format_revision;
+	uint8_t				content_revision;
+};
+
+struct gpu_metrics_v1_0 {
+	struct metrics_table_header	common_header;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Temperature */
+	uint16_t			temperature_edge;
+	uint16_t			temperature_hotspot;
+	uint16_t			temperature_mem;
+	uint16_t			temperature_vrgfx;
+	uint16_t			temperature_vrsoc;
+	uint16_t			temperature_vrmem;
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_umc_activity; // memory controller
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Power/Energy */
+	uint16_t			average_socket_power;
+	uint32_t			energy_accumulator;
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_vclk0_frequency;
+	uint16_t			average_dclk0_frequency;
+	uint16_t			average_vclk1_frequency;
+	uint16_t			average_dclk1_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_vclk0;
+	uint16_t			current_dclk0;
+	uint16_t			current_vclk1;
+	uint16_t			current_dclk1;
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			current_fan_speed;
+
+	/* Link width/speed */
+	uint8_t				pcie_link_width;
+	uint8_t				pcie_link_speed; // in 0.1 GT/s
+};
+
+struct gpu_metrics_v2_0 {
+	struct metrics_table_header	common_header;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Temperature */
+	uint16_t			temperature_gfx; // gfx temperature on APUs
+	uint16_t			temperature_soc; // soc temperature on APUs
+	uint16_t			temperature_core[8]; // CPU core temperature on APUs
+	uint16_t			temperature_l3[2];
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Power/Energy */
+	uint16_t			average_socket_power; // dGPU + APU power on A + A platform
+	uint16_t			average_cpu_power;
+	uint16_t			average_soc_power;
+	uint16_t			average_gfx_power;
+	uint16_t			average_core_power[8]; // CPU core power on APUs
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_fclk_frequency;
+	uint16_t			average_vclk_frequency;
+	uint16_t			average_dclk_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_fclk;
+	uint16_t			current_vclk;
+	uint16_t			current_dclk;
+	uint16_t			current_coreclk[8]; // CPU core clocks
+	uint16_t			current_l3clk[2];
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	uint16_t			padding;
+};
+
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
