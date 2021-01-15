Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5482333E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5482333E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D2A6E409;
	Fri, 15 Jan 2021 13:36:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8126E409
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 13:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD2MxvViTkRXpiV2ugMatH/2g4/LtfXCq8wfYqhkiVXS2xyy7KbW+Ux45jDZkrMi+9CeCufpsEyV2UHXvxOeh3LBOuFFRcYSvLaosaEId7s7p8jKGy0dn9w1PLlC14WHY3uF+4CSR23AJnt0ys2qadv0/SZDnaGP88VDbcOhjD9crCIoImlR83v+8660EYbyNaz0Ula3ABZ4De11vFLUPErwtVcly2xCVAt+Jy0c/0S40Ie2wIM6TpAwQFXjobk1BY+38daMEtBNcVIlXLOhSmDEQdGQ64bRg3gG2puROKnTrUHh4oy1uXMD0diPbM6uadmqKRfvXkI9Uab++f/bYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2zP86wyNMvZp1iqNuoZKROxHa58CW8zsv7BFDqCfPg=;
 b=C0sov0cEdZFDdKbc/9qljD1YunqMli1quW0+qmIAKXlGznZyEaiFGdvqvBK6EWBsEXwtnn+BsO5a8rAc3uwMc0L0ha1LMipAi7OcScMEd91qZ6SpE6yPGfNOt+in03oXnYZtcS/PWC200fE5zorw9PCgCrD7huiJ4R6MGYNmE7xdaIfqZ25pvNXglbeffPfJdg+ME16/F0qThMU6NM6KNH/5t1gqPXtpqm0DeeHJnPEW8Bgtke9/Wg/ihRSeDzYz7Jhb0wID9KVcmCgvs+53RaeLgN5PTzQtkKXhbFUcTcj65BjUuuEbFi1X6/2t+FpxiasqOSM3lRw8jkyDPuJRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2zP86wyNMvZp1iqNuoZKROxHa58CW8zsv7BFDqCfPg=;
 b=fTYIjvoJAtwfEUK8kXEYVhmcfklRZRczkjMXVNXEiocQC/wnb0a0stpJ6wn2UIJtWoR4IKq8CqQOM4BW0tQXIMVF3sC5s/jHxaNagwnwJAPse50lcdkp846E8LfIJVwmyPOB2+G+XyJ+JfFXi8yPm9Bo0YuP+obgwuRvc5I/tpo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1235.namprd12.prod.outlook.com (2603:10b6:404:20::17)
 by BN8PR12MB2865.namprd12.prod.outlook.com (2603:10b6:408:96::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 13:36:33 +0000
Received: from BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0]) by BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 13:36:32 +0000
Date: Sat, 16 Jan 2021 05:35:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Message-ID: <20210115213558.GA516039@hr-amd>
References: <20210115184658.513045-1-ray.huang@amd.com>
 <1c67eae5-a77c-b6af-4f80-94b5b80733eb@gmail.com>
