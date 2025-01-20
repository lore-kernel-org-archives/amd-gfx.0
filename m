Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E99C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 16:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAC410E442;
	Mon, 20 Jan 2025 16:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rdNse3B+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B39510E442
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbkq5ogXQBvWxJ9vD1XKz+i6jp581WKU7NxhoZM77qPbO9fAFiXHYARrfLmNev4GazFUhKuUZ40+DYomSO3wez6exjGLWlwrwqImpxurqBu1A/DGxUUVdGYPLQAOOPSjv1Oyhdit2SVPi6rZLeOsaHvbiRtWV/yx8YqgtEr1yJO9oDL8vyoHtQVXOeg7oTlIEkYpgu+ZgkF4xjuKNzD300Q0m94W7D0vPlJ+eabW6gZPs5CTBlf/Wta2pIxUp3ndCTSTxjVQpSI7c/3eI3ltBiSCeqHua/6nIpRKXs1L6gWUkYKhtYFE8N3qYLdk29U4+urr6NOuEWtGu9FdlCZxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ch0IJpbhXPw4bymUZodzdDagGjupgDQAF9PcF6ivec=;
 b=IXuizq1JrevWF/GaGpc37KgDPxaPY+EfRK0meTt4I30UPVvnml3i4GeRgTKYn17V27jSo6vOf0ojVc2WV0c9g4XufNtXMK19PWMi93KkPuKNuEp/ObIHJ3/hwCWAwcnX5ZTACd5u7crtvqV8fxXeV4HCSvV708hD6XfZBWMBVFCnlbb0+sxl1ye7JtJNGAoCW1l1ALyh2cz2L5RH5EUUTnRrJ/RFxwbrgK4yCf3GUtoRFpQ2+XuGTBiWeKLUsY5YauC4PVi1KW0sUz2pLMhAR7xV5CbIjOJ2Bh6kaX2LkwIHoAiNjPCS59N0ZnxW+EOBonFdutsV20paWb8a4dmiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ch0IJpbhXPw4bymUZodzdDagGjupgDQAF9PcF6ivec=;
 b=rdNse3B+Gx7hb/hMPDaFL5OKlmJ1MfwiPiLbFJT2WLGHrETv04Scr14WBjWpKqM+fl3wmb5m0R2Tp9tpiA/TzjpprM05Akenevin17HBd6fT5AxjEU2NgmbEJvhP5rUebdnRXkpd4mng9O00956mwLSpGMqqXglX+YSjYsS/Rdk=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:42:56 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:42:56 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li, Sun
 peng (Leo)" <Sunpeng.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amd/display: Fix error pointers in
 amdgpu_dm_crtc_mem_type_changed
Thread-Topic: [PATCH] drm/amd/display: Fix error pointers in
 amdgpu_dm_crtc_mem_type_changed
