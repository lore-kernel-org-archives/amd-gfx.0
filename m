Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E81AC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FEFD8EAA;
	Thu, 25 Aug 2022 07:17:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2158D8E7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWVbPun+QWAe5hJCY4gg4L8V+JXXflnMmZZDMVYnfFcmNVg/wpVw/bZssM2yd31qFI1nYilYeCKwG658++axfrNQG362PHKXJqZ/rlW34+aED5Cp13LHccrw6KE4AWEr4eVHHp98Og9IRpCsecLbxQfHOkPndMp+SDcFdyZtuHP6phnsb1bAe//jYut++chaet2iOQ+h+po4WYHdCB2lUQv3+dZ37CGAJHYXjdqQGNYvl14bx7/OPhHuyKoBGg0if+Y6rdwFZzAJoTUlY/0o9Kn6onH3+WlGKocViVov7Df8zfX2+6X2bB7xmu15zOZrSFUMdxJ4emhlfOPHo9XXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmobWFz729e6ARqu+6TvI9ck6wb/lxXvxcGK1cUAbu0=;
 b=UbNnI5MAbtTFiuF2YWI5WI+jibkV6iwa6mvPct0LQc8/uNFk2iJSKJ+2RNtMROcEnWA2wDfNQ7RURaPDgHOFJyS2QUG9QPvqEQsrRv0u0mTDGiiXuLD9SNc33Ci+MFpyc/FU3I31mMTxkll07PhhJ3CQTOet4318ddey2rYeA63THz5eSF3rbOe0Qvvf8rB5BjkY23A6uHriV1hdV+cUjH4fz9JTQUK0usEyhQAjRsSF/n9yA8lKIB36xH6AzyQDD/hkebDXVYSshIkxjclgnyfkzRoNLFNc5K0S7s2UWheaINUFao34Lkjg71s1wH7V19pjwZea+7UIdh8WBED1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmobWFz729e6ARqu+6TvI9ck6wb/lxXvxcGK1cUAbu0=;
 b=fRHUvtlNnHiZRjVOINvVRq7pYxEoS9DDVaN6j8wHbehY90qXjm3l/8Sqg7yi/uXGc7mlhU4jd/oVPWvzrwcGR4u5HD3/hZ4c16Wk2Wenbu5pPAF/PsJowNYHKwkvU15KudsKSoB6bMC/aGQX36HHT7NIpB9l4Ea5mnmYLp33Zfc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0137.namprd12.prod.outlook.com (2603:10b6:4:54::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 07:16:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 07:16:55 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
Thread-Topic: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
Thread-Index: AQHYuEuR/apnErWkDkC7qXxY2pNBb62/Mq5w
Date: Thu, 25 Aug 2022 07:16:55 +0000
Message-ID: <DM6PR12MB2619FF2341D8EEE09D90F177E4729@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220825062550.331393-1-guchun.chen@amd.com>
In-Reply-To: <20220825062550.331393-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T07:16:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=386409f0-a1fc-4b96-a5dc-3d2accb4f6ad;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a85ae162-4a5b-4837-383b-08da8669ca7a
x-ms-traffictypediagnostic: DM5PR1201MB0137:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VasUtmVVP6cRKdpXyMxpQ5sGk/VtvzaCxJFliaecpPOMHMtAfTFXFp0r5E4UaREkpvhzy84ytaUkShczRcaYbqOMEOsm8pz9hXroGUBPKkSR7HoXE3rZ5DK6DhDdezIbu/KhAju+Mh88V6wxcDr4J7U1bkxi31U4PXFytLpml1JkYpMDSUW+1eKxoo3QKUMnAhq4B/mR5WrEIirrPfOQa8/NoKwhDpUHcoJiUxrvkWOdVDzKW00WBImPX3+ysyIIh+HqCuGFAd11BK9EHNo6/WIC757JeafhU4lSFo61Z89uRoWfxlmXVuO9dnIoTYZRmeD4yse65GnxEa+/RoVppWRDvEGLE4f3SEoPqoxKf0e8BYZstBuu5ax7Fg7F+YUUC/Npc/VTkP0uOuakC/o/mzAqyZqwnq8WgqMOqMaSW8URjoYGWIT5iP3cTqbsqaDnfWyIy1U6Rre/te2w362C1da4Uv1bqfE2x7gfOZEmOOihAwc4KjaGpeYaGFYmF5Gft39UUn0z//16LxEaTH8xIkRMjgKLnsOj3hQvKCsUg4n9diOOAs5fumUwy2k+FMHm5ziCBe310ds1eTkVY71raLYwAf8z/ewyJYw3FbCc8NaslVXl192xFeCEiNjzb4JIITIQg7iegidP+2C7rylWaWgnoBGDS08QHCsAwtVlrY2q7XWJ/xUZvBUkIzn9ye/Gm6gYfFvYQ2C3ZBntwFNKA9wVHy2aWeRyTP/HSnlA9QknOFt9jgxKbe4nVMDVJJD6DAKdZaxG7JKvkGOTNEUcwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(2906002)(52536014)(5660300002)(8936002)(41300700001)(316002)(33656002)(6636002)(110136005)(26005)(9686003)(6506007)(71200400001)(55016003)(53546011)(7696005)(8676002)(478600001)(186003)(38070700005)(38100700002)(86362001)(83380400001)(66556008)(66476007)(76116006)(64756008)(122000001)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3u9UCOEFwyAaGh4P5mdIc+bIqJCiIgQuuxmWwo5mFJOsochsVBT7mT8nByP7?=
 =?us-ascii?Q?8LsinFbfdIVLD0MfoEFx+0FghFj6r8x5J0flTyyE/MorMkImBrLWwdrLxO+H?=
 =?us-ascii?Q?vtJCAJ7gUb4U8twtn/yha85cpWUuim3TueCY7ek+Y+Z9SqagztHwbCOE2aXY?=
 =?us-ascii?Q?w5OJluYYnPzF9O6cDCYIz7uP4IuxEi6cm8VboxlXPGIGrYP10wr+I/aLDvwQ?=
 =?us-ascii?Q?rcD9WKqk6n+M7BWVRLQ9s3/tBuxgDWJEsjTFK4zBxmswyl5nynskycbrUsiO?=
 =?us-ascii?Q?XkJt5+eF8iSDql6vwsclCGFBUgEIxOpfH8At7I/kDy/Rc1YEgcfzijVbO6E6?=
 =?us-ascii?Q?4Adaq5RifXtTgPSYrnGeIXvtWrNpybmZZ+Zi6tPr+4EK4w0ATbfHr57aScaL?=
 =?us-ascii?Q?zWme8EGnqgOzMebRloVohyvJp/D5lt5F+i8pcmK5CTO+kVx9a9/pUvl/2JD/?=
 =?us-ascii?Q?TLU+WNKTulUJAkeQ/DxxSyIA9ne4m4Sflnr7fEiZsJbK64p/JOyP/p83JZ49?=
 =?us-ascii?Q?wYLROYhSX6gYxjVAc2XMEa0s8dR6sfSgNGFJgMGkN4FXXvwrxh0U7/PXP37H?=
 =?us-ascii?Q?0bNnwxwXSOS/B3qqKEUDRIqE77EeuZwL3k0FdX5t0C/uRJbND/f4UQk4KuSw?=
 =?us-ascii?Q?CWeZkdbL5+M5aYzkWtTZl6etRJp9v1mkrSem68+O3druCaaaZ79SbVJtGZX7?=
 =?us-ascii?Q?Pm0ekrp+Yx4G5ymI9YGMI9oqaijICgAgmewZT+XYGrEX0V8E/DLSWaAc6WK4?=
 =?us-ascii?Q?pQmbxzkU+bLwj5nmifqCbN0Ks1BZ6muuwIhGLVImknuviMVMNQRXWGYoI1Ky?=
 =?us-ascii?Q?nNfQioU7vVJZy2Lq2bnpBfBMosdXybLthDB4DdSxUdiZAnkjIT6KSJvkeCxY?=
 =?us-ascii?Q?VhsSD0MomCvNxZAJRG8BOe2207NWL6qn9TRUTLC58MQJ5YINUmQR6nD9g6zF?=
 =?us-ascii?Q?sfq1edRBmnKAQh3f6zCSc9JPf0rGbacyT6N/CHTbanHf+ztaRdE7/0Q7Ra1J?=
 =?us-ascii?Q?LWwGWS4mTusEcrbnXwi0c2vLTgt42rjLnrqX4Zj75GHQz4pVVqrEFiFzd6LY?=
 =?us-ascii?Q?KsFafOYB1R0kz+Ry53CgoOVuF64IWTyhswHJQZXxBMhAlga6OWnL5ifI764a?=
 =?us-ascii?Q?QqvDutmuO55Zw68uh2e/9rdfO9o9U0nPUIGJIsXgN9g97bu/SL5YaywU4Bot?=
 =?us-ascii?Q?A0r6tjf+z8utmQ8KizWh74tGPKNpbNFwQKF+35c+R/YgQE89hHgZpModLDdc?=
 =?us-ascii?Q?83TpOrpQVDxY5qs1Z2vCzXCNVeQEb68yxkU4+gSmXoSI3m37zyhLDwXWfSo0?=
 =?us-ascii?Q?uK+0r/b2X5z4Eyjd95MjWucrtJbgrTGUJkLeRbC6seFhvCO9Q0Bd0ghnVQN1?=
 =?us-ascii?Q?Lm95aeeCpPXUiPIpfGjqepueTxVwuOcVt6NoZYduxCoU2NwjoWqDFmtQ6IF4?=
 =?us-ascii?Q?zRy0auN3kTINpG8MploSeI9iPvaIhjV8sNh1V5jSQ9T2kAWdUyTBXuF+x0c/?=
 =?us-ascii?Q?5WO2cmj7oL39CV+Dg6ol2o0whQ/rBtsgacQa7DGGm6eSWaU6RL1mZxU78ALo?=
 =?us-ascii?Q?RzVNzVYmcY0A0k6OMfs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ae162-4a5b-4837-383b-08da8669ca7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 07:16:55.2417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7bGktLcHAUzVlc64ZM9uMLlewGYBUAR8qAFIOKgcTBVBdFv9mhTbqSNlJTYpSMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0137
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

[AMD Official Use Only - General]

Here "free PSP TMR buffer" seems having some special meanings (a marker tha=
t indicates suspending is on-going).
Better to redesign the prompts for suspending.
Anyway, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, August 25, 2022 2:26 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
>=20
> 'free PSP TMR buffer' happens in suspend, but sometimes
> in mGPU config, it mixes with PSP resume log printing from
> another GPU, which is confusing. So use dev_info instead of
> DRM_INFO for printing.
>=20
> [drm] PSP is resuming...
> [drm] reserve 0xa00000 from 0x877e000000 for PSP TMR
> amdgpu 0000:e3:00.0: amdgpu: GECC is enabled
> amdgpu 0000:e3:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is
> not available
> amdgpu 0000:e3:00.0: amdgpu: SMU is resuming...
> amdgpu 0000:e3:00.0: amdgpu: smu driver if version =3D 0x00000040, smu fw=
 if
> version =3D 0x00000041, smu fw program =3D 0, version =3D 0x003a5400 (58.=
84.0)
> amdgpu 0000:e3:00.0: amdgpu: SMU driver if version not matched
> amdgpu 0000:e3:00.0: amdgpu: dpm has been enabled
> amdgpu 0000:e3:00.0: amdgpu: SMU is resumed successfully!
> [drm] DMUB hardware initialized: version=3D0x02020014
> [drm] free PSP TMR buffer
> [drm] kiq ring mec 2 pipe 1 q 0
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 1036446abc30..c932bc148554 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -812,7 +812,7 @@ static int psp_tmr_unload(struct psp_context *psp)
>  	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
>=20
>  	psp_prep_tmr_unload_cmd_buf(psp, cmd);
> -	DRM_INFO("free PSP TMR buffer\n");
> +	dev_info(psp->adev->dev, "free PSP TMR buffer\n");
>=20
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
> --
> 2.25.1
