Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD37C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E527B64F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E527B64F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB9E6EC6D;
	Thu,  4 Feb 2021 03:21:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68E76EC6D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 03:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+nXJFT5tW+e1MVfyFxdPYn2pkP4Ur0cSeFuxgM3FIXt3XZxpsGji8uGRrHL+fGgdOoZdW+wC1oGbAw+Lad7TX855D5RwwutS4r+ptXqSVLE9rDCzN4Ns+qEkOm4+f0bDol4pA6XxyMhFmIW7Vi7C3KPyxlCXg6ipHE3gJpx8z0JXsbBkqO72GBVjtbJTr76LoNnS9OLNS4INwdAiRRPLEghqak0H/9BtnP8gsO7f9m32VaQ2D6Q8h2cLuO4g0QzP8XmzMJUYkerBri91xeEcmRvw0h4dyJQ4vUJ7HEXYnuq0GHU+Dsi6qKjNdMr/THMUSq5kfsqDGWQQJag0uy6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDumfXZa/UyD06o1OKxFhJuDLm2Q5QlS+qLf2vlC/oo=;
 b=VpFECxbvEHDy0sTILtJ7pRLaIbqSGqOkFNe7H/LOkqy/r7HZ/wRwJcigfCrNMBOCOw3/nFn8debKciDsFtQulIgcuDbmoyn2IjsJ0QWDQW/RyiygbiWEa5+T/Vvc+C0Xe24YIiB3LycGD3y60r9uhVKfuFJVqeesDYkF1locLTcf02KZ7+MZtsryr8q8mW8XcbD14CPUALoG7I6qXduk6UNsqVExmoP+T+aYMP7TYhwz0681AT8WbxrZE4shPDa7M//MV6qdM8yQihWuORX5+oxAwvKLK2BfbUMnSM2ihOBvfyTqtAluO9zTyu5RnLSS8V5if1vyyZYzaR+VAWS1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDumfXZa/UyD06o1OKxFhJuDLm2Q5QlS+qLf2vlC/oo=;
 b=tBL0qTU3umOkLB91b90d2S+bVC64XHu7ZeWi3cmLtoUdu8lph97s2V4NE8h+i41K1mOP8bHr0FxKMRJGJ3ng3GLIlo2UhQfKo0K3Xjxbfmh0EHhu8+BpWPgq1cfhlrrDUZE7HhpXta64tGB/Xakrupnt0YsB7hIEMrwe2rWwPbc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Thu, 4 Feb
 2021 03:21:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%8]) with mapi id 15.20.3805.026; Thu, 4 Feb 2021
 03:21:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm/swsmu: unify the init soft gpu metrics function
Thread-Topic: [PATCH] drm/amd/pm/swsmu: unify the init soft gpu metrics
 function
