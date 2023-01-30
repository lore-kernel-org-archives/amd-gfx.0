Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE33DC54EAA
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jan 2023 14:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A5410E0FA;
	Mon, 30 Jan 2023 14:36:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74D110E0FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jan 2023 14:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjAGSqFq1OHclFqAcThieTMQMfFzDLC8eRi492J9fDf49aJZ9N9XNhImJ9Ol+aHr6EBb0i9ajVJ38qRch94m7vG3GoWWIRmekzTBEWxphitHkHwkEpm3yMq0ihpzHXKfd+KSjGsOs9gksKTLhL4oppvUzQgH+d7Csdk+0PW70IysFplCHa6fliHqf6JDKru7Tv0OeyVrxQNUVqwlwlc6OlDr0y7sHLW82IZ8eB3n2TduItkoijCTcs6215n1qq2OsazLU4+C3Yxe1MFnrrDGapZgu/GQsuPLmlFIGQ2VnTelweTfnzpXxouGLA3GG3ngdXmjRgTp3o9qHH3D+52VYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrBYoux2ZvvDYnVUjGaCt6ao+irlJHOndGTJjAhOGGc=;
 b=CWe3FKrGHVFObDc/QBwhC257Q07eRwhB6bb1RDOtj63PIbhvyXvpZ/U65Mfh7rtte0ACJbbj1jpCGwC3gZbZZDmtAEcpOBxtN8liLd1p0NH0dtRsvulzJYuaocJn0xTeT+4hhj+KIJctDtwIUwjn0mYXquCspQWDYwUUhf28Eh+chK1d1hRQrUdp1U2shNzv6p6nCKIAZ3NpmL7e4swRhXbpF9lRKI0ECYWgIz1JUjk0suR5mBX8YIgL0HsxCvVyr4gO8j0hBqutiJW0+6c4O6YmJAp3dj0HTDT4oGu0UJhOb2f3rap5x+vLQPaDIf9h9u6FAGBS7K1W9VmwALnwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrBYoux2ZvvDYnVUjGaCt6ao+irlJHOndGTJjAhOGGc=;
 b=dT6V14l3aDh6FB8RQs1scAKVwqKjCpz2Hksb5Qe96DP2ixP/ISfWCPoUhYJYM5AwTJ+EKi32KYkMbpy3vhslGlkpt81uUI22hKukzSDWthal2d9gIHdM2PbyA0KWQhOjpemi9qoSLkZJB1s8/SivjORZGJhPC5Uo611+jLCM80A=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:36:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 14:36:49 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Allow s0ix without BIOS support
Thread-Topic: [PATCH] drm/amd: Allow s0ix without BIOS support
Thread-Index: AQHZMOuL9X1oXh+7yEKLTRPXAMqCHa63BrIAgAAHQjA=
Date: Mon, 30 Jan 2023 14:36:49 +0000
Message-ID: <MN0PR12MB61010C26A10695128043F7B5E2D39@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230125183339.15664-1-mario.limonciello@amd.com>
 <87edrc15ff.fsf@espindo.la>
