Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C917C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BE510E517;
	Thu, 17 Sep 2026 18:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uY5vyuRO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44DE10E517
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYSpvBtJppNS0IhiRMvk9Vt2XPJggkk47Y6Wr6SYlg0XL+1DYfuBjqXWZvBz5hAoL5NB2MJfIQw7Jq2FGOesDoell4r+DBIjRUyfZaB7I5gSa3ShP0nlcEkL2LylBzN6ZC8OC/EKa7t5JDxzzS1+BHZP62gSJMkNII0tww3u9DUhUlEAenwG+OiNc99NZ5jqR2Ae4jjfJ39GOW2pNo9+CcEyYXgqK6S5vMgDssEkLOTVNePM4W4bfhsc9UZz6YioOR4IGDtJqkZsVUa8RJ/lm3E91IxHKXmWTYM/YoNKO7L+yvyDxZGU3ODyy6xp9rAAeaU+DBLlFdTLePxFnOKEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOOwka8aS2uKoe5m6ssB88o2+rKjjsDUuy5qb9smGPU=;
 b=nOU+hx6SJEb3aWwONREDTzx/XHnbZwMYi9CKbWyE2/s3YM2Gc6CicqsntHIXlQNjmgdEK/vrNLwubSUm5xmqq0FXKsakN9bgXNxuy/Xns8myfVXFMXVjTPA+qKGUEbRA684yFGohCW63qpG1oRK+3JAtdEO1q/rLR6TWGYkKTU6/ASN9Y5aWxjlIAnXL3+Kl+/6gwwpYnl1AZq/+th38HJcNaxMcg9jtBZxTeFPy+XzNdobD9vLIcaY/ElIwZhO63BJQU/EdA3d+V9W5PUo9gbusRugCcxzfcL+iYBTPXTgNVyw9VEFU0wFB62oQkmVaLV++1ZJovv+fGvKlESNdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOOwka8aS2uKoe5m6ssB88o2+rKjjsDUuy5qb9smGPU=;
 b=uY5vyuRO0CITlI2/lqtbLJrQjMq/flnD1h9lGFlrjqpXCroX7hqugmqKCiS0W+s5e4kdTGJGHQNoCvNxK0ZUGZYiXulZrHlHePc+8X1rz0eyYX3lf1PFBw9W4BunhpC2Loh4DLTzMOgaLLi4LzG9nFn7JmmNo31YG0pr9gy1Po0=
