Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC4606A88D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aEJfCUS2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458EE10FB88;
	Wed, 11 Nov 2026 11:56:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FBD10FB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuoNKO6D+GSh4xMytTC1Ckiq9gcnOKVstsvM/udRF1P+rj0/N36vuXrPXk5hqfezJBTTxMK9w7fZu4nHaYt3h9w7L3iLPAp3Olarkd7WWnnJUIeyqz7p0xHQnDs2VWTGBYSsQ+3r50+4trrHzmRh+pnJeYmq0v7KkNs9PZREPmIB7ZD8xXVu8PkV8m1nsaaazXxjiB/a/qSmF6ZiFV8E4V+KZ0E58VCfPopM0+SerQCuAR7VYJ528dOFX0r7LvaZbwFumhxg9SwdLafyVNf92K80W12FvMwAyo+KKqFCdv7qwHxeJVqOZEHybjNF3XIJmVkJouRHxqzQPj5RhB+OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFSlRAI/1VaSGSlPJJ9U6klY86wYR2WugiXUMHwqfTQ=;
 b=u738OMTDalqShwmsbqsVZ4gMcvpM84oLR3Qf93zJenmkzM1wDSof5NyOrysiFwKmxSfgX20B1E6LW91wpyNoe8Je/3bcqfYZp2eYsiiK+ya/2hSaqUTvjzUVf/hpPVwYz7w7AcfsyWJL66J+07PeBXxPkGYCuTkWOTbQ4CCAgViNqKI8Iy+oVmUp4Tkf7GbionEWTksq8pnKCeMpc3G/cuAGdqlshGw3p66g/OhzRMlAL6iN2pL9aJKC10wjRe2/5uCzS+Ty7luHjx4aYwy1vg/eWXLBoJnxHhcccSsIEvS9WMTgene5uDzBuOfpQjoJVu5U1kmiOuTYbn+c80TbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFSlRAI/1VaSGSlPJJ9U6klY86wYR2WugiXUMHwqfTQ=;
 b=aEJfCUS2aqUXVoppSElWYHOum/qrljGlq36Ow7kugH7ZIFK4uYqyshKSzsNOVSKP/ogW7fhc5ntqhhJYthyOWD6HX3P3jih4ubsVd7QVRJLhi3ryy8Tem+7ppE9l2N7gnmYG3r49Ro2jMk/X6xpGpDyIxY3x3cKd+Ag/lagfo4M=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:56:01 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:56:01 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 6/6] drm/amdgpu: wait for page-table moves in CPU
 prepare
Thread-Topic: [RFC PATCH v2 6/6] drm/amdgpu: wait for page-table moves in CPU
 prepare
