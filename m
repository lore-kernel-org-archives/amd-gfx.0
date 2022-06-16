Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA21C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 03:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDD810E0FC;
	Thu, 16 Jun 2022 03:49:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC0A10E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 03:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiS0jtjcxg2PBCHKOnvoRDesmJNepzs/AhyVJQnkSpTFV5K8gUeIsnuAGhiKmDxB2HOY4HaiVfoeS2o3X/CgXFhSkVJtfRGuh+qfg2uJwBs9vdHsPvsj0TgVbGFj8oIdC3RN9xMMKi7efDWXs+ca5Dlci3stwanomEzU7LkGGVNkGsf3625cdBiv+ZGgsk4UgqF1Zb8i9U5kE/Z1MiXsGgBrsXfEqpC1l9Nwyc2kfD/OowOaavZcljn7jQiKkfAXNFYkGWXufANr594AE37xs2u5f1yEFj182M0iI1HKrCyqxzCguKlAfu3nG7v8QCHalnrY1eqNFToJIzn1YvhI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOVtMA4+M7dx+AvA88YV+AC36X0Dsw6CQ59VORxXqjw=;
 b=b34GvPygps033FRKQJ9xlCEFEoXqYfXlpyvr5VGYjz2uQIwI62yz90WRuBZWoETjUb1IUW0jR6uAqhhE0rGydr8pPbSwDRKj9+XDhMAKueO7DeJ8qwU9IWb15N1PTH4L01BZkOmcbM0kuRTFkDpTXh0zG4M/z0+8z9H0FFE9CiG39eLQ7lwhEsmWmAhD3PtqaA8HnmvGlp7QjxqfhMueZf87LhGwZeLR7X2tMCEapJDx/Hmr+khpvX0fiKI+mOlb76TYid2zp2dKbuXAdHh+WRe/ngUEY/DBdACH/TnA9hddcyyq8xj48qnSRyIYPpku1CQeoW0zzXAUUtdUktUsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOVtMA4+M7dx+AvA88YV+AC36X0Dsw6CQ59VORxXqjw=;
 b=jfknUek9GoRmIbfkD0naq4YvOJEzz5dNQg0X8tQdEPnTp2whvP8pD0hRu2pgyYcStrVH5WsAEl1+iYTZaNU7Nws6fCjOYf8ghVjjblT5FWwJJeWAIFF/SdXTrrRtvehl7i0ziWpZrtDJxvW1FJwmmnmBDeOluJE31qWzEfB3kf4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 03:49:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::549d:6717:5787:f21a]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::549d:6717:5787:f21a%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 03:49:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Thread-Topic: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Thread-Index: AQHYgTBYF4SMFbd1WE2EPGRUXu8aUq1RZW0g
