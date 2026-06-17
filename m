Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF277CD98ED
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 21:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B65610EB51;
	Wed, 17 Jun 2026 21:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di9ISQar";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF80810EB51
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 21:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UghtZWmJOF5n3onqrzrC+TBnqMfSyJYsePVC1s22ZrbmBuZQa8X1N9J5AqUDpCuad9zg8WbgyI/wvFMn7Jb8icfZnpFLbm2z2KDwjTeJIPBjk7MX80yNkmIuym+OdWgJprML6PhcX8QOUpSaZxMtXFnWEdICcbUER958VIC1pXebENCGz5bahIyU/VwNhdO0C8EeqCFJeVdCqyDBGP9dpVAIpJfKp4Z9hm6OE0ahs+EoiYJgkmmfwWUi6GSJEdvUYJnGtrXW3+oZ8vIsmHQFucGJqyue2VEkUDPcsU7fGH7EBPKl+7aoKEvOKjTekk/1ylWhgyJyYx60BuS6CxJ5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcMp0JFtsglmk5O8zYWgv/TB0P9gXoemWJOSHKwP01o=;
 b=YYzNX/1TuH2hb7tei1Xpkt3Yr83kBksoG+9bA5djOyZ5NjQyIt06bl8C4FC7QiE+bp6o5g2pCozh88v9j7BUzSdVssVJvmGBeXcOWlPPD6j3DK9nfUdN9tt0DW8qxUc7m3DfvihzGZidR9pIen+ehoh7/mM80yJWuEA3oFSdwWVRoEHodQc1440kEIGAKPlodNm3APXuQZi8ZWGIwq0MdoL8QUGLM0VTkt0UVhYCzIonx1ooPyne3Q3q1PuPR2oJZMJGcI/ZInBV98gG33ipr0So8RafzIaRwwED0hKzKW+CFeOpaqqL9foGKL4k3h8xWctoBSD4zkTkoPPeCiNR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcMp0JFtsglmk5O8zYWgv/TB0P9gXoemWJOSHKwP01o=;
 b=Di9ISQarFv41eGgB5sEAE9aBwCLQkkO3UumlS96IdBks8sudXPM3abgDgvGfsIxESh4o4Y3M1s6TChyAo50Px5nL+PDDzm5/1aZkRJKXgAST5/yiOC+5JCcHxZssSphx3NeiXBi/JDqv9ab46zHK5JI6g9W0xdZcyMptEKk2CKI=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 21:02:27 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 21:02:26 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Topic: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Index: AQHc/pvT5ClGBwC5gkq0xEhfw51mGA==
