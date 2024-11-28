Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB529D70DED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 20:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B3010E0FA;
	Thu, 28 Nov 2024 20:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBZd3otf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CFF10E0FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 20:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtTox/io2RMNdKnZoC9AvJxJZXjzIyIWJtT9gx3OiZ4LqqtlqDxJtqp0+z4GML4osCsI4MOY1EfdFr4Lye56l4r50a5nEZIOJWYH3mTI9RPGg+MP82j/YyZiFQkQPHCYmkRQPAIGPcrLAYawqIxcctZO5+N68UbnzPIH4Nbh2uZtG6QI8RVpTYinQRqhmG+f3sSODDnf2fw67op38JP/+zHQqU3oA5PWZPEi1ZmQ+/5/eFHZ31fCwBqla3TSpbgDR3Vib8WYEEmNNqeuV6lHz8UMh0GNjIljj8rYllP8cPmyeTFOUv8ezaOYgBg8eHPcaWW0HlcGcGTEhVCtggfLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKcsVVfCbeShEoJzWHsDqJHoe9fZz56L1s+61hjld0Q=;
 b=S1VLZJNkxM1uYs3iyTb3lsoNeOoNtXgJs2uNtm1grvnL2wp0h4ECiHRlgJgOU0rt/BuyHIM9BWHud3AKD480q0Uk0Sgbr5ahNvuVtU1ASvzzHfBE8qJ5liO7BYaClnwh4lBXCve2oNh5Ej6XymU6Nz9Mfp+lXIdHJTzNHNs22uovV6JDt1IN7J18blWuBUXlzW9k9a0yQk27jLhDwelIrpeKAh0/wZ0cNrL9Ttnr1qGIDQvObNTkxenzs9TRJlMYAA+XHrrrd+IpMaECsp3hUHMsZVil+ZDmvcgaEh7JLe24iAI226OJLf8jD6wM6P8BSh9Bh8NVIpqbURljsYDgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKcsVVfCbeShEoJzWHsDqJHoe9fZz56L1s+61hjld0Q=;
 b=aBZd3otfkHP90Mv6ThqoLZTPCjij9Jk1ttq+v6a/a1jjW5ZK7yhdd3dvsVKitADNYR14WmbT8xnhrXpbBUte9YgARTvFHcYZjp2cgitaBA5EyUBVO48cSs/lEBmfuq8uTynFnVlRbuv0c13QAo3bmbCQE1SG5rQem9W8ck5PNw0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 20:26:46 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 20:26:46 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add MEC version that supports no PCIe atomics
 for GFX12
Thread-Topic: [PATCH] drm/amdkfd: add MEC version that supports no PCIe
 atomics for GFX12