Date: Thu, 16 Jun 2022 03:49:48 +0000
Message-ID: <BN9PR12MB5257AE3268E3C404A62FD923FCAC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220616032222.9207-1-Stanley.Yang@amd.com>
In-Reply-To: <20220616032222.9207-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8ebd7c7-4daa-4058-a6b0-a30c486c8183;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-16T03:48:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb48eb83-49c4-4d11-4708-08da4f4b429e
x-ms-traffictypediagnostic: MW4PR12MB5665:EE_
x-microsoft-antispam-prvs: <MW4PR12MB56656348196A388EF88FE8F5FCAC9@MW4PR12MB5665.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WcMJs3VaDhVk55Lj+b0xxZkHmHb8+9gPyWPI/FU1nIXbJQL8/5WjTG2PsFx4WTBLqGUkCoUazi4QgOIK7EdS8MwO62INWmY9ncQTH9QbOAQn2zZu2UG/360uY52ySsjx/wInp2YeULyhfVuvb0/JDWiuqLSpyXkXSxxFhLTZa/v5+HPF8GQfp6MFr1ENERyUvkG+1rY415qngvk2l7HBNsbxo2e9Kh0fG9hm1u/sUfdOfwIMeED6eyVW3NpAALZZFe1aiFY9AahA9BvTDt4arflVcKP6Yt6yfy+KPEGMRaCdRk37PsPNA/g4lZaIyLCCOAgpnOczegDAb35O14SpqvU+UFj4QNr6yQBGMJlIKtNJ/12orlCKHsRrpH+9T+nNl8BJzt4HleC+oYWYykjOkRyV+ZC9a9v7lWa61l2mCEEs5qSOOEOukwbNQgeIicfRkDV7h3k3igXSX6kfgz9z6RbuN32yZ/8tnmEq1UeWvZbrHf08D8761Y7rUQCn5yKpdLcyAp4oHnABB5sZiQbaNRDX6kab+G06SCCZqmsGeOrTBrQAhxR3zySrqL8aLOriI+B/BY40kTQWTA7RKyOLz34tLKPRKSmyo42mDMlLqqfgWX6sLEJhl9fGfxLEdFnt9awVdtiqAj8adQFEdHt8KeirXplygpbCjgtS6KQgzhPFmqjhi7Y+tOZD7f13lQUKaXqx3rRwumSHzFUHpirVfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66476007)(71200400001)(64756008)(66446008)(33656002)(66556008)(508600001)(86362001)(38100700002)(6506007)(7696005)(26005)(53546011)(9686003)(110136005)(8676002)(316002)(66946007)(76116006)(6636002)(186003)(52536014)(4326008)(2906002)(55016003)(5660300002)(8936002)(122000001)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pAcIYTLUhvte1evbA0BauT7D6eL5qtLDuGlMUXyQnb+53lGHt/k3FbsC+gxX?=
 =?us-ascii?Q?7MtwZABEsllq3QK3xHMjeaCqSKXYiOJ2TQgr9TYUGuiD4N/QI3WViYnQJZoP?=
 =?us-ascii?Q?Z0bSxSzfibvpCeFX05pHxwZRJr3tOwusx0b+m4uUsDCkjxHfzjT7K/eH64Sb?=
 =?us-ascii?Q?kdCz8MIS9vKtYkiqTu/SZYoXz+gcnrTfD52jofUiDVjsJAyU+Rzv73mWBgBp?=
 =?us-ascii?Q?Boxs/nyw2+Xf9FNIpD/qD+4Xa4lTqM0qidJW/5gg4QOHJAYPUd8i2EoGYNmY?=
 =?us-ascii?Q?e+CGNZLhaC9r0AFyL3xSUyXJ/6HAUt0janJvl0sWiDyXXQWvYciUL9jlaRrW?=
 =?us-ascii?Q?Tbctv2QEGA1hNAnrIejZLemjogfQ9dk9e1sHq971YuFt95W+CQN+8P4J96Kp?=
 =?us-ascii?Q?6WrSRoGxbfljF3KeJwQUbIDjIsmW8XVMEDqtb4eG0kCwaSim2ONAQKtoGQsr?=
 =?us-ascii?Q?Tswy9fVTHL8tu4tKuIrU5OEl//RoQSOsq21QP7xLaqIKwDgYAYaCRCy05SSL?=
 =?us-ascii?Q?wKsbqBdySEWUTsOo6xbtLi3SmaVIeqwublaWz0DLXl/Va5eSs7Be/IFqaQr4?=
 =?us-ascii?Q?O8KmQ4uW3Zj1oviDEq/3OJN5a2q1zeUZR9n+LlRtY3eFzwjogjAGKx2stafK?=
 =?us-ascii?Q?PYJVoP1DXOdsFYIV23Y50R3GO+6TQOb9P1Qfyuj87EZT/JUk2v6aklaaIeFt?=
 =?us-ascii?Q?KgvKIiror1XqEGLIMPyU+MfwU+4FxWbSnzlMS45U4qphPeplcQltKpkoEvrX?=
 =?us-ascii?Q?225IYcKmtA7JuHADqgaXzim2IZNjQJUkWLEVeLGdBPQk8ccG8cf/gobZGfK4?=
 =?us-ascii?Q?FxJnnRXASEjSv8PuIfHTti5ae0KQBNichNS6pSgRcSRgfz0EujF/bfBXLKa+?=
 =?us-ascii?Q?e76Ln7w7ejNOsG2svbcAEfLtBFCaBAQFiYtUW7mAQC6YciYiwC3/wCabCrAa?=
 =?us-ascii?Q?nNyWdhK+yfhFmsU+H5ZgWvLuukylles5hRIpmffswnUOPC8/TqeCWMOyFoWo?=
 =?us-ascii?Q?6tZlZ0BtvEpUH+Bnh6x7KkxXTOLgZJ+cIHStBe39iI/QedPHADn6FLEqboIg?=
 =?us-ascii?Q?JNFL6bnpjIhdPE2qHaD3xNseeafJK145qU9s9IcYehpT9PfVaceL1p3Pmw+u?=
 =?us-ascii?Q?4+ojSN6UwRyx66KALJzsR2fcME1feQ2GL0cPjhrig7g0BxKr5b3s8+/36/AT?=
 =?us-ascii?Q?pOlZmw/8zFwrfdN8wo2PBFeULqvBF1yEhYb+nYeOPr0rzjXeihf264I937ZW?=
 =?us-ascii?Q?kh2tiNxv10uL9w1mOr+LrHbWj0JX362FUQXjBnLfoTFUv1y4gQRzeawJtiKe?=
 =?us-ascii?Q?aT0P2NBxwHA5Pm6BRYUpzlWsvGO4en1B31Sy8Puv2mDdKi7rSZv+Zqgp/gTO?=
 =?us-ascii?Q?Ii7ML10rVNaeNg0LLJMdtXZ/JJ/dvpxhS31Aw7cUXmuJCwu+S4M2kYADDqFP?=
 =?us-ascii?Q?rMbMMtJA0JJyz0q+y0l8MxBl41wAmSqN2PDdyMOeWNSq9lAdikY8rA3YlGd6?=
 =?us-ascii?Q?6c7cpHuXX8E3ROjpfY+df/GDg+olmsoFlANlCof5B2tX+d7cHGN5MBYLGO2o?=
 =?us-ascii?Q?DLVCejmHduY5J/fVMzoLClIRWp1dCevhCKDKnvUalv7MWoN4MqsrPlP2cQFb?=
 =?us-ascii?Q?6EsAcouhUmD1g4otV8b9QzDtPrMT0xfVihBvoGGYMbmON1JG/B7nenVyR0xi?=
 =?us-ascii?Q?hStI4foVY3Cke/vzJCJ9VH/O6/pa1vWdm2skJlSHh5CYq1J+P/EvxEEC8M2i?=
 =?us-ascii?Q?sfYoJJhnTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb48eb83-49c4-4d11-4708-08da4f4b429e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 03:49:48.4845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ox0IGMr0zM/k/zuEekAfDfNKd6euqBV/xV1HHBpfkJbV84XIKwpFZVniGQhdTkgqyqITbYdRK4A3oZkMnD7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

For the structure itself, the change is okay to me. But you'll have to appl=
y pmfw version check in the implementation to make data matches with fw str=
ucture

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Thursday, June 16, 2022 11:22
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Quan, Eva=
n <Evan.Quan@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct

The EccInfo_t struct in driver_if.h is as below in official release verion =
68.55.0  typedef struct {
   uint64_t mca_umc_status;
   uint64_t mca_umc_addr;

   uint16_t ce_count_lo_chip;
   uint16_t ce_count_hi_chip;

   uint32_t eccPadding;

   uint64_t mca_ceumc_addr;
 } EccInfo_t;
It's different from the debug version druing develop print correctable erro=
r address, so adjust EccInfo_t struct.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldeb=
aran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran=
.h
index 6f92038470ec..7a6075daa7b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran
+++ .h
@@ -521,12 +521,13 @@ typedef struct {
 typedef struct {
        uint64_t mca_umc_status;
        uint64_t mca_umc_addr;
-       uint64_t mca_ceumc_addr;

        uint16_t ce_count_lo_chip;
        uint16_t ce_count_hi_chip;

        uint32_t eccPadding;
+
+       uint64_t mca_ceumc_addr;
 } EccInfo_V2_t;

 typedef struct {
--
2.17.1

