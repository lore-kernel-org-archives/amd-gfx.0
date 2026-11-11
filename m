Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3B606A331
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p5Gg4OuQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE41010FB81;
	Wed, 11 Nov 2026 11:56:08 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C9010FB78
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTnIcLYqgACDFarJSsG3mjr3OOKPipCMDxYI7xfkLFiDbjePQbLm1vlJ6Ju/afXdUA7J2n5hFSdST33U6AORhOhOahVNPE921tlWlje8Kgmu+ZYLngo6VZt4ftQM9+FoBpNAd8Cdujo2X5kI9LE/CQR+oMJnWetHbJEMYrc7TPsnCzIa2Kql0lQm4XDhvOm5Jf8FhZVD3MMsJY9/Dtsu8ZGt8e6+9eTA1CQK3cBIexcQIW22QEbHNJsyftDqKA0iWDLltjUHuVn3JNQEchwDg2dyWLX7jsbuwWCPIwWCIdLpyUyLw0on8BwTPsaNwUZWfNgGqau6PR8kMM9OiVLSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohzycRoa+vkOjRmcP6S7ZuIwcLPU0kpf4hIlrtyuPJE=;
 b=LRi91NPMmve8QAgrhykq5mxO7UlVVqUyQQRK5zeLJz6fw8+0zW5XZnIMIeCIlP6dcxB79vbhuFZEpHMfQDXPfJmrPJCQO9UMsGmS4ODwjBXDDcO+cezx39ZOfnlUjmYy58fsnm5Z3FiBz/i/ZH2AyGxmk4Y9oeJPCxBSKinL1kmUgQR5QqXqyKK/qce2DcQk/iFHM53qdzrdooq3hwZDiIJRZW0wB13/Ru6aiu8c/qxOw9fs9q/BLIz689nwNMyM9Yug1Uw1DlpUmNsvZHmNgVuEZZ2F4+Gz8gJ1xl2OPCWeA2mE0CT7AWZkGFFcq4Hb6gUwWQzTgXKRoixZ5dqpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohzycRoa+vkOjRmcP6S7ZuIwcLPU0kpf4hIlrtyuPJE=;
 b=p5Gg4OuQvcPJtp3H96TuXUYRg9qy4HpfaOC4AcSYvxBQmw/kBZdk4VX4cvQ5GrOBaY3iB3Agk6fSaTySru4zmSPkvcgnOsfSugM2Zs+6LEzRWAEZodvFkeHAaGyQVsimn0glV9p59HWvfH2EwbB13TD0FPIH1I+gx0RDwtluL5E=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:55 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:55 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 4/6] drm/amdgpu: unwind failed page-table initialization
Thread-Topic: [RFC PATCH v2 4/6] drm/amdgpu: unwind failed page-table
 initialization
