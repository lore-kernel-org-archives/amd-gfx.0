Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5ABC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 20:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9AD10FE85;
	Fri, 26 Jan 2024 20:51:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A09910FE85
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 20:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctKS/BIfMVQPEYXRpcI5/ni7VXxxZIpbTM3QaWqytbklYn5Qh6l7SZVGyjsdxtbDlzCt1eFdAHEg6nJbID416aH9eumc384/6b7l7/I/LvBMHsOwLXYnsu9K3TXGVy8GwQYVTYQmBZvR9HSjI2olJNu4eTaC5s3Aa7ERjvyY0yUsKmU5AKuL9WPsQkZC6evj0JBQcAM8CyxRMnLaT72VXwjNVmRNNRqxkDi47HRpqJRO3k+mf/DtXxWo2ZYSMVKGQjdrrpm2dvGfeGp9ahEgJ4Eqbk5d2By1DNX6zjNnxwABwUjuB1OeM6QyMzSCCakhYTe7NqJue0sQ/QsaXoLbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1XErzD/vhPtL+XQwFADoezBgBXgXbQWcinxQNgeTdc=;
 b=T3nvs7XZStw4q76mnvS2VidghcWQI4N+9jh7vms8OlWNbT2qO6oeelTLEWZ5pZufIeqxtmHhrraDyhYNbld7aoC4JuXrdPYd0P2cxbLMDhgQu/pOk3azFRWZWhsLhiGYMoMw9Yn+ePwbu3qqAVCkveCpleUTSJKyWmCqW+DhDnIqfLOEwb6LIEvdCxiOOxqtAoYdAlWu0M/YmK1foYDZtF5YchYHY/TO9ceTv7ENgPRjmHdHRRnPB6BWV2Kb5/uj2yReg+LvkLY8hChyiEw8eAgLvrWghw/UFy6cL+rlSpuCSiZbWm1zK7IRQHvvmzRqniv2X3RMrTEeyUEmdoy5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1XErzD/vhPtL+XQwFADoezBgBXgXbQWcinxQNgeTdc=;
 b=dBZ/mQGSazr3UTdHtlKJxcNNAAQNvPxdxF3/g1LmBcb6Uzr2P9r2T/E4CaODk3GjsSQOdPjpAahlE50pEE3q6gfV4WAOqQL4yzkCIg8kziJrFhsQC15NvslY+vhaNkvAazCkoR3yVsCKxF5Q3ImOtNf0Y+UdDmZb1dUQMg3jWag=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 20:50:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 20:50:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: William Bulley <web@umich.edu>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Topic: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Index: AQHaUIfmWLYh8IW35UKHk9XWsFTBILDskNtA
