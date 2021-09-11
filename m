Return-Path: <SRS0=1siV=OB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA6C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 10:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55429610C9
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 10:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55429610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A6E6EB69;
	Sat, 11 Sep 2021 10:18:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D17E6EB69
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Sep 2021 10:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y49dojwHmlM33phZLrmyFf0mvSsOfC0BiO0EGQoqzjNrlOTP+i9Kohk6/xDPvdFxYVrlZCzjAROtjgdAttjiU4DY/TsyjjpXeq1rX2/A22QHQuzyTSu3WHxCJIYtGIB9XCVHDrVE3U12pMvAFDbBEifoBcz9A8O8ZgHfU5zhfo7iJpD8bmBvw4LqqybZEU7DMD4/l/sFwYxxjG0XUOiLo2vBIoS+CqYjlowRyaxVYNDu7P6shKjeA828VCDB5B18OuVMKxpPQjrRfKCblsgwr3vskNLhCWnkuam24MYvCQr6VGrtV2X8vMv/SlqvrHEi4NcBwjUoOy+oHMS3Iw3FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ffVIy0FqgfelBIqe65EC/Go1FTKWmsstj7y0UUCwIGk=;
 b=d3Cmn9hJP49NB5zHIfOTyYSV0st5tqjD2TBWDxNMWb0gQ1d+3qq5UNKe6IOrDxAXBy+BUe8VFJgE/o18NxsXbMRSYzOOtXN6ycqfIIFq0YT0/6FVXzaFGHFbtu7pY5SCnjo48OSal3TQFODdtFKc3dzjQItaNVr+zc17PC3cl03n138nHdzfRrSbRVoYaoRoV9vJPFScM1gsBjwIsmjNJPaxos1p49M4/dF7Rm9XzYzrM8LRF+e9r8I1NxSQ4p0KYYpeBujtsmydjPoYWdU5IQCp4kHiKsAfLOYWd4Qkq+JrjOoVqa6ZfR9TLhUZTpZfFerDjzGiPITckBcEHG/jhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffVIy0FqgfelBIqe65EC/Go1FTKWmsstj7y0UUCwIGk=;
 b=zv7Ctw8SSgUqo+LrA8Q1ZgyCQRw3wYbJdC7UlDDENVHkVEyHvkeXV6QYQA+p2VsN9r717jIn/VztWB/8Kflb0fG0umZGORGlDy9BWNmCJRiHl638KZ1oSKOtJbXz0WadbV30tJkk9pKNrSJJGygKPQucMusV12yd4NzQandbrqI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:39d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.17; Sat, 11 Sep 2021 10:18:12 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4500.018; Sat, 11 Sep 2021
 10:18:12 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBhIHJhY2Ugb2YgSUIg?=
 =?utf-8?Q?test?=
Thread-Topic: [PATCH] drm/amdgpu: Fix a race of IB test
Thread-Index: AQHXprAdInfvMoj8KkCgP9SSUR/1jKuedKSAgAAe60s=
Date: Sat, 11 Sep 2021 10:18:11 +0000
Message-ID: <DM4PR12MB5165351AA7C45CCDBD15AAC187D79@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210911015513.3822-1-xinhui.pan@amd.com>
 <d983949c-6386-cb32-d361-c70efc206e2c@gmail.com>
