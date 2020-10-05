Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E2C4727D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 16:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0134D20756
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 16:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FgHIdlXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0134D20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8F589FC9;
	Mon,  5 Oct 2020 16:28:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A0289FC9
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 16:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwmV2wLMAB7SimKGux13hmnhhnabsd/yl1ArDtcypYWgNC/+kBiE6PuhPd1ftEkT8yrGBcboTnHMT8SIkbeL/12e1dsMLa0lRgLux0GgLjGDIZrWryy1vkrR8NBhXyz8+vWD1/6GI3/Tx/N0W0lYV58gnRGpcm+Q+d8GibgfH683piztiR6fGeTDI8TQKYZDHn+PjamBzBevaDjxwaZj9n0HB9ooTeoUyXKevwtSIIyLBJ6l7r6vCNsa80EEvOVH7Fi8jJpwwnWz205oYctwpKnhRRWXq/m/zLbkX39MS/YO02i+qy9OIpVMm7CzXSzhPFtQ1J9kF1RJTbckBUEMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjB1meaexJKQxgQ6B8PzkJauxY3fp3GxQSqzNXZ72Uk=;
 b=LzibUkOza/H0NfsSFZ2SMEKncvT3rR11Khh4bQe8cb49IzZuM0ktaMCn4xtVP6Yam+ac3EwF0cBxyA4XxoCKZHwByQ7WYnvZlvyJJ+OiWrCgNr4sjV65G9FeXiPUZ4NtmyiBC4uhOaON/LLLwXQPK3OjEExoB85CtuSGNZ8rLWeAYb47zQWfOyL/Do5FKYX2ViTiUF/CUv/oXTPaeJtlMLUiku/e+KpScHfrjH/4EFfLzRs5bhLv85+XFjQRq09INJXaCkl7iHHXPxNsXiRuRXZw6ySrwFno0lpXI8Db5brbSN4eavQXR0nzRP3BH7JD4D2QCMPwts7JAhUOiq+HmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjB1meaexJKQxgQ6B8PzkJauxY3fp3GxQSqzNXZ72Uk=;
 b=FgHIdlXj75BOzyRVtI0FfJY8+YwGeEHEMZpYu/KfJIiHfTS15Yg5ZOs8cm+8AAwAC2qKc3lhIc6ZzDqFWXLGup1+2obkPPLzG9AHqeC4idShjFm41tMQpsXYO2NKUum8iL8tXu2pVmLEuBjMhYgRZ3RXCDSMNxjDQuQSluV0jME=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34; Mon, 5 Oct 2020 16:28:29 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 16:28:29 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Topic: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Index: AQHWmPlYKNGdfSi7WECemr6EWHwj2KmJNwLA
Date: Mon, 5 Oct 2020 16:28:29 +0000
Message-ID: <DM6PR12MB2761EB6BA8F5F47BEBD82B3B8C0C0@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20201002201913.126122-1-jonathan.kim@amd.com>
 <20201002201913.126122-3-jonathan.kim@amd.com>
In-Reply-To: <20201002201913.126122-3-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-05T16:28:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=99cbec03-d5d1-469a-9d0c-2556e6c538f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c72ad299-1d6e-41c8-f61f-08d8694bb1b3
x-ms-traffictypediagnostic: DM6PR12MB3385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33859528FD7C15240E4F19018C0C0@DM6PR12MB3385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQRJirzYICH+J8TnG8bIXELUX3Zx7VnViabmbygK2oOaMSJBS+JPY0/ghF6KoT3B0u+WAbdDUWpYB+mEOCqjqEplcQk64Ohj+J/F83XLJ6jEQEEf+etqcPCCxTIUOkHcwYcgJWB1rHQU0o3CA3nV9EI2ZBlr69hx4SkRcWtBJarIGRwM0QATDIsdMHvfkSvllcHSL/Eym+3inL7Df9eRHc/gn/aAHBvSYWsD0AL5WcOfXZYFvqLti7O4O1gI0HNGm/vE56+RO6lW/WmaAY38+P/TynIDhmPi/YUzNlrnQGtpNwrc4zMr0Gdp+/3WhHMs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(86362001)(66446008)(64756008)(53546011)(66556008)(6506007)(186003)(66946007)(66476007)(52536014)(8676002)(8936002)(9686003)(7696005)(478600001)(2906002)(316002)(110136005)(71200400001)(5660300002)(33656002)(55016002)(76116006)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JJ7y1cXtxIyPltx570/DoOTfKACJC6cg7KHFlC664d0+9hkoLvCykJQbucMFR1aRuykVAVUMbJo4JxXAWH46hAidLI9NNwkV8Ngp9DaFqluYKC5LOKdJgEdvlC2pp+5a1ByybJzxElc9pAh+DX4fIbf5R4wojeCRu6bZ0n4EBKn+cLB6uFQbc2swDD1fQZEuD+XBxzxvSy+kSqFB4ARSHT3OSIxJTRXObSNPjkWFLHsPFo6eH0DfWuZezhJQCt4mppEtrWrB2juBo5fZSKjLiAf1VJaTV3Kz7sXgvssqwU8VoOTXKNMFpWJsZ2SLsSbTVMUrba2uCL0zm6fXz+iDcXhwbnttyE/wczvGes3vShtVJNAqcqLiGqGOmVRDH8vpf25PLB7uG4jRhuGusmMClpBzVtpcqVyEDJGoEfc44JXgnf+ilO3KU5LiZoWKALvfHn8oS+FuWzN/2sh5MduVp3k/5ftkXdd5fQ2oVbWcd8VGeRZi8je9SmW3UwW4AD6/GHUb5cwdEhv5HPJ4AJlfRX1779Tui6/E34jw1tJ6UxVm/brRwrVfch+Sv/nr/aBmVNGFGGdC0xGpLlnnKotVwCw4D2MwVDXSzq8Aqzbf9Uma2htvqptUGoEgkmMZg7TOcDugynN+8PzptePTAi3Pov0NmZHKDX3YpC3yjtDy0R08QK+/CeRGOGq7XfQ+kRtTfy4j5DbNj6l/J6adKp0O0g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72ad299-1d6e-41c8-f61f-08d8694bb1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 16:28:29.6230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zItCzydic0lPHgmfqbwVHiBCfSaUWI/UWwFf5xE4YD36cyAUxTvol3pFTyjWmiYiIbWNT5YwwiWtq5tg41j6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3385
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch series Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com> 
Sent: Friday, October 2, 2020 4:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

