Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00B606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=miplI5e0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6792E10F54A;
	Tue, 17 Nov 2026 11:40:46 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C90D10F64A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkywPaui4e8ObUVNPtgIvMlCopBvuqCtFEv9LOyJh8Wo4DAEgohEGywqkzOflW/U2U0EWUg82DYcT2I1zbPcVBElioGGTNO5uyS9YhVqDMqq8JLvEJPEMg1hFV2e10Z1L7WzhYSHOAcMzmBbvigd+T1xyjfqX6GAeLt+GKiUuuqcyenLMuw3SGmQHFgCuv/aBjGwBu2tuu8js1A59uU/BXlyXxvdWCPWaL70fu5jsWg6XFJ/6JJHSbyvjUywNfVjCMTMYwtUPJ1+qxGzwMMr1SmcoBpSsxhYE7eYQDS7FL5hYNIpsOSX0PmzJ+dRlr1VDQ2arQzDt7450DAqVpH/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfXMOhAmgf2fNm+kb7uAzw7nHzklMgJYnzgCRqxGlo4=;
 b=Osa1vc5t2/16aLh4+zSn6D6sQxck7wC1B8wOYxe4tvjZfZN3coaZ0fEQhKSQRyZlETzjHlDglOMM1o5pjAIXTsWK/I7kcaCTBJewDQp/TmC4/Sy3dntTQPCM53ynuugEUdQSyFCGbYjO/MpaJpQfPP8cPvTNdUMS55wdmcYN1yqs5HpPlXUGPJYwLc5c0DkdNd8QJhYx0ZoeOuC6tqadnXMCC91g2x+QSPTpypUEe3Yn/k9dg902W3Yk/7OlPa+x+elft86VcrTwrw5/pL6QX+cOW1f6PvklZD0Lt+QKSbh6KNYyfxMvJ8Sg2i7cPuF6W1unt7jfpIZCkjqelkJG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfXMOhAmgf2fNm+kb7uAzw7nHzklMgJYnzgCRqxGlo4=;
 b=miplI5e0adCnn/s8om02TUu4HMsEi0cZKBm3JGnIKAFiAim0AG1krVm6wABsHFc6cCM0QUP0WOc8w9sMWzrcPHljIQ59glHLsQ+iad25MZefE5fsOkWag7qxDCcjwPO67VG2n/qJsytnejoOwklzTAOf4zi6C0TdaHXO0Prgeq8=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 11:40:05 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:40:05 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 5/5] drm/amdgpu: wait uninterruptibly for page-table
 moves in CPU prepare
Thread-Topic: [RFC PATCH v3 5/5] drm/amdgpu: wait uninterruptibly for
 page-table moves in CPU prepare
