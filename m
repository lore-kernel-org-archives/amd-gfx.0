Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80EC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 09:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B539210E029;
	Mon, 17 Mar 2025 09:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCWn288P";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D3810E029
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 09:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwOGslaF/I0+/UTm9nex/hf87IJKlLkmALTCar8XvuMy2d+ma+9HiYTEl02z1LRpvAqEAc79C2RjgYUvkNnrchO9gO1GeQuelm0cN8BfqokVFk4yo4cJ9z6BJi7MRXs6jBdFigJaRL42QjIFvRnaTBWaF6ppCccRWB+vtQpyelj2JIviKmoJjqNY5OFViGc+tl0ThfzvCRX9FtOOFlkvebHTVP09QzhYzjGqvxkb8Jls/vcjcC1IBnaWfOjsTR1Wn73Qzf7njBX2nuFyoxw73ufDHgULi/UxVlyJbNRpLko7nHNnOeXV+UPcZdvw49Bq6slcoazl/rg4Tt95Lhg7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtco3NGg0J4SZ153F6f5I0o+TMPTqI24dys75wum+0I=;
 b=nmwUIEUTXxR38b657SdXj4VDyH4GFwG8THknveWjymuR1Qth4tQgjTyTF6DSFTqFAXEafMSCluMdh0UxU3a2ge3rhMEbFIH+DLNLbSnMSFNBkY7N05bZlnRbdHAu/ZqNx4qEiL51Qkyn1L2zZw3BFhC0r1n9geE/Fy9dBhgVLU05l/L/t6E7KB7uCN+b/Mw3lecPOn3ysvt/Q82RDGzGr9JofIJzR1pPK05PAK2LS6HVhFoWq3sTFD8YyFABOX+KnGb2Ehwnk4dlFU9s+ob8KMlPPLVPf9Kr5dwO3ReZZ4LQPm1u0M8qLM6JdAnjCWSHssuqGUdxDJbdo5xWmEzzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtco3NGg0J4SZ153F6f5I0o+TMPTqI24dys75wum+0I=;
 b=wCWn288PIH915pig6R86V/6dkEMNho50gaolKriyFHxrmT2Et0MEhDAR4s40mykFjTzQ5Rib5Wl0s7qJTqA91B3q2VVt97WsA3TJeZnjMU7o4TA4igwsJI+IHYF44+jmbEg6Fd2SxYA6Bae+Y6ryJz28kthzE+yVg7/56Vp9GhI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:06:44 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:06:44 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Topic: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Index: AQHblCYdtlcReGyPeUiPrTWI0cRMQLN3DPaQ
