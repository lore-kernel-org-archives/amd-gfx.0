Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C05C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 08:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DC210E5C0;
	Thu,  3 Nov 2022 08:00:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C434510E5B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 08:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtXP1x2TPmk9xspuVswZ3XvHhPWNgM4b+j2jtYkLfUC8AwjbB0j7M4lSbdgFGuEzzA/OlQZJ/JCREcmhjo7hiEuGZE+vCm2isU0V08g9NI63EJv4rcRS7aEb/DZ7900pQvJl0AXq0uFbQkkvhom+608iDm57+HZhLrMx9ZVg109AiNChL9Y2HNx+TTXKPgiQ2G0BVOpomHT49NWRTXMs3DHAJBqed+BT/NtCs2C/XFLy2+eCHNhB/YA4UF8i4tHlfFu/tM7EWNxaJUdq65Bi15MsQysMNe1w46784f3hLUPGCWmVTOhcSC5Bz9SCJx89bxxQqOuJgHM9OMTfnaNoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbfR3WJfTdgePkPxOTVcambHYHHfR2j0FDx6wPAy5Yo=;
 b=jqGkooAu/FlcMXSXoK2+I+yGfM+7Bv1xbX3NBp6qzmzx9mrdH2rAVz2JDsi+1w66t6HaTxi1AV6GQyH0AivC2MJnvmPRCuueJAw16PrYjmPHenKUVB1TSL+uyyW6x1hqGsixnjcwFusUx58M+n1EtOROSlRKnz+6tjLNKIiWyTY4DCtFiXwR/kfD2fvBY84m9UNKM4lDf5CGbOE4/krOemxWkAH1VmxWUxHq9Ef07vBn7oiHTSsI0AfVchJh93BKq9gwFxzAv/Y7PpiE4AAb1ijDFH45WOR/hkAKzg9aM4ZzdZvLxUXBIwBgzizlRnw0mQuk83mq2dxwWed5YQQNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbfR3WJfTdgePkPxOTVcambHYHHfR2j0FDx6wPAy5Yo=;
 b=hlBSonCefY0XjmRaIIttflhRgvDBGVSh0t+m483OrTBj5qAqVOK8VgUnAH6CVnc+ZENS29cT9MNUnLg7Q47sPxvhOn7egg7fRd44NJ5yFzE0l6bNtHQqKAweGh9V1qxYV7sfr8jxoIdOCn29KWeMiGRvYUY47lGV708w3Rchwkc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 08:00:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 08:00:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Index: AQHY7zImiLs/UJjSeU+sKNbRx2BA5K4sv4cAgAABHECAAAHy0IAAEoEAgAAA26A=
Date: Thu, 3 Nov 2022 08:00:11 +0000
Message-ID: <BN9PR12MB5257FE78BE3C16F2AAF1F498FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
 <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
 <BN9PR12MB525734DF8D8626B32C26E772FC389@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB52571E57E64A3E1C8CDA0DBCFC389@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM6PR12MB3035194490B11F5161C61212E5389@DM6PR12MB3035.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3035194490B11F5161C61212E5389@DM6PR12MB3035.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T08:00:06Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=663ae64c-b53a-4868-8d0c-019080713262;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6046:EE_
