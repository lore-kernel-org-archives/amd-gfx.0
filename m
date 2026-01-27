Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD07CA6C92
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9234A10E4EC;
	Tue, 27 Jan 2026 08:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6QNPFOd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEA710E01F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 08:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTwNM8wrIYx/QnqgLFzdzVVF8M4LAuC+WpbdzY59xMfxw3a6igIAtmABstNjFCSAVWBifQX2HVQ2Kl2zPCzQgZK8vjWXjfLQKbyaYg4UjiDeHU4O+Bqh7oxawqoLF8roGZd6LPJ5QyRYd9EVzM/5dbibtyHxTv02+QmgJQ9ot2mmCpLkzYPBNPw55+7F9Mj5J1dE5/wnmgNXJA66tFxtR2XQiG1h5NlMqeETq5OHXM6M914QZZRh611mxvj5wJu3PLEITS0WWT7JWEekdsc0xG7+kByBVb3Jy1+V3JXkiQ1los6zre6sIJ7FSniKNO0jtUsIX83nlsM4h3b9+XWguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7gxrBUNRay6P3383NTv3MFhYMCfm/VQBbIxnWQJqz0=;
 b=vtEVxXa4WsCf8im6pmB2p19AED35py7ogypx5fpFBP2wPAjWkQnO95lzxM5OCkgtUof9fvLhLOVtXAU7ip5rxJnUa33ih31uaTFsyMO0PX68uCdC+Pcd4XbXs7pFX/Vnfh1iyQYnfMQlv1GKm1+eH2S4ssAfdCQJFujs6TK2hFyM/xm+/cndQS4pWGttvPDbBHJRgtBC5yepwLcwFtdEe67WkC0KOvH2+azmTCNJ7BEKfrac8umWjPtLZOl9F0ygR+eVxwfGUZ3viRwa9mAehOdKq4GAmhtKe0acHDMNLRIQSDZi6UwlxrE1WYSvVd3AoPu75uJycOAD2ZXm3+SRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7gxrBUNRay6P3383NTv3MFhYMCfm/VQBbIxnWQJqz0=;
 b=F6QNPFOdHnblIcN45sbTKZGj+vdwU7Djynl7j7OIaPPnsodKxGDsUh9tsVYYogEXvCEA3ALLRo61jbuGM0reDzV2UF/y5gMgPtwW6NxOE0vsOo/DoSGSiCV2Z5Hk08WWUiuOQDheU/pVF2YP8fkbZH1Hm/x5L9rDzAH0bOBihfM=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:50:50 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::4ae2:5a34:266a:db8f]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::4ae2:5a34:266a:db8f%7]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 08:50:50 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix race in power state check before mutex
 lock
Thread-Topic: [PATCH] drm/amd/pm: fix race in power state check before mutex
 lock
