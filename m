Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A7FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE15A10E412;
	Mon, 29 Apr 2024 06:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCJmT9Ez";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764F810E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK5H2mks1bXsd9V5UCNu32ttCY2Fw1uh1FhZbPntrCex1iA6TswwrvAyPglXgOKroQtM06opwTT0OiNSyZ91OERypp684H5ifwFkrg2QjL7CQVclSF4VcX3VBquTqbcKeiNhRky7CYwu4PcBZVhrMVuC0urDKyl6U+TSXh5d2zUeEIV1VEMjb9QtchzUstUPq8EkfdedBOcX9DWjA7Taj4jaOWnSv7oQc8Kvo6AloFtUQ+k+EuH524lJIsqUHWGY7uKb8zX251cgWEXLPyzMVRDN2wi5xjU3Dm6qGu8vygNSGVRqRAYASFmG4LyDerivpUtpDVxPtzPmMnqFNBp3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oW8SQQcJJFuetKmbVk0noSDQkEwbV7I2okjcCojC5I=;
 b=Bs7ORdqk1J1zeNze6i96JFGnHOqX/OpU8+x+34HZBF9089WxPI2fweIkXAxMQH/QRawZsliS60fnHgi0XjAigDbq6I10ZjYgw7ZoWu1QTi2+J9HlEFKfdgpbaMlTEl7jp//CEmbFStHRTP1suftuvVW2cCWNUP8jRwdbsw+FPt5gl7DMz1Shxjg4TEzPBs4Rv0XNluZ65m/ggNVlHcE/uLJghoyCb3PpstrDlEOFjqyIWFmDjosCbERFfuM802fU8Ct4Namuietn+z2BQijidW4gJCgBdtxvgVH5peFwwDZQMjLRPkM1+2HvkZIruNTc9vcpWzEOcbEjyVIcn25NOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oW8SQQcJJFuetKmbVk0noSDQkEwbV7I2okjcCojC5I=;
 b=NCJmT9Ez+Xse0gTvchWKi65soiTu6u5Uluxca63ZWetkhVC9eQuTGmbu+7f8njin/mhW6PUCQf0y2z97HjCRD5U9LeEHLXIA1yVtJK4G+OJYYk1+NS4vRmvcEX7RuaQ9xdFs6GT2opJgtQqZ29FGlW5qat3wJKOi7nHeTS1wMtM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:57:53 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:57:53 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Thread-Topic: [PATCH] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Thread-Index: AQHamd0AkGxoE1mPe0WLwMktUUsnBbF+0LxQ