Thread-Index: AQHbZ3AVAiRaJz8HGkW/FlPIMUQMsbMf5LBQ
Date: Mon, 20 Jan 2025 16:42:56 +0000
Message-ID: <CY8PR12MB81934188FC0342F20CCC96D689E72@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20250115170728.2561339-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250115170728.2561339-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=432f0b75-4385-4601-84aa-d79095e98b65;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-20T16:38:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|CH3PR12MB8911:EE_
x-ms-office365-filtering-correlation-id: 6d07ea20-4485-4320-469a-08dd39717de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ECEVJkE9b+8XkSDIcsCj+OxOBVuMg9rAvpT5pQxWgwP7ivmrIxJcVKLk90aE?=
 =?us-ascii?Q?GizpEIOsZOJgM3OAvN/VMrigiBsCK7SGOncjz1s4VOyL26AGGK58LLiFxvPb?=
 =?us-ascii?Q?ccgraMtmydfrROPUbqJib5mfnuoyXD688vQpV8vVFYgBxVhKsZc8ZnGvjh8e?=
 =?us-ascii?Q?tHCSfdvd6u1idMUVM6w5UZo46rxsBgUJ8lJriO0+pw09VEM/FXAjiHDCLFuA?=
 =?us-ascii?Q?djts2iUZuGj6Kx/nf4CCw7IUXalK7UwxYXqpLx80e/a6q6sHEbB1IMkao4YI?=
 =?us-ascii?Q?FPpUlh0WpWa/MG35Tm470PHh/T6XvZTpk7hNszyCUdAdNhPFzevn4sar9oR6?=
 =?us-ascii?Q?MQqvfDqni28OkI+WZ1BC4j92npBta1S28AvanQ/ZPiMNZ9HWzQyhiefUzifl?=
 =?us-ascii?Q?9U2HdiC5OTPQo+bJyegd9F3T5KurFGJsKqd1H4KKTUXEVqiLGtWkQeQad1om?=
 =?us-ascii?Q?pjNaswmwJVsuE8ZRx+DT+3xeRlKtUnueVcyWE4yAQxTleAOSo00/KlVMIVfk?=
 =?us-ascii?Q?aPu0iy8XS3Ysi+EoN3nJQk2D7FENpRrTz2rrYvqXxfk7dOq7+BLWTlw9JiAM?=
 =?us-ascii?Q?uHOq0dhVsuNEOxEUQ4/mk5Rcj8kwy/kyp/xnuFvH6MlukfZS7O3+ho+0zH8/?=
 =?us-ascii?Q?aPR7/Ev52wp8IuLaV3fld5bEfxVeJa8SpF+R52fqRAjdJVKbGJwU13gwExks?=
 =?us-ascii?Q?t1eQd5aboEIyOR+1ToQ8lWdypBoITdIU9PQZuoHuIwudzb58wuFLigv3cK2Q?=
 =?us-ascii?Q?g+Y+Saw72mIztUMhqIabxuVerVwngz18KQqcij8mhkPPJAmFbd7BLnZP3F7Z?=
 =?us-ascii?Q?uOJIHS/FiaSoiNJMjWfPhHZw4l0xei4UjWAdI0K80yTdbQH0ABgxbzafKxAQ?=
 =?us-ascii?Q?uiDHDq1klBfJBTs8OkvUc6Q6BfOPJL9PxHdTkfwWSzscy7v+7xqbN7lE4ItZ?=
 =?us-ascii?Q?wf8Qxj1YTWaQKmvTwxrs8QxVW6Sf9A6SIOLE2yCioE1TYeJXY4cbZBJ7lPSs?=
 =?us-ascii?Q?oPAewBEsU1UxOCYYq/XhYOSFyyM3iM15FjS8qHkJKYfgIwnaCQV4xXCAZKG/?=
 =?us-ascii?Q?6cFg47Ak3TXKY4abKzObxkenocR7RRVNk3XcQAs4xFFm6pa/MsFPWiTda+Un?=
 =?us-ascii?Q?Zk5ip6iAdHDRAKuKCDge8pvJ72iZRqkVuV7oNl4VgORbHOnigqjSRaQjYV2K?=
 =?us-ascii?Q?B53Weqfq/wt864rJ5WQVb1GWNtx56Br23iuZ1tSU/9XKu5Zh8iDOsjvNCDF+?=
 =?us-ascii?Q?dLHGlr2rqQQtpqsTrdiOfkoX8eYlobLRMIrAoEZ/tkG4dXXmzOxUUTVwCTIw?=
 =?us-ascii?Q?QJklzXSuWqla2FfZclMCg5H9ltt+BPMM7eZUO/apGaaE76rayzpIje7EUy4U?=
 =?us-ascii?Q?xqQ+nx7JC4RbqgUOodpDNCd0/L0pNABk2+R3HVzS8Xh8qEY/x/H4AMk5UmSA?=
 =?us-ascii?Q?j+KyAAi31pCoq789Pje6INAk+1cwP+AS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkATR/9Eiz1Pvh298ImgXBZcT9sd/p/s5AbnICqVcUb0xs+U1hhjNvdwmRd9?=
 =?us-ascii?Q?e70Gkk7zhxjUpW+5C1mQvgtsBePn5rn6acp/UohJN69Gt2LX/O1qZmG9E3iq?=
 =?us-ascii?Q?aSWgHGRHSU2609RQTEqmwSVhJyz+Ol0HwBLapoINCtIbkoozrkwta8WC4iJr?=
 =?us-ascii?Q?+EPB6fzQaFc/8tGSXnzwnAlSWU57IYh7iWCiDwQbCCFY/m80WoZ8jYPMTRhx?=
 =?us-ascii?Q?iCWLlN1hDVdDR7Ozy/8GlHv8jFthawiR0+YHHQwYAeWOP/3DcAQC7uIaFt/b?=
 =?us-ascii?Q?WMLquymc+ULSx6LXn/JOvn59hXIc+u69Xo7pURk+rRfT6cDM0d+jl37ok0gb?=
 =?us-ascii?Q?VcN7DQnq57rcYZCemkR32Qds7s0PZUya0AZ7LmgiFhjOV6BECwUl3QviAOdB?=
 =?us-ascii?Q?fymHOaQCjKPftVSAPRZBorOOHREXaHQMl/29NwdO6ugUmBc5jMvEohJd+pwd?=
 =?us-ascii?Q?ERuqQzmKkIrFrMY4/mVSVznAftEtHv32BufHt3YKFBBPYK9Yu/Vd5zOoEnxj?=
 =?us-ascii?Q?ABjkMRuKNIdchUJSxjaXCZFas8Y8xFw0DvVGfC4quW05fWEJRVDdN+u4iLV1?=
 =?us-ascii?Q?XAUjTnPBm+5hDE6PGY/5W6GnZnmT9kp2YC326SHRVybmKlHuajbb64VSLFXo?=
 =?us-ascii?Q?y2l9iaQQu2ajAGLaeZLmk4LOYkOhhoOvWKIG//lY+tfzCl99kZtKf80Q1Os5?=
 =?us-ascii?Q?Prwf72txanAUcbznWl7BbZmvF5EBMvQOFrRuIjqni9sm9C8epkOtim0OHnhc?=
 =?us-ascii?Q?GjKerQGJ08WLfuum0z6iFRmBPznl7BitOgH8VJBOuw5k2Z9PKNoU1b8XmxN1?=
 =?us-ascii?Q?VBxX9aVvrETcOF0mTq0UqG5nbyM8hA9P+0LbgVdMbvRMP3Uk01lZUryqEx6A?=
 =?us-ascii?Q?5rk86gUSYZ0M0+cTVvAgHBMMwXcKnK03AuELje4GinQJxDmlOXA2ITA7hT9U?=
 =?us-ascii?Q?tV6YxAsMYPs+IeX8wREeOLN4/G5F8VxJXuJPugdiKNjJJBC2wVbUMA23JfT+?=
 =?us-ascii?Q?sQCvgiQ0ueqGW88hblSDpZ/OECO8Veu4liyISkv/2uIr4RHaOPsa5aoqiGEQ?=
 =?us-ascii?Q?Y9EKX6Mi7Hxg+0HtqPzJxYEnkwJMAtV/meUvaO2CiTlpKhSLEn7H2O5RCP9Z?=
 =?us-ascii?Q?tb+aFLsbg6snIn+jasuTV5q7KAIc5SeJygMEiuO+ewa1BGdxjbuYgEZPANTP?=
 =?us-ascii?Q?EkhxtfnOiTdqDyYoQTgMHmk4MzOMNylmFrWKhFPFzN0ca1ZaKkqctuE9ftJQ?=
 =?us-ascii?Q?Sz2leqLBd6WGJlP2+9+lggAKVA5NpOPBrUQ8VoOZ4Z2LToLTzwLrCq2SVI08?=
 =?us-ascii?Q?al1pS7Gucx4bvUe9iS+NXNwjG7J2BFejXt9g6jzXrzUKjatG4ZXcBztL3hJh?=
 =?us-ascii?Q?vUkwTZWo+hZ9+33Mv0p6j6xdHamqdO5qcIz4Bf7pDNhPXsURFzOF8oLI1NOg?=
 =?us-ascii?Q?C0RPRNyFdd3zMkdGYa06PjT3/7EOO3atTwHfuTmZPFF7vyCpwpV8N4l0oLcN?=
 =?us-ascii?Q?bPK6wbLeySsY3KWIy2GQyoNPONkyeYbUON5cuUJAPHssMgaw8MVhup71ZGAo?=
 =?us-ascii?Q?2wBD0FEDEnNkuUseUxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d07ea20-4485-4320-469a-08dd39717de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:42:56.2986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X89+5IfdHrJPQimMNdqgtkE8yHMVXD8lZSUg3k/3i961qYI3rHrWuIMFRR7QruKw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, January 15, 2025 12:07 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Hamza
