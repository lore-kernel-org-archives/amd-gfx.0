Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C15C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCB0207E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GR3wvX/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCB0207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D596E142;
	Mon, 13 Jan 2020 18:55:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9176E142
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 18:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+eQpFOmxUTlwlJk8VL6q6tVdZosa88/qZ6HwTOixwiiayRwe0ywawLh3+z7Llva9NpNuAY+bw7qPK5jlADSCsZCfj7bP35nYM2gqOpImnyQNjeFCJLdXCMc9zGYG81giHwLLIwaEfCdLwCxmqXOkLMejqU6Jyk4JBLIunMMXlMJNo0q3NzFnLni9H1rfupYHEA5I1wEMBhfXgijxVRL8jit/d/ZjaaxngnwZFervcqIdhL3gd+d91ubyVRZJPhxgLbiqiVcb8gSAl7FNbuWBFIKFAbwa8PIJxR6kbmSqGgk9XYAd+dR3tuF0oWuUq12TOH8eTYDRgCRc1bsbwD6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAqec8Mdi2o2w+vFJb4kgA1CmrAG/g9xXaAGsSGz+n4=;
 b=VikNZzcCuydc0l4tPey2GyYjZ9EVQT7URiW1Sbj6uE3+eh+nSJuZfRqCQvRN7W1aglcm09SHMNQi1Txt0ZpE+eExrsfEcu9dWRH9zLCKETkwnqpOxRmtF+N6XJJPgjCv58wePodiB9RJujbaOB4gyAdV1o0lq9u1u7AADemPAOSqeKqUq2VxnttvIel3Yq9o8QezHnSAkNsAPQNDlms229huUtX0OQicINjfJ1Mjy99ZtLN/ZwJiDk/ndVU/HPxhMHfb+DCzFDx0jAilXRDair4O0m4J+mxiflqjnn8k+R4IORR358l8E6v+0MVNJgJydPZaIYDmJPQ+uyhw0fG9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAqec8Mdi2o2w+vFJb4kgA1CmrAG/g9xXaAGsSGz+n4=;
 b=GR3wvX/pAydc+iv/FRZRy6ZRBJhAgYDwbrDrg/XHzYQpPeF8VGjKNyYjK52mFdAYXpKh6zvNcpEUNH7SthEvZvaOAOGzLHifW+c83cyIGaJlVmuOkUei/nWwsXzmHwFs9bjWQIU11173uN/yMuZDK0t7tBuGJvFWNIa7l+CVPuc=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (10.174.246.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 18:55:14 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845%9]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 18:55:14 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/df3.6: remove unused variable
Thread-Topic: [PATCH] drm/amdgpu/df3.6: remove unused variable
Thread-Index: AQHVyBVNFCb2tLdAHkiseF+pgn6Y56fo8jGAgAADZxA=
Date: Mon, 13 Jan 2020 18:55:14 +0000
Message-ID: <DM5PR1201MB2554D3C7A4FD0C6519D3C4B99E350@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200111002232.247789-1-alexander.deucher@amd.com>
 <CADnq5_MgDc7xuDADRGY+Gqm1jsMpdy3tLCpwaio0tt8+3-0pqQ@mail.gmail.com>
In-Reply-To: <CADnq5_MgDc7xuDADRGY+Gqm1jsMpdy3tLCpwaio0tt8+3-0pqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d531d7fd-dc0f-4356-b6c8-08d7985a1fc1
x-ms-traffictypediagnostic: DM5PR1201MB0218:|DM5PR1201MB0218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02189B65F377585B913FF64E9E350@DM5PR1201MB0218.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(478600001)(8676002)(110136005)(186003)(71200400001)(316002)(8936002)(86362001)(4326008)(2906002)(9686003)(55016002)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(52536014)(26005)(33656002)(81166006)(7696005)(81156014)(6506007)(5660300002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0218;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sv6YZU3TbElHTgXIfCQzfIFh2/5/7w4h9536jq1cHzH5YnJiUNJ0OE0LLLH5fIESVER74W9cLu8f23TQx1cN1csWPY4+MdsNY3qIvHvvwka1QfjbH7A66v71oVJVJkkGYb5gTVuIuNY1VtyDO7A6w/mIEY2jnmlvcrKMa653zgqf63GJxLZYyu+UOq7hPFJD2wo/VLsP2mTLmKKkZpS/kvHDSGA2BAnvny/DsWLDfK3pvPW2HAAXa0sNfaYWEcKPQ59sRIr7M5v+jDIPkrOfSCRFP7Bs6kmUHTt/w7oB3g0OxffvZV0yCKr38V6ZYtQokNLoPmgl+bZZ877qLU8M5uQ1CvxadWk9kJgGP/25n1Qha+wzDHwAhh/dL37DEyTUnDW4VP3T3hCrhkYB7etOHJS0aFFI0gtDz4JwkyjVp2ChvX53ukZdpoEkQftCN+0t
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d531d7fd-dc0f-4356-b6c8-08d7985a1fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 18:55:14.3112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hbIWWEYxzqvuBGCA209axYoH+J/lJgSgm/Mree0Cocqa1lTrSTNnLGD1VZ+tXnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2020/January/13, Monday 1:42 PM
> To: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/df3.6: remove unused variable
> 
> Ping?
> 
> Alex
> 
> On Fri, Jan 10, 2020 at 7:22 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >
> > Unused so drop it.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com> 

> > ---
> >  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> > b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> > index 3761c8cc1156..f51326598a8c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> > @@ -264,7 +264,7 @@ static DEVICE_ATTR(df_cntr_avail, S_IRUGO,
> > df_v3_6_get_df_cntr_avail, NULL);
> >
> >  static void df_v3_6_query_hashes(struct amdgpu_device *adev)  {
> > -       u32 chan_cfg, tmp;
> > +       u32 tmp;
> >
> >         adev->df.hash_status.hash_64k = false;
> >         adev->df.hash_status.hash_2m = false;
> > --
> > 2.24.1
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
