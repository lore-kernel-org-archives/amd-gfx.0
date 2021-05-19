Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B41DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC546135C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC546135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8D66EDD0;
	Wed, 19 May 2021 14:34:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19216EDD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKIyB/MZFVgag1b6kvbG86ZjZYoabZVh82tilZ4X92uVNMxdHfkb84BCl9aCJp95WD8Npv7HZabUuTiDGjKO0PObJuZcfH3/DtCnKrfcI150qaG/IbUm8NRd8SRTy/XmMN3KPi4U00h3Q+2dCAqTNd5rUIcLJ6G2t0oeBLJJQ5/eRLKFbQ2L0ypq28m0y151RGn31fMGUAuVDEzT5C3yJXBZUdNTBoa2HKNwQ6shbq6WFrM4m8UltyTrxbgnw2qIuo7IsivrrqkZvhUqCOME47alzsj0ty0jurPIblwyzCf9jRWFm5iyYWE76e8Z5oPMFCIaJf2UeCZMakAtl+ctfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyO6iJz5CgcJojVdOqcPxLljf3JRqzk3nLduUl4OeNg=;
 b=FZE5boR7FwtZSJbNML9TeRa2qJEYH5e7/LmbskeRjS1Wyrqy2UF2MzZRNdGS2+Xb5BJvC7/lF95yKxKUaanE2QnljjxdJP74f6luJgNFckBRHWHk+uxt9y2Khq3d3u6FwQ1TI4Prqkcw8e6XOYP2imWRh8Nne/ySSwx9NLEOELRrBp65+v5leQ67NZz+Q8pxefIi5kCFB72F5GRjlL8llvOZ6TKIsSXZBRwQVyIZ9zw/xy61hWukp+k+/4YPahXPHBcS8csZZHKJSHhJ1XXhypmFCWhJxaD2FZWdqD/tMyNt/XnJTt2ymxfZOjBUIVV+ATPyu5fLvnaENrLjPAnWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyO6iJz5CgcJojVdOqcPxLljf3JRqzk3nLduUl4OeNg=;
 b=d8PR+cyW6htO9YJmQox3J3UUwoQES619/IVsOehzO1dfsE5eE1k/j/MuYJfEjdd4eAWdS024E6p2kHgpQeYeZkc41932ozJB1MJvKK2tXTQkJrNrTcBwlHXGFPZHqvTeI0fXr7vNRictL5beVCFZur+Q+sgD6kj+5IcuI5iUvlE=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Wed, 19 May 2021 14:34:26 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6%6]) with mapi id 15.20.4129.034; Wed, 19 May 2021
 14:34:26 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Topic: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Index: AQHXSyptilLfNdTJpEC7Uq6pCXE4iarnvtEAgAMi0RA=
