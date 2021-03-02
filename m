Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D26AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 03:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87D76148E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 03:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87D76148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBF66E0FD;
	Tue,  2 Mar 2021 03:18:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323736E0FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 03:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juGNoC31gXr0Ldn5XD/u0lo/uYa88beU3rZ8TvKlMGkixOhxZY8bDxfOl/hUzBmzKYCsndiPO6Ra94bCbd8q0FJe+DBxdp9QVijcBIYD/7X2QKWoaACpxgctxuQmIgSpSlxK2Zl2AQRjgXLfT36Ct/UF6hszd/g89QVt2Hne2yysi1bG/AvQY3j+BCm0jTYXsZvvaBXCAJc2nTJNjymiixHkmmXtQJS1qcrTIOOl7SMWUZZqp/qXLxuyfSKZ/a18JLKRmiPN8fsHhxoZ711nqcqAQBpTClJBWgWFLJ6IG+seGnxQ2uDdrohQm5iZfMRP8p/CrAsu1jlpZT6/K/eyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3+kNpNSgoE04Q2t6cn4OARHeBhX+VG2hdAA9hgTR9g=;
 b=KHNMu5X9HtgdKfl5HsMoAFxImmS7qkDlRduaZd/MnjFvGC3TvQKiVR4R8why2yvA9TM2qWtIpyBQGfEi2t4m9GJ0NEA3Q6MCAJXodPwJUk3btPMxEbMcfO2+wAQYKQDURFhZPI7Kg7kYI42/yTDKRRovCbM+ZTnlM+PE+O5JkROxGxycnkF9PUKU+vsT+Cpc2J4/EimFarTZu5kJVwvuzQOSpQvGVJpKTdZQrU2N05tVjYO/A8RcclUXvGaEncE433/vygeN5HI24Pw6fCLZ843FYTp42ydR1v48CInBHEmKdvLzfjoJIBg7tv8+lSY/xNpC2pz3VvN+f5iN54TW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3+kNpNSgoE04Q2t6cn4OARHeBhX+VG2hdAA9hgTR9g=;
 b=sgGC6K82td4jFTIHO6eliSjwLOv/3Gdv7MJb7LmXL7cAp5dsVlts1jmy4MqfTOzcNeDeM9q0uiwbksD5kKsauJMXUoPY1bCVKGTkgV1hsTDqpCqEnt3+HkPSdIsTFCJkcP3wSAwWSePwkILefTbr+D86pkLTzkIv6fFWYkPKd2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Tue, 2 Mar 2021 03:18:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 03:18:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data structures V3
