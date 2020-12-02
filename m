Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E4C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 01:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C3221D7E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 01:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C3221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50B76E9D7;
	Wed,  2 Dec 2020 01:49:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864B46E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 01:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT5ewSvtV9Khlx+VCybwskY3HCSmkC0UJOB92MfbaPDwMVU4ZsNCcRfraUEnlpnGQ9uNPDzEIEfEFGEDdq9iN92XmSE24d0DinxF9WWT7E9/5NR+oS7HLcmG2ZqGomL007TlQkE0hK7CG5jqkHCRozU+RYYBlonZV35LtpD1Tl++vCmykkN+jwXWOSVpoJK9JyDojVKO6++ub+CTnvEqyP/q8kIGn1BldB6lpUfkBXK2MRgLO6akePJdhyiXClcKGfYZlcvBvnvU2rHPVWbebLfGB4u1k0cT0tSPpER+xbV4v2+c6wlfBzYepaWmTTGNJ0ImZTgIuJ1gtSegP62bBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8QnGjNLNDNMqp8FgCZdDPYlevHjps9nKQf8I0Afw1A=;
 b=TAD9H8u8zPGAomjy+iRVFhilSUYozk1SnvnrMM8QlMG2m0no2efZYTKJZXqqVTsFyTv5oyyFbXLvYf57vhM/vBYEllXDYy3BZY3xzyTmy65nJswkORCmiW7kLPx+YKVcwg4V7qBIm3Iw6vl1vQliaSHUK/Bd6jIP6R4ISn0Sp6GWIbHS6L7iyyCQ2lH9ZKInMEEpDakLg4vNHy/ziVsdn7AmFXaU1tFbSPYhVVFXu5Jr/9FphqgzhRYyV65hsGJ9HeeQY3fUvklieWaygmIySgSMN9U+rtdmS1COgRKszK4NpeJtPBs9YjeMrmM87SVVkoYR2fBQFgQ86QOc9/xvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8QnGjNLNDNMqp8FgCZdDPYlevHjps9nKQf8I0Afw1A=;
 b=WWvMenF0pls4CdzOMDNACXJ8nUElRy72DpQ87LGRJ2hAzfiPAUsq46JfaWy4UBtQB+qLl33Q7qv1EvJgHjz0lphrZfpYY13A6JOewHvqDmbgvZuMt2Tbnru78u8o+9xyywIIgM3P9xuBq5ZImTVPTP/iI3ZrSMmW7Z9UIoZ0UfM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Wed, 2 Dec 2020 01:49:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 01:49:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/swsmu/sienna_cichlid: simplify sensor
 handling
Thread-Topic: [PATCH 3/3] drm/amdgpu/swsmu/sienna_cichlid: simplify sensor
 handling
Thread-Index: AQHWyBHejHMMCSlZxk2LfgwDCLVF66njCnZg
Date: Wed, 2 Dec 2020 01:49:19 +0000
Message-ID: <DM6PR12MB2619F0131C41945AE44FD974E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201184320.686358-1-alexander.deucher@amd.com>
 <20201201184320.686358-3-alexander.deucher@amd.com>
