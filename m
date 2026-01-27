Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044BD25932
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 03:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D11A10E1EB;
	Tue, 27 Jan 2026 03:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aIA0QHZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540B210E1EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QONLq5Mkr3C4fUg9nkJYPTEakxV9K3OIwMpa1c47VjX1ljmfU4MZNZa3ItUNXxF2ZwepbFiHD4tW40LWYrCAk24p2q8wpQa+6jL7r9l4u0Ax8sJD0FQepbc2+xjbfswXLCUrMAqM3tTbbyrojhSGAjK20++eoFlzpFRT4+wJ7kUAQWnakPfHJS2LFLSLxAhfsfeAm2wnlcH1R+W6zz1fAVnh2LR53DK8Vma8RkjNDhX/hcWjo6nKMK6U3WhGKbu76UT9GLk1W84MFBb2BGKFv1384TbwNbZmpgrGa4h2bXwAsS/xdVHK2kzmgARwnSikeaYPMuvtetBCCfsANgWl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND3OpZAfx7XrKcsaZBW3roi7PHUBn4omyUlQ9wZOZLo=;
 b=lRs9RXr4jtmwcB69rvvTj0vA2MDy5uQQ7ZRFo2vldM0jyFla3KkCuMYg/0McgmDEivcl0EgMpbR32cKPYEYz74am/2AG0EG/dGzibCxErVA53ATlOeBz7b0Sy1YwZVY10Jji5CdmW5f1fKUVw87pji9FO/IJsWVehBpzOg97A/lH9D1ccqjw68pMu1bc96X8Tg0awda5rBzlY1xTET0PyK5Jpn0xT69PrHB2toHdC9UGzcDmbYmRdGyU/Lv95LKgT9wyEOTwNf47atD4DKW0MNU1t3OvDK83CrW/wjOlEqidq143LhB+x1NgBKaeAQe62DEKPNysIO+HLV+H5lxHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND3OpZAfx7XrKcsaZBW3roi7PHUBn4omyUlQ9wZOZLo=;
 b=5aIA0QHZvpKhhm2GA7ubLs7HftmN/DS4huDiFw7VTFquoZKBX7kwI9gZOvTiNXFeGOH/bv4hV6jOkHCZ4yscODAypMK226IwsdBwiE+0qz8SByj9jFzvBrTbXbu6mOgryIgQlL9RfjoFfX8S543/j77lcaau5943dWFkc+UtdDw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:57:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:57:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Thread-Topic: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Thread-Index: AQHcjne2GkLhoZ5m3kikGfT7fKLkpbVlZTGA
