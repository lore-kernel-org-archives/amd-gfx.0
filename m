Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C243C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 02:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7913010E163;
	Wed,  3 Jan 2024 02:17:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120A110E163
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 02:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auKGPRDixyPq5C6wOJdHPbFxX7j8vnhfOpOAozfmucVz9esW6zJZf5pV6uBd9lvmDti9S2qYQUePJBzk3sVTZH6Bdm+ELxx3hhmpNvNeMx0nTAgtZhC8X8ND1lpXfMLGNOYFM6CYpYiEylP3ldS5TYTO1wHAdEppCzrpIBATBjEFyoW72X3aka1DsZJjjtuZCAVPcB5/nAzWmCSMKbPUihctUwipL7wURXcTFQ26a3J53HkEur9uk+SkGuBtDQgqKjQlIsTPKZPQ3848vwWkDEw1fpo6g00xto+PSLwixG70/kJ0cKYcm1ovJOzuz52y1DDP55NAG47jPIyy64fqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alq+/PymlHJYNtDP2FQT0cnN/BAKaawO4zWz3OvQpe8=;
 b=H/s34HFT9QGuK8nG5Suda12InWxoshovshcznZpgjyBU3uy4FEHUY6viYT8v1gOqvEIuDQGNwrI6f1NFB+cFpWpL8ulAlTN/amPCh+bmeuHJJLPKuO0tW7CSJU5zchhitzegDmlDwGPei4ZMyNkJz46wwE4wCFz2vLczE/bR9+cINv+6kXdhqJovXQXklNqFHD9S6bYoxTQWULCsXRpvNDJvxH9mvQ5MUBuAiWNKivI8l8dMQQLCKsc4mjKdY3IfIy1NyPyz/TWaxndv3mWsVAc+k/qNquY6BuekMf+fUrel7iAuysZBQF66Pz1ntUF+/QCQNVqlk3NbQVeiDqvm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alq+/PymlHJYNtDP2FQT0cnN/BAKaawO4zWz3OvQpe8=;
 b=aVWjZUoX3aYfrMY9UtCEU9ZFSIQ/duF+1YnYt4uceiWkNBJHCOJ6WBU+NTvtM+/0oBvzksh4pcsfaCY6iT1iaz0CaCFfTmLjtmTlE10Ynrk2VLr/DT9lAAKl7Pcm+IoJedAb+wuu8Fwy/aA352s2zn9/qKFhJUsZ3GW/1lhTn+4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:17:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:17:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: Init pcie_index/data address as fallback
Thread-Topic: [PATCH 2/5] drm/amdgpu: Init pcie_index/data address as fallback
Thread-Index: AQHaPS32QJp0WOWCUE2z2YS980qNI7DG7agAgABt5IA=
Date: Wed, 3 Jan 2024 02:17:32 +0000
Message-ID: <BN9PR12MB52570BF5BBC3FF4E6D786561FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-3-Hawking.Zhang@amd.com>
 <CADnq5_OXqvmzNdjyOS8mNe3kVqAyRuCFRm4GEdiC1v9cSe7hWw@mail.gmail.com>