> Mahfooz <hamza.mahfooz@amd.com>; Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [PATCH] drm/amd/display: Fix error pointers in
> amdgpu_dm_crtc_mem_type_changed
>
> The function amdgpu_dm_crtc_mem_type_changed was dereferencing pointers
> returned by drm_atomic_get_plane_state without checking for errors. This =
could lead
> to undefined behavior if the function returns an error pointer.
>
> This commit adds checks using IS_ERR to ensure that new_plane_state and
> old_plane_state are valid before dereferencing them.
>
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:11486
> amdgpu_dm_crtc_mem_type_changed()
> error: 'new_plane_state' dereferencing possible ERR_PTR()
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>     11475 static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *=
dev,
>     11476                                             struct drm_atomic_s=
tate *state,
>     11477                                             struct drm_crtc_sta=
te *crtc_state)
>     11478 {
>     11479         struct drm_plane *plane;
>     11480         struct drm_plane_state *new_plane_state, *old_plane_sta=
te;
>     11481
>     11482         drm_for_each_plane_mask(plane, dev, crtc_state->plane_m=
ask) {
>     11483                 new_plane_state =3D drm_atomic_get_plane_state(=
state, plane);
>     11484                 old_plane_state =3D drm_atomic_get_plane_state(=
state, plane);
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^ Th=
ese functions can fail.
>
>     11485
> --> 11486                 if (old_plane_state->fb && new_plane_state->fb =
&&
>     11487                     get_mem_type(old_plane_state->fb) !=3D
> get_mem_type(new_plane_state->fb))
>     11488                         return true;
>     11489         }
>     11490
>     11491         return false;
>     11492 }
>
> Fixes: 1079bd90c55b ("drm/amd/display: Do not elevate mem_type change to =
full
> update")
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fe75fbced027..f3f319238763 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11523,6 +11523,11 @@ static bool
> amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
>               new_plane_state =3D drm_atomic_get_plane_state(state, plane=
);
>               old_plane_state =3D drm_atomic_get_plane_state(state, plane=
);
>
> +             if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
> +                     DRM_ERROR("Failed to get plane state for plane %s\n=
",
> plane->name);
> +                     return false;
> +             }
> +
>               if (old_plane_state->fb && new_plane_state->fb &&
>                   get_mem_type(old_plane_state->fb) !=3D
> get_mem_type(new_plane_state->fb))
>                       return true;
> --
> 2.34.1

