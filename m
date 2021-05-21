Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7BC04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 22:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279FB611ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 22:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279FB611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7B56E193;
	Fri, 21 May 2021 22:04:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602886E157
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 22:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL6pUif/GdLcDM/pXsrqwiZzxzdx//UotjKIhydF2ioz1t/nN5Z6xQbKXcHv7mNdiK+w6+q5wYrnxidW4+JtdPohKl+7hCrTEfOEqVEYo9Oo8PCXmiiFz3lapkT5/v/HIC/YmqORohygdYpVCNIiW7gcvFW0Ibtq9wQ928W4Gj7xhhjCCHezi0BKzPA8UPLvAE3imlq9qHJuyDc0xNQxSh8qJRgXs96r5R5mYbuShZAgaaoZtHw6CmDCZ34sZJQvF4LApCASJtmjLCXIlXLxvCPgMfnCH6lOd+tRbt/Mcf7KWcZXwG6lmzfeWYGAg2aZll91DtK2VqXfVw80BTDiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AVrIEng42uAEDYHrukTNRtjypYipvbuM8aj0S/hPGk=;
 b=CF5FAonMZvonzrUSk4Bi1JZkzImiR62miqGCCFUQaPi85cqkOrOsPauWUaf/NRZcYo8NYMcOo+CF30qxghAXt7J5xaBEk+2XzGldm/JGhk4e8gVq86Y4eHSLcp7u9/Be6WaG8ivktPnUWHsFRtSqJDKcaz5iFL6f5lVt8O2DV+CUz1aM8UsLls0cqJKGrh60IGulxbmE3fJBmAPg5OWWZcX3dAD+IhQWkNB5rmsEDLFz/bJbOO85f6i2GU2eN7D0IMhnlcBjaI3+EErwDx/SVBMtLDEquAKn9lpCUr0gDJ7nFfDlZF+INXJMs44U8eVjGCGziHpLm5INqjU0KWRqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AVrIEng42uAEDYHrukTNRtjypYipvbuM8aj0S/hPGk=;
 b=kii11JwpK//Ty/6hPLvUBGzGiYgAb47exr8LQT5RIuKVZZJ5L/0GpOzWtf3U+B8yvwzvO75VHwiIZCGRR6TMGE7ixdywzu5f1bTlB+HMlgNa45aR1GOo98PMcdX3tcvGjqxYjPI/KCRdxSm8Sj3vlGY/bPxpMXp+EH8pFJNTXZ4=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 22:04:10 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 22:04:09 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Topic: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Index: AQHXTYSqhVvD5xR5YU6jGKA1xw/dbKrt/8GAgAAz2ACAAC09gIAAED3AgAAJlICAAACvAIAAAuAA
Date: Fri, 21 May 2021 22:04:09 +0000
Message-ID: <DM6PR12MB306708FA8274AC661CE859248A299@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
 <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
 <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CADnq5_O=LP9y_YNmvPC8om7KOf2eKyBr2P+CL1j4zAhBrRak1A@mail.gmail.com>
 <DM6PR12MB3067E3CC583A472F14DE7A1A8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CADnq5_O257rQg7PW5NiRCdYrmbtzRnxco_FQiaX8sNHO=RSqgg@mail.gmail.com>
 <CADnq5_N1Wh2RNJtdQ200jsbeaeqgfMM+5rPcWp-sWWL2f_6Rmw@mail.gmail.com>
