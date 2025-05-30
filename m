Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5C2C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 08:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F65B10E21B;
	Fri, 30 May 2025 08:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kINJY6ju";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A34E10E21B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 08:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM6cd98wfxlrn7Du7Gbu009m/WQWxpIJxHbMl7w0hYbKDgtZrHf2tsuilySuKJnJ6dBSeDQiAepnum2KDKYf/wmi3IDvTJWHkc3Yw4gUwtfcRGjlXBGvklK2fPrth32ZcPpkhxU4xoGBDu5eexFi4YWTbUPRI76/3/aQFs+oSB6UGvo2Td7FpoJai5vta5PKdKl4ab3uicy32PoI7LeirDuSa8GVskn9qumFMCw1N0DgTLecCzVAtDf82AjiKusn8s1NesNxhyv9eUr8eprXG9dF/KB15XIemnBS/iI1LqXEz3GkPbtdDTansmHTAkQMsAXTlWiWKGMDF13CVA2VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFDCOqVtKLvss7nVN2mjfzyHte7MpHkli46rwZ7aO0s=;
 b=C3zUN4rWDaD0TSSEqg1DJ1vT2hbgzMiQx53xQbJbwvEJgqW202lsmzabV0kCccu0JloYLtx7DeEoOBc0f5YmEO07IozWPkqg1E/BoPTfzZ8LbWxDVsisZyv7IvWBZBXncMGXfDQKzbqW1Acbm2vvavE7uJ04qSHIobQzmZYHAWEvOE0IKdX178Jvx+/VkeUt4IV++F1OQ16Kfs/8h0WM24juxsopGnq5XlowQgUkAB/eQ+kOHqCWHl68Rmh048VKDD2J9KDXg33fCXKuAvq8yVfEAZmN82siq5yiyhLMTGCrwb/PEPzSzLrc82z1gHt6fAckN1IrQCD3F53GqPfztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFDCOqVtKLvss7nVN2mjfzyHte7MpHkli46rwZ7aO0s=;
 b=kINJY6ju5NPzfXtEOsPpB7fkZfCPLZHGU1LBXX3BYMm6DuNOMnv2ruzCLV+1gdTmkIVDBrv13vxYqm5eZeOeD3bhNwY0oT+dzaZ8Mc29XjSVAbqREe8oXAEhYZkRDiuGym1dIGtLO/gihJsI8y6wBUmCD0yEC0LyysEi2CaEdjM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 30 May
 2025 08:46:16 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%2]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 08:46:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
