Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1339FCF2597
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 08:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919A210E5A4;
	Wed, 19 Nov 2025 08:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gSZG0c8J";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E7110E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 08:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMi9IHWzjxoUdMMeNkAJZAyM48u1XYE/s0ySDSg70c5nT+t7ZU6Scy/svg4qfwezbYkYVQmIDIv2dklEos9vLKsWFLrRDtElqXoN67rsc4a65DKyyivNL+rLlJtmvnymc7u0hY7E6xtLNHkwwTcMwmomCP2xxAvsjh5v5OFPZRpouUpqlC1ORUb5vVE3sWsTwU7AzWlfiEVjCsoggvzUkXiW2//ENpjBXVEQFbpnK1b1bEq+OkYPoNIgRkG262ZwOpvMAebDPFswFGs0Y9X7EiESn+leBudEkm8rhPKyuTmDe1Wr/6qdtikmSh1WrKmYq6nCIX2AdHYhjiqp/xECow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kxobuRB2QSpB7P32B4d3mvSXC4UI0D49w2KigZmau0=;
 b=DwPLD+xgw3cfpk0Rb/dVcFqhB1QC38vZdurbz5kPxe49CLYnx9AkY/rBUiMtz90qpn/pcbclFdBTshxb1SCKofX8iGnwFaAeZivSgVrrUZyp2iFP1HFiZyNI3eUlTJxqAFvx5ykIwoQuQLDn2P1wcf537Pva3AprRUIA26SjbZepJPnGtRic9rUcUv9j1SZmfTlfcTA5jztVB6/obXX9RUXuuvrPA2p1mcF808sbYZFyb8obnmugfoOwSVFUzCKc2qL/0U7N2jBfs8LKO/wdyCzgB2ow88ZWvoD6CHXHTypmVUtUjFjMfwEpRFEEYyk2RIqbWbZGeOpZsWwXqqCQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kxobuRB2QSpB7P32B4d3mvSXC4UI0D49w2KigZmau0=;
 b=gSZG0c8JNdnBiM+UI9U1prz8u1XGeHMdPdSZQJv750q8ZfxkGWhhEf64u6q0jD2SDf3jsVziw7IYBrQDvwnDzd6mkz5L+wS9/P460nUqVUd6i+XPiLZmSz5OtfGFzFHwuXkqAOQr4Z5eLInQxBMZqTS6ZkcojsoFv3lbVCQ3NRE=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:12:08 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 08:12:08 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Fan, Shikang" <Shikang.Fan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan, Shikang"
 <Shikang.Fan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset
 support.
Thread-Topic: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset
 support.