In-Reply-To: <CADnq5_OXqvmzNdjyOS8mNe3kVqAyRuCFRm4GEdiC1v9cSe7hWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b4150968-1af7-49b0-8391-97dbae6b81e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T02:17:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5949:EE_
x-ms-office365-filtering-correlation-id: 7c49aca9-f488-4735-f573-08dc0c0224e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2CzxtCUtADCbVmwGFZvFyQlvecXR6QG4YaAZKDRFaxeC2qQftuRPssw611++TFeK5s0nvVKpNkd/XNTUg5ryYE6QKknUpCsnE+aXe5YJu0o7eSJkcdBQdyd1v9cW7ML284HvM5r1h9Ki1f56smcwqq9RIY1ytPk40U9M8n9cKR5RPmzSCzfFPjhnKctgbM0GlJr/7opQ2Px81DckDyE4iJHhOYwUqZIfD9lrIsghu9WIdv/c7glZyrvDcVi8VuMVJ1Tse5YeBvAgtxmIjnkDMX2uMxTib3O/YYklwTyB767TEJEqTaca7AMVPCN+VvnB0TasIEAFDG2cM4YNf1x3w4LZEluzEn6TlSvehGPquU6bPNO005xJKYnHW/MyAo2Jtag93sIK3fDhSk2s0AwkrQyq9d5g77u4bD/gQa/W/b/8Pcz78iQIDkjDHk8szn4lqG7JXkqDYpHwkbO+F6fEy3rsM+u+IFDSj7gEsSgemH/cEk+BzJu2abs2Ufz4KwZoPgQsGH1HjoxaCg1+I1TYQkwxr2r51ze4COO4njiaJiwPCX8dudKDepghhkL1DGKdr8KhQJDmbbTMJ66fWliWq5kVQZiCDKt2qrLVrlOTEXh90ItDAFXlAz9rZ4ajs4e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39850400004)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(71200400001)(122000001)(83380400001)(38100700002)(66946007)(76116006)(66556008)(316002)(6916009)(64756008)(66476007)(54906003)(66446008)(478600001)(55016003)(86362001)(5660300002)(2906002)(4326008)(52536014)(8676002)(33656002)(8936002)(38070700009)(7696005)(9686003)(6506007)(53546011)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3RpdVQ2YzJmbGswZnF0TVNicGt4N3hJOUJoZGIvSDVZOFVENDJMNVo0VVMx?=
 =?utf-8?B?UkVaSlVGZGlEc000L1NqYnAyYWtQaHorMHJoVTM3ZGV6TTZHM0VFWlRucTlw?=
 =?utf-8?B?VlhHS3RtakQ3VlpscGxiTEd5RkdCVHE0MHJsNnVGMjI2MlMwL1dCS25pU09D?=
 =?utf-8?B?VUNxcEtvZC9RY3RNMm5WTXVVR2lHWHl0MldKQjVBWjdlRi8zNjJCSkxXMjlE?=
 =?utf-8?B?YXRhSUZ5bzRJcFpoMFQ2UlJGN0tNc0N5OEF6a2xjSXZIN2tBNE0vYWZWaEpu?=
 =?utf-8?B?TGdWVjl6NXdvbytFUk13bmNCSHpNR1hhZjk4WkJtc3llNmRxZEN3c2c4V2lS?=
 =?utf-8?B?ZVBJNGprejEwUUs5WmYxeEJ1Y0NSMktsS2hYRVQyVURwUW5meVF2Nm1CL0RM?=
 =?utf-8?B?a1Z0WS9ZTzVuMThtYmdycWNqM3pQZ1ZrTzBsMGtaVHhIbFp3dVZibndicXRo?=
 =?utf-8?B?K0J2WjlhaDMwdWp1bWVXT0VYTitNdTF1NzF6U1M1dUY1WHhaemtxZEYrbi9j?=
 =?utf-8?B?VStYOHQxVjFNTkFsYlFyMVVCZXhrQ0lhbXBISkx4RWpiS0IrbW0vSDd3QS90?=
 =?utf-8?B?T0xpeFNzcGJrVEhUOHcvMkl3N1lhRnpGTHJFZDEzRDJ6dzlvc1VIS1FJZjZI?=
 =?utf-8?B?WFBZVUMrenV0bkhSU3FTeGtlamNtZ1JrTEQrazkrWTBNZVl5KzVyN2NhUyt0?=
 =?utf-8?B?dVA3aWdOS2xMZXZ2aThEc0R5ZlBvNnR2a0hhL0xQdDlSbGpnS1N3ZGdIWU5K?=
 =?utf-8?B?bEdFSzJDeG8rV1pLRU5aRW0vVEV5MkpidUFkZnhZMFZCSVBadEpLYXpTSlA0?=
 =?utf-8?B?VEtNVVpJOXh2UDhhajlXaEVZd25HMmdDQUVtbXhMRmdmamgydjZxVnJDS0lv?=
 =?utf-8?B?TjM4QjJzUnZLbEplanlQNU8xUHEzR2xiNkt3amNTaFpFYWtkZFV2ZlFTWmhJ?=
 =?utf-8?B?Nm8yQ3Q2WENFQ3ZMdlh3K0E2bU5VbWd1bGRWQ2F6OVkzSStPOHRjVHBMRFNh?=
 =?utf-8?B?TTRIaWZMNE5nWGt1bVhRbmlQUGFGTE4razFSUXB2dm1hWFNIRVUwTGpFM1p4?=
 =?utf-8?B?QlM3SDZJdEFveC9tNEt0MXc5M01NR3k5MXo1YlFzWHRiVi8rNGk2SkNQN1FS?=
 =?utf-8?B?SDdBZWRnN1hKekF4dmhISnZIcXI2aENTN0U0U0haVWlSejhxaVRsUlFFekl1?=
 =?utf-8?B?YkozRmJNYURpU3U5d0xqcCtub2w0YS8yMFl5cm5NWG1RR09rdHI1N3Y5SEVz?=
 =?utf-8?B?UWJ1TWoxMWtwQjducGoxOGlhUXprZkE1UjJSRXVnV0l0S0pFYzRpMk56bVZM?=
 =?utf-8?B?VWVzMEZyMUVkSmcvenZ5L09Nbmx2dVB5UE5wUUs5NGY2NjFyZk5ZdmhaQ0Yw?=
 =?utf-8?B?ankydWZCUUNtMWpLUmYvUUJQMkFua3NEbUlnMmhKWVVYbUkrcXNyT0FabHBR?=
 =?utf-8?B?WTRxNmpaNFJWL0RsS3k5VjVseWNBQ1hoZnlGWlJNSnlxZVFVcUpoSGZCT0xh?=
 =?utf-8?B?NUlHdDNJdzJheVdIOFVJYmd5VXNlM2g0dHE1Y2QxNnZSb2FpenhSNzdTTk5X?=
 =?utf-8?B?U24zbnQ1dmpFZHNVSDhlT0JVc1JXeUpiVnlsK28vZUdYSFJYZ1JaWFJhYnUz?=
 =?utf-8?B?aFZmK3JqclRpZlpnQTc2U1FoblRRNW9LaTRaM0U1ZlYzTy9NTkV5Z09Odnox?=
 =?utf-8?B?VWZOaHIwRjdNZVB2YkVRVUlJRTZKQ0RKSG5ISlNXSWFRRTRZQnFSWVVYZzVr?=
 =?utf-8?B?RnFXM2VNNUU3c3J0Y0IrZTgzV0w2SWZCc2w0ZUNVcWRFUG10THJXSlAzdFFu?=
 =?utf-8?B?aG13djQ0UWg2eHRCUDViSXNURzViK2ozWG5SYWdrR2UzYmIrN05yK290U2tp?=
 =?utf-8?B?YSsvaHV6T0Z4bnhYQnB5L1JVM3BMZEhucGdHZXNBYWFFLzErUnQxb1Z5TFNt?=
 =?utf-8?B?ZE40RW94bzlqVlh1QjBOb3o0bndVMTJkWlhoZ01VV3Y2QVQ5U2RCcDgzNDg3?=
 =?utf-8?B?YzJBdzVIdnFmZVFjNXU3TTFkcVUydk9LRnd4Sm5mNlZWdDJNOXE1czJsc0lu?=
 =?utf-8?B?L2djRDVaMGlVODBUaUc5WVZHb2NSUHZKZ1IxK0tRZ2g1T3hSL2c1V000ZjZq?=
 =?utf-8?Q?8/fZ2Rl23goQWlaGIVHJCNy9v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c49aca9-f488-4735-f573-08dc0c0224e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 02:17:32.7780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8qXqxj0NP8fyFIexICij4tcpIPNWGPaSLxtg8vB/wKquCWWfqPE3VI8Rp9DmjcvxKnohFDCPFrepgc5TE4g4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma,
 Le" <Le.Ma@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClN1cmUsIHdpbGwgZG8gaW4gdjIN
