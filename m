Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572B606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZqTqCs9+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F0E10E762;
	Wed,  4 Nov 2026 07:45:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49EF10E762
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 07:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2b76Tu45N0XMewhTwCNPpMzGNqlRhOPLZvC6CJY37vME2OkLqlyamJgycVf+CFdc2HC2nMl+ozEJ2EEoPkiuM0Bz6aqSWxLmyjUktfc1JTyGrHWZQB293hCrMOEPoo6lnchuifST1OKnbmVIhh4Zw6WsQYBXFdN4GkjzPaigH8CwgH9P6y8ZTmQzclQT5fHdmLz8nZq259u3nNLLTm4WsUBxs0CsH6Ght2t+UoiFdF3J5hH6MqMYaqrNEbDSOW8fkFKO+BAv+ZSAQFASW0z5jPSO3NLP1Bb2xF4apq7Vn7tUlocWdJKSsfclZkBGIUGZQXkcRX1onCptSw4uIdgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ayXNwit8JqIaXroVFFBQc6sYG8PYYfK9tEnq6KYrDo=;
 b=TBCdDajYF+kezoD8z1KCPmKMVS6A0ZOZjYM7Ko+6LZpax4Fy83LXAl3216fSdqEWNDIU9l5CYt/l06ReRnjIQfX7ds4Q2K/VMeuYBDRSxI1ctSIRGBtHKOYqJVPnFXP+9u/htVL6G33U+bcQtj3w191iN7qu9IL8pdCTroDa7QMVggROK0a6NwbaeM2uKeKXnlycb8g3basy6sN73LWSC9sj0WEuo3o0WHgDOXdzf1R/yrUjAfwaXEjA6DewHpaA1VVaxpihU1ABJNI+fOc1UIA456Dx7WA8utPTlJ9pMxn+v1NK7Tg8khFZw6SqY2D109yfcf20cvjqj047PUqK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ayXNwit8JqIaXroVFFBQc6sYG8PYYfK9tEnq6KYrDo=;
 b=ZqTqCs9+6AHNthikb9Kq0l5yB0Ty9PiVwQSb5GglESWLVV75kN4E4gB9KfoDYXMep+7FbN9prlbhnePxnz9ef/WhGMy5Ed5yo+UW3AThRI9rmKlPGE1IPT8Fuhl1BAyTfmB6keudaEKa9QJJEhjtksqZXGb/ZY9cpPh1o5K+7as=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB999271.namprd12.prod.outlook.com (2603:10b6:510:409::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 07:45:49 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 07:45:48 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu: program the SH_MEM registers of the SPM
 VMID
Thread-Topic: [PATCH 1/6] drm/amdgpu: program the SH_MEM registers of the SPM
 VMID
Thread-Index: AQHdaD963Zb+8Nhx3kW7MyDLW6zxrLcdkGlg
Date: Wed, 4 Nov 2026 07:45:48 +0000
Message-ID: <DM4PR12MB51524CCC41D990B40470EA1FE3682@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T07:45:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB999271:EE_
x-ms-office365-filtering-correlation-id: b815aaf1-4991-4722-e133-08df3a47a44d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003;
x-microsoft-antispam-message-info: Q1Yk+jilhnZyFqS9HPtqz2S0qqGHtV6WrhGPt+UAVK/UWk8ImVWkX8AsWP0pFg/Kjkzo8jeNG0U0Ovu6t7QVf4GM28fcqpJYy3ZwPFUyOb/XbTXleVv3VaKSUCZt7vbJd1hgeCZpcfu9UfS53twzuhrLTZux39v6HVL6P+yX+OJB6MNMoUU6PN7TjjnQKTk3L5IYOKkT5vHMK8UHj1T7x2YnfwuOzGCanyz7SFmyEQvJykiXq0lYBLrOhXrUa2L7bL0jYYere+0zuY3N0HsLPFfV+NAsk6FiczuCVcdWc/QqX6Fps2lcA/eMJlkezHx5fFn2VosRn38Xe5t1k7xmtpGzafPrG6qaDwobswCfH+45OS/NIsOCh4TDArUhTfbffN6HwHb3h/rjREo7HZzhh8JjXhcwvgEo055QV1c6C0hZAlVvinkEwbRDVAFvXoIhB24JMv/RxmWbGq/BKwYY1Ph9KMos5WZuyZCa2dW2FqrFGk1+DftPvyQr+MpYubWsYnov7gxnD/r5w4ZdRn2Cu5ZJhxrqVBy68L6kegp8GikBMJ5q1VbPkzSd5pIVupX9a5w8Hu5nRRLt3W7X4h2I0vVCvSU3YGosyCoHbmBGbq0866ORRq7BGbmq1Us8JV9oy0J5djMFHC360gvMzV1yDqKUGUg8ZNXtfWo1NjczSp1rn9IAWCZ2rhVNf5kYssoWpfX6C1AqWvQSvC/uKhQUmXPf9jGgyy8TJt0IyucEW1g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRvz9vEvohhASbbIs0IA5oMVn9lUDPWBEg1tbhATR2hn6YxRBL1tEJ4OZKZs?=
 =?us-ascii?Q?e1UTY2sTHNUv5HoJd7T8V6f7di7dBBPS/0dKtgEodL5bsEpefr2u2VnmSTp1?=
 =?us-ascii?Q?qrtg6IHlHYw+vg+ueIeStA3qZNrsLNRQo+pYs9ufXpwUVh9QQlnaRDhHbQXo?=
 =?us-ascii?Q?woujkVPxpm7Fu9u/i/DXgDyJYTVHLGJcTHvBaEvJKLbhQ9G6x4aYtpZEX0qj?=
 =?us-ascii?Q?8HIaOqaeJnChY5IAInWqqq/wlPXm5rLSMCw9JYgkBAwexcfFbZ8ExSf6vhAV?=
 =?us-ascii?Q?91cSZe8t9T1+5kxDLykY+szGL/Pdwt7URS3SRRwizd4Q5pAv9NxYgvVS59+L?=
 =?us-ascii?Q?OoXNUN67tPo9sIdMdbwZgY5Iang6TAzMzJ+Jz18VSSV/KCz5NNEX5RMihjjo?=
 =?us-ascii?Q?9cqlpg1TD2qsAip3MjiG7chXFEyGkGxI73+XgHcBDuuh0XBXLuSkk5DK/JrQ?=
 =?us-ascii?Q?sqjfJUrofcckvlJLsRewDWNztjwrxSsvJPjMGWjaTmt5ifi8uBo7IgXrLvCn?=
 =?us-ascii?Q?FS8LkPjuv0JKjbjZAk5H2lcNmP3SPYKmlzWrioaccU+EZiPELfM/2BdBZIQ5?=
 =?us-ascii?Q?5dTD9g205T4HaqoY8QlgbPQktleDVjfUzF6bT9JI/R/pjZKLz4h8wlfR//TG?=
 =?us-ascii?Q?WaWchkD6P+RtKfnEyT8TtTi7w+dWn9/2URyoTNK9thGWiUVaiwqf4up3z73i?=
 =?us-ascii?Q?2nHiRdPclEEq9+2nzTBSsjw+GI/lGqjBkQLa3NkL5MKLlW/MWu+sPBK+7dwZ?=
 =?us-ascii?Q?uXLN7vhkslXp+IVCORxyNeTvH+5i9cjhzydpfERIgv/LT0Iged8EHt9XkGVw?=
 =?us-ascii?Q?HQfhcqJ5Y+mNGd1F3rEqsPNTPLHo1axz+tbyC7RbsAeHabAMogdPFCyY+W1u?=
 =?us-ascii?Q?gQfw36EuhAJKi5UW8MJf2k+euKFotBQejQcgZkCz694Hv+M9zJFzo7/x1fYS?=
 =?us-ascii?Q?xBFgXnAi5HNe3XtEbeXMZem1yhO+Fz1lHbKO573d9E0aNSudM3pJWCLcbQGx?=
 =?us-ascii?Q?RP0wrAT6sYbjIFOUcilx1UeOUaKErBQg6GusJFtTtZPSk+XJpDCCBZ66As7R?=
 =?us-ascii?Q?g/bF8TCECZwcNtZ1QCXnuwbsp/OJ+ifgumvJueSQXE21Rjy/MWGC1ZmWk9hW?=
 =?us-ascii?Q?qnXCxdnaugwgGIaoeQlb0XGpPXrthg9lQY6Al2uSuCGtPNAU0/5BIyglVqMO?=
 =?us-ascii?Q?xT/aNy220dM+nOujyAPX1olEZCHqMKg2Gc/1BsYS2SGHLwvpZ2GFlTqtogin?=
 =?us-ascii?Q?dFMfck07Liwr5eu9toqJ3sKYVk59/3c/loWflxl33OhoOu+FOOwmtXUng2hP?=
 =?us-ascii?Q?ZDpUgCfpDJ/o2z3Gp8z/9eLIpb+ZToEwBZlnaA5RFuLtmwZvLWjGH3zABzLT?=
 =?us-ascii?Q?P/TtkFZYgjpjeDCVXPrp5Dzz9yAihl1glllreeUve0g9xkdQoFWzg70PSv3F?=
 =?us-ascii?Q?RGE0cpPWWlM/+G4hs1wW1QIHCNGweVxet69H2uFn5jwjpooLMpRn1RemUyiO?=
 =?us-ascii?Q?K6eOwoyUVQTqcqYXiMoeRDzg8tbZ33ZvvcxBPRWoxaKWukh7H3KxdykPOE65?=
 =?us-ascii?Q?0b8ShjH13DwAJwa7rB1lNwE77An3go8fBYnKSf5Pv6snXuimuV+dILz0Z8rR?=
 =?us-ascii?Q?p/kaLrQc6Um09hG0bku1VU9S7w3Lqj2NE9Nrk0dLXeSDFhTwPU7pSKoBkTw7?=
 =?us-ascii?Q?PHOU/d9+gJ+fRmn7rj/gFHZnVGHrt/PgJvNrIIjMbBpktWIY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b815aaf1-4991-4722-e133-08df3a47a44d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 07:45:48.3468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17/fNofraiA8Q0zDZ6TF7IBAhgTrM8Z2Az9uONy8KonG+4LEW5vHibTduQanhty8kEeSmqCVGhJiJDF4f7LQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999271
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Ping the series.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, October 30, 2026 3:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prik=
e
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/6] drm/amdgpu: program the SH_MEM registers of the
> SPM VMID
>
> Commit 02232367be23 ("drm/amdgpu: add spm_vmid and exclude it from
> the MES, KFD and kq pools") took the SPM VMID out of the kernel queue and
> the user queue VMID masks, and since commit 8a9263fc8812
> ("drm/amdgpu: use dedicated SPM VMID from the reserved path") the kernel
> queue jobs of a VM with a reserved VMID run on it. The gfx constants_init=
()
> only programs SH_MEM_CONFIG and SH_MEM_BASES for VMID 0 and the
> kernel queue mask though, and init_compute_vmid() for the user queue
> mask, so the SPM VMID keeps the reset defaults: no unaligned access mode
> and no apertures.
>
> On navi48 VMID 15 has SH_MEM_CONFIG 0xc000 and SH_MEM_BASES 0
> while the other graphics VMIDs have 0xc00c and 0x20001000. A shader
> storing a dword to an address with a byte offset of 1 writes it there in =
a normal
> process, but at the dword aligned address in one which reserved a VMID, e=
.g.
> for profiling with SPM:
>
>   $ umr -i 0 -sb 0 0 0 15 -r '*.*.regSH_MEM_CONFIG'
>   gfx1201.regSH_MEM_CONFIG =3D> 0x0000c000
>   $ amd_uapi_regression --run-subtest reserved-vmid-unaligned-store
>   unaligned store: 0x0000000000002a00 normally, 0x000000000000002a
> with a reserved VMID
>
> Add amdgpu_vmid_kq_mask() for VMID 0 and the kernel queue VMIDs of a
> hub, including the SPM VMID on the GFXHUB, and walk it in
> for_each_vmid_and_zero(), so the constants_init() of all gfx generations
> program the SPM VMID like the other kernel queue VMIDs. The mask is only
> used for the register initialization, the VMID allocation pool stays unch=
anged.
>
> v2: split out of the SPM VMID series, the per generation consolidation
>     of the SH_MEM initialization follows (Alex)
>     build the walked mask with amdgpu_vmid_kq_mask(), which the
> consolidation reuses
>
> Fixes: 8a9263fc8812 ("drm/amdgpu: use dedicated SPM VMID from the
> reserved path")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 30 ++++++++++++++++++--
> -----
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index c134000eecfd..3b73c7b4b117 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -36,23 +36,37 @@
>  #define AMDGPU_NUM_VMID      16
>
>  /**
> - * for_each_vmid_and_zero - iterate over VMID 0 plus every VMID set in a
> hub's
> - *                          vmid_mask
> + * amdgpu_vmid_kq_mask - VMIDs the kernel queues of a hub run on
> + * @adev:    struct amdgpu_device *
> + * @hub:     vmhub index into adev->vm_manager.id_mgr[]
> + *
> + * VMID 0, the VMIDs of the hub's kernel queue pool and, on the GFXHUB,
> +the
> + * dedicated SPM VMID, which is kept out of the pool but runs the
> +kernel queue
> + * jobs of the VM reserving it. Only builds a mask for the register
> + * initialization, the VMID allocation pool is not changed.
> + */
> +#define amdgpu_vmid_kq_mask(adev, hub)
>       \
> +     ((adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0) |       \
> +      ((hub) =3D=3D AMDGPU_GFXHUB(0) && (adev)-
> >vm_manager.spm_vmid ?        \
> +       BIT((adev)->vm_manager.spm_vmid) : 0))
> +
> +/**
> + * for_each_vmid_and_zero - iterate over VMID 0 and the kernel queue
> VMIDs of
> + *                          a hub
>   * @vmid:    loop cursor (int / unsigned int)
>   * @adev:    struct amdgpu_device *
>   * @hub:     vmhub index into adev->vm_manager.id_mgr[]
>   *
> - * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking
> - * the result with for_each_set_bit(). Used by the gfx_v*_constants_init=
()
> - * paths which must always touch VMID 0 (system) in addition to the regu=
lar
> - * VMIDs owned by the hub.
> + * Iterate over VMID 0 and the hub's kernel-queue pool, including the
> + * dedicated SPM VMID on GFXHUB, see amdgpu_vmid_kq_mask(). Used by
> the
> + * gfx_v*_constants_init() paths which must always touch VMID 0
> + (system) in
> + * addition to the VMIDs the kernel queues of the hub run on.
>   *
>   * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e=
.
>   * vmid_mask[] being a 1-element bitmap.
>   */
>  #define for_each_vmid_and_zero(vmid, adev, hub)
>       \
> -     for (unsigned long __vmid_mask =3D                                \
> -             (adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0);
>       \
> +     for (unsigned long __vmid_mask =3D amdgpu_vmid_kq_mask(adev,
> hub); \
>            __vmid_mask; __vmid_mask =3D 0)                              \
>               for_each_set_bit((vmid), &__vmid_mask,
> AMDGPU_NUM_VMID)
>
> --
> 2.50.1

