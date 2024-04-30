Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9111FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 04:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE4710E738;
	Tue, 30 Apr 2024 04:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZERncgVv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F65410E61B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 04:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khLPD4KGQEh5ZOs+dRQHydUHqeh/kpOlmtVcXThbeN/LALmaE1bcbTIFE9cCaW6vZu8Rw+Zt8UsneRVam8QT7uMejYFlUEQ6GZZKID+vDE5CNtyARvJLWnsylDPZCoMfi+UL+8nxCz33TL1MV6jy9rfliDqfCTAXep+xezFE53Az8Q4ZF79xnRc2A4JYXk+QVhkZ7IWAXXGWwIzq/92WqgTySSGonupNBmZZy6t5guQt7HFdzMYrpT1s95uD2D45TauC5lHw3GgbG3YNiHSzEW/UZRui9Qs/Mu5e0V6uJJ/CTZ76N7yjB7bSf5aiY/Njm/ZU/v45tzpBmVPBuEAv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR4r6z96e5mTr4jZkD23WDZIs9x0d3OHHnI81xDT8X4=;
 b=ZCJ18fZnQYtz0Sv79vFQwlEsEVW66TM7yu6ltqE+RttxEf1ZzKHSZjuAiWABYwilJV71BTy5XpkV+cXFZ/5BtnzMf4PsnfmZASXVlFyvkZAkkknI6m32yFQzmiwhsJesqm9qCpA7g4eYxkhvX8R7IDuojOmgpxzWu7x9RVHYGLFPaV4kxryswHFxEmueW0K1D/U4RcKkASSsLhDwLvVGDAIO7OkKBRYhyJNGaPHR8mr/vjM9q7cp++mg+pFjIVLACb1LWYBxZV+27uWulCruwelJSz6ArScGuEqNaW2Ki/+IrXGnbjMj4D7lyYOJCuEjZqf0Ufg5j2MvFrzXIxniug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR4r6z96e5mTr4jZkD23WDZIs9x0d3OHHnI81xDT8X4=;
 b=ZERncgVvpO+KOZfVDe1BFMDR5eU4MG+8pQr+yiOClpyL3SLsiUAqsHX/HXzJLcotlaGLgbVcfytVno+LdNw/vAQpJ8d4ZTl1MX8Pfq/kGUHoL5mCOIFYAJVTtLLDZo5sXjMTtVOZNJdxXKMkM9fhpwrJr0QApv8jtpa12nhKwoY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 04:13:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:13:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHal3fEOm433OEXSUiA6O0aY9XLl7GALvIAgAALTnA=
Date: Tue, 30 Apr 2024 04:13:32 +0000
Message-ID: <PH7PR12MB59970CD6D5438368938B597A821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240426011426.1340586-1-Tim.Huang@amd.com>
 <CH3PR12MB80748CBF93E22B4B8E4D138DF61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB80748CBF93E22B4B8E4D138DF61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c21f75a-151e-4cb3-8e19-d7f3c9b4a995;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T03:30:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4245:EE_