In-Reply-To: <CADnq5_N1Wh2RNJtdQ200jsbeaeqgfMM+5rPcWp-sWWL2f_6Rmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.141.145.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e3add1-ff46-46f1-447f-08d91ca45c58
x-ms-traffictypediagnostic: DM6PR12MB4404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4404A197DE05B727B39848DF8A299@DM6PR12MB4404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7rw7YK4ZCZV4s2VrgRmfyQVaRuiJL/KssrpJbpfQNdUt9BL2c8YmdS6OLdp4HZzpCnaQd7jcWsE93U67RWqATOXPre+mr6qGGftgFyjcZxgj7amwP/FQ0/xOsICdAhA9P7D/IkSugP57ddUVP3mdOR3LgSDtaaW1zElMN8EcT1aCZtJg/YP4udfil1KBD9Uj3g6Nlpx2HRRCjFLijw9oqZHTkhWXgjgot1Uhvg55i1HQ6N9+sPEOgNPOx1Qjtz1LDsGPgTkhQ4x+phrkeqHfe7jt0kZkNlXN0x+QltvcyayxXMpAjl1DQ3gUHHIW1NxU4mTDUwC8+eCaGyHwaet4TnPuwyLXf8UMCVM+ZgOEYPX8qeubHuVuYj0Lmt2YqUeAqOmYic6bp9VZ83b8oj1cFzpahPloWCJR03PuMaYNLZPxmPWZyJdQJ0EhpYTMyuA0fWhji+AFl71SCPqaGYpm+N7A5KbodRJi3NluqvhGRGxagjGlGMemJ+ByVMxleFAHaTuUPQMcpBGcaiJ3iROH0+6xSo/ukiY0rYbb9EgqYbWUTU/sM8/hODgmS3zxuuSmyW1jIAnRyi56JJkTinFjd+h9gOrsxluTpi7TzXZDlYj+QiOLeOId6UzlnX8f1ReGzZLC0a/q1NXF4oNr1Wk/bUbsCFCJxXfYjaAJl0USFow4wIZrhvZhJhuOwjoNjSQq1Q8YD/ykAOyzOmaZrp1LDSN0SVQm4f5gWaGE09pp/yL+BBxQkiAssONvsm5BhLUfurxZk4pDW7/Pi31Rxa6kQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(4326008)(478600001)(71200400001)(186003)(966005)(45080400002)(53546011)(54906003)(316002)(2906002)(55016002)(33656002)(66446008)(66556008)(86362001)(26005)(8676002)(6916009)(5660300002)(38100700002)(7696005)(76116006)(122000001)(83380400001)(8936002)(52536014)(64756008)(66946007)(9686003)(66476007)(6506007)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yStrAxjP+KaiXqswxDK+rYnrY3ygX+kL8KADGJsCrCy+vp3QZ2CMXg5f1VUz?=
 =?us-ascii?Q?YJ20vYU4ERxP1I/MOmuQVvFHQBBk7TJHe9fu1sUlR/Huqa2QsZMwMY3lpxMb?=
 =?us-ascii?Q?c+8P7wC00EqNKgT1JIo7PxdMcPyYtLXS8U8850K2lq4XVynDbu08gn+45+tl?=
 =?us-ascii?Q?HSEokfPMqA2vKstqNpd6auZuGmgOc6Byz8VxLRPNVcuLw+dC1442o2Fr3kR5?=
 =?us-ascii?Q?kpPNK+td4sP2ygzsVNPAec6IliYI5VkHQWCs+flJsv8fRrAJ1x6qSajeQIEQ?=
 =?us-ascii?Q?3bsKepTRzxtn7IIYqP2taxKqoXqWrw6Ww31keEOUPLu2CvqnCQEivzI0wMu9?=
 =?us-ascii?Q?HjSzM3PcUnWtxed1+fRg0Yv5RTdxO5rnKxGBO9wUrYERinKvKxZATIoU2mJ5?=
 =?us-ascii?Q?XdPixPfd/tVFFwy0w1Y+lvFdP/CmaL2u0Xh8NoZO6Q1gWyCeT+09pQ9ZbkU7?=
 =?us-ascii?Q?QRW1F5jES4knJXPt6JlkNfZTpIn1qvsRw4f7mQANqqjw2uQKkWQNijerLl4w?=
 =?us-ascii?Q?wWy6blMe+Xh0dfPdWkMV1rFenzHwv0M1mpCssyFuqVoxB5E4LB7Wb+Y63OO1?=
 =?us-ascii?Q?SLCGVQAfDzX99GmAY1NpwvtZaAG214so+uVmj/teXoOBBfCqi4DatU7OX76E?=
 =?us-ascii?Q?0+zfWyhm7sKE9RuMHhFDm/x4wNLbkT3szXNQIpcBGa6LwVShPmgaLxaekd/W?=
 =?us-ascii?Q?cpTotXJcRc5D7KdK55mwO5g8wWaSBFeifouzld5BuJ0WBKR0Jz+3Nj+McGcZ?=
 =?us-ascii?Q?fQe8iOUiF7871cndxbXgMDrH2n/jOyRTYDOxdN9mECMxaVN157BU0dudb6E6?=
 =?us-ascii?Q?vTWKmhws1dI2wAITkaReeTc+uEjEEVgkqNU3G4h5PKsNKLAFudT81+ukIO+H?=
 =?us-ascii?Q?GT7oO90hdzzBsb0li9yWunKaIXZ2JNDlWbgaJM6U4QiODXIZ7htsZDCFbsw7?=
 =?us-ascii?Q?Rv9v7iFS07VoLhzzRfYrw1dblERhMHhhTnvMxzpt/srTWHldVwBBHHl2habz?=
 =?us-ascii?Q?UOyqHaDoPj5C1cdW+WhbmrxGqILtPwr1OWf6mes+qywDiq4ogEh0XsYRjTfp?=
 =?us-ascii?Q?ok/wTMIUyS1Bib+L6UgSsat1A7PoS3xjhfDKYJIfFb4hhcE+hTQllTWubsek?=
 =?us-ascii?Q?0mCdvObzA1JhV5SCT+ugE3qq4GJvUrzDIjK3XlP5fGaNsrqGncneH6Cwb901?=
 =?us-ascii?Q?zCiOay6joGDf6sh+pjMtC8rEDjCztJrl6Xru6VbBtNGDCvD6jGUvpojVHvAg?=
 =?us-ascii?Q?UUJbBPF5+ymtt7cEZWDnEOKEPBqx5fvZSXPBRiz4dXf3fzMll3DyS1fczSah?=
 =?us-ascii?Q?X74ssYh7QY49o2If1k2s8atH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e3add1-ff46-46f1-447f-08d91ca45c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 22:04:09.7259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLyYNZq/0zwIaKWRkbRhSVm5MR6GjB3eDaiZtpSeI9Eq5dHw1Fi2K8HT5uPqWT79JplrjbrkdBaVA0Qfr467cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Right, that all makes sense. I'm fine with either of these options. Thanks for the insights -- I'll give this a bit more thought and get back to you.

