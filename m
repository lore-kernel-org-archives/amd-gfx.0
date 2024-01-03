Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE8DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 12:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7DF10E2BB;
	Wed,  3 Jan 2024 12:00:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F2010E298
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 12:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di5UgsldjwshEJVd7eW0hDTzR39D67KPtdH7Nx8NNNY8WALLaFLWwSc0oXXJd1M4Lq6K2LWjthuznUEHAlABiNGIGN139NjK8B9PTxisHqyjSqai9cgFVpgRe6LWoG6XRsHspDy56pz6j6F+b5nU56F5c03kexEG5bqOD2GEVxUwjITVSe2oS1PUt+svfwRS3U8TAvQXfMOsK/POCxxq442Nq5LlEwm8IHggQbieKnevM1uNr+EZXkYVtkQAUy5BAFYWDeveIvwWL40flX6BbH/0x/flaAHsRJUo67x5RMpdpJl8rV4iJ/B4Bn8jyFFsaklYHLHK/S1Mg2Qi4Zb1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fznHmevzsGWZT2DxqUW71Da+b0uaHk9zrmzruswpunQ=;
 b=UZ4ke/U4AMm3b1eJg7c7DTR8IoJPUnWNNKuGlm1dx1imWsbVaKZdDJwtpqX2l+0Om2ObYDzlDov2SLqWne9jkwg8dD+Yp9GwVONU5TZ9vJDXsKSGU4N1k2JUJXMsrBJruRoU6ShNZ5Pdm+L1ejSXKgi8jCm5a0MnY6ZdBpw2i/YDTIFppLZJvs5rHc6CxtuG8R78AcVGFOPNJgjCcQZaan2VvorrUJdgjxZXVhgCR5CgtZJx7364Un+9TdQUyaTGghbldedKSdng7hQ2MRJcFTA/uUDLUYP7SjU5tZRRClZoroMChP7w9ILvuYt9Hk7qsZbC/JkAh7PlLDiYozPq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fznHmevzsGWZT2DxqUW71Da+b0uaHk9zrmzruswpunQ=;
 b=GMINnEFutGHTGAjAejCA19IZPgu9Y1NqEba8/y6J8Lv541GU1TTd+1NIeISJvAcEJrMaKk7xiVAwfif3rRMGDp+FojArYPIrYgRFi+5/NYf8dkAsqQD3ZL7u/KgJ33lnYmnn8ttX6SvBXH17dU5kn5o8/7BhUMK6HlxveteBZRU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 12:00:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 12:00:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Topic: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Index: AQHaPhtmxGtwRqx0ZEOjppEprxjJPLDH+3xA
