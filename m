Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427D5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C610110E1DE;
	Mon, 28 Mar 2022 08:04:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA43110E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwv/rlkuT+DFmdldWAxRr/Nv4PqiyXdTQg8LwH/HUo8XtJ/y3nSFSXGHIV7Wv6mynY8GPRv/xcxdrLqPvP6yUqToK8OkmI0mf3gZ97w1Lg00Jvw/DHsbZstPL8yChzroMYRPf43AKym4bfC7D1lqgQyMyuX74jZYwMvFgRu8z0BVV0Wc5xWRw0Ie820hNN740IOMrViTfBiyW8mGkuVPKSBOt/e59ZWa9F3yiIDCoCXPaPIhkrZnRHGSd5IyoyyxAyYuPIYr/5pEk1CXKd5pKhGLAPSEYE9eEw+HT6+4fCJyPP1lrcaCi0/mX/BpxP18sOLyxD2sHQIoHPdIeYO0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HLL9P9YDJsKAP9+0MKA7yxZNMxEAh4NZ1ZfXce1JoE=;
 b=hOdDSTE4zN1fHOivm1rp0t147LEjBkxoFvqjmof2xHlNLmRNEZX84r/uKeSuwcCZr5VsQeaxUGGh429xiKgY83HUGHUTHrk9Ux8LQO2+5GnRvCb5vqO/5p3qP3F6Zb3MYYYck6WOkgag9Q9xzKgdTxZGeGUeK/rbWlcfBc+/Fw72WvmguOUjU0Zj5Bm6AeiTiJXgXsjLLyC6erAIQ7PGyY/YotWyex5oMHEdwkJxIP5+aEapPjyzEGUfgcq9uG6NR0q3GEQ0vp5/2A5Sb4dIGRItwCUrIzoCG2jNfkDQJMBFKY8cednYJrtr1bg5r/2WmbRFqkrvm3y8ICCeA8klDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HLL9P9YDJsKAP9+0MKA7yxZNMxEAh4NZ1ZfXce1JoE=;
 b=2SS+IoJVQgLkMTiFheBUMoUliw151p01nJFYsCOjq3O3DuSOKIyfXAqtO9cf/jqFDweVAYfLfo3oLPo481usYSZN5aXv/b1l5ga6k040VFHPiLdTlX6frh05VAmZ/ksZTY6ski4ifMtJSqWP+O0EdAGJFRTloNwv1498lMdkCAM=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 08:04:00 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:04:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Thread-Topic: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Thread-Index: AQHYQmyV3Dc2TFu1UEmyCd5FJIW3y6zUWEkAgAAFUICAABHDIA==
Date: Mon, 28 Mar 2022 08:03:59 +0000
Message-ID: <DM5PR12MB1770FD01099D88F440CA5C1EB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <c79c62f0-ec5f-4b5b-731c-96eb50dc7197@molgen.mpg.de>
 <PH0PR12MB54519A65963A95706FC3A2D5981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54519A65963A95706FC3A2D5981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T08:03:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1c4c4a18-ede4-43fc-a7cd-774857f4f7f2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 885c9fea-39a1-4aa8-f5d8-08da10918433