Content-Disposition: inline
In-Reply-To: <1c67eae5-a77c-b6af-4f80-94b5b80733eb@gmail.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To BN6PR12MB1235.namprd12.prod.outlook.com
 (2603:10b6:404:20::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Fri, 15 Jan 2021 13:36:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c71d25a6-5dce-4ce5-5395-08d8b95a9237
X-MS-TrafficTypeDiagnostic: BN8PR12MB2865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2865465F5EDE4141690A8F5CECA70@BN8PR12MB2865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3NCfdh18s8fiY2fH+qmnavARCpRF7DImkRyUqBW43uwDDw2aIKh/FBgUG1Pzq7JfRBFoktlT/DBQ0bRrQIhZjBOvc8uIx9JFPDbnTZylMBTbbNWL5W1mUCfi5m1eUajYOc+bM3J3nlQ+DEUsNpZuh5slrYw58T/LfCM5GT2Edk/q/BU0hvz8lWlv4ttZHb+LBmwzRJp4ZUHcjAieLGb3Obh+zKN6fGUcoRXTIA9WITeOw0QNihxLCPgzelyzKO2XuhfR/VW1YPkPD3H6pGoHe7oI/yDsHiOg8TQOpMl1K+QJtvaB5X9dyqee6OJ+BkmpuRo8ybMVgbQViRx0Y8T/U25qz46izcEAH8clmwOfRixcyURv209s7BX36HsDKlY3pxoaPhFHHiNTN3EFPBIwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1235.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(1076003)(54906003)(66574015)(16526019)(6636002)(316002)(33716001)(186003)(52116002)(55016002)(5660300002)(6496006)(9686003)(6862004)(478600001)(86362001)(2906002)(26005)(8936002)(83380400001)(4326008)(33656002)(66476007)(66556008)(8676002)(66946007)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?s+5bO2sEFraxMP2s2oYcQRP83HB7fUahuvLQLSUltjIVszY+4go+IMcoZE?=
 =?iso-8859-1?Q?lxI+tJpj/LJs5HYTskcCEoFREtAFfVM7kqBoY0NqujxnOI6Ddz9loYeBA6?=
 =?iso-8859-1?Q?e2JCVTKF9k9WYPqp2SCYlmIr+/m0Q/vW5E9FPseLUJRq82+u+GOcXmRkMS?=
 =?iso-8859-1?Q?azv64Q5dJeEbk5eew0WQFJerEk4xHO0ntsqfA7laUZOih+G11SFiLd9pSn?=
 =?iso-8859-1?Q?X1/Hd/tBDi/q9aQvm6cJXx8d0Lf3foSNfqN94GAm77XYaNORpXh001SMmL?=
 =?iso-8859-1?Q?JGpq7Mtc2UfpYyG5cMeOCgMf6HEI0ZDlDlS0DngBbRlJ/2jdYkHpbnUeCI?=
 =?iso-8859-1?Q?LDbxxT5gi/yVVW/UGinpIWrgXABLchQa8Zp/j8mERFEjZhdk9qxRB/xheD?=
 =?iso-8859-1?Q?LwQT1ZddI/Ob3exf6EcVCvkavRAiqkAwS986Cn1U1xqSVT5cWK8iw5/aDd?=
 =?iso-8859-1?Q?SLMydnV5PI0UjEEhDipmttOY2w73W5+km4C2DAwU8srvGZuarjKWBp2zdf?=
 =?iso-8859-1?Q?hKGNleu9BRgxOoF1npx7RgdB+ce3JMJeigl5nrSwiiMRNPGPGXIcLs5U/9?=
 =?iso-8859-1?Q?Sd8f9UJeC6VrfrNBoUEjSq+tQKArDl5RXn6jnvZwXUGwELpLKS242uxZMO?=
 =?iso-8859-1?Q?gi1P4i6T136HqjYRvdYCQ2cdwvexSJbBrx8Y0vFRGnuW/SLQtp9RKui10j?=
 =?iso-8859-1?Q?Kr7b0r+jHnL42lgHnn0/ZuEGSZkHFBad2SkKkUH16YwnScG5flcfX5LNr3?=
 =?iso-8859-1?Q?NeKgOXO3onB2527s39r4Z6XlYfzDjOQ2AET/Gak7d9sqHWnaKGeG8HJ0DR?=
 =?iso-8859-1?Q?WrpeJVJrI3xB8ZZeiwD9a3mCk+WLS1V9GSMUELGCGvVlWobyhOwTMVNuPg?=
 =?iso-8859-1?Q?JwrPO9pEENXKgWdxrFFXE+pUgNoVRbCqlTwpp91eUNGA6j3jpoHaY4PkJk?=
 =?iso-8859-1?Q?tvIuU+u23h899V2LQoCj30ASRFoR2SItGr13mz7Okv4gQmIjj4oRGgozzQ?=
 =?iso-8859-1?Q?b+uisREmqRXPmCbxnqhjvUwRC1qbGXlJv/PK2k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d25a6-5dce-4ce5-5395-08d8b95a9237
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 13:36:32.6798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/fcSI8yS6mwFOlIoc1f+ArZOweJnouECXtfrmhZGpCSOVSwS/0gurqb3MYggCY6S1BAYtqv4SoMQqpOSNDp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2865
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Su,
 Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, Lee Jones <lee.jones@linaro.org>, "Zhu,
 Changfeng" <Changfeng.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 15, 2021 at 07:22:43PM +0800, Christian K=F6nig wrote:
> Am 15.01.21 um 19:46 schrieb Huang Rui:
> > The buffer is allocated with the size of pointer and copy with the size=
 of
> > data structure. Then trigger the system memory page fault. Use the
> > orignal data structure to get the object size.
> >
> > Fixes: a8e30005b drm/amd/display/dc/core/dc_link: Move some local data
> > from the stack to the heap
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_link.c
> > index 69573d67056d..73178978ae74 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -1380,7 +1380,7 @@ static bool dc_link_construct(struct dc_link *lin=
k,
> >   =

> >   	DC_LOGGER_INIT(dc_ctx->logger);
> >   =

> > -	info =3D kzalloc(sizeof(info), GFP_KERNEL);
> > +	info =3D kzalloc(sizeof(struct integrated_info), GFP_KERNEL);
> =

> That should probably be sizeof(*info) instead, we usually try to avoid =

> sizeof(struct ...) in the kernel.
> =

> There are some automated scripts in place which will send you a patch to =

> change it otherwise.

No problem, just check in the patch before because of urgent fix. I will
file another patch to modify this.

Thanks,
Ray

> =

> >   	if (!info)
> >   		goto create_fail;
> >   =

> > @@ -1545,7 +1545,7 @@ static bool dc_link_construct(struct dc_link *lin=
k,
> >   	}
> >   =

> >   	if (bios->integrated_info)
> > -		memcpy(info, bios->integrated_info, sizeof(*info));
> > +		memcpy(info, bios->integrated_info, sizeof(struct integrated_info));
> =

> This can then also stay as it is.
> =

> Apart from that good catch.
> =

> Regards,
> Christian.
> =

> >   =

> >   	/* Look for channel mapping corresponding to connector and device ta=
g */
> >   	for (i =3D 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
