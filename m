Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C06C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAD510F4DE;
	Wed, 13 Apr 2022 07:47:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2C910F4DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDYAuEeeN2Xl+/ShEeF2BS0eNtNbyMlfPyw3hrE72AGM8wact06IGGf/U9pKwB13z7FZyLUg3QyBhoaveEIYljD3Rzz2aUsEVLEm/JmzlQneeLyRvhakXARCpBpMjArVKxv7OOzhWnmIi/Wv14ru08bKQHOtW6koDH8zbVeArezFszjXau6dpyvJVbih9HwalRUVxmyf1VNy54ph3/rpHMFTg62j8j76VNleS7jD0nviuzvuGzwoFPnKnp9CpSeo8/IKDTAA61nmmWRiIBVyJMR5wxpy8bm6HzFaVQ3SB0MQGsioBlSkQ7CRXTVDQwP4sieXM714vg19KM2pwKZSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMQsoPeRaXhpyRabxC1WHRtoRIv5J8V3IKxYU8q/E1I=;
 b=jbNeUV0CuMu96v/63GSFBeqZGNzU6jb08ZxtLp5tbH9LDwk555glMLh4n7bGxWLyhvH/XwOigdef3dvMAfH9H7nI7Av5jqyRGJ1F70yAYJ0fHZ2M0O5g8+id4GdAC/j8LRfFFay7af6yMW4WH5B+Vxjp2I/yZCVtOzJZn4+msmWo6GWP9fD7RNp7rgEHht+e1hJsrvMkN0I/QvtyzWtUWpIvPkAmyz/QYjK26VKBPDwKEtO5fO6UjiydYDCq8E24HD26JjBqCJH2BfBCnuSyHY2Dr88C47cM1TJlSWM2D70u2HO9pEVgftL6V4OZveNqQRUBkIjOGB5mywUSig0W8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMQsoPeRaXhpyRabxC1WHRtoRIv5J8V3IKxYU8q/E1I=;
 b=1vrFrP0vigCmuJtJbjfGQTLvMAEBWOz0tG8lNQ8HL1Rcp6gNDhJoucIJkwU4Q/2E/6xLFtnkzH+9m9SS8xgUfY//mDeIyLNDeGk4i2zRgmrS1k7SrAVzZiqB5I26bShTAckqQBV7kT+6q9wUcfCAizUjwbpu1HsXGAyBLUcNMS8=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Wed, 13 Apr 2022 07:47:16 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3888:87bd:3e3a:e353]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::3888:87bd:3e3a:e353%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 07:47:16 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYWtlIHN1cmUgdHRtIGRlbGF5?=
 =?gb2312?Q?ed_work_finished?=
Thread-Topic: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Thread-Index: AQHYTuPZU/7Ro64TakWKieUGNv+386ztcwcAgAACUYk=
Date: Wed, 13 Apr 2022 07:47:16 +0000
Message-ID: <DM4PR12MB51650F2F831EF872FACA22E487EC9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220413030854.31724-1-xinhui.pan@amd.com>
 <BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9@BN8PR12MB3587.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9@BN8PR12MB3587.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-13T07:47:15.360Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 224d62bb-f6e8-8438-3588-470a79fb9ecf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2102f75-87c1-4b50-f765-08da1d21d4c5