Date: Fri, 26 Jan 2024 20:50:54 +0000
Message-ID: <BL1PR12MB5144DF71497E33621393036FF7792@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240126184447.GC660@dell4>
In-Reply-To: <20240126184447.GC660@dell4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=aaf9e295-9252-4389-b264-19e01a787c85;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-26T20:48:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB7837:EE_
x-ms-office365-filtering-correlation-id: af25fbe6-8113-407e-ac26-08dc1eb07da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utjGic6cnGJS4QgchPipE0O8VhNJ51Qyfzlj9WQLH+N+htC1aGK4YwjXkrk+VllZvUwi2lfHlNcT+XA5HEQAeVSPen1oAoWUtFLlPiMmgdpTMApiDbekBMcBRn0Sh4j5Bf1K6rxOppqCifNTLI7O070/4zg3hx/vToHp2g8WYlJyeq8tgdo7u2wAw3uehpHPh3IFSVJJVQQMxyEmm9s7rWpyvV3Rq8g4Jq0KT/kd3HZDFR4W9aVUCQ33PoOD5X3iXPlw8gDZjEdN0gCAue3ZnhLtDjzFyuhA6v0JTmxcb1qfUcn+iYCf4TKlD8ABTVQoN79enjLGB9uYdnJuF8406jEkzgD3xTSydiTnZmZHN8HzOQFRcBbOFiR39z84jQAflx2rqHT7MTFzUfAQumE46uUqlqdwvyOr2uQd1Sge28Z8LeMZe4kCzaK2Jg9D3IF9isQFPcc3/g4N5kh0BM3PXKDOW82/Qrx2w9rlqfi+xdmbEglHrbi6STLaAfxguJZ2OiimgJnubaJ+Z7JjRJ+thUTnqUH4ZTJacj+8gllZbz1vW4QJ1IN7wtpTbw1IxTk2VTH+obFw1hN+nWVjCoSSlEPr5f62UCcQ4rhE404TEUMgOWCgdWu2KEs7tkQgxmdCvUKuc31LL1A0r6EXZK7p7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(8936002)(5660300002)(316002)(64756008)(52536014)(55016003)(66476007)(66446008)(66946007)(66556008)(76116006)(110136005)(71200400001)(30864003)(478600001)(83380400001)(41300700001)(33656002)(966005)(53546011)(2906002)(9686003)(122000001)(86362001)(26005)(38100700002)(6506007)(7696005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f9nL3dzY8AbTdLLB70GYC8yBeHH6gpt5PGS9og78Jnpz8hiTtpAXjam/1pmL?=
 =?us-ascii?Q?9EglEljMF/CJjL5/7UEkzOYzdFVualbaKmR7dWZagbQbHco5J9lp2u/XfVSJ?=
 =?us-ascii?Q?L8N5OUhadK07cyHEiREYMP/XXeYD3E1qodDtnlvChnrs9Mf0k0rTQKqmFW4B?=
 =?us-ascii?Q?QC3UPEH/CRW/toXVliSIgo3Q88cTL6S1M8web7nfeBI3AUKsjud5axEHeCnH?=
 =?us-ascii?Q?Pmr6MMbA6n2BazaI6d63WEdSJeN9Y6XNqaQRAze4nie+VXk5ehjr8Gx+bVwC?=
 =?us-ascii?Q?4TJAaGhboWsYRuCYfmKpzKswprnbVHOMhUGGPIdMwN70resJxwWfF9RjGmVl?=
 =?us-ascii?Q?HaLBmufuWNvvIgeE4WmFufT+jWhxDYIZMLlFZ8NZcCOvg533F+odGg0kQMws?=
 =?us-ascii?Q?cr5+CT0kyEHClcXvtasqgpQ73Rzib/TdfpD86n/YJjlAPEAa2q5fs6B8yw2j?=
 =?us-ascii?Q?bdOOsdID3C8KV5ruNmtfvs2AMqDPlT9BX1WWe4m95yOZNAVOhNaHytvsR+yw?=
 =?us-ascii?Q?5tDHKaqVFyKez6bUeYrP4vReRxSA98kpaZTn0Dy8/2/iaVIoonbiBo7sRvsq?=
 =?us-ascii?Q?NQ8gOxsbTeFTuR+cRE5YcZ2PioQoo5IDwriw0DJJmwxWHc9exD90GecZZm9g?=
 =?us-ascii?Q?cHHM/bvjWYu/d1QS0aUYiCwHsIWd0gJGmQwiqJYyelOnBbUcTQB0K5egURYk?=
 =?us-ascii?Q?Nmaou173WIABeXPu8KbvmQ6OjbHtyAFlm6q5qtyrGdywDQqycfG6tolprxMs?=
 =?us-ascii?Q?Yv2evri7Y/kIGhYKFgJZSzfXmoLBtm1Z5Q5X0J9aCUZqzwu038fQRGd4Dh8d?=
 =?us-ascii?Q?9IAcA2/Msa2LragTN7jwyDu3ptzEl9pA2xnEMWU7+yqzXZYKjl881wo++SNH?=
 =?us-ascii?Q?/yTtsqg9xS/almlSNPN7dUSKAOFe4aI587kt0r787pHrycnswO82Oxv472yE?=
 =?us-ascii?Q?tZywmekIb2lp4sz8Mx15KAHVPbrqpJlNHXWT/lq7dFvXOn+9h61pYGcUbsp0?=
 =?us-ascii?Q?tSg+dBth5U3EjoSxNOKlL6cILUNP+MvWlFHHIyJtpsXUiHDGWd6VQxmuHcYF?=
 =?us-ascii?Q?AHX41ZvbAvQ61ErNwi2b1yUoyCO4och4tIyijhSKctUYBoHkw6Auwc905B51?=
 =?us-ascii?Q?bj+/n8mQvWdBKvdjh3WwdmbWWUlFOq9N7qhiLVCbfLZHSg16/97D3g90SQue?=
 =?us-ascii?Q?JCpB2DKCaMMeVtdx/hkW8mFeHYD/6Ree+4lPcBJXxqUzFgvEUwrcCJc4DVQo?=
 =?us-ascii?Q?xmFs2ENEuNNpwvuxq4Xfcxt2xwE5O/pED4FykcAG21GNxNgbHyQroQMZ4/Jp?=
 =?us-ascii?Q?NOop5+t4+fnI4E+yaP+Tl+WQ7HSlmBmt49K/Khv6PR8ve82JX+98VvkJws0t?=
 =?us-ascii?Q?vl4WMKoXQC8/Py7bqkcOZHpqQGjceLa4DHyb4poitNc33NpEAeu7Isz22F+P?=
 =?us-ascii?Q?zS9swDbz+Hzw//3T0+emmbrewAhEf8vTnZIkaDAvtvjQekhZ99szd8i2IFNW?=
 =?us-ascii?Q?Cy5zlp+jYP3t0yEB0X4H7iaXG1pnWqb7CviD4LSjHJJ9CTc9ZXe6DtRBdjSh?=
 =?us-ascii?Q?pJ+/9CC+Ia4iVQtUhRA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af25fbe6-8113-407e-ac26-08dc1eb07da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 20:50:55.0391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocfo4sQ22+1oiGY3MPRAZD4H+8zixdZKvRW/RrAN02xm4CSI8r/qC4aOjLq409FLwjRdQy9cHljWVwfQ7zLWQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> William Bulley
> Sent: Friday, January 26, 2024 1:45 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Have WX 3200 Radeon graphics card -- cannot get X11 session to
> work
>
> I am running FreeBSD 14.0-STABLE from January 4th.  I have read the
> handbook and followed the instructions there.  I have these drivers:
>
> unix# ls -al /usr/local/lib/xorg/modules/drivers
> total 476
> drwxr-xr-x  2 root wheel      8 Jan 21 14:18 .
> drwxr-xr-x  5 root wheel     13 Jan 21 14:18 ..
> -rwxr-xr-x  1 root wheel 146216 Jan  6 11:41 amdgpu_drv.so
> -rwxr-xr-x  1 root wheel   7344 Jan 11 13:18 ati_drv.so
> -rwxr-xr-x  1 root wheel 112320 Jan 21 14:18 modesetting_drv.so -rwxr-xr-=
x
> 1 root wheel 501696 Jan 11 13:18 radeon_drv.so -rwxr-xr-x  1 root wheel
> 19800 Jan  6 11:41 scfb_drv.so -rwxr-xr-x  1 root wheel  27392 Jan  6 11:=
41
> vesa_drv.so
>
> I have these modules:
>
> unix# cd /boot/modules
> unix# ls -al *amdgpu*
> -r--r--r--  1 root wheel 8581752 Jan 22 15:14 amdgpu.ko <<plus hundreds o=
f
> other amdgpu*.ko modules>> unix# ls -al *kms*
> -r--r--r--  1 root wheel 3013512 Jan 22 15:14 i915kms.ko
> -r--r--r--  1 root wheel 2394600 Jan 22 15:14 radeonkms.ko
>
> I have followed the instructions in the handbook Chapter 5.1 but have nev=
er
> gotten an x11 session to appear.  Whenever I run startx as a non-root use=
r, the
> error message is always
> "(EE) no screens found".
>
> The WX 3200 (RS780?) is a newer card, so I put this line in my /etc/rc,co=
nf file:
>
>    kld_list+=3D"amdgpu"
>
> During the booting of the O/S these 90 lines appear in my /var/log/messag=
es
> file:
>
> Jan 26 10:35:20 msi1 kernel: [drm] amdgpu kernel modesetting enabled.
> Jan 26 10:35:20 msi1 kernel: drmn0: <drmn> on vgapci0 Jan 26 10:35:20
> msi1 kernel: vgapci0: child drmn0 requested pci_enable_io Jan 26 10:35:20
> msi1 kernel: vgapci0: child drmn0 requested pci_enable_io Jan 26 10:35:20
> msi1 kernel: [drm] initializing kernel modesetting (POLARIS12 0x1002:0x69=
81
> 0x1002:0x0B0D 0x10).
> Jan 26 10:35:20 msi1 kernel: drmn0: Trusted Memory Zone (TMZ) feature not
> supported Jan 26 10:35:20 msi1 kernel: [drm] register mmio base:
> 0xFCC00000 Jan 26 10:35:20 msi1 kernel: [drm] register mmio size: 262144
> Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 0 <vi_common> Jan
> 26 10:35:20 msi1 kernel: [drm] add ip block number 1 <gmc_v8_0> Jan 26
> 10:35:20 msi1 kernel: [drm] add ip block number 2 <tonga_ih> Jan 26
> 10:35:20 msi1 kernel: [drm] add ip block number 3 <gfx_v8_0> Jan 26
> 10:35:20 msi1 kernel: [drm] add ip block number 4 <sdma_v3_0> Jan 26
> 10:35:20 msi1 kernel: [drm] add ip block number 5 <powerplay> Jan 26
> 10:35:20 msi1 kernel: [drm] add ip block number 6 <dm> Jan 26 10:35:20
> msi1 kernel: [drm] add ip block number 7 <uvd_v6_0> Jan 26 10:35:20 msi1
> kernel: [drm] add ip block number 8 <vce_v3_0> Jan 26 10:35:20 msi1 kerne=
l:
> drmn0: Fetched VBIOS from VFCT Jan 26 10:35:20 msi1 kernel: amdgpu:
> ATOM BIOS: 113-D0155100-101 Jan 26 10:35:20 msi1 kernel: [drm] UVD is
> enabled in VM mode Jan 26 10:35:20 msi1 kernel: [drm] UVD ENC is enabled
> in VM mode Jan 26 10:35:20 msi1 kernel: [drm] VCE enabled in VM mode Jan
> 26 10:35:20 msi1 kernel: [drm] vm size is 256 GB, 2 levels, block size is=
 10-bit,
> fragment size is 9-bit Jan 26 10:35:20 msi1 kernel: drmn0: successfully l=
oaded
> firmware image 'amdgpu/polaris12_k_mc.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: VRAM: 4096M 0x000000F400000000 -
> 0x000000F4FFFFFFFF (4096M used) Jan 26 10:35:20 msi1 kernel: drmn0:
> GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF Jan 26 10:35:20
> msi1 kernel: [drm] Detected VRAM RAM=3D4096M, BAR=3D4096M Jan 26
> 10:35:20 msi1 kernel: [drm] RAM width 128bits GDDR5 Jan 26 10:35:20 msi1
> kernel: [drm] amdgpu: 4096M of VRAM memory ready Jan 26 10:35:20 msi1
> kernel: [drm] amdgpu: 4096M of GTT memory ready.
> Jan 26 10:35:20 msi1 kernel: [drm] GART: num cpu pages 65536, num gpu
> pages 65536 Jan 26 10:35:20 msi1 kernel: [drm] PCIE GART of 256M enabled
> (table at 0x000000F400300000).
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_pfp_2.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_me_2.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_ce_2.bin'
> Jan 26 10:35:20 msi1 kernel: [drm] Chained IB support enabled!
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_rlc.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_mec_2.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_mec2_2.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_sdma.bin'
> Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image
> 'amdgpu/polaris12_sdma1.bin'
> Jan 26 10:35:20 msi1 kernel: amdgpu: hwmgr_sw_init smu backed is
> polaris10_smu Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded
> firmware image 'amdgpu/polaris12_uvd.bin'
> Jan 26 10:35:20 msi1 kernel: [drm] Found UVD firmware Version: 1.130
> Family ID: 16 Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded
> firmware image 'amdgpu/polaris12_vce.bin'
> Jan 26 10:35:20 msi1 kernel: [drm] Found VCE firmware Version: 53.26 Bina=
ry
> ID: 3 Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware im=
age
> 'amdgpu/polaris12_k_smc.bin'
> Jan 26 10:35:20 msi1 kernel: [drm] Display Core initialized with v3.2.149=
!
> Jan 26 10:35:20 msi1 kernel: lkpi_iic0: <LinuxKPI I2C> on drmn0 Jan 26
> 10:35:20 msi1 kernel: iicbus0: <Philips I2C bus> on lkpi_iic0 Jan 26 10:3=
5:20
> msi1 kernel: iic0: <I2C generic I/O> on iicbus0 Jan 26 10:35:20 msi1 kern=
el:
> lkpi_iic1: <LinuxKPI I2C> on drmn0 Jan 26 10:35:20 msi1 kernel: iicbus1:
> <Philips I2C bus> on lkpi_iic1 Jan 26 10:35:20 msi1 kernel: iic1: <I2C ge=
neric
> I/O> on iicbus1 Jan 26 10:35:20 msi1 kernel: lkpi_iic2: <LinuxKPI I2C> on
> drmn0 Jan 26 10:35:20 msi1 kernel: iicbus2: <Philips I2C bus> on lkpi_iic=
2 Jan
> 26 10:35:20 msi1 kernel: iic2: <I2C generic I/O> on iicbus2 Jan 26 10:35:=
20
> msi1 kernel: lkpi_iic3: <LinuxKPI I2C> on drmn0 Jan 26 10:35:20 msi1 kern=
el:
> iicbus3: <Philips I2C bus> on lkpi_iic3 Jan 26 10:35:20 msi1 kernel: iic3=
: <I2C
> generic I/O> on iicbus3 Jan 26 10:35:20 msi1 kernel: [drm] UVD and UVD EN=
C
> initialized successfully.
> Jan 26 10:35:20 msi1 kernel: [drm] VCE initialized successfully.
> Jan 26 10:35:20 msi1 kernel: drmn0: SE 2, SH per SE 1, CU per SH 5,
> active_cu_number 10 Jan 26 10:35:20 msi1 kernel: [drm] fb mappable at
> 0x7E00830000 Jan 26 10:35:20 msi1 kernel: [drm] vram apper at
> 0x7E00000000 Jan 26 10:35:20 msi1 kernel: [drm] size 19906560 Jan 26
> 10:35:20 msi1 kernel: [drm] fb depth is 24
> Jan 26 10:35:20 msi1 kernel: [drm]    pitch is 13824
> Jan 26 10:35:20 msi1 kernel: VT: Replacing driver "efifb" with new "fb".
> Jan 26 10:35:20 msi1 kernel: start FB_INFO:
> Jan 26 10:35:20 msi1 kernel: type=3D11 height=3D1440 width=3D3440 depth=
=3D32 Jan
> 26 10:35:20 msi1 kernel: pbase=3D0x7e00830000 vbase=3D0xfffffe01ca830000
> Jan 26 10:35:20 msi1 kernel: name=3Ddrmn0 flags=3D0x0 stride=3D13824 bpp=
=3D32
> Jan 26 10:35:20 msi1 kernel: end FB_INFO Jan 26 10:35:20 msi1 kernel:
> vgapci0: child drmn0 requested pci_get_powerstate Jan 26 10:35:20 msi1
> kernel: drmn0: Using BACO for runtime pm Jan 26 10:35:20 msi1 kernel:
> sysctl_warn_reuse: can't re-use a leaf (hw.dri.debug)!
> Jan 26 10:35:20 msi1 kernel: lkpi_iic4: <LinuxKPI I2C> on drm1 Jan 26
> 10:35:20 msi1 kernel: iicbus4: <Philips I2C bus> on lkpi_iic4 Jan 26 10:3=
5:20
> msi1 kernel: iic4: <I2C generic I/O> on iicbus4 Jan 26 10:35:20 msi1 kern=
el:
> lkpi_iic5: <LinuxKPI I2C> on drm2 Jan 26 10:35:20 msi1 kernel: iicbus5:
> <Philips I2C bus> on lkpi_iic5 Jan 26 10:35:20 msi1 kernel: iic5: <I2C ge=
neric
> I/O> on iicbus5 Jan 26 10:35:20 msi1 kernel: lkpi_iic6: <LinuxKPI I2C> on=
 drm3
> Jan 26 10:35:20 msi1 kernel: iicbus6: <Philips I2C bus> on lkpi_iic6 Jan =
26
> 10:35:20 msi1 kernel: iic6: <I2C generic I/O> on iicbus6 Jan 26 10:35:20 =
msi1
> kernel: lkpi_iic7: <LinuxKPI I2C> on drm4 Jan 26 10:35:20 msi1 kernel: ii=
cbus7:
> <Philips I2C bus> on lkpi_iic7 Jan 26 10:35:20 msi1 kernel: iic7: <I2C ge=
neric
> I/O> on iicbus7 Jan 26 10:35:20 msi1 kernel: [drm] Initialized amdgpu 3.4=
2.0
> 20150101 for drmn0 on minor 0
>

Kernel driver looks like its loaded properly.

> And finally the contents of my /var/log/Xorg.0.log file:
>
> [    37.721]
> X.Org X Server 1.21.1.11
> X Protocol Version 11, Revision 0
> [    37.721] Current Operating System: FreeBSD unix 14.0-STABLE FreeBSD
> 14.0-STABLE #0 stable/14-n266191-8247b328ef0e: Thu Jan  4 06:38:16 UTC
> 2024
> root@releng1.nyi.freebsd.org:/usr/obj/usr/src/amd64.amd64/sys/GENERIC
> amd64
> [    37.721]
> [    37.721] Current version of pixman: 0.42.2
> [    37.722]  Before reporting problems, check http://wiki.x.org
>       to make sure that you have the latest version.
> [    37.722] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t setting,
>       (++) from command line, (!!) notice, (II) informational,
>       (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> [    37.722] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Fri Jan 26 1=
2:16:25 2024
> [    37.722] (=3D=3D) Using config directory: "/usr/local/etc/X11/xorg.co=
nf.d"
> [    37.722] (=3D=3D) No Layout section.  Using the first Screen section.
> [    37.722] (**) |-->Screen "Screen0" (0)
> [    37.722] (**) |   |-->Monitor "Monitor0"
> [    37.723] (**) |   |-->Device "Device0"
> [    37.723] (=3D=3D) Automatically adding devices
> [    37.723] (=3D=3D) Automatically enabling devices
> [    37.723] (=3D=3D) Automatically adding GPU devices
> [    37.723] (=3D=3D) Automatically binding GPU devices
> [    37.723] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
> [    37.725] (=3D=3D) FontPath set to:
>       /usr/local/share/fonts/misc/,
>       /usr/local/share/fonts/TTF/,
>       /usr/local/share/fonts/OTF/,
>       /usr/local/share/fonts/Type1/,
>       /usr/local/share/fonts/100dpi/,
>       /usr/local/share/fonts/75dpi/,
>       catalogue:/usr/local/etc/X11/fontpath.d
> [    37.725] (=3D=3D) ModulePath set to "/usr/local/lib/xorg/modules"
> [    37.725] (II) The server relies on udev to provide the list of input =
devices.
>       If no devices become available, reconfigure udev or disable
> AutoAddDevices.
> [    37.725] (II) Module ABI versions:
> [    37.725]  X.Org ANSI C Emulation: 0.4
> [    37.725]  X.Org Video Driver: 25.2
> [    37.725]  X.Org XInput driver : 24.4
> [    37.725]  X.Org Server Extension : 10.0
> [    37.727] (--) PCI:*(41@0:0:0) 1002:6981:1002:0b0d rev 16, Mem @
> 0x7e00000000/4294967296, 0x7f00000000/2097152,
> 0xfcc00000/262144, I/O @ 0x0000e000/256, BIOS @ 0x????????/65536
> [    37.727] (II) LoadModule: "glx"
> [    37.727] (II) Loading /usr/local/lib/xorg/modules/extensions/libglx.s=
o
> [    37.730] (II) Module glx: vendor=3D"X.Org Foundation"
> [    37.730]  compiled for 1.21.1.11, module version =3D 1.0.0
> [    37.730]  ABI class: X.Org Server Extension, version 10.0
> [    37.730] (II) LoadModule: "amdgpu"
> [    37.730] (II) Loading /usr/local/lib/xorg/modules/drivers/amdgpu_drv.=
so
> [    37.732] (II) Module amdgpu: vendor=3D"X.Org Foundation"
> [    37.732]  compiled for 1.21.1.10, module version =3D 22.0.0
> [    37.732]  Module class: X.Org Video Driver
> [    37.732]  ABI class: X.Org Video Driver, version 25.2
> [    37.732] (II) AMDGPU: Driver for AMD Radeon:
>       All GPUs supported by the amdgpu kernel driver
> [    37.732] (--) Using syscons driver with X support (version 2.0)
> [    37.732] (--) using VT number 9
>
> [    37.732] (II) AMDGPU(0): [KMS] Kernel modesetting enabled.
> [    37.732] (EE) AMDGPU(0): [drm] Failed to open DRM device for
> pci:0000:29:00.0: No such file or directory

I don't really have much experience with freebsd, but it doesn't seem to be=
 able to open the kernel driver.  Perhaps X starts before the kernel driver=
 has finished loading?  Can you try and load the kernel driver and then sta=
rt X?

Alex

> [    37.732] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card
> support
> [    37.732] (EE) Screen 0 deleted because of no matching config section.
> [    37.732] (II) UnloadModule: "amdgpu"
> [    37.732] (EE) Device(s) detected, but none match those in the config =
file.
> [    37.732] (EE)
> Fatal server error:
> [    37.732] (EE) no screens found(EE)
> [    37.732] (EE)
> Please consult the The X.Org Foundation support
>        at http://wiki.x.org
>  for help.
> [    37.732] (EE) Please also check the log file at "/var/log/Xorg.0.log"=
 for
> additional information.
> [    37.732] (EE)
> [    37.732] (EE) Server terminated with error (1). Closing log file.
>
> I have nothing in my /etc/X11 directory, nor anything in my
> /usr/local/etc/X11/xorg.conf.d directory.  Can anyone help explain what I=
 am
> doing wrong, or what I need to do to get a working x11 session on my 3440=
 x
> 1440 resolution monitor?

