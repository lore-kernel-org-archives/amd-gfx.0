Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F10C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 04:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4145C10E7C6;
	Mon,  7 Feb 2022 04:03:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC8C10E7C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 04:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR0rLxVquUl+ps5djBa9XTetIlRLoI1LyLUGKWT8Y8qroKhbcm1b6OMzE9+uTQYPIGU3YbtLJEMgaB/rDCoxlgVHv6oEvdhhz6nAc1WPbxzNVUm0fBjnbIp/M5ovYWitKjQGljPkSIK3MQSehtNmjRV/zeZhTqBKxVOeE+D+BuC8/QjevCCACqSxNDAWo/qGwzRaZ40WNxprHauEEu7m1T835kj7mBE0Re2OBGjEROhJSs0I212x1tH53Hlczea9L3i4zqGIyKTHmuA8fKnsEyonQdvZlCrLu5EPeCbDB+R4CJLukIm4ywA3wCwBgNde97tv8XRCU0sNI/b0mWHmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qP2x8xsi/X9MhR5vfVi7k8tqIWWtJtIG/1AcnwPi8Q=;
 b=iOI7OKzt8C8xY0XwpA/q6ZFUNjoU/zJ0Ka5UUfFHI+BDmLkBjBwosUi+GlfDQILZbD/B4LcklkUCQjR4lvdrVKhPVnhfW9B/eqNDQ9zuKGA5lznm8LzDQ0ruw8+fvJiog2mQ1+3EgsQKKvdNUeEoZpt5dlH0R69VOT6eE+6fONCHXEVYkTC/ikqf3R4f454Zz6gq4AQW8OPH4ai9IjsnbOjpwBmP1v6i5o3LFvw2w0SCBlUd0X5jPXoQ99T6rvPwuvrAYjj+pHGijAy7RrguIBlD6i0OLkxFRqGRpgVvhLJiERqCCLz9/ShA2AGopQaFRA0v618S9E8e+o4viT8FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qP2x8xsi/X9MhR5vfVi7k8tqIWWtJtIG/1AcnwPi8Q=;
 b=WxW6xkZRbwaLK5HgJ8qCBndMEBr1Whviov58rn6MaRjT7C6mRSVtA7fP3aUy27thBL8sTmJ4KbdKALFGigFJFScB72H3+c93/mONHhIXSHOlMxFeoMnL4CNokJvQWGIJmpSTIMXLjCLh8b5l/oFHFIpTjZ8chmyHg0Yd0QDNcfU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 04:03:11 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 04:03:11 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amdgpu: Print once if RAS unsupported
