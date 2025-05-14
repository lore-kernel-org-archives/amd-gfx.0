Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60875C3ABCB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 04:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2B510E23D;
	Wed, 14 May 2025 04:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBTgGYG6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9805F10E085
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 04:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWj/UkwlQzW26HHys6DuEwJaNbWzJZW29KJEyn+ypeYvkWXnGWcAAukpp2glabJ+TiMyv56myifv+uEdUVP2TVf2TG9vmGErZdJ7GuI/VDxKXKtJM6EoJcYjUCAK1HEKlBBwe9PTEkzcSCCRYPRSApNvKlXqJ2GFINc9imK+NZYasMuZFJev0okSQpVjmwpmRuFHUJw0vqut0k9+0bSjddSOXGdNWTw9CNUVPwhCpKpUlse+oBi6RmtUMG06n/yNYwXk3yUL7Pyp21ij1FX/Gc2UDmBmUJfO8Fsn/N+aHiuIS3Tm/Ojl5syzGWXCDk/n7m72Si+TUFG5AvnpO+y1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umb0vxBVQkOZOhdjDgqVxKVXE9HMoxA7A79XOv6NRcw=;
 b=eCCKKDmZ9PnCFIFjdstv9hxP4LFJyzU4GPs8N0jMV4/96wmyhP8yEtkzbk6SYkSBE02qNppcG4pDPTCrP3L1pFuGDZP9mlj5lr4LY2nRxK6fdoIJVMSsNrGMqMdJaMxkKwWvQms7EYy68xDMGjALRT0P7lhZrHHMnsShTLHYioBvB0ePvFqsSdIb3BCZ8osI3yqh5vCYHnkVKZhdDUNQO0MAFfGJ6f48DWK+ISTCdqNUw63cnLHLlNWTIA+vQempBsIjnwN5g9+3WN99N12Q5NCQkzW86+qavRAM6regGgQUSCEYfJzMouzkKyw9QyAQe+N66qeGGtaCRgDL9iuuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umb0vxBVQkOZOhdjDgqVxKVXE9HMoxA7A79XOv6NRcw=;
 b=lBTgGYG6QSJQU41Y/5fNUYyLl92dQbs44pD9tylqTX3FiLwSLv66aa23kI+9LOS+7A+0DODWofumUTZ/81Is7EYpkXTJBgtRpT9apbDdAPdjsIjFNaGNsMQq69OiDBKf7ZYEsgUI56Zf5CAkLit+87tYYNyixvPUnvd8lcmLaVE=
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 04:04:43 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:04:43 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH v2] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbw+dou5Ud9iqoh0mB4M3LCT+85LPQfJkAgAEBnIA=
Date: Wed, 14 May 2025 04:04:42 +0000
Message-ID: <PH0PR12MB8773B69D0B119D60FDC29919F991A@PH0PR12MB8773.namprd12.prod.outlook.com>
References: <20250513091348.57701-1-shiwu.zhang@amd.com>
 <102c9e7a-9d78-4802-b5ee-222bce86c48e@amd.com>
