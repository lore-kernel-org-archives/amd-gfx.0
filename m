Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB500E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 18:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0ED10E19A;
	Mon, 30 Dec 2024 18:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28prt5q1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46D110E19A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 18:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMxskyBITPICgiOeLp3XQveTnSTAeIchnMPFyGA59lugV/1mnX3H+PA4w2X9Dx5G+PDaK3H3g67SnpdoFYJYEeHmAEltJSWLdA2FQ/uH8N8Boim7JAw2ZsNKkiLsbUdZslDFfHxkrWQllut7pEbaKVLVxh7NlAmGsdoqpWadTWSr34pB/RpEP8QqYKHo8ZpfRm+hBCqUxnoV9YbMTbbI8W6VhyaSgJ3OyVJKJOvkfRbSscbOtIvHNqV+VFv0Hig1zf+Y+GxgrYEVE/31Uw1xTX1TmyA9D4y30EMiP1x3sIpPKAmJ/hRd3irH7VJwCz/lKi/2REjKMC6kHq4GpJBZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig8yuXJ9K+BocMPRTEUCgtaA1el/u6y4aksB/+xBkZI=;
 b=ENHzrAz21Zajwq2MtO9vbnf43+YWoNyAQqzEq4b4uJmt5PFYcMTaZ7MBwUwYJkojRAJASGBb9ctpKIx10LMdsKrry7zye+sHu/V0ue3ZMwxGdq2PteqYA41e4dJilZYILe3JeTR0trr27dAqdfX/MOO0lTreYuRJrjrI+KeuvF05FD0mZKPNEJE8ZuYtRiB5u3eq6vgDK+CrYhOYDfGrxtKSwDsZxdkWlrOm7qocd4Pzz5VhKg6p0E2gAXTQJlF7uPVqA/taObuyvxDcrYmA+F0tWDhTD7T+TWpbN6FelgyythBtV8PMc/Og/YKL5KYE1hdDGPI6nsKASXHrlhfzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig8yuXJ9K+BocMPRTEUCgtaA1el/u6y4aksB/+xBkZI=;
 b=28prt5q1TGilBMbGfZQSFy8UdLtB88CXuMBkLdSUwd/cXO8fJ6l8EOwHPQjQSv4DIHicB58M3ipcTrQytPcDZKOKOcIqJEOaLdy7FeQ1zERJvU7Bhg4JTfj/B73+M6xSidvDd1xAHxvgSZeWbK7Jb0lMQcqaGOaKdNK4tFFPK84=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 18:15:01 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 18:15:01 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Index: AQHbWtzVwZL9Z8SLhUG/oG7mXIfKgrL/DyMAgAACV4A=
Date: Mon, 30 Dec 2024 18:15:01 +0000
Message-ID: <SJ0PR12MB8138C3B22C551491933825A2F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20241230170223.574547-1-Andrew.Martin@amd.com>
 <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=875e0fdb-fd47-4e84-b2c6-d64d1f1c1207;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-30T17:35:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|DM4PR12MB8473:EE_
