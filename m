Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566B8D25923
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 03:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C7B10E004;
	Tue, 27 Jan 2026 03:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8Sq8glt";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1949610E004
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmV1KJfePtB5U90/32L034/QzgPNk3LDp1PpZXUlu+RTzHGfTu649i18vpuaGdzws9dOF9FOnHaRx7+XDr3LKF77lujZYRkSUXq3pzFjGFWjg1lykKufuM6hpJRPNbZJt6HTJMHXh9dvuGgTwvs1eZE4fX+/P+x7AUtmLf16iRFKDe/H1eHkPaObC0viU1yYnFQd1RNShZyDODyxtEOErept7JwwoMifYM1rINAWl3UTiIMH/DOE/j1CSEFyMf5j5XxqTfCCBA3eG60cPRbOHSSSGhEqu6v5RUfLdAqjAqALYtTcaiW4NPgV5Roe+kWMgCpFddfryecJPAJe4UCuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gPQBCkLTsHsYoKBx5JMtrYo7z2kNB4L6Rwi6c1g/1M=;
 b=uK/lGcyBk4n7VIr6sMXTEMrTlE2wV4HBEZDPWybuKtjclnS0TulYYElV2q0aBtYKqyREp8NkIG59vtQw4uS0dHjjgNj0o5hUfa4WF1K6R3xoOSQPoDmnTI3CiFD89xUNEbN1qQ4cG/7d5jHKxqPu9IwtvhDAXV7GhywHiCJmn3HqvDLokp8mN2yt0peAUDLMONSr+FSDfcDNKbcRJVKPlv2D0TaV6ZbHVDDBzpoU8R10XyORQ7WZn69Ouyr3xKuIA7+HhTa245Jz/+mTFAwP5SrLaqcEyVqVmhz65i92JVkbZPkhNagfiS9XpSTS03i+z+RhZURl/aqP9VTP2+Sz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gPQBCkLTsHsYoKBx5JMtrYo7z2kNB4L6Rwi6c1g/1M=;
 b=j8Sq8glthIfPqtuIVTso+9klIl0dZje3d5Je1hN/wJh4NkLb/E6LBb74QkWi4PhO/u5PyNg8cJLvqhC7AwGQV+DhhJSAXKMV7GfbVPwYSR+FM9/nhCerPQNJFo86NLm15th6f56NhSgcaNRToRveiciQ8qs+heaApzMBzdulLsY=
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 27 Jan
 2026 03:12:05 +0000
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8]) by SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8%4]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 03:12:05 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Jin, Jason(Yong)" <JasonYong.Jin@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
Thread-Topic: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
Thread-Index: AQHci3TUDaoCSodV3EGyLED2DvG7Gw==
Date: Tue, 27 Jan 2026 03:12:04 +0000
Message-ID: <SJ0PR12MB69035C332189D35E4D5A81C6F797A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-27T03:12:05.6300000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6903:EE_|CY5PR12MB6132:EE_
x-ms-office365-filtering-correlation-id: 29ba01e6-4920-4896-b12d-08de5d51d923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iXaLdiofiMQ5AvT/LcD6MWYVtfKpEKQwp+lAlPvnT0qjepx6juiR6mhiSO?=
 =?iso-8859-1?Q?JydwrAK0g3qMxFe9rPQomG46ulum94ZxtA3IRBaxqwNehCV9CP2/NSyP5S?=
 =?iso-8859-1?Q?gzzT+/m4i+sTyk32ufS5DcDO9GZk583k/+nIKdIElGVW5lxDkRqnPb7BpS?=
 =?iso-8859-1?Q?yMSnSrwy/yXPGvpsZmofUzNAyLzzykaoxFGY0NOEejegpxIOCy0lZhBScp?=
 =?iso-8859-1?Q?MHhq8teQRwbGWPC3qEdw8VFP1jZBNiRzuK/pMI4XWRIAmUbO0A/R+Vzrb2?=
 =?iso-8859-1?Q?8MsbUjI2k8amWdhsV4Xi2EXPcyf8+3AB+LxvZulrQYjvi36zadH562IwKY?=
 =?iso-8859-1?Q?NheNyQhxN9hdTG6YDeS+rEbHc4Z97rTFonbs8E4WpHZJcb8K37jo7BsWjz?=
 =?iso-8859-1?Q?494ZzaApiL906uasWbbidpatc4VQeXlPAYvySwRm4BXZGg+wJ3Nd46fM4T?=
 =?iso-8859-1?Q?vnE1EAPqrpLM2+AtHMdit5FIsJk58iaUDAAnn9UjVtLdWOMTACE9DpTpxT?=
 =?iso-8859-1?Q?xXSsIaw7gXZnBvqs+DL9bd7eTVVRJJB0qcYOK8Z6Ty+Ir61TEhbQdUsyqu?=
 =?iso-8859-1?Q?iv5x6CYdzF5npMyHN1GGMNGrY6j4I5iFblOeJ2U3lorqHdlFuAkUqxz4QU?=
 =?iso-8859-1?Q?4CvxAJL2TlE9jDIB0pFeF1KSpalHRTBZiFogqtxUNEjmdUE2UYwjJGG5Zg?=
 =?iso-8859-1?Q?f1ACIdYPTN3Y35WLWL2KJkaNIJQbE7ihRZde/zNN+7fzAr/JTuPadYy6Sz?=
 =?iso-8859-1?Q?hrw7IdmH1/H6bIsef0md+Wix4I+r8L+Up6fO+UV4Sa4VS+4ysE1jm+0m1S?=
 =?iso-8859-1?Q?/28+ui8Ygg9h7I3KfsCGbriwo/u1Dk8R+mJ6dnWP2GkzlcR2i9Mw0xVYmm?=
 =?iso-8859-1?Q?QqfuolNOV6RCohXeOVxXSQZBeQ+miRJrov8SdhZ3xc7QtHRwDQtC+pAkuM?=
 =?iso-8859-1?Q?jEFVTQCSkn5JC2S5Va2d51C/ZFIC9TUcuHCmzlx3l9lxLp41p8oJHzwRHK?=
 =?iso-8859-1?Q?3mdPeTyCwjBMlnufdBSW1WoR/sp9PEXS7XhKer74b+oH35Bg/L+9taj24w?=
 =?iso-8859-1?Q?9wu94GYqkcjIBgtTDlwZISX4DUtVo3xq+53lTfsoYFacT984bo+VuLmA7j?=
 =?iso-8859-1?Q?UuI2yuCyfWmsSzGTzODdbvX02RaXMSHV4Mu+y5fPHksZF4NF3NekJ2DkMh?=
 =?iso-8859-1?Q?5/euK1Qq/FjtVFO5i0l1PGSLLDeXfEyeBh88PYUTdUWfS//EsdpVyPps8d?=
 =?iso-8859-1?Q?DXb5/aqHPCks83pffY93lU6O9QKne9QRJhYFS4biqActhVEL9gGoUZ9SPq?=
 =?iso-8859-1?Q?3m3IkLQqxGX+0iqo+0+Xh34TM6Q1NWm01pctT/iPkJzvqzSrH1L4EjJxT7?=
 =?iso-8859-1?Q?Zb6Wgm3l30itKzvkC7leTSPQSfSWDes9eOvlhmgJu1jY8i25fkhThkj0vq?=
 =?iso-8859-1?Q?uoClevLb9jYuWMj118Oo2FC1S/KwFIXuuY/srt8LGQIn8JPFfCyQFk3tgy?=
 =?iso-8859-1?Q?Toep8id3OB4/X7sNPdLY9Kl0cXaA9MaYuIEuONVZFUEnPdhJs7WJzuzmwu?=
 =?iso-8859-1?Q?68bt8T32fld9s77qrBj2OFFmytiWIg/n++0HgRSSK/0ykgsQzKoQ8dnkr0?=
 =?iso-8859-1?Q?m8Va0/ksBj512GFMb+/kVC3cAoNWC6HydUF1TQz3ykoHjUEFJGOQfX65b8?=
 =?iso-8859-1?Q?GWFovoSb9F9Uk/Zhem0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6903.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xnxC8qozHIhVGDEDL4vTw1BnD9Y3Ak7daB2ID3Q840uwsIVkgGpjWU7vOe?=
 =?iso-8859-1?Q?qb3Io5CzmannxDGCbtZvVbUff/gwcr3GYrnRIr09HnNnUyTJEx1KqwYRHw?=
 =?iso-8859-1?Q?1On1X//vJwi/Wntd62P36NySH8q4BdLiFGb9U1bj+tvIy5Aj8/pCiWLeUH?=
 =?iso-8859-1?Q?aGZgkqHREGLelKrM9l/6hr8EwcmfGgF4l05c+JosLWO7fDDVQ9Xo57xqqS?=
 =?iso-8859-1?Q?0IvDXQDRkWGU12xr0x2CvwA86ZFSCIUZ8eKfLRRF2eKccXWqm147Lf3NWq?=
 =?iso-8859-1?Q?G5DKriTMF1K9XamzTxn03WRgbBiIda8Vn2ej9B733bfF5bv8Sqtz2twcJE?=
 =?iso-8859-1?Q?LUhlbaOi+MH5wPniSwS1LUxGd7NcoAn3u/EKjG/68U1iIzRqoIKyLmIRFk?=
 =?iso-8859-1?Q?hFkIsG19ckwd3+b1iR726wzS1Ixl09yvX+li7huhKtHk4OkDIcTddVdJTa?=
 =?iso-8859-1?Q?B2KG76wC8xAqEvHKdOVi43T5Vhi2jI3yvYkKozeuC5YICMbNphNTK1u/uE?=
 =?iso-8859-1?Q?TeRic+JSA3qb/Kik5DXmi8wDjsql+m4drWP973vN10LdX7oLMC+qwYe3Hc?=
 =?iso-8859-1?Q?xVHDMGIMGrHqGcSMeLoITlGTUWiQp1RTeB1iZUiZDiYSl7TF3KYWYr89mM?=
 =?iso-8859-1?Q?sXR8Z7dpp2xL/P5H/9KyApYtKYR+nWcqIZbZ4bep88tiRMDXZ7EhlvAmqF?=
 =?iso-8859-1?Q?YCXa1VtUcdWP9RWJ37nsDVbzbc1ARzMnL3yNKAK2QMbaZukRZBq3caFdxv?=
 =?iso-8859-1?Q?0t3v++02NsQ2w1oqKZteF0PMNs+1JjE1iEeKL+XXOsxClkCjOPnvwk3uCy?=
 =?iso-8859-1?Q?Ut0sCn7TaiMKMewrU38w5dV7yV4Hlu+Ps1Dbmq/5g5RhCz/lNwG+9etLof?=
 =?iso-8859-1?Q?56QmY1tNNKjBelf6OrxLY2csQ+6O95F3kupaDzDc2PAfcRsRf1K8MHOsO4?=
 =?iso-8859-1?Q?axPgoa+Xz08X/4irX3gvosqQbFoG9ggDISelAh/cHRq8Fnceki5F/Bm92D?=
 =?iso-8859-1?Q?KM+Gqb9xqP0u+yY9DdOjepsdUQ5qxvgqbXsDRj6HRaq2z/JzGU6ESQuJ6r?=
 =?iso-8859-1?Q?PYcj3Oa6nKvyChcTmWjdGrDxMKDNhwenZO+9kjwyBjNmA6B/vQ5XbBVDLS?=
 =?iso-8859-1?Q?UGvhYyvPk5ZZa4Fq8Y6c5X7a2x9ky+V25zduWdGW4odzOF+otRCOlR7Xyb?=
 =?iso-8859-1?Q?NZ8Swd4wZCm85HHN0KUrE6J3iVuMlEPvNYxk2dk8QXrDHyekr2PjrvOLhv?=
 =?iso-8859-1?Q?cBOoj53P3s//x0IMcSc85h1Bo7nuQf8la6PZNJ0oQspVAoQcsNmCYZHSOE?=
 =?iso-8859-1?Q?xc+F7KO+yQKaqUM0ooEp4lpbdfHBzmG7Zr7ldCMmAt1a3/4maRWhr8BJrQ?=
 =?iso-8859-1?Q?CFz2472wAxEsU3P1Dy7ftCID3fxLyrYK8WwZy0Ya4XjaaqpHHP0wcxgBSm?=
 =?iso-8859-1?Q?mRiSJTzV4HJ3K62qhHmS8b3uuNvfMmAmU1V8xawAbgT6HZEz2b+sY1+rG3?=
 =?iso-8859-1?Q?PoAd6NWlHpXs9B2W79KhndrixN+6I8cDujAi0Mh7pn80SltbXMGQpAP/UR?=
 =?iso-8859-1?Q?pp8T7eKBzhFQCAJ/mGFIZRF3SUODnWLZnFdRcpyPSse7HGHeIZfhQIFFsV?=
 =?iso-8859-1?Q?DcIHi7IYLQnLTyauLawkQEF80KeFEYlPnUKl/osbWSGPf4BoVCFvHlTNBW?=
 =?iso-8859-1?Q?7O8ubalLbH2v27ziTIOeqDNrFvUEjuALOOx3pcZ/W2Jv6jTb3kc44giXl+?=
 =?iso-8859-1?Q?4gCLQ5KzL/xtkeeikoJYDSLCk5haw9FO+1C3Vuawkr3TVJ?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69035C332189D35E4D5A81C6F797ASJ0PR12MB6903namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ba01e6-4920-4896-b12d-08de5d51d923
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 03:12:04.9599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSP5wuIfYoJ2+lVr7EiT5T9gImAGyPxo8CO10QtuNYaLfo8e6/4l/QCORbyL4vg9mrGXeVjs66gU0eq/tGdW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

