Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B028CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 11:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382AF11A766;
	Fri,  5 Jun 2026 11:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWHXH/zx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0126711A768
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKMViERQmYTmntT+lLXcz/DESJtjn9FuMky21ZMdIov9IGG9GMUL2XMTVxNEn5BJ21FCwN7gKaLwPPlhBnIcaZZiGDO5dbSoC+jY5N2MVZUwZd6JSdaR9yldVMGE0KQKnMSd/nm9BcedFCfD9Qty4+9TTo37xVVroKngW1QosLQD4YRwr3a65iaaeQc2gqZwuFH32GFbDeUmph7eOTUrFGp3S9tU5m24uif68/ZPRh47MQBZRvzQPHCbh4y3ME6/th8Bx+lL1mzSOCJ0w1egHjyaZHpEdkwlctSnjgE60LEsmmR8uMbBxzUeLZ/jHEzrmlj41g7uGRuA4n7rLb04qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds2xnOOopXZt6Ghx7I141J9P4HvPbVGqpyNPk9z1MJg=;
 b=WfODG358pnebTR9rWkxhXSjUfdJrWsEMEveoHnZP7NoGzrTRFZP/h1BnK5dmILHxiK6Ep3O3rzbC0MGAaJiMKF9o1jYkWX0ycQeXB8S+wikxw596Aaijdw1c7YzWZ+7P9zygJpxTDDxY3U4ACc+GDk3mcfSeP4wCDs+gLgtyNN5yWwnQYM874SOHpry/6z8ZhWBYZFUlNyDhTy6szey0muih6JvxXqybabh3MAJb3RzqiXf4K2ex1CsVXamcyHK6qxsJ1e6AV+x8XoZR7auvBUDCTXRPu6Ofj7aQ7pL0MWHPZMNEQzl839Z8W+RjVdiDMEcLW/fDC6so2Ou68mTk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds2xnOOopXZt6Ghx7I141J9P4HvPbVGqpyNPk9z1MJg=;
 b=pWHXH/zxTSzyJU1nUUrVuq0UGRppQdRn7X/eh4xY6/Cif5rn9WuwnHB47f0D+pdrnVtRgvyPIpadrOnx7WwUHnUsaS6hHMYzIXbIE86PtDQJ3Bf+9RfoSyON9cVTsccVDlgk3bTcN/Tus2v9ityVt4P7XeTGaeGEwZ0WVAvYugY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 11:00:22 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:00:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v1 1/2] drm/amdgpu/ras: Parse all deferred errors with UMC
 aca handle
Thread-Topic: [PATCH v1 1/2] drm/amdgpu/ras: Parse all deferred errors with
 UMC aca handle
Thread-Index: AQHc8wPa7tO/hgSnu0exVuy4BuINT7Yvzu4Q
Date: Fri, 5 Jun 2026 11:00:22 +0000
Message-ID: <PH7PR12MB87968F046594401E3423B6D5B0112@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <cover.1780454960.git.cesun102@amd.com>
 <e4d35cc1c23f27f1281b2f5c53d30fa712a12f37.1780454960.git.cesun102@amd.com>
