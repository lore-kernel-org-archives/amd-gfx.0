Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF114C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553BB7A36B;
	Mon,  6 Dec 2021 10:21:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E159772DCD
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 07:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOiBYtqKYbTYfo0jU0X5qmRqemTkYDS0/tIH8bNul5Z+qayfPYlHcTkZmH6sS3E2cJ9Emnilf2T4s3wU209fABhLdjgrGlopa/sZqHTHWnJtoGmMwsCFb3t9I1lzlQjAw5qa6ONVIUzxoTgmktn77wxpz1MKw0LoaqZR0UdIXwqueMA9Y8rr7RZKHTvMmPfTWBXxAfdShUmfXz7puxUpcRH8BFQf4tHjBJ5q5qXi0weKLpsLgtECUMBcSeNRKw5fbowuIf6O2AVoIwojj/ObVqz0bQAYZPUTWWLbqGZwZV7G8Yn53HZbdgyWXStQUQE+3oWnaahoyXphM7RfC6Kiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N44W6zbs+KfKwdVzAXyiHM35wgOWgNtAYfiq2ebMY8Q=;
 b=mtI/jb5BlB3wPd4a5jGOEIdduMP3+9N2rpe+7sMD3qwI4gDRwof/03dpOU0OQsjuvQBwg949Ac0oWcyOHE1rKJh70e3nRAPL1oM+E0LdHa8ukbfLop0SrWcrADyGKHZDi84vhxqKw1tek/YPkN0eL4sXs4EnB5DIkto9Wwh5tSYhcRt8S9+STh+8pO5Cm0qoqLd9dR0gtud/Br9oWCqRAeqH+cbV3CVzb+UjPZIez4Aj1vgLcEGhZ9n/XKyUceWukDKloUNsUVRHRJZeMwEWSZcMh5N+LcgAzPgLhojfifXGySAqLUxVr+Ojkw72B3lGiYEA7kZYrPqft3V3hgL72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N44W6zbs+KfKwdVzAXyiHM35wgOWgNtAYfiq2ebMY8Q=;
 b=NoME5AdQEdjnGH83Pk6IkNJ9HVVsIUwwY5ZPd720sH1ka6RDT7hmyBbhzPScbsrUzZxvgsRYivJkBSkyPrQuX3yaKe/kH/SJCUVqeW0GHfiPLLtTVDxyZkYWmzzhWqxsRUpWTrxfcUXOHc6zsDUKADnSZjIdShJZd/s1z+v82lM=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 06:58:00 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:58:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Topic: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Index: AQHX5qGzwQrRwGnuTUmemrwDRbB3tKwlAK5g
