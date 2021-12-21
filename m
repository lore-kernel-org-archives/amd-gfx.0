Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A20DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 01:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E3810E9C2;
	Tue, 21 Dec 2021 01:44:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD1B10E9C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 01:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfRKh2BVAYbFyD9TPoDYdvoS6aclelE8b6wGJKuRTlHLtTKeK+zlMeNBmhTMlAmUpJbyXtuhRO0fSeNOIbmu+BOviQgrRYwroksP70B2+CxcgKZRD5swD9cYriubZmTg6JvD60w++3Kc21x/K4TS/Wq1nFgFKwXDjmbdDSu8B/mVx2MIeKI4KvUp5MdPhlb+f5NUP0U/6hOUh2rxZ+oMpLAG8u71h1SSDIQ4AJVzpMfAUK0ZmGhWXG0/Ip0dUFwBdinQh2S4jBt4wRfkuWZpbQu3/vxGUjI85RBCN+epFnSGkDp4TR8fFiYPJl36ys8LoKEtRTDQFX8mov9vPM30Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idEHSu+QZrZX+XfDrSPSJHcMbtqEoU7OM2OBY4u7mwU=;
 b=fEH95rRGwwpuXc9Z7yO6Sh94AqB6FAWR7Sp4R1tfWcJSlfN4m/YV+MzaYAaruJNbJ32AoqFvVUsTIDXAOLvGFVFZuXFAyjpPzR8mu7wPb3YvsOOzEDtLd1NhfO3AGXuUfSOm+BTe/XB+vPxQEhWhvaHJM/BpOKq/aVikPqsv1wyEG7gwu7yaVjKKFHMf87ZDJWnGgI/+Kbd0pY0+WqTwW9gle2CuuinE0ZIoQho8+sBjAKL01C/rr/DHALZYXyr1YpHUaGsxvaBggVElsB/mCe6w8USA4plQT9griFEkLDo8ysPGzFEp5/IQBYxA0UNB66pZ7rPpbBcNRI1EdxMkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idEHSu+QZrZX+XfDrSPSJHcMbtqEoU7OM2OBY4u7mwU=;
 b=1dfqCanqvkPSInEU7vUJR5LQwxJldUmePQWEb3unAxq5nEIrad20Qscp1N5QJJeWEXxkdzPlQqGDs6jFxBo1bozD3YYccNFGYsOYXbOdDOjX2c8z6z0aaI8PvKnTpPjXpfACgxzfmVp2ruyhCQoOxgIyNR7eKRdzAq6vj1sjtOc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Tue, 21 Dec 2021 01:44:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 01:44:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop redundant semicolon
