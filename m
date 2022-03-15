Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E80C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9DD10E4CC;
	Tue, 15 Mar 2022 07:26:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79F910E4CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aroq9RG/QbOaxMSh0yatLNb5cytucdaVOv7xKEgGJ5wow4L02twx4Mvgevwy6aQHz7fxlVGG68sXUazbGtG0AwsxghIuqulmB0eXStZ4se5A4wLYsNTQ16Yh0W82W+8s3Iver7U7gqatScxPSK1gYIYI0PUZRZFVAB7bwKhUDKWqZMzcr/n1vKG51p7J0mUm1TyXagEupiyNQ6ChitDmdL+nLmYmFNLhVWOW5eSp2U4x3+xC2D+receImUvQuUq8v7YiXTb8BAkXaE7y++k5Xg8mXWjycXfeoQ4o5ZGNkpqK3XSMjjxHm5X+NqXd3FkWsSlAToZhaGe8eP4ckKweJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4aPhpetqPbUCyBm9qD4DPprWyq+jdA/epIxt+j7eJQ=;
 b=Qrt1piM0z0rzEkDbZ6YkapLE94yiT5WhkwEh8LjH5R7kUUNkNPEKTaH6mUQrjdTkF4WS7ey+43K8sWqHFGfZBj0/M2lGesjbGlrS7mXAwc82+0Ipd8EqyT75n9GDsb051jRHkhiRcIHf5KwZ0tdmWVWTkkBpccsLeAbK2Hx1kOQKWGkNeFkFcnllteoaHcCY1IANU1tJL0Bd6uxtHyCxjAy1FUD6G4fgoMCOQE9ofEFjZ6JhbayuWSEqcu5lEA6ReTRb0mHxLF0fN7Owmupxrc2EPxmhdH4awdU6sMhXdhMbQtZZmEqlwHG4/73PZ2XFOXBKlQN0LLNqsR7AfgPgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4aPhpetqPbUCyBm9qD4DPprWyq+jdA/epIxt+j7eJQ=;
 b=NUE/JH0ip60tPIu2TBX40b7IicLPmR5XLJ2oQOAsRYSr0ifl++trjAh3cD43TYrdDtGnoenP2rxUfSsGQYgp4Ki9Bl0aMZu5IA1vFeljknLxAAN974M8U/bkJDPUye016qMn/v7/FwCMPC2VLWvztUS9DxFUtd5fQBRvKau5B0o=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 07:26:44 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:26:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gnmh0rVuZ5PUyC0L/FY4MrH6y/N1IAgADR5tA=