Date: Mon, 29 Apr 2024 06:57:53 +0000
Message-ID: <CH3PR12MB80747C03667263F3068A8216F61B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240429022854.2060744-1-jesse.zhang@amd.com>
In-Reply-To: <20240429022854.2060744-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cfcfefb3-85c0-4b34-acd4-d4320772060f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T06:55:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CY5PR12MB6478:EE_
x-ms-office365-filtering-correlation-id: 9f9fa201-31a1-443e-ed3c-08dc6819b0e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?eEh5lBHw6kZRhZ2RCg/e2B1fDariD0jYoSs5lwOUrJnN4DEhPUMi1N6JyAr0?=
 =?us-ascii?Q?T3gNO4qt3MI9j3w+Cqks3c5QkQfLgTLBsP9+IG3Oe0FzC1rzIFQw5s9IjE7M?=
 =?us-ascii?Q?CIUeySptKJRTnvwktsGT0L6GiBxKUabp/ABgnTlwroxbDgQCQK+i9VdHI7KB?=
 =?us-ascii?Q?OQauEyUFSZF5mWmNNG6ZeVO4R8GFcJOn2rAMPLviVxgz1wcLVAd4VbjUbH9v?=
 =?us-ascii?Q?8vXYULwtsUrrXKuqlfAGMbCyd7Tj8Tos2E3TosLvNN5vw0Xp7euKmKbVVnN+?=
 =?us-ascii?Q?iKrNnrTM33Lt0JuS090RPwX2EvLWMkJA4wqdLC/k+JMtz/vl+JGHvaxYQcKO?=
 =?us-ascii?Q?yUuLNLzWOQ8IqxuNTBYQu34gE3lBWzvwo58FN6StPwvhJaGIyCtUUBTJXwDH?=
 =?us-ascii?Q?Zba6hM/J3yKl81n6XkHbfiWl2yBv8SMGlSe++CyCghm+dcQwYxD4ZdkCrR4n?=
 =?us-ascii?Q?4LMS868YkEJS2o3lAjFGgn6w7uSSMZN88TlYK2Pq8KtB1x6n8E9kOdTHLkC7?=
 =?us-ascii?Q?6SvBnR+kZZNtK6Z4UmTvuE8dRCGEgo4SFCQWGGnUX48GvuV01LvqPYHMD9G1?=
 =?us-ascii?Q?htnwxG8JJzYRXByH47MAdCYJ1ADGrPDP8v6WOB9yXI6siJ7FurbtrlfJ35uX?=
 =?us-ascii?Q?PuN0fXQMRfCeLPH1SXAK0gmVajP3UNnPqN89PtZulEGAViAz69R07AEBkfnk?=
 =?us-ascii?Q?Bgl46b1hnnmmTdUnkzs9+cGdx8NAI9WSkdYcYV4oy/Vs6aHdmrWsGciA/mQ5?=
 =?us-ascii?Q?IV6RoqJeI5ox4lxqFjA3GIyf3hXCmGn+Sa4Hz3gQJTrfArgOfyOFh8gLRYAl?=
 =?us-ascii?Q?nW5cAKOG8i5iDoulsHk5+Tgf3+LtY7U0BVxPLaAVgsBTZjMSbZbPcqhlS4Gr?=
 =?us-ascii?Q?g0UUreRr6yetD7BFM4ujalHZWyQ6bTXbrzXmbNcZ6hKKKU3MLYnjpCFwfOJf?=
 =?us-ascii?Q?ROlOHUGfs8etmmfw4Jb+f/rCkwLp4Ye+i27LAyzukdkwrTsHYcT7g8W4IpzA?=
 =?us-ascii?Q?k3KexIS/tx2JhuvK+XJ+KnoE1pEHED4E94FhvJnkV3y7PyZiRYJ+1f5P9cEa?=
 =?us-ascii?Q?Nwu8IUX1NK2K0JF2Dktv6ApNYteChcyAfZVSROlgiylHfRVwNv8BVK12oO5z?=
 =?us-ascii?Q?7jNFxZxH+YpKymzqu2HcmkB4mhBx+QCAm/lgQyuEmJ215H4Ve8hTgV1q1omL?=
 =?us-ascii?Q?y4D7kyNHUn39ZS5t0ByLmjVzXL+Nas97CDwRhMh8O/0FQv/Yn/IRcFcI91Vq?=
 =?us-ascii?Q?fXm1cnnYcMYl3ASPyRi130ClmKlg/ds+bXJNAnfQHMOEQnzteDgGTPbDV3wq?=
 =?us-ascii?Q?9OKkcNicm73Cq9jl+u7aNDXKDlKdWgdzkpMGaF44yx6V6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qYtzuhmiHJgKUYyZmM3gTH8I07qsEw9SHtQU33BaZdv+Tdg0FM8cob9ijJVb?=
 =?us-ascii?Q?3KmOosBf9MIPmKSaMYdSbB4zW9IXxRSgTzqm21Qbg7Z+Gi/CDeJHC3oDQUK3?=
 =?us-ascii?Q?WKapBU7iLTWhmlvszxShMZbSg3zoPguFWF8jiZCVot5YhRH7LJzoCnnsUyRO?=
 =?us-ascii?Q?luDyl33XwRzqNUB7pQ3i3SlD8+eNpUcjcWA8YWZFL7LUFu1Ph7N9MRjFyf+i?=
 =?us-ascii?Q?7TarEdQ3BlYWCLsAiv8FPoTgtsRmMgQkjVRebn/ev9ezqAJZbK1aaJnQXPLl?=
 =?us-ascii?Q?eospGQcntK4MG3i3wBUb73YKX2naZ/f/w6RYHgpr5rZj0bcsqaFnGxciY0UN?=
 =?us-ascii?Q?LaaTTY+tk01R4v1m+1QDJ81cvuppgW2jmzE110XBoOpfX817rAFvLwcHUsDt?=
 =?us-ascii?Q?folzpFQTybFg0q52mhbNv+OEEmeJrBBJ7/d902e+8A1MttZ1M4nF6IShC7CF?=
 =?us-ascii?Q?u2tWU9QjDiNBqWckVyPh+dA2TqvOiLkT6at8N1Smso3KvZswRRpxMTCQLawp?=
 =?us-ascii?Q?clAlzpGXfTv8UdUFWbt9sbS+vWubtGEKKB/ZECN1Rw//OMVoXrhI2jGyM3lS?=
 =?us-ascii?Q?HUziq+LneSrZc0DHIA7FmD3qsNnfgL7FqA2uV35heea+IxMkjS2bL+RWpmaa?=
 =?us-ascii?Q?Q2YekXcxXk2Mew5h1z0e6FiB4PfzeexTpelNo8rlCMaOB7NbQH0yoRfBUxe8?=
 =?us-ascii?Q?EbmUYfNtqs0hHaDDTDf6hhh+8ZNexuQXx/cYdBrGoyIFT4iw9aeF/ZPd1ywG?=
 =?us-ascii?Q?a/EXe5oUYGMLamshLSVavV9qvpxymH9lB+U/Cz63uDFlr3dKnh5A/Eu+TaTQ?=
 =?us-ascii?Q?TzX7F5VqrmqHXvtmIGVDCwgQyCNXROytaDABJ8xP/cNGhWkdDJPJspYkt3Vm?=
 =?us-ascii?Q?6kbNoA85pCDc1YPTObTpK/pHb8sduAJwXqobJ7W1tvnb9VYWOAKRJKU/9ulD?=
 =?us-ascii?Q?sP/BRlYJfIusESQHfaUwe0UtGJkrSAHMjav1INlNntfZUEEyIgV3dYmfWcJn?=
 =?us-ascii?Q?01i25nF2f5XOX53NfCSG1uc3hyYcZ+kYzjtS0LdSMN7+6JzMBJZi2phLXonP?=
 =?us-ascii?Q?A99UfMNOGovK3R2dyLVfzL4Fq8W0MtUwgzTeEpt5Z7bQ14MQywzcSDRko5tG?=
 =?us-ascii?Q?HwDV3Cz+xe6a1aVDDhDekbO8lUez6tqAs5vEpmXEqam/WWtFqPktWYg3JX2b?=
 =?us-ascii?Q?IsCPm71ZlsqfgJDtrfSGzI5jNJTi0NpIGOVRQj/6aIUBdsejMmCEPT9Z7ugj?=
 =?us-ascii?Q?CiJYquBOaUYiCtkklzl3EH8/dDk+dTbe8dvchxvXsnX7I7odAvyjN7dF1wWS?=
 =?us-ascii?Q?hVnB7XRHtBPQH7AcK9teyNMrs9Z1f+7FmC7ujMk69+SWtwPNfcW2POFDS17B?=
 =?us-ascii?Q?o/eY/YdGUPh4WiHgguuUCNRKv73pzosRNxWR5kRFNE1J41O/Vcx9wUbtAIuB?=
 =?us-ascii?Q?EPPgEMo2YL5FQ4xMzLeLQawHX/M7Rhd7g4kLv7tGbcA6Q3v8VpO1GKj/cLS6?=
 =?us-ascii?Q?4KKknteA9oqt9zv09cabTqznSSclK24STorkQdeaxhK0u2tUj2gXaUjRPeP2?=
 =?us-ascii?Q?aAcf+Gu6gEcCx7LU6wU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9fa201-31a1-443e-ed3c-08dc6819b0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:57:53.0808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doZu2bsMFrS37MEbR/MBP3sXjWLeVnvvh2/DpFviscG+o+KatlkwjHSRJCQcDqS4gaOBy707pmn+dCwbWr4VlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, April 29, 2024 10:29 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: fix warning using uninitialized value of
> max_vid_step
>
> Check the return of pp_atomfwctrl_get_Voltage_table_v4
> as it may fail to initialize max_vid_step
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index b602059436a8..70c711cec897 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2573,8 +2573,12 @@ static int vega10_init_smc_table(struct pp_hwmgr
> *hwmgr)
>               }
>       }
>
> -     pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
> +     result =3D pp_atomfwctrl_get_voltage_table_v4(hwmgr,
> VOLTAGE_TYPE_VDDC,
>                       VOLTAGE_OBJ_SVID2,  &voltage_table);
> +     PP_ASSERT_WITH_CODE(result < 0,

Hi jesse,

It should be PP_ASSERT_WITH_CODE(!result, right?

Tim
> +                     "Failed to get voltage tables!",
> +                     return result);
> +
>       pp_table->MaxVidStep =3D voltage_table.max_vid_step;
>
>       pp_table->GfxDpmVoltageMode =3D
> --
> 2.25.1

