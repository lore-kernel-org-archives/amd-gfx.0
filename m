Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CEC4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9155B64ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9155B64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134046EB6E;
	Wed, 24 Feb 2021 22:21:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31E26EB5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCynBbEEZJ0ikAsC0B48tvZ7xQtosgOX32UU80rQlNVsYm0/yKme4MU60VRH3PkIw5V2TR1WejMoPkteEefYDwJWdNZ9pQJymNVnkD41F7dgnbsdE6eu/33GeWe8qWNeovWxJ9hQhIKdOSX8IpYbjt1ZOPNCkpzo19ujxc2ie/cr8u4SsWX9ZRkQGJJA27dMNW8kElA4c1RdxNzVfwJRzzDeniMdZFwCUzsghiJTIi+aCL8U7nrpCSr/K4sc/pAsyktjJ35pnPUy3E/U7XkXqNpSsn8eOU1sY6L4ErxDKmK9TrQKp2QycdaBWhrHBD/4I3bkSwy89/XL6rsmgTwyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v84ERnDVTN8avClZibZ4Jx1/jWwNMN4ZYjmThrieXAM=;
 b=nksm6AcbJYJGkeWuq5nu6ckhQmJrQcXvzWDTatUzJ/z/OXmChmk4uqC//t10D8LR1J81+2CF6aH+9LZNNvqDJUlq8664Yx2VXs179dvW7XRSBBaJFrdy7VKgGgGG/latstAf+oxCiFKEh2LR+y/NUjp0pOaV2M+P9a3dptXanNwK+nyplc48Ue0OULKsSqGXpcaWLJDoo7P0cahCDP4SI1lW+3XFanwas1FP+nkHbyrAX84PkiDDF08jIz0NlMdkDv6hfuXov3ONsE1nfvejC6AvhHAYta8QzErCLhkR3ZONh3rRu8V3KtrROSqTP7xYR+y6F5FI1U3PXi9EeYcImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v84ERnDVTN8avClZibZ4Jx1/jWwNMN4ZYjmThrieXAM=;
 b=4j4uHYrz8Oe+v6fyldqFYH1ERunGVuhFbEnnZlzMGP9qBSl/LCcuEqlHBGbM/v9SCtreZrqGYZjltNecoBRojpJhA0CZem2EniCSXupHxz9wxr84hIffhjZz0b5gDtXfoB3iF2zTLA+CeZ7rTcM0MQGim/PI/C65WAAWO+ghSew=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 085/159] drm/amd/pm:add aldebaran support for getting bootup
 values
