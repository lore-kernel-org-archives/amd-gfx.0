Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E336C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C93F10E5AC;
	Thu,  3 Nov 2022 06:46:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD1C10E5AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG8e3CtvTApHAPwScl8c6iQTaHBzbSQ3yknr6Z5Yyb9i1FJ/vTSsE6reZagdsedgL4OU43hs96xPeL/VJ/gDkLucNN8LOM5j5GwL6vEFuCQXqmoUBg3aiCxeRdICz/yOkE0jszkbhtXNkPop/QY61kyDN4dratq7NEjhcxJ4V8NCsc9fIJHOFa6vtDGdGs2rG91LCaf0oV8tp8rAsSOUhJZjG0w/sfcQXjJapPVHjlFiYInV7PfD0sLrBoNLwoT9X0cvcWxxr1x3LCHHvXDxzrjCveFIwj+l3NOcttXkdr4WfZxFOxoRDBb/f+ZqvKS6tuJwXJu3v850mzkdtoZEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1hmh5bAo0VC/zNQ+kj0K4Vt6nz9vdYEbvZd8XWCOcI=;
 b=Sz2sPS3MAP/taXPrXL9WUcV4E9Ckot3Sbm0FNgZshIFx96u7mu+OappoeL5pSis54+AxJm01yExAEkLO4DekQof0u2Fm05tKcKbGHjPKBHP6sSn6Vtpder8uaPTHdIOgguS/L8gpgmwBCVXt1Pk2fC+BH13aP4clSfZvgmAYgbdt2k0w35xzdltxybUmGjwV/IRPHS5bIHq05lIVosJW3Ii+1X5kHb8ZTyb9I2R1XRuMrAzgEvbDhjheAgsR6qMEd9KJX6mMiKwG+8BE4DYSftoC/AoFP+yBpSkvRRcATQAuw5lRKs/tXV80vvQA5JEYbvNHTGmElfdNTmPhcljAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1hmh5bAo0VC/zNQ+kj0K4Vt6nz9vdYEbvZd8XWCOcI=;
 b=qRsxiHXFYBxYGrkGnyEdg7Ogp7O8bP9Zzs+6jdHQHB9g9vh7fI8Vg3AWFUfqnKzTlS8ZSsfMpRoOWbH+7ZgKUytskKGDaz0Oq2PId3pfvIikZeFTepV96wxXVFz0+oLKhUB/X4HAZNRrP9aQ0DO+nhJeF6vn2fEvFYWhVcaS0ko=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 06:46:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:46:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Index: AQHY7zImiLs/UJjSeU+sKNbRx2BA5K4sv4cAgAABHEA=
Date: Thu, 3 Nov 2022 06:46:29 +0000
Message-ID: <BN9PR12MB525734DF8D8626B32C26E772FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
 <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T06:46:27Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=663ae64c-b53a-4868-8d0c-019080713262;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM8PR12MB5479:EE_