Cg0KUmVnYXJkcywNCkhhd2tpbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5LCBK
YW51YXJ5IDMsIDIwMjQgMDM6NDQNClRvOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsg
V2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMg
PFlpUGVuZy5DaGFpQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTWEsIExlIDxM
ZS5NYUBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi81XSBkcm0vYW1kZ3B1OiBJbml0IHBjaWVfaW5kZXgvZGF0YSBhZGRyZXNz
IGFzIGZhbGxiYWNrDQoNCk9uIE1vbiwgSmFuIDEsIDIwMjQgYXQgMTA6NTDigK9QTSBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBUbyBhbGxvdyB1c2lu
ZyB0aGlzIGhlbHBlciBmb3IgaW5kaXJlY3QgYWNjZXNzIHdoZW4gbmJpbyBmdW5jcyBpcyBub3QN
Cj4gYXZhaWxhYmxlLiBGb3IgaW5zdGFuY2UsIGluIGlwIGRpc2NvdmVyeSBwaGFzZS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIwICsr
KysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiBpbmRleCAwMDFhMzVmYTBmMTkuLjg3MzQxOWE1YjlhYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNzgxLDEy
ICs3ODEsMjIgQEAgdTMyIGFtZGdwdV9kZXZpY2VfaW5kaXJlY3RfcnJlZ19leHQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpwY2llX2luZGV4X2hp
X29mZnNldDsNCj4gICAgICAgICB2b2lkIF9faW9tZW0gKnBjaWVfZGF0YV9vZmZzZXQ7DQo+DQo+
IC0gICAgICAgcGNpZV9pbmRleCA9IGFkZXYtPm5iaW8uZnVuY3MtPmdldF9wY2llX2luZGV4X29m
ZnNldChhZGV2KTsNCj4gLSAgICAgICBwY2llX2RhdGEgPSBhZGV2LT5uYmlvLmZ1bmNzLT5nZXRf
cGNpZV9kYXRhX29mZnNldChhZGV2KTsNCj4gLSAgICAgICBpZiAoKHJlZ19hZGRyID4+IDMyKSAm
JiAoYWRldi0+bmJpby5mdW5jcy0+Z2V0X3BjaWVfaW5kZXhfaGlfb2Zmc2V0KSkNCj4gLSAgICAg
ICAgICAgICAgIHBjaWVfaW5kZXhfaGkgPSBhZGV2LT5uYmlvLmZ1bmNzLT5nZXRfcGNpZV9pbmRl
eF9oaV9vZmZzZXQoYWRldik7DQo+IC0gICAgICAgZWxzZQ0KPiArICAgICAgIGlmICh1bmxpa2Vs
eSghYWRldi0+bmJpby5mdW5jcykpIHsNCj4gKyAgICAgICAgICAgICAgIHBjaWVfaW5kZXggPSAo
MHgzOCA+PiAyKTsNCj4gKyAgICAgICAgICAgICAgIHBjaWVfZGF0YSA9ICgweDNDID4+IDIpOw0K
PiArICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgICBwY2llX2luZGV4ID0gYWRldi0+
bmJpby5mdW5jcy0+Z2V0X3BjaWVfaW5kZXhfb2Zmc2V0KGFkZXYpOw0KPiArICAgICAgICAgICAg
ICAgcGNpZV9kYXRhID0gYWRldi0+bmJpby5mdW5jcy0+Z2V0X3BjaWVfZGF0YV9vZmZzZXQoYWRl
dik7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgaWYgKHJlZ19hZGRyID4+IDMyKSB7DQo+
ICsgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWFkZXYtPm5iaW8uZnVuY3MpKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBwY2llX2luZGV4X2hpID0gKDB4NDQgPj4gMik7DQoNCkknZCBz
dGlsbCB1c2UgYSBkZWZpbmUgZm9yIHRoZXNlLCBFLmcuLA0KDQojZGVmaW5lIEFNREdQVV9QQ0lF
X0lOREVYX0ZBTExCQUNLICgweDM4ID4+IDIpIGV0Yy4NCk9yIHNvbWV0aGluZyBzaW1pbGFyLg0K
DQpBbGV4DQoNCj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGNpZV9pbmRleF9oaSA9IGFkZXYtPm5iaW8uZnVuY3MtPmdldF9wY2llX2luZGV4X2hpX29m
ZnNldChhZGV2KTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgcGNpZV9p
bmRleF9oaSA9IDA7DQo+ICsgICAgICAgfQ0KPg0KPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZl
KCZhZGV2LT5wY2llX2lkeF9sb2NrLCBmbGFncyk7DQo+ICAgICAgICAgcGNpZV9pbmRleF9vZmZz
ZXQgPSAodm9pZCBfX2lvbWVtICopYWRldi0+cm1taW8gKyBwY2llX2luZGV4ICoNCj4gNDsNCj4g
LS0NCj4gMi4xNy4xDQo+DQo=