Date: Mon, 6 Dec 2021 06:58:00 +0000
Message-ID: <DM6PR12MB46507136C714550B974B682EB06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-3-YiPeng.Chai@amd.com>
In-Reply-To: <20211201105250.298525-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:03:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f91674a0-640b-4147-8237-7e6e1c20c707;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-06T06:57:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: cfd7dfb0-a27d-4785-ae11-42efb9447039
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94be4053-0273-4881-c500-08d9b885bdca
x-ms-traffictypediagnostic: DM6PR12MB2684:EE_
x-microsoft-antispam-prvs: <DM6PR12MB26840D30AB7BA26D4EE47B55B06D9@DM6PR12MB2684.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZO0q7FDtF9pnCDJnrZHJuZlvwBrqRe8C1tpgIFOHsDigH7ZKrHLyWJOEFWVxjKJBOZL7k/jiRfVpCCbcCUpxiyRRGcK2gr0Bq5pvZG/GGmRzqs4l7+HChBPtThbNbSJfkq6ymnUieRTendsh8Q+M2JbLCHLCWZd2HW6wdcO34Q1WbYGN1RaJ0CF0EDSwIkcnUNYDHq1k6Mvkt01VmB/IaX2+VYcS+7Joum2+ub2S2JPGIvJ7/v9gaBtKE/yWTzfuujp78e+cbR9EX21moZwRD31wIXeEt7p4FepQboXBMXktZ2xcH3z3wEnQXRebyEzrtfXyA30ehGotyO12DY2xie05a1WENchRS5v+i642avKuuA8FaxAJu6TK7u8FXKg9UpmltPzi+R3/IdOal3AgWW+FeMLUVoHpGTMpkD2VDLplR+yRUrBNtBIDJLo1Birx+PvVUBG1APXP+ZSNHeYcB3ItAlfvaXHWq3U49XnzI7Q/Lx1/mQ8lbfRke2tIM/UE7a4fBtpZIas/U/RDy/xkaRdwioTyAawurFpGjpobgo+i//ok8Xhm3mou6ObYH0bvt2yOLJOggjz4R99G2A8cv0CbrWuNST1a+UGWPKB/me53knrXtbKl/9VBp35gXkkWVMCQ9AM2D82XDKXjL1R3xDr85Zxg2JHVvUypEm51Xf9ccGa1odnCf9r9QuI6+MPh2+FEdqdNxrdK66+e0tfqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(316002)(33656002)(66946007)(76116006)(66556008)(64756008)(66446008)(7696005)(66476007)(38070700005)(8936002)(55016003)(86362001)(30864003)(26005)(38100700002)(186003)(83380400001)(6506007)(2906002)(53546011)(71200400001)(52536014)(508600001)(110136005)(8676002)(9686003)(4326008)(122000001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ok030fEGKaYgMNboxXVTqQRwBN2QUuA9ArctiUeUWzC5kL7k/fkg53zI6HUO?=
 =?us-ascii?Q?uAkDBB/rfATXDHh/t9NeXTc+ywwt4+PbphbYhwsPUw0oTI1ydO2qgJePw6Tg?=
 =?us-ascii?Q?2YnqpSJfxDRZwvdPlbxqa3ib/ZlJywjXIzHBywJ4pK31G6ZDB8pEv924sDei?=
 =?us-ascii?Q?d5Inob15inoYbH2mHoJOgHfGiGgFCl1thYhvyIupdxt1VMNc9gHAaI3MkXmB?=
 =?us-ascii?Q?1uBD0s5Vo22d1pGoF4nWArL2LCQQnXs61wsB8MVsGxcZoCjq/+c4eyhNL3y3?=
 =?us-ascii?Q?S6RR2M2exB5WSCzOPXMVj1XbBKivf5KUw6xUivYqLsxca++zQOqyii71Db1C?=
 =?us-ascii?Q?wg0zl656PUCBdMcW6lKq6/8qBznH+r/K+Sd7Hsl42dGP3/NuvolYnumfnvY2?=
 =?us-ascii?Q?CKc4rYIM+kmwhbRU58Gzn/xnYs6zOfZP40hPLW6q9SdJD1oML5MBm26WHL7o?=
 =?us-ascii?Q?bV6asrKSS84hk7SYGDluKkdxQtJKqYvHA080RiNXgzLhQtSm1tKZkpiRtBXf?=
 =?us-ascii?Q?CrkTpjVlsaF5k44zdClWfk/ieNy7rub7/Bky2B0cac0Gw2hqp/qURgiJsAKd?=
 =?us-ascii?Q?ETLrRKz8eHYgSnDYePweDJyqBVUyvq9rOCXhaJmcql6CaJ/8BCEabljd+LR7?=
 =?us-ascii?Q?O8Wv3zLvYUUTV5a23Yk6qYoh/NcOiEcsqvlEiHgq/YKBo2/1CHliMMHZFWiK?=
 =?us-ascii?Q?0vi4Clr5yKMttHQY6KL9iEt6TC3ki6NvzP052F/ywg5tx/nEIP1Q8ymJCsrS?=
 =?us-ascii?Q?v3USNKqJcXwaeonar8S4N6KIGtFshb8ubFkcU/z9onpXyc5fjf4c5juhWJFC?=
 =?us-ascii?Q?LR3uY2eVvapuoVK5FVnYajeSjMawq9K4ud/lr7Iob5el1UQbNG53Tg/LwtM9?=
 =?us-ascii?Q?UYKsGf+6gxHXQpBKD+awxW9xeR/AYIe+WVldNZVrlGoojxF+0XsNMLTOXfjD?=
 =?us-ascii?Q?dwVw/e1A35YQu8cMXY7wAqAYyVlnLuCkMX6xT/nKEhWLQBSTKM6m/La6QHv3?=
 =?us-ascii?Q?DCKzDMvQO/ZkkuM5RU9SJVsuD0HdUQOeueEClnD18kI5Qsi3zP6ITjd+f9AW?=
 =?us-ascii?Q?i2rXUzxOTxbvG5KiqhuDZWK8kpfPwUVjA1yjXjN7vgz0U70yoMDRs5BtY2Hz?=
 =?us-ascii?Q?A+3GLC/O2oupKoW4Ok2W7ZlYZDXHQ3iZaaI1S1/jaFLL8tKUZFmRll/N2CAp?=
 =?us-ascii?Q?fys3WT2loJkMuY2mkigRzQBwvhlBJfUA59Dt8v6J8rwC70PqAYevPJr+V+4v?=
 =?us-ascii?Q?Xd3Btnm5BARVj0gOZi+U5kFef8GKiaV1oOKpX4mfZYDUZ0RsQTI8JlzR1p1+?=
 =?us-ascii?Q?bvqmARnnVH0PSMxHF6BgagUzsSxj0OrEOVXYAgjMJHBqOVJsd6cAh/ZhRCVA?=
 =?us-ascii?Q?MoXKjWYCS41yrFrzPoYfn0hOR8hJO0+8VLJj8A6PRbTucDtYu476cuL5GTOc?=
 =?us-ascii?Q?bzrLZAfKLvm/czGyGhD0rJQx7EY1EVyr59eh5A053LlwurM0ydB3woGHE2nq?=
 =?us-ascii?Q?GtkjJHsXhAOm7ZVEWHUsMvh529VM6JoZOwvrGaO3tOBxs7bKRvQWhpf8G4tv?=
 =?us-ascii?Q?AQRvU5si3W21vYs1at4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94be4053-0273-4881-c500-08d9b885bdca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:58:00.2530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHx8hTgU4ku17cl73K4iMbOAFelCi6jvT6kUdwnAlv7+QwVw4XXcNAmyir0daw70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please see my comments inline.

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the uni=
fied
> ras block data and ops
>=20
> 1.Modify gfx block to fit for the unified ras block data and ops
> 2.Implement .ras_block_match function pointer for gfx block to identify i=
tself.
> 3.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the corresponding
> variable name remove _funcs suffix.
> 4.Remove the const flag of gfx ras variable so that gfx ras block can be =
able to
> be insertted into amdgpu device ras block link list.
> 5.Invoke amdgpu_ras_register_ras_block function to register gfx ras block=
 into