Thread-Index: AQHdcdOfkg64adkY8UumPSxn3cSnag==
Date: Wed, 11 Nov 2026 11:56:01 +0000
Message-ID: <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
In-Reply-To: <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|LV1PR12MB999279:EE_
x-ms-office365-filtering-correlation-id: e543155f-7d12-468e-0a76-08df3feac1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: brU9DPo9h2UB8CahR0rpurY8JXhY9ZkasAvYbLP71Wmr3TZpCQUVg79Y4eMLNcgfwx0lfPyPhUQyNEFDUgaQp3gy8uNQcfv3d583tYGjp9DLcdQX//SCGi/nRCdJw89a13UcxlfHxF/A+PWTDWSxYFQBGA0pEZzFNzrfv9Cj90cbHhUvSbzShIpbI66k28RFDpAoczs+8Y596fLkQtha88kD67avsGISD9kzY6FYjsDKCcSfkFrSv0qKuB6RFMJH/ib5WoGY+6Hs62wrDEvklYgwZK32/7KrdRuVXPZe97OBmkNnfOeKOfP095rJQ9nWy9G1k4eS1FMTnOLJewRghuvO83/JRqFkHn+WsYNiIpbZIgaCr+4GU3u1MSyidzyLLt7pZjpc6eZ4wpT6t6xP+DPfcU6Zl5CLKI1vqT661aXuHpM3IGwfy7bIh2kyl7VQW6ITlEoL1s0CrFfz/A+oHh/r+Qdh7K4gjFFf8ms0bNTfHPbYZWzngPi5JCC2sf/vSlriGr7CCLp+q5SAysExB8bOHOpLQKSANfdRRVvBFbD46PJtCBynQZwv8XzQ/bqdsUpXlXB/Kvtk8bNOoeS1FmeaQhJYAN9dImf8KSW3jdM/IW2L/OslsMoZVSJ0I++RN9pC5/sQ93ucMi91/fptJP1U+vFL2KGwv6alT6ksHIGuKNUENG3ytiCqiWaBbPKmogGNd+l4JOKpCN6tRrr33N549pJJuTWis+NEB7m3YWE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kTpbUr1yFy/K+z9WKOOv4vvxe3BPb7q7OJzBtMahcW76/cs1YqWAaiaxzQqf?=
 =?us-ascii?Q?DF1LYY4QWIEIcJ9zoDRHLMsNQpEfTI+9okrUGReUIoSBspMoWr3k7MC/aqdA?=
 =?us-ascii?Q?Y00ic4HTCJvg1C2alFyRy6LQ7Jz0RK0QX4WcusXgImi+9SLhndetVSNzSWLQ?=
 =?us-ascii?Q?vDecB5Pek07Bioi8TSRR4thUIJf2GX6BrofbHpAW1AldR5l9M/qsycrRPLiy?=
 =?us-ascii?Q?R5ybrAzLGOaTY5UZ1toeXOoviA90MvpvF4XkxrudMXQ/s7V8B8TA2/9tZHKg?=
 =?us-ascii?Q?PRrxmWb3hz2n+XOndwXv5P2sDfbO/l/nqkhq/mvyOGh6tRtAm39ooNG8quq3?=
 =?us-ascii?Q?IdlEG9sf+sDIZJUULf56e7P4Np5NLNsXAS7xXfUAwB70L7cFsRihT93tKzIO?=
 =?us-ascii?Q?/MRjJk0UmuR4XIb2639pJ4KfOeTPxR8B7Befk6VMQm1rnmxsK0jkaCLoW4rO?=
 =?us-ascii?Q?nLFjzH4JWQZuJCSi2xApkty//wMoEu21RQxFBnHHUVq8rLuFAvQ7lMrcpmSj?=
 =?us-ascii?Q?a3Nn8jdluVopSP3A9rzelJw2LDx60N11YtBCFG/+2yBrU/AopJIYmL9/HDB0?=
 =?us-ascii?Q?ZFiZKyIatNlrC4jO+bzKFTVw7cP8rg5/7KcpUDdkksYT7WVBvJAI+7n7jlQr?=
 =?us-ascii?Q?LOtLzFmMH8QXaITy1WBgGfw4hXBoHlyQy2h/RGbMY9xV8hkX+yXYE612bltw?=
 =?us-ascii?Q?BTsMiwMHR7u7d39TJDLxeA2/TZYbwr+9Gr5d9Q/2+iZiiDdJzNTCTOC4HD/s?=
 =?us-ascii?Q?7xAyAoCsDoTWUbBtEXoPCRrzAZ2o1R1R/v5kwCVfGw/ybM2nAAJVzNdG36CD?=
 =?us-ascii?Q?YiYPJooQYwoNpgto32peT+LqLZZI7ig8DrRxqSfIvoPI+UE5pl6M6b1sA6gd?=
 =?us-ascii?Q?n8aR+rH/qu6x1FKcZQnM32CMFtiBrf9U63MYPrrW3eBch8ZBewdrQvWMbm1Q?=
 =?us-ascii?Q?kP/XmquPi0JT7LIGmHk1bYcdSAnRAVyuhfPLwV4RJNKfJhnoGtrIvWhqS//C?=
 =?us-ascii?Q?g0tq4FZXL736Qgw3o/IU+0lVrqy34iQ7/ZY03+U5FdFfPo2vkal6ZUKcm9+T?=
 =?us-ascii?Q?y/SPc+S5fhutroX0e/HmM9cEh8CokWCiLp4q2Jpa1n+tuwHjlWyz2DgnzqEU?=
 =?us-ascii?Q?JVJ0inQjqu1c8KXILILgTGQ8v1w44AY1t4oS2A6tHzbjja8Tr/iJWUZe9E5O?=
 =?us-ascii?Q?xVay5W2ADevyx9EjqR/JHcqIG+n4iToPXzaMstgxfzBf93Ma0H++WkCRMtbk?=
 =?us-ascii?Q?Y+Q9EiBryhUhpP/QUULIhfVXG5VfAPVNf5Ns4D6J9jeckkbn9rCnJKd1KMKa?=
 =?us-ascii?Q?QizGjlz1tq0MTLVYSj7N7v/oylUV/SbvrVoVRfW2tB5qxN1mj8ZfbjAW0Ojo?=
 =?us-ascii?Q?hqU7M6i35zlisUEgf3PtQ7zkJUtZl45XWXI98VYE2NGOFbhg/7FI7r125d1w?=
 =?us-ascii?Q?kLo0INYCpJ5tLkyLYT/y2ejiVq+nnRb1e2pKgdr84DOYmfwzTJwMBRw970rK?=
 =?us-ascii?Q?RzLRExLMRomu/iYzlWmrIwAgPum0v4pyGTndKWYgnSw8ojfnk7eSkT07Bsro?=
 =?us-ascii?Q?1/xmb8xeW7tA6feynNn3KcpEoUbZtOsFXPi1XpZP12AHKgLAos62cOi5ZdLc?=
 =?us-ascii?Q?RZGIDm8hsufiEwo1qqCubFE2cISuC5ZY5xcdLAT5Djn5dG322NjhqBZxJehU?=
 =?us-ascii?Q?cjM/YG7g+rnU8fDmtMKTx3Vo21s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e543155f-7d12-468e-0a76-08df3feac1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:56:01.8027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0p2ZZC8OFV9t1Qcjo9fgJmWguOBtPoUaRR9sev72GHWVV8pseVnr9utmWWuVFnkR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999279
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

