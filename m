Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB124C83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F982083B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="264WRWfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F982083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB086EAB7;
	Wed, 29 Apr 2020 17:46:22 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A036EAB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 17:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2UnWdNIQrvfIjMdZGgxzJDUcIqmTMrvpcma2qGHw5hcmjYXbWkhqMdR2VXSyRF43N2nyPmO8f1Y6sVH/kGLCAp1hrTZ95MCqiZ+prartoDcvDxTjTEDyrrODQOAk9u1jeVFz0gWirSvf41s02LPc45xIuqGSzBY9RDexm148anPw7hW0+7Cvl8xPd3Lp3lg+ub83AuAXGnK3+VD09sRExFv3zHS7hZXDu5QNGRVueLKM/yXPFOB5uZYAegD+NvP55Vvt7CLvLsZ8R59hf3Uu9WtYmSnh6C9rOTtFk1flfLwHyz1h9jxJNkDXGaCCfkiLkdmOF/Fl4G3MLp4hvAaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdjamWyhRhaFr3/9K+mhVhKJ6CgiAWHrAr+p5DOAOjY=;
 b=aE9QRrjF+rksbsyjy0seIJQlk8j7mfZr34ybegC9nkuDm+uJ1sDwpTRM4RR1ix/1M3pHwJJMvaN3Ex2E6+BIlPeVWuiwBipQZgK/PUN9Kiwv385l/ShViPDz/mzjkFuVawXBbzRqDQeJx7+rv5I3Qm9ojtXh9L2yOOzgDSI+HTV20R/INWrQHf7Sk00vn0FkSxB5+TDkgkvQCT4W/nG6x8gU72d0DICFOgQZbpqrglwXTGg/KVFr2V3Ce4QeV9D2ipGR3WVZEiT9tRNpD6Is0OFGGDZY58ZlyMMD6ue1ot/MLCeSoWPxtXfbaGg5nrQWjP1nnb9iIn3f6+nApKmy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdjamWyhRhaFr3/9K+mhVhKJ6CgiAWHrAr+p5DOAOjY=;
 b=264WRWfgX8x0sZwkqmIyKDr9oXpZgflYSmWC5XGABOilrThjACpaWgujQg5lozulBYxOPR2m18hGaado+ovQz28m+5BHu2G5ozBvCrDJZz6n0JJj9cQZMvUXIDT4R3Tv2Qbx+vjHhOWhKJH5/Tyf/j+/zNzIjiRLPLsCyumr5Y4=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3049.namprd12.prod.outlook.com (2603:10b6:5:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 17:46:18 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 17:46:18 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Index: AQHWHLOVWjB6qGVLjki2kiF3JIbFbqiQYN2AgAABmAA=
Date: Wed, 29 Apr 2020 17:46:18 +0000
Message-ID: <DM6PR12MB37213A00A15CB473F5A9AAC685AD0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
 <20200427164735.27409-2-kent.russell@amd.com>
 <CADnq5_Naii9wE7YH7G6geNWgnFC_AgdicaTex6irc+eGwnczMw@mail.gmail.com>
In-Reply-To: <CADnq5_Naii9wE7YH7G6geNWgnFC_AgdicaTex6irc+eGwnczMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-29T17:46:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6a1a6640-4c9b-47f1-8ce8-0000628b0c4b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-29T17:46:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 98964be1-782f-43e5-9e22-0000761b4de9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:d812:3a5e:6edb:851f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cce462f8-c7b0-4d34-f838-08d7ec6538e9
x-ms-traffictypediagnostic: DM6PR12MB3049:
x-microsoft-antispam-prvs: <DM6PR12MB3049E7B2728B523B0752142C85AD0@DM6PR12MB3049.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(5660300002)(86362001)(55016002)(186003)(2906002)(7696005)(52536014)(45080400002)(9686003)(83080400001)(53546011)(6916009)(33656002)(6506007)(66946007)(66476007)(71200400001)(966005)(64756008)(76116006)(66556008)(66446008)(478600001)(8936002)(8676002)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RGR6pQdJRVdM1eqeK9s6Usym9Lyb1hR02I2jFcabxAdSb0o7o3nQ7byqtiywo/4dooel39/47tmo16ZEVHe6vX1Xp13i5/Xf12vZYpO8go+zT2MObIP/bpHKF1XlwxEvu3BxNnH6N0IpDbmkve+7C+T32788yo7RaLg5Uc6dDIk0uMqPHkxAxPQrb17TwWk0MfsuVhR+EB7bkGBcbV8WqAqokg8bXhPWcrFo6MCMi/RBWEeZap42RyNZMzHftKYH9voi98pRprdiU+pgRzraV9CJIwVSDxRNu2FH5Wdg9uEK3SHLyU1WPJp+5a7clXMIK0hgmF0WweDe7pDCoW6MZcaYlSWiniZmxa4W/0h0h62nNxvOtOs8BgcyZXbJowu7gyUpaHGPZhgKMtbevwQUmg3Q4CA22ou3Y0oE7hejlgO7l7eEHeLWICZqtpQf6Y28s6obC8F7McedjZdQuhmOvco9QzOYgvn3k+CY3V712hBqBF/ATvz7ZcYhxWrMlyxuJa2QWgR3kfe/oLZLqucew==
x-ms-exchange-antispam-messagedata: Lk7zM0k5EtOTnsYy+GBzi0AwRIcozhWtsaWcreOws6FC/AgQ5mYxEHZbwK9cpoOHZi/QcGRdOdDWTvEdgBojHQWX6wFc5Ry2tW051U9MQwxlKMIyEPZKVbIru/0KTqSyLSgPUXBYzWHh44kar2pQgIVi7FILGpe9hRN94VFzz8MXobQjH/Ez90ROCVum4YjHpZ7yCg/oya0aEQOygW/9iM7cS/0wWBW+BnVQkz120jKiBGM7zzzbLBiptb9dB9Myt+aYSeAMIS+6I6ViXTrNFjF/w3+TBhzYkx0y2ckeFei+4uGHgg2Hi4srx2zJxEUTBA4d/1uWs4o/rJYH5t4jvVc4sE5cLik/zNiIeEuNaJSK5waKlP/NNHvvKbm59AZ0RK3uD5hlkvgnuDsMXrZymOI+/JI2kMzaKzyKfBzFSfRrzOAes6DfGmJS7Lfg47qTLEIrSf2PodUUb9k2bw62/rbdDZWTr3JwlaFXH6nWaHlPu2cWClag7PSVeo0ezm+zahG7WcqbE9d9eunrVCk8AqEHc4UK2TGdyhqo5ukmXmLfTvkRNLL770HwUQNAnpcR2gyFHLZtJLcigRm09WPd1GlzY/x2P/j4EjXJKZIatJJD+0awCVifrXLKRF5y1kxS7+/3bv9Qh//G3zSQbt6sR40L0FBDGhEV9+PxXF4Rs8bj3Klx6hjhFLqWtVccl5G1YciOghUP1SIzBjbn25qssUqywkWZD1nfpaA+QyQvc2q9ABf0JekpogNK/xc5UOJnNHs8yIt5oHHZP/EZWWl4/fbXb3Zpo+VJrdEn8zBiPeAjJ8inQUVFmw4tNYhQXSIgctMTjmM3/g5cTDLHAQWi9lF9t1NYTrWzrWuE+jxn9CQ+d5WCabVSG5yd5nSE6LTN
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce462f8-c7b0-4d34-f838-08d7ec6538e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 17:46:18.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhp4uA/aQvlZ3JyJ8xq3szzWcsIufGAIc8KWC7hspm3gJQV+E9q9tV8C44gMfoN6pO9/2rEEn8vtGIrRIu8UwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3049
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


> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, April 29, 2020 1:39 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
> 
> On Mon, Apr 27, 2020 at 12:47 PM Kent Russell <kent.russell@amd.com>
> wrote:
> >
> > Add support for unique_id for Arcturus, since we only have the ppsmc
> > definitions for that added at the moment
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > Change-Id: I66f8e9ff41521d6c13ff673587d6061c1f3f4b7a
> > ---
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index e98d92ec1eac..f55f9b371bf2 100644
> > --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > @@ -293,6 +293,7 @@ static int arcturus_get_workload_type(struct
> > smu_context *smu, enum PP_SMC_POWER  static int
> > arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)  {
> >         struct smu_table_context *smu_table = &smu->smu_table;
> > +       uint32_t top32, bottom32;
> >
> >         SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
> >                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM); @@ -315,6
> > +316,15 @@ static int arcturus_tables_init(struct smu_context *smu, struct
> smu_table *table
> >                 return -ENOMEM;
> >         smu_table->metrics_time = 0;
> >
> > +       if (smu->adev->asic_type == CHIP_ARCTURUS) {
> > +               /* Get the SN to turn into a Unique ID */
> > +               smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
> > +                                &top32);
> > +               smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
> > +                                &bottom32);
> > +
> > +               smu->adev->unique_id = ((uint64_t)bottom32 << 32) |
> > + top32;
> 
> I presume the top/bottom order is still backwards for consistency?
> With that addressed, the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Correct, I confirmed that they still have it flipped here too. Thanks!

 Kent
> 
> > +       }
> >         return 0;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cke
> >
> nt.russell%40amd.com%7Cba8c8392f8864d5cc40408d7ec644c31%7C3dd8961f
> e488
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637237787836285236&amp;sdata=Np
> hMfjNehm
> > QHll%2BsskbXLRUip6UPYoRi0QWTuB%2FqoZI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