Date: Tue, 15 Mar 2022 07:26:43 +0000
Message-ID: <DM5PR12MB1770774B1D6940745C2C35BDB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <e4752fcc-3018-87d8-5053-2a82341e9d09@amd.com>
In-Reply-To: <e4752fcc-3018-87d8-5053-2a82341e9d09@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T07:12:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=03ada35b-3609-47ef-a40a-8d5aad15c741;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T07:26:41Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 1d80b3c8-7b39-4f24-8fac-e96899cd28cc
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40265547-a620-4161-4542-08da06552818
x-ms-traffictypediagnostic: MN2PR12MB4470:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4470C2C92B562589E64AA228B0109@MN2PR12MB4470.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIFDosDmZ7J2g/pxbP4gTNp6C5OqOmdouYJ4Y7GxT8B5GT+fFbNFwDsqzm4iDxfKa7IBHf9ZgvTeEJ5YsSx0okbDraU3K5Xj5q4bN0QGfifHPOVMXNRYVIs5hvS6qgUVrgInwwqOhWyhOjA8r6BOkhzj6GGr+cKXdEJT35W4iMld8L1qR1R4udsWxva+dAiodAycT8Q0wM3rrqYpMY18Gt9L3ARrE8wIQJBbC6UkxuYheFtncOsUYoL7RKZTX4FUsjS0WaIsbqMjaz0UZYjd2ninMrXv7crSYQCLHczM/js1t4Veq+TgpkKnD2kDE/NHYDkbgZj8G3jtbDtF+C+leG54HyPjPDosupf6j9GmOI4/7xGqbZ6Y+UuqWpDvHWYBdRwFDHmRfUBLkBv6Zx3sjYdsC7aWflxtCAy3G2l6585rFu3BBoXWZbCawAKAVi6jDz2d1iV5YNV9kRFljjc8gN/di7pppEM6gbJsy4ghNdYMszZoM4iVoaLHXYum7SG0Q+uDVw124ZDxCHydDEE7TEi9QZvklICSVG05tUUInpF03cj676YcoX2Ls34kJ91pStozlZ/fyFtRsNV0VODGNLZ7ZgQlY+X84egU8A1qR6tjOE703JCRuFT27ZI8XPjKWED3dNx1uRsEws7WcvDmBn4WthCblroUA3XU7arxP6mrDZWbBPnTRgZhy/AYf6DCsB8SC9bkUT1F5K+alxUzjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6506007)(53546011)(7696005)(2906002)(9686003)(71200400001)(508600001)(86362001)(26005)(122000001)(38070700005)(186003)(66446008)(55016003)(5660300002)(52536014)(8936002)(83380400001)(316002)(33656002)(6636002)(110136005)(8676002)(76116006)(66946007)(66556008)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VacCt5M01IYUZETWQyZVNOUU5zYzFINms2Z3ZNMkNzVUJzb3dqb3VlYkky?=
 =?utf-8?B?bWM2SVBCVHVvYTF2ckpuRW5DTFZGYS8xaDltRVlFd3lwZU13RjgydXNzSWJz?=
 =?utf-8?B?aGFkVGE1UFRJaUo1a2F3NDFhUlEvME80ZWw1anIxR2dUSnJCSnIyTzdjQy9Q?=
 =?utf-8?B?clRyY2JSVll0eEFjTnZ5YVNnN2VVQVFDamRiamlXMklhaGhueStZQmhDQlNQ?=
 =?utf-8?B?SFpUaVAvdG50T2Fmbm5pVlU1a1V1TWhveUN5U1pIMUgxTTM1eFFmRTNIeWpF?=
 =?utf-8?B?eThQeFdhRlVmSVRIcW11S3MzRXdySGk0aVhCemRmdWxYOXFWemN1TVppaHZm?=
 =?utf-8?B?QmNaL3FiMW4zK2ZIaGJSRG5oRWd1RDlZamkvc0pqdHRXeUxMYWdFbStiUG93?=
 =?utf-8?B?NTA5bDRnZmk4Mi9PMmJFRjN6cXhPeVlPdnJDeE5XMTlackh0RUxaRDh3YTNY?=
 =?utf-8?B?NWNoamdjQWZFZUZhdktnVWxyRS9Eamd6WWpXZVY0NWVLWFBWUFVuNFpOMU1a?=
 =?utf-8?B?ZDhUamxDUlZOTDdQTUdXWk5UWTExOFhqUWZGQ2x0U0tHQkRXTlZTeWRqanQ4?=
 =?utf-8?B?eWladjdWbzVsQThVYXhBYnptU1p6dnFzRC8yWlpoRkh2dzNySitJcnpjL2lo?=
 =?utf-8?B?QndtdENmODV6N0dWVyt4SjZ0Q3lLYUJPZDdmUnd5aG9wNG1DSkdWck03SzJp?=
 =?utf-8?B?Vk1UMGx1QXRrYWVvamFCN25BY3d3TlNIZ1dZQ0ZNckhtMENXaDVvTGtNQ0Fh?=
 =?utf-8?B?OTgxWENUN3JncVoyT3lFeVJ3OFlDNHpKaGlnTDgxK0JsRmdGcGRFWDNzdWJx?=
 =?utf-8?B?S3dWbzdWc25WQktpMFFvbnlMTGg4S2puQ0FJRlp3NTlnOHJRa0pqUkhXZDNz?=
 =?utf-8?B?d3F3SG1zSUJZNTRpOW55aVhMZWRnWW04WVVYSmRSRlFvTnpTYmlLc2wwVGtx?=
 =?utf-8?B?TEtCODV1NE15dzhiV0ZjQVZ6dHJwOGM5bmpPR1VyUWIycUZQMlRWaXRFMU15?=
 =?utf-8?B?K3NRYnltT25kblRzWElpMHZGc24rdFdTakE3ditYNU1uYW5Eclp6WmZmTUt6?=
 =?utf-8?B?NTFGQytqMG5WcE9LRDdaL2JEb3l4WmZqc1NZZnkzaHN5R1VBTEFUN3dveU1Q?=
 =?utf-8?B?QTF2NDMyb3lCNTFFajIxaXp4MHQ2SnJWalRCMk1VSGdhMG1WVW45ZXhoeFM3?=
 =?utf-8?B?YkYyYXMyQWJIQW01ZThUNk9CWThZRHp4NVdkMThhYk5xbkxzZUNOMzQvRWxP?=
 =?utf-8?B?VER1TkhraVZRYWxCQUhyeThPYlVJUFpndW9JaDByRlZUaG4yRXRxMmtjNkkz?=
 =?utf-8?B?dHQxZUJ1Q3dhOVNzN2UvMkg3Vjh1cWJZQXFRaThuRnlWcndMOEVtNDNsM0JM?=
 =?utf-8?B?T05Dd1Nyek1BaUdqSkVlOXYvdWUrVzk4SDNnNVRoN21OekNUNUdISzh1RTZ5?=
 =?utf-8?B?eitPbVdwcFB1TFhlR0hkVDZoYVd2ZGpqVkQrY2ZDVFEyc1MwcGNDYkNUTFJW?=
 =?utf-8?B?Zi85UC92cWE4dU55bGJuOVNlWDlmbUt5Z2RGRkJCalliNmFHcmx4azNxSzMr?=
 =?utf-8?B?L1ZsakxNaVd6bm1qdXpacmFvSGVGSW9zUkJpZUZ4WjF0UloxK3M2T1doeno5?=
 =?utf-8?B?MCtBenRzWFEyN203bVgrWG4zZG54QnBxZUVEREhOTGJnTDJrNTU2Z0hDZUlo?=
 =?utf-8?B?S2FWNUxZTTZUZjhpRXBrWDBQKzZISkQzKzVEZ0EzOEZMS0tpR2w0RStsYVIx?=
 =?utf-8?B?NFFuYksyVWdDUzhNa3lFRUswbGxDa3NIV1FFMitqbnhNREtHVlViUGJZNVJ4?=
 =?utf-8?B?cXNvRXY4ZHg2TVVYY05XK2tNN01QekRyck1nb0NzckltaVdBSVd1dXhPalVB?=
 =?utf-8?B?VVNDdWlkUitnK2ZzQW1GeElqN3Z2N3FLMFl4Y21EdDZCa2h2NngvY0ZEbHFY?=
 =?utf-8?Q?dEUOa9x197HjigwxFkQ/GC367DyiYW79?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40265547-a620-4161-4542-08da06552818
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:26:43.9293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHIEFaM63xZhJoQFQT5AQXssoyjpFxMXFKeIW37O/aXHDqqxuBRlbgAt7JCvP35K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBNYXJjaCAxNSwgMjAyMiAyOjQxIEFNDQo+IFRvOiBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywN
Cj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA8U3Rh
bmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1ka2ZkOiBhZGQgUkFTIHBvaXNvbiBjb25z
dW1wdGlvbiBzdXBwb3J0IGZvcg0KPiB1dGNsMg0KPiANCj4gSSdtIG5vdCBzdXJlIEkgdW5kZXJz
dGFuZCB0aGlzIGNoYW5nZS4gSXQgbG9va3MgbGlrZSB5b3Ugd2lsbCBjaGVjayB0aGUgUkFTIHBv
aXNvbg0KPiBzdGF0dXMgb24gZXZlcnkgVVRDTDIgVk0gZmF1bHQ/IElzIHRoYXQgYmVjYXVzZSB0
aGVyZSBpcyBubyBkZWRpY2F0ZWQgaW50ZXJydXB0DQo+IHNvdXJjZSBvciBjbGllbnQgSUQgdG8g
ZGlzdGluZ3Vpc2ggVVRDTDIgcG9pc29uIGNvbnN1bXB0aW9uIGZyb20gVk0gZmF1bHRzPw0KPiAN
Cj4gV2h5IGlzIGtmZF9zaWduYWxfcG9pc29uX2NvbnN1bWVkX2V2ZW50IG5vdCBkb25lIGZvciBV
VENMMiBwb2lzb24NCj4gY29uc3VtcHRpb24/IFRoZSBjb21tZW50IHNheXMsIGJlY2F1c2UgaXQn
cyBzaWduYWxlZCB0byB1c2VyIG1vZGUgYXMgYSBWTQ0KPiBmYXVsdC4gQnV0IGEgVk0gZmF1bHQg
YW5kIGEgcG9pc29uIGNvbnN1bXB0aW9uIGV2ZW50IGFyZSBkaWZmZXJlbnQuDQo+IFlvdSdyZSBi
YXNpY2FsbHkgc2VuZGluZyB0aGUgd3JvbmcgZXZlbnQgdG8gdXNlciBtb2RlLiBNYXliZSBpdCBk
b2Vzbid0IG1ha2UgYQ0KPiBiaWcgZGlmZmVyZW5jZSBpbiBwcmFjdGljZSBhdCB0aGUgbW9tZW50
LiBCdXQgdGhhdCBjb3VsZCBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4NCg0KW1Rhb10geWVzLCBubyBk
ZWRpY2F0ZWQgaW50ZXJydXB0IHNvdXJjZSwgc28gSSBuZWVkIHRvIGNoZWNrIEZFRCBiaXQgaW4g
Vk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMgdG8gZGlzdGluZ3Vpc2ggaXQgZnJvbSBnZW5l
cmFsIFZNIGZhdWx0Lg0KDQpJIGluamVjdCBlcnJvciB0byBQREUxIHRvIHRyaWdnZXIgVVRDTDIg
cG9pc29uIGNvbnN1bXB0aW9uLCBib3RoIGtmZF9zaWduYWxfcG9pc29uX2NvbnN1bWVkX2V2ZW50
IGFuZCBrZmRfc2lnbmFsX3ZtX2ZhdWx0X2V2ZW50IGNhbiBiZSBoYW5kbGVkIGJ5IFJPQ3IgaW4g
bXkgZXhwZXJpbWVudCAoYnVzIGVycm9yIHZzLiBjb3JlZHVtcCBhbmQgQVBQIGNhbiBiZSBraWxs
ZWQpLg0KSSB0aGluayB3ZSBjYW4gdGFrZSBVVENMMiBjb25zdW1wdGlvbiBhcyBhIHNwZWNpYWwg
Vk0gZmF1bHQsIHNvIEkgc2VsZWN0IGtmZF9zaWduYWxfdm1fZmF1bHRfZXZlbnQuIEFueXdheSwg
dGhpcyBjYW4gYmUgZGlzY3Vzc2VkIGZ1cnRoZXJseS4NCg0KPiANCj4gVHdvIG1vcmUgY29tbWVu
dHMgaW5saW5lIC4uLg0KPiANCj4gDQo+IEFtIDIwMjItMDMtMTQgdW0gMDM6MDMgc2NocmllYiBU
YW8gWmhvdToNCj4gPiBEbyBSQVMgcGFnZSByZXRpcmVtZW50IGFuZCB1c2UgZ3B1IHJlc2V0IGFz
IGZhbGxiYWNrIGluIHV0Y2wyIGZhdWx0DQo+ID4gaGFuZGxlci4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMgICB8IDIzICsrKysrKysrKysr
KysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+IGluZGV4IGY3ZGVmMGJmMDczMC4uMzk5MWY3MWQ4NjVi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJv
Y2Vzc192OS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9w
cm9jZXNzX3Y5LmMNCj4gPiBAQCAtOTMsMTEgKzkzLDEyIEBAIGVudW0gU1FfSU5URVJSVVBUX0VS
Uk9SX1RZUEUgew0KPiA+ICAgc3RhdGljIHZvaWQgZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25z
dW1wdGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+ICAgCQkJCWNvbnN0IHVpbnQzMl90ICpp
aF9yaW5nX2VudHJ5KQ0KPiA+ICAgew0KPiA+IC0JdWludDE2X3Qgc291cmNlX2lkLCBwYXNpZDsN
Cj4gPiArCXVpbnQxNl90IHNvdXJjZV9pZCwgY2xpZW50X2lkLCBwYXNpZDsNCj4gPiAgIAlpbnQg
cmV0ID0gLUVJTlZBTDsNCj4gPiAgIAlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnA7DQo+ID4NCj4gPiAg
IAlzb3VyY2VfaWQgPSBTT0MxNV9TT1VSQ0VfSURfRlJPTV9JSF9FTlRSWShpaF9yaW5nX2VudHJ5
KTsNCj4gPiArCWNsaWVudF9pZCA9IFNPQzE1X0NMSUVOVF9JRF9GUk9NX0lIX0VOVFJZKGloX3Jp
bmdfZW50cnkpOw0KPiA+ICAgCXBhc2lkID0gU09DMTVfUEFTSURfRlJPTV9JSF9FTlRSWShpaF9y
aW5nX2VudHJ5KTsNCj4gPg0KPiA+ICAgCXAgPSBrZmRfbG9va3VwX3Byb2Nlc3NfYnlfcGFzaWQo
cGFzaWQpOw0KPiA+IEBAIC0xMTAsNiArMTExLDcgQEAgc3RhdGljIHZvaWQNCj4gZXZlbnRfaW50
ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+ICAgCQly
ZXR1cm47DQo+ID4gICAJfQ0KPiA+DQo+ID4gKwlwcl9kZWJ1ZygiUkFTIHBvaXNvbiBjb25zdW1w
dGlvbiBoYW5kbGluZ1xuIik7DQo+ID4gICAJYXRvbWljX3NldCgmcC0+cG9pc29uLCAxKTsNCj4g
PiAgIAlrZmRfdW5yZWZfcHJvY2VzcyhwKTsNCj4gPg0KPiA+IEBAIC0xMTksMTAgKzEyMSwxNCBA
QCBzdGF0aWMgdm9pZA0KPiBldmVudF9pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uKHN0cnVj
dCBrZmRfZGV2ICpkZXYsDQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCWNhc2UgU09DMTVfSU5UU1JD
X1NETUFfRUNDOg0KPiA+ICAgCWRlZmF1bHQ6DQo+ID4gKwkJaWYgKGNsaWVudF9pZCA9PSBTT0Mx
NV9JSF9DTElFTlRJRF9VVENMMikNCj4gPiArCQkJcmV0ID0ga2ZkX2RxbV9ldmljdF9wYXNpZChk
ZXYtPmRxbSwgcGFzaWQpOw0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCWtm
ZF9zaWduYWxfcG9pc29uX2NvbnN1bWVkX2V2ZW50KGRldiwgcGFzaWQpOw0KPiA+ICsJLyogdXRj
bDIgcGFnZSBmYXVsdCBoYXMgaXRzIG93biB2bSBmYXVsdCBldmVudCAqLw0KPiA+ICsJaWYgKGNs
aWVudF9pZCAhPSBTT0MxNV9JSF9DTElFTlRJRF9VVENMMikNCj4gPiArCQlrZmRfc2lnbmFsX3Bv
aXNvbl9jb25zdW1lZF9ldmVudChkZXYsIHBhc2lkKTsNCj4gPg0KPiA+ICAgCS8qIHJlc2V0dGlu
ZyBxdWV1ZSBwYXNzZXMsIGRvIHBhZ2UgcmV0aXJlbWVudCB3aXRob3V0IGdwdSByZXNldA0KPiA+
ICAgCSAqIHJlc2V0dGluZyBxdWV1ZSBmYWlscywgZmFsbGJhY2sgdG8gZ3B1IHJlc2V0IHNvbHV0
aW9uIEBAIC0zMTQsNw0KPiA+ICszMjAsMTggQEAgc3RhdGljIHZvaWQgZXZlbnRfaW50ZXJydXB0
X3dxX3Y5KHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo+ID4gICAJCWluZm8ucHJvdF93cml0ZSA9IHJp
bmdfaWQgJiAweDIwOw0KPiA+DQo+ID4gICAJCWtmZF9zbWlfZXZlbnRfdXBkYXRlX3ZtZmF1bHQo
ZGV2LCBwYXNpZCk7DQo+ID4gLQkJa2ZkX2RxbV9ldmljdF9wYXNpZChkZXYtPmRxbSwgcGFzaWQp
Ow0KPiA+ICsNCj4gPiArCQlpZiAoY2xpZW50X2lkID09IFNPQzE1X0lIX0NMSUVOVElEX1VUQ0wy
ICYmDQo+ID4gKwkJICAgIGRldi0+a2ZkMmtnZC0+aXNfcmFzX3V0Y2wyX3BvaXNvbiAmJg0KPiA+
ICsJCSAgICBkZXYtPmtmZDJrZ2QtPmlzX3Jhc191dGNsMl9wb2lzb24oZGV2LT5hZGV2LCBjbGll
bnRfaWQpKSB7DQo+ID4gKwkJCWV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24oZGV2
LA0KPiBpaF9yaW5nX2VudHJ5KTsNCj4gPiArDQo+ID4gKwkJCWlmIChkZXYtPmtmZDJrZ2QtPnV0
Y2wyX2ZhdWx0X2NsZWFyKQ0KPiA+ICsJCQkJZGV2LT5rZmQya2dkLT51dGNsMl9mYXVsdF9jbGVh
cihkZXYtPmFkZXYpOw0KPiA+ICsJCX0NCj4gPiArCQllbHNlDQo+IA0KPiBFbHNlIHNob3VsZCBi
ZSBvbiB0aGUgc2FtZSBsaW5lIGFzIH0uIFBsZWFzZSBydW4gY2hlY2twYXRjaC5wbCwgaXQgd291
bGQgY2F0Y2ggdGhpcy4NCj4gSXQncyBhbHNvIGdvb2QgcHJhY3RpY2UgdG8gdXNlIHt9LWJyYWNl
cyBhcm91bmQgdGhlIGVsc2UtYnJhbmNoIGlmIHlvdSBoYXZlDQo+IGJyYWNlcyBhcm91bmQgdGhl
IGlmLWJyYW5jaC4NCg0KW1Rhb10gYWNjZXB0ZWQNCg0KPiANCj4gDQo+ID4gKwkJCWtmZF9kcW1f
ZXZpY3RfcGFzaWQoZGV2LT5kcW0sIHBhc2lkKTsNCj4gPiArDQo+ID4gICAJCWtmZF9zaWduYWxf
dm1fZmF1bHRfZXZlbnQoZGV2LCBwYXNpZCwgJmluZm8pOw0KPiANCj4gSWYgeW91IG1vdmUga2Zk
X3NpZ25hbF92bV9mYXVsdF9ldmVudCBpbnRvIHRoZSBlbHNlLWJyYW5jaCwgeW91IGNhbg0KPiB1
bmNvbmRpdGlvbmFsbHkgc2VuZCB0aGUgY29ycmVjdCBwb2lzb24gY29uc3VtcHRpb24gZXZlbnQg
dG8gdXNlciBtb2RlIGluDQo+IGV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24uDQo+
IA0KPiBSZWdhcmRzLA0KPiAgwqAgRmVsaXgNCj4gDQo+IA0KPiA+ICAgCX0NCj4gPiAgIH0NCg==
