Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8163C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 07:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38BF10E83F;
	Thu,  5 Jun 2025 07:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAoIuDlX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C1810E057
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 07:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLjp6OsuI8CWtxNrEYH0yKVOVWxMQgWWwvHqZ6bvPJl8SR20MA7MrxCBJf+bdFziCEUfwHKhoO4mdBgMYaCOkRmaMU/649nPfbhE3ZIIr+a9pStDSM8hirrzYjsJH4AWvsnOzHAhUz6ZOV2jzI2UxcE6eL3BMS7d2xb5Ckuk12zChRgnAb++BNtdp3mZc4xlM7yPluakmVGbdF9c1gDBV/Q9u1htzP0uL8I8kBGj+lvMrs+Ho4LikEwcHSaP7WWHieOAmqxF6KwQb/te0eAuE1saL+paLz51oDBhYxGU1izp+HspqkAVSdQRxXJdm1hMVFPIMCbbEJCl+eUQD7fnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk0i7JVPfM2jirgTaqVIFUp+FenQk5muvUf9oes92Vw=;
 b=BOvHlEYWDgbJ7Hv4sjj2HoUcNdaFdAHck+828n4qcF7rIrFQO8gRLnnrO3hkt1orqiyb3pbOPAWV89emJcZYm+zm/G3fA8Tec5iostvdw/e/IzKt4ONwfJpltQXTKNcoW1gCYC8Fdjcol09ymqIxc8eONTRGSQ+g7XcV/7Z4IBYOuq0dGZALrw5U141pKLMlq4+11msOQhTWJLWdjhDAI5jtDtWvQy3ytmU8nejE/Zx6V2NyNJqRuOvpFQC22NHFKHV99qy8ku0PGoUw/5kMDTyPdK2L1VGo2K44vUTCf6XM6iELutxzhpSul9yd973qKC5IOZevdgv6XMBgujKEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk0i7JVPfM2jirgTaqVIFUp+FenQk5muvUf9oes92Vw=;
 b=wAoIuDlXTiMPCAI0DXQ4cwe/iCn+YixTBbDIe2mviPf25FC9DhfGc0aechCiklQWVmFZqpltXJncEfy7doHdSaevfAlVBhuMejAk1rCrPo7B942KVfyzDHiHmqyz1gnR//mW3bOkMnQQ3T/JYp0OS2amxzRiO9BTb7SC840sZQk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 5 Jun
 2025 07:18:17 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 07:18:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: clear pa and mca record counter when
 resetting eeprom
Thread-Topic: [PATCH] drm/amdgpu: clear pa and mca record counter when
 resetting eeprom
