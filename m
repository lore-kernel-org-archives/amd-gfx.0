Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 13:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5556EBA4;
	Fri, 26 Nov 2021 13:11:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161D76EBA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 13:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqaeCQ8Wfq76TQp8lpIrtvviv8mQ4AEFhg4hYj7zUEwSMulhNvRS+JhEk8oV/ilWZrLmiVTIydZb9+atP37pGKKwijRx2fwtZJzxc7Ajq0yM7b4PvzPt9vjubNxqLm6cER7HIGGkuEWhhOlhNVv1zw8Nogl2dnwF0VUZvmm3kxerUFD3+03+tXHmNXOFvLkuzCsnivizgsgXA5HA73JuuZ1quXNYActHQ/RbT6Rhxo7ltPwCSIW/gRLFIz2+deG6e1FVkf4DWmq8MqsEDUFHD57pI9IHUUkDDPj9PopTVoIXRXH2c8wgfm+ayDKVHF1QOlvIIRNaEPpiyyTtbCbupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKMOEphNSQrzgA6jO6aHhmPbXVUYJKQ/kcrNHMhnnXk=;
 b=HT09ZRhEsX+/ax0VunmZn52bYhj70M0TWjemWLuKzJ5XlXhj83mMsNrqjyDeh1LwibQa2D2bB7hQVhsqU+S6n8ZJnAl02E0HmL+QlXEAHyL9+iqs1ymdOasF0pKkAk8OXh3VY73p0lnoEbbzmxlO9PakQ8lNNc7OaV/MLuLRykErjimeewztWeKY9VFSqSGoXrIbJko8N3ITou38Ypy6b5/ZmRxI07YwNBcwFRTT7dmCk0EhaTgKUpGCtCMwEA0PMZ9MbiaxpBpAkHQLVmSVR6NbZO/m9vqHUDqdADYr8vuVHinjNucWn2Xd2Kb5BwhqY10ioZt/9JfRBTZNIZTk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKMOEphNSQrzgA6jO6aHhmPbXVUYJKQ/kcrNHMhnnXk=;
 b=ujyEhhjpSwfJbFp/RsYbXD6l9DCk3yV3bBJGzkxK/RBQyGrbn7avhPQf0ue8Ln6VqwpnQ+I+DpCwHGadmNIKwJ82iLg+Vdkov7Ym5aAH7fxKu1MgaU94diHEYef+El2/5HeULlRY6JL9AsSSqdTDwPpZt9IdnrxKozm5BkLBSdY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 13:11:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 13:11:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Index: AQHX4qrH3hCO15BNrUuq4KP4/BrMIKwVwNSggAAHCoCAAABOAA==
Date: Fri, 26 Nov 2021 13:11:09 +0000
Message-ID: <BN9PR12MB5257474F4794351E0DD7D6DBFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211126094826.13732-1-Stanley.Yang@amd.com>
 <BN9PR12MB52574BFE341A838E1FDB319CFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM4PR12MB5342E076533F063F000BF8999A639@DM4PR12MB5342.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5342E076533F063F000BF8999A639@DM4PR12MB5342.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T13:11:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe7f4a64-fa8e-45eb-b3be-1ee62c5d2764;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6410fb4-185b-4736-5965-08d9b0de36ed
