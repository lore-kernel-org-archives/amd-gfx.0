Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C8C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 04:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAF52246B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 04:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAF52246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6DC89533;
	Tue, 15 Dec 2020 04:09:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD59889533
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 04:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR0WKYfnyChsth21q9Ugh+2E1RGa6xp7QIiiHgGqJvJYZehUJ4OpmZX0OIX6dwRTZLuFJJviuBmrrbL/HK/7LMbR2vl+K7Cvn+WYrj2rMAdPBFSlPRv7icwWKGeX4+VVObBLyB0oPRZ2ml90OxnwKJaFun2kQWd4DNytseucoD8hGhWK3kPnMgjcoAS/k3cgFwCVZ5si8oJ8WZyjuuVzs1Qz4K0ipPvVdlTk+VQe4bdx90P3c61ksbIzqLkhvs3ZGnls1/dSxWYXr9TXpLaGj0ahrwq49NGTGSlPZol+OgWeVxP+yqj6GS7YWUCleylK67VOq8EoCJ7agzv4BRcHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZylwAFjBoqunqvsRY1tdaDk23lFO/tUunVV486Eacro=;
 b=U3v5cPm09VnfNopIx+NN4XN2lpxeCxjEBu9JA+v4s8GUQnGLHHqn001LcngHo8jqKwiZeR/s/4WNplO6drazaWkwhhzIn10qcS9cy5N0IovmWa2mtw2S90BHjHj5dUf8pGW5gMl6Esl8gJjWFkNpbNvNBY+199lj+53tWM2YbJkZOLQGeiWCjHaDgN/ux7PCVOFQjJLdLTJy36ajIJOyCx6F3RnXtdvzR11r96hHpv2fGu6RFtXCNlChtxhFOmNNWmJYYAjFhtL8oG4HdrTVgB5zkgnqaj1zAez4tjM/J1E4xupOGCuyPejZV9qGUF9apkfBM6hiGDOYpC971dDBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZylwAFjBoqunqvsRY1tdaDk23lFO/tUunVV486Eacro=;
 b=LWJoZjY8xX2pT78AQeRcOtn4GqxXXQ3qNTJs1PjOjEgDfpFwfaaIMmItsxBMuH4hHm852ttcU4zfyVV6ELxxVWXKV6IBS+ClfuU4gmc+PSn8PaaNBWDEdYFicUHBNt2YUqKIodPdbHqsH7prMzg10WEGl+jx3dEomg2nrZ7K78M=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Tue, 15 Dec 2020 04:09:51 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72%3]) with mapi id 15.20.3654.018; Tue, 15 Dec 2020
 04:09:50 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: Overlay issues
