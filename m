Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE3E77188
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 00:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D188F10E43B;
	Thu, 19 Dec 2024 00:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCbErW7o";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6733E10E6BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 00:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYueMfzUdlV4baa8E/GMBg5s53i2KeaQaHsVFzDOkANlhJXYF3kEILqwzjFIW3Cqm814QWoluJWoFnnl3e8to32Bc5Wm0thkOoL1x5EHhX+W0989P50dOwxz0L7/jdzsx3FMh1bAgnthBI+U8CXrw6lBKwGe9uxm/K8tl9vg1HA+8fPJfofyfhVICpw4giOqs5plwOU0GAOwxgmGvTR3aEX4WjwYiKOcrRVr1y9R205j2qTLfkgLMRa8teHzA6kO76Qlci8F2JgSsgo0JjtgK5kmWlCUuLjuL6I5u7VF88lAFsuZbUeTOgmTmZwoxin/+xY1xhfGuuCnxHlod2XbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCZmBxFXp4jAfaUNW/xs6a4Jd5N2AMn3k3c+htlpBI0=;
 b=HOLZlfUiv5xm6AQFK9YDnWXFPAVR7SlO99y6idxj4h/CpyGfDRSGHejn1tg0kqZzpQX257inGYtbGpFA7wxtY7uM1cd2BylVlSCwMeLo2UMGMzq1JSEyXI4qGvtudqE594ci5jPw/0fwwtmg+gaTFak7SbFUh9lBQq+fjEPMjPBdrlk0HhN8n87MozpcrPzInGPyJa5L0IMvl0GFNrMYVuO8tGl2zL0KlebczoGK4Fjw/GJHMkz+5MCExJ5o83rLOWx9OHUhU+kvZswiWRpL+CbaCAD/EB1ukQ4khmNHTSh+RxhUSyDf5iGeWgwQvNYNNnigR0HWJy3Aq1ZJZbo2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCZmBxFXp4jAfaUNW/xs6a4Jd5N2AMn3k3c+htlpBI0=;
 b=qCbErW7okRdb12TiXCxPXCtqO31geZ/nOzrlECVcgyNaNXNO5xUa/26LrbUKoZjXfbcrEqxhDrxAh3Q/uegC82bivQ4t1WH+Pw62yPEZiY8oJqi5G2buDVpiLLmn3jzF64hQsssZuHeRxYNP+fKeIBPClSTGTJ0t74+A1X8bUp4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 19 Dec
 2024 00:52:36 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 00:52:36 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Tobias Klausmann <klausman@schwarzvogel.de>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2
Thread-Topic: [Bug report] Regression with kernel v6.13-rc2
Thread-Index: AQHbUWUGfslbcL05S0qwZkVRMIlnsrLsNeIAgACHSpA=
Date: Thu, 19 Dec 2024 00:52:35 +0000
Message-ID: <DM4PR12MB51522537655C2C5B3407BA3DE3062@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
 <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a68ea0e9-8139-47d6-b9b1-67f336e8a35c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-18T16:39:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB6756:EE_
