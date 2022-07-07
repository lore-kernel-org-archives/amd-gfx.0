Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9162DC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 03:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3C510F1F3;
	Thu,  7 Jul 2022 03:40:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD2210F1F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 03:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpuG3pLgqrBBjNlBWraJkiEpqiYWG4FpTntxGxHhpqPSdssjwC40dk/3rxcEPH/edNInZwz5/7bu/JC6MvBNY5W49RzOVgo4nXrD0B3/gKJXXieAjm+7gA77DAYCXg5dl6HzKO+1o0kgn9BCRqS5eMu8epYycP8sPQxCvtBvrJ2+GWNghAAuMEygbx5qmOsQXc4EBSY4BvIyZI9ru8Yu1W/IfyKB0r3l1fbfxJLqBzknGUVISTdNTjhQOqbwptMSPQqrCz9su6aHryGEcH4+cb3LzdsMwPWF10SAq4WA4pWifabMjS1PHkoLhdaFaV9NPKhPrx15B4yGP9goTnvglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js8kjg/cPUF3Ov+4lDYz2vvybVGBf9xhQB5Kmy0xphs=;
 b=aA8vb+ANQAZV9P6lpKuD1ctlC9/fqGdQIwfMiUZmMJAP2fVJDzgEBh8U9nVeVYedwPoc6ffPBqPi5/zF4T6eZe+v6bKLqwtFbsZkFF1PtiIh5i40QGt3k1NiQzN4Wi5zgL8VkgOcKb+6IY6oGF2Oiet085sUrhGC3IcjuYK7I16WQVOKVcyF52gNW8OTdhzF2sDXjqsx9BjsxP1F+5LVmVxeCa2JFnhT7V8k8I2E8i95O810NDRjbgTV2bPQX6LXQY/1Yp1n2nOeqjVGq1UQhR/FUgja4gnTsiAG/WQwJT23AcH93/A5OhbtGnZpTLEbzEb3v+J5/T3SfHB28uOcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js8kjg/cPUF3Ov+4lDYz2vvybVGBf9xhQB5Kmy0xphs=;
 b=024nN+fEuVosGh3TfaA+fzHu3OF8sWWBiQMRJ0na7BSW5BWNV6iM0VCGPIfMwY0feO4uJ24ln6QZFvWYR3bWuJUXV3opdCwTj+Tpr1uchwmOOfjOJjISp14MXXBNY0Iyp4QDU01RJJqv/z4gkdWMVC4bHd7wcOZboNsGsFUcGUU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Thu, 7 Jul 2022 03:39:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 03:39:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/display: correct idle_power_optimizations
 disablement return value
Thread-Topic: [PATCH] drm/amd/display: correct idle_power_optimizations
 disablement return value
Thread-Index: AQHYkauwecA4PW9APUOKvTi7G3veZ61yOFSAgAAKnMA=
Date: Thu, 7 Jul 2022 03:39:58 +0000
Message-ID: <DM6PR12MB26195907A5FEFF1BB4D00138E4839@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220707024531.90263-1-evan.quan@amd.com>
 <CADnq5_Mv2iwJK2035-8dU6-7jhZpyAFsrK5veK5coUpZRuRXFw@mail.gmail.com>
