Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F305EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 21:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B596E207AA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 21:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B596E207AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D1F89804;
	Tue,  8 Dec 2020 21:11:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1117A89804
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 21:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey1gNwAhWlHZ3qTm6V4Bd6yzh5a9M/ifFW6pMnFCQuZreZ2cs+Fn1pUQc7v+Q36InYlPcayKlqw/lc+S1kBpvhXhxu95lEnQ//QZVxOtFUlw4Uzf6y6ORVOPzI96FiAfKqheC6xrLIWwUCMvZasvQWZfF2nM3hB8qnM1Smh/VS5XinvLltSblYgJk/MQdxony+kMMZYnUneD07s6DGi189OqLm0Bx6+vymaZ0YgpttfB6Y7fIb7mvohcIaGErMdKW+c2qw4I/lH3N6goKH2DGTN1NhlXDjtzy8tLQCLLl25asfDa5z8AFfFM4fwdGD3W18Y96R64/8PbmJMop15XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxG+sgRwDJxea2S/F+5D3uWzk4/uT4zG9e49K3CLs/U=;
 b=OMnnZuN/O5L4wGnV1xAKszngyZe+VOrLhyBUwPXQFXrbKS1SrwA6LEdggSiz8UeZN772NxPILJd6GCUYPxCqGblldAmSIYGrhO/Ez3X0f9BAcm5MSa+ClNWmXzDT3b6NsNORRSz1MppFPukTQaApC8vo1uRmyou42hBDcKLcwPgbL/LA0yRs67bCrxOF0uE+GtpGUxspVkeRPkukJISouRKV3g7tuSypbJ/LXgbHIzDVE3p8cfptlZusUNLR3GQtWAf0v+5GbssOYrgJ2YWOq07dE7fT/VEE4OiANt9S8z3vwE/dFn2qG0JN2CQioXfgcksguXDspZIt8QBtaIfxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxG+sgRwDJxea2S/F+5D3uWzk4/uT4zG9e49K3CLs/U=;
 b=z21E7qdkN3Y6if87MgBkvjNn0sg5eJ8zZDqc5tLmSZnTJHsFE29gAaj60E1OxJqMIWFE4mWAXnOQfTtkyHiGAYiMAmYgNsw7PmEnKt6tAsiJYfceWwDUZxxtffTq6DhPHBQRo4LCTpcOEktpoqxFzn91V+C48YLe1xEFO6w7R5E=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 21:11:30 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72%3]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 21:11:30 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: RE: [PATCH 2/2] drm/amd/display: add cursor pitch check
Thread-Topic: [PATCH 2/2] drm/amd/display: add cursor pitch check
Thread-Index: AQHWyO9s06o5qPoHW0WIbjM9EO7Oe6nkU5+AgAAOTwCACA/RIIAAr7oAgABNTtA=
Date: Tue, 8 Dec 2020 21:11:29 +0000
Message-ID: <DM5PR12MB4679FF805EF736EBE77B2476EECD0@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
 <e1f8e29f-138f-9e1d-0ba7-ce10059f87d0@amd.com>
 <CADnq5_NmrL7=BsUZ-CGiA=0e7W83Sf5Dek9iOYCX7ji8aRJmQg@mail.gmail.com>
 <DM5PR12MB4679A4125CA7B11387B58FF5EECD0@DM5PR12MB4679.namprd12.prod.outlook.com>
 <vkqrs-73v441dUQBOsO7tDuuHoWp7_DXK8nx99ynWW31yDWo4Nf_Sg7zeq1aDOsZTIWkTWvsLIhha8Id9xWvqCAsl2Wjg8yki1sIn3OEwTg=@emersion.fr>
