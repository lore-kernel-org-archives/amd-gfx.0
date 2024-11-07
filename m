Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5530D5D688
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 20:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5223C10E8D2;
	Thu,  7 Nov 2024 20:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lqh1k/gf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23B510E8D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 20:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcHe/KXe5fWP0edFolbCw36hQPBcmzs2tT/qn+KYr+iI0v4eOtMXHSu8UOsborpxhJBoXl8BkLlq/JaLSAePQ398AIYM2cHwxmQMLy1q/oqFoNaP05yiIwnTpJflY+l80PzOPc+20HQD/XhtMcZqZJ7C30YzObALsKG3nGempN0G6mPUPOD5tiGQkNKQBKFRon5tBgjevPE3VdazeeVn3CKE5O66wUR3XV8fjCrFPcBBbKFDPcNCvsSEAt049MkiOhBY/vIZnFqW5s7bWX5SyfX1P+2JJTrZJUSkONS3M2qSm9xF0OAWfG+w3Iw/6bsHxXLJcsDEMloiE/zx5o0C8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhVYNNkNNfVFgWPy7xZCDG3GjnmjpCORCPcgoVGsnMY=;
 b=oglPYhQpEDUklkWuaW+ECokdHdWz2tuXx7dOmiEzSxutu3ojFfp8QyCAREHax1Tftqwc/53s9JMolyzkcI72koNgSs7CnLmwGkYGtKCyVUnPsV0EboVxp20YhtgPzVkvRSeSw7/F8gTdCLVm31mdJ/G9euD0gZ/236yHzSuqgrcoEzqBsfoMKuAhC78x8S1n1NulRwanUH5J5/R/OJYA0umsXcTCGVtSooxTrIOwxn2dym3o/6WFuihTDzrP1Us+b9HGWuQ+9lWbxVGlHQkqEBXvfvHx6KrRf5q9ymgEaDLfhz9JC1DIkxoY4I3HO4f7n4B03Qx+4RvAoLw/hr5e5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhVYNNkNNfVFgWPy7xZCDG3GjnmjpCORCPcgoVGsnMY=;
 b=Lqh1k/gfdSpcMQJJvsfIuLd5T0lM8PPwqG5t++6rqM+B9h0Bn0J5BpPmooopOk1GNu1pKFnko8f2rTY9GcQr7sGMUIf9YpzlK8JtxLkk1LPyIP/dg3fqDOgwE2sp30gtw2BUT5cTulDS8fE4NxHEzNsi4JHPsO5aBJwgvACIzqA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 20:21:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 20:21:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add documentation for enforce isolation
 feature
Thread-Topic: [PATCH] drm/amdgpu: Add documentation for enforce isolation
 feature
