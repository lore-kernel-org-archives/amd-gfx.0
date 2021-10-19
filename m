Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B761C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC04610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DC04610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB94B6E84B;
	Tue, 19 Oct 2021 18:22:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5586E84B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms00MFHFujS79r7se4cbirGtjmDkgtAO+PvOMxRp1hTYszHz/ZMcRvXvrBoPWdOs3jKy2jThL2l3flolG71YJ9sdCkJBZNNr8/Tb3ciNK+2Wm8aNIdIdZuCQgJFvcHwnwDgh7y27YhHyx2tQCnwHB6YyFVkDVqGvZwEiUIFNyuYhaXwA6p27k1u5acsAx5jjSssaaeC6J3BHOuA7ckp6gPzHGUktl8HxJ9mfFo2+c3bAUqyBVhBIKsHrgPIRLKB3InaDZ5OpHhj+OwIh//qtSbw2c1DciSXevAK/xdJEEjyOUtiPXQockoqTtFtyRuk7mN6l+PUuCvxe5BGxVXMKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxCeErCCkj5+MtqhKMrBgeTkJvp6Au0k++E/L6AXhAw=;
 b=P/HlS8ZlM12wZ5e3G7XWY3xJXFmMTrcMQ9DIJOxLvGNHrHcmQiSARjRzxTIfokphBOa6Z/g5iwM895xSDxlqIdKwprEHw0fK2D6J4Gm+Z4HLT2TdF7eKKkz0PR4FQwkyPLPMOxtHNfcHjk4YYcdfyF9g7EZdnNMMW2MFlpZA6R7QJsDwQJFCFTddJF0KPDf/cnHltOXWPhokTJiwEdqe8iLYBHIxXyG88v0GfwtfvFR/t/wnQrywhCHngh8BfG24ysQdjfC1EZ6yrivoJVb/HQ+gSrb1icwxeFLUCbRij/dmWTcU88FqE7GLHl48wWEXQTFunU1x69AeBfx9nsMFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxCeErCCkj5+MtqhKMrBgeTkJvp6Au0k++E/L6AXhAw=;
 b=huxQqDA4Rwv0QHhF+gFZ35ZuS55qnONUIytBM8fDnss1M/yPN4GjkffpSzuJ+Lz96zgEKQQkwoPgpAiPVn5UtiBVCAU1MVx5jZbWsPmvgXOmhQ1mKBdBZLuMNJhMYcOK7C9eh5Tdm3dpbLIbYd3W+eDSMBnUb/fzWv1p3/ciBtg=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:22:23 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:22:23 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
