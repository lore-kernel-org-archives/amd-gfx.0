Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4F2C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C63710E4F5;
	Thu, 18 Jul 2024 04:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q6q5zo36";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48DF10E4F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oof/t0UBGQVFeLjMYR2oAMzHud3OE7WYrH4n7T6Hk/MmptZGlEiTuib1xb25s/nVcVlaTJPtc+ENBmtTmgnnR6nfeRdn6nlEkO70ikPzRuH+5aLwfub7wJl6QAJI3Gw2zER2jOWqPuh5F9e28CGIAjR91iGnDZdD51NMBU18+Xmww0Sb9rQmno92+M+cZgYOqRqM3olRM9+oIT1AfJ44v9mrflwNOs0BP+svNo+gxyIcfAHaHIwqphAEizUJy0VbL4BWfomesDg8qc+MsPfL8T6XB9DVNZuu/gon4+dYeGvLOtY6o1EKbdXBqD4q5Z1Ux8CkzS+uB0OrbauutWiJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTCVY6EjHQA0GI2rUV4Eas3C6YNFYiM0jlX3tvEDa2I=;
 b=jcT8ywC/zl6UFqI6x6dVcGoTPijKHio4eap9RpTNRoAYw7ohEn1cIiZmCW3EHDLN8HX1p6u7GjTHSF0akDDCTbkl6hzdtbkhN4GqNrsxCDQ8Ww8gMvZ3X2HTH7Cx/jFgM09ds3uWR/EeUuTL1Yk83s4+CT6CqWVfLAvIKOTF+gaI3PwL3vMR/RIJE8W0xG9TZrwJwK6djE/jt6YhOhngmhr6uA41Tk+eVdqz/HsP4zRNzfu/bZLLOkWhe7K7OJ49IrbJyvqIlG7U57uxhjeLs2RFOP1VKy8LuKgMJDIclKu05KXfOcQoAmY+kMiHq+XIlO0rNC1Osl0WzpaWcoXGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTCVY6EjHQA0GI2rUV4Eas3C6YNFYiM0jlX3tvEDa2I=;
 b=q6q5zo36FuGNwjHlWP4Qbr0m6fqEOXilVCDpF2BtkUKJP+G0RxOZbugUxapKFJRvZj3QRxq+vaJZKmMHvfFEi9NjQmmk+a6GHKV96cK7u9ZGZmaUpvY14CBOa7P2f16QxZG21m3UQoeq6iHxlVp9y4ApDrtrMllIEEZNHSLULic=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 04:33:46 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 04:33:45 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Index: AQHa2CGZlu8rn/rGz0qvkKo/wpiqyrH7zCCAgAAJ6VCAABBbMA==