Date: Tue,  2 Mar 2021 11:18:15 +0800
Message-Id: <20210302031816.490689-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Tue, 2 Mar 2021 03:18:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8cdf00e-67c7-4cce-9ada-08d8dd29de0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB346724C334996D78E3E46ED9E4999@DM6PR12MB3467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0X4lpsvPBEN7vxFwYQWZWOykSvEyXFDC6OZ4U8QSk7r4l8RvbwZ5fJcpGi40kOfMGtI6KraRQu8FQtUJrNDrZbXWEw2GzfVIGQ7ZxyUiDEzryikqHx7ch6rSNchl8H3xLFI6Z1EMPN+3FVyyaCXZcE+fIyG+b9sg7q4w3rGnfcy++xbbD7OYnrb/+me0LE593jZWyzqyEXtU4b6/KLFydAD2gs6U8LbKJunug52Em/+SA6m4B15DLd3h3GGWEVQjkG2J7vOSyzgf/9Alcy++9qcCyHuX1+YQflA0gpAc6QkXGaz6IC4hONl57gCfiG+FDFbp9c0AiBdq5/HjzP4/dZKgwmaPqK9NpC4HGQ37fyr34HZyhAxpO1kgCSgv54topoPecK8/hnfqnul9r0831N7QynnAPVtAcSSdF5csa8pG49rQ/8cGnCuzm4OP4IAXUFiPqBR49i2q5izV/WBf2/7Ki3G1/+6b2htvrNMFU6bcmBUkZy2Xwx3lEwjKB3u9PqKwDNCgPtLNRzMDNqIkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(8936002)(44832011)(52116002)(4326008)(6916009)(26005)(36756003)(7696005)(6486002)(86362001)(478600001)(83380400001)(2616005)(2906002)(66946007)(6666004)(66476007)(8676002)(66556008)(5660300002)(16526019)(956004)(1076003)(186003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xuYJXw6I2n9sOR0VmL7GzNd5Be2sJGHmY6s874cP84cASgonFo7+Y2t/Twbd?=
 =?us-ascii?Q?J/J5xPpE6sSaziKGvnWBLV9wScy36xlrtd0jn6qyC0u4CV7yYWZIYnApuc/y?=
 =?us-ascii?Q?tpK1i38I7icYBuIzB+hru15UtszhFN36fA1o/DuibmhCb1LnfEdVr7q4xGV5?=
 =?us-ascii?Q?IZ0AkbW/N1CaEK2uWZzC9O+JylOCqhi+iiB9LAwEE0dtAzteDa0JDBpNLue/?=
 =?us-ascii?Q?WLpRAxKozHdJzj5wkQLttwdaPUJA8SezBEWav9FsmNCPyJGSWHJ2DZgJxOxC?=
 =?us-ascii?Q?UGdNXgyMOJCZ2DixtJi7KoQJ+KAJb69E5WQgS7YNzlkEsPgYJfMJDOF1XzSV?=
 =?us-ascii?Q?/Df0dSxISBKGcxTGcTE6ALl8FmkoMPi8wAKxC0M8Ww1Q3sFKRYl9q79wqEwN?=
 =?us-ascii?Q?3nk2nterbQQudzQP9JoVOptjEhAga74pFBKhdrRS60UxthIVQp/DkJd26/IZ?=
 =?us-ascii?Q?3ec3wawD7jK/hgv1knG2V5pi5iZvjeUNMXWZpI64ek/lIxfdGZSAgrtk8h9U?=
 =?us-ascii?Q?lVPGe6960bsVbBZxpEJQKBiQkCvna4iG62a8xiohGvqaNgZ6io3jykiapa1T?=
 =?us-ascii?Q?jO23gPZebbsyiGdBrLOtyt/IFFqQ6FR+j7tO/xz8rTOBVdYOfsUH6TM1zZLW?=
 =?us-ascii?Q?v2KH7XpZHZnO3il7WwfW7z2eF4JOMLeXzCpDY+eIPPhiWqxAr3agHKhUILOr?=
 =?us-ascii?Q?eCwVI9TV4fKPPG/3D3wARTHEFmHOWgSELOuA5/PdARVRDXHgLR0kFdKijwK0?=
 =?us-ascii?Q?MUfBeFG904tJ0Kk2ztgJcGNzOfv35NWcM26k3wrKMbHAj2onNeBtN25chdzz?=
 =?us-ascii?Q?a3x79HtiH2JQ5w3A7wYWRD6HfT5f/JVe8k68ew7sk+tLTABMTlP2ccpEqkYq?=
 =?us-ascii?Q?sIlxmhL6OYHGPRhSzGlfMA5Mlh2JQFYWHR/fTI6uqgo0mwOdyuVu+Npgr50l?=
 =?us-ascii?Q?RpDweDpa19Jzpv+NnhCXs+WlhqtBDjuiobDxta80pc2ghRuPEiFilyFo9cHN?=
 =?us-ascii?Q?UfixOtUzCxa1pzX0vQtBUrvyb5Y5afU34kaI2EE6S6IUwr9gsz7S+grNZrI1?=
 =?us-ascii?Q?q5ozoSWdk6WS1gTAk7jGOpMAjSgSRXrLGYZhmgqFv0Hx4lJvss84w7sc+zbG?=
 =?us-ascii?Q?4xG95ZKCt5ZYzPudf57p1oiYOEYy0kARwf/JEbz6tFRaGeiXJ03guRP4r07Z?=
 =?us-ascii?Q?j+Ko1U4CULRGMqellJkwBdckB5Uyb4Pic2MY7oNvMsBt6iOmnmQSyfjnhejb?=
 =?us-ascii?Q?0Jay8FQmWzVmO8PNWz4CMpaRJe85TYgoNAbi3XRHPwCZNa5tgcxQgrIfmZEG?=
 =?us-ascii?Q?+9bvuFG5sPzUNaq1jCCH5G/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cdf00e-67c7-4cce-9ada-08d8dd29de0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 03:18:36.7183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqoSqNIlKY2QKH1B+xk+lg3TS6f+KmaExTeqt11C9ypOu5aOo+hviIQArIpkPJsr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make sure they are naturally aligned. Also updating the
data type for link_speed/width for future PCIE5 support.

V2: define new structures with minor version bumped
V3: update data type of energy_accumulator as 64bit and
    drop unnecessary padding members

Change-Id: I0a139e1e1f09fe27deffdce1cec6ea4594947625
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 41c89f7d6412..85aa5cb957eb 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -341,6 +341,10 @@ struct metrics_table_header {
 	uint8_t				content_revision;
 };
 
+/*
+ * gpu_metrics_v1_0 is not recommended as it's not naturally aligned.
+ * Use gpu_metrics_v1_1 or later instead.
+ */
 struct gpu_metrics_v1_0 {
 	struct metrics_table_header	common_header;
 
@@ -393,6 +397,64 @@ struct gpu_metrics_v1_0 {
 	uint8_t				pcie_link_speed; // in 0.1 GT/s
 };
 
+struct gpu_metrics_v1_1 {
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
+	uint64_t			energy_accumulator;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
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
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed; // in 0.1 GT/s
+
+	uint16_t			padding;
+};
+
+/*
+ * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
+ * Use gpu_metrics_v2_1 or later instead.
+ */
 struct gpu_metrics_v2_0 {
 	struct metrics_table_header	common_header;
 
@@ -443,4 +505,54 @@ struct gpu_metrics_v2_0 {
 	uint16_t			padding;
 };
 
+struct gpu_metrics_v2_1 {
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
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
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
+	uint16_t			padding[3];
+};
+
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
