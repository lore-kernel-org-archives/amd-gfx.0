Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E78C021A4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 02:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041E010E0AE;
	Tue, 25 Feb 2025 02:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0tt7jXDJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C10B10E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 02:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipN2QXteVyFxSmX9Ufi9rQjEYC0fIc+qvC1sCnS1wCFTyO3zEnkzjY6B6kaTvDr6rLIxQH0oY/ZZ2Bjmi1TWE7kWrlHKUlQ6coaHzaknloPoMKNKY6kwBr+92UW2GK/Sqp8xp66bxyQs7eFZLjynfG/76IR0OKlkK1zmjOMUtqjjrX9E1rwrC91mhqdPBypaUlNed6uV7AMoraOPgOV7E0C41xZ/H6YKUeglfE8Qtp5O6P466PyG0rsaAhCpna7KJdE1Rx9zexEkB32GUpgERndg1NJDT00G3np9qFzB50gI2Oj291dx6mBcj4siBY27/CZeLaCaCHdaXOsotDjthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sKXHByLopp4CyZKXdUlXC5lSW82J+3D+yJcL4gQtcQ=;
 b=LSEchmDcbFse1tXAUlgg767vIdx3QOlofTK47+IE2aQT1YcoQoCD04Ix8EwKgmwxrB6yTE0LzGJB6b2LbQdmjzGhydGSUYCiVI7EIzpJbNmAn1L9qV8BUo3ZO8HkOPxCp9DGRod2fiievTOhTezD8Ucu0kRVNihAQBBWmQUgpgvCRdXQUW1Gt8DNhy9YBmj6m0S8XLkTbPc30CjLIaLvX8k81OyzikyCYHUJKTiR2YK1qXAn/vX2NYOQR4zrDOddThYRTvrCghd4zYg5g/7c2irtYhIHmgRjeGmiQokMlqBjS+jrtDeD5DkfM9Fovms0Nu2E6c2kZ0MhlRfRR9Dj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sKXHByLopp4CyZKXdUlXC5lSW82J+3D+yJcL4gQtcQ=;
 b=0tt7jXDJo15cgK0Azvs1ysqBKlX+vt82XqIqej3+IX8/fdB+k3km1eFAtYbanNxmNsFp/0orVqoXw4wXAISIEi0Kpvq+PHlIRjSDR4jWVO2QpIv3cVLUY3HQ46ntXsusJOKB3q5C+TDhfuOugecOUqzG4beHEEngqK6i/mu8O2U=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 02:45:06 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:45:04 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Topic: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Index: AQHbg2BEqvn8teHamEGQQgMnE4YMzLNQ/VsAgAS5dwCAAYUegIAAGdMg
Date: Tue, 25 Feb 2025 02:45:04 +0000
Message-ID: <BL3PR12MB642535FD7D55170C2AC45E0EEEC32@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
 <20250220062515.2050499-3-Emily.Deng@amd.com>
 <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54179719DAD3729506B19EC28FC02@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417843C44D1FFBD8FC8DAD58FC32@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417843C44D1FFBD8FC8DAD58FC32@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20eea709-1c3c-4ab6-a31b-da2884a9d2e2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T01:43:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ2PR12MB9008:EE_