In-Reply-To: <102c9e7a-9d78-4802-b5ee-222bce86c48e@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8c6a38e2-bff6-4b77-aa15-aace6ea0565c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T03:48:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8773:EE_|CH3PR12MB9022:EE_
x-ms-office365-filtering-correlation-id: 44715efc-e3ea-4d01-092f-08dd929c74e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FCAHf5Y+Ja41W9rG+mUuDQtJS9MkEC2tf2seoxm51E6f+pluhrTsLJVOJkD2?=
 =?us-ascii?Q?6O54hN5wyfEf3RU5blEv6csEIC2zvu7e8elYIQuc/1gWKX9pCJSwTN4mLFQm?=
 =?us-ascii?Q?ya5L1kojynaQXgkYVmLRb+3z1481HXn2KVr3ntkthHPYUZT2lztCUjAjyDcu?=
 =?us-ascii?Q?bHhHJn7mg4Ht/tJjFcpqr8FLzzDb2MECStTLk040snn//he4/66VsG9JcNhY?=
 =?us-ascii?Q?vBhIJH9rZRsPYkgBeBk337m7Bz0xAIUKpJIGoAa3ZdTcZOyT4lw/2XXDQ4oW?=
 =?us-ascii?Q?VTYqfx+3m2M9leYqioKujG1MohY/stq7yjclCyNkYbkNKXfjET1LLRVtLYx1?=
 =?us-ascii?Q?uMYHB7Xv8RdTRqNe49rX9xVR7m+ohWiClbVzBW9PZSce774XIYeO1BiqhwZc?=
 =?us-ascii?Q?RQnj1ya4N2yc+pmn4FeAJzk3LMIUwxnaKd40dLxEgHMsT/Sjao9CX/uB5OhQ?=
 =?us-ascii?Q?Q3UK+EZWW33GWXSnVAFLuhiIkP2XEAUD8dvnDOWHUb+kSgOWVCKyLSFXrYMK?=
 =?us-ascii?Q?k4OCur4a4I4iB42RgPk4wOt43rywyxwFAUSn4bk6WanXTPt3DQhVwafKa0Nu?=
 =?us-ascii?Q?slfEuFOV+1fW1TFGyHMMeadWPeTVwaNTOkf2hejgBXuT6+WLgeD5iV1fRKPf?=
 =?us-ascii?Q?oGV7EN5PhLuuOoW9Z4BGNw+Gx17nbG/AIPsQgjGyhqRnxSLDKBrvwXZOyIRz?=
 =?us-ascii?Q?Jg1pND/gKT8Qa89k63pIftAptMolDGIH1xSGbxFdX86DU2/ZkX82UJtYFYvK?=
 =?us-ascii?Q?XW/LsPTfrzQHCQzKJt5+lwaQLfbByD7bYACOyGoqIsksLrCnLEhACqHe32D3?=
 =?us-ascii?Q?l0tESkH221jir33wHBvqp8QgZlvovVhNRi17sg2UrEp7mnV20DM5AC3T3FPh?=
 =?us-ascii?Q?67Yt94V+zhNDzMM7r3pyuMT13HYvlCwtVZHXBNY6+3IObHDE1VTPebPtIS+C?=
 =?us-ascii?Q?Yv6ha7G1fSb5GPB4CRSjTwoGXB97/U/BKqdjAHwgPUdlfr9pcjW/n5xeoHWO?=
 =?us-ascii?Q?WY7HbdPBF3aALreorZtInIL+je+ecRH3ICHrobqcxbwi2Be5h0CsGT/MmReB?=
 =?us-ascii?Q?VMDCo5Ft8EuiNM4JlyIAZbbw0Ye742yRM9pNq3asvelTE+fXa7Ddvep1JkZI?=
 =?us-ascii?Q?ErC9VQZXDVRJRTHzHLxbkBAgXNTYAUriK4myPx3YOTJ6aM80nF4kyDvYNfoo?=
 =?us-ascii?Q?roamPbW9JjtWfY1olHnwVdXDyCuZd9SVrqMVIDwLoCT8ktqrfvbXpUAnccym?=
 =?us-ascii?Q?4wI6TLu6Rxf/qiZasmkUrdTNI6H9RsNlEGh4EeHwOcHhBrtWxZlFcEg4R59d?=
 =?us-ascii?Q?TNmEEpAvu70gBSxxV/nW9+uYXXI1eR3VBnPqZoYjyNllTGgAAw/Rjc3uaxth?=
 =?us-ascii?Q?PvE0S1KzD/rgzr75sTf4UXRWEZGgf9f8ZmIfFSJn13GxxlRAP+w/qZY3Kf4X?=
 =?us-ascii?Q?/LY/vqPlZM40XEVP2MJBxHlNFTaFunfTG++LMU5iqCEIHpXxoR1cVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB8773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hj7Swa3BhQXSY6knn+FBQ/rPKkBn/0AtQmRl54F2X3ioJv1u5xJogRjFosf+?=
 =?us-ascii?Q?TIDNtRIMHdRUV+KK6oFmrEz7zn+ACFZD8OlQG8qinedJS622vxWmYbxJAF9a?=
 =?us-ascii?Q?U7mjFl4LBUB83iopujjvMBdXKxuSisb0rzKNZdgpS9LvNS3ZkVmfvJB+9WYs?=
 =?us-ascii?Q?ckv2kKDCAyVZvCIjfl3BJYsy3igEBIvEvK7ebpBbxrRb9n/JNlOj3CpjwnC3?=
 =?us-ascii?Q?Is61w3k34G/mGakAMGJ6pGMZmml5IIfa0nAL4DWDBh4O0zdCIBW4JN7ygNtP?=
 =?us-ascii?Q?b+cBhtIVGkKxzXZ2UgtM7lUDFzPb/hQ8tAxHS4C60NfrPXosSXh9nLOzpRS5?=
 =?us-ascii?Q?txepkOcb63Jh0aiQ2djnS40faUUU3MC1LoIQ806eVjXR8t/fqJbk6qA/WalQ?=
 =?us-ascii?Q?wRGx+HOt0DPhRtsuHaR+/22U6J1SP/6SxTrKZ9UnqQZ+y73LmPbUe641MbTi?=
 =?us-ascii?Q?wcakW12lNE2xmkyDqLKtlKnQRwKOm46xGGdNQx/16ToOLbtMfWxCDwLcy5Yg?=
 =?us-ascii?Q?KufhXLUidHLDuDL4w5IP3zoI3EocDHmNbG1HmopkZk5sluKJR9YWOIZc1tZ8?=
 =?us-ascii?Q?7jS6fKkz92RFs+i0s3+S4c2h/oHOT2XSDyJUAmHXv45P0zFBn0SLSlKxY3y5?=
 =?us-ascii?Q?FvJ/qs79xKilytPkzxHA9U3A42iZVScpkMDl5su9aVnCJzlUBnPgmhMIX/m5?=
 =?us-ascii?Q?AAU7YZiFuxgLxoS2m0dILVZDcAdPfg/PolHYKwpkWaDSCbIf05DgjqXer9sl?=
 =?us-ascii?Q?rOdTWLFZ3n4aY0mjmUAl7PNQ2DE6qIt2wFwqKs+gVFah6Sy/IyzUJhAWgdv2?=
 =?us-ascii?Q?nviZWHbgYHw0JXf4XwPRy2/a/x2OkYfljWYlmqf9j6HDMxXE0R9vWqJGd38C?=
 =?us-ascii?Q?SgOk//miuwMw4OnNiZ6+H3SUlPlqEJGxj+2TNvGrtIiYU61lLenlGWpnt7PG?=
 =?us-ascii?Q?XeVLxbFYsos0EX4u2+SgMRpLM7gVj4sDMhaclq5CxbdkbTTHRiJAaOMWBZnc?=
 =?us-ascii?Q?ViiL+7GgXMyEGCfIOnSNAV5mJhWuRNTIJl0O2hHP+5O0NIyaFyZveiHfFfep?=
 =?us-ascii?Q?N4yzAPtZVAqpMkgCmSUPmfRbxZXEeUg3NDyCkrLKLHGuHFvDg2Nd4CcZONd1?=
 =?us-ascii?Q?bXhopaokJ0hYiWoil2oW6xq8XviHKM5/q8eVIfRjE3IjNa95Ds1H6C32yI/U?=
 =?us-ascii?Q?XUcRL6iFn/wta7McldwtjsbqH3zrmya9F+ZDfq1qgx8O/N0Ws3OcDW1cPA3U?=
 =?us-ascii?Q?AlR+LW7D8JxZ7axtSGEhmHeDyi4QSLf/EVmwN0IN0Xj+rztXIYdLhVOLNCQc?=
 =?us-ascii?Q?zdLXjQA5u5y6YpABQg0Pg4SYmFpybCYFJHUcy1iqRDTlRVM7UQeJelZFf/4p?=
 =?us-ascii?Q?Xfbj1QN6GN2wZnaNXG3MZDt1EV44fA+woR7eAB21btka8JCPaBm/8F6Lvb+8?=
 =?us-ascii?Q?32PSnAPAO2yICK7dgt4q7SX4Hs/Dm3Q3b/xFVRUviLWX/xdzEQdbISCqBVml?=
 =?us-ascii?Q?MZ2YXtlgQwRaEZiPRK/ORMwavBoW+MYSpWdXn8NnFx9PHN1py63JMZ2SKNFx?=
 =?us-ascii?Q?hG+baJah1VqGVwA4w28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44715efc-e3ea-4d01-092f-08dd929c74e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 04:04:42.9445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEG76nmAfm/0/HbThdHjc1x+oAAgxDvRhlwVHV8lYxUwMtPnmhjlzK6hutBadrtduHuAgQuPj9iPuqG+3ftKnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

