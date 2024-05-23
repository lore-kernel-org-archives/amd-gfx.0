Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D21C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 17:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC29A10F123;
	Thu, 23 May 2024 17:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSO0bmK9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0770310E9EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 17:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR9EOiO6EH41ZCdI3ApfoIMV7Wd52xLPj3ve0ywf1TiknT7vO7zD5CK/vGaMgxh1Pf1pT5AlZ+yBoTjLj7ePlOJc8jMyYROzHU3vozUHYnh6NFk7Dj9MuwiQUsWLTJuy9FfYdQi9pPf+fnQ8vXeDjZrbPys5ySpk9YnB0DP1h5Xmc6Aaov02XFqQsqbFsB/jizo1WdeMlNa9fxwAki5PDzIJ2buwKlFaRLSlgPmV+r3/hjjwaMyVWN2SqlFF2efigIpi4Cd61cWr4tgMFn8PKA/Poj11LTzMfXoP9GhTnGVZYcejjlRcB6j4AeCmyoyT9bvQdsMllWuYcb+bRTEN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GkuglytAUNax+2IJ0qGPOJQnCgJdSwXJinvwVfimvI=;
 b=BL8aKoXMLUmUVrgQwQ/fBanZ+hLoa3npPLrdivKBsOoVVmVaM5NP7hcKWvV4x7+8lL1qIUknKamDfBVdwnQRkSB5Z1oboF+0cmP+5EaXJowhDR3scejrpqyGPZ6Azbvp7I933TuBggjg4PaXND1xutWGC4Vp5YJla3Uigal0DMJ5D7sIalKbOVqLuzd5ff36zJbB60JgtwUBGrmSFWqwZJ29BJU6ku825DEcuucBAAmPXVgcZSLaQ7UwtKToKa3a9Np4MW7A2CvbtQUYaPgZpu3iFp1PQ+fPZkoX2xV1nd/QBRBAKMsZ5IJJikneDMRJFMRGioW/p8ggawSlBf2c5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GkuglytAUNax+2IJ0qGPOJQnCgJdSwXJinvwVfimvI=;
 b=XSO0bmK98TqqH5YHc9pmLsOoSQFSm+FheX4ovBSDShmtXf65XH8kx9SqoQjlf2GI85pokdGsGEkqMD840d8/Z3LTxjqN1r94l9Us5BMbMORmrHVK9+jD+cRlCX8n7xeIMsLpena+T93duD+oeLF/0ULOrqDec9PxgqPYr6mhy+I=
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 17:11:07 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 17:11:07 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Topic: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Index: AQHarSKQ50Pf5jMajk2UNMWHtN5i1LGk+w8AgAAOfYCAAAD3AIAAAyEH
Date: Thu, 23 May 2024 17:11:07 +0000
Message-ID: <BL1PR12MB51263D2BC502E2FCF5C7123DFDF42@BL1PR12MB5126.namprd12.prod.outlook.com>
References: <20240523150439.3274992-1-David.Wu3@amd.com>
 <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <47f0ac94-d6cb-4632-9960-0f94832857be@amd.com>
 <SJ1PR12MB61942426002C44CC636AD5C295F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB61942426002C44CC636AD5C295F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T17:11:06.754Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_|MW6PR12MB8733:EE_
