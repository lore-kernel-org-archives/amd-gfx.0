Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF93AC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 04:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFBB10E681;
	Tue, 14 Jul 2026 04:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svbcs7R8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DFE10E681
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 04:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px3QuYD8emjbrKAse3ML9evRv9zLcihwfLcwkklp87hiLSDUf81f1swsSeNmye6IfzbD0CUdZiUZNpTiGO1QOrRhDMZtGwFnIfxUazZy1ZplJ/JJUcdjpb2wHbzJmrBDDFgQ9nB9WRiUtAi/7xK6Er2uoUIcw/ICW2A1uwfi8mDT1WrJXBFmCIot1tp1V+Kiv4XYPAEPACNe0bhywnn0aACGEY7jBwrAXgra87WNE51uLqm92yMiW1g9LIhrRrw2dUBX1g5o6ELSWBcfxWieuaI+zaXvMPHJ+Rjyeb7G0DG3zEvcuSvtXS4j+hL78IysjY2Z6abadUW/U1q+HgJJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvqE1M45+Rk+XlM2skoTq3JyrnDENawl/GIYMggexEk=;
 b=heJ0ffFKYopW2eY0sw4jJOto7d6zm2c5eRGw5hX87GX13hxGufvm2K7/PT/mpJNnTwDjc9zuyvkXAd8cd8LEMCuS6e7sIJPqDHxwdzn/SzAqAkoHLA86RKXowUz81DXt+rdT5I8dngU9lf/5C4m0TyhakbiHnThjdgOuwPC7sKuCQm5Zi+HsukUqaUZd585Y/KW1pD/I2xDjjbOCYVwf7ey5UKmOYybt9f71vO7NbbLB8ipMHLSikXUZDg+C6Osui1U2BzjyNarbPQi+pjB0JeXXhYMitoKkcTKd25MK8r7h1dRfdFp3Y6gWWsM4z2pGRXUb9laJ+pxspW7njGS+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvqE1M45+Rk+XlM2skoTq3JyrnDENawl/GIYMggexEk=;
 b=svbcs7R8DUE0gPKi1JoYYRUk8S7AAU9n30vfnfcWW3l+Hhbw6PabUBi35t+SFF/enjEakLLt2wnWDLEjL+yA0dN+375uSMkzxOKo9HCtRfrtw9JrGlogeSuqiwZffB8/tHViBBMNX2a/un0FOgXCbIxkwOivWBREn/3S63Xq6+0=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 04:46:22 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 04:46:21 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwemLj48Zo5+FEGWvILeBy4uu7ZsZOoA
