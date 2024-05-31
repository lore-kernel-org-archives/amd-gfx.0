Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56364C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 12:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33BD10E0DA;
	Fri, 31 May 2024 12:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2eMEZjw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A267710E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 12:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS/x37MATOEd+GYr0eF4DHHMILamh41t+/z5O54NDnUiuiuNS0y4o3mU39DjwXOJZTCGKxoSk4OGOAeNTqe6oUR60J8joT/Ckei/GZQlb+48eNtGeRtf8gR0ccHuBgyZWEX8qAuaI0Il6tbCXh2cR6W6Wpz9f7V1MMBTvpakC2IjhHuJJlL1K0v8XR0ydQvWYDLIBGYUk8XlvqQ3nf/MrYjAvFzQ5YtNwh8d7GWOkG3O6JICDb/r9UTqRTI5WH9odAO5/3rUf5Go4jnCK9nZ1R+JRJKfeDTauL/JSCpkd3nOe0A17OOOSJOUJ60T+uRM41UqlyLK7nBw4wBPpJElFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sj8gGbnP2ZiqlhsWKMykPT3QXpuf11EMbztrjZx76k=;
 b=WlVKYpzcKm7YJbsZRacyhgqwJNvGGLMtBU/Q045cqa2PMj3ePu690DtsijJ2W5QMEhzwfL2tRf5i5K5mt8TWoQT8hKrXlAWvxLgBVZ9aRlZ60cZbBsi34z21RdCKCzLg8GuYyGkW7b0VnoAjNgtPcqvlrG+beFJmHHdUZtNGLNCtuxtQ2pz2R9EsQBxULDJfkIkUioYQuUwLjGj4TEou1pSoSGAc6hqwgPtQp9NDMxl6VJdXbQlJ7B6mfVatdKM8lETMcgHMcus1sSl5iPa2FLW9MyUTfO981N6n0GiTBgUabpwE9NnHdYfgbkp+Ee/6yLWDLugFclYsuTqPeMuM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sj8gGbnP2ZiqlhsWKMykPT3QXpuf11EMbztrjZx76k=;
 b=d2eMEZjwSNrKUmmcQCUciBz7906OABNG8eGItr0BNhoxi9/urp7syracldcUvnFZb7STzE0KmAsH/VPIqTkmK/MMBZOY8IIWJy70Nb9RzNngdjC5voG3zfBj+U1ZhWNXAC4rfQ5b5PRszbMa3QntjzKQLBxoXA6OL29IvbTI6xg=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 12:47:27 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%6]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 12:47:27 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip coredump during resets for debug
