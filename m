Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4097C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7548610D1
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7548610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4AF6E2F2;
	Wed, 25 Aug 2021 15:07:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F396E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 15:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nftp0Afue2futLGikeUSpIVeL5Kw7uK8qIQ3dO0RmkzbgoOlKcXzbuUXudV6FwAI2rndxZICNvaDeR5L/ktuFDQ9t5SH8S+22JBzPEIIhDfy1RGUD9INgtfTpKYH5xrOP3HAk6L5eXHTiKkUHx2ghlGcBKYWmN6M8EEh/HJhr7u71YqqzhdYWQ6cEsrUDCiXfvPEgTtezq47hYjVLL8ZfmtUxdqZ3LZ/jwh79nG+SUdELVImKMFeynvv297eMS0vA9xz3BcETykF0ErSHjGy1gRnOgZjDzgl3k2HbtHFUKUjuEUN8oDLi+XmWkVRpBSy0AOIVjoJTXrH5U+QYBJsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8i6tussQ+SjKV81+j183LO/EvkJQM7Bp41awsa9OmI=;
 b=YwQ7FvZeFkvHXJN9JisBd5TtmC/YUZN7ekYTD9Tl5SUkkVqfk+6Vamhe3Rj6KKKXTy+zYlWfVvBt4PgZmsMg6NcJDPpMHTZQFzYBHRb03Pnd3GGrhU1NtsHUe4yH633E9ZkATq/fmW6cJo7BJFcvIL95nuXVNL2+gNQdnm4phb4BYD78PgsY+QMJkVrziFa/nPH9uC+vN6b7OMBS2wtY99maS9zLRRSZq4YSHRosd/gPTu/wnYgaxFtEpf+ek+d/Udjg/4tf8OFNC4XZ2MoT9ISifd+jie2vSIZIy0xDD0J4Vv/joNK94uHHy56Yst1j3jwFLvaKoZjzUAgXStUaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8i6tussQ+SjKV81+j183LO/EvkJQM7Bp41awsa9OmI=;
 b=j5HapFf2yzXN5BkLHI8aiCqRKAW4AqoERHumVfCkn7+JyuouYmZb+L6XDIi6xTMNnOIbfON9RJoIO+gYLCJ7FoOm6ByQoXxU7ahDq5FErD79ZseJyFtP8kzzHvLa4EwhJpfK8AaTdU+3Q+U/5xpJxW2hVnlOYBo0jE5Hj0/YlCA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 14:52:01 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 14:52:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v4)
