Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC199C44506
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 06:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B36910E54F;
	Mon, 13 Jul 2026 06:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNRpfs4Q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B04010E54F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRVCxEvoXpucRDBC3WLQr5njtH6dyePpJafM/92z0aDQyklVGjPUNPQlmxqL2v/JilXZBNLuIe+BqygwRKS/1PM4ssX89tCGOk4cydJzRr6142mkuRfyhlGM5Qn0YXNsg/sM9JfcT3cx7K7uWpXXcDFoKqK6pSBu5/g0bKLlKI7loV/uR/sj/HPU8/ACOmkuE9lBRQU6U8jft3yb6e52eFoxoKD6/yCoJlipdLW0nRTzQL0Ku26AMElPtRXvkRJBAWnPeh7hWrluj3Hd8UxprmmAQali1oT2wW86gxvC7bWtr++NrWDNGgC8pg3YyuR1RT9OyIetH0Zqm3c7ejgDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmpXwG3ILtB1y/CC73zG1rTJNULJXknJPGziTgqB6vY=;
 b=xch2CrUE53atinRff6TbNGPxueHq0GNEV1n/5MHyeo29jNRJLVtaumQzsVg/Ju4ESkx5/YutRrE1G0Dzo9EVa6uHBx8auB1PCw4Kuc9x5nLqe8N9Zc03jsLpHGMn0kkTb1BURUS+5FMUJYr/Zdf44c+Nhx9wjOSy3vX2A3RsWb380AGQc04KN5xKc0bTuBq0SDfmV1zwapuLoYT7FMFwFH79C2VZ8Ln7COHQsit4lIlfa1YkHXl62ghPvhNCb28QfBYb/BvG/in0hHBfoL3azjhlfum9dQAwJbQMCenj+PqeElc5OQzOhb/78IWsP90QuSoJ+kKlfiu5zQftMUF88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmpXwG3ILtB1y/CC73zG1rTJNULJXknJPGziTgqB6vY=;
 b=CNRpfs4QNX8hw1HFvrqbnKWVJozLb7NedoosRQ9eiP9TeU/hu2tIYcHmyGEN1you3YQ4KZkHaOHmO5XNYRTUsSJEjuYkYE1ku6+mgglwfWeREqKMzMOtFiorcFY0P6aOToWb5V2yaaNUsH64CBpn6rN8BVfrrJettU255pfabqs=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 06:43:29 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 06:43:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, John
 Olender <john.olender@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Topic: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Index: AQHdEoAxsbbV6lTFxUqqFdVvtW7SpLZrAD8w