Received: from SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:42:22 +0000
Received: from SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef]) by SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 18:42:22 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Topic: [PATCH] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Index: AQHdRtL1v5SkKocKO0iZRirzT+JLuLbTGpgA
Date: Thu, 17 Sep 2026 18:42:22 +0000
Message-ID: <SA1PR12MB888780C6B57B249DDCB06B6A85B82@SA1PR12MB8887.namprd12.prod.outlook.com>
References: <20260917183220.622058-1-lancelot.six@amd.com>
In-Reply-To: <20260917183220.622058-1-lancelot.six@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-17T18:41:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8887:EE_|SJ2PR12MB9190:EE_
x-ms-office365-filtering-correlation-id: af79b2ad-577b-4f35-858e-08df14eb694a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 0yndLdprrG+N9MBA1YpeHOkpgkiNSTbuMqMKKYqcn5pMWgbHjdONsZf+kMIN6qfesr6MtRRLxIVZG6gvcMbYsGISMmX4VeOfORHww1FqN88jiGPa9qwujBTa/o6/HSeo2CR/VMxwiQKQikIfY5dhfAay6IdhuI5UstPyj3lNLr4VCpAhX0t/dO7uaXHmCXfeA/b7kH5efWTH6xu/fFPVIKm/e3yWD96SHkcTCxNKI39bdu3SSKjOZXpAezAkc36QyCH9LNQutjr5n6dHqMYsMF7qFy1Yci0BxlQFw3VdemFW7Ak6hpfdz1TV1Kt6rz7jp+WWItecFRuTSg7vCVpdtsWrxMBQ/1aQeVo4305ORlhh1S5hKKf0NRnSSlbhLSY32D7rBp8ZrcZjkLEEtn8fUcvMrHVFDgybI8IWvKKW/m6sX8jIQNU353FPK6p7DytraKG79Te/O3CT7zHScj+Lk94jqCDAbRBtD2O5MZcZLGo10tSKyaXvwUp9b3P7l67N+p7G0o7BHcUYzo2dyDB+YrdkhJ0hx1w5JOXYSNlQNQubpqUFHeXyJt9yZk/zmrFBwGGMVzSjvnH8NwdeHWLNFEzIs98QM489M/76cIZESfzTMKWvuDF4H0gPB08rBHkHMFl3+s9cR3McDICHJlxTwjZqkiLqDizvQAa6lNvgDOhhUOn9qtsdqNwzE6YH64oTFmO7Z/nORIXZKBv5Q+KrgdYHAIdDAERdCAfHBiQTk7w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8887.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6vUijJG6R9Lw1hSWCwxUdeoD/sdtSZY9RFg+P4HXlSo8m+3uLoeVNvAsp6J?=
 =?us-ascii?Q?i3cdGHOjp5K0gq2fa8w8xKQPC8uUhqHZ6eo46tjDlVqnnAeyyxxGGVVEDxd6?=
 =?us-ascii?Q?92xAl/FQYxKR3sSBCSIHfD4pbCBOQmk25saJyDF58dYDMdxDXpiGZukaMXY1?=
 =?us-ascii?Q?sRMEJXrIGGbtHO2PGL4LC2hTL5yl/VYk3aSxsGHwwasnrY7ApNrPeo7rQBRY?=
 =?us-ascii?Q?zAAtYn4WWLdaTZ2FDKExvcDswHUON7BcRSuPHgdUSyrjtVk3hX3jolMRhsXY?=
 =?us-ascii?Q?rC3Sr8BJgfNFdCM76Ixv+wYoU63BpHz6Lwbs3R5vn0+P1yRmFhDXo40//n8H?=
 =?us-ascii?Q?Qxe6qj5gBiZ9PZn1ov/n1neAOMnXpwDBTjYhAnXqy+asZeuPqTiihARHlAAb?=
 =?us-ascii?Q?/zQZghtXBKMHUI3uFUjIXKiCt4yeNQTrezZpgMRDh4EPnSkelV2FBPeZvXHa?=
 =?us-ascii?Q?Uwb+Z/XLtTADlp5XmXjnFxXdVEuxgBngfQFhzqNQ9CXqlOMtbDaUQOi77KwO?=
 =?us-ascii?Q?dOsesMjYSjICKJkNZuGc7LUjqrZHmN0tZFM3HMuJpBDHVLvI4KifVEl3ijCj?=
 =?us-ascii?Q?PU9o4oRR5MAPBr7gH5c3CPJuIcXjyHf6hYGjGuBdbYsRC880GIjM7gb2h3/i?=
 =?us-ascii?Q?HaAjd8pbifF/HczRLMyxphprCx2TWm6yiyJZyKUvQSh6R0jsXs9GNKt+DAdH?=
 =?us-ascii?Q?juWLY3lWhCZViyYSZhoBqn7/nGJ23ogMvQj1xk1y+yQG+suZS+BXEg6jFy+8?=
 =?us-ascii?Q?Y1zG/E0wqdKYlAj2j3bYrhBuFwMJmM9YjU1BqFCgBUMQXC6UbIICivZ0RTJ4?=
 =?us-ascii?Q?hUCrPc0MMprUHDXW7OiT6wEOGPNwvD/usSpf751tvH7IabmScgNI9de7h3Zi?=
 =?us-ascii?Q?tn+swCOq1m/qeh/Pxbu/edsIrnGqdEis7X4FaL3ulMIYqRtK5NcMP/NFPXtg?=
 =?us-ascii?Q?+qPmRT+iwgSASeyQ+dwUBA0aEiVQ3fpo7cmK2uSrD6ttUbRJ0PD2Dsb3L9dw?=
 =?us-ascii?Q?vvQO96Iioz0oUF5tPUwdO85zO9HXRWVLbSDzzClqaEYDFFz5D1QJSCLjNFwh?=
 =?us-ascii?Q?HqE7Y7QWyFm8hd2w9diB9YmTVq3EH6a7G6kgzdY9u6aloFKyo6xiNsnvuSKM?=
 =?us-ascii?Q?tUVT4TMNxBshs23EacmqgHHcMp9BYpjuF42IfCglLe8Sy4kkXCqZCSTAGoyp?=
 =?us-ascii?Q?hbZEEwXG5+/VdDuZjQ5bPBE2UXizdISjhn2QEnTZnf05sEAV0VMOOeL8UofT?=
 =?us-ascii?Q?MGDeobwqSyg5XnGAEhpL1EwZ2xZMrlGJCPGjnc0+lLbuGI2snuEfraIqhT6i?=
 =?us-ascii?Q?pduJj5cJGk4pVRgPhwPJLukYtKFpqWyqjukCCDhBYpxEwx9CO5OW96MqDuyG?=
 =?us-ascii?Q?ExWxvsH5HnUZ1/4KDKaP8mzNIOdbtpyHEZArWp+w69UTN509QHg1+/YLQ9rJ?=
 =?us-ascii?Q?H2M8skzbRR6/Qlt4oNk+6TTPPGHgLYJMftiVH+WwPhTRA4+jfGTx36WQwotA?=
 =?us-ascii?Q?/zYmv22T9fImgeu5BFbDPTpwRJQzuTBTYBzBmFGJ0jKu7/7Um5wcQm+HQjLl?=
 =?us-ascii?Q?orXfcfQPPo/bLoP67S+lLAv+lDI1S5uO3QVBAYAphIgg6yKhg6HolS4ORUXT?=
 =?us-ascii?Q?jOqOXUgJ1OW9Ndq8R+esDUn5nH/cAk9SiGr6/YX/RJ5PQSkuxJEzCmO8/aal?=
 =?us-ascii?Q?lYNvqo6jp/ysrsp+Av0i5nT/hSiq9mYvi8DyKUgRkh+OkrDu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8887.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af79b2ad-577b-4f35-858e-08df14eb694a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 18:42:22.5144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nr3bV1YMlJcL2m+Tw0bw68U9U7W9mg9Rh7wXqxX+Y34WF0nnevQ5YJnzihWPgoU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lancel=
