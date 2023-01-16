Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A30C678D6
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 07:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7979110E29F;
	Mon, 16 Jan 2023 07:35:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BFB10E294
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 07:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdRnw70b24IbtwNsi+kPeCUWbe9iiGiXXxoYBpJdo3DkC8VZe6YVhB4J7a4UDZNTFEa2Maxhd/HPe2EkBrkeXEcuf3Hr8zPtLNBIJ6c+MOuEocOYMxpBP/8jQh5p4kui1CwLCKDN3lvz2hAQ+ib5OvJB5r2M/Rf+z1pczCf1RWjUPtOuGomoEXhlzmG+6v5DGiILgjGQVOln2raTf2QyQFz8gpbWKH5Xadou+7sLJ+5hluFU18TLgyhcuPbv4e7zvA6h3A8F/h8OHjEWTvZobftg66wvdk/TDXS4IDEneVvC8Po2MltRzT1NQ5JuzlxCFxuQcWlb4kvRZJMHz21XCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqyMnE707BP5vW20Z5TrOPj8G/wDLvouYxJ5YuHxvR0=;
 b=fMbHvxC3gub2R9IEWXOA9eE/o5/D+ZBK9STdUsdXE3xW8FXA3ctxi+tGR14PdIZlFK87qiLkrqyhY28ec3TYRvLRo7eyCl2/8X5QiQpEFILRXooAJoKHmLYHcvRjPj02CsATfY69Y/v+diAbEnLV0cdUkIOWhLDjS9enOmGSpmtrtO7g1AEYzVTYulegTCzjFBvbmPgfwHAHrp2D6mW0Di50S2EgIgI4bXNJfhrtizDwBuPJ5c/btw2l7NR3YdME3vh0rkmk72vHUCvFz1G9HzllUHfiReG7KxY6YNFVZnQRH6jKBJvlDTSqt7u5qSK5Il6HNipdduJ7AZH+IRJxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqyMnE707BP5vW20Z5TrOPj8G/wDLvouYxJ5YuHxvR0=;
 b=rA083S99fn58ZcFSMmGouCId0zO63C3VinFmqeIAGglFEp67QJRgZuOnimG+kRFficAkgB2G/qpGT+P5jGkAJm9LQYmJmNb/m20tnaywbKpBG/Y3ktGyc38Lu/OjHdQ7Jy6RpAvaH8PbZdj0l8/FHl6wxXzl6M4S0YQAI4fHXaE=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 07:35:22 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::6fe5:4ba5:d001:29ef]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::6fe5:4ba5:d001:29ef%7]) with mapi id 15.20.5986.018; Mon, 16 Jan 2023
 07:35:22 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix cleaning up reserved VMID on release
Thread-Topic: [PATCH] drm/amdgpu: fix cleaning up reserved VMID on release
Thread-Index: AQHZJ20RfPAVENe9tkSuSNtNq67ALK6cjtcAgAQcCpA=
Date: Mon, 16 Jan 2023 07:35:22 +0000
Message-ID: <MW4PR12MB68754FAC08F652D6AF6329EA91C19@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20230113163531.175294-1-christian.koenig@amd.com>
 <CADnq5_OjeFLZ-s=8nr2N_ERecX3dCSiGg1R9XPc=cxB=f2RYDA@mail.gmail.com>
