Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C69BC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FAD10E012;
	Fri, 18 Apr 2025 14:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnvCjlci";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B6F10E012
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0s7SIxXlkXN5dY3+v+NtOkRHi0f6Lc6YFZ1TVkt4l3g5AzlMMlEqCgmHDgiMXR37MfROGtbY1KyDa7pVL1XrZZHJ8LsElEtR7tCHZr4y0TdgcWD+nP58YgcPXDS7kGLK39rR+ZbznAxQBs1ktESywwYqu2E1ZkEEnEgdMXJLv0ITmOnZc/1XLqq9+6gAQBgtLn0q7HbsudljtQj22kR3N1WHZgTK9woSrJLmwfqUPBnkxhTg2cIBLQg4qE+CuiMuDnKsjywhOVPumZv0/159u7CKlhj8wMA6oMYWBaOwhkLaGVvJHTeMAA5Io5XQdUH/FaMfihib8VgkIgbSv4WCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvjdEkTZDDU1ikMsdV5bFwOX0qi9Hzgm57vrOnEm3lA=;
 b=LzATkdgFOTJ4dMI3zEGeF9Edk7VDrirrLBy/LzrfVUqY2u9/FudOiHyfLDpDJ5GUIAIUdkgDgeFrs7CQZrxmEd54w7+Knt35KLykHUuzgAfz7mM/mdllFrAfC0gAjG/ow6QGLIAIWoGqHJ3jzRnmIsNDPyNh7vLt4kswVJzNAf/Y/8HLK+ysi9RggryVDF13g2PAaqE8Z9pwUSkVQukEekTH96RAvSDgNxfukM0WQ4kn3ywvbJuO85+MhvqaXze6v9AyI1tJywfTsauQS1sKme9ho1TDJMW7RW9lpheRSHlQzpMbTrrE6YiIbamsTeFnDmDOxFmIPGDTLwIJHxlEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvjdEkTZDDU1ikMsdV5bFwOX0qi9Hzgm57vrOnEm3lA=;
 b=vnvCjlcivZK7EwCHbBHAvaw9JOVqPPYT0vH5vPem4E85iqXMZfBY+Kvc53qqtIx72zqOJ8KDcf3YYieZ/AuAQYd3HyHGN2dZV7UbNCXSz3PeOjtsGVd6gNGlLDJjqw1OfKHRUYfyP3Y24p6rp+kP8Z6hNQBj1MGOxkRKsS4f4p4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.26; Fri, 18 Apr 2025 14:13:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 14:13:34 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/7] drm/amdgpu/userq: move waiting for last fence before
 umap
Thread-Topic: [PATCH 5/7] drm/amdgpu/userq: move waiting for last fence before
 umap
