Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C2C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32C160234
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32C160234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1BA6E4DE;
	Mon,  1 Mar 2021 05:50:40 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D45E6E4DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 05:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrT73h+aUPkm8yuGGxIWO5vx4TTPrSiRvId5H45pVrDo0+lyzadF35r7XDWLiMRYkQWkeahIBKdr6cW0EuI65B7xdLmXdSNCCsx8AsUo7gB7uA6ZCH4bh2wwUHpnDvOCNR5o54hVoAIQW5cmBdr2Opb8XREivzMGehsqccBR9gboAB7M59xW2eJFuJCnaCitdoMFbYJLZLvjgg30Jv7H5Slt1SCMUoVD3gpGCm0ls2kl7XmqiNO4Dj6zYRzDxTmMkjwtzJewSidUz2pHfV64FnVcXd+nfWBOyfO4yzLx8lPuzNac0AqsAu16ltzRCjudnj4oVI+6LCUpCcTRzXjmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOwsD7qtqTQN/cVeAvX/R9LNAn0OAjbzm6TC8APtDi0=;
 b=da7y/wm2bJwy3c8jIdOmCl+I/zH9f8F2lLV0I+fljoxTUPVvPccTjxNNfjfh1T/fZs4Qb/EsnMObsOY1bs2eu2FxFkuXi3KJjphom+qrq7z81BeVcm9gwRkAcxJUmF4uVdECpsd4M14kmZky4jTSuJTYArR8TzadWMmw2BIOvjP4OYzXYplmSHIzZg/JgNRr+GU+KO6v/RLdByRdRd0qkP0oxTL25npJfGQf0O2VOLtNd7t63DdJ5vn9linb+8hludS4qISZQRk5MX4+wyWK+AoD4Xaw82sQ0UqqaksKkNELICHucZMENi279KYwE4sJC2mtYH0e2eoLTjzr21gKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOwsD7qtqTQN/cVeAvX/R9LNAn0OAjbzm6TC8APtDi0=;
 b=xuXB3GPGvd2odY/I3gga7/kHF1BJ/r3fpSQnOW5sLOjLEI/iS+q9gybtIamVc2DUqzUkNegY2pi/zDD99LGTlhokVWRLSs6rH5HYEvcN5Cs2aMYAc1F1Oz8wIp6WlVujuqXdkvX4SzdVTElJmKmDMB6IxINHB4RTYtNYtlcwJV0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1161.namprd12.prod.outlook.com (2603:10b6:3:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Mon, 1 Mar 2021 05:50:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 1 Mar 2021
 05:50:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data structures V2
Date: Mon,  1 Mar 2021 13:50:06 +0800
Message-Id: <20210301055007.69191-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 05:50:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfc6f81f-708a-4891-0da5-08d8dc75ef62
X-MS-TrafficTypeDiagnostic: DM5PR12MB1161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11617525961B5E302E9939D6E49A9@DM5PR12MB1161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TkkvLpLhlXuVFg6XjOQHoG6LAKbcz1sv/WdWHOKNndIatDoe2WFf8Ecf2BrSUwMNNAjME/j4MMC/VDWuaFOhZ2yCTNi+WgQmfIQyh2pV1cPff5qXHclaL+a4iN6ZCNYcLVHaePmOF8pThB1ohO51VoRFG3f04ZoyXpyo79O8KHoOoVa189bUrrQylPyEXJhPlP9cYjeE7C2MLOsYlfo3nNVjLjWg4jCRfdtTG/ZuH/RvjYRH/GXcny/UBaPqmpHvyBQknmcwQLFtYmp2fc2dUk+RJDGct/ZzHDDv03moFuAVnuZobVBi6pCmBcdjlYKMo58KU8vHg1lg63okTSle38HGiSAdkYDDYhMMXT01/ry4ksGvEp1EMzLDes5OH9XLsyrm0FaQacdY/+ApxJiYqQzTRO/o5C/0hub3a/hSfw6dfSnhEQmz9U/RqxWAZcdB+xel9dEZCAvK9qAqlB94cuUSilmVLVH4L8hptt1j8zWNgJTEQ6sMalTAoYCuIEZBUul1Frjr2x7Y0HmtqHyRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(66556008)(956004)(66946007)(478600001)(66476007)(6486002)(316002)(83380400001)(86362001)(36756003)(5660300002)(4326008)(6666004)(7696005)(16526019)(2616005)(52116002)(6916009)(2906002)(44832011)(1076003)(186003)(8676002)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iz0M0E3mP4N1m0zwVG4BEQD5B4sJpNpCSU9qHmBF9bwTyYtUrn9n6T3/iw25?=
 =?us-ascii?Q?GG0wfFIW9gtdwfQeYjlb2cH/QAJcM1vt0xnqbUkhZ4GapxxW1hg9UDz+bQxF?=
 =?us-ascii?Q?74fUn0En/9jq/TQ9/d5xGzYof6+FcFSdpX15QosfZnRx1izBTU8x0ZfSROMd?=
 =?us-ascii?Q?N9M/3Hc0+MdgKFPyB5fR8vKatMwK/+bsFdphrcAXhpvz4UYjJR56aLIQxNIq?=
 =?us-ascii?Q?RYQsxVo7siormFnfFcGmZfij5I6a5hN7xkC3dYR8ABEYw9DKIg1NSj1+1fA8?=
 =?us-ascii?Q?89oCk2jOeUvzeBkRiaJi4lDWP3ZYON42Hnj685tOHvPb+oJvHhUtymGW9aR9?=
 =?us-ascii?Q?60fTJ5y2Bz+edsAYepIL298a2PSu6XdIQsH64YDzLP11JecPevRjKB6fIK/w?=
 =?us-ascii?Q?BNtHu9l69aVMlqhWKXJleMFvIwEbg6vwCsuLpWBHC1nedfo1clEgUO7Gl3h6?=
 =?us-ascii?Q?J7Yoj//mhvuVwCRgfj7clY0IVRtZEYidU8laAmYdAlE1Tq4iVoS4UBtPyZUy?=
 =?us-ascii?Q?zcNrN4vZVajxa2j7Sa5rY4/pB2Qaegh6O732UE3G1RcM09xCT6HZlvvub10l?=
 =?us-ascii?Q?52yTEFoRXcosZs0TI/+Xpczia3utY2mzY4Wm4wxz8+qcgELVcnLPxMp3Iv2Y?=
 =?us-ascii?Q?OPhg8bPXK7hJOrD8leJOQRk3Vu3C5uKrjAFzj1szKLhGt1juy3RqZywxZ8QY?=
 =?us-ascii?Q?lYl+iwZ2mb3UJiIRnPyrhGLHrPFeLas7cGEGnuPVSe9uGbDj5nSLs7a/qoeN?=
 =?us-ascii?Q?/6v+SMlpVgWGXrnArW9dUBj1BB4oATOW0CTKV+JtEY2e8FUr5kUI6mB8A/4g?=
 =?us-ascii?Q?bvjy8LT9KIv8OL+1bronY4iPJuoSSwUjARhlCvP2V6iQ9fgVAvfg8UInLyl3?=
 =?us-ascii?Q?0/DwUqrJgyRiOvtlQcV622pycj3VP0IGLkCbw0Xr8LIXEzV2RbiuNxN/pucw?=
 =?us-ascii?Q?Ot+o9AFhJbapBtHGvLcc4ZsZ06gC67SyT+z4PIaJvAjwfeINwjlMYo158sFK?=
 =?us-ascii?Q?MJgb6b7qM86J7yL4bmozoOMDCP7hJdp3NpS2pZsfMl0Mz+NCgtcpbvKTEd+3?=
 =?us-ascii?Q?ArirRbV+UdY2Bv8rw7+ItTaBwOw8V6Oj42/1Z1p/cVfDjHHMbNav/qw0ELcy?=
 =?us-ascii?Q?yu9il+NoKHuvItGxBzH6MEYLBBRPU6KbTcp+W3IvLFVJ6+HKLe6IWvqCKHfb?=
 =?us-ascii?Q?jPy+iRfrERCIX9q2cgypFb6PFqDlqdvvhWkfTx3IfsWp9TcFGz3/rybdnjGN?=
 =?us-ascii?Q?mmY+w8EwUixHVxuwJtg925vqJ4j6nIZ4/dV7pgsxA4u2rnvNn373cIxPUoly?=
 =?us-ascii?Q?CsR7/nhi7v4ysSPJfiadSU3c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc6f81f-708a-4891-0da5-08d8dc75ef62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 05:50:36.1228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEwJb57deTAxJD4Oqyv5ksXCMpUe8xw0ma4p8jFmtOBZxRmAkbL4lmYqfye1Z4oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1161
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make sure they are naturally aligned. Also updating the
data type for link_speed/width for future PCIE5 support.

Change-Id: I0a139e1e1f09fe27deffdce1cec6ea4594947625
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 41c89f7d6412..dbb066a39fdc 100644
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
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
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
+	uint16_t			padding[3];
+};
+
+/*
+ * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
+ * Use gpu_metrics_v2_1 or later instead.
+ */
 struct gpu_metrics_v2_0 {
 	struct metrics_table_header	common_header;
 
@@ -443,4 +505,56 @@ struct gpu_metrics_v2_0 {
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
+	uint16_t			padding[2];
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	uint16_t			padding_1;
+};
+
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