Thread-Index: AQHW+g8vvqZfHg587EKQzOHFEtsnx6pHVWB4
Date: Thu, 4 Feb 2021 03:21:12 +0000
Message-ID: <MN2PR12MB448883B167602CD19A5A381FF7B39@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210203092947.14023-1-kevin1.wang@amd.com>
In-Reply-To: <20210203092947.14023-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-04T03:21:11.792Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78778b10-5fcc-44cf-346f-08d8c8bbec84
x-ms-traffictypediagnostic: MN2PR12MB3710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3710093C0934ADBF6DFFE0C5F7B39@MN2PR12MB3710.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7KManP+G05eN6zqmmA2eVZJIjjBJVAP/sUSVCccrF0dPAaF7AA0xpCBnTrMU55aMnVg//2FhfyjzxpkaADidWy6LJ0VzYHxFWkcnrmaP+CLykURfvVHLhvT7MZ06WfalA92hK4KEnodO74OUUzAE3ZUlFAZn+Zs1Nzoz8UjZ0yt7IkKx3QQT8L9ewrVA9SjlLqsGXzD9iNH+wKvnSyHPRp+91iKv2QzE9HLLkg3RkBqo+LpZHopXkulUpXPPzJNM4GYsu5W+apYLgf2sf8pdrfkG6j60AbmB5T6+WezGrKt/iASI4vQeMz4iF72/ivCmlPFXCJAYv5c9xv9h3Uzu1ZclMwJbY9pm9ec4v4HBo18dgKKs0p5E20r9AW+1DDBMQdLJgGIlkh8jRdACwgy+DT8QMIhaEXv+F0vZV240jxJwjTpbzL5ZXkH7hs+bG3Oy0GeF4xLh9/kdoGs6cdH1UMmPDg1H2f6UmE4vLw5izG/bAHCrrS8efw71gDw/PnQxTI5a+MNBmEA+7s/3rAXgorM3GXUsgmwBgcrO5Fj8K8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(55016002)(9686003)(53546011)(66946007)(6506007)(5660300002)(19627405001)(76116006)(30864003)(33656002)(66446008)(83380400001)(64756008)(7696005)(66476007)(8676002)(8936002)(52536014)(166002)(66556008)(45080400002)(966005)(2906002)(186003)(26005)(86362001)(316002)(110136005)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+YiiPkQW+9Ouxjyb5RdkaAbjAj6QhULslHUTX9ALFqF5q75SiE0VMm5CKE?=
 =?iso-8859-1?Q?YYl31xhZsDVEOm4UN/l7p9T3bBAxHdO7pdRW2UhoayyvIgn/lxJxZBj5pL?=
 =?iso-8859-1?Q?RjBVatZZQyjzVBWdA0ImoPKXi3AH72Bc9auxQTrEUcTKpURS1NJ4fVejVP?=
 =?iso-8859-1?Q?LL4mzozegsWYdoYJhggQ0Uq7hCRysU1iN6mI+HAIH8RldEaPy+9eS5nfYg?=
 =?iso-8859-1?Q?MbXhIEkMEPE9PhKB8I2TcjFuiLa6HRa3jxHfKLZoQGlAL3h8e04EJhmPUy?=
 =?iso-8859-1?Q?0eoFsGTsesQ/haCCFSkzxTjjxxBU3C30sPKS3/njyblpP0Ye9kIH/LwBHz?=
 =?iso-8859-1?Q?5ZPW/lPrXmoJvdGePSVvhHFrcUGRrfJ/z7YdKxjNrI+Vgb3S09Yg/sxI6c?=
 =?iso-8859-1?Q?7HXMQvbhU3rkdoY4Mxy8bmVLqNBtujNU4BDLbjLySCkxfvQ0EOoMGBMfF0?=
 =?iso-8859-1?Q?KQmZ6e/K32FcBTc0k6HOMc0IQIERyjD/T6Mzz8MEO5863qvv9SwYam4GJw?=
 =?iso-8859-1?Q?rmQsQdiP6/PttJrEoEe/vgN6LnXssJPIsyNFG8k4Ju3gJKrHvjN3mXKWNJ?=
 =?iso-8859-1?Q?5ln36dxaqoL0StjPr4yyhj2TwIHWMITMZvM+qjzxm5ikW6yhCuvpExJoR3?=
 =?iso-8859-1?Q?o/WMw7wG0x1Ru6rt7u6Swa+M1MaUIfQkO1asQE3aJcua936OS+PV/7Evfi?=
 =?iso-8859-1?Q?K7Vbvq5BrKkAZ5bqfK5sP2Ha8FV7ucq7ApJZUQ+OsGxH8uXNL9YtBmizwD?=
 =?iso-8859-1?Q?WDbsdVPCa2CivR8IqfO7rqJR9WL81MvnE3yeuYUUULIy7xWbjaEU3P/4n8?=
 =?iso-8859-1?Q?oa+NuxoY8p/Q6rtthB2Wf0HBzIe7qlyd3AyuSU6cfwUoMjsUbdN8nYGRZ8?=
 =?iso-8859-1?Q?iqH7mcuROGSU6rP1W2Tev8xqUvQCqhoFuqMVIAOM2oA+R9yxthy1e1ARj1?=
 =?iso-8859-1?Q?wiK0PtRBnPJJo8aRdYvmneL1bSMfnPeJyaAHf1vjSVq1NiN5ULMBtsE5k8?=
 =?iso-8859-1?Q?hmAfwbSIAYYu2hMx2+9JXwBFqBW9hhYIB9hPJXA/mutGLgsEn5tWWxemqH?=
 =?iso-8859-1?Q?zIbl5GtOOicQl9cjWjwM4QzQQmDiHeeq5rVUynEaK39xfhpbfqzSxyveNT?=
 =?iso-8859-1?Q?DzMzdFcdC6Vq4Eu8CrS1pABdFlMvQ/TxvLrommze/R7ilTI+1LCHJYNedF?=
 =?iso-8859-1?Q?O0uaPR9TStm/BYmNxuWD4bWPfClC/2yczT6eBC3MJXvKM2+ydPIm1mV86r?=
 =?iso-8859-1?Q?4Bl8Vphsil02YOk5k/TcmiZaXys14hZ5PaPfhZbrZNAi2KOqLZ4xfWFiXO?=
 =?iso-8859-1?Q?PLh9ll4Hinj1Ucl+ok/NpcT6kZdDmX33jCGgtj4RzjCyQwOONcUnwiJ783?=
 =?iso-8859-1?Q?zS5Jd9yh3i?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78778b10-5fcc-44cf-346f-08d8c8bbec84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 03:21:12.4217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrZRFwuIZDnff5DxTN0GFMBXHj4p3qKDpAXWT4anPdJ1/U5b7pjwS3H0A5rtWa0V51Kd5EdcSH3k/UzowuA72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
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
Content-Type: multipart/mixed; boundary="===============1385100258=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1385100258==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448883B167602CD19A5A381FF7B39MN2PR12MB4488namp_"

