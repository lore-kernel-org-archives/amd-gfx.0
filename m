Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 02:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F45D10EEB1;
	Fri,  7 Jan 2022 02:05:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EEE010EEB1
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 02:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo+85hEPT8vy3zZ8wlowjzLmEy/GBARq+VFHjTo4F1g1jgPZwhcYWCcJaCfNcZlXBx3DuxkAg/j6kAD4+/JvuMOphLUu6vphVgjqN9Ct4HwXxQ88b84eEfbSPVhEhwBfefn/3Ih1yT8t72qA3XDLXUQT74pveFVniMnkdAoEFBwY4vWRe1PUEp3d/EpGBM8HuSKWezVNKgci87PwXSZF4XZ+T9woGgRcVFeCrr5Rv1Z+8oefdH0oEyPxy1rWyOZvq7SZ5MWaz0lQTQfNuubJ0B2OoxDiDGmD0rkAQlychQ9bJJY+2VV4Yt2kml2qBWIxfl/kRRKlZaY2e8kpfUI6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqWOSFwbpLd2TTpNPiKtsOW5rMWEOkaD6WYMmtcD3KU=;
 b=PwOJskDRsoII2cyTv55USlRCzVghkp9BD6X60pALTWv7WeF27XYTVq7B9c5kcQ9PNv26zsyIK1F9UIjz8EizJNBdvSz0Cmc7zjEpL/7dhG/dwh2RZ/kAfJwRL7hM7i5drDD49byXN/WM5/2Qu/xWaMJb5JLKsZIRdfQ2IZj4hd5MGjuRUi+60IQHwl5Fp/hy6w3AhRupmBan2+gSnJ/wSIC8H+ask/PgDAHYye1a/iLVEaYU38mIYGQyPDMkXTWsU6CBJ27L7a37SMmDzzeeF16LMZQsq9sy7O2jxo0HyKCXY8UlFnyhYP8AVd6hTaH1QwfeiIjaytT+RIUWvz+o3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqWOSFwbpLd2TTpNPiKtsOW5rMWEOkaD6WYMmtcD3KU=;
 b=NGnJZigSE7C1GeDyYKtT+6IASXocQspvR2VsB1GyvmpqyX4LWCGgytTjpy28mfJ+k3WysfBTQbxqrhRQ7BgfRdPfHJHnTgQzAtHilDWsu0PcLCzpUjFo61/J5A1RWtm+93PrlcTvGi5aFxDL0U4aaNHYOw/Wppud45+C5E9Uhms=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Fri, 7 Jan 2022 02:05:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 02:05:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy
 Flounder.
Thread-Topic: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy
 Flounder.
