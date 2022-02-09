Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51DCC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 08:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29ECE10E44B;
	Wed,  9 Feb 2022 08:54:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B16E10E44B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 08:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdKZ69BSi7KopgmAeKu2B7+2odSoOyUnPmnC/TfEBOgOPPof94qirjfzXPcu05L3D4sefqbFgatSC3H9UCDtQdbp6Gfassmk6pF9h0zhXWyS+qn9OBWAmyZyoY8F5Psqpnuuq0fnzCo8zHtdD09Ub2TAdldS9Wx50K4DT5hxft6G7lUcIGRuLLJdQpo97XSCRIhEQ0O0Lxioky6xifTM8eEXFOSl4+lAbQ0zKw0tzQaOztjmwDL4NnABpn8T8kXiV5xyggXB8pJsR94O4k1SPUEEm59t3viE1dMxsUAIZQpqJNbYrX9w8ZC+Wxi9heCfOf05FWJExjc2t9y8d8m30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPb2hY3IqtntNHVRdlAS1yQa4bVezBZndYv4M+Y/tas=;
 b=h4K2D7nyNhT22DxI0l7oTC7JFlRIVW+1cDa/xhnltNE2cC5wN94EMyy7wnW4Gq3w9XFuOxXF2JtRAVrAEDtbQ+ccRCW/aqAx7mmNn/cC31SWtCGoRaoYD8DV6/Fj4RGkyFTFm7SgENIoWRXRrx4j+Cw9iFCnr8HObOiV/S6UiunhIW+zXHx97xjJ5S+GWiYnFP/0Ovm5qsqyZCPfmvaGlnRxeQF5dMt3c1Ct7DjNG65mOGmjz5Xez5MqWwpa/whL/1Pm8pcTAtdu7zUXWaJYAMmrytQaFjH6uCIG0ZWTTRCJ/3PzfJXwCnM2BRAOj1gDIwhPMbbIh88pGU+MmTU82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPb2hY3IqtntNHVRdlAS1yQa4bVezBZndYv4M+Y/tas=;
 b=XCeJ35XhNREgpTkvihUFVUGJJPnTnXCniFD0EZabBgG9Xs9AoVyyjPPjxNsNbwVsa7TNkDwhqTbcfOkAa4ul/FExIkxhUFrwu5BPw2Hz3vb+M9pKzXFiBtSoQD84HaNInbI67Edj7mtdGCptDFF0cKLFMx7euR1fTtryn/Lh1B0=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:54:21 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:54:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Topic: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Index: AQHYHXoBCChifOVpoEe3cZvNUkmvCqyK6Xxg
Date: Wed, 9 Feb 2022 08:54:20 +0000
Message-ID: <DM5PR12MB177097DBFDF292BAA390B8C3B02E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
 <20220209055644.1873011-3-YiPeng.Chai@amd.com>