x-ms-traffictypediagnostic: CH0PR12MB5203:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5203B2CE7ACFA9A7CEE6186E87EC9@CH0PR12MB5203.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pkHLBIcX9Islu3xYX3EpRfTDT83HXj4Nhq8//zgwoUSPQ6LLqZRG4C00N1zzjZ6zL1JZFSlPCblSaOEwrmafWgjP0IYWcbgfhqkE9ftmTmHQA1EAiIz8kTYzfzyFl/vZy96eorwsjyv+qHE4S2L4fDTTJ64VyhtDyFpHhFfFpYC8dZDnFjHc9eDyLy/cNGG0eARhhkXXg0oOhbDpH/KvEufR1Yh2R0TrWH7L0UvmHTYlimHBrTzjLM3L9Nz2hNNvrzLmQieBS4mDZWQWvOlfX7G3O3UEQ+vH3D0ROVcknaaSlNujke+Wcaaj7hPnUWEjx3BtSSPtO1Jp+cBEmLcPTqwKaYQKzEN9fkaCLSnl7B+jf1fgNZ9yyIyOe57IbINcl4NIagWBu2aHQWeuPYGqM+8HHpCEDffP2wc8B2Wfxc9f+uoF73X0ykIyGs1xpRFtYTrSiPN+c3y3xn9zRuF1Kitx220ENIcqKCkx+R7gTgylNYBAacn0lbdXymtpmSIYDbhgG7EtgE4ZNxOyQvmg8KeaWMhWBhawNysqJJKH3UjmcQHABSosam07fFoz0le+hU+0mVn0aDn6r3zOCRKtxSOqYqOYrLbbKGhc65X6iT7D1m0vWBogD0UCcXMTooe5XY0yJnadrUeRTnakFVp/AFoI4T7/sN+PkgRkW0vJfNpEW4nhSjlpX6+lwSCZDjvKoexPyX1mPCuoZ0MF3QDZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(224303003)(122000001)(52536014)(5660300002)(8936002)(38070700005)(38100700002)(66446008)(66476007)(66946007)(64756008)(66556008)(55016003)(76116006)(91956017)(4326008)(508600001)(71200400001)(33656002)(9686003)(83380400001)(7696005)(86362001)(186003)(316002)(6506007)(110136005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bk5tTU1wbHd3R0pKS2psZW1Mb3FMTEpSVXFkUTBTRERtMnlleUNjOFFaQ3I3?=
 =?gb2312?B?eGlCWSs3T1AzK3I2aFg2MEo0ZTdhYTQ0SitRMEN5amtyLzY4YjhleFNlT2tX?=
 =?gb2312?B?czNxZzJ6VFRmZnhSL3Jpa0VWNHIzWGl1bDk1VUFDZjhzd2p3cjFUeEZzODZa?=
 =?gb2312?B?bDZ1Vk9mMmN5ZUFDTkJBYUZvSlZpMHZ0WDBwV2g4aVFLSFphbm84SVB2YWFK?=
 =?gb2312?B?UHFZcUFLSzRrTkMrV0xUVUcvd2d4RzhTWmNyOWNrcjZPL0hub29FZ2ZabFl0?=
 =?gb2312?B?cHJXOElNVzBoR1h1SmFoU2VTTzk5R054a3VISnYwWHQxVnRsc1FuQ1R5M2hm?=
 =?gb2312?B?MGluZnhnMTBnTnhpbTN1UXNWQ0F0M3VBcVg5WXRXT3ErV05LSm9xVG11N0JO?=
 =?gb2312?B?cTRSK2RHRWhNSk1oZlRNYkI5NW5SS3BvS1BEVkZVOEJxOGsyTEtCU0dWNVV3?=
 =?gb2312?B?NkQ5ZnIyTGFnRzZjRWdwalJXdEV1L3oraWU5S2p4M1FmWlgzV2VTdDVxb25F?=
 =?gb2312?B?SUEzRlBMa0xLaFdueFl0aFVkUXBPaDNwdFdZR1FOZnA0Q1NEVzh2WkNPdnZ2?=
 =?gb2312?B?UytPK1R2cmZMdHVvbFF4OERSYjluM2w5N2xCSTMvczhVY25Ea08yYmgzbnJs?=
 =?gb2312?B?bmRrOUFoR0JHVHJScCtkeFhVQnNmYU84TW54Q2MzYkpDVjFteDFaaWlIcVZw?=
 =?gb2312?B?aGcrN1BhWkx1Wk51TVk2OVVkUUhQRzFLUUtZOW5ZbU5mMU1xK1ZmdjZhRE12?=
 =?gb2312?B?U0RiMmRIWDFSVmdSTEdKcDdlc0RpS2MzYlAzamdJRjducFVQb255RHV5L0ov?=
 =?gb2312?B?akw5RFNqZnN2QjIvbkk4T1BXWE52RkM4SU1OT05TckJCQysveXd6MmhDVE9t?=
 =?gb2312?B?djU5Y0JHWVplK3BKbXVXb1RLallZcW4xL2cvYUs5TzRmVEZjYUJoSnRrS20v?=
 =?gb2312?B?R1JrSU4wakVnWWVaeCtPY3FRUURDSjBMVVF2M0F3SHZuZlRoQXFGUVFrQUN1?=
 =?gb2312?B?V0lDOUdQUUlnbDF2UkhpOXVpQ2gyMEtXL3hwRGdXOTI3Z3VrcmhZbFozN0ZJ?=
 =?gb2312?B?ekl1blRubStGRlNFQ2RZSm5idjRLOWgvSnpYaFgxRDhwUzVMcFNzbllPVGlH?=
 =?gb2312?B?cUI5ZXk5RE5LbDhPQTBaSXZHTUNGQmgzQTJ1MDRnUjlLclJWNGorQlRRRVMr?=
 =?gb2312?B?Zy9XWi8wOEp3enVBcko0d3JlYXN6VTFEQ2ZtWG9wUEJtTCtkWCs5cGVWK1lo?=
 =?gb2312?B?TzJDK0lQM2JwODA2bWdGb3hsU0tGTWlDU3FORHVyemxvTDJFTmhsQStSd3ZG?=
 =?gb2312?B?STBFYjk2WXV5bzFVVk4xSlN2NjFBNkc2Vk5pSlpRTnJHWFQ2WnNlUTNrcXVH?=
 =?gb2312?B?ZHpBTm9RSkZiRVpHblNyeXhuYWVGQ3RpUy9tVjFSMC9qamluRXcyRzViTlN6?=
 =?gb2312?B?cFd5ZkpZOHFxQ0gyNm5na2d1V0ZnOW44YmpySGkyem1ORmtSd0wxL2VSMjNQ?=
 =?gb2312?B?MTh5SGtkckdHODA1cWlQeGc5UzhMczFOVzB2UTNITkpTdDFtcWdWV2oyNUZv?=
 =?gb2312?B?VlhxQTNQanVQTHdVQmFaQUIzQ0h0MHByWVhZR290MWJuYkV5eVBicHp6S20v?=
 =?gb2312?B?eFowNUFxNmtlSFc1NTZneVJFVTlRV2ZncDRaUU9zUUpCVDNnTUgxUjZhcmFj?=
 =?gb2312?B?OHZTbDJ4N2JvSGJSdE91NWdhMVJzYjd4SE03Y2FzdEFVTGo4ZGNFNUxycW9m?=
 =?gb2312?B?a3IveUdsem9sZVdIK3VUdHJ6RkFENlE5Y0syL0c5UEUzNk9ReEJsQ0lrYU1E?=
 =?gb2312?B?Y2FQMGV5eWZuazdWZzIyV2xWWjNrd0NJS3lVMXVLcm9yUndMa1pjazZWenls?=
 =?gb2312?B?THFmc2Q2QVF3anJ5YXdBU3NWQmJ1eW40RTRjU1JWSndEY1BZMzU4VS8xMG9P?=
 =?gb2312?B?cEFsc0Y3bnNNelVQaHRtU0pZbWFtUXh0ZGIxOG9BdFk3NVFQeXpwM0FmUFVM?=
 =?gb2312?B?cHlURVlsUG14bkdFVmtvQk16QjNBOWFDVVB4Zm1KVjdoUUVhaXY3TTByUTZF?=
 =?gb2312?B?V2VjbWdBYVJPL3lrL0hPeXM2NGdIWkFMWEdXTVJjaW1OZEs0TWp3anB0Mmtt?=
 =?gb2312?B?UDBIUWJUU3k2MzRvb1VTLzBVU1h4dnVtMWsxbHFUdFJsWmlpUU1UWnVBOHI0?=
 =?gb2312?B?aHdydkFnVFJuaU83ZjF5YWdzVGlDeVNndDBDMDJVdk9PSkxWTFhSU2tVVUhP?=
 =?gb2312?B?TXppQzdmZTNvTGVQZ2dBV3hwUko3SHF3QmIwRm1jN0lwblpvWGw3Y3FiTk1w?=
 =?gb2312?Q?MSHCAF5b9Ku/2/n+wt?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2102f75-87c1-4b50-f765-08da1d21d4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 07:47:16.5966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyO3xuRD/p+jOS513BOm2Gnh2LWc6eLkLid0Ov07vt+ddTUx0dDG3mxmcbUImYrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhlIGxvZyBmcm9tIHRlc3RlciBzYXlzIGl0IGlz