Thread-Topic: [PATCH v1] drm/amdgpu: Print once if RAS unsupported
Thread-Index: AQHYGVPDwhneeu/wbEeLyQteCDMHaayHfCPA
Date: Mon, 7 Feb 2022 04:03:11 +0000
Message-ID: <DM5PR12MB1770E49AA079902EB1ECC6FEB02C9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <BL1PR12MB5144C64B0B4E525FC97EB522F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20220203231320.114539-1-luben.tuikov@amd.com>
In-Reply-To: <20220203231320.114539-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-07T04:01:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=56037f82-0a52-459c-a4e6-6f2ea9443f6e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-07T04:03:08Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 2372aa8f-8e18-4171-acac-5e4b84a1791f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8064cdab-413a-4c83-a368-08d9e9eec21b
x-ms-traffictypediagnostic: MN2PR12MB4815:EE_
x-microsoft-antispam-prvs: <MN2PR12MB481592144D83A262025052E3B02C9@MN2PR12MB4815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:24;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8pJDfDNWxeipMi2jxR/fNlmr3qDvwicRFTDYFfDFlOXysHV3kY6b6DenPLH1CXzJ5KgmAd7FRZaEJLIQsl5uN4IVxxqnlpTCcZcAcDEyTSDSA4Dk6cnHOglTeyfStz6tf5oEBFGF8BEi23n9RkPxE+SMP/7Sfnwonry82oQvMIZ5FBFtyoHXCXZaBVm3W6Ai3msS5Sr4F0L+qE1RZr2jKq0E3id1VLNmholQMK39HxDiZns0mKS0lnwsLo9meS2QNF/9YD7k1+7WyU65L1vhZWvniS54pSyCYK+rqxHnkx29HQaxQlWOpuqdo0yOppUT/i2euFKejbc30NO3rZ/xDWX7Q9HNsdnQZZ1k9KSV3hhpQpUZU2Ikj+ll5u1EQIoA9wo27FGhyr3oH3r2rEjAfMCw9lTQfGX608bxiI1aPgcGoGMszhObDn9bUMiLq1GUJGM358yB1qvVV1vWPZMfD1KIFd6kAb5+qaTvdKSk1Thh/1brINrbud7jpuBS7GZWkAaFBc+FN24FXEboAcS0/ecFcXNMe15M4vkLTwzb658HI0g5lu5W1ixk0K7MBZWp3HLvZAAsqBTz/IJ/nK2Tm20bvBy3+RPk/2sNA4pq02D986JjAInpXywxivjqYMS25BXCXgSHLKdPhl1RcCyLpNqa+o5YztMrOoIETHhr9WlPZz59GOhZ7VfX720rVBP20mDSAOnAxeEJKvF8tzQ8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(55016003)(5660300002)(83380400001)(33656002)(26005)(186003)(2906002)(508600001)(316002)(8936002)(8676002)(4326008)(71200400001)(38070700005)(9686003)(66476007)(66556008)(66946007)(64756008)(76116006)(54906003)(66446008)(38100700002)(6506007)(86362001)(110136005)(52536014)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qNo712K/JU9aR8nt9hEmXzZu+M59vcGkiG9B0q91Ij/lgB5mHetXK0NQ5j83?=
 =?us-ascii?Q?8dyTMY2KoSVWqyWxLaxtEgk6FrWxKV21/JkYtUI3Fp2N9RSXZN+1VOn+DoEr?=
 =?us-ascii?Q?sOOSP1lh4vQOH/6KX8KG4XzvZLU3gPG0DSxZ2hZghIy+zYHoBBkaPmbnCOTc?=
 =?us-ascii?Q?LwzIBOUmPq37ChUZuxX61HVrmgpntk9HgCDQNbsvtJIP20Z2CInrVZ7ywXFl?=
 =?us-ascii?Q?nHcD4jX25f+7wR/bT/RBRNdmZL8XyB1M4cQPn3n/A9uAwgU38efiAx4uIhza?=
 =?us-ascii?Q?ig52umDnxfhSWtJMnPQ1Wu7g/7xIZMikMvdsa5QmlRbPT81CfQFyKeUm8SDs?=
 =?us-ascii?Q?0gvGtVivwaz4V7rVY1p+CjOLiSYyDcD+It0koQmk54J6xWt847N1cmEpNcnu?=
 =?us-ascii?Q?up7G4VYbQofT7kQP2OxAYG0NNdTM9bXgxs+4alL6zmWw+l/MXe8RKt+MijaX?=
 =?us-ascii?Q?VzUdtZ7GZoANQ7Z8c3+UfpRO2KIDaVnvhPgBTqxmxBSSZMFKahkEkjFvfCRz?=
 =?us-ascii?Q?ASQyhyxbo5H/W/GoIyePibsrCHaxpBZmbzlY2aoAnE8WbK9JIWVa0oFlctqD?=
 =?us-ascii?Q?6UvFSs8QKvLUfX5fQ3jZwPrPLV9tjddnjVJcWxG8J9/Vg/Hmlr/ue4ScrCiC?=
 =?us-ascii?Q?5Ta2X0nSophqO7dp+bsp5ek0kABXGPsmPW+kKEkw6uu723bmHNeUNo+Dk5Cm?=
 =?us-ascii?Q?Hj34NPLyuD4BqNlcbljzKVxL35Ywgmc67a5+3OpsMkk9mhe3Ix/ynm+4zhtD?=
 =?us-ascii?Q?wYXmgMfjICs3IH7igzeW3eq/Z3rR8VAhAMEKEbTc3egKWBS9grDeE2HKZn9Y?=
 =?us-ascii?Q?ovmtFNH7Gn2hPvHNsLdIN5cQebOMDNWu8c10ePT+qAEtU0WD8i3f2dM2NXuf?=
 =?us-ascii?Q?tNFOQnIrRrfauusX8hKZyagCdJe8fWIIL/PNK+XaMVGFZg99002HHuFxLyNi?=
 =?us-ascii?Q?c9Ry9EWKuTa4L6eR1Ckoy/bji4JkwjpRWVfnH/3ez1QFe8ut1/FBBCZHiqwD?=
 =?us-ascii?Q?uhG+ucbPHp41+Bul+RH3MIOd/WgAT9vq+hEbA/YLpf48cPgPp51Sbn7RzC+J?=
 =?us-ascii?Q?YGSKoRDQ4CEc42brmITYQk9H7D3/JN9cxxCWIllXep6Uh5uXPfBFqu8Rgc4y?=
 =?us-ascii?Q?jVWp/CxD7VoNJnru0Hekrl9jQFfMdCNctf2hQI9rlpGltmKHeqP8YlkoCpVZ?=
 =?us-ascii?Q?zXcyG5MyKcyiEXOar5L+n95FX06Ao/8mPyg04Q59J957MafQ4gMYCeRQU9PS?=
 =?us-ascii?Q?84UxhejxQoorBv/yJMgPsSA4XpxBcL2PJYhnneuAvM2zTVcg90WS2UKM2UKT?=
 =?us-ascii?Q?lXzttPbpy6OAuvUkuEr5CNA08FoEFQhyvuAW5jHqqANlpIjsELoTLBm2f5k5?=
 =?us-ascii?Q?PoIG3ZEfVDJek/YctN3JyXyaDyb3cvkNoz765RNaptmPvk0bzRlsdNGjxLlk?=
 =?us-ascii?Q?WHFxcnAWFYa5HkszskJ/lj1IBCYQeznKwnITfc480p6n8Vqoarayq7+cJzKu?=
 =?us-ascii?Q?vxepAfBMitrH660Rjq3tiWdNGjnLXFbj8anHo3MM1WyrzGLgIlVwvQPMpInk?=
 =?us-ascii?Q?pMYoXL20KefZhCV8vBE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064cdab-413a-4c83-a368-08d9e9eec21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 04:03:11.5996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4M4cY0bmev1wpXU1n9UtUD8UuNnhAsSQq8OLQVPLweQLWag8kbNkgQB4S2QjH3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Friday, February 4, 2022 7:13 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Clements, John <John.Clements@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH v1] drm/amdgpu: Print once if RAS unsupported
