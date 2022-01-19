Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0247C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 10:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0530710ED8A;
	Wed, 19 Jan 2022 10:08:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B2A10ED8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 10:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgliD+3joUaTpRdJnz/roO4tuQB3odX2430spCJYogCT35WUGY7/JEyjLSJqd/yOFInSinihqU73IqQzog6yjaAuzUkY8oJDKfWK+Xjz8AEWcmwvThOzkpT9xs43Fql/AtVNgWd/OsPIEk7LKXFx0qEQ8pUPJwZDc8Ypbz8Qb498oUTGMKcUAUTu4Pz31E04hwVrwMqH0sMiuvERJp+qZRqJxaa53NnPSd9YC2Xo3/1R2DY5X1TvTaHOEcO5XDM+whOXDR8YT/hlN8emniuad2wojVVzCoRU19Ij/BNvH5YxKcxtJD7do2R9M0s82IYXFN/Je3MLtz3C1rCB+c+qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWI8e7u11MQgZQtXcbhyMFfPn+sAqAsTywSJ1EbVCmU=;
 b=DQx4A8prFvCSB5bzMnInSfMgg4oUvlG/zhcHaTfHQX9XWUPt3Pp1spe7aUYB7kye8P9PL7XwO2eiaL0d4Q93LXfPoPd4TNl4jj687B9BGrHmzjYtvj+/ZlHggPOSeurJQa+UBsLJXjIC1lDMFnuxDdRlxaAB+LK/PCbXtm34lyXDj+9SBNqKfzLc38xOnMEB+MqQgAu/NvsoGGWF+JIFitqCSSEfFqHkfAojvS6w42pKa2wwsdi3bR0yoSfj6m+vniUGS+DPowkb5fPTicKN4hHjOSBhff1BGG7LNjnPcYxURG8KayhF9XMERZQqGfa4z7A6AmYYcl8wRDgyrkx/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWI8e7u11MQgZQtXcbhyMFfPn+sAqAsTywSJ1EbVCmU=;
 b=G+hW+MW6dy/o6MnL/HLe07MtWTKzg1GuSB77rGyWGPDwlXzZjEbFpUSSuAs638LVAvaGhcy2c7M49usHmMDIbHyaWOX8CIGjqfV0aQNYvSj8YIUOm1r1dO/C9KwmVN/ColLBy+tRgCuN6g1YoFqoeUBY1jwe1k2nFoV+nMxIqHI=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 10:08:29 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.014; Wed, 19 Jan
 2022 10:08:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to early_init