Date: Tue, 14 Jul 2026 04:46:21 +0000
Message-ID: <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
In-Reply-To: <20260713203850.650426-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T04:01:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BN7PPF0D942FA9A:EE_
x-ms-office365-filtering-correlation-id: 38bd2257-9900-49d8-29bd-08dee162da4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: K3RcfYBKP21LSUR3Ss2MOmUvSbv5+AI9/nJJOH0xs/iOnKMC6aPYeVLvPChrWpBok72Rj8n96lvo2ecrTSQ+rxATcp0cwvPfWtQIoQMpZVfB9WGBitl/IMiQdNsmx4DbCjOPRl0tkpRBAyu5IMT8bIQq8jN0a8OHD1ZJ47fowbp2MSvxcC0II1mcmkHSCwgGi1LD6J+2Cyo5WBU7nc/fIBh4+qzSoO78EtQ3H0FS4FAGC7HZtteHdNscxKg5ObCIB6iRR0T7jeGQkgCqszcCoBk60Lwb+hOqTFELA+A3rSsvL0seABSgOEHOgKSuyHCfFdgXpuOfljEELkusf3Ggh0fRwttOZnqMnLy1tVh5cv+tnUM/gqE/UtDG3jKSF5NaO2d2+z/Tz/6xS0R4rnIvem97wf/z9U6cA8uqGvZoPKafPO6hBku6kfOZxmkPotnvFNtOAnT0JsvIhZ3Y9GlBP75CDLNMWBPu6tVR3btF3BIAsVvClYWVGFBhDiQZ7ohQld7R6N0g8tlaFcGGw/bIfXjTsbhV1cKcte/ChBRqzmG10lVUYPx9mQH5iCR1rNfoGDfwNv0vhGoD0l6Gt/kFltWhcQkT3N9hZpSpoLiMAzt6rGvMp2FKIftRoTiwnsJuCdbJqK2FnRLGClGMLDjlbi7DnABRoQeGlXSvMCIRurkB52J0/96KswK9/VUVdAFIGSsmnRRSG/W9CTTfsLSNH4tns1e0za6QW2huaTVybTM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XdjJsNjzmhvnh5EWs2g03XZKVteJRQXbkfVRyXfS6MMS1Mpv/ZIW/oJjXOSn?=
 =?us-ascii?Q?wIka2v0LZkUgShQ2j5742Z87eXaObRc81zWjYd70ODLZjQ6bQYzMkP+kyeiQ?=
 =?us-ascii?Q?Xgn3lYgYpNu05t/YGVsdbhahxtpP7Xq/+GaRnWXb93n/ebxhtljnT+dSGaSO?=
 =?us-ascii?Q?6YUUzgj7S8bNxyATL0UXTvw3CYGpDjftMdHJ+Yb7ew1E7ioUXzCOG96rBgHX?=
 =?us-ascii?Q?t8IEtmcXPUBsJO3VEGeTWFfjBhKbUiKCsKn5C8mmSZo0bXTmQUs0G3JVrV2O?=
 =?us-ascii?Q?OcGFoW0z7U+G5s2Y3PhtLNKbu0uwMCtUzESaOCCCCorkYpz8TWlc9NkFPQmr?=
 =?us-ascii?Q?bNdaI3XyZ8+djqC0gdprdzz2DwyrRIfgMOrLHSL03RoLNw1pXBAOLjuvv6cd?=
 =?us-ascii?Q?XREMq6k8INqrUHeFgoskgOwTcgGChClPtTecb5RoOlo5aD7HIpr4mWHnIHra?=
 =?us-ascii?Q?JJ47nnnXd8Irer41adCyuHmDY408klkMjL3P0vJKhL3dsm8HHQfRkfoDased?=
 =?us-ascii?Q?cFr75jGpax75QZhz0qb3sZAYg1OibsUaQrUHDbXiGI0I+WybKQI91rRCy5d7?=
 =?us-ascii?Q?Vq3l93fH09LSNcJ3EqyyfiqU5T8AD4RTa11s+fO18gkcdXwL1Nc2ArdRMGmR?=
 =?us-ascii?Q?AxWN4OFcqiutjqZMw0YTIRHTYlL8YwsgIuMz3vn8lfD5jR6o9GaA5gE3tAMK?=
 =?us-ascii?Q?GSrd5qQxJrsMxrOrOUf/AlSz9bTyIw+QxgqY6feU3+kWgToNh2fx8C3MiMN4?=
 =?us-ascii?Q?y99EFbhctAL64JEIrtlwluyk5L29ftcZaNbJjR/FT2qjgVo/VB5JOeBvn2D/?=
 =?us-ascii?Q?+StSPG0GzDkidHtwjilOoienLjwq8QcEnuvajK2nZvdu7IlcQcmTaZ9VGbGk?=
 =?us-ascii?Q?aOMUVrzp4UO/gFArIOa1L/qWDcV/wH6iu8EhkD5vXNxvrfRhhd4gjt4Mu5we?=
 =?us-ascii?Q?qNEswTngnhlGcAP1ZvAthb3WMOv6X4ldkj0noipFNFCtpIokLcpDq50WKQc6?=
 =?us-ascii?Q?7T8rgT9JbUEDB6zuxHb1526g/l7kdpUw1Dz9K9hawOivEd2n1K3R1f6yKYhY?=
 =?us-ascii?Q?r0aNFbsek2GP2hK2rIf8+omFNZELo10JbDuAzS7domRy3ojvQkhjGNyZhbQz?=
 =?us-ascii?Q?1f37kcZauj9xZkYQasSgl9tjwMZ2iR07ZeTs8WEH6OYnNiDWtOBV7KUaVCxY?=
 =?us-ascii?Q?Xr+0XncXwFRSSD7ZoYCDJ/0PBCsfprd8uqT/VoBhw9DQ5CqSVmwXSzliaNvj?=
 =?us-ascii?Q?pgQAQxscpNaceod1tAE14/DWa8eLYXXYR8hvzAdutI2NDrJMa62IFOXiH0jB?=
 =?us-ascii?Q?3bIa06HZe5pGVYW0DxMjZRSAx7lxZPwDY6EY2AtT4eak+LdZfsNXM8YaosPQ?=
 =?us-ascii?Q?GlA094aUBOJZnPQsJwi+Q0edekQNqX6V8HLiLxq6MFRQgN1Nvwk3tmjdjm3x?=
 =?us-ascii?Q?fTZxWqUqxoKwQeBkUBRWGhlEvfJjdPG0IQweQlawG5FtJeQ4rj9osgwX7Bdl?=
 =?us-ascii?Q?nk7M38H29uIAdHNvoJ0A03CyJ8HDY1Jgxc1LzHuG8jGJvvUt9EdU6SZ0EJn8?=
 =?us-ascii?Q?Qf7gEH+o+ivoL73dTiTrT0haGCfhBovSKQE+HbAR113r8YNqZP3MU1JXYeWI?=
 =?us-ascii?Q?eq/YQW84igw8SCW0n7w8/FRmi5MnmkRDjJ3KXNnmLGkkJXIPgp6UrUkbJeKV?=
 =?us-ascii?Q?EIyqTqTNGHP2EXy+5PCbxev3oVwTsFMWogS8zuqAAjI0dp/8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bd2257-9900-49d8-29bd-08dee162da4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 04:46:21.8112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTbaEy8oi68lbAK9n0SF+lliWsH7GkUvl7Ls7R/ySxYMeK5o5v23KvxOxUJCVqUVwVAtZWDm2dM7rDhBcjgDDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
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

AMD General

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Tuesday, July 14, 2026 2:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>
> We need to increment the reset counter, force fence completion, and set t=
he
> wedged event when a user queue is reset.
>
> mes_userq_reset_queue() handles this for collateral damage, but the calle=
r needs
> to handle this directly for the original guilty queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..5e1262636e1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>                                                        queue, NULL, NULL)=
;
>               else
>                       r =3D userq_funcs->reset(queue);
> -             if (r)
> +             if (r) {
>                       gpu_reset =3D true;
> +             } else {
> +                     atomic_inc(&adev->gpu_reset_counter);
> +                     amdgpu_userq_fence_driver_force_completion(queue);
> +                     drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);
> +             }
>       } else {
>               gpu_reset =3D true;
>       }

After the original queue was reset successfully, it did not update gpu_rese=
t_counter, complete its pending fences, or send the wedged event.
mes_userq_reset_queue() already updates gpu_reset_counter, completes the pe=
nding fences, and sends the wedged event for the other affected queues,
but skips the original queue because it has already been reset.
This patch adds the same steps for the original queue, making the reset han=
dling consistent for both the original queue and the other affected queues.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

> --
> 2.55.0