v4: Align with patch 2 with struct improvements
v3: Align with patch 2 streamlining perf types versus event config types.
v2: Resend for re-review with alignment for v3 in patch 2.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 20c500f61b40..d29226f7b6ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -35,6 +35,9 @@
 #define NUM_EVENT_TYPES_VEGA20		1
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		NUM_EVENTS_VEGA20_XGMI
+#define NUM_EVENT_TYPES_ARCTURUS	1
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		NUM_EVENTS_ARCTURUS_XGMI
 
 struct amdgpu_pmu_event_attribute {
 	struct device_attribute attr;
@@ -174,6 +177,36 @@ static struct amdgpu_pmu_config df_vega20_config = {
 	.num_types = 0
 };
 
+/* Arcturus events */
+static struct amdgpu_pmu_attr arcturus_events[NUM_EVENTS_ARCTURUS_MAX] = {
+	{ .name = "xgmi_link0_data_outbound",
+			.config = "event=0x7,instance=0x4b,umask=0x2" },
+	{ .name = "xgmi_link1_data_outbound",
+			.config = "event=0x7,instance=0x4c,umask=0x2" },
+	{ .name = "xgmi_link2_data_outbound",
+			.config = "event=0x7,instance=0x4d,umask=0x2" },
+	{ .name = "xgmi_link3_data_outbound",
+			.config = "event=0x7,instance=0x4e,umask=0x2" },
+	{ .name = "xgmi_link4_data_outbound",
+			.config = "event=0x7,instance=0x4f,umask=0x2" },
+	{ .name = "xgmi_link5_data_outbound",
+			.config = "event=0x7,instance=0x50,umask=0x2" } };
+
+static struct amdgpu_pmu_type arcturus_types[NUM_EVENT_TYPES_ARCTURUS] = {
+	{ .type = AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI,
+				.num_of_type = NUM_EVENTS_ARCTURUS_XGMI } };
+
+static struct amdgpu_pmu_config arcturus_config = {
+	.formats = amdgpu_pmu_formats,
+	.num_formats = ARRAY_SIZE(amdgpu_pmu_formats),
+	.events = arcturus_events,
+	.num_events = ARRAY_SIZE(arcturus_events),
+	.types = arcturus_types,
+	.num_types = ARRAY_SIZE(arcturus_types) };
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)  { @@ -605,6 +638,22 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		}
 
 		break;
+	case CHIP_ARCTURUS:
+		pmu_entry = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_ALL,
+						"", "amdgpu");
+		if (!pmu_entry)
+			return -ENOMEM;
+
+		ret = init_pmu_entry_by_type_and_add(pmu_entry,
+							&arcturus_config);
+
+		if (ret) {
+			kfree(pmu_entry);
+			return -ENOMEM;
+		}
+
+		break;
+
 	default:
 		return 0;
 	};
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 6e57ae95f997..6b4b30a8dce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -513,6 +513,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
@@ -554,6 +555,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			counter_idx,
@@ -590,6 +592,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
 						&lo_base_addr, &hi_base_addr);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
