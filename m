Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960CCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC0510EB5F;
	Fri, 14 Jan 2022 03:10:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40FC10EB5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYxMzdmmyJQ6lndti7lqRz2hKGp/XsznpzdE0d4F1hsgxR5JttgElOaPbnHZSiTP9eAKGXMNweL4/hxS5dDXR9k/5Iyz+zwC1CEoxslBwXG/gsWlE8yEwjYvDMkgOzlERsVtmxaFXV+YXHjc/0eztxPHAs+GVyrP9nJB77W5XL6SiS9eXMqEghFrySMXaCYAPPokzNYo2KmhJREKHzpxfoqBYsCzEA+zda5vuSPf8Q/UqoEmEK16F6Z3EM3+FShrlSGxCzArOaWsvou8ZDTndHC7IeKJapzJCZk391fy7PbNGsy2PcjqL2XStc8QKHMRYLLrgacM2vNG7OZFprbCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeGL2nhwE2EoFuB3IumaT1XCuZLOyu1xG59zOZBbyD4=;
 b=FmB43lkH061na9m0i6em3fyUe9iogtrpBvZWXK6mO1g+0dUznqAFgvFZYMyPaDdmVT0e1YqWbpylsr0mIB62LXlcGU2H4rDAMWHrjnq7J18ZgJmVeozdEfyZAUs6oBidlpBy0hUIylitZEtbAzwJPx/fcHXYPHSN80a2RObBLWZYe7iContkmp5JiicWuhmh8EOu10beGt1tWGIZVGldyzghwPXC2sNjbObLEx7eqemYP2/sU6KBMBP1wmd6uH48WqowPv0sB6TMt9OfLqxXuEVeFo2xMNpn07/IYn+BTmRE9cHUy3OMAEkAcLt0enYSoyR0O09kDb3ulTQBx62JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeGL2nhwE2EoFuB3IumaT1XCuZLOyu1xG59zOZBbyD4=;
 b=Jr0IuGsZ7gh8ogT8ZJ2BHnkWAnjwJReaYPu59Uc6YOAk0UDsCrEkImiJstVDPMFiepX7EFEKBNt0+4TXTeQxbO1vlZWFnmyAxIya75Ec9PIYirH+5/1fHiGPHlBtxgbLA8zoMUdI6sV2DVqlBmrZIe4Vf1ZzP+4smil34PfdQFM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 14 Jan 2022 03:10:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 03:10:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix null ptr access
