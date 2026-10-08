Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508ABCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 02:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA6610E00B;
	Thu,  8 Oct 2026 02:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DlJNs2eR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C95A10E00B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 02:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4eOXB56A8qiQgmPoXHJUYruO0qcvTtxkOfoOrQ+WpceUbdH0VFyc54YrRLJY9HDlsfN+yeJT09ujzhwNYyRQh3L1K5pT2PXPy+Mqi+mp2GaciNKo59vzmvmeHCQnX7gc2lOeYDukjC3mXQsZ14QjXH9UwB3SThsEchAQ97osmdmwRErMzd22LuHvXvdMgJwRDvIaiQ1Je0C9npjGJg9iBmbilHiMLfEEQwQWLecKI5PtHOCCFu+dvCBDnzRTXtoWrfYnE/84bEH7Ppap7kZTF8/TNLZHsm3wI5a3kdXDrwnAJNptIhIKOyNIojVIj07eXY7dmP0VqTkwycxSHFAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7ePA9Z9Rl9Y6J6KI/eEdIPos65qf6GaVkLmRGIg/fU=;
 b=rsZQv7WCHlVfv0J5SbPYTYtjfxFScjPATYKs1Br8fTL1rnhkNQrF9lo+OPZVQ49LFM9anQa41Ml7YWvkT+3rS9USoBzNfBHKTyDToI2IedJiGUY0Zvvfk0nnipFwIPe6VQQikyYIYKMJjvwGLoKm6c4GNcYsX3N2Wn4HzkCIyVzQ0Bu8e+7RlcOkCjzV6yA9LHzMwpzjNkCPZcIr0G04CVl+dKDUBDWil2JjRTuxtttXLiJU73fhbSIis85GpKm36P9tZZPTjWSGcfjWOA2yn3CDL9RqAX+2ok7NO4zPpXIY+GJMMO1xcJAgwTAr+748C1ymPjebn8h0I/WC7U4gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7ePA9Z9Rl9Y6J6KI/eEdIPos65qf6GaVkLmRGIg/fU=;
 b=DlJNs2eRs7w3ZmCe+nVDmoEQYPO7hwZHcHF6qVGy1D0lXX7TpXsoAIbQOpgwuUZYhzH7uRBsQ/GSsvhYzbO+2Jab1Z2y2Ks3oCA/pykNFoD96Eqf8HLBhCMhqV+mQ7rQ5J5W9t7EeoHZYKcvpV7X1Wjw0s1URaAaxstDX7PzTh4=