x-ms-traffictypediagnostic: MN2PR12MB4535:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4535A0C7677A0EFDA33C5D5EB01D9@MN2PR12MB4535.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bva6OMbP7uBfJLvrDuCmYhcdhFtL1z7vAxi1GDwNdBOEOJ/a/j1P5JTZ/X6KC+qPPrDGoHl6mdsh101DeMWux97JKOmK5E4JJ2BiNz1Wis2wsiyunw5E22BUljz7i0w0j2lZ9IIHIMma5TEFRmJAiblRVd8rGE28G67mv8ENUeYMJYKQu8YiVcVOT0TpnHDLtuRl5+LHH+lCxwdXHsH/ZcIPfqM0XLXWzRBDfGDrxS3NbrlHNd+1DvHXvgUC85N7qKy4ASkdwxlbWJ8oiYNG9X9mH3eAP0PYymtyRBP/2qsTu5Fidt+6/ja4P1au7ozAZe2eIuCNPVesmSGBPQsyFCH6rHHeXjVgDz9/PStWcv37jIbdkwImoTYIHnVgOKIzJ05l0xRElwClppPvTDUZi0zBUNfqRsz3+NSeO19fgBfZq7FPBYwJxSoMbMdTXHxPUVJuIchQgbKQIAGksqbWlkK8BeeyiI650s9G8Pl86niOBSsIUr8xodtbRkOSV2gkM9AkFfBZqgUTsrdpyd+ANduSxKwEGVJNuvU1Cw/QnWTYTali59Zjod/SbQqk5XgnRHXubCwOjMSAs6mv9Miu9S/GYMJaizmDHyRtyZFLl+4qptcczpp9yYXkanINXl5XegJgCwfxgihJjxvd43qOUgVlNoIH5FRRoibaDV2+xfv5NUmW0CLOqzZSeZ6nsT3l/XYiNP+m07XA/uaNshDUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66946007)(76116006)(26005)(186003)(5660300002)(71200400001)(86362001)(508600001)(7696005)(54906003)(122000001)(6506007)(8936002)(110136005)(55016003)(2906002)(316002)(52536014)(38100700002)(53546011)(9686003)(38070700005)(33656002)(66556008)(64756008)(66446008)(4326008)(66476007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzV3ekR3cjc4TGNzdy9zbGhKcVM2YUxGcmx3WW10Qitha3VQRktHSGNaZWpI?=
 =?utf-8?B?d20vaTZ5dUNXWjNBdXVmeEZabWZtdTRpR3Z6WHhONGpLV2w5b0Izc1FiUjI1?=
 =?utf-8?B?RTkzd3VXalhNdlk3d1dZWFlmU0RXRmd4Sm4zL3RaSExoMXZyUmljVk82S1g2?=
 =?utf-8?B?NEYyQXQxaE9UUmp6SDJKaTdwS1FNWWxnUVZZdjNLcFZxKzBxYkpMM2lOQXAw?=
 =?utf-8?B?Z3NTbXJOYTkrSDl0cWY4Rkw0OWFtUFhWOC91VkZ5UVhPSEVlTExYTnE0TGg0?=
 =?utf-8?B?NllUTm1rdVBtNjc5NVoybWgxUDVQKzNDQWtiMTZCYUdEKy9nVk05RktnYkxN?=
 =?utf-8?B?THdVYTJaYzVlYU1TcjVQQlNuQVVVeVNlV1RmUG5iaVUwTnNVVGJ1TDV5RVpT?=
 =?utf-8?B?b3lqaFJsQ0tKOTh5bEdJNlg2M0VTMUE1djRMd0k5MUxYaElrb2xpQmxNT3kr?=
 =?utf-8?B?SkZ5M0tjdTVNVDBmNmpyZ25FVUNtR3cyWklPR0Z6WklydDdRdk1UTWJ3VlQ5?=
 =?utf-8?B?dVpFWDM0YnVOYUdVVUFlUDRBOTJXVHlLM2o4QVhjU3ZYY0hLQkxLS2FxN0N4?=
 =?utf-8?B?MnF2VWoxY1JLTXVDUzJ4Q0l2YUh1MzEyMHZ4OTdCM1N6d3VXTXhZWURRMXRJ?=
 =?utf-8?B?RUtUdmJHTDJTQ0R4QmN6THMvM3paVUFVMjVnZVlTb3ZHQVB2MG16bGsyQVo2?=
 =?utf-8?B?SnRwdFQ2UHBSUUhYTkVhd2IzaEMwd2Rwb3hzTXU2NGVCcjN5NWZJdXBOd2VN?=
 =?utf-8?B?MUhvcDlPdUhVUVZBckZUbzZBMEJGbnNhSkkzM3ZZekNGeVVpeEFrMTZjT2Zk?=
 =?utf-8?B?N2xkZTJhNG9TSGYrODFDUmJGUnhEZnNKdGVvNnYxYUsvMzdha1dtcXlmdEps?=
 =?utf-8?B?Z3l6K2t0bVBid25zRGduUTRaMjNPeEp4ZUZOWXZIVTh6OWpWenFpVWk5L0s2?=
 =?utf-8?B?b2l3YXpuTWNUOThLLzhnbnhIclFNcHBRSllQNkgwQUIwRlJoSFhVL2ppemV4?=
 =?utf-8?B?Qzd3NXZ2SDNueW1hc2NsSVZmcWgvVzdKVmZ3RHlRWTNwUGloZnZPVThHeUV1?=
 =?utf-8?B?U2RlM1lzTTR1RXBtc3VsK0prakZ2c0F3MUJ1VWgzSko4b2YzOW1TQW94U0N1?=
 =?utf-8?B?bVdqS0laYlM5TFc3TEJVb1BZSTQreW91anRFTWFQS2xTcitidVpqZjZ4Ums0?=
 =?utf-8?B?VHNNVlVZeDFyY2Nzd1ZMZnViREtUYXovQ21aM3ZxTkhrMFpkamxNWVJpTFo1?=
 =?utf-8?B?ejJKQ1U5VEp0MmdncWJOL1dua3BoWEg0bDNYeWl5aTRBajFFTld3c2c5d2hr?=
 =?utf-8?B?RlBvVzZEQ1lmdkdOYXhYOWRUTDVkcVEwOGtWQitVU3pxbVM4ZG9IdFJRcnVC?=
 =?utf-8?B?WTY0UUxDMGh6L0xHeEFXcEVpUVBWVGpBc2RzamNKNk5rNHZHNTh0dXNWaXZN?=
 =?utf-8?B?Z3EwekgvNGY3aDRUYlRNM1l0bEV6N0czQ3Z2a1Y5dGhaUkM0YzFQc2VuZC8x?=
 =?utf-8?B?MHVYcGJ2cFlYOExPdVF2cFJWM3Rqb21oZitLOXpoN09uOXdkL3RaMkZjeGJ5?=
 =?utf-8?B?U1g2T3BPR2hoZzkrSnhyMGdIeXN1RkQ5VE9kanBjZDg3ZzU0cnAyK2dRbTht?=
 =?utf-8?B?Q2U4ZGNneHRzaGFaaDQyYisvM2F6c2svV1NYOGUxWXM4Tm1mV3I3aUEyeVIw?=
 =?utf-8?B?M3pCVW5xQnE4aTRoa213SytZUXk0cU15WHlqUERwYlVtTDRBdHl4QWdtaHlI?=
 =?utf-8?B?dXd6dm9nUGVWRTZJcFdPTmNJanhpRWhkbXRQVDdCWjJMRXZQdnV2Sk5xdG5q?=
 =?utf-8?B?ekQ5dWo5ZGFsN3J1NUZVOUp5T3ExcWQ1dHVKeDY5a1I2VTJEazFINGlEYkxX?=
 =?utf-8?B?K1JXWU1pTzJnWGo2eXUvTjc3UDZPYzl6bFhXaGRrNTgwOTFsQUVNemdpOXg0?=
 =?utf-8?B?NHBNS082SUVub2w4WUV0Mi9VUHFObHo3UzdQQTFyVjMxTmtnM2FpK2p2eHBp?=
 =?utf-8?B?SGs4TktLa1JzS09FdDcyN3NJeDN5Wit3OWp6K0dYTVM5ZVNOZEQ3TVdnV2x6?=
 =?utf-8?B?SWUyc2dHNkM5YzBGSTFtMndqZnlSUHBWWWJjSlpmaFNIVUxvOTJST1N2SUkz?=
 =?utf-8?B?Tm82RjRSeGdBSFRSVEFCc2VWK1NVSUpacTgwK01VWE5SdGg0TXpDQXFvU1VN?=
 =?utf-8?B?YW9SL1daalFuNHh1MFdYWDhkY0pITVN1SjdkendZZGxlQndORVRLcHlseitQ?=
 =?utf-8?B?Slp4ZFdrL0oyQVJBZVFrYmJ4QmNXQ2ZsWW9IcmFsK08xTmtuYWxOOU5HejBX?=
 =?utf-8?Q?Vi36t5JzuyDziCNN3t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885c9fea-39a1-4aa8-f5d8-08da10918433
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:03:59.8771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6DROaKD/JeVx+/HdBPfK1UBEC7HPn+PqgGV0lUP1DmfscGFjM+qecXLECyVe9KW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KV2l0aCBQYXVsJ3MgY29tbWVudCBmaXhlZCwgdGhl
IHNlcmllcyBpczoNCg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFppeWEsIE1vaGFtbWFkIHphZmFy
IDxNb2hhbW1hZHphZmFyLlppeWFAYW1kLmNvbT4gDQpTZW50OiBNb25kYXksIE1hcmNoIDI4LCAy
MDIyIDI6NTggUE0NClRvOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1k
LmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCB2NCAwLzZdIFZDTiBh
bmQgSlBFRyBSQVMgcG9pc29uIGRldGVjdGlvbg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0K
DQpEZWFyIFBhdWwsDQoNClRoYW5rIGZvciByZXZpZXcuIA0KQWRkZWQgY29tbWVudCBpbmxpbmUu
DQoNClJlZ2FyZHMsDQpNb2hhbW1hZA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5G
cm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPlNlbnQ6IE1vbmRheSwg
TWFyY2ggMjgsIDIwMjIgMTI6MDkgUE0NCj5UbzogWml5YSwgTW9oYW1tYWQgemFmYXIgPE1vaGFt
bWFkemFmYXIuWml5YUBhbWQuY29tPg0KPkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyANCj5MYXphciwgTGlqbyA8TGlqby5M
YXphckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgDQo+PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNl0gVkNOIGFuZCBKUEVHIFJBUyBwb2lzb24gZGV0
ZWN0aW9uDQo+DQo+RGVhciBNYWhvbW1hZCwNCj4NCj4NCj5BbSAyOC4wMy4yMiB1bSAwODoyNCBz
Y2hyaWViIE1vaGFtbWFkIFphZmFyIFppeWE6DQo+PiBWQ04gYW5kIEpQRUcgUkFTIHBvaXNvbiBk
ZXRlY3Rpb24NCj4NCj5JdOKAmWQgYmUgZ3JlYXQgaWYgeW91IGV4dGVuZGVkIHRoaXMgYSBsaXR0
bGUgYml0LiBFc3BlY2lhbGx5LCBob3cgaXQgY2FuIGJlIHRlc3RlZC4NCg0KW01vaGFtbWFkXTog
VGhpcyBpcyB0aGUgZmlyc3Qgc2VyaWVzIG9mIHRoZSBSQVMgcG9pc29uIGNvbnN1bXB0aW9uIGRl
dGVjdGlvbiBzdXBwb3J0LCB3aGVyZSB0aGlzIHNlcmllcyBvbmx5IGRldGVjdHMgdGhlIHBvaXNv
biBjb25zdW1wdGlvbi4gVGhlIEludGVycnVwdCBmcm9tIFZDTi9KUEVHIGJsb2NrIHdpbGwgYmUg
aW50ZXJjZXB0ZWQgYW5kIGNoZWNrIHRoZSBwb2lzb24gY29uc3VtZWQgYnkgVkNOL0pQRUcgYW5k
IGNyb3NzIGNoZWNrIGl0IGlzIGluZGVlZCB0aGUgdmNuL2pwZWcgcG9pc29uIGNvbnN1bXB0aW9u
IGludGVycnVwdC4NCg0KPg0KPj4gTW9oYW1tYWQgWmFmYXIgWml5YSAoNik6DQo+PiAgICBkcm0v
YW1kZ3B1OiBBZGQgdmNuIGFuZCBqcGVnIHJhcyBzdXBwb3J0IGZsYWcNCj4+ICAgIGRybS9hbWRn
cHUvdmNuOiBBZGQgdmNuIHJhcyBzdXBwb3J0DQo+PiAgICBkcm0vYW1kZ3B1L2pwZWc6IEFkZCBq
cGVnIGJsb2NrIHJhcyBzdXBwb3J0DQo+PiAgICBkcm0vYW1kZ3B1L3ZjbjogdmNuIGFuZCBqcGVn
IHZlciAyLjYgcmFzIHJlZ2lzdGVyIGRlZmluaXRpb24NCj4+ICAgIGRybS9hbWRncHUvdmNuOiBW
Q04gcmFzIGVycm9yIHF1ZXJ5IHN1cHBvcnQNCj4+ICAgIGRybS9hbWRncHUvanBlZzoganBlZyBy
YXMgZXJyb3IgcXVlcnkgc3VwcG9ydA0KPg0KPkl04oCZZCBiZSBncmVhdCBpZiB5b3UgbWFkZSB0
aGUgbGFzdCB0aHJlZSBjb21taXQgbWVzc2FnZSBzdW1tYXJpZXMgYWxzbyANCj5zdGF0ZW1lbnRz
IChieSBhZGRpbmcgYSB2ZXJiIGluIGltcGVyYXRpdmUgbW9vZCkuDQoNCltNb2hhbW1hZF06IFRo
ZSAybmQgbGFzdCBhbmQgbGFzdCBjb21taXQgb25seSBmYWNpbGl0YXRlIHRoZSBmdW5jdGlvbmFs
aXR5IG9mIHRoZSBwb2lzb24gY29uc3VtcHRpb24gZGV0ZWN0aW9uIG9mIHRoZSB2Y24vanBlZyBi
bG9jay4gVGhpcyB3aWxsIGJlIGNhbGxlZCB1bmRlciBJSC9CSCB0byBjaGVjayBpbmRlZWQgaW50
ZXJydXB0IGZyb20gVkNOL0pQRUcgcG9pc29uIGNvbnN1bXB0aW9uLiANClRoZSAzcmQgbGFzdCBj
b21taXRzIG9ubHkgYWRkIHRoZSByZWdpc3RlciBkZWZpbml0aW9uIG5lZWRlZCB0byBmYWNpbGl0
YXRlIHRoZSBmdW5jdGlvbmFsaXR5Lg0KDQo+DQo+DQo+S2luZCByZWdhcmRzLA0KPg0KPlBhdWwN
Cg==
