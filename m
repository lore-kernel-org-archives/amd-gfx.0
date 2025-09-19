Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E2ACAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 06:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B1910E0E6;
	Fri, 19 Sep 2025 06:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hvRxj36L";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BBB10E0E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orh4Fimi1vTnCC9uxu/zIgVZHiCX7/oy7Sbpk1dqoQ4YygoaZwkfluJRNVY9pV+aD1jLOhyL/D4Rxp0927pg3M6n8EPX6Lr1Rb0QDYrbx+v27eHySKmgFhCBXbvumjBHjgRnDCsPhELzydrZY4XcERWt71wefkT60ZR554IsWo/gpoz2tzLOtsp9/eP05nig9FmLFItZe9d5a/x4ei3QjEzl7xyMWdBOzSH8bdU0siqQbQFkmF3vF+8k+FAJX5Bu4KoOZRh2hBSnCsw5ywtwAhbzaE1aKubfQZbJQ9l8CgnP0MPipz4JxeKJUDwvqx6lPFHYvaed/dzWtedrsOAkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sCQ1cDsamC+pryvbf4sRa2mIGygvrJN+1RlKYp85rA=;
 b=H1Jj9+7awops03tz+HKZ4JICqEA+U+jbIa6dd3UO14onibJPUZP9KwJXSy0uCXUV36uEe4J9k9sLHQK/M0eKvayU9wu+CmVSQlqs7tU2w0sVphTAGwSkQx3vezadrDBHgmha6sT+qzHB5l415SBpX29z4AqPTPk3TpVGjEr+AbO7elA1wBjSRXjBIxodsn/R0YBDaHrlDh0qPd3EbLMNi+UKnjmyw4GklkURcpPzRBIcj3KUtcWYq04oQkau5on7OBQTMv3tnk6vk1gOXci6jAjoD4Y5xw+9Nal0h6d76E8fxN4br7hZftJjeVbTUgavlIsRXHUvl7X5rkhonIjROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sCQ1cDsamC+pryvbf4sRa2mIGygvrJN+1RlKYp85rA=;
 b=hvRxj36LTI0ky0hrKZv/q80z4L0QKU9yv/X9xRx5Ezwm2NKjA8Z6bwpPcT3zaAXAHKTF10Ad1qex2liu/Dbb03NNW1rpB22z+6zB5LP6yv6wP993KwXZQIvlqV++vVLc4W/YtcZvWdT+3ZrqWt/rl+660AO+BuRTa6R2nba/I+Y=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:34:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:34:23 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiSeiqpxQUxRESwZv75k51pn7SaCvAAgAAAWWA=
