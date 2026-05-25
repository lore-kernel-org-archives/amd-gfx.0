Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36AECD4F54
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 01:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D86810E0E7;
	Mon, 25 May 2026 01:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVSJvxb9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0737F10E0E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 01:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1ERh74TgbR7a+iAvvhTt69814XuUKfM88Cjd7t7Y9MlS3tbOS8vkhkkKOyYnMRHcDwLlG6+cvdXqSj7hVmwGQN6PftdCgetv+5eqen3wWxaJOjAf+gx9RGlYDjcopFNHM9bP97HuRoJoP387LOT0hfyMkEnAZ7oO9X7pTpKqBKCipo3TtHWrtw9ZvM3hPm4exl0DO29NgM3GYUnagCI5BjHx9iTI2QgM8KisP6c6cyhOKh92YwO398YKretlprgZ5UC+IJodqVGFbuEVcSOPbAtUm9TzJwoWkCNFz7pfkdGipgLcXrwNsN7lmlAS/eAancz2pkIyP2ruLBOrccm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ5bZJST2roAM3ScPCoba4z6w22e8GGPRk/R1PhCuwc=;
 b=jlyRdeqgnu1Y0W+wX95+AvtdqzF8RMCJtPp7sa0UbLUBEJYhqqTgRW5NOrvP3lym+bD3smQJyqng1GmLN45tfIZOzm2zNolL3mxkbC2p9q4owEFc9aEGQlaNYlAIm+FR5PY1Y41QsqTulrcK+5J7k6SAlYicB6uOUyJL6eQ2E0aCaT0tSqU9dszAGHSj4Ub5mSUed5IrJbyhYxJ5PFnpqv9i5MM1D9f4muU8ln4z/5JPmqX8JVm7za/v2RbItaqXQhxiiJ+n4b26WWroziqLradWaT4ROMlGT5Ljk0riQiC3kPKoqjV1PjcFbtdJnOWWDFVJevDlkxkhufdN6axmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ5bZJST2roAM3ScPCoba4z6w22e8GGPRk/R1PhCuwc=;
 b=oVSJvxb9jjhwuKNapNX98S1KZD+WwOkReGfpvmTKGifv5Z8q6rqKVEkWW+zGB651D3pl7SlVW1LvTwK5kqJI2SI4rZYn9KS/UCs2eskiKAtzp02JbCejnW8WerCYlqdNAT1c+ql/iOaw3x7kMgEuT4Ii68K7x1WTTLj1M+0eOpE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 01:27:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:27:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