[public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, May 13, 2025 8:26 PM
> To: Zhang, Morris <Shiwu.Zhang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH v2] drm/amdgpu: add debugfs for spirom IFWI dump
>
>
>
> On 5/13/2025 2:43 PM, Shiwu Zhang wrote:
> > Expose the debugfs file node for user space to dump the IFWI image on
> > spirom.
> >
> > For one transaction between PSP and host, it will read out the images
> > on both active and inactive partitions so a buffer with two times the
> > size of maximum IFWI image (currently 16MByte) is needed.
> >
> > v2: move the vbios gfl macros to the common header and rename the
> >     bo triplet struct to spirom_bo for this specfic usage (Hawking)
> >
> > Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
> >  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  46 +++++++--
> >  4 files changed, 170 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 4835123c99f3..bfa3b1519d4c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)
> >     amdgpu_rap_debugfs_init(adev);
> >     amdgpu_securedisplay_debugfs_init(adev);
> >     amdgpu_fw_attestation_debugfs_init(adev);
> > +   amdgpu_psp_debugfs_init(adev);
> >
> >     debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
> >                         &amdgpu_evict_vram_fops);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 6f9bcffda875..3a27ce75f80c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -4185,6 +4185,110 @@ const struct attribute_group
> amdgpu_flash_attr_group =3D {
> >     .is_visible =3D amdgpu_flash_attr_is_visible,  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +static int psp_read_spirom_debugfs_open(struct inode *inode, struct
> > +file *filp) {
> > +   struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +   struct spirom_bo *bo_triplet;
> > +   int ret;
> > +
> > +   /* serialize the open() file calling */
> > +   if (!mutex_trylock(&adev->psp.mutex))
> > +           return -EBUSY;
> > +
> > +   /*
> > +    * make sure only one userpace process is alive for dumping so that
> > +    * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is
> consumed.
> > +    * let's say the case where one process try opening the file while
> > +    * another one has proceeded to read or release. In this way, elimi=
nate
> > +    * the use of mutex for read() or release() callback as well.
> > +    */
> > +   if (adev->psp.spirom_dump_trip) {
> > +           mutex_unlock(&adev->psp.mutex);
> > +           return -EBUSY;
> > +   }
> > +
> > +   bo_triplet =3D kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
> > +   if (!bo_triplet) {
> > +           mutex_unlock(&adev->psp.mutex);
> > +           return -ENOMEM;
> > +   }
> > +
> > +   ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2=
,
> > +                                   AMDGPU_GPU_PAGE_SIZE,
> > +                                   AMDGPU_GEM_DOMAIN_GTT,
> > +                                   &bo_triplet->bo,
> > +                                   &bo_triplet->mc_addr,
> > +                                   &bo_triplet->cpu_addr);
> > +   if (ret)
> > +           goto rel_trip;
> > +
> > +   ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> > +   if (ret)
> > +           goto rel_bo;
> > +
>
> Is it really needed to allocate and send the command each time on file op=
en? Can't
> this be cached, or is it because of the 32MB size needed?
>
[Morris]  And yes, I want to free the 32MB ASAP since it is one time operat=
ion and should not impact the memory usage as that much.
And from the user space point of view, they need the latest ifwi image as t=
here could be ifwi flashing before reading. So caching is NOT a good idea i=
n that it will give the obsolete ifwi and also occupy the 32MB memory, whic=
h is not necessary.

> > +   adev->psp.spirom_dump_trip =3D bo_triplet;
> > +   mutex_unlock(&adev->psp.mutex);
> > +   return 0;
> > +rel_bo:
> > +   amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> > +                         &bo_triplet->cpu_addr);
> > +rel_trip:
> > +   kfree(bo_triplet);
> > +   mutex_unlock(&adev->psp.mutex);
> > +   dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
> > +   return ret;
> > +}
> > +
> > +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __=
user *buf,
> size_t size,
> > +                           loff_t *pos)
> > +{
> > +   struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +   struct spirom_bo *bo_triplet =3D adev->psp.spirom_dump_trip;
> > +
> > +   if (!bo_triplet)
> > +           return -EINVAL;
> > +
> > +   return simple_read_from_buffer(buf,
> > +                                  size,
> > +                                  pos, bo_triplet->cpu_addr,
> > +                                  AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
> > +
> > +static int psp_read_spirom_debugfs_release(struct inode *inode,
> > +struct file *filp) {
> > +   struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +   struct spirom_bo *bo_triplet =3D adev->psp.spirom_dump_trip;
> > +
> > +   if (bo_triplet) {
> > +           amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr=
,
> > +                                 &bo_triplet->cpu_addr);
> > +           kfree(bo_triplet);
> > +   }
> > +
> > +   adev->psp.spirom_dump_trip =3D NULL;
> > +   return 0;
> > +}
> > +
> > +static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
> > +   .owner =3D THIS_MODULE,
> > +   .open =3D psp_read_spirom_debugfs_open,
> > +   .read =3D psp_read_spirom_debugfs_read,
> > +   .release =3D psp_read_spirom_debugfs_release,
> > +   .llseek =3D default_llseek,
> > +};
> > +#endif
> > +
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
> > +defined(CONFIG_DEBUG_FS)
> > +   struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> > +
> > +   debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_ro=
ot,
> > +                           adev, &psp_dump_spirom_debugfs_ops,
> AMD_VBIOS_FILE_MAX_SIZE_B *
> > +2); #endif }
> > +
> >  const struct amd_ip_funcs psp_ip_funcs =3D {
> >     .name =3D "psp",
> >     .early_init =3D psp_early_init,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index 3876ac57ce62..089b6ae48329 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -39,6 +39,18 @@
> >  #define PSP_TMR_ALIGNMENT  0x100000
> >  #define PSP_FW_NAME_LEN            0x24
> >
> > +/* VBIOS gfl defines */
> > +#define MBOX_READY_MASK 0x80000000
> > +#define MBOX_STATUS_MASK 0x0000FFFF
> > +#define MBOX_COMMAND_MASK 0x00FF0000
> > +#define MBOX_READY_FLAG 0x80000000
> > +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2 #define
> > +C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3 #define
> > +C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4 #define
> > +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
> > +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
> > +C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>
> To be consistent with ADDR commands, better name this as
> C2PMSG_CMD_SPI_GET_ROM_IMAGE
[Morris] Thanks for your feedback. Just as the update command these macros =
are inherited from FW side. I would prefer to keep it as it is for the cons=
istency with FW side.

>
> > +
> >  extern const struct attribute_group amdgpu_flash_attr_group;
> >
> >  enum psp_shared_mem_size {
> > @@ -138,6 +150,7 @@ struct psp_funcs {
> >     int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
> >     int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
> >     int (*update_spirom)(struct psp_context *psp, uint64_t
> > fw_pri_mc_addr);
> > +   int (*dump_spirom)(struct psp_context *psp, uint64_t
> > +fw_pri_mc_addr);
> >     int (*vbflash_stat)(struct psp_context *psp);
> >     int (*fatal_error_recovery_quirk)(struct psp_context *psp);
> >     bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6
> > +335,14 @@ struct psp_runtime_scpm_entry {
> >     enum psp_runtime_scpm_authentication scpm_status;  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +struct spirom_bo {
> > +   struct amdgpu_bo *bo;
> > +   uint64_t mc_addr;
> > +   void *cpu_addr;
> > +};
> > +#endif
> > +
> >  struct psp_context {
> >     struct amdgpu_device            *adev;
> >     struct psp_ring                 km_ring;
> > @@ -409,6 +430,9 @@ struct psp_context {
> >     char                            *vbflash_tmp_buf;
> >     size_t                          vbflash_image_size;
> >     bool                            vbflash_done;
> > +#if defined(CONFIG_DEBUG_FS)
> > +   struct spirom_bo *spirom_dump_trip;
> > +#endif
> >  };
> >
> >  struct amdgpu_psp_funcs {
> > @@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
> >     ((psp)->funcs->update_spirom ? \
> >     (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> >
> > +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> > +   ((psp)->funcs->dump_spirom ? \
> > +   (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> > +
> >  #define psp_vbflash_status(psp) \
> >     ((psp)->funcs->vbflash_stat ? \
> >     (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +606,7 @@ in=
t
> > psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,  bool
> > amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);  int
> > amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
> >                                enum psp_reg_prog_id id);
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
> >
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > index 17f1ccd8bd53..99ff0bfd9d4a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > @@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
> >  /* Retry times for vmbx ready wait */  #define PSP_VMBX_POLLING_LIMIT
> > 3000
> >
> > -/* VBIOS gfl defines */
> > -#define MBOX_READY_MASK 0x80000000
> > -#define MBOX_STATUS_MASK 0x0000FFFF
> > -#define MBOX_COMMAND_MASK 0x00FF0000
> > -#define MBOX_READY_FLAG 0x80000000
> > -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2 -#define
> > C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3 -#define
> > C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> > -
> >  /* memory training timeout define */
> >  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US      3000000
> >
> > @@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_contex=
t
> *psp, int cmd)
> >     /* Ring the doorbell */
> >     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
> >
> > -   if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> > +   if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> > +       cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
> >             ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0,
> 0, regMP0_SMN_C2PMSG_115),
> >                                              MBOX_READY_FLAG,
> MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
> >     else
> > @@ -766,6 +758,39 @@ static int psp_v13_0_update_spirom(struct psp_cont=
ext
> *psp,
> >     return 0;
> >  }
> >
> > +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> > +                              uint64_t fw_pri_mc_addr)
> > +{
> > +   struct amdgpu_device *adev =3D psp->adev;
> > +   int ret;
> > +
> > +   /* Confirm PSP is ready to start */
> > +   ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_115),
> > +                      MBOX_READY_FLAG, MBOX_READY_MASK, false);
> > +   if (ret) {
> > +           dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d",
> ret);
> > +           return ret;
> > +   }
> > +
> > +   WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +lower_32_bits(fw_pri_mc_addr));
> > +
> > +   ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> > +   if (ret)
> > +           return ret;
> > +
> > +   WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +upper_32_bits(fw_pri_mc_addr));
> > +
> > +   ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> > +   if (ret)
> > +           return ret;
> > +
> > +   ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
>
> Returning directly from here will do.
>
> Thanks,
> Lijo
>
[Morris] yes, will make the change in v3. Thanks

> > +   if (ret)
> > +           return ret;
> > +
> > +   return 0;
> > +}
> > +
> >  static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
> >     struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +923,7 @@ stati=
c
> > const struct psp_funcs psp_v13_0_funcs =3D {
> >     .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
> >     .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
> >     .update_spirom =3D psp_v13_0_update_spirom,
> > +   .dump_spirom =3D psp_v13_0_dump_spirom,
> >     .vbflash_stat =3D psp_v13_0_vbflash_status,
> >     .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
> >     .get_ras_capability =3D psp_v13_0_get_ras_capability,

