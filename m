Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C24C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5961B10E5A6;
	Thu,  3 Nov 2022 06:51:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E840D10E5A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwzzM9WJGampLnO6VLGGq5Z7/fjZ3bF0r01blM5lz3ClaWiB9MhVLm9qnNC0f+IsLsA2BPLONqwItjr7V0llkBh44zqw3f41z3E4pxK86DBlLVFVPNjZoXuG8MdR4C2/Z+jkUOAyzUhaY18s2oGEKVfvh0KAqT/55iOaVT3CRnQJi/9wShyoAwB8eOvSqVMjvaVJ1oym4NiQMH4dvb00cX+qyRuPoV0smfF1djbOch6TUyuYLjVlAyC42To/mh5L98UJ6nqgL2i4TaK1B1NxRUloz+eurjUZzGbzrUC10kxGhg1CZMV/3oLGkjK2iE86W4kCdquQfEehFX+ftcKf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEq/7tpeQW/N68uWdpv6epqw3Bz2vP6+gqMNxlrf43U=;
 b=dLvtd1n1tVoJieQCygSeOAxdPcwonfyu7lKifi11toonHSbIovsI3x3MA2bP265NST9kRHKuFlSE6yxYWZVXkp7+YI+UMnEDla/8O8PyEOoKzdW/V9upQqzueZyGgVRWj7NqBcfwjwOuxaFHwLa/qhgv6o+PSql2akpInJ1n4kYHPJ4qkI1EJovoY+LmiVTS56Lpzws/R2vDmA0aCz9//nQLcs9aKpK9xZT1vdebSxrhZz3wDrgoX21cZwwSEJqMPJvbiLvldHx32+upIsh5nhn7YrvkNx5w8/PJ4pcQKUjiormFZbLk3eVwVHntWhGTZRFHNl510iU2ARERin61jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEq/7tpeQW/N68uWdpv6epqw3Bz2vP6+gqMNxlrf43U=;
 b=K8DB6HZYYpIwDSaVesmr4u8q+p3ei/r2IXXJ+k3MPiKeCtl4p5HjaSsTUsaPItqH3EIpfw8Et8Wy9ni6ShALOgoilS+qELSSRvwzmRlNIeG0QKNWF2nlNeXGdSbfra6UCSFWecy1zkYZ/mh23e1LJg/JlRmREevxOu8N4emhg1E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:51:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:51:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, YuBiao"
 <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Index: AQHY7zImiLs/UJjSeU+sKNbRx2BA5K4sv4cAgAABHECAAAHy0A==
Date: Thu, 3 Nov 2022 06:51:11 +0000
Message-ID: <BN9PR12MB52571E57E64A3E1C8CDA0DBCFC389@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
 <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
 <BN9PR12MB525734DF8D8626B32C26E772FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525734DF8D8626B32C26E772FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Kenneth.Feng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T06:51:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=663ae64c-b53a-4868-8d0c-019080713262;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7958:EE_
