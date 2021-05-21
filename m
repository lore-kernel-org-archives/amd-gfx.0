Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95959C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 09:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4276135C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 09:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4276135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8C56F5D1;
	Fri, 21 May 2021 09:58:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D2D6F5D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 09:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3+oEoxXQgxc11xNXQnzDW4nI2VC8uahRdQTc7dYCL2L7Z7f+QrtCREPj7aUe4OJBoy1ik1/cvbeOasTQ8xhvwYPyP0dw40JPMTQHJbOEUw0QdfVG9se+lTEmxVDhR/0yiIPUrJNoc8e3ZigGnYqlocGMsPW8yqx9XJTdsRVgzvN7XjpyFr+hN80AUgxCz7Jxjdj0hrqN8sDDy50HShEv2TyX9RGAnYSe6Uf1qlRkphmfBM45N3coSvbOycxof38Rn/P+CIvrIXLMQqQ1NBO0KNorB55CR1mHIsfXaVkd4EwPdzF8NeubusYDWJvDoe2AnnnMyWI7wrrVO2VN4el9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fdk22Ywt5t8c2aRIkVhLBYwB7k+MKgBL9TqPn+mUayw=;
 b=RGDfuFCsYbAuR1Heat/NCARO1iSZNi7DuUIhOC9X6GBtP0DMNcQ7DSnJabzStxJaLU/VBzmfrX819UqE4dVrL0wKhwTzqkZ1m+0Bz6Eys7f9Yph+3BEAcV0sLpQSKKkfDjXz3YDtApDCpXEhnpricrP59RMPYMnTDg8GkUBj9HC9pBt21xfklNaXyRFAyFYFKBptjLMnYZSeeqdjQliRlKKJEAszfcKqnCQ+WpX+f1Qhzxr8p3hcabi0NSi6Mf4ncRy4SwLQeKgIAdb4QUdKDuBZFZ/LSJjsJfLdFHZld5X3hr7e0kDytmn70RyRTpfOLGXzvcRLqDPrXcfjCPBvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fdk22Ywt5t8c2aRIkVhLBYwB7k+MKgBL9TqPn+mUayw=;
 b=Y93Qkz+7o7QENlyyfSxaC6zlYcFp3qhIudNx9Q4rU8lD3NC+mACi5SGrzM6hzxK704yjYTJczf5+8WLKh0ABDLbtnxAyQ/gB2HfUNUfm01EYy3D042pPdvEHiSU8DRDuTzpBFDHNu/mcPzH7rVs6S+ZOb9STE+RTtWnjSjYqHmo=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 21 May 2021 09:58:01 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 09:58:01 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Topic: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Index: AQHXSypx0BE9sQzOsku4FQjmjcajXqrrvzGAgAH4rBA=
Date: Fri, 21 May 2021 09:58:01 +0000
Message-ID: <DM8PR12MB5478E96B03A4B7FDF9263092F8299@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-9-PengJu.Zhou@amd.com>
 <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
