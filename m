Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711C8C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 03:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20C310E28A;
	Thu, 18 Jul 2024 03:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qs3gbGy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0AE10E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 03:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II24N/p+9f5wlRnTrYmXJizQ6cICapapCphzPiaU/1mBNeystpDFmZl7I1obp1mDmWjZ0OCGgLrpe66Lgb0fqluFk0EfcTO0I2hdKeH7nt343CSErpi7lmhCII/dqA+aS4idVD2TbRQS6rl40iRCkD5VSS8zQDkgh+yILU4eU2tqW+wcQjzcrhI7YGxL+SYUco7wdXzeMOyDlpr4FiRiywIJOtGhq8Ph4LvCiZIgCjgTeAokQl0/1t/RtmDUK6/ldiiqtv4s/ltLCK3sV+X4ZkNEMQ1VqvobeYthBZ58ebRGF8AoZJAmTRkgvs8WaC5Qn42USaGpEce7gXDQED3IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JO7OB2PBEYYqbE7N5R3oM6uqPtcleAdjwbVOOZubyo=;
 b=i6J2F4GSSlN+/PqpweNvgbBwudOoZSN0TaRv7YXs9gzZ1A2LOlCexh8PXq5N4gV+a26i0w2tjkg/+ofyeABmIDXfHn2+P2eotIy5LkO19sCDK0kGnXeQrwLH4ad9KVDputatqRGwJ16xlZdYLvYzsep3zi6Ud0BB/3Z43YJXr1aKxXGYTF0tpTqty1CiIyyIPzjDHFbKh+g8Bm5qR/g+sM0lsVdrgKjT8Xp6d6xteaC144Tk33nMOdFC56D4M/OIacSAohMz5BucXCvJ3cQrixlO+BzIoZJWeAjGgoe+jHycNKPGyMzx7SfUaypd5zeZelYwteaOFzU5nf5/gctVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JO7OB2PBEYYqbE7N5R3oM6uqPtcleAdjwbVOOZubyo=;
 b=3qs3gbGyY+MlwYgGgodxql/3vNy0S2+p0lHJb/gW2K8buvNngaNHrAD5gBmlaI6+uG+PB40RFASgWEY7RyfyqzGiJWbHM63GXWiEMan994E1Nf6gNjNpmkxpeHaYQsOda8HOsQjhIX1t5NvyyUkXPTGDy3UVyiXF6Zwi8+HLnsI=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 03:32:21 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 03:32:20 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Topic: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Index: AQHa2CGXX7DIO5W8SkeRbrpn8BAzHLH7ymuAgAADKXA=
