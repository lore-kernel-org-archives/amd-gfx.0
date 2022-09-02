Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E54ECAAD2
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 02:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A68910E492;
	Fri,  2 Sep 2022 02:27:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBF710E492
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 02:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka4472s+6lHCP/+mD9FCwYBX+oa4YC/0hFpaFbbnU/9ATBqCqRWzbDlwH00Uil2O1a+vZIFaaM33sEX8YitRJS1ZjLBfibmNU+Q6lnng74coC8HGIbRAhH1mtGxn9nIa7KXaacV7mPZMPOV8XCGFITKsPv7bHYOboxeHFtSMoQk8pwDv4D3wRkWw9hpVnDPfha7nmkstrzHP7oisoLAnU+qdOifOZVUF1ibrx+bxYBjGj1qgggbw1fyuC0KxfRMs9xCKdg0+irzTTEZGTDSsm6LertR65z2ohG+zxtFWZw0v+zxzBpAPhhX35oUaiYbTfGU8TaXoSwC/D4tBw0nzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnzRYoIbPdd4cF1AbuTd2OLa98RozJFRUcEdP2UzZG8=;
 b=O78hB67SyHqjXg3HiGj0rqkEAy7BTq5UiOR1PS8SWeJAw5Z3B/PJ4yoDDwinbd8fS8D07HSf78pn3nTkEHUt4pQKBG/xIJ6Ick64B3r1KLmjQqRq76CsijKEnX4po6rDyV7a8UMRdSSM05MWp9NaPsuixYReDnM0GC0VOYdsEoX0Nud8mjuuuPnDJ8xz3d3VgvtRJsTcDptk1vmrLP1tPbXQLv65DC9w0ZoRiMnymoFp231D+peB610TSz+rQGimuLmivS2UZBc+Bp9H+cA2SKzSLV/PzCrLv2N0lm0uyDS35wEDt/iJdX3313XbaBBOiQ7iP45E+HVfuADxsJIkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnzRYoIbPdd4cF1AbuTd2OLa98RozJFRUcEdP2UzZG8=;
 b=19Zrh74CnwxBZHDfVpBBsZ4bnBrrYuJb5dgJLe15qVLFtNp/FF+5XvA6Zkt7a/1/QE6MemTvluDYEIhG+/TLMVSIQTVnDG9ingKTnTMNuRRvtf8vPsB4U4j8wj4ZnEhoWLEk2PpZDJajro1SY1ErpFC3+9zOzOT3czzJ8jQpiu4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Fri, 2 Sep
 2022 02:27:41 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9116:cb67:b4da:41b1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9116:cb67:b4da:41b1%4]) with mapi id 15.20.5588.011; Fri, 2 Sep 2022
 02:27:41 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTQiViwZFIdEEa9gDF8/jJrY63LLOoAgAAyX4CAAAn8sA==
