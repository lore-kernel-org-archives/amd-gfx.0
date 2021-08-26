Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0726C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B181E6108F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B181E6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394026E81B;
	Thu, 26 Aug 2021 12:15:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15DF6E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm53ThAJrYC72qxXkeUVUQnZuCCZqh0m5RHZmzjyCJgzOhR7SGvDsX+e0IgJ+w7npdSPocicctHHTajORZ8JhbwE+cxusPYD7c4xK7NgBk7qEiQ4mRTT9ZwFjLHMA4UZfiUGVQx5YCxGdLoNYMqKL6EeV29ZPwMx9q2ZmU96qtWZE8FMsOgvZhBQ8fpnDylaH/VlW9PdZcEUf3HVTI42hHxKeBoUe3qk1Bx4yyn40+gNw5EedDQ6pdu2S/6PowQZV1qLlHA0ldRqPaMvlWp7EIZRK/lVXbwdxLpyak/JsvrQJp0TnD64dzlZ0yXL40Xqq4HsElzwDQ+dymP5MmI28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwQhX2c1h+Y+eatoKcP0KnV2qBFy3tv0VxCsfOOE01k=;
 b=N3S3VE95JI6fhXNgPCag35LWQTs6g8d1xQVLY3NePEp3HcOAYtXJPfXDvQsMf3omEP0nbnnYMRmvGxMpnfhusq6HWvRRtYuITFxgOxPVbhcNhtLxEoEuTqN5VGA1CG8mkUKyvUBxGY35Bu1ukePwuVlc6/w7xZxkPmVABw+xmb7NfOiyG85PM06OGrT9gjzjI+lHy3CnCUTs6/SILFAgZ4xTDFZ0utA0iq/r5/UxUU0OqIKa2YaPsQQ7WFIcXBy8cY5Tq3RA0CYtzB4jNzMrX0Ps74tvwOqnFbuHEvOgbWVSdOCHcxzZs4/57nPTNYPQju3RXSnXF0uLNl5oC/OgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwQhX2c1h+Y+eatoKcP0KnV2qBFy3tv0VxCsfOOE01k=;
 b=L9rQj8BLJSWooP0ENWdnkjxgfFPMTTIkTkfNVMQmTAUEbI5NsR9QBvZKDEUHacnXU88nPAipOBebhqiJuWlCK+nyjBteEOZXWaXXmXHvUbzsM8Le0aAQjsEspRn8QUhutiDNPYGrgpE8zDi5mqJLYrWIY8ygFO3Pp7lKKw8OyKU=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 12:15:03 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be%2]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:15:03 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Topic: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Index: AQHXmdZuCB+yjCUtWE2SNVzYjE2lt6uFs3wAgAAARLc=
