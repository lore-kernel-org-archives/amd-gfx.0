Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210AC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911FB2087D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PEh9UaUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911FB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469EA6E27A;
	Wed, 16 Sep 2020 02:09:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963806E27A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 02:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+zGryv+uuSNQpzX8Q/KK/Pti4FDhuClD4mGO71aSksgE4aPAhCe6eakS1Aqc465rVcLgCXa8ttnZoK8qgXz6FeeCG8PZNE49xJEeMGK8PayZ7CSgjuqHIWDP3pYriaxdvPZ0w0tMXMC3PqKP9L00QKrM1KVg/4DBfSgqSymk7sE9rNt47GbZEiMImyIjvhJyVJXyxRwEjczKLDDbv37wU/QlR1RPAghIUb6q5s0a3UoTbVmty6HmnB+QUQJHa4oVTBadkDukJfuAkTJI+YxKhXXLqvBVQfNJblyPYT+8JQJQ01gu2GmsPsTTeBeQ70GAQR0NuJG0peHl272ll0U8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d78y0kfMzchIahI9/MeWpPRvlHGM0kJPEs/o+dcsEoc=;
 b=Nr7m8OyOLv/Qf9ISPOFtQpuuhWk1l+grm02hcAJ95ccfjk4cc+cJIL+Q3QXTSHC5Ph8PhIaf0Oh8GrlP/nEkrsYx8cs3kW6Mfsote0elpO/C5N4ANugSjE7nm8OIBkgGAN1IPVCbRcIOu04fhKtqgJ0IHzpi2N9jQNjKJkRvQjwpBPb4PRn57XxOusdQ22AhKbon7Mnn6+ELYG1hCzYNOfl58rZCVhIjssfQj26LikAOGAt0powJK7FST4F9kWH7Be/847F+5KMPCB7qT5I/h087uiKAxu11a5L5bLXoHzcvGbDeIHluPz9ejBsLZWGAr6nXwqOMfG1zY9Rp+ry3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d78y0kfMzchIahI9/MeWpPRvlHGM0kJPEs/o+dcsEoc=;
 b=PEh9UaUup5NcK+Jz/sRPnv/zvrb6cFnwxKb4hXz3uljvMA+9Q8e3FN/7YjMcAJqASjmusYRytTCOKIZM3b6oP+ZHPL6n5NLtE9LIT9qP4HfZLwJzuIzAol/gBaCuzJ3ZrRLKUDSuWDaUZWxjpWjB7SPx/I6UH48k6QRWrjQkNpI=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3100.namprd12.prod.outlook.com (2603:10b6:5:11b::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 16 Sep 2020 02:09:53 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3370.018; Wed, 16 Sep 2020
 02:09:53 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Topic: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Index: AQHWi6ukwUGGoqLgdESPA5B0m2vLBqlqhVxw
Date: Wed, 16 Sep 2020 02:09:53 +0000
Message-ID: <DM6PR12MB2761C8F345F1EE8964E2BA968C210@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
 <20200915220015.2646-3-jonathan.kim@amd.com>
In-Reply-To: <20200915220015.2646-3-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T02:09:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=70a73957-61af-4352-b5aa-de5dd4898cc5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:987e:1074:7be8:407a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a25c186d-c9c8-4a1d-1957-08d859e599aa
x-ms-traffictypediagnostic: DM6PR12MB3100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3100F13CC0F00AEA287EEE418C210@DM6PR12MB3100.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLgUTXh2sdC+KAVYtbz1qs/BnWlKNf5yippUipoVXrtya2i8TEdHhg8ACCWmJD0daOYzDBzLu4oJNtPo9wiqEpCrz6rr7M3IGJVTiGoZG8M8UmXhDWV5z37O9QOhfaGTpZOOVDpmZgJmbfXvZv0eDq4JNi8fTuCt+zFu0s4OMWkJg07ZXOpeay3dEpmrvYF4ybgOdkGtBVyydS/4PzjAdDrOHMXtVACgrK37DsoHNZU7OvOI+3re5HyxI9jhwY8hz6V0DiGd2NV0yXhFGeTKCErTANrAgNsqvhxslIdB+NlIv45kpKThmMsW+wzrsAHy3/fEmw57PVyj1p5tC+9wMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(5660300002)(66446008)(2906002)(66946007)(76116006)(316002)(53546011)(71200400001)(55016002)(186003)(83380400001)(33656002)(66556008)(9686003)(110136005)(6506007)(86362001)(66476007)(8936002)(7696005)(64756008)(478600001)(8676002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WepXkb4XbocW78F28hernkTETRYJXne+MAp3u6crKCeCuGL+bzNCCsGbdlP088Au9XZ1QVNcMuU9R6pbsaCLtUWD8v0WxopIHjKdgtg/ML8VxWRDXAPv4mxKWVB7+iFipX7uuYNCJX+6ZONWk4DvmkmOzF7d1ZXR3YX4/bxd9YvB+DWxSylcE8kzRRoDXyDm11A5Ug/2heksNMSFn56rNhbEVyLNwDOTUW3+tXc0rnAFvIOSv2TIl4vEeUb4S1fG9a93l5m32K3gjqzzGoTkDX+6LDtZDjs9L1gJNUw0vTIeMstpPwUzHFwAiYy3vob+U5HXbtXn52QOvnVIPzWlB5gQRwIrfNsSBWzcQik1f+dLF1/jvZeAvfRvpreNejhZrMBOJwmY8EvCe8TrATei5girOgLZCOdqMZEcCkjvYRhc6dq23ZbCukwWdZt+9yg0A9wwomU+quyqFT391OtUiRLwAWSwvzlq3C3+pk0yUZMBCevDz+fQLeWLTSKYkQGG1TX1TV0AHAng/ZWCloPSH5HxmT5Y7h50Ur74ZeSS3WtvBBx16ZsAUA7+oWXqTtVTdZ/aZyUkEgjadWYBmakgQPbtTd18NXs5w6bmAHGHTUzA6dlw6dE8oYdjOfWc9kvMGhfQeXIPbmwEV907s8Q6Bn7VHnFUq5CsIXb+5yhlNSQkw/9RW8xC978VsbLw1QTV9koduQOSa0cjoef0P83tgw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c186d-c9c8-4a1d-1957-08d859e599aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 02:09:53.2170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pznnGQ0dHZblQiz/qm2NQOfpWgDEkNUbAGtYXsLx4dDI4pbyv8EmPkJy/DFjVeF/GQWFJg4iG8Ej/eE+iLPuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3100
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com> 
Sent: Tuesday, September 15, 2020 6:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 55 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index f3d2ac0e88a7..ec521c72e631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -34,6 +34,8 @@
 #define NUM_EVENTS_DF_LEGACY		8
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		2
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		6
 
 /* record to keep track of pmu entry per pmu type per device */  struct amdgpu_pmu_entry { @@ -110,6 +112,27 @@ const struct attribute_group *vega20_attr_groups[] = {
 	NULL
 };
 
+/* Arcturus events */
+static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x4b,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x4c,umask=0x2" },
+	{ "xgmi_link2_data_outbound", "event=0x7,instance=0x4d,umask=0x2" },
+	{ "xgmi_link3_data_outbound", "event=0x7,instance=0x4e,umask=0x2" },
+	{ "xgmi_link4_data_outbound", "event=0x7,instance=0x4f,umask=0x2" },
+	{ "xgmi_link5_data_outbound", "event=0x7,instance=0x50,umask=0x2" } };
+
+static struct attribute_group arcturus_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
+const struct attribute_group *arcturus_attr_groups[] = {
+	&amdgpu_pmu_format_attr_group,
+	&arcturus_event_attr_group,
+	NULL
+};
+
 /* All df_vega20_* items are DEPRECATED. Use vega20_ items above instead. */  static const char *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
 	{ "event", "config:0-7" },
@@ -400,6 +423,16 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 
 		pmu_entry->pmu.attr_groups = vega20_attr_groups;
 		break;
+	case CHIP_ARCTURUS:
+		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
+				arcturus_events, 0, NUM_EVENTS_ARCTURUS_XGMI,
+				PERF_TYPE_AMDGPU_XGMI);
+		num_events += NUM_EVENTS_ARCTURUS_XGMI;
+
+		/* other events can be added here */
+
+		pmu_entry->pmu.attr_groups = arcturus_attr_groups;
+		break;
 	default:
 		return -ENODEV;
 	};
@@ -530,6 +563,28 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 			goto err_pmu;
 		}
 
+		break;
+	case CHIP_ARCTURUS:
+		ret = amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
+						&fmt_attr,
+						NUM_FORMATS_AMDGPU_PMU,
+						&arcturus_event_attr_group,
+						&evt_attr,
+						NUM_EVENTS_ARCTURUS_MAX);
+
+		if (ret)
+			goto err_alloc;
+
+		ret = init_pmu_by_type(adev,
+				&amdgpu_pmu_format_attr_group, fmt_attr,
+				&arcturus_event_attr_group, evt_attr,
+				"Event", "amdgpu", PERF_TYPE_AMDGPU_MAX);
+
+		if (ret) {
+			kfree(arcturus_event_attr_group.attrs);
+			goto err_pmu;
+		}
+
 		break;
 	default:
 		return 0;
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
