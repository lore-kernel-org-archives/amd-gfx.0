Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEC7ED7B8B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE91710E5BF;
	Tue, 14 Apr 2026 08:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1WynO52U";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271E310E5BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr8wL1TNFWH5euXDBytntJPhjYnr7qWhtidZUsqm2kAIys+cjOQBDoDqt24BP/y3RIFTsf6tx1lSQFWTNAMIgYXW0NfTdXuXCUml5vIijBvJrGYeFUXyk9RfHojoZeTKxW685/76YUyaxO2NgfkG4RA20fJPhsoqEtVThj899vpdH8pR08gKrgewqmR9bPekQKMXXBcZbewMWGTrwqFnGehmMITuXHDb0F3x/0CGBHprJl0GwGbQow7CgpzrxpUB7kx/DePG6fnhBgkRLUduiXDRYpokYmqeDQoa9eLgoUKujAZbIW6H4mgUYHHA94uxiLYufDqPQDZOpJ2hpQaRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHRTxkfZcA7oXKnAIlyj5Jm7mZB10wS6BRMSfnspJmc=;
 b=m+H4xW6ckOOeE+vEPRnxOUPM8YX/AfAv801hxMfW6qJzeo23ZO7a0csw7mOrfjCLKFgoy6xkPjWg3TMtvMqWvNNNVWdJLxWLJNMckz08npfatLsmvgfd9SI+XJc7zt+QKr3wsDzeGwv+q8Ee+iDIJJ7jG7+qBoe0L7e4dB3lGsV7x+ykifcsv6/RLBB4r6slmpFHRPnspstP4cAGYC1IQd1/lhKf4rex7BASZzhbjGH9BKxMFzyAJRjJyWQqFu6SKQC+dVECJNPm+iHcTgOrENBwcZ36n2G48ebfzpDRjSuBRmok4DOp7PgvLwxE54KPPy2t1OYRRojsU5DTAOE8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHRTxkfZcA7oXKnAIlyj5Jm7mZB10wS6BRMSfnspJmc=;
 b=1WynO52U/9huNlAhlvevQ7sKuBOGVSqxAMQq7uP2A51OLUgOnWnvd6mV0SQOs/Ma9oNKxLvWctmtCfZ8S2xoYn9qdDnCc7LxA8FsejKWrmASUFY3+5GRj9NClEXcLjqR9VYFjHcN55A8GuiBpRBhGAqNqd6USPcT53nuuIh1uVw=
Received: from CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Tue, 14 Apr
 2026 08:47:57 +0000
Received: from CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1]) by CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 08:47:51 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <error27@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Fix mode2 reset ACK handling on aldebaran
 v2
Thread-Topic: [PATCH v2] drm/amd/pm: Fix mode2 reset ACK handling on aldebaran
 v2