x-ms-office365-filtering-correlation-id: ed2d2302-aa52-4c33-56e6-08dabd67caf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUn2FvxdWGY7VwNvH0/MxWL5s3EbwQDvFKariHoEd2iumbZzICgCQ46hwsOhyhzW12uzjM9W1+CcUjAiHLino1ZStfogPRNODa5FzrJMc9VjphguLMN69tEJn6CuwxusngBHqH5wmvGr9VeRTLZiXE+ZD1v6XeXPMpKjtQLvc3iMM1jc6PxBFp4LmyOTeA/VNs48f3x74Oe62dzr9IIsep36XaWaNQkhrTlk6YGb/3Jw9KqtbXR+tdmPmKlCk8XXODXUV/ZwAfkLduRimVpfXSr0xVUQRNzvIgvtEUtNYZNPkwhiR1yXwVHPIn01hNSBKfokVV8Wj3lZVddML72Fi8VeMOTn1DKq+Ge0BlYbMFxJ7l5iqQAYeq4QYM+T72BL97z6wRGSIMCy6PfmLa6b+5xJih4++W5oOg5i10U+Es82EjgWqhd+FJhgTW09umNxxN0D/T7U5xb/WpiC0s/PL69sqBDnwS3NTSaGlkgfxy365uJy0cFJRVwTy/wYjKmECFbNfDrBHOJdheHdZCEoAlDGB1UjjdqW97ws6bt6hfgPVR/F64145P3b+DuWAWqAMsJ42Ai/qjI+Ykw4btfLXSQ+q+nZDcg6ma8nT7Kqflm1RcHGwIe2qxVm8VfMFHLBclJLiWTfXnCgyTwbRMLUFxcGRdlcEb9AGjcCzsypiEAn+iHFrqsuoR48I51uszaEZZbcS+/K1dYsSXARrCXV/RXwj8haih2RpeU6v/v+rzKeRZ4l7W69nx3rkzi9YNW/8QhKvSGJRQRjiyO8eB8ejA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(55016003)(186003)(26005)(2940100002)(33656002)(86362001)(38070700005)(41300700001)(9686003)(478600001)(122000001)(8936002)(6506007)(5660300002)(53546011)(7696005)(71200400001)(52536014)(38100700002)(83380400001)(2906002)(316002)(110136005)(66946007)(66556008)(66476007)(4326008)(76116006)(8676002)(64756008)(66446008)(54906003)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RlcqYgoaMgi++PIL4is3xFkCg7/ysVDMt1RaufW17mHCBegejtuqhXgLBw+8?=
 =?us-ascii?Q?+dyCcwZPhF8wmkqayFMeC8oqLS9/uAIZMrgVmMXw5q7UjDHdKlMZ+44mt+It?=
 =?us-ascii?Q?iPTpVFJjaoVKG2e5iitj5mCyStDEq4+zQLVV9NTpVLrJcSQqbfbMA/7O4Y4h?=
 =?us-ascii?Q?h9LrRqy45JvY2wWFkUNk2iqvt5uYA/sGWB0a8o1jPuvWof3z+MtmJ2WEYTdA?=
 =?us-ascii?Q?Wllyk9zgWfNYfC3V/GuvFY7xcbzQbclTGsfQUHzi1aReZ0qM0pw5zz1dOCN4?=
 =?us-ascii?Q?fJbA+jBmHoHihO+L7Ee/SjBAzcz54ynY0MJMAvNtv/zYDNNUIAlEidMNmbHV?=
 =?us-ascii?Q?cj809SpXdohZIEoURAyzpKYp8KXjhL/3Aj/q5GTLFuaf2QlOSsKgpUif2gBV?=
 =?us-ascii?Q?h45JrUFKwT7agtgxomSInMiyYLwH26ciQ8KRZiWwebTLKoY+LS/m/byj1h3/?=
 =?us-ascii?Q?ZmAG1UghGb+p3NnFtzpwX3PAJ8WEOhGnsT61ExeA18p2bc//YeIkAxO/2k8t?=
 =?us-ascii?Q?4yXhur1QWICjOtyNuMqiNkjSvcKlF2fDMOuiMcn0HQr/4lVkHFP6mNMsOwGV?=
 =?us-ascii?Q?dgs/lv5g+XeKjfGWK2lUsH1z8XkAwjW7OTNaf3wyeT2Kp5Vs6TskY9rdkuDg?=
 =?us-ascii?Q?OLcs8DaNKCOcuOXIbg3puvQ53/mTzP1ux7Ne7JHf+aNpQqv1fw3ZsI3Y9jJ1?=
 =?us-ascii?Q?z8tuISeQ+nJZl6OFQ7SiZ1hJwANqVbyopoeR805hmgqwwp6q0W4eniKl6PTf?=
 =?us-ascii?Q?toutq2LkNKCcptwE11CAqPvdLJCkOPSGy+i309ihzE8scy5PClqfib7137IR?=
 =?us-ascii?Q?ergTISa6/TEKD17f4qqeb/uMVnNCXPwnTgunHQUFLNiu4GTMuWw9tORE71Ee?=
 =?us-ascii?Q?Mrmp4WSCI85+mCRQWUAC7kYD2xrXFEoASCfuphzfnTw1UN5sfdqh/nYPcJVg?=
 =?us-ascii?Q?z4MctztR9jBgB7b+8k7uebdVeArkOuRluBrzr42Q3H1t7q3b1xLcPWlWkxJ1?=
 =?us-ascii?Q?oGeJcsnxkvmfwzCsQTFnS9P0Jl1RQY3/UdyhAFxt51tnfxoR0+GQwcJFhwXZ?=
 =?us-ascii?Q?TulT6svx2552e/eA6OTAUBL/xhE2CviDnvYSlWgAMuyyvXxIQqwPCDrIgJbv?=
 =?us-ascii?Q?dSNU7Hxnz0ndv1N1c1NyIie1rDA6rOySwALTMF8tIbqccT44xp8lXY5lpeQt?=
 =?us-ascii?Q?wXlNHYlThe7qM5X3dP6tq4iElb3aypp8sxlBB+fOw9SB7BHmNhjcIu0cG54d?=
 =?us-ascii?Q?q9App9upaC2mQhyH2KoMt5KoDs3mP0yHVpPYbP0lnpIzO6FNtncV/pw3MsMI?=
 =?us-ascii?Q?LPFGu+h6Mc6wsTzPefOGOFmuA8q36uInpYgzbwmxLw5tCiISFvvUOrwTZUAW?=
 =?us-ascii?Q?9K2+2NCj/zRMfib3ASXTFUTAOuryNiSwrDMKBWysJZuG7j2bflVs4PJTU0Ik?=
 =?us-ascii?Q?YP9fBnQHEjZNvsTt+lBheEpZPRCgl2NAU3gn3pYaCoXQmvnkFErvCBm3TA62?=
 =?us-ascii?Q?j4iAV+xwEcpB/iXvBgDfkq1N9ikNrvzY3vq4+Eupn+VkPWNWiFG4b4ASOfqt?=
 =?us-ascii?Q?C4SUTp63EGDSOdRX+ubBesc74mrMOURH7jWEFK5z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d2302-aa52-4c33-56e6-08dabd67caf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:51:11.0195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vg2EQ3DbHm2Q8XOheBiBz9EPmlkvAxvcOF1mF7mfnoKDqMwh6JgN17y3BqMtTF+E7RgQ7ZfsQfuWHqXtN6P2xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Btw, if the concern is the gfx_late_init failure caused by incorrect settin=
g in IFWI. @Feng, Kenneth already have a workaround.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, November 3, 2022 14:46
To: Wang, YuBiao <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tu=
ikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koeni=
g@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

[AMD Official Use Only - General]

amdgpu_ras_feature_enable won't send RAS command to firmware if it is invok=
ed from guest side. The change seems unnecessary.

Regards,
Hawking

-----Original Message-----
From: Wang, YuBiao <YuBiao.Wang@amd.com>=20
Sent: Thursday, November 3, 2022 14:39
To: Wang, YuBiao <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org; Zhan=
g, Hawking <Hawking.Zhang@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wa=
ng, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

Hi Hawking,

This patch is to skip ras init in sriov case. Please help review.

Thanks,
Yubiao

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com>=20
Sent: Thursday, November 3, 2022 11:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@am=
d.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <H=
awking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@=
amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Wang, YuBiao <YuBiao.=
Wang@amd.com>
Subject: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

In sriov guest side doesn't need init ras feature, so skip it.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 84a76c36d9a7..be8ed617e269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
=20
-	if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
+	if (!amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(11, 0, 3)) {
 		r =3D gfx_v11_0_ras_late_init(handle);
 		if (r)
 			return r;
--=20
2.25.1
