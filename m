Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DF2C3ABDD
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AF810E64A;
	Wed, 14 May 2025 17:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iT3Gpfq0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D9F10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPWjNcSN8SnW1TX9BItW15um/kR8X+up33DlzTkH1RYBgpPL40fAVhOan1t6S0PtdvoYkSzgE987kMO92uDRgvJkGlZEqh/OGOmWVXzHyY8UvngTCo0gozjUlz2k+C0nEPhsN3TEG8/nOIFWaGOwo4/Y7iXjj2nCH+o/Twjb6KO6IQ2T8WbxBT6OMll4DqF7lUv8AERFQ6dU60QY7xi8Q+MliJXjGN+Yax+mLXSVZ3QaBovWE7/xQ0N4AQ8P7qyfg9GLJDrqZG9zP+/W6GIIGwEyTtqNi7qRzw8gm16uAEh0BzaiSTLWtacmzwQGxMd9yZp9dm5F/RfsHmSTwnQ/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pujNGzFJqELn2nRKRaw8Mi6y4vp88jbGbaX1TJ8+TIU=;
 b=RQkvviTBGyVVBG36rcihbyx3unVqevtpifTvNK7QS7h6iZQpBWHy9pE/Wye0zvN/NVmAd9AcZfIBgerNGBj+wCmK7dCRCNeB7c6jPj/Nq3PQlHuI6sCoeyPXXqYvfXf6m1AeTqh60b+aC4mMakooYkWg8xHGVt1JnScaHzqETxdFqS9uKNKOr/5Z2MpFYfHYd1/+kSrDdYgfXDFnbX27pDEwoVFkWnd1orP9A+Vi2cXQfm5lWEzDNa8oLxtWAF1zbCB21C1Im2RtTLPy4/dSX9Q5y2oqyxbWxY26ALRWgwrbFCmMgTYnZHFTG4flKiv467Y/FvtqtaRUY87GwXlwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pujNGzFJqELn2nRKRaw8Mi6y4vp88jbGbaX1TJ8+TIU=;
 b=iT3Gpfq0Dpm/5fNW3Po3Vl7kkAjr1hxEHWadGRBlbxzSBxY0LvOR+ZGhazFKKyh0kH5Z744EOo4vOZzJN0x5/96dgVP+aD6qJ998PS0THmdUs2WHe1T6RSOaiDQIAlVAVlvfIGWXLwTyuSFqUgel/AxemJXQy3uEuk43BMqd4bQ=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 17:45:35 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:45:34 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v1 2/8] drm/amdgpu: read back register after written
Thread-Topic: [PATCH v1 2/8] drm/amdgpu: read back register after written
Thread-Index: AQHbxPTbOxW0JHcTDEavZ5pyxvaUJLPSZZeA
Date: Wed, 14 May 2025 17:45:34 +0000
Message-ID: <SJ1PR12MB6194AE80C7658445112647B89591A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
 <20250514172251.726484-3-David.Wu3@amd.com>