Thread-Topic: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v4)
Thread-Index: AQHXmb+1Ofsshnl13UWTXVM7wHLgeauETZ5Z
Date: Wed, 25 Aug 2021 14:52:01 +0000
Message-ID: <BL1PR12MB51444BED5321A64323E4A36DF7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210825130926.230698-1-tom.stdenis@amd.com>
In-Reply-To: <20210825130926.230698-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-25T14:52:00.489Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9357dbe8-4696-4a26-5005-08d967d7e596
x-ms-traffictypediagnostic: BL1PR12MB5256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52566A7CFB05A46EA951FF81F7C69@BL1PR12MB5256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7ryRJxBZmiTwAmpxMOJEO1LOxueQQTFowEPzmP5vngZXmiMDlEfukKDYRLLYftKl8+j9BKYiS3J1+TyUUKVIb9v5wGJAZnoC8SB1myNJVt0RxEjqhJDQvIcDBGc7vUFUZQIR3jYQLi8PVFtHpfmVgKtKoqFXLP6j1NjW3SpvQWZesbawy1Yu8Ajz+PHgkOWr4pLppFPTmB6jmBlDQDaxO8dAIyGkByemVUSu2rbhR/B2hzVSeaTij3Wxf6C5tvy0AxaqvRBmH1YQ+44hcInDyXZK/l3GIX4DQGfjAvF5jPZXd27Uj0YNKof4SLf/dLt+6IFC94Z4DteiXnX2KK37r1icn5v8IijSh1GjgPhZ6yxE1FxhxB6Kgjpq9scZkPbPpLlG/i1lh8qA5htWhid21PaHqYy/xHZBDAnkQ1JWaaKiMXjzldIJAV9IZT+q4RPUnxc9m2s0kNchIl624HR3i6I3+eD02FP+ra6nDQPFEPn/EctILI33GSlqnj0kbRtbE+Xe/46GvV9Y59CBRcDEt1lIeSSNbXaYxaahIn05MOHUlMu023i0s8qPMeSmw8eyHsr8XHug3PHlp8cAxUL/FJ+uZzFJjBxd6Nzh9R9m60rVGYn17wJQaQxmeCWAaOEVnl28vqjwruHLFoN9C1Z0JGrkh1Zj9s4Y3ChL2SEVnZU764VUSTw4wwc0WeRpsnR99H5lciCcTN+0kFIuDnmzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(6506007)(66446008)(53546011)(86362001)(26005)(8676002)(66556008)(66476007)(76116006)(64756008)(66946007)(5660300002)(7696005)(316002)(19627405001)(83380400001)(122000001)(55016002)(2906002)(9686003)(38100700002)(38070700005)(33656002)(186003)(52536014)(71200400001)(478600001)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bKP65EanWAcZv1ba8qJR3dETBgOHOule5f6hQc2r5i0qN7exmsnKrsm1s1af?=
 =?us-ascii?Q?4bAkijZGJyCwUU8R7TcHoFKqU1D06vqDqPJCdiuaJUsSvJZCj5Xwzg/mXvmf?=
 =?us-ascii?Q?sMkds4iMb5GJTLPfdjJKBX2pFQX3rRWtqKzt/eLHsIszrpV52B/9dmXSQaxW?=
 =?us-ascii?Q?XmKj+wzX/tz8H7ZPATpa9MZU1jgDudU3eWa8ponj/0WIxSTvC7FGlREEomzK?=
 =?us-ascii?Q?Nt2qBE+PQBlwTwVa8LEhKafOIGkQ2QG9bZr/3YKNO+5+mDT9yRaKgbSagz7q?=
 =?us-ascii?Q?T4BO4Hj1KB0A9a2zhnEgb6X+Kinzd5MhZDpBqMLUvI/2Kg4347sU8znEx015?=
 =?us-ascii?Q?HtZP9A/NyFU362nMNX+5HbSjnxkMXv95ICdRUhbqkERwbcaLOJ7y+OnuIJz2?=
 =?us-ascii?Q?GTbTtkjqRKkT3a0ktTCYRVnXBY1rmQJ+eznDKULUcU3dFLCvBsFAivAcfXPc?=
 =?us-ascii?Q?0InccZBA0HMrJdFYdGZ5qIxRbJ+ahGcSuG1oFZvgZp50pM3BWJjkVN58ZWoJ?=
 =?us-ascii?Q?lmj14mWpHN7EEJyjaa2VcrGLJ3KHie5bEC1gEUvynijhDzRaY5J2XBIF6V8y?=
 =?us-ascii?Q?xpZyKP9/BfidRrRg267R4PQkt1M1gvjgTJOPU+69tjyNrZhy6CPZILP80xu/?=
 =?us-ascii?Q?0ob7AQNsxtocTZNe2Rj2B/3PBXLE9z17lOcJqpX+079B3V4Z7Ozwbe8Lwx79?=
 =?us-ascii?Q?Oe28CV8kUE99LYim17bL393KbY8/2/UhBp6RiZBJd39v+9zd2t9Cc0GGH6QB?=
 =?us-ascii?Q?x9BjgpmOpn4E7N2up7S5e9Yufp8jF9WiLFqzuxBprJoG7ZxyWnvPiGu3E3OO?=
 =?us-ascii?Q?JGY6l82EUW0Usex8I+N5ZT0Ed4cwXnyru2ACDWxeE8RPP2MTq/+L/9uoPZIq?=
 =?us-ascii?Q?J+2CY8rWAS0iGVm4C3Ug6MrxDHwsmX3Cz3xjpG8x3sjQ1Mra/lj85j44flKu?=
 =?us-ascii?Q?ZcSJ+a5mmTer4ZzkUZ+/HdvIm5xRO1fVPhuuGrmI9ynnigYrgrteEq53pN+N?=
 =?us-ascii?Q?dDH9gTOoQJbD/I/CweRreuCM5pSmIxNoJIw6p9bHPjCbUmJ0JpVuZhMmJJgB?=
 =?us-ascii?Q?pbM8fZgksGPZSLm32/UF1dNdpHF7qQr8jodpqaOxJB/ESDjOsd0oTHsB9v5L?=
 =?us-ascii?Q?09lU5HAdJpyVRH/j2z4EYGzo3oCm7JHQpqPbSvNJQNnF2rJGaCDauq1QyAtj?=
 =?us-ascii?Q?7TtjtigEOKAQFMguqIyzQuI1yjLr+XVpRh6KCoLOS+dLYoE7R/jAo4WmDiEk?=
 =?us-ascii?Q?83owIZSGHDnMNvF7y5XTgz1Q6Mo6GUlOQ1Yjko9JRzpg+wcqE+uyG9gbF/Tg?=
 =?us-ascii?Q?6WMpsKPkiFmwD6jKwu3s5+xv?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51444BED5321A64323E4A36DF7C69BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9357dbe8-4696-4a26-5005-08d967d7e596
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 14:52:01.6391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XroNPqPqls5kpNVNZFJErjj9iabJWeXySkdVzl0kmyJFS71EWnFdSK8bjC7CW37ltMJ7e5e0wlCFGfNsmDGXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
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

