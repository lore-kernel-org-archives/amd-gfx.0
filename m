Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9D606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ieaYH9PC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC4610F323;
	Tue,  3 Nov 2026 02:32:49 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB0410F31F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YttIBTYsq6ExCXJF8EvEl1cGVYVWqb1zj1fCPYlef4IjQ/zGQQLoCsb+Vz8QewBsgDueIRy2algrOjeymdZy6q/go7QlAkZdIdVHysj+h3GhderimTt/O4EYELWkNGDf1jzoIQ/kqHSXLEkmNE68fBB3k/NIDs1XOHspzUJogrL+bkcpksrW5bDTl6q+uRDhNpvLlb/Y815bsB9TruVUQ4hcbzJ4cKpIJz73/8TJzVgvwVOcX1mT416VV7xEtWSTGg2ILRvg3pF3zTl5uDNxtPhSeLEqyN05iqq3ehJ61i4WLWh6RyBBH8Yab5SfDj1yD+emvUsmcte3a38J2OfyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RhdwHl/mfn8qd0rM7Rdr8FnJXMrfsIozGPvacH34Z0=;
 b=EO9EMH1y7KVUUOL96h/+TQppzD9ydeptMIj2vj9VLxniwTDoX9GTX0zVf975CfpBrW1f9OU0pGPJe/jAb3uG+UYXAHVdY6tHDPifsvUXBZvfJ4NaM+hmm3PvZB9Nx/GyonJc/oTTUZkeA2fgjNmaA6F8d6dZ00ew200LMqkw7vV1fK9zXM3OFjpdvvAFf8jjX/kgEzm8Q8DYsXaBr/2xkewZy8PzlDB2EG/YjBZ40cxIUaJ3Vi5jD35/TDbxIr/GlepmhkGTn+TDqUbrVzbj93ORjrWaRmLHBmJIreuAu3HS/fcbRpzs67BTtpJF+8Tmr2Mu4TX7aw6CiU2hPvfhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RhdwHl/mfn8qd0rM7Rdr8FnJXMrfsIozGPvacH34Z0=;
 b=ieaYH9PCfQc5Lg694V4Us80oF6Blqrzl082e9S3fMr1QpPGAki/iQSsGsxaDBII6FJ6142tWB34OFm6oOquwsgDZb0ni6+BhWXQb8mfKqJ5CpeNJQB3HtsRAkxoF9osN/pin9N8wULvCO3zYFKnZL1U9V0NzX0R/CaRbcRhrEEs=
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 (2603:10b6:510:412::21) by DM4PR12MB6304.namprd12.prod.outlook.com
 (2603:10b6:8:a2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:32:13 +0000
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534]) by PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:32:12 +0000
From: "Mishra, Apurv" <Apurv.Mishra@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Bing"
 <Bing.Ma@amd.com>, "Welton, Benjamin" <Benjamin.Welton@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Tang, Jason (Markham)" <Jason.Tang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: force perfmon clock on for profiler PMC
 requests
Thread-Topic: [PATCH v2] drm/amdkfd: force perfmon clock on for profiler PMC
 requests