Date: Thu, 26 Aug 2021 12:15:03 +0000
Message-ID: <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
In-Reply-To: <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T12:15:02.660Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a41c2e2-5730-468b-7b6b-08d9688b222c
x-ms-traffictypediagnostic: DM6PR12MB4465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44659FABD689E5283EB44112F7C79@DM6PR12MB4465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldESyqgNiGonKlLWWEHKcfL7F33BakyaZ9QdWcjpOJRObY9DSvzebxPx/+NzUe6o7HarN+hHBTqixAntXmfgUw5Yeelc8Vyre/MqxBTyLHhfJ53lf8x9bvoLU/JiYCvC+gNpmvLrHYnLHNzA1fZJbwvcmBDlIdhdQYDK5CQWSJJ4gQRcVSDLRueqA04QfxPncmpssdN8ebF2gNxLCEdK+gPAOmETSXKEf1z5DQQpsJtNwwMtlNNY7aMh888kl1uLtGQHd6RopgNSIcXqk79j76ppZKZzfCHXkmZTJmGdDYp8ZcHo082hhppxZdnfpLnqqvJMCyJlG87U3oX8GO7mGckC03c9eE7uzme/diTK4BkLpzKIsGUINSlsawtT3Ke4inu1079XNtWEvaxBulpTbDg0vjyyvidNFCz96n3sfF2dURcbzuGtojNaxg/gVTAKMwI7JxUZmLD0fh86Hpwl060A52tKr7plqFeqNVsVPjFID7AIs8b8buQp/t1iSl75HBzCBKxCE5cPCr7wfmsVkoXkIQI6Xa55kHNJm6sS6VeT2tLgXtfw0fu3zIwoKduK6QuEwoPgaop0QoQpTniGeT7yF9lFnRW+wsZvxjQCZnaKMXRsfg7ySKG7i3yqJMPbQiUFomc/xkWxnNOrdb1/LwDlHG9X0ZAxZPPmsJDaqYFeRXNY3P5gFSSex5dpqQ8DjU525QwqIeYvIrj7XhWR4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(8676002)(86362001)(316002)(33656002)(38100700002)(478600001)(8936002)(110136005)(26005)(53546011)(7696005)(71200400001)(186003)(66946007)(91956017)(83380400001)(122000001)(2906002)(38070700005)(5660300002)(66476007)(55016002)(52536014)(9686003)(76116006)(66556008)(66446008)(6506007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?niyhraXIMzjphIkWqXNGAMSCGHnqqIzgH3ETtkgmnKY5ssxYBQtWTkxX5d?=
 =?iso-8859-1?Q?bia/ov3QSnpc/J24YYs7qsEV03uFshFpSpO0t8HWczkk9uhd1d28YYNGZa?=
 =?iso-8859-1?Q?/0rBl7IuP1t7eZgCfBVPvLAoKKMa6Am/Ed291aRKOsdBJLLLE3tHudP46k?=
 =?iso-8859-1?Q?nh24+qlKI1e/8U0oZdZc57p2Hieghu45igCUlgalgH5XrVw3Irc+wAW/Vt?=
 =?iso-8859-1?Q?h+WWbylgJtPiWw3M/gEUHvu4rVg3pte1DYAZE1jcQT60ap6377f1iPzXsv?=
 =?iso-8859-1?Q?m9okxlCbiXH1lUp5PapvnG29UwU4xnTGKIFNZXBg8/vhAsAlYMv+/qcow6?=
 =?iso-8859-1?Q?q1GR91fdrHoK7DU1JdCk20MMBMZd6tVd9dBEt9/csH0TNHtmgbPugqzTG2?=
 =?iso-8859-1?Q?gmryIr507xQcIqN+CsGoSXND1jgfW+PbEEJTwMwuG9c1xcH9Sdl9Ra8MHQ?=
 =?iso-8859-1?Q?fRLMkTZGIl/7abCYClm/Pi7yIpZvEcKGGoDPUxcCdlCm+t6NRuLAT2N1Pg?=
 =?iso-8859-1?Q?Kq7B7u9JYjZlqjZTIWv8YYNVdgMwpcnJQ5+vNnbdY/W6rPoMFzhjbIpMfw?=
 =?iso-8859-1?Q?e+D6SxpTbwUF1ozhiqjv52ivtBekDM9gKV1AHQQ48Uir4Yg8I2fQMmGTTw?=
 =?iso-8859-1?Q?Ec1SDyoTFUHAozqkTkzlnB6uSkkPTCQd7W6GdFtMyP45T/swtZlTcxfXtF?=
 =?iso-8859-1?Q?ZAePf37XQi96gIw/LdYZ3BH/YcODSAk7uQz1D47JAwhZRp4heu60QElQ+Q?=
 =?iso-8859-1?Q?KyKUqtzE/STlDFctZYdfsY1IPb4+MWKZmoo+Gfjk+Jk3oJDRD+f4jscENP?=
 =?iso-8859-1?Q?HHHYxHiLBvCEkA3EPVbDmzG6tA7cZwkImF89xHtfXuiPTC6pKS44OxR+Kb?=
 =?iso-8859-1?Q?2vwDvDxglelj4lMe5nprZVJUKLj0ygCRgm0eXuRS7prLvOFSUQteWizUsD?=
 =?iso-8859-1?Q?c9b28btPllwhkcItdvbw0kTNhmdV4thMFMfWMgqqEN1ZtJJnHWng4/9N1q?=
 =?iso-8859-1?Q?xLDrSYhPhMQVMp1mWHaEdHQo+kFvyXt5+1Jn0w7NboXlkDZ3Uz5KPTdsAb?=
 =?iso-8859-1?Q?Mp9VHuJT1tv+XK3kZDImT29oy73vUdIqNTzB3vpbWH9Galrv6bn9towIU3?=
 =?iso-8859-1?Q?kyciMQAqk1KqGAfU+m0nkeBZwOY9On1094g8JZ+RZxYYoferE70OAc5Wio?=
 =?iso-8859-1?Q?5lGcCyv98m5CH+a79NuvgZMA2VzOcgkENxti14RTgMmhzPF4MBenBjYH7+?=
 =?iso-8859-1?Q?6hWbXYPVke8/eku/aKd1avC4qtlt/tvrAOKRGCtjvQz/QJgfXipA6Lb8k1?=
 =?iso-8859-1?Q?VnUxvx0Icnq6ufeDYHme+FvvGZlu/YWx66fXq/8qfgKGbEA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a41c2e2-5730-468b-7b6b-08d9688b222c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 12:15:03.1180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2ob7e3MEiZr7m5g9ekB7+hCIqcMHV6fWNRVZMGMqNTkqoSprpaBGtBxBZTu8O8p3kwIT6aL6WXP3esvh7RNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

[AMD Official Use Only]

While umr uses this as a constant two-step dance that doesn't mean another =
user task couldn't misbehave.  Two threads firing read/write and IOCTL at t=
he same time could cause a lock imbalance.

As I remarked to Christian offline that's unlikely to happen since umr is t=
he only likely user of this it's still ideal to avoid potential race condit=
ions as a matter of correctness.

Tom

________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 26, 2021 08:12
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registe=
rs (v5)



On 8/25/2021 10:56 PM, Tom St Denis wrote:
> This new debugfs interface uses an IOCTL interface in order to pass
> along state information like SRBM and GRBM bank switching.  This
> new interface also allows a full 32-bit MMIO address range which
> the previous didn't.  With this new design we have room to grow
> the flexibility of the file as need be.
>
> (v2): Move read/write to .read/.write, fix style, add comment
>        for IOCTL data structure
>
> (v3): C style comments
>
> (v4): use u32 in struct and remove offset variable
>
> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>        instead of 0x3FF, use mutex for op/ioctl.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>   3 files changed, 201 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..87766fef0b1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -36,6 +36,7 @@
>   #include "amdgpu_rap.h"
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_fw_attestation.h"
> +#include "amdgpu_umr.h"
>
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>   {
> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct fil=
e *f, const char __user *buf,
>       return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, =
size, pos);
>   }
>
> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *f=
ile)
> +{
> +     struct amdgpu_debugfs_regs2_data *rd;
> +
> +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
> +     if (!rd)
> +             return -ENOMEM;
> +     rd->adev =3D file_inode(file)->i_private;
> +     file->private_data =3D rd;
> +     mutex_init(&rd->lock);
> +
> +     return 0;
> +}
> +
> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file=
 *file)
