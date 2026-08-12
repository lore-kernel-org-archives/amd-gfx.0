Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE5EC5B567
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 07:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBF110EE81;
	Wed, 12 Aug 2026 07:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGOWtL9n";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E884710EE81
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 07:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6WVLRci+i+3GDj3UW0/L3tBli4Tl3J+gFrEj75TBxZNkZZgMem7yp+W6FpXcw+wtjygzAVm7ze8UBWb/db6Cz5j4wbm8DpTj9iDdVGisXgizksKPBbFr8qF6WSWNM4O/OKdQU2RH1P1NRSWniAflLl4lVLc/QXI0LEuqynLblAd0kjH6D7umtIO0hXgYeFfASgKvUkju+UJPRKnm6gkyFyhASK1hVmztJYa044hmx5dOZo3kLynKYZ1fMud/4Q8tyuqTufANY7WgRus4LIYL92p2p111DOvvi3l9bTecczkoBdbtyApOlHuYiyM/s0uyEDkRb+fNoBEPKNkKLUCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9NBUfBM0MADVkXebg51d17fDp8wB1Jk3R3/Wds7orc=;
 b=UmlTd8Rkq3k5oh7N/7FbSwrSjLkJpvRi+gDuwOD2ttC9OgNYyYcVK1oZfi7x1WMHsT08z4aBaHovk0JsImlf8D1YgJwul9x9DwnLq+8qv9/+L3JiEb7vaAPlGZJ/3AP9O8VicTw6MBWOzq1g1fzHyfiq7WfBKfieobHjwaWxkWQIAicwrv+CiByXMeQXO1JZtK0JPvWkRcA+nEmkZpMMuveaeZ+i049OWyqne47ZP7HAUnpkUu/uskR+V+Hc59G9QqA56s/ePup5E4kM7psc5oE5/2lbQhjv5OA8C3avVKO7+3YUdKVisgn85YtFU9ZjTakY/BwVBRm+wKt9lkVuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9NBUfBM0MADVkXebg51d17fDp8wB1Jk3R3/Wds7orc=;
 b=nGOWtL9nQxZKvBlQiOU9CCrCRzr3tC1k7z86WpFRoA4+1kfD4pkr0GhA3GqWOVAplwaX2IWx2uZBmkmVTKpjkRfnbWPA9QOn4x9kKk+DgqCns482o5SsXcOdjto5zKXwXr/ph5TFwAneRuzygn7HyhvrzX5ZIAeUneFf9EQbyEM=
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 07:14:49 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 07:14:49 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdkfd: allow profiler process reenter
Thread-Topic: [PATCH] amdkfd: allow profiler process reenter
Thread-Index: AQHdJX+pZOzzLEsqiUG6jatMgMYfabaaCWDw
Date: Wed, 12 Aug 2026 07:14:49 +0000
Message-ID: <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
In-Reply-To: <20260806084312.79422-1-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T07:14:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9457:EE_|CYYPR12MB8869:EE_
x-ms-office365-filtering-correlation-id: da9c13cf-4513-406f-827e-08def8416585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UwjErp6wb0CXdBg1NhNQbne1tb1hXfMNMmtIt1/9Wu/b/ku50pVsWEfH2prMbBkFGHvu3x+eo1lHgaVQC5FjlWlaSUTeLMCcchPUMVfXXpzGvflUjiuLO9aej0LQX7nM0LjfNe0aChwFtONsVJ8XVQ1UmSiW0Fk6e/6krQ551kwRp8sI4UxQFwpM0wk+aNdBrwk5XEOyJN4IAY0VvX9pHU4khGqiOCAXjEZuju+VJ7LHmVahia4T70b9n1kiYQ57K3fVO+30Tkh3zx1PXDnLLm+k4pRTSzX42/QR/KA5yaHdRvWBeABekEL3huYdH+24kTjSc0WVhiaLrRTvimP+CDo0ZUIW10twWxwyMwRSTRfq1HB+8xg5oLFM1xeEMWNBHgt1t2HV7bEHlXpG3yHT2reiYIbXjf4ulaca3ZN2NsGSdHNv4JMbeZmvkiSqbXtKAVao+okRdWO9iXChSnvkrF/NlJvjVzpiW614q9DkoLM8UcUp3i2Gb9C8xDUIl5TI3t/d0glKhP8srWQg3NeZ5yfX8QT4bNWkLdZpNZxZI2nKObmzNYE8dj9soXsN8S2rDMRA+x7ZQWYZXqU8S/iJ9KBI5Dl0mtyrdfl5vIQqSthwvcmIRFuCyCnGwRgq964ENUDdrglXNEwL0JF3LJb1Dc0u9fTOnOJEICX0x4AmbbVN10w7MGTJm6ZiUQO/jseBpmmGV2zzQAQ9mSmdF8/+ZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXnEYanCFB04w0+8HZpm3E5SoERDDyjFSw2PxvA1Ud1N1BVILxg6AIUBB5VO?=
 =?us-ascii?Q?p3cw6SwDsN2PU6znbPsvzWb+gDiae4nWW8AhDeqJT5xUJ5OOLs/HcaAAxcYm?=
 =?us-ascii?Q?OtCA3eBkW6//SuezTnzPr0wBl6ajnnQkSHAmo7/0ERT5sDRsGQyCAbmffvr5?=
 =?us-ascii?Q?n+H4L+rxIKDW4Mvfs5MoA9+rViOZp0k/VDVocpKy+h3JwT2BjhTb+HTPtTKK?=
 =?us-ascii?Q?pJOWGeZHfMlqz58Cm6pl+UtEG5UVmS1eo6OymOEwqQps8Ww4sG9dOvUcH7yZ?=
 =?us-ascii?Q?2W5rNl9JK2l4lOZWxsC4hNvaDCA7DZWp8QKOCuLdHuUyb4X7GPNgI+vbTywR?=
 =?us-ascii?Q?41DjCkmKXQKc3sCsraPdE9f/QY17rMFycNiCQvnuESqDy6k9qpptrOMuEMaE?=
 =?us-ascii?Q?i/wE78pfpMYw8vtZ9JpFBRkhKfSJy/T/cyISFHX84La/qs8iCJA+QXZw/Nfs?=
 =?us-ascii?Q?Ua/I32R4lVQpuuLygI9w6AZwp/K8mt96SFdGFITOxgr6DdnxL/M/SKPBSiSX?=
 =?us-ascii?Q?DISbJ2H9ds4wMQhalVfKzabF/JyXZJvw1ArTiYfh8761/6Mtpn1bk3lYUK8s?=
 =?us-ascii?Q?JkluPjv4t7dERaUgCliDnDUI8ea4nVeoPAYzGMeBnF8TrDm7jrXFNbtYyVzi?=
 =?us-ascii?Q?C7CgA37jXAEijRvycWorsFEZQ6myQxV8HrXSTOH+AU8AnvHTa3Bg8R0xSbot?=
 =?us-ascii?Q?69FmmzP76g479t8ozThXJ8ninhOmkb0OJHpK8/Uf5XSVjN3JB+FlKv2VXdGb?=
 =?us-ascii?Q?Pw/UrKdofAwOuEYUVIfryqxbcJJitMQlJ95NE6jTlcM/HxRY3hWkdgn8f2y5?=
 =?us-ascii?Q?OSukUHHs5thAMR+hqkpnjWu6mrQ0U9phaul+cGg9YobFxd77d7MKpPk9j5OK?=
 =?us-ascii?Q?KEzLHeIX7sDFHQdHbDeEzOzJc4OIo1PwH3B7RuaYmsoKGejJfzrrJaA5wZ5k?=
 =?us-ascii?Q?Q84CSikCg5Oah9ULScxHqyynEjU1pkfa28vsmQ3BALQX7dHqolvoJlUwwIBd?=
 =?us-ascii?Q?83Vg5Q/WDNY4L1gpibccfF1JlQFkDIcejhaIgNRzG0E9UYlqklkx+eahOsKd?=
 =?us-ascii?Q?bu8KcXZGGA+KlbsncPBie4pJeGSolKfLClT6zGdp59wF/DppT43SkjXygYM9?=
 =?us-ascii?Q?o3TFlxO5BoKhqOZ4uiLCv/QRu6GVYDQUWP1OHIOUwbWx9spccZfZjBkxR5XA?=
 =?us-ascii?Q?sfTEntPR3IOrKljvJGKig+b5m5aLYvCWurTlOuLZrujWXYNHPtlPxYTF5PsO?=
 =?us-ascii?Q?+dfIjjjxOypV+8hjqsL9A7MrG5ufxJhmIe8ePbZsf7v5Jf6faSjt8v4ig3nN?=
 =?us-ascii?Q?Z93kNS7qUWTwDViWN71zmWl+vvWf6KWNPDoYFa2xak+hJxbYRgW03y96z5R4?=
 =?us-ascii?Q?6DNDjFikDRw022uJxjCiKKDy7Gqw/tvztv6OQLjEObTQLFGyksQAGwKzV2xH?=
 =?us-ascii?Q?pPlTHBEw8ueaXk8NTvSi50UvRdpO2dLv89etRkpAbvwWDjgo+R8PlHH4/F7p?=
 =?us-ascii?Q?HO7ktXqzxUzqwrMq/ol0ZH3N7fT3T3haVCwUlvw2ucTICoshEVMu9hExKaFW?=
 =?us-ascii?Q?/RM4fvPYw5mtW/BFetI8BzKFKcVGdyk5DbABqFGkjp+82eeUS630R/kndEhE?=
 =?us-ascii?Q?CrqQLL0ldj8YUec5vtoWhYwmneyQ/C8Cl3kJQRZxG/Qa0JVl9XYsaY2rE39h?=
 =?us-ascii?Q?PZNwmZ1ekzm/+C9WRoOiU8vGL/QxIK5jd1XYkW+CfMow4aY/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9c13cf-4513-406f-827e-08def8416585
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 07:14:49.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOvmvaiKEMt467h8cGgt4mhQBV6RBh4My7aj4azRjvkd5zQvuwJdAUIeWa+V+Z67nNnc+2tUIuNDEBDHAoxzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Gentle Ping.