x-ms-office365-filtering-correlation-id: b5372042-7651-4a5a-61d0-08dd28fde050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?n2M0WSpx2XYQFxzY3gDjZkLkv+Bs2GpNSisYR0+dC+zB2UbZmyDwq+4tOhm1?=
 =?us-ascii?Q?qrRDw45wtYj/+R1wBExg/q0bRspDgKv2Su9v3lbXHv7ZNLLZu1AaVNaJLpT0?=
 =?us-ascii?Q?kYbQi2sPgOe0sAiepeK2I8Op02bkyNRASw0S2uwajspGyosJR+qNXcNpDxyY?=
 =?us-ascii?Q?txTkOYt426/tdPLpnFF41k+RuwmXhRCkrmSpd8D/r+F1ROEvMC1xpHEtRMb0?=
 =?us-ascii?Q?tmtHsKYZggRS+WPX8DKkbNDDjtWyNRg2Ar6z2Gp5ac5c13BRe6MjzgWeXEi9?=
 =?us-ascii?Q?eMAJBRLFguyiU8MReO9/6WjbvJsY4ma1G9e1p2dgdalhFUstUGaRjVj/VcTn?=
 =?us-ascii?Q?zW0fuW0827RdwT03GbNrz4yNTKP8xMZvEYhi/Kchgc2jZu9DEE4gcN+JRz1V?=
 =?us-ascii?Q?2uL2HZ4FaXy43ND0L/bFynR3sCiTSiUzsqu/HTVEZY8H2kLFSnjF2r0TxxfK?=
 =?us-ascii?Q?rY44+UMa8fCtyE0rrKHim/ApqweZd9rvO+fNFv2YruUpitfKcxQF6hqBRPQ+?=
 =?us-ascii?Q?X1CFITcMuaznqbVHxv3DvaLGCx7s0VBLj9IkRu4PAKcSlNn5WpXIunkbMhCf?=
 =?us-ascii?Q?rythCfdlqwLKnhIbss5oav8rJA1W6wZpZnvKpyVkb7l6WNAO30r7z577k4KG?=
 =?us-ascii?Q?aYnv9GzAowJru3X2QEFO6MhU/wXUO09/0XyE3TH5tQiU62vlBHgQ2CC0VlnF?=
 =?us-ascii?Q?iFcOQfFjMA5yxiOB66hqA+UOsxqn54C+ky26pRBA2odFCTYGPSBl77sMxY7G?=
 =?us-ascii?Q?ashm2+Nz8SBduNA4Boy4NKA7SwyjFq6vaApS54YdTXfOEuabxhkI1F/IGgnC?=
 =?us-ascii?Q?g5laOlkSRTzz2DRqut0GdKnmb34iNCgypf7KBPzrl+5HNcGnROKEmA+u/qb5?=
 =?us-ascii?Q?rkt8eE+JMLJm5pi9lNMucTY5OOd7MtuVfaEqLLgXYIs0mpzcl1YZABf9vcZp?=
 =?us-ascii?Q?I8H6SkSSQqJjDHbjjgsNR2Z9CqlqZalgdjL4BvMcuqXidVM2c0ctpvep4/j1?=
 =?us-ascii?Q?kjXiF8uojcWmJ/Z/zgmeDq4pBzHbGI65gcXvtggTT25qFaBYEhz9nJQrw2zl?=
 =?us-ascii?Q?N9S8LIJZJR2IYWlw+wIFsjjy8yggbQWEwFu+MBYShI+6xR18AV8wBinqNmay?=
 =?us-ascii?Q?HwzVpurThc/vBOee5p9+fThRvOMLoVq+YiMv4DN2LsR+DQohDy/Y67+yBrNG?=
 =?us-ascii?Q?OFRBLyMR4DUpyOVgqxjPFnUh94a2eIRkA08HtUIJhHEKjLk+GQjx9oXjWg6q?=
 =?us-ascii?Q?Pd4uMp2zgdRbHrisiFe5M6/ckrer0LqRa6q5J8TYRrEYHoWsDHc1qTlYQ3bY?=
 =?us-ascii?Q?4itUzICANieibNXUxB0BX42yvofXDmW4IRTfTbemJrTmD9tBM13jNM78JN8i?=
 =?us-ascii?Q?rqXnne/KBCRUOg/1rNZNYcyqYs4munS43bb5ZkQmdJRWnbVpTVVf6Lw6vM6T?=
 =?us-ascii?Q?YLHM93PioS6pCm3gcDxXy+I9eF8gos5m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OdB5V3QK44Gxk74P3quH5RetTclri3QUzpbZ90UKlDimLd1cwd0xRIkH42RT?=
 =?us-ascii?Q?STt2GVMLQFDtXGwSU2UV3UPUcBNy5m5vsf16sea7Huz7vkJodBtRiBDZ2RIv?=
 =?us-ascii?Q?wT5NPlR1YTvgc0CwpxvDnup/kE0kZFW/gWq/LMorcXp29MAJTb0RoWQPcYac?=
 =?us-ascii?Q?SXHxGuGxe/40a3c91F6mr36vlgnYKXqHtTD7AkW5c4vfumILbDW2dEwssFMM?=
 =?us-ascii?Q?kBjcIif9cO1zMuYeZTxvdBB8vyfik9Wc2FiZHK3lq+YILki8DJlATtAyzQ4J?=
 =?us-ascii?Q?g4i/RU7ynLYK3syII2k3Pg2GgrD9cbODrsKUOkSk+6oQyE+5MIiwR4Preg5E?=
 =?us-ascii?Q?UdvSyznlCs3ezsWwLGnKyyWcuxKxYDkCtZPeKGLrsSWLbEoXWObaC5fcI6Dd?=
 =?us-ascii?Q?wQblGEs8kpWxsl+exJ8VP3ZLpPa4VE2FY+JZsfmjrwbHxdNd5si5CfGTAAWU?=
 =?us-ascii?Q?InHb5TDUyYM27MJY9Lqz4ZRaA0QKrc8aR6z+NhAKjkU+Quiepmln1sNObn3N?=
 =?us-ascii?Q?8dp1xeEZIe3ayEQt8OielPHlaJ2fIZwrydJMrOgtvN62ZVsEwyLHFpnPu630?=
 =?us-ascii?Q?hkI0mIN8vaRLma7OO+zNPaCkUamiBwOFeEJCQl43SHTi6KmO6RG1V+pIPms3?=
 =?us-ascii?Q?RHjdFv5Io4vl8hOcYEclmuuu/b8c8RPkk9+Tof843M4N+/G2NXrrwBR6XPKm?=
 =?us-ascii?Q?Ty3Ae71PYVJ3CTOj+NCfJq1C5CjYAYM+acmRd8+uGdnJ3TitVRZ1A2Tj5O1k?=
 =?us-ascii?Q?NrNrtHo3bHSgSxy6kzBqNmOVFWCZHpeX1jYfxVUrvagaFsQzcLCeu0qyRoPw?=
 =?us-ascii?Q?G8aXEBUvAX87VsQztPITWKmFTTKHWTEREicbXZWxwM9eHSbFYEOnxcu2HJwk?=
 =?us-ascii?Q?cfzsRobSofXg9P4zxuJAtIohAhNBQDbNp1Ctb0aRbj4yPEWpPiOb1c9cMjyS?=
 =?us-ascii?Q?KYI2z6dKkq2Ebl+gBKR/vcURt9iifO0O14O2BnKuwKUmaCF55GVqbvOgGq7w?=
 =?us-ascii?Q?1QXE7mz7gWxPlqv/jWCfPYglmEEUuWeytW/jOb6Sn+2WF7/iqt0IAv5zAdh9?=
 =?us-ascii?Q?a/63eS0muSjM2rsAVpnyIcr75qdsPbBkPhWLgWjgPf5DZdWDIjQAnUfvNbBk?=
 =?us-ascii?Q?J3BrYP5huYq3rn6zcKqRGHKrl8DSFmjZtchgzDUpohQR6PkPWP0mVRToWThI?=
 =?us-ascii?Q?8fMxCXrjFq9fywW8YBTcmRU6pzRh0wNMsKaeTMcJHAUiUfMw9yGMVEOzHY4E?=
 =?us-ascii?Q?lbNdQJ3xKdqcEwY0DmeJeHwyVRhxkWxEEo0TjvLTz3F+fWkKuhJqeArzdWPS?=
 =?us-ascii?Q?E8eYT3XA+mH/XS+p1hsQBTZvNVDwaL2Xywv14HpTHN0ysJU+/FIRC73GlROD?=
 =?us-ascii?Q?Z7BzrAncx13QWQi0JcAvJUNXPd6G+JTZA4InFkT5A52JzDc3LtGl8tX1WAC0?=
 =?us-ascii?Q?LSc9BcalT576ek+yYwxclwLefEt4DTKwrj+3dyK941L6yQki5Y9sGPMmkzXC?=
 =?us-ascii?Q?8UUy5zFVRbdAcusbcnD3t58il8cG9VDEd0XMO50f/NsqnK9Ot8W64PDjNswk?=
 =?us-ascii?Q?2SanQd0vcisOiAHs9qw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5372042-7651-4a5a-61d0-08dd28fde050
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 18:15:01.1394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AnYG+PRBcv79x529HEsrP8+aLDg3SPyZEdFSLU01qYhbpggkXIUPW7XVxxaHNC+3OTOk5seLLGlIhuOXU4Blg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
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

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, December 30, 2024 12:44 PM
> To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
>
> [Public]
>
> Might be worth changing the commit headline to what the patch does,
> something like Don't ignore return codes Or Various return code cleanup
>
> Otherwise it sounds like your patch is intentionally ignoring return code=
s,
> which is the opposite of what you're doing. Also 2 comments below.