> +{
> +     kfree(file->private_data);
> +     return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf,=
 u32 offset, size_t size, int write_en)
> +{
> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
> +     struct amdgpu_device *adev =3D rd->adev;
> +     ssize_t result =3D 0;
> +     int r;
> +     uint32_t value;
> +
> +     if (size & 0x3 || offset & 0x3)
> +             return -EINVAL;
> +
> +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +     if (r < 0) {
> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +             return r;
> +     }
> +
> +     r =3D amdgpu_virt_enable_access_debugfs(adev);
> +     if (r < 0) {
> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +             return r;
> +     }
> +
> +     mutex_lock(&rd->lock);
> +
> +     if (rd->id.use_grbm) {
> +             if ((rd->id.grbm.sh !=3D 0xFFFFFFFF && rd->id.grbm.sh >=3D =
adev->gfx.config.max_sh_per_se) ||
> +                 (rd->id.grbm.se !=3D 0xFFFFFFFF && rd->id.grbm.se >=3D =
adev->gfx.config.max_shader_engines)) {
> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +                     amdgpu_virt_disable_access_debugfs(adev);
> +                     mutex_unlock(&rd->lock);
> +                     return -EINVAL;
> +             }
> +             mutex_lock(&adev->grbm_idx_mutex);
> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
> +                                                             rd->id.grbm=
.sh,
> +                                                             rd->id.grbm=
.instance);
> +     }
> +
> +     if (rd->id.use_srbm) {
> +             mutex_lock(&adev->srbm_mutex);
> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.sr=
bm.pipe,
> +                                                                     rd-=
>id.srbm.queue, rd->id.srbm.vmid);
> +     }
> +
> +     if (rd->id.pg_lock)
> +             mutex_lock(&adev->pm.mutex);
> +
> +     while (size) {
> +             if (!write_en) {
> +                     value =3D RREG32(offset >> 2);
> +                     r =3D put_user(value, (uint32_t *)buf);
> +             } else {
> +                     r =3D get_user(value, (uint32_t *)buf);
> +                     if (!r)
> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value);
> +             }
> +             if (r) {
> +                     result =3D r;
> +                     goto end;
> +             }
> +             offset +=3D 4;
> +             size -=3D 4;
> +             result +=3D 4;
> +             buf +=3D 4;
> +     }
> +end:
> +     if (rd->id.use_grbm) {
> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff);
> +             mutex_unlock(&adev->grbm_idx_mutex);
> +     }
> +
> +     if (rd->id.use_srbm) {
> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
> +             mutex_unlock(&adev->srbm_mutex);
> +     }
> +
> +     if (rd->id.pg_lock)
> +             mutex_unlock(&adev->pm.mutex);
> +
> +     mutex_unlock(&rd->lock);
> +
> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +
> +     amdgpu_virt_disable_access_debugfs(adev);
> +     return result;
> +}
> +
> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd,=
 unsigned long data)
