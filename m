Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3325F8A173
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9F610E1E4;
	Thu, 16 Apr 2026 13:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ca677J4r";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0213810E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+tYCbYYJ+JaGWLojPc+ypLzyyk4BkqqAH5qOH+VO/WCVsFK7d0iyIY6wd5EwJIt+Kwerfl02eb77y4wjoBN+lNdI0wQfQsKO+g069CtKS7Um+kLuVGeG79rr8TcR7lmMBOBNq+R0K8/0+w/yTthCRs3UPbBXNr3KT5GrVZwBxP4t34hIJaarfwV5ZKtZF0+J8bKeX8Huqq30Lnwt1l72zRqXw/02rVXQl0Zq1NY8994WmfeSwyD3vvJ6KwA2pvN9PuB6MP19KRSOYPgrx8LAeXBu7Zhep5TuFXNsp6LxCRpDVkj91GMaqHxe3hjRBkCZUbtwdDoaQMo8IHRnkxxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl9h5EAM5YvXBCriD1M7jxMzKLz9kGHVLaRMmZacaH8=;
 b=Bn0LjuyqbLLDOt0EpRlMAgYNW/jcnaikcs/m2/yt8hZBtj9poi0cNHgyl4EkWI0mdT21G8nRBa/cbhIwZIlfvrjYxwKxSaM+LYuof9rpDcWZ18dlPb4W7iZXMGuls0vVY5ta8qZIcm0RCA5VYIUqSJ7B9AHmMhGMBFx3xCeGasN7ICEe3o2ClOYrw2T4vLnr36HibhbWONeRPat7QTa2I9gaxeHLe4jGC9UMHuhlvGKj76vrjo91b5h7hXeTJJzIcQEyp74irtRydJicsf9FgCjlvbsMZHtZUT8L4AD8ihLzBeGB4tqPdxVBuUkDGWJK/UCJm/i2Ak+hxIBOLj2raA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl9h5EAM5YvXBCriD1M7jxMzKLz9kGHVLaRMmZacaH8=;
 b=Ca677J4rnc7aAWG7ruihzhJjUTASqOv6jPktPSVJw1pCwhuLPt7Tg1MBuv4ksTEDWCyMY1plhoCQx3X+3W6Mrhet5A0ZZDzSKRSaniuuOlj7yB59Vu2qsILOyAB4ZBUsUSvXOfCSnC8StQP17gyMogCktk0/73Ry4RYN7NqC2Qo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 13:15:54 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 13:15:54 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
