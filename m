Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B420C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 13:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F298210E158;
	Wed, 17 May 2023 13:03:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B05E10E158
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 13:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV+B45t5Co/gpi0FRatE0/SVr30mHv5aFd5e6FCh3fpEKbiXATy9aT+PlEsNYXunha4e5Xb+dSBNaoEXWv8yP6LLFe3Fmiw1yPxGYYY/mB3mlxaKcpSQ7yR9IIzu8ajzh1AtPrrj63lyFqjzoYUC9yGLRI/Oe+x+HlZbh9UC9f2l5ysaLiZ2WcUrM3n2julZgSzr08+lX1nzJH0Eu2sGRfVxe9oswooMKiyh3klDiNYt8btoz3QVGUPvjM3puS0utj3W0/49ApxZFsX2vc1egOh+cqlMJjsyYsAoOkqtSQgCgOdD9OtdWtmMaDjTXsN7yzAlVfDKr8IDOkuwg2vhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+3h4PfZa/i3VF1Gj5E6W5KVd4tpmmBWFaQoM/BkW0U=;
 b=JB9iPoeotOFxlMmiI1j+9pRRhoqGfX50Z1qbndSat2t3L6VzI028ok5SDcOv/MxeubUZJ8TxtdXNLeakOGNvsuLriQX1lSRUWh4ue7gXCpwus0TcbfLWJ97OEYN+0aBZpDctHbjibP/wx20zySfaIuD84jyQkbD/OEm8kWMvD+eMpSPhuuML/W7BcA4lTWKagNq8ypK+eLAP511nKXSbjpIV06NueZyJAMpOK1JoE/ApORYWBUmF3qvOmmYEgJCuuZl8lW9HZ5SP3JaCqiSPZeCo2VpPIZ8zvPeprm8waEoPofRcTw1nl7T7H1YcgRHWzgapJNnr3pfO/DSZUdTHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+3h4PfZa/i3VF1Gj5E6W5KVd4tpmmBWFaQoM/BkW0U=;
 b=5WptRh2WnDL39JwVPz8RIkg181YdHVR53mZjBRWz8SnAJBR6Qk4Sd9rcnHZfMnADVKJ80lin51e37q87+wkgBto6RlGr5YZapqTig2jNbflZYYH5wqx54E+JmD8USXDeTrJeMi5VY9HACfN1RThmjj/XLaYsnaFkCONo5KQRuIg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:03:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 13:03:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "Liu01, Tong (Esther)"
 <Tong.Liu01@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Index: AQHZh9tya+URfSV690e2v8aW47A4w69eAYEAgABuqho=
Date: Wed, 17 May 2023 13:03:50 +0000
Message-ID: <BL1PR12MB51442AC67B6287D998EE55D1F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230516094716.323715-1-Tong.Liu01@amd.com>
 <DM4PR12MB50721544D0305ED7527FED95E17E9@DM4PR12MB5072.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB50721544D0305ED7527FED95E17E9@DM4PR12MB5072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T13:03:50.317Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4330:EE_
