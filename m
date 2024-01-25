Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2931EC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 03:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7AF10EC17;
	Thu, 25 Jan 2024 03:25:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAA510EC17
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 03:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbRMMNMn8rbrXCmjs/StRJN4CpVrTywDSP+h/hu1R4cTNidewre2NzKD3qS3234zKgRs3h0BGqfeaSxPZBSiC5dcZkuR6mKM+kw91soV+CVzf2xJAiHcP/NjMoft59dBmkT1y4p1yZRjkLyioeXH/NNDpbRRj4A/1ATtWapcdtiTu7uukVKi8Sj3Sa5HhxWdWE4VU5zUbI+c5lBxDd9+NNmnmkwvoi2q8kKEDMxeWhc/ypGSZ/JgIGZU5mwRLEaRbMwhzD6xjE/BjD9ikKoUwboj9WmvIvXo+Ieeumd6HrQjFyqJFji6eRG+pFMDkm/Q3KGz1bde5+JiNtmVyM4/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMzYa5mVubG/ZzCPbpNiU1inPZMzMT5IDGotHY53Rh4=;
 b=fLui7wRxsNumVmLIHogdoMmYsKyBs+W9gkORtaXLtAiufM6IWbyo2FvNYmPOW7GxHJ7GiwFNehLP8NBm2HdOPB2Jp8+jFx2vmXlwxQpkJ4GhNDJoqd4g5tDARf4EKcrzJlIyHCp1ZqKjG9iS3hmhETaJ8ids6RMPbSn8t/8uc/Hw4KEqrllbthzYU1pRmg/jUBV4eZfswNJAYkZP3RHTBUzc/EBuA0CJge/1l5LS/4RvRMIV1WqAhdRlWFlsb7j8OHgglavduEIGsjuMATns0mMwfD/p0HSrDaaOm9r55FgSmlPtZcWgp/VuEh+isL8YY5JPTGvNyyVQgBdM2lo2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMzYa5mVubG/ZzCPbpNiU1inPZMzMT5IDGotHY53Rh4=;
 b=HyJaLrLUcA5xu6dZsqSnuowWu3Jnc8Yl3OFiRev628ZXtkOOEZgJxD0F4lGllXwonm2f4aXTgLVDIY7KOTEvlGSdbzTVuKob/ilPKpraUUuerCcJIHFGHdeVR4MDhceM8TTB2h3b7Ae0mBlcNN/5qLN6iJgFZYNhAQIhnslsqak=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 03:25:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 03:25:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Support passing poison consumption ras
 block to SRIOV
Thread-Topic: [PATCH 1/3] drm/amdgpu: Support passing poison consumption ras
 block to SRIOV
