Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432AC43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577002072E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WD8gMIFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577002072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE0F6E038;
	Wed,  1 Apr 2020 05:44:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DD46E038
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 05:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZfHSblTOw8SW4TASOleqp4YYxflEyJ6iF7zTj0TmcbYbbp+OhybCPbqzYkalnhf/EHXLlVTpf9XFrNuV5zk6YJwdbKG//66nGaZ4oyLqbd44HoMX5D5H2yCBVmLolfPjwoYh8tj8oJZN+MYXcndlPkw0+kN/hEvNCvGuuB6AorqTmRK+NbgoQtEjqE5h6y/V7ZyDNWMF6YzCAKUQQZLTDkaAtEHJeyaJ+T33EWpeFWuektzux1q2q4oIZUSuT3aeRpg8XVwyvoMvFugMAN1C6xwws3m99IuISRbQmOW5bd70ybG3OqaWrP+w8cgHHFVAMnhThMb/e78TIBikTTWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utpvblf7781gLekbc/y0VOd8RnfUFk63zhRn22i+P78=;
 b=Q1tc1KMcoRA0fupYCwnKCtUBAeM+9DepV9lsqNQbV4G3vc6fFqH2Kc3qLnsded54vlMNcsxpF1LLscV28WXRjnGU5b/b84oDQXMin6oDOSAbdOiflx22GmUM9T2E3w2bUjIyIT9kmQGqDcb18LlOAQ4bVjdSZms9PQ3H8S132TUdHCehXXKLosmhm95bKWfPm2mztNCTR6FA4zhjySi2iinXS+lD9wm2BIbVFX6tFaAx8zIPiKfMpoYlbGKB9rtrP/VTAr3U/IoEO/wCDpr0m5oxe1dp4gP3Y+gqB9JsRqtkhfnlpadugo3tRofsdJk0ZpMd0/Ar7/rnr/6EL7QaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utpvblf7781gLekbc/y0VOd8RnfUFk63zhRn22i+P78=;
 b=WD8gMIFZEk6hiJLU8Y7EA/hd2QJnytdw1wHFeNA/k0l2uOnKIDIDyR4Yj8LtO1KnqBT6p/dWeUKJgyB+sgUxuhUG7AEXgwebrjUGRsmoSPKesQNocbyP0Nbw2ZWXd4gHRkwgdTDAUc8sXX4tT6gCyWlmkqbk6VFKklPUaSqtRl4=
Received: from CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16)
 by CY4PR12MB1925.namprd12.prod.outlook.com (2603:10b6:903:120::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 05:44:24 +0000
Received: from CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a]) by CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a%9]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 05:44:24 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK for DPM states consist of three entities :FCLK, UCLK,
 MEMCLK all these three clk change together , MEMCLK from FCLK.
Thread-Topic: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK for DPM states consist of three entities :FCLK, UCLK, MEMCLK all
 these three clk change together , MEMCLK from FCLK.
Thread-Index: AQHWB2Im/ZO9krmtdUuKOXDWIzYihahjvi2AgAACeLA=
Date: Wed, 1 Apr 2020 05:44:24 +0000
Message-ID: <CY4PR12MB1749D5F78248883F13E9D2828DC90@CY4PR12MB1749.namprd12.prod.outlook.com>
References: <20200331101016.2960-1-Yuxian.Dai@amd.com>
 <CADnq5_OfZKpAxCPQ5jJ3Xq=4vJYaq7OnpBHpocODOmAYE+9Lhw@mail.gmail.com>
 <20200401052910.GA30750@jenkins-Celadon-RN>
