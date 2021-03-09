Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77559C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7676528C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7676528C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102806E45D;
	Tue,  9 Mar 2021 04:45:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3474B6E45D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlG1i2FZeanuiNhHyPSW2vhS1TazyybBPVLH0ofTxYQTDEsbfKuMQs8Aqf/HhuMp0tVG0f+Epdavr31ATANCsfiqudd9Q9hmfNJmRf0PVvwdnVaVVC/jpchTfZQNT6lmUGRqEJE17wy00eU4FmthUy9hkIRMMC7dBe6qpowLI6KbKjEISrXXmGZd7uBCdQ/K/yIwvO7BQ4OUHP7jSBcd9ZF5k6i59xutP3HImj/UAVTgpWMB2jt/wUsdLh7U9LzbBaMwAB7OSNdAaBuvg81WJIIaerwi7AFnciA663pQTY8TPX/4tSDjweyR1aCmJIaOC5JOI2bwzLFw8Z7DGjUp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjLGpcon1tOPYWZC1AcGEkQY8iEh3BDOKEcDJvqDpEg=;
 b=VKqNLMJClrNV19FXMu7tiAfqud/DZHmhJcG03ON3Qi9lu5nnp6+xMDZ3NLkj27c46GI2LTCwfOQe08HeD0wBTF+0aQpirAI2K3ASnppXTcTawsPKOweQmTh91cvV3Ew6hwvYwAayJRvINgaMup5a/LqjvG5lxL0GSMjv14YQ6/9NkLLLXi7eXHaaeCEvJdbEGN18r1SCIsup5otKBNNelEUq5eEwzN5nO3DdXauqvZpo79gkDOK20q4HAn4H4NQ6u9RWCDa7188NjudX+BW912KbYEw8eDjKQdjnX797lscl6NbKxMf2TAhPtabilLDc7iiQAnZ6EvJtZhNNfnH2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjLGpcon1tOPYWZC1AcGEkQY8iEh3BDOKEcDJvqDpEg=;
 b=mUt3fBR5BHjSpMqDi4NV7EE7sNMOIeqmERAafZoFsPnBCjHGQ/Tq7OjVW7X/g5wmt6GFOWtOFsyjihbCmjQp6iBrOShXAR0QGXgikgYsOJQP2Y+kz4cS15OTvMEE36/MNdpmFkUfwRU9Yd2bOj1iJKcOsP/yL9lLN9SkLrn/IZI=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2968.namprd12.prod.outlook.com (2603:10b6:a03:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 04:45:44 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:45:44 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
Thread-Topic: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
Thread-Index: AQHXFJePvLjuUbnxb0SR/UDHMfA/I6p7CiyAgAAGoqA=
Date: Tue, 9 Mar 2021 04:45:44 +0000
Message-ID: <BYAPR12MB3238314A7550F5A2C1AE846DFB929@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1615261905-10482-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_MWkxBLBX-U0rv7NMSX-vmt+2aKO1dNYDTv2sVhyx6bzg@mail.gmail.com>
In-Reply-To: <CADnq5_MWkxBLBX-U0rv7NMSX-vmt+2aKO1dNYDTv2sVhyx6bzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=35e293fe-a892-41f3-b8c9-bf548059ebd7;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-03-09T04:31:10Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 125c6d0f-5fa6-4b13-1414-08d8e2b6334d
x-ms-traffictypediagnostic: BYAPR12MB2968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB296885D492665D35387B722FFB929@BYAPR12MB2968.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQjXVBgMJdkvU9BDMR5Heu1iWe8kbWdE1exjJqiD89z84bs89JP6h/Nq/J38YzdbHqPDhZp8T3pSj8hr6splSCvNUWu+k8aw7aSljF/Z08c2ZDfapiwcbSumHr9iYBO5rSURJ0xH4q/e6CGFHdTZCoj4bPZIH83QF41Sln5t5UZnYBpBe/xG8AC4bqVLMypFL7n1Pltv1EuwYdwpRQNKXdz29BF7HMe9xJpVncc/0M7jYjXVxdnFlyg0PJNNfZG6LCGH3ownUFlNsVQTOF7He2TpZbUks02cdGofOjhRluwauIE4sn/1TB6WlAxXFtPgUC308tQFktJoo/KiaWpFRRzaqE3VHqYQRojAarIM33KPQ2xXg2D8SL0m5JeKzVyjPfT8C6qPUB/P18Kj9jH6i6yGfiQ0v3eyvlcdj1JCC7bGAmKArosv4Kl0uBCcJpFT5Q2iB+/kNvMNuxTzb+ZSdXHUKLOgPeE0C3nXXIEEqPL+6pHv/ImCs0ltSFgoNCZr6Ms1BzyXCe0It9V1VsTMdwbukC810l7eXz23ll2jMaoQPxpQDSeQPTsGBstPFj+fWXr/4x9B4/Ez4jgu5Ttlod1azOAY+SsRdP6xNHlT7p8NDjIyTLj+o7hO4h4MeJAklHQDie7P2/1+7aj/JXV18Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(15650500001)(66946007)(186003)(316002)(53546011)(6506007)(76116006)(9686003)(54906003)(66476007)(66446008)(66556008)(64756008)(8676002)(83380400001)(2906002)(7696005)(478600001)(5660300002)(71200400001)(26005)(55016002)(33656002)(86362001)(966005)(52536014)(6916009)(8936002)(45080400002)(4326008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?70OIGYEb5ypXuZlF39gSw9909tvHWxYhQu9Gjb6xGdHeYEAvxK/R3xkWNo2j?=
 =?us-ascii?Q?Rm07F4dJiOTZ5gO2SDrJDtww+KfuyshNHUCG7keepHCjBqQP6hs5th2jpIuI?=
 =?us-ascii?Q?HiY9n2hOgGm/HIpJaFx+DL+rBFGUc0O3dUlKSpAADzCtwVmunWYjuTEZrJpL?=
 =?us-ascii?Q?hIuSacnOy9Ra7OLdgV+nraXZarFGwuZck5E/AMdo1fySRAiO8QwVN9mbsphq?=
 =?us-ascii?Q?l9+4NmHPMgQj5wRm+Z6wtpvBbhZGCTCY1D/DBfJ31uVYngpZcwX+FARIAX8G?=
 =?us-ascii?Q?rxfpLdhm2GkpFQDloDlIzfrJWiw7No5vgizgd46o7+rXMbDZ1vGcZbkSlJlx?=
 =?us-ascii?Q?XgvaAkhz2OUvr41pi8OX7JBuNxgcJttISNwjxKUM1gbEes2I1XtMOqFzYlQo?=
 =?us-ascii?Q?ZelezTeQ+gvUnaBwS3CvfKTeaWsScVSImnKj0zeBma3L9L3ZoT71ICWePLVt?=
 =?us-ascii?Q?3eKbST0F0qQD06iZFyifSsLgHPWoy6BtD4592UaoaYuOIAuZWbIYexgijKyU?=
 =?us-ascii?Q?IBa9FhkAwraJZrHv6/ZYYRRzAxDjzwKPTz+lI7Or5rSjUbn/4ETqgQBOAu30?=
 =?us-ascii?Q?X9NCSdyg7/dkylB2uXihwGfERCzkPJ0xyqbYyAcnqsfi2m+RYj2f7nGE5ziV?=
 =?us-ascii?Q?i/qcA8HwsF22c52TmW+u+ieSsxhogfp8Qe502F8zE7CKUxk+T5RvYUopNIoj?=
 =?us-ascii?Q?gErIf5TTMvukdsmd1kaaeOg3TUeC85v+7HHAPbovJIG4yz90f+tGFb8qaUwm?=
 =?us-ascii?Q?ZHrfVeaefwGxTUnVj4qLT8oafP591s5j5XzlHlwGwA8qwSI6Y8iLdRg7OT8Z?=
 =?us-ascii?Q?DkvsNxQPzTXYV3lLPde/DBXmkCcS66b1HxCYB33cu22ZJs4Ypy9li/d/CuOi?=
 =?us-ascii?Q?aPTvHRADTzlTCVfZGQSCt1Lmh5Yim9zhCoMHBspm55lfXVUPdviS5znboiZb?=
 =?us-ascii?Q?FCmTO3a2kdB+WWvCRUDA0XDFq+0/owEWHBH/8u/scjH45+8KPXc8nnBECMVg?=
 =?us-ascii?Q?gZa4cMdn0WFDGA5sRicjMtROojKJBVhu0zi3MoJPE5YexLsiRRDzn+7gQbu3?=
 =?us-ascii?Q?RoY9TJdV0L1j3GcUSBcC4V8gfVk4ohuYn+eug/AxOitZugHnLHgmUJBKSyfa?=
 =?us-ascii?Q?ilLv8gwAroBLpDI/UFOmU9slOByLfcYS6mluS7e/PF1iZPvFegINAJuWgrR9?=
 =?us-ascii?Q?tkyUzggQJjWqrgBYEKUubQnLUhgp6GPU2RTs0ZSmKNRnborMj+sHVYFvet4E?=
 =?us-ascii?Q?yeyFZLi0IV2Uikudl8lQIJil5uWj3wBcnWUoYL7jNkKn75T3AlwSb5Z1ZysD?=
 =?us-ascii?Q?EZVoC2m3IeCploYaASoMZ3Lf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125c6d0f-5fa6-4b13-1414-08d8e2b6334d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 04:45:44.4840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fw4ixNy3pRVXsvysOWdeMvn2B5zLCYM/nkjAjGUFSsvV0DJiBreQ1Utoeb33ZIZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2968
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, March 9, 2021 12:07 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
> 
> On Mon, Mar 8, 2021 at 10:52 PM Prike Liang <Prike.Liang@amd.com> wrote:
> >
> > During system hibernation suspend still need un-gate gfx CG/PG firstly
> > to handle HW status check before HW resource destory.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> 
> This is fine for stable, but we should work on cleaning this up.  I have a patch
> set to improve this, but it's more invasive.  We really need to sort out what
> specific parts of
> amdgpu_device_ip_suspend_phase2() are problematic and special case
> them.  We shouldn't just be skipping that function.
[Prike] Yeah in this stage we're just try make the s0ix been functional and stable. The AMDGPU work mode is aligning  with windows KMD s0ix sequence and only suspend the DCE and IH for s0i3 entry . Will try figure out the each GNB IP idle off dependency and then improve the AMDGPU suspend/resume sequence for system-wide Sx  entry/exit.  

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Alex
> 
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e247c3a..7079bfc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2683,7 +2683,7 @@ static int
> > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> >         int i, r;
> >
> > -       if (adev->in_poweroff_reboot_com ||
> > +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
> >             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> {
> >                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > @@ -3750,7 +3750,7 @@ int amdgpu_device_suspend(struct drm_device
> > *dev, bool fbcon)
> >
> >         amdgpu_fence_driver_suspend(adev);
> >
> > -       if (adev->in_poweroff_reboot_com ||
> > +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
> >             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> >                 r = amdgpu_device_ip_suspend_phase2(adev);
> >         else
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPr
> >
> ike.Liang%40amd.com%7C641ed997755644a7c30a08d8e2b0d7bf%7C3dd896
> 1fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637508596461291719%7CUnknown%7
> CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C1000&amp;sdata=J%2Figj9QUO6Vk74BeE3udM5yVgloUanpXtJUue3pJoFI%
> 3D&amp;
> > reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
