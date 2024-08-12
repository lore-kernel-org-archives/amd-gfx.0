Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE5C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 07:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE89310E0F9;
	Mon, 12 Aug 2024 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LB/U2voy";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E507910E0F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 07:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwHHLipQywJbJDU7vO+r0bvlS69NQuf1wdQRYfn7O73YoQetTeZ0jiuzi2T8zIicZEJs5Bh51IbVjrFYkuSIOCLRDpVO/mF3gRPpNP8CK03ziulncJsy6z7JdMKcqZsP4uREpYSoJ/X/PUZdT4+2V3Y0W3aAO3+CEtHOHJExVN1NRQBRK7hK/tEMcwNUvlal+loMRusPUDusQ5CClmsvsSyUd0r63Cj+23dl9UdvHIOAWfb90auQuVUbf2pYw50cIhOs3XMI9KzQzNEuLM/0EOwqUkeq96Y8SSjKU8fQerg9pHHgIn61NCF2erFg5/+gbbGIgUx4GzqATd44T8RWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8L7vUsNCgVdGNMyDaadhxWIbv8vTBU+yuQh07gTr8Y=;
 b=zQwDHVvVU13lKYyDxW8LuL1C4e+u5JEMfsgrCMDQcuQmwaNk9el+M+neaw2fQ8SUcGT/lUiNBkIFUvXsOXG1NM2G0SMabqJRw3xi3HAI7NjaEd3ZcmCNr8GBUe/GLQHvEEm5/L8LMQpIcxtr66EgywcmA1KXmtqoKtFXDN/n1I8tolwskXKhGDubMW2jiXGicT5qr/dXE9///dfjP9AZsuwURsChT5DvWvKHSoTUQ2StePPlI8O+kZ68ANoYUz2RP/QlirXY4xHB0/TgClRpEwT6BWbEA1bjjG2+5C6ZzrnMuBbGsIUx8vp6AydxhrG1Q0pPCfR3fYDMzEDyoKylpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8L7vUsNCgVdGNMyDaadhxWIbv8vTBU+yuQh07gTr8Y=;
 b=LB/U2voysSCFLxELe52UxBjBvo8OQpCUJEYjkpi9xF6cSARwEB0xBcIHwl/uqsVQCVA+Aswc+kY70fGxMSzYeb3JMNOUDrokGTXQ7z/mhisg7672PeVr1oZP3/dqQ4HVjEgngkL7KVaom7whi1G7ZmkV4QxFJ6gmf20D6lsxUxc=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 07:08:38 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 07:08:37 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
CC: "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Index: AQHa6KT3/ppEMp7adUygdPkvET7CTLIfnB8AgAOdV+Y=
Date: Mon, 12 Aug 2024 07:08:37 +0000
Message-ID: <DM4PR12MB5937EBC1E19206470250A820E5852@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20240807083624.1729349-1-guoqing.zhang@amd.com>
 <9dcd8afe-5c96-4ef7-ba5d-8b1d4c47b66a@amd.com>
