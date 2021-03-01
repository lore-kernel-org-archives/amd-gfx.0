Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF5C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 06:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C4F61494
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 06:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C4F61494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E236E4EC;
	Mon,  1 Mar 2021 06:29:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D696E4EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 06:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVadQ6AEz2LCMNwlQgFGCggJ5+XARm/fJgxsCem+hS8COD46VB6atKHYdO6E2NcdxYASW6INtZBIqnh14/KJrLjN1E49JeRGobbpA67jm+MElZnQtoYWEgfslAro0lY3Mja2srMnDAkwVI93DA0LsoOPG6i3k1umjxP/+1IaP0ybpnYWhgcnSKO+xfSA3aiUq+E+T2NZZ4qWPJhtW1CshrUZY1k/zr8L5PYt+2NYgjcIdxI+X6ATQ6jU2bULEYPJza6HclZZqjOxGpotNuJ7zk+Wv/ilM3EmKdKjsFFqR1DTxraeB3Ic92jVwoJyLiq2hnbwcXrE48eDCHt808Madg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztZl0gteqS2DrSarDBMhINvDHQ5V+Rx6KshqeIYPy7Y=;
 b=O3FrqQyZHWiIPCTDY2RZPrzYelI/8V+njPtSiXJWFZ6JbC6jtsXVBSuYARJsUqMjZIZ/8Un4APF7kwpzYyOry9E6P8q32UzQ2bqjskPeWRWg+vQjXefQJDk3OFUeeUJCNGsv8jz1cgReq2qKvRiH+GGtDdJYIrrgtyfXRifPTfNu3+w1UPVUf1Xoe1wVGNe3K+mdl0ob8L++kYHEgr83KnDLcSbhzOLoVzwVcFi4SLl7/K8saFKqDWzGLVYR1GZ4b2acgfywKe9zpI5WnUB8EZJVv2ObqkqWamWsUDD4vts8LL32hpy6IKOyC9ypkhRmTdRMZ6qbveiRSiv5jeDUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztZl0gteqS2DrSarDBMhINvDHQ5V+Rx6KshqeIYPy7Y=;
 b=cZvvf1o9I4SdlM1kGMn/pkTZ/EBDumP5kltLQ8PFf/jnt3xnFdUPoJ8vEF1Uq3OJC44o7zsXIQ+Q2RvcXkDvBh06++MsZZzL4ukYydBqoBA3UyTJ4BlR6ZA1kBHsu+L5PTp+CCi5A7zSrjGEO9borkhME/orBRcEi2eccV9G1GU=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 06:29:10 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 06:29:10 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures V2
