Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C7C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 13:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179CE10E7A1;
	Thu,  9 May 2024 13:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELtHF2lF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE80910E7A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 13:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msO5sMyin6LSBGQzpHXdECb05nDCrC7iCaXyvgAYu0kukUANWCRPw/WohL+c4PMlhpkPu4IfS9iGOrQzkisesq+NpTpKAzOJzJ3kpDh72ab9UUfiR6WFlqdUSfGyy9FFycARDRomm4taY03iC8n1wNkjHVPECyHTkirSlOUmTpswiGqxKY1f0QeCkCg+1nTkFOkhRPdQ9y5klXjZYsaxcrZD4aoR3zGoSJqAGpFe619db89FGtWwqFtqKxKZa49OACsAfmkcycdtcVID7b+DlP5W7noe6D7GODWRJI2kh0YXBz29CdlNI7K63aeXYmg6YoEbZB/gJHlsfxg/irhbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr6MWDThjHFFaYcWuV48KNXzflt8zBr7U4etJ4nqLkc=;
 b=YvYM+LXQUCwyV//npe+ndKn4zC02jB1f/2eCL5NwMNyivwEnzMZuLa+ggIt7ZCvKPqVuCeAm8ivQ2CZ09h4pv/FvaMVnWgPtRttmhy/F8Xic37LCfp5sF31lCufwk+2x4tX308T7cYNX7uHbMtgkEVwM69hakiT7qEqliC5uaH5WTp0x+Uw1Bv8PCc5fB6QtX51dub/HRH+xzy+nmpN3rp0CzQnqZG/9MFGW3LvfdtMBXVEdLfhMxkZUKjyzB9ftAXlasXrXY0QD1LW0AYKHMdwdJAF3zSddxP9lmr7SClenMQciyqw1o/CDgcNzO/WNUVHn9WETplc7ymPeMOvELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr6MWDThjHFFaYcWuV48KNXzflt8zBr7U4etJ4nqLkc=;
 b=ELtHF2lFU68YOmVk7xXDpGvXYOUMWH48+jcmOoQCUa8PRJiMdQ/YcJ2L0k0plashFTzih1vns0eDY8QEnwNlPQ5nobH2lqEhLglsmE+6GaFx53ZrBkAGzbwk8rGD9EdBQs6h2maVFnnZoXcEtPGIxFyu+wrBDKOQk5yd5ouAvrI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 13:01:14 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 13:01:13 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
