Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 17:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11884611C0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 17:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11884611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59386EC72;
	Fri,  5 Nov 2021 17:59:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304116EC72
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 17:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nThzJNJ2UADHPK68EdrbeefMM7Y8hEJjIHzX8IQu2qVOB0D4tSlPUmPUi2vb7F1lrz/Xc0sfRzVM8B7q209a25sF29yPWk69FBTLuEqRtLarTJCUMVDKh7ezW2H+JlF1e0eDeu4tPDMNDTqY5dqnDjj4GhrPNpAmOmxwv6kSrIQInhAmewimyD4Gnu5YPWJXvjSfFORAf0tLlYf4ohDIXFN3fy0HHgJkhuDfE0GVwnaHYCyzEL2qo4TCUWJz+a7VrAgx0R0PXDYGXBX/5nRdJfC7Lb/pLGoZ+aYJDNoyLtfbUAHstsvbqK0CMcYtoDzDwcFx63y5Y+tlkvUpuvYgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g23BdUNUJSShBgfiCaAzEfWhsIoyMk5VWi56knPXKjI=;
 b=jlVmDEPTKDxQ9IpWH5acKIZnaFS2LWWW58w65BWBsYn/daEsIwAPoJtue2usru7F6Ysw2sD+mzapb5AOxgBwUWdZX0KuV1N4A6jPQOhkfV8tH06fm4KfTBt5ZyVp5xZjCNt9QevW3m+UiHFJChuRUvTE/bXhV4q5JVWBEu8mgTcDHVrUFDP6azP9QPczJjQ9fuabqMnPG5DRO3s9DkyeD6kea1JhrGlsF8VCNzaWmiIwBr5DDwZ4snNXgw7RKTTgEA6MyWeh4fYllEnghl3sxLr2jjrr2OhybRUvB8ZjbGiSSFqGYittGTd6th13r7rUTbVLKfOYt8SnWvZwU0HnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g23BdUNUJSShBgfiCaAzEfWhsIoyMk5VWi56knPXKjI=;
 b=QDOsz/Foo1IRTwfuMN96uvQ8HwSN820FJesdNMGx2DX2gHcS13Lt+pE7yvGf7j8j78vy4gz6mcWAtcH9kr/A7xqgCp7lPzMy/juf+9nb3YDtMEkgeihhqSpJ1Zm/XMd/+uubNPRUFxGWomWPTje+ZT98Z47ojNc3Uvw3eQkUY+E=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 17:59:28 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::6801:240a:24c3:cda4]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::6801:240a:24c3:cda4%4]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 17:59:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
Thread-Index: AQHX0mZHjUQ0BNmicUSjo5/2ieE546v1NdUAgAAB7BA=
Date: Fri, 5 Nov 2021 17:59:28 +0000
Message-ID: <DM6PR12MB55345EA86293817DE5B71C6EF48E9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20211105165741.2617-1-shaoyun.liu@amd.com>
 <3b5fe2ba-d03c-b2ca-df69-f7b27dfd4ce7@amd.com>
