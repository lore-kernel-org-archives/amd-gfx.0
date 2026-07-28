Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAB4C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 19:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB17910E5C9;
	Tue, 28 Jul 2026 19:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CXaFSg5R";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8714410E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 19:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2aWWQ5IzQqJN7vaJJpPsoL1zq9g23ZZXYLDUOMijZxIcQMAUWWJWww/y65DjKMV5xy5ghwBAjXipSQ82FOiW0GOAzkzVjqvBqFRKqm4KpBkfnetR1a2QzYH7hrsP1fCbqE1kUqoPXAft4Mnm5ZHRp9kGZ37JTd6LJCahPQy5/3H0FyvDdlR/+dBSblBEpoBSpzcBGL88LEYl2NaIjZbHub7yKt4BNnyHqQiSEtbijk0zjCwPwg+LA9MZzV+WAdj9fGJ61DF+HQbpaXoaKPv0MecIhIP1Fq3/dTY7NyrV2agzaJcFSVG4jD1GSVUT9LC0cD+FkEeQmJpOxTa4X1LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmAsuuczHrH53fGIgKFPeF8b9dzbkxRXYtaIibkMqJw=;
 b=TIeY9Lipw7GyXsAn6WaJdoFfZeJDLPkftPDBt+9egoOLN5/upFv+DZaJNB/higxJyU1bSQi7T2HvjWntF1FRs4OBZcNuMwkz8SE6wHzBntg32OlxL6bcKqYhrycjPQNigmymePhlTJyKzejz1MEFJpetM8vCQy6Anl5sup12m+jbJ65xuzpe1m5qszPJ1K/QT+Tj3r+cOKVxvXgHK6BieOp4oD6oBqfDd2YP6IW+MtzxPKVq1dhRdcLQa3nFgiIrzVIduE5errwdVXb5fTCAOFHkhk6veY0MpEvz+rkz1TF2PJLmzTPTxlTQRDSqnLo1DtMa6VGIFBF6SHcXyTPAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmAsuuczHrH53fGIgKFPeF8b9dzbkxRXYtaIibkMqJw=;
 b=CXaFSg5RJH2II38HQMm+CBgAmtexu0KiyxRaF1BAVqqWwpKER8Yu03+z7RI30gCeHZJ9mHV+SdqyOpLD7UN9tEQVbxFwKOxIaIUTGCxinfPndOFojH97lBlobRiP5X6p6OQ4LQ5yES/Bxn6aQ7/8TkripArDOfAzxUUeSoLw5qY=
Received: from DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:19:53 +0000
Received: from DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce]) by DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:19:53 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: zero SDMA mid-command save state before
 restoring user queues
Thread-Topic: [PATCH] drm/amdkfd: zero SDMA mid-command save state before
 restoring user queues
Thread-Index: AQHdHr00K3OI9BX3h0WdYaBl2sF6XraDRlmAgAAHMtA=
Date: Tue, 28 Jul 2026 19:19:53 +0000
Message-ID: <DS0PR12MB7536307847468B42A0067B56F5CB2@DS0PR12MB7536.namprd12.prod.outlook.com>
References: <20260728181608.10541-1-andrew.martin@amd.com>
 <CADnq5_NCuSjcREYmLCm5Lnk4NQ4W1oDZy_9Cbh9JUUn_oOY8Qg@mail.gmail.com>