Thread-Index: AQHc6c3X+PjL8ty2PkGMvDS2KrtXarYd94Vw
Date: Mon, 25 May 2026 01:27:02 +0000
Message-ID: <DM4PR12MB5152B40872432200FA407C72E30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522093147.11192-1-christian.koenig@amd.com>
In-Reply-To: <20260522093147.11192-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T01:26:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB9064:EE_
x-ms-office365-filtering-correlation-id: 3cbf897c-f706-43dd-7d4d-08deb9fcb9a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021|11063799006;
x-microsoft-antispam-message-info: IK4x8AleVUpgrMFlGZvHS6xsHXNrPul54sCRE9ptwwbjRyFb71T9Enmvu2P5o/LTyetCHZ0urWSuvgsBY8iEci0E/2NaNK5xyRbtppGAJi1ZGriPfjA4UCVFnjhLvtWAF0Ww2cPSMA3FjF5QWmi346hAV6OLIsk6qKgihjDE25o173eAAdQpSM8VZEAwGdJerHOdLWFc0LXRzlsioQz7rQ0/PrK+yAOPKnklyFReGIFcIvn/sbO0bsxZNjTFEIAIJphra8jnYxebVoTlU4fKCLArx4lNOy8mnib6QWzxtTXmU/6SA5HOwDpPd1BiKEzzua8GgW5wxUFDCo6oWPHWjfANBH3MN4/MP6LSC9GL+6mxnLx7IAS4kUgCeETSg/tInOyDOOZiwhuc9yN5kx/FUdPC5Z69NTRBHy5Xc7PLv3PR49kkRgPR6V6YLmgkT6TtouUso2cVI1gXRLpCXrPvWh+t7OKJrHNkZYgVYfjn0TGtBiQDgDDwVtANf/nrAfCmhnYb6WsEpB8k7AAQmpJi+767ReF0I1YXg1a36I24vZD4ftXiOdSjqZbl8rI7YB/uyEx5K1iebqDrVwBKQKd+WZGyEOx36jDy5kWLVYZZA9m6NcBuoIy+nOWTPgwRL+86b0j/q4FoWv6MTd/lEjB2cqseZPH7pFP2GQfr+EbxFdJ8OkgZNj/0m3GbNZp90Zbcpw1UY6xUqbRPEy+AT81Y/SKL5WNdKKp/w9U4HMKC8YoxaE6kIqQrWcO6Bq2pVGtZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEgvYWZkMUh4c3EwWDBXSFh6bFB3VWhncGk5UlAySU55aW9LUk5TMzlwK2xz?=
 =?utf-8?B?U2U3cGRFd3kyOE5tSSt6UWxEaG0xc2lrWlFiajJCMEdHVUxIUUJ1cVM0bkRJ?=
 =?utf-8?B?N2ZaVDdnTGMxWkxzMWpzQ1hNSExBQ0JNN1JHR24vUk9HdUZnZHlIalZJM0p0?=
 =?utf-8?B?cytrRGdwUE1jaGdUcFlCbDJkQjFwdUNXTWxRSUFkU2JBalIwSXJYQXF2VE1I?=
 =?utf-8?B?ekVLNUJaUnI4V1BKSzA3TWJUZ0lSNlRlN0QvSjh6UEVMQ2UrdmdCWXc4eld1?=
 =?utf-8?B?YTN0aktTaG4rOTNhT3ZpWlU2bUhYV2lkcGVBYU02dWx1WHdURlIvcnJyTnlP?=
 =?utf-8?B?dk1GYkV1MGUxQmU2SEJKazNrMHJucEF3Mjl2dng3MXVhS0ljMkJzZnpkV3E0?=
 =?utf-8?B?cnlGL2RvRU8xbitXQmNMZEpOc2hoYzgzNGZFUVp1T0JLd2NKV01DaXRFWG16?=
 =?utf-8?B?MUhyejZyeFdUTmlVUVJWYUNtOHFNTXFqT0dSUXdGdzJwSFpMMXhHWFFQcldG?=
 =?utf-8?B?ajRoQWhSWnh4elNpWjlaNk12Y3dVaHdGVG56ODJLakRVK1gxZTBGMlFpZTc5?=
 =?utf-8?B?U1JRS0pLcXUydTFvSTJUQ3AwMzlVNmgrVmZ2ZnVJbnVkSHlxUzVsZTB1WnE3?=
 =?utf-8?B?ajh3MHdZOWQ0NE5SYlBLLzFXSENab0QwVXNnNG9oa0RjdDIvanVJcC9UY2VO?=
 =?utf-8?B?L1FFU0J6UHEyM3NiWklwWXhudlNhOUZsaW5oY3o5ZHZsL2RWd2pjM2k1VHRm?=
 =?utf-8?B?ak1sZDA2V0VaMlNZV3BZOTJOT3cydStQcEEvNVg3bEtnNkMrbVUrMzZKc0JI?=
 =?utf-8?B?bWlNTE5oUnlOd1Vjd2FXdkpiUVE2elFNOEdYNTdEdFZtejF4L2FSVGhidnk4?=
 =?utf-8?B?amUwejZHb3pDKzJwczJIcFRuaG9FMGIwRTFtTWNGdk1YWEhpc3dqcjI1TGFZ?=
 =?utf-8?B?cHdlcFhveTVJV2ttbk5QQ0NwWDRHNDZvNmFLazhUVk44Q1p2b1FZeEJLaFFQ?=
 =?utf-8?B?b3YzQTZwc04rOUhuWEwwbTJOUy81bUwzRnBZSkpYZmZCb3paOVRIWCtCOUJK?=
 =?utf-8?B?TXAwNVJNNzVkd09ZR05FVnEvT2c5YTZ0bTJHZVdDNnQvQktpM2JVNHdWQ1lH?=
 =?utf-8?B?S3owYjBoQ3ljME1oNEtGMmlmc2dHV1RGQWFpOC9ZR2JBdWlIYVI1T2xIUXp5?=
 =?utf-8?B?SjdJRExDeHdYOGVqcDdoV3owUmR4Y2I1RGVnc3V4KzRoMzRkYlc5b2pSbXZV?=
 =?utf-8?B?bjZBQXJNeVpLb1ZsTWl3NjVYcVRxdTJ6MlgrSGR3aXAxY3lZeDd2RFhWVDFx?=
 =?utf-8?B?RERMcCtEQU94WHpIaUxkNDduaTRDaVF2a29ocE84YjlDUEYxWVo4R1lvRFBU?=
 =?utf-8?B?V2pmcG5NNitmanpiL3MvTHNiZStKS2ptQWdJbEkzdmVDRFFxWHZmY1pzSFpI?=
 =?utf-8?B?TVBMSTVoSktPMTNoNnpFRVdZQjlDTEh3WFloMTlGMEJkbDdVOGo0U0ZYVkdI?=
 =?utf-8?B?c1VhdHJyZ3creEZCemdyNEFuWjhCd0F2WU1yakorbXNGanhJM05semV0T3pp?=
 =?utf-8?B?MDFpNXBaa3ZmdElOUVZwVS9Tc0JqWlJWbHhSQWFtV3BrYUJxM1UyeEE3SEJw?=
 =?utf-8?B?TDB1QXhCeVM5eThCcFFSTGF6OVczYUtRM3ZoM25nTFp1Rm5QY3AwcytOVUww?=
 =?utf-8?B?SStxZ3U2RTNZbGs0Z1pWandEdjgvWEJQY1BLUkFkZXZHSE9zN2N4KzEvekJS?=
 =?utf-8?B?Q2pNQXUxOGFNZkcwaVplaFd1VkJVK0UxWFhHNWs3bWlhcEYzWmpXbkNVQWpD?=
 =?utf-8?B?eFZVMi8wV3hqOS8yUkg4YUROUks3UVg0bmJYcHROSTFwbWd5aUxTUlEwdjUx?=
 =?utf-8?B?Q0ZWS3lKMG1oSHN4OE0wcGkycDM5cEJVTEdiQVY5a1FVWGJmRTM4UGkzUGtB?=
 =?utf-8?B?aE55dVFSS1RqTEk4SU1kcytwVVQyTmh6WEVCYzdBUFY3WCtIcDY5S0dubzV1?=
 =?utf-8?B?ekU0YWZPYzZibmxOb2l4UCtTc1RyVW83WVY5NHdwUm9mTGY5aTBRNzRpbncr?=
 =?utf-8?B?OXQycUhVSGpkTU1FNyt0UUUvM21WUDdoajNsZmpqc284cDRUUXk2dkxEaGlr?=
 =?utf-8?B?QlJJMWdkN2dTaTJXZW5YbnBFQmtwdEFGTjl3eG9mR3B4TTlzRjdtbjhBQlZB?=
 =?utf-8?B?S3pjenRGaGx6dWs2NW5hZHF0YUpYY1MyVFgyVHZDTzJOSkhLcHljQjBvQlI0?=
 =?utf-8?B?dEg4M1lJNnp2T3RUampoN0YzY2JLdExkcmFxV2t1TU1WaEJ1dzJqeHF6Z3Rw?=
 =?utf-8?Q?oIwAfkLcpbN2O72LXz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbf897c-f706-43dd-7d4d-08deb9fcb9a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 01:27:03.0232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dH3RQ+iJ1qqueQqpLHN4EXD4hXKYg9AnSbo71j4BLfUhkFwdGbgtYijkcDyhxyn5xscfBHln1r6YZir2pJKnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