Date: Tue, 27 Jan 2026 03:57:58 +0000
Message-ID: <PH7PR12MB8796A4E42378800F4616CB47B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-10-ganglxie@amd.com>
In-Reply-To: <20260126035527.1108488-10-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T03:57:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: 924a9e96-95fc-4267-5e5f-08de5d58423e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hVahPAePHjFtCJcjmMRecC5vnq+FaaHnT2UZC5cIpfUnk1TdxbnkyX+FKbBe?=
 =?us-ascii?Q?hOOB62k+NR/2Khu8RXwOEpEzxbYK3MCVcqO5JEGcK7g3+GDc5QnyJLKsr3SY?=
 =?us-ascii?Q?ugah1xjjIMeD1Gu3J00xGIZANF78rd8pH5yyIwtLeg3sJ5G/CD0tqhO0j13+?=
 =?us-ascii?Q?5R+0rCtiTSbnWCdchCR8C3/YckGJhLOHD6L6azQvRN4iqrCBQs9nV++g3ADt?=
 =?us-ascii?Q?Jw6BdZtm7tGcXwS2FI8XW0U/txg1+VJx5Ko2AOwj7gF/eljedwrT883oV5cZ?=
 =?us-ascii?Q?W2dMMHERaI5+LZKW01e+royUvBh7MdYwpTxRZ+BzHF2sK9P8O53cfkWTW7Wk?=
 =?us-ascii?Q?qDaqSuaAXpKRDbjgaL/0cTi/e+r4hG9n1gbGi0jgKLO+QYI+/d49busCptEj?=
 =?us-ascii?Q?SU+2BEcQmBNk4BkY6yv4WBregKUkhokHdBlyMqJp+DTpMMvNHZJay6g+79LX?=
 =?us-ascii?Q?NHhi0JPeeQvPhC0EI89UjMqRPnQtiXwwNPU8BTkvLwQZJ1irw3i0wBebzshI?=
 =?us-ascii?Q?NjjyS4b3EImzGmC9UAtJUsP6GwaxkvF6Z+SwUTJYoH2MTIsVwiYGy7Xx0YiB?=
 =?us-ascii?Q?T84ovIFWDxOHmS8zO/RAVMy8svhVGDSaoLZGDdO0NfnZpwHSmtOMP9hM6Ql9?=
 =?us-ascii?Q?lBUqGp9wUdx4H+nkWeK1rl3pdE1khK490ghqcMKZJDKlDmUeuVL8czG2cOFD?=
 =?us-ascii?Q?tAop0AHqvg6ZLd5jpwNIpvEvFxjSMEksBx5iysUhjg4+jOi3A3LRNdSlktq1?=
 =?us-ascii?Q?LPuXZ04VctOrZ6vGFqY2UI7/HlRojzYnxan//G4JnOuAfHlcRzYOmwJxrfUA?=
 =?us-ascii?Q?26GneE/v8xULlOy8a8Sx1ThJIxs83/IdsrsZMRorhT8ZLZvcxc3DTh7lNjXH?=
 =?us-ascii?Q?Mi7bJm/7UNxW+onbsI1sywr4HZxxomjOS6EeBQ0dN7HZPiJ3IjOXtqQl5sAk?=
 =?us-ascii?Q?KCPNcfcOj2ceQeffFftogA6LjcGLgrvCl26u+ePhi5QHPl8rU3cSoA89yRRr?=
 =?us-ascii?Q?VeRd33mRCi5tAJ8WYe8s8srkz1MM2t0IJDAZdmo+XD7N9eFsM0mALiu3VY9f?=
 =?us-ascii?Q?iMIxO2KsjZ3AHvhwnEacJB4yuQvc3quXqXjeyc357bFhjUcNFllpOz+pLoTy?=
 =?us-ascii?Q?PuQdqGC6ppTO4kZVQW9MKSKny3Z2KO8KD8XMgDOTtaaUUA/OPjDJJE0PPW2E?=
 =?us-ascii?Q?jxPxlBdNf3ijXbcTEHStaG33gHPHRItkWl7SH9BeEvcDh+VK6635qMtINQlI?=
 =?us-ascii?Q?UARufl84Lu6HqaId0b+JHHlTfyEscVWWs6J4g75wB/JDZEEvJMKYKCiJMKPZ?=
 =?us-ascii?Q?XSBJsam9LHCZWkj6L4yIpvlaub9p4Vc9HiSw2W30gDCu7FNEfe33hL0KAvnF?=
 =?us-ascii?Q?yfRHW6RP+Q5dfkhdcKpHi6vobxXWNOnZK5tIi6Gc4+WYcs+YxjNaIGpjhcJ0?=
 =?us-ascii?Q?0Wemduc6Y4S8rNkJ4MWuoVXO4nVqO0qW4IsOgBJLsYO8Qx7++uOoHW/1RHK9?=
 =?us-ascii?Q?v1bbLi7KXzfS7/0rboClL8LMKVP4PYsV67bxlFN20Fdl+49KmDDvPBFEZqeU?=
 =?us-ascii?Q?58pBedbRrSWMQnRRCYjqAmIKSGSwGMdIpzqRKnz2kto/DwcynLWOLx8oxAEO?=
 =?us-ascii?Q?PGrmFAQpLbJe3LKYHS2Z9Zk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qPcs1xOhc38xXicIJGWeUTvOjUfsqMqlRpVvTrXImzEjW/m2RgiHPoZ4p2Es?=
 =?us-ascii?Q?a9s5SOfIc11USfECjhhYjtYJH49ULLYdUW12Oxm/M7lNNd3xFyblOfQKbbJw?=
 =?us-ascii?Q?SXOS1zbCwfdpkPX0A4M1XeoP59wF5IbJHjqtCRou+5Fnx1fxgHXmvTBscGcp?=
 =?us-ascii?Q?wcliRicTj+LZpPN0pJrxUCL6i8M2zBPcWBO5sx0HJciSbct9KjrEZHpicBad?=
 =?us-ascii?Q?wDXDxFrEZH8Ufjui1zcdjcYuFruFV92UfIYm/51gl52hdjl5PhT8BI5rbzib?=
 =?us-ascii?Q?zXG2Mluc9CzkaP7nZzAlCBMSJp/rkEicewk2RAGiHsmB6MIPnCvE9FH5Q2xL?=
 =?us-ascii?Q?r2COF1pujnlfHLe1gAGjlg2+5ng424Pe0+pDcEhTt1BM5zIaZRn2zVvh+4u/?=
 =?us-ascii?Q?Af2YGEnyb/Z1f67kLcMeGfKmwxr0SoU75Sb7C3wyQhDNIQhlvJKHk9iGwQ5b?=
 =?us-ascii?Q?RypsNacOWmaBopYf4/48yXJhJJ3P9BOY6QjJObh8VAJcRn8I7XJQaskfwvv3?=
 =?us-ascii?Q?2buzL6bm2QTlyZG6BgKyp6+YVdBxMJ8LU+1Wd5dxtkWB1+wgOwNb10rarsgR?=
 =?us-ascii?Q?RgjzeUSVRUxllqb++/TzAXwmW+0ENU57M4/jMPHWYFbQ79mx+InaJC3On0Ud?=
 =?us-ascii?Q?SG2dlfXWRclIjzQeSLn+oMNJMkMfQwppxD4A2neW943XQg73U7xxxYuTNPsM?=
 =?us-ascii?Q?A44JyCfo39rH1Q2+yN4Xust+66xSJ0AbEFBVxH1IGNZf3t+WnSNyTNwuR1d5?=
 =?us-ascii?Q?4weP5T1R+s6biNpxXWXYGkNJDKHZKtZwaVukSotR8XPL88BUqdtyq9xArk5U?=
 =?us-ascii?Q?N78DKJuuo2ZIFIDFZ1wCbLLpsl51qsF4rdTMQZZVALW9UGY/viJdlM8jLA2n?=
 =?us-ascii?Q?PVIToxg9COz5dLQFXQdqGA+XE/+EEMT6LVq27eOrCAIakgaJDt7AlKHTQluV?=
 =?us-ascii?Q?EgmXTJLfV0RPrt32qKtR9YlsMdV2w/q0RQKA4GN+8m/7kgRquZMDz8+631Zq?=
 =?us-ascii?Q?k9DXf9en5vAyNRy71127TsIhqpXbgtId/gS3vnia9xvg+fzyTXmvOBr7Q46E?=
 =?us-ascii?Q?xWK6AiKyFhRbhQbEQ9IuS5Xql24G6CdkZARIFitFVtGwVYU00uKzqrlmcgWQ?=
 =?us-ascii?Q?tPLxr6D8FsRO98E7tyY2BkW0QRhNbKC/9ffjkh7HsX40h6LRnGj5NKpyJFuh?=
 =?us-ascii?Q?D2JIK31SCu9ghs1jl6+v5hzayE8cjFlKcKh0+S132K8eARyE+jWQKatmPWJQ?=
 =?us-ascii?Q?ufHwfXgEnug5cglryT/UHU2FgDgWW/mqJIRDkbY7cFhdHTwEQfQj8xvTTUt8?=
 =?us-ascii?Q?szUHY21/Lp+l9cTZ3xBl/+/ilGVeeskAm4W5b33/lS3yBYkFlT4nMVvmax90?=
 =?us-ascii?Q?J0bQY6Ni1yZZRfd1zxMuJ6qm+pm78RvFZmpx7ehyGTKjJxSjNSnwOgwVnpYl?=
 =?us-ascii?Q?mS/vzBr3IDhOqVWCU7Kw0QhdLmJTJQ3nx1TYcX1RkgqXsXImNRAfH5wX+WxB?=
 =?us-ascii?Q?Hf82M36lI7fnRVpn/lhhaVfBWbZAhpVxYwbuEUU0rWCSQlDfvHNIyqGgo6J1?=
 =?us-ascii?Q?CziG2lDKf2Q98b6ov5pz0g+wPqa1AicfFzPAqMx2yNrkMuNilxfUS3kwE8cr?=
 =?us-ascii?Q?09mvA8KKr23wSoifrL4xYbND5Ir2xVPr3+1qiGZrjiVzutbgXnhbx6EPesxl?=
 =?us-ascii?Q?lYDDE0eG9UWzFDCfTYI5hO3WToQ2bx5icJ4a3oVU1Kuq3Dvq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a9e96-95fc-4267-5e5f-08de5d58423e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 03:57:58.2445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+vPOry8ntBFgvXhtUETvBhM8KAKO4sEXqYnMpajSrfeAiNoCs7NAZR+vgTnKRK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