--_000_MN2PR12MB448883B167602CD19A5A381FF7B39MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kevin Wa=
ng <kevin1.wang@amd.com>
Sent: Wednesday, February 3, 2021 4:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm/swsmu: unify the init soft gpu metrics function

the soft gpu metrics is not asic related data structure.
unify them to reduce duplicate code.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  4 ---
 drivers/gpu/drm/amd/pm/inc/smu_v12_0.h        |  2 --
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 ++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 ------------------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 12 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 11 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v11_0.h
index c7d57e9555cc..e49c2d08a983 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -272,10 +272,6 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct=
 smu_context *smu);

 int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);

-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)=
;
-
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
;
-
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
                               bool enablement);

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v12_0.h
index fa2e8cb07967..02de3b6199e5 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
@@ -60,7 +60,5 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_cont=
ext *smu, enum smu_clk_

 int smu_v12_0_set_driver_table_location(struct smu_context *smu);

-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
;
-
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f0cc4de9ced5..45564a776e9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_co=
ntext *smu,
         if (ret)
                 return ret;

-       smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot;
@@ -2276,6 +2276,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_co=
ntext *smu,
         gpu_metrics->pcie_link_speed =3D
                         arcturus_get_current_pcie_link_speed(smu);

+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
         *table =3D (void *)gpu_metrics;

         return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f7f78daffd27..6e641f1513d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2314,7 +2314,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,

         mutex_unlock(&smu->metrics_lock);

-       smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);

         gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot;
@@ -2354,6 +2354,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,
         gpu_metrics->pcie_link_speed =3D
                         smu_v11_0_get_current_pcie_link_speed(smu);

+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
         *table =3D (void *)gpu_metrics;

         return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e3ba40d9f83f..34add528d83c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2950,7 +2950,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,
         if (ret)
                 return ret;

-       smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);

         gpu_metrics->temperature_edge =3D metrics->TemperatureEdge;
         gpu_metrics->temperature_hotspot =3D metrics->TemperatureHotspot;
@@ -2993,6 +2993,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,
         gpu_metrics->pcie_link_speed =3D
                         smu_v11_0_get_current_pcie_link_speed(smu);

+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
         *table =3D (void *)gpu_metrics;

         return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index cf6176afd4d5..36d651342a76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2021,30 +2021,6 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu=
_context *smu)
         return link_speed[speed_level];
 }

-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
-{
-       memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
-
-       gpu_metrics->common_header.structure_size =3D
-                               sizeof(struct gpu_metrics_v1_0);
-       gpu_metrics->common_header.format_revision =3D 1;
-       gpu_metrics->common_header.content_revision =3D 0;
-
-       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
-}
-
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
-{
-       memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
-
-       gpu_metrics->common_header.structure_size =3D
-                               sizeof(struct gpu_metrics_v2_0);
-       gpu_metrics->common_header.format_revision =3D 2;
-       gpu_metrics->common_header.content_revision =3D 0;
-
-       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
-}
-
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
                               bool enablement)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f0f06ef47b9e..42271e80c0b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1406,7 +1406,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_con=
text *smu,
         if (ret)
                 return ret;

