Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07E3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 13:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3714D10E025;
	Fri, 10 Nov 2023 13:04:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5710010E025
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 13:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPbn80Fwrf9CmzC8hk02yu95/j4owpCpHTjA2l2yDMW+E9ubKbEc0IKJvOzYvdtYCRKA6pzOb5KuUyOys3kBI1SGvWNDzaUacYQtzIsKTNsA8VgcxfT+w9Opv+KZHsB4Hue0eIl0HdYED11L2IgifoiXLbezZeYMm2KT2KeEx4VhzdK094PpEGxZeTI7Wh+C68NeR3/C81YXQYX061EuFV4irA/kf/5w/8aXf86V45u1Vq37ShW/MFIWbZAv/XSgbrAl7Kc+vS03Sry6w2EEfy0icxeOisu40lDF0L6DtLtRh7lgXJzb5TQ2u3+W1s6DzEJQUO42S0k6tzfSLnik+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAAhah1ryGDQTYgXQtQKcicF1/WgA5HfSDp1KMlIee8=;
 b=Rprr0GYZQLKs2KSr6cVmbnDip4oEHgi2IHCp8X1G7df8YQaAK/HQEUK/KGT6xNuZs8Jn3usk6ka3WjEp8+gnttiV3vVjzSqy+k/N1XRYWZwzm43ih9y7d0pBvJhTs66gRBl1bb2WdJeCyE3kgACBBblBuiFXq+ssK+PZF3NVi4nHDPjJZ4ZfncQmBUzMiHrfrh9H+lvUx6YRhyk1fMxT5pJ1VI11ab9Jmf+F6JTwgB74bdc3FASDfYINRfXDowvF4FTiOy+qDJOZ2Sx2tVnnmnN3JuSh/r5KowxGziKR4ak8k2ToHKSq8Riobw+vPqeM+K5FWZpesGoyKyElbnW1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAAhah1ryGDQTYgXQtQKcicF1/WgA5HfSDp1KMlIee8=;
 b=Ux4/PGkGxiygpeoqvTGBQ5hI5yshyen1yGzcPdEmjqPBTmdbAYVzV1kD5ckTJ7SI5YKL9UFug0/33BQXvdl90ZMg/Kac8CaeTqcxwKhS/DAuzON/PUSKrqtIRtaTVtEEOqhL+waA7465QHf75pri4Z5m0m9+NB/+/5UV81bvvwo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 13:04:38 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 13:04:38 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu/gmc11: disable AGP aperture
Thread-Topic: [PATCH 3/5] drm/amdgpu/gmc11: disable AGP aperture
Thread-Index: AQHaE06Rs/12gh9DukONoT0Lw1hL+7BzhJjA
Date: Fri, 10 Nov 2023 13:04:38 +0000
Message-ID: <CY5PR12MB63696A7DEADABF7408699040C1AEA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231109205125.513643-1-alexander.deucher@amd.com>
 <20231109205125.513643-3-alexander.deucher@amd.com>
