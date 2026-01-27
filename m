Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC233D2592C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 04:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFA110E272;
	Tue, 27 Jan 2026 04:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMyd+7MK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F9F10E272
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 04:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf4SZmO9pVRDX2uTbqWcSc37JoEiub61I+SZSw6JEqsRm2KiIFj110B3M+jFvkaPIouBHldhjo/h9DOVHF6gUeQLzoGQrAKrzdmlZH3j2PBuOGSMZtfsNAWCNI5OkWnzeA0AN2ne+XzJGO+JtJq+QucTzvfntCSw+xKn4t094LotHUuRlPbt250hMZ3fRTVJJGEYUGXWfVjUxgiS8saoPcaVBHTyusO2e9G0swCxYtrawBVruwH6ry6fOJss9uCn/1aWJA5I0D23HhCJqhmiy6Ich/3wtkKubhccLGOrgeGcE0ed4YW71XRiWavmWKkz5WrOtptRdMD7YEYSEhTsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJLNKrBxcitc6kLO9lMYfHcSszqYEEOBeWRbtovNIP4=;
 b=x9Uxc3QxQrIUkLyaGBAZuyuvgrjMhM3tgQxI4sR1oDDiXaFWo3Dia3ZMZkGo+DzYTG0XYl2UeZxVNyJ9B2bVJUG/KxaacKMVazqtOvqEJEqMBot3pR/3Vg3Dd7iUYgISKIdn5tYdTSoSvB5Qtvcg2ZIl2s9unbQ+ks9GPZsf4Yt/Xs4XsYf2CU7t4BYyq9ZEuE2wFE3m1OePUu3fTq4sE4G7ZZZQNcbxNLAvAH7hZFDYNovz8UPY5QZMGAR4crYOL1bbNxr2NdX7amxKfhsKz+0zYyr8gFdcR9oTpPRjSXBT8ykusB8S7MtfHBDiyTHbeQEUzWrsi9O718tjdGpshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJLNKrBxcitc6kLO9lMYfHcSszqYEEOBeWRbtovNIP4=;
 b=RMyd+7MKbcGR9Y9Ok7nFUfjFz96UZSTqoN2C4dKsEdOr/HRkZ7GVXVJgpWumEDfnRHSuMgUanWEkU2s2eKaKDOB2Sl5oGeG2fJRgVEE9A8P60FoHTbkJNnECfl7uObl4Miy8M09+U/88zA7UQpIl6GGgOHeh4+tikaI7aEXHC/g=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 04:19:35 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 04:19:35 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Thread-Topic: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Thread-Index: AQHcjne2CnaqqUXynEW4Xlqr7nzvabVlZU8AgAAF9oA=
