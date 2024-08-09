Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF9CC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 05:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09C710E621;
	Fri,  9 Aug 2024 05:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkJajaya";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308AD10E621
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 05:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzT3PqivULaUat2f0aPuiHZIyuynMS7fq8ek3EMhkdoUSK6cih9hOzNW1qNaUVj2EfvHnw/WC+h1C+zphj1Jh7IVEV+pWnSnpuePMf1Q0XP1p37rVYAEKBAGOep4B1PxRhFJw0NltvokvwVq1aj0WEL/em4tAvbqqJzKbD4ONzDvrIhEa5/wI6XxXHLyTBi9ttM3ROmDA2eL7F95SCCdO9XvKIn1yv5R28IQfpm9tBXaSlRz6nXIgApfP8srnFNk9d4o+iW4RaC3h5rbDq8Jhj1WYd7eJu0o+U76gDciaIhd7r5IvkeEwOzyp2EuBuXa5QSxbVKPW1kkKyWkAI8DTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exoAMZJiXaZMMH2RbiJiU5P+kzogg36zZUBtdm0UumE=;
 b=AiRVIni/i/uFddROGDarvekQ8dKfKqKkDVJo0kzNj1weIx7UeJNeGRkQ7lS8h0NIfIwmfhm4SYDl1IzCF0ujJlnXd02BDkYZ6neB2Hgc7Xhtiak/5WnZbcx7aj2b5Eoxa9w5uUgb0YZDahGIc1NBzcssPyf6w/rZtrOyriiF6Kw20bW2/BbgMG/ycRsDunKSj45GwPdxIx/C4/g6miAbcVys+KkcDWQK547AOgzDdhyswqPDnHTbsBUILumzYn0x12+y+0Q0gTh+Kaz3J0giygZNdzI33GC8RH4eQBxJNwR60719xzcbu3neZF/ySP9QzbJTT3LHkB3AAPx/xr0SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exoAMZJiXaZMMH2RbiJiU5P+kzogg36zZUBtdm0UumE=;
 b=nkJajayarHW5MPcnyoewFR/ZyCWmCLALBuCXWQYyGhXkV31qFSdarNbr9+l3LUSnwMLaGe1MPmZqsT6iuufXkuzxsOxp4WBNdXtfpPvexBXedWElg7KAUiZkXaojsEhQkHbTFoKqeYpbPh+2kYNB1/xDaT9MBDGCZw8Z0oWnToI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 05:39:54 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 05:39:54 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Topic: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Index: AQHa6W881OX1vpnp0U6vbxJOQG6+0LIdcF4AgADz69A=
