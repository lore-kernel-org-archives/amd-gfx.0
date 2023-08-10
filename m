Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7F3C001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 08:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490D510E165;
	Thu, 10 Aug 2023 08:49:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F2410E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhwD70i48w1Fs6PtXvYicpJmgfQEhQn8/JJn5h5e7DgT/urUnxOk0MRML+A4xIxeDS3MlYsJeMgQ6inVqay9BMgaS93bPryFJYZSrF6oUGSajaXKT68MMHYnss5llzAMM3rU+NUb42FxjUO7VwzLOml3WXNKgHGePTtzlVyIWT6xGGrzOHHg2PRkPzCQx0jEAsiN7l50FT9DJ3HvKqJznur2p4e8k27LnIh+74Vt7+ssuc+SkcdiSO1HaTLFSXej3y6X8AuE6fICQtju5dp2G0M4w0cclAqHRr+YLMw6ub6luh9zeqp0UCh3Bwc/Kk6qjaT7pwi3n6BmXU3MUfHPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSsc+NHx0hzwieOm4ar6XSUdebmg/W+iLCuaqcKf7lo=;
 b=Cf7+32M9BcxBlvVLWWt5xfAgzFm7rrJgFD+46l8uS9OP8rASUrFuI5TS+t8pj+sMAFmUVMIIprUWuPeP/dRhsEUiY4HEjmgFK67E60Iy2IfiugOAP73zWNBZj/Qs58S7aoMVzFZlVktxcTteVTqBrbcWSv4xlHGyBA3Gf5XScWe/LsiSfvSG25F4dLY0J5zdpX9rwUKPAWBsIapK26s7N2aazjHAlMw0f7mjwE05S+Z7744dBiy4kTfuRbZG3O1wUMzqYK+brK7NgA099eKfrreBoVvxt57RQ41R4duRG5Oi8fx5otzzrMWuiyLqBbs33eTtaCGC+kxAAEdHvL7MFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSsc+NHx0hzwieOm4ar6XSUdebmg/W+iLCuaqcKf7lo=;
 b=l0Aptu/GAwn2xnuF2YFXP6TVmvh4ClOdRMMj2As8RtD9/BpZxKGQYtbqoUTTd7BuKn8IJ5Vfm+9miw143smMXi7yqQIEHxJNH5xECtqP3WWXPFs3geJ7Np1YU53eJe111rriHkHUTH7A+lAl4LUHDucS9pE6LO8Vz6ZgQuV78DY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:49:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 08:49:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
