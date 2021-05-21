Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21EDC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 10:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70E8613CE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70E8613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E5D6F5CA;
	Fri, 21 May 2021 10:07:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD996F5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 10:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POq4EkVlwpWnI8J/e5pO2RVo3AYfzplB0gP0Yv7EmnHbWUSIBTrEwSUGdupPfnDkmLWDG9jqyVmPOz8u0sf2i2gZDmwi/kS2nbDTS5RKUtm1WkYpBrTLpv96Ax3DmkegL6U39DYosZayLh+rNEkTEBpoj8a41IXTXWl1CAN3D4Xwqq93Nkhj4BLmATNkFeZnt+HymRVuYKpwU6kvb8BHPTTPbnv82p1U0qCqJiUUSu+F/3JNKgoCp/4IClOqmBEmzNSP6s9hPz/BOKIhVxHhkJ84SXCg23yXbJa0Y99S1Ugl3iYeF9+Yz9MlZQ4robYnIxYD6454kCPeqZ5o4oZ9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN7eP3RcrhPLlVtAGXuFb5ugfFyNfrXeoqXRuyIeDIw=;
 b=lgA2l3IWeu4D7xnCtwP/8ucc+At1tP6jOLTvzS1cbLZuxz1UgAwJZ+2B3V5xp8bXs+siQlSi3xwSfDCdz4nmIzzBDX5TWGuGrozoBoyJxM4uoIdG+CarIwiNOG9SLqQXaniCMPjrck+UgGeeCHStWcfCUbzkOQb9B80cYVD1+qXogIYnoYuHvEIqvQzGVn0uRH75UMMxtbMXecXDetFfy3Tl8QmnXKBdDqNnd8l26vy9M5FaIchuWO6HeC5pR0BZF4AA7tKpyOgDUVOwViGKcOmbdoCqGpQfpjwSUmSZNpGpH7M0oLn+vkp3aCGd6fLRFQ2Y4t7oACbqc4FRPDWQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN7eP3RcrhPLlVtAGXuFb5ugfFyNfrXeoqXRuyIeDIw=;
 b=RYZoTrvXU6VuzYCXS/fjzT6gTUNKpYBW09cM0PnK3ikhY8BGp0UCGE8dmiIR9xxXKqahPcdxysvrj0YeShRimBupkxAgo0ZdOINiXYhiPJ0pFOuRSSpmt5K3dmtVaQQdli/Lymzb/sagXd7NU90Pv4a8lhH+uNabXco+t8wgFWA=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 10:07:44 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d%7]) with mapi id 15.20.4150.025; Fri, 21 May 2021
 10:07:44 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Topic: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Index: AQHXSyp3mrGEntBLaU2FIvWFafzH0KrrvzGAgAH6C4CAAAKZsA==
Date: Fri, 21 May 2021 10:07:44 +0000
Message-ID: <PH0PR12MB54173F1759D9D6FAA290DB568F299@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-9-PengJu.Zhou@amd.com>
 <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
 <DM8PR12MB5478E96B03A4B7FDF9263092F8299@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5478E96B03A4B7FDF9263092F8299@DM8PR12MB5478.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6713fb3-4684-47b8-8aea-08d91c404734
x-ms-traffictypediagnostic: PH0PR12MB5449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB544926075F8751961C354B0B8F299@PH0PR12MB5449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lc4/mWpJ3WBXlOBJTbt0HMiGFUZZdfaG7T5GRDUBdQsHEaYLTsiuFjTW/NO7O3c4BiOFUO2Juca6EzN+6fjgY/1ywp7ce2TAKRuFZgtURXWGttaZ4BZ3S0QNRAX+0Vllpe7HxW7jIzfXRbkVGDJUUPCPQVwRV+x0oTzJiHfJqem0Prjj3x+DCcuCq6KWFpIo7J1iD5uEh2RTCOV79hUO6uS0cVf5OxptyPjT7LamryZLEhA88YpqQnrd/BRXJ16Qa5fp5G+IdXd19NBxLAkKItZH+zr9qW7Jq02aicBrL+8cXUXiNb+HxLdMvGfAE/j2KlQEJCZKxmjgoIRUC4nNCfsHnuhtOQ6DrxsvJvfAJkzAIQ4SQMc7oDzSvw8GARWYKZHqvDRrIzzRE0PRtIQZvY6spYP4vqW4m/DgsDLpp1WU0HkDvDA0T5nMQqp1rjv/sYLpNxSWLTMoXHlvXRaOm3z8sWFPUc4Y12sz63RygRrBnrO59T2NXs7F9SfIsC9ASqMLj7pDf/p6j4CptvsDNwIcF4M/FQzVZK7GpqADty437pSf8Wf3YEd1G39yRObgpTtOSBcN9M9K59w3BAN8dq7QKeFdNxfZuXr8qMVVBHAdmFeR4ukByGmkoy+QW76d+m53a2rkwfUWkBeU7D3MxnCeANIv4F6U7JzBhhyy7tVHQri+7BwduJwRT5PYsWyTd10UnyHqlAg6RWrsCKvtJ6AqZJZDdmnRHpkzpP/eUFI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(8676002)(83380400001)(76116006)(84040400003)(8936002)(66946007)(966005)(110136005)(6636002)(7696005)(38100700002)(122000001)(52536014)(66556008)(66476007)(64756008)(66446008)(478600001)(71200400001)(55016002)(45080400002)(186003)(2906002)(316002)(4326008)(6506007)(53546011)(86362001)(33656002)(5660300002)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tHYt5U4sysWmf70mj/24MSzIozizGIFndfG1kJRVK0uqJfx59y5bWiphuymgzsXT2qHQG0FtX0UadOzHfS0Bv9cYLZMXchiq0NxHVPAyHi4sDOIohHQgetFTywWXFspZzx4pcZ4AFx5iVH17Xj/gFQw7hXTxrZ0Dkqcner9N0EcVTxE1PSiHO8SJ6jQjb1QsJSM6bcVPd19uF5mldWhLw0ILvi9Ud8eOVRGWZ5vLXaFuAVWG8RfmXVTj/wsRbcxVJpECA3tPfWPFlyQz4B1rbfYV0wO8/WI5XUHzNLUYd+eaaddPi7UCS68dm77IbvT/N8nbZ5C1SQ2tc++ZIlQJ0bdkw9MLE6CjdylnrYwu1V6Bu9SLEAPSGmVYEAI0rV2Q8CVMIhNjzTnCTrgoZNIqH3Dv+Ot2zPTjpQJ6WdbuObkbJSI2wYh2Z10gHUxHnPhBHsZIGo7absPNlMauiPltc6JYUkKFD+gyZyVdQNYFBjuJzDUOH7uix4i6xXzixnCvbWmVWIv31dVSj/yDSGDv0Qfs/Fwmz58f2tanqYC1nRk1JiTUDuyrU/AhoeMZ0+jYTXbBTk2pYoCFKHqzwQz8Zv/u2oXzYNkG6PeOGl0WJf7xappLugPfiVDmI+IYd4+xWPBt5hRB9QI421XZJvuzodtpd26T50FjFJq8i3Dl5ZPjlBgeMt1UY02xQNavqFSzrfwMwJ+7/5J9I0i8o2GKH6dEGKWAL1sDCalbpqUxhVEdFziRnLTkfsKiqrje3DaG
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6713fb3-4684-47b8-8aea-08d91c404734
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 10:07:44.5297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+Euh/bTi5ufq2XEcpblfxZzObcbILh8/gwoKaXyfHWYGkQITBACRDByqeIQPnR5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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

