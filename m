Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A58C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 16:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42B511A682;
	Mon, 10 Jan 2022 16:09:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D60111A655
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 16:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+009kCqVAPoJ9lz47l1KnafKSXKvrIPEabHrDzun4vWSGP5z4AYybdr+8Q8ElzNyPGWZpgVefhno5GY+yVxXKatQiBhSoshfUmGySQZrcAoaPfFAir620N3Nn/JKKLW/SSZtTi8CywYjtBfJsf7cucvi4QggU9Is56wnLpaQplq4fJEGi6c6fqYzDudbl5dIBobYRFAvtDZcKdoeU3XluLy5pCf9dS8NipdLAe+93/3qUXgDCtzqnBQYKjGvzrKy4JQCcabgqiBWu+hjIwwcxcf1RwVYcQuQkoJ+4SweHFJTxzhb/k7IwzIciB2dsBTRizkIgTHJjZqYlr7TCiVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8pu0Y4JrVWWdCKvTiTQc9yMvTf5QvKH0ImSXzVeImo=;
 b=e7Ya4QSerPAUjAiChLZVexI+fmrZTcPJbHKkr8c1zE1g3gtOwKRAltobQNaNs31VP632g1hucZGbz7qLZRjN/0C+LtOmtHgdz9TVBmgGyqmHr5VyycvJIOiuJTIIpfx/ggx3d4KKrZkBbcAaCja0GgCmrZayQboL17+y33CHXV6oZvzu1ayw9hg/VFwj3N+Du63/APEWwwx84vbLi0ub3kSGdRuW9ukqwsvg27cmysCHXOwWZUFPf7IL+3vVuSv5i/yKdRYbl2510GpqUK9GjVMUp3jJGqgXYx08ZWgFFTCrFXA0UL0u6RafiQvcobNnFUCfawuZik09kzwWQh6tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8pu0Y4JrVWWdCKvTiTQc9yMvTf5QvKH0ImSXzVeImo=;
 b=Qxxc52CQH5+Aiadtmk6Pp8RUjcOR9k3Ca9X9hBSG45ukX9IakOG/MHkcn9KlFuDRUximgnQe8k+1NugRL3VUoWqOtJI8Ye3So2N8Y0MwWbvvqANWChVK2sybY7y35POtRu4n/TvnLRAF8uhW+d2D3E9Dyb9pIxTrJFXhN0bODko=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 16:09:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 16:09:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Zytaruk,
 Kelly" <Kelly.Zytaruk@amd.com>, "Huang, Qiliang (Warden)"
 <Qiliang.Huang@amd.com>, "Zhang, Bokun" <Bokun.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Topic: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Index: AQHYBeDhnsscBqWQYk6qILDh+Cd6V6xcbQs+
