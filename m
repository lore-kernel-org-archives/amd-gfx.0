Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A43C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 13:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E0A10F085;
	Fri, 10 Jun 2022 13:04:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E5510F085
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 13:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFakqf83f2MfKNgcwJTNGwIBraXMMtJYobwL0zimmWYfznyhBkpHRcduhq6qmqXdDvGT225NNxmmrvKl5NADhdoiVc1ZDziQ9TkkLOIPc8yLVbixpi22iisl7i1trRBC3ZmAecxwWxZCRfnmjNByGJp9Q8x6M1fpD+rrcWJ4zkKddwRiTiOESlzdj1pgzAsQToTvEJW3+V2b48c2uMM3njAu2xx6jJzPdNSik/P95OXybFcGvs6L9FRFlUB9gB/bHUz3JuWSTGJF/6kRsLQDxEpYLcEJkTCO9LtIK6sTUWUHVIGP4xfIj39BBxP8Sy2JAYX4NO6GR96eas1FhEs+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HosdO+eoY8UayaLEyAxyUDtdlqE0pxr5X89SkolS3ys=;
 b=aBLZ3qmpH+IAtDr9/57QsSdG/stIIDuY9D8Vrt4tKpPsxql8pYrkp8ZubUZx/tlD/tHKQ2GkSsDsz+p0pU75d9pogeQCilRWF1xYYkdkk/UUK1s3PmTCvPDbZj9u8S9YQMXs/x37xnUFRQL1jCxAWHjHHp28PJFAFn9HWidKcxR6X5t55cb3azyMKopNjy915Ms0bvmVW2BWALEsow0CM3bVxN9MbFicjILMvcUZFAGsrukfwTEEwAEnkAWs2xzk4q20yro7peaGUNpYNeqq/o1FKtS4UOTVG9oJRxQC4PntAO1jRI7QT8mXqZVcsxy7nG4KqLvEXJKvfOK5+1jXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HosdO+eoY8UayaLEyAxyUDtdlqE0pxr5X89SkolS3ys=;
 b=zeIi0lZAjylINQUOkE4fA9RWRkJQhWavTb8RbLoH1G200RvL58muG8rYMul9AVXCWZSCLNnfluDRhc5hDXO6aVB0ryiq4nU04ZA/MiSWCEIT83VnvjHKgAD8lx52Ni301RaTdHHYL45f326N1A+EcDpQdMatOrCBJDGLdBBugeE=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 13:04:15 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94%8]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 13:04:15 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Olsak, Marek"
 <Marek.Olsak@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
Thread-Topic: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
Thread-Index: AQHYfA0MJ4fCQICj3Uahrx68iXKmE61H2p8AgADCTRU=
Date: Fri, 10 Jun 2022 13:04:14 +0000
Message-ID: <CH0PR12MB5284F6875A12FF0CFB0AEC778BA69@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
 <DM5PR12MB24693A6DB8AF22CB79B0477EF1A69@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24693A6DB8AF22CB79B0477EF1A69@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T13:04:15.484Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25669e4d-f0fd-45e3-64cd-08da4ae1b88e