Thread-Topic: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
Thread-Index: AQHczVyb/ZJo5cnsmEyDtmdRYDIlarXhqoew
Date: Thu, 16 Apr 2026 13:15:54 +0000
Message-ID: <BL1PR12MB58981E8785647FE677A7165F85232@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260416045025.1825888-1-perry.yuan@amd.com>
In-Reply-To: <20260416045025.1825888-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-16T13:12:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH3PR12MB7739:EE_
x-ms-office365-filtering-correlation-id: a4e63c22-fe11-4c45-1805-08de9bba4a08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ulX9U8m8LAaNFpahRPIwWW8voZiK/cu6yGyHJPg4+XEAkbEqw0XEABBfGOp3y/TZrhY7aRqTXe+bWzwcZ9JoXaRMWPy4g0R6AhlVClf7RKt/WvMKqBkdv3PHSNfvqQNri0ZpgUisfEKZnzeKFoaGZyj49DaQFjsRZpW9fDCeJOy6tQKsU4NxA6N8gCMvL17BEgxclcZo/xQ7wG9S/jfbHoAMgTH3n1wyZXRAp9I2y6/7yZxaP2PKKVHOvVD3kvyBvq9Krx4uG2V6obtkGvMVQze5tH70/F5w3RWK3YLFYxzwzE735/EI7dLF32D9neioYOp5eq5NjrU2qaFBF8bReHS2P0r15sRaQBQsg2zzxBDOS5AMd6Rw+WHFrEnRnLwdEoKK/bCmKBYenud5PC7dwp9RqOuG4dMsvdvWrc/x7jHMFoO+f9Xju5jGkfxYcojXcWmJtC+2svT8iYz6OCA2ugsEKkJAXMtH+ShzrtmxkXKIYrwx1UsNUD0I5fEgOq7oqQVOSyHsocPg4KrxL6h8mpJBSmwY9IXhF0t0b/ijXO3n8b3TgeJbMLJLcQ1dDn5Thdas6PN4K1aOuVU173zK6plJXLiDLci5RyG4O+7UoL/QGf9NJv8RE84Ai41nwYw6VCVI90aX7HeNE7zyYVrAx+cb0Y8GOjWMxK7e3HSKKcJcmcnpH2lZ7owqGlHF4AeTisKUs5pZ0aII9Xy4o317IoNTpRYcfIzOW8LwLsXVIhZhCOM8qq05SkMnq5XAjkoBrVa3plP7/6OljYNiMkHmfZoOp2x9CMTArqhjaUvLI+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p4tFTR/YTkyVMJuZnvSYs6cgn+4uz821TdORY7b+Wi3d9xuT/RvJmoWJj7lx?=
 =?us-ascii?Q?j/KuhVTDXC3ASc32vFa1MI97V4dxZZlSNqH9GREfZQiO8fD0vu1WNcAdi3th?=
 =?us-ascii?Q?ONzQW4HUvRdc17uoQWIZ4chEuTM6bbyji5+t0GOscJaK4zOrbkIYzD8dmOMG?=
 =?us-ascii?Q?bQY0/Y10V9h7eKCnAMVQG8RkooVaAvFpVwVbCa4FvXwUMue2eNF4x595uCRW?=
 =?us-ascii?Q?Vdynm7ZMP5FZFAzlcpsxFlWJcRvgUu5alHl+LNx2ZGIetvITJhK4HekkIvyg?=
 =?us-ascii?Q?1r4NN9epyNGFOB0IDFIRJbaWri5DNMOqGo16hyPq+FZNYg3GPywEdjMWZB1Q?=
 =?us-ascii?Q?LIQCrvT5Ufq6TUK71l4tT8W4lkrjnmrypK1S6NB//C3jpZCZ+miLVYznCRy8?=
 =?us-ascii?Q?En6SwFv+mj1L/EQwZzpqIklxk7NVCFt7KGnkFyDAXEiDdeA0b15RHXlxKK5t?=
 =?us-ascii?Q?LbQGJUWCfngel4XYdF4M+8hiR5/ljDXnDxcHOq68PVGI1dUbstSrzk50e/M+?=
 =?us-ascii?Q?sfVIeRKnC5v3V3XZxMsUdZ5HHfOCdexVgFtYsFCmSnMDpGWISPMA+jqm3GL0?=
 =?us-ascii?Q?XSOJQixKH0biXnhq7L5EOJCWGT3kuaPogjISj7+Y6VZME1gOjf4e7yprH0qb?=
 =?us-ascii?Q?7iJVi85pRmy3PdmYEoMH5m1xz0LQT2GMsnTaXALt9GHgUvWwaQz+Xjf+xQf3?=
 =?us-ascii?Q?w8av26gm7JjJtk59QKpQtGv5vYLg4ER8FfZBLLZJWw/FB+c+pAdy2rfcIPn8?=
 =?us-ascii?Q?0a5bEte0o5AWwOBY9ofyD5U91P1jgshIax71elO9JyfyX+sN3mydrbrISZuh?=
 =?us-ascii?Q?qBPkEc2E/3IF2LQDrjDpEYASNgk+ojker1o7LCZyzfe7aNXV78eLckXjx22C?=
 =?us-ascii?Q?Urs8VngAPvJWFxpaJl5sTXzhGHIucDh7wQhqOVpQQXCQtwEiHTmSq8OjdT75?=
 =?us-ascii?Q?rDpucTwaK0++VkPQOIe99Ia1BxaAcXjnTNvxAS5d8V4olOmeaJ71M806S/mZ?=
 =?us-ascii?Q?0w7yyihf2snf657ocBzXpAMakI0dG5fDxuHdnvdAOyHWn2HxUK1oOpa1Mg/r?=
 =?us-ascii?Q?QapGr/LzNwZFW/hb7a1GVrNbaoHzoFjZK1Bs+BHpUtDJcpy/zvpX6vfhhi0d?=
 =?us-ascii?Q?1z5jqw1AUu5Z0tTydKwP/e/8z6xOtvNDBMS7aAK+juSl11EeH6HvBQq6azqR?=
 =?us-ascii?Q?See8L2su8NLxu9jX7R22f7SxqxiLeNRxkefVhIsZ2wq4JZXmAk1IayJAJp0U?=
 =?us-ascii?Q?2Y6OMbD2sNhiTLFjbnId6rbEY7uyzaHkosyaSJcLrEqAO5DzFcOtOdBJ+t2/?=
 =?us-ascii?Q?5qfzYe9CZR/aeyuRt0uCzXQmNBRJj8v1v3vzBTnO+CxUZQV1rWUZFWh13VqQ?=
 =?us-ascii?Q?80giS6L2pXpOhDL81sLv60IzNeG6RB0oX4ASvKLartGf1N6LOkNdmHnHtkGw?=
 =?us-ascii?Q?HP7yjAWXekfdCDK5xuRbOD8cFdNl/0/ZIS1Ro1Lj3zWUyKAbn5ZhidNGyzVw?=
 =?us-ascii?Q?EbWMLwLXoDGoyKMDlbHevFb3eciMWOoqnBDU4I2jtZ8g3SbaPZxJF1skFGSf?=
 =?us-ascii?Q?fVRXi427BwtbdnJrWmhAoiANCrjzFxn0Mp9S26bySaqZKPfMBNNVTLTi7BSd?=
 =?us-ascii?Q?RZKAnzdkuxcrx6gsWNqo6ju4xev6WHUaoz53nlot4bMESpQERedUOn305Kgc?=
 =?us-ascii?Q?2hnSnaTiyW8pMIn7j7QSd6/meZLZB6Zera9l6sRcWzKEDB2b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e63c22-fe11-4c45-1805-08de9bba4a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:15:54.1379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFhUAH1QDpFs66LOecjqRrCs6iZKCR9GspD6Bi2YaZxL65zGkTM7+S2787xD4jr2TqXswWasVqm55UjIraVXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

