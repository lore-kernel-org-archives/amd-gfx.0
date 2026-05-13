Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B5BCD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 23:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB35B10F0E1;
	Wed, 13 May 2026 23:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKWZmEuC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E99010F0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 23:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7v0zsfL1aH+joygqGEH9WPpBMk0Wa4T72kcyWCP3v71kyqsnYckY451IOgAHin34N6uentLucJvtaYphl3NVNzBlh6RonPFsV1ERMkF6bAxrNs6sdslOvnqbr93PlSlqDFVL2DXLIzeTiFvRHf8fit/74XjvMc25loaJfSMPgrBIw+aAYeN28Q2+bAc3VTLI+Txyhpce4oljwdBN1Uf+VeVWW1EoYC98bRujz+sMuv23mGAyXxryRJg21ponZQfD+FZqYX5+TKMrtcO5UKmd4yAyLd8EjfBZzjemGfkvnImZSeSEYpMIV6lxTgt7+/rk1xp0851Jb3GTFkQcd0Acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sGfSYzJy3pZKh+NRDSGoAAyUkNcLPeW3ZCbysgAdQg=;
 b=YRTlL8RYm7VDIXyLm+uWHd4C2VberBo1166/ZQu69sNcDO5pVPWi0RIO3XZ9s08lnu1ybGjZZdY7uE6ZteYHaafVZAVbJiWoGEHr+AcrUUw+tTsfAZhoet618AF9fwzfNpuAUwZRMtCg5B0nk+6d3u8GLiobOmQzDb3ZwWTaMtT8p/Ls5voy7XFzBF1WtcfpYqr5Wlf7I+5sZfmN0npIi3S1sc+DUzwgqjiQZWKOpmpDcpRJ8urXww1VxKwQuj0vKCJde9BrAcdzcUvxZNiAFGRXLHTCHjwKU39znDF8yD2tSKvwE5Kwhac/uDnsh4dKWFMTmruAJcfPDSrWcAjSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sGfSYzJy3pZKh+NRDSGoAAyUkNcLPeW3ZCbysgAdQg=;
 b=AKWZmEuC37kalqPQwGrsYP7TjNhY7AmtZA127bRXZAMgcFeudCX7gm/mFzjjYmsw2ZsKz8v4jMinFaw0K/KbFv2rR5VDNqCRdMQdQrlIclY82hUVC1HAdoC5DPN/9fNAxmITLkqB0424IOJ+vpfSt3yjZhTGvj2EGAaDbdQQW3w=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 23:56:25 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 23:56:24 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH 2/2] amdgpu: Add Streaming Performance Monitor (SPM) data
 collection interface
Thread-Topic: [PATCH 2/2] amdgpu: Add Streaming Performance Monitor (SPM) data
 collection interface
Thread-Index: AQHcy3vsxJrkIFC9wkCA3HoXrxQE1bYM0StQ
Date: Wed, 13 May 2026 23:56:24 +0000
Message-ID: <BY5PR12MB41792EB41C0E0A2957F4E44FFD062@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
 <20260413192947.3145878-2-James.Zhu@amd.com>
