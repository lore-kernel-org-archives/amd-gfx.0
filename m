Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 07:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9990A10E5B4;
	Thu,  3 Nov 2022 07:56:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0E810E5B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 07:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMRwohoULGhKpYd8+Cy4vN20YVhI4VmGU+fr9E4VTZyjuCrErzLU1vIkUOmngSjSn7mZldNsmuW49wEuPW9k6fA1hOLM4OtLwll4ePkgXaVasJMPT0HLkTMnf6Pc1Z1yuJUePdCgOg79gKc1keQaxA7p/oklGyqwqh5/hnp0Yr3ZMUwLsD7sE4+4vYw5p40joRUmnSp6XO+E5K3vDDtxGasv6TOWApDAoGXvI3X6WuXBPyQNrE3sjoPHnSIV1Bvql7ikhw0U1w1uLK8cOL5jdEWuY6abfPpPJBk/4CkrjzQ1RnA9peWfBidRdtixWdtT4pba8QnF5au1BjmbTLs8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xkw6xCkJPFax7mhu4+Y2tsVyXBCx9ln/sTQ/kSB+Zo=;
 b=LSfkcd/XF2Lq1MNODSXmJKWyEcHZ3L9mLjOmGrt0BuNdq9y3yudI3z8iyIoZ73J4oMfkXn/pWwtHtvCm0y1O65OOWShNYqq8QCyDHcx4AnJJmf69uiNCL83Ct238IpBQd0wCPQdZDHblXZIetml3ruGaqrGjHGTCVaTSr+IIAFutjLnbQqgVzE8H4FaqQ9l7YvGGbqqakTHFa47nWx6pq/DWMOOfAAmNa/s/uAQtXdZY6nGes/0/djKsA/QYR2A+1IBFLpNyjAOYIrY3nim4WppXDEt/vMvtlTjhfKAFmAw+QIT0JmLThcNUHRmvF+nmd/+05tw3lB+iVgi8lUzqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xkw6xCkJPFax7mhu4+Y2tsVyXBCx9ln/sTQ/kSB+Zo=;
 b=KBh/2HznrXGBozxxYpna4oLRKA8jrKtYJd6Ay8uNcMPZAEwYNrYgnZG9QJAL6mNMuoU882C5d/R1g5zQ3AF8QFIFw9VAmFG9G36v/jLfdqSA78alMRHoqb+KXghGgWt9TKWuzWHAXL3EzmaOu3PKZdx/RWGUJ/jP0b2l82+Eu3Q=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 07:56:12 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea%7]) with mapi id 15.20.5769.024; Thu, 3 Nov 2022
 07:56:12 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Index: AQHY7zImzMfN7osu70271KM7JDmi1K4svyYAgAACdoCAAAFQgIAAESnw
