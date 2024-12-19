Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24DBE7718A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2864210E2C6;
	Thu, 19 Dec 2024 14:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aw4GowJC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A2010E2C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 14:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpPIOjMSDkNMbF9g7rvqtN2Imtxi6Wvs1I4LBhpBxn+S+kXl2Nav1ezfCPPz1Lx3HoPaoTeheyEIhZ1qq0lQXWkEFRd34heZdWe6NKTkcB0h1TBntuvL6zf1BUhM5FoHwFDKZ0tu1HWO4Xq64t8MM1Tl+A7VIyy8pKv3SloWbZUocO6Y9xJQPAH9IWp1QIMBOHZlG37AQ9B92E7ACK5hv/tY1gt3XViDRq1L8Nmt6Sqr/qngOgYGKVnwii9tQm5HNKGVsdy8bu+3eGiO4ucMdkcktSakAn/VnQ/wsW9+yzStrNOtQrPvwCcu0QR1WmO5G8xEpXq19S/A+L4TNPmpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10TuCIW4OPAb2PTNsrBZvpq4vTB5+1vTqxd95EL+33s=;
 b=LBj2jEWZB1H1eYKjasslfwo85JY8Wp+0IELeuZxRXFczXZV/gHDFmzHec/7pVrGKh6ZfWCNHgiSzzN5sfYrJDczW8CdgPlJs7dl+0uGJYlhnSYRZ09omSAOz3x1Jy+8P7LXJ6ASLBnChKOnyOJmlfCX9DVhiaS7kXTcbkxzpLG4De+CowT3Ws+bkgelmuWKgFkZRYFbNOAlYZo9xOvluVTIHI06UXVmDXVYTxI59IOFWiWnZfrWMzLZPjgK3WJ90zUsUyHbs2TP70tLHIj9cy8rlRTzUw+7cc+2nCXbs0Ats4/pIEndxKspYDwq9p/D/It0h6TTvGmcdwi9hI6RA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10TuCIW4OPAb2PTNsrBZvpq4vTB5+1vTqxd95EL+33s=;
 b=Aw4GowJCgYi7jdfukNIE4PVDwzThlJIGvN0I2daU0uLKDFYkjCY+XP2Nut7l/ey6tM5/v8dsz8aSsFmxEi6Liv0B4H+HAJIGcX5mG5mAj9zIQePUwo9HwXIpycdwUd+7AIbZd9r+SXS7SsRsBGxlNXFJtw5cWKAMaZw7atdY2W0=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 14:59:38 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 14:59:38 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Topic: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Index: AQHbUTc0YquUsl8amUC/3ih/MYB9X7LtPi/QgABrtOA=
Date: Thu, 19 Dec 2024 14:59:38 +0000
Message-ID: <SA1PR12MB85997BEE45D88FD36C16D8F7ED062@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241218102541.812627-1-jesse.zhang@amd.com>
 <DM4PR12MB5152E8A1890753941154DA71E3062@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152E8A1890753941154DA71E3062@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8aa85e03-453e-47ac-a118-9208cf696839;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-19T14:56:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|MN0PR12MB6246:EE_
