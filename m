Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E40C636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 02:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6837613E0
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 02:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6837613E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2826E8DB;
	Fri, 16 Jul 2021 02:14:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD126E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 02:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9RjArc4cE6+ZJzCdWmG1zZLlgEfg0pBsU8TUR6Xkf2aBHkxK9bxckI+2H0CKV+0GIWwUfGo8d9dBf7+uShRGTi+x/iTv+a97onYq69iyIEFCaUHqZVXuH50kZ6s1buy5CjKBqRFEUvrd6TylvLhXuPyhlDB/lfnkQysvuyadzLt28Ae7L4GTjyOcwDE34DH3LTtGVYQUDA6op4j2zIMdo1pvaA56ZpGGK/k9tAc8oeMwaimi+PdL+emMuHGhY4zaN/oQoJKljyaa2T1PqAEdH9pRMEUfZ7YSgGNOGS+STqosjAScQzN4nYbhcepJcacn/6XnLQieRMHjpfMTMWQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8Q2Hb/yq0cFuysjpgc5FwjltWH+nf/YWJ3MNbKigfk=;
 b=f6uE6zdCODh7OUOiuMK5ewefrfEsTML+pDwmCR7LfgFwImWQguNSWoA62PVGpUx86rtcQYDBHmMYCb+TzVgsPgKzehMqg85VPAZdKSGlWvnpUBzaNRTqQoDXkoxq0pUi0brhVxYZOrbCx2gA/Ce0hZFoW2tIJRZGntR3uvVWC9c+DFKam1H4FmHldP+d2sRgwfmsraWtdu5DMh0LCfGniVetaf58Iazc0q1McQEHyOxMBYwgHCdWHDPG5FTF4cnFvrS2CYGnsRn6ATkI4T06VDNFtWeSptGu3ovoBsSVyG8YyVfpaCv2A1G5caev8HumxMNGoP3DFX6PBUfSIYm8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8Q2Hb/yq0cFuysjpgc5FwjltWH+nf/YWJ3MNbKigfk=;
 b=nJnQ5vIZZzAb85vK696fyYZkJbeeAoQTXSVUJeoSoj1Dfq21bLaazry7mIOmCS+gileUDLw6fTQT9Xpi8h2oBq6b07ge34WOWv+Ddel1fwu6A8LevQxP3qkJZtTZTCM0+9nLW49/R/pnRo27/oe2jPYBV0KfBT1u6Sp0sEJdUVk=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Fri, 16 Jul 2021 02:14:50 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 02:14:50 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Thread-Index: AQHXd9Iwvd3Kd1vle0ail5ypjMsaGKtCjzsAgACYKACAAbka4A==
Date: Fri, 16 Jul 2021 02:14:50 +0000
Message-ID: <DM8PR12MB547842919141D197309734C9F8119@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210713103054.4161-1-PengJu.Zhou@amd.com>
 <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
 <BL1PR12MB52698D14831EB471F690696E84139@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52698D14831EB471F690696E84139@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Leo.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-16T02:14:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04a59527-ca0d-4cc6-a537-1492c3157b66;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07cac1ac-ae5e-41a4-f4bf-08d947ff7dc6
