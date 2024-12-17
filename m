Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A337AE77184
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 21:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BA710E062;
	Tue, 17 Dec 2024 21:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F3S17BWN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9792D10E062
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 21:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHp992QmoGdeVdhgB69TBcqmt+lqDtzF08hn6zqk7X6/GKOuF2y5XUJIRd6rTx26TiE9PFhwbkHCUA5//uECMNBP7IsGyJQxa/8Hp7Up7ZQ5nDRXCb8+oxbIZLBYcF0m4SaIVUVSJ36U0+2z4cwWC24HKKujtS1kThmKfU/XpHGW2S74ZHnkb9GLAyWq6VYEpKJKnCKUIC7BASAMB6o2tyVBLjeBAzV05EQyR6KvR4wYZMxEkjjEUGgym391ykZmvcv3Lj0GtChOOD6tONnSY85vZDEt3tePHdO6SyAOsKMnDgApCjasvwp3OxSWAqEPsuhBBZfcMz3HmWpJGnibwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btolaeftaBqDwQXyWKFWaSVtI2pmNU7Bdm5TZCQUjNw=;
 b=je6NhPBmwdUucVERDVtda33mHgHZOjhajOBpGz1bKEjZShPQhz+YEld0GeiJJtjf26x+rxDrzD6LD5eo4V8XhamDSPwmAWlBo+szhN9ri9U0d5X14X2ottsctMZms22iqC0guhqz3zb19Re2p0i2z7mLGXqEhyxtGFdiyUSh77hVJtanUSy1FdoseNbS5suEV8im2/ALnUFWVuONfA1VWsp236pKLHNcwuJCbOwsSB4sTNJipLkl1mK7Qz6n+MM69zQs+txJ2rtq+WBH/kwKbvQV7EZFBM97aD4x8Md/+w9tAJS7r6ZuiHcmL4YRZ2HV1t4y49j/+EPxA4Xz9E4yKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btolaeftaBqDwQXyWKFWaSVtI2pmNU7Bdm5TZCQUjNw=;
 b=F3S17BWNzC8nWsbfzPpf6psRNak5PmWSSXS6kkg/DG1ImC4PY5spJhaKpO4/imkLphR8qI+NgwfnoxpzMHJ0ztbpKXVyisst3RoU8TmFizL65dPNEaoSwUyITXUdhskj+XRmyJU3YgvH4kgbWqi/9p4QVzUtyiqs1WVQyFoPaII=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 21:22:33 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:22:33 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li, Sun
 peng (Leo)" <Sunpeng.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH v2] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Thread-Topic: [PATCH v2] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Thread-Index: AQHbTIYtI3rmrEmtl027HY21QI1eULLq+c0g
