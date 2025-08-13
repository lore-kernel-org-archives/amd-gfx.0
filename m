Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90588CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 09:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1559D88C4C;
	Wed, 13 Aug 2025 09:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4To7hyE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AE988C4C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 09:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEBHCLxHbNngobT2lqTIVTpUkIVV2K+0AjZXSLGTyxtfQlaLyEnRliJrde5b3rWY47hAZv6g+fECO6GsA/u+KA7ASD8H+eqQbprYbcAsuyNoEbfxt+NSTSnq4OwsKMjRxQqczsb7s4Vh+7fmtVpHXp9XWZg+dCf4ygXc8Gm8GQSKaEE97WFWE+G56EiaTOb/8FUJ/g6VEb6WAzcLzkY038WTV2G4i+pI2RFxpI1a4WGyd0X/1fKkRZ80PIAO2f7HH/c0b6cdjxS8mRonjpLjVpbsmy+8fewmBPpZeDQSmjGePEXQclnAbFhXHFGCvaJIwehib9a/c3VFyvdO21X0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX0GPU4YOw92D9pgLnXH2SNJTcPpkPBXTKwDhVHj1bs=;
 b=aSBkEg8otoG/uiMUcWPtj1SeenfFd1EKPwNlpOBPh/dJfiaF7rBm2OWkFSHFhIrkB3vR/MPfSksMnBnDVpP6tBFrIGgWSj40//JjkstzJw3jTdjpLaxrYB4lznDNap2R5mrSCxFyPpLGG/Kx4fff8pfWummal6UeWBxJn0zpMJK5adFbUrD4ScwDYYn2EgDHlCGdNiJzs0Uo6Ym7wcKmIN0tnjAGYVka3lx4DzbgqUv8peqnh1UFXM51W9cFru7wnBLRiUl8uic6Ptuvjdb+Eo0wGrckJv6CTydhEBDA5WL3WPukSBIldBxAA1BEFOMK1cMegh4apFU5fW3JAAmJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX0GPU4YOw92D9pgLnXH2SNJTcPpkPBXTKwDhVHj1bs=;
 b=H4To7hyE4aPqhpmdEx8EjwI7tAgNtuQZad7O5ELat5Ovewlby/4f+adAjebnEBwHRtZBMaNvqiNHlXmXVObPkndbisyy7IcAezWZGCUDE7x9KRHXLchq44OM2aZCBcr8ap1+b1BFyyEvYRvqtuK4SaZNhFVVeDexNxQ3XaGE9JE=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.25; Wed, 13 Aug
 2025 09:48:17 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 09:48:17 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcC1upGsd/ITdiqE+HEIMTwlUZprResPiAgAArrICAAXgzgA==
Date: Wed, 13 Aug 2025 09:48:17 +0000
Message-ID: <PH7PR12MB798802FA071DCCDAFF1CB55C9A2AA@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250812073453.257913-1-cesun102@amd.com>
 <CH2PR12MB42157554010D0EF4E81D4FA7FC2BA@CH2PR12MB4215.namprd12.prod.outlook.com>
 <SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T11:10:14.5870000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CH3PR12MB8850:EE_