Date: Mon, 13 Jul 2026 06:43:29 +0000
Message-ID: <BN9PR12MB521171370A960563DAEE885C82FA2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260713042902.2220454-1-asad.kamal@amd.com>
In-Reply-To: <20260713042902.2220454-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-13T06:41:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|SA3PR12MB8802:EE_
x-ms-office365-filtering-correlation-id: ebfd847f-0afc-4f86-4023-08dee0aa0cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: E45iOh58AbBji4MUI/peapR8cfENaZIcccO9OrNLsblJC9iTmg08FE1sTYj5TMIr+8/e2Jo3FAQemzVjNX7BbRc2p1vt1s1kvT9tYQBTmwEmEBPCJdaDAKu8uddKkObwXlxtVWLBQ3cKkxWRQCyz2MuxWdi/bu80ODtvMWHH0amEkABeE+lcSTZCbd+De533wD3yWxt8vvY3xn+ui8r6JWBuhl491CqbcGWxu/h8m5+1xUP5nX+yrejo43jc7MTHLgCnHygmNu+GqFU4WphOrPCrJILvttnRZQrqfCNVK1KPb5kWiAb/2sGHHVqm0VKbSbA+kVfj5h1Xn0eBpIj6QlQeXpdZe8fAooO65WNDNYUP0b935fN+Tsp7L2klQZGWnTubJVsMgLOfvbsUiP2O3RxcoeVUjZAiNlQ+cEHsd2mUKJXfFdmJPZm99ZOa9lxqo6KMFz2HLmWUmRw39+9UwFS90CIpmWGfa74fmxxjYYZFMRSBQzJZ2nzdswQEibVPROKnPOu0R6BfIvdmlfJ7db2D6H8hGKfuefgOrC+XEKTw1YAcD/yXyqOUKFnrqgGWG4ZxMlQUpweQgdBhdcaDs7NUDv5lWThzgjJYDgrRAVyU9DEC7Vxsimkw8fFyoY/meHBy/lhJuAFvSMrF1ecMhSUwaluLzUk+RCITkqf2azvGYcA+RBlLzXx2hVFVhv6Dxu3AT3ZOSOW8bjFYEOYJWeJfDUGAIkhmBnyq08JcKWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXloNTJHRW1UUGFFK2VNNXMzeUxSRGlVVm00RW1yOTZzdTlrdWdNTXIya2FE?=
 =?utf-8?B?MHI3OEJXMDRadVBEb1hoSk8rR0t1cDJFZXVnV0NlaDB5bmlwbitKUHpud0Qv?=
 =?utf-8?B?MEYra0dYMTA0Z0NHblJKQzZaMzVWWlRYTmEzNmF0VHFYZUhrMHIxMnBoVkhk?=
 =?utf-8?B?RkFQd3M3SHFpTkQvd3RHNm9xTU0yMzJRdkZ6TkUrY29yMTAybDlKTS9KejFn?=
 =?utf-8?B?Z1JkNThJV2hKTTNEeGlpSHhXd2RUUW5RU1RrVUtOY0w4N0wyVDVEYXczaEl5?=
 =?utf-8?B?OVJBUDQ3Ums3SVpBcHlyVGRyRWpqbHdzK1crVDdRWkVoUXpNaUFMQytLbklY?=
 =?utf-8?B?NDJjUDBvMXJHUTJMbi8vWjVCd3plMEo0Ly9oYU5QbnpRanI5OVRYb0Q3bXJt?=
 =?utf-8?B?NTQ4WVR2SFg3R1FGSWE3Wkl0WVRjZHRHY2N1S2psR2dHczA0cFEwZS9iVXlR?=
 =?utf-8?B?NG45QkVqekg1VzRGd1hPQ2NtSnJwT3lpM0o4Q0o1MXR5T0JmTEJmNnNNMngy?=
 =?utf-8?B?NThkckJMbVJVUTRWeE9GL1hhMnRRbE1nM1c0TTQyUE5DcmtPaE1ucmZZNlV3?=
 =?utf-8?B?NmptQTBKcVI1N1ROR1NDaHB2RW9TbU5JVmNFT3liNXM4MjhSR0NVbnE3TzNI?=
 =?utf-8?B?bmpTaURZT3YwQjhhSktBNStTTWxGWFhBREVuRm1jSjhKR0V3dG1VakhyeVlL?=
 =?utf-8?B?Y1hZMHc1UVBoVXBwdHNObTRoSVo1aHR3N0FzZW0xbXJQd2VWeDRmZjFHUzUx?=
 =?utf-8?B?TDM0dUFlSlJndFhRWnJNeG9CaVZ0c2ZidHVGWGp5Q2l5cDhsUWh1UTliVTJo?=
 =?utf-8?B?OGYwcVVqbjJkbWJMUm5Fck12bTYzbnpMKzR6Z0tPN29sY2t1R1h1Uk5JZDZi?=
 =?utf-8?B?M3lSYWxBQW9rU0FkQUN2Sk02VThEOUdTSG9ONmFVNnB1VWkya2w4ZjArZmxp?=
 =?utf-8?B?UUdPc1JRalJ0dXBEdHFISDlYcjRVYTg5Qmo4eElXcFpLUmsxWVcwS0doNEd5?=
 =?utf-8?B?ZU5XRnljbU9RajBTdFI2ZHlhdDVSYzZGV1F2WC9iZDVnOCs3dVVPZmhRQlB4?=
 =?utf-8?B?WlJtNktFZXp3dWo4aUNJVWpYZ0Z5MnhUVmtRL1JjQ2c1MFFSaVJVRmVoczBi?=
 =?utf-8?B?d2h2MEpub2pwN2xMZGQ4K3lvR1VVcVp6Q1JrOWVGL0g0ZDV2Q2ZEaXBtR1lY?=
 =?utf-8?B?bkpnUzRPcFpyL2FxQW1iZlZIZG9yYkxHNlF3ZDZ2ejgzc0JiWGphdnZ0MHl4?=
 =?utf-8?B?cTVrZFd3c2R1ZnRmUmVwR2JRSHVtSmViajd2MFJtYzNwT2Zwd3hBQ1dweThC?=
 =?utf-8?B?TUFudTlxUy9kMHN2c3ROeVljTjhIeGV5K1lHNEgrWkJJSndOWG5IdGRCV0pz?=
 =?utf-8?B?OUNONlZQZDJBT2VRaUlBRERjYkN3RzZFM3kyaTBjSk52c09zbXJUS1dwczcr?=
 =?utf-8?B?OE8xNFhFeWhxc2dOeWVuY2FZd2RPb0VwWVI4bFZ1LytGK1pFZ3dOL1RSS1RL?=
 =?utf-8?B?bDV3UnU4OFlPNlcwZjg4dTFyVTYycTFCdFpVWXgwSXc0cnkwNzF2eTRRekZE?=
 =?utf-8?B?TlhlcDl5ajI3UUk1ZWR6OHhKeS9VRVkwWGlDRlBkR0paV0NqSlE2QjV5ekN1?=
 =?utf-8?B?MVF5US9BVnQ2dENzTkdYUStQMkRKMjR5b2RQbWFlZEVNYWVNV3A4STBPNFE3?=
 =?utf-8?B?dU5DaHRGVWpTK3dTcXYwTHg0T2htc3cwWW93RmJLY1FVUmxheGRwQXNQRHlO?=
 =?utf-8?B?VVRjU2duVTJBeFBkek9XRnl1OVNEdGRvdEtzV09RUTlNQ1NQaG1LMWIrZWRa?=
 =?utf-8?B?WkUzSWYraXpCaHBkSHpMVjAzNWtsTGlSSEYvWVUvWE5keHQ4cVBwNjVoMFc1?=
 =?utf-8?B?TzJTbENVeERFRndKWC9GVTRheWxTRnU5NjJ5OE9qMzEwKzZ1SUFHRGVONzBl?=
 =?utf-8?B?UFg5b3ExQ2JyN0oyNjJmOFR1OExYek4reGRvK3dOV3dPK2tFV2luSEk4ajZ2?=
 =?utf-8?B?MVg1eTB1TTJLVDdIamdWdDloOWVXNWllRVJHdjhXTVhlMmdoTldnRmpxNFBX?=
 =?utf-8?B?VTJGY0RsZUlGT2U3ZmdDWnBHelk4cEIzcDFwb3NHRCtybktXNkV0cTNLYWJ5?=
 =?utf-8?B?Zjh3ZHE4eXJLczlvK0NYS21LcVA2THRoQnBVUnVPdHNIWWgrNmR4NnB3TlJr?=
 =?utf-8?B?RzFjdGRObWJvYktjcUs1Z1hKT3VkSkhjUExVcC96aWpVckNYckxxN2kyRTBn?=
 =?utf-8?B?KzZ3b2d1OG1rVmd0WkRvSUI5RldqMUhXUjE1R2E1a3VvaGRibFZCektwTTV5?=
 =?utf-8?Q?rUCYmLzWK258w6+1rb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd847f-0afc-4f86-4023-08dee0aa0cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:43:29.5718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD2HwxhJcpJNQo7DsOziRcgCoIQsMdqYUsrjfxCVTaYONWxbklQ4JhmL5Wkba7EG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW1h
bCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTMsIDIw
MjYgMTI6MjkgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBM
YXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IFpoYW5nLCBNb3JyaXMN
Cj4gPFNoaXd1LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKQ0KPiA8S2V2aW5ZYW5nLldhbmdA
YW1kLmNvbT47IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBKb2huDQo+IE9sZW5k
ZXIgPGpvaG4ub2xlbmRlckBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9w
bTogRml4IHBwX2VudHJpZXNfbWF4KCkgYmlvcyBjaGVjaw0KPg0KPiBDb21taXQgM2NmZTQzMzYz
MDUwICgiZHJtL2FtZC9wbTogVXNlIHVwbG9hZGVkIHNpemUgZm9yIGxlZ2FjeSBjdXN0b20NCj4g
UFBUYWJsZSIpIGNoYW5nZWQgcHBfZHBtX3NldF9wcF90YWJsZSgpIHRvIGttZW1kdXAgdGhlIHVw
bG9hZGVkIGJ1ZmZlcg0KPiBkaXJlY3RseSBhbmQgc2V0IHNvZnRfcHBfdGFibGVfc2l6ZSB0byB0
aGUgdXBsb2FkZWQgc2l6ZS4gIEFzIGEgcmVzdWx0DQo+IHNvZnRfcHBfdGFibGUgbm93IHBvaW50
cyB0byBhbiBhbGxvY2F0aW9uIGNvbXBsZXRlbHkgb3V0c2lkZSBhZGV2LT5iaW9zLA0KPiBtYWtp
bmcgdGhlIHVuY29uZGl0aW9uYWwgcHBfZW5kID4gYmlvc19lbmQgY2hlY2sgaW4gcHBfZW50cmll
c19tYXgoKQ0KPiBhbHdheXMgdHJ1ZSBmb3IgY3VzdG9tIFBQIHRhYmxlcyDigJQgc2lsZW50bHkg
cmV0dXJuaW5nIDAgYW5kIGJyZWFraW5nIFBQIHRhYmxlDQo+IG92ZXJyaWRlcyB2aWEgc3lzZnMu
DQo+DQo+IEZpeCB0aGlzIGJ5IGNvbmRpdGlvbmluZyB0aGUgQklPUyBjb250YWlubWVudCBjaGVj
ayBvbiBoYXJkY29kZV9wcF90YWJsZQ0KPiBiZWluZyBOVUxMLiAgaGFyZGNvZGVfcHBfdGFibGUg
aXMgemVyby1pbml0aWFsaXNlZA0KPiAoa3phbGxvYykgYW5kIG9ubHkgc2V0IHdoZW4gYSBjdXN0
b20gdGFibGUgaXMgdXBsb2FkZWQgdmlhIHN5c2ZzLCBzbzoNCj4NCj4gICAtIGhhcmRjb2RlX3Bw
X3RhYmxlID09IE5VTEw6IFZCSU9TIHBhdGgg4oCUIGVuZm9yY2UgcHBfZW5kIDw9IGJpb3NfZW5k
DQo+ICAgICB0byByZWplY3QgYSBtYWxpY2lvdXMgVkJJT1MgaW5mbGF0aW5nIHVzU3RydWN0dXJl
U2l6ZSBwYXN0IHRoZSBCSU9TDQo+ICAgICBpbWFnZS4NCj4NCj4gICAtIGhhcmRjb2RlX3BwX3Rh
YmxlICE9IE5VTEw6IGN1c3RvbSB1cGxvYWQgcGF0aCDigJQgc2tpcCB0aGUgYmlvc19lbmQNCj4g
ICAgIGNoZWNrLCBzb2Z0X3BwX3RhYmxlX3NpemUgaXMgdGhlIGtlcm5lbC1zdXBwbGllZCB1cGxv
YWQgc2l6ZSBhbmQgaXMNCj4gICAgIGFscmVhZHkgdHJ1c3RlZC4NCj4NCj4gRml4ZXM6IGUzMGIz
ZTNhYjUxYSAoImRybS9hbWRncHUvcG06IGFkZCBwcF9lbnRyaWVzX21heCgpIGhlbHBlciIpDQo+
IFJlcG9ydGVkLWJ5OiBKb2huIE9sZW5kZXIgPGpvaG4ub2xlbmRlckBnbWFpbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9pbmMvaHdtZ3IuaCB8IDE1ICsrKysrKysr
Ky0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2lu
Yy9od21nci5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaW5jL2h3bWdy
LmgNCj4gaW5kZXggN2ViYzEzNDQwMjNmLi5hMjNlMDE5MjE4NDIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+IEBAIC04MzMsMTQgKzgz
MywxNyBAQCBzdGF0aWMgaW5saW5lIHVpbnQzMl90IHBwX2VudHJpZXNfbWF4KGNvbnN0IHN0cnVj
dA0KPiBwcF9od21nciAqaHdtZ3IsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHZvaWQgKnN1Yl90YWJsZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZV90IGhkcl9zaXplLCBzaXplX3QgcmVjX3NpemUpICB7DQo+IC0gICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaHdtZ3It
DQo+ID5hZGV2Ow0KPiAtICAgICBjb25zdCBjaGFyICpiaW9zX2VuZCA9IChjb25zdCBjaGFyICop
YWRldi0+YmlvcyArIGFkZXYtPmJpb3Nfc2l6ZTsNCj4gLSAgICAgY29uc3QgY2hhciAqcHBfZW5k
ICAgPSAoY29uc3QgY2hhciAqKWh3bWdyLT5zb2Z0X3BwX3RhYmxlDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKyBod21nci0+c29mdF9wcF90YWJsZV9zaXplOw0KPiArICAgICBjb25z
dCBjaGFyICpwcF9zdGFydCA9IChjb25zdCBjaGFyICopaHdtZ3ItPnNvZnRfcHBfdGFibGU7DQo+
ICsgICAgIGNvbnN0IGNoYXIgKnBwX2VuZCAgID0gcHBfc3RhcnQgKyBod21nci0+c29mdF9wcF90
YWJsZV9zaXplOw0KPiAgICAgICBjb25zdCBjaGFyICplbnRyaWVzICA9IChjb25zdCBjaGFyICop
c3ViX3RhYmxlICsgaGRyX3NpemU7DQo+DQo+IC0gICAgIGlmIChwcF9lbmQgPiBiaW9zX2VuZCkN
Cj4gLSAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgaWYgKCFod21nci0+aGFyZGNvZGVf
cHBfdGFibGUpIHsNCj4gKyAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqKWh3bWdyLT5hZGV2Ow0KPiArICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKmJpb3NfZW5kID0gKGNvbnN0IGNoYXIgKilhZGV2LT5iaW9zICsgYWRldi0N
Cj4gPmJpb3Nfc2l6ZTsNCg0KVGhlIHR3byBleHBsaWNpdCB0eXBlIGNhc3RzIGFyZSB1bm5lY2Vz
c2FyeSBhcyBJIGtub3c7IHBsZWFzZSBkb3VibGUtY2hlY2sgdGhpcyBwYXJ0Lg0KDQpBcGFydCBp
cyBMR1RNICwgdGhlIHBhdGNoIGlzDQpSZXZpZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcu
d2FuZ0BhbWQuY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KPiArDQo+ICsgICAgICAgICAg
ICAgaWYgKHBwX2VuZCA+IGJpb3NfZW5kKQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+ICsgICAgIH0NCj4gICAgICAgaWYgKCFyZWNfc2l6ZSB8fCBlbnRyaWVzID49IHBwX2Vu
ZCkNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgcmV0dXJuICh1aW50MzJfdCko
KHBwX2VuZCAtIGVudHJpZXMpIC8gcmVjX3NpemUpOw0KPiAtLQ0KPiAyLjQ2LjANCg0K