Thread-Index: AQHaTxwl1/2UejqBPUmpgFUEj9n+abDp1+hA
Date: Thu, 25 Jan 2024 03:25:29 +0000
Message-ID: <BN9PR12MB5257B16FF57F79EE9532ADCCFC7A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240124232143.7201-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240124232143.7201-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Zhigang.Luo@amd.com,YiPeng.Chai@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=abb10ea1-d9f2-4f85-9c19-ab595855d0f7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T03:03:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM3PR12MB9436:EE_
x-ms-office365-filtering-correlation-id: 9c64f88f-dd5d-4134-a963-08dc1d55480e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/eUtI2WudO22HwIVMlqJzx/hQlObI5xlI3I388yeqtPWV7kvf6C9aN0cXE70xbRNtcQt6AKX1/AjWkca8FMUjWN9Z70R6FoagH7EFiyKxBS1ZTqgxebTUrxQSQ5Ku+jzhnf336oaGP1n9usGV44o/lD02+D+d8bBTkFDv8nsY9EFx7TN7yKcToMZn+gLSjws+2tOOUjjMCryE+HhmImQt2yPaGXHNQwe5TUtpH1gervePzwdODZpJHgwEAOHWmU0IAuyWzGrh63G10vwWdUpULymwfOX1u97e81cbaVkw4FwOWUV/g8Sf4L2tUDOXm2OceJN6rlzXUVYn6dRM3Vf0+F3hKPeuRVLiCGWfe+1Hcocq2fKkZcTNgXxHxv3lM829Ho5r0okePHqFEIQsuYrRkKiD3yfy5Yr43SrmE+a5OtLuLwih2wS6MuZet11tmYLiihiL5EjplwjgRdboXecDhvO/3aJ6G0cuhjchZCrAVFX+a1dpS69/skLNKFm54jc+o2fMRmUPAeLz+Fy0Msh3B1GZePI/rheI8I0OWTNh5hZLo7icHIjGGnwfIuvKyCVEcKwAC5eMw1p29MNNl5bJvp5SvqAVGvdRmvI+dDTOVuNGJ06mslGJOyNrvGo1lH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(966005)(478600001)(41300700001)(122000001)(38100700002)(55016003)(26005)(83380400001)(9686003)(6506007)(7696005)(30864003)(316002)(66446008)(6636002)(2906002)(33656002)(8676002)(52536014)(4326008)(8936002)(64756008)(110136005)(54906003)(38070700009)(76116006)(66946007)(5660300002)(66476007)(86362001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fNrYt659CZRiUbKeUvtLQ0KQrKfgptrPxd9mEa0UElRelZ82POwU25kNvvR2?=
 =?us-ascii?Q?sdpvnjGBJ0QDSCkCUX0p6thJQAF0NqPzKj012laBf/TernGd8bAxIwANwlQE?=
 =?us-ascii?Q?bIW5XwpIz0CALQAglKVF674rIk32wx3qIOkp50xcx6H5g1Jvdgq4aXXSk/XY?=
 =?us-ascii?Q?6RvS7UQbnoO0TU+kEInLRG5sB4By0gPVLvFvnGYgPH+GMgmcRik+tg3KFh/+?=
 =?us-ascii?Q?IiIC0DeClF3I+NoG2cPKtMuaNuHcRgWIuM05br+rrCDAzKAf9nor8BVF1Ozj?=
 =?us-ascii?Q?pd8RoORJUjWohWs93yFmttsFi0PJRmjZqUCJBztJWm8bTvLAXj52TjCM7Wum?=
 =?us-ascii?Q?xwpglkOyz+d5UqYzX/37V2QvEDFEU+cf/9gCJn+CZ84EniGXO58LSt73rCoE?=
 =?us-ascii?Q?gMbh8wkWMsQmg1x5WIYe1LTAPEphTzjgVqdKF8oZx6yfDsaxFM2DtgyXXQ45?=
 =?us-ascii?Q?TFH/VkmXPLFNHUEPRlj8SsQbyJYPnWC8U8g3JYG47cVxDq7RKs2mexKwErJm?=
 =?us-ascii?Q?4JUnjQmqE6+Hwz6G/8NCHhtIalMXMCgWcrnIlxvrO1+NXPHZZi7Z+LhLriqN?=
 =?us-ascii?Q?W1GiwOZoQTWmEQzxMqIGhxut2JvC4qbRyOtXdAB0FxlTHNLb7QcR1iMN+jgr?=
 =?us-ascii?Q?4l9PLxkVlGl9bb9mRm6CinEUGclKk6LTopd8iJ/rxI2s28yoiKWUHLBnKkRd?=
 =?us-ascii?Q?Us9XNgXZXLCHsDIwMv4SSpXQU12kT/I8lgodmiOUAosm6eIwK7yPK+6JO+j/?=
 =?us-ascii?Q?0fpGhKVnkTciaIkNSXjr09j8/8zWBjXKVp71Nk/28u6tSs3zKiLbU0t1FnqT?=
 =?us-ascii?Q?Ss0e0BZ3oC+oCC/HKcKBwyhSJNo/wMG3Z3Wiav6YfGezuhiyrodKFmzta7WB?=
 =?us-ascii?Q?Qw3seRQSdxcYJERHQewLsJcejoKEXsb7poOLf2UE1neUNMpAbVV9BviuDxDW?=
 =?us-ascii?Q?pKuAE9PqWVhs2CLJW6/EihdJFl7DdqXcOTbeZHiSp9vOFqo0CEUsgJpH1YEF?=
 =?us-ascii?Q?oljO3mh3M6SmYhw5ukWQp86Lt9XbOdx90ZrHmnh0J1s2YvDCc7hKluG93Gji?=
 =?us-ascii?Q?pQsPXSZebsO5WW0mjiF856jhhZ6Mst/mmlnymR4rx4UarIU4T2+QIS07ZGoL?=
 =?us-ascii?Q?WG+nxEdfzgqO3RDf3PL0QhGK79z/nxnmrGYBcQVSy3ru7zzL6MvjRyayzk2S?=
 =?us-ascii?Q?g/SUSMeq4jjkJ5oV8Xg0J2FV2j0N5GhOhotQKcBOk+ew04PPFFYORQFCetOm?=
 =?us-ascii?Q?JnYX6JmOpYXbPiBlRPGniK0lKKE7nRJJJzfBONTQeQmO/dWjJmhqFonZs+cf?=
 =?us-ascii?Q?5IGqU4fYtze2BleQLJbVDWP+sfzRW11Xt/2mTNVyAyA6l4MlLc7ePP9F6RZZ?=
 =?us-ascii?Q?y1jsSRvb1g+oy6mI1kXd6bZZIYQawhlcjUvV/pmMYS4p2RFTZOJbxQyffduP?=
 =?us-ascii?Q?fRJRw7FWL93IaUcKJhupMcf0zSMIXKFk2zjye5HHeumbQwzFW/C6XoWOvLgA?=
 =?us-ascii?Q?XA4FBuN3O/dE+Au22G2Vg9JK6vlROUmSeEGi+/VM7+7fot8dS6izPsapcXrG?=
 =?us-ascii?Q?+/megXQvBqlF4ZEPOPZMweJXuaG8QbeRb37JWTV5?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257B16FF57F79EE9532ADCCFC7A2BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c64f88f-dd5d-4134-a963-08dc1d55480e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 03:25:29.7524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8twvNGeWSgBP1MwCeCD0opYvcJea4vMljnI6Gjw8FVitLV0zRc4+w0dUtJjyRLM8xSmFEu8J3BRDiqnEAl+fTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>, "Skvortsov,
 Victor" <Victor.Skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257B16FF57F79EE9532ADCCFC7A2BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


@@ -210,8 +211,10 @@ static void event_interrupt_poison_consumption_v11(str=
uct kfd_node *dev,
        case SOC15_INTSRC_SQ_INTERRUPT_MSG:
                if (dev->dqm->ops.reset_queues)
                        ret =3D dev->dqm->ops.reset_queues(dev->dqm, pasid)=
;
+               block =3D AMDGPU_RAS_BLOCK__GFX;
                break;
        case SOC21_INTSRC_SDMA_ECC:
+               block =3D AMDGPU_RAS_BLOCK__SDMA;

Hi @Chai, Thomas<mailto:YiPeng.Chai@amd.com>/@Luo, Zhigang<mailto:Zhigang.L=
uo@amd.com>,

event_interrupt_poison_consumption_v11 was duplicated from v9 generation. H=
owever, the hardware/firmware takes completely different approach to handle=
 poison consumption in gfx11.

At this stage, let's just initialize block to AMDGPU_RAS_BLOCK__GFX for all=
 the IQR sources (i.e., gfx 11 poison consumption notification was centrali=
zed to RLC). I believe we still need a few series to correct the v11 implem=
entation.

With above addressed, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com<mailto:Zhigang.Luo@amd.com>>
Sent: Thursday, January 25, 2024 07:22
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; S=
kvortsov, Victor <Victor.Skvortsov@amd.com<mailto:Victor.Skvortsov@amd.com>=
>; Saye, Sashank <Sashank.Saye@amd.com<mailto:Sashank.Saye@amd.com>>; Chai,=
 Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Subject: [PATCH 1/3] drm/amdgpu: Support passing poison consumption ras blo=
ck to SRIOV

From: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>

Support passing poison consumption ras blocks to SRIOV.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 23 +++++++++++++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  7 ++++--  .../gpu/drm/amd=
/amdkfd/kfd_int_process_v11.c  |  7 ++++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  7 ++++--
 13 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 77e263660288..dfb93664e866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -732,9 +732,10 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_devic=
e *adev)
        amdgpu_device_flush_hdp(adev, NULL);
 }