In-Reply-To: <20260413192947.3145878-2-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-13T23:56:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|LV2PR12MB5728:EE_
x-ms-office365-filtering-correlation-id: 44b60a78-6d19-4d2c-2113-08deb14b3da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4143699003|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 0Yf/mqFUDG++Ihy3RM5l0rmjKaMaRTyH9CSAc2vDJYkbHiCrLgHdIlGr33Wjfu3EDiV32w1GAc8b2H8tFmJwiQmsHrCtpJ6KLy1bsnK3BAhsOUaVvcnE7v1Jp90w1JA4afBjCjpFduZi65m7jdm/II0mGksK1qD/2y0cTFfWAn+dsNKE5cvpwxfMoKlIMuLoJNxBdTw/8cMfauEVBlesr9h4mT2wLvDRdJU9jGxNnmtv08ZnWScwxYg/nmUn2Q01KtHdWiF9RiGqrULH5e093qa4J3qLodoD4Hi6br+z7RoI9+UY4a/CsJcH/p+IRmoA6Jhs5Q7pSeZQovc9Tuaf3HvPxEJL6V+No6Wo5c0ofHYuyLsEQrMG5YrYu/k7HwlIMsRKFVeMZcrYd+dbQxl0TBK3iGHyxy/YL3mzSWvUC4u2PtelSTFfQYQ9atqh4JJUefWCGYf3ZOIwMIRCdeWbjwL2APDIIAkXYn9E4BdJXO8hZBlFVah2QDvk5H31MO5LouFdsXaVjqfxtgAQUFcFAlnLCekfX9raZYYyGfMueieh2kaChDrbQGph3eU3ZFlnzZpNWQ2pNIe/xqLenRpXnAYq01UnjNXd98UnObzyXF39tCyubyzooLzPc2OOHVBqB9LKR0G2JsbkmjrgYGNndCjUgf0euBviB9iqai37PPlKgiT1ibtzWuKLSV4/fqbIlJBU5i8nxg3FAsLsk8NbT2LISavNyCZqXwga+OziG5CfgxbLjqJUg3c9JdzOjz4x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aZIci0Pgpua6a2XHQ+ZZQHsb2hHjolmk71wjIVyhFrLIaRaXOkTuMUy/rNhy?=
 =?us-ascii?Q?7ZqEmilau5+xJQpfu2bUskDLKEnASP7klQqA1YgRg287xDJq6La0/SaPopH+?=
 =?us-ascii?Q?vFHPNkxkzqcb6Y1vucla88tUzlirZ4Nx7ZnaVJ+cSvnO++eBwUkd9eIL+3cS?=
 =?us-ascii?Q?EpqEEbJSIBkmztidMu3h9/iEqc/ifs0tv/EUz8fyBfvhL/U0wY3mGJ4Tk0JR?=
 =?us-ascii?Q?oCmwpONUJKI6sey6RBys3mUTDixPRCCPwJIrkIAlZkfB57cIIWdsJ3IhvnP0?=
 =?us-ascii?Q?atYRnFaD4C8xTjuIY4a+dDM4+++P8hpjQZG8XF2kZ4wcWkmaWsX1N4ERgfiw?=
 =?us-ascii?Q?fDxfVr5Zg5gWoxKMit2HYBIv/2qB7nzK4wVBr2L/WZ/bYvu5Kt24HMdgpd2D?=
 =?us-ascii?Q?20MrHieYFe4RgzR40rX19I5hbcY9Bs46QmZpA6a2aFJA/iIwwCAeEppBUFAL?=
 =?us-ascii?Q?tk2z1JmOGvTZztp/f/2pciwQHZWr+HYrX1JMvmg+2J17dJNaeV/vMTBvz6FP?=
 =?us-ascii?Q?MkWaTRDOyEtK1fFX6sOJvpGLdom5fzN/4mQFo7Ih6pEeTPPtZbkW1d1+TJ0f?=
 =?us-ascii?Q?zM1xddd7jvl0KTC53MsYPJ7lWyAzbgs7EcNgTyt++9BHZNQYYM1MMk7z/R7Y?=
 =?us-ascii?Q?3n1MypoUfqJkLicyTdKel5ib6tX/g9RYb7oBHb7m3XiYDesPXzxy8iDL2Kz2?=
 =?us-ascii?Q?Oidf4ravbcAGSlvRTXyUeY+XGwj9IKuDQQ7/KxRqceAezFZuRZQ1Q09nTugX?=
 =?us-ascii?Q?g8S1XjBtwUaqyin4Op9IwJuzyl5/vkAJfHHaDqFblQnuvqW8THaoGSuMlH1u?=
 =?us-ascii?Q?ZRd1ukFLhKEjX99KtZmp1qPabTSgMz0avhskLtXbWT1kPyykASARLh2+YiCv?=
 =?us-ascii?Q?2fUT8lZovYVvNYzbf2moJDAybSXeAR/0DWUNs6rJyP4jsw7xvV0umL9THMBc?=
 =?us-ascii?Q?5phlPU2I7mvbhjiX46InGJXhkVvdD/sC+FFWfvrRL1m9DMKjie1MluQrA1F6?=
 =?us-ascii?Q?Aw1wmZD8rT0SqS+Pc0ttWA4j2jCVydo/ntUcPE4jCk9BsC0a37kmbUSVXHvx?=
 =?us-ascii?Q?mxS847Kyg0wqFSmpAqEQ5GBZrQ2CjcRDWFU+sQiwG6KQ3CoTAInF89GOijbh?=
 =?us-ascii?Q?6F3o+P2ErytmoD2JdjaoEd1gakPTBJmU9LQdi56OYZUEhtZH3N2YUbTy7p/Q?=
 =?us-ascii?Q?/Uales8jJmtq1Wr7/588tJIO2M1gVfMiirqaf6JdqgYImO2UqDKychcTBJ5o?=
 =?us-ascii?Q?qsuFcLcJVw0iBoBAUbk48NOnVTx7D8lJQR5PkYVj0MRvKtp+is2nfj0pM67d?=
 =?us-ascii?Q?fSGe0R783HX+lViG3fR+MmXzuLww6H75BxADSTzEOT3h1Vh8q+tFjHFvYaDX?=
 =?us-ascii?Q?dNSDE207hPv4NAC1+FyTzzqN8J39zt2qvMx7UTWpgLS93TiW5MOtIV14PAuN?=
 =?us-ascii?Q?/U26Mpk+rvGB3UZ9res7B61wLybYzXQa52xaV9Om4sv3MwCZUoAUvPXFSz5W?=
 =?us-ascii?Q?k7CBqq0ksY2+/36xmRFpkIe9qfSaAchcaDjkFDI3qVgpbsKJ3XndvOVXhvuh?=
 =?us-ascii?Q?FUBiNSQGZfyY99lZDJAqoo54ufcwPBxdElbSAMptdr63yN/GP4JmtxjRxJXW?=
 =?us-ascii?Q?C5DTZI9dG5tuEu2PcmfJKJFTm5Za7Neglk++lii+xIYJnhU2LeK2TFlTX4Jh?=
 =?us-ascii?Q?jAW+giHibQuMbgk3dWyw7uASzazqQvMTcZmpK1nGlM34dsHX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b60a78-6d19-4d2c-2113-08deb14b3da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 23:56:24.8156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VU2Q9m4icyqKpGSFGSuZPcbLhnl3Xk2HRF7JqnMcdsqwaVl7rDm1AHH6HyWzNC4QATgy5vHBxo83QyVhVq95aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Monday, April 13, 2026 12:30 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 2/2] amdgpu: Add Streaming Performance Monitor (SPM) data c=