x-ms-office365-filtering-correlation-id: eeebdef7-f523-42de-c395-08dd1fc76e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2Uc5QQwWRk3pLuDBkvmDiR9sn7qUgDj8MouCnwIN9JATXvTDzewdfDsM3sLN?=
 =?us-ascii?Q?20TeoVJ3Mh+2S1G96GQtcVoHG6AYAOq5hCl9WmveEOTWcUuP24IOTuVojjif?=
 =?us-ascii?Q?usrum7D6bsJORDbv5B+MPVSLFeF7BKOQgJ77/y1MMKOnPdoW7rXcoS/WXO+3?=
 =?us-ascii?Q?HZjHno6rSv6wdGCLQ1TmDcBZZAq2Lwx5aM/clvEgKMotTVgtHHepxAi7VlUR?=
 =?us-ascii?Q?qtlcEaGoIOdSKe7DWlr3eGzq/zw4W6GkSTVsR08/JvZKrtCA8FwjG+ISJAV9?=
 =?us-ascii?Q?U+XR7ppZBN/22hguk3uLb3Pz7/RIoipMZOinwtnF0zMvOUycCp2V7P1GDNQP?=
 =?us-ascii?Q?Iq6iRhjmUXY4fnguZxVO5fXe0AW0tHHhFdft34bc25hVLxC+UK4Qx8Vh96Vf?=
 =?us-ascii?Q?YLWpjag5sOldxrg8Hc1Ia922EQc2P5EUgrGcuvzSMQdasG6C9glQD72GJu5i?=
 =?us-ascii?Q?jeebJYOHJ8cswXcPs4UWuWWJYKrtWh8BFiGsJJ/B7h0PiunzSCpM5ulAuYKG?=
 =?us-ascii?Q?w4dvHDRb9HYGxoAbor8MtnqxvzktI7hAZyZxwfKL7K9R7wgE7OgOn58lNhPJ?=
 =?us-ascii?Q?k+L1PAnW4VibUjLrS25sVZnwkGaMP/ITio4/4JP4CJlzecoESVl9HUWR/40+?=
 =?us-ascii?Q?q7s0HTFsQn0an7emzgvNMio1bQqaAABHGWmavy5ADEYV0KNayl5S9DuAKhvG?=
 =?us-ascii?Q?JjG70FnLPJ5c9FFEiEHjCqPyYQNxHWdf5F34192z3DiFKcI8NTD95JTJJHLg?=
 =?us-ascii?Q?iOJsMz1ZqeKtYuYOYkBCD9HYP9M9JvkqibNhvSxLqWtzudhpou9IGrOPg7f1?=
 =?us-ascii?Q?ZpjAjnrjynorlGRWsON5JGY4w3o368FRL7R5+QFtzgp7hzNb2qn6tBuZwz40?=
 =?us-ascii?Q?F8wCB11763NpXgoYKZXpWFklnsubi/DXPsmZe+JjjoyZtQ2jN4DUHdRaYE5N?=
 =?us-ascii?Q?KRiYP/wHQRFvGJv+V69sbSHiHJKZKwo45BnSjqHned4sXLbUjAOmoH19ZS6S?=
 =?us-ascii?Q?XCu2ld6nL41et61x+zsx++THtrvu/rnoJIibSeiG/SMNs0nq/uYVhrj3r21k?=
 =?us-ascii?Q?hY5bn3wZXHEz4gR75cmkmYhBayHQ5WCTSdKTR2GPF1bHm2HexDhkT+nKnZ7H?=
 =?us-ascii?Q?Cwbmw3xpj3p3giZptgdm6ugCEan5hnZd5XIEiPxzukPy4KWxK8Mbyga1zkhH?=
 =?us-ascii?Q?YW3ocDI01VVoHbnFx9o2/BCrs0pqMUmiYIj1ZRYtt/8UHpKdUlVZy/drqwN9?=
 =?us-ascii?Q?0AlmyymMCm1Bvx+FKTFejgdIiSa6q/vYvruElehdkHzGz7OYjHnKsDe5C7pL?=
 =?us-ascii?Q?UCLT47SVzyaqhzNNEKtNHikEMmOU+k4h9MQJi1TfNzBL8Goe6udOmDasA2Yl?=
 =?us-ascii?Q?oDByrnzqkCZ38KjVtSpnpn2YxWPTk6eAkiqketvTg0kNXwufnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cZqIwA3ImmiqFrhHn6NgYXuC0wpq3HZHTkpw+FPSea/BDAgRcITc5bVmvwUA?=
 =?us-ascii?Q?PizKhZx+XGQn0WDyeYyDTgtMK2X4bRPbqtje1L1MyjOmfhtOv6/96Eb6EA4f?=
 =?us-ascii?Q?F9TVqsJzWzgVnYgTW+xbRcXl9OOlKo34MueyyxaaLEG96bQWGbvb/msNFADn?=
 =?us-ascii?Q?XhJfU+yfuuZHMAb6NW18Ly8NvM9OzjjHvHylLdBysv0gT4gyM92GoMHNfTs/?=
 =?us-ascii?Q?hmUOFl7wxZYBCwDChHZ0MlCFmpTqs5a8FBgPKILOxSJaz7MoLpY6xugo8wCS?=
 =?us-ascii?Q?PluzhPBSZ3jMsMiCrgQxedAp9dEfSIck5awotM6OU409Ss0VqtG+oBwCibxM?=
 =?us-ascii?Q?taOJtH6BMjTvfmgIHM6CQ4R1OoMHnIfpbPnS+6P0cvNb72Yv7pQCq6fy5sS7?=
 =?us-ascii?Q?g4wyJst9Ax9lYvtcNET+oYvNlQngj1J/IZWA9uq0Wl2l0nhddmaz+xvwmDOR?=
 =?us-ascii?Q?r5LwlVkr1i7A02RrL8xvW3PsbFGe+dmJbzv1f5PAV5IJ9o+E/BIYiXCW1oX1?=
 =?us-ascii?Q?ZMc8FR+OYEI9BGU4Y9bhUIrOHzc+z4pv1gS4RU0NNxzo6yMuDx1aRXrxlUNL?=
 =?us-ascii?Q?MrpxttM5YG+1m+XqjZKULs2qwUWmUhvKBQk/N6cVTt13B8IPp/wW/wWQ790W?=
 =?us-ascii?Q?bgUcLUmTMeRZyygcJBx7DyuNyJQwx0G0EFT/kGPlDonBfqbxY+yO2OspoGfp?=
 =?us-ascii?Q?nJcFYbDRzsdQknB+iXqLWOLTGsqKyUNxcciGVA4SdYZzcvGsm64/jP6Xmlpq?=
 =?us-ascii?Q?nxqY44RgzOPcAFfA1RTi2PyKvUaF5KsI6Mh84gDCROF9FHFyFTnnBdr9DSQB?=
 =?us-ascii?Q?kBC9+UwcgWq9IAKWZ5r7jfUJa7LUeGXINSdHBJ9/FPoqrsRSxVWxfZKlYtfo?=
 =?us-ascii?Q?Y17g4gWc5+4+UzYO5swFe5HdPuAnbWOrsrPSkXAmuQWUXdVFoq0+iEvH2cUF?=
 =?us-ascii?Q?/MtTZosNzZ8PDeJq6dweyVFHZydq9ay+Q3PwJCGgM31k4OUEJCWIqxBI8wtm?=
 =?us-ascii?Q?6sqEVEjCFxWSC7xVknOH+ot4TiZwB8+Eq2JzRUscM3Tuya3katlblE3IlVMC?=
 =?us-ascii?Q?EtfuVlyVJWDeTanzRGCSCnEwu9oX2RzkbdTmZ0fFdqYw+ZQ14+oBBmJpDMc6?=
 =?us-ascii?Q?JV2C9h9SJqNQo2K2VKfZevy6Ndw3//NbjnG94aPGLVfZnqoGX/ALhXg5GLr/?=
 =?us-ascii?Q?Bk/9Lyqt/AVSgz4CSsof35O3EpA8R5kp2dXNTjY00JJeuvQHpR7uswB1chZy?=
 =?us-ascii?Q?AHBkZxu/pW1WEtU3KjP8+HaYCmw5nhgUi/U1ASEeVCfHUHBGVpTJLmdA5gnu?=
 =?us-ascii?Q?5wB1foW7l8fpGAOx2uLQxtfYoJsEOKP9+s7oXDnIfRRhMtdcb97dHpUZCuXC?=
 =?us-ascii?Q?+B5gJT+rINKOXlswM6z9eibzgw+MRV422LScfiv+eEkVppij8/3olgJQLNCO?=
 =?us-ascii?Q?SWCyM/ktd+gIMTvzMaCO9twpGFtCX17T43G8k1kSb3DJvoY5ctCftrt4YedQ?=
 =?us-ascii?Q?i90fPVI2fL3oNBIZPQOjm0SmMyat5o74WqKQUTDwtp0pZDmTzeKotl8iUlR0?=
 =?us-ascii?Q?xvzdTw3m00e7uutKhvY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeebdef7-f523-42de-c395-08dd1fc76e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 00:52:36.1234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmDXOTDVeLmm5Lom/kOofDI2HKtXvclj6Owev/P46cBawYqc+gAHw1MHTDR9HKtR1y3lICYfDbOdypIqRudhuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

