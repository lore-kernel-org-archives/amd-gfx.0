Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67028C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F062A10E0B6;
	Thu, 13 Aug 2026 08:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yA1yfF2L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8516F10E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePXU2ESuR//U66giPEvpXFkE6ft8XFn9JoQm3XCJSGyUlkdDhzOAfO9CpAWVks5Lyn0jNm7DyH7vpgS7tydg4f6DpyuoJoYt8V3VK5c83zqKqd8ILGCAteaxVl6XHwgMgNME8J+7O7PeYbsyPjVvfeI5jNLwMWIJLxAVw2ZQSMcRwyCHhfmRaKi33b1Q1hHKrBFm8LsWKRGoN8zKELdThwvj4RXhc6IEBxGbFQvIxo2hZY2+p4nvlq2Ifxy88m3bKO9nyowvd5djTuciShSAZul1VKO83aopMbeeUsW2+i2GOOAqwDP1tuh5L4g4Drs07ArWrzJnm739MTCVdcdN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg4NO91lvhRiHd1Nn6PKP9Z1qqp8oQHwzbhA+D6/stc=;
 b=vZ9r/bYoDFlEyezTGvdMCL17mmeJBhQ2jKGqlPC2zWLwilogKEkaKWaqIUYeVu+GKm8QyrpVbW67nxIYnSWLh+rcqFIM87YO6l6XatT/BrebCd99GWKadc12YeWwidtKaLaOtL/zfWrckMSlMlGZkSwJNqDfIPnIboTsFmphkpb4OmzVG/W6dHUl7CqULKQ1qHGCRTJfGhVtUSjJC29IRJI84w1XNCef+nqSAcfj0gwdO3JZNtYEkvf8FJLg4ygPX5J2Zxz978ipSxqfPwHrhB79BVnldtJGlWpCbpRdigDWTlYmfcHiBzQXznHh12Kuv7h9vBX4JamLmPubtZ5+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg4NO91lvhRiHd1Nn6PKP9Z1qqp8oQHwzbhA+D6/stc=;
 b=yA1yfF2LE0smfKQw6KZbtlDKZrYEJxsxwvHcD5JUVcfmWG4hDXQizfo7Nfx1hvIum3s4NplLTswJytzg7gpuWLVuOZ7U/MWRwnZ2/0yTmI6+gzs79agXtMwA0YgTqWyKTLoPZE4yA/4f4WutDFGIOqYGlQuIk0uCw2cBNawHW/g=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 08:52:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 08:52:20 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Ghosh,
 Prerona" <Prerona.Ghosh@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