-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev, bool reset)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
+       enum amdgpu_ras_block block, bool reset)
 {
-       amdgpu_umc_poison_handler(adev, reset);
+       amdgpu_umc_poison_handler(adev, block, reset);
 }

 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_amdkfd.h
index 584a0cea5572..50d3e0149032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -334,7 +334,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device=
 *adev);  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
                                struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
-                               bool reset);
+                       enum amdgpu_ras_block block, bool reset);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd=
_mem *mem);  void amdgpu_amdkfd_block_mmu_notifications(void *p);  int amdg=
pu_amdkfd_criu_resume(void *p); diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebcd1cb60052..79bf6bd428a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2041,7 +2041,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
                }
        }

-       amdgpu_umc_poison_handler(adev, false);
+       amdgpu_umc_poison_handler(adev, obj->head.block, false);

        if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumpti=
on)
                poison_stat =3D block_obj->hw_ops->handle_poison_consumptio=
n(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index a6cdb69897f2..20436f81856a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -246,7 +246,8 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,
        return 0;
 }

-int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block block, bool reset)
 {
        int ret =3D AMDGPU_RAS_SUCCESS;

@@ -297,7 +298,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *ade=
v, bool reset)
                }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-                       adev->virt.ops->ras_poison_handler(adev);
