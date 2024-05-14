Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74440C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3B110EA51;
	Tue, 14 May 2024 08:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1PcfBNO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6EB10EA18
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsCf0rEj9PohGfDnMuuZ8QbhLLQb3cAYFXNq2ASAWXzc89fAd8v05CL8jQ6aU0aVGs/Bbvqm3SZtcndAaGC2KOrFDIcv1PsJZ6VypFEB4TyRUy9qeBOsUqaxhYSEl7V0wpPf4yh4fjeAN8eLO1DI5Tkxi8igGm29fbV4DWkHHeUvTn4RDXHVKSvpkIVk78GnbkuGg1W05jl1+E4DKlS/aUr0qcNk1hWqIivRa/WM/IWSAgVoJkjWtC0nqZyS/V9eIEGwonT6VCSqJaswaChm9ttBKDQ+/Py5N1TADqWOU/HC7vDk5G0u3t0f4xNQZxFlc6CpzhPFFIdg1EdaN6q0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmet2Lhqd8NvI9jxr6C0Ezk6dO0XaDsa5C1VJ1hxIlc=;
 b=nDKNblFrBXhhT/G5ZsfnVLmp6sbyiVkHR0QYv6cupwspLBfW/dXJ3KIw5C35D9Sjcj3LHX/eEwcB+PWCwzufF8nHM/wQUEC9bTmeBd5IsUMpPHi281JeAqgT5U2oNHy+Wy0EKDgU0X6Cqhi3YFjql792+2rFRlKOtUh+KKj2u5gRlF1cOd0z7dsYXLqLWQJCG1kmzmJJAr+jGgBTOo71vQhQtCHDr1nBcQ7zsktpMtVcMd9VjKTivj1GhvDTYNYyvwRBTO/pvxN80O+KlQOFPB5AND26Y0oMixRtdnQPhpWC4hsaUOTmq1l+Mb5GlO/kmrehoUibMhWt3KgQ0mpGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmet2Lhqd8NvI9jxr6C0Ezk6dO0XaDsa5C1VJ1hxIlc=;
 b=I1PcfBNOj5Fy3iXj46WosbqMW8hk0uxCUxyrIXrgwVQbPcPsJZa3vhxl/veuBMxjPvqgSgzBxVKaSKoVB+oUUMDsuXU54W6HME84jqcCqE7omHvFsvNa88nT+kXpzGOzvy0ZtbxhwFyCeORvJWEa8i2nDmez5nlnI5vm1ghYjtU=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:51:11 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:51:11 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: enable gfx cgcg&cgls for gfx v12_0_0
