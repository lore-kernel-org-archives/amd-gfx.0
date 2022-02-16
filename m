Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E33C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 05:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042B610E621;
	Wed, 16 Feb 2022 05:28:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EC110E621
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 05:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caJE9/LID0NiRNTL7UkniqPMt7jkK3rbsSsmotD2P0Z3mgFajJRjyFqoeB5MXSe6ThYR5B5ewiVGOfkDaK+wO0jZnQ/D9DNNATWVUpTi2tkLIPfj6MrCMJToFg67crhubc/kdiUcx4CQcIOe+/P3x/3Lqz2KvaRf2sYDfC8arbk5ajRzl6XKUxo4gjEf+R3H7Jw5HTisXsdxVc/jNPIRwChANDLP4l+GkrDhLcdVzcg2JyDpidrSLJdOkX30LXczOJFmT2qLacn1jvFIxELVfO3M22YUmTCMCZyhSIWHk0QNzdb7lg28q3Nxn36B8+EhKvhXP0nIhmhOd3HodHlNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IBlWi7C6sJUpxOHijKTuYe9DNJ5Hu+y/8z0Pz0DTl4=;
 b=UQQfgIdtnTVmfetTc7En6hXM1xp6cDII9toAIVc7sJnO9r0Qs85R3JGp8aHExfNQl+4D+njXOENG8gT8RPyBGWJGsgogag43/alAxA8Nwq85LLIN5JV95ywzUgVdJvni1LFUB4GzYDqA4DVP0RcKXHdLxHM8B0BeSJ5zk7d+43J+tuOSRy8TRESxH7/lL6vAWaabejtLvwBXSpitAVuyRCwCcxZKfRLV5jPG6W6tKjGivKMG8Cv/4aImT6zD5Fke8CpzDyc3HHxUHR8l0Z5hIDAf93UfwndJ5h5/Es1NYOfsNlA3TVisbJUjfpCgooz8jZAv2T27VaLPFmt+0EKFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IBlWi7C6sJUpxOHijKTuYe9DNJ5Hu+y/8z0Pz0DTl4=;
 b=sRwgN6t8jeCMK4ZkhqX/Jy4JXWOrN0ozQRgg+6vgHd00MIaP/7AE5pWjQvol/PzKX7s4TSsyA3plxf0HN/JcjC7gvGm50Ft3lgqLOsJ3SrXNZE8TkeJPTYKAl6FFQMmg2F5xX4098bsCwR26Ef2rieas6kofGBbD9WLF/ZvH6pU=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BN6PR12MB1603.namprd12.prod.outlook.com (2603:10b6:405:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 05:28:08 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%6]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 05:28:08 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all
 ras blocks' .ras_late_init
Thread-Topic: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all
 ras blocks' .ras_late_init
Thread-Index: AQHYIj+P/wvh4I5KH0yq0qwRe0t9JKyVf/GAgAAmciA=
Date: Wed, 16 Feb 2022 05:28:08 +0000
Message-ID: <CH2PR12MB42159E46D1154782EF467330FC359@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
 <20220215074124.3411761-6-YiPeng.Chai@amd.com>
 <DM5PR12MB17705C6357570B0A9BF02CDFB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17705C6357570B0A9BF02CDFB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T03:06:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bf542317-7c25-4877-9a5f-90cefca22e19;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-16T05:28:04Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 742e2f34-e8c6-4799-a734-62b8658d450b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191289e7-2521-40c3-8def-08d9f10d1d85
