Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5431CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 06:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EB210E93A;
	Fri, 19 Sep 2025 06:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ku3tpS7V";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC42E10E93A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUGwuAiA6yXLHxYBDMrhJPlMh+8gqlkrB+YfWTZ/zdk3Di3cusnQSEvHWKlACa+k4FsIpcjvicWe/4oRx50/IhWLN9d8sRrkaHSROOynDNVToUrgW1VR0ofqmgKtlU17UMwLIJ4N7zOVR6Hl+I+BE3wg+9IEclK7s4F8/5fuwfMZFIvDgO9gYo8hxQXLPCp8NvM7SJCGFHwR8jnq9arvbXVFHugaJIIsBrGNAXmvulADBSzmEFlQy2aRoObO2fi2ycKpRALAcCLikj4LPpQikqA+JTCDaAv0nv/HcXTK1BSXxh086QqTb2/2WJRbdR2r+Zk4MtpVk7J1va4DRMASsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Iw1a2bP/l7iiDkGoB4Ryx/i0yoiKNVb6Bn0CplNy4=;
 b=VYQQc8UcqupK/BdCI3wZmDQOr8DoKud7emA16ltV1z632u0Xgfxkp8ygLdoPcGCZBdx/w4XUC5DpgYlWZSk55/tUQ8vwdnuHK5+5n5accnCqC0jCQqNGkRWxUU+BKq5OiRVbs8xSnk9FpiUODn27BAp86eEJtQNFHAvbFCuKBW9isnLk76Vsf+9XDUAKI3OqEkrLUkEcmvsXRpb81AO2GthQ84bp6Tyt8zsYCUlnFaaRJczP35yk5RAP9MkfqEvlCJ5c8vUxUHgiTTQf5TE1ZNV4fLbEb+8jG/yZzkbmn2DvV4U3pz2D/HPgWuQ5tue/n8GnN172hxrV9RoomWv2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8Iw1a2bP/l7iiDkGoB4Ryx/i0yoiKNVb6Bn0CplNy4=;
 b=Ku3tpS7VS3+cYW7BbhifUoz+sAoN/O1IV1ONLeIGPDW8qtjkBB1EZPnOnmENtrpbdYsifW0gW/uQ8Q5ip16gu41dQxVTR1pE7ZbxTKp0dhbM8tTCSgRr/hNw4KykuRyzqH6Eat7/uSW/TSO4657EdnyyMfs/NF+N6Y1VghqGPlI=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 06:54:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:54:18 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiSeiqpxQUxRESwZv75k51pn7SaCvAAgAAAWWCAAAQTgIAAAGTA
