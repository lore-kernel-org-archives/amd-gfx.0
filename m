Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA2CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D5D10E0C0;
	Wed, 13 May 2026 20:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sn2m4MWS";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6124710E343
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcIaHiRuKFg6F7EjROcwPx1Jf4Smu9ATFLDnZYOd7A7cnkk3ljstpA6bx3ZJPhPtwu2FkwHOIsyd0ZNlBU+InuNAjhElU6Tt7G5xqEudUPah94RPoegdMnx1otTfudqDHXb5dSNjb0Hjwm+R32c0GvelbqngIlGzJ2kK9rHQ268axDFs4GqUxTpKksctsqq2vemxEZ3iSCnU8uYa5AdUXGMCFmZbvruJtOpOiSFk8pelaYXiC3YfLlNiyGSs8L9yl7qkomcv8e2q9dcuWBYPzb9jpkiQ9AC0dHZ9G/TbLP3fzb7XX7xvegjGuxLxLb4CySNSNp9FZgFOezmsjhFefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svfp9D3LdfA1WKr+8xDJrrW7Nv/OXXWLSJROtFDfFvE=;
 b=LX4CyTXfqI15z625Abod7sV/6aCIbW++D2czWwM+HFlkwROX5l9RgRRYeJIbfnTMQfjjBEa2W6aZ8lSKsus9Jym90C+DqrYSY2/jBaRF1xGcf5VgePNop7ZHjGivaf7CpWJMmh1r+vffqMdRuW64P07nXzou4G0IMjHXKwjxbi+Q4zseqRV40AOwV/FA3xOR4KeahE6gc5Odc01g9sAYvnguBqSKyoR6F5T7nP3esKXEBKTm9sQokgS/OOVytErS6kbzUQRXsNjeiQeU37PN1J7qKOdX6E+wpIa9u7Q1RCH5ucaD9xJTOut4p6ND6iFx6BeuLppgZAzYDivMYRKXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svfp9D3LdfA1WKr+8xDJrrW7Nv/OXXWLSJROtFDfFvE=;
 b=sn2m4MWSPX6MGnzuY+nqBFf0krNQtV+N46aVOPGRUdgoqeY6hG3HzYS5h6NYD2K+lzUENj71P4nIXsp7au8LoJZ0VfzXDR5QB4dJ3u0ZiYl2dfGdDEeSyya87asLnQgIS2PME7JPWZlh2ugSc0rmx256ZrGgq/uHsu49mMsptUg=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:54:40 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 20:54:39 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask
Thread-Index: AQHc4kGu4QzgzKc+EUynxKQtbV+WnLYLtWEAgAC7BuA=
Date: Wed, 13 May 2026 20:54:39 +0000
Message-ID: <SJ2PR12MB865013D5352DF5147B40AE7C8C062@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
 <39547ace-1a1f-464f-aea3-2b5a86c1e404@amd.com>