Thread-Topic: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
Thread-Index: AQHb0Tg//Fb4yekIk0OC94ahgWLy1LPq23aA
Date: Fri, 30 May 2025 08:46:13 +0000
Message-ID: <PH7PR12MB59970C154657D4CC163B6D308261A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-5-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-5-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1453b73f-41d4-4424-a048-2cdaa9f64120;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-30T08:43:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB8435:EE_
x-ms-office365-filtering-correlation-id: 44a9961c-47e2-44a4-c781-08dd9f566f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pZjqJRe+k05tVoNkfyWIDYUqYizJRWn7yiWXjBSJ9tdKJqblkH1aWshwiGvE?=
 =?us-ascii?Q?+CylXQd3u8ZDBIZI8cVmM0vbpMbzhjjSyw9XTE707dizpAbVItlT0nl9WD1s?=
 =?us-ascii?Q?LTlSUNnwqPLTl+TT4kWwAlQLHKIB81/ep5CLcbwJTiVGwF6T5KmG38AXMttp?=
 =?us-ascii?Q?SblNCINM0muSoAN0agdkKbTfgapSj8ear83XthTTNiYulh4Wk+ccWJFSx9Dg?=
 =?us-ascii?Q?uZEa4+m6CfU5zeMvr97EuoTj/DarZCeRi1yeRbVsGXWAof7YyUgGRZ8l0rVe?=
 =?us-ascii?Q?CAnE8dwXFgMXpvzpMj4nq76a/xV1G3ZUFRzahPXQIap281UpD1Xk3ZJOJJRx?=
 =?us-ascii?Q?59I1onH4qFt4NsmpkTlUe7iL209aKNigeHLJTIKeDLJFsJE2T5tP4aeVCDYN?=
 =?us-ascii?Q?hWqXUFexiKA/CoOx0zNTqCeDzfOf7kOURkva724dYriebhhljchHWMeZoSb6?=
 =?us-ascii?Q?UMpwO72QEIzy1+dmq48t2QdjFsjyOnlDeKeIuBHUY7mvyMptYPDFb8p2a3B5?=
 =?us-ascii?Q?yTvWAq3b51kmP9jYn6tUVS+9BKBF43pu1wSkEl7MyP2huWCAyd9RbFgB0e4d?=
 =?us-ascii?Q?g1oSXNMU8wxzBv4wE9l6dbJd9Pmq4isrqjFfRthSZZCg4bB9aa/D/Df8cVDD?=
 =?us-ascii?Q?eKebyPPUutT1H3fwBve+Iu/APu+CNZC1S0/NoPDXdu2tbXtQ/eMupdqqQkND?=
 =?us-ascii?Q?us74Z2kUFSUy3/EzJdoPwS/qFu4qOwQ3hA5wm8cWxXYTHDDs38Q4FqOkSeAL?=
 =?us-ascii?Q?ZNa76za1wj1Xtze+2/6Ynx+qcT5zKO3gpMN5oDoT+Q7vzqhPbBQRlz+asqAB?=
 =?us-ascii?Q?bniuKuaffZLRVF2MAI/HwTTVO74u8t1F3cwrDKsqpAQQVLqprchsCdC8FU7w?=
 =?us-ascii?Q?G7DiSR6GvyAyHykO9tKf8m4H4aQlWrlyNiSV2D47qMWlMBhfv+bOE36p81QS?=
 =?us-ascii?Q?kRruJ+ICxqrs9OaJ5/iPsq+QU4YI6qpR6Sn52yykTxda91qceJZaC0o/sk4x?=
 =?us-ascii?Q?c5cuN9SAUZn5T4dF/ezTgvBovS+B3FXXzmetkreZlobNz13zp3yH0KQJWv8p?=
 =?us-ascii?Q?gfuIA/+xF/PiU/yjEvMY9UmDy+E+IQYPVReKqrXETLYRywwqIqyyfKT186dj?=
 =?us-ascii?Q?GVWRi3iibKV59uedyS63a1F4ZWLVNCfXp9gUklqm/th9EmvONNZd2UFd3+4y?=
 =?us-ascii?Q?1DPMS/Cyu8evkO9o6VxfE8E/xRnoGSlHLNdiCRFrQxEiSlWunw2dPJnaWQAb?=
 =?us-ascii?Q?2OWcMmdueVtdDtKPJSyJAC3y0vo/wHn8JgtJvjX+3iISx+RojHaH3WrbJDyr?=
 =?us-ascii?Q?LOmbY3FXr6NgxniHHKPDR50xU9maxTNfO50gz92PwPdi+8KKVnCMZUwBwIpq?=
 =?us-ascii?Q?YQ9EKMmeiDPmKiLRwvVNJQn0fjVY/mFlkrUCIuXDv7RMoXeMH6d+cIRQE7ET?=
 =?us-ascii?Q?syi45Xy+HAOEFqA2lU7aSCcILhccLjTkKMQ49KtpRNcrn7wMuid5qFpU1u6r?=
 =?us-ascii?Q?T/7y9k4xMtWHNMQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CY/zLsKcdH6BNcSU8R/avRzFzXe5fweXNXXAOIP5wFwjeSc0Q4/4Yi1JgE7b?=
 =?us-ascii?Q?eFJ4Nx75Ed6YW9lT9iO9MRcY0sYWWujtMkvSsh2ycFObWhPTXy0ViInWxt7A?=
 =?us-ascii?Q?dl7y6k1RM1ianq7vyJt4NAS+hZqd24WuDAe4+NfU+00D7WLOqSvGKwG+5ov1?=
 =?us-ascii?Q?mxFN/OEv8iOAodGeRuUUDEyK/otiFcxEx8QI7qG3Ozoq3uKpPw3Xa6/gv33F?=
 =?us-ascii?Q?caCji+jkV1V6hDFqpgjlITTZGziXojs9KqdoKtGERw+d6Llg1Dvmy9ip3h+x?=
 =?us-ascii?Q?M5eXhfx0XEIQitOf9HeRO+G39Ob1qYyKo/ch+3BsQ5xcYu61UJmPemSkK7Tm?=
 =?us-ascii?Q?yHrutWwbewvUm+Ued340TdQ+Tp6nwg2I+npJCZLipGsIwD6PUwkYCvo2ngFc?=
 =?us-ascii?Q?6g7PwGDz9bE1u/QGcw2v5ZBh4xkq95iKhOU/lBc3/uHsHUensG4NMZySBvLf?=
 =?us-ascii?Q?0nijpNhXKzqww9UGmplSfkSL5ImsS/zxzu/vqJQ2KfiCv8TMaKQJmlEq1zUK?=
 =?us-ascii?Q?C2uieTb/uRb8qMNIn234hbtQUvtkNynOFbQ6az+jQYuEEU4NPKTIi5lb9Oe9?=
 =?us-ascii?Q?a21oHKAKD1h34yHC49JK2+ralaT8++lJ4Z6tNXCmmO/tkbCeVt/KY98iKMr1?=
 =?us-ascii?Q?X45e1Mk1U1pa0P0xwloM2uPfQJU9OOluLzSScGVtjHNH3r/d7SSGAfIONNti?=
 =?us-ascii?Q?EDzkJR6hOhH4cSvp0jXLIsxDwUlUCoGqODUp5FX0G/o0ZsQgURJUzpkeTm+/?=
 =?us-ascii?Q?wvsmp+v3DnU5LAxcjEZV8JhxZWiNgv7nImZkcY+Gs6CuyG6rAi1htmxo+LW7?=
 =?us-ascii?Q?+eo37xiFJ6C4tOZiUQMVV2/8yySwFD14TdX6hziQtgAxR/odbQwpNK/+CIWo?=
 =?us-ascii?Q?Pgl9IYxdUDSToM7g99P46Ig7N2gcZiDxUzOVs+CAiOdW6UmEtAzlIUphJtdQ?=
 =?us-ascii?Q?LlNQWdp6N3Je1YlmYgztFFVPGuIDe2bpj7+DmPuzjS6o9Qr1awgsKg1Z396o?=
 =?us-ascii?Q?34X12RGtlHQ+4Fs+1c1yefEI8epFKHpG5691Yi4gk1EIVZwlWJ4+n6PC3Kov?=
 =?us-ascii?Q?6k3kCj+p3z1aJxOy/b9OH7fFL6pwU1ePKWvgYy7SEFCeI7IQTH1lYszMvWk7?=
 =?us-ascii?Q?E52gkjAhc9fKD3/hmcxJnrdaOQU60NnrHKT7TjfcA+4qGYFe98epoh10YNgg?=
 =?us-ascii?Q?GTV+MZZdFRYknbNUml9GFHgsEC6UbQ2rX3NBCYdS4abyk6daUEXnDrY/eG7S?=
 =?us-ascii?Q?WjS/JuRjKUBMbjdFROCBaFDpWlpdNuzX7/lVNW55fo3RA+CalaSIX6swVfn4?=
 =?us-ascii?Q?BAS3Tee/scaafTzHrrgUaQJebfkpqUvFqzwrGm9z/MPJoOSy+9mQHGZGfxCq?=
 =?us-ascii?Q?p+ltJ+sa+HGocRdNoKqqRdY5eSajtakBLr2y89OQDQYUWYUalTfiZInTgpkN?=
 =?us-ascii?Q?7MyHc+I4lpgJu0ZO9XL56AbTg4R2hOc9WEpPKpzyvtC8BBYxAQFmvCJeBaK7?=
 =?us-ascii?Q?g5CD9eeu/xdF0JXbNatzMwK1q7QSs3rcvsDz66A8XTU/EWnbde/vJ10FOdz1?=
 =?us-ascii?Q?vA8U5FO6caygBvQjgDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a9961c-47e2-44a4-c781-08dd9f566f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 08:46:13.9381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GoXXK2kwy66anD284PsOCg8d5wMeBRU5xWIj2p3vbef2ceoffs9raWCYO6voU+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

