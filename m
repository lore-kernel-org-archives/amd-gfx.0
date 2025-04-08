Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53949C369A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 19:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7110E171;
	Tue,  8 Apr 2025 19:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UQA4rM2z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEA410E171
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 19:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZmuCN/2gbWkeLR34uofdY1zQ9SjbNKkLnn96YysHJh8Q/cxktC0YtbF18Ek5Kvchvk9BPT2p1Kp454pHRZ9gn2iZ/tLS83Gge0x3vtUvsol95eylnwHu4JioDR/hkciotBkbDAGhls5B2o7L1wD2CSgynH3ryCK7M74Baj7OtO2s836p3M1Xpm60yi7YeVAAhd9jgjzTj6KEh8oujgyyRpJl6GNrF7X5ytZnUyeGgJKozQsDcoE+9swBq5kjXkfJbJnRPTAzaOiSNZwcXMphJkYsMjTaOxH6FpOkJmJM7AskmnNxFdNCEl2By9vANMLfZqmNgWkNy2w64aMsnS7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz6QubpiB4TGt0tCRknNOAYn50wm+zq4JGutBL8bVkE=;
 b=GccOt/lNZMSvhHYojpP59O/Rvx6SzFQaSkmEu2kvRYnQ86oExFRbzt+4wGku9TXxyFYzjKleeT4P8a2k++UDSKMmNFmaFGBco9euGMsYsK/HDHN3iy1TjJL53ke+AKWwb6Yg8juhhMNXUkSbEpzhBDlDbML+n0uLYsiSmLbs58r076TD8JqfQRSJjRMGtHKG2K8P1+faQRQd/XErweL1df9RwUwgrpSZ/Q6EO5TSRvLtHc2ocvPRmggSA4u2K50cyXzWGgT06y4DGY/E+X3CgKa/MAsiE50okZMvTQum9FrnIq/JJtsP3Bhv2OxKbD8DSzS9u3u0v4wZzcrDZtcR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz6QubpiB4TGt0tCRknNOAYn50wm+zq4JGutBL8bVkE=;
 b=UQA4rM2zM+V7F+DiUcljMqz38lp+FVKM1cVt+YC5lP3VZghIP2FppgDy3jtTHP51x3R+Ilv5kX3jl84PUukvuygnVKCG3VH/DAhWollleFhXt5VuOLf10XI7XWkb965d3w/iUa7wKxa5rdSW/7/cDChRbpVHOY1r16u/Q+ggumY=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 19:03:38 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 19:03:38 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Grinman, Masha" <Masha.Grinman@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Grinman, Masha" <Masha.Grinman@amd.com>, "Grinman, Masha"
 <Masha.Grinman@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Move read of snoop register from guest to host
Thread-Topic: [PATCH] drm/amdgpu: Move read of snoop register from guest to
 host
