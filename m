Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C4EC7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 16:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99EE10E2B4;
	Mon, 12 Jun 2023 16:19:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397DA10E1A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 16:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIdb3HAIK4LXF2MDdOA/pctMkPxyGx46+cD0hosL/2qFHcnkKrs9SfBuHWtRkfjoRBzv704t2XqumkXrYW83RKaENsDXnCIdWRas1wiW73OMdvLNMirTuqM+cUZBJY0scr4oASDs5H00YNaE+4Ki8mByyF4eLVvejp0wEWJZbqIB/FuE7WVQ5ReVU8DKvzdcw2jYok5/tXQtrdeeKtK60H2rB8g5BtldZzP51Ku2cvT4D3B3s1X2hyXdJX8Ir71aNGUMbClwHrZk3bkSqKGQKSC4bzJC5oKfJd8g+4M/C5LtvDgGL/qk1ANGOTxwQ/FlJukaaibYKh/wdf+lZRCeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWnRwgrIgZwPh8GcSpNYBscCk9pY0H6ZSEPop425DqM=;
 b=Vg0isfXo99wMwCj6d8FrAs4J99DOce9LLixsdxdLEYNZFUu/Wzg/MApqan7KknkQSZ1zELgC1a+cN6OAqTcKtmFDiYNIGVwuamNlQq+pd61g1jxR+4OGAnER/MzaTtFhZTgwut1SjD+It0DTHNJdRoJ908oBGqG2zu1ZowSH4x0sBuQmEgQPADEJVJByf97AVjiaYXmRnq9ilmGa9Aj2lq5kA+9pn4gOlfFxezrXEbcByu7IwPRNE8hNwTzMM7gbrYsxok4OmHlCNR6UhvANCHVFFSN2mk2pmewG9VlS4wNyez5cbeWPkh96dXkytlr1zCmSEUf77NL7+9hoD3psBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWnRwgrIgZwPh8GcSpNYBscCk9pY0H6ZSEPop425DqM=;
 b=LEVlDM7TdZIu/JhrJ9bfr8wS0eJuUVI6zoDPk8S3074kxpoKSCPzfM1fq3MCXUCUNc0dRT+1X3q5CHiR6MiBkSq2uR1EPVVemnqg0yZEIg+SQM2yYEtUOzUv3jHWf8ZnaD2dObE9tUjyskJpbH80MJRAFwnRmtcFyFahw8NTfOQ=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 16:19:03 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::3ce8:2641:818f:ac48]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::3ce8:2641:818f:ac48%6]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 16:19:03 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Thread-Topic: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event
 age unmatchs
Thread-Index: AQHZmxMj4BFKza1cy02xTz4UtC88pK+DEb2AgARJr4A=
Date: Mon, 12 Jun 2023 16:19:03 +0000
Message-ID: <DM6PR12MB50214C152AF8F6E2F6F626B09554A@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20230608170705.2271276-4-James.Zhu@amd.com>
 <20230609204350.2352248-1-James.Zhu@amd.com>
 <3380071c-2673-8e2b-762b-51c2b66baa72@amd.com>