--_000_BL1PR12MB51444BED5321A64323E4A36DF7C69BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I think it would be good to put the IOCTL structures in their own header to=
 make it easier to share with umr.  No need to put it in uapi area though. =
 We also need a umr branch that utilizes this to upstream the changes.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Wednesday, August 25, 2021 9:09 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (=
v4)

This new debugfs interface uses an IOCTL interface in order to pass
along state information like SRBM and GRBM bank switching.  This
new interface also allows a full 32-bit MMIO address range which
the previous didn't.  With this new design we have room to grow
the flexibility of the file as need be.

(v2): Move read/write to .read/.write, fix style, add comment
      for IOCTL data structure

(v3): C style comments

(v4): use u32 in struct and remove offset variable

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 158 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  29 ++++
 2 files changed, 187 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 277128846dd1..6450f210f6c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -279,6 +279,152 @@ static ssize_t amdgpu_debugfs_regs_write(struct file =
*f, const char __user *buf,
         return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf,=
 size, pos);
 }

+static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *fil=
e)
+{
+       struct amdgpu_debugfs_regs2_data *rd;
+
+       rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
+       if (!rd)
+               return -ENOMEM;
+       rd->adev =3D file_inode(file)->i_private;
+       file->private_data =3D rd;
+
+       return 0;
+}
+
+static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *=
file)
+{
+       kfree(file->private_data);
+       return 0;
+}
+
+static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u=
32 offset, size_t size, int write_en)
+{
+       struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
+       struct amdgpu_device *adev =3D rd->adev;
+       ssize_t result =3D 0;
+       int r;
+       uint32_t value;
+
+       if (size & 0x3 || offset & 0x3)
+               return -EINVAL;
+
+       if (rd->id.use_grbm) {
+               if (rd->id.grbm.se =3D=3D 0x3FF)
+                       rd->id.grbm.se =3D 0xFFFFFFFF;
+               if (rd->id.grbm.sh =3D=3D 0x3FF)
+                       rd->id.grbm.sh =3D 0xFFFFFFFF;
+               if (rd->id.grbm.instance =3D=3D 0x3FF)
+                       rd->id.grbm.instance =3D 0xFFFFFFFF;
+       }
+
+       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
+       if (r < 0) {
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return r;
+       }
+
+       r =3D amdgpu_virt_enable_access_debugfs(adev);
+       if (r < 0) {
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return r;
+       }
+
+       if (rd->id.use_grbm) {
+               if ((rd->id.grbm.sh !=3D 0xFFFFFFFF && rd->id.grbm.sh >=3D =
adev->gfx.config.max_sh_per_se) ||
+                   (rd->id.grbm.se !=3D 0xFFFFFFFF && rd->id.grbm.se >=3D =
adev->gfx.config.max_shader_engines)) {
+                       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+                       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+                       amdgpu_virt_disable_access_debugfs(adev);
+                       return -EINVAL;
+               }
+               mutex_lock(&adev->grbm_idx_mutex);
+               amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
+                                                               rd->id.grbm=
.sh,
+                                                               rd->id.grbm=
.instance);
+       }
+
+       if (rd->id.use_srbm) {
+               mutex_lock(&adev->srbm_mutex);
+               amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.sr=
bm.pipe,
+                                                                       rd-=
>id.srbm.queue, rd->id.srbm.vmid);
+       }
+
+       if (rd->id.pg_lock)
+               mutex_lock(&adev->pm.mutex);
+
+       while (size) {
+               if (!write_en) {
+                       value =3D RREG32(offset >> 2);
+                       r =3D put_user(value, (uint32_t *)buf);
+               } else {
+                       r =3D get_user(value, (uint32_t *)buf);
+                       if (!r)
+                               amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value);
+               }
+               if (r) {
+                       result =3D r;
+                       goto end;
+               }
+               offset +=3D 4;
+               size -=3D 4;
+               result +=3D 4;
+               buf +=3D 4;
+       }
+end:
+       if (rd->id.use_grbm) {
+               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff);
+               mutex_unlock(&adev->grbm_idx_mutex);
+       }
+
+       if (rd->id.use_srbm) {
+               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
+               mutex_unlock(&adev->srbm_mutex);
+       }
+
+       if (rd->id.pg_lock)
+               mutex_unlock(&adev->pm.mutex);
+
+       /* in umr (the likely user of this) flags are set per file operatio=
n
+        * which means they're never "unset" explicitly.  To avoid breaking
+        * this convention we unset the flags after each operation
+        * flags are for a single call (need to be set for every read/write=
) */
+       rd->id.use_grbm =3D 0;
+       rd->id.use_srbm =3D 0;
+       rd->id.pg_lock  =3D 0;
+
+       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+       amdgpu_virt_disable_access_debugfs(adev);
+       return result;
+}
+
+static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, u=
nsigned long data)
+{
+       struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
+
+       switch (cmd) {
+       case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
+               if (copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_io=
cdata *)data, sizeof rd->id))
+                       return -EINVAL;
+               break;
+       default:
+               return -EINVAL;
+       }
+       return 0;
+}
+
+static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf,=
 size_t size, loff_t *pos)
