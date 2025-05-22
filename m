Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A00AC54E90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 19:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3863810E1B9;
	Thu, 22 May 2025 19:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YxqVeKJ+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1C310E7FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 19:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnCrmepgozmAD7ohzeikT/hZL8+GWV7DO23WkCKgyh3oxenOMFSUiX5o82dj09bOW4NSOeC1NijhyUAp9qBUXNqWTOOWmhimVtY44cRrRFTQGbp7+v5juBsbmVjBNGEazUGrmYBa5X8y+2/uEqshCzx3Lbzs05y1G5FN5NcTF0eruN9o3a4rez1h+96UNfrjlvv0GG8Z+GFavVHoYU+c7RJVTmjDclo0FID9qf3Rw3YTCD7K/tSxgnO5eCwyiXKcNFNR/ORVeY82kVB5YdkEmHPk//WCUyyklkt8L9920aBmlS0Lwcaylvp6DKPrx+jCvMWNETQ+O3ri/Hm8OiP0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2lc9BqX9+VRM6DETQnhHe/borYt9sOXN0fSneXK0hA=;
 b=iYqx6mf2o2f9YvIANOaHTVQcSGihq2Unj7UozFKL+7m1iVjqLn6sg7UZ/txZIQM9VkLHdWB1ou3xpWAVpMrFF5UtXBMIdr8v0YSFi27I1OvikOeE4D4u01luZlCtStB0AZ0CotuOofj/h4NoNo5Mp7RvnSUXFN1Bu/P62BRg+BRfS9UrdrZ3too+NhOUK1QX1PSVKf5z1FJmbmaCbaADNe8a7K7dWtAahtE/H1q9geCrG/XyzTRDvklrj4bKzs0GaiYXubvg4Z3uUrPfA2qG9yiCBp0GsQyJUec6oo0Y8BhofmUryKsgWf3rxIZE2J1DSVAn4MWfyo/DEKH1CWWd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2lc9BqX9+VRM6DETQnhHe/borYt9sOXN0fSneXK0hA=;
 b=YxqVeKJ+DpronbKBuw1fchtaOqdAfDBNdsYqW6oKaYsJifkYk2j9wLIcwKdYtnBCEeqkvg/aCs9UNNaV9Vc26y+dSjJN3L0h65V6oPEdzjezx7YsV80sjix2AI8cSbh/IeAoqcWOtXjQ4925KLrIGL63hVhlorIatQmsqWTGtdU=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 19:06:01 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:06:01 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v3 9/9] drm/amdgpu: read back register after written
Thread-Topic: [PATCH v3 9/9] drm/amdgpu: read back register after written
Thread-Index: AQHbyo5dnra7n832TEWPYbD9M2CsSrPfA9TA
Date: Thu, 22 May 2025 19:06:00 +0000
Message-ID: <SJ1PR12MB6194E8F5D18C84BDA74DCF609599A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
 <20250521202414.18251-9-David.Wu3@amd.com>