-       smu_v11_0_init_gpu_metrics_v2_0(gpu_metrics);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);

         gpu_metrics->temperature_gfx =3D metrics.GfxTemperature;
         gpu_metrics->temperature_soc =3D metrics.SocTemperature;
@@ -1442,6 +1442,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_con=
text *smu,

         gpu_metrics->throttle_status =3D metrics.ThrottlerStatus;

+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
         *table =3D (void *)gpu_metrics;

         return sizeof(struct gpu_metrics_v2_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..f2d57900e93e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1257,7 +1257,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_cont=
ext *smu,
         if (ret)
                 return ret;

-       smu_v12_0_init_gpu_metrics_v2_0(gpu_metrics);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);

         gpu_metrics->temperature_gfx =3D metrics.GfxTemperature;
         gpu_metrics->temperature_soc =3D metrics.SocTemperature;
@@ -1298,6 +1298,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_cont=
ext *smu,

         gpu_metrics->fan_pwm =3D metrics.FanPwm;

+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
         *table =3D (void *)gpu_metrics;

         return sizeof(struct gpu_metrics_v2_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c
index 06abf2a7ce9e..6cc4855c8a37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -278,15 +278,3 @@ int smu_v12_0_set_driver_table_location(struct smu_con=
text *smu)

         return ret;
 }
-
-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
-{
-       memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
-
-       gpu_metrics->common_header.structure_size =3D
-                               sizeof(struct gpu_metrics_v2_0);
-       gpu_metrics->common_header.format_revision =3D 2;
-       gpu_metrics->common_header.content_revision =3D 0;
-
-       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index d9ecaa04d14e..38bcbe46e809 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -746,3 +746,28 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,

         return ret;
 }
+
+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
)
+{
+       struct metrics_table_header *header =3D (struct metrics_table_heade=
r *)table;
+
+       header->format_revision =3D frev;
+       header->content_revision =3D crev;
+
+#define METRICS_VERSION(a, b)  ((a << 16) | b )
+
+       switch (METRICS_VERSION(frev, crev)) {
+       case METRICS_VERSION(1, 0):
+               header->structure_size =3D sizeof(struct gpu_metrics_v1_0);
+               break;
+       case METRICS_VERSION(2, 0):
+               header->structure_size =3D sizeof(struct gpu_metrics_v2_0);
+               break;
+       default:
+               break;
+       }
+
+#undef METRICS_VERSION
+
+       memset(header, 0xFF, header->structure_size);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 08ccf2d3257c..c69250185575 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -97,5 +97,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
                               void *metrics_table,
                               bool bypass_cache);

+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
);
+
 #endif
 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ce8c80bc1d7f845d896b808d8c826513f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637479414187156203%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DjZYPEDDsNnX4cznjfDlgGaXBIDsyqOLZCkIg%2FKAUNpE%3D&amp;reserved=3D0

--_000_MN2PR12MB448883B167602CD19A5A381FF7B39MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Kevin Wang &lt;kevin1.wang@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 3, 2021 4:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm/swsmu: unify the init soft gpu metrics f=
unction</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">the soft gpu metrics is not asic related data stru=
cture.<br>
unify them to reduce duplicate code.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v12_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |&nbsp; 4 ++-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; |&nbsp; 4 ++-=
<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; |&nbsp; 4 ++-=
<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp; | 24 ---=
---------------<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; |&nbsp; 4 ++-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp; |&nbsp; 4 ++-=
<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c&nbsp;&nbsp;&nbsp; | 12 ---=
------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 25 +++++++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;11 files changed, 42 insertions(+), 47 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v11_0.h<br>
index c7d57e9555cc..e49c2d08a983 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
@@ -272,10 +272,6 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct=
 smu_context *smu);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);<b=