In-Reply-To: <39547ace-1a1f-464f-aea3-2b5a86c1e404@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-13T20:54:39.728Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|MN0PR12MB6001:EE_
x-ms-office365-filtering-correlation-id: 3516a399-d21f-4896-e294-08deb131d9be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|4143699003|38070700021|22082099003|56012099003|18002099003|11063799003;
x-microsoft-antispam-message-info: rlf2r2PrFsUxoKIYIrzmBamc9GSf88VOznr56hG3xMdD36JVdZEDRbsour2A1zYemy5D/dOKkfTgoz1b6ZRbiUS/crCrrWE65QPI0HpRQkM7LrgFBcXPvoaxmpSc8np9Yw2ymicE8XPDwIQvH9xqGz8j+zMnrl2fxIJ0H7IL0k5ySHq1tR+10xzm83/5bI1IAIJNiYmu1S3QF8ZWu6c5Q2ZaunqU4cMItundwmZ0uCDfkPAmTYxanY9zmawFpHFa8mh0CBF5EQuJFNtfIyQXLgOF5OPuCCdWekjTATdtuAkhW/38yzsr7x+oMIk8AlrdZv9W76FyNRrwjQLlua0UgJ5ldtL7wpj/I8V4Y4A2zx0OLB8a5F1KjX/3oeTFvPcNbRNgjwByx/PAIw14QC6xYig34EJ84ZI+hpCxUusOKwVXBPEDONCEiYSt0BLFUwfhT9EIK/Q/F4psvT1OBdQpWGn/TwYKw6hF5/Dsh37uKx1PW4NMs4t6kY32BwN6vPJ6H/Spba72AWc1yFZDkrhTqI9yNjQ3yC+JuMOpDucoCotHKBsFJjeW8hS+LwFFqSEh9PAkTTtE7QlRvjjE/cPAC1BY3NY1i8N1mG502FUhnPqq5nUYFZfWnRT8MMlzIn6SqhHDCeC2Ay2aWhYClfy7dJKbs6nFt0De44cfB47rVxyP/Ge323McNZR7Z32lXqQjPcignK55oIbCpD3qttL7iCPdsKuw99tLTofAExm6wbubDlNkQMsLhpbbZfxzqyNX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(4143699003)(38070700021)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gWD396VwqMWvKs0SSxu7S6CdLKakrxm9+b6CFHfYJEe7TRduVrXqKymFG8?=
 =?iso-8859-1?Q?XdmVgQt7IHc/7i74jf/+PHRdU1ZguKIq5aYXcvdKJHUL1J+Z0nHblMzpix?=
 =?iso-8859-1?Q?q7pWIKAk1+sAwpCGK7p0LETITCla4MYFGj3Aw8epfFsLTDc3goPWVN45xj?=
 =?iso-8859-1?Q?31pTc2zCuc86vdVQl/CF+h4/6qTSEJQK3c9z2dDnuThxTM+yjzrJWgeJ8w?=
 =?iso-8859-1?Q?Xbaonsh7eTSssmRbOpvaXyEFslRH2UJnprrnKXx7ZcfNpYqYxVb+BFXn+B?=
 =?iso-8859-1?Q?Ej8HVMhZfLctFZLELn7IE9tyvXO4jDspf/FCJWq/Ve/NBrc2DQK1vFUm1Y?=
 =?iso-8859-1?Q?WmRnU+dSUdkY8uMAhPf/ZwREM5wHEeX/y8g83c1khjvLtClH7iICgHLSXz?=
 =?iso-8859-1?Q?7zR58yB22cdt1TGipbHqKDvyQkbweVmcMmu5VaRvp8rBH10JE0TTJ6d2F/?=
 =?iso-8859-1?Q?z5+M1svqTtiAOxHNVCASsi4ApTK/yDp2sl4Ql3J9nR05b52R3I2b2KBHvh?=
 =?iso-8859-1?Q?SXWRrXq/EdpNcGCAI7UUrmchaDzKYjYpklv2IsvajxGicfnk4noI+gtb4d?=
 =?iso-8859-1?Q?nWCB0Ub3ApGVERm+38dzU8w2cH9G3NlIBCrtrBKMYuXE3P6DXS2SYrLSHq?=
 =?iso-8859-1?Q?M6+qFyNfAxtjwClf/ash2NjpeRXrIsHIJ+faoehCT1Ssyc8yiFwyUOQfUg?=
 =?iso-8859-1?Q?qTJOX5u0wikrCXfVAy8/L3jlQVXvlmFqAVmR6drqzMoO9UevyZu+srg7y3?=
 =?iso-8859-1?Q?/QwbcWn2qi2rgLqGQsrevRIxXUo5fteqYyXXIXM4JaNtsy3N6Ms2XZhmuh?=
 =?iso-8859-1?Q?KzOBPCupupeffbgwXU4wh1csIhrmZypzRkIcjcPWWpYliE+G2CMRHV9od6?=
 =?iso-8859-1?Q?/CEDLLOWXMwR3Fg4XqSD2mtpZ/jpIW5XjfveAxA7uEUBn62qzCkMcAbKzM?=
 =?iso-8859-1?Q?96W7mB3qeDZuaNwfbU4kZST7wMeyP32cPDVFywqVeEC+TS5GR+MEn3Q1Cs?=
 =?iso-8859-1?Q?PBlKfWmuJpMmwkyIoD1P0F81DoQCzGfUOZj8NN3u9vxr7lMABGj1BAHTO5?=
 =?iso-8859-1?Q?bBIqKmR1PjQqdWjs8aHRxz+CvCZ7OU9BuK/ukpFL7FABi8seswhfktTA6K?=
 =?iso-8859-1?Q?OfAjw/hN01Z9gcXCOYM7J6f48dj+6AfkkE07DthnQMOx83QXUXnlbYK/ub?=
 =?iso-8859-1?Q?ECGJ1dZHPgWgQI4Md6ajLIy+cBjmCe5BDrqbrIokIKp5KfiRLiiDBj27p1?=
 =?iso-8859-1?Q?l9SMvN+zF6pVXC5mKBuuYeOxp93iGbrjQLK/eLMJW/EDIDvtEfTxMa1q82?=
 =?iso-8859-1?Q?H8JmpNlPabn/eCMw50ARLeA/JqHcbSusoFBd5enA8tQVp2F9WG2GxVdZJM?=
 =?iso-8859-1?Q?oiw/LBWwPa/kaIVBGi+2Rpn0xTRK0lN8rkr0oDQcLKsZqjKEDKt7vHx3ja?=
 =?iso-8859-1?Q?Sq50tQNI3NgNmAwbJZb6kRVNdJMBeNCNb3jt1JT8FND1Bflc3pQa5Buimv?=
 =?iso-8859-1?Q?uAnGtCra9KLs+mGOtNDJAcudDzd7xBVwZn7WA8WRI9iAHpA93iZkf/+SAM?=
 =?iso-8859-1?Q?bgNhHZEgTyxoeuxpFn1hHFT54GT4Cq5BVoum0ulcIL5iCGZBjAGVIsSctL?=
 =?iso-8859-1?Q?qwyaKie/n3wQ5cvjB4bV5WjoIojhCfqQ+zw2Yh4iUFPjKIMlnMjU73ukt6?=
 =?iso-8859-1?Q?jENYP25cfqoU0z4pReo4/R8mUx0VHW61N669+936G3PSUmpb+ius/aWDn7?=
 =?iso-8859-1?Q?/H5scYmQRV3KLCnIAt1d52U2F2/BEY40GX87qyGExguH6t?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB865013D5352DF5147B40AE7C8C062SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3516a399-d21f-4896-e294-08deb131d9be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 20:54:39.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xzj8hnHJWHUppC4D1jG4XCmIz59NrdATurj0F4CnJi2jGsx98hGUbJq12zdKGDEVNv1WKRW4wFtpJwRExsMx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

