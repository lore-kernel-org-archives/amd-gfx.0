Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA222C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E6A22B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zA9Amz95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6A22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB266E84B;
	Thu, 30 Jul 2020 03:29:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410B86E84B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDNQl54itXpyZLq3Mi5zRIMrRLV+OkzuTJqf4y05QM3a6oxH//zUAWhwMS4h19/GiZnRaEzdGWndzJ+/oGB35AE/t/2CqXJ5dylwj/CqYl+QWjCuru51psufvqAm0Er3fczZwKd9xTDh50dqMcHUgsKDJRz11+W8lCCotWknoCaKtfylkRr8vhMaC4cRmh5HfV+FlbwtrhF4CHQnJ3CbezN7lFY+7jcJ+B0EF60OeMtiUeM1B/CtvfN3iZbAp0uP9oqRXqgkfs+D9TK871+EaIGeSsz0L/gaf9gALbv2fzuQkf5RSSLQspdgQWO8AyVfHWrwtENQBTbLaTwAp5rRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaswfrwAP3j36u/PTRu6q/l0n7QTIw2/5bTDOy9UCy0=;
 b=odSMgMzHEmxwJRnfXM9YGoIZ2++tk5f/7A4TerBvJMTv1450zB8+q21XISu0VedOEZVPDJKkz1vvW32oC2jst4GHJCehuCKUxIRypAULtq41Nk2h27+gLC88t+WC5ryS8K098o1pgWeSIK153EqrYDZQOB5buA6IVSdK2sBQ0siDRa9NIEuJIbIVHzhW3Z3OXkXYAHRWRSP9inyMUQDcFYsyEgX5WsSS5R8H1Sv9lakne3fws4ppoHKq4Dm1apeQJJwG+AdefKEYFmi38PoZ5ntTV0zWU9Gk06Gwu9tjNxrpEC1fX3efNGNYW9y+cfwRK5nI5C4GzLkJ26MZmg9xTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaswfrwAP3j36u/PTRu6q/l0n7QTIw2/5bTDOy9UCy0=;
 b=zA9Amz95BM5IKWrS5TwgerG/jzF5QNJiNEgkGAiZKH/jfc3bFRiYhACD+mcem7YxxUXPF6vct1w6Rwj05XJHboxzHgS3ZEXvo4qPpL4lCya1UHeLC4QaJX92rEoKfzPL2NAMsMlqs2ValHGCyez9z6rG3cGoyhYeB/ke69dj/5k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:29:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:29:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amd/powerplay: define an universal data structure for
 gpu metrics (V3)
Date: Thu, 30 Jul 2020 11:28:32 +0800
Message-Id: <20200730032839.2517-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:29:04 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12f7fc71-8df7-4736-9d50-08d83438b66a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13553979638495A5F268D943E4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDSrIAkeFftmmMKcxl+BpqvJdR8XALNyqg6Sk4lYmLv5vNyIHASvYF+CRP0Mfol+M/uLjwyzIQZku0WIb1P+i7L6HRtac90IS0gg3L9bSxbWf0F/aTOHeam+7To9GbQw6XmCySWaGuhMqo8e7nM4KtseEHy+QQE5FxkQJw+bLVuNnJXnlc9VQ32mf+ENM3YT8Eq2sJ3mPE/30U8jUQZ2yPoxvG/wZZLIryIHWG+IgEAL2LzRA869HW/gdmei72dO6IqKIryA7eZdmsH85HuumzH51Mi1ukwjonk+oTImql9oonNcppz4CudGPxNHljW/58zlgm6pKi/cmGp12D17KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8QrltwT7HhfoHawYlYqKexLYJ+yIVFiQaxMEfctiomWF7xfQiwuhNAljvVHi8gKMrC41UDQwbR5G7fFo9Ph98GcBAgs5aTtCMhjVs4qlpiZJFnUby8nxU/uA7rANEYiNgHwwvrSOdIgGBvdKaJVIaHfJ3DwwP1y+9arR8cLMFdvNsJBYQiISzrKnrlvTZhH++jGoHQ6SfUux//ly72+tWo1Yv9hPSIOzVaK1NqrSypKgISe6g1hNWaCdpo6EF3MeksI5XJDG1063NS2aRZO6Wr52NkxzHVuQyI59jO5XHqaiaWw4L9Tjv96TGHguWVrH9YNoa5OVfDifEI48O+AyvG/gwpZHAzOIltGAsPGR9FgWGTz/cHVrhmQdthCWBk+8hBXMHcbdFD31ypLb0g42RqML/u6V8dkd4qAWYm77t9NY8Lorx3iOn73N4/ORS8N1IWG4xuXJ7rtG8Tpnp5lnsbfOsOxjXR6K/2fntB1AwDM6ced/a91BsWc8FMim5FbmzRzKJ91ovJeaq5RIT/vZjOMEtENqtiyc4ZLtjbkRPKW89xWyqDxdy0IY9QEFJBzWL6qpddrmLuwHuzG69DYY4g93Me0/H3kNIw9H0cf4LY7mGV+QDKpOdCS9tBbCCTXf5FQqCBYdcQj5KYq62+6miw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f7fc71-8df7-4736-9d50-08d83438b66a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:29:05.9526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhyNFCN7jwHucWtUARwGzgBhtj8UiW9nAQBM6OUd9TmMdlnvECE/7geLqeKR5yEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thus we can provide an interface for UMD to retrieve gpu metrics data.

V2: better naming and comments
V3: two structures created for dGPU and APU separately

Change-Id: Ibc2d5c642eff732c082f8447348749a44dc35be3
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a7f92d0b3a90..5122f8e5436a 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -324,4 +324,106 @@ struct amd_pm_funcs {
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