> amdgpu device ras block link list.
> 6.Remove the redundant code about gfx in amdgpu_ras.c after using the uni=
fied
> ras block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  6 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 15 ++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 80 ++++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 73 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 39 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 42 +++++++++----
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
>  8 files changed, 178 insertions(+), 81 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1795d448c700..da8691259ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct
> amdgpu_device *adev,
>  	 */
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
>  		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_count)
> -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> err_data);
> +		if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +		    adev->gfx.ras->ras_block.ops->query_ras_error_count)
> +			adev->gfx.ras->ras_block.ops-
> >query_ras_error_count(adev, err_data);
>  		amdgpu_ras_reset_gpu(adev);
>  	}
>  	return AMDGPU_RAS_SUCCESS;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6b78b4a0e182..ff4a8428a84b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ring.h"
>  #include "amdgpu_rlc.h"
>  #include "soc15.h"
> +#include "amdgpu_ras.h"
>=20
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -213,16 +214,8 @@ struct amdgpu_cu_info {
>  	uint32_t bitmap[4][4];
>  };
>=20
> -struct amdgpu_gfx_ras_funcs {
> -	int (*ras_late_init)(struct amdgpu_device *adev);
> -	void (*ras_fini)(struct amdgpu_device *adev);
> -	int (*ras_error_inject)(struct amdgpu_device *adev,
> -				void *inject_if);
> -	int (*query_ras_error_count)(struct amdgpu_device *adev,
> -				     void *ras_error_status);
> -	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> -	void (*query_ras_error_status)(struct amdgpu_device *adev);
> -	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> +struct amdgpu_gfx_ras {
> +	struct amdgpu_ras_block_object  ras_block;
>  	void (*enable_watchdog_timer)(struct amdgpu_device *adev);  };

[Tao] Can we add " enable_watchdog_timer" function into amdgpu_ras_block_op=
s structure?
And I think using ras_block directly is more simple than amdgpu_gfx_ras gfx=
_v9_0_ras structure.

>=20
> @@ -348,7 +341,7 @@ struct amdgpu_gfx {
>=20
>  	/*ras */
>  	struct ras_common_if			*ras_if;
> -	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
> +	struct amdgpu_gfx_ras	*ras;
>  };
>=20
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs-
> >get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1cf1f6331db1..190a4a4e9d7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -862,6 +862,27 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  }
>  /* feature ctl end */
>=20
> +static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct
> amdgpu_device *adev,
> +					enum amdgpu_ras_block block,
> uint32_t sub_block_index) {
> +	struct amdgpu_ras_block_object *obj, *tmp;
> +
> +	if (block >=3D AMDGPU_RAS_BLOCK__LAST) {
> +		return NULL;
> +	}
[Tao] The "{}" can be dropped since only one line under the if.

> +
> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if( !obj->ops || !obj->ops->ras_block_match) {
[Tao]  Need a space after "if" and the space before "!obj" can be removed.=
=20

> +			dev_info(adev->dev, "%s don't config ops or
> ras_block_match\n", obj->name);
> +			continue;
> +		}
> +		if (!obj->ops->ras_block_match(obj, block, sub_block_index)) {
> +			return obj;
> +		}
[Tao] The "{}" can be removed.

> +	}
> +
> +	return NULL;
> +}
[Tao] This is a generic ras function, not gfx specific, the code can be mov=
ed to patch #1.

