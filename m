Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE716C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 16:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C49210E91E;
	Thu,  7 Dec 2023 16:29:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D8210E91E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 16:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwDdq0jAMl4H3Z4687TYq+PZ1RjYep15SargH2bHC10sZJP9yt8im4P9rCggiKlGr3pI0pSx+LAmM6/aVHkrSu05/LdU6TNF5EDvqjDGngic4fuivQq+J6WE5bpaBpfDdX7etMG0i/PzoxDqb1IUcJkSxdCWszuA9Lwr0pipvh8Jmntxa9daNEh/TK4UYEZ+lkb+F2laT4Lgro8b4mG9e+PEMx5QBky0JThh1BIT4r4y0GdU1wSIDFgSjYS956OslL187PfKiELaWBf9eZAetTaym9CJnHKZxtGVJwLbK4y9DkfSykb3nL896AO+tfIyKHl8YOdry9OEyl6p90bMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qIaXhIHIUr54hJVsmSMg5sYln7v3p3M81aYL2Dbe1c=;
 b=n82qH0ra76XGFkKu5PvDYWgO7EhZ2Zuml0V8xrRWJVoTU6n2sM+1x+aGtDsElBn3/oA+EosKolVHYkFN81SL6n7i+ZDt/juO89XwuP3vh4ksFylVbqG7xM0sbzGFn7IETTAF6SVtlEAJeKDPccZihC8vlk5SKRU7yfGq4CsitQHFcBYc+h0xojewl7b+s26Hw8PoEle+U96ko31SDZi8At7q5s3xqNKKOPSUVk3f7bvsBoomogK03WxjY4XFWc2HW5MFKhYGYUjcyIqq2P+Zvg2xEyEdSZckYOMJGn2IGNgqC7QqaPUkCciGFzF0ms5raFT8YzW/qGkgUaLo79ZR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qIaXhIHIUr54hJVsmSMg5sYln7v3p3M81aYL2Dbe1c=;
 b=CzqmxJ19LalyIjMKzsG2khNHfbHSrn4xyjtlRWGNerDHWgrqD0YKs1y5fmHm6cJskRcbva0ECadZjWmSzCfqH4836XyqGBzEWYsfu5aMin9S71MONZzO5KQ2njeg/YaYTsbWksw5RbjL1wXrVdZiF9kf6zOYxg/irqLK1friyX8=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 16:29:23 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::4777:4707:7f29:351a]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::4777:4707:7f29:351a%4]) with mapi id 15.20.7046.036; Thu, 7 Dec 2023
 16:29:23 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1] drm/amdgpu/jpeg: configure doorbell for each playback
