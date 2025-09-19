Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9784CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 07:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313A510E944;
	Fri, 19 Sep 2025 07:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bf9pRF9M";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD9910E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 07:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siKmqB/+keqGpmUDr7WD7UrTGYUuztMCgArUV0Uhqyk6wfKIHLJdkJnQ3G7efUVp7lM/2CHTCQwly5v7/l5gVtDycEVyfruttpjoUSVKcCMyiSHx4trA1jEzfta+eq92HHvYGWS5H2+Uev8qCXfuwBVGOh1HGsJiNXh2XoyhJEAmuv938NuAVBSq/bxnb5Q2JEf/UHFpq+HNV4jU4PAizOXkVqJ5OrNGo19D2V+AnDv657QBtBFIrIKH/4g9HmuoXONKDjCzU77HLPbniIBRsZm88jSI7c1vBPIIORaF8J+hyCljG/zMs0+2fL7dXHqW/6CeFfHalobpwhCAntQ9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wIAeTidRyK6wyvzssti7yx6yt2LQ8N2x6wsbdO6yL8=;
 b=cz+ySACR8RNv/pNxZ01GP9crYwhPJt6bftKgTsy/UODs9BX4+PiSxLdSbBia4xDQqbIxIVojR4+13HKK3aCgyhxf5GuA2CcuCH8a1qY7KPDGkNSC9seq4QqEn71KWX/8WnxFltG5ThPdgxOw+1d9VxE4E2SA2eO61W3CdfEdZDl9kClkRYh+vgqsQ5goZh/b6XdFs70JQatNpbkO/XxFj2s+Oa0yfTDg7QGxtM9fZ7uqfReUki7RWk5W/RJTZN5dIQbFsi3pMNOBpBmQpePHPZUGAh+tY0vnBryR8uRr7G/y1y5vFjSqBeHSHh+Sklw8A97Mo/dS/60ZKwVtSsB6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wIAeTidRyK6wyvzssti7yx6yt2LQ8N2x6wsbdO6yL8=;
 b=Bf9pRF9MnhAnx25M4mtUC7pGWJQ6sZgKN6kjDrxV79cJMoAQmHP51nQHdWmeyUsBgSIZf/Rd9y1ht2WjIhnEdAWXu/m1+3idHSSAQpcKNuVDDh9LvM5UuYyNcnS98RVEAoyg2z+mwYjJNm5m1nMravOaqNvVp0gegzVlXFOX+Zo=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Fri, 19 Sep 2025 07:37:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:37:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiSeiqpxQUxRESwZv75k51pn7SaCvAAgAAAWWCAAAQTgIAAAGTAgAAGdICAAAY6AIAAATpA