x-ms-office365-filtering-correlation-id: b8b1357d-d57d-45b5-4b3d-08dc68cbe5b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?dc3K4b261ltGsDbN7MK1AsZphGhTVZWwZXzJ8F5DdS/8eiGYPVNznbM2c/Wg?=
 =?us-ascii?Q?p/mkFCs7Ax58t75cw3etR0PCrCywHiq4MecZ38rCGvBCA8aPgsHGdHF6+scY?=
 =?us-ascii?Q?5be3BIARhCkkhN2w8IqHixCZqmYIZ7Hi3cJlYAJBVy6FQmuKoiwL2eWBnMiq?=
 =?us-ascii?Q?XWleP2bTQ3MFG+v/ttM/tAMpypXqrM3X1DYEF3FTEUU/lu7HN/FWPdQ/fVCV?=
 =?us-ascii?Q?Noe3tsY463r7b6wiEEWJ8sgolJUe38jfp8I22pj8LjjWPCS78omVJ6EO1Fj4?=
 =?us-ascii?Q?/yu9jDuQ14qC0NOvCTyhNu11xujnxbzu7t9jFl/7OQXFkcose3V3ph0yRk7i?=
 =?us-ascii?Q?NL07pM6MeC9eTWKcsZVczkk6U4qlTaFDN7n7ZpjrMmuE5HAx0F1ZrwbxUmsi?=
 =?us-ascii?Q?k55L+LTh033JT7TZJfMsKuJ5rRhk68xaXGOPurbgkME5diNRLdFlx1KiqAlQ?=
 =?us-ascii?Q?kE2BpbFVAEe9hwMCET9xn5rAUFhxqSUHBmi01P90qMi0tK0WBK7MuQQHkZbB?=
 =?us-ascii?Q?n+rEh2q8A0c5yhdjz2rRlZ7FL4L6puD/5azipO745/Mt7Z+bRZkRa5cIR0eE?=
 =?us-ascii?Q?0CIohKc+DzIWmwyJ1T9MZ3pqrVdVbpSY34DAYPwhLcObnYHxVAKLtrgCj6Ey?=
 =?us-ascii?Q?kM7vSSNw5a02labu+/+FfRRHIv9fk1vb4D/HColzWnULD03KaiJh4zuSzquQ?=
 =?us-ascii?Q?6513sNRdvKed2D3r+TruhuuiRn3kQ/VJOznYcBHY67k0LwUS29KjaCqARv+L?=
 =?us-ascii?Q?Gdukm+YmcSEaQ37erRstQii8iOeogUUcOr+tcEhP1qYeP6gr2W1KU5TaGd/m?=
 =?us-ascii?Q?rtxyVFt/7+UUJruxwVZU6QUgLFj89HRoxYxCb/veCsG0JmnmbE8Nhq0xahl0?=
 =?us-ascii?Q?nh6TfA4cyaU01DvFwtspCHJeAS/VWVLTSyoFBUMjSdFjrJ9z2XNYDoNTPC6z?=
 =?us-ascii?Q?ZykEG4JORnqJefzgyrnlrlazjHT+Y/eD07A2bCbJeel+HzBhJ7cfuKIH6304?=
 =?us-ascii?Q?nN3UcpASNVVffofgqXgNyOIk//TZkQtponzh/b8RwI2GO/SG1RM01m5kZdLL?=
 =?us-ascii?Q?MMEQd5lSO09nxxKHl8/vETv+iXGxuIc31qlFxYGhu61ZK4wedDjug/tgfM9y?=
 =?us-ascii?Q?SRokGCPxVKOoA920p/pNRnMHMLIP0VcLuOqk5Qhgq6V75GQxZJJJ4gtIMnHR?=
 =?us-ascii?Q?OU1gEsBQp77Q6muYbMW/3MbO6MJPx0iDEjOVluAyApI5hIgvM8qiQoy8z7fK?=
 =?us-ascii?Q?tnwBuEXBympVDBUwK7EObDE3QqIGEz4P2pv4wS3QW70OKdfvhjPovpOn2Xuv?=
 =?us-ascii?Q?+F0XM4d4bg4I+xp6+hNsUfmX3dDoKdFFZTFocSufSv/ytg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7HNj1Uu6bXTORjFx14/NfAaB2HDMSsgLRiUtkhKmxNr08zR225mpy5oFwzgu?=
 =?us-ascii?Q?wtmKQQrnv+hxi9X8g4nw7vZPgqifRSwesyCDfSq9RxXf9wWt9hk3iZO7Dzc5?=
 =?us-ascii?Q?GGZQJ+hU94G7x/Jrx8hx0/lClqD2vuHc0OlGOleTyG5TIS0nCA5qAQlnIKWP?=
 =?us-ascii?Q?8UGASjfdAHze9+KMekxY8dZRPsvT8P4YCpja1DQ3w0rT5N92LV4PgkiP0byg?=
 =?us-ascii?Q?Tt4bgdOwD25o8Uw+HFjSggr5eXY1osFdKz73ne5nUdWK536XygkFsDKrK3bN?=
 =?us-ascii?Q?99O5XnyVAJ8pCzdVRZeXkw9VSHmNY0EPvQ47L9m1XnfN2LzZDqLbkPBhZ2Z/?=
 =?us-ascii?Q?PUg+FbE5arBgpu3TDLz1RMz8rvFHdS1tQJWG2nQFsllPTkHX8nowb89RZMPY?=
 =?us-ascii?Q?0Esdg7QxqHmx/6wqD/5wCvUKdYoQXoqgVkm8+BCU85U7iGhsJ9UX2vt9wTuE?=
 =?us-ascii?Q?fDz+BSkYcF3AvA90cQB6QsKbLbGbx5un7JYS9RUVQuA96xeWYMbBU3R707Je?=
 =?us-ascii?Q?cTl11eUMAUJ4KZnF8rDmGUzMtHF6o1qQnN/YbvM/z/Otl91HDPGO42lCver5?=
 =?us-ascii?Q?R1dIR3/XJGgU4NwPA/09FClVuxtd2ZUZYSOmJrWuz67ZG9+cOELaFNK1HsU+?=
 =?us-ascii?Q?M1lmeAXRHPbN0N+EPK1yc3rONXIGr4n/l2XPUqLFqaKAUygXgESTFBeGxvHa?=
 =?us-ascii?Q?iHjlnmodPo7ilc4+5kHYJ2f8DwAd6CxQRN9A/Yofxf6vUOGEShqLGPeYfLzy?=
 =?us-ascii?Q?S8cTUAfD2sakT+vS6LRIWdU1Fu+TsBqrN4omaHUvoyLCnLYvnQJm1N3hXAnm?=
 =?us-ascii?Q?HG0Cy7PNQwfFs5mpP6lb3KnsJ0VvvAQW/JnUsuykh+u1x8AywZ8IsYwdnwh5?=
 =?us-ascii?Q?1gJwMXSg8e/xxrlUTzXIc0XqvH4jmf2sIrbb3nGBlU8YBrZ4Z74/fU4xfG5A?=
 =?us-ascii?Q?xb8mO1pc/s4Kzx3t2iPCV7fmaTIMRSv5E3CDn0Hh+I+3xLmpEDA+mSPTXInd?=
 =?us-ascii?Q?VwNOjRUZgvx8BPna63qiUD72zmSwfunGzzkwAQkriv3ZEkzh4MM+TZoAZ1Lv?=
 =?us-ascii?Q?0JQSV3bYXIfpwUbZXQ/WIVHw0PZcnXSEvEJgxhOyKXVJrvQ4Khvb/JBb3/UN?=
 =?us-ascii?Q?2cXc0QgU4HjvSRva8C5n3iP6z1hPjrX88SqcowneidpPIbUhfeua4m+w1SQO?=
 =?us-ascii?Q?IdDLdDJ0Uf8ewsOcxM5nh5A5uK7/VsIx7nSBjJcltDO3BxMXs1EO8VC2xFcH?=
 =?us-ascii?Q?jRBNMKHuQxoElOYuzuRtUHkTNQIJvHT2b/vshFLHWSGUahCDZ76JGbUPwe6O?=
 =?us-ascii?Q?TG8xCn2IgJgfCoCfiMiAzwwk5pDF2IIgerYKOD+OR7DgpO807zHHT01XgSdD?=
 =?us-ascii?Q?4nZTS6na7ZpmaWINECpDvk/8E8MESN3yAJ2B67VmYI3XMolmWNcfK8L7B4PA?=
 =?us-ascii?Q?X3a3vlW9Zc28gFYZ6jSqQA+iPmniPMqX4LFe4qk/B6qBatMbX7p1yiF8H8QN?=
 =?us-ascii?Q?ZGeebRa6qQqYs9dlV/x6b4vN8v4DEJHgJ7RAriGsD+EOdJs0ksJ70Yhly3UY?=
 =?us-ascii?Q?3XhcXhJGdt6vBvSJ+LE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b1357d-d57d-45b5-4b3d-08dc68cbe5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:13:32.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkrAy9aDB5Q7/8RmX4U52N610eJLpGu+J9naZpOJy8tZfs0kw6+lP3s/CGAMuncD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang, T=
im
Sent: Tuesday, April 30, 2024 11:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning

[Public]

[Public]

Ping ...
> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, April 26, 2024 9:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
>
> Clear warning that field bp is uninitialized when calling
> amdgpu_virt_ras_add_bps.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 54ab51a4ada7..a2f15edfe812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -395,6 +395,8 @@ static void amdgpu_virt_add_bad_page(struct
> amdgpu_device *adev,
>       else
>               vram_usage_va =3D adev->mman.drv_vram_usage_va;
>
> +     memset(&bp, 0, sizeof(struct eeprom_table_record));
[Kevin]:

It is better to change code  to "sizeof (bp)".

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
> +
>       if (bp_block_size) {
>               bp_cnt =3D bp_block_size / sizeof(uint64_t);
>               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
> --
> 2.39.2

