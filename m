Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD7C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AE161002
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AE161002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B4789B20;
	Mon, 17 May 2021 20:07:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BFA89B20
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 20:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHi4/fZBOeqZlXfPz+dG9VUZNf7at/KcTKGB7Cg4shFW/VSNX41AtdJwMbGn0JvigFRc9q3/ILPZ59uQIBI64coBjyTJuT/YGwJG9E9Hivb0/KmSxm26hDlzeN50Ri7JpMrBfuOs11eVwbmnHObaJ96f8YU63LkwU27JgbPZvEsG+snL1HIDvL9G4mRAVoXwokqkX1NIHiTFiAbh8YfFNpJDqKxpakMwvWI07n+ppw4mJPdQOiw0hsHCRPdVGpwcyrQuw8OSxOnzq/7JspZ2cfnsN4IIrcPqQ6yjUe3g3pJVS5L9vT3osOMcvUZvWpBS3TZiQJdGjEXJN1JsOiRU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4XByUd0k5RCCs3lbZU2W91xIJDHoURPe/RGxSs7AQ0=;
 b=NT4IXMEmQQg7UiNT2XTjFbkWsXIPb7Eoc87az/YusIK5hfXJ5aUUsU+ZjVhXsmeY5YKN6g4eODyp+0Ol1lTLz4NBhAVcWsZkiqrogIqtvY+7kLCYFgJ3Gl/8hwJmDySdnZ9kEkT+uynJqp3hzSacOSR5WLKqJ4kuZHsHZ2Jm3JfDbgR+uoOgMJ8p+eFkTs7DxA2KFcnfJs7tDW4P9rRrzh1phSBix2CFt0ohwEv8rYbN6qqXGvh0GeyRXXl9ws1q0dh+f1Gi3kioQLdlAawgmJRcYbiMaGcpfie+wGy8a+1hI1reXOpFy+/LGyyPeRCFU8Ij7JdejZdcEGpHFiIVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4XByUd0k5RCCs3lbZU2W91xIJDHoURPe/RGxSs7AQ0=;
 b=E6MgZG4/PVOlCEE5WRqA0emKy8GAhy9qGlkpeLTmscwH+a+AkRE0w0P4mcS6xOwytU8Ba3Bfx+BhqmoZNbthkzR1Rfe7AzZNv58P/niUp3OBbHBODquCcQV5prPbcv5d10cdRo9+Gvoz+Ncv7a3lYcHgoSFUxgWlkvzVPEfI6Sk=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 20:06:57 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 20:06:57 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x
Thread-Index: AQHXSQRa8qQowvQgmUuj4mevZAUa2qrnOZCAgADjz8c=
Date: Mon, 17 May 2021 20:06:57 +0000
Message-ID: <BYAPR12MB28401B53159CAC8ECF5B2322F42D9@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210514210135.14079-1-david.nieto@amd.com>
 <20210514210135.14079-2-david.nieto@amd.com>,
 <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T20:06:56.741Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.143.192.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 296d6d94-1617-4f5f-ab72-08d9196f52f7