Thread-Index: AQHb1d+DnHS5Azy9jUKMSajtmQkkcbP0KDYQ
Date: Thu, 5 Jun 2025 07:18:17 +0000
Message-ID: <PH7PR12MB8796F69292803443EF1A7D1DB06FA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250605060210.158358-1-ganglxie@amd.com>
In-Reply-To: <20250605060210.158358-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=647a362a-1eb2-4874-aac6-b311dc296f0b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-05T07:18:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB5784:EE_
x-ms-office365-filtering-correlation-id: b44f82b1-686c-4d94-4f20-08dda4012491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qxNIQyhKSaFx5wXQNNsbOs3jGgoBajZ/BbL/LgWFZ7gCgjxd/eOamLcDZryX?=
 =?us-ascii?Q?aUx9T7HDcSB0h1yaluYGd0qRbOgb8zhHuOHgIKT3+EA75T+q2MGqzT0TWFXK?=
 =?us-ascii?Q?8p3B8hYXb5V6HQkAUE3X4s3nUIjTLds4Mw4SpSXxiYC4ztbAe2qd/dLJYW5X?=
 =?us-ascii?Q?qm3mKglh/LnfPhHPCGz0EdwepVAcFToZ8uvFG3xpfqyCuD+E8IojOhwXXtiK?=
 =?us-ascii?Q?IhvRsOrvEARUQcClYCGIw3dFnGoh0MljIjJevLVfSuKt+ViImKsQChPYVwY+?=
 =?us-ascii?Q?1rQUEI83ZVtuOd952dcPW5272vi6YP2UoWFTkPr/k7F+QDvfgBGJDcker+7A?=
 =?us-ascii?Q?V9mW6WRLp4+VFrnkYkH7G/gg+idc1c39Vy00hJ16VQe8qyVC6XTn/p0AygNe?=
 =?us-ascii?Q?UliyEk7nUfgQ7nOJ7sOMWzV2IDf04iigD+wpT1dl5H7p1CxTfiLEgr2c2f7w?=
 =?us-ascii?Q?a0gmX0Reycc4jnxp+ylkFcqEOtLEJdZYALgn4Zk+i9Y4GF+buDeRzq/nEvWM?=
 =?us-ascii?Q?qJgc4duZGih93BHEDjD+PLoByGzWUbwKXgD6XEEHBU0KLwZDlEaNi58I7JNJ?=
 =?us-ascii?Q?oixpLjXlJ1Tup3CgGIACBz36rmpXEKNSMTGmTQfuhIp6OXlOghvGcDKwrG3N?=
 =?us-ascii?Q?/uFwrJMGDa8pmVj+Btul7rYnluMclmAp6M2KplgVmZKfHDqlUml82bBh3dE5?=
 =?us-ascii?Q?JQImRmGsHkAtQxMqXrIwL5IzxLGANLkVR+XfFzZqAdVuNOqrARRnamOrjeWQ?=
 =?us-ascii?Q?WLiV/qluIybCyWzoqVaiNofD+3ltuh8cYI0hnr9leHt8W/Fr+aFe/UZPLh9P?=
 =?us-ascii?Q?i38nsU1xM9KbhSjMbAtZyLVehkA50CU5esMf47JhzkNp6S7UJ0YwRs0AGGR8?=
 =?us-ascii?Q?VshCGLHuC9EBFilyOcdut4S9w57tXTMVXrnaW0RuJ6pdvedzHb4vPy3uB6U9?=
 =?us-ascii?Q?8ulCYOHMMSNnZa4EXilr9CV6hZ5cU/53S3qGO1JryCZbT7XNb3BootBuUPtC?=
 =?us-ascii?Q?5LTGW+szCS0Q3yYTTRk+Y/lDX3GIGdExdMM4J/NO9j1q4GNQ7LEivWpr/Zf0?=
 =?us-ascii?Q?tMs3FshJBZq7McZzUijBbYxwQYGcuDr3tc9qtlvEYKbAyGfvEnYcNCAHo5Nw?=
 =?us-ascii?Q?Lx3p2YUmBtuxdcO60GTC2FgJj2e4QyZpytKK4zilTTsp0ZrIaDGScadyf7r4?=
 =?us-ascii?Q?FG7C3ZK0PFl6Nc7LvJJZlUFu8fu+Q47AwnBU3VXpHRMGF/cfGb1Gtq6n+5Fs?=
 =?us-ascii?Q?v6YI7Bh1y4+T4xCAf0CNSDAFutnTeCdQunI6GmU1Hwd7g90Kb1pA38YvNP23?=
 =?us-ascii?Q?eEzWqlbwPM0UzRWk5gWsEqS7kYCp+X4LKmWf+zjrTm+qoL1Ycxfhod9vfi6F?=
 =?us-ascii?Q?4idBVJZoJy3r/9Z6FKyVs7zvB3W00QbcJJu+jLfNG83zd/lONCzQlyYkAbu1?=
 =?us-ascii?Q?78XrpAVNvJEJmkjm4Z+LYqgdC4PMDsfzVnjc9WuOP9vtJWhRxxK3XQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JJfO8zf8rj2fFwtnpQeJpD4OA9lF1AsY0ljDDbs3YcRlMvaCj1VhH1TY4cP9?=
 =?us-ascii?Q?N8PL9J5Oc4rusx+SSzmDEfBR18EVSp9zc0HmBDawlF81hgeNpHlNjYmYg/QP?=
 =?us-ascii?Q?+Wd4gWDbrpG3zlYlpvA5LTJUVN8jW/5CrzRMQt7LKrYsgU50IzwpSNivXCmD?=
 =?us-ascii?Q?Add99sDpJofWSn7YbOS7gu1lGhPrXEO41V1NimNR30hxiNxcvw3BA9a+C+FL?=
 =?us-ascii?Q?QDIJtsAByAwHpvVInJCDsfeVi3CE/Fbcgk8seSg8L13sBZhf4w32KNvXojMi?=
 =?us-ascii?Q?WgcdAFeD7C1x0ZwM0EetVBYGJCqtXdsEOsT2Q/dx46wlinUepeOlVitoB/eh?=
 =?us-ascii?Q?CmJW8QravNmzO3zs+cuHvMPDeLFWaYxHA3hc0hlm3BvngbB/8XyGmDZqAoBv?=
 =?us-ascii?Q?CO9JYPzw91R2aCYB6jchYL1prz0dX4/u+pByb7IPXGlwzgq4oU+2oe5EPAUH?=
 =?us-ascii?Q?IDNmxOH9Zp2lhousUZ5tDqvSI5v89/snmDyqPXKymVGESciA8uTGb//eulcS?=
 =?us-ascii?Q?cfPoMmyVK97XX4O6/u16fSNu/uI2CIDH80u8RbRls/h7dYO4zESdZC0Ue6cw?=
 =?us-ascii?Q?J4hP6LeMm/HclDKCZuPaqGw2J2IN3iueNawAV+1TTlMRY2P/b6juQ4tJ413Q?=
 =?us-ascii?Q?iOAxbR0RtLJL44NrvIQW9ujR72N+DEx2ecxQUpUmTXF4iuf+2EOO2vamzpt0?=
 =?us-ascii?Q?GnU1qcUsgqkE3mTrDq+d0LxJ8AnTqVzs6Puyq1MN1ti0KYiNpo1uNrY4OzYV?=
 =?us-ascii?Q?Dz34X74I53t5L+Q44RJ4ZTdT3QznPv00DI1385qDxwZ/UL8LJ54doKx+yrdP?=
 =?us-ascii?Q?TLsK3Ii4jKMo9XMPEAG5NbT0iKaPAfMUgxGUtJBvhb3dI4vmDwzgFqZTfecq?=
 =?us-ascii?Q?eYsCA24vfxIFWk7XW7nWwBNK4oX0XcWNAGOmjPzKj3Jif6d4NklGMUfomMGx?=
 =?us-ascii?Q?MAZ6OsXqY/WKktXgGMr/mVb+KcrKHRmSOR1sz32bCvj5uV04iiDWfxIz+59f?=
 =?us-ascii?Q?x8bJ2VRlmgSm25BY+1UVpS6TdDYGwRE5S14tnPnnqPABnPOaatnUJzc4VUIF?=
 =?us-ascii?Q?o5IXQbIXndiTqx9iDOrijbY9MVqQ7MrE//iRKaSdvf0vg86NGIrnZNukdcdn?=
 =?us-ascii?Q?M4agAkkzBCJjgrzbKLvY1H0yZ3Xw2QN6XFlLr9w14OBeXtoDDgxP1Zdi98Qe?=
 =?us-ascii?Q?bzmR60/21tK1gEiVWJy0lJ9pyZ+fd6tXvpU2BNAyETdGkTY/uY/RESNcaIXE?=
 =?us-ascii?Q?Eew1NetvJRDsc84HPTJEqZp/lL3K5X2WEM+amrIQ+jf2GQMEKOyZL7WQiOm1?=
 =?us-ascii?Q?VdCQHIkhTOOTS78wNFwA8AsusaYV8Psw2BJqgzPxYDfeasoHvWSzEt/3ugq6?=
 =?us-ascii?Q?L18gBXuZ8rRsvOvbbhwQVrHoe9cXkh+AQ6CmdThUWf2g95aNEL4UiT+fxI1r?=
 =?us-ascii?Q?iasbNdwqDngAqCI7lDKWunJRkVr6pwdA+orbBGATMJc/xUquUZWx3s0kYh1Y?=
 =?us-ascii?Q?oJtqDQ4rbe+zg9lHCoEKwZQUT2xZhGJp6IZR7dwu3pIqS6wYX1rA9TrgDl1Q?=
 =?us-ascii?Q?VvxvqvkvAnwp+kd8w1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44f82b1-686c-4d94-4f20-08dda4012491
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 07:18:17.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdMTHaxJIXJBPCb4rMmIqEnhTnDcBICRJADGkfY2DbVVEx0sEYTjI2Czvv1YILT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, June 5, 2025 2:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: clear pa and mca record counter when resetti=
ng
> eeprom
>
> clear pa and mca record counter when resetting eeprom, so that
> ras_num_bad_pages can be calculated correctly
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2c58e09e56f9..2ddedf476542 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -476,6 +476,8 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>
>       control->ras_num_recs =3D 0;
>       control->ras_num_bad_pages =3D 0;
> +     control->ras_num_mca_recs =3D 0;
> +     control->ras_num_pa_recs =3D 0;
>       control->ras_fri =3D 0;
>
>       amdgpu_dpm_send_hbm_bad_pages_num(adev, control-
> >ras_num_bad_pages);
> --
> 2.34.1