ot
> SIX
> Sent: Thursday, September 17, 2026 2:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Six, Lancelot <Lancelot.Six@amd.com>
> Subject: [PATCH] drm/amdgpu: Add pci_domain to struct
> kfd_dbg_device_info_entry
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The device info structure returned to the debugger via the
> KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT ioctl contain location of the
> device on PCI (bus, device, function), but is missing the domain this
> location belongs to.
>
> This patch adds this information to the snapshot structure.  The overall
> size of the kfd_dbg_device_info_entry structure structure, this new
> field is placed in preexisting padding.
>
> Tested using the ROCm debugger.
>
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>

Reviewed-by: Jonathan Kim <Jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
>  include/uapi/linux/kfd_ioctl.h         | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 0dd1fd448059b..2c14b03df0781 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1129,6 +1129,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process
> *target,
>                 device_info.capability =3D topo_dev->node_props.capabilit=
y;
>                 device_info.debug_prop =3D topo_dev->node_props.debug_pro=
p;
>                 device_info.capability2 =3D topo_dev->node_props.capabili=
ty2;
> +               device_info.pci_domain =3D topo_dev->node_props.domain;
>
>                 if (exception_clear_mask)
>                         pdd->exception_status &=3D ~exception_clear_mask;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 749d196e2114b..e7908a068d3d1 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -49,9 +49,10 @@
>   * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptio=
ns
>   * - 1.22 - Add queue creation with metadata ring base address
>   * - 1.23 - Add profiler control ioctl to enable/disable profiler on a p=
rocess
> + * - 1.24 - Add  PCI domain in kfd_dbg_device_info_entry
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 23
> +#define KFD_IOCTL_MINOR_VERSION 24
>
>  struct kfd_ioctl_get_version_args {
>         __u32 major_version;    /* from KFD */
> @@ -151,7 +152,7 @@ struct kfd_dbg_device_info_entry {
>         __u32 capability;
>         __u32 debug_prop;
>         __u32 capability2;
> -       __u32 pad;
> +       __u32 pci_domain;
>  };
>
>  /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_pol=
icy */
>
> base-commit: cf48bd0a46279f4607956cb17c71bda96ee802e3
> --
> 2.43.0

