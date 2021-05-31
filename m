Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A624C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 04:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6F61057
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 04:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6F61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8326E471;
	Mon, 31 May 2021 04:37:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F69D6E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 04:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baEt+g9ztrG4ajpmNNQ+M5FGdAt6DHGwOKM9i8F91rYC7ZI9R15jyYpROIBBnraR/P5KhMPV34Z8RQA31wSGi19mps8WXYTFUw+VGVQzeWbujyR6EvAznuTbOqSOl7C2TSTd5k2k69lCwSofKLJX5iMvRNmNa/L6pi7gmnrrFR4Wyir2v4s7I6/iJRdsGbXp3hv7SYRF2nxeV1r8zwcSxWqGriKXCOuJRkOyJv9wNHRsyotEQJcD81GMNfAv+3ZkxerlMZeGChMY5wGc7pUa6UEe9aCColqvt4cjvev8wdoI+vhVIYXCBJarRYPRbMFS0QiukZYZ1cCygXZN4r99rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGuCNkmpyV4RCSEPDZZfaNOkFypuP3NSoGCzWrLQ4yc=;
 b=MK7TTZSvGxSM5G0/D7SwG6FYW0LwxfDctc5XOUrJrZXBK9HK0E3Tv49Bxv2qmfYBPNsQQWV48z8iNjt572NwWKS2sDyEFpH5LG1zuJ3Shi6wGwwduUoXvijkvwDBg30kde++ddpi4SmqgLp9kmozQ8R1QrKXtvG2er5Cs2ZEz0DCSwpCX3E6cbC0K4KDbgCIhNiEukAPt2g03pmVYXmAOeBp14aDhMXtWd03KIKoX76jn7dw07iBSa1Gx1uKBTm9cwrRzUAL4ucM95bXF9Um4f54xw5wp4lXbHK/cdYCSBZcrHbRgHQMLrvyB6xwfBVdY+s/kH0HKvxmgbDLy+pyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGuCNkmpyV4RCSEPDZZfaNOkFypuP3NSoGCzWrLQ4yc=;
 b=Rd9oXqq3uUevQCkXXsXIZoBEQrnEuIZ1vogeu034BktnJfxoVRRnLKyg+5ycCqaWLGfImgfQGUnKmagXIdp979n05qKav3J3y79QlGq0N20SF9lhSjv7qQ/IphYRxxRv4Te8oQuJxcSSh9lg0VvpNBD0+LvxfRy7nnCuUTm/s3U=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 04:37:10 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 04:37:10 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/8] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Thread-Topic: [PATCH v2 1/8] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