In-Reply-To: <87edrc15ff.fsf@espindo.la>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-30T14:37:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=152d1822-46f3-4bad-9a3e-1d53ff4f9f27;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-30T14:37:00Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 11dd0159-7727-4603-a7a2-43b957a4db1a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BY1PR12MB8447:EE_
x-ms-office365-filtering-correlation-id: f19abda4-f4d9-444a-58c8-08db02cf6bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNOyPJDCiicIfo8OdpjF+7WWjHZQYIa636Tl3sAwv3+lhTKXulxl0V+xrq69HbgJ8U/JBIhMBIgIzEZs+c3R15/bXNEzIT45b0nHkE6Bh4JY6m/1/F3DHBuUhDLFGS7sripoKH5HdL1DfHa+SMVYE/7pWbbHNBaYii0UOTBvVnKHBoqNdFfihf4HFTA6t7mz93HtzhOppMLOQIO/gaq8WSf0+zt4idQFQTv8HHssqEtAkhfBSnVUUCoMj4mHrYdqDlQwJJR23xJd7vpkG+UobZmqtuS01rdxcHEVafRUBXRMVxQeOVT0atuh8WjiwwnhC2jTpJsvOo1DlXIxjZmG4hr2igaLbYShNh1pZNEbnQPE3MQ4ScsnG4MfDcSV8mB4bGHdGtFA/IWh9ZqGMhTs5Chsls2MgeA3Fulj2hr7baPRSS24j6C+cU0fDfkBD0p/YI11+m/GFxhJvIL8iRWTVUdYwbAsHtp85C9RB7yLgH1rwq7m5RUW47xBWzW3XkCiCCzX0SI5PrmHhNE39IyC9vtiT1hZ2KPJ5ApWJfjovDkXswNMEFVpLG7bxAjTSSEpmS104IambhupVoxc18s+kwCnyFG5JxL1hn4vnapxhkVz2Qeq4gqQp30k1Nz+YcHNc+ktjMLwhCWQouWVVvYmz6n9gdP0EBFW3gpae04+C+g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199018)(52536014)(5660300002)(8936002)(41300700001)(38100700002)(122000001)(38070700005)(55016003)(33656002)(86362001)(2906002)(110136005)(66574015)(186003)(478600001)(26005)(966005)(66899018)(9686003)(7696005)(71200400001)(6506007)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(83380400001)(53546011)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm4vWWg2SVNrOGxDOU51VGVJL3hUN3N0MTBJam1HR0gra1lmdkZYSmlReWxm?=
 =?utf-8?B?bVhmZE55T2d5TzVtVTdLWmd4QjhTQVl2cWxMWVlsR0dSdWh4eUVBZzZNbjlQ?=
 =?utf-8?B?M1ZNODBKdnptVmlacCtHTnRJVHNZU0RjaG41L0xFakE1ZW5hSVdaald4c0s2?=
 =?utf-8?B?T0ZDQ0lIMUNNQjlpOTh6bWJVOGkrL3gvUGd5NzZoaEhpckFQejc3cVN4T3Bu?=
 =?utf-8?B?R2ozbUM2RStibGcvWUlWTG1FV0ZnQk1YZCtZODRDZHZuSFE0RENCNlZuODRL?=
 =?utf-8?B?cGpDb0RrRGE0QmVvaG5WTGpNcmVYMGFGaHQ2ZlBJUVBRVmZ6WVlLNHNwYzha?=
 =?utf-8?B?WmV3MXY4bUZVSDV4NDVrb3RlUitQNGw1UVNBbWtZaWhQbFdFM3ZZZEQ4OGVj?=
 =?utf-8?B?c1QvWXZvbEFqeUxibTVaUEM5WmozTjVPTnBtSThRZFRxc0N6SUxUR3Zmelgx?=
 =?utf-8?B?N0hHVk5XN2Q3RlVQUlF1eTROaFJibzFva1hQa1lhSDUzNm0xVkk0VWtraHR3?=
 =?utf-8?B?bXNsK1ZpOC81MDROYms5UkFlS1Z0VnI5c05pZEtyeUdSY1NjbnJKdkxHa3dp?=
 =?utf-8?B?VktVNmhjWUN6ZElLeklpMU1nOWtJeWp2RjUrVEUwTVdOSW5HUGxzZjVDVjJQ?=
 =?utf-8?B?QmdmMDYvd0d5ajFUcWswc0lmbzdxNUJPQ2RYZkJrcFZXbDlpSHlSVkUraGY1?=
 =?utf-8?B?Y1VTZ3ZNRFR6anVXRXRQS1R4WFF2QmpoT3BnS3ZSbW92ZVJvak5oa21yYWRS?=
 =?utf-8?B?VHVXUVd4dkdTeE9WamRDU3JHR0lhRnRqYnEwZXhKcDFYRzlPVUtoZVhaSVpk?=
 =?utf-8?B?UkpIQUFYajJ4U3N5ZFRVb3ZOb0ZvT1RQczZkS1RMRGpzWTRxK1NlRUJIanV5?=
 =?utf-8?B?Q0N5NGw5cFVOcDBoaGVqeVZ2cnRSZmlyZzFkTTZaLzRFa3lNUFhoaFZsMnBY?=
 =?utf-8?B?UDFtbFJUUVBCMEFBNVNrbDBJeitTQTRaVjFTUTlOa05sM3pCVDA5M2pxTmxK?=
 =?utf-8?B?eE5nSGJ4aGw2VC84M1ZmWXlDRVgwZFpGOGM3VUowSmVXWlh1aDJaVnFZYUQ3?=
 =?utf-8?B?VC9WSHEzRlRzS0dXUkFrRjdyTTlVckJRR2ZWckdHR0prVzRlN2trZ1RmMnU4?=
 =?utf-8?B?VEVwTkhYdnlWem5MQjBtdkM4ak9GUU1MODEwNUoya2VFSEY4SVRwYjFCaE51?=
 =?utf-8?B?UXhDeXh6Q09sS0ljMGJ4MzE1OUdPWnUrUmhHeEVkV05GSkRTb1hoMFpKNGRR?=
 =?utf-8?B?QWFOUlJXSmVwY2pTb05CNzlzamgvRkhrUElsZVUxcWpQTDMyczZWbjNMdHln?=
 =?utf-8?B?RWVXemVpY1EzK1pqRW9XdnNCL1dzSWZNRlNqRmU1aVViaXdCVXl6Z2Q4bEEv?=
 =?utf-8?B?cHhJZWlFS1pyaEtrN2p4RjNhWUpqWnRIcXRScjIrUGUxcHJGTlpEdWhaRGkw?=
 =?utf-8?B?ZFl1b0ZYakY5V2NVdnlNWkdhUm41dzF3Z3FoK3AvNXNIS3lIV0xOQ0lFalRV?=
 =?utf-8?B?Zko5elA0Y2g1MGlOazZEK3QzeVMvK2FTaWVFREdNQWYyL2ZLZXBGeGhEQVFY?=
 =?utf-8?B?UDQ5aTdLYkQwUDdITklxSGdHKzg3cmVYNWN0b3I4dStXWnhJaGhpTlRhemRu?=
 =?utf-8?B?dHZMSVpBWlZDRWNUR0pUbS82RUJGK2N0M3oxTk5sTjlxeDUvTjQrbUhmbzFR?=
 =?utf-8?B?Q3RuYUVCajJma0N6cThSV2hyVU1RNThhNzVLTUlrMENGa3JIT1VjNEtQaXVz?=
 =?utf-8?B?dE9yWGVadWhrR1lxT2IzSHZmekxmMUFsajZsYUwwSHVKNnRMK2ZZaHhLY1dL?=
 =?utf-8?B?RDRZZ3MvTU5uODVXNHBZZHZGaDJLK2FYMGhZTEduWkZZSjFEUXRWbVFkbTkw?=
 =?utf-8?B?Y0xJZVR6MDM3cHE4T0JoQnBWV1g1R003MExXTURtc3A4RmFqOFlPc2E3K3Q0?=
 =?utf-8?B?VFhDck9hN3NnTmZrR3E5OHAwQmpCY0Z4aWh2NkJyZG5DcGM4ZWJVa2JJS24z?=
 =?utf-8?B?Q1hZRERpdFFzdjVQV1h6TVpLZ2Znb2tQZmhVbjI4VkNzTjBRdzJaY0s1elBZ?=
 =?utf-8?B?RlNLRE5YTFRmTW0vTG84bzM2SjZ2aTNpbDZiaDBKY2pzWVBuOHdQMXIvN0ZJ?=
 =?utf-8?Q?sQes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19abda4-f4d9-444a-58c8-08db02cf6bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 14:36:49.5290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFKWD9kd9G0f78chF4s/aAlhxhnAYo4BAXYotGshB8qTQIgVvtrKWtjwPOXXQYehiXv7bFjRFgWioEF/8ghruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xhIDxyYWZhZWxAZXNwaW5kby5sYT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDMwLCAyMDIzIDA4OjA4DQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1h
cmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZDogQWxsb3cgczBpeCB3aXRob3V0IEJJT1Mg
c3VwcG9ydA0KPiANCj4gQlRXLCB0byB3aGljaCBnaXQgcmVwbyB0aGlzIGdldHMgYWRkZWQgZmly
c3Q/IEkgdG9vayBhIGxvb2sgYXQNCj4gZ2l0Oi8vYW5vbmdpdC5mcmVlZGVza3RvcC5vcmcvZHJt
LXRpcCwgYnV0IGl0IGlzIG5vdCB0aGVyZS4NCj4gDQo+IFRoYW5rcywNCj4gUmFmYWVsDQoNCkhp
LA0KDQpJdCB3aWxsIGZpcnN0IHNob3cgdXAgaW4gYW1kLXN0YWdpbmctZHJtLW5leHQgaGVyZToN
Cg0KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2FnZDVmL2xpbnV4Ly0vY29tbWl0cy9h
bWQtc3RhZ2luZy1kcm0tbmV4dA0KDQpJdCBoYXNuJ3QgYmVlbiByZWZyZXNoZWQgZm9yIHRoaW5n
cyBhY2NlcHRlZCB0aGlzIGxhc3Qgd2VlayB5ZXQsIGJ1dCBpdCBzaG91bGQNCnNob3cgdXAgdGhp
cyB3ZWVrIHNvbWUgdGltZS4NCg0KVGhhbmtzLA0KDQo+IA0KPiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBXZSBndWFyZCB0aGUg
c3VzcGVuZCBlbnRyeSBjb2RlIGZyb20gcnVubmluZyB1bmxlc3Mgd2UgaGF2ZSBwcm9wZXINCj4g
PiBCSU9TIHN1cHBvcnQgZm9yIGVpdGhlciBTMyBtb2RlIG9yIHMwaXggbW9kZS4NCj4gPg0KPiA+
IElmIGEgdXNlcidzIHN5c3RlbSBkb2Vzbid0IHN1cHBvcnQgZWl0aGVyIG9mIHRoZXNlIG1vZGVz
IHRoZSBrZXJuZWwNCj4gPiBzdGlsbCBkb2VzIG9mZmVyIHMyaWRsZSBpbiBgL3N5cy9wb3dlci9t
ZW1fc2xlZXBgIHNvIHRoZXJlIGlzIGFuDQo+ID4gZXhwZWN0YXRpb24gZnJvbSB1c2VycyB0aGF0
IGl0IHdvcmtzIGV2ZW4gaWYgdGhlIHBvd2VyIGNvbnN1bXB0aW9uDQo+ID4gcmVtYWlucyB2ZXJ5
IGhpZ2guDQo+ID4NCj4gPiBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGEgcmVwb3J0cyB0aGF0
IGEgc3lzdGVtIG9mIGhpcyBoYXMgYQ0KPiA+IG5vbi1mdW5jdGlvbmFsIGdyYXBoaWNzIHN0YWNr
IGFmdGVyIHJlc3VtaW5nLiAgVGhhdCBzeXN0ZW0gZG9lc24ndA0KPiA+IHN1cHBvcnQgUzMgYW5k
IHRoZSBGQURUIGRvZXNuJ3QgaW5kaWNhdGUgc3VwcG9ydCBmb3IgbG93IHBvd2VyIGlkbGUuDQo+
ID4NCj4gPiBUaHJvdWdoIHNvbWUgZXhwZXJpbWVudGF0aW9uIGl0IHdhcyBjb25jbHVkZWQgdGhh
dCBldmVuIHdpdGhvdXQgdGhlDQo+ID4gaGFyZHdhcmUgczBpMyBzdXBwb3J0IHByb3ZpZGVkIGJ5
IHRoZSBhbWRfcG1jIGRyaXZlciB0aGUgcG93ZXINCj4gPiBjb25zdW1wdGlvbiBvdmVyIHN1c3Bl
bmQgaXMgZGVjcmVhc2VkIGJ5IHJ1bm5pbmcgYW1kZ3B1J3MgczBpeA0KPiA+IHN1c3BlbmQgcm91
dGluZS4NCj4gPg0KPiA+IFRoZSBudW1iZXJzIG92ZXIgc3VzcGVuZCBzaG93ZWQ6DQo+ID4gKiBO
byBwYXRjaDogOS4yVw0KPiA+ICogU2tpcCBhbWRncHUgc3VzcGVuZCBlbnRpcmVseTogMTAuNVcN
Cj4gPiAqIFJ1biBhbWRncHUgczBpeCByb3V0aW5lOiA3LjdXDQo+ID4NCj4gPiBBcyB0aGlzIGRv
ZXMgaW1wcm92ZSB0aGUgcG93ZXIsIHJlbW92ZSBzb21lIG9mIHRoZSBndWFyZCByYWlscyBpbg0K
PiA+IGBhbWRncHVfYWNwaS5jYCBmb3Igb25seSBydW5uaW5nIHMwaXggc3VzcGVuZCByb3V0aW5l
cyBpbiB0aGUgcmlnaHQNCj4gPiBjaXJjdW1zdGFuY2VzLg0KPiA+DQo+ID4gSG93ZXZlciBpZiB0
aGlzIHR1cm5zIG91dCB0byBjYXVzZSByZWdyZXNzaW9ucyBmb3IgYW55b25lLCB3ZSBzaG91bGQN
Cj4gPiByZXZlcnQgdGhpcyBjaGFuZ2UgYW5kIGluc3RlYWQgb3B0IGZvciBza2lwcGluZyBzdXNw
ZW5kL3Jlc3VtZSByb3V0aW5lcw0KPiA+IGVudGlyZWx5IG9yIHRyeSB0byBmaXggdGhlIHVuZGVy
bHlpbmcgYmVoYXZpb3IgdGhhdCBtYWtlcyBncmFwaGljcyBmYWlsDQo+ID4gYWZ0ZXIgcmVzdW1l
IHdpdGhvdXQgdW5kZXJseWluZyBwbGF0Zm9ybSBzdXBwb3J0Lg0KPiA+DQo+ID4gUmVwb3J0ZWQt
Ynk6IFJhZmFlbCDDgXZpbGEgZGUgRXNww61uZG9sYSA8cmFmYWVsQGVzcGluZG8ubGE+DQo+ID4g
TGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjM2
NA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxs
b0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYWNwaS5jIHwgOCArKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYWNwaS5jDQo+ID4gaW5kZXggNTdiNWUxMTQ0NmM2NS4uZmE3Mzc1Yjk3ZmQ0NyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+
IEBAIC0xMDc5LDIwICsxMDc5LDE2IEBAIGJvb2wgYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUo
c3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gIAkgKiBTMGl4IGV2ZW4gdGhvdWdo
IHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGluZyB0byBpZGxlLCBzbyByZXR1cm4gZmFsc2UNCj4gPiAg
CSAqIGluIHRoYXQgY2FzZS4NCj4gPiAgCSAqLw0KPiA+IC0JaWYgKCEoYWNwaV9nYmxfRkFEVC5m
bGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApKSB7DQo+ID4gKwlpZiAoIShhY3BpX2dibF9G
QURULmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkpDQo+ID4gIAkJZGV2X3dhcm5fb25j
ZShhZGV2LT5kZXYsDQo+ID4gIAkJCSAgICAgICJQb3dlciBjb25zdW1wdGlvbiB3aWxsIGJlIGhp
Z2hlciBhcyBCSU9TIGhhcw0KPiBub3QgYmVlbiBjb25maWd1cmVkIGZvciBzdXNwZW5kLXRvLWlk
bGUuXG4iDQo+ID4gIAkJCSAgICAgICJUbyB1c2Ugc3VzcGVuZC10by1pZGxlIGNoYW5nZSB0aGUg
c2xlZXAgbW9kZSBpbg0KPiBCSU9TIHNldHVwLlxuIik7DQo+ID4gLQkJcmV0dXJuIGZhbHNlOw0K
PiA+IC0JfQ0KPiA+DQo+ID4gICNpZiAhSVNfRU5BQkxFRChDT05GSUdfQU1EX1BNQykNCj4gPiAg
CWRldl93YXJuX29uY2UoYWRldi0+ZGV2LA0KPiA+ICAJCSAgICAgICJQb3dlciBjb25zdW1wdGlv
biB3aWxsIGJlIGhpZ2hlciBhcyB0aGUga2VybmVsIGhhcyBub3QNCj4gYmVlbiBjb21waWxlZCB3
aXRoIENPTkZJR19BTURfUE1DLlxuIik7DQo+ID4gLQlyZXR1cm4gZmFsc2U7DQo+ID4gLSNlbHNl
DQo+ID4gLQlyZXR1cm4gdHJ1ZTsNCj4gPiAgI2VuZGlmIC8qIENPTkZJR19BTURfUE1DICovDQo+
ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfU1VT
UEVORCAqLw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo=