Date: Tue, 17 Dec 2024 21:22:32 +0000
Message-ID: <CY8PR12MB8193BA9C783152B8FFA9D05E89042@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20241212110808.956179-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241212110808.956179-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=42032737-c72f-4837-9701-5df9541329b5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-17T21:20:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|CH2PR12MB4183:EE_
x-ms-office365-filtering-correlation-id: 01c6904c-568f-4a10-3a26-08dd1ee0eb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?z+86pRh1Pl5Q8kQyjsYKkSQgrwSjJ8l1ncpr8gk9ARum2R24nqVqwC/Kf3oP?=
 =?us-ascii?Q?ocLgyYcpD3Yiy9z4FcvEPOrCsPm29WC4edwZpAxwIAEXubZnHYeAjGrTLK5Y?=
 =?us-ascii?Q?gaH1a76cGW47Wj0FRLqvJk27GHPT/lp9nbKd8/qMs6WjU9NocZvt6IuxYxOG?=
 =?us-ascii?Q?RBKlIXI2RL5EqoXbOcygh2T20OehEzoQkqIwEy6/1saTcQLDbFYIsfd6WGDG?=
 =?us-ascii?Q?lsXq57910/jDiGLTScLHIs0x2d0BA0wr2fEeWZFsXtJ4YASyJ6+BcrOgAqwh?=
 =?us-ascii?Q?+hKhfmjk+3StAJpN7PlTTVfbAC/nx6KsKWEkqaYCGNqHPl4dfCLvhlE+SSyc?=
 =?us-ascii?Q?NTskpnfm19xjOkHe2SBAyp7xRj1mrkuiRdzFGKjSj8B77YyreWIE4wEfIP6y?=
 =?us-ascii?Q?wIYd/7mha21c8nZiL2a6LW7U3j1papGmSYb3p27XfhxFBRW9wh/1vv6pHgaF?=
 =?us-ascii?Q?ToC4fLZLXHUTrQn8nsWAUemqlDjL6hCbwtREzp3J37WuaLjYBLzpqyBUWfOT?=
 =?us-ascii?Q?NCs1f0BR5mOPI0V/nJKG5KM+qfcRTGLDHgq9gXgNLtCuVUO5ZgIp4NXksKPw?=
 =?us-ascii?Q?NCytF8H4l/qv+9elye9BJAKwc0SCPPg69cE4dONVLkwa/BA5dwrXQjKGtAiI?=
 =?us-ascii?Q?NNEq/We1lFQ73WZNBwJZnWwmZ7BPdDtAaNEN33AD39AkYbjE7z9j4MeFXDZT?=
 =?us-ascii?Q?QRABxaH75pQ6juwPHdpFDiMGsb4w6JRch8ouCsZydac5cfZXySj5gByrVdcz?=
 =?us-ascii?Q?iNTfrXhhmIIiDfFWkWh7Xz5S2eQeQtonRX9md7bMbP2mAjr9PfnVlby+vsLP?=
 =?us-ascii?Q?rEeK4MQBGfPgLOjlSayMkN9Uh2lyhMGO8BUsvNbQjbYy7bdT4FpEF2or20FD?=
 =?us-ascii?Q?5sRhkPv250Sd/7vNzxz0ZTqwvjjz2uHy90VvygSq5RHEot8NcmsiwKgQ7Jxg?=
 =?us-ascii?Q?BUsu6jnnFc3I23XhASygDYdRku1rbnunRCRX3csKz2Gluf65nIL8Dxqc6sEI?=
 =?us-ascii?Q?YUhDB/RylauN8Hkyg5EkzH2a8NBFRwx+1mrmUlYWLTcRc94RHmk5FIW87Olf?=
 =?us-ascii?Q?pAwwMd+DpjU8B6xPPr8ssoZgKvCeAgAvXrLtJhkgQdvC9ty0HR6ANfXzacfC?=
 =?us-ascii?Q?8zc9fF1XIU/DfBCPl2D03oKO6+gMa/Mf+S8ZXi+Wh4Ewkt8l3tu/yCnTRqL6?=
 =?us-ascii?Q?FhWxppYIhQZmwyVMeclI+i6Acjb92yJexAUJSNdbIeKNDFZJEBfkzZwjbs+t?=
 =?us-ascii?Q?Rc4Nzg0JP6E5lggr7sd7iN6NmSi1/EVrHT/RXg3lULKhCYFJhCVM5usYwKFm?=
 =?us-ascii?Q?kcNi9oR0zUmhJ5b5ahWU5qU7JeugFBOMNuJagKTo4iWsbiP9GmTTXlN4BxQW?=
 =?us-ascii?Q?wtpykb375YDV7IjwJiRhvtHj+QZrcwMjnONNejAKPYZxn2ojS63iKrLRBSFb?=
 =?us-ascii?Q?dp+DeWd+mMZSWZ9n0ZDS9zig/S5Djmkm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GJDvNBEtkSQSu6lemrE2XjV8paWD9U5YJJZ2aT4UDSKzDVmskhKFwJcGrRDs?=
 =?us-ascii?Q?KAdKGsnbouwoveymHTdV4daCLu5fLGeiBbGBNtUA/WUky8MrAdFwMt4k30yU?=
 =?us-ascii?Q?QmyiXVU0IC/L0n7bWr7sXZ5vFl1PGpSrJIOD/7CGQCMyXR+0dvWVGjVcColj?=
 =?us-ascii?Q?UTwsVkjNzOUCVHIpnx/urwdJQfUW0RC13aSAGrfs7ISufDgMuuC+zW3QU8OO?=
 =?us-ascii?Q?DU/bqvjBRNSgrARheaEegyrCFGyE46UEp/T0MGfRDteuyoquktMa7rmAURsT?=
 =?us-ascii?Q?94uSEhJ6m2L/lIviX0qCs5rxWdVwtNoovJpGiOfFcBfKDsX8Y/B8HiJ4Khuz?=
 =?us-ascii?Q?SMkxFDYug6F2OtOSllaHSqIekigI8q2Wd7NYN89ZhhET8+MGv4PRb4ViVXCk?=
 =?us-ascii?Q?DgWz5z27lv12Qr8o4YllonWx5xf+xb51m4QK/2ki419OegYAIRcOtOgzT6ac?=
 =?us-ascii?Q?FQa5rBxtdftBmbq+wiOqxmkkjpFnvNHy6gilFeBJBnrhzAIkDytHR9PSvEcd?=
 =?us-ascii?Q?OCaRhoSd4n0S4CXkNBpd2PItRTxbB7IXFJpQnzn+0FOtihO7xSeYr4keZnBo?=
 =?us-ascii?Q?XylhcIiM//OCsQbEc3hhX8huqPohTfNiCq1QS5JaEnQhoLgZ3+tNqWwxEn1u?=
 =?us-ascii?Q?Yda2EvxaboUyLHOxEJdl7t1fV/ZfPygHscXCZTCuxB2KdTLUjahNkUioa0CJ?=
 =?us-ascii?Q?kQ3B1xU+zvpGdmNObN7YqS/Cux/JZCDFNUpAU06eDRxXq7cNxt+z1QpjFeAO?=
 =?us-ascii?Q?k4c1Lb/YfcGiTKJuxPyAON7yS8BN9SMxkLPzdta013CVNrep4t45i7TZ0QYy?=
 =?us-ascii?Q?onyAdDCPXfEtfUTckQmLHb9NBFeufqecC2fcm3sjJViKh3lRCjDi5qy/2F0D?=
 =?us-ascii?Q?93sbVw9e0Hp5aCLkLv2bfb+zNfQaFM3Bg7jbMtrWFHOGeB4TaKr1TBW++5fu?=
 =?us-ascii?Q?AT4gnfuireDwhEaqfoxdbrcey96QPLhxXRANOLQTuKNyqeLvXTmss55l6R+Z?=
 =?us-ascii?Q?yF6fpwXxu+3UetcMoosVk2Dgnl92ejzjr+Lc1W3gWF0IRJEH2jUBNp3dpGXu?=
 =?us-ascii?Q?ZtFkwk1zexClT2hA6RoGl73L49ZiG4hXIxuJVFg6AMkncvnOvNNOOHHPhoh6?=
 =?us-ascii?Q?HcTRx4HhC7yMx/lwgxlB3ETW+23dOs7Fhfddy/hvUo3G7jRVeuNmfnZpeobj?=
 =?us-ascii?Q?sB3CbFdqWYyIKjOuGhzHHalfU9AiYsocEqTgjr3cApDFxsSmaeQrRlENah+Z?=
 =?us-ascii?Q?PtqXydP1sQobOGV3JlWQ0hnVUOjivPNySn6tWByWfM3lTIGCq5t9N3xffsDZ?=
 =?us-ascii?Q?B25vMEbYZQNF7z03jaj9jlNgbtr6QOWRd+mudU1hp7hkb0D3QnUzTTesGOVF?=
 =?us-ascii?Q?pYJluetBgbK5fMfowKbgfEGEzgGwQc9X6Rf2LwLUACaxYNhWugpP63ekvA88?=
 =?us-ascii?Q?2ams/nb9iTbTUloDZIjg360MUV1S3CBIssjxUXQ30IHJuRUdRa8HBP76SGKR?=
 =?us-ascii?Q?qe6Ffsd0ukUVm52J/HSobJ0fybuzyf2S+nATF6KcfXVcOM4dP/0Wl0yMJntR?=
 =?us-ascii?Q?S6m35F95tu3hQ85woDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c6904c-568f-4a10-3a26-08dd1ee0eb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 21:22:32.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5w9IkCS3mKEDpmi23VaMg3bxshAWs7Zzp/BjcRyMWlkWyahbY4RGYXf783Hl/M0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Thursday, December 12, 2024 6:08 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Hamza
