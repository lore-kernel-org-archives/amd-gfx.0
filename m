Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D649AE77180
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 18:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B2710E354;
	Mon,  9 Dec 2024 18:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FFEG816X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE75F10E354
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 18:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpYjG+Mt5E1CQ4kkQKZDFdj4NTIYry4e+priGC9YpSkRxnHjWeSbWJ+koUNY8vNBON5wycz+lTXBK55B6XnN+fiO095lOiea9C2Ds03phtjSiZjkDzo1dzw9e4pTOhTptCusye4f8RkqWGqh6RMHCpXO9YZDLUv9ZSQYPAsEVqkKxLEqRFlnBFvtOHtLqXSuLqPea3I8f+4Z/t0cAzFOxjQjnaDQQjLf6msYtMFLwfQ2R12Cv5JdIKGFZaha84+OtKNuBWi0VOvp89npjFc/efcT5+J9aYUVMVfjcheu7aVjgC5c73vtL/jEwCVkDjvXC1NmDBz7pWGDsvCrRZJYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qjO26PwV3jxkTGyPkLMBPcW2KXcbuqMewnigtNQkgo=;
 b=HASpJJg0ZJdWV5ESCrl6YxPg3QLVBshrAs3dr9BA/hhqmGitIekVuee3z+vqw8JYTNFFOMLryTBlmFuU/lSx6/fGZpirKMTK1eWSaitIQRDq+aCUvtJGt9QoDreGpuW3uFvFsbGknktA5OVuZUWAr3rxXOXsq7WoarfHrhomUB5CljuhV9YJYah1tZ07e/6TIzQj9TimU1d7zx7IwXaojwhqEX0sy/tQjEIPuDh3NGEnEbrgG2qVfIc9xl1XjivsoBBwwZ2riHnEbl9me7Ry9O3KF1R6G2Ds9iX7g3No+NLovtF6sS4cYIk/TCOAjOwVeJRcgefsi6AWecHqwxLxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qjO26PwV3jxkTGyPkLMBPcW2KXcbuqMewnigtNQkgo=;
 b=FFEG816XSOuaqPubIOISSwK9pnszgGv9UF16WfqYIvzVvFJAJhjOKKV5lSSH4HpzEidTf/PU5wBhZMQTnSuZHI8oV66/yFh2DZikp+4kccil4McaTNi1JlrImNiRVmPKkFkLjNjGr7TReoMkg/nTAC08KcJJ+ZKqxIWfxySISvw=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:52:23 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 18:52:22 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tudor, Alexandru"
 <Alexandru.Tudor@amd.com>, "Martin, Andrew" <Andrew.Martin@amd.com>, "Martin, 
 Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Uninitialized pointer read
