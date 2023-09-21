Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB412CD493B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 01:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577C010E495;
	Thu, 21 Sep 2023 01:39:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9991F10E495
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 01:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB8cA1d8/GsNee7oYrKkDpNX0TEcneemhtONcTbu+Y5gOg4N36s0rBUHCa+EOHWiQgAvs8dKGas+OX5mEFPG8DDCXBiy7mtFeobUUJXZWVIuOA4dBALkzgCAzngt0yk8uTvfJl3OZ+WUvWMPVkuFLe4R76GGsSn45ZQ2EEPgTLUmb/eUc4nnr7zWAQpRzDfHY+2lpZrb2wqdK/QN7eh8OHY22cBE6jsMm4pg5uUJImshd4yyz+bqlxhIGuCW5PYJIu4z7ZHCceYE+B3Nx2e0OmKNP8qCZw96cKDT54r9C61ozx07vk5odUTWPO1NDLwbDgcJ25ERyDrGNzNREg0Ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uiB4t21D+ChyPYnfupBgpTZWJv0DRQ1An9SrO+U3zg=;
 b=WJ4tNI46WNJt37SQRF2IRKISpr36z4RGjKy/ZBL1gEssuzbP9Fw/NiyCQcg3oC6yAWlVb7Xs/SwxBtlpwHUquAs6dhEjXP8iU53sa9W6D9D3DxL0j/sKiM4YD95nGmh0G7bpa4on7YXuNoVZLVWXrH41tMXn0wyNN/ICDFNe96khszfTB333HoA314lStAcfwT4z+oxewhnc4s2yDc2/KgOXnS/hGkuh51QgoEGBQxZbvR29+qgaw7zecEGWUlLtm/PMh+wlZo/PQ164RnCA7QZllrLCBz1S6vuhA3HR+jtIMbJDvj2akaCFlPJ0ep6UqQuzh6lwhE014n9egOtzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uiB4t21D+ChyPYnfupBgpTZWJv0DRQ1An9SrO+U3zg=;
 b=k09wfzF4DpBloZrJeOHk/NiXCDM0X5T2d8VJ+my9pvxDujb6fezJ8bI6fPWn+geU+KalNUJRzWcntQ5J+M4ZHncjbzbbXWy7vBzhlPMmpP540/aibJG3BNLdyqmYiB+X4BTUDckwGYg3PPbxNHXstwnNtdpArlrfVRrrviAbHlc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 01:39:51 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6768.029; Thu, 21 Sep 2023
 01:39:50 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Thread-Topic: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Thread-Index: AQHZ6+wnPYHtf28TEkiAf+ygDKqb1rAkgPig
Date: Thu, 21 Sep 2023 01:39:50 +0000
Message-ID: <PH7PR12MB5997A9BCE1A370C007A37A9382F8A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230920175823.3099627-1-alexander.deucher@amd.com>
 <20230920175823.3099627-3-alexander.deucher@amd.com>