--_000_SJ0PR12MB69035C332189D35E4D5A81C6F797ASJ0PR12MB6903namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

When a bo_list handle was reused across multi command submission, reusing
of those allocated HMM range structure can avoid redundant allocate/free
operations on each submission.
Doing this way benefits the amdgpu_cs_parser_bos time, especially for
large bo_list

Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h     |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_bo_list.c
index 66fb37b64388..9c662369d292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)
                           refcount);
    struct amdgpu_bo_list_entry *e;

-   amdgpu_bo_list_for_each_entry(e, list)
+   amdgpu_bo_list_for_each_entry(e, list) {
+       amdgpu_hmm_range_free(e->range);
        amdgpu_bo_unref(&e->bo);
+   }
    call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index ecdfe6cb36cc..fc195fa2c0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,
        bool userpage_invalidated =3D false;
        struct amdgpu_bo *bo =3D e->bo;

-       e->range =3D amdgpu_hmm_range_alloc(NULL);
-       if (unlikely(!e->range))
-           return -ENOMEM;
+       if (!e->range) {
+           e->range =3D amdgpu_hmm_range_alloc(NULL);
+           if (unlikely(!e->range))
+               return -ENOMEM;
+       } else {
+           amdgpu_hmm_range_reset(e->range);
+       }

        r =3D amdgpu_ttm_tt_get_user_pages(bo, e->range);
        if (r)
