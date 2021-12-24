Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B17C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 12:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56F410E39F;
	Fri, 24 Dec 2021 12:31:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506CD10E39F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 12:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBDFlPOB0NC3X5tWVFIVr6rkE5gYl6cgWgskEEM9XdUxBHMWo3sRTTXe3VdCHskZ19bVgOFNFlOf82ZVx1OmkpRjPJ5YTPPtasuVJR25V4IPTPLU7Br8+0lxrf/kMi2s/laEkAzW1iAfpTrwi/D2GaaVrcD3kGlVJm4G3wwXbYxq4qY+I8hL7uF6hQu6Wsj592hkMWwxSo0/7iy1wuXtAh10HihPySqnqfsqY38k4sBKjO1sAE15p1eY3b2/Oq0KwoSmhpKQreOBEt3ZUBTmtTuNR8BjQi9CBjCVyCS5Hp5bnsHVUd3VIHcAOe6gVAnG1PQnM5jG8QIsIe0Ki30cmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gubIW0klza6XfRuTo0B2ScpEUqbdTmdBsfo2R5nkMn4=;
 b=oYs3wyDVNMIyrZk1fMfA4aIWE7bfURLnCJp++ZE4R8aSvh7vWGcg4gvHEYYvo09zjIxsPhOTtkSDOkme/g+Ae3gzSaFcW5ruG44qv7fWph22GAQovP9vsFD8yKHEna+vwPRUlhjD/nOO6SskN9oV9soSAumkCk1kW6PCpjewEx9JrCERLC3tdoMplcQK2hQaZZbVBhXwyAX5hWjjTgw/PHk8yol9ZzIG5PRzqL9pEKQWwgL9I96Mq/kG75xcpjc9d1DFkXDtUYpk46yyl5H0UU7KMITSMq/GJJEAOgfR8mb2uXUkqwELC8SumwJsxB+ZvfhHgiShCFZVE3K0ZkBygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gubIW0klza6XfRuTo0B2ScpEUqbdTmdBsfo2R5nkMn4=;
 b=SiYRiwNwUHv4fbYKO1koxMLc55jGKba13Vlmd3UymA+0ypyeF5iLoubR5DoHcdYVvliN/7+4Lt6tbajXRLaedmdzvB8OVWMKwM5DNXRVAjsDKKYShZhzl0infOdSY8VbqGbbi26v0IV1Syuw721M3PlFf+DHBrZTS04tM5y7Gro=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 12:31:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 12:31:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending
 for BOCO capable platform
Thread-Topic: [PATCH] drm/amdgpu: put SMU into proper state on runpm
 suspending for BOCO capable platform
Thread-Index: AQHX+HS+TBeuyJOlHkuJviFG5gW5OaxBELeAgACAhVA=
Date: Fri, 24 Dec 2021 12:31:19 +0000
Message-ID: <DM6PR12MB261951179C3BBBA560B2BA28E47F9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211224031644.2555373-1-evan.quan@amd.com>
 <2de02d4d-3c68-d8cd-5685-81b1f29b170e@amd.com>