Thread-Index: AQHcjzqRWoGJv/HE2kSgZO9OKyKLK7VltWXQ
Date: Tue, 27 Jan 2026 08:50:50 +0000
Message-ID: <MW4PR12MB68036CF2AD0C68DA36184A968E90A@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260127031047.4068526-1-kevinyang.wang@amd.com>
In-Reply-To: <20260127031047.4068526-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T08:50:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SA5PPF06C91DA0C:EE_
x-ms-office365-filtering-correlation-id: 29a77d26-7c97-4806-11e1-08de5d812bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tk1JiNu/Q1NxvyRZCBurUxPFmkL65v13QgXm1xtWiI8gDtxFGC/Ql1P0PpCM?=
 =?us-ascii?Q?wJ8Wte5nh6nYTgRDwRdebuirlvwX5J67I3dt98KliERQMsjuOKGv7POBO0e3?=
 =?us-ascii?Q?yVxYn6kRoIFfnjrTHDKTDaLbpGfywTh/30RAsySuqP4EaAJQQkWzP5PjJ4Uv?=
 =?us-ascii?Q?3oMjOZ1evfHcZ6DNkApC/uqFM1IxVPqUyX4Mbq0kOmL5ydSpajgwaK0vSkuT?=
 =?us-ascii?Q?OtJ6FikHZfuA2yZ+dmzKRPr64hdbYPfHkbr81PqEN7WV+KIA7DMj/qmpvpN2?=
 =?us-ascii?Q?RvlYIG4iTaK/LCHYKUxuzYkT+dvurL3sbY8XHoryJuiVAstd06THeDn8IC7T?=
 =?us-ascii?Q?qymEMfGFMMkjDddJgDR9DbqzL838UwmIBN9gW8PRh8ONkkFaNBpMD3LD+dnM?=
 =?us-ascii?Q?pXDv9LnhteXpJ//VOXotbIkvytagCSOyTw6ItEdax37znw3aOJFydz/LxdsM?=
 =?us-ascii?Q?dDKjHBEiYGgbBOji+kgTmYjTAWrP3ViqBcaUxMG4VNqRRK6Z+MLWCKEW/f4c?=
 =?us-ascii?Q?LoeWI/P+DVK3yjpLAp3qQsTS/66HYMVm43wWymTLUGrdsHXGpsbc+YPspVjM?=
 =?us-ascii?Q?SDCJzYtHgUS3QHn9od4fdkQCxtFLRPkVxeoCRzXOdNQJ6WPUIrZ4O6I0BCIR?=
 =?us-ascii?Q?532mCiW5z4ZkmU5VbqXqt4jMROZuwYIYULQ+F6aVOQH5yZCpH6AKYyepeJow?=
 =?us-ascii?Q?4wDO84hgfwrZ+HrIsQOXzaALoGpXGO9aPpihwZdq7jt5wJtN4l7LZSaCBvzD?=
 =?us-ascii?Q?x5HmooTwpkTrkBFMrFMcr+1B2HsY1hbBPObBhOLZLrM5Q8CMjMW+Bcfp4hUU?=
 =?us-ascii?Q?kDF9vCXUXGzIsmMeLj1Lv8flBmwMmg2DXCnglaqGT1dB1+fzGgbAj8MlQbUE?=
 =?us-ascii?Q?sR5nW1MkUJcowMOC9RhnGxezXXCR5Mprzx8uDP8Ao21mnrN8pSYtzUPEgp7M?=
 =?us-ascii?Q?NeWe9m1iJLAnoYNoz2GZLGESvDaAJKgkANmGPhIibs9M8IwY84YlwdCalWS1?=
 =?us-ascii?Q?UfnoUwzlvvIDz4p3tPGmlkTdJaIAyYsh3o81/swDdhysST1VkmB5wOpMuXL5?=
 =?us-ascii?Q?Q6FHDVI6uGe93HdsmnWRS6hKJUg0pnG6hs7/chh/yzJIuTNdxrjZzteZ31qc?=
 =?us-ascii?Q?PJpGs8l2gPzmimligKnQUt351Z6xZswOX3G4TVWi296klSU67RQmKhpkzJp9?=
 =?us-ascii?Q?NhHNUvbJs48YfPsNSJhWFFtg4Dy/0Vxc9V67ZGduIX9CbfddAkqrYWhFi1UL?=
 =?us-ascii?Q?emFIt3A8zsG57ENLT5lfR/WDKk5c7RjEjF9wXh21QYLSI7DFCdeSF5NpWWmy?=
 =?us-ascii?Q?/2bBsEMn1nVnkvgtEsxiAph+HUKfciPqdQ4gZc/9LAgEyvHSl7pYEHfASn3r?=
 =?us-ascii?Q?cZeV4rI1M4bb//u1GfRr2d4PwtVIkN4QebzxelWE5rjng53gDOZREOSVU9Ad?=
 =?us-ascii?Q?V5V3JOgBYJTpcZprsk40k/0mlpftwRoLOjU/p+dGqv3W5coDFv/uFHq6Q0L9?=
 =?us-ascii?Q?Y17B1hPNDhlPr0Lm7oe/T+7Qr5UplDxfmX7xUMNOpNvvuqHWb2DZ5XJuRUtp?=
 =?us-ascii?Q?CqMCC8o4EAvoPjZ74MXdl8XB1FwRWBQhDPsDwBVW3sCK2Zt6/syHfMnur6Yt?=
 =?us-ascii?Q?k3/Bv3cblYg8Z98in1giCas=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z0SlgY9I9DYEMok9qWw8mbZBhCeALJSXbV3jE927eiz1v8dx8Mcd8KAir6cc?=
 =?us-ascii?Q?KE/igYWfI+8c1SR1oB0UicNMO65u6Ux4B+rpnfb9dmt3B3Z9nicnv6y3O6MX?=
 =?us-ascii?Q?fijnOxjRMc3pvBeHHDdIjpMcveIeVxGdGpXuY2Gih7lbT42Fz98nROu52gM0?=
 =?us-ascii?Q?QiqG+ZoHcVBSOVGi3mtj9dWyrCv5Gl/35eNZv8igLFvxWq72RXUmBDdfyOKc?=
 =?us-ascii?Q?L0622NtF+STWwk6z3T38KUvsB463ilRGeriBwtNMKaL5G8+TbqRgJ+Sfiqpw?=
 =?us-ascii?Q?LDKOCjZPVdESHb3rWwgssNAccg2vrrsuA/zel3mSjQ5XscI+KBBrJ/SZsMgJ?=
 =?us-ascii?Q?xJYQmJB8TKv8J1NciozwoR+aco6GVyCFOO7NQO7s86gVxHC2pBDWDbRmC357?=
 =?us-ascii?Q?+eCQEhPl2GXjYM1YaEOZNCtPmaWZvUeirL5IbHEhqLBdm23aEGhZmWaCxayf?=
 =?us-ascii?Q?kpWF77xe4zqfP9cnhWmSESzE4ij1jUnUWxjihaKm5KG7rzJzNkvlPX8njL72?=
 =?us-ascii?Q?ZbLpyN6zHOunAXh9Uk/El0qGoQf6BFJpsQZLB9PNM1IQk+A00RdqY8ge/FJ2?=
 =?us-ascii?Q?+hxAn29Rz79SgqlrP3PQZT1bpwT+2I1w0xBhK0KQNmQUypm9iLFLMH3jBy2L?=
 =?us-ascii?Q?wVzj+ypznD9iLo9SCKHd6ziX6WZ93dcdfK3gPLnifHOISCZ4yYDUbjJ2aoyK?=
 =?us-ascii?Q?u/j4UtkwGKTT0d3AAFu8d1Jkmo3W4MpmF0XoU/aTrGjzZ9VgWmN8mTlCnWRM?=
 =?us-ascii?Q?Plvu3BBISYMHOOwE3l7tkOiDBB2HCZ+0P6Ru+Whnx4w1CM+cp+qCZV6QHGyh?=
 =?us-ascii?Q?SeoKateNf1rC9CB1a2AyNVy9ChjSLSuu8jCwzHXPd4u0edarq5kbjEP2DzKh?=
 =?us-ascii?Q?loCYdahXpGL/CRk1VnLlBhIDwKw2pY5GcaAuKDz8vLOA2iS82cBKANTFbUUK?=
 =?us-ascii?Q?Xgha8sXZE/V/PThO9wtVobdnXROWZSkaLvvuONBGnVJBQNYJ/HZRemnmCusj?=
 =?us-ascii?Q?Oo1pF8KLJAlc9XIlXUG7mP2CRRibdNT5vhDpPMyzE+YSLQcTXaRBg6mk+kjE?=
 =?us-ascii?Q?gztiNvHcIrvdxpgrfxlApNuaGsONTApACqYuCrHSxwUkS+G6VKdWW6eeEyLI?=
 =?us-ascii?Q?720Uhxf15KTxiAnlcC2GvbQDy043pTYa+bXtF7HR2Dee5drtybgSDU8edtQW?=
 =?us-ascii?Q?vhRLTbAgN8nPC5hjL3HEhMYIG0/EH4qI16tUGFeBa+qnb/ZAm/c3o+PAVcG2?=
 =?us-ascii?Q?oE8HZB2pmZNjzzP0tP+xEeAbzgxbAWc7Z1lwOz8nrI1aTp1+QRulN8dfBSSK?=
 =?us-ascii?Q?cUm25ve1c1EFOR9B3Cdxw6eAn2090Xa6g70w2fREcS90xIGcxkoVb+YIYcyt?=
 =?us-ascii?Q?vMu8zcb5CoOctr0eHj1vcY7mpSZvr3diFlOjt1ApRZbaRQ/zTYP7jENiiBRc?=
 =?us-ascii?Q?+YqXh7yXdrNxTHw9CS4XYujX8bwWbrl1QZB3YeJNywVqya3RQewsQu+HfkoX?=
 =?us-ascii?Q?CxkxP6t64CeVHbhMaTNSwM6dZR6cm6bjYvRpdWm8bQCdtQP60xH2ATf99syV?=
 =?us-ascii?Q?TcQJVhH83hcCzvnzyXn97pyD03s5LCPnVuSwvx+984eYoJiSqHZm1KeDRe6T?=
 =?us-ascii?Q?qofPp7JQZ+/n92ZBx2COIAGBD6Rv837yVDafGO3y1WGIM/oEpaP/uuDJ6c5j?=
 =?us-ascii?Q?zIAlE+AD7l1Hp/OZur1dTOdjI4ejeu52QqNL+iBBCVR8S+aZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a77d26-7c97-4806-11e1-08de5d812bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 08:50:50.0648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4dDtr/172/neuSJvSYbeuyTMhigkwPU3kOhI+6QkVHPC7JHE5sIcz5ifAHbZ5Sl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, January 27, 2026 11:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix race in power state check before mutex loc=