Date: Fri, 19 Sep 2025 07:37:04 +0000
Message-ID: <DS0PR12MB78043B5CEA0E00DFD97A4FF89711A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB78042A130EEFE0D5FB33AD199711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS7PR12MB6071E44F8B9DE838DEAD5BB68E11A@DS7PR12MB6071.namprd12.prod.outlook.com>
 <PH7PR12MB5997EBFCB6E732B9A5B164338211A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997EBFCB6E732B9A5B164338211A@PH7PR12MB5997.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 4f550be7-c9e2-4341-f74b-08ddf74f5448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ag2QjiAegyXFHin2EEEW84Ekqtul18bXpNDvH49+RQktpGP+vdz1HGOeuY/+?=
 =?us-ascii?Q?6t78T9oG/RoLCEhQ/1osDHIP68jUXya94EVhhPOBHQ2xqKYJbpBIlvpx8quq?=
 =?us-ascii?Q?0slBMi9SobHUeB9tjcMNuT+PBvBgUpTs0Wqxcx3FWZ2098rwM/9hrT01INHv?=
 =?us-ascii?Q?DhayRSEoDAWhaHeN5QS9UQyjIGKbBPFCS2p73eqXnZFJlyINEY7LxMlv8zDq?=
 =?us-ascii?Q?nrqL2kkaeilQGrx7PwUsRNlUvcKYoHAiqO6kL+zWt1RY/r2N2EbgR9YxSYNO?=
 =?us-ascii?Q?M/J11dj2ORYc8+K+VTcXJZ8yUG56wpV0A+o/Xjog2LSyIJoFRpYMtMkQtQcF?=
 =?us-ascii?Q?i+1LxR8qtp8ZzuvFkOOyPPF32tpay/KfnRCQgmuBkbX08QwPAJCTyuVL6ZcD?=
 =?us-ascii?Q?L4h3OCqNL4/BuLX15fQyzZXo4hS+qgt3ktgfQCo/QcE6J4xdaLIdmSdSGulj?=
 =?us-ascii?Q?qwzxK7GzdiE+kllgEGQaEPOJ1W7Xse8Fre0OAaY7v9JnJaR98573UWp8R3vL?=
 =?us-ascii?Q?BgOzjn+lOGwPzIGzd9g2q+ZCi2fthGZV+sl9jYzZAtdsF3sVc9R66RFD5L9k?=
 =?us-ascii?Q?BuTrj0UKmqYeg3MplGSDCJqyfbKQ+hlb6q0J8ky6jBaJ++GVLcua2jIzWJEX?=
 =?us-ascii?Q?ho9W4oZqgNWWZzo1n4JH3TtoJgoowLb+s/PJbvfsl8L3y38/AxgcYAvkiIqx?=
 =?us-ascii?Q?vwN2s5qahE8tXMzsdShD75Chs7pai+rQgkISRkNZseqoJ1121QINMzcEJUig?=
 =?us-ascii?Q?sWj5xGhCdqwApuZUCgC1umI4zeiSZyQO/YEVWJWP0b9tbn4dyPTZA5GFtYLL?=
 =?us-ascii?Q?mm/cUd9+DBUkULLLJoo8DWoeLyaQmnLT2pYIEmPCNJDTK5zjVCUNPlxUx8O/?=
 =?us-ascii?Q?5YRNaNNMA6j8aPoYPXx5RI2VZprBBuLKc0QhzTGZh+kJ00wjVNBJ99frBOIc?=
 =?us-ascii?Q?LhVohM0cpuTBOeP1z01Fn4+IYCQY2y8A6GCDk8nvkpo6FzS10STyFq9eunPP?=
 =?us-ascii?Q?wSg8O/a2xMhDnbRKOI9pC9CqWay4mn+KoLLXTpExKafB5S0ufilbT1hhvBn/?=
 =?us-ascii?Q?XzzX3Lua3e0Jg2vzd3kZMzgjNyDdqj/yhjLbRO55vdHClpKAJHbTK4L1Ls6F?=
 =?us-ascii?Q?i12UV/rqiopabnWg2t7t9c66zmnPUhB6h3OdyOHQXdGNdPXcpHMkUPcYNrtg?=
 =?us-ascii?Q?8/wEWwNGoleiTIlLIr61haWsHKN1D72ui3bycSKjMGa//+BGzkh30qQhxLbz?=
 =?us-ascii?Q?xDCA7y23t5vEn8NuuvBZfoygp5Jl7qpGtstZ2H2UXAVwx+pLpL++itKgc91Q?=
 =?us-ascii?Q?U359AAqSmpblbcAJPKMQNuV1LrMYL4j3j0Kh8up7pFF7zR0EzYIP7czjd/6b?=
 =?us-ascii?Q?DU4zJqacD6pUiZcv/kt+xzZJ7lA1EWeC3AlfToafYHpeWeNJ3SqFJZPveCte?=
 =?us-ascii?Q?Nnhty60Yxk++T2pP+/aQr9/gvyMo5qh+bYDzqu6VXR+/FY1ypmABLg9tQX41?=
 =?us-ascii?Q?xTceQmhR0Ft1svw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OoBlEIU+Dwy54/f4ObieOfInrAE2Kp+eTuOe+3C0XO9OFZyplw+dbvwGa+vV?=
 =?us-ascii?Q?wJ6XJ2oJgrTthr/sUuhpw7ZKQXJdQne+p1f+ZCtiu7X5zTVk7b6OtNSZvC0g?=
 =?us-ascii?Q?05eDtlBXvv1jabPPdlAxKySs8Skdgszc9WvhowAtdtWqHcbr33ZZFdtKuh6R?=
 =?us-ascii?Q?sWczFU5SGB8TlbowPo1k7H2BnhsrSqKXAZVxzyyFzs/Vmn9gfTyX9U0/e0kh?=
 =?us-ascii?Q?Tl/hQwvbI2t06QrrH0+WFKNDTwlpmoSkSPPUAPG07s/ZoX1W3hA4CVTXdtv2?=
 =?us-ascii?Q?zCQFSJRRO87ySRptRLlEnkzejlrz4VbH4EQQy8StMVry30OIIh/rl94zCHfP?=
 =?us-ascii?Q?ewIINTVyHii29fNrATpJu87OQ7fhm91xFuFksr2wD/ydQbgy4QKmU00bLWr5?=
 =?us-ascii?Q?vyvnn3k1Lijp8PO2lH0y7CmHHY69yeTqItcHJhZzPNEb0xQiBuSYjbREEtqP?=
 =?us-ascii?Q?STHgIRy6uoQY4e6tMvl3+UlSspr6dWFU4MAdrN6+mk8kwPgGgRBKtMsJZh3k?=
 =?us-ascii?Q?ndkkNAz9yZZAzHTRiWNT+LKACWkbdEFwdH/HUU8/q7jhZAv0jqkp1CeL+pDU?=
 =?us-ascii?Q?UENyte03eppkSLQLcXgUNmwOiAFGx6MOBy35rHgPPtSNnuvc4cMUc14Fyi7f?=
 =?us-ascii?Q?5Ja8oZU10xvpI0FchB0t0IgZ+d9x6Yj7qtiIykpZNAE/gicOLo+jPwDOykNE?=
 =?us-ascii?Q?jCBh8oGEsQrA2ivMb2BY3SLzCuOvkgmmTIXQvmHi3MyPW3Nq+GK1JCcpnJkg?=
 =?us-ascii?Q?loCnewN7TDR5v/FRSukVGEMEDHTc0gY3NNYzHa6juo0Gv17B0DbtrvZKvVzD?=
 =?us-ascii?Q?8ww1uiDMe1jqrk2qANuIm8XzUu3SPf/uWFTGTewPDmgYgHXGyilfcBBrDxES?=
 =?us-ascii?Q?MwgWpHx3doQvueVuyEZMDvCdNAdEQNoPY/uGZC8+KA1aJm/Lko0DVVlmvwB8?=
 =?us-ascii?Q?YtG+oW0fQuvPXXcaLD8nCGpc68/3JXI0m7bz8bidG1xxz2bMsGwYYLUOLTYh?=
 =?us-ascii?Q?YBymRB4h/eGU/K6rRKJD7GCWzA+v2XewUlzG5PRNqjy3AIwcA8lRwSJBCGAc?=
 =?us-ascii?Q?9FBW9caA6m3S4cTsAoR35zCcnRrHsMHZx840iwGbhrD+ExLhm90TNGny5O0L?=
 =?us-ascii?Q?knoOEC0/MYu57zW+P/Noa1cxN3KfVKyyNu6Jv7uPuMB2OcFsuXXOVHMaC4OX?=
 =?us-ascii?Q?SRpmgmEoSt3yAfGQvgex9Eomkm2sqobUyaNTaZgUmXWH/27GmANZs3G0xyjB?=
 =?us-ascii?Q?WDbuRvcXQDzL1RBlxPTrAMapgF6L+ThStkpEh8NmAI+PvmeM3D7DH3wLp8FW?=
 =?us-ascii?Q?9oTVsiKCniW/xSzJbNTP4KWHiqStvm7iA6jnDQFDH+wLcrXV/hDF6YQTMmR9?=
 =?us-ascii?Q?42jsa1+N7M32ytNq97VCPlN+rd3Lr8PqjguQK98RC+EZcar+IXCkWrIWM8fW?=
 =?us-ascii?Q?cbHrSJIYdbrdfZT9mjaiTxduqg3l8et/3YtanJ7mEbXoi4kZqUwW3zi0d3P5?=
 =?us-ascii?Q?Vw1exphWCp8T6OLNRlh3yM3Z6FMn/uyRkw+UC/KgMbQmQ7FsfwKkrNcS3QnC?=
 =?us-ascii?Q?TUOD5od4Q0EP4R04+08=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f550be7-c9e2-4341-f74b-08ddf74f5448
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:37:04.4865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy8d7G8NTVsK4HAneDIewdm2yd0Dt+GPcJ3fdlSfAf/X69tWS9WN0GexyBbxD2xo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

> This information was originally intended for developer use and problem id=
entification; this change was made specifically for 13.0.6/13.0.12 but did =
not provide any benefit.

The mismatch messaging is there across smu11/12/14. This change suppresses =
the message only for SMU v13.0.6/SMU v13.0.14/SMU v13.0.12.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 1:01 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd=
-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

>> The message is really confusing during debug, and I remember getting stu=
ck with pmfw team , to explain them its not error just a message. As Lijo p=
ointed out we have not updated interface version for 13.0.6 and 13.0.12 fro=
m long time because we are not using it. I only use this message to check p=
mfw version which is anyways available in sysfs interface.

This information was originally intended for developer use and problem iden=
tification; this change was made specifically for 13.0.6/13.0.12 but did no=
t provide any benefit.

Best Regards,
Kevin

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, September 19, 2025 3:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

The message is really confusing during debug, and I remember getting stuck =
with pmfw team , to explain them its not error just a message. As Lijo poin=
ted out we have not updated interface version for 13.0.6 and 13.0.12 from l=
ong time because we are not using it. I only use this message to check pmfw=
 version which is anyways available in sysfs interface.

So, from my side

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 12:24 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

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







