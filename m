Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF299606A840
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y9rgrZro
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5976510E071;
	Wed,  4 Nov 2026 22:14:47 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5DC10E071
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 22:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2uEpOdsPyHo6GEX8IlKk2Kwj2+tRPz+gESGd/B4+KHcu+qX3jjBaks+cyi/xF8Rss/hCBOrYP37eDRqRBe97xOp94voxYcL22vh0rLHRcU+Tq6jaFb+QBW289hkPfz4sBMymAwyF6iT3I7kdLnoQ6yQxDKVFSTgevoQSavw9btZ4SYd0ZAUQ5qrA+JhtylCxCw8S2shlaDMVOuTWBGIRsD7Wc08Ei9Hd/Voqkgx7iHwfTVETBEYgNHzK4Uo9Wu8L1p1vI0hEQl7r7/nkuhAsNBqzUjtyNubpsLwhm/4StSv7fBE0Wtm3eGvTr8X5XwDUvmbrAlAwelL17edCoSR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D9k0MtEx8d9S5KHdKwRMxgm10d0heqpeqMIMDVKZr4=;
 b=yawdJxRyNghXgl85QrSC/ZLhwzWBTW4V7jJwfxFF6DnOPeUs3DrKffG1WGyOdBBdxt1fzXlbV6JJ6KtlH2tGmBHEU5U4OKZeEXdHJ+kKbAMiMI82+JjKFzRrH/pMCy6MXI71sKLSSMHXAxADgqhc3CKvK2+JFEp0YAtRmYNEhYncQzEWrkSn89D0viupS09jeU9h2N0x2L0s2/NfYlirarM7d8YsTsCA1M8FXm7Ev3SZUmmzu/Lwh/jn0gJ1NtGC9zaeWS2YwhF9t6uFRV+KYN793hDctpL87R03Y5QYAD52ghuzlU7NhFBqiVk5bsLm7FyXOk+/YJfZ+KunjSaA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D9k0MtEx8d9S5KHdKwRMxgm10d0heqpeqMIMDVKZr4=;
 b=Y9rgrZroh1j4DsuWk/Sp4cqo13AecqPDs9vlZtvUQKiPYrytl65dEoKXtXziotnHGcrK/CNCD6CcWQ7/3W9xqzSdjvcPvDzyuU9fVG2AdaqzVvQRGzyIUKPMpgHcipm6O80QsY0KqF0S9OHFfoGnuPL889tpRHZLvbohYDScC9U=
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 (2603:10b6:510:412::21) by DS0PR12MB9324.namprd12.prod.outlook.com
 (2603:10b6:8:1b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 22:14:36 +0000
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534]) by PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 22:14:36 +0000
From: "Mishra, Apurv" <Apurv.Mishra@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Ma, Bing" <Bing.Ma@amd.com>, "Welton, Benjamin"
 <Benjamin.Welton@amd.com>, "Tang, Jason (Markham)" <Jason.Tang@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Topic: [PATCH v2] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Index: AQHdazuEAbfEL9bdekmGuBdQNC9rZ7ceNXQAgABFqeM=
Date: Wed, 4 Nov 2026 22:14:36 +0000
Message-ID: <PH9PR12MB1359214ABEFD25F9718961AD329F682@PH9PR12MB135921.namprd12.prod.outlook.com>
References: <20261103023145.61021-1-Apurv.Mishra@amd.com>
 <add0b216-7697-47ea-80aa-5216334292e0@amd.com>