Thread-Topic: [PATCH] drm/amdgpu: drop redundant semicolon
Thread-Index: AQHX9a69NA12vGE6WUOvXvvKk7xm8qw8LPyA
Date: Tue, 21 Dec 2021 01:44:10 +0000
Message-ID: <DM6PR12MB2619F218ABC1D225AAE545E3E47C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211220143340.8702-1-guchun.chen@amd.com>
In-Reply-To: <20211220143340.8702-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-21T01:44:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f68f84d4-714b-4970-bda7-016660a5ea60;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2196d46-ec86-4bd6-61db-08d9c42362ab
x-ms-traffictypediagnostic: DM6PR12MB3275:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3275E601626ED7E93563FA1CE47C9@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pp7aT0Wuj/RB1EJK+bayNN2JECzN/cdNmSwxqrVf4YEnZ6nekP1lkURf8O64b7OT2n75Rbf383yGYw4wxuYjwS+1pEONOmhmdgQKm+2Z1+dWOBbyb4+nZ/fmKMEf3qW7ozSWwURrAzVQl7jmKwtuxGxENxHpUYbc08G7S+1YNstQSqIj4UzRc6/z4BbPdyMvuAXOrcTQILqa/Oxlsw7xP1BknhN/jt1qSXKnDdW5AnTr1znGBkAQf6NEqWeDrBz4DxSZ7Dx+0Pi8n9ghDLXgal2H16rCqSYPeS8k9f7QSFeh5h+hmWau463ddpmMq8uvAeO0gQLN3kyfyGaM0dp9kpm99Q/S9WcOhg02HT+HPVfgowfXlWXVoejvRufv7een8py43K3X10aTL23N4QBUFTX9eQj/KcvHCnzBXNZiHLZgQDAl//YU0JdenfY4CRYO3M4GZn1pcezPLkxH2KQCemcNhALsjUXwUAaUx67U7qGRqWurgwFuWJEW9YxOp1fU4UzFYWsofY/Vw9yyV8p/N1Hqs5NTjYlEJM79zVbRWA7zEXUH9ckmh2+IdpegdvW11l/OxQL0VvqrxOQSD46LiEHwj+kHOPrcYPY40XVX4LOpuEjEtU4OnmmGA7r9j+Mfd43KmjinoNlPZUv3v1IKYzteIF+mcgR1UgZGc1uMaTlhE5YApwyURJDRi/zP0v9mkgJgoGd5mANKkOXmrAmP2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(2906002)(52536014)(66556008)(64756008)(66946007)(76116006)(6636002)(7696005)(66476007)(8676002)(86362001)(33656002)(316002)(110136005)(8936002)(122000001)(5660300002)(38100700002)(4744005)(53546011)(6506007)(26005)(186003)(508600001)(38070700005)(83380400001)(4326008)(9686003)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+jBhAkpFz71r+vIfmzHUbP+GBM52ncbn7cd2PkKgDFLHvKx9ZUTHjMGwesoF?=
 =?us-ascii?Q?xigSJnjhI8ImQAo1d/hvTKCdTwlUtzva0rXw5h0ZsREfysq5CucAllsBLUr5?=
 =?us-ascii?Q?OLZHs8YS7t3nj00yqsI39sVuBun7De02NujBZGXkctdmGuxiLj5zl52OPKhe?=
 =?us-ascii?Q?0Xra/8/DNAkqsz02Qnu128wrkXJlJI1XvFP09Lc5xzbppdWV1DqcHzxNhPXx?=
 =?us-ascii?Q?ej9fwsiwPI4PyiOVBw6hNDZUzxYRz7c29LM6Iyxg/sDhRueecJ9Tfh4kAyDK?=
 =?us-ascii?Q?Xd7fEub59tjkX20Yhuaan9fEYmgSF4LhMRmEo91I7NGu2hDsnKmEUsAI7tC6?=
 =?us-ascii?Q?k9ziPILnlU4gV8+tEBIsL7Z1b9ogRx3NAiE1EYoYg/NMwAChFRv/npAjKAQ5?=
 =?us-ascii?Q?bLsvRV75lNkUSyyQnsvvVV/6/CsBhGirKF8ct3Ja0PZgiBSrKHruA9F7UM77?=
 =?us-ascii?Q?KRXnFDAU5ant5f41WFLNfVbhAnMuoHg8JsRi/pMR9noUq11uSTjiwMjlhsNB?=
 =?us-ascii?Q?GvM4Zy0t7Zo94RTIE4F24H1OpvzigxcDFb6dGd7ns8FbY9ZJYu+VZZsQlgr+?=
 =?us-ascii?Q?6ZkDD87NEky0u44+/gEiaUdBPenjsqVT5LMXxr5AvPfvASSUKIuWj9J+PMRq?=
 =?us-ascii?Q?fm128+4rQ/CiWZ7Iz3GUfGY+fHmL/NVsWCdzwhmHVKgQR+WSSoMEBzYU4VkC?=
 =?us-ascii?Q?udI4A31+EAjqB69yOjmFNEe4zERj6zoMp9Gpv8iSygfvP8I7dx4Jwhc+kEBu?=
 =?us-ascii?Q?igY8wAfy55hhBFpJBEBTCladRn0hmX47ECNHsui4ouLZaAv6FYHU/2wJCxs2?=
 =?us-ascii?Q?0nRyIx2TmQ1CPauSCocD11r5ull0mxct3Y5Bh7tvVDRcYwYYl1ClMbDnF+AH?=
 =?us-ascii?Q?jZgOpCPbyKxy1hqNTGVdnbPJHNOacYsnEyk0pgJBwK6cRVe/CKA+8UoJgT8H?=
 =?us-ascii?Q?MMYIv6ft5LaiazTze1B9u8FFi1qlRMvKbZjYLpw5B5CQUbmxTUh5TI76U0BD?=
 =?us-ascii?Q?Vuz80eqdZG7PVKa1M9GtpghayUfgFd3nO4pYa/oYkzpO1BgYuKJcPGfBBwZ0?=
 =?us-ascii?Q?RgqV1YknYpwBPdwhF0xAttPOydTVPaBn3tJIIND9Nhlv8xD4kn9kVI8RD2xv?=
 =?us-ascii?Q?wjJryxGAqKF0AyzQdUyu7Y+KZTYzZmxLCXizkT5pjtC2bfXdGPsWupE+sd26?=
 =?us-ascii?Q?Km3UeH5tLWR9hU5/pyKvdJSrZ8I0ZpzCG9RUbBRkwskxVrZ6pAXMbMON+zNT?=
 =?us-ascii?Q?p98BfLSOVbzFH6hwrNCiMx+J2vs/TVH2qKrFakdX2B+/c/ow6fu4LbesDbPG?=
 =?us-ascii?Q?dGQXJYvTS4l8dnWAFBubRmzy7PcYRSIM49quYDlEUh2qhp0oiJpotNdcz5nn?=
 =?us-ascii?Q?wNX0GzveSg5QRogyhz2mi6QJZ2WXOYR/eJ6D9USBu677L8oDXL74wa6uOPm7?=
 =?us-ascii?Q?d5VDePa9ST/DP22BU99DaTM7z+SN5xazr3GJ1i905fUGjrTsBmATmjrS/j/e?=
 =?us-ascii?Q?sDlMBbc2kZsmGG9QM6cKZdUnQ5jQWBMdwiPLmprHmFa1KhXCUNV4LyO8BSJn?=
 =?us-ascii?Q?TsgkiAwRW94LGnp9qEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2196d46-ec86-4bd6-61db-08d9c42362ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 01:44:10.5903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy7x8l+TR4g4WzGEbk5H8cGDhvgrNIz31uW6vmTm2WDqV3Wi/51+S1VfyhwyABPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Guchun Chen
> Sent: Monday, December 20, 2021 10:34 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: drop redundant semicolon
>=20
> A minor typo.
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index b13db855cc9a..580a5b387122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1023,7 +1023,7 @@ static int
> amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>  		amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
>  		break;
>  	default:
> -		break;;
> +		break;
>  	}
>  	return 0;
>  }
> --
> 2.17.1
