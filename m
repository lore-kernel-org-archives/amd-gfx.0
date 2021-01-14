Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D65C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 04:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FBD23107
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 04:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FBD23107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FF689B30;
	Thu, 14 Jan 2021 04:17:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FA989B29
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 04:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5J4mRAcv/21hC34czoMb3Wp1T1JffEYp30K3m4mGwjcTSxcyd6ALe8SwW5rmm/fS1cmw79jayt5kgD9uBFe06F9jFWdgYXDLtO87Wl8DjDybcuenGQXS3OobsNIudGeTL7Cnvtf0HKXZh0zq1kC/33VR4ir/AM0chHCTyjUs0HFedB9h9t/j8/zK7O8boaSfCtlIt1xpNaoZ3gWefqsjHufFvLuA7LJ853PpQqj6IS6nZtRPM2NsOrbhhe1Xk6G3R9tTy8uknKvhHaezZtKaUkKeLTnlpmT1Heok1c+waS+5YlzaRhOhoFV88pND7N3OsvJmJGoyLeOay0veE5iYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlXNYC+HHn0KcXYHzko3JuWjrcLJI26Ce/GpRWTbQWM=;
 b=ZdH9YLmI6RRYMcINwO+4EpWGC7I53l4/CsLxNHAL2nmbmybFwEuMPh9OXV6xi07uRhR+6pAacmvDasymWU0cxph8TprUfibyOpyqvQJwQd251CQ5zrfRujjxrNcZDxYSgfDVXW5H2SqrHZNER/tfgv8h9+8dQqhnUikzLDao5di87OVEHA9pgou1UtM+uIam9bCHrhzKC4ouyEDDdgNanISCWCQ+Vi0M2RTFhx/l2TTPyAtRXEDR388d42I7PoGvfwSN+9H/4KZ2COjvytXwpC19WoPbdkUwo2MrrlxnTh45MxJmHjMS54XxjF6wg+1PV76O6UlGuR+ZEPJEbYxbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlXNYC+HHn0KcXYHzko3JuWjrcLJI26Ce/GpRWTbQWM=;
 b=YP7JPdeTQScMutBa9xHlgf7bVQdbQXVO0jBNeiRE5gZRnOCRnSGIEqwbqZJFjE8IG7comtSdSMDgDnJC4TQ6RaLSfaGOBfIESBPvBsx5qzCKeof1O39xvLitV9hmyR2+zdMHZfuJ8xk6nPp0EEGP9l43EIs7fBrW3MKr8ktFlVM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2498.namprd12.prod.outlook.com (2603:10b6:207:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 04:17:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%5]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 04:17:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Topic: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Index: AQHW4sKOiBa8YiQmc0+DU+m7lJVlZqomhAOAgAAA0QCAAA2b4A==