x-ms-traffictypediagnostic: BN6PR12MB1539:EE_
x-microsoft-antispam-prvs: <BN6PR12MB153930E3DECEC83EABAEBDDE8BA69@BN6PR12MB1539.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qvst1BoB2uXajNB4PdL78SE1/WyDI3s9D3+Y4XjpO1cVKeQsCk89/QASL1QuCH1CBKXxE7f5buTewx1b2ljoGKAgtHT88jMWGWedmg7vGdaZy9zDJcW/A3XxBRXAoFWIAuQZtOVDGhTK6Sy+wR9RY8XJXHuRiyctwPnwn2VRjRh94sQpRIdDqkJcIWCttyGZuXcwTr4AWEVXsKKdD45ygvwTsP4eN7GegqCRpSp+6RowJ01oe3pWRptnfi9KezW1selT+cy8QPETcT+qTH/0e+fxzRGnJkL7x0Y9UHDpnShtk3afz2OjHH1qTNuiJ3k0tUyhpimIKC90npI5HOXj7Kt+GxpeAAxqPv1WH1NSNE9Zo6X1oWBBJ0IS4avJOduFsaDmLSe98Bm7OzAmOTccLoTHgT82Uys0wrnvBFegMuW36ZKvGeaktGlJ0K+J0wnpfLhmt0psePq1Zz15KD3n9n4mA6vjtsqOuHNcwT6yDK9cyYVL8ZKjICIOATjURT6czInr8y7rWyTFbEMd2NnBZoA1ZnmuroiozN/2MuBZhR8M58zzZb1hdxrIzWo6mUv185dI0nC71KVkWopfO9mhi8r9+rhf7LUVDehF2+6D2q5cCsaDrOeuLotIdPPxSkhe+C5sAVQL2sCYWoIdyOC9n6xJvrLQbBF9qW/CDGlXFGL4AECwPScKKO3hDO4Fthv3b9bI7lPbMrdl6oMWdU25gg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(83380400001)(53546011)(8936002)(86362001)(6506007)(7696005)(55016003)(52536014)(5660300002)(33656002)(508600001)(122000001)(19627405001)(110136005)(316002)(54906003)(26005)(9686003)(2906002)(186003)(38100700002)(38070700005)(66476007)(8676002)(4326008)(64756008)(66946007)(66556008)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9QODfq48S0vOdggXB7MLnmUFGqimstcKhSB0emMPUPNCaH7oQ1XoPT3WuyG8?=
 =?us-ascii?Q?T5HAXDgmDLAyv2r1dJueqF25Py2an02Z/Lmj/oA7S7lprZbZ5OnWYn05UTyQ?=
 =?us-ascii?Q?JEcH4XEPIRjnSsaZPbFJgoRUg0PJzfAkGwfis8g32269I30IqL9B3qsiWQsN?=
 =?us-ascii?Q?J60W8zD0I1nAOzqy12hHhuWB2Dynj5WPlDIzqNeE6BqQ4ci5AT6kfm5vzioc?=
 =?us-ascii?Q?czvHNvKBLXhrRFLVm2ssFoOE0k8q5iSJ6XDLfv70fiLml4lG9zd2+e47aq3/?=
 =?us-ascii?Q?goYnB6iEq/lZcNQ2C5DW6RNWcM57ecFz5qXENsnMB/iaMM/fZxKMkDCUMV9m?=
 =?us-ascii?Q?XaCzPfMUdNaZBGq5U1IoyCy/YZ9SFseSY4mixcBo9z71sxCnvGl/6TYq639O?=
 =?us-ascii?Q?u+v2L80MMvZnJHd0gXkPbNNpqwJPLjxHU2+vy8Sn3HrQU8gdEabvf2Pzv1dH?=
 =?us-ascii?Q?fjg2hghiumEU7q0KXSon4aUJUQC7R9iVW6vaNho0ucJbSDYXH7I55F11CVFb?=
 =?us-ascii?Q?VS7TcrvD0+7ITbdhxGUc7/nbC2lCr+KafOFelwy0qsOWrEVe8kExizTH1yLb?=
 =?us-ascii?Q?usn6Y7vJSXX5yJLmpIZ8L2yd7rTHV+RoBwpxIrZ4sm9vn/4j+7Ln5G+XMoWl?=
 =?us-ascii?Q?B/lldK9rGdRcvfIla790NrwqbZqdl6ISk+gDjIwxy1dn9T/UxEAe/BJW9+/Q?=
 =?us-ascii?Q?XXdmlLgs4rG/WRnCJRO2G5RbAXczU5L5dInLI5h+jFiOX/E5igpVzTuquJzG?=
 =?us-ascii?Q?ooZk4Vg8SC6BRuBEF59uUm5AGFi949M1V9Oy+1fpCnZXhD1x+FI+mfPnoCnj?=
 =?us-ascii?Q?dxLCoODohQ1RhKcKEL8C0iD6ahVFJRWRx0ZdQexedO/IawhQWLBfKkFiJkz/?=
 =?us-ascii?Q?xIutd7QOFM4nPxNHPxV5cJ0bsFG5dlhzJbq3SVzGKIvCkU31ONohsvrx0cYA?=
 =?us-ascii?Q?Ohtm8txiYYUyVXAmpYRFTKY19BetdUfXqBaC9ukef2SmCxMKc3B4u9hvc22m?=
 =?us-ascii?Q?eEUzzBe4RqJDDnBe6uIxzLfjv3Xeis0hCILcHuniY0U2d8yOc8WItWtmbeTo?=
 =?us-ascii?Q?+JYPXww3r12up4if/dpsO5Q87cLkpf9ivd9C7PA8I1AeEv16HthiZ5eTIPl1?=
 =?us-ascii?Q?9dzX/P174QsEL8SgdBLdJVp72Qr3Q0dzme8fZfxl6nvupXZQbOa/jTLE7dtr?=
 =?us-ascii?Q?Q0KttfGq4rr4u1AhK96fpzP0BkwWC/ffMzVJnzawld5EvZBK3MjZ53pxBGKF?=
 =?us-ascii?Q?vfLeQSKcvQM2pLTYq+ECg4LWF6D85tH/YDDsYxmz8dcJvaDYml/dljGgtGeO?=
 =?us-ascii?Q?r6H0KkNSLFI84IwZ99Xz1KWlr7O7c+rBMtf9bym3llLFPU+6RzXtjcjhgrJp?=
 =?us-ascii?Q?RLQRzdYTGxbGKXbbPpZqXMpmk9Y+QXtcEGED5IJt7UfbfCBfBlDi8DMsPzhG?=
 =?us-ascii?Q?Wgd8GKkfnxwGFwXO7aDJdomKjyvxs0bVdBXpgrb6uZZFRwf1WV5Dg2rd1RXs?=
 =?us-ascii?Q?Jx+8cixrckrpmPpZIb8wQ0qH3NI7elEyxW8qsfzZkAbSPKWCOaFTPsiImuUe?=
 =?us-ascii?Q?rpzzHm+7F7fu3AVChSnZyEkGfFJTBbBO86cqZZpQyr1oWe1B/WqwLZnqTNw3?=
 =?us-ascii?Q?4jDyAcl8RCNPqECfFvz5X5KAlIh/9OQN1NkBxJf3ZVnrviczKR89t+rcjoNB?=
 =?us-ascii?Q?ifoLXTF37msiGQYetQf+F1cklRaw7Vgv0nZpS1J03/pj7TV9?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284F6875A12FF0CFB0AEC778BA69CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25669e4d-f0fd-45e3-64cd-08da4ae1b88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 13:04:14.9941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GykFuKd2TnRM4Pbd//VT+NAADsRnQ5kAcXss52z8PNd40qPm/W6cnbCjrOcpWQaJdsoIlPlEs+rdykyCUWQYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Qiao,
 Ken" <Ken.Qiao@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284F6875A12FF0CFB0AEC778BA69CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Thanks for noticing, will fix it in a separate patch since I already merged=
 this.

