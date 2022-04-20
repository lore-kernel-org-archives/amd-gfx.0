Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B10C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 06:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F7810E365;
	Wed, 20 Apr 2022 06:16:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF23B10E365
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 06:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBRIxqml3EWR1GAGZAFcwaoa8Z/QMXo1+CUhaEONLB5MeKsYRQ0d/QDHZgIJ6sNmPU/A3u2qXxwY8oWrs9l/HZroK+vySL1pFKifLhOYbAsEU3uj+UkexkR88YDdIjfXqdKhhdAwi2l6KvtUawV8Ak6vC37UKABaFN6lg8XVmnSqyNRzxPRnnO552hdiN4o2d7EZwNLJk5y3CNSpqJxS0BKl1P3shD5jjFkV7fUH7kqPfmS5tQyRWxs+ABHGBzADDcIwuMFYFcqWt2cuDNIBn/je9qlyTbwmuWK8IrUq0ofGZp7p9fPeWXOC7+WlPaq2yGKd/I0TimGp/iJwAMjvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VqdZPWQSMI/++LH49c8VKav/UOLTvUtCtFR7zkiKKs=;
 b=PNpSDbqJbiYjUPFJF6CN9PVIqyRZVI5nJUB42vPUSGK6b7bdbQ4nJFhuzvBkPUop8WuucVdzDSOYxA+4T1yZzuKHb6hbG06XLxmqysZgBW20+qcLJ515FIwMiz/A2ewZJFDxptWC95DmDuk9DWLvqfXSUti8LBT0g6SqzSgpmG9yK42opgQ7mYntFh0vqu54bvTXKZ7Ad4BYf4wHKAD3Xh/AchOqVEXwUtqBO9SMiBSaY7mteCp1/fxHSNbH8wXBrPfcm51HcRypjp5sLehSaI64nUZhtzvTIa9F1Hk8uh7MRV2LCHBwmLZ8uJMrUUtndHRI4CxFr/WlaO+LqTNnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VqdZPWQSMI/++LH49c8VKav/UOLTvUtCtFR7zkiKKs=;
 b=O4Mwz3k5gIrzOnhJ6SDVy47wtBfXXzJdkmr/q0UKj1MUsRMnRvKQOfpaE4uCabc0a+rbykDuJhBjGg+PW+g0P5lhCJv7NQ3ZxzKQe2i2gIKteKp3adoDdAH0l/CbhF9Nu3WX0vemy8hkfzQaFNUt1IIw0JWmqnvvTA6qsGXigo8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 06:16:45 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 06:16:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for
 poison creation
Thread-Topic: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for
 poison creation
Thread-Index: AQHYVGo3LOvGHScJbEmPPBgUBq1Nz6z4MCeAgAAi5iA=
Date: Wed, 20 Apr 2022 06:16:45 +0000
Message-ID: <DM5PR12MB1770E49B3B2520B4F84A1B99B0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
 <4d7f8be2-dffb-1fb1-1feb-576e0ebb6f4f@amd.com>
