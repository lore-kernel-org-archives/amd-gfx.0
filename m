Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6147FC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 15:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2109560F91
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 15:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2109560F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC566E42C;
	Thu, 12 Aug 2021 15:49:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A2B6E42C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 15:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeTBKtzFqBfiOBXmDoY/9b6wk52ji3sabGeNcRpoMkkUpbUVWwC5ONM4myVpUfmh9d8WY4OSkIwiSDZiBNfBUTVvKSL4g9khpZ1KXKFMUpF0vct6wTnH/8CFBwzB0e0EwVInP0Kn8A2RhdVkFTUi8HIhTjjkmoWjBlyByji1v4fZIt5xuJwjMbC7QHeejUfy5LCzDOZ0TdxtwuDYenm7uSgeMYtEMktWdIyCbMjNnbtsh87eGdaPIzG0d4aPAHHQIQWZhPNKhO1fXg6gH+5+osphLgDAlZm59r5k6uK1QwQg/6wII9BUXIWrBKNHWkRyenHfLguL/WCGum9S+uLD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cFCf4SuwD0UHaB1Rctjjnexu2g+rglROES/oJ89KqQ=;
 b=l/RLAC5zFFMHlX9U0eay2DN0znZWGyU3YdTPahjiJmKvzfOr4PpMPQrwG0yHID4OS80L9uVWJmOshvbXg1gY+1IE1qFUwHoQVHwhHcownlpaMHyCnIQdEELXk5juMNjS0lzfv5b7W9pfJ8ADezff/qjbzERTtjUWIE9J8DauYDukPSF/Tu7PIlKm7bi0ux2cQXsowt0Yzk26W93X8uDCedTRCKkJTfSINUHU0z5Hd+XOO/W5nMT2zPkoqmai2J8Lj8Jm7m7hW7CwdpV3QJfRxr+lUw6MB1k/TObNfeCLRMdtW3Fin+D31aqXRg/gtmZSKH953rn/7KsClMf6PVjhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cFCf4SuwD0UHaB1Rctjjnexu2g+rglROES/oJ89KqQ=;
 b=N4AzAbb8CKW6ZailmuV8JMuEfl1eiJMdTD1LwgdkOjq+8b2L1x610fmNOmnj5AVi2HL//GPU3v0okDMg5y9L1mDoXncJSIAHk/ouWIbfxBwB4J1JRS9kCZJEJLEs1v2KbiYIJR1C+pv+LpxrkKuZXlVlQDmGFoJaQFvn2jgni1w=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 12 Aug
 2021 15:49:43 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 15:49:43 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix random
 KFDSVMRangeTest.SetGetAttributesTest test failure
Thread-Topic: [PATCH] drm/amdkfd: fix random
 KFDSVMRangeTest.SetGetAttributesTest test failure
Thread-Index: AQHXjaI8cWWw9imTTUGWK/O7HiWLPats5V8AgALEsvA=
Date: Thu, 12 Aug 2021 15:49:43 +0000
Message-ID: <BYAPR12MB3416A20073AB5277FEB144CEC1F99@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210810044310.3805858-1-yifan1.zhang@amd.com>
 <a07e70af-4ab8-a359-480b-d348755cbfd2@amd.com>