Thanks
Lingshan

-----Original Message-----
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Thursday, August 6, 2026 4:43 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu, Lin=
gshan <Lingshan.Zhu@amd.com>
Subject: [PATCH] amdkfd: allow profiler process reenter

profile_lock_device() currently returns -EALREADY when the current profiler=
 process requests to lock the device again. However any negtive values here=
 are treated as failure, so this causes rejecting a profiler operation even=
 though the caller still owns the device locking.

This commit fixes this problem by returning 0 when the current profiler pro=
cess locking the device again.

This commit also changes profile_lock_device() to return an int value other=
 than uint32_t, because it returns negative number when fail.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 309510e23315..9acd5c91e51c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct file *file=
p, struct kfd_process *p, v
        return 0;
 }

-static inline uint32_t profile_lock_device(struct kfd_process *p,
-                                          uint32_t gpu_id, uint32_t op)
+static inline int profile_lock_device(struct kfd_process *p,
+                                     uint32_t gpu_id, uint32_t op)
 {
        struct kfd_process_device *pdd;
        struct kfd_dev *kfd;
@@ -3365,7 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd=
_process *p,
                        }
                        return status;
                } else if (kfd->profiler_process =3D=3D p) {
-                       status =3D -EALREADY;
+                       status =3D 0;
                } else {
                        status =3D -EBUSY;
                }
--
2.53.0