> Mahfooz <hamza.mahfooz@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>
> Subject: [PATCH v2] drm/amd/display: Fix NULL pointer dereference in
> dmub_tracebuffer_show
>
> It corrects the issue by checking if 'adev->dm.dmub_srv' is NULL before a=
ccessing
> its 'meta_info' member. This ensures that we do not dereference a NULL po=
inter.
>
> Fixes the below:
>       drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
> :917 dmub_tracebuffer_show()
>       warn: address of 'adev->dm.dmub_srv->meta_info' is non-NULL
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
>     901 static int dmub_tracebuffer_show(struct seq_file *m, void *data)
>     902 {
>     903         struct amdgpu_device *adev =3D m->private;
>     904         struct dmub_srv_fb_info *fb_info =3D adev->dm.dmub_fb_inf=
o;
>     905         struct dmub_fw_meta_info *fw_meta_info =3D &adev->dm.dmub=
_srv-
> >meta_info;
>                                                          ^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^ Even if adev-
> >dm.dmub_srv is NULL, the address of ->meta_info can't be NULL
>
>     906         struct dmub_debugfs_trace_entry *entries;
>     907         uint8_t *tbuf_base;
>     908         uint32_t tbuf_size, max_entries, num_entries, first_entry=
, i;
>     909
>     910         if (!fb_info)
>     911                 return 0;
>     912
>     913         tbuf_base =3D (uint8_t *)fb_info-
> >fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
>     914         if (!tbuf_base)
>     915                 return 0;
>     916
> --> 917         tbuf_size =3D fw_meta_info ? fw_meta_info->trace_buffer_s=
ize :
>                             ^^^^^^^^^^^^ Always non-NULL
>
>     918                                    DMUB_TRACE_BUFFER_SIZE;
>     919         max_entries =3D (tbuf_size - sizeof(struct dmub_debugfs_t=
race_header)) /
>     920                       sizeof(struct dmub_debugfs_trace_entry);
>     921
>     922         num_entries =3D
>
> Fixes: c506f6e03b18 ("drm/amd/display: Make DMCUB tracebuffer debugfs
> chronological")
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>  - initially initialize struct dmub_fw_meta_info *fw_meta_info to NULL (D=
an
>    Carpenter)
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 11a7ac54f91c..2d31836ecb98 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -902,7 +902,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, =
void
> *data)  {
>       struct amdgpu_device *adev =3D m->private;
>       struct dmub_srv_fb_info *fb_info =3D adev->dm.dmub_fb_info;
> -     struct dmub_fw_meta_info *fw_meta_info =3D &adev->dm.dmub_srv-
> >meta_info;
> +     struct dmub_fw_meta_info *fw_meta_info =3D NULL;
>       struct dmub_debugfs_trace_entry *entries;
>       uint8_t *tbuf_base;
>       uint32_t tbuf_size, max_entries, num_entries, first_entry, i; @@ -9=
14,6
> +914,9 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data=
)
>       if (!tbuf_base)
>               return 0;
>
> +     if (adev->dm.dmub_srv)
> +             fw_meta_info =3D &adev->dm.dmub_srv->meta_info;
> +
>       tbuf_size =3D fw_meta_info ? fw_meta_info->trace_buffer_size :
>                                  DMUB_TRACE_BUFFER_SIZE;
>       max_entries =3D (tbuf_size - sizeof(struct dmub_debugfs_trace_heade=
r)) /
> --
> 2.34.1