In-Reply-To: <add0b216-7697-47ea-80aa-5216334292e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T22:14:01.161Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH9PR12MB135921:EE_|DS0PR12MB9324:EE_
x-ms-office365-filtering-correlation-id: 52af603c-2b50-4f09-5741-08df3ac1030a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|8096899003|3023799007|38070700021|56012099006|4143699003|5023799004|11063799006|261026121527099003|261022115727099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003;
x-microsoft-antispam-message-info: JmhgpihFQWbiFW8FMuS4ESYkvAInVaTNPwGi0rsAjdi5XHwYNulW35rgItkRPJ9jrSm/46il2bteM1G8WqYJcpJ3pmHrvL8q/1wDh8oLYgXfuE8Js8NVCHRVBhyl2r07zEn4WMYoxwx75SvLVXOv3GOVu3GStnCUhBxOyno+Fgq8rJ9obZw4hrsO1UZ7bX6WPVCs6JhmJbNtzbjdyzurv7QydfsdZHHukejReTBSIEAdHHqG5fbM0IAFl1afXC+dCIvoJi+CqEe0UruZi1DStCTawJ++9EYgLsfqW2be4FwYKEyD4kJRZkt1RCrGa/3d9xtwTssjgLG+gJZIEHABUIqH97Y0wn/BXbnS3XWan+ztuFhwmeMB62jHkWnifLMpJY0tylzYJd9QPFXBnpK1Ho84ucOzYQtMSh4bP51A68yn2GSAx12yTfsmsQVRmOPW87f4WSY8DQQ1FHGccA7EXvUwAATyZY6FjG1Bx+f8E8FXIF3tUZG37OVNQkR9A8PsbNjc5LT/tgrqM9aLZsygEDyk8+tO9X+BBPt0gfTEiqAlOPwiAQ89JiLoLLMwypftExuR3YovvctpgniplbQX11pj7hFYpGhLmwqraDCXTeOvchwDR0enUqrzcykJqprRAAd7iCK3GFy0qACIcu00I+Pm9GrHKSGCfptwIM3g0YRiw9Uzzu1rXFrndc/xR2PvuGRJeyA4OhLaDmEudILKPQTSlByi2YynKKet/tmiTTg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH9PR12MB135921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(8096899003)(3023799007)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(261026121527099003)(261022115727099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xC+FJlt/U0thNLX/iukfiBbjhChGqan0dx7f+omJ7abnLs7t/t8VlpsLKo?=
 =?iso-8859-1?Q?T+ZmAxpPUoi8TTPrX/AZmCCX59GUZHVZwsb7sy1vQ748LNlGQQi2z+EujG?=
 =?iso-8859-1?Q?0F2wltvQuTOOa3V3RE9uaCU57Ni7i5t6PzytIfBsybRYiFr2noA83tUdqj?=
 =?iso-8859-1?Q?BJJhW0YILW1WgLlN/fd9XGgwXU4FXe8yTUNsUi6w5+s+naZO3gWWQf7JvS?=
 =?iso-8859-1?Q?k0h24YLaKZI4YW7lq8N6CkPOCtMMj1kevUkZEZvactImumyyO4+kmYpFrp?=
 =?iso-8859-1?Q?CzPutMdvu2rkc3EWSUaEFdo/ohASgeiHkxWvb2FTGBw2FAZvqh71aj/Hex?=
 =?iso-8859-1?Q?OhQJY1EAIPrZgFBDkaV3IndfgJjtm9GQv5F1pQj0tuK6KYypWRAG3WzUap?=
 =?iso-8859-1?Q?qEMBzVSuSJUBq6vhJ98Bje6ct8FBeGfyVujnn1u5dvRA9uXjHLMPqGeZAl?=
 =?iso-8859-1?Q?hEanadTRZMg27Pc/8TacEqVtZJPQikJm6G24bBh4yC7XSsHInFY8q20nQR?=
 =?iso-8859-1?Q?WJ9u4VUBWCgHqj2URn4ANmTkWjKUkNBt3SWm8ll+HX6P5wzqAXBCjzE/bF?=
 =?iso-8859-1?Q?KE9cSvY3HqzrYGaihXee1M4wlPacNsBJEVATeLrC6yXQ0iDtB6ZxPZb4e8?=
 =?iso-8859-1?Q?J5DsCL3m9S6PjTCZRNOOfYvNJXuROTdvQXefoVjDP+rFJMGvJfOIQyvAk6?=
 =?iso-8859-1?Q?JS8dUYcfLccqMrp5m0o6hWLw0BrKhvWgGpxyQfh59SYCOyQq6EPuggn97O?=
 =?iso-8859-1?Q?ohoP06DbiBE3OyA9md8Y/3FdsnjYmU8pEgbp7olfLjcZzGeWLZLeuj0OnZ?=
 =?iso-8859-1?Q?vxLeVcNgEN+IksAN2FZ6cwUIkmhTVKthN1zS7IGtafYNnB53Q2h0UJjoa7?=
 =?iso-8859-1?Q?BDzd5I+sithBu03FgZmrlAjBex4v61ibhGPW4QiKnTl34U5X+Ls8b1gyqU?=
 =?iso-8859-1?Q?OwACVk5VMAEaBybilGHpL531fc1i4WmmHIrKs4Dmu1kBiSW+hff3MG00qg?=
 =?iso-8859-1?Q?s45GrGZRfrpW1ewqEmYcl/xC0h9OL8szjCROuJYpIypBPrcG+C5sVi88BX?=
 =?iso-8859-1?Q?Te4PSKCp9/QwCXask1btLV4e9woAm9ZSh441MvtGQyVIwE4t5ewiF6gqD2?=
 =?iso-8859-1?Q?y7AiR70fd1iILRvvEFLnC3ZgUZKdFUtkHsdwFSmJQNjS/5XgO8dQtv46Mi?=
 =?iso-8859-1?Q?r7hYheoIfcJwQR4vY5To5K/s3FaWrrRKqX/myA03WRgmafqVv75cMWUQx/?=
 =?iso-8859-1?Q?GYY0qKzlQF0IikJYKSSguUKh0HGDBVPhKowhx7fx9n/ipp5MJQTcO7/DpW?=
 =?iso-8859-1?Q?ZMtxDHK2G5lZUe8vuj/t09ahs04W25p7gQ8HeaoHt3eje22lyId+U8jWZt?=
 =?iso-8859-1?Q?vgT3wmvcLHAh2bIf4NBYEywycfM/C+V9/c2xXXz+O/mL6+gWqeU/CdrK5V?=
 =?iso-8859-1?Q?n1J40PxvA+BXye84jiI0LB601EWLwscdjKtvfDBV3X+xjXIsdGejpThWro?=
 =?iso-8859-1?Q?uHtrUeSBZM5Xlfn1k90wpXl2g/aktrVV+NiDgEf0RMA9pliG/Ee3kGI8KT?=
 =?iso-8859-1?Q?igsyQfDqsmvbatTGhR7v0YWHrktSV8/fjQuKP+ROQ+R8ZSM8mCmXdIhb/P?=
 =?iso-8859-1?Q?lAtNQYrsbWMmSbDdAuV0oLuGIfchu+85bwyqFcybpewDRa+/yKKNn0BxaN?=
 =?iso-8859-1?Q?QKxH31oeQjh5xYwnJmByC5FqOuyvzxczJtIaOLy6dyHK5gyuVHU7L7vQnd?=
 =?iso-8859-1?Q?79EgNS1R0709xUrgznVvCyHPpGGVTgYtzkAMlT8BW5rxeI?=
Content-Type: multipart/alternative;
 boundary="_000_PH9PR12MB1359214ABEFD25F9718961AD329F682PH9PR12MB135921_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH9PR12MB135921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af603c-2b50-4f09-5741-08df3ac1030a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 22:14:36.3743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00vA1QdqMeN3MZFB2Md2kD+HI7iKvqZoyzCX8Vnmz3dWOPVC+mBiNFxxmRioHiGAn3AEKFRPgRewxS0W7eKgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_PH9PR12MB1359214ABEFD25F9718961AD329F682PH9PR12MB135921_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi, @Deucher, Alexander<mailto:Alexander.Deucher@amd.com> and @Koenig, Chri=
stian<mailto:Christian.Koenig@amd.com>, this change was reviewed by James Z=
hu but there is also the following change related to user space which would=
 need a review from either of you. Please have a look, thank you.

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 749d196e2114..34f3ffaf1c66 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {
};
};
-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*

  *
* KFD_IOC_PROFILER_VERSION_NUM history:
  *
* - 1 - initial version
  *
* - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until th=
e
  *
* lock is released or the process exits. lock =3D=3D 0 with
  *
* perfcount_enable =3D=3D 1 forces it on without CAP_PERFMON and without
  *
* locking, until lock =3D=3D 0 with perfcount_enable =3D=3D 0 or the proces=
s
  *
* exits
  *
/
+#define KFD_IOC_PROFILER_VERSION_NUM 2
     *
enum kfd_profiler_ops {
KFD_IOC_PROFILER_PMC =3D 0,
KFD_IOC_PROFILER_VERSION =3D 2,

Regards,
Apurv

________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Wednesday, November 4, 2026 12:57 PM
To: Mishra, Apurv <Apurv.Mishra@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.c=
om>; Welton, Benjamin <Benjamin.Welton@amd.com>; Zhu, James <James.Zhu@amd.=
com>; Tang, Jason (Markham) <Jason.Tang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: Force perfmon clock on for profiler PMC=
 requests



On 2026-11-02 21:31, Apurv Mishra wrote:

Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
workaround (STABLE_STD) needs root and pins clocks.

Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
perfmon clock on per XCC, keeps GFXOFF disallowed while held, and
restores the previous state on last release, resume and reset.
perfmon_clk_mutex serializes it with the GFX clock gating sequences
and the soc21/soc24 stable pstate hook.

Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU
and under reset_domain->sem:
- lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.
- lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON needed,
  held until lock=3D0, perfcount_enable=3D0 or process exit.

No DPM change, no new ioctl, no struct change. Bump
KFD_IOC_PROFILER_VERSION_NUM to 2.

v2:
- Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle
- Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold
  perfmon_clk_mutex across the GFX clock gating sequences
- Bind the process to the GPU before forcing the perfmon clock on
- Take reset_domain->sem before profiler_lock
- Release a dispatch-mode hold with lock=3D0, perfcount_enable=3D0

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com><mailto:Apurv.Mishra@amd.=
com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 89 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/soc24.c         |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 63 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 20 +++++
 include/uapi/linux/kfd_ioctl.h             | 11 ++-
 12 files changed, 261 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 44091ac12fa9..04422c1e1f86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)

        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+       amdgpu_gfx_perfmon_clk_restore(adev);

        amdgpu_device_fill_reset_magic(adev);

@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        mutex_init(&adev->srbm_mutex);
        mutex_init(&adev->gfx.pipe_reserve_mutex);
        mutex_init(&adev->gfx.gfx_off_mutex);
