Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB9EEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 03:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D825D10E26D;
	Mon, 24 Jul 2023 03:08:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53C910E26D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 03:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk59iRqkVNwljAw3t4kOSfgO5Uhnhmp7BevgN4jYjfrFoFkiE9336ht+S+FRPKpfvnWZhzgfyIp5Gw1UPdmX2DASe5zvj0TLoF94FBQhxbEZ0C7HUuj9usfB8ArojoI+DshT2TbhpnBw6wQvzG22MIZEM3zGFw8QksmsxEpMRbPsDfb5bYqsvDea8WZkfJkvZ9BTQDT3dtVxBUBcRefbjuiETIXCzd2DLHMlKwnGqf7qybsD6+lhS54wUFcRmBMlI4489C+2NWACURiADHFWssIgJPCRYRXyzUxTROlNVgR1XMzmx4n3zggHso/a2qiqBu2skQQsR73ub1e9kmHu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbFn9rKLt1Qpi1lXJhjlmbyUnFr7EJf00ehGaRkupw8=;
 b=OXa6+z8dzbO7y5GQ6r/F1AZWxYzn5+AQuSoHDN9XE9D/rO2fsBePke3lxGtClI/si7YHYco3O+P3RuH+EEKPXxnOg39doteZvT0VqrCvWyVMrkfBQPkzC9gjMbnv+WuGk6fqtZecBDlvxU9nFb7ObXFFMAZ9s6zuR22oQmXuyrjpLwiTZFnDyOPsuoBcXMGzzasybo/mzuhMUeVclgwLVc3Oj22tRvYjjZ9zaQl3bLz53GHsUvrTVAj1LNJNCKgkDv0VOSEUC4h7TTBKHf4LgN2VGedDKY1XLvC93CVI4Jia33uFcBVZXaKd2sjoN6VfuKtrXl1i3YQ6Aeour73lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbFn9rKLt1Qpi1lXJhjlmbyUnFr7EJf00ehGaRkupw8=;
 b=iwbaA7Eyq/ExbgkDoDAb1ZN1Ap9IwG/3leX87+TccPTQc9LOQqKJZsEuYQqFOcBZaDHGHL0bwG4pCwoP8G3OxJ7Z5M//nqF0g6LwiEDxU+MhDYLh2QTgAaS7vGZu+j4FYD2MdfFbNQd7hqLcVwwWhz0AAj72oGzXwUT42DyomZY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 03:08:54 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 03:08:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Check APU flag to disable RAS
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Check APU flag to disable RAS
Thread-Index: AQHZu9XJHACwNmmqDk+pMFuD9fl8ea/IQH5g
Date: Mon, 24 Jul 2023 03:08:53 +0000
Message-ID: <PH7PR12MB87967EB3438A0B296C9EB12DB002A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230721131747.608514-1-Stanley.Yang@amd.com>
In-Reply-To: <20230721131747.608514-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=93ffbc29-598b-42e5-9157-05ad35aa04c2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-24T03:08:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN0PR12MB5738:EE_
x-ms-office365-filtering-correlation-id: 5f119873-924f-4d76-b928-08db8bf35009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2b6SRpR/z70ny4CkAeIBa58SRBf27m0ZIJPG2/SHhnTqG/D8X/74/gI3+4WGzHjQM7L6DNuV59qbRYtmyIVSyGhht0GW3NIYOsiVeSLbAJvM/9PyHGn/qYQvk7xWZ3N2Tr+tAr1d09Rbe1kn0ZTtCle/+HowtkWSBkfddnLLL5uRq91KSYITM2mxAb+QCLEbZCNLT1vhJs9LvOaqeh+4JtgQVQJz+nXKOMK9Nk+FeNPp1qF0ZDKw/8HD0YzPFCmmnUApwAbOkR3+lN7Xr+VY9EGSeL4rpLYJnCvZqrDVzYW5seZ3YC9KqlQD28Ww9+oLyGwLcLgf++Rk4r4vT8Zmo1JxZV914YI+O2PXCKQtJ3JU1zgvfAQYoyciuqqjn7oHKUfoT1HvRH1yhhnm/W3wh9kiH8UWQwJ4sJDgyXErbwyisUYyANOcd0FWrno7cTGkB8nGxfNUgxbMXdU24SrpgbCcwDRUTB2HizEoLMAvbrsTQFuGrYo9Ca8cLmnmfBzhtLkPRX4rRWSMzLx4JX4JSUiG5xzbeCxU8DoKXCAHT8NQE34aOdXRz5MKpu0PjrSoS7ZbbG941ulESP0fvJOqxoBJmfjtKzAihQaKYT5ZRejGDUw536ur3CYs2S9MnxR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(33656002)(86362001)(38100700002)(55016003)(122000001)(71200400001)(2906002)(7696005)(9686003)(53546011)(6506007)(186003)(38070700005)(26005)(110136005)(5660300002)(41300700001)(66556008)(66476007)(76116006)(66446008)(64756008)(66946007)(6636002)(4326008)(316002)(478600001)(8936002)(52536014)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u2UQBWBoOKL9CThgfxiLcNmoGG8Daa6SRWlxO5+90CXpajq6EYNsk871lQyX?=
 =?us-ascii?Q?s4uOtKrtO0tIJ0JPu19brfWQ6FWLF+AKbIBDOA3DlA6uNAcei9m2IcWmt6Gg?=
 =?us-ascii?Q?z+dvcmih5yVM1ya/7bkydYssFJjnelyVeCuNGcYWtCSx/wa7y4fJ3ddDbRIs?=
 =?us-ascii?Q?r/t5ppjYngS2nvPa+9Ze7elObcqUt3053HYhCNEr+i07zSPGqH7q6gIQiU4O?=
 =?us-ascii?Q?1RjI0T5t5LbzFAASaLOu6/aJMGVoS8mQ3/RimH1nw82BeiecqnxNmsFvXkmG?=
 =?us-ascii?Q?ZoE/B8G158ozCQdp9TmUhQD1xtaN0Tx3C4iwAmnIniLTZlnOeEF68nSHAHcn?=
 =?us-ascii?Q?2OwGkktEdHq+95R4BJfoqEWysii/uRKMfr7lnL7JTqIRjvU99UXq8WMnp7nT?=
 =?us-ascii?Q?q7/JGP7olid1Rn7zAxrOrkUUUE0IvHu+PnGWWfgQtF3s0Bl53C5gjtpOyi1u?=
 =?us-ascii?Q?4CqHypLkluNIiINlRNQ/T4/6eqmdIH4N0+uxBxAsFZ42jVYa5e36vxGMEHh4?=
 =?us-ascii?Q?XPcn6xtJ1MX55YHjtvqcor9rJqm/NDx+t4kjXlI+cMtSm3g1bGSs1J0M2QCs?=
 =?us-ascii?Q?1IsHhiMq3SO6kQcUi5zOuqf2Dk9FJLLDqZuz3VQILXNmu96j50vbgS5pYdpt?=
 =?us-ascii?Q?UrazBfD83S7vJOqZ8kLg8d6IofbNV+gd3BWregxoR4S2crxtLhrOtbj/0DoV?=
 =?us-ascii?Q?hPMMxAwHgCQRzQOo9jEjxN2jBL/A9Y4PwpYqBSAzMRAsTcjCBGsaqNu/joqR?=
 =?us-ascii?Q?kun5CzAuqw12yxlCTKaGCD8hipTr1Xf7COBh9+wwHWqqHpDzC+GjDCkqsiCN?=
 =?us-ascii?Q?5s4MqDPug4TpmwIHpQCuCr6ptzxiKQDh3gHa7vBKSMXkc4trEyx3ZvYruav8?=
 =?us-ascii?Q?t2cz96/pHUJKdaSaUZyVIrldNZlhNKzBPp2oKTKOybLxb9uuyGRChUzDZ+rY?=
 =?us-ascii?Q?AttvDHYHopz1xThlxO7yKYuKbdoiE7bzdkTrkxj1+lceQEriaCFIOfRrmqe6?=
 =?us-ascii?Q?LVvkmGJbMwUlMUBwf98CXcDeXQ7gLIiVWiEzQgOWrw0RR+yyLQb8rphDOTcr?=
 =?us-ascii?Q?1np0Hcl42K75ToePGC1FO/mdlF5sG0Q60sToI4mEy/jR5NXM64ZOXM6QVIOa?=
 =?us-ascii?Q?l7jD60+jKLBfa8S00emWldp538iCjfRVU0dOC5SDATLHrYpzaMNV8v5SCppB?=
 =?us-ascii?Q?ZYcoq5GHlQsWJBTfyA/pXP/rNlchRqFkbl5m8uxwS1N7b+vCjXdP/VsGQfUj?=
 =?us-ascii?Q?AD52+urAKsaWfjdegSX9yi2IlFZr3lM+IFon1NLVn7c73I5yG/wLuZ3Ui4tM?=
 =?us-ascii?Q?H0a//DpOGwt9dckIXHN+UqaQrG9CftkBc1iW8vlWF7TtzeMPjB3pEeC9LbNk?=
 =?us-ascii?Q?pvR2+VHq8Hsr/h4BwDPj7D1F7Ve2Lpwphr59FLufIb7S9fHvf4bJZIwIahkP?=
 =?us-ascii?Q?GfxD93M6WaSxgUEDupUG+B5m1hd6u8zb3IDW9tSh3nxIcQoydzWNWMxEcwGB?=
 =?us-ascii?Q?hIYioPwUvI9MhpDK+GFV7q9wGdCfCpdHvjeAgzznblY41vhPoJVYugTt/DAm?=
 =?us-ascii?Q?nOhnwMdOlRYfZBo3Svc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f119873-924f-4d76-b928-08db8bf35009
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 03:08:53.8673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJntwKvgejnSSspDlJkbY97K4+rrFUs5IUf8xe7Zc9HYWa0s9JvwjCb0H7i7iuS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Friday, July 21, 2023 9:18 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Check APU flag to disable RAS
>
> Only disable RAS by default for aqua vanjaram on APU platform.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2221460e23e4..00a3863a6017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2529,7 +2529,8 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>        * Disable ras feature for aqua vanjaram
>        * by default on apu platform.
>        */
> -     if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
> +     if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6) &&
> +         adev->gmc.is_app_apu)
>               adev->ras_enabled =3D amdgpu_ras_enable !=3D 1 ? 0 :
>                       adev->ras_hw_enabled & amdgpu_ras_mask;
>       else
> --
> 2.25.1

