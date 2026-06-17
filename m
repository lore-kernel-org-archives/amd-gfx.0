Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC0CD98F0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 20:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837A510F0EF;
	Wed, 17 Jun 2026 20:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N55rMvnK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789FC10EB41
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 20:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKoEmIIUw21wEPpwkRVhuB52vdx0ryrNxKEduhrkjAJrEEqNF4M6voxuAPHo4y2qqP6kSq+hhORtSsKmEmJn7dTm1FaFFpiFWTKqrMsMXsFRf9qzlqnX/IDs0fsxQNeGgEzCNfhBkff1n5rMqSWBKED0Tu/2i++nx7KLDJS4zAFhuYOAQSl4hJZhX2B/haBclv1WDUeIJ+/Hq+crevpou51gPWQzNyFkhTMBeLYIc9bP6BkSaYepXh6sQx04zs0yidgWv6pS7e4wlBK15H6fnSxF+JlV5FJQDc2XnwhM01wcP5Bp1mkfeb27ALBEp6pYcTqVMkaVcXtnGc5dIDdmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD7tDKq7qBQPZ5jaPiFKISrfkcS8pgMtiYoICkFG3nE=;
 b=gk0603R1VnicDeZjw2Gl875qpcDEGXlm0b8NcSnjSqoDlIOZCKEU/l042Xyn4jo/jwdaqo8hgOl6t78H7QkHlI6zTo17URAk3FDxTrnvmdhK1ulcMtMgSpMGKGgVLljfhe9dYsYVoO29nZMkLLx0cnacyXnLsGDUbDrDMRbWttjYmB9XSVWtCSVEEEgj7cvYhlqyUPOFphQotXO676ZuK0zxlHiEww5sYoU5Fp+pXIQlEmdvSlLUQQ4Le3Z1EQFG3/1HVulhGXqbehegKX8K8X3OCC9PWawKMrH1pGMgV6aY87eJ3XRNccVzMpYjtTtz1AFbooHqqDbmwVY4NU73Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD7tDKq7qBQPZ5jaPiFKISrfkcS8pgMtiYoICkFG3nE=;
 b=N55rMvnKqfdiyB7V2S+agsjHwI3JeTkMb4uKIWlzzRYTFrYza3Cgcm8oVziM80ojgEjXe5uU9kLAMJf8KtUgd4wvWS7JfV8Pz8IC0IMlg+ZYsSz7mKR/WgEUnu6jfQ/iGyt3dySB4eLXQDbcZGtj+CGD56dXN0sn35YVjWERXAM=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 20:13:21 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 20:13:21 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Topic: [PATCH] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Index: AQHc/pMGj2pf1s74S0ubmq5yLTbxiA==