In-Reply-To: <vkqrs-73v441dUQBOsO7tDuuHoWp7_DXK8nx99ynWW31yDWo4Nf_Sg7zeq1aDOsZTIWkTWvsLIhha8Id9xWvqCAsl2Wjg8yki1sIn3OEwTg=@emersion.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T21:11:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6ce2bdf9-7c0e-4ecf-8912-00008769d35e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-08T21:11:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 751373f3-d721-479d-9ce4-0000117c5506
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T21:11:28Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b7e475ed-dfee-4eff-86e0-000018314f40
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 243f2b51-a368-4f07-6121-08d89bbdd53b
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB317941FADE866236989E2A4EEECD0@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IEKI9arx/M7ZG7tJWiyMEk9P60zU3AyHlcUvkYfk0B7RyX5Bf87aRb+Hs9lLEgntVLIZCwcc03CqbRFbdjHkR+XuhfFcnhcFrPsd1iZrgQGrgvIZouUGXzyi95kTIPOC+1zG9f9Xci5b/uxjmQAASBw7KG4s5Nx/iDU6CuxKuTcQMpC5kmYOPH2tU1SZv3CzjaJ/qLokBNhu54p0aKrjLxhVZSUPZnA5n65qHxxWqFTx6bIyH0sL2G0MLbRi9cI7YbvlHFD5gqsV54zPyi/Ium7DiOf1BRnLAA173IEctBGcT6nIlh8nO0pd5X8bqSQPLhu9VlrM5QRwz1F+KmC5de/qlQwdJmzNphH1fid5XbW8ZDvwk93+fh3EZl6zqvc/XudMwUjIp1j8Ia5+P4heLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(54906003)(53546011)(6506007)(186003)(26005)(508600001)(71200400001)(86362001)(8936002)(7696005)(2906002)(8676002)(966005)(55016002)(45080400002)(33656002)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(5660300002)(9686003)(4326008)(6916009)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aExmajZralhUdEFtOXZTSXJoNC9JYUd2NnBKUU1SVFhjd3ZlSnJaN1JCdmZ1?=
 =?utf-8?B?U3RBaEkvMk9TdCsvYm4rM25STHluQ2lwcGkrblo0dHUzTjdtNmhiN0JyODBl?=
 =?utf-8?B?ZlM1WEtjenFRbXNTTjdhb1pOWGJDb3BLQVRNNzhKaFVlYUxuL0x2TzhldktO?=
 =?utf-8?B?ZzYzaHAvbnFUSXBJejhGMitIVUxRcEpoZERmUlo1Z3ZGdWc3clo5LzNZb2l5?=
 =?utf-8?B?NUk3M2FzY3habkhSTGdtRFFLTnlsclpGeW5zNEU5cE5BbXF5Y1VDV0N2ZjNu?=
 =?utf-8?B?Q2x5Q3M1NTNCK2JqZ21CKy9QR0VQWDRmRkgzN3VuS0hibTdHRDdUeGlKbHR1?=
 =?utf-8?B?U3dTbkZFY1hFMUt4Y3Zrb1pFc2RJYjJNTjdYY3RJNStRamx1d1BIbHJwTE8w?=
 =?utf-8?B?WUw4d0JmL3I0UEdaelZFbTN1UmVSWUV4UjZxV2VIT1ZjWjNGWVZMSnRXbUcx?=
 =?utf-8?B?Ny80VUFUYnJsZE02SFlxRnlUSUI2TzliT3V1NWsxdjJIb2ViUUlwWURsRis2?=
 =?utf-8?B?c2srd0NLQ0plYndlVFBhdjJheXppQ2RYeFZmNmYzK3RQdEgwZWg0Z1BOM1Fw?=
 =?utf-8?B?UjVTQmsrWFRxZ0hWWDBrVmpFQlJDVWxrTC9IZm40UWtQelhpR3h4dzZiS2Yv?=
 =?utf-8?B?TnI4bWJKNnZaUEsxdzhSYktUbWhjMmdqSFhqRFArU2J0a21LbkpBc3dreWt2?=
 =?utf-8?B?eWkrUHRFRytNNHYrV1ByUklCdlByQUVLbDM4QklpUTFRMkJZMGpiZHhPR0I0?=
 =?utf-8?B?S2NBaEYxbTVweWhrQ2dKeEUyZjEwcFJ1R24zNS9JTTZtNWxsUU9KN1RZUmhh?=
 =?utf-8?B?YWlzV084aXBERHU4U2h5OTd4d1YwS09lWkU5UDR6WWlNcGZiVVVHcUNCaS9a?=
 =?utf-8?B?UDFEeXhsR2NWTWNOR0RIWjU0RUJhVXRhaWlWV1RZRENEU3V6ZHV3cjVEU0tk?=
 =?utf-8?B?Zit6UTNiclgrK2FiT2Q1WHBJV2FZdVR1Z3BKNnA3ZXJ6ZVEyY0Q0Y20zUHlI?=
 =?utf-8?B?YzV0Sy8yenpzblBVaVl1NEd3M0ZZTm50VXRiS3ViMTRiLzNTclIyY0dZVFdU?=
 =?utf-8?B?RmlGdHp1MFI4Vk1UeS9YSC9pVEZYZDJkV3g2RjMzY3ZMUHU5Y1JvZWE2dDZY?=
 =?utf-8?B?RW5xYWRETk5PSW9vRWtqcklhNjBvNXMzU3BpZGc5dzdXR0lMVGNrSlpQTWt2?=
 =?utf-8?B?UVQ5eGkrV2tvUXNkQjdXSXNZMi92QklTL1JMYmFDZWM1OWY2OTQ4UGlpU0ky?=
 =?utf-8?B?aEQyZDRGOU9XNU4xZTlRZXR3bytjVGNOaWYwNzRZaXB6UFZmL0hURWo4UGUw?=
 =?utf-8?Q?rEo/Z/U6urGus=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243f2b51-a368-4f07-6121-08d89bbdd53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 21:11:30.0398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e86waRylNd0b5RlWNJ/2J947e1DjeshRWvquKyM2dobScdgWdhgDIE+St9vl+SUjJzEGR70kC3CfKbUK3gHIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Very good, thanks!