Date: Thu, 18 Jul 2024 03:32:20 +0000
Message-ID: <CH2PR12MB421559CBBE6F3186268DBFEBFCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <PH7PR12MB87962BBBFF9F1E1B476077A9B0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87962BBBFF9F1E1B476077A9B0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a0b65814-a6c0-4b21-bd07-b3d6f3d9d7a8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:44:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB5734:EE_
x-ms-office365-filtering-correlation-id: 9ff61658-92ae-4efa-eddb-08dca6da3b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wJ/ZCOsHAGFaQd5wnNs4e8eysgJBaQAqIsWyd2KqLAkSbrectXmb+Dvo1rh8?=
 =?us-ascii?Q?e8Sr/WAjRigWMcTQufNZzoZ1BvuR9laTEV1kb7TDaSqDy/lJKEG7Z1hHYZSp?=
 =?us-ascii?Q?JnOBqd+5mnrD5+a9NMj1yDvQ4b9v/+4UD+UjFlk8lgTOgerEotT0GjSlhi39?=
 =?us-ascii?Q?Uc+45OHHOqGZqAZHYoFhN8wdB+eRQ+DTbbQGAJcK0KMjPHty69CKRow9Nb3y?=
 =?us-ascii?Q?NOb1isZDWJ5cAL6SOJxhQsku/N5T0rRDqUdYIaPCCAp2f4u/FL7C9n3ZxNy7?=
 =?us-ascii?Q?W7rDR2krzwu3SGS42hT+ND0pwDI5nJCr35uUxiJJuyamG60HKq/xK/GJxOrH?=
 =?us-ascii?Q?bwREfXbT5jbP6Qn8soy7Oc2Q2JacdxfNixsLp2HmNXizb/9CUivWsEK6iqUy?=
 =?us-ascii?Q?kcvcrz6cec8leor+tBQstFCpE4qnVCuVl8H88holyUI/ofV1e0+Kts+UD7Rm?=
 =?us-ascii?Q?lmtHPan6H19nez4dyhnAPaRIx+qazMAINeO8btdWZ+gYI96k23owJ13MZiQi?=
 =?us-ascii?Q?k/zdZaQDOGWigFHB2J0Y8HPAmt5MwA6Ps32CEkAq8lXB174/eNBazlvJlMp0?=
 =?us-ascii?Q?Wa3fi586tfnRyFB7NFapWNt/igm5KjQcnMaRAZqOqDDrT2ye7cBwcsTER0EH?=
 =?us-ascii?Q?+763RK2xu+v5rZnNwCDdCgyZU66BWwJsGfYXvl7mihBTe3RcvtU3o9BLl1bV?=
 =?us-ascii?Q?GDIEOsxec9wKjno2hbeFbw7aZgZPrtEON5JY/VEgu12EeOvPENhXzahRHCLc?=
 =?us-ascii?Q?qd814T0HvR24Vkm6rkyWXyrgbi42Bgi287InnZh85TlLC9p+jXEQwG+tsmed?=
 =?us-ascii?Q?6GF+2Ql3xhptMgow3+BmTYOM5Dk+UbDtJx8hA3Wypv1Zz1mLKrxs3xMHe04U?=
 =?us-ascii?Q?fdxvPcHcN4U2J4mR948izr6PYZ9ceDQzgkzKz5+javst2Fe+qcaqKPzkUCKJ?=
 =?us-ascii?Q?jk7RetYZh2B7rQ3H4yq4dUc8QlBqRePDj/OK5g1jWd/DF9ABOMf0gh/8yHZH?=
 =?us-ascii?Q?QWMLzdrObaKGfM03PhMzlXOJdCENGeoaZz3qsQLVb/SMCXbfIUiAm0jzu1Nf?=
 =?us-ascii?Q?OUjlMwc3TWNLswBeR6OSJIt5cjslUv8rk5GYQsCyCmazKn0IXAMrW3AqTXXq?=
 =?us-ascii?Q?frHPHw/p83rIeyoctV80rDhXqnOWmM6wj9qhfN6QDLYHXjUzDVCrTmtNiiUv?=
 =?us-ascii?Q?rH5uFAV+yIO4srbh3ZvagbJvszIEXDlj32SCb1QQ8OI2kzYiThA9hDPfUxq/?=
 =?us-ascii?Q?Wf/5KEumrGHVQVtWy5zoEYNXhjdkypCQ+/mKY4w9mojxTsZM6NkZ35S1aloC?=
 =?us-ascii?Q?totDoVxySPxsTX4k/ampLrtmsutEPw7VB1ADYQGU6NkPDPjcRk9kbhilgnXj?=
 =?us-ascii?Q?vraXmacR1mIAYai+kbbQfV4qZU8p1TN8/dgz/RvtuDrVPOm8ew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xCC8fPtcHUxGLUSWmyG/mT6A+d6qiphvaBRNU92wiy/CkH+DfKl94uPA8WRA?=
 =?us-ascii?Q?Kg28AP76NhBBVtDz1dioV3h56TyJJLsOLcyNlK2bPs088x74N7S9PrS/L+dX?=
 =?us-ascii?Q?15o5GuH6s/z6ifyARUA3i6zVLJl17gTHAdeD/wOopukMxlF1ZRz/Xa+tDOfC?=
 =?us-ascii?Q?Vj1s8hbeOuxkGpNO/FsBbvN2YmYFjqu9EygJqdn89kqcd8qXGYxKEe+Wg7w+?=
 =?us-ascii?Q?g/kgpBJFG6T+vi/1trso6mdAj65vX4TQEvSTqY3z53mBiLe9IvQ5laJDIp0o?=
 =?us-ascii?Q?ptq4dpjhBFDnFDFgtbqF7XOugOQ2KRtvKJCKpBmKNCjV3lV+d7zRELoRbd1a?=
 =?us-ascii?Q?79tN4ZHKLtYmL+1Jo5r3kau5v6whDLQKD661fs92jad+x15xPZ5nigSx6Z1w?=
 =?us-ascii?Q?gn00YeA2x8QrTF3GvVhhBzsipKmudPRTPIhDkv/ZzkVmwMhKyKFG99EMIhOM?=
 =?us-ascii?Q?mK2JrAllLenVxgHXx7eY37eibMons/BmlZUQHg8mWWmwBbgVgeZlLRhCb0oc?=
 =?us-ascii?Q?k9gdRLABYwvCWEQJZ4pf6bov6CjihgUPMPMRW0UTr8eaQvM59C2y9ht+QSLY?=
 =?us-ascii?Q?0/7fyF41Qlpe6HAfQa9PBHXDir+9nm5K7idpg8hqh/46UaFD50XI+p/zg1nh?=
 =?us-ascii?Q?PtfByPFIF5nIrGDVAcZKa/pDKMPfJ5Aa+cySrmFivBZLwHi3yZkQ1/oiX9/s?=
 =?us-ascii?Q?+whg3bPnyG/4jWhFdAygAyXS8Zs/USgBlBQNUH7V6CUyuTsnsnwbni9F17fb?=
 =?us-ascii?Q?vhrx8YJM8d1Dx8ejGjDR+HnfapmhFbF8IworL+Maog3Bl36vgtaDgMLscPX1?=
 =?us-ascii?Q?Kwt+QfpvYa+WekWl39kXD5lAVTXBla3bbzoYng99a44eBjdy743MqwJKmvRV?=
 =?us-ascii?Q?eSvfY3oymBnQ8A/sEJoC2pXeHjI7cGoUDiVz0laHYZruXVQwFvtQHE0sfcDo?=
 =?us-ascii?Q?UOjd3g1gjYz7JigvOWqzoHzWFJ9kyboUZSwWasN5nBgtxNLolwhGh9oMo15a?=
 =?us-ascii?Q?ukxkT7z67HKjZPP1G3P15iF7Ri83U55K2l00lj+QIbZfRYEKHV8GZUFOjOJ/?=
 =?us-ascii?Q?KJXweq9oeH5VvolcROuKbmHVWdZOQ84f59O7Jkci0aXbtnkJohmwKXVV9su9?=
 =?us-ascii?Q?UPf0yXjqy0P27jgzPaPJBQn6Fp5P3QbMvUymZCbAEwWvRwPDHrofn7t9aALR?=
 =?us-ascii?Q?kgQ6KCarvLkRMS5KePIx58tdSLLAtruTe2+HNQ/BQC2Tb8r1jlqT4im2wHuc?=
 =?us-ascii?Q?Ml05/vzCbe5lC4Jl0ppOQq0jvl/2m71X38HxF80mUoBw7mRQKWHCNsW//fjW?=
 =?us-ascii?Q?XHzzC8Odqt7Qs41eaVHKl/wknCDjQkgIzPpHZ0XtTjULL+KLdI94kg2jvzi7?=
 =?us-ascii?Q?m5hMdpQ8CYnesuH4ZxNhHFrC+HRghxpNrjdA88qO7T54flmNA9nrNp5tuuqF?=
 =?us-ascii?Q?+WW/9LgkT6HRvjdozXM1iG3xZwwYHI97hpxNQg7Z2XNhO95POMauzg99B9A5?=
 =?us-ascii?Q?LwNcYzzAHzquWcSoqzwX2bvtKPIOFwau47+JgadJU8/h4sdgNzwRs7zvePd2?=
 =?us-ascii?Q?KclSO/rEF/avD5cipyo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff61658-92ae-4efa-eddb-08dca6da3b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 03:32:20.8527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z66cWYNYcciZAPdbVQr+qvoK9yrxoZSgzFoSunol1kOJlHqvSTR4vpzZeNt9DbNqiX0qWk3ZmBoAPODA+EF0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 18, 2024 10:51 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion fu=
