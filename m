Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A556C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 18:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD9410E08D;
	Thu,  6 Jun 2024 18:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JcNB/rB7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA9110E08D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 18:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILyY+yNBjHrIyNLFY4rcP7/4KBeqIoZdB0pzpYrUWnmgTfexIYqsSP9fPw0A4bc7ms2uXzHT2PfTiSS5zfrCe/M0yep+lWy3oPxyDjHZA/uHFqufuSoRfbErfaxlDQi/3kM2DtqFbUC3bAfiJZwp2eEbK0Syu5CkvDvLYgqY2W+ITLKNOhUWs4iHRjLqPfiAZEAr/j3Cw7xXxc1J+j+WeYMka+npIBYmaZ6BjXr96AsGJiyg1MjfqDSmlySvXYmUN2wddCExst1yUhZobQdHmQyjJHkweATB4Tu982xLvPRSqIBkQFTq0zqMkGDHeAwEF2uQXaRvT8xeTz6ecE/5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyD8hDUihMgZVfrFYizoCHT9p3WO1tOYwOYE6WjHgzc=;
 b=lr28thpam8cUsJPFvZu95wrO1BhCAqteaUShBLHi518Jy3tbuxDvj0bASQAGKCDat/YtLOnPotDjkpm8Zfh25f4GGEyHGWpDvyRFAHrDEKTA40YAldkvkj6XkXmKEpgmOoZwj0EEEPrU95voeP3quNQ2w6kmL/q6zpXv8NZN+4NCI3i8HYPF1lc+bg5wncnZdl54a99xV3s2no1f75akzw+1c3rNVAXhAHa9RK+c3w1PSzi2SPJtNBw4ZU6F5r0Ga0dAdlp0xwl9FQlb6n0wPgszhcIfn4fo+Va6FIQ3JpmorpT1l0nl52J0O/V1brNil+Q4Ma67W3gMDSG6c/RXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyD8hDUihMgZVfrFYizoCHT9p3WO1tOYwOYE6WjHgzc=;
 b=JcNB/rB73V2yfBvdRQSNcnEo8jFyZyOdLiF+iC0Zhf3XgVqURWamUaAcNlG7V+69wS1r7b0NQ+ouAKD2tF6+wTo4WmrBGuxLEMzabQZFnXiokAst+cYEOsh0/7eW+aB+dgQe4ypyKqgVZnUoGXCVGcQkJhqD/rvRd5KGq8/BPaA=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 6 Jun
 2024 18:27:14 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:27:13 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Topic: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Index: AQHauDHVeXdaWpoJBU2cSgwX4JW/iLG69GEQgAAERACAABUwsA==
Date: Thu, 6 Jun 2024 18:27:13 +0000
Message-ID: <BL1PR12MB58980DE64AC5E35824252D9585FA2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240606165100.2821320-1-mukul.joshi@amd.com>
 <BL1PR12MB5898C513B0D9E4801B920F4185FA2@BL1PR12MB5898.namprd12.prod.outlook.com>
 <BL3PR12MB6425899B9E10D0770C78A375EEFA2@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB6425899B9E10D0770C78A375EEFA2@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb56e961-e762-4d45-8e07-835299815ad1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T16:55:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CYYPR12MB8992:EE_