In-Reply-To: <20230920175823.3099627-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b3efb106-fc11-43a1-a71e-e05ab6652e72;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T01:39:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: 675a5c94-3be0-4a28-2bd6-08dbba43a564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sv1jGITkQ1EiQEgSrwOBRrYX0NZ+VvD7ybdsnBYcoR2qptOGj+9XPNsenxFWwvbLuq3T3cQDP0ymwh5GGbRBJdZlte7Xhl7ReicGikQBdTVe86FHYCkKlCUZXpTmOIjENeQ1x6in9nqlmP31KY62gaxbsUqjOyz3wPGZ6mFQeeBhQvFbJtdVgeRgndjFLjI7lgoaJPdb+3qdDqnyAbUyy1GhhvJB7ucRX56aHHZ23y+jIdkTAe/TCukj6PNK0GaYMpUMnid8ocfzE3FiWA2g/N2IfMqB98fmOlm6Pchqw94RJYJ7ycfSJvevmC7XDnS5kzunpntQKG7GG5i7f+jG69G92UfR6d+MauAiOpFEShquTmdpqx7gsv9vPVOXN8pn2ywFcM7niZ4Is2GGY/qJhL3rEOhXM7C5UE4v1fatJgGO8QpDJt8U0/KJJeqcYhOLsryKYncA+jBs3mTTmdz7sHdZP/l9+2aZ+C8lWxGa6pgLqBRJ786Q/qu5yUKgEbNva2wzllz/Rwh1rlCYLBl1h5q8jYg/wmPdbN7bRUAKBgLzdQheDeHs/PjYoWUuiwXXJEmx0kOipLvnGNsIi5uyMd2dtRnzV3uPYfHUGDMZmjh/SPOKFG/0h9UJiXiiTLCz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(26005)(52536014)(8676002)(8936002)(122000001)(4326008)(83380400001)(33656002)(2906002)(64756008)(55016003)(86362001)(6506007)(53546011)(7696005)(5660300002)(71200400001)(76116006)(66946007)(478600001)(110136005)(66446008)(41300700001)(9686003)(66556008)(66476007)(38100700002)(316002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkjgRLfh/SNscWimESVl8D1fZtZN34oQ9kPhkdnvEBEmBI2wMcrtcPtMaeDu?=
 =?us-ascii?Q?wa78zzk9vm4E9iSmxGJozsjOlrDuOybD7Eyjh/iRCxcKIwd+I7gUhrUffgNm?=
 =?us-ascii?Q?MUbMPc9rsGL02kRGbBF5VCc6DNit8H5bZPmMJ+R3Vixi1mMNnQtJJfnGDIg5?=
 =?us-ascii?Q?ucRnBTrWYkTngL1hyaxAdtLsRaCaEIxr//tCUoBozKYfL8lNGMygAROKcHyD?=
 =?us-ascii?Q?rMXr6Nc/bQVU6tAvK7pIxXgAuw79LEZb3BnBwooDDfPhCnvOlXLtvjXaZefH?=
 =?us-ascii?Q?Ca4nstkamnmIuHGWY8P1q/GU6dj9saW/feYsjJhAPJobfWpxobnKE9v3iCdp?=
 =?us-ascii?Q?AuIAYuC5YXQ+QdTjZVgZWUg/xW1zInyOy5e2HDv7/LxWXxTOfj1ZekubdpWm?=
 =?us-ascii?Q?dC3Z9hYyo+4zJGxKNXXSWTx1M9C89ycEFeTUE8xgW1+kEgbQqFgFV9bemclJ?=
 =?us-ascii?Q?mMzy6PnNS+r34m3ME+Whd76oKlJZoRM1+Sca5JXSNsw3m1JJpbyqTnqCY5SY?=
 =?us-ascii?Q?HrCTi1F9dut8DJjqLHCi8LwNrYe5kdEFrKwmtOfPzS4MGImaAFkq5FFRedrF?=
 =?us-ascii?Q?Pe4F9tA9nA/rIfgKDJWBTbQ5si7HX2SHvqlBOWdjc8dzOr7aKA1oQJrBGexc?=
 =?us-ascii?Q?AATbeF2obmLHlA4dpalJ0Y0CAQEZruWtRwu7cN8N6NXDH/bP2f2GdErczlJ0?=
 =?us-ascii?Q?cDbY3o+4apH6wsd8CYrmfB7440q0/c80JkJBYJ3B5Mue74nzxapteGK7zw2f?=
 =?us-ascii?Q?/GyOrPSfEVZunU2Bibh58OT6TTl6l6QLPFVIiO8DMixKpom/aNG89RiznmWf?=
 =?us-ascii?Q?JDOfbx9r8haUdZr1anKNYZ8l5U5R8bsuvh/boRLZD2yYZlOIrO9jvBL7hBnu?=
 =?us-ascii?Q?07B572bBP0Cp2nkaeelhFG18/jX7g3daJbu7xL43aXIdVxzTpHw4Wm8SALSh?=
 =?us-ascii?Q?AQuXY+6AYb+utRz4fKcrW1NQEbq6V5FRcsF4ubP0inAJmQ1UG87BN8dxs5rE?=
 =?us-ascii?Q?NRbZFoaD2fhiaWIqsywhJU+g9j9xDI4RHuyTQojiCl8jN7hKY2isFLJKvjiH?=
 =?us-ascii?Q?gY8G1jhAik7PXvm/VcnCI3OnoXNNdjLD2SrURCNe98fUiDTWidkgnorgc5Kr?=
 =?us-ascii?Q?LxNGYxdXKrrPdOescJHcXmHg0avt9BUtr2nsYC5w7+ktha/qicnTi1MFVN0g?=
 =?us-ascii?Q?AHuc+Koy+T1rIDmLkHbTvHzprHOSTjtFQdctHp/IpAzmYqLLsyJ3/liCjmxO?=
 =?us-ascii?Q?DRbJDx1IrYdGgP+gs/YRIrLzDP2t8Wkg1euyXkRzQdoBBmGRiasAVil6yoap?=
 =?us-ascii?Q?GX3JDE43PJ1nV7JbbUbhPppltObGHzCQJpGZKbX5jNOLF8UBrjs6wZTUpoXB?=
 =?us-ascii?Q?vTuX1FSbJW158gSkw0GOqeUnpUvKlcyNKcTpHhcxWF/bA/SzyUidZa8YNQYi?=
 =?us-ascii?Q?146d2co+dTAFVCEy7GvMX3OyKyr4BRoiHQLgvkK10UbHv2Ay39na5UWt7amY?=
 =?us-ascii?Q?7XPvUd3jHdMuHHKU62pKAZ61NskeiCEhD0uIoh5TojmPpjrOFfGDpQTeAXnF?=
 =?us-ascii?Q?og+r0xR3VSB2TSAXHPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675a5c94-3be0-4a28-2bd6-08dbba43a564
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 01:39:50.2992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L6Mls+/k7+H1HoS8uhfvbOJxccmVfUkm1qQfDk3gJYAUpC9BdAwqatMFUMmZ6sh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, September 21, 2023 1:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call
v4: revert back to the original model

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 28dc08fe542b..9de5659ecfba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -741,7 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev=
)
        else
                adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev) ||
+           (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 5, 0))=
)
                adev->gmc.disable_agp =3D true;
        gmc_v11_0_vram_gtt_location(adev, &adev->gmc);

--
2.41.0