Thread-Topic: [PATCH] drm/amdgpu: Skip coredump during resets for debug
Thread-Index: AQHas1bmJjMMmsY1tkm/2DhWQxK81bGxSqhw
Date: Fri, 31 May 2024 12:47:27 +0000
Message-ID: <DS7PR12MB607162D6CBE0657A71CC02EE8EFC2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240531123403.978597-1-lijo.lazar@amd.com>
In-Reply-To: <20240531123403.978597-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8cb71bc6-8106-4c9b-872c-702e85edc0d4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T12:47:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH0PR12MB7790:EE_
x-ms-office365-filtering-correlation-id: 3b24b327-6ec5-4b17-4440-08dc816fd3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?XPPqQscSztvmzb+R1sPvX48opdgehl2kC3a3Vm/PSrC7lceCCHhbFis+Huh6?=
 =?us-ascii?Q?5Mv1+ddyHHQ5Y/+sFYX6/koCuFY7dfAB5H3aINdS3uLpmIn9lBPQznTZ5Gsv?=
 =?us-ascii?Q?UW3g3JFYStr+FKhp5OSFqSfngEur/IQPr3fDKLiYzHmzRivmvzEFGVkQOj2C?=
 =?us-ascii?Q?B4EqRhrEprQ+iIUroEn+BxBnOu4bE71Xh1GzM33eTFq2VeAtBXBcfczQW9A4?=
 =?us-ascii?Q?KACGI0OzgZF1E/foSMH+cY7WKRaURJZDXshvkXbvJcEfMJdhNOAAqSPr7Dnp?=
 =?us-ascii?Q?YL1OBim+PESeQHmtZxVvN8o3FxOhy8gxuJN7DtMn9o1a88mJWs11lUNw8vY8?=
 =?us-ascii?Q?R207NRhZgSAufvL5jQaQCJFOkbeBBjwuNoIoEk9VtruTXg6kcgnydravD/5b?=
 =?us-ascii?Q?U9PYYAUEckVZrFDQw9uyl6x9TGnxxhcGe5DuDdaF/1zf1qhWtUaTwSa7XwqE?=
 =?us-ascii?Q?j+e+QWDdXL2x4/ha1Y7CusxAUBCXs2waLiXexHVx86GPgrhOacyw2t7C0d0g?=
 =?us-ascii?Q?oqADbvAJ4COccx2SB8h9PR3MltuKYkB0tyFIumAYwvkSlocNwRU51sozCIJT?=
 =?us-ascii?Q?YXWIK263bLa0r8dzgs+FdnDAqqKwof6gV7Xsv17DFVLUXiclyJpi7cvKw3SB?=
 =?us-ascii?Q?2AgnvGNoQ4bjhVPqTN0o/UR6dbHhvvkkK27DnjSyXyp88r8QC0rzdI3eCiUW?=
 =?us-ascii?Q?u7LKDj1JqGfLHsG5aIvxqPFOyC34R1WMTWUol4R9Uape2tkR36uSkBXhz0iY?=
 =?us-ascii?Q?Sh53ZSUhdFUQZp1yVqezrRUj+Ei5p02RDoE86zDU3ABTnoonFNarh3ooeqRf?=
 =?us-ascii?Q?qfI0V7AXrp8CIUGG1OrTSbPF4jtS7sKO206qMvJszkjfBCpKAM2Wv2/cU04i?=
 =?us-ascii?Q?Zj7u0eqkGPlibx0G7rrj2/6okJk0nnG9KAqVl5gVUOV/LcGI9Uac5emQZzvz?=
 =?us-ascii?Q?Bau+6ijWbiuQ0dF7lRTy55/q9BDvuyLb77+4tn0Aq6SYKTpKxu9LgrI4Qo+F?=
 =?us-ascii?Q?aDbF5Biu4PNGKB6k0PN0lVoNwBh6rpP4KcWLoFqx1JjN3/pYrgmwMfPMZqwm?=
 =?us-ascii?Q?R8eMwjIwCJRn2B3qPJFc1FCKwHb35irHUx4v7vGDVgQ4oXjGhwKs7hOinRYA?=
 =?us-ascii?Q?SrHnw553haeoQuVD6/8CdT4GuiIIw+Ktm9ObdlilmVr82UCAQJYe+v9E1PEo?=
 =?us-ascii?Q?wpHAZGHvo0rC9eHovGm50Ohbpx78KMStIVKvXZa5awmQ/XXPOPpPNYLdG0QD?=
 =?us-ascii?Q?uFkUjQEAgrvATj9l12kqWLs/5t5lOBNqAbuQgcBSwKtL8nZhz51L+BKRZ7bV?=
 =?us-ascii?Q?CU5dsfcxcGtoNUw3gPp2+eZ9saFT2NsEqRfFozRB17xNdA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UixFWf++7Mi9NCpFrO0BAL3keTZ3P6L5FYk+pcs4ny3fR2elnbudscATBC2n?=
 =?us-ascii?Q?6Gc+rMJUyR+C31i09yYHMP4XhdRYnxGp9x9erC6GF5xhDq+VgtK94kZSfVcx?=
 =?us-ascii?Q?GxTnnGIAWl7L5t8u46UzjyUKtVl7zXNyNp6iIhMKE8bwkyKllPsgzk3lzKUi?=
 =?us-ascii?Q?IKN9yXPve3AMFI6bfMBylle5u3bAGtvdwHCoQOT6SwcIreq78YzAkqd2jJwm?=
 =?us-ascii?Q?MPAnMhCQONGdO2lSIxcqM5D+AzKToVD2ChemqLr9r6XVSqXU+gUOfCAKrplc?=
 =?us-ascii?Q?qefnVAlgwM6Vi9UKRuhUufRz5VFOieyR+v6t3G9y6YgPoduULGt7WZzaQakm?=
 =?us-ascii?Q?QDH8nh8RqbLjbHyYy6+PmSdumMdC2n1eELAv0cdFBvJYsyggTcxAfL3FkLPA?=
 =?us-ascii?Q?c/y8crt4H4cpgWReKgP1VaOM55h+wf2JQkZhB4LsAM16ttjok5Ux0kt0LPsp?=
 =?us-ascii?Q?j2mCscS6yw+Y1RuyiPJedi3ZaQXMB6dJKmTV2KaxdwIjdKRoGHtUdxmutks2?=
 =?us-ascii?Q?n6TN/V8w6Xnu3lkT6sxBdRlYJz2na5G1C2Pyli6PuUfsRT4dfILO0YcHlBTD?=
 =?us-ascii?Q?8ZcAnPonK8gIAYlbhnKDsnHTGiHzS19JvvG0re3U9DrI8TdMbtfaZr2hpJZL?=
 =?us-ascii?Q?5zDDhPRwnzMyd0+hJnM79wJOn+0GouVU+s8oNnecfubaUlCxz9Xj6n7ra+GN?=
 =?us-ascii?Q?R3rAYw+oLtdW+p7x86E2lCEJo4mHGcdzN/jq8KXMg3syA4o7P7eRjQpCfFvM?=
 =?us-ascii?Q?It+JcdxldUfWMDvCDuxb7FwbqP6B75UZtW7yVNgUkWNpQgEA8O12aIdsQ9Ic?=
 =?us-ascii?Q?pv2zLrKq9cbyRonvtiT2jGIWpMOR/gHQGjauqeiMK0wK94WUKDcHM3sWRetl?=
 =?us-ascii?Q?Kf6q20zKB2MS1nHHq9Vh5w/E/bijufm/k5tnn67fV4xOl/FwBtChtH2TCRVT?=
 =?us-ascii?Q?BEo2zQmszocm8lJL8QrnhNp3eNHyHxWn+P9Y/jp8tTOBZyzDFCRxu9RR6PIA?=
 =?us-ascii?Q?g1/Iqp17Zgetp932FP+tvAxlPhLsSi4ZILnrVpGF84f64ty8IkZW1dz8bVxG?=
 =?us-ascii?Q?0CYv6QxqJ5tU8/2YlVVi3ohO+KUePHYy/FntkjsH3cKgw800YsXcQypbDIu/?=
 =?us-ascii?Q?QlN1yRrhybfWw7PCuG3k1bPNsLix7N1ReJpwMtjRnHx8gTLDVPO4/8r4/KpT?=
 =?us-ascii?Q?X3ZWpkEO+jj0UTUZmHnpBBavBsCF+HnsTVhN9OdQepaVSbRAv7OmaJT2Gg77?=
 =?us-ascii?Q?FRI782ZbSZyrZewa6HLWH6GUNdID7pUAgnd0ZayJY4YqYgjQgcnNccBjpzPf?=
 =?us-ascii?Q?KtmUZTqfCqFpRz8SOXP8aSTJfYoZ0JbnpT8PSAoqkp6lbTwzod9pVV1HgUuS?=
 =?us-ascii?Q?ZS3hfJWTz9fjMuL5b65dLfa7+iAfhAX6ZAyKAq4/2RmbRwfcKZsabXAd3pnZ?=
 =?us-ascii?Q?Jk1gHViuTnTd3XkBHz9hi51T5Zig2QfQK2GWAE8WdAYG+GIK+kyy7ms6wiyy?=
 =?us-ascii?Q?pGzaqv0pa816N2kF1NCyD7Kb71U9CLu7U6Y2VX5NtzKyzUUlcfIZH8NjfymX?=
 =?us-ascii?Q?anvIx1TC7w3KBwR/tKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b24b327-6ec5-4b17-4440-08dc816fd3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 12:47:27.1377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkHKUdJmW/nSyl+bxBlyH/3teIFXmIJWKdzn19iY0e4TqP3sp2d3JRbPVS57aEt1NxmQw6mR8NfgvByl2kNjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, May 31, 2024 6:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Khatri, Suni=
l <Sunil.Khatri@amd.com>
Subject: [PATCH] drm/amdgpu: Skip coredump during resets for debug

Skip scheduling coredump when gpu reset is intentionally triggered through =
debugfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 10832b470448..1a9fda1d20fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -981,6 +981,7 @@ static void amdgpu_debugfs_reset_work(struct work_struc=
t *work)
        reset_context.method =3D AMD_RESET_METHOD_NONE;
        reset_context.reset_req_dev =3D adev;
        set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+       set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);

        amdgpu_device_gpu_recover(adev, NULL, &reset_context);  }
--
2.25.1