In-Reply-To: <20250521202414.18251-9-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=212c5504-90bd-4188-a302-8356fb050efa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-22T19:05:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|DS2PR12MB9614:EE_
x-ms-office365-filtering-correlation-id: eefee1c5-e2dd-4cd1-4ace-08dd9963b13b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Fozkifp2WqTH9CuOMiC2ThWY25IgCXPMrRJwP/bRs5vWP+YpmvGeNvjnfivu?=
 =?us-ascii?Q?TMU9N2nDLgvvcPo4m74FgvoGhRI1gBvyPrDQ1OOMdvGaFiB24hSZ9rbNwRtK?=
 =?us-ascii?Q?necaV9qM8CzhZVI87jtN9dzj37Yv9nzGDwE8adDI8sPyLn2Os9/i8oYNgWdJ?=
 =?us-ascii?Q?XTQEm7KYBR/UqeLFJR+GHXo2gpqh5nlbERjKNWHldn9waVWsOX7Mt5wewv4m?=
 =?us-ascii?Q?OJ7QPU7FD9anMjYUbsR3EIGtK33yh81ZnxOTRNmc0HZvgTzdHTZLDHGVP26R?=
 =?us-ascii?Q?/aeW7P6RW1Y/kjRjq/uDACQxO85CJYz6+IS+uoJZEqMBazV446VzAI3YsVqQ?=
 =?us-ascii?Q?4wHw/EJysj8DRE3PXidQBWxP4wxHOFyhGKNhorYlWiQIwI7Dd6k+bB8V+5ln?=
 =?us-ascii?Q?ZKlSiyZbFi8CDRP7h4gGXi5oRzWWdjZUQKuErKHj5OvMRg3IeGGq+FjF0jdQ?=
 =?us-ascii?Q?jsFgcTHNFBE99/px1U6V/iFFe5twlnjNQqaUqnNEEZGpVlkBClTlSxIirptq?=
 =?us-ascii?Q?fH5MmJkaArWuZ5pFwQhMaBc10p7VjO8dRgMGLt/pJ/F9cvhbt62GhyvpCtZK?=
 =?us-ascii?Q?TItp5H+c5JDRgeShCOTKGc336O6CHytHiDsrjhglAxZ0nYxJ6k/X+NRUCaLT?=
 =?us-ascii?Q?Jk/b4sL9b3stpZOYRLUnS6GEdIjVe4JLhlN99wlX9wZdmd8j0CVSSxeSfQlI?=
 =?us-ascii?Q?oWmiVV/SSqHvAJBUtU/DKcY3aEvWOHIz5n0gWHmjcQrtkITiv4Vi2wvhlP/U?=
 =?us-ascii?Q?gpM9P2AP2fN/D4JCd4mO88/ecIxVNuZYUS6qUzZxLESJaIb3HV9Cq7zfzPmy?=
 =?us-ascii?Q?PYmBgBgDOUgxP1BZHv8oHj9FpdK8j10qlxlDdT8Iyr9xp2WUVOQl2KOf+62m?=
 =?us-ascii?Q?MrGN58RU7uraMHYsHIddrr4p3W8xL+Pc+8T0XbzzQX2MubnloKxb3tkG51aB?=
 =?us-ascii?Q?cozubWrAliRfs5es7dUuid5cY6xkRF86YqXflGXlqaiAmhEnFdgZaeb4dfSz?=
 =?us-ascii?Q?nG66UvYSGAg2KV1C81jgkEchrbphXj3tL2eAfrUomikAyOJmcKpnEP5WSXHb?=
 =?us-ascii?Q?kxGt8yZ3FT7MMovA8OKDnsfKTtfEjlz3rf9+kjnEglaTj3xC7gNcseiydTKX?=
 =?us-ascii?Q?XH9PncWSW2A+x6ZEsP4R5QNq47boRmjfGQlF/29rAJxhTBqQs3Gcs5ieupYd?=
 =?us-ascii?Q?et3+GzNHZANdOVKxEZSsT4LLWzV5VTqpQXgHju0On7+RBQpYNI+Yjk/Fssap?=
 =?us-ascii?Q?QrU4rztW6cwh+LHsFR6CVTgMv+fYK5IQUpurPCozMfOtW/ss93kwRapImQNX?=
 =?us-ascii?Q?SiowAayybM81VG+9OiSTiNIFGtA9fcAOiUAEsTJZgJK9UtvDWayKpE3636he?=
 =?us-ascii?Q?HAqzvMD4vLURTiv729sR3Fz+ydUJHv5eC9iwocokUMm1LBeSOrMVbZtDtFO3?=
 =?us-ascii?Q?j/SAHj1hIbkzDoWkAwy6ljGGft55BgWKrLMG79y2q9ptJd2sfsl/eg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jJfICmEk10Xa1SI41HAvJcLMP1elkgJSizERpGQqPBnc068iLAgR2krDpNSx?=
 =?us-ascii?Q?5hkDvlq8/za7vsrObZ5bvRoe7tHF0d6r+TfMuDo0e0YuUwT2kiN5Fe2UTtZj?=
 =?us-ascii?Q?eic0IUQu3HW9yCE5JDiBdsqiVEQhRAG3edIiHr7Vr5Dmy/oz4D2CYiSS5TtM?=
 =?us-ascii?Q?XffNn8WgNmBkOTuqbgyynyZzI9GICczhsCjEWQJOwMVuMDq/hiL/cL1fBGN8?=
 =?us-ascii?Q?SPdTNFeJqYws03qV+BZ0KigEyXw95ju5WRJGb4X0pEWDGwBSPC3Mh2pndsfk?=
 =?us-ascii?Q?U8tMiMkUx0kR4rLbKLMnHZctZYW9Z59mOMLyyIaxqXVWYQARfZrz697by8ik?=
 =?us-ascii?Q?iioF7rJGpCI6zZGRbJ/rB7Mle0Xy6jlHk23qFtAnBEHX6mSMOMFOFrhfNjbf?=
 =?us-ascii?Q?uZzqp4xFA2yXlu7wdsiQnbQyGoaJE+TKcRcTIcBSKHtnnI9vJoMLpb27Zvqi?=
 =?us-ascii?Q?CvoNk9lRcyN2uZwvS7jehGxV/kS2GRVyQL9nUcny5chanumi53sjs1Kz11SA?=
 =?us-ascii?Q?dzYLKGxTcm9ch48JvHyXjIcilNhnNJT4TlZmCz2ANzgGXxyK34TvX5Wxm5cI?=
 =?us-ascii?Q?xORUX32EUbIws5+FQb5nJ+vUmrNdQqXCb05xpxYnPYaxVoCoeEnsCmpErjQg?=
 =?us-ascii?Q?p4mBro64seghzSpBMkf+i7zcfif81gkrsLOKKcn6EVXjblpQdkHFc0bZjhou?=
 =?us-ascii?Q?fKJjcsrTF2GwYNokxyNU1l8ERK9iiBAfKL+SH9UhHaA/PnOaZcDmp9S2a0oq?=
 =?us-ascii?Q?cmqFP45Wj3yw7YTa2O4kT/na7iqPMqGMsHqX0dKncGfK5OrO2wjrPKgtXdBh?=
 =?us-ascii?Q?bv+HokEaJ2uvrreCXY9XhcEty3XraAtZ/sdfZmPKQMbwLlRxI0Y0KpjwGwCl?=
 =?us-ascii?Q?zrULMMEr/xlDHtMx2p7VLijo3UlQGTpWt+j3NFpAKM4tJqnFFreGtEfQ03Zd?=
 =?us-ascii?Q?b553r6ee6wNzfx8R7Tt+AQdKdj0YWVn4enGzGGv3/TAle+jjTu/B+jSksZna?=
 =?us-ascii?Q?AgtJO8lUcBxQ+Nnw4RPMVikYwPmhLCfIr5NkIp9bXh+b0HvyzH3lp9NJBx7j?=
 =?us-ascii?Q?D3TUBdaYJ/Uu7llAYx+EbeA0g8FSlf1jDZHUtT9ClaaQNOeY9/CebX1GG7xy?=
 =?us-ascii?Q?mLvcT6eGt2aQe4HVgs80R4Pk/SHMXRH2oH+MEbDomfAnddtkAFNFlT2kEB6F?=
 =?us-ascii?Q?bNYkMGFJ+P6MyCp8LGqBjuL2/jfiA2OwgEJwBPIb1nDO5ESUYGZxHE51DdH1?=
 =?us-ascii?Q?OwUxDAFPXq0JK6VSn5Ik0x02GBgwTbKnqPMDX3vnTCg8gmAxVwYkoIqmOGrB?=
 =?us-ascii?Q?cpYviNv8sB8unvaSvIuAaImdZQ5u5cm5J0u/Y3MsyGIJKWTVnadwr2dIEndt?=
 =?us-ascii?Q?7jWDuYQCEjVQlFepxKh9s1YIw2Fwk7Dv21zdJu3PQYlIa5m49rn6MwuKfBZ9?=
 =?us-ascii?Q?KFc6b+fUQB2cH9o9SbN4rFadqEAhumNRHIaC9sbeupGQ/je4uIdJ3ZYEcs1P?=
 =?us-ascii?Q?lQGeQjK4Y4XAiL2c4j//YIy41ZARI53E8qdMyZSgw2/TXYFWo00U2/2ReGkN?=
 =?us-ascii?Q?zgir++7P3A0EtA5QZvY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefee1c5-e2dd-4cd1-4ace-08dd9963b13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 19:06:01.0501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ho4KsNzX0YcUNzlNaV3lKYtk4xL3PbdPRj8YFPL/CF8NvC6TGyHZwmI/NKBO/ZAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614
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

The series is

`Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>`


-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Wednesday, May 21, 2025 4:24 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>
Subject: [PATCH v3 9/9] drm/amdgpu: read back register after written

The addition of register read-back in VCN v5.0.1 is intended to prevent pot=
ential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c
index 1e9d2aedf2799..338cf43c45fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1038,6 +1038,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *=
vinst)
        WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
        fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_=
HOLD_OFF);

+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
        return 0;
 }

@@ -1072,6 +1077,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_v=
cn_inst *vinst)
        /* disable dynamic power gating mode */
        WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
                ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 }

 /**
@@ -1147,6 +1157,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *v=
inst)
        /* clear status */
        WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);

+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
        return 0;
 }

--
2.34.1

