Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F194EC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 11:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6445710E13F;
	Mon, 24 Apr 2023 11:28:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AF710E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 11:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWTtjqElf4u6BqMlqlwnVzJyJohsYsnQXBpZmDDIWjXu+NbnrKni21h97Napwsc5Z54q9EsSxb6c9mQk9a0yaHj1k9QuWeKs8RMlsAFhP4B3ztYx8SUPmiKaZUfU0Em0YBbKV2lJd1FlpoL6tw0IXeOZJOlNSasW+BzvVeEVFx6Jh2AORj45KTrhnTcOYvl3rpYPZxJyZynfjmeVytMFwnmsUm9qMWqQqyrnCpa1IDfm2qwDe8ytR8N0e+JMWoL7Yrp4iX6nYfDdC00DhmTqGUKEfTFHQEQiyFiaAciEy60JtYCN+LLHua+ioxZKI3sDz10PnjAJ5MX0f0Zagw8unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gBJO/cvLjlkDwabOUvXfgf/s40YTE+orRdRicuQmdY=;
 b=hlItoK66sxvEqVXIp4Jnqm39Uct1dYPmXHf8RIZlKYacEjSCFSFSTKJFVHu2gGZnswPhRnbzDTpM3/ERqUpZ/hjaRgHdq3htm46n3UMzd/F6HxgK9M+Z/En5+p6MHj0j7rim0tIFRxAL08FSCai77oU0GvY4axrz94FL0g+8GD6whYAnMpxF58nW4vc3LO6NPLV/YLOnJOuj50qqfzeBKSCDp8x9M9nLeyQY7dtXU6nsBGLAgcpUsoJUubj1NMnEW2dqNOwA0HsoW6kvof6XqQxT4N8QYXYkCqi99TNrXBM4l8psPGJF6hvVQtxp3TZihi1ov2WwCLjHf9Etv+lNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gBJO/cvLjlkDwabOUvXfgf/s40YTE+orRdRicuQmdY=;
 b=YMIQ2lE3Sn5IEG+ue5a89uxRyBUjaBv4cDaqLjoxIY/0rsjwcUkG5+CvX6004U4hzovi2bgrOwXSx4kyy2jZHHhF+4O2m2plwb5Qc0imQzLq0leIpgshCQPsj2n7TizmJYKbC8c0YiXfZP1tXN6vtqQA5wCVYon1nf4dIcxchN8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 11:28:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 11:28:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc
 hw_fini
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and
 gmc hw_fini