Hi Tobais,
-----Original Message-----
From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
Sent: Thursday, December 19, 2024 12:46 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Tobias Klausmann <klaus=
man@schwarzvogel.de>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2

[Public]

> From: Tobias Klausmann <klausman@schwarzvogel.de>
> Sent: Wednesday, December 18, 2024 10:54 Hi!
>
> I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
> example:
>
> [Wed Dec 18 15:56:24 2024] gmc_v11_0_process_interrupt: 10 callbacks
> suppressed [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040B52
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x5
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page
> fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x3
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page
> fault
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10 [Wed Dec 18 15:56:24 2024]
> amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
>
> This happens when loading nontrivial (~6g) models using PyTorch. There
> is no immediate crash, but if exercise the model for a few minutes,
> evetually, the GPU crashes (sometimes the whole machine).
could you help try with this patch ?
https://lists.freedesktop.org/archives/amd-gfx/2024-December/118058.html

Thanks
Jesse

>
> I bisected this betwee -rc1 (which works fine) and -rc2, and I landed on =
this commit:
>
> commit 438b39ac74e2a9dc0a5c9d653b7d8066877e86b1
> Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
> Date:   Thu Dec 5 17:41:26 2024 +0800
>
>     drm/amdkfd: pause autosuspend when creating pdd
>
>     When using MES creating a pdd will require talking to the GPU to
>     setup the relevant context. The code here forgot to wake up the GPU
>     in case it was in suspend, this causes KVM to EFAULT for passthrough
>     GPU for example. This issue can be masked if the GPU was woken up by
>     other things (e.g. opening the KMS node) first and have not yet gone =
to sleep.
>
>     v4: do the allocation of proc_ctx_bo in a lazy fashion
>     when the first queue is created in a process (Felix)
>
>     Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>     Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: stable@vger.kernel.org
>
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 15 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 23 ++--------------=
------
>  2 files changed, 17 insertions(+), 21 deletions(-)
>
> I am not sure what the causal relation ship between the commit and the
> messages I get is, but I thought this report might be useful.

If I had to guess I'd say that somewhere used the pdd->proc_ctx_gpu_addr be=
fore add_queue_mes is called, and since this patch moved the init into add_=
queue_mes null is passed to the GPU and we get the page fault.

+Alex as well for awareness.

> Since I am not subscribed to the list, please CC me on replies. Thank you=
!
>
> Best,
> Tobias

