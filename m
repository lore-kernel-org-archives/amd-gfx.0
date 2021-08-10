Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAFCC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE71604D7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCE71604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEF089E1D;
	Tue, 10 Aug 2021 03:06:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B96489E1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 03:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcFaelWt/cLor2n4yfxFhGy7+RyhQ0psLNX3gX5kmG9Z9KBWQDrn0fqOzKxM6Z/EtjzeNKg4c3xFvBF3K7dc9Dmx2d/BOrWGQF86x5/r01qmMQrVHvvleM+TSwyCq2hi3BxdQyOz4CcsDUbGtsQ/aik1B5rHPH6EYi7IGZk/A22ZfBa1GNviMBvNGdoKYQAKh9akyuKdYf5KAr3CwA6m73ZZ9VUzkzkFNTNkh07pG3F5to0YodXw1cUXSXqwX5lld/gsgNaDvIfaC4sLuSS9rdB9Z0ry2Xuut9EHDwGdb5/AI3wp51CZ6HzHjkeuouEo0cbL2emgo54cxpjKYWARzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m3PiZliMWNtnl44k3G5VToFSLAL/utIoo+YSeDgiSE=;
 b=nf6xofQKkZWgno1Okxt1fc3iupFplQNPV7yxaUlVQMcdrvTG7rrbYD1eJyY/7efZN94Ko41PAVDWN34AIdPxKfliD6I5bX6rs/PJ4hae2l3lmQ7Uep6Wcci2m0JHUKzJdGg//tzjwd9HuZ7ZOfujSU6GqiilviMwPN0nOCHys0dvcBLC0jH22pp+uNUY4aizhnfTH6i2j1DIIC5jG7lt6gAFCF0I2qjNaO8qouyaAJXCMKhU8qaKlu91xnf3UEh2S6EsX83ORxWGlQ3wWDj2pJlvJWuyJpjHTlQr5N+OEJBZKMUvIxcaOWPfNMfmdHN7leHwspmye4WTFk0tGLmUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m3PiZliMWNtnl44k3G5VToFSLAL/utIoo+YSeDgiSE=;
 b=HdiE0NBnzSmTLppqfPnQV7k6BpiVS9RP8zD90ZgHRtxewOm0ZvbQlhA7mtexCi9KBUyjfP+MlUXz0Jkz3gqP2OI0hooyODFBeKTs1lXaCuiDKSSrKarSHv1iEubUHLQrMKZ+5es/SACepYKY1DIaInMtR05FbOvTX/54d6sX4+k=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Tue, 10 Aug 2021 03:06:13 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:06:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)