--

Regards,
Jay
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, June 9, 2022 9:28 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Olsak, Marek <Marek.Olsak=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siq=
ueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Qiao, Ken <Ken.Qiao@amd.com>;=
 Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/display: ignore modifiers when checking for fo=
rmat support

+                                       return true;
+                                       break;

Possibly a coding style problem, 'break' after 'return' looks redundant.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: Thursday, June 9, 2022 10:27 PM
To: Olsak, Marek <Marek.Olsak@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siq=
ueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Qiao, Ken <Ken.Qiao@amd.com>;=
 Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: ignore modifiers when checking for format=
 support

[Why&How]
There are cases where swizzle modes are set but modifiers arent. For such a=
 userspace, we need not check modifiers while checking compatibilty in the =
drm hook for checking plane format.

Ignore checking modifiers but check the DCN generation for the supported sw=
izzle mode.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2023baf41b7e..1322df491736 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct drm_=
plane *plane,  {
         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
         const struct drm_format_info *info =3D drm_format_info(format);
+       struct hw_asic_id asic_id =3D adev->dm.dc->ctx->asic_id;
         int i;

         enum dm_micro_swizzle microtile =3D modifier_gfx9_swizzle_mode(mod=
ifier) & 3; @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_support=
ed(struct drm_plane *plane,
                 return true;
         }

-       /* Check that the modifier is on the list of the plane's supported =
modifiers. */
-       for (i =3D 0; i < plane->modifier_count; i++) {
-               if (modifier =3D=3D plane->modifiers[i])
+       /* check if swizzle mode is supported by this version of DCN */
+       switch (asic_id.chip_family) {
+               case FAMILY_SI:
+               case FAMILY_CI:
+               case FAMILY_KV:
+               case FAMILY_CZ:
+               case FAMILY_VI:
+                       /* AI and earlier asics does not have modifier supp=
ort */
+                       return false;
+                       break;
+               case FAMILY_AI:
+               case FAMILY_RV:
+               case FAMILY_NV:
+               case FAMILY_VGH:
+               case FAMILY_YELLOW_CARP:
+               case AMDGPU_FAMILY_GC_10_3_6:
+               case AMDGPU_FAMILY_GC_10_3_7:
+                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
+                                       return true;
+                                       break;
+                               default:
+                                       return false;
+                                       break;
+                       }
+                       break;
+               case AMDGPU_FAMILY_GC_11_0_0:
+                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
+                                       return true;
+                                       break;
+                               default:
+                                       return false;
+                                       break;
+                       }
+                       break;
+               default:
+                       ASSERT(0); /* Unknown asic */
                         break;
         }