Thread-Index: AQHcWHMq8pA4bgiPBEK3qZj0vV/uILT5pz+Q
Date: Wed, 19 Nov 2025 08:12:08 +0000
Message-ID: <DM6PR12MB4340C6AF0393C417756AB338FAD7A@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20251118100657.1222595-1-shikang.fan@amd.com>
In-Reply-To: <20251118100657.1222595-1-shikang.fan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Owen.Zhang2@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-19T08:11:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|SN7PR12MB8791:EE_
x-ms-office365-filtering-correlation-id: d2d9c9aa-ec31-4754-af3e-08de2743558b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?W3ZMcs6kHIhWiSGKzdyY/vXqxhDjSVbpyWHJDTL3HOH+Ak65RX9w4AMniNol?=
 =?us-ascii?Q?3lpod6Eb8N0PFOoOMpmFJvSxEssVDSZhA+S3k5dR8opIaaR3KwQeNLqkSRzu?=
 =?us-ascii?Q?w/LvZR23rteR6xgUIE6EdESlzZY3DcfQMvhLWo81REoMQNJA3Rn/DT9mHvCL?=
 =?us-ascii?Q?C6G4gXpyWX5Y2N1zFmyiq0zjX1sfXVbRHuOqcNykJRlQJW6Eg9O85fOp74m4?=
 =?us-ascii?Q?R+4jshRmKM4iboisAbtxe/mzF4rV7nompG1/gY+vpLXdZGr/fmM3v8VHcwBb?=
 =?us-ascii?Q?yI7UpEqO0Ua8mW36y4nq9/e0mWHaLJKc/UwRgisA/Yly5mcWJe46Ds9UFw2u?=
 =?us-ascii?Q?SUkKEdF4JFz5pGoaDjnGXmntu1fXnzYKcR4zMhJ/8+hbq0vjDVgpLeZWSQtK?=
 =?us-ascii?Q?VuiZtYrQ6pew6xR0em0JB8eMGd3kEikVeQcYC5p1RtZOlpcUC1QwgItcredj?=
 =?us-ascii?Q?al5ODX+r0wMFisXU303aSRVRNRYbXt1FaXDF9w11RCUDNrsjS29HidSDg0wm?=
 =?us-ascii?Q?wIUeJj5Y5puGzOl8PPNYguKxqBVUwmeyot1V6eXdScXSDUK+AZfuyP3TXMuV?=
 =?us-ascii?Q?n/mLLy1u/nw6sRJyGLY+DVO9SICx3eNIDgwcUNILio8UJF28jGPRUUm9EwhN?=
 =?us-ascii?Q?2D8MEfblbQNFSZ0iJTh3lYeGnHcEFtY58UrqwW4ls/iBAC2/Gy3t7csYz5uv?=
 =?us-ascii?Q?yyB3hEArRu4K+DTCHi/oENTsY5JV82YxlWL5TFOLQ+gzDaphpXAhrioNUZeg?=
 =?us-ascii?Q?Dj6504Fm7UgwgSLQd4UJzpLgKJjcI7jMvfgTONe8Xay3Fpm4xJNSCbIb/WZw?=
 =?us-ascii?Q?bnH6+qJkDokEFQjMXCe18d+mSR/c2+117SRq66jYN9w3zB+ukrPVzcMMyGEf?=
 =?us-ascii?Q?dpnfd1FU+oGFNaG4RaZgOfokeGSeWe/Y6rtBvMe0rnTVSj6SVrjHmfwA0flq?=
 =?us-ascii?Q?pyuVUyaOIL7YBeOmhMCScZadtAp1+yW2CmbqTzBABr9yMPhK2Mq/c36v4T+k?=
 =?us-ascii?Q?hXFziaUNKTDCMcz7MZcacXVHrnrDhi7195ZUEfk5B4VO1IbbNPjeu/nHVuxj?=
 =?us-ascii?Q?4p+WbNHhWKRnwZp+o/p2UgALQ0Uni2UkRyzmQWtwhQ0On7ZiKTFlqESGLQfM?=
 =?us-ascii?Q?0hcxAyfQ4mokkiBPlAyAzwp45Cah+yGtu8ha9kt+xszRggjpKvK6uKdT5x2T?=
 =?us-ascii?Q?FN3eZKZKfROslNUZpGJj4SCLjE5VrD6ZoSK8BrobP5ZJ9gAUzZYH6W+DIyTb?=
 =?us-ascii?Q?o+SexneHaBFkvVgOydaCClbUziLsqrwnjRJhwD9OgqJM57EhE28XjdbCDJEf?=
 =?us-ascii?Q?XIWjZHHVPdrJB4tj/IuoCv4UZkUvbWuEecIhTuWwvyxLbgif7M+3Mm/CBOsL?=
 =?us-ascii?Q?oPTIdubQ5SOxX3DoHemwKRbSMEf/dn5zb94S6wNFcmCG0UL7KNpHOxwAiXWe?=
 =?us-ascii?Q?auOMFb/4Grp/tJhuIIix2nOgk30H0ScRJjbrTGBrqSFf2J7nREiVB68JTPdN?=
 =?us-ascii?Q?kC0IhIB0/6dcwGtpUC06gkJQ5pQcL+q2aWlA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tm1KDqCHsYW2WcJpPPpxIiopXhdS4FqmMJhC80FPLjTGJeBtyrJ9THX1gtT4?=
 =?us-ascii?Q?WkjxEETCNsQG2Y2FMRSL3oV8JIu9/n0dWFg1EmJKCBPAe2hqsA+/8VmAGZ63?=
 =?us-ascii?Q?8+C8ja70Ou1izNhMNXoU26GhNYLNSzBil66SODOe/dsRU25rk6RZ6lNqWEP1?=
 =?us-ascii?Q?53aXuPkRBKiY1kNIecxLg9Pvb5U/HmXRE6iGdp5HUZ6iW2/ayB1ftayrJBA2?=
 =?us-ascii?Q?RiupAH5JNPcnl7UBxTZtUp06aQqOf+bRLcF1N0JiwKw7vders9UbHRPZCixe?=
 =?us-ascii?Q?C7/LMp826MqrH8b8uNyLLhs45Hn8/ORe8VvXMazI9lrquKoJEZpHZjAxQsd+?=
 =?us-ascii?Q?oT8AXJAGCg7IfTv8tDVrDsd/05AT5rjDDTv0GI7JiouQwPC+F3qo+3DH5rLi?=
 =?us-ascii?Q?B3ss63MlMNtPOY1bpkwzd0BAfdL66rkePw4sFXyF4A1HC9VQ2BslEFOzitte?=
 =?us-ascii?Q?UO+JdREODAvuxGp1Ck53o06pM8vWXiv2NAKKgSpN+g8IWW97CXJvHHc3P5GV?=
 =?us-ascii?Q?mj93petMUWRRe52sluZ5xou6SQ+5bezkV2rgqElSjFujMNpXWeRtgNtfMZ1y?=
 =?us-ascii?Q?0Q9hukckI+KWyO1AczBc5ScKYq47xHDLEh4MJV1xoV88TZ+bKN2tKagrFuJq?=
 =?us-ascii?Q?uMmUX+rrkz31dZ2rfD5/AHIQtgTmMIvl/6rsRsbMu9LRAIEWoAjaiU3h9DiJ?=
 =?us-ascii?Q?qhVQwenJLcI7Er67tNeXN4+tQtTMZvhMnpLzW0Fgd0pLfQzJorezLwcZmHKf?=
 =?us-ascii?Q?nUwuw0NGdRI+OWNt2889cfjY4EyqlaBzpHFV8ID5KtZTn0IgtPjp/7w3XcVM?=
 =?us-ascii?Q?4ZSrNm7t8xQIhEWkGtwsmVOmlKhpaexnWyuyqBJIEq+2ZaOI3glYK5dZQZCw?=
 =?us-ascii?Q?ZTFjur1B3I+hTAW96OjnUQeeTaYv9ChgRVmL7Ap7lAljb6RmOyisJm2qAHzd?=
 =?us-ascii?Q?OGcUyZvk8YgaG6EdHBBHkzGW6zR4ILcE7ZE6TfeV3/LxibXe4O82HO3+mlqO?=
 =?us-ascii?Q?X4zu75EAafQ6xB7PMyjmloEGnpvx93JztXMW2oJTYIBbmCpD5iTT75bNnWVe?=
 =?us-ascii?Q?zu3ICFapVcrw5YsGhq/9sM5jPziJ5z9azyQ9vkDEZXX9xqSFb1D5fG8YR2Si?=
 =?us-ascii?Q?bjIYjpU38Le4Uj/tgV0AR1abQUcJBFj+Hp/ODXiaClm/43vQT7OiCLXsv+64?=
 =?us-ascii?Q?jkdSpNFlgyOaNR0CaA0cM2EPAoFEWhcMF4Q4YFI3XsL3xTegDNVFfs48vK5O?=
 =?us-ascii?Q?E+JonsZkgvNbQPABhFJTtmJJ4haZ8ZOMA9pCpH/2uMFtHChFYeqQzcF3Ht5Y?=
 =?us-ascii?Q?KlyOT782whxNSinRyKUr1quE47UOJ8W71rqYdPSEMYFSYlKis2L51przdPtz?=
 =?us-ascii?Q?IMknopiW3iLvimOJYhoJ0kSdFql73fDnMW0Cvp3XKq29KF6236E21xDvcIST?=
 =?us-ascii?Q?UeanTl50kOko+IHGmcaD/sppA0nUwQgMkS/y9xxsxH8qaUDxmypViFEhtk1o?=
 =?us-ascii?Q?/x17idxijL5jTt9gTghy5tjxQoOCnoO2f9PEdFl/SYYm4oQjM9DmMGJ2wB7f?=
 =?us-ascii?Q?/BbjzGWoIlISmoXTDvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d9c9aa-ec31-4754-af3e-08de2743558b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 08:12:08.4162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNeiNPmA6NVk1HYVISx3M6w03Empb6ROGICMEcMqsCgfvmRIi05BWOD6Yuau7s7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

Add @Zhang, Owen(SRDC)

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shikang =
Fan
Sent: Tuesday, November 18, 2025 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang <Shikang.F=
an@amd.com>
Subject: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset sup=
port.

Add SRIOV check when setting VCN ring's supported reset mask.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/vcn_v5_0_1.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index eacf4e93ba2f..cb7123ec1a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -141,7 +141,7 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block =
*ip_block)
        adev->vcn.supported_reset =3D
                amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc=
[0]);

-       if (amdgpu_dpm_reset_vcn_is_supported(adev))
+       if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(ade=
v))
                adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_1.c
index 714350cabf2f..8bd457dea4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -122,7 +122,9 @@ static int vcn_v5_0_1_late_init(struct amdgpu_ip_block =
*ip_block)

        switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
        case IP_VERSION(13, 0, 12):
-               if ((adev->psp.sos.fw_version >=3D 0x00450025) && amdgpu_dp=
m_reset_vcn_is_supported(adev))
+               if ((adev->psp.sos.fw_version >=3D 0x00450025) &&
+                       amdgpu_dpm_reset_vcn_is_supported(adev) &&
+                       !amdgpu_sriov_vf(adev))
                        adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PE=
R_QUEUE;
                break;
        default:
--
2.34.1