Date: Wed, 17 Jun 2026 20:13:21 +0000
Message-ID: <SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T20:13:21.094Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|CH3PR12MB9024:EE_
x-ms-office365-filtering-correlation-id: c1f6f940-c41d-49d1-5ad9-08deccace100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|6049299003|1800799024|366016|23010399003|38070700021|4053099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: QhCz36+wyGoqKcWtyZqgAgDTHbx2hofMWzQnlF2fDE/jMSpd9yrPgeSWsTt5z+A+EiSECnfvvMqfT6vpIertw3sUCUFdru6M/3S0cJHjk6iUB793ttow6b6TZxMzK4fBPpWZIBSigvd/RgcRhIwzabdPGXC4S4tXYDrQdrXK2iA57ose5Irb8bG2VHv/NLHyRI6cU2tavTF4ZaFFwXo4pHnA3N8nWLFL808nOVlUNz0BC0T5s2X8t+pOFBusrbFQyfG2/Pp3gr+fT9rVvTs0dAnkDuDpCpfPXWMx6IH+PCWrwQnpRV4bEmMagdoTabrmuZMygQK34p0tS0lCW7r3q4Vd3bR4rcq4LdSv9YpQCVvqdvQXZtcL6P2pEL8dgLeW8Ei5PBcwPX9lMUI0ZhrSAqMuYdkMGeXiTEh6+YRndcnh+3Is9BC0ALGw40wlWPs3mpGt5tVxn0lOUHpBLcsEXvA4yCl4tX0QlRT/sR1vH8gWn8UMYm/ppM8iMUdapn2UlQBL4Zm9P8bycMuVdnyEzPpPu3pNzxohW7Lka4w7a8s5r7/Xo37B9LWKU9YXs9S9aHLHkr1L7axd/R2dUEbN5oV1f4pUo6zHrBUnAzuc3G+TZN2MkD6VSzWnL7xl1inIIxdJ/EwABbGlUTqL54rwFSkrc6xU8tAgflYHck3Jxz69qlYULRblQKUya0h3z/Cc7gWo7qHgyLQg5Z0iUegsa9UaqvYJk1FZbQXRBrVpo4kP/BwxKc4fXk/hQWUf4SVp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(6049299003)(1800799024)(366016)(23010399003)(38070700021)(4053099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ikRBSuTdUd7fzyNQt0Gz9PSODUGc76a+Y0LeDkPfJyfw4dFZKmCAdzajZ+?=
 =?iso-8859-1?Q?fthMSFu7cpUtuiY47TyXmjoU6Ig+AYYVkxMIypcISIL/YP4LRU0dbX7xZr?=
 =?iso-8859-1?Q?1f8VxkUTvNHIcXnsWfTfGS3gva1Eki/zvL7u1oiea6pUddjEQI54L/rYt3?=
 =?iso-8859-1?Q?KV5105eov2DqGi7sm//Djux1T2fxjTp343e+a7l71GGK//OtSrXDn8yIH8?=
 =?iso-8859-1?Q?kb36RGOA5isJPHpOCmTkwsbMm4O8mgQ5qCA5peM/nKkBPKcHo1wzZO0kyR?=
 =?iso-8859-1?Q?0oZKchKvTwJnacg3g7lRtHoqvRIATOZdhVWRMRQQ54ArKjpf5nteZvHYHM?=
 =?iso-8859-1?Q?E7bHC+b0UxHXqryHK05DKQCIGKcSZfJPDR2YmdfY3u2jE7oqnGbYiMK39l?=
 =?iso-8859-1?Q?TOwrWuxikGLqvYwx7wjXqhqyq7kT96oUm6AuDp0DjOWHn+B4oh1evY25SF?=
 =?iso-8859-1?Q?UAZ4A/4kUlkarLp/hb5j8SeHXF2sBsxcmnGm2Rwmtp/ydXU06hP2B/2Io8?=
 =?iso-8859-1?Q?jkiiJbXXmLmYEZoXxcWv374kp85R7SiQ23lXgyrI5XPSqgkz272Z8FZC7A?=
 =?iso-8859-1?Q?fnF5GtX/qhlVKhw7GygighJAsKiheQn3NEzYeex7m9HWlj0pQSd7qY3hTQ?=
 =?iso-8859-1?Q?Hwv5fGWtwsSObCekg0oWslxYCzmd7L1pPeJdmRdyojkIit4lINEXcnRVkd?=
 =?iso-8859-1?Q?lK8fri5ApReOEr5iRxv5JsDpItwaifShuIhi/RU8kvzPmUPbN8VQiW0R3e?=
 =?iso-8859-1?Q?xOEZsROTZT24b2QBqXLE/rlK7ycRXtkDGOnCf8/QsUW9MyDlnpCAGQIqJ8?=
 =?iso-8859-1?Q?xE1PhS7RutDrcya84gjGv3eIZU+796NUfCoI42jVCNwbq9uEKUP41VEq/k?=
 =?iso-8859-1?Q?mMXzpkXwvV4n25LZ0TDXhsP3jAtggaDg5m1uZYWaC+MwVSYHYeUflohHLe?=
 =?iso-8859-1?Q?4zskFSLVJS7Px6eY6uJDjzBvHOrCW4hCzAA9S1lK2/dXvooHzCUGAUa1PF?=
 =?iso-8859-1?Q?mXG6I80XutT4GW7HPz5sm5LJF6diQRxsaP/OL0nNlrbPwfkWrOWxAe8mN0?=
 =?iso-8859-1?Q?8MLq8MGwvQDQG+dinNbRl2oIGnSIo69Z/sd2pZbgNB25bsavYCJaQd4Z0M?=
 =?iso-8859-1?Q?euBPGVqbcXzjwElYP6QfIGaYUcv/CBAUKXBMY1MXJqIRCG0LnYQwB+vbzk?=
 =?iso-8859-1?Q?LOFgGkk9XF3FY5t+Ov6odaXMSMPGUnwOA7UVESSTMbUoCskbONokhPYsZU?=
 =?iso-8859-1?Q?gcFkDgLijvzAjRzIaeaT1D9usbGkSKuBQeBLDeUAQWQQw6CAHxgQ3+RZxq?=
 =?iso-8859-1?Q?m63XBudQbVSA2jdlLB0pmQHYXZS7s40D5hvdTwERJspHgv1L2YJ5m+HMZQ?=
 =?iso-8859-1?Q?iktZQb9gHJxInYl9S1VURY+9kw4yyOH4U1PDg/2HSOr55eJeou5XRfkWBE?=
 =?iso-8859-1?Q?IvYONAvv0X/SnGTWLV+2RacAFpa3He7clBguk45ZxZRVjKV+UNAvff72Qy?=
 =?iso-8859-1?Q?2z3cBP46h1+hXFXJlTitT4t+lwN62qz7mTLzvyjMiYpsgcAjMkmwLP3JQj?=
 =?iso-8859-1?Q?B2l9EQsGwiQzaHqHbI/hkhDqpttbKtacpG2jxw8TmcaugQ3MzjFPJ+kbdQ?=
 =?iso-8859-1?Q?dE7uNV2MPHElntO0qm9cqTRzbP6QrAaUx6WtECRROF4tIdC2/r8FwPSDdz?=
 =?iso-8859-1?Q?DG7vVkJl7mdTqivBQ7s1jKrn8IT2GIootiOoNIsIQ4AVuflHuYBn9Gf7bv?=
 =?iso-8859-1?Q?Oi3Zqti17MoiQ9SWI7+1AY5PR4Lc5YtiLKuXFADYORY/s1?=
Content-Type: multipart/mixed;
 boundary="_003_SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f6f940-c41d-49d1-5ad9-08deccace100
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 20:13:21.4244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t54PIv0KeEXWuSdeZlYR8q0sKpq/O8rOiWrbn8ks43/z1I3dfDFbpsBFhrUHYtwfGQfEB/aU4a4zMxkCxev85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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

--_003_SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42SA1PR12MB8600namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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
Signed-off-by: Marioukhine, Vladimir <vladimir.marioukhine@amd.com>=0A=
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
                                                     false);=0A=
                if (retval) {=0A=
                        dev_err(dev->adev->dev, "failed to allocate process=
 context bo\n");=0A=
-                       return retval;=0A=
+                       goto err_create_queue;=0A=
                }=0A=
                memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);=
