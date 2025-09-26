Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8822CAC5B9
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 10:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F9810E346;
	Fri, 26 Sep 2025 10:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0RxpZ//M";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A5B10E346
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 10:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7oa9vbNpxIczinVuIDTemsnUeYyy5x8H5yAI+k5AzSCd/AWxkn4FFcErAs+IfzfOcccRvvwZqt9/IkJIGYZjmlVRv7Bzmimx4HiRWu4Z1ZlfMbuFXAk2D8R2dcDVTwtx17jlR9Dy15WOkjlNaW27/uQi51Oa8NI1MwwN4zQFwjZjfiOTeVV3PlK2V2DrVbW5ucxbh4pFMDhZmc+Eapq8mX+4iyh08FnlYihyCYI7nUVohw80p3D8QkeyCtcOXV41nIwIVFiIAdNHB1AlyGdyw3Em15IGKxsVslmEJOGtJUUR9Ntp9PYmwvUK8pzMDhXvBp4hOycBHm08q+yfUf+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCaFugK+T9zmRV9JiEtzanYVYKMIzq1Z9xTxmLX68pQ=;
 b=TqKeawZaW2S2VHiRkBlExc5NX4e8kepbDs7+HeVF5d0V4eRXYkg3zzjJp7RU7W6DbnvOrBpmJgbxK0TwJw4QDw3WB5iAMFPRO7OU9rBxFG53ldgq+10wtBNb52cNlG/bncJ0QudJrMUVLHQgtduGlhlsdDGm1aZ9yC1yODZm2xL+HmsNBVRuyGytNYsB5JA8PqNdtnuciw9k1f81tABi4FsQ3QPs0SV5QGnMP369mbbPeC2VEl8IDhZ/DPeDtkJkuuaaFtiNsQsbMdzfSgwzcevtXXrq7UtZ46tauaOkXXEoxVbs37dLaeS/3A0QpXlinhHRxCHUFFY5p8sQPAYMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCaFugK+T9zmRV9JiEtzanYVYKMIzq1Z9xTxmLX68pQ=;
 b=0RxpZ//MPYfQScP5Zcs7C26JWYRS7seALiXdWFOrhNLH/hDjZA2vdg+GafggggyRKGv/NO3JPupju5SW+GDug3UjismFvqXFHfqWI67yz9zbbilDuBba2PinZmU/mFHO+ASbXtrNaFntTf4f/dqHxq2zwey5EOZJbYHyI6sN578=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:31:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 10:31:45 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Topic: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Index: AQHcLq/CnRqszrely0C0m9n0ee75DbSlBt9wgAAL3QCAABzd/IAABxqAgAAM3gU=
