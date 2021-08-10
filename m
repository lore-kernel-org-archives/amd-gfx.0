Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68324C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2835160FE6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2835160FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE7E89DA3;
	Tue, 10 Aug 2021 03:01:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E290589DA3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 03:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuKTkY+NpbPEpNt9DJXQwKfD1PabDojaPpZzEw3qv4vh3PNua6SRKyTC35rOuT/zMu6eId5aRJ6Ddp3Wi1753QGGZCbDDaedy6TCpxp+rJt5xiTZmwD2TO/xmwSEfpG8wrWUAjZtj8ayY2ceGyWwvHNxhfo4aQY+XjcJEA5ASRBju3DuwWTEW4bXFDD/3fUXjRdUiIqUygT8TLckRPtHCCCZxqWNjLqpAhM2N5bGmRpa81lXa+LLUHtLayhBDefbcQs8Bi1ayT0oSQzP4VZGNc95NKij1uIh7JOjnkBflNj0xQYkKnn+bKbzm5BsvDM0zCRBipGbba+/aDQi1LwJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTEkBPro5U4nnCObSQC7yC+uvrMPn+ZVy5B8d5b1NaI=;
 b=Holk7EVMCEdb21izfAqSjddT9AvJmA1ZlU5HsOFqRfWpSyNf5fgQfXSsKRz/lWm+2Yg8F6vUenuxOiyitPYbe5kHi10jWIQHRg4SaY0XEe/Hf7u2Yr28G4MJnbPzK+uAObIj9ZTpaOrgp2qymxHemRPQSikEev+Ru38gK8P8g1gzKptJKAbrr5M4YJcGn8DwL9lQzJcEoFxgLwSzP4/bGRcvYk3MQvpQQyBNaToJvVugn6uvWz/989o3GW3FAIOJ2j8ECGNL+A4dc6mGZGeX/1Q6EEz5L/dcKETwrAT6p4uA5F6k4/alLtFgObX9x2qK8EFy1HuaTtUMc+/PNqzfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTEkBPro5U4nnCObSQC7yC+uvrMPn+ZVy5B8d5b1NaI=;
 b=Jrmk5o0iyljfm/JpNQLoSdyFl4QkuWbTeysRT70JwgeICkgmTNix3UUj4x8X87WGWEh9DgOdaUQOlyZNb0B+mGJrDA9BN2p3pX8jyoT88aSSPqWpvPCtdp1maTBFaS7U8VS5EHyxSTcs1uFMmsquOK0MT807Ob2XVzTuU4F/txs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Tue, 10 Aug 2021 03:01:43 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:01:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: handle VCN instances when harvesting