In-Reply-To: <9dcd8afe-5c96-4ef7-ba5d-8b1d4c47b66a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T07:00:54.6300987Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|BL3PR12MB9049:EE_
x-ms-office365-filtering-correlation-id: 31378a17-cfa8-4d60-834e-08dcba9d9675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?EAZI/H2oUlyZUGfojcBR1R+QhhiLN5+rPqgxRBX2jSRozD4lX1UqjkQ0?=
 =?Windows-1252?Q?GakQvZVqnETrFv0h8CB+Jra1u51u7sdvz+R7UMJzETJdAzhjfQcJ3zY3?=
 =?Windows-1252?Q?H2m+GeKEdt82y+dSy2vSTw1k7sqWVSzJTb7ZeVUXWA76YhQxpaGekiXO?=
 =?Windows-1252?Q?1RGZjErmsFfZ3sGhd9ADktJCkP2vu/acDoXGqR4BNNcfU9J20ThDlwLE?=
 =?Windows-1252?Q?hPwob+j7NmMus1MlxfLEKWFirFGBX6tfn22ArW2nCHaW7BCu6nDT6E5a?=
 =?Windows-1252?Q?mtxA/R9ihDzhjP9bD0pXvVYDUDVkvbBgULM76V1BB0uGBnKfAj4mWrdE?=
 =?Windows-1252?Q?Sh3UNLLivaTGeqJf3wfv0x7tYbRsPkvr6IQSTS3t48/+5UKiWMe8BGh+?=
 =?Windows-1252?Q?hwZmjGOmuZqYy9CjpYLZYT8o4JGQyJDqaIBNjMHyqEzT4NiEzKX4bR3f?=
 =?Windows-1252?Q?w2BrZ6v2ysilDIqWZc5YFAXELtmErvb4CinT8DYp39JcJanYpSzo+vWF?=
 =?Windows-1252?Q?L9WLM8Wa30PbGsXiDjXg4SzUgYiNxfwN39fVZbWoHM+NeOe12CZh5nIa?=
 =?Windows-1252?Q?2jwMEKw8shH+qSp2L2CiKmnZYCUm7/gB5I26lB2ggtaqW9tLqh+VdvVy?=
 =?Windows-1252?Q?iIZ4LeQfFedUlBImVbWpM4eugj2cdPzKwvu3CxcgCiJXyd6yHwNxCdbk?=
 =?Windows-1252?Q?BbYaSZxpbxjqdAQOxjBifi8cWMv1rwFbZYow0W4fJdbuMkxZxM/uUohg?=
 =?Windows-1252?Q?CCpmWQJgVIQjQ/Ss8lrrr2aY+C0D4gdTyeWJneijJcJgy+qiXLvjHnvu?=
 =?Windows-1252?Q?DNrrl1mOMRfcubtZmofJS3YEfFoRGDPsKTD13umFP5TQumvAyKs0TRd8?=
 =?Windows-1252?Q?B5d3UEHRo8WM8CeXcJB9vmzp95f6thh+i2H25O4np6M0oYnsOSWzB7Hb?=
 =?Windows-1252?Q?8HvHCRBArZLya4a8hGFcTVp/ALaA0fLLi9v8DRIjS+zo55jXb9FARzyO?=
 =?Windows-1252?Q?CnCDpQPHkWf18s+RUSlgzmJrq9tEP4TNMpx6WwkqsDD8DzxaraUGqr6E?=
 =?Windows-1252?Q?mIFrIzfdAif2iBq6yV5uNqrqZx4kaZv/jKX8VWy+fntRU5n0T/lUESGj?=
 =?Windows-1252?Q?gZyro6GT4BKzoZkrnJA0SUeg67bR3rn1oH0LNvgil/cHIhx3L/qUSgOp?=
 =?Windows-1252?Q?hlb3IeE7b0rPY7pira/X6XpWOYl7sXV5LughQk82wjDgNsVGFNNg6T5n?=
 =?Windows-1252?Q?u2fzLYal7itUKrJGqZxo2ybqOKae5Jvfj4ozMeP3Rf8VmczCQ958hBfp?=
 =?Windows-1252?Q?V/Qwg6NGpHErUUvAKrbzTWoE5pqafmeJGnQEC1/kcoknLDZDhk5hk5fZ?=
 =?Windows-1252?Q?MQkGjSjEwzW1l56LDuzzwz/eN1iQsylzTDCgQfZ1Sm9VoIaiNV+HOgUx?=
 =?Windows-1252?Q?NOXLnvW1w7iZ/HQj0/61W4p15LX4IckxedgG2tB1nAh06HBRftVt4jR1?=
 =?Windows-1252?Q?/wI7SDrukn8efWyJvmGO6BJR2qGOwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?83cmGvwzLjmmVS4EyERxcf87+IgIfMpZNc9Wb43lyvm2iRDCFSRhE9Hi?=
 =?Windows-1252?Q?j08CLneGsCeH82vvr9XH9Ty/yHfJumtU51kEyLA1yIoEX6GyBYFOPSI2?=
 =?Windows-1252?Q?arDuSvSEA7k/wVKGekAcBL+T4+PVTXB9OeJ+T56EgpVNUvnfxQFUGM2K?=
 =?Windows-1252?Q?RWTOZRc8e8H/SExOe3+lZHO9th1AkZ7TsdfbOREIgOvnsv/UK3wEnwrA?=
 =?Windows-1252?Q?qeMH0FBLFPyuVoW1XPM+iCEqsDtDIX6osRnse+4iIh3vRsrTQjy+7rFv?=
 =?Windows-1252?Q?AefqWXfDlRsrRDyxQXVWZWdwLoyFIMN4LHV2t762gqn0+109ps0G0XPW?=
 =?Windows-1252?Q?v9J6ojZNW+h+d+Zr6bfjmkeRp339m5QYTxjDKyx8EvQ3MYf/Pcm0KHY5?=
 =?Windows-1252?Q?0rvJSNNCM10oMJYA554jurR46DhwRD/bgSJVWU31bt10stTR+o1D+ej0?=
 =?Windows-1252?Q?OMvsN5tRm8q3VeT+ybP8Cv0Y/1rXBgfvtV+GU0AqVbyjmXl6RUqZiYqm?=
 =?Windows-1252?Q?AhYvf7BxaNF5PgrR9qXLKN4oUkyD3bDDfcVmND0q55EeSdCCBJ+2boO8?=
 =?Windows-1252?Q?IuqHDEcpQHsUTIf2SEHAcKkbJEFSXu3sUUDGZxr/zw/nXSQlHGRTGP9L?=
 =?Windows-1252?Q?0/zECSexUyHlyMyIuNSKcTkwq4BkUMe9gNakFuJ25DTd39UXDa0IhZV6?=
 =?Windows-1252?Q?nx+Vjsgfp29EdIRNUQQ1z3AepB6PNG6gcUsh5LjuIJsn9cmqfMkjvv7Y?=
 =?Windows-1252?Q?tEDK/lElMogOuVDr0v9bkKsaKLYulkGZOTciFye9QQSAyW0D/aaV5Bmc?=
 =?Windows-1252?Q?EeA8tajUAPRnoy0EgMDDs/4e3NPb+GRiuxXnlZHrRdcnkFscL0r4gxny?=
 =?Windows-1252?Q?KjQ0xMYYv7Xt64ss8kk080dC6lD0b3jtX1hU2o74F+GGFVt41voMei+n?=
 =?Windows-1252?Q?NAqYe23a80fBrkrfDxH5z+hy/HUFg5xvnpxHokqxknSCog1O65C8nuAS?=
 =?Windows-1252?Q?Hms998FRW3fhUJg2j1LEIxWoDzt6K3hcPe3hzbA1D9i0O+0bKP+LmiuJ?=
 =?Windows-1252?Q?IrAl+2Y0P9bK09+sJTXHNrS+quiiyDTzOSw84HrU6NDJRWt9a+aCoWyt?=
 =?Windows-1252?Q?T/SXigEiWYotMTM4lkXQo+uxlfyvfVCU6a8tccDYAjiWyelj1Eh3U5+g?=
 =?Windows-1252?Q?EVKyqte5O2OuMqvV7VlmrJO33UCqGq25RHX16e8nYkIaANUkHexv2Xh+?=
 =?Windows-1252?Q?DI4JZ2Xs/RXKSlXm4pDBjy4owsM9Ei5CERp84vvd3bxt/+5RbBGRM3ZG?=
 =?Windows-1252?Q?eWjH8yAiv+FsC/9JgVLg+0mRRLFVt6jOHnZF5+84vUmUbR/ia5R1INzr?=
 =?Windows-1252?Q?u9SYWHtLn0LkM8x2q+ysaAnT1htDtaz5dqbDeyNFeZ/1AZtz7LRBMkoS?=
 =?Windows-1252?Q?X0iM0nsgYJujoStOKheE1CdxsjlcCmy294fUWcmdHpHsuAEeLei3A8aL?=
 =?Windows-1252?Q?MTX2LFR41BXTw4qJPPLyTF5psT8yCg7MP93ki/FF2wtb/bvl2bkffIWs?=
 =?Windows-1252?Q?xD2LbKC4STNPBo8Fjd8lC7deoZjaSHlXZLqjVCqHu0KeqPVjTtQKF9Oh?=
 =?Windows-1252?Q?TLvp6i9JEQX/9LLE/dt0uIJFK/CiLoI7CPH7Qj07bVJrZLnJXDK+KQLa?=
 =?Windows-1252?Q?XtfpGtGsYZi4rnhxS/UM/FiMrvfiDt1at4f0gezh5rBT7+z0L1Unug?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5937EBC1E19206470250A820E5852DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31378a17-cfa8-4d60-834e-08dcba9d9675
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 07:08:37.6117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYhIm2y6pHhjalZ7Q4iNh9xckMtKjxLZN2pGPDj2XAmGeEOIM7r67qqE37KeInZgd6/R4nfwJetjXkvepS5zpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

