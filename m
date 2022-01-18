Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1614C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 08:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EE610ED97;
	Tue, 18 Jan 2022 08:18:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647AE10ED97
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 08:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coDDqipbBvP6PI2ISvt41OOGvu6lcG85Em+5+cwLKQp6+3ow0C2z0+82UMCSSS1I10ylq1I4K2mBbtr3HrwN4pXokAsbNTtB9fZukrhqLS37CB9CtpSRinHdN4Z9ubmRCT7Y1v3zsuHIPa4j9GLpBLfq5O1T7fipSbhxvpMowrRw/FsypvuAARljOJSuO0nS7QCaHn7YUOV0BUxhOWA65jZ0pd6QHH1FXjaaLLEBi/JBK6clSvmTnDGJKonir+Qj13A+ke13Jhz+B1IWr+DAsXdgngj4TUt7S+/OVBHk+qDTOZbOpSzGtXJtTq9V5sE/sFnNG3NnjDgPjgn8N4nGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjktmFiThVXP78ZtwPdrb9zNUOShM0NX/qDG6QZj++4=;
 b=nnKe0dhKvQeZaH0+c69I0vr+90jgC7ph6Z8aFhZAYMuvNG+9abPnO3d0uJec5ScpV6X0uM4d0tqeDo3PxJeKgqJR5OPZRGYwFEt3tnkGS/H9a0NQpyFf5JqpBe38/xonVErJ9nAl6Adz/RxCGqjdZ2VRFhWN2CRYa3Ij2bW4vbToh5niZklLrcKyTaIHfR9sN5jTMP2t+gZwBlS20Aa0GOZwiAC0w4oxGbbkDpPRT2tYeMmpAH0H7BgENdC+57jmTXu77UXLPcK/ZaM/Fxoz3wjdTjJJtG9zxolw5h8DY6yV/4qMT1ZrTLWxeDxAuovwFcDTo2X1gbwiQii48GxZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjktmFiThVXP78ZtwPdrb9zNUOShM0NX/qDG6QZj++4=;
 b=giNtEm8NUmLIT/0YhzRA0rdJFMq/T6qW1CEzXdQina/y1lT988ea4zCXpbZYheu7KWxYPc+NcbcGDU8qG+gPM3CcbFi7U3yVLvVbAELQqHWSWpgi8WVnOaaY8a/rpFQwe0I/IIdCpoUDUXGQaQfGw/tA2yLegzCsAclK8oPOIHs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 08:18:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:18:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Index: AQHYC/wB4n/uUjOCA0eOf90imw9wI6xoYlQAgAAJmICAAAKzAIAAANqw
Date: Tue, 18 Jan 2022 08:18:22 +0000
Message-ID: <DM5PR12MB2469C94C449807AA6743B38DF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220117234307.3820143-1-jonathan.kim@amd.com>
 <88f0e304-c17c-bc50-14ce-37c05d76a3b4@amd.com>
 <DM5PR12MB24692B8100BF87268D08FF3CF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <a01cffca-797d-0edd-d64e-e011b53fed04@amd.com>