x-ms-traffictypediagnostic: BYAPR12MB4789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4789949107FFB323AA2B89EBF42D9@BYAPR12MB4789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAT2h1969dWXfi6EHGA16DCEn0OVnKk/XnGCJNki/sy1Jj4vU0iVuN0Dgn+JN0sOiXjRqo0NzGMsehuhiVXqO5GozsDihoW3cUdq0EwvXqC5Vn2X9DKf+hkY++QwjaZT639LbDsPp5te9VrjQjaDKpP2JaPero1bal7PX2NiNPOQF4cPG5lJmjbjPeTI3cCaJIbtAM12beJzeSWNo/TemVdAnokLKze7/3vyikEfVtUeoctKhK9ptecbe9KO9BPGj/wTKqDXL5eZrQFm3h3pys3KPIAg0Y+D07XFf06XRZxxJD8GICzwK9Klx6Nv9G5IoMbrGXHA3irHad4oenMkNPLmOhVZ1u3uUtW7Z2QP27LywimttKYIitZBgAX0yecZ4leosnAu2C1pXI8nPiyynKf+/0Z7UzH05o79cAJ3fILY6X5/FWyfeKQPHcy55qbqQBL+1r97e7WVQ2rG0Thd9s6J44PcityZqHjuzGckMl8MZVdDnPPxbdIjWKAMnXGSJqvVXM2mKU3Wbp/Sg/1VZWtAzVS9cmJxI/5kftUEcnq+p+z3J1AJMkXL2zMno5ASSQg/e3qSf98QNeMaz+d3/gqDOFklgaU7RurhkTi5fdfGcAEQ++LNkhNlrf/l3EKCDVdHOcFRcZYVbuk/h3Dmk5iUxXD5Coyh3ECInP9PxdNEPdoRtftLbG/4hV6Oz5Wy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(53546011)(86362001)(55016002)(6506007)(9686003)(76116006)(8936002)(30864003)(2906002)(66476007)(66946007)(966005)(45080400002)(52536014)(478600001)(122000001)(66556008)(66446008)(33656002)(8676002)(19627405001)(5660300002)(7696005)(316002)(19627235002)(186003)(110136005)(38100700002)(166002)(26005)(83380400001)(71200400001)(64756008)(32563001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lcWjMa7CCNFy5p3EEQgN5MvDyVQcw+Z3OXkKSKYQFYxWNVU+XGLvYqCc9IDn?=
 =?us-ascii?Q?+3iIldsClERqi3z14k/VOqKLGKZk1eEkKn8Q7MyUV5Dt6LiUTM5fWCjVwsmg?=
 =?us-ascii?Q?0xuh0ZU45P2hRI5jagyyizN0TTI5PUrnyfEtf2VRm/3Ya3yu4ydvw5dL/yjO?=
 =?us-ascii?Q?WFggb7kGEsHvrfN/xhvCgiKbMLJifFMjkBeoWbXPai7QRHeNzZcuY9c4lDwd?=
 =?us-ascii?Q?qHKXARMS9MEnxW0c7o34//Y/8kzhLo/+U6xCn7T82oJjmKRNYrz42kpabSRN?=
 =?us-ascii?Q?9azVpmX8ZO+7BSi6i+a4mSiQPUkguWIud/GFQM1vJQzQyboRBupmVw9f9VMw?=
 =?us-ascii?Q?li1oHbRhEjiLozRq+6HtUVnGbKglI5Sms2KSMmPKEP12qqIakz4HJbNMLuha?=
 =?us-ascii?Q?EEFjLmrY8ofC+nRT4L1Q7fUm8lUZzGVanEqQ7NYaZVagGTf9dzhbSjvLl/19?=
 =?us-ascii?Q?3X5XXfUHDL7P9yeWUwPyBKKwImwCVIjoN9yJCwsfh1JVILb8Ax1MqQBjP/H6?=
 =?us-ascii?Q?D6iSfkLWaWNiJKDzvkgrsl+zwovTrlbydXfZs8AuJihi+xEkWoLZgiTQTODB?=
 =?us-ascii?Q?ELZDU9m6cHPCkEAi/XxnkfO7zgRy97o9uI8Wbm1tyc7pX7epEQdH9sfmQ4Jk?=
 =?us-ascii?Q?3rZo3tEMOCpydnyBdJBSaKl27Oq8deXaoc4S9+LeggCtgHMjxTrOHdNmPYEk?=
 =?us-ascii?Q?qDFODDenaLTkdiLKVKFV/aOdgX/82lU1VLDitEMo9l0JOrd3bltempD229Pm?=
 =?us-ascii?Q?N/nLxR2TvX2NcPz1tROJmf4UODZBFGS4B0e/T47HUVfQOPhDoCKfyd6DT8No?=
 =?us-ascii?Q?UWoCT6t/inkNodoNWSMVqn2D3U+ZA0+UK1zdv/2qWp03ttzkYldsCbzqItWs?=
 =?us-ascii?Q?q7z9FuDFst/BhN1b2nofGI6GiTcbeINXsIENslv1Rx4OB6LL4yimnOg80ueH?=
 =?us-ascii?Q?DRlmY/4C09X43juFthAqeqmSo4+TdSwIHyEJMWIaj9gCJDonA1Wnpu38Y1z+?=
 =?us-ascii?Q?P1Qe2KGY7JMnRbdWDJexor6F7tOs0rPH+uqW4K9+QWmW+KhNWbVJeXaLM9Op?=
 =?us-ascii?Q?moNJRTwI0QqWxpqhS3MZm+VEMTBBnrzNIUq/VfW+ToYzxTKfktsJpFi1qFi5?=
 =?us-ascii?Q?E6EZ7pOwv31MysPhlcxLnIZ3FKEZS5u+v/2SunBue1+6kPVJcc0jySL3voZW?=
 =?us-ascii?Q?MIqGlg7Dx5HyySi8kIKLTYrktm86wJyo2zyC/jAA+F6uLMcjyZcRq66Ak0RW?=
 =?us-ascii?Q?hAEKqx2fshdVeWyR/RJXdG2KLp9lq4AbMGQBTQeVyLNG+2TBaAZuljczfSiN?=
 =?us-ascii?Q?E89q+CbY2QNSdXwdYAwpdDEm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296d6d94-1617-4f5f-ab72-08d9196f52f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 20:06:57.1724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+0tSqF4oTIaiM33YvvXkGehGYNdXhyWkoE6VzuxeAMZ1kgmxeMV474QpjB1cP0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
Content-Type: multipart/mixed; boundary="===============0661162508=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0661162508==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB28401B53159CAC8ECF5B2322F42D9BYAPR12MB2840namp_"

--_000_BYAPR12MB28401B53159CAC8ECF5B2322F42D9BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I dont think the pp_nodes expose the vclk dclk nodes, but it might be bette=
r to rework this patch to expose those instead, and just add the voltages..=
.
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Sunday, May 16, 2021 11:28 PM
To: Nieto, David M <David.Nieto@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Nieto, David M <David.Nieto@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x

[AMD Public Use]

Metrics table carries dynamic state information of the ASIC. There are othe=
r pp_* nodes which carry static information about min/max and levels suppor=
ted and that is a one-time query. Why there is a need to put everything in =
metrics data?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David M =
Nieto
Sent: Saturday, May 15, 2021 2:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Nieto, David M <David.Nieto@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x

Fill voltage and frequency ranges fields

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I07f926dea46e80a96e1c972ba9dbc804b812d503
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 434 +++++++++++++++++-
 1 file changed, 417 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..a412fa9a95ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
                 goto err0_out;
         smu_table->metrics_time =3D 0;

-       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
1);
+       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
3);
         smu_table->gpu_metrics_table =3D kzalloc(smu_table->gpu_metrics_ta=
ble_size, GFP_KERNEL);
         if (!smu_table->gpu_metrics_table)
                 goto err1_out;