>=20
> MESA polls for errors every 2-3 seconds. Printing with dev_info() causes =
the
> dmesg log to fill up with the same message, e.g,
>=20
> [18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras functio=
n.
>=20
> Make it dev_dbg_once(), as it isn't something correctible during boot or
> thereafter, so printing just once is sufficient. Also sanitize the messag=
e.
>=20
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: yipechai <YiPeng.Chai@amd.com>
> Fixes: e93ea3d0cf434b ("drm/amdgpu: Modify gfx block to fit for the unifi=
ed ras
> block data and ops")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9d7c778c1a2d8e..e440a5268acecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  	} else {
>  		block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block,
> 0);
>  		if (!block_obj || !block_obj->hw_ops)   {
> -			dev_info(adev->dev, "%s doesn't config ras function.\n",
> -					get_ras_block_str(&info->head));
> +			dev_dbg_once(adev->dev, "%s doesn't config RAS
> function\n",
> +				     get_ras_block_str(&info->head));
>  			return -EINVAL;
>  		}
>=20
> @@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)   {
> -		dev_info(adev->dev, "%s doesn't config ras function.\n",
> -				ras_block_str(block));
> +		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +			     ras_block_str(block));
>  		return -EINVAL;
>  	}
>=20
> @@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> *adev,
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)	{
> -		dev_info(adev->dev, "%s doesn't config ras function.\n",
> -					get_ras_block_str(&info->head));
> +		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +			     get_ras_block_str(&info->head));
>  		return -EINVAL;
>  	}
>=20
> @@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					info->head.sub_block_index);
>=20
>  	if (!block_obj || !block_obj->hw_ops) {
> -		dev_info(adev->dev, "%s doesn't config ras function.\n",
> -			get_ras_block_str(&info->head));
> +		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
> +			     get_ras_block_str(&info->head));
>  		return;
>  	}
>=20
>=20
> base-commit: cf33ae90884f254d683436fc2538b99dc4932447
> --
> 2.35.0.3.gb23dac905b