In-Reply-To: <a01cffca-797d-0edd-d64e-e011b53fed04@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-18T08:16:46Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=62400f1d-035e-4438-847d-8445c2c0f963;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-18T08:18:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c667005a-7f79-4446-a00f-2cf3e8559eae
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f969c9-91c8-416b-6d4b-08d9da5b17a9
x-ms-traffictypediagnostic: SJ0PR12MB5501:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB550197DE2751263024D3BA98F1589@SJ0PR12MB5501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2ZdBjumBh5IxECCyXPkdMYccxKw2s/4ki0wfDcqNJY9vv0SrTYCQ41EqVQF7AB8F8VcNFHnB5m2YA0vaFdOe1jyh1nh2pzJpSztPk63dF8h9WKg/Uj751smdnxKckT7CYbcwz0JjX5gTLe6EVGF0Q4FPwghGmNg8tpp9mUAot8ZJgnXzr700T0F8Vgqzd1p0BLY04mV9VB/LSOsULptbMO6r2oCaxB5CPmS1Op2fnjqArE2zD2lGgfQhUaisJD5RPktQyj50wtgsgDLAI2UWdfI1oAGQpiGB081Ds5hcFV55fmzsWEq6fph9oKxg9g5BX9wJIZEKtpmLh7e0txI7QUV6hO8AyOTmJ8LylsRmoO96Qq78jH4T6OMkCYG1NEKihbxbbAY2F6X1Zj5xxyyqwy7Uw6fyRUd5uDskcLaR+n+a3WoJIsMU+dZDpMyQdvnWcEoU7XUvqOQAbCWc+PsVIH87CPZCY4vUQ+uJIX73hka+XHINh2DzSuZ033Yx0Qsa1JhU+cndA79UgIOKLIx7WenyvXD8VsC8DZFppzaU+irmlQq5emhh1QnMvcKZLxpPVozIPVdu4l1FEfVPAl+5pjAg6ueCXwmQz4zuSSKp0qI8AxOMd0zxYxffAWieSR04ma3GOQjPvC5jP7nkbzFGqnwA4aX4w6KgCsPi2fi/IdGO9QnRVVBwwqlcFhuDLYQiTg9+ShxYPiSKUlGoYDutw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(186003)(64756008)(66476007)(86362001)(26005)(66556008)(5660300002)(38070700005)(76116006)(4326008)(508600001)(122000001)(2906002)(66946007)(316002)(38100700002)(7696005)(8936002)(110136005)(52536014)(9686003)(53546011)(55016003)(8676002)(83380400001)(71200400001)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNaZG1iaXg1dURsMzlMSXA1c2NpL1ByU2wxNGlDdnMxTTBNWUpXbWdvaXp4?=
 =?utf-8?B?OFU2aEo0d3ZlOEk1MzlxWHFDMVhVWU04ajIyekljTmJkUGRxUTdZY0pyTFRH?=
 =?utf-8?B?N2FsTlNFMFN6cFpRUlRodGZOZmtDNnRIejlPTkhkTlp4TDZnMm9URXo3N1dU?=
 =?utf-8?B?T1oyaVFFWDNjWWFVdHFralRVVk1zUlhuY2dOYVo2RmhrNnViYkwyaTBKUjkz?=
 =?utf-8?B?UVVFeU9OaUxjRVFxVVp4MHpPMHF1dHowS01HUGs3cWZDdTdtRU53RHN5UGg0?=
 =?utf-8?B?NWQ5N05JRnIzSkxMSUZkWkZMVm9obDJFc0xjYmpxd2psT1RFVlExdDhBM0pq?=
 =?utf-8?B?T0VaTlhsWW12enV0ZDZ0RmtmM2dFQ2R0MkloQ05yOHpqeXdlQjhwOVhqNCts?=
 =?utf-8?B?bTl3cXRmRVhzK0NsaDIwZ2tXUXAwYnlZRlB1WXlZTjMvOFRJR01MYlJybEpI?=
 =?utf-8?B?V1d3TGEwb21tS3g5TXpFSzJBSVpmWmtkb3VFR1JMTk4vZEJwZU5HTXNEOS9P?=
 =?utf-8?B?eEJxU0h4ZFM3UFJtTFRhRFBUenB1SVI5bFJFK01NU25md0kwaW5MWU9iTlZR?=
 =?utf-8?B?SWV0b1p0bS96a0FuRXBhNkJGVWRMVTNHbmZnWmtMT1ZDZkE4cVk1SWRJYlNZ?=
 =?utf-8?B?ZXJZbnQ3OVREWVBjbmNRUFljUEZHUUs3Vm1JZ2pIeWc5ZzJoamMrM0pUUnNM?=
 =?utf-8?B?eTZVRmlqT3BObzJkeXdrQ1U2cGtDb015WEhtVFVCN0FtMDc4Zk5UcnBPTEMv?=
 =?utf-8?B?VlpON3pyZG5hNm0vUDlKTi9GQ2hSV1UyTmpxb2pIeWViTEIvdCtBd042anJz?=
 =?utf-8?B?eVJVRWpkanAvN0FnYklHYXVBZXJteVhuUk16aEZnYnNPb1hYVTNtL3JkRUth?=
 =?utf-8?B?K1FBNHVISDZMYU5JZnBuNi9XMm5JYjRSMlNpZ09nenFLVHVMdnczRWlhR1Zk?=
 =?utf-8?B?YkhPVEsrUDFheTM1bUlXUXVhMVZMSS9vSnUvT01VZnN1VmMwMXVFMGk0aDE3?=
 =?utf-8?B?TnRKZ0RqS3dPODB5MlF5cEpoK1hyTTI3bDRXMmgvVEt0UFdDQUlFUFVobDFT?=
 =?utf-8?B?Mkl1eXFSaHg2RTZtWjVEQnREbUVlVEdvS3kvdjAwSHZEZ1Bac1FEMWJCWHIv?=
 =?utf-8?B?ZVFJMGRYZEZyZWJQc0xFMkZwNVFUQWNPWitzeVpncHRXeStObjBHc2xsSjBq?=
 =?utf-8?B?Rkw0YmFJeHZrMklEVTkrS0tpQWhRbFN0elArektKWUEzR0V4bzdCZ2d0NEJ6?=
 =?utf-8?B?cFFkeUVFbk5PVk53TUJpOStCV3htSDB6RTJYK3h5YXptY09vVWxBaXN6dEJZ?=
 =?utf-8?B?K0V3V3B3VU93VWQxbDI2SHlvOTY1MUc2cG1vV1VPdzcyWis1eXpVTFU2N0FJ?=
 =?utf-8?B?TXQwc3BCZTJHQkowbmZackZsWDE4OFV1akQyT2RtTVdDNzlWczVsSDduZjdt?=
 =?utf-8?B?ZG12bFcxcHlzZDVReWNPQ2RlVXVRelJsVkl4ZXZoTnlQMWpJcWE3RElycXhs?=
 =?utf-8?B?YjBkVUZob21sYkE0UEd3Yno3ZDNoTzM3SGhFb1RqZTlFSkMvRTZvQjJJeFU0?=
 =?utf-8?B?MSs3Zy8rL2FYYW5nYUxTcGV6a1N0dG1ZdlgwdEtlc3dkdUNvL3FVdDZ0a2VX?=
 =?utf-8?B?TUJUcHVXbUtsTklKL05HRmlWSmp0dFNnWFNjRXFvOTdpZjZEV3ZGVlZpRHNq?=
 =?utf-8?B?b2daVWVFTUtHbG5BRnRNNEZqeWZuUkVWL1M2YmFwdGpIMTdlRjk1ckIrRVVp?=
 =?utf-8?B?T0dCbHEvZlhDNis4THJwaFhtZGs1Z2NEcmJSZ0g0dkFnc2gyUzRqS3lKbndk?=
 =?utf-8?B?MGdFbmJwRjJVMmxJTHRqTFZVLzZzOVZpZnBxd1FFWm0wWHpwMGpJeHY4Z1A0?=
 =?utf-8?B?eEs5RzZZR3RiaFkzc2RwZUFyUDh6dTZCdTZQcXlza3VGNTNQMHFUZWNUOUtr?=
 =?utf-8?B?Q2JqeG1QQm90Mk5VUkJWK0FadGo4SXVINFNsd2hWQTVQQmRocDN5V0VzYjJC?=
 =?utf-8?B?UE9PaUNxZlNFN1cwUEIrdTBnc0Q0c1VMeWszL2hGTmROMjlkRkl6cXRNWkFZ?=
 =?utf-8?B?dkFKWGJEOW1ORUoxbUIrU0g4aEs5ZlBIWVRSYXlqUDJRVnpPa2pCWUpkeVVs?=
 =?utf-8?B?RUZzMEEySkt1MzhRc2lqd2dvRitaelEySjBKTllteThTZk1PeGl3RG9GVC9j?=
 =?utf-8?Q?ycZNSF+W7lhppG7ZLyK8z88=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f969c9-91c8-416b-6d4b-08d9da5b17a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:18:22.2713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hw7kOvNhegrwgd9aTwJxT3XvbXfre5yBsdLnxKl9WEdYw6lsUFHkyiCGJJOYtfYdP3TiaCf6Ejjz/bX1uoMt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KT2theS4uLiBpbiBhbWRncHVfZ2FydF9iaW5kLCB0aGUgY2hlY2sgb2YgZ2Fy