Thread-Index: AQHbMU+Mr/cfZ2Jb4kylW4JVbD9OjrKsQpFS
Date: Thu, 7 Nov 2024 20:21:39 +0000
Message-ID: <BL1PR12MB51446D77AFD4B22460516271F75C2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241107195907.601798-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241107195907.601798-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-07T20:21:39.547Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4319:EE_
x-ms-office365-filtering-correlation-id: 8d985525-6a55-4e86-4ad0-08dcff69c9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4nr0WGrF0RuezWaP0t7q7R6v0lwyTefj8ZC6y7Gle8gjCTVfKbxnLwwIkT?=
 =?iso-8859-1?Q?AWafIIMi949kioPVck/Wbkt3/QQhHUR/67bM2mefrVP2qUBaxAEO3MJK/Z?=
 =?iso-8859-1?Q?jnXh6HRj2Bra0r+13SRRmCDpNPT+DTOlFVMLwjRxk0cEPgAgOyglpa9zHD?=
 =?iso-8859-1?Q?DK2/IQ/xcSmFDsB4O3chcYeBq09pKqaFxLHRAbbgaSPT8WjGdO7gZBzLqX?=
 =?iso-8859-1?Q?+ZMJ3ALSFPMz4Tj1bBMymUrDSltkwX+gHTYFSkI17CYzBaIn5o2TKZkkc5?=
 =?iso-8859-1?Q?8cwC3hKICM0YR7G5RjnLvqAW+XrZCrCrPkKpN1p8tB0fah86z4iAjbzdjE?=
 =?iso-8859-1?Q?gbYKcPL3N80LN+ualUPnRrE2TVPER4BCEXV5oBe7tvrdhUZMmDWzuvkot9?=
 =?iso-8859-1?Q?L8zP0m2sEFeJzZjY0G1ep8SHzb7sPwkjdRVq6vbQTDn+PB/VpBqiEujqsY?=
 =?iso-8859-1?Q?hOn3zPD5GzVC30x0A4P8XK7dhulDQMSoxw7ZiyuodMarQHTPs4V59b+4ib?=
 =?iso-8859-1?Q?9CXlr+PECDN+Vp/DMauf9kqZqMaCoV/kBd261ngMfhJjb0eFLLEWCueRJZ?=
 =?iso-8859-1?Q?IuTLv327mHWReEndupYW2imx2uyGvUkK5BFhPqjDN7KCmSngdGJVC2DAtu?=
 =?iso-8859-1?Q?FIPgMuWmJHWy6s+nZrTWMHIPcpVT8xNdpOZdArxAJggyoOLVRmBSi2IS3d?=
 =?iso-8859-1?Q?KU/x6nQJ3Pu5stc1UIXUAa10bsKJ9MVVw0vyzsGuh1Y4fngLBraRxhFhnU?=
 =?iso-8859-1?Q?DDhtkz9v8YLHH1r8X+JM3782XuooBA9Qcek5kAcBCZWxYkmHcTHMYlbtSt?=
 =?iso-8859-1?Q?VlyQoRoeiSe+i8Qqu1vlJEiDzt120pPBq45KU8sspFk0yj897Ll/0CokZr?=
 =?iso-8859-1?Q?+aqNcAL0194C4c7b7C0jdlY1dpdUMNIoQSEvT6z4jJNDkrkxyLt2nm61LH?=
 =?iso-8859-1?Q?HQukbnxiLlao9zNuJSJxMbL3PPfYEFSr+QIrykyd3Jsd3Fm6Qjqs8tzG9S?=
 =?iso-8859-1?Q?QJNGVOf6G2e7yIBaYihyFFNh+JVewjE7tlu8CHqIFnkZMRGiLq1WA48Qvq?=
 =?iso-8859-1?Q?uOHXTItVWaa0chAuAnU2ALh/3nQinXBkZ+j15Gb+qiyDtjHA118pkz824f?=
 =?iso-8859-1?Q?l7jekMlLx6IqZP2kAnbchpOxDvIO7dy4aAx0h4XDnAQV6004z+dSMJd3o8?=
 =?iso-8859-1?Q?mcHe/hvTSJvyd51p2Ojd77NnQgyzTSV8WnQb9y48q6fHtU8Hyy3ccc2K7w?=
 =?iso-8859-1?Q?26EFSyKNKWjTypJ1gE5GCKFjVLEZId+4giCDNW0FM1aVlZmU0Ay4dnob/f?=
 =?iso-8859-1?Q?vN5A6PjEwVRgFQNCgBdopsImhJEz5UvDl7VLabl9ydhcg9pianjLLCCVs0?=
 =?iso-8859-1?Q?5nxrIMSZ43ucNI/lpt/w+5jI0D7GEVadVztHJzwIoat8+STs8JRBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GlHzKZGwOrxzHX7mO8PK4n+Fgs1heuxzhiUOGEPdIcP5X3qrDNVK82LwKx?=
 =?iso-8859-1?Q?Yrffg2abAA9PK29blzu/GG0gw+brmJp0r9HnTW1KGNlNNzwgMZxDJ5R0L5?=
 =?iso-8859-1?Q?Sk6uJmgOtKv/ocllivug7Volm628q1qKLhGJFIAEFa/rrZwnMYP27ShGQt?=
 =?iso-8859-1?Q?EH1gWXiGedbNWOeK8q99wOzBNZAkg5sLVqhWj4UfKEKYCXKvP7ZK5gKLoB?=
 =?iso-8859-1?Q?R1xeZ3UxOCVOVCZAigXkh9a0tkKXywNJRsu/8+lrbPBXgwE+OgCU7Sjvet?=
 =?iso-8859-1?Q?Ws5NucmrxCJ4v1lvxUs2DS+HRojQ7ypIoQihFSPh/jYCQQe3/4cw38cOyo?=
 =?iso-8859-1?Q?lEnfPgeO5SZxE8o80GqHAvRna2++rbCo52MSzP19zlvH8y/kriv55ycJ8r?=
 =?iso-8859-1?Q?Q9G+F6xVfYt6ZcGfmeXsGBCQ6VEbHUaAdlnN+7I0rW737EWt3mAw7XxldU?=
 =?iso-8859-1?Q?NCjQGTyNRj7bilmKoEfG6sptJlilHIT8GanFJF4OUl/DshnZyG3YAVfoRu?=
 =?iso-8859-1?Q?jEDKboMsPEgCqRg4VtNRFR/p2Ookhh12wqtRUsi0scK6j29BwpColCrNwR?=
 =?iso-8859-1?Q?SEzIaliJ2Rn5cg1WRA7nKFDr7KzlAGKAMyvzZEwpMWHoKndeoFUgZdyINB?=
 =?iso-8859-1?Q?X7jA1yoD4A312LTQMx84jVjqjV3t5a8nU+BkF+u1fXdgI1PuXzv6qzUb4U?=
 =?iso-8859-1?Q?0pa0xKCNt8j8RWcasLlniwyiKJ0bfFCcU1kL+fwrGOo49hDcAaHqSHmtwt?=
 =?iso-8859-1?Q?NuZXAcvxwT5mIFD/WSaQxXw+Sqo7Rsq5s8gafKnzCQmjORJWhV8gj86uoW?=
 =?iso-8859-1?Q?wzxXLeP9S7958Y+BAwVCSL4M7kiQ5YcndvtOSVqaVy+KDprqgqF/LD9bFK?=
 =?iso-8859-1?Q?ERz2qUpRjXyr4NQUrdu/sxHbcYQ10ZQZAHY5bNYUS7xtcEUI/QO541QDk5?=
 =?iso-8859-1?Q?TZDEFdxMf/Q/n/jB+A4rU4D9ttuWNM7TXS/1hLOfKEYUoyZh0ADSCe/IDx?=
 =?iso-8859-1?Q?b0xd3xcdkrqAntCQ3tA3CFFIPUjoPk7rMt+xA07kHkrC/x6OpfBH3WEI4Q?=
 =?iso-8859-1?Q?aPF1hisOUVFIZ+6bSYYHxo6uIEcP8SjtLAUohydrKyM8nL4SvmaPyUNbbU?=
 =?iso-8859-1?Q?ilMlBAo5rionWaBvdYjdbkzssBTSrWBBtNeT2cndL+Rl5RFoSZFSpsTlu2?=
 =?iso-8859-1?Q?q4piumBGou3eN7tq4YPc7TrgmYg8FKsxDrRXOlvcxF0J45SGIB3MgcwPdd?=
 =?iso-8859-1?Q?IFaf7kqAQ38l0pm6kJCIM6It2NYv2xsxZNeTLqtqctluSko1CGSo+8faSx?=
 =?iso-8859-1?Q?Jz34eNhPNjzPw7jvnLCEsrRO9z7jkKjuCIskD2Ga54cLtSVdUsNa8zc0YX?=
 =?iso-8859-1?Q?Pyg54ZI5P/Y1L/KqRMEdanhXmJglJD96jSfDE6qHhuULcNNVmN+yztJ8du?=
 =?iso-8859-1?Q?0GZ9VbhPxOrtPMqO0EbCyENEy5wEdQemzUiDfnNloM589Jb4OKTFEDrNSX?=
 =?iso-8859-1?Q?irDWnOSgCuPbstbicqF9DWoPOuxgVCDLT56pivBwKwoXjC8L59m6zQsZ3x?=
 =?iso-8859-1?Q?arRtEZOmTm/Oe1Bb7bTjPiHGSB67MK0Fujaeib6X1m6tw0XXEbysJeo9BQ?=
 =?iso-8859-1?Q?DkrHpUDwZZiH4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446D77AFD4B22460516271F75C2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d985525-6a55-4e86-4ad0-08dcff69c9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 20:21:40.0012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfUoMpEyhbZ6rKLm91qbQ8WzKHWus1zsuknLU9kIZ0FQCUIdq+s7aHaDHP+lbpJboPjqe+BDBiCyelsVh95HHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