Date: Fri, 19 Sep 2025 06:54:18 +0000
Message-ID: <DS0PR12MB78042A130EEFE0D5FB33AD199711A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T06:30:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|MW4PR12MB8610:EE_
x-ms-office365-filtering-correlation-id: 4f50b261-e550-4a5f-ad1c-08ddf7495ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LQMtfbQoWA0IrZnlLy5X4/KDazNOrpSq3sgYZpVx9ZNRr/C3+V0W80sowmvg?=
 =?us-ascii?Q?VPTPpBWPP5txdpPAzJN24vlZHSPlmIqW5F1NJyINCLrYoUYhQPT6L5Ae5ud1?=
 =?us-ascii?Q?WVanamVGW60zTS2dqHDZyOW/rtqkDD17LuSJIv9Cxr2q24alI5pT++iKT4k6?=
 =?us-ascii?Q?AKJ1I8lubrmBmb1KQumDkPMpKE8jHr20lRbSbbIywkfjVW1vQhrK0aawZ++Y?=
 =?us-ascii?Q?q0hSkIOQBG6c70gAJH8sY8ivS/Kblqglz4pua94HhwGJtpenY6lmNd0DBZpm?=
 =?us-ascii?Q?f7ZcC7o5e7fUxZtB8MbwJ9cedSkWR0kz+Rt6xxpxcp/dbSIA4MzVr5cnREVJ?=
 =?us-ascii?Q?n8WfNT+9CXOsF73nZDNJKNEwNjAa4nX9f4ubB00WzTYY9XQ6y0B9bS9gv7Cw?=
 =?us-ascii?Q?gxicEEkYcYVWOOu6ZvXJSXy9Ef95CMp7HtmoYM4VIIPOxkPMJNWav4NF5Ueb?=
 =?us-ascii?Q?d5aqYck6menVya6PWCAkwCR3mhg3fnjs1XZLCeg8xjvVs+PLRhyQDTkD0D9e?=
 =?us-ascii?Q?5MMasRQ8sE4AlPgebJ054a1zbdanw8LTVvqwgFFnTrSWENHy0UkApesN1cxc?=
 =?us-ascii?Q?ye3ndXguVpToVQxHDasQRBTcwHn1KEgWlOJAZxg43ND6CytnkHaY3Jmc4OBC?=
 =?us-ascii?Q?Ng40TwQacyqBbsePAiJnqWjitx9udV+Ggdi/Dl9HCdnQZyCqVaI7r3DEBzsk?=
 =?us-ascii?Q?+yxDscRA/6ZWHWreFi/cdU6k7eUOq+LlktyLKz2mvcZtPrNDIaZZQc6o8/LL?=
 =?us-ascii?Q?uJWTchTNFYaAGS9QtIOdM12M5IIUjEjBrE80AkRZ2hNB4Pogv7t7ug9Q+L2e?=
 =?us-ascii?Q?7SDad4WZILuUVIVxaUlvHqiDkhb0Wl4W4FTZ5AMVRLLcMLSHlS7HLj6WpnHW?=
 =?us-ascii?Q?vnS/wNiFmd28J+xz2BQG/M8IJEpIADGOZ+7H16sM/ikY+xIgz5oPdV+al2ai?=
 =?us-ascii?Q?xvcMkS42VepeifdTXrlAuzW71XAW4MGH25zbsm3sTEjRmMjCnn+JgLdolHhs?=
 =?us-ascii?Q?G89VRPNRYeDc+gbGBwhan2guHo2iRRwnL4/5KKUNbkAS81zvQSvt1IpumS7X?=
 =?us-ascii?Q?/ICepReGsjndLJqcALxbIlfVapLPJ4wzB3y49nB8CpTDRfIX6+gintz5gE7G?=
 =?us-ascii?Q?QCpgubIejm9V5Km54xuHwnPi7gnNGWJcV02UV6zWey0ph5ZGm1DXlG3rd3X8?=
 =?us-ascii?Q?os193uG2qWYKadd1wJBlhaji3K6K+pIRLUl2YIWG8kYhXg8+UGY8XW7/g8QA?=
 =?us-ascii?Q?tNyeT0FZdwcq8qVzdfRFVMwp2mEnlYgxzhJ4pi8oGKDFOORnFLVj+0OaIpWg?=
 =?us-ascii?Q?Pj6OOk20kPIxdmWSwBTzP2RFNWIIz3UL6WJYvgT26W1+Y3QgqwDl6Gt3lauf?=
 =?us-ascii?Q?LJWZacmKjxbiry15eUFoURw4d+ILY0v3GZEoBCbv0KiI1UtArzeVekolkWI1?=
 =?us-ascii?Q?YU016qanZjZFC9MmO+oYg7rPO3n8gQfd6awnt6OYvJmKXKs47S+aVfMyNlL6?=
 =?us-ascii?Q?gqqPSljABVc8gIw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CNITY1RgJuaIzr0yhsHTrCVGtGkUZi8uFFmwvLfSAIxO2zKrMp5lYam9qOtz?=
 =?us-ascii?Q?KwtqZn2kRVwTtS+fitG5cLI3TJulc+uqDBPJVS88geIAbhsB1uxY4S0m7HRe?=
 =?us-ascii?Q?DRYcsaRm4nyxq4Y2t65Mu0u47jWaQ5gZMHnwblFKVzpmQCMUBdbV7uMqAZ1h?=
 =?us-ascii?Q?Rhn+9tuQcmy4ziUc+w8tIPrG+mZRgcxcfUEf3hbSiHCrjB/48ibwVvzBVBQU?=
 =?us-ascii?Q?jzJ2Xp7lRoZIT6bYyoK83Oyz9DnmyfP8h9KZzX7y1nlif82i0MTTNW+A0UyU?=
 =?us-ascii?Q?V+yE7SLKR83KWZiaAD3xerWoV7p3Ga6WIBIfm+eE+MSjLFtyJ/U46VkSn4k3?=
 =?us-ascii?Q?TWAFHZdCC/4kqR49jg8TCcU4HjWNzZS08E84bMvPWoKGR2Z7XHE/u8IIciCC?=
 =?us-ascii?Q?eoeVtV/jPv5Env+UmCkbAWTn62qf/pGXxwsQQOHoQFpKzBZTHGpbsSfsO8dH?=
 =?us-ascii?Q?o+3Y/cVa1BX7sbjP6hhRqXdGbqy/sHsSQudhEzbzKW3q4eBAal3Twn7WTADq?=
 =?us-ascii?Q?FYd7UR8ccW8SSvyCD9LXqdU3IuGq3ld4KxlgNH+WUld2aW2Zqnkf+71Fitso?=
 =?us-ascii?Q?GbmWAOBjxdyIyPGN9sKUPj1FV4E9hci316LkJC4MsOswTnR4u5+dW2MuogNy?=
 =?us-ascii?Q?e2MzWLeH2gX/qE6K1qSn1Ieh5MHDBujZMn4+1wj51uQvWmzq/iJA+Ox2MFjD?=
 =?us-ascii?Q?T4cJyPGTDS+Rxei8UvSqext2br2wDvef3Dz67V9vf+xtGDqIQP21LAVfwiR3?=
 =?us-ascii?Q?gN+MCS/AkTjIXeebn+cvzLmxICzVQ1cmC2Nm24r7bGOj4nL6REHJQ2nC32RD?=
 =?us-ascii?Q?Cf+E6o3WOy3tGXvKTN31QSB4EjqHboA+rfZzzNWylBlzxgyk0ACHdALBnuc7?=
 =?us-ascii?Q?SD6ZPdLpf3p9ZieAvxrZYhJF6Fna11l9g8eBjtQeEsENJby3Yv3C303pHMQc?=
 =?us-ascii?Q?s4NDHC/0cY1MUxD/GrczhbRCLaU7c7l8CIvqfFifrr9ATF8w3/DIg7Lc2GGO?=
 =?us-ascii?Q?9z5pkIkydOq3vZB2X/a1MMZOzJBW2/7R/dz4dsJ/s8XJ4l2X9E3hwVu4fRSp?=
 =?us-ascii?Q?VmKYeteqN7un8ZNtg6EwTsCa7DX/fnVuiq/9R4GsKrijor49YeFBlbPr56Rj?=
 =?us-ascii?Q?zLx9mM321Pd799Xm+X+9blZGYod5BNXmeQ0il28tVVAdjrdTUU6VmvbdC6e2?=
 =?us-ascii?Q?9PhU5ykuteWGfoyfE+ER8BWEHcNnm94OqcrUmxozM+Ba9H1DhjarNWg2eS/+?=
 =?us-ascii?Q?EFzeA0IX7dcJ4IzFr4EjNslUAJg3ERIC3lB614359oFQs4PwjnC2jH8909ox?=
 =?us-ascii?Q?7/5hMxRoqqDaPGZtHuIw8nK90UmaQXSJYKbN9srrnmmcW+HK5kRGV6KKptYr?=
 =?us-ascii?Q?qkNMEQ/S9yGtEcULX5lfMwO5zAW75x0fifmXDaJJ4+qM6KlclzFZdTlhKxmN?=
 =?us-ascii?Q?/Rgx+1p0UbXgd+xSBTvkA3okkqoXO1SErs2WsebkT5gBJwPMjQx3X9Z8gOgC?=
 =?us-ascii?Q?+TRjzesipvGSXGm/DeKKDdPQll3WhMK/yiKYYXYgvjgX4rD38kDOB6Daqvf0?=
 =?us-ascii?Q?dP7GiTYiuLlsTZDqk50=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f50b261-e550-4a5f-ad1c-08ddf7495ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 06:54:18.2764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlsSEshU1vD3+tWR45+qKeTH9kzxXapahYbUv5GRWiJ6JM4oX/TJDIes8zEJ4LXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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

