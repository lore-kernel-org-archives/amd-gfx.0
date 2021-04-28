Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F6C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 13:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786C9613B8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786C9613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA35F890A9;
	Wed, 28 Apr 2021 13:19:03 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AF8890A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 13:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YILoCAKJ/U4re+sP73cg9L249qqgy0/VblmB8uDZYeWohK0DJ+/1U4Fk9ZI+EyBigagbay2E/fl1l7upQjLQTPxqOSQK5NJ8TSU50EVFmMiXCogEyXCtrrn41dr7bvjqTGOXrOuIqRGj4pwNRh0wvILj3z3TUhh1Q5afAnd/Blt0vWOTzrVmWMCuMqJvkMJZPCX4TOPc2QrH5G3lljQTl9/HDRCRjDHvX/0PrxK1wKcQME+aA7atzmoM6ho86mHyWMCfGhdnzxjuCvg3MnqCvXU3vBNiXg8fMse5ElGSMbn4KjNcOFSNR+WjGRuxgJfVZOe1s0f0K/V5h3+f+bzB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmGXgu6RhmVA17F3ZzinxlPQQKlYLE/ZIUyVM88kH90=;
 b=HESDlS60Pgq2COyqBV3DMcDgGfq8FDEsKrGeot3h16K8cCTM96phTNhYxMzwUNxvq2uq7KWZTt8dZ7uCUB6phfXSx6Y8N8rwuBcOUzVL2tpAXd7qz/QyWdmKqU8Oq1Q/JTc8xASrHh04XAwkcNJMj7obkOusPU7R4W+39sWKLLZNE0/GRskPhlOuiPwPAFPiwV05AhkJOeycGhVaFFXIxD7UNI18i7NqtYH4TRgh69T3pKIvpJYl8hMDZQKKbhyxPjXukzBWzmgtzOul9lVBmbmKX+M7BqK1uj1sUZcyFjCwqwg0kje1IlsBTyacg8vAqxEM2KgpQx7MsMBltZhbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmGXgu6RhmVA17F3ZzinxlPQQKlYLE/ZIUyVM88kH90=;
 b=BBQF7d1jjeVMnOcT3uy+JRkJ4VJWeAjj8ikDOGElZ730YVkBbIqNoJ20m6U+YH6Ia4ElTQHFukcV0bSjhAgEDKtfNxJmhMVZtrfkkinPE9kySFO54mCbLkVVF/lty5D/UEX04JuXAb66rfcyehZcQaOJm2VKsLBV3xKxomvBHWk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 13:19:00 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Wed, 28 Apr 2021
 13:19:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/pm: new gpu_metrics structure for pmfw
 attached timestamp
Thread-Topic: [PATCH 1/2] drm/amd/pm: new gpu_metrics structure for pmfw
 attached timestamp