--_000_BL1PR12MB51446D77AFD4B22460516271F75C2BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, November 7, 2024 2:59 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Kamal, Asad <Asad.Kamal@amd.c=
om>
Subject: [PATCH] drm/amdgpu: Add documentation for enforce isolation featur=
e

This feature enables process isolation on the graphics engine by
serializing access to it and adding a cleaner shader which clears LDS
(Local Data Store) and GPRs (General Purpose Registers) between jobs.

Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Asad Kamal <asad.kamal@amd.com>
---
 Documentation/gpu/amdgpu/index.rst            |  1 +
 .../gpu/amdgpu/process-isolation.rst          | 59 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/process-isolation.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/=
index.rst
index 847e04924030..302d039928ee 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -16,4 +16,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) arc=
hitectures.
    thermal
    driver-misc
    debugging
+   process-isolation
    amdgpu-glossary
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation=
/gpu/amdgpu/process-isolation.rst
new file mode 100644
index 000000000000..6b6d70e357a7
--- /dev/null
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+ AMDGPU Process Isolation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The AMDGPU driver includes a feature that enables automatic process isolat=
ion on the graphics engine. This feature serializes access to the graphics =
engine and adds a cleaner shader which clears the Local Data Store (LDS) an=
d General Purpose Registers (GPRs) between jobs. All processes using the GP=
U, including both graphics and compute workloads, are serialized when this =
feature is enabled. On GPUs that support partitionable graphics engines, th=
is feature can be enabled on a per-partition basis.
+
+In addition, there is an interface to manually run the cleaner shader when=
 the use of the GPU is complete. This may be preferable in some use cases, =