+                       adev->virt.ops->ras_poison_handler(adev, block);
                else
                        dev_warn(adev->dev,
                                "No ras_poison_handler interface in SRIOV!\=
n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umc.h
index 83199296ed10..26d2ae498daf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -102,7 +102,8 @@ struct amdgpu_umc {

 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);  int amdgpu_umc_ra=
s_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block); -=
int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block block, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
                struct amdgpu_irq_src *source,
                struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index f4963330c772..f300d4a4457d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1189,7 +1189,7 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_devic=
e *adev,
                amdgpu_ras_interrupt_dispatch(adev, &ih_data);
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-                       adev->virt.ops->ras_poison_handler(adev);
+                       adev->virt.ops->ras_poison_handler(adev, ras_if->bl=
ock);
                else
                        dev_warn(adev->dev,
                                "No ras_poison_handler interface in SRIOV f=
or VCN!\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 1b49c007ff62..fa7be5f277b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,7 +88,8 @@ struct amdgpu_virt_ops {
        int (*wait_reset)(struct amdgpu_device *adev);
        void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
                          u32 data1, u32 data2, u32 data3);
-       void (*ras_poison_handler)(struct amdgpu_device *adev);
+       void (*ras_poison_handler)(struct amdgpu_device *adev,
+                                       enum amdgpu_ras_block block);
 };

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 26d6286d86c9..9e7ce1e6bc06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -69,7 +69,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_devic=
e *adev,
                amdgpu_ras_interrupt_dispatch(adev, &ih_data);
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-                       adev->virt.ops->ras_poison_handler(adev);
+                       adev->virt.ops->ras_poison_handler(adev, ras_if->bl=
ock);
                else
                        dev_warn(adev->dev,
                                "No ras_poison_handler interface in SRIOV f=
or %s!\n", ras_if->name); diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.=
c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 63725b2ebc03..a2bd2c3b1ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -404,7 +404,8 @@ static int xgpu_ai_request_init_data(struct amdgpu_devi=
ce *adev)
        return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);  =
}

