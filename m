Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43CEC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 00:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40D110E05D;
	Thu,  8 Sep 2022 00:04:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AC410E05D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 00:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW1+kVkEEjypZJMWqlofQsR8MpNQ6o+d1iGlEixuQ4cRR3Nyg57fOMqFZTCvmXzJtJJsVHEQGxMPwsEnTxZQhsvUkWRZiCSXvmIhfy8MomEkn0oPbPvJ/9H7B8EXprDu1RMKB4CXfYZz3LZ4zHnIYeyzGdGAHgJZlpIcL0gGJhaR3q6NP79qv4aqvKVNubAPFBUed9F7AkV1tGZWtkLlJ9P1mvd4oRNiC8MmbrZVnglCKgZ3H+mJqlo+1aF6FjwnvsJgDlQd9pN2Nta9ZYEZwOknl9Rqb2CJAAYes4uX/pJ9TdPq1xnMTWnspO33GT1twqemzKZPQbS1ZBtSd9uyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRvyA9xFzWScK4dhi89hvt40oFU12mizZe++DL/7sb0=;
 b=P5imiG4AB6JkJuVO7iOK4ZWxHsFyFkob8+e2Eiza1fj6p7sPQtyQ+XBFlYdF76eFUXY6vDdKcn9vtStMe4S9J7rRrJv92N/4sniKhCGrcNVAyOVVNb2NSyTXe1qBnQWauRuRb7XGJtlqJK7b6sA76W3fNi+tHhGmaIk+H58XPeE/NHqHeSTq5cBbedTUBOi1pP9fHASCiYlCDGAjARn2FUsVqO2VmaVLug25wRmNbz2z31rlPUpdXcXwwD4e6B8CtcUSoYkqmaUNUYVaCiZ3Fs4Dbr5zc/NVOerakQFXeQuOIDP8LQOq9da9Kh9dyAzkysDhJ7grS57oMbjozWRfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRvyA9xFzWScK4dhi89hvt40oFU12mizZe++DL/7sb0=;
 b=fnp4uW/UExCW+LSa09ygM2lTinxtP2FegGQa+dwonAjTJJcgf35ke8mEJZsZz0QhqDwWwGsa1ARH5FF43SD/q18cclCe8HLMTwgj8fVpCGvW/v25+VgMBy17oHGx1REJXcmONWPuc+/7y9loykE0JKfnyELWUnyB8+S1zFcudA8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 00:04:48 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8c33:62ed:e957:73a1]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8c33:62ed:e957:73a1%6]) with mapi id 15.20.5612.013; Thu, 8 Sep 2022
 00:04:48 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on
 sriov  configuration