x-ms-office365-filtering-correlation-id: b5bbdacf-d781-475b-7a55-08db56d728ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoxj3f/1wzBPcbSlHH5F2PmPoINnHktAmuMmlYT4w5zjZo9qYOmGZXiMDGhbjyz1ct+ufzpyS3kIMloIm24tt7TzwHryGoTItEpZY0m4Ga67t+bbj2JNEeMXKq9uWs5UjY7Rktw9y4Ybk32FzkxQmu+395MqfnN8iDzdICMsgIhvjt1CCLcWnPIdLpxMytA+Qb7vwHZMl6fFoyv4ghnYYpwl+29IjpMldUE9Ye8oe5011Q1RgNeYBGURKnsjcV++55mC792z/jqpPtbtdF0g26kBVfKfHPiwP3/xVMVlqB0TmKlRnIuNSCWZ85kqE1o//lnD+mFyH5OlfwjIepsAEmj3VZVgkCy9Boaj9dGsTCyiUo7MKZr0+3InJCi6FsHQC1NPY+6mVzoC0wMujPFyyNTlPC7WnojOFWsjao3MvPGfy6tywUeeIP7IUmt5weita/zhyXXMbqW6y0r6vAPQBUPEb8nJ/Zt683rAEgwdK9NJsJBwMJMC4qTxaeH/v9oBQjNkxyV4yQzgokTh5Yc1DPhdsRVXZg00G+WCf+1cHQIP1qZPNCtCcVgWeMizMmH56jMYjK4hq7Q+rtu9V5rfgXksvIInNg0hKzbEDFT7AxqHzTVpXTpmPwf5UN8rFo32
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(84040400005)(451199021)(52536014)(5660300002)(86362001)(8936002)(8676002)(66556008)(83380400001)(6506007)(9686003)(53546011)(26005)(38100700002)(186003)(122000001)(38070700005)(7696005)(478600001)(71200400001)(33656002)(110136005)(55016003)(316002)(66446008)(41300700001)(66946007)(54906003)(66476007)(76116006)(64756008)(4326008)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ts4bGDMVZ7F7ZUaCnDlqzgdRr7xsfuaHoqo9KZ5k5qLIMyviHcCiTFl5enQb?=
 =?us-ascii?Q?VhGEVYUufZiiHrME5AFyUANPeu7/jO7BANzLX3FLOVxHMX8ozP2o0OviMZqW?=
 =?us-ascii?Q?/4gzs7qa/QKiCf/J33uu0MAOYfpqoPE2iY1lJlsyV836yOeFA8zM6BwzSI4O?=
 =?us-ascii?Q?HHqgv4f7H0UdbI1D41r07PiT+sc/E58J6pzhICrCRqwrfQaWvIGfEJCsRvS6?=
 =?us-ascii?Q?+kWMUVazGaNQgTf+lOjRHPQ+FVLd+b9TFEQWgkexzTsGGNZul4hXZqfC1n3a?=
 =?us-ascii?Q?E1dpJbGxSWUdXoShADklMvtMQm7txRuCU9XLz4drImhpeE7U94ExXylbJHBO?=
 =?us-ascii?Q?Dm+pzJziXxLZOogm7kkbWOxB7KB1622KrMIAkk7O/pXqcsgg8qS9v1DNY/VL?=
 =?us-ascii?Q?/MilLMCaBbqgKGFMRgH4KeBSLMByhn5Mm65GJ+NkUV+UnswMMPn21Qig9Lgu?=
 =?us-ascii?Q?gUvvLPgxWvMMLYKr8ymFHyfxkufltMoCNZG+fdcR/WcJoQQ/if4f2jWAWbvH?=
 =?us-ascii?Q?vzUIPWipmZ0Je4MgX7nbDw5IPTBKSNHwedkYVdhLscs5ltA6ncApzazvJ+kN?=
 =?us-ascii?Q?T/j8LgCp77kADlrlSl9zIEDWRgLCBT2SEmNzoiHGWoGv8ObEVbxmzF/si2Uj?=
 =?us-ascii?Q?hOlVOrkhhSkGy+8yqgWCUhRbzfnF5ybPIwp+jf3qQwKQ1B/XqJRe7JGEb4jj?=
 =?us-ascii?Q?0+bNxD2r6KyvuXGiHOL4fK6w1QNGLfBx9Cw4eyjgK2dPpXyTtq7IROTS/yTu?=
 =?us-ascii?Q?48LSDXu6hJt5v3bSJmheWptRJQdI7msGfb1TgVFd1YWyibv4MNLa5oGtnhlb?=
 =?us-ascii?Q?v9fhemAiOJFCizN8ikZUryfWRs6k6eMT18tbpa0PGUf7kZypO/ST1kw3xNUk?=
 =?us-ascii?Q?wDjvm4Mh/GVCPqSXdHavCBEl2hzVUWgWFNDkOwc6TDeKaM9PSB9yosXoichL?=
 =?us-ascii?Q?CmbTjH/4g9x6L/RTmbpOwI+1UDMsAdTzhVt6Zgihb0fxziaNfAKEP3e0CvkV?=
 =?us-ascii?Q?31z2tLjmQ9jBl9t//K97AxanwsGQm81SJVVCczzs/3nT4GSJRtDKjTg2AR5m?=
 =?us-ascii?Q?Pfur29UhFSBzQPa5iay0jLLAMltPk+v6cv+HDwUs/7bI24sIYwT5Nz5/94+o?=
 =?us-ascii?Q?7rUSK9duWK6MyoS2G2YS14JTD38CQqdcUNFShJZfxJSX8P29O35SSMeHxp2x?=
 =?us-ascii?Q?lL9LbmMF6DuFNMn/gbhfB3GzWVV1yjNrPKfoARBuKlXMbtDEmG7r9bUjJU23?=
 =?us-ascii?Q?VaDvyu31XnAc6ug5q2dFOa1933MQvFWx82IxmrbkrysCBgxezrBYF9eE5bo/?=
 =?us-ascii?Q?vZNR/ECet8NyHkGJAjwyWrWX6Myf4ZSt2ppyYNrbEfQ8h4nDmMLoiOE5FTvy?=
 =?us-ascii?Q?IQ2ygtV9E60VK6Yc/7ctRCm2nFBw3a0CHIBcWZrKOhvflIQL9kDxHrwQSYzY?=
 =?us-ascii?Q?14FT4qi1vMLq0Zc+s43QheVGZ7DODvTpV7tmwjU/aaqlUb4mf1bUuObF7Km9?=
 =?us-ascii?Q?u9hh4POctVGWv6dqOVOKOkKgc1lMvxTy4LM/rFXemeIrEIeR/s/3vW+Suxh2?=
 =?us-ascii?Q?B4YXEEBlhj2n99OPPug=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442AC67B6287D998EE55D1F77E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bbdacf-d781-475b-7a55-08db56d728ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 13:03:50.8444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCi/vP/lK7rb+PVDom1QYtqiJobydch4IVIk30ND22lS0X/lXbBvuoqSR5DAHiUryd7pIHRg9mpsJ8V5rIJ0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51442AC67B6287D998EE55D1F77E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Assuming there are no issues resulting from the re-ordering of the function=
 calls, it looks fine to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Horace <Horace.Chen@amd.com>
