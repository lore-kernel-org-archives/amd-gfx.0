Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114B7C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC320223D6
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC320223D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E8E89998;
	Tue, 15 Dec 2020 16:36:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897B5897D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 16:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFJp/0Gciha0VbArJt4M7g5j48lpzS6Qz1y81XDFAj5TJvVJOyajK0R5HDp54x9gjPr9XV83rrtZAqhIHoWxrDJLNwIkMgc+PRmUUYBwAeIoYesCS8YR5CvSE7LRmIjkKhw6j3QSG5OklGvvsj7teIiVw7hCrqOxeIH9AEW8XCbsCYFBoyO0HovPHkkB4CXR7zKZm5Xz+vfwAK8pS/DZ3swRRU0VYWppUe2ewJT/C3SD1Ox3/5Kw7sIW+Ns6fyJJH0dgFDQiWOtIj4VRHXhPmO5S6Hf1ccdfxNgqLbmdGVEU9qP6SsSFKDQ8SUFkFNTq7rFVOt6LnDd6fKg1ud3k4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdWg9GEfzwhFldfctDtLq/2zrA0b/h2gmuJqvHQWg2g=;
 b=OtVWC5nFshAOOKMTmwEhMyjaHIGVOGv2G7JFBi7zkBBr39yc5irYhWpMfJCIRLckfUa6pPd7ZRkFwv2xM/eG4ca0YLm885NBhdIQ+ly75I6W4HFMUYXiN3Y5wsQ3XScrE1GBR8Sp5WLVY3VUoXFMdEC/rKJsFz4tOnMBAQ5V4hMbRDmPQ0vZvY+2LFuFVvEXdgCOLOFmjPm/nR+GJopMejWOmpP4OfJvmZy0yz22YjjIi9XDVo7AQLI/Ndub9hMPVMJiaVhaTUz78yS6Ze7+mPBaVTjybxDuOoxjCB2Aj3bYQtGlWMuNNc2hUUH21150FUvqMSEc4nEd+5OsB4jATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdWg9GEfzwhFldfctDtLq/2zrA0b/h2gmuJqvHQWg2g=;
 b=qU9xemMDng9z4IwhHUu+6Iv/3fTN08zp0Iv4XLrZ56rkKNiPKpbetmVRxr+/tCWa2KekKIj2rw6DZePXvm9uFwxvHIJ2bMQAgPZqhxn4XRtytreIrgnf3ysTjgAQIpNJMgTlcG3AKFKFTwKn2PqiptXO+eTC+fw/G/72UqDgIrA=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.14; Tue, 15 Dec 2020 16:36:42 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72%3]) with mapi id 15.20.3654.018; Tue, 15 Dec 2020
 16:36:41 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Thread-Topic: Overlay issues
