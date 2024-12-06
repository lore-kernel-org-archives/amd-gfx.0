Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22666E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 11:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11C510E03B;
	Fri,  6 Dec 2024 11:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUhWQAdp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA2B10E03B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 11:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnC2A88qdCoXHVYXtOUBXpha5ZTVSdcOt/J2fFMqQpc3NCufsFCKjGH5aIuHn2tFFjBGl3ti4rkxZzYccbX0owY4Pp+CLliNAQblwx/1AyNAV1hU5HiY3mRei8bbFgkPYGq3U/isYDjwAVhpNUhTH1Wiznh4L0ij9gt6yxBw4EssBu/bM4okAjcq9fFVPBpkT6GBl3nHP/N86vDYagGnnpMFC5d9mrpf2NCO0tR6JWfRAbNC/j4CUif7ozy/7LUx/zt+Q7QE9EjK7ZVPQZqF7sMfi8nzGTfuxWeoEz6DBVfoExnC/P2FAEz/mY6P2iaDD0mNg4yNcbDhLosn6MPt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE5RhjtrsgSvv7MiL4/L4fZIB67V2tXn+qE9l/FXrfk=;
 b=YXer1bzmbH19gGgE2xcNECmA2Bv5twXnGkclcPk2qd636Z7nkTQNZkZ10vLcqqcHbC4bbCP2zIkCrLVW6kHcXUhSZBnhzZxAqLLr92AGm75WJ8ysh2lHhp+H72s39lN6QRTBoiBX+x4gXZ3q6GKZWbQBNWlB69BT8Mb6NlPEV42hpZk5N6P6AaXuQqYKTiBCcNLxM32fjrAIl4VRYGa/JJuyMb275kcm3EV1CEC4J6Yqw7FVuJkAIrn1Ft3K4lJcz3wvoOjAMrAQI0Eem7yJaETfZF6cxNj5N11DkcMepzrQYwrqVNtgQqVSdBMJkYSgQoZZiV/bR9RDqzDFecNk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE5RhjtrsgSvv7MiL4/L4fZIB67V2tXn+qE9l/FXrfk=;
 b=wUhWQAdpxaZ2se+68ij+qLQyCVLqkiXvPJ6UXFW8cyRMX2NlUe3v1rzOPE5E0G/EHxfeEjjPhhnAyUaeKEHuchR4p3L17/qNPXxrl2P+nnMB69GMJZZNbssoeiQ4sP8SVgZaDnsSypx+6M4kMLJT9R0huVHKZk82CY5KJFzpxe8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 11:07:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 11:07:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Support nbif v6_3_1 fatal error handling
Thread-Topic: [PATCH 4/4] drm/amdgpu: Support nbif v6_3_1 fatal error handling
Thread-Index: AQHbR74Nw0o9e1PEF0efF+LoStPMbbLZDokg
Date: Fri, 6 Dec 2024 11:07:52 +0000
Message-ID: <BN9PR12MB52576F21B6750B3172F35B27FC312@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241206090455.182520-1-candice.li@amd.com>
 <20241206090455.182520-4-candice.li@amd.com>
