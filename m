Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD0C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 13:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9385A10E61D;
	Wed, 31 Jul 2024 13:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQlVrNH9";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFA410E61D
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 13:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOy8y5UM/3Bznn3rCusprvl5osD7pVfz0ZGPBumVa31/75zKV8n6fql0Tvklan/t80wMKbDIJmUtC42PUTKngyy2Xfe3H9mVhZ8Z7nN2nxiaFSegom0FgGATPIRyF6QDfWviVD2w+DJY0/lY24p8J33BGAM9jQz+D3+8eAXLAzr2/B8KY6x42z4+QlZFSnQDp087bJcNHZqTWkNBzPxd63Mx9y2xobg/1fvRZ9yqp9NSi31egRQXx9kQK70SkewZejuAdy0IzjdQ+hQelxZ/Gm1p5G4/ga33HQFzAZd+2P2yGko00pTOcxOi5RJQkVwO3BD9oUAUBUGY5a0zDza2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GOYzR9kPjEkcfCVrPfm+Yfm/35ZWrsXTfQ/RDmw15Q=;
 b=dRic7P8pU3W2nLZehMZhX8MoRarJBUaMyVE7oSS7TjyPNAaUXQX7v9oNNBK693/TaDHR0gWv89Hti4z3JLmUkct7m6TswnUZwwpTlT2GzjiykARS0PfGOvYpDJhhsck8PiUTU+p+3WPavWPATNo/lavqtO9SXJqNIB7nZfSOY8uNmoD9FnLZq7OfHw3mDciq5HoI2JJp5FNfx5OEUnZ8pZMAB3KbevOG62DHVfVSJHtoPRcNjvvgLbL0nzOtZQWlA7qmikf81bUevnO9kfHzc8kb7Gyy8PlIkqKDoSKIO9YXqc8qgUg0ue8jApSr/kc+RUry+OhnQfrdV1flOuXFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GOYzR9kPjEkcfCVrPfm+Yfm/35ZWrsXTfQ/RDmw15Q=;
 b=FQlVrNH9Tp/OrYJ9XumPEr5hplhKRyYMhiB62lUcueAVAmh9Tqz7jDtcRSmaSo1Q7Ix/xtFUabrigreY7P3owAaIhDvJ8LV4JSwralqRfSmHnghyD/RbK2l5//cT2Gbbxg/OgVs2yMAxtklK+2nT2cxzoedGC7jdJd9TFpbFwQ0=
Received: from SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Wed, 31 Jul
 2024 13:48:32 +0000
