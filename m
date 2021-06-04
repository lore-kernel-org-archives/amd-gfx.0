Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF7C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C5E61400
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C5E61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441A56E0F6;
	Fri,  4 Jun 2021 15:04:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EB16E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 15:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtMF6vc85F06+wFZT7U+UEz038bFQhplmWCsFU6xBshMrGoMuPO8n7Eg9AT8tpU2TkVHFwMsMxR9z8r8ysuuRufCjVaTxoJqyQwm9mBxPgENKdTQp08VjcQ58ZCB8Vd1kI4C4Pi8WH5aMlnDWZWOh7wk7ByFBr20aKIbQPYb2wpubsd75XkgpZq6iP8zoJs2F6LKz3nPPVlFGnvjtLIgGoi3nDkJ5KuFnQaI63991lYSsTv5F+zd9iZIJHoz+SgPOvVf0w8nfbLHmvvOmr2Nfra9do6hQ+wPU1EwBzeeaH+3KUZcb5bIaLiB3nsQn9GjzbC0b/Hk5lRlzYF3xthtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TisvboHI/d0y00M7Up84OOaUc2m97ZsfueybvhzOW8=;
 b=AJ6Dv6XrbLmnHjjn4eBmM0Tciq13YPfdbcqYOqxfQPTMCsR0mMTorcHiPCwjOZrbNq3adD5PnhNDG09ud+CXcEcfljK52uOht+cf2D0w2w4kDUaXNnt0Yq9lD0XQoQS1ILhF2cNQEmFKfFFS2MR7/G6WL7dLZm5JWKwtAf9ZMO7ZF46ykFlOXHhXcc38knJzH7afGLFbw1KVTfZKwUrdkex9bZuRNdgZNSH8I54po2XARxjS50mSEbEFlgBL/djh2s+ZZXE6CmgkqrOj8uWhYAJPG8kqvt/KxyRS3GcGFXwl0UDP6jh3dN4W8jT7Zmr2Yd+8SYWKTiyE/bCssyvEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TisvboHI/d0y00M7Up84OOaUc2m97ZsfueybvhzOW8=;
 b=tneVG4lwmjGSi6EViSqRLv6D91jyBWoJBxt/juXEY2gLrXAzZOnqFSDevGJ2D5h5u8DMn2tCZuJ57KKF0A32d3O3eX9w1LhB507g/2XvR5oKez8Z77aHGSiDTyThd51tE97WFknQeDfV7lEPPAyPlGMxllDdq2WzDjFheMRAJLI=
Received: from BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 15:04:33 +0000
Received: from BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689]) by BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689%5]) with mapi id 15.20.4195.022; Fri, 4 Jun 2021
 15:04:33 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna
 Cichlid
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna
 Cichlid
Thread-Index: AQHXWVDsWSQ/WaGbIU27K9XOrtkSQ6sD8PKAgAACLOA=
Date: Fri, 4 Jun 2021 15:04:33 +0000
Message-ID: <BL0PR12MB475577237DF9EB2C3AF89FAA873B9@BL0PR12MB4755.namprd12.prod.outlook.com>
References: <20210604144921.14764-1-rohit.khaire@amd.com>
 <MN2PR12MB44881B6C3797944D77FC30E6F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44881B6C3797944D77FC30E6F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T14:56:24.976Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f34b37b-45ec-4fa8-1ed6-08d9276a0fb7