Thanks, will do!, Please see response to your 2 comments also!

>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Andrew Martin
> > Sent: Monday, December 30, 2024 12:02 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Russell, Kent
> > <Kent.Russell@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> > Subject: [PATCH v2] drm/amdkfd: Ignored various return code
> >
> > This patch checks and handles the return code of the called function.
> >
> > Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
> >  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-----
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
> >  4 files changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 065d87841459..52a11dc01422 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -2864,7 +2864,7 @@ static int runtime_disable(struct kfd_process *p)
> >
> > pdd->dev->vm_info.last_vmid_kfd);
> >
> >                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> > -                             debug_refresh_runlist(pdd->dev->dqm);
> > +
> > + (void)debug_refresh_runlist(pdd->dev->dqm);
> >                       else
> >                               kfd_dbg_set_mes_debug_mode(pdd,
> >
> > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 693469c18c60..f335ed9e0b3a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void
> *pcrat_image,
> >       if (kdev->kfd->hive_id) {
> >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> >                       peer_dev =3D
> > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > +                     if (!peer_dev)
> > +                             return -ENODEV;
> >                       if (!peer_dev->gpu)
> >                               continue;
> >                       if (peer_dev->gpu->kfd->hive_id !=3D
> > kdev->kfd->hive_id) diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > index a8abc3091801..b4db409d90a1 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > @@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >       for (i =3D 0; i < target->n_pdds; i++) {
> >               struct kfd_topology_device *topo_dev =3D
> >
> > kfd_topology_device_by_id(target->pdds[i]->dev->id);
> > +             if (!topo_dev)
> > +                     return -EINVAL;
> > +
> >               uint32_t caps =3D topo_dev->node_props.capability;
> >
> >               if (!(caps &
> > HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> > &&
> > @@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >                               continue;
> >
> >                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> > -                             debug_refresh_runlist(pdd->dev->dqm);
> > +
> > + (void)debug_refresh_runlist(pdd->dev->dqm);
> >                       else
> > -                             kfd_dbg_set_mes_debug_mode(pdd, true);
> > +                             (void)kfd_dbg_set_mes_debug_mode(pdd,
> > + true);
> >               }
> >       }
> >
> > @@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > *target, uint32_t *flags)
> >   */
> >  void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind,
> > int
> > unwind_count)
> >  {
> > -     int i;
> >
> > +     int i, r =3D 0;
> >       if (!unwind) {
> >               uint32_t flags =3D 0;
> >               int resume_count =3D resume_queues(target, 0, NULL); @@
> > -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> > *target, bool unwind, int unwind
> >                       pr_err("Failed to release debug vmid on [%i]\n",
> > pdd->dev-
> > >id);
> >
> >               if (!pdd->dev->kfd->shared_resources.enable_mes)
> > -                     debug_refresh_runlist(pdd->dev->dqm);
> > +                     r =3D debug_refresh_runlist(pdd->dev->dqm);
> >               else
> > -                     kfd_dbg_set_mes_debug_mode(pdd,
> > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > +                     r =3D kfd_dbg_set_mes_debug_mode(pdd,
> > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > +             if (r)
> > +                     break;
> >       }
> >
> >       kfd_dbg_set_workaround(target, false); @@ -1071,6 +1076,10 @@
> > int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> >       for (i =3D 0; i < tmp_num_devices; i++) {
> >               struct kfd_process_device *pdd =3D target->pdds[i];
> >               struct kfd_topology_device *topo_dev =3D
> > kfd_topology_device_by_id(pdd->dev->id);
> > +             if (!topo_dev) {
> > +                     r =3D EINVAL;
> > +                     break;
> > +             }
> >
> >               device_info.gpu_id =3D pdd->dev->id;
> >               device_info.exception_status =3D pdd->exception_status;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 1405e8affd48..250aa43a39c8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -1907,16 +1907,18 @@ static int start_cpsch(struct
> > device_queue_manager
> > *dqm)
> >
> >  static int stop_cpsch(struct device_queue_manager *dqm)  {
> > +     int ret =3D 0;
> >       dqm_lock(dqm);
> >       if (!dqm->sched_running) {
> >               dqm_unlock(dqm);
> > -             return 0;
> > +             return ret;

I can agree with this one, since it minimizes the changes, but it does flow=
 the same.

>
> I think it's cleaner to just leave the "return 0" . e.g. If the code gets=
 refactored
> and new stuff gets added above, then this might flow differently.
>
>
> >       }
> >
> >       if (!dqm->dev->kfd->shared_resources.enable_mes)
> > -             unmap_queues_cpsch(dqm,
> > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD,
> > false);
> > +             ret =3D unmap_queues_cpsch(dqm,
> > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> > +                                      0, USE_DEFAULT_GRACE_PERIOD,
> > + false);
> >       else
> > -             remove_all_kfd_queues_mes(dqm);
> > +             ret =3D remove_all_kfd_queues_mes(dqm);
> >
> >       dqm->sched_running =3D false;
> >
> > @@ -1930,7 +1932,7 @@ static int stop_cpsch(struct
> > device_queue_manager
> > *dqm)
> >       dqm->detect_hang_info =3D NULL;
> >       dqm_unlock(dqm);
> >
> > -     return 0;
> > +     return ret;
>
> Same here
>

If I change this back to "return 0 ;" then I would have lost the return val=
ue from "unmap_queues_cpsch()" or  "remove_all_kfd_queues_mes()" which was =
the whole point of touching this function.  But since we in the "stop_cpch(=
)" perhaps it is a more optimal solution is to ignore the return code with
...
(void)unmap_queues_cpsch()
else
(void)remove_all_kfd_queues_mes()
...

Which would be the only change here. Otherwise, I would need to introduce a=
 3rd return statement.  So do let me know which path complements the design=
 more.

>  Kent
>
> >  }
> >
> >  static int create_kernel_queue_cpsch(struct device_queue_manager
> > *dqm, @@ -3439,7 +3441,6 @@ int suspend_queues(struct kfd_process *p,
> >                                       else
> >                                               per_device_suspended++;
> >                               } else if (err !=3D -EBUSY) {
> > -                                     r =3D err;
> >                                       queue_ids[q_idx] |=3D
> > KFD_DBG_QUEUE_ERROR_MASK;
> >                                       break;
> >                               }
> > --
> > 2.43.0
>