> +{
> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
> +     int r;
> +
> +     switch (cmd) {
> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
> +             mutex_lock(&rd->lock);
> +             r =3D copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_=
iocdata *)data, sizeof rd->id);
> +             mutex_unlock(&rd->lock);

As this is a two-step read/write, I don't think there is any protection
offered by having this mutex.

Thanks,
Lijo

> +             return r ? -EINVAL : 0;
> +     default:
> +             return -EINVAL;
> +     }
> +     return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *bu=
f, size_t size, loff_t *pos)
> +{
> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __u=
ser *buf, size_t size, loff_t *pos)
> +{
> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1=
);
> +}
> +
>
>   /**
>    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct f=
ile *f, char __user *buf,
>       return result;
>   }
>
> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
> +     .read =3D amdgpu_debugfs_regs2_read,
> +     .write =3D amdgpu_debugfs_regs2_write,
> +     .open =3D amdgpu_debugfs_regs2_open,
> +     .release =3D amdgpu_debugfs_regs2_release,
> +     .llseek =3D default_llseek
> +};
> +
>   static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>       .owner =3D THIS_MODULE,
>       .read =3D amdgpu_debugfs_regs_read,
> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs_=
gfxoff_fops =3D {
>
>   static const struct file_operations *debugfs_regs[] =3D {
>       &amdgpu_debugfs_regs_fops,
> +     &amdgpu_debugfs_regs2_fops,
>       &amdgpu_debugfs_regs_didt_fops,
>       &amdgpu_debugfs_regs_pcie_fops,
>       &amdgpu_debugfs_regs_smc_fops,
> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[]=
 =3D {
>
>   static const char *debugfs_regs_names[] =3D {
>       "amdgpu_regs",
> +     "amdgpu_regs2",
>       "amdgpu_regs_didt",
>       "amdgpu_regs_pcie",
>       "amdgpu_regs_smc",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..6d4965b2d01e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -22,7 +22,6 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> -
>   /*
>    * Debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_umr.h
> new file mode 100644
> index 000000000000..919d9d401750
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/ioctl.h>
> +
> +/*
> + * MMIO debugfs IOCTL structure
> + */
> +struct amdgpu_debugfs_regs2_iocdata {
> +     __u32 use_srbm, use_grbm, pg_lock;
> +     struct {
> +             __u32 se, sh, instance;
> +     } grbm;
> +     struct {
> +             __u32 me, pipe, queue, vmid;
> +     } srbm;
> +};
> +
> +/*
> + * MMIO debugfs state data (per file* handle)
> + */
> +struct amdgpu_debugfs_regs2_data {
> +     struct amdgpu_device *adev;
> +     struct mutex lock;
> +     struct amdgpu_debugfs_regs2_iocdata id;
> +};
> +
> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
> +};
> +
> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_RE=
GS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>