=0A=
        }=0A=
--=0A=
2.34.1=

--_003_SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42SA1PR12MB8600namp_
Content-Type: text/x-patch;
	name="0001-drm-amdkfd-fix-qid-bit-leak-in-pqm_create_queue.patch"
Content-Description:  0001-drm-amdkfd-fix-qid-bit-leak-in-pqm_create_queue.patch
Content-Disposition: attachment;
	filename="0001-drm-amdkfd-fix-qid-bit-leak-in-pqm_create_queue.patch";
	size=1527; creation-date="Wed, 17 Jun 2026 19:53:54 GMT";
	modification-date="Wed, 17 Jun 2026 19:56:05 GMT"
Content-Transfer-Encoding: base64

RnJvbTogTWFyaW91a2hpbmUsIFZsYWRpbWlyIDx2bGFkaW1pci5tYXJpb3VraGluZUBhbWQuY29t
PgpEYXRlOiBXZWQsIDIwIE1heSAyMDI2IDIxOjMxOjQ5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZGtmZDogZml4IFFJRCBiaXQgbGVhayBpbiBwcW1fY3JlYXRlX3F1ZXVlKCkKCldoZW4g
TUVTIGlzIGVuYWJsZWQgYW5kIGFtZGdwdV9hbWRrZmRfYWxsb2Nfa2VybmVsX21lbSgpIGZhaWxz
IGR1cmluZwp0aGUgZmlyc3QgcXVldWUgY3JlYXRpb24gZm9yIGEgcHJvY2VzcywgcHFtX2NyZWF0
ZV9xdWV1ZSgpIHJldHVybnMKZWFybHkgdmlhICdyZXR1cm4gcmV0dmFsJyB3aXRob3V0IGdvaW5n
IHRocm91Z2ggdGhlIGVycl9jcmVhdGVfcXVldWUKY2xlYW51cCBsYWJlbC4KClRoaXMgbWVhbnMg
Y2xlYXJfYml0KCpxaWQsIHBxbS0+cXVldWVfc2xvdF9iaXRtYXApIGlzIG5ldmVyIGNhbGxlZCwK
bGVhdmluZyB0aGUgcmVzZXJ2ZWQgUUlEIGJpdCBwZXJtYW5lbnRseSBzZXQgaW4gcXVldWVfc2xv
dF9iaXRtYXAuCk92ZXIgdGltZSB0aGlzIGxlYWtzIFFJRCBzbG90cywgcG90ZW50aWFsbHkgZXho
YXVzdGluZyBhbGwgYXZhaWxhYmxlCnF1ZXVlIHNsb3RzLgoKRml4IHRoaXMgYnkgcmVwbGFjaW5n
ICdyZXR1cm4gcmV0dmFsJyB3aXRoICdnb3RvIGVycl9jcmVhdGVfcXVldWUnCnNvIHRoYXQgY2xl
YXJfYml0KCkgaXMgYWx3YXlzIGNhbGxlZCBvbiB0aGUgZXJyb3IgcGF0aC4KCkZpeGVzOiBBSUxJ
S0ZELTgxMwpSZXBvcnRlZC1ieTogRGV1Y2hlciwgQWxleGFuZGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJpb3VraGluZSwgVmxhZGltaXIgPHZsYWRpbWly
Lm1hcmlvdWtoaW5lQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCmluZGV4IDEyMzQ1NjcuLmFiY2RlZmcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVl
X21hbmFnZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19x
dWV1ZV9tYW5hZ2VyLmMKQEAgLTM3OCw3ICszNzgsNyBAQAogCQkJCQkJICAgICBmYWxzZSk7CiAJ
CWlmIChyZXR2YWwpIHsKIAkJCWRldl9lcnIoZGV2LT5hZGV2LT5kZXYsICJmYWlsZWQgdG8gYWxs
b2NhdGUgcHJvY2VzcyBjb250ZXh0IGJvXG4iKTsKLQkJCXJldHVybiByZXR2YWw7CisJCQlnb3Rv
IGVycl9jcmVhdGVfcXVldWU7CiAJCX0KIAkJbWVtc2V0KHBkZC0+cHJvY19jdHhfY3B1X3B0ciwg
MCwgQU1ER1BVX01FU19QUk9DX0NUWF9TSVpFKTsKIAl9Ci0tIAoyLjM0LjEK