Date: Fri, 26 Sep 2025 10:31:45 +0000
Message-ID: <DS0PR12MB7804E9B50AA94EAB4B391992971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250926063345.1131635-1-kevinyang.wang@amd.com>
 <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB5997351862909E500BF2DB7F821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780416F186166F39E61F39DD971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB59974E8FB258A40D171BF4D2821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59974E8FB258A40D171BF4D2821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T06:52:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: 4702e6d7-2e2c-487c-8517-08ddfce7e44c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VHsiQizjfEfeoas5LkpVeBG6UcSZWKnY2ZwTHrGVnzFYaoILR98/gjWPNMci?=
 =?us-ascii?Q?Kw3GhbIYh1GvW0X4SWIoMIUhKNffgPT331oCm46h9NSGx0I5xMM2J9vzxCjR?=
 =?us-ascii?Q?CPDXszcwaJ5CbVp0q31LyFZxaoo0vHMgrQ4SBBft44fcoYUPsnkbidLTv3zf?=
 =?us-ascii?Q?XJ+PlpOT/jPF0HXBnUCVx97rqM0HqW8MwZfQ60lwPUiyDvCYWVJhZ6CrhQHp?=
 =?us-ascii?Q?zQjhOOhECJZbixY2hfkP2B3Bd01cZhKaPJp0qrDLUNW2p7vFrLRC1ueI4gDO?=
 =?us-ascii?Q?J7AmvJluo594Mql95szRbhxbp9uG/PFg5PVJTIrOZbMPExUvWmnQh6zGAuYn?=
 =?us-ascii?Q?nvXnm6vfhUZfRbPrdi03M0JvDBtYS7AKABi7M4C2zpfM9z8Ahu8B3iNdIowG?=
 =?us-ascii?Q?XmpCmfzamb2g2wnCT/xt2yhwoNkapEAVd+7bQLTWeEGbzcktbITeH7PLCcZj?=
 =?us-ascii?Q?+aXzxq7rghxAtQ39MrZXckwBAOl0tnm2LbVc4/UL++pZ26wXp2KY9P26Gxn7?=
 =?us-ascii?Q?iCdYdKySXR8i2PVgHUZqviSfAy2fzBJNH9cwndsl6Qy82pF9/RbgPTDDSEgx?=
 =?us-ascii?Q?0p0vFwii771usFtHiiHmD6G6/KTtUCD741MurJELV6PdcrBpNk1ON4DLfeUi?=
 =?us-ascii?Q?SvV7CLW0P5RKC+bYY3qIewE1tKjRsNWSQBTJoVMlFAmPcqb0rit56ztK4260?=
 =?us-ascii?Q?UatxUPQjyocJcjqKgUloaStZlZr4vfpRDRrm0QKC+3794EdvDCSRtPplJmKV?=
 =?us-ascii?Q?FvmKpwkDPaGaOqiQZjKS1Kxw5/ySsrplYjjveb5k7I4j8b3LZT6X03ESXyoy?=
 =?us-ascii?Q?Z6tqqZXQR3B591seMzpRBSED5R4kebHvB8Lq3RtgBfpFP/KHPgPgfOmppqje?=
 =?us-ascii?Q?6igjD0Ed0do+QEAapMO3q9nMAfSjif4Nj5yPvYZ/nomwsBFNFQczONcnfBwx?=
 =?us-ascii?Q?IjE7D1Ym/FcMxr02K9mWXVa+A7hyCIVbMMAva3jlESd0BaSa4UIoAOm1Uciu?=
 =?us-ascii?Q?BBPtYGJhxVMu4Hc+TA4HKqHz9CfQl7e6g/JkBsU3/zcaxJ+Q+GhItatlz89q?=
 =?us-ascii?Q?dmZ8VargEcCjxehY8dLKuR2OO7VgA3Wu2Kcnf6nPiEfLxVKAbA76aD5XDbFF?=
 =?us-ascii?Q?bFh9LVHvjsTY49FDCVGJGtgAbU7lkerWCRGhBRp1JTzcf67bCtR85G5HPulw?=
 =?us-ascii?Q?EOyUjmYZenUuqb35ZbI/ZWOZ4R5YbryLOcle5Mlkim/0OHKJHbeRLKyam0TE?=
 =?us-ascii?Q?C7+LLCPgYupdiAkubFlRqU/7hh3pjjaqsE9/t/VWfvG1mJqirou0R6iHxJon?=
 =?us-ascii?Q?5nbGRiZL9GMJ+nNi6Cbe8m8dnLCJZzE7LDwGrX2edKZR52lzocgJ8bCSvwN4?=
 =?us-ascii?Q?ilBTklU5eTH2K60iYQKu7P1cFDzhBLvVHlCUxiRtMiOsyB62WDMi9oxMydoh?=
 =?us-ascii?Q?r8/gyoXMyh/ZRYCNhFqsKIhxUnnqCx3bXp2Eg7Eib7RB0LViajpbT662R/EP?=
 =?us-ascii?Q?CT1RtO68UKYyNbfOcfDkxsewYLJhdWjN+IMN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kgVXTWHVk2DH+tHyQ7IgHobBfao4UkGH9YtSHlSexBsWk/8OWE5TcUhfVI24?=
 =?us-ascii?Q?UJn+M7Xe4jIfaXpT7KEeXL9jpUrR2kKnog1SgUyNJmk74wfJ0PeNAU95DmJ1?=
 =?us-ascii?Q?fQI6ryo7LDYlbk26fTgOQQ9GldhTwDfH/WKrqC6VsYoKAitrl6Wh4L+8YphG?=
 =?us-ascii?Q?uSaaR+cfm8gKpDt1IXRUlP0Ksyck0SBbdcCasrerz/LEW9rbrpPVXE6wUkwI?=
 =?us-ascii?Q?b4NkVUohsn1YdKt/LurM2qe4h1tPlANdh0frU4ih1d9hYBBQkEPTtIvUkdsX?=
 =?us-ascii?Q?khmfCthSWtlWtt3EswagOA5+nmdmZlYNTgDpcvee9zs1NkLsQIrQ+nz3HZzh?=
 =?us-ascii?Q?0gQF43zc52NQtyb7rlOsrWlkfTlrtLgGttiNL5HvRZMF1R4Tnj2MQf/1iL+4?=
 =?us-ascii?Q?SS/cNvaq0Hzih0pRHnZu4wyCTW71eSB2rHEiX6P09jDnm5mYotwejI6dMgz2?=
 =?us-ascii?Q?OcRDSM9iOWBlxv2b/d8pxvb12FnRsJ+fXQiH/yRN5idkUQlCltNBE9zO3Gig?=
 =?us-ascii?Q?KYw7UicYy1wJIlKSYrEAAngqdt/N3/hDYfM+8S8/jreyDlQ8S7ISXyJd5+R9?=
 =?us-ascii?Q?E7smUz33CTk+tsrbx58umGKF7qXn1YN2mBfF7yeIV4xZb511jvtiCE/r4WXs?=
 =?us-ascii?Q?+HTnWq3FwbSKxDJiHEv3j88araZUPb0OY48UiJSSrdRQpfIEUTZF9s6CND8i?=
 =?us-ascii?Q?zyW/IAovnAIULShu/EqLe8P0gGVuNpR5g6kTWsp1V32aUi3wFtAlAUbA3Tno?=
 =?us-ascii?Q?d7WS0296o/ALvFDXAstwFcCfHtN+pPmvU3bd08D0rEqVa6K+BzMwB7b8tjmk?=
 =?us-ascii?Q?3HIEN/WXhanxcK6lJrxVqGbn/Ffi1WDjg28VQmWu2momfM1HmM8ZKFHQqUbw?=
 =?us-ascii?Q?pwMi+IndAhmwHrq+Y29O8xMWVuMd9TinnRWN3JNgCMhV1NpL9AgPlJYcfwSm?=
 =?us-ascii?Q?kv6OyG6/b7a3BmJMUp6p+oXwBroS3nAD0GkVl68wTwlVrm5Z3TnkyyfErdhJ?=
 =?us-ascii?Q?5w89D24noEhv1YZTUfciVkkS4eaKaj2cjPt7wxH6BlD3IejdnQW8OGXXx1NT?=
 =?us-ascii?Q?Qzye3MWxnXmOFZa9ud7Fh+Z/SHW7t+Fqt+FOJPO9zyyCVdA0W5b2awfi6fJC?=
 =?us-ascii?Q?Xm6AU1UJkdKzCWIm01nsdD/QVv5QtNog87jQVqp8oY7O4s9pDTaqgTCkYe5n?=
 =?us-ascii?Q?xGS9iiAcWM4KuSjgITWoKvZpuR1pk2qKTCsoD5FUmIRZOLnKhVH5qt3mA6Cb?=
 =?us-ascii?Q?gxF2u4lNOJb6qTO726IyIARFryFEQY58aJXJP4zuNws812nYDkZkugOeXhRr?=
 =?us-ascii?Q?6rnoRkgg23pvQBJFpMY/dlOZ2It7EudeCOmxUJ7XUPlIoIQxNJnrhrRjCgIk?=
 =?us-ascii?Q?u3JUur1tqWJ2bDFPeBYbrQIQCbyLlsw1D9mCfo5wCk3uoABppbHVe8hcmLcT?=
 =?us-ascii?Q?EAuTWKdauRuyOgbAtzqxavZw74tUuZ+IyeTtC0Bw6o+xtfAXzJfT0wglO02f?=
 =?us-ascii?Q?C5UepMZpp3ZIfYHXj0occUMU0t2bJiyS914EOBzelxyXVe391jlMwug2cC7h?=
 =?us-ascii?Q?h2QKFgBQSs7XvJItVaPed9WOdiKV6CTfluD9N0vZ?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB7804E9B50AA94EAB4B391992971EADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4702e6d7-2e2c-487c-8517-08ddfce7e44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 10:31:45.3652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iarFryK7iUNFpzDFX8QnjP8RmefeWzvSZvi7XxhU7YcFKq6/lvPM4tFEoYr1Dcyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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