In-Reply-To: <3380071c-2673-8e2b-762b-51c2b66baa72@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-Mentions: James.Zhu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8a85325-f136-473f-b630-7c03e3991958;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T16:13:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|MW3PR12MB4458:EE_
x-ms-office365-filtering-correlation-id: 224ac41f-de1e-4d07-b466-08db6b60bceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGWDopBT3r0CdrzscTX2lY4V728OaQVHoKa9e1Iwc3AJONBjpSGCEHAiNteReotj6iosBUa28pJIouEMxnU33JTcsCJa3/1micdZ9pdeEAV1tWJBNq/Uw4sFQzxP8djD+u+ncyovqP+g6BLJMmB+vLh8Ua/4yelo3BAVThoOESoJrEx29lbody5M5JFLH1IWCjMEFo6VdVK5cdBPge4dlyUy962YmJ4WtnlqUEBelx6zvr6Iowe8y1nKvuCtVsRskXCeIhMFk25ThnRuXVhfV9rsZZb2cd600+5+lq8qtQTID7cr+mvECDhOCctnwn5X/facuV2bFSsepbm2CDqEy5ZnAl3phDl62R6CyoCjcNhhD/Ph8WuQnJ6YAWlm2Rro1Bviy1B7j/wmI87d/0PaTKyMgJJCuJHWUT6WlP1zKv1UFonDmyx/9M9tRxtDfE15o6Z3wSl8OvhUasFNFbl7XWX8r3fh/LP2bhMSfzGxYET/mLqDn9LBttYZvdi7hE0BmvU1W8HkQLj93iiSWjE49mudZjc70oC33xce+oFkISGtLNeHphSOB8gOsMyRNCTX6jzG+UsgUIzo5IeBerYAodjq76t8qNSOziJjtnTcbqR5arZmGyw78xLr7zfdDBj5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(5660300002)(52536014)(8936002)(8676002)(2906002)(66556008)(76116006)(66946007)(64756008)(66476007)(66446008)(110136005)(71200400001)(7696005)(4326008)(9686003)(26005)(6506007)(53546011)(316002)(41300700001)(186003)(83380400001)(478600001)(33656002)(55016003)(38070700005)(38100700002)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dytuODM2UnRxaTNxcE9PRXpNQkU4RjhRdzAwendkemU1OTRJbDJJRXRVWHFI?=
 =?utf-8?B?MkRZMUMxb0lZL29kYlZlL0NzTDc0MGxUSzMxRHpzcFdncXVKamdKQ1d0SVox?=
 =?utf-8?B?UTR6SXBscnltZEliYzA3L0dYSC9tRXVHcFRObitEOEdSa0Z4Sm5GcGdzekIr?=
 =?utf-8?B?ZmdJb25tQVoybEozLzZkTWhXbU9BanZrWlpTRnZRMFRnUXU4amJML2FJZEda?=
 =?utf-8?B?RXg4THFBeFBnRGhzWjdHeEYwZW1pNDNMTUdVQitoRERCb2RYdWRrUnQzczRx?=
 =?utf-8?B?MjIwVTlETmxBNXkrL0tENFRTYUlJL2szUWl2QzMrN0VzNElWYjIrcUpXWHhS?=
 =?utf-8?B?UFlvZHppS2kxMW5IcmhNemYvdEk5K0xEQ1lBWkxhWDNnMk02QjZFbEExMjdE?=
 =?utf-8?B?NW10VWNpNWhoMjdFNUhxNzJxS0c3aEpjQmNwQUNJekxGUlV6ZUJubUhJajNh?=
 =?utf-8?B?bVhhNDBXOHlWL294TEpMald5SWRzdXBwemc5NjNLZlVYWVowUzFFNFVzWWpN?=
 =?utf-8?B?MEw1WWFmckpWcGhJeTliZ3hZSmxidWpXWXJ2MVNyOURiQUVGVVFNYjF1NXFS?=
 =?utf-8?B?QUpCc0VueHQ5OG9yeElwL1E0ZUlLQ2xqRGFVd2dkR0VScmRpM3lVdDJ3R0Jx?=
 =?utf-8?B?SHNiZWlYQ1pteGI4aDRKT2lIVjBxeFFVSGFKMjBhRko3MHdVa3BKcEwwZDFG?=
 =?utf-8?B?ZEdqcldpNmEvNFRmTlhEaUxsODlqZVZDSDdHZkk2MEtOT0o0V3hlaGhrc2Mz?=
 =?utf-8?B?U3NQWEsrcFEwcHBZVXNQMnJXT24rQm93V25KUy8rNkFGVE9BcTBqYXZvUXN4?=
 =?utf-8?B?L05ETW9hcmtUM2IyaEcvRjhiWm9jNkJaS3R3TTU4WTZPangzd1Z6WHF2RVBz?=
 =?utf-8?B?RUZpK1FPMzZCVnNnSk1GOHJSN3RRaXBUVWlIU2NRaVN2TFg4aHBUbGRhSTVI?=
 =?utf-8?B?ckQ3Q3NnWnoxWFZOQTRJcXVqN3BqVnk5R1FiRnluTFpXaC9BWWZRQ0dLMDNH?=
 =?utf-8?B?ZE5wamlQZDN3ZXNIQnEzS2J2RDl6Nlptdmw2SzdLRFQ4aTlZcllKN2Fsd0RR?=
 =?utf-8?B?WTE5b3d3UkNTQTNVYTlJU1JPQWExbnQvOHdrUFdUaEdBVGpkdU5rM1VFMlc4?=
 =?utf-8?B?N3pTdS9yblFxWWtBVXlEazJwMEErK2xlUHhqbGp2THFjMlVWNGFIcmpsK0lV?=
 =?utf-8?B?azg3cjVhenUwNEVrR1JxL0FISXdHYjUyZ1ZiczZTYTBWQmRiYVRZdXdEZWFT?=
 =?utf-8?B?RVFkS21nVWF3UkVTKzdIbzk4RWtTL3NSN3ZaRHU3bHNTVHplbFEwUTlGSFZZ?=
 =?utf-8?B?QzBvL1UzdTUzMS96K2xPKzl1YkYwc0ZUZG1yeU5wUEZ3ZHFRNnc4MytoWWU2?=
 =?utf-8?B?UzFQUml3ckxJcno0UUtJK3lSN3JPSUZuVUt3S3JKSTBDNTBvMGwzN0pYSlFX?=
 =?utf-8?B?RTNSQnlmbUM0bmlXMTIzWitVdUhxMHR6NFdVWUFVVHZHcVFkU0owTVFpVTVj?=
 =?utf-8?B?NFVDeUNyM1JFQ0ZpZ0ZFWUdOWGJNTWhyc0FOQkh3TjRMTlYwZi8yaDlJZ2l0?=
 =?utf-8?B?cld6emlCRmlEY2VTd2o3WGh4bUVBeTZZdUVIYm1tZy9jdTBHa1lxaWI4UEpW?=
 =?utf-8?B?MUZpb0hDYlI2MldlQWtaelgzSGFOaEhPdDdXNkhFcGxrd29CQ1A2NEwrakpR?=
 =?utf-8?B?QmlFQktHMXo1WldVVjR1bUM4S3BPOEhsUS9sK0wzQTAxanZaeGlod1kvdFIv?=
 =?utf-8?B?b1c2d1dJS0plVWJRQlRtL2k0SDRLdDBVL0FFVDY0MWlxWjgwdDJSdU5YMW1v?=
 =?utf-8?B?bFdkcXpUeDBZKytlMEZhWjN2cnNSN1lhOGUrN1VmZUpwbWhTMlRXdEY5dHdM?=
 =?utf-8?B?U0dLOTFLTjhiODBiN2x4cVY4MzZ5T3NBYllxdDU3NkY4MldFaW93S2c2aWph?=
 =?utf-8?B?MWFTaXZ6ZFhNc1FQdVpiYjREbXBzWDJhSTBLS1RROVFQdWJlcFRKM3d4MlVo?=
 =?utf-8?B?QXZtRmh4QmttMFJ3N3NaRmE1WFZTR3I5VVRFMEVlaFc0K0w1YWpXY0F0S0ZM?=
 =?utf-8?B?eEg3QVRwbC9YdTduWTBTNkNiRG1nRVNxZHBjRTdhMEFyWGJNM1JBM2hndlZM?=
 =?utf-8?Q?caNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ac41f-de1e-4d07-b466-08db6b60bceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 16:19:03.3560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTXQRg3dANHN6EG4BPpnNKlXX6c64Lb4YqaU+JxqN+zYu4O2dPS5mKLve0/oiDuseZglPa5b+3VeWBzdYBDt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoZSBjdXJyZW50IFJPQ3IgcGF0
