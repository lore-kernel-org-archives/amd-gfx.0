Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57B9C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 14:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E960210E6B5;
	Wed, 23 Apr 2025 14:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQBZFtFu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255F510E6B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 14:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ+w9p1hgcUX4FHATJGCoxa8qPUYg33mWkJZRMzKNB6jnr+YfT2WN1oLrmcSsggj5Q73Fex5Rtf23EN/mBWw+MI/5GQ6g75UPT44xW/ezXWYy7O/1I2S4a3JysAxhR/dINPnfvRnp1/FASyGQcik8NMBEfL3t7HC1NqVltZ7T7QzSgQTOWu0fJqRsvOkaPAp+3+6J3iqGHSHVF3wmQndUwW8xSLcKIe6TMfjxFHCtLaN3ayHzduyW7qr1fAWSjtLROgxcDGawNP8X7K8TVhvA6VJH79rtG/3kkFIj3584EFqBX7G0Legw7unVPmDBgQmr63RWKL+a4l+jvwPqjJj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iReZKcaG8sT/K9H51XA3GC69MLgI7zo7CW2TD3IzaNU=;
 b=PFPqPnXBziyYs7c7pm/iOW0YGZ43KGCXiiK+pK5Vjxe+sad06zeA0TW1mxMyQVd/KpLhhlWLKVv4BP3uQI0yvmrbgl/5LWBrVJ2foV7B082Hpklyu0nTurVh75qZKTMscSu4T471rdaIYKDngN0i+ny/tAF21XX+uMFLvYFmrvAkI58xYm5HqlUvOCtj+XL03PWf0PgJhIhJpBrahpNIu6DT0vcLbvYTgbU+BTZTPcnqBT2nizTA3hUCOrHXk6IxWYfUR1GajWwOv+ce/vED5+fmD1fAW/ZjPGHi+I5R+/vbfWkrx5yL2w39UIgo8qQ4FLY566EBF12vsviYkMWcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iReZKcaG8sT/K9H51XA3GC69MLgI7zo7CW2TD3IzaNU=;
 b=MQBZFtFuYNqsz3NrkROd/dXSw58JY8zlU5V70FWENFUJ8nN8GM073iT/XHQv05HzHFUndBibtCZSutIrmsKOJ76oIp467aDUm27BcPTbv2PSNp4q0V8RyanAI/goasu2jl8WGJB/ptVwZxQdhHTWUSofpOIIeJIRUCak8bE4iNA=
Received: from DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) by
 CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 14:06:15 +0000