such as a single-user system where the login manager triggers the cleaner s=
hader when the user logs out.
+
+Process Isolation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The `run_cleaner_shader` and `enforce_isolation` sysfs interfaces allow us=
ers to manually execute the cleaner shader and control the process isolatio=
n feature, respectively.
+
+Partition Handling
+------------------
+
+The `enforce_isolation` file in sysfs can be used to enable process isolat=
ion and automatic shader cleanup between processes. On GPUs that support gr=
aphics engine partitioning, this can be enabled per partition. The partitio=
n and its current setting (0 disabled, 1 enabled) can be read from sysfs. O=
n GPUs that do not support graphics engine partitioning, only a single part=
ition will be present. Writing 1 to the partition position enables enforce =
isolation, writing 0 disables it.
+
+Example of enabling enforce isolation on a GPU with multiple partitions:
+
+.. code-block:: console
+
+    $ echo 1 0 1 0 > /sys/class/drm/card0/device/enforce_isolation
+    $ cat /sys/class/drm/card0/device/enforce_isolation
+    1 0 1 0
+
+The output indicates that enforce isolation is enabled on zeroth and secon=
d parition and disabled on first and fourth parition.
+
+For devices with a single partition or those that do not support partition=
s, there will be only one element:
+
+.. code-block:: console
+
+    $ echo 1 > /sys/class/drm/card0/device/enforce_isolation
+    $ cat /sys/class/drm/card0/device/enforce_isolation
+    1
+
+Cleaner Shader Execution
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The driver can trigger a cleaner shader to clean up the LDS and GPR state =
on the graphics engine. When process isolation is enabled, this happens aut=
omatically between processes. In addition, there is a sysfs file to manuall=
y trigger cleaner shader execution.
+
+To manually trigger the execution of the cleaner shader, write `0` to the =
`run_cleaner_shader` sysfs file:
+
+.. code-block:: console
+
+    $ echo 0 > /sys/class/drm/card0/device/run_cleaner_shader
+
+For multi-partition devices, you can specify the partition index when trig=
gering the cleaner shader:
+
+.. code-block:: console
+
+    $ echo 0 > /sys/class/drm/card0/device/run_cleaner_shader # For partit=
ion 0
+    $ echo 1 > /sys/class/drm/card0/device/run_cleaner_shader # For partit=
ion 1
+    $ echo 2 > /sys/class/drm/card0/device/run_cleaner_shader # For partit=
ion 2
+    # ... and so on for each partition
+
+This command initiates the cleaner shader, which will run and complete bef=
ore any new tasks are scheduled on the GPU.
--
2.34.1


--_000_BL1PR12MB51446D77AFD4B22460516271F75C2BL1PR12MB5144namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 7, 2024 2:59 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Kamal, Asa=
d &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add documentation for enforce isolation=
 feature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This feature enables process isolation on the grap=
hics engine by<br>
serializing access to it and adding a cleaner shader which clears LDS<br>
(Local Data Store) and GPRs (General Purpose Registers) between jobs.<br>
<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
Suggested-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Suggested-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu/index.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;.../gpu/amdgpu/process-isolation.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 59 +++++++++++++++++++<br>
&nbsp;2 files changed, 60 insertions(+)<br>
&nbsp;create mode 100644 Documentation/gpu/amdgpu/process-isolation.rst<br>
<br>
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/=
index.rst<br>
index 847e04924030..302d039928ee 100644<br>
--- a/Documentation/gpu/amdgpu/index.rst<br>
+++ b/Documentation/gpu/amdgpu/index.rst<br>
@@ -16,4 +16,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) arc=
hitectures.<br>
&nbsp;&nbsp;&nbsp; thermal<br>
&nbsp;&nbsp;&nbsp; driver-misc<br>
&nbsp;&nbsp;&nbsp; debugging<br>
+&nbsp;&nbsp; process-isolation<br>
&nbsp;&nbsp;&nbsp; amdgpu-glossary<br>
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation=
/gpu/amdgpu/process-isolation.rst<br>
new file mode 100644<br>
index 000000000000..6b6d70e357a7<br>
--- /dev/null<br>
+++ b/Documentation/gpu/amdgpu/process-isolation.rst<br>
@@ -0,0 +1,59 @@<br>
+.. SPDX-License-Identifier: GPL-2.0<br>
+<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+ AMDGPU Process Isolation<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+<br>
+The AMDGPU driver includes a feature that enables automatic process isolat=
ion on the graphics engine. This feature serializes access to the graphics =
engine and adds a cleaner shader which clears the Local Data Store (LDS) an=
d General Purpose Registers (GPRs)
 between jobs. All processes using the GPU, including both graphics and com=
