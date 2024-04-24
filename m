Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF9AC10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 18:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723E210FF7A;
	Wed, 24 Apr 2024 18:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lqstonz8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B39C10FF7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 18:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kli60WJglZ+Lek3rLFvk8ikongUP4JWg3S+9moH8deKeZhak3N/0OdxQzrwHzrMJkZdvTnwzt3/4BAK1dScQhKOHeaNKqYjFGskq06MfTvJVyli2dA+B7QpeA1g84AVlCaL/22SxEVOTEVXwsMZ8j2oP+Q0UC0bKbgBhuQnn0re+ZjpLbymAqh2DnhFjqYewzx1BS9ORwSudFVE4v75s3XvBMNb9OLHKTjZZJxgG+EtAUnTkY6YxwBEBkW7T/2T8V7gnZZPNz0//wKHkW6//vZlb3H36CHafDOlp1nBYiFLeWUMGq87xOtzINk7NbD3fAUixz6pjF/+etxoYOk7KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL47ADeaTUi/qlE+eHpmR5WiKELFdkqvClMBjfk5vGc=;
 b=dw0/OiMnByj/0b/K1GB/tTaJU5LmBcYLDhyAV6+ZsnFT+amrTP07nwmJc11LFnyk4nfArTXqD1fglVnQXM4hjV8Gb3Q6P9xbm5bAWg5UmXinifdb3vywfHUJhKvjJhoOWeNyt5AbzdNV6Tkm4SeYGULBR9K3vNRZ5HZbueOh/MoQ1ngHQ3Qc0fW8sg0uOwzCizqU3DL1jf8qYcUikg/y2HDZgA788A6I7YZCXq94T6uLImVnedg4VHUcd9f70u/mXhqPZXKaeV8ncoxKKPRq/nMOGZyRWqTgayUgyl+jfuzxPFST+YcVVLYvEFLb8F1SZgzaJ8G3qpS27QRBkVFwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL47ADeaTUi/qlE+eHpmR5WiKELFdkqvClMBjfk5vGc=;
 b=lqstonz8AL4FmB0e3VXyJtBWH7C5WyDu44KzeY59QkuI0a5pf3XmOZLIrAf9BjTsgwocjGhLZvjZbsDulo/x66H8li0wtVpnyOPTwAtIBgag+ISdmZbRA+SFZxlvLEYMhJ5EGWIx4r2lF64DTq//H7cXEfYdk+PEWu5WPJRSYbE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 18:17:33 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 18:17:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_afmt_acr