x-ms-office365-filtering-correlation-id: c3d94e50-7bff-485e-1be2-08ddda4e8772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SXSnZbvRN7Kw39B9+HHxG+GUuc67ohGKjaPUvBCMGap/kR3takQFsIKQQ1bE?=
 =?us-ascii?Q?FKqVxKOT1hwOH+PxClvNZJz3FBj7eRVnAF2hEHATG8WCkJ7OtInvBGw4Y15f?=
 =?us-ascii?Q?6GpMJDbrf9/YKB3J6mrSE6e+Pck7AVUQbnzgInV8aGLjDhk+vRFkOs1/kR6G?=
 =?us-ascii?Q?UIjQntPUuOc1P83xOHDX4ZEVX1ejkRUSO0mZh2Gn55BlAj9AQZwxQlp+6y7x?=
 =?us-ascii?Q?qulSD1RG8CZgm9Tanra6B7FLLkn+YNRNlakjzvx56haXtea11LWGo9rF+kGf?=
 =?us-ascii?Q?HRhh4z2AnxPA4Uc0uxCH5eeWUuET4LJIqCQzAQhYhPFeaz+ocM/DNL4/Yx2R?=
 =?us-ascii?Q?TB3wzHEam2uyZiuilB9WDmXhdnYColp1XkkisjVijv72SIarw1lWTDpkfqZD?=
 =?us-ascii?Q?fuTI5AJiBzPXB2TkXyla1mj87TWc2ogy93UbigTHkrfc/FZTqxe63BtlWoQY?=
 =?us-ascii?Q?84dXyNkZfZgGqOISVitBGZ9OVASSgcYtKvqJduf6VpR/81tvcGsK/bX4EFso?=
 =?us-ascii?Q?K7RAXS7LsGhfrrHPEWRtz6LLOXM8z2rb7wphRA88oMmTXCzh/8FsXtXVWrno?=
 =?us-ascii?Q?cQHNI0UDB12t2IvuZZl4e7FhyHWx7pswaBzB/us39nTsNrBRA5jujPtjOsn8?=
 =?us-ascii?Q?QSDUmfP5YtCIFHzqv7RjK5wZqPYs4uFWtLITnNTOEIH03E9UY/sjJsSl/Xck?=
 =?us-ascii?Q?axLbe61+jC8nI3yIvxmNIbFD5lffS1b8YJkQCAhrjM0Yw43rV+QUKuSIh6gU?=
 =?us-ascii?Q?szvjEZwtTRD+pwUOQK7wk4LktW7FQJtihtmAjQk22H0wPQuoW2x7tRKgUoVE?=
 =?us-ascii?Q?GOPZu9ippOi0z8yS907/OpWl6ximcnnhH7Fh//VMIFVFwXjzUeZykxyFjsu8?=
 =?us-ascii?Q?K0QWhbywlhWQK3vry8JvyKYY/EaUuH4OR0k9crIMsas5UiTz3KcvIZdTCAyL?=
 =?us-ascii?Q?TrYvUb6Ib7YS39OPK3FHjOA7Qsa/02KqvkHAlYe2WSb+bqd4fh7Ltd3mbhkq?=
 =?us-ascii?Q?72jvLn9iTrHRHFfEaigvVWYuSZBx1XAXDw/ccmCinNCjf4y2pHHqCs1Xd+hZ?=
 =?us-ascii?Q?KA3ynCrsLNbF+0na9MuWsZAVFJVpq6NEUyLI9uDnZp/2wb88QDa2eUbiktSC?=
 =?us-ascii?Q?N9IXPQ8+UAFSxSiyoGv2PAinnJZmTQI3zYZdOCnoM3FoF+yPhKSQgu/xYB1z?=
 =?us-ascii?Q?eLf4gkKtzZrDHJWWGN4xR9ET4ZlMN9+XjQJFGJBO4EvPfd4hsm2Yq4SOhgb+?=
 =?us-ascii?Q?0kBu/V5J8luOU/IrEYU4bQ1Z9zjMX/AnUrrRHFhnB80xtljgMsdJ+T6pPSO7?=
 =?us-ascii?Q?FufTcT8e2GW7gmyHm2zzrNOS7t4OE+9MlkFvyZjYcRJyDmDvqL+dGhtnMeKU?=
 =?us-ascii?Q?/8v3P5IoYE2R7JPSSsp6/fOtVSqKi/JD2AKlScG4kG4mJaElTImmZEhoijuY?=
 =?us-ascii?Q?4RQiF3BN3tYhXJ893lNMTStTsQzHz49R4vZFBMO9F0K41Vw5iggbGZsUekIi?=
 =?us-ascii?Q?d5YVrId6DRlfpy4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IzjURZAd1NfkWXfSmZetqAXRr7FXO2o4ALyQFUoqCKyU8FpL5t4D+MKLm4s9?=
 =?us-ascii?Q?dikrYchHTjZr6BqiSp7/0FcXevVss5awdhWla1cSxUJv3kX8ejfxzk/pEgj3?=
 =?us-ascii?Q?L8XSBUNUM+mMIOWw5OqrpqaFWFfEL6kZoDRQBSkFTG69gg3j1pAGZyqSU9h8?=
 =?us-ascii?Q?wsYyczEjz2PjJ0BsTz+bT8GQNyoDvEQFCeUCCh0sO48p6LAuoidmt7Q78vim?=
 =?us-ascii?Q?P5djhzP5D6gdQpXKPeb7i1zer3GVTrmOI2tej7y6h+JkuBPPIWb4NvDfzNzK?=
 =?us-ascii?Q?d00VRi08iDVGOKO69WjG4BomArM6B5E433xLwVLwAP8/wXZBaeMFTJz6DZyv?=
 =?us-ascii?Q?qVTGtkE/qO+nbY/3BTCQmCyG0dYzBvfmv/Noo66PqzzC6NzSUmmJccomkHYp?=
 =?us-ascii?Q?BI2/ZsWZPmBS7gwAYcLoRMR1SuCFnGKQdsWqgxn9JfdQZu+PEJu2s5B4OKBK?=
 =?us-ascii?Q?JXYtFbv75daf5lCl32j8hDBLKkKWbQX5pwyZ2MAvIo5Ck/SsrvVMQAQv9Gju?=
 =?us-ascii?Q?qN1cg/AmBURh+R/IpoACDAEYJq66swDs6AownjhkkwGcHP+E9LrmTFdUtPIc?=
 =?us-ascii?Q?8+di2Begneqp9ElqCqXT1bGwGvZP2JaqAf0i3XcmmGY4dD8TS9/s/NwSGPG+?=
 =?us-ascii?Q?pAgdcScyLRlgKc5oG/lKfPPCZgCG9Wi9rsf9XNTUj9d4mYjShBdtmn7BH48e?=
 =?us-ascii?Q?RAvyuQjcxa+Xl0LdoZ/mKXiMrRLomgsaigHemTAqM3/dqtoOKQoC/yo4njhJ?=
 =?us-ascii?Q?To7g/xfbW+IBfTfxUdZFswNMzmpD0DD+M0dMIys+CZewgR9bxRaai0HyUSK1?=
 =?us-ascii?Q?ju8Qjll2QV5+UDX7bjjO9Xgs2FBlvoFZbcPKuFLNN4Meg13NjXqOED1rCTCt?=
 =?us-ascii?Q?b6ecXgP5bHDmAXTOuVUvFF4qHn26NTy+0PYva5KFgnJ0feE9Ns1QDjjUh1pg?=
 =?us-ascii?Q?cTd5Rq7lf9w/nAETqx0Lak7s+FLXONLakqaqGh+tE2CuUQ1P5lQOvPyUEU84?=
 =?us-ascii?Q?xd08LHn+W5RchwvmE9vnrxTUUc13VyH6aWmsPmLONLeDPaE/M5c6N0ZVR7q6?=
 =?us-ascii?Q?015oU4Rjr3T6OuaiHXXO8HOBsoLS+NOqPd+ZsOdRVSiUXz6J06hTFs+PWpMc?=
 =?us-ascii?Q?SsX5i/u1aORjZv+Lw5Hlxfhmr3eF87bB+zD2KuaQNojeTuRTqnb4zO/bSv9n?=
 =?us-ascii?Q?2zeIeV/Nm9Qk+Zq2suar6SD25ZbbFlibByKooO9c3dWub5VFOKnVfBvs2RWS?=
 =?us-ascii?Q?9OkZLD97DeDus4KEE+9HqwZLACdLF3DUDEYzLLV1AqyhDc4zd1S/jrLdIRZS?=
 =?us-ascii?Q?pA0LnOc9G5g2DE/a5qrNFqT4xHEuOck3SjRfiSzLaZTj8+YtDrcz9NoWcE8V?=
 =?us-ascii?Q?IoPKduwCZW3sjrXeFyjeRfg8bcrgyn+7TVsPdWFlxvNwFxHDxRqg/pKL9VoK?=
 =?us-ascii?Q?WUJ0CK3vuVr+s1lZJwXqglSHEJu52A0Dlzh0ZautERz7C4dMbdGBZ2hJjL6T?=
 =?us-ascii?Q?zshWgItTp0Fc1nx3Dp+3aMeIGeBHgwt1GbfFvOMBnub9gVuJLYMbXfCqmMqY?=
 =?us-ascii?Q?pSg7qlYS4v+vmSLU2o4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB798802FA071DCCDAFF1CB55C9A2AAPH7PR12MB7988namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d94e50-7bff-485e-1be2-08ddda4e8772
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 09:48:17.1089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUWBZ7M11OA6n+BF/LI1a6889zJ90TiI8Zqq9/zQMGn0V62zb7+h1cY0MUUnUAGwEJ2J6PfINV20MsPEWJRaDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850
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

