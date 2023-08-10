Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4596EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 02:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3D810E49D;
	Thu, 10 Aug 2023 02:20:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F9D10E14D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 02:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF+3e46LhwxwH6FC77edfkDBXeekXEQFJSpI/EORuZmywvV+IsRbp6YfKx5DExitqn68W26UgXb7iLN65YYXVXS6tmy7qFS+fHmPAX1ON0wKCLmuphysddBQb0+apA22QBvxrwxiPFj77A/ZwA2maxigRskxX9z6MxbrVUdWij0RqCCyXlhMl+xK0j+cdKZhp3TxZy5qfSMTzgkV2+8VZJv41SazphcgEnfRVqdPq52cwGcMfSUuP+uZExWrJNXAEq0wDZdvGmB0GSPVaaoQ5xZGuKEbAI96fXs1ImEKuSwyR8EwmsZpUwEoLf8/wuIY5AeUEZYJ1ZohGl09MLX5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9jU3XLrP8Q9Mv6MaWh6GxjVeNcV1PB6FGW82ObZ1qc=;
 b=Qb9dyCXTRiS83ysB6CiIxgNMHP4WJe5W2PgGVvZ3YpOmzRgJqYBPSOsFX/5BQ9s2DSs72yFyKwt1Rcj1NatVbjMpz9gJIZg9/6h/aISN0ml1eAeTckUCnALm+V0p+zvPzqJoj6gnVzbxHbZByN7lDqRmqWhKoqbN96gJXtE7tHti5/jG+GC6iA/T1UJJ+48k2b8b1XrtUlXIepbVG+DBkk/TzBFYIgoZ8kSO6C7owZYgxUR61/DaAkExjTVrKeNoCdelAb0t79G4mous/i/iopDfLq6Tf/vSDKa3+PHENEp0ZDs6+s3ysGIS1sdBrLHHL5P8Dg7LMFajxtOFwL0yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9jU3XLrP8Q9Mv6MaWh6GxjVeNcV1PB6FGW82ObZ1qc=;
 b=WdZWb47tCaE/XR1aE+xV28KD+iDLPExJ7EJUF8yZC/Tj6d2lW3MS2X0wLCkAr8u8aaXNmazRGSsL3eke3Yin49AXnSc4fpY+1emx1rjOW6YdoyEb9ltB7uvBTEpaCptTSjSOfqFLcGiYQXuX4rl0fO52mB+Swk9w8eKM39UI744=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 02:20:24 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::7abf:f750:1e18:e157]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::7abf:f750:1e18:e157%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:20:24 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove unnecessary ras cap check
