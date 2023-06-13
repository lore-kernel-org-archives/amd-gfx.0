Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E6DC7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 12:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD77010E239;
	Tue, 13 Jun 2023 12:40:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B3810E239
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 12:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Inr7qENrXKtnl6GFWHI6hUOv5VnziHgUxYS0FEUmqk+f8WevbysumlndQK04PjlGZohLLeJMTqNR74y1DSK2Rvodf/N9uLBKW2F4meWkH46V0WlYaElurQ4WxGa84qnCrtuY2muBYGwiwZfks43eBqa26YXJKagskgyfPObXyBT4f2XvGBXVA8Xa6Y+93rYrRmzoAe113oAgvAPRS5H/3CjIwP2h5jQlhTvMieWCiCKvn+shhT3DBWak83PBDEbEkyR7yV6hAzFAnT5hPkpAv//0ohDB1e1DUylrgFdXs0SzD6ye3U0ATSRELaSjO+hl+ahFuwyqHnzRQRlghcnFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1XutuQecFyc0NjBFa/K/y1CaemBkMh6OMNPtwTLY4s=;
 b=NmodXTQKPIPGHlAWOpy5MTx9OMebpVwCuIELEJG5epEwW8aGyEukZBZYDajf3CkBQYzHDyz8+UmFRff9mv9DK2M/IvMK/LwDxpcXkTBB1CSYk/lOTcZ5XwD0dYFemY5GFlNiV7JmkfV5VhVJDS7TAmoszPTZQ9SccPY3pnKrpdxO1PtIJqU0a7V2bRhqhsvTwDGnQ3MyyXaI5us8spaOJzkXP+gZER27ig5Cqa4KNYjzeCMHQfHaoPEz6ycCZg7xQXN/rEmTpx27Nt/U1Q8pEr8ZYhisE+BiPuhvp/+VClHqGs/rKlIgpUXe5rXPVPCj4xG+cv7FeBaUrrHcBk/aKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1XutuQecFyc0NjBFa/K/y1CaemBkMh6OMNPtwTLY4s=;
 b=D9oAVChpaniZ3djOU4noTxUAzl1AEdRpSktnu4aqmJyXLz+VV34seo08H5v3gTfokZLTp0GFvQikyp37haHqEUkroMtsLwXM16qHeLyCeSKIBdFfbCcS6soKS44m+UEmLPD4ZZsRacBjE1wDbgy67r0QgY8mR79mOxlZ6py+TOo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 12:40:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 12:40:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/3] drm/amdgpu: Use PSP FW API for partition switch
Thread-Topic: [PATCH v2 2/3] drm/amdgpu: Use PSP FW API for partition switch
Thread-Index: AQHZneauzbKAU012JEyjE9UQDuGiea+IrKxg
Date: Tue, 13 Jun 2023 12:40:51 +0000
Message-ID: <BN9PR12MB5257BFFB33DCF4767E44514BFC55A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230613110256.1562271-1-lijo.lazar@amd.com>
 <20230613110256.1562271-2-lijo.lazar@amd.com>
