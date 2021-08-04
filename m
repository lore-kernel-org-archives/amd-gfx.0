Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 03:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A947B60EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 03:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A947B60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E4D6E9B0;
	Wed,  4 Aug 2021 03:40:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4AE6E9B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 03:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S26d9K9vKIaeG6+aJmBD41GeBK8X6HvQ47OPD9TXqnsQI+QJBD0KwRsn+07h6SZL4ITmpIADO68IA5mpPDmAoKUx99Lm4YBVlV8uk+k3N9G8BTzgkMJXoHAWiRxKEz/BbfN9anQGc9Mt2x06mlSMDt8KqhL5AR0akfXZm1DyQoQzK0jFuE9hbefeJLt6LYXULwkK/9L5mlzDHFBdbyQO6siTa0wC+H80g93xE2vYCwmfLyRH10hYiP5L/crVUsgUtXL73zAcKDAbaslp8wtj6Q0qr4HOEQuz5k1kTBA/dKcbzqTqBdlsu5oc7zIxkkEemvGRnXrZvE8WrauIImzWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wbvIOTfVe511nw5ySxR59eW1gkVIa/I46yrOx26L1k=;
 b=fMJbuTLcQ6rmjySb2mRcC2Rjl9O1zAcFMpPZl/arXEhiN6G8hUPGV2g5cDpfAvZqT6EObBY0m2m048uEuBfrNdC1smdM0yVNJP+KZUjQoKOgT7FNf8eu8EoPhWwDaOwb8b+PpaJEBJ/CtQeT7ZKGOfAQOSWlm3+CfMfqM1QVRbw0mMOXAxswWNq1y9ypgEQl0Ws5ng0bX0gJqNBn41GRx/zyRmFGff4v78bJr6Y8ElGbx2XTvygd3zbU0+4IAr2BicE8xitT3Udz1GhLtmH/PxqJsNa+pjgQVygeCpGU57s/7HK6tMhUuir/xwjZzHMl4rHr9w67jLeUxwPZ4y54iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wbvIOTfVe511nw5ySxR59eW1gkVIa/I46yrOx26L1k=;
 b=pqYM+cKr+WcbM2vsMiKdeZNqMzu2+LaUo3QJRUFLYqFZhV28LvcNhfIPJJ2C7UCN/e+9tpZBzhYkAxYyFINe8Cgk0LF5Cvhlm9AtROserqhW/gXIM3d8UklRaz3PMI+Gx2VPos7TBeRNdG974eeCvlVzTZBBMe3P0Jw7Tij6/WE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19; Wed, 4 Aug 2021 03:40:02 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 03:40:02 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Topic: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Index: AdeITLg7attLKh5xSlmEVfidPAvHswAIhHnwAABMeRIAHFsMcAAAM8HA
Date: Wed, 4 Aug 2021 03:40:01 +0000
Message-ID: <DM5PR12MB24692417404B35DAE5A72A12F1F19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>,
 <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BN9PR12MB522659C72ED024CE62496CFDFBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
 <BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T03:39:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9236718-54f1-4bfe-a732-08d956f98a80