Received: from DS7PR12MB6046.namprd12.prod.outlook.com
 ([fe80::959f:de78:963f:9f38]) by DS7PR12MB6046.namprd12.prod.outlook.com
 ([fe80::959f:de78:963f:9f38%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 14:06:15 +0000
From: "Zhu, Yihan" <Yihan.Zhu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amd/display: Fix NULL pointer dereference for
 program_lut_mode in dcn401_populate_mcm_luts
Thread-Topic: [PATCH] drm/amd/display: Fix NULL pointer dereference for
 program_lut_mode in dcn401_populate_mcm_luts
Thread-Index: AQHbtFQhVWuBEQk9PEKVrL3RAior5LOxSJWQ
Date: Wed, 23 Apr 2025 14:06:15 +0000
Message-ID: <DS7PR12MB6046CAF8F49C38AD3C08A03DE3BA2@DS7PR12MB6046.namprd12.prod.outlook.com>
References: <20250423133156.3877781-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250423133156.3877781-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38650af4-5c33-4d77-9103-70b43fdba636;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-23T14:04:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6046:EE_|CY8PR12MB7610:EE_
x-ms-office365-filtering-correlation-id: 39502426-90a8-48e9-ffea-08dd827002e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KlX9ZVD8aOpQlAAXTP9jA4n8gnikkxCpzvK+QaVNHQ9eM8UPwj9goT61n7v9?=
 =?us-ascii?Q?mQJzY4fH51Q7mxTTy/fIXO6KBTXhUmPTiu1cDq5TKAHgbgIncdpjgG3mL4iY?=
 =?us-ascii?Q?fbDgOuWY+mF1SfKn/qL01k3Xe0jBJZSCQfYOSOPShY3UaatSvl8mlcJGvHxN?=
 =?us-ascii?Q?ghlD1v6O/HgE5F8XJ1Gjk0bc3ialTXWWidgOJ4+pxn7j9BNW9oEyZmGbQcKP?=
 =?us-ascii?Q?DrzdCnHdmOQ/8whwyNgqjrAYHib9LBZfRTKIqNSTq72V8HRAeweGbjVhIyfY?=
 =?us-ascii?Q?RlGaU5IHqSGEeamIulaVUvbOKxhX2gEMgJTrO6em1/zddJEh9kv1cjLxjoaL?=
 =?us-ascii?Q?EZxP8YYphw+EeoJnFo9J84RcQ5wY5vaSq3CLFjd51ZsobnPn184BaE5yv2zg?=
 =?us-ascii?Q?esIjgV0xAcxk3mo1GJPQmL83GzK9rVjB0fz/DnVGF87wrBTRGRWezb03Vovy?=
 =?us-ascii?Q?qE2Kfz1Bvv2aqY6oFzF+mnnxoiu0JrhZidZt0kCUx6ZwsGrqD3WTuEkMeOzJ?=
 =?us-ascii?Q?ZVmdBFHnFlVaKaD1CwAoyz4LHpNfqSS5MX4YiyzmSRre+9KvdQtWcwz+ubiF?=
 =?us-ascii?Q?FK+DPYN7hTyxwD51AINC9KsvgDWh8X3+9j5yaN8f8dsD8tfNldSwO60pPidw?=
 =?us-ascii?Q?5x0ykKdO1wcxOA8Oc/uswn4kUmfgn7WfYg5vjcOiVevbSmaP9lweFlwxn9S1?=
 =?us-ascii?Q?EqhsOtJpl2Uxh5RjSIc9Li76MC9Ayi2TxP8q5WE09APaCJw4kkdYny7VxJON?=
 =?us-ascii?Q?5KzkFOGfYYPCd7o10GaS9H0bK71bHaBPJgzj28ovOT3kRjDC/NirfMUt9Nde?=
 =?us-ascii?Q?adhxaU02OJNyUB1T/PaZN+919ZIDfer9cQ69DZ2HpfZ6O8UVx779yxQrWDg9?=
 =?us-ascii?Q?KGf5kB+M6S/iA95jOiZvpcOHxY+cZvh/3I1AG+rPWSTvZNmYpRbw5CAOiUs+?=
 =?us-ascii?Q?RFwqa5m2XRVdLDVZxRBLMIN1xzF565TovErlPSJydQrHSym1GhJn8uhEm9tw?=
 =?us-ascii?Q?9kEjLk8eI/BOycDDhLtqfOTSc9fej72oMncRgcRGQ0aBmMd5aZTA7EaFhnRu?=
 =?us-ascii?Q?PDHQSIMfIDGhE/CZKC8XcKInsTqFqyDivsBoBozCnkhTqm6u31v5YaxYPGTG?=
 =?us-ascii?Q?iiSlb7c1nYXXmxbCwjr9ZiaI0H/NPBG3jcow8e5UzUl+VemZtwYuLmJVKkp+?=
 =?us-ascii?Q?0CTbsOfSk6imPkLshbuNMGldqxgIIJzuAwjZt4F6URIY5PRuHCv7ODpu8a3K?=
 =?us-ascii?Q?rF4L7IiEDcxQDBYdc4YaTkpXryl5omUQ/pm3FbmeydkW40RGDDEe5/FvHWlN?=
 =?us-ascii?Q?a0X4SZ6VS6U+tZui6Hg60A+BRAkvTGOXD52YUblJknni1uDCaw1MhEjCK45a?=
 =?us-ascii?Q?EGrtGi5+jGmJ3FIf1o6ux56NINtdhNyx0zF+Cgud7bE2iijgQWhtVw5kU6Xg?=
 =?us-ascii?Q?/Zeo4blxxFwvCbJ7ta4bCF3l2ehRZXncDp8FBDBy8Oa6/QpERrlpBWn2pTzR?=
 =?us-ascii?Q?VB7Xddnv7yOOoj8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6046.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KOraId41WjETrKqpRjFs32xcopmT5ADMIbGoQuAJUF+j6qgTmZ1s3QFkDqDB?=
 =?us-ascii?Q?FJqwW/UqxA2HzEOnCR+4KrK67TqGxzL7ypR8h4Yf4Icl8HYit3lUVYQbrXHp?=
 =?us-ascii?Q?daPQJCl0AdquDumh+SwF+qSExG3UZFVBX59MvGdCHDWdjFCuidsiUlRwW3ei?=
 =?us-ascii?Q?qJMud6Yyg52xkkAzr5F0yfD/kFwnoZePWl+UQnh9y8boYoD6clg1LPLHL8R1?=
 =?us-ascii?Q?lFbir3fmbRXsBvd1Siha20wB0adkjQ6IJ7l5mhHVuYJmUer7x4M9HO7G8JQu?=
 =?us-ascii?Q?QuEox/VW4zPIyODdLzN+eWl8eZUYU22tneVH6GvFavSpSOgDB/zoKQfBRTLY?=
 =?us-ascii?Q?3bkrByynPN6KV7pKWBrFqdUWQY5SzTJJM1lfGlnME0tRRRH6ZbYFz4LEalwM?=
 =?us-ascii?Q?GCO8rokkSeiY0RzzIrAa7aCCfZwemk0cM3a0pCstyTjQWCrrZvxrcbkknwUf?=
 =?us-ascii?Q?VUGWrQr+yQ2CZcXq4K0cDp0lWc6QNHUo4J2+FIouPhgR3QuXFuBpIA2vfuS/?=
 =?us-ascii?Q?+VaooSuJjw4q5gL8JZ2ba8rbRlIPSOu8/HOnrDHsTGZsFQApq/AWR7PMVAg5?=
 =?us-ascii?Q?jCyCklDVBgmytLo0hZsmK3kbbROZcy1CPBmQYp7w3bz/0YA42BYzTNFYDciB?=
 =?us-ascii?Q?Cy90h+ZX8P5h+aZgZ58zZCOhNd18C6QCzxsXtSd69pgUHPO+HC3eZgaE/hfs?=
 =?us-ascii?Q?BiQQXSIabBTdIZ5zEDgKOKclfpElIYo0bFYUrm3SfCnw8Fk4rFn3f5jiQtK/?=
 =?us-ascii?Q?b+qSCwxzQcvxo854H3104NJfH8Ce85oaRbmiW5bt7K0Eu0zkzqN/XpwzoK1t?=
 =?us-ascii?Q?e94XsSqfN6jYegQi0Ss2I6wA21TUxpBR/6NgBkz0UxBlCRx7ATlcUwcBXDLC?=
 =?us-ascii?Q?jbZ+SN7DT6YmWcu9i4Gv0Gz8dHJuHs51ziFbBF6ABLDjPeYOQOKOuMzNNQuq?=
 =?us-ascii?Q?YVK/NNSbax3M3p9Nmiv2XMguG7XzJCMv8J356UzTmL6ofcfFoXHljuSnR+rL?=
 =?us-ascii?Q?Mw8egLW4/vSl/OjVpRWc/C0eJkFMdwIggfu+RcUBNqdZBepZLxcedOi5xIVV?=
 =?us-ascii?Q?isgBobY42jEa7eJwPehYp98Ukd5uqt8PcBGnKkwvbIP0CeQ8krFAcpDnIaLz?=
 =?us-ascii?Q?8Ipb/haDkzIsF1cU4WgTo+39LiY55Pe39iROn+vc+dRjJFRxDlX+QpVZAwuZ?=
 =?us-ascii?Q?BZZdspi3QdIpUIJYM18j/S6oLpZ20wGObh8ZJke0vRQjS8ePi3Fj9F0rUZTs?=
 =?us-ascii?Q?WgDrezvegAaSP7WkhX6jxLWiZGBmspW101fDkqHwsGMTr5t0dSV0t5iuL99N?=
 =?us-ascii?Q?dx03SYG7SPNpIn0pLw7W2+gL+AqZ25SbBQ7wAq/gCS6vrpIXeaU1LXCvR18V?=
 =?us-ascii?Q?u68PhYvqTeDwU2rhvWPsC5yLg8FeH/e5AemC+bIJXjy6kkZ6+YfCYDiuimuV?=
 =?us-ascii?Q?zO8ZBDP0M3mKasnIjK0AIwwQVPbH58R8TCTzPVlLhlHbN3OQ7gJi5ifvZhBr?=
 =?us-ascii?Q?CZnQiScaV6eQzeTwkk0G1SQl7CYnmalGhIT62MNRrOB/N/6sbXbZR5Kej0WJ?=
 =?us-ascii?Q?As12ot9VJWAs0wCyRTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6046.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39502426-90a8-48e9-ffea-08dd827002e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 14:06:15.2632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2oA2ANv+DerGb0NsJ9xx0jUVrMFONk4oWttFC9ub4C0l7dhzQeKQKTpnh+b/vdnVCmZ1KZIppagSd/2zcYRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Srini,

Thanks for helping add missing NULL pointer check in the Linux side. Is the=
re any further actions needed from me?

This fix looks good to me, approved.
Reviewed-by: Yihan Zhu <yihanzhu@amd.com>


Regards,
Yihan Z

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Wednesday, April 23, 2025 9:32 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Zhu, Yihan <Yihan.Zhu@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chung, Chi=
aHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Rodrigo Siqueira <Rodrigo.Siqueira@=
amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Dan=
 Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference for program_=
lut_mode in dcn401_populate_mcm_luts

This commit introduces a NULL pointer check for
mpc->funcs->program_lut_mode in the dcn401_populate_mcm_luts function.
The previous implementation directly called program_lut_mode without valida=
ting its existence, which could lead to a NULL pointer dereference.

With this change, the function is now only invoked if
mpc->funcs->program_lut_mode is not NULL

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:720 dcn=
401_populate_mcm_luts()
error: we previously assumed 'mpc->funcs->program_lut_mode' could be null (=
see line 701)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c
    642 void dcn401_populate_mcm_luts(struct dc *dc,
    643                 struct pipe_ctx *pipe_ctx,
    644                 struct dc_cm2_func_luts mcm_luts,
    645                 bool lut_bank_a)
    646 {
        ...
    716                 }
    717                 if (m_lut_params.pwl) {
    718                         if (mpc->funcs->mcm.populate_lut)
    719                                 mpc->funcs->mcm.populate_lut(mpc, m=
_lut_params, lut_bank_a, mpcc_id);
--> 720                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_S=
HAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);

Cc: Yihan Zhu <yihanzhu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8611eb9607df..ae7194da5987 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -717,7 +717,8 @@ void dcn401_populate_mcm_luts(struct dc *dc,
                if (m_lut_params.pwl) {
                        if (mpc->funcs->mcm.populate_lut)
                                mpc->funcs->mcm.populate_lut(mpc, m_lut_par=
ams, lut_bank_a, mpcc_id);
-                       mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, M=
CM_LUT_ENABLE, lut_bank_a, mpcc_id);
+                       if (mpc->funcs->program_lut_mode)
+                               mpc->funcs->program_lut_mode(mpc, MCM_LUT_S=
HAPER, MCM_LUT_ENABLE,
+lut_bank_a, mpcc_id);
                }
        }

--
2.34.1