@@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser=
 *p,

 out_free_user_pages:
    amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-       amdgpu_hmm_range_free(e->range);
-       e->range =3D NULL;
+       amdgpu_hmm_range_reset(e->range);
    }
    mutex_unlock(&p->bo_list->bo_list_mutex);
    return r;
@@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *=
p,
    r =3D 0;
    amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
        r |=3D !amdgpu_hmm_range_valid(e->range);
-       amdgpu_hmm_range_free(e->range);
-       e->range =3D NULL;
+       amdgpu_hmm_range_reset(e->range);
    }
    if (r) {
        r =3D -EAGAIN;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hmm.c
index 90d26d820bac..5b72ea5a3db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct=
 amdgpu_bo *bo)
    return range;
 }

+/**
+ * amdgpu_hmm_range_reset - reset an AMDGPU HMM range
+ * @range: pointer to the range object to reset
+ *
+ * Free the hmm_pfns associated with range, but keep the allocated struct =
range
+ * for reuse, in order to avoid repeated allocation/free overhead when the=
 same
+ * bo_list handle reused across multiple command submissions.
+ *
+ * Return: void
+ */
+void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)
+{
+   if (!range)
+       return;
+
+   kvfree(range->hmm_range.hmm_pfns);
+   range->hmm_range.hmm_pfns =3D NULL;
+}
+
 /**
  * amdgpu_hmm_range_free - release an AMDGPU HMM range
  * @range: pointer to the range object to free
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hmm.h
index 140bc9cd57b4..558f3f22c617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifi=
er *notifier,
 #if defined(CONFIG_HMM_MIRROR)
 bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
 struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
+void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);
 void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
 int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
 void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
@@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_range_a=
lloc(struct amdgpu_bo *
    return NULL;
 }

+static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range) =
{}
 static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range) {=
}
 #endif

--
2.43.0

--_000_SJ0PR12MB69035C332189D35E4D5A81C6F797ASJ0PR12MB6903namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
When a bo_list handle was reused across multi command submission, reusing</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
of those allocated HMM range structure can avoid redundant allocate/free</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
operations on each submission.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Doing this way benefits the amdgpu_cs_parser_bos time, especially for</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
large bo_list</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Signed-off-by: Wang, Beyond &lt;Wang.Beyond@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | &nbsp;4 +++-</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c &nbsp; &nbsp; &nbsp;| 16 +++++=
++++-------</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c &nbsp; &nbsp; | 19 ++++++++++=
+++++++++</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h &nbsp; &nbsp; | &nbsp;2 ++</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;4 files changed, 33 insertions(+), 8 deletions(-)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_bo_list.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 66fb37b64388..9c662369d292 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;refcount);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; struct amdgpu_bo_list_entry *e;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; amdgpu_bo_list_for_each_entry(e, list)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; amdgpu_bo_list_for_each_entry(e, list) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_bo_unref(&amp;e-&gt;bo);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; call_rcu(&amp;list-&gt;rhead, amdgpu_bo_list_free_rcu);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index ecdfe6cb36cc..fc195fa2c0c0 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; bool userpage_invalidated =3D false;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_bo *bo =3D e-&gt;bo;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; e-&gt;range =3D amdgpu_hmm_range_alloc(NULL);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; if (unlikely(!e-&gt;range))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; if (!e-&gt;range) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e-&gt;range =3D amdgpu_hmm_range_alloc=
(NULL);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (unlikely(!e-&gt;range))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; } else {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;range);</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; r =3D amdgpu_ttm_tt_get_user_pages(bo, e-&gt;ra=
nge);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser=
 *p,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;out_free_user_pages:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;bo_list) {</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; e-&gt;range =3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; mutex_unlock(&amp;p-&gt;bo_list-&gt;bo_list_mutex);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *=
p,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; r =3D 0;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;bo_list) {</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; r |=3D !amdgpu_hmm_range_valid(e-&gt;range);</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; e-&gt;range =3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; if (r) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; r =3D -EAGAIN;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hmm.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 90d26d820bac..5b72ea5a3db7 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct=
 amdgpu_bo *bo)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; return range;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+/**</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * amdgpu_hmm_range_reset - reset an AMDGPU HMM range</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * @range: pointer to the range object to reset</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ *</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * Free the hmm_pfns associated with range, but keep the allocated struct =
range</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * for reuse, in order to avoid repeated allocation/free overhead when the=
 same</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * bo_list handle reused across multiple command submissions.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ *</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ * Return: void</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ */</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+{</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; if (!range)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; return;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; kvfree(range-&gt;hmm_range.hmm_pfns);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; range-&gt;hmm_range.hmm_pfns =3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;/**</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; * amdgpu_hmm_range_free - release an AMDGPU HMM range</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; * @range: pointer to the range object to free</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hmm.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 140bc9cd57b4..558f3f22c617 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifi=
er *notifier,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;#if defined(CONFIG_HMM_MIRROR)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)=
;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;void amdgpu_hmm_unregister(struct amdgpu_bo *bo);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_range_a=
lloc(struct amdgpu_bo *</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; return NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range) =
{}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *ran=
ge) {}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;#endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
2.43.0</div>
</div>
</body>
</html>

--_000_SJ0PR12MB69035C332189D35E4D5A81C6F797ASJ0PR12MB6903namp_--