x-ms-traffictypediagnostic: DM6PR12MB3962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39623A8EDFE7DD969E412A84F1F19@DM6PR12MB3962.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2+YXaXeWSPmOHcf1/tyLqh75OhczW8X7eyoMvOutcVuDdm39RM3obK4eFcSDuj4co12gvjkdQm0plrRO8HvzpwyG8QaFb6f1p55i05+A0XC9d8VKlj/4Ijf85xpnyuh+qdok48sPdt4apRidDBzd+6GxKZlG4vOKD0CtbJIIYLM1VUoyAgdaS6afZMywqu8HL7sdlXezP3AYC9K+U11QgQaFa2kpGl3XQenT9owbuASppWc2UBYrbGiULzFANDTHPZLI67mq3thwgtRHA8cehm97lt2G5DX/bKOkKQJC620LaLLuIT68JBT61IWI9Mnw0VGvW9kgTraSq1Oy0n21WLUtoU1OAb9cU4trSX7I3IeLGkP75y1+f6Q3QjijuTMF9FAtbSGu3ay172UaNutdqZJjaDjXBHgPPoPGXVjmr5Gn5m1dbeqnxxrOWKBGpnX3/7CjAkAD/7e+E9av//d297/+rJJL/0RARD+1WJoed8E1Oeez46FtgKpq6sUVnVWeBuFdPglC7F9F5OgmPEHBgW9dJ8gTmkx2IsytwCQS/BStr05c/2jju/ofXIECy6VOCrZDW5cPexwnhaq9gxJL9TLzYxWEvvR90RsH6CSykpuwIXsvghylIFYugQls5674ksOZ7ky2n5tGWBj2c8ohWw7G3F/fKw9FrYeDqHNOv75hhKeYiJfhqYoxH+Lv9s1dsIW9773hfYjyAYL2y+D8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(71200400001)(6506007)(8676002)(5660300002)(76116006)(26005)(66446008)(86362001)(53546011)(66556008)(55016002)(64756008)(186003)(9686003)(66476007)(478600001)(316002)(66946007)(122000001)(54906003)(8936002)(83380400001)(2906002)(33656002)(38100700002)(7696005)(110136005)(4326008)(52536014)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZNhr2I0UsbVRexxcekGTkCkrDBdqNahH1U4xKG0HJQk16fSOwIvOTUlFlotg?=
 =?us-ascii?Q?cvgJY7mZRxpuqI0/7rSnW8vqY+mJTROgoYFB/PznGFm0L0rvJZ4PNiioX8P2?=
 =?us-ascii?Q?EUogP0DewKvVAlStQNbLGQpPxKnenHLfecbx0U1ZY24td6NeX8e0hSWixtqK?=
 =?us-ascii?Q?lZnMeeEaJVc4wY4bntVWWf52KGIB4SJ8RZZ0j+FyjmR0QmLFKRdBYCXu8DKx?=
 =?us-ascii?Q?Twcn84vntXte9uv14lDw5owDJ11nm0guijYki6uzCgUWm/N/RF2e/e4aYHPq?=
 =?us-ascii?Q?bS8QT/Yl5sAtn/a3PN3rEImMMmhvWkBy4eo7Si6GAHX5rcMr39WQ7pPhRGot?=
 =?us-ascii?Q?yRwnP6RYqZYmLlmE3+E/Ya11KGDlSOH/BvHih5bjU+2mo/9zewQvx6nnp4D/?=
 =?us-ascii?Q?qckBe5wztldbhmyp0atZRfz65tFFtYffF9IrgFXrpTChB4orfy/LPZVGl3KB?=
 =?us-ascii?Q?nzhjAVkJ1HzkFTrw9pk+Y8g9Zw+Z6u6J6aTbACoDXdPTCjFogVXRFxsD0Jn9?=
 =?us-ascii?Q?b54i2fTnxl10IYFPqQCeRkJE8cnd5IuCQ/S13ltxxY2CpyQf8nAi9oinYL6K?=
 =?us-ascii?Q?UZHVpxCGhiMREW97ExEE7cW7J592hhR1XeVj72F8qPw4RMJbTBjesKoBx/Tz?=
 =?us-ascii?Q?Et0A8jtF/vDz5j7ozIlvBF9nyFtLOpxsQpwOTQPgMURzkHOHpLt/PLqtLgIi?=
 =?us-ascii?Q?FJ6LDiFqTUw7WggcLnypzfntX3mvD6pqJfyllAWsV1snGtNJpFApDHZZVtce?=
 =?us-ascii?Q?FAJP4NvMvRSz+YF34Pj108qgBDfffqyVXo63oXQMdpjUOil6guk0b+tc9ulP?=
 =?us-ascii?Q?KF2U6UxnpALlEhsjlD52R+rXAisVsoziDDC2P7drn4X3O06pS7PZPQW78Pnp?=
 =?us-ascii?Q?RqSc73UHTmn2wZ+W0LTVdMXxx2LXGWJAEFvdNApBxDk0bftkYsF1I0MK4Txv?=
 =?us-ascii?Q?+5RLgyaCIhqr6jAgfO4jjmQydDC+MWKhMClw88vP/Z1wOUhwfmzvy0rC35hT?=
 =?us-ascii?Q?pTfm+7sm2tJSBI+ZrMEYmDDP2k4DW8xKwvkLeMKcitPwZ0jzQIkHyEu3ydGH?=
 =?us-ascii?Q?hqxs2jNxvOdAaZ4OmlOE2t77WtW5OTj06s1ytTDGy7ohRoljc9vD1Ox7FcSl?=
 =?us-ascii?Q?SnMPNUlL1O/mo5fihqSMKVQiKIPsc55COQaqvfBziD61BUR7vUTZ+eplN+V9?=
 =?us-ascii?Q?UXcrVVxUMVOjYAQ8wrwRc+2pMNawQk+2SyFDfYblyQ+8kiTa8cd32FgXcFtC?=
 =?us-ascii?Q?s+ffxVU7sFe/b+pRiX5eOfacWCg5PzjYxMmjItOWlSegj6kHeHwzlmkicLbA?=
 =?us-ascii?Q?0hE6ZaBXULPGIT8DQinb4vFM?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24692417404B35DAE5A72A12F1F19DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9236718-54f1-4bfe-a732-08d956f98a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 03:40:01.9678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQ/n9QMbNhShSE5zd+ON/XyaiuesAQ24EaSqvS4l/FJ6RKgJRVPeO50uA3xI2nSpcfSBCGDNOfs55fdzGh1Zgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB24692417404B35DAE5A72A12F1F19DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks John. As in the same context, it's meaningless that two mutex target=
 almost the same thing.

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, August 4, 2021 11:34 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]

