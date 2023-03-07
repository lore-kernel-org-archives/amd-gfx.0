Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCECC678D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 07:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FC810E373;
	Tue,  7 Mar 2023 07:48:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BF610E373
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 07:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/+dWZl9u5x22Y5m5utbt+/3NBavalX2d3x4y8QbqQ37StFQfzVSR8ELKzJ10iyTa7ocz2k/w+PsCGWfiUHVfT0lavdC+dfJ+m5/aHNNKGBVb6S4WjK1pTpT2aJZ5iJq8eVvHvB8zwoeOl8RZhbB6TLNpVdd1kiCWug6dIXQNn5zqaXPhZEYPBGkbBX74cGuPufhSVRj6Cwk1D2+gHfAVFJWjcovCPhnstiMCoXrYOmev0v6QDdEtM+DjBOAQUOlowOcDQOhqVDpc83DRNvRErH0SkckhOWSH+6+2wpJiDqTncCNQ2Jnm40/VD9bpIpOI1cNuOVIk3jqzZHiSToMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrXbhz3fTDxoE1abBnDP2dd3ok8BVu6CRiMKI5CoB3E=;
 b=H2GO4hMM07ite/0416bNh65ltm9M+I+01A8CwS/vYUHmvRRRgGKs0w3lkmyydF0S0zrXYrPKraJo1yGvUpZ0Y0wMZODwaZTQfJkHbW+bts/lJbrIjoiqcj6nBRbriiz6GGdy9pa/N8EXyFqlH9e9CvlIF4Z/VOpjJzlGjZ8qqOy3+hY3Xyr3HchrPtanzXPhlUYvwithGyXojHoWqGw2GUNnuVL/Kbj+CB6RO2l7LItZTeemSniegKXevUrbApE1JGj6ndz+ZFSYgR/DowJYhZuLtLaTtIdQaZtrHT4AtoVjtsIc2UAP7OIoyefjrtUdxjduY+xQAjUuo5/Uc+4hPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrXbhz3fTDxoE1abBnDP2dd3ok8BVu6CRiMKI5CoB3E=;
 b=w611esrSF057S2zKymc+EDSvo9tXEL/DD9/OzwXJPGfCQozdR32ada8XeuGKaPb0/wKMIVVYtPdCFURzrDAhr0nPvM0/2A5cQQcQ8pshlRvX8HpJ8TApluwAUfVg/3kqwMf9Kx5iGSFnL1ISS52wA4xrJK5EoPPyAeUR3Y0CEbg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 07:48:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 07:48:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix warning in SVM debug statement
