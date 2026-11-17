Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202D606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y4WTC3jP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2E110E4EC;
	Tue, 17 Nov 2026 01:58:49 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450C010E4EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 01:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO+X8MZcFTUVUVXOxdKtvbI4fAD68FoD5KhpRXGldqBJJVmTkeg28eTqhHWr01gmrHd7nW4T9HrFt2y3T6zeQxai+TbLmgjtkYBeyCh7Fatqziw0eVb1mZGqfgerQdg/l6JjU3KM/gilgrUKfZy4643WwiGKO5dqlUjDu6hdmc8evtPhfBCR2Kxvh72qITRS13S5wylMFP7naZH7oXwiX+fNSNIZddMxfgqhCiJvgmaw460iGoNYrKYI54b2MVLMAHEbMei3Q7IcI1wdhMatSgXJD3RaKUUh5KPNVbyMu2/7Gk+hskhINYj3wtQG0wBB7fYZHdLhOcaebvTZc65qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJonRwSTXb21gLO+zakiOAF2XyvVajXBpK78Q2DJP94=;
 b=XyIwcvpubzPxYS33OEf+5M4TdttOEOFVAPrzmmYhW+F7Iy6/YFBEWOOGdqmT/I4LZyoR4r43UMh6GcUFcoomBGwyJJc3bplCVKXTbtuuw5EOZkS2QHVT1S3+nEXSlve9XpcALqjehlR1CcLRrujPaQdua0GcdblVHsfKIyHkAtsGTSQ8kzArRjOhca3RTmZlbCoSO1tKb9BeudUli1yBjQLApvJpqELodJ6R9O46IOUvtq8qgGrFmyw9YRvHMnNOpIzx+s5uBWcsMAjA+gkOR7UxnwvRsrQ0U1+j8X7EoC3dLAEzJam8/vGImQ7xG78SP1HYDr0jVO4jlLw2vN9wHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJonRwSTXb21gLO+zakiOAF2XyvVajXBpK78Q2DJP94=;
 b=y4WTC3jP7s7m+e4JwVgXMKC85OxFD1W9WyAo8rwBYSwtrt6YEjgB01MjNUnBLsjiG34lDxSoo35bnwB1VKpcWrCy4BFePweZuqVZb0e0Sf3GzoPS0jeRTb/L52i/KOtHRM7sVUpa+XOXH+CssKr976Fa5ZiqxMZnViAzO3dHJDg=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 01:58:39 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 01:58:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Topic: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Index: AQHdcRQaGUd7GApEC0GQ5ghRE8CKCLcw3xWAgACsGSA=
Date: Tue, 17 Nov 2026 01:58:38 +0000
Message-ID: <PH7PR12MB6000FB11CF1AEDECD98287DEFB7B2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
 <CY3PR12MB96315B4EC5D0B0EB56099E14F47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
