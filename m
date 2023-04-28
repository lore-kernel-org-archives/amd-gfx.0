Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A204AC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 02:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7F910E398;
	Fri, 28 Apr 2023 02:54:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3205A10E398
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 02:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V07b5QTHICPpZffX7shoGuWbcd+93WybHB+X31lLUwFepPXKwgJHfTY+1sw/H7ZWCw4wRjyXL38lc1Qy/bAZMXU2iApptKZHRzmBlMjWOO/UCeeSW734sLgAD2R1NV668jKvKmKRl5ZO6/FFHFAamrpUJa78Gkke9TzmB2QM0U23ni59Tb/Kr5f4VJFM5XmUEO/K77cnoGae+9+76vAbApPr13/f8nSm3jPx8+qUvGwvql7A5swd65LfyST8qTTxEaO35Ur9bPiXcu/Cp+bK6YnTpysICnQb8QicFkJgndiea4oOMHX5nW07VfXFFsgdGXyWOCIkUFl3I567ne3Utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUApAwMLElfvraqQ9Vpb9tt/Y5oLB8sTcxnl0BoTgEc=;
 b=E9lLsGDNjjHuhvHSAo/27UB0prgsRYuzW7dDCmi5qnYBJ7q7mhyYywnYX7OQdNT0Yp9lhz9ZJvAF6tu4Hli5XbxyLQpKyCg53lO3zx1gx2cD9+vL0suKSE9VJ52TW+EodWK8b3HNs0tbPzxQ92rmo/MxOlTKQobVxUpoy7RncIxsHPWVrbEkVvJvP6+Mk0YRRvvIFnR297SK9YC8uHo7d7mJ6EapZKiud0E+yzc3OobZwMxBGPXDmnPA2zxKviYeD8ypn0Tn6qZWviecBmpzptFphVfanpwy2NmstnyFmsDUj2H9iBcxL6R6GPRh1tW0MoHhb0BZA82Kdv3Lyn6ANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUApAwMLElfvraqQ9Vpb9tt/Y5oLB8sTcxnl0BoTgEc=;
 b=PU3odca6hTZu11p8lKxxaA5EkshBI3XS6muXC/EL+2JwitPQnAHi/JEkM5xuYqJjcIJ48m20lyOF8MMCKmAb9xUNEh20vpAyF2zetCLXDHuFn27Gs1xTxXRCMqI8roUtzJQvU4Tcrqurm4Kt0aHKGoerF2kK7rPp5onRXLx7K6Q=
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 02:54:11 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::b40e:bce2:11f3:2a3f]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::b40e:bce2:11f3:2a3f%4]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 02:54:11 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
Thread-Topic: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
Thread-Index: AQHZeNhOSlkJfnS9KkG7U97L++V6zq9ABEtw
Date: Fri, 28 Apr 2023 02:54:11 +0000
Message-ID: <DM4PR12MB524818FF0E65A15836CA0814F06B9@DM4PR12MB5248.namprd12.prod.outlook.com>
References: <20230427071634.1484586-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20230427071634.1484586-1-Xiaomeng.Hou@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d8217fbd-523b-4a8b-8643-ce79262bc157;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-28T02:41:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5248:EE_|DM4PR12MB5133:EE_
x-ms-office365-filtering-correlation-id: 575599bb-aac1-490e-c0e4-08db4793d832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMYaN0Ucd3JS0WRMLl8Jk/sjIlZSh9ZWAtxbwV6RKFmT5BnnjLXyk8yJPGRJczEnbXhjdhzPkHIx2riVBYe0xfHdfvz/oagcPqZH0Ms1ZQHahJq2Cf42hfCBu1Wqt9/bIDT5eZmh43iHF8NWWNkVMvyAXhB2v50WaFWds4VOJo5y5hNMdxHUMZo8cvjq98Deb2dZgTy9dmNWoLlPayfcaZgYz1dNlBc2+0M4JDxDG4TLTxDjWN/mz1BIjycZcemupo3UO+i1Hf9vA22j81b5G3VKcHTYRpwjgFMTf/9WNV9PToHqnjLjR2ACNPLFoVtc4kYrioiamk3VgFoMeSiRy+8mRT4B7s4jSRZIB6Hjtf3dnrGlO2vWb0eIPAaH6gj5vyB8/spKPenqwuKsph27we6/mkbpKz2MKly37CzJ7OLxfrwkygrq9M0VTGainvQ42zynrr3kRdKXCt7huoX70BIoJWBQ7wDJmlrw1YQbIZ29WgIev02MjlIPJgioxjcjMe60J2zX5Apu8CAumWnnzYvOLfhq1DXX02uIH1wajF6yBb91/8HCIvfTyUGzE32bN1bz5p9c7g+ZVphc+vTp9y9VO7eNX5MNSFCnzEz363Et0EHFZurGvdyde8ZP3WZ/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(110136005)(7696005)(66556008)(66946007)(64756008)(66446008)(76116006)(4326008)(26005)(33656002)(6506007)(9686003)(53546011)(8676002)(8936002)(38100700002)(41300700001)(186003)(86362001)(122000001)(5660300002)(52536014)(66476007)(55016003)(54906003)(316002)(38070700005)(2906002)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F1Dfbvfb7GInhIiLEz3IDrW/ziFtYyymW+DZeT6KF1OVtIpLh+EktvNR+Za9?=
 =?us-ascii?Q?DTnlcF/UX6IoT5YihPKbMf3fTDtAw1ojVwI5vlD9RQkVFxNB8pht8ZWcaSC0?=
 =?us-ascii?Q?U4o+dwym4y5jylXn2dj7vq7sZHvov7SuJz5y1jMuEo1AE9YOetmfkNXN/CNH?=
 =?us-ascii?Q?N08OkZNro3WY7qSDgeCFdynIkil8VllTYAUSnx0wHSA/Zmx7m/FPBYyK5ROd?=
 =?us-ascii?Q?ArFFW8k3DK2CZSlcwbRGR8bc/f5vDGhsY4bhWnVQ0GUqXvZYiXv/0Ccxdr26?=
 =?us-ascii?Q?Vvsoz/CVn4G/sSosR6tbhf+A64ScuLicJUvsWBVoBrFNmBat6PFX3qJ7dRCO?=
 =?us-ascii?Q?gtjtb4/UuLnUpzHQrf/pmiFnYQDKcVR3U7TODj1AjMUbLtyH8O1wRt3IxDhz?=
 =?us-ascii?Q?a+wrxVyM73bGbihxZ0QFIXq9IqQAMW7mzfMI1L8pqLHxVwlQ/qteCZ5UqLXK?=
 =?us-ascii?Q?O8+DP1k94a1Ng1zD0js3fltyi3PqPnmJQmdmsoa8kpjxm1A6yxbIZKW3zoEQ?=
 =?us-ascii?Q?ybmIe8BNaZnllrrA/yUQva1XPwOlW8K/C6F6O8HmjdJYGL6NONwemk6w6uXI?=
 =?us-ascii?Q?t4mqei/hyPVIMCP0BJUqwrrmdZsfztSX1aa4dBemI5/2kf2RfK+NEmeS4dDR?=
 =?us-ascii?Q?hc/qq5IJ9VtDYpu1d9icMA3KC3MYJRE+fKW2y2LxpXEnVVERgNkhB9MA83yT?=
 =?us-ascii?Q?lcpFTyHmWyCHAgOjh2gdnsAnqpORx0Yy15KOE3dahs8BbMd9JYDFRwFWzHJ7?=
 =?us-ascii?Q?qeeWKe7XQACzOXuXp/r7CNcFUCtuFwFmfMJi8XNs/i8fCWb6o4PcUVJRgBF0?=
 =?us-ascii?Q?+yBrVGpYQe1fRtCAQEyi0r8T1iKZPPsMg42d/BGkjQ12Au49+ZwZDeQpZ64y?=
 =?us-ascii?Q?xOGzP/zdTSSiWvoxSONlN9zK/4CXX8CkBrIl5EufsXxypHGQhZeFgZ+LUyCB?=
 =?us-ascii?Q?CXLHcD0UfyyWBxULiYiePlnubVKECPk8fgwOZFfYb3yJilPoze+N/wSWNyvL?=
 =?us-ascii?Q?NahAUJjrSFVMqAoAy7Q3mIUMGIxDLuvLODmI68Vvq4XeFQv0Fju7Ef6PToXN?=
 =?us-ascii?Q?/wcTzS0lvKQytLopQYwsOTZ/M7QPjuU0MxYdBOA2qFJZ4PPU1+QLpeZydfU+?=
 =?us-ascii?Q?GxleK53NNcvTVKshJWwAlI2hPbl0guDkip1/hR/4Zl+WC/67Evn/UeB7tg8J?=
 =?us-ascii?Q?ZuLEbuQqRqdIbN6nroirD5AQD2oKEBLaF+8OOBbyXRBOBDL5ElQl29v7SF7J?=
 =?us-ascii?Q?bawjdCp3cTV2K1UL29IgBsR6mJRYUsFRsTz+fR0/b/6OXmgrO9hYu7vZ0qMo?=
 =?us-ascii?Q?mq3WhYgdirp1Sofs07hL5m61mLyestxAQrYe5j3wiJ8bQovSSbEWjraLLRKM?=
 =?us-ascii?Q?h5dpt3m3cn2jFEgPEfdotvP+vuayjUxJuOdR38FmS8uk1ae1qGNSpjr2AGSq?=
 =?us-ascii?Q?nePh3Zmz37cDfWTuRmceYL1NC7ltRWg4s3NNFNtKqysZgty9KYh10LM9ORyd?=
 =?us-ascii?Q?YGroaDVLQjGwYZ+ejAI2wBN5Px62EgahPiJtQtkBRITVLcKVdbaph+sf/szx?=
 =?us-ascii?Q?PK7lzWWnUPINA5AHfkE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575599bb-aac1-490e-c0e4-08db4793d832
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 02:54:11.5481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fSt5qxSx5Q+5ZAD/KLcuQfxoTb434rxs2Sp7kfdS7yepkivnKrF1OsX4zht2Lax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Good catch!
The PASID_SRC bit is only used in IH_COOKIE which is sent as register write=
 to the IH by IH_client.