In-Reply-To: <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Victor.Zhao@amd.com,Emily.Deng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-21T09:57:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3d920038-f703-48ec-8236-aea1423c4249;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.166.164.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd33e651-b684-41bd-59b3-08d91c3eeb6b
x-ms-traffictypediagnostic: DM4PR12MB5213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5213336038DD37B0D40CF74AF8299@DM4PR12MB5213.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4UaMeC9BbUDuc3Mgt/GpiCkOz83N3DQMmciNU06LTpL6saxmkjEEXK77nTBSqQ+TOV7LBDeiIBEptuhG46WnCt2xNMhct9RUyDu13FbvB7ajbEOyjjhOc3Xbljl6bBYaERXYY5B20LACBx0ARrsHzaX5emdV/JiCk+/COpEhMaCtFyidoeFK7HYcHLngRi0lMAt0ub49S0b+KJVYCs6D3SMIVmVnScc3iYIOwPKHEif2lp810LerBv+XyBYRPXq0C80WiLtOYUVfmhoAzdLkhg8xLlqGjgUCxXurqm508vt+69gCESsc1xpqXcqYWrt/TiDa8tg+mX3DPmrtTIf2SMWdRlifE/ARoxn5U49Rab7ZjsxySFyB2EBG7WHFQKgF7vVryneYdlFSnh9PePi/kMF17blR9WEM+EUbT3B8O84zTQBvm46t2+C4kSl/Q1GX8mnPfATMJ7JQf8WgY5cOWT3aYXL/LvAmoQt+Yr+IqF3SWRnKm0nP4QJj35973Usjhz7OOmrRDOyJACJFd64J0sum5rU8I/KpuP8qq4509xl1Rv5E1ZrrT/x6b2y5TgqMg+WzF3zt/DBTOD/ite6/pYJDn7jXp1HqcN1DXln/E+ChxCy6kei5wTw6ez7QPPQvKZ+FwNZTGrs0591XtHJWn/4lD/oO1HGn6wUUUOhoT+ce8rdTW44T2sIEYK5slX9odwkWNoRmTab3+mweATM7t25CTAlgMzBmPOpSQhHpuM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39850400004)(316002)(6636002)(76116006)(66946007)(9686003)(33656002)(2906002)(64756008)(66476007)(66556008)(66446008)(8936002)(186003)(83380400001)(4326008)(8676002)(110136005)(45080400002)(6506007)(38100700002)(71200400001)(122000001)(478600001)(7696005)(55016002)(86362001)(84040400003)(5660300002)(52536014)(966005)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HNSEcmigXZPCLJbqOR0f27w8D/SvBsMI05tRcYOxoqyz4MX2rwq2Nadlj9Y/RLw56KJ7fw01VrBS4aVZo0Y1td2/NtcBi5YKgSl3gUnSffFzscaIMuE+fgMP9IY8/SxmZdoi58JqaeY3OBSyxawQKt5T5HclgrNHIvRQFPk37w1M4Rsmw+XwpjtpQJ190bvM5PqyAltbTI6n2VF3bHP6c/+R/N44nTX7VkknH2fSQjvFMxFL72rpiKAc7Ok8vgWeecA6Ah73tRn7f6l2jbmQBhX2d2fy+VfK9CujnNxyrMDXEjNBB310IxNMpU8/EuYVckzmExY/d+PYwDUBQ2WSgv4BFw+mcLZRJ+XUV8jT50reBaPLUV76QganPUgFAToIcXQT4Bk2EcATCH65O7pIYSxRruI0Xuip1gPfyavtmv/vTZ9fBbSEIQIyoX3hMzC25HKnAkcAOumvrTJZ4GMUUexv+ql6Cgbcuj3Qxb1MUi5JnVpooMStoqfmgWQFIE/J2+F82Nzm25rv36ixx8287LgOGyc1dAyQEwom3SWyDA0YEALKOZ7uybi5tVSsqBX+1HjJ79J2M46IB0LiIofs5YKPUacksJF/KMLmv6e67w21lvTELmhuQCByLpqy1E/Mp3Ip8rfV12FHLVJhHwAiJmQo6F3mrPzbo+Cmt5bdZWWhuF9i1u/OTf8wbACXssf9xHeuY1sIDgMJAgg7UGZm2NzeZfKhoZXQ2GW1YxUNJrY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd33e651-b684-41bd-59b3-08d91c3eeb6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 09:58:01.1512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXyMaG9wJiutu52v0JjKVsuAeedscjiainiQG2boPbj3yGjVxjH5lWUjv3ieSf9HhgR50JjClrRjgaTpYSH2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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

[AMD Official Use Only - Internal Distribution Only]

Hi @Zhao, Victor/@Deng, Emily

Can you help to answer Alex's question,?
Because this patch originally from @Zhao, Victor, it's hard for me to explain the question.

Alex's question:
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> >         case CHIP_NAVI12:
> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> > +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> 
> Is it safe to change the order like this on bare metal?  Please look at what was
> done for vega and sienna cichlid.  Something like that is probably a better bet.


---------------------------------------------------------------------- 
BW
Pengju Zhou




> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, May 20, 2021 11:47 AM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhao, Victor
> <Victor.Zhao@amd.com>
> Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
> IH_RB_CNTL* registers
> 
> On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com>
> wrote:
> >
> > use psp to program IH_RB_CNTL* if indirect access for ih enabled in
> > SRIOV environment.
> >
> > Signed-off-by: Victor <Victor.Zhao@amd.com>
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > index f4e4040bbd25..2e69cf8db072 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct
> amdgpu_device *adev,
> >         /* enable_intr field is only valid in ring0 */
> >         if (ih == &adev->irq.ih)
> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ?
> 1 : 0));
> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> > +                       return -ETIMEDOUT;
> > +               }
> > +       } else {
> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> > +       }
> >
> >         if (enable) {
> >                 ih->enabled = true;
> > @@ -261,7 +268,15 @@ static int navi10_ih_enable_ring(struct
> amdgpu_device *adev,
> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL,
> WPTR_OVERFLOW_ENABLE, 0);
> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE,
> 1);
> >         }
> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> > +
> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> > +                       return -ETIMEDOUT;
> > +               }
> > +       } else {
> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> > +       }
> >
> >         if (ih == &adev->irq.ih) {
> >                 /* set the ih ring 0 writeback address whether it's
> > enabled or not */ diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> > b/drivers/gpu/drm/amd/amdgpu/nv.c index a9ad28fb55b3..b9c9c4d4606c
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> >         case CHIP_NAVI12:
> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> > +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> 
> Is it safe to change the order like this on bare metal?  Please look at what was
> done for vega and sienna cichlid.  Something like that is probably a better bet.
> 
> Alex
> 
> 
> >                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> >                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> >                 if (adev->enable_virtual_display ||
> > amdgpu_sriov_vf(adev))
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPe
> >
> ngJu.Zhou%40amd.com%7Cabc8d955fb1f4deb9ce108d91b41ecbb%7C3dd89
> 61fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637570792232990999%7CUnknown%7
> CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C1000&amp;sdata=HyDcZjT3c6mY%2F%2FYdjMuW1T%2FRUIzqX5kK9vaYus
> mZJxI%3D&
> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