In-Reply-To: <CADnq5_NCuSjcREYmLCm5Lnk4NQ4W1oDZy_9Cbh9JUUn_oOY8Qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: alexdeucher@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T19:15:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7536:EE_|SA0PR12MB7091:EE_
x-ms-office365-filtering-correlation-id: ceba728a-15d5-4e79-1050-08deecdd33db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|56012099006|11063799006|4143699003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: qfw1j9ExIJOCFOcQqhNI1PlNHePIsH1WmNmgF+ALc+Ta9/2GwOyxSrxjWTJ6dZ12l7V65OVM9b7Be2+CqAlJ6Wq9IylihMMXRr6/vzdd8pSeOh3AW9kv9pbNQpQnK78ZgMeTJcrnD+mH/DdwAx6n7UOhcQl9DDq26szup0GN5qb0nsCuicWTvPR13MuzTMRqZVzfRevAly3SHq6Xy1CpLKjAXQVl9wEp4t2+Tlu5ZZ4een5PtE5Krp2lAJc+C1SEdhVOEKvIyx3wLcj7SA1W9SWtBIpizS1ztl36Kpl8iI4D4NEIiJiy1mkkqvcqz/288HfiVTu6w3Ya8jVWZ+r1Cz2As7M3+8VssQokRg/Y+u8DSOk+d0uA5p8XPrQWSWzL56BERq0TfsTxNGGVsqi+SWqLEFxP23TMVB/A45FRR1k4D7Xwpml8lJYlLTtOaH90IEyC9JLXHlcaGX2LdOGsEruSAb38QBrPVCgZmAY5efSmro3rSBNF6dbu7UNuttqjENxV4Sg5zgczPvtWXzrezoZ4BjFb/GdV7qJWFAHAqeGcEGZWQPfq5QR9v4J5HAxdKg5miLG2fYa1+qg1C+KtP6Rh7g3zo3Iti9qXiAsKVPLghglmtzaPHxQuwKso00/HF2V0HGVr8bPoWYBReyhcqQhBF+JO6hpKu92gb+BvMYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STR2TVlWb3ZwRXNiQ3ppTlc3cURVd0hEdEJtdUtVdFQ2K2poeVZJRlE4OFVB?=
 =?utf-8?B?bkk3QjlGR1JUc0UwWEp4aCs2SDB5SEUrTDVBWkdMNVl4QSsxVEdBK2RsS08x?=
 =?utf-8?B?Vm41d250NXh3SXdKaGQ0S2lyME5PUnZCNTBBcFhQb05CQWFMWitsaW1iWXQ0?=
 =?utf-8?B?bGxud1NJZEdaUDJHUkpJOUlpR0x1MzQwVDV6SExreWtKY3NOaTY4cWIvdGxh?=
 =?utf-8?B?dHpPVVI2MHQ2TjM1cjdrREllbFcxQmJod1NOZVc1YURKR1RCeXdad0pkdlZw?=
 =?utf-8?B?WDQyUFc5ZVdKcDcyRkU0OFhjb1huVlZqd1o3cWdMTDUwQzZQeFp1ekc3dng2?=
 =?utf-8?B?UUlQVk5xSFlPV252TXdqSDVQL3pWMTYzWm5pQVM2Z3M3V2lCMGdmSEpGWEpq?=
 =?utf-8?B?SXp3YXE1aUs5eU1IUkkwVWUzTktTZlBZOXhOMXdnNUpxNXhhN0NNOVRDZHBF?=
 =?utf-8?B?M3dBNEh1a1NjSEh3WUc2QVlaZnkzaWY4LzY2RUNpTVJqSzZrdGoxaU1uZ1NJ?=
 =?utf-8?B?QmRpOWRNWC96ZzRlNWFwUVJGaGYreEhCTk1KZG1BSVZSLy9CMzRwa3RqSEJW?=
 =?utf-8?B?WjRxd1E3NERxUzBScTdoellOa0lTajlRd1ZsdlphQnhweWZIRTM0YjBVNWFa?=
 =?utf-8?B?R1hyZmpTN21PVWdWVml4enZoeTE3UGNYdWRxNW5KcEZYOUpjVllUR2RHOERG?=
 =?utf-8?B?bjE1RlZLUnRaQ2NkSzh1VzNubTZIT3RIUEVOblhWSWIrbXNlVGxYUFdpK21h?=
 =?utf-8?B?VWZjcmx3akowbGZlSnpnem9ZWHdYVVJaT3ZNeVlCYStKSDFnNHl3YzZJc0JJ?=
 =?utf-8?B?aFZnV3NQQXIvdjM1NXZ6dGd5R0ZoU0d4V29nNSs5aGk4WDM2SEZRT0hIUjVF?=
 =?utf-8?B?a0VvSThvUHpWdlR1a2x3OEo4Z3JCQ1JSNEtsUnBIMEo1em9HWDVhK1Zkcmto?=
 =?utf-8?B?S2orYktwTmN6UldJVHVwd2xvejFyZUZ2SE12b2pPTFJWYzlnUlByeHdCb2hR?=
 =?utf-8?B?RGZoRit6azlIWVNRWjBYSnVkNVV4U3JzV2hOVDljQlNqNkF3SzVKWU4zdVAz?=
 =?utf-8?B?bDFLbE9TNXFIbCtaZm9rajlReHNTeGVsNjc3bk52VmJjTzlzMG12N3pSbSs5?=
 =?utf-8?B?VTF5RzNMTWt0cDhtVy9lNFk5QkM2dUJwNVFHaVB5YTFtMjQvZVlhQkNSbmNw?=
 =?utf-8?B?U1JEaFdTY1ZENHR2WE05d0JvZFJYVkt1NUxvRDZVMWVFeFQ3TDVWcDRkdDRX?=
 =?utf-8?B?OExDOCtKQ2doV0tHNlAyaHFzMWM1cmtGTGYwUXBXYWZ0V0RKZFFtNU1MbWdJ?=
 =?utf-8?B?dXMvNjcwRG1UYWc4dnFsWDhOdmMrNVQ2bU5MemdscnNlOGhvYnY4Snk2cWk1?=
 =?utf-8?B?dFN4YmhMT1pNQ1hGeUY5V0pMZHJXOUZZYmdDNnBnelAxRkJvWmJKYzUzbXRr?=
 =?utf-8?B?UER1Zk9iL3lISFMxL05xU0czV2VvcU5LMlRtV1ZrajBDaTRYSUgvOUxKQUwz?=
 =?utf-8?B?eVRVWm5JU3h5djBLUzVMNFlkZTBPZmRhUkt2R1A3U2FXMkVpajIzMWF3RUpR?=
 =?utf-8?B?MDR3cVZPa3lGUlJWMWp5NGw4Um1jRGdSbm9NRHd1R0xUOVFnZGtJcnFvVGdo?=
 =?utf-8?B?OEJlTzdaQ29lQVQxL0l3elRFclZUSmdad0NpZ1BtM3ZSQWVsUDU4V1dNZUpG?=
 =?utf-8?B?MzZkSjhzbzZGSFdRMTgwZ1UwWmpHR0pSOHY2RjJVQTZlUHM0d2FKYlJFMVNN?=
 =?utf-8?B?Yi8wTjdSSzlvTUtWQVo0czlmaS9yTHZJZzI5MFpYWWZ6ZzhQUmg5U1JnOExO?=
 =?utf-8?B?L3lMUXlyUFNnQVo2eSs4WmdPRGh2TEtHZWdwUHd2dmUwaDJXa21HQ2FvK3Nn?=
 =?utf-8?B?WEs5MStFQTBnbTNCRFR5WnNxb2diNmlyejZRdjhBaTJ4ZWppSGpQMTZNSFVs?=
 =?utf-8?B?VG9aVUxzay9aMXkzSGpva3dGc3I1UHhxT1h6cGJ3L3pmVUx6ZWVlSVBBNTcy?=
 =?utf-8?B?N0djcWgvZElraWgyc2dhV0ZEaXhZRFEwTml2cDVBS0JUWjVVRFlyUE51TFZW?=
 =?utf-8?B?UEZsaTVGTllJakxZZDFPNHR6Um9aOEVza2NidU5zRVJWaG10MGRNR091QndB?=
 =?utf-8?B?VDMycWhiOWRSSFFQUElRcEtCbEdaMS9RZ3dUTEU3cDR6ZWFhU2VjR204ZEth?=
 =?utf-8?B?VldYUUNTbWl5ODhkLythNTR6ZnlnVVRoSlBjdHdhaHZDODlnVTNBWGtURXdm?=
 =?utf-8?B?NGJqZUtpdDhFdXUxa1FXV01laHpyZUVuVjR2NnhOYnJodkNFLy9zWE05NVN6?=
 =?utf-8?Q?Tj80bhbJh98SlyWPT6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7536.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceba728a-15d5-4e79-1050-08deecdd33db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 19:19:53.4971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NK1iLYUeFfKBD+1VbbcI9D12Qx2RuO7wwpafz0PTjqTB6oVW3jmwkbnQvFuhbu6zehmwxhj50sFjlpwt/Sl5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

