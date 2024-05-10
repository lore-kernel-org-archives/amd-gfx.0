Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D5EC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B7510E269;
	Fri, 10 May 2024 06:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g4SiFUMg";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5162510E269
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nroTiNs9ZqzZ9GrSjGMZi4+d4Q0n4yOj4C7ea5Gk/++Z+5TRipjC5Li+IguGnWokBvATJIHXXtSNcXhmEiBLNFUWDTHc0G6DZ/zF3QxBsJzosMXYBXspMwsBQR0kBCQ5e1pa21Iy7F3dSXkKlBQIVUWxW1eaBOAh6tqLYunQnXb+O1NBpZjPV22fKmzhi7f1GySPBfg2RAxMDReRds4xs8nPQgePsw0X0VPQ5WHlgU506UNEZaagXBc86kb06Qq+P3QrhNaTmr0fuh/7sXgs3vdN/gzO75Mz7QHcnxhHacX6xSCDAdV5mRuytdyF+iQP5EGfR5He3Xdz0V6HolkUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVWt/2sAH1hlFB1M0HnHgtASCwngn+xGrBvH/D7Ducc=;
 b=T1v0od7Cj7/5mfBOFDulQrTUVy7XVuJvVeUi5A19V0jTNvOkhooZvtSJCOqjj587aq9spnqw5VQDkRsLaDoPtudXG+M1P4qzl58Kp9JVuVE7lBkcgbRCpdp0njRWNF20aeYr3Oe7c2FY7/NpJ5cpNkh+0MHyF9QjEGBFzMsE2XFmnqf+UB/PDJeDLAzdN95/7a38+3mWC4AZKQZl3nwfm6CdmLq4BJS2r1YqQAC3L6yFZEY8JwogL3mmFQ+mwx9DtfDfLNfHDcZZO8MnnXmHf3+uglsVKrLICCTlsKWk2YeQoQDzxNNYbISLPYOAIJYOoe9rSWRJvEimdRXOqiVU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVWt/2sAH1hlFB1M0HnHgtASCwngn+xGrBvH/D7Ducc=;
 b=g4SiFUMgvUx5wYRIOTAwGH7BxPCGV0Pr/4hZX5uZkWmbo0UralEA1vjblm8PBJnenab0ModHIZ9QcNHL0TunsssZvaLSXso5ogJHPhhP5nOg2tQCjnLahwrWTFmDzYUY+YJWl/2d2IqM84wnz7pCH1jRejrySUeC4g51ACsCCjk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:37:16 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:37:16 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Topic: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Index: AQHaooUxdFmYbnGwgkGJQMb95ExOJLGP95YA
