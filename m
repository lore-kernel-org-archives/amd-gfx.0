Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B6DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 10:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F0C10EE8A;
	Thu, 26 May 2022 10:26:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F033810EE8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 10:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYVkT2abb2U29Au74+K165xboaKkw6xsVM8k6yPFZ6ELN0BeUgZ0KPiR45U/J5nhTut6ZwyP5efNJnDUMiXQmyoelZbxcDaVbLpKMpgrYTO6EFYIUOdxxe79GkvCqz3L4dsu1aseZbTalgJ7TBd0dMfVrMVF9jRPO472TpfOtztukyNLdC/qO1Qp8xofCFRCDoBZPiPz81dVBvS9F6txzeqXGkea7CgTNS3cEi6d8N1UC9NqbfMvAN8vzx0obi+bp5C/hybc6JvTISbdbjmrQFGJqJ/PVQIbWmY0z9hePMuI3pqzuRK2vUd+fbkFkDpMNEPNHJ6cXem67SGGm8m3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amd1LOLC0Hd96I3mmwfFs92uPqc6dPFoOQHMPuWl98c=;
 b=U5vbAt1MpOPD2WBoAsK7kUzSHGj+Oia/TSwKan+ZrIxGDLKciHM6L6P97bKrmmxrIB58F43sJFi6g0YqQoeQRbWKxY94qUYNLIvS5WuBReEmrKQk14N78R9qVhTw2LkAPTMZgctbefPNDHD47+AXRqVd/fy2u0lYolpvQ5cn74xqeqoKV/Zw8iiSWuN5qCzRouh6kr92Gna1dUwb/PH5K1vO5DS1ExMMuL47i+gg0uWeT4zDFXqPERvEDe7CIinY9av0w5dIbe4wsiXbQCE/YrBJn4yGqx/vPckvnd3jlBwRS1wbrAPIsMCQcoogOb2W6ccLIduQQ043Z22VGamveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amd1LOLC0Hd96I3mmwfFs92uPqc6dPFoOQHMPuWl98c=;
 b=bPIogEGKbYO9Xue2o+1WhMJNXRJVG+4xVSjP9rNkddKr589sadH0YUMXm7jNbtgfqB3IIZbSiUUh48oTNBymTRNpz+n+cbS+7kRzFA+iiwELUlgqtSYuGklaO6l8JLuvNzzTsotGPXQWsHqUBj0V9ZS7ZlG/glabP/vPuJNMmIs=
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 by BN8PR12MB3284.namprd12.prod.outlook.com (2603:10b6:408:9a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 26 May
 2022 10:26:36 +0000
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::6dd5:94c7:fad:d037]) by SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::6dd5:94c7:fad:d037%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 10:26:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: adding device coredump support
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: adding device coredump support
Thread-Index: AQHYcOXe8iUraHvnPkKDwtmhaquVRq0w8eUq
Date: Thu, 26 May 2022 10:26:31 +0000
Message-ID: <CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
 <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
