Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CCC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 14:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BF510E7D7;
	Wed,  5 Mar 2025 14:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHupIAsK";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219B710E7BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 14:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0YcqLdGcxBCG8p7uu+AcbvbSOpUDM8oSFV6FTIclMUqTVAoBSqHGMC+0iwpsnWRaCSmao2oyxLdu8YqXfVveYbayLb3RMDSBFv2hBVe+fkiMzOCDMYOYQGqacYvyrZe8Q6COU0c3FkTtBPheN92ACihyjxs9GOERZ+lG7R5Yv1bFGg0WA86BTzjCRDNdmUncceQcsMR1U2WcpTPs6TImNhv9/wgQ749bA7/wmDK72ngsvwkceu2EKpXjxXiTgLcme6NI8Ed13I6LOPrkT3wFEeb+rdo2DrZnnGAO4sCGUSWYrr2WDMQAENpb0n6WXETDRH3yc42FxXXUYqTna8SjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1/o0fRI/boXAFQeylgRa4nmSWdPPAPjeLMJdD0KBEs=;
 b=WYFeJ9vwIHtjMim7jMa9hIuiR5rgkb4zv40rLuOm1zxbQlRdxcE5CCggfazYp+beOP+UmTKknJzqtCc2w9lnC7ejnZwVTdR7o4Djr/vqazEw7wpLZJu7D2ftN95RYxsixMh2FsFjXyQg1xENqr3lA2EPDO4/KL2Qa9GuBpysSJqOOacYgJ8advj61b1jdXnmHv0mDMGhmQvOuD+cWF25Grzst/Sd0WlObAqLdGQnP4efo9K9JWfKs4SbxTVtF1sBZLCMMOtOk128E81waJ3NjiRrBaVfjnsTgQAId/Rlb6PJpjuEUTHH8qXKh9bR8OU2FqlwXOQsdjcNVSXUDj21KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1/o0fRI/boXAFQeylgRa4nmSWdPPAPjeLMJdD0KBEs=;
 b=UHupIAsKqk/ULFnQ1GY4v0XJcRdGagd4sO28YQhNxvVrIyT1+h5C1IVJVYGXu7jB6UajE+6lSMkCMJi/obi/mA9UM9pURnKpCgGyn5MVZOAOAGHQYbnmF1TN7vAg0525LbrIVcfoeFMQLaSQfG7YFUQhEzDsEMzU/8rLAinZC60=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:59:38 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:59:38 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Thread-Topic: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Thread-Index: AQHbjSWbyfpxnNShskS/TNtOc4UM7LNkogzQ
