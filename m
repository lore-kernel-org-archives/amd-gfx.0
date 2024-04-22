Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA58C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD57C10E7A7;
	Mon, 22 Apr 2024 09:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ymilrbo+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CE010E7A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHBBAhsBxzzNwVI0eVbFBYhSBPvC0oHoK6GpO2K7BN5TtmEy8MsIYIICqS7xka8x4gxWUtUfEpNGvSasqZJME4SyWAn4pG4maPW675gmi0u1ueO/bSYFFLb1DP0LYjs3YQjrK9mguTmRkqZL9EVdEhorpsx5STk3Ecn+5Wa1cPRagN4h2T6oxJjmw6lM4sK3dUgK6PMl3bIL6fG8whhctnNFBJR7hqHkaFBTk8/JoJxV+UPRA4vUYoWfpMBs5pgOgY3f4cYHaot194QVb0KdWHcZv8OA7dTUsLvJNLL9dVbcXpWn7j2+efMD8/R7SevDViUxknLrpkJwmOWKxSA2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewr8BXsXlDu5bXpnPl9TZah4+CV7ZWVCLj5+YJVyx+I=;
 b=B0eB3QuSBiik5n7Uu4uvbC9q2UWkPMyFjycR555H8Xl9XVVIhGFCW2Xd7eOVJMx6E+ZQh9WJmUd+ix47Okg0UNagwpnkgCNnMsmSxpbjuLcMjNB35QjAUZNeEO1xxbSM94l+BhwjVapEswsNA5rLRm28P/qYumObGbnBNt/3nW9E3Q9yOn2O6JRfnFULYSAsGI+p8Ko9nigTwu96x855kdJbJTlTE06Sag52FS3N3UIr98mZowwiuSOJHSdQHXZK/PyhgooKz7CNMo0B3ADcbO+FIDCIEwFFj6Wk5tnpKtIbhcNuAxv05MnXCtCAwLrW4jjadQXQs2t3BqXVGhfx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewr8BXsXlDu5bXpnPl9TZah4+CV7ZWVCLj5+YJVyx+I=;
 b=Ymilrbo+nLONim/NL/mJcGGIVZJmCDkRM7RTZHzQnfH+C7X3q65LAQCXw+PMSlkqygfNN0ZFXmi2AuedPT7BZs2GM4U3Q53JMyvVZzgykzAkobUPy7S8qul/vK3v3HMehxNxyzZBtzdEI5uwu1QrC8Fd715Ra2GRJ2jmkP+onBY=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:33:18 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:33:18 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Topic: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Index: AQHakTzIRliRX3pRekKB0Zi4/jMU4bFz95gAgAAG3SCAAA7fgA==
Date: Mon, 22 Apr 2024 09:33:18 +0000
Message-ID: <CH2PR12MB4215DD77EB0A40EAF3727B95FC122@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-10-YiPeng.Chai@amd.com>
 <PH7PR12MB8796BA85309CCBC954A8ACA8B0122@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB421536E01B3D9A3440F23029FC122@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB421536E01B3D9A3440F23029FC122@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c585f23d-7ab8-43dd-82ea-5f594246e3c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T08:12:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SN7PR12MB6790:EE_