Thread-Topic: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
Thread-Index: AQHaofSBcv0LtUmTjE+zeFUCqjXDg7GO3UAw
Date: Thu, 9 May 2024 13:01:13 +0000
Message-ID: <PH7PR12MB5997A8C067197492C30A64AC82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240509093705.414124-1-Jun.Ma2@amd.com>
In-Reply-To: <20240509093705.414124-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=654e0aee-cba3-4302-849d-e40556e75c5b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T12:58:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN0PR12MB5908:EE_
x-ms-office365-filtering-correlation-id: eae3b6bb-7e1e-4ca1-b5f8-08dc70281b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?aVoiA2mZ9noQOHd7iFYCfMPXs+pJeG0pazMJl9/69z3PVF6TfzVZN9J1gxYB?=
 =?us-ascii?Q?2+9TD4a9soenOcSW6W8wtgI2nt7YuW/n/XmPM3R5MBWSc7FJKZ39P8/wf/mR?=
 =?us-ascii?Q?uy8Ov94+R1JCiWciWvyce7u3HXKd0260aYpcBQIJYV8murXLucsmdyRTKFpJ?=
 =?us-ascii?Q?W1C43MydkzREEJAWo7y6JBQ7f3ZmknKRbKFtm9VwB07IdSvQiGVoHdZjom1p?=
 =?us-ascii?Q?zoMjfNlK/dR2F0Sf0qXPBR1WLjJMu1EFqluw/vD+gEb9XVnlpllbOR+2qnXH?=
 =?us-ascii?Q?q9uC/IKwmLG7NcxR9JD/XhjPzGsdqQu11GKtz7zdMycv67dVfALBDj8ec/hs?=
 =?us-ascii?Q?tHRhUzpIpV72uDo9udSllblEZ+bfyx5JM+ZvN6lZDs0bQPzh7Tv9k5IxPCiy?=
 =?us-ascii?Q?2D5EqqT7GAIDsvH9f1hkfXbghaLkTDeF2y2oZDFmGVoBFEjmG2Z70LexzqHt?=
 =?us-ascii?Q?KXkNm9YlZHfu65VGiX6hz1CZpg6ryhYDT+rVdlsXSZHz7HXRomtVGvT8TpqO?=
 =?us-ascii?Q?bpJPtrQnWUmKSWxM3AYgZi7fcyzSKu/AXT/sE44mg+CFcHN0g+Fo94Hed+xT?=
 =?us-ascii?Q?KWhpaHgUGZvOy3YWJP9AggZzl2pPIy5xiw7qU/Wj9gd1tsejDNUHWYA2fGgC?=
 =?us-ascii?Q?pFlJBgYWc3LizXeaJxVk2nkSwN2EMIvfYHGgVp0TeBNZOPNvBUEeEX/pgHmG?=
 =?us-ascii?Q?5//yeOnbHPGfqYrVpRyrr4WSemGKxgB7wf2F2A0ZurFfBIbBplNBOM/f4s5C?=
 =?us-ascii?Q?GWjgH3yKr+2DMXbAAea+BbkChc5aNN/siK/UI2e81oE/1tRkJBS3/VwyuHpB?=
 =?us-ascii?Q?9qmVC57OKOu9pxtwxb8rrOqwDzuF8BDw9FwvlOOfOjXgQUJDbi1amRvswgP0?=
 =?us-ascii?Q?rMmhGHVuYiAx8ZIzxtU0tbuyTUg4IB7yr2h/Sqxaz5si/tPDdDvlJ1HaWPwG?=
 =?us-ascii?Q?6Mzln1SPY+deOcqBPdngpnjl60KP/1WzJlkwkrhYHCSzOIkhcncSGN4w6mL+?=
 =?us-ascii?Q?cSVo4/Ovbo4aI+eWr0d95Y/lcSSlfz6+hxa4DDKAowjghbUM867GB75lInJf?=
 =?us-ascii?Q?1+HFMAPAZ95Q5mTu5nwxmxK8P50YGIDxrVrdgBGpLj7QSpe5HnvpgSNq5uub?=
 =?us-ascii?Q?84CAhaiwVKYSLvfW80gepNxC9DCNsE7OQMq85ZTaYvZqUNKk5LJgIwnUxBLq?=
 =?us-ascii?Q?IPcQB6lFPPKvATMPum0xQrAwyDF8qBq9oPNi4shL0z6WWlnm6qJJ+l/Si6H5?=
 =?us-ascii?Q?z227l59gF6ksoPtA1C7UrBNB2RHVZ3LC/9LDGwi2hdzA627pn5zw9i5dEwyN?=
 =?us-ascii?Q?8Bs+IPrSDbVq+xsgJ7OZBQIbzW8L0KYMwlSUrzasHJmUjQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kUQYoznERtgH4Ji4eLlZFKIJoBndrqcwXhhS79VHQHTZI2odXhQWQKe8Lzp?=
 =?us-ascii?Q?VGaUHbvnEyTxfP5fTJUSb0Vta0WBn1q8LIBe82Laorb5AtLXxvf7HAoHjynG?=
 =?us-ascii?Q?4bwWzcwv/+py0w/L4tGrKXyrQ1PNXHOyDTbkzoSn+5vyTLjrHCriU/ocMKSu?=
 =?us-ascii?Q?aN/Amk7D9U6HpoudoK4/n7vG3GQNM8wylatrw27LTx7el9pnzPtjhtH05QYY?=
 =?us-ascii?Q?koT1VddjWHjJMZeWpbcJ4aZNtS1x6wHfokebXdKufX3sOA4M0vhtQXB/K+Z8?=
 =?us-ascii?Q?eMD34iifNUfwvXTihUgJvcoMWZmnLyF6pENEu+NjzRiEFl4oY91oAwFObqnK?=
 =?us-ascii?Q?dYh1x+1yXd0DjwT/V85BqBlhAZUqjpN73mjc2GhBanK9c1ZhWKYvW0PZ45hO?=
 =?us-ascii?Q?zFgQ7sSooLRW7tgBVXwKG+mywv0YwO5bSWlRcP0fZDBqmnRN/3A3f+cPiRqj?=
 =?us-ascii?Q?5idvLBHeQ5iuX082QsZIjEpTxZQ7FUx8OvuzYbhl9ATBTIonj0uCUrnm+Jsc?=
 =?us-ascii?Q?dY9yGHK9enJzh9I0gCrLQVwJYfeEb+mLUfmZf+C0X3zrhgO8hJZL2O91ZcuO?=
 =?us-ascii?Q?2NAzcdiZgRhohxV68rjSbGFVr2OHfPl3EUS4ttXb2S+OP5SeyFJDjxxOCd8k?=
 =?us-ascii?Q?0DobxRypxd8MnVp/HJSFNhknGQ/x2AmcsXCXJHVU2zbeKt1w3mSmpSK7WJZj?=
 =?us-ascii?Q?2AKlkyp53CUe2G0gsiO5x4QxKRwgrrut2ECWZmgZq2dXl5onDehC9sTjkgkU?=
 =?us-ascii?Q?VAwB4btOhjqzwjj+8fOT3nWtx3vUK0arunsP8F9BdEkt9ZE8RqpjKgH11V6S?=
 =?us-ascii?Q?/2P+wJ7/TBWrKhFHR0zjyMdjqx6CSpdQwolvMAkVh7zRbKAMfJQaxXxBs7op?=
 =?us-ascii?Q?BlJUAFysQgFcVYb9DL9DvwnL4c5h/t0kZ7XwrL9LfUaoEkOpECfvFFYveUlI?=
 =?us-ascii?Q?yBU3VO/PC+2LqDhIWqbmo7ZMXugac912j0H7277GdC69BBsuTMWkbHgFUu2o?=
 =?us-ascii?Q?q523OsvCS0PnSFKHZil4J6twa47oHoVdy8HbRFwFWq33p6iUMQrsAqHEUV5m?=
 =?us-ascii?Q?ouYbUIrNN/PkfQzisHIAUumVi9tt1H2nKLvE2e9H5dEUTRnwLxNchElB134P?=
 =?us-ascii?Q?jxUi4MIwkBCHfptFncTvr0a8SKFEu0wWdkY/lJpoc7GL0mf2H73DNDaaFCqK?=
 =?us-ascii?Q?EvECV9tliUnVoCQnFGMIs5T/TPDfFqnnzXnJSjG1lKy8NyXeMUOBrPnIIS3V?=
 =?us-ascii?Q?HZY6VZql4dFPLOgFpbHG8KBQqTCwzEH8jw92dXVDVxMQLZR2lsPmzWU9lXen?=
 =?us-ascii?Q?Kwp800l5o56UYsZdm2M8E/h/vqgLNNZFTBICegHfThvnlXXuD35yzgXKrywW?=
 =?us-ascii?Q?YNv2dL++JDUCxqdwOqOsf9PaozhmiC8yH39v77otV3i7pEe1VT8jaYrL3yK0?=
 =?us-ascii?Q?kh25FWxwmyjNDTUxQK31G2S3ZEUnGzj235c//CptjhNUqRTyyjJbqNcZ1Cmo?=
 =?us-ascii?Q?chNApEqZQrBiCYZTvLMoKU6EVxC9ytYVHPhq9QoD+D3NKuvn6dnR4G951rTO?=
 =?us-ascii?Q?iNkrNWwxbgOXoscL0B8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3b6bb-7e1e-4ca1-b5f8-08dc70281b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 13:01:13.8723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1T9qVnROPuwHqBY3weoX57xGw8H4FfbiMxMV7t4WFD6soVzEWwOJjA1jLTnEogji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