Best,
Graham

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 21, 2021 5:50 PM
To: Sider, Graham <Graham.Sider@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation

[CAUTION: External Email]

On Fri, May 21, 2021 at 5:47 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, May 21, 2021 at 5:32 PM Sider, Graham <Graham.Sider@amd.com> wrote:
> >
> > Would this be referring to tools that may parse /sys/class/.../device/gpu_metrics or the actual gpu_metrics_vX_Y structs? For the latter, if there are tools that parse dependent on version vX_Y, I agree that we would not want to break those.
> >
> > Since most ASICs are using different version currently, we would have to create a duplicate struct for each gpu_metrics version currently being used, unless I'm misunderstanding. I'm not sure if this is what you had in mind - let me know.
> >
>
> Just update them all to the latest version.  The newer ones are just 
> supersets of the previous versions.  I think a newer revision just 
> went in in the last day or two for some additional new data, you can 
> probably just piggy back on that since the code is not upstream yet.

Another option would be to leave the current throttle status as is, and add a new one that provides the standardized format.  Not sure if there is much value in having both though.  That said, we could increase the size of the new one to 64 bits to accommodate future throttle status bits.

Alex

>
> Alex
>
>
> > Best,
> > Graham
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, May 21, 2021 4:15 PM
> > To: Sider, Graham <Graham.Sider@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, 
> > Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) 
> > <Elena.Sakhnovitch@amd.com>
> > Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler 
> > translation
> >
> > [CAUTION: External Email]
> >
> > On Fri, May 21, 2021 at 1:39 PM Sider, Graham <Graham.Sider@amd.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > Are you referring to bumping the gpu_metrics_vX_Y version number? Different ASICs are currently using different version numbers already, so I'm not sure how feasible this might be (e.g. arcturus ==  gpu_metrics_v1_1, navi1x == gpu_metrics_v1_3, vangogh == gpu_metrics_v2_1).
> > >
> > > Technically speaking no new fields have been added to any of the gpu_metrics versions, just a change in representation in the throttle_status field. Let me know your thoughts on this.
> > >
> >
> > I don't know if we have any existing tools out there that parse this data, but if so, they would interpret it incorrectly after this change.  If we bump the version, at least the tools will know how to handle it.
> >
> > Alex
> >
> >
> > > Best,
> > > Graham
> > >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Friday, May 21, 2021 10:27 AM
> > > To: Sider, Graham <Graham.Sider@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, 
> > > Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) 
> > > <Elena.Sakhnovitch@amd.com>
> > > Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler 
> > > translation
> > >
> > > [CAUTION: External Email]
> > >
> > > General comment on the patch series, do you want to bump the metrics table version since the meaning of the throttler status has changed?
> > >
> > > Alex
> > >
> > > On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
> > > >
> > > > Perform dependent to independent throttle status translation for 
> > > > arcturus.
> > > > ---
> > > >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62
> > > > ++++++++++++++++---
> > > >  1 file changed, 53 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > index 1735a96dd307..7c01c0bf2073 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > > @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
> > > >         return (abs(frequency1 - frequency2) <= EPSILON);  }
> > > >
> > > > +static uint32_t arcturus_get_indep_throttler_status(
> > > > +                                       unsigned long
> > > > +dep_throttler_status) {
> > > > +       unsigned long indep_throttler_status = 0;
> > > > +
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> > > > +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> > > > +                 test_bit(THROTTLER_VRHOT1_BIT, 
> > > > + &dep_throttler_status));
> > > > +
> > > > +       return (uint32_t)indep_throttler_status; }
> > > > +
> > > >  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
> > > >                                          MetricsMember_t member,
> > > >                                          uint32_t *value) @@ 
> > > > -629,7
> > > > +672,7 @@ static int arcturus_get_smu_metrics_data(struct
> > > > +smu_context *smu,
> > > >                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> > > >                 break;
> > > >         case METRICS_THROTTLER_STATUS:
> > > > -               *value = metrics->ThrottlerStatus;
> > > > +               *value =
> > > > + arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
> > > >                 break;
> > > >         case METRICS_CURR_FANSPEED:
> > > >                 *value = metrics->CurrFanSpeed; @@ -2213,13 
> > > > +2256,13 @@ static const struct throttling_logging_label {
> > > >         uint32_t feature_mask;
> > > >         const char *label;
> > > >  } logging_label[] = {
> > > > -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > > > -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> > > > -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > > > -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > > > -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > > > -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > > > -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > > > +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > > > +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > > > +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > > >  };
> > > >  static void arcturus_log_thermal_throttling_event(struct
> > > > smu_context
> > > > *smu)  { @@ -2314,7 +2357,8 @@ static ssize_t 
> > > > arcturus_get_gpu_metrics(struct smu_context *smu,
> > > >         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> > > >         gpu_metrics->current_dclk0 = 
> > > > metrics.CurrClock[PPCLK_DCLK];
> > > >
> > > > -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > > > +       gpu_metrics->throttle_status =
> > > > +
> > > > + arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
> > > >
> > > >         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > 2Fli
> > > > st
> > > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C0
> > > > 1%7C
> > > > Gr
> > > > aham.Sider%40amd.com%7Ca3ca9a6b0576479e545808d91c648f50%7C3dd896
> > > > 1fe4
> > > > 88
> > > > 4e608e11a82d994e183d%7C0%7C0%7C637572040495495758%7CUnknown%7CTW
> > > > FpbG
> > > > Zs
> > > > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > > Mn0%
> > > > 3D
> > > > %7C1000&amp;sdata=YxUx7BrsQKBauKE3fHpNrkWMAG4dBy11fV9xnJdMHns%3D
> > > > &amp
> > > > ;r
> > > > eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