In-Reply-To: <a07e70af-4ab8-a359-480b-d348755cbfd2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T15:49:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=054a32ad-f15e-4bc9-91fb-d8352c63cadf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7602792-b7a2-4b32-3f90-08d95da8cdcc
x-ms-traffictypediagnostic: BYAPR12MB2886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2886D03E4045F0B4BAB2D682C1F99@BYAPR12MB2886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5biOkmKQuxJKx+WXfv+/UQ5t/su8Krnv9kSlfhNE49RP9EasJDsqwmKpfCDTUu/4rcCJrNiYuMRbnRC4VDHmpqdttfP6WUs7zx+DDaIxG0ydq7V0yHCkx4/+tz/DME/KK/nOtu4sDLmeqGSMQk7qZz8Z7tEvIWu0tl7XuEyWuRL/3Aya0ZPDh3ckvB8h6Cuj+HdPCg4JGS4uKvQI+CvN8fwnd25T71yhWEX2kpE+r6kmZKd+IcFG+sGs3zJpuWAlfSleVAbyClYHLTcZGPWqAHeYLP7ZzeMipMxm2wJIMdOvyEOKstduA4M0cv7+2yh84cypR1CXsU/Zc8DqOTiLgpfRz68GwNHLR3n8lB7+hCRPXt+eiaT4WRmkzA07odRps4y3vpcI0NbupqhaWu1zPEWvFGCNewDuH8b24On0QebadbLgsHNOFOYjXHGeiYBgAAQeYjwWqFmBy8fDzXWWSzd7vWiEw+22KAav0wrR7YC0yfVQ94Fckq5cvzMZ9gZFbb+5mwK4o/iE8FMLYFp/4x0Gc82ED1wXgZIDDlEPmnCzjLGWv6FrHXsoGRPZ2180P12T8vlSgI0HEdd5jSYsdji85hbEVpdD46fuxfjDzT2v3a+T7nB4hnJ9qaZpH8/eCxmaUIrllsCGZCzbR9N/n9GDrD4qwESVnBhG3qRWaqcRkZKlP+ojGxLk/xHkNnDBAxGEmeLRo15sOK1Sx74nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(86362001)(55016002)(8676002)(316002)(110136005)(83380400001)(9686003)(66476007)(186003)(122000001)(76116006)(53546011)(52536014)(66946007)(38100700002)(7696005)(66446008)(6506007)(5660300002)(33656002)(26005)(38070700005)(508600001)(71200400001)(2906002)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhLaGVMK0cwQWp5UzNXT2N0QkZOQmtycTdyR1VhZ3hnQm50Tks0MU5QQkRY?=
 =?utf-8?B?ZDRnTzFtTkNVbXNyNjhYanp6ZFRjbjBFRDhQVXhJVEp3UzZJUjkrZlF5a0Fo?=
 =?utf-8?B?eVpaekFIVXlTclN1WXFQRk1HZG5iRlY0ZnNaZ2wweVAxdzVjUkE2c1dtQW5Y?=
 =?utf-8?B?RUUyTUtHUmt5eldHalk2Q2xBRXpXNjY2b3hoNmo3K2x1ckNFSldIWi81V25k?=
 =?utf-8?B?b3VGaHo2SXBlQ3dBNXhDTitXK3hLYmZSOEdXenJzN25KYjhRbTJ1a1RqYUJS?=
 =?utf-8?B?QU5GQmg1NHk2d2dJclFoOVMzNTlYMWFMb2oxTi9XTWJZRFV2cm9MbWxKT1Zp?=
 =?utf-8?B?eEdUbUEvMnNhODh4NnY3TURLWHdEZzBlM0N4ZTBUNFZJU3JQcFBFUHlZYk5F?=
 =?utf-8?B?R1RxUFl1T21kWGFreTA2Q2IvTDFMSitpeXZFejk0ZDBuTWxheGpGSE1IZ1dl?=
 =?utf-8?B?eWpRRjlJT0tMeUF0LzRjZGtTbmZna2taUWhRN3UyVWVxbjhWc0p1YjlreXBk?=
 =?utf-8?B?ZE9ZQ1JncjdMdmJrOEJXdGZJSENtcWw5My9LUlUzS3BSY0VRaDlkTlZuZGwy?=
 =?utf-8?B?VVFONXBzSy8vYlpXbTIxQVFyOVJBMnBlNFd2NHp2ZEV5bXNBa3lqVVc3RVJo?=
 =?utf-8?B?QThpZXNIMVVweVZIeEpTZ25aQnlBcFAraHBxU2FNdlhzMm9ZbUx0b2tseUVY?=
 =?utf-8?B?NXhQWEQrNURKM1hjaytVLzhyNmtOMFpReExuUEVLMk9yQ05QSlVjRXJlOSth?=
 =?utf-8?B?czFzazRvc2I5Y1c4dytoQ2FjNzB4dXlxNEdpREpzSHBqa3hNMWdKQTdVSC9y?=
 =?utf-8?B?UTZzQnJXUW51aTIvTWpZbTllSUpOVThuampkZW15Zy94S1VVbmwzU21VTHFr?=
 =?utf-8?B?K0h1MnlsWGhyYmRRYzN6dERmRDI0dlJNc0tWU3pLNlg5RXp2cHZYOHRXUG9L?=
 =?utf-8?B?V3pyeGNpM0I2bVk1bFc4SE80WHBhYzYzd3Fld1FTMnlMNWU1Njh1R0trNVFM?=
 =?utf-8?B?WG50S3lXSXc3ODFjUDR0cThpUTNlUFYrRmFOcWRuK0grY0VnWk8reXFUMWJ2?=
 =?utf-8?B?NWlvOEQ4UWFYcFN2UnlTdnZvdTV0di9hYTk5Z3hSbWdwVWpTc3ZpMTV0Tlo1?=
 =?utf-8?B?N21IK2NLdXhzOWpiQkFyOGhNSjIzeXlGcUpTTlp6blg1KzgxRjNnZFBNSVVq?=
 =?utf-8?B?UERML3h1TUd5YUlCQmlKZGtFN2lPWVN1SjhNbE5VK1dPNVJaVWZKWEFMYkJP?=
 =?utf-8?B?c0J4Ym5yZ2ZnaVlJOVZmTElsa2Jlcy9FVGovc04wR0I2cWZoeEcxMXBHcG5r?=
 =?utf-8?B?VmY5cEs5SUl3NE0yS3hleW9WNzFKK1ZEUmlTTW5OQnVibnFPbnQrelhsTlN6?=
 =?utf-8?B?ZVlwRlB4ekxJSUNkQ2hQQVNFeEZJdThPZ3hXSGRMc2JxeGg4MVpCOXdLMC8r?=
 =?utf-8?B?Y085UENCT2N1UXJPa0Z1NmpNbGo4QUVNYTM4dWhmenBjaXloNG8xUllXd3hz?=
 =?utf-8?B?eVRkQTZackhyNFBFbkNKOGxRYW5KWExRb0ErdFZPeU1XNG0yN0FBRjFyQXdJ?=
 =?utf-8?B?K1pEZXRENWhGc1RKTzZMSkVCbS9xcDE2aWN2bml3ci9sYU1FY3R0QjV6MzBM?=
 =?utf-8?B?WWRBRlNwK1ZHMXJOTmV3aWVmNkJxUDNoRWxWMUxaY2R3WFhNc0xIN0xMVXF4?=
 =?utf-8?B?YWJBNkFBV09mZTVVeE1JZFFyTUxsSmh3eDdpRHY3bGlTWjBncTV1OHZZZU15?=
 =?utf-8?Q?+ZLvUrmPymSfZuK9ezAMou/DwxjziJTlbvYuI1N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7602792-b7a2-4b32-3f90-08d95da8cdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 15:49:43.6500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/V42/EYteG2lDZOFZKqDVNxmh/+niUaWxouwM085tnUZvVi9d/TZrtEIgS3Uh2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KWWVzLCBpdCBpcyBhIHN5bmMgaXNzdWUgYi93IFNW