x-ms-office365-filtering-correlation-id: 9fd16f0d-b815-41fa-083d-08dc7b4b55be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?O/8eBZJrDRDYEbg9Z+nT84Wm48EjQZ2ck6qumcb0LnxbdlmJnBEw4Us67qYn?=
 =?us-ascii?Q?WbzKyUh05m/M1FewiLtlNn+Crs2mnuhHcswMEUi3rJyLn4/b4ACcK4izVGdH?=
 =?us-ascii?Q?jNu8FeKYapPTv+DrzYFOmzfMIHEd4UJQZqMlWxvV6/xRfUi6ckCBt77SlDKK?=
 =?us-ascii?Q?SWQXTqtBt81wKpEHJR6WEs6rIgscc4gl/ScLiZ5Dr3fLAKY33Yz8MvFV/KIP?=
 =?us-ascii?Q?CJZWDncX4hJQDaKkyDybFSn9o5FsQuPRGsWA6ZBddWTvm7acYEuUWq+4XwQD?=
 =?us-ascii?Q?YVkwYx01Nym8rkHHiQl8e8Ign1NHFQjra34V2hiFNTM44q/mYlVWX8ULPXF7?=
 =?us-ascii?Q?zV3d12NVpB2AqzsfhBtEK+xX2qWRDGeRsJN+stbIJAbql3IZWWxcY3uzFPdE?=
 =?us-ascii?Q?1bHQpaYhmNiFDGxo98tkeHEmQlFbsYIHPD0Ff3CVGTWxeAt5PjkAT9LqcynM?=
 =?us-ascii?Q?TmFYZyNd6OMeIe78hhITBnpWEeSoHxPSqBGXWlZEmbVfk9OdAy5bE9hoQKxm?=
 =?us-ascii?Q?Xyq+c3+YWSsMpPGCw+ehlGufmfOEgd3wPczrvf3H3THZXBvKeDS9fca6kYRH?=
 =?us-ascii?Q?XwBPlfcmi6ulmU6BdH/MYMcdyH4BeNWyRQfkbubLYMf0DzTWIFcen/MuCubI?=
 =?us-ascii?Q?/Ah+DX0bXJHXxyFKFSodWPw0ZRcs+XLSiJRZogx3wyKR/i4gQwYSW/SL28Ds?=
 =?us-ascii?Q?6wPvNwBsO/z9rrpn4Ng053U8EBwc26lSRoFxYDbud2BXGUh2MVdGgBXWQ7QS?=
 =?us-ascii?Q?pJVlo4PWaj+tBlWXEjI4XvNgU5OVfeNHay8TV8fsQt6JLmA+jbRADkzNIiWN?=
 =?us-ascii?Q?fejufaDegeF1xlqxShevYZ4yZSFG/B2DoJ5Wu4h8u+FZrB0+/Px0We1hL9o2?=
 =?us-ascii?Q?5yaHRgVuM8FxKBBH6b4W2tkrkmNpqNlJDsEn/Dwrvmk5u2qM+YGmOmwAW8wL?=
 =?us-ascii?Q?0zO6hFnSYq1kff29SECWzt3MHBmiCUTSwatMbUp2473ZkCZ0/3hQ/M3pS957?=
 =?us-ascii?Q?xbcBPzi0PASWwffH4BzfAhdg2oyUQrljhzkSfcOQzaIRiBoIf+4N5cwc3Cmg?=
 =?us-ascii?Q?0FS9MRu7iEyZW+3brow6y2e48slwVWTEKyRtHxWOiz5kcDcEj1bZq0aCmJW4?=
 =?us-ascii?Q?+OROHWO6rXrqaPCUigrmOQUTW9u91hHSvbd9q2UTYtH1sj55DNBGcDqh5AZy?=
 =?us-ascii?Q?z00A/ri7sNXGJVuPFWz9wDqwsOII5eGYX2XVBrZzMbaJvJ0BV99gAQGo47X6?=
 =?us-ascii?Q?iF1qRh1Q13r9g66wCDq/Ob/490+/C3UxS6gJpDBuGauIP2DKLracT+clCK2Z?=
 =?us-ascii?Q?3LvRywnxhKYcZF9D3QPtg0mxl2t8UIt/RoGFRB0ZlQb+Kw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4hvfdLhc3QobQ0eMv+7yqO6OigxtkUV0VQZvGg7Gu17NxDSVZY7LNcA2gzZL?=
 =?us-ascii?Q?iSXOoDaLSwmZ3ntWm3cyhNgcs0yHO3GYdIjiiKpwbyc0T6DqLk4pMlfg375Q?=
 =?us-ascii?Q?cdSPPv3h4/+DL37c8f1CjwNiH70UOdJ1elrLO1+w7DNga7Mau6Kcq/U+22sn?=
 =?us-ascii?Q?UTaGEgExx2ezeoB7f8R6YXIyNhdVTA5x62Nb9GiMBbQQvRiGYwH/dEu9hSO7?=
 =?us-ascii?Q?7BfvAhWI3M5tCYryYGa457meKPe9xkZWDOTNga3ySDX66QObsz+enaHWtNf1?=
 =?us-ascii?Q?PJmqCOSIj2ALBlVpQ34a4NAU2UGoLJY871XD2vfagb5krN9nZJUKxG7scS/m?=
 =?us-ascii?Q?TCmW/u70ELF5H9EjcEMlsWqz468BokmDnDSJe87T3C1/cQW913bHC0jVYeLR?=
 =?us-ascii?Q?wzd2/66YvlzR9BY+Jf6Ry6JkpvIiGLZa3LcKyGhx5+O24qHyuMd7bnNp/mKS?=
 =?us-ascii?Q?4LYFmnPB8sGgU+hhBoyaTGaYoD9gAQWlPGJsiT60bfH7GOq7Buhh8D0k/XV1?=
 =?us-ascii?Q?DfZpThx0AnjxJiYQ68DGdhjlETk/wQ5qurENRgZqs4oJwN2ODGOFSgQsR9Zu?=
 =?us-ascii?Q?XHoGDyHLvetTa2EVVs5mlNXz2hZHdNBqvnvgh/glI7v4C5pumWbM4szI51+V?=
 =?us-ascii?Q?dUhbKMG3/mn3Y4OrnltvW2mHCSSw7UAcjV9KEQXMXobfKmE8jGOFI5ZLFqON?=
 =?us-ascii?Q?l3twtYsMM5dNHfHBGyLUJlp+G7dtBfTmIhfzNQsMZb+b++kstl7kRhIqoZjc?=
 =?us-ascii?Q?M84HAhSeuCu+UT5FwKjcPC6AFPwaEmspKRxgSb7C/3/rp1szo9mmJL7wY5HF?=
 =?us-ascii?Q?rDXjQgKxs2Z39NNmed0jXhOoKQnuL9bE1tqF9HCUh+j4Xdk5eLCwpazzONuc?=
 =?us-ascii?Q?9sYjYhKQR77g4o5DT00EaK9KJI9x45XklowiNJjD3Q+1087RLrrgqwplhthH?=
 =?us-ascii?Q?KDainWrX1wa9rqea+yMPOrm6DKvZtlk5Ojp+2John/SzFmQkdsYm3fUy2y9q?=
 =?us-ascii?Q?fWpMF12aP8Pgg/jBhQyq3amN5G3ZIGgLnfrQy4HQ61VMljVAHrNZcutnw4+E?=
 =?us-ascii?Q?i16uuEjDa0QL93lvDZV0evDtCardlmgPpttAwvkj08pYNAF845Oez2jXTISi?=
 =?us-ascii?Q?dx3NslRKbnWn2HYkjhtTiJX/NGZhMip5nAu4K/CQNZ3V6oj2ibEQEopW1+Xa?=
 =?us-ascii?Q?nc9kyQdBGMoJuhd2aUooDdMI4EdsV9duXMSYAY7YAd/OmLUuU4/hzjz9Gihy?=
 =?us-ascii?Q?EqcvqAcn0deBxzkik829OuF49tx9ywAGwVHpW8wdMe8w86XggD6MQde+JivT?=
 =?us-ascii?Q?4CuJAA43iWhMIZ8w0EXKRhy5t9ALPhjY/X3og8483BbiH0GhtbsFvSLT+D54?=
 =?us-ascii?Q?P3UBfDlweGZlEpJg7w+ZwYrNJbVLo2LcWjrirkUHjpjEfWWfNpwR8GqHCpKQ?=
 =?us-ascii?Q?iT5HctvqEeTRUnEIW9VqT2uL94ZzB4D7ZjM1TUqykRpK42qRZBpwn6WkvDUl?=
 =?us-ascii?Q?OlsfrdYmCAIGgngkv1aCufPy/a3MVL3sSR4/lrbyTF1JKgo04dDd4RPufjc/?=
 =?us-ascii?Q?3/aZQD2CwUGThRgHAmo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51263D2BC502E2FCF5C7123DFDF42BL1PR12MB5126namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd16f0d-b815-41fa-083d-08dc7b4b55be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 17:11:07.0625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWTQbGEw0XZuQgX8cYtxrO1PT1FW/LDnHZkKwWo4j7ugip09sgsJo0yIHnKmcpGU72q8MIRuzb3OtywHW3uf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