Thread-Index: AQHdazpDhI9rHVOZtkGvI9H3Rn85gbcbn9qN
Date: Tue, 3 Nov 2026 02:32:12 +0000
Message-ID: <PH9PR12MB1359218CEB025679B5CDC01B1F9F692@PH9PR12MB135921.namprd12.prod.outlook.com>
References: <20261103022235.60665-1-Apurv.Mishra@amd.com>
In-Reply-To: <20261103022235.60665-1-Apurv.Mishra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T02:31:36.358Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH9PR12MB135921:EE_|DM4PR12MB6304:EE_
x-ms-office365-filtering-correlation-id: 7806242f-47d3-4e00-75e7-08df3952aaa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|3023799007|8096899003|56012099006|11063799006|5023799004|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261022115727099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: BzwGcmXjYj0oKmd6qLvRus++gwQi8BOg4JAdYnWp5bj4nU97/UksRybovJU2obtasNwNkRe4Hm+Y7eIxgBr+kKChKSWpfJJH6diqSo7R+uADid5PG6c9qwVFkWXRwm7DOF1RxFmLxanz8HRbVkGgRmCYYjqu9MoSUIY0YL1DMJ6+r9K7BGUwaZhAfsr4FNg/xq76KSXRD2K6UNAX6ChG/Ye/IVz+yI0X3QlrwZYUmQqmKj8SgI7GKS0/fdgwvb3hY3MDxSGVw0Dxj45ceTKR9uD6FfJbTzy1OJpU7yo894hqgdMW6PzuiIymWTTeJ4Ruzx1OSoK8nGlRzeXpPwmHF6Tlb/UgCV0BoITH8NeBhi86GxGa4f0tFmHlQchFU5QMNUWUA9TZPCMc/7ib203Crbkp2sNiI8o9oXVWDc9bPfrz8SYM1wGkTbrFs6KcXn9/h0lhLkJwrPcegKLBY4oXWUPIPI8tM/EbRYszFEFrQbaE0Nq32DnaBkvGzhDO18buQhNSJvxKba+UlB56pVWiQ8a7Walb48sPPKmbBayJUPj3QiPezL/BRyIW/fp4l/iHrTsQWH9REmnRq9ZwYkyjRog73VabTF4bM97CU6uRQoOzv+xu/jo+EzvDhvcl18Y6MR9sO7mtCmYU6UV7/QoB9Y0nHYQwCRanFzp8Paa00Wn/fVRsZnhMO9DQYqTxQfQdl5y1wPAWQK/I6gqbEqi2lO0Nz506IAUngzJl1hsJsp4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH9PR12MB135921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(8096899003)(56012099006)(11063799006)(5023799004)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3gJL99aeOgs0B2GjR2pcDi9Q/h6vdlthq9EIZjEDnheeVr+7U8/J3bM6Ev?=
 =?iso-8859-1?Q?OCMRBiKjq/Ejj8u9rMiX3dmj0GFrJqKDr6ItRqB5JN3GSN9SyK/5LWc+fg?=
 =?iso-8859-1?Q?QuHvmLlRU6jDViiZ6veuoJ5CrhO+8u+aDBaIRz/+KAxBGcvaJN/+JjhziR?=
 =?iso-8859-1?Q?u5Y+45tmrBB6nBtp6iek4AvBlg4A9hF+tBO3tke3BM2qVnTGU6cV9WR9WA?=
 =?iso-8859-1?Q?I/6+HnbMArMHM0LA1ZMChFFRebl3cqHF+o/NBBc3am2b/IruBes41W4NAi?=
 =?iso-8859-1?Q?KXYfzMrYoENldvZoVYvIR201+VnI9M848FlDVdPOn2WJfCP29iWG/D9nu4?=
 =?iso-8859-1?Q?lwbbP4TmPy1Ywa1AQ1bZp2XdHxIex9y1DqI9qwNxGSqVNH8uaaeZUAkhjt?=
 =?iso-8859-1?Q?KFYClX2e7y+yCCUUbnrh5lQdOpLJU8YkAaSz3Y4Fez4g4RJRaGcTGcDCgG?=
 =?iso-8859-1?Q?1cq8drqklK1dPxTE8cCwziMA72b4Qd1ckJ62wbN44sukXnRs5pUuCT1mXm?=
 =?iso-8859-1?Q?zNo79eE0GFKuhaxcy+pS43nT23uq4i6Fu33kpN7qt/kZgDKvbwtzoh35rG?=
 =?iso-8859-1?Q?Th9yxTo1CW/AXh6QzA+ucf8szmUTbn8/7JcoN2/TddhQS2m4Y2pZY0IYqr?=
 =?iso-8859-1?Q?jGFfd2sY2MZ3wIfB4Qxj4YzjTHLxmoGTF6GQ1yNJGvvCwVqy/MlbnD23HY?=
 =?iso-8859-1?Q?dx0o8nEa+tQ6KVNLI2D2PTrdzRFxwULYDOuo71zkWOrYrihrS35x8QLjim?=
 =?iso-8859-1?Q?06g/M/8BnUfoOpAiTS+UOdPg/LPWrozdUVyD5ATsjbn0q99KQz+J+J5+CH?=
 =?iso-8859-1?Q?UaNgaOgFj2Q12YGimQ/c3TdFwXj2GA+ra+BU/MMgxh6gBN5fKK7DK2ZP80?=
 =?iso-8859-1?Q?ptQCcND1nWqnpaLHZ7mXTkG8qZgPfLNsu+PqCoEAVzDgB1dEw/54uuUxiq?=
 =?iso-8859-1?Q?GIeIJdFScwnnZ3IyFSv7ryElcTgNNKO7hhWy0F03EyrzajyVQ1aGrAXWNV?=
 =?iso-8859-1?Q?mjI6XecO9ly7U+bzI0AmJkosekk7mpj9Z0hG0426XAVgPV2fqiQ8kIWFHf?=
 =?iso-8859-1?Q?1YcKFfDUSI4bUD+/ymDIzUcjoitgErISgNIATCthteIbSCaJ9xczsteJtL?=
 =?iso-8859-1?Q?XWsdiM5GBQL8kFl4d/itN6p9XBU8c+1vjcNRtL3gd/XQZq4QQnzL1JNq3x?=
 =?iso-8859-1?Q?ktPm/KpeTwLgOy1lf0VBBC5qDNN3fxwiVi3VHiFAmG2WzWn1YrPN0IRHAf?=
 =?iso-8859-1?Q?H0Zw/o11qjHwG9ybyiap+7cRX20oIeZVVs+LqswQInCeC2lcU/rrzyd3Uk?=
 =?iso-8859-1?Q?ikxbCdUbUt6Q8u98d+yTH2moRA0B5TEgYdaMnjhe1iu3s34dzRVNwu9jUQ?=
 =?iso-8859-1?Q?aQFtuWw4I4+7FS5oku6vNfZNuf4PhrNKpyBe0VP5Z1BSvCdJNV+v+pzNsY?=
 =?iso-8859-1?Q?Fy27r48s4LsRJYla5KX1FhOymr2fWjK9DKHHmIrxbr0hy9FcmbGf2mbIw9?=
 =?iso-8859-1?Q?z7a9yXibz4OLyp/icy6nJO4sBn929VKxI8/31NkJRRRGvJhLf01sdxeksG?=
 =?iso-8859-1?Q?meIZLLxfMYa/LzyNnu52NHd7ENw3et4ZTJh5VeVrZrIhqwPx1SdWrbgtfs?=
 =?iso-8859-1?Q?Lm7Xn+oq7SROgLJPR/yNHanjuydF3fgemgaYeG9rtnOfptzOYsjDLM5B9e?=
 =?iso-8859-1?Q?iyAFsGXi8QdcwbshtivXl7sxdUerCgnZj5rTQjXULKd+DI7XEUQNm/iKGX?=
 =?iso-8859-1?Q?FHAiI4Bu0B8wBF/hxotWa8zMDXnJb81rVyGaOjGok3g8tC?=
