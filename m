Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF376C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 15:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E6010F5F2;
	Fri,  9 Feb 2024 15:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODZX7zd5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B6D10F5F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 15:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1bLFT6yP+ppRN1fTakSxA0wtN/4iGG5zb3NGzLys5rgFjUF09i0+itN7wz9wNoDmYSFYy/USBwE0oFa1KskgfvcCOY2Coe3VVZVs0n//wg3l41lK49Sjf1P60FdYvX/g3QM/p7oZQfKodKA2u5aQXkNoEjJcQL2qrfv9oApJMoL4far97eSNy1kRgGRl9xAXHn8wqdYLmotdZdHUh6XEIz+EGLGEHlzW+JjsMZMpRM/p4VCAyW8EzUKCdiHPQ4ygSMKN8lV4YNm7D/7NmU7H1TTi6gWMBlI32lawmKBE7gvJaZbBUa7/5Rb5Pr1Rojg+7+JY5rFsWN6i97SqWtnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNHLogyxMqYVGD/q5omOQqUeLuLdNykyOsIfA+A5Ojk=;
 b=mUVRHipbDuwrWOSDBjoRHjG9Ha2xZqQ1Dfl/fLPesxtfl5A0I+m71dQ6zr64AC/kIgFCfC8gHEOJID75A4NLuLP0Nt+i/sHApxsF7U8iMcksGTl3VwDI52CK+ZHK66MY33zTulVRKxImkdjeQ/HaiyquGAqGA2HndsdQqdl9V6LUHnNGcwh7BU8I/BMFMutzZwAOS0UqjNk+pYAui5Yf58fTBdpujAZlsWn1GxLRBsxPEc6nykJZUSFElX2tlrzsKzX3VQhUJ41zal108E3zCXZO4k4dG2hLUA7ptfS1f1KMpPopHYqIaSxxSRn1ggGAaf6PpxhDnc4rDAZ/XASj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNHLogyxMqYVGD/q5omOQqUeLuLdNykyOsIfA+A5Ojk=;
 b=ODZX7zd5m25mQns2TgZrkZylN7ZRekeZhbhiY9ZZfbjwR7f3FuGuKkomMFoDgepzIuJLADD7Q6BF+gTd3wKQNpwRzqvQa/tvscvehXqiAdYugXqsK23WB5yh0YkXfG6MYs0630sj0A8IXyL+296Mo8f1kLnaM10iEKJvsvJ4BoQ=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:20:35 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:20:34 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix possible buffer overflow in
 'find_dcfclk_for_voltage()'
Thread-Topic: [PATCH] drm/amd/display: Fix possible buffer overflow in
 'find_dcfclk_for_voltage()'
