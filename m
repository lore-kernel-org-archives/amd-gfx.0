Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7C6CD6E5D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 05:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4780210E44B;
	Fri,  5 Jun 2026 05:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBIrvATu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA9610E44B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 05:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF8gBzidHoZsVb5j3p+kQOTkctqxq8WQFqqWseNo8RaEPrlLuRD6Cl6bX6yU9k7E3d4aqbQ1l5P6JwxeyXg7d2k7+tAhWp7YTo6gbg4hYAnSsbUE1/wl2s4WbTxjAEqMBlxz6G2rNDNQD9/j23k+9iYG9bkllrw58tYoK8jD5xGwZhRl40PFYsUAgh7XrOPgIOHexgl45d2um+Ub7C/qqBeJQWuG9xbbtVwKxK96RrX+SM6WsjiJhkdll9ZXHZz+djmEsT1cUfjNvAQkeF+27Bst1SbHd5Rs2haGqyMQ/tA93D32jaTAPXaB9WnKhfHk7RRgkH7xEmWJCC9S1wMGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7r6HlVafpEdXGqPtUCpmYbIeZr7uMFlYMCDE2tNRbw=;
 b=WA2y3NUBsb58w+fLHwQM0hwfoi4Yyn8ZO+GG+X7vR9R3fX7vyX4bkehEOvlwKE1pI3rguDKzdTLqnSwCCBaIYhlAnEoWPNJYeUXInolrur9ObrjU6zMC19NemY8aG9lkAFO0I0nr3/c7S12FXFnZRbrpeOc1l4PiNtbJMgwU2TIleDGV25QD87aq8qbzoJgRgeO6sw63zV6YAbjXMgQkzb8kgJxAI79z8aLFICiFuQ8lzaZGG37pRjWodb5/g3BbiEK8yl1a7kXyX1tMcrwlZgT4s/7C49upsfTZLOBYkjPXwsvJphKptb7DwSPO+WSfUeQrgYpZBLgT0T//lRTyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7r6HlVafpEdXGqPtUCpmYbIeZr7uMFlYMCDE2tNRbw=;
 b=GBIrvATu2I/7XYmUX3HtZsNdivZFwb1yRk98En/IGOWbRrjJ6ZWiWNgxYV9GlXW490WkBuf7YN7Gror+zck+WPxjej34dvNswDAmytjeMSSv4O1IPuD9ixs0IawjNqsMq11cBekG1NxZFsaITBc2FGsQwgO/YPDpCh18LV3bGJw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 05:07:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 05:07:24 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove spurious line in
 amdgpu_ring_find_guilty_fence()
Thread-Topic: [PATCH] drm/amdgpu: remove spurious line in
 amdgpu_ring_find_guilty_fence()
