Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFBCC369C2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 15:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3E710E023;
	Mon, 21 Apr 2025 15:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZON+XQ93";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F4710E023
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 15:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvRiq967kvDw91DzahiEJpR1SR/ZkhTmVstFJzdP0QC9lcvpBNsdvVv7HY6nm+filX1poIBLkrJFNcc3UT6qIvWmHNaaBaN1Tq92GL5iUTWuyk71dEvhv9jlaIf7+ybNscRdM5RvdE1MFwe9hlK3HIk7k2ELw6lZGAeiIohz65DqAVSNn2vurJA4dmYeXzuCq380t6aQqKp2tw4HPECo7vODJ8wjIkec8IAlVlm0dGHeNxpMLVRRaBIMSKG5Er1BQTfrnYUjs+6aQzqn7chbCXqai8WhRJEZACb2J2aHurzxDg/k5xb02C38v306Gt9S2hsI02BiF+ahGOtOoPk6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMS+7XhaMnaQEKslw1iJx1JkpfNKxMheyWddabdgtaA=;
 b=QYPDZiQ/bg2YMw7Ho0s8eh3ocgmKtNM0ybUX0tdvNBagiAMSUgoPH/HNFFSU1GpZbli2y6TLx6nJjzEblTta9UV1rNGg0UT5NSZXtfTf4n8j/21MKr1+o5MQrzAg8PWjD9Gvo6o5YZGs7HKFML1kkF86BIUBrJHVeTH3imfId0RQqsaWgdNEm+h4rEitd0QBa6ObmSeL3HIsh9tLbrm2SncTP/gnXx5vTQT2X4M3l7TiQyoDe6QRzevibpQBljbFB6Zn5hMvRroiq5Ed7KH0y6NU3UfGfb0eig4vV7/CTmEM9ce03wu6/6Dy3iLOVKsVUskStQPJK8pC3VjmozEjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMS+7XhaMnaQEKslw1iJx1JkpfNKxMheyWddabdgtaA=;
 b=ZON+XQ93jjEZWzI2am7YRJjg6QT5VKb0ExbC+4W8wD8L0OpoGsKY5Eo/kDUmrOYSdJvXdHH+W8wJXwe609/EBIMweF3K++vafy+OoiSHdPPTEwEqzveBTFj8N1sAM1aSocaBphPkjgeICO9wDWqAiClPwb4RwYC0eJXsNUvjk78=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:07:47 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 15:07:45 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state() v2
Thread-Topic: [PATCH v2] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state() v2
Thread-Index: AQHbsnLCqcoKDj1eoEC6COz/T8RWUrOuOS2M
Date: Mon, 21 Apr 2025 15:07:45 +0000
Message-ID: <CH0PR12MB5284A4EC373224A8945799258BB82@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
 <20250421040610.3794293-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250421040610.3794293-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-21T15:07:45.302Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|PH8PR12MB6724:EE_
