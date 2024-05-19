Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1065DC25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 21:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42C010E064;
	Sun, 19 May 2024 21:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJhZkbfv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9BA10E064
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 May 2024 21:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4PudEfLqcqFW580Byh3fvwmGHQfntYxNm51P12xfaHREgnSJ4hCK6dMrhS8lkxWMCevaSDS9rpldaYeuvhz4r8A84rY/v5nmgdf79KCb+bVWtNNGup/UYJLvcR1het886xqZe9iVEEumcivmj8jFctjaiWhW5DAqQERpPc00Zo6o4am9OA6ZIOHSWnvnR0rtGfwT4Xk6ZI30QRw41lq7Ued/FeJ+XIT8yU74POPYRpRQRMEdj0F1XeKVEAiQ3B6lCEpOiLn0QuLVxsGVuSZksbobt0whckkrFvHHN5Z4SSqGNc0F4DlQP7yk3HnvZBOHqlxSWP1dDXVSnoAxSTSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpaiAxOn0RY6gQPvIikKjKMbCnRV8sMw1PaNWJ89Z/s=;
 b=oRCPVy+tGnVCt3AK8Iw/RJmTBoiTrkI+a/924TNbQayesVM5K6IuE8w0NQz1r7cfTpHe+8Xx2zgycYbBHisZlEz+CMFyMrUUH07f7KQ8UpMt4TnveKMJmZu/epXnrwKrV4RgKB8w2jgCvlBYN/rHFbQ3QTP8N5l7vaueUOEk/9cFN97lkQEcLY60q79nGNrT1DF+pMI0NsCAeWuYdjCC04aXMrGelGiMDU/JRAbkmxcpQDUz7xd7T8l/dSfDvAKX3VJGmgbYx4hcaTzBTXPMCqrNPKV+nbZcwLRkMcmKu4jpsjcZ9U0tA3jes0X8Wjq5YRQbsQRBynlxJTVWLfNMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpaiAxOn0RY6gQPvIikKjKMbCnRV8sMw1PaNWJ89Z/s=;
 b=kJhZkbfvw3tDeV4Ks24qE9SmNuvO+F4VwnDVjShErPaLlQJUBHyjd7SeHdpMNAXLGkD0uoJi9K/HQA8UaTUj3FI2m2XNtquhdPITRlw72onadLBAx079MuljBa/rlhmItxlDkXFPWu5cP/u+vo0W5Y9YDu3QswjEa38DovrEP3M=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 21:54:10 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::1da0:d5f:3177:1fb9]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::1da0:d5f:3177:1fb9%5]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 21:54:10 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Extend KIQ reg polling wait for VF