In-Reply-To: <d983949c-6386-cb32-d361-c70efc206e2c@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-11T10:18:11.150Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: ca834012-8caf-5d97-631c-bdc753487441
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35ce2bb6-f128-4a4a-394f-08d9750d75c1
x-ms-traffictypediagnostic: DM4PR12MB5309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5309CA872AD8E8EB7690846187D79@DM4PR12MB5309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XM9KTu5p8WLwhb1TXlqRrwd/BxhqIF8+zdidoCLVhDpi6izHx+Wszir9xdHofrNi2IPPzs2GKvcxADlWcSztIj9SKYjJCFz+r8LPDgDaHN7WncBg6UfEAuPhOFXHVioGNdtDf8BMoFpOi4t+jgMvTJaUYAg29UNQ9enTOUJxQsJjjvy5u9lTYm3ULWWYy61ar+kiBfppji28uFCkT6b0IcFePKhgP48FyLUhaEIJnJbRjBjuxFJRefnGeZApB1+ganZFJinNgthCGZlyCq3fMvfBxtj+fOR1bd2sCW7Ll3WiDX3JMBPdYPv2YCIExe0Awl9yRKdm0XkgYkrEymofzJjzfTHBUc8yrXCP15F03JZ6+fYbyN3XcA5bN3pNSBI0FPUmi6i9hXvIlTzQE8FFXIuM3UqfqQWuj8lnbXCdJeSnyg9t9yjBQPjBRKqyAeA8vVMHdnxFdcs1H9I0WhTJ41bpBKhgG7dIuWfjfaiHIufMM0XOXlAQjrdUfzrtSAU9XHYCr2ANP0tpsVxiNDEYbZxdExszHhe0wJ3pQl9mzOLyrPvDDNfb0Tcw/CGAt4lqVI9uoR/vz/WVrd1DCnCE5uPNgDuK3F1gfXTyn3NfrSP98LN+zV0+27QplCm76F0K+SqmklVsMgsbaXJNV1AqggoB+j/PVdc1D2m7hsyaRKCbgghiY4ibqrOcafSL/XtUJKthNdTchlPAKRsDhlG6rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(33656002)(55016002)(2906002)(38070700005)(122000001)(9686003)(38100700002)(26005)(83380400001)(54906003)(71200400001)(110136005)(5660300002)(8936002)(186003)(66574015)(86362001)(52536014)(316002)(66446008)(7696005)(4326008)(478600001)(66946007)(76116006)(6506007)(224303003)(64756008)(66556008)(66476007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZTL0tySHFEWWQvdFpqZWEzb0src2kyd1gvZkdkdk5NTUh5NTNHL0pUZXlH?=
 =?utf-8?B?VXpTMmluQjJyN21jUUREUW5Ibm51cHNLelAwV01JOUNyWVVPT3phYkJRWjR4?=
 =?utf-8?B?NnBDeityeVoyM2R3NHIrSXUvUlB0ekZwb3ZhclVMcHoyeXNYSXVraU1ranly?=
 =?utf-8?B?NmU3UjBKS2RROU9ySmpuc095b0NLcXJ2VDcwYlY3WHVqdGJ0d0hOOGU5aG1U?=
 =?utf-8?B?c1NPV0JPR2tkUWpiQm5sOUI4MjVmU0k2T1NtbUdTLzJIMHJTMk1pdkUzb0xy?=
 =?utf-8?B?anJIVy9peUgrZTNpYm9kZ0p1eVkzdE5oOTBJaVRVWTgwVzJiYXM4M1RNaFJR?=
 =?utf-8?B?cGE5ZDVacllldGtacmp5c0lCbmVQOWhkeFJ6ZWl4TnI0MFpWSFZGNkM2SDJy?=
 =?utf-8?B?V08zenpjdTVGZ0xMM2RSalZhYVdnUVo0TmZQTVprTzB1VE9EeFpKNnJ6Y1k0?=
 =?utf-8?B?K25uYnFaU1hsZCs0cHVJVjYyZFZCV1owd0VNYnJpNWF3Q1JpYmIvZVlCUk1V?=
 =?utf-8?B?MW5yeHcwUStid09pQzhmVHRnTmwxSGNiMkFhQkhpY1FLSTBXeElQUWtBNjFv?=
 =?utf-8?B?dEtUUWFNK05kRkhBbVBtU2xhclhWVy9qZ3MzYXllNjFDRU9VZW9DMnFieW5P?=
 =?utf-8?B?VVdRRFJaNFBqK0l3aElKZkc0L1g1Q28vRjhrUE01NnlWek9TSHFCYTU4aUlP?=
 =?utf-8?B?VFBUcVBLT3lRKzNtd2ZQVUd6NXYweDgyNUFyaXVwMTRqeDZUUzFSdFFrVmhP?=
 =?utf-8?B?R1haRHE4NnpCek9QWGREV2pOQkhTZDZwdVZWOTVnbGFpSkhPZGRyamJlQjR5?=
 =?utf-8?B?UkNmNTQwbmpWRE9VNVhaVzdkU2FwSUVranEzdUhPcUlTdTdLMS9nU2t2anF4?=
 =?utf-8?B?ME5ReFJndWdEcjZhVlVvZnJjeHhneEl6M2gvS1hjZm9PVDNiTkVOU2FubW5N?=
 =?utf-8?B?aW9nQ0lIWHVUYTYxYUJ1SzdWTC9Rd2E3RkVYTUdqM3lvM0pYampic21jbG5W?=
 =?utf-8?B?ZGlnQ2FTd0E1ZlJpeDdJaHNOY1prZ2lhdFZZS2NXalVDR01GckVmZTMvMjhX?=
 =?utf-8?B?Y056WGxuQUpEQVRZb1dmQjcyWVR2N09yMDVsS1Fwdll1aEtuNE9scXNabTdy?=
 =?utf-8?B?c0Q0cWo4dEVMVzFMODB5ZWxGaTZreGlZL2MyKytKSC9ab3RPcnI5ejdaL0dp?=
 =?utf-8?B?aXdFUjR4L1pLVDlzM1ZFV29mYzVIUUx1a2VrVDJsYjhPNGdiRmVQdUhDVmI4?=
 =?utf-8?B?Qk5zcXJqMGVvWnREbXkwY3pMd05CM1QwWm9EOGFNQXQvbUc4WGtzNHA4K3p1?=
 =?utf-8?B?MFlHQk42S3U1WHF0NUFGK0RVSU1iazlYUG12ODVibU5QQUYwV1ZlOHhFVVpn?=
 =?utf-8?B?Z0hlL2lldGxoWGk4cENXQ3UwTWc5S044TFQ3c1psS2UvVjBFYWtGZmdyTjZp?=
 =?utf-8?B?ditnZjB5a0phMjM2b3M0dnVrRjZ1aW9TRGRaMGc1blA3S0QwcmF3VmdTQ2FI?=
 =?utf-8?B?NHFBMDdyV2U1aVVyUzFKRU1Tbmd2NkU4Y0tCU3VsSE95N3d1eFFEZjhrc2Fx?=
 =?utf-8?B?eUdhTHZjOXMrcGZMa1dwODkrdUhWM1FQeGVoQXZ1WGN6KzhsVUMydDdpRGYw?=
 =?utf-8?B?Z0k0Unp6UHZIN2lTQjJ2VkZURDN0b2ZHd0lYZ09WMVFJL0JXNzk4bDdvTTB6?=
 =?utf-8?B?VHYxSGhwRVJpM000b0dwMGY1QlVFWDdNSW44QWxHV1BUdnlxdzVxWXFXTG14?=
 =?utf-8?Q?Yptb1XFiVuW/1qCt5A2u8FDg2TMFrmLXKyCjAnu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ce2bb6-f128-4a4a-394f-08d9750d75c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2021 10:18:11.8744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r7nXOjZAj+rO6B0mx663qs8HEflVbCr0tWp1R6Skygjswwr/DV6/YUnT8XZQwSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRm9yIHRoZSBwb3NzaWJsZSBkZWFkbG9jaywgd2Ug
Y2FuIGp1c3QgbW92ZSBmbHVzaF9kZWxheWVkX3dvcmsgYWJvdmUgZG93bl93cml0ZS4gbm90IGEg
YmlnIHRoaW5nLg0KQnV0IEkgYW0gbm90IGF3YXJlIHdoeSBkZWxheWVkIGluaXQgd29yayB3b3Vs
ZCB0cnkgdG8gbG9jayByZXNldF9zZW0uDQoNCmRlbGF5ZWQgaW5pdCB3b3JrIGlzIGVucXVldWVk
IHdoZW4gZGV2aWNlIHJlc3VtZS4gSXQgY2FsbHMgYW1kZ3B1X2liX3JpbmdfdGVzdHMgZGlyZWN0
bHkuIFdlIG5lZWQgb25lIHN5bmMgbWV0aG9kLg0KQnV0IEkgc2VlIGRldmljZSByZXN1bWUgaXRz
ZWxmIHdvdWQgZmx1c2ggaXQuIFNvIHRoZXJlIGlzIG5vIHJhY2UgYmV0d2VlbiB0aGVtIGFzIHVz
ZXJzcGFjZSBpcyBzdGlsbCBmcmVlemVkLg0KDQpJIHdpbGwgZHJvcCB0aGlzIGZsdXNoIGluIFYy
Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K5Y+R5Lu25Lq6OiBD
aHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCuWPkemA
geaXtumXtDogMjAyMeW5tDnmnIgxMeaXpSAxNTo0NQ0K5pS25Lu25Lq6OiBQYW4sIFhpbmh1aTsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCuaKhOmAgTogRGV1Y2hlciwgQWxleGFuZGVy
OyBLb2VuaWcsIENocmlzdGlhbg0K5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
YSByYWNlIG9mIElCIHRlc3QNCg0KDQoNCkFtIDExLjA5LjIxIHVtIDAzOjU1IHNjaHJpZWIgeGlu
aHVpIHBhbjoNCj4gRGlyZWN0IElCIHN1Ym1pc3Npb24gc2hvdWxkIGJlIGV4Y2x1c2l2ZS4gU28g
dXNlIHdyaXRlIGxvY2suDQo+DQo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5w
YW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYyB8IDkgKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGVidWdmcy5jDQo+IGluZGV4IDE5MzIzYjRjY2U3Yi4uYWNiZTAyOTI4NzkxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gQEAg
LTEzNTgsMTAgKzEzNTgsMTUgQEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc190ZXN0X2liX3No
b3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp1bnVzZWQpDQo+ICAgICAgIH0NCj4NCj4gICAg
ICAgLyogQXZvaWQgYWNjaWRlbnRseSB1bnBhcmtpbmcgdGhlIHNjaGVkIHRocmVhZCBkdXJpbmcg
R1BVIHJlc2V0ICovDQo+IC0gICAgIHIgPSBkb3duX3JlYWRfa2lsbGFibGUoJmFkZXYtPnJlc2V0
X3NlbSk7DQo+ICsgICAgIHIgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZhZGV2LT5yZXNldF9zZW0p
Ow0KPiAgICAgICBpZiAocikNCj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4NCj4gKyAgICAg
LyogQXZvaWQgY29uY3VycmVudGx5IElCIHRlc3QgYnV0IG5vdCBjYW5jZWwgaXQgYXMgSSBkb24n
dCBrbm93IHdoZXRoZXIgd2UNCj4gKyAgICAgICogd291bGQgYWRkIG1vcmUgY29kZSBpbiB0aGUg
ZGVsYXllZCBpbml0IHdvcmsuDQo+ICsgICAgICAqLw0KPiArICAgICBmbHVzaF9kZWxheWVkX3dv
cmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsNCj4gKw0KDQpUaGF0IHdvbid0IHdvcmsuIEl0
J3MgYXQgbGVhc3QgdGhlb3JldGljYWwgcG9zc2libGUgdGhhdCB0aGUgZGVsYXllZA0KaW5pdCB3
b3JrIHdhaXRzIGZvciB0aGUgcmVzZXRfc2VtIHdoaWNoIHdlIGFyZSBob2xkaW5nIGhlcmUuDQoN
ClZlcnkgdW5saWtlbHkgdG8gaGFwcGVuLCBidXQgbG9ja2RlcCBtaWdodCBiZSBhYmxlIHRvIHBv
aW50IHRoYXQgb3V0DQp3aXRoIGEgbmljZSBiYWNrdHJhY2UgaW4gdGhlIGxvZ3MuDQoNCk9uIHRo
ZSBvdGhlciBoYW5kIGRlbGF5ZWQgaW5pdCB3b3JrIGFuZCBkaXJlY3QgSUIgdGVzdCB0aHJvdWdo
IHRoaXMNCmludGVyZmFjZSBzaG91bGQgd29yayBhdCB0aGUgc2FtZSB0aW1lLCBzbyBJIHdvdWxk
IGp1c3QgZHJvcCBpdC4NCg0KQ2hyaXN0aWFuLg0KDQo+ICAgICAgIC8qIGhvbGQgb24gdGhlIHNj
aGVkdWxlciAqLw0KPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgaSsr
KSB7DQo+ICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmlu
Z3NbaV07DQo+IEBAIC0xMzg3LDcgKzEzOTIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2Zz
X3Rlc3RfaWJfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnVudXNlZCkNCj4gICAgICAg
ICAgICAgICBrdGhyZWFkX3VucGFyayhyaW5nLT5zY2hlZC50aHJlYWQpOw0KPiAgICAgICB9DQo+
DQo+IC0gICAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7DQo+ICsgICAgIHVwX3dyaXRlKCZh
ZGV2LT5yZXNldF9zZW0pOw0KPg0KPiAgICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRl
di0+ZGV2KTsNCj4gICAgICAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2LT5kZXYpOw0K
DQo=
