Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1345AC0219B
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 03:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7655610E2B5;
	Sat,  8 Feb 2025 03:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOxQuJke";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BB410E2B5
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeNysxPz5rNAirXm2z7hXabuWC7CT88EGlXBfsb+PE39h0OueXsF4Boez2nzyqzG5Z5Xr7uuX94oiE6hkli2cHl/lwewhgMxvDhuQikrkUuS+mlXHUnegrxL6YtDvyrX70m4zrUeVbOaPNVPZ208P495AguzxbIXKzxRQzTQkd0Axm7IOASSxvWqIRODttwnD+nKn1fBVw2X0hl6eXCw405bPxCfL3Xyy1sx9TDV4zIW0nhXEL9Qasb8yHDqiPdwz0DJPUNg0OS3NMk9jIqxfPN/fIRqqUAQuGLLegC4zD3hjkDGkT10M54wipqNRjGtU+kVg9NSUNkgxmCC6BYJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UReq1xR6EQXyByCCOmlWcYaPD0ilBsIzIil+ONdNx5A=;
 b=AvRr/Zs8u1eRHykw0CWxn0/emRPZSWq4iKjcerLeauWNksjoDDZ7J5qCjGnyOx7c3n9OGLfycY/EAWzaHSTdr/zE6BROIlpxWAVFNl5atQqYW6LYDSvHGNw2UJ5ZZ2L+sLJKsrb6ASQpUU31+UqCr/87p6MzOqt+kPg2WGvsGt8lZXL969vpHE78+taLVZv5eCnk6Z0Tbv32r9wKOBxHP108VE0Kl7e7DSYrQvaApogmKrp72ojhANBKHQyaRmT06geoECCDRnjVEeKrSoPx+xBswRV8p3aRyBcJylBXQ3l0M+hCNbihVFtKkjVM4qeWY3tCxBTjXhzgZrWohUMLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UReq1xR6EQXyByCCOmlWcYaPD0ilBsIzIil+ONdNx5A=;
 b=XOxQuJkekBQgNYlnobTRG3uuLpQ3xJ/DGqvncb4PQ4geLvz4TAl+Jar0BalbzT4yx3O7NCVqWsYbA4ucXinznF+yprdxy9TfSr+7cIsGhTTQndwS/qWW6KWexf6Y7C2VTKNIMZ+07TxKWH8EWQUaNSAx11Xcci4rZKx8KeEDohc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 03:02:31 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 03:02:31 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Thread-Topic: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Thread-Index: AQHbeUsLw+x9TIpBREG7nHPj+Rk5d7M8uSQg