--_000_PH7PR12MB798802FA071DCCDAFF1CB55C9A2AAPH7PR12MB7988namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This issue is caused by SMU polling mca bank info delay, driver can add cor=
responding delay before send msg to SMU to query mca bank info.

Regards,
Stanley
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, August 12, 2025 7:10 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info


[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Sent: Tuesday, August 12, 2025 3:35 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley=
 <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Chai, Thomas <YiPeng.Chai@=
amd.com<mailto:YiPeng.Chai@amd.com>>; Sun, Ce(Overlord) <Ce.Sun@amd.com<mai=
lto:Ce.Sun@amd.com>>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con, @=
@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);

[Thomas] Does bank_count  only use for umc deferred error or include umc ce=
 de and other ras block bank error?
[Ce,Sun]Hi Thomas,thank you for your review.
Yes, here include umc ce de and other ras block bank error. If there are ma=
ny bank errors stuck earlier, we will read out all the ones stuck earlier w=
ith bank count=3D12.
                  The amdgpu_ras_poison_creation_handler function is used t=
o handle UMC deferred error. not include umc ce and other ras block bank er=
ror.
[Ce,Sun] As mentioned earlier, if a lot of umc ce is stuck and not handled =
earlier, it will be reported through amdgpu_ras_poison_creation_handler. I =
think how to handle or parse it is done by aca parser. we aim is still to r=
ead out all the bank reg info.If the include umc ce and other ras block ban=
k error gets stuck ahead.I think it should be a normal behavior to parse ou=
t all the umc ce and other ras block bank errors that were not reported ear=
lier through the creation/consumption interrupt