Hi Pengju,
     You'd better only switch for sriov.

Best wishes
Emily Deng

>-----Original Message-----
>From: Zhou, Peng Ju <PengJu.Zhou@amd.com>
>Sent: Friday, May 21, 2021 5:58 PM
>To: Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor
><Victor.Zhao@amd.com>; Deng, Emily <Emily.Deng@amd.com>
>Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
>registers
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Hi @Zhao, Victor/@Deng, Emily
>
>Can you help to answer Alex's question,?
>Because this patch originally from @Zhao, Victor, it's hard for me to explain the
>question.
>
>Alex's question:
>> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>> >         case CHIP_NAVI12:
>> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
>> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>> >                 amdgpu_device_ip_block_add(adev,
>> > &psp_v11_0_ip_block);
>> > +               amdgpu_device_ip_block_add(adev,
>> > + &navi10_ih_ip_block);
>>
>> Is it safe to change the order like this on bare metal?  Please look
>> at what was done for vega and sienna cichlid.  Something like that is probably
>a better bet.
>
>
>----------------------------------------------------------------------
>BW
>Pengju Zhou
>
>
>
>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, May 20, 2021 11:47 AM
>> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhao, Victor
>> <Victor.Zhao@amd.com>
>> Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
>> IH_RB_CNTL* registers
>>
>> On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com>
>> wrote:
>> >
>> > use psp to program IH_RB_CNTL* if indirect access for ih enabled in
>> > SRIOV environment.
>> >
>> > Signed-off-by: Victor <Victor.Zhao@amd.com>
>> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
>> >  drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
>> >  2 files changed, 18 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> > b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> > index f4e4040bbd25..2e69cf8db072 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> > @@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct
>> amdgpu_device *adev,
>> >         /* enable_intr field is only valid in ring0 */
>> >         if (ih == &adev->irq.ih)
>> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ?
>> 1 : 0));
>> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
>> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
>> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>> > +                       return -ETIMEDOUT;
>> > +               }
>> > +       } else {
>> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
>> > +       }
>> >
>> >         if (enable) {
>> >                 ih->enabled = true;
>> > @@ -261,7 +268,15 @@ static int navi10_ih_enable_ring(struct
>> amdgpu_device *adev,
>> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL,
>> WPTR_OVERFLOW_ENABLE, 0);
>> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE,
>> 1);
>> >         }
>> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
>> > +
>> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
>> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>> > +                       return -ETIMEDOUT;
>> > +               }
>> > +       } else {
>> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
>> > +       }
>> >
>> >         if (ih == &adev->irq.ih) {
>> >                 /* set the ih ring 0 writeback address whether it's
>> > enabled or not */ diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>> > b/drivers/gpu/drm/amd/amdgpu/nv.c index a9ad28fb55b3..b9c9c4d4606c
>> > 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>> >         case CHIP_NAVI12:
>> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
>> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>> >                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>> > +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>>
>> Is it safe to change the order like this on bare metal?  Please look at what was
>> done for vega and sienna cichlid.  Something like that is probably a better bet.
>>
>> Alex
>>
>>
>> >                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
>> >                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>> >                 if (adev->enable_virtual_display ||
>> > amdgpu_sriov_vf(adev))
>> > --
>> > 2.17.1
>> >
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx@lists.freedesktop.org
>> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CPe
>> >
>> ngJu.Zhou%40amd.com%7Cabc8d955fb1f4deb9ce108d91b41ecbb%7C3dd89
>> 61fe4884
>> >
>> e608e11a82d994e183d%7C0%7C0%7C637570792232990999%7CUnknown%7
>> CTWFpbGZsb
>> >
>> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>> %3D%
>> >
>> 7C1000&amp;sdata=HyDcZjT3c6mY%2F%2FYdjMuW1T%2FRUIzqX5kK9vaYus
>> mZJxI%3D&
>> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