Thread-Topic: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
Thread-Index: AQHXxRHiTRUzuuQltka6eVaOiI/pYavanoSAgAADwYA=
Date: Tue, 19 Oct 2021 18:22:22 +0000
Message-ID: <DM6PR12MB3324F45AD12D4D86590917C585BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <c51879d3-5434-d8c1-aab2-471ed1ab6931@amd.com>
In-Reply-To: <c51879d3-5434-d8c1-aab2-471ed1ab6931@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-19T18:22:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=67d48bc3-c6f3-4e1b-95ac-d5195037839c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5400da9c-41ea-4da1-9f56-08d9932d6532
x-ms-traffictypediagnostic: DM6PR12MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB375387F6C31BBA4B9B5CE2B285BD9@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2uO87l3w5CZ/yiwu+kqEsNrpJUKP8GVLdO3zyCusyEFzW4aNdIjTvnzBlirlFNq5hsxPnKzZt7oIMgDoHjluTBzHCQl0/dOLQU40sEVDIcZlW07CyFTEM7t+umpOQFWaELUMlPYg1/mzoEygC0vpYG5Zm7xSvU8bYune3r/BXGIuujv1QdDYEyVoPZ5RnlJDt1y2Pcv732lZXsSH/hk/kLTrqMbnjmSZcPD6mBa65oJ1pdsvO2/QuCofC580o8+1VD+peOOHgKBqmxnqxZI0czadystyiMjOg4vMPcFUDSSRKxyugdVXPaZv/02tuEer8Q9mOhNcuISQatIjG8rn6moH1XxwlrGILOfXQNC4y6duVy+FkPnPNB90x6s4jjIZhLsXENy8kx3BcXWnJZGbdclxGQl/hr8Cn0bvUYHLqmLATPfkDMGhqnZH1KfJu7KRuUafRMgwLm1R5YRj42e0R3gfg5UVtqX6H3ymkG2urOoZAPMfU1v9zQzxB728+fVr+DdwAVspvU2UwWOVHq05WRvGuoSmY4NE78OQZO6ETWJUWfx7MAPC+9O6y09Vs3A0Fj7/hknFc8HnEOFOle1IeuuEaRZmaWQTf6UjaaKUaxoAvkB4CcSwLl/kvrHrmc3BvfjOZ4nsGu8LakBhwLiLk8tUWXMohSElGZSZAEsqDWBeJQFe+Mb1amFoswPrEKe6NyVUC+lT+HPlTRH5xtyBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(71200400001)(26005)(76116006)(122000001)(66446008)(6506007)(66556008)(64756008)(52536014)(38070700005)(2906002)(186003)(5660300002)(83380400001)(8676002)(86362001)(53546011)(7696005)(8936002)(55016002)(4326008)(33656002)(110136005)(38100700002)(54906003)(66476007)(66946007)(4001150100001)(9686003)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0ZwaU84SnFOZ2RubW16QlBlUnlUQzhNMDVLbmdKUk9JWWxYN0F0L1QyWjZX?=
 =?utf-8?B?Nml3cktScmg1VVJkYWlyeC9yYzZZR1pXaHNNNXJRSE41cDlpNUdseHlGRzc5?=
 =?utf-8?B?N1BvK2Vhb2dldHpEV1lIVGFlZnJVN0JEY0Z5dXJZbHNkdjNTSXRuVllwdlpu?=
 =?utf-8?B?Q1lQK1hTZktBWHRCZHAwaGM3NTdjU1JtaEZvZG81TTd2N1dMNzVubWFMem9E?=
 =?utf-8?B?clFCMmFkd29WNVhWTi8wamRBYWxGWitoZzdBUDN3RVlZRlE2RCs1T3FyMXI5?=
 =?utf-8?B?N0NBc3hXSEhteXpHZU5sY0VPY1JTSkdJT3dxcEtCNUIzTFI3SlZxWERVajh6?=
 =?utf-8?B?VHNKN1V1byt6VDJKSkp1V1dKQm1wQ05Ga3lKVjBWdnJQeGhBak4wSVd6Tmh1?=
 =?utf-8?B?dUhSclkrbElWYzkzOUo0aFRaTkIycGN4MHEyREVkU0lKb2FHOS9WbkJWYVg3?=
 =?utf-8?B?NVF0cTNpakF5UEVVTG16K0h3cjlhSUtDdEI0VVhCOFZySVk4a25TNjJHVThQ?=
 =?utf-8?B?clJsWDZOd1poNWxPdjFHaG9XMnpWN2xzdk5YZmtnZXVWbjJqYlFSYW9EWkRx?=
 =?utf-8?B?bGdUTUJtYlpVaWs4QU9EdGpaZEQ1Q3R2SjhXQktZc0hZZmgrclkwMWFCdlpJ?=
 =?utf-8?B?dVhxblAvVDc0VmhLT0VGZUJtRC9RNmFCNXBiekVqMER4dWEwRDNXV0hld3R1?=
 =?utf-8?B?NnNQK3NpTE5tV3VpbGtUSUlIb0U5VzY4VjM5Y3ExOEhuYlJrMlNlVGpxUEZT?=
 =?utf-8?B?MlFuRFRIR1dnSzk2bGZaY2UvbHZaRytlTWFiOUlHdGpVY2NZaWM2bEtiVmd6?=
 =?utf-8?B?OXpIVkxteHE0WFhHeStscEtpNXByUDNMRGNtMlNEVGI4N2Jvei9tbTQwbFlx?=
 =?utf-8?B?b0V0KzlVTmVBRHFmVTVobkJ0RkdlTGtiY0ZZajZqcDA0bTlIeXZFclhYU2Y0?=
 =?utf-8?B?VHRVMUcyYytLaGRGcnIybWxrVng0UEJNdmZJcmN6cWZsWmtZWWsyOFQxRjRy?=
 =?utf-8?B?cHpJeFJtcXIzUk1zNGxlSnFCQzczUDhWVEd6ZGh3d29TTjFqek5BNjJaQmR5?=
 =?utf-8?B?TG1oOGsvWDM5cXc5WVFsd0tyWWx0Tkh4R1BjUEZUQ3Y0NDZpdlpBd1BjWEpI?=
 =?utf-8?B?ajBiUDVNT1dBQWUyWXBhTGl1eTZPSWt6aC9YTStQRU5IMkZ6UEp4cys0Lzdv?=
 =?utf-8?B?ejBpak9VTTVDdUZQNWlKTlMyZmZ4TEhENUV1YlRyMCtMdVNHbnVWS1pzdnQ2?=
 =?utf-8?B?eWk1VFFqTHRhMGx1ZFgrenFGTEVDcEFaM0dVMjlGMS9jTTFnU3RvQmNob1Fa?=
 =?utf-8?B?YUFHWG53RkdmdlNDdGNKY0t1NFVlMWRzY3oxdjV3T0xSSnZFbWsxaDBFdmZI?=
 =?utf-8?B?QWpGTWp6VUZVUTBRK3lRS3ZsTXpFQ2xmd2F1SDZhTHZiWEx3dVl1K3hXM2s3?=
 =?utf-8?B?aDN1L2hVTm91ZEdRTTZJYVN4OVQ1alNIaStvS3JqRGQxY3h2elNrbjBuMHU2?=
 =?utf-8?B?TDcrdFJqdGVvZkRIdDd2U0FNcnYxUUFVeWZ5YllhS1pDa0x1Qk5JS3g1K3or?=
 =?utf-8?B?MXlZeCtRMkpBSzMzSUpmK2xEQk1hakpoNy9TS3NZR3MxUnVLYmNFbTN3OTZF?=
 =?utf-8?B?NDhKMTI5TThWUTFWUDhnUHcvT3hxem9ycS9sTm9peUt4M1gwaEltaGJtZmpQ?=
 =?utf-8?B?eXBTcVhJakNBb0UyZGw1YzJhd3BOUEVGT2M4dEhmcmdLa2JJYzd4RkptS3pk?=
 =?utf-8?Q?CyDeIE3fIqo/4RTEZSqRo8yQd4kgGwuG0WhSrnY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5400da9c-41ea-4da1-9f56-08d9932d6532
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 18:22:22.9134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxRCFHrGEi2TmRPNACaR9Kp7FsbGvC+k+vzBaN2YVM9SetlFutNbvm3zUF55nZLWZUm4AnofDnQ9V2/kjpVcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDI6MDkgUE0NCj4gVG86IFJ1c3NlbGwsIEtl
bnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgSm9zaGksIE11a3Vs
IDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHJtL2Ft
ZGdwdTogV2FybiB3aGVuIGJhZCBwYWdlcyBhcHByb2FjaGVzIHRocmVzaG9sZA0KPiANCj4gQW0g
MjAyMS0xMC0xOSB1bSAxOjUwIHAubS4gc2NocmllYiBLZW50IFJ1c3NlbGw6DQo+ID4gQ3VycmVu
dGx5IGRtZXNnIGRvZXNuJ3Qgd2FybiB3aGVuIHRoZSBudW1iZXIgb2YgYmFkIHBhZ2VzIGFwcHJv
YWNoZXMgdGhlDQo+ID4gdGhyZXNob2xkIGZvciBwYWdlIHJldGlyZW1lbnQuIFdBUk4gd2hlbiB0
aGUgbnVtYmVyIG9mIGJhZCBwYWdlcw0KPiA+IGlzIGF0IDkwJSBvciBncmVhdGVyIGZvciBlYXNp
ZXIgY2hlY2tzIGFuZCBwbGFubmluZywgaW5zdGVhZCBvZiB3YWl0aW5nDQo+ID4gdW50aWwgdGhl
IEdQVSBpcyBmdWxsIG9mIGJhZCBwYWdlcw0KPiA+DQo+ID4gQ2M6IEx1YmVuIFR1aWtvdiA8bHVi
ZW4udHVpa292QGFtZC5jb20+DQo+ID4gQ2M6IE11a3VsIEpvc2hpIDxNdWt1bC5Kb3NoaUBhbWQu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNf
ZWVwcm9tLmMgfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhc19lZXByb20uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXNfZWVwcm9tLmMNCj4gPiBpbmRleCA5ODczMjUxODU0M2UuLjgyNzBhYWQyM2EwNiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJv
bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXBy
b20uYw0KPiA+IEBAIC0xMDc3LDYgKzEwNzcsMTYgQEAgaW50IGFtZGdwdV9yYXNfZWVwcm9tX2lu
aXQoc3RydWN0DQo+IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2wsDQo+ID4gIAkJ
aWYgKHJlcykNCj4gPiAgCQkJRFJNX0VSUk9SKCJSQVMgdGFibGUgaW5jb3JyZWN0IGNoZWNrc3Vt
IG9yIGVycm9yOiVkXG4iLA0KPiA+ICAJCQkJICByZXMpOw0KPiA+ICsNCj4gPiArCQkvKiB0aHJl
c2hvbGQgPSAtMSBpcyBhdXRvbWF0aWMsIHRocmVzaG9sZCA9IDAgbWVhbnMgdGhhdCBwYWdlDQo+
ID4gKwkJICogcmV0aXJlbWVudCBpcyBkaXNhYmxlZC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAo
YW1kZ3B1X2JhZF9wYWdlX3RocmVzaG9sZCA+IDAgJiYNCj4gPiArCQkgICAgY29udHJvbC0+cmFz
X251bV9yZWNzID49IDAgJiYNCj4gPiArCQkgICAgY29udHJvbC0+cmFzX251bV9yZWNzID49IChh
bWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkICogOSAvIDEwKSkNCj4gPiArCQkJRFJNX1dBUk4oIlJB
UyByZWNvcmRzOiV1IGFwcHJvYWNoaW5nIHRocmVzaG9sZDolZCIsDQo+ID4gKwkJCQkJY29udHJv
bC0+cmFzX251bV9yZWNzLA0KPiA+ICsJCQkJCWFtZGdwdV9iYWRfcGFnZV90aHJlc2hvbGQpOw0K
PiANCj4gVGhpcyB3b24ndCB3b3JrIGZvciB0aGUgZGVmYXVsdCBzZXR0aW5nIGFtZGdwdV9iYWRf
cGFnZV90aHJlc2hvbGQ9LTEuDQo+IEZvciB0aGlzIGNhc2UsIHlvdSdkIGhhdmUgdG8gdGFrZSB0
aGUgdGhyZXNob2xkIGZyb20NCj4gcmFzLT5iYWRfcGFnZV9jbnRfdGhyZXNob2xkLg0KDQpZZXAs
IGNvbXBsZXRlbHkgbWlzc2VkIHRoYXQuIFRoYW5rcywgSSdsbCBmaXggdGhhdCB1cC4NCg0KIEtl
bnQNCj4gDQo+IFJlZ2FyZHMsDQo+IMKgwqAgRmVsaXgNCj4gDQo+IA0KPiA+ICAJfSBlbHNlIGlm
IChoZHItPmhlYWRlciA9PSBSQVNfVEFCTEVfSERSX0JBRCAmJg0KPiA+ICAJCSAgIGFtZGdwdV9i
YWRfcGFnZV90aHJlc2hvbGQgIT0gMCkgew0KPiA+ICAJCXJlcyA9IF9fdmVyaWZ5X3Jhc190YWJs
ZV9jaGVja3N1bShjb250cm9sKTsNCg==