Date: Fri, 9 Aug 2024 05:39:53 +0000
Message-ID: <CY5PR12MB63696ECC884783C0812DF219C1BA2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240808084421.2755417-1-yifan1.zhang@amd.com>
 <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7ce74ef-11e6-4d51-ae5e-3b7353d05e3e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T14:44:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: fd3da4f1-60af-4e9d-51ad-08dcb835b20e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?064VS1aOeg7CCcxmdzWB8mc3vl1N2rXKZ4Blv5e3ZsXU4RsJUgXnuhqIbzG7?=
 =?us-ascii?Q?pSLFI04o4XPH5TnZIAgVIpl2f2npJYqr4ShmpyuI62sMMOzQSgDKChOBdgkV?=
 =?us-ascii?Q?N6+kuyjgjYCXtzemMSu1hdCWO76BmnlhGsGNoPd0O4Cq7XjeYR07cV6utdz/?=
 =?us-ascii?Q?oE/9D7myFmXjEccSulGD4njjXr30bzl8uehRanvRdSwSr0r+yWQovF3vHcdw?=
 =?us-ascii?Q?EX7U9cOphek+dbpdI7LI+tYMSjk67kwnZcIPNMs9quRkB0lM0mHwzcmMB7gg?=
 =?us-ascii?Q?54xW1/fC11gLZmrmHeADKvH6ZyDBQLCTp6/GXzF6Mi+utiquwaM7eXr5C1Vo?=
 =?us-ascii?Q?G9f/iPcFk25rYbJrq9YnOhyGHmjNoqtNkZhnDLyfEIlNoOspRB9hKIRBaB+q?=
 =?us-ascii?Q?ofxXZwjkaIqrL5fbXr1G+/M5NNcV0uA/QwLxqRw+TpxaUyCwAmLDWrIwLztF?=
 =?us-ascii?Q?dxTkZWRI5JZcoMIMdnZQZihAgSSmMrMqskgkzssPJfEIQS8OBceyu7eWTzbP?=
 =?us-ascii?Q?YRXlsviTYYo2mZ5evIUua/QjX3vblrOfXxED78e5vMNOzpYPSmKWDXQCAYZo?=
 =?us-ascii?Q?S1uayOGbItpzNXlSwBH1gnT/cwWbSudBrLqO+XnMpoVJXeuCLMXvxYogoIOq?=
 =?us-ascii?Q?Ps+9PZE7b9WARVvqQOcLicS4R9KfuDsT3czMjVUoyxfBtnm9xZnUzKKQvFEF?=
 =?us-ascii?Q?DUmrvLNv8AirjPeNIh7qBRX/IHC4xAWhR7Sj8dA7EvBpdGnxGTNqIP0s6fsK?=
 =?us-ascii?Q?84lClIs97mIiGWy5zxcNT+7dUcY0xrNOikyMynkLJ/gOHgAobeMz1GjJb5cW?=
 =?us-ascii?Q?g/F5kI/1L8dz6VCZyf1WQnRFpQ4FZewW5whyv9YRbG8EICzDkUxTh9FfOjKz?=
 =?us-ascii?Q?xOKUekgNWOiYzwmOWkI/e+GrBqFe59p+kbdMNhFgwl9evW3c4Ti564ZHqLLV?=
 =?us-ascii?Q?GKd1oUm+qbLMXKACmhmY2m1R1Gfu9bkWV3wp6T+1OefytWceKX26vdrvYS4q?=
 =?us-ascii?Q?no0OqwKy9iVtR/sH5bdT1c4MUv0cDohto7nfL7cGFxqxfxAHPY09hxXA5NYE?=
 =?us-ascii?Q?UjLZjRaXnOqHrMOAVO17u3M88Eyapb/rIxS6XO/zANEXnEsfwBkKD8ZdlIWW?=
 =?us-ascii?Q?fp6qPuxA3Hk+tidT8GCZjvB4RJ4M5lFh9CKESwpZlOM26GUiT8HdSNcPigtr?=
 =?us-ascii?Q?04gfopaUGMl305BE/6okHuJ1muCPQOI9FYN2rMvZa66hayGwxvJD1KARI28T?=
 =?us-ascii?Q?0Amy98O0GAobb6HCPzgJB8RyrDka8j81Dj5VUm6F2TdMBMfbyuYvjdOQenoO?=
 =?us-ascii?Q?3C10cjepRuCsyYBsGNY/FurvroZFm0nyDoJdhEbuae5+/HNrGpH2Z9zxcLIx?=
 =?us-ascii?Q?P+H76Tlycg+Bja9EpGQ40AAR61ZohuLWNZkn4QZOS46iEEq09Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDJM5ZQVu7DYR5D/ToJ630zUiyMBbA5RhFe03penuTF6ukFu5ZDs3/1xI/sk?=
 =?us-ascii?Q?wLJ4C1sN8LIqaKJEHmaX2BXujQMy3bqS2CmBUhR3eZyfTBW/uK9R7QfWTJl7?=
 =?us-ascii?Q?57k1s4xJFDsjWARDjxdTFGaZHJfOUewijYHAcaQdZwiJI1A3Mtahe3XEujmS?=
 =?us-ascii?Q?XjbJghfpX9GowkXWlsgGNweDeN16cXvBklsWFLrwR7k5DKRAedGI1NSkHP0y?=
 =?us-ascii?Q?Wi7xEIP3EhZz3vmzg2sS8YWJtEeQVEFFGx/GrFJEL1M3ZKUwnBWVG2oO1IqE?=
 =?us-ascii?Q?xRbYUhIbLxrRSRnPTUiPbvcEy4d+UQealyA3BV4WQvZ+R59JcCIhtBiQ+igX?=
 =?us-ascii?Q?NPqAhfnibISKjVtgQTfSCzq3YGSR0heZyGyBG8LYzdhYkhLtKFOI+U6pNabi?=
 =?us-ascii?Q?X/QyGtPUlvhwvexPQ3OdT7gxzEmpYEWtE4/58R9AJAD5rGy9BOgIeMtJpkto?=
 =?us-ascii?Q?ME8xBaHUN4ae5Hb66BbwMijdGn3RC9jrMwiChp8PQJ5Zd4xP21l2eBuVA0z0?=
 =?us-ascii?Q?U8a0yIv2B3I1YRfEuqMkfOvE8xOLnDd/pKfN6lcoklguayMGOgw5uTSCGuFp?=
 =?us-ascii?Q?3BM7wyu4MhBI7jj2QpkdVJh5byBfYWL9vg7N9fGqG+cTbzyZEnble0TSh2uE?=
 =?us-ascii?Q?RUwyVamEMag4Q1AvmrKsHQnpDgsE2SjuH/XGoTVxFZYjAyGaa2KaB5+rR6HI?=
 =?us-ascii?Q?fWYFC4hl7CUnx9owKxoXbTzz9piXoNHV49BYeuLakGtADfM3ASoHnJk6bPGt?=
 =?us-ascii?Q?OXEajYl5xqBzahzwgFs4OEaTdbGCH8jPnffamJRBBRUTAXQqLaEz1H/HYFFV?=
 =?us-ascii?Q?Ojqo/go6kxBGVh7DaFoLedMJESXarI2R0xywbflQwPnTqPiT/BnW0GNmR01/?=
 =?us-ascii?Q?m//uovSwvcN2JuJBc4aNcKqkv6hVPP0LJtY6TFnz+tCLkYe4O0zV/1DvroXR?=
 =?us-ascii?Q?TDYNa6v5VLg/61CNYqA5SnElzTvwjEQuMwfenR0UXaELOKDGgC1Ad9O+1C73?=
 =?us-ascii?Q?QMnnDdEzMGZgmZaBCJ745jZSTbOn1XQv5gKcdpweq54yjy51cKcu6GQSah5g?=
 =?us-ascii?Q?ek0cpwubpiQL4xFNbpNJtlzBR3jnmXOUmhzKSnNjpyu3OOcsWqVPokrcrA5o?=
 =?us-ascii?Q?ES9Gm2HNjeLIyFxcGfqqljWSMv0eQgGlwMJRcg6rUHJgzaLzdwSuXVd2/gNL?=
 =?us-ascii?Q?4/Nayx7/AlPTlOrzs0MRE6H+Hu600E8ag44pf0wCGHV8awMh86m13PhuZVyq?=
 =?us-ascii?Q?H7ElZa0qHxVjCiyh1RQJ6mJ6yHXa0Xnr73yE4p5Zr4R0wsn0j4RIhvdaEV3X?=
 =?us-ascii?Q?j+CghsH/11AUZD87EoYx+kH/lvECy+yCNRPGCOGIHWZ9jEavsVQbbV62ta5d?=
 =?us-ascii?Q?fZzE3vJ7cETkamqZw8YWGNV2gTk3vVMGGcky/TWyA1Di8qujKJJ7Xipi0+0I?=
 =?us-ascii?Q?LPTvv8r/2MlLrhRfJBFRc7l8CTydLXk2MebqtADHKeilCRtIDNoLDkXyNOPm?=
 =?us-ascii?Q?C4d7iz/xuRXRRwYw1st+ta3AQ4j1nPCbWqw2ilbfx+xf5ARwgEMYQVAVQC/8?=
 =?us-ascii?Q?doItGAfa0rOEbKULlY0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3da4f1-60af-4e9d-51ad-08dcb835b20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 05:39:53.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6D4JcMgHtHTZWzkKVcduGX+iNVO0VfBnL/hVtDjhhMoCQ8RY/8K6lglDYzsgtkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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