Date: Fri, 10 May 2024 06:37:15 +0000
Message-ID: <CH3PR12MB8074AEA25927E3722561012AF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-9-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-9-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ef11ab5-5bdf-4aff-a49a-495d6fa6cdb3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:52:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: 9e84abf8-599d-407f-9f6f-08dc70bba20f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YAqNTwRPME80ucK/CDtBzAOqBpvxtcXq7000E1PqS1sqYdBHxufjCBep8S2k?=
 =?us-ascii?Q?y7dac/4D3dFIWgaZBmOViIhpq5efqe6FwI2iNmiGFen8lPvZw0TkW2GwD2XP?=
 =?us-ascii?Q?09ER6zOrW7Y3CqEAm33T+ZS8Danhw5Rbzjgf+EdXhU3M2vZg9JUbawVuVBuN?=
 =?us-ascii?Q?75diZMDmp5f4c+vvw44NquyUKsUzvYVPgtWA1wkchtlQfHar6daj3gkkU4Di?=
 =?us-ascii?Q?oSIvp1XDToHRcv1gLe/OK40c8iqgjmV0nBTCYobf+rH3hujcMyiC/Qtgn99x?=
 =?us-ascii?Q?z0CzzEUrPzfJK23ZxtngjRzUsnjAu8IU5QFrHcM0spCJS7fJVtJ+qV1AXqHg?=
 =?us-ascii?Q?lrpCEOFKv6imjArdqc8icXzFW0FXiQzcL90fvr6ggJbBgw5QcaDoVcl8O8Xj?=
 =?us-ascii?Q?trQJ7Er47humRyuy6mfX4U6491botGyyGcGtd4QvJdyf5W9uLe7brHHbpYsO?=
 =?us-ascii?Q?9r5RQ+qvqTH6egW2LZt5sznR0TK/Vb6NKApgmhGrTQRW3EP97hzmmda89uFG?=
 =?us-ascii?Q?KqCVpzt8nYgmysHGZF7QL+eCZPzSfrYFqPZAjlWfAdemxIcHGYVKMrdoDOGH?=
 =?us-ascii?Q?Q5gp6xtrE9eOt85MkjNzt1gGtLnA6wYmxy3Phatlkur6KyCI7JEe4/z/+/hQ?=
 =?us-ascii?Q?ISsL/a6NL//EN6AZ8d7Og4zoFNM4a3xEyOhJga7/NT40ViLwHwNOVIw+rsgW?=
 =?us-ascii?Q?LLGr5IXYtvURHn75ib7GIzQGctclmeDfI+Slx/ulYaopsuFnuYOlYRNAJfjA?=
 =?us-ascii?Q?1UscGV4JpGP5gaCfsY+dXCFdgxIP46DvWOlFGqUw2CNCEPIhBZYHfYy4lsnC?=
 =?us-ascii?Q?z9jNxo1Chz7vQH4ouWKZGYSz0hWiTIIKMxyA8L0SS/yyzVuaEnu5fzkVVnbd?=
 =?us-ascii?Q?0CCxbEaQFEvPHGrF7Viq6j269o6VY9UoGnxtwbGZ933z+ryVtV8Vaq4BL1Ny?=
 =?us-ascii?Q?EXrm1oBOrfGItRi0f69TzOUflDOd8t/9cVdlOfI9IeXT2olxQdyhQ+/Z6r/9?=
 =?us-ascii?Q?lL3cwVhPiGprK+TeMxWPOlVqqZmf1xl2Dy44Fexp6viVNc2rfrB0gbPq871K?=
 =?us-ascii?Q?+84Vdfae55H53XYdyk2UxpfB+82gIbuIuAvb8l1HZ0AQDUi7krPtavsdtfMB?=
 =?us-ascii?Q?nEvYB0KCy/ITmXgILT+BSQ0i/882f0loggWAF8lJuYWuxMWWLbi6RxhlwXMX?=
 =?us-ascii?Q?wmFIrBSK3l5PuKgnUEFevothOupHnXTHp2GVlX84K23yoh2JDgR52FQiUnXG?=
 =?us-ascii?Q?FOrbKsjcSNeKPU6um3ltjC1EUnc5fCNwi7XQEZ8tzMzimM22CB33axmqqO01?=
 =?us-ascii?Q?KYnVKDVRt0cLtDDzm2cMZNqJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7nNyrraQ6Vqi0bBST6AObjsmN7uvIckZWW0NAzo6b/SlOuSNx2N8pjcRWG4?=
 =?us-ascii?Q?osTVrae37QK8BrKzqVXKZYk+78b21G9vd6Tb/IhdX2U0/WIBn6rYvTlR0fiF?=
 =?us-ascii?Q?seTmIXkYYCqRizjJX/iusUaOxlThR+R11VfRA9T4VilXeKbRFtr41K++S1rz?=
 =?us-ascii?Q?SFUWv8WORWqwfL6LHD8ZJwPoG/OxOQwo/vWlaHhRSfajU1N3N4gqj6RUQq2U?=
 =?us-ascii?Q?Giw/EHD7/GZwnljpCUdzkbLbEQ+1tBfoY0qfOuzMvuuhAsP60eoSpftWkto3?=
 =?us-ascii?Q?6E3NGLrpQlP+O+vY0jpyigl+WuMiASkzi5kTE3WjgmHF+Y91tSrDkdd9GxGv?=
 =?us-ascii?Q?ZFJTxpBW30B1SG2byxHhLrE7AWUQrf9LbeRYe9DZpyQCWH++Fni/wiX+x3nI?=
 =?us-ascii?Q?+qyyi9iIbfJwsc/ErOyeeK+TOKN9EVxhcUYcs5Ye6aoWcJ2FyULJM5U+7GPk?=
 =?us-ascii?Q?e770+0q3e1WBSjW/eK5sh+rLR31IIYSAKvu30EdZKVIGyG7nPQU4HqRm0iAz?=
 =?us-ascii?Q?mRAtyBZbqHiOvt6hYx/v24lCNHRr4vHz09mFO+F0ehkaTrdlX6IGtPKEPcra?=
 =?us-ascii?Q?UvrRyF7Trs5dPThLWcAox/OSGjnlcUxwV9xIi5eAUiqG+GFQhBFjsrHWOARH?=
 =?us-ascii?Q?bUUaqrloED+hKc0lhl+v0nBuSFnnsLwHxIePv4C78qJPfYsduDaBFYibqmq8?=
 =?us-ascii?Q?bitVdN/4BfWUxXPuQhO5dGPktRuzMCAv8YNe7tBVOjsD9KSH9AszFKXCwm52?=
 =?us-ascii?Q?eDENfh2JOfAKHA2xIMtgUMQ2sFnWHj0fcwUdrx3MUPSTlMOc6rcj1C3wHxsd?=
 =?us-ascii?Q?Kof0VVEL+y17yga1k8LM8Gjrg495TjjnyXPt02hMEz9FaYKCuXH446Fad2PE?=
 =?us-ascii?Q?+MbiR1dDtFEieQ7gHigznQN9l+3jhMHH2YCti4c0rkZncbpLhcsOGXs9lBpS?=
 =?us-ascii?Q?XhC9XG9guJl7iDJeULWflEzhs270NAKLMmNFWMsMVaO29oXmezHfN1ZWrEBF?=
 =?us-ascii?Q?2KDeRuvfs7wEhsx8RMt4SUuh+G8FCPjk+SEc5xrysVP9wIKalTs6pNYPBkj/?=
 =?us-ascii?Q?BCc3eF6UxFPepVmycjrzCgJo+a0CsOGyqkWnTjZC6yB0ZLOatrK+BOQtkAB2?=
 =?us-ascii?Q?CM24NXuzEt2X926VT4pB2rmMt2i+CTwWcre+vH/DTp6x3ITIfAHXchsUGR+P?=
 =?us-ascii?Q?10KEmc5NOpRcwysVc/5qmsJFI4dpsrdrUcG495PpWl8yU0fkK97e1rhTvq5+?=
 =?us-ascii?Q?4zJ2ZkdOuImZlZD1TB5RI6e2kK9oFo0hW0g8mYRCIbq9TJjfZj6gmZTSHWKt?=
 =?us-ascii?Q?MZKkNSutJpDy/kHXZ0p65yAaNnIYCqcJLwFts6lwzTTONekFDWftdtIKSNvc?=
 =?us-ascii?Q?BKT0VkDDURU9gsXzE5cXrrzaoC9yBwmxgGzC/PN4j/n9JYN0Kgqee9xGzzKx?=
 =?us-ascii?Q?N3H5keh0Qt3rwS/dc5ew5+w5zzMU0ZQMy8PF3Ou+fs4JZ+8IXdjeUCSZkksG?=
 =?us-ascii?Q?hmGUqvq+qeslqEVR/pIgHsdSxF7E+FEBoL5MyKkJYMVgd3fgXMsgLqaYD54m?=
 =?us-ascii?Q?YuzjKzxNACTMB0foY98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e84abf8-599d-407f-9f6f-08dc70bba20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:37:15.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzKjZDnuDPp/L40bZIqBuWSt+RjepPLCZM0Zy/Hx9OyMNm0lOVAx7aavXj026xiV+zvcY0CXyFG4XdZxkaym0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

[AMD Official Use Only - General]

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 09/22] drm/amd/pm: check specific index for smu13
>
> Check for specific indexes that may be invalid values.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 051092f1b1b4..7c343dd12a7f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct
> smu_context *smu)
>
>       index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
>                                              SMU_MSG_GfxDeviceDriverReset=
);
> +     if (index < 0)
> +             ret =3D -EINVAL;

We should need to return the index here?

Tim

>
>       mutex_lock(&smu->message_lock);
>
> --
> 2.25.1