Date: Thu, 3 Nov 2022 07:56:12 +0000
Message-ID: <DM6PR12MB3035194490B11F5161C61212E5389@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
 <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
 <BN9PR12MB525734DF8D8626B32C26E772FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB52571E57E64A3E1C8CDA0DBCFC389@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52571E57E64A3E1C8CDA0DBCFC389@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
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
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|SN7PR12MB6931:EE_
x-ms-office365-filtering-correlation-id: f57fc77e-4c17-4c4c-0149-08dabd70e08f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY+9T2bQkeEv5NIE4GMwgawTENMYdeKADt0ZYvmYkNnJCN/AQ1U8qDnMBHQnE0mh2lZuzq6zKKOAJKZO+nt/xgoyvHT65ChOG52Oj9vxVjgkOZC5ufB1pVOlxN6Nzxn3kw7Wy0IcgnbHGIZEKO8GsSUIhBcFYSiqQI17GbOusbNqcxc3bcsH371boskIKs38scY/q3GV4FxEQTmbtLMXW8gaIMIAJ9JKAFgKZM++UBRdsIByWoYFKhzk3XXim1iCoJa1tCx1KtLtH6u5kqpcwSa/ffT0CdbZZaOGr3LwFQ5SO3321J9lOxwyobnI7kbwH6bw8jpkhjPQTM3O7dCd6PjOj+rU4P+sXzUNiT2uOwwMecgKVpUfQxbrAo2ZOaLJ+DpgcxcYF7aU5bt0keAMxBpehhPnjoAsZ6errEP+fSUZPkvqjneTmXWivnqAYL0P7dtffIElK9pPWTk9g28l6gZc8BEsNXvlFcIWs3MrvRboUXP5CoWpI3jf8XLoIYyJm6qSfKMUWcCTdUDnS5qHRjC+N558akkMzwA7PfLdb/QCaEdV91hDKDIcYBTmJfN4Y2aElnHTXPaTuoAUPCR+DBC4i9HsZpbJTpMYCMxkGhzyFCbFjbQeSWxYE/OlDXsTpg6vqUJlx1RYfBA46GlTAzz8lsKuC2zS7Ut8S4TbKV5Z1wf/e27MtJWygsLEfcGEDwNYZNc/Ubtnyth7x/2Z+vmXHIOPtXayBOgzPJBq2m3nfW9Ly5Roth9aG5ENVjhrfw0LpZm2TkOphCY0R57AGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(83380400001)(54906003)(478600001)(66946007)(66446008)(53546011)(66476007)(316002)(110136005)(122000001)(6636002)(76116006)(38070700005)(6506007)(64756008)(7696005)(66556008)(8676002)(71200400001)(4326008)(38100700002)(9686003)(26005)(5660300002)(41300700001)(186003)(8936002)(55016003)(33656002)(2906002)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bO5JZdPKpNkn9QcQ6qzX9EJncQEwJoVyV9QPtpvn/4UHntDMEro50a18pB6v?=
 =?us-ascii?Q?PzZKEqzUhaGeiK8IqyMtkpinoXtEw9ioSGScCXaY6oR5FLav2tfAFZ6ycF5c?=
 =?us-ascii?Q?zraZTgg5YVTIUxp+18CF58k6nloszYbS2gbCMEMzFDUjZ2rAhlXIQi7JTBpP?=
 =?us-ascii?Q?kLbir2C8CiC5oDiD4q0phFhU0YkhkWXsE7TX6+MyX/qc3djjaqAAxbLo/Jme?=
 =?us-ascii?Q?PUKRD8GONx5uQEtnBmFFKG3CR8Pq4Y50zZqQnzVIDM46nGmUDuzu3m5J1WLy?=
 =?us-ascii?Q?oGHuBoIbHfTThEGkmYJfti7CHGQBBWEaxxUSc+omkx0vFljXOJHFA/EWnm7j?=
 =?us-ascii?Q?JFlO5iizdkcU344PYuQqo6QisXsa83jXabqbase0+mlFEqeVLsAWMEncbbEX?=
 =?us-ascii?Q?VYf4tJR7IU1qku/HHUtZk0d9smtNc/qt0tLakCryF94LlWFRVXtqLryliAg/?=
 =?us-ascii?Q?VBbUCsfmjNaiAKMG4MT433XV0t1LEXYEhjS73WfqbIcBo3CfrexrLSHDBO8K?=
 =?us-ascii?Q?/9IKNt5XISJAxRiS7CvNJKk1cF9GdApYnbWbdKq1Z5mge4Ni1Pqxh5Q/XWYO?=
 =?us-ascii?Q?6X6hToibywK3MzLtMRrSNASSaXvqegBB6E/sBGmxSfOkUilfd7bs/ffJEeUE?=
 =?us-ascii?Q?Cndx7wAtDPd1TB0sOVb5cZ+nw6CINjidHfi9ohVhUARZuaXsAXIYpJ7R30NL?=
 =?us-ascii?Q?6WnS9o0KZ9Qzkqid9TS3HUEtpEFGo7eI2asOLV7JnoZEdkiZfdbZRB22ZgQ4?=
 =?us-ascii?Q?UT6wcfbn3f1zkYtkUagni+7dWCTBnm9KK1x62cXDqe/PtRETUFonTrOwfChX?=
 =?us-ascii?Q?lsT035UcAUHj/UlXem4qLuwn902M1GJenB99ZH9iliY+iIQrhEQI0GFPkEdV?=
 =?us-ascii?Q?J2dsBAcsJPmrxcG7peOyUZ9BtdXUR+ztf7p6tWko7asdNGuurOAZJYRKpnKg?=
 =?us-ascii?Q?S8lsU/Qh/OvUbTPAUEugu6bfGxlHSn7x/TK+NqCnFc2Yrk3n9L/w6Y/ichB7?=
 =?us-ascii?Q?PcuNlb+txRQYIKJQxhCbuJ1U9fG2RX/CJl11V+Eeqg7rWGJerZLfXH9yQHQ8?=
 =?us-ascii?Q?aY6Z1oi/R9nmfbExSLs0M6MQWLEeMUTSfv0HRCDfHy0Fmao5XXj9uBv5ahX+?=
 =?us-ascii?Q?cnK0NXn842K/0VN5tj6NWjFqPA/1W1a6OMFdiJFMqHz+WP/LqEgJs+k+gtnE?=
 =?us-ascii?Q?GRvWgoH5Wq0t4W9L3RVE2tuo8qiJeKAS3d9SRssW/6zS79DTVk6XVgSarCQL?=
 =?us-ascii?Q?SrxW1niWaT/QgcZAXJH/AOVe3Lk54HU6FlzRlsxo78R4urkLe7Z3FUqiPBRf?=
 =?us-ascii?Q?nitNUKzdUgmkpW4clO0GGAJ5+5o7F23QttWyYyrZ39uwFe+mu+axHS02TBzz?=
 =?us-ascii?Q?sGCyOsssewBYYOWw4fTUsitKEBUOMsWkD7RymS1QnpVLAyQCRnhk5kkmIy7n?=
 =?us-ascii?Q?lFzRhQcQlnR7YZ4mLlGWFRusKluqyKEsNK3ZmElOPM1svLM5czBT23+MWKQq?=
 =?us-ascii?Q?gqLZJeVfbIFy3qnu/zlGCDJDjiWCakJFVxYkEDtwf5p3SJapffqaaGOVEAVS?=
 =?us-ascii?Q?fd4Yb999ge04HH/dRMGAR+KQbmm82+D6yIyluXa6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57fc77e-4c17-4c4c-0149-08dabd70e08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:56:12.7489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vr0fFNBOaJs4yXPHCvOCZtkFUQWtUSKOMsw2O8HIdWxZPGKGVADIMLBiIT3YvQV/jboVpWv7i9J4j+KLCt8ctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

Hi Hawking,

Yes I now noticed that. I was sending this patch since I found it as a regr=
ession on my side. So this is caused by IFWI regression instead of a sriov-=
only bug. Sorry for the misunderstanding. Thanks!

Regards,
Yubiao

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Thursday, November 3, 2022 2:51 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.c=
om>; amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tu=
ikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koeni=
g@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

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