In-Reply-To: <CADnq5_OjeFLZ-s=8nr2N_ERecX3dCSiGg1R9XPc=cxB=f2RYDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-16T07:35:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bbc749e8-433e-4682-9ee6-65c5ea4ce5f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-16T07:35:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f3cac23b-dff4-4567-9b9e-bd1b41c485b3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|MN2PR12MB4566:EE_
x-ms-office365-filtering-correlation-id: cefae08f-5589-4f94-c1a3-08daf79439b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ip6gDJsMt3Bx+cx/njeKAYVLFB/tZbYiKL/UH9pQ5u9bWT/kYq7Rl9qDlI8SbDKMrG/sm5V+heJHGVWAxi67Kzs2xurlGIbVegt+zHH1AuERtWljCMHcRbMWGmwA4QBXbd4OQpYQLoURqRkr5Tjxrlypoy4rfWOMSlszl3cLKEKqtKSiEmDJ/XhpEorOOCBKL3ZD07ZAREn/QgiFXjqu0X5OUaQ0ZI6agPDkqFbBkh+3q/vOCrB48YoReSingqoTffzBpqr+6eeqb2fMJ6pgQjCoWYe7GiEPjDxPOw5WNnrSs5vvNU0o2nvjL9AvIWvon5mA5p/MVYSsZU+nHDwqV/8/Ki51pYQEgN63whldm4pi+8lL1ANpNrqz8n81Z1CTCqR9pwTiAKd27d2t2k9yFodV6H+jJNyq5tuQj0RE0lMhFL8mjA8nKREHgPm8Zwvh1w6sHOoEwsLIgyHw0HpVRKBqq3CP4VQ6dfGyEcexRYg0KLAfSvyZ8JI8C6LwKDlGhwKthunVdYrCD25GXLqEKEqXpG8UoSb8hHVzzvZdgTqPS7S1NxNzu2QQaYgebfFhJVyJ/xU9+fJRSk+HZUHABkNtOCeELc9erFodeoG3VZdkgfMHPni5xZ1+WSEt7ROElCF1eyGTQxikccEik5wan6qMwhXOooBEeW5Q0HxOUVEK6fwmSYOirvpqNpyMtf4eoSk9nVi4v9P2BlYrgXJisA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(41300700001)(38070700005)(478600001)(33656002)(66574015)(38100700002)(71200400001)(86362001)(316002)(110136005)(54906003)(186003)(66556008)(66476007)(66946007)(55016003)(7696005)(26005)(5660300002)(53546011)(6506007)(2906002)(8676002)(9686003)(66446008)(4326008)(76116006)(64756008)(8936002)(83380400001)(52536014)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlVkVG10SGlDTlZNb1hDdUU2QXU0Z2ZUa3dYN2VwRTV6SlhFcEdlZVJSOGEx?=
 =?utf-8?B?NGlVNElCbmNxdE5paFo0WmppM2NFYVpla0lkd1JCZmJtMW1tYytVb2JHUktD?=
 =?utf-8?B?eksyeElkVTRpOWZnMGw3OHRXNG9kRWo0R3MwWCtBV2hBV2hqc1lYR2ZKN1R2?=
 =?utf-8?B?OExZODYzdS82N3FBMGczYm96OHlqMVZtWkIxWWVEVjYxSG5IR1IyaThTblJn?=
 =?utf-8?B?OStEZExjRTNsUnp3a1JIbHBRclE1ZVM5R0htSkNQMERQUHlidnBXNVM0aEJB?=
 =?utf-8?B?cXJNOCt2S0g5U3FJOHVtdFRyRDV3RC9XWkkzRDNyQlloSHptWEtWR1kyOHd6?=
 =?utf-8?B?WmVBY2Q5aFVHV1JZZVVRcXk2VWpIa0JveE51R3FXZGdVS1BJYndnSmJwUlE5?=
 =?utf-8?B?OEZFeXh5UGRvYTd2dHNyTG42T0tYK1JGSzF5L1FTMHdDNjB4TFVXWmJkRFJx?=
 =?utf-8?B?MEYwMEdyeU1FUVIvTm5OUmU0RkNsNzlDMWlRRmF6UXJhTVN6MldGQ2FDbTRV?=
 =?utf-8?B?bDAvSUdTbmVudHZFbWwvSnAyU3VNLzJ0STVtTWliZnJqbmRTc3QzTTZBRzVF?=
 =?utf-8?B?VW9iUGZFQTdTVVhFdzFHUGJnQ3VJYmdSSUVrMWdMcmlxZGdDQ0JZQ040QzR0?=
 =?utf-8?B?bUVYdEJsRll5TjNEenQ2SkdLMTVCTFZZb1lETEpvK0NRTGxxREI5RG1pdlFt?=
 =?utf-8?B?R1dGR0RWRFJsNXl4Q1VEZDFxcWFQeE1LenMxL3R4disxR2lBNVBPb3EwWEU1?=
 =?utf-8?B?cnRDUWlCSmxTaktvbExqaVpuUWIwZUo5WjF3VTZHOGxiZk9keDJOM0tKQVNK?=
 =?utf-8?B?ZzlTRmxJcE9UdGJxTE15Z0Q0WEc0UDRXZG9mRHV6a3dNVHQ2cGZMb2Q4dFZk?=
 =?utf-8?B?ajZjdkI4L1IxZVVqelQzNFFRcGdhaGlMZWtFMzgreHdWMy9GaVNza2FMcEo1?=
 =?utf-8?B?aHgwWC92ZmFxZjk1dTlGYS83dFVWY29oVSt6eTZHNjNyRXJBU1R3NHlpNmtG?=
 =?utf-8?B?anRTZHlIOVoycFJPdzVIUjRVZ1pERDExSXp3Sk1CM1k2T0txWTdKckRoL29E?=
 =?utf-8?B?MmJzNGlvL0hmeld0MGhUTkNEK2ZJbkhsakVBQ3NBTldiSmhVU0pGNzJFRXNT?=
 =?utf-8?B?SDdhaCtIZGhTRDJQYmthclZ3YUw1VGYrYUNIUEJqM2lNdGw3VERVUlhlRDBN?=
 =?utf-8?B?TUxZOE9RTjNkNWZkaWRlSnMrRWtpS2hKeHpzYlZqVlFUMy90cnJqWUVScUdy?=
 =?utf-8?B?Nm4wNFZ1TE1BRzlReTU1cG5kNmltdUxqbjJHR3FOWnVwUHhaa3dUL09LbE16?=
 =?utf-8?B?bFlpNmZXb3hXL3IxWkRPdnA0YzhvM1VXNlR2VHFReURnamh6Z2UvYUhuMCt4?=
 =?utf-8?B?bTRpelB5Wmo1TnI2OHVtR0QzeTQrZmtzSERBYmFjZE5ZamowSC9xZVZMMXNz?=
 =?utf-8?B?akFxSHUwdVdOaXV6dkpnNXJBS0dRUnh6MVltS0ZrZ2ovZFVxeUp6TXRKN3k3?=
 =?utf-8?B?SWYvQkwxckw2aVM0aW1tc1dJbUtkbE5rbWJiRWM4UTl4aWpZYXJyQWlWMlky?=
 =?utf-8?B?RGM2N1VVR3d6cHNyOGV2SnQzRXFhcXIwMFg5SzFkOGNtVkxGQzdXV1l0b0s4?=
 =?utf-8?B?U09KQ01NSEVYWG5DUE9Za2ZXNzlIL3A0dGtDbFYxaDJ2QlZiUDk1VnJDRWhE?=
 =?utf-8?B?N29uKytwUjVGcnlvMjFVajg4ZndQTmR3bFVRbjY4V3hYTkJxTHRPbGdsUDVa?=
 =?utf-8?B?cDNLbjIxOWM0VHBzVHJTMXdiVHE3QlRRMXhiM01ORlZ4SUE5QzBZQ3RTVVY4?=
 =?utf-8?B?TzZ1aFhRV3pTSUgxUzNvLzIwOW9RVE8zRkRqU0ZnOVVGVUl0NnkzZWtUcXpG?=
 =?utf-8?B?RmtieXdMTUd5NkYxRGVldnlvTzIxWktYQkFPT0pWbFZmUVQ4V3MwUHU1cWU4?=
 =?utf-8?B?Z1Zqa3ZjdFFYVDhWY1JCYmc5OHF5NWFHK0dCbHlScVg5VU00bTlrY3ZNQUVN?=
 =?utf-8?B?b1FTSmRVRmsvWEVXekVvYjhUV3dERW1SQXlVcUErOTdGTFZtRzFUVllVa0pa?=
 =?utf-8?B?OGJvOUdVVEdZbnVoc3MvWThySUJZbjdOQ21pWGJYeE9SQ3QzVlN1SksvMkRq?=
 =?utf-8?Q?s4Gc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefae08f-5589-4f94-c1a3-08daf79439b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:35:22.0827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjUNnvg+VP3SLVfHEyYSMRWZXMt/OiNx4bMhcIX90RV9tohZEIeHBQGWNe12dpxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRlc3RlZC1ieTogQ2FuZGljZSBM