+       mutex_init(&adev->gfx.perfmon_clk_mutex);
        mutex_init(&adev->gfx.partition_mutex);
        mutex_init(&adev->grbm_idx_mutex);
        mutex_init(&adev->mn_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index a6f95ff47d24..c9c4c3d4e88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_dev=
ice *adev, bool enable)
        amdgpu_gfx_do_off_ctrl(adev, enable, true);
 }

+/*
+ * Force the perfmon clock on, or restore the saved state; @save records t=
he old
+ * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.
+ */
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
+                                          bool force_on, bool save)
+{
+       int i, num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
[JZ] Nit: lockdep_assert_held(&adev->gfx.perfmon_clk_mutex) here, as amdgpu=
_gfx_perfmon_clk_update() does.
With this update,

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com><mailto:James.Zhu@a=
md.com>

+       for (i =3D 0; i < num_xcc; i++) {
+               bool on =3D force_on || test_bit(i, &adev->gfx.perfmon_clk_=
restore_mask);
+               bool in_safe_mode =3D adev->gfx.rlc.in_safe_mode[i];
+               bool was_on;
+
+               if (!in_safe_mode)
+                       amdgpu_gfx_rlc_enter_safe_mode(adev, i);
+               was_on =3D adev->gfx.funcs->set_perfmon_clk_override(adev, =
i, on);
+               if (!in_safe_mode)
+                       amdgpu_gfx_rlc_exit_safe_mode(adev, i);
+
+               if (save)
+                       assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, =
was_on);
+       }
+}
+
+/*
+ * Refcounted override that keeps the perfmon clock on for profilers. The =
last
+ * put restores the previous state. Each hold keeps GFXOFF disallowed, as =
a
+ * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can'=
t do it.
+ *
+ * GFXOFF control takes pm.mutex, which clock gating holds around
+ * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.
+ */
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e)
+{
+       int r =3D 0;
+
+       if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
+           !adev->gfx.funcs->set_perfmon_clk_override)
+               return -EOPNOTSUPP;
+
+       if (enable)
+               amdgpu_gfx_off_ctrl(adev, false);
+
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
+       if (enable) {
+               if (!adev->gfx.perfmon_clk_override_count++)
+                       amdgpu_gfx_perfmon_clk_program(adev, true, true);
+       } else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
+               r =3D -EINVAL;
+       } else if (!--adev->gfx.perfmon_clk_override_count) {
+               amdgpu_gfx_perfmon_clk_program(adev, false, false);
+       }
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+
+       if (!enable && !r)
+               amdgpu_gfx_off_ctrl(adev, true);
+
+       return r;
+}
+
+/*
+ * Program the perfmon clock for clock gating. While overridden, only reco=
rd
+ * the state for the final restore. Called with perfmon_clk_mutex held.
+ */
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on)
+{
+       lockdep_assert_held(&adev->gfx.perfmon_clk_mutex);
+
+       if (adev->gfx.perfmon_clk_override_count)
+               assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on)=
;
+       else
+               adev->gfx.funcs->set_perfmon_clk_override(adev, xcc_id, on)=
;
+}
+
+/* Re-apply the override after resume/reset reprogrammed clock gating. */
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
+{
+       if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
+               return;
+
+       amdgpu_gfx_off_ctrl(adev, false);
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
+       if (adev->gfx.perfmon_clk_override_count)
+               amdgpu_gfx_perfmon_clk_program(adev, true, false);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+       amdgpu_gfx_off_ctrl(adev, true);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
        int r =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index f5fb2e585e8a..1bfd12dd3956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
                                 u32 queue, u32 vmid, u32 xcc_id);
        void (*init_spm_golden)(struct amdgpu_device *adev);
        void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable=
);
+       /* set the perfmon clock, returns its previous state */
+       bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xc=
c_id,
+                                        bool on);
        int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
                                   struct amdgpu_gfx_shadow_info *shadow_in=
fo,
                                   bool skip_check);
@@ -500,6 +503,11 @@ struct amdgpu_gfx {
        uint32_t                        gfx_off_residency;  /* last logged =
residency */
        uint64_t                        gfx_off_entrycount; /* count of tim=
es GPU has get into GFXOFF state */

+       /* perfmon clock override for profilers */
+       struct mutex                    perfmon_clk_mutex;
+       uint32_t                        perfmon_clk_override_count;
+       unsigned long                   perfmon_clk_restore_mask; /* per XC=
C */
+
        /* pipe reservation */
        struct mutex                    pipe_reserve_mutex;
        DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_CO=
MPUTE_QUEUES);
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device =
*adev,
                                        u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable=
);
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e);
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on);
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)=
;
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common=
_if *ras_block);
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_=
if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index a7ed4923857b..a01244621fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
                                      bool enable);
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);

 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)
 {
@@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_fu=
ncs =3D {
        .read_wave_vgprs =3D &gfx_v11_0_read_wave_vgprs,
        .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
        .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v11_0_set_perfmon_clk_override,
        .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu=
_device *adev, int xcc_id)
        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }

-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
-                                     bool enable)
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
+                                     bool enable)
+{
+       if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+               amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }

 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
@@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gatin=
g(struct amdgpu_device *ade
 static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
                                            bool enable)
 {
+       /* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override=
 */
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
        amdgpu_gfx_rlc_enter_safe_mode(adev, 0);

        gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
@@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,
                gfx_v11_0_enable_gui_idle_interrupt(adev, enable);

        amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index ec1e142549c5..9e754c25b15c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
                                      bool enable);
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);

 static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
                                        uint64_t queue_mask)
@@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_func=
s =3D {
        .read_wave_vgprs =3D &gfx_v12_0_read_wave_vgprs,
        .select_me_pipe_q =3D &gfx_v12_0_select_me_pipe_q,
        .update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v12_0_set_perfmon_clk_override,
        .get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu=
_device *adev,
        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }

-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
-                                     bool enable)
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
+                                     bool enable)
+{
+       if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+               amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }

 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
@@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_=
device *adev,
 static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
                                            bool enable)
 {
+       /* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override=
 */
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
        amdgpu_gfx_rlc_enter_safe_mode(adev, 0);

        gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);
@@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,
                gfx_v12_0_enable_gui_idle_interrupt(adev, enable);

        amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index f812d6d81e9c..958b4ad39d9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_dev=
ice *adev,
                                      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
                                         bool enable, int xcc_id);
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *ad=
ev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
        struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
@@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_func=
s =3D {
        .read_wave_vgprs =3D &gfx_v12_1_read_wave_vgprs,
        .select_me_pipe_q =3D &gfx_v12_1_select_me_pipe_q,
        .update_perfmon_mgcg =3D &gfx_v12_1_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v12_1_set_perfmon_clk_override,
        .get_xccs_per_xcp =3D &gfx_v12_1_get_xccs_per_xcp,
        .ih_node_to_logical_xcc =3D &gfx_v12_1_ih_to_xcc_inst,
 };
@@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct a=
mdgpu_device *adev,
                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVE=
RRIDE, data);
 }

-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
-                                         bool enable, int xcc_id)
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT=
_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVE=
RRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
+                                         bool enable, int xcc_id)
+{
+       if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+               amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);
 }

 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *ade=
v,
                                             bool enable, int xcc_id)
 {
+       /* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override=
 */
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
        amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);

        gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id=
);
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,
                gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_i=
d);

        amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 599d47e1d38b..ed10c258703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_dev=