Date: Wed, 5 Mar 2025 14:59:38 +0000
Message-ID: <BL1PR12MB5898F470ED28E84105A0C00D85CB2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250304165024.4040892-1-alexander.deucher@amd.com>
In-Reply-To: <20250304165024.4040892-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b5f9db6b-68ee-46c8-8fbd-f45bd34bd32a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-05T14:54:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB9475:EE_
x-ms-office365-filtering-correlation-id: a95df539-81d6-4153-096e-08dd5bf659c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?M6i3kzWxpac0nHNVkHUgelzR6ATbHM2eKEnnlAAN016ernAWO296nDBh+gTq?=
 =?us-ascii?Q?odi6icB5rPSGQ1uRJfZKNiReW0/EgPGl1MXM8hqj+OSZ/+v4+Pcs6gklCpEL?=
 =?us-ascii?Q?kWy1BcMZj6o0/GYVbQU8KBweIS461KPjAW71FBoPObkkZmY6sjEt+/whBAS+?=
 =?us-ascii?Q?zEDbQH23RXNdqTE/meSwu4LWgz5MN9WQiXweD74vJYf4I5FFAGNWmdRYEkCx?=
 =?us-ascii?Q?GEB6cL/HeiM0lF78BDNlYp4SACkMiDE2nEseKL9zq97ii43CLMHCrCE55+AJ?=
 =?us-ascii?Q?GGYyV3kXKaK3s9Jsl00D92oEo7dcVJekWsOClsEpW3XOFMbcs//D2qs/o/xc?=
 =?us-ascii?Q?L4AKfsizFMOI5LxVFW7LNh5umk+2hQUuCVatwjrC5gWwlby38z+odTOtnnFI?=
 =?us-ascii?Q?YXub/A9R526rguNSZwQJRoDPRhcOhgk6CZRBoH5GYWh135BLDfYAnphT3JEH?=
 =?us-ascii?Q?RUm1bSheAe/HzpugXDZ+OHhNf/TGhY/oO/yyD3c1MCEPiJQC5s76KJRWBxGZ?=
 =?us-ascii?Q?/aWwkzPiXBnNsegIu7x+gWFpbr7KMxLjIivqBwAWXbr9sAGgfsz+idr4AFYa?=
 =?us-ascii?Q?N7GrFELX9D7GL9Ld8fPKLJi/lD1nEa0skS1YoUWZSOI4yRPZcrXaojro+Dmf?=
 =?us-ascii?Q?B42gZKKYJhDi6B2oZDH/Y1Kpxb8RoOfcYQcs5jeAS4tbAz7D6UFGqgIZwf9N?=
 =?us-ascii?Q?5/cB/qp1xg4rjW/ALBURCUoYM0Z+gBa0G/qyf0qco3Pn9zDdl2sR4aH35zKU?=
 =?us-ascii?Q?4W0JknQzaAhiQ+0N0QhVlH83XBiLRw3Jp6cq80akHTtEq0w/Upe09PwuI501?=
 =?us-ascii?Q?DomGt5wdgxJubetFWHMu6ZVRISuqKIdqHcvHMNAB98d9MPL2n3C/npjvEmwG?=
 =?us-ascii?Q?+RW4iznmBwHbLwReDlD7Ig/yN6zkiJvlpFKNCMCjdnnWOpbFYm35vg0DIzGS?=
 =?us-ascii?Q?SuLpS3eAnInoZgKq38ouPMKjorPyB5Vd5mYtRCmKHGsRSTRIqFGEJe+B9NUx?=
 =?us-ascii?Q?JGOCZOTYJQDWdJ5/5DqTwCdTFnYO49BoWtTXJy7rnTLvR0OuR2KwPxIqle5Y?=
 =?us-ascii?Q?Uwy0vo4+Wwe4fxD/Re2nyLwaxcH1mlqQW/J3M/X15gWjBUkfEesaU/N17v6+?=
 =?us-ascii?Q?RoRqL8XhduOp01NLbH1FRQzGHzQCmiOSMozs4YXqOObk2X4DVQq3MD45ADFN?=
 =?us-ascii?Q?ZmNqXQ/ldgwSOlSDvYUvMvvJoFgX7tadmpHjSZyQ8Tt6TCHuI50M0Pow7r7d?=
 =?us-ascii?Q?4JHbcSN+v3QZk+lFVj3FYCME8y4YMfMW2fG8DASQca0MIOC5u2sFVjXCBnHG?=
 =?us-ascii?Q?JY5S302komq665t3qLIJsmktQd1ND5v6RavRwwvqnNpRun2dKbfYRyDpq2iP?=
 =?us-ascii?Q?zqKXOfr8NtFkmMcYy/jxX+MuHBHuM4fbwQzYXZ6gprjDCG+ND7850WYHZcWR?=
 =?us-ascii?Q?UflohaYXB2fVEeX7xJFintlKSobq5iKG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NyaYQ0Lcxocmh/7yGKhSRYbHSOcnCStNdCPak9Ms2imaIeoLoVCH4RKIg6tv?=
 =?us-ascii?Q?MycXcGTkRqJCgy2yJHZVlDq7Yko73d06XkIZ4cabEEQCJOvZRUaUpikRBPMO?=
 =?us-ascii?Q?ZHJuR92yrO12OyxOWxU/yBvSZX6DZnegO5h6kgI7S91pe6mo7Bd/bXsspUcr?=
 =?us-ascii?Q?92Nj/rFs0U0souIqyAJP8Fu+qsqt7MTnzBREt1gEN7WjtnSsMgTCUNopQHRN?=
 =?us-ascii?Q?dsStKUvJRLJ1TakHc9hqBwSmmNYocE49FtHESR+n3fleVAexMW/L/kq2h4ZX?=
 =?us-ascii?Q?QGZOat123Tlchx1oymhhlga68+MzlAho9O76qWh6+svqtEnHT4z1E2ryzoLC?=
 =?us-ascii?Q?rtq5Ad5Vn+w+uJy9roX4r9ALgUBVfnI5wdIHlKuYcfHZ4Ps+8yv2WsigGD9X?=
 =?us-ascii?Q?Y+aWME19QgzVSCFzJNnlNZdohMkHyUePB3DFH71PC4TJKxIb+A++xLP0BCN/?=
 =?us-ascii?Q?LcH8DVBR0sM/O0ccMnJu4W0dfpfYikA4QeV1/tElady6zxbbxdooAOA8AkT4?=
 =?us-ascii?Q?Rn1kbceDVkIXvjPhiOIT/2zClMc0SV+K55p3++NZ7AZnY68sQSZ5nLMMdLbA?=
 =?us-ascii?Q?hNAK+TxTAiKS3sIZpdiu12JHCu7uqZHvS4Ea5j5fd9PxviWhwox5zH6MOsrx?=
 =?us-ascii?Q?eFlkRntWZGBDU4YGV4plN1d5xg53jHYi8nbwVJTUtlMDp9EvWfi8tqgoyhCs?=
 =?us-ascii?Q?KvzS0isGdveC3hkh3eq2ZMzU3d8ysYFKUIZ5YsH/FM3TuW0NCXnYGTpjS4Z0?=
 =?us-ascii?Q?Kjb8Xi6RdrgCERmqqzujIeyfrkGPC70MILjxfDP4n11vtvfxBB8CPrYhXeHQ?=
 =?us-ascii?Q?b475y7oJovm6zKEyCvI3DaU+RDITiqsvO/CY/s73lPz+yo7NBkwSaRceWpuB?=
 =?us-ascii?Q?LRcmv8ARy58PZFEKyqXsPJeUBQUql1ZOA+9+rHSscLsy42aPWN37VV2F3lX3?=
 =?us-ascii?Q?2ECslXw4+AXx6s7eWP5hLCX1gSVOopWLFBCB9E8FFikspeG7mEdUkk/QsWeN?=
 =?us-ascii?Q?Rp83V0ahePFwXwjHCSQwhPLO9pfldArIR5rCPvwXBaPm6xxyxYD2RUOt+aQo?=
 =?us-ascii?Q?nNxOZ9qSL2g3uMjvUFBNSP9rFCR6HVKCUhawbMp7qk6y3ZIleVN/vK6Be7uD?=
 =?us-ascii?Q?Zuh+PCid3I790odluDqDY25r1MmfgwnitzcZ2Qm4dY1W3Gs86vW+luKZL3ED?=
 =?us-ascii?Q?/5is9eu0u5QyFhkR9/6jPUwy/5ySD7JhkguEe2ClfljMYlXxxYaybicyOoFg?=
 =?us-ascii?Q?eNbrHY49pEghnzDfrsmwI0yex2HmEWYRgplhB6W9oQ6l7rX5yziyPT9CkAd6?=
 =?us-ascii?Q?6SonnAcJ4UwQs8WxvCdJ+eL0UgEwcGd6JV7ALMuy39HAiG6asPCNATNRs3dc?=
 =?us-ascii?Q?vFTwXnRQxpSMQGfqfiQ66eAQV7Ojf3dIHwksFytiTLFXH7wANiLOQjNrzzkE?=
 =?us-ascii?Q?3g7Mwq0BV1Ns625Oj+q16YJk06CWofvrRHRyykxFSzrREaceHDLjK1fEx0/6?=
 =?us-ascii?Q?jYafJOXqPLF7uXXPFiXgB83KFXbF2LL/M+EZ+AGWvF6wHqluNq1gpgViGva7?=
 =?us-ascii?Q?8MC3ZRhOzTTZHBYtrO0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95df539-81d6-4153-096e-08dd5bf659c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 14:59:38.2552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdTahEuaCGxbTPzhwKBBqRj2pjvgEcTBARFrfiue9WDoovoJ7cb/Jutj8eTqbR7h7AoT1ejv7AqZnRdGsKb6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, March 4, 2025 11:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: add initial documentation for debugfs files