Date: Thu, 14 Jan 2021 04:17:03 +0000
Message-ID: <MN2PR12MB448833D45364D89B8F7516D8F7A80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210104175337.636270-1-alexander.deucher@amd.com>
 <CADnq5_NM4tVs+Mv6RmToa-BNNxnT_io0U145ZfwQK0e4a-y4_g@mail.gmail.com>
 <DM6PR12MB2812C14FDA19467A549E59DE90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2812C14FDA19467A549E59DE90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-14T04:16:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c361f152-c449-4e44-99cc-0000a654ddb6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-14T04:16:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 289190c1-2748-44c6-a713-00000c9e89ee
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-14T04:17:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ca7bb239-d037-4573-81d2-000001860df5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8c8d7a7-7dad-4d04-4589-08d8b8433f07
x-ms-traffictypediagnostic: BL0PR12MB2498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24981D528DEDEB73BE235421F7A80@BL0PR12MB2498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dglsIGdriQ5nW4hjii2Gx6dfPcsRyvL40sZReyvkhlDZ5TlLbm+f3SMYOFk/f4bCHmOD6C9p/Al70D5I16F+B3x0YLB5DafjLDPLO3EJ7UCpSdYwKYal/05Rt4dIcn4B7smKf2iq0QMb1gOrv1Zu9LTiUqziCNFIC6wYYZhde5BnXfGb+FtXDDuOWfW1aDk8/isEHY3NcLc2ln3JWAOn5dZju7D4Awe6/wOvRa/AnK4FHvpbZ42bR2S/v3RLFtOMV7dZJkN/Me4cQbzcQIyU1JT6o9V7N1FqWVJmEkoD84I7ceIZFJZ5dlo3cdSweSOVgRdmGytrvOdfduS0CkIXgEWHJ0BSXWVTtrG9JeeWl87uqAT/cqcnhzdJ3/kFlFl1b/7Vd9RMq2C3kV2a8cN9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(71200400001)(2906002)(66476007)(64756008)(66946007)(66446008)(66556008)(76116006)(186003)(26005)(8676002)(9686003)(8936002)(478600001)(55016002)(52536014)(86362001)(5660300002)(7696005)(83380400001)(110136005)(6506007)(53546011)(316002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wit1NkF5dG85Vlpkbmk2emVKZ0dXR0NTV2Ruc0dtZ29rUWdjdXFFUllYK0Vj?=
 =?utf-8?B?b0JVY0RxVnJFL3ZNbjl1QzVvcXpYRUNwcG9sL1VQQWtQZllqUXpsSmVkY1Yx?=
 =?utf-8?B?N3lDK2tOVEtrTGNjQ2xZY1Q1M3owaW1kOVVZVjYzMzdhN3A3UW0zZW90WTZU?=
 =?utf-8?B?eXRiT3RPR1gveUhidWtJcDA3dElzVXVSci96WjNTb2JXNzZWcDNtTlpEWlJ1?=
 =?utf-8?B?MWQxZmlTU3RnSlZuNHlwanlUK2tiMGxqZTZXS01wU1VjMjkvRWhXWUU3UUVh?=
 =?utf-8?B?ZkFkbGloZU9kS09qYlQrUFUvWWFienRHTE5tVFVzTk5sWC9oWW85ZUM4OXVP?=
 =?utf-8?B?SGg3RG5hYVFMcGxGMFBCendTVjQ0c2JBY3ZBcEFCTnQ0SlRyaEJaNnU4aytN?=
 =?utf-8?B?ekIvdmlyNXdtMlFTNHNxT2JtTXJZR0U3bTZmenJ1OFEyTjV6MXg5YkNGekJY?=
 =?utf-8?B?dTJRVmNncEJaeW9pOGFHQTV5YzFXYS9DQlphdTdjSlBtV01zVDk5SVFLU2I3?=
 =?utf-8?B?bkNRSHpqeDd3UFFrbWFhT0tjYVA5OXFDNUg1Q0kxVHRRZUZuZVVtRnk5NFlI?=
 =?utf-8?B?QjVyMUZwOVRObHlRajgvTWdYQXpicERWaHBlSURoVWFFb09MSnMyajVXTzBV?=
 =?utf-8?B?MzBHUW9HaDVMTzR3YnhITEU4NFpSNnoxYjRWRWt6OUdHVE9BREtqTU8yK3NU?=
 =?utf-8?B?TytnTEZzSGNkM2RTbDJyd1FxYWtkVXFuQWI1UG1BMmxMdk0vQWNRZHpGakNB?=
 =?utf-8?B?SjJpTlNhdGJ5WSszdjdWUURlUWRNTWxFV0svcTZLMW9KSTRzczVMUEh5ampx?=
 =?utf-8?B?cmtaejlVenZ1cGhlRVh2OFdjU1BJdERmSGppa25mTmNqTnY1OFVBaFhFcFBj?=
 =?utf-8?B?MHhpVEUwbmoxTlJLbE1yOXBZNTU1bUFCS293d0l1eHJhd0ZzVlB1cUFmL2cr?=
 =?utf-8?B?b2hVZTdrNWpNNGtJZkdCQlpFaithUSsyT1VmQ1FHcU1hd1pxZWdkZHR1dzRE?=
 =?utf-8?B?Y0FHbG1TMzB6MzRQUVVQZWk2U2JIREVrUTRyL0pjVllvcTdodUZycUZWM2NE?=
 =?utf-8?B?QTNzanJGbFR3elhUL2hIKzVRU0lCUGZnU2syTHBLa05lZGM4SVRNVStUZk11?=
 =?utf-8?B?N1d3eTF2YXI4KzIvcHg4RjJENHRsdUJXZ1BiZkdCWlZPYVVsd3NKUUtYYS9K?=
 =?utf-8?B?TU9NSUF3NUJIL3VXMGxWQnhsSHpmQ2piRzNieUZuVHVBUEIyeHBGb0V0YXB1?=
 =?utf-8?B?aFRQTlpHSVlJOXhRTFo5ZU83SU9nTUl6TDVwMUF2L3pESHNWcG13UFo4ZWhN?=
 =?utf-8?Q?YFh6Ye4CFTUj8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c8d7a7-7dad-4d04-4589-08d8b8433f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 04:17:03.0963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0b0V4DqTk4M5GjLe4z2UP1cxcMqHwf2FFhdDpCQeNJVs/gfPfPVk2yxwdGJu87k3q5iBF7kbvq8XC4mpBAktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> Sent: Wednesday, January 13, 2021 10:27 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in
> secure display debugfs (v2)
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Thanks, Alex!

Can I get a Reviewed-by or Acked-by?

Thanks!

Alex

> 
> Regards,
> Joe
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, January 14, 2021 11:24 AM
> To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Su, Jinzhou (Joe)
> <Jinzhou.Su@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: check the result of copy_from_user in
> secure display debugfs (v2)
> 
> + Joe
> 
> On Mon, Jan 4, 2021 at 12:53 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >
> > Make sure the copy succeeded.  Also fixes a warning.
> >
> > v2: fix the error check
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > index 455978781380..b033344c5ce2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > @@ -101,7 +101,9 @@ static ssize_t
> amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
> >                 return -EINVAL;
> >
> >         memset(str,  0, sizeof(str));
> > -       copy_from_user(str, buf, size);
> > +       ret = copy_from_user(str, buf, size);
> > +       if (ret)
> > +               return -EFAULT;
> >
> >         ret = pm_runtime_get_sync(dev->dev);
> >         if (ret < 0) {
> > --
> > 2.29.2
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