--_000_DM4PR12MB5937EBC1E19206470250A820E5852DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Kuehling, Felix<mailto:Felix.Kuehling@amd.com>,
Thank you for review. I agree with you that we need to adjust the priority =
of each access method here.

Hi @Kim, Jonathan<mailto:Jonathan.Kim@amd.com>,
I also find a new issue in amdgpu_ttm_access_memory_sdma() after my first p=
atch. I sent a second patch to fix the new issue. Please help review.
=93[PATCH 2/2] drm/amdgpu: fix incomplete access issue in amdgpu_ttm_access=
_memory_sdma()=94

Regards
Sam

From: Kuehling, Felix <Felix.Kuehling@amd.com>
Date: Saturday, August 10, 2024 at 07:49
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Zhang, G=
uoQing (Sam) <GuoQing.Zhang@amd.com>, Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVra=
m fail on SRIOV

On 2024-08-07 04:36, Samuel Zhang wrote:
> Ptrace access VRAM bo will first try sdma access in
> amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
> access.
>
> Since ptrace only access 8 bytes at a time and
> amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
> it returns fail.
> On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
> is blocked for security reasons.
>
> The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
> that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace
> test case on SRIOV, but also improve the access performance when the
> access length is < PAGE_SIZE.
> len > PAGE_SIZE case support is not needed as larger size will be break
> into chunks of PAGE_SIZE len max in mem_rw().