ice *adev)
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
                                          bool enter)
 {
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
        if (enter)
                amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
        else
@@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu=
_device *adev,

        if (adev->gfx.funcs->update_perfmon_mgcg)
                adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 6c8b8ed4a44d..46d746dd37b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_dev=
ice *adev)
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
                                          bool enter)
 {
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
        if (enter)
                amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
        else
@@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu=
_device *adev,

        if (adev->gfx.funcs->update_perfmon_mgcg)
                adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..e4fb9f5aa3b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,

        mutex_lock(&p->mutex);
        pdd =3D kfd_process_device_data_by_id(p, gpu_id);
+       /* Bind for the runtime PM reference before programming the perfmon=
 clock */
+       if (pdd && op =3D=3D 1)
+               pdd =3D kfd_bind_process_to_device(pdd->dev, p);
        mutex_unlock(&p->mutex);

+       if (IS_ERR(pdd))
+               return PTR_ERR(pdd);
        if (!pdd || !pdd->dev || !pdd->dev->kfd)
                return -EINVAL;

        kfd =3D pdd->dev->kfd;
        ptl =3D &pdd->dev->adev->psp.ptl;

+       /* Before profiler_lock, which reset takes in kfd_resume() */
+       down_read(&kfd->adev->reset_domain->sem);
        mutex_lock(&kfd->profiler_lock);
        if (op =3D=3D 1) {
                if (!kfd->profiler_process) {
                        kfd->profiler_process =3D p;
+                       amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
                        status =3D 0;
                        mutex_unlock(&kfd->profiler_lock);
+                       up_read(&kfd->adev->reset_domain->sem);
                        if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SU=
PPORTED) {
                                status =3D kfd_ptl_disable_request(pdd, p);
                                if (status !=3D 0)
@@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_pro=
cess *p,
                }
        } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
                kfd->profiler_process =3D NULL;
+               amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
                status =3D 0;
                mutex_unlock(&kfd->profiler_lock);
+               up_read(&kfd->adev->reset_domain->sem);

                if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED)=
 {
                        status =3D kfd_ptl_disable_release(pdd, p);
@@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,
                return status;
        }
        mutex_unlock(&kfd->profiler_lock);
+       up_read(&kfd->adev->reset_domain->sem);

        return status;
 }

+/*
+ * Take or drop this process's dispatch-mode perfmon clock hold. Taking it=
 again
+ * is a no-op. Dropping returns -ENOENT without a hold, and for the device=
 lock
+ * holder, whose lock =3D=3D 0 must still unlock.
+ */
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id=
,
+                                   bool enable)
+{
+       struct kfd_process_device *pdd;
+       struct kfd_dev *kfd;
+       int r =3D 0;
+
+       mutex_lock(&p->mutex);
+       pdd =3D kfd_process_device_data_by_id(p, gpu_id);
+       /* Bind for the runtime PM reference before programming the perfmon=
 clock */
+       if (pdd && enable)
+               pdd =3D kfd_bind_process_to_device(pdd->dev, p);
+       mutex_unlock(&p->mutex);
+
+       if (IS_ERR(pdd))
+               return PTR_ERR(pdd);
+       if (!pdd || !pdd->dev || !pdd->dev->kfd)
+               return -EINVAL;
+
+       kfd =3D pdd->dev->kfd;
+
+       /* Before profiler_lock, which reset takes in kfd_resume() */
+       down_read(&kfd->adev->reset_domain->sem);
+       mutex_lock(&kfd->profiler_lock);
+       if (!enable && (!pdd->perfmon_clk_req || kfd->profiler_process =3D=
=3D p))
+               r =3D -ENOENT;
+       else if (pdd->perfmon_clk_req !=3D enable)
+               r =3D amdgpu_gfx_perfmon_clk_override(kfd->adev, enable);
+       if (!r)
+               pdd->perfmon_clk_req =3D enable;
+       mutex_unlock(&kfd->profiler_lock);
+       up_read(&kfd->adev->reset_domain->sem);
+
+       return r;
+}
+
 static inline int kfd_profiler_pmc(struct kfd_process *p,
                                   struct kfd_ioctl_pmc_settings *args)
 {
@@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_proces=
s *p,
        struct device_queue_manager *dqm;
        int status;

+       if (!args->lock) {
+               /* Dispatch mode: perfmon clock only, no lock, no CAP_PERFM=
ON needed */
+               if (args->perfcount_enable)
+                       return kfd_profiler_perfmon_clk(p, args->gpu_id, tr=
ue);
+
+               /* Drop a dispatch-mode hold if there is one, else unlock a=
s before */
+               if (!kfd_profiler_perfmon_clk(p, args->gpu_id, false))
+                       return 0;
+       }
+
        /* Check if we have the correct permissions. */
        if (!perfmon_capable())
                return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index d8631847f0eb..32c3c23d6d14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -886,6 +886,8 @@ struct kfd_process_device {
        u32 pasid;
        /* Indicates this process has requested PTL stay disabled */
        bool ptl_disable_req;
+       /* Holds a dispatch-mode perfmon clock override until released or e=
xit */
+       bool perfmon_clk_req;
 };

 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index dd938788bdd9..7ba1c4ab283b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(st=
ruct kfd_process *p)

 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd=
_process_device *pdd)
 {
+       struct amdgpu_device *adev =3D pdd->dev->adev;
+       int puts =3D 0;
+
        mutex_lock(&pdd->dev->kfd->profiler_lock);
        if (pdd->dev->kfd->profiler_process =3D=3D p) {
                pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
                pdd->dev->kfd->profiler_process =3D NULL;
+               puts++;
+       }
+       if (pdd->perfmon_clk_req) {
+               pdd->perfmon_clk_req =3D false;
+               puts++;
        }
        mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
+       /*
+        * Nothing is held on the kfd_create_process() error path, which ho=
lds
+        * kfd_processes_mutex and so must not wait for a reset.
+        */
+       if (!puts)
+               return;
+
+       down_read(&adev->reset_domain->sem);
+       while (puts--)
+               amdgpu_gfx_perfmon_clk_override(adev, false);
+       up_read(&adev->reset_domain->sem);
 }

 static void kfd_process_destroy_pdds(struct kfd_process *p)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 749d196e2114..34f3ffaf1c66 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {
        };
 };

-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*
+ * KFD_IOC_PROFILER_VERSION_NUM history:
+ * - 1 - initial version
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until =
the
+ *       lock is released or the process exits. lock =3D=3D 0 with
+ *       perfcount_enable =3D=3D 1 forces it on without CAP_PERFMON and wi=
thout
+ *       locking, until lock =3D=3D 0 with perfcount_enable =3D=3D 0 or th=
e process
+ *       exits
+ */
+#define KFD_IOC_PROFILER_VERSION_NUM 2
 enum kfd_profiler_ops {
        KFD_IOC_PROFILER_PMC =3D 0,
        KFD_IOC_PROFILER_VERSION =3D 2,


--_000_PH9PR12MB1359214ABEFD25F9718961AD329F682PH9PR12MB135921_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<p class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 8pt; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi, <a href=3D"mailto:Alexander.Deucher@amd.com" id=3D"OWAAM511345" class=
=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" style=3D"margin-top: 0px; margin-bot=
tom: 0px;">
@Deucher, Alexander</a>&nbsp;and <a href=3D"mailto:Christian.Koenig@amd.com=
" id=3D"OWAAM703941" class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" style=3D"m=
argin-top: 0px; margin-bottom: 0px;">
@Koenig, Christian</a>, this change was reviewed by James Zhu but there is =
also the following change related to user space which would need a review f=
rom either of you. Please have a look, thank you.</p>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
index 749d196e2114..34f3ffaf1c66 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--- a/include/uapi/linux/kfd_ioctl.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+++ b/include/uapi/linux/kfd_ioctl.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
};</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
};</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
-#define KFD_IOC_PROFILER_VERSION_NUM 1</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+/*</div>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* KFD_IOC_PROFILER_VERSION_NUM history:</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* - 1 - initial version</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* - 2 - KFD_IOC_PROFILER_PMC lock also forces th=
e perfmon clock on until the</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* lock is released or the process exits. lock =
=3D=3D 0 with</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* perfcount_enable =3D=3D 1 forces it on without=
 CAP_PERFMON and without</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* locking, until lock =3D=3D 0 with perfcount_en=