In-Reply-To: <e4d35cc1c23f27f1281b2f5c53d30fa712a12f37.1780454960.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T11:00:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB7710:EE_
x-ms-office365-filtering-correlation-id: 35da75f5-2e89-4a84-7490-08dec2f1a3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: PwjkMcMPbf8J80l5S5aFE4WC/VgItzrL4BqxI2iiMBw2p19axwrA8MCWl9exosa2xfzF0UbnNoUVifr3HU/m54M0jRdC2/gtnCMmtlgFt0fe+H35A0WZVD+w3e7lJLmXAMYTcibHT0QAzf0HJrND5C1u/w7UhFywdLWStSVPVLafgp7TM4KKxdVKa1Kx3Ti8V9S4hErJAuuKiR8zs4HHT8V/Xdl5YEB4f5X47W5GNdFVT97lsWVrLZiYf3aLOTDRBD45ixX01BbGdYoWMLKxCamGMglZspCzi0Lyi1xe6DuF9mDhUtEj0iDxWy/rH12cJW90blG8ZuYmULsflLf/QukuATYAeCLA5vqsdViUebU+YUuk/bVY18SBQs/b5bAaIfvKSxr6g/VuYWXfQXZ8Ijpyy3LIoO7j0bnAkXRnh67Ji0Z8Donft6R4AzKUz6fNoUwFtAKTo5Gzo5qEMkOHFo73j4OFXR8RHg9bEqv27dHK0B+uCo0gGlOsnVY3J/kfqL4ZtZYCRxC0u5WLxcwfOkEvxJbLncuADx6Qdo9ef7zAk7BDBkbfRlPWbvMdh8QErEYXwrCdBA0F1NIDbOyHwXmAPhy3C2KG6p+emefTIQOr9daJeE8gCpCnZxWxUwwNXpDQM0B8wGbWwqhR6b5lV8+Ttf+rM501AFYL8cY47PfOl5/MlNCF9XOK6BfoM2CutinhmLG8+fKiKZjqDfbAARo/oEvQ9+cq28YzWchFC1UboW3VpkEIJ49icj3XeXO2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ayJGX2Cxvfz3b0ileXrYV+ICo69n+UYTxQqoQ0ndR1ZyhvcVQNuGvlgNQxZI?=
 =?us-ascii?Q?Q6VukiGumbel3ggxZNYWUZo1ENrgifU/6GJkeba/4z7Ha2UON/zxtB3itAZg?=
 =?us-ascii?Q?ZRH60pvSGR85MxQwA8N/HhyrjfONxnPhgHtl9AunRpnTeEIhcQOLyACOzelL?=
 =?us-ascii?Q?qQJWFERDBNYgEUsE6LZHx7SGyDDdMSv83OQ+v6JX7zNoNaPKViGe8qcMwiVf?=
 =?us-ascii?Q?UOuf7kUjq0d5nrEr6g8NsqYwjAcq4njxNxDdwyjsUoqGCvzDjdN1uDVGbYZ2?=
 =?us-ascii?Q?OKAcK+D+3wG+WM9M/rOddviVGhqtyeWPJXH/p2lFruQduTXuKXQZqDWlp9sc?=
 =?us-ascii?Q?W0+wMAehTlKEeB0HYxeCbarCai8KeWMLqC9Mu9Mitqt171BWktXN4/SdtOAs?=
 =?us-ascii?Q?+uwpHv2Jizck8pxoVyQadJ53W12y8xI3sku+HlZ47rRO/56d1/zVXdGkHkGt?=
 =?us-ascii?Q?IUfr9TGCh6CZcH1+r1HWbclUxCtSKbqUbCuKvaznBfwPlq7g5T8/OoL5vM4M?=
 =?us-ascii?Q?/+M4WymhE3EPw6FUOpudzOdQ4aKYdG8xXzp1EASiZSdUy6gV2TCvc6Boyr/W?=
 =?us-ascii?Q?IkRh1C92Fcj9r3wm/2XMrMURRztj+xHqacqep6Yw/zd8OqjGGsGbxk3nE3Kl?=
 =?us-ascii?Q?PCQFJMlSgFlF0PILTXPcg7jHyvg0jc3QgkdcC01hU4J12B9CqSNVm/z+3j02?=
 =?us-ascii?Q?s/wutTFD8HOlnjspy0wTlByMUcN7bAKRYtN2KO7v7qnYWtuEYBHoImhFKWC8?=
 =?us-ascii?Q?UYwhrzmtjalNC5DoBFLPLP8aF4/R1FeXvTxFw6y6n/rCmF46UPVHitMSOD4W?=
 =?us-ascii?Q?U1eULl2YPLMbr+NwMbmXtzX9ykS6aZGigGYFvJrl3+S5bXqWDyrcTGaVeyBC?=
 =?us-ascii?Q?GK+iXh5QuFIwwQAWotGC/SIJIJYXPm69r6svw3cZV0702PAHuFVYBURT9PIi?=
 =?us-ascii?Q?ren9CCMCKqAO9mZ07pu25rA7wwt0+lPVomy55AY3OLBy+K+CM2aPt5jyZW0A?=
 =?us-ascii?Q?Qq4cfiNgtZq5eyzFpAcH0cb03VRbNFYTCawHLJaL3N1Iu0rxGWeg3yvGahPv?=
 =?us-ascii?Q?C2vS0ciMdQDCA4EgZRLwzBhzoPHrt+teseD6RgFIgL8IlgaYsFTooU8GXwXB?=
 =?us-ascii?Q?iyZaGGq0zVSFXfR63G5yEjn7IZOUtUaZ4pn9R2C1g6JYmUeh7kO4kykAujmU?=
 =?us-ascii?Q?Y15E/81qhAyF6a5Qj8Pn0Ef8a4uUPKsfTN/0YAJdTD5QaUtu2Uc7LskR473s?=
 =?us-ascii?Q?USpHR9arK67R0BRfKYC8AS8ViYN+P2WHrN0zYI0InPezAqnhoywDlXWUHBQK?=
 =?us-ascii?Q?p+QUrtFRpr2JNBSqbjQCls7h6A06NzoZjQukUN1zx68bZgGyJs0c2gtDjGaM?=
 =?us-ascii?Q?7PHxmzM41r7SS+x1aiJ+NOwI+HtqNfZbt4M+VRE4yT27Rxxl4RY7eBk2KTMQ?=
 =?us-ascii?Q?m5fSW068VJcbeIDHqdM1dftwxM0/us0ABy/jXlHu8eFXU9kat/L17Qo65jjW?=
 =?us-ascii?Q?lRKfp/aI2XKYq3VyzrLrg5I5njUbbQxxS+o1B0kRrIQZ+hfRayV/U3wjdZD4?=
 =?us-ascii?Q?47hqy7ClJzWUI99N4ELo51V58u5Q5zFIdH2p/vndbD3MY3rtyTDkbo15Kmrx?=
 =?us-ascii?Q?4xtw9a+MVBBvDSXtnEQpQ/aN10Dmw13lP2Nycz4EHq6oMOku7MJiiGfr71JE?=
 =?us-ascii?Q?EXk6OQEDEIm3ZdfWwKdJn5d/8K50OB1fimpVtMe+1PF+Ay6/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35da75f5-2e89-4a84-7490-08dec2f1a3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:00:22.2066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2rsZW6i/6F4vudSJ+YBWjMATQlQSZCBgcGEjO8fCZ2G0ikD+m3kwXfRLCs1cfSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, June 3, 2026 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v1 1/2] drm/amdgpu/ras: Parse all deferred errors with UM=
