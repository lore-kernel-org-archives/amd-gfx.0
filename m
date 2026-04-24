Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A31AFED3CC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 14:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C3C10F5C5;
	Fri, 24 Apr 2026 14:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAML3+k5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C72010F5C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHc37BrltdKHA5QYrphQCvGyqh5zcpbLyOMzewt0ZEXxGEvBBKWZIm6Xlg2fnbteMUgEKGkgoDlOgVVX5hq2SWA4v4Q3rKFeHXPsdh6U2uQ0i66PypY8Qjbz6ce5/g1/2FJxUDPvbENXrgtS1bqTae0DirT7J4fKCQAWzO96flUqAnt8TBLs0h7O+o06cp7c1aYyFLcnCmaDM0t4bpd+TyMieHdp0Qpo/3hPxvbyrx97wk6n5ctu7Wx4w5tLiM9fd+wT+d+oMrKtWCp1QfFrS36AjzJ5P6mKTkz3WxKscsUHm41UFrZ4bICbpYbIjnSjjzDZ4MNie7lG1usTuWMFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOhf6U9ooNBXc0a8WxL1F0hH8th6T3Bu4AL/Gna/gXM=;
 b=DCTHZT0oZEpLxJrv3ODT/xIidVCTXLYiCUFSGktMPkyEYQFWw2Exb2UcRY8sUhBH6uyDREMLVjc4HsedeCjb5OClUzNJAZ/99h1sttAHP4lF0a7Cz8N1V14m0cGBftQVnnZNI2BqW3xK208XI62VWPIM31qrgiObiiO01upcFfgKIjpdwqpTNKc1oQd0l8nFoqQTVPTD8O+RCdZNr9+YwMqnzQNIsFS19TLFZSgiG/0xZ2UrMTU6oYslixqhLZfNTjWiNpUEFn5gS0mSk1jbhpkv8r/z0D7VipBK+vqloR0fv0bgyJrf73KnKJjJu/6ohDwJ6UMlY29Fk/Y1ZG6cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOhf6U9ooNBXc0a8WxL1F0hH8th6T3Bu4AL/Gna/gXM=;
 b=PAML3+k5O/s9Fl1fhn+4up8F0tIRiiOU9JZkhOK/Xg5SKZKfyWl16wsqrsdhmJnrd8Vx33USaLjxUK5xOtNJijv8MnmEuIsZhkgvcYlsqh9zueSsiZEAv6veTVkGOt+0f8x7fMjkV5yHbW4yzx1i8wEuwuTYu2Afm4rmbpVs4LU=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:25:53 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 14:25:52 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, Mario
 Limonciello <superm1@kernel.org>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove dead init_mcm_addr_lut call in soc_v1_0
Thread-Topic: [PATCH] drm/amdgpu: Remove dead init_mcm_addr_lut call in
 soc_v1_0