Thread-Index: AQHbrx3fEuYySHhAqkm7tnYJcHGTFbOpeHoQ
Date: Fri, 18 Apr 2025 14:13:34 +0000
Message-ID: <DS7PR12MB6005EB484267F4803FAC3F4DFBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-5-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=60514bdd-f81f-4b1e-bda2-12251065180b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T14:08:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8925:EE_
x-ms-office365-filtering-correlation-id: ece7fa43-6daf-45c0-d4f7-08dd7e8334cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jicyeHwJl+jhMt6D0ivgsOnjV3b01aoIoP0hf6fP36yAQJz/MZqBnfBB2yo7?=
 =?us-ascii?Q?EyaTvplIBp4bH8L/TdMYdIQfP3cCCe7xfLDG5DODPHG7nnxQcnUBc0JgxS1n?=
 =?us-ascii?Q?EYx5ot+9qNGXaLsp68iNs3OXDUCaU29dp3prLM0DfuDKDAmwNApZYMXQ7sLk?=
 =?us-ascii?Q?ngpmO//zgYPSHDMJTth92Cq1xrD1CLZDKCYCIP1m2T4Pl7z4dTDsnaS6/fLc?=
 =?us-ascii?Q?cmKWXJLeNsLP5ZhCP6qiqCpO/p3uOfKZ8nYF0uWzCXIpblCKQlY3hmRRrfkB?=
 =?us-ascii?Q?5F5IwHGylWLCd8rwubU3UC0NsEG8LmSfCRMxky2+JQFWS6W5lVR3BkCsGbpG?=
 =?us-ascii?Q?i2069UMOQeUzKxSr68NwnNt3D9WHzVtMDn4IDf84xvAK2+ZiJgYVTVf1aq7w?=
 =?us-ascii?Q?M7dbfH2+jWmcvQPy4Nmm05N6+czpAcblFN3tkL9lNQKc83asrK8g8GAtuewx?=
 =?us-ascii?Q?SITm+1K/kXIj2JRgvYBOF8/gigcaS4MLJPt4JXbxzVFwXuGVmUcTvR5cbTSl?=
 =?us-ascii?Q?pVdbndcbX/WC8pIk45HX39syP7cDGYmRlYayy5EKHdWHs2ob2nWVzhwvt1zB?=
 =?us-ascii?Q?NjoQRSDJ20b9xen7YR4/+rRp8NhIKUCGDknjYDaOW1K0zNtQve7hD9ScmZAi?=
 =?us-ascii?Q?u7WCsWuXqh+xaaJ40bmwgSjgOT5kITntZOG/P+00iftLl5EEJUQmlvQBgea+?=
 =?us-ascii?Q?HUr51mY4ZR+2Krb5EQi2aG+AWl2uwOCLlJUuoktyOmuoCPhaGFPEPdrS2WEL?=
 =?us-ascii?Q?S4wXQ8iKJqcRnddXjB7cCmgPWIxa9OxHb7mdKRZfPG4Gr7wjvvFtPJP9fjIN?=
 =?us-ascii?Q?G2SZqhFjybpgShdjcelGpd8lB2KyOLkhcP8yaX9+Hd59hR/COVweOzTs6w3r?=
 =?us-ascii?Q?NYzzyVZ3s1belmKRrHnHKOuOM2DhFBlysYJQFPMXO8vjbbYDjtIZxkB8GEhl?=
 =?us-ascii?Q?h6jkc4mjpGM/JzB7q/lHWdL77zl7KPevT+5QrnmEsl4ih1NLaWeNnCqRaHjo?=
 =?us-ascii?Q?+skKicG/1WAXUl2/ykuyBL6UWrU5fIv6QpgquqLAkL3rwbZxWsbA1ErvHdKr?=
 =?us-ascii?Q?Pc6Z9WVe9SMgrADouEsDyHE9SX+Ab5Eh2zxUJf5qPcrfFLK6c74rEJY1ZiCU?=
 =?us-ascii?Q?30KzeK7xSBnK1aO1ewCc/ZzERfed8OmuNOkY+ybBj63BveNVAeLQSrkKu46M?=
 =?us-ascii?Q?DQJadyxtRyr/qEHvDvgC/5hNLsLw6H2npPWqN/1CPcSGNTcDnPATzSN0U109?=
 =?us-ascii?Q?5DhZB5hFeaIzlgZKaNw8Yb3Zb8sKah9uZv9p7MBNXD6TD/39o0jlQSqWuVZI?=
 =?us-ascii?Q?ZAynnL31h54N36uzkgYwrI+o+WAqLGCWQfI4H7ydlvS/sgpcAq+5cDKl1lwZ?=
 =?us-ascii?Q?PYiEBZK3WfOLOApdGAKBU46h8xM1U4a96KsGDPR8rTyU5XA+N/74gWo374Ts?=
 =?us-ascii?Q?1RAL8izWDDN7Aqvx78p0Qt+SkHLbDgPxi/CUzHO9u3pnU7Ozmu836Nn1CUcA?=
 =?us-ascii?Q?NvbJzv9clZ8pjws=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YVrVOvBmBBCebGs5zWT39n1uPXYdfAgVhEKMfxfUKc1DBa1ApFI4KI1Si2JX?=
 =?us-ascii?Q?eXdq1gyHVyCaA3/wMRh72fUVFmr+S4WCpC+l7Yc+NOOR9/CDazzEYKPB+4q9?=
 =?us-ascii?Q?VtLs9HY2uTs0fPnMbwzMS8t7dDu2+/2r+tN3mmc9lhvGN9wAW8E5yKGZ4MIP?=
 =?us-ascii?Q?pzPnvCDRm7m6jF01viuE7ljowD8dpRk0TkGYfuQIlJnMi53g836lrAmZtDTn?=
 =?us-ascii?Q?JW65HVZSMHcA4IU7jbV9DMBiVCOmSlO1GEl43AtpJ3rSuzbhLKkz+tl/yEXG?=
 =?us-ascii?Q?HcYV6TfHT87n07prcA0ftXsYxGBrElyIyEffxNOu6eqLx5NMmGm69PAsPOsM?=
 =?us-ascii?Q?Y6f2mKMdCyO4xWJbCN8FjPR+AfGJLJ0lGBFyeRTfNgLJHs6ejspuBePwJcjR?=
 =?us-ascii?Q?n4mafv6RkyAgHmgEUQl5u9Jhfx2ZSM4LL2lGugrhFdu82Wia/uYexg0Zk11C?=
 =?us-ascii?Q?UvDtkCYEhuNBmJ3TP5EdSxFPJr0BRF8jwri6zT01P7wyoF28exG24IQr9kx+?=
 =?us-ascii?Q?EewJQNfZJIIl39n7FK2EtDFwfLDvBj34XVgYNMzCK1IW9mdP5w1rZjrT1HFY?=
 =?us-ascii?Q?uUwYyjNRi4ZMdDVmxRFhvTYgvQr0ySqUN2DqxdSJRMyg/I9Rly1v2QP8OVUC?=
 =?us-ascii?Q?O1+/xVgG3nsSZmG4J6H6jygoNTShgnVgRP0jeQw6+xIY4EvzD3QRAk+lpa8v?=
 =?us-ascii?Q?qigQGI45Fkm+xg2EQwRZdrQGDfVqve+RA1BY/oo58dP2UP8RafkSl1fNn13F?=
 =?us-ascii?Q?fkqnHUCyN7UVY06ztmEu1Txa/ejeBCM020QDa2taxbs/yu9BUevclH5avGgr?=
 =?us-ascii?Q?t++hU8j1JL31nnbZ7ELdmdCVkxcsoLno3BTlu9ZOfbCRRQhZHBg2sF+Vb8j8?=
 =?us-ascii?Q?SSkwGa13FuaFL+EOe8pdwJMrGvE/aFdhLCsuBP+H17Zc+zcBVVql44KVMvJz?=
 =?us-ascii?Q?vOD/7cwAcvBIreHY2imgpZEJDLFXjdhtN35dGux4xxJxectJ7+DmB/Lbc5qe?=
 =?us-ascii?Q?5WFv/PELsX2C7mnnkXP/PfFiS8kpgiAgwvYeHkSt4Za2lrnIV/aBAt4W9miL?=
 =?us-ascii?Q?yy0FmZh3teaitFr3yfHQqEO5NZSr2C+5VfF96KuiaA9gItzPe6rMzmJtOZ28?=
 =?us-ascii?Q?DCU43YuUKXrwCC5XYDWGd8hE1YaJzENibAKUMCaJMbEcVVoQRgSA6GM6b66m?=
 =?us-ascii?Q?ZPk3puY1rD9NNLb+LUq6Dymr/wOCOU8jCiFN7QiUeZladROZPEhZE/leP3v9?=
 =?us-ascii?Q?rJtTg7gdjtpnggmmnL/C0VwLxB/j537PeBcuC4Wt6lV65X83js2+VONjrBr9?=
 =?us-ascii?Q?rt5BZvrmX540qLp8qS9Mj3wgKc1t9LUFP32LV/c++HLed0dBB5ptze4y3GH+?=
 =?us-ascii?Q?jlI5XbnynJ4nc6VrJ7NgGGqOxfGWqslhc4aYUo+yeNvrvIJd5d5l/LGP6mHd?=
 =?us-ascii?Q?wJkpAqS2yJ5uP8/0vRRejN+qUNn3e4ffM/4Cp1HToNLLOeFF4XzJKfENb6eN?=
 =?us-ascii?Q?ccAETQFh28YCVloJyFOfsy7ErRDNfBWa6nKxPSlrkKRpo5WhgRkYUMHim3kY?=
 =?us-ascii?Q?C/hCmI4eqhnvoiMs6Vs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece7fa43-6daf-45c0-d4f7-08dd7e8334cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 14:13:34.8151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ff222d3taydRc5bTgWKRoyKDcZPgY89Ge//pqz80zB1qokBvBikl7huj/+TUcwk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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

> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 5/7] drm/amdgpu/userq: move waiting for last fence before=
 umap
>
> Need to wait for the last fence before unmapping.  This also fixes a memo=
ry leak
> in amdgpu_userqueue_cleanup() when the fence isn't signalled.
>
> Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 763532de5588d..a2b92b549c0f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -84,22 +84,27 @@ amdgpu_userqueue_map_helper(struct
> amdgpu_userq_mgr *uq_mgr,  }
>
>  static void
> -amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> -                      struct amdgpu_usermode_queue *queue,
> -                      int queue_id)
> +amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_usermode_queue *queue)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
> -     const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[que=
ue-
> >queue_type];
>       struct dma_fence *f =3D queue->last_fence;
>       int ret;
>
>       if (f && !dma_fence_is_signaled(f)) {
>               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(10=
0));
> -             if (ret <=3D 0) {
> -                     DRM_ERROR("Timed out waiting for fence f=3D%p\n", f=
);
> -                     return;
> -             }
> +             if (ret <=3D 0)
> +                     dev_err(adev->dev, "Timed out waiting for fence f=
=3D%p\n", f);
>       }
> +}
> +
Maybe move the amdgpu_userqueue_wait_for_last_fence() to amdgpu_userqueue_w=
ait_for_signal() to wait for each user queue fence signal, which can simpli=
fy the amdgpu_userqueue_wait_for_signal() as well.

Anway the patch Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> +static void
> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> +                      struct amdgpu_usermode_queue *queue,
> +                      int queue_id)
> +{
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     const struct amdgpu_userq_funcs *uq_funcs =3D
> +adev->userq_funcs[queue->queue_type];
>
>       uq_funcs->mqd_destroy(uq_mgr, queue);
>       queue->fence_drv->fence_drv_xa_ptr =3D NULL; @@ -305,6 +310,7 @@
> amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>               mutex_unlock(&uq_mgr->userq_mutex);
>               return -EINVAL;
>       }
> +     amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
>       r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
>       amdgpu_bo_unpin(queue->db_obj.obj);
>       amdgpu_bo_unref(&queue->db_obj.obj);
> @@ -779,6 +785,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> *userq_mgr)
>
>       mutex_lock(&userq_mgr->userq_mutex);
>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +             amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
>               amdgpu_userqueue_unmap_helper(userq_mgr, queue);
>               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
>       }
> --
> 2.49.0