In-Reply-To: <20250514172251.726484-3-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=327e982b-d0c1-4b4e-874e-f788cc30c9fe;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T17:43:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|LV2PR12MB5989:EE_
x-ms-office365-filtering-correlation-id: 3128f534-3d1b-46ed-4533-08dd930f2134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?81ilSEZq0AfxLrISWQF6VWBPDQza073+HdyJTU2mQGxv3/vRDOd2ZKZJyTrP?=
 =?us-ascii?Q?+SVqTPw1HLhXYhUkCtvOwO2q97qSWsqt8Up1qrZsP2lq7OWrRKWuHqRqZqSU?=
 =?us-ascii?Q?OrEwwQYPDVlAvuNRNwoXEImWteaRmaW2/yLm+Luvjr8RzsHhD5DM1yHrgj6E?=
 =?us-ascii?Q?TaokyTQR3JNlQAwCvwQy5zbCpzf0mTUSpi+mdgaNunuVf7/kKcQWDRGinFXQ?=
 =?us-ascii?Q?avGFB5HZiwUUiJQTVxBny/wPt+L0uEgrHE38sz3Y8fPryMf+FemlBdZoleQ2?=
 =?us-ascii?Q?sZ3AWLFmrNr6MRDLVFm34Veubb1CrSTZoSnSIRo+06Ns9ysKFJsEVsfW3q5Y?=
 =?us-ascii?Q?AzlQB/5gTTRe8iKeb8vydY3mDBo0tqfu60/abXPfAEO8MLzCs1tgE0K0rpwy?=
 =?us-ascii?Q?SYTA0vOdCtegxaND41OHsZMTYVviQeuqPXBQKrkF0wwVOrbVqbJwCeLkO6BZ?=
 =?us-ascii?Q?GDNSgf1kOm7nvGVdJZt0vziA9a9Vz6WZXXVdm09ley37kdPzOdnPvCOfbYh0?=
 =?us-ascii?Q?g5ZtkmtlQzrX9XpkqOMVifSg2LeY2b6a9iO+VwBaOwvuFG3Sm+K/dNt1SEGZ?=
 =?us-ascii?Q?14CwMQdUIboaIGdyEereNjbp0Knaf3hp6i2MBdEJkKHJPyeFO/vpyqoLH/5c?=
 =?us-ascii?Q?W3k1qHewI3PQ4+e3nF3IVWA77ZxKzyJhwVZjVr9iMoO+UleSTmvM0OMnUee+?=
 =?us-ascii?Q?8DdvLb0U6Opedco76wodcOWbqKYR6JbpphYkRY7gCX/9Lqs6sNeAJv2w3eFR?=
 =?us-ascii?Q?pBt4aMspZlJV78G0xPsj5t3IywOfo6rJNcYADwVzSUqK+eEuw/ZTPAbSUeqT?=
 =?us-ascii?Q?OINumMzA9/BAiNdtw1NYx+aetZDiXjZ9txEb0OZVuo+yrBL1vfSbRbNkdLLP?=
 =?us-ascii?Q?plBzpNxBnnsRjd/snIfeCNo2baRbHge9UnDWD+c60+UtRHgwgxlTR+MeiGJj?=
 =?us-ascii?Q?GFJ+CPFoCzuYHwkbQ82RkwL0Ys78ktKgWvg2W7i+auBkkdVBEbUzmO8gzeMo?=
 =?us-ascii?Q?FFz4m6UK4mYXZxzRqhcdIjVzbnEEOpROtM6/aWE/i6GIgfiNw0odLez7tsIJ?=
 =?us-ascii?Q?RGRVKoJTx+iigCI6cPxlsIQjyrhlMUd8fF6nK9S01PWoU4C6CWPKziyHukW8?=
 =?us-ascii?Q?6LMAb5Fc1NNDQh9dW453BhSKhzPhCMTF2vsdMqKKU61mB3U6r4W7HsgZQE/f?=
 =?us-ascii?Q?887RRQmP4+jeUelHD1pjk8YLAadsxo1VU1sMCaSzucbk/YZTQgTJ8OqDEIye?=
 =?us-ascii?Q?C/PygBBGN+nBXZsPoMhsCFXlRYsFh3zLxgauYvzZyuxoLraoAw+vMscBYN/Q?=
 =?us-ascii?Q?98hKpDFx7uPG+YY0ZsQ6z7Zw/0Cg4zbEQYAiE3dtl/hcG14SMvx1FUDybQU1?=
 =?us-ascii?Q?eVJug9Ttua9UjBZ+p5DC40BpFsS1Aixu3BqQMFC1bZxOVwQ0lsBPPTreYJ7e?=
 =?us-ascii?Q?88GpeeWU2IWNsFFmeHnuefZei93ceLhkbA5aZLNS3RopL21dFaBavQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FPqSxmGr1+f+Q0OP0hZWGboMtI75hWWZTSxlRVZI5urM9PlOYtZNuM03NDj5?=
 =?us-ascii?Q?G57qM4BLYuxbhEzVXBPzyebRI4M3itIxxG26G+f22Lnb5gWBOC7Jzh3ddZh2?=
 =?us-ascii?Q?IGAqzrXBN9Ss6jrfp8UwUxjaed5nix0KTO09Day5DLMh7UISAQvRbTMVgXCE?=
 =?us-ascii?Q?woLvtacIeFCFe8PonM5qG1mVX4/AY2tqMFkTWwFdmqCOPxIy5FTIRPkdxoXN?=
 =?us-ascii?Q?5vPP6INNe3InT9wWYw+4/nEHWxCybrQBaPaUindSfzZuua4CB++QNGqzsFZW?=
 =?us-ascii?Q?nHAKLlZvPB/Z7YM+ASYo6EB3ErcCb4UXLW0rWXm3DeMWKhEevVmnz9BPoKPz?=
 =?us-ascii?Q?dqCG/yq717DTlOFFVSliN+Zg/Xc4oho0fXHxxsfF2B453fsZNS5yPUhjIKTi?=
 =?us-ascii?Q?utMb2wJR1K+MQyTdhiY5DSw2ui3p0u+PpU3mXtD27z6P3TNKBwddTIzfw3Ab?=
 =?us-ascii?Q?v0nfL3Zz8EIzsCQCvpN/as/iiOqVkdI+IS2TGl1n97xtfLOLjkSdAZDoEh2U?=
 =?us-ascii?Q?yiWuR4cFI9qnmXlYRubjPx+XGGuYerUI6mozDDu2LQ+Vmh2YzLS/bkstYCbJ?=
 =?us-ascii?Q?tfssMaPnIJdv0BIF1FBwgq68Wa6DnCb9K9PrySi/GU6CVfi29wZOUxKv+eQn?=
 =?us-ascii?Q?c8WRuMAQibqwiAXDvm8swHY5dacHpbFQ+LNRf7+ct+SW3nbFrYF3fVEbo1bL?=
 =?us-ascii?Q?Ppdh/eaRPCFNHzJDnYXTxV+FRcnmLPWZAEdlOL5AjqunwtFdZx1tTWcmpRdw?=
 =?us-ascii?Q?M9iBuckkOmL1gcGhkERdkuRbimZD2hULo9PpMSrx4uB/lujsX1tRLwcRfK+k?=
 =?us-ascii?Q?+eKAfxHL0sFKd00tHXhRxg3+G5ooy4z1Y9SKDCS4P9NV/uDrYo5Xkp6LJ2Q/?=
 =?us-ascii?Q?KbYmVtmi+tX37QVgA4b+zDUfR4SjDQYgn1HwR2WITJ7MM23VhNaAChCmeAd1?=
 =?us-ascii?Q?4SxDTzn+wlXSUpz7mtkQshdFhvpHh+yRGOZYwLdEZqttk8jFSmJDbA1Monf0?=
 =?us-ascii?Q?twtmxcDfkt13jW9nHqJ15Jch7FF/rQg0lQ/p7ux7mJvDKPqGoM8zjIn+MJHP?=
 =?us-ascii?Q?7L+MmpzplDr/gLRZrW9LFodcKqMiyUzY3aDLm3Sf5vsAE+9VgN2QWjxOmAKK?=
 =?us-ascii?Q?sgBJFbazdMFTvNt+hKQmb4Nir7DGcqyU3NqKK8guzRiV08Xukqis2B1ayJEn?=
 =?us-ascii?Q?ZCHaZqgvl8rzy9nWauYhgITbaMGubtRnpHsCnZDi5KCJg3JzyoYzDXJUArkY?=
 =?us-ascii?Q?QtZKjLyuF6Yeigp+eV8+/Rw7OB8OvaOnPH6gPP+ouyFtMCGh7nju4G70QZI9?=
 =?us-ascii?Q?YYBZRGrMrB60RNEVrXCPT6k8++Iok9qnStMti2QFJ/IgZ9RxaZ3spVcSKQ2q?=
 =?us-ascii?Q?JhLkOaWhEr7Aplng/wdYXIuAht7VlgPyzjR1w/Bx/FHO93b7vA2pq79M14Au?=
 =?us-ascii?Q?kE2Okdw6EXqqZJ7CFfTZLBDIk4KCZ033t/0B1jKSiBc+X1oR9U8G1fy5L57i?=
 =?us-ascii?Q?RMyQkdkc5w9Btd4TlEVm2soRJoNWQcxzBpMZaewI/pHnlnXnW+zwOMubShqi?=
 =?us-ascii?Q?Hy1RqDb4TPlFxghp6Jg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3128f534-3d1b-46ed-4533-08dd930f2134
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 17:45:34.7051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxU/gtUKkaBo9p0G31o+m3Vc0x4lIK8RXTCeJbh8bHrKAXkmPODt9X51IKBNmlbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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

Only in start() ? what about stop(), pause() and etc?

Thanks,
Ruijing

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Wednesday, May 14, 2025 1:23 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com=
>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>
Subject: [PATCH v1 2/8] drm/amdgpu: read back register after written

The addition of register read-back in VCN v2.0 is intended to prevent poten=
tial race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index b8d835c9e17e..e6a008d7e67c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,6 +978,12 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_i=
nst *vinst, bool indirect)
        /* Unstall DPG */
        WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
                0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

@@ -1152,6 +1158,11 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vi=
nst)
        WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
        fw_shared->multi_queue.encode_lowlatency_queue_mode &=3D ~FW_QUEUE_=
RING_RESET;

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

--
2.49.0