k

The power state check in amdgpu_dpm_set_powergating_by_smu() is done before=
 acquiring the pm mutex, leading to a race condition where:
1. Thread A checks state and thinks no change is needed 2. Thread B acquire=
s mutex and modifies the state 3. Thread A returns without updating state, =
causing inconsistency

Fix this by moving the mutex lock before the power state check, ensuring at=
omicity of the state check and modification.

Fixes: 6ee27ee27ba8 ("drm/amd/pm: avoid duplicate powergate/ungate setting"=
)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 4214f7314963..feadf604b474 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -80,15 +80,15 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev,
        enum ip_power_state pwr_state =3D gate ? POWER_STATE_OFF : POWER_ST=
ATE_ON;
        bool is_vcn =3D block_type =3D=3D AMD_IP_BLOCK_TYPE_VCN;

+       mutex_lock(&adev->pm.mutex);
+
        if (atomic_read(&adev->pm.pwr_state[block_type]) =3D=3D pwr_state &=
&
                        (!is_vcn || adev->vcn.num_vcn_inst =3D=3D 1)) {
                dev_dbg(adev->dev, "IP block%d already in the target %s sta=
te!",
                                block_type, gate ? "gate" : "ungate");
-               return 0;
+               goto out_unlock;
        }

-       mutex_lock(&adev->pm.mutex);
-
        switch (block_type) {
        case AMD_IP_BLOCK_TYPE_UVD:
        case AMD_IP_BLOCK_TYPE_VCE:
@@ -115,6 +115,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev,
        if (!ret)
                atomic_set(&adev->pm.pwr_state[block_type], pwr_state);

+out_unlock:
        mutex_unlock(&adev->pm.mutex);

        return ret;
--
2.34.1