In-Reply-To: <20230613110256.1562271-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=afd15721-72ed-4288-92e0-771960c71582;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T12:40:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB8529:EE_
x-ms-office365-filtering-correlation-id: 08983dd6-1417-4927-b6e3-08db6c0b6bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vdmJyUsDbbak/4YdQlXELZx8RickuyOELQojeXBmnszf9F4b2rJXOKCpaH2pBbp9n0nEF3FEpG0VsYn0q47yvnmSLGmRk8ClMbK025hx2hvE29waPKw5LCaDskXs8oFTmzsfmSfNseNX3Kjc7oAdQ203WIRLseanf0edeIbsE4BIGn+DE6woSzj9ESx15m7pvO9gniax+myBLEg6V5aUc9Sca/sBvlTx4iIRFnnzPJWUDy8doyTF4ku5OV1vvBv5PMzw6pORMrtWRgVZyvQDVQ6z7DiLPBSKW4PNwbk5x0UJgmYja92N1wf3TfwtuzaH5JYXuYC/H/c1L+7VuElnu7VMbSpuNdEQfBX3IprmEiOGi1GLXqd9ti4D9iEmJ2lnncIjEi/ZthHzQOjN6yPOCAgubuTsebdkHKiAhFtm18tgkmfN5G0lqVFXrdy0CJ9bnLeZvLhY9HYQQwzDQGAi7kXZzywVe0KAqI8/SAj0zJKRATW1SyYtF6Bo/KNf9895S8t242whPddlhGgvKRGgG3+ZHrgHDI/ci0OpxpR7JyTcKpGpmkK7WGPoqDUpZxJbhP9oAPp8UbLUbHsnoG6baO0d0oY34WLwz+CI+0iSXYw9WVFxYLuSVl7jH3861gx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(54906003)(5660300002)(110136005)(66556008)(4326008)(8676002)(52536014)(316002)(66946007)(41300700001)(8936002)(186003)(2906002)(66446008)(71200400001)(64756008)(478600001)(76116006)(66476007)(7696005)(6506007)(122000001)(33656002)(53546011)(26005)(55016003)(83380400001)(9686003)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVmayzE6DOxoHioliJqTgkTvfSZGxubGLWSsl5y/RJTSN924CkJOLKJvM5Jk?=
 =?us-ascii?Q?/I4mudKCxTJNSq60R8azH08E/a9BXkF+IgvYSuKrNYT85QEPlCRA7tsJthBM?=
 =?us-ascii?Q?4TSfP18SjNJudr/7tLrOvsI/62/gW/yMp5PTMDhpeUetVJU6pROJk+06RLCb?=
 =?us-ascii?Q?JjxUffh1wsYKHLEYyxEBEEfbgFqhMfcsFGuxMzjjzcFOf+TJmbTYaczMAhsp?=
 =?us-ascii?Q?TrrPW3wgWNiyYPVGf53qiZY5E+lZqUv1e+5Mb3JsOccxvBkoYTaAMC9HNDQB?=
 =?us-ascii?Q?x8cIMdBOW41K1ermsAamg+mdfZwdUZaygSR0UUwPjiwelcdY8LSt2Kn/Fpjl?=
 =?us-ascii?Q?pyEzXWukkZxsSm/23X3SZaKIw/nUfzW5vayyZ2/1B7vuEGQ7hJFHCKMBg6Xn?=
 =?us-ascii?Q?njokJUHFPOoknrB+ngi2eG1HY5nPdg85oxbn1YaGQzcMcv3lZeVTLkp4+Gpl?=
 =?us-ascii?Q?vqQVjXsn+sYcOlimUTbgsD00WHPKri33S+AfYrORquvjamAKqTLk5YCNjGDZ?=
 =?us-ascii?Q?WO5OMzQWXsD56ddgpLIUtfUSzF/hO0g8qDk8Omn6hH3WU192tzHhVH6KfEB5?=
 =?us-ascii?Q?Jw1Q6UQpdgZn0+YprmBwwe+pZ9oRJFuyY3rGMkwK7aT7xFeQr94Z/mHKSreE?=
 =?us-ascii?Q?wwtExoCPZcEsaA241uj84Rr3a0BY+Rp49ykwsBmUaw+KjCY1mBrHz3PMdZzT?=
 =?us-ascii?Q?Xi+r7/uTWMlXaQiQpyGN3FhA5NMaVgTYAKbLja7fmm560WUSOl2il4cWO1hF?=
 =?us-ascii?Q?55vty20vCf7SjPEgkDcTWRFRTdSVauktZZUxFtHpWB79sduSTG/ul8Yc03hb?=
 =?us-ascii?Q?wibY4tQRYQ+B5vOnE48knkw9xcsn5CXw9y8gw6sTqIH6cRt2bRnJKOQ+Ee6Z?=
 =?us-ascii?Q?6qzThmqtmaRvw0pHvmZpWOnhEd+e24WQTV9i93D/AysCsDojfBGYVFoIeHm7?=
 =?us-ascii?Q?hV0JNjXBE4P6evTzmMjDqfs8EV87+rSfhKZfkgQwDbvET23XXZ3GMBlhdfyS?=
 =?us-ascii?Q?eisNkYBOzCuwvYCARgXRHmetOxsI9a+uhQPO9npoGRyCyIz5dKDtxRdVRjo7?=
 =?us-ascii?Q?xPFDXLWPqBzsoeQTnfFxkpqNzhg4zZ6blr/ZkM3vRI6eWB7N79SZvX9IZ21a?=
 =?us-ascii?Q?Qe6v26oTr5DNIkFK47l9kT80McXbtc7BqzLT/+swVYrR6gY4M+OH6ktcKeKj?=
 =?us-ascii?Q?O/4c3qovqplTYsLs0JroU8ke19BXg/ZnR3jEgckyoTQR8KspospfTi+UQlUg?=
 =?us-ascii?Q?8ErSpxIvKvJytB5ovpzbkrMWspX0+7fJpoRzYZg1yb9h2eWhrqE9N0KJUswy?=
 =?us-ascii?Q?fBmtg3KII+Q8Y4Xal3257WmCpmjA4hZOv/T06EHSqk1Tb2XprnaXZDLMvIT5?=
 =?us-ascii?Q?PhmWnYjVUrjg9XEMEwY2GddSaGpjimvUr8xi4HMVpTIcUm6Vbj1uyzveF8ln?=
 =?us-ascii?Q?JPDR4dzno52QDoIxE+R7UWmkdjv8BYroRYB+SeiQiHStZyYhbFgrq1SjGKAV?=
 =?us-ascii?Q?A/1V8n8ctf+qtpha7Hplqng00yCjh+QkbOhccZ9U3Q1Q+g5BPy82voMEKDCg?=
 =?us-ascii?Q?q4JLoy2S0jdC9Pq/E15ZamkDHmlntBnks024Fi13?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08983dd6-1417-4927-b6e3-08db6c0b6bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 12:40:51.4522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKITNISoADtrYEQ/x4zi1cgvMAFFkqJwrnobxsbWcz863w2e9p0bjXQovqdRSdfBJQ0+tRJXrklXI0bhI2Q+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, June 13, 2023 19:03
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Use PSP FW API for partition switch