x-ms-traffictypediagnostic: DM4PR12MB5357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5357330F6C598795ED945A1DF8119@DM4PR12MB5357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDdemSpL5PkhJbZ28N2GuhtSbCeJL2uQ4ExcNFaPQtrpUz8HnP60ifqmoRLkkkddiQuqXKeBnrNP8LdSa3xk/vx/d5fgUql05sOGHM0uQeig+OtOuxAiDPT3Vfm/SjNHRv1hr1KhzqvmE95/4fBtDewpVmYtE8w9n8uj3DDFjNJu2h3sut6llq5VyktGU2UKCmxHOXI/bbHi0R50/xUb7RM2n829bBfLPDIFYfjYY1vbpshVao8W2AqYjbItmJPmCcPA+CQxaT/7LexcL1CcGQxS9pctOtzo8NtY1zBCQ6zTuddhNgarwM/qMsKUIX0i+o3bc/sTnscgM67VJbYDFWYZ5maDEL4Fi5A6K56kicu6kt3PrUg6WohHTU/DJoNcxvSvMtiF6T31K/meKh7s+FHPLokxqoZb4GSHFXqGcsLYCpda6RzqN8M7IOn3i6GzuUP0Kvfjk1Jt9D+tFfZtDsjda4WFobJIUGAAU4TLbv/4/PLkWb4qVGI3mZIB1Pi2uVkfMo1EwO0UjSpaJ9DzhLgV/lFWiReeskuBzRIOBAqoaMFULEU32LtmPCPbtk32LT70/4iagcgcj4cW1kqJHZI0YXLb1r1f+QTeAYHtUzZwlcH/fkYOj5Tbi48gPWAkYG2QEudedpbx5szzYR6eoF0bcHTekmKlaYb2D1nqumCX3Z6QQkkmRKwUWPHidn1HengPzB8VlRcesBi3f4B/75m1kGfIoGCI97SE/uaPpxaqiTxkZ9qGW2hnXU3hRZOumkroO/+afjCJWrbO7f0njbIo4x/BA2trQ+npXQ4skJA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(8936002)(110136005)(122000001)(84040400003)(83380400001)(66946007)(55016002)(53546011)(86362001)(9686003)(186003)(71200400001)(316002)(8676002)(76116006)(45080400002)(6506007)(33656002)(6636002)(966005)(478600001)(7696005)(38100700002)(26005)(66556008)(52536014)(2906002)(66446008)(64756008)(66476007)(5660300002)(4326008)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iRdxGkDKKfsY76QbPYiv8m+fJluN2y5AzlayZC8xr+/bC+E2Ino2VwtcVJ9w?=
 =?us-ascii?Q?VG+Z9wq83E+wQpkLuRaPMt6pOk0mC1nY2HWUlxqL5vsQLRugnZmb8Kl+K1yh?=
 =?us-ascii?Q?oZLPklnYwgdZz3t4q7QUF9EcAHSpx7F4tQiSugH/aJgQC3ZkFwyWVBtlltKV?=
 =?us-ascii?Q?SU+7hqU4io9HUYNSedvio2cpyO8K2W6UzZdYNDal0B/yldNAbWNX/SZBYYAS?=
 =?us-ascii?Q?7xFOU/ZT4jtRP+8VWEtQGxCtj+V3dEgaVLmkmKZFUcU+ejOkudLvtWtt1Rqx?=
 =?us-ascii?Q?+EtzGob3xDBAdqd9erfYyg0dnXG8I1go7aKjsYce9r/KZtOVRHGIUxwYXaMI?=
 =?us-ascii?Q?Dvq0/+Nf86MXihE+LeDuoZtkIIDQTIuof17+tZZRpSO1vbJcOYdfNixifx+R?=
 =?us-ascii?Q?Y4zc9wv31MrEu/qBrijj6XBwn9gTr1NTcCibmKT/hbiQWFSf3DyAEZo2tfwA?=
 =?us-ascii?Q?VXAaQX2N7geF5igROV4GT4hRFPXHqfgQ1pb7tSHW6aZFp3hHUOkfy312bV2X?=
 =?us-ascii?Q?a6Z13PYcVEKigZi7/Ad5r7Byj2idp7L4rh/K0CoZqQO0Z1qtFkG/+YPgzQTr?=
 =?us-ascii?Q?GDbDRJ0L2+xCDyVenzOmgfrFX3eRSktJMqHFPHFl4wxqsfTxiXpZKtI9OCed?=
 =?us-ascii?Q?sftgariyP70Ap6UTL3atTniirgB6/x2J72wyWnWU9nCICFyuKofzQspdQB7L?=
 =?us-ascii?Q?/Y8FsLnxmiDogls+Tyj6jyA0k6cFlZ0LaveWSmo+qBymrx4Itk32jb5rLvXn?=
 =?us-ascii?Q?dEm+fZ7Ogpn+F3pV9alIdFV7pgpGpF4k1P2wi9DQwUr/5IbnBhPEXYFCNuGQ?=
 =?us-ascii?Q?lpDvdGnq6K0STt/6kQ2U8TQBbzxTbqgRXfMFEEx/RhHymxbDAUZGauETtaIJ?=
 =?us-ascii?Q?dJc/9J566qhlWoY5m37T7kEdZalISIu/oKk5Xt2UP3dF2lLd0EngJCIef9Zu?=
 =?us-ascii?Q?/aD/cGVcdGii8bEPrmXJ2j4m3u+wH+jyq6ihoRshu3t3V1U0Yu+BjqK6w+dM?=
 =?us-ascii?Q?uGEHsFzQGfkhFKrSL5Fc5PIS9nGLQ+thgqUDl6HeWsPXQ6f4+P/qBoTl3RUS?=
 =?us-ascii?Q?tm2yP1K5JKCY846NBec4ioxZisAM0ee/fPob7zLnykOQjQvBGqKu6QGV4RE+?=
 =?us-ascii?Q?VppA+mdHcNM+JOxVJ+lHIw+9AkqWwY7mB0Wgul1PnNOpvdFxjOng4lO987W8?=
 =?us-ascii?Q?BOTkJFpLU4seQ6LKWhJk2015iPnVdkE8oosk3KV7mlfjELrszZeO7cyxT7nm?=
 =?us-ascii?Q?fWX/bAfYkG747LcJ7g+MS38nc0htIgKGBx4PvgPSTYdpIRoxNILlSluRpkqL?=
 =?us-ascii?Q?YjL0YsbLs5oTu+ot5W2AqtiO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cac1ac-ae5e-41a4-f4bf-08d947ff7dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 02:14:50.1282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJHw8PycNQ6U5N8kvpP8Xm/qOwNC4yqPU99qvTz1xShdITSqvQlAp8aZxI6/jKzGyvnkjFZ+LC8jRvj4xBn6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi @Liu, Leo