x-ms-office365-filtering-correlation-id: ab72e70b-687d-472d-4d5a-08dc62af3e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?saAlukGdluVbYMLAoAk9PYaBcmb6moVO/brpgjHIy3q2tYqMvpdGn4N9qYXU?=
 =?us-ascii?Q?ll98ZHxBt+q9M+qFjvDTIntmwVQ9llHJEV/mnvBNnC2jIgwROKyvwx2uC7qi?=
 =?us-ascii?Q?/Ok5JMYLUS5Wn40WKUA8ZxJR0eLFfjfgijv2wAWSJss4h4yEmyBD2TIjqIHQ?=
 =?us-ascii?Q?fv4Z0GurLtLeh3zQfPETH+cdlgbSp1jvHe8v2t72vW/X5gCmMjFYPaqqI4aq?=
 =?us-ascii?Q?lyrwoVG/D/VQaa8zt2lHr77OBV/fax2N3dDxc9rF+4ZWbnwbhQUuLCoXVrXu?=
 =?us-ascii?Q?Ms4mqsoc38rCEnIdur8/SPSObbGs7bsyRwUnvlyDx+0jE1jReADJfDTBcfQo?=
 =?us-ascii?Q?HFEFoFaS0I6vi/0cIDTULFUe0AWsJN/y4be/fmeIJAstM+5YElRqpUmq1S0J?=
 =?us-ascii?Q?z7xPoxtMsxF0645gsrwZeM+ggZLN4sBE+Eyrzi8e7jXY9hS4Z/hiHUD4Zd7l?=
 =?us-ascii?Q?JTp5hm/wWzqPv+ctl0LgxwBRjQFXTKeeCv7Y1ZhJTg4PYBQkLMo3aNueqMhx?=
 =?us-ascii?Q?vwX0nGe4eP47wwT5RcX1bWXU7wVak4ZreWcjbL4UUTYiSiDatP9ByP4v/kVu?=
 =?us-ascii?Q?dN0qcm7DqhRxqHuM/LSk6JcuwiuCdVBskJ5MbmmpS0wGCK3Cl2cvovTPuNKK?=
 =?us-ascii?Q?xcJGa/71KQUXi78tBs3dTYZUhyMWnxxXzAptJ8uMkko63pgE5pU4aszUpFP5?=
 =?us-ascii?Q?HCBIZSa6N9K2SvYFMiuduZ3ZOea2PjtEHYXgBbV17SkGwZKdYoBkenE2I++i?=
 =?us-ascii?Q?0WzVa7Ow9AE7zMwNK3XBcLHABqgp6yCu8b2iLF/xCA+PC1zLwTphQ4WRYwqA?=
 =?us-ascii?Q?9uGjgz+4fpy7y5B73XE8S6O/emMy+MfiPr/NoZ7+QjIOLFCFNlYIWHclwkFK?=
 =?us-ascii?Q?kptBcJB0rAYxysD7KlCo18xdmLd6J+Ziv55svl8jUk0hS6hKMQpvEbiPC8Bg?=
 =?us-ascii?Q?ZvH++MHlK/FHnOYd/C0YWoy81/FbWJzSB071IgKPwvwsu6sTXBFXeuLC4ixD?=
 =?us-ascii?Q?ijM2LMi0ViskGRckPV/N2d1RQSW0Ll+/oyovretBBgNpJGEDhpB24r7OVnGQ?=
 =?us-ascii?Q?gM/9ng78VFM+Pwl6myswBPj2ah9Rt6FZko3I/Y/yj6iRPg/NTCDjROm72Mmu?=
 =?us-ascii?Q?W2I+ZEQEK5jL9XMfmPdNafrdSCQVFRBXCc1vLOlhn3vGuwrLUnCpbf83Wdq5?=
 =?us-ascii?Q?SB9ZkxX1vz5wZJpgNi9QjXkA/jU7xx/zXUZ2BB47zbVVj2ThpUDbEnFedTGw?=
 =?us-ascii?Q?dH9sp5/oCiVQPZdQ4544ec8915A86Cc5hD5ngdBxS8HfvEhC2q0RkzO6VGfH?=
 =?us-ascii?Q?VZVcI6aNQPRBMV3dZdl14as3TLZ9Ku/aWcvdDS2ktZlJEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ph2AE3HIrQG2xWh11OF5dBg9yUGAtnqXTKGJsmsQ7Sp1PPtraD0QLH7+Go0?=
 =?us-ascii?Q?HZalVhOBlZw9pRJrM3V+pZOQjBfMtqpgyLyYdTVGFNO9rnQHZbVcw/WDHva6?=
 =?us-ascii?Q?jzwPHtVF14GxjgjnzHvE5gcP5ThdOISs7aBAx4g/Q9CBvA3qleDcMRdi0ftp?=
 =?us-ascii?Q?hbK1AOXub5+zqsvkyDpPgoLObFwQWzayR9OUOQMi9B50GJ6nU1s8Zy9xDxJu?=
 =?us-ascii?Q?MMr37xXD5qtDhJZpVDDu5PEvtZzEWsIPb75PY4prR6CBoumWVhAcvLbR3ApU?=
 =?us-ascii?Q?nS6dXzIy8Ek0VUdbyGu8L1gjlFsgPyTkWBcAUm3WgpLST2+a+6Pa3H22ZlZR?=
 =?us-ascii?Q?Ns6RB9Fhv1UWr/6KxANtguxv/11Jz82IaRKgIsze9Xh0WnHa1Fs+D4hbG0Hc?=
 =?us-ascii?Q?5Az/1nMWLUeFBIBBcWYG/VpayGIAC0xk5qLEuYBbSecpza3kh33RZZKNvvCj?=
 =?us-ascii?Q?JLlEGHCczJmWUj2cXp3fEPjMxHh7SmNRew0tizla2ipP+Tb/iQmSoidRW7xU?=
 =?us-ascii?Q?qrNrHinGqP6PwiT3N3GdII6JFvVrgUMAABqk+UiTeKMhBZS+mw0C2Y+wG1bR?=
 =?us-ascii?Q?eQPAy2ACjbObhbVOQrvITk1DnagkT3O50ejWA+Lgk/nlZtBOwNItJ365Exf4?=
 =?us-ascii?Q?Ia37N9k4/kGjDXp9y41BRBTe026iRpILBIBMLMMkptMbT547cDJau8olkSnn?=
 =?us-ascii?Q?61ATHWQwbZipWEc1ud5BqFp+L1smJzAbf1tDuosS1WjTRm3S+K6kperrKymz?=
 =?us-ascii?Q?kkTzD/Gn8a1egIrch2N4NIPvilOs5HYN5dN4rKfTgzf0KWQ77xiUtwdEqcl2?=
 =?us-ascii?Q?rcqFuzLIZnsopFTeghe0yytyVTr+FYaXMtKOUIffWozYzwBxQPBUNMFw63KG?=
 =?us-ascii?Q?+KfeGTlFNkgQ7icSkFjbx1XRwAyemQVbIXF1Pw62cSib8kq7qDXnXO/rR/pq?=
 =?us-ascii?Q?2Pq7MhSSoo+LT0ZESjui+IWYHsvOiKU22e/WBlYYwV6c55UouIcBLFinEFKs?=
 =?us-ascii?Q?ZX/zp7ukXg9MU3am2q/xXClB1Yb8BdSuD1lZTpRoNnniUqpHniiCdGrHOU3H?=
 =?us-ascii?Q?I1f+c93G5JKU7jhOMxnEm3f14fJVGYXz68sDC8vg4CyNoPH3J6pLYmlUci2G?=
 =?us-ascii?Q?gU2UY6sRK2H3McM8f4dxR+w3TAfBY/x3zmf2L0ObWKgFnmdYuxXQot3m5E1u?=
 =?us-ascii?Q?PbKDlmcURiyVU4FP7tkFjAkHgAEn9VBKBa8MpQznTQA4z63ZzUeBUr08npZw?=
 =?us-ascii?Q?JF1jd27LapIri6w+lEBt3LJ0W5n08D8nbi5ZPmaY+VA7bJ82fmzFqHGmv1t8?=
 =?us-ascii?Q?zIZI3mHqFTZsp/i09ONLANB/5OxVzbvWnKhfBBe76KoNYpKmyntHO5jLeZg7?=
 =?us-ascii?Q?6w76CUa0a+ifTvx09G0kyEB2AZK9n/r3wCQ9IxMA882XGUo3Xfe/cn1WTNBC?=
 =?us-ascii?Q?/OrbaBiBItF6StzTzj1by9uHBKCuIjoI7HilARP1heZ81hNoGxspJ4xQEMbp?=
 =?us-ascii?Q?aQOknlyZIG15torYL+3YMKsjXH3KVwG7IsMAmkHgu9sbFjdJk30dgkST38FK?=
 =?us-ascii?Q?YBu5i/Eth4dbBWJjA5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab72e70b-687d-472d-4d5a-08dc62af3e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:33:18.7330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xymaBcY4qZpNCEkWSPM9StjYK6DoQrkGb2TmGmWPM+jjjFLvwqDBvzAztaYf2JPLCE6VIE1QEV/IwPUbmoQtZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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