In-Reply-To: <CADnq5_Mv2iwJK2035-8dU6-7jhZpyAFsrK5veK5coUpZRuRXFw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-07T03:39:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=000bd99f-7933-4f07-a415-cb2bbb1560e5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a3a498-c1ac-4e59-95d9-08da5fca5d6b
x-ms-traffictypediagnostic: DS7PR12MB6096:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qMWjzabA6IMHwgxOP6Yqq6WRjA6diaX/qRRylxZYRHIQbGRuziIGEwGpHOYlHQIcE5iuefaTgKFOl7S3y6Hq9PyW4evPu6e3VFkSq3idyf6q18Ho6ivdH5O6omwtrsRXZEcVkADNFYad20JieLOFmBWuBviF9U4cSRD39qyPCDTXMFcigBp3RkQ/KWcwHwzoQTAZ4wFHFyDWi4c3CTuiY9swD4wnMx5Y9o6r7dOG0gbhoBUv7gSJZGEObLhrVkLwOvmpc1qRgGoxEoBQKiUU4xvJEI7a4KZn/r2ETBf+E8zYDicMHlcQtOvNSm/CzuVhLKMGj9wolXNj7hAPOnpKLfeooJuE7AWEUBZtscF8pLh6/236zhXBt1HhjbIjYoCyqsysZdVROm2ExSOXlHbOKovLoF2orDtUCmJrZlW/sN7bql7O8PKfjdPSVCE6Atn4e3OmvcOcY47s5LhDI6liiu7eUs9g4TX0hH7lbKsOwZCe/tyYKdvLuxXGoBTcxy15zaCiyCSYDGWSVEsM0v8VoKLlYeoG5FRLZ/H05ISJwbN2UbSkek4jzgYlioKeMYxhFXR22Gs8vAK7L6+tSUUwmjNH9qH4EtWH7VdaK+Q/5bJMjvd18ld4KtnVBGFjCkN9q6zScStABioUGXG08LxS9lEQBJusrZMfpWL1p3NTTC930gr838pZYD3/S47xYZPM+A1B/ih+9ruMpVUnPQUC9yi7LDu/uXKqLFXZwxHf9id1fXxLTQ5XthAZd7eiFeg2u6/oHZ8n8foEuG/3ofvAW/JbqhtXJcZ60QexFJIrYfz0OuLzEEEjp+SblRwwfTZa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(86362001)(41300700001)(26005)(2906002)(6506007)(9686003)(53546011)(7696005)(52536014)(478600001)(8936002)(5660300002)(33656002)(38070700005)(122000001)(83380400001)(186003)(55016003)(38100700002)(64756008)(71200400001)(8676002)(316002)(4326008)(66446008)(76116006)(6916009)(66946007)(54906003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVQKzJvQWJ6dEVBS3JMcGxjdVBrVGQyelhFOU5KcUFjN0Njd1NuTDRkZ3JO?=
 =?utf-8?B?UUpwb1FIaEhkOVFZcnNnQlBsTU54R1dsbjFaYjZwai9HYWp1SXU2RjNGTEJV?=
 =?utf-8?B?VFhkN0tHUmd6TEl0d3BPYW00eGxlSG13NmxuK2QvbGIwN2Noa1JMTVY2WkFt?=
 =?utf-8?B?V2g2R0xsT2pDc0w1WlRGb1JLS0ZxK01iRURVZUhlWC9lcll4eEhPZ0FFVS84?=
 =?utf-8?B?QjM1K2g2a3o0b1FDaTFCM0t6Ujk0SFZrMUhuMWswMUpINTIvZXUzMDVpY1hN?=
 =?utf-8?B?UzNUOTE2S3BBV1N3TlZtTEN3cG5xR1ZXSDN0Q2R3YjRqTkpFQWVTR1ROdWhw?=
 =?utf-8?B?cnFvMlVyZTM4dHY5NTNiQzJDMTU3K3MwaHZVZVFFV0g4WTBBdHB0cWFKaysx?=
 =?utf-8?B?dWhYRk1qNDZjUWQ5NkgreXVHa3U0RTV6QU9WNGJhNjhoVjVPNUoxcm1od0pT?=
 =?utf-8?B?RkVDMmd4THB6dnVHd2c4a0Yzb0hMZmY4RnVvV1BrUGtNQWZ6SElmZVdUcDhF?=
 =?utf-8?B?R0V6UWVMSzRBL0F4NGgxM2w2bjdLcm05N1VkWHRTZXNHNENNOHFBbWo2c2Mv?=
 =?utf-8?B?Ky9zQWx3R0hRK1pXZ1dUZTZKRENCYm1zVWVRM0hyaG56dGc0NHNXeHljTDlI?=
 =?utf-8?B?dndHNzJ6YzBmOHlOVGs0TzMvaGZuajNmR3pxT2lzc2NJNWFmNFFaK1dTWENS?=
 =?utf-8?B?bkUwc1hLNkxhcGNGT28yR3VqTGhWcDdsRkttZjFxSWV0cTluT1p4bXpKN3ZH?=
 =?utf-8?B?Qk93L296K0ljUlp6YW1VQlVRczNkTFgvakJrNEdWQ1ZNK1V6VUJia09UL1lk?=
 =?utf-8?B?N3J5TnBNM2dzS1RPS09ZM2tRL25wMExRVmRaczdmTzNoTW1aMjdpOG0ySjZN?=
 =?utf-8?B?NS9WUkhZMzhqd3VoSy82Z3ZJTnFHczRZaXZoY3lxZXQwR0ZIa3prTWtWb1JW?=
 =?utf-8?B?SStTYlhGbDUxRUNDTlVKQXFtdTJmbFJ2dXhqZWhFYUFyYldpOGlpSFVJR3Q1?=
 =?utf-8?B?WWhHak52VUlIdlNPTG9BRVJqKzNBUnlianZ3WTB0blZHSTNtUEM2cFR2ZlFr?=
 =?utf-8?B?eGovR0U5YUtZSFJWYy9TelpGdE1FV094dFlVUjFkVEVTYnVpRVNnR2lLVGQ3?=
 =?utf-8?B?WTRzek1QSXJSV0FodWNZWjE4eWdrVUNyNVRtb283NFZqNkVMV2Zha1piMnpv?=
 =?utf-8?B?VDREa1RMY21DWmprejlXVDJTRG5CQzh0N0ZQZzZpYVRNY09OdDVmdXRDMHN3?=
 =?utf-8?B?L0RlNE1ITWp1QTgyQjVHZUZnVVZwZ0ZoYzRZRnFzbWdvNFhYMlozbXk1L09G?=
 =?utf-8?B?T05RL1dlQzdZcFZ4NjNDWUk0OXZnUGcxekV3MmlhbE5hZXdPQlFOVHhkUUkx?=
 =?utf-8?B?azhMd0JSb05zUHh4WVNTUVpFR3liNEwrMkp5eTI4a2VIRUl5Nk5TYml5TzZS?=
 =?utf-8?B?ZUpPYnQ0TEZpemVVSExZNDF2NmZUNktnbkVlNzhrTnI5NXpSeTZ3ZmV5Q0VI?=
 =?utf-8?B?VVFLTmd1UzdsVzUzMFE2QWFyYmpjcUtlam1PZm5LcG93a0lycDc3NmhHS0dF?=
 =?utf-8?B?ZlZXZjhWWVdqc2hZSUFEbnVuVzBhTmFDMkpPUXFyaGs1TkVFRkVtNnQ0R2N0?=
 =?utf-8?B?cDdhMVJ5OHY1TGxsWThuRHljSUprNlpJVDhiS1p4NUNEUjdRREM3dW5YQjJB?=
 =?utf-8?B?Ymh2anR4b3grM0JuRFZsSU9FRzdrcHVKTlB6aGY3cC9oQmZkR2pzQkduNDZY?=
 =?utf-8?B?U1haNFNhSzFYZGs4NWtnTDlJeEVFQkJCTTB1eENNU3IwT1lxSlpSRlB5QW5S?=
 =?utf-8?B?OW1wOFM2VWQ5S2FmWkduTjJad3dEaWJCWmVUVm1GbytMdmt6TXZtczZrcFc5?=
 =?utf-8?B?S0xPZWc0OUFlWFM5ZmI2K2VrM0M4ZnhrWWViWlBqeE52aFNUOTFIQVI1Nmhl?=
 =?utf-8?B?eC9Md1E5STRMRnVWdWJ4Z29uS1BMSmJrUEhmS0haN0dPeUxWYUhUNUtUQWVa?=
 =?utf-8?B?L1QrcnY3NlFGMkRteDhXZHNlZzRJWGJTdWxOYnMwbFU2aTVZMXQ3bWRaak1r?=
 =?utf-8?B?WFRjalN0M2FUcWFDbmlnVitneWhWY1JQSnpwaWNkRjA2NktwWGVkSEJSYTRY?=
 =?utf-8?Q?7FYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a3a498-c1ac-4e59-95d9-08da5fca5d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 03:39:58.1398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OsEtxMEIrS2z5deo369bT/k7XZiFK3aShsj8Rauzu/N5PhAnUxeeytA0E0liWaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "for 3.8" <Stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSA3LCAyMDIyIDExOjAxIEFNDQo+IFRvOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBQaWxsYWksIEF1cmFiaW5kbw0KPiA8QXVyYWJpbmRvLlBpbGxhaUBhbWQu
Y29tPjsgZm9yIDMuOCA8U3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBjb3JyZWN0IGlkbGVfcG93ZXJfb3B0aW1pemF0aW9ucw0K
PiBkaXNhYmxlbWVudCByZXR1cm4gdmFsdWUNCj4gDQo+IE9uIFdlZCwgSnVsIDYsIDIwMjIgYXQg
MTA6NDYgUE0gRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBb
V2h5XQ0KPiA+IFRoZSByZXR1cm4gdmFsdWUgaW5kaWNhdGVzIHdoZXRoZXIgdGhlIG9wZXJhdGlv
bihkaXNhYmxlL2VuYWJsZSkNCj4gPiBzdWNjZWVkZWQgb3Igbm90LiBUaGUgZXhpc3RpbmcgbG9n
aWMgcmVwb3J0cyB3cm9uZyByZXN1bHQgZXZlbiBpZiB0aGUNCj4gPiBkaXNhYmxlbWVudCB3YXMg
cGVyZm9ybWVkIHN1Y2Nlc3NmdWxseS4gVGhhdCB3aWxsIG1ha2Ugc3VjY2VlZGluZw0KPiA+IHJl
ZW5hYmxlbWVudCBhYmFuZG9uZWQgYXMgZGMtPmlkbGVfb3B0aW1pemF0aW9uc19hbGxvd2VkIGlz
IGFsd2F5cw0KPiB0cnVlLg0KPiA+DQo+ID4gW0hvd10NCj4gPiBDb3JyZWN0IHRoZSByZXR1cm4g
dmFsdWUgdG8gcmVmbGVjdCB0aGUgcmVhbCByZXN1bHQgb2YgZGlzYWJsZW1lbnQuDQo+ID4NCj4g
PiBGaXhlczogZTQwZmNkNGEgKCJkcm0vYW1kL2Rpc3BsYXk6IGFkZCBEQ04zMi8zMjEgc3BlY2lm
aWMgZmlsZXMgZm9yDQo+ID4gRGlzcGxheSBDb3JlIikNCj4gDQo+IE5lZWQgMTIgcGxhY2VzIGZv
ciB0aGUgZ2l0IGhhc2g6DQo+IEZpeGVzOiAyMzVjNjc2MzQyMzAgKCJkcm0vYW1kL2Rpc3BsYXk6
IGFkZCBEQ04zMi8zMjEgc3BlY2lmaWMgZmlsZXMgZm9yDQo+IERpc3BsYXkgQ29yZSIpDQo+IA0K
PiA+IENjOiA8U3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gDQo+IFRoaXMgZG9lc24ndCBuZWVk
IHRvIGdvIHRvIHN0YWJsZS4gIFRoZXNlIGNoYW5nZXMgYXJlIHF1ZXVlZCB1cCBmb3IgNS4yMC4N
ClRoYW5rcy4gRml4ZWQgaW4gVjIuDQoNCkV2YW4NCj4gDQo+IFBhdGNoIGlzOg0KPiBBY2tlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IENoYW5nZS1JZDog
SWY4N2Q0Y2Y3NmY2Y2ZiMzZkNjA3ZjA1MWZmMzJmOWM3ODcwYjRkNmQNCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMyL2RjbjMyX2h3c2VxLmMgfCAyICst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMi9k
Y24zMl9od3NlcS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzIv
ZGNuMzJfaHdzZXEuYw0KPiA+IGluZGV4IGQ1M2NiZmVmMzU1OC4uMWFjZDc0ZmE0ZTU1IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMi9kY24zMl9o
d3NlcS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMyL2Rj
bjMyX2h3c2VxLmMNCj4gPiBAQCAtMzczLDcgKzM3Myw3IEBAIGJvb2wgZGNuMzJfYXBwbHlfaWRs
ZV9wb3dlcl9vcHRpbWl6YXRpb25zKHN0cnVjdA0KPiBkYyAqZGMsIGJvb2wgZW5hYmxlKQ0KPiA+
ICAgICAgICAgZGNfZG11Yl9zcnZfY21kX2V4ZWN1dGUoZGMtPmN0eC0+ZG11Yl9zcnYpOw0KPiA+
ICAgICAgICAgZGNfZG11Yl9zcnZfd2FpdF9pZGxlKGRjLT5jdHgtPmRtdWJfc3J2KTsNCj4gPg0K
PiA+IC0gICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgICAgcmV0dXJuIHRydWU7DQo+ID4g
IH0NCj4gPg0KPiA+ICAvKiBTZW5kIERNQ1VCIG1lc3NhZ2Ugd2l0aCBTdWJWUCBwaXBlIGluZm8N
Cj4gPiAtLQ0KPiA+IDIuMjkuMA0KPiA+DQo=