Thread-Index: AQHddohj6rmkmAwjd02YYx3288W9DQ==
Date: Tue, 17 Nov 2026 11:40:05 +0000
Message-ID: <MW3PR12MB45722BB121F9BEF7DA3203F39E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
In-Reply-To: <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|SN7PR12MB6861:EE_
x-ms-office365-filtering-correlation-id: ce822562-65dd-41a1-97d9-08df449f867b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|261026121527099003|261021121427099003|11063799006|4143699003|56012099006|261022075727099003|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: HPQYR2GltT88c9zv12iIB8LV2ooYY30sGOudBG2J5IlT5hnkcr2TZCYCbxsc01Ab3K14+ddcXZzhJA6vl0csUYwSunPpVPSihnWYL/eWZTkfkjj3P50U2r+Vxe8EnxQBTkyzGcc9JuJVM6YFPnD7i1JasYYR95eC3nYM2WZMb4ZGWESLO83yXFLeyqPhtC8Yb0H18PkznbTB8Yqmn50lPIhId+Bf86TOAETvQpI5vho45TJL3EwfxwWB72dr3s9C5vg56qSjh3yyjvs31yM6wQRJrxK2EwsYc3Ila39KHZJZSZnL4ZekFrd6aar5IimW4ot/q1PSLlqYVie+JbV6zpl9WYamhh4UThcOvufKcqukESJg21U5lFnGbEdiqO/TpY9YnLKFAFGuV/1UUoO8ClNDJd3ueEiQHxQOApw3xEA03yoMLLVCGUzZXwo1G63Sz/6mXSOI53FalSpRTnhhH3WPAYUf0mGc028gVyvkHTS/END5FB5R2JTnaaNHZfdLGdqBabqnov+B9Bhk5xV9nTHYB48EdhvaGkOYbj2X53US8LBNTOH/uIm/M09y4zz1GnNdUftw0YDnQp8epzOKK607IDHvSRs6oYBRGOMzIVcWpHdjNE5aBo1wQmOoSrvd3w3/2EmOyGskQmlOmJSXSZlimKa9f/j6qFCKbLn0+og=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(261026121527099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sCgLFBzLxv7qlp7QvQ6SRk7FKuV1EnT6QtcGhg71v7xKWj/4UVKGUVJeDt2f?=
 =?us-ascii?Q?Hl6wT4KzcDhLFrzb9tHvLHc79usHT8vdaGpliz0u2Nlzu4Wx7bX0dYIz79iS?=
 =?us-ascii?Q?maKUXb5BXi9ffbpyyDWnLrYs+8d/rvH3Yrh7+1KrXnw5+ddSYnMSo7dECz67?=
 =?us-ascii?Q?fhtoKt+Ua+Cr7RGwjEUOZ7w4Mh2zSTp2CK9LSMlgMFBvIZcEJFq52WZGizvR?=
 =?us-ascii?Q?UxSocPIgcDNjVI0VX8IgSsFBQvvfmTegOJ+oTpsGsBc5oFTn1LOT7ldPUy5e?=
 =?us-ascii?Q?GxAQh1H1nHaEvZ6slhon1842sEVDPJkWtpnt++uZhAdMG6iYWbRidFOZFFbo?=
 =?us-ascii?Q?fGza9Q5AMcoTDgmMFYzaPOhs/ChXbvimYlcFerPITwOliYe3IWPp4eJmBPYo?=
 =?us-ascii?Q?iUc/zVfiW2q5nEDTzirH6IvBxb6A//wybRJkMhF23kjn2LRNr85+39e9wgVS?=
 =?us-ascii?Q?w3UpbmQPrQzPkon/3MToVrNNRLktJpQ3d93J1KpuBgRVsT5ZdksUQnA6zDiA?=
 =?us-ascii?Q?5LQnoIfCZqq6TDNLUTnHn6T2BUXMXtNMPepU770B9VFtkcxMeN1Ok0WpCTc/?=
 =?us-ascii?Q?9skaCeyEPGUALitnxdo1WJXDOiE2/9nEUv+lz8tiOqh1bimtTBbJmzdiA0u5?=
 =?us-ascii?Q?qmPBx60EGGw3I4EprplTNlEI5VJf0a9AWQPAXxowFS2ktqI4I/w8wxic+aYM?=
 =?us-ascii?Q?GmVOqyDwLML+GDKI6B7EztcEGCalk8IQIC1SG3EWiG7pBBeXo5u4nKxVwN6Q?=
 =?us-ascii?Q?/q2JPRTagIEnYCHGMHulFOdssqhxmVrw6pOw9jGyB4yW2QNIfWKhePrlrDOR?=
 =?us-ascii?Q?3pXDmePHUWI7c2AQL/3cOBE0Urzol2+YyiXqPUka3VUY5scv0vi6c39iGK4e?=
 =?us-ascii?Q?eVJh54AvJS/Z4hzo0VmhHDUpjxwm0pUzQwYNJsXoxEaubatvZ/9aOp+muDpS?=
 =?us-ascii?Q?HnJ2V28e07sXy4gMBFwfs+lJqqFq+OQdsyazlX4kg1A44IoUD+z4gT5g3+xC?=
 =?us-ascii?Q?EAfZKxxQIhc/FYR0JIg20ptaR04sReFjb/GqxkqSk6ToxNf0FkqaM+1TCyQR?=
 =?us-ascii?Q?iy+CMqQKJdkJ5aGdG0kZFRK34NM7jPdRqnCxuP8nTBerMtIkb5UqsdDEu1rv?=
 =?us-ascii?Q?JGCniwSwKtYfbYczXvxfFjeiRCT8Dnu0Lbik3A+69QF2jI05y5JpJfOsZoj7?=
 =?us-ascii?Q?yz+xj9uBo7H+PnXDKKohdx5Phe0mIWRAn3qYsRM6fZhgHeva9I8B0Oq5TRoy?=
 =?us-ascii?Q?6bJmmyuvsejrvc4kP0H6WdCUoSMIMXVogvHkhz0n6VvwqZpUN0EETEFFNsZE?=
 =?us-ascii?Q?XV7RoPVViom7pNPKkr+JtVOZ/y3lrR6wzY7LT+8k49PIr2IiOPZvZ+kWsv8v?=
 =?us-ascii?Q?Ns5eIeAopT4TPALEo3BAuLw7IMpFy0PCBJBPGrRcYELOSjcTOZDJXgYhebbP?=
 =?us-ascii?Q?5vxiPnbpZcKVkooCRlvRuf6eUPWF+6cno2SukPNBFttZ/oncBp85X3X0Nu+j?=
 =?us-ascii?Q?xkB3NuAUbWuRrMXS+EGDZyLYMgigVrDM9qo9L0O8lvriZZjneyQKSvUyjGEG?=
 =?us-ascii?Q?Q5PBz6X37QrkvOlzc9F9i00qW8IevaiycAPQZ5YLzDEIBvQ560q9OFH9xmls?=
 =?us-ascii?Q?CNSfCNB5ws8Zfpyn4Ymc7ulKGAc0oN1DafaGbaXYM5IcEvWM7z49+hHpGY1c?=
 =?us-ascii?Q?SaNPtEx0wojwCYeHgVXsnfuIzlc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce822562-65dd-41a1-97d9-08df449f867b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:40:05.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/k972uWzK8+yqONi07kzZnfncgWvvUFP52EYDBBeKyDfjQxQoPTWwMDacPgsEAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

Wait for the shared root KERNEL move dependencies in prepare, including
NULL-sync calls, and remove the per-batch wait from the CPU update.
Allocation now commits and prepares again before further writes.

Use uninterruptible waits for both explicit sync and KERNEL dependencies.
An MMU-notifier unmap must complete even if a signal is pending; moving
an interruptible wait into prepare does not meet that requirement.
The infinite, uninterruptible reservation wait needs no error branch.

Keep the CPU write/flags body and public callback types otherwise
unchanged. SDMA resource-allocation failures remain outside this CPU
signal-handling fix; no allocation retry or no-fail claim is added.

Link: https://lore.kernel.org/amd-gfx/bf90d631-c63e-4df0-92ad-213bd65ef0ba@=
amd.com/
Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_cpu.c
index 7521c5be207..b6d774751cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -50,10 +50,19 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm =
*table)
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
 				 struct amdgpu_sync *sync)
 {
-	if (!sync)
-		return 0;
+	struct dma_resv *resv =3D p->vm->root.bo->tbo.base.resv;
+	int r;
=20
-	return amdgpu_sync_wait(sync, true);
+	if (sync) {
+		r =3D amdgpu_sync_wait(sync, false);
+		if (r)
+			return r;
+	}
+
+	/* MMU-notifier unmaps must finish, including when a signal is pending. *=
/
+	dma_resv_wait_timeout(resv, DMA_RESV_USAGE_KERNEL,
+			      false, MAX_SCHEDULE_TIMEOUT);
+	return 0;
 }
=20
 /**
@@ -76,12 +85,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_=
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