In-Reply-To: <2de02d4d-3c68-d8cd-5685-81b1f29b170e@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-24T12:31:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7476570c-bb97-4dd9-873e-e1f76747dc1e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a3e169-f2a5-47ba-080b-08d9c6d949fb
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR12MB34687018B5FF7ECF31704550E47F9@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WGNozq073hNJDrc4O7Kll6TRJ2HJvLE3WueufDFsE2Dbj7Io+d8oCBH+95XeUkTTAxgJ0wET9uw9xmocTMH626lWEYmaoBGP03VBODnQY6WaevhUbxvj9v3pVpEao4HV5ujOKTrOOvHXBAgZB3bm42r9iod+9EAPXzx9+C5BMJKtrf6LJNcajN54rrWTOwBGj/TkvPP07kxCd5gnjaKPHc3y0HVLH0hVK3C5IxvmME//6QnFvZlmDSVRNayAhI3RqXgeUAulrAjPIszbenCSRTuIvzXBaNy+lqRBlzgox/g1aiUZNCjOUEuvP8ssQnlVda2M8IlIa1ABVdPR2SkAZRB9BSDSrbNa4QR0a1pP9Wf0LCeS/PT7HeZiCLks7F8O0drleyqWHt3vkeIedbnUr1EYeLQlLJ/DgVhoKFr4eis91IqOjqfJERo3riAgx6bYp0Un2ONbqa407pRIfHXWlyKbe3uU9CLN4hg7EDxfvy1fcdO4Q0UmANo2Q2Mjf/xXdUZwDEVBpt+IAt9UTuJMB6qphYesvcRlHLdRgBL4UigjT9G0mY/Ew753KpR+W1KxV9dEbF9bZsNpfP7Z9gvh1sTf1JLB+bEDhufL6cE64Wr+tVFRadH4uyxKWp2KwH7C8AZj6dwaHtL0uwCSgxUgz6PdEnLaFer6dP/SX3G+i0+hLRgGKUmnZK5zEP/p2VyDxdO0pKK4qw3m5ptZywf1vQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(2906002)(316002)(53546011)(6506007)(8676002)(8936002)(54906003)(7696005)(52536014)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(33656002)(508600001)(55016003)(186003)(38070700005)(15650500001)(86362001)(122000001)(71200400001)(5660300002)(9686003)(26005)(4326008)(83380400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3ZCZXBTbkdmeXp0TE5lZllobG0zUng1ekE4bS9RNzZEKzIwZzI2eUNSVlcw?=
 =?utf-8?B?d3VNa0NQckFYc09oSjdYTG9PeXFrUGVoeXFkdndrMlJQVW9iZCtkOGYxcHg1?=
 =?utf-8?B?Mk9UWjg2ZDgwZW4vTmFLRmFoU3hrMkFsc3R0alZwdjR0NDE4YnNhdG5MbmdC?=
 =?utf-8?B?UWZ2Tmo5dUlqQzd3bFB1MEt4WHV0WDFFbnZGb1VRa2lZeFJiS093a1hWZTl4?=
 =?utf-8?B?cmdjbThuNUxaWkJPbW11VXVFUm9qdmRJOHQrWmpDTzNPL0NDTkE0NjY3QUNp?=
 =?utf-8?B?ajhQSVpyMFN2SUxkeHlFemh6M0MxYXBvR2VDUnlaRkxENG15TS9YVU03OHhw?=
 =?utf-8?B?QXZuYlBrZ044djlCODJaS2ZMZGdVUHlLK2dSbFhlc1VNbTJQa2VSRkljMjR2?=
 =?utf-8?B?dzBibjAvOFAwd3NkeThDSXFOZ3hDaVNBZkxIV3A4RS84KzhBR2ltb1FtRmhO?=
 =?utf-8?B?OGV1SWo2QXNwR1RheXNOd3BuaytJSE1nc3JGUHRtUHpIMHVxbDYzcEdWejJV?=
 =?utf-8?B?RDB5RjhvS3J2RDJ0akI4SUV0UnFHaEhnT0ZteTN5WXFpZ3pvUGVKQkhZQ1ZM?=
 =?utf-8?B?WjkwVlBQeGVSSmJVSnNLYVFheVFJWjNlTWwwLzkwSEVKOU5kNVROU1BZV1Fh?=
 =?utf-8?B?VTk4VytoeUp5dVhLT0xFQUJLNmxnR3NKbmxpb2tjWS95QUpETERpNG02aXQw?=
 =?utf-8?B?c1FpNmEvRmhQRkRsUXk4SnZFUUMxMVFzeG1FdzRxQnBTNGo2UFlIL1NWNWZZ?=
 =?utf-8?B?VkdYQlBVLzNSM2svYndXbnVMMGZIcjMzQVhhbWdSemZFc3ZqSTZERloxdk9N?=
 =?utf-8?B?bVZlYnZONjVEejdOYmErQStiVm5UTTgxZnJLR2g2bDJ6Ymc1SG9MT09oaGlS?=
 =?utf-8?B?VUVKQmkxdVhzaUowRXhnb3JrdE9QVmNFd0cvUE9wQmR1cmU4dWhhRW1nb3Q0?=
 =?utf-8?B?eFovNVVzanoyb0lTM3crbXcxQWRsRitmSTd1aWF4YnQ2L21EK1VYKzJuV3Bz?=
 =?utf-8?B?NGxJSTduZ25ROUdaelVsMDJyUnRtU3JqYy9zM1ZKTnl0N1g5Y3ZTOXZyd25Y?=
 =?utf-8?B?d3ZpaHVvQjNuZkhQMHpmenNFcGJXSkVCbFZZVXQxdGhvWW4rZURWTTRXeUtD?=
 =?utf-8?B?WVFXT1R3Z3YrZ3IyU2NPdURPSjNXM2s2WGNXTmZNVWhneEF1NXhMa0s2d1RT?=
 =?utf-8?B?eXB5SkpRa1FBNzNqdmpJaEJWaWpDWGJTb3JxeWd1WEZDWnRPTlRwUDFXQk8y?=
 =?utf-8?B?Q2RjQUdhQ2NDQjEvckM5ZUduQmpIQ0Q1RldELzV5Q1RWdkJQL09waHp1ODhB?=
 =?utf-8?B?T3d6MCsraHVjLzF2a0RhSWxyTWNZMGhucGw1NmM1VmlyMFhicDRlRzBuQnVL?=
 =?utf-8?B?K3ZNZFJvbVR5RzJxQ2taTXFBNXNmWGNUOUVaUXJaTW4zR1NVSlpqMEk1QkR5?=
 =?utf-8?B?cHZDeDNRU1dzbHpFdjZuMkh3cWRQdEpycXIrcHY4eDNvQlZ0dnhHOEs2WXNW?=
 =?utf-8?B?WlRrZ3dMYy9JK1FUcjVQUnJLQmlVZUtsTlVQMkhaYTR0Z1N1Tzh1UTlLSkhB?=
 =?utf-8?B?QnNBcVgzeHRvZTFIZzFxeFhYZFNtMEpkYlp1cFhRSllBRWZ3bUJFVlJCTXJa?=
 =?utf-8?B?enRYcHVScHRKYzBXSmJBUzhieC9rN1VSZ2djRWkvN2Y1dlZQVGhza3ZTRDJH?=
 =?utf-8?B?NUZDVk1RZ1dZRmdhNkJ5SmxMeU9YeThxTDV0cFlvSEFDQ2orbzNpNTltNk91?=
 =?utf-8?B?dW9MM3BFbHJ5NGRNKy9pRWZlbFNnSHBpQlpScnFUdnhzOU93cVBVZExncE9k?=
 =?utf-8?B?d1ltWUdzaVZzLzMxdE0xNXg3dWxpdEc5MEd6V2laaElJb2k3WGhDcE92cUdB?=
 =?utf-8?B?SG9EOVNrc3ZZY1lZd1cwVXU4cGhFTFZJbzhMSGcwTWRrYUdZY20zT21UQTZT?=
 =?utf-8?B?N0lRYWx3a0wvUm5QS2luZUdJL1cweitxNzE1YklGZTdEN0xwaTVFQS9qSENG?=
 =?utf-8?B?M091Q0R3R3Vodm0wOTVLYVZuMHhuUC82Ym1zdXM5U0xpaWhHdXdXY2p6cmtU?=
 =?utf-8?B?RWYwREVMTERIM2NsbU03VXNzb1N3OWk0UVRvZU01Y1pKVzdJQi9qZGx6WUJi?=
 =?utf-8?Q?Npnw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a3e169-f2a5-47ba-080b-08d9c6d949fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 12:31:19.9933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTMNcSaIPsSVRiD9irjf0zbZpwUr7ht4Zsez+7HpglE6qJa40pi/IQhS8Ir7Y3s1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBEZWNlbWJlciAyNCwgMjAyMSAxMjo0NCBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuDQo+
IDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBwdXQgU01VIGludG8gcHJvcGVyIHN0YXRlIG9uIHJ1bnBtDQo+IHN1c3BlbmRpbmcgZm9yIEJP
Q08gY2FwYWJsZSBwbGF0Zm9ybQ0KPiANCj4gDQo+IA0KPiBPbiAxMi8yNC8yMDIxIDg6NDYgQU0s
IEV2YW4gUXVhbiB3cm90ZToNCj4gPiBCeSBzZXR0aW5nIG1wMV9zdGF0ZSBhcyBQUF9NUDFfU1RB
VEVfVU5MT0FELCBNUDEgd2lsbCBkbyBzb21lDQo+IHByb3Blcg0KPiA+IGNsZWFudXBzIGFuZCBw
dXQgaXRzZWxmIGludG8gYSBzdGF0ZSByZWFkeSBmb3IgUE5QKHdoaWNoIGZpdHMgdGhlIHNjZW5h
cmlvDQo+IEJPQ08gc3RhbmRzIGZvcikuDQo+IA0KPiAiQk9DTyBzaW1pbGFyIHRvIFBOUCIgaXMg
bm90IGNvcnJlY3QuIE1lbnRpb24gdGhpcyBhcyBhIHdvcmthcm91bmQuIFdpdGggdGhhdA0KPiBj
aGFuZ2VkDQpbUXVhbiwgRXZhbl0gU29ycnkgZm9yIHRoZSBjb25mdXNpbmcuIEkgZGlkIG5vdCBt
ZWFuICJCT0NPIiA9PSAiUE5QIi4gV2hhdCBJIHdhbnRlZCB0byBleHByZXNzIGlzIGZvciBCT0NP
L1BOUCh1bmxpa2UgQkFDTyksIFNNVSBkb2VzIG5vdCBoYXZlIHRvIGJlIGFsaXZlLg0KRnJvbSB0
aGF0IHBlcnNwZWN0aXZlLCBpdCdzIHJlYXNvbmFibGUgdG8gc2hhcmUgdGhlIFNNVSBjbGVhbnVw
IHByb2Nlc3MgZGVzaWduZWQgZm9yIFBOUCBmb3IgQk9DTy4gQW55d2F5IHRoYW5rcyBmb3IgcG9p
bnRpbmcgdGhpcyBvdXQuIEkgd2lsbCBkcm9wIHRoYXQgY29uZnVzaW5nIGV4cHJlc3Npb24uDQoN
CkJSDQpFdmFuDQo+IAlSZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29t
Pg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+IFRoYXQgY2FuIGFkZHJlc3Mgc29tZSBy
YW5kb20gcmVzdW1pbmcgZmFpbHVyZSBvYnNlcnZlZCBvbiBCT0NPDQo+IGNhcGFibGUgcGxhdGZv
cm1zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNv
bT4NCj4gPiBDaGFuZ2UtSWQ6IEk5ODA0YzRmMDRiNmQyZWY3MzdiMDc2Y2FiZjg1ZDI4ODAxNzll
ZmUyDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMNCj4gPiBpbmRleCBlNDMxYzdmMTA3NTUuLmFkODM3MGI0MWU3NCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBAQCAtMjIzNSwxMiArMjIz
NSwyNyBAQCBzdGF0aWMgaW50DQo+IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ICAgCWlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX3B4KGRybV9k
ZXYpKQ0KPiA+ICAgCQlkcm1fZGV2LT5zd2l0Y2hfcG93ZXJfc3RhdGUgPQ0KPiBEUk1fU1dJVENI
X1BPV0VSX0NIQU5HSU5HOw0KPiA+DQo+ID4gKwkvKg0KPiA+ICsJICogQnkgc2V0dGluZyBtcDFf
c3RhdGUgYXMgUFBfTVAxX1NUQVRFX1VOTE9BRCwgTVAxIHdpbGwgZG8NCj4gc29tZQ0KPiA+ICsJ
ICogcHJvcGVyIGNsZWFudXBzIGFuZCBwdXQgaXRzZWxmIGludG8gYSBzdGF0ZSByZWFkeSBmb3Ig
UE5QLiBUaGF0DQo+ID4gKwkgKiBjYW4gYWRkcmVzcyBzb21lIHJhbmRvbSByZXN1bWluZyBmYWls
dXJlIG9ic2VydmVkIG9uIEJPQ08NCj4gY2FwYWJsZQ0KPiA+ICsJICogcGxhdGZvcm1zLg0KPiA+
ICsJICogVE9ETzogdGhpcyBtYXkgYmUgYWxzbyBuZWVkZWQgZm9yIFBYIGNhcGFibGUgcGxhdGZv
cm0uDQo+ID4gKwkgKi8NCj4gPiArCWlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZHJt
X2RldikpDQo+ID4gKwkJYWRldi0+bXAxX3N0YXRlID0gUFBfTVAxX1NUQVRFX1VOTE9BRDsNCj4g
PiArDQo+ID4gICAJcmV0ID0gYW1kZ3B1X2RldmljZV9zdXNwZW5kKGRybV9kZXYsIGZhbHNlKTsN
Cj4gPiAgIAlpZiAocmV0KSB7DQo+ID4gICAJCWFkZXYtPmluX3J1bnBtID0gZmFsc2U7DQo+ID4g
KwkJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkNCj4gPiArCQkJYWRl
di0+bXAxX3N0YXRlID0gUFBfTVAxX1NUQVRFX05PTkU7DQo+ID4gICAJCXJldHVybiByZXQ7DQo+
ID4gICAJfQ0KPiA+DQo+ID4gKwlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9k
ZXYpKQ0KPiA+ICsJCWFkZXYtPm1wMV9zdGF0ZSA9IFBQX01QMV9TVEFURV9OT05FOw0KPiA+ICsN
Cj4gPiAgIAlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19weChkcm1fZGV2KSkgew0KPiA+ICAg
CQkvKiBPbmx5IG5lZWQgdG8gaGFuZGxlIFBDSSBzdGF0ZSBpbiB0aGUgZHJpdmVyIGZvciBBVFBY
DQo+ID4gICAJCSAqIFBDSSBjb3JlIGhhbmRsZXMgaXQgZm9yIF9QUjMuDQo+ID4NCg==