@@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct=
 smu_context *smu,
                                              void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_1 *gpu_metrics =3D
-               (struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_3 *gpu_metrics =3D
+               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
         SmuMetrics_legacy_t metrics;
         int ret =3D 0;
+       int freq =3D 0, dpm =3D 0;

         mutex_lock(&smu->metrics_lock);

@@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct s=
mu_context *smu,

         mutex_unlock(&smu->metrics_lock);

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot; @=
@ -2681,19 +2682,119 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct=
 smu_context *smu,

         gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

+       gpu_metrics->voltage_gfx =3D (155000 - 625 * metrics.CurrGfxVoltage=
Offset) / 100;
+       gpu_metrics->voltage_mem =3D (155000 - 625 * metrics.CurrMemVidOffs=
et) / 100;
+       gpu_metrics->voltage_soc =3D (155000 - 625 *
+metrics.CurrSocVoltageOffset) / 100;
+
+       gpu_metrics->max_socket_power =3D smu->power_limit;
+
+       /* Frequency and DPM ranges */
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_dclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+       if (ret)
+               goto out;
+       gpu_metrics->max_gfxclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+                       gpu_metrics->max_gfxclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+                       gpu_metrics->max_socclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+                       gpu_metrics->max_uclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+                       gpu_metrics->max_vclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+                       gpu_metrics->max_dclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_frequency =3D freq;
+
         *table =3D (void *)gpu_metrics;

-       return sizeof(struct gpu_metrics_v1_1);
+       return sizeof(struct gpu_metrics_v1_3);
+out:
+       return ret;
 }

 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
                                       void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_1 *gpu_metrics =3D