Date: Wed, 3 Jan 2024 12:00:09 +0000
Message-ID: <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-6-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-6-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdcc984b-5deb-45cf-8a74-8368334f15fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8835:EE_
x-ms-office365-filtering-correlation-id: b5ac3914-eaba-4ef3-753e-08dc0c538902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uhgCQ3Z9wwL45DeavATaxfVx7xIz2JhuLwadwV06b6P+yQhEaqEVAgd3ngEeDPRjj7eqlnFpLFzf1W3TMBEKuh5erVtgYhEAypfOP1/yLkwbVAfJEIb1ICCG6LSYNUAvtz4425j6eEppyVZiCQlch627IZG4o7dIVLgXvEf87GWP5E3dsNEFjentbH6Rd07blOzHBGUjE7ZXd1ueUvb2Bj8f/H0OgZdmiQGYs7DAQW8h6G0E3/UqrGkDIl4yWB6pHuzUAQqr7hgm2bIhQGHRAwdyHU0TNIG48oe8rtBKuHJQB0LMp0dfIiA5jwZ6NkmpJ4Ohc9fbtrZMIFuXbSHRjKrWluenLhZyZLzOWSfDAMZg3oeKNwW0zFBSmOuMFP9tiNsC8/1nwcpdlDAOc34ZFf4QPy08MYgget9PW7mQeIOGs5YBTWEcUOBdpJFQwGCKkdCmMMJE85Kxh0gi8NYj5LWQA59gXFb+0v+JFkLp4sry2T1k+xy1VeH88byR/8BUIEz2QAQ98t13H/rti4Yx6T4acEdmzP9+L28oj3xta+dNs8IVjbsB0T71QI9hNfv3kYBMgTxDeaA0JcwXWOy1af6YQq0rRHmQzjnqYW2D2fBhiNvX7KqCNP3sClDjqWE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(52536014)(4326008)(2906002)(8676002)(8936002)(122000001)(38100700002)(83380400001)(26005)(5660300002)(38070700009)(478600001)(6506007)(7696005)(71200400001)(33656002)(55016003)(9686003)(41300700001)(66476007)(66556008)(76116006)(66446008)(66946007)(86362001)(64756008)(53546011)(54906003)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4iVUJuqrctTz3+osrFSKR2RZAqfxyc9i76r/J/R+TGnHtuETOB/WrFadF/Gn?=
 =?us-ascii?Q?arJm0CoglkgbksTbCMF2v2k11lsxSF1NMqICwJXMa9yZUmhFDwmYtjpbRHOV?=
 =?us-ascii?Q?JlVcO5+6IrfbqUen74O43npdN7iy4Fw1DuCc489U5ES9y5KEtBT4YrUETD5z?=
 =?us-ascii?Q?ckJaCblH100LuM4+BlK5Dxf3O1ZNLE3Tt0IFN8tTruk+8lkoWceIOBaA19vu?=
 =?us-ascii?Q?ClRbxnDrl7cE5POprYY9z1MS6MhFaPwB+Bwg7LbFELuo3XpCCpqwJ0TkLoAP?=
 =?us-ascii?Q?IB0DJG7k0RipgTLM2kSJ0oiJebXctFbxioYLpAHUDIn0O0mj/9oWzGt9U9rj?=
 =?us-ascii?Q?A7lFKMpGq0OmlmHgMnEXT/nMh71ad35SDLCiJaoIBK9w4bJI+6tLnufC12Aj?=
 =?us-ascii?Q?YVHmQDy3j6QDrCJ7QKkoq2+Hk4avftNHAbVA7dxtI/uks1EqSXuLHnJxJ2dY?=
 =?us-ascii?Q?pm1hCW3qaGVr1Zy7UZ54rMchcf4mhVQMQ3Q5cK0c3nAC2zUy71FHd0CmuF0d?=
 =?us-ascii?Q?3KoFw96wHFox50jp+388DN81kctHzZC/ohBuSkwglVn12LwzFIHk1f46Yf4C?=
 =?us-ascii?Q?L72FXMT5GpO/r8hFk7C2OA4NBN1VIPWZI8Fsa2XA+Za9b6j7F+/1uxDOLd+B?=
 =?us-ascii?Q?SsbZpUPHPFs6dh133lsaMZwekjJ0kKqK+zbH2ilKScXqwNRWEKAC4Vme2EVl?=
 =?us-ascii?Q?RfwvJp8zNIRX+2mWyp7CUXhWqqsMqB2F+TxBiJlFHT74i9dELZiPSx7W24sF?=
 =?us-ascii?Q?92SCc3Zl00UeyDKIyt5l8t/O4DO2/J9WdEqGW4JmFkeVAkzaOr9F1PbimDNV?=
 =?us-ascii?Q?efOsNZ7sqOTAKl7hERr0EKtZLfOx0DV96hO5CiPwiG2fVXMTNkr+CJ0cB7zl?=
 =?us-ascii?Q?XVQxtNZhL6aRUj0Qbyo/zG07Hx5CK2y8Kyl+xUZxgwG37rMwz65vqS/d+04K?=
 =?us-ascii?Q?S6/5O8M/tU9/cpNUwphHTW5O1wmZqPuey5jwv/jzlWybpoYza6oUlYlMeL2Z?=
 =?us-ascii?Q?rh7xD7BYlQm2Sho1ntWnS9d/G5/rXt7lx/ir/I0/Sik5EVY0nwauUMQn3XB7?=
 =?us-ascii?Q?quJUNajJsx5jVvPp5q/eDfPA4RGK5y+02axs7sFBInvj5jlc34HQ8xSlLGZl?=
 =?us-ascii?Q?cIhcCHRdZDxHQVBs99u2grOLKlj+GoelGsJXTR308XBdBKfw4GYrqSQs560/?=
 =?us-ascii?Q?vihQInELBdCVqqsdZT/CWOgL5F91lKWFriUjDgjlopIcRQheWoVrONgAf6wA?=
 =?us-ascii?Q?ubFHwkBnUrzvOO39axLs8QUNWnhu52H+zan30YcGHX+jSOkNC6bTC8bXdrM4?=
 =?us-ascii?Q?wK2NcNgHj3sx5/WelZJHA8ItwGEJOpevBSERUYivhR0OhF/fRnlyskXmpdd4?=
 =?us-ascii?Q?i/xe0QwvbSUcVDfBGCEhH/Qs465aFZzp+QzYboP/XCNbdpcYJXg64WnJhdOG?=
 =?us-ascii?Q?tgrFP1kUqnqykwkl7W5x9uwNFkdBiTQJg7NwwTuesTZu90iuZDkH4ODmuflT?=
 =?us-ascii?Q?Bc8N3zfVCaClGW2ZK9wyeDREFodU6Kz0iKekkg4MUT5sNBeDQoDyr97tejHe?=
 =?us-ascii?Q?pQnhhps6HwhyVnoFsafKtXEPABMZtlYYNdGd0d05?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac3914-eaba-4ef3-753e-08dc0c538902
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 12:00:09.9848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6BvHVMo6eMhsOYSVCdT5aPjWmYjQf/buf+5l3ksJnw5cWVlvFf58fEMBOUUy+828AGVpuye0KSSIsC6pikw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I assume we are leveraging error_query_mode to differentiate aca path from =
legacy ras path, right?