Thread-Topic: [PATCH] drm/amdkfd: Uninitialized pointer read
Thread-Index: AQHbSBqNCHKiszaU6kCQjk8IfEed+bLeRoWw
Date: Mon, 9 Dec 2024 18:52:22 +0000
Message-ID: <CY8PR12MB7099490F7AA16524AFA8D8588C3C2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241206200727.2771144-1-Andrew.Martin@amd.com>
In-Reply-To: <20241206200727.2771144-1-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0f7efdc3-8100-493d-8732-f77fac1461a4;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-09T18:51:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM4PR12MB7526:EE_
x-ms-office365-filtering-correlation-id: cb86ede9-6ed5-41e6-acca-08dd18829dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tRVI/rLlYhIYWEgnOWdWsW9sBsKM7Kya+C3wzwai3qPLOgEPfPGv9EhPw19K?=
 =?us-ascii?Q?KbRBfGQeb3BzzqGwVh/HQEtoWsrs/+unPCKNtgd5NLGznhUygfm8EPVbdWiN?=
 =?us-ascii?Q?7b/rrvukWetaInc+oeY67uKfmn4PVoUYmbOXT/YUwBEHyoahP/8UhF9dTmv7?=
 =?us-ascii?Q?LBBCdYEBwo6PmCKDf8cREd4bMieb9Q39WcDdVKzRt0FaSXsfQY4fzxkA7m3u?=
 =?us-ascii?Q?j5+6JvuoNS8nG0doaP2iOl9FsXYWFoHgdUi1rCvNl1NIy1us9x61t9IdMmtb?=
 =?us-ascii?Q?FkXdag8PEPcsep3q/DiRjOsmVFxP2j/FD9W2KhBaS+h2Gt5SyktygiETW/EJ?=
 =?us-ascii?Q?T/dwZotqm4cnvNIqDWXE9TDrAUao8+DKGDzYPyebBeX+702NFOdTdBWLJQy6?=
 =?us-ascii?Q?lKu9Vj1bApPxq0zQCLzRAB1gI2TlSu9VnoSH57TvtGfixeVQf2w1aD8ByoF7?=
 =?us-ascii?Q?9UFlgf+AzFoJHgQNGONHiGgP/qVpF46fMXZga/vunk1Yes9U5mUBWxZRrMYb?=
 =?us-ascii?Q?zCWY+35GeR0M3R+n8NzC+wwqyHRyRd9z66rHLBHZRcTeeJKNAtOVgENR5B0h?=
 =?us-ascii?Q?tlvNg3tq16Bnf8MH1T3TMgm5Wr9aN/IeO1BF2bCrDSJcRKeqRaPKqF8YqRk3?=
 =?us-ascii?Q?MsQTGlBYv6yzL6B6uNRusPv6xOwYqfDF4JUHLY3Emh4TJ+s5GThDN4r2YKdW?=
 =?us-ascii?Q?NfXU2HE3/y+aY2nX7IuBq+2wVbvys7320Za74bEPAxRd33/lbv7MfE2ai708?=
 =?us-ascii?Q?NU7l36EvONQTdHsWeVepwcolWyeR8cOPN7VYegj0PIg/MebIQV0SQWhE/ws5?=
 =?us-ascii?Q?DYRYeSWl2rtuRgSOecXQO6REM0oaTdXjLNN/HFaw9YIfdrVFPcRAuM1yOBjD?=
 =?us-ascii?Q?rrq5ZXcCS2vuRnVPUqPtLjjTaLU1Tjz5LYQZiakiF0hNTufILXcHK2MMn//F?=
 =?us-ascii?Q?eogSR4oitP9zwK2F2KbGis8TuKBi/geolkG+i+gOkWe8gm4K4+WC6uO7OZxl?=
 =?us-ascii?Q?T+mAEaUMaDdI4ay01zM0X51cID88QTe/6xRSxpOxxrHqYiyuY8ERLyW7Q9KH?=
 =?us-ascii?Q?8x1I9gc2ajX/bXtjKIRrpjrBXKtJ2WcrHaCcmxYucIL+Oj10DrythHHnhTlq?=
 =?us-ascii?Q?pq4rIqmgGy/AXrx3P77sgKUU0SHlYIjdXtvHKyrotNYGkc91pbkPTpYvudba?=
 =?us-ascii?Q?Ja3RiGiVeAK+Cv3xKW1B5HnSnPbPTL8y9hkQzrkroHIyK2YU2M9QKU1l3V2L?=
 =?us-ascii?Q?GzlZgwqcsIf5zkQRcFPhm7k35+fitHULjCzCKr17EdJ55TPvg2DMsAZ8epgV?=
 =?us-ascii?Q?5ePIpEaUgEnh5E6nx0RJMYIe99CMcEAFTl3JQHvROH+l4iawnLDnPNjueA59?=
 =?us-ascii?Q?mD0cVpv+Y+Le7ViA5r3gKeRM2HyP0bkrD/1O9RgC6IHBNO9W1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nupU6A+HwNte90SO7ipm9X5ydGEt0yx12E9WGvRHd+B/vbxeYbBGUpFAgc6D?=
 =?us-ascii?Q?Gp0ecu/cpa4xGcPRwsRCl/JGpkTvqJAamde4r+4ZS5zzdFfNWsJE7MqS2tMF?=
 =?us-ascii?Q?Nh/U4QgDYbKN+2rzDv7kMsrPUKghlZP2Mu6PotuqsvWyKHB5FXPLSxQARd+O?=
 =?us-ascii?Q?HgaNwQjIi+FmjFZjcSq64Lf//5va0QR7gIFfo2bAXlS110DZVX77jIRs3ZYE?=
 =?us-ascii?Q?BNCe0/MdwxRU5ZD7ITFCdQ1cAj0O7VTgGclxkAo6/fGkYUeNuRWwLiiAn7GQ?=
 =?us-ascii?Q?WJEEJfJVcNyenk+Q11n5bu0g0QcWiMLmaRK/mLoTKMoIB3Kz/yWtew5mx5XN?=
 =?us-ascii?Q?iIt2hgYa+5lV8aiipFxGM5j7BwKyhqq9m/PDJbOAFf7/f6KfCv4mYif5eS0X?=
 =?us-ascii?Q?+NApLZd4fyXf+eZm/3Y42IQHk+GK6uDgTrk3cvoX49K1wbNgMJ3KvgoCc4W0?=
 =?us-ascii?Q?A8E9L4e73OzikYY76EuQ+Y+g7nzJwWuDBzBjhL/Yy6KXxNc+zM2qCT7G9SYZ?=
 =?us-ascii?Q?IDQQ24jE2C7TOpVmGgC858b+JBNSlryLIdBc5mdhxxuTJ4PokNurA9QpItVQ?=
 =?us-ascii?Q?G2WiZqckzd3dxelNrWG8DvqE5cO8nTPcvGpBuXBRSuhiEjeRAbvohs2YPKY/?=
 =?us-ascii?Q?MdgWMYEiPdoW/Mnbtz/RphYxhvfNEZK4sondHkXqOl2BNj5o38en9ONqwNgK?=
 =?us-ascii?Q?MqQ+85vytQ8wj6paaoZeMutQZ7WEGBCsdIH58W7QOkgSpDhUJO9d3uAL8+i3?=
 =?us-ascii?Q?vm81AzG+Kut8bGP2U7b6ivmHSUFLWFDYJN/h+yjimmPvbhXxYZGUi5sIgf5w?=
 =?us-ascii?Q?T+6nuhMBwsActrPzZJzl7sy6eqaXqbJq2FWvy7G5d5RWmVhUnT/OuVDdU4Nb?=
 =?us-ascii?Q?99eUGRTaPWUepB52ZYiRGUj3gZPxboTsQFp8qES6pR4/zXECqwS2yrn606VS?=
 =?us-ascii?Q?3O8xIUO+FH09UdHI3bfW2y1nI7X+/44dWKj2EIH5DpBWlcWtXv4CIrIMJXHW?=
 =?us-ascii?Q?tR8aPVL7e2O3OtsADMvDXAzodv0iMTECdRxjw6S9MJYm9/YqpmJl1TaEYMPB?=
 =?us-ascii?Q?JVkPV/RsoOIIkv7soq241QSSDvteYZLdX0QqtVmo20J8qb9QG/hKGdpYX9pu?=
 =?us-ascii?Q?eQRZ+1+ow0WV+0PC6lEPwdXV36RNCv+SDacJZxczRqhwWIpcZ5MQ+z45n/Nr?=
 =?us-ascii?Q?hEEW9nwpDReabaQz8hYcfOlf1VoCxjQwzNi1SSfp7/2DCn5pZNCuoKIZIeH2?=
 =?us-ascii?Q?WtLh/lHS/5t7KQE8dwfziv4ZZD0R2Nk6kK+w9dsQhnfqLQ4MGShLTrTKh3GD?=
 =?us-ascii?Q?a1kMmaiv1ETpf8M/ZUaV8fXIV9BY5/0X4+leHdlOPQ571n2Bg/GHwo83vD80?=
 =?us-ascii?Q?CXNBlGbrv9k1V6KgGaVvTbfO4skSMhd/daWQzvMXECcA06Sx65oaiws5YtBs?=
 =?us-ascii?Q?Llpusl4o/qOTXeFat/k1t4z9vQFBmevpZH0IP5XK5AolqQaCfGNPep/VW7K0?=
 =?us-ascii?Q?2jUgsgEwpUqGoWMKnXaPIhak+TrtFaBjYPViSEK49IdqZUoQimJD1VxGOxGW?=
 =?us-ascii?Q?ro4dabq05MfIojwEu4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb86ede9-6ed5-41e6-acca-08dd18829dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 18:52:22.9396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNQqmENi+GrR/esCK7Wmn4GmkcVWLKZxAGYJjDN+V2peTBxseYUpVEc5vLnCq7Z1wk1mY9zk6ATzWe58g3IKlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew M=
artin
Sent: Friday, December 6, 2024 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru <Alexandru.T=
udor@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>; Martin, Andrew <Andr=
ew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Uninitialized pointer read

This a pointer that is being passed into other functions, so it is best to
initialize it to NULL prior.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 52c6c5e9d264..ceb9fb475ef1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1777,7 +1777,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_t=
opology_device *dev, struct
        struct amdgpu_cu_info *cu_info =3D &kdev->adev->gfx.cu_info;
        struct amdgpu_gfx_config *gfx_info =3D &kdev->adev->gfx.config;
        int gpu_processor_id;
-       struct kfd_cache_properties *props_ext;
+       struct kfd_cache_properties *props_ext =3D NULL;
        int num_of_entries =3D 0;
        int num_of_cache_types =3D 0;
        struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
--
2.43.0