Thread-Index: AQHdcdObBqvQhdaQ6UqIIIy18BaQeg==
Date: Wed, 11 Nov 2026 11:55:55 +0000
Message-ID: <MW3PR12MB4572B43E948F524191A58EF09E712@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: a31611c3-aae7-4439-56d3-08df3feabdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: DpB5OZic+hBIQl/fTffWdO/Og7iq1/Q0y3+Stm9VXpnaXUtCecM2C/OQ4dGVV7A/mXEuaokW92tOlz4dbEKXBqU5Jff2ONV7c5f4rEM7OGAOZ0RyC4zs2A2omFRoXnGNWhXwJDcAnKR6ZSuOVfzlyT7TxZ9yfiswnwsYWip68qCbzqM0JuyuWpVUD/bMTdlNP+u1C625StjG4184Js/65bsT6T3D9voNYvUYSy0//NIjcMFlD47qBgtOW4TjQ6YGedoRZXM+O7ZQZjItAcii5Y9n1hoYM55RFqH6325j5LtNv7hL1dWAayB6MiPq1czpFCamV4qX0jsCeK17jX/yXcWolQEjovr4Zi5If3WUV+COawTjPPGIpkxQhcnoiB5BKp+cmXdA82V4u1amGgM9+2q6GQ49TKgS+MuFAv8lNbxVNekdcB2AykWCz4QAA3BsGWKHIn00lTEaxkKG8qZGdXK9MeBsrjsJ5otkg0aKFjqKPTjUnzVkk1ZvT468t46hTVsAxGBOTHlDpqamBcyXqJwfx7KQ7sZG2D0IXfuIzHF5gATOAVeD0jGI/CI8QmUKiucfgoX4XyCXOfDwxc9ajEf/7clLJulnB8xBHbG7wTfDYSBJ7i4NEl/R1r4HDeOAY8MeYx5Vfd7BcQllwmseWtYn1IU97Px7t/wUifwQvatYE0mCykwhqk+BJKlAIc/qTHh5XA3uC8W1c/5WATc1d7w8ImalUfW6MUvmiIC64fw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hM6rAaTrbitXobhmRozcJmYCFJjnlD5y4RQ0ZMhe281L9ZYndRKgdy3G660f?=
 =?us-ascii?Q?JxWTRpSv9x4uCLOkQbqQrEky2dQxNRs3BQernT5TMvvNqwQZV73dJxlFbOf8?=
 =?us-ascii?Q?8wfMsGiiVh4u2jQzI2Uze63J/99jHXBCNyxMxyNkMJAdoGVp1anj/tT7+1yu?=
 =?us-ascii?Q?mWfK9RBnj79itCsbYnQPBwXUSGk3tW7GF+ahdssN9YDD2x7DGEQCCkrGMDe0?=
 =?us-ascii?Q?X6MXxVso0Upg15d3wi+LuwacAC9CCZs+RZpIDdoLpJES2R74qx6UwYyVM1+S?=
 =?us-ascii?Q?3t64nB72nPtRKVYlyaz7Z/CW55zQqPjuLIC81myhdHf9rQj4/UqiilEsKcoV?=
 =?us-ascii?Q?JuRxt1X/sViCDD3Ec66Ax6JbNuWOPrQ7Xd2jBy+bry4bjxRdwWbLUEaagKTg?=
 =?us-ascii?Q?h/GbuRQNJoizAml2W2XweKFlupSe7DOxAmMNoYQHJxLDk4NgFv9pQTfnhGtb?=
 =?us-ascii?Q?TWmNgB3K9/hW64VhLkfeWFxuBh16nq+AUqPNIlN9Do0dGWhYObh2MR1TTTwx?=
 =?us-ascii?Q?dNOETa52G3vpEctlx5n2jUerrFgzZV6cRjkC2TmfU408syi4grhSGI73f3wx?=
 =?us-ascii?Q?fGhIDOXnsXp5e0rQ8Te+V+qyQlqPMFM4Jf793dsHXwjgFtceqap49Nc3AclJ?=
 =?us-ascii?Q?gVehE6ym61Df0Sho2FAgmCB+CTXP+hLC8FnDi7+eX5V/hw2Xn/zD2SIgrFem?=
 =?us-ascii?Q?yzLKw2gvb3/cdE5QjMpXH4FYpojHF40IZKxG7SSQLJPzaLsm1FYCdcdueGXo?=
 =?us-ascii?Q?zPbNY1/LWk2rLdQCRuX9Ur4E9buBijdElXIHv7xR00y2O4YMYvUA35X16UYF?=
 =?us-ascii?Q?/MsmxQRWFRYlIsfw841+ij+vobhKB5Fepxtr9WkLR9GAOP5gWMONjmunxoZf?=
 =?us-ascii?Q?r2/8Uw4DNh5hGPsAW5wvcmSN9RD11iyv/T1eBfQOBzbSlqa/r96K27/S/OlJ?=
 =?us-ascii?Q?9+4HLNhITTwJkfdrP35TO2bZoXoP3ywcAN89Sm3rlehZAmi6OaUTc3f9okas?=
 =?us-ascii?Q?vxXHApG5qbgc3Dsy5NZ9Mvt/nyjvR2s8xW0XrAXnv8tBcGSr4xTdDTDv7o6k?=
 =?us-ascii?Q?tSeDdCxUlSGPBdEbqwpeVC8a9ryZ6defQ5XUeewhJ3J8EYxfXitQHLyrUNBH?=
 =?us-ascii?Q?1dS2RWWrLNH0S6xoMIxf7Q1S4UFFTG0C/UgCIW0Lfpt37Yd+7JWP/HnE19Bq?=
 =?us-ascii?Q?SdZ/Au8RWjCw7IbISJHwbIrferfVXcUdKK2e1olcUViQ6OLC2OmBLX65VkFZ?=
 =?us-ascii?Q?CCOYGGdbEwQVBbF+1vIBQ0h+D8k5jXQbHCW0WKBpvhibtqoa63uuWGsV/PGA?=
 =?us-ascii?Q?mSa9Ogi1rOhR2KPxIIFJzMeBO+rnL86IXBGkSt0gUu9u8zKMcuH8f52KdYs+?=
 =?us-ascii?Q?H9rWWshkhU0d48C4ed9Ws8mxttN8K2G8lPyA1ormOI68oBj/a3MOLJ9Lz8Ox?=
 =?us-ascii?Q?opyTE4/YfHwtmDctY2U3Pe+m0Wc5xuHXX9x1UM9fKb9AZ7XqFg+OrTHAi0RZ?=
 =?us-ascii?Q?+fP/jow7OmfX7mwIS0vYwwWLF4TkC8ZtEExZ9w+8eHYgSurmT1FSbDQCBBaA?=
 =?us-ascii?Q?eROLfA4zYWMYjpWu6xrtsQqb6lGX+P5tI2YiX9jgggY5ZjI7AfH5bNqCPVA6?=
 =?us-ascii?Q?0y3fXxZMe6880py5cgynJ56wQvOaUAe1+vWFOS/cdYK7Et1VI8/vfZasGWxf?=
 =?us-ascii?Q?tYOG/smjZFjHhXRowOwA9/85UZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31611c3-aae7-4439-56d3-08df3feabdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:55.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CFUfzZY5uiaaTzpwjjpX3TrE8fmrqyeePUySKn7t7EOxbHXW8y5rSJB6WKtE0lh
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