Thread-Index: AQHXU/w7F6V+POEo/EaiQ5QHlHycrKr8/yrw
Date: Mon, 31 May 2021 04:37:10 +0000
Message-ID: <CH0PR12MB5348F3AB7DBE43CFA3318E4E973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-31T04:37:03Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=00084847-2e5e-41e1-b1f1-673c7cf2f45e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [59.97.59.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c76bfa-ab7d-4d6f-3422-08d923edc12e
x-ms-traffictypediagnostic: CH0PR12MB5386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5386E0E68D0059D5C1FD3742973F9@CH0PR12MB5386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFE9MPIbNr1WwKqV2jPXXtGQ2kOCzNB2LE7a0Q7IHTDb3vHfyU7IEDOFgJklwu/NbSGR52RIgKGcSxBQZO4CYz5cBQaJrGvW8p7EwKqKiVQU72BvwVZk9INrhOVpl3aDYbasT10bIIu0/KEHMeaZaIOrNyYSLUFrFFFBn2pM2DJK4HXbrfRPxquIq3LQAxtemv9lesEP4XSYMay72Ks1IMwCBDn9KOefDUHSESwpq8d8qBXDQXohU+BK3RVYH/q2sh93patyvmtUZQ4m5IsjPz1MzfFt5XyIVtTIkLZOdKIEX4TI/8ntNIdeRqAzGB5cD/5uS3s7kynt7NjU9z49MueUqjiKR8vbAAKr+r5E/czBRqyoJaq3QQCZiX27M74LIVP62og5d+UFNSstNlo+EFNnlWtlZZYlL7VnTGfih6viZAc15KKTtxT5zKMOF/ZAYGw3L3z1KgjeOtIpyIrdAv9sfHOIpgubn7Qo5oSrELvJ234IatGM7X0DtQ1jGMkpnEWNkZRXwXJ6JzGu7U5ENejYkSqnL/KSAYcaaYnOqCazI91tac3swFz4RDCQlEugHW0dhpFnNnqKcTOnAIxZ8fBgPwDT8SYtOXDCgfvZpWMi94X4vbUfdibkGAU6U+q4xcNzx5IHbsX2N+JytvhWOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(26005)(33656002)(83380400001)(55016002)(966005)(71200400001)(478600001)(5660300002)(52536014)(45080400002)(66946007)(76116006)(66556008)(66476007)(64756008)(86362001)(2906002)(7696005)(110136005)(54906003)(122000001)(38100700002)(316002)(8936002)(186003)(9686003)(8676002)(66446008)(4326008)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o8QLgurfooigsGV5i+ksyaoYO4Xxu66MtiWXtrcJoqqFh+JQ86CLKUjkLBUJ?=
 =?us-ascii?Q?AFeK4/uvM8UTo/lqJ4Hcf6YQpTpWjLdf6bkFqFadbHtbAmQONiXF706olLzE?=
 =?us-ascii?Q?yKjPTbBI0ec5b+pBpCX+FI42ZPbO69Pgq1NO2S6ZrQyOzN7Kztdlwx8kapxE?=
 =?us-ascii?Q?Dyfyvb0sSoud+v2S8HQe5HBzVbv6EcFnxRuGOPRYFeto2NzThk1wClZWdBWM?=
 =?us-ascii?Q?VqBSn6Tx6ps9QPnVH1umGuetE0RSeU9DT9LZ/aYW5DQ/tlUqQ2eCj+cgeJyl?=
 =?us-ascii?Q?9GFawH5Vm6azncP+LMtbZ9yAjZQ0z7U3sGBuUDKAtBMdkvK/CCydZEQXJarD?=
 =?us-ascii?Q?t4Letqqj/+IH0o1BGguh2D4kErR2cNfKGf/xD9EqpPknzBNpOQR+6+cf1O9f?=
 =?us-ascii?Q?rTRfJrPHb3YbyOQHZ1Sr7vEwU8h8hQIQ0UKeRY327ZiisBlKv1YD2CFahKV+?=
 =?us-ascii?Q?+75E0iOz4uUOQ2B+OEDmATkGOuK7v+lZKmgWbilsv2hUaUJLSuD7TiOgBA2J?=
 =?us-ascii?Q?csEHFAjJ3v42OslSjfPToIkv4mBhBzynwPMsJQM5BsGEdgqI/iLrGr+leS9I?=
 =?us-ascii?Q?VjpcEbDs+vZUgG+MRYS3q/xICpdiYjTrbOrt4kAjgEuEW6q6H86JRiYpdB+E?=
 =?us-ascii?Q?fnf62BdzFcwPD8w++6NnWQMwxRPfwaZJoMU++ezxPW1EwmFoQJ+gj7Ic0ltQ?=
 =?us-ascii?Q?zTGXYhYX/xuddEm2zewls/mtgav5PP+zjGhDgqvrLa5SAo55jyVehXt6J72Y?=
 =?us-ascii?Q?t4mVRA0p7bVpQ9DB8Jgmk6IpZoMaH7QPhgkTTlTUcf2iLs0R+J7TSPaShvgE?=
 =?us-ascii?Q?x+nKQgbuN4mBV8Bwl5Ir/uc95Ti5VnVHgZeFqG0BrEmydej8YCB/VzMiGVi3?=
 =?us-ascii?Q?bbOi9qDcfp5A5D4iO6y1mYNoSNmztu23J27rHx3m0BaAh9ApGZ69WwPTRqwz?=
 =?us-ascii?Q?GVUge2ieRL157bVE6oNo3dhuvPDhJJdWlkCjgXwqsJoQFynd8kcL7yhw8QkO?=
 =?us-ascii?Q?rUnoin+Mzau6tvJZNflsaDHbNFh+cautzzvO8TFCtw+YDn0ykRxT7ErtZhKo?=
 =?us-ascii?Q?IdCz1S27J4rIcoCnfT5mgEX8yUhd4EctTPJ0QKpZS+7w339OId3ZzTK8m8PJ?=
 =?us-ascii?Q?c8Ekapk2l5k8eRYyn0psV2JDo14+laC3pbnNPF6dE83gR2DEk+E0slkAlla3?=
 =?us-ascii?Q?5AYeEP608gg9KgwwR/nuTeJAuSEDxd3oXYyLRVB7gNa5zioRTou/rPvrzj71?=
 =?us-ascii?Q?jihEDQ280IU/LBa9o+CU8d6Bda+0Z7tkj+oT3v3x9Gi4BeHoDrv6Epcs0OnP?=
 =?us-ascii?Q?2rg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c76bfa-ab7d-4d6f-3422-08d923edc12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 04:37:10.1940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8OIXgqkLsdar09uv6WBA3w5sDtnQRoiakt6pv9XZmd7ihchi0yXo6HQ89s60v0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham Sider
Sent: Saturday, May 29, 2021 1:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: [PATCH v2 1/8] drm/amd/pm: Add u64 throttler status field to gpu_metrics

This patch piggybacks off the gpu_metrics_v1_3 bump and adds a new ASIC independant u64 throttler status field (indep_throttle_status).
Similarly bumps gpu_metrics_v2 version (to v2_2) to add field. The alternative to adding this new field would be to overwrite the original u32 throttle_status (would still require a version bump for gpu_metrics_v2). The benefit to adding a new field is that we can allocate 16 bits to each "type" of throttler information and have more leeway for adding additional throttler bits in the future.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 58 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..b50d6bd0833c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -577,7 +577,7 @@ struct gpu_metrics_v1_3 {
 	uint16_t			current_vclk1;
 	uint16_t			current_dclk1;
 
-	/* Throttle status */
+	/* Throttle status (ASIC dependant) */
 	uint32_t			throttle_status;
 
 	/* Fans */
@@ -602,6 +602,9 @@ struct gpu_metrics_v1_3 {
 	uint16_t			voltage_gfx;
 	uint16_t			voltage_mem;
 
+	/* Throttle status (ASIC independant) */
+	uint64_t			indep_throttle_status;
+

< > Placement of this field here followed by uint16_t padding tells that member alignment is broken. Align the new member to 64-bit boundary.

 	uint16_t			padding1;
 };
 
@@ -709,4 +712,57 @@ struct gpu_metrics_v2_1 {
 	uint16_t			padding[3];
 };
 
+struct gpu_metrics_v2_2 {
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
+	/* Throttle status (ASIC dependant) */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	/* Throttle status (ASIC independant) */
+	uint64_t			indep_throttle_status;

< >  Same alignment issue here as well.

Thanks,
Lijo

+	uint16_t			padding[3];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0ceb7329838c..01645537d9ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -773,6 +773,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(2, 1):
 		structure_size = sizeof(struct gpu_metrics_v2_1);
 		break;
+	case METRICS_VERSION(2, 2):
+		structure_size = sizeof(struct gpu_metrics_v2_2);
+		break;
 	default:
 		return;
 	}
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C7ca262503fb54995e4d808d922135cd7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637578288831073471%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2B9FPgt9%2FPLNL0N4lvGQMnWny5ER5UnNwdysYGqL%2FzAc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