Date: Mon, 10 Jan 2022 16:09:22 +0000
Message-ID: <BL1PR12MB51446F808FF38ACF66C43F99F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220110051344.29134-1-guchun.chen@amd.com>
In-Reply-To: <20220110051344.29134-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-10T16:09:21.625Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c8ad32f0-09b1-3df0-5455-1f462a4d54e7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a8b1288-4f95-4e23-ca7c-08d9d45390a5
x-ms-traffictypediagnostic: BL1PR12MB5031:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5031DC56C6D9EEC3DC6F9F74F7509@BL1PR12MB5031.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXITQdkJDrlw0FOlKiIMySDI8nqd+kvHi+YKSMxpzhrTQPC4sMOTHmEwooSzgymwiJXVXxirh6ViLxXDKP0iEaqlnwN2AVPw7iwEIpD4rmDf7F54j+LQxYdoaNxbl7LymDBPggrqSyFY+euseKuTtUlgRUelu4ASmKOtfx4VE/cJqXiLDtSfNaTJdcRMRQw/tEhzGFv4RYRma2l1B3blOjPcCRDr64nj/JNQaq6XNO4crCmaSeSnBZ0u+G3yjoxSLWWpQ1uICB5QpYSo6JsIbr8jGjo0CAS/HUWuRkI1Pz7YQ59SOKyG28L+VtNOLWjUdgDfX6ehoc69CJ6iV4tGu8LqkMdVu/eymYP0rjofKHn3L6sKjI2Ln06A0TujPJv28vEXiAQsZCx3N0TVUEYu8q/0548xjRPV69rN5lK7IZ+AYQd4F37i2j2vmQ1HKU74TijxYhHPcKjfHN2EfUr7Te/sP3a2JY5UJuQQDdOFlBpXIR3G4DoaUo5UMhLE5stj/SrQGqItnj4jAjZoun2+fngCnTXfcO0XPlLUuCLXcKuPXRR2mcpdPCXJglFnQa59uxmnPGZK1gQqU3vWXlO7a7t77oApBk8iUdDtCXQUeQTaw3PVueJ0kGTQ6huftfxxlMVzdlS2kFpgK5Zer3LJ34rEyemi+4zlFlwIrgoefY33mTo4WNYQeRfabkdt1TgK6flyUThwp9aa2ymfmQuKGLlCFdf8yqbSfbnOeX1y1+M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(26005)(6636002)(316002)(33656002)(19627405001)(9686003)(52536014)(6506007)(66476007)(53546011)(8676002)(8936002)(71200400001)(186003)(5660300002)(38100700002)(921005)(55016003)(7696005)(66446008)(38070700005)(2906002)(86362001)(83380400001)(122000001)(66556008)(66946007)(76116006)(64756008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3FPL9rnQliz0A2GJHbFOprlgTVSCmGWnmIMRf196Bjc7BAXZLLRT6G3Hrr8J?=
 =?us-ascii?Q?9ZF7kGozrkaMzuK6yS0g7CTWPvmiXFQFzsHp14jHGnHtzvlCLUxXVc6Y9eKS?=
 =?us-ascii?Q?G92WsXfvujr9tSHQOxjGNK/OZa2CtdPn+K/+wCvPYR+eQ0M0H1mT0Lenl/VN?=
 =?us-ascii?Q?fg3t49yMxaYhwRumffEhnJv6IPHW0Ccxjx+NnXsK0RP3Jje4C/lZw/pSXl50?=
 =?us-ascii?Q?Zld+5gnhArulvFCUQQYbnQ8V46L0aM8dvytKIKr6sUq9we0LxUEcDheSTtiT?=
 =?us-ascii?Q?g479jfu+OAWvAnAlBQBPTKnHH4rBbNcEsCh42DIUMPNo7KOAd1FZ8cx+dXuk?=
 =?us-ascii?Q?GtjiI9N0NG9RDU5KrgsXXGJI58fT0bniYKmFT+LLFJHnvUv334Q4s+heFZJt?=
 =?us-ascii?Q?ShieFCXlP65J9AGVX7dPAtGpvSnk1PE1ujVz2E8vdIOvQxam0x3z5vi25sGZ?=
 =?us-ascii?Q?0RGmFdcauuHbErlMM14vbhpZE54sWAusXU8OXCA8+L+9TGaxO50Ke8Ehcee9?=
 =?us-ascii?Q?jedfhlS9RJICoRHEMighaqXerzJEK4ZxjJUImFh4/R+4FMLZikmn6cAeQfGc?=
 =?us-ascii?Q?evqYH//WwdrNXmidZmM9oacklh5FmKPeLmEWKhaysk0G52yDCxdPDplfNFPh?=
 =?us-ascii?Q?t0glORDjcyQ8ygu8ba/9jc5oRkwfZcEQ3N61aNzHGk52Hyf5dPEcCqOasJ2h?=
 =?us-ascii?Q?ZNeMVAgEyA8zixrK6OeYb8MVjVapPlrWesBUiiiVrFqbd7SuEb3ZOVgHTrGW?=
 =?us-ascii?Q?fmRFzRsnNhi/z1a46g0vNX9pVHPMGXnK2jJaa4Km38lOJNCvf0ulAXyQ065/?=
 =?us-ascii?Q?JZ6F79Po2ecalpfqeQTpIlMdys6jKhPhZqI4NfdzmfaHgYoADyqntjhMmT8r?=
 =?us-ascii?Q?pwBAdIOxcZIQIce2tdEODe/9M4eKAcxcd57LtSfc2+Tauj0GdobbHBOt4Mq3?=
 =?us-ascii?Q?Jt3CmrUJVMd/58BWfEwYXPZQ8+DiRWHd7mkIkZZbo06xtDQmIkBj9aFiDUFc?=
 =?us-ascii?Q?sX+lGFRvh6Ud02jTz8JlucRNoyhTooWjMrYx5RGSfTPOkEJTlJqR1SWnXfSC?=
 =?us-ascii?Q?4glOFYNc0xla9xiH8GJxeFcEW7hSRZbJ+CPkWDP4iYebVqq1b+pVtMFbvpqW?=
 =?us-ascii?Q?bPyVMmZohwulxBZ9mQFZpnoY+PfL7WHkUs9YWfDj4/OoYJYQ5uGYDeyVn0zx?=
 =?us-ascii?Q?0nmHpgI1aCJmSJQ5P1irudvIpNx6H6l7U8g7QBh4X7iGXvLJ4XO4sbIzIA1j?=
 =?us-ascii?Q?90g1idgulsQt99Lcl2ltuPjpRr6gqPy1R2NFz8j0aLyaXWsz7UAUQDFzVVsK?=
 =?us-ascii?Q?1mgM9lyUgzKoiXdXS0jiAV3JokYhrEx/OP74osJpyPRdmHKDsWUEDhl5Yqt7?=
 =?us-ascii?Q?/7QBCsYuPiLvqUYakyQG3JVs1K5SPUd3sHp7mI+ZQmaKIcxyANT8wflKzUmG?=
 =?us-ascii?Q?4iNJSblA+8iXJiuMpJtBCfBNqPOjVJP5dJDGyqbOk3nQ/gtflVf35HjRpa41?=
 =?us-ascii?Q?0tNWIivAra7pdwTCo94AhE7CNNTOwabfb2uAAszsXa2AH+qtYvovBBqeTGoh?=
 =?us-ascii?Q?26hSWG27dOGitdUvvbY9Z5d1+qP4tUI9jW9Nr5bKEF6xNKKW1mhBqb5mJGxT?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446F808FF38ACF66C43F99F7509BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8b1288-4f95-4e23-ca7c-08d9d45390a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 16:09:22.2217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzux1gdr4AcWCZDME7mY2wySRkdktBkPG8TjHhYBvjOnSBTWedyCe15rbd5uNNVefqgNR8chM5K4LGkyBE8oYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

--_000_BL1PR12MB51446F808FF38ACF66C43F99F7509BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, January 10, 2022 12:13 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@=
amd.com>; Huang, Qiliang (Warden) <Qiliang.Huang@amd.com>; Zhang, Bokun <Bo=
kun.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by loc=
al interrupt

This is observed in SRIOV case with virtual KMS as display.

_raw_spin_lock_irqsave+0x37/0x40
drm_handle_vblank+0x69/0x350 [drm]
? try_to_wake_up+0x432/0x5c0
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
drm_crtc_handle_vblank+0x17/0x20 [drm]
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
__hrtimer_run_queues+0xfb/0x230
hrtimer_interrupt+0x109/0x220
__sysvec_apic_timer_interrupt+0x64/0xe0
asm_call_irq_on_stack+0x12/0x20

Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 2dcc68e04e84..d99c8779b51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct dr=
m_crtc *crtc,
 static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
                                           struct drm_atomic_state *state)
 {
+       unsigned long flags;
         if (crtc->state->event) {
-               spin_lock(&crtc->dev->event_lock);
+               spin_lock_irqsave(&crtc->dev->event_lock, flags);

                 if (drm_crtc_vblank_get(crtc) !=3D 0)
                         drm_crtc_send_vblank_event(crtc, crtc->state->even=
t);
                 else
                         drm_crtc_arm_vblank_event(crtc, crtc->state->event=
);

-               spin_unlock(&crtc->dev->event_lock);
+               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);

                 crtc->state->event =3D NULL;
         }