Date: Tue, 27 Jan 2026 04:19:35 +0000
Message-ID: <MW5PR12MB56847E760E7378AB8DC69ED3E590A@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-10-ganglxie@amd.com>
 <PH7PR12MB8796A4E42378800F4616CB47B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796A4E42378800F4616CB47B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 28434948-f489-44eb-70cb-08de5d5b4748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XcQmwL/Rw+cKapKAp0OCnlIW53pHWvvQE4HDdXnLOTOp1dOIx86AaI6GuqxH?=
 =?us-ascii?Q?dF+FEkFObI/f+LNKvPZ4cjCGA5pgKn+KWLagwSi+6cTxABbi214OuRtWZxhK?=
 =?us-ascii?Q?qRQvGUEy9TOK58W73jpEujOGBYYZEib4d1ceI8GlfxmTfDACIC3Wej3El3O8?=
 =?us-ascii?Q?kHAxfEZJCBue+TdO+E5zEuexhfciTL1mcOB6wCU7/s7V6d7mY6FC7D5KLlJW?=
 =?us-ascii?Q?Rr+mqX1DqjJk+xMCIRhZem+7X8O1sqsaOqlXjUh5eMP1y1Kk1RE+GHvW+4rC?=
 =?us-ascii?Q?+AGJHJH4GXcMxhwtl0MnoA/XeJvVEez//L9U7qqfUZ4OZYmov410182cYJ5D?=
 =?us-ascii?Q?5/Pzdc7su8qyroPHK7MbPMYUpOs9FdioVO+uR99E2PedLsG5OVkW5z7MuwXE?=
 =?us-ascii?Q?+6xrxuouJ7+7Zbpcz4JHFeeDG0e0Y96nEgn/ZXmouFEDWRpha/i6zcDPC4Uq?=
 =?us-ascii?Q?LrCba2FqcLw3PngZssVCMMh9vgCwIQZ1Rvx0m6ZsGRyeEbifSAAugzZvzLfS?=
 =?us-ascii?Q?lv36HdG81wvmsKiT0J/USeW5yc+7Wr6AVXIGG9yHkGvfaFt6OwRYdTLddVlG?=
 =?us-ascii?Q?yOCQ+MSTtNDh8iQ495UXmKeQJ6ux+EJb4LdnLjanxZO9TFG/16xerjcYg685?=
 =?us-ascii?Q?Pyx8VLAaD8JgSUXz8DT8YKhH4x14E2bRxgLtvrlnGGyV4LvGjXq41SdH8zAT?=
 =?us-ascii?Q?eg2uS0slyaJEs9T2S55gPh0NKYJT2y5RroWD+ID8evUg/3NLaSwMgV6mqZix?=
 =?us-ascii?Q?69b2jrfzF43iXcodBnqtgYnHBUbuzwTDYidNBUqD+GWkLOKZtITbtPXGD/Cr?=
 =?us-ascii?Q?TDAcAOmLZbBpNDCvWrruAg63J422td2CiO2aKywG+MT3bX+zVv5it9gXXuyc?=
 =?us-ascii?Q?t7MjmmEX5r2LKitit6uxCX+uDY5Dlo8mjs1GtvP7syInJzqOIWH7zoTJl4Y2?=
 =?us-ascii?Q?JiSjTFcLfDdpf0J5KYPt/0BwjYZeAEGhXdGqZh0iqxMkYUCmkoUs9LK8RpUT?=
 =?us-ascii?Q?DrEWBWwmIwAfCtwUQnqYHgB+y5mW3RPI7x6YQHIu8zJNus/wzP2CFB4Piycx?=
 =?us-ascii?Q?VzWovbnSI7lbHyfw15hIvsYQdubGBE2Yty1s1ZEo51Q5Xkr9ZxWq+k9ip/gX?=
 =?us-ascii?Q?r7dV3aecK2Dajwk1FIbsyUAdRU7rtnUUNLMWwAnNcM7kQIHtWDl6jOFEleiv?=
 =?us-ascii?Q?c2YLW7Y8dl570ESi/hAaOSxldCkbnq6E4khEguseSUPiyn+3sQKebMQLk2em?=
 =?us-ascii?Q?X0Z7y6i9X0DTtv6c+x31rmd6RLmdtGF9UIjYXOMO4U5gng1FHZaOmrnvathQ?=
 =?us-ascii?Q?5YLUE33L8HIRLuv0udTEiBh7oOfmTJkI+jrl3wZIzanca7g2mJBWF7UnG64g?=
 =?us-ascii?Q?+AruyVDxfxhUMxwEYiYIduzOkYKN1n9/kC/zwwAWsY/nIZdt0ZqpD4+ZI0IE?=
 =?us-ascii?Q?EU2PJSHinm+nRd1r4V+BGjp4mQZbNmhUlAR3hLqRRfEMKgshbei9+lXmTcmw?=
 =?us-ascii?Q?BV4W9YbyHbTNo6i1BwIWdLFQTyiFFXGyCOVO0J3t3HpsRPW+lR2TAt+89zse?=
 =?us-ascii?Q?MTlsfPkenAU8vRPKrT0md+g6s1YDVeItdnPaNLAl2vrWDI71fGtoRsS62FJp?=
 =?us-ascii?Q?N/ATlqra1I7DAPFP1xL2FJc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xBAzUNk338FtGDFOq6Nz75tpDDLvnI5fzkMaf+TIhJdXZezYCp14vzYVpeSk?=
 =?us-ascii?Q?2JQdzys5DXTi7/+CJ12VCXn98hqXcltRhIy7Lt6onuDZpWG6H+JkKI7Dm4sA?=
 =?us-ascii?Q?CRAfuBODJbznqRGW8JB/CkI5j0vN5jk4a/RScbO0mxOVvVzT1wrC9w5TIMac?=
 =?us-ascii?Q?yUwgVe7sEX3RqsDnpweq6BU7oLFI0UhK2NjR3+9pxDBodWzUc+n1h74b8DSn?=
 =?us-ascii?Q?CYvVPTtDmahbx56pQxqf95TeZh/IPVecKPVkAAPUV3S0qkkl6mcJTzjRkyPM?=
 =?us-ascii?Q?IekD4HTbI/IautHu2d4esdeg0b/ODYGBo2V9vsPsRe5vL2U7PVEh4XR/HCcv?=
 =?us-ascii?Q?elgRzwxvuaASAzfQUSlkb976Ur+j5Zklc0QEFBd2y0NxF4gGYAXPWVTu5tVl?=
 =?us-ascii?Q?IXmcQDuB/ZDXVeJE2EUn1sX6SYz+jyVTZgO1iRNLxOqvmV7xRNvADWeiGXi4?=
 =?us-ascii?Q?e6ZkbosZqZyDMPxfJfK34OUVCuOrbai2LzYp+LEt01o610K1j2N1n0gT8TKC?=
 =?us-ascii?Q?rJirnS7DS1vpWs3EoizUcfAx7G7caiwSB5toUdhAsa0UotNSojTrJ3vMhKaE?=
 =?us-ascii?Q?dniwB9dtmh84HdaGL49MosO/FrdFXddvoKDJnraqcq80p6tHrLn5CReNsHNq?=
 =?us-ascii?Q?bQ07sgLA66hfIr8dwZtzz+iG/epDXUkJ049dvFC9Vu5v26xO2/svNFkjy8wF?=
 =?us-ascii?Q?5qetctqsJKCbB9nYIOFu95D/EIcekfwOyQ/y3cq4v4bO0q+rv9RWxKB3DVly?=
 =?us-ascii?Q?TnYHdyFKOOzhejVVKdHWZ8fRt66lz+RQB5Bw10dfFxfZSnHpSfRuakVWa7oa?=
 =?us-ascii?Q?uBrQWObp05iQkFklQqnU+f8VSFhf2ujD/2B7SFv1a1oWJwYJXfjEPVL/WLiX?=
 =?us-ascii?Q?Z/BHp/Q9JgDCPUruFhCQ90UbEZ8lxhs42fhHegC/7iHvjGsv9PIi0665KwUI?=
 =?us-ascii?Q?IatoiZUfuuUEP/utxTfRDCz19rWAZnMpHGO60KtlND34anoT0GMnYeGcyxWM?=
 =?us-ascii?Q?k8ePbE9fJRbviUAR1SK2VwFGk9dW9KS+88xYLlbCMIxsSXXJG+FHnUL3JMny?=
 =?us-ascii?Q?dV6P/wfZCB3EVbcnhzuT3i+NdjwhUDQrFrmkh9k73tmbT6w3koBTwf2VSnsk?=
 =?us-ascii?Q?8yXpxjDfzhaBSyFYvCDiz1Vjm5oCPLYmtzuZVnCqboP2AVUCDC/+HqJm2/+i?=
 =?us-ascii?Q?GOZf1nhY6SPz3id1xAwhc3Q6QY3OBGlwrdmP3xhv9dZROhAayNMsydPe6Nxf?=
 =?us-ascii?Q?p6K4P8Ep2aIJiJxLHHQXN381sTBdin6gdE6VmI38cdBLFHCKF2F2TMCkeHjN?=
 =?us-ascii?Q?tBDSpcdnX6Wpy++us8UJj34v+Wp7yaCYtz5cEsB5CNO6AjR4A/pjANVJ4xnh?=
 =?us-ascii?Q?A0TSEdpwL1gRr0zIMTnTVVN532u1m9Cd+nqq2h+jcYNjuerJv8f6WczNJ2LB?=
 =?us-ascii?Q?dRh21R/F8718MLzPbmfgqUb2NAh2FYmNRrr4ivlxTvD1zB5k/hGXHfzKpdb4?=
 =?us-ascii?Q?E83CzrV9z7Dg4xKhYOhN5GniHztiszG+NchL3jmUG7vjg7PPekNMvkXNdhxt?=
 =?us-ascii?Q?urLov1b1u+xjgboR1FEk4wRhh6ZuFRh8nr8L6DdDFrdm+Uf7QnW4xJWyAa0x?=
 =?us-ascii?Q?/pMz6N/JdVow+RjIo1wyiPqiqu4b6PX/PFqZK8IjNPuTPssSCd+gB1BsNDQp?=
 =?us-ascii?Q?7Q23KG7JypBqbFrmgg0MfRSO+lsJY9+i8D7kAqFcooPRZ350?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28434948-f489-44eb-70cb-08de5d5b4748
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 04:19:35.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgAe5KK9yHfcUfRIPUD1PsXTTcXmoUFNSp5FnbfxXQCcmTVWuonvPpDhIJ8O/+m6Mrf7qtIfELG3Tt8I9M3UoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