@Chen, Guchun<mailto:Guchun.Chen@amd.com>,
Based off your feedback I double checked the code, and I changed my opinion=
 about it, I think it's better just to reuse the original mutex for now. I'=
ve submitted an updated patch for review

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, August 3, 2021 10:07 PM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss

Hello Guchun,

In most of those cases you are right it is redundant, the reason i kept the=
m separate for now is to resolve this bug while also keeping those interfac=
es modular, and not affecting the psp submit sequence yet. We are planning =
a bigger change to that source to remove alot of the duplicate code regardi=
ng the cmd buffer prepare/submit flow and will probably go back down to one=
 mutex there.

Thank you,
John Clements

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, August 3, 2021 9:58 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]



Before calling into psp_cmd_submit_buf, a mutex psp->cmd_buf_mutex is there=
, and after entering psp_cmd_submit_buf, there is another mutex psp->mutex,=
 is it a bit redundant?



Regards,

Guchun



From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, August 3, 2021 5:50 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Chen, Guchun <Guchun.Chen@amd=
.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access



[AMD Official Use Only]



Submitting patch to synchronize access to psp cmd submission memory to reso=
lve potential race conditions.

--_000_DM5PR12MB24692417404B35DAE5A72A12F1F19DM5PR12MB2469namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsipheader23c54b6f, li.xmsipheader23c54b6f, div.xmsipheader23c54b6f
	{mso-style-name:x_msipheader23c54b6f;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheadera4477989, li.xmsipheadera4477989, div.xmsipheadera4477989
	{mso-style-name:x_msipheadera4477989;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks John. As in the same context, it&#8217;s mean=
ingless that two mutex target almost the same thing.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, August 4, 2021 11:34 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a id=3D"OWAAM657D9489ADBF421697FD567A7A47E1AE" href=
=3D"mailto:Guchun.Chen@amd.com"><span style=3D"font-family:&quot;Calibri&qu=
ot;,sans-serif;text-decoration:none">@Chen, Guchun</span></a>,<o:p></o:p></=
p>
<p class=3D"MsoNormal">Based off your feedback I double checked the code, a=
nd I changed my opinion about it, I think it&#8217;s better just to reuse t=
he original mutex for now. I&#8217;ve submitted an updated patch for review=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 3, 2021 10:07 PM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Hello Guchun,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">In most of those cases you are right it is redundant, t=
he reason i kept them separate for now is to resolve this bug while also ke=
eping those interfaces modular, and not
 affecting the psp submit sequence yet. We are planning a bigger change to =
that source to remove alot of the duplicate code regarding the cmd buffer p=
repare/submit flow and will probably go back down to one mutex there.<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Thank you,
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">John Clements<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 9:58 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader23c54b6f"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Before calling into psp_cmd_submit_buf, a mutex psp=
-&gt;cmd_buf_mutex is there, and after entering psp_cmd_submit_buf, there i=
s another mutex psp-&gt;mutex, is it a bit redundant?<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:J=
ohn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 3, 2021 5:50 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto=
:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added synchronization for psp cmd buf a=
ccess<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsipheadera4477989"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Submitting patch to synchronize access to psp cmd s=
ubmission memory to resolve potential race conditions.<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24692417404B35DAE5A72A12F1F19DM5PR12MB2469namp_--