From: Zihao Mu <zmu@amd.com>

The CPU backend repeats reservation traversal for every PTE batch. An
interrupted wait can also skip a batch whose result the walker ignores.

Wait for the shared root reservation's KERNEL dependencies in prepare,
including calls without an explicit sync. Allocation now commits and
restarts the phase, so dependencies added while the eviction lock was
dropped are covered before the resumed phase writes entries.

Preserve the existing interruptible wait policy. An interruption now
fails prepare before that phase writes any entries, while prior phases
have been committed and receive normal partial-range finalization.
Keep explicit sync handling and the CPU write/flags/commit tail intact.

The update callback now only writes entries and returns zero through
the existing interface. This does not claim that all VM preparation or
SDMA allocation operations have become non-failing.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe20c..89e76e18d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -52,10 +52,19 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_updat=
e_params *p,
 				 struct amdgpu_sync *sync,
 				 u64 k_job_id)
 {
-	if (!sync)
-		return 0;
+	struct dma_resv *resv =3D p->vm->root.bo->tbo.base.resv;
+	long r;
+
+	if (sync) {
+		r =3D amdgpu_sync_wait(sync, true);
+		if (r)
+			return r;
+	}
=20
-	return amdgpu_sync_wait(sync, true);
+	/* Allocation restarts prepare before any further page-table writes. */
+	r =3D dma_resv_wait_timeout(resv, DMA_RESV_USAGE_KERNEL,
+				  true, MAX_SCHEDULE_TIMEOUT);
+	return r < 0 ? r : 0;
 }
=20
 /**
@@ -78,12 +87,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_=
params *p,
 {
 	unsigned int i;
 	uint64_t value;
-	long r;
-
-	r =3D dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL=
,
-				  true, MAX_SCHEDULE_TIMEOUT);
-	if (r < 0)
-		return r;
=20
 	pe +=3D (unsigned long)amdgpu_bo_kptr(&vmbo->bo);
=20
--=20
2.43.0