Thread-Topic: [PATCH 1/2] drm/amdgpu: Extend KIQ reg polling wait for VF
Thread-Index: AQHaqfw5nhQ5VMD0JUeZg61Mpn//dLGfGhCA
Date: Sun, 19 May 2024 21:54:09 +0000
Message-ID: <DM4PR12MB5328E92364CD6F59D9B70121F1E82@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240519145221.623701-1-victor.skvortsov@amd.com>
In-Reply-To: <20240519145221.623701-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c106cf8c-6f8d-4794-8197-5d3426c00e3b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-19T21:53:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|BY5PR12MB4145:EE_
x-ms-office365-filtering-correlation-id: e8374ab6-639f-4911-97c2-08dc784e36ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CnbcklHtlF3nagQL8b4cypo/ZnbBQwHxmIBUu9rPuv0vAt2E5tWyMTiB+RQA?=
 =?us-ascii?Q?2L1u+5wA6nXa0oQ1mwP+Ca9HCcnezM680yp6AFLlj5qpSVdzuNEWe86hJR0I?=
 =?us-ascii?Q?d+ld0isVvX8GDej7X4eCpgH2W/gWTrcK4k6ylyi0XN0jU0cg/51LEpTIDHX6?=
 =?us-ascii?Q?2QzWHM6SyMZ5To9HoMAIS9u70+HiX8HwgM5VBra/B4AG2m6TYXgW0N68fq/6?=
 =?us-ascii?Q?o7VQh3ma8oFEdIBKLXBIwTDEx/Nv8QSceAI5VS/vdWlRUorlens+LJb4x/dY?=
 =?us-ascii?Q?PlabzHKV1AIOdv92X6YNzH8gxfZTIvEHGWiNZjh1oZeMhHOcec1UsuUckGYY?=
 =?us-ascii?Q?lE82cf66DQSwOhPoqI0zvPMYeieIOHNpq+rVwEzr/44tiATyCAupZrvlRMzC?=
 =?us-ascii?Q?xPIGfSJClactAi4kBzlgmtMf1PMkW6KIDhCp/15Gyxgt7F+zqXEPXKZ77toi?=
 =?us-ascii?Q?sxGLQ43KMZBPq9B1BoayLOhb+zTnDp8yCHPFdVd+PcK7b7aist+dTNauqM2v?=
 =?us-ascii?Q?kMLS85qRQ2uep+g1kO6St2mQPwRC2jLL9ACVoxAMt7CA+93KKLCEWejft3fG?=
 =?us-ascii?Q?BRmbrsUV/WHMCh/IkiOuzg6tEdtSl68YwtCiE5m6Zsi3DFS0TPBjzDZZ0hnF?=
 =?us-ascii?Q?U7DtSHsJX++TTjqQsF/IwPwG3vL4mVfted9bpBJ1UYOsLgktEsFA22sYKHdA?=
 =?us-ascii?Q?UWH7o6HCWCIkWx3SsF8sjN6O3jcxBzPrmDZkARopdSYbZMB6Q4BjbHeAutJO?=
 =?us-ascii?Q?P7yuB+SD6G82dooGa5D5KGhXsaocJ97Sn/C22tfgED/UPkrJKuF2Cs+s/p32?=
 =?us-ascii?Q?rUU66gdsmuXE+5RCDZ7V8OnBxtYnDOKuSvoWfN2Xqtom0cxKkmOu+ZeJe6Mu?=
 =?us-ascii?Q?2p35YjxRF5DObeLeTI9dkZNqGzAnrQpPitJm+pCsWUvrUHgndo7YTpYsFEBk?=
 =?us-ascii?Q?6SITHV1t647IZa5ZFHnPL3mtZmJWYDFqdhgT8Rm0xWHVZAwCmoskyMhwVfvf?=
 =?us-ascii?Q?eeL/ZYTAJINkiklMflCDnO9gKkDERLhE04d2nvz8/8xFHNRbmtsNO31LeP9m?=
 =?us-ascii?Q?r/C3ZJKcaE+BWZVB7Yv+596ooSeeZAal/Ohjw2iNWeKi+3Eq2wDi0HWgJwG1?=
 =?us-ascii?Q?NYck7h16qkz2lXrb688pQYQfoOacxbuCw5vBb0U2ovXRpWYygCI/NY8EXCEw?=
 =?us-ascii?Q?iEnHy1AYwmZyhhEuKyTkKSKdUWFzWLS/T94ouNB+i2vdY/0vxfbnOtoRmvY/?=
 =?us-ascii?Q?mK4rHIwn5CRsC1VYFLCLif6eXIhcI57u7WI3Vdt3tXTMYUSjyQ4G8RUXGyOs?=
 =?us-ascii?Q?1hK2/C4ucmsUzA7tKZg2ADjJGFM2ttv7frTRWWjuyH+jAg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uIPlsBpXX1AeAA7RvT06cE2cNajF28EdIk05vbNKrC5jChhesXVe56gHPs1h?=
 =?us-ascii?Q?toSQRvQl4wRKYTA9218z1JyubPqw1tvE6A8N1zheZbmGmk9l/tEBVKAWUzTf?=
 =?us-ascii?Q?ndY9p1SJ7QF68gWgpWAGm69JOObj0QkXI73boDE0RsfBIOEe/EDUhUzgOne2?=
 =?us-ascii?Q?e3QIhPOUMDuN9XSENzXwbjIKezn+5ahPGWV/Tq8TpiWbhg7l07hzkadE0CsV?=
 =?us-ascii?Q?d4gnMjr/vqsZmiTPaotA9bAz748cgXfY+EPF5TtSZO1S8sb7YPQzjYvh66EX?=
 =?us-ascii?Q?PEUzal4mLWjHgvyTZnK/ECYjv+WVsaPS2FeA9XFR5e3rTDpXP8o/w0i4o3lD?=
 =?us-ascii?Q?MGKdydaG62hzwdi5SQkzZNo82xB70wbabgwqcPRcY+wsjdvfENDTGetmPPXQ?=
 =?us-ascii?Q?euY5OfS9X9Pm7kjzOc+j5MS0V0QXcGarHkvyJFh2e9afb1K3G9J2VwpkkKLD?=
 =?us-ascii?Q?gHFuiiBUlPcmsnRRvX3IN7LQ2f3eEqXFPCwrRuVeF81RD10RcvllkcMKuiYD?=
 =?us-ascii?Q?JwT2ypstMyOorzURqYzpjsmdk29GMZhXYYxgNs9E3rWD+KsuTHv6VcypegCR?=
 =?us-ascii?Q?6pRqh3NU8oSucNE04aIkq88Dh8OMR3vpfEYw6IQQoN1T0AKrAd3AdvwLMNOt?=
 =?us-ascii?Q?1Y8+MREGJNuOaU8LI1YNMi+pV5JvU0nu8IK58z5JLttMq7YOLhcv0LMBsf/p?=
 =?us-ascii?Q?CT2fmAPMH70zszGenbXzTQ6feMy6QeB+SDD+Y69DimeDDaH+MLZvty71QrOA?=
 =?us-ascii?Q?7BPKJcR9yXfedytP/Z5zaPp8c+WYRfldcHvvDeSnW6LNmCGOvo/akyJvo+4f?=
 =?us-ascii?Q?EOCbnj8U24m1+T8k2vI9ptzeLPhFCp+ApBKWxlD7QGQAAq8fSh+QtAx8WYRU?=
 =?us-ascii?Q?Zpfq0z0G2+VzPx/Y959cRfTISpBbv0y0/c8Ybh5CovIsDOoFUjLQ3I/NPIK2?=
 =?us-ascii?Q?wCCrs+9Do19E9Cv1NT8EnRXuM4nlHKOQKfZ7AV4XSkauPDJ6M3klJ9al/2qX?=
 =?us-ascii?Q?FapKja9ap97oITv+Ik5ZUdU7g1Sgc2L0Id4X8pE0u3e6DvbPFTaMwQ91CRmj?=
 =?us-ascii?Q?Ofqecu1hRDH6uR4Wn+dtVnVX+S1Pps29uvtsvY7IXbLB4Tl1jEoZrOzUJUpQ?=
 =?us-ascii?Q?UB7J/1667/3s1HJeUXtL/18OmnhLhK+b/itIBow7KlLUqdhs3X18qWW6yR9j?=
 =?us-ascii?Q?uR830R8gCgddRHcxEDiDyHfHjcz6YtWao45eflzzAFnpnY5Rkbqw/eP6XMe9?=
 =?us-ascii?Q?G142TGsA+skMCcpvOnhIKtcHNFTkV+BghKCHsSBJmRFt8S8Ok1I2ZYS8ZB8n?=
 =?us-ascii?Q?c7/0I+bVBS1jmJ4JlebU8vSlmOfAkUivDKIFl156Ctvg91lDqsOuvLyXmm6K?=
 =?us-ascii?Q?LeIE8871JsZVQw3bci4utwSXVPK8YjXL2pDWGeQYSbTzO+X5NkDIZ3bn1sxl?=
 =?us-ascii?Q?YAOMW8Y3FcVtHrL7nvRyMj/kN1LbgkjKTpgm29SHC0m4sL187/VigFSkg9Ck?=
 =?us-ascii?Q?rX1fbRRGJhcXaozZKUk32Af+izpHvpnadbmr8FqSPVrAJLAICl+2eN7K4BkM?=
 =?us-ascii?Q?JutEUsC/ccldFoBFqA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8374ab6-639f-4911-97c2-08dc784e36ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 21:54:09.9667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Myw+h8CfPF8n+O43W3pP2EFYOrgeQGhmR62196hmFqjs2sNiGXdY9Lvb63eFtcm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Sunday, May 19, 2024 10:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Extend KIQ reg polling wait for VF

Runtime KIQ interface to read/write registers in VF may take longer than ex=
pected for BM environment. Extend the timeout.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index d749c6abdc5e..e8980b6009c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -348,9 +348,9 @@ enum amdgpu_kiq_irq {
        AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
        AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
-#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
-#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
+#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */
+#define MAX_KIQ_REG_WAIT amdgpu_sriov_vf(adev) ? 50000 : 5000 /* in
+usecs, extend for VF */ #define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in
+msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000

 int amdgpu_device_ip_set_clockgating_state(void *dev,
--
2.34.1

