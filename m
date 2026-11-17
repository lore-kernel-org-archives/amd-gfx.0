Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D9606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4AvhRBXX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B7010F600;
	Tue, 17 Nov 2026 11:40:35 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A9F10F64A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhF4Djr95lwiTLCJ5BZZkN1z5y66iMTke94mBOD2mRp0azRiVnPZPfirmZ+Gp/RjBZ5wLH7ou4K/A+OMtJf8tYNApZuBNRqDSJGi6WiIt0sGY+qCELx6RcrKwCPvAgxk0adZgSJz/HaOnlpObP+TLd5m+kyRBGnmspBXDKzXO1qsXsnqs/AHz400QkF5sgATEa6VMAFg3/URRxeCrDOy9IiKrVWoicTFwQWoxGRtHfMnJ97XKetHlrRmMUsbGvURZyWcIwUTOSr6QW2b1/rMOQ9yrW9As37/p9GVOodYCat15wgjH4wtAMsB4ZBcj8is17Qi5eIMBBJdnKW8iflKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP6PuTsRPpDKRL0UoF3qCerQ9ChUaCZLiPfIDoiB1RM=;
 b=rDa3d3bg9ClsmvW4IzHxQUwbgkdWysU4vc7MIyLJ3Dwv5fj3o406yqmyTmnKftymZEoaY65b0K68xjTg62yUkOwFC0Md1FWU1vBrcQZShojx+PBjf4X9hT3Lt+oCg2CsdrjgVh6xfI0OpBETGh/1cnb7DUS9jbHrRsJAB/4EWSk8mjrK7XdNckphUvIvsLszHNd5mEdojrfsn7emmOsmQfbvPGy7DtDA0mLW/j7K45CJXSaTexbYN5MGyw+IRQe4JERZjwGHkm41I8B3zcurIwRNDhreYx270tcDn39S/sW6krbvQY6y8liOouOQTzY8rGFDJSrk5jFClNvLXxbSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP6PuTsRPpDKRL0UoF3qCerQ9ChUaCZLiPfIDoiB1RM=;
 b=4AvhRBXXYBKWNnRgBswPaNdLML5afau76lFfGL/YylkD3L16ecIkJWso6LmZt93fpAIYgXkWM+iz5EuYt8rLzKN2uuDAaY4G2J82fCCmfduDm033r7S/9sMrWutejR3nJ6rBh4ENzkOPIzox2jOGWFWM0QAXpMDPtq5asX3iPHc=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 11:39:49 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:39:49 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 1/5] drm/amdgpu: pass job id as part of
 amdgpu_vm_update_params
Thread-Topic: [RFC PATCH v3 1/5] drm/amdgpu: pass job id as part of
 amdgpu_vm_update_params