Thread-Index: AQHYws/iugWiobd7vUGTjU1jcjD1hK3Up4tg
Date: Thu, 8 Sep 2022 00:04:48 +0000
Message-ID: <CH0PR12MB5372A46F350E46A9953114F1F4409@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220907153803.24370-1-shaoyun.liu@amd.com>
In-Reply-To: <20220907153803.24370-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=27e07bc7-3ec3-4343-8974-97717a498d48;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T00:04:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH0PR12MB5404:EE_
x-ms-office365-filtering-correlation-id: fb1f86c2-76b8-4fd3-85c7-08da912dbe70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfhaC9n7xAoPamL4R4iL1VEW/0aQU1RBTU25RmDzdHoK7Nuetq+lHtu4t4fTm5OXcru7gjYXjuouB4KywRV8Jm9meoc907uDuY5p6RnDVNT1oniAmpqjgI6fCrHcYRK64lGtZMhjctfgBQXuxqqKR8xym2hCt/4lR2gXe1U0V/6JasmuCbUqR0G/o1wMkKjzOaYzW3o1UzRuGFONoM/zMVxhlVtE0DGtQSZZMbpS6Uf3BaOqmV+MftqL49Mh2ujfsk+NPUMhJtwqfelb+WYcfDwqJIIqZj5U5Ox3Fm6NOfvZu5XkS1cqcOBp5x4Op5+Iu7njpBwkMevR6lRj5V/tXUxu1+qzuPVWuk1ui6F/y/w+rygm6kkcpSBR5Qyvadn2Gk5KwbDkdNie8Gdq/NCjyRDC6dEx5snhOFCWzcLLPOii/TuvRltYnbABuxm/ziTGrYd7DsUJG04FBEVGBI3T1rIqoxe3/6RASUjKEoy7AisGMBCWHum3wjeZxX6+lH9WUS2+ilrp21SNs7oCLQwvto52Kt7vsSiQY0NqEfp19J3gV0lSAW42AZ0umzEQR8RdCObzs7cTq7iDeu6tC9HW6vMc1+7Kdx+CgooD+S6HlCQKfpFsFFhUpZCGYxmNUbSfqvpGLRzph2Xk6++Ylvr/1bf3lHf1aHzPGioD2bcwBkd+pIRYwrKzU8LW62jKoOz1fF643TOlwS88CHJPGK6s81MwKhX+SGYGDqh48ATQWu0Ri94Se2SyFh+KjMREenK1C2va6cECZ2k5vzeJHcLGIvrer4nftx99Q0jPbjv8FLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(76116006)(33656002)(316002)(5660300002)(83380400001)(66446008)(66946007)(66556008)(66476007)(2906002)(64756008)(8676002)(6916009)(52536014)(8936002)(478600001)(966005)(41300700001)(9686003)(71200400001)(26005)(186003)(55016003)(86362001)(53546011)(7696005)(38100700002)(6506007)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5TSpbGU/r9xz3p17XQASCTAQqxsMw/ILvniVAFr20ouGx6Baw8HqZ10R6/Wr?=
 =?us-ascii?Q?kFXMWteaqU7MB76mwUn9tGyX6YcvftB95ZxVTsQRaEm/j25VqNscdt5wdnUe?=
 =?us-ascii?Q?+7sPK7DtRGjmu9Yu0zqZAXI2LauqZTzDqh7DqaylMSZlRYIUl31r+XShJyjy?=
 =?us-ascii?Q?kidqDFtqvGOyQf2vGn6LlRFX2bujfRXmyg8CUzuy3g3Y7Kfd9I1HHSyfenyp?=
 =?us-ascii?Q?FKFXEPXo1zpbOuLuPS/bKY9U7MJGXMsy92p1+uKsQMfNnlgF7K90N2PMn5FR?=
 =?us-ascii?Q?R1WOMDjHyJIN7AzUjcTTx3VhMoncnyOCQDf2Qi/ANA7PosMGV3auDxLmbcAw?=
 =?us-ascii?Q?Xe7Z3ucMdoosRsV1KVxkxMremgkUb8jmroFCA4OJ9dNY05gRExT7ZnOrwLnt?=
 =?us-ascii?Q?CjxdXEBx4WSfmjCzwYZvqmA8f9NYHe+C9M7IXDXTclh7SvpNgE2Cuqk8ey4O?=
 =?us-ascii?Q?HfvrrcuVkGuDTMAhdRvALnMN/Yr5oAGI2KDopkkOrgqRqHGDNeBHQEVSrbCt?=
 =?us-ascii?Q?NBwfr+O6tXueEr1OmnlHi1hEBmjT8BJmOv9hfKvWdG2nKHtINnmfueL0Wc9F?=
 =?us-ascii?Q?v34qotqAJUBUCURwFlWIEWdnFsmm4kyaBx3Ut+WZDHie4iV4wqXLpQRNTTno?=
 =?us-ascii?Q?iAYEri15Apsi0hrMRxkKvb4hOI6Mp40D9w/nYofID35SYWhAuJAWcz+6SqH7?=
 =?us-ascii?Q?Llb/dc7S8B8ljUGZgxjsa89/YBr85nS108v/fhUqFuEf2Ksel2NJZICnOTdZ?=
 =?us-ascii?Q?OgOO6yxkpLktHCqB6m4HZA4nOURzqFEb32c1AAUiqTHewSOzQgKdmcncsrHa?=
 =?us-ascii?Q?FH95Pi5kbMSepB7hN4sfNQL4lpoXYbtzZIR4eEnztl63e0FORhDlJJGd70Hh?=
 =?us-ascii?Q?mHF1pEPpbHGBoawdkLWfhvsQUmYK2h2c9KhNhJev0VsoDQWS2dUZm3+JqiDA?=
 =?us-ascii?Q?LUX8n7iQoHkcVfOaHSllX+yeN51Hl2wMbnrycQwsM29gtq73j5oEb4AjhGTx?=
 =?us-ascii?Q?SN5ls0HFbFLZIyCyHE57a4QroErdG8q6Jafs9FuTn2CQr6zfNwVA0dXFK7Cx?=
 =?us-ascii?Q?xoLW6DEu9Vy7EziZN+yMtR9Pp1cyNxxvH/N+NrhomvA0yr0jzgqlb7qp/PVk?=
 =?us-ascii?Q?a1cchBUX1DV3tyUVYKAOV/sIKEELGqwdX9G43RpnBp72XjCF1iBACSfZfFi0?=
 =?us-ascii?Q?tYABiDkPEPDVkg6/oSc5vUNlQ5wgSGl4Hp75vVvVd2b+6Epjh3rMuWuN5B4I?=
 =?us-ascii?Q?l5J65f497Kd6Bovh8GLL/VGJ4vJuOYhoRDxL8au+oM0wXJZPAJ9S0BY46nZu?=
 =?us-ascii?Q?NLiJe3MwXRgBnQZ2pIuPDWBqI1FuiDZCPp243YY4s9dEFKOizdFUiP4bp9RS?=
 =?us-ascii?Q?TDNxmPzV6SI0R2uNuqBjoDExKYEpPEVxYPgdirXKlc+xfltGTOkm98HUQQxz?=
 =?us-ascii?Q?CU6IRZ2Q5ZC0NW0NDATNZ/YaNWOLM5FqWq3dwXUzprlqoTf/uQ+Zxsl0u2E1?=
 =?us-ascii?Q?mlczwKsajmsELC/POHWd8kZ3ACviMzwNxZm+CjssYVgreRwnvOMzesbLBUx/?=
 =?us-ascii?Q?ugm4ESxwrc4kyVYAiZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1f86c2-76b8-4fd3-85c7-08da912dbe70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 00:04:48.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrzhwYFMSHSXo6P8DxuUo7yq9/ZeTcbHlARKnb1E6bjsa4LJA/2jfM7X2djzSt9/+zwkgM+E4oyljYZhsiKA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, September 7, 2022 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov =
configuration

For SRIOV configuration, host driver control the reset method(either FLR or=
 heavier chain reset). The host will notify the guest individually with FLR=
 message if individual GPU within the hive need to be reset. So for guest s=
ide, no need to use hive->reset_domain to replace the original per device r=
eset_domain

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 36 +++++++++++++---------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b26f0e37b0..a5533e0d9d6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2453,17 +2453,19 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
                if (amdgpu_xgmi_add_device(adev) =3D=3D 0) {
                        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_h=
ive(adev);

-                       if (!hive->reset_domain ||
-                           !amdgpu_reset_get_reset_domain(hive->reset_doma=
in)) {
-                               r =3D -ENOENT;
+                       if(!amdgpu_sriov_vf(adev)) {
+                               if (!hive->reset_domain ||
+                                   !amdgpu_reset_get_reset_domain(hive->re=
set_domain)) {
+                                       r =3D -ENOENT;
+                                       amdgpu_put_xgmi_hive(hive);
+                                       goto init_failed;
+                               }
+
+                               /* Drop the early temporary reset domain we=
 created for device */
+                               amdgpu_reset_put_reset_domain(adev->reset_d=
omain);
+                               adev->reset_domain =3D hive->reset_domain;
                                amdgpu_put_xgmi_hive(hive);
-                               goto init_failed;
                        }
-
-                       /* Drop the early temporary reset domain we created=
 for device */
-                       amdgpu_reset_put_reset_domain(adev->reset_domain);
-                       adev->reset_domain =3D hive->reset_domain;
-                       amdgpu_put_xgmi_hive(hive);
                }
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index d3b483aa81f8..a78b589e4f4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -391,24 +391,32 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct =
amdgpu_device *adev)
                goto pro_end;
        }

+       /**
+        * Only init hive->reset_domain for none SRIOV configuration. For S=
RIOV,
+        * Host driver decide how to reset the GPU either through FLR or ch=
ain reset.
+        * Guest side will get individual notifications from the host for t=
he FLR
+        * if necessary.
+        */
+       if (!amdgpu_sriov_vf(adev)) {
        /**
         * Avoid recreating reset domain when hive is reconstructed for the=
 case
-        * of reset the devices in the XGMI hive during probe for SRIOV
+        * of reset the devices in the XGMI hive during probe for passthrou=
gh
+GPU
         * See https://www.spinics.net/lists/amd-gfx/msg58836.html
         */
-       if (adev->reset_domain->type !=3D XGMI_HIVE) {
-               hive->reset_domain =3D amdgpu_reset_create_reset_domain(XGM=
I_HIVE, "amdgpu-reset-hive");
-                       if (!hive->reset_domain) {
-                               dev_err(adev->dev, "XGMI: failed initializi=
ng reset domain for xgmi hive\n");
-                               ret =3D -ENOMEM;
-                               kobject_put(&hive->kobj);
-                               kfree(hive);
-                               hive =3D NULL;
-                               goto pro_end;
-                       }
-       } else {
-               amdgpu_reset_get_reset_domain(adev->reset_domain);
-               hive->reset_domain =3D adev->reset_domain;
+               if (adev->reset_domain->type !=3D XGMI_HIVE) {
+                       hive->reset_domain =3D amdgpu_reset_create_reset_do=
main(XGMI_HIVE, "amdgpu-reset-hive");
+                               if (!hive->reset_domain) {
+                                       dev_err(adev->dev, "XGMI: failed in=
itializing reset domain for xgmi hive\n");
+                                       ret =3D -ENOMEM;
+                                       kobject_put(&hive->kobj);
+                                       kfree(hive);
+                                       hive =3D NULL;
+                                       goto pro_end;
+                               }
+               } else {
+                       amdgpu_reset_get_reset_domain(adev->reset_domain);
+                       hive->reset_domain =3D adev->reset_domain;
+               }
        }

        hive->hive_id =3D adev->gmc.xgmi.hive_id;
--
2.17.1