Thread-Index: AQHXO8/iHEFZjTZw7k2UDOjFVxAP6qrJ6lGQ
Date: Wed, 28 Apr 2021 13:18:59 +0000
Message-ID: <MN2PR12MB44880375E9CEB443800E093FF7409@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210428014305.1736511-1-evan.quan@amd.com>
In-Reply-To: <20210428014305.1736511-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-28T13:18:59.117Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddcaf232-3d37-4af0-628e-08d90a482f83
x-ms-traffictypediagnostic: MN2PR12MB4488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44887B36606C2409096514EDF7409@MN2PR12MB4488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5rUdMzbrfpg7Im4rXRhB5WjxGK0ubbHButc+lcSM5gbruDJqADwMo0zGa+SdEiyimZdEUPinRMdkGvWh+jMIvy8SlwYgYvS+/R5rXGFCXP/FjbgKHfgLBtPs2vEXJBtuKPIbH9Zp9gqK+Yhki82jQ4glNn+avIG3eDjz+VKebGMP36xhmd2dk2FlVm/YkzpAZA5b5NG5PadM/H0208r9xNPwWBYL4SFxBS5dIQQW2PZG/siTgb3ABhEmMVAWJTRyfIGq9AmbZ6jSx6ksSPCSdWgL+PKNFKCzV8ahpVLBSTp89nO9jIVdPCTSrRUvXzGM8uF7JLtYSyP3H0mZZvmCapefqXg3c8lOPm4dIzz/Lf3r4s438GfrAnFX/rnvE2bdLkkWTxE9IOT/xFBbzNmAgMbuECXWqtm8sbSwHDsurGMexNEeOuT9VMu+4kggk1QTrZWCP5xUJPprYPlUE2RMRCcxWLq5VbuKwpJFFED56t2gDamiDnDF7BEo761KHnb4oICjA0x+k2Iy6T+44/IuhHeX8AB6tWb0wkKteM8AiTJQyf6rhujacmVXElNrE8ILRaSr+9rTfmwXPjXxZIa1P++X8Grzp+L4Qfm89r8w0Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(86362001)(8936002)(5660300002)(8676002)(478600001)(7696005)(83380400001)(33656002)(316002)(9686003)(64756008)(4326008)(2906002)(71200400001)(110136005)(38100700002)(55016002)(76116006)(66946007)(186003)(66556008)(26005)(52536014)(19627405001)(53546011)(122000001)(66446008)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dv8khwl4VwtrtVRequPyzWTMnv4Mj05C6yoUu/qI9gFoh4svV89GaDT+gdpx?=
 =?us-ascii?Q?COtWreERmoLo61rPtjpx1mmiXcdEBR8n9ACg0OA5U46oXlVNBVpUms03gOcm?=
 =?us-ascii?Q?SXQpGyfdV02v82pxUITglngUYru9bhKJgeQvVbS10txchGrfmGwofk9F3Q0Q?=
 =?us-ascii?Q?Vzx4cga+CUnBpqcAE22fj5U7MB5ocBrFtjWpTsCxV+7ltZ/KQDQrDyBZ86+r?=
 =?us-ascii?Q?nOsoX9Jw3tyZw8HyWIRDffe3J1BKoLXwc0MrMxeb1IsiFBsuUN3cJNvguiMZ?=
 =?us-ascii?Q?fErkUHZbczPJ+czGJafvrF1iFVn/WL2xQrX8/H0IuqQ9nQG0kl691EQHGh51?=
 =?us-ascii?Q?HfErvl5PTeqP15X6rxe+hcqtf0kR+Mjtj1D6iqkaaLACqcqBjgdB3htMo/SK?=
 =?us-ascii?Q?HFK3TrvUO0QusoM5jPS5DAsetPW7tWCA/bXZzMyUTqhd6E9OhsdoAzm1x7SJ?=
 =?us-ascii?Q?3LQjx/wYfYntO8A852FPPBW9PcyI0biXedexP2YCigTqHRW2WnwMpMYJkJe9?=
 =?us-ascii?Q?dIlDEOvESoON4rr3WHpGkjOxaz57oHR3X36yWDitmksUO7/OxuuVQWsY8zQi?=
 =?us-ascii?Q?E5J56JadrNxHicHmZp8Avq9YW6oKz8Jb22a+N1vdbo3LnIuDiTclvEVpwX7z?=
 =?us-ascii?Q?AWcBq5TgQ+7vblh9cLAyTzxu3BnPXZjejiHOU9Q+g4F06eCjYZ5c4S9uGOxa?=
 =?us-ascii?Q?K8tY6BYPJR9I9iecS+shGl2roAGvrTjRq4XeVo0iGWfAdrPwoP3bipa/kQxg?=
 =?us-ascii?Q?y+KQXpCAA53Mgq6G6ybft12YT47QRpkamlimvB1WMWXVk43WQAkawDBZSb5n?=
 =?us-ascii?Q?+Dn+EDnta+cPdrsVbC8VW0tuNNrF1dws50q11A7tazdykzmzSMc2EAoBfYLv?=
 =?us-ascii?Q?iQAehhaE/7W0e3ssdPbBu9emDfvB/wSlrCXhhopHJAP6LvUDd3GdcyoM8d11?=
 =?us-ascii?Q?cmqamOa/o94vzem7F8NI8paWWz4mtIo6EKP6V7jOt5t7Lfx1YJvDBrgq/uKA?=
 =?us-ascii?Q?BqZVsxv6HWrEorSPrFN1Xln3M9KH74FkxRqGwQS1JC2MASqp6Z7QNgv7hOrU?=
 =?us-ascii?Q?va7U2cwadwXTwtOIVY/27NumSYtd0toTKtH2DyZVeWWXPeR5k9DiVAkuppIO?=
 =?us-ascii?Q?PDTqaOVoKLTO98nK5tu0Q4601i4ixqqB/2qO/D0mP9F+89hvhNAXz78i19iB?=
 =?us-ascii?Q?vsTkjrktwkpNx7LC4KCDK4+3VvQPw3/W9r74yrpnJ6RWbbQOFS/37HfhnDTi?=
 =?us-ascii?Q?R6tHMwLY6F5Oe4YQrvbTfpYKs089EmRb4g/CoiEtFsFmS1KDX2xcwoW4Cb1m?=
 =?us-ascii?Q?WSG7rY1l8S1IqCl95v9ZFpUO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcaf232-3d37-4af0-628e-08d90a482f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 13:18:59.5790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pe3JYiiZKa4MZ3TymjPx6tZZiC2zDKumNWOmRtZctEj1T7KXXESVpz+ZhkzV6k90kJfFYgi8cItDO08kTWTaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Content-Type: multipart/mixed; boundary="===============1498120084=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1498120084==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880375E9CEB443800E093FF7409MN2PR12MB4488namp_"

--_000_MN2PR12MB44880375E9CEB443800E093FF7409MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Assuming the updated table it 64 bit aligned, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, April 27, 2021 9:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: new gpu_metrics structure for pmfw attache=
d timestamp