Date: Fri, 2 Sep 2022 02:27:40 +0000
Message-ID: <CY5PR12MB6369CE86D66FA5010B56589EC17A9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
 <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
 <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-02T02:27:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5918864b-a1cc-482c-a629-6fb80a695130
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd402ca-fdf5-4586-aff4-08da8c8ab5cf
x-ms-traffictypediagnostic: DS0PR12MB6487:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGR0+aXIDXW+JtcLXWeStTJqOzzBx6azpYRP8z7ikssslOAFceuNO3HWVosOp4QcmXUgyudxDaAlMJzExs7aR3fccHn31c1xoMcMXiVrTFniGglCqcgLadZRXWYQYrpdFHdWEVXpU13p0iBC5oYvsPnRJnDJqLfYfwza+4fSxywYZt/XYBoA4NvCrttw0XqzQCl3BhU6kS+W3WwykgCEwOewcWWFRoNoht0pYIVoQ6seH6l3Io4Esvs6/Qo3ZrKwc6gWs62dyLmV8Vkab9mwXmqTNZOQaC2gDvMapNaOJzVKsH55Ft5YPmBp52Duq9Y2/Svefwy3lXR2BxPmvrN5Lb/iG82m/c4v4KoPElBmJkPC0Qm52O9R9xbtVljvEFvsrjNMT54NIR2rfBEgfaolUGnUSCSxPjSZ3Pn5duLFD8LwPim85Gy80oSk4W+uh+yXmzOdGJB3YPMO2GmRfUBRpeq5dnhHWTeYW4Ez2VItbXR42qGZewFRmwebp6U5kqcv480t1/26eofQzO9eAajrmpXlMkyWBQxan9DrdH54BX4kXb6IXlstJwziuvCHeuZ2W3+knhX+h7zoC6wBjM891DSanTW73eVZ6RSRFV1iQcKYxXDWpHmnTZ16PKOUdhNkCQF+Jcu5OGieSzTIlO7MA2HJaBJOSIV8+5oL2Z9RW39L8k3EKKkABrq9vNrBqtBOdVn0rERCttwUKGG/clPUkrSx9EAQWyIEUOU2ftxd7WPLGS1uuPrTsSvSobZ2gvp+dOopfgABH6QZl93xmHhFxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(316002)(66556008)(76116006)(64756008)(66946007)(8676002)(71200400001)(86362001)(54906003)(66446008)(66476007)(4326008)(52536014)(478600001)(8936002)(5660300002)(38070700005)(110136005)(41300700001)(53546011)(38100700002)(6506007)(122000001)(2906002)(55016003)(83380400001)(9686003)(7696005)(186003)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mekSL2qCkU9agOnPskZ09ZxpDCNhB9ulGXt8ZNZYBpViBeK1CyOYCp6JjPPV?=
 =?us-ascii?Q?V3POm8xp5HEZJvSgSja05oypDC02MEnMUPC02VsMZCjlO3Af3UURcKx+Vgnm?=
 =?us-ascii?Q?Sai0iZdEHjgSQ3J5AcMhCasX3S73I+hlWCH5A/jr4v2vl0VX4C0i1Doitopx?=
 =?us-ascii?Q?ii4eoI2p72nL2DXaHztEVkyO1E42h+tYaojTqUqct8msHGGtWVZPcV0eSiGT?=
 =?us-ascii?Q?rXOdw26eWic5vjFt1i/eD5uq90hON3sD5NuudFSSbz3MOBzn9sj3r7nxDO7P?=
 =?us-ascii?Q?5rBXThfOiu3GoLjJEYQNwiGHvXyeva4FYU6uYjGY/ZcFWGZbn431vkrBCpSV?=
 =?us-ascii?Q?fj5S9YSrlD9/jxuYvW9vaIfIi8r7nd/1+uXVxMNjAezaW+CQRIeH/pqPjgsi?=
 =?us-ascii?Q?pMYAkRbdS/Kfs1JctGr5eN9hioFULIHsPkaCwaFFEcUrtm4OlAUaAIxJEGoQ?=
 =?us-ascii?Q?YPwPYom++8gkAAhvJxZomlGDigzPzc8E0fayHYG237ihPaWEg2wdpIe2kMha?=
 =?us-ascii?Q?aK9QpN8WwFTzPhNDTR9FJyJS+Pgrkw0kMmPeQMFzt8H4Byi8G9ea7UcmxJUR?=
 =?us-ascii?Q?HYa4w6gBo9dKwEwDsK7Vt3b/tMOw3vnbkJretIT/ofnqWHiL0izK2eMGfpeB?=
 =?us-ascii?Q?lb2HVx/5+mRpWbB6hFDlPiW+lTMg/zkhnCHSA8eBPKATYu/rR2EtMcGp60m6?=
 =?us-ascii?Q?GP00oqWLCRM7lrxscIbkd2v88eaZuzl1ZzMyVft0eu3vEku7FatM168t9c8H?=
 =?us-ascii?Q?hj9XNTHP1vcnFigDy2rFN7PuO95b5fOJi62kKf/7o2YgIazrPfjirJW7cBJx?=
 =?us-ascii?Q?0twH09pzo2uc0Ph3xTpJko0Pc812pvE12KxlvS+Bj7eXNmbWaux6RWLDeNCV?=
 =?us-ascii?Q?ZW949gSslcGlBpK72cGvN1CBGjMyLA7wuiNSCyheRaoKNhc7xNHjvQekeMbw?=
 =?us-ascii?Q?+HcsPRTEbNMrQql/i7WOs29Bjgb4nhdH7PMlkXBvdPZ2ZvaBmvqVm3aE35TU?=
 =?us-ascii?Q?Yt00OXPaFIylr+54hj5gd9d4O1N4+1iaElXrh4Kx+vif3WiJzUrM1Lna1imU?=
 =?us-ascii?Q?3iwz7+9m6vN+6JnfYyio0cZ5V4iFO7qiuw7WYgeLB/CWZfT1sCFhe/lsd5p+?=
 =?us-ascii?Q?jBGQdfB2fSqKSZao/Ym6OvEXRMGwisvQL/LmKwrW2kaAPAvqHhM0dTWOBPMe?=
 =?us-ascii?Q?5oGuNBkzGDuRav6VjcxtccSTQx0WX2Lh0NC4E/0xL4s5gJtwKdKxyypgkZjT?=
 =?us-ascii?Q?kt+v5/9H/BYUXdI6Z7/tbwAQt5xGNDK9fCUfETFJSvQTj3ok/HCOc6TN72yz?=
 =?us-ascii?Q?Gz9WUYIpLlqIX7j1yOZgIPmjBht1imXojhR1aOs0BQu8M9dtegMJozIAO1Rx?=
 =?us-ascii?Q?X2s0zmgqX92TfXzvUNsKRDXIsNmOs6zh12IHlr4GI+9JGlCHPKSDtU1u98eh?=
 =?us-ascii?Q?o/9rutRXx326MbFdPAuDoN4vQDeqAc+mLoNXGSZbEQkkRbzhzOxVVj/mQUPp?=
 =?us-ascii?Q?6FNsfuk7/TvxFcjlntNLPPTCri94ZU5IzMgB9KUlqRx5F5gK3SNCi+iUoby3?=
 =?us-ascii?Q?1Fj4qrfhTeY2452wsp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd402ca-fdf5-4586-aff4-08da8c8ab5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 02:27:40.9696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c2xuBeKRKalFdTvKNTTGvBDkIu2CSkS5Cj04kZ8WiiXv6uW0YLS5+4QejG4faYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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

Hi Aaron,

Yes, the cache info are different. But this diff is intentional to workarou=
nd the discovery table lacks cache info in GC 11.0.1 issue. The workaround =
will be removed after discovery table finishes integrating cache info. Give=
n they already have a test version, we can pend this patch until they finis=
h integration.

Best Regards,
Yifan

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>=20
Sent: Friday, September 2, 2022 9:44 AM
To: Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; am=
d-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Huang, Tim
> Sent: Friday, September 2, 2022 6:44 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian=20
> <Xiaojian.Du@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow=20
> carp
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
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim=20
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
>=20
> Current discovery table doesn't have cache info for GC 11.0.1, thus=20
> can't be parsed like other GC 11, this patch to match GC 11.0.1 cache=20
> info to yellow carp
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
> @@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct=20
> kfd_dev *kdev,
>                 case IP_VERSION(10, 3, 3):
>                 case IP_VERSION(10, 3, 6): /* TODO: Double check these=20
> on production silicon */
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these=20
> on production silicon */
> +               case IP_VERSION(11, 0, 1): /* TODO: Double check these=20
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