Thread-Index: AQHcy+qxL7AI6MxRtEGffBryJBBHAbXePuJQ
Date: Tue, 14 Apr 2026 08:47:51 +0000
Message-ID: <CH0PR12MB5106DACEDD06DB688D911480FE252@CH0PR12MB5106.namprd12.prod.outlook.com>
References: <20260414084236.2333815-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260414084236.2333815-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-14T08:47:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5106:EE_|BY5PR12MB4260:EE_
x-ms-office365-filtering-correlation-id: 47651509-769f-4875-d8d8-08de9a02831c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: XQZXIw7fB0SQdfeHScHlvKCzDmNx+7qLVgtK+mQxLDyX8gvN2N5LTOn8SJB+THguw1C6StPTTrHjsLC2SNr2DrG1MU5keGLR02cj8vlJDf4f6yRAbG+g8wU8k/obk1opAVmiO0vi/nFzeuE2Y35ag/p4ypkOEc3qhDNJbBMSTguA/vKsVSOnBIwq/yQ6PruVSPHXC20EzmVS25SaBgwCYcqzstemwOuy733grCz8yYqLB/fmPfWCmRbUulqebX+wz56UhF9M87KdrOr2QiZqjlbYTs3IGT6xOfAJ/7hSvlzxOH/Cqt7eCiJin4kuioWBms2wyTryNpBnU5DLkriBKd4ULfEanVyV2ftJEaGlPrRJzwmYy8spKuKlPQIqjjyrejrRu+RIJn7iXPvZzbmnsC4Uw9PCFbqaW1wEpqZmLLgktQLH5KRTkYcjCr9NHzDSikXyHD5SIiuRv8w5t4OhFyDcAhUMRQ9ijEv8DioxTmrFpljhogRzqoJW+vEx2qLreQ4eF8SwOCwcmpobGuj7pKt4rOIUmNDpJ0ITmxqqWNlMbMe94spRkiwM17sCUJffxXyM3p0rrA5Jku49nhrK25Fo25YKNVw5A3pjGTynbGbMl3k5vr41HTdYWGBJb8pY8Oj6j0BqekKVheUnIxevmrwxdf8edcawyruoDW4Ws/Id5lA9j6JrdXuD/L1cjTOX3F63tu1nXjFONl8ac7nWyuw0OFoee22pfO6HlpDZj+WV2zGwXrh3RDgC/06SOsXdjchQaOin/ziOZn3U7OlSlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkxVSHZNUnNzUm5zeEdFTHh6cW1jdjZ3WW9YMEw0OGNwSzRPQngyVmJ4QjM1?=
 =?utf-8?B?akQ4eUYvU3M4YjFnRjFBQTVXTUJKU1NJUUI1VHF2ZnRPYXdzRXZOUzAyc2tz?=
 =?utf-8?B?dlJSSmE4bTdXcTBsNFVXaWRvaGJaVENBcjBlUjZkeDErOFhGWUpkZ3NuK294?=
 =?utf-8?B?ZXNNT3kwcjVEU1JucjhQK1pkcmNUYXJvQWU5Q1JYMWhJWDJKcWZ2UVdJbHc3?=
 =?utf-8?B?Qy9zUjluckwrNGJ1cE5lVi9BVDUvWVYzRUVHRWJ1R3NYL1BrbkgybU9zT0di?=
 =?utf-8?B?SDl0ZURJaFdvUFQvYnNxTVIvSFlPQU9WUndtSnEwVm4rcDI2UEk3Qm02Nmxl?=
 =?utf-8?B?eHYyYVd4K1NmUFpHVWlVcm5KbHFVaHhLZmZMeWZwN2ZhSUZzTktidmpOQ2lJ?=
 =?utf-8?B?T0JTQ2tJNldZVi81YnRkUFYyQVk2NFRmdGZWMC9uR0Z2SGMyRnNHNlBmeUFp?=
 =?utf-8?B?a3ozRVZvMnZSemJrYUY0T2RoU3FoL21haEl1Y25sN255SjZJK3N0eEdMYUkr?=
 =?utf-8?B?RHlmajNNYXk1N1hNUWpzN0ZITzQzOWhXRjZQOEM1QUo1UWJuQ3BvZWtmUFFW?=
 =?utf-8?B?ZmxGSjJNeXJqU0V4TFhxUllDVTgrRHQveW51aFBkL1MwUEFDQmhaZmRLV2JW?=
 =?utf-8?B?MytBQ1dMejZsa0JxYWhkMUYxSVpiOFJEYXhKU1JPT095K0R2MkN0UngxSUN1?=
 =?utf-8?B?d0JoM0NqdVZqRmVIai8zQUZqcS9FSC9XR0s0UnhERVhCMFZ4OW9EV1IybUtp?=
 =?utf-8?B?cmhpa1BMV3c2UGtpWlVuUjEyaDByRkNPeFRhamtHdUduSDBvNlpINXU2dEQ3?=
 =?utf-8?B?WVBGdXM0WkdnRWdXOW9ybVhMOGNvVHVnNTc4L3F3Q3F4YzVIWWtid3BjOFdp?=
 =?utf-8?B?ZGZJa0h0ZkhZVFpHSWhnclNPcWhjd0xsYmJoTVNCWHNCVFhrZDJ3dzJjRnF2?=
 =?utf-8?B?aFpWS3JNWEQ1ckMzaDFhNDJ6Q3VuUmNYRFhrbWJNZ1UzbFh3MC8xM0N4c3Z5?=
 =?utf-8?B?SWlGbE0yM3FnUlc1cDJHcS9jOEZ3bW5WVGVaa0l5WTArVTZoNTgyaXNUZ2VJ?=
 =?utf-8?B?L21vRENGY0VQeW93bXRmZWduanBOME1EUlNtL09HUTdjbjltK3o2VEhWUXFR?=
 =?utf-8?B?Q2lMWjhGZjVhOU5hZnphUjVueFFuNk4xR0ZEMC9VM0JXYnEyNlNxbGY1L2ww?=
 =?utf-8?B?cTZvQTJNYnk4STNnTmpkc3VGQ1MxeEh5YWlaMzZVQVlXRW9meGNXekV4d0hP?=
 =?utf-8?B?bVN0Tk92eUlYMk9VdjVQRmM5c1JTdEE1emZEdmNFNlpseUVmQzBvWUMzd3FV?=
 =?utf-8?B?c1ZHSTR2dldrQkFBclluckd3bS80dWo1R29jMU53cGN5SmRQK2pnVWZCNEFF?=
 =?utf-8?B?SDh5bndGNHQ1VWRvbkVDUzNDZWFwa0xOM0I4WUhGd3NWQ3UrMWVSbWpJdWNU?=
 =?utf-8?B?UnkveW1XbUN2bEQ3NFZBUWpicnVsKzIzY0VlNStqY1EzVDlpRWhFQzF2K1Y2?=
 =?utf-8?B?U2Z4aGZoRE5Fb3NSdG10L2VLcmtRK0loNm9BN0V3ekNVSXlZM0dJbUc0VXhQ?=
 =?utf-8?B?TTVUckFZNS9pUVRaYllIN1JibXYyMzlTYllKQTN6c0pkUCtTTW9FSndxVkIv?=
 =?utf-8?B?MW1HRHp6ODJnWjFEeDgyRldiQ1p2TlpkR0YzNG82bzNZYXhsQllscVV1NWw3?=
 =?utf-8?B?NnBGUlBXNWdyZ2RoeldJdTBCSjNabk9mZGZwNFdtbXM3WGRFUEFlSjI0L1hE?=
 =?utf-8?B?aUhRYzMrMHRQRUxpMHJidW1ENkhiK0gwL2trVDVNOVNoc25YT1VkS0pHcHhp?=
 =?utf-8?B?Mk5zTElvTGtXL0RwWFVkNVIxQjJSU3dWeExTL1JkTEpNY0x5WU1UUEx4Zm10?=
 =?utf-8?B?ZnZ1Qm9xd1IrMUVWeGNFZUNiV0MxZXZrV1NFN0p4UFptZjRWV01KSEFmRGF4?=
 =?utf-8?B?NlBERFlVcFM1MEtidTEvTHVpazcwS245WDNFL3NKci9yVTZuc2MvTGtBR05l?=
 =?utf-8?B?QitIRFRpcWNhc0p3MHVKTzNBaWYvQVBFSjhMVmptajh1SGExOGMrcm9aUTVH?=
 =?utf-8?B?d1lnMG05SnNUTWRmNzduQU5nV3JDNHord2JLaHE0dXd0TEU0aUVJRDRUMVN3?=
 =?utf-8?B?dEtCbXR1THgyeFdhSEF2N1JqTmdKL0tyRXdtcGo1bXoxcjBFVTlPb2oyTWlD?=
 =?utf-8?B?dlNnSUdnV291MjcrR2tiNjZJV1ExWU53ZGdhTFJXNmxwTS9SUjhLMXN6RnBy?=
 =?utf-8?B?WW5leWNsNHdFMml1UkdrTUY3L25pUUVZb21lWDRPVGhWZzI4R29qOU5GMUdq?=
 =?utf-8?Q?MyfdQvafU1pNLaI6Ys?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47651509-769f-4875-d8d8-08de9a02831c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:47:51.3486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kp1vETnmRtc+wyed6f5sVWrLEKQG9eDU6gefYKSzTu1RbY9cQFd8g0PcsPFEtgB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFT
QU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBBcHJpbCAxNCwgMjAyNiA0OjQz
IFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FO
LlNIQU5NVUdBTUBhbWQuY29tPjsgRGFuIENhcnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+OyBY
dSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDog
W1BBVENIIHYyXSBkcm0vYW1kL3BtOiBGaXggbW9kZTIgcmVzZXQgQUNLIGhhbmRsaW5nIG9uIGFs
ZGViYXJhbiB2Mg0KDQphbGRlYmFyYW5fbW9kZTJfcmVzZXQoKSBzZW5kcyBhIG1vZGUyIHJlc2V0
IG1lc3NhZ2UgYW5kIHdhaXRzIGZvciBhbiBhY2tub3dsZWRnbWVudCBmcm9tIHRoZSBTTVUuDQoN
ClRoZSBjdXJyZW50IEFDSyBoYW5kbGluZyBpcyBpbmNvcnJlY3QuDQoNClRoZSB3YWl0IGxvb3Ag
cnVucyBvbmx5IHdoZW4gcmV0IGlzIC1FVElNRS4gQnV0IGFmdGVyIGEgc3VjY2Vzc2Z1bCBhc3lu
YyBzZW5kLCByZXQgaXMgMC4gQmVjYXVzZSBvZiB0aGlzLCB0aGUgbG9vcCBpcyBza2lwcGVkIGFu
ZCB0aGUgY29kZSBkb2VzIG5vdCB3YWl0IGZvciB0aGUgcmVzZXQgYWNrbm93bGVkZ21lbnQuDQoN
CkFsc28sIHRoZSBjb2RlIGNoZWNrcyBmb3IgcmV0ICE9IDEgYWZ0ZXIgY2FsbGluZyBzbXVfbXNn
X3dhaXRfcmVzcG9uc2UoKS4gSG93ZXZlciwgc211X21zZ193YWl0X3Jlc3BvbnNlKCkgcmV0dXJu
cw0KMCBvbiBzdWNjZXNzIGFuZCBuZWdhdGl2ZSBlcnJvciBjb2RlcyBvbiBmYWlsdXJlLiBTbyBj
aGVja2luZyBhZ2FpbnN0IDEgaXMgd3JvbmcuDQoNClJldHVybiAtRU9QTk9UU1VQUCB3aGVuIHRo
ZSBmaXJtd2FyZSBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgcmVzZXQgbWVzc2FnZS4NCg0KRml4IHRo
aXMgYnkgc2V0dGluZyByZXQgdG8gLUVUSU1FIGJlZm9yZSBlbnRlcmluZyB0aGUgd2FpdCBsb29w
LCBjaGVja2luZyBmb3IgcmV0ICE9IDAgYWZ0ZXIgZ2V0dGluZyB0aGUgU01VIHJlc3BvbnNlLCBh
bmQgcmV0dXJuaW5nIC1FT1BOT1RTVVBQIHdoZW4gdGhlIGZpcm13YXJlIGRvZXMgbm90IHN1cHBv
cnQgdGhlIG1lc3NhZ2UuDQoNCnYyOg0KLSBVcGRhdGUgQUNLIGNoZWNrIHRvIHVzZSByZXQgIT0g
MCBpbnN0ZWFkIG9mIHJldCAhPSAxLCBzaW5jZQ0KICBzbXVfbXNnX3dhaXRfcmVzcG9uc2UoKSBy
ZXR1cm5zIDAgb24gc3VjY2VzcyAoRmVpZmVpKQ0KLSBSZW1vdmUgdW5uZWNlc3NhcnkgaGFuZGxp
bmcgZm9yIHJldCA9PSAwDQoNCkZpeGVzOiBlNDI1NjlkMDJhY2IgKCJkcm0vYW1kL3BtOiBNb2Rp
ZnkgbW9kZTIgbXNnIHNlcXVlbmNlIG9uIGFsZGViYXJhbiIpDQpSZXBvcnRlZC1ieTogRGFuIENh
cnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQpDYzogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1k
LmNvbT4NCkNjOiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQpDYzogSGF3a2luZyBa
aGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNh
bi5zaGFubXVnYW1AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KaW5kZXggMjU5ZTVhMTNjMWJkLi5jYjdj
YmJjY2I4NzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
My9hbGRlYmFyYW5fcHB0LmMNCkBAIC0xODQ3LDYgKzE4NDcsNyBAQCBzdGF0aWMgaW50IGFsZGVi
YXJhbl9tb2RlMl9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAgICAgICAgICAgICAg
ICBhbWRncHVfZGV2aWNlX2xvYWRfcGNpX3N0YXRlKGFkZXYtPnBkZXYpOw0KDQogICAgICAgICAg
ICAgICAgZGV2X2RiZyhhZGV2LT5kZXYsICJ3YWl0IGZvciByZXNldCBhY2tcbiIpOw0KKyAgICAg
ICAgICAgICAgIHJldCA9IC1FVElNRTsNCiAgICAgICAgICAgICAgICB3aGlsZSAocmV0ID09IC1F
VElNRSAmJiB0aW1lb3V0KSAgew0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gc211X21z
Z193YWl0X3Jlc3BvbnNlKGN0bCwgMCk7DQogICAgICAgICAgICAgICAgICAgICAgICAvKiBXYWl0
IGEgYml0IG1vcmUgdGltZSBmb3IgZ2V0dGluZyBBQ0sgKi8gQEAgLTE4NTYsNyArMTg1Nyw3IEBA
IHN0YXRpYyBpbnQgYWxkZWJhcmFuX21vZGUyX3Jlc2V0KHN0cnVjdCBzbXVfY29udGV4dCAqc211
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCiAgICAgICAgICAg
ICAgICAgICAgICAgIH0NCg0KLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCAhPSAxKSB7
DQorICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0ICE9IDApIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gc2VuZCBtb2Rl
MiBtZXNzYWdlIFx0cGFyYW06IDB4JTA4eCByZXNwb25zZSAlI3hcbiIsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVVfUkVTRVRfTU9ERV8yLCByZXQp
Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCkBAIC0xODY2LDEw
ICsxODY3LDkgQEAgc3RhdGljIGludCBhbGRlYmFyYW5fbW9kZTJfcmVzZXQoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUpDQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgZGV2X2Vycihh
ZGV2LT5kZXYsICJzbXUgZncgMHgleCBkb2VzIG5vdCBzdXBwb3J0IE1TR19HZnhEZXZpY2VEcml2
ZXJSZXNldCBNU0dcbiIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtdS0+c21j
X2Z3X3ZlcnNpb24pOw0KKyAgICAgICAgICAgICAgIHJldCA9IC1FT1BOT1RTVVBQOw0KICAgICAg
ICB9DQoNCi0gICAgICAgaWYgKHJldCA9PSAxKQ0KLSAgICAgICAgICAgICAgIHJldCA9IDA7DQog
b3V0Og0KICAgICAgICBtdXRleF91bmxvY2soJmN0bC0+bG9jayk7DQoNCi0tDQoyLjM0LjENCg0K
