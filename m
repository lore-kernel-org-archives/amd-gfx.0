Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642ECCDE00B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 14:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ADB10EB61;
	Thu, 26 Sep 2024 14:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3aME3f+8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C09810EB61
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 14:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9CphEFF0mDMVtrtxARBjBeqo0y4QYUYkE2ybX7xWME6etO8iVveaYInaBaoosS0Fw5zA7X0iNERZB/Kf095ti/SeLdAmCw7/kcvNlpmgetGuUF+GgqkocpydalhCU0gSdPYoeV0ynVNGmvIxHqaFW//MB5aUChKvvWNhsPgN2UCY92Ep9kNgFKwDCR0XMhA+2luKabHj/yVfqwS/CfrXAlMc/B3WNBwZvv/vZRF8hTDSR4DfeAtNsjWmlOZKwBqhlaJqyinfpiBLkLSZ6CwkVZL3ScMzQCH4bCKElN6iLQjnqa5M5MduacyZcWOfq4OlQj57UVyIlBMGhtUtVPf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK6H0ZSl3h2HN+WKfLx5j1nh9vFRdYxIpbeNJgpmoic=;
 b=yfkup8MF0Bh7vx8Nrtoz/oshzFW0qC4Ogk61pMhsRy0IVJ2hzRYxI3w2D+NMaUPdKRfrPlnQv6zWnL4ZZ8ZGZJnrWClJr0Sb1NU8qxkTkir06/3bKUbZTg1Wns+bEi1U56o0FBVDf55OlAGH/8o+sPX4iJX6xJOLz4xGy5+j9nVDEA3+bGeRMAmP3YbXy3Y5v7qZRGn6/DQGbRitAXfkgCmkKrAbEVJZfoMkb2Jdc9D9fiy2iWtXvAatXB9wf/d7ns3mdgyc8TpWs+CAgaSJPOg76mUoHH2dMVqAG5D9zgWd7VHW+ZcK5gvQDsOaFpkSGkyIoZ87iXpMZFA6EyjY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK6H0ZSl3h2HN+WKfLx5j1nh9vFRdYxIpbeNJgpmoic=;
 b=3aME3f+8PvvVzJhEfs+R/5EQyG0BFcVnZKU0QCGdr9fx+rZJj2Br6CfncL/dJkaUN5nNsp5uTZhbVEvaALZ+/kvgwkTRHiDXpam/nRkgJ/ZvuKmBgMTFzf478Ftr9EjuKxjr0SZNYRwG0m969bfA/2e02o6ZwBJT57UHw4X2a2k=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 14:08:56 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:08:55 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Fix out-of-bounds access in
 'dcn21_link_encoder_create'
Thread-Topic: [PATCH v3] drm/amd/display: Fix out-of-bounds access in
 'dcn21_link_encoder_create'
