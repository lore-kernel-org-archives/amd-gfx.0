Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321FCC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 16:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DDC10E9A6;
	Fri,  9 Aug 2024 16:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mWagwA/9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E3910E9A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Vgr962D2JAcjfdJDaTBGmwnQuOCspfoX0N/IFQYlolW+IYwDMFugOR84IdJDaHwR7vPcGneWRmsQs8Rlv5GFIYnLj1I0wkQCjE9Fvi/VAJZTJfG/DiTstF5h4rCUXLLWoOZdj0nv5sBBayBqSq8l4POL8/EoXk/VYUouLEGUduMoO2twjjuSqVTmenJmpR62j9uC3OvIIP8E1V/HmwKkquhWW+zhjMWvp69wGMpthvHGlUWbmj5FNFoUYrJN8H5HdeTedR2y6PdbGyuL+MqRZWkmuLnSx/6zAaEeTOJBtqGm5dfeThpNLvMCmeesDTKY7gvTXhw23GxZKfct2W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwWpQuu3u14fE3MN9h04mpXQtMCBzA2GmRyMQwm6kEM=;
 b=WNBE5yU67sIgzyba9z0DrDd1PqFLQMsqgmjOo9gyifqaQRKsgKdjDTmcd8wAmyq6078abQ208MvM2APCRMskcU0Z9lJBD4Dcc/Afp8UsfbQRK64+Tw6ea3/73Sw0wzrt4ciqb9LAV8x32lXAaTVu3UhZbtHwibm3Wr9FEY0Q7alWYYEBM2gX/8B/gUctcwPx9MpWcMfsFZtO9VMkgGUvP9rJzn5fwH/bcpezlZnzMOi16lMIvOdMpIni9zTZNeVEMeRZjpBfOHafc758VAAriUdagDWGcKn+M/lVbB35UPGTATLLmIm8YezAtLcGJDHWn6dOcJfJeDmwsHLKYUbMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwWpQuu3u14fE3MN9h04mpXQtMCBzA2GmRyMQwm6kEM=;
 b=mWagwA/9CHOCWjVXTNtFFcJVe6vwXePNX/cKzk/PsEcnKgIl+IZI1+fY7E4kfNsyqkazqF3yDuPjz80wM9alyVClsHJaXdWJWn/kz1JF3apyVuvB7dErOrYTFlTO49AkvSLpiQYlSR30Z3ajusx6KoxMcjFLMjPDPggSMyGcIug=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.15; Fri, 9 Aug 2024 16:58:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 16:58:12 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix partition query when setting up
 recommended sdma engines
Thread-Topic: [PATCH] drm/amdkfd: fix partition query when setting up
 recommended sdma engines