-static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev)
+static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,
+                                       enum amdgpu_ras_block block)
 {
        xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);  } diff --git a=
/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_n=
v.c
index 6a68ee946f1c..d0a018da3c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -152,14 +152,14 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_=
device *adev,
        xgpu_nv_mailbox_set_valid(adev, false);  }

-static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
-                                       enum idh_request req)
+static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *a=
dev,
+                       enum idh_request req, u32 data1, u32 data2, u32 dat=
a3)
 {
        int r, retry =3D 1;
        enum idh_event event =3D -1;

 send_request:
-       xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
+       xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);

        switch (req) {
        case IDH_REQ_GPU_INIT_ACCESS:
@@ -206,6 +206,13 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,
        return 0;
 }

+static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
+                                       enum idh_request req)
+{
+       return xgpu_nv_send_access_requests_with_param(adev,
+                                               req, 0, 0, 0);
+}
+
 static int xgpu_nv_request_reset(struct amdgpu_device *adev)  {
        int ret, i =3D 0;
@@ -424,9 +431,15 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *ade=
v)
        amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);  }

-static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev)
+static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
+               enum amdgpu_ras_block block)
 {
-       xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+       if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
+               xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+       } else {
+               xgpu_nv_send_access_requests_with_param(adev,
+                                       IDH_RAS_POISON, block, 0, 0);
+       }
 }

 const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D { diff --git a/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_in=
t_process_v10.c
index a7697ec8188e..9a06c6fb6605 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -132,6 +132,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption(struct kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
+       enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -151,12 +152,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_node *dev,
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
+               block =3D AMDGPU_RAS_BLOCK__GFX;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
        case SOC15_IH_CLIENTID_SDMA2:
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
+               block =3D AMDGPU_RAS_BLOCK__SDMA;
                break;
        default:
                break;
@@ -171,12 +174,12 @@ static void event_interrupt_poison_consumption(struct=
 kfd_node *dev,
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck,
+false);
        } else {
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
        }
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v11.c
index 2a65792fd116..c6d28e37ed46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -191,6 +191,7 @@ static void print_sq_intr_info_error(uint32_t context_i=
d0, uint32_t context_id1)  static void event_interrupt_poison_consumption_v=
11(struct kfd_node *dev,
                                uint16_t pasid, uint16_t source_id)  {
+       enum amdgpu_ras_block block =3D 0;
        int ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -210,8 +211,10 @@ static void event_interrupt_poison_consumption_v11(str=
uct kfd_node *dev,
        case SOC15_INTSRC_SQ_INTERRUPT_MSG:
                if (dev->dqm->ops.reset_queues)
                        ret =3D dev->dqm->ops.reset_queues(dev->dqm, pasid)=
;
+               block =3D AMDGPU_RAS_BLOCK__GFX;
                break;
        case SOC21_INTSRC_SDMA_ECC:
+               block =3D AMDGPU_RAS_BLOCK__SDMA;
        default:
                break;
        }
@@ -221,9 +224,9 @@ static void event_interrupt_poison_consumption_v11(stru=
ct kfd_node *dev,
        /* resetting queue passes, do page retirement without gpu reset
           resetting queue fails, fallback to gpu reset solution */
        if (!ret)
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck,
+false);
        else
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
 }

 static bool event_interrupt_isr_v11(struct kfd_node *dev, diff --git a/dri=
vers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/k=
fd_int_process_v9.c
index 27cdaea40501..91dd5e045b51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -143,6 +143,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption_v9(struct kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
+       enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -162,12 +163,14 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
+               block =3D AMDGPU_RAS_BLOCK__GFX;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
        case SOC15_IH_CLIENTID_SDMA2:
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
+               block =3D AMDGPU_RAS_BLOCK__SDMA;
                break;
        default:
                break;
@@ -182,12 +185,12 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck,
+false);
        } else {
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e);
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
        }
 }