Thread-Topic: [PATCH 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to early_init
Thread-Index: AQHYDRZ2xudJsPc16kqOCrRiSuRh96xqHLTQ
Date: Wed, 19 Jan 2022 10:08:29 +0000
Message-ID: <DM5PR12MB1770F6100C6BAE2FF40DCA9FB0599@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220119092435.287721-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220119092435.287721-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T10:08:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7029f28b-bd1c-4ddb-b838-71b1e939f5a0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-19T10:08:26Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7eadbdf6-b623-47a2-a4a3-a5f5185f74e3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd94d697-7e21-472d-206b-08d9db33a441
x-ms-traffictypediagnostic: DM6PR12MB2620:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2620410BE0E24B0D8ECF88A5B0599@DM6PR12MB2620.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlzqLWDd/lqUnvVulugZptKznFQZzEaYdTW1vvECtf+xHMrblR0Y9UZlJPfTSELlz1sERz/2ANvLYHnaDYz3zdvThGHoQUE5kFnjYlOhDqFLI4LBxHY1xheM6nZYVU+JevusWc5Sm/jt5xz+nuoKdPR/cx4+3uc9spXRZP3NGdwUgHTAvk9cIFCndiedvAW7tyl3tLZXmgQpOhcYuYhxo+muyMYAELaUuGwiuqWxKuaZtsBD6WPwC4dfGmdCZPoOQydXgr8ADuSpKiXJWIPw04dWzzPzkxl+nXK5oSFV3jdxa1HiMMsenfTBRQ/rvUNwzunHXVSfuxyvBWpYNYqjTViErc6DiPV5OO4x6zU3VmhYtwPGKBfLDwDNt10GPTLLRlpLyD2++gEy9aOiSdBj657Vzj7ejwkZs5RpnIWFitbJPhUYsc7/rff9kxhbRVaiorDuCDVqwlRf4KlcRU7WaEwbTm+jvmzgO8mIeWt4Fdq/VlDHIrEdiJ+OydEYizUZj8bkSpIgBJH/9TVucTe7/5xkBJq1CWcw4LfgFUTDw6xN+YlxRu79+sotohcg0rCeu8+wWGkrsrHKB3cb8I1Mnl0+NiIqBOWubW/HHpqrlUesK0KLz/JCYSkeTVkZ49dgHlunmraIoYm2hVDVWuUqdinclvZkCRqhvASOK+0ujyx9T9m19xOcTjkLaaCSS+9qcPzpx4LiI+ZNPl8AG5wl5guZ/b4f+ZBGR5WV7M0BUYg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(122000001)(8676002)(38100700002)(52536014)(55016003)(26005)(66946007)(66556008)(86362001)(64756008)(66446008)(7696005)(83380400001)(66476007)(53546011)(33656002)(5660300002)(508600001)(71200400001)(54906003)(110136005)(4326008)(316002)(186003)(9686003)(8936002)(38070700005)(6506007)(2906002)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?03bCV3ipgutzK3xm2kOlEZ7JV8zSdUqStAI4RTj9PG2sWb5aV+5zczNET27a?=
 =?us-ascii?Q?2t7IjN/buYnARS/ienmGhgvYBQ9BkXJ2XSVR+Yc4TFvh0b/yiWhX6RS+3SzN?=
 =?us-ascii?Q?EaUygQer40hO1cghmsX4Wi+t7VRD3tTK6pyKzJZs8cyUXztX+Wd7RBzxm0KG?=
 =?us-ascii?Q?jpWflGjyxc+gmr+GIyV4Fj4IhBcqUeytF6OPKAN1c/eUZVD8hDdYRQ8DRjeQ?=
 =?us-ascii?Q?WhU8ZVRRf27Ox46ECt2W5CXjfVrI7pSv33zRuyCqZw1ajlHsX0/3jr6SeEtb?=
 =?us-ascii?Q?4lwMmIyvblsquzUi7fW9ZpQ4fMZUEwqFkYees6qpDQQLfibBV9H0Uw9ev8kv?=
 =?us-ascii?Q?e0+6gCXKj3tJVH2AM/qrYPJpAJ9srSxVqIfPXa09+7F1IL/lw9CMKO2AJIJC?=
 =?us-ascii?Q?JBGS+9id8XBSsEJHbfhJifOZa2fNv5lkDS8dC5EXZA6gzkQb9Gx3vbRpdIE7?=
 =?us-ascii?Q?G++XIxm3d86LCTSBBwZlKVqe8Ob0qyfD4uCanSUtSDZ3qMN7eSSU2LT5/VXd?=
 =?us-ascii?Q?5PM0EQ4y1QifET2lXKf48YYoM7cNPrBBg3dw6DRwRGBOIgJQlZuttPVk+tKX?=
 =?us-ascii?Q?3Z4tEjym+xovWWEL+hV17Jf14n8OSVJ7GqhpjpmKBuEwgoRBCEfRiy50lUmR?=
 =?us-ascii?Q?BMWJGdSXZDvIGyXtM6H/W7x8rSpTmnnXK3w+cDX4lDi473MLTmzJlQ/4P1Ve?=
 =?us-ascii?Q?lxZ+NTe7XUsmv15AUjeqlqe49MMxusCcLyZou74zz1IigqQItf0CwfMYQOZP?=
 =?us-ascii?Q?nq6S1TzAfW4OioOhvtZGYBJz6CpbAnApWjz28YXuo+13hAohgYgGWKH0L84v?=
 =?us-ascii?Q?F+wdtHxLbEZNmIIdBlHAAa95dsczmyLUwJSv5hs1WfZtMcMQTSl9qTTZ6t2C?=
 =?us-ascii?Q?xC0Rc6+W5HL/TZlYykusAyy8qVK8rOOMF866RHGTs+d0/hv4va/3376u3Z9c?=
 =?us-ascii?Q?dBleJmpcqA5n8S86bHcoW3tGYTzFNuBF3YvyknFDJDFKJd3J3B1ISwmH6ebw?=
 =?us-ascii?Q?wF2/EdzBfeXZBFoLnaPS52ocZbbvzIx3QQjS2CtnUK4knDlbr70S2eoZFohE?=
 =?us-ascii?Q?TuV/s2WclRiOSHyjOIHtme+s9kvDjHoEc14dALPepNNWgvm++R5/9aq9QKdc?=
 =?us-ascii?Q?VQUAnda/1+l+rGwOnTT6n7vx5c1QZGyeZZ0FZcRtLF9I3IIRHT634m0WkuxX?=
 =?us-ascii?Q?66i8AZQGGwmjgBqZNq9Ke4Ulyh/Ih20YbRxCDAz/Od5JjpECz634SW5qSAlV?=
 =?us-ascii?Q?7doe34RtCIncBMMh3sOmjoq1md72AxbnrnCbDEFMs6l1U8B7yPY0StTjeEiV?=
 =?us-ascii?Q?HgucIRO7yiDIK8XabnuKvxCUIOkOkDQcuOvyBqH0A2TeeKwO3sS8JeNGnVH3?=
 =?us-ascii?Q?lDftk2p6HMihAwPN709zMrai9FG38+rY10Gm0bfIkLnn6I4OAVfW7TgLCvxt?=
 =?us-ascii?Q?yjRPsZtynXJojLBOuNtyIF61Qpvs/SQKg1gon+J+5nZKENL5iPxzexX/C9Tu?=
 =?us-ascii?Q?DVEUps4lSgsJZYUTFVRuST9SNaXGEiuPt1+g3LQZBorWlcPe0oW+QdkcgOKr?=
 =?us-ascii?Q?bdOhYef7lr0NlQ3ET00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd94d697-7e21-472d-206b-08d9db33a441
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 10:08:29.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIn4D4ZA2mQcyFAZyJ27cunpEj0298rE3fmCsYo2TBLADRu40t29I0jgMuJF1Q83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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
> Sent: Wednesday, January 19, 2022 5:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Move xgmi ras initialization from .late_=
init
> to early_init
>=20
> Move xgmi ras initialization from .late_init to early_init, which let xgm=
i ras can
> be initialized only once.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  3 +++
>  4 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 22f50aadf694..ece6397f81de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2189,6 +2189,8 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>  		}
>  	}
>=20
> +	amdgpu_ras_early_init(adev);
> +
>  	adev->cg_flags &=3D amdgpu_cg_mask;
>  	adev->pg_flags &=3D amdgpu_pg_mask;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3483a82f5734..d83eee1984c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)
>  			return r;
>  	}
>=20
> -	if (!adev->gmc.xgmi.connected_to_cpu) {
> -		adev->gmc.xgmi.ras =3D &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> -	}
> -
>  	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init)
> {
>  		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
>  		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7a1d2bac698e..2b71611be388 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2238,6 +2238,16 @@ static void amdgpu_ras_counte_dw(struct
> work_struct *work)
>  	pm_runtime_put_autosuspend(dev->dev);
>  }
>=20
> +int amdgpu_ras_early_init(struct amdgpu_device *adev) {
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.ras =3D &xgmi_ras;
> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> +	}
> +
> +	return 0;
> +}
[Tao]: I suggest creating amdgpu_gmc_ras_late_init in amdgpu_gmc.c and call=
 it in each gmc_vx.c.
Please make sure gpu reset and S3 tests pass.

> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a51a281bd91a..7d99e3736ab9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -600,6 +600,9 @@ amdgpu_ras_error_to_ta(enum
> amdgpu_ras_error_type error) {
>  	}
>  }
>=20
> +/* called in ip_early_init */
> +int amdgpu_ras_early_init(struct amdgpu_device *adev);
> +
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);  int amdgpu_ras_fini(st=
ruct
> amdgpu_device *adev);
> --
> 2.25.1