Thread-Topic: [PATCH] drm/amdgpu: handle VCN instances when harvesting
Thread-Index: AQHXjYwlzE97BnoorE6YnvaVrumKxKtsDM9g
Date: Tue, 10 Aug 2021 03:01:43 +0000
Message-ID: <DM5PR12MB2469AED0649F231B8BD5467EF1F79@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210810020441.995996-1-alexander.deucher@amd.com>
In-Reply-To: <20210810020441.995996-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T03:01:40Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5e16877f-ff19-477c-ae48-7ea24e666761;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76e250f4-3921-491f-3fd0-08d95bab2edc
x-ms-traffictypediagnostic: DM5PR12MB1260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1260A7A5E2DC8A3815F11737F1F79@DM5PR12MB1260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cIp8Fo1KfjmLnKKulA7zuQM+pRfiPcSlQbQQwLV3G//zxSrvGWsoXErILrL3lYxFWL4nipAWMzaKIEjoMA1vFOam3IsFx01OrhhUvxtxTUKBQKWPocxWq1B+zuQiUgRmjTQiOFcztibLl/lpTIoDmE5KJzh242iN/AZ629WJ2oDWI7L7TUCK4xaqZ/QO6a5i/lgoGMQv72pGffceCZK8XeCb4ofNRU/iHoodeIHEzWbJc1OemyBK7/KWOBY2yzA3RlbRJimW2FQwCv8t6Mqtl8OkE0ibC9H/1kJElSRBEZBDYlIHQn3Tdd1iLyi+t4SKD78QHaHoYoOroQaajAH1Z/IbtPHbGopOcs/NeIYXQFHgjHACEjPVLtsNnE5TYLjObXsoqumyoWXHSEQhUpjdVzJdleCsTbDbhAu9NFhZIM3uCu2/KJ4C3pIWKsBgFH+zOT8D9gpwIEaqQd8FOm/9MUH+NalmU5SeLiRLuqIgJYNd9Bn4KV2IwqNPisxkSF65hVDS5jfP4DKpCmXyPU31Nac9A97biKwZWeH8B67cJ5BwzTUrTCYh7tU6Ku7sOf7kcD7T6BzTdkaIY+S0b2sygpgAODlouNQq4znDspmiUuoTnU6r59PRTp47MA3jfBqTGd6cpNt/iNXtJJqKWchDhPv2WHl+Mnc92KPFbmnOsAjuIbDfZllsvUjUNcVilb3hyg9Vk6VVSCgVS3EaxorVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(52536014)(54906003)(38100700002)(122000001)(966005)(316002)(478600001)(6506007)(53546011)(8936002)(7696005)(110136005)(33656002)(8676002)(5660300002)(76116006)(26005)(2906002)(186003)(55016002)(9686003)(45080400002)(86362001)(4326008)(66946007)(66476007)(71200400001)(83380400001)(64756008)(38070700005)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oCaBoIRdohF0UkWijKyKgK5SXDl/s6lhoRnr8WCS2osi8T4UeQGe3EGSIlbo?=
 =?us-ascii?Q?h/RDRmd07OdoZTNoOW6Y0Qc72hnAVD9afffilef/MXoS7nxKObR8EGzQ/wgA?=
 =?us-ascii?Q?+qDorXbt+GJPcLBwKn8Vr9x3JXbmJaF+YDiRO5w8Pb40ZfV4uf+JW7Az7r7l?=
 =?us-ascii?Q?S8aCGCQdG+8gVBfbFo6qNOGqqItdHp+ul7hv2HaYPLbZhB76Wux2Xd7cb92V?=
 =?us-ascii?Q?Hh/DJhwapmfYwRz3BAzagnrxKTbbnHa8gFi8FV2xV7dizSdMGbrqzaSk6pMj?=
 =?us-ascii?Q?Mwb+wLWdr4T8oqi3pgJJus2XShZHVGZLO96jPRMotea14RVGXGZ69LK+gVZF?=
 =?us-ascii?Q?2R/FhsTmCJQ64+X0bAXZmmaWy/Nqa6/hzmaa39z82GSlgXlERn6xKlwFzCkl?=
 =?us-ascii?Q?o+W6LhLUvmE2oYBS0uVkF1L0dybJ/XINpZ6ntiXJgMtq0sgh/L0qvZ9Dcq65?=
 =?us-ascii?Q?PcD9op17+hH0eOBAbCzmwmLARu2UPfxYN2vQHzHIvZ1wXYrfh9MgvaBAKDw7?=
 =?us-ascii?Q?zF8eODreLLR3+cOEzspVvOxaQspjY+vXiNdarHXNXFj133U7d/L8pu61RDjR?=
 =?us-ascii?Q?A09nBnkJbTCmjv5T6fT+wqkISVve0l3Q8r+LK8QPSyjqMNewEjqCXH7HyvaC?=
 =?us-ascii?Q?YMmeZeA5oUep+TPeAl+XZ7oSjB5pl+Xihbv3EUkPX9P82afwlKJJDB0M3cxa?=
 =?us-ascii?Q?ZuyF48dnR0NVNmgK1sEaza14CuK/NUZHAJDrq/YKBVC6fUeHYLdon9K5d4nF?=
 =?us-ascii?Q?bHBs/XwyfS1mNmf+PyD5Fe1T8SfihGla4XTbnYFDOYpWM92oIqd+peNJXyoV?=
 =?us-ascii?Q?1OASD9wjPVqUxHQ/1rem9E6w+llJ01Ry/8pLpGtl0oZXs0xMnARa70GtrFX4?=
 =?us-ascii?Q?1RUemkMWNP7bAv8MZgvdyPde3fBs/SMZhVOPY9UhrhX3B/QjtRO4EimKDXOw?=
 =?us-ascii?Q?jZVaVkcJ0leJ0uy2r09ihdqKcyGiIXGEWHyJ7xct4pH2qRwtXKkzCVWWFe4c?=
 =?us-ascii?Q?xiaT/JELk/ANKLJ9pp2i36dkgW7pyAmi3EsD1wk2+AFhTwS+guZMoiVmarAF?=
 =?us-ascii?Q?VVT7kUr3tG2vSqv73QCjeC10A7zAgpH0beA18zO0yuc5kLOi7Ax/jjdAbRHS?=
 =?us-ascii?Q?8ckrTwkR3UDcDkF48cI6pfV8q/sNrDGyaABIzkHgHVwp51wsJSNOgyevWbgM?=
 =?us-ascii?Q?TW92fZMilznYMxQW8haDmgFW5sfqjSyhgDJKLFsuxPyq5Y/IfxO4GTUFh+jo?=
 =?us-ascii?Q?wCLaNy/AHwfHsjmWDkC9Fca5jzcODr9cwU3LQqHjJr56LgmjOwMlbN/ehURJ?=
 =?us-ascii?Q?Z8XPzY3L0qXLVhJq8XzZKcJC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e250f4-3921-491f-3fd0-08d95bab2edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 03:01:43.1278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w+vViGjTRILESUYeWIHNOBz+rgy4dJClctkRpOL2QM5E/m2E3gHUw7AvKc7n/+AVm90upQh3cAsybzqn/B7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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

A spelling typo in commit body.

There may be multiple instances an only one is harvested.

s/an/and

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, August 10, 2021 10:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James <James.Zhu@a=
md.com>
Subject: [PATCH] drm/amdgpu: handle VCN instances when harvesting

There may be multiple instances an only one is harvested.

Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1673&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7Cd3b39300779148333e6008d95ba34697%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637641579088850586%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DZ0tcI%2BPoHB2qwA2PVN4YBg5IjxLiaKdsm4KgE%2Bvf6WE%3D&amp;reserved=3D0
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 43e7b61d1c5c..ada7bc19118a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -299,6 +299,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device=
 *adev)
 				  ip->major, ip->minor,
 				  ip->revision);
=20
+			if (le16_to_cpu(ip->hw_id) =3D=3D VCN_HWID)
+				adev->vcn.num_vcn_inst++;
+
 			for (k =3D 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place, @@ -385,7 +388,7=
 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)  {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
-	int i;
+	int i, vcn_harvest_count =3D 0;
=20
 	bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
 	harvest_info =3D (struct harvest_table *)(adev->mman.discovery_bin + @@ -=
397,8 +400,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev=
)
=20
 		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
-			adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
-			adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
+			vcn_harvest_count++;
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK; @@ -407,6 +409,10 @=
@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	if (vcn_harvest_count =3D=3D adev->vcn.num_vcn_inst) {
+		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
+		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
+	}
 }
=20
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
--
2.31.1
