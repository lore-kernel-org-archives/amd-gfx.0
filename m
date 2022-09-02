Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59B3ECAAD2
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 01:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D4110E3F2;
	Fri,  2 Sep 2022 01:44:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E5110E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 01:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggWfAAIiYb7pj5/5DxvTu5kYy86R4k0LEgB13r/qdjDwYxsK9YGsIrFnHx0X9b9bkIZbofZ22icVb73lro2yRhprTqp5Mf1X37I6cEq0chkn99Th4E9c/qdMSCuvNMHkpVZxh3aw+Jr4oKrarv+UyJkOhCvVKaUOj8mXBAVfZ3IrX+sUTaNiczr/2kA/Ej8Bf1/kd6WGdrFObNscfL/HOQoWSO+M2Cjdaa5GXSsKRJqvodf0FzOFoEs6dML8ErLK64m67n5CdObaIsBvm/Fgz7RGU026X+6d/rF1G26YPW/ywfqczxl3VwfexOkY6mRKfJhCKMiNyuB9A/N5qIBOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N4UeaajCcjJ66MEXM5JAuae9hMtEHaVKpO/8w5fKLU=;
 b=NALcBdwpVnKqMwYoX71z3hYQixLjBarwdi6HdOlADItRIOrf+Oq/Z1CgHeEX4ccxOAnbifW2gDdtgg0cS4anfoxWkhAzWN+TB6FOpxWwWwGyqqh32Go+FKuMD7mNdKRuCWYdoCoUaryb00u34GkVVEDUGH9yUIGY8fzzyOP7v4M//QPZ2Hc17C+ulCbTII1B3Gphq3U5YRCuB+lYSLAq+QC03vpO6YhR8yTQvuJePtlMVlyH0zAu9Nl4fiAat37EE32v8yhbLdHBQ7wfBGEcVTJjvXJITx3PQvxEsxe24Uf2ESjtBaWXgQbvIe5m538qitgQcHMDOEOn9N7WyI02Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N4UeaajCcjJ66MEXM5JAuae9hMtEHaVKpO/8w5fKLU=;
 b=xkO5c17/Gz7NF6D6Vwowtg8NNWUkWRk5wGWHZ/VJK7EzQZL+QSwzsuK72BfuX4m1CyqJp2H5GrhzC4L9hChmiFD4TTgwdsK/PHqeCYagrBFGTqdc/a0yjH2TSTQMu/eaxGpB9EwutKLS2ppd41dsq4YNoi9AEIm74wY0Hcrgkhk=
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Fri, 2 Sep
 2022 01:44:02 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::7404:28f5:f36e:b5e9]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::7404:28f5:f36e:b5e9%9]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 01:44:01 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTSHIy2CTozCUmP5AKYj2Y5v63LLOoAgAAsuyA=
Date: Fri, 2 Sep 2022 01:44:01 +0000
Message-ID: <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
 <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-02T01:43:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=64ec50d8-0469-49d2-8aa1-29f13023105e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d24842-6403-430c-3127-08da8c849c7a