--_000_BL1PR12MB51263D2BC502E2FCF5C7123DFDF42BL1PR12MB5126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

The patch is Reviewed-by: Sonny Jiang <sonjiang@amd.com>

Thanks,
Sonny

________________________________
From: Dong, Ruijing <Ruijing.Dong@amd.com>
Sent: Thursday, May 23, 2024 12:58 PM
To: Wu, David <David.Wu3@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@l=
ists.freedesktop.org>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN code

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks for the response, and it looks good to me.

Ruijing

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Thursday, May 23, 2024 12:55 PM
To: Dong, Ruijing <Ruijing.Dong@amd.com>; Wu, David <David.Wu3@amd.com>; am=
d-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code

please see in line.

On 2024-05-23 12:02, Dong, Ruijing wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Please see my question inline below.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 23, 2024 11:05 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing
> <Ruijing.Dong@amd.com>
> Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
>
> We have messages when the VCN fails to initialize and there is no need to=
 report on success.
> Also PSP loading FWs is the default for production.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1 -  drivers/gpu/drm/amd/am=
dgpu/jpeg_v5_0_0.c |  3 ---  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 =
+---------
>   3 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b89605b400c0..5e2b7c340724 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *a=
dev)
>                              IP_VERSION(4, 0, 3))
>                                  break;
>                  }
> -               dev_info(adev->dev, "Will use PSP to load VCN firmware\n"=
);
>          }
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 64c856bfe0cb..68ef29bc70e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>          if (r)
>                  return r;
>
> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n"=
);
> -
>          return 0;
>   }
>
> @@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec=
_ring_vm_funcs =3D {  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amd=
gpu_device *adev)  {
>          adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v5_0_0_dec_ring_vm_fu=
ncs;
> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>   }
>
>   static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 36d4ca645c56..070b56610c7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)
>
>                  r =3D amdgpu_ring_test_helper(ring);
>                  if (r)
> -                       goto done;
> +                       return r;
>          }
>   [Ruijing] Are we assuming the hw init process always be successful?

