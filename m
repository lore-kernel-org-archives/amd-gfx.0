Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58ACC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 01:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8128064F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 01:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128064F3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC2889ECB;
	Wed, 17 Mar 2021 01:44:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D291589ECB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 01:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTXj+IEIY1j1im20y+bSjMriHF9Ag/xrihoVeUCXJK9WSLYisxDSwKpMJP0kAlrMMMdi78ZgvubiEk9vP3ZhEJPt3nInEwNygZqzdLq0rkR3ZJF3PPB2ieqXZ/4chdqYAeIUglVBMm4fnnb3FSFNKbyEWVC5FA2HLNQ8bgcwg1ygEHikJMuFG7lpKwzfPXK0ERmggij7y1xCji+LIAWDvV55I1Kaj7P2wx60th8IDad6DxzDFI6LSqULS2cOTms+RyJvXRk72jeZfyD9MU31rBn9yBzDaGZei6Cazi8Hv4Qi2eafJaLJuv1M+HzDRD24PvEi25oRPRYdemDVXfi2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7JgLpqB6pAqI1/HryqSpAjGsDEZnIWIGwBPYoYvZgA=;
 b=mej4PnunYVOTxXgWec97p+d+OdtG36JILPOo5gT6E4ecI22etnxOZc1zDUs7cpqLIWYj+k+tp3IF/xcCojhN0fTqRGUMXiXZMcN2PZZDYCiY5Fs+d67pgDy2mXQr12Hi91y5NP6bmvpwSrLPU8vJn2Cl3mESDgcQxSQTR0cCyyeDhzroi2ULxc2HcUN3CIFN+MQYLvNkZ63Xgc6n2o0GueqZMMsYMrE7h50QreXOPPe8tEabblnIpgJswSQmCR2HcONWt1RNLTc/Jpfw3s15cNRbXqW7sZk8TJ3F1r2hnXIHyt3BakEHa0ZQXvUkGq97QaPPwxleboks8WkoX2SIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7JgLpqB6pAqI1/HryqSpAjGsDEZnIWIGwBPYoYvZgA=;
 b=MsKwehexoDxzhdFeEAqwgDF+S5MwYPQurAeh8xfSMq1DRHQH2vUSmU1e4J3HIMA+UYIA1HET4lOlw+JspZ9jXLVXq/Y4M/tR7aRqq6hMpCtjtmfDjNd0nhOLNElCRF0WNatQGpIzerpTW5w5HIL4pboWVFztIgCdDcafMl+L6+4=
