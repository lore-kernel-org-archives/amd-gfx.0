Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5567C25B78
	for <amd-gfx@archiver.kernel.org>; Sat, 25 May 2024 14:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E3910E0B8;
	Sat, 25 May 2024 14:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CR7dVF8i";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6F710E0B8
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 May 2024 14:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBDosbbMJEo9j9o3Li/dLlBinMfGejy1lLbpQ9DG+rqAWz5SmDV62i1OCMSlHLVU8b1rRM3k+UE3YG7CE1iBiy+6qEnk5lmfqCBSr6wrr7l9GQ8ZcOAnp66q1SSBGuG+s8EHdCPFsZ/fVl8ys8JW7jQvEfxJp0qtV8ZQ/dp95rWcKo95LPX4GOyPLENiDvan/Ec48rKhUAHtiIdjb5POUqRjm+wQfz1bf2Yi9LRAqwV74i+9msFZ1+aYRcaWksPY9jt1148/x9ckgyKOfVzqpuDdzskbpVdxKtpSUi9kDjyovbfGVLnIVmhqXpQJKj3MLmszdhFR1T0ANerXSZIEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLKGCRUbMO6OM/CXsvXRmYNMGz+otosLtqRUqloyQ9w=;
 b=ebQn3h8ICqgO+7UfT9GHAGqMIXjzSUpZYq8C21S4s6u+yuOdQmxOIqUXbr97DwkNcNMD0Ix3Uvs+/aaS20M0DAJrK+WYJOkdu/TgLuNYN7PN/+/Hn90d+KWZFCXApIG6jeNOg958HkvLc8zDLm/yONDHvLJlKNttuSC5GP/5AjS3yrLjMrhYCHr0sFRhYvWVqdnUEtxlqhKWHA3caSR6yNYCmT002O3yAdqUmPRmtvLfhYpD3Hfbw9A7zk9pDlgxqux85PZylI4Gmg3/P0h8vLjyvC6qm5dBTgTb3/r0sRoblQsLbl0GZ4gKwkVMJIHt1wiDn8PxuqzNT5RWvgzpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLKGCRUbMO6OM/CXsvXRmYNMGz+otosLtqRUqloyQ9w=;
 b=CR7dVF8iFbLSdvBULoCw1/d6+s9qlrVXpCL0RuhS3Ol93FvYUW86MeirEw4f/FjIMKll/HWmIFYzbkJHmemPLv76jTR//SRPqSZyRg78aVsSc7MwJOxVucNk6b7KhvLAGsKPXpC80cAu0bhKEMIzVnPFjxqEKuO4N6GUOIw6olU=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sat, 25 May
 2024 14:02:06 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%6]) with mapi id 15.20.7611.016; Sat, 25 May 2024
 14:02:06 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: simplify APU VRAM handling