+       user_addr =3D ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);

This is a PAGE_ALIGN_DOWN() macro can simplify your code logic.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike Li=
ang
Sent: Friday, May 30, 2025 15:55
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prike <Prik=
e.Liang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: add userq object va track helpers

Add the userq object virtual address get(),mapped() and put() helpers for t=
racking the userq obj va address usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 120 +++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  11 ++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 32e88064bdea..3854b1696d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -79,6 +79,122 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm=
, u64 addr,
        return -EINVAL;
 }

+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr) {
+       struct amdgpu_bo_va_mapping *mapping;
+       u64 user_addr;
+       int r;
+
+       addr &=3D AMDGPU_GMC_HOLE_MASK;
+       user_addr =3D ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+       r =3D amdgpu_bo_reserve(vm->root.bo, false);
+       if (r)
+               return r;
+
+       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+       if (!mapping)
+               goto out_err;
+
+       /*
+        * Need to unify the following userq va reference.
+        *  mqd  bo
+        *  rptr bo
+        *  wptr bo
+        *  eop  bo
+        *  doorbell bo
+        */
+       //amdgpu_bo_ref(mapping->bo_va->base.bo);
+       mapping->bo_va->queue_refcount++;
+
+       amdgpu_bo_unreserve(vm->root.bo);
+       return 0;
+
+out_err:
+       amdgpu_bo_unreserve(vm->root.bo);
+       return -EINVAL;
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr) {
+       struct amdgpu_bo_va_mapping *mapping;
+       u64 user_addr;
+       bool r;
+
+       addr &=3D AMDGPU_GMC_HOLE_MASK;
+       user_addr =3D ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+       if (amdgpu_bo_reserve(vm->root.bo, false))
+               return false;
+
+       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
+               r =3D true;
+       else
+               r =3D false;
+       amdgpu_bo_unreserve(vm->root.bo);
+
+       return r;
+}
+
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+                       struct amdgpu_usermode_queue *queue) {
+
+       if (amdgpu_userq_buffer_va_mapped(vm, queue->doorbell_handle) ||
+               amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+               amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+               amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va))
+               return true;
+       else
+               return false;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr) {
+       struct amdgpu_bo_va_mapping *mapping;
+       u64 user_addr;
+       int r;
+
+       addr &=3D AMDGPU_GMC_HOLE_MASK;
+       user_addr =3D ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+       r =3D amdgpu_bo_reserve(vm->root.bo, false);
+       if (r)
+               return r;
+
+       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+       if (!mapping)
+               goto out_err;
+       /*
+        * As the GEM userq bo will be unmapped by amdgpu_vm_bo_unmap() whi=
ch is
+        * invoked before userq is destroyed. So if we want to reference/de=
reference
+        * the userq vm bo, then ensure the userq vm bo dereferenced  befor=
e
+        * amdgpu_vm_bo_unmap() or fallback to unmap the userq vm bo at amd=
gpu_userq_destroy().
+        */
+       //amdgpu_bo_unref(&mapping->bo_va->base.bo);
+
+       mapping->bo_va->queue_refcount--;
+
+       amdgpu_bo_unreserve(vm->root.bo);
+       return 0;
+
+out_err:
+       amdgpu_bo_unreserve(vm->root.bo);
+       return -EINVAL;
+}
+
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+                       struct amdgpu_usermode_queue *queue) {
+       amdgpu_userq_buffer_va_put(vm, queue->doorbell_handle);
+       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+
+       return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
                          struct amdgpu_usermode_queue *queue) @@ -451,6 +5=