Thread-Topic: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
Thread-Index: AQHdKio6WTemUBpq5E+S0zWGxAeus7abrYyw
Date: Thu, 13 Aug 2026 08:52:20 +0000
Message-ID: <CY5PR12MB6369788404AA5CA817392341C1DB2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260812071414.1066241-1-yifan1.zhang@amd.com>
In-Reply-To: <20260812071414.1066241-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-13T08:51:48.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH0PR12MB7908:EE_
x-ms-office365-filtering-correlation-id: 7bdd288f-0852-48ce-2d0a-08def9182f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: IZFqy83n3lUITXBFBsMFLwhXfDZN5D4zTa4Cz2dhrm+ryAaGdhAmTFAv00I1md93dsBtYCK1qdZntqxkBexYmJDM2ZzJZHFIFPsmTxo9mpofEG20KJMJ6QADfLE9pO6i1aTfRkUfQjItw+QNqGtVKH1wZaG2P108HDKrlC0OmA4Hvz6kBWc7D+z3ngrb2tFADSd+CFQHHVw1cFjEadVEON7cfv0bRUHIJdLJCUba8UgR2vdrWHla1ud91YkoUv4S3Of5h2k/EDVU4EtBxSrHKQLrSjd6gO+fYYO5jkmPRI+sS5qchHFcZFwm8ayyHErUNRB3ximC4+wASNDC7NRkSc47ID3O/LAX61fh51DknQ0jJnYkRea+ss1JPeSLLSx3JDLHC6W7jsh2heHMh+CuqykkAAxfohxwngOHdHCPvQpwPhG5z4qYUDSC+VogKOcDd0qjHRz85TVfD4FgvwXQO47Mvb33huk4ASBeQ/4TaxQvWCqse2F0QWEbajabS3Cd6m9iDxN2iSek/j5pfSrahxz6Ph9Gd3aSqcEIgGj8jDNlHOUBTTWVnfu89TmwX9dW1HJbXcjMRbm5jwnS4VYTxOEfLktb5ujlONIXUy/b1fjsFTGLYGi6mhOJc7Imj7s4xTHr8XnMO3uCyDuGy2vM7mQq/Xkt2xKTvjetuIo/CgQ6OjoYXGBUkViTt/IN+iqiTT+m1jCcUotQO0zAEvvVinbKYO7EltYF6MqbE6twZJo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ogrhsWTwgFE8P2TK38Q6cn0xxYzlMQEwT5+f7J+zF6u4rYMbrcomgImqarPo?=
 =?us-ascii?Q?TQULAdxGlP54Vj19qjoiZwgumD+uHMGiS0Ldy1Wc5OsEwUCjt8V13NjVAGSs?=
 =?us-ascii?Q?Lo/hqrnK/puzbkDQZMagDRK5i9f9qTzhXBgUlOZSeIskgm7Lyu0uUMMxogJb?=
 =?us-ascii?Q?qnDb2A8WyjqGkFhcP/cYHkZpSTfsq3utNErTfurnUahXoQz+GHPyhS1J9Wlk?=
 =?us-ascii?Q?8cQc6mfcCXtmM5fJC0iAzq7zyeMZdrBwtOLfPpCYk/aaTZVMBrQqMEcUtRfu?=
 =?us-ascii?Q?18jwVZEQ9FGjTZONQcBOG+slpW0DzQQky8Bif7KEAf+gnOVOHcpUBHOKD/iS?=
 =?us-ascii?Q?hk/JDMTR9hkB05UES+9Akt1r/bhQWt+Uho0sieSsQ9n1Cp+YBypYVxzmsWdA?=
 =?us-ascii?Q?C7RSVT8AKnmdkQOr+rIIhEnyZbVj0AgfXJupsRmQvPxHUlcn2ewvsx9lcv6U?=
 =?us-ascii?Q?R24qzTwkb/TC9P+pT6KLRL5BV7HU/bMk7kRQY8FI1i4iJnIRgCVyRT4sImV8?=
 =?us-ascii?Q?zFO/pakV2U6CWetmScSbejQKMCX11LLKsclOqSJknexdH/rpTD/ixAnqUIlS?=
 =?us-ascii?Q?mmGDBl89fbCtXt3098Tn3x3R5fuNyacj0wnwyelRZfiXFyzU9fIrH5XLkzbh?=
 =?us-ascii?Q?Jjftk+iHaU99xRbMi+QTpTWKuTskjE+tldBEmaks8Y58wAOMhqAefA9zQRGy?=
 =?us-ascii?Q?rJQt57KmHGtf89qupDvv0VAv4k4O/159g8TkjeOi2C7EzlDV5t9h4oK45CHc?=
 =?us-ascii?Q?r2mXXHWsKtBF6WE11hf8rJA1jWxEDu+5zcSorinmBUE2EUYb1RrRfk0wEy/B?=
 =?us-ascii?Q?I4nJfnELeL0OLPE8gGwhZUog0cwcGWC2jorwXq5YovG5irmWdD3RVlmk1lwh?=
 =?us-ascii?Q?E29OczFeCmT6aq0XKOyjjg6hoRU9fkf9JoUN84O+xWsCadN7wHmZ6jmVMu3H?=
 =?us-ascii?Q?2lVEB5y9Fj2VDu5TOTaTL+kBMpBDvsYf/ysZU1fs53ovcl3XZ72+r13iJ5ze?=
 =?us-ascii?Q?5tdLvb6UHJ94qCyt14hHRAM9xzs/k1mhD2Jv0momRSnsAbse0qj6KSIzYiuu?=
 =?us-ascii?Q?9LcSEqBD+WvcXCI8tN4kq52SF6niEJqWTFNC26eNlE+fapUCx0iJBxwFV0bn?=
 =?us-ascii?Q?0l/fWWkLR0pR1K7wX0mXvGmaO70m4RQmDb2260pulCH3beRy768FYJhSMlXC?=
 =?us-ascii?Q?yiabo5xC3q7v5t8vk/IsIet5AuxDU/KtK7cvkYohyhNzdGkwy4LYo2A4wyqa?=
 =?us-ascii?Q?XpVXiN7vnFE1+ITFrhXAy347KkGNbpfb/9wY/ARXdUxE588DXA9NeBRgS1V5?=
 =?us-ascii?Q?Pe5Km5Xj7eej0YiSNbip1nOJg/C+hKUWB60xJCcCj179zxtlvDP/cLJ5kVCQ?=
 =?us-ascii?Q?hL7Q0F/fGdqUBIgxHhgS0V3qVMEShdlamI6273SYKLLJgKs7sfj4aucleNMz?=
 =?us-ascii?Q?XXqSEtYIHaxQBohwLWQFSzjx4csIM6ScVXIjzKUbUo5AKBKDG9oj1b1qcB2E?=
 =?us-ascii?Q?dmLKOATIKAGAd/u3Im2876oUmbBEy/ZQ3prhGESCOGh51FbRgk6tfNKKjTQz?=
 =?us-ascii?Q?NhqultIoHZEyL6z3oZfhUzR/phz6A4oRVCMx9UZTB4v1Rk0lGYlEWlOq3EQz?=
 =?us-ascii?Q?bA3U9bP0EbnpHq+dRScgYa6WfKflD7RWH+fo+uPwhKbIUVFGFtx5zUvXiQt5?=
 =?us-ascii?Q?atc37VOZNCPi4l1XuBgSVLgDN86WKSa72w73n53SZyumr3Ja?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdd288f-0852-48ce-2d0a-08def9182f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 08:52:20.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOCFEhCQV4rbU/revajaSgTqr7UuBPD+jnO/D1TRKxDoZ6+Bzci1rqYb6XKUOb3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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

