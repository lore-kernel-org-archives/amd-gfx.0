Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB57C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 20:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3565610E39C;
	Thu, 10 Apr 2025 20:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3g8+cH4F";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484BA10E39C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 20:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxCWp9CscXjU2F+hHhRK/OcUSKSHLKJMmjppaPu5MJJIC+kOEeiW7wJJHA9AdnMsUl5QsKHpShzOePY2+fyLrLJLCuMbbYmrFiaLYSfMkl4BNoUUah4R3DhFUjD/GCCe15QD7MlzlyjuwOZR3F4pXs3vWxxN3d1qOxiTD3O4Jer9yvMourhm+H6OoUZ9YQ5mkpCeKqATYJc1qD8m95vZkWC+NRpoVRFYLeKPdshBJbPkwKVkV8QQSR2t2zyvc3yapFguAQ+MasDdta3WUq8xLs9T3SrG44x+IErjADBnTpE2aKvUQJkXDJBuxTHLp7ov/gVlSwh9dXrthyCQZbXfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQxOStmDtQDAdSoZIyg9jLzeqgbo54m+mT3/omjoq4=;
 b=dJk5jEirGBkpyhLBPhp0llKl7jdT09WPeYMBGH/+vZOjvhH/fjyIIWEprUiPtaWXwpw4/ecmrN6NhYS40U7n1UXIlDxKmvgbSrX0bZAnxQAWZ/Osv3HfZ7RV8YP/uUbX4EfCmP9ZmwlwOqf3dpIK8b3ZxPgBmYZa5yo7wVY3RFQq2N5LZwaqEOgCEOOMRy6TIK8WPy9aE8Jhz+ooVsCMGNUkW25Wn8ajYlD8HLgak07hxNr56YMei0+s9YmzhbRSz+Ee7ISRszbDaRDi7QJ+PQARNDebY78sz3Z4DqPdhCp2i+M5gekPj8RhfGRYGbB0NrJVmFkaf6iMGZ4XXc8YiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQxOStmDtQDAdSoZIyg9jLzeqgbo54m+mT3/omjoq4=;
 b=3g8+cH4Fg/PbkWfqmrqT9eHNxLT0//Ix8+sZ0l6JxaBqVRU5i6ihxQVu3SmRJWxdhO68SICeiKFk7W5HBoWMHO+05/fXF8RVvh+T68bnA39HUGZoFAgG4v5r9TRVLJgUB4uy2WqrzWOrpiMXeN33sp9ESSGAhw+QsTqX/QKBb24=
Received: from CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 20:50:02 +0000
Received: from CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f]) by CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 20:50:02 +0000
From: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Gande, Shravan kumar"
 <Shravankumar.Gande@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Direct ret in ras_reset_err_cnt on VF