x-ms-office365-filtering-correlation-id: 2f7bf32b-067a-451a-a5ec-08dc86564992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CAO22lKfIX5RR0pzqxFlGTiJ7IIPB+BdA0kr8qTYNcenVNJ6chfRgKeWanpi?=
 =?us-ascii?Q?H8qR0GW11BvWTok1DOOTCQM7bT+jJJvTE6qnlJdJ2PK2vPPZaeMSZBBUcKSE?=
 =?us-ascii?Q?J8hCWzRdMCsco2rNa6bZlvMKdiHmJK7i9qhe460v/Ziozm2THnRH4F2va8YB?=
 =?us-ascii?Q?Ju2SQ6wljN3BRv1TKOI4PyCkxsqKeL6gRBkH13zwHxekH03thAR7jax8DzU9?=
 =?us-ascii?Q?JDESwImCr7o7GaEYtM0FXFJ7h1oRHSZ2krpUdxkTh4O2yu9VFe1sieU6ZvXy?=
 =?us-ascii?Q?wIqKcYFGXL8rcX7x8D7b06atlj31si/JupK9jyMYBIbajBgZ22Osv8zVcvNQ?=
 =?us-ascii?Q?51Zd8KnCyvg5Pj+5sZ9mAEfNPMzyxRCfw10agNLCHhuelPt/GpKf4JOKf70V?=
 =?us-ascii?Q?F3GsONrxZRitTSHZMiBiIFwN+gaffZQ47V1Z1xTI2BaUKLMjYya0HjAAiNvf?=
 =?us-ascii?Q?t13culzOs16PkrN27TSdxLjbjA/rO2bAonx5Jxj/+7w9+xEnHhWcHpk3h7yc?=
 =?us-ascii?Q?oaeeX680jfIxjlTnEv6Y3ev5VVOlwK8TQjhc85CyA7POLygIW1lEfIj2juvb?=
 =?us-ascii?Q?28QcY/7x0Xj/hIgwMK4ndNBB4hSP7xseijVGJDlEZ8wGpt4NT5/kYgPZJjrQ?=
 =?us-ascii?Q?wuLypU1/PfJDO0WVMrpmfATguH+jNTzKYuw3QBHUdJMlKFzvVp5FS0LE7R9c?=
 =?us-ascii?Q?5U5obLJUiiXCvh5nNP8PWtlv4Yv2RqZDRS2MK78UlpSLOgrY3GTrQGfYBxg0?=
 =?us-ascii?Q?W5mNFOkOhm5ljc+/CleSB7qwL1J9Mej7TU3i9EYXiCYfy2ga+OHTU2WJOJUN?=
 =?us-ascii?Q?CjdX5Eto9d8CYCtqV8IGce7Zm8vMX26ul1zfJ0Ev/wHDnHfMQ/U7e2Vu775j?=
 =?us-ascii?Q?s/wT9iK3DocBDhbOMy9MVobXn2xnRudg2ET+Vx2j2fdoKSfyFugw16B5BTaX?=
 =?us-ascii?Q?8/ulOZQqU2g4NM3DN9sQIAmMbn/hUtFIRA9i3qhYnAbiObajVx2A5TYIhcZ/?=
 =?us-ascii?Q?AIiYMIRtjXjwcow6PmFpL734Nun3t/SeIbU5sd5FYyM94rjzYyLhhm+f1qqH?=
 =?us-ascii?Q?B/mqag9Q/keovewSpdQDN/9SPCwnVZ0u98dEEPv4fSvJY7nrEECJZjuT+ug5?=
 =?us-ascii?Q?c06b0u422NFbFxOqgv8/kJIIWMZJ+OWE25R/h6EYNYn0RQzr+z8UMw+Vg/IV?=
 =?us-ascii?Q?3vmU+V9gSqlCrZkUdRR44AnQ+TazrZJE5KU8HRLy8xW8mPlxH9YqNHjB2Y1c?=
 =?us-ascii?Q?Ws4t71PwE4tSI/3YD31IYOfBctyawbhEuEJVLtA2LQ9bXfSsJ5MMeSeZVGFa?=
 =?us-ascii?Q?vwEOox1NL+x/x4PMkGFzBDoIuMFZ1DsDHcsw99POfQiOsk9iQYI4UPY9cQpP?=
 =?us-ascii?Q?LvUuqDc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UQbT/dBEai9e5aVVzula10RsihplTTy1yRLpTOlFaEgLsw8OCddbyvMBRqSh?=
 =?us-ascii?Q?Ybwmm48e7duW0dTVBucuYGrezK2T5O2C3NM8om6cMNvMCRV0cunAZvzlCSqD?=
 =?us-ascii?Q?Rk2Dx0igZhi3giBvjyH4F+JPWqx/8eJIfBMT8cNnoy1yEhaEXU09J/t7VOP6?=
 =?us-ascii?Q?tVXE5/V99CG1d7eob8vdF/XUzpkbxFFb8rcQm17SR4CoRGiQWpeJjJzf1f1B?=
 =?us-ascii?Q?4wX+rPb/hxycAroTjoIRnE0qdOThijKQvvE/laGTU2t6xcv5lsE5S20Gge1u?=
 =?us-ascii?Q?de3M+HnXPVsBCis3RjpoxQ+bDR4n+5nHbrLNJ+ciMxbY8fI+rsrCHEBP+8WV?=
 =?us-ascii?Q?aPVutySlUHtqZfvT8n07ympCMVY1TD0SP4tfhUHUffzJyLDK/q11piH5GNF3?=
 =?us-ascii?Q?cfHZpBR/w/Gua2gNviFaPGwgaHGBn4kJT/4zXn3V/wCECWQCvinmWZwvZcdZ?=
 =?us-ascii?Q?MI4y0JF6XAdyZd8ucNWcUfCAsklewJRLDVvcKFbIe5AMxHJwjpY88yN0ViHk?=
 =?us-ascii?Q?qYnYG3o6Bfb28+5djRZdwxyr8J2PZInC4rZ3J9c8ySNF8UQcDJcFmoZIUC35?=
 =?us-ascii?Q?T6U/JD3yCXyscRfrE8awVtfNEdctqSRflZT76ofPKZY1Edptc/eF9tLhrLU7?=
 =?us-ascii?Q?q3w7poLdqdc0O40+o7QYip0yHpLfSPd6H2ci8ZkGf0jyzvt4WJVZuizqZ9yF?=
 =?us-ascii?Q?C5JbKUltz9Sq1p5D5ax7MvTp+b/Ze2b/vMheMSoktuQ6RxhG3nkG5U9CfcwQ?=
 =?us-ascii?Q?6Gk+Jcf/viKLYgyqHCRPFjRY55LwFEGBfC6+XNjIix37soD3JG3bdSz/q0r4?=
 =?us-ascii?Q?OPsCfcsNzH9IgITPswNcsoojbEs3w+nX6zofP1v7GglmKuTLj7DeVxNPRCST?=
 =?us-ascii?Q?bWKedfSJwIoypHW5mhydJ+2vYjzWnVLFcCpjG+jgEvFbEuVKIYxuL41GOmY7?=
 =?us-ascii?Q?XP246uEkRi91HjYnCGVCJ1qKqQRrGmegv3KXjQPS5hwJB0LXybcKfvHP7NCq?=
 =?us-ascii?Q?W5fEdFDJaayQ2ujSncc8KWX23rKg5AoeO0ZMXd7ecg4qAMRG7RTR8d86MwON?=
 =?us-ascii?Q?VDrJN+rUY1J9uV/euKlFNi5FVs9gA9yOw+8oBNeWS+OZoYoxGT8u+dazLfbJ?=
 =?us-ascii?Q?xCAH/gU5N315RrycVIWA5vaXLDXfIc3JZjdBMCGBo5XBCI/gK+wqTm6i+KRe?=
 =?us-ascii?Q?4UNNzK06IeGfpkmZ6bs2SsGWmoo8Ro5TKGJMvS8zUsuT/jyae1vvQpAKrBtk?=
 =?us-ascii?Q?PgcwB57D78lcNofvkHhPEbGdsCQTgKnCnMVFTYco1qx0BwKzyl6RWPneR0gn?=
 =?us-ascii?Q?iwQFwGVHq1zQ03mGD6r3WXS3Sdb1eJdLyrxswUKIaUPsiq/25Hsik5i5aUFJ?=
 =?us-ascii?Q?mEoL12GipTk7MwbOgMI5+swsCT8alFj1JBJbs96YWju/+rIPiym3QPsmxjn6?=
 =?us-ascii?Q?DXZFigOeBu4wc1HV3srq3rY1NmY896ftnIATcRXnApw8qCzBgIOs2cTbyVX4?=
 =?us-ascii?Q?DYZ6vjDSz10lfFU+z/w1rZDAhQo0QfVGST1UbxElBnhlnXI+6LYDoYxH6pYT?=
 =?us-ascii?Q?VHe4EnwvmHKg6kZuK/Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7bf32b-067a-451a-a5ec-08dc86564992
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 18:27:13.8987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQp5aYyFeB6ES86y8UmFSccT+vQ2S/in/Tiz8ltnwGFJJh84XAdutfIg3OUNXRJvUrBw0opRbQb/5VqmVt9QSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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