x-ms-office365-filtering-correlation-id: 21a07cb0-1c62-4185-f0be-08dd203dc27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lk5PLuh9J0sqtZk/38lu5E8BIkKAZP3JZ0zxbKlSV0j9zMeRhlp5/A15Z0KF?=
 =?us-ascii?Q?mMs8ZebIHPaVCCW3cUC3mBoGAHxwV+6SGH8zKxo/Fwd5d1R7VZzXndL/y/Y7?=
 =?us-ascii?Q?VGeFef6xVVGI7LC+jFH/FOnM0Y0xgO7HUHo8RuXiKv0V71Eu8uGKGdbdAFOk?=
 =?us-ascii?Q?FtEPd++0rNpUda1J1NYuD1Kspm2VBjqQ/EAoW9Szg3Wg3onaA40hRuiLy32b?=
 =?us-ascii?Q?l15oBAdanOJoJRGt+fbAnU8hRSmlT2TT2H+Iay3uPEjAiC0PthXUoLhm+0dO?=
 =?us-ascii?Q?y5/rXvrnAv2fx9YdtFr+BFIDmp3M4Hd5CHMKIFhFQb6rcWg9qlICSo2/M+C5?=
 =?us-ascii?Q?jHTpEM2wgYOR93Y6BEnj3ofsW1mkub9dtv6XsLfsQsIMtOVAfe7DUicb27f7?=
 =?us-ascii?Q?S9vIAaFR9cEY49nTupnfsHBnQwTIeB+T7mk67U5s1BXrwIZMSOxaCzKxfctk?=
 =?us-ascii?Q?ccyZTWgJLYqyelqovZe2sng1Adz/gncW0p3/w3dN78US+44sQQ9T2u5WomD6?=
 =?us-ascii?Q?u9teDqOq/kSPGjhsF/AKCZ/09vfbmoZ8c9jstCYfD5l/4zPyGpsjieb/QmxX?=
 =?us-ascii?Q?TaUF5VopEsCnbQrV3Vww+hCT59o9ETjoFI61KFUcRkdfPi3PsOgDnD/twHlU?=
 =?us-ascii?Q?OgAb2gJn4OHZXx2O6jztK7ICsyIpKE+Ov5VG5LYCReq8vPnYKhc5bXsgs0ZG?=
 =?us-ascii?Q?3F7y5DV2/OwRlzm5+XLnHyPESCNxsZje8ISDD26Fz73pQRP3hxdm5W5xfRxa?=
 =?us-ascii?Q?+BrS8kaDrjzxaT8t5AZ+M3cprcxG6Lacv1N7iX9ouVM3nQqxKzzp8BrSzghh?=
 =?us-ascii?Q?X4+d9ey+sLn6SIhzz/qiBGD+XHnnEIWzcEEtEHkv44PW2WdCsVSAAdYuVzcW?=
 =?us-ascii?Q?wNFUGr+I4HVcvwqCz+o0XC1+lY3VntOBn7l7UIxYsB3Dtrm1dcOt+b57f60j?=
 =?us-ascii?Q?NYIrLcXGIK2Ps0k1YlTSDIbfAldh0+Dud6sl4KLBoWN9LtbMThXC2kmEg7QF?=
 =?us-ascii?Q?67jQBpcGOAVbTVEnUVME2nV69K61Y8gc4h5SGlOV5L9K0EaYWlGYN9XJlfSq?=
 =?us-ascii?Q?TAsgfhZMBV6A13C3ogCAaD8KW61FTHgGmNIdQjY3+jJ20+9/rdIAS3lhMgNN?=
 =?us-ascii?Q?91vSmf6f5z6XWLnY90eBSbOyU/CIl1R/JWDnoh7B3N02ohUkCsv7+3uMOxDM?=
 =?us-ascii?Q?ARsUWs8DavICzltLqrLbr61JCEgrVmEPJcvA6EEzhe0oSDTXq+gbl1Ej80rn?=
 =?us-ascii?Q?vv1mDEyHtdPHjXh1e0q1jn0L65RoVwoojQTO17NmVQv6u6QdVyN7jRQ4z/sX?=
 =?us-ascii?Q?exlkiBmedDjrn2KKIS9P4rD1WnVtBgAlpMO2uKPWw/8QtXl8MiTSzUfQwlEb?=
 =?us-ascii?Q?1/V97zLp8nF14am1iRm7X9gHKK4Tjq0sxyOPZUSW1tjTj8G4GK2n6xPyTI5u?=
 =?us-ascii?Q?KW6l9kjRWf+Hs5Vft1nqUVIoiCAcBlTd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pqgMX0V45W0geIavmENUldl6eRqCP2xbzyOlcKHhL732x8uNirh9Ga88vdUZ?=
 =?us-ascii?Q?7tMdoQ1yekWPlq194oiaV6ZiMZAbSYti3lcHMYwHgeAAtBJroR8BYNqJtRBe?=
 =?us-ascii?Q?uyuVOYfZYPNiaryLm2O67Zc4fVoSuxHrXEqjgAxLZ6Pg197Xl7Th0s87PWQy?=
 =?us-ascii?Q?LyCUlyYpV2OMGvKHGRfZkurqrxnyQzaXXq/HdyeQLgNsM+W1BPNPV1CemHDg?=
 =?us-ascii?Q?gK4ZM6pDjvTGlEEoEzZnQpGj3Y2l5JT9jC/1MI54m18ukUAC7VyR+cpErwYX?=
 =?us-ascii?Q?5IvF/Gv+74dxKtGATxGNmSBxIJ5UdNYvd5nUEKzAKH+roLwFbToqE0eLX3au?=
 =?us-ascii?Q?Z4bGo0al4CfwwgIfYjHU/lUJVe28i8XIK3oIqbVQDrljJs2dRJueyHD9jtcm?=
 =?us-ascii?Q?caC25bj3EaALR++Tg8M+oxkWWD6F6mjNMqw2R0xsgsiyBC509tx4o8B5IVMO?=
 =?us-ascii?Q?41jLa8NFskzPMz3e0PWlHsU1NzY5EKVb2HRROaglJuuN0/j6xxqYqzAnBUIe?=
 =?us-ascii?Q?doe2+y1taVbgRlfRjWkMPB1eENzfy3pl3osyAlGWnAIjnpk5NXD93OV3EG7R?=
 =?us-ascii?Q?CRIYuj7fM/kOhiAJ8/55fk7wX46KsWEc6DY735lCHH1PjNu8sGJQPKqgxPTr?=
 =?us-ascii?Q?nje5vmvMjW9jrKzCxSz+seMVWmoKdfafD+Xf0+12LGDaMGrMgNMJoomNvmuB?=
 =?us-ascii?Q?sPaz6Hmy26MRBk+sgK+BeQ5z4hL3t7NrrhqbYnODROmkhyFOniFDg1MHK2kV?=
 =?us-ascii?Q?m1fF3Nbz9KNwATufNIdFkMf/SkQSjaC9uNb/mbURTbpAj2DugeGaJJYvmtFW?=
 =?us-ascii?Q?dIkNTbfYvf7Cxvmmjke8Y5yJMIqsuzsNem5ieF4JyaL0rTj5c033jgtP8alf?=
 =?us-ascii?Q?CdUdtsd5g4+ZmRn07dRdOVDPP21zsWP0cGvua7z7/emndRq8AS7qNCBmhmrg?=
 =?us-ascii?Q?Xn+k2Zfby+/IFKVDjEKGyEgd4yYkmx3dCyQZV7TM5Klz/tNHJ0ynfSYyi7tw?=
 =?us-ascii?Q?o6N5QUdUYmCeFcrAsNWZYAJ37nHdPcF59BsrRJtMv0/gdsIZMmtqb2EkuQlS?=
 =?us-ascii?Q?C1xBuLvQfe1XmsHfAR9i8hNLImn09g+MYvl4C29VrplWZgnyAGqBL18Yu2jR?=
 =?us-ascii?Q?0v4JzffZUZHGsssMznYyJH18OGHnyOl+kk79ZRPd6OC9sGHhc5z/3G9lSBzB?=
 =?us-ascii?Q?mIcvXD72c8oDgqwN130/mgWVF5mNm+Yvy4muc495mNxOANykxa79EnN+JSv0?=
 =?us-ascii?Q?rrjOzw7Of38xrG/ca0rcGWg4n9mdqPmtedScuNCARvYaUv0p3Yx89gIPsps+?=
 =?us-ascii?Q?vrr84C16U3KURxTQkoHR8MCzESKfR86ExcWvtM554GBIVJs2tgHLnAKCSxV1?=
 =?us-ascii?Q?Wv3mmd8Z79LEN/hdNCJNmsSHX5pmfRcV4+bU7utk47DSBeeIR6MTFOZGe7Vk?=
 =?us-ascii?Q?DRSEnuN3h1SbbjwPSPhJ0NvgDtIvjes7O0GR2iCDjp0KB36TWGRaA+9Uehp/?=
 =?us-ascii?Q?Yl9IaoK3i3gkg+kb1cglvIDlTPxim6iu7tWSH0iFEdpHVI6dkZ6+RhT4WPEL?=
 =?us-ascii?Q?v2cgJLiTpwtJ5+l6iYE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a07cb0-1c62-4185-f0be-08dd203dc27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 14:59:38.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qZOnTseTwxjEjRH4xhZSly8ChQUdmdlz1rbia7r1cKBDKYTx+AvdD8iz0MLLvq7XpUgUDnD9ZPRgGQNMQpflQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Wednesday, December 18, 2024 6:26 PM