x-ms-traffictypediagnostic: BN9PR12MB5148:
x-microsoft-antispam-prvs: <BN9PR12MB514888970AB6CFA0EC00A8FCFC639@BN9PR12MB5148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5eESMHHFA3ZZvoh5BA4HPJlAI1m+NO9uCoDQlaEdopzwMLvbSNUcAHY+ZQxVNasjlHFIF3vujN3JkdCyvGHWEFExlYuqJWQHgwERGh5Q6l0j74c4BCMLMkyoQKwOPnd0KVdH77fyo0cw146H6io2+nH7qgYDmpkEVgoz3BU+wYnIqzyAs8PF2gKwxJsQEeDOD26+/uCBfeI6f+PEcPO2liOJCc51ZhJ229ylKRoWjidfqvrFPBFOcpknizlUYv22NjL4P/x0zfrSdf0X3Jx45Q1Vi+v+8pCJfNlbzDdUPehBg2x1XpLbJdostHxdPoB2gqUWOMgEpB44UG6FXwYS3g7kq6b9VvtzUXdz9iJO9gkVmYdgxkFqQVPtY741RSaoTVyokcOL+YgM3vpERqiyNfBz9GqZmVBy+31ImnJgrzP6Nn2BRBNuuSap0Dk1AFEOz7JsFZePmhL9s3xOlvueoRX9X8ue7uY3duFzOyykgoGvXIcKK01nJ2ZzlQaC4nVzHVTMKqQtFI8bvj/5N6a+dyVnAxMUTNACjMUmEdBkNIkP+EIDiqP5gGD4lhEhCxLVyX74bjA02Csi6mdBVQPxggYgp3LXZ2vu7yqyn6I9OyfY9bvbnGUW8Y4ma7h8n1a1FtGkXATBPdNWODAo0LuDZ0aB4vLu0ULbbh5dGzKDllAwscBq9X7Bfyfeewylmsrq3CRsXTUy8WA/lqTizprc4Mz9v2qMXXFTt63TwZxfOw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(71200400001)(66446008)(64756008)(66556008)(55016003)(52536014)(508600001)(53546011)(316002)(86362001)(38070700005)(76116006)(921005)(8676002)(26005)(110136005)(6636002)(66476007)(33656002)(9686003)(2906002)(38100700002)(6506007)(83380400001)(5660300002)(8936002)(122000001)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVcwY3FNQ0tHYlQ2aDRmMTVRNXVTWVFpZjZJSkRUL1VNeVVkZG9vSTJUeWJV?=
 =?utf-8?B?WmIrZ2RuRDFSNU0rSis0aG16V1BGdjhjQU9NWXUzRlozbUFVUklmblZ4clJY?=
 =?utf-8?B?cU9hNjhGeGxFNjJmdXVSWThUV0JON2FkemRweG82b0o4RVg0UVAzSDNzSEZU?=
 =?utf-8?B?WnVUeU1XanAySE1YM2Rsc2kzbjZybWxMT1hjRGx6VUhnVlo4S2daMHNZeUNR?=
 =?utf-8?B?eDZwcXNJYXBMckNTdEtuY2FnY0JPdzF0TktHWFhrZmpZZUsvanFuV3JmK2hP?=
 =?utf-8?B?TkJUVzh1ZWJZTXozTWl4MXZwd3JZbG1ZeW9GVFNLTzY2clcydXJvRTQyWHJz?=
 =?utf-8?B?eU0yUmo3K1FHN2VxL1ROWFVtTWV6eGZlVXhjcDNWempoVzU5Q2RncldDV3p1?=
 =?utf-8?B?Z0NKTWVZMnM0d0tUdnVHNDRPQXh3TW5EL2dxRER6aWoyc1ByR0JKWnBJRXlM?=
 =?utf-8?B?Qmp0VFBXdTJwc29HT1JyTWJYSWduSHM3TVIvdGxpZ3J4Qm1UbzZnQkcrbUta?=
 =?utf-8?B?MmI0TUJWU2pUK2ZpQlR2TWlEUEFQTHVOTVlFdW5HQnZuSDZwaHV0TE1yZzZi?=
 =?utf-8?B?dk1WcUlTUUY1WU9TdWFoMFVzL2FFeTJrdVZtbHZ4dGQ4bWVveE9iblpDbWEv?=
 =?utf-8?B?U0VaLzIxT0t2eUFLR1ZmVzJRN3hjank4ZlphSU5JN1dONmNSRTh5TWgrRmMr?=
 =?utf-8?B?Vk5McEcvM0ZNNytETVdyeDkxSnk5Zm1FNkhic29DTzVxRVpOc2tFcHJGZVho?=
 =?utf-8?B?YTJ5ZThmKzlWcW1yMGNmaGN2emprbmZ6OFZBV1JxKzEyajBjMHRkSVBlN1FJ?=
 =?utf-8?B?anNJRlR2ZWtHODNpeFdqaGREU08xanlBQnB3akljc0FyaHNnRFNSUjVWbHJD?=
 =?utf-8?B?RkxLdXlaUTJnTDQyT1NuS1ZDUEFUSnFmTHl2M2U3NEZWMjUzYS84QXBsa2lw?=
 =?utf-8?B?STN3QlN3SCtvcHhOZGViaUZ5M1JnNVNKSlBPUjJuWmVzVmpkbTVFQmNqNG81?=
 =?utf-8?B?THl5MFlFK2Z5NXRZRWh1QXdESHRsUlBBVWxPSTZHWUpiVFFBcVplSzc0cTJD?=
 =?utf-8?B?a0dxQytDMGFKOVBlbTRaZmNkVEV0dVAyQ3N1TGFvbFo1M09Hd212SDd6dzlI?=
 =?utf-8?B?ZmZaZEllSUc5NEVxRmlZemI0MC9RbXZEZWFxUFpCamE3SU1VcEQxMktLay8x?=
 =?utf-8?B?L3pMeWZiL2I4b1JSekxTdVhsKzRpL0RsWnVPY2NCTFNaeXBWNTdlOG9EOWZr?=
 =?utf-8?B?cUJQK1FYcEJvbmJMNVlCL0grOE5vZEZrTGpNdnR5MXQwYS9BZnkrZU44QnVB?=
 =?utf-8?B?eG51UkZ5Nk9IQnJzN2xOaHZ0RVRtSzNxSTI4eTQvdmd4di9rUDJPYzFEbVBi?=
 =?utf-8?B?S1NUYm1iWFptdmJKTGlVc0tuL0pra2tieE82d0F1TDhaM0E5THpZM0lZQVlD?=
 =?utf-8?B?UTJtZlY4ZjFQVlRvaW15YWl1OVc4UHhCOUNXSGRZMTFDTDdmb201cUt2VEJ6?=
 =?utf-8?B?K2VYdWFtN2dVcXMwbDBCK3FGVXN0Z0JPUnFQcWt4d0hLK015dHJaWXllM3U0?=
 =?utf-8?B?RklYdThZZ0VVdjVTQ2svM0xkb2lFY2xCRGpBZTJTd2VFY3BDRG9YN201emJE?=
 =?utf-8?B?VWZVOXIxK0xQbGFqakd3N3J6Q3JEQkxNSUFhcjFDcW1kN1UrSS93UEpVSER1?=
 =?utf-8?B?RFdjb1dtOVFHT1A3bElxU3BjMXJRQnpEZGFhSmdOSkNFWCtWQ0FtQStmVjdD?=
 =?utf-8?B?Ui9NcmR3VWJ0NXpURG4zbWRkb29LR3FvVWFVSVlPUXd0ZHV6SHA1M2F1VEhS?=
 =?utf-8?B?ME5SbUpJeDlMaG84QzNpbU1QTGVlWGYxcXZqU2Y2VjJScUVTOVNTcUowZXp4?=
 =?utf-8?B?cGQ4Z0ZOcEcvN2NlSnh4OUQrVENxK0FodW5obisxOVp6cVVGbStadUZTQXdQ?=
 =?utf-8?B?dEhLTmdNbVNRZjBzQ2xYdEEwN2laZlNUY1hMUkR4cGdnQ2NqcVVlcEFJb01a?=
 =?utf-8?B?Vmx2dDk1OWxsS1haQ2dHUVdHTFp1Yy91c0NJUGdoVXJMZGZaK3hRaEtCbzdZ?=
 =?utf-8?B?VlYzMHRvdG5CbVYyMG13bFhaWGVEVUNXazEycitvdnJLWkswWUlNd0hLZ2pm?=
 =?utf-8?B?S0RnbGlLaHRidVBBcXdITjh1T0IzakNBblF1a3F1OG5WQjU4UnIwaU03Wmtv?=
 =?utf-8?Q?zBQg0dkp+NQcjAIQM+XLgtM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6410fb4-185b-4736-5965-08d9b0de36ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 13:11:09.7820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ilx51O/kuJ4kaMBWFOcGkqZlDWJz4sjXKQlXANIeYpvqT+lWpoTgyKATml5iAOQUUV9MiVas+4v2J5q/BqkUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSBzdXNwZWN0IGl0IGlzIHN0aWxsIG5lZWRlZCwg
