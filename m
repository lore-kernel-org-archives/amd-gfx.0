Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E88DCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 06:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7874A10E385;
	Wed, 18 Oct 2023 06:00:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDD410E385
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 06:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwygOXvnrx/VF8BxVvKDCsLHpBUC/TPbHvBlXUGeYrI895x1n9fqRoK9EoLI39rz+7TPFRZkIGFwsvN0Nw2fGOXuCqYWbOS76rCBrY7WPO21mlJHkuZfcYbGT4J3yA4zckuSh0zfn7GSIZfUxVfrSq3XLqI1svM1JZaQ0x4G8bRg9L95MeR13oIqoT0RmdtJg3C2WsCSmLzVFFe2Uik0NiofVkuRCkTAfpkiXkGKjfZFmtcjJB43qmsTY0237V2ycgRaMCPjDUDlEvjp84HQqJTx/N9C1huJiVrgfEoPdSQhRHjUVhRvQyupx59Y+V5jEkZjuln18FrIE+9+L4D+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/pCh8BLN7aAnrtARpjYW3Z+Du6DhSL7wUMHUHp1Qz4=;
 b=KwLxBqH4xOGVY0DPMhy4hVXeSeVNd2aYVjOMqionfLsNn+De/ryUCMKWS/b7m0qqws6bam7TjoKcGL8XxI2zOIkC9HjlFPmTUnnni9hVnb4KsancTDBWPtrxioNYF0sH61iyQkvhJ0rYWjnBvzJnnkoczV47iffuxvwrBwtPG8LFp3wBa9LwnrUyP4Ybbw/GXVa2axZBpSlAkX5OMVHdx2tFrFb9iMWrRhazICOU6wjfeg2gk/OxGIqxiI3rgQ6NAodzVWcjLEQNWqGx4Tp8IO9B36YX/xACpNVi1nKNGD4aK2WjQW1yjjgy81SPp6nqN9F13yKOTXT03Dzf2xvEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/pCh8BLN7aAnrtARpjYW3Z+Du6DhSL7wUMHUHp1Qz4=;
 b=FS1r71JxpN51lzH1tom8e1xQ0VuWihb1JBrlEpU95Nm1Yfx7KNMJrJfYsIFUxEIxeQY/ah07rbVI/sYPYIiLWdOLfZ6Y/1UM2zwsyfpNcuukh6gJMz46r6WMny2vnOxSg5CYyoSCqR5rdd63nuBoo7+XPANskhYFSlJVxBkTPmw=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 06:00:42 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 06:00:42 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Index: AQHaAQdZG+uF94IAa0S8RuGsakVc/7BO3G+AgAAyR1A=
Date: Wed, 18 Oct 2023 06:00:41 +0000
Message-ID: <PH7PR12MB79881AF2C9D77C676185AB919AD5A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231017143638.3203961-1-Stanley.Yang@amd.com>
 <PH7PR12MB87962D8997F0A360450D5F0EB0D5A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87962D8997F0A360450D5F0EB0D5A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7bb9da4f-da0e-4530-93b9-558752e1d879;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T02:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CY8PR12MB9035:EE_