x-ms-traffictypediagnostic: BN6PR12MB1603:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1603529D31D179D66300CDA0FC359@BN6PR12MB1603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quDV/oRyk9hxXVPmZ5lCYCazt69frVyeqok4av75cgDvAAHw1MGoGGcjjlwZSWdZLSDL+XM1lhpNsEebOwzz3rU9D7sK4ws6jLWgaiZblKvVE4EV7uxseiJClJhQsbNRWRvnZBEOPOqQvguscABJCx4F5v6BqbYpcgSm+pZkBaIiEh88nbaN5P5mfLFcri4hXuC5AJHiV5v8nuoL7bPIrMvvnHtwlDK0FfRuSMX13yi+ilfGFLKAa1wzzyM26G1Fi3OiXirPE/kH3EQRqlpCqw3E2Q4CCEwWf2EkKgNHtGkYGu6M7Gg9muXCN7602rDauwEauW+nQGdGnYty6mH/FHBrjXfRbATvXkthm2AqdrtRgnAVsrQvnUkOpf8AHjxuDB1rP31QvAmRsvr4wjcl+RKboVCQoOIUeSo0rh3VU1yeiynXDONBjbtPqOU/1Wvuw1wnnvWmSxj6k3Hfp5wvZY7Y8PsCx/e5NR1NmF3sdhp4AIzOoeLjd8IM2QPKTH/NAbTNSJMfgS+U+TB75+7wEm5hrt6MzQUrj8bpClJ0ZI+x/8Du9dgudg6PAuEKUNUSGNZ3ILpiX0zv5RO3ClsWtzovlF6ybm0YDIc5hT/uHiASjixNHBcZyw1OnOc2ByYTIERel/W7vStgZ/m9/Sj6UiAMBDJpA0CwzU0Hh4FdIjD/mtcgJOC907N61v6vL8x/2UmWJWUbrLLJHyAbNlPm7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(55016003)(316002)(66946007)(64756008)(186003)(122000001)(76116006)(66446008)(5660300002)(83380400001)(8676002)(4326008)(52536014)(9686003)(110136005)(38070700005)(8936002)(38100700002)(86362001)(54906003)(53546011)(33656002)(6506007)(2906002)(508600001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uIEYEPpAJNJ9z4Fv5E5crJ4x5WaI3DUqvAtlny02pgPa3xqGu/AytWOY/ldY?=
 =?us-ascii?Q?NAyw4wEjyO/0ciZAz4eX4CZSfvUZXfIfFUAx290jbpWAnohTIC48r6+f3TlM?=
 =?us-ascii?Q?zNwCwAlRg55BDze4gm6XV1eg4nhEuangaqr77D5t6sjJIdJAcziHYujw6GLv?=
 =?us-ascii?Q?SlwYaGpmr81wFWakKGdkRJlPXoJAXkwrZDr2HxVK8wPADQeq79l7mUYRH3ap?=
 =?us-ascii?Q?xtW5F94VdsK1ZUZP74U8MBwcF7Ob0bGgJQ8BJwGQdwSzoJBjx4U+SSpQQn2T?=
 =?us-ascii?Q?E/KtbzbbLbAaEUqbyOV0VaA2HBtNoBsIPi15MVYuXbm6QBjie+YVU3XSDga2?=
 =?us-ascii?Q?2WLbc59P56gLiAI8dMuIzNeDVv7uHXl/fRW7O8MvFP+vi+HJQMHIdkSy7yHn?=
 =?us-ascii?Q?uSC/rHuqDx7XfbziYj3Z1g3kOP+43voPj8W+xMShwve0nR5HQC/02WJV/U7Y?=
 =?us-ascii?Q?h9yxxVu+LMgxVYYAFllfdUJ5PQsq0APK10f0Doc7JglPoBTSO0agkGo0Dtqm?=
 =?us-ascii?Q?zoHS44W/rku3Bk8KOrpemgHlTJF1jJJxMP7K5nyQlVGOW/MBPfmO7CbmZlZL?=
 =?us-ascii?Q?f51q3llddN9F38+7pH02bBahHlcisvaxbryTYDNRF8ahORtrZlDkS7X7PGKN?=
 =?us-ascii?Q?da67gn9ddmJc372w7dQj+qltXsqve/17sD7v+lnRDy7BAAjYSg7T0B5UyBLk?=
 =?us-ascii?Q?ykmQS9n/KNh3NAe6JTyfTXFjMQ7jgrBU9qmW9e+dzmg/9g8aLAcqLvjpTs+a?=
 =?us-ascii?Q?uvNFq1AJvCRKt6YuKAXMCUwXYWBFx7m4XDSUsUfiTJzzmiPqMDTzyq704XQX?=
 =?us-ascii?Q?Sl9mMhAN/zIzDD9uCOG7Wgc0xzQ4gE9OQ5eZjDFn92/HbwRyFDDYEbVLU2ZQ?=
 =?us-ascii?Q?HSvYmj0YL/4vO/p9PjdDwqy/6rhUlsYvXTlmDJnLODZXAuAdegC9MFW5eifH?=
 =?us-ascii?Q?7sYrbv6A3nkK8cUOhQUo5zoPVwgLHqidNgPQqBUs4rrPcjn0ubG84yafiQ/f?=
 =?us-ascii?Q?+J3X8Eth0GhEzQuIy74pzwN7B4QyKGdmJklFR0GH25WM2TyssMFitHutWilB?=
 =?us-ascii?Q?5g/2Ym7s7IbpAzG6YGUyASOGUYm8OyN9rmoCDKmNuIkc5BGW35bMqnzpfIv3?=
 =?us-ascii?Q?AqVukNi2s2voIkdZcx9NOaSN/kseggAqvUaxTx6TtVxgz8rYQiS9N2/SZt5c?=
 =?us-ascii?Q?t5kzhWFf1694XpkbIEkz48Acg9fc53X2CwmKWm6Ip+ORC7jlxEXFDLjLS4BF?=
 =?us-ascii?Q?2pHY36evxpQTkmzpk2Rr63WuUtDHv6a2fwME5+Iwa8/f76vUH+hNQ++fUzKe?=
 =?us-ascii?Q?LmG5ltmZQFOiHdPD5nDA0CUYnsZH/DiOqy2aNjKs3DHEXWdfxyQftyEqVI7j?=
 =?us-ascii?Q?4Mcp9sriVU1/SneFgOufWc/xNjaVmTq+ZyV+4Dnqt4DZjks0yC21mUrxiMEQ?=
 =?us-ascii?Q?16NW0q8fXHaAEdwymzxdO7rdJJRiCmHtqe+zOBladvk7Q2LQFPNuN1s/thX1?=
 =?us-ascii?Q?H9YvGQDuC1wHKtCSCyCiLKX19fvdKxHlYV8R2l2PpR3pvC1VnYFYFNoVbjUG?=
 =?us-ascii?Q?bFtPKHnHZGZFh7IEa6/3FskucGT06iLajnT6EOKbJs3nGcOyKuh6zSWzWiBy?=
 =?us-ascii?Q?EPphDnK/4/7UvB50kjuINiTvpbzmFPa2zBNQ5tHAvdtZBfi4FN6yAgwMCX8h?=
 =?us-ascii?Q?BXXjY5QBxRswakMVFu3qSBVMQ00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191289e7-2521-40c3-8def-08d9f10d1d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 05:28:08.1171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+d8iFIWpx3SzSITsO8nT8ipF9JSlwU+CKxhLY5TU5tOso+42gPZriw5TftZU9sm1ud5z+FHrcM6ZUYLjiQ1pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1603
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



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, February 16, 2022 11:07 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call al=
l ras blocks' .ras_late_init

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, February 15, 2022 3:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call=20
> all ras blocks' .ras_late_init
>=20
> Define amdgpu_ras_late_init to call all ras blocks' .ras_late_init.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 44 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 18 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 +--
>  7 files changed, 23 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a74a1b74a172..67ea23dbc618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2625,6 +2625,8 @@ static int amdgpu_device_ip_late_init(struct=20
> amdgpu_device *adev)
>  		adev->ip_blocks[i].status.late_initialized =3D true;
>  	}
>=20
> +	amdgpu_ras_late_init(adev);
>[Tao]: do we need to pass return value here?

