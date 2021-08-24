Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E148C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576A46135F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 576A46135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07FDC8986D;
	Tue, 24 Aug 2021 13:00:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5475B8986D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmiadk857ZY8FPZL99YCqEy0a6lDkoB2zp8lLEMjxKxPUyLYpAoGquozTOiN2nkBYj90qMaA/qoMBLqmTaUKg/lXizzHZJoMj+IKjxPKnCh5F4HDCtGUTgeZXtAsgii417DK9C//6mwDTd0ojfAKQBAzIoMOC1THIqRldIqK5iu6/mwi5XmYZvE6/m6zeH9HqsUqSnPpHy3V++DE9STWT4Ve5OG5qTkJeSTSIHo5XDWf3TrpHVS7qmWQrMOBif592UQU7YDaIX1yF9nZBF9c7MnpK6KCW8Bd2hxI9tgvGSvFZmZZIKJcxhNKMKNjHqlVIhGTuU6HCuGoM9XrVbSTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqxyznyinJi1AflyvILJn8nCBYFH9YGe/H7hFpLEM4Q=;
 b=fEzkkVIyGOwJxEQSgG6zuIylz5SJjdtQJOt1APjT48SLg1JSvwe3ZtwdaAYJVLSXoRP6cYUcI3J55gURSJNUIVlEJvKa3KbKV+6xssNCBzUIcr5c5cfAU9aACH0MpM/J5FhKuHirXED9n0gJ8OduZte3ujoqA7UGpLVhM7+Fh/skPa9OXSiXUal1ZLa+k+AVW/gvH9QfyOOSrXAd/IjmzEkeDAeAy4vTTSvlRMeLks9Zefxp3RrOWWDQnknmrMaJxDMzc69UT8mWf3lEr03Uwlrx6/BoQIDVJ0f97vh1e+tz/Qk+Vj7KCooI+DHFovVlJnMofkF8NU8IkvGItHoS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqxyznyinJi1AflyvILJn8nCBYFH9YGe/H7hFpLEM4Q=;
 b=g7LqGF4qkNyDo+aB6h7ZjlwDoyoyAe0sHnh59R/48ppoldYnpux+f2DMLvTjf4/BmO01/l7Y6MXccDq0WG59t+dQszbOJmVw2pg1aNFyqHGW9mc4xykXWcsntxCnHGIcI32T2LMBx5vBIN+pez8sJoAE7/X0v9mBTkqADuFijMg=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4793.namprd12.prod.outlook.com (2603:10b6:5:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 12:27:55 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be%2]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 12:27:55 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
Thread-Topic: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
Thread-Index: AQHXmOHj/zdgmkWZBUSoc1vVkrzhL6uCky6AgAABf4Y=
Date: Tue, 24 Aug 2021 12:27:55 +0000
Message-ID: <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210824121618.99839-1-tom.stdenis@amd.com>
 <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
