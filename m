Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8379CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 03:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3445B64F8F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 03:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3445B64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6FE6E0BA;
	Wed, 17 Mar 2021 03:32:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5EE6E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 03:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUqVJa8be0zwov7Ueb1tnOuq/ttQgsLcnl/YnFk+6EqTS2zrbU7rl3nU1Zz3noMsCPDYFqfC2n56yhl3wYkDvYv347csTM21/pWBjreiYGXfQFlx+s4I28fYmlEu9DNjTsAg8iXN4GFXUDPQsYjzIFcnUaqGhEfChkysf3M3tUPeyUawfqc7yGGVh9z5U9qKNYkwP4tenbhlRJBEJFvJIRkQIXB4OWqNutG3lLlwa3oz4N2oB6WHesZjv11Dl41e9gTO+I7Nwc/zBQPdO5HlnruIgd7tZn6Q7k82NfZ3SagQo9hbVOHdQiDDv93Sj5lo78hRKRuasHkMpIm6jm2IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl7ie/nzy/OFI1rTHzNX6RmVWWG7jXJcYN8456iRCJw=;
 b=IJ6QU5sr9nUdBIKwb+7GI2xt+LQK6XG7pPtxlOIXQXYfQf3jEKMQNSXtRc9bTJe5k55ZbjWy/2pSivxtfQG1qGqTkm0MAI5gXYBZhZhmfO7y0OwuCqlTb5vpfFsy6V9Mo/fcicUuMH+LVLdU421H7NjcmoR+C2WoyeU0J+MyBtPum41M7Cdl+HwqqlnwkAzRBs8Vru8CXc/N/PwuaBQV7zhfuOjMECJtqR01XPyT6eQDKdktEwpUgVtSTd6SEtSVLcWZA3UWR8qB2ibAvqMVd3Xh4I1KPwuxVtYjvVRq5b0yEZItB3psW03QawT/B6VOqr2qJnxYebVJMFsFyKtaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl7ie/nzy/OFI1rTHzNX6RmVWWG7jXJcYN8456iRCJw=;
 b=XWs1PtrlSYHkpKUPnhGtd/b6xNhfTo80zFGF8JcowxgRwrChjvnVjyRCwdSC5oCAKfwQR1S78Q+Qj/trHGJio5DJ7Iktl5O9hDFSYhNlV01QwSK1SP4dATwqaihcv+f2JTiF62apbqqjyjPs6sHGl3Sg7bFEOlqSWHx1nxGzq9A=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1656.namprd12.prod.outlook.com (2603:10b6:910:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 03:32:01 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:32:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "R, Bindu" <Bindu.R@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Topic: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Index: AQHXGr8fwgitnFi1FUaWsLypJpIgxKqHaL+AgAAde4A=
Date: Wed, 17 Mar 2021 03:32:01 +0000
Message-ID: <CY4PR12MB1287C50A1F73DBEE391DA64DF16A9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210316234952.254296-1-bindu.r@amd.com>
 <BN8PR12MB363370FEDCB6A5BE867005638E6A9@BN8PR12MB3633.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB363370FEDCB6A5BE867005638E6A9@BN8PR12MB3633.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-17T03:31:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4e4bebfb-5eeb-4e42-9480-1945e5983439;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fa3fb26-eb51-4e83-23ba-08d8e8f53a36
x-ms-traffictypediagnostic: CY4PR12MB1656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1656ED7601BB7553E27A9D1DF16A9@CY4PR12MB1656.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGg03ZecEdouamwpivWT1hJH3RpQ1eKD/4/fe5YdbJZ/PA/QCApQ+N1L0wDGeGBPPj1qNzfXsJLyao43mIshzgyYZ0LL2xJAJw5Alf4r5PtocxYy8KhZaNY000/qEGoazvCollrRECPtzW6DJyiBzHSCbeTnGOyVwwThJ9mLrPPAcFhaUFoUR86t4ywdgaTIYrh18/rEQq41a0Cx9De6rvsppR4i7R8p9YLfkuu7o8kYje7wbQ0sc0uuCfAzLbvNEzRBeNKTunxyfDdX1Oh/xWxL891qawNOGz2rG2FMe58wRQQL1nqVGIDKFrAhI370CT57iPZRmYGFmreruFCO5hkLdUPHC/K0VQw5ho7co5UhHRuhEs6VCvLtYn21MeI/vJpYVFslrBxhi+BloX37XUmIfBOsXE3UAozgnhRth87g+vn06gVEEIXWTD0w40HF6joNym1l5xo7wNHH4DTUxaz/MSOt2qVtT3SX6tP6cilglb6PEwif6Vy9gQ6vxtasWaSdl9D4SyqoXHft698YoGeCxWspe+4Lz+H3cppjHy90kfnStEmv+DruIzwSQH6YZ5iMV5AI11bxNmATT6OmpbeO2ViNo3K6XnFhr6lI0cQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(54906003)(316002)(966005)(7696005)(45080400002)(110136005)(186003)(52536014)(66946007)(76116006)(64756008)(86362001)(66556008)(66476007)(66446008)(5660300002)(6506007)(2906002)(33656002)(83380400001)(4326008)(478600001)(8936002)(8676002)(26005)(55016002)(9686003)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7vpXZB1f/9CoXIF3m4DT7CuuH3dqLKwf12QoXQ7+PG/pAQZ9C9qZArb2coyJ?=
 =?us-ascii?Q?gkkrY5FvhCJpbLFDOKhnHHYjiHB8TMx5e7QvwEn2y2jpRqZj18O51Km0p8fe?=
 =?us-ascii?Q?G34jjnQWHdRu8OLQjrwxPTct1n54ezn75iHyrAwB99Lvb35tCVv+bmjYpWC0?=
 =?us-ascii?Q?WwyhSgyTMOr/rthOFzqYEYD5PSLzYARrOzmSrrLw5pzz1NF/MiOTqPeriLvv?=
 =?us-ascii?Q?kefkwMcOQqaTDvJ51RC5vZFOiQAQb/1HMXrGD2lU82p1R8Xo8AjNzLwlxADR?=
 =?us-ascii?Q?dlZrlMZ4l1a6zshggOKOmxbsCuw6li+49T0DVo+vZ1Krxh5OxYGYc4UgB6sT?=
 =?us-ascii?Q?x1BlXahqtVbYN+6/ETPx5U/kIaFtFw3WMRSrx+rFVLHGI1a459CaVxC9BCtu?=
 =?us-ascii?Q?dxLkP302Zy5fplA38zInylaPsYSmyMeP7hrw1A7pyg2XjmOY6E9JqvNLcUjy?=
 =?us-ascii?Q?/ZcJlXHQ9U2Ge/BNBpX+sT0dPC5cNXTtihmnFGg/myYKCqdxMD0iorNdbdq3?=
 =?us-ascii?Q?FJ3pAcbUwLYVPTozYG+kRVHGTq5qcG+8QNbM8FH0nm8ko6OsjV1CV9yCcbbe?=
 =?us-ascii?Q?xaUzC/NyLa8r5INFAUdVYntzXXgsrMulNyNKf4gIxIur6lHZaERFfZdQ0rhG?=
 =?us-ascii?Q?uMDlg+7QoLDBq+ynO3m8Yy6FrHEM4VEXhCIfAp1RPVnqWwHJcXV9hV1NiP77?=
 =?us-ascii?Q?CoytxSwqOiNZdLRM/8ay3/+gQBvN4BPwugZuDNxDGk+XrulnDMdWtPvvbBwj?=
 =?us-ascii?Q?0LY5Qar3pHKC0hAXq7K+2igexsR3X6zU67esQl9t2F8eNE4FOGH802ZSq0eY?=
 =?us-ascii?Q?qCvpjnMpBAU/aq7WbgJKQ4otMASrLzZE6utNRpReji17ZBXgLa19xOvTjjLq?=
 =?us-ascii?Q?JHt8bcKKsC4QUvnEYr8Pb+k9XbV1pNngST0tyYiCr7HaxatiKzXMCGhCmVrX?=
 =?us-ascii?Q?Y7CArVdVv8RW0pVExtvJYWL5oFFv+ObdsJD5muBQQCjke2sPqSoedUwYQWvX?=
 =?us-ascii?Q?qben6iraJxUiwyvJN5y3oX85wmI2KSPhaYDdEoLDZb7hR6Fxs1ETcnnTztN/?=
 =?us-ascii?Q?CogJKDVj92xyb3uJf7/yp5VTVEllxmk7w8zL3Q4XJ8UEWgIXXpWkVYv9eNZp?=
 =?us-ascii?Q?Fjct3EI6hqop1HK4Jtzj4KCKJCoMSyZ2G1ZJ6PDoxQqAj8LmQTkFv88bvUGj?=
 =?us-ascii?Q?rnF64qwEmB3d895+XxWEwuhpHf2aHurxDT/hl7XoIePSJx0CDfnrIIK8QAh0?=
 =?us-ascii?Q?YI91JXnopMF6N0gHorQuz+WJTFGaGIZnB6dskQVTsUaJLEz6/RcMhbSX93+p?=
 =?us-ascii?Q?WRS5WsMCGRG0oyMy1UotlPf0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa3fb26-eb51-4e83-23ba-08d8e8f53a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 03:32:01.1814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N69N8yeWBjkzJQ9wcj6/APYHF6f8ExAPQTIVCEXuow4hOQVvo0OVSEFUpKmF1MQeS67/6nMKbp8p7UqVGD/Ydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1656
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R,
 Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+    /* Allow idle optimization when vblank count is 0 for display off */
+    if (dm->active_vblank_irq_count == 0)
+               dc_allow_idle_optimizations(dm->dc,true);
+

Above part needs to be guarded by CONFIG_DRM_AMD_DC_DCN?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feng, Kenneth
Sent: Wednesday, March 17, 2021 9:45 AM
To: R, Bindu <Bindu.R@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vblank.

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bindu Ramamurthy
Sent: Wednesday, March 17, 2021 7:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH] drm/amd/display: Allow idle optimization based on vblank.

[CAUTION: External Email]

[Why]
idle optimization was being disabled after commit.

[How]
check vblank count for display off and enable idle optimization based on this count.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 553e39f9538c..56a55143ad2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct *work)

        if (vblank_work->enable)
                dm->active_vblank_irq_count++;
-       else
+       else if(dm->active_vblank_irq_count)
                dm->active_vblank_irq_count--;

        dc_allow_idle_optimizations(
@@ -8694,7 +8694,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
                WARN_ON(!dc_commit_state(dm->dc, dc_state));
                mutex_unlock(&dm->dc_lock);
        }
-
+    /* Allow idle optimization when vblank count is 0 for display off */
+    if (dm->active_vblank_irq_count == 0)
+               dc_allow_idle_optimizations(dm->dc,true);
+
        for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
                struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