x-ms-traffictypediagnostic: CH2PR12MB4151:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeTxnfAC90JzvZjXiCHtLFsxgGYHtPGVZ+ADjupWsNvmHuCGykeQ2SUhhjftCXxkSHR4qa+33YmTCJVSqTb7ovhjHdr2CRNUAZzKEY1kTPvhIwUblDWaIDfDj3FP6NFBmn2yWxNzvwXD9+Zdw+v/AveH93aEcB/2Q/L+Kna5DxpkBASM6NRkJOIPttQauZAHSZBPsAGBsg3cLMicvuVbnhwl0D2eeuMRKXTzicB0yEQ9pKRXyLVRM/0oQfuUngmp9TapkMzBZoiREEfyWce9x1cjh6cR7ioAoHc9x6wmeXNoq12uDSZt/BcY6Hp7zfLUs6uTAr1jm8KKPjxJ2FrmKLTDHfpQTNemS1wozEM1u7Eoik9t8C7xZnHhagwvD/saOzCrqr3YbzZ5Vh/TLwpTLdLKcnsG6WGZ+uANDZv9sK4ZBgLgplcqsoVbkx8wA0BNo0yDbsvum9Lk70zIEGipFFYz1c7JI4xxI3YES0eZRoxJrcvvef5w9UojBjL/kGDwJM6D+t8U2DMM93pyqzqTRNQTOh64ixw/iR2UdtGh4wfZ+KBIpPl4u573LVdqfRAqmaoIj/T0/Msc8JjTIKJyzpJReFI2jVt8aTyKVQs4DnssSb3QQU/AgFWryG8wl8eECUkXoOwfyjsgBvbLwQEbocsCHKlimYawAhBo6mWXouta0MEFiB3tE7jdzSg2XOb8IdD9Vz95u4GG7mdBPPLhd/E5YCJEfMo5lctAm7Lzz/bfxg7szleJk4SgWQvGo/wes+iYNw8hND6UoMSLb+UAcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(54906003)(55016003)(64756008)(66446008)(66556008)(76116006)(66476007)(110136005)(66946007)(33656002)(316002)(26005)(41300700001)(7696005)(53546011)(2906002)(52536014)(8936002)(5660300002)(6506007)(71200400001)(478600001)(186003)(9686003)(83380400001)(38070700005)(38100700002)(86362001)(122000001)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cRUn5J+QKr5WskrPRhOaeeTl2+ZqlmTHz3Ea3vO6AfSH613LeTdCqJAkuNy+?=
 =?us-ascii?Q?DIA3XaXnxQtjzanQFsw56b4pJYEcmKdSj3hx8HSpQ0FLEKrOP1PNh3opMfhT?=
 =?us-ascii?Q?hm7s+nlssvImJcATJEL4KS3+fwWPfRAyglcgTTXidCiNH8VaJq/zyCsqhvC0?=
 =?us-ascii?Q?EY2ufidWu7heQ3KUnu0khG80Xj6C0cQUWmp0LeWmrIkmGEVuy/SoO8HL373e?=
 =?us-ascii?Q?Ta6AUUAadkoMp51fkR1Z7jOVSUkajmZrktKf2LiVaeFzNDB0ZCAaK2nrNlWz?=
 =?us-ascii?Q?tpsJKBn/6AieJ8p1o3WY/YLtpnSslm8IT29AkOXWSWx29AsQ0Pjwve74mEH3?=
 =?us-ascii?Q?dC7QfgGs3rUQdlVJP/oAOE1VctqUayT/FNdRmcw10MHsS725++7UgB+0su7Y?=
 =?us-ascii?Q?LUlaXiA/T8oX0R2d73RuD+c2uqyH4DxFSAnUbJ9DUUOx5L8ji3/2pxW1yrJh?=
 =?us-ascii?Q?36pQiv+X12OcfRHtc2ia/7hChFdr6/yoIAoQ44vIq/5FMgApXL6xkXOa0WGC?=
 =?us-ascii?Q?MJHI5s0utCoHVKslVKwwPwvf8leDx2ZHYagmissC5l1de+IrEJeiNYe7DHT0?=
 =?us-ascii?Q?NnwbmifZ1HH6uO0WBu8D9J6jpPNA6ACFAB3BjFsyDorXCZKmqV+cKk42YWTC?=
 =?us-ascii?Q?xyO6N9PPY75YAzu/CV04tcq8J5TzZ4BZNP6xvWdq9pFRka+hyI3Y8P6dC4Ix?=
 =?us-ascii?Q?ImbvcHGlkEXpJ5F34WnjDvAV6Z9dYqf95hwbE1dP6l8+wEpI2QCvQGTEjSX/?=
 =?us-ascii?Q?yuDJGIZUoqYSoDaqbK5xsNB1+jMiu0PcapqSzMyvBTCxQsxMlrOF2sFUisbf?=
 =?us-ascii?Q?t3+KlCJ8KfFnN2WTNYRKU32gMXVfX/9Fh1YjXH8O9UhfIbbm9ez194blTFdA?=
 =?us-ascii?Q?whJXh15KULxmrRI3R+M/JRRZkwdypsujyiy4j4BSqVBq68+GqlSARqoZw0bi?=
 =?us-ascii?Q?VXcC9/mTusS19U/Vv7zqMB6k0/lXYbQKZFwLB9+Hmf2KEccmJX/+eozEQ+nl?=
 =?us-ascii?Q?uoN4wKKnLmIS8pRT0HNr0UJhomE0/BVYLChTNqxNgVVT04utC8BKfEWlks7r?=
 =?us-ascii?Q?ojubSShYDvJm/LzTOQGFywZ3dTrJxWM2LsQFUAdwzPHcEoygm2H4Wb2gM4DF?=
 =?us-ascii?Q?vWxTr6KK0JD04nMvkKzxKCp9t3vXRabw92dn6ehhz7mSL/TluKmmlY3KRfGw?=
 =?us-ascii?Q?r53D+C6h527NV6bEKIp5h/FwJhQqCSe/GxwT9LXW9Lc5VKaGrpS5SpCRzBYI?=
 =?us-ascii?Q?kZAl3Idc3U/5HqHeEFBi8JLjNBpEqm8ECEe6BZKW+dhr5GmwGZgvdoeHX+kI?=
 =?us-ascii?Q?+EVJOqo0Vb28t1b/DCMUfVbC7OL08KJTLvLwKWdkclMTs3lbWbCgzTUon3/3?=
 =?us-ascii?Q?uZRkj/ezmlu/HDPphIFRcz+ZvXBAdCiEIludpd8YzDyDISj3D6KcBCgTSMlZ?=
 =?us-ascii?Q?BliP16IV+gzlN5djDrfPL2JgIuBBDYcrNSAE173b52+CyaXD8gzVRRApSOKh?=
 =?us-ascii?Q?MugWy1T1XTlS53c/IYchIjaGGqbifZF2JUMO/KzTSDlk/VM1jt3ScXyXU2d3?=
 =?us-ascii?Q?eBRAIoZzco5se8a6re0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d24842-6403-430c-3127-08da8c849c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 01:44:01.4859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UVDmpr7SFR8F7eMA/fcMpQ3E8t1ZOXx7u8c1nHbA0DRZnGihJziwcCM7cUkcc0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Yifan,

