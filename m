Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ABECA0EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 00:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A37110E00C;
	Tue, 12 Sep 2023 00:21:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A4910E00C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 00:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRFUDcH0dVtU1DP79QCLrr2AVcvvAxfL4rE38HQjYUs3vqLwM3Dm6Ej6onf7atvfl7w/Xv/avgz4lzd0eee9MM/9oIOcMogEghQjeChgDseQI+KjoWINKSBFULraOaJmX6aTLXejql7+WoHvWrzbT08ZBuxuUhHXAD7YNwcB48qn52qVbWyYTBSGrZLQFw5vuZfdAOKmVHcrqjDyZOPdEORGerwAhpIYssJVT0ALLWVLN9xjUeVua2PakGe/TvSC7Mj6LtmLj+09tCPX1tEmWuSsFKbz9X0+VXIMHBHlucsqc90Fox6lC3TDwxMGc1cxsfRNF/BEbPQAUYxbmLmVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rm1Z9Ac4VOLgfO9/Ox4SCXkHGXNCaL7/jU/yc6w+tE=;
 b=AgRZsRh+A3EWiTqrBqT02zjadyk2i8d3PrFK1oF4wrmBTURHnjTWHu6ep8/CaVEnetIyeOtQcR3pbhmqdMJfQGM0WxbH2Q6EqwzCVI/HUzmtSwtVYhB5SaliPZ1yL2He9ufvReDqdZb73njRAoXZ1Il/cq5NcniZFmYi7G4LqdIA+9z0B77FhKLJSB3RVexnwE61+Ci9flWsnI+g+EEO6JOIxpipgKYd6f7FD/pcyriNHMko8ecBCSXPR0kgZck6zwzeDenvGoG7I8U6PU4JPg23YC6T626ra5KyXuUtPGAebW0YMnIYiZxNgNer2qts9K/DhNEbUHoN+QmQx27bSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rm1Z9Ac4VOLgfO9/Ox4SCXkHGXNCaL7/jU/yc6w+tE=;
 b=cgc5nEsQAhG3ZXAjsJpBuy4SqhYs7rt95kpUyyF9rFMkZVWxgIi2sO2RKKVOfVpZwwgW3lfKVRxHwjQRG4Y9kzRhPZt7R7WzGfD1675T+D7UPEx7z2MmvKFQz3QcON1OmgKulIJV+seYT+tK7Townq4mZIpO1jXwenCHmtOfniI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 00:21:43 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:21:43 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Thread-Topic: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Thread-Index: AQHZ4gY7TrHrU0ErD0yHmZwYXqeiabAQfQqAgAXXXaA=
