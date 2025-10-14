Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8A6CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 17:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCAA10E27B;
	Tue, 14 Oct 2025 17:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QVSIeYjs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4C010E27B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 17:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HInV5balgxQxneFgYtgfyegoMzxvztqhF6RNeFW9Cka8qi6jUTCbBhqI1eXGSsclcOXhC/QhNVvb2mKNwzhKWqUnEIMAY8HVDQCV85f7Ko4inxtZ0+ALDL2IuQTemWveJGotSZdraUSYc2nbHSkrUT0GepWAigsy5yxdwgjAFSM6E1vPx9W68fVosIiyzFDMhWYJNlH1vufkFBUgBbDFOJJhXk0SOA3ms/CsNN4FtpFP/eOv8aBloFEq6mqxY6bI8V8FH0Yevd8LYttgFC1eXVN/McYEts5B9Y8H7kOwFUi2QdveAJR4tEyybq73XrAbwnFtR7ifujB3JsO33/DqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaNV3Tx4EU38YropKED41qd90kJNG2jeciCBfWeEJGM=;
 b=iZtCpKzPq7Fwi4GpGgdwOUDKUQ17KZg/HQcvuvK7zSQrHv4HHWQo6egXHRfXrM1pdvWdVPD4ib28RiODvxV73O400qEbUn9ZyqlgwYTop3Wpm4hVAhQe73P2pjR5/q8wgyMdrhBQClMAu0k7u4ANOaF3JRFOYpBOTTzfkgfQKZ8goqh29/zizdnCVUdzo67kj/UO6EiRGA6p80A/XdozCa5uhimkT+qrJjpecD6fbBr+2rqA9qBJwjwH7+4r1fD6q5ocO610BGdb1hHSQ1aXoEhvYFQLV7B/o5ub9udmhU5ufGSfFshxV9kG2Z7S8Xw/JmwofZc5L2u/r2jX77X1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaNV3Tx4EU38YropKED41qd90kJNG2jeciCBfWeEJGM=;
 b=QVSIeYjszTolbFzUFuAOEvzC4xeV+M3IbMMFTTQ0wLR74UPgy79CsdTy3+l/NWAXJiOiJdfImdi0wAK0wrglz/cg93oHgWTUo3wbXP63kxo+LZJ/VvLJv6YqlRmrWrNX3l7bycTe3ekJkwNzrsc56hECIWDGe4a6FcvnbP1BdLI=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 17:52:26 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 17:52:26 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix vram_usage underflow