ollection interface

This patch implements full Streaming Performance Monitor (SPM) support for =
AMD GPUs, enabling real-time performance counter data collection directly t=
o userspace buffers.

The implementation provides three key operations:
- AMDGPU_SPM_OP_ACQUIRE: Acquire exclusive access to SPM hardware resources
- AMDGPU_SPM_OP_RELEASE: Release SPM hardware for use by other processes
- AMDGPU_SPM_OP_SET_DEST_BUF: Configure destination buffer and manage
  counter data streaming

Key features:
- Flexible destination buffer management with configurable timeout behavior
- Automatic detection and reporting of data loss due to ring buffer overflo=
w
- Support for partial buffer fills with explicit data size reporting
- Detailed kernel API documentation with operation semantics

The amdgpu_spm_setdestbuff() function allowing profiling tools to efficient=
ly collect performance data from the GPU. The timeout mechanism enables wai=
ting for a buffer to fill completely before switching to a new one, or imme=
diate switching with partial data preservation.

This enables performance analysis tools, and profiling frameworks to access=
 real-time GPU performance metrics without kernel-mode overhead.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 amdgpu/amdgpu-symbols.txt |  3 ++
 amdgpu/amdgpu.h           | 38 ++++++++++++++++
 amdgpu/amdgpu_profiler.c  | 68 +++++++++++++++++++++++++++++  include/drm/=