Date: Mon, 17 Mar 2025 09:06:44 +0000
Message-ID: <DS7PR12MB6005F4F38F75F94DC2262703FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-4-alexander.deucher@amd.com>
In-Reply-To: <20250313144136.1117072-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b0aabef7-fb9a-4c1d-bafc-9826b0432971;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T08:57:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV3PR12MB9165:EE_
x-ms-office365-filtering-correlation-id: 3eeefd37-2428-47d8-9063-08dd65330a31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zvWWk7ADOn5AcxoNSp2HbJ7phfjXG2k21U6w3tLJu4vs42pPxRZfJ6lQ7JAp?=
 =?us-ascii?Q?kYiSkdeWzCR7tiurPb6KdSGfChk+8F2Y9aL6oaMASgvCsQtwZy93s/CYSCU4?=
 =?us-ascii?Q?PVkDqYPyhAtv+Q+MESrLGE/ZltXQIg+s+qh3nXrc5flXGQrzb7DUlfP7J4vl?=
 =?us-ascii?Q?EUmE2quCzsk4mapnDu6hzxWhN8Owg4E1LQSY8oDdZX/v+AGH36n7vHe9s+VX?=
 =?us-ascii?Q?jj1sfhQa3pZIuWoSH9puXXPxfkNIOQVuVpr2vkl24qngWjRL2PAQpUIYySf3?=
 =?us-ascii?Q?/+HFoglZh32b2TLNPb/61SBagreUNEcO4a8bQ8lKucOJseeN1eHlPia42+NM?=
 =?us-ascii?Q?Seg3NMmHnGPRrJSEYZ6gj7WugVQLs9HLRBjBlhY2wu+hZhpm9PUdKBHcpgs1?=
 =?us-ascii?Q?COVAb3dvHYVzoXuA7dTDJ144ipYef3uuzqxUKjCYY0J4IMhU2Ia17GLHlfEo?=
 =?us-ascii?Q?X/x2UkFhHs4cNaptZCCjFQUrgNlKNLXA6x1Ux8jXen0GOl2MWZyVDd0Hcw+S?=
 =?us-ascii?Q?7ZrC62mWc3pOCcLQzvdqg2wgEjmBkROKGzSvkZkE+776jranQwWqcdCOquEo?=
 =?us-ascii?Q?ojsQBv+FNpa7pmzHHQMlBiVteEv99I82eP1mJyJ2onmvOXQwuH9WlfnrBduP?=
 =?us-ascii?Q?SFQjsrHKfJg39Uk4Uv0/rpiOlqvCdMneeITp4otGTK5Mcgzwh3YL5Ip6yTQF?=
 =?us-ascii?Q?o9TnQA+mBxvjUUATx79kmRNkPLzTw1fFR135HL5dcGQDDrrjoK7Od/l01wBU?=
 =?us-ascii?Q?icSbWCcSZaE0LkUN0i8epK7/VCgmDfxq349kOkf4/kugXFfyzzGOouNUqj10?=
 =?us-ascii?Q?8h2WK9Jhn380Y+5sRY09H1q4oncBoMry7Fl9DrhJxKtqbFFEI9Ci2mb88Idg?=
 =?us-ascii?Q?yKcm4lR32VzWgP5h2VugnhlRQWLTrbhk7TPSl+l8oWZV4GcTfYalH1o8DpVw?=
 =?us-ascii?Q?qWgBDZZnDVB3thimeSCsqTWj1Yh9sa6HpUqEVpYn8LpW9mS0mnIB/0Fld8yM?=
 =?us-ascii?Q?VaIowe234AgP2pe8dMJNweogeZC+Y7NkPVGyHo54MW2bhWzmoTmNBEpHkOgS?=
 =?us-ascii?Q?dCxbEtMvJNR6fMKTBpBUbvByhuzPLkxLYLNa8jQ6VFU6x0pGJVqhauDyYVNK?=
 =?us-ascii?Q?68Z90U/DXFORX9DwYelhqbBL+nf0wBn0w164cm6wACq7dLKJPFV7ig0YQA7K?=
 =?us-ascii?Q?wp/8d5M8XG0qdck3cXqFFWfJct+ylDnUB03peKjIqSIL6D8mUy9xwuVGneSN?=
 =?us-ascii?Q?w90b5QXbSe/b2x7gDb+gpLmUqJZ/S7gHpUiH5tpPgZup6jSL2g4lbsAdKx9w?=
 =?us-ascii?Q?G0dsruTaknTDK4CsUEMOU76W4ANLw+DMdEdk5CkJsdmGbcIXHvwgLfYc1o0B?=
 =?us-ascii?Q?K0GiaDbx7EFap40HCjbeea4x6dxBfelKTUV1VU1N8ZMyJfamdLKhqnqZ2CvS?=
 =?us-ascii?Q?L82aNSiV1piaJVgIyib6bWv7W3pWSmwM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fme0aaTKvJa5q4upSf0XYxhysTk5AQBAJPyr7kdjU4NEU/hQSBuYhmS0FYZH?=
 =?us-ascii?Q?ZMeEet0I6H+/DhUoMjth+5qRLnSsJ13fNjRA+cgaKrOX1bpAcNWWpD15E70i?=
 =?us-ascii?Q?NAi+bmlqsdKEPvF45IYFqf04cJvC3b8Tcc5RWnqKqyUEJNXWCoZvhBxaWoyU?=
 =?us-ascii?Q?63aHbsvSW0fUvoWUNn7lWW1aUJq6efLUHdYi/4TT6oUmoH6f3hfiQUF7qsWx?=
 =?us-ascii?Q?T7OjGQGiJFBlcmE8P1Z2N2fqlPIuQth/Rb/LbnbvEkDUgBNBP4o+TCSVXcCz?=
 =?us-ascii?Q?Nemcc55r96hDCmftejEObBkq7X1Sg5ESRevEBCkTzn3CIUMS8hNyh5pcT0w2?=
 =?us-ascii?Q?Asblpa9CpZlACVjcC3+Es9SuptXGkVU/z12OdO1NDoqCli8c8iKRizXjr0lZ?=
 =?us-ascii?Q?wRbSskSW6uPUFXJZoBi6tYaMy8oYpG/aQxvRkYirZVPe0dc5MaBouUWvs+2S?=
 =?us-ascii?Q?NBH9+ADsvm4+YOKte32d6NnSPb16h08Y4PMHDVU3/2pdhZiOGEcbVraC8Jrm?=
 =?us-ascii?Q?Wd5HhOYZYulpuAEW3OzgNfXhtS3ER+uJJ1graP1xxRow2qGorB8/iBYG8P3B?=
 =?us-ascii?Q?r63uSoLn+lBvqVHqQkjCBkBg+i3aRbCPo0kkyaDOIhHcQ+W7wUXpemLTY8eN?=
 =?us-ascii?Q?bfM6AwrENt2UCkFui0bArULUm6zha0hCCicP/PfC1jLcLXh77oLMrG9WHnbu?=
 =?us-ascii?Q?IycyT5W3GFGzVxSgityOHqLzjoJgeFYPyOx/0lZ9t0++nxNeGNmxwQhJ11uJ?=
 =?us-ascii?Q?2dZQV6hQ41QsWi+bZ77Hm1DAxSCmprzXzSsyrxBjDHd9opPeyrBa4ow+PJS+?=
 =?us-ascii?Q?4yhK9SiEHzvtbTOK/k7ZsWLnMLRaG1DVW7SMPP8OlOCnFQng8XFRYEv5txX5?=
 =?us-ascii?Q?EkS3jj2nt71vf1kB8i7MwfbmNoUghR/eDwVePUNTx+HGlYhnQXMRs4ybBegR?=
 =?us-ascii?Q?Y9DuC8liaJHpoSbL9zQPEJ0Mmjz3rhiypPTkIkXASUm/cnVD858JWLR4EZwa?=
 =?us-ascii?Q?iGvj7H9iso7ztlktHKbNeHBQ5LAwC/GPfNxHvN6WFkG3FcWsnW9HsDZF7b3/?=
 =?us-ascii?Q?GNKbgUmbPiumXzkaF4m7F2rsZzTLuoDIKBvhNbskV6hMKFyYQPcRqvF1YISy?=
 =?us-ascii?Q?Xylu79z3a5Zq06qi9rpjp2PteXFDvSrGBBCGEFNry0W8/2btyeDL0NAnYuUC?=
 =?us-ascii?Q?AO98tCZRKCFVUmFHxtu5cdBIRbEf47ot2phwPwk1hlQflVJX47CiCuO5DL3F?=
 =?us-ascii?Q?Ghk7byGgJAbuJrAiVFgUlKWePkLI6gBkyXtXqQna4B2G2ZE/80l9Vv/q3jBJ?=
 =?us-ascii?Q?AlPmmIXGERFa+wTnf6xR61DS5JaiZYnsHwm7DhGrexalYYh0SNYfGr5OAC7W?=
 =?us-ascii?Q?wba3aiMagHwgOzg+FijNiPwh1ZEwssZTn1q6xEWKIPykz04tCt4R7mb6BV7C?=
 =?us-ascii?Q?ktkie3FuQBzJQykfPS2jz14oXy3cYn/N9/cOR7gpHTaBREXXUpvHo//WsMGB?=
 =?us-ascii?Q?14zhZMq6IoYQ+dIOLv6KKHeJzycGq4fs7msQajNFaDzL1LXVaAwEERrQeWse?=
 =?us-ascii?Q?8g4Z3Yea3iBEWdrwGbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eeefd37-2428-47d8-9063-08dd65330a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 09:06:44.4984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cA6HU1TvBqlpuAxAcA9JH2m5f1Nv9azOoQWbkNKu7ltJSKL9IhmRMI+b06m9BUkN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