Thread-Index: AQHZdpjEGM0ccyQJ10mTkmmgxamiba86UKEg
Date: Mon, 24 Apr 2023 11:28:26 +0000
Message-ID: <BN9PR12MB525758042CF80D29449B0AB8FC679@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2f844e6f-5dee-447e-ac11-29e155c12978;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T11:21:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5101:EE_
x-ms-office365-filtering-correlation-id: 3ce022f2-9918-4d1c-34e0-08db44b705b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhoxpHlwnE5MKrQ2HjmDiLCrM3HCVK0TUe3Zyzpq59xQqXBmywdEhgIoUKAWm3y30S8EQszSJ4rVuN3EfrQUIo4N8jUW3MdyShm+/T9QQSgUww3XhKbnSR6zYu1dOODsuC2+ccgQsfhPpDxHszptoRsOsRcdXuFidxh8q6OHXXUxu6AE8DDH7/jUwB/f3wXOspmP/nW7nNZzb4M6G7958EQS5SiTGeTIxh7tERcx+9Do2lrJKviBTNmjx91mUA1CH7X12aTDjOAoxZJk70BQfP9jL3eCI1B82b6sSMVHl+/4kzNH/FvO0Mh9iW5oTKfq7zBhAItKGklUGwz42paFoPnqHKtpXEcyd7laC5rjVbId3ZuOnZYjTaFA4dL3YsS9D92qoPBGJ/WXpO4Nu2G8heao42XgHFNx2kcfXFoc50VIw1aVtb6bLKSXiyHaZNa7+D50BWR+If+QBKGBRrHb2JPmPhJutiIH15wPE7Q6OFBTzM7TzkVluc1CrWqxwUuLoJXoAXe4wyH5TJ6dGFSTODjWxen7L5IuzwR6zWSatM3S4WXxiFAw4xjQBWzbH0OQAfMld4VXitDB0Yox4D4Qlxq0z0ZvKVrsTjXFNq8m2+G2M3swIAJVmKQbg1s2i7G4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(186003)(38100700002)(122000001)(66946007)(478600001)(76116006)(86362001)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(54906003)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0cD2zoSpDBjRc4WkkYmhOFiv2QRs0edYpFhW1DJzJCkW6+u1rpTKy8mD5fY+?=
 =?us-ascii?Q?x2ALYg/xe3przacg5ihJ91NvdgkkmLUXxc2FCxsfjOusEfzpVHWgJiY33LRx?=
 =?us-ascii?Q?FD3SbOC7a4EKCan4mAVAOpXyCR3wRBXAfNfJhHxr+UoFJ4EMWeB1JK3k65zN?=
 =?us-ascii?Q?wKa5AbVxb54Vqeg7wAJ2OWMKSmXDfa9VgAnAY4Zfp5lInprbFgqryiiGYl7T?=
 =?us-ascii?Q?Fh7s27Bpw8kt9Ov/z72E3lOr7b7B+07bFc70dPcngcLGgPvefNJDssfrFWsl?=
 =?us-ascii?Q?g8plNc1II2lqW/S/lActFlUcREXZwrSbnUAWGz7PmJvl2x6g+A3Z2BMlyD3J?=
 =?us-ascii?Q?kTVvj7S04AEFN5Z+vmoGOa44WI3kHNziwfZLNK8u9r6p0blrfkC6IkUgwf0q?=
 =?us-ascii?Q?ygsv+vukK0sdCIxN3uO6J20Lu76hyeNgHeVyya5A5jHcumzID9Fk/aXN8m8H?=
 =?us-ascii?Q?kMWS2Wge/z9SsdwMAYs/hBvNPBQvCaa8tWxyL0Vu6GoCbuxwJ9blo9H6DVj6?=
 =?us-ascii?Q?ZSbF0d7U1eM/H3Z4PtqzeRMeT7/mTCwb3KEZqIDtGzXQoXM4SmHZoCcGuizg?=
 =?us-ascii?Q?Rm4slTnVT1saKYGdbsFJFJq5F44s5qERDZ8vRnWueut9DONRedZ7Ft1uMlbZ?=
 =?us-ascii?Q?9uJEiQC6KeNrGCw5gpOxC/6WE89buvUGw5AmuNGA0AjrwrrVS0pNXHWkRj3K?=
 =?us-ascii?Q?rqSG5kK/vUxNFyf1TMBEDvF2TzAq1Z0s1jNfKP8EoRYFpGFGu3FSxXxBndw0?=
 =?us-ascii?Q?Vj+Awyp0wFlal5xQVKsdWPc9pQnpVAJGYLJuI3jWIHP0oBLvs/U+rnyXTV7N?=
 =?us-ascii?Q?p80ZOqKsojio2LIgr56BzgIQCRbLmZjf79p6Clt6+ofkL/eJ6JabXjur7zRE?=
 =?us-ascii?Q?YCD1PiwzRtfIBaSdZZ99c8T++J4S9eppUuHYo0DDt7OpCuWuZzqEBX4H2vdL?=
 =?us-ascii?Q?u9ymuB9CfR21B+FMRunonk8vOSd8z4yC94QGK0K9WL+vl2OwGQgPGPP35wSU?=
 =?us-ascii?Q?rghkVp6BqzDFHpIUUnFlGsGfDYwI/xyGTGq0id87hsruaAQT5PL6wLBz2rDl?=
 =?us-ascii?Q?y/JBZitXRJG3WzsR5AljqZyCw3nhDMeJUCabP03k0fdxe+JuQmhFtaShofxp?=
 =?us-ascii?Q?5/DxJ+BuPnwyqgdQNcBTd5YeD2PiH4nD8E+ZwEgDWmr99B062xta1xbfery6?=
 =?us-ascii?Q?/chng9fw+ZfVQLnmJcmzURlC3DJ/ImO/GCj6/xibXXlkDDhnQE7Dx1VnfpiY?=
 =?us-ascii?Q?dTCQt2QETuEXEzXkYdL3tPXoT3rDakFqcXpr9JMmLuh2nFNdpf8NVeM2JlGc?=
 =?us-ascii?Q?S9K5ULCgbHXUyHNAQCPaxYQONKcMph2E8QR7b2Ve8s8CBN2DeTfMbA5H1Rpa?=
 =?us-ascii?Q?4/gm9HpoUjKzXs8HiQVWMAvbyubmOdkiwOZJMsT0gzjcohITfTMOFYOGdr1q?=
 =?us-ascii?Q?zmeLoBB2ptQjK5GRqfVS5BAtsje6fRjx+S5a+xQqXGAY94uNZT+EsCCwwOzz?=
 =?us-ascii?Q?7xg1+6O804/YduaPkEp/hE8OZe+M5OmJS/JuJdGH1WuzCNl6gWbv8UTQz/Fs?=
 =?us-ascii?Q?sD6/Q4U2B46LecS+R9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce022f2-9918-4d1c-34e0-08db44b705b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 11:28:26.8508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MY4Ad+fOrPC/7vpU5G9twNhbfus/0HoCXqXjNrI4xFPbf9EtGjibWn5K294pFAqLAjb27kfz/Iqa904soxRm+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Let's handle umc and gfx ras cases in separated patch.