C aca
> handle
>
> We should only increase the deferred errors in UMC block
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> index 210fbd8851a6..840610538c1f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> @@ -213,7 +213,7 @@ static int aca_parse_umc_bank(struct ras_core_context
> *ras_core,
>       struct aca_bank_reg *bank =3D (struct aca_bank_reg *)data;
>       struct aca_bank_ecc *ecc =3D (struct aca_bank_ecc *)buf;
>       struct aca_ecc_info bank_info;
> -     uint32_t ext_error_code;
> +     uint32_t ext_error_code, misc0_errcnt;
>       uint64_t status0;
>
>       status0 =3D bank->regs[ACA_REG_IDX__STATUS]; @@ -228,15 +228,14
> @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
>       ecc->bank_info.addr =3D bank->regs[ACA_REG_IDX__ADDR];
>
>       ext_error_code =3D ACA_REG_STATUS_ERRORCODEEXT(status0);
> +     misc0_errcnt =3D ACA_REG_MISC0_ERRCNT(bank-
> >regs[ACA_REG_IDX__MISC0]);
>
>       if (aca_check_umc_de(ras_core, status0))
> -             ecc->de_count =3D 1;
> +             ecc->de_count =3D misc0_errcnt ? misc0_errcnt : 1;
>       else if (aca_check_umc_ue(ras_core, status0))
> -             ecc->ue_count =3D ext_error_code ?
> -                     1 : ACA_REG_MISC0_ERRCNT(bank-
> >regs[ACA_REG_IDX__MISC0]);
> +             ecc->ue_count =3D ext_error_code ? 1 : misc0_errcnt;
>       else if (aca_check_umc_ce(ras_core, status0))
> -             ecc->ce_count =3D ext_error_code ?
> -                     1 : ACA_REG_MISC0_ERRCNT(bank-
> >regs[ACA_REG_IDX__MISC0]);
> +             ecc->ce_count =3D ext_error_code ? 1 : misc0_errcnt;
>
>       return 0;
>  }
> @@ -266,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_con=
text
> *ras_core,
>       ecc->bank_info.addr =3D bank->regs[ACA_REG_IDX__ADDR];
>
>       if (aca_check_bank_is_de(ras_core, status)) {
> -             ecc->de_count =3D 1;
> +             ecc->de_count =3D 0;
>       } else {
>               if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
>                       ecc->ue_count =3D 1;
> --
> 2.34.1

