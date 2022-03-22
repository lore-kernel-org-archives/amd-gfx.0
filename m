Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53132C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 18:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46DA10E03D;
	Tue, 22 Mar 2022 18:20:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59B410E03D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 18:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hywCSbyT8kABO0vTWhmPTmY/Rw+14yexKuv6UMOshDHBRHEjuNwYijlqXQQIdZaFP+9UFcJWHbhI3sHBSA+qp1aZYvUCk34w4+60oyvE98IJHnVFmWNVRI1elYn9FJOFNyLFmA18/cuSO73+oURcHoj2PoEvvBJ3d+CIwYo3zK2uezN+UsUHgq3X5eiCs4r4ZeTNZJL3KpArkGCgiH7WjpWXMZ+Sp+rjU8gluNt3WOteOdtUX0z7KqdLhPksfYp19Yyi2cBu+T1UppAL7XonPMoTqoJ97SFzb1wJDTnO3TokHms3VwvQEsLmyV5zfT0EtgIkF/CKlIT3rvTtoZbmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+Z7q1Y3JqaQ2GOML2n0a0hmW0tFVsFdWyw+p96xXyE=;
 b=ANWWc899Dj9gnYlUyFCW5S7+dxT7qfeyj2KuSkhoxTIn3zht1qWSinpXxks0Np63t+KZOAS3GapKBJDZkMBBq3D0pNLNOmsrvsnjp8SUFveSjm93et3Yl1dJPHKV7bkAy142KSWe6IGfk9EHQFw1hDcs0tCiqJcEnG9DDlbZ2A8r1nuMJGDDwGM5dFwaHcstsiNZtnfBlEuzZS/bbEDfKnXCzx2gW413XWwobI9I/K1PB9hYfg+a+nz5D3WJHlmieRezvCElPznMMWdMBTbJV7Vq87tDOespCQSLhEcRFejiq8gaWbq23jkKRoav63cxoJrrxOm6o3Tjaw26DK3Sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+Z7q1Y3JqaQ2GOML2n0a0hmW0tFVsFdWyw+p96xXyE=;
 b=tijmFDc9f5bM+/rlkLBvm1UBlrnTq6W7gypifQ2Mf8AC+pryist2NoBCw+ScHWa9s75HD0r7Lo8IJ3eNsoDb4NK+Xt0FafA9jYmTBBlIHYifJigqyDSm9zE+I8fHJVppEVg0DXs+C2P/tWlUbIHla84a87VqRJ9vZoNLCmPmWrM=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Tue, 22 Mar
 2022 18:20:17 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::60d5:7585:9936:5104]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::60d5:7585:9936:5104%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 18:20:17 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Phillips, Daniel" <Daniel.Phillips@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC] Add KFD available memory ioctl thunk support