Thread-Topic: [PATCH v1] drm/amdgpu/jpeg: configure doorbell for each playback
Thread-Index: AQHaKSVqEzsHbt1a9EKgwPLgzZ2oobCeApYg
Date: Thu, 7 Dec 2023 16:29:23 +0000
Message-ID: <BYAPR12MB269376E02355ACA51D5B1240FA8BA@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20231207155222.734041-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20231207155222.734041-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f8ca0ea-0935-4273-8c09-02669924ceed;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-07T16:28:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2693:EE_|CH3PR12MB8074:EE_
x-ms-office365-filtering-correlation-id: 672eec53-928e-4b04-b048-08dbf741abdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHuO9NS7gXBdKS/9IY7kNhxXeaTAqDEYXM8NjjnssFswDX9vZDWbpEkflY3SD95MqWdqDEMh7ESFt2wLjoz8zxqrtA0bp1cpMUPqPt7pLTv1RgMcVZA8M84um+bWkEhWtDpaN6VnNeYjAaW9RNaTZ6yPeZwyoBu/fRTOnxZ5Kwv7jsWKLEn4fVTCq/7b5xOOepxjwDZsiYj1/wl+Wujw3+VzHgwdH/+cwfUsgrB7LODj5VNVluwbXMB+HkjBntyyFqx/Odp5FpKxHGTu2ffZ0NBPR3bS94QXC4egYYfbuaNgruSftNaBbrYG4BOtODIfoW2DbnNm2UtQHEZdg+c2FZ3OcYaufss4sjI1VlPef0hYKSJ6TyAElCVuG7/aOKHm1JX1ge2b3hQYgyCSiIrc1OY9P4DkPxVzd6Zu9EUCTolmH06he/NpyFo1QbPIle0gnHksB0SP6A/jO96Cb1+D2wRxIpfFKcyhUVQXNUlyJeZ75nupxVxTqWyYM1MUIv37s+pj5ddUF2Whkjcjf4pv2V2wGvImx++5k5FCVSixLHn1C9BeG5y1e71rWdABeakAHaw85TPr2EiVuAj9a70TXScvriWYc72G7ja4f0pf6wfliR88nBuH13RkZq+bPAlj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(76116006)(9686003)(83380400001)(26005)(478600001)(66556008)(66946007)(66476007)(316002)(64756008)(54906003)(66446008)(110136005)(7696005)(38070700009)(6506007)(53546011)(5660300002)(71200400001)(122000001)(33656002)(38100700002)(55016003)(2906002)(52536014)(41300700001)(8936002)(4326008)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FcXewfSqwZRXf6NgdIr7xsJR8g07vVrJ8WdO3kZCSgSH+Wll9iUTgTb/8JWl?=
 =?us-ascii?Q?fD5bfpCibx5YwQ1sqKzsk15CRCK9O8St5C2ymtrlXKQLxFEdrMBpO2XO61UN?=
 =?us-ascii?Q?LGV1f1my2AYvSdxCgiiJTfNQncdNNVK5XhsExdfjVB5h6Jlxs99E8M63nQ1G?=
 =?us-ascii?Q?PV51wqsgs9hviUP+aKzlWgwhK1CtlAlmb7z/kVQ+1rqbnWpLWm61J807p7HF?=
 =?us-ascii?Q?3Ncq3GQX0paDiVN2Gk8DUAOWaJLEEamqfJJEun+SyPqzjvobDAEUbAih1ube?=
 =?us-ascii?Q?JPtGVzECNex3siLoi4u+vrQ2KxfSaQVogEwAEeaOfSVZUwGCJOwcDgaEz+f0?=
 =?us-ascii?Q?PQg7BM+ir+z8b9yy87M9Uw6QYEaBeOwYGCBuys4+2F0yvLuNeUZ0tKlst2ZK?=
 =?us-ascii?Q?ercWqfaKOUt8bVT/1awOHBMm4MzYqCguuj2ozCOSaZ7mdp2Ozyi09IkxTkhx?=
 =?us-ascii?Q?S2NFYG+ZGA37jVdHZFYdROgVZarKxTw19cQZPIwn9O4wxYLVXwnk+WSVzWXv?=
 =?us-ascii?Q?0WaFmzWfhLdYS/ew7/69Fr8NfDr2LseEb0OoXttdOWmsfI5p3OFiQ11sz7Le?=
 =?us-ascii?Q?cPz9bYWIf5k6UyMrV3EHcozKlOasDDPrD9yCJXlVoR0kWHTAe7G5bs3TpFDm?=
 =?us-ascii?Q?2hBTaVtmCmkHO7B4fhx15zfYkG1wh1hg9kNIFd48Wo/2GCPh1KtJU1oqPsbi?=
 =?us-ascii?Q?QF7T7MXhq+pGBESBH30mAh5bZ87M+CzwrvFWf7BTBYpJR0GnigR8ruaGUXYR?=
 =?us-ascii?Q?QvtM9leuExqN5BZ6FoI4aabSfyIb24WPPDAx6S0ZQBqrlNQP+HBSRPZ7n4xo?=
 =?us-ascii?Q?Z9Oh83w0Nqay75KB3+u2zml52Ak2pVyI6RqCF/l5bASUm3BLJtu4PUTfYEiv?=
 =?us-ascii?Q?tAimFIq9HWJEZ6R+q7W3RL13bvtAdz/RrEvvvNc6SVecntE79MloNiVUPEIn?=
 =?us-ascii?Q?Q0QRs7Jg1vPc8//VjNKW6VQT/SBTt4lQNLLo5E+KwXiqSIQEPQ/DOI9M/yBm?=
 =?us-ascii?Q?fBY9CGTgDaxGHsSWSqdoTMiSv6r5I9/3L/WKum1C7dnfnMF6lGXjUlsoaghS?=
 =?us-ascii?Q?1Bcb0W4hWGX6LE2btYRhRDVtBFWZhF5dBNr76vcutVE9EkbMe4xXpgqZNqLC?=
 =?us-ascii?Q?qO8xAB8JzLYkn7m4m80OogVj8TTykeBuskYLHke5t6U+fWMWnswmhw5h1tXI?=
 =?us-ascii?Q?Cmkqf8iW6NT123CpN7ZovJINzdwXwr+W2EgAzvmUc0iSPDgupsEFsU/H1uGb?=
 =?us-ascii?Q?5z0oXC0UsUAslN/MDNDIapPMimocQpPUiKtl7ceb6wZ0P52zpeSr5rn6J9bj?=
 =?us-ascii?Q?JpO8k0ZIeMDkyzDYleQGUGaUjtU/mZKsadiKVlB3dGy53QORGE7ZT31Z3iUz?=
 =?us-ascii?Q?PjS/Opxhne6CLhedkF0C14SHuMi6NwVK4ecxCdcGPf9bh6g1R1oSbEZ4aprY?=
 =?us-ascii?Q?mJPqTCbbB9t3KbyNyoMEbZVaLoeAgEpavFfj2LyiRf+4KlypSWf+zAGK8bzv?=
 =?us-ascii?Q?+6Z2lpRo+z31DqUBnmmNXBg5QSC2v0qISH5tA7GqNRgqi5ZXRapGnbloBC1Q?=
 =?us-ascii?Q?v9ccHXEm3Fk0YSZ8P1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672eec53-928e-4b04-b048-08dbf741abdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 16:29:23.1153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEmmyLFDoBB1UJUQiwh+72BR8mrncSaA5x/p8aqUR8M6zMdHZ/Kvp/4Bq9jgClRQBDmSMuDv9+Br0kfr/E3Ocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sundararaju,
 Sathishkumar" <Sathishkumar.Sundararaju@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Rao, 
 Srinath" <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looking good to me.

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