Date: Sat, 8 Feb 2025 03:02:31 +0000
Message-ID: <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250207102823.1565467-1-Emily.Deng@amd.com>
In-Reply-To: <20250207102823.1565467-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ce1de60-fd72-45d7-bc0b-f62e06fb7667;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-08T03:02:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|CY8PR12MB7657:EE_
x-ms-office365-filtering-correlation-id: 4d53e582-8932-4dd9-ea55-08dd47ed074d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ofQ32TSF+g4rAzeQ8zoTQPYaSOtUYil2D7G70yuD241P+uLK8dWUVjUYBYQZ?=
 =?us-ascii?Q?QgE0LMEL7ZQ98gexV+r4WezW1bx4xZb0hhL4fqeqIK6HaaJnCY1LW8C76yBj?=
 =?us-ascii?Q?OKztW8syRBvgr5SNt8sU1Z6J3pqYjzomCGv8pm9wb33CNBP3Dwd8Kv9jz8qf?=
 =?us-ascii?Q?/d6RwVh+CDjOLp5Djkttlf9hC7hkGNlpAhl/dhlZXZpR4rZkzvv4dv//cCuC?=
 =?us-ascii?Q?1fxoRn5EgH4Te91SdpI+JkKOe7eFVdWwA95tDbLQC9FEqNlnlOZv0ksIqmcs?=
 =?us-ascii?Q?SMbWNZ//Jj1tniDru3qr18kcW/XAcQMKjRE2wDAr7fLk8fpK+JYNC+FL9rF0?=
 =?us-ascii?Q?zkqKOdComrvN4AJmsleBGhzljzR9DlH0NUd/LGGHmE5GvkauvOlczYgXWODN?=
 =?us-ascii?Q?s44SbHQKd3OO+ZoCQy5lrDuetvYQ8p7zbBeuURrHhU/EsO9xN5RwZRqerOy1?=
 =?us-ascii?Q?lr/djdWy10H9AfwruhEOcJoXyOYyGD6eO2a/NxdHxYH/fz7s7FsppYmJKKEm?=
 =?us-ascii?Q?whmUTon/2YTWpmdjkn8deKAlWW1CPrIGsijXY4ra7LBVGZoLH1KgOf8mG0a6?=
 =?us-ascii?Q?7EzuaFv7qKxp+9yeNSs2BE62En0hLg7FqYdB3lnSUBG7MW3wYkk4NIsT6xLI?=
 =?us-ascii?Q?b8YiomJqpMXuISO2Xiq5jeq0N5EgYcqoBxYFSL1Kjt81mg1gz+P0CAlfrO4u?=
 =?us-ascii?Q?k6fc3vNmAa+6eAGM3LBgDO+1W9igG41az1YddH+cPqJw1pcWu30e1MuDvxWd?=
 =?us-ascii?Q?LOnAS/K59ZKhbT1qnaWNrjyhIiJZNQvp5esFACTG4sVykR+cKBMhcDxTvq3E?=
 =?us-ascii?Q?ufOWrehDYjQbtwY67XMz/hekp7RMOnH9TM9HldyM5SVKS7mdlWi67kixYNHa?=
 =?us-ascii?Q?TlKsEsX71Cb/LFPvQRFSYSAebXWOKatScYaIQaKcMuaCrnfaKxXeOG/gmyL1?=
 =?us-ascii?Q?4NosULF7UmexIGTIlyfaMfGtlL+BVHoEoZE1CynvDil8My3lINCbG6trqKt2?=
 =?us-ascii?Q?RHHH3yoA6k367FlUu5F3/2hx6C5FnpFKRVsjksO0f+0G+VxF1qBFfVQZyi+I?=
 =?us-ascii?Q?gicDGrbBXm2WXJ0ykG/X+pL9MY6Y4GPOmjj4w5z8jx9q1XPSXVQtN8Ulq0yK?=
 =?us-ascii?Q?uZiDhNIvzt02IRDvG9f/F4CH9bLtFgf9Q/Eob7vu05bbOUINWAVphxIa5efO?=
 =?us-ascii?Q?50Kdqd4eREC3yUhcX/CpBJc3bToQtlLCOngXGpznVSwR2Z9bi3nz2GNhXNl0?=
 =?us-ascii?Q?Hg00uDFTAGWyfBXZ1pbnf0nhm56FCgkCxFElwIqS7SutK0hMB1LRUTxo7V53?=
 =?us-ascii?Q?+3rkuoHH6dnztzuGAOY4+E3xSR5b227D4t9b4Lw821LUgkW+bsZuJcsebnXX?=
 =?us-ascii?Q?lXzCwVWh62AdAh10cAucHoBNAAefyyO0eTDAX68e+q73Ba3RoCYmxIg8yPAb?=
 =?us-ascii?Q?HpJXozBTUWWl2WECmVgOuAFhOM13RJ6G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QheUNBCNo8C2qgqG14J/ZgWUUHCU1bweWFsWVKq+9yG9k8sf7btGJP/PyW5g?=
 =?us-ascii?Q?ax/WOJprsaFhHpL3DGteQY0YapJP7mVRy0Bcf3MqvIsv/0BXEJPTu3JrxXv1?=
 =?us-ascii?Q?h1vWePsvHzoEu1/wdSlT2zLhgOghgLlQ23gAuIurnQ69BBciaNpmVOCpyGkW?=
 =?us-ascii?Q?1jf7/qnlrYcyWV2t0/soYOJfSWSIYC+d6p/Dhtqjez+1OQcXtUdoK6EoyVEL?=
 =?us-ascii?Q?VOU8/Ud2t9e0BnNAK1nQDHPC8qzMR5NpXWbaop3V8AHOotS9Tkr/R9vnW5JY?=
 =?us-ascii?Q?FQXDQF0IEKECdXCC3ZGXVgEII4DPnyKygnse+OojrwHe9r40fX5RLkv1CWag?=
 =?us-ascii?Q?zQ6hrqFOmAHstSfK9x2ykhNcrTDGlC4tkYOISXAyFhghQv2MF6vU9TLlsqSv?=
 =?us-ascii?Q?LOJYH4hpt4e4GQc/BnYujAwvVG2NF1gAfNs+rf/kQJG2x4KPO2jrHxBVQCk2?=
 =?us-ascii?Q?RyES0zSG1mv/SqlnQf0LL/Zr+CKqmAumoCO79J5koc36eUed8XQ3P2x9i8c1?=
 =?us-ascii?Q?VMlK4tj4o+An/pvKcvgazDolty7OjVoCwgKa5Kkt2sSLgUe0bKjwJQLz46JH?=
 =?us-ascii?Q?Znaw/RLWI1Vw7LKX/4xHRKAwm4h/InSmv8omyROFJTY2i0dP60fek/nNn0Qn?=
 =?us-ascii?Q?grh46oYZNYyC6ahbud1u5wrvonZLRSlCEFzL8gpJnpjHzArUJ1eAiM/aEATm?=
 =?us-ascii?Q?jJwzAplmPobV1C/AVuHa3HizWL63SvEDu1izbJ2YGo7E9b56jyoP8eoHinZ7?=
 =?us-ascii?Q?Ixu+ag7dYrmvGTHdbbzRBzmf/ZQU+9tcj+FJmtlhhmKftWDPeIcvVmag7Tks?=
 =?us-ascii?Q?feqQmXB734vbQ3sgwMtFvMcGz4O+x+T/p2eMBvDTMgaiMLtyeTBH0DqyO9nG?=
 =?us-ascii?Q?x0nHHYr2dr8Pmag8lhRsDHjzRmZTr+xc/52KxJuYYclaZJOkRVpebFmrICkI?=
 =?us-ascii?Q?zi9uB3YykZc5l1WDmsdMTc9OLc1VlZPRY6OWd2Ud8DkGfBUam+LctL1NLS46?=
 =?us-ascii?Q?YLs9LWeUaDJ4Jp68lDGxvqOd/8CYYxhBZJRWj4QMNWjoNP+6nqUbXVviTe35?=
 =?us-ascii?Q?wuGWhxUd7SOm1nl8Z/5mzpC+bcvrkm1SSY6hXcvQ3kpPip81gIaw3QEMkaj2?=
 =?us-ascii?Q?e/XuJmOHUSIHJXDnnggZMabktSE2vLbt8BDw5JogBaKrDU8RX2O2IwOkjL6h?=
 =?us-ascii?Q?EbFzr3jz8Z250jjCgAkeHSFuGljAEEbDLBIrVpoa1aUQ0nAEzGp11Z4ZifMm?=
 =?us-ascii?Q?HBpmk4HHbRg7imCWxW7xTiSGeB7J+3aLXUBN8lBru83hI/BPO1Im65druGMC?=
 =?us-ascii?Q?2Me2MHvPtKwTcH1VMD/zD5+Ya7sH1QnwDvNy6IAtpNWK6eJHxqtn73LSzD/1?=
 =?us-ascii?Q?xeOnQ21XGgTmbSvbcs4q12ejt1udgYK2qLJqwXkBqkkbpZkR2RGHt2KmZJwo?=
 =?us-ascii?Q?itQIvLQUWq6mg6RkGX0SH4Jopxggcbk9Gc5AlyA4VLc7Pdhh+8kwxEKVBJfW?=
 =?us-ascii?Q?OP7uFAU9iyF1KO5aL3p5wtu5SwjIXpF7G0Tc/lF3K6CwRF/fb7ElXyxfdu7F?=
 =?us-ascii?Q?bN4WlfLGk8ESVvGPzfY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d53e582-8932-4dd9-ea55-08dd47ed074d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 03:02:31.1552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n51ABubKfP6joAIuTNnG0UKw8LYxgQTcYDBkBqKm1wVyMKVY2xg7iqxoL5awdIh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