>
> Describes what debugfs files are available and what
> they are used for.
>
> v2: fix some typos (Mark Glines)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/debugfs.rst | 202 +++++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/index.rst   |   1 +
>  2 files changed, 203 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/debugfs.rst
>
> diff --git a/Documentation/gpu/amdgpu/debugfs.rst
> b/Documentation/gpu/amdgpu/debugfs.rst
> new file mode 100644
> index 0000000000000..18bccb57c89fb
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/debugfs.rst
> @@ -0,0 +1,202 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AMDGPU DebugFS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The amdgpu driver provides a number of debugfs files to aid in debugging
> +issues in the driver.  Thse are usually found in
> +/sys/kernel/debug/dri/<num>.
> +
> +DebugFS Files
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +amdgpu_benchmark
> +----------------
> +
> +Run benchmarks using the DMA engine the driver uses for GPU memory pagin=
g.
> +Write a number to the file to run the test.  The results are written to =
the
> +kernel log.  The following tests are available:
> +
> +- 1: simple test, VRAM to GTT and GTT to VRAM
> +- 2: simple test, VRAM to VRAM
> +- 3: GTT to VRAM, buffer size sweep, powers of 2
> +- 4: VRAM to GTT, buffer size sweep, powers of 2
> +- 5: VRAM to VRAM, buffer size sweep, powers of 2
> +- 6: GTT to VRAM, buffer size sweep, common modes
> +- 7: VRAM to GTT, buffer size sweep, common modes
> +- 8: VRAM to VRAM, buffer size sweep, common modes
> +
> +amdgpu_test_ib
> +--------------
> +
> +Read this file to run simple IB (Indirect Buffer) tests on all kernel ma=
naged
> +rings.  IBs are command buffers usually generated by userspace applicati=
ons
> +which are submitted to the kernel for execution on an particular GPU eng=
ine.
> +This just runs the simple IB tests included in the kernel.
> +
> +amdgpu_discovery
> +----------------
> +
> +Provides raw access to the IP discovery binary provided by the GPU.  Rea=
d this
> +file to acess the raw binary.
> +
> +amdgpu_vbios
> +------------
> +
> +Provides raw access to the ROM binary image from the GPU.  Read this fil=
e to
> +access the raw binary.
> +
> +amdgpu_evict_gtt
> +----------------
> +
> +Evict all buffers from the GTT memory pool.  Read this file to evict all
> +buffers from this pool.
> +
> +amdgpu_evict_vram
> +-----------------
> +
> +Evict all buffers from the VRAM memory pool.  Read this file to evict al=
l
> +buffers from this pool.
> +
> +amdgpu_gpu_recover
> +------------------
> +