Regards,
Veera

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Thursday, December 7, 2023 9:22 PM
To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; Liu, Leo <Leo.Liu@amd=
.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@am=
d.com>; amd-gfx@lists.freedesktop.org
Cc: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Rao, Srin=
ath <Srinath.rao@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; =
Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH v1] drm/amdgpu/jpeg: configure doorbell for each playback

Doorbell is configured during start of each playback.

v1 - add comment for the doorbell programming change (Veera)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_5.c
index 9df011323d4b..6ede85b28cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -155,13 +155,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
        struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
        int r;

-       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-                               (adev->doorbell_index.vcn.vcn_ring0_1 << 1)=
, 0);
-
-       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
-               ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-               VCN_JPEG_DB_CTRL__EN_MASK);
-
        r =3D amdgpu_ring_test_helper(ring);
        if (r)
                return r;
@@ -336,6 +329,14 @@ static int jpeg_v4_0_5_start(struct amdgpu_device *ade=
v)
        if (adev->pm.dpm_enabled)
                amdgpu_dpm_enable_jpeg(adev, true);

+       /* doorbell programming is done for every playback */
+       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+                               (adev->doorbell_index.vcn.vcn_ring0_1 << 1)=
, 0);
+
+       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+               ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+               VCN_JPEG_DB_CTRL__EN_MASK);
+
        /* disable power gating */
        r =3D jpeg_v4_0_5_disable_static_power_gating(adev);
        if (r)
--
2.25.1