able =3D=3D 0 or the process</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">* exits</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">+#define KFD_IOC_PROFILER_VERSION_NUM 2</div>
</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); displa=
y: block;">
<div role=3D"presentation">enum kfd_profiler_ops {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">KFD_IOC_PROFILER_PMC =3D 0,</div>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">KFD_IOC_PROFILER_VERSION =3D 2,</div>
</div>
</li></ul>
</ul>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Apurv</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 4, 2026 12:57 PM<br>
<b>To:</b> Mishra, Apurv &lt;Apurv.Mishra@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma, Bing &=
lt;Bing.Ma@amd.com&gt;; Welton, Benjamin &lt;Benjamin.Welton@amd.com&gt;; Z=
hu, James &lt;James.Zhu@amd.com&gt;; Tang, Jason (Markham) &lt;Jason.Tang@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: Force perfmon clock on for profi=
ler PMC requests
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 1em; margin-bottom: 1em;"><br>
</p>
<div>On 2026-11-02 21:31, Apurv Mishra wrote:</div>
<blockquote>
<pre><div>Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 bec=
ause=0A=
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing=0A=
workaround (STABLE_STD) needs root and pins clocks.=0A=
=0A=
Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the=0A=
perfmon clock on per XCC, keeps GFXOFF disallowed while held, and=0A=
restores the previous state on last release, resume and reset.=0A=
perfmon_clk_mutex serializes it with the GFX clock gating sequences=0A=
and the soc21/soc24 stable pstate hook.=0A=
=0A=
Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU=0A=
and under reset_domain-&gt;sem:=0A=
- lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.=0A=
- lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON needed,=0A=
 &nbsp;held until lock=3D0, perfcount_enable=3D0 or process exit.=0A=
=0A=
No DPM change, no new ioctl, no struct change. Bump=0A=
KFD_IOC_PROFILER_VERSION_NUM to 2.=0A=
=0A=
v2:=0A=
- Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle=0A=
- Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold=
=0A=
 &nbsp;perfmon_clk_mutex across the GFX clock gating sequences=0A=
- Bind the process to the GPU before forcing the perfmon clock on=0A=
- Take reset_domain-&gt;sem before profiler_lock=0A=
- Release a dispatch-mode hold with lock=3D0, perfcount_enable=3D0=0A=
=0A=
Signed-off-by: Apurv Mishra <a href=3D"mailto:Apurv.Mishra@amd.com" id=3D"O=
WA2360748b-eda4-fe49-5053-3180d09b24ff" class=3D"x_moz-txt-link-rfc2396E OW=
AAutoLink">&lt;Apurv.Mishra@amd.com&gt;</a>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | &nbsp;2 +=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c &nbsp; &nbsp;| 89 ++++++++++++++++=
++++++=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h &nbsp; &nbsp;| 11 +++=0A=
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c &nbsp; &nbsp; | 28 +++++--=0A=
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c &nbsp; &nbsp; | 28 +++++--=0A=
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c &nbsp; &nbsp; | 28 +++++--=0A=
 drivers/gpu/drm/amd/amdgpu/soc21.c &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2 +=
=0A=
 drivers/gpu/drm/amd/amdgpu/soc24.c &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2 +=
=0A=
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c &nbsp; | 63 +++++++++++++++=0A=
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h &nbsp; &nbsp; &nbsp;| &nbsp;2 +=0A=
 drivers/gpu/drm/amd/amdkfd/kfd_process.c &nbsp; | 20 +++++=0A=
 include/uapi/linux/kfd_ioctl.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |=
 11 ++-=0A=
 12 files changed, 261 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c=0A=
index 44091ac12fa9..04422c1e1f86 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
@@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)=0A=
 =0A=
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);=0A=
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);=0A=
+	amdgpu_gfx_perfmon_clk_restore(adev);=0A=
 =0A=
 	amdgpu_device_fill_reset_magic(adev);=0A=
 =0A=
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,=0A=
 	mutex_init(&amp;adev-&gt;srbm_mutex);=0A=
 	mutex_init(&amp;adev-&gt;gfx.pipe_reserve_mutex);=0A=
 	mutex_init(&amp;adev-&gt;gfx.gfx_off_mutex);=0A=
+	mutex_init(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	mutex_init(&amp;adev-&gt;gfx.partition_mutex);=0A=
 	mutex_init(&amp;adev-&gt;grbm_idx_mutex);=0A=
 	mutex_init(&amp;adev-&gt;mn_lock);=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c=0A=
index a6f95ff47d24..c9c4c3d4e88d 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
@@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_dev=
ice *adev, bool enable)=0A=
 	amdgpu_gfx_do_off_ctrl(adev, enable, true);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Force the perfmon clock on, or restore the saved state; @save records t=