ZXNwZWNpYWxseSB3aGVuIGFtZGdwdV9yYXNfZmluaSBpcyB1c2VkIHRvIGRlYWwgd2l0aCByYXMg
aW5pdGlhbGl6YXRpb24gZmFpbHVyZSBpbiBwc3BfcmFzX2luaXRpYWxpemUuDQoNClJlZ2FyZHMs
DQpIYXdraW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZYW5nLCBTdGFu
bGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI2LCAy
MDIxIDIxOjA4DQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50
c0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8
Q2FuZGljZS5MaUBhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0K
U3ViamVjdDog5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogZml4IGRpc2Fi
bGUgcmFzIGZlYXR1cmUgZmFpbGVkIHdoZW4gdW5sb2FkIGRydmllcg0KDQpbQU1EIE9mZmljaWFs
IFVzZSBPbmx5XQ0KDQpJdCdzIG5vdCBuZWNlc3NhcnksIGJlY2F1c2UgYmVmb3JlIGh3IGZpbmks
IGFsbCByYXMgZmVhdHVyZXMgaGF2ZSBiZWVuIGRpc2FibGVkIGFuZCBjb24tPmZlYXR1cmVzIGlz
IHNldCB0byB6ZXJvLg0KDQpSZWdhcmRzLA0KU3RhbmxleQ0KPiAtLS0tLemCruS7tuWOn+S7ti0t
LS0tDQo+IOWPkeS7tuS6ujogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4N
Cj4g5Y+R6YCB5pe26Ze0OiBGcmlkYXksIE5vdmVtYmVyIDI2LCAyMDIxIDg6NTcgUE0NCj4g5pS2
5Lu25Lq6OiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IGFtZC0gDQo+IGdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFt
ZC5jb20+OyANCj4gWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8
Q2FuZGljZS5MaUBhbWQuY29tPjsgDQo+IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNv
bT4NCj4g5oqE6YCBOiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4g5Li7
6aKYOiBSRTogW1BBVENIIFJldmlldyAxLzFdIGRybS9hbWRncHU6IGZpeCBkaXNhYmxlIHJhcyBm
ZWF0dXJlIGZhaWxlZCANCj4gd2hlbiB1bmxvYWQgZHJ2aWVyDQo+IA0KPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5XQ0KPiANCj4gR29vZCBjYXRjaC4gV2Ugc3RpbGwgbmVlZCB0byByZWxlYXNlIHJh
cyBvYmplY3QgaW4gdGhlIGVuZC4gQW55IHJlYXNvbiANCj4gdGhlIHNlcXVlbmNlIHdhcyByZW1v
dmVkPw0KPiANCj4gQEAgLTI1NjQsOSArMjU2Myw2IEBAIGludCBhbWRncHVfcmFzX2Zpbmkoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+IA0KPiAgCVdBUk4oY29uLT5mZWF0dXJlcywgIkZl
YXR1cmUgbWFzayBpcyBub3QgY2xlYXJlZCIpOw0KPiANCj4gLQlpZiAoY29uLT5mZWF0dXJlcykN
Cj4gLQkJYW1kZ3B1X3Jhc19kaXNhYmxlX2FsbF9mZWF0dXJlcyhhZGV2LCAxKTsNCj4gLQ0KPiAJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb24tPnJhc19jb3VudGVfZGVsYXlfd29yayk7DQo+
IA0KPiBSZWdhcmRzLA0KPiBIYXdraW5nDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTZW50OiBG
cmlkYXksIE5vdmVtYmVyIDI2LCAyMDIxIDE3OjQ4DQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBD
bGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgDQo+IFpob3UxLCBUYW8gPFRh
by5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IA0KPiBD
aGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IENjOiBZYW5nLCBTdGFubGV5IDxT
dGFubGV5LllhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIFJldmlldyAxLzFdIGRybS9h
bWRncHU6IGZpeCBkaXNhYmxlIHJhcyBmZWF0dXJlIGZhaWxlZCANCj4gd2hlbiB1bmxvYWQgZHJ2
aWVyDQo+IA0KPiBGdW5jdGlvbiBhbWRncHVfZGV2aWNlX2ZpbmlfaHcgaXMgY2FsbGVkIGJlZm9y
ZSBhbWRncHVfZGV2aWNlX2Zpbmlfc3csIA0KPiBzbyByYXMgdGEgd2lsbCB1bmxvYWQgYmVmb3Jl
IHNlbmQgcmFzIGRpc2FibGUgY29tbWFuZCwgcmFzIGRzaWFibGUgDQo+IG9wZXJhdGlvbiBtdXN0
IGJlZm9yZSBodyBmaW5pLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxTdGFu
bGV5LllhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgfCA1ICsrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMgICAgfCA0IC0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCA3M2VjNDYxNDBkNjguLmQ1ZTY0MmU5MDAxMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAt
MjgzOCw4ICsyODM4LDYgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX2Zpbmkoc3RydWN0
IA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikg
JiYgYWRldi0+dmlydC5yYXNfaW5pdF9kb25lKQ0KPiAgCQlhbWRncHVfdmlydF9yZWxlYXNlX3Jh
c19lcnJfaGFuZGxlcl9kYXRhKGFkZXYpOw0KPiANCj4gLQlhbWRncHVfcmFzX3ByZV9maW5pKGFk
ZXYpOw0KPiAtDQo+ICAJaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEp
DQo+ICAJCWFtZGdwdV94Z21pX3JlbW92ZV9kZXZpY2UoYWRldik7DQo+IA0KPiBAQCAtMzk1OSw2
ICszOTU3LDkgQEAgdm9pZCBhbWRncHVfZGV2aWNlX2ZpbmlfaHcoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgDQo+ICphZGV2KQ0KPiANCj4gIAlhbWRncHVfZmJkZXZfZmluaShhZGV2KTsNCj4gDQo+ICsJ
LyogZGlzYWJsZSByYXMgZmVhdHVyZSBtdXN0IGJlZm9yZSBodyBmaW5pICovDQo+ICsJYW1kZ3B1
X3Jhc19wcmVfZmluaShhZGV2KTsNCj4gKw0KPiAgCWFtZGdwdV9kZXZpY2VfaXBfZmluaV9lYXJs
eShhZGV2KTsNCj4gDQo+ICAJYW1kZ3B1X2lycV9maW5pX2h3KGFkZXYpOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IDM5ZGZkNGQ1OTg4MS4uNjUx
MDJkMmEwYTk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
DQo+IEBAIC0yNDg0LDcgKzI0ODQsNiBAQCB2b2lkIGFtZGdwdV9yYXNfbGF0ZV9maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlIA0KPiAqYWRldiwNCj4gIAlhbWRncHVfcmFzX3N5c2ZzX3JlbW92ZShh
ZGV2LCByYXNfYmxvY2spOw0KPiAgCWlmIChpaF9pbmZvLT5jYikNCj4gIAkJYW1kZ3B1X3Jhc19p
bnRlcnJ1cHRfcmVtb3ZlX2hhbmRsZXIoYWRldiwgaWhfaW5mbyk7DQo+IC0JYW1kZ3B1X3Jhc19m
ZWF0dXJlX2VuYWJsZShhZGV2LCByYXNfYmxvY2ssIDApOw0KPiAgfQ0KPiANCj4gIC8qIGRvIHNv
bWUgaW5pdCB3b3JrIGFmdGVyIElQIGxhdGUgaW5pdCBhcyBkZXBlbmRlbmNlLg0KPiBAQCAtMjU2
NCw5ICsyNTYzLDYgQEAgaW50IGFtZGdwdV9yYXNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCj4gDQo+ICAJV0FSTihjb24tPmZlYXR1cmVzLCAiRmVhdHVyZSBtYXNrIGlzIG5vdCBj
bGVhcmVkIik7DQo+IA0KPiAtCWlmIChjb24tPmZlYXR1cmVzKQ0KPiAtCQlhbWRncHVfcmFzX2Rp
c2FibGVfYWxsX2ZlYXR1cmVzKGFkZXYsIDEpOw0KPiAtDQo+ICAJY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCZjb24tPnJhc19jb3VudGVfZGVsYXlfd29yayk7DQo+IA0KPiAgCWFtZGdwdV9yYXNf
c2V0X2NvbnRleHQoYWRldiwgTlVMTCk7DQo+IC0tDQo+IDIuMTcuMQ0K