In-Reply-To: <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T12:27:54.602Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305d8f60-be1e-4e37-0047-08d966fa99a1
x-ms-traffictypediagnostic: DM6PR12MB4793:
x-microsoft-antispam-prvs: <DM6PR12MB47934EA864D506A4072D8DC5F7C59@DM6PR12MB4793.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhOefl3RtBs2QcYCJ/f0NAUZwuMQucYR7jbou43bWQlPjuvratrTZtBN5UxPPCgKhIHWh/YmZ0MNeiN12kaHtKPxU0cG/LVI+mV9K/lzjqYMaq8eCzdx5ND56iDIBXmHw1hTDJSoJZV+nq++jDuMqn2lEIbzcki7IAFseKrFv/NPQgzsHdmsT/MqGiv7tW48eMi6JiCNMi8wZOD8bQMJzg8Hdz0ooPu/44szIJocSoG3/V7++F5rXSGH2QiaDNuPAmLXsYfSwJmv/E5erRFcfF2BB1hNVtGlr847Q7nPAtKPv7JXR3TXvpEmpciYZNf3TsEszhoCGl9Jspg+n8k0yTNu5uo9hwLKuzrHD/8PesoBqhZoTbLj176O0brnJg81mUFu9kxAK5teMS1WPOwK6iV0aWztkGD0ReQjkqskmrJZ30XcEZzd2FQCYnXec4TitvI8kg63a2B3AgcrTr98V43YcwxX3cT1jRBoWGsw0Bce42aym3NIlAifHykEz33nV9UFixsZvTwFrVxIylGaWy6WGidBkTWgOMXedZRditBpwPZOtRW4sY3jHK9+jDxMecdKd64tEq3cz+ncdaUSk/40jhEToKAM4XuPY2dUmdWSLtrUbovZFqMuYPTpFbAnUKmqzqlDwEmIYyRb2rA61WLUfJBQoLKRHRatH7US8oLGSpzJDw5HC47Irlbrwducb0+LZ6nfEXlvxp+PbexiFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(91956017)(8676002)(55016002)(66946007)(8936002)(9686003)(71200400001)(76116006)(7696005)(66446008)(66476007)(38100700002)(64756008)(66556008)(83380400001)(66574015)(26005)(6506007)(110136005)(478600001)(38070700005)(122000001)(5660300002)(53546011)(52536014)(186003)(316002)(86362001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w+lO7SmNZpPgL5xuVbGyCkGDVhGc1iAf1D6P/9XX/qTNnSQne/DGLXpRq2?=
 =?iso-8859-1?Q?R7QgeqNaFdYu01mX5Qoip4jVt/xYpGy2JIqJYMxOy/eW1FX8118QuNmqf7?=
 =?iso-8859-1?Q?86H8ICVJsKO8uHpythKsHQ2xo5NMyKqXIq+WPcePfeE2MIFSPuYTryipqv?=
 =?iso-8859-1?Q?anDNcfZ61fst4F5ilRMN3T1AVtt00P/8EQqPq0+3/XSWjkamnEfoMtpZkt?=
 =?iso-8859-1?Q?TThpT/wlbraIpBuGLZYtXWls1oDR55Vj0X3rAUUqSquVrUGt0Eiyd8Hdzz?=
 =?iso-8859-1?Q?yRaV1m3xmT2XY3piaHuwPh0xKoZ3ZeA1hCZYi6/bQEq//Dykz1aK72iWuw?=
 =?iso-8859-1?Q?BCzcZhVbO4K+sdlZN9m2kD4JuoTWQvxVbTIgFekNmeunTs1obYZ5dJ0oTm?=
 =?iso-8859-1?Q?emTTuBVDw49Ig7eLPDzfg19bI54QEFY9egw6VnBcb6OVeuTR/c8EimoY5M?=
 =?iso-8859-1?Q?xzYRygUSfUkjiDxtb75tikFFUGrHvXXJwV/duYqsKIgRcgpweZlyrMzqFc?=
 =?iso-8859-1?Q?ZOcAfm9wmYUmMW20NvL9D1FfdQYL774e5enmmQl8E8/ohVxKzjt1Rmb1Y9?=
 =?iso-8859-1?Q?cBAIOs/BGDCLmtLqiygI9oayEuehlaNINLs3MykgshvRs25tyYus8VxFd6?=
 =?iso-8859-1?Q?Zs84i+4TGUT4FkAPD95UPv1kenzTOrErXSn38PYCzK/lbKGtrbgSaHiMil?=
 =?iso-8859-1?Q?i71N8btpn2XB7SFf83zwVfqsv/7X8skhIB7yTOpOmsn0OMkNlKPSTHjhmb?=
 =?iso-8859-1?Q?Bj/+an72YfKnIxY6jkR++N4pneoqYww48QL+zHBhOVj4UFEQUnmTSLQsUT?=
 =?iso-8859-1?Q?5aCCj9kJgDpZCHboQ1wmp5GdIeKN8LbrwvlKis3yLXtpSJyp/iRPN/OWMK?=
 =?iso-8859-1?Q?lb+fp/I4V032y1Xq8Kovnkt8AavO0NrtdffMvTiTvfDlBgGpT72pC18Fp+?=
 =?iso-8859-1?Q?5/KuC11pZgFb8pK8+YeLTjDKa1ItJTEUdN/Xov6z6I9ksjS1/7QQjlMtnj?=
 =?iso-8859-1?Q?Hu9PP/mqxep7yQFNN7Rv1Nzo//B9GZJ0ssnBs9gIR0QWr5NouoKKJCpga9?=
 =?iso-8859-1?Q?CNlAzcx5JsnqWPDODurMilOay7YKcoNOkBUQjA5GjeC9cJ+WWGlwnEksgY?=
 =?iso-8859-1?Q?EOb4KpeG4NjQk/M1Gz3ND/JX30IOmxBxFqwe+bGWH/Q7cmSuys/mqv8zp9?=
 =?iso-8859-1?Q?B9X/ZLDO4T29FFV7N3yc3rS/+RDMfMjHn8WnTDN+Bv6i0DXNn5MsMw8Y9q?=
 =?iso-8859-1?Q?mam0QiExvmn69gtIdSXIl2e0ibG4wvtY2isroZIsaxo6sTNLdGFZ5jXVjy?=
 =?iso-8859-1?Q?zhV6DRSpixiCioT6uJLvnOwz1rLrQm4dIjnfesCpfHVYvg4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305d8f60-be1e-4e37-0047-08d966fa99a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 12:27:55.2479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PsW9duEgwKTARXQh8phvNXrp1vIm7MWJ66ZLMWxSXKucKE42AmJmHDHgho+3nYtPCWIkeaEkxAEFRsmTXO2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4793
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

What do you mean a "shared header?"  How would they be shared between kerne=
l and user?

As for why not read/write.  Jus wanted to keep it simple.  It's not really =
performance bound.  umr never does reads/writes larger than 32-bits anyways=
.  It doesn't have to be this way though but I figured the fewer LOC the be=
tter.

Tom

________________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, August 24, 2021 08:20
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registe=
rs



Am 24.08.21 um 14:16 schrieb Tom St Denis:
> This new debugfs interface uses an IOCTL interface in order to pass
> along state information like SRBM and GRBM bank switching.  This
> new interface also allows a full 32-bit MMIO address range which
> the previous didn't.  With this new design we have room to grow
> the flexibility of the file as need be.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>   2 files changed, 209 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..ab2d92f84da5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -279,6 +279,173 @@ static ssize_t amdgpu_debugfs_regs_write(struct fil=
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
> +static int amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, int=
 write_en)
> +{
> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
> +     struct amdgpu_device *adev =3D rd->adev;
> +     int result =3D 0, r;
> +     uint32_t value;
> +
> +     if (rd->state.offset & 0x3)
> +             return -EINVAL;
> +
> +     if (rd->state.use_grbm) {
> +             if (rd->state.grbm.se =3D=3D 0x3FF)
> +                     rd->state.grbm.se =3D 0xFFFFFFFF;
> +             if (rd->state.grbm.sh =3D=3D 0x3FF)
> +                     rd->state.grbm.sh =3D 0xFFFFFFFF;
> +             if (rd->state.grbm.instance =3D=3D 0x3FF)
> +                     rd->state.grbm.instance =3D 0xFFFFFFFF;
> +     }
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
> +     if (rd->state.use_grbm) {
> +             if ((rd->state.grbm.sh !=3D 0xFFFFFFFF && rd->state.grbm.sh=
 >=3D adev->gfx.config.max_sh_per_se) ||
> +                 (rd->state.grbm.se !=3D 0xFFFFFFFF && rd->state.grbm.se=
 >=3D adev->gfx.config.max_shader_engines)) {
> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +                     amdgpu_virt_disable_access_debugfs(adev);
> +                     return -EINVAL;
> +             }
> +             mutex_lock(&adev->grbm_idx_mutex);
> +             amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se,
> +                                                             rd->state.g=
rbm.sh,
> +                                                             rd->state.g=
rbm.instance);
> +     } else if (rd->state.use_grbm) {
> +             mutex_lock(&adev->srbm_mutex);
> +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.srbm.me, rd->st=
ate.srbm.pipe,
> +                                                                     rd-=
>state.srbm.queue, rd->state.srbm.vmid);
> +     }
> +
> +     if (rd->state.pg_lock)
> +             mutex_lock(&adev->pm.mutex);
> +
> +     if (!write_en) {
> +             value =3D RREG32(rd->state.offset >> 2);
> +             r =3D put_user(value, (uint32_t *)buf);
> +     } else {
> +             r =3D get_user(value, (uint32_t *)buf);
> +             if (!r)
> +                     amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2=
, value);
> +     }
> +     if (r) {
> +             result =3D r;
> +             goto end;
> +     }
> +     result =3D 0;
> +end:
> +     if (rd->state.use_grbm) {
> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff);
> +             mutex_unlock(&adev->grbm_idx_mutex);
> +     } else if (rd->state.use_srbm) {
> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
> +             mutex_unlock(&adev->srbm_mutex);
> +     }
> +
> +     if (rd->state.pg_lock)
> +             mutex_unlock(&adev->pm.mutex);
> +
> +     // in umr (the likely user of this) flags are set per file operatio=
n
> +     // which means they're never "unset" explicitly.  To avoid breaking
> +     // this convention we unset the flags after each operation
> +     // flags are for a single call (need to be set for every read/write=
)
> +     rd->state.use_grbm =3D 0;
> +     rd->state.use_srbm =3D 0;
> +     rd->state.pg_lock  =3D 0;
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
> +     unsigned char st[32], v;
> +     int r, x;
> +
> +     // always read first 4 bytes of data
> +     for (x =3D 0; x < 4; x++) {
> +             if ((r =3D get_user(v, (unsigned char *)data))) {
> +                     return r;
> +             }
> +             ++data;
> +             st[x] =3D v;
> +     }
> +
> +     // first 4 bytes are offset
> +     rd->state.offset =3D ((u32)st[0]) | ((u32)st[1] << 8) |
> +                                        ((u32)st[2] << 16) | ((u32)st[3]=
 << 24);
