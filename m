Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E4C11F66
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD03613E4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD03613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0952F6E9A3;
	Thu,  1 Jul 2021 02:34:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83BC6E9A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 02:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFDTigstsoJVXiWCK7uDCHR/U6yPDqexdqsj/myDtw+c+OcEnpA34W2RS3xNjGxhlhGtYfB4N1JZiDWkTwgYg7p7r4FCs6H7jNdzvlrQo7x9HWAix2apkTuJBIxTj6SXtTuToRdYEHucl5kDuJKxmvDVjXsWl2wWUtQrYjTsk9XfIsMrdZj6m72uQMmm08OLaLv8ZUc7L7KUzcxedsXdnuvT9zsMRpDar2zzPliooKPgZ7CslyaN5Ym9kYF5GdHgpVxfUWWGySK8xXZQfa/0XTCzi9HsIf58cDz7GbLnb3TQDKefOlmxTiTgL70GqxPVv1FHGCDtzPKA9rFrU0xNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jRFz6O4QmzyFqzE5I2b36m4gv6jNLD9ZeMsp/gJCfQ=;
 b=Y57tMQ5jaFR1rcXSge+bxIi4+a40NjFT20sZjYpCg5CVZ3Gb6JvSc6SfbzQrAk9yaeIYMP1dZc8j4QrK/nbU+ZUf+JuSvvCnBTYxDlNpnJgIyau+mtqFkYjGUES9sDoxKB61us8g50yiHZ4cMNtDDk3X4xkCo3DzzqD7NCDEljtgjdVcRTTTI3LNdN9hpzgnP+iJbGdefAGq4MX7kBU5fRsGZhRyfE6GpB8iOZ9VtfqjrQkd8/AfXPfH++yUPT5lHTdO9pH0Uj0roxLR7LTnDpKinPSEF16etiuMjCqR8i2dMnIw6oLxQmj3b9T2tdsXSJMeSu1Un4oKNQh4g4K0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jRFz6O4QmzyFqzE5I2b36m4gv6jNLD9ZeMsp/gJCfQ=;
 b=iQyF0I9pKNFUPA9fjxbUfpYStd9pzTIYXArYFY4ZpkTt6guQ4Gxz4wQO4e/Xf7o7TF9+82ya68YeS3rGava4GoHgLkig/ZTvFMRGSzMB6Bx5tEA3zQ7v/aI1HZOwK+9h1vqV3Himppkr73XOf1iYWULsNebO+7zSB5sN4JwjXZg=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Thu, 1 Jul 2021 02:34:02 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6%8]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 02:34:01 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v3] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH v3] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXaY2Sx4Ttbpj/qUGxSli20g4VdKsrEr2AgAJcIoA=
Date: Thu, 1 Jul 2021 02:34:01 +0000
Message-ID: <DM8PR12MB5478BB6C80599B4195C551DAF8009@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210625064422.30590-1-PengJu.Zhou@amd.com>
 <CADnq5_NYoJeuvX8GY3qvkZyErXBtuBKhv4LT4TFtmasibG5ioQ@mail.gmail.com>