Thread-Topic: [PATCH 3/8] drm/amdgpu: enable gfx cgcg&cgls for gfx v12_0_0
Thread-Index: AQHapdt7lZ/V8LrQfkCYr2DNAmSfA7GWa/HA
Date: Tue, 14 May 2024 08:51:11 +0000
Message-ID: <DM4PR12MB518106FD47E59382ECBCA623EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-3-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-3-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0ff4ab1e-d3fb-4d35-90aa-7477e79a7854;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:50:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 39656f14-e815-44ec-e1b1-08dc73f3013c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+clwAUCoVgWoYFZnWn2oOUaaCnNo5Gu0xt42WOuKL2qb8VQnLx9rmRqQwTh/?=
 =?us-ascii?Q?axWxEam95+avY8Osy8YcOrVDjVIFJmolUtwLweze2gl2jAx6XsYke0Hjftie?=
 =?us-ascii?Q?DBM2ZmVZlau0xyJRhRZydQYK7St0oze51cvmSvhII2GwSjaTMCImUR/BDT04?=
 =?us-ascii?Q?+GBSWiLWzS1+SHMc2mS63uHiB5AfiVHAriRgg5Cpcwf7ySy30qUeGwcaDLVg?=
 =?us-ascii?Q?4CgI2igZ2u9mKE4uF2fQgRrM2BdZDBTJ0mOm3ndKloW0gCuft2DxIL994Hpl?=
 =?us-ascii?Q?4PBSdckDkXjgQUK0oHCJxv1a/suvgvaTBzX/tR5FCEp5eKL1YtNiGdhRujd+?=
 =?us-ascii?Q?H4u2teqbIy97E0FwB9YRmSuAYaTombJ9c+Fz0jSIc2DsPGq1DfGCtbx8iEKf?=
 =?us-ascii?Q?pi+Eg/LEJzvakLh7+V8EKIxJgBjIT+BM4vACZnojTXIOk5oAT2DFbyXNRaHl?=
 =?us-ascii?Q?LuRQ0WFlHYFtz4INxrifG31s7oy9V5PZZV8WaAKKeqGK2TbArF0CGrWkpZ1P?=
 =?us-ascii?Q?rSstRmEWbAVQpfsBbha7FeUv5XyL8k3zFTY1dN8ygmWPVnD0IBG8ozdvbX6a?=
 =?us-ascii?Q?vYf4qX7CykqhzlLFMGi9efANxUIbuvhJUdYSzbpInTQdZ4JYCq/pGgFcAZnd?=
 =?us-ascii?Q?iEpMI53SSVmLxpzy5mTXiCsfjkJtZaq4l26KNwDw96YKVXVbIv508XrVtQCb?=
 =?us-ascii?Q?LeL3/kJz3XlZA2HLdIs294/Q5MDbxnE4MvoqOvvsJNW9VYQRSYWFdcVwoH1a?=
 =?us-ascii?Q?QgiJg8W4ZciR8SXxllnY6WvxCRDFMGpXPguJB/Hplk/SKMdNMYzq5ZK4WiZb?=
 =?us-ascii?Q?tYsXpYLj3vLjH6kWp7JKsmMgF+LgT7VeHx4/igxuCjN2IQJYr9nmeWWYKKd7?=
 =?us-ascii?Q?df3OjhP7HEVMlOKDdOJs4T6y2e+EUvyjP2Mz6vWNLgX2ORtX9cmCyuCceb8E?=
 =?us-ascii?Q?KLEuatJaxPk5JaqZl1I9gmRRiA/4WZTvkixaVeNHVUgc56IVMIsMrJM56/Mq?=
 =?us-ascii?Q?LMfb8N+u8dYbCea0rQhY5RpmHgta5/nGz41ho5Nb7ZJZUhdnEeaIR9/dwNrm?=
 =?us-ascii?Q?XpuS0yHBWWMvrYbHwpZXscG96wAsQ94miV7tvzy1uP4p+r1yRYb4dOG3YoW2?=
 =?us-ascii?Q?Vf66FRZ/5Gzii0SZxhH3alhmkm0E1MWrm6vfnoZhivxtBSb/Tl+BEmsSOXGK?=
 =?us-ascii?Q?8ZYe2Z9F3elm0JkOx4raWxfN2ITW8Vr1y3fQid00OaR/ugDAoBZr6t3lQsAv?=
 =?us-ascii?Q?usrm6GxtdoqgGSMlQU9e0ppJrdgg24n1TGEBun9yJO6vWJejR3l9YQsD/26x?=
 =?us-ascii?Q?fP1rnuvzuSClN5zfc2/uBKWkCBFBF0jJRng3ufCCy3Lujg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDkPqYEq5EztZceGv6vpodmD+n8pwJgrt383a5mwpQVa6P/q9MAVtigVYF6m?=
 =?us-ascii?Q?jhsaCzWLn3iFrPhKCnnQhP3eF8P3CvNy15ahrVI83J64XSaWR5mA+Bf8TO/i?=
 =?us-ascii?Q?wvdYWpbEuu8UcF3JlgYQTqQbmAhAdE9z4Xju0QSwe1UriRuGtyym2QCoM7D7?=
 =?us-ascii?Q?YEauTeY0g9Fczm2Vj2kmeXsc2VgCbuqDrCS8ye3PFrU371aXyRF7Xc/h3evH?=
 =?us-ascii?Q?lPXTJfztCeQ67GMuVWrS97m9ql8XdCgqG2KFYTDmXjvSTat8OPsdlnD/g/RQ?=
 =?us-ascii?Q?yHTJl3BNcq7BO78g+QCcAUbXeZFx8cThv55NjwiqyLv35F9yOhCPlAISXCzS?=
 =?us-ascii?Q?STvrpp7ytCAVEeuN/znCf0IvXquvyVPf9Gcw7tnZ26qe/N4xMEx7fx9VQXP6?=
 =?us-ascii?Q?UbtO+A8WkJa+5eGwYT5VjRfADNGJfkw56GzrZHYNdfC0/5CMoJFW9ImzZBIB?=
 =?us-ascii?Q?4l5Q8L7TSF1KYegfIsnk9CDi50trQhLXEM9wO82Zt2ZJdTJQqkuU4ap/BLw6?=
 =?us-ascii?Q?LkWoCFTHfwGVsAIeMd/goufec+GBB6S6oqcsU9eHXBbyOxszz5BoHAaAdO09?=
 =?us-ascii?Q?aI4fsbZPIKieP0nsYfcyaacdn1E8FfzpzfZpJI6xsiIOQL0YFheW2/dH4eCs?=
 =?us-ascii?Q?j6pQJWitRs5ngguBmjDma4w6MmF/VIH5RlCKdIU5P+JivSnIjUMdH2VST9HZ?=
 =?us-ascii?Q?Rp2oJnmsG9O+h7Nr/s9KFoteoW3UE9Vtqg4w2dSImtfQdIavBAPplOSmZ92k?=
 =?us-ascii?Q?QnsHxBEHGHeiJIF0K26PRAQxXu4N2hhgWeiuO4BlNj3cU7cqRoTWT+96yBG6?=
 =?us-ascii?Q?5+EomyFXM6jQ95uYqy1OGmCvlWSo7FveuMCPyL/gqNpx/hIxPvbGlZjpPpSZ?=
 =?us-ascii?Q?QqiK49EMWv0fO+z/hD/HI3D535LwAORSu+2YnJ0D0moXMJh7anPc6PFoGVYa?=
 =?us-ascii?Q?KwLZ5Fs43EPXPu2MWv+uiKqw/BkbMWkYDsmfIwd2f/PpvROoeAYw2mMYAcot?=
 =?us-ascii?Q?+PMu9Cw/xG10lKBqK+2WiLVJ2KmK1tpA7Rn6nAxq2hdICr+TGmHBb71iL5Yu?=
 =?us-ascii?Q?KK7VFwju0BQ8KqILgvtut7K0AzzsvogyQJkeYIXcm7TRu46WkSB5tNtm3GnL?=
 =?us-ascii?Q?YWn5+bWLK29I4N+c78/Ei9iAmFvy4hz3oNAH4cIJEnbKs6ZECIwsr7jyQQmu?=
 =?us-ascii?Q?acE85Lkvr++trcnPb3j2utyDdCpKbMO5RdFUEdBorpagb0OP34AlTgEXZ8tO?=
 =?us-ascii?Q?USsswD+wcrHD8NBPcA+cK/wPj3/oj45cXRm2oJTnz8vtam96aRsCuoJqS/ue?=
 =?us-ascii?Q?xuQ/fz/NICN1Qhm1ekZ4Hyr8ZwsQazAfBM0ozM50CblOG70fXnYibaptBAPe?=
 =?us-ascii?Q?ulaMgPY+jVwL+bm/rmSwll9ALaj8dlfZiugoj8d9kpVRL1wJa2z5mWdNDTAC?=
 =?us-ascii?Q?h6RumaV6ljXLUoGWjqM4Npier/nYXEAKgk91y0E+Tf13n3dsINA8R2a9U1tm?=
 =?us-ascii?Q?W6NNRXr7R/niZlNHLlCLuzbk9Y2XOQM9M3pKjLQQqCaV4jR/nj8YGdLRznIV?=
 =?us-ascii?Q?Ekh0hv1gKi0S5EqIILo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39656f14-e815-44ec-e1b1-08dc73f3013c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:51:11.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNeOAxQcf0V17L0G02z64BHIN6m/B6mFCahwGh9GRlR3hGQ7sKe3pAGnLH+7mW66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Likun Gao <Likun.Gao@amd.com>

Enable GFX CGCG and CGLS for gfx version 12.0.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 924ab4a3a0d5..045731caa624 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3857,6 +3857,7 @@ static int gfx_v12_0_set_clockgating_state(void *hand=
le,
                return 0;

        switch (adev->ip_versions[GC_HWIP][0]) {
+       case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
                gfx_v12_0_update_gfx_clock_gating(adev,
                                                  state =3D=3D AMD_CG_STATE=
_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 3eb6574b777a..5c796e974252 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -397,7 +397,8 @@ static int soc24_common_early_init(void *handle)

        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(12, 0, 0):
-               adev->cg_flags =3D 0;
+               adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
+                       AMD_CG_SUPPORT_GFX_CGLS;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG;
                adev->external_rev_id =3D adev->rev_id + 0x40;
--
2.34.1