+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Tuesday, August 12, 2025 4:33 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.free=
desktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley=
 <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Sent: Tuesday, August 12, 2025 3:35 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley=
 <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Chai, Thomas <YiPeng.Chai@=
amd.com<mailto:YiPeng.Chai@amd.com>>; Sun, Ce(Overlord) <Ce.Sun@amd.com<mai=
lto:Ce.Sun@amd.com>>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con, @=
@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);

[Thomas] Does bank_count  only use for umc deferred error or include umc ce=
 de and other ras block bank error?
                  The amdgpu_ras_poison_creation_handler function is used t=
o handle UMC deferred error. not include umc ce and other ras block bank er=
ror.

+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
 };

 struct ras_critical_region {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..8dbffe4d22d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,

        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
-               if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
-               else
-                       dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);
-
                kfree(ecc_err);
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
-
        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                pa_addr,
--
2.34.1

--_000_PH7PR12MB798802FA071DCCDAFF1CB55C9A2AAPH7PR12MB7988namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This issue is caused by SMU polling mca bank info de=
lay, driver can add corresponding delay before send msg to SMU to query mca=
 bank info.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Stanley<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Sun, Ce(Overlord) &lt;Ce.Sun@a=
md.com&gt;
<br>
<b>Sent:</b> Tuesday, August 12, 2025 7:10 PM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.=
Yang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(=
Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank re=
g info<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">-----Original Message---=
--<br>
From: Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.co=
m</a>&gt;<br>
Sent: Tuesday, August 12, 2025 3:35 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</=
a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanley.Y=
ang@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd=
.com">Hawking.Zhang@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailt=
o:KevinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&gt;;
 Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.co=
m</a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;<br>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info<br>
<br>
By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained<br>
<br>
Signed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.=
com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++-----------------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 2 --&nbsp; drivers/=
gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; |&nbsp; 7 ----<br>
&nbsp;3 files changed, 13 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index f00a9e0c9c47..ad8ad08f0f33 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)<br>
&nbsp;/* typical ECC bad page rate is 1 bad page per 100MB VRAM */<br>
&nbsp;#define RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)<br>
<br>
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 300&nbsp; //ms<br>
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 50&nbsp; //ms<br>
<br>
&nbsp;#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100&nbsp; //ms<br>
<br>
@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;ecc_log-&gt;lock=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_RADIX_TREE(&amp;ecc_log-&gt=
;de_page_tree, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)=
 @@ -3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_l=