x-ms-office365-filtering-correlation-id: cfddbcb6-11a3-4d79-f76d-08dabd716ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfUxaif01ajcYknxGInJRS3XR/NDPqzEaYgj5qW8bjBVCkcceIKax/CGU3iWCY5dOKX51KGAcQeIIhHRNMdpMB6CRNYoTT54ucMz8Rjc0kBCD0MGABxWg+SDvhU5XZBybmMarU76WE6NWRFxWxV2Uj2WaIHZxKhwskceS+qut/HHAmgbOW4/+JGfQ524Kt+YpoI+Jwv3ahw6Lirn1eQS0TCh4oiLjchg+owSrIWvg7JRv8z5WxWg+8oUuYDnYZvVLkQMeLeoKLlCL2WHDK56R893bAbH3tCZNKkcu4rD/+ndC0BmzQPBySp8oaNOV6zZDjN1P/j+sRGMEgPMf6PRucLmXvsvLns13QPBzVMx0HZiEKf4E2VnxstT0vZ6kMMShO26T2AGc/N1DwGgJdqBzg/nAau3rAwliZkKi/wEWfm05TggwqPykb28o9DMW0bLxjp6KG9Irng95Q/AUSgcgzP3f64FSUKKiO/lwImQ5Ra/1LsIpdBAYC/XAkmEIsnYpSPykyb7B818tM+jLza7nFcO/QzOp7plwIYSZmMT1d9s21+Z8T+I0+BypCYaSJPuk+EJ7+cYfjYUAxyJYjjrmGPIHXS1b//7idNNvlYLKv7Yo5Xmh6mRJRxVAaBScqeaLJOZaRthISIo1qzXlZBK2N7mrTT6/ZcwluBH9k8y+Yf/Ho8qBY1tFXq1AONvQx0gbiPvh1QTuNZkfuV3aJiqVlhewUnPPxipaqDdAT8q/ZJM9Zpt0ic3apZh0smqfIHcAQbBqo10TPwBC7bVJAkncQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(66446008)(86362001)(33656002)(122000001)(38100700002)(38070700005)(186003)(2906002)(53546011)(55016003)(9686003)(110136005)(478600001)(26005)(83380400001)(7696005)(6506007)(66556008)(54906003)(41300700001)(6636002)(66946007)(64756008)(5660300002)(76116006)(316002)(4326008)(71200400001)(8936002)(8676002)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2vq6a0+xk7pZxTYxLA4w3o/BQGkawYr19ElAeFEeKRjk49No/SudNYRq/CI7?=
 =?us-ascii?Q?LYVXnFe/CcsyxsFNr8qAYinCQ+l5eDoi7cnXKWdIEz/h0nIDKEC8xKFi3Owx?=
 =?us-ascii?Q?wvkhWhC5Y5Al7U2u0S8NvB+VKcawcbwyZH7v3jyswAbl4h3b8vSqsaK+eDLA?=
 =?us-ascii?Q?GcLv8p6MEHARHTPNeV5AeaIYEs3G/OLxJBvOoe8n3rhFkw7YjspWKuDR4sFt?=
 =?us-ascii?Q?f8cyCw/S8kaqz9pzVc2GrOuXG9+6bzidwBGiEx3joF78TZln2+8IyTDJisBZ?=
 =?us-ascii?Q?rXhFyRJTKmbG2iJHN+ElYLyb7LE8dtQk6x0vGriakXJMbeA3vmQXt90ca3i9?=
 =?us-ascii?Q?jRRM6poccw+3/dZfWoFrUXbB5INIF+pXjhbcykj4lGtTj/iA/+dgmo39R74+?=
 =?us-ascii?Q?BChy3eJPn6OFJKDN6SSN9doQ+FQB6Wom5RkVfT0QMMcrAMHToYPPrXXv1ck0?=
 =?us-ascii?Q?6NimcMMgUCQpyXn/jy9eiEBrsANZGCmnTCSq/w4A28J0RLKtXRcloaCBOeKV?=
 =?us-ascii?Q?M4ZDmyl1d/OoLpGLGY/aEWDgubNLgtKN0ZJKnC1pfEyWM4aCsAUxhvRj05nt?=
 =?us-ascii?Q?A0uU1nYuthSlpFoZdTRKrKMPyAlrGodveIDfPT34KpZrVWevAvzMTScXoM11?=
 =?us-ascii?Q?Cz87oPEBw3IM3+pJmU8/7CYO9QR3buRT9sdgjIElTmzk4vzFpPg3/Sa5SVDZ?=
 =?us-ascii?Q?yhNXg27gLPmNATQP5jIWMNAZ2BgmgO001vBuCW3YMyNCYUtSJi8ZoNN20lHY?=
 =?us-ascii?Q?J2VD0tV+h7kmYZWhkN1JsXm+CCHAaWqe7gNTL7pejaTzea4UefeFPAQ86676?=
 =?us-ascii?Q?Tncs1dV0xIFMtHN35dd+eXZESvhv592HG3FRuw8HT06ZnCRXMh7Epb9DsUjm?=
 =?us-ascii?Q?3F508MXsMfI1oq/cMstAoMhPwPl2NToluPPsbpRly/Lf7zb9cGdQ78qZBPcE?=
 =?us-ascii?Q?UZneLUHsCm1a5ajYVaWnnvpiGjCjdhXI0WHdsaWMo4JCSUPUhpquY6CUAeFm?=
 =?us-ascii?Q?HT3KvMpFyfi6qSNu4ZBhiljxoOPZl35z/D71K3CfKBHiEwzUiOGQN1lhzCJN?=
 =?us-ascii?Q?NRkgfoSR/OqvcdfMEdbNkH1RVx1znrRv8kRNlFjF+8UDC4e5XI5Gh8tyiJ43?=
 =?us-ascii?Q?ruX4PrAboM98DEW+BsPV9Q1t1oPWS2CAxiMh0fKmRtaKJ+oxKdc61jXAW3Ag?=
 =?us-ascii?Q?y3LBLkVDP2WoToAg5l/7VN5RRf11eDnSH4vM7hecbXNYVaBfASxQtUHKdQx4?=
 =?us-ascii?Q?7K5m1nh0IvSSnJckxma/1DiePm7whu/uRE6H61q72scqhvLNxDDmzgPASlCH?=
 =?us-ascii?Q?gCpFQpGh1occuXL4W2J+I8IrAlpsIYF2X9yQ+Nw37/3AP2HutbmPoG1GvIQS?=
 =?us-ascii?Q?LZSJVmZk4TzYvZ+BxORFccdRHXCgRKfQznPZzrEcXf2QCJAsbFN584Qp83T1?=
 =?us-ascii?Q?bRuIOYuk182LfNLxrohCfpEz6MXTdbraA+UNgXZXE6YFeGPl4xtMEqY1njnV?=
 =?us-ascii?Q?DHaXYUv9eZQL/bXIEdweg10PpGS7wWQARn8g6MtTc8pLRmSwbQJrRc4Rq/YL?=
 =?us-ascii?Q?VgJ7wEj9ZGiPMM0zHaNVJhgoG1R3JRSUmHWcTGNJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfddbcb6-11a3-4d79-f76d-08dabd716ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 08:00:11.1031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUqeSEO5GZV+DeVDukwY/JNUbrUqPji9AGPRYTH68PyF12Bx+b5gG9KMhU0xNdQXIDWKKko+12TUYCPx3QLixg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

No worries. Let's know if you run into any RAS issue in SRIOV environment.

Regards,
Hawking

-----Original Message-----
From: Wang, YuBiao <YuBiao.Wang@amd.com>=20
Sent: Thursday, November 3, 2022 15:56
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tu=
ikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koeni=
g@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

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