Can you help to review this patch?
Monk and Alex have reviewed it.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Liu, Monk <Monk.Liu@amd.com>
> Sent: Thursday, July 15, 2021 7:54 AM
> To: Alex Deucher <alexdeucher@gmail.com>; Zhou, Peng Ju
> <PengJu.Zhou@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
> 
> [AMD Official Use Only]
> 
> Reviewed-by: Monk Liu <monk.liu@amd.com>
> 
> You might need @Liu, Leo's review as well
> 
> Thanks
> 
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, July 14, 2021 10:49 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
> 
> On Tue, Jul 13, 2021 at 6:31 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
> >
> > The previous logic is recording the amount of valid vcn instances to
> > use them on SRIOV, it is a hard task due to the vcn accessment is
> > based on the index of the vcn instance.
> >
> > Check if the vcn instance enabled before do instance init.
> >
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33
> > ++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index c3580de3ea9c..d11fea2c9d90 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
> >         int i;
> >
> >         if (amdgpu_sriov_vf(adev)) {
> > -               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> > -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> > -                               adev->vcn.num_vcn_inst++;
> > +               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> >                 adev->vcn.harvest_config = 0;
> >                 adev->vcn.num_enc_rings = 1;
> >
> > @@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
> >                 adev->firmware.fw_size +=
> >                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes),
> > PAGE_SIZE);
> >
> > -               if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID)
> ||
> > -                   (amdgpu_sriov_vf(adev) && adev->asic_type ==
> CHIP_SIENNA_CICHLID)) {
> > +               if (adev->vcn.num_vcn_inst ==
> > + VCN_INSTANCES_SIENNA_CICHLID) {
> >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id =
> AMDGPU_UCODE_ID_VCN1;
> >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev-
> >vcn.fw;
> >                         adev->firmware.fw_size += @@ -322,18 +319,28
> > @@ static int vcn_v3_0_hw_init(void *handle)
> >                                 continue;
> >
> >                         ring = &adev->vcn.inst[i].ring_dec;
> > -                       ring->wptr = 0;
> > -                       ring->wptr_old = 0;
> > -                       vcn_v3_0_dec_ring_set_wptr(ring);
> > -                       ring->sched.ready = true;
> > -
> > -                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> > -                               ring = &adev->vcn.inst[i].ring_enc[j];
> > +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> {
> > +                               ring->sched.ready = false;
> > +                               dev_info(adev->dev, "ring %s is disabled by hypervisor\n",
> ring->name);
> > +                       } else {
> >                                 ring->wptr = 0;
> >                                 ring->wptr_old = 0;
> > -                               vcn_v3_0_enc_ring_set_wptr(ring);
> > +                               vcn_v3_0_dec_ring_set_wptr(ring);
> >                                 ring->sched.ready = true;
> >                         }
> > +
> > +                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> > +                               ring = &adev->vcn.inst[i].ring_enc[j];
> > +                               if (amdgpu_vcn_is_disabled_vcn(adev,
> VCN_ENCODE_RING, i)) {
> > +                                       ring->sched.ready = false;
> > +                                       dev_info(adev->dev, "ring %s is disabled by
> hypervisor\n", ring->name);
> > +                               } else {
> > +                                       ring->wptr = 0;
> > +                                       ring->wptr_old = 0;
> > +                                       vcn_v3_0_enc_ring_set_wptr(ring);
> > +                                       ring->sched.ready = true;
> > +                               }
> > +                       }
> >                 }
> >         } else {
> >                 for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cmo
> >
> nk.liu%40amd.com%7Ceee0db55446b43f11a5d08d946d69bda%7C3dd8961fe4
> 884e60
> >
> 8e11a82d994e183d%7C0%7C0%7C637618709836027968%7CUnknown%7CTW
> FpbGZsb3d8
> >
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1
> >
> 000&amp;sdata=0lw4us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D
> &amp;res
> > erved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Ceee0db55446b43f11a5
> d08d946d69bda%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 618709836027968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0lw4
> us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