Content-Type: multipart/alternative;
 boundary="_000_PH9PR12MB1359218CEB025679B5CDC01B1F9F692PH9PR12MB135921_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH9PR12MB135921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7806242f-47d3-4e00-75e7-08df3952aaa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 02:32:12.2864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wADSggj1oieBHHKUhAiR5W3wMX3FrjbbkmN/Wg+LEq7n+53aHjUbOCajxK4Uw1/rEKHnKeba7VpYvtNax74yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

--_000_PH9PR12MB1359218CEB025679B5CDC01B1F9F692PH9PR12MB135921_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Apologies, please ignore this e-mail.

Regards,
Apurv

________________________________
From: Mishra, Apurv <Apurv.Mishra@amd.com>
Sent: Monday, November 2, 2026 9:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.c=
om>; Welton, Benjamin <Benjamin.Welton@amd.com>; Zhu, James <James.Zhu@amd.=
com>; Tang, Jason (Markham) <Jason.Tang@amd.com>; Mishra, Apurv <Apurv.Mish=
ra@amd.com>
Subject: [PATCH v2] drm/amdkfd: force perfmon clock on for profiler PMC req=
uests

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

Change-Id: I45a76007861d8f322e63bb5b29bf1ef5d7b7e0cb
Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
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
+
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
         void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enabl=