nction

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 17, 2024 4:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
> function
>
> Split into 3 parts:
> 1. Convert soc physical address via ras ta.
> 2. Expand bad pages from soc physical address.
> 3. Dump bad address info.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 116
> ++++++++++++++++---------
>  1 file changed, 77 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 9dbb13adb661..eca5ac6a0532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -225,26 +225,16 @@ static void
> umc_v12_0_convert_error_address(struct
> amdgpu_device *adev,
>       }
>  }
>
> -static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
> -                             struct ta_ras_query_address_input *addr_in,
> -                             uint64_t *pfns, int len)
> +static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
> +                             struct ta_ras_query_address_output *addr_ou=
t,
> +                             uint64_t err_addr)
>  {
>       uint32_t col, row, row_xor, bank, channel_index;
> -     uint64_t soc_pa, retired_page, column, err_addr;
> -     struct ta_ras_query_address_output addr_out;
> -     uint32_t pos =3D 0;
> -
> -     err_addr =3D addr_in->ma.err_addr;
> -     addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
> -     if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
> -             dev_warn(adev->dev, "Failed to query RAS physical address f=
or
> 0x%llx",
> -                     err_addr);
> -             return 0;
> -     }
> +     uint64_t soc_pa, retired_page, column;
>
> -     soc_pa =3D addr_out.pa.pa;
> -     bank =3D addr_out.pa.bank;
> -     channel_index =3D addr_out.pa.channel_idx;
> +     soc_pa =3D addr_out->pa.pa;
> +     bank =3D addr_out->pa.bank;
> +     channel_index =3D addr_out->pa.channel_idx;
>
>       col =3D (err_addr >> 1) & 0x1fULL;
>       row =3D (err_addr >> 10) & 0x3fffULL; @@ -258,11 +248,6 @@ static
> int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
>       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
>               retired_page =3D soc_pa | ((column & 0x3) <<
> UMC_V12_0_PA_C2_BIT);
>               retired_page |=3D (((column & 0x4) >> 2) <<
> UMC_V12_0_PA_C4_BIT);
> -
> -             if (pos >=3D len)
> -                     return 0;
> -             pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> -
>               /* include column bit 0 and 1 */
>               col &=3D 0x3;
>               col |=3D (column << 2);
> @@ -270,6 +255,35 @@ static int umc_v12_0_convert_err_addr(struct
> amdgpu_device *adev,
>                       "Error Address(PA):0x%-10llx Row:0x%-4x
> Col:0x%-2x Bank:0x%x Channel:0x%x\n",
>                       retired_page, row, col, bank, channel_index);
>
> +             /* shift R13 bit */
> +             retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
> +             dev_info(adev->dev,
> +                     "Error Address(PA):0x%-10llx Row:0x%-4x
> + Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
> +                     retired_page, row_xor, col, bank, channel_index);
> +     }
> +}
> +
> +static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device
> *adev,
> +                     uint64_t pa_addr, uint64_t *pfns, int len) {
> +     uint64_t soc_pa, retired_page, column;
> +     uint32_t pos =3D 0;
> +
> +     soc_pa =3D pa_addr;
> +     /* clear [C3 C2] in soc physical address */
> +     soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
> +     /* clear [C4] in soc physical address */
> +     soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);