Thread-Index: AQHYAs9DwBo+MaVkeUGLgpoW6DroKaxWPf2AgACR3KA=
Date: Fri, 7 Jan 2022 02:05:54 +0000
Message-ID: <DM5PR12MB2469F92C25F4ABF84C35A8D0F14D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220106073000.14878-1-PengJu.Zhou@amd.com>
 <BL1PR12MB51449E0379D8A2CAA705D2A1F74C9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51449E0379D8A2CAA705D2A1F74C9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-06T17:18:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9405054d-906e-4fa0-adbf-224677a10997;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-07T02:05:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c4fd51b6-41e0-47d6-9479-4e7b8f399737
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bbee512-972a-428e-fd47-08d9d1823cdd
x-ms-traffictypediagnostic: DM6PR12MB3770:EE_
x-microsoft-antispam-prvs: <DM6PR12MB37705009DA8B2B3F3201ECEDF14D9@DM6PR12MB3770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFeSA2ScOf/KMYSvySt0ZdXjGhtVcLxMfYqqeqhG/E6ATvsWTe0Y3Sx8RBOLZjKSm1dlwuS1m4mTDvUejaKchW4TlPDj47AopMMMcTz70WnqBomyhPyPH+xXVxC4CHINsZIkHgkNBq6QAmMmo+rUhhtB3VBSGaR/GJiPrh/JfwR2Fd+TTDpwvXAsM7Gng8G6KyqSzaBhky4qjY0mBOJNZfTre2ItadHvWipQG3LwK+lempv1zhKtYYulb7jnEnJG/oF8JINWX/xSzctTsBLxSlVXXB1vUa0aeoweD9nucCc5BK79ga6mxBp/fFgrNhoErlVHbhCuO9UWAmkWiI++VCdHF1NX24BJYQedZylB/46Z2baUVzUwcxY8ONAZYdm1qJxB4y+27jDbB11aWW9/qj2q1b7Mac7fc0fo/4wPcLWxOHDRO5DCAlJGVhWCJLMxqW/XTCbcx+DhvzkO6J1yi0cv1DEH2BQmtnahpN2pL5uHLQVwtRikbBxYXgEPe1SZW74I2OwDSRyWuwxvryjtZpG9CdcaV0no34kaCB8iVYfPx0Uy50BNiBolYLzPGl4rir39zcBPi3mLZjRfiMAXaIZmy+4ytIWSAHCxkC9a8xj6edmrmw7WE0cF+F1WB3+obQA9XkwIaYYftOG4jLqRLxwmtOIcMY1Oc5x22URL0WuNW8Ou2Zh+fkC5gP2Sp4iyQFtSbkmvlsP1mB4YfC+Z+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(66476007)(38100700002)(76116006)(64756008)(316002)(8936002)(8676002)(66556008)(26005)(6506007)(66446008)(186003)(122000001)(38070700005)(110136005)(55016003)(33656002)(52536014)(2906002)(508600001)(5660300002)(86362001)(71200400001)(53546011)(7696005)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6E4nqpmcRzS2trRMeUl0rbl1GZO1yJQ+I6fLsXmgiPm9v24P2pSvimN00c2r?=
 =?us-ascii?Q?4gIRBGwPFxDB5oHpnejWFJPV2MV1O8pZiQd/RTppHGH80yafESAY4SUiyUG+?=
 =?us-ascii?Q?fRGKM4lW1XmhKDnRAVWKglVekCI2Xim0jHrLmYLuBiIQsen4kZXbR2xSF7C2?=
 =?us-ascii?Q?AFwrvL251x+o4/uK6OZi0J/PVJgUf12r1KEbCDCa2gR6WyXML9jNig8f6bkz?=
 =?us-ascii?Q?N69N6+U3ZhF6/c0KrAVP5JwXyqz4MIduuqWYvCKBzTAG3L131cMWagbPcVpV?=
 =?us-ascii?Q?gZgE/579w7rdeOMLkPiTlgx2SXezAE0LAG+Mm01GotamPDuc8RCvYDuPCyyX?=
 =?us-ascii?Q?CAFwPhCOQUAgI9FXBKvNCeyR4+nX4h6d8O29MhEDFiLIuDNPutOQkitbV+RC?=
 =?us-ascii?Q?MkAjuPF+WT5MIaglr4ocuiv7ve/b+Fn9PNeVV2irkwuYiwpaZnA2sKyWKwM+?=
 =?us-ascii?Q?6DsdKymhfaFVLD/5XFKqK4e1BjmmO4L97yzTsS+73GQDc0qRJTubsrJ55wy4?=
 =?us-ascii?Q?EBh3vCIo+3mTA1pzetOrcvYF9H8UxoBAdbS5QQ/VAo4AzY+YRFgD0nCZOWir?=
 =?us-ascii?Q?qbOWI3gomF5dUmlvVmcFhQaVRX6swXTpwqeGt07OsLC5wOlfi7aoz+b3F/oa?=
 =?us-ascii?Q?vOMTypnEsC6D+3OJKbvvkGTtXYnC9b0ZmnTk9PiqBCqoZA5NsyccOudse8Vg?=
 =?us-ascii?Q?/7nnTpr6P06GCvOU5HYm/3tOEASI51RB/7lu77Jzu0aGS/GKrjM0IBJOJnMg?=
 =?us-ascii?Q?4u8lZDrpD6GFjrSbOlMQhxDsfU3+llBy0xjDVM39DzmJKlG2NYhUB+CZEJSk?=
 =?us-ascii?Q?EM5PQ/jU4CeGZBMaYSsYdYERi+f/l709UdL4V8T6dQvhSaTfd6NSSR+mzB9H?=
 =?us-ascii?Q?gAos2wzdVzLWcQqIdOJX23h3mHon9T0KKjEUQ6S/XlN1VgpgtmB/4QJIDyPd?=
 =?us-ascii?Q?vu5oWSVwFlhMGW76i4vz5iN80bm6eeALZAeK1SZJevquZMKZ08ViGbh9CVYu?=
 =?us-ascii?Q?MA/PQZiOrArRpiVtmq0J2ISpKIjtduirGD4/ydzikbKCxxMu1xAI5dTEQhJK?=
 =?us-ascii?Q?pcxrko4sKGy7vCyp1caRTK7JEN6vJplRqF0K6hF9YbVGWYMVuS3A1geOjk06?=
 =?us-ascii?Q?EeA4WVMnJQSKVXNYetzBZWp1fR6Sf/Iy9C17PaROkLqkRvtyRNOjnCBH3UA+?=
 =?us-ascii?Q?H2qDN53/Orsu7xpr71tY+0NYs7oVO/EjzLy2N3FGHrDPpYDwQtc+X+uiaLWN?=
 =?us-ascii?Q?YM6Tf4ZWUDpyP/MuWAQCX+CCbe+AmZdmQvSZArCJiV8nIHpvh7PIVYLqJK1x?=
 =?us-ascii?Q?cKTt1b1KKlq5y+CqVNoiZOTdea5U0E7sZOxBqbve16JsO1lJ3W10MV9Ydd1n?=
 =?us-ascii?Q?hEal9HfBzoV3NZ8k1E0ma7fRShp79tr2itaXz6d3lXZ2Rv6K5fAplic1VvGJ?=
 =?us-ascii?Q?f/6duE9pLyYg/mDB4c4ULEOSRqx2ru/pe6ND968W/CUF/8iRrMx1FXfMicvX?=
 =?us-ascii?Q?DGh1OrsRxtp+FBVDaGOJfZuYq+BUyV8fnT0KazQIRXpOi1q3E70L0pAdAZhh?=
 =?us-ascii?Q?KeyHf/kFMQnfMTiHZKbH6qOjHti4SZli1790KEyCQCdJuuXHJ3//UadJ529C?=
 =?us-ascii?Q?1x/sQz5MC81C1z+6jagg2to=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbee512-972a-428e-fd47-08d9d1823cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 02:05:54.5677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLthQRGCT4WaZqIWYgqbho8xmdWwt3/dUdFL3j9h4ZV10F+CRjjg5AxZSZFy6wlErnXTHBYsAeoSuN/bVGW+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Next I will figure out which navy flounder boards have the bad harvest tabl=