Thread-Index: AQHddohalE4/GIMrSk+EkSELs2AkJg==
Date: Tue, 17 Nov 2026 11:39:48 +0000
Message-ID: <MW3PR12MB45728092AA08C322A8863E529E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 040552f9-cae6-4afd-7df2-08df449f7ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|261026121527099003|261021121427099003|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: mzePiYrTbguo7cbsQJObM+KnZyUpgHSfVWO2WatUx74GwzIrRxSvD7ycnJE3p3hmEr0A5ruqX1AqoJOQBwic0SNaxcaI/Iu2yqZQArY7/3E+MYgae6cabnjxnpLlprUwB3ywSECIg7NaR05vWi2Jlmch9opfB6bHAbKsHjt/tCeOucdtHj1W7uUD8qQFDvSUSC43OthbySZAtq5K5s5nvsFb5TybbCiD+c59zYwHqmYXZKXAHvPw3YntjJtx60UYIOhfS6eoro55NeimFT9ElZPfwe0AUgB2xoJ7MNyDRPyO96xoYNJjzJr5Ed+1qU2mTHE9WlfZq4jFWk06c5ClRP/uKq7+8BTHCoGO+ZDylJ2bEaHG1NJfb2ANu1lkOqS73DaN2s8+28YdJ8XToa84h62K8RJznHEupkSvv9GNqj3hsgpnY1CiUwTkKORqxh7cOWJic5AekQXvz0VhbJaP56TceILxCowMigzphAmQyzIe7nFXuZqWxsA3ZEJNKDDwlbXJtkA5cu7IK0UGK6pSun+8b8MrGBqN4X3CaLLv6QXclq2QgvVSAqCw3bsuO3pxhdz6hxjFcB8l+oaPbTfKif6QTJEIpoAp515NkwS/3De4kMJLo5Ms7vQ7FlMJFPU7YGquhme/ZA7uHpAnICz8qeGX2Yhk8n9okpP37AlXZ+DREXbYJhJu0qWBC2VQSBH0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(261026121527099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p8f9pFS7eqUa8ws22f+16UcmY6ijoZroJP1bw+PYpZ6oNZqiQ/lmOkRVtDH3?=
 =?us-ascii?Q?PVh0xeGMKZdacvoqWLas7megw6b2d90Ie2bs6NSlwOP9Br3UQkQfPMmnioe1?=
 =?us-ascii?Q?aoQKYWpbpq9si+sv9Siu+CwxgYyPOoCGeTPMczWsGDfAwcVWmjHuMrr8osGT?=
 =?us-ascii?Q?vNYLDLeCMgH+B5qtJ0skSCqV6+EP10Gwk0IE4Y5ZoXjbR8g/H6Cl9zz541K/?=
 =?us-ascii?Q?FcevVCbKpC8lZrUO2nBHE7fRq1eE03DRrOcWNXhMNTJU+VwquhIVGlsPYN31?=
 =?us-ascii?Q?wSwdGdWzo5uJLHI8Ok/SlZXdZJV45Ru/IxDhEJWBQSQApN2drvlzN+DDTm96?=
 =?us-ascii?Q?iOEOpNncesFtvMAnxAAEnRdlQD2qbfYPEttYkqZnyjhqePQEBTJmSxnt2arW?=
 =?us-ascii?Q?LVz5mj/q5g2KDYJiK6vpdtnNa8N8AFP7gvbo3pLsPlTnwbd+0dL7LmW7RdxY?=
 =?us-ascii?Q?JiD0H/ynR6NpcsA5Ebf+ZKbgP1LCIEOSo9UDbC2EorQ8x+F+w4EPjmKqHUjf?=
 =?us-ascii?Q?Xn7eOdRROEvdkIYolMNCRtG4gZ3LjSyNu2Y7VAK1/eF4H/mMyJoGxzZdqrxY?=
 =?us-ascii?Q?mzi9iE/iQqag6gb0JH7fdS3kAdLW6/+cljRNzbeM0QCiEfbpJvFDccKEb+gn?=
 =?us-ascii?Q?/6x+B14/eA4+ytk5f3GGWBV3HLQCkcUfTdPgP/Vf6gHEjw/dlOFK4cZegXQU?=
 =?us-ascii?Q?AHOT4jUDczeNzd6ikAxC3YFveG+FR1p9usCLHoVlt+aLffHNDS3/bQauFUWd?=
 =?us-ascii?Q?gfRvMnLYsLxRehffuKILrVdDtoaWLEf6EroliWt2+Xk8CAIGcmFKvcb+DK0/?=
 =?us-ascii?Q?wgifiZTItOTmOyDSNH3RNAAZ8AizVjW84sv0whmoLhYchE2d5eXaBjgShzP8?=
 =?us-ascii?Q?gjI+BS/dIp5Unta4+Lr0McfiZoUjJ0cWZpjV80aza65rLASxmXAys5DQeqHi?=
 =?us-ascii?Q?mcgz0cJYZMf4fWX8hL7CeSIDPS7TJ/JOUpP2J/OCLKJ4mkktdV36EQI4SFdr?=
 =?us-ascii?Q?EVQCNnjZhKoYr6SmQ2ipveWicOISMLFjxXXPO+OQbqbT4ENDl+i5R00aeF7a?=
 =?us-ascii?Q?g2dZ8mWjflc0KHzi7Ogu3TEai/9FnApNYU4vY006XK06zWqdRSNbWhRfxRx2?=
 =?us-ascii?Q?QytXauDEMRgeP11NZ8zOYIOZr/3g5PJBkXiybG24XPAYM4MrBcEIxnprhXrn?=
 =?us-ascii?Q?mK0KsxjR9Xys7xeubM4pGusBTgE81Nj8xIwpIJKTfZ+XVkPsHXnIpJKvVUZr?=
 =?us-ascii?Q?b46JYp85F0f4UDIg0WyMJvpZgFuxsKQTMbqi+dDTcZALXo7Mv45QVOTkb4Cs?=
 =?us-ascii?Q?h5XDJFn7CCARpXGUy53iQ7uMNZmRBR0FET1dSvVr2/nXJjEHFLdosyI1oQMo?=
 =?us-ascii?Q?5LoKZ/AbfdgnZbCMqL+1+MI7GWsS5hISKNaB0F5/FWhcwD+qRZqZt9f78Ta/?=
 =?us-ascii?Q?yyj9caeP9gGaz2d1gNsSGIP5ytDP5uB20LjeLWLfJrvdIW97ZFh793Pv8WnR?=
 =?us-ascii?Q?L8V7h3mnD/c5RpMXUhUOJ9wQRz09k9GHwsOdmjAiF3uDDfmEu6lEybfHuRKI?=
 =?us-ascii?Q?m9/JbaB0DUR225B8OXqpHTBUbbaWMux246arMPkF18ZfxPBVneQF8RdzLMAm?=
 =?us-ascii?Q?3h2sOHz19730pAsgqllzl0oWhu9Ll69yEU5guY5WVkuddWQtG1o2HohVqxkk?=
 =?us-ascii?Q?yKOI3hdjhkCUjTFdJYMpoL5qWzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040552f9-cae6-4afd-7df2-08df449f7ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:39:49.0895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIrTV4DFPcbGV9/yXcTX1Nvd3QM/6XVeSq/cXjUABjlWLMdqoIf4epAwhHmJMwm5
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

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Keep the original identifier in the update context so replacement jobs
and phases restarted around allocation use the same tracing identity.

Initialize the ID for range, PDE and table-clear contexts. Use it in
SDMA's initial and rollover allocations, and remove prepare's separate
job-ID argument from both backends and the callback type.

[zmu: Complete the SDMA prepare/alloc_job/rollover changes omitted from
the inline proposal, and adapt to the current context layout.]
Link: https://lore.kernel.org/amd-gfx/avRl4ajLaCSa8AeG@quatroqueijos.cascar=
do.eti.br/
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     | 12 +++++-------
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 172af3b8f1a..7199cec1f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1055,8 +1055,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.vm =3D vm;
 	params.immediate =3D immediate;
=20
-	r =3D vm->update_funcs->prepare(&params, NULL,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
+	params.k_job_id =3D AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES;
+	r =3D vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto error;
=20
@@ -1218,8 +1218,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 		dma_fence_put(tmp);
 	}
=20
-	r =3D vm->update_funcs->prepare(&params, sync,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
+	params.k_job_id =3D AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE;
+	r =3D vm->update_funcs->prepare(&params, sync);
 	if (r)
 		goto error_free;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_cpu.c
index 8c7afd34783..7521c5be207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -43,14 +43,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm =
*table)
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: sync obj with fences to wait on
- * @k_job_id: the id for tracing/debug purposes
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
-				 struct amdgpu_sync *sync,
-				 u64 k_job_id)
+				 struct amdgpu_sync *sync)
 {
 	if (!sync)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_internal.h
index 0b7cc3a1701..ea52be053d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -77,6 +77,11 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_job *job;
=20
+	/**
+	 * @k_job_id: original job identifier for every submission in this contex=
t
+	 */
+	u64 k_job_id;
+
 	/**
 	 * @num_dw_left: number of dw left for the IB
 	 */
@@ -107,7 +112,7 @@ struct amdgpu_vm_update_params {
 struct amdgpu_vm_update_funcs {
 	int (*map_table)(struct amdgpu_bo_vm *bo);
 	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync, u64 k_job_id);
+		       struct amdgpu_sync *sync);
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index f205adfd59e..0ff2d06bf53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -399,8 +399,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
 	params.vm =3D vm;
 	params.immediate =3D immediate;
=20
-	r =3D vm->update_funcs->prepare(&params, NULL,
-				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
+	params.k_job_id =3D AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR;
+	r =3D vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto exit;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index e7180a6661a..38ca2d78b38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -41,7 +41,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *=
table)
=20
 /* Allocate a new job for @count PTE updates */
 static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
-				    unsigned int count, u64 k_job_id)
+				    unsigned int count)
 {
 	enum amdgpu_ib_pool_type pool =3D p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
 		: AMDGPU_IB_POOL_DELAYED;
@@ -57,7 +57,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_upda=
te_params *p,
 	ndw =3D min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
=20
 	r =3D amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
-				     ndw * 4, pool, k_job_id, &p->job);
+				     ndw * 4, pool, p->k_job_id, &p->job);
 	if (r)
 		return r;
=20
@@ -70,17 +70,16 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_up=
date_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: amdgpu_sync object with fences to wait for
- * @k_job_id: identifier of the job, for tracing purpose
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
-				  struct amdgpu_sync *sync, u64 k_job_id)
+				  struct amdgpu_sync *sync)
 {
 	int r;
=20
-	r =3D amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
+	r =3D amdgpu_vm_sdma_alloc_job(p, 0);
 	if (r)
 		return r;
=20
@@ -256,8 +255,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_updat=
e_params *p,
 		if (ndw < 32) {
 			amdgpu_vm_sdma_commit(p, NULL);
=20
-			r =3D amdgpu_vm_sdma_alloc_job(p, count,
-						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
+			r =3D amdgpu_vm_sdma_alloc_job(p, count);
 			if (r)
 				return r;
=20
--=20
2.43.0