Date: Wed, 17 Jun 2026 21:02:26 +0000
Message-ID: <SA1PR12MB8600B7A9323EB2698E2C20A49FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T21:02:26.186Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|PH7PR12MB7164:EE_
x-ms-office365-filtering-correlation-id: 19720325-1f9c-4578-b837-08deccb3bc6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|38070700021|18002099003;
x-microsoft-antispam-message-info: T5Pg5f3CAwYl8tC8e4d+hKyThd8PAICSs3dRkOpNLjzz6aKon+vF7bsLmdqUkcZLuiGoBCzHnjKLrmLsBQUEnNxoaW5inY9t11gggXCFdUjyT46LR1yKtT9YQBBpRG0jgn9IVpyJaB7PaY/vhRYkm+9fb9jhbs7bT7dpuS636KE4aP2vl6vKtzjqOwEnVobdGLCqvOmiYe0e1q0wKzdiHBdiC0Qk/Y5MCq08QlKyWHl2n3CiMB1/GjEVA6kncpQwcMey/b5Z5MZ/j/Ud8wr5vGaIeepl+BMLmqgGAHeuxE7mIBn3AVlnhuBMsIIE/9/yVMcSkGiSryG61r+CJQxPisvIGW0FEb3UzUzeGEQ7sIvsJUuhjyUQjk1fuDjGtyBzDCer9RpAyPsNy6QmpELv7hvdc/h42yPg8Ts5SC41IR3gv5pTdnc+jtppzlk1Fzk3SlJvcFxAtPeYl4KbbWMy7j6tjUa1I1ptTTZgI2igvvHJlIOVDg8HD8e5zAhahg2zC5bLnT5StTZPD3kpuo9nLQIaEJ+uCe0mhJ+Yn/Tpgpb7aczL3JHly8OCgRzKcjX1p+HKqjZYKJwSqYGieCP9WHhrqsFUih1xBLRm2gWJLSljAZhCgLublEDeiQEKqMg9dftPTz4GAWEZXfHSJHRup2+XbYbpIkpHJsRKdR9bWFaLUpQoFxyt2GN6C1oCPLBPTkHmXDPHvOa7duXg9Najq17u9kVtquQ/4//RaGlDhaWwS/EZOG8f/MABp8uuNI27
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NI2mQZsUMGvaWGh2a592mNhSVb56nLrzjA7ISFs4G618ZPtZqgKKkCc1+M?=
 =?iso-8859-1?Q?znWhHPQb0SMl8B0QgrbqtunCYLsT+s6fGjOjjCZyD7UGeB5tL+2Ca0rMg5?=
 =?iso-8859-1?Q?8KkkkFquZ2p/oIbYR4Kjz/sOHGdsdDwQ3f7b/bX9qa1ErNycnJVvMNCZvD?=
 =?iso-8859-1?Q?lfgISigvkcKBRJ9RBM7fDUvkw5WwzQ6LNHLG6EiOYRF5kM7d8e4hBX2CAG?=
 =?iso-8859-1?Q?Ix6i3cD5uMnyTaB6RPp2fKrRMZ0UV6QTEbBZZqzkVC9jQP08qn0q4Wpc66?=
 =?iso-8859-1?Q?vdoE3k8f95jMgvn87jLigqHqnj/sryR9Mta5GETuc7MvOnnVZrpe5qtGaQ?=
 =?iso-8859-1?Q?23RWoFOVGgeQ5uAWRV5Odb78gEE09g5XqAU7QcggZG36uQ1L0QUHQ3Ifp7?=
 =?iso-8859-1?Q?uls2unkc6uUfVK/DG/044ZUPULpODiwu337QjqzP/mxH+l2dG5iiiLb7GS?=
 =?iso-8859-1?Q?ujoo7HTcElISKT2Ba/u6NIgSEyKts5RE38F9SsYRn7HoHrBGyzd+mZb1jG?=
 =?iso-8859-1?Q?ribZrPAiekYM+prN3am/BIlor2k5RhnHuizZtwgOAQGfnoUXBpuCkDj8au?=
 =?iso-8859-1?Q?RUWcQCQFfh/z9kwxTBVsW/wxiPfATiBRILuuTkWlsG0rP3+ndm8tmfNd/P?=
 =?iso-8859-1?Q?Geo+Di1FcuvBfT9ifhIbz4L3FN8s9VczLn3Sw+k6yXzKkOAYMkYfopPzN/?=
 =?iso-8859-1?Q?XLSrLlhTkFUeRQhIwu6xUhbi/fcHXupASxMgbIm8/eBiv2R1wv8CVcMN0F?=
 =?iso-8859-1?Q?NCdjsM26GmTnbnfpd5a34DSe2VccqZ/vGb/SFMOE2J25Xcdw3Q7FbndkPi?=
 =?iso-8859-1?Q?B4foyx7fHtkc53ZjZmUasnEZhSQDYv5Bb5veKQE5xIvLcvWzbbtI5sSWxT?=
 =?iso-8859-1?Q?SYWckY0Tdq5aohLg+mNzKqH72hFsd2hZ0hldDIacSAvoR/nU64dzKbPD+N?=
 =?iso-8859-1?Q?vXgPgJ0kFfbenLkCyUoiyctB9AneZV/ops0S1IhMtl8gc9owMcF+f5+WC/?=
 =?iso-8859-1?Q?A44Ql+RcRf4w2bN3chwrjx8NO+nFX61VI9f8OeRyyrqNRqfVjGBEJubDFC?=
 =?iso-8859-1?Q?OvHgveHqfzQzK9dbnAtTMbdyxTA6pdpLXhUs9zs8fTA5QX903DlGhQBqJ+?=
 =?iso-8859-1?Q?/jZ1pMltuwZNHGDnE+09Cyk6/h212doroJ+lcsqSuPlGP5fyYbnm0rkuHk?=
 =?iso-8859-1?Q?50Lvo62xm+BZdhkL3OmMApgkxKXaQXGtaz89NmHMYdXvtHve8Mf58z2fYO?=
 =?iso-8859-1?Q?vj6joUosM8+T2fqa0C4dsnYk39MR03aYLDrwxsaj7egPfuD3DT6Uduk4Fx?=
 =?iso-8859-1?Q?a5UwXAlrFOApXxF6+WwfRPKmw8cWau2Vy8LOXh2FxG930qvhR/keymWvRp?=
 =?iso-8859-1?Q?6bvVObsclpCjCD9d4oAbT78y4ePoG1zt5QJ9YtCeGPWHm9rcQClKKkUZv+?=
 =?iso-8859-1?Q?mzWpZxr0X55zsuG6J2zbfpyH5jPm+1AbNST11KJJO6aiig8gJ/z/u+UybC?=
 =?iso-8859-1?Q?Cfnb72TrmYlKm7EF7/2QrpZm4p4fzbnxvdJAfsU3Vy+mkKJ/4dW7LOyVed?=
 =?iso-8859-1?Q?gFa6ui4LhdZOglxCxxQCL1JYyq5Hq6qkEATECRkC8xgLN6rti1ExszCY0y?=
 =?iso-8859-1?Q?4w4cfgPKKVPS34V4XSc0GofO71P6kv6ZRLsEZ6hUcVgqgNE7hReMxR/bEJ?=
 =?iso-8859-1?Q?TcIttWfCVjUKF8CZ7l0pJzhNSP0gdQzy4h96HJOJIMZBB0OpbPnyMlm5tn?=
 =?iso-8859-1?Q?IDdWAPI850X7joU+sF7A2QxwrhDIYPGTh32FgmJ6QHayAH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19720325-1f9c-4578-b837-08deccb3bc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 21:02:26.5278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /R1ej+RUl7r1mKYokJqGMV6IfoF5zuy+72RopNBZEUase3S5JJ3F+fyR5AE59UYoQTf8zV9ksENIMcKKM0KSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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

