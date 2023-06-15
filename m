Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673B1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 13:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50D310E4FF;
	Thu, 15 Jun 2023 13:56:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5818810E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 13:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha6MEi6La9ZenFpUMca8GcnkRe6vf/aaZbf5hET9xcdFsZ89C2vTwQ2UJgnVLEWPMcSSEXIRX1ps+MXWMmHuLLR/bXL+bcy90t368WkIzL4tA7x/zX0Z+OT9hi6wRYxAQxpc8rwhPxel4vb/xOpdvcM6YVD3msGCSN6VHRoWbMY85pPuHfZ5+yTdLc3uAlSLFH65tCyhJKCiiRQd2H7FvW3Kft/fE2qOtvuA3lRGgXdadKyj/7SeEYOMgypWM//aC6qITg8HOqYHrMshsxoKgoZ2eyHopnJv30AxqWT5CywQfy2t801g+szGHvZI8vf6BPxMkxcYr2VY2bHDdQe6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2HzFofiUYeVA5NPv5CdXh+6W7yGMSG+RFR1EfncDo4=;
 b=aRh9NYhLqqEXnib/r+/gv6SjuzlXRhTLdI21kNXltjKlC0czUSFbq/+uYxNpShUpS73BJmC24McGLMGnXH7PZ4pkNwKp/HT+zYcpRNnZndulbrIzN794vnIT7L7whB/1HXPvfMaDKtUryM8j73NzKXzuOV4vF1f8zD+u+4229pzcJZ579tX8DY9y57wYn9YPjQgr0h26AGD9ltHg1rna+kXlFnfBVOqcvf+t8AmS/CX1RkgNSnYODkYjswGHKMDd4M2EFtMI5KcOu48S8JGWre+YCjjKXv/7K9vIgVuOcTdpJhcug6HpF7mWDET5uAPiuyjjg8YtcUlOzSUcrDPGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2HzFofiUYeVA5NPv5CdXh+6W7yGMSG+RFR1EfncDo4=;
 b=1nt9mXIP1xvfb6OfYz9NgTEeLk5M3/7Baqk+rF9FGe5IeDXoE615PYINQaEHDxU26hz5MoSiEzeg+wu6B+4IMcY1jb+Ic7D6jd4gtoeErFnUpxrabxZk+RJDNk4N1BISGvMvnpkzZc7nv3Ja0XjshiAyZW+u9U58zHKA2RBzDPw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 13:56:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 13:56:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/atomfirmware: fix DDR5 width reporting
Thread-Topic: [PATCH] drm/amdgpu/atomfirmware: fix DDR5 width reporting
Thread-Index: AQHZmV+dNcB8KmcQ50O5QpxdEEf2IK+HvFEAgAQoeICAAAq4kA==
Date: Thu, 15 Jun 2023 13:56:25 +0000
Message-ID: <BN9PR12MB52578D5DC78F676BB98376F1FC5BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230607164604.961913-1-alexander.deucher@amd.com>
 <CADnq5_Nwf_8iqMsFGO9x-PdUbBoUf1RqU4KzqrEKVPdwmkDW2g@mail.gmail.com>
 <CADnq5_MyLN79FEjjVx5tt4REGWwBVV7=4xJ+TnYCXnEGxOjk6A@mail.gmail.com>