--_000_SJ2PR12MB865013D5352DF5147B40AE7C8C062SJ2PR12MB8650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General




________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, May 13, 2026 5:43 AM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask



On 13-May-26 12:30 AM, Harish Kasiviswanathan wrote:
> For PTE creation use asic specific physical page address mask
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
>   9 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..631c8a7cc99a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev=
, void *cpu_pt_addr,
>        /*
>         * The following is for PTE only. GART does not have PDEs.
>        */
> -     value =3D addr & 0x0000FFFFFFFFF000ULL;
> +     value =3D addr & adev->gmc.pa_mask;
>        value |=3D flags;
>        writeq(value, ptr + (gpu_page_idx * 8));
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 676e3aaa1f27..886311fbc2d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -280,6 +280,7 @@ struct amdgpu_gmc {
>        u64                     real_vram_size;
>        int                     vram_mtrr;
>        u64                     mc_mask;
> +     uint64_t                pa_mask;
>        const struct firmware   *fw;    /* MC firmware */
>        uint32_t                fw_version;
>        struct amdgpu_irq_src   vm_fault;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index f2ccf30da324..1e98a9eb8e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */
> +     adev->gmc.pa_mask =3D 0x0000FFFFFFFFF000ULL; /* 48 bit PA */

This patch uses pa_mask as a value which represents the max PTE width.
It doesn't represent tha actual physical address capability - as in this
case it's only 44-bit. Suggest to change pa_mask to reflect actual
capability or rename the variable.

[HK] : Is pte_pa_mask better?

Thanks,
Lijo

>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 93b1912e28c8..4b93afe7ac8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */
> +     adev->gmc.pa_mask =3D 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 8bea8d0d16b4..a921e4c007ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>   {
>        int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0;
>        struct amdgpu_device *adev =3D ip_block->adev;
> +     uint64_t pa_mask =3D 0;
>        int i;
>
>        adev->mmhub.funcs->init(adev);
> @@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>                 * block size 512 (9bit)
>                 */
>                amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +             pa_mask =3D 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>                break;
>        case IP_VERSION(12, 1, 0):
>                bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
> @@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>                 * block size 512 (9bit)
>                 */
>                amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
> +             pa_mask =3D 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
>                break;
>        default:
>                break;
> @@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D AMDGPU_GMC_HOLE_MASK;
> +     adev->gmc.pa_mask =3D pa_mask;
>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index b39f37597429..675e0fbec8cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>        amdgpu_vm_adjust_size(adev, 64, 9, 1, 40);
>
>        adev->gmc.mc_mask =3D 0xffffffffffULL;
> +     adev->gmc.pa_mask =3D 0x000000FFFFFFF000ULL;
>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index eedd2006bec3..3eedd2b630c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D 0xffffffffffULL; /* 40 bit MC */
> +     adev->gmc.pa_mask =3D 0x000000FFFFFFF000ULL; /* 40 bit PA */
>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 347259700dce..a281abb810f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D 0xffffffffffULL; /* 40 bit MC */
> +     adev->gmc.pa_mask =3D 0x000000FFFFFFF000ULL; /* 40 bit PA */
>
>        r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>        if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 4cc3f2434677..0e485da0db8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         * internal address space.
>         */
>        adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */
> +     adev->gmc.pa_mask =3D 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>
>        dma_addr_bits =3D amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
>                                        IP_VERSION(9, 4, 2) ?


--_000_SJ2PR12MB865013D5352DF5147B40AE7C8C062SJ2PR12MB8650namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, May 13, 2026 5:43 AM<br>
<b>To:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br=
>
<b>Subject:</b>&nbsp;Re: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask =
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
<br>
On 13-May-26 12:30 AM, Harish Kasiviswanathan wrote:<br>
&gt; For PTE creation use asic specific physical page address mask<br>
&gt;<br>
&gt; Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.c=
om&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp; | 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp; | 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp; | 4 ++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c&nbsp;&nbsp; | 1 +<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c&nbsp;&nbsp; | 1 +<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp; | 1 +<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp; | 1 +<br=
>
&gt;&nbsp;&nbsp; 9 files changed, 12 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 13bec8461cde..631c8a7cc99a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *a=
dev, void *cpu_pt_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The following is for=
 PTE only. GART does not have PDEs.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; value =3D addr &amp; 0x0000FFFFFFFFF000ULL;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; value =3D addr &amp; adev-&gt;gmc.pa_mask;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writeq(value, ptr + (gpu_pag=
e_idx * 8));<br>
&gt;&nbsp;&nbsp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index 676e3aaa1f27..886311fbc2d1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -280,6 +280,7 @@ struct amdgpu_gmc {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; real_vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; vram_mtrr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; mc_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa_mask;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware&nbsp;&=
nbsp; *fw;&nbsp;&nbsp;&nbsp; /* MC firmware */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_v=
ersion;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp;&=
nbsp; vm_fault;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c<br>
&gt; index f2ccf30da324..1e98a9eb8e11 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; @@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffffULL; /* 48 bit MC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x0000FFFFFFFFF000U=
LL; /* 48 bit PA */<br>
<br>
This patch uses pa_mask as a value which represents the max PTE width.<br>
It doesn't represent tha actual physical address capability - as in this<br=
>
case it's only 44-bit. Suggest to change pa_mask to reflect actual<br>
capability or rename the variable.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">[HK] : Is pte_pa_m=
ask better?&nbsp;<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(44));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v11_0.c<br>
&gt; index 93b1912e28c8..4b93afe7ac8b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
&gt; @@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffffULL; /* 48 bit MC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x0000FFFFFFFFF000U=
LL; /* 48 bit PA */<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(44));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v12_0.c<br>
&gt; index 8bea8d0d16b4..a921e4c007ca 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; @@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, vram_width =3D 0, vra=
m_type =3D 0, vram_vendor =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ip_block-&gt;adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pa_mask =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs-&gt;ini=
t(adev);<br>
&gt; @@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * block size 512 (9bit)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pa_mask =3D 0x0000FFFFFFFFF000ULL; /* 48 bit PA */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 1, 0):<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bitmap_set(adev-&gt;vmhubs_mask, AMDGPU_GFXHUB(0),<br>
&gt; @@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * block size 512 (9bit)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pa_mask =3D 0x000FFFFFFFFFF000ULL; /* 52 bit PA */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D AMD=
GPU_GMC_HOLE_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D pa_mask;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(44));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v6_0.c<br>
&gt; index b39f37597429..675e0fbec8cf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; @@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_adjust_size(adev, =
64, 9, 1, 40);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x000000FFFFFFF000U=
LL;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(40));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v7_0.c<br>
&gt; index eedd2006bec3..3eedd2b630c3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; @@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffULL; /* 40 bit MC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x000000FFFFFFF000U=
LL; /* 40 bit PA */<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(40));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c<br>
&gt; index 347259700dce..a281abb810f3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; @@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffULL; /* 40 bit MC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x000000FFFFFFF000U=
LL; /* 40 bit PA */<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coher=
ent(adev-&gt;dev, DMA_BIT_MASK(40));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 4cc3f2434677..0e485da0db8d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal address spa=
ce.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0xf=
fffffffffffULL; /* 48 bit MC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pa_mask =3D 0x0000FFFFFFFFF000U=
LL; /* 48 bit PA */<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_bits =3D amdgpu_ip_=
version(adev, GC_HWIP, 0) &gt;=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; IP_VERSION(9, 4, 2) ?<br>
<br>
</div>
</body>
</html>

--_000_SJ2PR12MB865013D5352DF5147B40AE7C8C062SJ2PR12MB8650namp_--
