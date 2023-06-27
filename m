Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D986DEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 05:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE51510E28B;
	Tue, 27 Jun 2023 05:31:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6811810E28B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 05:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShCkJ0DUFS/marewQpF+x4B87aWjYQzgtjdOoIkZ4aM4JieSB6k18GNGfMYUvNo+B4aV5M6au4PPOifZFzLp78fbaqdCLQJELzswUW4qKemozcQVlMuEXHBSQz7fZ7rdVs/3zgG8yrBb9P0/luhxUhEoyhnc70dZM4wc5jiaGAZInd0sUtDujwRlUY2zUYN5k5wo2Z8M6EBe7zXtrYarVdZAXBkQs00RbiTvwKoU02lmS65DubFGqVG5THBPPplKUMrwuCNqMNwmt0cVMVt0A+eLBq5DDDsiGZl2aZHoAaw2PlILQSypg4m32fKVEOKBYeFYuh6FOHXLuCjYu8dQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAyC5cOBjd/ZTuHzXDMig/SnnSSn8a+KmZoKDNqG+gM=;
 b=UV2mp3+K4caFvosY61zqBcbIzFnMBqEwMLLAioAGmff1Vpsae+Y7Om6ifE62/PV4f26J7wYpq1nfhKi7rqsoxEd7G+8+kKBrAuEMgKwIxU+h7yUg/xV0MLuzaGpxjqONDdgnovv3+6VHqxWISnjN4j8KkC8zsQjoWaeMSHUk6fOrq1ZND7q6mazkQEtTL4X+QdYIU47AMh2bDj7qT8JwH00ef8viYM4pIjj36YSg1GFUqfm9s7n2erLnPfpughzXSbDNdXytkpbuNW0XAKvPY1thnBMEiJWxN4+4O5ykbbm/+lOnMRCGh2O3Sh/hfGAY3cWStjdl37CxthO26vasLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAyC5cOBjd/ZTuHzXDMig/SnnSSn8a+KmZoKDNqG+gM=;
 b=IO4d1utUePFJvk08kbAoG8zlYw0KSBN++y4o8Nx/RmdH9f9j1T432V6zYhf0h8HINbTUO/o1IHwJ7slrgsydmNkK0CGJAygNKjJ2T2AjoQlOnwW89UJAj/NMKQESEcySI9wzik2Htbb7R47kREHO3h05DPC/D94MOKuHE3Li67U=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 05:31:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 05:31:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Keep non-psp path for partition switch