Thread-Topic: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures V2
Thread-Index: AQHXDl7U9o4q9jc8AEWLP1Jmq8W+sKpuqm4Q
Date: Mon, 1 Mar 2021 06:29:10 +0000
Message-ID: <MN2PR12MB45492F399F58E04453A863C9979A9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210301055007.69191-1-evan.quan@amd.com>
In-Reply-To: <20210301055007.69191-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T06:29:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=742c0928-989e-486a-928b-40a8b330a904;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.218.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 475ca677-2020-4ca8-5eee-08d8dc7b5309
x-ms-traffictypediagnostic: MN2PR12MB4062:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB406244EA87CB285C84E4E42F979A9@MN2PR12MB4062.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JUbJ6x4pViCbM/KMiJTp+KKRv7g41hzbK6eSPQ+6HKGbOsCRGPYLVWqSNS0ZVcT/boRd3K61epvLB66ztV1GaEmMsk4y4phmUATQLVzdLoEoKDFz6T0/C+30EeEOKNM9rDizICx0y9fb3KCKZm8v3pKDZP5RJAdW4P8kbMidHHZEiLs9RHA0QI0NJj2blMyqLoG0S3nH1lve6nzdGorIsWax5JkfSBnn/uNlXJJUEV9n/GWBe5OYD+6Cge9soChfZvonilzRiX7f2cj3jImFYGkFoSddBniFKR5y3hmRsVdAffjU4pgb9rcpwfI7Npj/VXXvzfLCuENgN/t+joAXaa4upgPwOnX+FAExZB/ZkXqLZGfgmpmRvEiyVstftBHf6wL+qDyQpvRpc1+6fwiVO3ycTeGv+rx6YOR2mGesr+6KEHN6WWvU6HM9JrwSZgYeYNFKy+JdeSpXRYgxStBScVh4bCJuRDojOOcURPQFYF4ERWB6JzNl9HITEilAcDF/1xgACXHRiVV90Z4JWZIkgnmwzI536YeIHFLLAIwqLWEEYvm//1Q8b1jptaLPvKd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(53546011)(6506007)(7696005)(316002)(966005)(478600001)(45080400002)(54906003)(110136005)(83380400001)(33656002)(66556008)(52536014)(86362001)(66946007)(66476007)(64756008)(66446008)(55016002)(76116006)(9686003)(8676002)(5660300002)(71200400001)(26005)(8936002)(4326008)(2906002)(186003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AIbs3RXGCeZNvKK6eSl2RX/ZACMG9zNOsTWhs3XTqnobJB/T+3ir6861Bypn?=
 =?us-ascii?Q?rOJ2l2cAD20NzdtB3IO/pBA9CsCUz1jtAO7Bpq0RL2ChtwI9RBNNN26HOvlE?=
 =?us-ascii?Q?7LtOgLP0cKO3seeTgd0tZs3Ua+mTWAyDg/1yogS+zAinPryQ1VLYOWFn21Oz?=
 =?us-ascii?Q?5zxDRuGSm+jL4qezWaZnhh2X3CBDgt6bRVleHVhfqQDLqLwpJD7pXUymON2U?=
 =?us-ascii?Q?wOKyFxqA7TsJd0du/V74CLEu6E7fljkX3p238aCz1B9tzERjhcrnexwOZVCr?=
 =?us-ascii?Q?ieo1BrEv/YfSIqAESAUPBpjnVYnZTKCFxalZkkImizoQB3WGPAUf8YhnBerx?=
 =?us-ascii?Q?sO3qPetdwJpTCgQCK7kqkyI17QQfWHy7+n4Dsmfi32+PSvXutDUaEirxVg9X?=
 =?us-ascii?Q?J0IROv1/DV/36r7Y1eOU+y5wMl3vDCvZyM55nYi3smKxsOhdvsH2a6jbE3F/?=
 =?us-ascii?Q?KVxBHzrVfurgyInYctAbm/91fpidUaSs3sndUtDntvFi1eRXWoSOjUKUvnDt?=
 =?us-ascii?Q?ueOz6xnUc2hgpJ3B1X5fX2N8Awwy7ExwVUIzQuydeLaQqnXodNUJ2WCJKO4k?=
 =?us-ascii?Q?c/J0kMQNEtUFJudoDjfX1W5G31WOyV4prNtSXkZKax/Dc3PxUElL4ezWkx7G?=
 =?us-ascii?Q?jem892GTJomSKmDsqJprkvxRLelae6WZIh3edhfF67zUJ0WDa6dIu8Cvt8up?=
 =?us-ascii?Q?UhhjX01Dip/f+bg3pX9GjI/jr1WQ6Pu3lrHApwt35IbF6IE9vpCeBAnHEac2?=
 =?us-ascii?Q?GZLNVihX/DLE7mhNty4gQMEbP9Tk4mPMrtI2WaLK/gWsWtvJfM6jIfyu4Ak7?=
 =?us-ascii?Q?4EEJtXZcFZWDFbo3IxeGvnBp5ToTf8fBZzS/fHhI4ZZNj4uD6yMqjfILXRXp?=
 =?us-ascii?Q?eXsd4Y1cmPL39LEKCFRUr8M2j7cNk7u9vag141L7vnQ798UbljOwAxvlZCSm?=
 =?us-ascii?Q?0NGxNG2Faiq/ruj2K1dodEjObe4RQeXjFnQTJi9gOstGPDhtKiCpkTJm/eE4?=
 =?us-ascii?Q?I81AmNaOaItuPJlk4whp8pOpeJZkImFxk+S1P3peXNG5j06qPrOSQz0qz9jo?=
 =?us-ascii?Q?yB0gdGai4VE0XbJOa56I9UYVJFRcNwJA7ob86hQsfr8L0RjAmyYPgQ6MJKdp?=
 =?us-ascii?Q?7osbPemH75r9SbFh3G2i7GJRdTI1EkAlIX/Ac3cFW/yKBNvy3LMg/bvTsUYe?=
 =?us-ascii?Q?LcdppSPjIeOoNjYlSAG2wFP1ioNW5BYMUrl4yM7V1oYtHmprlIdnOSc7/TcO?=
 =?us-ascii?Q?o/n5m8B2mJv69y9tg3gJDgznIbtVQmUgI0sLv8XxUG12DcBLFiz74hK2Lt6+?=
 =?us-ascii?Q?JFfIQk9QJEryL+NSH5rZDZnE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475ca677-2020-4ca8-5eee-08d8dc7b5309
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 06:29:10.3722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SJOveKxG+6hHQEPMCgwHUZcfWc48N/yadx+TnWixDL4DNOK0qwUUymQVrFLwSbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
