Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD631C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 03:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC2D10E01F;
	Thu,  4 Jan 2024 03:09:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7B410E01F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 03:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJe0mpMiYRavFspq/le7dxhSU0nUzoSTRLLsxNixl3d2btPi2/1nHzbxUmXn94qswz3Nzvl2zV8CnegoYjd2qD1XYIf1YJ0bD2SflpUgX/0otImGB37JkkeQikCxFfxvm5xlXowAurGO3RZmdXLOFM1+cBjbxf64MdrcHA+Wl+qDeakU8DG4zgfMfg7I9pSAYUH97oJd/WBNO1PKJ/bYV5QVPLDfbCuunMNXf6nxPjDgYoyeplZH7l9V6uKM4CnLi+LpeKGjH8FO13BXwD0RL2S4xLGIJ+7uuKZ+19zMz2XvENmYZGORaqcAx/J/ih0GVJIFMhkX1PlJldIFFkzkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/n+J2wjAze/AjkASS8CMgFM0b5xtaUB4VirRQxdi6Q=;
 b=I72+eVmHL81wYPNZaf/6mTGKmrbI7rtPyWm53ebW+JqQCiL0utnyZI7YLjN5gIBeTVXD+dtpKf2r7K6fidVvETeQl/A35M7NecJSAZMcM8w/8pmozu2c2s8AhmmQJ0Kq7PuYN6zyRpAKTwsuUDY59lR/jLceHxdz0ZFsfb7UsT+vpDBhF5SrMUnUWdArQyFJNlEZka5m/Szp47PpGJLEmNeSEdmN6Y51gHUnLVrbrYD3i1tahNFq5Y+CIrkt0uXoEjphy5uMiiMDvXkpw5btm5C6tCswtLlKAnBEca9RSGLvd5QTzie3MP5eYLVcdF//9Hc+mDigzk8dsJBCwhhfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/n+J2wjAze/AjkASS8CMgFM0b5xtaUB4VirRQxdi6Q=;
 b=Qb3foVqCkLs4KZGr4dikHy/kSIom9KIRa+mH4blS6ESgV79ZsAIGnRtoTKOqUH8z40qFnsOFgSCnPajLXcpp9oPbaCw5/nZcpvINsbwn9dtVXpqvcI9/2bYDQn3sL9dRDBKVOkYxx91hkpajKunQuffd7VFC1X0uGTsBKbM8VwA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 03:09:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 03:09:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Topic: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Index: AQHaPhtm5AMWhrYRZUWX6LIOLkMU07DH/JWAgAD63xA=