--
2.25.1


--_000_BN9PR12MB5257B16FF57F79EE9532ADCCFC7A2BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
210,8 +211,10 @@ static void event_interrupt_poison_consumption_v11(struct =
kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_INTSRC_SQ_INTERRUPT=
_MSG:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (dev-&gt;dqm-&gt;ops.reset_queues)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D d=
ev-&gt;dqm-&gt;ops.reset_queues(dev-&gt;dqm, pasid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__GFX;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC21_INTSRC_SDMA_ECC:</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__SDMA;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#2B579A"><span style=
=3D"background-color:#E1DFDD;">@Chai, Thomas</span></font></a>/<a href=3D"m=
ailto:Zhigang.Luo@amd.com"><font color=3D"#2B579A"><span style=3D"backgroun=
d-color:#E1DFDD;">@Luo,
Zhigang</span></font></a>,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">even=
t_interrupt_poison_consumption_v11 was duplicated from v9 generation. Howev=
er, the hardware/firmware takes completely different approach to handle poi=
son consumption in gfx11.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">At t=
his stage, let&#8217;s just initialize block to AMDGPU_RAS_BLOCK__GFX for a=
ll the IQR sources (i.e., gfx 11 poison consumption notification was centra=
lized to RLC). I believe we still need a few
series to correct the v11 implementation.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">With=
 above addressed, the series is</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Luo, Zhigang &lt;<a href=3D"mailto:Zhigang.Luo@amd.com"><font color=3D"#0=
563C1"><u>Zhigang.Luo@amd.com</u></font></a>&gt; </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Thursday, January 25, 2024 07:22</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u=
>amd-gfx@lists.freedesktop.org</u></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"=
#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Skvortsov, Victor &lt=
;<a href=3D"mailto:Victor.Skvortsov@amd.com"><font color=3D"#0563C1"><u>Vic=
tor.Skvortsov@amd.com</u></font></a>&gt;;
Saye, Sashank &lt;<a href=3D"mailto:Sashank.Saye@amd.com"><font color=3D"#0=
563C1"><u>Sashank.Saye@amd.com</u></font></a>&gt;; Chai, Thomas &lt;<a href=
=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#0563C1"><u>YiPeng.Chai@amd.=
com</u></font></a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH 1/3] drm/amdgpu: Support passing poison consumption ras block t=
o SRIOV</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#05=
63C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Supp=
ort passing poison consumption ras blocks to SRIOV.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font col=
or=3D"#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++--</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_umc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 5 ++--</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_umc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 23 +++++++++++++++----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> ...=
/gpu/drm/amd/amdkfd/kfd_int_process_v10.c&nbsp; |&nbsp; 7 ++++--&nbsp; .../=
gpu/drm/amd/amdkfd/kfd_int_process_v11.c&nbsp; |&nbsp; 7 ++++--</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> ...=
/gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp; |&nbsp; 7 ++++--</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 13 =
files changed, 49 insertions(+), 22 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_amdkfd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 77e263660288..dfb93664e866 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
732,9 +732,10 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *a=
dev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(adev, =
NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, =
bool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block, bool reset)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_handler(adev, reset);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_handler(adev, block, re=
set);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev, diff =
--git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu_amdkfd.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 584a0cea5572..50d3e0149032 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
334,7 +334,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *ad=
ev);&nbsp; int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config);</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> voi=
d amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool reset);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_bloc=
k block, bool reset);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> boo=
l amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem=
 *mem);&nbsp; void amdgpu_amdkfd_block_mmu_notifications(void *p);&nbsp; in=