-       if (i =3D=3D plane->modifier_count)
-               return false;

         /*
          * For D swizzle the canonical modifier depends on the bpp, so che=
ck
--
2.36.1


--_000_CH0PR12MB5284F6875A12FF0CFB0AEC778BA69CH0PR12MB5284namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks for noticing, will fix it in a separate patch since I already merged=
 this.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 9, 2022 9:28 PM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Olsak, Marek=
 &lt;Marek.Olsak@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Cc:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo=
 &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Qiao=
, Ken &lt;Ken.Qiao@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.=
com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wentland,
 Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: ignore modifiers when checking=
 for format support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
<br>
Possibly a coding style problem, 'break' after 'return' looks redundant.<br=
>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Au=
rabindo Pillai<br>
Sent: Thursday, June 9, 2022 10:27 PM<br>
To: Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; amd-gfx@lists.freedesktop.org=
<br>
Cc: Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Ro=
drigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Qiao, Ken &=
lt;Ken.Qiao@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;=
; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wentland, Harry
 &lt;Harry.Wentland@amd.com&gt;<br>
Subject: [PATCH] drm/amd/display: ignore modifiers when checking for format=
 support<br>
<br>
[Why&amp;How]<br>
There are cases where swizzle modes are set but modifiers arent. For such a=
 userspace, we need not check modifiers while checking compatibilty in the =
drm hook for checking plane format.<br>
<br>
Ignore checking modifiers but check the DCN generation for the supported sw=
izzle mode.<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++-=
-<br>
&nbsp;1 file changed, 46 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 2023baf41b7e..1322df491736 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct drm_=
plane *plane,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(plane-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_format_in=
fo *info =3D drm_format_info(format);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hw_asic_id asic_id =3D adev-&g=
t;dm.dc-&gt;ctx-&gt;asic_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dm_micro_swizzle micr=
otile =3D modifier_gfx9_swizzle_mode(modifier) &amp; 3; @@ -4955,13 +4956,5=
3 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check that the modifier is on the =
list of the plane's supported modifiers. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; plane-&gt;modifi=
er_count; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (modifier =3D=3D plane-&gt;modifiers[i])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if swizzle mode is supported=
 by this version of DCN */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_id.chip_family) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_SI:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_CI:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_KV:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_CZ:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_VI:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AI and earlie=
r asics does not have modifier support */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_AI:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_RV:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_NV:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_VGH:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case FAMILY_YELLOW_CARP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_FAMILY_GC_10_3_6:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_FAMILY_GC_10_3_7:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (AMD_FMT_=
MOD_GET(TILE, modifier)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_R_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_D_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_S_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_D:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_FAMILY_GC_11_0_0:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (AMD_FMT_=
MOD_GET(TILE, modifier)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX11_256K_R_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_R_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_D_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_S_X:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FMT_MOD_TILE_GFX9_64K_D:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(0); /* Un=
known asic */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D plane-&gt;modifier_count=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For D swizzle the =
canonical modifier depends on the bpp, so check<br>
--<br>
2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284F6875A12FF0CFB0AEC778BA69CH0PR12MB5284namp_--