Date: Thu, 4 Jan 2024 03:09:27 +0000
Message-ID: <PH7PR12MB5997395962FA9BAA037E53228267A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-6-kevinyang.wang@amd.com>
 <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
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
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BN9PR12MB5366:EE_
x-ms-office365-filtering-correlation-id: c4b29b30-65cc-4621-23e3-08dc0cd2901f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeoQYFkTakttWddUIeO+VuEwUTSkMFcWaasZsCdrQP/QObtk5wi0zlyTBxMJwkzs/ZJNFfFR5iUZNWSim/90acHi4B1PyQKbnztW2Q2FJ+qNnFuaxv+bvZqDGlE3o+5eatbbaYbRpCwQQoK4658Vz1FTYhJGYLpwpgIYvZeQjV5Uaoco3I1moCBzpJ62MazNgE9bTuIqUa/xOt1qbishi03IBeeM7/vBJc9c5osh/11pDtWLszZVW45bHEE4Qd41TXMq4ZKxpgc4W5N1zCYobzf3gm89YxuscWaNu1qTKwFWr5M711WQWrbUVy35Gidg66dFOrbxtAl2dsr3uLNPxjl8zoOZvqiCQS+TEfa9gg8L9tdpd64qQ7R5+27BY6u5WYY29n7gZJypbdLrmiaHJjkMtMGmJf0526cbqn6bAnC+TwZzlsVhijWcwqx3ecT6cAiHGAeWch8iODF7LJA8K9+p+8kbBcmxJnl9os8xSbN7qyPiDWrkrzZy0PYsqECnJ5nkNjY5rrdZ4XiUvXQggckxqztfbnaUpkU9SlLtqXm2iEFV8xr9ru31qsBkFmpONrAkW3fH/9o4V1eOVPXuBMLVhs+tTgJh4hhDfbqyEW4MkRAPpZ2wk/nIYaOaUKwu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(66476007)(76116006)(66556008)(83380400001)(66446008)(64756008)(33656002)(478600001)(55016003)(26005)(4326008)(110136005)(52536014)(316002)(54906003)(71200400001)(9686003)(6506007)(41300700001)(8936002)(8676002)(53546011)(7696005)(86362001)(38070700009)(5660300002)(2906002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWowvcAyoPHCzvz8P0sNF6Xd+rhqPGcl0hf2C0dVlS3JY3I5UsNMjb8lhfeQ?=
 =?us-ascii?Q?AV5Kn27Ez5Lw4ZsGwy1A1um23xk05HGIYpVuGM7ncIakboGhM5NXQhMaST8K?=
 =?us-ascii?Q?OTeaCYnKXmktBuNopbEDZiJB/JPqm0o8ARfd8yDniNKXVXecbARjNmE5HX5k?=
 =?us-ascii?Q?q0cGoBiJXhiVyrQSZH0isSTX0leAc710YBvL3WuU56NQqrYtnqpvktUUCyR7?=
 =?us-ascii?Q?nXqoxgsCvwGb49mW7rwScn0TF/ylBYdYM9pwS3YCS3Bp9IbISBp7fPm6snfD?=
 =?us-ascii?Q?y0IWm8A9wx7rjnu+7oyZVvt9w3xJPdOWyZykQXvgKUOfEhe6PA0j76hmuFg5?=
 =?us-ascii?Q?ipLoW4e3GkTd1xcsdIJpdRHB/xZOIR8uozVR5F0s7DYXPMzKjni32wNw6XaG?=
 =?us-ascii?Q?H/DOUQ81CwoCvduLbBIYy0M66c5aNl57nCnDVD6miyIUZMrF4cVaeI442rHc?=
 =?us-ascii?Q?BtdC0EXyT3davdgurCfOuc0kTEuil1+iWyOin2I+ASjrtZJryzcsj0kyTeD0?=
 =?us-ascii?Q?8q5Cb4u+S1V+1K/gNdK/PrdOhd+TkFRZor20SrEHfUHoTtowCIMxSssNawxi?=
 =?us-ascii?Q?ih4DhxnE8ZEI11+Lb1+Ub13XZcxsC0Rp8KsUWNGIw0fa/eXsnOJLsl/aVHE0?=
 =?us-ascii?Q?wLVHn+kAUBWH+Oj7CJZICH8JVg5nhn2YUvA1k6V7Fhoe+dIVk6XMQz/A3TRg?=
 =?us-ascii?Q?O1kvnGfOujX24bYy/Q3gK4PV6WyAui2h991kcaWEPRsaEu/EZHxF2Tj6Exdz?=
 =?us-ascii?Q?ELVxTQGx/m6eqtR4I0eTmWnKXCgBMXm6+EdzfUkjbH9TJ2C4iIXMPIlBYBkc?=
 =?us-ascii?Q?AGJGfy22USDigKhJuMNpW34vs7zM5Ascimevt8mcQccq0lKRAcAyh+wmjDSG?=
 =?us-ascii?Q?FX4ZhnfWezq73RkPosI6JsOsHAUn7K6iZ6tcQpoZy/lCgmYXAyp8hGSyWfuS?=
 =?us-ascii?Q?7XwhxinwUjT8ZJjoceGd8Su1hbqCcew7kBzyUbvAN+NF0YSlmdMxdM6AMZcb?=
 =?us-ascii?Q?OXUQBcKbUqAUHIKMGyan7+S0yC49j/vuoZANH4v3VJvXe7SUwlcMVDGylyDG?=
 =?us-ascii?Q?2CVReOeQX9Hg7NK38YVz9dsyBfYXhnOqIB1MEdqQIPvdVthC1FQtt5vY2U0o?=
 =?us-ascii?Q?l44W5iUVpilbFW7O86ParB+qDnO8h55ecnCsKm6ckqQD9jbs1BBPNJ+RlHqj?=
 =?us-ascii?Q?zg4vGK7GKJV01bqR4NUB/a/VKyI1xP6Krxudy5VTnfHZa6MjGjknulqa369M?=
 =?us-ascii?Q?TCqRGeKqPgoc+YHfp9AXrskUvXA7E0up0+jOqCSJr36o0S6QI59sCJ0Njk9j?=
 =?us-ascii?Q?QTGLpv8LGd8OQtnvQvdqEyH5STKq/kpUVVhBkY0Q62gfZhSUB/ymjNQTN6YL?=
 =?us-ascii?Q?qzL834EWnU9MX2sMlnVtL4imXvEz8VtN1pA+qiMVaijPZeVTMVud79Rq6Mcu?=
 =?us-ascii?Q?y3FlfUOgPVH73Ujr7by3xtayYADfiURsug9nk6moH1GZGcIC8iXoxG83j5KK?=
 =?us-ascii?Q?l6MuTtIXKQv6PXrfFNtKQmJ09EZPngMPHmxw1XWCFyZjHSBanppDWokkM7I3?=
 =?us-ascii?Q?E+PO2K4xhI3ebB9ncAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b29b30-65cc-4621-23e3-08dc0cd2901f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:09:28.0029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg6i1d1q0ez4Ds8M9E/YYkufDlQNISE3y6M6BWH4ACPBBGcAMiNvnhwHISn2SIYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 8:00 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface

[AMD Official Use Only - General]

I assume we are leveraging error_query_mode to differentiate aca path from =
legacy ras path, right?
[kevin]: yes, the query interface is dependent on this query mode.

But given in-band error reporting is just the start of transition from lega=
cy ras to aca, do we need a flag in amdgpu_aca to indicate whether aca is s=
upported or not? Accordingly, we can initialize the flag in amdgpu_ras_chec=
k_supported. it should help us to differentiate aca from legacy ras when im=
plementing other features, thoughts?
[kevin]:
I think it should be NOT, whether it is aca/mca/legacy driver pooling path,=
 all RAS query interface is unified, so there is no need for a flag to indi=
cate whether it is supported or not.
And we also have a debug mode debugfs node, this can dynamically switch bet=
ween ACA and driver pooling modes.

Best Regards,
Kevin

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
ta, @@ -1175,6 +1222,7 @@ static int amdgpu_ras_query_error_status_helper(s=
truct amdgpu_device *adev,  {
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

        hive =3D amdgpu_get_xgmi_hive(adev); @@ -1277,7 +1329,7 @@ int amdg=
pu_ras_reset_error_count(struct amdgpu_device *adev,
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
+       amdgpu_ras_set_aca_debug_mode(adev, !!(adev->flags &
+ AMD_IS_APU));

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
+                              const struct aca_info *aca_info, void
+*data); int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
+amdgpu_ras_block blk);
+
 #endif
--
2.34.1


