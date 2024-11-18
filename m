Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B1CD4921D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 14:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7052C10E4E8;
	Mon, 18 Nov 2024 14:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFhePaHc";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F7110E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 14:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibuQDHgR/QCsh60vdc+bBN5LWESWFLOd6FQS8eaCIqkqC7uoNR9XIQhaip+6e74t0wyrRwtMfDC1OFA3QTWUV3iiuu8ZfdwN/uXp41cXzHkWMasXBmlXC1zxKJEkQtM7d38Ub4smZz47brntn1EkswHp1VfI9vmCQKQWqtsvtmWAqY8fCxMN63h89IwFB1p2R+3Sgd5dlKLBJrDLzKiSs6SHpGbbV4xTXGJRlO0b0K/Yu/M3J1qfO1dMYKZU2145MUtRN2hHOAUkTytXAsMdIXieITgFWBRuZZts8rj0KmiWTWB1hekFJ7xPBjB9EYJv9zF3wdcBIy9Ak3sfL0iSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWSIbvj8pPN1iF0k3ETBKyG78gX9bZl3+9DJUF6DR80=;
 b=kmkICrl9DGVV4v7UowF91yEGdamjUGyyqE64DGson4tVbXQUoi1gZ8FFNeGyivO6ufRmrjc22EosiEL2S9LGUygPXMozRygiOCSZs2FThmTlXMhnt1lLvhb9Kqx1VoXwM4TErjsFvv+d54MkTEZxI92IsqxC5Wjqd+Xf1p0qI/zXqGE7O2JfMtzQnAfnyH+1JBhONR7Y+Hz2slDUehQHwQSlgT7vw12ywO86ITc31+2aFSg84b1WrPnjAj2rdMvaNNOKHBLAd97bjJX+0N69TgxeTAkggCIjpRQN9tzv9iY995mYgwATet9Btll3SGbyxKPQUNZAccAtm/B2B18hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWSIbvj8pPN1iF0k3ETBKyG78gX9bZl3+9DJUF6DR80=;
 b=dFhePaHcHeUlVpa3fveihHoclF2qsS45VOVxYgmh+FKBDsGruCzvIJ1fCCBOD0yOa2gV5oztyTzU4mpfT3a31P+vsPOrL1+iaVCsOpKTfENNC0dKqaIji/OynHwiFwr79YrQ9VGIfRz5jF3yLewAY8H7Ps73cDmCC50JxIT9BT0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 14:38:38 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%6]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:38:37 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 0/9] DC Patches November 12, 2024