x-ms-office365-filtering-correlation-id: 7aca16bd-1386-480c-4724-08dd80e645d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XiSbYhMNR7SkPgH7PRTEg4CpsoMTPg1q8NBOlHRdsRk4+aRxCUQinJYF/WxI?=
 =?us-ascii?Q?iivEEiuTCC8z0FtIaVkMYvZZVgLrakBXSv0480fKrzuLHbPMosA5uqtOVM1w?=
 =?us-ascii?Q?rZetU/NBwayU2sT4CIELF5rh95/z7MPjZE/pHdAvMoRenn2FsyPNf4UilTdx?=
 =?us-ascii?Q?l86lbMu2YQTfXhx6PXxO5nIEfvd3JZS3qYEQvbSco6aYLF98exQFslqiv0Ri?=
 =?us-ascii?Q?CnGKfWQPRDeyw0Md9SWSHPVvUZFxGo1aVvSWJsgjBbvYLny1+buDNajonT4Z?=
 =?us-ascii?Q?MsDSj8fqZ6EC5Ycb1YrRpAvybp+4VCpbkIVH8Hw/onmuhpz+tCK+NAyE914l?=
 =?us-ascii?Q?F0KyfqOOPn2HLGSkuWpcjxQtk41zHxSsNc1hATUi1SmjL9eBU1cSFkQ6PdjZ?=
 =?us-ascii?Q?VdAjH+j+t/9XPznbF9HJg4/GBdau0V0swr/gtp7R8wR8CJ4dM45/A+MbZDpe?=
 =?us-ascii?Q?lrkQfS5nYOOrHwVIXXAClDYWEDA3vm3NOTyvgm/rrqc0I5FHxlr4C3Z1evnf?=
 =?us-ascii?Q?j8SXApA2lvdDLds6eejomyWlutT6lbqcZgglaC6e6YIpo0h1+VTNGY/MGWY0?=
 =?us-ascii?Q?C2AsBCiI3nVNUrATXTeSZtTCIhV4hG29mtxI04O/F8wNQMhZwehgciTp0Ch+?=
 =?us-ascii?Q?NREZjcTjHiWJGfn+dmAVjb7go29RUZLF//cuUntgLqnePCqCIeBQ4/bX3jSh?=
 =?us-ascii?Q?wqTO2vLPOOsaleZ7DZ+KOI/6yNNL9ac+aY60uo4fVTenjhIOZ3TeaDWg46wC?=
 =?us-ascii?Q?nTIYIv98f3T+9rEVWTk+/OSWkVdxZnsVPJb/f2PPVRadJBcC5O0kA/UUpoEE?=
 =?us-ascii?Q?u2zN46XhPLYf+X1xPzoaXASzp3k74/r4vyP7qtA+3DuYzc6XCtraiVoNT7IL?=
 =?us-ascii?Q?rPrm7G2/PvbVfL9F7LtgiSbyp31NXFppeQJ1TyX7YO4IcVQ/n3vwFAmlALXn?=
 =?us-ascii?Q?btXQDfA+ViteOK8x9dV1b4kDDDLceMsUEmhKDVHVUiISMpxTDvo6+PQLulBL?=
 =?us-ascii?Q?YexiAF7kxqjPLraYGKCqRrgLt/jo5BXR0b8AkVatS2GTAKqVY64joYXP2lSo?=
 =?us-ascii?Q?NsUul5z7ob6IVtD2aGS02kcKedjpz8/WM/8DVjD2SuCnj9QJtSc/PPGMvHZq?=
 =?us-ascii?Q?K4khp9gy/sWxjhDAumiMVZo3kqR/MC9ysY+XisbH1QSGNW2VV0PISvtvl2TJ?=
 =?us-ascii?Q?9R0vJcd5xeciWiPOHDDUZ8xZJ9aZjbn6FgiHwnK9wiJBaSaOZvicdfAQMz5P?=
 =?us-ascii?Q?LFUcLOWxob5+4hjv9DB+K3vd5j6w2FXxmU6rHvuhhxOCq1aRyy2bMI+OVnFu?=
 =?us-ascii?Q?cgNPlJeGXIhOpTPw3FuAUs5HJsxGHmgiw94sEwTmmwXJUEJ1MD4AFUxmg5ry?=
 =?us-ascii?Q?VjRxUfqpjWwAbgG75oyayRC3/TvlGfQFAbDUXJ6WkZlg4x8Z8MyCSKWuNgDp?=
 =?us-ascii?Q?UaVNIjm6GswIuwzAN/P8ajZxK7c/VMofB7no3MSrpu9qd1/MYqnUqtnM5Zml?=
 =?us-ascii?Q?VCGR95fEGtIXsr4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4cqN8FaaPMc1gtbHv+L5eAZU/DGRQ/gEhxeCTxztxSUEBc2ieUW+/5Y7szT4?=
 =?us-ascii?Q?hKM6hAZZ7CQtppJYj8HJEhbyPcyaVWrnHW9Ot4Ca0ndiPYPwkWkBS0tfmNiv?=
 =?us-ascii?Q?kpKUMOBUZIX8HtQghHSFwR7n1oej4ghBVJMUUgD2bFMQZg4k2E1qokoKQEfo?=
 =?us-ascii?Q?wf46K+XNRruRWSKgs8IkHrN/p0TVdAAllQ8yelUvD8CDTIVaJRHL2E28a82C?=
 =?us-ascii?Q?k7xTOCt54d6+JBVxxQeAmla4yOzDxWekaTk4r6SusZOuOqVRe0+YqQFxNQ4J?=
 =?us-ascii?Q?pN0Z+K3xjv3JPoIAaSGlJAPBGcIk2wCeUCS7KUI7H39aXePURyJ85Xyalqb+?=
 =?us-ascii?Q?Pr4dOSf1bKTfrUcfYNp4uJUK/f+IEGzmx846kwTrIm2jm3mIAg5nL0wkE6jj?=
 =?us-ascii?Q?wNSbu9Y82tEqEyvi2hYNqIH6xevLkY7yrniuxdq+W5xcIeoCnzZYMoaqDWRD?=
 =?us-ascii?Q?38s22mhkgg2qV2AjAq9ryd9f547bqIpNeEux9jBui9Lc5ya1MNC/EQWp5rdG?=
 =?us-ascii?Q?3+U/5TZOh40n6sje9r82AHTS1zqr9jNny5wmx/BGuAQTNVpu4l+jL1x3L234?=
 =?us-ascii?Q?94tfP/e5CN0SvLuh5q7Kq6P20X7oTe5PPC89BMqgmX/HjFpXwYGrUBwYcVrI?=
 =?us-ascii?Q?imPL53207FtSy09zB+PppyqihIxkCmGpbpfaMY0LS6i949iy8zq0ZmoTtxqn?=
 =?us-ascii?Q?NJ03A7/YUKCYn77qDGx4fuoR3S3sVMgByHSXXEJyZ6wc9VvuQUYTXMibH8Le?=
 =?us-ascii?Q?BUuM5eXaygGhuulALk9whOoL/rcEZjGLk7bJYso0j3DCnwzAccT3SX4kajV1?=
 =?us-ascii?Q?MYcHiFgdUPV3vHxIjrBTHfeZQKL/05AGQkR2glz+mqQsSjO0XoV7RkrcAwXW?=
 =?us-ascii?Q?UgpYoPrcg26Kq/kkCWJjkv2jI7GuML3TBL3DKfgF9v5cm/WVrWqIVQSRCHUq?=
 =?us-ascii?Q?nuSuz/Qd2kYeWdVilVbuw8j8tlx7LB15wdUX1E8C2shd71kgWmg+fhP5KI32?=
 =?us-ascii?Q?/DqXAli2teeZH1BuLc3D626SCXXfvPOGRl96ERmf11OzOpTaGx4xJUr1jiUd?=
 =?us-ascii?Q?JT8TmqOurh98JVdPzmb+YkEFmUG9Gyzq1fDIpcZ15yUcM3Ms6jcLYhO+BIl1?=
 =?us-ascii?Q?4K4DoKUXRtOEF4DtH/hnb28mAScKDjCP97xOsysG3P2RSrW5zt5axhFBUY3Z?=
 =?us-ascii?Q?tmzTTuuygjC5H1RUjlWQfzwqCq6APRVmrY7/KB4wxQqpUy3RqFapVoc09Lp3?=
 =?us-ascii?Q?JXqe3QIgajnwMKOeFWhJtj9KBJMLNTDLPcyBuUaY5o0TtmT0hcEGd5DVLcXC?=
 =?us-ascii?Q?OHwsjyUSMnjGwuSqaNI4zBjV89d68PXTY+k1HKrqmZkSyYNbgriTDYTc8GR1?=
 =?us-ascii?Q?1zQLSHzbolc0FOjRheQBZmHtSEP7JDCjt/rfPqsA//IMMFfO9pNrV2jG4Pm1?=
 =?us-ascii?Q?EKdsbY6Klyk7H+Ap9OyLFTbjXUwJfUB8L/gvDzFhjxBhlwuTxwZ7eP+9tF67?=
 =?us-ascii?Q?HFtoeYegwLEPa5l+GmXohjYmFZJJlIdQzXIQJ1SZ0CPLTMUO0nTu4hEkMsdi?=
 =?us-ascii?Q?aRLpMd/eC8i0u2UkDIs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284A4EC373224A8945799258BB82CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca16bd-1386-480c-4724-08dd80e645d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 15:07:45.8903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXW2pl7l4yzzj9KzUNtCoAaH1lcHQul4xFWLKaWi6OXml4AnShsQZcmtGC7zgGOXXJFyCwR7FzOTRKG1RHm1cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

