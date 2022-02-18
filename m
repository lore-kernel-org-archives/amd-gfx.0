Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EBFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 01:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8588710E9C9;
	Fri, 18 Feb 2022 01:57:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E0910E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 01:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTUw+/vrAFLbNbw4fbatkS08NNqIQ3Ud6cEsOyQjdo0qRS0+9UcV7OdwVmnl42BR4XTmxErsL5DfkJfLfqK0qbzDvgO3cjGE44rsSe8fRoOoXnoTsDvbuFxm46IMs6GYd0MTPTp2FAxDG2061sbBsMRaN4cciAJEB26GJN2+Vs1vXjRduyj57caWkgaFfGd76/9GcVnMdONEvzXPcTbZq9UNp9mFW+/jo7bf+gXR4syEjek4qsWn5u+2a/B73lDZH1mYRrllHLC8DryMeRlBXylCd94PtAVGD4i7KKEJg4BJXo0bJY3tKn7kK45V5qMido9sEVjjSG7NDAYsshMhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdJ6JUU3G9D2O3C6Hi3UlALiHg5FJ1l1XOLqmN/42Ok=;
 b=Fg83KcypR2jzn/IW5VzenZGa2Cqk+g6stueXTBixEK96Z5vWazusAEmh/5gOvgdBPl+IOqBn123TFdJ4Uq1TY9o4zRZfzURN/cYWreEFB/LHjPtEbRVKdYMRsDvjm513IiYl9xIn0i9tRgk+QWPJfrvJ6Kmquc2WdRpDdWTVJ6BL4C+/bE2OqwhPBlRnmuEZjfUa5MTC2iMhlf0TXvTCW6e6ukAmQ3MbK/BUSCdrMEGIj6256FAUhe3GeFMYlsDIewKK5Z1hssV/bbN1kjG5niJ1mGphDR+UJZRuojhCK/BivsRDkWnmR6/ZlhfkmX5VRZIcjqXw6ga/gPqbk3WrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdJ6JUU3G9D2O3C6Hi3UlALiHg5FJ1l1XOLqmN/42Ok=;
 b=ePeQQRu79Oa3m0TxBsjt80vBsAVJmUNd0fwP63/2ipOTEOA1oannpwzqNgGxeYa7EhdlrbKK7QaYnVPUnFvnzQ/gZ+4BmOxO3j+fZQpO0QzfvL8+3LawiRYY3BjTZJhPkKJoc0gW9E7uIcN880OBE8zkrZcaTccXhHOaRpr9vHE=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 01:56:18 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 01:56:18 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Topic: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Index: AQHYJGhdxW+BMT2guUW5iMrb0otVFayYjB9w