Thread-Topic: [PATCH 0/9] DC Patches November 12, 2024
Thread-Index: AQHbNT05CvnakhOwP0292rrpOwE/srK9I/ew
Date: Mon, 18 Nov 2024 14:38:37 +0000
Message-ID: <DS0PR12MB6534FB2D6FC9B3733F5627179C272@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5759bf39-bcca-49e4-b8aa-f13eae5cce36;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-18T14:36:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB7671:EE_
x-ms-office365-filtering-correlation-id: 0c2bda7c-1645-4f64-f435-08dd07deb045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?56AU+IS3rsUvbZr+XR+wP4d+8FuNHHod0Kcqdmw+b9eYCdGnhbYPFwaTBU?=
 =?iso-8859-1?Q?x9hy6bcKI4IxjBwGeNeNnBhqCixE03i+G1s3ZfH9XTD0DrCD7IVsjt9VYi?=
 =?iso-8859-1?Q?/xPSK5g0LQEDdnIg/UpRTEGSVgPKE/KUlCQnocqr18BsJ6KI6uAADQXJbv?=
 =?iso-8859-1?Q?e7y4yrvDorEY0kTBSdpLej2OjsfvhrWrFsF+NEDWLuIF+gIK5KaR/0nAvi?=
 =?iso-8859-1?Q?9rghEzmLP/EwiMXpI+Gf83fA5po0NRS8Noe3R743uUJQXlOn9DSXP2a9r0?=
 =?iso-8859-1?Q?sBh3cczSb4P7KmEgXeV/5sOu9fRAQ78OAlfvkMkjsppJ+CG5NHf+LoXIO9?=
 =?iso-8859-1?Q?BGDLsKFhuBSK+kyNTNeejKr6bLAckXc+58d1i6rLfO9FBYNd5xdB8DZoTW?=
 =?iso-8859-1?Q?WZk38ydDygZYDib6DHkzpGjTwsiq1FeaDiE1QJ2imrBjN+/llyJqRbQlZY?=
 =?iso-8859-1?Q?LV3UqFRMRmMeHDCBfhrS5T6qkgcHMUcsA1zjhtzrpF7ID5+GeJJXWXv/z1?=
 =?iso-8859-1?Q?4L0RA8lbjZpi2flWMU7vRzCfMfJ6dkz33F2c8XIMkTf+yLULOEbYyqOC5p?=
 =?iso-8859-1?Q?fz6oDeT7IYJgm0WH2polhbVq68EbaII09xOKTUT2cswCF6gY5RrVUyst8B?=
 =?iso-8859-1?Q?NQK3oSCWcZNwTNQRA1Oez3bdwAGKg9L/BfB7CZK/qqTmrR/9pPgvVlmCtQ?=
 =?iso-8859-1?Q?lffNd2EE6/eRZj/dq7TbH11lFMZTiYUqfvMNR+lDDolQu6ZuWdpsZAvuv1?=
 =?iso-8859-1?Q?oRpwGgJMrpZ7F17yPDYLKl3heUZn8X9GAMnxrrT9wAm9cjPGewIRDN5zX/?=
 =?iso-8859-1?Q?KB7glrHVIpFo9dbevSr3RckZZmIophvCFHCjI/1CCNLcvW58OuwhEfZ2qb?=
 =?iso-8859-1?Q?zaxHQLzfAy4/Ep0EDZjCSR7L5oyxN2X7klYznD0gYhyUdzKHoBD8emkm6D?=
 =?iso-8859-1?Q?o4GFjywNv7jZz4HAvEsU+oseMr0C+/pwtH1L7ozEZrFBVaTmPFOSxrq2Nv?=
 =?iso-8859-1?Q?hxXn2i4D+ASVXL95mLWNl2dnsCo4+uyyx3XDNT9MSyutz48O1YA22X1T0J?=
 =?iso-8859-1?Q?jSGQAldO3RdwMTFWEESxN11yFhOktwHcRCU0PPAOarXauoGJYzIvwSVwKY?=
 =?iso-8859-1?Q?Nt/mle3E4VHiIeIA4jnSSs2AELqr6JaQEGtJlZLyCWbCFKKwtkBLWgv9F6?=
 =?iso-8859-1?Q?ZyvVwVg6dBWnVde+F32EyNKOKCUIt0s7Px1g46n+ZbLGw8EZbP2JtRtFHx?=
 =?iso-8859-1?Q?MwppCnn144LtGt2eWWT2ayY4ZhTPTrlTHyPihW9HoGjUNy+OVZ5G3ElEtG?=
 =?iso-8859-1?Q?3765MkzoPTNe4YDtTo5eN6r2hfsWZ37dicn6w0B2H+7aQ1eqkwEs+JosRZ?=
 =?iso-8859-1?Q?7a29blgsydPYQ586TZ0WWp1hm2ZluCpF1TcRRlZ4sIkbWTzcyic0Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eBoIzGK/NSlIh6DTFjDvaD5oLJPMZP3SzQFmS4BL2EHOyAlPoOVGfFYnxq?=
 =?iso-8859-1?Q?MPU5AKU3L2/KVjBOKD+OBelmhmki7Bu87UnhQtuH2qz7XvADRtFOyov+rF?=
 =?iso-8859-1?Q?tOFaTGp4N6/p3Txuj+FPhNqsHBzQPGiFg8rmAD8w5MKE68g/D/Gw/dpo4q?=
 =?iso-8859-1?Q?ZgqMbxwB8+qx5HNxFmfxjYdPH3kgPeEZ7D6LSCp0sfWK4GEwvWzB+uq/U3?=
 =?iso-8859-1?Q?EcGFNYVtPdXtCoAWzFrS7YRwRnRSvMDXcQUXnddR+vemBhMU6Wr4EuFLM1?=
 =?iso-8859-1?Q?WUytpquNwW2M8hzToDFdV/sE6ybH37ly548dK8ZQJ9OtdihExByXD09USp?=
 =?iso-8859-1?Q?5Fd+hY3lBGkZDSCvgScp10s0KvoP0mRiQsT/B8L3wDt3ncAisium1NPSRx?=
 =?iso-8859-1?Q?xTPA4ZyEKQdA8p8MAkL7iv3yVY8pTBuXucM7s3FkHCdWirO0nND0CdUUh3?=
 =?iso-8859-1?Q?nlP7B6f3Kb4CIXgqy4wh0oXGO+t4Kf5MAo1h2RFtLh8/EzqemVqzAnZtW0?=
 =?iso-8859-1?Q?xIy2guDtvZJ6v77VM0i+cDWFDf7cuT6xlwkK4Euc3iUKONWWCM04IrlpCj?=
 =?iso-8859-1?Q?9erN+E1KqD8WX7teTrPvx6DzEoo+pFZTEOqoe7UtV3OOEFNeHuoovkKQrM?=
 =?iso-8859-1?Q?Wg+T9Oo5AmPzcnIu4RjYRc185IYdPEgtGVom4RTGRMbv3csQUSgaRVldop?=
 =?iso-8859-1?Q?FNkVLoKwhAFXp/XZLkpXuwVUJbz8aQxsuXHTm+k8O7pkCkra33NwCFp6KI?=
 =?iso-8859-1?Q?NGxb70osWI5Wg4Dn7DE0CledxS3GNamrEVGJxH95Qk4Jd2GfxEZj+0L3or?=
 =?iso-8859-1?Q?xC0OCCjEv8crVZrXYJ3SggKogYlQYicZvqI6ubla+MoOekfLg3Of9CtCTJ?=
 =?iso-8859-1?Q?1G41fPr0x0DWvokW8IdA56of7IQ7QWY/8ID4UifJvoSvy2xgtm7vyMyhXQ?=
 =?iso-8859-1?Q?eqvlVJWenksYhhmZp4EB2bJHzHkEcokSiWnvn7nsT8gWmqxAE+FZIqfbGl?=
 =?iso-8859-1?Q?XtOes1PpFCAex/aTyZZIBghEWerjnoxNE9fR2wEHdCN5CAsk/4iyAqkCV1?=
 =?iso-8859-1?Q?PofechO93G8UFcMC519x1d7AjA4i6367BBgwi7CJLn7skBSu7rhM3kxyJU?=
 =?iso-8859-1?Q?Xems6TOuGNqTRYHSH++z7gjCxLFGIUSTdA4kglExUJpk08KqfuWKva8tuW?=
 =?iso-8859-1?Q?2mHD5M5vIRlVbyuFyxnw5S89GCs0gmg10Y1+iJQztlKXUn0p7r9NYyO/ie?=
 =?iso-8859-1?Q?mFrkjc6rkTdJcnRPyT9+FxPOJv2jLaHvbBDIUvE8JVnUsWLO9ilNWw4fml?=
 =?iso-8859-1?Q?+xB71iLzXHb/dhFNqDOhvzoH9fijGjrRxgpNk3V8EozGwF45RO2xJ9wQXh?=
 =?iso-8859-1?Q?JcXhhLs0Lo4nktziTBRcHmNFphbfvuSnYJmjfPadM9WAYpVTEtt64h6KuY?=
 =?iso-8859-1?Q?35vGax7SlgPacTG/lHMfnzwFAr3KHO0HIrd8hSddMz2TUfwZ8mMesA14Vu?=
 =?iso-8859-1?Q?VAMUDr+T7pRsaXPqjMcEt+CohIBb8QhUm4VJmYlZRcCscTm/1lhHSxFkBB?=
 =?iso-8859-1?Q?E11hL0AnrMVJnDDLTviWVBDscN+943S1Fe4RyMIdwcNeg6KuYXsGeBEXp0?=
 =?iso-8859-1?Q?9GfHEtVLKd3Rg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2bda7c-1645-4f64-f435-08dd07deb045
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 14:38:37.7957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gq08m92/jiw9iBWB+ZntVwRtrJXKXvk1QE/5ZsGF8x1R/8IhKn04VH1gAZWewHDs8iH7K+2iNd2c6LpB4gGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz, at a max resolution suppor=
ted by the dongle of 4k 120hz YUV420 12bpc .

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 6d0=
5371e967a70b6b3aae52114e3b4127b1a69da -> drm/amdgpu: update vcn_v5.0 devcor=
edump on per instance basis) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Tuesday, November 12, 2024 2:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 0/9] DC Patches November 12, 2024

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.310

Austin Zheng (1):
  drm/amd/display: Populate Power Profile In Case of Early Return

Chris Park (1):
  drm/amd/display: Ignore scalar validation failure if pipe is phantom

Dillon Varone (1):
  drm/amd/display: Enable Request rate limiter during C-State on dcn401

Joshua Aberback (1):
  drm/amd/display: Fix handling of plane refcount

Ovidiu Bunea (1):
  drm/amd/display: Remove PIPE_DTO_SRC_SEL programming from
    set_dtbclk_dto

Samson Tam (2):
  drm/amd/display: add public taps API in SPL
  drm/amd/display: allow chroma 1:1 scaling when sharpness is off

Yihan Zhu (1):
  drm/amd/display: update pipe selection policy to check head pipe

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  7 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 15 +--
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  6 ++
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 23 ++++-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  8 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |  1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 24 ++++-  .../display/dc/h=
ubbub/dcn401/dcn401_hubbub.h  |  7 +-  .../amd/display/dc/hwss/dcn401/dcn40=
1_hwseq.c | 13 ++-  .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 97 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h   |  2 +
 15 files changed, 166 insertions(+), 52 deletions(-)

--
2.46.1