>=20
>  void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
>  				       struct ras_common_if *ras_block, @@ -
> 892,6 +913,7 @@ void amdgpu_ras_mca_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  				  struct ras_query_if *info)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D NULL;
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
>  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>  	int i;
> @@ -899,6 +921,8 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  	if (!obj)
>  		return -EINVAL;
>=20
> +	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
> +
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__UMC:
>  		if (adev->umc.ras_funcs &&
> @@ -919,13 +943,17 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  		}
>  		break;
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_count)
> -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> &err_data);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> +				get_ras_block_str(&info->head));
> +			return -EINVAL;
> +		}
[Tao] Can we put the check behind "block_obj =3D amdgpu_ras_get_ras_block"?=
 The same suggestion to all similar code.

> +
> +		if (block_obj->ops->query_ras_error_count)
> +			block_obj->ops->query_ras_error_count(adev,
> &err_data);
>=20
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_status)
> -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> +		if (block_obj->ops->query_ras_error_status)
> +			block_obj->ops->query_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> @@ -1012,18 +1040,21 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  		enum amdgpu_ras_block block)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D
> +amdgpu_ras_get_ras_block(adev, block, 0);
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return -EINVAL;
>=20
>  	switch (block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->reset_ras_error_count)
> -			adev->gfx.ras_funcs->reset_ras_error_count(adev);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> ras_block_str(block));
> +			return -EINVAL;
> +		}
> +		if (block_obj->ops->reset_ras_error_count)
> +			block_obj->ops->reset_ras_error_count(adev);
>=20
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->reset_ras_error_status)
> -			adev->gfx.ras_funcs->reset_ras_error_status(adev);
> +		if (block_obj->ops->reset_ras_error_status)
> +			block_obj->ops->reset_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> @@ -1088,7 +1119,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> *adev,
>  		.address =3D info->address,
>  		.value =3D info->value,
>  	};
> -	int ret =3D 0;
> +	int ret =3D -EINVAL;
> +	struct amdgpu_ras_block_object* block_obj =3D
> +amdgpu_ras_get_ras_block(adev, info->head.block,
> +info->head.sub_block_index);
>=20
>  	if (!obj)
>  		return -EINVAL;
> @@ -1102,11 +1134,12 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> *adev,
>=20
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->ras_error_inject)
> -			ret =3D adev->gfx.ras_funcs->ras_error_inject(adev, info);
> -		else
> -			ret =3D -EINVAL;
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +			return -EINVAL;
> +		}
> +		if (block_obj->ops->ras_error_inject)
> +			ret =3D block_obj->ops->ras_error_inject(adev, info);
>  		break;
>  	case AMDGPU_RAS_BLOCK__UMC:
>  	case AMDGPU_RAS_BLOCK__SDMA:
> @@ -1727,15 +1760,20 @@ static void amdgpu_ras_log_on_err_counter(struct
> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					  struct ras_query_if *info)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D
> +amdgpu_ras_get_ras_block(adev, info->head.block,
> +info->head.sub_block_index);
>  	/*
>  	 * Only two block need to query read/write
>  	 * RspStatus at current state
>  	 */
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_status)
> -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +			return ;
> +		}
> +
> +		if (block_obj->ops->query_ras_error_status)
> +			block_obj->ops->query_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 08e91e7245df..2ffde223c4f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device
> *adev,  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_devi=
ce
> *adev);  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)=
;
> static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring); -sta=
tic
> int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>  					  void *ras_error_status);
>  static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
>  				     void *inject_if);
> @@ -2118,6 +2118,18 @@ static void gfx_v9_0_select_me_pipe_q(struct
> amdgpu_device *adev,
>  	soc15_grbm_select(adev, me, pipe, q, vm);  }
>=20
> +static int gfx_v9_0_ras_block_match(struct amdgpu_ras_block_object*
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
[Tao] The return type can be changed to bool and return value is true or fa=
lse instead of -EINVAL and 0.

> +}
[Tao] It's better to implement a general ras block match function in amdgpu=
_ras.c