dC5wdHIgaXMgYWxzbyBwcmVzZW50LCBzbyBpdCdzIHNhZmUuDQoNClJlZ2FyZHMsDQpHdWNodW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogVHVlc2RheSwgSmFudWFyeSAxOCwgMjAy
MiA0OjE0IFBNDQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgS2ltLCBK
b25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBmaXggYnVpbGQgdXAgYW5kIHRlYXIgZG93
biBvZiBkZWJ1ZyB2cmFtIGFjY2VzcyBib3VuY2UgYnVmZmVyDQoNClRoYXQgY2hlY2sgaXMgdXR0
ZXJseSBub25zZW5zZSBhbmQgc2hvdWxkIHByb2JhYmx5IGJlIHJlbW92ZWQuDQoNCldoYXQgbmVl
ZHMgdG8gYmUgY2hlY2tlZCBpcyBpZiB0aGUgR0FSVCBwdHIgaXMgYXZhaWxhYmxlIGFuZCB0aGF0
IHNob3VsZCBjZXJ0YWlubHkgYmUgdGhlIGNhc2UgYXQgdGhpcyBwb2ludC4NCg0KQ2hyaXN0aWFu
Lg0KDQpBbSAxOC4wMS4yMiB1bSAwOTowOSBzY2hyaWViIENoZW4sIEd1Y2h1bjoNCj4gW1B1Ymxp
Y10NCj4NCj4gSGkgQ2hyaXN0aWFuLA0KPg0KPiBSZTogV2VsbCB0aGF0IGRvZXNuJ3Qgc2VlbSB0
byBtYWtlIHNlbnNlIHRoZSBHQVJUIGlzIGluaXRpYWxpemVkIGJ5IHRoZSBjb2RlIGFyb3VuZCB0
aGUgYWxsb2NhdGlvbiBzbyB0aGF0IHNob3VsZCB3b3JrIGZpbmUuDQo+DQo+IEJlbG93IGlzIHRo
ZSBjYWxsdHJhY2UgZHVyaW5nIGRyaXZlciBwcm9iZS4gV2hlbiBiaW5kaW5nIHRoZSBwYWdlKFNE
TUEgYm8pIGludG8gZ2FydCB0YWJsZSwgdGhlcmUgaXMgYSBjaGVjayBieSBnYXJ0LnJlYWR5LCB0
aGF0IHdpbGwgYmUgc2V0IHRvIGJlIHRydWUgbGF0ZXIgb24gaW4gZ21jX3YxMF8wX2h3X2luaXQu
IFNvIGEgY2FsbHRyYWNlIGlzIG9ic2VydmVkLg0KPg0KPiBbICAgIDMuMzgxNTEwXSAgYW1kZ3B1
X3R0bV9nYXJ0X2JpbmQrMHg4MC8weGMwIFthbWRncHVdDQo+IFsgICAgMy4zODE1ODBdICBhbWRn
cHVfdHRtX2FsbG9jX2dhcnQrMHgxNTgvMHgxYzAgW2FtZGdwdV0NCj4gWyAgICAzLjM4MTY0N10g
IGFtZGdwdV9ib19jcmVhdGVfcmVzZXJ2ZWQrMHgxMzYvMHgxZTAgW2FtZGdwdV0NCj4gWyAgICAz
LjM4MTcxNF0gID8gYW1kZ3B1X3R0bV9kZWJ1Z2ZzX2luaXQrMHgxMjAvMHgxMjAgW2FtZGdwdV0N
Cj4gWyAgICAzLjM4MTc4Ml0gIGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKzB4MTcvMHg4MCBbYW1k
Z3B1XQ0KPiBbICAgIDMuMzgxODQ5XSAgYW1kZ3B1X3R0bV9pbml0LmNvbGQrMHgxNzQvMHgxOGUg
W2FtZGdwdV0NCj4gWyAgICAzLjM4MTk1MV0gID8gdnByaW50a19kZWZhdWx0KzB4MWQvMHgyMA0K
PiBbICAgIDMuMzgxOTU1XSAgPyBwcmludGsrMHg1OC8weDZmDQo+IFsgICAgMy4zODE5NTddICBh
bWRncHVfYm9faW5pdC5jb2xkKzB4NGIvMHg1MyBbYW1kZ3B1XQ0KPiBbICAgIDMuMzgyMDUyXSAg
Z21jX3YxMF8wX3N3X2luaXQrMHgzMDQvMHg0OTAgW2FtZGdwdV0NCj4NCj4gUmVnYXJkcywNCj4g
R3VjaHVuDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEph
bnVhcnkgMTgsIDIwMjIgMzozMCBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2lt
QGFtZC5jb20+OyANCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IENoZW4sIEd1Y2h1biANCj4gPEd1
Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1
OiBmaXggYnVpbGQgdXAgYW5kIHRlYXIgZG93biBvZiANCj4gZGVidWcgdnJhbSBhY2Nlc3MgYm91
bmNlIGJ1ZmZlcg0KPg0KPiBBbSAxOC4wMS4yMiB1bSAwMDo0MyBzY2hyaWViIEpvbmF0aGFuIEtp
bToNCj4+IE1vdmUgdGhlIGRlYnVnIHNkbWEgdnJhbSBib3VuY2UgYnVmZmVyIEdBUlQgbWFwIG9u
IGRldmljZSBpbml0IGFmdGVyIA0KPj4gd2hlbiBHQVJUIGlzIHJlYWR5IHRvIGF2b2lkIHdhcm5p
bmdzIGFuZCBub24tYWNjZXNzIHRvIFNETUEuDQo+IFdlbGwgdGhhdCBkb2Vzbid0IHNlZW0gdG8g
bWFrZSBzZW5zZSB0aGUgR0FSVCBpcyBpbml0aWFsaXplZCBieSB0aGUgY29kZSBhcm91bmQgdGhl
IGFsbG9jYXRpb24gc28gdGhhdCBzaG91bGQgd29yayBmaW5lLg0KPg0KPiBGcmVlaW5nIHRoZSBC
TyBpbmRlZWQgbmVlZHMgdG8gYmUgbW92ZWQgdXAsIGJ1dCB0aGF0IGNhbiBzdGlsbCBiZSBpbiB0
aGUgc2FtZSBmdW5jdGlvbi4NCj4NCj4gQWxzbyBwbGVhc2UgZG9uJ3QgbW92ZSBUVE0gcmVsYXRl
ZCBjb2RlIG91dHNpZGUgb2YgdGhlIFRUTSBjb2RlIGluIGFtZGdwdS4NCj4NCj4gUmVnYXJkcywN
Cj4gQ2hyaXN0aWFuLg0KPg0KPj4gQWxzbyBtb3ZlIGJvdW5jZSBidWZmZXIgdGVhciBkb3duIGFm
dGVyIHRoZSBtZW1vcnkgbWFuYWdlciBoYXMgDQo+PiBmbHVzaGVkIHF1ZXVlZCB3b3JrIGZvciBz
YWZldHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1A
YW1kLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgMTEgKysrKysrKysrKysNCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyAgICB8ICA4IC0tLS0tLS0tDQo+PiAgICAyIGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4IGRhMzM0OGZhN2IwZS4u
MDk5NDYwZDE1MjU4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4+IEBAIC0yMzc4LDYgKzIzNzgsMTMgQEAgc3RhdGljIGludCBhbWRncHVf
ZGV2aWNlX2lwX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAJaWYgKHIp
DQo+PiAgICAJCWdvdG8gaW5pdF9mYWlsZWQ7DQo+PiAgICANCj4+ICsJLyogR1RUIGJvdW5jZSBi
dWZmZXIgZm9yIGRlYnVnIHZyYW0gYWNjZXNzIG92ZXIgc2RtYS4gKi8NCj4+ICsJaWYgKGFtZGdw
dV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIFBBR0VfU0laRSwgUEFHRV9TSVpFLA0KPj4gKwkJCQlB
TURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+PiArCQkJCSZhZGV2LT5tbWFuLnNkbWFfYWNjZXNzX2Jv
LCBOVUxMLA0KPj4gKwkJCQkmYWRldi0+bW1hbi5zZG1hX2FjY2Vzc19wdHIpKQ0KPj4gKwkJRFJN
X1dBUk4oIkRlYnVnIFZSQU0gYWNjZXNzIHdpbGwgdXNlIHNsb3dwYXRoIE1NIGFjY2Vzc1xuIik7
DQo+PiArDQo+PiAgICAJLyoNCj4+ICAgIAkgKiByZXRpcmVkIHBhZ2VzIHdpbGwgYmUgbG9hZGVk
IGZyb20gZWVwcm9tIGFuZCByZXNlcnZlZCBoZXJlLA0KPj4gICAgCSAqIGl0IHNob3VsZCBiZSBj
YWxsZWQgYWZ0ZXIgYW1kZ3B1X2RldmljZV9pcF9od19pbml0X3BoYXNlMiAgDQo+PiBzaW5jZSBA
QCAtMzg3Miw2ICszODc5LDEwIEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX2h3KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAgCX0NCj4+ICAgIAlhZGV2LT5zaHV0ZG93biA9IHRy
dWU7DQo+PiAgICANCj4+ICsJLyogcmVtb3ZlIGRlYnVnIHZyYW0gc2RtYSBhY2Nlc3MgYm91bmNl
IGJ1ZmZlci4gKi8NCj4+ICsJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5tbWFuLnNkbWFf
YWNjZXNzX2JvLCBOVUxMLA0KPj4gKwkJCQkJJmFkZXYtPm1tYW4uc2RtYV9hY2Nlc3NfcHRyKTsN
Cj4+ICsNCj4+ICAgIAkvKiBtYWtlIHN1cmUgSUIgdGVzdCBmaW5pc2hlZCBiZWZvcmUgZW50ZXJp
bmcgZXhjbHVzaXZlIG1vZGUNCj4+ICAgIAkgKiB0byBhdm9pZCBwcmVlbXB0aW9uIG9uIElCIHRl
c3QNCj4+ICAgIAkgKiAqLw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMNCj4+IGluZGV4IGI0ODljZDhhYmUzMS4uNjE3OGFlN2JhNjI0IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4+IEBAIC0xODU1LDEyICsxODU1
LDYgQEAgaW50IGFtZGdwdV90dG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+
ICAgIAkJcmV0dXJuIHI7DQo+PiAgICAJfQ0KPj4gICAgDQo+PiAtCWlmIChhbWRncHVfYm9fY3Jl
YXRlX2tlcm5lbChhZGV2LCBQQUdFX1NJWkUsIFBBR0VfU0laRSwNCj4+IC0JCQkJQU1ER1BVX0dF
TV9ET01BSU5fR1RULA0KPj4gLQkJCQkmYWRldi0+bW1hbi5zZG1hX2FjY2Vzc19ibywgTlVMTCwN
Cj4+IC0JCQkJYWRldi0+bW1hbi5zZG1hX2FjY2Vzc19wdHIpKQ0KPj4gLQkJRFJNX1dBUk4oIkRl
YnVnIFZSQU0gYWNjZXNzIHdpbGwgdXNlIHNsb3dwYXRoIE1NIGFjY2Vzc1xuIik7DQo+PiAtDQo+
PiAgICAJcmV0dXJuIDA7DQo+PiAgICB9DQo+PiAgICANCj4+IEBAIC0xOTAxLDggKzE4OTUsNiBA
QCB2b2lkIGFtZGdwdV90dG1fZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAg
IAl0dG1fcmFuZ2VfbWFuX2ZpbmkoJmFkZXYtPm1tYW4uYmRldiwgQU1ER1BVX1BMX09BKTsNCj4+
ICAgIAl0dG1fZGV2aWNlX2ZpbmkoJmFkZXYtPm1tYW4uYmRldik7DQo+PiAgICAJYWRldi0+bW1h
bi5pbml0aWFsaXplZCA9IGZhbHNlOw0KPj4gLQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYt
Pm1tYW4uc2RtYV9hY2Nlc3NfYm8sIE5VTEwsDQo+PiAtCQkJCQkmYWRldi0+bW1hbi5zZG1hX2Fj
Y2Vzc19wdHIpOw0KPj4gICAgCURSTV9JTkZPKCJhbWRncHU6IHR0bSBmaW5hbGl6ZWRcbiIpOw0K
Pj4gICAgfQ0KPj4gICAgDQo=