Thread-Topic: [PATCH] drm/amdkfd: fix warning in SVM debug statement
Thread-Index: AQHZUH0ZyPk5uWJXZ02kDdapIa+9D67u8VFA
Date: Tue, 7 Mar 2023 07:48:14 +0000
Message-ID: <DM6PR12MB2619F04CC441681D6CC9FF41E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230306224313.891082-1-alexander.deucher@amd.com>
In-Reply-To: <20230306224313.891082-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T07:48:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57e7ed94-72f1-4cbd-bc63-8861d78d6f3a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS0PR12MB8443:EE_
x-ms-office365-filtering-correlation-id: 182453bc-a932-480a-5c4f-08db1ee04ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pK6+NLyhV3xl6f2Gjeqv3KNvrzWhZG7o0m2lJ7wRyLvFQY64mu4sTJdXyYSGYY2cUgYmCJNtkjE1DCKzmq2q9wlWpRr1wL2Ub3mlG7E7+39L0gCNKsXiXOE89PZJoBxjDc2AxAYLpKC+xN1LJcO00lXySLwhIQO34rAWXEJ2IKk/9vGmhI5qL0UIb6XgLC3xg2wvF3TAuRTi9ODiix0zyDRDKtjF+MAh+k7PIZduGOPUp8YaS6wcr1foD4hmJmBZtTc4nwAhSfPrFU5OLvG4tNCNVaZsz6whH8vieqFao68EqvHrX1g77rgccH0RFl7cKIsoayOOKAQuUCGI1RVrVEfgt+kC5MDyc2/+2kWy89aiLoJ4kBCkjQhAnNO0aMf49cu0efc4G/jDD+h6kMfK5ah3BCbqbtxfwsBw3vUzM8aKn2Qn2E1r9SmE++psrHdX0v5vcJQtHyvo+bSHJIYC7RNg0XkmOu3RDOqy9A1pgkTw7az+glHO+Ce1fr8VA0cjacd1IPxKGuzu/2GmuxKOtKpvwOwVk7tuk7N6yTSbvCrP9symruO355XQost4L9pRuzp9GWzcLJdFPn+GK3piRMpXjdDCEFz8ZN4GvK5cKcBVumiXEA0x4Ibt0m9TRWDZJqCd0zWrqr3Fz/P0kB+OVXMWng58xZQ7HK6vxS/zh/44JseQpljz5Fo/j9IgGxpCw834WhOBw7Nd3vCjSXx7HQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199018)(7696005)(38070700005)(33656002)(76116006)(66946007)(4326008)(41300700001)(64756008)(8936002)(66476007)(66556008)(8676002)(2906002)(5660300002)(66446008)(86362001)(122000001)(38100700002)(110136005)(55016003)(478600001)(316002)(71200400001)(52536014)(6506007)(83380400001)(53546011)(9686003)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0tPSVpxUHFtWUVka1pkM1JJOUFtSHhjaHdZeHFLazlJZ0Q5WHpYaTZabHVa?=
 =?utf-8?B?a0hSQVVNa2w1M3VrOTluRGUxVGkyZ1o3WjluNlNxZ09DWkVMQ0VTdzJGNHRD?=
 =?utf-8?B?VnM0ZTNIRWNQYWU5WHFEMTI1Tnd6SFQxZ0dRT1pMd3BXSnJ5bzNHSFp6Tm8z?=
 =?utf-8?B?bEd6TzFJNDNVcklWVXRPYkQvQmFEM1hQd1JTbFRZSktxc3BPYUp3ZjIzaEt5?=
 =?utf-8?B?a2pMZGpkRzJqMzhyZ2Jqb2V6MFBJS2dpMkkxcDR2Mnp1cldNcWg1aWlkUlor?=
 =?utf-8?B?SEd3eGk2T1pFK0xRRmJwaEYyTHA0Sm90bmR1clRYRmRGSHEvWkd0eisvY3BM?=
 =?utf-8?B?NjZCRzdLZlVCNTRpRXhySFFGYlBYYmRLblE4TXNiYTAvVTBtM3RiWWNTSkFu?=
 =?utf-8?B?S0FXNCtqcUJzMWNwZzFiZ1VlZEtUR3dZS0VzK3RrbW9Sd1NqN0dwSkt0Tm1N?=
 =?utf-8?B?NEM1OG9uOHhKN0hpenpYYmJ5cGk3ZjRkY0J4TXdtQTl2WUUzcFdBekZwdDBI?=
 =?utf-8?B?T1QvRFdKcEhncXZsOEo3dUFYWlZHcnRrR0V1bjgxekxEM2ZTRHhXK2N4enJQ?=
 =?utf-8?B?cEJwdnhuUFMwZWpLV0twQys3RHZHRVh4UUFCTXpoR094YTBFbnNoY0ltcWw0?=
 =?utf-8?B?MDZEZm9KQ2FwTXpoczBQQnpUSUFMRzNvSjh1dHpPM2hLS1FwSlFUaFl5dG9r?=
 =?utf-8?B?QUVuU1dyalRGRlVZUldNQkRHRGd6cVJRQk04aDFoekV5TkdFc0RjODNIWHVZ?=
 =?utf-8?B?YlY3TGV2S2VuOFlRWUlPeTlTNDNLVFArOVBBNHIyWjFPd0xheUhvelk4KzFZ?=
 =?utf-8?B?NFRkUG5OV1QyZjJucjM1OTFwVHNVRmdzWmxoZC9BU2lwRmlEaFJJUHVkUGor?=
 =?utf-8?B?RWJ4aUJnSEx4V0x3ai9QMWV4NG55V1RESGlYRkgzY0l1TUFCMllIeHBjRVUx?=
 =?utf-8?B?bEFTcG5WVnQ3UjNqUklDMEZUK3BDY1UyUENOZC9XSTBtK2hTRmVoa3hNNEtL?=
 =?utf-8?B?WnozUVBGU0RueFlTY0ZDOE1jcEpOUndNVlRaRGJyNGdnTHdFZUJ1SGh2TVBR?=
 =?utf-8?B?WmZ5OWFmTGpMTkh1ai8rQ2wyOUc3VmpGelNsSTJHOFgwYWpQcjRsMHpWcndY?=
 =?utf-8?B?SXNNRis1akdZVStxWTBqNHNJZ21NTXpVQ2dyNTBmbWJZcnczdmVKWjd0MmRu?=
 =?utf-8?B?Z3ZhK1hVakR2b216UFVrVFNiQzBqZ1ljQmdwS3EyREp3NzhHcmVkdmZvaEJE?=
 =?utf-8?B?WG1SOGJEeUhGOU9teE9hM01NRWQrbmNkL0pwTGw1VWJ1YmRkSnpXcVVPcVNl?=
 =?utf-8?B?UkM1amI0WDgzUHZvTUl3bkM2akY0dkpoRmpZZWZhSFdvS3dZQ2phQXBzWDZO?=
 =?utf-8?B?RlZ0VlZyWnVnbUxtcXZ6U1hjQWlqeVA0WnVtUGVocHQ0cXJyYUVueWVLUEs2?=
 =?utf-8?B?SUhWNDhCclFLd1BOeTErYis5d2x4MmVQSGFteU95S0s0akRNZTgxMTZDRUtt?=
 =?utf-8?B?TEsvWDc4aHZvY3RqekE3ckRvdnFJdEZQdWtiWlBYY3p3ZEd5TFV6QnEvUUpV?=
 =?utf-8?B?S2d1enZZRy84ZStkQ3BsZHByZTdYUFV3NDBjN2tHS1FZRncwWk1mZUZOV0ZC?=
 =?utf-8?B?K3lOeEdBZE9XVW1iazE4Z0h3WHUwUVMzTkd5alhSVzlqTGV6cHlBWVczY0Rt?=
 =?utf-8?B?MHZlRklFVmxRRmpxaEg1OXB5R1lJUFZMMmlZdW5uRXREbUw2bVMyMTZhaGpm?=
 =?utf-8?B?L1NLWUMvNitjaWtXdUgwZUhqNzB3MVZPVUdSMmlNR0I1R1lkbk50aFl5VHhH?=
 =?utf-8?B?c2VRRWlGTkdQbnJBUzFwYk5IMHl3VndJWDQ2cnU3MkFNYVB6Ujgwbm4wdVBT?=
 =?utf-8?B?QjdlZForZEoxaUp0SkN4KzgxNWtuMitraHM3YksxcUp5cDRiUXJiQjhFUGpR?=
 =?utf-8?B?dVRXVG9TeXRoRkpxV0tJajcwUHVGQ3NXOWJmRGdHaXJxdXdPRlhKR3IxMklw?=
 =?utf-8?B?Z0ltSWVlQ1RlUHhIMWd5M050ajg1WDBxY2dacjZqTGpmdTMxL0U2cFlWbUpk?=
 =?utf-8?B?SUgrdlNBdEdmQ0M5WFdvb3paREFvMWxVQjBKWDJETjlBZmVBV2JMRy9yNU9s?=
 =?utf-8?Q?EKjQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182453bc-a932-480a-5c4f-08db1ee04ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 07:48:14.8012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6GthArWzWJA4qY3ECqWSQABBooH0Z+Du8lS6lpanAuTb1EooGpgKM+7RP35dqxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBBbGV4DQo+IERldWNoZXINCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNywgMjAy
MyA2OjQzIEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCB3YXJuaW5nIGluIFNWTSBkZWJ1ZyBzdGF0ZW1lbnQNCj4g
DQo+IFByaW50IGEgbG9uZyBsb25nIHZhbHVlLg0KPiANCj4gSW4gZmlsZSBpbmNsdWRlZA0KPiBm
cm9tIC4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
aDozMiwNCj4gICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2FtZGtmZC9rZmRfbWlncmF0ZS5jOjI5Og0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9hbWRrZmQva2ZkX21pZ3JhdGUuYzogSW4gZnVuY3Rpb24NCj4g4oCYc3ZtX21pZ3JhdGVf
Y29weV90b192cmFt4oCZOg0KPiAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGdw
dS9hbWRncHUuaDozNToyMTogd2FybmluZzoNCj4gZm9ybWF0IOKAmCVseOKAmSBleHBlY3RzIGFy
Z3VtZW50IG9mIHR5cGUg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJksIGJ1dCBhcmd1bWVudCA2DQo+
IGhhcyB0eXBlIOKAmHVpbnQ2NF904oCZIHtha2Eg4oCYbG9uZyBsb25nIHVuc2lnbmVkIGludOKA
mX0gWy1XZm9ybWF0PV0NCj4gICAgMzUgfCAjZGVmaW5lIHByX2ZtdChmbXQpICJhbWRncHU6ICIg
Zm10DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+DQo+IC4vaW5jbHVk
ZS9saW51eC9keW5hbWljX2RlYnVnLmg6MjIzOjI5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8NCj4g4oCYcHJfZm104oCZDQo+ICAgMjIzIHwgICAgICAgICAgICAgICAgIGZ1bmMoJmlkLCAj
I19fVkFfQVJHU19fKTsgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4NCj4gLi9pbmNsdWRlL2xpbnV4L2R5bmFt
aWNfZGVidWcuaDoyNDc6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvDQo+IOKAmF9fZHlu
YW1pY19mdW5jX2NhbGxfY2xz4oCZDQo+ICAgMjQ3IHwgICAgICAgICBfX2R5bmFtaWNfZnVuY19j
YWxsX2NscyhfX1VOSVFVRV9JRChkZGVidWcpLCBjbHMsIGZtdCwgZnVuYywNCj4gIyNfX1ZBX0FS
R1NfXykNCj4gICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC4vaW5j
bHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6MjQ5Ojk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBt
YWNybw0KPiDigJhfZHluYW1pY19mdW5jX2NhbGxfY2xz4oCZDQo+ICAgMjQ5IHwgICAgICAgICBf
ZHluYW1pY19mdW5jX2NhbGxfY2xzKF9EUFJJTlRLX0NMQVNTX0RGTFQsIGZtdCwgZnVuYywNCj4g
IyNfX1ZBX0FSR1NfXykNCj4gICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gLi9pbmNsdWRlL2xpbnV4L2R5bmFtaWNfZGVidWcuaDoyNjg6OTogbm90ZTogaW4gZXhwYW5z
aW9uIG9mIG1hY3JvDQo+IOKAmF9keW5hbWljX2Z1bmNfY2FsbOKAmQ0KPiAgIDI2OCB8ICAgICAg
ICAgX2R5bmFtaWNfZnVuY19jYWxsKGZtdCwgX19keW5hbWljX3ByX2RlYnVnLCAgICAgICAgICAg
ICBcDQo+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gLi9pbmNsdWRlL2xp
bnV4L3ByaW50ay5oOjU4MTo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4g4oCYZHlu
YW1pY19wcl9kZWJ1Z+KAmQ0KPiAgIDU4MSB8ICAgICAgICAgZHluYW1pY19wcl9kZWJ1ZyhmbXQs
ICMjX19WQV9BUkdTX18pDQo+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQo+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfbWlncmF0ZS5jOjMwMjo5OiBu
b3RlOiBpbg0KPiBleHBhbnNpb24gb2YgbWFjcm8g4oCYcHJfZGVidWfigJkNCj4gICAzMDIgfCAg
ICAgICAgIHByX2RlYnVnKCJzdm1zIDB4JXAgWzB4JWx4IDB4JWx4IDB4JWx4XVxuIiwgcHJhbmdl
LT5zdm1zLA0KPiBwcmFuZ2UtPnN0YXJ0LA0KPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn4NCj4g
DQo+IEZpeGVzOiBiNzUyMzc0ZmRmM2EgKCJkcm0vYW1ka2ZkOiBGaXggQk8gb2Zmc2V0IGZvciBt
dWx0aS1WTUEgcGFnZQ0KPiBtaWdyYXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbWlncmF0ZS5jDQo+IGluZGV4IGFkMTA5NDAzYjVjYy4uMzkxZGE2YWNiM2U1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4gQEAgLTI5
OSw3ICsyOTksNyBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZp
Y2UNCj4gKmFkZXYsIHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwNCj4gIAl1aW50NjRfdCBpLCBq
Ow0KPiAgCWludCByOw0KPiANCj4gLQlwcl9kZWJ1Zygic3ZtcyAweCVwIFsweCVseCAweCVseCAw
eCVseF1cbiIsIHByYW5nZS0+c3ZtcywNCj4gcHJhbmdlLT5zdGFydCwNCj4gKwlwcl9kZWJ1Zygi
c3ZtcyAweCVwIFsweCVseCAweCVseCAweCVsbHhdXG4iLCBwcmFuZ2UtPnN2bXMsDQo+IHByYW5n
ZS0+c3RhcnQsDQo+ICAJCSBwcmFuZ2UtPmxhc3QsIHR0bV9yZXNfb2Zmc2V0KTsNCj4gDQo+ICAJ
c3JjID0gc2NyYXRjaDsNCj4gLS0NCj4gMi4zOS4yDQo=