Sent: Wednesday, May 17, 2023 2:27 AM
To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; K=
oenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>=
; Kevin Wang <Kevin1.Wang@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; L=
iu01, Tong (Esther) <Tong.Liu01@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough=
 case

[AMD Official Use Only - General]

Hi Alex,

Can you help review this patch?
Currently on passthrough, GPU is also on the root bus but it is not APU. Cu=
rrent driver regard it as APU and limit the PCIE link speed to gen2. It cau=
ses some failure on some OCL benchmark.

Thanks & Regards,
Horace.

-----Original Message-----
From: Tong Liu01 <Tong.Liu01@amd.com>
Sent: Tuesday, May 16, 2023 5:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Kevin Wang <Kevin1.Wang@amd.com>; Cha=
ng, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough cas=
e

[why]
Passthrough case is treated as root bus and pcie_gen_mask is set as default=
 value that does not support GEN 3 and GEN 4 for PCIe link speed. So PCIe l=
ink speed will be downgraded at smu hw init in passthrough condition

[how]
Move detect virtualization before get pcie info and check if it is passthro=
ugh case when set pcie_gen_mask

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a9d9bbe8586b..255b0014b6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,6 +3813,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base=
);
        DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);

+       /* detect hw virtualization here */
+       amdgpu_detect_virtualization(adev);
+
        amdgpu_device_get_pcie_info(adev);

        if (amdgpu_mcbp)
@@ -3827,9 +3830,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (!adev->reset_domain)
                return -ENOMEM;