QU1EIEdlbmVyYWwNCg0KVGhlIHBhdGNoIGhhcyBiZWVuIHZlcmlmaWVkOyBmZWVsIGZyZWUgdG8g
YWRkDQpSZXZpZXdlZC1ieTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+IGFuZCBU
ZXN0ZWQtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJpc3RpYW4NCj4gS8O2bmlnDQo+IFNl
bnQ6IEZyaWRheSwgTWF5IDIyLCAyMDI2IDU6MzIgUE0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhbWRncHVfdm1fYm9f
cmVzZXRfc3RhdGVfbWFjaGluZQ0KPg0KPiBDYW4ndCBzcGxpY2UgdGhlIGxpc3QgYnV0IG5lZWQg
dG8gaGFuZGxlIGVhY2ggZW50cnkgaW5kaXZpZHVhbGx5Lg0KPg0KPiBPdGhlcndpc2Ugd2UgcnVu
IGludG8gaXNzdWVzIGFmdGVyIGEgR1BVIHJlc2V0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxNyArKysrKysrKysrKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IGI1MjNhN2I5
N2Q2Zi4uZTkxNTA0ZjA0ZDk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPiBAQCAtMjY2LDEyICsyNjYsMjMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2Jv
X2lkbGUoc3RydWN0DQo+IGFtZGdwdV92bV9ib19iYXNlICp2bV9ibykNCj4gICAqLw0KPiAgc3Rh
dGljIHZvaWQgYW1kZ3B1X3ZtX2JvX3Jlc2V0X3N0YXRlX21hY2hpbmUoc3RydWN0IGFtZGdwdV92
bSAqdm0pICB7DQo+ICsgICAgIHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqdm1fYm8sICp0bXA7
DQo+ICsNCj4gKyAgICAgLyoNCj4gKyAgICAgICogRG9uJ3QgdXNlIGxpc3Qgc3BsaWNlIGhlcmUs
IHdlIG5lZWQgdGhlIHNwZWNpYWwgaGFuZGxpbmcgZm9yIHRoZSByb290DQo+ICsgICAgICAqIFBE
IGFuZCBzZXQgdGhlIG1vdmVkIGZsYWcgYXBwcm9wcmlhdGVseS4NCj4gKyAgICAgICovDQo+ICAg
ICAgIGFtZGdwdV92bV9hc3NlcnRfbG9ja2VkKHZtKTsNCj4gLSAgICAgbGlzdF9zcGxpY2VfaW5p
dCgmdm0tPmtlcm5lbC5pZGxlLCAmdm0tPmtlcm5lbC5tb3ZlZCk7DQo+IC0gICAgIGxpc3Rfc3Bs
aWNlX2luaXQoJnZtLT5hbHdheXNfdmFsaWQuaWRsZSwgJnZtLT5hbHdheXNfdmFsaWQubW92ZWQp
Ow0KPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUodm1fYm8sIHRtcCwgJnZtLT5rZXJu
ZWwuaWRsZSwgdm1fc3RhdHVzKQ0KPiArICAgICAgICAgICAgIGFtZGdwdV92bV9ib19tb3ZlZCh2
bV9ibyk7DQo+ICsgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh2bV9ibywgdG1wLCAmdm0t
PmFsd2F5c192YWxpZC5pZGxlLCB2bV9zdGF0dXMpDQo+ICsgICAgICAgICAgICAgYW1kZ3B1X3Zt
X2JvX21vdmVkKHZtX2JvKTsNCj4NCj4gICAgICAgc3Bpbl9sb2NrKCZ2bS0+aW5kaXZpZHVhbF9s
b2NrKTsNCj4gLSAgICAgbGlzdF9zcGxpY2VfaW5pdCgmdm0tPmluZGl2aWR1YWwuaWRsZSwgJnZt
LT5pbmRpdmlkdWFsLm1vdmVkKTsNCj4gKyAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHZt
X2JvLCB0bXAsICZ2bS0+aW5kaXZpZHVhbC5pZGxlLCB2bV9zdGF0dXMpIHsNCj4gKyAgICAgICAg
ICAgICB2bV9iby0+bW92ZWQgPSB0cnVlOw0KPiArICAgICAgICAgICAgIGxpc3RfbW92ZSgmdm1f
Ym8tPnZtX3N0YXR1cywgJnZtLT5pbmRpdmlkdWFsLm1vdmVkKTsNCj4gKyAgICAgfQ0KPiAgICAg
ICBzcGluX3VubG9jaygmdm0tPmluZGl2aWR1YWxfbG9jayk7DQo+ICB9DQo+DQo+IC0tDQo+IDIu
NDMuMA0KDQo=