In-Reply-To: <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-26T10:26:20.780Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf55eebb-2171-4d5c-f3a6-08da3f023396
x-ms-traffictypediagnostic: BN8PR12MB3284:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3284A96AB6CC6403F3696D2C82D99@BN8PR12MB3284.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0V5dt+txGe+9qbDiWT3Z6OcYHUl8XMWi2ZlCBDm95FV+g6T1VbWSNHGZuIHqRNod1CjR7R5TLHtO35LYdpK7Y+wUbvax1sNsLLC9+DPQemBLpFMY1y2TkDytD+a0eQ/3P1cB8Bcb3TnVVGMjyv0yKsGJ+hhKzsrONBtIMN0Tg9EaFPVSovEZ7DyFK7IiXwJcTNM2ycpL3F+nX4bLaTK418i+tCzDXiTEUwTW+Gn59NXYTM2OWO9TnPv8VwVQ8G5Se7V2b9ng6vnyNDD+CEEpkjt0Q0QC9wINP/pVKhrQRWy91el2DnMhYSgtAx3DdKpOfjULLgGkT4SbpGZsqfnRqYkUZhs2Z27mWKcJrSAhlbTvBEpym2EltP3/6521+gohftazGtDexNsrNplnhjr1vz4JWm+la8SI9r5OTW2nBTnMRzidP7beLBz/S1r5Kk5hw0KC0Lrq+JpUKcvBY+p/Gl7lzpQp9E/bRW51mh7HOk2yzmqiy9lED3Oievxcxi/jVp3GqqeY9COiePMcGpz7gyOR6HdnBz6RmFTkblsC9dHowtlCMkF/QjOyknV1UWd+nVvFljpnJD0aZPwEefAdN/XFlQXuv8Iv6pFEHVNbQ1a7nYq7OK+coNr23eUYVJL9nWX6Wpi/F7f5fnG7821u5mOKIwkr2xv7qRkMh0IRMSDzjsGa/ZMdnjdokckkG3YJPHdJO/OTRhctm6zdNeKqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(316002)(508600001)(6512007)(9686003)(66476007)(26005)(54906003)(4326008)(86362001)(186003)(110136005)(19627405001)(91956017)(76116006)(6506007)(64756008)(38070700005)(6486002)(38100700002)(8936002)(66556008)(66446008)(53546011)(8676002)(66946007)(2906002)(71200400001)(5660300002)(33656002)(122000001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BPw3hIO86ZLV/shwo1swuIq0akNgZy71CrjCxvbns6kI1R/xndG8d4pVIk?=
 =?iso-8859-1?Q?yVG1MGBnKxNkBBvT2RJl+/To/WRKHmG+8D9icIDW95+NUSs7zXQCWMwBEX?=
 =?iso-8859-1?Q?h0GeWPwPkRNIc5dzeiW8LpnQmbeQ7KJMfBwtp+xF3z+I6aiRvV2izIb6wk?=
 =?iso-8859-1?Q?oG1vIFq+jUUwBrfirSxBBdPuIqbjuHIb1yk2fmbASrx/DGsHvwqIAmbo5+?=
 =?iso-8859-1?Q?LbzRhBxDNZWZdP0be3fg9pavPooyMbHVSuO50XYVd3qD2pNo3Gjw7d4smV?=
 =?iso-8859-1?Q?OhJubgvW7m4kQtrVbxsNlJkl7dxvlQ/T10adWVFzk3D78pHDsntpmH7pw2?=
 =?iso-8859-1?Q?gssOvlGzs8EZgLb6NsO0UEAVYiytovitUSYL2x6Y6gdLb2V5mgdk40u581?=
 =?iso-8859-1?Q?nM81x4tUkhqb7jcFnd4dMs4zJyYXbUMFD2ZYFp2tWXbk88K3huUVwxkdsB?=
 =?iso-8859-1?Q?jIihe5xLpIjxVvaMBZZvNBugt35x/J6oAdN5/ku9K+0/CszMKKn56lJnwh?=
 =?iso-8859-1?Q?G18fxgFYCPXZKK01mEwktgp7NVbBxDSqJo8wVKI/iU6D2HEspq9sf19+vD?=
 =?iso-8859-1?Q?3DttFuYSAW4MJpRiD8oHTyvE18bfAfotS1GbGsH8dBKOePh7ppn5vI1f5x?=
 =?iso-8859-1?Q?ikKFfjLqvXyx0ncVTHrIAW/V+rxIZhOemii5/moDVeZQReUEh8hvar8mQm?=
 =?iso-8859-1?Q?uLHAqO69Gd/2MBJjSfjMiP1wFlngSW75+VcBl7XeJmHG9PI1vNGXQl1bkX?=
 =?iso-8859-1?Q?tLt7jXRud1qxPxsdTg0Na5ZNW/6vp9WtUV1x+8IH3/cGAneTKfr6ZM2/No?=
 =?iso-8859-1?Q?kE6pXtAZegW4l0jDsqRNiQx4ucCHbW5ECun6aCaZlsJ49u/R7e5Dzl/VN6?=
 =?iso-8859-1?Q?oMCNTcWlmdQrQ7sXJCMS+SBY4vb2WfA0pHBvNVT8ErKky0idb/5VVzaM68?=
 =?iso-8859-1?Q?3KzeV8uajsX5t3LrNc+cNRRyRfrnYCph4olNiavul9de97+Uax+pdCCV8I?=
 =?iso-8859-1?Q?1CnPHB+JR4fYErw+qz9yt3jFxGygVuQUeDDP+zVSi8bdPMjuUkQa//sBBh?=
 =?iso-8859-1?Q?sOP1XAhkiukGRY4feoIr9Qzta0tSmdaJUdShkbWt5c2gS4t2nmAQYA5syr?=
 =?iso-8859-1?Q?BqqAvK7qbV4wJJJlI6OELijpyCDflO7anm1mTtts3Sh36F+qL4eZeARAoX?=
 =?iso-8859-1?Q?WJ2Xtz/Y4vfNE/tmu30xL4LtHktlt2LeaOJEWmVFGFDrBxuag3fkL2x5rG?=
 =?iso-8859-1?Q?QW5JpanmthbKCLkccPKPkI8/uaHpTYqa+RlDkCBtcp0r9XVi+kwkB7NBra?=
 =?iso-8859-1?Q?JIoa/F/mfPne8lo12UC3sxdNUH4mJ7c5HuWYkzDA0E6ZaV/Ef9MDgQU18W?=
 =?iso-8859-1?Q?VZF6esDLUwfWlwrveRMlSTtbswCv3d5MSrsMBeCcqY7ptdeCeMacf1CbTS?=
 =?iso-8859-1?Q?iBh/cDcSyw109ZkS/LTZsv5GvW5X63FRAHLcQ2y8OW8tHfGc/DzuT1t62r?=
 =?iso-8859-1?Q?z6eG9eW6lakPrn5JIH4mBXB3sDu4dOTyk5S+lOODgy+wiAS9qg2Tb70hN7?=
 =?iso-8859-1?Q?gkfXY4/cr/PThn/V1tXIp99d+iXvSUtLw8t9LDk4kwxZczisAngFoYjbkU?=
 =?iso-8859-1?Q?Jr3FYtgWWdreJuxTLf554cVvrw6jycsQzOc3thKakf335KD9+vfR6TJEje?=
 =?iso-8859-1?Q?vplrOnsdiu/YiofXpS7d0FBKTtV/KHurAUGlLebuU306qAGkIu7LDKtsML?=
 =?iso-8859-1?Q?9YuCL8oHxN74lb6os+3VrM/f2udaDZPZrRhT4fw4q42Saf?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473648915874B1A5D6C2A9C82D99CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf55eebb-2171-4d5c-f3a6-08da3f023396
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 10:26:31.4205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1x1MuxP9mxrr1GhMD9NnSnH6WoTe9s+xq7pSblQZjeFaqJTNvneynCho8ZoOT6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3284
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473648915874B1A5D6C2A9C82D99CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Somalapu=
ram Amaranath <Amaranath.Somalapuram@amd.com>
Sent: Thursday, May 26, 2022 5:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath =
<Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>; Sharma, Shashank <Shashank.Sharma@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: adding device coredump support

Added device coredump information:
- Kernel version
- Module
- Time
- VRAM status
- Guilty process name and PID
- GPU register dumps
v1 -> v2: Variable name change
v1 -> v2: NULL check
v1 -> v2: Code alignment
v1 -> v2: Adding dummy amdgpu_devcoredump_free
v1 -> v2: memset reset_task_info to zero

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index c79d9992b113..25a7b2c74928 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,9 @@ struct amdgpu_device {
         uint32_t                        *reset_dump_reg_list;
         uint32_t                        *reset_dump_reg_value;
         int                             num_regs;
+       struct amdgpu_task_info         reset_task_info;
+       bool                            reset_vram_lost;
+       struct timespec64               reset_time;

[kevin]:
the CONFIG_DEV_COREDUMP check is needed for above variable to avoid compile=
r warning when coredump feautre is not enabled.

         struct amdgpu_reset_domain      *reset_domain;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 866b4980a6fa..ca97afe5be63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/devcoredump.h>
+#include <generated/utsrelease.h>

 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -4734,6 +4736,62 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_devi=
ce *adev)
         return 0;
 }