When MES is enabled and amdgpu_amdkfd_alloc_kernel_mem() fails during=0A=
the first queue creation for a process, pqm_create_queue() returns=0A=
early via 'return retval' without going through the err_create_queue=0A=
cleanup label.=0A=
=0A=
This means clear_bit(*qid, pqm->queue_slot_bitmap) is never called,=0A=
leaving the reserved QID bit permanently set in queue_slot_bitmap.=0A=
Over time this leaks QID slots, potentially exhausting all available=0A=
queue slots.=0A=
=0A=
Fix this by replacing 'return retval' with 'goto err_create_queue'=0A=
so that clear_bit() is always called on the error path.=0A=
=0A=
Fixes: AILIKFD-813=0A=
Reported-by: Deucher, Alexander <alexander.deucher@amd.com>=0A=
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>=0A=
=0A=
Changes in v2:=0A=
- Fixed author name format to First Last order (suggested by A. Deucher)=0A=
- Removed incorrect attachments from mailing list submission=0A=
=0A=
---=0A=
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
index 1234567..abcdefg 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
@@ -378,7 +378,7 @@=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 false);=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retval) {=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev->adev->dev, "fa=
iled to allocate process context bo\n");=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_create_queue;=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES=
_PROC_CTX_SIZE);=0A=
 =A0 =A0 =A0 =A0}=0A=
--=0A=
2.34.1=0A=