Use PSP firmware interface for switching compute partitions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
        Changed the return value to int

 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        | 18 ++++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/=
gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a595bb958215..16471b81a1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -518,9 +518,6 @@ static int aqua_vanjaram_switch_partition_mode(struct a=
mdgpu_xcp_mgr *xcp_mgr,
                adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
                                                       num_xcc_per_xcp);

-       if (adev->nbio.funcs->set_compute_partition_mode)
-               adev->nbio.funcs->set_compute_partition_mode(adev, mode);
-
        /* Init info about new xcps */
        *num_xcps =3D num_xcc / num_xcc_per_xcp;
        amdgpu_xcp_init(xcp_mgr, *num_xcps, mode); diff --git a/drivers/gpu=
/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f5b8d3f388ff..c1ee54d4c3d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,22 +623,16 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu=
_device *adev,  static int gfx_v9_4_3_switch_compute_partition(struct amdgp=
u_device *adev,
                                                int num_xccs_per_xcp)
 {
-       int i, num_xcc;
-       u32 tmp =3D 0;
-
-       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       int ret;

-       for (i =3D 0; i < num_xcc; i++) {
-               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-                                   num_xccs_per_xcp);
-               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-                                   i % num_xccs_per_xcp);
-               WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL, tmp);
-       }
+       ret =3D psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mas=
k) /
+                                                       num_xccs_per_xcp);
+       if (ret)
+               return ret;

        adev->gfx.num_xcc_per_xcp =3D num_xccs_per_xcp;

-       return 0;
+       return ret;
 }

 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_no=
de)
--
2.25.1