please fix similar issues in other xxx_ppt.c file together? e. g: navi10_pp=
t.c, etc

Best Regards,
Kevin
-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, May 9, 2024 5:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile set=
ting on smu13 and smu14

Check the input value for CUSTOM profile mode setting on smu13 and smu14. O=
therwise it may cause out-of-bouds read error.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++  drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++  drivers/gpu/drm/amd/pm=
/swsmu/smu14/smu_v14_0_2_ppt.c | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e8b01662e164..6c24e2306383 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2495,6 +2495,9 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
        }

        if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+               if (size !=3D 9)
+                       return -EINVAL;
+
                ret =3D smu_cmn_update_table(smu,
                                           SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
                                           WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -2526,6 +2529,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
                        activity_monitor->Fclk_PD_Data_error_coeff =3D inpu=
t[7];
                        activity_monitor->Fclk_PD_Data_error_rate_coeff =3D=
 input[8];
                        break;
+               default:
+                       return -EINVAL;
                }

                ret =3D smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e996a0a4d33e..4f98869e0284 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2450,6 +2450,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct =
smu_context *smu, long *inp
        }

        if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+               if (size !=3D 8)
+                       return -EINVAL;

                ret =3D smu_cmn_update_table(smu,
                                       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT, @@ -2478,6 +2480,8 @@ static int smu_v13_0_7_set_p=
ower_profile_mode(struct smu_context *smu, long *inp
                        activity_monitor->Fclk_MinActiveFreq =3D input[6];
                        activity_monitor->Fclk_BoosterFreq =3D input[7];
                        break;
+               default:
+                       return -EINVAL;
                }

                ret =3D smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0d5ad531c764..3f040a4d374e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1418,6 +1418,9 @@ static int smu_v14_0_2_set_power_profile_mode(struct =
smu_context *smu,
        }

        if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+               if (size !=3D 9)
+                       return -EINVAL;
+
                ret =3D smu_cmn_update_table(smu,
                                           SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
                                           WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1449,6 +1452,8 @@ static int smu_v14_0_2_set_power_profile_mode(struct =
smu_context *smu,
                        activity_monitor->Fclk_PD_Data_error_coeff =3D inpu=
t[7];
                        activity_monitor->Fclk_PD_Data_error_rate_coeff =3D=
 input[8];
                        break;
+               default:
+                       return -EINVAL;
                }

                ret =3D smu_cmn_update_table(smu,
--
2.34.1