If we're going for consistency, then you could add "Trigger a full GPU rese=
t" or something like that beforehand. The other entries above are "Do a thi=
ng. Read this file to do the thing", so it doesn't match the same style. Bu=
t it's honestly so nit-picky and pedantic that it's not a big deal.

> +Read this file to trigger a full GPU reset.  All work currently running
> +on the GPU will be lost.
> +
> +amdgpu_ring_<name>
> +------------------
> +
> +Provides read access to the kernel managed ring buffers for each ring <n=
ame>.
> +These are useful for debugging problems on a particular ring.  The ring =
buffer
> +is how the CPU sends commands to the GPU.  The CPU writes commands into =
the
> +buffer and then asks the GPU engine to process it.
> +
> +amdgpu_mqd_<name>
> +-----------------
> +
> +Provides read access to the kernel managed MQD (Memory Queue Descriptor)=
 for
> +ring <name> managed by the kernel driver.  MQDs define the features of t=
he ring
> +and are used to store the ring's state when it is not connected to hardw=
are.
> +The driver writes the requested ring features and metadata (GPU addresse=
s of
> +the ring itself and associated buffers) to the MQD and the firmware uses=
 the MQD
> +to populate the hardware when the ring is mapped to a hardware slot.  On=
ly
> +available on engines which use MQDs.
> +
> +amdgpu_error_<name>
> +-------------------
> +
> +Provides an interface to set an error on fences associated with ring <na=
me>.
> +The error code specified is propogated to all fences associated with the
> +ring.
> +
> +amdgpu_pm_info
> +--------------
> +
> +Provides human readable information about the power management features
> +and state of the GPU.  This includes current GFX clock, Memory clock,
> +voltages, average SoC power, temperature, GFX load, Memory load, SMU
> +feature mask, VCN power state, clock and power gating features.
> +
> +amdgpu_firmware_info
> +--------------------
> +
> +Lists the firmware versions for all firmwares used by the GPU.  Only
> +entries with a non-0 version are valid.  If the version is 0, the firmwa=
re
> +is not valid for the GPU.
> +
> +amdgpu_fence_info
> +-----------------
> +
> +Shows the last signalled and emitted fence sequence numbers for each
> +kernel driver managed ring.  Fences are associated with submissions
> +to the engine.  Emitted fences have been submitted to the ring
> +and signalled fences have been signalled by the GPU.  Rings with a
> +larger emitted fence value have outstanding work that is still being
> +processed by the engine that owns that ring.  When the emitted and
> +signalled fence values are equal, the ring is idle.
> +
> +amdgpu_gem_info
> +---------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that they have
> +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buff=
er
> +attributes (CPU access required, CPU cache attributes, etc.).
> +
> +amdgpu_vm_info
> +--------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that they have
> +allocated as well as the status of those buffers relative to that proces=
s'
> +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> +
> +amdgpu_sa_info
> +--------------
> +
> +Prints out all of the suballocations by the suballocation manager in the
> +kernel driver.  Prints the GPU address, size, and fence info associated
> +with each suballocation.  The suballocations are used internally within
> +the kernel driver for various things.
> +
> +amdgpu_<pool>_mm
> +----------------
> +
> +Prints TTM information about the memory pool <pool>.
> +
> +amdgpu_vram
> +-----------
> +
> +Provides direct access to VRAM.  Used by tools like UMR to inspect
> +objects in VRAM.
> +
> +amdgpu_iomem
> +------------
> +
> +Provides direct access to GTT memory.  Used by tools like UMR to inspect
> +GTT memory.
> +
> +amdgpu_regs_*
> +-------------
> +
> +Provides direct access to various register aperatures on the GPU.  Used
> +by tools like UMR to access GPU registers.
> +
> +amdgpu_regs2
> +------------
> +
> +Provides an IOCTL interface used by UMR for interacting with GPU registe=
rs.
> +
> +
> +amdgpu_sensors
> +--------------
> +
> +Provides an interface to query GPU power metrics (temperature, average
> +power, etc.).  Used by tools like UMR to query GPU power metrics.
> +
> +
> +amdgpu_gca_config
> +-----------------
> +
> +Provides an interface to query GPU details (GFX config, PCI config,
> +GPU family, etc.).  Used by tools like UMR to query GPU details.
> +
> +amdgpu_wave
> +-----------
> +
> +Used to query GFX/compute wave infomation from the hardware.  Used by to=
ols
> +like UMR to query GFX/compute wave information.
> +
> +amdgpu_gpr
> +----------
> +
> +Used to      query GFX/compute GPR (General Purpose Register) informatio=
n

Weird extra spaces here

 Kent

> from the
> +hardware.  Used by tools like UMR to query GPRs when debugging shaders.
> +
> +amdgpu_gprwave
> +--------------
> +
> +Provides an IOCTL interface used by UMR for interacting with shader wave=
s.
> +
> +amdgpu_fw_attestation
> +---------------------
> +
> +Provides an interface for reading back firmware attestation records.
> diff --git a/Documentation/gpu/amdgpu/index.rst
> b/Documentation/gpu/amdgpu/index.rst
> index 302d039928ee8..5254f3a162f84 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -17,4 +17,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA
> (CDNA) architectures.
>     driver-misc
>     debugging
>     process-isolation
> +   debugfs
>     amdgpu-glossary
> --
> 2.48.1