--_000_CH0PR12MB5284A4EC373224A8945799258BB82CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Aurabindo Pillai
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Monday, April 21, 2025 12:06 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chung, Chi=
aHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Rodrigo Siqueira <Rodrigo.Siqueira@=
amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Dan=
 Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Fix NULL pointer dereferences in dm_up=
date_crtc_state() v2

Added checks for NULL values after retrieving drm_new_conn_state
to prevent dereferencing NULL pointers.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update=
_crtc_state()
        warn: 'drm_new_conn_state' can also be NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm=
,
    10673                          struct drm_atomic_state *state,
    10674                          struct drm_crtc *crtc,
    10675                          struct drm_crtc_state *old_crtc_state,
    10676                          struct drm_crtc_state *new_crtc_state,
    10677                          bool enable,
    10678                          bool *lock_and_validation_needed)
    10679 {
    10680         struct dm_atomic_state *dm_state =3D NULL;
    10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_sta=
te;
    10682         struct dc_stream_state *new_stream;
    10683         int ret =3D 0;
    10684
    ...
    10703
    10704         /* TODO This hack should go away */
    10705         if (connector && enable) {
    10706                 /* Make sure fake sink is created in plug-in scen=
ario */
    10707                 drm_new_conn_state =3D drm_atomic_get_new_connect=
or_state(state,
    10708                                                                  =
       connector);

drm_atomic_get_new_connector_state() can't return error pointers, only NULL=
.

    10709                 drm_old_conn_state =3D drm_atomic_get_old_connect=
or_state(state,
    10710                                                                  =
       connector);
    10711
    10712                 if (IS_ERR(drm_new_conn_state)) {
                                     ^^^^^^^^^^^^^^^^^^

    10713                         ret =3D PTR_ERR_OR_ZERO(drm_new_conn_stat=
e);

Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.

    10714                         goto fail;
    10715                 }
    10716
    ...
    10748
    10749                 dm_new_crtc_state->abm_level =3D dm_new_conn_stat=
e->abm_level;
    10750
--> 10751                 ret =3D fill_hdr_info_packet(drm_new_conn_state,
                                                     ^^^^^^^^^^^^^^^^^^ Unc=
hecked dereference

    10752                                            &new_stream->hdr_stati=
c_metadata);
    10753                 if (ret)
    10754                         goto fail;
    10755

v2: Modified the NULL pointer check for drm_new_conn_state in the
    dm_update_crtc_state function to  include a warning via WARN_ON and
    return -EINVAL to indicate an invalid state when the pointer is NULL.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31a5b8fc4dc4..3d2ff5d58067 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10858,8 +10858,8 @@ static int dm_update_crtc_state(struct amdgpu_displ=
ay_manager *dm,
                 drm_old_conn_state =3D drm_atomic_get_old_connector_state(=
state,
                                                                         co=
nnector);

-               if (IS_ERR(drm_new_conn_state)) {
-                       ret =3D PTR_ERR_OR_ZERO(drm_new_conn_state);
+               if (WARN_ON(!drm_new_conn_state)) {
+                       ret =3D -EINVAL;
                         goto fail;
                 }

--
2.34.1


--_000_CH0PR12MB5284A4EC373224A8945799258BB82CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo Pillai </div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Monday, April 21, 2025 12:06 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kaz=
lauskas@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;=
;
 Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@=
amd.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;; Dan Carpenter &lt;dan.ca=
rpenter@linaro.org&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Fix NULL pointer dereferences i=
n dm_update_crtc_state() v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Added checks for NULL values after retrieving drm_=
new_conn_state<br>
to prevent dereferencing NULL pointers.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update=
_crtc_state()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn: 'drm_new_conn_state' can a=
lso be NULL<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c<br>
&nbsp;&nbsp;&nbsp; 10672 static int dm_update_crtc_state(struct amdgpu_disp=
lay_manager *dm,<br>
&nbsp;&nbsp;&nbsp; 10673&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_atomic_state *state,<br>
&nbsp;&nbsp;&nbsp; 10674&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp; 10675&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *old_crtc_state,<br>
&nbsp;&nbsp;&nbsp; 10676&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *new_crtc_state,<br>
&nbsp;&nbsp;&nbsp; 10677&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool enable,<br>
&nbsp;&nbsp;&nbsp; 10678&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool *lock_and_validation_needed)<br>
&nbsp;&nbsp;&nbsp; 10679 {<br>
&nbsp;&nbsp;&nbsp; 10680&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct dm_atomic_state *dm_state =3D NULL;<br>
&nbsp;&nbsp;&nbsp; 10681&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;<br>
&nbsp;&nbsp;&nbsp; 10682&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct dc_stream_state *new_stream;<br>
&nbsp;&nbsp;&nbsp; 10683&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
t ret =3D 0;<br>
&nbsp;&nbsp;&nbsp; 10684<br>
&nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp; 10703<br>
&nbsp;&nbsp;&nbsp; 10704&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 TODO This hack should go away */<br>
&nbsp;&nbsp;&nbsp; 10705&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (connector &amp;&amp; enable) {<br>
&nbsp;&nbsp;&nbsp; 10706&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure fake sink is cre=
ated in plug-in scenario */<br>
&nbsp;&nbsp;&nbsp; 10707&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_new_conn_state =3D drm_at=
omic_get_new_connector_state(state,<br>
&nbsp;&nbsp;&nbsp; 10708&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; connector);<br>
<br>
drm_atomic_get_new_connector_state() can't return error pointers, only NULL=
.<br>
<br>
&nbsp;&nbsp;&nbsp; 10709&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_old_conn_state =3D drm_at=
omic_get_old_connector_state(state,<br>
&nbsp;&nbsp;&nbsp; 10710&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; connector);<br>
&nbsp;&nbsp;&nbsp; 10711<br>
&nbsp;&nbsp;&nbsp; 10712&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(drm_new_conn_state=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^=
^^^^^^^^^^<br>
<br>
&nbsp;&nbsp;&nbsp; 10713&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ret =3D PTR_ERR_OR_ZERO(drm_new_conn_state);<br>
<br>
Calling PTR_ERR_OR_ZERO() doesn't make sense.&nbsp; It can't be success.<br=
>
<br>
&nbsp;&nbsp;&nbsp; 10714&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;&nbsp;&nbsp; 10715&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; 10716<br>
&nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp; 10748<br>
&nbsp;&nbsp;&nbsp; 10749&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;abm_lev=
el =3D dm_new_conn_state-&gt;abm_level;<br>
&nbsp;&nbsp;&nbsp; 10750<br>
--&gt; 10751&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D fill_hdr_info_packet(drm_new_conn=
_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^ Unchecked dereference<br>
<br>
&nbsp;&nbsp;&nbsp; 10752&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;new_stream-&=
gt;hdr_static_metadata);<br>
&nbsp;&nbsp;&nbsp; 10753&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp; 10754&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;&nbsp;&nbsp; 10755<br>
<br>
v2: Modified the NULL pointer check for drm_new_conn_state in the<br>
&nbsp;&nbsp;&nbsp; dm_update_crtc_state function to&nbsp; include a warning=
 via WARN_ON and<br>
&nbsp;&nbsp;&nbsp; return -EINVAL to indicate an invalid state when the poi=
nter is NULL.<br>
<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Cc: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Reported-by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 31a5b8fc4dc4..3d2ff5d58067 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -10858,8 +10858,8 @@ static int dm_update_crtc_state(struct amdgpu_displ=
ay_manager *dm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_old_conn_state =3D drm_atomic_get_old_connector_s=
tate(state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (IS_ERR(drm_new_conn_state)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D PTR_ERR_=
OR_ZERO(drm_new_conn_state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (WARN_ON(!drm_new_conn_state)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284A4EC373224A8945799258BB82CH0PR12MB5284namp_--
