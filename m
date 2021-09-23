Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DA26109E
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00DA26109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548166E111;
	Thu, 23 Sep 2021 14:24:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE3B6E111
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 14:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgIQNthrxF4iu3fkj4isLzFvUUCKtQXqg3VJhIi8FGonVTPxSLw2yRg5AMotJhphjbYLB7Nq80NUYg0zFW7+sJipYTnDc5qG2902+KWZg771IZ7tzCgOBae/wN/2slXFZYs8eEFbAiqnXVyk9CPR5gKLk/ND58lOHTOVp7RFqiThRpI/e9nQ6MJJsUsjMhtiH1dgzWXr+k+7+R1BbP6+OW+SyuskwjlYs0+iI/bJEzHW+MzAHbZICxKx7rw0qW+Amv8MJbHBwK6itihjddgbmfHi2dI7SB1N/bdEE9yT6rpYIaJWY90EBN/G5L/O9t2I0+XlX35K4P2V/Kq2fO5RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WEz3wBr8HzOzgAUdfmXA+lKqiZqpNYAfmaKAo2QtZzA=;
 b=Aua5xTIAvmL0I/hu2kdKpWlSFVaKkJvsPTFXoNPraiRdz0ae8vmf2nZnwLeHTAGuIDcT2QLLNp3D6TYVMGM1/GyBqc8vuFjZ5DeeZFCSlL+ljlhiiyLsEBzhVZ6yOBfZr4wR2JAZmOw3GRoYZWnU37YV3vjhzkccXtUg0lPxaKh7ei+BiCl9l7mgwhGzBEWmqAbFJSjZ1iKSJkQWv0lNvYQhHS4IzEI6wS3qGHvmTK9hbUORfHZ1Er43FK5FSkGj16aAtW6gun+TsfLxuvuhTvw4Ppzoup5NF1QtgegJuzHfpWukIl+TYvz4CFut7XUc6sFC2JMSBMOis4LBtlJqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEz3wBr8HzOzgAUdfmXA+lKqiZqpNYAfmaKAo2QtZzA=;
 b=2AmZMOpWxNnBzSRHEZf07Y6HvJU/1B3kcpvbyypBW51YfWMMcPXCrJstOaX4Mtw6BZujrPiCfBupKMrf+SWDLf46++XsOlqDufO4PhaoAzqW9DwzxA8TH/n5wVPCKBTGd0KefeB0QyywPHsYC5Al+6w7riQ0HS3DLhXQjn55Bk4=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 23 Sep 2021 14:24:32 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 14:24:32 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAAcjgIAAFGOQ
Date: Thu, 23 Sep 2021 14:24:32 +0000
Message-ID: <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
In-Reply-To: <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T14:24:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=48146963-76f6-4417-a8c4-495c6c36956d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93a669fa-1935-4405-34df-08d97e9ddc58
x-ms-traffictypediagnostic: DM5PR1201MB0108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB010854A60FCCC3C65A67B6A1FBA39@DM5PR1201MB0108.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VcvN9AfJiocx1P5BHMRIpMIUexy2/Wue0/SF1Rae1udx/vz7706GBvPPMIijmsOlaPs3g3tzap5HmLVPbWIer3V9uJpBP7OQh5VSYR/mJYN69PYU1oYg0Uh3ogbSkcyRw4CZkQGDQsXgBtfqHcYtGhAK2alDAXKffGTUJV5FUIlGEo/tt5jnWmTBvNMQBfGabwxY5Q4lBFVk4o6X/ejArbiowNgWhWv+GfvzjJzCSh1J3tKzVreKAAz5yC0/BZOmsArnLWAPd2jvQYrsLqA/8Vgd3fPv8AuNQfmV2rdeDqikV2XUykz9JklbtV6mRDSKTJM4i5sscmaiZ3JVUCSU2w65bFnwciH6MRnwH4rR2ZVbuwW3K4rbYcmzH6Q9opmMFEq2W5p3KmsNTaiwR7OvTC7F8tQf6Sgs/yz5Hlw1ig2TFBuCq23xP/3t/ukvnsKCyabIgJ8o1gdJmICggUjgUWsmRX31aHjKMlZZB3JObNUWaYom/+w3tjMan0yFvDRlTYjlHiYDbPPAh34FrF3iDx6z3kf4KNVhxva6qsny5nNo+Jiayk53f2hw3StuAr+up1DrXyFzY2SE+6gJiZeh2wZtCm2pSU43TSuY9NFRrs/xOGSii0s6Ed2jvyL5eBBY6+bWL66khPPKen9Bjvte6KSBMcte4FpOx3X/mo8N2BTfXlWdw2x3on9uwt9l6wrP3Rq5gBQ5Sm7kUOI6YoTD2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(38070700005)(6506007)(53546011)(508600001)(8676002)(9686003)(26005)(52536014)(186003)(71200400001)(122000001)(66556008)(316002)(86362001)(7696005)(64756008)(33656002)(66476007)(83380400001)(54906003)(66946007)(76116006)(8936002)(110136005)(66446008)(55016002)(2906002)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZmNXJUL2ZnMXF4QlQzNG82T241MmFHRTM5c04rWTh6L3AzNW9oV1BPNFpv?=
 =?utf-8?B?bTJFM2NLTllVN0hnRVR2ZmlqMWlXcys5Z2hORnFMa1dQTURibnFlRGhIc0JL?=
 =?utf-8?B?ZHlvZUVoTDhiWGJVK1A2V1dXZnduMXZtUnFNUmtoNFlYZUlvM0VFbWxMTFdN?=
 =?utf-8?B?Ulg2b001SEV3ZUo5SkNRcHNmc0lrbEdoVHVQbTd6a2ppTUtqbTFLU3R4aFdG?=
 =?utf-8?B?YkkzWExtdldoM3JuS01tSDJDajBtUEFHaTNrWkhPNUxjVk9oNGdSQUxiZkFn?=
 =?utf-8?B?bDltdkZmTll4bXY0ejhjNTk5UEJWbjZ4S0NQY3VFUWFSQ3VTMkpkaXZOYnRs?=
 =?utf-8?B?eDhvM01LQkJOWUlNOFJrZDZ5MEoreTZkQUZ1WFlJT0g4N3dRQit3RUp0VTk2?=
 =?utf-8?B?L2FzeVY1Z0dsalF5a2U5ZG5NVzFlNnV5MVdmWU9zbHljZ2l3N0RpWmQwWmU4?=
 =?utf-8?B?VDVMZ0lsbitkbHFRSFhWWU9lcDB0WDZXUTdhRnZ6TmpjOFdqN2dOWDVaZ2ZH?=
 =?utf-8?B?KzdDamhCaVBLcnlCU25EOERQY1J0NkthMjBzV0Z6aWVNbDZiTkVoZWh1dG5w?=
 =?utf-8?B?Q08xZDBZV29hWDQ3QnY2Snl4WThHVWt1Yi9aQUQwaUhaa0JKUXVpc2hWS3hv?=
 =?utf-8?B?cnJIREoycXRRWFJFemcrYVJmWDY2U210UmpvSkhpaXUrQVpFUCt2aUp6SGxK?=
 =?utf-8?B?NytYcUJNNlFMc1BwNWtLNUNFandoVmZ1ZW1MV0l5enVHRTlydEZ6dkFSZWdU?=
 =?utf-8?B?MWJ5a1RLbnNkZ0dFMlNBNVZGcTVhdTFNbmU3MklwSTlHaGtka2l0U3d0NHFq?=
 =?utf-8?B?WVRzUGg5U1FIU0VuSDhpTGk5ZFAvUG9MNlNJUDFGcTF4WUYwTTNmSnJ2cllk?=
 =?utf-8?B?RktQV1l6M2xqby85Vzk0UDY3UXhhcU9uTnA3Qms2T0tVRk95cW9vK2NqNzZk?=
 =?utf-8?B?d2ZOdVRrdlg5cDFiRWgyUTJFNXZicFJ1QVNZN1I1UklLTWcrdklsM05ZWVox?=
 =?utf-8?B?UW4zMVAwQzFnVEh3dXRibVo2OGZkZ3J4dGU1ZlhPSnFORWZCbDM3dlBqWWY3?=
 =?utf-8?B?OTdvcTdRL0g3cExFOHI5cFpMVDFMcktmRTRqRlViNXFDSlBsUDNqZDBMdWRZ?=
 =?utf-8?B?d0FLM1cvT3JyRk5yVnpadVhTbVpRM25xUEtmeUpEb1hmb2VpMDJ6RnNDQUpM?=
 =?utf-8?B?U2pHL1VrbVBvSG1mNE5iTVpzR1NlTDdDWHVlNG1Jd1l5cXVJb2FOZkUyWFkv?=
 =?utf-8?B?TkUxVytQZEtzNStESnlEK1ZrTWMyYUk1WFBKSWNnd29Qb00yWENaeEFLbFFP?=
 =?utf-8?B?dUtqZVNGVVdHL2FILzd4WjVtdWhRditENnFWUnpuUmhDS1JaOFRXSUpXNlNm?=
 =?utf-8?B?dUJVd3RIU3JZb09wTmdKTk5GUDRhSVJ2eUdicGZ1UDY5ejBqeCsxWFdZLzRZ?=
 =?utf-8?B?NmJZQXlhc0dVaVJPQlRqWWMvNXNyVSs1eXJER09WdmI4U2tnSmZJc0VwTnF0?=
 =?utf-8?B?QXpYVkVPc1VnN21iZVFGQi9TWjhZbFN1aXh5UDNqdkRqKzJhallHT0lUd2ZN?=
 =?utf-8?B?WVBWVko1WkhRcEVZYUVHNFAvdlltdU94Mm5xY3orcTFZMEh3UXY3SW5tNG5v?=
 =?utf-8?B?T3V2T0dpME1jQlVpUXlYTVY4OXdzOXovRmZqMUo4bnl1OU1ZWm9GcWhtUkhM?=
 =?utf-8?B?Q0JXWmJJcjZSK1k5Q2kwc3RuWVVUajRIeDU3QlRBUjJ0bXZjWStQZlZvTW1h?=
 =?utf-8?Q?OMNyNqQWtlEDGh2bExafaUgjJQJZvBE2jFBR3t5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a669fa-1935-4405-34df-08d97e9ddc58
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 14:24:32.0294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k13GjEsh+76e7IZEe/7p9O50hWO77Pahoiuo+EiTnCUV0CMpqh3UdzWWwUh83WHbMGsBnGKCdBFfpn9ftHEDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPlNl
bnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjEgODoyNCBQTQ0KPlRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgQ2hyaXN0aWFuIEsgbmlnDQo+
PEMzQjZjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1k
LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRtX2JvX3JlbGVhc2Ug
d2FybmluZw0KPg0KPkFtIDIzLjA5LjIxIHVtIDE0OjA5IHNjaHJpZWIgWXUsIExhbmc6DQo+PiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4NCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIzLCAyMDIxIDc6NDAgUE0N
Cj4+PiBUbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+Pj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT47IENocmlzdGlhbiBLIG5pZw0KPj4+IDxDM0I2Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsg
SHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2tmZDogZml4IHR0bV9ib19yZWxlYXNlIHdhcm5pbmcNCj4+Pg0KPj4+DQo+Pj4NCj4+PiBB
bSAyMy4wOS4yMSB1bSAxMTo0NCBzY2hyaWViIExhbmcgWXU6DQo+Pj4+IElmIGEgQk8gaXMgcGlu
bmVkLCB1bnBpbiBpdCBiZWZvcmUgZnJlZWluZyBpdC4NCj4+Pj4NCj4+Pj4gQ2FsbCBUcmFjZToN
Cj4+Pj4gCXR0bV9ib19wdXQrMHgzMC8weDUwIFt0dG1dDQo+Pj4+IAlhbWRncHVfYm9fdW5yZWYr
MHgxZS8weDMwIFthbWRncHVdDQo+Pj4+IAlhbWRncHVfZ2VtX29iamVjdF9mcmVlKzB4MzQvMHg1
MCBbYW1kZ3B1XQ0KPj4+PiAJZHJtX2dlbV9vYmplY3RfZnJlZSsweDFkLzB4MzAgW2RybV0NCj4+
Pj4gCWFtZGdwdV9hbWRrZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1KzB4MzFmLzB4M2EwIFth
bWRncHVdDQo+Pj4+IAlrZmRfcHJvY2Vzc19kZXZpY2VfZnJlZV9ib3MrMHhhMy8weGYwIFthbWRn
cHVdDQo+Pj4+IAlrZmRfcHJvY2Vzc193cV9yZWxlYXNlKzB4MjI0LzB4MmUwIFthbWRncHVdDQo+
Pj4+IAlwcm9jZXNzX29uZV93b3JrKzB4MjIwLzB4M2MwDQo+Pj4+IAl3b3JrZXJfdGhyZWFkKzB4
NGQvMHgzZjANCj4+Pj4gCWt0aHJlYWQrMHgxMTQvMHgxNTANCj4+Pj4gCXByb2Nlc3Nfb25lX3dv
cmsrMHgzYzAvMHgzYzANCj4+Pj4gCWt0aHJlYWRfcGFyaysweDkwLzB4OTANCj4+Pj4gCXJldF9m
cm9tX2ZvcmsrMHgyMi8weDMwDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPGxh
bmcueXVAYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+IGluZGV4IDJkNmIyZDc3Yjcz
OC4uN2U2OTNiMDY0MDcyIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+IEBAIC0xNTY3LDYgKzE1NjcsOSBA
QCBpbnQNCj5hbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgNCj4+Pj4gICAg
CXByX2RlYnVnKCJSZWxlYXNlIFZBIDB4JWxseCAtIDB4JWxseFxuIiwgbWVtLT52YSwNCj4+Pj4g
ICAgCQltZW0tPnZhICsgYm9fc2l6ZSAqICgxICsgbWVtLT5hcWxfcXVldWUpKTsNCj4+Pj4NCj4+
Pj4gKwlpZiAobWVtLT5iby0+dGJvLnBpbl9jb3VudCkNCj4+Pj4gKwkJYW1kZ3B1X2JvX3VucGlu
KG1lbS0+Ym8pOw0KPj4+PiArDQo+Pj4gTkFLLCB1c2luZyBtZW0tPmJvLT50Ym8ucGluX2NvdW50
IGxpa2UgdGhpcyBpcyBpbGxlZ2FsLg0KPj4gSSBkaWRuJ3QgIGdldCB5b3VyIHBvaW50LiBJIHJl
ZmVycmVkIHRvIGZ1bmN0aW9uLSJ2b2lkDQo+PiBhbWRncHVfYm9fdW5waW4oc3RydWN0IGFtZGdw
dV9ibyAqYm8pIiwgd2hpY2ggdXNlcyBpdCBsaWtlIHRoaXMuDQo+DQo+V2hhdCBhbWRncHVfYm9f
dW5waW4oKSBkb2VzIGlzIHRoZSBmb2xsb3dpbmc6DQo+DQo+IMKgwqDCoMKgwqDCoMKgIHR0bV9i
b191bnBpbigmYm8tPnRibyk7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChiby0+dGJvLnBpbl9jb3Vu
dCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4uLi4uDQo+DQo+
SW4gb3RoZXIgd29yZHMgd2UgdGFrZSBmdXJ0aGVyIGFjdGlvbnMgYmFzZWQgb24gaWYgdGhlIGJ1
ZmZlciB1cyBpcyBzdGlsbCBwaW5uZWQgb3INCj5ub3QgYWZ0ZXIgYW4gdW5waW4gb3BlcmF0aW9u
Lg0KPg0KPldoYXQgeW91IHRyeSB0byBkbyBoZXJlIGlzIHVucGlubmluZyB0aGUgQk8gd2hlbiBp
dCBpcyBwaW5uZWQgaW5kZXBlbmRlbnQgaWYNCj5zb21lYm9keSBlbHNlIG9yIG91ciBjb2RlIGhh
cyBwaW5uZWQgaXQgYmVmb3JlLg0KDQpIaSBDaHJpc3RpYW4sDQoNClRoYW5rcyBmb3IgeW91ciBl
eHBsYW5hdGlvbiBhbmQgYWR2aWNlLiBJIGdvdCB5b3VyIHBvaW50Lg0KQWN0dWFsbHksIHRoZXNl
IEJPcyBhcmUgYWxsb2NhdGVkIGFuZCBwaW5uZWQgZHVyaW5nIGEga2ZkIHByb2Nlc3MgbGlmZWN5
Y2xlLg0KSSB3aWxsIHRyeSB0byBhZGQgYSBmbGFnIGludG8gc3RydWN0IGtnZF9tZW0gdG8gaW5k
aWNhdGUgd2hpY2ggQk8gaXMgcGluZWQgDQphbmQgc2hvdWxkIGJlIHVucGlubmVkLiBXaGljaCB3
aWxsIG1ha2UgYW1kZ3B1X2JvX3Bpbi9hbWRncHVfYm9fdW5waW4gDQpjYWxscyBiYWxhbmNlZC4g
VGhhbmtzIQ0KDQpSZWdhcmRzLA0KTGFuZw0KPg0KPlRoYXQgY2FuIGxlYWQgdG8gYWxsIGtpbmQg
b2YgcHJvYmxlbXMgYW5kIGlzIGNsZWFybHkgaWxsZWdhbC4NCj4NCj4+PiBXaGVyZSB3YXMgdGhl
IEJPIHBpbm5lZCBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+PiBJIGZvdW5kIHR3byBwbGFjZXM6DQo+
Pg0KPj4gCXJldCA9IGtmZF9wcm9jZXNzX2FsbG9jX2dwdXZtKHBkZCwgcXBkLT5pYl9iYXNlLCBQ
QUdFX1NJWkUsIGZsYWdzLA0KPj4gCQkJCSAgICAgICZrYWRkcik7DQo+Pg0KPj4gCXJldCA9IGtm
ZF9wcm9jZXNzX2FsbG9jX2dwdXZtKHBkZCwgcXBkLT5jd3NyX2Jhc2UsDQo+PiAJCQkJICAgICAg
S0ZEX0NXU1JfVEJBX1RNQV9TSVpFLCBmbGFncywgJmthZGRyKTsNCj4NCj5XZWxsIHRoZW4geW91
IG5lZWQgdG8gZmlndXJlIG91dCB3aGVyZSB0aGF0IG1lbW9yeSBpcyBmcmVlZCBhZ2FpbiBhbmQg
cGxhY2UgdGhlDQo+dW5waW4gYXBwcm9wcmlhdGVseS4NCj4NCj5HZW5lcmFsIHJ1bGUgb2YgdGh1
bWIgaXMgdGhhdCBjYWxscyB0byBhbWRncHVfYm9fcGluL2FtZGdwdV9ib191bnBpbiBzaG91bGQN
Cj5iZSBiYWxhbmNlZC4NCj4NCj5SZWdhcmRzLA0KPkNocmlzdGlhbi4NCj4NCj4+IFJlZ2FyZHMs
DQo+PiBMYW5nDQo+Pg0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+PiAgICAJcmV0ID0gdW5yZXNl
cnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4+Pj4NCj4+Pj4gICAgCS8qIFJl
bW92ZSBmcm9tIFZNIGludGVybmFsIGRhdGEgc3RydWN0dXJlcyAqLw0K