Thread-Index: AdbSl9sxMkfhaFWoRjW4p/7OX2aWMgAIDMeAABHbJ1A=
Date: Tue, 15 Dec 2020 16:36:41 +0000
Message-ID: <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
In-Reply-To: <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-15T16:36:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fdbe14bf-82bc-429b-8095-000000e8c469;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-15T16:36:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5c860d4b-b8f8-4cbc-9160-0000874ebb22
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-15T16:36:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4f20ecc4-097f-402f-85ad-0000389c41d0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 896c219d-0b3c-4dd8-9bd4-08d8a1179a43
x-ms-traffictypediagnostic: DM5PR12MB1354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13541E25A39BADBF69796EE4EEC60@DM5PR12MB1354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7TSpLDP9WKaATShOPVRGFKHZ00xg99fxhG7GBAiA8PAbIqAIGaUeyVNzhcEdPz7UizUtbwPPP7zQXEAersKQtIHHjedLZ/IZY/IjUKvJRyb8lNaaYJBWoI4SUkOiAquDpol5LGYoChtCnbYpjjhfawzfoJ6+Kf741xn0P/XMurMsNqttbv1seVOnzBLjWo8IKnuz1kv4uOkNMO+Q7TT8tKRiCiXu2PEyMOxdEE/9g8g27aXjL5dsgk2rJu/UJuc9zRo8oLv8n6VmcE76+vggs1p9cT4NVUWzEjYndjuBuNST+LccbWjZBrddxDbTx/5wk5H09F038xVioetZut8eQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(86362001)(83380400001)(7116003)(66446008)(8676002)(33656002)(76116006)(66476007)(9686003)(64756008)(66946007)(66556008)(7696005)(52536014)(55016002)(6916009)(5660300002)(71200400001)(6506007)(4326008)(2906002)(3480700007)(53546011)(508600001)(26005)(54906003)(8936002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eFArWHVYUWcvZm1ReitxSHlwS1hSK1plZnN3M01CL1ZmcE84WC9rc2RJay9k?=
 =?utf-8?B?VUxNT0l0d2VWb3R4Vi9DMUhETEhMd1BrSUhSTmlDV0QzVlI2VDh4Tm11QmpX?=
 =?utf-8?B?Vk1YSmxaOHRTbWRmd2J4OTFMTUkySng0cXNndlkyQko1YU8vMkFSWW03cEJV?=
 =?utf-8?B?REFJRFJQa2lKV2pQQXhFTm44ZmlNWXh2U2E3NjZ6bFA2dityL2ljM0Z6NUdy?=
 =?utf-8?B?WnF4eHpnTmtYRUt2L3FXdUNJcVd4bVZvZEl3ajQrZTVvZHFpTmVnbmR4a1RI?=
 =?utf-8?B?QWQ0bTB0aXV4dTJYR3c2dzYwNjNiMUNnTmpUQ2c0TUc0NXROcU44NDFtMTVy?=
 =?utf-8?B?bHVQSGIxOGg1Ym9GdW1hRDhwc1hGNEpGZHVtNGpmMkhicXJsUk9SaGl0Z0Zu?=
 =?utf-8?B?ckMwWTl3R00yUVp1eUQ3dkUrbndoTXc5M3g4WS9XNERpZ3J6T2RmakpoaWJa?=
 =?utf-8?B?eVNEUDFEelJIUWFneTRTZUVOVW15Sm9kOTR5cUN5ck5JRzFEZWg5M3BUdExG?=
 =?utf-8?B?Q1JWcEpiVEwyaE5wRkJ4TENPUGltL0o5SUliTnZmS3dSZ3RhM1hreXpOaldS?=
 =?utf-8?B?TWJsMVdCSjRTUk4yV3JMSm9YT2NBeGRLbk1peVVYTFVkdElYKzErM1J5enlk?=
 =?utf-8?B?NnFJWUYzNlR1OGRnVEI5NU1vaUtJOTdkdWlhTW9RNzUrQTVwa2QreHFGdWdF?=
 =?utf-8?B?UFFtRUg4V09la3JBcDZsc00rVTFzc3dIMEZEb3FPcXh5NW5ZSm5UOHFXT05z?=
 =?utf-8?B?S1ZFeGFRS09Nb0xUN2tZZUJ0TGtkdVJ5NTlqOEVXVDJQVlJ5R1ZDbFkwM1Fa?=
 =?utf-8?B?bStJRmcxcnVObkhQVWQ0aVd4Sk10N21Eb0N5bUhNS3ZMT2pwUXBZYy96Y3Bt?=
 =?utf-8?B?bnI0cFpXRk5wY01pcE5uYnBZQWlGQ2ZhS0x6VkRxR2NSazJSc2JHRW1SOURs?=
 =?utf-8?B?eHUvTFRqcnkvT3Z6ck9OMHluaXN0WWNXTzVacEpPcWhMbTYzU21qNU12bjlC?=
 =?utf-8?B?bHhEUzVFMlM0dEFyNlpQUS9ianF2SnJhNExWWGtSMFN5ZXluZ21UVm81c3dt?=
 =?utf-8?B?UEcwN3dNRGM2VkRlTEllVWNETzFyb1JGNEN1a2l4bTFvVFQyOG5MZTRMZnB6?=
 =?utf-8?B?dWVhQzBHajh6SGgvZzZQU09xSGgxNmlJL0ZjWThUcGNuelg1UGtNWkhWaFl6?=
 =?utf-8?B?ZVkxbGJ5UmE0WUJwSmNZbjRvb3FIRk4xdW9tOEZHS2t0RHhuRTVPZ3h0cldF?=
 =?utf-8?B?RTRoYWZiQWE1ay9HZytnc1gwdExmSmlLVWRvYlhJRjRrQ2pRNFgyV2cxRDcr?=
 =?utf-8?Q?A4nbX5mZXX+Jo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c219d-0b3c-4dd8-9bd4-08d8a1179a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 16:36:41.5538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXtEj7X1XjvZPEdJcwapBaOVpNfHSz92qGJYeU2dqtm4R5yzRBOhJqcepFagpAKcpgdT4pqdwAfzC9V1huoAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

Yeah, but... it works with bigger FBs (300x300). So looks like some clipping somewhere works OK until a corner-case is reached.

-----Original Message-----
From: Simon Ser <contact@emersion.fr> 
Sent: Tuesday, December 15, 2020 2:58 AM
To: Cornij, Nikola <Nikola.Cornij@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Overlay issues

On Tuesday, December 15th, 2020 at 5:09 AM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Public Use]
>
> Hi Simon,
>
> Just to keep you updated, I've reproduced issue '[1] - Overlay plane:
> position not updated when CRTC_X is negative' on Ubuntu using IGT.
> Seems to happen only with smaller FBs (so far tried 24x24 and I can 
> repro, but 300x300 is OK).
>
> I'll look into fixing this.

Thanks for the update and for looking into this! Let me know if I can help with anything. Nicholas replied on the issue tracker that overlay planes couldn't have negative positions, so I was thinking of having a look at the SRC_Y handling (see if we can do the same for SRC_X), experimenting with FB sizes and SRC_W/H to figure out what's the overlay max size still triggering the bug. If we really can't emulate neg SRC_X we should fail atomic commits with negative SRC_X by returning EINVAL (so that user-space can fall back to not using the plane in this case).

Simon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