But given in-band error reporting is just the start of transition from lega=
cy ras to aca, do we need a flag in amdgpu_aca to indicate whether aca is s=
upported or not? Accordingly, we can initialize the flag in amdgpu_ras_chec=
k_supported. it should help us to differentiate aca from legacy ras when im=
plementing other features, thoughts?

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface

use new ACA error query interface to instead of legacy MCA query.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 88 ++++++++++++++++++++-----  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 12 +++-
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 038bd1b17cef..bbae41f86e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1168,6 +1168,53 @@ static void amdgpu_rasmgr_error_data_statistic_updat=
e(struct ras_manager *obj, s
        }
 }

+static struct ras_manager *get_ras_manager(struct amdgpu_device *adev,
+enum amdgpu_ras_block blk) {
+       struct ras_common_if head;
+
+       memset(&head, 0, sizeof(head));
+       head.block =3D blk;
+
+       return amdgpu_ras_find_obj(adev, &head); }
+
+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block =
blk,
+                       const struct aca_info *aca_info, void *data) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       return amdgpu_aca_add_handle(adev, &obj->aca_handle,
+ras_block_str(blk), aca_info, data); }
+
+int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
+amdgpu_ras_block blk) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       amdgpu_aca_remove_handle(&obj->aca_handle);
+
+       return 0;
+}
+
+static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum =
amdgpu_ras_block blk,
+                                        enum aca_error_type type, struct r=
as_err_data *err_data) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
+err_data); }
+
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev=
,
                                                struct ras_query_if *info,
                                                struct ras_err_data *err_da=
ta,
@@ -1175,6 +1222,7 @@ static int amdgpu_ras_query_error_status_helper(struc=
t amdgpu_device *adev,  {
        enum amdgpu_ras_block blk =3D info ? info->head.block : AMDGPU_RAS_=
BLOCK_COUNT;
        struct amdgpu_ras_block_object *block_obj =3D NULL;
+       int ret;

        if (blk =3D=3D AMDGPU_RAS_BLOCK_COUNT)
                return -EINVAL;
@@ -1204,9 +1252,13 @@ static int amdgpu_ras_query_error_status_helper(stru=
ct amdgpu_device *adev,
                        }
                }
        } else {
-               /* FIXME: add code to check return value later */
-               amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TY=
PE_UE, err_data);
-               amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TY=
PE_CE, err_data);
+               ret =3D amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_=
TYPE_UE, err_data);
+               if (ret)
+                       return ret;
+
+               ret =3D amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_=
TYPE_CE, err_data);
+               if (ret)
+                       return ret;
        }

        return 0;
