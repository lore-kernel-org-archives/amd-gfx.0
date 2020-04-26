Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8990FC55186
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 03:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEAC20714
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 03:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VZHC/tIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEAC20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0236589B30;
	Sun, 26 Apr 2020 03:22:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0EA89B30
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 03:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNNzwb9pSr+GmZzyLOId/AO5dEcRbx+JLResKk7LLsy5w9SGVVDoRvmTQ4fDR57gPpPhZOKJO/1nzyEOsaGK0Z9olRYvfucr1heW8Qi2n6Ken2NnJGeWuqK5psBn8//pyGLSObsUkxjN7L61oaV2GF3enxarKtuC4oBRFCJDB+vGeiiSAvgeT/oke+ls2hukOqT1aIb2bIVfriqNDfv3q4KOHtUVoG5OrXvGLKSRkc1eRoUNMemvg042VJidaeP8Gg2vg4gdCsfNyw25twbhj5eWfmlePdiL5f5DpbmlB0qLzteYOIcbOiXSjdY5B3invbtBgbv3jurz+hf6DN7oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9bymKMD9RoFuv/oudVrY0ngSotLhCj8znKvYKB8IsI=;
 b=i2Q8iHVCVM//3RrVFD1mNeQ8TYecpGF5AnIFXr/O4pLBNsLQ9PXvvjhvRKKTesMD9DoFcitAEc51PHsi4+G3uevjCzriE2+pXSC0t+ZqP9GbLfF4F4QOvN4+IyoKsK80ufa/UAtCCOAGAod9Txn4t/EBlKsUYOFDqoivccK8VVmVAnnLHAlEkNDFKrm6dHbRoTWoiNlY5S0l7CV4bTPIqjhxC4N4CYeizFhkISs32SOBVk9FkMRMfmhjFLJnrzJdqC2tdz17BySdO9vPlr7P2HO1JmqTux8Iy+CxpFm4sRoVMUHkm288a+57bKVnHyhtL+GfBs4Ntjj3FyWzRK1dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9bymKMD9RoFuv/oudVrY0ngSotLhCj8znKvYKB8IsI=;
 b=VZHC/tIZtAymyL4QZY4L0rlVny+JGoRsoy8bQHfzCo7rNblNY9Qv9YbslM+A9N8+9b1yOVxY06SxfqwfZDuLSsWprJkKfskm3FKQYrpnFfbCqOm5Mhx7g24K+zB2joNBnhHgapSevCNv356pz5CywKncIyxxFPXLeBp7yMJkt9w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.30; Sun, 26 Apr 2020 03:22:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Sun, 26 Apr 2020
 03:22:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter
Thread-Topic: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm
 enter
Thread-Index: AQHWGg84TbRAQ8V/Wk2JaM1P/5vKQ6iITf8AgAAALQCAAnEOkA==
Date: Sun, 26 Apr 2020 03:22:19 +0000
Message-ID: <DM6PR12MB2619209C59D85E98601E14B6E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200424080547.25599-1-evan.quan@amd.com>
 <20200424080547.25599-2-evan.quan@amd.com>
 <CADnq5_PB_1Pef-C923gNut2+neF_1yxXPhzQUCWGvgLsyc1-eg@mail.gmail.com>
 <CADnq5_OTeEvqXWBOkjL1z8rqNf_-32DEPVHjdok-Hhcksay7eQ@mail.gmail.com>
