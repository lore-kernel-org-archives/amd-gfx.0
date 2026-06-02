Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96794CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB7910F284;
	Tue,  2 Jun 2026 18:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ax2mjaT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6178F10F284
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFrcErwfyE9VJRg5F1gLM8aormOc/AzhOTZvAMhDXON2Jx/nZ1yUpFecsS0JGsyj5NgcO4V5nyDU0oY+D/rVt14+BbKGasNhzGDOvI0Jbz3i0T/80ir7xL1xWD/nkBK8PtXW29CNJ9BdFTdzsDKqi1Vl+mMgQRtFc/Of6d9cvTjBePNVUJv3Qh7BMGvJ054Gjd/c7NhOfCDmQkhhMvFwq5ss+eMPtM5ETqli1pJwBTUdzVyDt2l0JkrA+4s8rL37Yk/Xdg0z+KduztNUsuvK80NDKa1eRdqcREXzd5yqoUbQepYpXeLlR/26rvsz4Am7VY/oKDnJZCeaITAJKpn3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+dyDi2Wd7otYijeEKGJf7Ho2nYCMao4BZ9ZunYo0NY=;
 b=FcLJB2aL/grLv7O2SSGGxQ7kCdl3sVCGQtHLVSaaG7irMwjr6RXtkm1JLCwCP+e0JKadJ3jDiRfubupNUnFPYOByYAUq5SMWZsySx2gnxkPzvfaV9bmdGdg8atgwPjlItC2jCIY3X71b1hODw3IzBqTasbNyjdwW0tixVNn28uapwe/I5xt5aGfSR3w8287Se8SO57ISf/TutY0BSHelg+fEfKA2EEMp1gLjn56A7XXZKRJXaHe1fvDBWMqIGpc/ml0rR9HK+7mbcAQYWgx/cTf0FQMvZSHcFUed/K1gxLrp1PjoWneEZMFVz+/tTwxjx0Rft18nN7QxvDUu5WEKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+dyDi2Wd7otYijeEKGJf7Ho2nYCMao4BZ9ZunYo0NY=;
 b=5ax2mjaTH8zlpUpV7Zd9o6y5Dc7Taz25XtZ2n6MpQktpk57tTAGklGhdpRVrPXK0sMwcXsVW7T5jp94BzRnalo6Oa1wEvQJTMfeSlDiidPGkDfR0Mh6eXSiY+On+oK4tWWthcWp042cdNrO495ki/Ls9HY7fOM0qBF9aDSEs/gc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 18:11:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 18:11:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: validate the mes firmware version for
 gfx11
Thread-Topic: [PATCH 1/3] drm/amdgpu: validate the mes firmware version for
 gfx11
