Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9099C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E63610E435;
	Fri, 10 May 2024 06:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjJHc1DC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D7810E53B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8p9TvnKjumwJjVS5B6zolqlEiviuZzO2N4zmp8lV+ez2IWJ3RNandiOSc+JYFqUcyALneYH6YgSvzvq+ljkZiKXF5//oc7+APTNsfPQ0YAXdmGvFTXHkH/SFKkCql9PjeUrGO3qafRZl0QCh2A3Xus/ZibCI35lTAXEPrFuJFeEqTvMH+EsNjjLUt2sUfHdIk9pfHZBszArbTvFG3psdamY9GlrYKS0tKSNPbxWLfecqdqaC6iWpJhuMty13buTa7gzJvHepjkh1lNAIKxC4+rVkHc32WVEdME98W3sH0Y7IVItRbBM8OhUPfVpPqzb2ZVkb5wLbsd7p8ccyyOULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCleEo5K+Q7gnodd6pKj3mzc78HZDM0ta3yr7b9wN2g=;
 b=h3RxWs5MORTMmu42eT5jmylsN/WKw+TmyAiQvMmdHc92r+oRaN6Zmxcn/1JlCuPZKvZiYqlT6D6b9U7f4GhSuti5InJe2eUv0dj8Az1GPv1b3CJGhpGMO1yV1lEwKJWOSiM8+MyVEQOnDjBd8CwvFO4XM85pCXo2ve7CX9NNaoy3gU/zk/PgntBkhbwSQ5bjBiRkzOAJUCHa88b/L9t18DGvx09jjROzKZ8daOpM4YDvdkwQ0GI9X4hmjg7nyKuVOPAYhuigfAUgGG1NkoTVnUvcP24wh1QUB6kc86T1Ax+SN/nCT8tHtC3MS10CqVuwWBh4zKbYjfiTIHrdpjPg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCleEo5K+Q7gnodd6pKj3mzc78HZDM0ta3yr7b9wN2g=;
 b=sjJHc1DCC/bsjbAWTyurJlLTrM3KPtrviRmShyB3fhcgB9qnIVJZE1ZKQuKy8gjAvvUxlyYEHgGRjKS3n7B3vHSPKrEAzGlpve8Kdvc0XaKnQ9VeW1EHmvHc9sxzubiPTMd42q6IQ/EYTRJMbkaMWlHYD6v6FrjW1RESE3Bv8Pk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 06:51:21 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:51:20 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
