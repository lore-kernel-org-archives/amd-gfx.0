Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1DD2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 05:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE4D10E235;
	Tue, 20 Jan 2026 05:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cR+37GhX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878710E235
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 05:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzKPkYoSYiVcl62rmBpUlR7RurCaFNLEQQYfu2+I2NS8w/QSjLj/2NZ2nW6dq9MrLPdzbhp48lDQ7TX94bJ6zFgz6of+hevBk3C9IPnJui+YMGoUMZ1HFkkV7Zb43m1dEOdu8SABuR5v0fZg0F4M6gyllObVirTKe+25gI8Tyoal3A7yKvwj6AVuK1grZbL+PjjG0vSIWAFamenYQHE1fu52ZiyQaRjrKa4WvdBfkjNzcYg2/E67pAq20K8GPmzFht9b2T0EygeFVZPCCpmBq2WCXQ/knOakQfIL+nTFD8XlUB6dKrmYfn63odA52kNWWW9sYctskINpZAHGs0rEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKJ5370rhqr/A7WXfmY0jx50RZC3OQi0EzCZwYOSMfY=;
 b=BxCD6TyohRxpzRNy/BBOAH9BzrBnVaGeXcVUDPvRA2w+F8dDLpksOoQEoJnMVWJt5oPBBOd5dXZ9DrIrW7gwpY0NBUt/oAbBY4DsDEx9vFEhrvc/47XYIRJmBleFMMwTCLh5Nhc2e4JYocAglDz8EKwl5YWjSxLynC2gaKCkokpYixNAOTHozSDM/kZzlR2aNCZcZoNMkN//2LcSzftJJUwqJkzTnHEUUY5TzFaDK6DVH0XvJ7N9qLTRsDF3AbbBW8XLOr47XHKC2G2GrakFitxb2Yg0vYPTGk3hrKCEui/Wz/pHgSe7hfMBS5D5niwVHm97+qrmFb6yWXttutQ3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKJ5370rhqr/A7WXfmY0jx50RZC3OQi0EzCZwYOSMfY=;
 b=cR+37GhXI/thI1TtYEqeod4wquaPiNs8+t0ZTi28IcuVRU+rSzj4mYYSBIkphX6XO8ffQI7E0yP/spaWaKlzY1B4GOY6Bg1mPaLOJL/npyDIrYktfZ5g+gte+qlUaSmBPC5Q8l1GJf9PBiQ/ypB5h/42rue63F1Q8UoU/OJOlvg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 05:12:18 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 05:12:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Thread-Topic: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Thread-Index: AQHcicHOr+aY0rpEMkGKYafIBHjszrVagAIA
