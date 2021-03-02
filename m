Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4943C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6590C601FF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6590C601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75656E110;
	Tue,  2 Mar 2021 01:59:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E689E6E110
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 01:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+/KpP6iJoVz2xUUHm7bkuRshhD1N8MFAQc/LQtupmDQexCHtRpRBK6tEB85uAx9IzzyWqWPT31lb/+hrxzjtjopfj8WVDNlvbsMRGg4YSQgw9Tk/atSa0IpcGqiXekzyYkD14insTX6tDqc3BVfp3fdxOY3jISgUyg6YGxBd4d5QfWHBjxItuExl2nBAte4NwrN0UR0iq9Fyep9Z1z7dGyfVEExPk5aYwY4+DCkl9h/CBkO18dFmvglIbcrIUEQg/pbVldCktPOOQCV7tlzDgcp9aKNDC9xN27SYDyYz9grhRaYWODCCnyw0xVKxhmtuy3ojNM4dxljtnrTBuRckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLp+/xhIe8l+d6sYaUWQbAurn87eNlbiDv4frK3Qrnc=;
 b=dICvuxb+dI6bLuXmVfTgds6CBdJO4Vxg279RQGOX1isUojM/m0bjWhlOi6mpUtqPucS9ixabFR7JB9xzHgs6nBCrxw6PeVfjmaQAbit7+aWXpJTsf9r/ggs1cZG0URR1bREhkTE7/ijzErmAbkp+QNR0S0febYp7fipwmMWolDGfyLrM/CGDO/IMHNad3Y7r7myCqfVRtvGCfsupGAAJv6JzotqG697lzj/tLiqSc29FEL0tzfdUinfvFj6CAkJSqcgtgAvWufmHF/KZY8ycEAc3LXlHDNK6/aBG4WF+6gD4B6tQzsnegIbTPphg2E+xGVK7yBCT3MxoeCwe6MXOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLp+/xhIe8l+d6sYaUWQbAurn87eNlbiDv4frK3Qrnc=;
 b=swFJIarPNb56bLxfFdIMrE3CheVLIfjjkGwFlUfVroXT27WAEH0NXqFW2GWjCU+5GUl7EbZ5wzcBjrPKsgCk587uZSFamshWqlABwTR3qR6ezMFSkEhCHb63cE2WQRarI9XItp//E3AG8hQW1v2LpPKrp065HW0IqkzzPcUmCoc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.28; Tue, 2 Mar 2021 01:59:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:59:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures V2
Thread-Topic: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures V2
Thread-Index: AQHXDl7Numkh1ID6aUuLbsC4PHBSOapuq6IAgAFGx0A=
Date: Tue, 2 Mar 2021 01:59:32 +0000
Message-ID: <DM6PR12MB2619049C42A636009B7832E7E4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210301055007.69191-1-evan.quan@amd.com>
 <MN2PR12MB45492F399F58E04453A863C9979A9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45492F399F58E04453A863C9979A9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T01:59:30Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=742c0928-989e-486a-928b-40a8b330a904;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ca52d6-954e-49a7-6cea-08d8dd1ed303