aSA8Y2FuZGljZS5saUBhbWQuY29tPg0KDQoNCg0KVGhhbmtzLA0KQ2FuZGljZQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+IA0KU2VudDogU2F0dXJkYXksIEphbnVhcnkgMTQsIDIwMjMgMTI6NDggQU0NClRvOiBD
aHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBjbGVhbmluZyB1cCBy
ZXNlcnZlZCBWTUlEIG9uIHJlbGVhc2UNCg0KT24gRnJpLCBKYW4gMTMsIDIwMjMgYXQgMTE6MzUg
QU0gQ2hyaXN0aWFuIEvDtm5pZw0KPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3
cm90ZToNCj4NCj4gV2UgbmVlZCB0byByZXNldCB0aGlzIG9yIG90aGVyd2lzZSBydW4gaW50byBs
aXN0IGNvcnJ1cHRpb24gbGF0ZXIgb24uLw0KDQpEcm9wIHRoZSAvIGFib3ZlLg0KUmV2aWV3ZWQt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPg0KPiBGaXhl
czogMTZiZTNlOWY2ZjAzICgiZHJtL2FtZGdwdTogcmV3b3JrIHJlc2VydmVkIFZNSUQgaGFuZGxp
bmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lk
cy5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiBpbmRleCA2NDgxYjQzZmZlMjUuLmEw
NTQ1ZDUxYjZiZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2lkcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMu
Yw0KPiBAQCAtNDk5LDYgKzQ5OSw3IEBAIHZvaWQgYW1kZ3B1X3ZtaWRfZnJlZV9yZXNlcnZlZChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgIS0taWRfbWdyLT5yZXNl
cnZlZF91c2VfY291bnQpIHsNCj4gICAgICAgICAgICAgICAgIC8qIGdpdmUgdGhlIHJlc2VydmVk
IElEIGJhY2sgdG8gbm9ybWFsIHJvdW5kIHJvYmluICovDQo+ICAgICAgICAgICAgICAgICBsaXN0
X2FkZCgmaWRfbWdyLT5yZXNlcnZlZC0+bGlzdCwgJmlkX21nci0+aWRzX2xydSk7DQo+ICsgICAg
ICAgICAgICAgICBpZF9tZ3ItPnJlc2VydmVkID0gTlVMTDsNCj4gICAgICAgICB9DQo+ICAgICAg
ICAgdm0tPnJlc2VydmVkX3ZtaWRbdm1odWJdID0gZmFsc2U7DQo+ICAgICAgICAgbXV0ZXhfdW5s
b2NrKCZpZF9tZ3ItPmxvY2spOw0KPiAtLQ0KPiAyLjM0LjENCj4NCg==