>[Tao] these bits are already cleared via UMC_V12_ADDR_MASK_BAD_COLS in pat=
ch #2, is the clear here redundant?

[Thomas] I think these code are like checking input parameters and cannot r=
ely on external call data.

> +
> +     /* loop for all possibilities of [C4 C3 C2] */
> +     for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
> +             retired_page =3D soc_pa | ((column & 0x3) <<
> UMC_V12_0_PA_C2_BIT);
> +             retired_page |=3D (((column & 0x4) >> 2) <<
> UMC_V12_0_PA_C4_BIT);
> +
> +             if (pos >=3D len)
> +                     return 0;
> +             pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> +
>               /* shift R13 bit */
>               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
>
> @@ -277,14 +291,40 @@ static int umc_v12_0_convert_err_addr(struct
> amdgpu_device *adev,
>                       return 0;
>               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
>
> -             dev_info(adev->dev,
> -                     "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
> -                     retired_page, row_xor, col, bank, channel_index);
>       }
>
>       return pos;
>  }
>
> +static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
> +                     uint64_t err_addr, uint32_t ch, uint32_t umc,
> +                     uint32_t node, uint32_t socket,
> +                     uint64_t *addr, bool dump_addr) {
> +     struct ta_ras_query_address_input addr_in;
> +     struct ta_ras_query_address_output addr_out;
> +
> +     memset(&addr_in, 0, sizeof(addr_in));
> +     addr_in.ma.err_addr =3D err_addr;
> +     addr_in.ma.ch_inst =3D ch;
> +     addr_in.ma.umc_inst =3D umc;
> +     addr_in.ma.node_inst =3D node;
> +     addr_in.ma.socket_id =3D socket;
> +     addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
> +     if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
> +             dev_warn(adev->dev, "Failed to query RAS physical
> + address for
> 0x%llx",
> +                     err_addr);
> +             return -EINVAL;
> +     }
> +
> +     if (dump_addr)
> +             umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
> +
> +     *addr =3D addr_out.pa.pa;
> +
> +     return 0;
> +}
> +
>  static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
>                                       uint32_t node_inst, uint32_t umc_in=
st,
>                                       uint32_t ch_inst, void *data) @@
> -483,12 +523,10 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       uint16_t hwid, mcatype;
> -     struct ta_ras_query_address_input addr_in;
>       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -     uint64_t err_addr, hash_val =3D 0;
> +     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
>       struct ras_ecc_err *ecc_err;
> -     int count;
> -     int ret;
> +     int count, ret;
>
>       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
>       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -514,17
> +552,17 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> *adev,
>               MCA_IPID_2_UMC_CH(ipid),
>               err_addr);
>
> -     memset(page_pfn, 0, sizeof(page_pfn));
> -
> -     memset(&addr_in, 0, sizeof(addr_in));
> -     addr_in.ma.err_addr =3D err_addr;
> -     addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
> -     addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
> -     addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
> -     addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
> +     ret =3D umc_v12_0_convert_mca_to_addr(adev,
> +                     err_addr, MCA_IPID_2_UMC_CH(ipid),
> +                     MCA_IPID_2_UMC_INST(ipid),
> MCA_IPID_2_DIE_ID(ipid),
> +                     MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);

> [Tao] I prefer to using addr_in as input parameter for convert_mca_to_add=
r to simplify the function, and it's also convenient to make the function a=
s a common interface for all ASICs in the future.

[Thomas]  convert_mca_to_addr will be called in multiple places: 1. Detecti=
ng a newly ecc error; 2. Loading ecc data from EEPROM (when using new data =
format). 3. Switch NPS?
      If using addr_in as input parameter,  a lot of  redundant  code must =
be added to convert IPID to add_in in  each place before calling convert_mc=
a_to_addr.
    Each ASIC may have different address translation,  umc_v12_0_convert_mc=
a_to_addr is only for umc v12,  if address translation has a common interfa=
ce in future,  it only need to change umc_v12_0_convert_mca_to_addr.

> +     if (ret)
> +             return ret;
>
> -     count =3D umc_v12_0_convert_err_addr(adev,
> -                             &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             pa_addr,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
>       if (count <=3D 0) {
>               dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
>               return 0;
> --
> 2.34.1


