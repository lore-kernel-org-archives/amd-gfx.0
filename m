Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ACEC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 05:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC6210E1AE;
	Wed, 31 May 2023 05:50:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A8810E1AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 05:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baHhKSMl36L2nsxLtn22IFeow9TNACwh020bPqQcjflGnv1DqRM8L27oveFhLqUqblOZLNVWxM8m5NJAnYa59/KmCjC1jspGqAL20pyXVpnlMYpyum2eIKz0BpD0SzmH5tIS2ZD/YQG/Uw/drgoj2RXnkL74oifWcDTgMOmbZxhcQBHpLspTz1WWr+na65b8fIMUefdHAllL8jn4KI174+VjTUi7Y4bsPvwY5RkZIWrlRmwtV08gEBgGo/TnpaPcD4j4L+BTXC0wYKf8f81obrNGhE21ZJcg/YfbMw6d6d3UZ2IMLmshsUmgI+z0o5MPS7NegILL9kWqiInfY/CNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V6mF11Ejm/Arf2z1IGXrsofjOo28F5xGK/AbbBdYy4=;
 b=Et73mpzOgW4rDqbHPLk3NwYWbDx/3ZXHraTL+5PpUNZMH8VeTH6I8B0pVekoIZj2xR6fV+x4k6U5X+vpYGjExLk5U2lKXO+TA1Z91L8TojoBsnngfKVPEX6JydPbYdf1EZOykzzFNtvqg/xsB/TMLrKc6MfXZwARgfpT6o/VGxH696QKzV/artYXjy12LAMgoWup7p9badsILvDw/papAFBO7iCMltlYIN6Zee5Vu2o6QfwnLtbxr3xYjnkNzyVG/IX01qaUdBkH9eVQu2+iOaZdN1iAtGXOUEmPrkR3MNH2ETEjzYLBdN+5GN9uqDP+vT4QGN0MUH/jqz8qgCL30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V6mF11Ejm/Arf2z1IGXrsofjOo28F5xGK/AbbBdYy4=;
 b=FL0eu0SA/DfaccpdczMbBCbJYgg6vC07VYZLttOqoGBLqZmvegmvUfVPAJ5go5JYpHXsyao9KCXVZPtXsYLRrB7rO9JofRWFBp+/VkqWXFfj+eNmfdX2UQD3ZDraaZu/efXYZD0rxBjY4OGAp7hmU0tQUAsFvhaNQBLt+JVNMpA=