Date: Tue, 20 Jan 2026 05:12:17 +0000
Message-ID: <PH7PR12MB8796F233C5A112DD0B94A051B089A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260120040339.1086611-1-ganglxie@amd.com>
In-Reply-To: <20260120040339.1086611-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T05:00:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB9503:EE_
x-ms-office365-filtering-correlation-id: 15634dc9-1608-47c1-d859-08de57e27b5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DGbuXw3/68h3vj61ky+M/0jxWG61kb/bxp9AMs17epmEAaQB3KOcb3FeGHrV?=
 =?us-ascii?Q?+lOFFQ/JF0pXbLDa9bkUkr2lbSa8ODTpWTISw51h3dlPCc/avaGP3AEHvcv5?=
 =?us-ascii?Q?aTXVgGQmcUaBh5c4+A6v6oQVNuYKAcXAr5jq49GNdpuPbT5xMeB6E8DLK+Ty?=
 =?us-ascii?Q?Tw0hS4+E+SFbbn3Pzc+EICLaeiOZknHJPeHKwF48XsBPq4Z+vlLk9d0cGgNl?=
 =?us-ascii?Q?Vyc2d3nindmalHoAKTpoC9MMIjiCN+3njBOksEIw4JLUzC4SqSldy1/I9Fut?=
 =?us-ascii?Q?uZt69xua36lsMas/xJbh/ZR/cHhNmfVAMa4/gF802DzryTcitTgcTnU6M0YR?=
 =?us-ascii?Q?U+NJ25957OUYdsqBcJy/cGCFtVAbdFvpZVoiTMaJkM+JHFY6zT1UvthvVoal?=
 =?us-ascii?Q?EJ0yATnnIwQ2S2Dq4EytpwmP5cpIFxb1XBbiXvehsvA1raXnP5grUoTEwVU7?=
 =?us-ascii?Q?YMiAmxhuB/qgaidjwFfZ0oi/frPuZGNYt88hRBcVU7xR6/ff08ONAtQHEBZc?=
 =?us-ascii?Q?af47gn2T5R0b3+vHYXJy7YnT4lkYN7fr0vZ7tI7FkSFDWrJp/GkU3W33D2k1?=
 =?us-ascii?Q?//NYXjxwGnaKQLqWJjdwi+CGIqSIvHta+uUBvtZPCZ/C64RF4uczCV7nVYqA?=
 =?us-ascii?Q?RyakUlQ1jX78ZkNGItuj0ozsryRkd+avUcljOqj7eR3rGbzvGXo1coi5AOdA?=
 =?us-ascii?Q?tHqRg4VDxIVCOF/r1LiiRmOzCBNCLu548s3dHnNlXqYg69CQL2SW+Mxd6btO?=
 =?us-ascii?Q?cvBRLkCmHLM8ffyG0/ozU7MULWDrfF6cyiIoCHjq/qydI1kkJytXuUQ+NPIg?=
 =?us-ascii?Q?mdu+2HtO6vwHrB93xWE53YaAsC7XkVYIVXoBeluypcPDS0G/EJG4bDLmTaXz?=
 =?us-ascii?Q?pUzmHpf6m68u/JVZOlHaRXjn4bDx39fm95RlO75W2Q6sTjYKNbjHXT7Yg0jK?=
 =?us-ascii?Q?NK6Q28UkLdoev99zo0I3ztA/1sQfpWO48kyVumemMqiht2kV5kEqKjl95Tn1?=
 =?us-ascii?Q?tAq1Iu9AMAQ4UpI3DwOnlk+0AeZOfBRWJS8R8r/5N9KQNiXx/7/GiQN4nQgJ?=
 =?us-ascii?Q?ZWAThp0QSaKLer1CjfsSnW3zThX+xnNPH/u/ZyfnjjvMheGzY2ovnXT+sFJz?=
 =?us-ascii?Q?H9AS3yxowHxxrVR4BMAqucZudCow1MX9RkI3Zn7XAoNYruRTwZjPnEg7Tal1?=
 =?us-ascii?Q?3nGp48kQKvIQSkrkpTLMWnBkxlSoBcbLq3N3ySZHqL5YZsQGQz46b0qYWffs?=
 =?us-ascii?Q?eMvxJh4KJWPPezn+uvZKCiiqhr+6oD+/Eu/TbNGTjcd3fm1BmtyEWbYkN5eZ?=
 =?us-ascii?Q?7ThGAE3kRugbmU1Dfl06XUfkOT3HCgz1POYwmiXozFwJBgX8JpanKp+OI6bK?=
 =?us-ascii?Q?pb0QgaDx071PgiFAePRmGmkuhM8sv1CkBYBbcH0pWzSvS3+n4s/yVYbFGGC+?=
 =?us-ascii?Q?z9DjGIN8qK+pnsRE6BGQFelIelF+UKWCYz2kPewPWwZiGcO4CLayq1Nf/DbU?=
 =?us-ascii?Q?GLizp82+9jOFKIPb4zG1tS8UUdynhvnj/vVf9+MLOtcZec6yeviyTT2iEqHB?=
 =?us-ascii?Q?AdXEw6MqvbDo7cbkK98O02NSOver2IwaN0Gvy3sjAU09pkDZvzx80GAW4u4C?=
 =?us-ascii?Q?7oIKqB7IZPNH9sEcoWpnv+4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CfRR2bvdyQWY+ty6zY6nhUlTNEedwv5fl2Dnewck4uRchsQGuYqtxy6iSDAr?=
 =?us-ascii?Q?Da3+zTcXw1bnUMmNp2hV1GBQOqqaTPl51O6Mtg/rCLikuJ6GK/NrZmvrqmkQ?=
 =?us-ascii?Q?fe0otV8gULU/nzqJ/L0HCmz+mP2WPeiXlloaY8vYQJRLSkpneY0bRvr45b/6?=
 =?us-ascii?Q?1wcGbiyrJxhpq6+VY7cmsBEyfNr0wbnu34cK0JzM+Yi9SaP2ree/8rfnHqzF?=
 =?us-ascii?Q?QIcqdY7J8Ax85kua8VrCbQnooEYDnKfDa2JF677O2YnDP20nECfstAUmaUN+?=
 =?us-ascii?Q?L/VTwk1ibcAD1jCUqbMceWd3JJ1n8UlDfk/PKvpquiGlv90nZ0wlxIJNE4Qf?=
 =?us-ascii?Q?iUVrWBD3h/I9D9hSX1CULgRsyayFYca6jXRVzGn7ay+Sw1LvSNlOjan8S99e?=
 =?us-ascii?Q?Pg7PpR3YUvOZ74A4uq0Ia+t/O5Cm5i7BA3MlQkD9bBAgIB+zcmCBzA8JD2t5?=
 =?us-ascii?Q?TAPYFtMOSwjFyMeuZUp4h44xeqE1M3R/S/1hV2GW/OMnxmkrCcNLisQpBfxR?=
 =?us-ascii?Q?58JKerHtyLdCBxLlyjvGNJBN+zNdTtMvlvZSpH90nzyK1EOOL30VJHuIlP6A?=
 =?us-ascii?Q?yy9pyjnYeuxAFMyz+VODRVW59A7fCpVPn3MCc3XTtbvgoWvUPOIPvHQ2mvm3?=
 =?us-ascii?Q?WfbeidmXELnuGnbwduHPzZBxiAve2AVXGQr8ppp6yfkDiiq4TBBxy7BiWAMd?=
 =?us-ascii?Q?TlLCZOEIdCjkckz7xwRzifhS+PHjAq+T8tGbIOJenJEF1MfG98cHn3N/waNw?=
 =?us-ascii?Q?r0JfWe90S6GqY4L4QXfyrTwrWRqdqf4hVICdZ5L7IvFnYhz+lus/z90j9Pzc?=
 =?us-ascii?Q?Fny/DzmhTl1h8xDGJwqFbKOV6bCMbGfD4ytFMYWEA2PNnRSQI/GXQzZlrVYX?=
 =?us-ascii?Q?JbVdewUd3IVY6wuzAYNeVskC7XpEXg/SEbewAXvmYTucCQEJaOd5tZ9soTdp?=
 =?us-ascii?Q?8tIJPb6wLGrcfaI+lIIVaaEC7RZQuzqCSRstXMLQfyB0FANMSL8tWb+ZtRmc?=
 =?us-ascii?Q?TqWfkx1N5tGmpRYh7/lpc5YrQO+w4INFQsfsunbtFCFjOqDQIHghVG7TJS01?=
 =?us-ascii?Q?bgQw17u2mRRpg6+PyS1KSqNsYFsMPhiMnv8GueY+dh+pL4zsbjwt0UbDY5nl?=
 =?us-ascii?Q?TJ91xFpdyltTJqZhrhe3E6hpDcuoDhbCDAKNmclhq2LEQGrRxFQXM2LqeEjN?=
 =?us-ascii?Q?RLayN2RZetBTzvE1ppfTrAdk+xfkUk9OAs9WmulNX2HNhd/A3AVaYl6m1S0B?=
 =?us-ascii?Q?/4wSpjy3IKMiNunswf/htDftgtqXtYroXFIzszWehkQCCC8ZRS1NPO3t6MXe?=
 =?us-ascii?Q?HM9Bf65f/ZJF/pubWpBJ2EN9+G/6eBRn/0ccxkJUel7wnGpdmgPcy6V0orLg?=
 =?us-ascii?Q?4zwCiNm7Cz6tgvhW8aQVJ6uxHg0YVV90FYCPNFIZ+JtEAFyljQ0iaLhzJ46j?=
 =?us-ascii?Q?FhJ2U7hLIORykcQD3YeS7Xyh/XK28MDFloIkIer9SU/37UKKzSQsOZ/kRicc?=
 =?us-ascii?Q?Or6f0ePv8q3QNzI5Qk1WWoKr9HYVHIedy2dnTlNkd9FH5fPN6hbaptqc6PcW?=
 =?us-ascii?Q?PfSSK8cVpg5arqo88BwZeWS5V6/xIBabQ64jrU7YBKKQ+wh18zJFmP5z5SJQ?=
 =?us-ascii?Q?UT5WtyOIfa9dMx9CMjtCFX5Pe4VYyjSo/lJLIsMa5kJptX5hDpGiyqOJrOlX?=
 =?us-ascii?Q?wOn9smRmaB/nfYUYDb2SdwazM6utwW8Aqc9KVCFPb/ebHisM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15634dc9-1608-47c1-d859-08de57e27b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 05:12:17.6503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S45EGOJD1qfzHlYMsWk7fRYQe65Zr+/RpD+0b9mcxs1DY87WLCN24pM9mgDqOazI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, January 20, 2026 12:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
>
> set retired_page of invalid ras records to U64_MAX, and skip them when
> reading ras records
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0c84c7ab36d1..13d901c0ed6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2784,6 +2784,9 @@ static int amdgpu_ras_badpages_read(struct
> amdgpu_device *adev,
>                       if (!data->bps[i].ts)
>                               continue;
>
> +                     if (data->bps[i].retired_page =3D=3D U64_MAX)
> +                             continue;

[Tao] the change is fine with me, it's better to add comment to explain U64=
_MAX is used as invalid flag.
With that fixed, the patch is:  Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +
>                       bps[r].bp =3D data->bps[i].retired_page;
>                       r++;
>                       if (r >=3D count)
> @@ -3090,6 +3093,7 @@ static int __amdgpu_ras_restore_bad_pages(struct
> amdgpu_device *adev,
>
>               if (amdgpu_ras_check_bad_page_unlock(con,
>                       bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
> +                     data->bps[data->count].retired_page =3D U64_MAX;
>                       data->count++;
>                       data->space_left--;
>                       continue;
> --
> 2.34.1