67,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *=
args)
        queue->queue_type =3D args->in.ip_type;
        queue->vm =3D &fpriv->vm;
        queue->priority =3D priority;
+       queue->queue_va =3D args->in.queue_va;
+       queue->rptr_va =3D args->in.rptr_va;
+       queue->wptr_va =3D args->in.wptr_va;

        db_info.queue_type =3D queue->queue_type;
        db_info.doorbell_handle =3D queue->doorbell_handle; @@ -481,7 +600,=
6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *arg=
s)
                goto unlock;
        }

-
        qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_CO=
UNT, GFP_KERNEL);
        if (qid < 0) {
                drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n=
"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.h
index 375fba639c94..65f9bd91ac73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -52,6 +52,10 @@ struct amdgpu_usermode_queue {
        enum amdgpu_userq_state state;
        uint64_t                doorbell_handle;
        uint64_t                doorbell_index;
+       uint64_t                queue_va;
+       uint64_t                rptr_va;
+       uint64_t                wptr_va;
+
        uint64_t                flags;
        struct amdgpu_mqd_prop  *userq_prop;
        struct amdgpu_userq_mgr *userq_mgr;
@@ -134,4 +138,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,

 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
                                        u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr); bool
+amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr); bool
+amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+                       struct amdgpu_usermode_queue *queue); int
+amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr); int
+amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+                       struct amdgpu_usermode_queue *queue);
 #endif
--
2.34.1