Received: from SN7PR12MB7451.namprd12.prod.outlook.com
 ([fe80::4ca9:555b:174c:855c]) by SN7PR12MB7451.namprd12.prod.outlook.com
 ([fe80::4ca9:555b:174c:855c%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:48:32 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Topic: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Index: AQHa3Gj7DVQ8R62dXUymO+7JFXFLHrIPgK8AgAFm6+A=
Date: Wed, 31 Jul 2024 13:48:32 +0000
Message-ID: <SN7PR12MB7451BA1D84A1408F64DDA3E985B12@SN7PR12MB7451.namprd12.prod.outlook.com>
References: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
 <CY8PR12MB709977C1CC4F113D9D7FC7F78CB02@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB709977C1CC4F113D9D7FC7F78CB02@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c3c73ec7-9038-4587-96fd-6edd2800193a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-31T13:47:47Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7451:EE_|IA1PR12MB6140:EE_
x-ms-office365-filtering-correlation-id: 4a513b4f-5022-4979-f29d-08dcb1677754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+QK35uaBR8fDY5d8W3wC1LEWehw2TWaw1m0RY597QAWVRKP/uo+wX9xXmnqW?=
 =?us-ascii?Q?KpOet+V70XYNWrHopU/OzN07bkPI5IxYl87bSpzSTKTKZuN2vZqp2r5PbACZ?=
 =?us-ascii?Q?+TGTdaDD8yc/AcP1K4nJsAQICjoj+uiS/k0DtIxTSmCybRKdfUcsgLkSjhgA?=
 =?us-ascii?Q?V4149fx6HKDg0ZAlziQ13TBtTwJwgc5w+eKNDST0cEiv9qZ0vrMiwXqYrBcp?=
 =?us-ascii?Q?h2pxD3ZiPtrxXE15MlXJkiaUN6439YmZNKUvUdQ586HRUS4lQGzcbaZo0r0F?=
 =?us-ascii?Q?wxjCWlKFpJR97WDl7g42CW4dvSXIHBY6N7P4xkS/LlsCwaNbtGatEevQg74P?=
 =?us-ascii?Q?pZ0X6sd1R4lzcC3mhCLaeQMHaLaWajy2GqSl/ihsmEjX5B7WRABtt8R7ancU?=
 =?us-ascii?Q?Qe+kxFbMtsDFSmx9mOjLhFPmBREwollJeu2KJF2cmm+aOFYs4Nnn0nXzCQAG?=
 =?us-ascii?Q?oibM0QXyJ48WMneh4NwSa1TXwfaEnJxSAaqJZSTlB3Ukb0wBpynrQQq7Golv?=
 =?us-ascii?Q?7V3fSJzivMaHyWaW+1J7z3W1Kq/0nzIxPqBiQSZtG1tm4515EpZNzOsuLhln?=
 =?us-ascii?Q?ZOdlQ6Vi88D9a3eBzAuxEWr4DmGM9hRKviz4WOit+iVtOGEWAkycJZfrM3wM?=
 =?us-ascii?Q?qK0nZP5CLzzuqJjoGmqnCR7qCuYOcA9vJ+c9TBdeOOD6fQFHM0sKOMLQPJl0?=
 =?us-ascii?Q?4FpiE/xn1sDmjXVnQ8a90HmUfhuIUaPDJG9jcgodNXcXQe9kBdKIZPExvfq1?=
 =?us-ascii?Q?mqPPf3DQEvPMmZySCGo53uhJBp9fhgnmhe0sDDHjEDGaYE1sg8YfRCFGkKnB?=
 =?us-ascii?Q?fOHffYpiGgDyrNxKTpwmUR4IA7U6bDgWUzAs0xBZiiIvYZtwrAIjcZR7Oxpy?=
 =?us-ascii?Q?jmbhn8nU4HUBFKGK6uvipxkOmGY2wD5GBhxsXsK1c+RZOC20hVuJdo0w3LAS?=
 =?us-ascii?Q?G5xZTF/iGU6lhV0GeC631stfjxq93nVvqh47HqjBBRtlgnVQgXJ4mQl7sS2m?=
 =?us-ascii?Q?3cWbA71ZgjW4b1ADPersnF5Gx4njo6Wm2bb+C2lWQ7yVYXr2KQbECw9xonEt?=
 =?us-ascii?Q?ZvFkMbjmVTKc8es+D64JtBenX8HpXM7XSqWS65vT7s5tv4wdcg+B/RdAdvT9?=
 =?us-ascii?Q?aIYWFzGVTQoeCVzZWn/1Z2m9nAqx79SplhXVb/dU3x70vOGnWlgU6VBlUgo6?=
 =?us-ascii?Q?MJ+K5RGPn3Jj5kIaSTXIg2EUUEFn5wx2FMTwSnI+QlpJ/N179elLhPvfNAxS?=
 =?us-ascii?Q?fAx0tdW+zqTIb4+qsh3iSQ0k+MMTSq1fO4efs2rLYq361zSIRzslLxIPXyHO?=
 =?us-ascii?Q?VFZAD/OhpOCcfozBOtY1lJVh46COMinNTkRdkLmb1fjORqOiwTtQiJwLoFyG?=
 =?us-ascii?Q?sSwRT8xlsswaJsYvm1eZh/e+olxICiUiaVgoC5lrz9AsREKcmg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nqeVIlaNuW8BtYAybiyBYwB8dIRJHsRbAkUdpKnzDHfTv9XDjXmbVcY2gJBb?=
 =?us-ascii?Q?bwfuuD3JFQln62MdyTBQitd6C1KBDnaODDFDsDeuxga7eH2Kz2ywbJBTTM+I?=
 =?us-ascii?Q?xhcEH+PLmQFF4rxmbHz87wRz2c3xM7NluMyvncoGM/dDXBhAzTuMPW3jHcn5?=
 =?us-ascii?Q?ElegYfxFj3gRZKoqZoFjXhAFcypFSPUaW+zElWhcVSsgawDGRYG8FpOLsdGW?=
 =?us-ascii?Q?50pwB2JtAKMAvGlzK6ugm8BQDAiCgTw7Ec4F/CKvy8lQi57yWtNDSLFw5Xtx?=
 =?us-ascii?Q?a5JFO8Fhtg9+tJj90QK7xrmENYct+rdKWnsPurmxhX78ixm9U6XiLBBxho9z?=
 =?us-ascii?Q?Fj7/BPUx63st4KtM136hV3ew9x58GGL6aQ03odec7OOfUMxFEjG963nrpZGL?=
 =?us-ascii?Q?bpPvqg7FY+I1aCoqHRzK+xjXmxSwiwrb7/q+2JNIE0eQJToR/sHHbBrvSBzI?=
 =?us-ascii?Q?v3PRKIp1pdMZhFHBBxoV9zJHbOaBycjDi0xZ2Ez2Xq+7TzuzaWWu5F0Qn+59?=
 =?us-ascii?Q?thzQyfEpCgA9D9o6j2H/BM8Oc1LxnSH72UjO+Guyvc9KEmlW7/QtVCLVK2cO?=
 =?us-ascii?Q?UTkLpxWZg5I0R91g9NFp6tena6A9Dz0p7g0kVhSe3YZh+a4pGqSl3q6PDgOE?=
 =?us-ascii?Q?8UzYRDTV9sXsO2nyYhV8PgrNUmHcZQDGLHp5V+y+GarB/ltZkdrTq4lFw275?=
 =?us-ascii?Q?FtYjE/jQQ6NOrSV8KKiQAFeYOrWBpiuQDr8tPG2QDZLOn6XQj2qiz1lD/gDi?=
 =?us-ascii?Q?v4kW6EeLzAuF4lDmBLpZe8xb4ipf19C29vBTmQvTXyl+8DENDqL2aWJ8qQ9w?=
 =?us-ascii?Q?XpR4eHfvNbjgGlgN5WtlDjl8/pCorfKNvs2H9O6vXPH9R63znyxx9X1TAsXk?=
 =?us-ascii?Q?99uuU+bNAwCDeOqgyq6WAGZ1t8Jkx02rMui0oYY6yFHhrd6l8uratKxb0X2D?=
 =?us-ascii?Q?2gOzT5FxZ0L/j9pC+4D+aQNChXx8BcmfCVTUcl5pmSO3ecMCLMmp3IdJZFo0?=
 =?us-ascii?Q?lxxXtqBO5rPTDsZTyU0AAy4/aFJ6QGhaPqb2JV2wG8MgVlBr/rju00znUgDK?=
 =?us-ascii?Q?0Axp77tx/e+kcJTh9JrG5RuQh8xp8vYjmHR5EEAP0LVd9NUsPceBtECkaOZ9?=
 =?us-ascii?Q?jVPaozr3QiJh2VNTwvzb12xKF/UlKRfmFTpZ0kgm0MCHKjh/nK7Wrg6q0GJ7?=
 =?us-ascii?Q?0l1oQFfxSDVERpFlmMYjx+boUzkRBhUMdKgjoPhJFzIusQStKrD6iOY9P20d?=
 =?us-ascii?Q?BtAeEBs0P/Pf1ob7COMoSTcvmsvYvWLXPxq+gK7QuvgUmNRMJxvUrWP9VvFb?=
 =?us-ascii?Q?YwiIfd2Ed6Kjr3sr9Gp2TywSP846XU6UO81esgJ2IgS1mmKXwhXtLc1kKKlo?=
 =?us-ascii?Q?8KfDgSOj4DInuowRzQgZumoc6k2SEqJjLZcV9uA0DNOTaDlTKLUtLSUt21xk?=
 =?us-ascii?Q?te1I81bU7IcTJ7SbdtdIM3uRkmzni0C04CmziFCuPY76o8Rqf2c3PZByTpCE?=
 =?us-ascii?Q?4/pAaesKXQ6VNEmpx9ylcr8aJTF6KNujdQIznCtCtS8ZgnytPS4nidUTw0dS?=
 =?us-ascii?Q?h1JW1jJAQUGzJ9Oaa6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a513b4f-5022-4979-f29d-08dcb1677754
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:48:32.1076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5RUb+wbg61ccYfCsezt/bKNf5VfI8opa+zIYP0f+DbA9OSn3OkNB0ql+3Yv6LjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, July 30, 2024 12:23 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix debug watchpoints for logical device=
s
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> One minor comment b. Either way Reviewed-by: Harish Kasiviswanathan
> <Harish.Kasiviswanathan@amd.com>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jonathan Kim
> Sent: Monday, July 22, 2024 2:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
>
> The number of watchpoints should be set and constrained per logical
> partition device, not by the socket device.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c  | 20 ++++++++++----------
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  8 ++++----
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 34a282540c7e..312dfa84f29f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -365,47 +365,47 @@ static int kfd_dbg_get_dev_watch_id(struct
> kfd_process_device *pdd, int *watch_i
>
>         *watch_id =3D KFD_DEBUGGER_INVALID_WATCH_POINT_ID;
>
> -       spin_lock(&pdd->dev->kfd->watch_points_lock);
> +       spin_lock(&pdd->dev->watch_points_lock);
>
>         for (i =3D 0; i < MAX_WATCH_ADDRESSES; i++) {
>                 /* device watchpoint in use so skip */
> -               if ((pdd->dev->kfd->alloc_watch_ids >> i) & 0x1)
> +               if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
>                         continue;
>
>                 pdd->alloc_watch_ids |=3D 0x1 << i;
> -               pdd->dev->kfd->alloc_watch_ids |=3D 0x1 << i;
> +               pdd->dev->alloc_watch_ids |=3D 0x1 << i;
>                 *watch_id =3D i;
> -               spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +               spin_unlock(&pdd->dev->watch_points_lock);
>                 return 0;
>         }
>
> -       spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +       spin_unlock(&pdd->dev->watch_points_lock);
>
>         return -ENOMEM;
>  }
>
>  static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, i=
nt
> watch_id)
>  {
> -       spin_lock(&pdd->dev->kfd->watch_points_lock);
> +       spin_lock(&pdd->dev->watch_points_lock);
>
>         /* process owns device watch point so safe to clear */
>         if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
>                 pdd->alloc_watch_ids &=3D ~(0x1 << watch_id);
> -               pdd->dev->kfd->alloc_watch_ids &=3D ~(0x1 << watch_id);
> +               pdd->dev->alloc_watch_ids &=3D ~(0x1 << watch_id);
>         }
>
> -       spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +       spin_unlock(&pdd->dev->watch_points_lock);
>  }
>
>  static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, in=
t
> watch_id)
>  {
>         bool owns_watch_id =3D false;
>
> -       spin_lock(&pdd->dev->kfd->watch_points_lock);
> +       spin_lock(&pdd->dev->watch_points_lock);
>         owns_watch_id =3D watch_id < MAX_WATCH_ADDRESSES &&
>                         ((pdd->alloc_watch_ids >> watch_id) & 0x1);
>
> -       spin_unlock(&pdd->dev->kfd->watch_points_lock);
> +       spin_unlock(&pdd->dev->watch_points_lock);
>
>         return owns_watch_id;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f4d20adaa068..f91a9b6ce3fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -885,12 +885,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>                         goto node_init_error;
>                 }
>
> Wouldn't it better to initialize node->watch_points_lock here.
> spin_lock_init(&node->watch_points_lock);

Done.  Thanks for the review.

Jon

>
>                 kfd->nodes[i] =3D node;
> +
> +               spin_lock_init(&kfd->nodes[i]->watch_points_lock);
>         }
>
>         svm_range_set_max_pages(kfd->adev);
>
> -       spin_lock_init(&kfd->watch_points_lock);
> -
>         kfd->init_complete =3D true;
>         dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->ven=
dor,
>                  kfd->adev->pdev->device);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..653e1f934107 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -310,6 +310,10 @@ struct kfd_node {
>         struct kfd_local_mem_info local_mem_info;
>
>         struct kfd_dev *kfd;
> +
> +       /* Track per device allocated watch points */
> +       uint32_t alloc_watch_ids;
> +       spinlock_t watch_points_lock;
>  };
>
>  struct kfd_dev {
> @@ -362,10 +366,6 @@ struct kfd_dev {
>         struct kfd_node *nodes[MAX_KFD_NODES];
>         unsigned int num_nodes;
>
> -       /* Track per device allocated watch points */
> -       uint32_t alloc_watch_ids;
> -       spinlock_t watch_points_lock;
> -
>         /* Kernel doorbells for KFD device */
>         struct amdgpu_bo *doorbells;
>
> --
> 2.34.1
>