gmc.ecc_irq maps to df mca interrupt, which is enabled by firmware per IFWI=
 setting. Check GFX RAS mask is not correct in such case. host driver is no=
t privileged to enable/disable the interrupt. As you noticed already the se=
t function is dummy one. then just drop amdgpu_irq_put call for gmc.ecc_irq=
 should be fine.

gfx.cp_ecc_error_irq is not used in gfx11. Feel free to retire the interrup=
t for gfx11 in another patch (i.e., gfx_v11_0_cp_ecc_error_irq_funcs is not=
 needed any more)

Regards,
Hawking

-----Original Message-----
From: Horatio Zhang <Hongkun.Zhang@amd.com>
Sent: Monday, April 24, 2023 18:37
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zha=
ng, Hawking <Hawking.Zhang@amd.com>; Yao, Longlong <Longlong.Yao@amd.com>; =
Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc =
hw_fini

The call trace occurred when the amdgpu is suspended before the mode1 reset=
. For the IP block that do not support ras features, the relevant interrupt=
 is not opened during initialization, but hw_fini forced the close of this =
interrupt, which resulted in amdgpu_irq_enabled check warning.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu] [  102.874019]  gfx_v=
11_0_suspend+0xe/0x20 [amdgpu] [  102.874072]  amdgpu_device_ip_suspend_pha=
se2+0x240/0x460 [amdgpu] [  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80=
 [amdgpu] [  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu] =
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu] [  102.=
874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu] [  102.874375]  proce=
ss_one_work+0x21f/0x3f0 [  102.874377]  worker_thread+0x200/0x3e0 [  102.87=
4378]  ? process_one_work+0x3f0/0x3f0 [  102.874379]  kthread+0xfd/0x130 [ =
 102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

[  102.980303] Call Trace:
[  102.980303]  <TASK>
[  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu] [  102.980357]  gmc_v1=
1_0_suspend+0xe/0x20 [amdgpu] [  102.980409]  amdgpu_device_ip_suspend_phas=
e2+0x240/0x460 [amdgpu] [  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 =
[amdgpu] [  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu] [=
  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu] [  102.9=
80687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu] [  102.980740]  proces=
s_one_work+0x21f/0x3f0 [  102.980741]  worker_thread+0x200/0x3e0 [  102.980=
742]  ? process_one_work+0x3f0/0x3f0 [  102.980743]  kthread+0xfd/0x130 [  =
102.980743]  ? kthread_complete_and_exit+0x20/0x20
[  102.980744]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu=
/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 543af07ff102..0f6b037558bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4483,7 +4483,8 @@ static int gfx_v11_0_hw_fini(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        int r;

-       amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+               amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 3828ca95899f..25f466c26d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -951,7 +951,8 @@ static int gmc_v11_0_hw_fini(void *handle)
                return 0;
        }

-       amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
        gmc_v11_0_gart_disable(adev);

--
2.34.1