--_000_DS0PR12MB7804E9B50AA94EAB4B391992971EADS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

From what I understand, all KFD events will also eventually be moved to drm=
 node based uevents. Also, these events are pre/post reset ones, not when t=
he device is in reset state.

Thanks,
Lijo
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 26, 2025 3:13:39 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent


[Public]


>> I guess the primary reason to have drm_ event and amdgpu having that is =
because all the 'users' interested in GPU events come through drm interface=
.



in fact, that such devices like drm render/kfd/i2c controller/hwmon/device =
nodes are attached to pci devices may not respond if device in reset state.
so, this is useful event for user mode application.



and please conduct some research before making any comments to avoid wastin=
g review resources.

KERNEL[11438.593689] remove   /devices/virtual/kfd/kfd (kfd)
KERNEL[11438.593757] remove   /class/kfd (class)
KERNEL[11438.614767] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13/i2c-dev/i2c-13 (i2c-=
dev)

KERNEL[11438.615100] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13 (i2c)

KERNEL[11438.615624] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3 (drm)

KERNEL[11438.615951] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-HDMI-A-1 (drm)

KERNEL[11438.617227] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-Writeback-1 (drm)

KERNEL[11438.618336] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1 (drm)

KERNEL[11438.618429] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/renderD128 (drm)