-               (struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_3 *gpu_metrics =3D
+               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
         SmuMetrics_t metrics;
         int ret =3D 0;
+       int freq =3D 0, dpm =3D 0;

         mutex_lock(&smu->metrics_lock);

@@ -2709,7 +2810,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,

         mutex_unlock(&smu->metrics_lock);

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot; @=
@ -2746,19 +2847,119 @@ static ssize_t navi10_get_gpu_metrics(struct smu_co=
ntext *smu,

         gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

+       gpu_metrics->voltage_gfx =3D (155000 - 625 * metrics.CurrGfxVoltage=
Offset) / 100;
+       gpu_metrics->voltage_mem =3D (155000 - 625 * metrics.CurrMemVidOffs=
et) / 100;
+       gpu_metrics->voltage_soc =3D (155000 - 625 *
+metrics.CurrSocVoltageOffset) / 100;
+
+       gpu_metrics->max_socket_power =3D smu->power_limit;
+
+       /* Frequency and DPM ranges */
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_dclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+       if (ret)
+               goto out;
+       gpu_metrics->max_gfxclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+                       gpu_metrics->max_gfxclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+                       gpu_metrics->max_socclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+                       gpu_metrics->max_uclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+                       gpu_metrics->max_vclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+                       gpu_metrics->max_dclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_frequency =3D freq;
+
         *table =3D (void *)gpu_metrics;

-       return sizeof(struct gpu_metrics_v1_1);
+       return sizeof(struct gpu_metrics_v1_3);
+out:
+       return ret;
 }

 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
                                              void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_1 *gpu_metrics =3D
-               (struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_3 *gpu_metrics =3D
+               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
         SmuMetrics_NV12_legacy_t metrics;
         int ret =3D 0;
+       int freq =3D 0, dpm =3D 0;

         mutex_lock(&smu->metrics_lock);

@@ -2774,7 +2975,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct s=
mu_context *smu,

         mutex_unlock(&smu->metrics_lock);

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot; @=
@ -2814,19 +3015,119 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct=
 smu_context *smu,

         gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

+       gpu_metrics->voltage_gfx =3D (155000 - 625 * metrics.CurrGfxVoltage=
Offset) / 100;
+       gpu_metrics->voltage_mem =3D (155000 - 625 * metrics.CurrMemVidOffs=
et) / 100;
+       gpu_metrics->voltage_soc =3D (155000 - 625 *
+metrics.CurrSocVoltageOffset) / 100;
+
+       gpu_metrics->max_socket_power =3D smu->power_limit;
+
+       /* Frequency and DPM ranges */
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_dclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+       if (ret)
+               goto out;
+       gpu_metrics->max_gfxclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+                       gpu_metrics->max_gfxclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+                       gpu_metrics->max_socclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+                       gpu_metrics->max_uclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+                       gpu_metrics->max_vclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+                       gpu_metrics->max_dclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_frequency =3D freq;
+
         *table =3D (void *)gpu_metrics;

-       return sizeof(struct gpu_metrics_v1_1);
+       return sizeof(struct gpu_metrics_v1_3);
+out:
+       return ret;
 }

 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
                                       void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_1 *gpu_metrics =3D
-               (struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_3 *gpu_metrics =3D
+               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
         SmuMetrics_NV12_t metrics;
         int ret =3D 0;
+       int freq =3D 0, dpm =3D 0;

         mutex_lock(&smu->metrics_lock);

@@ -2842,7 +3143,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_cont=
ext *smu,

         mutex_unlock(&smu->metrics_lock);

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot; @=
@ -2884,9 +3185,108 @@ static ssize_t navi12_get_gpu_metrics(struct smu_con=
text *smu,

         gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

+       gpu_metrics->voltage_gfx =3D (155000 - 625 * metrics.CurrGfxVoltage=
Offset) / 100;
+       gpu_metrics->voltage_mem =3D (155000 - 625 * metrics.CurrMemVidOffs=
et) / 100;
+       gpu_metrics->voltage_soc =3D (155000 - 625 *
+metrics.CurrSocVoltageOffset) / 100;
+
+       gpu_metrics->max_socket_power =3D smu->power_limit;
+
+       /* Frequency and DPM ranges */
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+       if (ret)
+               goto out;
+       gpu_metrics->min_dclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+       if (ret)
+               goto out;
+       gpu_metrics->max_gfxclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+                       gpu_metrics->max_gfxclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_gfxclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+                       gpu_metrics->max_socclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_socclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+                       gpu_metrics->max_uclk_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_uclk_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+                       gpu_metrics->max_vclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_vclk0_frequency =3D freq;
+
+       ret =3D smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_dpm =3D dpm;
+
+       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+                       gpu_metrics->max_dclk0_dpm - 1, &freq);
+       if (ret)
+               goto out;
+
+       gpu_metrics->max_dclk0_frequency =3D freq;
+
         *table =3D (void *)gpu_metrics;

-       return sizeof(struct gpu_metrics_v1_1);
+       return sizeof(struct gpu_metrics_v1_3);
+out:
+       return ret;
 }

 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7C2aabcce1455c410dec6008d9171b80a8%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637566229187346163%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNgH=
qow7Ra1rXTqz4suB8Vv%2FASOYRRJAtCgLUcpHRDto%3D&amp;reserved=3D0

--_000_BYAPR12MB28401B53159CAC8ECF5B2322F42D9BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I dont think the pp_nodes expose the vclk dclk nodes, but it might be bette=
r to rework this patch to expose those instead, and just add the voltages..=
.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Sunday, May 16, 2021 11:28 PM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Metrics table carries dynamic state information of the ASIC. There are othe=
r pp_* nodes which carry static information about min/max and levels suppor=
ted and that is a one-time query. Why there is a need to put everything in =
metrics data?<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Da=
vid M Nieto<br>
Sent: Saturday, May 15, 2021 2:32 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x<br>
<br>
Fill voltage and frequency ranges fields<br>
<br>
Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
Change-Id: I07f926dea46e80a96e1c972ba9dbc804b812d503<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | 434 +++++++=
++++++++++-<br>
&nbsp;1 file changed, 417 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index ac13042672ea..a412fa9a95ec 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err0_out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time=
 =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_table_size =
=3D sizeof(struct gpu_metrics_v1_1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_table_size =
=3D sizeof(struct gpu_metrics_v1_3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_=
table =3D kzalloc(smu_table-&gt;gpu_metrics_table_size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;gpu_met=
rics_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err1_out;<br>
@@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_1 *gpu_metrics =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_1 *)smu_table-&gt;gpu_metrics_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_3 *gpu_metrics =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_3 *)smu_table-&gt;gpu_metrics_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_legacy_t metric=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int freq =3D 0, dpm =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;<br>
@@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct s=
mu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
metrics_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot; @@ -2681,19 +2682,119 @@ static s=
size_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clo=
ck_counter =3D ktime_get_boottime_ns();<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_gfx =3D (1550=
00 - 625 * metrics.CurrGfxVoltageOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_mem =3D (1550=
00 - 625 * metrics.CurrMemVidOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_soc =3D (1550=
00 - 625 * <br>
+metrics.CurrSocVoltageOffset) / 100;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socket_power =3D =
smu-&gt;power_limit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frequency and DPM ranges */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_dclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_GFXCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_gfxclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_SOCCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_socclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_UCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_dpm =3D dpm;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_uclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_VCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_vclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_DCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_dclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_frequency =
=3D freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_3=
);<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_1 *gpu_metrics =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_1 *)smu_table-&gt;gpu_metrics_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_3 *gpu_metrics =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_3 *)smu_table-&gt;gpu_metrics_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int freq =3D 0, dpm =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;<br>
@@ -2709,7 +2810,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
metrics_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot; @@ -2746,19 +2847,119 @@ static s=
size_t navi10_get_gpu_metrics(struct smu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clo=
ck_counter =3D ktime_get_boottime_ns();<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_gfx =3D (1550=
00 - 625 * metrics.CurrGfxVoltageOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_mem =3D (1550=
00 - 625 * metrics.CurrMemVidOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_soc =3D (1550=
00 - 625 * <br>
+metrics.CurrSocVoltageOffset) / 100;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socket_power =3D =
smu-&gt;power_limit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frequency and DPM ranges */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_dclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_GFXCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_gfxclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_SOCCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_socclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_UCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_dpm =3D dpm;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_uclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_VCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_vclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_DCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_dclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_frequency =
=3D freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_3=
);<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_1 *gpu_metrics =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_1 *)smu_table-&gt;gpu_metrics_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_3 *gpu_metrics =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_3 *)smu_table-&gt;gpu_metrics_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_NV12_legacy_t m=
etrics;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int freq =3D 0, dpm =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;<br>
@@ -2774,7 +2975,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct s=
mu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
metrics_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot; @@ -2814,19 +3015,119 @@ static s=
size_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clo=
ck_counter =3D ktime_get_boottime_ns();<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_gfx =3D (1550=
00 - 625 * metrics.CurrGfxVoltageOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_mem =3D (1550=
00 - 625 * metrics.CurrMemVidOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_soc =3D (1550=
00 - 625 * <br>
+metrics.CurrSocVoltageOffset) / 100;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socket_power =3D =
smu-&gt;power_limit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frequency and DPM ranges */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_dclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_GFXCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_gfxclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_SOCCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_socclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_UCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_dpm =3D dpm;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_uclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_VCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_vclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_DCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_dclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_frequency =
=3D freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_3=
);<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_1 *gpu_metrics =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_1 *)smu_table-&gt;gpu_metrics_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_3 *gpu_metrics =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct gpu_metrics_v1_3 *)smu_table-&gt;gpu_metrics_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_NV12_t metrics;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int freq =3D 0, dpm =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
&nbsp;<br>
@@ -2842,7 +3143,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
metrics_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot; @@ -2884,9 +3185,108 @@ static ss=
ize_t navi12_get_gpu_metrics(struct smu_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clo=
ck_counter =3D ktime_get_boottime_ns();<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_gfx =3D (1550=
00 - 625 * metrics.CurrGfxVoltageOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_mem =3D (1550=
00 - 625 * metrics.CurrMemVidOffset) / 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;voltage_soc =3D (1550=
00 - 625 * <br>
+metrics.CurrSocVoltageOffset) / 100;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socket_power =3D =
smu-&gt;power_limit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frequency and DPM ranges */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK, 0, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;min_dclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_GFXCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_GFXCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_gfxclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_gfxclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_SOCCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_dpm =3D dp=
m;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_SOCCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_socclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_socclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_UCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_dpm =3D dpm;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_UCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_uclk_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_uclk_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_VCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_vclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_vclk0_frequency =
=3D freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_level_count=
(smu, SMU_DCLK, &amp;dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_dpm =3D dpm=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_dpm_freq_by_ind=
ex(smu, SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;=
max_dclk0_dpm - 1, &amp;freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;max_dclk0_frequency =
=3D freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_3=
);<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7C2aabcce1455c410dec6008d9171b80a8%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637566229187346163%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3DNgHqow7Ra1rXTqz4suB8Vv%2FASOYRRJAtCgLUcpHRDto%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7C2aabcce1455c410dec6008d9171b80a8%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637566229187346163%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DNgHqow7Ra1rXTqz4suB8Vv%2FASOYRRJAtCgLUcpHRDto%3D&amp;amp;r=
eserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB28401B53159CAC8ECF5B2322F42D9BYAPR12MB2840namp_--

--===============0661162508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0661162508==--