But in the interrupt packet from IH to driver, the corresponding bit is alw=
ays reserved. PASID_SRC is not to be used for driver.

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Xiaomeng Hou
> Sent: Thursday, April 27, 2023 3:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ji, Ruili
> <Ruili.Ji@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
>
> PASID_SRC is not actually present in the Interrupt Packet, the field is t=
aken as
> reserved bits now. So remove it from IV entry to avoid misuse.
>
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 1 -
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index d58353c89e59..fceb3b384955 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -271,7 +271,6 @@ void amdgpu_ih_decode_iv_helper(struct
> amdgpu_device *adev,
>       entry->timestamp_src =3D dw[2] >> 31;
>       entry->pasid =3D dw[3] & 0xffff;
>       entry->node_id =3D (dw[3] >> 16) & 0xff;
> -     entry->pasid_src =3D dw[3] >> 31;
>       entry->src_data[0] =3D dw[4];
>       entry->src_data[1] =3D dw[5];
>       entry->src_data[2] =3D dw[6];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index 7a8e686bdd41..1c747ac4129a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -54,7 +54,6 @@ struct amdgpu_iv_entry {
>       unsigned timestamp_src;
>       unsigned pasid;
>       unsigned node_id;
> -     unsigned pasid_src;
>       unsigned src_data[AMDGPU_IRQ_SRC_DATA_MAX_SIZE_DW];
>       const uint32_t *iv_entry;
>  };
> --
> 2.25.1

