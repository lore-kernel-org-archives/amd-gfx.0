Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43771C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 20:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38BD10EBC6;
	Thu, 26 May 2022 20:46:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59BE10EBC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 20:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezJlLdnkE+L96apusUpiYD3uiWg6U+BaktS6BWfGrT2jcaPIvakQA0eZe8Sn7VVXaSl7tBYan5LLtMtgRI9p8K3/uz1CSG2LZ2bqq/jxgbxTBHR6rwSnrV/vwfq6hFCGn3VhKGLD1uup3vAO0L02Eo/aUWeJtVPoNxFB34CC7y0W9+oxPF9QJ+0lZR1+n+O/2fompWPaW68IWbSm5avcF2eZf0xFu8MEQKUoMvUNSkTDux2KmqjEDzbkkx7daQ26LkZyRLs5hWaNlEb6vlXRXezMuowWp68WAZKLbdyVbiZpiSo3y8ftFtPJfBMxbzjTFivYslPUX1Eo2mqbmydjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uKXmhr2FLUb2hMtXY/UjHJIcM3Z4q2xYNM2C/dtEdQ=;
 b=hWoSNouu6dt16jhzHFvoq7Y3/Icw69L6YFgZ4eV3XXix3shai1OlnQBO4nKPnB6z8M3W0/AxDb6DZ4U9qGy0HJtvDPp8uRcS/NJgc7EobRhFVF0hLjEuDNuEINQdVzFP3gouElfa0OGDIZfwxhqiGBH5MsPN750tN1++ZIyQayzDxv+NmZKFvkc6cchQRKvpXpT6WH0pNXOrZtRkY7r2Htkx6XmEXl7Cj7mUsF7NjZjQ8dKvK5FdjnV4DEcPdEUyeIuOcBqdWKPGf7C8S4QwOsPV4pW1sIxiYFMNqt5LSb2tQKVr2Ruo30WbQi1Um/TEXQZ4zfh8p1wFnDCKL/rPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uKXmhr2FLUb2hMtXY/UjHJIcM3Z4q2xYNM2C/dtEdQ=;
 b=mY7cnF/G/XurHDuKHYTrpd6QCzdhlKCuF28ATvnFpm8ZKSLgcqOuf/3BNXnPyvSXVqc1pUOsFX7coNPslE/trvJMIJi4WK4ovj/XNxe9i9RpW2oestKRnf877B7Qxk+tgiojuPn+/pwbad1js1aQ09eVO9+VryfToq/JnvOqHWs=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Thu, 26 May 2022 20:46:46 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::4d97:142:bada:c300]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::4d97:142:bada:c300%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 20:46:46 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update VCN codec support for Yellow Carp