In-Reply-To: <CADnq5_NYoJeuvX8GY3qvkZyErXBtuBKhv4LT4TFtmasibG5ioQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-01T02:33:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6c93b243-cc54-483f-bce3-01f5b075bad4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f50dfb4-ff10-47ec-ff46-08d93c38b019
x-ms-traffictypediagnostic: DM4PR12MB5373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5373F173559D29FDEFB76F11F8009@DM4PR12MB5373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWLyT+DGgp6WfmJA6XZ6SPu8ZC4mpISZ9OEJav9yLR5disFnOvU2wI+GLxlGasYCUf9pcFxmJ4vs4rWKkL2VT3aSAqzW7jJxCa11Jqn4/IM+GhwmtZRZH36TN5MYq14EsKkJMshZn4mbouYXwOWl9z2LRpB9yR0xV+1rMtLuRT+stUBvagUdiePPOE4E+aOFVo/jCRIuoyoWPh/0mGLzD8zEJVUvb3Ji87fCRZ2Jwtj70GNKpa7TFWGvxExxItB4Od3hq0Ev8IqqJZarsrPFHXo2J5+cTzSqqRFW+INbpQ0pHUTGy0EfmuH76UK5G6UUQE9J6oM3ayfWZ5Y73+ddt36KgWlEUW88Yk0dGX4tFs3yMU9PgXa1NxH34f8j84HNtUkBypYhVIwm/lpHtpMlMKROa0q8Q/YQlnjEau/5c+Mg/jN5Cjj1nLU7JdG5kc+JjPV+aEF9LOt0H3jWwKXp8F99QMwzgljeXZFVPHlFlPLbHHi7ylqaQi72RW/CRY9KbJUK6mBdgWI6dLRawqd1TfsXWgMNCrXaoWO4c0EqHNV26U49jYXLkYgilAs2opcqep/TBJhzQDcyTB4uRIyqA9dc8QFVG8cShvHYBsyEfjWbWW8+uG0GhHW2VKmi4j25lmccyuuIiDf3uERKeRfWFGU5VogBIwQd71o01SPHskNcp4HilklQ6xn5oj+Ky1nmWSSjWXcEwSRVdahBvXdPNyu1kAlVn6rc6jOWiV849TB5Deb7QjuQatYVMIDp8udMV07p9tlZ5oty24NhCjC+eg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(9686003)(66556008)(6916009)(83380400001)(64756008)(66446008)(5660300002)(55016002)(53546011)(6506007)(66476007)(33656002)(66946007)(45080400002)(76116006)(122000001)(4326008)(478600001)(316002)(966005)(7696005)(8676002)(38100700002)(186003)(8936002)(2906002)(71200400001)(26005)(52536014)(54906003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EvGN/yaWXMomi91qsSs3ZAAtdxjvanWr3aMmZDiwrrwTxoBQDNzYUVO5Td5d?=
 =?us-ascii?Q?3pf8dhpNPStZBhF/e/XILyV8oUlcCkP6cByqOGMnXE5+OJSfqWoDopfkbela?=
 =?us-ascii?Q?V7UJuOiUdqnRtwjrbMcV50v9RoLyj4DeXzHg7SFEv+F4xLpepBm8Zt2lZ8AO?=
 =?us-ascii?Q?gPJR6gXnsZ2IP72+7nC6qWpeSJewlbW7peqphkaz2j4XcPLQfkrFg9U6fev7?=
 =?us-ascii?Q?O7q+i4IguE5J05WBGwygozZTwX6gx6y2D4xxrlDSytxmMgHkIsCG8g9DLfcq?=
 =?us-ascii?Q?pzaM22jCV/nzzXN0IOoKuvcrICMlqBnq6I0BoaySLjvTSEGjx83leXyyqV2v?=
 =?us-ascii?Q?HPCHTlWnkkWa//vfR643IvMY2kJf74Zcw4g5m2zMN0DM5RAVtMKs9j+f8Rh2?=
 =?us-ascii?Q?49Mx8HgZPRtfQC+vBU8Z6PLjKflHi9wua80XY6HI7nBBOWG7eBpSJ/WJkFen?=
 =?us-ascii?Q?pExbIlr/CH7jcMljvNX2ByoTBRygEquuBUhYdEpG99TSTwpdm8R/DPSgVKnd?=
 =?us-ascii?Q?of+O7cMr3vqdoVtkaGnBQlUzurB5xPyJc+Fwq5enaQN+e6IrjKJlXZXJ9Ei5?=
 =?us-ascii?Q?rcBD3BzYI5ubNWi5D6TIAWKkLIzrUF8D2KdAPfAheQdV67mmhj4PObn2nYFD?=
 =?us-ascii?Q?fl9vQwHKb2WULiD0c3KPuztNNO/ma9xZOI8u6B7pIMY+YnX7/PaobOOotTpb?=
 =?us-ascii?Q?Xeyh2UcJ2DDpXO0FO3uSqb0Ac5pshYriQh7kR5lv22CI/x/KiZeSJe1rhWj5?=
 =?us-ascii?Q?WJjyyAZRV/Rzvy3rWCSII/llrS71w4YhyJbc4Bss3gD0vV1UoF0IbJKui49v?=
 =?us-ascii?Q?8xhosrGbrTOENsn8F0OjW0PagaOFsKu+kExGXKI7j7cCGG3R6tmQLcgbgjsE?=
 =?us-ascii?Q?XNWzemRBAxHlvQG2j3qB8SvLS6KHoKgtOFZRKygZTYKsNiqG8M8OIQGfzMyv?=
 =?us-ascii?Q?Gwf/buwgn5BQ/jk9ZNhSgzl5+PJvmFWKRCbBiR1ysiN7YMJgbJOfN04mWMVi?=
 =?us-ascii?Q?2YFoyWL1skHwVNQ6sNhQ6LcdhXR7crWndAguPdUPqwUUk33yJAI6dwjNfrBB?=
 =?us-ascii?Q?QmU7qOr3+1uGkmWbfVoyFaBO9Ar+XOKkEWGdiyqEfWvejSMLkPJB5YghnKHb?=
 =?us-ascii?Q?f9YmPkT9vlE0QEZPJMUtT4YJVVPTGsA7cn4tsAJfhTmexmtC9pLtjrRQfpcP?=
 =?us-ascii?Q?oUJKfC1YVwCmMxqOIkU5eXf1isutaJpDMlZY4J6dWZlP/uO8iIqf52aCRZMI?=
 =?us-ascii?Q?2qiVh6rdDIA+eOtCOAmEE14JdFfRaLTvi6wr8owhHUUXLlQNuohddWk8pGdU?=
 =?us-ascii?Q?DfMRcDTaZi+xijmVzOYOqzaK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f50dfb4-ff10-47ec-ff46-08d93c38b019
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 02:34:01.8710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUuCJEBSg91y/fSZgs7hWJ2sNPpKpoqAOKq3GazQVvtOASFDwzYlAPfhU8my8+tvZCyJGKoBhaUkUM4xXCfqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Alex
The function amdgpu_restore_msix is used for reset the msix during board reset(sriov reset or asic reset), it moves from host to guest, so I think a flag to indicate if msix enabled is not needed.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, June 29, 2021 10:28 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily
> <Emily.Deng@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: Restore msix after FLR
> 
> On Fri, Jun 25, 2021 at 2:44 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
> >
> > From: "Emily.Deng" <Emily.Deng@amd.com>
> >
> > After FLR, the msix will be cleared, so need to re-enable it.
> 
> Do we need to store whether we enabled msix in the first place and then
> decide whether to enable it again in this case?
> 
> Alex
> 
> >
> > Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > index 90f50561b43a..26e63cb5d8d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -277,6 +277,16 @@ static bool amdgpu_msi_ok(struct amdgpu_device
> *adev)
> >         return true;
> >  }
> >
> > +void amdgpu_restore_msix(struct amdgpu_device *adev) {
> > +       u16 ctrl;
> > +
> > +       pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, &ctrl);
> > +       ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> > +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, ctrl);
> > +       ctrl |= PCI_MSIX_FLAGS_ENABLE;
> > +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> > +PCI_MSIX_FLAGS, ctrl); }
> >  /**
> >   * amdgpu_irq_init - initialize interrupt handling
> >   *
> > @@ -558,6 +568,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
> > amdgpu_device *adev)  {
> >         int i, j, k;
> >
> > +       amdgpu_restore_msix(adev);
> >         for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> >                 if (!adev->irq.client[i].sources)
> >                         continue;
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
> ngJu.Zhou%40amd.com%7C409895f80e0d43ecba3808d93b0a15fc%7C3dd8961
> fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637605736778199787%7CUnknown%7C
> TWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%
> >
> 7C1000&amp;sdata=w%2FgDzhoAjDraAMiyfx3XTPxx1QNff3OY%2BZWn1NYq%
> 2Ffo%3D&
> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