Supported by some latest ASICs.

Change-Id: I0bb26df87d10f1b356b5b9bf008a1422a8fe60d9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 71018a5fb0b0..f6818dd84145 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -474,6 +474,68 @@ struct gpu_metrics_v1_1 {
         uint16_t                        temperature_hbm[NUM_HBM_INSTANCES]=
;
 };

+struct gpu_metrics_v1_2 {
+       struct metrics_table_header     common_header;
+
+       /* Temperature */
+       uint16_t                        temperature_edge;
+       uint16_t                        temperature_hotspot;
+       uint16_t                        temperature_mem;
+       uint16_t                        temperature_vrgfx;
+       uint16_t                        temperature_vrsoc;
+       uint16_t                        temperature_vrmem;
+
+       /* Utilization */
+       uint16_t                        average_gfx_activity;
+       uint16_t                        average_umc_activity; // memory con=
troller
+       uint16_t                        average_mm_activity; // UVD or VCN
+
+       /* Power/Energy */
+       uint16_t                        average_socket_power;
+       uint64_t                        energy_accumulator;
+
+       /* Driver attached timestamp (in ns) */
+       uint64_t                        system_clock_counter;
+
+       /* Average clocks */
+       uint16_t                        average_gfxclk_frequency;
+       uint16_t                        average_socclk_frequency;
+       uint16_t                        average_uclk_frequency;
+       uint16_t                        average_vclk0_frequency;
+       uint16_t                        average_dclk0_frequency;
+       uint16_t                        average_vclk1_frequency;
+       uint16_t                        average_dclk1_frequency;
+
+       /* Current clocks */
+       uint16_t                        current_gfxclk;
+       uint16_t                        current_socclk;
+       uint16_t                        current_uclk;
+       uint16_t                        current_vclk0;
+       uint16_t                        current_dclk0;
+       uint16_t                        current_vclk1;
+       uint16_t                        current_dclk1;
+
+       /* Throttle status */
+       uint32_t                        throttle_status;
+
+       /* Fans */
+       uint16_t                        current_fan_speed;
+
+       /* Link width/speed */
+       uint16_t                        pcie_link_width;
+       uint16_t                        pcie_link_speed; // in 0.1 GT/s
+
+       uint16_t                        padding;
+
+       uint32_t                        gfx_activity_acc;
+       uint32_t                        mem_activity_acc;
+
+       uint16_t                        temperature_hbm[NUM_HBM_INSTANCES];
+
+       /* PMFW attached timestamp (10ns resolution) */
+       uint64_t                        firmware_timestamp;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
--
2.29.0


--_000_MN2PR12MB44880375E9CEB443800E093FF7409MN2PR12MB4488namp_
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
: 12pt; color: rgb(0, 0, 0);">
Assuming the updated table it 64 bit aligned, the series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 27, 2021 9:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/pm: new gpu_metrics structure for pmfw =
attached timestamp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Supported by some latest ASICs.<br>
<br>
Change-Id: I0bb26df87d10f1b356b5b9bf008a1422a8fe60d9<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; | 62 +++=
++++++++++++++++<br>
&nbsp;1 file changed, 62 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 71018a5fb0b0..f6818dd84145 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -474,6 +474,68 @@ struct gpu_metrics_v1_1 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_hbm[NUM_HBM_INSTA=
NCES];<br>
&nbsp;};<br>
&nbsp;<br>
+struct gpu_metrics_v1_2 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct metrics_table_header&nbsp;&nbs=
p;&nbsp;&nbsp; common_header;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Temperature */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_edge;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_hotspot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_mem;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_vrgfx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_vrsoc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_vrmem;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Utilization */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_gfx_activity;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_umc_activity; // memory controll=
er<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_mm_activity; // UVD or VCN<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Power/Energy */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_socket_power;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; energy_accumulator;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Driver attached timestamp (in ns) =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_clock_counter;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Average clocks */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_gfxclk_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_socclk_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_uclk_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_vclk0_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_dclk0_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_vclk1_frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; average_dclk1_frequency;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Current clocks */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_gfxclk;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_socclk;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_uclk;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_vclk0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_dclk0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_vclk1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_dclk1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Throttle status */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttle_status;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fans */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current_fan_speed;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Link width/speed */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_link_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_link_speed; // in 0.1 GT/s<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; padding;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_activity_acc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_activity_acc;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature_hbm[NUM_HBM_INSTANCES];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PMFW attached timestamp (10ns reso=
lution) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; firmware_timestamp;<br>
+};<br>
+<br>
&nbsp;/*<br>
&nbsp; * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.=
<br>
&nbsp; * Use gpu_metrics_v2_1 or later instead.<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880375E9CEB443800E093FF7409MN2PR12MB4488namp_--

--===============1498120084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1498120084==--