Thread-Index: AQHa6a1Cwo1rj5HLCkOsIc97BMdhoLIfJwcA
Date: Fri, 9 Aug 2024 16:58:12 +0000
Message-ID: <DS0PR12MB7804A37B9FD6C4F6CE3EF02F97BA2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240808160839.1886946-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240808160839.1886946-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7fcc9c31-1192-4b8b-8796-6ecd30f9976c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-09T16:57:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY8PR12MB7514:EE_
x-ms-office365-filtering-correlation-id: 92d1a7c4-2a65-4770-d8de-08dcb894747f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pa3UJMbUpE/IBkU4NkYj0lu3XR3jofwWWxnI1QsfbEDNvz5YsqjzVU4y/OST?=
 =?us-ascii?Q?nclm8kRglCQVEXuQZ3o36Td5mJ9t00DQ2l4YJEYg4Oi4OW1IcA69m2LCCaep?=
 =?us-ascii?Q?nU4pdhIpearBoW7I8BjVrwioCoVkQbfygMs52ZxU9j1IIQCH1MjYnUbSnmTM?=
 =?us-ascii?Q?/h1QtLEzyZgmKSmwgLMdpKXZ0KCBaa5kksB55wl5X9EdwEQOUymlGp/ZuWKW?=
 =?us-ascii?Q?bWuXYPSdC542NaOhUjreWV9LPMVOrVwNhg8AzfJ36QiNYmd/u1uXLGKl77mV?=
 =?us-ascii?Q?byB+IOgQujLV06HO5JAo1AbOHM0bp7rd1PAmobObZdPG2gw/26Q68XGdMbc6?=
 =?us-ascii?Q?ZRkJ8vO1fM5RU5XhkzFt0V0ZmQX9+cxyYziuHEfpket10QNiNjFsvBWCKjWi?=
 =?us-ascii?Q?yKXlYXrPzw1PS9kLrGEXHgfZ0r6v+GydLlFBej1VceBejL8xa0PAGaoIXlwb?=
 =?us-ascii?Q?4OPFZAesQV7eTKkzkHhzUMF5kzKVKvp9CvBqb/D5CpGiKmDQxJTmpUiATdJT?=
 =?us-ascii?Q?sC8KwFk/8GWBr3TfzmOdd8ngC6RJ15DKHJ1xuavqD8PZyzilO3/8+/WooROq?=
 =?us-ascii?Q?imDZGyeEebmfuibkRO3apfILVsmac8181lvT4WJtaoAInf/AMc8qHl3t+x3r?=
 =?us-ascii?Q?gSLocNcvWGU8Z4Y+q73SsKm/x03g62ZR3PvBB5YGSgHWFyH7+FetJGLrB+Aj?=
 =?us-ascii?Q?TzLrY9jA0Y20SyZSUh0ozCgZAwb78b2cv0wovCF9MsOKEYcHA8W3HVbipKry?=
 =?us-ascii?Q?W/6eQrUdrshfGw/MmatK2ULDF+2wwZYM4cRHmkHBrAzZTuzrdDo/KJ41SQy+?=
 =?us-ascii?Q?SntQW7M/Qm+FYlLpA+u7mGL/auhYgy8ve0dxguB/RCXkSjpvkzDSyP7uGGnZ?=
 =?us-ascii?Q?TGFknUQafH5P9WECuH8xN4KJvC2sZemUbT0O3slHcXl1jZD39czlrlFByYWF?=
 =?us-ascii?Q?ZCwBJrYR3H18PL8d91xArwBz6QUipV76kReIlMZbEer+IUmnAzDnahQyUFEz?=
 =?us-ascii?Q?3bcWIXQ0jtL3/WMgeUCnnJJn1ziyk2DsfitCGG5A84r0U68LrFxnucsMrwFF?=
 =?us-ascii?Q?kDT8IEkkGZNX+QT3RjT1zaDSQGJM0QkngggBDSO44JL6UkD3eBL2E1ENXxdI?=
 =?us-ascii?Q?bHtqdT+9zFHSjU7E9fMA1Ac0wTdrVIgYjnZVCpg/zTiOorCKwG1csJ/r+cNE?=
 =?us-ascii?Q?gFG0wYWOjSs+XgXervoROxHdc6bRDjajIy4NtNmHvkd43cRe/g2lc10qGAjo?=
 =?us-ascii?Q?3PS6IYpSo61pm8Bd/AvLZ5HAd+5L2dgBkoeiOLMh+XDJOeExfh2/NmwY1373?=
 =?us-ascii?Q?+5Xn05R75NnzDLoHYI7PGtEX4XQ34Qw9S3FZzwikgoRSluaGE6yvIuBXi8lB?=
 =?us-ascii?Q?lsAtX9WZaZ6WT1lApB0aukuwMqdnybOOmJzwoMWb5jSkgAArLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gy8MZ70USUjzbKsERNwFVafmiodGgud1YvhRMwxSAqL7Z2k0Uc3RGoSQx4hw?=
 =?us-ascii?Q?BKy+HCviCr6SObGP0Ccscxi/4EVaYdsViYiPAHiUR0URxuEKY17XWiL2KTpy?=
 =?us-ascii?Q?hiIG6WffW4hdoeCupOnjBxtHdB/oS7Te3fYl7hvJ0pPPRYClCKfVA+T9a6qY?=
 =?us-ascii?Q?ac+U9/ZrSoQ8i2fQOK+giJi8JDJhzfQUswknWlHnhSMt7Ru2KwiK+Q2qfWm8?=
 =?us-ascii?Q?ietjWygsQMMV5kdoB6YkzfC4dqJ+CYwhSagDYDvVGFBGH/VmEIiouQIItfvn?=
 =?us-ascii?Q?f0t6TG8PEkOgBrACGIT/+/FqnZcbpyzwB4EgVxK829DwIvSEp62PivCgtvHP?=
 =?us-ascii?Q?sy0a5P78T7Fh7H1PBGzGyFy8RncoqmoZnt2T4RtX/4Xyf6kqdUr6tR3+k/IU?=
 =?us-ascii?Q?9TBb94aY78dYDe4+Vq+njS2VBjtVaCq0eJSD2J0Psl5AQm/a29/MsIUlHPNW?=
 =?us-ascii?Q?2ja09tUrn8FgWIdCu1AAUi+AhkRPu65UMR3FrSUuztpJql/5yo1Kn/fd7YJ+?=
 =?us-ascii?Q?npzIQzhudsomFJss78z2oSLzfzqkJaNtbNvs4Dt1S4PX6WDFWw6xZPqdyP2E?=
 =?us-ascii?Q?85eh2eEKUKQC/xMoL1/wJYoNbpSIeF62ipNBE487als2G3GA7AJ84/yX4u8I?=
 =?us-ascii?Q?Mjn6MIkNsqGzKLwOO2yyhpMoOp9Aq6DPNREtOltBdh97qSN4msTs7Ywg8urq?=
 =?us-ascii?Q?mvdSRF8wsQeQ/qasPIHLXVhQjfQRbvSMfCgrq//RTH4pXM7uO7WnRBEfQADk?=
 =?us-ascii?Q?GUm0ly6FQVeLIufS3JBsFi67NFgqJymWwG9pIDuCjpq/ozSf6Ul7saowxBci?=
 =?us-ascii?Q?GwzZfp9FPTYjgcTVvTXOGVRRx5QgS7uAaPsidsTvRxKaCRhtDvsYibFksFAb?=
 =?us-ascii?Q?/xrpnp1S0TwYWdGETrtindN3aDRPu1KRG0ief5rOVhS/Srltu2TRcnWqKnDG?=
 =?us-ascii?Q?Ywk5+4SoqQ7cQSQK0fgkwF91vaeXH2yfu5Ii232IGWjBx0i3qbGisgXm4tcB?=
 =?us-ascii?Q?xZqOy5NrBvWbn0BhMhnUpaG4qQZ5H9cNi0dK2UpZelb8L7y33jy4NgHakRD7?=
 =?us-ascii?Q?dmuvpKS5Qmj62tqzjtzfMXP26TEgb92q981Hgmv+f7PT4iZqatyCjv+uNtrQ?=
 =?us-ascii?Q?s5I3N5is0CCHuMt0aQQzoU3xesjrzkp/i+a39RFcX69dsAOw0dGJ7DCNN2My?=
 =?us-ascii?Q?Rph6bFEXamXfjejVSN9yTow3MIjAeJJtW7uDKHBWD6r/g13o35BLFnjQmI7j?=
 =?us-ascii?Q?p9nE2apITTvhE/qF8MaISyjQIsx6oVvy2cZ0bDVHLEzKX6QOz4heOmv/BPSm?=
 =?us-ascii?Q?K4ITdzLUtAeOvoN9g+9BN+KSo2XU2UhZlmXe4cvEIm6xDOFdAbW5GoTDzQ29?=
 =?us-ascii?Q?k0iU4OHVN2FECTHB+1CYvPB3F4odSv0LZC40++jupglgrYRs1h9gB6pUFvZn?=
 =?us-ascii?Q?CKbVw1sNHXLbcUOlWbPQDQYv32QwhBq7BXRSMLb56e+Xg7wQQchElNKxIE/7?=
 =?us-ascii?Q?7kEswTEJKNHSs9U1VFPzHgZS7ReUmjH+NEgIGhsYpfnQJrxfDhH1A2F3BRA3?=
 =?us-ascii?Q?Kjz2GAZQmXZGcmX+fXk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d1a7c4-2a65-4770-d8de-08dcb894747f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 16:58:12.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMMUDjLzr8JAu6otThWC781uLS9PR2eC6dnyY7477fL0sTon9ohOXSiptZi/rHp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, August 8, 2024 9:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.c=