e);
+       /* set the perfmon clock, returns its previous state */
+       bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xc=
c_id,
+                                        bool on);
         int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
                                    struct amdgpu_gfx_shadow_info *shadow_i=
nfo,
                                    bool skip_check);
@@ -500,6 +503,11 @@ struct amdgpu_gfx {
         uint32_t                        gfx_off_residency;  /* last logged=
 residency */
         uint64_t                        gfx_off_entrycount; /* count of ti=
mes GPU has get into GFXOFF state */

+       /* perfmon clock override for profilers */
+       struct mutex                    perfmon_clk_mutex;
+       uint32_t                        perfmon_clk_override_count;
+       unsigned long                   perfmon_clk_restore_mask; /* per XC=
C */
+
         /* pipe reservation */
         struct mutex                    pipe_reserve_mutex;
         DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_C=
OMPUTE_QUEUES);
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device =
*adev,
                                         u8 me_id, u8 pipe_id, u8 queue_id)=
;
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
                 data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
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
                 data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
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
                 WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OV=
ERRIDE, data);
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
         def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGT=
T_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                 data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

         if (def !=3D data)
                 WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OV=
ERRIDE, data);
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

         gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_i=
d);
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,
                 gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_=
id);

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
                         if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_S=
UPPORTED) {
                                 status =3D kfd_ptl_disable_request(pdd, p)=
;
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

                 if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED=
) {
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
--
2.43.0


--_000_PH9PR12MB1359218CEB025679B5CDC01B1F9F692PH9PR12MB135921_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Apologies, please ignore this e-mail.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
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
<b>From:</b> Mishra, Apurv &lt;Apurv.Mishra@amd.com&gt;<br>
<b>Sent:</b> Monday, November 2, 2026 9:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma, Bing &=
lt;Bing.Ma@amd.com&gt;; Welton, Benjamin &lt;Benjamin.Welton@amd.com&gt;; Z=
hu, James &lt;James.Zhu@amd.com&gt;; Tang, Jason (Markham) &lt;Jason.Tang@a=
md.com&gt;; Mishra, Apurv &lt;Apurv.Mishra@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdkfd: force perfmon clock on for profiler =
PMC requests
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Counters and SQ/PC sampling read 0 at DPM A=
UTO on gfx11/gfx12 because<br>
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing<br>
workaround (STABLE_STD) needs root and pins clocks.<br>
<br>
Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the<br>
perfmon clock on per XCC, keeps GFXOFF disallowed while held, and<br>
restores the previous state on last release, resume and reset.<br>
perfmon_clk_mutex serializes it with the GFX clock gating sequences<br>
and the soc21/soc24 stable pstate hook.<br>
<br>
Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU<br>
and under reset_domain-&gt;sem:<br>
- lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.<br>
- lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON needed,<br=
>
&nbsp; held until lock=3D0, perfcount_enable=3D0 or process exit.<br>
<br>
No DPM change, no new ioctl, no struct change. Bump<br>
KFD_IOC_PROFILER_VERSION_NUM to 2.<br>
<br>
v2:<br>
- Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle<br>
- Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold<b=
r>
&nbsp; perfmon_clk_mutex across the GFX clock gating sequences<br>
- Bind the process to the GPU before forcing the perfmon clock on<br>
- Take reset_domain-&gt;sem before profiler_lock<br>
- Release a dispatch-mode hold with lock=3D0, perfcount_enable=3D0<br>
<br>
Change-Id: I45a76007861d8f322e63bb5b29bf1ef5d7b7e0cb<br>
Signed-off-by: Apurv Mishra &lt;Apurv.Mishra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp; | 89 ++++++=
++++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp; | 11 +++<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 28 +=
++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 28 +=
++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c&nbsp;&nbsp;&nbsp;&nbsp; | 28 +=
++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc24.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp; | 63 +++++++++++=
++++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp; | 20 +++++<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 ++-<br>
&nbsp;12 files changed, 261 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 44091ac12fa9..04422c1e1f86 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state=
(adev, AMD_CG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state=
(adev, AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_clk_restore(adev);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_fill_reset_m=
agic(adev);<br>
&nbsp;<br>
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;s=
rbm_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
fx.pipe_reserve_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
fx.gfx_off_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
fx.partition_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;m=
n_lock);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index a6f95ff47d24..c9c4c3d4e88d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_dev=
ice *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_do_off_ctrl(ade=
v, enable, true);<br>
&nbsp;}<br>
&nbsp;<br>
+/*<br>
+ * Force the perfmon clock on, or restore the saved state; @save records t=
he old<br>
+ * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.<br>
+ */<br>
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool force_on, bool save)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, num_xcc =3D NUM_XCC(adev-&gt;g=
fx.xcc_mask);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i++) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool on =3D force_on || test_bit(i, &amp;adev-&gt;gfx.perfmon_cl=
k_restore_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool in_safe_mode =3D adev-&gt;gfx.rlc.in_safe_mode[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool was_on;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!in_safe_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_e=
nter_safe_mode(adev, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; was_on =3D adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev,=
 i, on);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!in_safe_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_e=
xit_safe_mode(adev, i);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (save)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; assign_bit(i, &a=
mp;adev-&gt;gfx.perfmon_clk_restore_mask, was_on);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+/*<br>
+ * Refcounted override that keeps the perfmon clock on for profilers. The =
last<br>
+ * put restores the previous state. Each hold keeps GFXOFF disallowed, as =
a<br>
+ * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can'=
t do it.<br>
+ *<br>
+ * GFXOFF control takes pm.mutex, which clock gating holds around<br>
+ * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.=
<br>
+ */<br>
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || !adev-&g=
t;gfx.funcs ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx=
.funcs-&gt;set_perfmon_clk_override)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;gfx.perfmon_clk_override_count++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfm=
on_clk_program(adev, true, true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (WARN_ON_ONCE(!adev-&gt;gfx=
.perfmon_clk_override_count)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!--adev-&gt;gfx.perfmon_cl=
k_override_count) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_program(adev, false, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enable &amp;&amp; !r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+}<br>
+<br>
+/*<br>
+ * Program the perfmon clock for clock gating. While overridden, only reco=
rd<br>
+ * the state for the final restore. Called with perfmon_clk_mutex held.<br=
>
+ */<br>
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lockdep_assert_held(&amp;adev-&gt;gfx=
.perfmon_clk_mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.perfmon_clk_override=
_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; assign_bit(xcc_id, &amp;adev-&gt;gfx.perfmon_clk_restore_mask, o=
n);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, xcc_id, on=
);<br>
+}<br>
+<br>
+/* Re-apply the override after resume/reset reprogrammed clock gating. */<=
br>
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.funcs || !adev-&gt;=
gfx.funcs-&gt;set_perfmon_clk_override)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.perfmon_clk_override=
_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_program(adev, true, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
+}<br>
+<br>
&nbsp;int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool val=
ue)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index f5fb2e585e8a..1bfd12dd3956 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 queue, u32 vmid, u32 x=
cc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*init_spm_golden)(st=
ruct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_perfmon_mgcg=
)(struct amdgpu_device *adev, bool enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the perfmon clock, returns its=
 previous state */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*set_perfmon_clk_override)(stru=
ct amdgpu_device *adev, int xcc_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool on);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_gfx_shadow_info)=
(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
gfx_shadow_info *shadow_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool skip_chec=
k);<br>
@@ -500,6 +503,11 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_residency;&nbsp; /* l=
ast logged residency */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_entrycount; /* count =
of times GPU has get into GFXOFF state */<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* perfmon clock override for profile=
rs */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; perfmon_clk_mutex;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perfmon_clk_override_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; perfmon_clk_restore_mask; /* per XCC */<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pipe reservation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pipe_reserve_mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u8 me_id, u8 pipe_id, u8 queue_id);<br>
&nbsp;void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);<br=
>
&nbsp;void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool e=
nable);<br>
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enabl=
e);<br>
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id,=
 bool on);<br>
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *v=
alue);<br>
&nbsp;int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_c=
ommon_if *ras_block);<br>
&nbsp;void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_co=
mmon_if *ras_block);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index a7ed4923857b..a01244621fa3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);<br>
&nbsp;static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)=
;<br>
&nbsp;static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool enable);<br>
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&nbsp;<br>
&nbsp;static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uin=
t64_t queue_mask)<br>
&nbsp;{<br>
@@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;=
gfx_v11_0_read_wave_vgprs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp=
;gfx_v11_0_select_me_pipe_q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &=
amp;gfx_v11_0_update_perf_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gf=
x_v11_0_set_perfmon_clk_override,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gfx_shadow_info =3D &=
amp;gfx_v11_0_get_gfx_shadow_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hdp_flush_mask =3D &a=
mp;amdgpu_gfx_get_hdp_flush_mask,<br>
&nbsp;};<br>
@@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu=
_device *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC=
_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);<br>
&nbsp;}<br>
&nbsp;<br>
-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en=
able)<br>
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_=
SUPPORT_GFX_PERF_CLK))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SO=
C15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE=
_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVE=
RRIDE__PERFMON_CLOCK_STATE_MASK);<br>
+}<br>
+<br>
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en=
able)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SU=
PPORT_GFX_PERF_CLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,<br=
>
@@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gatin=
g(struct amdgpu_device *ade<br>
&nbsp;static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RLC_CGTT_MGCG_OVERRIDE is shared w=
ith the perfmon clock override */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_=
mode(adev, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v11_0_update_coarse_gr=
ain_clock_gating(adev, enable);<br>
@@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v11_0_enable_gui_idle_interrupt(adev, enable);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_m=
ode(adev, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index ec1e142549c5..9e754c25b15c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);<br>
&nbsp;static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work)=
;<br>
&nbsp;static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool enable);<br>
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&nbsp;<br>
&nbsp;static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_t queue_mask)<br>
@@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;=
gfx_v12_0_read_wave_vgprs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp=
;gfx_v12_0_select_me_pipe_q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &=
amp;gfx_v12_0_update_perf_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gf=
x_v12_0_set_perfmon_clk_override,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gfx_shadow_info =3D &=
amp;gfx_v12_0_get_gfx_shadow_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hdp_flush_mask =3D &a=
mp;amdgpu_gfx_get_hdp_flush_mask,<br>
&nbsp;};<br>
@@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC=
_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);<br>
&nbsp;}<br>
&nbsp;<br>
-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en=
able)<br>
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_=
SUPPORT_GFX_PERF_CLK))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SO=
C15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE=
_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVE=
RRIDE__PERFMON_CLOCK_STATE_MASK);<br>
+}<br>
+<br>
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en=
able)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SU=
PPORT_GFX_PERF_CLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,<br>
@@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_=
device *adev,<br>
&nbsp;static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RLC_CGTT_MGCG_OVERRIDE is shared w=
ith the perfmon clock override */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_=
mode(adev, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_0_update_coarse_gr=
ain_clock_gating(adev, enable);<br>
@@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v12_0_enable_gui_idle_interrupt(adev, enable);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_m=
ode(adev, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c<br>
index f812d6d81e9c..958b4ad39d9f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
@@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool enable);<br>
&nbsp;static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool enable, int xcc_id);<br>
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&nbsp;static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_devic=
e *adev);<br>
&nbsp;static void gfx_v12_1_xcc_update_medium_grain_clock_gating(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
, bool enable, int xcc_id, bool force);<br>
@@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;=
gfx_v12_1_read_wave_vgprs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp=
;gfx_v12_1_select_me_pipe_q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &=
amp;gfx_v12_1_update_perf_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gf=
x_v12_1_set_perfmon_clk_override,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_xccs_per_xcp =3D &amp=
;gfx_v12_1_get_xccs_per_xcp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ih_node_to_logical_xcc =
=3D &amp;gfx_v12_1_ih_to_xcc_inst,<br>
&nbsp;};<br>
@@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MG=
CG_OVERRIDE, data);<br>
&nbsp;}<br>
&nbsp;<br>
-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool enable, int xcc_id)<br>
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_=
SUPPORT_GFX_PERF_CLK))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SO=
C15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE=
_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MG=
CG_OVERRIDE, data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVE=
RRIDE__PERFMON_CLOCK_STATE_MASK);<br>
+}<br>
+<br>
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool enable, int xcc_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SU=
PPORT_GFX_PERF_CLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable, int xcc_id)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RLC_CGTT_MGCG_OVERRIDE is shared w=
ith the perfmon clock override */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_=
mode(adev, xcc_id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_1_xcc_update_coars=
e_grain_clock_gating(adev, enable, xcc_id);<br>
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable,=
 xcc_id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_m=
ode(adev, xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 599d47e1d38b..ed10c258703c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_dev=
ice *adev)<br>
&nbsp;static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool enter)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enter)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_mode(adev, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu=
_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt=
;update_perfmon_mgcg)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !ent=
er);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c<br>
index 6c8b8ed4a44d..46d746dd37b2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c<br>
@@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_dev=
ice *adev)<br>
&nbsp;static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool enter)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_=
clk_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enter)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_mode(adev, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu=
_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt=
;update_perfmon_mgcg)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !ent=
er);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmo=
n_clk_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 7fcfc150a7fc..e4fb9f5aa3b2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;mute=
x);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D kfd_process_device=
_data_by_id(p, gpu_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind for the runtime PM reference =
before programming the perfmon clock */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd &amp;&amp; op =3D=3D 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd =3D kfd_bind_process_to_device(pdd-&gt;dev, p);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mu=
tex);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(pdd))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return PTR_ERR(pdd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd || !pdd-&gt;dev |=
| !pdd-&gt;dev-&gt;kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd =3D pdd-&gt;dev-&gt;kf=
d;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptl =3D &amp;pdd-&gt;dev-&=
gt;adev-&gt;psp.ptl;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Before profiler_lock, which reset =
takes in kfd_resume() */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;kfd-&gt;adev-&gt;reset=
_domain-&gt;sem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd-&gt;pr=
ofiler_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;profiler_process) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;profiler_process =3D p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfm=
on_clk_override(kfd-&gt;adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; statu=
s =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex=
_unlock(&amp;kfd-&gt;profiler_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;kfd=
-&gt;adev-&gt;reset_domain-&gt;sem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p=
tl-&gt;hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D kfd_ptl_disable_reque=
st(pdd, p);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D 0)<br>
@@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_pro=
cess *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (op =3D=3D 0 &am=
p;&amp; kfd-&gt;profiler_process =3D=3D p) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd-&gt;profiler_process =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd-&gt;profiler_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ptl-&gt;hw_supported_state =3D=3D AMDGPU_PTL_HW_S=
UPPORTED) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; statu=
s =3D kfd_ptl_disable_release(pdd, p);<br>
@@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd-&gt;=
profiler_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;kfd-&gt;adev-&gt;reset_d=
omain-&gt;sem);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&nbsp;}<br>
&nbsp;<br>
+/*<br>
+ * Take or drop this process's dispatch-mode perfmon clock hold. Taking it=
 again<br>
+ * is a no-op. Dropping returns -ENOENT without a hold, and for the device=
 lock<br>
+ * holder, whose lock =3D=3D 0 must still unlock.<br>
+ */<br>
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D kfd_process_device_data_by_id=
(p, gpu_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind for the runtime PM reference =
before programming the perfmon clock */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd &amp;&amp; enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd =3D kfd_bind_process_to_device(pdd-&gt;dev, p);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(pdd))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return PTR_ERR(pdd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd || !pdd-&gt;dev || !pdd-&gt;=
dev-&gt;kfd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd =3D pdd-&gt;dev-&gt;kfd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Before profiler_lock, which reset =
takes in kfd_resume() */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;kfd-&gt;adev-&gt;reset=
_domain-&gt;sem);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd-&gt;profiler_lock=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enable &amp;&amp; (!pdd-&gt;perf=
mon_clk_req || kfd-&gt;profiler_process =3D=3D p))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ENOENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (pdd-&gt;perfmon_clk_req !=3D=
 enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd-&gt;perfmon_clk_req =3D enable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd-&gt;profiler_lo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;kfd-&gt;adev-&gt;reset_d=
omain-&gt;sem);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+}<br>
+<br>
&nbsp;static inline int kfd_profiler_pmc(struct kfd_process *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioc=
tl_pmc_settings *args)<br>
&nbsp;{<br>
@@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_proces=
s *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_queue_manage=
r *dqm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!args-&gt;lock) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON ne=
eded */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (args-&gt;perfcount_enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return kfd_profi=
ler_perfmon_clk(p, args-&gt;gpu_id, true);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Drop a dispatch-mode hold if there is one, else unlock as bef=
ore */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, false))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if we have the co=
rrect permissions. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!perfmon_capable())<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index d8631847f0eb..32c3c23d6d14 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -886,6 +886,8 @@ struct kfd_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates this process =
has requested PTL stay disabled */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ptl_disable_req;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Holds a dispatch-mode perfmon cloc=
k override until released or exit */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool perfmon_clk_req;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)=
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index dd938788bdd9..7ba1c4ab283b 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(st=
ruct kfd_process *p)<br>
&nbsp;<br>
&nbsp;static void kfd_process_profiler_release(struct kfd_process *p, struc=
t kfd_process_device *pdd)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D pdd-&g=
t;dev-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int puts =3D 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pdd-&gt;de=
v-&gt;kfd-&gt;profiler_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd-&g=
t;profiler_process =3D=3D p) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.dqm-&gt;ops.set_perfcount(pdd-&gt;qpd.dqm=
, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;kfd-&gt;profiler_process =3D NULL;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; puts++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;perfmon_clk_req) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd-&gt;perfmon_clk_req =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; puts++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;=
dev-&gt;kfd-&gt;profiler_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Nothing is held on the kfd_cr=
eate_process() error path, which holds<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * kfd_processes_mutex and so mu=
st not wait for a reset.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!puts)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;adev-&gt;reset_domain-=
&gt;sem);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (puts--)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_perfmon_clk_override(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&g=
t;sem);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void kfd_process_destroy_pdds(struct kfd_process *p)<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index 749d196e2114..34f3ffaf1c66 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;};<br>
&nbsp;<br>
-#define KFD_IOC_PROFILER_VERSION_NUM 1<br>
+/*<br>
+ * KFD_IOC_PROFILER_VERSION_NUM history:<br>
+ * - 1 - initial version<br>
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until =
the<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock is released or the process exi=
ts. lock =3D=3D 0 with<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perfcount_enable =3D=3D 1 forces it=
 on without CAP_PERFMON and without<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locking, until lock =3D=3D 0 with p=
erfcount_enable =3D=3D 0 or the process<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exits<br>
+ */<br>
+#define KFD_IOC_PROFILER_VERSION_NUM 2<br>
&nbsp;enum kfd_profiler_ops {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_PROFILER_PMC =3D 0=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_PROFILER_VERSION =
=3D 2,<br>
--<br>
2.43.0<br>
<br>
</div>
</body>
</html>

--_000_PH9PR12MB1359218CEB025679B5CDC01B1F9F692PH9PR12MB135921_--