When disabling the gfx kernel queue, then the related ring function callbac=
k should be unassigned, and the clean shader callback should also not be fu=
rther invoked. To avoid the clean shader resource allocated, we may need to=
 drop the shader clean initialized at *_ sw_init() when disable gfx kernel =
queue.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 10:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_k=
q
>
> Add proper checks for disable_kq functionality in gfx helper functions.  =
Add special
> logic for families that require the clear state setup.
>
> v2: use ring count as per Felix suggestion
> v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 984e6ff6e4632..a08243dd0798e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct
> amdgpu_device *adev)
>       }
>
>       /* update the number of active graphics rings */
> -     adev->gfx.num_gfx_rings =3D
> -             bitmap_weight(adev->gfx.me.queue_bitmap,
> AMDGPU_MAX_GFX_QUEUES);
> +     if (adev->gfx.num_gfx_rings)
> +             adev->gfx.num_gfx_rings =3D
> +                     bitmap_weight(adev->gfx.me.queue_bitmap,
> AMDGPU_MAX_GFX_QUEUES);
>  }
>
>  static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev, @@ -1544,6
> +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device
> *dev,
>       if (adev->in_suspend && !adev->in_runpm)
>               return -EPERM;
>
> +     if (adev->gfx.disable_kq)
> +             return -ENOTSUPP;
> +
>       ret =3D kstrtol(buf, 0, &value);
>
>       if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddf4533614bac..8fa68a4ac34f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>
>       atomic_t                        total_submission_cnt;
>       struct delayed_work             idle_work;
> +
> +     bool                            disable_kq;
>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> --
> 2.48.1