e info from VBIOS, and add a quirk to enable this workaround.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Friday, January 7, 2022 1:21 AM
To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy Flou=
nder.

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Peng Ju Zhou
> Sent: Thursday, January 6, 2022 2:30 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy=20
> Flounder.
>=20
> Certain Navy Flounder cards have 2 VCNs, enable it.
>=20
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 580a5b387122..57e001d73ec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -550,7 +550,8 @@ void amdgpu_discovery_harvest_ip(struct
> amdgpu_device *adev)
>  	}
>  	/* some IP discovery tables on Navy Flounder don't have this set=20
> correctly */
>  	if ((adev->ip_versions[UVD_HWIP][1] =3D=3D IP_VERSION(3, 0, 1)) &&
> -	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)))
> +	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)) &&
> +	    (adev->pdev->revision !=3D 0xFF))

We added this check because some navy flounder boards did not correctly set=
 the harvesting in the IP discovery table.  It would be nice to sort that o=
ut so we only enable this workaround on the boards with the bad harvest tab=
le.  I suppose that would probably come down to the PCI revision anyway, so=
 this is probably fine.

Acked-by: Alex Deucher <alexander.deucher@amd.com>


>  		adev->vcn.harvest_config |=3D
> AMDGPU_VCN_HARVEST_VCN1;
>  	if (vcn_harvest_count =3D=3D adev->vcn.num_vcn_inst) {
>  		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
> --
> 2.33.1
