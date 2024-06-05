Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BC2C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537E710E70C;
	Wed,  5 Jun 2024 08:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1V/97ok";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE5F10E70C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNkqHEprYPqeuql4E3fZExhoPGd3/rkCGisQX+ZsYHEqPDpor+rYwTREYQit7Hh7Z2r5+YoAg2L2zLVoymO3Elyjt6zy4Q4zv3dV3GSQwdc+i7ESQUKz4XeIJDRWsFeFUz+jfYlja3Z25tbGX5/5B+HypgiGU+7NxumpOBy88aGG0mTPx5aLRbm/qqohftE79GHbXQuDEvs4aJdkMEPQVvmijJ2z1SIr0XY+c9L+WNe0atsHDSk0RNlCEEs4uUu2Aw54biSare9g/x2s52NzZPuD0tNDmToXdPbpoLDn3IM3QBhTY58uZuCfIbp6Hvt+N8zmUivC5Bu0Z7J1vhFcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJXoC35Z8AfanOzLu4+7EUNPSJ3LfEo9oQDNZ34r/7Q=;
 b=QCSw+dSEfiUVYWcTwIGoTiqXTszu2cYoNMd0gotJqbFj9GoYjMd1LZ20045qwdgp7pv9dBZL4huMbe0BQyCPWASXZvMrPHfH618Tu/dgM8Ppg3K8mqj6FsHwQ89TDMp22gz1blB7sjmfCQ1fVwsScsH9VFx+RZZJ38sqqEKGGaBfFlHQu0OhnsC1Sbv5913TVyfU2g52oLQiIblZa+D1mDq76HktTl06OsXIQ+QerDi7LLahzYvZMq8P/eFpiSo5ixeVGTXv9wY2IX5atdrZdgFfv9eTKu5FEx8qi9lCgLlnnWq5/wtJsEE8SgxvdaqqFNimoOeOXYPkmJIa+DqRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJXoC35Z8AfanOzLu4+7EUNPSJ3LfEo9oQDNZ34r/7Q=;
 b=D1V/97oks8rlJx7tq28P27B9TV/jZZWPHa3TAPNLarbIoVWokZe+RBfhw9IPkzi6fFymeQYTdLGwuNBtWCm+WcyUyqS/PWlCbXaLWcvF6Sv5vRT3slP0tnm9Ow55wcAKYzWYveYMKCSjxuL2igU52ROjIU3jt1aEf0SlDJJxgs4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 08:38:58 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:38:57 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/12 V2] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Thread-Topic: [PATCH 1/12 V2] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Thread-Index: AQHatyMc9fSJOulDbkSzVkTRM7WQ3LG42PWg