Thread-Topic: [RFC] Add KFD available memory ioctl thunk support
Thread-Index: AQHYPhJO+nlE7/ilv0eH0qrSgP7ggazLtlgw
Date: Tue, 22 Mar 2022 18:20:16 +0000
Message-ID: <DM6PR12MB5021C430FE412C50B32DF18495179@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <5741ccfa-856a-b0a8-1a70-4b7b5098144a@amd.com>
In-Reply-To: <5741ccfa-856a-b0a8-1a70-4b7b5098144a@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f87861-77ba-42f6-de37-08da0c309db9
x-ms-traffictypediagnostic: CO6PR12MB5396:EE_
x-microsoft-antispam-prvs: <CO6PR12MB539615573A4257C15130F3F795179@CO6PR12MB5396.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ev4g7Y4S7atHikAKULPruiEStIF4JYjUUb6GawvhsLW0KBhfvh47Q2iUvMZo1duHpAYzQKOt1MXJ+uFeCZhxDAzlS8bVeeVh0p8g1h4AbVfY732g19ClYhFnYpG6iRVoaeZ5Or3Vqwj06XH1o6qSn+0elAEkXTgeeqtbRjUPmKWxJTstVDcjn+LUzSQmHhO/mCdwZdWPiYjkWBE/3CE7/r9ckBZgXVLNq9eRR/2fZ/b1Sf/1Qv1EvoeukY/33hRbQnWBxzI9cB63J2ksQcRvpyB1zRt6BE7cECowC3yAdnuSOv4iGyoybpzCVzVoWPtNC44YqeM1OE6bgdwQojKqR0wSPWW47vfsQzlTz1cbp4A3EiTAaiGsGNlaom9Y6UyYjX25dbJm+znMNZZbAg6MonhlrwSD8h0iA6J1O42qAIR09MbIjIymEQhlugJiwDbWctIZp2/L6WEm+WzRZ2FaP5APeOZi1H4BI9KG+vlmdjB3BSg+4CShyB5YxF2MNXBpTKim2Y2fWb10E/iOCzEp3XW02K8miHi7iTK6eNDyLRiVLnes8nzs0R8nIe275CBHPvQE85BQq5OQoddoBX0KtElFVLMirEvEszj7xa3ezL9JFqMgNZZvDwarGT0G3AxvIiBd25Xj7GbP3Mu6DT7r8opx4HgYH62m/nVDTtwumL3LRFt/YLkP+Xt4VO6fJgVgnL5LpGSzOuei7lki1fuagA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(186003)(316002)(86362001)(110136005)(9686003)(66946007)(71200400001)(8676002)(122000001)(64756008)(66446008)(4326008)(7696005)(66476007)(66556008)(53546011)(83380400001)(6506007)(76116006)(2906002)(26005)(5660300002)(52536014)(8936002)(33656002)(38070700005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDFld0o0MlNPZmhaVWI3TitnUU5ZbWdSQnRadU1SZFdwaUNNZk1iRnhQMDBi?=
 =?utf-8?B?aEVkRkJxTVNXT21ONzRRTmRSd25ReWdUc2xhTENTWUl4cDlLYVdyU05BTmN0?=
 =?utf-8?B?dE54TkZTQlNuR1RxOTlwbUNlNFBYbE5wbW1uWkh4MlphenN0dm5mc3dGcXlE?=
 =?utf-8?B?cW1HYXcxclFYTEh0L2xVVmMrSWdQSW9SS2NPZCttRmY2ZG5CbUE3RTRDYVFr?=
 =?utf-8?B?YzhqMFlKYUNYNys2aCtncDJEajVxZjBLT0ZuSU9Ia3BvZlJ1R0RjNTlUcDBU?=
 =?utf-8?B?SFRSdFgyYURYNE55TW9xVXpHWGNHNTBJVjI0LzI0alNOT002YkN2OFg2WW9U?=
 =?utf-8?B?WEFoQzJrdGYxVHI1bDB5Z0RVZFZDaEhpblBKUDVYSmcrcjQwejdkVS9KdlNP?=
 =?utf-8?B?L3N4Qi93aWZuMUdlbUNveEZhZnlnSkhsazVtbFh5L0VuNktQc1pQbXVpMElX?=
 =?utf-8?B?WTlXQkFKcnBrZXg2cjhrWWRPUXlTcVBOMG93UHJML0c3V2NnSUp4SkF1Zi9o?=
 =?utf-8?B?eTkxTURuQnpKOEtkSmlEZVpIa3AzbFlZanpyRFdyN2NKcTJVR05JUUtZd1dU?=
 =?utf-8?B?WUdSWEUvV1hTV0djbmRXTjhOYzVqZTJ4RFlGQkR5QlVUSUdkeTZqNml2ZkhU?=
 =?utf-8?B?V2ZpM1krMTJRS29RMFgxaDF3OXNzNUVhS1BFb25GYnNPaU5iUzVQOTNsWDA0?=
 =?utf-8?B?akdKdllEQWd1eitnTXJCVGdtUVhsYS9UWHNBNHNCYjh3dFY4MHprS1hBN2Nh?=
 =?utf-8?B?NW9WYmhvS2xicGtscDREY1NtYWdDalBIUnFxYWNXVkFraUdabG9lWHpXU3V4?=
 =?utf-8?B?ZFRYMjQ3WDJSb24xOGFSRWR0SkYvWU9WUkdaN1hEN1BFc1ExN0h2WnBIdlpY?=
 =?utf-8?B?bEM2Y25STkRLUTRrUGNKM1NEZ3pZUi8wVXNYTkJmcE9YRGpmL3g0dVoyaEd6?=
 =?utf-8?B?MlJkanhIRzZkTjRDeWorTkxjNXkwaTgreVc1Wlh3SjQ5elFkU0QxQitCSzky?=
 =?utf-8?B?Tk5zWlg5bjBaQmxrNlRJY3BNbGtlRmRaZGMrTVhBNThqVllmQWJkMFhVNnpU?=
 =?utf-8?B?dGk2SSsyaHlzeG5HNS9SSUNnVjl3VmRmOGVRaVdoemlPSGwwV21kUFdXbC9I?=
 =?utf-8?B?cytoMjVQVXREVjBOdmhoa3ZBdldqK0x0UzZPRkM3aFlETlQ4enhJVmNFc0Y0?=
 =?utf-8?B?Y2prNE1zeTVFM1R1SkpQNE5ETDUvZmNscFo4NW81Uk9VMnl1VTNsbDV5aHR2?=
 =?utf-8?B?a216OTNRbm9TUVp6aExWRS9WbDh2SWN2bDBsdCtZckRHZWxOLzlWbWJlU3FI?=
 =?utf-8?B?Z1ByQ3VrTjc0VklRZzFqWVA1RE1YbURUZFl2K2k4ZmJseGFxS2NsZnAzQXl4?=
 =?utf-8?B?L3l3WFJ6VlN5bUJzYWVIMDJvbXRuUXJORDlBZjl1Tkw2R3VHVEtBY1RIaUkw?=
 =?utf-8?B?K0xucCtIY1BZd1VLTlIvTGVGaDBLcUVHUTdCNnFucUpYV0trUG1hMk1zaUdJ?=
 =?utf-8?B?bllldlRIYStuVXdWQ1U5V2dTSkdPank2S2ZRSVNyM0M1Q0ROaC85aURhRXR3?=
 =?utf-8?B?OEZDL2UwaFZNaGdjazlSRnpkL2lwY0R4b1ozdnBibkNqUElzM1hQYjJ0UWFr?=
 =?utf-8?B?Kys1N0ZBR1plWTFBZGoxSU00ZUpMbjZsdFRDWExWM0FoZDFTeWcrWThoK0VG?=
 =?utf-8?B?djZ5VnVNYStJa1N4b3hVd0VVZDlYOFJnMU9MZjlEc2NKdTlyc0xWS216bENs?=
 =?utf-8?B?OUZJa0V6Q1lOQUJXU2lwTU1iS05sNzdrYXp5NG5LRnh3em9YWWdSejVFeThV?=
 =?utf-8?B?b3Q4a2tvQjdqTFNVWCswMnN5RlU5R1BJM0JITDB2OVhlN2I5Q1FUUzkwaHhw?=
 =?utf-8?B?b05hWDVsR1pQbFZOclpLUUdZUitxc2ZsTENtOWR1VktTVXRKeGFnMm9TVzdS?=
 =?utf-8?Q?FusFswPeKSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f87861-77ba-42f6-de37-08da0c309db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 18:20:16.8795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Le2cUPclSkypZMNMweSju/mH6nkxYLcweCG7hIzgRVLsxOgJOUvcik4Ow9zXZhkJCP90YpGER86jExJ6IK45Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIERhbmllbA0KPiBQ
aGlsbGlwcw0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMiwgMjAyMiAxOjI5IFBNDQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUkZDXSBBZGQgS0ZEIGF2YWlsYWJsZSBt
ZW1vcnkgaW9jdGwgdGh1bmsgc3VwcG9ydA0KPiANCj4gSGkgYWxsLA0KPiANCj4gVGhpcyBwYXRj
aCBhZGRzIHRodW5rIHN1cHBvcnQgZm9yIHRoZSBuZXcgS0ZEIG1lbW9yeSBhdmFpbGFiaWxpdHkg
aW9jdGwuDQo+IA0KPiBJIGFtIHBvc3RpbmcgdGhpcyBwYXRjaCBpbmxpbmUgd2l0aCBUaHVuZGVy
YmlyZCBqdXN0IGZvciBub3csIHRvIGVzdGFibGlzaCB0aGUNCj4gcHJpbmNpcGxlIHRoYXQgSSBj
YW4gcG9zdCBwYXRjaGVzL2NvZGUgb2xkIHNjaG9vbCBzdHlsZSB3aXRob3V0IG1hbmdsaW5nDQo+
IHdoaXRlc3BhY2UuIFBsZWFzZSBiZWFyIHdpdGggbWUgd2hpbGUgSSBnZXQgdGhhdCBzb3J0ZWQg
b3V0LiBJIHdpbGwgc3dpdGNoIHRvDQo+IHBvc3Rpbmcgd2l0aCBnaXQgYW0gIHByZXR0eSBzb29u
Lg0KPiANCj4gIGluY2x1ZGUvaHNha210LmggICAgICAgICAgfCAgIDExICsrKysrKysrKysrDQo+
ICBpbmNsdWRlL2xpbnV4L2tmZF9pb2N0bC5oIHwgICAxOCArKysrKysrKysrKysrKysrLS0NCj4g
IHNyYy9tZW1vcnkuYyAgICAgICAgICAgICAgfCAgIDIzICsrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2hzYWtt
dC5oIGIvaW5jbHVkZS9oc2FrbXQuaCBpbmRleCBmZjJkMDIzLi5hYmM2MTdmDQo+IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2hzYWttdC5oDQo+ICsrKyBiL2luY2x1ZGUvaHNha210LmgNCj4gQEAg
LTM3NCw2ICszNzQsMTcgQEAgaHNhS210RnJlZU1lbW9yeSgNCj4gICAgICBIU0F1aW50NjQgICBT
aXplSW5CeXRlcyAgICAgICAgIC8vSU4NCj4gICAgICApOw0KPiANCj4gKy8qKg0KPiArICBJbnF1
aXJlcyBtZW1vcnkgYXZhaWxhYmxlIGZvciBhbGxvY2F0aW9uIGFzIGEgbWVtb3J5IGJ1ZmZlciAq
Lw0KPiArDQo+ICtIU0FLTVRfU1RBVFVTDQo+ICtIU0FLTVRBUEkNCj4gK2hzYUttdEF2YWlsYWJs
ZU1lbW9yeSgNCj4gKyAgICBIU0F1aW50MzIgTm9kZSwNCj4gKyAgICBIU0F1aW50NjQgKkF2YWls
YWJsZUJ5dGVzDQo+ICsgICAgKTsNCj4gKw0KPiAgLyoqDQo+ICAgIFJlZ2lzdGVycyB3aXRoIEtG
RCBhIG1lbW9yeSBidWZmZXIgdGhhdCBtYXkgYmUgYWNjZXNzZWQgYnkgdGhlIEdQVSAgKi8NCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2ZkX2lvY3RsLmggYi9pbmNsdWRlL2xpbnV4L2tm
ZF9pb2N0bC5oIGluZGV4DQo+IDhhMGVkNDkuLmFiZmE5NDggMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgva2ZkX2lvY3RsLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9rZmRfaW9jdGwuaA0K
PiBAQCAtMzQsOSArMzQsMTAgQEANCj4gICAqIC0gMS42IC0gUXVlcnkgY2xlYXIgZmxhZ3MgaW4g
U1ZNIGdldF9hdHRyIEFQSQ0KPiAgICogLSAxLjcgLSBDaGVja3BvaW50IFJlc3RvcmUgKENSSVUp
IEFQSQ0KPiAgICogLSAxLjggLSBDUklVIC0gU3VwcG9ydCBmb3IgU0RNQSB0cmFuc2ZlcnMgd2l0
aCBHVFQgQk9zDQo+ICsgKiAtIDEuOSAtIEFkZCBhdmFpbGFibGVfbWVtb3J5IGlvY3RsDQo+ICAg
Ki8NCj4gICNkZWZpbmUgS0ZEX0lPQ1RMX01BSk9SX1ZFUlNJT04gMQ0KPiAtI2RlZmluZSBLRkRf
SU9DVExfTUlOT1JfVkVSU0lPTiA4DQo+ICsjZGVmaW5lIEtGRF9JT0NUTF9NSU5PUl9WRVJTSU9O
IDkNCj4gDQo+ICAvKg0KPiAgICogRGVidWcgcmV2aXNpb24gY2hhbmdlIGxvZw0KPiBAQCAtNzY5
LDYgKzc3MCwxNiBAQCBzdHJ1Y3Qga2ZkX2lvY3RsX2ZyZWVfbWVtb3J5X29mX2dwdV9hcmdzIHsN
Cj4gIAlfX3U2NCBoYW5kbGU7CQkvKiB0byBLRkQgKi8NCj4gIH07DQo+IA0KPiArLyogSW5xdWly
ZSBhdmFpbGFibGUgbWVtb3J5IHdpdGgga2ZkX2lvY3RsX2dldF9hdmFpbGFibGVfbWVtb3J5DQo+
ICsgKg0KPiArICogQGF2YWlsYWJsZTogbWVtb3J5IGF2YWlsYWJsZSBmb3IgYWxsb2MgICovIHN0
cnVjdA0KPiAra2ZkX2lvY3RsX2dldF9hdmFpbGFibGVfbWVtb3J5X2FyZ3Mgew0KPiArCV9fdTY0
IGF2YWlsYWJsZTsJLyogZnJvbSBLRkQgKi8NCj4gKwlfX3UzMiBncHVfaWQ7CQkvKiB0byBLRkQg
Ki8NCj4gKwlfX3UzMiBwYWQ7DQo+ICt9Ow0KPiArDQo+ICAvKiBNYXAgbWVtb3J5IHRvIG9uZSBv
ciBtb3JlIEdQVXMNCj4gICAqDQo+ICAgKiBAaGFuZGxlOiAgICAgICAgICAgICAgICBtZW1vcnkg
aGFuZGxlIHJldHVybmVkIGJ5IGFsbG9jDQo+IEBAIC0xMzI4LDcgKzEzMzksNyBAQCBzdHJ1Y3Qg
a2ZkX2lvY3RsX3NldF94bmFja19tb2RlX2FyZ3Mgew0KPiAgCQlBTURLRkRfSU9XUigweDIyLCBz
dHJ1Y3Qga2ZkX2lvY3RsX2NyaXVfYXJncykNCj4gDQo+ICAjZGVmaW5lIEFNREtGRF9DT01NQU5E
X1NUQVJUCQkweDAxDQo+IC0jZGVmaW5lIEFNREtGRF9DT01NQU5EX0VORAkJMHgyMw0KPiArI2Rl
ZmluZSBBTURLRkRfQ09NTUFORF9FTkQJCTB4MjQNCj4gDQo+ICAvKiBub24tdXBzdHJlYW0gaW9j
dGxzICovDQo+ICAjZGVmaW5lIEFNREtGRF9JT0NfSVBDX0lNUE9SVF9IQU5ETEUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+IGRpZmYgLS1naXQgYS9zcmMvbWVtb3J5LmMg
Yi9zcmMvbWVtb3J5LmMgaW5kZXggNmQyYTRmNC4uYjJjZDc1OSAxMDA2NDQNCj4gLS0tIGEvc3Jj
L21lbW9yeS5jDQo+ICsrKyBiL3NyYy9tZW1vcnkuYw0KPiBAQCAtMTk5LDYgKzE5OSwyOSBAQCBI
U0FLTVRfU1RBVFVTIEhTQUtNVEFQSQ0KPiBoc2FLbXRGcmVlTWVtb3J5KHZvaWQgKk1lbW9yeUFk
ZHJlc3MsDQo+ICAJcmV0dXJuIGZtbV9yZWxlYXNlKE1lbW9yeUFkZHJlc3MpOw0KPiAgfQ0KPiAN
Cj4gK0hTQUtNVF9TVEFUVVMgSFNBS01UQVBJIGhzYUttdEF2YWlsYWJsZU1lbW9yeShIU0F1aW50
MzIgTm9kZSwNCj4gSFNBdWludDY0DQo+ICsqQXZhaWxhYmxlQnl0ZXMpIHsNCj4gKwlzdHJ1Y3Qg
a2ZkX2lvY3RsX2dldF9hdmFpbGFibGVfbWVtb3J5X2FyZ3MgYXJncyA9IHt9Ow0KPiArCUhTQUtN
VF9TVEFUVVMgcmVzdWx0Ow0KPiArDQo+ICsJQ0hFQ0tfS0ZEX09QRU4oKTsNCj4gKwlDSEVDS19L
RkRfTUlOT1JfVkVSU0lPTig3KTsNCg0KSSB0aGluayB0aGlzIHNob3VsZCBjaGVjayBmb3IgbWlu
b3IgdmVyc2lvbiA5IHRvIG1hdGNoICNkZWZpbmUgS0ZEX0lPQ1RMX01JTk9SX1ZFUlNJT04gOSBp
biBrZmRfaW9jdGwuaA0KDQpSZWdhcmRzLA0KRGF2aWQNCg0KDQo+ICsNCj4gKwlwcl9kZWJ1Zygi
WyVzXSBub2RlICVkXG4iLCBfX2Z1bmNfXywgTm9kZSk7DQo+ICsNCj4gKwlyZXN1bHQgPSB2YWxp
ZGF0ZV9ub2RlaWQoTm9kZSwgJmFyZ3MuZ3B1X2lkKTsNCj4gKwlpZiAocmVzdWx0ICE9IEhTQUtN
VF9TVEFUVVNfU1VDQ0VTUykgew0KPiArCQlwcl9lcnIoIlslc10gaW52YWxpZCBub2RlIElEOiAl
ZFxuIiwgX19mdW5jX18sIE5vZGUpOw0KPiArCQlyZXR1cm4gcmVzdWx0Ow0KPiArCX0NCj4gKw0K
PiArCWlmIChrbXRJb2N0bChrZmRfZmQsIEFNREtGRF9JT0NfQVZBSUxBQkxFX01FTU9SWSwgJmFy
Z3MpKQ0KPiArCQlyZXR1cm4gSFNBS01UX1NUQVRVU19FUlJPUjsNCj4gKw0KPiArCSpBdmFpbGFi
bGVCeXRlcyA9IGFyZ3MuYXZhaWxhYmxlOw0KPiArCXJldHVybiBIU0FLTVRfU1RBVFVTX1NVQ0NF
U1M7DQo+ICt9DQo+ICsNCj4gIEhTQUtNVF9TVEFUVVMgSFNBS01UQVBJIGhzYUttdFJlZ2lzdGVy
TWVtb3J5KHZvaWQNCj4gKk1lbW9yeUFkZHJlc3MsDQo+ICAJCQkJCSAgICAgSFNBdWludDY0IE1l
bW9yeVNpemVJbkJ5dGVzKQ0KPiAgew0K