In-Reply-To: <20231109205125.513643-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=10e0e95e-6bab-44fd-8821-4835d4b3b050;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T12:58:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH2PR12MB4183:EE_
x-ms-office365-filtering-correlation-id: 303b307c-89c6-4a57-8ee1-08dbe1ed987e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ce5xuGSZqENiLTgvbkWXI89BP2U3n0WxwKOcH0HAHAa7FvVkxd8fuTn8FrrN8qqMYw5K67nYf3J6RzG5Dirz3fY8SljloMM4+hB+PDTWuyq+mAF2eWkb0tTObpqtEqJD7Is3izZj9L4QMjU53/WgXyCJxKCW1BGYlpIzw2vrAr+R0cqsSR6RIHHi1wmiMotu3zIrMiQMTAlxqYblyMMbAjCuWMvGynhT6JP809EaVbl9fw4q2X5ZcVeLfg2bRbvdv8v1Lr61t39YoEOTN4RpVz0QlAuu9CzM+dq+BX1OlhMQW8UwhKxYexVgkpR7Whr8S5OYj1V63behnVhF/fdy2tG8wDybgS420u76UO4Gs6qVMRoL32tIa01D5I78aAJJTcp3ufjBmFHjWhsO8yXB0aiskQRe5HtfNI0jhnf/1kv7c1m7mKb6B7tkOW/mezx7EDjFEiJK2CnrnHUG5tGbTYsCiG7nRxt9m2ks3d3wAoUP8wTEnurJzL6iPFEhq96JicKGtWA7CjC/VPShzT7cQF26bNsWHhfujMu1G5bf8kRgbtC2vyZ26H90Sql+l40u9oY56wMSTr5dHP5pcbbfwGlXCD33wP27n2uSqHvDZmL9DeiCZM38/XYA9Ck+uR7r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33656002)(38070700009)(83380400001)(26005)(316002)(110136005)(66556008)(54906003)(64756008)(66446008)(66476007)(66946007)(76116006)(2906002)(52536014)(8676002)(8936002)(55016003)(5660300002)(4326008)(53546011)(478600001)(71200400001)(7696005)(6506007)(9686003)(86362001)(38100700002)(122000001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ipU2r9NBx0QgPrV1yIyIqmZDvGi7Q+bI1KOafNdmBXHrSo7RLeE+QueeyzyE?=
 =?us-ascii?Q?hDzwMYrGHdmMSYHWl+N7y+jAfWcbdg1y7QDYZV///kJeJm0iBsZn4Cwkm/C3?=
 =?us-ascii?Q?q8DKUYv/wTiu8xue3SsEVGIZhJP3ZouBgQuzPzX37E+tsCent6GaEF+lQS3Q?=
 =?us-ascii?Q?ZDwerQUbsg9xiUOZ6We03fN7R/xrAQdoOpvG1hahpD7EA8ThG2XPtb6Gx+iJ?=
 =?us-ascii?Q?86VyaSLL+dDYmu0hf1t1jCPlOxnm40pvebP3fozm09EceV9CCtMyHF+IvwKJ?=
 =?us-ascii?Q?ruhAHgjZj8N19lkCfC10kJY60I4q+m91E8qN8ieYMdMzSEwB6GJhwprl1Es4?=
 =?us-ascii?Q?jApOnxXfjnPSKpEByUri8oBFqDPzwp2f/pJ/UoQef+/IUHtNJUyDsAN8RUHo?=
 =?us-ascii?Q?TAUPWvUfhbd77BwEVkxic9g/ErPBOzoDT/8ysWIWr3+rWC5gLQHaHuGks1KO?=
 =?us-ascii?Q?2CNPHhkRCObULQt3mjQ24S8esWVl+j1TZSdV8clMgJ2Io6fLRJVNtpBRWOCt?=
 =?us-ascii?Q?cG+4V4XrFqsFwIKP9Ev0zxk/j/9FM4UDXTb6EJlngJI/El2FVYwBSsJ5tvjz?=
 =?us-ascii?Q?Eu9axZ8Cm7sQ6VjB5Stxvwj3hK0zXviCx5hZ63NaYUAD6saRT5RNFtPWkADY?=
 =?us-ascii?Q?e6ULtkBNq2AlKURqxlcD1C4oGstyhNTftXr+Mic39kN/mpe3AeCsWalTwSuS?=
 =?us-ascii?Q?7MpEBuBcThuTxOtrutecEPsWuIi/jG+lKL1Bo3MsDqiCR+k9mVoBZ6T4WgIB?=
 =?us-ascii?Q?A9VeCxBZ15Dla7kCzeRBGJazJb/nk6da2ujrWhHBuIUyz3mA0d9oD3MySb1z?=
 =?us-ascii?Q?G5pVLQrxNB6SCY8GspOBrG7uR6Xnveu5oi4TmuAj3n3LQJZCfAxCrtQathLo?=
 =?us-ascii?Q?u1HhpjC5hENPj/8sN07O3tvmADbMPJjC1HSUPe76UdKZ8AJS9WttZXkKNhSQ?=
 =?us-ascii?Q?h3Q3+Qaety4Oq5vkG535vXdWQZWfffZdMVI6RfU4vWWzPdd6cYPzIsMKtDVn?=
 =?us-ascii?Q?kVMj3zl/eeIPo6+iWkRUc9HTITaDSe1hzyagkG7emUi0i94qBdYZScKt7t5W?=
 =?us-ascii?Q?Mz0XdQLc8dnSt7Bpt5XxNEWdjPjQ1VumN4jtPO17+OiWF0RR05oguXjKSEW7?=
 =?us-ascii?Q?t9LgWfH/w0MIX8KPdRGOH0HfwC8xbpmSO0dwGIchfLFH+zmpA0769f97hov7?=
 =?us-ascii?Q?CqRXL0nB4na/vbyR7B+kycmM/8QyIwnpcURPC0x7p9jgatmcNKaaOcz+eJn/?=
 =?us-ascii?Q?inenTXedTrzP2Ll09k8Qv99sd6norvrcxtoMzI7UNEXcCPCyQLosmxpLAmI3?=
 =?us-ascii?Q?R5/wxifsTGK8sLmW55sUGO6+pCn7sHbq/uYmk2rlCgidMvaKHyXMHZdiwcKu?=
 =?us-ascii?Q?KUjAZCcsM1Gx7Wn7qgZiYdXfoPXbuMDXBPgwvfzTLTv6c4vC4qpyx2s+Jyry?=
 =?us-ascii?Q?2y6hg7uhGdFnpwfa6haHSQJqhxvROFomUoJagxDpuSS8v5W5Ioem9AZ58NnA?=
 =?us-ascii?Q?sdtLp+pLc9Q6rF9sEXv1SCY2daFpbB2wvGw9pAclgQPS+/2TKLAKnJiTLrzY?=
 =?us-ascii?Q?pQRCsOwTDh20ZTvBi/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b307c-89c6-4a57-8ee1-08dbe1ed987e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 13:04:38.4513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2Rle/o/BIuM6fAEf6bOPivI1+WA6iDdD/bZfkxuSPpbE1x6Go87elv/QkiPuzfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Are these page faults reported after ("b93ed51c32ca drm/amdgpu: fix AGP ini=
t order ") ? Jesse also found page faults in Kfdtest after this commit, and=
 can be fixed by below patch:

[PATCH] drm/amdgpu: exclude domain start when calucales offset for AGP aper=
ture BOs



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, November 10, 2023 4:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gmc11: disable AGP aperture

We've had misc reports of random IOMMU page faults when this is used.  It's=
 just a rarely used optimization anyway, so let's just disable it.  It can =
still be toggled via the module parameter for testing.

v2: leave it configurable via module parameter

Reviewed-by: Yang Wang <kevinyang.wang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index e1078b53e942..23d7b548d13f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -642,7 +642,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,
        amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
        if (!amdgpu_sriov_vf(adev) &&
            (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)) &&
-           (amdgpu_agp !=3D 0))
+           (amdgpu_agp =3D=3D 1))
                amdgpu_gmc_agp_location(adev, mc);

        /* base offset of vram pages */
--
2.41.0