[AMD Official Use Only - AMD Internal Distribution Only]

Perfect, thanks for explaining. It's fine then

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Joshi, Mukul <Mukul.Joshi@amd.com>
> Sent: Thursday, June 6, 2024 1:11 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: Thursday, June 6, 2024 12:57 PM
> > To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Mukul Joshi
> > > Sent: Thursday, June 6, 2024 12:51 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> > > Subject: [PATCH] drm/amdgpu: Add missing locking for MES API calls
> > >
> > > Add missing locking at a few places when calling MES APIs to ensure
> > > exclusive access to MES queue.
> > >
> > > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > index 62edf6328566..df6c067b1dc9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > @@ -801,7 +801,9 @@ int amdgpu_mes_map_legacy_queue(struct
> > > amdgpu_device *adev,
> > >       queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
> > >       queue_input.wptr_addr =3D ring->wptr_gpu_addr;
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_inpu=
t);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > >       if (r)
> > >               DRM_ERROR("failed to map legacy queue\n");
> > >
> > > @@ -824,7 +826,9 @@ int amdgpu_mes_unmap_legacy_queue(struct
> > > amdgpu_device *adev,
> > >       queue_input.trail_fence_addr =3D gpu_addr;
> > >       queue_input.trail_fence_data =3D seq;
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes,
> > > &queue_input);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > >       if (r)
> > >               DRM_ERROR("failed to unmap legacy queue\n");
> > >
> > > @@ -845,11 +849,13 @@ uint32_t amdgpu_mes_rreg(struct
> > amdgpu_device
> > > *adev, uint32_t reg)
> > >               goto error;
> > >       }
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > >       if (r)
> > >               DRM_ERROR("failed to read reg (0x%x)\n", reg);
> > >       else
> > >               val =3D *(adev->mes.read_val_ptr);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > If we're following the pattern, this should go before the if/else block
> >
> >  Kent
>
> I wanted to make sure read_val_ptr wasn't updated before its value was re=
ad.
> That's the reason to put the unlock after fetching the read_val_ptr.
>
> Mukul
> >
> > >
> > >  error:
> > >       return val;
> > > @@ -871,7 +877,9 @@ int amdgpu_mes_wreg(struct amdgpu_device
> > *adev,
> > >               goto error;
> > >       }
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > >       if (r)
> > >               DRM_ERROR("failed to write reg (0x%x)\n", reg);
> > >
> > > @@ -898,7 +906,9 @@ int amdgpu_mes_reg_write_reg_wait(struct
> > > amdgpu_device *adev,
> > >               goto error;
> > >       }
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > >       if (r)
> > >               DRM_ERROR("failed to reg_write_reg_wait\n");
> > >
> > > @@ -923,7 +933,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device
> > > *adev, uint32_t reg,
> > >               goto error;
> > >       }
> > >
> > > +     amdgpu_mes_lock(&adev->mes);
> > >       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> > > +     amdgpu_mes_unlock(&adev->mes);
> > >       if (r)
> > >               DRM_ERROR("failed to reg_write_reg_wait\n");
> > >
> > > --
> > > 2.35.1
> >
>