pute workloads, are serialized when this feature is enabled. On GPUs that s=
upport partitionable graphics engines, this feature can be enabled on a per=
-partition basis.<br>
+<br>
+In addition, there is an interface to manually run the cleaner shader when=
 the use of the GPU is complete. This may be preferable in some use cases, =
such as a single-user system where the login manager triggers the cleaner s=
hader when the user logs out.<br>
+<br>
+Process Isolation<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+The `run_cleaner_shader` and `enforce_isolation` sysfs interfaces allow us=
ers to manually execute the cleaner shader and control the process isolatio=
n feature, respectively.<br>
+<br>
+Partition Handling<br>
+------------------<br>
+<br>
+The `enforce_isolation` file in sysfs can be used to enable process isolat=
ion and automatic shader cleanup between processes. On GPUs that support gr=
aphics engine partitioning, this can be enabled per partition. The partitio=
n and its current setting (0 disabled,
 1 enabled) can be read from sysfs. On GPUs that do not support graphics en=
gine partitioning, only a single partition will be present. Writing 1 to th=
e partition position enables enforce isolation, writing 0 disables it.<br>
+<br>
+Example of enabling enforce isolation on a GPU with multiple partitions:<b=
r>
+<br>
+.. code-block:: console<br>
+<br>
+&nbsp;&nbsp;&nbsp; $ echo 1 0 1 0 &gt; /sys/class/drm/card0/device/enforce=
_isolation<br>
+&nbsp;&nbsp;&nbsp; $ cat /sys/class/drm/card0/device/enforce_isolation<br>
+&nbsp;&nbsp;&nbsp; 1 0 1 0<br>
+<br>
+The output indicates that enforce isolation is enabled on zeroth and secon=
d parition and disabled on first and fourth parition.<br>
+<br>
+For devices with a single partition or those that do not support partition=
s, there will be only one element:<br>
+<br>
+.. code-block:: console<br>
+<br>
+&nbsp;&nbsp;&nbsp; $ echo 1 &gt; /sys/class/drm/card0/device/enforce_isola=
tion<br>
+&nbsp;&nbsp;&nbsp; $ cat /sys/class/drm/card0/device/enforce_isolation<br>
+&nbsp;&nbsp;&nbsp; 1<br>
+<br>
+Cleaner Shader Execution<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r>
+<br>
+The driver can trigger a cleaner shader to clean up the LDS and GPR state =
on the graphics engine. When process isolation is enabled, this happens aut=
omatically between processes. In addition, there is a sysfs file to manuall=
y trigger cleaner shader execution.<br>
+<br>
+To manually trigger the execution of the cleaner shader, write `0` to the =
`run_cleaner_shader` sysfs file:<br>
+<br>
+.. code-block:: console<br>
+<br>
+&nbsp;&nbsp;&nbsp; $ echo 0 &gt; /sys/class/drm/card0/device/run_cleaner_s=
hader<br>
+<br>
+For multi-partition devices, you can specify the partition index when trig=
gering the cleaner shader:<br>
+<br>
+.. code-block:: console<br>
+<br>
+&nbsp;&nbsp;&nbsp; $ echo 0 &gt; /sys/class/drm/card0/device/run_cleaner_s=
hader # For partition 0<br>
+&nbsp;&nbsp;&nbsp; $ echo 1 &gt; /sys/class/drm/card0/device/run_cleaner_s=
hader # For partition 1<br>
+&nbsp;&nbsp;&nbsp; $ echo 2 &gt; /sys/class/drm/card0/device/run_cleaner_s=
hader # For partition 2<br>
+&nbsp;&nbsp;&nbsp; # ... and so on for each partition<br>
+<br>
+This command initiates the cleaner shader, which will run and complete bef=
ore any new tasks are scheduled on the GPU.<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51446D77AFD4B22460516271F75C2BL1PR12MB5144namp_--