r>
&nbsp;<br>
-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)=
;<br>
-<br>
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
;<br>
-<br>
&nbsp;int smu_v11_0_gfx_ulv_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enablement);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v12_0.h<br>
index fa2e8cb07967..02de3b6199e5 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h<br>
@@ -60,7 +60,5 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_cont=
ext *smu, enum smu_clk_<br>
&nbsp;<br>
&nbsp;int smu_v12_0_set_driver_table_location(struct smu_context *smu);<br>
&nbsp;<br>
-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
;<br>
-<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index f0cc4de9ced5..45564a776e9b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_init_gpu_metrics_v1_0(gpu_m=
etrics);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot;<br>
@@ -2276,6 +2276,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_=
speed =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arctu=
rus_get_current_pcie_link_speed(smu);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v1_0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index f7f78daffd27..6e641f1513d8 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -2314,7 +2314,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
metrics_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_init_gpu_metrics_v1_0(gpu_m=
etrics);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics.TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics.TemperatureHotspot;<br>
@@ -2354,6 +2354,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_=
speed =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v=
11_0_get_current_pcie_link_speed(smu);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v1_0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index e3ba40d9f83f..34add528d83c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -2950,7 +2950,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_init_gpu_metrics_v1_0(gpu_m=
etrics);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 1, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_edge =3D metrics-&gt;TemperatureEdge;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D metrics-&gt;TemperatureHotspot;<br>
@@ -2993,6 +2993,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_=
speed =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v=
11_0_get_current_pcie_link_speed(smu);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v1_0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index cf6176afd4d5..36d651342a76 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -2021,30 +2021,6 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return link_speed[speed_le=
vel];<br>
&nbsp;}<br>
&nbsp;<br>
-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)=
<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(gpu_metrics, 0xFF, sizeof(stru=
ct gpu_metrics_v1_0));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.structu=
re_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct gpu_metrics_v1_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.format_=
revision =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.content=
_revision =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
-}<br>
-<br>
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(gpu_metrics, 0xFF, sizeof(stru=
ct gpu_metrics_v2_0));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.structu=
re_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct gpu_metrics_v2_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.format_=
revision =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.content=
_revision =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
-}<br>
-<br>
&nbsp;int smu_v11_0_gfx_ulv_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enablement)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index f0f06ef47b9e..42271e80c0b4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1406,7 +1406,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_init_gpu_metrics_v2_0(gpu_m=
etrics);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 2, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_gfx =3D metrics.GfxTemperature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_soc =3D metrics.SocTemperature;<br>
@@ -1442,6 +1442,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_con=
text *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;throttle_s=
tatus =3D metrics.ThrottlerStatus;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v2_0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index ab15570305f7..f2d57900e93e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -1257,7 +1257,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v12_0_init_gpu_metrics_v2_0(gpu_m=
etrics);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metrics(gpu_met=
rics, 2, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_gfx =3D metrics.GfxTemperature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_soc =3D metrics.SocTemperature;<br>
@@ -1298,6 +1298,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;fan_pwm =
=3D metrics.FanPwm;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table =3D (void *)gpu_met=
rics;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v2_0);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
index 06abf2a7ce9e..6cc4855c8a37 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
@@ -278,15 +278,3 @@ int smu_v12_0_set_driver_table_location(struct smu_con=
text *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-<br>
-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)=
<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(gpu_metrics, 0xFF, sizeof(stru=
ct gpu_metrics_v2_0));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.structu=
re_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct gpu_metrics_v2_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.format_=
revision =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;common_header.content=
_revision =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clock_counter =
=3D ktime_get_boottime_ns();<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index d9ecaa04d14e..38bcbe46e809 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -746,3 +746,28 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
+<br>
+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct metrics_table_header *header =
=3D (struct metrics_table_header *)table;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header-&gt;format_revision =3D frev;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header-&gt;content_revision =3D crev;=
<br>
+<br>
+#define METRICS_VERSION(a, b)&nbsp; ((a &lt;&lt; 16) | b )<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (METRICS_VERSION(frev, crev)) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header-&gt;structure_size =3D sizeof(struct gpu_metrics_v1_0);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header-&gt;structure_size =3D sizeof(struct gpu_metrics_v2_0);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+#undef METRICS_VERSION<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(header, 0xFF, header-&gt;struc=
ture_size);<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index 08ccf2d3257c..c69250185575 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -97,5 +97,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *metrics_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bypass_cache);<br>
&nbsp;<br>
+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
);<br>
+<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ce8c80bc1d7f845d896b808d8c826513f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479414187156203%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DjZYPEDDsNnX4cznjfDlgGaXBIDsyqOLZCkIg%2FKAUNpE%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Ce8c80bc1d7f845d896b808d8c82651=
3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479414187156203%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DjZYPEDDsNnX4cznjfDlgGaXBIDsyqOLZCkIg%2FKAUNp=
E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448883B167602CD19A5A381FF7B39MN2PR12MB4488namp_--

--===============1385100258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1385100258==--