+{
+       return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
+}
+
+static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __use=
r *buf, size_t size, loff_t *pos)
+{
+       return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1=
);
+}
+

 /**
  * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
@@ -1091,6 +1237,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct fil=
e *f, char __user *buf,
         return result;
 }

+static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
+       .owner =3D THIS_MODULE,
+       .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
+       .read =3D amdgpu_debugfs_regs2_read,
+       .write =3D amdgpu_debugfs_regs2_write,
+       .open =3D amdgpu_debugfs_regs2_open,
+       .release =3D amdgpu_debugfs_regs2_release,
+       .llseek =3D default_llseek
+};
+
 static const struct file_operations amdgpu_debugfs_regs_fops =3D {
         .owner =3D THIS_MODULE,
         .read =3D amdgpu_debugfs_regs_read,
@@ -1148,6 +1304,7 @@ static const struct file_operations amdgpu_debugfs_gf=
xoff_fops =3D {

 static const struct file_operations *debugfs_regs[] =3D {
         &amdgpu_debugfs_regs_fops,
+       &amdgpu_debugfs_regs2_fops,
         &amdgpu_debugfs_regs_didt_fops,
         &amdgpu_debugfs_regs_pcie_fops,
         &amdgpu_debugfs_regs_smc_fops,
@@ -1160,6 +1317,7 @@ static const struct file_operations *debugfs_regs[] =
=3D {

 static const char *debugfs_regs_names[] =3D {
         "amdgpu_regs",
+       "amdgpu_regs2",
         "amdgpu_regs_didt",
         "amdgpu_regs_pcie",
         "amdgpu_regs_smc",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.h
index 141a8474e24f..dcf20859c866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -22,6 +22,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/ioctl.h>
+#include <uapi/drm/amdgpu_drm.h>

 /*
  * Debugfs
@@ -38,3 +40,30 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *ade=
v);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
+
+/*
+ * MMIO debugfs IOCTL structure
+ */
+struct amdgpu_debugfs_regs2_iocdata {
+       __u32 use_srbm, use_grbm, pg_lock;
+       struct {
+               __u32 se, sh, instance;
+       } grbm;
+       struct {
+               __u32 me, pipe, queue, vmid;
+       } srbm;
+};
+
+/*
+ * MMIO debugfs state data (per file* handle)
+ */
+struct amdgpu_debugfs_regs2_data {
+       struct amdgpu_device *adev;
+       struct amdgpu_debugfs_regs2_iocdata id;
+};
+
+enum AMDGPU_DEBUGFS_REGS2_CMDS {
+       AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
+};
+
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS=
2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
--
2.31.1