Ping.......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Friday, February 7, 2025 6:28 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
>
>It will hit deadlock in svm_range_restore_work ramdonly.
>Detail as below:
>1.svm_range_restore_work
>       ->svm_range_list_lock_and_flush_work
>       ->mmap_write_lock
>2.svm_range_restore_work
>       ->svm_range_validate_and_map
>       ->amdgpu_vm_update_range
>       ->amdgpu_vm_ptes_update
>       ->amdgpu_vm_pt_alloc
>       ->svm_range_evict_svm_bo_worker
>       ->mmap_read_lock(deadlock here, because already get mmap_write_lock=
)
>
>How to fix?
>Downgrade the write lock to read lock.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>index bd3e20d981e0..c907e2de3dde 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struc=
t
>*work)
>       mutex_lock(&process_info->lock);
>       svm_range_list_lock_and_flush_work(svms, mm);
>       mutex_lock(&svms->lock);
>+      mmap_write_downgrade(mm);
>
>       evicted_ranges =3D atomic_read(&svms->evicted_ranges);
>
>@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struc=
t
>*work)
>
> out_reschedule:
>       mutex_unlock(&svms->lock);
>-      mmap_write_unlock(mm);
>+      mmap_read_unlock(mm);
>       mutex_unlock(&process_info->lock);
>
>       /* If validation failed, reschedule another attempt */
>--
>2.34.1