he old=0A=
+ * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.=0A=
+ */=0A=
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,=0A=
+					 &nbsp; bool force_on, bool save)=0A=
+{=0A=
+	int i, num_xcc =3D NUM_XCC(adev-&gt;gfx.xcc_mask);=0A=
[JZ] Nit: lockdep_assert_held(&amp;adev-&gt;gfx.perfmon_clk_mutex) here, as=
 amdgpu_gfx_perfmon_clk_update() does.=0A=
With this update,&nbsp;</div></pre>
</blockquote>
<pre style=3D"margin: 0px;"><div style=3D"text-indent: 0px;">This<span styl=
e=3D"color: rgb(192, 192, 192);"> </span>patch<span style=3D"color: rgb(192=
, 192, 192);"> </span>is<span style=3D"color: rgb(192, 192, 192);"> </span>=
Reviewed-by:<span style=3D"color: rgb(192, 192, 192);"> </span>James<span s=
tyle=3D"color: rgb(192, 192, 192);"> </span>Zhu<span style=3D"color: rgb(19=
2, 192, 192);"> </span><a href=3D"mailto:James.Zhu@amd.com" id=3D"OWAccfd74=
19-9258-7d8b-729f-ec7cdd656f2e" class=3D"x_moz-txt-link-rfc2396E OWAAutoLin=
k">&lt;James.Zhu@amd.com&gt;</a></div></pre>
<blockquote>
<pre><div>+	for (i =3D 0; i &lt; num_xcc; i++) {=0A=
+		bool on =3D force_on || test_bit(i, &amp;adev-&gt;gfx.perfmon_clk_restor=
e_mask);=0A=
+		bool in_safe_mode =3D adev-&gt;gfx.rlc.in_safe_mode[i];=0A=
+		bool was_on;=0A=
+=0A=
+		if (!in_safe_mode)=0A=
+			amdgpu_gfx_rlc_enter_safe_mode(adev, i);=0A=
+		was_on =3D adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, i, on);=
=0A=
+		if (!in_safe_mode)=0A=
+			amdgpu_gfx_rlc_exit_safe_mode(adev, i);=0A=
+=0A=
+		if (save)=0A=
+			assign_bit(i, &amp;adev-&gt;gfx.perfmon_clk_restore_mask, was_on);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refcounted override that keeps the perfmon clock on for profilers. The =
last=0A=
+ * put restores the previous state. Each hold keeps GFXOFF disallowed, as =
a=0A=
+ * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can'=
t do it.=0A=
+ *=0A=
+ * GFXOFF control takes pm.mutex, which clock gating holds around=0A=
+ * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.=
=0A=
+ */=0A=
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e)=0A=
+{=0A=
+	int r =3D 0;=0A=
+=0A=
+	if (amdgpu_sriov_vf(adev) || !adev-&gt;gfx.funcs ||=0A=
+	 &nbsp; &nbsp;!adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override)=0A=
+		return -EOPNOTSUPP;=0A=
+=0A=
+	if (enable)=0A=
+		amdgpu_gfx_off_ctrl(adev, false);=0A=
+=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
+	if (enable) {=0A=
+		if (!adev-&gt;gfx.perfmon_clk_override_count++)=0A=
+			amdgpu_gfx_perfmon_clk_program(adev, true, true);=0A=
+	} else if (WARN_ON_ONCE(!adev-&gt;gfx.perfmon_clk_override_count)) {=0A=
+		r =3D -EINVAL;=0A=
+	} else if (!--adev-&gt;gfx.perfmon_clk_override_count) {=0A=
+		amdgpu_gfx_perfmon_clk_program(adev, false, false);=0A=
+	}=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
+=0A=
+	if (!enable &amp;&amp; !r)=0A=
+		amdgpu_gfx_off_ctrl(adev, true);=0A=
+=0A=
+	return r;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Program the perfmon clock for clock gating. While overridden, only reco=
rd=0A=
+ * the state for the final restore. Called with perfmon_clk_mutex held.=0A=
+ */=0A=
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on)=0A=
+{=0A=
+	lockdep_assert_held(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
+=0A=
+	if (adev-&gt;gfx.perfmon_clk_override_count)=0A=
+		assign_bit(xcc_id, &amp;adev-&gt;gfx.perfmon_clk_restore_mask, on);=0A=
+	else=0A=
+		adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, xcc_id, on);=0A=
+}=0A=
+=0A=
+/* Re-apply the override after resume/reset reprogrammed clock gating. */=
=0A=
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)=0A=
+{=0A=
+	if (!adev-&gt;gfx.funcs || !adev-&gt;gfx.funcs-&gt;set_perfmon_clk_overri=
de)=0A=
+		return;=0A=
+=0A=
+	amdgpu_gfx_off_ctrl(adev, false);=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
+	if (adev-&gt;gfx.perfmon_clk_override_count)=0A=
+		amdgpu_gfx_perfmon_clk_program(adev, true, false);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
+	amdgpu_gfx_off_ctrl(adev, true);=0A=
+}=0A=
+=0A=
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)=
=0A=
 {=0A=
 	int r =3D 0;=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h=0A=
index f5fb2e585e8a..1bfd12dd3956 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h=0A=
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {=0A=
 				 u32 queue, u32 vmid, u32 xcc_id);=0A=
 	void (*init_spm_golden)(struct amdgpu_device *adev);=0A=
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);=0A=
+	/* set the perfmon clock, returns its previous state */=0A=
+	bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xcc_id,=
=0A=
+					 bool on);=0A=
 	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,=0A=
 				 &nbsp; struct amdgpu_gfx_shadow_info *shadow_info,=0A=
 				 &nbsp; bool skip_check);=0A=
@@ -500,6 +503,11 @@ struct amdgpu_gfx {=0A=
 	uint32_t &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;gfx_off_residency; &nbsp;/* last logged residency */=0A=
 	uint64_t &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;gfx_off_entrycount; /* count of times GPU has get into G=
FXOFF state */=0A=
 =0A=
+	/* perfmon clock override for profilers */=0A=
+	struct mutex			perfmon_clk_mutex;=0A=
+	uint32_t			perfmon_clk_override_count;=0A=
+	unsigned long			perfmon_clk_restore_mask; /* per XCC */=0A=
+=0A=
 	/* pipe reservation */=0A=
 	struct mutex			pipe_reserve_mutex;=0A=
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);=0A=
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device =
*adev,=0A=
 					u8 me_id, u8 pipe_id, u8 queue_id);=0A=
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);=0A=
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable=
);=0A=
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e);=0A=
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on);=0A=
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);=0A=
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)=
;=0A=
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common=
_if *ras_block);=0A=
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_=
if *ras_block);=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c=0A=
index a7ed4923857b..a01244621fa3 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c=0A=
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);=0A=
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);=0A=
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,=0A=
 				 &nbsp; &nbsp; &nbsp;bool enable);=0A=
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on);=0A=
 =0A=
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)=0A=
 {=0A=
@@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_fu=
ncs =3D {=0A=
 	.read_wave_vgprs =3D &amp;gfx_v11_0_read_wave_vgprs,=0A=
 	.select_me_pipe_q =3D &amp;gfx_v11_0_select_me_pipe_q,=0A=
 	.update_perfmon_mgcg =3D &amp;gfx_v11_0_update_perf_clk,=0A=
+	.set_perfmon_clk_override =3D &amp;gfx_v11_0_set_perfmon_clk_override,=0A=
 	.get_gfx_shadow_info =3D &amp;gfx_v11_0_get_gfx_shadow_info,=0A=
 	.get_hdp_flush_mask =3D &amp;amdgpu_gfx_get_hdp_flush_mask,=0A=
 };=0A=
@@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu=
_device *adev, int xcc_id)=0A=
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);=0A=
 }=0A=
 =0A=
-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,=0A=
-				 &nbsp; &nbsp; &nbsp;bool enable)=0A=
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on)=0A=
 {=0A=
 	uint32_t def, data;=0A=
 =0A=
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))=0A=
-		return;=0A=
-=0A=
 	def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);=0A=
 =0A=
-	if (enable)=0A=
-		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
-	else=0A=
+	if (on)=0A=
 		data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
+	else=0A=
+		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
 =0A=
 	if (def !=3D data)=0A=
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);=0A=
+=0A=
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);=0A=
+}=0A=
+=0A=
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,=0A=
+				 &nbsp; &nbsp; &nbsp;bool enable)=0A=
+{=0A=
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)=0A=
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);=0A=
 }=0A=
 =0A=
 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,=0A=
@@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gatin=
g(struct amdgpu_device *ade=0A=
 static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,=
=0A=
 					 &nbsp; &nbsp;bool enable)=0A=
 {=0A=
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);=0A=
 =0A=
 	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);=0A=