In-Reply-To: <20220209055644.1873011-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-09T08:54:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f99db08d-6001-4c76-961d-99fb74e09471;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-09T08:54:17Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 810e9e12-38a9-4da2-a1fe-4fb6c2ed0378
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87514ba6-9dfa-4f4f-830d-08d9eba9c36c
x-ms-traffictypediagnostic: PH0PR12MB5647:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5647D327E4D76896CDC39AFBB02E9@PH0PR12MB5647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7rIIVw36SIz0dHF8b9MBoUhK3gSE6Yc76/J7iRJXpsPcLnLU6HwNUR2j0yP5yXgvrKPBaP3OuAq9ih8MFfGXSyw0q0ql5iBxSmff049LYUpn3823+bs+XueE8AZSo7CQfiRqthTGuedbazJ+0kj0VgAVCsdLMNmrtnaHHBnbEQ286282Ah1k45pYgFpKp08JATg3CQqjbgrtzw1pkgIYigeLIPFMmiX2rNpotHsDF6zYSnm6wvt4/05hdo9e57FQUGoXr+QM7nDGjKjN9mmLgKwgVspO/xxvHfUqtT1Rfn4hTgx5rOqet2Zd+pR+5SdY6VGjgKd+sxDy9L/z28yxFWBttVFsVHwmfRr4ZcA0jZj6wF6qWXA8mJQLy+jNyDd24Kp9qgoJkKACP7lDax9OjDoRATR7GzPc5Z1Q9l3dBsF7IYQm3hC47NeBOKzz1ffjTiUBwikachEVIH28N3HUlpEJEqsTiXE+0J75zSoXP3KFzGnHsBhL4X+n/whXePNTsUWgV0ppUIMuZhnvAWr2FRE+VxSkNgRLwc2FVPdVnTTQeG7aJPxO3U/aRFp/SBNrgizddZ9F8qJSbaEsgZ8N8ZIBtFGcpMaNHtoiQIXGDVdINFiCneXyURyDjeMQ8I6Fe8PAA76y8JTe++EvFv/fCYoofjEthyZJFnRJKIrpp/JJFXe/SJjFCx1TnvLyDCOiMd9yuhVAIsdKgtdTISl/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(71200400001)(316002)(110136005)(508600001)(66556008)(66476007)(66446008)(64756008)(66946007)(122000001)(4326008)(8676002)(8936002)(54906003)(38070700005)(26005)(76116006)(186003)(83380400001)(52536014)(5660300002)(2906002)(53546011)(33656002)(55016003)(9686003)(6506007)(7696005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QculOQ/7GVkACfBJu1yLX9EP3yDR5FpJ/Tjcn5Simp4Rt3pOPIdnd71X7tYk?=
 =?us-ascii?Q?SUxQ9OrErWYXmevQSOJOwRoHLtvr4UBlODn+kLzeuiPtWrDLCFE5looQaO6w?=
 =?us-ascii?Q?sK3mlhbpgIwVR+tzqrwdgjaeDZgr/Hmmg7Bv527OXkFULOG2YtpCDv1vHVwe?=
 =?us-ascii?Q?8WlVFg0dhH8vrSQTyKQW9buzsallv1hBqOQZaS2ajyEfJykCHPvir0S/1cje?=
 =?us-ascii?Q?sin//4OKT/xClOiSSKH5AxD78FOJTE7lK8jnpKu1FOr2m8EY10Orvz/RiurM?=
 =?us-ascii?Q?x5U+jaQgWVqJEUr0ADd0cjX7JfLeTMykgU2Y/6qFAenleuT85FzFOgAXzftK?=
 =?us-ascii?Q?qXA+HaypNcO/gTNQq89Yz9TDe93GX68qnHPg3d39BvW7VS+FMCcePp9/4Vr0?=
 =?us-ascii?Q?P4DUb4qgcPXpQ0fjpAicxkfnTYL2eEJt5a7kviG/43HB753WxRXeUEOFc/kP?=
 =?us-ascii?Q?SpXv/TGIHu3qhcV2ckZACKnW+SU8JGxWkNNQO63oFYEipIFxQ4heGnFW2tAs?=
 =?us-ascii?Q?d+KeDQ6nmTCVGPmWR6hBqQh0RHGmgjlhSdTIoJh0gYF49pRbToLtLoLsaILO?=
 =?us-ascii?Q?ClgsnbF4qvxA2ir/fCoi54OGUex3B4htOlHrxN8zPhfz0F8BaimnWB3ah20P?=
 =?us-ascii?Q?YRe54XGORlbseSGIeExU5UlDjaUFXyXIVmwKNMuP9PLFdr9jydnCvbXaHjDH?=
 =?us-ascii?Q?nC7khJCUSqaQtd46Qs4sEsNIO/6OVHd2MX83Vv6CIQNaKiRZoHI6deO9u3N0?=
 =?us-ascii?Q?TbTghrTwe6fHKiJd1Jf1fhsdPB7SGZevzdcpVT21J4pJLcQE9/4yU+nW6i4F?=
 =?us-ascii?Q?PsDf5dzhJzLsmYYau9bIoCiGiItvT6eJxvJ5mZ1SQxJD5ItY6P9abQFUmj50?=
 =?us-ascii?Q?UtAA1a8TyyNyuBKzUBnBuPqTwQR5M+/jCt/FdUwkeYZSdt8eWJFl6Fylx7Bp?=
 =?us-ascii?Q?NmtPbgIexjj9GQmovF4azehAqtkqwkIPe9BGczlekRwyzzJF7YWN1jNu5PBq?=
 =?us-ascii?Q?dn+PqgEPRtLSBISK/ptljAL+431+xuLrzcnctjcPyHUEjyUAIIwyy4yfjrJ7?=
 =?us-ascii?Q?2y/4Hbw1t8x9YVQq66M7/C15AaqKVeA+CkId1ppjJ5zk6HPv0RT0WhcOMwWo?=
 =?us-ascii?Q?SKNZwq2u5bvwUfqpiLeBrRHhvH9xnNRNo66m/iq+61bU1V9deZIZHeY/Hqx/?=
 =?us-ascii?Q?XiRiXZAbG/DBKixpaTtAmLxhy4RGb8Z871hfytzPstoXvVqixwvzCLzO5HYD?=
 =?us-ascii?Q?8cHe/489YJIDp5vt/5qBW4Zo6qBGkr+EzCxRxpG/bsMHi5Y5h/FwV86onljq?=
 =?us-ascii?Q?jHBNgPzzOuZH87+iE8BN2EvIAZGNLWL3IvX731CEH58z48aGFp3Oz4cc0/ht?=
 =?us-ascii?Q?Q36rx20r2pXf1aN9B7exMDtSKO/lc9hMVr3EEei0Tl4jKQDT9lIkx5TH+L7g?=
 =?us-ascii?Q?l8c49DKZFjQTutnE7Of7tBDDGdxxrfAWDMciF1AZH4kuFXh5yXiHPmrNx705?=
 =?us-ascii?Q?vNmTx+gLH7/Gbwh0hgIBvDON/u1oN6lO5P6EX8KsH+ipRmGEJVDkrcvqW9Ew?=
 =?us-ascii?Q?kWVVMr/f3SDUTSFGxKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87514ba6-9dfa-4f4f-830d-08d9eba9c36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:54:20.3742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4HNUvMTBSQYIMODpHvNd4TB9/1yNFgj+Ko1Id27Y6L4v1Qjgilx7oR6FDZGHjKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, February 9, 2022 1:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 03/11] drm/amdgpu: Optimize
> amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
>=20
> Optimize amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 37 ++-----------------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  1 +
>  3 files changed, 5 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> index 518966a26130..21a5f884dd2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -26,43 +26,12 @@
>=20
>  int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)=
  {
> -	int r;
> -	struct ras_ih_if ih_info =3D {
> -		.cb =3D NULL,
> -	};
> -	struct ras_fs_if fs_info =3D {
> -		.sysfs_name =3D "hdp_err_count",
> -	};
> -
> -	if (!adev->hdp.ras_if) {
> -		adev->hdp.ras_if =3D kmalloc(sizeof(struct ras_common_if),
> GFP_KERNEL);
> -		if (!adev->hdp.ras_if)
> -			return -ENOMEM;
> -		adev->hdp.ras_if->block =3D AMDGPU_RAS_BLOCK__HDP;
> -		adev->hdp.ras_if->type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->hdp.ras_if->sub_block_index =3D 0;
> -	}
> -	ih_info.head =3D fs_info.head =3D *adev->hdp.ras_if;
> -	r =3D amdgpu_ras_late_init(adev, adev->hdp.ras_if,
> -				 &fs_info, &ih_info);
> -	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
> -		kfree(adev->hdp.ras_if);
> -		adev->hdp.ras_if =3D NULL;
> -	}
> -
> -	return r;
> +	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
>  }
>=20
>  void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
> -	    adev->hdp.ras_if) {
> -		struct ras_common_if *ras_if =3D adev->hdp.ras_if;
> -		struct ras_ih_if ih_info =3D {
> -			.cb =3D NULL,
> -		};
> -
> -		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
> -		kfree(ras_if);
> -	}
> +	    adev->hdp.ras_if)
> +		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
>  }
[Tao]: Since hdp_ras_late_init/fini are simple wrapper, can we remove them =
and call amdgpu_ras_block_late_init/fini directly?
The same comment to other blocks.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index af873c99d5e4..b12fe6703f02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1302,6 +1302,7 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct
> amdgpu_device *adev)  {
>  	adev->hdp.ras =3D &hdp_v4_0_ras;
>  	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
> +	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
>  }
>=20
>  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff --gi=
t
> a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index 503c292b321e..a9ed4232cdeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -160,6 +160,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  		.ras_comm =3D {
>  			.name =3D "hdp",
>  			.block =3D AMDGPU_RAS_BLOCK__HDP,
> +			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
>  		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_hdp_ras_late_init,
> --
> 2.25.1