Thread-Topic: [PATCH] drm/amdkfd: simplify APU VRAM handling
Thread-Index: AQHarePiB6DTXB1/zUSIk8QNtxZffLGn+5Fw
Date: Sat, 25 May 2024 14:02:06 +0000
Message-ID: <MW6PR12MB8898F1D8E41153BCDF012854FBF62@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240524140807.3186797-1-alexander.deucher@amd.com>
In-Reply-To: <20240524140807.3186797-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9073b0c9-76e0-40cf-9aab-bccddb6c8356;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-25T13:58:58Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM4PR12MB6496:EE_
x-ms-office365-filtering-correlation-id: 72a89607-b7eb-4325-a7b6-08dc7cc34323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/IEAZgCJZsCeZASrKkj0P6pvw0d/DaidlYz+hJ63u69SVZFsSAsgKzkmX+7f?=
 =?us-ascii?Q?9s/CdVmNLw8HB4MjiV2SQGNIusP5DdqZ5YYqT3p/Mi5Jf6pnrNhbm4MqpdhL?=
 =?us-ascii?Q?zYwqMoqsirM8bGieZC+tNRkUZjO+0oCKfDt3mHK2jf2HZNqskgvRRBlJU8Qt?=
 =?us-ascii?Q?H9WQ1tfHcYUj5DizD+qePgHYTxuy4uD5+oljxT/4qDH+AM0pCCgJ6uP2/V9W?=
 =?us-ascii?Q?3sJT3n+4ugjKIFKVGq2WF77PUVvinX4JIG1a5gznQmB5KTOclQJ9pRgytS2G?=
 =?us-ascii?Q?vU/QLtaOaFATIwoNzvsGGclqsA9oThMHmqK13SnY9isnVJbmsEJcjmKUyRxU?=
 =?us-ascii?Q?0BOdSFInNjRBKDUs5HIZ7Ima/iAplSpfD6cFpnB68g3hhkMtCHTNE95Ro+7m?=
 =?us-ascii?Q?CunfJnzmyB/G5jipHq9M5Jr5+iGwWfBKZ45iJM+OjzVAD9xecgazzPth6xyY?=
 =?us-ascii?Q?RpV+JCm9JnanyZupriyK57ybViJx26A+GZbfZmjtC6QES+25O5De5Ft5jXT9?=
 =?us-ascii?Q?n5ATLvwKnwHh5sAm7BUKGWf6EUJFiEUOSENq6/kTJe6Ogg2KVsk+p+MyrB0H?=
 =?us-ascii?Q?ZnfTBN3GIC8L8xrOEuKYzpVyvulfLsrif7suu7J5JK18SaR2sqjDGBUVZ0M2?=
 =?us-ascii?Q?8/F8ntNxOwtnW9zlWLfIjodwVff+otoj+7kJ37aITCqiZfqPrtBWiXMFdN/E?=
 =?us-ascii?Q?wQUjScNrbHle47qTlKdDvN3TqoucLv3qDqfgY88aetS8yZbgTDhzI9G3y99o?=
 =?us-ascii?Q?Ygy3hfViqSyHt94KmuNXfzlyRaHSVAjfNk7DueR9CCDe2gh34Wgrjmcw7on+?=
 =?us-ascii?Q?rnRIZ5h0AY5jIg+TW5tBr/Ej5ipPRA9FUVZ5cSGamAJtfMrMIan8Q1v/EYRa?=
 =?us-ascii?Q?+7UZstpI1E0UfpU7MLSegb+etyqCwwiP1E0jfS3wESz23RA54qm+lRO+PWVu?=
 =?us-ascii?Q?zxPsTNy8yBj68rWTP1AFFLdDUi5qX2jnJpX/wg1RULoSHmOgXx4zfr/Nr118?=
 =?us-ascii?Q?a6cpV1M6pvCaNM4GXaLF5+/oM/sVs7ULa+7p0diXTVyT63UtWK6aYYF2/71D?=
 =?us-ascii?Q?Qyk9E03ArZYIIKITROL+Q5yNT959QkJ+MqJ3jKDXQrZxxfRXvP3WcMCuAPzq?=
 =?us-ascii?Q?kRTxvbHnnRniTdPDKjyRFaR8r3ESGMixySRZScWMPuCpWnEXrkzFKsfqONoG?=
 =?us-ascii?Q?q9tkoYI1uoC5FwPANzNLG2WvU7QPNZCaM3b3XXUiyb7x0Gb3C4vFqSLGszNj?=
 =?us-ascii?Q?Uqvlt85B81o2Dyt1d2nPwlZ4u3MKZ8UfpSRxR8l/TubyFg3l9T6LfCM1A5UE?=
 =?us-ascii?Q?WhYD40leQ7scFofdu3fStu2Sh2RX8ZL2JfHANL2giXON+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ES018aIUVHWZLMkeRSheyagzndnyfSjq71xv4WY0fQOnWnHP3zJcBB+aeFeP?=
 =?us-ascii?Q?iTiyy6Y281pL5F9Nn3frqlZdSMOBgITEHcJfJaEWuaINsD+wDP93iwHbcK90?=
 =?us-ascii?Q?AAOjkYkquUGkOujxZqCUspk+W8aO855WGrkHDX8Ul8zJTt0+NwI1ARTcJFuv?=
 =?us-ascii?Q?AYF50sto/126/4bdAIXLvwXO7nfrJAiKDb6vDQ+2Sp7qkyp9mKq3ZQBxhGPC?=
 =?us-ascii?Q?WWIbwauy/WV84S05Xp+EYJmW7rFawCCKG12za00QFgPtQhMWScIumWseluCO?=
 =?us-ascii?Q?/1NdMNW/UbPE2tqSpp5VZuaX/sB+XVOd0+QkjfKUh6JsvrHwdybouQlym9k1?=
 =?us-ascii?Q?Nd/TO2yTnmig7DR5dUK5KfHOO4RMS0xfT0ql4z/cyqWL7EgeTFquUu0gz3kv?=
 =?us-ascii?Q?7JAIt2IeWBHUdIdlHrFTkrtsqou/zoaa0d1megC8jCCNWBBT+Dl0XZP6mHlt?=
 =?us-ascii?Q?zNfdJIcuZI2N81HNfTqW1inneledaRbanTvVmnY5jNJSwxOCzCm1ws7e+ac8?=
 =?us-ascii?Q?nKwZ5FE6I5aWLqKkrUB0ICKBEY+/tyYuTOaOXTaYgTwhhu6QAOv4TMEGPSG0?=
 =?us-ascii?Q?d6galtqacqB3+4zJsbLvd0koSmcxrXMXZ6BWRCJMVUG5qQKHmkmozc+q3lNV?=
 =?us-ascii?Q?xan6+jV0LLBhDuz7jRuzh9Z5ZBQ2gndhwdEvSPfZuWcHhLKv1pFRSXHxyMxN?=
 =?us-ascii?Q?rFZfQWps73GCpXIrnVSfBA7DS6OoMMnqJRkmM79IcjXN0gBLuLzLKBNb2twC?=
 =?us-ascii?Q?GgC4NAVKEtuFG9umrQ5Lp26HUqKr11gWv/IuwJZ6gsIJGiRuBVxS128JBERc?=
 =?us-ascii?Q?kiDzdQjf1q5zKdwgvNglIl2Qd4zRPfpoAnCWxaIvKma5s+apR4dkl1/KpuTO?=
 =?us-ascii?Q?bR5KZ4b2ycrVbrUYnDFUBzhpFOrcqTuWCOV/wYM57VHzvjh7sbg7qV78j4cV?=
 =?us-ascii?Q?4VpxJqt/CEHE9/XKR/eJuMS4XNExvo7u8BuwsjhbSlBJlfJrDjrq8lIlYOho?=
 =?us-ascii?Q?r9g7CbJQ8p4WZUx939EHs8sD5YLx+AJfF8xzoJ96XPDA8W+zdv2jHC6J5OVv?=
 =?us-ascii?Q?u+2sV0rRp0p76LQN8KsKTP3g/4gT3LR6PvhHH7CKJQgIbxiLTHPwTWfLU2U5?=
 =?us-ascii?Q?3qyxro5iRMnnoIfg3wk6ec31ipXnB31rPEPiiNYdQG5bRM+4Z8y7dpEmfPb1?=
 =?us-ascii?Q?4eIL8zE/PrjrrYOKSlMbNKiE5vqzfcNRyacjt5c6HWMmU/fG0TXg8Q3yk/qJ?=
 =?us-ascii?Q?nltkCc2n8WiG8cQ3JjQoe04DQ7xcpo7r/ULd/oUil7DjX3FVH0rQyiAccRBa?=
 =?us-ascii?Q?PVASbb1nwhstTepEwaP66AariIsDHj86fJY14gfxPP5LErb7PN0bC6y0k5y1?=
 =?us-ascii?Q?QqNqXXQe5niVCQaIWK+eiMmYUKUxkWL2KirIXWKlTp8rDjqgfWeRJLEsifgA?=
 =?us-ascii?Q?RvL+cYufGqH+bkOr1SSE15brpQ5nVmVwkAfTgq0+IcyJxgTQIUGEerEPNDZO?=
 =?us-ascii?Q?WKHSBPBsh8BTzs8/B8stm7Puc1IfA9crGVjJZ2dddd8YLnYciySJMo0HcYjV?=
 =?us-ascii?Q?6l0/K+QTm/Rpoelp/5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a89607-b7eb-4325-a7b6-08dc7cc34323
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2024 14:02:06.6291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lujpj5aGyfL4TowTgdG46o/77Y1POTi53kBYQM5Ji1exQRIPPkiX0wFRP9MKAeZ1UiQCRpY+g28aoz5UP/1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