Thread-Topic: [PATCH] drm/amdgpu: Fix vram_usage underflow
Thread-Index: AQHcPRCSrVh8hcTKc06Z3A1g3osmzbTB7FCQ
Date: Tue, 14 Oct 2025 17:52:26 +0000
Message-ID: <CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20251014134317.5081-1-Alysa.Liu@amd.com>
In-Reply-To: <20251014134317.5081-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-14T17:52:15.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA1PR12MB5658:EE_
x-ms-office365-filtering-correlation-id: 44b7201a-0fc8-4bb1-3000-08de0b4a6fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FF3lFR6arDHccGOUK5Pc5/aQ8M6Ki7CmED2FQ8jG6QmCNh2+SL/x9KLuU/Iv?=
 =?us-ascii?Q?SS8WVoPNEqNWa1LuYwjWBcF1wJ5K8w1eLYcqFfdd6QCb7ElwO/bfTX7aGBLD?=
 =?us-ascii?Q?ENY58nYJfAf1Now/ImdqarkkladvuY6oCZ8jvyqgsU/gVsCKcoDpsqe0LMk/?=
 =?us-ascii?Q?dRaPK8AIgr/En7sk6cpevEo7TJ8AvrUI9c1vILBhwIwtdq7G1rV+3BqSQTSd?=
 =?us-ascii?Q?Gy1Fic4lMdNak1JXKQdlM45W2cLXCLVBcTcVLu1SgxBM0vYahv/Pa4wQ9EVw?=
 =?us-ascii?Q?OJImpoB4WESqgw1UH0XzQaHSTVDl2Ownhktz0RY3JfIDEPIRUCbpRLvCKdDK?=
 =?us-ascii?Q?3gILOkiXFnWhOGAv7gpjpZeH2NaZP0gsG4gUGIBw9l/P7M9bUI2ts8teX9C4?=
 =?us-ascii?Q?1A717Y8oji3T1Nz9LzfESdpSXatyrUhPcyBMRA7/34XDS19P1wIr4qLxF4UU?=
 =?us-ascii?Q?ii6HJFhbCmTtpCuH7ooitUHD4unIHpZ1lie36M85EizUECcdShccKiM3BEdM?=
 =?us-ascii?Q?5eyfJL3PtOa4ZdamYmqddpPzxD82+sfBJHiUgYy/t9cbgiPJPFq0L/CwL5Tr?=
 =?us-ascii?Q?ZAmv2ZMVC5lfja7kjaa8ksa3vhvfh3z5XzU+rLvUJn8Tkg5GONaNfL7wycQE?=
 =?us-ascii?Q?WZmbkjV8isu1JqnJ1PbD4QqdL0JwfdfHrdpvhHt3pHMYvyIQkmkY9fnrlS3t?=
 =?us-ascii?Q?58vyz24t1j3l3HKcx8nwyQBP4abq00eYTXzPye7r68QCSUGt1muuKyITG2Ob?=
 =?us-ascii?Q?hxk5HvSz0VslAL1FkIDIyr3LhxU3Z6glAHAbzum1tvubQ441U0De4T9X8Pgc?=
 =?us-ascii?Q?zEAheyY1buV7Rh6sKGk/5oAHVb3ekOS7Xp3x12vi/Vq8YXLKrp5mG7tVqrWw?=
 =?us-ascii?Q?F3u8vg5kbnkBar5FNrXoYcGaJYIM9+IYY7JvkHEToD37KyAjRHvMKZxu71db?=
 =?us-ascii?Q?XvcN3QdfgSwCwW+4g0xPePs8N8qiVLcu+o/6SJjIP2dp6oH2hOu/14I7sHKb?=
 =?us-ascii?Q?H1YIWRLSHvY25Hc1j6YQFr/MW1zbmiweHLkJT6/Rh50LNnDCAZVALEaehuAH?=
 =?us-ascii?Q?/bXC13JEm3kS4kzexH+C7z7EyNskvBKUAUs8obn/XlToGfvwk61uNkblX8Kx?=
 =?us-ascii?Q?CWpxESxe0KVnmh8o41xLHkDja4M26EXfADmLRvky638eo01FvHFdz2GPC/6E?=
 =?us-ascii?Q?SIVtzoqtlP3/Ixc7A3NwxXvO09xc7BQCFdhKLlIwwPQ97QUSN24F+coD1Utu?=
 =?us-ascii?Q?Eca2xnlt64aEuzlJh+bWJVqqabn5V5HOSUG0BlN7b1Guom4E9KiBWJvxY6Ns?=
 =?us-ascii?Q?yGb6hSFmq4crP0UtvcaNDDFf3g8bYIuMbEJWL29l2zZI70Wlcz25q9yFEMjw?=
 =?us-ascii?Q?XC/pD4WvFCyk8i5Jr7XDzYUA8tf0/IYddP09BFvDhy9AOOQzyCLmjPMZX5lD?=
 =?us-ascii?Q?kfCKc68X23JXTKfGsV/X1ebO5CGYEJTeELvuEjRJw/Nek1IgwEYqFbJdhNl2?=
 =?us-ascii?Q?cXnR3A2gr7vYyjNuYIhRhwCHyJx+9BJD34yC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9QPLa47U+5Jgk4eN+SddeLyLMLf3AQXTpojg5mCalm6cL852L0s6Dii6eqkS?=
 =?us-ascii?Q?PsH8+XDzavUSuZyUj7sOs8u/B+ZxWKpyyI377cQ6GcSXahJeklZfx+2RjndS?=
 =?us-ascii?Q?GCoO4l54zecyI14bPB98iFae6wjaUxU/owaSgRWA8XtfR9POSL3MCLANwSX9?=
 =?us-ascii?Q?DBZel8A2JvWKzbc5eKRsZe5AOqxhXqcqjy97MIZIlNgdh+PrhnzHwZQiunrW?=
 =?us-ascii?Q?CZtImVmXS1n8WZlTeXg3mwL74og1DH93R+ZJ1ZGxUzNuQJJmywNuWQ54F6o6?=
 =?us-ascii?Q?6pJ+BkmX2yx0fR0LadVHlkDQ7Pd/t0XpKv+kakFaXvIGUN3ue1HeOHBL6EiV?=
 =?us-ascii?Q?kGque7Ar4etFzTUgg6Txha16vDP+5sdFaN/omx91w7BCvBJMYwGzdjFyHPli?=
 =?us-ascii?Q?3YJqVWuCercBgg1Ox6LvQxs+I1SzU0xT1siK93ez0aBc8k2Rz1bQPenyBipm?=
 =?us-ascii?Q?qxYjBrPdVctTNZaybZZQXjGIswUytlbl36lDKv1O5jf7tpc9aOieVrmz4ovN?=
 =?us-ascii?Q?htrErsJK6Vao8zp9kl28XBTKeDi+bjhxp2R6sfYwu6qi6urKKP8IS8miS/wk?=
 =?us-ascii?Q?2haSvoXL0fj+8tj5Nomtz4WYCGgWKw5CqhH9gKxW4O6N2ZpxQeZV0Hn5PFA3?=
 =?us-ascii?Q?vpBI32xExfwRLDZjbfKA82oQoZOExuHDPsl+UddSOTsWt6ReT41D9pRLZTfJ?=
 =?us-ascii?Q?m57zpmxaGgJYK0RwgezNwOedIC8SvjvqOfb8LNzKrl9z6PEc979Elpq0cvIo?=
 =?us-ascii?Q?7AnYwTeBBdaaWybStWfNxnm5KF6CR/hhubMEgT+CnlqjtBibf2h9usiK5FmB?=
 =?us-ascii?Q?s2VLxjCeXv5iSQ8UPiPWswNaPexKHyP1Q4W7yXbNmsbn189Ev9/ig9+uPFk+?=
 =?us-ascii?Q?vbSt9L61Dl8k7fk2H5pHNBlb2RaPFw8q0e+x9R8kMNX35oLnmzkMsQ7ebbOH?=
 =?us-ascii?Q?f2krWLlAUt/8lr2ksOhAv08c0iNJOBpBTa7uc/9urWqpYeOnPk73DUc83v4L?=
 =?us-ascii?Q?KxuK9qBD8lcrCcnlF0093XSU/RJXP3EVJ/1Wt3TVUsTWSf2KG/G/V4Gsi4p6?=
 =?us-ascii?Q?7rBg3TPtHBHEG9cvrnsHkEw85KpFNPZUyR0IWcTQXCxAcng0W3JF/iRPmWAM?=
 =?us-ascii?Q?m0aRvDDltdlmhYJ6eoXBepgWuJeEb9RIgzbI5aGM4nJgwdDFsC860phIw/ni?=
 =?us-ascii?Q?y4/iLJNPHCjGIEnGmu7QOi8gR6d4ct7ACvnQ4alxLmvWKJnbaEuQAp1QzFdQ?=
 =?us-ascii?Q?PbW7edYVSRmug2f5QhIwwiR2jcYergb/ICtYofKlEJX6O68/5Vgdt2ty/Mpv?=
 =?us-ascii?Q?oevESFQpgjEUnmcDUQjqz+Ius82nZ0+zBGbWJnQmg64SUq7hCnCjy3s/10cn?=
 =?us-ascii?Q?9lESq8fOvTbycRb9Ur4Qv4Pz02SNOl/ow4HuFhJHLN5adwpoKYUBIGlURNI5?=
 =?us-ascii?Q?B3egfY84aYglIQUafswgpBDGm+DH+rUkTZctMa0p2/9jIer31oHU1qgIzoUm?=
 =?us-ascii?Q?1UEym6vrRDo8hVJqEDTooxqOUtKrBUN8T86SL1Eqt3Hv/0jYr3/+hsMd0Lql?=
 =?us-ascii?Q?tYpmMf13gsoFfp7hqTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b7201a-0fc8-4bb1-3000-08de0b4a6fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 17:52:26.5828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0DDliJPnp+vcOYlYbi+ZjrdCYZrD7gECQY+gUaN9B5FkAbnIn4pHUKr6dhIr8r9+Zht9XQavyi8qZ7q0L4c1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Tuesday, October 14, 2025 9:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow

From: Alysa Liu <Alysa.Liu@amd.com>

vram_usage was subtracting non-vram memory size,
which caused it to become negative.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 22c1bdc53d2e..c2fa330ff78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
         */
        if (size) {
                if (!is_imported &&
-                  (mem->bo->preferred_domains =3D=3D AMDGPU_GEM_DOMAIN_VRA=
M ||
-                  (adev->apu_prefer_gtt &&
-                   mem->bo->preferred_domains =3D=3D AMDGPU_GEM_DOMAIN_GTT=
)))
+                  mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
                        *size =3D bo_size;
                else
                        *size =3D 0;
--
2.34.1