Thread-Topic: [PATCH v2] drm/amdgpu: fix null ptr access
Thread-Index: AQHYCPITB8Xubw6YjkyiqXtcOXHehaxh1bWA
Date: Fri, 14 Jan 2022 03:10:01 +0000
Message-ID: <DM6PR12MB2619E18E89EA70F940AD4FF7E4549@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220114025422.255750-1-flora.cui@amd.com>
In-Reply-To: <20220114025422.255750-1-flora.cui@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T03:09:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=92320b80-04e5-43d9-bfcb-997695a870f4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456d4e2b-5401-4fc2-f498-08d9d70b5ac7
x-ms-traffictypediagnostic: DM5PR1201MB0121:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01210A9FA266E17901D6D97AE4549@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWLyFi2zZVgLwQeZTlLX2jYx14NbUqtl9HItmxeh+S16OH4fPlNquE5jT5xg2FjiruLgHMON45nu84PkZMqLGeMcTy5XqmhrQhirgam9LeekByvc4Do9lJv5IMXcJ9oQMRzTbRZx4ygbUZzKoCoLsikXLJxUxHVgMBZCoJ74GfTmKCKdv33h6J3GFHdQZuVpGg7tiCnsDx5Sv5E9fiw6txhSU2vwwn6aWz348ZH1i2oG/ZibnxveiEPynfSTVoMD2igo6rWt7zIdXYOhx8jnSfss2Tf63oZ8JQdSgGJf3QYUBz357ztypwcrNoMciAXvSctF6dt6FsnizyDshKxH6WkvVjUkuJniwA8L4d+xE0ACk/YcJvMR2+gMx63xoMXO9/9+b+2Vk2ubTOY6hDKuBBmwNNbnZk8Z5kYeL4niB0NkDIc1VFfgpKAls7lf8gfnecTY6sqcQXv1cBTOg38J3Nr8ywCpCpA1pEuPrx7y0gw3C0WVsYUy0Hscu5IyL2DDG8pMPKnn7aH86E668sD5rUmttf5furd+hoYfZVD4UT8ib2eAq02ltohxI8pbBzG5FyqbkvdbcnGF50UjbKDPD8TBiIHblFAr7Dx/pEwwCGjnHRrXtRej+bjbeDQ7ESYnmAiSIyiMkL8wUi1k1XrTJGiqarYJN612xvlgRSXRHxCUsykuJNHCrx0l0J3ExOmuTbCwP/xAeAjuGmkmPGiu2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(5660300002)(71200400001)(8936002)(38070700005)(110136005)(8676002)(508600001)(38100700002)(316002)(33656002)(2906002)(76116006)(83380400001)(7696005)(86362001)(53546011)(66946007)(66446008)(186003)(66476007)(64756008)(6506007)(122000001)(66556008)(52536014)(55016003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYpcYeapxXzNOcChVCVV/lOfA3xwpBKx3kixicPd9nEImEl7iEW31ExgQVN9?=
 =?us-ascii?Q?Y8hXN8Jsu5Tiesbbrjt8RL2GR5qWqxlUdWpJMsrUu801h1V5yQYBsAYGgLXz?=
 =?us-ascii?Q?yYduP4H1X3JpN4WkPLRVzgi5Vvj0keoeE3WXTfGeKLk6PfMGC+vwSOQ3HLyC?=
 =?us-ascii?Q?O2vUoXb3ulRQDo08gOpHLhBweinp3qvvGnR51uyEtoq+ahIE7mTMY7m3E4ud?=
 =?us-ascii?Q?TOP7kxVVFx2pRNyBzv4HIZFDYG9HFkxjitzxPtYYlqeNHkINBO7jkp102ytH?=
 =?us-ascii?Q?fD27qf86VN7VISuu//tUzk3tZht2UimxRrVnNnjAPX7BQIeVjgdfpafcYJ2S?=
 =?us-ascii?Q?vhPAypjEuL9TNgjmVr2WCRSVmcxQHQSQjh3Xh5opcgNfaAK1CZiVPLkO9Kk1?=
 =?us-ascii?Q?mteYNEbGPj8I1hr7um2tHVrZX+trWjqA+eMv5p2CPIxnZhkxpO/XnfvS786k?=
 =?us-ascii?Q?htUUPxS/xneef3LXv63AVW8oY9XbpnjQKp5apgct3StwFnXnG1BjBC/sFVSw?=
 =?us-ascii?Q?urTcnIoP0Y63rYcLcFXfYVjNr3npN5nZoYGDmg51GTeq5zI/QLclIxoNbr6E?=
 =?us-ascii?Q?mCO7fBC+157lrKO2h6EY2wXmeRENvWJ9iS2J7KlgkYeZypTYjD9aqdrimHzS?=
 =?us-ascii?Q?7TKGsmqz54q27E8gtyizx+MEsGR0pTQtwmz8O4r+voGwq8A/8SZLErrygV69?=
 =?us-ascii?Q?CHdwl9L85g+3SMJNfAYIveSKFG2CMKOdEagXjIzGLZNLO1xVGtAqsEkTT5Qh?=
 =?us-ascii?Q?R38gLits+bF7Qr0kSrtwuIHmvlYxeTOeNNmtl6OaArAGsxmWGOt8HVtawkQe?=
 =?us-ascii?Q?jkklAM0jviszZDfksiAoTNaJnvkimbXUn1L06zqOMK9VDU5p670v2hgCBvMe?=
 =?us-ascii?Q?59sS0jIrmOoIiuhXexDI0E3zABdxWvMs5bi89cvwkYq55en2FFAD31cAbSyx?=
 =?us-ascii?Q?EFDfx1xklxAK/7xoWyLwXXsVLKmCBQO+8g7v4K2gTN8FSUpnJW12iG6QxDfO?=
 =?us-ascii?Q?P0FzjccIyXrgQPveFuA5OgfW1bLChupvFbsVKv6BF/DAiNt/8EvZIAvKS0Gq?=
 =?us-ascii?Q?UZ9fNPW65BWy/JunczVytbvVUwRjSzBgz46kvYmo1atgTUOLCxkLtuvS9w3V?=
 =?us-ascii?Q?5TYxtctXdILiySrcAdCplUaA/LTHw/v9/ofr9KNQO5ov28pLbrR2rGBX349l?=
 =?us-ascii?Q?NbZ2ZSJ3i42EaHLoI65lA7TfpSV9MMwMdqSrzNKytUi6/4+YXSmZT5XbUEmz?=
 =?us-ascii?Q?Cjh/jzz6heXhk2LeNKaw99O/4K+vJkkzzRvPa/cdpbEsqEMNUWSPv47ZtBy2?=
 =?us-ascii?Q?lsnHDF1fdZTIz0bKzFrl7WsTU5fLVipPXUF84LTfSk0wOLxeFa54e7tk8VDP?=
 =?us-ascii?Q?TLOEaKsDkda7fTd5aHbY9j6B82yVNvNmkBAiEWw26ksveeWJ90PhJXqul91J?=
 =?us-ascii?Q?U2VyHgA/s60Yubcl+D71v5ektkY0aNrYCePevXryP08SdyDAIAKfKYzmRbZS?=
 =?us-ascii?Q?pU1q+fIS0ubzvOgA+BJQ2KpGqxHWdsUcezTptXeCUk9pYmyrQD/k+Z13BPsb?=
 =?us-ascii?Q?cJVMGioRJC2Syxpnt+0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d4e2b-5401-4fc2-f498-08d9d70b5ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:10:01.6364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8yPoADd2x4+sW4YDLnURxBRoh5HA0Itlea9yDKQCv8qodpZv/LTWoHl/Z2ewAmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

[AMD Official Use Only]

For the patch with power code change, we usually have the patch title prefi=
xed with "drm/amd/pm". =20
With that fixed, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Cui, Flora <Flora.Cui@amd.com>
> Sent: Friday, January 14, 2022 10:54 AM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Cui, Flora <Flora.Cui@amd.com>
> Subject: [PATCH v2] drm/amdgpu: fix null ptr access
>=20
> check null ptr first before access its element
>=20
> v2: check adev->pm.dpm_enabled early in amdgpu_debugfs_pm_init()
>=20
> Signed-off-by: Flora Cui <flora.cui@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
> drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f0daa66f5b3d..5fc33893a68c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -463,7 +463,7 @@ int amdgpu_pm_load_smu_firmware(struct
> amdgpu_device *adev, uint32_t *smu_versio
>  	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	int r =3D 0;
>=20
> -	if (!pp_funcs->load_firmware)
> +	if (!pp_funcs || !pp_funcs->load_firmware)
>  		return 0;
>=20
>  	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 1b03ad7a21ad..49a9c6375343 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3583,6 +3583,9 @@ void amdgpu_debugfs_pm_init(struct
> amdgpu_device *adev)
>  	struct drm_minor *minor =3D adev_to_drm(adev)->primary;
>  	struct dentry *root =3D minor->debugfs_root;
>=20
> +	if (!adev->pm.dpm_enabled)
> +		return;
> +
>  	debugfs_create_file("amdgpu_pm_info", 0444, root, adev,
>  			    &amdgpu_debugfs_pm_info_fops);
>=20
> --
> 2.25.1