Thread-Topic: [PATCH 1/3] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_afmt_acr
Thread-Index: AQHali688/Iv2WL0RkSD+xYQcnzgRbF3uq+w
Date: Wed, 24 Apr 2024 18:17:33 +0000
Message-ID: <BL1PR12MB5144760DB5E060CC5285A17CF7102@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240424100343.608218-1-Jun.Ma2@amd.com>
In-Reply-To: <20240424100343.608218-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d2e0fc64-cf6a-4fac-9fbb-b63a44b5e497;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T18:16:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB7931:EE_
x-ms-office365-filtering-correlation-id: 0222720c-5924-438c-cc33-08dc648acfae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?QzwEaWQryNyS9GILmYZ3R299uuGRoZ1f0Z9qDK1kO1MfRb/++d4QpkAu9+us?=
 =?us-ascii?Q?B61+CDZB1pN8fJKzNGYahwiur8gjUJlnJX5IRjEgGDViLMCiZtossS1968+J?=
 =?us-ascii?Q?0rvjLsftiKUIhXLHDw8qgqqPsip2wWXRn6pXYw3yfHyzoC0B6YPaMs3mbWNZ?=
 =?us-ascii?Q?vAmClCysJzPlBqSZP2K9/0BdEPLZ1R5XGkBsxRW/tEI/WPq3C35jqp8MUUgD?=
 =?us-ascii?Q?VvcR8xiHaqaFF10JzhMlINTdtF9R+m6AkHm39dJmkmGbcoqY+TQnxS/f1KBX?=
 =?us-ascii?Q?cPFQzkmZjN+dTr+4W1AwsxO4Uev5G4CR+p3pUNeQYIrvRNwwIwdPlWa+9Ish?=
 =?us-ascii?Q?jbDtejfhWeOSHGrxCceNgMm9huQu3IbBJdvpq/Dw0XGvK8rF0GTysCn1Pnc/?=
 =?us-ascii?Q?/MHkvk/JuABfQgxRUBVNDPZrXzKghFgy86WGDWEmKk8ADT9ybZw1KRg+5Mnk?=
 =?us-ascii?Q?z9HUxh+lHXWjjwl5ySsvSOJGrRwd9GGi0ZfwImDlt7nGgYXaTxdJG913hRBA?=
 =?us-ascii?Q?3dqBvmbDvtXNy6Esm/pb4jCCnd0eCnU1MhnyYN/YRcwzuDnWdxdA3/lhX6lC?=
 =?us-ascii?Q?dukW2L6zsQR/sgvNAIHBBQ3/7B/iWx2UQO+RoL5C26V3JxKPnV+2oO4LQSkP?=
 =?us-ascii?Q?tyCGhThm9M/ENJ3rXqIik6JYaiR5GDcvq+ePFt4++YiYXaENsR/0lO6oJwHc?=
 =?us-ascii?Q?hCiqq8T4N3CXQCmFox1PmE6x4GcvmjCy84FhDW8HiCTFYx8O4jP05zYzWSp8?=
 =?us-ascii?Q?ZRcIZBJhkUCKGLttAScTbqCe6p1DmIyJi8cUo7qBIAKM4vSQdU8/5ioxEsAv?=
 =?us-ascii?Q?fUGTnKEOD0sVe6wuxrjtEKlzYf5TnahwnpsPAcRp19gMK4zwijCUQDm6bq03?=
 =?us-ascii?Q?DKeE23vGFp9vV5VVCH8HpvINN070A+JLlswiAg4an9yv0pHmBWDGr1oNceLg?=
 =?us-ascii?Q?vD6SDQtbLXPYFc5LfvTVsctjz8JE/L8yAJAb+dDtT1xeZBcdlzY0sTHHc+L8?=
 =?us-ascii?Q?y/doJziHIl5hEs8fvSviYfVH3w11l07g6lE1ewmU46ncXx0JkpS+FhqLo4ym?=
 =?us-ascii?Q?y/PBdRC5nQbJeiOqY5v+F3aX+KG08XkqrbhB4uGCLl78CE/EgNy+PTEwrkzr?=
 =?us-ascii?Q?wELWYqW6iNaoxuPVEhdFGAqI9prkc/CT5ouA1qcBUEpLYmPbVtMREGcEygdy?=
 =?us-ascii?Q?JemmO33uRKDMvK/WUAz5gDMgMVJIETDlqAzEVBpyX5YAQj1V0vqUC3F5imhx?=
 =?us-ascii?Q?kJodWFU6PwGcU51vLYOgmrSWzfsPJZjbdreMYft2JZLpCN7J6Uffl7ZA768e?=
 =?us-ascii?Q?nYn9GbNXWDxIa4xTDmBmStrASpEvmK0meP+E4490FXzfxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UX1GAFRBO7DPshTHnjWP4fTIuZxqGaVA5nGQ1qpzGp483kS91/EGKcO4Aln9?=
 =?us-ascii?Q?Fc7Rb4aUIWpt3KyQyw4fjr4M58D6D01ma+horjRxBYIVHWG7QhFsA10LX7sA?=
 =?us-ascii?Q?TUxr61d9QFkcNvaWh5KFcK58hm5uM0dCwB5Soa1OzNG68ImwceDGhC//kpbP?=
 =?us-ascii?Q?UDV1qbdznDfW9+znmS6r5yg7m9eM4gT5GR4LoaZ0uxaHV7UEpVOqDAgfFoCO?=
 =?us-ascii?Q?CcXZW7YpfVW3VJrbJx1VEAio8Mo6Pir3kalz7SKvFo+iTYxrcOpWrP5mQhFt?=
 =?us-ascii?Q?utj+Y6UX+vivu4aR6L1PegLF/iX3ekOLUyG66BY9ahsGtEVda6G22cuv8cmb?=
 =?us-ascii?Q?LdMhCfU8nXKTO86c4Uce7YEYdAKHWHnWMkut37+DAx8E7XW3Z9/RsM6I3FxJ?=
 =?us-ascii?Q?UtL6znq1Eph2Xpcu2UZwjJhW4QelAZQBc84SUtrWf/yLLKnCmnEXzDy3Mu24?=
 =?us-ascii?Q?+UmNyaPiHabD6iu5gghDtyf0J4yc8XXmG0XGyHeBam29LxLamQUNLunWNq4f?=
 =?us-ascii?Q?toO/DO0b+VY5XVjBOgkWzPBJPo72BiZN1pRvTwMwTyfGnHo65LKUBnSNSuik?=
 =?us-ascii?Q?uJbd6qAkY/QIib3SOSrK+/JDv8asqmHfe5IW3El+mwNBd8ZnD378yFNyk3qd?=
 =?us-ascii?Q?iVfgPXIAOyMsxcVGYP83W5rcyf2h82OeJbUVElS9i4xwQm4Z4+uYYTtTNGlt?=
 =?us-ascii?Q?MARfNS8PkX0UbKPY/V6shlCuE5Fbyn/+PGRpDWPWMFTCHwBvJEwyR/us1WtL?=
 =?us-ascii?Q?iPm9CMAcomfArYRI1ynu215dK4/lp0ROtwPhe0uMujhZg4IgRj0qv/ZnNPgw?=
 =?us-ascii?Q?V4Oa25WoWbqPuKj9zqt3fYvtL71msdLhJF32529H0ozTgyUFLqxSyQ9bimbt?=
 =?us-ascii?Q?D8cAV911k73YXyLHcP/Mn06afta97ScsOh+GNDtjf6WNIAKDTZz1rDBTjQ2q?=
 =?us-ascii?Q?WgVWTSkMZfEOpULvIp7jgRl0omfQYPAhJcqGC7zHxf9ZFhgk9CCuyfbiEAZh?=
 =?us-ascii?Q?8Ut/K0fMkpr5VdoaRW93uJKcKo2epIGelDLc26eqI+PwupzZJttAZUJ95/ev?=
 =?us-ascii?Q?lC0+bJg5fI9S0tVJXbHainaWrRoTg+g/k3242Q/VOjJ83TSg+nHZDEko+Uux?=
 =?us-ascii?Q?mcM6V7eha61RcQ/WIfJTWyI/ybYbH4I3miEHluuDEYAyUDoNvOfdCPzJT8lu?=
 =?us-ascii?Q?WdM9bc3I8t+r5GfjRp4UrAd/MoI1Io08zahSBQ+Kf9dikp6VZ0d3XuyQd1cL?=
 =?us-ascii?Q?+5tbYs9ezoIIKi7tRjVaH92KM+FIINwEMBVIDi/M07Vg2TUSoDgDXN0qsRcx?=
 =?us-ascii?Q?7ySubLLFItPWulwufWDIXI62yRD/6LFLKttkuJP0tPHNW3QOFoT8lOVpXnEa?=
 =?us-ascii?Q?tBKQ2IIKxr5QBNV/c0BYIkDRy7LP1e3hFAKDXwnk8KrbFFlV00blxV+7abHd?=
 =?us-ascii?Q?G98+wdrCcVzMrW6y7pTaMTnxJGEUh/imuxCTwfZoCvAc+j7OAvsUOl9GlpXQ?=
 =?us-ascii?Q?dh6dFXT65Css7xq1KCGqSDy/82oi6HA1VkOvG5bIqvhIdWw6GSU3xVt6IRYk?=
 =?us-ascii?Q?QrxE5qH2EZAmeTfIUZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0222720c-5924-438c-cc33-08dc648acfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 18:17:33.1786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJmRvcAqE02ciEuNi3I1phXMMdxJYmxZxfgzcV3gib5eKd91Ad9AuC7NDtBGqhGdTu7lULT2NKGvQ6TBHinZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Wednesday, April 24, 2024 6:04 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: Fix uninitialized variable warning in
> amdgpu_afmt_acr
>
> Assign value to clock to fix the warning below:
> "Using uninitialized value res. Field res.clock is uninitialized"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> index a4d65973bf7c..9e3442b2d2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> @@ -87,7 +87,7 @@ static void amdgpu_afmt_calc_cts(uint32_t clock, int
> *CTS, int *N, int freq)
>
>  struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)  {
> -     struct amdgpu_afmt_acr res;
> +     struct amdgpu_afmt_acr res =3D {0};

I think you can drop this hunk since all of the fields are initialized belo=
w.

Alex

>       u8 i;
>
>       /* Precalculated values for common clocks */ @@ -100,6 +100,7 @@
> struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
>       amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
>       amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz,
> 44100);
>       amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
> +     res.clock =3D clock;
>
>       return res;
>  }
> --
> 2.34.1