>
> add read func for pmfw eeprom, and adapt address converting for bad pages=
 loaded
> from pmfw eeprom
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 70 +++++++++++++++++++
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  5 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 27 +++++--
>  .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  2 +-
>  6 files changed, 101 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index ae10d853c565..05c7923e8f0f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -241,6 +241,7 @@ struct ras_bank_ecc {
>       uint64_t status;
>       uint64_t ipid;
>       uint64_t addr;
> +     uint64_t ts;
>  };
>
>  struct ras_bank_ecc_node {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 1f2ce3749d43..fe188a5304d9 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -239,7 +239,10 @@ static int ras_core_eeprom_recovery(struct
> ras_core_context *ras_core)
>       int count;
>       int ret;
>
> -     count =3D ras_eeprom_get_record_count(ras_core);
> +     if (ras_fw_eeprom_supported(ras_core))
> +             count =3D ras_fw_eeprom_get_record_count(ras_core);
> +     else
> +             count =3D ras_eeprom_get_record_count(ras_core);
>       if (!count)
>               return 0;
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index f7a6f2368530..69e1aef67ab9 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -259,3 +259,73 @@ int ras_fw_eeprom_append(struct ras_core_context
> *ras_core,
>       mutex_unlock(&control->ras_tbl_mutex);
>       return 0;
>  }
> +
> +int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
> +                      struct eeprom_umc_record *record_umc,
> +                      struct ras_bank_ecc *ras_ecc,
> +                      u32 rec_idx, const u32 num)
> +{
> +     struct ras_fw_eeprom_control *control =3D &ras_core->ras_fw_eeprom;
> +     int i, ret, end_idx;
> +     u64 mca, ipid, ts;
> +
> +     if (!ras_core->ras_umc.ip_func ||
> +         !ras_core->ras_umc.ip_func->mca_ipid_parse)
> +             return -EOPNOTSUPP;
> +
> +     mutex_lock(&control->ras_tbl_mutex);
> +
> +     end_idx =3D rec_idx + num;
> +     for (i =3D rec_idx; i < end_idx; i++) {
> +             ret =3D ras_fw_get_badpage_mca_addr(ras_core, i, &mca);
> +             if (ret)
> +                     goto Out;
> +
> +             ret =3D ras_fw_get_badpage_ipid(ras_core, i, &ipid);
> +             if (ret)
> +                     goto Out;
> +
> +             ret =3D ras_fw_get_timestamp(ras_core, i, &ts);
> +             if (ret)
> +                     goto Out;
> +
> +             if (record_umc) {
> +                     record_umc[i - rec_idx].address =3D mca;
> +                     /* retired_page (pa) is unused now */
> +                     record_umc[i - rec_idx].retired_row_pfn =3D 0x1ULL;
> +                     record_umc[i - rec_idx].ts =3D ts;
> +                     record_umc[i - rec_idx].err_type =3D
> RAS_EEPROM_ERR_NON_RECOVERABLE;
> +
> +                     ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core,=
 ipid,
> +                             (uint32_t *)&(record_umc[i - rec_idx].cu),
> +                             (uint32_t *)&(record_umc[i - rec_idx].mem_c=
hannel),
> +                             (uint32_t *)&(record_umc[i - rec_idx].mcumc=
_id),
> NULL);
> +
> +                     /* update bad channel bitmap */
> +                     if ((record_umc[i].mem_channel < BITS_PER_TYPE(cont=
rol-
> >bad_channel_bitmap)) &&
> +                             !(control->bad_channel_bitmap & (1 <<
> record_umc[i].mem_channel))) {
> +                             control->bad_channel_bitmap |=3D 1 <<
> record_umc[i].mem_channel;
> +                             control->update_channel_flag =3D true;
> +                     }
> +             }
> +
> +             if (ras_ecc) {
> +                     ras_ecc[i - rec_idx].addr =3D mca;
> +                     ras_ecc[i - rec_idx].ipid =3D ipid;
> +                     ras_ecc[i - rec_idx].ts =3D ts;
> +             }
> +
> +     }
> +
> +Out:

[Tao] better to use 'out'

> +     mutex_unlock(&control->ras_tbl_mutex);
> +     return ret;
> +}
> +
> +uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context
> +*ras_core) {
> +     if (!ras_core)
> +             return 0;
> +
> +     return ras_core->ras_fw_eeprom.ras_num_recs;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index 27507bb38135..7daf903ad5aa 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -70,5 +70,10 @@ int ras_fw_eeprom_reset_table(struct ras_core_context
> *ras_core);  bool ras_fw_eeprom_check_safety_watermark(struct ras_core_co=
ntext
> *ras_core);  int ras_fw_eeprom_append(struct ras_core_context *ras_core,
>                          struct eeprom_umc_record *record, const u32 num)=
;
> +int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
> +                      struct eeprom_umc_record *record_umc,
> +                      struct ras_bank_ecc *ras_ecc,
> +                      u32 rec_idx, const u32 num);
> +uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context
> +*ras_core);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index fd427fd59ecf..eb5bb6df18f5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -436,17 +436,27 @@ int ras_umc_load_bad_pages(struct ras_core_context
> *ras_core)
>       uint32_t ras_num_recs;
>       int ret;
>
> -     ras_num_recs =3D ras_eeprom_get_record_count(ras_core);
> -     /* no bad page record, skip eeprom access */
> -     if (!ras_num_recs ||
> -         ras_core->ras_eeprom.record_threshold_config =3D=3D
> DISABLE_RETIRE_PAGE)
> -             return 0;
> +     if (ras_fw_eeprom_supported(ras_core)) {
> +             ras_num_recs =3D ras_fw_eeprom_get_record_count(ras_core);
> +             /* no bad page record, skip eeprom access */
> +             if (!ras_num_recs ||
> +                 ras_core->ras_fw_eeprom.record_threshold_config =3D=3D
> DISABLE_RETIRE_PAGE)
> +                     return 0;
> +     } else {
> +             ras_num_recs =3D ras_eeprom_get_record_count(ras_core);
> +             if (!ras_num_recs ||
> +                 ras_core->ras_eeprom.record_threshold_config =3D=3D
> DISABLE_RETIRE_PAGE)
> +                     return 0;
> +     }
>
>       bps =3D kcalloc(ras_num_recs, sizeof(*bps), GFP_KERNEL);
>       if (!bps)
>               return -ENOMEM;
>
> -     ret =3D ras_eeprom_read(ras_core, bps, ras_num_recs);
> +     if (ras_fw_eeprom_supported(ras_core))
> +             ret =3D ras_fw_eeprom_read_idx(ras_core, bps, 0, 0, ras_num=
_recs);
> +     else
> +             ret =3D ras_eeprom_read(ras_core, bps, ras_num_recs);
>       if (ret) {
>               RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table
> records!");
>       } else {
> @@ -474,7 +484,10 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)
>       if (!data->bps)
>               return 0;
>
> -     eeprom_record_num =3D ras_eeprom_get_record_count(ras_core);
> +     if (ras_fw_eeprom_supported(ras_core))
> +             eeprom_record_num =3D ras_fw_eeprom_get_record_count(ras_co=
re);
> +     else
> +             eeprom_record_num =3D ras_eeprom_get_record_count(ras_core)=
;
>       mutex_lock(&ras_umc->umc_lock);
>       save_count =3D data->count - eeprom_record_num;
>       /* only new entries are saved */
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> index e2792b239bea..53dc59e4de0c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> @@ -413,7 +413,7 @@ static int umc_v12_0_eeprom_record_to_nps_record(stru=
ct
> ras_core_context *ras_co
>       uint64_t pa =3D 0;
>       int ret =3D 0;
>
> -     if (nps =3D=3D EEPROM_RECORD_UMC_NPS_MODE(record)) {
> +     if (nps =3D=3D EEPROM_RECORD_UMC_NPS_MODE(record) &&
> +!ras_fw_eeprom_supported(ras_core)) {
>               record->cur_nps_retired_row_pfn =3D
> EEPROM_RECORD_UMC_ADDR_PFN(record);
>       } else {
>               ret =3D convert_eeprom_record_to_nps_addr(ras_core,
> --
> 2.34.1