--_000_BL1PR12MB51444BED5321A64323E4A36DF7C69BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think it would be good to put the IOCTL structures in their own header to=
 make it easier to share with umr.&nbsp; No need to put it in uapi area tho=
ugh.&nbsp; We also need a umr branch that utilizes this to upstream the cha=
nges.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 25, 2021 9:09 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO regi=
sters (v4)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This new debugfs interface uses an IOCTL interface=
 in order to pass<br>
along state information like SRBM and GRBM bank switching.&nbsp; This<br>
new interface also allows a full 32-bit MMIO address range which<br>
the previous didn't.&nbsp; With this new design we have room to grow<br>
the flexibility of the file as need be.<br>
<br>
(v2): Move read/write to .read/.write, fix style, add comment<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for IOCTL data structure<br>
<br>
(v3): C style comments<br>
<br>
(v4): use u32 in struct and remove offset variable<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 158 +++++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 29 ++++<br>
&nbsp;2 files changed, 187 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 277128846dd1..6450f210f6c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -279,6 +279,152 @@ static ssize_t amdgpu_debugfs_regs_write(struct file =
*f, const char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_proc=
ess_reg_op(false, f, (char __user *)buf, size, pos);<br>
&nbsp;}<br>
&nbsp;<br>
+static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *fil=
e)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_debugfs_regs2_data *rd;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd =3D kzalloc(sizeof *rd, GFP_KERNEL=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!rd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;adev =3D file_inode(file)-&gt;=
i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D rd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *=
file)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(file-&gt;private_data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u=
32 offset, size_t size, int write_en)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_debugfs_regs2_data *rd =
=3D f-&gt;private_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D rd-&gt=
;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t result =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &amp; 0x3 || offset &amp; 0x=
3)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.use_grbm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (rd-&gt;id.grbm.se =3D=3D 0x3FF)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.grbm.s=
e =3D 0xFFFFFFFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (rd-&gt;id.grbm.sh =3D=3D 0x3FF)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.grbm.s=
h =3D 0xFFFFFFFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (rd-&gt;id.grbm.instance =3D=3D 0x3FF)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.grbm.i=
nstance =3D 0xFFFFFFFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev_to_drm=
(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_enable_access_debug=
fs(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.use_grbm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((rd-&gt;id.grbm.sh !=3D 0xFFFFFFFF &amp;&amp; rd-&gt;id.grbm=
.sh &gt;=3D adev-&gt;gfx.config.max_sh_per_se) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rd-&gt;id.grbm.se !=3D 0xFFFFFFFF &amp;=
&amp; rd-&gt;id.grbm.se &gt;=3D adev-&gt;gfx.config.max_shader_engines)) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_=
last_busy(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_a=
utosuspend(adev_to_drm(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_disa=
ble_access_debugfs(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_select_se_sh(adev, rd-&gt;id.grbm.se,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
d-&gt;id.grbm.sh,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
d-&gt;id.grbm.instance);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.use_srbm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_select_me_pipe_q(adev, rd-&gt;id.srbm.me, rd-&gt;id.s=
rbm.pipe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.srbm.queue, rd-&gt=
;id.srbm.vmid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.pg_lock)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!write_en) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D RREG32=
(offset &gt;&gt; 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D put_user(v=
alue, (uint32_t *)buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D get_user(v=
alue, (uint32_t *)buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, offset &gt;&g=
t; 2, value);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D r;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset +=3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size -=3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result +=3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; buf +=3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+end:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.use_grbm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.use_srbm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rd-&gt;id.pg_lock)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in umr (the likely user of this) f=
lags are set per file operation<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which means they're never &qu=
ot;unset&quot; explicitly.&nbsp; To avoid breaking<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this convention we unset the =
flags after each operation<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * flags are for a single call (=
need to be set for every read/write) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.use_grbm =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.use_srbm =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd-&gt;id.pg_lock&nbsp; =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(adev_to_drm=
(adev)-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(adev_to_dr=
m(adev)-&gt;dev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_disable_access_debugfs(ad=
ev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
+}<br>
+<br>
+static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, u=
nsigned long data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_debugfs_regs2_data *rd =
=3D f-&gt;private_data;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (cmd) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_DEBUGFS_REGS2_IOC_SET_STA=
TE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (copy_from_user(&amp;rd-&gt;id, (struct amdgpu_debugfs_regs2_=
iocdata *)data, sizeof rd-&gt;id))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf,=
 size_t size, loff_t *pos)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_regs2_op(f, buf=
, *pos, size, 0);<br>
+}<br>
+<br>
+static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __use=
r *buf, size_t size, loff_t *pos)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_regs2_op(f, (ch=
ar __user *)buf, *pos, size, 1);<br>
+}<br>
+<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register<br>
@@ -1091,6 +1237,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct fil=
e *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
+static const struct file_operations amdgpu_debugfs_regs2_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unlocked_ioctl =3D amdgpu_debugfs_re=
gs2_ioctl,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_regs2_read,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write =3D amdgpu_debugfs_regs2_write=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D amdgpu_debugfs_regs2_open,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_debugfs_regs2_rel=
ease,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
+};<br>
+<br>
&nbsp;static const struct file_operations amdgpu_debugfs_regs_fops =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_r=
egs_read,<br>
@@ -1148,6 +1304,7 @@ static const struct file_operations amdgpu_debugfs_gf=
xoff_fops =3D {<br>
&nbsp;<br>
&nbsp;static const struct file_operations *debugfs_regs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_f=
ops,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs2_fops,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_d=
idt_fops,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_p=
cie_fops,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_s=
mc_fops,<br>
@@ -1160,6 +1317,7 @@ static const struct file_operations *debugfs_regs[] =
=3D {<br>
&nbsp;<br>
&nbsp;static const char *debugfs_regs_names[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs&quot;,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs2&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_didt&quo=
t;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_pcie&quo=
t;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_smc&quot=
;,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.h<br>
index 141a8474e24f..dcf20859c866 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
@@ -22,6 +22,8 @@<br>
&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&nbsp; *<br>
&nbsp; */<br>
+#include &lt;linux/ioctl.h&gt;<br>
+#include &lt;uapi/drm/amdgpu_drm.h&gt;<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * Debugfs<br>
@@ -38,3 +40,30 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *ade=
v);<br>
&nbsp;void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);<br>
+<br>
+/*<br>
+ * MMIO debugfs IOCTL structure<br>
+ */<br>
+struct amdgpu_debugfs_regs2_iocdata {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 use_srbm, use_grbm, pg_lock;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __u32 se, sh, instance;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } grbm;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __u32 me, pipe, queue, vmid;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } srbm;<br>
+};<br>
+<br>
+/*<br>
+ * MMIO debugfs state data (per file* handle)<br>
+ */<br>
+struct amdgpu_debugfs_regs2_data {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_debugfs_regs2_iocdata i=
d;<br>
+};<br>
+<br>
+enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D=
0,<br>
+};<br>
+<br>
+#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS=
2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51444BED5321A64323E4A36DF7C69BL1PR12MB5144namp_--