Thread-Index: AQHc8eMDF/zyflG8zke3pAg5dpR1SrYrkXfQ
Date: Tue, 2 Jun 2026 18:11:57 +0000
Message-ID: <BL1PR12MB5144AC4C3E48C6FD88E7762CF7122@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260601162336.3239363-1-sunil.khatri@amd.com>
In-Reply-To: <20260601162336.3239363-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-02T18:07:10.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYXPR12MB9425:EE_
x-ms-office365-filtering-correlation-id: 84aae06f-81e0-4e9c-e0fa-08dec0d26f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|5023799004|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: /TY1Zf/PjjqAULs5V3fVs//WHbm5gXIU8J8CV9heut7Zu+SHb98bY03lcdME8X6Nw2zbmCi2pZEX5Cn/pDmnTexHUnzvNOhE8YltPcGN8K7JrD+GozD7UPWmaOl2P07l4LY4AgAqVFfCybYI/Iyik3Z1ACopX8DOKhjCmHVFl49HnpB06biDCKsX+pdNsvhjjxeCXdq+A5U7GVkSHJyEoYjVQEP+d52T8x5r0YTSykM4vBATChkTruE4Yqa6HgOvHdJXYjsYF+3fBw+tF6LFjhJUezoCCDKhHAVYZj5FRs1V6DrapScCJr9cy7pnljq3ZP/VuqHB4xokTceeP5i9Np4AWNAu2lT6sPkVlPPQKQUcQsrLf/7qZIeGOkpvGsg+c5olL1LytKlT/7FaxDKSPc7WxiW8lWw5U2UcXSI8FjFh2TVUhbMvZbfuV65N3CbADPbClD0e0VmC/yLlu/qyjAo0zsiKUSs/ittceakAngxYnMqe0ZgaYttEgLR+HYcrhDyxF+1IZ8vinbmydLVxhqF/tChZ8OdHpkCX1ZjlO/BBXS/Qh6jlWjwK91+9W5zqUIWOhVmEVc3HNAmUtIUwo2ekqS2M/fBXxO6ieiGR6tXP9CR1rRE8xsJtddqZH5DmXz1MKKsg9uSowfCttKUArtU/+qvv7wHm+QonkOEUAOaYtCA90wglBSvJzTfl/arIZmrqbNvmp0BUPrH8MWskSEs8CmifP6jJ6cfXiDgnPpwx0BovfmNXzTumM/I9jxmo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vd8m9457hXNCRJgCwFdAt/1nMTpciqJwkdOSgrPow/PsdlX7GdXL07x+ZDQT?=
 =?us-ascii?Q?CHvjKEV6rKa2LZzxCe4lpmbbMypCvoh/XrZhErW0J8zWHPmXuwgPl4yIWMam?=
 =?us-ascii?Q?q4GtM6R90TKxPXaPbmpYQLALDUNER8mamu2zpm2bvCUnHIyxsVtlnyXQK90j?=
 =?us-ascii?Q?NBr6zNIGSQpz9r/FQzks5SliJvnAJV1RYNU7VJOCDSE17D2WWzIF4NeEZHBg?=
 =?us-ascii?Q?nZ+vDfLbDZ67aGFpCifMONPgKdrEN4ZmNRzZsKUJffSL4fZUOSNquWfIFjLy?=
 =?us-ascii?Q?HwOjaThnAb6wN7UpavzAJ/GVUKHa87b/Hcy9/2Azio3zY2724LQyAPdxDjYE?=
 =?us-ascii?Q?9Adoges9xsD4oyfefT4Yn9eaFEDJK8xZA8lVvRJyGDIW0fk1pyRcQYUxRXHe?=
 =?us-ascii?Q?L/zeCu/59XA9Eip2gyQzar3HYNnIn/ei3EN4x3rA9syOxHF+bDEHHbYkRnEi?=
 =?us-ascii?Q?tfpTd5ZsXcyAfa6M8H0VaDoOiZtbTAikoystw+nkz2yH3/3Oa7DFZQlbq9Rf?=
 =?us-ascii?Q?KVcynHywOAt2f9RGXO5jKYXmWlOGqz7tYRVfQZfz1cdkWwuXIVbmRwiGxJ6S?=
 =?us-ascii?Q?MvLzQR3b2pV5geTr7fOgv9BPqAnBsxiNWGzHhaNUvFXTr3FJBdbXL61X1laf?=
 =?us-ascii?Q?rQV0+mi4crP65RGzQnfQJROQ24ZzRiidqLSwqtF9wh67tsBgv2a0bU6m/vvW?=
 =?us-ascii?Q?KDUIvjH+0raTbV439e9QwHe4gORp0sZJ+0JA9eYTS5G9pCeSuwVashhpeVDA?=
 =?us-ascii?Q?7DYVNNLA43BEDLw/yK1NSMzPDZMSkUOkkUOahqlqmWUvJ3dA3etvKGzoUnAF?=
 =?us-ascii?Q?tpCyBYCjL4S+Kghf4qIXwWMSvteThElTkGRvzt939OR9hUa9OHGEoco/DHyP?=
 =?us-ascii?Q?vZLrw+qJiv5CKbUzLnrIYoLGPYY3L9dMJB6Bovy0hVEVg3wnwn+Wdg/QqPwo?=
 =?us-ascii?Q?KsdXZaCQXJMk49uofxVcsDHhKQdSGXMnM6iOaWNRU5ZiC2BX+ucKQw5jIruY?=
 =?us-ascii?Q?BnPD7BmrhmbNuZupDQeVnViVHqbCgTjSoyY7wowf8W5aPCaUOok7FsKit2V1?=
 =?us-ascii?Q?jpttDtNjPIeDjopTruXNrJMAy0SQybZ+TrV3YcFhO8t9O8LV2oGZLlqQ9Rg+?=
 =?us-ascii?Q?JSG/r/S8+iDfSd4y+oNSa3l/FjcDOAuyQHwORZSbdOsgYprxVpTiXxw9jWYC?=
 =?us-ascii?Q?f9wPKC6acvI8nC+hSC5trSjvRT+vm4R/1YiOAbOzSDeHfiwy1AlA9/cvrHbK?=
 =?us-ascii?Q?HnFsaH6+Xp6Jwvlcd6j/jYW8dMUV/UemTw519uXjqOP4LM8qhC5pkjQqKPhv?=
 =?us-ascii?Q?fUaWWjzgRHs70CmtyKuNF0Udf30FzvW5W1GGEObDd9nfhKx5HQqI7536EbwL?=
 =?us-ascii?Q?kWrrvnJspl1ThMVJV4ci0Zz0oP+QOMOgCERCwRHVAiZ9CPGIQK2F0olw8Q9t?=
 =?us-ascii?Q?0HI5Pt/ApeNQ9zRFOJHjohrjdbiFMpp8p3N6GxPWJ52J8s3JhRD089v1Bl+r?=
 =?us-ascii?Q?hHSetRl256gTzin9r+inwAhGvm+yCPfpdHSz3kPp/8IzFcX2wZZTnj9oAPEZ?=
 =?us-ascii?Q?iAvZMrXjAEk6zsFgRr6hgTBTnADI/Jqgin8yINQim0xLyrqZyu45uWXWf9fC?=
 =?us-ascii?Q?W1aADOY/IONh3uYMwWPPpqK/uJg8KPELbLUmUdyoYZIdWsRI15//89Uq+C3T?=
 =?us-ascii?Q?8x2zi7qKL0WvIE4T7+04e/oO2cQG8GqYw0eKOtA5XixJqQtv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aae06f-81e0-4e9c-e0fa-08dec0d26f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 18:11:58.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvqM4nZE3dmhJxPMwsBFfektL2yVaANtfrwiqZxUF+7VLBNmc3Z71vJt2qJXzEc53iArkKrX4UK3zLr8eqMkgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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