> +
>  static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>          .get_gpu_clock_counter =3D &gfx_v9_0_get_gpu_clock_counter,
>          .select_se_sh =3D &gfx_v9_0_select_se_sh, @@ -2127,12 +2139,21 @=
@
> static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>          .select_me_pipe_q =3D &gfx_v9_0_select_me_pipe_q,  };
>=20
> -static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs =3D {
> -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> -	.ras_fini =3D amdgpu_gfx_ras_fini,
> -	.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> -	.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> -	.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count,
> +const struct amdgpu_ras_block_ops  gfx_v9_0_ras_ops =3D {

[Tao]  static const?

> +		.ras_block_match =3D gfx_v9_0_ras_block_match,
> +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +		.ras_fini =3D amdgpu_gfx_ras_fini,
> +		.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> +		.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> +		.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count, };
> +
> +static struct amdgpu_gfx_ras gfx_v9_0_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_0_ras_ops,
> +	},
>  };
>=20
>  static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev) @@ -2161,=
7
> +2182,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
>  		DRM_INFO("fix gfx.config for vega12\n");
>  		break;
>  	case CHIP_VEGA20:
> -		adev->gfx.ras_funcs =3D &gfx_v9_0_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_0_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2187,7 +2208,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device
> *adev)
>  			gb_addr_config =3D RAVEN_GB_ADDR_CONFIG_GOLDEN;
>  		break;
>  	case CHIP_ARCTURUS:
> -		adev->gfx.ras_funcs =3D &gfx_v9_4_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_4_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2208,7 +2229,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device
> *adev)
>  		gb_addr_config |=3D 0x22010042;
>  		break;
>  	case CHIP_ALDEBARAN:
> -		adev->gfx.ras_funcs =3D &gfx_v9_4_2_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_4_2_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2227,6 +2248,14 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_devic=
e
> *adev)
>  		break;
>  	}
>=20
> +	if (adev->gfx.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> >ras_block);
> +		if (err) {
> +			DRM_ERROR("Failed to register gfx ras block!\n");
> +			return err;
> +		}
> +	}
> +
>  	adev->gfx.config.gb_addr_config =3D gb_addr_config;
>=20
>  	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << @@ -2448,9
> +2477,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->ras_fini)
> -		adev->gfx.ras_funcs->ras_fini(adev);
> +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +	    adev->gfx.ras->ras_block.ops->ras_fini)
> +		adev->gfx.ras->ras_block.ops->ras_fini(adev);
>=20
>  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> @@ -4888,16 +4917,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->ras_late_init) {
> -		r =3D adev->gfx.ras_funcs->ras_late_init(adev);
> +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +	    adev->gfx.ras->ras_block.ops->ras_late_init) {
> +		r =3D adev->gfx.ras->ras_block.ops->ras_late_init(adev);
>  		if (r)
>  			return r;
>  	}
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->enable_watchdog_timer)
> -		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
> +	if (adev->gfx.ras &&
> +	    adev->gfx.ras->enable_watchdog_timer)
> +		adev->gfx.ras->enable_watchdog_timer(adev);
>=20
>  	return 0;
>  }
> @@ -6841,7 +6870,7 @@ static void gfx_v9_0_reset_ras_error_count(struct
> amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);  }
>=20
> -static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>  					  void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> @@ -6850,7 +6879,7 @@ static int gfx_v9_0_query_ras_error_count(struct
> amdgpu_device *adev,
>  	uint32_t reg_value;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -6879,8 +6908,6 @@ static int gfx_v9_0_query_ras_error_count(struct
> amdgpu_device *adev,
>  	mutex_unlock(&adev->grbm_idx_mutex);
>=20
>  	gfx_v9_0_query_utc_edc_status(adev, err_data);
> -
> -	return 0;
>  }
>=20
>  static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring) diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> index b4789dfc2bb9..2d816addbd4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> @@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
>  					  void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
> @@ -872,7 +872,7 @@ static int gfx_v9_4_query_ras_error_count(struct
> amdgpu_device *adev,
>  	uint32_t reg_value;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct
> amdgpu_device *adev,
>=20
>  	gfx_v9_4_query_utc_edc_status(adev, err_data);
>=20
> -	return 0;
>  }
>=20
>  static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev) @=
@
> -1029,11 +1028,31 @@ static void gfx_v9_4_query_ras_error_status(struct
> amdgpu_device *adev)
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
>=20
> -const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs =3D {
> -        .ras_late_init =3D amdgpu_gfx_ras_late_init,
> -        .ras_fini =3D amdgpu_gfx_ras_fini,
> -        .ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> -        .query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> -        .reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> -        .query_ras_error_status =3D &gfx_v9_4_query_ras_error_status,
> +static int gfx_v9_4_ras_block_match(struct amdgpu_ras_block_object*
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +const struct amdgpu_ras_block_ops  gfx_v9_4_ras_ops =3D {
> +	.ras_block_match =3D gfx_v9_4_ras_block_match,
> +	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +	.ras_fini =3D amdgpu_gfx_ras_fini,
> +	.ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> +	.query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> +	.reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> +	.query_ras_error_status =3D &gfx_v9_4_query_ras_error_status, };
> +
> +struct amdgpu_gfx_ras gfx_v9_4_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_4_ras_ops,
> +	},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> index bdd16b568021..ca520a767267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> @@ -24,6 +24,6 @@
>  #ifndef __GFX_V9_4_H__
>  #define __GFX_V9_4_H__
>=20
> -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
> +extern struct amdgpu_gfx_ras gfx_v9_4_ras;
>=20
>  #endif /* __GFX_V9_4_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 54306fd45ff1..2744709fa09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -1644,14 +1644,14 @@ static int gfx_v9_4_2_query_utc_edc_count(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device
> +*adev,
>  					    void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
>  	uint32_t sec_count =3D 0, ded_count =3D 0;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -1664,7 +1664,6 @@ static int gfx_v9_4_2_query_ras_error_count(struct
> amdgpu_device *adev,
>  	err_data->ce_count +=3D sec_count;
>  	err_data->ue_count +=3D ded_count;
>=20
> -	return 0;
>  }
>=20
>  static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev) =
@@
> -1934,13 +1933,34 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struc=
t
> amdgpu_device *adev)
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
>=20
> -const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs =3D {
> -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> -	.ras_fini =3D amdgpu_gfx_ras_fini,
> -	.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> -	.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> -	.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> -	.query_ras_error_status =3D &gfx_v9_4_2_query_ras_error_status,
> -	.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> +static int gfx_v9_4_2_ras_block_match(struct amdgpu_ras_block_object*
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +struct amdgpu_ras_block_ops  gfx_v9_4_2_ras_ops =3D{
> +		.ras_block_match =3D gfx_v9_4_2_ras_block_match,
> +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +		.ras_fini =3D amdgpu_gfx_ras_fini,
> +		.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> +		.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> +		.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> +		.query_ras_error_status =3D
> &gfx_v9_4_2_query_ras_error_status,
> +		.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> +};
> +
> +struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_4_2_ras_ops,
> +	},
>  	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index 6db1f88509af..7584624b641c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct
> amdgpu_device *adev,  void gfx_v9_4_2_set_power_brake_sequence(struct
> amdgpu_device *adev);  int gfx_v9_4_2_do_edc_gpr_workarounds(struct
> amdgpu_device *adev);
>=20
> -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
> +extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
>=20
>  #endif /* __GFX_V9_4_2_H__ */
> --
> 2.25.1