[Thomas] According to the previous code,  it needs to judge the return valu=
e.  I will add it.

> +
>  	amdgpu_ras_set_error_query_ready(adev, true);
>=20
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE); diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ebf4194b0699..49dd81c0db2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -449,50 +449,6 @@ int amdgpu_gmc_ras_early_init(struct=20
> amdgpu_device
> *adev)
>=20
>  int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)  {
> -	int r;
> -
> -	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
> -		r =3D adev->umc.ras->ras_block.ras_late_init(adev, adev-
> >umc.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
> -		r =3D adev->mmhub.ras->ras_block.ras_late_init(adev, adev-
> >mmhub.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, adev-
> >gmc.xgmi.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
> -		r =3D adev->hdp.ras->ras_block.ras_late_init(adev, adev-
> >hdp.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->mca.mp0.ras->ras_block.ras_late_init(adev, adev-
> >mca.mp0.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->mca.mp1.ras->ras_block.ras_late_init(adev, adev-
> >mca.mp1.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mpio.ras && adev->mca.mpio.ras-
> >ras_block.ras_late_init) {
> -		r =3D adev->mca.mpio.ras->ras_block.ras_late_init(adev, adev-
> >mca.mpio.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1aff88fcea76..6cb1e5d126d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2522,6 +2522,24 @@ void amdgpu_ras_suspend(struct amdgpu_device
> *adev)
>  		amdgpu_ras_disable_all_features(adev, 1);  }
>=20
> +int amdgpu_ras_late_init(struct amdgpu_device *adev) {
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
> +
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n");
> +			continue;
> +		}
> +		obj =3D node->ras_obj;
> +		if (obj->ras_late_init)
> +			obj->ras_late_init(adev, &obj->ras_comm);
>[Tao]: check return value?
=20
[Thomas] OK, add checking return value.

> +	}
> +
> +	return 0;
> +}
> +
>  /* do some fini work before IP fini as dependence */  int=20
> amdgpu_ras_pre_fini(struct amdgpu_device *adev)  { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 837d1b79a9cb..143a83043d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type=20
> error) {
>=20
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);
> +int amdgpu_ras_late_init(struct amdgpu_device *adev);
>  int amdgpu_ras_fini(struct amdgpu_device *adev);  int=20
> amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index bb40ab83fc22..1997f129db9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4791,12 +4791,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
> -		r =3D adev->gfx.ras->ras_block.ras_late_init(adev, adev-
> >gfx.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
>  	if (adev->gfx.ras &&
>  	    adev->gfx.ras->enable_watchdog_timer)
>  		adev->gfx.ras->enable_watchdog_timer(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index af5a1c93861b..e26c39fcd336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1894,10 +1894,7 @@ static int sdma_v4_0_late_init(void *handle)
>  			adev->sdma.ras->ras_block.hw_ops-
> >reset_ras_error_count(adev);
>  	}
>=20
> -	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
> -		return adev->sdma.ras->ras_block.ras_late_init(adev, adev-
> >sdma.ras_if);
> -	else
> -		return 0;
> +	return 0;
>  }
>=20
>  static int sdma_v4_0_sw_init(void *handle) diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 464d635a0487..ba983398c9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1186,15 +1186,11 @@ static int soc15_common_early_init(void=20
> *handle) static int soc15_common_late_init(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -	int r =3D 0;
>=20
>  	if (amdgpu_sriov_vf(adev))
>  		xgpu_ai_mailbox_get_irq(adev);
>=20
> -	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
> -		r =3D adev->nbio.ras->ras_block.ras_late_init(adev, adev-
> >nbio.ras_if);
> -
> -	return r;
> +	return 0;
>  }
>=20
>  static int soc15_common_sw_init(void *handle)
> --
> 2.25.1