Date: Fri, 19 Sep 2025 06:34:23 +0000
Message-ID: <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB9284:EE_
x-ms-office365-filtering-correlation-id: 84b5d832-9eb2-4a6d-4835-08ddf746926c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XPTy7/yQ+en5/vh65V9kvSrKOUqe27Obdc96uy462SEKnIXNnp6MyCHO8Mv1?=
 =?us-ascii?Q?3+dq31/FNsv+32KkzZY39mKFdLKn68Rzo6Rpsl0qm+OIsHz92RXn6Ogr/b5i?=
 =?us-ascii?Q?+jW6sEUA7MSjIg4NvAGwwOxfz/PQDfzL/P2vVs6LcdZutzGmUNMcK5j7It0E?=
 =?us-ascii?Q?vrE4msfWWgKYck6kchJkvozo/GrjMro1KQPcsZo1+P4TfcMjwI7IOerYnSek?=
 =?us-ascii?Q?vOQcsLEUCc/KDOInd9h+LFZbI0PkfJL+R35JQlfq1MVcp481jcdVJkyRX6nu?=
 =?us-ascii?Q?6KS9U6jo5K//kAkzLvAKXLJy1wAzpe3F96R1fRifsRKQ18AyUE53AymomF6Q?=
 =?us-ascii?Q?IGUYPD8hgiYzRqF6h4QxegfVslIC4NMCyS30bGA01Poupg2D6mGaF7eFiXaY?=
 =?us-ascii?Q?r8XKjQbe5qydh/Axb0WEX9axJI1xyo2UpIXF4Q3Aop9Ng1vQ7Ec/BoDNzoZK?=
 =?us-ascii?Q?P89/AFBA91SCPnSG67NJXlLFtVxFlyiuQe6JYk4CC9PtXvvRazDPOhYgP24T?=
 =?us-ascii?Q?ygIrkWzGnzHo4pOLVsbKRZqFkubLet3gcxH/XGgVS//hNQqgu6bWb+DTJO3R?=
 =?us-ascii?Q?bDPrFOTjSBJCJal8y+ATvZBGYr5zGcK5SN0bhTfw83+JMHLI65RxRY2X8LQr?=
 =?us-ascii?Q?KpovtK6AnHQyw3sKeWO1b3COD59hE9EZnFAmKQS+3abCv+vPXZ0554HwCwaI?=
 =?us-ascii?Q?skQt7IIWrDWnV6B2j+1MZnX+xRBDXVK/mkwp9UE7WoFbvau5FBqS6XtZFp/9?=
 =?us-ascii?Q?SXuyfnICzJe150+TpB27B6qLOhwxnQ9IC5c1mCvoo8ZiwW0EYvYdcmo281OE?=
 =?us-ascii?Q?EAH9h1tsdq0NWGEQMvC3uB9p1BlTGVqF5z9qWhoG0NxGD9HXbO8/Wldt50St?=
 =?us-ascii?Q?fr+c2owiaIlppb0vJJGT3OoZfRuj4YZVC3D1Wh4NoLOKb7u25v15FopDWJW8?=
 =?us-ascii?Q?XdRtWUJ1us8oRxPn7vtIdBOiX/mlpnu+EIRh/sweNzMKJy0hy7ixElL9Zbzg?=
 =?us-ascii?Q?0kWvlrOSKoIdBCGnbTDIePzI15/KRWpAQT6MfFLlQSHwpFPlZOA0O27HCB9B?=
 =?us-ascii?Q?n3Pk6ZMoPpTHsdPt/hJkFtoG3cedXjBhiyKKkrXJgCGkf0QD8Ws4+Fordq79?=
 =?us-ascii?Q?EeKHWuIxZ5pMSD/oTKpTw4jWXmUtOXVhDw1sXkdwIp7liNPf+mOhWWVlf7uo?=
 =?us-ascii?Q?VWuvKaCeqZJoS+N9wZrDTeNbdTHc6ARM23LBgTv603l+G/kSyaN3C/JwWIha?=
 =?us-ascii?Q?YF0mwWMQGs0M0XfaS0SLagsVG1U/zdL/9p27MYydB0m7R9DeC29V03R+4IPb?=
 =?us-ascii?Q?MfE+RawjzoisgkEzjJWe82wCzv4A4150Y74PIWLMt1hyWjlp1TDb8YbL9IgK?=
 =?us-ascii?Q?WZrvXZpYbYj8dUYpD8K+AlWl4bKbr10JdDTboUbW2Ae1Gn/LDbIkFTjI7PlS?=
 =?us-ascii?Q?f2THygtM6QJF12E5wfO8KiRSfk4Vvls0XKYjPpeb6qELS/Gwa4Px05nhxsRq?=
 =?us-ascii?Q?z95QPskXVA43Xx8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?34iY14FdJ5BKd3fuEE0xpE7gTWtJfX2qJRTkz9ylF7x5OvIQKalScU4k80pf?=
 =?us-ascii?Q?60NfM30HhQQuKHcZX00bWfXMFQtnYlUluMn7ExZUNpPgNRABbPUEYp6o23NC?=
 =?us-ascii?Q?Yeup4lzMcawRag1uZayaH0yCQww29QBp65zvg4iz35Xn1Bi4yrLAiTbWNKFJ?=
 =?us-ascii?Q?wVb+ae4DM7/jDf4tgzPA9lcdLLNl36gO2epREYebCXCGd6mRHNOToqe2eroY?=
 =?us-ascii?Q?Ww80SDF1hdzj1Fy7n+bRPkX0fIeY/iDsGk1QsjPotk0o3GZcwPq0EkqnzJC1?=
 =?us-ascii?Q?UPheReYACBKNNpEHVQYf5bWMVpIw647u0NgsObrZEgqHO9G4bccCT4v3qO2Z?=
 =?us-ascii?Q?MwbrnmnGtfWG4YmSgJFYjeFbHANur4lWxG3QAaNDv3Zob4KqKLH17IvfBox1?=
 =?us-ascii?Q?Xo/Etiuk1AcxQaoh0utvpwuT9kifqk+1sNu0zl1co8nm/dUcPjuQIJnicCyP?=
 =?us-ascii?Q?YNfJKvj1mhMh1qWw/HVmUCfkEki/GM6+oDUbQIQO1k+wALHA9BkXCLryoNTA?=
 =?us-ascii?Q?SOfmc7yMDox7p9TVEvmRA3HAKEuPYSOj8gYLyss4Tefp0QKbNot/8FlUqUhU?=
 =?us-ascii?Q?scXw8MYKGTYJxuy7TssdCOdSPc+WwG1EER2lX11UPLbv39/qxibI74P8FXmn?=
 =?us-ascii?Q?KiN6/4AAj9cDeVseS9jO02PIhehQjmG8yjOxwjjvgNJ9QpvONyNMSGOXJVRr?=
 =?us-ascii?Q?/LPixLKfXenJcNrhDClNtBOmYU2eDw+1CVVHb0qJl4Y/KnXwhx0ii5I9Zaym?=
 =?us-ascii?Q?I5d+pvR9jhkpWjBKQkA87rNa/f5NcMjNr3udyy1fXfU0QI5NmGuiH5I65FyI?=
 =?us-ascii?Q?xeI2+KfAazVulOJkbMl6TiXP9jvaeAWhaJkWJ6cBVdChnZ0tH4nZ94UvLdfL?=
 =?us-ascii?Q?2HNAjdff/vG83zaTQSx+ifFIx6qatzyfLedL9nlPUHfKGu0//ZGRNEctQBe+?=
 =?us-ascii?Q?OhAUFi6g5ZFR4lLngVH4ay+JSY2lR3oOVWbEbPQ2ahAEZH/KDNCbstaNo3iA?=
 =?us-ascii?Q?HBkjebH8nHXVW1OAE8iXviRGKkIuIAFCFeu+FtLEsp8/vZNPdrSd/SuSHJtp?=
 =?us-ascii?Q?/eptLw2V0t57QtowjahCMyiDD2aMxJLtGeksJw4sZZsLmJoEtSQxN0z0kuHQ?=
 =?us-ascii?Q?yOd1nnnsSQFb40IzBiARDYsp42MjM/vyqUKG2tmWJfaP7cKuAo5GX6ANH7Un?=
 =?us-ascii?Q?1V+DdtawbMV8lwO/Uv79PITMEAfJ6ytOlX8LjYNFWYn8/G4niMbPNrGg9m32?=
 =?us-ascii?Q?qzOc2OTQ6tGSzstoXTvR8QUkOX2Nf5g1QmQWrjZMiv0h5z2fEHTCm6UHVsCD?=
 =?us-ascii?Q?k9AeEXmqBr1s04dUtP0hpwg7G/HOET64fFMbKacgen+RLnnzeV7WRlb+6uUM?=
 =?us-ascii?Q?zcH0H2PDQUhyCrriu+UD+N5oKYNqKoD3WeOugcQgdefXUEEQLicgtTxD1+XN?=
 =?us-ascii?Q?0okypkgegj8lWSaCGhN+ge4Uzu42b97tsqk/4hfDfm/AEU2kfH8Jm/EOUc2Y?=
 =?us-ascii?Q?/wQUHrP4HZ5QhaNUCdx4B8wWpBKbZGWC1N2szbafOsQk+OJtvTgFWYQY3PM8?=
 =?us-ascii?Q?p0s6LQgYptnFzR/n/1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b5d832-9eb2-4a6d-4835-08ddf746926c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 06:34:23.2482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KT2F7afvjL9/YsfPKepVM+tDWV5tFIysBoFBOnhUkKlimSltSXXjwrUPyQnM3/Wz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

> Hiding this information seems unreasonable unless there is another strong=
 reason

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