In-Reply-To: <4d7f8be2-dffb-1fb1-1feb-576e0ebb6f4f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-20T06:16:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5a51500b-e3fd-4ca4-ae98-3684f9c020a9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-20T06:16:41Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6e944d17-a0e0-442c-802a-dd5f2b3dd425
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e608da1a-e2f6-4c01-994b-08da22955877
x-ms-traffictypediagnostic: BY5PR12MB4196:EE_
x-microsoft-antispam-prvs: <BY5PR12MB41969D43CE1BC0BA08F7C01FB0F59@BY5PR12MB4196.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQ5EvgqlC59a9ZBrdrmCdCqO1ZapqDHmVcM1f57kJGNnTuU640asampzM06RP1EA4JYr55Jf2U7P5HukPFEXI4KIlfNGtdEIPTlDmJeqPVmkUNHGZjmrYWzS1jTk0h3lkFZg0WKOqcdEVqH/VvwPaAs8Mesdkip1YZWmWdlZnxX+TishsjVrTOSdKGJxYYAoGE4Z8eSSHeqkhiSkGcTl1M0FaTSF7p7IZXB2X4g523ff3678dfaVcvtL0SZGtsMcm4gxUmSgPucMWEW6Pz8Jt+Y0LH1qYYnI6eUfE4bzd/I2IwaR1z/np0gjl7e4T3Dv3Z4hwwxwTTdPYisGw+SAi9hawvneI4wrgL4npKTKtGnLU2ro+1ckelWCpzDMkLjzdbhWikWHoBHNh2jAyAbveOLGCMs87iL+6N4GluoN0S40w3raGTKRGA+D1TuopW+n5ZiDvb5898IbytVEeZKn0eFB8M0tk9Kbvm8YEqfQfO1ezxnqSPcK/9yJEqtiOFYRhveURGTCIObmRbMYnqWeHyYph2vkrJUidtajE3k9mbt1Z3rftxqBaK5JIQp+UnZ/UGS0gpu3+aJNxGT4VkDGQ8reEGKS3mVSAmimu2uBMHQpijSSNOlhATJELAkSOCR4I7JMf5ADb5FHbYVCLj4kRRJ5zO4pSa+j9sjTDvZz5XgElvTFNXDYfTihnbJ9xDll8LkA8/fwmupMWySZFTTsN0zdkDQR6FmMknaOsGBdCfg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(9686003)(6506007)(7696005)(71200400001)(26005)(83380400001)(186003)(38100700002)(53546011)(6636002)(316002)(76116006)(921005)(122000001)(66946007)(66556008)(66446008)(8676002)(64756008)(66476007)(86362001)(55016003)(8936002)(52536014)(5660300002)(2906002)(33656002)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFRya1VqYnNhcUxHTHpvaS9WZTBUQTVmVTAwNCtseS92V3JGR3FBTjk0cHp1?=
 =?utf-8?B?WjVHUzF0dUhsUFhqWjZsTWxIWFVRRjRUMGEzdDZUcHNRWU02Z1Z2K2MyU2pR?=
 =?utf-8?B?b3NIejExWjZMNTRVTWgvN3htd1FRUXl0eXhLbThjdk5zUHpLVE1kMm9rWjBN?=
 =?utf-8?B?clA4TEtQZ0FvVnRJcDVmNHcyZXBBZm9weVhGN25aUTNhallwTDcrRUtzSXRS?=
 =?utf-8?B?SENEL21qUkFGQ3M1U0xzQUNMdVRmZlNGb0ZPckxKRmRoVUVlcFRPNzVwYkU2?=
 =?utf-8?B?RkVQdFRxWkd6VXhRRHIzQ3kxUkdYVnBTdVJhUVZzV3FzSFk1Ym9vaDlCZlU2?=
 =?utf-8?B?Z2gwdzdGeUR1MjZUcE55ZHdmcHVjNU1MbzVlUFQ5dmNDWDl4eC9HcjBrNFlI?=
 =?utf-8?B?WGFPQUl0UWNDUmx3QXkxdHQ3VTJEc1JsM3RmMGR0b2J6aGluM0prUDVxUCtV?=
 =?utf-8?B?RzNsMVhCVkZ4bWRkNFpLeElKdFhZWURDSExNRnVKeDV6RGFzQ3NNamlSclZa?=
 =?utf-8?B?Wk9qOVgrM2xvU3RUVzRuNEp2ZjNZOFhCOC9aRUlZKzNvY1llY04wLzMyU3hi?=
 =?utf-8?B?ZjR2LzFmbWhsZWtPV0RLQ2NZd05yc2FLTkVPcjZkdUwwWVRBVFJzS3UxRERp?=
 =?utf-8?B?K2pCdzI4dE5zd29BMURwaXhWQUdtOG9HWGlqYjVwUVAxMWNVdW5MdnZtVlVD?=
 =?utf-8?B?UjZLOTFHd0dEUFFNQlE3TzhxWE9rRkpPQ0c3THZmOEY5dWJ0RmVQaDRYZjFW?=
 =?utf-8?B?UkkrcFE3VmFGU2NTcEZlUXJ5TUhVbkxJUys5RGNQdTBvRTdGMll1dnlqbnJv?=
 =?utf-8?B?bjB0S0JqOXpaTmdNSWlMRytRbGtKMlRtWXFBdk93T0M0SDIrRDRZUW1JbnpP?=
 =?utf-8?B?MmpBMDI4cURtOE1zK0o4cjMzU3grbkZza2tIdUVMSktTbUhCNDUvWmtpT05j?=
 =?utf-8?B?QkNmSHVUV1NVOElVRXMzaTZsemljTG1TOXJqWmcrdVNHYzRaOGlOY29ibmts?=
 =?utf-8?B?d0U4bHZhMExHKzRyTDJjeWlhWFZ4dFltMUJhS1VWN1JPN1RTTDViSnVzM25n?=
 =?utf-8?B?eHlVT043STY2dDAyc0ZISVgwbm9JKzNic0ZPaDRZdDI3ZU5uNklPN25mcFp6?=
 =?utf-8?B?MDhxb3RDSE1CemV2ZHBRN3Jpak5zOUR0MlVYRGV6Tm1QVE5wNEdxcEZYdmNa?=
 =?utf-8?B?N2xZc0FYemNJTWgwYmFNdUU3SmdvemkvdXlwL1VhNkZqc3NYZVBRcHZSTWh1?=
 =?utf-8?B?TWdtbEV5NDR3RkMybWY0QnJVOXJyNjhCT3o5TUhtV3ZnVHVNUGtoWWZ1cC82?=
 =?utf-8?B?SnFsc0dCemx0cmx6a2Jadi9QZ0xSNDhkd3V2TW5xc3JPQzRpV1dxM2poYUFk?=
 =?utf-8?B?dGF3cmVSOVhkY2xCZ3ZHb3FEblZWL2JsMDVnQUY4NGdEaXhlL2ppT21adFov?=
 =?utf-8?B?b3dVSFFReXJWUlkwUXlkRFNybnREdGpnU2g3bVY0UHpTQk9QRnJRdzRzZHVj?=
 =?utf-8?B?Wm15eGRBMFhrMkptaWpCbXB0cG4zUTkzTUQrQk5Ya3Z3WVEyRGxJUHUxL3pF?=
 =?utf-8?B?MkpIbTFzVkIvUW55R05ZdnpJYUtPSzRuYVdhMWJMaWhCQm5EQWxjWU9uWlRw?=
 =?utf-8?B?Vlg0YjVlVkpuZXRvWGtVcmxDbFQxOTJaYnlrTzBKSEhucXo2emJmMnQrczgr?=
 =?utf-8?B?SERHL0JhT1o4blNMaHhXNStna25rTXd6RHFUZFFCNjJHc1lhUTZ0RTl5aXdD?=
 =?utf-8?B?eHBXc2Y4elY0UzJjVEpTVXZnNGxOcU53ZDB1OHpnU0FBUW55ZHBLdE5hYjYy?=
 =?utf-8?B?RXF1ZXBJVTcvYTBFaU5ZY0hNcW4wN3kvUmpFOXRXc0xqbFQ2UlEwcEhsSnYz?=
 =?utf-8?B?N293YXI3Mm9PMDE3d3hiZUFvUWVIZFZMRlkyOXNjcUx3eDViek5idVFGYmc4?=
 =?utf-8?B?MmZSaytodllPTERzZCtyTUl2eFBRdFE1cUxwWXptSzlldmZxaE1JVnJjd3NK?=
 =?utf-8?B?RU0rNEI0WkloRVIwUVorMEgzWlc5REFtdHBXUjdMOFVJR3l0Y28ySGU3VWI2?=
 =?utf-8?B?NHJLYkdibC9WUVNDRk9DcnpzeVZtaDZ6WTgxaHh5aE92SDY1c3RFbUFOck1G?=
 =?utf-8?B?eW0wQkJnekhScU8yU29oTHpBcXVsa2RXKy9TZlRRY3ZsV2NQaTMvd25JQ1NI?=
 =?utf-8?B?Q1lSMkxvRXYwQ3BMRzVWQlZVY05nbnVoNTc0dUpXWXFPNTJMaGdHVU5kQ3lO?=
 =?utf-8?B?VzdoampROUZzUlJld1VPRGg2bTlQSlZVVThsS3cvOGkwQnhMY2xhM3dOV1Ir?=
 =?utf-8?B?ZTJOTnM4M29vK1BFR2lNMU9FVGtJcW5EK1FZSnRjRDdybEk4Vzg0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e608da1a-e2f6-4c01-994b-08da22955877
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 06:16:45.4488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn7AmOnM9yTmK6WcVwjTZssTfKy+dnh0rLoFumaQND2/zRqvscou17b1HvlbM/18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAyMCwgMjAyMiAxMjoxMCBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpo
b3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsDQo+IEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkNCj4gPFN0YW5sZXku
WWFuZ0BhbWQuY29tPjsgWml5YSwgTW9oYW1tYWQgemFmYXINCj4gPE1vaGFtbWFkemFmYXIuWml5
YUBhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogaW1wbGVtZW50IFJBUyBpbnRlcnJ1cHQgaGFu
ZGxlciBmb3INCj4gcG9pc29uIGNyZWF0aW9uDQo+IA0KPiANCj4gDQo+IE9uIDQvMjAvMjAyMiA5
OjIzIEFNLCBUYW8gWmhvdSB3cm90ZToNCj4gPiBQcmVwYXJlIGZvciB0aGUgaW1wbGVtZW50YXRp
b24gb2YgcG9pc29uIGNvbnN1bXB0aW9uIGhhbmRsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA2MiArKysrKysrKysrKysrKy0tLS0tLS0t
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMN
Cj4gPiBpbmRleCA0YmJlZDc2Yjc5YzguLjJkMDY2Y2ZmNzBlYSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBAQCAtMTUxNSwxMiArMTUxNSw0
NCBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfZmluaShzdHJ1Y3QNCj4gYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCj4gPiAgIC8qIHJhcyBmcyBlbmQgKi8NCj4gPg0KPiA+ICAgLyogaWggYmVnaW4g
Ki8NCj4gPiArc3RhdGljIHZvaWQgcmFzX2ludGVycnVwdF9wb2lzb25fY3JlYXRpb25faGFuZGxl
cihzdHJ1Y3QgcmFzX21hbmFnZXIgKm9iaiwNCj4gPiArCQkJCXN0cnVjdCBhbWRncHVfaXZfZW50
cnkgKmVudHJ5KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcmFzX2loX2RhdGEgKmRhdGEgPSAmb2Jq
LT5paF9kYXRhOw0KPiA+ICsJc3RydWN0IHJhc19lcnJfZGF0YSBlcnJfZGF0YSA9IHswLCAwLCAw
LCBOVUxMfTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKCFkYXRhLT5jYikNCj4g
PiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJaWYgKGFtZGdwdV9yYXNfaXNfcG9pc29uX21vZGVf
c3VwcG9ydGVkKG9iai0+YWRldikgJiYNCj4gPiArCSAgICBvYmotPmhlYWQuYmxvY2sgPT0gQU1E
R1BVX1JBU19CTE9DS19fVU1DKQ0KPiA+ICsJCWRldl9pbmZvKG9iai0+YWRldi0+ZGV2LA0KPiA+
ICsJCQkiUG9pc29uIGlzIGNyZWF0ZWQsIG5vIHVzZXIgYWN0aW9uIGlzIG5lZWRlZC5cbiIpOw0K
PiA+ICsJZWxzZSB7DQo+IA0KPiBJdCBpcyBjb25mdXNpbmcgdG8gaGFuZGxlIFJBUyBpbnRlcnJ1
cHRzIHVuZGVyIHBvaXNvbl9jcmVhdGlvbl9oYW5kbGVyIGluIG5vbi0NCj4gcG9pc29uIG1vZGUu
DQoNCltUYW9dIHdpbGwgc3BsaXQgaXQgaW50byByYXNfaW50ZXJydXB0X3BvaXNvbl9jcmVhdGlv
bl9oYW5kbGVyIGFuZCByYXNfaW50ZXJydXB0X3VtY19oYW5kbGVyLg0KDQo+IA0KPiBUaGFua3Ms
DQo+IExpam8NCj4gDQo+ID4gKwkJLyogTGV0IElQIGhhbmRsZSBpdHMgZGF0YSwgbWF5YmUgd2Ug
bmVlZCBnZXQgdGhlIG91dHB1dA0KPiA+ICsJCSAqIGZyb20gdGhlIGNhbGxiYWNrIHRvIHVwZGF0
ZSB0aGUgZXJyb3IgdHlwZS9jb3VudCwgZXRjDQo+ID4gKwkJICovDQo+ID4gKwkJcmV0ID0gZGF0
YS0+Y2Iob2JqLT5hZGV2LCAmZXJyX2RhdGEsIGVudHJ5KTsNCj4gPiArCQkvKiB1ZSB3aWxsIHRy
aWdnZXIgYW4gaW50ZXJydXB0LCBhbmQgaW4gdGhhdCBjYXNlDQo+ID4gKwkJICogd2UgbmVlZCBk
byBhIHJlc2V0IHRvIHJlY292ZXJ5IHRoZSB3aG9sZSBzeXN0ZW0uDQo+ID4gKwkJICogQnV0IGxl
YXZlIElQIGRvIHRoYXQgcmVjb3ZlcnksIGhlcmUgd2UganVzdCBkaXNwYXRjaA0KPiA+ICsJCSAq
IHRoZSBlcnJvci4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAocmV0ID09IEFNREdQVV9SQVNfU1VD
Q0VTUykgew0KPiA+ICsJCQkvKiB0aGVzZSBjb3VudHMgY291bGQgYmUgbGVmdCBhcyAwIGlmDQo+
ID4gKwkJCSAqIHNvbWUgYmxvY2tzIGRvIG5vdCBjb3VudCBlcnJvciBudW1iZXINCj4gPiArCQkJ
ICovDQo+ID4gKwkJCW9iai0+ZXJyX2RhdGEudWVfY291bnQgKz0gZXJyX2RhdGEudWVfY291bnQ7
DQo+ID4gKwkJCW9iai0+ZXJyX2RhdGEuY2VfY291bnQgKz0gZXJyX2RhdGEuY2VfY291bnQ7DQo+
ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgYW1kZ3B1
X3Jhc19pbnRlcnJ1cHRfaGFuZGxlcihzdHJ1Y3QgcmFzX21hbmFnZXIgKm9iaikNCj4gPiAgIHsN
Cj4gPiAgIAlzdHJ1Y3QgcmFzX2loX2RhdGEgKmRhdGEgPSAmb2JqLT5paF9kYXRhOw0KPiA+ICAg
CXN0cnVjdCBhbWRncHVfaXZfZW50cnkgZW50cnk7DQo+ID4gLQlpbnQgcmV0Ow0KPiA+IC0Jc3Ry
dWN0IHJhc19lcnJfZGF0YSBlcnJfZGF0YSA9IHswLCAwLCAwLCBOVUxMfTsNCj4gPg0KPiA+ICAg
CXdoaWxlIChkYXRhLT5ycHRyICE9IGRhdGEtPndwdHIpIHsNCj4gPiAgIAkJcm1iKCk7DQo+ID4g
QEAgLTE1MzEsMzEgKzE1NjMsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2ludGVycnVwdF9o
YW5kbGVyKHN0cnVjdA0KPiByYXNfbWFuYWdlciAqb2JqKQ0KPiA+ICAgCQlkYXRhLT5ycHRyID0g
KGRhdGEtPmFsaWduZWRfZWxlbWVudF9zaXplICsNCj4gPiAgIAkJCQlkYXRhLT5ycHRyKSAlIGRh
dGEtPnJpbmdfc2l6ZTsNCj4gPg0KPiA+IC0JCWlmIChkYXRhLT5jYikgew0KPiA+IC0JCQlpZiAo
YW1kZ3B1X3Jhc19pc19wb2lzb25fbW9kZV9zdXBwb3J0ZWQob2JqLT5hZGV2KQ0KPiAmJg0KPiA+
IC0JCQkgICAgb2JqLT5oZWFkLmJsb2NrID09IEFNREdQVV9SQVNfQkxPQ0tfX1VNQykNCj4gPiAt
CQkJCWRldl9pbmZvKG9iai0+YWRldi0+ZGV2LA0KPiA+IC0JCQkJCQkiUG9pc29uIGlzIGNyZWF0
ZWQsIG5vIHVzZXINCj4gYWN0aW9uIGlzIG5lZWRlZC5cbiIpOw0KPiA+IC0JCQllbHNlIHsNCj4g
PiAtCQkJCS8qIExldCBJUCBoYW5kbGUgaXRzIGRhdGEsIG1heWJlIHdlIG5lZWQgZ2V0DQo+IHRo
ZSBvdXRwdXQNCj4gPiAtCQkJCSAqIGZyb20gdGhlIGNhbGxiYWNrIHRvIHVkcGF0ZSB0aGUgZXJy
b3INCj4gdHlwZS9jb3VudCwgZXRjDQo+ID4gLQkJCQkgKi8NCj4gPiAtCQkJCW1lbXNldCgmZXJy
X2RhdGEsIDAsIHNpemVvZihlcnJfZGF0YSkpOw0KPiA+IC0JCQkJcmV0ID0gZGF0YS0+Y2Iob2Jq
LT5hZGV2LCAmZXJyX2RhdGEsICZlbnRyeSk7DQo+ID4gLQkJCQkvKiB1ZSB3aWxsIHRyaWdnZXIg
YW4gaW50ZXJydXB0LCBhbmQgaW4gdGhhdCBjYXNlDQo+ID4gLQkJCQkgKiB3ZSBuZWVkIGRvIGEg
cmVzZXQgdG8gcmVjb3ZlcnkgdGhlIHdob2xlDQo+IHN5c3RlbS4NCj4gPiAtCQkJCSAqIEJ1dCBs
ZWF2ZSBJUCBkbyB0aGF0IHJlY292ZXJ5LCBoZXJlIHdlIGp1c3QNCj4gZGlzcGF0Y2gNCj4gPiAt
CQkJCSAqIHRoZSBlcnJvci4NCj4gPiAtCQkJCSAqLw0KPiA+IC0JCQkJaWYgKHJldCA9PSBBTURH
UFVfUkFTX1NVQ0NFU1MpIHsNCj4gPiAtCQkJCQkvKiB0aGVzZSBjb3VudHMgY291bGQgYmUgbGVm
dCBhcyAwIGlmDQo+ID4gLQkJCQkJICogc29tZSBibG9ja3MgZG8gbm90IGNvdW50IGVycm9yDQo+
IG51bWJlcg0KPiA+IC0JCQkJCSAqLw0KPiA+IC0JCQkJCW9iai0+ZXJyX2RhdGEudWVfY291bnQg
Kz0NCj4gZXJyX2RhdGEudWVfY291bnQ7DQo+ID4gLQkJCQkJb2JqLT5lcnJfZGF0YS5jZV9jb3Vu
dCArPQ0KPiBlcnJfZGF0YS5jZV9jb3VudDsNCj4gPiAtCQkJCX0NCj4gPiAtCQkJfQ0KPiA+IC0J
CX0NCj4gPiArCQlyYXNfaW50ZXJydXB0X3BvaXNvbl9jcmVhdGlvbl9oYW5kbGVyKG9iaiwgJmVu
dHJ5KTsNCj4gPiAgIAl9DQo+ID4gICB9DQo+ID4NCj4gPg0K