om>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.=
com>
Subject: [PATCH] drm/amdkfd: fix partition query when setting up recommende=
d sdma engines

When users dynamically set the partition mode through sysfs writes, this ca=
n lead to a double lock situation where the KFD is trying to take the parti=
tion lock when updating the recommended SDMA engines.
Have the KFD reference its saved socket device number count instead.
Also ensure we have enough SDMA xGMI engines report the recommended engines=
 in the first place.

v2: fixups in description

Fixes: a0f548d7871e ("drm/amdkfd: allow users to target recommended SDMA en=
gines")
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 40771f8752cb..27d452e50ca9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1286,9 +1286,8 @@ static void kfd_set_recommended_sdma_engines(struct k=
fd_topology_device *to_dev,
        struct amdgpu_device *adev =3D gpu->adev;
        int num_xgmi_nodes =3D adev->gmc.xgmi.num_physical_nodes;
        bool support_rec_eng =3D !amdgpu_sriov_vf(adev) && to_dev->gpu &&
-               adev->aid_mask && num_xgmi_nodes &&
-               (amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_=
FL_NONE) =3D=3D
-                     AMDGPU_SPX_PARTITION_MODE) &&
+               adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes =3D=
=3D 1 &&
+               kfd_get_num_xgmi_sdma_engines(gpu) >=3D 14 &&
                (!(adev->flags & AMD_IS_APU) && num_xgmi_nodes =3D=3D 8);

        if (support_rec_eng) {
--
2.34.1