Thread-Topic: [PATCH] drm/amdgpu: Keep non-psp path for partition switch
Thread-Index: AQHZqLb+1y0trvKnzUKVhyTIaPsVZa+eH7Dg
Date: Tue, 27 Jun 2023 05:31:44 +0000
Message-ID: <BN9PR12MB52577609F6A8735ABB19B51AFC27A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230627051922.2644853-1-lijo.lazar@amd.com>
In-Reply-To: <20230627051922.2644853-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dae1b348-22af-4302-a766-39b3da7c3315;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-27T05:31:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM8PR12MB5496:EE_
x-ms-office365-filtering-correlation-id: 88bed56b-e912-4589-a666-08db76cfcb5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IwK2/qz0lZYKyR8/fUhWRcVWBDmV6u/PnRI9/3HJJTwhK2ioFMM4k0sOZkwbmVbN7+PM+Mr38KYtmiwo7QJweqvdT4wZuNyWbSdoR+EKMv2y+w3+/mwkXgY2m8tlPhSl/UlySEbYjsxGz58m2EJVYbAMR85iCiw5q58wCVLIvVPGNLlGylZkLMQOyomDmcWKUBorObfnXK2QvTSA4kcjYEn6dayab5vP2Xq72vaglo6GfLLOB3GAhgGjEDSsy2YLjmEIJklrbIObhweR6mZdPtFbVcdC5OK1/O+eMp0G0okQ9XuuEAWI0Wza6eXvLL9rRsczO7EPo4gg4x2Vlpp6RygSZE7f+0u5MhxYIxr9nt97OSnOP3yR82FBfJcEvcZHaK7OaYhvK5Lro2837uIuKkVTKxFWyvWs7N9zwfm0bm5UgvTjACr4Fv69h7fUeF+W+yMdWwk7tJ+3hUiz2NVA3mu90eRRSwfDrccsnImmv/ghZiBCcQlXmIq4I8Ew8J8E1e+WXiV7PBfa6ki68dQKrwAIBAHi1YepbGgY9SOP43+TD140Cyptd/JC49CUuTaoFWRqxSbdhdaN2o8BFKxSy5rXf382+9VABQsHoz4oUwJ9zAUNHANLbNKUJh726yc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(66446008)(53546011)(33656002)(52536014)(5660300002)(64756008)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(38100700002)(76116006)(316002)(4326008)(122000001)(55016003)(66946007)(38070700005)(9686003)(26005)(2906002)(478600001)(186003)(6506007)(7696005)(71200400001)(54906003)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kFtPBfmfAgQeqr2wgFVd1mNvsnWh31iiSIIx2upcNCLZD76N0V2VpIeJ6sQ1?=
 =?us-ascii?Q?nUW3O19YXYd+m4sPlNWKr31D/wo/Pns3RirldhFiJk8klrIJpHgPvFpo/nEm?=
 =?us-ascii?Q?0YWacP/iGCRLZMg+CohBM8EF6tMc8czZkPZ3XNK90bl7S2VlHmdNt3yT8Osg?=
 =?us-ascii?Q?zvuDAyq3uB+FnKxtL6kE22Dci95goSEWXm8xXRo2MC9ERNfowNOHrhDzT5YT?=
 =?us-ascii?Q?oLMbQqXpxyacF7AREyifVTyCKCHwZ3wOvFQ/HVlW0itDR5cTGnhOHft1fN2w?=
 =?us-ascii?Q?OxL17dCSHpEDnrrJ6cG1MKSfkhh2IIb1hV0Fv8WEPsMFb494l1YgSTS7qf1M?=
 =?us-ascii?Q?e0Ahs28cfZRZUBMwpri9bGZhwHCxQ5LDrq112O7pUgdGnrhCa02mv6JBZfmZ?=
 =?us-ascii?Q?fMJ6Mb2rJgZs3dfzW7I4r39C8K4ARvlKvocSzU7mUwb2evucNkKaCcRU/3G5?=
 =?us-ascii?Q?IhffZpZ9FzHy0bD0yyW5n4hBgJdvWDCUwmFzKcZ3OrEoru4knyLmMn/sr5g3?=
 =?us-ascii?Q?BtxwAlijhym+BaEWF7jAIxoBk17bo+Dx8nYTwrJZOY7UQrwFAzHM4eCClWrH?=
 =?us-ascii?Q?EDZ6GB4+NKmd0wgdYEzBx2UsNf8p3+EXpR+xnNQkM8lijS+/LUSHKWbBtxJ3?=
 =?us-ascii?Q?hGDHcrlkU0XLU4Nwz06YsiJeDYPKg4mw9ckF3PcsJ64ZvvzJoNTJC+UZwlLW?=
 =?us-ascii?Q?FjsSRUPon2jZS0YDUKhCI9gTGd3tVx8ER5ei5Ic07VNinrn4Xj6zQx5Tr3fM?=
 =?us-ascii?Q?ui9O5Y6SxM0UBlq5ES+nfo0fZYFTm16tDBT2Sj5SC6NBULwn/VM8bwvZ1x+R?=
 =?us-ascii?Q?3w9VLro1Xdx6M6CaSaw+gYibY3PdoFEGC1tw2ptPl07VMwCWJ020ynOz2TlJ?=
 =?us-ascii?Q?SLJMbeKFZEXM6HCIkx8zXvqQvpqvRkU2zxG3OU7Nb5BZrpwh4zmmWQ2Y4sWG?=
 =?us-ascii?Q?I0aCUD5X54d/9E+qLt6LrNPhcDDdZk6hwATR4xbpuKwj/FTRUNkqFMvZyPgu?=
 =?us-ascii?Q?a8BZvpemum7KPDr8EBhv4Zkp6B0v4lvIsEpFUe6WjSMKiPnb7WBXyhd/f/WP?=
 =?us-ascii?Q?dAYXH9JsIj6jWNAkX0cwpOCcYQ+aw0Cghq+sGRFX3vWsZqggGti2+3v0n5bP?=
 =?us-ascii?Q?0uWyqOANaK7CcPIsxlBYzsHdUMpEqlmFnknpbiIMtOz667Y3RBa/UyX6QyuC?=
 =?us-ascii?Q?MYqgDykLmQHwR2q+ty5i5/Hp27i5gAT8FlMyPJYQVgky+Dw53tOIeD3D8sij?=
 =?us-ascii?Q?pJF6vypzD/Hgr34AVTwZnvUuF08h30hCg9wzDiIP+p8/b5ADfIE+9HMGNq0M?=
 =?us-ascii?Q?gO7tinHNhwtBmRyGbYez8P0Jt5G0LFVAqwvguTrtccOl/VVaJJH+tjTSBlVA?=
 =?us-ascii?Q?vNqC7mYG65+bjcuKMKWuHQRfKG+fo+0WNEf1Rm9h55C1+jocM2CpGGf+QM95?=
 =?us-ascii?Q?602vrK7TRosWIjZhaoKPxvcvWwUOOWrukyQnFzXt4OddcKC8/0Q+sr7zLkL3?=
 =?us-ascii?Q?+Y/rGMcjCCM9aMtA6fJFrb8IAXu7PTAqs7VwTNCYJ0FrYtXr5cNxGuSrPDaO?=
 =?us-ascii?Q?PBS3k4O8Bwa9EsOvrKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bed56b-e912-4589-a666-08db76cfcb5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 05:31:44.5019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1qienvRAsSO3vX+O00LUHsGjrdZE4619iXx6/0WugplhYL9NngUJGwn4O8UJSX+CpIe7MZKkplmveuMXnq8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gadre,
 Mangesh" <Mangesh.Gadre@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 27, 2023 13:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Keep non-psp path for partition switch

When PSP block is not present, use direct programming.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Tested-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 76b189bd244a..9e3b835bdbb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,12 +623,28 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu=
_device *adev,  static int gfx_v9_4_3_switch_compute_partition(struct amdgp=
u_device *adev,
                                                int num_xccs_per_xcp)
 {
-       int ret;
-
-       ret =3D psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mas=
k) /
-                                                       num_xccs_per_xcp);
-       if (ret)
-               return ret;
+       int ret, i, num_xcc;
+       u32 tmp =3D 0;
+
+       if (adev->psp.funcs) {
+               ret =3D psp_spatial_partition(&adev->psp,
+                                           NUM_XCC(adev->gfx.xcc_mask) /
+                                                   num_xccs_per_xcp);
+               if (ret)
+                       return ret;
+       } else {
+               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+
+               for (i =3D 0; i < num_xcc; i++) {
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_=
IN_XCP,
+                                           num_xccs_per_xcp);
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_=
XCC_ID,
+                                           i % num_xccs_per_xcp);
+                       WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL=
,
+                                    tmp);
+               }
+               ret =3D 0;
+       }

        adev->gfx.num_xcc_per_xcp =3D num_xccs_per_xcp;

--
2.25.1