--
2.17.1


--_000_BL1PR12MB51446F808FF38ACF66C43F99F7509BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, January 10, 2022 12:13 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;;=
 Zytaruk, Kelly &lt;Kelly.Zytaruk@amd.com&gt;; Huang, Qiliang
 (Warden) &lt;Qiliang.Huang@amd.com&gt;; Zhang, Bokun &lt;Bokun.Zhang@amd.c=
om&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock=
 by local interrupt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is observed in SRIOV case with virtual KMS as=
 display.<br>
<br>
_raw_spin_lock_irqsave+0x37/0x40<br>
drm_handle_vblank+0x69/0x350 [drm]<br>
? try_to_wake_up+0x432/0x5c0<br>
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]<br>
drm_crtc_handle_vblank+0x17/0x20 [drm]<br>
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]<br>
__hrtimer_run_queues+0xfb/0x230<br>
hrtimer_interrupt+0x109/0x220<br>
__sysvec_apic_timer_interrupt+0x64/0xe0<br>
asm_call_irq_on_stack+0x12/0x20<br>
<br>
Fixes: ba5317109d0c(&quot;drm/amdgpu: create amdgpu_vkms (v4)&quot;)<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--<br>
&nbsp;1 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c<br>
index 2dcc68e04e84..d99c8779b51e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct dr=
m_crtc *crtc,<br>
&nbsp;static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_atomic_state *state)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (crtc-&gt;state-&gt;eve=
nt) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;crtc-&gt;dev-&gt;event_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock_irqsave(&amp;crtc-&gt;dev-&gt;event_lock, flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (drm_crtc_vblank_get(crtc) !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_c=
rtc_send_vblank_event(crtc, crtc-&gt;state-&gt;event);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_c=
rtc_arm_vblank_event(crtc, crtc-&gt;state-&gt;event);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;crtc-&gt;dev-&gt;event_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock_irqrestore(&amp;crtc-&gt;dev-&gt;event_lock, flags);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; crtc-&gt;state-&gt;event =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51446F808FF38ACF66C43F99F7509BL1PR12MB5144namp_--