In-Reply-To: <20201201184320.686358-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0a4e4e80-c848-4a7d-9136-15bf2d068ffd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T01:48:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca3c04c2-5960-4fea-b3a3-08d896647c36
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB235843C8969665719A9EFC96E4F30@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cT25/lzY3ILtMkF6MKbop+UoJKZxKcaiGX8mHTtoFq8F4DKX89BKqDmvebTklMjITHDkT9e8ePzE2BI/oC7v4I+mdRA85cCWoig5MQ9OvOZ75CByR1/qTnTitqbSGoVZ1hBmJvljNi2bC8Fm3D81lKjl/cnmQGmqtuhFLAI0C1sQWilYYqcPMULs6O+p4ZiETiucsL2KwWEzaXG1SczlT3Pm+SkU0JbpzpVYHKVDxsmPlTdAQvlENo9X11Nd+yrICH8RWYyXuIJ6OOmwDhIogDYnmnlbHXMwNqs5riJkgB50NRo/Wq7Po+KXbV97qaf/fJlYRcufZelQf2caBDnhEO0b6uneYepKuBY6/Qz8vzI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(316002)(86362001)(5660300002)(55016002)(4326008)(53546011)(7696005)(6506007)(66946007)(33656002)(71200400001)(478600001)(45080400002)(64756008)(8676002)(9686003)(2906002)(110136005)(83380400001)(76116006)(8936002)(52536014)(186003)(66446008)(66556008)(26005)(966005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PoPTFJVubd3jnEpQigAS4/S7L5lHZ/BjMmHZmeDoUuXRJCAdrzr5vyBkfydI?=
 =?us-ascii?Q?hHNvP0ffq39HNwmEGpJXwtZ2AqdKRaj3cdaUne3T1w0352Ecy9BvW0fGSANn?=
 =?us-ascii?Q?7ADL67YGmGNsRz4woHUerZHYnLDBSJ462Gf04Tmi9Xy9JLRW0mnDlwgJCOVt?=
 =?us-ascii?Q?cQRQEx4MWhCUliyBGxnmYcptkTI79lVDYQmE3zBcIQaIPPcl2EIlGZn7+tRM?=
 =?us-ascii?Q?BMPESJyYZ3M9r296yB7gMT/2d9MgitdEE6QdIfADKu/0eHVuue57N8xHMlMK?=
 =?us-ascii?Q?HC8TGLmrNgm2N5kEh8ygDifSmT/nmB1wgebEiwktku8JpPqvOKncyyctHb6E?=
 =?us-ascii?Q?0WgLhZXXDt/2M0QREXdx5GlpDN6wfBozT0oLsnRzEWhlgYheO1QpeprywzHN?=
 =?us-ascii?Q?F11K4p4P/XiHbK4Gs2n0oYjQbOnqFE0+6yBmEzJ/WFxn7aDkpcA9hj1+fdmu?=
 =?us-ascii?Q?TCZWyp9L+foXR+S4QoF0uY5uNrIzoE64L8mPPVjrZldQ+YyEIIsGlckgJYjH?=
 =?us-ascii?Q?7sb4d9gpXovz5M/ZhLW4aryTOsO70bzycf6cnaxeo7//+/iw6ebk1gOS7E5S?=
 =?us-ascii?Q?PwW+7rNtb8Xzst8WP8BEMvORjhKnLC8Odk8lPFMXbV54CNkNJht6PEpElNeG?=
 =?us-ascii?Q?2DnDNmzFD70qUmatxTSHBpWeBVuf2OCEPsAtRaN/k0g2NoB3YoPlUNGCFOPu?=
 =?us-ascii?Q?D86AMKA09KrPbPgK0JvmT41H8ufPLGxhV+tQdAEr0vZOL28ZMtP85uurJzma?=
 =?us-ascii?Q?L/Kn34V3qdYJKY5esb3X5jdVzy1xTzY80aR5KXGmG1vntbxBPYLsa7D95XfI?=
 =?us-ascii?Q?7YkItNxfIIzg80OV5co/MzwofaSBkuYfaAK9uullXVYFFMw8vYWp89EyoMuD?=
 =?us-ascii?Q?HXzxi40A7mK4fKGCilUkT8i6YBFEatuVQ+G58lBy50K/b9cf3x0CDPqMEXjv?=
 =?us-ascii?Q?FYciV2USVvf5/M0jgXUUu4NORHltFqwF0fb3h0h9iYg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3c04c2-5960-4fea-b3a3-08d896647c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 01:49:19.6203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rz/t5PmExjuqTUyKY6s6/kDKq8Iso6j4smrbeecN7Bo0ZMUlhBFRrXUPZHqI3DX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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

[AMD Official Use Only - Internal Distribution Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 2:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/swsmu/sienna_cichlid: simplify sensor handling

Just query the metrics table directly rather than going through an extra level of functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 98 +++++--------------
 1 file changed, 24 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 21c5ea3a4a63..db0f2a476c23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1119,44 +1119,6 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 return ret;
 }

-static int sienna_cichlid_get_gpu_power(struct smu_context *smu, uint32_t *value) -{
-if (!value)
-return -EINVAL;
-
-return sienna_cichlid_get_smu_metrics_data(smu,
-   METRICS_AVERAGE_SOCKETPOWER,
-   value);
-}
-
-static int sienna_cichlid_get_current_activity_percent(struct smu_context *smu,
-       enum amd_pp_sensors sensor,
-       uint32_t *value)
-{
-int ret = 0;
-
-if (!value)
-return -EINVAL;
-
-switch (sensor) {
-case AMDGPU_PP_SENSOR_GPU_LOAD:
-ret = sienna_cichlid_get_smu_metrics_data(smu,
-  METRICS_AVERAGE_GFXACTIVITY,
-  value);
-break;
-case AMDGPU_PP_SENSOR_MEM_LOAD:
-ret = sienna_cichlid_get_smu_metrics_data(smu,
-  METRICS_AVERAGE_MEMACTIVITY,
-  value);
-break;
-default:
-dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-return -EINVAL;
-}
-
-return ret;
-}
-
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)  {
 int ret = 0;
@@ -1468,39 +1430,6 @@ static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
 return 0;
 }

-static int sienna_cichlid_thermal_get_temperature(struct smu_context *smu,
-     enum amd_pp_sensors sensor,
-     uint32_t *value)
-{
-int ret = 0;
-
-if (!value)
-return -EINVAL;
-
-switch (sensor) {
-case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-ret = sienna_cichlid_get_smu_metrics_data(smu,
-  METRICS_TEMPERATURE_HOTSPOT,
-  value);
-break;
-case AMDGPU_PP_SENSOR_EDGE_TEMP:
-ret = sienna_cichlid_get_smu_metrics_data(smu,
-  METRICS_TEMPERATURE_EDGE,
-  value);
-break;
-case AMDGPU_PP_SENSOR_MEM_TEMP:
-ret = sienna_cichlid_get_smu_metrics_data(smu,
-  METRICS_TEMPERATURE_MEM,
-  value);
-break;
-default:
-dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
-return -EINVAL;
-}
-
-return ret;
-}
-
 static int sienna_cichlid_read_sensor(struct smu_context *smu,
  enum amd_pp_sensors sensor,
  void *data, uint32_t *size)
@@ -1519,18 +1448,39 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_MEM_LOAD:
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_MEMACTIVITY,
+  (uint32_t *)data);
+*size = 4;
+break;
 case AMDGPU_PP_SENSOR_GPU_LOAD:
-ret = sienna_cichlid_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_GFXACTIVITY,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GPU_POWER:
-ret = sienna_cichlid_get_gpu_power(smu, (uint32_t *)data);
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_SOCKETPOWER,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_HOTSPOT,
+  (uint32_t *)data);
+*size = 4;
+break;
 case AMDGPU_PP_SENSOR_EDGE_TEMP:
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_EDGE,
+  (uint32_t *)data);
+*size = 4;
+break;
 case AMDGPU_PP_SENSOR_MEM_TEMP:
-ret = sienna_cichlid_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_MEM,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_MCLK:
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ce93414ccd35e4357db7908d89629003d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424450123752767%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QU9nHZZgdnnkBHOCENfXMjGKBXgmr%2BaDv6QiKG95PdA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