x-ms-traffictypediagnostic: DM5PR12MB1706:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1706F99D8EF5799F04069D2EE4999@DM5PR12MB1706.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAWdiCYsakurbTWN17mv8meJr2/mu3YOhWUfDE24wQv+r0qXISSy8TeHteajGzghcxxAUa1DedaTI+FVKLAs5kFb1XFiNnltiX5SzMtDWfHzZPL2TG6tqV2pPqh9dHaz3+0Tj7hg9hPTuH2PZ+WMsOpAM4Cn+6gfqqyfHzjASSv6cX/0om6FWxFkHMhV0xqoRfLgzdRQsr17BGBHdQxmzmaDu99Or8VN7vJG2ZHR8c78G7xPhNPFVIjOaEDS54c2cRQBgxMl27XgqF4lpJOpMeMVu+IVr9bcV2ISilvneMaxHBPZkDvjufhlmnwXsmng5Lb9Tq3F/nTjO5CCSTgfknIE0Ot5RyDBE5obTgJwTeY/B0/zAAZcbWcdg1rdlffxC38U+Ic4eZF0OKIy+6j2BV1yMK+P2gkR8TX0PilFhMU2uD/TCo4zGOhXmGSEFURSISwcC7iwXtK5qOa9EBJbSV3ml2FzF9hKu5A4T4DLovTt6ftaPscWTm55+Up/vniPwLWITgApb/raQDudLrPEAl2mxAwqUksx1NpU8C9f9NgTgQIgBIM5cdJrquJ0VdSw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(76116006)(5660300002)(53546011)(6506007)(4326008)(55016002)(9686003)(2906002)(478600001)(966005)(316002)(33656002)(66476007)(66446008)(52536014)(66556008)(7696005)(110136005)(64756008)(71200400001)(66946007)(45080400002)(83380400001)(8936002)(26005)(86362001)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OYKImNtT2ZMsbdjlW9WH1GcMCBsiNdILL0A5FoDtvJBvNzT4T4vkoXJ+VLnM?=
 =?us-ascii?Q?5WOJvV324AGyxcFMm7jwLMniTvHTOZSEoKcurEq3fbw7rgfj+BOxQQoMIQSb?=
 =?us-ascii?Q?UdhnlRCbSXPhcEpHCSaWN3LWDxtibyVSAzf5Zf/O45lf+yhdrVd+pH3k3XoQ?=
 =?us-ascii?Q?IkxjDLDVLRywtJNBfIi4o5tWCikDI3HOEm+cErIpXtyQIhBy8cVo1t0NBONL?=
 =?us-ascii?Q?NFaMKcuhrOCTnDuufBo7ksQ8Pl7tgRXMPVNAHs8I0RJtGjwL/7SA0w5gNkWk?=
 =?us-ascii?Q?EdXdzqRlUsnJSuaVC+tk1O8HwEeYZnpRB9/BwvqeE0yXEv90ue79A01oDciX?=
 =?us-ascii?Q?MLWJ8kVVEQOhI1cq6Yk4MpcyKL7RRdyhIaL3bmGl3A4NWQtCtgn032VKdu7h?=
 =?us-ascii?Q?rNS1JVnbCGFV3Fhs7spDz8EUsjWZMmejnnj7yCXPJRsux2JwOlIeuozI1EBY?=
 =?us-ascii?Q?BR+e+62jaR9XgYWKxh5RV5aW/PPBQifGDR76vuixta0o2EUkCVSeMC9OTv9V?=
 =?us-ascii?Q?1cE7TtGhTJzBWxmO+8nsPWGmWvpsfyFn4zJ+n7QdUicUQt91YQ/M1Zbsv21E?=
 =?us-ascii?Q?Og/e/t1tDFc7H67VjwRRh8D9Y1Gqxw+VYb4iI8O9b6RTlyLvjRSiWVvZuMyH?=
 =?us-ascii?Q?3T3NtJ7inFJj5PTjbLt+P5hdBTFcSNzsaIM4PnceXv7xSsToq+iBiN5eCUci?=
 =?us-ascii?Q?vpEPWZXTOjretzxVUL+SJOGo0e70eq02D6NvS5rfEahTH9itg1mTkqvZUZ8B?=
 =?us-ascii?Q?4vmWji6cRW1JYkCvXDXcL3zwSAtIAuyF7ssC5L7W3rdW/jZvUcX1HTI9te4a?=
 =?us-ascii?Q?2/sdvdW5dIMvTUkxS+ghuUn4wWzrhZJRZngp8wCbB9pchajUyqgcPp3U5F1S?=
 =?us-ascii?Q?2RdYqPiTUzhzL/K8Jq51/gMHYwMzenvLL0PCXcTg1abIDK4iviaD2VJDN4Ya?=
 =?us-ascii?Q?/bCHRJkHYGwsoZ/HhdaPWDaWcDU146wa1WjjQrG3V0HPI5UjcSz4UzVUXjsp?=
 =?us-ascii?Q?SgqWqDWxvZr+VaiepTCu8Aof5WGc/jxr25m7wA86pFLlvN/wk5WejhvKvcMq?=
 =?us-ascii?Q?iBZiXXRrnZ2JyjjGe/67kQVnLPveBuc5cYFULu1TEBhD54eDRlnp6yA+76Bu?=
 =?us-ascii?Q?CiaPAK1YKRQvoMAeYSwpXtz7NrelBWfkNL2IcsHxs4ag2AXqJFhFenafdGdK?=
 =?us-ascii?Q?Tx32/owdJPZTI4C5z2qtvDjcjCvboNSJE/mAMsipQJMWefhl9gw2kLdqUrya?=
 =?us-ascii?Q?Z6NxcTuTFI/1ZhZH/NXHNXtlfQHvdJlVSpW3h2ue5rRKQfQnKcw87N+aQFHE?=
 =?us-ascii?Q?soc/kkhVEugm/CPhSJniu+69?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ca52d6-954e-49a7-6cea-08d8dd1ed303
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:59:33.0950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjfmnQb4P91gG2bWC53u3ty4jVzt66E72LwVQ5gJOhr4XPHGMGvdX8PFQQjaCuv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks! Will send out a new patch with these updated.

Regards
Evan
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, March 1, 2021 2:29 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data structures V2

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, March 1, 2021 11:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data structures V2

To make sure they are naturally aligned. Also updating the data type for link_speed/width for future PCIE5 support.

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

<> Energy accumulator is 64-bit in newer FW interface. Once change is made, this will need realignment.

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

<> This padding can be avoided if throttle status is moved up.

Thanks,
Lijo

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cb8068a2b79e64889dc5408d8dc75f3a0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637501746480810976%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QzggLryhGEI%2FtBWhlu0RfsIX3C%2F7rK21F9VJPF0vNt0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