Thread-Topic: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)
Thread-Index: AQHXjZRR5p6AM3AjFEeSo8NBeWCb5atsDhBw
Date: Tue, 10 Aug 2021 03:06:13 +0000
Message-ID: <DM5PR12MB2469B6FC56449B5B2F7070E9F1F79@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210810030313.997451-1-alexander.deucher@amd.com>
In-Reply-To: <20210810030313.997451-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T03:06:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4249a871-11b7-48b1-b55d-51e2d4610e9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f76d505-9479-4215-9636-08d95babcfe9
x-ms-traffictypediagnostic: DM5PR12MB1260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB126067C59E9A2A1B40018C78F1F79@DM5PR12MB1260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPePCs2uBQhNIuNr76rfzsq/Ro61ZeUsfD8bfTchxjwqNnSQeKG6+ssG2nsODizckhxbA1hjlbCkgW6oHWUcHhrd/Q621CWttrt9Ek4ZIrtIQYoyDibq4tyy1jxrvSyTaYmk4zozyRCI/OFtDkKBy77xPEcvYwuwc5MPSHXuVB9jcgSQHJqHjofL5l74TJz0tT1jtTKBKKuIAe1ZLbNcZo777kId046Gcg8NKb+gwMDgSvEhxV4aUuLFa6SYoUjYgKdOCQqxCXw0z9sLA4ImnnfDCQGooaY8TCWOhL5DU34z5H5cUqxONeD0BSmnwxaTZ2eaORlH/Q/23Pkw4WLDRJJtwknf72Iugk/QJtw6Tzz4mDnYETK2sUJNjLBulAOs+Bxh74uo+j6uJFTvIYTYXtmZF95VwELJ6wDbJ7duKBSNDBmhMH+UGm70CqqRPp26JxYTzRVz2V0HFg+NUZuyy5wyjvPQIcz+Bf6ghM7sS230Zk9x/Hs9TCrFUHnr8+acLQL6SPm2z2OrXYqqUEgcgMePXI4yQS2HI2oT8LVUKAAj743RStOb++xBBtdWRI2vrLzilxDZ7Q8VnLNUJXSlieUBc04qTPmkw57k1987wAWuIIe/1MLiK2ZHUC752CNiv98d5Xh9q5okvBT0LpAiDvO8jrygynq52ldcPdkL7LL/RbCbyMhJ1QBd+5O0Cmqf/5QVX/yxpfjCWsmT1cGpJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(52536014)(54906003)(38100700002)(122000001)(966005)(316002)(478600001)(6506007)(53546011)(8936002)(7696005)(110136005)(33656002)(8676002)(5660300002)(76116006)(26005)(2906002)(186003)(55016002)(9686003)(45080400002)(86362001)(4326008)(66946007)(66476007)(71200400001)(83380400001)(64756008)(38070700005)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?03X2uq7p81rPdfLGOxHeggVwDPrTOSyUcrpa+/QDJC1B5EP3kSm45g/GRT15?=
 =?us-ascii?Q?ImAsV8eR+FTNXPxStZpHGM6dJrrYf15hsPVwqtmaA9hen0oawIeAMxfJY0Yu?=
 =?us-ascii?Q?XBCb5tO7VizziffOzfnoPuPWmVbJTcPc92utomJ21VsrK1CcSL+oDo5thlLo?=
 =?us-ascii?Q?W6J7FYoZBlHX3stRl2dMP4Wq1MT8Uk/4AUCawDSY8c7JX5L2/fH75jjG0RKP?=
 =?us-ascii?Q?mbZUfkPPomlsRD03qiUU4/Hne9GKW6YFJm3GAsB1u2+C/JK6NmEV11KCmhi+?=
 =?us-ascii?Q?euvxKTbAACoTkbFyKUsQ09gMNNl2z3QDX2H30VVV9yeaHUedNQlX249Uf9Lx?=
 =?us-ascii?Q?WwHIo0jleuUCN9we/y+G3HrAIaGrTQilYt+dSiZXi8ERoK71HSxa2yFcxcwj?=
 =?us-ascii?Q?wZiVV1wzmXRozUSs44Eu+hqSdOiIadR+z6eSUvaghYlBu0VS93J1G+ROc2mJ?=
 =?us-ascii?Q?a5DzLA8EO76KFsnJIpsjF/UN8I1Iqh7Z3MSd4yhdOVhFkmi66wF4oSm+UzX3?=
 =?us-ascii?Q?2P1S6aN9GXttVaYS2F1WR33JYBqzEEjhzUkVFXwTMhck090/KOq8xuLpp2wA?=
 =?us-ascii?Q?PtnzPNPQQLc4E1+btyrw1UB5vAQ5NvCE8xGm5X21w9DjCYxb37AGuUoGx3No?=
 =?us-ascii?Q?JRhBWoSCw88DBeXUZ2FaQbigAOj0Zzv194m4scv+KmqWWK0Wr9AdkfTTVbX4?=
 =?us-ascii?Q?vUViL9rqazr0c5rDFWJwraTH4OQKuPmQPZhsXYtuAeIzgENzWQYWddjt6HWH?=
 =?us-ascii?Q?lpxDxhm8+9fqeCyppxRZJ2XLmaN7iBz7sRMHay0fWW40UcPBMDxSDE1k8mJi?=
 =?us-ascii?Q?IWEOStxTS2fxUwKgNfmwpR8YqFyZQS9YrPl086iJLb0et9JhsnQJ3O7dbChH?=
 =?us-ascii?Q?nUJ3g3UtviL8SyICbFxQnwQYqT390FCzkjIT7qzhx0ohiby5K12lVx/rmqz3?=
 =?us-ascii?Q?v9wjFGHRaaz0Ng8c8tBMZauBvLg1JgrIjpZzDWe9Yml+GGbjpUn66WD+E2wC?=
 =?us-ascii?Q?ycrwu5U04NdgyjPKaE1HakJEJel149wKb8lML06mvQlCuD6j6C5jevTjSkJ+?=
 =?us-ascii?Q?MBxaixnvKE2ZRMsdr4yPWtbXqBbYzcYGfWBmIAZv/3d7W4CC90H22mEOeUKq?=
 =?us-ascii?Q?dkMPrxyn4wsbV8JO32g+fnSJJzAVz0t2sYSr5dcnG5uoBIXXRaZ1JqJv8prd?=
 =?us-ascii?Q?zzdQaIy7Xv+E8weoOStXiR1g3vNb9Z1+09GsEryqKoLmO107dJxBhTCwysF/?=
 =?us-ascii?Q?5EI3eUDxPOMOvRWzSXn7wMWM8F4etmC+60EUKLL4aMv+rllBRsZbtukYpiQ2?=
 =?us-ascii?Q?M9MRWjEoT9fvy3//M2tQ+9TH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76d505-9479-4215-9636-08d95babcfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 03:06:13.3314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAH1g1BCYIPCAWzuZMd/2Zl8yCqyV/DLg67xXtocvJs3vEeMAHbPyt5mHC7991YvKWOKZsAUcUzU3x5LDaJevw==
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, August 10, 2021 11:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James <James.Zhu@a=
md.com>
Subject: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)

There may be multiple instances and only one is harvested.

v2: fix typo in commit message

Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1673&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7Cff725e2787674280255308d95bab7325%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637641614198052677%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DoNLIYokjXIL2CfqeVMevwNjj9jJJo%2BmhZJ6az8TLW2c%3D&amp;reserved=3D0
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