In-Reply-To: <20241206090455.182520-4-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d5205f3d-3f40-42ab-8491-a452ed7fd7de;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T11:07:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8307:EE_
x-ms-office365-filtering-correlation-id: 3f15e07f-066b-4f8a-9b2f-08dd15e63aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EnNsD7WJdoylzzvl9YHsPZ8aB/+oeAKi2t0cskvBf1sg6zPHigxIwlp2bTUp?=
 =?us-ascii?Q?RWYCiMWTN+lc8/z33S47HxHpb5C/ZYCaAG4xwJwSeVlVnKWQwvl0xtBoUTJQ?=
 =?us-ascii?Q?SRUZ/7E88rKJygNGdk3i/I7amUF/PS909OYXmDPSZXNzSfyQiuvJKHP4Nf0K?=
 =?us-ascii?Q?tptDeD53W2NE5UTbrHnP55Cjkl1IwGqfQeMwASFuCfBrk2empUBYwatT9vEU?=
 =?us-ascii?Q?+5c9tKcfN7iLHFJJcdbzmEKWFQZTsuYcs/6rKv8eofShtUpghivx0VKtr2Tx?=
 =?us-ascii?Q?NPyGsKralPCzLC1vZcrLL+UoPvSzCTNhOTuG3oF8MpbMGpjbyqwgivDzBqdf?=
 =?us-ascii?Q?0VRGmkv+XZ4WqLv2tl9CFmFphCN10fivkejpdwh+n6vl2wi3CqeAwYbADJ8O?=
 =?us-ascii?Q?210RKbApDSUn8k4NL0ty2hTsc76FHAQX0sCoVPvJt12RCMziv8y7+0FQswuk?=
 =?us-ascii?Q?gT5BPkLmyU2jKFqLA4a6oxSImgdKncQ+rki0KohUjvCvCRrS934nyZzdJhRi?=
 =?us-ascii?Q?DoA60FJ+x/eCzqp64fQ66oVccdY1LVWDN05qJzsbgBJKZYJ7PWjL9Gx4cTxM?=
 =?us-ascii?Q?2otGVSzuj0Yew8Ch/VtcuTRMpjIVtT77KrrmWnCdrhKkBtmM+hlrLTjfMeKM?=
 =?us-ascii?Q?77vvPuat4rpMmiPyzui13JH6EZBnmgphTvBGW0qzH5i5fSxYWI3LRL903+wN?=
 =?us-ascii?Q?FmkzP94UArFpkFc6wJAbRulUbmFi3m1Tbhm9PAH/+l5KyeSzL5mf35/WiuKp?=
 =?us-ascii?Q?TJ8klb2eE1BtPycEISzZM784z5ca51iLjLXgSSobwHFPg7AhRM14njervbSG?=
 =?us-ascii?Q?iKgHvt+FYtZ+NuptCE+8Tp2w63UQWlgVWO1wS4V886kCai2dgISorRvdstch?=
 =?us-ascii?Q?tjOYgvzHqr9HmKR4fMqFR6/gIftojTiy/hOwKwdL9WKeE7tj9e7ixbLIA3Zj?=
 =?us-ascii?Q?DZ9tXq9h6YpppURaSK+mZspw5lY33x0/05j1qkqWJXep2dbjfr09+ZId1aGv?=
 =?us-ascii?Q?pSuf4157jXTemDPjXB1UzS6AsxlPfNh5MbSK8it1gTPgmVq/k0O6xmRLufy+?=
 =?us-ascii?Q?g8wd13PA4CDxOsltSQAy+hc6kyfpEX4318dxvyaCDdxTBvAF2abFkiiQ3Un6?=
 =?us-ascii?Q?MNkFrRkRCvpX32cuZzptiCH1CsBti9q4JpNnDyNJInNmtheGKk8IRUSK3/15?=
 =?us-ascii?Q?PHrS/J/Jga6aTlb5KsjlErwyKvjhqzk6KA91iDrEi7H2oeNWsmziHdJj52zB?=
 =?us-ascii?Q?mc+p+rm42SwjBdOrOto7P7LP6eGdQtmg3f2nE8lvVWgbdSQwj5nc8+owUz1T?=
 =?us-ascii?Q?atf9ri9jERaZadF3ZhIbWWRZEu/TCKMUnAbTUW24aFe4BowDWF9PzTkL23Wy?=
 =?us-ascii?Q?g0g3CoA73aWMl06ZIBalYkat9Tc4KgqGGaB1S6+jzGMTF6UD1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TWUfjTF8lYGXKXO07lzg/TFYp7S8mAKn1bnQjLF1MzFCs+pM91FiBdXFrXQf?=
 =?us-ascii?Q?PYjJBhNQbXUpRN8MaYqBfYWibrEr+i47jaA3yWIvHROOrEfw/FMt0KEM1433?=
 =?us-ascii?Q?uZMl1M6AjvtL3UUgE1oApAY8TzLVbATE50OzbIiNJmqAXu7FxTII1rYiwuDd?=
 =?us-ascii?Q?I+SfItFj9ipUSK7jWLcWNKVZ7k2PWGKXN3ZHq/Z0GQfwJ1iyRjm3whJc3b4r?=
 =?us-ascii?Q?gBocLHM1H1LRSUJ/xppAozqe9cPxpr1n8R9tuD/RMB3TAenLPHsZOfnvPZQO?=
 =?us-ascii?Q?j9uOMJ/YvFEErkfA9GQ7kj75JATYmLOrEMfaYgBv7hhg0NZ9Ujr1LmZt5W3M?=
 =?us-ascii?Q?k0kbOgujXftJE1Xel/KxokaCFnQTdvTTs+KuFSNAJm8OI5SHxDaOBAl076lx?=
 =?us-ascii?Q?Yl11mEh/Yxs5cM0ZYn8xkAHuzpdpndSZKAELnRBQqqaC1SHdXNZbAlBmccis?=
 =?us-ascii?Q?s0nbZ/HHLa9jyxe7JWMuzkE5OfS33va5dqIEBizj1UWYDlAiQ3x3dewKDEZP?=
 =?us-ascii?Q?7QixpUcKnthsI0SSnAIyE61Ar2lON/wzoxP1GqdYb/6XCH/nLVsrkj9TZGpv?=
 =?us-ascii?Q?ZEsPhEupqJuPIAvkHKc2IHcMDTY9Mp+BUBts+DIbcDEGjapwmoYgaDr9Khud?=
 =?us-ascii?Q?IHQ7Z+sNFi/7IMwPz6RdtSnHZp8YO25vBKeYUNNrI0q4YyvRByIMLlIS9d0r?=
 =?us-ascii?Q?IRhSGny7puR5kZor8MCNOkwE+CZxkNrMwhpDSBpo4YOT/UzLelpgvUsPGMMr?=
 =?us-ascii?Q?+Ff/IH8jff1BxclWoE8zWkFCqtJzDOg3YQAfRSCUB/FNh0BQuzb3w3tRkA3Y?=
 =?us-ascii?Q?2pqy6O2yEeo47NE8IJ5gPtYM2tXobDgwK+zaqQRcpJoDLtPUVb5VkqauG32I?=
 =?us-ascii?Q?eY0TWy2kMZZBB3PGd72J69hGeQIrGOZvg21tVVYbXsTRoRPp5VVxeLIgO8i0?=
 =?us-ascii?Q?uSqXp9uiUNGx/TtsdVdxtSulmIsbmoDzropI20a0GhmygwtTHLB1HZ9MawmU?=
 =?us-ascii?Q?l/mC5g1+yXMw7x+ljLHeglMDS0Ys8TnEPUpnaDkpkKxBlpbsvSesKnOrOUVw?=
 =?us-ascii?Q?09xihotM7EAFgjoz9pI6ub+Ty8MsDv9w9bG45Q389vXqLIz5vcrNZQafP2DQ?=
 =?us-ascii?Q?IlpvLGsF6pQF8xag7aKm4Hw359bWVGy5yha9zmfNV4Eqe+b18GdiYWPQB8oj?=
 =?us-ascii?Q?0TwvVsbIU2lI/uLoyDPAPSIwXd0x4Nla+RYf9o8osO68kvsTxkjsXtBQNpeZ?=
 =?us-ascii?Q?DinDs6FSkjEACQCVlkWLc1ZA9Z/KpHBpQg3aNB7UutAjNcsh8RSUFC5F/34c?=
 =?us-ascii?Q?3TsMjF2YHFILouSBi7X7l8P1k5SIvbJuQXM6bZHY607QpXhCyXIl8Jk6s/b5?=
 =?us-ascii?Q?kOlKmt2xsd4MsjSOJWkxHwj/sSz0wDsuuRvvkh/DzyYbDhV86SBItKAQRdQH?=
 =?us-ascii?Q?dLnbblnf3sQaEMhmH7Ku6bywMxpn+aJgAVUZBH65q8mjXN1aes7gF8wTzFxz?=
 =?us-ascii?Q?UOyAmFqZBSUFT1Qf/aPMrW+l4bWjuE1uLhQ/wEbSRxF4WIeI+xEP9dcZfUS+?=
 =?us-ascii?Q?g3awGY9NYqZ6u6FrgyqTxMaSipsc8QOYMJGBQI4/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f15e07f-066b-4f8a-9b2f-08dd15e63aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 11:07:52.7596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opB+1fwSe6zC5OcyuIvalN/dAGlCwjggc31nA/jrbgsTAdttnNU7+oAE5e0KWOTEocJKJjcy4tlVdgSLUOCTPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, December 6, 2024 17:05
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Support nbif v6_3_1 fatal error handling