Date: Thu, 18 Jul 2024 04:33:45 +0000
Message-ID: <CH2PR12MB42151D081B5DA967A7F58B93FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <20240717081547.224193-2-YiPeng.Chai@amd.com>
 <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB42159F3051B2254E1A5740C5FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42159F3051B2254E1A5740C5FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3021fd-db53-4b87-840f-056fb3730b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:56:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: 92b9d101-cba0-40dc-b358-08dca6e2cfab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?747s5Gu8Aa00452lL5gDVNkvVBUmmmbfmcUZytuX0M6YWe1bN21DZftscCCe?=
 =?us-ascii?Q?7uAjyTy+WOXrTVKlXqzvJkW32D73iOMU16d1Fh/l55DU7v9Rgh8SrHkjf3jT?=
 =?us-ascii?Q?Ta5NjJLQnQINeiaLo5DT4aKysfcvnKQOX4KIfbvUlrtCicyQlDKmC9GYi3zD?=
 =?us-ascii?Q?EG1J+RbHcgGnamQ1h4c6slIODmB0LtFSbINIwgZ1rjK4yNkKmuITzBthD9hg?=
 =?us-ascii?Q?HpfbA0UOuHJwHrMthnl/HCrDxvef6DEdCqDi0AbBnIf2HB5IGGshhuh5g0oX?=
 =?us-ascii?Q?SYIeyG1bdBt9Ok7fryDhMZZtv0Gk1D4jvWu3L5DDgIzbufi/MtXUUpApQ60E?=
 =?us-ascii?Q?GqfkWeHx0U8Hj7GAYsKQ4YmVs8a0Sp3ucPvV9NWDurkRjiRhoi5kbEdoqBuN?=
 =?us-ascii?Q?qkzE3M58LaorXHhhn2I6Gg5SALZCfmbSJo6KkX8bsFgaId56F63pXzT1o7fi?=
 =?us-ascii?Q?GHrNHDmzXuSO4h+ZIW6QZOQ16oVSDNeBVxQfTN2Cs2K7MWf6iyBI+sGT1zBm?=
 =?us-ascii?Q?OOOv5adE3KjBV9UaWedQnUoipXbJWDWZ1bbn6NNcqMeEBYXDpjU+a4rERD+O?=
 =?us-ascii?Q?sFSaJGnNkIz6TjPVw3XBoBgPOTh1dGkt9C9ep4HXRgDkhRC3B/B6NfDNYZls?=
 =?us-ascii?Q?gZ+ejhESdlwFcxzB1IujE1pPdP3MhkDXNSrohssU0V5gLZv9Ml7DVKOoGXFi?=
 =?us-ascii?Q?ckZ8JAI/9lXnreAvKit4MbGL/KEu91cPPOb3GCH7bAO7rAIZD/0DIZPokBg6?=
 =?us-ascii?Q?MYSRoF5Q5MhKNOJahbKvNd1/3tTCeo2lqVDYi9nLhnpzuD3plq8MxqAsTF1s?=
 =?us-ascii?Q?bHei1ej9DeUs/AwOxPbo4MMb4NRoySAAE7FzGfP+iZwr3WyqJT2wLH03U8Ek?=
 =?us-ascii?Q?YNpKTUEgZVSSTmQM+h5lPIvsJ0cRncqW1/+nMpicz3hEO2vDO5VZujjLRPjA?=
 =?us-ascii?Q?eqlkJJM1Lw/C6x2wkZj2y3Rv5s1BLxBgnlbMD+Xacgfk16YrnkdAzUMgjOwX?=
 =?us-ascii?Q?S1PYtc+3b2QQdYJyJ8SV9kf5T8NbN/0KLbv5jENdd9vQ8kou61CFNDEKtBwN?=
 =?us-ascii?Q?ebxAwprFZPbmJK8ADBuBYEXjUERIVyx7yOoqAHB+Yf6bkQGtbB1AdQqD4TOF?=
 =?us-ascii?Q?u8GVnYDo7EawYqJ8xNilFRbBmjGhrynzZM9E1KlYWuak+BzQCut0FWJJEZUi?=
 =?us-ascii?Q?Yj6lkeVpOvfzcOY3VjqfN/wF8YNxVSoB5KsxWBQTkLSwqZoRe7dz6zLfGG2F?=
 =?us-ascii?Q?w4+mpYKK6Dj3j+VLDScuplel3fop5/3fOVP/f8BwWqFmFef3DxbMvq6w1idF?=
 =?us-ascii?Q?/NGoZXuMCyPVEKdjlEDqF0CBio+dZU1L6VTfsFF/hlpkFXD78rw/V8lwhb4w?=
 =?us-ascii?Q?Qg9OWqSHPac4g21czPdpjqgqF9SBxjzzSM49OHhQ8OpdckCi4g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hf46sILfcIfXGmRu1b1Sh/Rbff1QFE2m1nydqPzQqGNWK6tgypqFPuUGiS0S?=
 =?us-ascii?Q?9YxvSjwbx6QnjNt9PMO2XGjVxb3mEJ30iYV8Bqh6OtWFu97IVvoSRHkOh2Vt?=
 =?us-ascii?Q?fyEyVa3E0pSQ57sMiMFng8qvV82RRm//fvyNUWAymlF1IVvgw7bSYI/gpWTX?=
 =?us-ascii?Q?JKClD6YGe9qmPK2jNmsQCRDa+dEr+lK348XZLMUZ4pCPNPrryvHA7qPm6FLD?=
 =?us-ascii?Q?2ftkgN7V8geYntTJ7d+e1nN6gP0FknhtcOxGf6kalmYXNMZyFNPw5mtZJEDV?=
 =?us-ascii?Q?zHXZOcGcvlruZ6+MUtR1kSE80gQxhYJLLp5ydBAQsuZSF/23H+QW3lE7KGsj?=
 =?us-ascii?Q?tb/Q0aQWaaD06CkGOWgqDomx+K98+s/Ss8rMvk/KfZ5m5X9JrqxSSgW9cMIl?=
 =?us-ascii?Q?yqmI0il4ZUlxG1N7S7G7flRA0Ms6PTHt5XSghL0DunClEoChybb0tiKdTHM8?=
 =?us-ascii?Q?GoTkOP91K/zGUgDzbsnhSiy0UaSXFv/u12l0hv8pYHIHjVMp0fj8zPq1scRD?=
 =?us-ascii?Q?g3hFl7R2cl3XLkL2mD8VIBQx0o8TCuQco1HuPgaVbjp4ebd/w9nIU0VfqBM2?=
 =?us-ascii?Q?TzpYBWt4mI8sj7ZPo5ZxpgFzkU/C+c4EhpcUxnL4fb5SbN4exh5kyRLDhaHp?=
 =?us-ascii?Q?9BpUmFD6ecY2Q/hO7X1022PKuTFqVjF8aM6eKzS+78SWB8xxJIk+T3QNKzBx?=
 =?us-ascii?Q?83WHZdAfvPPO2DAsDb9UsZSVzmN/jmckUqp7Z/dInuh1SNx9p47CB5vWjxxr?=
 =?us-ascii?Q?CIh3khOzDHMqKtjlA7btgvket6SR9doaROWMFYaRld9YbEhHNfoRDwhKgF/w?=
 =?us-ascii?Q?+vSpAOOPCuGCvLizsNTTTwBVH45oXPC+Ud+r3f4oHxlLi9WuEEvR5oGdP0ST?=
 =?us-ascii?Q?vwrAefd/vyH5BtASNuy6f926hEf/9OTa40HA8uPC25LQXcorZar/T2IWdy6v?=
 =?us-ascii?Q?SiI9umaY5mC7ZTk/a/jTZWDl8vaVC+uOI88hNFvrx5xdh9qoLs4oBH0+M7Jo?=
 =?us-ascii?Q?7bSsEMjpTtxdHtyCxMVniwtTky8r5n34gxi1urtCrHY7NAkJgDnbpSaY0hLa?=
 =?us-ascii?Q?COMM4t6s7ZuJfv41wCnphel+lB/rTiobKDeSqi2Wqhd9GOBfQ1c8T57Z4po/?=
 =?us-ascii?Q?PU2wt7VXe61g8PMiG9LntQtedkRRGSY4IfZ7plOJz4Q7ZLe5+I9xhV9RFz2Y?=
 =?us-ascii?Q?WmPx4+PgLMtMVzxpGbW+Txc5krKplfqIr8yJTjCKhD8w5gE6dqwVY+1DIFkP?=
 =?us-ascii?Q?gg41CE0/3l+Z+1pxqXZFt815V5xQFKmyYxXEWz2+TqFnlYUzzzyUm5uyTeKy?=
 =?us-ascii?Q?sIKEXsDW8+2zPW9ucYubpVMDJrPybj3FU4sw0/1nMoMluoFpAllIau5Abzwz?=
 =?us-ascii?Q?J7TLw++P8ww7//hnDE9EgNrdA9sO477pt/y+t0VRLHwTjRCFjSlydaamW0Rv?=
 =?us-ascii?Q?fCnbEA8d0H1eDbY8Dm8qIamkcK+aDtQsKhfW40XQj/GFALAn3Ugx2xEMA3yl?=
 =?us-ascii?Q?rdOqqv87vgio+qUYqBTmFkeIyqJ1zu6jsirNus9Z6noU1WiTbMdIEggWajLh?=
 =?us-ascii?Q?zw73oSCVKHTRy7tr1dk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b9d101-cba0-40dc-b358-08dca6e2cfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 04:33:45.6201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00s0HDHIeckW3tqPcrhoIXN/keR7twyWtDV2kfVIFARnJ87A8B6q3FEvuCxswCFlGwbE1M6/lYjM3r483vu/VQ==
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chai, Th=
omas
Sent: Thursday, July 18, 2024 11:35 AM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 18, 2024 10:57 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 17, 2024 4:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> 1. Use pa_pfn as the radix-tree key index to log
>    deferred error info.
> 2. Use local array to store expanded bad pages.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65 ++++++++++++-------------
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  5 ++
>  4 files changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index dcf1f3dbb5c4..f607ff620015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -476,10 +476,10 @@ struct ras_err_pages {  };
>
>  struct ras_ecc_err {
> -     u64 hash_index;
>       uint64_t status;
>       uint64_t ipid;
>       uint64_t addr;
> +     uint64_t pa_pfn;
>       struct ras_err_pages err_pages;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 5d08c03fe543..2fc90799bf8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device
> *adev,
>       ecc_log =3D &con->umc_ecc_log;
>
>       mutex_lock(&ecc_log->lock);
> -     ret =3D radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err);
> -     if (!ret) {
> -             struct ras_err_pages *err_pages =3D &ecc_err->err_pages;
> -             int i;
> -
> -             /* Reserve memory */
> -             for (i =3D 0; i < err_pages->count; i++)
> -                     amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
> -
> +     ret =3D radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
> +     if (!ret)
>               radix_tree_tag_set(ecc_tree,
> -                     ecc_err->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> -     }
> +                     ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
>       mutex_unlock(&ecc_log->lock);
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index eca5ac6a0532..f2235c9ead29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       uint16_t hwid, mcatype;
>       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
> +     uint64_t err_addr, pa_addr =3D 0;
>       struct ras_ecc_err *ecc_err;
> -     int count, ret;
> +     int count, ret, i;
>
>       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
>       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -559,39
> +559,18 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> *adev,
>       if (ret)
>               return ret;
>
> -     memset(page_pfn, 0, sizeof(page_pfn));
> -     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> -                             pa_addr,
> -                             page_pfn, ARRAY_SIZE(page_pfn));
> -     if (count <=3D 0) {
> -             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> -             return 0;
> -     }
> -
> -     ret =3D amdgpu_umc_build_pages_hash(adev,
> -                     page_pfn, count, &hash_val);
> -     if (ret) {
> -             dev_err(adev->dev, "Fail to build error pages hash\n");
> -             return ret;
> -     }
> -
>       ecc_err =3D kzalloc(sizeof(*ecc_err), GFP_KERNEL);
>       if (!ecc_err)
>               return -ENOMEM;
>
> -     ecc_err->err_pages.pfn =3D kcalloc(count, sizeof(*ecc_err->err_page=
s.pfn),
> GFP_KERNEL);
> -     if (!ecc_err->err_pages.pfn) {
> -             kfree(ecc_err);
> -             return -ENOMEM;
> -     }
> -
> -     memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err-
> >err_pages.pfn));
> -     ecc_err->err_pages.count =3D count;
> -
> -     ecc_err->hash_index =3D hash_val;
>       ecc_err->status =3D status;
>       ecc_err->ipid =3D ipid;
>       ecc_err->addr =3D addr;
> +     ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >>
> +AMDGPU_GPU_PAGE_SHIFT;
> +
> +     /* If converted pa_pfn is 0, use pa xor pfn. */
> +     if (!ecc_err->pa_pfn)
> +             ecc_err->pa_pfn =3D BIT_ULL(UMC_V12_0_PA_R13_BIT) >>
> +AMDGPU_GPU_PAGE_SHIFT;