KERNEL[11438.622178] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/hwmon/hwmon0 (hwmon)

KERNEL[11438.784296] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-10/i2c-dev/i2c-10 (i2c-dev)

KERNEL[11438.784346] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-10 (i2c)
KERNEL[11438.784386] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-9/i2c-dev/i2c-9 (i2c-dev)

KERNEL[11438.784417] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-9 (i2c)
KERNEL[11438.784508] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-8/i2c-dev/i2c-8 (i2c-dev)

KERNEL[11438.784540] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-8 (i2c)
KERNEL[11438.784634] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-7/i2c-dev/i2c-7 (i2c-dev)

KERNEL[11438.784664] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-7 (i2c)
KERNEL[11438.784803] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-6/i2c-dev/i2c-6 (i2c-dev)

KERNEL[11438.784934] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-6 (i2c)
KERNEL[11438.785151] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-5/i2c-dev/i2c-5 (i2c-dev)

KERNEL[11438.785335] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-5 (i2c)



Best Regards,

Kevin



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 26, 2025 17:22
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent



[Public]



The intention is to notify users of the device about the event.



I guess the primary reason to have drm_ event and amdgpu having that is bec=
ause all the 'users' interested in GPU events come through drm interface.



Thanks,

Lijo

________________________________

From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Friday, September 26, 2025 1:04:56 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent



[Public]

KERNEL[173.150476] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0/drm/card1 (drm)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0/drm/card1
SUBSYSTEM=3Ddrm
WEDGED=3Dnone
DEVNAME=3D/dev/dri/card1
DEVTYPE=3Ddrm_minor
SEQNUM=3D6237
MAJOR=3D226
MINOR=3D1

a "drm_dev_wedget_event()" uevent example above.

You shouldn't discuss these together; they are two separate events occurrin=
g on different type devices (pci device and drm device).
software-defined devices and physical devices don't have a strict one-to-on=
e mapping,
and the device initiating the reset and the device that need to reset are d=
ifferent on an XGMI system.
so, all independent PCI devices in same XGMI link need to independently rep=
ort events.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, September 26, 2025 14:55
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

[Public]

Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Yang Wang
Sent: Friday, September 26, 2025 12:04 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

Use the uevent mechanism to expose the GPU reset state, so that the system =
tool can more accurately monitor the device reset status.

example:
$ sudo cat /sys/kernel/debug/dri/<minor>/amdgpu_gpu_recover

KERNEL[172.053149] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D1
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6235

KERNEL[173.137681] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D0
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6236

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 2a0df4cabb99..73c946d9cbe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_inf=
o,
                           uint64_t uid);  uint64_t amdgpu_device_get_uid(s=
truct amdgpu_uid *uid_info,
                               enum amdgpu_uid_type type, uint8_t inst);
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a77000c2e0bb..300cc22dad91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,

 retry: /* Rest of adevs pre asic reset from XGMI hive. */
        list_for_each_entry(tmp_adev, device_list, reset_list) {
+               amdgpu_device_uevent_reset(tmp_adev, false);
                r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context)=