@@ -1254,7 +1306,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,  {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
        struct amdgpu_hive_info *hive;
        int hive_ras_recovery =3D 0;

@@ -1265,7 +1317,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
        }

        if (!amdgpu_ras_is_supported(adev, block) ||
-           !amdgpu_ras_get_mca_debug_mode(adev))
+           !amdgpu_ras_get_aca_debug_mode(adev))
                return -EOPNOTSUPP;

        hive =3D amdgpu_get_xgmi_hive(adev);
@@ -1277,7 +1329,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
        /* skip ras error reset in gpu reset */
        if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
            hive_ras_recovery) &&
-           mca_funcs && mca_funcs->mca_set_debug_mode)
+           smu_funcs && smu_funcs->set_debug_mode)
                return -EOPNOTSUPP;

        if (block_obj->hw_ops->reset_ras_error_count)
@@ -1773,7 +1825,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_devi=
ce *adev)
                }
        }

-       amdgpu_mca_smu_debugfs_init(adev, dir);
+       amdgpu_aca_smu_debugfs_init(adev, dir);
 }

 /* debugfs end */
@@ -3138,8 +3190,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev))
                return 0;

-       /* enable MCA debug on APU device */
-       amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
+       /* enable ACA debug on APU device */
+       amdgpu_ras_set_aca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));

        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                if (!node->ras_obj) {
@@ -3422,7 +3474,7 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_devic=
e *adev, bool enable)
        if (con) {
                ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
                if (!ret)
-                       con->is_mca_debug_mode =3D enable;
+                       con->is_aca_debug_mode =3D enable;
        }

        return ret;
@@ -3436,22 +3488,22 @@ int amdgpu_ras_set_aca_debug_mode(struct amdgpu_dev=
ice *adev, bool enable)
        if (con) {
                ret =3D amdgpu_aca_smu_set_debug_mode(adev, enable);
                if (!ret)
-                       con->is_mca_debug_mode =3D enable;
+                       con->is_aca_debug_mode =3D enable;
        }

        return ret;
 }

-bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;

        if (!con)
                return false;

-       if (mca_funcs && mca_funcs->mca_set_debug_mode)
-               return con->is_mca_debug_mode;
+       if (smu_funcs && smu_funcs->set_debug_mode)
+               return con->is_aca_debug_mode;
        else
                return true;
 }
@@ -3460,16 +3512,16 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_=
device *adev,
                                     unsigned int *error_query_mode)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;

        if (!con) {
                *error_query_mode =3D AMDGPU_RAS_INVALID_ERROR_QUERY;
                return false;
        }

-       if (mca_funcs && mca_funcs->mca_set_debug_mode)
+       if (smu_funcs && smu_funcs->set_debug_mode)
                *error_query_mode =3D
-                       (con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_=
QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+                       (con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_=
QUERY :
+AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
        else
                *error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 408e21c3cc88..2afac9aa381a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -442,7 +442,7 @@ struct amdgpu_ras {
        /* Indicates smu whether need update bad channel info */
        bool update_channel_flag;
        /* Record status of smu mca debug mode */
-       bool is_mca_debug_mode;
+       bool is_aca_debug_mode;

        /* Record special requirements of gpu reset caller */
        uint32_t  gpu_reset_flags;
@@ -530,6 +530,8 @@ struct ras_manager {
        struct ras_ih_data ih_data;

        struct ras_err_data err_data;
+
+       struct aca_handle aca_handle;
 };

 struct ras_badpage {
@@ -781,9 +783,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu=
_device *adev);

 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *=
ras_con);

-int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)=
;  int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enabl=
e); -bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool
+enable); bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device
+*adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
                                     unsigned int *mode);

@@ -821,4 +823,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_=
data *err_data,
                struct amdgpu_smuio_mcm_config_info *mcm_info,
                struct ras_err_addr *err_addr, u64 count);

+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block =
blk,
+                              const struct aca_info *aca_info, void *data)=
; int
+amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block
+blk);
+
 #endif
--
2.34.1