Received: from LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 02:00:38 +0000
Received: from LV3PR12MB9235.namprd12.prod.outlook.com
 ([fe80::fa69:b1ab:8128:4ec5]) by LV3PR12MB9235.namprd12.prod.outlook.com
 ([fe80::fa69:b1ab:8128:4ec5%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 02:00:37 +0000
From: "Hong, Chi" <Chi.Hong@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhang, Tiantian (Celine)"
 <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Topic: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Index: AQHdTxBHfNaTUsoRCkidkpaFmONe/rblI/3wgAHazQCAC/QREA==
Date: Thu, 8 Oct 2026 02:00:37 +0000
Message-ID: <LV3PR12MB9235B6BCB43D50E20413D21B9F932@LV3PR12MB9235.namprd12.prod.outlook.com>
References: <20260928061148.117428-1-Chi.Hong@amd.com>
 <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
 <1ff26404-19cc-42d1-9792-e6e557b2fcc8@amd.com>
In-Reply-To: <1ff26404-19cc-42d1-9792-e6e557b2fcc8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Tao.Zhou1@amd.com,YiPeng.Chai@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T01:58:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9235:EE_|DM6PR12MB4435:EE_
x-ms-office365-filtering-correlation-id: 1568986d-3059-4f94-9db6-08df24dff2b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|38070700021|5023799004|4143699003|11063799006|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: KWA6MRa19qanRc6OP+Hbc+8AmyOvb2QWcWCAijkyQYzyJ9BKc8a6i59EwWUtnfZIxyJwISrmh6vDLsRFfluQS8NhVsr3Vx/OsAjgqZqEKD+HA26Y9nWRoSfvK2HfZWIepJiWOcEdIcJEwyMvPCSQAP8jHC7fhfHM4fM89PuoayGSKsE7nHfON2e03wH6HjaLWoEUkCubZOlFmM59HJ1goV1JQHoYlrftenKxX6MPGIcHlqZdDzrcp2aA1aAXOJeb7cBmNMmwL0oUUsTvYa53n+3MBhF7BGbIDuEnaXTwDPTtHx4l2B0F7quK7zLY+jo+gwRzIPU21VBimavcW0SsgOVgMWgiwBwmm2B2QlBOgXAliPEnQ+mlnQ4yo+SRJPEJ3t0ShbSx5t2Z1JBemAdkkFztuq1eJ6hqN5s8nGhV6lP0309R7MOFSTi077b4KSIlMsn0IN2cTBx0bPC5VVybdMJYS6ea5YcfewqYg6pNqX0RSwRmFItLQXN16N9hT3lyuR+86os8+N3XeVh1hMA1/QUD/heBRt9rQWQbPjmRyOYRgnLAfUH5ZAP3CIK1H0xa2iE3H9O09sLlTemnwDsVq6invhtfY3h6YVTzQ3+6WWZYviaSMSdR7gSWfYTaKhVvWimrtCZagDp/06nXRhUen4rGLC5d264SZBQKZIeTS8qVocsJ+qu7wtfwUXlZ57vDL9G5+MIlvimz2HAojmk/F0LaZzkME+dqD4sML5uWndY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9235.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(38070700021)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFhZkV0NFRPUDVvU0tPY1NGNitSaE5DRmd0ZldKbWsyOFgydm1jNTlRZ01V?=
 =?utf-8?B?QVJvZ1JONlJ2eEJKaG55ZTNkWUUwZWdnTGQ4c09QZStXSDFrUUgxRmhuVFZw?=
 =?utf-8?B?aDRKb3ZZRk8rencwanV5dG9SYjJTSmNWdFlnbGRXZTZZUmY5MVVGNGRINXlH?=
 =?utf-8?B?QVdMRUR3MC9tTU5rMmlMZWM4eTZPdEZBY3hqT3dSYmtWdmw2OVQxUUR3WE9L?=
 =?utf-8?B?ZjAycWtTZHVQUzZuUEYyRWUwcDFXa2hOSkNkcEZ5QjRQaVVvQVJMck1nMU9L?=
 =?utf-8?B?dzZYRDBOTmtjL25sYUhORnVPNUsxelNHenJ0b2IvaWk2Y0EyUlpkRTliU1ZX?=
 =?utf-8?B?bzF0bzRaNWdjb1VqNEhyZnUyQ2hOQUdXK2ZnNmMvS21jM1F5S2VMTmtTSmtq?=
 =?utf-8?B?TjRFakhQOGo1cStJZVJGSjE4QllhNnNlaHA3QjNWOWUxaEptOTNJQUQ2RjBW?=
 =?utf-8?B?N2RYaDFManZSSWlCL3ZhVFNMeS9OelY3TE9kSmp6UXdZMm01MlJxN0FVSUl3?=
 =?utf-8?B?SFpqTGVUQkl2NjVaRk0yeExzR2RYUkxZUFo1L0Q4dVZwSlZjNDBaZ3l5UmhL?=
 =?utf-8?B?MDRSdmMvTWVhRGhmRk10Q1RLZ2M2ODM2V0g5WUhaNXdwYVF5bmlIUkFxTk4v?=
 =?utf-8?B?YXoyZTVMQ1IyVk1NMkxPRXlKaHd0bnBCRUwyZHd0cThMeGRkcXdUUlQ3R21I?=
 =?utf-8?B?KzZLMG1QNlNQcXFhZHRJcmtIenNpWlV1dDRrQXM3SWNZTmtxOUY3WTQrdnNk?=
 =?utf-8?B?bHR5L3J4TEFMSGFKU0lpYThUZFFhU3NLd2NPZmQzbjVqMkJGTWI1TTJzMVVN?=
 =?utf-8?B?VlFEc3JBa25Jc0N2U08wZEF0Z3lHV1cyOVZuVkxUQWJxR2ZJQUdCaVV3R3pU?=
 =?utf-8?B?VTVDWUlaUTZrM3NOMUFBZFprY21GQlFXdmNzNGtqbWhZVTBKejk3L0VZei9w?=
 =?utf-8?B?VldqV2hVa1FpcFN5Qk5leUptYTVTREl2NUxHQ2RUZVlTQmhmWjV2MVRLV2h6?=
 =?utf-8?B?NTNuVHhCUS9XdWNiWnJkdnY5ckExbUFwSyttSVFJajZIdXdnTWRmUjlTenZO?=
 =?utf-8?B?QVdtQ3RxODlaQnErbDd4aUs0OWc0amJGek1iaWhacVhsVTJ3cU9TZnozUmds?=
 =?utf-8?B?VmpRd3M1U1ZsZHpMM05xYkZLOVNVei93LzZHWmNJejU4TmltK3BjODl3QWR1?=
 =?utf-8?B?Yy9jdEVELzQvSERDU3E1M2RSQ0kxczdyRzRiTTQ4Q3djeG5vdEpFaDVKTVVV?=
 =?utf-8?B?TTRydnhnZDVlbXBZOEIwb1NLbkJVYmxGZmIyNzZuY3VmNHVvZFdnKzJaYzRU?=
 =?utf-8?B?YmxkYmZ5b1M5cHlybktETjE3MnNhc09peUtQd0E4Q2hNd3B5RjhmOHZrQnFa?=
 =?utf-8?B?V21KSU9SMkdIemkwMklRMURiNFoxdlJOb1lERkRzcTZDeVVHZ2ZTQ25SVWFD?=
 =?utf-8?B?VUF6RXdSN205ci81bjRWTEFLTFhNcDlLZ0pESWJ0RzQwOEtub2xVd3g1R2NL?=
 =?utf-8?B?STVOQXhsMGdtb0dpUWs5SVpDMzVLeVZyVjlZQW1ROUFMN2UxUXdsTmdabllQ?=
 =?utf-8?B?K1pic3dIMHQ1dWxiUStOOE5aY0d0a3dLaTB2V2E4dU1mV0RuUnZoMVB6dDJK?=
 =?utf-8?B?T25kdGN2YVd0N0RBL21xYUduNGYzQXpMb1M2QldEb0ltR2pTblRCWFBpSDAy?=
 =?utf-8?B?Tms5Y0JFL1M2SkJtWk1wbGtkSzR2QUpVeEsvSWQ3aHl0MkF2VlNaMTBkcXBS?=
 =?utf-8?B?cWl5VmFhOUNVVW5XeFVtbTRSZU1xaE5TRnFIZjZwOXRoNldkUXdqVTJOaUhh?=
 =?utf-8?B?T0J4K2haQUsxend1MUJ2OHMwTFpCbU5RcFB5ZlcwekduK1NPbVlzM0t1ZUdZ?=
 =?utf-8?B?VzhsNUU3VmZmczVLYXJWY093MmhSNlVvekR6VUI5S3RkSm1wT1ZweUgrMGc2?=
 =?utf-8?B?Z1hrajZwdlZ6dE9CRU1BUzdNY1NSOVBCRitjbXdDN3U3bGtJS1EvQXNMOVdo?=
 =?utf-8?B?N3FaNllHRFZDRTZKS0hKRUhESC9TMWY5VkYwL0RHaVVnOHRIb1dOMngrT3V1?=
 =?utf-8?B?V3NnTDVVUThXb2VScklja1NPcGszT2t5SzdwYXc2RWVMdGRXN21qOHFjcFFK?=
 =?utf-8?B?WFdEYmdVNTJWelVEa1lDeXZRVFJMRk0wRmlhVXF1ZXdwb0ZRb0VIcnBaZjdm?=
 =?utf-8?B?c24raldyZFdCTVNGeWNBcWhlY3JFWmg2UXNiK3NNMFZhMktaMUtlTXdIeTQ2?=
 =?utf-8?B?RXZWTFlldkdaL0JvbUhPWkdvY2s2THludU5VTVVUeTdpdm91RGpPTjJ2bVEv?=
 =?utf-8?Q?2swn5mUIexrBl58z9w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1568986d-3059-4f94-9db6-08df24dff2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 02:00:37.7664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1/8pev9bkGZBFMfLEtZDlObyaDUdavG06JWfVCW6neA/jLMowSmXXBJ5xgW7hTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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

QU1EIEdlbmVyYWwNCg0KSGkNCg0KQENoYWksIFRob21hc0BaaG91MSwgVGFvLiBQbGVhc2UgdGFr
ZSBhIGxvb2sgYXQgdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KQ2hpDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjYgNzoyNiBQTQ0KVG86IEhvbmcsIENoaSA8
Q2hpLkhvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpoYW5nLCBUaWFudGlhbiAoQ2Vs
aW5lKSA8VGlhbnRpYW4uWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQu
Y29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZC9yYXM6IHNraXAgUkFTIFRBIGZpcm13YXJlIHJlbG9hZCBvbiByZXN1bWUg
Zm9yIFNSLUlPViBWRnMNCg0KY2M6IFRhby9UaG9tYXMgdG8gdGFrZSBhIGxvb2suDQoNClRoYW5r
cywNCkxpam8NCg0KT24gMjktU2VwLTI2IDEyOjU1IFBNLCBIb25nLCBDaGkgd3JvdGU6DQo+IEFN
RCBHZW5lcmFsDQo+DQo+IFBpbmcNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogQ2hpIEhvbmcgPENoaS5Ib25nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVt
YmVyIDI4LCAyMDI2IDI6MTIgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBIb25nLCBDaGkgPENoaS5Ib25nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZC9yYXM6IHNraXAgUkFTIFRBIGZpcm13YXJlIHJlbG9hZCBvbiByZXN1bWUgZm9yIFNS
LUlPViBWRnMNCj4NCj4gU1ItSU9WIFZGcyB1c2UgYW1kZ3B1X3ZpcnRfcmFzX2h3X2luaXQoKSB3
aGljaCBza2lwcyByYXNfY29yZV9od19pbml0KCksIGxlYXZpbmcgZndfZ3B1X21lbSB1bmFsbG9j
YXRlZC4gcmFzX3BzcF9yZWxvYWRfZmlybXdhcmVzKCkgdGhlbiBoaXRzIHRoZSBOVUxMIGJ1ZmZl
ciBhbmQgcmV0dXJucyAtRU5PTUVNICgtMTIpIGZvciBldmVyeSBWRiBvbiByZXN1bWUsIGFib3J0
aW5nDQo+IGlwX3Jlc3VtZV9waGFzZTIgYmVmb3JlIGFtZGdwdV9mZW5jZV9kcml2ZXJfaHdfaW5p
dCgpIHJ1bnMuIFRoZSBuZXh0IGhpYmVybmF0ZSBkb3VibGUtcHV0cyBJUlEgcmVmY291bnRzIGNh
dXNpbmcgYSBXQVJOIHN0b3JtLg0KPg0KPiBTa2lwIHRoZSByZWxvYWQgZm9yIFZGcyAtIHRoZXJl
IGlzIG5vdGhpbmcgbG9jYWwgdG8gcmVsb2FkLiBUaGUgcG9zdC1yZXNldCBwYXRoIChhbWRncHVf
cmFzX21ncl9yZXN1bWVfYWZ0ZXJfcmVzZXQpIGlzIHVuYWZmZWN0ZWQuDQo+DQo+IEZpeGVzOiA1
ZTViZTU2YTViNzYgKCJkcm0vYW1kZ3B1L3JhczogcmVsb2FkIFJBUyBUQSBmcm9tIHJhcyBtZ3Ig
cmVzdW1lIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hpIEhvbmcgPENoaS5Ib25nQGFtZC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3Jhc19tZ3Iu
YyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21nci5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21nci5jDQo+IGlu
ZGV4IGEwMjE2NzM5N2NlMi4uNWJhYzc5MjU1NGY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Jhcy9yYXNfbWdyL2FtZGdwdV9yYXNfbWdyLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21nci5jDQo+IEBAIC01MjksNiArNTI5
LDkgQEAgc3RhdGljIGludCBhbWRncHVfcmFzX21ncl9yZXN1bWUoc3RydWN0IGFtZGdwdV9pcF9i
bG9jayAqaXBfYmxvY2spDQo+ICAgICAgICAgIGlmICghcmFzX21nci0+cmFzX2lzX3JlYWR5KQ0K
PiAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPiArICAgICAgIGlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAg
ICByZXQgPSByYXNfcHNwX3JlbG9hZF9maXJtd2FyZXMocmFzX21nci0+cmFzX2NvcmUsIDApOw0K
PiAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgIFJBU19ERVZfRVJSKGFkZXYs
DQo+IC0tDQo+IDIuNDMuMA0KDQo=