No - it could fail with errors and in this case the top level will report e=
rror. Otherwise it will succeed(and no need to report successful message).

David

>          return 0;
> -done:
> -       if (!r)
> -               DRM_INFO("VCN decode and encode initialized successfully(=
under %s).\n",
> -                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mo=
de":"SPG Mode");
> -
> -       return r;
>   }
>
>   /**
> @@ -1122,8 +1116,6 @@ static void
> vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>
>                  adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unif=
ied_ring_vm_funcs;
>                  adev->vcn.inst[i].ring_enc[0].me =3D i;
> -
> -               DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n"=
, i);
>          }
>   }
>
> --
> 2.34.1
>

--_000_BL1PR12MB51263D2BC502E2FCF5C7123DFDF42BL1PR12MB5126namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The patch is Reviewed-by: Sonny Jiang &lt;sonjiang@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sonny</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dong, Ruijing &lt;Rui=
jing.Dong@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 23, 2024 12:58 PM<br>
<b>To:</b> Wu, David &lt;David.Wu3@amd.com&gt;; amd-gfx@lists.freedesktop.o=
rg &lt;amd-gfx@lists.freedesktop.org&gt;; Koenig, Christian &lt;Christian.K=
oenig@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo &=
lt;Leo.Liu@amd.com&gt;; Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN co=
de</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Thanks for the response, and it looks good to me.<br>
<br>
Ruijing<br>
<br>
-----Original Message-----<br>
From: Wu, David &lt;David.Wu3@amd.com&gt;<br>
Sent: Thursday, May 23, 2024 12:55 PM<br>
To: Dong, Ruijing &lt;Ruijing.Dong@amd.com&gt;; Wu, David &lt;David.Wu3@amd=
.com&gt;; amd-gfx@lists.freedesktop.org; Koenig, Christian &lt;Christian.Ko=
enig@amd.com&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo &lt;Leo.=
Liu@amd.com&gt;; Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code<br>
<br>
please see in line.<br>
<br>
On 2024-05-23 12:02, Dong, Ruijing wrote:<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt; Please see my question inline below.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Ruijing<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Wu, David &lt;David.Wu3@amd.com&gt;<br>
&gt; Sent: Thursday, May 23, 2024 11:05 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org; Koenig, Christian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Leo<br>
&gt; &lt;Leo.Liu@amd.com&gt;; Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;; Don=
g, Ruijing<br>
&gt; &lt;Ruijing.Dong@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code<br>
&gt;<br>
&gt; We have messages when the VCN fails to initialize and there is no need=
 to report on success.<br>
&gt; Also PSP loading FWs is the default for production.<br>
&gt;<br>
&gt; Signed-off-by: David (Ming Qiang) Wu &lt;David.Wu3@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp; |&nbsp; 1 -&=
nbsp; drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |&nbsp; 3 ---&nbsp; drivers/=
gpu/drm/amd/amdgpu/vcn_v5_0_0.c&nbsp; | 10 +---------<br>
&gt;&nbsp;&nbsp; 3 files changed, 1 insertion(+), 13 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; index b89605b400c0..5e2b7c340724 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; @@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 0, 3))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmw=
are\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
&gt; index 64c856bfe0cb..68ef29bc70e2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
&gt; @@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_INFO(adev-&gt;dev, &quot=
;JPEG decode initialized successfully.\n&quot;);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_=
dec_ring_vm_funcs =3D {&nbsp; static void jpeg_v5_0_0_set_dec_ring_funcs(st=
ruct amdgpu_device *adev)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;jpeg.in=
st-&gt;ring_dec-&gt;funcs =3D &amp;jpeg_v5_0_0_dec_ring_vm_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_INFO(adev-&gt;dev, &quot=
;JPEG decode is enabled in VM mode\n&quot;);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_f=
uncs =3D {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
&gt; index 36d4ca645c56..070b56610c7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
&gt; @@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_helper(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto done;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; [Ruijing] Are we assuming the hw init process always be su=
ccessful?<br>
<br>
No - it could fail with errors and in this case the top level will report e=
rror. Otherwise it will succeed(and no need to report successful message).<=
br>
<br>
David<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -done:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN decode and encode initialized successful=
ly(under %s).\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;p=
g_flags &amp; AMD_PG_SUPPORT_VCN_DPG)?&quot;DPG Mode&quot;:&quot;SPG Mode&q=
uot;);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt; @@ -1122,8 +1116,6 @@ static void<br>
&gt; vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.inst[i].ring_enc[0].funcs =3D =
&amp;vcn_v5_0_0_unified_ring_vm_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.inst[i].ring_enc[0].me =3D i;<=
br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN(%d) encode/decode are enabled in VM mode=
\n&quot;, i);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51263D2BC502E2FCF5C7123DFDF42BL1PR12MB5126namp_--