;
                /*TODO Should we stop ?*/
                if (r) {
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,
                 * in before drm_sched_start.
                 */
                amdgpu_device_stop_pending_resets(tmp_adev);
+
+               amdgpu_device_uevent_reset(tmp_adev, true);
        }

        return r;
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_inf=
o,

        return uid_info->uid[type][inst];  }
+
+__printf(3, 4)
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobj=
ect_action action,
+                                    char *fmt, ...) {
+       struct kobject *kobj =3D &adev->dev->kobj;
+       char *uevent_env[2], *tmp;
+       va_list ap;
+       int ret;
+
+       va_start(ap, fmt);
+       tmp =3D kvasprintf(GFP_KERNEL, fmt, ap);
+       va_end(ap);
+
+       if (!tmp) {
+               ret =3D -ENOMEM;
+               goto out;
+       }
+
+       uevent_env[0] =3D tmp;
+       uevent_env[1] =3D NULL;
+
+       ret =3D kobject_uevent_env(kobj, action, uevent_env);
+
+       kvfree(tmp);
+
+out:
+       return ret;
+}
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done) {
+       int val =3D done ? 0 : 1;
+
+       return amdgpu_device_uevent_emit(adev, KOBJ_CHANGE, "RESET=3D%d",
+val); }
--
2.34.1


--_000_DS0PR12MB7804E9B50AA94EAB4B391992971EADS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
From what I understand, all KFD events will also eventually be moved to drm=
 node based uevents. Also, these events are pre/post reset ones, not when t=
he device is in reset state.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Friday, September 26, 2025 3:13:39 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#467886;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:b=
reak-word">
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0080=
00; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">&gt;&gt; I guess the primary reason to have drm_ e=
vent and amdgpu having that is because all the 'users' interested in GPU ev=
ents come through drm interface.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">in fact, that such devices like drm render/kfd/i2c=
 controller/hwmon/device nodes are attached to pci devices may not respond =
if device in reset state.<br>
so, this is useful event for user mode application.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">and please conduct some research before making any=
 comments to avoid wasting review resources.<br>
<br>
KERNEL[11438.593689] remove&nbsp;&nbsp; /devices/virtual/kfd/kfd (kfd)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.593757] remove&nbsp;&nbsp; /class/kfd (class)<br>
KERNEL[11438.614767] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13/i2c-dev/i2=
c-13 (i2c-dev)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.615100] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/car=
d1-DP-3/i2c-13 (i2c)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.615624] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/car=
d1-DP-3 (drm)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.615951] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/car=
d1-HDMI-A-1 (drm)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.617227] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/car=
d1-Writeback-1 (drm)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.618336] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1 (dr=
m)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.618429] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/renderD12=
8 (drm)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.622178] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/hwmon/hwmon0 =
(hwmon)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784296] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-10/i2c-de=
v/i2c-10 (i2c-dev)</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784346] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-10 (i2c)&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784386] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-9/i2c-dev/i2c-9 (i2c-dev)</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784417] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-9 (i2c)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784508] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-8/i2c-dev/i2c-8 (i2c-dev)</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784540] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-8 (i2c)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784634] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-7/i2c-dev/i2c-7 (i2c-dev)</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784664] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-7 (i2c)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784803] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-6/i2c-dev/i2c-6 (i2c-dev)</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.784934] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-6 (i2c)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.785151] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-5/i2c-dev/i2c-5 (i2c-dev)</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">KERNEL[11438.785335] remove&nbsp;&nbsp; /devices/p=
ci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-5 (i2c)</=
span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Best Regards,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Kevin</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar=
@amd.com&gt;
<br>
<b>Sent:</b> Friday, September 26, 2025 17:22<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal">The intention is to notify users of the device abo=
ut the event.</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">I guess the primary reason to have drm_ event and =
amdgpu having that is because all the 'users' interested in GPU events come=
 through drm interface.</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">Thanks,</p>