> Subject: [PATCH] drm/amdkfd: fixed page fault when enable MES shader debu=
gger
>
> Initialize the process context address before setting the shader debugger=
.

I think it would make sense to pull this into it's own function if it's dup=
licated at multiple places. Also, may need to add a check before amdgpu_mes=
_flush_shader_debugger as well? Seems like in that case it would be enough =
to just skip the call if gpu_addr is null.

Regards,
Teddy

> [  260.781212] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.781236] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
> [  260.781255] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A40
> [  260.781270] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: =
CPC
> (0x5)
> [  260.781284] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x0
> [  260.781296] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
> [  260.781308] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
> [  260.781320] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [  260.781332] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
> [  260.782017] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.782039] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
> [  260.782058] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A41
> [  260.782073] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: =
CPC
> (0x5)
> [  260.782087] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x1
> [  260.782098] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
> [  260.782110] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
> [  260.782122] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [  260.782137] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
> [  260.782155] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.782166] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 312dfa84f29f..a8abc3091801 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -350,10 +350,27 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)  {
>         uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd->spi_dbg_la=
unch_mode;
>         uint32_t flags =3D pdd->process->dbg_flags;
> +       struct amdgpu_device *adev =3D pdd->dev->adev;
> +       int r;
>
>         if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>                 return 0;
>
> +       if (!pdd->proc_ctx_cpu_ptr) {
> +                       r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
> +                               AMDGPU_MES_PROC_CTX_SIZE,
> +                               &pdd->proc_ctx_bo,
> +                               &pdd->proc_ctx_gpu_addr,
> +                               &pdd->proc_ctx_cpu_ptr,
> +                               false);
> +               if (r) {
> +                       dev_err(adev->dev,
> +                       "failed to allocate process context bo\n");
> +                       return r;
> +               }
> +               memset(pdd->proc_ctx_cpu_ptr, 0,
> AMDGPU_MES_PROC_CTX_SIZE);
> +       }
> +
>         return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd-
> >proc_ctx_gpu_addr, spi_dbg_cntl,
>                                                 pdd->watch_points, flags,=
 sq_trap_en);  }
> --
> 2.25.1
>