t amdgpu_amdkfd_criu_resume(void *p); diff --git
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x ebcd1cb60052..79bf6bd428a5 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2041,7 +2041,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handl=
er(struct ras_manager *</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_handler(adev, false);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_handler(adev, obj-&gt;h=
ead.block, false);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (block_obj-&gt;hw_ops &amp;=
&amp; block_obj-&gt;hw_ops-&gt;handle_poison_consumption)</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; poison_stat =3D block_obj-&gt;hw_ops-&gt;handle_poison_co=
nsumption(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x a6cdb69897f2..20436f81856a 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
246,7 +246,8 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_devic=
e *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_umc_poison_handler(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_bloc=
k block, bool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D AMDGPU_RAS_SUCCESS=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
297,7 +298,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, b=
ool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;virt.ops &amp;&amp; adev-&gt;virt.ops-&gt;ra=
s_poison_handler)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev, block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(=
adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;No ras_poison_handler interfac=
e in SRIOV!\n&quot;); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 83199296ed10..26d2ae498daf 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
102,7 +102,8 @@ struct amdgpu_umc {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);&nbsp; int amdgpu_umc_r=
as_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block); =
-int amdgpu_umc_poison_handler(struct amdgpu_device
*adev, bool reset);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_umc_poison_handler(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_bloc=
k block, bool reset);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_vcn.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x f4963330c772..f300d4a4457d 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1189,7 +1189,7 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *a=
dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_ras_interrupt_dispatch(adev, &amp;ih_data);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;virt.ops &amp;&amp; adev-&gt;virt.ops-&gt;ra=
s_poison_handler)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev, ras_if-&gt;block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(=
adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;No ras_poison_handler interfac=
e in SRIOV for VCN!\n&quot;); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 1b49c007ff62..fa7be5f277b9 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
88,7 +88,8 @@ struct amdgpu_virt_ops {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*wait_reset)(struct amdgp=
u_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*trans_msg)(struct amdgp=
u_device *adev, enum idh_request req,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; u32 data1, u32 data2, u32 data3);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*ras_poison_handler)(struct amdgpu_=
device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*ras_poison_handler)(struct amdgpu_=
device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum amdgpu_ras_block block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amd=
gpu/gfx_v11_0_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 26d6286d86c9..9e7ce1e6bc06 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
69,7 +69,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *a=
dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_ras_interrupt_dispatch(adev, &amp;ih_data);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;virt.ops &amp;&amp; adev-&gt;virt.ops-&gt;ra=
s_poison_handler)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&g=
t;ras_poison_handler(adev, ras_if-&gt;block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(=
adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;No ras_poison_handler interfac=
e in SRIOV for %s!\n&quot;, ras_if-&gt;name); diff --git a/drivers/gpu/drm/=
amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 63725b2ebc03..a2bd2c3b1ef9 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
404,7 +404,8 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *=
adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_ai_send_access_req=
uests(adev, IDH_REQ_GPU_INIT_DATA);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum amdgpu_ras_block block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_ai_send_access_requests(a=
dev, IDH_RAS_POISON);&nbsp; } diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu=
_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6a68ee946f1c..d0a018da3c7a 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
152,14 +152,14 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_devi=
ce *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_nv_mailbox_set_valid(adev=
, false);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int xgpu_nv_send_access_requests(struct amdgpu_device *adev,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum idh_request req)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idh_request req=
, u32 data1, u32 data2, u32 data3)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, retry =3D 1;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idh_event event =3D -1;</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sen=
d_request:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_nv_mailbox_trans_msg(adev, req, 0, 0=
, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_nv_mailbox_trans_msg(adev, req, data=
1, data2, data3);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (req) {</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_GPU_INIT_ACCESS:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
206,6 +206,13 @@ static int xgpu_nv_send_access_requests(struct amdgpu_devi=
ce *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int xgpu_nv_send_access_requests(struct amdgpu_device *adev,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum idh_request req)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests_with_=
param(adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req, 0, 0, 0);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int xgpu_nv_request_reset(struct amdgpu_device *adev)&nbsp; {</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
424,9 +431,15 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev=
-&gt;virt.rcv_irq, 0);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum amdgpu_ras_block block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgpu_nv_send_access_requests(adev, IDH_RA=
S_POISON);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_HWIP, 0) =
&lt; IP_VERSION(12, 0, 0)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; xgpu_nv_send_access_requests_with_param(adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 IDH_RAS_POISON, block, 0, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> con=
st struct amdgpu_virt_ops xgpu_nv_virt_ops =3D { diff --git a/drivers/gpu/d=
rm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_pr=
ocess_v10.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x a7697ec8188e..9a06c6fb6605 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
132,6 +132,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {&nbsp; static void event_inte=
rrupt_poison_consumption(struct kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint16_t client_id)&=
nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block =3D 0;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int old_poison, ret =3D -EINVA=
L;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D kfd_=
lookup_process_by_pasid(pasid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
151,12 +152,14 @@ static void event_interrupt_poison_consumption(struct kfd=
_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SE3SH:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_UTCL2:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D kfd_dqm_evict_pasid(dev-&gt;dqm, pasid);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__GFX;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA0:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA1:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA2:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA3:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA4:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__SDMA;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
171,12 +174,12 @@ static void event_interrupt_poison_consumption(struct kfd=
_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS=
 poison consumption, unmap queue flow succeeded: client id %d\n&quot;,</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, false);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, </=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+fal=
se);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS=
 poison consumption, fall back to gpu reset flow: client id %d\n&quot;,</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, true);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, tr=
ue);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_int_process_v11.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 2a65792fd116..c6d28e37ed46 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
191,6 +191,7 @@ static void print_sq_intr_info_error(uint32_t context_id0, =
uint32_t context_id1)&nbsp; static void event_interrupt_poison_consumption_=
v11(struct kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint16_t source_id)&=
nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block =3D 0;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D kfd_=
lookup_process_by_pasid(pasid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
210,8 +211,10 @@ static void event_interrupt_poison_consumption_v11(struct =
kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_INTSRC_SQ_INTERRUPT=
_MSG:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (dev-&gt;dqm-&gt;ops.reset_queues)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D d=
ev-&gt;dqm-&gt;ops.reset_queues(dev-&gt;dqm, pasid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__GFX;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC21_INTSRC_SDMA_ECC:</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__SDMA;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
221,9 +224,9 @@ static void event_interrupt_poison_consumption_v11(struct k=
fd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* resetting queue passes, do =
page retirement without gpu reset</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resetting qu=
eue fails, fallback to gpu reset solution */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, false);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, </=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+fal=
se);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, true);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, tr=
ue);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic bool event_interrupt_isr_v11(struct kfd_node *dev, diff --git a/drivers=
/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_i=
nt_process_v9.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 27cdaea40501..91dd5e045b51 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
143,6 +143,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {&nbsp; static void event_inte=
rrupt_poison_consumption_v9(struct kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint16_t client_id)&=
nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block =3D 0;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int old_poison, ret =3D -EINVA=
L;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D kfd_=
lookup_process_by_pasid(pasid);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
162,12 +163,14 @@ static void event_interrupt_poison_consumption_v9(struct =
kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SE3SH:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_UTCL2:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D kfd_dqm_evict_pasid(dev-&gt;dqm, pasid);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__GFX;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA0:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA1:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA2:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA3:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA4:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; block =3D AMDGPU_RAS_BLOCK__SDMA;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
182,12 +185,12 @@ static void event_interrupt_poison_consumption_v9(struct =
kfd_node *dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS=
 poison consumption, unmap queue flow succeeded: client id %d\n&quot;,</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, false);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, </=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+fal=
se);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS=
 poison consumption, fall back to gpu reset flow: client id %d\n&quot;,</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, true);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;adev, block, tr=
ue);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.25=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257B16FF57F79EE9532ADCCFC7A2BN9PR12MB5257namp_--
