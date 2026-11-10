Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196B606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zOcFl9P9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248D210E560;
	Tue, 10 Nov 2026 02:38:29 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B33310E560
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 02:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc5YwXD12oY4lg8l9atWJpI5txBnM0SAqTscCArgT8iDChciqnhk3X4XG7THnfBfZ1fPe3OmeKtAs5K1NjILyDc90r3GAqWcLBBANNo4j0GKBjqQW4StpQPuaPiFE74sk9xwHzArfI9p419dx28kVqFHTMPegOU+zFzMmOuLJnPf8S2QeUZREDAatuOztN+mNebCoK4H+ViW3e+Bw27KJeeG512Rir//sdts94G7uXOSEQje4QCoulUcxGw/kzD0SM3hi1YynZEUxMjkd9+Eo8rkuTm99oVVhDDwYiwhL9O8VMD2SXHQCMFqU8l97OAgLluYy+R2zIQGqhFpiWpmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ujIEwvdcYIOFbh42kond3Tx+AhVVSBXdC6DUKcUyNk=;
 b=gc6JDeT1vNKGoeVqXj2HZzP/NcMO7fF7+F+T8cGiotX8zFZjaanqGfc2+a0kIw+9pk4/pSfOllPgvQjF/w/K3W5qjMLOiEzjqgbUIQaQ9R8PZXQ1kkeltx8upv3JmMv9F9lbgU5AsgY1VOIUVundomsIaMug5OlIVLg6zKKK2APumdp0WtLiyPzdJR6ffMm+fRX7Pa+7rt/c2h4Rf1YTZOy4PSIx4rZ1Fsm/u7MFQVnwHdi67DQmqnD+fsM+U8YjCBDShvFu9wUSEzRq9lICVubI1/h3mapZ1KesYpgsGnu29dAuNiILLkUCg6WkmHH5x4XlJzXorYJEZ/84czt1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ujIEwvdcYIOFbh42kond3Tx+AhVVSBXdC6DUKcUyNk=;
 b=zOcFl9P9z/kQeacD8w+w0vLXuddKSumkRYH4H/16heqh/1WYemDJH3e6+gerJx64j7cjwUja9D/FYJKobXzws2+EWr0QXs/ySuMGw0kczOS5NWPyfeS5gPuwg7NvmV9PCVHP9efC5pK4nGShaRIi0FPODRbh9WwjKk4hs+kst4U=
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 02:38:17 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::dd24:2a58:c0d0:b183%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:38:17 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: Jiaming Fan <fan.jiaming@hotmail.com>, Chengjun Yao
 <Chengjun.Yao@amd.com>, "Su, Yang" <Yang.Su2@amd.com>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkcl: run the remaining foreground probes in
 background
Thread-Topic: [PATCH] drm/amdkcl: run the remaining foreground probes in
 background