In-Reply-To: <CADnq5_MyLN79FEjjVx5tt4REGWwBVV7=4xJ+TnYCXnEGxOjk6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fa07620-01e1-41dc-9ca9-c597d7dbdc47;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T13:56:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6580:EE_
x-ms-office365-filtering-correlation-id: 074ec18d-57a8-4e5c-595a-08db6da84f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0unixbp/tXcAch2ih0fsQtRHdCJN5qyjZ4OLtktoah8BYhcfx6rnRNX3JHsHPitI3M7EIMxvBB75/Wud3zLO6i0rlmGXrvvbXXzIeJCDnCB5DTbB4xQ2Eq2KD6L+75+DKJKCmMGznrANoytCnHjPA8FoJUJpHw5FCVb5kXJFyistZNph78jjioA7JaZ5gzd8ODWqaA1UZ0TwM6/k45wLdWt99oH9gb7xXiBFeOhfFCm2AfEl47CDdl+AzPNE4mX11oLRzOfZQ88zBox3R/0fZ7f9QUYur37yt5+wVwaLkgmdDfmtzX4ZxGx+J87ziEBQ4Btlm0Un/vgJ9C12IhZnPvyklek7ChuZKebRNC/BHlHiZo1vxWP2bweP98HKCESWnHUvaBC0STVaC0m5vQ7LOXoKhbzcWjm0Zl8LrQuVInUbE18BSmtrZtS08MSxSWMTiDt9hL5I0esRFU7+tXaSkxa9C1apHid2qQQ9wc97ifPbbOMitRXdGTPeEemLkpVmoBBys58x0piolm6NNtEY8d4MGZ3PRjWQbdAdnaank1MTHE1OuLsVcRHQSv+/p3a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(7696005)(9686003)(8936002)(26005)(8676002)(41300700001)(478600001)(71200400001)(66446008)(64756008)(38100700002)(4326008)(76116006)(6636002)(66556008)(66476007)(86362001)(66946007)(122000001)(110136005)(38070700005)(33656002)(316002)(53546011)(55016003)(6506007)(52536014)(5660300002)(83380400001)(186003)(966005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1gwb2oza285eTZqQ21Ob1FNMlVWSERhYlArTXZHT2pkRlh6TTFHZVVhcjFz?=
 =?utf-8?B?NlBKUmRpaXFCcUo4QlBYcnl1UE1iTE9QRDZjZElCZGt3R2FJSUNESFlNTDBh?=
 =?utf-8?B?cm00dXJmVE1yK3JkY3JxdU5kRzQzeEtsUFBWdFhUajlVcms2K0RoQUtpa2F0?=
 =?utf-8?B?bmRjWVpIYzBUcjQ3bU1lekdFWEtOSDJ2TllVTFpzclBGRm91KzNjNFNEWFUz?=
 =?utf-8?B?elkzZmVnUWJGNTBxb2pxSHBuRXlxWStSS1BHa1ZOTTVQVWpSMWhvZTNvSUNT?=
 =?utf-8?B?ZldLU2J6eU9ZYmY2STNpYTc3ZE1jMmlMWDhwNWF2NXpvTEhmeDNZUElYVTk2?=
 =?utf-8?B?QkFtbTdjZHNOM2lONjlOd0p2MVlrRHNzeGJOOTYvcmtsWDhZMThPaDRGbDFv?=
 =?utf-8?B?Zk9EN2N5blhXcGFTdmUzQjFWRHBqQzRWWkp0Z1ZBYldaUmRjMmNmc3FPUXVO?=
 =?utf-8?B?L3Q2aDlRb2VxZWFsTEpFWk9pUkFpOVhDdWc2SDVWNk9WcUhBZ284R29EMXV4?=
 =?utf-8?B?bk5LbVVuMnZtb2ptTDVWalEySENlSlZrSS9Ta2F6MC9MSjZ2VmlvbjRvZGNG?=
 =?utf-8?B?Wjh2cjVSZi9EQiswV1MzYWR0MThPVGlyK3JRakpTQlhRYmxFUExZRGlsRWNM?=
 =?utf-8?B?eW1DblcxUXNNQjR3YjgvbCtZOVpMajByQlhrTUs4YWtMaFM2YWVGenJjVEpV?=
 =?utf-8?B?UHQzTm9xeVR0ZVoyWXVuTDlNNE81dDJtQnVoOUdYVDNDMlMyMW1lVlJlWDNS?=
 =?utf-8?B?VGFNWmFNaGpBTVpXR2FzOUcwdDAzNWM2WFlXNGNLZFlNUUIraVR4R2JkTWNL?=
 =?utf-8?B?NDNVYVlOMytTNitIdXZUOEtrdThKcEhoQmhTaEVRY3NoSjNlTG5DNUMwZlRi?=
 =?utf-8?B?RWdJU01Xd0VqTUpvUVl1cFMrd3pQeENWOFo0ZzlYQXpDeFFDWFA3SzI0cEZu?=
 =?utf-8?B?YTRqNFdkQ09iQStJRkQwL2FVc3h0M3BZbHN6K3NFM20vTTlPTXBFeTdKZ0hk?=
 =?utf-8?B?SkFSSFFraDNlVG9Ob0IxTVBZODd0bEUwNkY5c1VPaStNNVVtY3F1RkgxQnJj?=
 =?utf-8?B?Q1JoSFF4SEhYTzFIODJ0YUwwaUR4Nkc3VE9mT2FmNVpHRmk5SHNFNGNidTU3?=
 =?utf-8?B?ZExpTkc1YnNPYmxCeCtyUVkrZXBzTjY5MHhmV2ZXNHdQTnBFSXdLbHMwbWlX?=
 =?utf-8?B?V0RmQ2ptWERHWG9PR0tGNUEwQ09RMi9CRTU4WTVFS3RBc2E4czZSYlJvSGtI?=
 =?utf-8?B?ZlNRN3JUWVNRVk1PWE1HTVpqemsyWU9LY0ZYb1NWQ0IwOXJsaVp2Q1RpekJX?=
 =?utf-8?B?MS9VRENXS2VrWjZWeHZVbFQ0dlVGMlF2WWdwbVRjL0tqQlg3dytUYUFUems0?=
 =?utf-8?B?ZGhVM2EvVlNTeEVzR2RrMFp4TjZ6aTN3K0JrbkxDUGREYzk5SmtRMTdSWTQr?=
 =?utf-8?B?TzZsazFFTkFSaDVMVjEyaTNxN1hnYm1xOGtsSVpjYkxCWE9sWlo3bnFQS0Nh?=
 =?utf-8?B?c1VwVmNhakplMGtuZnlZZ1REZlVxeThRNE9Wc3JZcWRvSHR2MjZmc3hKeHZ2?=
 =?utf-8?B?L3lHRGo3U08yajBuN1FXVkVjKzhzMTE0S1VWYUxxK3ZBY2diWGVIOFJuUU9G?=
 =?utf-8?B?MFllV0lwc0g3TGdHMThpOG91VDBXb0hYOFc4UkZldWZaZytWTkNRQTNGUGN3?=
 =?utf-8?B?VmdmZFBrbFNwNDZKTElJTVBxTW9rRmZ1czUxeTd3ZzM5ZkdyZzB3RHROYXFa?=
 =?utf-8?B?NEE2S3QzWUxIK1E0bjVPMUdCeHJUWjduUVQ4cWdCNVExUEdYZlFLVDZUNXJt?=
 =?utf-8?B?V2k3N1M4MjVGSE5lV2Z3UVBFVW41eUJlYm5zZEtHclllejlHNDUxeUhpMDc2?=
 =?utf-8?B?RmtvZWFzVjhBZmdVdFVuOXkvNGx6OHU1TEcySlJzd1JjcEJ4Z0l2cDRIZTFS?=
 =?utf-8?B?K3FQYUM0alpqM1BJcmpzYThnb05qb3BnQzNHZUFNbGRlVHUyODRLdmhZeGtR?=
 =?utf-8?B?Zkg1TWNKR2lYeGFSMGV5TXVPL1dJMklMbTlWZXBKQ0hYcCszWkFXbUVSeGxX?=
 =?utf-8?B?bllRNFZRMzM2L2pXSThFT3ladlc3QlJKL2hQTXdNb0d3VTR3MnhTZXlMYjUv?=
 =?utf-8?Q?uf9Dm0nqPuQkaayCLcZU8YYzB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074ec18d-57a8-4e5c-595a-08db6da84f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 13:56:25.3870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/09fZ3VOD9RafcRItthbc/zNCHz3Z0Z5vZ7CYhaJnXJMk4te6X74Bn8TvMRSTxSW+EDgordUKhEBAYJJN8TGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkFja2VkLWJ5OiBIYXdraW5nIFpo
YW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogVGh1cnNk
YXksIEp1bmUgMTUsIDIwMjMgMjE6MTgNClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvYXRvbWZpcm13YXJlOiBmaXggRERSNSB3aWR0
aCByZXBvcnRpbmcNCg0KUGluZz8NCg0KT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgNTo0N+KAr1BN
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4NCj4gUGluZz8N
Cj4NCj4gT24gV2VkLCBKdW4gNywgMjAyMyBhdCAxMjo0NuKAr1BNIEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBERFI1IGNoYW5uZWxzIGFy
ZSAzMiBiaXQgcmF0aGVyIHRoYW4gNjQsIHJlcG9ydCB0aGUgd2lkdGggcHJvcGVybHkNCj4gPiBp
biB0aGUgbG9nLg0KPiA+DQo+ID4gTGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3Jn
L2RybS9hbWQvLS9pc3N1ZXMvMjQ2OA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmMgIHwgMjANCj4gPiArKysrKysrKysrKysrLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hdG9tZmlybXdhcmUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2F0b21maXJtd2FyZS5jDQo+ID4gaW5kZXggZWY0YjlhNDFmMjBhLi42YjNiZGMyN2Y3NzggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJt
d2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21m
aXJtd2FyZS5jDQo+ID4gQEAgLTMyNywxMCArMzI3LDE0IEBAIGFtZGdwdV9hdG9tZmlybXdhcmVf
Z2V0X3ZyYW1faW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtX2NoYW5uZWxfbnVtYmVyID0gaWdwX2lu
Zm8tPnYxMS51bWFjaGFubmVsbnVtYmVyOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoIW1lbV9jaGFubmVsX251bWJlcikNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1fY2hhbm5lbF9udW1iZXIgPSAx
Ow0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBjaGFubmVs
IHdpZHRoIGlzIDY0ICovDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICh2cmFtX3dpZHRoKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICp2cmFtX3dpZHRoID0gbWVtX2NoYW5uZWxfbnVtYmVyICogNjQ7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbV90eXBlID0NCj4g
PiBpZ3BfaW5mby0+djExLm1lbW9yeXR5cGU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmICgobWVtX3R5cGUgPT0gRGRyNU1lbVR5cGUpIHx8DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAobWVtX3R5cGUgPT0gTHBE
ZHI1TWVtVHlwZSkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtX2NoYW5uZWxfd2lkdGggPSAzMjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1lbV9jaGFubmVsX3dpZHRoID0gNjQ7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmFtX3dpZHRoKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICp2cmFtX3dpZHRo
ID0NCj4gPiArIG1lbV9jaGFubmVsX251bWJlciAqIG1lbV9jaGFubmVsX3dpZHRoOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJhbV90eXBlKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICp2cmFtX3R5
cGUgPSBjb252ZXJ0X2F0b21fbWVtX3R5cGVfdG9fdnJhbV90eXBlKGFkZXYsIG1lbV90eXBlKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7IEBAIC0z
NDUsMTAgKzM0OSwxNCBAQA0KPiA+IGFtZGdwdV9hdG9tZmlybXdhcmVfZ2V0X3ZyYW1faW5mbyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbWVtX2NoYW5uZWxfbnVtYmVyID0gaWdwX2luZm8tPnYyMS51bWFjaGFu
bmVsbnVtYmVyOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIW1lbV9jaGFubmVsX251bWJlcikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtZW1fY2hhbm5lbF9udW1iZXIgPSAxOw0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBjaGFubmVsIHdpZHRoIGlzIDY0ICov
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmFtX3dp
ZHRoKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICp2cmFtX3dpZHRoID0gbWVtX2NoYW5uZWxfbnVtYmVyICogNjQ7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbV90eXBlID0NCj4gPiBpZ3BfaW5mby0+djIx
Lm1lbW9yeXR5cGU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmICgobWVtX3R5cGUgPT0gRGRyNU1lbVR5cGUpIHx8DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAobWVtX3R5cGUgPT0gTHBEZHI1TWVtVHlwZSkpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtX2No
YW5uZWxfd2lkdGggPSAzMjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1lbV9jaGFubmVsX3dpZHRoID0gNjQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICh2cmFtX3dpZHRoKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICp2cmFtX3dpZHRoID0NCj4gPiArIG1lbV9j
aGFubmVsX251bWJlciAqIG1lbV9jaGFubmVsX3dpZHRoOw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJhbV90eXBlKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICp2cmFtX3R5cGUgPSBjb252ZXJ0X2F0
b21fbWVtX3R5cGVfdG9fdnJhbV90eXBlKGFkZXYsIG1lbV90eXBlKTsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLS0NCj4gPiAyLjQwLjEN
Cj4gPg0K