og_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ecc_log-&gt;lo=
ck);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;ecc_log-&gt;l=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *c=
on, @@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(s=
truct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t poison_creation_count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D MAX_UMC_POISON_P=
OLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgp=
u_ras_get_context(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_dete=
ct_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t need_query_count =3D poison_=
creation_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_event_type type =3D RAS=
_EVENT_TYPE_POISON_CREATION;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t prev_de_queried_count =3D 0;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bank_count =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.head.block =3D AMDGPU_RAS_B=
LOCK__UMC;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log =3D &amp;ras-&gt;umc_ecc_log;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D amdgpu_ras_query_error_status_with_event(adev, &amp=
;info, type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; de_queried_count =3D ecc_log-&gt;de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (de_queried_count &gt; ecc_log-&gt;prev_de_queried_count) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D de_queried_count - ecc_log-&gt;prev_de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev=
_de_queried_count =3D de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank_count =3D amdgpu_aca_get_bank_count(adev);<br>
<br>
[Thomas] Does bank_count&nbsp; only use for umc deferred error or include u=
mc ce de and other ras block bank error?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black;background:yellow">[Ce,Su=
n]Hi Thomas,thank you for your review.</span><span style=3D"color:black"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black;background:yellow">Yes, h=
ere include umc ce de and other ras block bank error. If there are many ban=
k errors stuck earlier, we will read out all the ones stuck earlier with ba=
nk count=3D12.</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; The amdgpu_ras_poison_creation_handler function is used to handle UMC d=
eferred error. not include umc ce and other ras block bank error.<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black;background:yellow">[Ce,Su=
n] As mentioned earlier, if a lot of umc ce is stuck and not handled earlie=
r, it will be reported through amdgpu_ras_poison_creation_handler. I think =
how to handle or parse it is done by
 aca parser. we aim is still to read out all the bank reg info.If the inclu=
de umc ce and other ras block bank error gets stuck ahead.I think it should=
 be a normal behavior to parse out all the umc ce and other ras block bank =
errors that were not reported earlier
 through the creation/consumption interrupt</span><span style=3D"color:blac=
k"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (bank_count) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_de_queried_=
count =3D bank_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_clear=
_bank_count(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_=
UMC_POISON_POLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (new_detect_count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_cou=
nt +=3D new_detect_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout &am=
p;&amp; need_query_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!--timeout)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (total_detect_count &lt; need=
_query_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_detect_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prev_de_queried_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; schedule_delayed_work(&amp;ras-&gt;page_retirement_dwork, 0=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_rma(adev) &amp=
;&amp; atomic_cmpxchg(&amp;ras-&gt;rma_in_recovery, 0, 1) =3D=3D 0) diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h<br>
index ff63020f9c6c..132b45a362c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -492,8 +492,6 @@ struct ras_ecc_err {&nbsp; struct ras_ecc_log_info {<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chai, =
Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&g=
t;<br>
<b>Sent:</b> Tuesday, August 12, 2025 4:33 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@am=
d.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">St=
anley.Yang@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zh=
ang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Wang, Yang(Kevin)
 &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&g=
t;<br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank re=
g info</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.co=
m</a>&gt;<br>
Sent: Tuesday, August 12, 2025 3:35 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</=
a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanley.Y=
ang@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd=
.com">Hawking.Zhang@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailt=
o:KevinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&gt;;
 Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.co=
m</a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;<br>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info<br>
<br>
By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained<br>
<br>
Signed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.=
com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++-----------------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 2 --&nbsp; drivers/=
gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; |&nbsp; 7 ----<br>
&nbsp;3 files changed, 13 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index f00a9e0c9c47..ad8ad08f0f33 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)<br>
&nbsp;/* typical ECC bad page rate is 1 bad page per 100MB VRAM */<br>
&nbsp;#define RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)<br>
<br>
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 300&nbsp; //ms<br>
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 50&nbsp; //ms<br>
<br>
&nbsp;#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100&nbsp; //ms<br>
<br>
@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;ecc_log-&gt;lock=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_RADIX_TREE(&amp;ecc_log-&gt=
;de_page_tree, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)=
 @@ -3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_l=
og_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ecc_log-&gt;lo=
ck);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;ecc_log-&gt;l=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *c=
on, @@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(s=
truct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t poison_creation_count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D MAX_UMC_POISON_P=
OLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgp=
u_ras_get_context(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_dete=
ct_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t need_query_count =3D poison_=
creation_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_event_type type =3D RAS=
_EVENT_TYPE_POISON_CREATION;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t prev_de_queried_count =3D 0;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bank_count =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.head.block =3D AMDGPU_RAS_B=
LOCK__UMC;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log =3D &amp;ras-&gt;umc_ecc_log;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D amdgpu_ras_query_error_status_with_event(adev, &amp=
;info, type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; de_queried_count =3D ecc_log-&gt;de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (de_queried_count &gt; ecc_log-&gt;prev_de_queried_count) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D de_queried_count - ecc_log-&gt;prev_de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev=
_de_queried_count =3D de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank_count =3D amdgpu_aca_get_bank_count(adev);<br>
<br>
[Thomas] Does bank_count&nbsp; only use for umc deferred error or include u=
mc ce de and other ras block bank error?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; The amdgpu_ras_poison_creation_handler function=
 is used to handle UMC deferred error. not include umc ce and other ras blo=
ck bank error.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (bank_count) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_de_queried_=
count =3D bank_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_clear=
_bank_count(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_=
UMC_POISON_POLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (new_detect_count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_cou=
nt +=3D new_detect_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout &am=
p;&amp; need_query_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!--timeout)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (total_detect_count &lt; need=
_query_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_detect_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prev_de_queried_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; schedule_delayed_work(&amp;ras-&gt;page_retirement_dwork, 0=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_rma(adev) &amp=
;&amp; atomic_cmpxchg(&amp;ras-&gt;rma_in_recovery, 0, 1) =3D=3D 0) diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h<br>
index ff63020f9c6c..132b45a362c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -492,8 +492,6 @@ struct ras_ecc_err {&nbsp; struct ras_ecc_log_info {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct radix_tree_root de_page_t=
ree;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; prev_de_queried_count;<br>
&nbsp;};<br>
<br>
&nbsp;struct ras_critical_region {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index e590cbdd8de9..8dbffe4d22d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_umc_logs_ecc_err(=
adev, &amp;con-&gt;umc_ecc_log.de_page_tree, ecc_err);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D -EEXIST)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_=
log.de_queried_count++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Fail to log ecc error! ret:%d\n&quot;, ret);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(ecc_err);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.de_queried_count+=
+;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(page_pfn, 0, sizeof(page_=
pfn));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D amdgpu_umc_lookup_bad_=
pages_in_a_row(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa_addr,<br>
--<br>
2.34.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB798802FA071DCCDAFF1CB55C9A2AAPH7PR12MB7988namp_--