Thread-Index: AQHbD1z+789zqiDFzUuo7kCDxz/EMrJqHHLw
Date: Thu, 26 Sep 2024 14:08:55 +0000
Message-ID: <CY8PR12MB81936FA2646063E08C95EA12896A2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240925150948.3331867-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240925150948.3331867-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d81ffea8-62fb-42dc-8d28-1b22d5ce3894;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-26T14:08:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA0PR12MB7773:EE_
x-ms-office365-filtering-correlation-id: 3f68bbbe-0e18-4c6e-3e59-08dcde34c23e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6iAjZWJV7Rd/hAzZHM8/aIa76g56HTlB0IDkzQ1kgv6dSi7LdD18tjnbQ9az?=
 =?us-ascii?Q?M78vf9qqEomHxJbaX2bRq3Cb8ZTTlBGcYuNilJ9AaHYEVNkow0Fk0WnN2lSt?=
 =?us-ascii?Q?HyGQPP8R6hpc0ZInXLXONOimejPgoWZSNJZLcOW4GjQbcTu5vEUhOfMeem2K?=
 =?us-ascii?Q?TqqaMfyqnoXMiLXbEwh1hnZNdVRyBkPSsCI6WetRg3esA2jJuSwnFFanmymB?=
 =?us-ascii?Q?2oJnp1WPtz3xzP7u4q9pNNRtPuyvjJuhpH5twZylJ3YrEiPj7MXRD04dgY0x?=
 =?us-ascii?Q?y/fR/KB30tCxFONWNytfKxcASBm0IQiM5LMRKOrguS+WTHdbLQYgk4uQDgJ4?=
 =?us-ascii?Q?fJ3qU6k/dkqQpj6b5x8wixNqktnYnPF8b7+ZrDyB4vjFG7aTSKIPJNG+YYeb?=
 =?us-ascii?Q?SpMLduIOLjWgiNjNLJE84SrpLkI9M7q5PQY1KceptNhDZl5uVhR7q6xkgdiI?=
 =?us-ascii?Q?4g/YASBz+woR3M2eGk51DXOTx13E6/CjEEYPJRht+C201ztrQmY1f2mhxGTU?=
 =?us-ascii?Q?18vBL60qAbLAwmdn5fONYGcgO3Q1Gjaf3d6jZiFAl/vM7r4QXbcitmGaxI68?=
 =?us-ascii?Q?7QY93b+6I2hrvvuGTcxy/xLo5A5aBHmWcQa3c5MLPPr5SCMplU1SDFnrkdDx?=
 =?us-ascii?Q?v42my/miEq021IyfyoWGmxYdjlccspL9WvIg7/OiHA7rM53zTz3Hhkq915Mh?=
 =?us-ascii?Q?rC2p6dXWfQoHPCZ4g9cVusk5G0cgy96dE86+XZGSqz+KWjx7Fxig/XK8T7ZP?=
 =?us-ascii?Q?gMFpy2gTbzrd1b+WVvranPYKWYE8OPgPHQlGuurCmFiwYIY911HqBboeEbXV?=
 =?us-ascii?Q?tJ+YkOLQxvmBiF7AJYa8ScEuqC5k5jVRil4hem20EJEovmCQLC2zDPMs3LNa?=
 =?us-ascii?Q?VYOuu6YmFfWVZxtmJ+ddDek+O7wR/dXi7jvZbuLOnXTqK+K806Y+gC5sHln2?=
 =?us-ascii?Q?oPrPVonU8qWS/60WleL3dsnYxFryW9RSt3pylhYIwYbny5P5+EHYBeWWlCsN?=
 =?us-ascii?Q?OjUxDM0rF7LP92J0e9qr0C2i4vFdXJZwUFLrVctsw9KsXY/DmuX7/DS/EHIM?=
 =?us-ascii?Q?gxYiZgW39hzMqm+uJ6KNjNQPg/d/G5nWEnAcUZLaQosAE5/F78FfxtU4/Jjx?=
 =?us-ascii?Q?qs/2PfBMfsltDmqDIMPJRCG911hr8uVC1tEjcKfsOJZBPyU4L/qLvgxKgnaI?=
 =?us-ascii?Q?T6T4WCg8663pU31ST+H1+1AW2A9xdwluAVjMhrUyXkprjfHpe2ah97qrIUgg?=
 =?us-ascii?Q?eDdRnv5ukrhbw7zoNkgRalmUKuWEGWlHquFakV917UC9tfla3igjK0zSXDPy?=
 =?us-ascii?Q?x8u17ny4mWRti5rjt7hDrBDHZKLqRYWzgHHwKJKys+oIL/I/fnLPYfvQWbdh?=
 =?us-ascii?Q?UtUwCT+yrxKLJnhsYDP8XxWbYzH2I7tazBXjDfJ/3ifMY19sKA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s36Zhmyr1O+YvVn9D/kpTOtHluX2tpcfXEOQiuZyjskcTgNs7UfzdW8K5GkS?=
 =?us-ascii?Q?bRsg7e7XIpJrEp9rpgXdjCvnRjpybuiCiBsfPdIi1U0ZmQ5aQFD3OdErgeP9?=
 =?us-ascii?Q?wCAMkl9fqB29omaAyaWrkY+TDg9gE0FxuB2y17U/6EVXCZclyVG3CNpsTxQ5?=
 =?us-ascii?Q?I6f4c/hnrJl6i0LBoS2veIcAmBqbWkktrn0Jbw0yCHR/d4stfdwNcdvPrgx3?=
 =?us-ascii?Q?x3XTEsaK4SZeJTckC1PgQqen/Z1hvTkMCuxOgmfKQ8Pjsb3pNgYishFjw2VS?=
 =?us-ascii?Q?4czi8LTgolSLYv1YxHYg24wd/zQHWtRcDFShjd3E6iARMmqR1CECicKEZ6ue?=
 =?us-ascii?Q?vvpPLtB8rlD0QlxPzvTM8IhQbXeXTSBZJmczeKZu09a4SHeZgu9jQhmOq8vZ?=
 =?us-ascii?Q?YBSkOzslMc8sxT0TGTc/+YFSsGnc4sh7DXLMAJzDlOpKzzDhedWjW5ZNgMLb?=
 =?us-ascii?Q?TJzyhWN0d0kIgJ70svBI/ZSOIHAMtW8SOOkvkPg0nnFfXGhIM1eHmoqNiePa?=
 =?us-ascii?Q?/ZzpXChV9ZAlUzR7nqDygVhvGROEqtxr25pDv+GIkJWe93ZMPSvD9f5I7A9a?=
 =?us-ascii?Q?7hZ+ZkP5+brcKxInUQM8P03NKjioaxnx47FLsnb3irdlKTnDg2WnHrW8J4u0?=
 =?us-ascii?Q?CC5PvJDZf9yHdhTHN6bFyTMrMUB3Gru1D/AeJhmJ0vEWo6GTZA8b2CkfWjfL?=
 =?us-ascii?Q?5WeB86IBmFvaQFERdeGeDLVN0sxUKOPCxhVa+pMUiKURW+6voe0VzawrAysB?=
 =?us-ascii?Q?ZhZDGffNZ1o3xEtWmbxNEi4pdJt0oNM57AcuG2WGYKr3hZj6MoDM9NGDjjiJ?=
 =?us-ascii?Q?trISh8BMe450hq8KrCf28nMGnlo8ciAXAAAxGuO4u/35hlxyAFFBAfFUi5PE?=
 =?us-ascii?Q?2tXhvls3tCMSIAyK51tzHITPYDZNYF9QKKGK4hWAuye6jMgPSJxOk2gdYhpc?=
 =?us-ascii?Q?B3QAOCMNKrYnr0ajB9sbNbLGZ/lJNrqSrJKXCbjpqLexfB/OBiA1OqqxgcBy?=
 =?us-ascii?Q?4WCtNSG+2i6F4qvUMP19yQWXLqK+tykUj3toVt+VPfvIiFEM5AY3TPe44DKW?=
 =?us-ascii?Q?YqK4OLp4HmOdIuxIkzdqw8I4cewys7KY5FWLeYMyiNLONTcGSYt1dlA0W2rt?=
 =?us-ascii?Q?FjZGJJSA6/XY/W84TXnyzLQD9hyB6/6fV50vwusfAis3U05r7lMe6EKldCKh?=
 =?us-ascii?Q?PCfZjHrb1Xd36hh9QfPljHJ/feuyT8c4HplAT7z+dMpXZdZVnc6cfPSGt+FU?=
 =?us-ascii?Q?0xFzN2hseMM+WduMcoWxQtSyNc/xyaBbqA9Te1S6NVfXbR1yIKRkH+uYWpku?=
 =?us-ascii?Q?G8iHNbjUuuLDizkx8HUJWY7wotLAwTjIUG9As+YxiuF8zxp5IzK9I/XdWCM6?=
 =?us-ascii?Q?9Javyak61c0q03e/V6vTDt0BiYR0fuSbVi8a9qKWiNYzI2BmXqVjwXQF6RYE?=
 =?us-ascii?Q?hQPVN0BNvSEShQfA37z8NtpYVNqINerh4fV7yRqCQnChDm4bl/3bC0ajTDS9?=
 =?us-ascii?Q?LvEpgR1KSQXQWMxcMnlJ7SR3qvCR95XGa3h0EYoBvIVbJaFSV0hJMxu8ISHn?=
 =?us-ascii?Q?YX85TWvIynS/pP5jYgk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f68bbbe-0e18-4c6e-3e59-08dcde34c23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 14:08:55.7880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fv89RTqyMsCGjbxaHN5HxOGKEA4D6bJg8/oDUBXxL2mUNTy9JWuS+t6YIx6kbA4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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