Thread-Topic: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
Thread-Index: AQHaooVmGXzze42JSUimJqLRKM+EwrGP++TA
Date: Fri, 10 May 2024 06:51:20 +0000
Message-ID: <CH3PR12MB807484C37AA2484206A5A954F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-19-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-19-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c8d61c43-bf36-4c0d-9f8b-e1771ac3af3a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:08:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7200:EE_
x-ms-office365-filtering-correlation-id: e721e36a-4bb6-45fd-48df-08dc70bd99aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rbHBY5jf9gbinbq52slBnhXekD94/+S1crPe0ZzSJ9U3OrOgnmzhKnS1O1?=
 =?iso-8859-1?Q?18YswqJEDi/jkEp5xY7qTUWdZoBMpUIvm9y+a0Cp4B6rBMziIMskp+qr7H?=
 =?iso-8859-1?Q?U/ZS4UtIKk78PIWFqxZPBYThJ4j76TuA5JQhgS0Tq4rrkGZSz85sox/1eK?=
 =?iso-8859-1?Q?5q0oSPPJZDWqoPlk5w71yhI1Z27fY3EvWCw04mhwZFyu1q55fzAWjTO1X3?=
 =?iso-8859-1?Q?GclszuQ9Up1UppCYH0Vl6pH/Wn36wZ9Fb7are+7hf850nyb/dNrbwGTwu+?=
 =?iso-8859-1?Q?QyrBYudz9uapSXMNf5Njof7od7k/qcFMP1NhFEQxpUKeQoC5FJHBWj7DIw?=
 =?iso-8859-1?Q?+DEfiDSsZFD+tnKThXqLD+isIdEuEv9uk8ziCUX4LgIMt9hwvj/6Ey5Ly4?=
 =?iso-8859-1?Q?XPJQdXTCdS7YFkjHU3yAo6sTEBROJvmrVy+cmpJvl8O65MVN+3yuVDmATe?=
 =?iso-8859-1?Q?uwUbyu35sBX3K5ceONeIVXziBV7ReQrd5LZ/o1+mmjfo7xx59u1BiNQ/dp?=
 =?iso-8859-1?Q?1VxeIt5RI33MsHJwuZgCmR0SBFZkRwA8hZ+N6wJksycgrCkXSxolC9P4me?=
 =?iso-8859-1?Q?A9HrCyl4Sq1i/eJIC+G2DoX33KY4eRI6IcUNZnEwZz3gJfMddSR5dHVL/U?=
 =?iso-8859-1?Q?KDIRsV0PH0Wo508suwiU/kr8HXbN5AuTpLWk2durD5ReFBqm1gRDJ/G89a?=
 =?iso-8859-1?Q?FIKYB9xy/tSbDuD3IrYS/heyI0OvgxlL2cr1nllZgvHNRXy9sKpYU4uvc2?=
 =?iso-8859-1?Q?rK9Gb2NsR+9Yt40WtDcSR9rVzJu2RqRbIovKEYeJRpmvoIRZHpMB4k8IP1?=
 =?iso-8859-1?Q?spcsSh+1qA7TqCrFr+ZnQPWzfRR4qaGuyL8mSMTZbGgBUjU9SYJCxac6Vs?=
 =?iso-8859-1?Q?NLxm5SZOjr0LJ633MAV6MT5RCRwWni0r0Q3beZE1ThL5wPo6HZHBpEpxss?=
 =?iso-8859-1?Q?okA1NZNhkGi2aFKkeC/3p/E+9MebeRH1fqOVmQ9D5i5gHnXiuR+WKng4i5?=
 =?iso-8859-1?Q?z6wQP4l/4s/TyrSPCnHTv1cYQgF0VL3iaqYQbosL1W62nh9dadXW/2cB09?=
 =?iso-8859-1?Q?uY7qoUaHpRq0ci1oHRRVTMqZAircms8lTgOLz2Sr5DaoyfuEPl24r3RaQE?=
 =?iso-8859-1?Q?M/GL8JzyHm6ucoGjZaasyFBu1SD3bNSOCeq5D5VkwQ4jMCP/reZc3vZRY1?=
 =?iso-8859-1?Q?kboAhsLlXW+F1LAfVrMelbD0EiuFA0J9Bte5cok9FeXtvN++vllZwMD5GM?=
 =?iso-8859-1?Q?4j47hlEUeyEHUD4pkBHl4OtRrGXcCKchOoQ3tIOhUws0kVgtyGjgtRnBGZ?=
 =?iso-8859-1?Q?SVCPNBA+uMZizAOIJLM1GAzH4enY2vb7YE4V2lwCSaqzfUfgIITbgleBk1?=
 =?iso-8859-1?Q?ng6ipl+49pLUhU352WTQQiS9C1HwjS/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xRSdeAFrrnqKVB+NoTCvMC2irZg0COf6HB1ZyNTN+K++FBsr4KjJa8PM4f?=
 =?iso-8859-1?Q?L5sjUm79lFr4mEy8UFCt/eT6dj711Vw3tli+uTMz4DJG+Ye+52cnrKBFZ1?=
 =?iso-8859-1?Q?/Dic3EPzICwDDEuh9mswvKND9p+2XjD9zydm0USIpYU2rG9bxSmazaP54x?=
 =?iso-8859-1?Q?AQttr6qrKyD096LiPiVF1M48rcfqsz3bDUH/XgpcT7TZjZlhwzsya1Ig4e?=
 =?iso-8859-1?Q?4YmlbyUQEknu8iXMbkqp4FVCvbUWNQfEGzpJJB39Vctv++IpufbSOOTFzo?=
 =?iso-8859-1?Q?XgQHdUw2X+DL24TAATUXOYCgHmNbJdxiRMvsykW7sXWhQURMG+4+rU5mw4?=
 =?iso-8859-1?Q?6QZHwgZBZOPKQPbIuDiYXOidzI1rpS9F0z/QconHlaohdWMtj45HbmQZlf?=
 =?iso-8859-1?Q?H9JycWQxdWbYqYS1Pk1RZYmE3Yql/ZnJkd0kGSpSbEQOh6lGobVaogoB5a?=
 =?iso-8859-1?Q?2bs689i7mjFoD75IazunKfi9RRx7lV3DjQZ0p3yqTEiFamvmW895ctFCoB?=
 =?iso-8859-1?Q?F6PEvSfnxAPriWz5EDHxCyaRHwOuUaWxUUTcVKwsCzlX1U9Jsiy7L+Cmyu?=
 =?iso-8859-1?Q?Ceevgew5ddTa+FyMswqKc1Bg0uHf6Va/woDq9fdnYUndrLakcZyKdlZmtA?=
 =?iso-8859-1?Q?wB6NorR8La+HlWSz+bQRB/bCkwIhYOOMsnUTesyMhpwG1uiRy6/f0+B52I?=
 =?iso-8859-1?Q?bO1AwMCNBEJbWrKaT5HWED0xasFgNq0Kgj90dsi8vUx6FQKyo1gq723Ew/?=
 =?iso-8859-1?Q?mElyAzxq6tyOz+an9msf4SPQWqm3paIyXFEec6kU9ptHjfRnoJqeDFLq+d?=
 =?iso-8859-1?Q?bWSGEEk84nO3jOz3fJVIEwcOEMD4lCNGpCQBXsJnPDtwzWDN593Idl7DFQ?=
 =?iso-8859-1?Q?oX+UXE5xBz/2bME+sOvOSPuwEr4ZO+WsTYvD2/8l4/hNXajZA/GqOVY1kT?=
 =?iso-8859-1?Q?WFCkMRHK+8eybn3tb7nK/am2rz3PXvbzbBttM5Cs4qP8nGb63dkh02pY05?=
 =?iso-8859-1?Q?eOkwWdIhFS1MxgUmvBD2BlULOZVRbRS7ELRH18QeY/DPVRZ1kLntRyP6If?=
 =?iso-8859-1?Q?Lx1nRy5i2h/Wj7LYO16AlgXLkdGRV2j0Qbav0FtPEbvIO7brb/zlSX08jm?=
 =?iso-8859-1?Q?IqhAkS0rF0oqaQF8PwpjGTh6pgXjlV7K8gNa55xlClwQOBmeNXhAwTvcEh?=
 =?iso-8859-1?Q?XajRS1QJiUsAE+GBotNOdeISo+j2KM5bNaR9HhFAN71B8UADfxwoQ2r/+s?=
 =?iso-8859-1?Q?5LMB2jZSvB9SZxLgB4JWNyssY/xrYRZsOQU3t5jYDVeUiYHVdjjbTjDn7a?=
 =?iso-8859-1?Q?E/aYKZGAfQn6RbWnepSP2W+FQcnx9c3oOqdZJITaHiYw3Ald6p7PuZVMkp?=
 =?iso-8859-1?Q?5c7rcvlT38FxaY2wucetibGih3fSiS9TckPE8X+UsQPGYK/0Kz7ZtEBVLM?=
 =?iso-8859-1?Q?0VFdIgzRcIWXOG6exg30lVDbc3Yt4wNjuZcQs7b5sb+nR8aX//XYJZzUdz?=
 =?iso-8859-1?Q?jyBFtidhMCTqVxCiLd4+ALUx1GgyBRaOl6Qh7E4V8d6Ki+bS38nUtVaqNX?=
 =?iso-8859-1?Q?MtuGt4PtnkKsD62omfzIYfJeYBu2twvnWD3MCn+FMRmR++UU0Rj0kMg3c2?=
 =?iso-8859-1?Q?+CNc9JUdLWo7M9ikc+P3VDywqwNAM2ZFzl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e721e36a-4bb6-45fd-48df-08dc70bd99aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:51:20.8624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VvsiNR8gW0ZgZPOfiqfQr4Uu1PGX4fLWHcJ62Gl8aGhetufTFi7b/Q1YXu9JgNPL6b96XcXEVcTO/27WgLTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
> zero for the variable num_xcc_per_xcp
>
> Dividing expression num_xcc_per_xcp which may be zero has undefined
> behavior.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 414ea3f560a7..5752c6760992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -522,6 +522,9 @@ static int
> aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>               goto unlock;
>
>       num_xcc_per_xcp =3D __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr,
> mode);
> +     if (!num_xcc_per_xcp)
> +             goto unlock;
> +
>       if (adev->gfx.funcs->switch_partition_mode)
>               adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
>                                                      num_xcc_per_xcp);
> --
> 2.25.1