Thanks , will change to 'out'

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 27, 2026 11:58 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
>
> add read func for pmfw eeprom, and adapt address converting for bad
> pages loaded from pmfw eeprom
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
> +                      u32 rec_idx, const u32 num) {
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
> +                             (uint32_t *)&(record_umc[i -
> + rec_idx].mcumc_id),
> NULL);
> +
> +                     /* update bad channel bitmap */
> +                     if ((record_umc[i].mem_channel <
> + BITS_PER_TYPE(control-
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
> @@ -70,5 +70,10 @@ int ras_fw_eeprom_reset_table(struct
> ras_core_context *ras_core);  bool
> ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core); =
 int ras_fw_eeprom_append(struct ras_core_context *ras_core,
>                          struct eeprom_umc_record *record, const u32
> num);
> +int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
> +                      struct eeprom_umc_record *record_umc,
> +                      struct ras_bank_ecc *ras_ecc,
> +                      u32 rec_idx, const u32 num); uint32_t
> +ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index fd427fd59ecf..eb5bb6df18f5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -436,17 +436,27 @@ int ras_umc_load_bad_pages(struct
> ras_core_context
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
> +             eeprom_record_num =3D
> + ras_eeprom_get_record_count(ras_core);
>       mutex_lock(&ras_umc->umc_lock);
>       save_count =3D data->count - eeprom_record_num;
>       /* only new entries are saved */ diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> index e2792b239bea..53dc59e4de0c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> @@ -413,7 +413,7 @@ static int
> umc_v12_0_eeprom_record_to_nps_record(struct
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