x-ms-office365-filtering-correlation-id: 4e4d5d52-ce29-485e-ac57-08dd5546682f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gL6wjB+k1ySA6CCbh8KuE8wEjbmJiDhkijikhk+6QqzAG5ahO0aITI9lZ2vP?=
 =?us-ascii?Q?Cy7OrUJ6lkZt6aqGRhIVpeO7qU3ZH5hg4dI/1kG06OsXRXCP742igCK2xZ1E?=
 =?us-ascii?Q?h6hUmN9+grK48h47EDatXL8Qi8kOu766tDdTqYNvMJ8wFZGghGi5pYGALbFN?=
 =?us-ascii?Q?0T/tNwS4uBHlZqYLQRSqSg2UoLSNhMW4Alac8pMTKD9UNquz8rJFge2ATw/c?=
 =?us-ascii?Q?54ZhEEYW/+sbK99WmY3+pOYOrhOg8c3Qf9fXfNz2fUeCJdA5mw8+MbyTQpuA?=
 =?us-ascii?Q?PgEzxgDHXcoe4uZhupM6EGo91DMYdzWvGIoUFpOjctHQeDtLyOUEbsK2ZsH6?=
 =?us-ascii?Q?TJ9CmNLlcpqTHdSR+bltm+rG/wF24MD3ZdqG5y5js5FcLw8tkIQPfK1y5RYL?=
 =?us-ascii?Q?mBC7ZVUWueQSw6OQNbXwwWTv/xHUjjq/6QeMFJn28ygxfRAkhnu1pMY057+S?=
 =?us-ascii?Q?Eoq4F2y4WOZ4FwsEYfFpZLI3eFPuUF05u+/R4GaHvxJEEU3YYJ/V7Zm7fG8Y?=
 =?us-ascii?Q?WkhNeiJ98vZPl1QHAJ9balxUr6Quq4mhTzM9aLu6nejBXkQqaZtTTiW+c82k?=
 =?us-ascii?Q?R3Dw+yFXwAZA3mbzsmcfzkNNKHc5C8aoVbkDQCybNvg3+j2o6MU0d8r6Ev5J?=
 =?us-ascii?Q?s55Ly39cbFmSjI69UODVua95WPfAy80ncCDrYCPdRTJuP0PCX30FTR+do6bL?=
 =?us-ascii?Q?1kFCp/H31oLlRkACP6xwLH/aJL1oO6jUaQkpRf5xO1tAd598KPzuTwRQGCeg?=
 =?us-ascii?Q?b95RdCCL5dI9j7SbME7MNsWn1+EDFh76rBJQV9LQaAXAYv/YLfZ78jjbvDNl?=
 =?us-ascii?Q?b44NCNnWoVy2xbwiqyk9iJjdp1xiS2wHbZIjRXUV1Ztjh8n4+hZ2/426ouHL?=
 =?us-ascii?Q?+ST6cmauEh2OdCKNFf10eLJqZrBhX/6wKxRTYCDSEJM9mr339ANUTAyFcMyL?=
 =?us-ascii?Q?F7aio2Musu84u6CP8YtP7fjCs7MV3QjKzMAe/vMZktrOTG17JucZ4CcXdykF?=
 =?us-ascii?Q?+mRWzWvI6hinZsUYdGPqJbLePhMmBBf3DHgeuWUxTxhORl9eegUpEyx0JZW1?=
 =?us-ascii?Q?iFv1r3XpNgGANygmEFWhpWCP8CAe+burvLyu+LA4c+1suHUfXejpDrVdgA2f?=
 =?us-ascii?Q?so4O6IuYmumh2DeOHE21awaoG+UQ7VXDBZVTA+Miwal4Xv4Yfkv2mtiKxn9T?=
 =?us-ascii?Q?dvixHVVxHVsKOUqfjGCiC8Lc0FIKOeLe3W//Qf07NtORu4cJRX30aDeuVBHz?=
 =?us-ascii?Q?dXvjENX/a4s6gywIRCpLCklgdGkcLMKQOY94hnTASazWu1v4rYzQ4fK5SmPj?=
 =?us-ascii?Q?R+z8DjJpMxjhhl12Y75dUFsC8QnNssa5mZeNpiHiwLFB6lH5O9FC9iPut/kc?=
 =?us-ascii?Q?i+NAzrzobnHZCe0SxdzMLzhDa5cTG0JH4YBFotiYXWyhyRnIjfTfO5tz4sui?=
 =?us-ascii?Q?P3/bWiMcK/e8kIZsZZ3o81TpzFrH3TU4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qPRi2zOkUcAzoadJo+ECdlaq5hEfC9XNU1VEYwmaw7jngQ8o7v7JAgCqLYAC?=
 =?us-ascii?Q?RV9NaVIuayojZ4nHrxUslZSlDQXm4etSQY+E7nm2Gd6wcr6ilz/fYwJneOMk?=
 =?us-ascii?Q?+Q9WhCL1EKUlLpFloPAdq9eLpjJz83tKWoot16tP2jxoiD0FAMR6kleUFs42?=
 =?us-ascii?Q?aU2fXJctVOHzaZHct48PvY+Ilde6j/5kluTCgGXEpUN0gqCOr0zOficWj5ZC?=
 =?us-ascii?Q?dp8TTa9XV4SSExh/KWqsw6MKqxUznStf0uby+07MbD/iMHS50rxMhZB+Ud+a?=
 =?us-ascii?Q?YWjEGWsYWgM0gllexyGLOjxRQdKmQ7b5o7jg3nrrW1ngLbOHQl/KB+dncc0C?=
 =?us-ascii?Q?q/FJNfn+gg9VOV3qnIrgsPMKlorayIUAG4w2a6Oxu4ZDDPf5m73jdcfiRnEw?=
 =?us-ascii?Q?SryHqNThwSuyPkDjIt//jpBpvQhDScMM+bru1rZBiaRdJKGcHLakIr4A2VvH?=
 =?us-ascii?Q?QSjv4t/FC/gYGDjE5h2bnMytmju9/AXKqRpwmOvdppsJXYwGmEFjbtDT0eWE?=
 =?us-ascii?Q?SHgGDnLlFV/dFbCTBg6R4kJaoSri6a75eZnNSWKdzkLJIjwadXy9AcnKOia9?=
 =?us-ascii?Q?ZvpbBFdobbJNDTpR8gASURNj1YGBcIj8sXaCItiMmKiQ5r+8vmVZhzanHnQw?=
 =?us-ascii?Q?6qY04+lV4bf6ExJ61nLNI9VlcXoFG90diZgFpaf86jI1i0tLdLjOf8l/Yp9E?=
 =?us-ascii?Q?tkpWGkd7uXYHWoz77sTl//1gq2F3UlFoTukAiD13+OsZy8YSMj6RVkBBZVJ0?=
 =?us-ascii?Q?ISW/++a0xOwvcQVyAnFWQvoq0ITgoTlxXQ/N8GVizggkIGqRu4KHLOfQEpKp?=
 =?us-ascii?Q?yEZlmZoc7nuSwddOuTPcPnv6p7JFoh0QZISUpegNrQXZnRVHm8a5Tm7vbAGU?=
 =?us-ascii?Q?7IFvKyQ2xcGaEccrRy629CmWne1SEkn3T18l+VoJW74MhdKIkk60yjKO5K2o?=
 =?us-ascii?Q?hONoGGVLqLRyPmMZ5sIsTo0wx+tcL6mfRAwp9Z3KvAfrsgIpIsHelJdJ2WB7?=
 =?us-ascii?Q?EcBE3or4lGTbGc3JNo1j0cajXFJ7BHRsxoWvOTbxetgSxdmJKSEwGjpMcJaM?=
 =?us-ascii?Q?fB0G+k+IKfKGM/mkwsbkG0ak38ziDVMinmMEVGUAb22rTjh5YFAk1h0o3D6B?=
 =?us-ascii?Q?pC82Dl1ZYTIa7KZpCHGEfyOSMRC0of7SFxsj5nUSWA9Oa77k8yQFu5angNZA?=
 =?us-ascii?Q?RXKkHEPLsv8/IOfO9RIKRRLk97WXFmYoUrvoSwku4htS8+cc/47UekApf2Sr?=
 =?us-ascii?Q?OL/qwIyi2xIfN2rykOuIbueuBJQmx8Sy7CRa1USilxMjggTFGUIPbVncUOsP?=
 =?us-ascii?Q?nDq6jMUBIMkQCd6b92mOJQhEbSvu/rccC1j3BWk8NZX0b9Osh+bcIpD89690?=
 =?us-ascii?Q?E5aSzZVZWMh6JXLKDtpidRRhbKy+i+A0kuRHMnCXbxX5KHm3F8AOjJUU9QRq?=
 =?us-ascii?Q?ar2qvP6pRiVGL3s43xf/ocf+GHQW+yyhCB1uknNIrWvN2mUygghLYIIXAFY6?=
 =?us-ascii?Q?YWY9K/t4GScZlHKLMeFLN9EvNdsvzk3ekTlHu1IG6WWeGzPjFUVpLxDgtpOE?=
 =?us-ascii?Q?r5FENOE5xiCa9qJ2qtI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d5d52-ce29-485e-ac57-08dd5546682f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 02:45:04.0363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDoiJ/rrjPIV3yTmnk+gqgCjLGLPu//RgGRV7/jY1l5YkksCf2j3tqiq4JeGOaIpztnrqMcEzKO3Y7Ll0Ao2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deng,
