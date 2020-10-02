Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6024C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4714B206B6
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dP5Aaepy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4714B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815EF6E9D0;
	Fri,  2 Oct 2020 20:57:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FE86E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 20:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv2BtBESXezNZfjn1XKLR1Ed3V3iHs9wYWeTPZ/6Vb6ZE2ciZJcxTOnbZsoE+W1GnPLLGEGJXPeyZNhwatOBtBYMrFvdBxcD/LFZwF2qJOOkkz4493UIgwK2iR/pJgoHvtsz2BxlD1LoNQklftnayM77jutmzhkl1MpN+oSk3KWbLBXL75SYq71M3Ss+y7xkLC2SniEgGULGH9SkPOyXD/Uw6GuLnczO54NOcbSxZYc8EAYEzHkkDFw5lfxITHmXRr5tU+2LTwwB4Y6i6dbKHdzfM5ia7XriENi/Vbcef54PhqHNCKfMhVf1kgL50P2B4Y2arb83fZbLmTXpAh5zJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyfUCjirn0t8efntfWC3Y4kHDLjdHsFYIpF+J3jB97w=;
 b=UksyYTVSPbj6xURG/mukKhSFIyeLytD7B1mQRzmCia1nhy5pmRfr4gg87QcmoKLqINOdau95Rdw817+llY7sJ4tTPe+H6buSLCtPGU7nmksHDd2ogkT+Bgu0XUYzVNQADO5rKb0cdzUEi/2WwQl8Ux67cGK5vqRlO53RJuj1yDaFcqX1IRjbpW5ZMmhi6HrtLsEvD75bq3V8VLKHurKKqs9F9nYsCb7OoC8wpD902F6Jf/rptIsGBbIMNHU8X6KgnRjHDjrhHF8lSqPIEwHhYtsi5Pnu4cyCz0owVDCZcYGVlIb8jIuBRzpuNm1nyoRXj3lkpNtEx0Ias8uRw2JLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyfUCjirn0t8efntfWC3Y4kHDLjdHsFYIpF+J3jB97w=;
 b=dP5Aaepy4nucCmMPyYS+SSiImybPwlk4ErygV6Hhdd7SqIIUjNIqYtbPkKR1IldLYDio1YPRORSFmGx01c8R6WcH2ULofvjmq1oxeZMQ1LJcoiw5H5bA2fC9/WRRwGmCOTdz/5OA6s14zUcjOS+JwJtuluX7nLajYKwEJRYiRqc=
Received: from BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16)
 by BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Fri, 2 Oct
 2020 20:57:43 +0000
Received: from BYAPR12MB2760.namprd12.prod.outlook.com
 ([fe80::55f6:c3f2:390c:6604]) by BYAPR12MB2760.namprd12.prod.outlook.com
 ([fe80::55f6:c3f2:390c:6604%5]) with mapi id 15.20.3412.029; Fri, 2 Oct 2020
 20:57:43 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Topic: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Index: AQHWmPlYKNGdfSi7WECemr6EWHwj2KmEyzlw
Date: Fri, 2 Oct 2020 20:57:43 +0000
Message-ID: <BYAPR12MB27606D88167B7DF07766EA3E8C310@BYAPR12MB2760.namprd12.prod.outlook.com>
References: <20201002201913.126122-1-jonathan.kim@amd.com>
 <20201002201913.126122-3-jonathan.kim@amd.com>
In-Reply-To: <20201002201913.126122-3-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-02T20:57:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ef1df1f7-5c73-4fc5-b6cf-bf2f50055fd3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66cf3ae7-6ac4-44c1-491c-08d86715cee8
x-ms-traffictypediagnostic: BYAPR12MB3368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33689AF6DFF47051F61B00CD8C310@BYAPR12MB3368.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jb/kb/q8/7EO4Pi9+dxv9yj0mj7ZatvSfn4Kssd7+TyS3t4J3DAPVvoVQqlYQAs4qbb3ZoHHs0Hxuv5mQiEx0E1/b4BhqolL2sF9rLwUx42RThp8UpkYGeGTholAkCbxLEh531wXef+QgxjfRkc6M4bcIBQ6OAfm8XVZPFsoA7edW0Traipn5C4UA5yED6m36Bg4PG08DAyiyEAxoknYQcGToL5IbdQ76tnB4GrQ5inzhitJZfEQSmUA/VbbgJNbyLIhCYE00wxUbaTkCzqPD+zkg/1D1EAPOTFAtAlFr2q0cyOCumNUO1E7QN/zSDEZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(66476007)(66556008)(2906002)(55016002)(6506007)(110136005)(5660300002)(66946007)(7696005)(316002)(26005)(76116006)(9686003)(83380400001)(33656002)(86362001)(64756008)(52536014)(186003)(8676002)(53546011)(8936002)(478600001)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G7Mmgugk6sKmV3OCfCw+xu02APYEX9wsqo0SsOhxDjEhFDa80iBjGkdFqvzNSN6FbS83+tpJIgzs8Cy17f/K3U9VcqO7B1PBpNFugNjuvlJF8FElQVZopLps5FW8LD9eZAsxlTvf74KjnUMZCKjivYbLglsPJUmww02RnWnkUpI7JtmqarODaJb7LMUfdnSHUjQCYkuGH6ddalrTraBabLZdTpC10QHc5paBdA/kb3bbBKWo0NmwULxZ2AN6VHcgENXHQskHKyn3q0csHfcQcwklha2XUJDiQ4RIg1Xwmpnf3KlmIUxWDjZZmxrKpN54zqRIB85J3a4zFWaEn59dcHIAi7JqCpjAaQxElQmCYCieF+DZ0vZlL16a2nLF7uO8I1gS7h1RVJVI5IUb7I5gdgF7QEnUiH/dlk+hPCnOAj0OwSvATyKo89J0EpGj+W9DGemt1QuIhPt+3q96ynLPbqoKey8ZonuXjoGJ5YseR6VxEXtUx9ohiJ0JEdTjO10P4QdiCZeYM450FYBuEjrmG8aq/TFQRL2A07R2d3HgL1ZsbWaYp12cFg6P4CsobV/A9F4v7Asmmx4/hoP3tjdIbVX/WwEYvZqeZSsLY13FvSPcsa8zUClkfTpCSf5GkEiBP0zM1drC1xVhl1WxWVLgNw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cf3ae7-6ac4-44c1-491c-08d86715cee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 20:57:43.4469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEtunD1crk+KnwkPJ3nwEPHEVfqstt4RFA8ZlFPBbiSP3+l0hYzM/HDn4Aqr8TlWEPz+xtv9ZC53Jc8v5lrszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
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

This series Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

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