x-ms-office365-filtering-correlation-id: e8ee04d5-c70b-4f99-f870-08dabd67234c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxU+4Nf2Th5NG9I7rb/dCZsT7DxdxSDblO5KkF/1VcGxsIM8w5uDBUo9mmdsUy8uVAJ+/7syTY3RP3GkZy81IZBl72rRcAIfXcKX2zFwX/yokz+3lXuIeLAlr+yHwqUb4XN8nbIY4u12+BvWoAWaWio/z7FFy0SS0J2Qi31fIKkVgZzidDZPrSOgJI7unhJM0BHXWkfREdaEEtqfygp3AMhyuU0GZIX9F499DZwMp0qIXjz7b+mAzzouHt68O8azmh0HnSSrCXamv6sE16wKgtpcIR1MnPSieP6jYgTSMfkodvZW+fD7A89YOb0+yWug2xKepWWHQlpqkrV0ItMnX+wVHdUU5HVH34HTuU/bMxH0UXgorFPHWKDw7Im4q1ttye6PGZs356UDJt2xLj4a44v0gzTBZTq4SAYtTG240Q8m9WKmzhfVw3gm4D+m6rubS36btfqn1K7mlLeqaHT91OuQYs5t6qkdViJg4RohZfZrw6E8xTaNfyZmwON4APEQw3MXY1iMI3Mc4UFQMnCDkuC0eDhOmWz9TPQM7bgBtiKVBdiYPRIvHb/oR3CU8xyInOeShVhjcvsTKIyO09dOrgOGxWa1eIn4RR8SnwYujzsfptqPQEhFyqA2cEWRCiBG+LUmq/VcZOJhXSpmvhYwDU45tf16StNAzBEp3ZpTRQUOEA5kHEI2EHKxwm/MKfBXFTlXAo4KqdAR06M9QvY1ZPxa6L5akbJNZqyRsMQqFAQzIuxl04k2qNtqfo+Y0HgkXZPfWP+6XT1DOEzXwCLeaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(2906002)(52536014)(8936002)(478600001)(33656002)(5660300002)(66446008)(186003)(76116006)(66476007)(86362001)(64756008)(4326008)(8676002)(6506007)(66946007)(66556008)(83380400001)(54906003)(316002)(7696005)(110136005)(26005)(38070700005)(9686003)(53546011)(41300700001)(71200400001)(38100700002)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?czf9u9qObbXw5e1GiLTtKxhMtTkHGnjjKGiCo9D73JyJDvcejDAEKNuxh5N3?=
 =?us-ascii?Q?4+uiy1E1SWd5O7SeR5XadKiFDAlMNp7ivhISIJZWtV2RVgDvzKBZRKoz5zcY?=
 =?us-ascii?Q?u8TuWakMFV4XAzuxklNIVQxPFTKo+IHgf9qVtHwGQH4n9lwbuO6aV4EU/HRE?=
 =?us-ascii?Q?VZsA64lmjY9d5Kr+N91HtFfJyyUUG/CaQRcGzSvOOMoPye3bzr9lIYpBncOW?=
 =?us-ascii?Q?niol75wCjQuhmkpahM0Sn+mTz3AoR7E4HiOnHHGaeBv1EAl9o91nKJJXAFdd?=
 =?us-ascii?Q?91ISn01ALFBCbDTSV1n+uL4ScWXZ4yO5K0GF3+7BDO+QE9DLNEjIv9ZFqEbT?=
 =?us-ascii?Q?Hdo5NkkkjAKSQSb+q5veXTKluo7eqFiJlAqx+o5aZQ/troTe8W/c0O5Zew8v?=
 =?us-ascii?Q?JdJ+E9glSaymVJC2gkUPZYmVQLS5joh794sHksRDMsYaMOPy2cGVrmEhQbPv?=
 =?us-ascii?Q?TiiYOkRi65e6VHd82SiSWv6cxDAT6M/Ns9kCiB9pBB97zzFR6VRTfeoWIfw7?=
 =?us-ascii?Q?UmfuzIosn/0FL9P2O4ljSvHKAMlJs+zLE8+s9hs3IWaSw2DsyWk/k4onQtpd?=
 =?us-ascii?Q?s+lSAn0oRzu8lgPaYcrv2V5kuOsIZwD8xs928i6AQlPqO+aJbWNkszKnKWX9?=
 =?us-ascii?Q?u1cZeX5DPik6kztU4TywHjCEB0zTeFX3G9b6OQLC6pHpioBmHoc9RmBWEdSi?=
 =?us-ascii?Q?wnhnjRo+nr2YaqPDWQDYE4B3Qc858zK3RtMXGB3qosHJxScmHJrEbG0gCcMy?=
 =?us-ascii?Q?jRZq3qtHyr4GZZagi/nOugXzyjI/K8zQql8dALLFsVvwe4hsHlvfvu88ymee?=
 =?us-ascii?Q?Mf84Qbg+LjFkE0A3PDEJMpesWw0mvxpyW0QIjh/kcTv6QzDc66Sq9nno3fC3?=
 =?us-ascii?Q?AW2+x+BZSML8lhtOzVDmQrzPGIi93/FZNTQ5eLvjiUW52+TK05HyRuqbOn5N?=
 =?us-ascii?Q?WzZa6siHentNBfVBnXN30UODS2cZTD7yPfZrmNZmNpebCfyxb2i0wZuZncFl?=
 =?us-ascii?Q?tdUmBjYPf9GPr2Q5O7BVL16wa5kOp0l2tYop5ZSoIICJPUlbOdkJhhekNkFt?=
 =?us-ascii?Q?qjkQbiQQQ57NQzPEbBhG/q8lUm2tFSXAq4t7i8oaVbQqcrY93mLWAOvNf/NI?=
 =?us-ascii?Q?HnztMamzOT/muY/M7C5chWxwWnqRGHUr3ongw9Fu8eUqCI7P9K/5BxzwxPi0?=
 =?us-ascii?Q?Qd0WJZGGYyJ7SXY51UoD+KfzTR7FHYtX/DUKhBy4R6AjMIF09LN0s1NHW5KK?=
 =?us-ascii?Q?fNZr1lDYzRfBQEJhqTbVAAaxokJT4E68jUWrjtluHbP1RVvQhr/JlUwJLLEQ?=
 =?us-ascii?Q?pI19YHbICutqehP80/smvkeprsyi+rhlak3eyIXAcZtaqrL6Wfst4qnWSTFh?=
 =?us-ascii?Q?XEXGqA8JSYZuYrJZYpKmtZBQiHw3yyRB33KoFBdbpRh1Wcl6JAXTfSKslwF5?=
 =?us-ascii?Q?jK/uDOP8DKrPS9Wjx57fhMVrF2rEWfXMyDbKD9ItWU2CpJiWbsSAWXxfKwyT?=
 =?us-ascii?Q?ttI5hED9BSs7dE5IEg5XOQTHJNlKAj+LXLG5D05x5K0hqT7YemhzXOb+l+mt?=
 =?us-ascii?Q?7pgtNpIOsuLZ2xry+IZ5K0UINN4fwbNYeXGr3LXp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ee04d5-c70b-4f99-f870-08dabd67234c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:46:29.7406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP0+qm0V1OCifZZJqOE6jVH1GDl/7yu2XEH53q46/Rz4nStGmJIygGpMWJSqgU07RgVUjJu6gY2SK2k/3nYlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
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
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