In-Reply-To: <CADnq5_OTeEvqXWBOkjL1z8rqNf_-32DEPVHjdok-Hhcksay7eQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e54c9901-34ff-4122-a367-0000c2675b3a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-26T03:20:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54c4c4a7-5912-41c7-257d-08d7e991075b
x-ms-traffictypediagnostic: DM6PR12MB2649:|DM6PR12MB2649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2649FED2A29C9669A8421E1EE4AE0@DM6PR12MB2649.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(26005)(6506007)(9686003)(53546011)(66476007)(8936002)(83080400001)(54906003)(316002)(81156014)(33656002)(66556008)(7696005)(66446008)(64756008)(52536014)(6916009)(8676002)(76116006)(66946007)(55016002)(478600001)(5660300002)(45080400002)(86362001)(4326008)(2906002)(966005)(71200400001)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N49d4KtyE8eVgYHlBM+iZPlRaxQ1ROeWTgZclSQOL2Ep1OB38l+6joSX8b4TMshU/hN3P5a3scHqn+57WHhwCjV5HembcQ8ngWvIcvrHij5f68DD7K14cWOysMevAxPCKmijvTEttMcdW82/IWRMoubo05ULKo7LN9vupp7nD+n9j0i737FI/GH+cvF46XOE2zAxPbXUdQfieeOObo0N6JGgg1SgjHQm8MoIltZazKdMpcjRdqj4hG3TkO+UZNwMOS0NYvQn4ikoWwK0fN6DrHKXfJtH0jrPDHloh7kovY/fIdzGc4EzKRH+6TPALghr0JBsjmLDlkfE5VGtJ593cneKH81ijHu6+tl1vpig5IJcmVWFHWsEOaZOt/fVpJCIVNzANq91nRDDW4EsGfiqfxT/AJX09eI+pdQ7Rz17bId/qku3ZyvTlCocSVo4X/BWfgG5Xnw8JuKha+H+zg/Yk5GYT4j36Ujc4SzJOS6LZJ0POiyHQzyqrl8U/zz/FSin/T52yBpVQwpL76ZbCu5kRA==
x-ms-exchange-antispam-messagedata: QXWTpQpXuMpsdv7uVWbw0N4y7MIXlbObvDeUSWCnCmXgA399hoYsNx8CGu4BC9XAmLA6aHbgW15VdbtfTY58enDpO0LMsBX9N9dRbspsFcXk7K3fevfs2cFCZHefLnzLgXWp/x54bfw28ZB8P5BYbW9xouM5AK+O36O9GgNo2RE189XY3ZnbM71pKeb2mc4DBEufEmImX+vKbShdbdOZfwVzrOy5Nawfx+wMrbFpBSv/L6XLAaIFPmA48TM+YPr0pGVNseYJacH5qxOW6SMt5t30qbIKbWojgdY6zSTl+R32UZ5ZX7E4BcPssXY7IYq04b8OzaROfpP7dzOnFxPA/U3qoHc8jDiTOyN9GMstfIvlGAggNxteJx8LHvl3rWaA+rb4CylmcPmyfuPf6rqprZ8uRGw2rqTCmZRIqktWa25cLcEUKKTZxZrwaOlks+OE9fv+GIjR/gEr3te6aokNOcwqzwZlCDBph6cBk1aCNB0yhb30ZCFLQcNSyzVvIMijERlGbant3ktuHlVIHOhTWKO1L42LsPSb2Ccak2p29ePST3eTtu+17jmLPwJJMga2ojqAix/K/jfvpcK4BmBe9FNbHHK1fY30S14m6RVxptnf2VpqQusP/+iG1zVToEwElEte9uP6t1ZOMS2HMBB0edAzwl+CgkxFsMG8zHTjf7/yaHo2PVWPioOWaqzm2N6zduf7WFLHPDVKG49D01CflYFanzvzAcRezy7kb8tqISnHaP7CsIxdrIB/neO34RAqHkR4dqlu7a03HVx42D3+cwdV0WEqREw0b+qxZjC1HPs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c4c4a7-5912-41c7-257d-08d7e991075b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 03:22:19.8258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyCdHj7BEYaAQieuNlDWHPm9AAKJA0+DLYjGjZLVlC2CKC58z/SMIbBH0C8A60JU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Corrected this on code submission.

Regards,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, April 24, 2020 10:04 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: Re: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter

On Fri, Apr 24, 2020 at 10:02 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Also, I just noticed a typo in the patch title:
>
> drma/dmgpu -> drm/admgpu

Can't type.

drma/dmgpu -> drm/amdgpu

Alex

>
> Alex
>
> On Fri, Apr 24, 2020 at 4:06 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > CG/PG ungate is already performed in ip_suspend_phase1. Otherwise, 
> > the CG/PG ungate will be performed twice. That will cause gfxoff 
> > disablement is performed twice also on runpm enter while gfxoff 
> > enablemnt once on rump exit. That will put gfxoff into disabled 
> > state.
> >
> > Change-Id: I489ca456770d3fe482b685f132400202467f712b
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 08eeb0d2c149..71278942f9f0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3453,9 +3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
> >                 }
> >         }
> >
> > -       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > -       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > -
> >         amdgpu_ras_suspend(adev);
> >
> >         r = amdgpu_device_ip_suspend_phase1(adev);
> > --
> > 2.26.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%
> > 7Cevan.quan%40amd.com%7Cca47ab8d659f48905ecd08d7e8584fd3%7C3dd8961fe
> > 4884e608e11a82d994e183d%7C0%7C0%7C637233338316990767&amp;sdata=LqQrJ
> > Q3XTLmdCWvCKEpxOXEatrSjoswoQEb%2B7QDahGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