Add nbif v6_3_1 fatal error handling support.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 12 ++++  drivers/gpu/drm/amd/am=
dgpu/nbif_v6_3_1.c | 81 ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgp=
u/nbif_v6_3_1.h |  1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c       | 19 +++++-
 4 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 623ae9b3880037..db081618e85c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,6 +36,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "nbio_v4_3.h"
+#include "nbif_v6_3_1.h"
 #include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
@@ -3911,6 +3912,17 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                         * check DF RAS */
                        adev->nbio.ras =3D &nbio_v4_3_ras;
                break;
+       case IP_VERSION(6, 3, 1):
+               if (adev->ras_hw_enabled & (1 << AMDGPU_RAS_BLOCK__DF))
+                       /* unlike other generation of nbio ras,
+                        * nbif v6_3_1 only support fatal error interrupt
+                        * to inform software that DF is freezed due to
+                        * system fatal error event. driver should not
+                        * enable nbio ras in such case. Instead,
+                        * check DF RAS
+                        */
+                       adev->nbio.ras =3D &nbif_v6_3_1_ras;
+               break;
        case IP_VERSION(7, 9, 0):
        case IP_VERSION(7, 9, 1):
                if (!adev->gmc.is_app_apu)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index 39919e0892c148..c92875ceb31f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -28,6 +28,7 @@
 #include "nbif/nbif_6_3_1_sh_mask.h"
 #include "pcie/pcie_6_1_0_offset.h"
 #include "pcie/pcie_6_1_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>

 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev) @@=
 -518,3 +519,83 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs =
=3D {
        .get_rom_offset =3D nbif_v6_3_1_get_rom_offset,
        .set_reg_remap =3D nbif_v6_3_1_set_reg_remap,  };
+
+static int nbif_v6_3_1_set_ras_err_event_athub_irq_state(struct amdgpu_dev=
ice *adev,
+                                                      struct amdgpu_irq_sr=
c *src,
+                                                      unsigned type,
+                                                      enum amdgpu_interrup=
t_state state) {
+       /* The ras_controller_irq enablement should be done in psp bl when =
it
+        * tries to enable ras feature. Driver only need to set the correct=
 interrupt
+        * vector for bare-metal and sriov use case respectively
+        */
+       uint32_t bif_doorbell_int_cntl;
+
+       bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOOR=
BELL_INT_CNTL);
+       bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cntl,
+                                             BIF_BX0_BIF_DOORBELL_INT_CNTL=
,
+                                             RAS_ATHUB_ERR_EVENT_INTERRUPT=
_DISABLE,
+                                             (state =3D=3D AMDGPU_IRQ_STAT=
E_ENABLE) ? 0 : 1);
+       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
+bif_doorbell_int_cntl);
+
+       return 0;
+}
+
+static int nbif_v6_3_1_process_err_event_athub_irq(struct amdgpu_device *a=
dev,
+                                                struct amdgpu_irq_src *sou=
rce,
+                                                struct amdgpu_iv_entry *en=
try)
+{
+       /* By design, the ih cookie for err_event_athub_irq should be writt=
en
+        * to bif ring. since bif ring is not enabled, just leave process c=
allback
+        * as a dummy one.
+        */
+       return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbif_v6_3_1_ras_err_event_athub_i=
rq_funcs =3D {
+       .set =3D nbif_v6_3_1_set_ras_err_event_athub_irq_state,
+       .process =3D nbif_v6_3_1_process_err_event_athub_irq,
+};
+
+static void
+nbif_v6_3_1_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_devic=
e *adev) {
+       uint32_t bif_doorbell_int_cntl;
+
+       bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOOR=
BELL_INT_CNTL);
+       if (REG_GET_FIELD(bif_doorbell_int_cntl,
+                         BIF_BX0_BIF_DOORBELL_INT_CNTL,
+                         RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+               /* driver has to clear the interrupt status when bif ring i=
s disabled */
+               bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cn=
tl,
+                                               BIF_BX0_BIF_DOORBELL_INT_CN=
TL,
+                                               RAS_ATHUB_ERR_EVENT_INTERRU=
PT_CLEAR, 1);
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif=
_doorbell_int_cntl);
+               amdgpu_ras_global_ras_isr(adev);
+       }
+}
+
+static int nbif_v6_3_1_init_ras_err_event_athub_interrupt(struct
+amdgpu_device *adev) {
+       int r;
+
+       /* init the irq funcs */
+       adev->nbio.ras_err_event_athub_irq.funcs =3D
+               &nbif_v6_3_1_ras_err_event_athub_irq_funcs;
+       adev->nbio.ras_err_event_athub_irq.num_types =3D 1;
+
+       /* register ras err event athub interrupt
+        * nbif v6_3_1 uses the same irq source as nbio v7_4
+        */
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+                             NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+                             &adev->nbio.ras_err_event_athub_irq);
+
+       return r;
+}
+
+struct amdgpu_nbio_ras nbif_v6_3_1_ras =3D {
+       .handle_ras_err_event_athub_intr_no_bifring =3D
+               nbif_v6_3_1_handle_ras_err_event_athub_intr_no_bifring,
+       .init_ras_err_event_athub_interrupt =3D
+               nbif_v6_3_1_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.h
index b7f2e0d88905d2..9ac4831d39e17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
@@ -29,5 +29,6 @@
 extern const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg;  extern =
const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs;  extern const struct amdg=
pu_nbio_funcs nbif_v6_3_1_sriov_funcs;
+extern struct amdgpu_nbio_ras nbif_v6_3_1_ras;

 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index eda03d40d76589..6b8e078ee7c751 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -444,8 +444,18 @@ static int soc24_common_late_init(struct amdgpu_ip_blo=
ck *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                xgpu_nv_mailbox_get_irq(adev);
+       } else {
+               if (adev->nbio.ras &&
+                   adev->nbio.ras_err_event_athub_irq.funcs)
+                       /* don't need to fail gpu late init
+                        * if enabling athub_err_event interrupt failed
+                        * nbif v6_3_1 only support fatal error hanlding
+                        * just enable the interrupt directly
+                        */
+                       amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0);
+       }

        /* Enable selfring doorbell aperture late because doorbell BAR
         * aperture will change if resize BAR successfully in gmc sw_init.
@@ -501,8 +511,13 @@ static int soc24_common_hw_fini(struct amdgpu_ip_block=
 *ip_block)
        adev->nbio.funcs->enable_doorbell_aperture(adev, false);
        adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                xgpu_nv_mailbox_put_irq(adev);
+       } else {
+               if (adev->nbio.ras &&
+                   adev->nbio.ras_err_event_athub_irq.funcs)
+                       amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0);
+       }

        return 0;
 }
--
2.25.1

