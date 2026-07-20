Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A61C44520
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 15:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B8A10E9A2;
	Mon, 20 Jul 2026 15:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIPmvHzP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44B610E9A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 15:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpm1q1I/AEEFz8i8gP9XPoAvzYHfjcXVjzjRBhrfEzIzAeAydPZRlFxv4VSp43UAG2Y/P8ykPab5u2D3lWGs12iJZ99c3WwCZMKDzl0O/fut+/qb3hzZrlnPyNXgaG3WQ1h9uMO6NjqIkgrGCq9r9TjT6vsPZmJzk4LS+y4MhrjUg7oXkCof6vo+kTFCADKsB5vY5QoxuHj9TUZtGM3F2dUItLjtab7ljRMmKj/bKGBn3TjokUiq1GFu+eV21faTjDlTFINcToWcAb3Pp7p2hJ4Ry6uFM1daDrwVCoKA59gvif76xs84Zbhv+5T9a654POAp0Zx/pH/6Gp7wiMyCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc3L9xMIY6ucFEUSlXV/QBib0BtymkWyuiFAWqw4mfs=;
 b=FaRVDQ92qWb9dMlvqWKMEmQPlaL7Eq2JCQ6LIs/rtnor2QGxVO8uUttwL7g8hCu5QDFYEHUXLdDVACWd1kltY4Ds/SHq3Ey2mNT7B8Vt9vVIu8ttcRIqVUHYNdNZ1pyIhklcPNdaTYNiBopODsozF3g2jBUTKESopIgMxCPw6jVvi8A/6wIqSchzC9G2DhlCq9Nm31gEGg7q5OxOby/ZFqpzJnFnsSfR4SqK4efEu7/DF+uylW1E23QIkM21u7dgkoO0U6KM0uLtAVSvgttqJzM79peohe8mxJiU7pytVsbb5hxthtkfh+hK+xZUv0HuTTguBrXffaRGYruzKb/Qrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc3L9xMIY6ucFEUSlXV/QBib0BtymkWyuiFAWqw4mfs=;
 b=cIPmvHzPQeNr/BFA1xm9sVozq/ay0ItglJ83Ti5saU9X1wQQthmjOn04cXhcda0syb5XrAq0+S3j9bJ4spkNDMeGSaJIOvAtFCb3lM3C3D1OPAtuBa6uluUXQYcPfFAhYnNqcvsQjRf2Mvy6lgMkdRkZ0PdNedayLfBY1Pgc2vM=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:42:17 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0202.023; Mon, 20 Jul 2026
 15:42:17 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions
Thread-Topic: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions
Thread-Index: AQHdF6Us5o0l+E5ssUyWJsQt4r62+rZ2jTMo
Date: Mon, 20 Jul 2026 15:42:17 +0000
Message-ID: <DM6PR12MB3611824F6F06889882D1665E94C32@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260719173627.3598744-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260719173627.3598744-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-20T15:42:16.095Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|MN2PR12MB4190:EE_
x-ms-office365-filtering-correlation-id: 49d3437c-1f58-4373-88d9-08dee6757a6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|8096899003|3023799007;
x-microsoft-antispam-message-info: kRIXlM8BTD6dJwT8rTeyuH+UbGUjBX1B0XurZdrWHnQs3ZM5B16rxxje9nRSGPdWe3KQprjVbYgES6hwCQeTzQ+Ve3Blv6KKf/dRJYaLH3d0iLHQ1f9xCFOJepG5QEY26buhylVUhgSHdLSClKnTSJ8lUYvDDQ7qgTQt3r31iF9/qsYLQwjtPLrHq6aCUK/4F18mtRGbnHpXMhaHsS7c6NXDeh9YJU1upsfHz/F/gsdd97eaTg49n13RsqSpS5T7HnYfVdXgpM1r3SFktoSWFWpK4IijQ5+5CK+zZbmQIre//7zW0WMaWT9U/fFFkz6pMtLP/EMSA7CBjRobRs1XqC/CMm7t1U+cwkBY8n/2HGH1Ix+quhPTUrKEcjCTTao8dL6sXuOY0G8rA2Y47xp6yeKH8oVPU8XnstjvWbgmUC6BrWjRgPKkzoEceT+2nuX9Svas+xWjWD5gOhYXXPTSZ1knK3rklwyZOgYYaAFV5ADAAFIM2hLxLEsgIBsI6EH86EOb3mHxa0SfZv3lZAzw+/NnFRv7/Rl7kP+DhqgDYU80Ez/lbJ3xyjs/0cxuoJGgoN08MAu7KpN0ohrtwKvOyS8iY4g0RB9GHkiNIT1T//Y4VXY5BqONfGNm0ZfDTr9DFd2L+s3CI1EP/PAB0tRWbXoJRxi122D213PEvDDNovT2lDRbdundM2wrUGZTgbjIQPGkpBIw++X/2porTAfKzgQcM9eWWiXQUmlmxkDeOh8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6M50SzTwCxb3c0mM//gmZ9O7tKnCXvU8HGsC+k0R/hbX/UFHtfCjthtBDV8j?=
 =?us-ascii?Q?LO57WLv0jNqgviGxVYxtwFkzXXcWrsWtPgo03cSEcN3Tf5Gt1EFxnGid1gjr?=
 =?us-ascii?Q?gi3/AyfXhjfLt2z1IsW5kFZ0PfGNGvxtqXmaRbh758n5KMQ7SuNPoiHvrafw?=
 =?us-ascii?Q?+GPuEAqUJzyN6bGTieSTzeaomTt/nFq2xoMM+54gc9C8RJBCmpytxDQfoLlK?=
 =?us-ascii?Q?NHVC4zP3Bu6oIJw+7oA3Wf8uqd960MPZh9pi2kw0Y1w9XryEapeh+WIJDnKE?=
 =?us-ascii?Q?OaAX/OW/Yuu+aHuL8wgHiQ+LJEAKqIh0OLelKBZ92rHF0PRYHIU6S9RvN1qB?=
 =?us-ascii?Q?AfM8m5VhCwm7Hn2NINJ+um5k0e4WQp2BdxSBvkEJI6931BRClhGhAXOVuma8?=
 =?us-ascii?Q?XqST2cS18BU0fvtQs9wX8mqM0qrcQgPqoHQd009A+sJCwvIUiTyiBmnsSReF?=
 =?us-ascii?Q?WQzUcfDIbqsJiS7R60gKCJPw1eBXg6e0te0pQn8S6yiVM1JNJESOXIajltCo?=
 =?us-ascii?Q?GyOFVLg7acYwGI0mceV4/uRDRWEiQ4kwd966MGbtNIDYsbgxhWwl914YO1gf?=
 =?us-ascii?Q?GULcWC+T3HKm2Ir2qYfEh8O9WMM2diKE0TXo+hokzBIblCR2zk6wH7Ad2Q8n?=
 =?us-ascii?Q?BGd22aNTgCugm02/Lq52c8r5nmDtFfyOnP4gpIVVKlfmnNjl4c+dHhogIVpX?=
 =?us-ascii?Q?gnxIDfDMQ9q5N2NIwZ+S9YzuP5RF6fYxW9xpJCk27cjPeViD20hWKAc4qoVd?=
 =?us-ascii?Q?fxe4LXU8eEgr+qRn6YY7mV4bdNAU4ildWwAT5F+GdmaQNwIRc5yi0128gPbB?=
 =?us-ascii?Q?JAtCmXdT1+P7ktohPCy/DorRcusHZCRAOb0F9NNdjhBDJ/uNCJ/URUZs7W6W?=
 =?us-ascii?Q?5+irJiYcL3rhFdBUw+DkabtSVL8P0/DKIasjrei+QOqe5UoDGGzOFQKag397?=
 =?us-ascii?Q?p+S+dbZIyDJlY1BNJx4OTR5eE3YauriEwUdDUgNJkqiusCX0t8fUsJ2XZRmf?=
 =?us-ascii?Q?PJSQQq3UvZiTbJ/cXGoRuVBEPdp3iArdMaBWaVJ9DkeKkUpXc0IprcGP71u4?=
 =?us-ascii?Q?efrWm5Vp6DsK2oKQzIiOWNPlC8YDK4I5K9Ya7lqL7xJqC2NHMR2niGK8JNRv?=
 =?us-ascii?Q?X3HumOh72d/H3asHmmQJIs0/Q+/HYglKWQMCOciKT8LBsm6Oipgn3/N2Cko6?=
 =?us-ascii?Q?m7iH6D4wdJp3inrLxb5M7gTlfWhMW1hR7S6SVK+WSWwPNVSDVK0a42dkd+tf?=
 =?us-ascii?Q?wKaFoJHWj4DK7GKCj0p+vSIstJXQFYRq+IJnxABFUyB4wiRvynkCwxryb0ah?=
 =?us-ascii?Q?xqwvgXDiw4RiNTHZyA8e4gdAG1kRScvVbQLhSGroz8qUrNHWWI5LgYk4ikvI?=
 =?us-ascii?Q?zmiGSrkY8uy4v211JwfcXspsnfJJVw5l4lTP0GiSsbhD/1zMOid024TcUw77?=
 =?us-ascii?Q?6R0tKSr/G4LNJ0dr2T7s8i4y2F+J5oKAfjGJWl+8+hYiZCZ58/AfWBck3u5t?=
 =?us-ascii?Q?K1aSodkLVjmWD0nXS0/Phlf1rOgswqggEvqBxwWPTIw0CEKDRkixaLXrIgkn?=
 =?us-ascii?Q?C3hj7EEEp7ucXhy1mezO+7Gwi96Pf0KFD4p65fOz06sbKZP1TBTUfgrAcaSK?=
 =?us-ascii?Q?jy2SjPB2Hv7t86cqusimEc9yVYylEpCxSbczWhy66wgD5pqCP//hzA4gL/rc?=
 =?us-ascii?Q?9vKZjC4BkWZfxvX21Px1eNiBHPdWRuCXKN/+iWywEI1iuy/t?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3611824F6F06889882D1665E94C32DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d3437c-1f58-4373-88d9-08dee6757a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:42:17.2172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7WActoJyzX/25XuEFvv65DR5h/e0sdaPyZTkWRqqFF/MMO22M37ISTXpzv92g5e557wQYShTCaJfnptDCWWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