Thread-Index: AQHaWYHh+D/mM5ZVhkCb2lBgcUmqUrECIbOQ
Date: Fri, 9 Feb 2024 15:20:34 +0000
Message-ID: <CY8PR12MB819367D896F28D9FAA0CEF31894B2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b9945c25-c626-40a9-9e04-127f3ce94db9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-09T15:20:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA1PR12MB6307:EE_
x-ms-office365-filtering-correlation-id: a20c9fb6-c904-4f97-b0f7-08dc2982a9a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91WSJYx1DGP3wzWb7WD8qys9KkNtVnPNaEw0zH8inDQFWh6I3Qn0FZPS987Ix5fLIQEXi/lmstMKGs33IG4Ay4GSAcYBPMMZNx2IjQ/bgSrhGC1GycziPq19zRfen55SPILQoSNGTxjwFCMjG6AVjvNJSN00JEsy8B6YA8wqAIIb7as7JsgeQYULAIvb5hi45cfrOyGYRQySS/Jlc1VLoZvY3oyB8TnyAN+HHJ6TGCCGN8rOvtYdTyIru0CfE2UMkag6xRHs7QkyDxyrYq+zk1hSt/crqMTLvO2r58MchHyra/hY6sY4gsKGHZsFgWzilc42vyg67xfxiHBQW2n37OkD7W9gxWuYHAjyV9xpdTGkQ80tlQPRvWqdoqf/2obpJ9uBgXptIKsNo6gCnoM3SIuzSYDzo1RG/z8yt2BiEClgbCIBLXX0KLVRL8zH/vogMZMCYRzK7vY5Q/N5fkF6sJOS4UskveOzPIMNLvPpbFprt93JdJRCvMRy3WJ280PIE0ls0dhVQ9Jb2CdJtEA7aDVOBTDXQ0FC04sP56IKd8d5+40fONtew4IVETRsVxYn8FklkyrQXzsnBq0b6nqd/noDBNikPVMZMGEw8xn9CroSbtvzyYiYhonmZztA6ou8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(7696005)(53546011)(71200400001)(83380400001)(9686003)(2906002)(316002)(6636002)(26005)(110136005)(66946007)(76116006)(66556008)(66446008)(4326008)(66476007)(64756008)(5660300002)(8676002)(33656002)(38100700002)(8936002)(52536014)(38070700009)(122000001)(86362001)(6506007)(41300700001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d5H5niB/SDuLwgfTvDX6Ug+EYilPwajzaQSCVmpgfZPgK2Zl7AxOFW6lDdCR?=
 =?us-ascii?Q?Z4/eL64FG+0dYOpf/JgsPYYzWm8sWoy8Mn++AGlly44zOKWqXNdt0p1KXT+a?=
 =?us-ascii?Q?uspFvBM2Wz9AF49jGd9lQf+NyDEf9D1fyR6h8wtiOZ6Ul/EqlyNNss0Pp0Qt?=
 =?us-ascii?Q?OcQw8NohY0/EdwwGGY122QTHHG+yJuzRDh6A+T/XroB+lryy/OUp9AKEsUO7?=
 =?us-ascii?Q?CbvFVQ9gvG7vrool+eJawXky5ATNZOu43JoQptWOasuMZCNVXdPU+FvMHIdP?=
 =?us-ascii?Q?AVSMt9EmIHj6VaNiTCEcm1QGQTvbtU+BxVFYIDmtpiNjTjoKT4GW2ywX0PjC?=
 =?us-ascii?Q?UV/lyQWJR2rXnhhPvcDHiqNYkHh7R7GITgDY3omoxDCSvpBzsr830tNMNRjU?=
 =?us-ascii?Q?fa8mlsK6kc7OzNYoIJAWGBfcZLSdLA5mOxAUs77XTmp0tSiotx+yfYqdjHZb?=
 =?us-ascii?Q?8oZmkKzbr5nYfC4AD5giU519fXquy1BuyGDmbwNQp8wfVb2udYYEsAEsF3q5?=
 =?us-ascii?Q?IJ9Wj3gV8SHWggwaYfVdzB70ve8tQ/9P3txLPBmLbGDq77HE+qggDiD0sDm4?=
 =?us-ascii?Q?GTO+18XDsBy9fZQIFNoc41Vrusf8iyMRe3X7OgluZ0kxXno3xslE1irYZa1A?=
 =?us-ascii?Q?jqErDIRBsSXKuYUrpZUISnEQMv7WZ569/pHOq+sZ6tg0L67Wat4KATMkRJjG?=
 =?us-ascii?Q?RyGYv5Pd17GI3MUcTbRNGxkfT70c9GIIdfEFjDfJ9fJ+F07K+WauqTBMVqU/?=
 =?us-ascii?Q?ZRc4Roe7shR1AposnrQ2aEt7odkQZ8NImuSqRIomFSZ/KLTyrQltjMUNeS1u?=
 =?us-ascii?Q?CTh1ZskHnlFsYV2JuJB3KVeCryZ9MO2DHctKChF/q33f3thBC9PVidcf61iv?=
 =?us-ascii?Q?s8Tdfn51w9mXL1tn0Ti3U7bXS1Zen3kXAQaO+3atNx34UMah0Td+UczMHaKq?=
 =?us-ascii?Q?YOFen32bTqTzJtvTW3axWOY3cSbxnIOzmzYSFlawzpRHhFseiG5Z8UIuUPzx?=
 =?us-ascii?Q?i2SXyffzU+iS+0V0JyIXpk7AODMSVEgxNs2IIZzNWyFWeQYqs3gkuXElnDC+?=
 =?us-ascii?Q?qpKk5+IU1B4Qjrk7NK7wPX2aP+ogBK2VPZwMTFOZYSJS0RG2+KEJML5NIdP6?=
 =?us-ascii?Q?Rk9zWMkFwkOszVrz5AGpZOUUgYt3tcFQdTFD92HWynNMM2o5r6JuG/njsUJZ?=
 =?us-ascii?Q?Mlk2hQb1tbogtRvfa8+vF7EudQZFZ/iWEkb1RUUhhaLv5dGiJEud3rhDEgwi?=
 =?us-ascii?Q?QxIkkaVIFMdcDEQ6SXM1zeLL2tvCTX1qEtoVm0agqjLQ9EUE+7jXWiL2m8XS?=
 =?us-ascii?Q?X+kbO/jSD+3jnjM6Gjh48+ntm6vufx9C4DCtXsU48HQsn/DL05xL1kuyZI9t?=
 =?us-ascii?Q?/AVxjtWOBXxvk7/rvgq0y+SaFtdPkxBoSlHzZ5L9Ol70fSLvMb6rMQVF/ylD?=
 =?us-ascii?Q?sJkwVGbBoDGOpmJX0JK0zCtW0VU7VdCuRt1PPhDEpgrvJjChqjcys3NviZF2?=
 =?us-ascii?Q?zVbSqrkGOZraKiJ23bKaCljNDBx1vZn7V7qesZ6pCO4bBCkszoxVCUcOegH2?=
 =?us-ascii?Q?r7wfs+cPx8cMeYvvwm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20c9fb6-c904-4f97-b0f7-08dc2982a9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:20:34.8616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbbRqbJ6NquapJmuJe7cq2utFQZBsdfNt2ITIoMRDCoDp+jYMS/F7PTYRVOlh6Bz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Tuesday, February 6, 2024 11:55 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH] drm/amd/display: Fix possible buffer overflow in