update

-----------------
Best Regards,
Thomas

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chai, Th=
omas
Sent: Monday, April 22, 2024 5:21 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0

[AMD Official Use Only - General]

[AMD Official Use Only - General]

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, April 22, 2024 4:14 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, April 18, 2024 10:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
>
> Retire bad pages for umc v12_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57
> +++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 6c2b61ef5b57..bd917eb6ea24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -28,6 +28,8 @@
>  #include "umc/umc_12_0_0_sh_mask.h"
>  #include "mp/mp_13_0_6_sh_mask.h"
>
> +#define MAX_ECC_NUM_PER_RETIREMENT  16

> [Tao] we already have UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL for the
> purposes

[Thomas]  This is from eeprom view to define the maximum number of eeprom t=
able entries written each time.
The actual data items that need to be written to eeprom may be less than th=
is value(e.g.  later, write the data items before address conversion), or m=
ay be more than this value.
If the value is less than this value, it will be written according to the a=
ctual value, and if it is more than this value, it will be written in multi=
ple times.


> +
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst,
>                                           uint32_t umc_inst, @@ -633,6
> +635,58 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
> +                             struct ras_ecc_err *ecc_err, void
> *ras_error_status) {
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> +     uint32_t i =3D 0;
> +     int ret =3D 0;
> +
> +     if (!err_data || !ecc_err)
> +             return -EINVAL;
> +
> +     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +             ret =3D amdgpu_umc_fill_error_record(err_data,
> +                             ecc_err->addr,
> +                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             MCA_IPID_2_UMC_CH(ecc_err->ipid),
> +                             MCA_IPID_2_UMC_INST(ecc_err->ipid));
> +             if (ret)
> +                     break;
> +     }
> +
> +     err_data->de_count++;
> +
> +     return ret;
> +}
> +
> +static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
> +                                     void *ras_error_status) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct ras_ecc_err *entries[MAX_ECC_NUM_PER_RETIREMENT];
> +     struct radix_tree_root *ecc_tree;
> +     int new_detected, ret, i;
> +
> +     ecc_tree =3D &con->umc_ecc_log.de_page_tree;
> +
> +     mutex_lock(&con->umc_ecc_log.lock);
> +     new_detected =3D radix_tree_gang_lookup_tag(ecc_tree, (void **)entr=
ies,
> +                     0, ARRAY_SIZE(entries),
> UMC_ECC_NEW_DETECTED_TAG);
> +     for (i =3D 0; i < new_detected; i++) {
> +             if (!entries[i])
> +                     continue;
> +
> +             ret =3D umc_v12_0_fill_error_record(adev, entries[i],
> ras_error_status);
> +             if (ret) {
> +                     dev_err(adev->dev, "Fail to fill umc error
> + record,
> ret:%d\n", ret);
> +                     break;
> +             }
> +             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +     }
> +     mutex_unlock(&con->umc_ecc_log.lock);
> +}
> +
>  struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       .ras_block =3D {
>               .hw_ops =3D &umc_v12_0_ras_hw_ops, @@ -640,8 +694,7 @@
> struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       },
>       .err_cnt_init =3D umc_v12_0_err_cnt_init,
>       .query_ras_poison_mode =3D umc_v12_0_query_ras_poison_mode,
> -     .ecc_info_query_ras_error_count =3D
> umc_v12_0_ecc_info_query_ras_error_count,
> -     .ecc_info_query_ras_error_address =3D
> umc_v12_0_ecc_info_query_ras_error_address,
> +     .ecc_info_query_ras_error_address =3D
> umc_v12_0_query_ras_ecc_err_addr,
>       .check_ecc_err_status =3D umc_v12_0_check_ecc_err_status,
>       .update_ecc_status =3D umc_v12_0_update_ecc_status,  };
> --
> 2.34.1