--_000_DM6PR12MB3611824F6F06889882D1665E94C32DM6PR12MB3611namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Sunday, July 19, 2026 1:36 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike <Prike.Liang@amd=
.com>; Chen, Michael <Michael.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions

Complete the kernel-doc comments for the MES RS64 memory, process
context, and gang context helper functions by documenting the missing
function parameters to keep the kernel-doc comments consistent with
their function signatures.

Fixes: d160cbf3e4db ("drm/amdgpu: add RS64 local memory context array init/=
fini")
Fixes: dded4c22699e ("drm/amdgpu: add mes process context alloc/free")
Fixes: a755b0cf3ef3 ("drm/amdgpu: add mes gang contex alloc/free helper")
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Michael Chen <michael.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++--------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 1e3a23c81552..9af7c97af5be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -952,9 +952,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)
         return 0;
 }

-/**
- * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
- */
+ /**
+  * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
+  *
+  * @mes: MES instance
+  */
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
 {
         if (mes->ctx_array_size_bo) {
@@ -1038,9 +1040,10 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_m=
es *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
+ * @queue: Usermode queue receiving the allocated process context index
  *
- * Returns 0 on success, -ENOSPC if all slots are used (caller should
- * fall back to system memory path).
+ * Returns 0 on success, -ENOSPC if all slots are used, or
+ * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
@@ -1064,9 +1067,12 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_me=
s *mes,
         return 0;
 }

-/**
- * amdgpu_mes_free_proc_ctx_index - free a process context slot
- */
+ /**
+  * amdgpu_mes_free_proc_ctx_index - free a process context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue whose process context index is released
+  */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
 {
@@ -1080,9 +1086,15 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_me=
s *mes,
         amdgpu_mes_unlock(mes);
 }

-/**
- * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
- */
+ /**
+  * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue receiving the allocated gang context index
+  *
+  * Returns 0 on success, -ENOSPC if all slots are used, or
+  * -EOPNOTSUPP if RS64 local memory is unavailable.
+  */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
 {
@@ -1105,9 +1117,12 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_me=
s *mes,
         return 0;
 }

-/**
- * amdgpu_mes_free_gang_ctx_index - free a gang context slot
- */
+ /**
+  * amdgpu_mes_free_gang_ctx_index - free a gang context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue whose gang context index is released
+  */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
 {
--
2.34.1


--_000_DM6PR12MB3611824F6F06889882D1665E94C32DM6PR12MB3611namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Sunday, July 19, 2026 1:36 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Liang, Pri=
ke &lt;Prike.Liang@amd.com&gt;; Chen, Michael &lt;Michael.Chen@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add missing MES helper parameter descri=
ptions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Complete the kernel-doc comments for the MES RS64 =
memory, process<br>
context, and gang context helper functions by documenting the missing<br>
function parameters to keep the kernel-doc comments consistent with<br>
their function signatures.<br>
<br>
Fixes: d160cbf3e4db (&quot;drm/amdgpu: add RS64 local memory context array =
init/fini&quot;)<br>
Fixes: dded4c22699e (&quot;drm/amdgpu: add mes process context alloc/free&q=
uot;)<br>
Fixes: a755b0cf3ef3 (&quot;drm/amdgpu: add mes gang contex alloc/free helpe=
r&quot;)<br>
Cc: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Cc: Michael Chen &lt;michael.chen@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 29 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 1e3a23c81552..9af7c97af5be 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -952,9 +952,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-/**<br>
- * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management<br>
- */<br>
+ /**<br>
+&nbsp; * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management<=
br>
+&nbsp; *<br>
+&nbsp; * @mes: MES instance<br>
+&nbsp; */<br>
&nbsp;void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;ctx_array_size=
_bo) {<br>
@@ -1038,9 +1040,10 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_m=
es *mes)<br>
&nbsp; * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot<=
br>
&nbsp; *<br>
&nbsp; * @mes: MES instance<br>
+ * @queue: Usermode queue receiving the allocated process context index<br=
>
&nbsp; *<br>
- * Returns 0 on success, -ENOSPC if all slots are used (caller should<br>
- * fall back to system memory path).<br>
+ * Returns 0 on success, -ENOSPC if all slots are used, or<br>
+ * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
@@ -1064,9 +1067,12 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_me=
s *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-/**<br>
- * amdgpu_mes_free_proc_ctx_index - free a process context slot<br>
- */<br>
+ /**<br>
+&nbsp; * amdgpu_mes_free_proc_ctx_index - free a process context slot<br>
+&nbsp; *<br>
+&nbsp; * @mes: MES instance<br>
+&nbsp; * @queue: Usermode queue whose process context index is released<br=
>
+&nbsp; */<br>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
&nbsp;{<br>
@@ -1080,9 +1086,15 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_me=
s *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;}<br>
&nbsp;<br>
-/**<br>
- * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot<br>
- */<br>
+ /**<br>
+&nbsp; * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot<br=
>
+&nbsp; *<br>
+&nbsp; * @mes: MES instance<br>
+&nbsp; * @queue: Usermode queue receiving the allocated gang context index=
<br>
+&nbsp; *<br>
+&nbsp; * Returns 0 on success, -ENOSPC if all slots are used, or<br>
+&nbsp; * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
+&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
&nbsp;{<br>
@@ -1105,9 +1117,12 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_me=
s *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-/**<br>
- * amdgpu_mes_free_gang_ctx_index - free a gang context slot<br>
- */<br>
+ /**<br>
+&nbsp; * amdgpu_mes_free_gang_ctx_index - free a gang context slot<br>
+&nbsp; *<br>
+&nbsp; * @mes: MES instance<br>
+&nbsp; * @queue: Usermode queue whose gang context index is released<br>
+&nbsp; */<br>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
&nbsp;{<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3611824F6F06889882D1665E94C32DM6PR12MB3611namp_--