Date: Wed, 24 Feb 2021 17:17:45 -0500
Message-Id: <20210224221859.3068810-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd70fed6-9953-4487-ce3e-08d8d9125e4f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40461EFFF521396578E211ACF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsSTRS9qXZxEEBD8c41t8nvQTKGG6KH2uDhi44B6R9+2hoP9Sw0SoGcz5ehqvTJH0zh3EaKI9N3sHzM1LbEW8KRzNYeWxSTmdh2AgEjILrrl5f5eHWVG/k8BooWe07tRH1O+HptmVm6jskilLyWrklgaxBLitACKs0kFq/Dcb+LpRdhXiuGm+W8OKEaFOrbxbNQH30MXm1mV85JNhsmmnUlArt3GlO46/fgWgiRTGHv7LXuwjQgqHp3vpJBTj4b/5BK+DV+W04s6SCn7E7RN80utA1AUpaYHc9rkEFDwXrDpT2+EXZovDkefOnP1JaPqEHnv/KIQkgidn7gJHiCrUFLp7w615C+QOHCHFMJxbX9G7DMj3m4O5m5Y/4KcSg+/1ECrTaFdaZ5w8+EgmwFduBqmtctRjgK9elFxST8gPpTbuL9HxXkL2iAqj4rPtson+1kBpv5nEDVmg5XxSrj2Vbn1aodTnnSzNnxwPu08hlYv5uMdqwhmhF6vbdj1/4miTxFeiZ3aG7atKQBE4sPKPdsdQLeQRtr1DBqDw8r8hOg/hzqwlPWdfXPo4igMRl9UPIsY8M+3gAwWGiUZStosWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x63EkFRtDbIkC9UQGz6wlJgrziqXPgnlx5F6EFjWtV18o1f1Im2b0G2PWkaL?=
 =?us-ascii?Q?pW9URle+FJIT+SsgLyLldNQIsUbG+fx9+E1Ufg8ZcgLpMQ5Uh2PlMfe5vWBv?=
 =?us-ascii?Q?ssZW/6toqrqaGiT5JJrvgW2DJwTkjEUbwg5adGYxMKIa9hPkrbgiOX72YdXl?=
 =?us-ascii?Q?hhJKEGampwkOCZd+yydr3minUYE+T3N28Wina8fbEekCMsLRJgJ8wzjF0saC?=
 =?us-ascii?Q?87QIGzmNW/kioMuKkXfDkzUVNQHFced3wirb+UwrzaO6fv3H5nOObzB5PpfP?=
 =?us-ascii?Q?wmpI/EvWDzJxCIcLgQVjFRDkhX4gIvoQoxEIK429Jwt6BuOjSlSZOR0t3qkp?=
 =?us-ascii?Q?P+DDDxWGI/VBWRr3JF9A4Lw6QJQuN0IyQAkgou7qrrxThYiNf4m6rFKbgkpv?=
 =?us-ascii?Q?k1MtaBJsYkx1XHPlPIJXd+hj002crvd8k1fQZ1+t1FAr1L39aQ9kWunJUk0d?=
 =?us-ascii?Q?pZJsWP0NdhFJRTrOaZAaYdnU0sutLATt19nkHvmz/SkWfvcccBXDFFslI4Br?=
 =?us-ascii?Q?EfSUlYLrI6dWR8Fq0friht6upN0dAfj//Z/rotcwNzw1rp3RBzOxFiKQamCS?=
 =?us-ascii?Q?iAEKcjIdQhqLPLPJtlFGfgBMunM5BCZOD+f9j9KIBUxwb2p57hoo+8Dbtcr+?=
 =?us-ascii?Q?CUauCSoH+s3TxO+a25ydGhI7jx/Ifer/dfolpgi4lQxl7o0UP494QyuxhA3+?=
 =?us-ascii?Q?4Apv33CY09ym7KQXEGZJS3sFGOaRYGibp57gk5wAzfXelogcjZh245BwXWJC?=
 =?us-ascii?Q?7YwsglreZBOP3hYfLPGV6TRdpmfMm9JLRDYzK2fcA+67k/mm37/UoqAQt+6t?=
 =?us-ascii?Q?C2gG/SxcGNG4m8JUESCse/SgI5xX4A9caDO1OVUqTZcWy0N/ga9ABjRhSjcn?=
 =?us-ascii?Q?ecMwJR4oY2oB1rIoSDyxVQXPLbO9VBgP6ZzYzTeOWtsQEWTfO0lzGoETZ6xo?=
 =?us-ascii?Q?kuV22KLIjhYmE0i3qQRWxIT0V4qzw27WxUdubccXLztCtI0j6jiF5ai/KyxL?=
 =?us-ascii?Q?WVS/ksxNY7msTrSHoGwM2TsH9Pc+gvpVBPsUdHqVal/izGBdlmpq/ItLEXsv?=
 =?us-ascii?Q?AjEqvX3Bbk32zRQqygTTS7KXYCK8ciHC+f4VGaDhHr/m1h3uaCdJ4rbeCyO7?=
 =?us-ascii?Q?BYf+b97czVWBlm+mNCN5KceOcdtMLZhErB1Gp5O62wB3DquZsVfAhy4UW/JT?=
 =?us-ascii?Q?sKnJKnR6cf0ZY7Ps0ytuAu0e80V/MwHfpA+go8l31NtjHG0dTf9NDH1eioiU?=
 =?us-ascii?Q?AVF7B+f3F9ON+XWGLPikaAtDwBzlYQs4Sh69HZv9dx41wOUsxwUyhf/UNq8e?=
 =?us-ascii?Q?TyGcBisyJxeVP6x4zk4OO8T1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd70fed6-9953-4487-ce3e-08d8d9125e4f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:19.0311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU6w5zBgBRRxGQtWQlxFu7dCMyTrGLsTjb2R1TCPd3rtcvSKkHP5i8QOMHqkR3FqRNPEE+l0445fyGu6cSG+lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

for SMU config.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 15033caeacb7..0db4f1572086 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -461,6 +461,7 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 	uint16_t size;
 	uint8_t frev, crev;
 	struct atom_common_table_header *header;
+	struct atom_firmware_info_v3_4 *v_3_4;
 	struct atom_firmware_info_v3_3 *v_3_3;
 	struct atom_firmware_info_v3_1 *v_3_1;
 
@@ -495,7 +496,6 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.pp_table_id = 0;
 		break;
 	case 3:
-	default:
 		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
 		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
 		smu->smu_table.boot_values.gfxclk = v_3_3->bootup_sclk_in10khz;
@@ -508,6 +508,20 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = v_3_3->pplib_pptable_id;
+	case 4:
+	default:
+		v_3_4 = (struct atom_firmware_info_v3_4 *)header;
+		smu->smu_table.boot_values.revision = v_3_4->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_4->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_4->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_4->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_4->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_4->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_4->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_4->coolingsolution_id;
+		smu->smu_table.boot_values.pp_table_id = v_3_4->pplib_pptable_id;
 	}
 
 	smu->smu_table.boot_values.format_revision = header->format_revision;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