In-Reply-To: <CY3PR12MB96315B4EC5D0B0EB56099E14F47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T15:38:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DM4PR12MB5938:EE_
x-ms-office365-filtering-correlation-id: 97e7e924-f8d5-4a79-00c0-08df444e4c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009221227099003|261009223027099003|4143699003|260925021911599003|56012099006|260925022911599003|11063799006|260925021311599003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: W70RPE5d6MR7g3Du4228/jRI0JT92BDLeL3k7FkoDnE2Sz4wQBnSHIuCFTwbRBkdrVK1LGCumVmn7woVCmwIMCFmeNp+E/EDLptmTEi5X8AiobmmNwrtYwHO0g5EYto3eXUndMAhrHReyu0rtXCbjFRblptb9cPU3kMNBrCP5tzSoE+1kkNbZlVIJQ3clZoPWGRS8dyLLO/WwOiaw49TWNub8ZEo8wI5nkTpbBni3z08OIhoO7UJ8QwcVZC7oFi5wdMq+YWaIo35U8Rhc8wI1EJkv52qzG9jeKO9bDfqBYxzTb7PMrJf75s8gOiSv62Rt0WonH9fpoGwwVtVBXoeXKtPzWd+6qPod32aEVBwixm4LwF+rlFrwVccq4LVe4CPezYGpXNlP9Qiq0QutoWmRMA3eZryfAfT0yn4BCeFY+BJ48oeKrz9+FAQQgA1DlwIlxBii9aWfzfuhGbtdbrxPEQUJxVFC4W1IiWAQg5xoq84+K/0QLcjaYFfiXPh/qIepz5Zg0QqnnEiYPe+Ri0RaCY6olFfnfx5OzcJBYS9gI3VhmShIdrMg5p7efPXDexrhuT2wy62abfTkJN12o3mllU8YpqOa9mGR9EZYa42ZPiJjGC2H9Gd4cqEwxhQaRRWjhrgYRfxED8fTyx/gVDU972Yg9/hkq0/xm4i4mSBMWpOAdfBDuSF/F1k2xzlqr0WLICzXVEXRWcvSveG2gjPj6ldJuoeuzxBbMVDLb4psFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(4143699003)(260925021911599003)(56012099006)(260925022911599003)(11063799006)(260925021311599003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8loZa/xAM50erFiSuSnKgegnaUlvFVjHdACkmfnLyyVX2hS13Wm+DzYcqmZz?=
 =?us-ascii?Q?oyQtF6k/zSn6Gy5Qt18r9iFw17GhtI90drFoygKacarVon5BXWwRJXtnSfoj?=
 =?us-ascii?Q?pDfysRR+cUxYqK/cLO7bqyWCNDJ8IYS0i0InCDEFEBW8W1lbWL+0qMKxPCnA?=
 =?us-ascii?Q?C0Wu/4FI2m3rg7tkFzgPm4IGz8klj7QcxR225dPVuxsYorxdqNWjVeGbWRmE?=
 =?us-ascii?Q?LC/HoFtzu+gfLtHVXuRcwss3kvt+OtMr/Dsq7ogDKucQm6OfMd9L6VHFVR+c?=
 =?us-ascii?Q?/Jk/Vo/a/Fs+cp97u7+ZZnZ+c2iqjsIl4ZAGqvOLxQw3xiD43C16Q6FZ/mq6?=
 =?us-ascii?Q?A96Kv2yiOqMYEKagC6IqkOLeb9/poANjQloK1kTr1UkseT4P+OnzqsxQHUo8?=
 =?us-ascii?Q?qV8m2pYzxam7D8p2Z/9nVcz2zFVqOXGFaoB6DxQYyV17HclzpKSXEL/K+/T+?=
 =?us-ascii?Q?zJ1GcisyWVQjBoWY8O2gOjAEKMP9YI2nBzI4RkdhoyK9RttA+cDalAlEuI/7?=
 =?us-ascii?Q?wKO/37nd00IUan3y7rNV/btX0mT8ZVnxMV2eV7Y3Fxxp9FG/XNUSPye9gsVM?=
 =?us-ascii?Q?0IxAXsIZIvYGJIFtp7+fIuoI9dJBSWp/KBD6OB6vCAmG/uVKSJdGS0ZMtQhd?=
 =?us-ascii?Q?7qzOK2EfbI3JWLIbj3ZgzO6OJIbhvosD+bIndTSEfDTZyCK+KJJAl3a+EQrn?=
 =?us-ascii?Q?7lpThdXah4gdsJ7y1xkicx5imF4+bZJ2jEvsvFS1c4jDqUorxIuY10k88y4I?=
 =?us-ascii?Q?yUdH6BrSNYP/eSCn1mFUB1CCvhliOBMxiPtKEham8h87sbEg7sWTjs5SIKrE?=
 =?us-ascii?Q?yqYCwShKHO/h6eFTlrDHx2L7+V0B8PtBUs7qFHczv4QhE+vba9PeJWM6x7xf?=
 =?us-ascii?Q?307xJa/rYwvamTWxr0BkFrpmz9DpoZgc3ZwkRj1kzAoiMl2i6u4rEyo2EKTi?=
 =?us-ascii?Q?6WumctXfq41V6OK4aGb3UACLtC0sXTY/FrYwyOjx2kbcvuHoSd0YIDQLhW/4?=
 =?us-ascii?Q?kKIOL8PpSsXVQVS1C8baj9Mqrmbj5JvSfO2bQj76qSKsVcF+4Ralx3eN+VOy?=
 =?us-ascii?Q?toocloXxIsZd0RWB/Hcue9s0g6hHIG0r4vRpwtmplsCYTbHSl82iu6AAU27o?=
 =?us-ascii?Q?+1KZ6gqItv8UkdZxxLwBbk///HRfqFoqxfDVTypPVQdy6S941Uzm9g06E0+O?=
 =?us-ascii?Q?H2YrHw/SYE5CxemNYfE8gZvrqQ2i4vEd91T4mrApb5g/h0bksvRshEEhVt1S?=
 =?us-ascii?Q?qfrTpcvRFWap5w+JUMKfVtU52dmHOaUPwWFgp2L9YknnQgziPR31btJLc+rg?=
 =?us-ascii?Q?jJEqcz7uJKxtfC/KSNn78Fs1MRFdyp5M0VbBYgcJ3b68zVq4bNwGgmO0f6aA?=
 =?us-ascii?Q?4WrcOgu4fME57mn5ri+8r8rXQqM0Og5BkvO8JVaPKz3OnrvgPZVmkOTQQONB?=
 =?us-ascii?Q?TiREu/Sq7X15SN0qI/cAS7P/wLTZv6LJrZBNiMKgCOqfVoqBSqUWkBOVLBhP?=
 =?us-ascii?Q?VWDJRFNa4oWapEYBGsQtMnk8elodfwumu25uHIvTWxJpnGgvJULhDuR/jZEn?=
 =?us-ascii?Q?La8SV5HlYBy4U+NqZq7Y1+k43ih0fW/2JndkAG+zm+GoY2XTSCm11sSwE/CC?=
 =?us-ascii?Q?2HwVxkuTb5xUMmyWyxGLsfOOQWpllHktoqk7mn9Y/qdFtgnLwMK+2jZFnbxW?=
 =?us-ascii?Q?78baglwPYsRcO4iFrkG9UYaq0uB8czevmh1yG39Nlk2tBNWV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e7e924-f8d5-4a79-00c0-08df444e4c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 01:58:38.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxKLLmyy5BoDn0Wml86QNO8wBloYzJCLT0qT+lnAL33pRWs6H2wAcwDjEAxkDkp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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

Yes, I plan to enable MES context index loading for GFX11 first. How about =
we handle GFX12 and GFX13 in a separate follow-up patch series?

Regards,
      Prike

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Monday, November 16, 2026 11:39 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>
> Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
> SET_SHADER_DEBUGGER
>
> AMD General
>
> Please also copy process_context_array_index in mes_v12_0.c and mes_v12_1=
.c.
> The v12 API has the field.
>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 10, 2026 8:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
> SET_SHADER_DEBUGGER
>
> With MES RS64 process/gang context loading, MES keeps the process context=
s in
> an array in its local memory and looks them up by the slot index the driv=
er passes.
> SET_SHADER_DEBUGGER has a process_context_array_index field for this, but
> amdgpu_mes_set_shader_debugger() and amdgpu_mes_flush_shader_debugger()
> only pass the process context address, so MES always gets slot 0.
>
> KFD sends the flush variant of this packet for every process that exits
> (kfd_process_dequeue_from_device()). In RS64 mode the flush therefore hit=
s slot 0,
> which belongs to whichever process allocated it first, instead of the exi=
ting process's
> slot:
>  - the owner of slot 0 loses its process context while its queues are
>    still running, so its next GPU accesses fault;
>  - the exiting process's slot is never flushed, so the next process
>    that gets it starts with a stale context.
>
> So the KFDIPCTest.BasicTest failure on Navi3x was caused on the case when
> parent holds slot 0, the child's exit flush wipes the parent's process co=
ntext, and the
> parent's next access to the shared IPC buffer faults.
>
> Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                 | 2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  5 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 7864afab5b40..99b803f95c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -763,6 +763,7 @@ int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>
>  int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                 uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
>                                 uint32_t spi_gdbg_per_vmid_cntl,
>                                 const uint32_t *tcp_watch_cntl,
>                                 const uint64_t *watch_addresses, @@ -782,=
6 +783,8 @@ int
> amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>         op_input.xcc_id =3D xcc_id;
>         op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
>         op_input.set_shader_debugger.process_context_addr =3D process_con=
text_addr;
> +       op_input.set_shader_debugger.process_context_array_index =3D
> +               process_context_array_index;
>         op_input.set_shader_debugger.flags.u32all =3D flags;
>
>         /* use amdgpu mes_flush_shader_debugger instead */ @@ -811,6 +814=
,7 @@
> int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>
>  int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
>                                      uint64_t process_context_addr,
> +                                    uint32_t
> + process_context_array_index,
>                                      uint32_t xcc_id)  {
>         struct mes_misc_op_input op_input =3D {0}; @@ -825,6 +829,8 @@ in=
t
> amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
>         op_input.xcc_id =3D xcc_id;
>         op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
>         op_input.set_shader_debugger.process_context_addr =3D process_con=
text_addr;
> +       op_input.set_shader_debugger.process_context_array_index =3D
> +               process_context_array_index;
>         op_input.set_shader_debugger.flags.process_ctx_flush =3D true;
>
>         amdgpu_mes_lock(&adev->mes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index e5dbcf8ef890..9358090165aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -450,6 +450,7 @@ struct mes_misc_op_input {
>                         uint32_t tcp_watch_cntl[4];
>                         uint64_t watch_addresses[4];
>                         uint32_t trap_en;
> +                       uint32_t process_context_array_index;
>                 } set_shader_debugger;
>
>                 struct {
> @@ -653,6 +654,7 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_devic=
e
> *adev,  int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);  int
> amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                 uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
>                                 uint32_t spi_gdbg_per_vmid_cntl,
>                                 const uint32_t *tcp_watch_cntl,
>                                 const uint64_t *watch_addresses, @@ -660,=
7 +662,8 @@ int
> amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                 bool trap_en,
>                                 uint32_t xcc_id);  int
> amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
> -                               uint64_t process_context_addr, uint32_t x=
cc_id);
> +                               uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
> + uint32_t xcc_id);
>
>  uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device
> *adev,
>                                                    enum amdgpu_mes_priori=
ty_level prio); diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 60b27278a598..2617c2b7f101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1043,6 +1043,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes=
,
>                                 upper_32_bits(input->set_shader_debugger.=
watch_addresses[i])
> & 0xffff;
>                 }
>                 misc_pkt.set_shader_debugger.trap_en =3D input-
> >set_shader_debugger.trap_en;
> +               misc_pkt.set_shader_debugger.process_context_array_index =
=3D
> +
> + input->set_shader_debugger.process_context_array_index;
>                 break;
>         case MES_MISC_OP_CHANGE_CONFIG:
>                 if ((mes->adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK) < 0x63) { diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 71b34a57c2cc..cb830f985536 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -373,7 +373,8 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)
>         }
>
>         return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
> -                                       pdd->proc_ctx_gpu_addr, spi_dbg_c=
ntl,
> +                                       pdd->proc_ctx_gpu_addr,
> +                                       pdd->proc_ctx_array_index,
> + spi_dbg_cntl,
>                                         pdd->watch_points,
>                                         pdd->watch_addresses,
>                                         flags, sq_trap_en, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index b68e884b1c37..d3149e6d40e4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -96,6 +96,7 @@ void kfd_process_dequeue_from_device(struct
> kfd_process_device *pdd)
>             down_read_trylock(&dev->adev->reset_domain->sem)) {
>                 amdgpu_mes_flush_shader_debugger(dev->adev,
>                                                  pdd->proc_ctx_gpu_addr,
> +
> + pdd->proc_ctx_array_index,
>                                                  ffs(pdd->dev->xcc_mask) =
- 1);
>                 up_read(&dev->adev->reset_domain->sem);
>         }
> --
> 2.34.1
>