-       /* detect hw virtualization here */
-       amdgpu_detect_virtualization(adev);
-
        r =3D amdgpu_device_get_job_timeout_settings(adev);
        if (r) {
                dev_err(adev->dev, "invalid lockup_timeout parameter syntax=
\n"); @@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie_info(struct =
amdgpu_device *adev)
                adev->pm.pcie_mlw_mask =3D amdgpu_pcie_lane_cap;

        /* covers APUs as well */
-       if (pci_is_root_bus(adev->pdev->bus)) {
+       if (pci_is_root_bus(adev->pdev->bus) && !amdgpu_passthrough(adev)) =
{
                if (adev->pm.pcie_gen_mask =3D=3D 0)
                        adev->pm.pcie_gen_mask =3D AMDGPU_DEFAULT_PCIE_GEN_=
MASK;
                if (adev->pm.pcie_mlw_mask =3D=3D 0)
--
2.34.1


--_000_BL1PR12MB51442AC67B6287D998EE55D1F77E9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Assuming there are no issues resulting from the re-ordering of the function=
 calls, it looks fine to me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Horace &lt;Hora=
ce.Chen@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2023 2:27 AM<br>
<b>To:</b> Liu01, Tong (Esther) &lt;Tong.Liu01@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Tuikov, Luben &lt;Luben.Tu=
ikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deuch=
er, Alexander &lt;Alexander.Deucher@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@a=
md.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Monk
 &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kevin Wang=
 &lt;Kevin1.Wang@amd.com&gt;; Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;; L=
iu01, Tong (Esther) &lt;Tong.Liu01@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in pass=
through case</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - General]<br>
<br>
Hi Alex,<br>
<br>
Can you help review this patch?<br>
Currently on passthrough, GPU is also on the root bus but it is not APU. Cu=
rrent driver regard it as APU and limit the PCIE link speed to gen2. It cau=
ses some failure on some OCL benchmark.<br>
<br>
Thanks &amp; Regards,<br>
Horace.<br>
<br>
-----Original Message-----<br>
From: Tong Liu01 &lt;Tong.Liu01@amd.com&gt;<br>
Sent: Tuesday, May 16, 2023 5:47 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Quan, Evan &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.=
com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;=
Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.=
com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;;
 Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; =
Kevin Wang &lt;Kevin1.Wang@amd.com&gt;; Chang, HaiJun &lt;HaiJun.Chang@amd.=
com&gt;; Liu01, Tong (Esther) &lt;Tong.Liu01@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough cas=
e<br>
<br>
[why]<br>
Passthrough case is treated as root bus and pcie_gen_mask is set as default=
 value that does not support GEN 3 and GEN 4 for PCIe link speed. So PCIe l=
ink speed will be downgraded at smu hw init in passthrough condition<br>
<br>
[how]<br>
Move detect virtualization before get pcie info and check if it is passthro=
ugh case when set pcie_gen_mask<br>
<br>
Signed-off-by: Tong Liu01 &lt;Tong.Liu01@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a9d9bbe8586b..255b0014b6a3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3813,6 +3813,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;register mmio bas=
e: 0x%08X\n&quot;, (uint32_t)adev-&gt;rmmio_base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;register mmio siz=
e: %u\n&quot;, (unsigned)adev-&gt;rmmio_size);<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* detect hw virtualization here */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_detect_virtualization(adev);<b=
r>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_mcbp)<br>
@@ -3827,9 +3830,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;reset_domain)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* detect hw virtualization here */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_detect_virtualization(adev);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_get_job_time=
out_settings(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid lockup_timeout paramete=
r syntax\n&quot;); @@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie=
_info(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;pm.pcie_mlw_mask =3D amdgpu_pcie_lane_cap;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* covers APUs as well */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_is_root_bus(adev-&gt;pdev-&gt=
;bus) &amp;&amp; !amdgpu_passthrough(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm=
.pcie_gen_mask =3D AMDGPU_DEFAULT_PCIE_GEN_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_mlw_mask =3D=3D 0)<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442AC67B6287D998EE55D1F77E9BL1PR12MB5144namp_--