Date: Fri, 18 Feb 2022 01:56:18 +0000
Message-ID: <BL1PR12MB523753998E7CF358807C1A42F0379@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <1645148219-17774-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1645148219-17774-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-18T01:56:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9e269365-c2c8-45a7-a62c-7ee4bfeb408c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-18T01:56:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 15db66a4-d606-4a2c-965b-667dc820ac6a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d190be6-2520-4856-b833-08d9f281da99
x-ms-traffictypediagnostic: CH2PR12MB4040:EE_
x-microsoft-antispam-prvs: <CH2PR12MB40403AE4AE54DD08DC406E4BF0379@CH2PR12MB4040.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7p/LodWejSDmOqK2Dlb4JVTpgQRFmt/F3DK4BcEt+QlXNQV7cCpiUYxictfjyiKj9TTZoPWEgpeXDVWiKQ194h8t2/vQiIAYuQ9BV1pzvN3u4PG7h/QPcdEsitPJCb5yFN/lx02sFKpVoIxcxgxEngT1FTQnB8XdOrBBQYAzesZ5sjQUGb8MtGo94WNEvG4oIVqNRjlSdSSj22LPVjxJU1sfb+qXpyDdZVlBk2sIDCjB/Q+QtP0iZ/yBDx5gMcsJvh06cqi7mt6iLnz+dRkgfZlz9ly401gpn9pbdzP1ZHe516v8pOPtwB952a7X7QDEuuUQGP9HzBPkr80is2hOFYS+Y+ou/MyYQ2aQbCWHsjBJB8ck1T+GVJGaQDwsMNIV2tCmy80WadYHKNx49xCZY1H8kOiUufrnIgoqiYaECQZysnBdiCd+Ak0XrWt4bldUlVtJzUC+kzajvAKLkNWtQ4NXdfp10ERlGu2VodF4ik+Hso5mLWfe7nsKw7Qz5hK5kQjsF+DxMh+/2sTkekIz5yeWEQV+WZgzWo+L1M57xaCS85tclkEzQIaGD1l1LG211Q7+Or7lhjVQ29FTomaNIlooTsOACpAp9Jr+OKSmPI1zDYxmsIDIUlDrQDTi57e2fPBll1xfIUaEkzoWHDjrkMUP+L1xi+0ewQrcJvSuFoLMIrmPZbg0wwHii5P0a0kWeMc+q7BrP/cGtam4n1gMeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(122000001)(55016003)(38070700005)(9686003)(7696005)(54906003)(53546011)(6506007)(316002)(110136005)(71200400001)(508600001)(2906002)(86362001)(66446008)(64756008)(8676002)(66476007)(66556008)(4326008)(76116006)(66946007)(26005)(8936002)(186003)(5660300002)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3PA8X1AEkSlmJo86FJH868n1X7uOCJlhISo3tUMTYx2eMAtD6B+MvuCRACTN?=
 =?us-ascii?Q?ezFWEOoh1biig0wivYblcrC3v+xJL3BaelSLwigxs6PQcImRnWwzywiLRPEn?=
 =?us-ascii?Q?wpDV3Aw4DK0kqpaW1lZkmlFa1JEB75g1yCCbTNJEli4z4EJ6V9ic2r0868gc?=
 =?us-ascii?Q?9HXkhZLZecpx0qODg/TZgXwdlHAT++Z/guJn+VFbdCUAH62xm7CR4ai3v8yU?=
 =?us-ascii?Q?Fw2ahy+9qzw9PfSgKkZlNWK5HvunNoKYbPQy5iYy8gQ8gr8OCnBgW19aKW2B?=
 =?us-ascii?Q?/CLdng7jyyHqQGhqa7emY6FooFA894OTrWutL0Zy49DVVvHzROiDN2XfOmKc?=
 =?us-ascii?Q?ZU6PvW8xqY8uF8iWPWVzqk21AJ6GJOEG5aJyDjXjgghm3nsuGQ+VhYdHcF0t?=
 =?us-ascii?Q?hUHoszN3x3FZ8Gilj3ujwKU0iTfdtGDYyc+3Te0Sw2ZGOExvYjNwUY84VLZi?=
 =?us-ascii?Q?Y2vR1bAsQjw+sNKTQwP9FoUZCBpYAXuYW50E313PRHaGIhvHSECzMLBhuGmK?=
 =?us-ascii?Q?T4Bxnzi2nQmXrPEXCOWWd9+1tojWlAYFTpISzLjKAUR2sK09qOPcVS2LEx6K?=
 =?us-ascii?Q?g29Tx3wDriFqyoPC61V5UH4md9NR0O/1iWALp25/Bh/QQClLfntCuvn1Cq3K?=
 =?us-ascii?Q?UMNE9+z+cIkJgfGqFSK4ueP3DRSsYv3I/CuZTqavr/s5HN/NF5ZTBFezX2UC?=
 =?us-ascii?Q?6SXbcICzMKiMlpNOC2I22acEf7iA0l+iVjVNt5gOIjztPn9itQtDjV45gbKz?=
 =?us-ascii?Q?HWOb598IrSx7vZRXQUI1YwcNQetQbbiChWRvdDAaS2tIBGbzcF9H6tu+vdVB?=
 =?us-ascii?Q?Nd4c3TNj7MLr+fkXYUipBn7wGAowudYg1R8J8DpFsF1xXO2ObgudkLqkdyX5?=
 =?us-ascii?Q?PHouROVRQiwZeK6mA3h5WGr9+DdE+pW+u8d63cyzw62A3VavNgGo6PsKy1UQ?=
 =?us-ascii?Q?40CsdiKt7/AJNEo/p8NFY7/rHNbI/kYJSlkDTbYatkX88lj+bHS2zd9DTflE?=
 =?us-ascii?Q?IPe6rXX9oR8+i/J7ZDoT3r70MKIMol6KfjKEBKFMImCBXRjldCZal1BliOHN?=
 =?us-ascii?Q?A6P83YuHDmA4ch6Np9XX6ah2WEFMm+Bdc3p3Qta8p2LLckeJmKP3EmYDfMIU?=
 =?us-ascii?Q?u6NkEv1aWB64MtSPJWRYLcb6kksfjNYr/1rvo3+9bRK5VShPLJDWVWgXaYh5?=
 =?us-ascii?Q?LrKG3WhJt4DjQN1LWcT/VTb8JuWQFYr3eR2BPak/gLUUgfg2nYPGhh4isj4z?=
 =?us-ascii?Q?aJNvCrqVXoBgfKtweGzsqd+bp8bUenaKV4o9k8a9TTnEgwH2CSAX9BkabpCw?=
 =?us-ascii?Q?EwKK1wyt+hG9Z9Mt3X2N0bJPn0UgS/o2tJlNLngGfKBkD8jA3gON8d+xbE8B?=
 =?us-ascii?Q?M4YwFEPGvotNWuhc6GksKPQ8AIWgHdpNXaZ51DiVXabfNztXo9IkDJnAuZCH?=
 =?us-ascii?Q?93sMsvmQsjOy2ujoFY2RPRfrP00V2TLQZ+2TF1dzS7Gxmh3OAccfKrQoTONu?=
 =?us-ascii?Q?V9gifJ/gHoapKdTiA6HhmSWdmvdxSkQoUDOB40nESzuaND3y6MzQPCYUbVY0?=
 =?us-ascii?Q?U7KgZ7dtTbfNrGGx0J4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d190be6-2520-4856-b833-08d9f281da99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 01:56:18.0908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bimw0g5b7d04QTtBvWVk7ODE4KTlK54t7ShCU7w9C16x92VP3C3XsKDahD3J3mFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

":" is expected behind "case CHIP_IP_DISCOVERY"

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike
> Liang
> Sent: Friday, February 18, 2022 9:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
>=20
> The TMZ is disabled by default and enable TMZ option for the IP discovery
> based asic will help on the TMZ function verification.
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 956cc994ca7d..d2dd526a4c80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device
> *adev)
>  	case CHIP_NAVI12:
>  	case CHIP_VANGOGH:
>  	case CHIP_YELLOW_CARP:
> +	case CHIP_IP_DISCOVERY
>  		/* Don't enable it by default yet.
>  		 */
>  		if (amdgpu_tmz < 1) {
> --
> 2.17.1
