Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87710D6E2A2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 03:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308A910E0FD;
	Wed, 20 Nov 2024 03:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBV8wJE2";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF6610E0FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 03:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/rtDIOoYE0UaMYH9CcbIX52gPWLWLNcr7+kUrlxePLKKQQ5p2nDMDyOIWOh+C/dUrzUF40hxUfB+aqI94nlbq37iooHQDJZgqqwyvPdvH499zLLxT5B7wraIk4WA5KdYfSbBsSu2VyOJ9mPz5ErhvEd2Vz4G5t1ezk/H5cBMxxU51eHo45LxB3rm98JrmVz9woicm2eZ7RxkyvqZHYcjgR3dgR8yoffe7M1DIA5z1VZnTusUnAcjnT0ecBwXLdLYT2YFkb9dUyO7UKZEcZEurziPj4Qn6QVEmzZXH6QJaxp6cQiJUkVPB26ollkd5RP19Olhlm9gDpd9Ps0J+b/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAUMj893RiaOL8s3wfyqJzSvF5F25Xj4rdVwKc/QrPw=;
 b=YRDFEdxHJgUFt2np92GK9XISd+/W5QyHfyULAw0t0WU0MLx6uyHrPjM+f1WbRCpfQtZiBqQ6xDqezaWbJsitYPyiZXcI0JIxOJr9xNs+vDluvqPhpWGFhC94sAimtjO+h3f+oiQWKzHdnkYlFeLQ5qOJhsVTVDKgjYZU8byy/nKAKAeLZ4ylEbNXad2zuw/o04SIOecsNPd9uRPkT6M1AwJ5tWtcAF2N9xHngX4g6sGMKRCJaugjmbYYTwkg5vOyXu00L6EispauGLccqSL3/CinT7woajmd/4PZopTwSs49RqhlWC2IjkEThzUMvTj0q23ceJfQPFqX9rU0VewvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAUMj893RiaOL8s3wfyqJzSvF5F25Xj4rdVwKc/QrPw=;
 b=LBV8wJE2QvfceXDyHgmnZ/q6eF9i04HWvYbcHB+NZQ8Q2kwPqUbrgsoIxOuuGFtODTphVwooi7QJiLzntNVKDPe+JRxeMsVYgLu8j37Je4HIqlWEegfYhPinPuK2xwVmwHGmZQlwGcee6tvIvpLyM2Lrl/WkvUfQj0tvoMclN2s=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Wed, 20 Nov 2024 03:08:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 03:08:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH] drm/amd/display: Need config check for
 drm_dp_mst_topology_queue_probe()
Thread-Topic: [PATCH] drm/amd/display: Need config check for
 drm_dp_mst_topology_queue_probe()
