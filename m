Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65391C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD5A510E4A9;
	Thu,  2 Jul 2026 12:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PmRl7TYk";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010000.outbound.protection.outlook.com
 [52.101.193.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AAC10E4A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUD3plc4lS8vGRMalngwn+6xKXbfKrkQV3O+d5f0IkxAfeyOB7fWPK8zSvsX58+jW6yuYxhEzK7yaTjxRmpkbsjqfOwBs0zJcVnMuK+Om+sEe7TJsN6Gi14HOao6jh9je8jDx5ytt+X9kFfXJdm1mmQgJ6jHSvPAvoDsc4hpSmcCcmhVvx1ys1CaLJbSrPIzPnQpHTV4MSGxEc+SQf3PkLZ1/r18KbQKs/l7de+2EOiFs5+VnwHrFpymMT7fG9goyjUD/geUGfgaTVXk+eMAeq4lV+NF36SB5kXkr+LWa5eBUuF4XR92QiLv6bVKgyUTE+Rw6OZLrVOJrVFbQE1rOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCqN1qf5ARGk8LGJrdma+I2qAVTMne9XmulQQ++XT5I=;
 b=xLiGVI52J9GeG6DkIAuEeLzNYQvJWxcAjMKEfp1uWy4eeEkEtpV36xRFxO+NC6LG4Cyi9fmUeIO9/f7XEQqWk5cTaz2jWiVwmCidwdt7gV0IXWREgijIZ0SGQPoInO7hk/sa+gydX88ZFiiLIRpbFyUxYHr+ERsHwaYA60jgSmxDI3+1aLA07DD7CRQ2LB6XvKrduaFFMaJARxRlgwTK4E27DY3mQRyIcv2c/rbEzltik2UvJHAy40OQ+pv72tzUuihwbDGn33pKpp6ScoioHfsOK2zONpWZf8CrlU59ZlU1CV8BKCXWayDsZA9SKho5GIw6SjGXiRms4qv2XcdKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCqN1qf5ARGk8LGJrdma+I2qAVTMne9XmulQQ++XT5I=;
 b=PmRl7TYkvtHi9c9GMlfUC6DzYMp6ow3oN+7vYxruTZvwM7bndE7WfwfAt6e9l7Fo+VuBCgmz5DJO9384wwFvUudyDyEc7rmRsaIBqV+ZRvfM9UisgGXROL49Q5V0shHSVBaPLcb/dEG9fWOB5AO70BpFSMiVAw/TNWMUdW1Ceeg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 12:13:48 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 12:13:47 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
Thread-Topic: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
Thread-Index: AQHdCf5+yHVupeNBHUGtLmYhnM0abrZaDc4AgAAWKFA=
Date: Thu, 2 Jul 2026 12:13:47 +0000
Message-ID: <IA0PR12MB8208395BD2307863D6BF516290F52@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
 <20260702084021.3140071-2-srinivasan.shanmugam@amd.com>
 <5a6ad86d-64dc-480d-bb08-230e61534b79@amd.com>
In-Reply-To: <5a6ad86d-64dc-480d-bb08-230e61534b79@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-02T12:11:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BL4PR12MB9723:EE_
x-ms-office365-filtering-correlation-id: c850a421-132e-48ce-939b-08ded8335e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|56012099006|6133799003|11063799006|4143699003;
x-microsoft-antispam-message-info: wuYq9fqShVDyD3frKVqJBnE7v3U7aeol7RxyUNNKaBFDqa1Knamr417nElfvgvgIbuse6al1nU0aHhp6D/EZulZqFSQ14KTHlWYlcX3O02aBPc7CwIeiDuwKYTjID4BT9SSYg78aDkDEE1kVNMqP/2xYfLlM3PYosKEy/X04APR4vX7/PN82ghpahGqmilHgQ9MrIxlN+kuaADc3GMYCXGnbUOZvoSs+iEkd7yY9/FHC1SJJWejiidCpioPvkz0xxFp45fJzeX3w6O5xjpgVUmT62vt5Xock1yRnYw/vsyEESTc1oa8gI6yEgleMOQYU5uN0N6IHhXEDZewS/k7PDwA9l8ZqD1Mn3/Wp+f58y7NpN0cspO45uP37V4AavaOH/fGKqO3NpGDcSsMnzxDteZ8hxziRxR4PdproMwUL521EuEvwOWfyXe5wb958eWd10MsqrlDdilpHeRngIzhHwktNVZhuPZkNQVKKyFt5OofgU4CN3LNf1I3uqV8VjtKhLqCCfrBPrHkgnqABGrP4ioEAX1TFRs6yMzL4KoJ5HVmk6TdVFt9k6rYjlpUOL3AXjj5WraOs9lloyBnDCKxVTSWb+I+B5BrvEo4BAtLJAvsL424Ws/vTAR8rwlsOrDl8cpaycBWZy8q33UO+KXkEjm2bdRoCBPRQL6t8N5kkRbvlpedfB9dsQsao5h4tu1Uou0LL5UK61yLPd/fhKy78XzP974V+KezJKXPyo6Yx+w4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anRHMWxoZU05SXJHMVlGUXJxNzFBUDNvK25Wb3lCamZmNk8vV1kySFRKa3Jv?=
 =?utf-8?B?UUVjTnpLWnZjOFZYeUlBdllwVG5RZElqWDVHcUZ4SFRlY2I1VGRZVjdSSVhY?=
 =?utf-8?B?NDBDcW1GcmlmQk5oM0htT2dCckRGSGgxRzJ6MVFOUC83REtuSnUvbmVrZUhY?=
 =?utf-8?B?WVAwV0FOQTdjaEY5SzJSaVlKSTljOXNUM25xNzBYTFFydHNxWFlTYmtEQmt3?=
 =?utf-8?B?MDdkT1VSL0Q3VTAzM002VjJJbENvcDZzNHpBVnljNlcyVUJkNWo1VDRId2p5?=
 =?utf-8?B?UWtla3RDWExwb0JuOEdLbDlWcENrcUFySGJrTjJrdTJhOUQ3dVZoOFM0aDlh?=
 =?utf-8?B?SG9XL0E1YzBxM1VZNHdUN0tMUzM1b2M3UGE3Vkc4VVRSSDlkbFdsT0gwVURm?=
 =?utf-8?B?dHk5ZFQrOFBEd2ozRFFCNXZLMngxcnJwUXAxRWVlTTYrV2UyN2xRbU5QNFNL?=
 =?utf-8?B?OENVRC9hLzVJdmRYUHRGV1cvYnVuWEZYS2xRZ3NlNjlma1dqTlVXWGYyVWp5?=
 =?utf-8?B?dkZVbjZSVjg2dTA5UGowS3l5THFyVTgwYmpvYVFneGF3ci9jWEZlbUxKMHBu?=
 =?utf-8?B?RHgvU3Vyakt6dU5lek9OaWxlc3lYZGh6SE04RUh4eGZTakxYZ2wvQVp0NEcz?=
 =?utf-8?B?c2RtRUxyTTk0aElCWnBRYkVOMklzYXJkWUd4K2FMNERyN1oxQ1dUZlh6YjlF?=
 =?utf-8?B?bkliemZnSkUzSzczM1Rqc05ITFZ1Rk41a1NTQ0ZVSTVQbWpCWnY4YmN2ZzBM?=
 =?utf-8?B?aysxZUdoa3o3cUJlSk1weDd4dmNLNXJ3Tmt2MzRVQmI2R002cTVMc1hxTEk5?=
 =?utf-8?B?ckJiZnlKSVVUUnVUZ2xNU1dKQmNZZkh2amhxc1hGNmhYR2lUTlAvUlUwNTgr?=
 =?utf-8?B?bTYvcFlMeHgwcFI5NVdYSmcvNjlKOW1lNnZCb0JrckxpQjZLL0ZodnY4S0x4?=
 =?utf-8?B?OXpDak1nVklKYmYyNmh4TjNaRzlhT1F3dUIvSnVLZFdXbE1qWWJCeGlieFdB?=
 =?utf-8?B?REcxVytTaXV0THJueTRObjBySWsyWlEzS2J0ejJ4anN1TCtDQ1dab29kMEdZ?=
 =?utf-8?B?SnFNeWNzNGRuK3Q1M09Db0Z4OXJYakpUNFdLQ1IrZFBrSlJXZVFZZjdkcXJ6?=
 =?utf-8?B?YWkrNnJIWXY1STFEdlhUZFNCV0hnRmJXTHdqNGNVL0Y3Nm5mdUh3SFhtekNE?=
 =?utf-8?B?Q1MwZUIzcU01YzRPQ2hjTFZvNjQ4eTFENmk5OWV3MmtWZytlc1JBNHMvNU1B?=
 =?utf-8?B?OWUyVUtDbUV0cEdPYUgwNndvL2Z2Z3lmVFNHUjV0K25yVWdBek9PejA5WXBz?=
 =?utf-8?B?NlRoR0xvOUVVSVd4L3VPOWJYSWdJWUJnUnJwUWpncW5HclJjM3JNV3ExNDRz?=
 =?utf-8?B?YjJaSDE2RElJRlF6NDRXRjRvNWJxZG9lMDREdEV0d1d5RktFMCs5bU03M1pR?=
 =?utf-8?B?WE9RQnhLWG9NRlR0YTR0aVhwVGgwWTdEaUZqZ21HbG56R0J4aTJQZzdzRkt5?=
 =?utf-8?B?U1RmZXhNMlZaaXZsV01qVUJzVHhJRk0xME1MVldVaVd5bTQybzM0bm5vZ0Vw?=
 =?utf-8?B?cUdnSUN1bWJRdkdWT2xxZmF2Uk54b2xIRVh0QUlMdzRmV2ZJYlRkRjFRRlZp?=
 =?utf-8?B?U0Z0YTAweHNUb3ptZmJBRXFiZlIvUTZDSW42UjgyUnd4ZEl1bURuMjBybkZK?=
 =?utf-8?B?cXhhNHpvUGd1QUZBYTRjdWxvenoxajFDcFhHUlM3bzhwaTk0YlVZRXlldW5R?=
 =?utf-8?B?a3VId2tpbWVaeEVEeHJwdHNONWxUN21la3ZEU2NnR216NitDdVFGd0xFb2c4?=
 =?utf-8?B?NlBHSndoK1BuYjBGbkt4dzdraEhIUUlQYk1paG5YeWZRVHNBRFJuajBnKzVs?=
 =?utf-8?B?bU1UOVpWRnEyTlFNOXJJWDVyUnRtd0hILzZvUVVSMEkvRmpGZmtsU1l0L3d6?=
 =?utf-8?B?YlAvanFDL2daT0kyQ0FFYnJ6ekpPTGtNVU1KaGQ5ZUR4Z2pDYS8rU2ljNi9j?=
 =?utf-8?B?dnpLeUpWcERISlV5N1JRVm91clJhSENPWERud3FKTWxkNGlweTE4WFplN3pl?=
 =?utf-8?B?V01JdzY3RzJPeU9lRXNpTjhhVWF0VnU2b2I2NmpCUVBYNWkxQ05uTUV1NjFh?=
 =?utf-8?B?a1UwZTQ3d1gyZ29zcTFvazFPTHAzb3ZiRi92RHV5RmRuVTVoQXJvUEJkaTN1?=
 =?utf-8?B?TytuMnlCbGFFdXJaZ1ErK3doMkYvT0pZMWVlTVc5MlZkS1JrQ2dNWUlzVGtD?=
 =?utf-8?B?SFk1N3NIU3JoczFONkR0MEEwU1Q1QzVLS3VHQmVPa2hiVmQ5QUliZENVb3M1?=
 =?utf-8?Q?TT9GCau13W3ugjR9ng?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c850a421-132e-48ce-939b-08ded8335e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 12:13:47.3434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyJjqW6kPQD2lwXv7P1f37pj1hz5jUUzOjhmZzAwu5QOtptQ0Z0HMsQy5+8XlFxWs4m3Y8AbSslm63MFbZpiAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDIsIDIwMjYgNDoyMyBQTQ0KPiBUbzogU0hBTk1VR0FN
LCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzRdIGRybS9hbWRn
cHU6IEFkZCBQQVNJRCBmcHJpdiBvd25lcnNoaXAgaGVscGVycw0KPg0KPiBPbiA3LzIvMjYgMTA6
NDAsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+IEFNREdQVSBhbHJlYWR5IGhhcyBh
IGdsb2JhbCBQQVNJRCB4YXJyYXkgdXNlZCBieSB0aGUgUEFTSUQgYWxsb2NhdG9yLg0KPiA+DQo+
ID4gQ3VycmVudGx5IGFsbG9jYXRlZCBQQVNJRHMgc3RvcmUgYSBkdW1teSB2YWx1ZSBpbiB0aGF0
IHhhcnJheS4NCj4gPg0KPiA+IEFkZCBoZWxwZXIgZnVuY3Rpb25zIHNvIERSTS1vd25lZCBQQVNJ
RHMgY2FuIHN0b3JlIGFuZCByZXRyaWV2ZSB0aGVpcg0KPiA+IG93bmluZyBEUk0gZmlsZS1wcml2
YXRlIG9iamVjdC4NCj4gPg0KPiA+IFRoaXMgcHJlcGFyZXMgZm9yIHVzaW5nOg0KPiA+DQo+ID4g
ICAgIFBBU0lEIC0+IGZwcml2IC0+IHZtDQo+ID4NCj4gPiBpbnN0ZWFkIG9mIHRoZSBzZXBhcmF0
ZSBwZXItZGV2aWNlOg0KPiA+DQo+ID4gICAgIFBBU0lEIC0+IHZtDQo+ID4NCj4gPiBtYXBwaW5n
Lg0KPiA+DQo+ID4gdjM6IChwZXIgQ2hyaXN0aWFuKQ0KPiA+IC0gRG9jdW1lbnQgdGhhdCBQQVNJ
RCBhbGxvY2F0aW9uIGlzIGludGVudGlvbmFsbHkga2VwdCBzZXBhcmF0ZQ0KPiA+ICAgZnJvbSBm
cHJpdiByZWdpc3RyYXRpb24gYmVjYXVzZSBmcHJpdiBpcyBub3QgZnVsbHkgaW5pdGlhbGl6ZWQN
Cj4gPiAgIHdoZW4gdGhlIFBBU0lEIGlzIGFsbG9jYXRlZC4NCj4gPg0KPiA+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyB8IDEy
Ng0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKyAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2lkcy5oIHwNCj4gPiAxMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMzkg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2lkcy5jDQo+ID4gaW5kZXggNjg0ZjQwZmNlNzNmLi41MzMzOTM3ZjBkMDQgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jDQo+ID4gQEAgLTc4LDYg
Kzc4LDEzMiBAQCBpbnQgYW1kZ3B1X3Bhc2lkX2FsbG9jKHVuc2lnbmVkIGludCBiaXRzKQ0KPiA+
ICAgICByZXR1cm4gcGFzaWQ7DQo+ID4gIH0NCj4gPg0KPiA+ICsvKioNCj4gPiArICogYW1kZ3B1
X3Bhc2lkX3NldF9mcHJpdiAtIHJlZ2lzdGVyIHRoZSBEUk0gb3duZXIgb2YgYSBQQVNJRA0KPiA+
ICsgKiBAcGFzaWQ6IFBBU0lEIGFsbG9jYXRlZCBmb3IgdGhlIERSTSBjbGllbnQNCj4gPiArICog
QGZwcml2OiBvd25pbmcgRFJNIGZpbGUtcHJpdmF0ZSBvYmplY3QNCj4gPiArICoNCj4gPiArICog
UEFTSUQgYWxsb2NhdGlvbiBpcyBpbnRlbnRpb25hbGx5IGtlcHQgc2VwYXJhdGUgZnJvbSBvd25l
cg0KPiA+ICsgKiByZWdpc3RyYXRpb24gYmVjYXVzZSB0aGUgRFJNIGZpbGUtcHJpdmF0ZSBvYmpl
Y3QgaXMgbm90IGZ1bGx5DQo+ID4gKyAqIGluaXRpYWxpemVkIHdoZW4gdGhlIFBBU0lEIGlzIGFs
bG9jYXRlZC4NCj4gPiArICoNCj4gPiArICogVGhpcyBoZWxwZXIgcmVwbGFjZXMgdGhlIHRlbXBv
cmFyeSBhbGxvY2F0aW9uIG1hcmtlciB3aXRoIHRoZQ0KPiA+ICsgKiBpbml0aWFsaXplZCBEUk0g
b3duZXIuDQo+DQo+IFRha2luZyBhIGNsb3NlciBsb29rIGF0IEkgdGhpbmsgd2Ugc2hvdWxkIHJh
dGhlciByZS1zdHJ1Y3R1cmUgdGhlIGZwcmlmIGluaXQgY29kZSB0bw0KPiBhbGxvY2F0ZSB0aGUg
cGFzaWQgbGF0ZXIuDQoNClRoYW5rcyENCg0KSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5k
IHRoZSBpbnRlbmRlZCBpbml0aWFsaXphdGlvbiBvcmRlciBjb3JyZWN0bHk6IHdoZW4geW91IHNh
eSAiYWxsb2NhdGUgdGhlIFBBU0lEIGxhdGVyIiwgZG8geW91IG1lYW4gbW92aW5nIHRoZSBQQVNJ
RCBhbGxvY2F0aW9uIHVudGlsIGFmdGVyIGZwcml2IGhhcyBiZWVuIGZ1bGx5IGluaXRpYWxpemVk
IGluIGFtZGdwdV9kcml2ZXJfb3Blbl9rbXMoKSwgc28gdGhhdCBhbWRncHVfcGFzaWRfYWxsb2Mo
KSBjYW4gZGlyZWN0bHkgcmVnaXN0ZXIgdGhlIGZwcml2IHdpdGhvdXQgYSBzZXBhcmF0ZSBhbWRn
cHVfcGFzaWRfc2V0X2Zwcml2KCkgc3RlcD8NCg0KQmVzdCByZWdhcmRzLA0KU3JpbmkNCg==