Thread-Index: AQHdcLUCIF+EQ3eKx0GcSXW4K3/0Ebcml6lU
Date: Tue, 10 Nov 2026 02:38:17 +0000
Message-ID: <DS5PPF18A985A10A603888D767C69419E6894722@DS5PPF18A985A10.namprd12.prod.outlook.com>
References: <OS3PR01MB102510E3381EAC477967C91D2E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB102510E3381EAC477967C91D2E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF18A985A10:EE_|CY8PR12MB8300:EE_
x-ms-office365-filtering-correlation-id: 09c5bcff-6a60-45ad-f708-08df3ed3ad43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|8096899003|10067099003|38070700021|5023799004|11063799006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261009221227099003;
x-microsoft-antispam-message-info: KdMNTWOAO6YAQ+8IXSAoPLpD81EzPnLi5XoXAXDqnaUKrH7GU6BNUtSHOvTOPmOtAlue3ii2JE5+ru/1mGm1ZRnZAHv3CqozWJ/nlofn0LUvmMNUbIuV+bMD3ZHPwSKwFg9sdr5dUtbCrFZxLZYEGWUW11R8cjT3sChBXtF7IX9JAtk2zgi0PhV25iB5fAHgemOzC86LFXF0PQb2Z8KxLomzssfHUWfmGiQy8mckBM3zZ0Obx+rcUwTu8wZLRwRv0k6vCiDINPEG1ITj9gAH9cOsWMgckh/BJiq61nFBLLVkkz6qugCcw/NikuF1f+r/S6hJHKUuvipEStA86nYkRzaMUi390gWBteAKx/olvWzxbz+8CAO7kSVPpkUP/eb3VFKEZ0NKPKd0W6IThdDUlk60peNeOcuTPnsDcar9YdGironl/fUD+hGlhWBlk6S1uRDN2KY6NdOzwTUYBm6Z966kNA+c86q31jV/Ro2XvlAWoA97NM5lc4gL6fkm4XFi2PrWNDJOXW1Y6xwM5SG/72kxfy9+yZG0YC/rm2HblRhyXf6Q4JsrfTVUUximRXEz1d+IarUOzRqp4e4Kvhn7azQIc2thDFEy0dSuHgBGOSiJLd5JqFILFSm87zuQ0F2HcswAQ/j/jCLH8L5ScWciMVNxaNZv2fM91sdHQhYDJjhm9D/uo/J/23uzIP8651K8Bf6GfmbH1oOongF1XRqPvT4K/Oy1P6ntDy+ge8wV7zg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(8096899003)(10067099003)(38070700021)(5023799004)(11063799006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aDtyluFtw+kc1w5QTeV9Tvv6O58IjUuKCtVMAEjF92BDOHFCr0vsj/Zl3Jqd?=
 =?us-ascii?Q?vsHnb/R08xswchl28XHx7i6lbf5nnR0URoXTLGV0+eQvw0LIXKZNCIpCHZg0?=
 =?us-ascii?Q?2Fj+U1nnxdr4p3Fd+14tfl7pl+eU2TobOdH5SGBFiaAJ3Tv2PmD8yfsEqQWZ?=
 =?us-ascii?Q?g+NA1Naj1239ovqcOW0QjtGT5meMcVMpquZp2MaLP9IrCGvuG8YWdsq/HUux?=
 =?us-ascii?Q?DydEwDi9Jo55ZkAVys+BNI92vGKeaDc7RCylzDlSwmhteZPYxdSTa7mFFWGP?=
 =?us-ascii?Q?n+B8WIowB9H42xmA5Vh346ELrPdCyRm4Jr3gz1Wn99QC+GAeLGoWFuA11FJ1?=
 =?us-ascii?Q?DeRyvDVM0I3YGr7Zl9yKMfhM+Pfin04ACKjbKTAO7vGyCBhXjTrg7e52YlHc?=
 =?us-ascii?Q?HcFLKcnvQnrZ4dgKEbpnBxEnrAnTr3wV4TptjSP7Xuu0R7X8EVVlmKdtwudi?=
 =?us-ascii?Q?wBeowMYyPvM1zV03Xv+E13VIecSE85a3Ii8XCykHbKyTVICpFlnPtbdKQiZ8?=
 =?us-ascii?Q?KJcDaCjAnz0RCz0/f1M7R2o24RgbccENWAgUYMMjofYZ/TDbN7yfA1pfZmq/?=
 =?us-ascii?Q?pvSxdmbSPnMgzN/iueVqm7UvJamT09XsKBG3o+KQuXXtiKh4AzRkLVWq4Z5f?=
 =?us-ascii?Q?DKqAdO20e6K6t1m9+WnsAwG2SPNPVPmNJmukGY7R0VnuIqI3KTWoiQgXwPGP?=
 =?us-ascii?Q?gEzyrNdLoR50BzIgV6cMQr3AZOFgIfELR9QaGnwkvKI/2SkcrncUQHmjubSi?=
 =?us-ascii?Q?TiG2IiGQqDaYikBSnFxiy28PFW+3IwtuLKdRS0sDWWmrffD6Qu/gb4YljV75?=
 =?us-ascii?Q?u7z/pi9EokRWn72o7dT0QsFN5WRaNQeWP7WmJnIHAJvsTalk4FGrTyG9mPGU?=
 =?us-ascii?Q?m2ZYGjjaJTHkFkkLymR15+DFhFHKWQ3U12g4ujPZUyWrJNikV9WuvbQICugi?=
 =?us-ascii?Q?U1onFzhtffs2t8ewlvusRsO5j1d3loltgBtxRioERmeYCBNXpJDHYwtoKg9a?=
 =?us-ascii?Q?Bzn/nbjYviD0BXRrY7C6/kn1Y2mUGlwrxrbcF6QZYUq/5vFPX/xsGuxDRC1w?=
 =?us-ascii?Q?xLBoPTD5vlXI5UZ5i1bO2XyV5s9omQRXGZ8h6JpEhEQe+FnEaNDSlw/rlh6+?=
 =?us-ascii?Q?Ci+3lvk/hanCL4jRBMew87T7Pxto0ABwhMLV3WntvdHAA4FKbuifowcJYKsU?=
 =?us-ascii?Q?P/Rm5w+PXDFKEIOkfL8aR3bIaX3dwasrszBzfMXMjmoW3xVY0yo/83LsQbDN?=
 =?us-ascii?Q?2oqVKw9qGNDYMdNM9xhGect9VJKJmn8O6r9CfoJUeudP2LGE2vN4/Y4/YOMp?=
 =?us-ascii?Q?p/dRfCqbC/t+6YlWD87HG1pW6CYtMQ6v9uf2PKvATROg8cj0/zWU0XUV3+Os?=
 =?us-ascii?Q?tNmj3KITySLr8GSGYSJvIj/tSh6eOeICsrRTNBfyWsvr7rRapZUBVX6uUuTz?=
 =?us-ascii?Q?O9RNDgFKyOTzZaX5c0SKEv09HIem+Vw1WyI8T/N9K46t9Q2OEvGMplPE38Xg?=
 =?us-ascii?Q?ATffoy3xZQKfYh9odrcLJg6qFKGXV+UeYZJjtNphrXiiY1m/ShWZfeDOq04X?=
 =?us-ascii?Q?uiXT4ZSXP842Z0K9oQDjDWvGtp3u6bqw/404iJFSsHoWoRZTMPkPOn/ahxxR?=
 =?us-ascii?Q?ePNj+qfh9CAD3g4IymhV5YG8IsG/abAiwbzLHN91fPwwfnzvJM7bubx4WBZQ?=
 =?us-ascii?Q?fZfdiumFUNhGf3Ai7kcEGdztitx/XCmiRDPv8qp+2I+Et6sY?=
Content-Type: multipart/alternative;
 boundary="_000_DS5PPF18A985A10A603888D767C69419E6894722DS5PPF18A985A10_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5bcff-6a60-45ad-f708-08df3ed3ad43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 02:38:17.5243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MI4o0xd5f2kkqArQLesCj6IstSUN5/5yJeJWsvpt9Iju2pWADGC72vDgcanASBTGMFGMEsI/QcSmKjFkM1QuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS5PPF18A985A10A603888D767C69419E6894722DS5PPF18A985A10_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jiaming,

Thanks for the patch.

The change correctly moves the remaining foreground probes into isolated te=
mporary build directories and keeps them tracked by the top-level AC_KERNEL=
_WAIT. Wrapping each probe individually also avoids the nested-background P=
ID tracking issue. This prevents stale conftest.o state from affecting the =
checks and makes these probes consistent with the rest.

Reviewed-by: Bob Zhou <Bob.Zhou@amd.com>

We will apply the patch.

Regards,
Bob

________________________________________ From: Jiaming Fan Sent: Tuesday, 1=
0 November 2026 01:44:10 To: Chengjun Yao; Zhou, Bob; Su, Yang Cc: Russell,=
 Kent; Cui, Flora; amd-gfx@lists.freedesktop.org Subject: [PATCH] drm/amdkc=
l: run the remaining foreground probes in background [Some people who recei=
ved this message don't often get email from fan.jiaming@hotmail.com. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification ] Th=
e HDMI and DP colorspace property probes and the legacy gamma probe are the=
 only top-level probes that are not wrapped in AC_KERNEL_DO_BACKGROUND. The=
y run in the shared configure directory, one at a time, while every other p=
robe runs in parallel in its own temporary directory. Running in the shared=
 directory also lets a probe see a conftest.o left there by an earlier one.=
 Before commit a4e55d0e6d9a ("drm/amdkcl: string objtool from cflags for co=
nftest") the probe command ended in "; objtool ... conftest.o", so a failed=
 compile was hidden by objtool succeeding on that stale object. On v5.17 th=
is defined HAVE_DRM_MODE_CREATE_{HDMI,DP}_COLORSPACE_PROPERTY_2ARGS for ker=
nels that only have the 1-argument functions. That commit removed the cause=
; running these probes in background like the others removes the shared sta=
te as well. Wrap each probe separately rather than the colorspace group as =
a whole: AC_AMDGPU_DRM_CONNECT_ATTACH_COLORSPACE_PROPERTY already runs in b=
ackground, and a job started from inside another one is not in $procs, so A=
C_KERNEL_WAIT would not wait for it. The generated config.h is unchanged. L=
ink: https://github.com/ROCm/amdgpu/issues/228 Signed-off-by: Jiaming Fan -=
-- This was a real bug in the ROCm 6.0.0 DKMS package on kernel v5.17, whic=
h I reported in issue #228. It is already fixed on master by a4e55d0e6d9a, =
so this patch does not fix a bug there; it only makes these three probes co=
nsistent with the rest. Feel free to drop it if you prefer to leave them as=
 they are. ...rm_mode_create_hdmi_colorspace_property.m4 | 40 ++++++++++---=
------ .../drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 | 12 +++--- 2 files cha=
nged, 29 insertions(+), 23 deletions(-) diff --git a/drivers/gpu/drm/amd/dk=
ms/m4/drm_mode_create_hdmi_colorspace_property.m4 b/drivers/gpu/drm/amd/dkm=
s/m4/drm_mode_create_hdmi_colorspace_property.m4 index ecc33db..3d7eee7 100=
644 --- a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_prope=
rty.m4 +++ b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_pr=
operty.m4 @@ -20,30 +20,34 @@ dnl # commit v6.1-5783-g08383039cd19 dnl # dr=
m/connector: Allow drivers to pass list of supported colorspaces dnl # AC_D=
EFUN([AC_AMDGPU_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY], [ - AC_KERNEL_TR=
Y_COMPILE_SYMBOL([ - #include - ], [ - drm_mode_create_hdmi_colorspace_prop=
erty(NULL, 0); - ], [drm_mode_create_hdmi_colorspace_property], [drivers/gp=
u/drm/drm_connector.c], [ - AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_=
PROPERTY_2ARGS, 1, - [drm_mode_create_hdmi_colorspace_property() has 2 args=
]) - ]) -]) + AC_KERNEL_DO_BACKGROUND([ + AC_KERNEL_TRY_COMPILE_SYMBOL([ + =
#include + ], [ + drm_mode_create_hdmi_colorspace_property(NULL, 0); + ], [=
drm_mode_create_hdmi_colorspace_property], [drivers/gpu/drm/drm_connector.c=
], [ + AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY_2ARGS, 1, + =
[drm_mode_create_hdmi_colorspace_property() has 2 args]) + ]) + ]) +]) dnl =
# dnl # commit v6.1-5783-g08383039cd19 dnl # drm/connector: Allow drivers t=
o pass list of supported colorspaces dnl # AC_DEFUN([AC_AMDGPU_DRM_MODE_CRE=
ATE_DP_COLORSPACE_PROPERTY], [ - AC_KERNEL_TRY_COMPILE_SYMBOL([ - #include =
- ], [ - drm_mode_create_dp_colorspace_property(NULL, 0); - ], [drm_mode_cr=
eate_dp_colorspace_property], [drivers/gpu/drm/drm_connector.c], [ - AC_DEF=
INE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY_2ARGS, 1, - [drm_mode_creat=
e_dp_colorspace_property() has 2 args]) - ]) -]) + AC_KERNEL_DO_BACKGROUND(=
[ + AC_KERNEL_TRY_COMPILE_SYMBOL([ + #include + ], [ + drm_mode_create_dp_c=
olorspace_property(NULL, 0); + ], [drm_mode_create_dp_colorspace_property],=
 [drivers/gpu/drm/drm_connector.c], [ + AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_C=
OLORSPACE_PROPERTY_2ARGS, 1, + [drm_mode_create_dp_colorspace_property() ha=
s 2 args]) + ]) + ]) +]) AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_COLORSPACE_PRO=
PERTY_FUNCS], [ diff --git a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_fu=
ncs.m4 b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 index 6b53674=
..9e9acbc 100644 --- a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4=
 +++ b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 @@ -23,13 +23,1=
5 @@ dnl # dnl # v5.10-1961-g6ca2ab8086af drm: automatic legacy gamma suppo=
rt dnl # AC_DEFUN([AC_AMDGPU_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL], [ -=
 AC_KERNEL_TRY_COMPILE_SYMBOL([ - #include - ], [ - drm_atomic_helper_legac=
y_gamma_set(NULL, NULL, NULL, NULL, 0, NULL); - ], [drm_atomic_helper_legac=
y_gamma_set], [drivers/gpu/drm/drm_atomic_helper.c],[],[ + AC_KERNEL_DO_BAC=
KGROUND([ + AC_KERNEL_TRY_COMPILE_SYMBOL([ + #include + ], [ + drm_atomic_h=
elper_legacy_gamma_set(NULL, NULL, NULL, NULL, 0, NULL); + ], [drm_atomic_h=
elper_legacy_gamma_set], [drivers/gpu/drm/drm_atomic_helper.c],[],[ AC_DEFI=
NE(HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL, 1, [HAVE_STRUCT_DRM_CRTC_=
FUNCS_GAMMA_SET_OPTIONAL is available]) + ]) ]) ]) -- 2.56.0

--_000_DS5PPF18A985A10A603888D767C69419E6894722DS5PPF18A985A10_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p>Hi Jiaming,</p>
<p>Thanks for the patch.</p>
<p>The change correctly moves the remaining foreground probes into isolated=
 temporary build directories and keeps them tracked by the top-level AC_KER=
NEL_WAIT. Wrapping each probe individually also avoids the nested-backgroun=
d PID tracking issue. This prevents
 stale conftest.o state from affecting the checks and makes these probes co=
nsistent with the rest.</p>
<p>Reviewed-by: Bob Zhou &lt;Bob.Zhou@amd.com&gt;</p>
<p>We will apply the patch.</p>
<p>Regards,<br>
Bob</p>
________________________________________ From: Jiaming Fan <fan.jiaming@hot=
mail.com>
Sent: Tuesday, 10 November 2026 01:44:10 To: Chengjun Yao; Zhou, Bob; Su, Y=
ang Cc: Russell, Kent; Cui, Flora; amd-gfx@lists.freedesktop.org Subject: [=
PATCH] drm/amdkcl: run the remaining foreground probes in background [Some =
people who received this message
 don't often get email from fan.jiaming@hotmail.com. Learn why this is impo=
rtant at https://aka.ms/LearnAboutSenderIdentification ] The HDMI and DP co=
lorspace property probes and the legacy gamma probe are the only top-level =
probes that are not wrapped in AC_KERNEL_DO_BACKGROUND.
 They run in the shared configure directory, one at a time, while every oth=
er probe runs in parallel in its own temporary directory. Running in the sh=
ared directory also lets a probe see a conftest.o left there by an earlier =
one. Before commit a4e55d0e6d9a
 (&quot;drm/amdkcl: string objtool from cflags for conftest&quot;) the prob=
e command ended in &quot;; objtool ... conftest.o&quot;, so a failed compil=
e was hidden by objtool succeeding on that stale object. On v5.17 this defi=
ned HAVE_DRM_MODE_CREATE_{HDMI,DP}_COLORSPACE_PROPERTY_2ARGS
 for kernels that only have the 1-argument functions. That commit removed t=
he cause; running these probes in background like the others removes the sh=
ared state as well. Wrap each probe separately rather than the colorspace g=
roup as a whole: AC_AMDGPU_DRM_CONNECT_ATTACH_COLORSPACE_PROPERTY
 already runs in background, and a job started from inside another one is n=
ot in $procs, so AC_KERNEL_WAIT would not wait for it. The generated config=
.h is unchanged. Link: https://github.com/ROCm/amdgpu/issues/228 Signed-off=
-by: Jiaming Fan
<fan.jiaming@hotmail.com>--- This was a real bug in the ROCm 6.0.0 DKMS pac=
kage on kernel v5.17, which I reported in issue #228. It is already fixed o=
n master by a4e55d0e6d9a, so this patch does not fix a bug there; it only m=
akes these three probes consistent
 with the rest. Feel free to drop it if you prefer to leave them as they ar=
e. ...rm_mode_create_hdmi_colorspace_property.m4 | 40 ++++++++++--------- .=
../drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 | 12 +++--- 2 files changed, 29=
 insertions(+), 23 deletions(-)
 diff --git a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_p=
roperty.m4 b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_pr=
operty.m4 index ecc33db..3d7eee7 100644 --- a/drivers/gpu/drm/amd/dkms/m4/d=
rm_mode_create_hdmi_colorspace_property.m4
 +++ b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_property=
.m4 @@ -20,30 +20,34 @@ dnl # commit v6.1-5783-g08383039cd19 dnl # drm/conn=
ector: Allow drivers to pass list of supported colorspaces dnl # AC_DEFUN([=
AC_AMDGPU_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY],
 [ - AC_KERNEL_TRY_COMPILE_SYMBOL([ - #include <drm drm_connector.h=3D"">- =
], [ - drm_mode_create_hdmi_colorspace_property(NULL, 0); - ], [drm_mode_cr=
eate_hdmi_colorspace_property], [drivers/gpu/drm/drm_connector.c], [ - AC_D=
EFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY_2ARGS,
 1, - [drm_mode_create_hdmi_colorspace_property() has 2 args]) - ]) -]) + A=