A new table is linked to the VM before it is cleared. If clearing fails,
the allocation path only unpins and drops the BO reference, leaving the
entry, VM status list and accounting referring to that BO.

Unwind the initialized entry through amdgpu_vm_pt_free() instead. Finish
any partial SDMA clear before returning its original error, so no current
job is abandoned. The tracked completion and reservation fences retain
the submitted work while TTM handles the BO release.

Keep this initialization-error fix separate from the update-phase
boundary changes. PDE iteration and its error policy are not changed.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index 9955be111ce..bdd06b7718c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -372,7 +372,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
 	struct amdgpu_bo *bo =3D &vmbo->bo;
 	uint64_t value =3D 0, flags =3D 0;
 	uint64_t addr;
-	int r, idx;
+	int r, commit_r, idx;
=20
 	/* Figure out our place in the hierarchy */
 	if (ancestor->parent) {
@@ -426,10 +426,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
=20
 	r =3D vm->update_funcs->update(&params, vmbo, addr, 0, entries,
 				     value, flags);
-	if (r)
-		goto exit;
-
-	r =3D vm->update_funcs->commit(&params, &vm->last_update);
+	commit_r =3D vm->update_funcs->commit(&params, &vm->last_update);
+	if (!r)
+		r =3D commit_r;
 exit:
 	if (last_update && params.last_update)
 		swap(*last_update, params.last_update);
@@ -507,6 +506,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 	return 0;
 }
=20
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -550,8 +551,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_=
params *p,
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate,
 			       &p->last_update);
-	if (r)
-		goto error_unpin;
+	if (r) {
+		amdgpu_vm_pt_free(entry);
+		return r;
+	}
=20
 	return 0;
=20
--=20
2.43.0