Thread-Topic: [PATCH] drm/amdgpu: Direct ret in ras_reset_err_cnt on VF
Thread-Index: AQHbpKZZE6YGsTjhS0CREjkl2F02YbOdaurQ
Date: Thu, 10 Apr 2025 20:50:01 +0000
Message-ID: <CY5PR12MB603498F622FF7B6F26EBCE698FB72@CY5PR12MB6034.namprd12.prod.outlook.com>
References: <20250403144016.30030-1-yunru.pan@amd.com>
In-Reply-To: <20250403144016.30030-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5788c2c4-72c0-434b-a8c3-1c6221935eff;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T20:49:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6034:EE_|SA1PR12MB7175:EE_
x-ms-office365-filtering-correlation-id: a9caf6ab-d352-47d5-0c5e-08dd787143cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?R6R4EVSajwnx+CAWlJXyXX7s6HLiCAyi40NiWVUWUCE/9Ng3UEc7eMOF13tc?=
 =?us-ascii?Q?PNIwv2pcXmuLlRQRYYqx/9jcp3UoEPBPPz3bKp0tly4+ktedEaGy4FexHQNe?=
 =?us-ascii?Q?54sdM6emYnh57d2W9zf/GF8GoJDN3viXltX8XKCiJzASRyd27CwrqAyn9NGD?=
 =?us-ascii?Q?lJ/SYJtNE8g5EemFdvD17hgeT116J87YLzS4jgZ2ARidJarG0USoge1AQ+5w?=
 =?us-ascii?Q?LwxeiYo06HMBoiSuY7aNhFktdwqI9aTqLcE6uJ3FrawrTW/Fi8GfyL91NNSA?=
 =?us-ascii?Q?+7uhaYcY1dnYnkEDq3lFFK/SvCskK06UvCGsMwcfv6FZ2AGYjPvZbV75jKE4?=
 =?us-ascii?Q?FiJWRrMuX45ejVFav81zqRnj7DZWiTndikrYutGdyQHpJYCIsjAd7Wt/QI3e?=
 =?us-ascii?Q?5CNpiUSoJoUGCpo+3EofNO8VNbbJzxjkAy2QsNe8NgxpbCYuIzJTYGCNdDug?=
 =?us-ascii?Q?MjhupTDNyKGbVrgzxtArqX5rb6As/2vIM3OAJz5RtyXl6hlNTWrFyq2lr5XF?=
 =?us-ascii?Q?2GGo8jTSPqYmkK7fZ+X8nrfYyOPVBwInx5TwTH3gEH7Lax56Gvg/rJmpfwPh?=
 =?us-ascii?Q?L4m+ORoxu9hOxs+44uI0rUHilWnSCUQg6yU6wFWgBBsUibxYCti8jklJJ0K6?=
 =?us-ascii?Q?TRYKHD6Hy7PkGi4JxtGPaPOC4R6BwueTkh+Q7+FU3IGa/mbQan47PBN26cDR?=
 =?us-ascii?Q?JOvHwazGKlpVRuqPzjnBLMs+IkBN/TfPUbuxP2NAVen0vC6dnqJT8i6iDRvU?=
 =?us-ascii?Q?h5WXZ2YwH8sJn+EigTZLveWtGADKEJbwm/TIx7ntOZlXKmkzev9xIUPE8/Kh?=
 =?us-ascii?Q?tq2/qWlUiO6EtpKTs/6JdSuaJnaiTSVD0fvjeCt8jg7YSoX6BajUpxx+evUm?=
 =?us-ascii?Q?cvJcPELCJegVd+VcOSVBs+VtR8rLyDfDZPeBcWUhOZiLXPTa6GbBUQEisbTJ?=
 =?us-ascii?Q?M8x5d/ZqE8IOAPgwaD3eXeGSmKKiph8Lrly4lhugE0FQu3FN1R+c5PdWTTFA?=
 =?us-ascii?Q?oVuna6QMFuriCPFnW+actVEYVEj820yL/IWWNtoaKhlrLZSHEqzrZiimyufB?=
 =?us-ascii?Q?4WhjQTkwp0ItbTEnUxOLDfpelGOc8IafJOncTmIeulE0TmG1CdaYd+FxWal/?=
 =?us-ascii?Q?yjZXc/jAyRgUBHcXJELS+9BNqXDUxdQUEM2b5lx604uSv9Jj/fmorXVW4kb6?=
 =?us-ascii?Q?MTt/sX599UgCbkAlpXffq7gzV2KvOXShhPk0N8IK3/yMZ0xKptDRj5xQkapy?=
 =?us-ascii?Q?NfVBTBg5LB93elICVmzrpl2telRIKxajywM34Z6m6j+jfruD3qRfRTzfBbhk?=
 =?us-ascii?Q?hEZbMdK/1+c6uKIkChldPzB2eEwiDX9DgrWp0S5bCJ0YKPgRq2FQoqwFAs3B?=
 =?us-ascii?Q?Sikrg3GLjsXEPCQxfYAuehU+dY7EboNJqih/69ZcNezhPazBlGCkuJ6j9+5G?=
 =?us-ascii?Q?ZbGyZniPMXd+anr0R73oAg7lbtUcQxR4IpBzn8G2s/vkp4MpFaa/JgHdN8Os?=
 =?us-ascii?Q?5TrL0Ba4ALlZm6E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6034.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBrWcB9p8bML5O3pIc+g3Ul3gg02MKQB14pODrMJZDIrKAg1MMrffPCeLieK?=
 =?us-ascii?Q?WUTjU1748sXptP2E8ZjvnNiiMEcPXt8/UQALi6BBwM9492dZYvhB1CrlYjzJ?=
 =?us-ascii?Q?3LO6ID889phaNbgM6Usf2Gu9nFHNnH+8Oyzt7WtpVo2t+nZbQy10PHPJejkd?=
 =?us-ascii?Q?6WHmGcmo3Sj6OSrIieX5kWTHrWVQwxdcFUl2ow5st72R9+sJi1VXet8FIxCh?=
 =?us-ascii?Q?5/CO0cwbg0Lllg4xuB5+raroCAiVHP1aYaBerZw9672nu5zrSUqObOKDfZFU?=
 =?us-ascii?Q?LBN/v5qDm9NuRUYiwLqV109fLUw+nQTZpf1YRVUvqWxljb0dbn+m+M7m+pBT?=
 =?us-ascii?Q?5xcDnGKuwoUFkJBk21fN5Yewbu9C+Fk5aUKgrWCgn/br+YHZoN0PvV1fTUwo?=
 =?us-ascii?Q?dhSKbzqy0t4INVNbc1LP51u6diAUmiKKEeFPtdl8OTM/O+2YzGCdIoQZmYjz?=
 =?us-ascii?Q?CclE9WZSKePjdPpTAHtlayeTgde+7GyE3QU+RbXEgzwBpNu4Yeb8NcOwm3aR?=
 =?us-ascii?Q?0JAXweX/uQWKgAtYisRuYh+DOFhcyM5l8DjBwx4v4tBBHzhL/a0yzE+rEKqh?=
 =?us-ascii?Q?USSviklr20HUHehfa7vw9+QVJhHVc8R6TguQlGAFF2HPQImsWnhTWmluj9BI?=
 =?us-ascii?Q?+GEjR1pcafvMHY1c84zJWqel0y9l2lw8UX25T1P0Uj5y8kLXWBBSBeXVbD6p?=
 =?us-ascii?Q?YBXny1yuOAZFtZG/kQXG25JBHEmBwOXUX+N7I4Y6Hh1V8eW/TyBBnMvoBxPt?=
 =?us-ascii?Q?U4tAARlHygzwVg6FjtJAAXgpnY661syKgenH+RiAELPAtJGpKlFLvSnNN0CH?=
 =?us-ascii?Q?aahahBO+u3CjfIPwN7eW+KC4TLKoJMhyPUirmwOkbGymGDCngkcUPrZnRhHE?=
 =?us-ascii?Q?XNEENNhpcowCxqsVbQUK3cetGFhiZlP53g+E0dHDBVrw4Z3aG309rkKgAXJw?=
 =?us-ascii?Q?y1pRhcfGCPsqJHqymd2pP49xLcu6n3g/rEL0pas0H0a+NJCxxjHJwpuTSuPe?=
 =?us-ascii?Q?4mLphG6RiuKtks3Ddl3yu/wgb0bS9JfoN8vq01mhzFAI5hqKa1lTxQVVLQq6?=
 =?us-ascii?Q?ebMzHX6pd8f1KVOR/Cv/av5D/3D+fs0JjH6vlJ/URw1HsWYFoPbAYo5zUpPJ?=
 =?us-ascii?Q?IgdxUVjCT8qmIQVPx/X9qeYqyKAKjsRWdXRGkqVf8+C1bBiFDPvrLbbiLtPf?=
 =?us-ascii?Q?7qUM8Wn8SOgakv2RxHDEiXFxyQivp2W3xE0CP5ThfHwPgCmlH2T3xpVdYbUD?=
 =?us-ascii?Q?bjiiPtSoIUlFuXVeMTeqvY9Vj2gKCG2ZADYDecUUGUoeCIHZ+bkieRCRbdap?=
 =?us-ascii?Q?CpU/Q9vi/2NJ7ZqztVdXp9VdxfaFAGXZrPgp9AaBMKNsDWbnhXja4cHWkMA5?=
 =?us-ascii?Q?z/f8W69goRCul40NMgvIUrGKUQMwjtl0XHymd/3v9XL2s30dJLpleyMF9L7o?=
 =?us-ascii?Q?P3oE3BSHnIghnxPXAsEsS9PbglPwUg15gff4qeV1RsMbtUx1aLwHoGKlUyTT?=
 =?us-ascii?Q?RZWe6Jdf5GXrpwBVR2oCzL3mEeqvIdJ/WBwQE0k99dLZC0YDQN2jjrxfmt4b?=
 =?us-ascii?Q?0bNnN6UtNL80iNbqoGw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6034.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9caf6ab-d352-47d5-0c5e-08dd787143cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 20:50:02.0601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0g3bZgkuQUgMSuXtG1L/cRmVctIHg7ryUFvMZPzE0j/e3NWinIC8LeVt1nmMfmW27RsUCx2sKhxdpP068RQ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175
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

Reviewed-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Thanks,
Ahmad

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Thursday, April 3, 2025 10:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Gande, Shravan kumar <Shravankumar.Gande@amd.com>; Pan, Ellen =
<Yunru.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Direct ret in ras_reset_err_cnt on VF

With adding sriov_vf check, we directly return EOPNOTSUPP in ras_reset_erro=
r_count as we should not do anything on VF to reset RAS error count.

This also fixes the issue that loading guest driver causes register violati=
ons.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ebf1f63d0442..f8cf9621097f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1498,6 +1498,9 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
            !amdgpu_ras_get_aca_debug_mode(adev))
                return -EOPNOTSUPP;

+       if (amdgpu_sriov_vf(adev))
+               return -EOPNOTSUPP;
+
        /* skip ras error reset in gpu reset */
        if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
            ((smu_funcs && smu_funcs->set_debug_mode) ||
--
2.34.1