Thread-Index: AQHc0/Px0DH4zYmOtUS7xjjPywuKSLXuRIXQ
Date: Fri, 24 Apr 2026 14:25:52 +0000
Message-ID: <IA0PR12MB8208795BD8AC81230E235FAF902B2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260424140755.2500419-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260424140755.2500419-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-24T14:25:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BN5PR12MB9510:EE_
x-ms-office365-filtering-correlation-id: 5487efb5-32db-4dbf-ef1a-08dea20d63f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: owgihn7dXO+b655m1tdSvjEL7xYwFvxRJzyQ056Z0J0P8zx/kza0nJlKmkzTD3dPLkO/2mKEZzePj2IUsQRTCRW9avZUoXKKn89bJQUWlir6M713I8wbB4E2TxQ4JVs2XBFusjuLBifGuyEbpAChqlRn8R69pc9juGkjR6sn1MPqw9HazB32MBCl56FuUjFZyOcN+b5Pe96kFQ7BH2EJLjWPSw2DCqqK9jAw/MbwhFtQhLM2JvWWcDdCPyQf2xTHOAyhhZCADdVQ4dyxkqDKvzQfXT088RRzqM4WN4OAUkRJxciUHrycYnan/kSnE3mW9+N6wlaUNCNi+dqjjDtGxeWKtZ7GxH5k+Z2trt+rkqiP/13wCkTGCpc+wKgHexemOAgJir5SQs9dj/t5Khss4HFL0pZmjIAWphU55G5WIA32ATG5VWKEIMjY55i2yEmfmIK6WDsfiG3KeQ0fGK/TtMQqaO353NLL7OzsbTE3V9eXc1nK5BwI+nkHaEjJEoR22znlkfKX6rSmCrousSrpYdYVMntCNpWtWhCZTgR8O8kQM66Jgrlh1OPd9elSyw10vHabiZWRon3s866is8ir/ku0Fy+3vdLZRx2uBnF6o8w2ch8bIzmQyeiN7zOw+dWHqL/01aiy809HoX/mJI5Gnmmb//zoqiuG++4dRM2QDpAHiEt9TkQOfotcT88s4c+QwLRFFNAY81MRijIeiM1vNQekgZ5N3VXlyRrSrvs13SGbP4XgkVf+kU2D/FDgFpRX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?acVIo7z85nnY8Ka/cSWg4vhnkUGqcBAlcGSyRbxfQWc/W4cDC/WojIEi/NHe?=
 =?us-ascii?Q?eosSL/ugRiryt4l77a2y/stpupqjmborNN/xTLK49Blzx15N2EURx9l8B7KS?=
 =?us-ascii?Q?qGQTGVWre491q5P7hDk8ctOUpNkXBZRGBhkMgOb8SnuVUi/jM1TnGQUZwZ6D?=
 =?us-ascii?Q?W2UoiUP52lIYAChmJVKyE20G1hbhU9tCkUoCy0S2XCQ3ICnfgMQf40uCKSQN?=
 =?us-ascii?Q?wt3PiuI2bBmrMlbaMY0FnGIuIEsbJoufJeWsCZgYhZ/bBNBxuzvspXY/n8mY?=
 =?us-ascii?Q?PyDTaqtvZU7UR4leYszn2GO08bUsUmg94lDeTWw+Klw3jlqYX5sAgyWjHZzl?=
 =?us-ascii?Q?jG0T0OJpXwtTuT4/6DyGsZ5NUBW3L5yU0x/dCtJmqt72HHSYjF15+tI3u+ZL?=
 =?us-ascii?Q?/Dj20yL/rvZ3v/NEqnjW8ITKHhemkg9ijsauR6jVYKN5gOUUKq+hH12CMADe?=
 =?us-ascii?Q?m5NhyvYATS7OmjR2TqR0cvZaU9JY23sIBD09WDtEpfeiRirEO32SSBgYgviQ?=
 =?us-ascii?Q?BBNVWPTcrX/VkF/y0jywbikN5DRuBV3K+qcWQY3r4QCrYNqs33BuYEXqZyJR?=
 =?us-ascii?Q?3Hln4xLNm5gBwllED+TxbGzz3r3/wyIR6F27nQImwvfvIxL+WnLVaG18oJna?=
 =?us-ascii?Q?u27oOAUrYWIVphFkQaQVo0YLa+d67PDGb6XZT8wewa8o3845A769fatd4dP+?=
 =?us-ascii?Q?DJ7wPHnSoTQSWriR90xI3Jg+4j9m0/46iHIRA1Vf9+9yqMfQyYO3wb4Dvxq7?=
 =?us-ascii?Q?R523ic0FrCAMNYNLYALfr7708mmiCnv5y5Jh9JWCCkLyucJ+lcmgoK3Zsydk?=
 =?us-ascii?Q?pYGS6FxUq0wFOsOFqdleuTeMU0t+4R5C4MT+dqARsDXK7gzb2wfLrndg0Hrw?=
 =?us-ascii?Q?heePFjzz7pDxRjpw5M084/mpqA4QqnBkC6H4dqIPC4SXQB9tjhMiv9DNZVjO?=
 =?us-ascii?Q?b/f/5J1HY/8cMEZ+kKlMAnMq0dXKXHGMXZjQESayCLnjUDwNzr9W0I+hMqm3?=
 =?us-ascii?Q?QiU16pXiXJzQEGUS1giiNPod78yPk//E7bHnaSrZrkXGrD7P0wQIZF2/mNZc?=
 =?us-ascii?Q?fXmK37Tm4tHdIPv6SZIPaW2v/NGRPrikud7Gyd/Blut24BaY8Rm5m7tBM/cg?=
 =?us-ascii?Q?lUf2Mbza+mjHgtvpGfysUuc0S2NUxYUaI7MrtvfSGT71da0f73qMVSF2Vebn?=
 =?us-ascii?Q?bhG43mE4JgBgtvBvD7Pb+OfWp54ZGUyIcEvuTmnhoN4v7X+YOI/v/H2ibymH?=
 =?us-ascii?Q?+slW4kH0B9kgJyay8tEEUFYct9W6QW4cH0ZgYS5VBrNQm1GEIL4u0db4J9g5?=
 =?us-ascii?Q?QcyPvQA3VQNYtDmW14f2LRLL15SJE7tWnp6rD/JQaHeoAn6LYCrxxIgK+n5I?=
 =?us-ascii?Q?lQymXKaqcDsrIxW4Pfg1kQJR0cvRZcx5MBUz5Ci2OTF6KPmsEpD/JlKoKBRv?=
 =?us-ascii?Q?gRwq1Wg20GsglqaLFPbhidjJPnob7ROfBfbtYLMnwPQGuftVKAgcgcft/yLg?=
 =?us-ascii?Q?IHnL98pkAAYg4pw78mMVMHUwQh9bqyKx4ctgy10rKlxw/16+CbBQTLUnQ+Fv?=
 =?us-ascii?Q?z/RdHAMmT4nSULhZv+mA+Ivu9aeg1a6lHh3mxlOCDWAHbzRrvuB0io8dGrKl?=
 =?us-ascii?Q?B+/mds7piu3Iqb8jmPWqi08ggxiEgl/47AmYu8AyxEOdl/EeKBGDKmYV1o3s?=
 =?us-ascii?Q?LLLe+kOKix7greERgCTd02DD4+AyQs8Y86H49CxELnv68XjB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5487efb5-32db-4dbf-ef1a-08dea20d63f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 14:25:52.8507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NHLC5gcxZmm4AhJS7x6D0SS8Dwav6uvB+0l9OsdenW511GsyRgkRHF/IJxVPqEyB9cEzIBOTJ2ntEBvWkBg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
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

This is already proposed https://patchwork.freedesktop.org/patch/720475/

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> IVAN.LIPSKI@amd.com
> Sent: Friday, April 24, 2026 7:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Mario
> Limonciello <superm1@kernel.org>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> Subject: [PATCH] drm/amdgpu: Remove dead init_mcm_addr_lut call in soc_v1=
_0
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why&How]
> init_mcm_addr_lut() definition was reverted from amdgpu_imu_funcs , so th=
is
> function call causes build failure.
>
> Thus, remove it.
>
> Fixes: 21bd78c821c9 ("Revert "drm/amdgpu: Init mcm_addr look up table"")
>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index d06953c237ed..f09d21738400 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -744,10 +744,6 @@ static int soc_v1_0_switch_partition_mode(struct
> amdgpu_xcp_mgr *xcp_mgr,
>               if (ret)
>                       goto out;
>       }
> -     if (adev->gfx.imu.funcs &&
> -         adev->gfx.imu.funcs->init_mcm_addr_lut &&
> -         amdgpu_emu_mode)
> -             adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
>
>       /* Init info about new xcps */
>       *num_xcps =3D num_xcc / num_xcc_per_xcp;
> --
> 2.43.0

