Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D2EC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 19:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1164810E305;
	Wed, 15 May 2024 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJYcGdQO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340F210E305
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 19:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+xrQNWYbw1cRbma4AuTmgEhlT9nZTwExqyLOn006KDyc0f6+u1oUM+sHDXHrE5bqPJLRONc10Iniehuj5jzar01fuVQPtcBWTebeGBVIp0qkgseNjZRNYfkhGPMsnQl5EcbWvJpqcqapSyXYcdQe+/t5jAKrGQd8ZAcEQnYhEYdnAUfQOUXcjPO19vWCIYGwJUssxkqvphLaHG59vm4Q0WHxcKeySxPWqO7qo5H+s+AYLw1YsC7Cntf7VI5Owix8sdglfj6S7MJnOLG8CXDiNv4fVcmv3ulMhiUPNvUHPqGRD5pJsYxYIhyGMq7GVdgdXbwoOfWi4q3rRXNpoA81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gigueXLwG/ol0eer/gSMjAodEOZvSx0viapV8tzsZiM=;
 b=lrc8PaeuzARSUxjO+Kovxx46dVf/0aUDCxFUXxUI3YattafAQLXWJOBdc6pimWLB1FVPnYZ9EoPb3OGzLRTUfJpYBh39q9TztBgJ/ZOPYXhGEz1tb8u98ESwckobs7MbpEltlIRlw4V8WL82TVI8DT+FcEutkJZYG54Ki1TSOuBMFP4RgJtuN0yXo3QxkVomC3RPRO4Trvx23zXWRcmQ5vz2/uisquAj03GJNH7PsCDr/HZLcW+wYlMkDpzio5meIkVX1pHOXeZmA/JYp0mdDXtdOkc4MY2sarx4szf75X30jcALbo9WqYxGxpVytZLvEOO3v027eXKu1OZ/aSGMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gigueXLwG/ol0eer/gSMjAodEOZvSx0viapV8tzsZiM=;
 b=nJYcGdQOr4dPWvqCT4PehImbaPjkmT56ooaY9pNpzJmAv7uoH/v9FyQw71baySoWMO7aQHSRkGaQfV8q6RgDuIsnEeLV4aqIFz57vXPj9bzQHeqKcQLSYd6eMwQSjzd7G9xRZ5ftH87gRx6L2oNU+lhnW9uAIFt7D/fIJYesfok=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 19:48:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 19:48:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH v4 10/10] Documentation/amdgpu: Add PM policy documentation
Thread-Topic: [PATCH v4 10/10] Documentation/amdgpu: Add PM policy
 documentation
Thread-Index: AQHape7Oiot5vwX7SEKaI908Y6HXarGYtURA
Date: Wed, 15 May 2024 19:48:31 +0000
Message-ID: <BL1PR12MB51444DECF335A55BCA9F7AB9F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
 <20240514110606.396234-11-lijo.lazar@amd.com>