Yellow carp's cache info cannot be duplicated to GC_11_0_1.

Different point to GC_11_0_1:
TCP L1  Cache size is 32    =20
GL1 Data Cache size per SA is 256

Others looks good to me=20

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Huang, Tim
> Sent: Friday, September 2, 2022 6:44 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow car=
p
>=20
> [Public]
>=20
> [Public]
>=20
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
>=20
> Best Regards,
> Tim Huang
>=20
>=20
>=20
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, September 1, 2022 3:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang,
> Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
>=20
> Current discovery table doesn't have cache info for GC 11.0.1, thus can't=
 be
> parsed like other GC 11, this patch to match GC 11.0.1 cache info to yell=
ow
> carp
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24b414cff3ec..1c500bfb0b28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev
> *kdev,
>                 case IP_VERSION(10, 3, 3):
>                 case IP_VERSION(10, 3, 6): /* TODO: Double check these on
> production silicon */
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these on
> production silicon */
> +               case IP_VERSION(11, 0, 1): /* TODO: Double check these
> +on production silicon */
>                         pcache_info =3D yellow_carp_cache_info;
>                         num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cac=
he_info);
>                         break;
>                 case IP_VERSION(11, 0, 0):
> -               case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
>                 case IP_VERSION(11, 0, 3):
>                         pcache_info =3D cache_info;
> --
> 2.37.1