</div>
<div>
<p class=3D"x_MsoNormal">Lijo</p>
</div>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.W=
ang@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, September 26, 2025 1:04:56 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEG=
IN"></a><span style=3D"font-size:11.0pt; font-family:&quot;Times New Roman&=
quot;,serif">[Public]<br>
<br>
KERNEL[173.150476] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1 (drm)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0/drm/card1<br>
SUBSYSTEM=3Ddrm<br>
WEDGED=3Dnone<br>
DEVNAME=3D/dev/dri/card1<br>
DEVTYPE=3Ddrm_minor<br>
SEQNUM=3D6237<br>
MAJOR=3D226<br>
MINOR=3D1<br>
<br>
a &quot;drm_dev_wedget_event()&quot; uevent example above.<br>
<br>
You shouldn't discuss these together; they are two separate events occurrin=
g on different type devices (pci device and drm device).<br>
software-defined devices and physical devices don't have a strict one-to-on=
e mapping,<br>
and the device initiating the reset and the device that need to reset are d=
ifferent on an XGMI system.<br>
so, all independent PCI devices in same XGMI link need to independently rep=
ort events.<br>
<br>
Best Regards,<br>
Kevin<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.=
com</a>&gt;<br>
Sent: Friday, September 26, 2025 14:55<br>
To: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYa=
ng.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuc=
her@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent<b=
r>
<br>
[Public]<br>
<br>
Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?<br>
<br>
Thanks,<br>
Lijo<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Yang Wang<br>
Sent: Friday, September 26, 2025 12:04 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuc=
her@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent<br>
<br>
Use the uevent mechanism to expose the GPU reset state, so that the system =
tool can more accurately monitor the device reset status.<br>
<br>
example:<br>
$ sudo cat /sys/kernel/debug/dri/&lt;minor&gt;/amdgpu_gpu_recover<br>
<br>
KERNEL[172.053149] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0 (pci)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0<br>
SUBSYSTEM=3Dpci<br>
RESET=3D1<br>
DRIVER=3Damdgpu<br>
PCI_CLASS=3D30000<br>
PCI_ID=3D1002:73BF<br>
PCI_SUBSYS_ID=3D1002:0E3A<br>
PCI_SLOT_NAME=3D0000:05:00.0<br>
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00<br>
SEQNUM=3D6235<br>
<br>
KERNEL[173.137681] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0 (pci)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0<br>
SUBSYSTEM=3Dpci<br>
RESET=3D0<br>
DRIVER=3Damdgpu<br>
PCI_CLASS=3D30000<br>
PCI_ID=3D1002:73BF<br>
PCI_SUBSYS_ID=3D1002:0E3A<br>
PCI_SLOT_NAME=3D0000:05:00.0<br>
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00<br>
SEQNUM=3D6236<br>
<br>
Signed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com">kevi=
nyang.wang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 +++++++++++++++++++++=
+<br>
&nbsp;2 files changed, 42 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 2a0df4cabb99..73c946d9cbe1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_inf=
o,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint64_t uid);&nbsp; uint64_t amdgpu_device_get_uid(struct amdgpu_ui=
d *uid_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_uid_type type, uint8_t inst);<br=
>
+<br>
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);<br>
+<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a77000c2e0bb..300cc22dad91 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,<br>
<br>
&nbsp;retry: /* Rest of adevs pre asic reset from XGMI hive. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, de=
vice_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_uevent_reset(tmp_adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*TODO Should we stop ?*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r) {<br>
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * in before drm_sched_start.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_stop_pending_resets(tmp_adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_uevent_reset(tmp_adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_inf=
o,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return uid_info-&gt;uid[type][in=
st];&nbsp; }<br>
+<br>
+__printf(3, 4)<br>
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobj=
ect_action action,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *fmt, ..=
.) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj =3D &amp;adev-&g=
t;dev-&gt;kobj;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *uevent_env[2], *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list ap;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_start(ap, fmt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D kvasprintf(GFP_KERNEL, fmt, a=
p);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_end(ap);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uevent_env[0] =3D tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uevent_env[1] =3D NULL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kobject_uevent_env(kobj, acti=
on, uevent_env);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(tmp);<br>
+<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int val =3D done ? 0 : 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_uevent_emit(adev=
, KOBJ_CHANGE, &quot;RESET=3D%d&quot;,<br>
+val); }<br>
--<br>
2.34.1<br>
<br>
</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif"></span=
></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS0PR12MB7804E9B50AA94EAB4B391992971EADS0PR12MB7804namp_--