> Emily
> Sent: Monday, February 24, 2025 8:05 PM
> To: Deng, Emily <Emily.Deng@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
> queue
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping......
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >Deng, Emily
> >Sent: Monday, February 24, 2025 9:53 AM
> >To: Kuehling, Felix <Felix.Kuehling@amd.com>
> >Cc: amd-gfx@lists.freedesktop.org
> >Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
> >queue
> >
> >[AMD Official Use Only - AMD Internal Distribution Only]
> >
> >[AMD Official Use Only - AMD Internal Distribution Only]
> >
> >Hi Felix,
> >    Could you help review this? Thanks.
> >
> >Emily Deng
> >Best Wishes
> >
> >
> >
> >>-----Original Message-----
> >>From: Deng, Emily <Emily.Deng@amd.com>
> >>Sent: Friday, February 21, 2025 9:44 AM
> >>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
> >>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
> >>queue
> >>
> >>[AMD Official Use Only - AMD Internal Distribution Only]
> >>
> >>Ping......
> >>
> >>Emily Deng
> >>Best Wishes
> >>
> >>
> >>
> >>>-----Original Message-----
> >>>From: Emily Deng <Emily.Deng@amd.com>
> >>>Sent: Thursday, February 20, 2025 2:25 PM
> >>>To: amd-gfx@lists.freedesktop.org
> >>>Cc: Deng, Emily <Emily.Deng@amd.com>
> >>>Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
> >>>queue
> >>>
> >>>Avoid updating the vmid to 0 during the queue update process, as this
> >>>may trigger a wptr poll address page fault when a ring doorbell is
> >>>activated  in
> >>doorbell_mode=3D1.