Not sure if something git got messed up here, but it looks like you're remo=
ving
> -#define AMDKFD_COMMAND_START_2               0x80
> -#define AMDKFD_COMMAND_END_2         0x87

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Perry =
Yuan
> Sent: Thursday, April 16, 2026 12:50 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
>
> Move `AMDKFD_IOC_PROFILER` from the secondary ioctl range to the
> primary upstream range at `0x28` and bump `AMDKFD_COMMAND_END` to
> `0x29`.
>
> Fixes: 4abe9fd1e763 ("Add kfd_ioctl_profiler to contain profiler kernel d=
river
> changes")
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index da93daa3283c..1a94d512df35 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1711,13 +1711,10 @@ struct kfd_ioctl_profiler_args {
>  #define AMDKFD_IOC_CREATE_PROCESS            \
>               AMDKFD_IO(0x27)
>
> -#define AMDKFD_COMMAND_START         0x01
> -#define AMDKFD_COMMAND_END           0x28
> -
>  #define AMDKFD_IOC_PROFILER                  \
> -             AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
> +             AMDKFD_IOWR(0x28, struct kfd_ioctl_profiler_args)
>
> -#define AMDKFD_COMMAND_START_2               0x80
> -#define AMDKFD_COMMAND_END_2         0x87
> +#define AMDKFD_COMMAND_START         0x01
> +#define AMDKFD_COMMAND_END           0x29
>
>  #endif
> --
> 2.34.1