In-Reply-To: <3b5fe2ba-d03c-b2ca-df69-f7b27dfd4ce7@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-05T17:59:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=497186fa-824c-4974-b128-f6d5e9133c9e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5dedbb0-ff1e-47b2-5270-08d9a08602f0
x-ms-traffictypediagnostic: DM4PR12MB5053:
x-microsoft-antispam-prvs: <DM4PR12MB505342578353C50D707824ACF48E9@DM4PR12MB5053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47eGf7eeMqJHE7/C8rNTHv5bPW7AbMsqMNGshsC3c8YG+i38tQzwX/4u5Oizu+xnQxQ0vhI+Cmr8AtEmpS1+c6AxKXBh/PHc1Fw4DeGURat6EbJMmFPTtmTsXmZRNoGiuexnq7k2JZkQK99WEhxyCVxrfWIpC8m0JWjBGkiHX1HMUsqnfyI1VGlPeSLWwYaW97wCP2q2ZrmjBJSU2B8GET5U7BtlrOOKoV+V6b2oPO+W8tXYbqhVrhyQ9j0nLZ6AXNhEy/doD2IIspvn2FZN/ctteRm2T0us4o7o3uBbJ2PMm4SfSf/da9XaVW+fYevmrKnFa4UC56c3e/zz4g6qKameb/6QyhJ5nrlHtCrc9Px5CRJJyePldJeFFfQ/Zwlavw0j3ttG7hNoa83+Q55QAmkGn0LM8I6k8/rHfTHSGUHzbJ047INSyWAjKCTChRFwrTBEb6hk7Nk32XtTmjXCrZw3iGOOEwW91x1SP8rwfxYlHYzdt5LahTtPR4Y8L8R8Cqq8PyvAoaz/wdSXBZVUvbsQqY3o/6dd4AuFOuGjuNBOAy/1zU3PM/AgPio2tKEr7/QVJa0c29yf6uBrhMGdHTVb/A47B1t89FurNljR7O+ReebuKW6+oNjXQ3X/U5m0mLyWsvK44ixWoFOQLfKzkmmZjsd+XVbRD7d3lQI1jcRm4o163Wfc9l0zf/nIQFAXbPzdKBAyJOlWeqQsIwCMNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(53546011)(7696005)(86362001)(5660300002)(26005)(186003)(52536014)(6506007)(8676002)(76116006)(2906002)(55016002)(9686003)(122000001)(33656002)(110136005)(66476007)(66556008)(316002)(66446008)(64756008)(508600001)(71200400001)(83380400001)(8936002)(38100700002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVcyUjBTN0VBYTdlZkxNSGdCZm00ZWJvd25CRk1WYW5CRzZGYWYrRS9ZaXVi?=
 =?utf-8?B?emtueVZxN050MTRVY3pORjV4UkNwYUxUa284ZVN5V2laK0lZQTBxeHBHWkZR?=
 =?utf-8?B?a3lLQkZrZGljRFBMQXJkNmJ3VTY3cW83b3QyeXV0NkdzbDFxWkJSbStJNXoy?=
 =?utf-8?B?Yk0wTWNXVGdCeVFFcVBTSllDSk5ENjhzRnphU0xtNHdGQzNqbmtOT3NqQnov?=
 =?utf-8?B?cFhQd1pQYXJGM1dNTktQaUxOMDcvNWNLNWZiYzVBK1EvTGl1V1NXMTFaNCtl?=
 =?utf-8?B?QWY5Sml4bGxWczRhbjdUYm5NNTg5K0hUTkp0Z1lRcHlLQ0lIQlJkOEZZcnpC?=
 =?utf-8?B?emg1dmRyMVlKOWlQV25mRjdaR0FQd2gzbUdIU3RkdEdoVHBDVHJ3SHlaRWQz?=
 =?utf-8?B?VTZIbkFWWk5zYm1Ea041Umo4YjgwM05ZdmJHRlJiSEl1ZTBOdCtGWUhlTDJF?=
 =?utf-8?B?dlVESjZLdEc1YTlmYlB4QnhudjIwTG82VmNycjRRR21SNTRPU3VraE1DUFRM?=
 =?utf-8?B?YXlYL3JaZnhJK2dNcENmaW4yc3F1QXM2ZmJMa1RFbHpqTFRUYlZvQXczSEg1?=
 =?utf-8?B?aVZkdGdjK1lJRnJtTUdKdjRaR3Vrcm8zaVozVXhMelA1M0psdjZGZVN2SEpM?=
 =?utf-8?B?WldKaUxpVS9KVWNheS9sZVV0RTVHbWIycmRLalRicnlSSzVxRHBmYXhmejQv?=
 =?utf-8?B?ZFdYNHVqZnh3MGlUajh6M2twbzg4eDBKQ1o3S1BiWXMxL0NwS0NqWCtDV1NF?=
 =?utf-8?B?dWFMTXRnTXlDb0U5aGJ5bFpTQWFyaU1FdkNTNHFvdjErZGNwMFF5b0Z2MHhq?=
 =?utf-8?B?QXp5LzhpV0d6bTJRM21xdEhFQVpMZlQ0WHlwT293OUR4VWhDdmFCN2hHdHVp?=
 =?utf-8?B?czV3L1JNSVRXdUtiam9JQUltRStIdnJFNGlLdm5PS2tuMnBjSktBTkxWenk2?=
 =?utf-8?B?Vnh1NTUreEgrcnpvSnNiazdnWlJpMHdtMUptR1VOS2NnenV5MEVUVlBrWkJH?=
 =?utf-8?B?Y1p5aFU0ZmRZNVc4ZDFxZEdvSkFMWE9tKytzOGJxYmNiVHplMEM1M0sycmNw?=
 =?utf-8?B?Q0ZabzBmOUFQZ3owcndEdUNKb2pvSkh1NWUvUUxsLzUrc2dhbTlGdHc4QWN0?=
 =?utf-8?B?cnRFUUdSc1N5WWgvbUNzVVRoelpoZk16ZEExL1gwVkRyTnViTlp0TDNlZUMw?=
 =?utf-8?B?VGF1WFFTT0dseUpnQUhXRU9wVTlKSGQzd3dzUTNzK2JWMkUwMEdVanp5aTBM?=
 =?utf-8?B?cGJlRkxkbEVUMXhaS1NmcUNFQWd2QWoxZkhVdk02V2NOb1hjbHZQdHQ1Szg4?=
 =?utf-8?B?bEFVSXpuNDhTbU5xaFpwZTFMb28vUFBoWndsUjJ4WGtzUW1EQjBBaFovTzUy?=
 =?utf-8?B?VUZnd0F1YmNhOHF6cU5ZSTE0UGoyem5BMDN1MWUyeGpoY3pnUHlHNEZGN3lB?=
 =?utf-8?B?ZXRvZjhTbkpoMk9hOUp5bEU3VFM3RHlmY0FXcG1qYkR3a2NZVkM3aEg1YmlI?=
 =?utf-8?B?ek83YVRwTEpERVBYbHI4RG1lMGFHdFZ5UjZ0UDFhZGc5T1l1eFgwQmdNNTZ1?=
 =?utf-8?B?Y05UNnRvSFVYRHdVUytJWlJ0aU04b1hhR0tHSXJRL0graEFSQkhIeEdNcloz?=
 =?utf-8?B?Wk5SeGFXWFZ2SG1OTW9zY3h1dk9IcVdwZXU3bkV3Qy9Sb0RMSWRKdXJWekxO?=
 =?utf-8?B?U0Q2ZFQ1VWZxbklFTmQvY0duMnA5MkxoTTYwbWhsTGNQbTJRRG1OR2U1ZTRI?=
 =?utf-8?B?VDFFL0VtN29DUFFFa2k0SmtVMDRRY0tVaDdkWENDbWdRSS8wclgvYVp3WFYx?=
 =?utf-8?B?K3JUVlRvZEd4VzhqQWJUVWR1ZWdya2xqRjVGVStBZGVCNFFpcnd1TUVETldQ?=
 =?utf-8?B?T0FUbk5LbFhrbWI0WFoxVUh1ZUIwdlV3WWp5TzFXR1VOMUoxZ1YzMTN0bnZC?=
 =?utf-8?B?Mit4SjYyTmNyZlFZMlY0RGNSSlBsNUxlYU5qRSsxc2lYdzZRZThSeXJ6bGZr?=
 =?utf-8?B?RG9pYmk0anFPYXd6TXFpOXovYXphZlM5VjdZNW1US2tJc0xTcFdSeWZJQmdJ?=
 =?utf-8?B?NHMwVjZVdG9sMVlSMy82eE51d1pmYWhCdTd2c0EvWVNKTW1xQ0ZmaUFvNTBE?=
 =?utf-8?B?bklyT1l1RmhoS1lEZ0tZblNNeFRmb3VXekR6czBLNU1vMThoVXRGUGNKWGZq?=
 =?utf-8?Q?lcCQb7JQdj7dAVMyVB37tks=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dedbb0-ff1e-47b2-5270-08d9a08602f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 17:59:28.3498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENqfXF22604snk6uDK80X3XG2z23auuwcUPMj2EuGV8t2qTwUTb59ZTHor31LWtyqs59M/JsF+TxhiwHuUriaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KWWUsIGEgbG90IGFscmVhZHkgYmVlbiBjaGFuZ2Vk
IHNpbmNlIHRoZW4gLCBub3cgdGhlICBwcmVfcmVzZXQgYW5kICBwb3N0X3Jlc2V0IG5vdCBpbiB0
aGUgIGxvY2svdW5sb2NrIGFueW1vcmUuICBXaXRoICBteSBwcmV2aW91cyBjaGFuZ2UgLCB3ZSBt
YWtlIGtmZF9wcmVfcmVzZXQgIGF2b2lkIHRvdWNoICBIVyAuIE5vdyBpdCdzIHB1cmUgU1cgaGFu
ZGxpbmcgLCBzaG91bGQgYmUgc2FmZSAgdG8gYmUgbW92ZWQgb3V0IG9mIHRoZSBmdWxsIGFjY2Vz
cyAuIA0KQW55d2F5LCB0aGFua3MgdG8gYnJpbmcgdGhpcyB1cCwgaXQgd2lsbCByZW1pbmQgdXMg
dG8gdmVyaWZ5IG9uIHRoZSAgWEdNSSBjb25maWd1cmF0aW9uIG9uIFNSSU9WLiANCg0KUmVnYXJk
cw0Kc2hhb3l1bi5saXUgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogRnJpZGF5LCBOb3Zl
bWJlciA1LCAyMDIxIDE6NDggUE0NClRvOiBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZC9hbWRncHU6IGZpeCB0aGUga2ZkIHByZV9yZXNldCBzZXF1ZW5jZSBpbiBzcmlvdg0K
DQpUaGVyZSB3YXMgYSByZWFzb24gd2h5IHByZV9yZXNldCB3YXMgZG9uZSBkaWZmZXJlbnRseSBv
biBTUklPVi4gSG93ZXZlciwgdGhlIGNvZGUgaGFzIGNoYW5nZWQgYSBsb3Qgc2luY2UgdGhlbi4g
SXMgdGhpcyBjb25jZXJuIHN0aWxsIHZhbGlkPw0KDQo+IGNvbW1pdCA3YjE4NGIwMDYxODUyMTVk
YWY0ZTkxMWY4ZGUyMTI5NjRjOTlhNTE0DQo+IEF1dGhvcjogd2VudGFsb3UgPFdlbnRhby5Mb3VA
YW1kLmNvbT4NCj4gRGF0ZTrCoMKgIEZyaSBEZWMgNyAxMzo1MzoxOCAyMDE4ICswODAwDQo+DQo+
IMKgwqDCoCBkcm0vYW1kZ3B1OiBrZmRfcHJlX3Jlc2V0IG91dHNpZGUgcmVxX2Z1bGxfZ3B1IGNh
dXNlIHNyaW92IGhhbmcNCj4NCj4gwqDCoMKgIFhHTUkgaGl2ZSBwdXQga2ZkX3ByZV9yZXNldCBp
bnRvIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2LA0KPiDCoMKgwqAgYnV0IG91dHNpZGUgcmVxX2Z1
bGxfZ3B1IG9mIHNyaW92Lg0KPiDCoMKgwqAgSXQgd291bGQgbWFrZSBzcmlvdiBoYW5nIGR1cmlu
ZyByZXNldC4NCj4NCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFdlbnRhbyBMb3UgPFdlbnRhby5M
b3VAYW1kLmNvbT4NCj4gwqDCoMKgIFJldmlld2VkLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5M
aXVAYW1kLmNvbT4NCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KDQpPbiAyMDIxLTEx
LTA1IDEyOjU3IHAubS4sIHNoYW95dW5sIHdyb3RlOg0KPiBUaGUgS0ZEIHByZV9yZXNldCBzaG91
bGQgYmUgY2FsbGVkIGJlZm9yZSByZXNldCBiZWVuIGV4ZWN1dGVkLCBpdCB3aWxsIA0KPiBob2xk
IHRoZSBsb2NrIHRvIHByZXZlbnQgb3RoZXIgcm9jbSBwcm9jZXNzIHRvIHNlbnQgdGhlIHBhY2ts
YWdlIHRvIA0KPiBoaXEgZHVyaW5nIGhvc3QgZXhlY3V0ZSB0aGUgcmVhbCByZXNldCBvbiB0aGUg
SFcNCj4NCj4gU2lnbmVkLW9mZi1ieTogc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFtZC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUg
Ky0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
IGluZGV4IDk1ZmVjMzZlMzg1ZS4uZDdjOWRjZTE3Y2FkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00Mjc4LDggKzQyNzgsNiBAQCBz
dGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfcmVzZXRfc3Jpb3Yoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAgCWlmIChyKQ0KPiAgIAkJcmV0dXJuIHI7DQo+ICAgDQo+IC0JYW1kZ3B1X2Ft
ZGtmZF9wcmVfcmVzZXQoYWRldik7DQo+IC0NCj4gICAJLyogUmVzdW1lIElQIHByaW9yIHRvIFNN
QyAqLw0KPiAgIAlyID0gYW1kZ3B1X2RldmljZV9pcF9yZWluaXRfZWFybHlfc3Jpb3YoYWRldik7
DQo+ICAgCWlmIChyKQ0KPiBAQCAtNTAxNSw4ICs1MDEzLDcgQEAgaW50IGFtZGdwdV9kZXZpY2Vf
Z3B1X3JlY292ZXIoc3RydWN0IA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIA0KPiAgIAkJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ0bXBfYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOw0K
PiAgIA0KPiAtCQlpZiAoIWFtZGdwdV9zcmlvdl92Zih0bXBfYWRldikpDQo+IC0JCQlhbWRncHVf
YW1ka2ZkX3ByZV9yZXNldCh0bXBfYWRldik7DQo+ICsJCWFtZGdwdV9hbWRrZmRfcHJlX3Jlc2V0
KHRtcF9hZGV2KTsNCj4gICANCj4gICAJCS8qDQo+ICAgCQkgKiBNYXJrIHRoZXNlIEFTSUNzIHRv
IGJlIHJlc2V0ZWQgYXMgdW50cmFja2VkIGZpcnN0DQo=