Public

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Monday, June 1, 2026 12:24 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: validate the mes firmware version for
> gfx11
>
> MES fw should report the fw version same either read from the register or=
 if
> read from the firmware ucode. That is not the case for MES firmware and w=
e
> add a warning in case it is not same.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index c9467b26e42c..e5e1ceabcbc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -781,6 +781,18 @@ int amdgpu_mes_init_microcode(struct
> amdgpu_device *adev, int pipe)
>       return r;
>  }
>
> +void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev) {
> +     u32 fw_from_ucode =3D adev-
> >mes.fw_version[AMDGPU_MES_SCHED_PIPE];
> +     u32 fw_from_reg =3D adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK;
> +
> +     if (fw_from_ucode !=3D fw_from_reg)
> +             dev_warn(adev->dev,
> +                      "MES FW version mismatch: ucode=3D0x%x
> register=3D0x%x\n",
> +                      fw_from_ucode, fw_from_reg);

Rather than a warning, maybe just dev_info?  I'm concerned this will genera=
tes a lot of useless bug reports.  There's nothing actually wrong with the =
firmware, the version is just wrong in the ucode binary.  Perhaps reword th=
e message to say something like: "firmware reports incorrect version in uco=
de binary (0x%x vs. 0x%x)."

Alex


> +}
> +
> +
>  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device
> *adev)  {
>       uint32_t mes_rev =3D adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 93990d4990f2..fdd06a17520a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -441,6 +441,7 @@ struct amdgpu_mes_funcs {
>       (adev)->mes.kiq_hw_fini((adev), (xcc_id))
>
>  int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
> +void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
>  int amdgpu_mes_init(struct amdgpu_device *adev);  void
> amdgpu_mes_fini(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a926a330700e..0db378d126fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1686,6 +1686,7 @@ static int mes_v11_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>       if (r)
>               goto failure;
>
> +     amdgpu_mes_validate_fw_version(adev);
>  out:
>       /*
>        * Disable KIQ ring usage from the driver once MES is enabled.
> --
> 2.34.1