Have you observed this page fault? If you have it, can you please paste the=
 page fault backtrace.

> >>>
> >>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> >>>---
> >>> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> >>>b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> >>>index 6b38967d5631..3028c16264b2 100644
> >>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> >>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> >>>@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm,
> void
> >**mqd,
> >>>               m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
> >>>       }
> >>>
> >>>+      m->cp_hqd_vmid =3D q->vmid;
> >>>+

q->vmid would be 0 at the time of calling init_mqd when using HW scheduler =
as it's the
HWS which assigns the VMID.
Driver only assigns VMID when there is no HWS, which is not a production us=
e-case.

> >>>       *mqd =3D m;
> >>>       if (gart_addr)
> >>>               *gart_addr =3D addr;
> >>>@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager
> *mm,
> >>>void *mqd,
> >>>
> >>>       m->cp_hqd_iq_timer =3D 0;
> >>>
> >>>-      m->cp_hqd_vmid =3D q->vmid;

Maybe we can just remove his vmid assignment if this is indeed causing a pa=
ge fault.
But I haven't seen a page fault because of this before.

Regards,
Mukul

> >>>-
> >>>       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> >>>               m->cp_hqd_pq_control |=3D
> >>>CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
> >>>                               2 <<
> >>>CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
> >>>--
> >>>2.36.1
> >>