Thread-Index: AQHbp+B8MelhtLGiNUCFMrTyp9I0j7OaIPvw
Date: Tue, 8 Apr 2025 19:03:37 +0000
Message-ID: <CY8PR12MB70998CB780DE33292768009F8CB52@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250407171344.234402-1-masha.grinman@amd.com>
In-Reply-To: <20250407171344.234402-1-masha.grinman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=044fb97e-0981-415e-bdee-57b142a6a852;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-08T19:00:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB8416:EE_
x-ms-office365-filtering-correlation-id: d565b8e1-0de3-4028-95de-08dd76d011c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YtyU5SLWK6XzrUSdIA52a1OFMf/togTvURiHcJCohVhduw5yWx/1qle9EjSQ?=
 =?us-ascii?Q?VV0CfQtzlwjuBJbCuXawjd7A+hiXTTxwVMQDhJfXqFrvtl687Yhk5T21Mz4S?=
 =?us-ascii?Q?PvqWo7tdOmq26RKlgdkILVyBFR5JmBIR9sXaK4ThsVQlBh3qqRpIWC3QnARH?=
 =?us-ascii?Q?v/4XUUZKZkTzHUXfyYfqNJkQqmheUMm6fWr9uuML6SPc+m158JpgIfcYQwZq?=
 =?us-ascii?Q?ukK2TcLSQsWvdgrUKENm9qcF2Zn3Hb4wVaYUnfwTAu7eyQF30efSpmum6aqh?=
 =?us-ascii?Q?cFDf4Hn8AYrg4kBtfKBrfb7chLapEtoaH43+lvUe8RCcUlkjRzeq8wN/CCA5?=
 =?us-ascii?Q?zEIPv/J/pygSikFYznjlQLR2V2WootqtJbvu/1KUCR9WFY7y9E0lQTwESqY7?=
 =?us-ascii?Q?AZf0Q3WLAT4idufck5oiGiaaaGeDA2yip2Uj/dpPns1VmysRWkBg3zWOO/xE?=
 =?us-ascii?Q?VOkqRtqrrXfkinta4ooh8glLF+9l7pSdYulPPTJmKX2jLo1XZgMNUtQsiqHO?=
 =?us-ascii?Q?XWJNTK7MBqf7rf4TyqWjintIyF4pzBaZfJviE8WkbYyeyII0kBqGFO9RnbNH?=
 =?us-ascii?Q?umwOm4AQGCxS2KYy0oWFtt4HUeGD87EksPn+7lTOrfoz+0SeOPTaaC1BmwzQ?=
 =?us-ascii?Q?/+9DtCU1uugIEdq06MfxkHWR3fGxYaIo7HvhNgBebxiXu802EzgUv0szt7GE?=
 =?us-ascii?Q?qnf7kgQi1d0NzRE5kbrE2ZBTjpfXZfhXxzZi6R2NJqTGMNl78tKbxaLmgyWM?=
 =?us-ascii?Q?CQy8YNRSCpEjygDk73+WzaCm5Y/nFukczOkbmTk+iyfjqvigxaLgMBInP1KV?=
 =?us-ascii?Q?PdKq6iwuFihWlkKC2TDVoii97w2yZDjYK0ag9L3v09VgHT5vSjs3FxAGg4sN?=
 =?us-ascii?Q?fBdmm5c7f8RP+qjNVTF7l3KCHTmrV7AuHWaJe7Ckuy50ojpf38EXDPs+tbIV?=
 =?us-ascii?Q?tC+9npdjwjJXCq7i3d1Kk4fDbnq38cHCoqQ0+bFBvFTS3Nrn08dUmYD4abzt?=
 =?us-ascii?Q?JO6Zw+tm1oV5DdETs5W4cvQuvtY/+VLU8WBzTVbPq1FVgUaM9ko2mBc4PJ0z?=
 =?us-ascii?Q?o3veqC/K+ZcdNfAWTKUmI+xuLRvHwgeM0spJcMertjsiIh7uNZdXAa0VSt6j?=
 =?us-ascii?Q?0iDZ/7tCIrSF/67e6chnRUcf/j9fLmyV+PW9/lz8Sn8lJsV/Oj9BzNV1fqGn?=
 =?us-ascii?Q?mXmz0fe36p9XUzkkizWeYOQYlQZyPJZUd04Jo5pvVmApzC3cJP50FhRuerJW?=
 =?us-ascii?Q?+9REDrTRGJl/g4OSYyp9WdsFxRXqv2w5lQzkCOaNr0kiVvDdNIcs7Una77of?=
 =?us-ascii?Q?4XldDxiypEo39oDhP5T64Exu/uZjc5g/i+KbIwc4pGO4zXF3a80PZ0o/hT8N?=
 =?us-ascii?Q?xbjjjkLN/fi1tQePNul8s2i47olixdBRFACgpX/Q0ndEJHzWWBioKD0swUeu?=
 =?us-ascii?Q?un3UME3+o6TmD/2V5lo4XCOiYaKQ5RkLpEJyE8Xq5h0S6V348wTtkCmTB2h4?=
 =?us-ascii?Q?EUF9qXaYO8KHdVk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yvHr751cMKxhqz3AF5UCkaYo/u5oyD8UQjnbtkw0CwohAjdPtEOB6FIzsFkO?=
 =?us-ascii?Q?L662AFC5b1mSF5bdbz4GVK9BXnQ/X5JoctnbuztSqyEEnQ7CXn+IJ5EA0+pv?=
 =?us-ascii?Q?ZHTq89SHvtN8EF+HrSdsT/SUFqnTMnAjd+GqbWwn35IUaiNmgWQu0O/N4Du/?=
 =?us-ascii?Q?puhF3j8m3PHHj+GpHeRPQcIRClPmgTLx+U/0yzqsa/sw22u876S6S8aelmPi?=
 =?us-ascii?Q?C0/UM8bwEqrkJ6JWqX3Ox49EF8wPlKSRE7aADN8GmDja+kibcInjQaPJTGOZ?=
 =?us-ascii?Q?aSZgJvrTZJfg3Mh8CXPdwurOwtr8PSFDzbXIBJ9OBg7qbcd0GzrFgbwed3X6?=
 =?us-ascii?Q?8c7aiE9P7ImLy5MbmNG6066YAF55sjyLB+hd36s3sEfPSUqMYBHo/RxNlmc5?=
 =?us-ascii?Q?+1LNAisjjk6w3d6BDxrChVBxf7nfrMmazHo6h5wHLt3y+fDDLTkikcA1SLFB?=
 =?us-ascii?Q?rI/Aoz2fP6F3IR1w4Zf8Ufsm8TZo7nwXCa0tq/rB7UxGEaXgtoQViexRoiGw?=
 =?us-ascii?Q?rlmBLtU0xuowGKZn4CmLrQR8fOycnX8OkxCsSk52ADE6EhqQ2bs+fRCDmIP0?=
 =?us-ascii?Q?IVno4V+c7eYKwMiAjixtUL8i825mC81I2RL0UCLf+lS4lF3O+LIi7QaPX/zE?=
 =?us-ascii?Q?AoTmHRsNAh38+hJ5NVQgG/NnwGV0BE5ljrqDBMPiTU4uwJ2JR0JjHTL49X9h?=
 =?us-ascii?Q?zmVmC94LGkyOxKb0XTmiFDvLcVfObyCK8Te4g2NsgqMGoEsic2iVwRB7kmue?=
 =?us-ascii?Q?Uburox4Sl5EoFCIG95NjDsGLAr3u7DEHDQcdCfEfYr2p4PGk99XaUNsrg+/u?=
 =?us-ascii?Q?shpTHmaqUbwNhtECIDWi4hrETksk8O0PqbIUxr5Zbezrfi/ugJbFOTF3CSRP?=
 =?us-ascii?Q?on0oTiJV5A8RHFzLbGKBlKGKwYiVaK6fA6DRZ+fCFJdAFeLvIChQDdP1plTw?=
 =?us-ascii?Q?raiVTvE1Hryv5oxvx30Z4gMX5PdaILAaVQAc3Bu9hZ0ZJKuJKzPJ0+91+ILl?=
 =?us-ascii?Q?KbfC5y+64wLBngpDmMyXXmX8rDcT1h9tj4hr2ef4rWiP1a8spwJOP0w/7CQh?=
 =?us-ascii?Q?1j1whfsurbmPUWog2HzKdPyVPLgMFthmJAjPWdcphXXRlGiEeLZEaxdSE5sL?=
 =?us-ascii?Q?792RNhrxEAgNic8onwLv4ynDfj3lfQklaIG4A5TUYGuj4HMpLRMWHCWEdvSh?=
 =?us-ascii?Q?FDo9ONP7xTXOWoKde8R1A/WVOimtkpQbsLGHiuluiS+wgYnpFKBsl4yyJPyO?=
 =?us-ascii?Q?3eg22FdjBXZss+leQofNgRZFpBQTn0XJfD1nBODieI2s9J2k8R7foMYytqi2?=
 =?us-ascii?Q?zSfIxzby6w4yTTr8yzHb80mH7FKCDGNP/9RjvzT+m5LJQKgY37q4iaoADqfR?=
 =?us-ascii?Q?6duPjT3M7PRS2prQ2jyGrwQ2F/Cm2VZOWfN9QU6p3NUyXAkPH6v8nMiGapaM?=
 =?us-ascii?Q?y1ME0XgelNkYbNe7bUjpYWtvYZvl4vJ4IYIisNdL3oikEFh2zF65auO4K1wB?=
 =?us-ascii?Q?A/m4y92nIzYatBx49hpYFEthQv0SgD6Skhw7ThN3gTf4+j2UwdOZY+hTOsXO?=
 =?us-ascii?Q?3le0fE/JGZtPzhSJ4Nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d565b8e1-0de3-4028-95de-08dd76d011c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 19:03:38.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW8KcBHv3WUiOCJW+VvFastnAhzYq/yzuib2ZoSJ3K1VUcy+bmZZGL/Dzv1tqfUgawQ+ovup4Yw3/bRRMfERMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

One minor comment, with that fixed.

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Masha Gr=
inman
Sent: Monday, April 7, 2025 1:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grinman, Masha <Masha.Grinman@amd.com>; Grinman, Masha <Masha.Grinman@a=
md.com>
Subject: [PATCH] drm/amdgpu: Move read of snoop register from guest to host

From: Masha Grinman <Masha.Grinman@amd.com>

Guest is reading/writing to snoop register which is a security violation
We moved the code to the host driver
And also added a validation on the guest side to check if it's guestwq


[HK]: guestwq <-- is this a typo?

Change-Id: I1d5773ffa6187a961994b3403d4cde5b1641369f
Signed-off-by: Masha Grinman <masha.grinman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index a54e7b929295..6dc3896fd61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -221,6 +221,9 @@ static void mmhub_v1_8_init_snoop_override_regs(struct =
amdgpu_device *adev)
        uint32_t distance =3D regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
                            regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;

+       if (amdgpu_sriov_vf(adev))
+                return;
+
        inst_mask =3D adev->aid_mask;
        for_each_inst(i, inst_mask) {
                for (j =3D 0; j < 5; j++) { /* DAGB instances */
--
2.34.1