Thread-Topic: [PATCH] drm/amdgpu: Remove unnecessary ras cap check
Thread-Index: AQHZyrO7HGMeql9bqUOClnR7jsABL6/izQCg
Date: Thu, 10 Aug 2023 02:20:23 +0000
Message-ID: <PH7PR12MB8796A66D25C0BE1374F46E28B013A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230809112130.20535-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230809112130.20535-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=83c94309-9b3b-4465-b85b-2c17127cb170;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-10T02:20:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB6611:EE_
x-ms-office365-filtering-correlation-id: 5a6fe529-a1d0-41c3-8ef6-08db99485a8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjqzQ84WV6bGKdwKwYjlf5JeY7plSpJ0vxWK0VUfqo1s9ARNtP76jQf8nVx6/Cxa9Al93Hg3BdCi3gpjZV27lwFAqwHYh5Wdt50iopaqWFVXG9yKuqDMiBcPX7XJoYFLrURWKSbZAaBpwRSPQekyl+JXXAfAgpwzmPSKWuhbYUdMhHfyz5Ll0nbmGef+iRDItGMtFQG1os0G2sRdJhyJCo2CoJUbYV0c4rHYvNN3bU8UT1q20QMtJJ76deH1240T04xCBY9oU6xm/buu+gLAs41J/uNeucP5dXrRaTb5rQVpimJTl3NFLvLVDHLFICksNiltl0///4rEvCRDGPqLokCNK0fFvcaAqNyOp33E3GrKd1iuQMLFKmNR8jcx67Jg0CX/Iwz/2dA9mCOAXhbElJ0KniCuWvbzlNjUBm7vqCg4ZdiWLLnbOOnEgS7SxK6EFlQE86s1CGRM18Q1Xle5uxQg1KpyQj63dqrRY69uErqhV3xku333WIIMjmSxjJcVdr4mB8xz5/CZDHCA3RuRXdIPn1/DO0XKzVAXOSoBt9gbwCJPS8p1v5TLyvwHT0xN33zhOYfolx7bGy8gVbWfNRYnrlYXcg87Y+BQ0xBHnn/uPOWCKfXy+jZfeZ8HOoWB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(186006)(451199021)(1800799006)(38070700005)(52536014)(26005)(8936002)(41300700001)(2906002)(5660300002)(83380400001)(8676002)(55016003)(38100700002)(64756008)(316002)(478600001)(53546011)(33656002)(7696005)(71200400001)(6506007)(66556008)(76116006)(86362001)(122000001)(66446008)(66946007)(110136005)(66476007)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?moh3o3llSdCita7sfIc1BDxEsfaGMuXIr2zbE/g87eH3+jyK6XE1kBMMfBsD?=
 =?us-ascii?Q?tbdjmDFl5VyPlmeF1xty5ckxuL89mQrif8osQqm4xe4uuOnhLFRoA68ZdmE7?=
 =?us-ascii?Q?S2p1chjyc9O4oDoOXKZ43EJKSxLnCBmosri8AlLOU4u6A3d/PTzzJ0ZyKEii?=
 =?us-ascii?Q?eW5oakqVU07eywJ911mn0ephtgXpMMHGN0jHa+qiIZ02j23FZvBRg4FO6VT6?=
 =?us-ascii?Q?kI9XjFrnQYAuFiC7oZopfnjIfBjnsOePG5vN9jvtoMpYNTtQ/V8dqWXUhQ1a?=
 =?us-ascii?Q?LhFWrll0oc+q8upO/SizW/79hGXk1KsG9SN3/phI0xIKT+CclFTkAVv947iH?=
 =?us-ascii?Q?PdQ6n7ut8Tm49Ya8tSh7yK10b0q6eKjfPDGPsZwbMdaI1WsHzwRihCNkeccJ?=
 =?us-ascii?Q?b0fHE59YT34hSaQ+Wapr5G6o7lVkVdPdk1L6U8f/6U9917DsuVWR4q5P8YGc?=
 =?us-ascii?Q?HuyQ8ZLc96Nz8hqPI7KnjQxyPNk1T1uEfFoo7uYbJsoWZnJ7fYiWC54OjB/l?=
 =?us-ascii?Q?B/J6ivhnnO0DN/0/qYdlPcrlGbn60MfLm475vE1MclMSkRFuCOuZyBFds8u+?=
 =?us-ascii?Q?jX3X6zql95vOF2QEdvvn0Hgjp6Fo1iAdkBI1s39NfvO9P3IumM06JLR/fdCp?=
 =?us-ascii?Q?uwHH8HmIqINI87H1b3Vu0p7unx2VuLIo7D0vBt+gQM/o6STBiKQgv35UQBe6?=
 =?us-ascii?Q?q9o/lFp6rh3K7mM6vWYCZaqbwcBBODPHp+J5Yu8AbTgE7LrCbevSdAKp3I7E?=
 =?us-ascii?Q?VQXkA6gkKQsQGf5BmiCzAKGkN/ht7eK8RQh2wEBliEwkWQpWHBznrWebdXWv?=
 =?us-ascii?Q?/uhAx/hNlH6LshJHJZ9Zycys9Q2rfgWpfINcU4FJ74kfYp5RbXbnSbrwZLZv?=
 =?us-ascii?Q?QU1E2EbfEh0vkEsquwazmqZD/w04Sy5m4fCtm/lhkBod2jzo+USJ+z8cg9fB?=
 =?us-ascii?Q?jtuDJ5nyfpNCtO0ErMn4C5ebSjR8eCVxCkT8T3P28F1/+mSnGAYOsgiaQXuK?=
 =?us-ascii?Q?LBs942z1m+DS2qJYu39orC2xVsKtCCykYWZtr7KtYPg+zoPmwpfSA2T67sSn?=
 =?us-ascii?Q?iG+S7nnxf+NAHbF4vVeaGEkM0ucHsrtFwemHVfcFknzash5FVakGB9F1H3hY?=
 =?us-ascii?Q?vC2A+b0iUE/eRRcvZ9uSua5i6Dx2VoOnUroGtywn8hH/N1KK4tT8QsgpI/68?=
 =?us-ascii?Q?yhDlOHJ9P7JN1saJiHVqN/R4L7kwiH3DZd4jTxQ7nbjr7eWmTcdvon7ZDkCb?=
 =?us-ascii?Q?IpISFJezhpFJhPJdt5FvnM8nDdA1N4UWKBOfgj1jJoXaFNqg+3JzlqxWeIgH?=
 =?us-ascii?Q?+hFDxf9xTJSy9MJX4Yp/QvP4cNESGR8G+fA1/9qMN2o8krN6+JddcL8ULk2a?=
 =?us-ascii?Q?BNth8holaM7keU+VGCk8NlVO95KnuFUKkhVo417Z00oWrMyl9nZUkzGt12Jb?=
 =?us-ascii?Q?ZzA22z2/8Shwidnb2HSpdAdj/RMMBwsCotCUXhru82+0vCWp+YtBEjgqPuTS?=
 =?us-ascii?Q?lPjOGh2dE74D0uvBkD6tILz4C0amMmbvyeuL6Bv38CIDRlMPaQ3f+LO8yr30?=
 =?us-ascii?Q?/PV/sRuGX+YM0jvrTKk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6fe529-a1d0-41c3-8ef6-08db99485a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:20:23.9026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bwD6Bz7kaS+wZ779zKjeEsTOSGHCyoMvLLW/GaBzmLjLJmGS715rTIhguAqSi56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Wednesday, August 9, 2023 7:22 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Remove unnecessary ras cap check
>
> RAS global isr will only be invoked by hardware interrupt. Don't need to =
query ras
> capability in isr In addition, amdgpu_ras_interrupt_fatal_error_handler
> ensures the isr won't be called from guest linux side by accident. The RA=
S cap
> check in isr that introduced to fix sriov crash is not needed any more
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 00658c2816dc..c58b31121fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2970,10 +2970,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>
>  void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  {
> -     amdgpu_ras_check_supported(adev);
> -     if (!adev->ras_hw_enabled)
> -             return;
> -
>       if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) {
>               struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
> --
> 2.17.1