Date: Tue, 12 Sep 2023 00:21:42 +0000
Message-ID: <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
In-Reply-To: <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5f8e9bba-0aaf-4004-82ab-bd7af7865fa6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-12T00:01:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|BY5PR12MB4195:EE_
x-ms-office365-filtering-correlation-id: 4f800a07-7c72-46d0-9be0-08dbb3263dbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxFmyiVqpkvIHpDJXWfrPpPUItxuNrAYFB8OXJ7zEJgwTldz1yLdLGTcluXomDgoDD0SeUwXXb7qEdMKqoT0CMQG6rCl8GiI2HR75/5828S2d/YMC1L5w3fT0GG8lEeyR66EFnhxSCEaAI5BVyMHz4QnxiwlQwD0WJKD4b/VUWRNb5tfnpgnj+ZRZ0l2up2uoxgzR8M9OccY0lxY9GLopXgMheb7uBTtNnOArXYisd+LmzTq6n58HC9SXdKUt6OXinkoYoHnlBBfjOPs3hUEjuvQ0Gl8EoV12GOYpxhVx5I1bRdregZYOidSm7pNjLThCgVRtN2Y1yu/97vnukneI8h1N4NAErqNfIBR66n12RWTx5mHPEo7tgeCXqIG/MQ4NLjElWl0LlZSM9yF6nh73XDUrM1qmG3ITTMviFQTJnN4aVKG8hT6bKODyvYBaLWUGIi+lCe3v9FnGKSEArXpHiKUIThZlNuEnyJtHN9TD34RAZ9xSyoQC9gT7rjuPoCl9Vuy05bqfiWvR19OAQ23WLldXYuyHS+bLg9FBelmTIfiD7GVRykQ+PGOitJGPcOpZewyyaGhPDDyXSALr+BsfYll6ZSjGA+xT9tS9++cbF6TQ3TjqbqQFcaaKMx3xBaW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(6506007)(7696005)(53546011)(9686003)(71200400001)(83380400001)(122000001)(86362001)(38100700002)(33656002)(38070700005)(66574015)(55016003)(52536014)(316002)(15650500001)(41300700001)(54906003)(66946007)(8936002)(8676002)(76116006)(66556008)(66446008)(110136005)(4326008)(66476007)(64756008)(478600001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExvS0xFMDB2S08weWlwWmNXZUpxbW1iMEdZQ2NwUXRvUHNnMUltbXo4RDJx?=
 =?utf-8?B?U3F6TzJ3UFZNMDRKU0RPOVZrR3haTit0cW8wZWJzazFyWFRlZFRRM1I4RWtQ?=
 =?utf-8?B?c041ME1IdE44MnkxNVB6STE3Y1RWa0VXWkdMWm9pd2dZU3JLelh0UEZCQzRE?=
 =?utf-8?B?S2tQSEoxM1pMTmhYR1VQd3ZIdERnTll2eTNmUlFtVUpSMzVRWUJUazcxdzdZ?=
 =?utf-8?B?RVNXd3ZPMEVjOGxGUmFwVU9pSHZKWFROelVaMWRoU3ZDeGJwUVppRXh1RVNS?=
 =?utf-8?B?UWZXYU55ZHVZSjlrWU1USGJQanp0d0twZ1lxMmplbU9sY00wSmFWOFNNam53?=
 =?utf-8?B?NjJ1eTJxK3NOVnBzYThGenk0ZlJNZGVjL1drbndBaWJpQUVTbzgvL0NaK2FI?=
 =?utf-8?B?c0ZzVjZYZHdUM3ZsWFJ5Y3ppRGtRUWIzTlFUZ25xL05WSWgrSmxsQmZETXdq?=
 =?utf-8?B?VVhSUlRRTGIvTjlmTEhYejBzYW05RlNSNDgrN1ZYVEdVb1p1V2dvSTFkVWZQ?=
 =?utf-8?B?NmtJSk51RlVsYkhvUTQ0VEg0TSttWXNQekpaeS9hdkxQSFljYnZJYzNmV1BU?=
 =?utf-8?B?cmlBS0xZZTR2SmQxLytQWmFuTDkwbmNxaERORzZyQm9KNVgvcktKLzNoSlJP?=
 =?utf-8?B?cHd2Lzlmdm9MSHhRL29hTFA3elZsT1lXNHNyYW1nQ2JQKzhyK3pLUE55WDN3?=
 =?utf-8?B?WUdrUU9QZ1dPNFE2SStkb1J5UTIxc2UvVXB3bGRTaDBHN2JwWWFhZXJndW1S?=
 =?utf-8?B?c3BrNzlsYUhoOFl0eFkzV3pFNTFkWVBDeWZpRGZFS1A3MithQXgwWXYySmRG?=
 =?utf-8?B?WXlwUERsV01sd1hwU0F1STFvYnpWNXZUQmRPbE1TOVRYTk5PMzZrWWNzTVJ4?=
 =?utf-8?B?WGt6aW5iZW9Tdk1OZTVreVJwTDRPYXRzNy8zOHVlZGh1Y3hBUm1ZTTU2TDh3?=
 =?utf-8?B?d2RCWGhDanNyWU01a0ZlSlMrb0hlUHBrSVJIaU5MMER3clltK3VCeHlodEZN?=
 =?utf-8?B?clFBckNjdHBQRk8zcjNrTC95di9zeWVmWmxYTFdDYy9ia1dqSytSWHZmbGV2?=
 =?utf-8?B?Vi9NRVVneHNxNmdrbE8vdHREQ25MZ2dHbzRiYzc0QjVhV0xYQ1ljMEtVclh0?=
 =?utf-8?B?YllqRUlOcjBNTW91aUNFcXNSUVNmM2F4NEZ4RVZSVlJBOE1rK3p5WWdBVCtr?=
 =?utf-8?B?K2k3aVMwRUc5eFpkVmtXaGs4Q2dyQnVXc0NzZUpOQnBJNmh0a0hBai8xZ0FC?=
 =?utf-8?B?MThoV3lCRTIwQ2g0VnlFZCtqOW9CNng1aWVySnNEQ3QxanNGN3MzSS9wUzlt?=
 =?utf-8?B?WHA5VTZnU1I5RG10dGw1Uk5uc3dDSkdVRGk2TkdsbGtlblg5dTh6YXJVaGFU?=
 =?utf-8?B?Skp1U2pxQVJ2RTZ4dnk3c2NkcWV5VzQ1NE5GTEhoUGQrd1FaUEUxeDVkRmpR?=
 =?utf-8?B?enROZTJEeHdYNGd5QnZ2d05WRXZ5OUladjFydjlVcnhrS2Z3WEJFemp5TGpk?=
 =?utf-8?B?TDZ0aEZNRndxTGZ1bzFlT2l3UGVJRzg4WnhJOExabWNFRHl1c3hENWVqUXFm?=
 =?utf-8?B?Nk9hZ2Voa05KMS9iSnkrZnM1S0JWU0FEM2EyMlQ2bWd2YUNVU040cVF5a3ha?=
 =?utf-8?B?TExoU0R0VHZsa1pRTFdRbHBtemlqdWUxRDh2UmJJdkMxaUpqa2g3MTBMd2xu?=
 =?utf-8?B?K3pGbGliM01qV3FaejlKUys5cXRmTmhZQkhjUTZYdEF2YitQVC9DU3A3WlV6?=
 =?utf-8?B?cExZMzBQRmlQVFpDdXdJdVVjUlJFdW5VV2xRWm5Idm5VYXdWbTRSdktLWEhD?=
 =?utf-8?B?bTRyblFTSE9JUzlQZEF1ZDZyeStTWVdqNWc4SDdnc0s2bDFQOUZVa044VE1D?=
 =?utf-8?B?TUduNTlpRUI4akY0VTI1Y3JTeWF6NzFXNUJ3Q2FuR1JYbzFNRWYvazZ1cWYx?=
 =?utf-8?B?eUx2TWg4RWkybllJZHBnbndsUVhRZ3VHODR4TStlcWowQ2NpNC9hRW9tbnFl?=
 =?utf-8?B?cXNielJ5MWpnTmMwZzNMRERKcFlvWnJIdFRQek5YUXZCNG4yNlA1Qi9KeG5k?=
 =?utf-8?Q?JNXCPc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f800a07-7c72-46d0-9be0-08dbb3263dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 00:21:42.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dznaQ06wIiPnJ78TDDYK5HM22B9LPCoddgH13hM+p/xbrQ7MYtVEAo0KftVG/pve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Fan, Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9oIHllcCwgUGlubmVkIEJPIGlz
IG1vdmVkIHRvIG90aGVyIExSVSBsaXN0LCBTbyBldmljdGlvbiBmYWlscyBiZWNhdXNlIG9mIG90
aGVyIHJlYXNvbi4NCkkgd2lsbCBjaGFuZ2UgdGhlIGNvbW1lbnRzIGluIHRoZSBwYXRjaC4NClRo
ZSBwcm9ibGVtIGlzIGV2aWN0aW9uIGZhaWxzIGFzIG1hbnkgcmVhc29ucywgc2F5LCBCTyBpcyBs
b2NrZWQuDQpBU0FJSywga2ZkIHdpbGwgc3RvcCB0aGUgcXVldWVzIGFuZCBmbHVzaCBzb21lIGV2
aWN0L3Jlc3RvcmUgd29yayBpbiBpdHMgc3VzcGVuZCBjYWxsYmFjay4gU08gdGhlIGZpcnN0IGV2
aWN0aW9uIGJlZm9yZSBrZmQgY2FsbGJhY2sgbGlrZWx5IGZhaWxzLg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+DQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciA4LCAyMDIzIDI6NDkgUE0N
ClRvOiBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRmFu
LCBTaGlrYW5nIDxTaGlrYW5nLkZhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogSWdub3JlIGZpcnN0IGV2Y3Rpb24gZmFpbHVyZSBkdXJpbmcgc3VzcGVuZA0KDQpB
bSAwOC4wOS4yMyB1bSAwNTozOSBzY2hyaWViIHhpbmh1aSBwYW46DQo+IFNvbWUgQk9zIG1pZ2h0
IGJlIHBpbm5lZC4gU28gdGhlIGZpcnN0IGV2aWN0aW9uJ3MgZmFpbHVyZSB3aWxsIGFib3J0DQo+
IHRoZSBzdXNwZW5kIHNlcXVlbmNlLiBUaGVzZSBwaW5uZWQgQk9zIHdpbGwgYmUgdW5waW5lZCBh
ZnRlcndhcmRzDQo+IGR1cmluZyBzdXNwZW5kLg0KDQpUaGF0IGRvZXNuJ3QgbWFrZSBtdWNoIHNl
bnNlIHNpbmNlIHBpbm5lZCBCT3MgZG9uJ3QgY2F1c2UgZXZpY3Rpb24gZmFpbHVyZSBoZXJlLg0K
DQpXaGF0IGV4YWN0bHkgaXMgdGhlIGVycm9yIGNvZGUgeW91IHNlZT8NCg0KQ2hyaXN0aWFuLg0K
DQo+DQo+IEFjdGF1bGx5IGl0IGhhcyBldmljdGVkIG1vc3QgQk9zLCBzbyB0aGF0IHNob3VsZCBz
dGlsIHdvcmsgZmluZSBpbg0KPiBzcmlvdiBmdWxsIGFjY2VzcyBtb2RlLg0KPg0KPiBGaXhlczog
NDdlYTIwNzYyYmI3ICgiZHJtL2FtZGdwdTogQWRkIGFuIGV4dHJhIGV2aWN0X3Jlc291cmNlIGNh
bGwNCj4gZHVyaW5nIGRldmljZV9zdXNwZW5kLiIpDQo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBw
YW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgOSArKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDVjMGUyYjc2NjAyNi4uMzlhZjUy
NmNkYmJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+IEBAIC00MTQ4LDEwICs0MTQ4LDExIEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQo
c3RydWN0IGRybV9kZXZpY2UNCj4gKmRldiwgYm9vbCBmYmNvbikNCj4NCj4gICAgICAgYWRldi0+
aW5fc3VzcGVuZCA9IHRydWU7DQo+DQo+IC0gICAgIC8qIEV2aWN0IHRoZSBtYWpvcml0eSBvZiBC
T3MgYmVmb3JlIGdyYWJiaW5nIHRoZSBmdWxsIGFjY2VzcyAqLw0KPiAtICAgICByID0gYW1kZ3B1
X2RldmljZV9ldmljdF9yZXNvdXJjZXMoYWRldik7DQo+IC0gICAgIGlmIChyKQ0KPiAtICAgICAg
ICAgICAgIHJldHVybiByOw0KPiArICAgICAvKiBUcnkgdG8gZXZpY3QgdGhlIG1ham9yaXR5IG9m
IEJPcyBiZWZvcmUgZ3JhYmJpbmcgdGhlIGZ1bGwgYWNjZXNzDQo+ICsgICAgICAqIElnbm9yZSB0
aGUgcmV0IHZhbCBhdCBmaXJzdCBwbGFjZSBhcyB3ZSB3aWxsIHVucGluIHNvbWUgQk9zIGlmIGFu
eQ0KPiArICAgICAgKiBhZnRlcndhcmRzLg0KPiArICAgICAgKi8NCj4gKyAgICAgKHZvaWQpYW1k
Z3B1X2RldmljZV9ldmljdF9yZXNvdXJjZXMoYWRldik7DQo+DQo+ICAgICAgIGlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpIHsNCj4gICAgICAgICAgICAgICBhbWRncHVfdmlydF9maW5pX2RhdGFf
ZXhjaGFuZ2UoYWRldik7DQoNCg==