> +
> +     switch (cmd) {
> +             case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
> +                     for (x =3D 4; x < 32; x++) {
> +                             if ((r =3D get_user(v, (unsigned char *)dat=
a))) {
> +                                     return r;
> +                             }
> +                             ++data;
> +                             st[x] =3D v;
> +                     }
> +
> +                     // next byte contains the flag
> +                     // we only consume the remainder of the state if bi=
t 1 is set
> +                     // this allows the subsequent read/write
> +                     rd->state.use_grbm =3D (st[4] & 1) ? 1 : 0;
> +                     rd->state.use_srbm =3D (st[4] & 2) ? 1 : 0;
> +                     rd->state.pg_lock  =3D (st[4] & 4) ? 1 : 0;
> +
> +                     // next 6 bytes are grbm data
> +                     rd->state.grbm.se       =3D  ((u32)st[5]) | ((u32)s=
t[6] << 8);
> +                     rd->state.grbm.sh       =3D  ((u32)st[7]) | ((u32)s=
t[8] << 8);
> +                     rd->state.grbm.instance =3D  ((u32)st[9]) | ((u32)s=
t[10] << 8);
> +
> +                     // next 8 are srbm data
> +                     rd->state.srbm.me       =3D  ((u32)st[11]) | ((u32)=
st[12] << 8);
> +                     rd->state.srbm.pipe     =3D  ((u32)st[13]) | ((u32)=
st[14] << 8);
> +                     rd->state.srbm.queue    =3D  ((u32)st[15]) | ((u32)=
st[16] << 8);
> +                     rd->state.srbm.vmid     =3D  ((u32)st[17]) | ((u32)=
st[18] << 8);
> +                     break;
> +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:
> +                     return amdgpu_debugfs_regs2_op(f, (char __user *)da=
ta, 0);
> +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
> +                     return amdgpu_debugfs_regs2_op(f, (char __user *)da=
ta, 1);
> +             default:
> +                     return -EINVAL;
> +     }
> +     return 0;
> +}
>
>   /**
>    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
> @@ -1091,6 +1258,14 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct f=
ile *f, char __user *buf,
>       return result;
>   }
>
> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
> +     .open =3D amdgpu_debugfs_regs2_open,
> +     .release =3D amdgpu_debugfs_regs2_release,
> +     .llseek =3D default_llseek
> +};
> +
>   static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>       .owner =3D THIS_MODULE,
>       .read =3D amdgpu_debugfs_regs_read,
> @@ -1148,6 +1323,7 @@ static const struct file_operations amdgpu_debugfs_=
gfxoff_fops =3D {
>
>   static const struct file_operations *debugfs_regs[] =3D {
>       &amdgpu_debugfs_regs_fops,
> +     &amdgpu_debugfs_regs2_fops,
>       &amdgpu_debugfs_regs_didt_fops,
>       &amdgpu_debugfs_regs_pcie_fops,
>       &amdgpu_debugfs_regs_smc_fops,
> @@ -1160,6 +1336,7 @@ static const struct file_operations *debugfs_regs[]=
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
> index 141a8474e24f..04c81cd4bcc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -22,6 +22,7 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> +#include <linux/ioctl.h>
>
>   /*
>    * Debugfs
> @@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *a=
dev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> +
> +struct amdgpu_debugfs_regs2_data {
> +     struct amdgpu_device *adev;
> +     struct {
> +             // regs state
> +             int use_srbm,
> +                 use_grbm,
> +                 pg_lock;
> +             struct {
> +                     u32 se, sh, instance;
> +             } grbm;
> +             struct {
> +                     u32 me, pipe, queue, vmid;
> +             } srbm;
> +             u32 offset;
> +     } state;
> +};

This stuff needs to be in some shared header then.

> +
> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
> +     AMDGPU_DEBUGFS_REGS2_CMD_READ,
> +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,

Why not just using the normal read and write functions?

Christian.

> +};
> +
> +struct amdgpu_debugfs_regs2_iocdata {
> +     unsigned char t[32];
> +};
> +
> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_RE=
GS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
> +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_C=
MD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
> +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_=
CMD_READ, struct amdgpu_debugfs_regs2_iocdata)

