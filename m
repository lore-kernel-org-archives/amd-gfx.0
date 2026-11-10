Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75922606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZFcvng5P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE32B10E0F7;
	Tue, 10 Nov 2026 03:16:22 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F7F10E0F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 03:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoRrBcN9ESaQf88HA6T+2jQx3cdNxIAeITR/52B6Br7zcrjc8ZUEKhDeXwf83Eav5Hge2UlauCMt/c579fQRhBKdVLfPjMmkRwEtQogiG4W3wUCgauZikG4Jo8wj7JFnKf9Ii7Dz2xA15so/brA3MVH2DYyAQnBasUKlyokSSS4gXMWDXX+pr4200oXsAA4OiXnycVMVLkLaHnPyTpYvnnLNoVWcOLvs+ng9oyTN0Omi5NuFHDJmEpfrisdha1SyP97ibuQh1IjngqEBF6kktn3XM7sUHjjn9C4FXHWTWoOHFMIl2xlP3sX8I/wPfr1g80jldbvIa8G5bpQa/PZnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H3Oh3SWDwEIMMqFvuyz6/Huqa9UIndO9CPmCcHw67A=;
 b=as+EZ49nailer5wU+jsRtupwTyn8GURmP/kxtlnwygi0qsefyHQJ6YZhFkteF8No1ldOHqL5WqdMZigY9JJ62W+33qI8ZzFZCmvsbGfg4xKqISQ99JDQPXcDXIfbn/WzwvzOM4j/SIcWRL5QtjxHPsMZQFu3N7ko/LVfmckOcNN0d2RjtWgJlJbA92tNomI1qY8rye4WMXNbhqt8MVAtuNbSs5RlU2iEIuNp7jtEPDDKMVwcM11CJMyy2smTjzwCSeqg7BuhCF+py+UA3nqMZvW6cb2qg+QNXqtrX99EUJiuLa7TjyMpQ9v9qEqmIEIhD1XY3SDI4l7TeesQCjR69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H3Oh3SWDwEIMMqFvuyz6/Huqa9UIndO9CPmCcHw67A=;
 b=ZFcvng5Pnp/EiUMKxq6ElWGjsuDffdSF1M16cPWX3kH5ledzVDCjHBGmuFFvrx1HDeVgecTnB8hNmlbmaZmvLvo1ow6imvEpWMH3EEszERqRlX2MbIS4E2OEepHNaQ3cR0bA4arRjpthewCukEnfpGZxl2iMsQsIxAJvWxVOImU=
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by BN3PR12MB9571.namprd12.prod.outlook.com
 (2603:10b6:408:2ca::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 03:16:13 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 03:16:13 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: Jiaming Fan <fan.jiaming@hotmail.com>, "Su, Yang" <Yang.Su2@amd.com>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkcl: run the remaining foreground probes in
 background
Thread-Topic: [PATCH] drm/amdkcl: run the remaining foreground probes in
 background
Thread-Index: AQHdcLUCIF+EQ3eKx0GcSXW4K3/0EbcmokOP
Date: Tue, 10 Nov 2026 03:16:13 +0000
Message-ID: <DS5PPF18A985A10F29C974DC149F4AFB44B94722@DS5PPF18A985A10.namprd12.prod.outlook.com>
References: <OS3PR01MB102510E3381EAC477967C91D2E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB102510E3381EAC477967C91D2E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF18A985A10:EE_|BN3PR12MB9571:EE_
x-ms-office365-filtering-correlation-id: e87dc92a-9c9b-48e7-24e5-08df3ed8fa0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|10067099003|38070700021|56012099006|11063799006|5023799004|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|261009221227099003|261026140227099003;
x-microsoft-antispam-message-info: 2aa17YPE1PJCW6DXduWcQZiAfLaZjPWP/nioVwyZB+dlhMb3ocUK28ptpsQSSiPFUD4Av6WDQfVgRXSClW68tP2YthjHgsBP5NL45MPbsJOYgA0ej1tzz5hJl0udcN+t9LaalnwNn+J/1uw2OEM2qWH7uI2mAkAWTYwj3T9xh2zPEkwUq2280nGZeY6e6sXvar/OOn0QD4CauqbMd+L2KTuv65kxyf5JRA8zfZ0IoxR9Pdn+0wt3gd0OrueGlBdAO3Mni7Y0Zqr1ugb9qYsDWZNEL7hbLet3lvyeVha7stElO5Jb4qfMUydijWZnLAKZTrpkflmDrEyi/URw/46tM+uj0sMUufdJr1EbLqESrVxMOFR9Oy056PD/aakHg8W+hzcmVYC9drqdClUNHovNj43zagw0c/5waiXNfBrw3jDpHut2XQDsdqBg8inwpOrrNVEYCB0yq5kun+OADxnamH3coeDSAkPfdW6osSmdPrH8SVjCrr8iNo0zDx8mmNmOYH7YcDdlYc4atAzdQidKtYWyFNz98BCAkOoJQ8IExZW4c4MWpCrtZRjo/I2mhBbTj9o0LN1VrDKtPAZpYnVVm0vgfNbGlw4gbolklIxPAMvYIs6SM9BPTnpkMRRO60ylPuMsrBpnPkyEFu8YYhZCUTM89Z64lEj5fxu8UlgQNHzQpgf+lJHAPolg1B4HLFylUoG1Z9YY62UXDIXINWx9ETBwcuFMRCml1Q/uoWRws9M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(38070700021)(56012099006)(11063799006)(5023799004)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261009221227099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jj+jcOLZAHJHMvxvcbNVPl5DFy2kEwJxuAOwKBHzOWPC9+q4nglP4k5fezVJ?=
 =?us-ascii?Q?+yHWbCewNRo8X5vsT99yvC0hYGYzBq4GAQJG+Ri/hcMaiZBHOEzGKh/08wuj?=
 =?us-ascii?Q?0u7ZKfIEzk5ZkHzker+YeXVbqVVQFQ31Xl4GYzFgDfofLoPLejo5F47yoGDT?=
 =?us-ascii?Q?X7VWwJVwcWVHuj9gq4saCdIgK+b88RFPU7ApuX0OQsPTTfLUbHuGN3Tg0WZI?=
 =?us-ascii?Q?Cu4IxExzyLvYjc+Q/0KvuibxjQkNUbpsFfuWxX9SQtZ9WRwM+Q4wU5jzns3N?=
 =?us-ascii?Q?vk4DOBrzaFvfg8cmBzQGWjLnj/1Nv82s+HF/YuMUBADSSOQvYuMVsGWddWmw?=
 =?us-ascii?Q?ofneiXDXK6llesh7l/N6qqD9OVV6izkb8FHPmtMJU2rCZkDa9yhfhUhn0uQY?=
 =?us-ascii?Q?3PX+D9M0/jM5t5i0KJOdJTRb7qHPxjxBjIJfUl9j/L6w1tXujOzbCJZnPAxD?=
 =?us-ascii?Q?sK+WrZC841ayydZvVBBw858MVHn/1izaHPnEAbZP9x1VDENJW6rlOWsKNMyg?=
 =?us-ascii?Q?i1XLGtChpGxv3zHaNHkwtynVnMatvGLP1deqq6UA5MGLxK/t0e99J+RFMCCH?=
 =?us-ascii?Q?cp+oUtzydmgXEBQYtJGrFsoM/5ZzfmoAHdSLxNrF92BHWIqc+OCrPWnkmpNS?=
 =?us-ascii?Q?MFKj/+oxDecH4MVO11i5Cw2MKbaljNYFrnDBRTFXSlKoDE1cRRzS7KrIiChm?=
 =?us-ascii?Q?NJMnvnAYcXtzrCXd6Cfq+1tQ9o1le9P40o2MJIg9yQJZBEYuGc40/QhzKEjg?=
 =?us-ascii?Q?ZoKRmk/SOA7eF9bdaaMEbZYqzYGdfLPxaDknawUJ6HxkOmBQ3kvlyBDwpwBx?=
 =?us-ascii?Q?nUonr148dMTufgTRyiBCVJ2fSoSQK+6cXC6zudEOgKBorZORJ4Xm70cLN3nY?=
 =?us-ascii?Q?dvd6ya4tpKSBIcevvu4XOHl0LqR7UKF17dboemR09qHmzDm3EZoalTZR5nqN?=
 =?us-ascii?Q?WcTW4v5yNOtmi7VzJjHoDhn8vFv6GuH8snVFo96weJvhn1rBe5fR3Dl2xob1?=
 =?us-ascii?Q?X+OkiYQ2tIG1aebcsljFNgTPTkh5Ut51zQGI1UmO+GOhAYudAE9rbNvNkYcB?=
 =?us-ascii?Q?k+/30YY08mIM5vLtqvxlNaxS130y39vFjYZCGao2P785AMez416BIVCBYm3d?=
 =?us-ascii?Q?T7Q3y01OAODsvdz7LJ1ZZdIoMcGozf7FDzWAaqx8JG+D7e+MpFeeu4XOoS8J?=
 =?us-ascii?Q?dOaWmkWBzmTu1PTm2nRqncFrI+ZwLUq6PjmCieXvQTxcHzijB1KvFyQmqwxg?=
 =?us-ascii?Q?P0BTLmDqIvKGMFPJjCFBhg2AQdK7gGA0kPcLOX9NI/7b9RROmmuRUKRPwMjv?=
 =?us-ascii?Q?djdg4HhKG4mmxGseSJPZKUx5uCMGhVFXLnG4CPT7SwJPfIddOUwlw2XihTKg?=
 =?us-ascii?Q?WqAbyhyLG8SZHxs5nUhzNh2Mh2kLY4up0+hUaCAL0WQza/+5zT9MwYixeBeY?=
 =?us-ascii?Q?wqImI2LFkqvwI6Zwv8i0iyFs1zygu2+ut4eSxpgLleVBiCHDQQckeQbrVFbm?=
 =?us-ascii?Q?qSIiljPnCPUtuUgde+JeaXSiFJsNFt61Eo1Y8/Vbx9Xlj2D+lptildxmLsQ/?=
 =?us-ascii?Q?Gjmc0xXRUuNay/LG4c6oJ0Lc3IK+lWeXcbHgt2Gg4NUSnTgAH5aGedm4B0dY?=
 =?us-ascii?Q?u1YEwtNJpD6DKLt1KBNVVe2vrny3LQgae92PLsDwk5WyU/UKUxOK0L0ftE7G?=
 =?us-ascii?Q?RwO0kfGDKSMtccXrBZ8mRODu8ExVPJOGAzPIPBjhnm3Fm4S3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87dc92a-9c9b-48e7-24e5-08df3ed8fa0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 03:16:13.8864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYCztgA3vDNPQSLN30efNTaKfWEMp6oC5V0WGWxVbUpAE1nJ2Z559Ojqzb6/OHL35Ttrr942SnYHc7hsGbmdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The quoted content in my previous email lost its line breaks due to a forma=
tting issue.

Reviewed-by: Bob Zhou <Bob.Zhou@amd.com>

We will apply the patch.

On 11/10/2026 9:44 AM, Jiaming Fan wrote:

> [Some people who received this message don't often get email from fan.jia=
ming@hotmail.com. Learn why this is important at https://aka.ms/LearnAboutS=
enderIdentification ]
>
> The HDMI and DP colorspace property probes and the legacy gamma probe
> are the only top-level probes that are not wrapped in
> AC_KERNEL_DO_BACKGROUND. They run in the shared configure directory,
> one at a time, while every other probe runs in parallel in its own
> temporary directory.
>
> Running in the shared directory also lets a probe see a conftest.o left
> there by an earlier one. Before commit a4e55d0e6d9a ("drm/amdkcl: string
> objtool from cflags for conftest") the probe command ended in
> "; objtool ... conftest.o", so a failed compile was hidden by objtool
> succeeding on that stale object. On v5.17 this defined
> HAVE_DRM_MODE_CREATE_{HDMI,DP}_COLORSPACE_PROPERTY_2ARGS for kernels
> that only have the 1-argument functions. That commit removed the cause;
> running these probes in background like the others removes the shared
> state as well.
>
> Wrap each probe separately rather than the colorspace group as a whole:
> AC_AMDGPU_DRM_CONNECT_ATTACH_COLORSPACE_PROPERTY already runs in
> background, and a job started from inside another one is not in $procs,
> so AC_KERNEL_WAIT would not wait for it.
>
> The generated config.h is unchanged.
>
> Link: https://github.com/ROCm/amdgpu/issues/228
> Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
> ---
> This was a real bug in the ROCm 6.0.0 DKMS package on kernel v5.17, which
> I reported in issue #228. It is already fixed on master by a4e55d0e6d9a,
> so this patch does not fix a bug there; it only makes these three probes
> consistent with the rest. Feel free to drop it if you prefer to leave
> them as they are.
>
>  ...rm_mode_create_hdmi_colorspace_property.m4 | 40 ++++++++++---------
>  .../drm/amd/dkms/m4/struct_drm_crtc_funcs.m4  | 12 +++---
>  2 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_=
property.m4 b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_p=
roperty.m4
> index ecc33db..3d7eee7 100644
> --- a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_propert=
y.m4
> +++ b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_propert=
y.m4
> @@ -20,30 +20,34 @@ dnl # commit v6.1-5783-g08383039cd19
>  dnl # drm/connector: Allow drivers to pass list of supported colorspaces
>  dnl #
>  AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY], [
> -       AC_KERNEL_TRY_COMPILE_SYMBOL([
> -                       #include <drm/drm_connector.h>
> -        ], [
> -            drm_mode_create_hdmi_colorspace_property(NULL, 0);
> -               ], [drm_mode_create_hdmi_colorspace_property], [drivers/g=
pu/drm/drm_connector.c], [
> -                               AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLOR=
SPACE_PROPERTY_2ARGS, 1,
> -                       [drm_mode_create_hdmi_colorspace_property() has 2=
 args])
> -               ])
> -])
> +       AC_KERNEL_DO_BACKGROUND([
> +               AC_KERNEL_TRY_COMPILE_SYMBOL([
> +                       #include <drm/drm_connector.h>
> +               ], [
> +                       drm_mode_create_hdmi_colorspace_property(NULL, 0)=
;
> +               ], [drm_mode_create_hdmi_colorspace_property], [drivers/g=
pu/drm/drm_connector.c], [
> +                       AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PR=
OPERTY_2ARGS, 1,
> +                               [drm_mode_create_hdmi_colorspace_property=
() has 2 args])
> +               ])
> +       ])
> +])
>
>  dnl #
>  dnl # commit v6.1-5783-g08383039cd19
>  dnl # drm/connector: Allow drivers to pass list of supported colorspaces
>  dnl #
>  AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY], [
> -       AC_KERNEL_TRY_COMPILE_SYMBOL([
> -                       #include <drm/drm_connector.h>
> -        ], [
> -            drm_mode_create_dp_colorspace_property(NULL, 0);
> -               ], [drm_mode_create_dp_colorspace_property], [drivers/gpu=
/drm/drm_connector.c], [
> -                               AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSP=
ACE_PROPERTY_2ARGS, 1,
> -                       [drm_mode_create_dp_colorspace_property() has 2 a=
rgs])
> -               ])
> -])
> +       AC_KERNEL_DO_BACKGROUND([
> +               AC_KERNEL_TRY_COMPILE_SYMBOL([
> +                       #include <drm/drm_connector.h>
> +               ], [
> +                       drm_mode_create_dp_colorspace_property(NULL, 0);
> +               ], [drm_mode_create_dp_colorspace_property], [drivers/gpu=
/drm/drm_connector.c], [
> +                       AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROP=
ERTY_2ARGS, 1,
> +                               [drm_mode_create_dp_colorspace_property()=
 has 2 args])
> +               ])
> +       ])
> +])
>
>
>  AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_COLORSPACE_PROPERTY_FUNCS], [
> diff --git a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 b/drive=
rs/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
> index 6b53674..9e9acbc 100644
> --- a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
> +++ b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
> @@ -23,13 +23,15 @@ dnl #
>  dnl # v5.10-1961-g6ca2ab8086af drm: automatic legacy gamma support
>  dnl #
>  AC_DEFUN([AC_AMDGPU_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL], [
> -       AC_KERNEL_TRY_COMPILE_SYMBOL([
> -               #include <drm/drm_atomic_helper.h>
> -       ], [
> -               drm_atomic_helper_legacy_gamma_set(NULL, NULL, NULL, NULL=
, 0, NULL);
> -       ], [drm_atomic_helper_legacy_gamma_set], [drivers/gpu/drm/drm_ato=
mic_helper.c],[],[
> +       AC_KERNEL_DO_BACKGROUND([
> +               AC_KERNEL_TRY_COMPILE_SYMBOL([
> +                       #include <drm/drm_atomic_helper.h>
> +               ], [
> +                       drm_atomic_helper_legacy_gamma_set(NULL, NULL, NU=
LL, NULL, 0, NULL);
> +               ], [drm_atomic_helper_legacy_gamma_set], [drivers/gpu/drm=
/drm_atomic_helper.c],[],[
>                         AC_DEFINE(HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OP=
TIONAL, 1,
>                                 [HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPT=
IONAL is available])
> +               ])
>         ])
>  ])
>
> --
> 2.56.0
>
>
>=