@@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,=0A=
 	 &nbsp; &nbsp; &nbsp; &nbsp;gfx_v11_0_enable_gui_idle_interrupt(adev, ena=
ble);=0A=
 =0A=
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c=0A=
index ec1e142549c5..9e754c25b15c 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c=0A=
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);=0A=
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);=0A=
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,=0A=
 				 &nbsp; &nbsp; &nbsp;bool enable);=0A=
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on);=0A=
 =0A=
 static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,=0A=
 					uint64_t queue_mask)=0A=
@@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_func=
s =3D {=0A=
 	.read_wave_vgprs =3D &amp;gfx_v12_0_read_wave_vgprs,=0A=
 	.select_me_pipe_q =3D &amp;gfx_v12_0_select_me_pipe_q,=0A=
 	.update_perfmon_mgcg =3D &amp;gfx_v12_0_update_perf_clk,=0A=
+	.set_perfmon_clk_override =3D &amp;gfx_v12_0_set_perfmon_clk_override,=0A=
 	.get_gfx_shadow_info =3D &amp;gfx_v12_0_get_gfx_shadow_info,=0A=
 	.get_hdp_flush_mask =3D &amp;amdgpu_gfx_get_hdp_flush_mask,=0A=
 };=0A=
@@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu=
_device *adev,=0A=
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);=0A=
 }=0A=
 =0A=
-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,=0A=
-				 &nbsp; &nbsp; &nbsp;bool enable)=0A=
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on)=0A=
 {=0A=
 	uint32_t def, data;=0A=
 =0A=
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))=0A=
-		return;=0A=
-=0A=
 	def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);=0A=
 =0A=
-	if (enable)=0A=
-		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
-	else=0A=
+	if (on)=0A=
 		data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
+	else=0A=
+		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
 =0A=
 	if (def !=3D data)=0A=
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);=0A=
+=0A=
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);=0A=
+}=0A=
+=0A=
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,=0A=
+				 &nbsp; &nbsp; &nbsp;bool enable)=0A=
+{=0A=
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)=0A=
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);=0A=
 }=0A=
 =0A=
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,=0A=
@@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_=
device *adev,=0A=
 static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,=
=0A=
 					 &nbsp; &nbsp;bool enable)=0A=
 {=0A=
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);=0A=
 =0A=
 	gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);=0A=
@@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,=0A=
 		gfx_v12_0_enable_gui_idle_interrupt(adev, enable);=0A=
 =0A=
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c=0A=
index f812d6d81e9c..958b4ad39d9f 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c=0A=
@@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_dev=
ice *adev,=0A=
 				 &nbsp; &nbsp; &nbsp;bool enable);=0A=
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=0A=
 					 bool enable, int xcc_id);=0A=
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on);=0A=
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *ad=
ev);=0A=
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(=0A=
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);=0A=
@@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_func=
s =3D {=0A=
 	.read_wave_vgprs =3D &amp;gfx_v12_1_read_wave_vgprs,=0A=
 	.select_me_pipe_q =3D &amp;gfx_v12_1_select_me_pipe_q,=0A=
 	.update_perfmon_mgcg =3D &amp;gfx_v12_1_update_perf_clk,=0A=
+	.set_perfmon_clk_override =3D &amp;gfx_v12_1_set_perfmon_clk_override,=0A=
 	.get_xccs_per_xcp =3D &amp;gfx_v12_1_get_xccs_per_xcp,=0A=
 	.ih_node_to_logical_xcc =3D &amp;gfx_v12_1_ih_to_xcc_inst,=0A=
 };=0A=
@@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct a=
mdgpu_device *adev,=0A=
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);=
=0A=
 }=0A=
 =0A=
-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=0A=
-					 &nbsp;bool enable, int xcc_id)=0A=
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,=
=0A=
+					 &nbsp; &nbsp; &nbsp; int xcc_id, bool on)=0A=
 {=0A=
 	uint32_t def, data;=0A=
 =0A=
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))=0A=
-		return;=0A=
-=0A=
 	def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_=
OVERRIDE);=0A=
 =0A=
-	if (enable)=0A=
-		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
-	else=0A=
+	if (on)=0A=
 		data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
+	else=0A=
+		data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=0A=
 =0A=
 	if (def !=3D data)=0A=
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);=
=0A=
+=0A=
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);=0A=
+}=0A=
+=0A=
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=0A=
+					 &nbsp;bool enable, int xcc_id)=0A=
+{=0A=
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)=0A=
+		amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);=0A=
 }=0A=
 =0A=
 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *ade=
v,=0A=
 					 &nbsp; &nbsp; bool enable, int xcc_id)=0A=
 {=0A=
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);=0A=
 =0A=
 	gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id);=0A=
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,=0A=
 		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_id);=0A=
 =0A=
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c=0A=
index 599d47e1d38b..ed10c258703c 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c=0A=
@@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_dev=
ice *adev)=0A=
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,=0A=
 					 &nbsp;bool enter)=0A=
 {=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	if (enter)=0A=
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);=0A=
 	else=0A=
@@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu=
_device *adev,=0A=
 =0A=
 	if (adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg)=0A=
 		adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !enter);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c=0A=
index 6c8b8ed4a44d..46d746dd37b2 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c=0A=
@@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_dev=
ice *adev)=0A=
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,=0A=
 					 &nbsp;bool enter)=0A=
 {=0A=
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 	if (enter)=0A=
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);=0A=
 	else=0A=
@@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu=
_device *adev,=0A=
 =0A=
 	if (adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg)=0A=
 		adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !enter);=0A=
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c=0A=
index 7fcfc150a7fc..e4fb9f5aa3b2 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c=0A=
@@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,=0A=
 =0A=
 	mutex_lock(&amp;p-&gt;mutex);=0A=
 	pdd =3D kfd_process_device_data_by_id(p, gpu_id);=0A=
+	/* Bind for the runtime PM reference before programming the perfmon clock=
 */=0A=
+	if (pdd &amp;&amp; op =3D=3D 1)=0A=
+		pdd =3D kfd_bind_process_to_device(pdd-&gt;dev, p);=0A=
 	mutex_unlock(&amp;p-&gt;mutex);=0A=
 =0A=
+	if (IS_ERR(pdd))=0A=
+		return PTR_ERR(pdd);=0A=
 	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)=0A=
 		return -EINVAL;=0A=
 =0A=
 	kfd =3D pdd-&gt;dev-&gt;kfd;=0A=
 	ptl =3D &amp;pdd-&gt;dev-&gt;adev-&gt;psp.ptl;=0A=
 =0A=
+	/* Before profiler_lock, which reset takes in kfd_resume() */=0A=
+	down_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
 	mutex_lock(&amp;kfd-&gt;profiler_lock);=0A=
 	if (op =3D=3D 1) {=0A=
 		if (!kfd-&gt;profiler_process) {=0A=
 			kfd-&gt;profiler_process =3D p;=0A=
+			amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, true);=0A=
 			status =3D 0;=0A=
 			mutex_unlock(&amp;kfd-&gt;profiler_lock);=0A=
+			up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
 			if (ptl-&gt;hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED) {=0A=
 				status =3D kfd_ptl_disable_request(pdd, p);=0A=
 				if (status !=3D 0)=0A=
@@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_pro=
cess *p,=0A=
 		}=0A=
 	} else if (op =3D=3D 0 &amp;&amp; kfd-&gt;profiler_process =3D=3D p) {=0A=
 		kfd-&gt;profiler_process =3D NULL;=0A=
+		amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, false);=0A=
 		status =3D 0;=0A=
 		mutex_unlock(&amp;kfd-&gt;profiler_lock);=0A=