I'm not convinced that using SDMA for small accesses is the best
solution for all cases. For example, on large-BAR GPUs we should fall
back to access through the FB BAR before we use indirect register
access. That may still perform better than SDMA especially for very
small accesses like 4-bytes typical for ptrace accesses. Maybe this
needs an SRIOV-VF-specific condition if MMIO register access is not an
option there.

@Jonathan Kim, can you chime in as well?

Thanks,
   Felix


>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 5daa05e23ddf..a6e90eada367 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm=
_buffer_object *bo,
>        unsigned int num_dw;
>        int r, idx;
>
> -     if (len !=3D PAGE_SIZE)
> +     if (len > PAGE_SIZE)
>                return -EINVAL;
>
>        if (!adev->mman.sdma_access_ptr)
> @@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm=
_buffer_object *bo,
>                swap(src_addr, dst_addr);
>
>        amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -                             PAGE_SIZE, 0);
> +                             len, 0);
>
>        amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>        WARN_ON(job->ibs[0].length_dw > num_dw);

--_000_DM4PR12MB5937EBC1E19206470250A820E5852DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.spelle
	{mso-style-name:spelle;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
</span><span lang=3D"EN-US"><a id=3D"OWAAM4048616300D61C4AB9A5FEB3EFAA44B5"=
 href=3D"mailto:Felix.Kuehling@amd.com"><span style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;text-decoration:none">@Kuehling, Felix</span></a>,</=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thank you for review. I agree w=
ith you that we need to adjust the priority of each access method here.</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAM364ABE905E2A804E9F3AF3E7FE765BB0" href=3D"mailto:Jonathan.Kim=
@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Kim, Jonathan</span></a>,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">I also find a new issue in
<span class=3D"spelle">amdgpu_ttm_access_memory_sdma</span>() after my firs=
t patch. I sent a second patch to fix the new issue. Please help review.
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">=93[PATCH 2/2]
<span class=3D"spelle">drm</span>/<span class=3D"spelle">amdgpu</span>: fix=
 incomplete access issue in
<span class=3D"spelle">amdgpu_ttm_access_memory_sdma</span>()=94</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Date: </b>Saturday, August 10, 2024 at 07:49<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;, Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, Kim, Jonathan &lt;=
Jonathan.Kim@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvis=
ibleVram fail on SRIOV</span></p>
</div>
<div>
<p class=3D"MsoNormal"><br>
On 2024-08-07 04:36, Samuel Zhang wrote:<br>
&gt; Ptrace access VRAM bo will first try sdma access in<br>
&gt; amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio<br=
>
&gt; access.<br>
&gt;<br>
&gt; Since ptrace only access 8 bytes at a time and<br>
&gt; amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,<br>
&gt; it returns fail.<br>
&gt; On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register writ=
e<br>
&gt; is blocked for security reasons.<br>
&gt;<br>
&gt; The fix is just change len check in amdgpu_ttm_access_memory_sdma() so=
<br>
&gt; that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace<b=
r>
&gt; test case on SRIOV, but also improve the access performance when the<b=
r>
&gt; access length is &lt; PAGE_SIZE.<br>
&gt; len &gt; PAGE_SIZE case support is not needed as larger size will be b=
reak<br>
&gt; into chunks of PAGE_SIZE len max in mem_rw().<br>
<br>
I'm not convinced that using SDMA for small accesses is the best <br>
solution for all cases. For example, on large-BAR GPUs we should fall <br>
back to access through the FB BAR before we use indirect register <br>
access. That may still perform better than SDMA especially for very <br>
small accesses like 4-bytes typical for ptrace accesses. Maybe this <br>
needs an SRIOV-VF-specific condition if MMIO register access is not an <br>
option there.<br>
<br>
@Jonathan Kim, can you chime in as well?<br>
<br>
Thanks,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 5daa05e23ddf..a6e90eada367 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct =
ttm_buffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, idx;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (len !=3D PAGE_SIZE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (len &gt; PAGE_SIZE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.sdma_acce=
ss_ptr)<br>
&gt; @@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct =
ttm_buffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; swap(src_addr, dst_addr);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev=
, &amp;job-&gt;ibs[0], src_addr, dst_addr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; len, 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(adev-&gt;=
mman.buffer_funcs_ring, &amp;job-&gt;ibs[0]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].lengt=
h_dw &gt; num_dw);</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5937EBC1E19206470250A820E5852DM4PR12MB5937namp_--