Thread-Topic: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
Thread-Index: AQHZyqFTDQ+vflozRE2r+CqlJXs7n6/jORLA
Date: Thu, 10 Aug 2023 08:49:10 +0000
Message-ID: <DM5PR12MB2469CB3FF5DA8FAB52C4C885F113A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230809090951.435142-1-asad.kamal@amd.com>
In-Reply-To: <20230809090951.435142-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=42226e6b-ed35-4ef7-ae9b-9e503147d64b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-10T08:46:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|LV8PR12MB9359:EE_
x-ms-office365-filtering-correlation-id: 771a177e-7cc1-4514-932f-08db997eaa66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUIWQ8XRBOZosZwISsFTkzCtgcMGg4BPVRdmsjRGSNjF4xypsOtEtQvb47vlIVk2o0V4lCuu+DwvMC97Trz37AUSEEp8UMpE+apMjQFnDFPcWrGB6d8ICp73UJxz4qqWKElA8xh/plI5cb7EAbD/mAAU5IWBUEgRnK7whgz2CwWW8SXXEwpBA2JfyvNUnWGvZ5nN3v+xioYKVhTR5VQhJWcPCFYh1+GbRqyEpm/2FQJVR0nkXzzhgOY9OTmbOT14v8zHXU0JMMJsOm7MTknKusrznH3MY8O2WtnBQt8n/tUwK8gpVR0Qh+LHW65DdO0mKG68yiDisIc8o6F7vAfuXmUp48WYkPAw2gxD0l2LFrI0yY9D9t+CaMNb1huh/YSQWEj0yb3rhUxB9zDQnp+JWnLfSueZGUNHg6kt/i6zH3Tuveq/n3qNe9alowL0OcQItDGvbOvCKEEFk+xZF0QW44UoR4RH+XobHnmWRBKvm/Nhd44zDjNYccMmjrWnu1U9wAnIwBcEU7D/gvxc1ThHnLf3SWH7CXMnyWZdo3eyvQ+tTmxAp8eoi3/rrdzRbhyj4vuhFdO2o0YmJOZxniWiDzr/yCcsdvLi7XajmrgovN5EI/sZMPFyi5k0WM7udfy/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(1800799006)(186006)(86362001)(33656002)(76116006)(478600001)(71200400001)(110136005)(54906003)(6506007)(53546011)(66946007)(66446008)(26005)(64756008)(66476007)(66556008)(7696005)(4326008)(9686003)(2906002)(41300700001)(316002)(52536014)(8936002)(5660300002)(38100700002)(122000001)(38070700005)(8676002)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nIuXMH9pIZLdvh88e9nF02V+BrZFwJYMdd4GmCyrTKXIg06grdcU+UkkXuu?=
 =?us-ascii?Q?HER28eufMeoyOwX2dUjmI7tOEnX5KEERQgnrRryYzgrT7JKIlKoQowYAzF9h?=
 =?us-ascii?Q?J4RathAngsw3w+LkjMeFgoK2oknb81YKdT5hW5yqwL3L3hxm18AOvtee0Zpd?=
 =?us-ascii?Q?Xa6pK75K8apSUvZKVkizEy2CR0cEsADPDXuYBPYxqyXw7xkcZOW6jSfaizQM?=
 =?us-ascii?Q?thktaP0MFcLzOsbbtjN1axpmB1neiItZb173D6q3bDmt1qvOp1OUOp7ECB4E?=
 =?us-ascii?Q?m6ZJZjbl+U8PmFdq2ZL2bqW7wQzh0mzqAHgSv5pUBkSymtHp8+zrjCgu0/e9?=
 =?us-ascii?Q?r3QxboNeQ6DkGp17Yu7+OqfrnsX6BzCHTlPOIKgJmdxExbB5m2VtvKy+5tZb?=
 =?us-ascii?Q?PsOYHParTCgeBve4R+1vmWxF0G6QZ2sPpFaVqfdnmGpXkjqBgGMJ6JooT/RH?=
 =?us-ascii?Q?m95P06Vps1ztcN1QHLbyC6RwvfVgwyB4ENuu6wB4L1z4fak+AzS0U7P10hWt?=
 =?us-ascii?Q?YJOEDJUrb438nPNxo+nlOtT6DXSzC7uLkguBXiwkJmm6FwqBRsnTX2HqVCJd?=
 =?us-ascii?Q?7vSIXamqn+XA9zbHhDe7gPps43Vo0OsAoN6X//T9hes/ZvY+Vl9iuyEJrtZo?=
 =?us-ascii?Q?lOyz+9Y4i3S6oZ7q154uM30Y/97dkodIhdhLPiB80SacxEtmiFjmcUhcJBVV?=
 =?us-ascii?Q?N4Tgfb1K15E4Kt6J1qdilUMCyAuJF9TwIFmglwMEWcS1oFjSd/spTxfLES9q?=
 =?us-ascii?Q?cM+Kr1X8hqHe9bdw0ypTc9Tz+Aqj9YVkwhioRntt2Jv7iWb4kqowerbd0eZ2?=
 =?us-ascii?Q?G3fQPzdykc0AHpMtixE98me6gDk2dpHFi34iqHKEUpATtfsbYJuKKDnPvbSk?=
 =?us-ascii?Q?NWe3zTVGwoCo3TRw1sDTwMNk78AxklQBCUQ6scX77Llr/7nvfC5M2rSmpCeh?=
 =?us-ascii?Q?4zMk0M6IOUf7Jaq7rcA37YUvGXLbhbyIYb5WuBV+ViNlhQUVmWPhm4ofL5E7?=
 =?us-ascii?Q?94sy8fwwzagbkTF6pAKg5T1VZcVzCAEiKvBKVBz8T1bTjfXFeQXgozZaqouc?=
 =?us-ascii?Q?5ElfIghLKwgQIbh7Vy80qAJLSOcyG+K0FR4+XqCGxkNaMqu2ewypVbkRf+sP?=
 =?us-ascii?Q?c7es273aAtnidPTGzN+Dj7MFExiX92Pq/m1XPWr/0LnSwC2dhTos+2fbIouY?=
 =?us-ascii?Q?9csWCAIt26QZZnOJRTuks8pZTHe2IOgJyuyRZ1r6jrbObImaqHWHsDKv5hjy?=
 =?us-ascii?Q?mYQstsyBgmR8hvDMz44DEB0YHIa9yF+o1HOEx6qLFOIPPbzQ7yh54MXdNso6?=
 =?us-ascii?Q?5KYkHTdQ1KjF+opmrRdgZNeJ0ANP/EoOHhjlwO7Q39cqhoVSviTp6uIQBOLn?=
 =?us-ascii?Q?J0E17VCsV9s7mXv298aJ1KOcUVns48yo9N9FH4rRaX0VSJvUhz21BBiHuUSV?=
 =?us-ascii?Q?eTrgShR6EwUkcye1Ct7b1Z25VDkKZVn/KOFFYJva1Q8khQxvvC4bU7mntF6g?=
 =?us-ascii?Q?tgqfjzgxgV3J/robGI/JIBA5w1tVGweZi8rYTkE3iafnW0TbXD/j+3aaPcO4?=
 =?us-ascii?Q?Zih5fBS7BqIqI0wep8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771a177e-7cc1-4514-932f-08db997eaa66
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 08:49:10.6357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKP2+gxe6WYnvt0oLcYipHfB0IGtKSKAe19L21NYsh3n9u2itqzz4LSukYPKzv99X47/oZljpJrkH+LuONPwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad
> Kamal
> Sent: Wednesday, August 9, 2023 5:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>;
> Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
>
> Expose sysfs vclck and dclk entries for GC version 9.4.3
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 3922dd274f30..e4183d6d7f39 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2095,7 +2095,8 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
>                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
>                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> -                   gc_ver =3D=3D IP_VERSION(11, 0, 3)))
> +                   gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
> +                   gc_ver =3D=3D IP_VERSION(9, 4, 3)))

I suggest to put IP_VERSION(9, 4, 3) prior to IP_VERSION(10...) to maintain=
 it numerically.

>                       *states =3D ATTR_STATE_UNSUPPORTED;
>       } else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
>               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) || @@ -2109,7 +21=
10,8
> @@ static int default_attr_update(struct amdgpu_device *adev, struct
> amdgpu_device_
>                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
>                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
>                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> -                   gc_ver =3D=3D IP_VERSION(11, 0, 3)))
> +                   gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
> +                   gc_ver =3D=3D IP_VERSION(9, 4, 3)))

Same as above.

Regards,
Guchun

>                       *states =3D ATTR_STATE_UNSUPPORTED;
>       } else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
>               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
> --
> 2.34.1