QU1EIEdlbmVyYWwNCg0KR3JlZXRpbmdzIEBBbGV4IERldWNoZXINCj4gQ2xvc2VzOiBodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL3dvcmtfaXRlbXMvNTQ3NQ0KPiBJZiB5
b3UgYXJlIGdvaW5nIHRvIGdvIHRoaXMgd2F5LCB5b3Ugc2hvdWxkIGp1c3QgYXBwbHkgdGhlIHBh
dGNoZXMgYXR0YWNoZWQgdG8NCj4gdGhhdCB0aWNrZXQgYWxyZWFkeSBzaW5jZSB0aGV5IGFyZSBi
YXNpY2FsbHkgdGhlIHNhbWUgZml4ZXMuICBUaGF0IHNhaWQsIEl0J3Mgbm90DQo+IGNsZWFyIHRv
IG1lIHRoYXQgdGhpcyBpcyBhIHByb3BlciBmaXguDQo+IENsZWFyaW5nIHRoZSBzdGF0ZSBtYXkg
cHJldmVudCB0aGUgaXNzdWUsIGJ1dCBpdCBtYXkgYWxzbyBsZWF2ZSB0aGUgc2RtYSBjb3B5IGlu
DQo+IHF1ZXN0aW9uIGluY29tcGxldGUuICBXZSBuZWVkIHRvIHdvcmsgd2l0aCB0aGUgRlcgdGVh
bXMgdG8gdW5kZXJzdGFuZCB3aHkNCj4gdGhpcyBpcyBoYXBwZW5pbmcuDQo+DQo+IEFsZXgNCg0K
VGhhbmtzIGZvciB0aGF0IGZlZWRiYWNrcywgSSB3aWxsIGZvbGxvdyB1cCB3aXRoIHRoZSBGVyB0
ZWFtIGFuZCBjb21lIHRvIHNvbWUgYWdyZWVtZW50LCB0aGVuIHdoYXRldmVyIGNvbWVzIG91dCB0
byB0aGF0IGNhbiBiZSB1cGxvYWRlZCBvbiB0aGUgdGlja2V0Lg0KDQpPbmUgbG92ZSENCg0KDQo=