>[Tao] why address 0 should be avoided?

[Thomas] When address is 0, it means the data has just been loaded from EEP=
ROM, it should calculate  pa_pfn.   This will be useful for the eeprom new =
data formats in  the future.

>
>       ret =3D amdgpu_umc_logs_ecc_err(adev, &con-
> >umc_ecc_log.de_page_tree, ecc_err);
>       if (ret) {
> @@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>               else
>                       dev_err(adev->dev, "Fail to log ecc error!
> ret:%d\n", ret);
>
> -             kfree(ecc_err->err_pages.pfn);
>               kfree(ecc_err);
>               return ret;
>       }
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             pa_addr,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +     if (count <=3D 0) {
> +             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> +             return 0;
> +     }
> +
> +     /* Reserve memory */
> +     for (i =3D 0; i < count; i++)
> +             amdgpu_ras_reserve_page(adev, page_pfn[i]);
> +
>       /* The problem case is as follows:
>        * 1. GPU A triggers a gpu ras reset, and GPU A drives
>        *    GPU B to also perform a gpu ras reset.
> @@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct
> amdgpu_device *adev,
>                               struct ras_ecc_err *ecc_err, void
> *ras_error_status)  {
>       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> -     uint32_t i =3D 0;
> -     int ret =3D 0;
> +     uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> +     int ret, i, count;
>
>       if (!err_data || !ecc_err)
>               return -EINVAL;
>
> -     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             ecc_err->pa_pfn <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +
> +     for (i =3D 0; i < count; i++) {
>               ret =3D amdgpu_umc_fill_error_record(err_data,
>                               ecc_err->addr,
> -                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
>                               MCA_IPID_2_UMC_CH(ecc_err->ipid),
>                               MCA_IPID_2_UMC_INST(ecc_err->ipid));
>               if (ret)
> @@ -674,7 +670,8 @@ static void
> umc_v12_0_query_ras_ecc_err_addr(struct
> amdgpu_device *adev,
>                       dev_err(adev->dev, "Fail to fill umc error
> record, ret:%d\n", ret);
>                       break;
>               }
> -             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +             radix_tree_tag_clear(ecc_tree,
> +                             entries[i]->pa_pfn,
> UMC_ECC_NEW_DETECTED_TAG);
>       }
>       mutex_unlock(&con->umc_ecc_log.lock);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> index b4974793850b..be5598d76c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> @@ -81,6 +81,11 @@
>       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
>        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
>
> +#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
> +     ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_R13_BIT)))
> +
>  bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);  bool umc_v12_0_is_uncorrectable_error(struct
> amdgpu_device *adev, uint64_t mc_umc_status);  bool
> umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);
> --
> 2.34.1