+#ifdef CONFIG_DEV_COREDUMP
+static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
+               size_t count, void *data, size_t datalen)
+{
+       struct drm_printer p;
+       struct amdgpu_device *adev =3D data;
+       struct drm_print_iterator iter;
+       int i;
+
+       if (adev =3D=3D NULL)
+               return 0;
[kevin]:
 this check is not needed, because this private data is passed by our drive=
r as below:

       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
                       amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+
+       iter.data =3D buffer;
+       iter.offset =3D 0;
+       iter.start =3D offset;
+       iter.remain =3D count;
+
+       p =3D drm_coredump_printer(&iter);
+
+       drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+       drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+       drm_printf(&p, "module: " KBUILD_MODNAME "\n");
+       drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev-=
>reset_time.tv_nsec);
+       if (adev->reset_task_info.pid)
+               drm_printf(&p, "process_name: %s PID: %d\n",
+                          adev->reset_task_info.process_name,
+                          adev->reset_task_info.pid);
+
+       if (adev->reset_vram_lost)
+               drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+       if (adev->num_regs) {
+               drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\=
n");
+
+               for (i =3D 0; i < adev->num_regs; i++)
+                       drm_printf(&p, "0x%08x: 0x%08x\n",
+                                  adev->reset_dump_reg_list[i],
+                                  adev->reset_dump_reg_value[i]);
+       }
+
+       return count - iter.remain;
+}
+
+static void amdgpu_devcoredump_free(void *data)
+{
+}
+
+static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
+{
+       struct drm_device *dev =3D adev_to_drm(adev);
+
+       ktime_get_ts64(&adev->reset_time);
+       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+                       amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+}
+#endif
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
                          struct amdgpu_reset_context *reset_context)
 {
@@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                                         goto out;

                                 vram_lost =3D amdgpu_device_check_vram_los=
t(tmp_adev);
+#ifdef CONFIG_DEV_COREDUMP
+                               tmp_adev->reset_vram_lost =3D vram_lost;
+                               memset(&tmp_adev->reset_task_info, 0,
+                                               sizeof(tmp_adev->reset_task=
_info));
+                               if (reset_context->job && reset_context->jo=
b->vm)
+                                       tmp_adev->reset_task_info =3D
+                                               reset_context->job->vm->tas=
k_info;
+                               amdgpu_reset_capture_coredumpm(tmp_adev);
+#endif
                                 if (vram_lost) {
                                         DRM_INFO("VRAM is lost due to GPU =
reset!\n");
                                         amdgpu_inc_vram_lost(tmp_adev);
--
2.32.0


--_000_CO6PR12MB5473648915874B1A5D6C2A9C82D99CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Somalapuram Amaranath &lt;Ama=
ranath.Somalapuram@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 26, 2022 5:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapura=
m, Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;C=
hristian.Koenig@amd.com&gt;; Sharma, Shashank &lt;Shashank.Sharma@amd.com&g=
t;<br>
<b>Subject:</b> [PATCH v2 2/2] drm/amdgpu: adding device coredump support</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">Added device coredump information:<=
br>
- Kernel version<br>
- Module<br>
- Time<br>
- VRAM status<br>
- Guilty process name and PID<br>
- GPU register dumps<br>
v1 -&gt; v2: Variable name change<br>
v1 -&gt; v2: NULL check<br>
v1 -&gt; v2: Code alignment<br>
v1 -&gt; v2: Adding dummy amdgpu_devcoredump_free<br>
v1 -&gt; v2: memset reset_task_info to zero<br>
<br>
Signed-off-by: Somalapuram Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;<=
br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 +++++++++++++++++++++=
+<br>
&nbsp;2 files changed, 70 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index c79d9992b113..25a7b2c74928 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1044,6 +1044,9 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_=
regs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_task_info;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_vram_lost;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timespec64&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_time=
;</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof">the <span style=3D"background-color=
:rgb(255, 255, 255);display:inline !important">
CONFIG_DEV_COREDUMP check is needed for above variable to avoid compiler wa=
rning when coredump feautre is not enabled.</span><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_domain;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 866b4980a6fa..ca97afe5be63 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -32,6 +32,8 @@<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
&nbsp;#include &lt;linux/iommu.h&gt;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
+#include &lt;linux/devcoredump.h&gt;<br>
+#include &lt;generated/utsrelease.h&gt;<br>
&nbsp;<br>
&nbsp;#include &lt;drm/drm_atomic_helper.h&gt;<br>
&nbsp;#include &lt;drm/drm_probe_helper.h&gt;<br>
@@ -4734,6 +4736,62 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef CONFIG_DEV_COREDUMP<br>
+static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size_t count, void *data, size_t datalen)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_printer p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D data;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_print_iterator iter;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof">&nbsp;this check is not needed, bec=
ause this private data is passed by our driver as below:</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"background-color:rgb=
(255, 255, 255);display:inline !important">&nbsp; &nbsp; &nbsp; &nbsp;dev_c=
oredumpm(dev-&gt;dev, THIS_MODULE, adev, 0, GFP_KERNEL,</span><br style=3D"=
background-color:rgb(255, 255, 255)">
</div>
<div class=3D"PlainText elementToProof"><span style=3D"background-color:rgb=
(255, 255, 255);display:inline !important">&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_devcoredump_read,=
 amdgpu_devcoredump_free);</span><br>
</div>
<div class=3D"PlainText elementToProof">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.data =3D buffer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.offset =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.start =3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.remain =3D count;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p =3D drm_coredump_printer(&amp;iter)=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;**** AMDGPU =
Device Coredump ****\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;kernel: &quo=
t; UTS_RELEASE &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;module: &quo=
t; KBUILD_MODNAME &quot;\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;time: %lld.%=
09ld\n&quot;, adev-&gt;reset_time.tv_sec, adev-&gt;reset_time.tv_nsec);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_task_info.pid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_printf(&amp;p, &quot;process_name: %s PID: %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;reset_task_info.process_name,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;reset_task_info.pid);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_vram_lost)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_printf(&amp;p, &quot;VRAM is lost due to GPU reset!\n&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;num_regs) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_printf(&amp;p, &quot;AMDGPU register dumps:\nOffset:&nbsp;&n=
bsp;&nbsp;&nbsp; Value:\n&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_regs; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;=
p, &quot;0x%08x: 0x%08x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_l=
ist[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_v=
alue[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count - iter.remain;<br>
+}<br>
+<br>
+static void amdgpu_devcoredump_free(void *data)<br>
+{<br>
+}<br>
+<br>
+static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D adev_to_dr=
m(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_ts64(&amp;adev-&gt;reset_ti=
me);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_coredumpm(dev-&gt;dev, THIS_MODUL=
E, adev, 0, GFP_KERNEL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devcoredu=
mp_read, amdgpu_devcoredump_free);<br>
+}<br>
+#endif<br>
+<br>
&nbsp;int amdgpu_do_asic_reset(struct list_head *device_list_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct amdgpu_reset_context *reset_context)<br>
&nbsp;{<br>
@@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_lost =3D amdgpu_device_chec=
k_vram_lost(tmp_adev);<br>
+#ifdef CONFIG_DEV_COREDUMP<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_vram_lost =3D vram_lost;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;tmp_adev-&gt;reset_task_info, 0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(tmp_adev-&gt;re=
set_task_info));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;job &amp;&amp; reset_=
context-&gt;job-&gt;vm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp_adev-&gt;reset_task_info =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context-&gt;job-=
&gt;vm-&gt;task_info;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_capture_coredumpm(tmp_adev);<b=
r>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_lost) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VRAM is lost due to GPU reset!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_inc_vram_lost(tmp_adev);<br>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473648915874B1A5D6C2A9C82D99CO6PR12MB5473namp_--