+		up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
 =0A=
 		if (ptl-&gt;hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED) {=0A=
 			status =3D kfd_ptl_disable_release(pdd, p);=0A=
@@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,=0A=
 		return status;=0A=
 	}=0A=
 	mutex_unlock(&amp;kfd-&gt;profiler_lock);=0A=
+	up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
 =0A=
 	return status;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Take or drop this process's dispatch-mode perfmon clock hold. Taking it=
 again=0A=
+ * is a no-op. Dropping returns -ENOENT without a hold, and for the device=
 lock=0A=
+ * holder, whose lock =3D=3D 0 must still unlock.=0A=
+ */=0A=
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id=
,=0A=
+				 &nbsp; &nbsp;bool enable)=0A=
+{=0A=
+	struct kfd_process_device *pdd;=0A=
+	struct kfd_dev *kfd;=0A=
+	int r =3D 0;=0A=
+=0A=
+	mutex_lock(&amp;p-&gt;mutex);=0A=
+	pdd =3D kfd_process_device_data_by_id(p, gpu_id);=0A=
+	/* Bind for the runtime PM reference before programming the perfmon clock=
 */=0A=
+	if (pdd &amp;&amp; enable)=0A=
+		pdd =3D kfd_bind_process_to_device(pdd-&gt;dev, p);=0A=
+	mutex_unlock(&amp;p-&gt;mutex);=0A=
+=0A=
+	if (IS_ERR(pdd))=0A=
+		return PTR_ERR(pdd);=0A=
+	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)=0A=
+		return -EINVAL;=0A=
+=0A=
+	kfd =3D pdd-&gt;dev-&gt;kfd;=0A=
+=0A=
+	/* Before profiler_lock, which reset takes in kfd_resume() */=0A=
+	down_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
+	mutex_lock(&amp;kfd-&gt;profiler_lock);=0A=
+	if (!enable &amp;&amp; (!pdd-&gt;perfmon_clk_req || kfd-&gt;profiler_proc=
ess =3D=3D p))=0A=
+		r =3D -ENOENT;=0A=
+	else if (pdd-&gt;perfmon_clk_req !=3D enable)=0A=
+		r =3D amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, enable);=0A=
+	if (!r)=0A=
+		pdd-&gt;perfmon_clk_req =3D enable;=0A=
+	mutex_unlock(&amp;kfd-&gt;profiler_lock);=0A=
+	up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);=0A=
+=0A=
+	return r;=0A=
+}=0A=
+=0A=
 static inline int kfd_profiler_pmc(struct kfd_process *p,=0A=
 				 &nbsp; struct kfd_ioctl_pmc_settings *args)=0A=
 {=0A=
@@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_proces=
s *p,=0A=
 	struct device_queue_manager *dqm;=0A=
 	int status;=0A=
 =0A=
+	if (!args-&gt;lock) {=0A=
+		/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */=
=0A=
+		if (args-&gt;perfcount_enable)=0A=
+			return kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, true);=0A=
+=0A=
+		/* Drop a dispatch-mode hold if there is one, else unlock as before */=
=0A=
+		if (!kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, false))=0A=
+			return 0;=0A=
+	}=0A=
+=0A=
 	/* Check if we have the correct permissions. */=0A=
 	if (!perfmon_capable())=0A=
 		return -EPERM;=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h=0A=
index d8631847f0eb..32c3c23d6d14 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h=0A=
@@ -886,6 +886,8 @@ struct kfd_process_device {=0A=
 	u32 pasid;=0A=
 	/* Indicates this process has requested PTL stay disabled */=0A=
 	bool ptl_disable_req;=0A=
+	/* Holds a dispatch-mode perfmon clock override until released or exit */=
=0A=
+	bool perfmon_clk_req;=0A=
 };=0A=
 =0A=
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c=0A=
index dd938788bdd9..7ba1c4ab283b 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c=0A=
@@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(st=
ruct kfd_process *p)=0A=
 =0A=
 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd=
_process_device *pdd)=0A=
 {=0A=
+	struct amdgpu_device *adev =3D pdd-&gt;dev-&gt;adev;=0A=
+	int puts =3D 0;=0A=
+=0A=
 	mutex_lock(&amp;pdd-&gt;dev-&gt;kfd-&gt;profiler_lock);=0A=
 	if (pdd-&gt;dev-&gt;kfd-&gt;profiler_process =3D=3D p) {=0A=
 		pdd-&gt;qpd.dqm-&gt;ops.set_perfcount(pdd-&gt;qpd.dqm, 0);=0A=
 		pdd-&gt;dev-&gt;kfd-&gt;profiler_process =3D NULL;=0A=
+		puts++;=0A=
+	}=0A=
+	if (pdd-&gt;perfmon_clk_req) {=0A=
+		pdd-&gt;perfmon_clk_req =3D false;=0A=
+		puts++;=0A=
 	}=0A=
 	mutex_unlock(&amp;pdd-&gt;dev-&gt;kfd-&gt;profiler_lock);=0A=
+=0A=
+	/*=0A=
+	 * Nothing is held on the kfd_create_process() error path, which holds=0A=
+	 * kfd_processes_mutex and so must not wait for a reset.=0A=
+	 */=0A=
+	if (!puts)=0A=
+		return;=0A=
+=0A=
+	down_read(&amp;adev-&gt;reset_domain-&gt;sem);=0A=
+	while (puts--)=0A=
+		amdgpu_gfx_perfmon_clk_override(adev, false);=0A=
+	up_read(&amp;adev-&gt;reset_domain-&gt;sem);=0A=
 }=0A=
 =0A=
 static void kfd_process_destroy_pdds(struct kfd_process *p)=0A=
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h=0A=
index 749d196e2114..34f3ffaf1c66 100644=0A=
--- a/include/uapi/linux/kfd_ioctl.h=0A=
+++ b/include/uapi/linux/kfd_ioctl.h=0A=
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {=0A=
 	};=0A=
 };=0A=
 =0A=
-#define KFD_IOC_PROFILER_VERSION_NUM 1=0A=
+/*=0A=
+ * KFD_IOC_PROFILER_VERSION_NUM history:=0A=
+ * - 1 - initial version=0A=
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until =
the=0A=
+ * &nbsp; &nbsp; &nbsp; lock is released or the process exits. lock =3D=3D=
 0 with=0A=
+ * &nbsp; &nbsp; &nbsp; perfcount_enable =3D=3D 1 forces it on without CAP=
_PERFMON and without=0A=
+ * &nbsp; &nbsp; &nbsp; locking, until lock =3D=3D 0 with perfcount_enable=
 =3D=3D 0 or the process=0A=
+ * &nbsp; &nbsp; &nbsp; exits=0A=
+ */=0A=
+#define KFD_IOC_PROFILER_VERSION_NUM 2=0A=
 enum kfd_profiler_ops {=0A=
 	KFD_IOC_PROFILER_PMC =3D 0,=0A=
 	KFD_IOC_PROFILER_VERSION =3D 2,=0A=
</div></pre>
</blockquote>
</body>
</html>

--_000_PH9PR12MB1359214ABEFD25F9718961AD329F682PH9PR12MB135921_--