x-ms-traffictypediagnostic: BL0PR12MB4657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB46576D6C57459B524C813941873B9@BL0PR12MB4657.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:92;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wexz3YKQBmQsmlkFdZAgTkdIr2l6vSHASPPnJ5I2xk9W6AGft/ZSd+YTRi2sLv0I4tOlyf6aRBhr3qn3oDMkCCMrR8hTUJ0GYKHrSYbWnutaRYBVUcS8lqlkXaM5Hol3/KiBJXw+NDTo+9k4DvnxVu1yO4SakXNqITEBizpa6ebUb6JhXpGq/ZCQRQjKx1OkzRaYZnRS2WtyokAvgMOa1nuOroI59JpFGpXISc3/K2MMmStpRF/fiWiILlsVps4SZcdWBKOrlWJCN+Dp0BBxueQvNLo1u2jZ9Jg7Xfno3HB347yrDuljb9hS5Je9z/M3r/Ct53bJezr4YpPtFkj0unA9aWdt4pYj734v6ib+Jt0bSjx1EsOCSweXN+9UDb4dOfAO/9dSjrQEAi2fo0Ze3HbmNh+ooaFOhu7/f/zhGXbqGWodFYq627hk/89hDNwR+1c4JaIXNgdDkb5ThhGFQAZ71nzTlkY1N0E3OPxSfnnUuC96oUi8bhRJAEohe0CqMHfogBgQgtjBJ6hTOg5k/RJWYYON9TZ4NZgGcpmJPZ5spogCOqJaQUyEwgdrly9UXeBZ1Ntxk5cjTqxE/b7y8zQxBcmxuvNeJnKbTpzMuqQYE5OV2Bi+tOYc74xx0dzqvsIDBfL1Off+MH1aoGl4PQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4755.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(2906002)(5660300002)(8936002)(110136005)(26005)(54906003)(55016002)(9686003)(316002)(52536014)(6506007)(53546011)(4326008)(186003)(122000001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(71200400001)(6636002)(83380400001)(86362001)(8676002)(7696005)(921005)(33656002)(38100700002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X4MNP2lbz/Y6H7CucTfevQ9yxPXCF7/6junmVovGISSM2oQv1RBLZvDuJPyE?=
 =?us-ascii?Q?vcJGyZM7ipv/5HpF5mu7VxNS9LwvzP/qEVdN171qiBkVhZEjl4mRcDkHec+T?=
 =?us-ascii?Q?WDVEUFnKoG1YI+Rq10D0uEpuf/WWUify6iPAfjERTfpIF1SWJxUJkB1H/kLo?=
 =?us-ascii?Q?AXp4WKE2A0xspGmZFRUnwSP8+fc2lY6o4WxuoGpFwlfaXlInCvMdXN06i37E?=
 =?us-ascii?Q?ME1/rGw4sdV/WBD3f8kvdtEAXn/1KtlxAxn7TRZJ65iWDh8dEt9CmfVkQ3Ds?=
 =?us-ascii?Q?MZSwdMqCoyasJXQKdSRPO8vk5FlqkZu7hUL6f+7H35DjFcdcvK+R+g+rOe9U?=
 =?us-ascii?Q?UP4noLz+3jDErEVpJde7Ojk2rmB4UPaFbupHFL3Z8Drfx/Me1Sooi81jdqrF?=
 =?us-ascii?Q?51341rEAM4Mxp/6P9WANOogm2937wRyKUx4ywlC+79JYLaDWec9JKO4jK8uT?=
 =?us-ascii?Q?/SKyhXaeT7M4YWsKvjoFK8mmKTslGmls45/66G1fFXlWct0E3v2yYwKYSm9S?=
 =?us-ascii?Q?1/M7tWyCRoG1alGWGUd5XStzTtCXvx8uBLzT+FgPYuiWqOUoCbmeTHCdvSGM?=
 =?us-ascii?Q?OZyVnJXW8gbwnmy7wnOAgf3jhrgWdioZie8gM+UEL+4n8D8PdYPMjfS6fb/t?=
 =?us-ascii?Q?Zk0a1qdnel8FIN3SappvW5o0FEPNFUZarJo6q4iozD0Jm7SraQ3gEZO0vZbx?=
 =?us-ascii?Q?cea71NU98E9MbDy/mPS8Td0Xndeqix4XC1iquYMC0FW7YWTcEEbz/pcgxRFV?=
 =?us-ascii?Q?aj36mZ4khTJz7RW8fVRknf3rBWooirrrhyp8FtodclHDww6b9nEGN1+1ibfD?=
 =?us-ascii?Q?rGTTs/pSarM3dLy5W0sxllQ18CUee2kSo38qIg5tX3d4W7+KyZPSmM+g0GkK?=
 =?us-ascii?Q?H9it4SHx0niQcWEhyxitUSRvFK3ydLEMK6KW26brRZ1uuzkssQjoER6og3Kg?=
 =?us-ascii?Q?094djQH796XgktXqytDiWwBYh5GCPuke9Ntz57Uyv4k366ZiB8ms2vt7JSpX?=
 =?us-ascii?Q?fTcKMBNUj3obLYGyDFUDaaa6I588wNCbvv4RjRYupH87R2F3jV0/rNZQxGB9?=
 =?us-ascii?Q?DxeZA3h80haR8JyBNtMUh0zuhaHiygezsbxalg0puY3jMKrajosjF+EO9FJ+?=
 =?us-ascii?Q?Hsu5AS4rN8Nbe5isletPClyObf/7a+kq56JTiDwq3D4bHoimZerlppttJCFF?=
 =?us-ascii?Q?lVwBT8hxP5zPZVlvqVBqG3YTc20LY591/Qdhnz/nicwwvrBXSQvwWAYq3NWl?=
 =?us-ascii?Q?Xc1hj651bq7JACX7TwX/gPxUZmHRV9+RrxC1RHVo5nbQlGeA8BgnA5z5b8jz?=
 =?us-ascii?Q?yq76hUIgvkIrRgA7DZCvj7S+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f34b37b-45ec-4fa8-1ed6-08d9276a0fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 15:04:33.1023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhbO2LACbSfqAQHvUiMiO0dQ4raRf/vbtLE7yVK3mADHnncg7dM/cbRPXEow20/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1707276290=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1707276290==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB475577237DF9EB2C3AF89FAA873B9BL0PR12MB4755namp_"

--_000_BL0PR12MB475577237DF9EB2C3AF89FAA873B9BL0PR12MB4755namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks. I will fix that check.

Rohit

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: June 4, 2021 10:56 AM
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu=
, Monk <Monk.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, Horac=
e <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna =
Cichlid


[AMD Official Use Only]

checks should be adev->asic_type >=3D CHIP_SIENNA_CICHLID so we cover other=
 gfx10.3 asics as well.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>

________________________________
From: Khaire, Rohit <Rohit.Khaire@amd.com<mailto:Rohit.Khaire@amd.com>>
Sent: Friday, June 4, 2021 10:49 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Deng,=
 Emily <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>; Liu, Monk <Monk.Liu=
@amd.com<mailto:Monk.Liu@amd.com>>; Zhou, Peng Ju <PengJu.Zhou@amd.com<mail=
to:PengJu.Zhou@amd.com>>; Chen, Horace <Horace.Chen@amd.com<mailto:Horace.C=
hen@amd.com>>
Cc: Ming, Davis <Davis.Ming@amd.com<mailto:Davis.Ming@amd.com>>; Khaire, Ro=
hit <Rohit.Khaire@amd.com<mailto:Rohit.Khaire@amd.com>>; Koenig, Christian =
<Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; Khaire, Rohit =
<Rohit.Khaire@amd.com<mailto:Rohit.Khaire@amd.com>>
Subject: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna Cich=
lid

RLC_CP_SCHEDULERS and RLC_SPARE_INT0 have different
offsets for Sienna Cichlid

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com<mailto:rohit.khaire@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 11a64ca8a5ec..1e1ce1e49c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -177,6 +177,9 @@
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0

+#define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
+
 #define GFX_RLCG_GC_WRITE_OLD   (0x8 << 28)
 #define GFX_RLCG_GC_WRITE       (0x0 << 28)
 #define GFX_RLCG_GC_READ        (0x1 << 28)
@@ -1489,8 +1492,15 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, uint32
                        (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_I=
DX] + mmSCRATCH_REG2) * 4;
         scratch_reg3 =3D adev->rmmio +
                        (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_I=
DX] + mmSCRATCH_REG3) * 4;
-       spare_int =3D adev->rmmio +
-                   (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX]=
 + mmRLC_SPARE_INT) * 4;