Date: Wed, 19 May 2021 14:34:26 +0000
Message-ID: <DM8PR12MB547846C12D8F143579F031DAF82B9@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <DM8PR12MB5478B352B7F1D70855826CB2F82D9@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5478B352B7F1D70855826CB2F82D9@DM8PR12MB5478.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-19T14:34:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=053e5205-a5d7-4149-afdd-3529f2b0e29d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next  
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.166.164.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5de39d7b-2125-4755-2f6d-08d91ad33417
x-ms-traffictypediagnostic: DM6PR12MB5518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5518F18EF1EB0C7566C7C8FAF82B9@DM6PR12MB5518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npSIJ3FLNG6n2pgU7+1GcrFaO6i0wJH8HMFQ8323cmZFCTxCMcqYADl1i7N0gjZ7luHNH4x+ENE2CuNnjvQNc2CRvTssJkWDgjRSbTF/314KGleohUKOnZvHLT1oF2c7St8gCr8Xp5jzyh6j1ADgidZ3G4AhyHRk0DvmjupzSkB2KE6IoH3FGX1X5h5ps4gh4Q+t6X9DskZp3AighZdTU0Xvx1cYHyc37aG+CySwlIDOd7lG8aN3g/wAFO4T1xTs2dwn48Zc74pC2SXXLgW1KchY0/0i6LeugmcAr7za6+XMPoD8wya7TAD6otwpR0A1SU+hHdljl3W/1ED7qDjVjWEzYcbcZnBAMXXqiu+fpoAuQ8h3bCDe9iOcUR9m7wMfZmNBzln5WI/uPA6JXAOwBmFroqeX8mrVLPOC6oGHX4l6AsG4/RKX5oX3VSuJI3sLyeQcwq4d3FSB+u5j+LDbBf82Js2LdzrXcA9oCqZUkuihoERiVLUzzMaXHs+9frYHr922dxEBg93pW0b4zET6tMTkVVSYgdvUegE5Pf6KeLP/kygwNBhSv+8rUrheihTNG7rBGZbVr1UriVc/c8wxpb2Ll3AM1O8MpTZmZqdMnckYXIItMcCYV89sAwP6WO7zQeI6Tzd3FrlNgn+bMMHXOpDswvyZki+grBLXzqU4/dmMZ0z7hllhHvb83endGNQY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(83380400001)(5660300002)(966005)(316002)(55016002)(9686003)(4326008)(7696005)(86362001)(53546011)(6506007)(66446008)(66556008)(64756008)(66476007)(66946007)(30864003)(38100700002)(84040400003)(45080400002)(2906002)(110136005)(54906003)(122000001)(478600001)(8676002)(26005)(52536014)(76116006)(186003)(33656002)(8936002)(71200400001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rBczrCxjTcHXd1RJBXTeoy8q91xesCMVYqnpbV9wM1RYHW/hO5iiMOKQ/Ynd?=
 =?us-ascii?Q?uhWO4ZPk0NNcDfC3lk9G5lm2YIv1L9h78avvcnNxUFyew7WwlpvcLMsCmwuJ?=
 =?us-ascii?Q?5pfvecotkwOxej5XdSTszan96Jk5bvNBOuftJddT5U1wY9LBLc3mq2BKb78l?=
 =?us-ascii?Q?BsBAbASiELQ0k7vORubP3E/sbAtZcFwfl5FQJfnWYai0Z7b/MLnxaKmFJOzN?=
 =?us-ascii?Q?GTaOOw5brZzH0Gug0rbPSFBnjBWhirzQ6SNkNlRz92wu9W3k+JsathnlzAgs?=
 =?us-ascii?Q?ByEJ2cyIL7eV+JpjdE/XkFSl+5qJ5tbuPm41Vf4xSXHnZP2oN1RQCulHCSje?=
 =?us-ascii?Q?n6220uU+xvh1AW8XXHh385+6gCO+1oxcY6v4rPp44FKbc66PnJmG6G6+B6aN?=
 =?us-ascii?Q?H3xcKpdOC94AuefX0+BMRrh9wM9EIQjdNH2b9QSVdWPR/gOiEUDSVwOp6tkm?=
 =?us-ascii?Q?Kl6CNiqza0Zi72kSQigiaZMo56Ata7LfgoCW2PBxPYkTEp3EgzO1em0A5PRL?=
 =?us-ascii?Q?tM0FOPm5wj8XFP2yzDd9rS2qSsshMGU/nc+wdOqRILYkwXUekJvqXMorICYs?=
 =?us-ascii?Q?ce2gZ75s8vdBitARoKX7eOmSAZjIgtu4pyMV9p8LpGLnU/fdyX6qeWk0cP7K?=
 =?us-ascii?Q?PmzfLGL3EFFnyAH4Mi8XsMVs/A0n39ANKKtruww9xoGz/IcEsvJx9cr5lqVn?=
 =?us-ascii?Q?K1LzyzAPfg/Oo88QSX3ZzOWtxTHwUk3pVqTe6UAqIMne0eXGJDQgiSTFN/3o?=
 =?us-ascii?Q?OACwFVtvi7MiDS/91aNvou7pGSBYg6GE7d2zrf4q+3hNY0dCk3oD9VdgsdtD?=
 =?us-ascii?Q?cMocY6S/38OMO0Y032vC1xby317+Bt+dLK0ISaX902zeUlfXmCW4jUWZ01OZ?=
 =?us-ascii?Q?PS8WlAN+jT8I3BjeGK32XP3Fm+m28971xMWvHatM8QTTorO9a8/rXrXrS8+P?=
 =?us-ascii?Q?oP8mzcJ5/EyhoVniUTaII9xvUvtv4InftpgtMuJbcIhg1FejI4ltuoUUeXaE?=
 =?us-ascii?Q?Ozwa2V6jTWz6BRGHWywrgXG7aoB+XnDa55L+ntgNbTvZ3YqEUyKOv2FGItLG?=
 =?us-ascii?Q?Ito1VarQq0vGLlZczm5KIlyiHlYHcOTzIYC5BI10fMfl15EIknzUIqq+r46q?=
 =?us-ascii?Q?MwoqJcqCIyGvfegM+cs98nt9fsTOLvArXFzaGDdj76qHQkQpwK943gS+Urp2?=
 =?us-ascii?Q?zYB1C2eukgNhhZv+kWlziPg6rVGx68cuxEoPahhzyupKKXyWD26PvJgxUOWn?=
 =?us-ascii?Q?prDDgOj/LS/9bnqAjRQiRXEL9LhbXIa/pj0FdBFbdg2oOO0CUKgWuPsrHdw+?=
 =?us-ascii?Q?nugYIkWg+2z6tvFaXp0r07/m?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de39d7b-2125-4755-2f6d-08d91ad33417
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 14:34:26.2020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HyPhfLJ6c6g5XFYcKxhsL7MvnyMDuJa8qPKNZEgeH8o4aQy6LehctloXpb4Oeclr3noAmtxj9lccHS8I+4lkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Ming, Davis" <Davis.Ming@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping on this series.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou,
> Peng Ju
> Sent: Monday, May 17, 2021 10:50 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Ming, Davis
> <Davis.Ming@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
> Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for
> Navi12 sriov
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Alex
> About your comment:
> "I think patches 1-4, 16 need to be squashed together to avoid breaking the
> build.  Please also provide a description of how the new macros work in the
> patch description.  Describe how the reworked macros properly handle
> sending GC and MMHUB accesses via the RLC rather than via some other
> mechanism.  It's really hard to follow the macro logic."
> 
> I squashed patches 1-4, 16 and add more detail description in the patch
> description.
> Can you help to review the patch series?
> 
> 
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
> 
> 
> 
> > -----Original Message-----
> > From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > Sent: Monday, May 17, 2021 10:39 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> > Subject: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
> > sriov
> >
> > This patch series are used for GC/MMHUB(part)/IH_RB_CNTL indirect
> access
> > in the SRIOV environment.
> >
> > There are 4 bits, controlled by host, to control if
> > GC/MMHUB(part)/IH_RB_CNTL indirect access enabled.
> > (one bit is master bit controls other 3 bits)
> >
> > For GC registers, changing all the register access from MMIO to RLC and use
> > RLC as the default access method in the full access time.
> >
> > For partial MMHUB registers, changing their access from MMIO to RLC in
> the
> > full access time, the remaining registers keep the original access method.
> >
> > For IH_RB_CNTL register, changing it's access from MMIO to PSP.
> >
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 78 +++++++++----------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  9 ++-
> >  drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 87 +++++++++++++----
> --
> > ---
> >  6 files changed, 97 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 3147c1c935c8..4e0c90e52ab6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1147,6 +1147,7 @@ int emu_soc_asic_init(struct amdgpu_device
> > *adev);
> >   * Registers read & write functions.
> >   */
> >  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> > +#define AMDGPU_REGS_RLC	(1<<2)
> >
> >  #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg),
> > AMDGPU_REGS_NO_KIQ)  #define WREG32_NO_KIQ(reg, v)
> > amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ) diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7c6c435e5d02..a2392bbe1e21 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct
> > amdgpu_device *adev,
> >  	    adev->gfx.rlc.funcs &&
> >  	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
> >  		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
> > -			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> > +			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0,
> > 0);
> >  	} else {
> >  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> >  	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > index 4fc2ce8ce8ab..7a4775ab6804 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > @@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
> >  	void (*reset)(struct amdgpu_device *adev);
> >  	void (*start)(struct amdgpu_device *adev);
> >  	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned
> > vmid);
> > -	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> > flag);
> > -	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
> > +	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> > acc_flags, u32 hwip);
> > +	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32
> > +acc_flags, u32 hwip);
> >  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t
> > reg);  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 2a3427e5020f..7c5c1ff7d97e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -1427,38 +1427,36 @@ static const struct soc15_reg_golden
> > golden_settings_gc_10_1_2[] =
> >  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff,
> > 0x00800000)  };
> >
> > -static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset,
> > uint32_t *flag, bool write) -{
> > -	/* always programed by rlcg, only for gc */
> > -	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
> > -		if (!amdgpu_sriov_reg_indirect_gc(adev))
> > -			*flag = GFX_RLCG_GC_WRITE_OLD;
> > -		else
> > -			*flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> > +static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32
> > acc_flags, u32 hwip,
> > +				 int write, u32 *rlcg_flag)
> > +{
> > +	switch (hwip) {
> > +	case GC_HWIP:
> > +		if (amdgpu_sriov_reg_indirect_gc(adev)) {
> > +			*rlcg_flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> >
> > -		return true;
> > -	}
> > +			return true;
> > +		/* only in new version, AMDGPU_REGS_NO_KIQ and
> > AMDGPU_REGS_RLC enabled simultaneously */
> > +		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags &
> > AMDGPU_REGS_NO_KIQ)) {
> > +			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
> >
> > -	/* currently support gc read/write, mmhub write */
> > -	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
> > -	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
> > -		if (amdgpu_sriov_reg_indirect_gc(adev))
> > -			*flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> > -		else
> > -			return false;
> > -	} else {
> > -		if (amdgpu_sriov_reg_indirect_mmhub(adev))
> > -			*flag = GFX_RLCG_MMHUB_WRITE;
> > -		else
> > -			return false;
> > +			return true;
> > +		}
> > +
> > +		break;
> > +	case MMHUB_HWIP:
> > +		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
> > +		    (acc_flags & AMDGPU_REGS_RLC) && write) {
> > +			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
> > +			return true;
> > +		}
> > +
> > +		break;
> > +	default:
> > +		DRM_DEBUG("Not program register by RLCG\n");
> >  	}
> >
> > -	return true;
> > +	return false;
> >  }
> >
> >  static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,
> > uint32_t flag) @@ -1518,36 +1516,34 @@ static u32 gfx_v10_rlcg_rw(struct
> > amdgpu_device *adev, u32 offset, u32 v, uint32
> >  	return ret;
> >  }
> >
> > -static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32
> > value, u32 flag)
> > +static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> > +u32 value, u32 acc_flags, u32 hwip)
> >  {
> > -	uint32_t rlcg_flag;
> > +	u32 rlcg_flag;
> >
> > -	if (amdgpu_sriov_fullaccess(adev) &&
> > -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
> > +	if (!amdgpu_sriov_runtime(adev) &&
> > +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
> >  		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
> > -
> >  		return;
> >  	}
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		WREG32_NO_KIQ(offset, value);
> >  	else
> >  		WREG32(offset, value);
> >  }
> >
> > -static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32
> > flag)
> > +static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset,
> > +u32 acc_flags, u32 hwip)
> >  {
> > -	uint32_t rlcg_flag;
> > +	u32 rlcg_flag;
> >
> > -	if (amdgpu_sriov_fullaccess(adev) &&
> > -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
> > +	if (!amdgpu_sriov_runtime(adev) &&
> > +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
> >  		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
> >
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		return RREG32_NO_KIQ(offset);
> >  	else
> >  		return RREG32(offset);
> > -
> > -	return 0;
> >  }
> >
> >  static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] = diff
> -
> > -git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index feaa5e4a5538..fe5908f708cc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -734,7 +734,7 @@ static const u32
> > GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
> >  	mmRLC_SRM_INDEX_CNTL_DATA_7 -
> > mmRLC_SRM_INDEX_CNTL_DATA_0,  };
> >
> > -static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32
> v,
> > u32 flag)
> > +static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32
> > +v, u32 flag)
> >  {
> >  	static void *scratch_reg0;
> >  	static void *scratch_reg1;
> > @@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct
> amdgpu_device
> > *adev, u32 offset, u32 v, u32
> >
> >  }
> >
> > -static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> u32
> > v, u32 flag)
> > +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> > +			       u32 v, u32 acc_flags, u32 hwip)
> >  {
> >  	if (amdgpu_sriov_fullaccess(adev)) {
> > -		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> > +		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
> >
> >  		return;
> >  	}
> >
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		WREG32_NO_KIQ(offset, v);
> >  	else
> >  		WREG32(offset, v);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > index 14bd794bbea6..c781808e4dc3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > @@ -27,28 +27,51 @@
> >  /* Register Access Macros */
> >  #define SOC15_REG_OFFSET(ip, inst, reg)	(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> >
> > +#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
> > +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
> > +	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
> > +	 WREG32(reg, value))
> > +
> > +#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
> > +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
> > +	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
> > +	 RREG32(reg))
> > +
> >  #define WREG32_FIELD15(ip, idx, reg, field, val)	\
> > -	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> > + mm##reg,	\
> > -	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> > + mm##reg)	\
> > -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> > field))
> > +	 __WREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
> > +				(__RREG32_SOC15_RLC__( \
> > +					adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> > +					0, ip##_HWIP) & \
> > +				~REG_FIELD_MASK(reg, field)) | (val) <<
> > REG_FIELD_SHIFT(reg, field), \
> > +			      0, ip##_HWIP)
> >
> >  #define RREG32_SOC15(ip, inst, reg) \
> > -	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			 0, ip##_HWIP)
> > +
> > +#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0,
> > +ip##_HWIP)
> >
> >  #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
> > -	RREG32_NO_KIQ(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> >
> >  #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
> > -	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > + offset)
> > +
> > +__RREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, 0, ip##_HWIP)
> >
> >  #define WREG32_SOC15(ip, inst, reg, value) \
> > -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg),
> > value)
> > +	 __WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
> > +			  value, 0, ip##_HWIP)
> > +
> > +#define WREG32_SOC15_IP(ip, reg, value) \
> > +	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
> >
> >  #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
> > -	WREG32_NO_KIQ((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
> > +	__WREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> >
> >  #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
> > -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > + offset, value)
> > +	 __WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
> > +			  value, 0, ip##_HWIP)
> >
> >  #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
> >  ({	int ret = 0;						\
> > @@ -77,12 +100,7 @@
> >  })
> >
> >  #define WREG32_RLC(reg, value) \
> > -	do { \
> > -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> > -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
> > -		else \
> > -			WREG32(reg, value);	\
> > -	} while (0)
> > +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
> >
> >  #define WREG32_RLC_EX(prefix, reg, value) \
> >  	do {							\
> > @@ -108,24 +126,19 @@
> >  		}	\
> >  	} while (0)
> >
> > +/* shadow the registers in the callback function */
> >  #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
> > -	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > + reg), value)
> > +
> > +__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg), value, AMDGPU_REGS_RLC, GC_HWIP)
> >
> > +/* for GC only */
> >  #define RREG32_RLC(reg) \
> > -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> > -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
> > -
> > -#define WREG32_RLC_NO_KIQ(reg, value) \
> > -	do { \
> > -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> > -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value,
> > AMDGPU_REGS_NO_KIQ); \
> > -		else \
> > -			WREG32_NO_KIQ(reg, value);	\
> > -	} while (0)
> > +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
> > +
> > +#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
> > +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ |
> > AMDGPU_REGS_RLC,
> > +hwip)
> >
> > -#define RREG32_RLC_NO_KIQ(reg) \
> > -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> > -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg,
> > AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
> > +#define RREG32_RLC_NO_KIQ(reg, hwip) \
> > +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ |
> > AMDGPU_REGS_RLC, hwip)
> >
> >  #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
> >  	do {							\
> > @@ -146,12 +159,12 @@
> >  	} while (0)
> >
> >  #define RREG32_SOC15_RLC(ip, inst, reg) \
> > -	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> > reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define WREG32_SOC15_RLC(ip, inst, reg, value) \
> >  	do {							\
> >  		uint32_t target_reg = adev-
> > >reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
> > -		WREG32_RLC(target_reg, value); \
> > +		__WREG32_SOC15_RLC__(target_reg, value,
> > AMDGPU_REGS_RLC, ip##_HWIP);
> > +\
> >  	} while (0)
> >
> >  #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \ @@ -161,14
> > +174,16 @@
> >  	} while (0)
> >
> >  #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
> > -	WREG32_RLC((adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> > -	(RREG32_RLC(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
> > -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> > field))
> > +	__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> > +			     (__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> > +						   AMDGPU_REGS_RLC,
> > ip##_HWIP) & \
> > +			      ~REG_FIELD_MASK(reg, field)) | (val) <<
> > REG_FIELD_SHIFT(reg, field), \
> > +			     AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
> > -	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > + reg) + offset), value)
> > +
> > +__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
> > -	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> > reg) + offset))
> > +
> > +__RREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #endif
> > --
> > 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPengju.Zhou%40amd.com%7C5593a422cc7e48b
> 80f6c08d9194308ae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637568597973904052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=a4brqHQ43K6fkF%2BAgWWclhZdgEs2SpThk%2BFYcmaInTM%3D&amp;r
> eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