Date: Wed, 5 Jun 2024 08:38:57 +0000
Message-ID: <CH3PR12MB8074AA56E67F73A9CDFCF1CAF6F92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240605083347.3216852-1-jesse.zhang@amd.com>
In-Reply-To: <20240605083347.3216852-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=84102ad8-fcdf-424a-8866-4f48b1975d97;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-05T08:38:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH7PR12MB5806:EE_
x-ms-office365-filtering-correlation-id: 8824fa09-77cb-4d14-e632-08dc853af0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?voqeIhbhHGxUIA7fFUzfVTfKmhEP+TzevJL+AM5s6HPKIi7az8lyQuDfRY?=
 =?iso-8859-1?Q?JdkcJmWojDTQ4XxMfeBtdkVE04xRypjQAlDWxSV7OrWXYHq2SIJLX9IG88?=
 =?iso-8859-1?Q?Wi+5y9/93mCKRCKeDbcz62PqmwjC8mHEAd+WVFskIDO8gmXWiEVLzdBrHP?=
 =?iso-8859-1?Q?+RA14QNoUe/pIMQCwxwd+w9iAZt2gqRLb9SlWtae2cmzhTfbbvzrzWyMav?=
 =?iso-8859-1?Q?ba2iLWdapZbroYsxU+PNs5irDYM6FggICfUv6eOQ6MCirkYowjHxs+4aFc?=
 =?iso-8859-1?Q?VAf8/f9jLhGSJW0gDKtVZR5xjgXjP7nEeHSDjnQ0t2rMvC03R7mHTLjfZs?=
 =?iso-8859-1?Q?GIlOOvJgkb+ZKx1KKENw8pUqkd4vRSSEuxbmwkfDh6hq9B3OC6qIray3mw?=
 =?iso-8859-1?Q?4wFaiA1ZNMHNCh/KBuT2t+jUbFT+ZhQ/0IjSHydKDH11K10ujVe0mPCIBP?=
 =?iso-8859-1?Q?LemkGfHto9GwddvtNwIFI6nMyu4BgaEQBhx6sf+cWh4uRp5Sm3C86iMVwt?=
 =?iso-8859-1?Q?gijz3oOoSsky5LkpjYiCkufEXVm66VDDvhwNa2HYliXqQPywTxL3vAsj+p?=
 =?iso-8859-1?Q?EmqU0mWpyV66pcjLfFQHu2STpcVYuO7dOKjmrO9N2yDtLU4E4VGdCA24/1?=
 =?iso-8859-1?Q?jWhZvDD+lmbeSbTCet6FrrVc+QJSLfZTcdG/gtd4vCb0s89p7Sz1vynAl1?=
 =?iso-8859-1?Q?yAK1DcRgKTZR2DjH6I925T66RBdBuE8wY/n1X/sKMlOgDSIIhLPs0RcgUQ?=
 =?iso-8859-1?Q?ewiUpSOLY6w15EWtdl8IPm1zUcJmaLZO9J0SwNXWCMR5OQGvsenpqFDyMf?=
 =?iso-8859-1?Q?+filC6pUu6zDnFmHHnNl5LPRC4USUw2duv4L5gP4fUA6WTOgd55ab8iF32?=
 =?iso-8859-1?Q?2LOmx9aNZ6r/yX0pN8AV5x/LQckOLn4J45HCGc3sysIX4Pn+qIuD1KJy+V?=
 =?iso-8859-1?Q?HwAgsYTXVhf3aO8LWPAaeZQP67U9zDM8P0AULP6n+qjlnlmSk6REQYG8lN?=
 =?iso-8859-1?Q?nmiynUhvofaQWFhwMDA/GCmylEjQNOimzQ3fMbCo67To7InYXq/GQ95H8F?=
 =?iso-8859-1?Q?19oq7aEoNMaoXS9f6jotc+rYJi/LEsSZRXZsga7/g3G9iParbqVl+QgYTA?=
 =?iso-8859-1?Q?37KFMevOVz8Zr5ciU4d4zJnoopZh8QGn3VOHv6nHhDcz93sQcQtgW7fZAn?=
 =?iso-8859-1?Q?d07vBSQSgDoLdF+aOq/C5y+AmLHZML+5xTlcX9IGoSTD5FvRHtpUffK5Sz?=
 =?iso-8859-1?Q?/DfKkAvEBLSlKp/Z2L2BiG2VJeTHjX+hnON7LIUgkrYBj2BwpzKGVaUJeN?=
 =?iso-8859-1?Q?DtOqWCWFIo0OVwAKmO9hK0vc9zdL++zXNpeOoySQcEVg73lIe+1IUc2zv6?=
 =?iso-8859-1?Q?76Q2aGO86k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AXny5Z4IC8rWUlWH8d6Zds0Fe1fgwy4wDsYcqcuWcggqHbpx41OP//wQQN?=
 =?iso-8859-1?Q?e8sL7fjwZdUEVA7SSnbmy2PbrHCmZSABOWetHvNXuOlTXy581HrLOsXlyp?=
 =?iso-8859-1?Q?HVWXlgMc30WB1Z+eizrSfczGZJilBYSE2KwAIWLFx9kNLi9Y7mSFQDQMNb?=
 =?iso-8859-1?Q?Aq8hu1Jbjk8H5oQIh6578IBmO24Qc3ODAi3glOOQE+JYc56U7la9bkPf4v?=
 =?iso-8859-1?Q?hFMwoUjZFvYYvhJc82Vui8xBTJp5BQ3aCgM+6LNXSrGU+JVZboUvn67HTV?=
 =?iso-8859-1?Q?KeqkOdbyp9xCtAIUmlAUxOtV7aZhj2+gPhGKzCPvx7B635AJVc1HdOW1VS?=
 =?iso-8859-1?Q?CC4w8thCLfCfFo8TfX5MuT+fNoVLowS3OIQqHj2x6/62fhICSA2PHl6zUo?=
 =?iso-8859-1?Q?rzu0Np+jUWLkd67AuFdPKx8OTfh4sh4y26bbZKGCR8j+5Enabxf31byVsH?=
 =?iso-8859-1?Q?uDqFR88/vDfjdvZNiYq9uIEi31OJZC/n0CAxNsbnBUuiStHywmSiF2i7LP?=
 =?iso-8859-1?Q?8MGIVbmObXPOrOi3GqJayW1ooxBa8TvuUXq+IEwyn/VZFXLVO67ihfYXIW?=
 =?iso-8859-1?Q?O+k2lEtkyCR5E2aSxZBy0Nuxx3J81FWBPIRNQ1JZgwndPfto2I/eYIgKb+?=
 =?iso-8859-1?Q?SX1Gz2962ywDKxsQLgO2CULWUtTSS7uzXNgxq8hP7IGa/YIRJzp+Jhjq6F?=
 =?iso-8859-1?Q?RXDjexmhDNR2IS8/RJqNCN5CKXs7/5JgKsgIiCQ6Nf/r9cUwA1KV7r96G9?=
 =?iso-8859-1?Q?gHOT6B7+5yX7bDfiRbj22OqSq6bGC2BwK7NoeT5Oo5R8AONbFvQ3XXSsar?=
 =?iso-8859-1?Q?MklGss7T4bDz66UX1RIZoeRqjN6cUcu9ULzuy5Tc3hJhvi8DgFXvJFCHaA?=
 =?iso-8859-1?Q?WUVBebz0QgPYBp/0cvnnhb1Bg7GtNPEUkvPbld2ext0u7MV0z2wkjQs2Gh?=
 =?iso-8859-1?Q?Pm60AGIgfOsoEahG7gSlG16X0RpgnjKpHZKl8iDffEjQy12YtuVANRXOaA?=
 =?iso-8859-1?Q?1g4ADJqRuaHibj0iVe2i7fFDK7iu10LuaPqddIxKOj4NIcZlsh5+HLkp/f?=
 =?iso-8859-1?Q?SfjfZN8NJn+vFhArnXxgBEdt6XnFWGnb8A8ILIp7Dgz50LAYww+o03cSku?=
 =?iso-8859-1?Q?f81UPm0wxgKycV84JDuxjJ+ff8zOD9bKUtJhdt8zsSqUFvt3te22FsgWLn?=
 =?iso-8859-1?Q?qYvFQ05GEcki27BlQu7DfZj84NszteTerigQqMSkbLMGfjR675DN6q/cGk?=
 =?iso-8859-1?Q?a1EYB3bdUWh/YFmG4NLNrVzddTvtfk94L2xY+8TwgeqC9DPBWNqLLVCE5u?=
 =?iso-8859-1?Q?FYhfBpqwmtqDpZ45zcIhKMBQqpSzxFI8b11TggEbM5Eo1ira/UtYr4zwZO?=
 =?iso-8859-1?Q?CPTCYcFKMdMnV01T/SLEhnpzkE3EgHjTrpMHw6suyCuj9B6PofcOx/nhx3?=
 =?iso-8859-1?Q?+pnjsKJVQgbZU1Jp9OXBoKoU/GZgRVaNFzMLcjiF4zP2/4lDU8Qog0pPUy?=
 =?iso-8859-1?Q?OD966cdsBw05XvdW+gCRLT4kECVXXop7Tbv/GJnyqwAFhB34HpjZd02+x1?=
 =?iso-8859-1?Q?i/dnpK+6v2diAlwve+0SG/eL0hqjA2ORN8sDBOXtaB5L16PJO+8kCn1WqV?=
 =?iso-8859-1?Q?H/flAN3iTQfEA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8824fa09-77cb-4d14-e632-08dc853af0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:38:57.7584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1QSQcfwkhDlYCAuJmtPSF7BUNVn0b/afG7fOtx4XUWZKO7u//dGXVV8arfrDTLPKUSLxpfi8q2vqHfNFyNBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

[Public]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Wednesday, June 5, 2024 4:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/12 V2] drm/amd/pm: remove dead code in
> si_convert_power_level_to_smc
>
> Since gmc_pg is false, setting mcFlags with SISLANDS_SMC_MC_PG_EN
> cannot be reach.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 68ac01a8bc3a..f324a8ef8032 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -5467,7 +5467,6 @@ static int si_convert_power_level_to_smc(struct
> amdgpu_device *adev,
>       int ret;
>       bool dll_state_on;
>       u16 std_vddc;
> -     bool gmc_pg =3D false;
>
>       if (eg_pi->pcie_performance_request &&
>           (si_pi->force_pcie_gen !=3D SI_PCIE_GEN_INVALID)) @@ -5487,9
> +5486,6 @@ static int si_convert_power_level_to_smc(struct amdgpu_device
> *adev,
>           (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
>           (adev->pm.dpm.new_active_crtc_count <=3D 2)) {
>               level->mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;
> -
> -             if (gmc_pg)
> -                     level->mcFlags |=3D SISLANDS_SMC_MC_PG_EN;
>       }
>
>       if (adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_GDDR5) {
> --
> 2.25.1