Reviewed-by: Lang Yu <Lang.Yu@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>Deucher
>Sent: Friday, May 24, 2024 10:08 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: [PATCH] drm/amdkfd: simplify APU VRAM handling
>
>With commit 89773b85599a
>("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs") big an=
d
>small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU is set for=
 both
>big and small APUs, we can simplify the checks in the code.
>
>v2: clean up a few more places (Lang)
>
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  6 ++----
> drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
> 4 files changed, 11 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>index 336eb51c4839..3af00b57cd8a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
>amdgpu_device *adev,
>                       return -EINVAL;
>
>               vram_size =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id);
>-              if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+              if (adev->flags & AMD_IS_APU) {
>                       system_mem_needed =3D size;
>                       ttm_mem_needed =3D size;
>               }
>@@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
>amdgpu_device *adev,
>       if (adev && xcp_id >=3D 0) {
>               adev->kfd.vram_used[xcp_id] +=3D vram_needed;
>               adev->kfd.vram_used_aligned[xcp_id] +=3D
>-                              (adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) ?
>+                              (adev->flags & AMD_IS_APU) ?
>                               vram_needed :
>                               ALIGN(vram_needed,
>VRAM_AVAILABLITY_ALIGN);
>       }
>@@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct
>amdgpu_device *adev,
>
>               if (adev) {
>                       adev->kfd.vram_used[xcp_id] -=3D size;
>-                      if (adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) {
>+                      if (adev->flags & AMD_IS_APU) {
>                               adev->kfd.vram_used_aligned[xcp_id] -=3D si=
ze;
>                               kfd_mem_limit.system_mem_used -=3D size;
>                               kfd_mem_limit.ttm_mem_used -=3D size; @@ -
>894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, stru=
ct
>kgd_mem *mem,
>        * if peer device has large BAR. In contrast, access over xGMI is
>        * allowed for both small and large BAR configurations of peer devi=
ce
>        */
>-      if ((adev !=3D bo_adev && !(adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU)) &&
>+      if ((adev !=3D bo_adev && !(adev->flags & AMD_IS_APU)) &&
>           ((mem->domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM) ||
>            (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
>            (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)))
>{ @@ -1682,7 +1682,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct
>amdgpu_device *adev,
>               - atomic64_read(&adev->vram_pin_size)
>               - reserved_for_pt;
>
>-      if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+      if (adev->flags & AMD_IS_APU) {
>               system_mem_available =3D no_system_mem_limit ?
>
>       kfd_mem_limit.max_system_mem_limit :
>                                       kfd_mem_limit.max_system_mem_limit
>- @@ -1730,7 +1730,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>       if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>               domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>
>-              if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+              if (adev->flags & AMD_IS_APU) {
>                       domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                       alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                       alloc_flags =3D 0;
>@@ -1981,7 +1981,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>       if (size) {
>               if (!is_imported &&
>                  (mem->bo->preferred_domains =3D=3D
>AMDGPU_GEM_DOMAIN_VRAM ||
>-                 ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
>+                 ((adev->flags & AMD_IS_APU) &&
>                   mem->bo->preferred_domains =3D=3D
>AMDGPU_GEM_DOMAIN_GTT)))
>                       *size =3D bo_size;
>               else
>@@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device
>*adev,
>       (*mem)->bo =3D bo;
>       (*mem)->va =3D va;
>       (*mem)->domain =3D (bo->preferred_domains &
>AMDGPU_GEM_DOMAIN_VRAM) &&
>-                       !(adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) ?
>+                       !(adev->flags & AMD_IS_APU) ?
>                        AMDGPU_GEM_DOMAIN_VRAM :
>AMDGPU_GEM_DOMAIN_GTT;
>
>       (*mem)->mapped_to_gpu_memory =3D 0;
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>index 4816fcb9803a..8ee3d07ffbdf 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>@@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device
>*adev)
>       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
>               return -EINVAL;
>
>-      if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
>+      if (adev->flags & AMD_IS_APU)
>               return 0;
>
>       pgmap =3D &kfddev->pgmap;
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>index 28c2c1b66226..407636a68814 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>@@ -2634,8 +2634,7 @@ svm_range_best_restore_location(struct svm_range
>*prange,
>               return -1;
>       }
>
>-      if (node->adev->gmc.is_app_apu ||
>-          node->adev->flags & AMD_IS_APU)
>+      if (node->adev->flags & AMD_IS_APU)
>               return 0;
>
>       if (prange->preferred_loc =3D=3D gpuid ||
>@@ -3353,8 +3352,7 @@ svm_range_best_prefetch_location(struct svm_range
>*prange)
>               goto out;
>       }
>
>-      if (bo_node->adev->gmc.is_app_apu ||
>-          bo_node->adev->flags & AMD_IS_APU) {
>+      if (bo_node->adev->flags & AMD_IS_APU) {
>               best_loc =3D 0;
>               goto out;
>       }
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>index 9c37bd0567ef..70c1776611c4 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>@@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct
>svm_range_list *svms, struct mm_s
>  * is initialized to not 0 when page migration register device memory.
>  */
> #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type !=3D 0 ||\
>-                                      (adev)->gmc.is_app_apu ||\
>                                       ((adev)->flags & AMD_IS_APU))
>
> void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>--
>2.45.1