Received: from BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 01:44:52 +0000
Received: from BN8PR12MB3633.namprd12.prod.outlook.com
 ([fe80::9d24:2886:951b:b161]) by BN8PR12MB3633.namprd12.prod.outlook.com
 ([fe80::9d24:2886:951b:b161%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 01:44:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "R, Bindu" <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Topic: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Index: AQHXGr8fq/tZ9KIFx0OysQXH9BPG/KqHaHuQ
Date: Wed, 17 Mar 2021 01:44:51 +0000
Message-ID: <BN8PR12MB363370FEDCB6A5BE867005638E6A9@BN8PR12MB3633.namprd12.prod.outlook.com>
References: <20210316234952.254296-1-bindu.r@amd.com>
In-Reply-To: <20210316234952.254296-1-bindu.r@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-17T01:44:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=eb4a10c2-d0b4-420d-a674-fbb2fabf22e2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5621610-2c9a-4764-acfe-08d8e8e641df
x-ms-traffictypediagnostic: BN8PR12MB3635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB36351928EA93B6147C8146728E6A9@BN8PR12MB3635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sj0ZZAnO0LflFUX5ThcvbuHYkt+1CBxP/Oewh/fDxTVPbwyX5cMaXil/mDqVm5Jy/y8nbw4j3hbMsuCezZBefKdv9dE8Fep+YKDKjzT79HI3h5U5ehGzX/c/uZI4hLBZyG5dacY/IqFyfDlwLvLqeXkhnN/Gp+z+eKv/rB3XXu8eXv75jowa2MTmeENFv1C0h2IkqWyuVaxbtgDHNBrghKZqDjriYZgwYkT+tjJCeIwp4CzfwkX8MLAStGOoksCvrB3Wx1pNTce7EWGAI7QkuMUr+viwC5b/f3U25n0Ck+T5QnOBqTG9WqlUImsnfxWCn2k5xFxMulSp/9/gr/hu+UjV2QVCwgBekkQpjpijzzECFJQ2ZSbewzi0mMFpxqnDkg/sOBvI3LRUYpB6Mk6KKI9QSI5cqkDll8jx1iBRLU8g7bDvp6jwkFYmNTlOX5AKuR4KDWu3wC++UsnVD4B5VWQMkS56dViB+Q24nWu0pQCZ7onidE0KAxqC9D2dR8/ScdEl/xzHSsVd4BbLwczEIOjQJYkhNZiT6vp+SCLgh5HMz9j/9rWABbfkFR+R5NrTtjRVK/G+Y+da0en82Tw3lzY5dEmkcZLA1u8RNg06iUo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(9686003)(966005)(66946007)(8676002)(5660300002)(26005)(45080400002)(71200400001)(478600001)(316002)(66556008)(76116006)(7696005)(2906002)(64756008)(66446008)(54906003)(83380400001)(86362001)(8936002)(55016002)(186003)(53546011)(66476007)(33656002)(110136005)(6506007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/GnGN+RXva7nV1VMLuCRhZQw0+/Bulqi7kr3l1Cm8WBMK/8VkIz5iTOqWzPu?=
 =?us-ascii?Q?KmwvVa0cFk+HYimCjy9CHCp4QYoH3H0hkOoaJDx60RGHxL89rEROvyxu1IxB?=
 =?us-ascii?Q?FQBHU18bACE5koQ+k9kb6dY4AFGNzucfHoQPi4x0gTTTOAnWamn4X9jDRGTK?=
 =?us-ascii?Q?Ufuj2uq0OKz9R6Ng+Hmy8Mu+7FRKvpNTOqvLgVCwdSz3FdMyES/SqTk+TOUF?=
 =?us-ascii?Q?FzHnqr9qnoR5jSQv3PIOgudktB40l52vbeDjhbY/wxOznUvoeuD9TWEm3KBU?=
 =?us-ascii?Q?wb76CHKnzWVpdIUCDY7KRjaT52QkX/4qTOVeadiQg7uZ3Zjbz3t3mJSf/qvM?=
 =?us-ascii?Q?iainns44xcdaHH710zBcmtzzQ2gOw+1P55Y0t8g7zCiNNKespP6pMUTYnxys?=
 =?us-ascii?Q?upaZfF/FXO6NsiJuHrlAcP1BIkM/1gHHDPcSgKu3kXAnHLaWQMc7cT1NNN1h?=
 =?us-ascii?Q?ajQXMrXNjRkqvEokPLIjJsyIvHvEftgAMVsctUFk8Znr5Y9JMWFgZ7qCZnlx?=
 =?us-ascii?Q?2OXFzizDEteKmlVP4++31JUG9/6x1otnXGEziwUDm+DCIC4YKh6KAw3eB4HB?=
 =?us-ascii?Q?ZRoTJ9LBfADlyaldZ7KHJ0YJF+r9hp70/8jF4jipPBCUwqkg0BxdAhksZ+pH?=
 =?us-ascii?Q?lZYzL4z23c9uKAix49341drM4bsO6UWtPQ+cB0jkp0VrNHK/Xg/xB2pjLUjK?=
 =?us-ascii?Q?63jq2VyDo/qI/8q4cAmwFvDEnQ9r4kWfZ2kEscp+rtTMY/c3MlFcKFY4KUl1?=
 =?us-ascii?Q?zi2JmxhmsDEPqZ+NOBnulQ+efYJR3QCkPWyOG8svYSHbs+ema1MFK859dUum?=
 =?us-ascii?Q?ItpBufeFkpoxAWZZHYbtnh8PiF9FNbcTGTQY58aejBYPQn43jfIqQzpE9t82?=
 =?us-ascii?Q?rBqj3AyvNMJr5+QAYJxvpnPkgNDy5vhnaclSVyPh0S/cM5v3SkpTTAQjMXNz?=
 =?us-ascii?Q?82AneXrB9Iem6Ks7a8/7Tyc9bngyfrU3PocF693lz8LxTP0KtI0DoZzduKbF?=
 =?us-ascii?Q?hAXEIcexb1jbmt3303g+xS2PYjXJ9DIXQNr8m/Cw4w2qKsgW3qN6UVtZCQan?=
 =?us-ascii?Q?+ueCs6APpWphFWHeoHC19cCOQT1RcGlIYyqHsMyn3flcm3YIiLrCmQSbmgst?=
 =?us-ascii?Q?AfV5HJSsdcIvN2Rjq15UvWswZHuxgA7oy3UeYdv4x0GH2zFzkooGkX1eonfw?=
 =?us-ascii?Q?j7cp+7CZ6lKFCUS/ZE9wDn/dq/cgjZ3u16kHaRXVsLwZTRXHrgXo5Ozo7/H8?=
 =?us-ascii?Q?pCgsSWuaTFCZDdAEcNAmgIlQ3O7bUKeH1p+kNGNh3eiNhRkS2oPx7HEQYMMP?=
 =?us-ascii?Q?juFqkV97M6Ty9LgAe8ZhCiV0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5621610-2c9a-4764-acfe-08d8e8e641df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 01:44:51.5386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVtMwuaqTs47PpJ+wvwG3s3FM8Zc/wGqn0rgoBOt897lQ6x39vlMiqgSoMkt2G+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cf2f2166bfb314e1ad12408d8e8d63f5f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515354195323551%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=l88hqOHfw7IpxeDnWN0St7FdMFaj7xo2jiIu0xv9kn8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