IHRoZSBkcm0gZnJhbWVidWZmZXIgQk8gYmVpbmcgYnVzeS4NCg0KSSBqdXN0IGZlZWwgdGhlcmUg
aXMgbGFjayBvZiB0aW1lIGZvciBpdHMgZmVuY2UgdG8gYmUgc2lnbmFsZWQuDQpBcyBhIGRlbGF5
IHdvcmtzIHRvbyBpbiBteSB0ZXN0Lg0KQnV0IHRoZSB3YXJuaW5nIGlzIGEgbGl0dGxlIGFubm95
aW5nLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQq3osvNyrG85Dog
MjAyMsTqNNTCMTPI1SAxNTozMA0KytW8/sjLOiBQYW4sIFhpbmh1aTsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCrOty806IERldWNoZXIsIEFsZXhhbmRlcg0K1vfM4jogQVc6IFtQQVRD
SF0gZHJtL2FtZGdwdTogTWFrZSBzdXJlIHR0bSBkZWxheWVkIHdvcmsgZmluaXNoZWQNCg0KV2Ug
ZG9uJ3QgbmVlZCB0aGF0Lg0KDQpUVE0gb25seSByZXNjaGVkdWxlcyB3aGVuIHRoZSBCT3MgYXJl
IHN0aWxsIGJ1c3kuDQoNCkFuZCBpZiB0aGUgQk9zIGFyZSBzdGlsbCBidXN5IHdoZW4geW91IHVu
bG9hZCB0aGUgZHJpdmVyIHdlIGhhdmUgbXVjaCBiaWdnZXIgcHJvYmxlbXMgdGhhdCB0aGlzIFRU
TSB3b3JrZXIgOikNCg0KUmVnYXJkcywNCkNocmlzdGlhbg0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KVm9uOiBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0KR2Vz
ZW5kZXQ6IE1pdHR3b2NoLCAxMy4gQXByaWwgMjAyMiAwNTowOA0KQW46IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5A
YW1kLmNvbT4NCkJldHJlZmY6IFtQQVRDSF0gZHJtL2FtZGdwdTogTWFrZSBzdXJlIHR0bSBkZWxh
eWVkIHdvcmsgZmluaXNoZWQNCg0KdHRtX2RldmljZV9kZWxheWVkX3dvcmtxdWV1ZSB3b3VsZCBy
ZXNjaGVkdWxlIGl0c2VsZiBpZiB0aGVyZSBpcyBwZW5kaW5nDQpCTyB0byBiZSBkZXN0cm95ZWQu
IFNvIGp1c3Qgb25lIGZsdXNoICsgY2FuY2VsX3N5bmMgaXMgbm90IGVub3VnaC4gV2UNCnN0aWxs
IHNlZSBscnVfbGlzdCBub3QgZW1wdHkgd2FybmdpbmcuDQoNCkZpeCBpdCBieSB3YWl0aW5nIGFs
bCBCTyB0byBiZSBkZXN0cm95ZWQuDQoNClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1
aS5wYW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyB8IDEwICsrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQppbmRleCA2ZjQ3NzI2ZjE3NjUuLmUyNDk5MjNlYjlhNyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQpAQCAtMzk1NywxMSArMzk1NywxNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX3VubWFwX21taW8oc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQogICovDQogdm9pZCBhbWRncHVfZGV2aWNlX2ZpbmlfaHcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQogew0KKyAgICAgICBpbnQgcGVuZGluZyA9IDE7DQorDQogICAgICAg
ICBkZXZfaW5mbyhhZGV2LT5kZXYsICJhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsNCiAg
ICAgICAgIGZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOw0KLSAg
ICAgICBpZiAoYWRldi0+bW1hbi5pbml0aWFsaXplZCkgew0KKyAgICAgICB3aGlsZSAoYWRldi0+
bW1hbi5pbml0aWFsaXplZCAmJiBwZW5kaW5nKSB7DQogICAgICAgICAgICAgICAgIGZsdXNoX2Rl
bGF5ZWRfd29yaygmYWRldi0+bW1hbi5iZGV2LndxKTsNCi0gICAgICAgICAgICAgICB0dG1fYm9f
bG9ja19kZWxheWVkX3dvcmtxdWV1ZSgmYWRldi0+bW1hbi5iZGV2KTsNCisgICAgICAgICAgICAg
ICBwZW5kaW5nID0gdHRtX2JvX2xvY2tfZGVsYXllZF93b3JrcXVldWUoJmFkZXYtPm1tYW4uYmRl
dik7DQorICAgICAgICAgICAgICAgaWYgKHBlbmRpbmcpIHsNCisgICAgICAgICAgICAgICAgICAg
ICAgIHR0bV9ib191bmxvY2tfZGVsYXllZF93b3JrcXVldWUoJmFkZXYtPm1tYW4uYmRldiwgdHJ1
ZSk7DQorICAgICAgICAgICAgICAgICAgICAgICBtc2xlZXAoKEhaIC8gMTAwKSA8IDEpID8gMSA6
IEhaIC8gMTAwKTsNCisgICAgICAgICAgICAgICB9DQogICAgICAgICB9DQogICAgICAgICBhZGV2
LT5zaHV0ZG93biA9IHRydWU7DQoNCi0tDQoyLjI1LjENCg0K