First, it's not the developer who is using the system. Any mismatch informa=
tion in a dmesg log is always an alarm to the user who is not aware of the =
implementation details.

This mismatch is bound to happen when PMFW is not loaded along with the dri=
ver.  In such cases, the mechanism to ensure compatibility is only PMFW ver=
sion checks and hence some IP implementations follow the same. If there is =
an issue, the identification mechanism is the stack information which is th=
e driver version along with the all the firmware versions. The interface ve=
rsion is not the first thing that is checked; in fact, I don't remember che=
cking that at all. That is why this code is keeping the same interface vers=
ion for SMU v13.0.12 and SMU v13.0.6 and not getting noticed so far. So ins=
tead of sticking with it,  it is rather good to clean up such messages or d=
owngrade to debug (which is again useless because as mentioned earlier it's=
 not looked at all).

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 12:14 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

>> " is not used": Actually, this is used to display information to users a=
nd developers, not the driver itself.

This "driver_if_version" is used to show what driver if source file version=
 is using on current driver, this information is used to *developers* and *=
user* from dmesg.log, not driver *itself*.

>> This interface version is not used anywhere. Driver ensures backward com=
patibility by PMFW version checks and shows the exact PMFW version in dmesg=
 log. PMFW version is a more authentic way to identify any compatibility. S=