Received: from DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 05:49:56 +0000
Received: from DM6PR12MB4153.namprd12.prod.outlook.com
 ([fe80::af01:5050:9f23:e1f7]) by DM6PR12MB4153.namprd12.prod.outlook.com
 ([fe80::af01:5050:9f23:e1f7%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:49:55 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix Null pointer dereference error in
 amdgpu_device_recover_vram
Thread-Topic: [PATCH] drm/amdgpu: fix Null pointer dereference error in
 amdgpu_device_recover_vram
Thread-Index: AQHZkl7UvwyBOmxP1ke7X5WDacaAm69z4oRg
Date: Wed, 31 May 2023 05:49:55 +0000
Message-ID: <DM6PR12MB4153EB43AFFC6EDF82FB55C3FE489@DM6PR12MB4153.namprd12.prod.outlook.com>
References: <20230529185312.49427-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230529185312.49427-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7b11445a-110e-494c-b5dc-b1a3e01e8b12;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-31T05:49:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4153:EE_|CY8PR12MB8215:EE_
x-ms-office365-filtering-correlation-id: f843c80c-f3ea-4c80-7561-08db619adca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7gVsmtxijWl1IRV0rqtJOnnvdBkhmcLwdTMuilF1Qm6zsXgG/dINUmdxji00r64459jqJt4AO2l9cc6Jz/Uan4EqCz4k2vgSV9T3iAHpFKj/L9R04ITjx8KWf8ODYdTtxTVpttnaq78jtrdL/2/4n4yWAWX/VDqb24pzpMbu/kcfc1AdcDftD06jS3bDTfTbGxjYGAWQxJ159x49dTO86m6Tbz7cCEtbAgXaUxb+xlG+6UIRabJmDGYyt2oPcWFS0rufoF99lWPOWDnVCRW22og4PNj7weXE+3TqAxn4+XJcQsoy/BKE4kpBCP1BUyRz7OeNjC501aPvEMbIFGG1t9mexYpxCONUTHZD3srHtom+ItQv2LOaOyEG22hhqWKijbKSS3kvzpeWGdcbQbT0NtYo9JtgU2NH/z9jxI78sxRbFQ1ZWTukDeyB6ciu8u/U/ZXn74Ycnnay6eAMn5iOi1DR9YhocSzIsil9dq8cWLomlRyEsa3CNRmyo6kKMEKBElf3YnqxUxKf8gOnFaztrKxqvUPZvf8WUP/zytMNqNf6+7MEJ3HPtgYWPquswk3ddAOxShbsDQcpCAFd+GsrfJnR0oe4iewf+OVMJFfevmTW7xo9BvtJ9yrPJJCtWBFp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4153.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(7696005)(71200400001)(478600001)(33656002)(186003)(26005)(6506007)(53546011)(9686003)(83380400001)(38100700002)(38070700005)(86362001)(122000001)(55016003)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(52536014)(8936002)(8676002)(5660300002)(2906002)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iEbURT1ikHs+lo+x9Hr1gvVZaeEZiqPguxpsoVFLXYLYWJacgFZH4BXkgmyt?=
 =?us-ascii?Q?C10QhoNlcrx6n2hX6jVU1Te6dVuIDT12Pxw7btjhBnUB3dp+FiVosCKUk36t?=
 =?us-ascii?Q?p3K+S/4jqY5ijkWEzxEhE5szTCL+/DN5NIttrseHvrF6HAROqPNXhvYIDytL?=
 =?us-ascii?Q?FOcGSgJJ7DhH+e6aatjAcrNLml0Hry7y/E9VCsNgcXvgbFd014xu7wPa1Vge?=
 =?us-ascii?Q?r0vcNHQwgjP+6ZgTJGk7kXbXlHmMmXBNaIxA+fmhasQLL4f2xhKUxPk2lAPG?=
 =?us-ascii?Q?w+/lXZgtkMhMDsUqle0ufxa5wuQcBM4g+uZWkP2E5MeImR9MWCyVeZNLEIbp?=
 =?us-ascii?Q?cUCgsRmSOZxkRp3dzvZwDRq/xU2zY7JImgRXENc+tlt6vhVK4cjCVhHFrSFb?=
 =?us-ascii?Q?F7o+60YVPTLct/Him0TNBJKBTlJ4xbsmJBy9NK5Z8sTgc1pg9gCVsbj1NABu?=
 =?us-ascii?Q?VNBs7gxn6aGysqEIx27+G7AyTEp+lEmVsTtBune5d0lylLKd41MUA8LWR4r4?=
 =?us-ascii?Q?/GmI+5kUvZDTkP/LtwW0m3d5MkXiLKiHhHuZr47U5zMAjT273jLy+UiT/GTP?=
 =?us-ascii?Q?/uwTVZ8MmrOFhT+kudAU89uhWF2hH9IyrLXpCndTl7e28JOVU1l+a4NMmdRT?=
 =?us-ascii?Q?0z0Rx/AljzwimHv4Ffsno618Kn3qA4K29ZpeiUKiYtH75eQ3gwFKV14p/h8T?=
 =?us-ascii?Q?8I1zUY6CdbGUBl6OH3CXE/Jl4Zf/DLhd9cEjf2t8vw8tSlFJt9rdu5zN8ZrP?=
 =?us-ascii?Q?BtSl7UU/7MZs8/uUPBOYWdRrDWACw0CQo8QieQWwpeZqvJEn5oRlA2cvT5RW?=
 =?us-ascii?Q?I7+DwZQRNl0i92SkrwdeWHKf+nyLajGNHQS7uJuhIFTXUVHILlbfjgWV4NFQ?=
 =?us-ascii?Q?W8Ge1OYCTD7UIK2VV9oAnV6LHSNRXvCO9N9EAojhksU6cE6OVvi8jKJu16x1?=
 =?us-ascii?Q?QroXiIv157TdkD73izjv1hk625RSVWO7p56c+FOVS/o6mM+tAbIoawBYgiGl?=
 =?us-ascii?Q?8jP67KT/lcbDS5ZeI3+SAD5qcI79MXLC1hn2hO3Oj1j44whKhhzwuPfuMbQo?=
 =?us-ascii?Q?h1psEWPhMzs0SYkv3EksRk3GjCdb1vA1nA1bS7dji64jT4KT2D2dPSb4Mip2?=
 =?us-ascii?Q?eVT+VXn/O7TROSG28MLDvfbmb6jOId/iyx3SGrLSpKMddfc0khjVF2GWIjw9?=
 =?us-ascii?Q?YUzVwq95N0gAa1/OkJTHlITxAwvWM9IMcJTeQDgxO6BvuDwf/MZNVoG5Llc6?=
 =?us-ascii?Q?t9iEE+AQH46/B0v9MxqklJ1VTyNJE9/8gqM7yHxK9RT3vJUQnS6+M3Fh4uel?=
 =?us-ascii?Q?gaIm2xcAVF7ZDASO9WUpcg7kJ7io5/Ee9HmyxRUBDGlixM51GKYPF6qn91LM?=
 =?us-ascii?Q?XbzClcRfD1+ryrc19OYTbMJeqOFnhuBVQNIfe7fhuN6NyrGYsGEeSCXem9xy?=
 =?us-ascii?Q?o86b/akkrrV0olFIK9Nih5ByY6JiR0/hmAEVcbRssEopaLz6sXeeMIpyoPij?=
 =?us-ascii?Q?FDf97jKfPEajBVOAvGwKzfI0GMNE9GSH/2oYpjoACgh4PD5h4B9mPwrt5a5D?=
 =?us-ascii?Q?c1rPtZND4tU4mSyGPqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4153.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f843c80c-f3ea-4c80-7561-08db619adca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:49:55.7371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucvHIsfGt+40RQUKz5U06miLQXhupWbLyjM9yYwb8cqX7AGaF1148NlgNRptPJ+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Zhang,
 Horatio" <Hongkun.Zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: Horatio Zhang <Hongkun.Zhang@amd.com>
Sent: Tuesday, May 30, 2023 2:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yao, Longlong <Longlong.Yao@amd.com>; Z=
hang, Horatio <Hongkun.Zhang@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: fix Null pointer dereference error in amdgpu_d=
evice_recover_vram

Use the function of amdgpu_bo_vm_destroy to handle the resource release of =
shadow bo. During the amdgpu_mes_self_test, shadow bo released, but
vmbo->shadow_list was not, which caused a null pointer reference error
in amdgpu_device_recover_vram when GPU reset.

Fixes: cd7050908070 ("drm/amdgpu: Fix vram recover doesn't work after whole=
 GPU reset (v2)")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++------  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c  |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 46f249912b67..4e46f8f1b3de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -79,9 +79,10 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_obj=
ect *tbo)  static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo) =
 {
        struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
-       struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo);
+       struct amdgpu_bo *shadow_bo =3D ttm_to_amdgpu_bo(tbo), *bo;
        struct amdgpu_bo_vm *vmbo;

+       bo =3D shadow_bo->parent;
        vmbo =3D to_amdgpu_bo_vm(bo);
        /* in case amdgpu_device_recover_vram got NULL of bo->parent */
        if (!list_empty(&vmbo->shadow_list)) { @@ -711,11 +712,6 @@ int amd=
gpu_bo_create_vm(struct amdgpu_device *adev,
                return r;

        *vmbo_ptr =3D to_amdgpu_bo_vm(bo_ptr);
-       INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
-       /* Set destroy callback to amdgpu_bo_vm_destroy after vmbo->shadow_=
list
-        * is initialized.
-        */
-       bo_ptr->tbo.destroy =3D &amdgpu_bo_vm_destroy;
        return r;
 }

@@ -732,6 +728,8 @@ void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *=
vmbo)

        mutex_lock(&adev->shadow_list_lock);
        list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
+       vmbo->shadow->parent =3D amdgpu_bo_ref(&vmbo->bo);
+       vmbo->shadow->tbo.destroy =3D &amdgpu_bo_vm_destroy;
        mutex_unlock(&adev->shadow_list_lock);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index cc3b1b596e56..dea1a64be44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -573,7 +573,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
                return r;
        }

-       (*vmbo)->shadow->parent =3D amdgpu_bo_ref(bo);
        amdgpu_bo_add_to_shadow_list(*vmbo);

        return 0;
--
2.34.1