Thread-Index: AQHbOvT1rhxmx9Do+Eun4+U2lysz87K/fOuA
Date: Wed, 20 Nov 2024 03:08:35 +0000
Message-ID: <DS7PR12MB600539BC9C96D19570223BFDFB212@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241120023412.322957-1-Prike.Liang@amd.com>
In-Reply-To: <20241120023412.322957-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=967938d2-26bd-4eb8-9f7c-851422a8024b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-20T03:08:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB5837:EE_
x-ms-office365-filtering-correlation-id: 01ee267e-0d3d-4201-0ca8-08dd09109f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qi5I+i6oWZDqdPV7x0386HGlAeFHW5mw26Xue68h2Rm8qUeMTdnVIzHLfvVr?=
 =?us-ascii?Q?4CUALYdgWtmh6+X9AjiDnXpVcdlq+jHGx1hh5EgcFcpphaqytD0jmBbqkunT?=
 =?us-ascii?Q?JeVTXDBeu++mOLx9B6KrYl86z3wX3H/7zYP5Cz84sYQYW/oCsn57ZNslmb0o?=
 =?us-ascii?Q?qGfS7w7cu/umZgA9BCtbTkRPfKit5Fpjw4DCRfyHUMxZsIAtGkVj7TO9g+Q7?=
 =?us-ascii?Q?aPbtM55U2nEriwUNK38FxGTA5fu3JALBtk2p87LauI0UT5us6O0SKoitThz4?=
 =?us-ascii?Q?SILPdWnTj8qwW1xKcx+onvJChC0vMHLjZNYQgGrL0AEUKnAK0oS5slQTQtFL?=
 =?us-ascii?Q?IkbquzW3f7Rn5kvXcqv2m6At9wsIT2TcUKtWiTYax4wr03Zd6x+/zjZcsPvq?=
 =?us-ascii?Q?GDDsVlYatZJCZ4QsXvq3qdlJncmvkMqKgH2/Y9IIhbQSq+aLnXyVN+GdgIls?=
 =?us-ascii?Q?od3FZc/dsZGwLR2HD2MncF2l/VoEWdzI3X7fjsUV7u6YH86NKSbpwKwGGL9v?=
 =?us-ascii?Q?5Ks4s/HuyxL4jwPj+69w12tgQTU492t/nPOADsPY8QkKbqGP7V2Fobacbtcw?=
 =?us-ascii?Q?E6l16uK3QU4WFGe0NJmn2nzjn33y9Cl83vZdOnwYC+buXmAK8ORZFLFk79xr?=
 =?us-ascii?Q?M1leYdFRnCDuYJ/6hAcjeu4hYBK3LUjwxllaBSQEN3fHKwn3AV/TJijL0Nkl?=
 =?us-ascii?Q?P5hampxv/EznqiFm6014UNf84AHXHh19bXGUZGiidrx6tvmnSdFLCoFZRem5?=
 =?us-ascii?Q?FZF0N/e78bPGr6OsTHOCkmZGOrKOTIcoZ9jiaTvPbeww37rZgWaa6qxCSryO?=
 =?us-ascii?Q?kp+DBly9IdhU0BT2wwixfR6rs7SBPvyG79r0sPdOyDNViAoY1VbDb/RDTa7+?=
 =?us-ascii?Q?YC+dxZ7TAz3FXB4DbPzA6T8tvZRTaLgd2OqYNXLIQB+guuawaqPms0ytTGyD?=
 =?us-ascii?Q?8KdIpAttpJh/YcN5BWvvb3be59GbXe7EOqCbKf0Uav6xBmeDPUE2H6P1nOWQ?=
 =?us-ascii?Q?fMsVOvPxAkFsxl3MIs4G/ofqVk9eortT8ETQy6tUQChSWIbAnzpuSNtf0HE2?=
 =?us-ascii?Q?MJTFrA+3l5Sk4aXTIDdqlfGEaE7kHQ/2kp7dZ2yFCiHAX0/AgvkTKkexCUmv?=
 =?us-ascii?Q?P1+FqaozR2htgUXwy8CROr/o+TIx47L0rjpTmvlHc51iF74iEOkED3EV/xhn?=
 =?us-ascii?Q?xJTZ60SApmKGejWlsdrCYbx7e9owQZvmuQ48BKguijODnO9EDHlvtWLOfa2O?=
 =?us-ascii?Q?u01755dpeArTvFqWhrKDJI6ecLx1wo/4KIIQwXQFHw8GdRNjzDi3SyWluxUJ?=
 =?us-ascii?Q?BN+SgTUQO4MobCmDwb2VfQFDEmMCp0WqDQWYw0e9P7OO+dK54+njbXgTnolI?=
 =?us-ascii?Q?Kv6LIAw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SYGqJ2tTB0SPJSOT3Bxi9ksIBPhOZILnbzqb6Htxksl0fT2ipYs28vVOesML?=
 =?us-ascii?Q?NdZqztsqvsOmGJiEdL/Ud5mo6RjdfBuvhhrWmBkrx8vGweQYao8HfiehcXF3?=
 =?us-ascii?Q?+Ss5jB/eYnqWvL8e0hguNjr9gjDLgFM5v0t9K17YxZn4JLds0tNcy8Wr0+i4?=
 =?us-ascii?Q?ckf678h0727RiKky3BdLPdeOODOLQYQZV6DpCbj6WGSHBL5ZZNUdtJrTxFSF?=
 =?us-ascii?Q?r3g18fDTpaeR46Jb55Tl7VZwS8nNtgc3yil8DecWuX/4ueRdXNPj9+tm+IuP?=
 =?us-ascii?Q?pUB7Lvdld0j3Ie3YpJlOFFy9loI9fXXeVcR0vWPFi/53VxQ7yoSeQSPsxnNQ?=
 =?us-ascii?Q?DkkMNQrRa1F4VD5m2/IRCIaiY22Hnf6pa4rCLJzVaYPBvAqX9vXQXuxKspn8?=
 =?us-ascii?Q?BA0rYd0Hr3FjiF1/k2La2Nw1VdhwidTb/q6/Z3iaxSw8Bz+jiSNudx7lfVBN?=
 =?us-ascii?Q?4RTCHYeiP0xvmKpvUjGKDnW+MSdnKSBvG15FTsF1gtkVer4TNLQINkLz3igP?=
 =?us-ascii?Q?ce720yahZle9H3rFuvKYxWIKLMNCTXDnNvtHOTii+P8nOSdA5L9ioRRZ92P4?=
 =?us-ascii?Q?+5Azl0qzOVA8YrnO7WbCqMDli8zwv9NN2Z7JNev8hZ3b3YL+u1sForB+RQ0z?=
 =?us-ascii?Q?EhA4ml/LR2dIrXGyFHOcgK+QRCPDQLPrHH25OtYXITENFQvX1zKzi0bHxK6r?=
 =?us-ascii?Q?x7ZzODH0SiHlr38NqgrT531j/VsSdFyr2miMKaIdy8fig+iCMM6r4Hzoy4uW?=
 =?us-ascii?Q?yyXF4OKWNb328Vk8/SEOABL/Bmv1ke2o+ufwwe1utQDGHFQZp7sJt4mRGV5g?=
 =?us-ascii?Q?k5vkpjE7l8NKbYVLOG8UiPU91E8Dq2qXb0LeqHF96e/ITXNj5XWADg9YhtHR?=
 =?us-ascii?Q?9OgiZD/ssElWjnKuMin/PhqioNhAJ7QhUZ29RIaDlo7kdZaQ8UuWW45lM3Ge?=
 =?us-ascii?Q?qYwDz5ezia6OKhSBBS7zwAY6ZLmPAXUwYUz9CSRCEEk27G19zxNE6DbGnxx8?=
 =?us-ascii?Q?s1Rt8XWP195EDbtFQJsByziTd5WPg8DscxWCj9n4U6P3buuDOfAn5dcuvUt9?=
 =?us-ascii?Q?wsrxaDZDZorCz0/qgI1dqUSshkoIOHiRsHHjwR0W6CiJk0DuWseT1Nut1wiR?=
 =?us-ascii?Q?tGZRe4yjFcUrSz29bPRVj+w9R9JUJRNB7uKumUzMyR88iYRCzGRCBIwmFqT9?=
 =?us-ascii?Q?FL6cnxrolc0QpHOPW8RoAIY9cOoLGjU9cC08mLIr+AZkOS0X7nbG1DLi42fv?=
 =?us-ascii?Q?EBmTVpXMABSCaKvKdM36uu3oIMEIzHgShbKqFow6/s5jKZZfK+vqa+Ir0lHj?=
 =?us-ascii?Q?ryrOsFTqUiIOr35lC1IsquQPXjd/zWGz5A9xL2hkgNJTO71aHO484fxxkIoF?=
 =?us-ascii?Q?mYY+aMS18DczjbEn4xNaOj2hglAyY1cHDUwqawHf4djN0EOp1ZmotRKSuGx8?=
 =?us-ascii?Q?nwPffQTrb17/ai6DiD+7XTwcKPjvtVxkMsdWSWSZR8PnQ0vNNYGj1KoFHFbP?=
 =?us-ascii?Q?fCPrxeI+cxMvMCWMHNaFuaWk+DJSCoyzh3knhUMnam5EK7RaUZmi14Mi+rmk?=
 =?us-ascii?Q?5I7zQu62TfK/G4o/4Cg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ee267e-0d3d-4201-0ca8-08dd09109f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 03:08:35.1807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmIhtRwxNXkao1UYYM2B+5MVxpEbZu0pQCYEhQ5fSF8cqR54WJ76wttgeJLc4UAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

Please ignore this patch for the moment.

Thanks,
Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike =
Liang
> Sent: Wednesday, November 20, 2024 10:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lin,
> Wayne <Wayne.Lin@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amd/display: Need config check for
> drm_dp_mst_topology_queue_probe()
>
> There is need to check the CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS
> config whether is enabled before uses the related MST functions.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 94f1651422da..21c0242daf19 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3382,7 +3382,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>                   aconnector->mst_root)
>                       continue;
>
> +#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
>               drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
> +#endif
>       }
>       drm_connector_list_iter_end(&iter);
>
> --
> 2.34.1