--_003_SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42SA1PR12MB8600namp_
Content-Type: text/plain; name="ailikfd813_test_results.txt"
Content-Description: ailikfd813_test_results.txt
Content-Disposition: attachment; filename="ailikfd813_test_results.txt";
	size=3457; creation-date="Wed, 17 Jun 2026 19:53:54 GMT";
	modification-date="Wed, 17 Jun 2026 19:56:05 GMT"
Content-Transfer-Encoding: base64

PT09IEFJTElLRkQtODEzIFBhdGNoIFRlc3QgUmVzdWx0cyA9PT0KRGF0ZTogVGh1IE1heSAyMSAw
MjoyOTo0NCBQTSBFRFQgMjAyNgpLZXJuZWw6IDYuMTcuMApHUFU6IDAzOjAwLjAgVkdBIGNvbXBh
dGlibGUgY29udHJvbGxlcjogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0g
TmF2aSAzMSBbUmFkZW9uIFJYIDc5MDAgWFQvNzkwMCBYVFgvNzkwME1dIChyZXYgY2UpCgo9PT0g
QkFTRUxJTkUgKHVucGF0Y2hlZCkgPT09ClsgICAgICAgT0sgXSBLRkRRTVRlc3QuQ3JlYXRlRGVz
dHJveUNwUXVldWUgKDM0IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LlN1Ym1pdE5vcENwUXVl
dWUgKDE4IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LlN1Ym1pdFBhY2tldENwUXVldWUgKDE3
IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkFsbENwUXVldWVzICg4MiBtcykKWyAgICAgICBP
SyBdIEtGRFFNVGVzdC5DcmVhdGVEZXN0cm95U2RtYVF1ZXVlICg5IG1zKQpbICAgICAgIE9LIF0g
S0ZEUU1UZXN0LlN1Ym1pdE5vcFNkbWFRdWV1ZSAoMTAgbXMpClsgICAgICAgT0sgXSBLRkRRTVRl
c3QuU3VibWl0UGFja2V0U2RtYVF1ZXVlICgxMCBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5B
bGxTZG1hUXVldWVzICgzNSBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5BbGxYZ21pU2RtYVF1
ZXVlcyAoNyBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5BbGxRdWV1ZXMgKDEwOCBtcykKWyAg
ICAgICBPSyBdIEtGRFFNVGVzdC5TZG1hQ29uY3VycmVudENvcGllcyAoNTcxMiBtcykKWyAgICAg
ICBPSyBdIEtGRFFNVGVzdC5EaXNhYmxlQ3BRdWV1ZUJ5VXBkYXRlV2l0aE51bGxBZGRyZXNzICgy
MDMwIG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkRpc2FibGVTZG1hUXVldWVCeVVwZGF0ZVdp
dGhOdWxsQWRkcmVzcyAoMjAyNiBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5EaXNhYmxlQ3BR
dWV1ZUJ5VXBkYXRlV2l0aFplcm9QZXJjZW50YWdlICgyMDQ1IG1zKQpbICAgICAgIE9LIF0gS0ZE
UU1UZXN0LkNyZWF0ZVF1ZXVlU3RyZXNzU2luZ2xlVGhyZWFkZWQgKDE1MDIwIG1zKQpbICAgICAg
IE9LIF0gS0ZEUU1UZXN0Lk92ZXJTdWJzY3JpYmVDcFF1ZXVlcyAoNTg5NyBtcykKWyAgRkFJTEVE
ICBdIEtGRFFNVGVzdC5CYXNpY0N1TWFza2luZ0xpbmVhciAoNzc4MCBtcykKWyAgRkFJTEVEICBd
IEtGRFFNVGVzdC5CYXNpY0N1TWFza2luZ0V2ZW4gKDMxMDAgbXMpClsgICAgICAgT0sgXSBLRkRR
TVRlc3QuUXVldWVQcmlvcml0eU9uRGlmZmVyZW50UGlwZSAoMTA3IG1zKQpbICAgICAgIE9LIF0g
S0ZEUU1UZXN0LlF1ZXVlUHJpb3JpdHlPblNhbWVQaXBlICgyMDkgbXMpClsgICAgICAgT0sgXSBL
RkRRTVRlc3QuRW1wdHlEaXNwYXRjaCAoMTkgbXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuU2lt
cGxlV3JpdGVEaXNwYXRjaCAoMTkgbXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuTXVsdGlwbGVD
cFF1ZXVlc1N0cmVzc0Rpc3BhdGNoICgxNTE2MiBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5D
cHVXcml0ZUNvaGVyZW5jZSAoMTkgbXMpClsgIEZBSUxFRCAgXSBLRkRRTVRlc3QuQ3JlYXRlQXFs
Q3BRdWV1ZSAoMTUgbXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuUXVldWVMYXRlbmN5ICgyNSBt
cykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5DcFF1ZXVlV3JhcGFyb3VuZCAoMjYgbXMpClsgICAg
ICAgT0sgXSBLRkRRTVRlc3QuU2RtYVF1ZXVlV3JhcGFyb3VuZCAoNDcxIG1zKQpbICAgICAgIE9L
IF0gS0ZEUU1UZXN0LkF0b21pY3MgKDM3IG1zKQoKPT09IFBBVENIRUQgPT09ClsgICAgICAgT0sg
XSBLRkRRTVRlc3QuQ3JlYXRlRGVzdHJveUNwUXVldWUgKDMzIG1zKQpbICAgICAgIE9LIF0gS0ZE
UU1UZXN0LlN1Ym1pdE5vcENwUXVldWUgKDIyIG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LlN1
Ym1pdFBhY2tldENwUXVldWUgKDE2IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkFsbENwUXVl
dWVzICg3OCBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5DcmVhdGVEZXN0cm95U2RtYVF1ZXVl
ICg5IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LlN1Ym1pdE5vcFNkbWFRdWV1ZSAoMTAgbXMp
ClsgICAgICAgT0sgXSBLRkRRTVRlc3QuU3VibWl0UGFja2V0U2RtYVF1ZXVlICgxMCBtcykKWyAg
ICAgICBPSyBdIEtGRFFNVGVzdC5BbGxTZG1hUXVldWVzICgzNSBtcykKWyAgICAgICBPSyBdIEtG
RFFNVGVzdC5BbGxYZ21pU2RtYVF1ZXVlcyAoNiBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5B
bGxRdWV1ZXMgKDEyNyBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5TZG1hQ29uY3VycmVudENv
cGllcyAoNTY0NiBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5EaXNhYmxlQ3BRdWV1ZUJ5VXBk
YXRlV2l0aE51bGxBZGRyZXNzICgyMDIxIG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkRpc2Fi
bGVTZG1hUXVldWVCeVVwZGF0ZVdpdGhOdWxsQWRkcmVzcyAoMjAxNCBtcykKWyAgICAgICBPSyBd
IEtGRFFNVGVzdC5EaXNhYmxlQ3BRdWV1ZUJ5VXBkYXRlV2l0aFplcm9QZXJjZW50YWdlICgyMDI2
IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkNyZWF0ZVF1ZXVlU3RyZXNzU2luZ2xlVGhyZWFk
ZWQgKDE1MDE3IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0Lk92ZXJTdWJzY3JpYmVDcFF1ZXVl
cyAoNTgzMSBtcykKWyAgRkFJTEVEICBdIEtGRFFNVGVzdC5CYXNpY0N1TWFza2luZ0xpbmVhciAo
ODQwNSBtcykKWyAgRkFJTEVEICBdIEtGRFFNVGVzdC5CYXNpY0N1TWFza2luZ0V2ZW4gKDMxOTcg
bXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuUXVldWVQcmlvcml0eU9uRGlmZmVyZW50UGlwZSAo
MTA3IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LlF1ZXVlUHJpb3JpdHlPblNhbWVQaXBlICgy
MTMgbXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuRW1wdHlEaXNwYXRjaCAoMTggbXMpClsgICAg
ICAgT0sgXSBLRkRRTVRlc3QuU2ltcGxlV3JpdGVEaXNwYXRjaCAoMjggbXMpClsgICAgICAgT0sg
XSBLRkRRTVRlc3QuTXVsdGlwbGVDcFF1ZXVlc1N0cmVzc0Rpc3BhdGNoICgxNTEzNSBtcykKWyAg
ICAgICBPSyBdIEtGRFFNVGVzdC5DcHVXcml0ZUNvaGVyZW5jZSAoMjAgbXMpClsgIEZBSUxFRCAg
XSBLRkRRTVRlc3QuQ3JlYXRlQXFsQ3BRdWV1ZSAoMTQgbXMpClsgICAgICAgT0sgXSBLRkRRTVRl
c3QuUXVldWVMYXRlbmN5ICgyMyBtcykKWyAgICAgICBPSyBdIEtGRFFNVGVzdC5DcFF1ZXVlV3Jh
cGFyb3VuZCAoMjMgbXMpClsgICAgICAgT0sgXSBLRkRRTVRlc3QuU2RtYVF1ZXVlV3JhcGFyb3Vu
ZCAoNDc0IG1zKQpbICAgICAgIE9LIF0gS0ZEUU1UZXN0LkF0b21pY3MgKDUxIG1zKQoKPT09IFNV
TU1BUlkgPT09CkJhc2VsaW5lICAtIFBBU1NFRDogMjYgRkFJTEVEOiAzClBhdGNoZWQgICAtIFBB
U1NFRDogMjYgRkFJTEVEOiAzClJlZ3Jlc3Npb25zOiBOT05FCg==

--_003_SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42SA1PR12MB8600namp_--