Thread-Index: AQHc9GRfOxo/H35OL0SKEqx5AGaFprYvaXPg
Date: Fri, 5 Jun 2026 05:07:23 +0000
Message-ID: <DM4PR12MB51527046A13302380DDD8915E3112@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260604205423.14358-1-alexander.deucher@amd.com>
In-Reply-To: <20260604205423.14358-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T05:06:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB7628:EE_
x-ms-office365-filtering-correlation-id: 0ec71e96-6b0e-4450-38e8-08dec2c0547d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: TzHHfBQNOoH05Yex75E78fQ/bTQa6JugWhSjfPDTuOxFhEHTjAQXlWdbZZm84EdvBm49UyE7xMtbKwAWcsvn7qdDLEWGrY5T8WLXxtTU6MyAJ6xlkod8ZfodFJ5ltsGh/9lHzsF9ef/8JlbPLkkfJu13KdVKUCdYRbTD5TsH42UEnbyzcloeEImkVSaJl+zeGyLcEauVoEvoT2LnTV6FMGTZtNuF1SPFH9uUt1SNQCRZW3gQUjFuW1QgUbCzal3bpaa4kurvXikS2kWONeskNkhu+q9Zx8y/70ZJccAJlUIkrX8KYl5Ua67SvF1+UJvfuFaz9VaAG0yyUBDjBzlZZlh6UIa+1XDX+0sXf7f+cmEnmbbEi9We3kee8IR616kNXNxu1NhBpSe6ogxfdrTUKuEgT37KJ7Q5ucUfaWVdEeamFPpccsSUYMxitqDymPtV/cArUSMmo89sms2fdwnaaiV45veWazhIn90hPem1EtKg5p1W2jk8oYg17pl+FoQmfU1CxFHXT6hQaul3w9Jn+QWnYQyneEjHypRo8csk6LEHWD+gqhpwM7VpDtMz/dUoL3rzSkym1WyhNNG6/KVnDO/atoU/tmtG+1H8VnEtrqkZISY1d0oQeZBw2p6OGVNhUKO2l1TT6ESkL306lgqJOyY1mb+iR0/nyp8ejxL1bGOXQsdxwInkZYof+qslnyhmHaFnZqezEcEqUXyNQMyySiRe0EN+nquVnta3ZIIFIww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VkBe8ud/D+8YEb88R1JG9MmK8N1wLSDJLCvUgseI5yETPBiRbnVCYkisbs4J?=
 =?us-ascii?Q?Ts0L3p/MFZ0HK559CRfizvXZZa6B3FQYS05qyCzOg8NHnQgjlFd4z/YwM2Dl?=
 =?us-ascii?Q?lrdQXyvFxM8mxRnowIcnIG15OWPCY5rAL0aA4V2X5f2ZENi8AfSl1NMuuV9v?=
 =?us-ascii?Q?U35YfxNkVDuwyJndjMplG10tBCS/Kdo67aJlQeIg+mifSPt/iEwGnrDNmZnA?=
 =?us-ascii?Q?RYpzkFTPkAkcH4rIL6Jy2Io6AJlSlMTmYCPYjFzQqRo1N6p2PpV2Rpi8Yy4R?=
 =?us-ascii?Q?qqU3QEFP0skMZlH1rlZ3BZBg/a3SY3obY2xOzeX8qclTitoBv25Ow0U77ShZ?=
 =?us-ascii?Q?XTknR+Z6/karIna5vlZ1deAaLQJUUR+ePuk1Q8Nwh1GyZBhnJodQLKDER4ff?=
 =?us-ascii?Q?1JRuM2AlSmwLnZqddSwfpvul33Yu8RvWNNx6FcwbKrYiHOa0Ml6VBKPNpaD8?=
 =?us-ascii?Q?LX/b0ml1TlSV9mZgsyhrxlvfDOtoHR3DW394BQ7/z5tyUJi1McebWSgqL1QS?=
 =?us-ascii?Q?cVpRIn6wuZiaUYdtWYVWYOtMWuK20Xs0olrBhWDT3MXhhqR8CYMTS4joeDsJ?=
 =?us-ascii?Q?e30OO0A7xaoK8XgpVcgPHPsj3Ca+KWj7IQKhha29fsN7z2s9FJOKcO6+XY0Z?=
 =?us-ascii?Q?H1EvsKXLr0SB8I02YIC1Xu2DRXz57civL42xJR4nWO3LYiplzaiM5UeUBOW5?=
 =?us-ascii?Q?d4qQt5Kyq9DEKLTU97GXOKSLau09T4nEQbQWu12C9TO6BF9zmYrq1gnTIrB/?=
 =?us-ascii?Q?oa1qPwWoNtKdgBIXnMD2N2W67OnbAYzWU04ovzAX02HNkMpXz3Ci0xvYYy4m?=
 =?us-ascii?Q?QIX5VETCp5BT0oBBlQ0T+gSgeQ622CsY25ifOltbHm8pocK7woeQTBBhWLfc?=
 =?us-ascii?Q?79EuLSlollPLKKzMZ+roFqojpeed7cGLbifyufP0ywBsLJ0AOnkansqyWEh5?=
 =?us-ascii?Q?1x7M8tBA20Hzpooh8Y1pttu69foeObAGXZgI3ggsIBWngwa61IJWRGx3T32h?=
 =?us-ascii?Q?YFl0AEbtfS/tdXn8GgPd6fi4c6tGsWQDKnEBeAbsJCoUcQAVgaX6ilgedQET?=
 =?us-ascii?Q?+fyFpQXbBwBg3r2iIwGAQJ5LoNqFMpzcrVBfOfe5BcgMXuJWKlCh1ccGVlqb?=
 =?us-ascii?Q?m5jzhfCf7aJh8/weyRYsn0mb9xIXtrTYnMLnDF4/TfqJVagfF9XZPwr1doFs?=
 =?us-ascii?Q?c8ob13E9R3K+R8QwPDFowEL4ds0cbW+7sS1c1qvfPYocnsJE4tS1QufzIEVz?=
 =?us-ascii?Q?m6c6J8kHXk41qkWSxED6Y3UU5Vpnaxy1Cd2+cHlfCj6xkXsLvzMCWimyAA5u?=
 =?us-ascii?Q?wGLUuZgrbVye0gyZkmXJuSb/iBn1/1RjH+0umrrSUP560V4VlP2VZ8cf4cao?=
 =?us-ascii?Q?OMKLG4BZQNBO8J0YSMDtLuK6w2OS1fQUgohLBdzrTIsJygNl/NUVw6QTbeF2?=
 =?us-ascii?Q?pM3LB1hNXU/srpWucMRwkUOxdMdW1JKEtSH2YDp2W0TpXHkdUQVgyOr0C1cy?=
 =?us-ascii?Q?cNps85YODi5VkrxiE+O2knmUkgvYInSgw63GGzMDrMZbwjflyX849MIqpIFn?=
 =?us-ascii?Q?kdYV2EZEXmNpEUo3bFM/bXI0DLsz4gD4dilme9JKFH6IA/UkOsAjBD0wJZnL?=
 =?us-ascii?Q?j938lZFbNgXfDgwTeUUohHy+EihbDFzGW5XDjI2tF7AeX+hv5S0/nyGEo2/1?=
 =?us-ascii?Q?HLWAbmvFv7R/7seArO2L9/qURdT5Yx3o7rDJ5YONpJgmLeGZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec71e96-6b0e-4450-38e8-08dec2c0547d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 05:07:23.9698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl9ZzZHYsZEQNMhH0FLL5QJh4oR9f/YgCNbD22yMzOOSHswFoIEMR+InVrQealVKwvDhnsN6kOxaX1tYzQIP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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

AMD General

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, June 5, 2026 4:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: remove spurious line in
> amdgpu_ring_find_guilty_fence()
>
> Copy-paste error.
>
> Fixes: f647ddad8ace ("drm/amdgpu/fence: add helper to extract the guilty =
fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8569c1c637a2b..3043ad041bb42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -842,7 +842,6 @@ amdgpu_ring_find_guilty_fence(struct amdgpu_ring *rin=
g)
>
>       last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences_m=
ask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> -     ring->ring_backup_entries_to_copy =3D 0;
>
>       do {
>               last_seq++;
> --
> 2.54.0