In-Reply-To: <20240514110606.396234-11-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0e68bbef-9a60-4bf9-9849-dc5f741134ab;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T19:46:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB9194:EE_
x-ms-office365-filtering-correlation-id: cfcdf7bd-2cb8-49c4-935b-08dc75180007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LP2IYVagPEWGM5+1ZaR1ZvOV9qLHCOkRqqXFuvTjqZ9bNlmSSgsSCev/yIG4?=
 =?us-ascii?Q?xYVIoHi0HtwO54pxwtGUXxEdJfwen5JYOgOfJjbFX32rj2ME0/3fuU3gABNy?=
 =?us-ascii?Q?AxccQuqXtWybE17sotZlBxkg1sSkrK4A+yidyd+hIbLA+d4TlnNGmNf/klhR?=
 =?us-ascii?Q?LRVUI4dRa6ec0LrWf4k0zYEUblyBWfqx7JSws+NQR4bg4pncMLy9GC/xjJlD?=
 =?us-ascii?Q?3NmzW1qNAbnqf6TdaTY4aYQOUAzHhjsh8FeEzgF8j4NNy9hNjQqf3wEVYY5f?=
 =?us-ascii?Q?bq0UvevIXeqTjId7qqoep1wMpF3+fUi2XSqvy/xmvOaj9083ovQW2MurB/ra?=
 =?us-ascii?Q?az2VJu4f13ywSiOmiHtYue6Jjefpyh+IDltaGg0pDIjLzEqqTTGxZzjhpDP4?=
 =?us-ascii?Q?Wf3POXCmLDw9Dbj3mKrl2Xj1M71CJP4teJn0AMslVEZLeO7IcIz03s2a2iuv?=
 =?us-ascii?Q?uhOEIVf7mT3akflJxoYfjop2Z4uy+B5QF0YmoAXiA4A4XFyKBFptSxuY9Gbd?=
 =?us-ascii?Q?k8SUs/KCwWFgd4dEX4/oBtKeFVyATXxbX1F3uS8zWh8tPW4/7758KN1dFkzh?=
 =?us-ascii?Q?nIaGD4yAwwHULvfBuZNeASmF4DdEHeNxhXmJz6kMSx+NKG+PdkU+GvAlrU86?=
 =?us-ascii?Q?VhN67J4M1Z2kAb3dEkEZ5UJoMy1Gi2Zosa4kmnjkYdhyQOHSzE0+1AaRyaX1?=
 =?us-ascii?Q?hK093tNral/61JatchbbxtPFKTYj9V4SFap4TxWEvrjYq17Z5wQLwkWG0TsU?=
 =?us-ascii?Q?lot4Z1DTMh+QRh6ShE/BnRCH1PT7PPjFFACdKuEqswBCIXu3HjoVUoMcvns1?=
 =?us-ascii?Q?0+Jfk8VNAWTkNyFpKGBRDu7b5Vm/sBhqdf7o7nKD0vf4D0UC9wILNPXnRlTe?=
 =?us-ascii?Q?F++n99qCGL/XeLGX8lA0oqpPTCDLDVg8o3qT0pLipTW1rByICEv3VlMAMd3p?=
 =?us-ascii?Q?7G3gTS5CiVSpfxCluC76RYxhfKnxnB87fdUoNT6xIXR0LThO91MhsEix4cb4?=
 =?us-ascii?Q?Nu6UQBajFfWyjxbCYgAuiD6XLZ07dQkkL00dvykXNYPya/5MVGXHo5IW2kmb?=
 =?us-ascii?Q?eogzie3Sw9VfDeCYx0EK4RKlMdjEAzmNg4K5TgDhxcONDIItfk0dBq5gjxgQ?=
 =?us-ascii?Q?CduayiAOrWSJ4fJ2oDqu55hoHRmJQu+blSWTFFP6eifBiJidUNVN+EzApbB4?=
 =?us-ascii?Q?zBlfbIspdIvzN2CboQg/Dm0UChWJtdcCITC8HPGyN8x5tS/wsYk86YigJ5Wr?=
 =?us-ascii?Q?F8SJ3p33tFD6WbJxicVnErL74dVWNKcDEeD4kUAgrTQspnQJA8/B8Fwekvn1?=
 =?us-ascii?Q?KHhZqoG4xP1b/KeqfLvMOz7JgZkkEIi5MGTV3k+L//mBOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s7dnX+m7gy49/DM8jvVPYw3GSg1zJfO4ET/oDqsSep/E2rbtSSTJTDBUv9yQ?=
 =?us-ascii?Q?0a3XIigiYhs1BAino6Om41jScWBWQOnNbXbSbyPgEPGIucqVNPvcwkGdroqM?=
 =?us-ascii?Q?00s5lj3FjkEI6CxmsoFt8I3xMc0jc19CigGA+sPdW6CYZ7Cara/ncIkuSGBh?=
 =?us-ascii?Q?O0MOpfb3pX5FQxmBH/nAlGgQ1/Txwn/f28EEucA/maaNJmDum9KDdTjB0glm?=
 =?us-ascii?Q?NqBmO8opiiNxWoEwr0xBOn4o96Pg7en7rYHsL3hWcHtfMcmQC+EYL4oWjxe/?=
 =?us-ascii?Q?Wmbg2e6WiTtANopdJi/JDTrKTl6jub1G1EQemgPWFMY2j/Pa9TtVktaI9TtM?=
 =?us-ascii?Q?J0L7xq075HMwgOXN3zyYGzDm9KJ3tVm4sRU8s6vAxLkxQJLhn115P6W+KAA6?=
 =?us-ascii?Q?lBaA7vdQ/ICmaA41hul5exneRLP/3SXiKWTeBbuHtxo+izrCac4Zt0NFcSC4?=
 =?us-ascii?Q?mCNUQsA4ijMTJzqOX5Y0Mapw4CIg2LOOlW2K4hz1NAF0wFRQpGsz7ljy59QR?=
 =?us-ascii?Q?9NvZ7gc7LlqEXQQ+XNI7Z88ZGNPwKdlBowTj4UAHJOFcj7l2bLoFYB0bKV+7?=
 =?us-ascii?Q?i73g5hLgcegEDEYTHwBmK1RZLtKVFVRFwpDeKYjIq/yHG+BcBlUf2Kd2Zkx9?=
 =?us-ascii?Q?mZna60hTA6fHjIrStaCf6BJ4oHifwaM6oD/uoA8yhSYVpYhEd42BmMS6B6vU?=
 =?us-ascii?Q?aQCh5jgRNG3LQNZQsQQ7XrkMyoQKGAzPkXVJX6x2mkcJpuA3ISEAWNY+xvae?=
 =?us-ascii?Q?WizXhdI4vrCvsLnFIeTWRlCjpZZRHwxmgwC9GXISobqqa3cjgqWfm5EuZ6KK?=
 =?us-ascii?Q?ju9EONAuFMdp3dcVCCP65jR2SlvS39l9PMrUnsWQY9XViFn1GmMspbJ8/Myc?=
 =?us-ascii?Q?U5Pd5i9buV+G73DfjcV+1+xPj/0p35WYL/UQ2zx8ZHqmMrjGk8JKdjPoJAGq?=
 =?us-ascii?Q?4GSO2GNC4VWNBkC13pGe72TlIvSDcs4VPbnVBNbfY41195SH4JGjc1gAHGYF?=
 =?us-ascii?Q?BP8p5sGgZBJahWytButDnvbq7GB1irdjI9yCtVXLJm4qLoMQ3cyt6ht0D8Qw?=
 =?us-ascii?Q?Ijs+TrLxs3o+sPhbrf/ZKKdkjr6nq8dgIZz5MqEFWyChpeHsP2bIlTxNZxX4?=
 =?us-ascii?Q?Qn8hCpob39XViWdY3xHD4ome+kqVjlB4u3ukutdaXMCPfNtoNdC/oqH3keIM?=
 =?us-ascii?Q?+e+CBnT236dZFqJYukGSJfiN/csYtbivrZl0X4U6XHBqEdW9t+uNl9aujJoT?=
 =?us-ascii?Q?OE4EOHYWIj/XLKmgQgjirPwR4jCcLSM7tK1tei5tP+rFm1y8ZnSENWERyp5x?=
 =?us-ascii?Q?60OkUvr2pcxeZ1eQDHvc2heCXOKvgquC3ei4M1FhGHt+O1VdG+wpcgMxTzDr?=
 =?us-ascii?Q?eMQNDIlaV9kV05sKkih48yQPjPIVfkzlfYM7ncX7l1K4kM4Pu+YxMsLZoXmh?=
 =?us-ascii?Q?l5gbljVTg28yfmFCyxbHSkZ5f718FMB5qS73Kk+ShW9V3I19mMHUXb28oRnQ?=
 =?us-ascii?Q?5RnoPlLGkQyNwMBH1x5dimJKTPmraeTVF8j2I9II4UqqNf2HVqiV1Nmbc/lW?=
 =?us-ascii?Q?8mFL53STLJpNlPmmuBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcdf7bd-2cb8-49c4-935b-08dc75180007
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 19:48:31.9857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBJQDlFqgbxbetgHEMQ/Pp0t1ZiMMKjR6QY3+myXYXS9+OtIRD6Y4X1moSiIvWCvfrlm+HxPlo9xpZSPWP4LsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, May 14, 2024 7:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,
> Le <Le.Ma@amd.com>
> Subject: [PATCH v4 10/10] Documentation/amdgpu: Add PM policy
> documentation
>
> Add documentation about the newly added pm_policy node in sysfs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  Documentation/gpu/amdgpu/thermal.rst |  6 ++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 48
> ++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/thermal.rst
> b/Documentation/gpu/amdgpu/thermal.rst
> index 2f6166f81e6a..6d942b5c58f0 100644
> --- a/Documentation/gpu/amdgpu/thermal.rst
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -49,6 +49,12 @@ pp_power_profile_mode  .. kernel-doc::
> drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: pp_power_profile_mode
>
> +pm_policy
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: pm_policy
> +
>  \*_busy_percent
>  ---------------
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5c92c041d0bc..be39276181a1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2214,6 +2214,54 @@ static int pp_dpm_clk_default_attr_update(struct
> amdgpu_device *adev, struct amd
>       return 0;
>  }
>
> +/**
> + * DOC: pm_policy
> + *
> + * Certain SOCs can support different power policies to optimize
> +application
> + * performance. However, this policy is provided only at SOC level and
> +not at a
> + * per-process level. This is useful especially when entire SOC is
> +utilized for
> + * dedicated workload.
> + *
> + * The amdgpu driver provides a sysfs API for selecting the policy.
> +Presently,
> + * only two types of policies are supported through this interface.
> + *
> + *  Pstate Policy Selection - This is to select different Pstate
> +profiles which
> + *  decides clock/throttling preferences.
> + *
> + *  XGMI PLPD Policy Selection - When multiple devices are connected
> +over XGMI,
> + *  this helps to select policy to be applied for per link power down.
> + *
> + * The list of available policies and policy levels vary between SOCs.
> +They can
> + * be viewed by reading the file. The policy level which is applied
> +presently is
> + * denoted by * (asterisk). E.g.,
> + *
> + * .. code-block:: console
> + *
> + *   cat /sys/bus/pci/devices/.../pm_policy
> + *   soc_pstate
> + *   0 : soc_pstate_default
> + *   1 : soc_pstate_0
> + *   2 : soc_pstate_1*
> + *   3 : soc_pstate_2
> + *   xgmi_plpd
> + *   0 : plpd_disallow
> + *   1 : plpd_default
> + *   2 : plpd_optimized*

I think it would be cleaner to have a pm_policy directory and then have soc=
_pstate and xgmi_plpd has nodes within that directory.  That aligns better =
with the sysfs model and makes it easier to expose different policy options=
 for different SoCs.

Alex


> + *
> + * To apply a specific policy
> + *
> + * "echo <policy type> <level> > /sys/bus/pci/devices/.../pm_policy"
> + *
> + * For the levels listed in the example above, to select
> +"plpd_optimized" for
> + * XGMI and "soc_pstate_2" for soc pstate policy -
> + *
> + * .. code-block:: console
> + *
> + *   echo "xgmi_plpd 2" > /sys/bus/pci/devices/.../pm_policy
> + *   echo "soc_pstate 3" > /sys/bus/pci/devices/.../pm_policy
> + *
> + */
> +
>  static ssize_t amdgpu_get_pm_policy(struct device *dev,
>                                   struct device_attribute *attr, char *bu=
f)  {
> --
> 2.25.1

