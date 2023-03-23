Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E368C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8DB10E0C6;
	Thu, 23 Mar 2023 13:55:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DB810EAA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhj2Gm0DJ6SAdO0WhYxyLwFDEYIM139lUS/+aq4JI0Em5K+oZcJOhqDTIVmJMHxmBsmAneQ6vpRbzdDsiQcy0hz1PCNL5X1r0d94OzoXlQTzifAD9Wh9JqzhaNS4cW0tm27d32p5EqXu2a/jif5d2Y/QCBeOENJSdYGNH8QpZtDUWcAMJcNIkaIUlFAI7hPGnbcQpOJqLZFqek6VAMGCz/3xtyk6ZZv6m0nK2VoUIc5GaDBU6KmsNTFMV++pHYioUt11wt6M3nzwHlNTSmQFWRtU5mX7rkw8ldVzqlkihW6wmvOpk+foVz32AlNEL5lQ8oUX5+qZwsn+RpxbMZJQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNYvnv6CqpA8YvGSMVJ83OqsL2yIlN46CbqZfTTRCcY=;
 b=Ss19XuC7XUi7NBMRcJlelWvN6EKklVybcUVMBJXk18Wom7H3vh838Zvxn40cFy1f2oW4m6oZA5FdPEr5T8+kTgdIN9l2F7STtfXXq8ojw0YH9+bnenSq+WWKrr+/EFz+8hgvVegPsrClznuCYnsJHczh+gfV/evnzPYwYtP1jpLu+SGKSmaaLjapunXiPffyYKgHGgaVIE7z0KC5vKyuYvhogXDW1YJHB4nFbRfgDWHWrR0oztqEcW1FSm5r7fB30GU5hGQblEC9YXJ1bfYdhDBt9nKyOSpv6LLH0WZE1VszLF3gq01mClb15cpAXTEISYH6OqTHRhIyLF3+IDiYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNYvnv6CqpA8YvGSMVJ83OqsL2yIlN46CbqZfTTRCcY=;
 b=NeqiKHOETfrJSTTzTH+t4OeDfs97xzcgy4CJWu9m/fhAGN+Cg78401Rt7PgC/9O/cUnsS8FL18JfF5e76/HuzVGvLLoqgeeqBdCqv1YyjFEH2gI1nRptLU7elH6Izrx5BbrnzSstkdiNHU49isDwxBlYfvnMYlr5slRCzgqyUO4=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 13:55:49 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:55:49 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXX+20w+FZISrM02v7ekDk7+DS68IW/oAgAAG9oCAAABUsA==
Date: Thu, 23 Mar 2023 13:55:49 +0000
Message-ID: <MN2PR12MB4128060CF657C1F8AAA6B24490879@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
 <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
 <b308338a-663f-8a5d-7784-39bed8af1f5c@amd.com>