> 'find_dcfclk_for_voltage()'
>
> when 'find_dcfclk_for_voltage()' function is looping over
> VG_NUM_SOC_VOLTAGE_LEVELS (which is 8), but the size of the DcfClocks
> array is VG_NUM_DCFCLK_DPM_LEVELS (which is 7).
>
> When the loop variable i reaches 7, the function tries to access clock_ta=
ble-
> >DcfClocks[7]. However, since the size of the DcfClocks array is 7, the v=
alid
> indices are 0 to 6. Index 7 is beyond the size of the array, leading to a=
 buffer
> overflow.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:
> 550 find_dcfclk_for_voltage() error: buffer overflow 'clock_table->DcfClo=
cks' 7
> <=3D 7

I recommend mentioning that this is a static analysis tool error.
With that:
Reviewed-by: Roman Li <roman.li@amd.com>

>
> Fixes: 3a83e4e64bb1 ("drm/amd/display: Add dcn3.01 support to DC (v2)")
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> index a5489fe6875f..aa9fd1dc550a 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> @@ -546,6 +546,8 @@ static unsigned int find_dcfclk_for_voltage(const
> struct vg_dpm_clocks *clock_ta
>       int i;
>
>       for (i =3D 0; i < VG_NUM_SOC_VOLTAGE_LEVELS; i++) {
> +             if (i >=3D VG_NUM_DCFCLK_DPM_LEVELS)
> +                     break;
>               if (clock_table->SocVoltage[i] =3D=3D voltage)
>                       return clock_table->DcfClocks[i];
>       }
> --
> 2.34.1