Y2hlcyBhbHJlYWR5IGFkZHJlc3MgbXkgcHJldmlvdXMgZmVlZGJhY2suIEkgYW0gb2sgd2l0aCB0
aGUgY3VycmVudCBST0NyIHBhdGNoZXMuDQoNCkN1cnJlbnRseSwgdGhlcmUgaXMgbm8gUk9DcnRz
dCB0aGF0IHdvdWxkIHN0cmVzcyB0aGlzIG11bHRpcGxlLXdhaXRlcnMgaXNzdWUuIEkgd2FzIHRo
aW5raW5nIHNvbWV0aGluZyBsaWtlIHRoZSBLRkRUZXN0LCBidXQgd2l0aCBieSBjYWxsaW5nIHRo
ZSB3YWl0ZXJzIGZyb20gZGlmZmVyZW50IHRocmVhZHMuIEBaaHUsIEphbWVzIFdvdWxkIHlvdSBo
YXZlIHRpbWUgdG8gbG9vayBpbnRvIHRoaXM/DQoNCn5EYXZpZA0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMgNjo0NCBQTQ0KPiBUbzogWmh1LCBK
YW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQuY29tPjsgWmh1LCBKYW1lcw0K
PiA8SmFtZXMuWmh1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy81XSBkcm0v
YW1ka2ZkOiBzZXQgYWN0aXZhdGVkIGZsYWcgdHJ1ZSB3aGVuIGV2ZW50DQo+IGFnZSB1bm1hdGNo
cw0KPg0KPiAgRnJvbSB0aGUgS0ZEIHBlcnNwZWN0aXZlLCB0aGUgc2VyaWVzIGlzDQo+DQo+IFJl
dmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4NCj4g
RGF2aWQsIEkgbG9va2VkIGF0IHRoZSBST0NyIGFuZCBUaHVuayBjaGFuZ2VzIGFzIHdlbGwsIGFu
ZCB0aGV5IGxvb2sNCj4gcmVhc29uYWJsZSB0byBtZS4gRG8geW91IGhhdmUgYW55IGZlZWRiYWNr
IG9uIHRoZXNlIHBhdGNoZXMgZnJvbSBhIFJPQ3INCj4gcG9pbnQgb2Ygdmlldz8gSXMgdGhlcmUg
YSByZWFzb25hYmxlIHN0cmVzcyB0ZXN0IHRoYXQgY291bGQgYmUgdXNlZCBjaGVjayB0aGF0DQo+
IHRoaXMgaGFuZGxlcyB0aGUgcmFjZSBjb25kaXRpb25zIGFzIGV4cGVjdGVkIGFuZCBhbGxvd3Mg
YWxsIHdhaXRlcnMgdG8gc2xlZXA/DQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZlbGl4DQo+DQo+DQo+
IE9uIDIwMjMtMDYtMDkgMTY6NDMsIEphbWVzIFpodSB3cm90ZToNCj4gPiBTZXQgd2FpdGVyJ3Mg
YWN0aXZhdGVkIGZsYWcgdHJ1ZSB3aGVuIGV2ZW50IGFnZSB1bm1hdGNocyB3aXRoDQo+IGxhc3Rf
ZXZlbnRfYWdlLg0KPiA+DQo+ID4gLXY0OiBhZGQgZXZlbnQgdHlwZSBjaGVjaw0KPiA+IC12NTog
aW1wcm92ZSBvbiBldmVudCBhZ2UgZW5hYmxlIGFuZCBhY3RpdmF0ZWQgZmxhZ3MNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMgfCAxNyArKysrKysr
KysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2V2ZW50cy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZl
bnRzLmMNCj4gPiBpbmRleCBjNzY4OTE4MWNjMjIuLmIyNTg2YTFkZDM1ZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4gPiBAQCAtNDEsNiArNDEs
NyBAQCBzdHJ1Y3Qga2ZkX2V2ZW50X3dhaXRlciB7DQo+ID4gICAgIHdhaXRfcXVldWVfZW50cnlf
dCB3YWl0Ow0KPiA+ICAgICBzdHJ1Y3Qga2ZkX2V2ZW50ICpldmVudDsgLyogRXZlbnQgdG8gd2Fp
dCBmb3IgKi8NCj4gPiAgICAgYm9vbCBhY3RpdmF0ZWQ7ICAgICAgICAgIC8qIEJlY29tZXMgdHJ1
ZSB3aGVuIGV2ZW50IGlzIHNpZ25hbGVkICovDQo+ID4gKyAgIGJvb2wgZXZlbnRfYWdlX2VuYWJs
ZWQ7ICAvKiBzZXQgdG8gdHJ1ZSB3aGVuIGxhc3RfZXZlbnRfYWdlIGlzDQo+ID4gK25vbi16ZXJv
ICovDQo+ID4gICB9Ow0KPiA+DQo+ID4gICAvKg0KPiA+IEBAIC03OTcsOSArNzk4LDkgQEAgc3Rh
dGljIHN0cnVjdCBrZmRfZXZlbnRfd2FpdGVyDQo+ID4gKmFsbG9jX2V2ZW50X3dhaXRlcnModWlu
dDMyX3QgbnVtX2V2ZW50cykNCj4gPg0KPiA+ICAgc3RhdGljIGludCBpbml0X2V2ZW50X3dhaXRl
cihzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ID4gICAgICAgICAgICAgc3RydWN0IGtmZF9ldmVu
dF93YWl0ZXIgKndhaXRlciwNCj4gPiAtICAgICAgICAgICB1aW50MzJfdCBldmVudF9pZCkNCj4g
PiArICAgICAgICAgICBzdHJ1Y3Qga2ZkX2V2ZW50X2RhdGEgKmV2ZW50X2RhdGEpDQo+ID4gICB7
DQo+ID4gLSAgIHN0cnVjdCBrZmRfZXZlbnQgKmV2ID0gbG9va3VwX2V2ZW50X2J5X2lkKHAsIGV2
ZW50X2lkKTsNCj4gPiArICAgc3RydWN0IGtmZF9ldmVudCAqZXYgPSBsb29rdXBfZXZlbnRfYnlf
aWQocCwgZXZlbnRfZGF0YS0+ZXZlbnRfaWQpOw0KPiA+DQo+ID4gICAgIGlmICghZXYpDQo+ID4g
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTgwOCw2ICs4MDksMTUgQEAgc3Rh
dGljIGludCBpbml0X2V2ZW50X3dhaXRlcihzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ID4gICAg
IHdhaXRlci0+ZXZlbnQgPSBldjsNCj4gPiAgICAgd2FpdGVyLT5hY3RpdmF0ZWQgPSBldi0+c2ln
bmFsZWQ7DQo+ID4gICAgIGV2LT5zaWduYWxlZCA9IGV2LT5zaWduYWxlZCAmJiAhZXYtPmF1dG9f
cmVzZXQ7DQo+ID4gKw0KPiA+ICsgICAvKiBsYXN0X2V2ZW50X2FnZSA9IDAgcmVzZXJ2ZWQgZm9y
IGJhY2t3YXJkIGNvbXBhdGlibGUgKi8NCj4gPiArICAgaWYgKHdhaXRlci0+ZXZlbnQtPnR5cGUg
PT0gS0ZEX0VWRU5UX1RZUEVfU0lHTkFMICYmDQo+ID4gKyAgICAgICAgICAgZXZlbnRfZGF0YS0+
c2lnbmFsX2V2ZW50X2RhdGEubGFzdF9ldmVudF9hZ2UpIHsNCj4gPiArICAgICAgICAgICB3YWl0
ZXItPmV2ZW50X2FnZV9lbmFibGVkID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICBpZiAoZXYtPmV2
ZW50X2FnZSAhPSBldmVudF9kYXRhLQ0KPiA+c2lnbmFsX2V2ZW50X2RhdGEubGFzdF9ldmVudF9h
Z2UpDQo+ID4gKyAgICAgICAgICAgICAgICAgICB3YWl0ZXItPmFjdGl2YXRlZCA9IHRydWU7DQo+
ID4gKyAgIH0NCj4gPiArDQo+ID4gICAgIGlmICghd2FpdGVyLT5hY3RpdmF0ZWQpDQo+ID4gICAg
ICAgICAgICAgYWRkX3dhaXRfcXVldWUoJmV2LT53cSwgJndhaXRlci0+d2FpdCk7DQo+ID4gICAg
IHNwaW5fdW5sb2NrKCZldi0+bG9jayk7DQo+ID4gQEAgLTk0OCw4ICs5NTgsNyBAQCBpbnQga2Zk
X3dhaXRfb25fZXZlbnRzKHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4gPiAgICAgICAgICAgICB9DQo+ID4NCj4gPiAtICAg
ICAgICAgICByZXQgPSBpbml0X2V2ZW50X3dhaXRlcihwLCAmZXZlbnRfd2FpdGVyc1tpXSwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVudF9kYXRhLmV2ZW50X2lk
KTsNCj4gPiArICAgICAgICAgICByZXQgPSBpbml0X2V2ZW50X3dhaXRlcihwLCAmZXZlbnRfd2Fp
dGVyc1tpXSwgJmV2ZW50X2RhdGEpOw0KPiA+ICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+ID4gICAgIH0NCg==