C_KERNEL_DO_BACKGROUND([ + AC_KERNEL_TRY_COMPILE_SYMBOL([ + #include
<drm drm_connector.h=3D"">+ ], [ + drm_mode_create_hdmi_colorspace_property=
(NULL, 0); + ], [drm_mode_create_hdmi_colorspace_property], [drivers/gpu/dr=
m/drm_connector.c], [ + AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PROP=
ERTY_2ARGS, 1, + [drm_mode_create_hdmi_colorspace_property()
 has 2 args]) + ]) + ]) +]) dnl # dnl # commit v6.1-5783-g08383039cd19 dnl =
# drm/connector: Allow drivers to pass list of supported colorspaces dnl # =
AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY], [ - AC_KERNEL_=
TRY_COMPILE_SYMBOL([ - #include
<drm drm_connector.h=3D"">- ], [ - drm_mode_create_dp_colorspace_property(N=
ULL, 0); - ], [drm_mode_create_dp_colorspace_property], [drivers/gpu/drm/dr=
m_connector.c], [ - AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY_2=
ARGS, 1, - [drm_mode_create_dp_colorspace_property()
 has 2 args]) - ]) -]) + AC_KERNEL_DO_BACKGROUND([ + AC_KERNEL_TRY_COMPILE_=
SYMBOL([ + #include
<drm drm_connector.h=3D"">+ ], [ + drm_mode_create_dp_colorspace_property(N=
ULL, 0); + ], [drm_mode_create_dp_colorspace_property], [drivers/gpu/drm/dr=
m_connector.c], [ + AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY_2=
ARGS, 1, + [drm_mode_create_dp_colorspace_property()
 has 2 args]) + ]) + ]) +]) AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_COLORSPACE_=