+
+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
+               spare_int =3D adev->rmmio +
+                           (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0=
_Sienna_Cichlid_BASE_IDX]
+                            + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;
+       } else {
+               spare_int =3D adev->rmmio +
+                           (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_B=
ASE_IDX] + mmRLC_SPARE_INT) * 4;
+       }

         grbm_cntl =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_ID=
X] + mmGRBM_GFX_CNTL;
         grbm_idx =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_ID=
X] + mmGRBM_GFX_INDEX;
@@ -7410,9 +7420,15 @@ static int gfx_v10_0_hw_fini(void *handle)
         if (amdgpu_sriov_vf(adev)) {
                 gfx_v10_0_cp_gfx_enable(adev, false);
                 /* Program KIQ position of RLC_CP_SCHEDULERS during destro=
y */
-               tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-               tmp &=3D 0xffffff00;
-               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
+                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sie=
nna_Cichlid);
+                       tmp &=3D 0xffffff00;
+                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cich=
lid, tmp);
+               } else {
+                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+                       tmp &=3D 0xffffff00;
+                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+               }

                 return 0;
         }
--
2.17.1

--_000_BL0PR12MB475577237DF9EB2C3AF89FAA873B9BL0PR12MB4755namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks. I=
 will fix that check.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Rohit<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;