x-ms-office365-filtering-correlation-id: cdd09625-1d25-4490-dfff-08dbcf9f8f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0KbuB4SqEZGi9WvVg+pQiCrJ1wHU5dERNSVQiz2J9nGyQDWGulKxBkb/3kYv1IXbN34D/C8nlhrNJ19Edmix3CV3lrvg0fhV/Ypp/fcBDIX9/M3cz+/dZche0fsEjgTLYh9ljNO2zjoMSngAKPWLOgoEQRKgx0wuTbd1LgxBmGuB3lisVZSnxwr4BgYG2TyOC6AbEofPTTcAmE7p7Kt5SYlcnKwcYNxlbezL5s/lRHH31i12FuXHKFRbmNiaSbMWjNiyHaOlz8PQIi80oB0A71ohuFs79nHXyfvoIUppZ3q7ZsRA9EFjT5NQuVaMzNicq3VB57ouqkTNaMFgIbiJMdh1wBloM8FhLOeYJIP/kbVhmnxAk6zf3dbuopCs1zHCKawY37v4qEvimtj88WzHzy/6yJ/K9bHjSPPsceKo1U+iPGI4DLZYPkyfGvbaRPWPB9vX/j7hbZAijn1HJXAvEA+LgM+6dn25E1eAayIr3bHJYBJfrobdlnZHy8dfwDpMO7QQr6AFwSRKJUTGxv95aL7U21ZgearkSgEgSMoovgLIkQXmvlCAZ560o+C8N7QPp5AM38yEXt96lZu7cEOrEYS4w7/CiDrk3dyDSr8itc65GtQfpHgCOVKUpbjpI7y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(38100700002)(55016003)(9686003)(38070700005)(122000001)(2906002)(86362001)(316002)(110136005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(5660300002)(52536014)(8676002)(8936002)(478600001)(6506007)(7696005)(53546011)(71200400001)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k7qqlJ/ZjBHgLRY8mR9QL30ewUhlmRqf2Hl7ycEl4UMeyd0UMu6Z6mm/0b/k?=
 =?us-ascii?Q?ynhYMkOatNQdTij1U5vAdWYqv4PO549KvYNO56VLfKnYNIfz1HF0fDdjhGtF?=
 =?us-ascii?Q?u/uuMJlLJXFZYqgqv7CgI7JVMvVNvA9lnjZreQt538maSMG+4IjKki2D3Nmk?=
 =?us-ascii?Q?gfZ0Ek+eXWfUmVK5rGhN50h4GqnYIer0rPcvdvETewuRrZkQ7Z4qraaAp/r0?=
 =?us-ascii?Q?ewPousywurs/tgoa+z8bW9fPgZSpSvWPfPzC30lYJht3l/LR0NSosEelGDXO?=
 =?us-ascii?Q?pQe5j8IdyEzlHH337dDrGKg6+w+f6jwsJ/ssVhU9ZMFfGtIgtPd4Wc5iWrHq?=
 =?us-ascii?Q?6eZtAQGWL1Yk+e9AEzzUr8v9vst26+V6nVJWH7PtcbAT2ttFaCOT3eZFNDGT?=
 =?us-ascii?Q?zb0YDeNf6lxA+iNcAG3ltwB9eJzwDvKAOTwMkRzgM4wknSKUG2bo8mySf0mb?=
 =?us-ascii?Q?GhDZVqSZYQOWWjZMOsFgD5NzzLxRsUK44Ihv5kkJl0vANwk8Eeh6ZR76tXLt?=
 =?us-ascii?Q?aI8/WoMY5wOY/R4HDF92w3zjBFBBZTlqYP//146w1S4CWf8nYQlx0uSGV7BE?=
 =?us-ascii?Q?rP7uFyxWbSAHd1eY6+3VefX6ZMK5oSqt7J43Wh9KiF0oKHxxddDCAIFDEaQN?=
 =?us-ascii?Q?AwLk2xYG+hm8G9vmv0N4l1ANHqRGLC+sx9vqt/zC0cyiXRRXz+ul+PhNkbNa?=
 =?us-ascii?Q?6S3gpV6kACYhZ/hrkMuN1gEo/GpLTg3kAzf6MH+h9YvMzaJw5ftJtuATpgqL?=
 =?us-ascii?Q?ushr+nCVW0foD+uRt7sgSNyB4G1K7DTpS9STla2CYcjWEF89sNJICcaRlNHj?=
 =?us-ascii?Q?W86hXYLD43tOSiGVNesOwfqKgBe0J/g1vqd9Z5/P27YQ0j+rIzPfBo+Q3md0?=
 =?us-ascii?Q?FGXzjShHp87wiQLjnzJ4s5YDSCI2eiGa8xlk6/83HqdZ/3ckTl9JPmkyt6cm?=
 =?us-ascii?Q?k5enfONR9kaHMu38LXWEyYQb98Er/BJCHq3ElVi1kFwHLrFXkjOyfOe9STpY?=
 =?us-ascii?Q?1fJtQuxlT/qP1Z+cRNagA7Aqg0ijezlTxS66hJ6AbOQkNLvnqTKA5QsAj4ms?=
 =?us-ascii?Q?PflAjujrZ/YrbduUgvyRFzYMYY8LASuAel4l2S2A1ELNa5WeIexxcZneanUe?=
 =?us-ascii?Q?CFYo+BAy7EnojW9LOH6VhmdoF5B7ap+5NiMU314C2v0bY/ZO/FkX+p70Ofux?=
 =?us-ascii?Q?sWpSSI/VNGT+9y/DG5WDF59MDtxcPh4tXDHpNIMoO6rR+xC1UOBslX3BeIN2?=
 =?us-ascii?Q?nMIiKxMS3xDt8acwNoBG2k5VgSE/cXeLVd9XZD+ke1zRrjzkkhysEV9LZtSB?=
 =?us-ascii?Q?7dJiXCVJ6Fj0Yu/n0sgeodja2dyNGiyXBQwnFx3ejaGFfZA1nCXIYut2azpQ?=
 =?us-ascii?Q?xKoRh+sFU+IYajRhPLxRKvhjX07P5ozX8MUn/0OUdm1P/L+ab2SpiuHmVfC1?=
 =?us-ascii?Q?w8B99QFo9d8omDEYbKxqluBq/U/OG96byXGzzZgXMsjtT/vD6h3ufP5K2DWp?=
 =?us-ascii?Q?T5zkLKcHnF2Ymh99IsXCj6AK1rL6TxMK9jy4JFxg5nBpkkfkswtVa5pLcVWi?=
 =?us-ascii?Q?iX3HtGyi3tYtK8osOPo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd09625-1d25-4490-dfff-08dbcf9f8f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 06:00:41.7685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSQAd7mHaXbHzT2xWEgqTyUjGnGss29BjzgQCDBAPJT2G3Vz5GQKo5RGLLDoT/piSWJhBJAxe57wE6M0Wef2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

[AMD Official Use Only - General]

Thanks, will update.

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, October 18, 2023 11:00 AM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring
> test during ras gpu recovery
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Stanley.Yang
> > Sent: Tuesday, October 17, 2023 10:37 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring
> > test during ras gpu recovery
> >
> > This is workaround, kiq ring test failed in suspend stage when do ras
> > recovery for gfx v9_4_3.
> >
> > Change-Id: I8de9900aa76706f59bc029d4e9e8438c6e1db8e0
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21
> +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 9a158018ae16..902e60203809 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -29,6 +29,7 @@
> >  #include "amdgpu_rlc.h"
> >  #include "amdgpu_ras.h"
> >  #include "amdgpu_xcp.h"
> > +#include "amdgpu_xgmi.h"
> >
> >  /* delay 0.1 second to enable gfx off feature */
> >  #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> > @@ -501,6 +502,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
> > *adev, int xcc_id)  {
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
> >       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > +     struct amdgpu_hive_info *hive;
> > +     struct amdgpu_ras *ras;
> > +     int hive_ras_recovery;
> >       int i, r =3D 0;
> >       int j;
> >
> > @@ -521,6 +525,23 @@ int amdgpu_gfx_disable_kcq(struct
> amdgpu_device
> > *adev, int xcc_id)
> >                                          RESET_QUEUES, 0, 0);
> >       }
> >
> > +     /**
> > +      * This is workaround: only skip kiq_ring test
> > +      * during ras recovery in suspend stage for gfx v9_4_3
> > +      */
> > +     hive =3D amdgpu_get_xgmi_hive(adev);
> > +     if (hive) {
> [Tao] the hive_ras_recovery should has default value if !hive.
> With that fixed, the patch is:
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > +             hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
> > +             amdgpu_put_xgmi_hive(hive);
> > +     }
> > +
> > +     ras =3D amdgpu_ras_get_context(adev);
> > +     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, =
3)) &&
> > +             ras && (atomic_read(&ras->in_recovery) ||
> > + hive_ras_recovery))
> > {
> > +             spin_unlock(&kiq->ring_lock);
> > +             return 0;
> > +     }
> > +
> >       if (kiq_ring->sched.ready && !adev->job_hang)
> >               r =3D amdgpu_ring_test_helper(kiq_ring);
> >       spin_unlock(&kiq->ring_lock);
> > --
> > 2.25.1
>