PROPERTY_FUNCS], [ diff --git a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc=
_funcs.m4 b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 index 6b53=
674..9e9acbc 100644 --- a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs=
.m4
 +++ b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 @@ -23,13 +23,1=
5 @@ dnl # dnl # v5.10-1961-g6ca2ab8086af drm: automatic legacy gamma suppo=
rt dnl # AC_DEFUN([AC_AMDGPU_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL], [ -=
 AC_KERNEL_TRY_COMPILE_SYMBOL([
 - #include <drm drm_atomic_helper.h=3D"">- ], [ - drm_atomic_helper_legacy=
_gamma_set(NULL, NULL, NULL, NULL, 0, NULL); - ], [drm_atomic_helper_legacy=
_gamma_set], [drivers/gpu/drm/drm_atomic_helper.c],[],[ + AC_KERNEL_DO_BACK=
GROUND([ + AC_KERNEL_TRY_COMPILE_SYMBOL([
 + #include <drm drm_atomic_helper.h=3D"">+ ], [ + drm_atomic_helper_legacy=
_gamma_set(NULL, NULL, NULL, NULL, 0, NULL); + ], [drm_atomic_helper_legacy=
_gamma_set], [drivers/gpu/drm/drm_atomic_helper.c],[],[ AC_DEFINE(HAVE_STRU=
CT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL,
 1, [HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL is available]) + ]) ]) ]=
) -- 2.56.0
</body>
</html>

--_000_DS5PPF18A985A10A603888D767C69419E6894722DS5PPF18A985A10_--