Thread-Index: AQHbQcIy0o34nALol0SAGS32zgL9GbLNI6AA
Date: Thu, 28 Nov 2024 20:26:46 +0000
Message-ID: <CY8PR12MB7099D876B8FD29FC8C7007F28C292@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241128181937.158956-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20241128181937.158956-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c3d0e56f-18fb-44b9-8d7c-d22232a98775;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-28T20:25:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ2PR12MB7866:EE_
x-ms-office365-filtering-correlation-id: 8d673a47-78c6-4665-281d-08dd0feafb0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OOoMChuXu5+N+MMfeMb9GV65pz5UCrAjCf/LJdWQe2wzVLO/NsxBXN77KXgj?=
 =?us-ascii?Q?8mZuR4YuvNP2fBkmy404l8l1IdyOgYRk7mOqpiyCiW5c45d3MwA/Bn71lW6d?=
 =?us-ascii?Q?xEvpwv0ciaDQY5lD6gcZifZuwkes0j+5FehUEH9/rggegdu5UlW2NjAQwGyv?=
 =?us-ascii?Q?XmC52NCyKdrOgUcMphINb6XnnRDDgrm5pkI08jhUqPWICMQMeu2xu2BdOxV6?=
 =?us-ascii?Q?yzcKrac0sls0g5iOiBoJ5HqKu0vWYaJiLaBZL8ImLPWC7KZbUiwnOywd0oFe?=
 =?us-ascii?Q?FQc7qbfg3DmRJW2H6TbtE1wS4ZuLnJq5Bun07YgfOVazbmRf3HLlYxLNgbCo?=
 =?us-ascii?Q?Bmh5Gqs7GCPQ9Mk+uBTdGX7z2OdSZiz1MKVh0jG+xjgUXwLAOO+MT4Csuegk?=
 =?us-ascii?Q?zsZ/JxXtlanw+1hdaGdZlSaOWuNebfGquKvMuaZzNCb8pNWjs7bFdKi/cno8?=
 =?us-ascii?Q?xuyMa05jS8RNHT2Vq46g4/4VGwM3NxudlNjzDghZYYTHnQ+grnnRNBtmsNh0?=
 =?us-ascii?Q?NYwZgn5/ZW8mYHKdRDivYIjUFzkOgveXqdUkN12YynQWpD5f9suH1Vq7iEBj?=
 =?us-ascii?Q?Yk4ILINkpHd/2iOsuP8FPx+larO8wbVx+EOVCAx5JKVFlFsarC49Cp8wazF2?=
 =?us-ascii?Q?vzjdudRyuzjvFeF+ZjJgUaekB6r/6iTV023SK/R6RLeYjiHjaCPfe/wR3Oq9?=
 =?us-ascii?Q?HIGKWvQ4JqpSZn4j7MpS+eh7N+e4YtjD4zI8u1zNDqPyNS6hocH2T436hXMj?=
 =?us-ascii?Q?x8CinEOhn0CgtjuubzLo2qohf8yce3K85WuNHrQfBATuQ1OjHcdMXascJ49x?=
 =?us-ascii?Q?gdMdddiRQO95jQeDfZEsXkVuMjzWOUiTNyplq6bLLL9oZwjxZFuZ9vTg/Bbz?=
 =?us-ascii?Q?IILa8Zcex0hXBmCQvyDBdXK452I7XdAGKb04fcfPi7mM2BrLk2Xy01Zupjkx?=
 =?us-ascii?Q?vgkswGtDK2W5T0oSzhvwBjb9nSVdN0i37nzrVHbte4mFxpLbMuwoRYZxW0O/?=
 =?us-ascii?Q?4nG4L4A+892D6iz9RP45eALIuTirfE10A9ttDYARBSmQtQMslGGsxtWTwsSJ?=
 =?us-ascii?Q?f9YxVjv+VcwchvinS78Fct6172EPVACkIcauXlwhyZjZUaCm2N+U54IL8HcX?=
 =?us-ascii?Q?zR1yByNbFXT0+ZDIGoOF0GSo+W+mkppbYIjM4Ke/lmKqk5HNJ2cbDH1p8+CK?=
 =?us-ascii?Q?x+CJIm1ix2SvWRugZdNByfGmO6suxznp4TZG+VmHAGT9g/iRC4X2IyE7SLbz?=
 =?us-ascii?Q?KCv6oq7iU7XYZBhb5uhXD1254vbakdiJqaMca/IA87JmgleQXZfokHtFZF19?=
 =?us-ascii?Q?clCiKYaHrev2HQaKjjOcfRuYuRR3nKFJgq8J8+2rgSwqLsJ2yOkk4lT3Z6fi?=
 =?us-ascii?Q?4THRl9ByVflWQi77eR7/KR/hLycu0O2U3Mo88aBL9/DktXLVkA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PagmeNJRmY+c6LVC5Hy2sVPtfmT8IfWCAnecESjMEuxdvimlXYVpc2sLidl?=
 =?us-ascii?Q?HKAX3Qw6GFqoqbNVmygRy40ZKj7ajCdpDmNTUgaxm+fWmWKfcx94BZdUhjWE?=
 =?us-ascii?Q?fE44yg7LrC8AOaVZKUTNIX8wsqWeUu8diywAGlGJd/YvXHAbBLnpyv94xGe6?=
 =?us-ascii?Q?cBtX2SiEIHbXdfnumGzNbhD23sF6MUJi16pp2VZZ3Wk8+C8HsSYflit88JVQ?=
 =?us-ascii?Q?xfTR6hG9KyoyKxqnVLadfcuXtK+StYk3P9Ulw6yQ26i3yOZDFGpcsIwOx4hy?=
 =?us-ascii?Q?auvPwRXBZjEgTWEy/E5dtUX24S8pD17w92sJ9pPIGA/GMYoos9VNwVWhRHX4?=
 =?us-ascii?Q?ECTmd7sbjpMESjgGQKZvvH+kiefPYwb6wWR+QWqfyOzIooJTJ/bx9m4Q0SXc?=
 =?us-ascii?Q?MUpIwduFzunjkNX66Llyvvl+eI7TBsK5VzkOg1LnNEM9nkStiRkZcpb0SuTm?=
 =?us-ascii?Q?ZNxJuoanU2Y0q3VqS5jlvj7VD2/5Grn4HhQRau+N6f2K9+pVxIaQed5TKJmu?=
 =?us-ascii?Q?0IlMmZxHmkTJiIkx+Nt957Hmzq08qL89P2Qt93l445Q5R02brMpWlajo1heR?=
 =?us-ascii?Q?XHIQju+c2WU2C6jBkLk/MijztqFfHMiiyGBUKd96ZPNmSw2P+kmunsI8RN+F?=
 =?us-ascii?Q?6qB4xosvOv703lX4Q253zN6nINpMiY9kJdLN0i7vRHvVK8OZjh92nwH9elUL?=
 =?us-ascii?Q?iSyLIqP+qvkkNapp3WM4yIbU2i4GiF5m0A+bjzQ9DcIVmIcSUDcfBB9n/mcP?=
 =?us-ascii?Q?YdKZuj7E+K0rc8q57wneyXo8A9tl7/SfxrxoloXXo/+pztJ+8ZUdczuJXpco?=
 =?us-ascii?Q?wSm5fo5rsMUPcAazO6x6bCw+MoswhSpBtDAadrZd07bvYf9R9bqLpNv+DUt/?=
 =?us-ascii?Q?2OjCl75NbPjPmuSE4YxTJ6hfHgQCoidDGY5peQAgcKTtSPNaQMrecNCKGmp7?=
 =?us-ascii?Q?iOaPE2XZOItfseVsbAwTdGoaN5Rzg95E7EUvJEcuq45TzjwrU4WYj9+6rjJo?=
 =?us-ascii?Q?FDBh3wCvvlg/HSGhS+srqKOBYO5SdDBPQQL+GePXsclVfE7l9kwP8qCUr6jn?=
 =?us-ascii?Q?hDK0ZQF8XJPyiC4BX9BL5Il3MBoXcSDgGb2uQmqXRxTaTactXxl77mFVp4Ph?=
 =?us-ascii?Q?DeuWI3OBbNNARpqLBNAh3q2Uo7zrYCV9qhJXsEQ39G8LSsZX/+glWA6aj47w?=
 =?us-ascii?Q?CddCsPDWo+h5CXzsD7gFozu+vRJ4ImaTKEVc3/Df2wat5vo9olWx0ANmvft/?=
 =?us-ascii?Q?YUmyHcGmpUGv0IEWkyK8/BScscMz96vBINaEmxwYVS6z4Qmjz42vlO4ACqrp?=
 =?us-ascii?Q?4aSuVSi44A9GHy8vx0PmcmjUKSHN8YL4pmJZ47FSAUKHamoxOkBvNQ933kaO?=
 =?us-ascii?Q?IMqHrJ1XaaSzKFwC/gpdK7HHs3fHYvU+YFXyEIbsV/1KngS91Ojz/IrMTyZ4?=
 =?us-ascii?Q?p+6mN+OPj/GY5IE+EJfWl0YFO1bHlI8ixkGmu10TJFHOn6fhwCLw99tVeMgn?=
 =?us-ascii?Q?xCBdjEr8iVZidZ9q51/kK6OoV5ja/PYb7czGDB43PmLcu+2Ldx/6fc22P/pI?=
 =?us-ascii?Q?9Bw4MI83/oY7Q8C2pQM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d673a47-78c6-4665-281d-08dd0feafb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 20:26:46.4789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkle3XU0IF+aRBWnomUmskHOcmQ7xnOu+7ktIkeRYufXlPYFvJ65kwvrxqEolz3feu1/Z3VSXiKnypkCC5qTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreekant=
 Somasekharan
Sent: Thursday, November 28, 2024 1:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: add MEC version that supports no PCIe atomics =
for GFX12

Add MEC version from which alternate support for no PCIe atomics
is provided so that device is not skipped during KFD device init in
GFX1200/GFX1201.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 956198da7859..891ce1d0dbbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -237,6 +237,7 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
                        kfd->device_info.no_atomic_fw_version =3D kfd->adev=
->gfx.rs64_enable ? 509 : 0;
                } else {

Safer to add an else if (gc_version < IP_VERSION(13, 0, 0)) {

}
                        kfd->device_info.needs_pci_atomics =3D true;
+                       kfd->device_info.no_atomic_fw_version =3D 2090;
                }
        } else {
                kfd->device_info.doorbell_size =3D 4;
--
2.34.1