I'll take a look at the overlay ones, then.

-----Original Message-----
From: Simon Ser <contact@emersion.fr> 
Sent: Tuesday, December 8, 2020 7:00 AM
To: Cornij, Nikola <Nikola.Cornij@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: add cursor pitch check

Hi Nikola,

On Tuesday, December 8th, 2020 at 2:36 AM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Public Use]
>
> Hi Simon,
>
> It looks to me I'm kinda late to the party to look at your questions 
> under https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2020-November%2F056032.html&amp;data=04%7C01%7CNikola.Cornij%40amd.com%7C6a860bd758d044c4a3bf08d89b70d628%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430256236209108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=T5ijUId6nrrKK3R7c62wVllZ1rEhKdmi95Foijvjf5M%3D&amp;reserved=0...
>
> Does the commit below and
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Farchives%2Famd-gfx%2F2020-December%2F057048.html&amp;data=04%7C01%7CNikola.Cornij%40amd.com%7C6a860bd758d044c4a3bf08d89b70d628%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430256236209108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6GKjptsf0S%2FWzg9CwSnp89EkaQoMxgyq9JvVcVhJIyU%3D&amp;reserved=0 mean the above issue is now on its way to resolution?

Yes, I've figured everything out about the cursor, thanks!

If you have time, another thing I need feedback about is overlay planes. I have some bug reports [1] [2] about corruption when using a small 24x24 buffer near the edges of the screen. However everything works fine with a bigger 256x256 buffer. Is there a minimum buffer size for the overlay plane?

Simon

[1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1385&amp;data=04%7C01%7CNikola.Cornij%40amd.com%7C6a860bd758d044c4a3bf08d89b70d628%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430256236209108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rXhMSAySLeVbVP7Pw6vw2B0%2BnrNcKqsveeFKRYMWNhE%3D&amp;reserved=0
[2]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1386&amp;data=04%7C01%7CNikola.Cornij%40amd.com%7C6a860bd758d044c4a3bf08d89b70d628%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430256236209108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gD%2FTWuBAVM8AuEfbY7c6tp%2Byns6I6hd9SihTKrO4so0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