o having a mismatch statement in the log is only leading to confusion.

Pmfw/driver_if_version is the remote(pmfw) version, while driver_if_version=
 is the local (kmd) version, Because the driver allows for their existence =
without matching, more information is needed.

They should not be confused as they do not display the same type of informa=
tion.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 2:34 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

> Hiding this information seems unreasonable unless there is another
> strong reason

This interface version is not used anywhere. Driver ensures backward compat=
ibility by PMFW version checks and shows the exact PMFW version in dmesg lo=
g. PMFW version is a more authentic way to identify any compatibility. So h=
aving a mismatch statement in the log is only leading to confusion.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 11:59 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[AMD Official Use Only - AMD Internal Distribution Only]

>> PMFW interface version is not used by some IP implementations like SMU v=
13.0.6/12, instead rely on PMFW version checks. Avoid the log if interface =
version is not used.

" is not used": Actually, this is used to display information to users and =
developers, not the driver itself.

Smu 'driver_if_version': it is used to show driver source file interface ve=
rsion on kernel driver side.
Smu 'If_version': it is returned from pmfw side, that means what driver if =
version is using on pmfw side.

The most perfect aesthetic situation is using same if version between drive=
r and pmfw side, but it can still work normally even if it is not matched. =
(with limited functionality)

According to the SMU driver design, KMD will not reject interface version m=
ismatches to ensure smooth driver loading.
Preserving this information helps the driver understand the KMD/PMFW operat=
ing environment and detect problems early.
Hiding this information seems unreasonable unless there is another strong r=
eason.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

PMFW interface version is not used by some IP implementations like SMU v13.=
0.6/12, instead rely on PMFW version checks. Avoid the log if interface ver=
sion is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (if_version !=3D smu->smc_driver_if_version) {
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version, diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=
=3D IP_VERSION(13, 0, 12)) ?
                smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_ma=
p;
        smu->table_map =3D smu_v13_0_6_table_map;
-       smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_driver_if_version =3D SMU_IGNORE_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        smu_v13_0_6_set_temp_funcs(smu); diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
        do {                                                             \
                typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
--
2.49.0