In-Reply-To: <b308338a-663f-8a5d-7784-39bed8af1f5c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T13:55:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e607362-23b9-499c-8552-e450e840113a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB6847:EE_
x-ms-office365-filtering-correlation-id: 29247e47-7f28-4b92-dcae-08db2ba64f1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hzltFRBEW9A0icVjfvjHPNEqUq07VMHghI6MUgaoIC+X28NOcazzV34q/bJP5S3L3BQXOyU4El/PmAxfoue5Kc5/XMVnHTVr2MDcB3YqqD3AePD57h7gVrBrxBnGnL5B//AWsZqqZVspRao76n3sFj0toFvpGvf8DRsLrs0e4XC7zJj2C4gxn8HOskBh4tAXdf4SMWr2tUZ4wmwjkDKsYfqYv5rBwk4IGbIjOHrboSAd4GVK+GxvNxCU+rfy24BK2rEeS2IfDMLg5tHbRBDLcg2VaCyx5RU8Tpk3erQOcw9qrga118VOm9JF112rwOzWWyBYAIM/1KKPZjh3nqeM8S0YisMYn/AeZJClAry64z2ea34n02aQMaiu3S2IGVRuLaJOrLANViEgIqcjjAAdA8dQ/hhEMwPMRZeuxCZRcm6Okbj+M4kHElFwyDWjoAudP0TsQgx5se7y5Yb1RpEGvqlFDeXpF5M68TCeOuEOUrnNnZDLWGCVozXuF9aNizSWFArTnyD0n0z/G7TEZUIYXxCneFzKdx10ZbSri9XqPAe0I3YZ6DLq4N0PGvxZEkV0R6wLExs0ismimeU3JWqgqLGI7EJugDNt90DxkRa16wKzhT83UrqeNrXy2f+KDlR2+mXLygy3s8eWe/uY0+djJyvgKl6StR93uhu4NOj7G3IOt+5tCP+gvwudCMXlNo/7J6iqRHfpPv+Y3oTGVcm0kuruES3Qnqd0WxuEmx4TW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(33656002)(86362001)(921005)(64756008)(38070700005)(122000001)(38100700002)(2906002)(66446008)(41300700001)(66556008)(4326008)(66476007)(8676002)(52536014)(5660300002)(8936002)(55016003)(55236004)(53546011)(186003)(9686003)(83380400001)(66946007)(6506007)(6636002)(478600001)(76116006)(110136005)(316002)(26005)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjNMQXZkT1h4V2ZlSGV6ZzlCd3RMakY3NjJZMEU2OTFJMTRVTDVoZnBaNWNl?=
 =?utf-8?B?Qlkwbjc2Njd0UXNwWUgvb2NkRm1kTGR4SURhc2pNNzRVSTlIRWhqZUw4KzNj?=
 =?utf-8?B?QVczQ0VzZUk1aEw0MXFkb3VkUDRvTWhTR2Q2eUJ4RDNqdzdoWmEvTUFxdjAw?=
 =?utf-8?B?YS84QzIvRkl5RzN2Tjg4QjhNQ1YrVDJ1VzZOMElXRFp3b1FxakRjRjM4aEVj?=
 =?utf-8?B?ZGJnRWNmMk9zYzE2QlRPeC9veWZHTElLcHozeGp4UkFmWkdCVEtxMFBaa3pq?=
 =?utf-8?B?eDJHQVQvTjEwcGZVKzFnOTJBK2duanlYK0F1N203ZytzRlowYmo5SzdDSEJs?=
 =?utf-8?B?UFNURnNyUVR4bHFPWG5rVWliUkRpNGZTOWNyNWlmYUY0WTdtZ1VOMzUyRHd6?=
 =?utf-8?B?eUFsaGU2QXVQaHIrVTdDSGtVcnlPYmJxcVhlcFNtMmtDNWxrSldDclhDM2lT?=
 =?utf-8?B?TmVBV0RxamNIOU84OVhXbXZPWjFQZEFGM1JhTm1uM3paS3JGZWNLODJmb29t?=
 =?utf-8?B?ZlBkS1M2aWxFRVZKUWw5Sm02YnpCdVVPUkFuZitabjVBOWJmUkZpN1hoTlI3?=
 =?utf-8?B?c1VFeGRGL2FZa3hXMXkvK3BLZVhWWmpmUEhXSW9lT0laM3ZnWUE4TUo1R2hq?=
 =?utf-8?B?ZFdHOU11b0gyK253dlBaakhHU3lUN2Y4Zm9DbFFlOHQ3dDMrOFpHRzVlTDJp?=
 =?utf-8?B?VWVjMi9yMHRoRHIrWGxIMStZVCtlWm80VWMxRHp6VnNyWncrYUR1dytkcWlD?=
 =?utf-8?B?cG5mekFxQkNNc3Z2ajhwdGJhR1NZbktUcDdVQUd1cGxHVXhYT2hSQ3phSitH?=
 =?utf-8?B?ZXQxcFBoSXR3a2lOZ2JEcENkKzJ2M0pZVDQxdDRHZVlFdDRzdzNFR0Nob3hj?=
 =?utf-8?B?VFpXb3NGTGUvQ0NKZm1zTDd4bTR6eTNPN1BUYzJFYmFFYlhpNDNybDFFanp6?=
 =?utf-8?B?aW9FNmlWY3IyV2NZdGwyM01hZ2E4NVlDQkNCZllmdWEydmJkMnRRRzVMVEtO?=
 =?utf-8?B?SlJUR1hDQnc2SE85cU9IajQ3M1NHMTFKeVJWeG9yckd3WTIyRkZwRDZwWHFs?=
 =?utf-8?B?Z2Z0ekp4S0dkZ0xETnJ0Qjk5NXdOeGh0aW5JRnRldUV4T3BUTEdOVEtHRVFo?=
 =?utf-8?B?cFhKbWFDcmkxcWNib0J4ZTR3OERtVXAwSjlzYmRYYllGZ3F6ajdjb3FtWnE5?=
 =?utf-8?B?ZFl5aER2OWpkdDJEZGxVdGEzQzdtT3FJZDlmMVVPdHcwVFhabHFMazlPWmxs?=
 =?utf-8?B?Q3lSWFFldHVZcFI0M2VDa0dMVDc0M1Rnc3Fqd2M3NjRmQldKREw3V2ZIWTZM?=
 =?utf-8?B?c0dGNnBwWSttWlNVck9oMVA5WjNxaks4eTFKbVQ1RHZFSHdXRm9vWVlwVzYw?=
 =?utf-8?B?a2hwY1NRcTl4cGErL29NVXdQczJPbmpLMTE5Z04raHVVbzA1L083VDlSMG0r?=
 =?utf-8?B?TjJpWHlzZWpzcndRTmNaOVc0MktLZjdhVDhlQ1Y2NlYvelFOdWxlNGZLL3Bs?=
 =?utf-8?B?a2d2V1pnOFkzY2hXa0hETmpnVDd4WEtCa0xxT0M4OGR5UVlDd2NQNzQ0UVor?=
 =?utf-8?B?SGpka3BybGxzT0wxV3N1cFhaOHRNc3hQTHF5M3l6bmc2YzlMaEx2NWU0WGlw?=
 =?utf-8?B?N3B5bGU3N2cvdVNoZ1pCNVZMdmhNNTJwdEhTZWV4QXplTkpYNktCODFiOTB6?=
 =?utf-8?B?K3hrUmxCcmpVZ1h4SEM1NlU3cTdMeGNUK2dESUpqZjBQT1FaQTNTeUg3dlpC?=
 =?utf-8?B?dVBGTitKWDlCR3I3TUJxbzVKcU85VVMyTURnTmMrSGdUVHE0T2g3VlBhR0tq?=
 =?utf-8?B?eCtkSGd2U2M4aWtJcVVPSGY2Q1I3S1dLOEdKNy81aWhSTFJmVGpIazlGTUJL?=
 =?utf-8?B?SXlkeXhLcGRWQkh2eWd6ZE9qVEd3NHVFeFRwekdyd2MwdTFjY0NoRERIbTVl?=
 =?utf-8?B?WENZeGdyYzh6eTcraFJKQTFZMXVZQmVUTUt1bDY4TzBRUlJRd21MK25vb0ts?=
 =?utf-8?B?TWE1YjdDRjFJdjZTL3JDa3o0QmJrQlgySmphRmhVRXJjaFYrN2djMjlia2pW?=
 =?utf-8?B?UWt4a0VSSEtaMnI0S2ZoVWp0OXR6RmdLT2RVYnlscWlHZjBxaVNzNDJWMDVT?=
 =?utf-8?Q?p+CQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29247e47-7f28-4b92-dcae-08db2ba64f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:55:49.4576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJFSmkRXtAbiFZ7fXYydZ8Dy5MKFBWe30DkLUuk1vsqzMvKc2RqCN3BRz6US3odTVp+sZ44iyfGLjyJIrEG93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBMdWJlbiEs
IG11Y2ggYXBwcmVjaWF0ZSBmb3IgeW91ciBoZWxwIQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+IA0KU2VudDog
VGh1cnNkYXksIE1hcmNoIDIzLCAyMDIzIDc6MjQgUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZB
U0FOLlNIQU5NVUdBTUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRn
cHU6IEZpeCBsb2dpYyBidWcgaW4gZmF0YWwgZXJyb3IgaGFuZGxpbmcNCg0KT24gMjAyMy0wMy0y
MyAwOToyOSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gQW0gMjMuMDMuMjMgdW0gMTM6MDQg
c2NocmllYiBTcmluaXZhc2FuIFNoYW5tdWdhbToNCj4+IENDICAgICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5vDQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmM6MjU2NzoyODogZXJyb3I6IGJpdHdpc2Ugb3Igd2l0aCBub24temVybyB2YWx1
ZSBhbHdheXMgZXZhbHVhdGVzIHRvIHRydWUgWy1XZXJyb3IsLVd0YXV0b2xvZ2ljYWwtYml0d2lz
ZS1jb21wYXJlXQ0KPj4gICAgICAgICAgICAgICAgaWYgKGFkZXYtPnJhc19od19lbmFibGVkIHwg
QU1ER1BVX1JBU19CTE9DS19fREYpDQo+PiAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+
fn5+fn5+fn5+Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFByZXN1bWFibHkgdGhlIGF1
dGhvciBpbnRlbmRlZCB0byB0ZXN0IGlmIEFNREdQVV9SQVNfQkxPQ0tfX0RGIGJpdCANCj4+IHdh
cyBzZXQgaWYgcmFzIGlzIGVuYWJsZWQsIHNvIHRoYXQncyB3aGF0IEknbSBjaGFuZ2luZyB0aGUg
Y29kZSB0by4gDQo+PiBIb3BlZnVsbHkgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nLg0KPiANCj4gVGhh
dCBsb29rcyBsaWtlIGEgbmljZSBjYXRjaCB0byBtZSwgYnV0IEkgZG9uJ3QgcmVhbGx5IGtub3cg
dGhlIHJhcyANCj4gY29kZSB0aGF0IHdlbGwuDQo+IA0KPiBIYXdraW5nLCBMdWJlbiBvciB3aG9l
dmVyIGlzIG1vcmUgZmFtaWxpYXIgd2l0aCB0aGF0IHNob3VsZCBwcm9iYWJseSANCj4gY29tbWVu
dCBhcyB3ZWxsLg0KDQpUaGFua3MgQ2hyaXN0aWFuLS15ZWFoLCBpdCBsb29rcyBsaWtlIGEgdHlw
by4gRml4IGlzIGFscmVhZHkgY29tbWl0dGVkIGludG8gYW1kLXN0YWdpbmctZHJtLW5leHQuDQot
LQ0KUmVnYXJkcywNCkx1YmVuDQo=