> Sent: Wednesday, September 25, 2024 11:10 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Mahfooz,
> Hamza <Hamza.Mahfooz@amd.com>
> Subject: [PATCH v3] drm/amd/display: Fix out-of-bounds access in
> 'dcn21_link_encoder_create'
>
> An issue was identified in the dcn21_link_encoder_create function where a=
n out-of-
> bounds access could occur when the hpd_source index was used to reference=
 the
> link_enc_hpd_regs array. This array has a fixed size and the index was no=
t being
> checked against the array's bounds before accessing it.
>
> This fix adds a conditional check to ensure that the hpd_source index is =
within the
> valid range of the link_enc_hpd_regs array. If the index is out of bounds=
, the function
> now returns NULL to prevent undefined behavior.
>
> References:
>
> [   65.920507] ------------[ cut here ]------------
> [   65.920510] UBSAN: array-index-out-of-bounds in
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:=
1312:
> 29
> [   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_regis=
ters [5]'
> [   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE   =
   6.8.0-
> cleanershaderfeatureresetasdntipmi200nv2132 #13
> [   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS
> WMJ0429N_Weekly_20_04_2 04/29/2020
> [   65.920527] Call Trace:
> [   65.920529]  <TASK>
> [   65.920532]  dump_stack_lvl+0x48/0x70
> [   65.920541]  dump_stack+0x10/0x20
> [   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
> [   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
> [   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
> [   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
> [   65.921679]  dc_create+0x360/0x720 [amdgpu]
> [   65.921999]  ? dmi_matches+0xa0/0x220
> [   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
> [   65.922342]  ? console_unlock+0x77/0x120
> [   65.922348]  ? dev_printk_emit+0x86/0xb0
> [   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
> [   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
> [   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
> [   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
> [   65.923087]  local_pci_probe+0x4b/0xb0
> [   65.923087]  pci_device_probe+0xc8/0x280
> [   65.923087]  really_probe+0x187/0x300
> [   65.923087]  __driver_probe_device+0x85/0x130
> [   65.923087]  driver_probe_device+0x24/0x110
> [   65.923087]  __driver_attach+0xac/0x1d0
> [   65.923087]  ? __pfx___driver_attach+0x10/0x10
> [   65.923087]  bus_for_each_dev+0x7d/0xd0
> [   65.923087]  driver_attach+0x1e/0x30
> [   65.923087]  bus_add_driver+0xf2/0x200
> [   65.923087]  driver_register+0x64/0x130
> [   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   65.923087]  __pci_register_driver+0x61/0x70
> [   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
> [   65.923087]  do_one_initcall+0x49/0x310
> [   65.923087]  ? kmalloc_trace+0x136/0x360
> [   65.923087]  do_init_module+0x6a/0x270
> [   65.923087]  load_module+0x1fce/0x23a0
> [   65.923087]  init_module_from_file+0x9c/0xe0
> [   65.923087]  ? init_module_from_file+0x9c/0xe0
> [   65.923087]  idempotent_init_module+0x179/0x230
> [   65.923087]  __x64_sys_finit_module+0x5d/0xa0
> [   65.923087]  do_syscall_64+0x76/0x120
> [   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   65.923087] RIP: 0033:0x7f2d80f1e88d
> [   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 4=
8 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff
> 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> [   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d8=
0f1e88d
> [   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI:
> 000000000000000f
> [   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09:
> 0000000000000002
> [   65.923087] R10: 000000000000000f R11: 0000000000000246 R12:
> 0000564c9c1e5480
> [   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15:
> 0000564c9c1e54b0
> [   65.923087]  </TASK>
> [   65.923927] ---[ end trace ]---
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>  - Changed to ARRAY_SIZE() to be generic (Roman)
>
> v3:
>  - Updated git commit message
>
>  drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource=
.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> index 347e6aaea582..14b28841657d 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> @@ -1298,7 +1298,7 @@ static struct link_encoder *dcn21_link_encoder_crea=
te(
>               kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
>       int link_regs_id;
>
> -     if (!enc21)
> +     if (!enc21 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       link_regs_id =3D
> --
> 2.34.1