In-Reply-To: <20200401052910.GA30750@jenkins-Celadon-RN>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-01T05:44:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19153ac0-e58a-4ecc-99a1-0000d2b55f8f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-01T05:44:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bac8f122-79cf-4d1e-bbc3-0000cb156dbf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44109c30-9c93-438b-83b3-08d7d5ffbc4f
x-ms-traffictypediagnostic: CY4PR12MB1925:|CY4PR12MB1925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1925CC2CB0D124CEDEC30B4A8DC90@CY4PR12MB1925.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1749.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(2906002)(81166006)(45080400002)(71200400001)(9686003)(81156014)(110136005)(478600001)(8936002)(316002)(55016002)(966005)(6506007)(66946007)(186003)(66556008)(5660300002)(33656002)(7696005)(52536014)(4326008)(76116006)(86362001)(66476007)(8676002)(26005)(53546011)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYuCYtx2k2LlNqsHd9CSbR2jMRjVw3u0s5Oem7w7UuxnpXg2EVLVWp6ejUy1Y0nucejQpxB/NYMXp54c7ilao+M34b3SqJ3RliaXqZZOTEoQS2gIsEfZlztJB6ZJ8JZKv38c3OcCpa+VW1jqUd64cRHVSrcYs/wnkjn11QwIsNRCOUCUicaMgSxD4sJDJBhyFhQchkrWS6imxVvNeSyBXRGJFUAfmY3KwqF07cAqhn10hospVBZMkDbUV8jhuH2Rx6q+SqY4r5NpPJNXlIJY79IeX4rDLr9SDheYyIw2H14KnhlwYTTWT7UMJ892rq0J1IlPE7+rGDnVqclS/i9XJH2P/LuzgYvsKNZDW1W0dpxtYkMYOhxCtm/KbLKRxBxXjHP9O/KzNgyYMN8XNQSYVQp5dZYNbE0IWwwxt/nj5RYNzmNPTzvfo9lwOmXrR1DY+XHcRBo+Bs73FIZElUx9/SsBcmTVJFccW3ORMqt50G8zwe7zlwSIwCJDbR1LuygG5iBK/ncbD4CkW3inCOb35w==
x-ms-exchange-antispam-messagedata: k/FXiLfajaCupXlU3OBSoj60Gm9bgYi+OSeaN35JvTrGkSSNlz/ry1yxlFyPABbiQFjupFmHuw+A9hGTmmKT7JHvKKk2y/hUoAykI1fu0nJTBEUWlmvOJBzW5alZ+OjB5pAWZnKaisdcX2hRf2VcAQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44109c30-9c93-438b-83b3-08d7d5ffbc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 05:44:24.8079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBgBgptjuI4JLmK7/gkhQMBtMIita8TYSIHPRJNp+WerO1y5LKJw81Un80O1zy0Z9pdOUkYYz6P2oCWJpDctpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1925
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

On Tue, Mar 31, 2020 at 09:41:44AM -0400, Alex Deucher wrote:
> On Tue, Mar 31, 2020 at 6:10 AM Yuxian Dai <Yuxian.Dai@amd.com> wrote:
> >
> > From: "yuxiadai@amd.com" <yuxiadai@amd.com>
> 
> Your patch title is too long; it is basically the whole patch 
> description rather than just a title.  Please split it up between the 
> title and descriptions.  E.g.,
> 
> drm/amdgpu/powerplay: fix MCLK DPM handling for renoir
> 
> Using the FCLK DPM table to set the MCLK for DPM states consist of 
> three entities:
> FCLK
> UCLK
> MEMCLK
> All these three clk change together, MEMCLK from FCLK, so use the fclk 
> frequency.
> 
> With that fixed, patch is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 

Yes, and usually, we don't leave the commit message as empty. David, you need describe the detailed info in the commit not the title.
 > missing  a blank line, so the description  confuse you . I will update it according your suggestion.
Thanks,
Ray

> >
> > Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
> > Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h 
> > b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > index 2a390ddd37dd..89cd6da118a3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > @@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
> >                         freq = table->SocClocks[dpm_level].Freq;        \
> >                         break;                                          \
> >                 case SMU_MCLK:                                          \
> > -                       freq = table->MemClocks[dpm_level].Freq;        \
> > +                       freq = table->FClocks[dpm_level].Freq;  \
> >                         break;                                          \
> >                 case SMU_DCEFCLK:                                       \
> >                         freq = table->DcfClocks[dpm_level].Freq;        \
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%
> > 7Cray.huang%40amd.com%7C541f2e15da804d81c5b508d7d57949d2%7C3dd8961fe
> > 4884e608e11a82d994e183d%7C0%7C0%7C637212590166168794&amp;sdata=7x4pB
> > WEPuVHbb8ro%2Fpy5%2BgiJhrxWbLrxGqHSro9KUV8%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cra
> y.huang%40amd.com%7C541f2e15da804d81c5b508d7d57949d2%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637212590166168794&amp;sdata=7x4pBWEPuVHbb
> 8ro%2Fpy5%2BgiJhrxWbLrxGqHSro9KUV8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