<br>
<b>Sent:</b> June 4, 2021 10:56 AM<br>
<b>To:</b> Khaire, Rohit &lt;Rohit.Khaire@amd.com&gt;; amd-gfx@lists.freede=
sktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deng, Emily &lt;Em=
ily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Zhou, Peng Ju &lt=
;PengJu.Zhou@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;; Koenig, Christian &lt;Ch=
ristian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix incorrect register offsets for =
Sienna Cichlid<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">checks =
should be </span>
<span style=3D"color:black">adev-&gt;asic_type &gt;=3D CHIP_SIENNA_CICHLID =
so we cover other gfx10.3 asics as well.&nbsp; With that fixed:</span><span=
 style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Reviewed-by: Alex Deuche=
r &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.co=
m</a>&gt;</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Khaire, Rohit &lt;<a href=3D"mailto:Rohit.Khaire@am=
d.com">Rohit.Khaire@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, June 4, 2021 10:49 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;; Deng, Emily &lt;<a href=3D"mailto:Emily.Deng@amd.com">Emil=
y.Deng@amd.com</a>&gt;; Liu, Monk &lt;<a href=3D"mailto:Monk.Liu@amd.com">M=
onk.Liu@amd.com</a>&gt;; Zhou, Peng Ju &lt;<a href=3D"mailto:PengJu.Zhou@am=
d.com">PengJu.Zhou@amd.com</a>&gt;;
 Chen, Horace &lt;<a href=3D"mailto:Horace.Chen@amd.com">Horace.Chen@amd.co=
m</a>&gt;<br>
<b>Cc:</b> Ming, Davis &lt;<a href=3D"mailto:Davis.Ming@amd.com">Davis.Ming=
@amd.com</a>&gt;; Khaire, Rohit &lt;<a href=3D"mailto:Rohit.Khaire@amd.com"=
>Rohit.Khaire@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Chri=
stian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;;
 Khaire, Rohit &lt;<a href=3D"mailto:Rohit.Khaire@amd.com">Rohit.Khaire@amd=
.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix incorrect register offsets for Sien=
na Cichlid</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">RLC_CP_SCHEDULERS and=
 RLC_SPARE_INT0 have different<br>
offsets for Sienna Cichlid<br>
<br>
Signed-off-by: Rohit Khaire &lt;<a href=3D"mailto:rohit.khaire@amd.com">roh=
it.khaire@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++++----=
-<br>
&nbsp;1 file changed, 21 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 11a64ca8a5ec..1e1ce1e49c70 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -177,6 +177,9 @@<br>
&nbsp;#define mmGC_THROTTLE_CTRL_Sienna_Cichlid&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2030<br>
&nbsp;#define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX&nbsp;&nbsp;&nbsp;&=
nbsp; 0<br>
&nbsp;<br>
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4ca5<br>
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 1<br>
+<br>
&nbsp;#define GFX_RLCG_GC_WRITE_OLD&nbsp;&nbsp; (0x8 &lt;&lt; 28)<br>
&nbsp;#define GFX_RLCG_GC_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x0 &l=
t;&lt; 28)<br>
&nbsp;#define GFX_RLCG_GC_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
x1 &lt;&lt; 28)<br>
@@ -1489,8 +1492,15 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, uint32<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;r=
eg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG2) * 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;=
rmmio +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;r=
eg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3) * 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_S=
PARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0_Sienna_Cichlid_B=
ASE_IDX]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spare_int =3D adev-&gt;rmmio +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_=
SPARE_INT) * 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg=
_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_idx =3D adev-&gt;reg_=
offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;<br>
@@ -7410,9 +7420,15 @@ static int gfx_v10_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_cp_gfx_enable(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Program KIQ position of RLC_CP_SCHEDULERS during d=
estroy */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp &amp;=3D 0xffffff00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_S=
OC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xf=
fffff00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_S=
OC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D 0xf=
fffff00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmRLC_CP_SCHEDULERS, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL0PR12MB475577237DF9EB2C3AF89FAA873B9BL0PR12MB4755namp_--

--===============1707276290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1707276290==--