Thread-Topic: [PATCH] drm/amdgpu: update VCN codec support for Yellow Carp
Thread-Index: AQHYcUCr1A1jJ8x5lUGPihIWknmQT60xoNEg
Date: Thu, 26 May 2022 20:46:46 +0000
Message-ID: <DM8PR12MB53994D22058401B9BF44C42EE5D99@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20220526203857.100936-1-alexander.deucher@amd.com>
In-Reply-To: <20220526203857.100936-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cb1463a5-ec93-47ba-805c-19d61a6137a0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-26T20:46:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0fb3da1-a548-4f0e-e202-08da3f58d995
x-ms-traffictypediagnostic: DM5PR12MB1162:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1162B0F7D68D3321647493E4E5D99@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbPgot5XwyQt/J2RsvU+Em8lRUkgojibBxq4lmQLANXYlKJgPff6LL1ErX08kuBkXCFjdNsv9F3W3bPCfrXV5l8Ehq4Wl2xUY1ToCjMPV1IiZk6owrkCb8DYyijmoIIyEefEcCBLzcXs6sDu4iX29cwNRgQHudILeeNz8S0kjvbiGq7lAxdhgFZ/Qe/2gpmtiYErcnioXf0cu3YPsXaSQ5+e/LjY82fPTU+pVZm+nTu8gyK83UOzCg8CLYVGwwxvOieJFcSySKG82IvmCgRbb/bcclt0pQtqb1ZsIJp18ee42ihhlMhAmwafjpWaTRtiIaDkfrrMKBOT24fBjTAT/1SH4Thr8Bv76u9DcDvDdi+IDlb0n5pwogQgFsHRfTxgMkpHjw+5U1OXRdjBOq2mFi7X1LEpFlPF35Pt5mobY3kI3amsINnDofqdKgB2WrVs0LbvCZ4CXbZFrRskbwmWfcGv57IHB0g/REu4VDpOUZqmUHNPn+J7e+sJnhCtAdDCqcpyNpez8JWvDcpZg1I8sz90pdc4fdm6zToMIlzaHSKdRqAJIKhHb5gdqA4gDgFZ2jjQLJsUwjfJS8jBy+2pi/pTdeNt1cMW81xVVvBrN0/5Bmh7zSD2xdnQYqaLanX7NDt4xCPmJylcmGm0bb7XDkg8R5pilNKml1JGA4VzI58F/NcwFG6oKeA5FjG0VcTnSU7bTZ4PJ0Rk3+m+ACof8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(508600001)(71200400001)(2906002)(15650500001)(83380400001)(86362001)(966005)(45080400002)(186003)(26005)(52536014)(4326008)(38070700005)(66946007)(38100700002)(66556008)(76116006)(64756008)(8676002)(66446008)(6506007)(122000001)(8936002)(7696005)(5660300002)(9686003)(53546011)(110136005)(316002)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DBfV2vC/OmU4E6cwLFJKC9qWOqZq8ql5y5bL2YSjF6XXHehV2z16KSRQf4my?=
 =?us-ascii?Q?WGKE35A0UvU5EyfNt6GN78IDaK5FAwIzQpRO19tpHRuFBoZcQRoJEuEGWcaa?=
 =?us-ascii?Q?EwwPrRsGEctGsAlVGiD9GOznsSihKVf9AdL4Z/DwJxvhlVPLJKVGpG7zot+h?=
 =?us-ascii?Q?QvKhds/KgzgZdz053eLsjPEsUbk5YwUcKxzWgxgmZgGyVAsk1bL+BmvqcLcn?=
 =?us-ascii?Q?m/crPhcyGURMJI5p8eQQrlhRkO5xBGFcyLrkTlXDnryTJurDwu24bmPjEt/f?=
 =?us-ascii?Q?0e97tdVebueWx9yKin79zsmzdqLNbmwmZNkoBMkMnjslSfznLyB5VeqSpoYA?=
 =?us-ascii?Q?w2Tu1Y4dZEG8SbdJXffSRYQrmrmtaiPKBPiz8SDLrj6iUKk+f/v0I6TsTsbh?=
 =?us-ascii?Q?VvHzGBZzgK+xqQq0yYiU1/jo+//dIC4AarbqmAKn/Ssp/YJfXBXWbZ5kroQT?=
 =?us-ascii?Q?+ZuKaVZUxHYTJIhkYLeoX0OU3Fsm6sMVhMGc4BSeCJToexlXmNMSBYHyj90u?=
 =?us-ascii?Q?25yMzdCjK3etFpY1SmyTVz69EOsE+lmhktwAfUR6ZRD29vjeP+BQGdtlOXYo?=
 =?us-ascii?Q?2lHKWTD0jPvzJs4gcjN6oSQ+bYxdNVCJH+ZEbRvyCYX16PiqWpTforxiU+E9?=
 =?us-ascii?Q?xDKShXwCSAz9mOqAW+bztOTz/MLvkx3KwfQ1ErKYe82lP3yANuhgRlDOt1db?=
 =?us-ascii?Q?pw/ZAF7yzLTYx+iCaNKQaykM2NDAHwNVgJB5TzKDe6Cj58iBNOIItlbJr4Vb?=
 =?us-ascii?Q?Omrhy4/edn3QKB1CO451ClSRQGgzaf1LBYmsAtVqCleBqa5dR8VKiNC9vXGH?=
 =?us-ascii?Q?aR8SFJ0TN1sTsdS0q5c7BCCnbVr0tezsFuTUSPtRTzTTwU9aEB9vTgbzthmQ?=
 =?us-ascii?Q?exMgXUkC+qJtjpUnfV9h9jKyo+SGTaMogJA1ZTvu069xiMfhu+TKfuSYP/T2?=
 =?us-ascii?Q?EUok8sCGSMGW8bGeokm4RcsYLYguKuckHeXmlQYBNq2VxtVwXX7Gya+Q8jbH?=
 =?us-ascii?Q?6aSoACD/8FoVNF6tqzdNdg+ml7qIoasyqVTBS0hN98qniILENxFBNjBwenz9?=
 =?us-ascii?Q?sKXXnk1rddAK7yQZ75q8kFT+9cXq9duMhQomEwdCwhibqJWA+p6xjM2Xefi6?=
 =?us-ascii?Q?KjzmQ3j9k08jYnLS1m1DKpZoeTLdXPthzFjlFj3vBgsbpsO4fc/FkmVw8VOZ?=
 =?us-ascii?Q?Mk2pfa2KbvsvdJLlikxg4XC/GitJBzueoxsMCvJpuWmhqiIh0iO7qqBAgWPn?=
 =?us-ascii?Q?uZlxn/fjZeLL00AwyHQ+InlpJzne4cLqEfFgyRi6QNpcAEx2jqE3MrcP3axd?=
 =?us-ascii?Q?C8NvDZMuRM1e5qTKFh0OVYh+eFE8W7muAPWvFxCjhNjSUBxsiop7Uk3N/T4q?=
 =?us-ascii?Q?w1XkeEkI1aV8SdGBVJrUs+r7axpKJ+JSdmGvBvnabwQSc8UfgfX7YPuNvTaA?=
 =?us-ascii?Q?Xt6XIcupIH4m73H7m0d6TPtOLTBADxP4WkI3KGVgaVBIcaJS/6w13Sjb4rfV?=
 =?us-ascii?Q?13KlocDv/7bM4sPy6bk3hh7XO+XO8PIPtAshCjBdMCz3uN5paKhG3ciw1vzc?=
 =?us-ascii?Q?Oz8QySQHkOmYRFPEo4xWAyaE/Q+xsB5DLaLTOvYFeEs65h63J0HJvGnrBZBa?=
 =?us-ascii?Q?KNdbTRNGBuii/MDXrlpdi6ECYXxGOxqQVNW45ex+s1Vp9iM1k7JEtoPldXmq?=
 =?us-ascii?Q?NUo9C09SSD76vuSHq5cbtcxy6qMQzDV8WzUqNrCxqjO0afQE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fb3da1-a548-4f0e-e202-08da3f58d995
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 20:46:46.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTmcu5tSXBufv1iL9U7ocZIvr3tG+cYuErpuU6wlDkCOH9fdyZTtbmMqsQ7l39Ay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: May 26, 2022 4:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update VCN codec support for Yellow Carp

Supports AV1.  Mesa already has support for this and doesn't rely on the ke=
rnel caps for yellow carp, so this was already working from an application =
perspective.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2002&amp;data=3D05%7C01%7Cl=
eo.liu%40amd.com%7C097e1931973e4c1b9fc308da3f57ccc5%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637891943577189959%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;sdata=3DuW264nO7bt01lNcMxyFI0NUGQT5eb3Z2yFuX2pdnvT0%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index d016e3c3e221..b3fba8dea63c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -170,6 +170,7 @@ static const struct amdgpu_video_codec_info yc_video_co=
decs_decode_array[] =3D {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
, 186)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,=
 0)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352,
+0)},
 };

 static const struct amdgpu_video_codecs yc_video_codecs_decode =3D {
--
2.35.3