TVJhbmdlIHVubWFwIGRlZmVycmVkIGxpc3QgYW5kIGdldC1hdHRyaWJ1dGUgY2FsbC4gVGhlcmUg
aXMgdGltZSBzbG90IHdoZW4gUHJvY2VzcyB2bWEgaGFzIGJlZW4gdW5tYXBwZWQgZnJvbSBDUFUg
c2lkZSwgYnV0IHByYW5nZSBpcyBub3QgcmVtb3ZlZCBpbiBkZWZlcnJlZCBsaXN0LiBJZiBnZXQt
YXR0cmlidXRlIGlzIGNhbGxlZCAgaW4gdGhpcyB0aW1lIHNsb3QsIHRoZW4gdGhlcmUgd2lsbCBi
ZSBhIHByb2JsZW0uDQoNClRoaXMgaXNzdWUgaGFwcGVucyB3aGVuIEtGRFNWTVJhbmdlVGVzdCxT
ZXRHZXRBdHRyaWJ1dGVzVGVzdCBydW5zIGFmdGVyIEtGRFNWTVJhbmdlVGVzdC5CYXNpY1N5c3Rl
bU1lbVRlc3QgdGVzdC4NCg0KVEVTVF9GKEtGRFNWTVJhbmdlVGVzdCwgU2V0R2V0QXR0cmlidXRl
c1Rlc3QpIHsNCiAgICAgVEVTVF9SRVFVSVJFX0VOVl9DQVBBQklMSVRJRVMoRU5WQ0FQU182NEJJ
VExJTlVYKTsNCiAgICAgVEVTVF9TVEFSVChURVNUUFJPRklMRV9SVU5BTEwpDQouLi4uLi4NCiAg
ICAgSFNBaW50MzIgZW5hYmxlID0gLTE7DQogICAgIEVYUEVDVF9TVUNDRVNTKGhzYUttdEdldFhO
QUNLTW9kZSgmZW5hYmxlKSk7DQogICAgIGV4cGVjdGVkRGVmYXVsdFJlc3VsdHNbNF0gPSAoZW5h
YmxlKT9IU0FfU1ZNX0FUVFJfQUNDRVNTOkhTQV9TVk1fQVRUUl9OT19BQ0NFU1M7DQogICAgIHN5
c0J1ZmZlciA9IG5ldyBIc2FTVk1SYW5nZShCdWZTaXplKTsgLy8gSXQgcmV0dXJucyB0aGUgc2Ft
ZSBhZGRyIGFzIHRoZSBsYXN0IHRlc3QgY2FzZSBzaW5jZSB0aGUgYWRkciBpcyBhbHJlYWR5IG11
bm1hcCBmb3IgQ1BVLg0KICAgICBjaGFyICpwQnVmID0gc3lzQnVmZmVyLT5BczxjaGFyICo+KCk7
DQogDQogICAgIExPRygpIDw8ICJHZXQgZGVmYXVsdCBhdHJyaWJ1dGVzIiA8PCBzdGQ6OmVuZGw7
DQogICAgIG1lbWNweShvdXRwdXRBdHRyaWJ1dGVzLCBpbnB1dEF0dHJpYnV0ZXMsIG5BdHRyaWJ1
dGVzICogc2l6ZW9mKEhTQV9TVk1fQVRUUklCVVRFKSk7DQogICAgIEVYUEVDVF9TVUNDRVNTKGhz
YUttdFNWTUdldEF0dHIocEJ1ZiwgQnVmU2l6ZSwgLy8gVGhpcyBpcyB0aGUgcHJvYmxlbWF0aWMg
Z2V0LWF0dHJpYnV0ZS4gSXQgcmV0dXJucyB0aGUgdGhlIHByYW5nZSBhdHRyaWJ1dGVzIGluIHRo
ZSBsYXN0IHRlc3QgY2FzZSBzaW5jZSBwcmFuZ2UgaXMgbm90IHJlbW92ZWQuDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbkF0dHJpYnV0ZXMsIG91dHB1dEF0dHJpYnV0ZXMp
KTsNCg0Kc3lzQnVmZXIgYWRkcmVzcyBpcyBhbiB1bnJlZ2lzdGVyZWQgU1ZNIHJhbmdlLiBUaHVz
IGhzYUttdFNWTUdldEF0dHIgc2hvdWxkIHJldHVybiB0aGUgZGVmYXVsdCBhdHRyaWJ1dGVzLiBC
dXQgdGhlcmUgYXJlIHNvbWUgY29ybmVyIGNhc2VzLCBkZWZlcnJlZCBsaXN0IGZyb20gbGFzdCB0
ZXN0IGNhc2UgaXMgbm90IGZpbmlzaGVkIHdoZW4gZ2V0IGF0dHJpYnV0ZSBpcyBjYWxsZWQsIHNv
IHN2bSByYW5nZSBsaXN0IHJlbWFpbnMgdGhlIGNvbnRlbnRzIG9mIHRoZSBsYXN0IHRlc3QuIElu
IHN1Y2ggY2FzZXMsIGhzYUttdFNWTUdldEF0dHIgcmV0dXJucyB0aGUgYXR0cmlidXRlcyBpbiB0
aGUgbGFzdCB0ZXN0IGluc3RlYWQgb2YgZGVmYXVsdCB2YWx1ZXMuIChUaGUgdHdvIHRlc3QgY2Fz
ZXMgYXJlIGluIHRoZSBzYW1lIHByb2Nlc3MsIG1tYXAgaW4gSHNhU1ZNUmFuZ2UgY29uc3RydWN0
b3IgcmV0dXJuIHRoZSBzYW1lIGFkZHIpIGFuZCBtYWtlcyB0ZXN0IGNhc2UgZmFpbC4NCg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPiANClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxMCwgMjAyMSAxMTo1NyBQ
TQ0KVG86IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IHJh
bmRvbSBLRkRTVk1SYW5nZVRlc3QuU2V0R2V0QXR0cmlidXRlc1Rlc3QgdGVzdCBmYWlsdXJlDQoN
CkFtIDIwMjEtMDgtMTAgdW0gMTI6NDMgYS5tLiBzY2hyaWViIFlpZmFuIFpoYW5nOg0KPiBLRkRT
Vk1SYW5nZVRlc3QuU2V0R2V0QXR0cmlidXRlc1Rlc3QgcmFuZG9tbHkgZmFpbHMgaW4gc3RyZXNz
IHRlc3QuDQo+DQo+IE5vdGU6IEdvb2dsZSBUZXN0IGZpbHRlciA9IEtGRFNWTVJhbmdlVGVzdC4q
IFs9PT09PT09PT09XSBSdW5uaW5nIDE4IA0KPiB0ZXN0cyBmcm9tIDEgdGVzdCBjYXNlLg0KPiBb
LS0tLS0tLS0tLV0gR2xvYmFsIHRlc3QgZW52aXJvbm1lbnQgc2V0LXVwLg0KPiBbLS0tLS0tLS0t
LV0gMTggdGVzdHMgZnJvbSBLRkRTVk1SYW5nZVRlc3QNCj4gWyBSVU4gICAgICBdIEtGRFNWTVJh
bmdlVGVzdC5CYXNpY1N5c3RlbU1lbVRlc3QNCj4gWyAgICAgICBPSyBdIEtGRFNWTVJhbmdlVGVz
dC5CYXNpY1N5c3RlbU1lbVRlc3QgKDMwIG1zKQ0KPiBbIFJVTiAgICAgIF0gS0ZEU1ZNUmFuZ2VU
ZXN0LlNldEdldEF0dHJpYnV0ZXNUZXN0DQo+IFsgICAgICAgICAgXSBHZXQgZGVmYXVsdCBhdHJy
aWJ1dGVzDQo+IC9ob21lL3lpZmFuL2JyYWhtYS9saWJoc2FrbXQvdGVzdHMva2ZkdGVzdC9zcmMv
S0ZEU1ZNUmFuZ2VUZXN0LmNwcDoxNTQNCj4gOiBGYWlsdXJlIFZhbHVlIG9mOiBleHBlY3RlZERl
ZmF1bHRSZXN1bHRzW2ldDQo+ICAgQWN0dWFsOiA0Mjk0OTY3Mjk1DQo+IEV4cGVjdGVkOiBvdXRw
dXRBdHRyaWJ1dGVzW2ldLnZhbHVlDQo+IFdoaWNoIGlzOiAwDQo+IC9ob21lL3lpZmFuL2JyYWht
YS9saWJoc2FrbXQvdGVzdHMva2ZkdGVzdC9zcmMvS0ZEU1ZNUmFuZ2VUZXN0LmNwcDoxNTQNCj4g
OiBGYWlsdXJlIFZhbHVlIG9mOiBleHBlY3RlZERlZmF1bHRSZXN1bHRzW2ldDQo+ICAgQWN0dWFs
OiA0Mjk0OTY3Mjk1DQo+IEV4cGVjdGVkOiBvdXRwdXRBdHRyaWJ1dGVzW2ldLnZhbHVlDQo+IFdo
aWNoIGlzOiAwDQo+IC9ob21lL3lpZmFuL2JyYWhtYS9saWJoc2FrbXQvdGVzdHMva2ZkdGVzdC9z
cmMvS0ZEU1ZNUmFuZ2VUZXN0LmNwcDoxNTINCj4gOiBGYWlsdXJlIFZhbHVlIG9mOiBleHBlY3Rl
ZERlZmF1bHRSZXN1bHRzW2ldDQo+ICAgQWN0dWFsOiA0DQo+IEV4cGVjdGVkOiBvdXRwdXRBdHRy
aWJ1dGVzW2ldLnR5cGUNCj4gV2hpY2ggaXM6IDINCj4gWyAgICAgICAgICBdIFNldHRpbmcvR2V0
dGluZyBhdHJyaWJ1dGVzDQo+IFsgIEZBSUxFRCAgXQ0KPg0KPiB0aGUgcm9vdCBjYXVzZSBpcyB0
aGF0IHN2bSB3b3JrIHF1ZXVlIGhhcyBub3QgZmluaXNoZWQgd2hlbiANCj4gc3ZtX3JhbmdlX2dl
dF9hdHRyIGlzIGNhbGxlZCwgdGh1cyBzb21lIGdhcmJhZ2Ugc3ZtIGludGVydmFsIHRyZWUgZGF0
YSANCj4gbWFrZSBzdm1fcmFuZ2VfZ2V0X2F0dHIgZ2V0IHdyb25nIHJlc3VsdC4gRmx1c2ggd29y
ayBxdWV1ZSBiZWZvcmUgaXRlcmF0ZSBzdm0gaW50ZXJ2YWwgdHJlZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfc3ZtLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2
bS5jDQo+IGluZGV4IGY4MTFhM2EyNGNkMi4uMTkyZTk0MDFiZWQ1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+IEBAIC0zMDcyLDYgKzMwNzIsOSBAQCBzdm1fcmFu
Z2VfZ2V0X2F0dHIoc3RydWN0IGtmZF9wcm9jZXNzICpwLCB1aW50NjRfdCBzdGFydCwgdWludDY0
X3Qgc2l6ZSwNCj4gIAlwcl9kZWJ1Zygic3ZtcyAweCVwIFsweCVsbHggMHglbGx4XSBuYXR0ciAw
eCV4XG4iLCAmcC0+c3Ztcywgc3RhcnQsDQo+ICAJCSBzdGFydCArIHNpemUgLSAxLCBuYXR0cik7
DQo+ICANCj4gKwkvKiBmbHVzaCBwZW5kaW5nIGRlZmVycmVkIHdvcmsgKi8NCj4gKwlmbHVzaF93
b3JrKCZwLT5zdm1zLmRlZmVycmVkX2xpc3Rfd29yayk7DQo+ICsNCg0KVGhlcmUgaXMgc3RpbGwg
YSByYWNlIGNvbmRpdGlvbiBoZXJlLiBNb3JlIHdvcmsgY2FuIGJlIGFkZGVkIHRvIHRoZSBkZWZl
cnJlZF9saXN0X3dvcmsgYWZ0ZXIgdGhlIGZsdXNoIGNhbGwuDQoNCldvcmsgZ2V0cyBhZGRlZCB0
byB0aGUgZGVmZXJyZWRfbGlzdCBhc3luY2hyb25vdXNseSwgZm9yIGV4YW1wbGUgaW4gTU1VIG5v
dGlmaWVycy4gVHJ5aW5nIHRvIHN5bmNocm9uaXplIHdpdGggYXN5bmNocm9ub3VzIGV2ZW50cyBp
cyBpbmhlcmVudGx5IHByb2JsZW1hdGljLiBJdCBhcHBlYXJzIHRoYXQgdGhlIHRlc3QgaXMgbWFr
aW5nIHNvbWUgYXNzdW1wdGlvbnMgYWJvdXQgdGhpbmdzIGhhcHBlbmluZyBhc3luY2hyb25vdXNs
eSAocGFnZSBmYXVsdHMgb3IgTU1VIG5vdGlmaWVycykgYW5kIHRoYXQncyBwcm9iYWJseSBhIHBy
b2JsZW0gd2l0aCB0aGUgdGVzdCwgbm90IHdpdGggdGhlIGRyaXZlci4NCg0KQWx0ZXJuYXRpdmVs
eSwgdGhlcmUgbWF5IGJlIGEgcHJvYmxlbSB3aXRoIGEgc2V0LWF0dHJpYnV0ZSBjYWxsIHRoYXQg
bGVhdmVzIHNvbWUgb3BlcmF0aW9ucyBvbiB0aGUgZGVmZXJyZWQgbGlzdCBhbmQgcmVzdWx0cyBp
biB1bmV4cGVjdGVkIGdldC1hdHRyaWJ1dGUgcmVzdWx0cy4gSWYgdGhhdCdzIHRoZSBwcm9ibGVt
LCB3ZSBtYXkgbmVlZCB0byBhZGQgYSBmbHVzaC1jYWxsIHRvIHRoZSBlbmQgb2YgdGhlIHNldC1h
dHRyaWJ1dGVzIGZ1bmN0aW9uLg0KDQpDYW4geW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzIGFib3V0
IHRoZSBleGFjdCBzZXF1ZW5jZSBvZiBzZXQtYXR0cmlidXRlIGFuZCBnZXQtYXR0cmlidXRlIGNh
bGxzIHRoYXQgaXMgY2F1c2luZyB0aGUgcHJvYmxlbT8NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoN
Cg0KPiAgCW1tYXBfcmVhZF9sb2NrKG1tKTsNCj4gIAlyID0gc3ZtX3JhbmdlX2lzX3ZhbGlkKHAs
IHN0YXJ0LCBzaXplKTsNCj4gIAltbWFwX3JlYWRfdW5sb2NrKG1tKTsNCg==