[AMD Official Use Only - AMD Internal Distribution Only]

Yes, I think we need that change for a normal code path, but this case is i=
ntroduced only with the HSA_OVERRIDE_GFX_VERSION environment setting, which=
 implies that "the override ASIC is compatible with the real ASIC." It is i=
ntended for experimental purposes. When a user is using HSA_OVERRIDE_GFX_VE=
RSION, they should be aware of the potential risks it may bring. Usually, H=
SA_OVERRIDE_GFX_VERSION is used to force an unsupported APU to be recognize=
d as a ROCm-supported high-end dGPU, which has a large cwsr save area, maki=
ng the operation safe. This check was added to KFD two weeks ago, the HSA_O=
VERRIDE_GFX_VERSION environment had been working fine before that.

Best Regards,
Yifan

-----Original Message-----
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Thursday, August 8, 2024 10:46 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save are=
a doesn't match

[AMD Official Use Only - AMD Internal Distribution Only]

In this case, shouldn't larger of two sizes be used. Also, we should have a=
n upper bound check.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Thursday, August 8, 2024 4:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save area do=
esn't match

If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space and kernel=
 use different spec to calculate cwsr save area, current check may fail cre=
ate queue ioctl. Change error to warn to make create queue succeed in that =
case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c
index e0a073ae4a49..9f283aff057a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_devic=
e *pdd, struct queue_prope
        }

        if (properties->ctx_save_restore_area_size !=3D topo_dev->node_prop=
s.cwsr_size) {
-               pr_debug("queue cwsr size 0x%x not equal to node cwsr size =
0x%x\n",
+               pr_warn("queue cwsr size 0x%x not equal to node cwsr
+ size 0x%x\n",
                        properties->ctx_save_restore_area_size,
                        topo_dev->node_props.cwsr_size);
-               err =3D -EINVAL;
-               goto out_err_unreserve;
        }

        total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev->nod=
e_props.debug_memory_size)
--
2.37.3