Public

Ping...

Best Regards,
Yifan

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, August 12, 2026 3:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Ghosh, Prerona <Pr=
erona.Ghosh@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

DMA-buf imports are created unbound and land on the VM idle list, so neithe=
r amdgpu_vm_validate() nor amdgpu_userq_bo_validate() ever binds them. Only=
 the BO list of a command submission does, and a VM using user queues never=
 runs amdgpu_cs. AMDGPU_GEM_VA then programs PTEs from a TTM_PL_SYSTEM reso=
urce, i.e. without AMDGPU_PTE_VALID, and the first GPU access faults.

Validate imports in amdgpu_gem_object_open() instead, while the BO is alrea=
dy reserved by the drm_exec context. Graphics and compute VMs now follow th=
e same rule, and a BO that cannot be bound fails the ioctl rather than hand=
ing out a handle that only maps to faulting PTEs.

v3: validate inside amdgpu_gem_object_open (Christian)

Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:claude-opus-5.0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index f754a4a3a1c2..261218cb57a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -271,6 +271,20 @@ static int amdgpu_gem_object_open(struct drm_gem_objec=
t *obj,
                ++bo_va->ref_count;
        }

+       /* Imports are created unbound and land on the VM idle list, so nei=
ther
+        * amdgpu_vm_validate() nor an amdgpu_cs BO list ever binds them fo=
r a
+        * VM that submits through user queues. AMDGPU_GEM_VA would then pr=
ogram
+        * PTEs from a TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALI=
D.
+        */
+       if (drm_gem_is_imported(obj)) {
+               struct ttm_operation_ctx ctx =3D { false, false };
+
+               amdgpu_bo_placement_from_domain(abo, abo->allowed_domains);
+               r =3D ttm_bo_validate(&abo->tbo, &abo->placement, &ctx);
+               if (r)
+                       goto out_unlock;
+       }
+
        drm_exec_fini(&exec);

        /* Validate and add eviction fence to DMABuf imports with dynamic
--
2.43.0