Thread-Topic: Overlay issues
Thread-Index: AdbSl9sxMkfhaFWoRjW4p/7OX2aWMg==
Date: Tue, 15 Dec 2020 04:09:50 +0000
Message-ID: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-15T04:09:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bce8b94b-7e56-4b3b-a721-00005330ce69
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e81e3412-0958-4fe5-787a-08d8a0af44e8
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB183686BABF00E6C52CE8C4C8EEC60@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fT1PnZkqvE/Y5pYLK1mlScpfOacusT2FTnkZZC1NwPwwYh2VibvpaRnFTHKwWiXroy4atwB9MxYvY4/dZ6cXx8a9lA6yYDT9EGRzxVV5i9Lfay4d7rCbXmASSXZeHHZxh0LAJ8ditueo1XHRjZMOBITz7IqQ+DBbewROp7lmkpz3gF+n9uVulMVTJ81nn4VIey+xtT9rL8Ohoz73ogljLbJ50nqFp4FRQqSTjZc4jLMImybbz4fjCAyKW6wYDYUGvj9rzllvQLc6XshwcWIXXJSHN6vIVhc8S9POhOJAXmLclO6QC24wbQZUyRatB99Epr0axXS05k3z2DZnnOTasqTiUb6FywM+tNfa8+qr0rp04lhO9MgIfvPa90nVw4hDsXPksc6Fu6sqVqnd8TkmIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(76116006)(6506007)(2906002)(6916009)(186003)(7696005)(7116003)(66446008)(66556008)(53546011)(71200400001)(45080400002)(508600001)(83380400001)(966005)(26005)(86362001)(66476007)(9686003)(5660300002)(64756008)(66946007)(33656002)(55016002)(8936002)(4326008)(52536014)(8676002)(3480700007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q1p1YWl1cC90UXBkSCs3ekN2VEFkSXRnWVRsdGhOZ3IxQ2NSRXFxa2NrZHc3?=
 =?utf-8?B?TGlQUUhtTjFrd2dKQ0hDSzBkTWcxUFBZUzk1dENBZWVkVmE5VmZlRDVlbmZQ?=
 =?utf-8?B?c1p3THpDelJrOUluOHZTU2k2Zk03R1gvSExCYkUxOER1SFdldE1JM2ZFTjQr?=
 =?utf-8?B?VmN5Rlg5YzFKenA5eGpzTnBvYnI0SUlPa2ROMDlIMGZna1RsK3F4bGd3UVdw?=
 =?utf-8?B?NWlnK3BGSWkrS1JoTnRvemdKN0RIbW5hMkgvejJxN0pNblo5L2tJNjdwcGFv?=
 =?utf-8?B?cGJqQzh1WGdaZUd0MHpkQnU5VkJCLzd2T2x4WWthWllHMWtpdHJWL24zeUZj?=
 =?utf-8?B?dm0vNC8rT2t5TXl0MGp0SWZXazArM3NjaGVCcm1KVmxiK0g2eTliQ3AxM1dl?=
 =?utf-8?B?cVU3ZzdzdGl4OGRPU3FDbXpLQmVzRWJtSzB0VjBUbXQva2VZSFg1dE54aENu?=
 =?utf-8?B?RmF6b0VxeUJjUW9iNnE1WnRYL3hxUmF1emsyZE5takVsOTJMbHhCanJsOTVv?=
 =?utf-8?B?aUx5cFFESFRkdGY0blVWS0w4VkZETVlwRVpLTFFWejV0ek96UDlZNWxaM1Ux?=
 =?utf-8?B?N1RHMitPSmZ4aE9mOHU3Y1RqQTU4dnNNUGp2Zlh5VFcxNjdmQW1RaTh6dkp0?=
 =?utf-8?B?M0prckpTVTlZK291ZFNJSlFaYUdsajNiVXlHblQwZkJvQUY2Nzh3emxhWWRQ?=
 =?utf-8?B?U1gyakpLVXlWaldEd3NXdmJvOXhnbW1PZ1l6QitNVlNvWmc5QzRXc0M1cWx3?=
 =?utf-8?B?WTdJWWlSL1lGSW9RNTN1cHc1a21LaWJpbnpJd2NFVThjRllJZm8zbUo0NFdr?=
 =?utf-8?B?enNzbTF4eWYxOXA4VWZ4K01mcWtxdkc5ditTMjdlRzVESm1YUlBqN2pEcTNU?=
 =?utf-8?B?dDhzV0RQdDg3MDFKTnpSTGd4R21SbmkweEVaYmFyVTBzdWs0NVRoNWlIL1VO?=
 =?utf-8?B?bkNNM3VINmpxdFVCUGxIUWQzWXZuQ0R3UlVHVHQxeS9idFlBeGVjSm9MWnUr?=
 =?utf-8?B?RXg4SVdHV2ZhWkxpY3JhbExObC91TGtPbUtobERrUFhLMmI5bXlMUDlIRWV0?=
 =?utf-8?B?RG5xWlFvbE5DNnF5bmlieDJacE1pdjAzdE5sSjdHYjQyTDhHeDIzNUEzUlRt?=
 =?utf-8?B?dk9BeitTdjIzSkhoV2oxcTlMWktYNU92V2xVT0RDWlpGemY4WWtFWG50V1VK?=
 =?utf-8?B?WFlMcEVaZGRQSzE1WW1zdk1iUGwwZnFNaUIvR2EyWVR6b1FoMnJwdkZ4bHI4?=
 =?utf-8?B?aDZkYkZtQ01vTXBodTF5UnU5c2RReGduY3YrVERUVUl6SzdFZFc4VUxVbVVa?=
 =?utf-8?Q?VF9XyW52jrQ1c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81e3412-0958-4fe5-787a-08d8a0af44e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 04:09:50.7322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo2FC2NZPOxS3zZM0NZ7al5yfgAislmxhS2pa8/FTUEfjosslGneQWs3jQl5D6HRE3B5w0gCBxzQkEP/4OguNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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

Hi Simon,

Just to keep you updated, I've reproduced issue '[1] - Overlay plane: position not updated when CRTC_X is negative' on Ubuntu using IGT. Seems to happen only with smaller FBs (so far tried 24x24 and I can repro, but 300x300 is OK).

I'll look into fixing this.

Regards,

Nikola


-----Original Message-----
From: Cornij, Nikola 
Sent: Tuesday, December 8, 2020 4:11 PM
To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: add cursor pitch check

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