amdgpu_drm.h  | 92 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu-symbols.txt b/amdgpu/amdgpu-symbols.txt index 8c=
d5559c..b33958ef 100644
--- a/amdgpu/amdgpu-symbols.txt
+++ b/amdgpu/amdgpu-symbols.txt
@@ -88,3 +88,6 @@ amdgpu_create_userqueue  amdgpu_free_userqueue  amdgpu_us=
erq_signal  amdgpu_userq_wait
+amdgpu_spm_acquire
+amdgpu_spm_release
+amdgpu_spm_setdestbuff
diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h index 4ec1f6b6..8698f26a 100=
644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2129,7 +2129,45 @@ int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_ha=
ndle dev,
  */
 int amdgpu_profiler_version(amdgpu_device_handle dev);

+/**
+ * Acquire request exclusive use of SPM
+ * \param   dev               - \c [in]     device handle
+ *
+ * \return  0 on success otherwise POSIX Error code  */ int
+amdgpu_spm_acquire(amdgpu_device_handle dev);
+
+/**
+ * Release exclusive use of SPM
+ *
+ * \return  0 on success otherwise POSIX Error code  */ int
+amdgpu_spm_release(amdgpu_device_handle dev);
+
+/**
+ *  Set up the destination user mode buffer for stream performance
+ *  counter data.
+ * \param   dev               - \c [in]     device handle
+ * \param   size_in_bytes     - \c [in]     size of the buffer
+ * \param   timeout           - \c [in/out] timeout in milliseconds
+ * \param   size_copied       - \c [in]     number of bytes copied
+ * \param   dest_mem_addr     - \c [in]     destination address. Set to NU=
LL
+ *                                          to stop copy on previous buffe=
r
+ * \param   is_spm_data_loss  - \c [in]     true if data was lost
+ *
+ * \return  0 on success otherwise POSIX Error code  */ int
+amdgpu_spm_setdestbuff(
+                       amdgpu_device_handle dev,
+                       uint32_t             size_in_bytes,
+                       uint32_t             *timeout,
+                       uint32_t             *size_copied,
+                       void                 *dest_mem_addr,
+                       bool                 *is_spm_data_loss
+       );
+
 #ifdef __cplusplus
 }
+
 #endif
 #endif /* #ifdef _AMDGPU_H_ */
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c index 8d4d=
ffe4..e9d30fb6 100644
--- a/amdgpu/amdgpu_profiler.c
+++ b/amdgpu/amdgpu_profiler.c
@@ -44,3 +44,71 @@ amdgpu_profiler_version(amdgpu_device_handle dev)

        return ret;
 }
+
+drm_public int
+amdgpu_spm_acquire(amdgpu_device_handle dev) {
+       int ret;
+       struct drm_amdgpu_profiler_args user_arg;
+
+       if (!dev)
+               return -EINVAL;
+
+       memset(&user_arg, 0, sizeof(user_arg));
+       user_arg.op =3D AMDGPU_PROFILER_SPM;
+       user_arg.spm.op =3D AMDGPU_SPM_OP_ACQUIRE;
+
+       ret =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+                                 &user_arg, sizeof(user_arg));
+
+       return ret;
+}
+
+drm_public int
+amdgpu_spm_release(amdgpu_device_handle dev) {
+       struct drm_amdgpu_profiler_args user_arg;
+
+       if (!dev)
+               return -EINVAL;
+
+       memset(&user_arg, 0, sizeof(user_arg));
+       user_arg.op =3D AMDGPU_PROFILER_SPM;
+       user_arg.spm.op =3D AMDGPU_SPM_OP_RELEASE;
+
+       return drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+                                  &user_arg, sizeof(user_arg));
+}
+
+drm_public int
+amdgpu_spm_setdestbuff(
+               amdgpu_device_handle dev,
+               uint32_t             size_in_bytes,
+               uint32_t             *timeout,
+               uint32_t             *size_copied,
+               void                 *dest_mem_addr,
+               bool                 *is_spm_data_loss
+       )
+{
+       int ret;
+       struct drm_amdgpu_profiler_args user_arg;
+
+       if (!dev)
+               return -EINVAL;
+
+       memset(&user_arg, 0, sizeof(user_arg));
+       user_arg.op =3D AMDGPU_PROFILER_SPM;
+       user_arg.spm.op =3D AMDGPU_SPM_OP_SET_DEST_BUF;
+       user_arg.spm.timeout =3D *timeout;
+       user_arg.spm.dest_buf =3D (uint64_t)dest_mem_addr;
+       user_arg.spm.buf_size =3D size_in_bytes;
+
+       ret =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+                                  &user_arg, sizeof(user_arg));
+
+       *size_copied =3D user_arg.spm.bytes_copied;
+       *is_spm_data_loss =3D user_arg.spm.has_data_loss;
+       *timeout =3D user_arg.spm.timeout;
+
+       return ret;
+}
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index 3072=
42ac..60c73233 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -1698,10 +1698,99 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */

 /*
- * Supported Profiler Operations
+ * Supported SPM (Stream Performance Monitor) Operations
  */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ *
+ * @AMDGPU_SPM_OP_ACQUIRE: acquire exclusive access to SPM
+ * @AMDGPU_SPM_OP_RELEASE: release exclusive access to SPM
+ * @AMDGPU_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM
+streaming  */ enum drm_amdgpu_spm_op {
+       AMDGPU_SPM_OP_ACQUIRE,
+       AMDGPU_SPM_OP_RELEASE,
+       AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @op[in]:            specifies the operation to perform
+ * @dst_buf[in]:       used for the address of the destination buffer
+ *                      in @AMDGPU_SPM_SET_DEST_BUFFER
+ * @buf_size[in]:      size of the destination buffer
+ * @timeout[in/out]:   [in]: timeout in milliseconds, [out]: amount of tim=
e left
+ *                      `in the timeout window
+ * @bytes_copied[out]: total amount of data that was copied to the previou=
s dest_buf
+ * @has_data_loss:     total count for sub-block which has data loss
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified for the calling proce=
ss.
+ * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified for the calling
+process,
+ * which allows another process to acquire it in the future.
+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dst_buf is NULL, the destination buffer address is unset and
+copying of counters
+ * is stopped.
+ *
+ * If @dst_buf is not NULL, it specifies the pointer to a new destination =
buffer.
+ * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for
+the previous
+ * buffer to be filled. If previous buffer to be filled before timeout,
+the @timeout
+ * will be updated value with the time remaining. If the timeout is
+exceeded, the function
+ * copies any partial data available into the previous user buffer and ret=
urns success.
+ * The amount of valid data in the previous user buffer is indicated by @b=
ytes_copied.
+ *
+ * If @timeout is 0, the function immediately replaces the previous
+destination buffer
+ * without waiting for the previous buffer to be filled. That means the
+previous buffer
+ * may only be partially filled, and @bytes_copied will indicate how
+much data has been
+ * copied to it.
+ *
+ * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss wi=
ll be non-0.
+ *
+ * Returns negative error code on failure, 0 on success.
+ */
+struct drm_amdgpu_spm_args {
+       __u64 dest_buf;
+       __u32 buf_size;
+       __u32 op;
+       __u32 timeout;
+       __u32 bytes_copied;
+       __u32 has_data_loss;
+       __u32 pad;
+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for
+drm_amdgpu_spm_args->dest_buf
+ *
+ * @version        [out]: spm version
+ * @bytes_copied   [out]: amount of data for each sub-block
+ * @has_data_loss: [out]: boolean indicating whether data was lost for eac=
h sub-block
+ *                        (e.g. due to a ring-buffer overflow)
+ */
+struct drm_amdgpu_spm_buffer_header {
+       __u32 version; /* 0-23: minor 24-31: major */
+       __u32 bytes_copied;
+       __u32 has_data_loss;
+       __u32 reserved[5];
+};
+
 enum drm_amdgpu_profiler_ops {
        AMDGPU_PROFILER_VERSION =3D 0,
+       AMDGPU_PROFILER_SPM,
 };

 struct drm_amdgpu_profiler_args {
@@ -1711,6 +1800,7 @@ struct drm_amdgpu_profiler_args {
                                          * lower 16 bit: minor
                                          * higher 16 bit: major
                                          */
+           struct drm_amdgpu_spm_args spm;
        };
 };

--
2.34.1

