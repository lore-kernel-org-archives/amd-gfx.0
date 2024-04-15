Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EE3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 04:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618CB10FBB1;
	Mon, 15 Apr 2024 04:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEwVI+ni";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8FF10FBB1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 04:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Qt5HiZYyudHwoCLM4EoWYQ5hyoMqJEnPFHqxQlA39k8RZ+U18DKQV+XqX4uq9lrDorb/f5By/Fe/fuJju0zg8UvIWkY8wisdeDHHE4mDRJT/dZWTgimGNXShoHkA4fI/JPy20CZ+j38YpkhUlN8aMGTuZzQiMIWbBIe2T6jTwm2HBi/J95v3U9TRYn6dMb5FOb7nNWWaXVJJ5rUQ3fqxN15m453W/CL6ukaxdp1eAakdi0u1WeedBqoJbd0XQZ4ekWzgo4FaFrHcK7OgutRIr+Bw+dTz3F3PYqf70fIGyILUuNU4b42dh2uQtUJWF++lGckADFHizuCecgH6WeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFspP7sVksjEnP88PUSGuvSXx0Rfgi21T9/KCqSqd3Q=;
 b=LGX3G1cg67U8zj5cxeIDfuauIDqUtBvVEkpFqfZkfJxUsV+GILGk242KFAnknMquLMqeqIxoKMbQpi91BmoYAdrSj6yZ3Y1R1aWZE2swsB9rARBChc/Desp865JxJ6SlO079MD9lhKCoDHi3RM3J7D6gghvDrMgEAi2R7wUda5a3uC1cb4eTdGRlQ7I+Zymz7R7l1wO82YnFYeEosZT0/g/tw6eo0QLT8VvRkeduGspN4mcU9t62qXoDZpnnRLxGDVr4SaH6z0Zbsldi7VrEj73TriBDQZmQMLi4rpZ3Pobnix2Sygcrupm/SUUA9kkqIDNdXU/FhGaXZIvP1t5rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFspP7sVksjEnP88PUSGuvSXx0Rfgi21T9/KCqSqd3Q=;
 b=iEwVI+niogELVF1HPJcuAu+wGHhyet3hRj+J7wsfx9Cx9waanBFlKKVZ7IBRDPEkkIKlv+M6bHGO59OUAEcouOUHJ0trcP6Wbtr/iDIZqabJVFkSHevWZlX/ugRJca6G99BKkIWBzWQRNyiTIP54WwKrx8EtES8C3cOW37r4678=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 04:04:48 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 04:04:48 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH V2] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHajLdjDNpBIY55rUK/K5MtXMxCjbFkXOmAgARJnLA=
Date: Mon, 15 Apr 2024 04:04:47 +0000
Message-ID: <CH2PR12MB4215DEA1C70A9B18DCD376FCFC092@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
 <3110de1a-9379-4058-8a65-5d50b04fba92@gmail.com>
In-Reply-To: <3110de1a-9379-4058-8a65-5d50b04fba92@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=153d4956-c9f8-46fc-8dbc-e9154c8ca8e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-15T02:52:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB9172:EE_
x-ms-office365-filtering-correlation-id: 22c5508f-3968-41a3-299b-08dc5d013109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOWp4Awyoh3IS2xoJhK9XVoGnwFJVlCDV9aS2YMdYdhB6Hzs3R81WB+gOYL8sjHAOD7KfbUVZj6KYWOIeoNqW8QOLEMeHB3SC3Wjfen+QYDs+Vq8Bu5sPThLppoYlT0OAGPzrDm76JilmaKpnzo2C6fxMKH2yF4emeXJN4ml/QwQj2b4IYZUTIXJ5AAxBHK14ayyHpZjQelUtr7kazzdC24Booo8yEIM+uxrGhB7TM1EzFj2KzDhXV1qZLwFsW5MpjxeTefqVYNPZdztcPSnn8ZExGUJ/1fLR6OfzZIus1by4jA/QaTBonL6qDn5v6riNxx/8A9/fvS3ozNLvcIOA2wD+o3f/hRsWVT84FvEvj7k5yDNjrzJBK1aaVfe/ytxE2ZoNQpcqKyQ8wcKxV8Ax5y6Gw3Fh61GZtGBjY7H65vN5JPIhIwWOsZU5bKhQhR1c/xbyTDTrE2NO8ikbO36Ybdl0Ngwpo0wiNw9U9X1w2sm6X9ynQj4M62ZQHH12mg9RsdMSUrndX21MaCtHEjSMUzk2g797v4vPnrEQt5hPpzKFAbhBGcaxCdTEOWzkXBp17kkLdnTyIr9d+cI1u2PJXoSzbOOw/W6hSQqg4N01jIU+XBINmJNmNAGGjSQMie/EXvLrl03Yis9f2ehu9zsjRSjnwDM11G/6w04WAdpa/yxWYLBOjghbCumG6IQeqA4A2OjIQB1XToxPTL/1dUTapqfRr8Cn55K/YcbXRHy0Ok=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODR1K1p3WkVkUEJHUXNPYXV2eHhjMHVadTR4UFFjcVFrMHM4WXpoZGdZSFdq?=
 =?utf-8?B?a3UxRExaWlpzcEVpMTJORGlMc1hteFFaQW9CamZ4cnB4ODloaGxWVkt5RndN?=
 =?utf-8?B?aDBIek9oODhXNjZZS2hyeEtzNnpWYndpN3p4RmQvbGk2RlFGamhVMjVIUEdv?=
 =?utf-8?B?T1RsWFJLajNQVHhDRTJuWFJGc216aVNMck9vT3J4VG80bm1MMytCdEhYb25O?=
 =?utf-8?B?a05XNGtObGRCcGlPb3pOQUVtejIxT3dNbDlZSkxOR0lRa0tkLzNsNFBpSUNa?=
 =?utf-8?B?b2JDaE9IK1Vmd1RHeERQYUpMazZjd05rWTJyRys0MTNTZmNPVVRwUmk5ZkRh?=
 =?utf-8?B?UkZ3dEpKcjJBamR2b1drNWFPeiswc0pOcXdaZXNEU0x2UjJFT1dSNTlvUG1T?=
 =?utf-8?B?Sk1zRVdicHdLblh4ejhOcXBFR1NpNG1XOGZIVWdUOEM0VisrUHVZRU1LZ1Nm?=
 =?utf-8?B?TWdOaTROLzZvNnI1OVYzamZQd3ZFMkZCVTBIWFNpY3lPNGdyOEdBTDUyS2Zs?=
 =?utf-8?B?aHM2cHBrVmE3enU0OU5NU3FDOTNpN3M1aWhiY3pRVE1WdkR1dC9ibHZYdFhV?=
 =?utf-8?B?TzNsakc0dHo0R3JXajN5NzRwRmtRZXF4STJ1S2JGalc3S2E2NklQMURnUmVD?=
 =?utf-8?B?SytaU1Vjam9aOWZLNkFqbFE0UmhJNml3ZXp0SFROYXR3ZFc4TkNjMzlNUk02?=
 =?utf-8?B?bU14cVMzS2VwdE81V0l0c2JobkU5VE5Lb3BpM2VTVDVQSVBQdjd3Wlc3ZDRS?=
 =?utf-8?B?c0FlUkcwWVgrU2xkcE11ZWhwN0o4dE40c3E3OHhtVVh3UVJtQ1g0TW8zdW50?=
 =?utf-8?B?N1ZEa2MzNzNCd2pEcjF0dTNLaTloTWZDWWdCR3pjTDJZamJNdWhzSi9LUXJM?=
 =?utf-8?B?cFNReldQejNvRyt2bkxXVWJDdmNrRHQ4ejM2SXkvVUVGN09kVS9CYUlOSFdy?=
 =?utf-8?B?cmdkQm1Md0FsMjB4VTlTN0FsTUpTalBBS21HZ3U2QU9kUzhIRkVTU1Y3SzQ1?=
 =?utf-8?B?THdUOURrdU5icTducklmQnQ1YmdjZ3VCQnpiS2dWQWR5dDVvRlhGQmUrcWsz?=
 =?utf-8?B?WURWNVZIUWN2VGsvZk9oVGRVbUdzZ0VkR0F0aW1LN05iN1Znd1JqZ2xLYS9H?=
 =?utf-8?B?UUVXUE9xZFlKalB1UWp0V0d0YWlvR3pGVGo3S0hocGRhMWdjQnJkSkcrMUlF?=
 =?utf-8?B?QU1qakp2WGJnVjcvcVAvZlA4ZStFT3lod3FrNzJYZFkxVVJJNUpuOUdtTTBr?=
 =?utf-8?B?SmRkb0ZpQjNINGNyQWRaRGpLdzhpUnVKQ29pNWRGMTViQzFMTjg4N1hZRFgx?=
 =?utf-8?B?TTMxT2Z2QXVmMk9mNUJXc2Z6T3NZYzFaeDZlRCtwdzFlenkraUlScFh2ODFo?=
 =?utf-8?B?ZXdVcm5PWGZYcGZRTDdPRVpsbFcvdkx4dEhiVGgzaXA2WWlpWG1kRlVYVkFS?=
 =?utf-8?B?NWJIZU1CNjVhS2xTLytmZmI5YTVRYUJHdDJJL3A0VS9wRWdKZHp6Z1NHZ3Vz?=
 =?utf-8?B?bmMrcGRBU0M5QjIxZEFFNXlndUFSOFAvY0QrMUJtMmVUbXlndXp5c3l2c3NS?=
 =?utf-8?B?VHpENW4ya01DYTd2K1VzS2wrMCtPT3ZZdGtVQTFsaldQVmdGYTlxWWxLUHlQ?=
 =?utf-8?B?YVBmMHdmMTgva3JKNE92dWc0Wi92aHNtSElxQkxBQU4wUFhwanZnYmhpYmpQ?=
 =?utf-8?B?OWR3ejN2Rm5Eak5GbDVNUDRwcDFhU0pIdjc4UHYwYktpR3RSNm90a3diWjgx?=
 =?utf-8?B?b3Z4eU9sc0xiT2p4WFFnUm8rVFBYSUExbnVvQVZPZE9aTmNRQU1KbTZEL3cz?=
 =?utf-8?B?U3Z1bXpWQ1lSa3NHQ1MraHpsVEtOakl0bk5QZGRyOVliZHRJcTgxQ2xxT1Y2?=
 =?utf-8?B?UERPVDBBTERjbENWZStUK2dUMkdjZ2M0N1hUUVg0eGpoVUx2TGR6WHVQRVF1?=
 =?utf-8?B?dHNzUEJiT0NOd3o2bkNWbWQ2b3p5MDNDZC9HZmxEZVJMcC9aa1o4NW92VFJa?=
 =?utf-8?B?WWVHQTViRmdKblBjdE8rQk54VXRpWlN0ZW9qZVErQzAxOU41Rmh1Z3BjUnJn?=
 =?utf-8?B?NFlRQ1I5a1ZwU1grNzFqeHNMVENvSmFHSThNNDdnZWpiVHBkMmZGQmlxN3Qz?=
 =?utf-8?Q?LBIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c5508f-3968-41a3-299b-08dc5d013109
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 04:04:47.8339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DiqujDa96IKcLweXUCwpinmd4HO2u7rl/ydK2LsMdsI21y44gM0bV2S3IZj97xne0m1psyaXO859lcTWbCOrGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbjoNCiAgIElm
IGFuIGVjYyBlcnJvciBvY2N1cnMgYXQgYW4gYWRkcmVzcywgSFcgd2lsbCBnZW5lcmF0ZSBhbiBp
bnRlcnJ1cHQgdG8gU1cgdG8gcmV0aXJlIGFsbCBwYWdlcyBsb2NhdGVkIGluIHRoZSBzYW1lIHBo
eXNpY2FsIHJvdyBhcyB0aGUgZXJyb3IgYWRkcmVzcyBiYXNlZCBvbiB0aGUgcGh5c2ljYWwgY2hh
cmFjdGVyaXN0aWNzIG9mIHRoZSBtZW1vcnkgZGV2aWNlLg0KICAgVGhlcmVmb3JlLCBpZiBvdGhl
ciBwYWdlcyBsb2NhdGVkIG9uIHRoZSBzYW1lIHBoeXNpY2FsIHJvdyBhcyB0aGUgZXJyb3IgYWRk
cmVzcyBhbHNvIG9jY3VyIGVjYyBlcnJvcnMgbGF0ZXIsIEhXIHdpbGwgYWxzbyBnZW5lcmF0ZSBt
dWx0aXBsZSBpbnRlcnJ1cHRzIHRvIFNXIHRvIHJldGlyZSB0aGVzZSBzYW1lIHBhZ2VzIGFnYWlu
LCBzbyB0aGF0IGFtZGdwdV92cmFtX21ncl9yZXNlcnZlX3JhbmdlIHdpbGwgYmUgY2FsbGVkIG11
bHRpcGxlIHRpbWVzIHRvIHJlc2VydmUgdGhlIHNhbWUgcGFnZXMuDQoNCiAgICBJIHRoaW5rIGl0
J3MgbW9yZSBhcHByb3ByaWF0ZSB0byBkbyB0aGUgc3RhdHVzIGNoZWNrIGluc2lkZSB0aGUgZnVu
Y3Rpb24uIElmIHRoZSBmdW5jdGlvbiBlbnRyeSBpcyBub3QgY2hlY2tlZCwgcGVvcGxlIHdobyBh
cmUgbm90IGZhbWlsaWFyIHdpdGggdGhpcyBwYXJ0IG9mIHRoZSBjb2RlIGNhbiBlYXNpbHkgbWFr
ZSBtaXN0YWtlcyB3aGVuIGNhbGxpbmcgdGhlIGZ1bmN0aW9uLg0KDQoNCi0tLS0tLS0tLS0tLS0t
LS0tDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
Pg0KU2VudDogRnJpZGF5LCBBcHJpbCAxMiwgMjAyNCA1OjI0IFBNDQpUbzogQ2hhaSwgVGhvbWFz
IDxZaVBlbmcuQ2hhaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwg
Q2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFu
Zy5XYW5nQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIGRybS9hbWRncHU6IEZpeCBpbmNvcnJlY3QgcmV0dXJuIHZh
bHVlDQoNCkFtIDEyLjA0LjI0IHVtIDEwOjU1IHNjaHJpZWIgWWlQZW5nIENoYWk6DQo+IFtXaHld
DQo+ICAgIEFmdGVyIGNhbGxpbmcgYW1kZ3B1X3ZyYW1fbWdyX3Jlc2VydmVfcmFuZ2UgbXVsdGlw
bGUgdGltZXMgd2l0aCB0aGUNCj4gc2FtZSBhZGRyZXNzLCBjYWxsaW5nIGFtZGdwdV92cmFtX21n
cl9xdWVyeV9wYWdlX3N0YXR1cyB3aWxsIGFsd2F5cw0KPiByZXR1cm4gLUVCVVNZLg0KPiAgICBG
cm9tIHRoZSBzZWNvbmQgY2FsbCB0byBhbWRncHVfdnJhbV9tZ3JfcmVzZXJ2ZV9yYW5nZSwgdGhl
IHNhbWUNCj4gYWRkcmVzcyB3aWxsIGJlIGFkZGVkIHRvIHRoZSByZXNlcnZhdGlvbnNfcGVuZGlu
ZyBsaXN0IGFnYWluIGFuZCBpcw0KPiBuZXZlciBtb3ZlZCB0byB0aGUgcmVzZXJ2ZWRfcGFnZXMg
bGlzdCBiZWNhdXNlIHRoZSBhZGRyZXNzIGhhZCBiZWVuDQo+IHJlc2VydmVkLg0KDQpXZWxsIGp1
c3QgdG8gbWFrZSBpdCBjbGVhciB0aGF0IGFwcHJvYWNoIGlzIGEgTkFLIHVudGlsIG15IGNvbmNl
cm5zIGFyZSBzb2x2ZWQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gW0hvd10NCj4g
ICAgRmlyc3QgYWRkIHRoZSBhZGRyZXNzIHN0YXR1cyBjaGVjayBiZWZvcmUgY2FsbGluZw0KPiBh
bWRncHVfdnJhbV9tZ3JfZG9fcmVzZXJ2ZSwgaWYgdGhlIGFkZHJlc3MgaXMgYWxyZWFkeSByZXNl
cnZlZCwgZG8NCj4gbm90aGluZzsgSWYgdGhlIGFkZHJlc3MgaXMgYWxyZWFkeSBpbiB0aGUgcmVz
ZXJ2YXRpb25zX3BlbmRpbmcgbGlzdCwNCj4gZGlyZWN0bHkgcmVzZXJ2ZSBtZW1vcnk7IG9ubHkg
YWRkIG5ldyBub2RlcyBmb3IgdGhlIGFkZHJlc3NlcyB0aGF0IGFyZQ0KPiBub3QgaW4gdGhlIHJl
c2VydmVkX3BhZ2VzIGxpc3QgYW5kIHJlc2VydmF0aW9uc19wZW5kaW5nIGxpc3QuDQo+DQo+IFYy
Og0KPiAgIEF2b2lkIHJlcGVhdGVkIGxvY2tpbmcvdW5sb2NraW5nLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBZaVBlbmcgQ2hhaSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgfCAyNSArKysrKysrKysrKysr
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZyYW1fbWdyLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9t
Z3IuYw0KPiBpbmRleCAxZTM2YzQyOGQyNTQuLmE2MzZkM2Y2NTBiMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4gQEAgLTMxNyw3ICsz
MTcsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdnJhbV9tZ3JfZG9fcmVzZXJ2ZShzdHJ1Y3QNCj4g
dHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbikNCj4NCj4gICAgICAgICAgICAgICBkZXZfZGJnKGFk
ZXYtPmRldiwgIlJlc2VydmF0aW9uIDB4JWxseCAtICVsbGQsIFN1Y2NlZWRlZFxuIiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgIHJzdi0+c3RhcnQsIHJzdi0+c2l6ZSk7DQo+IC0NCj4gICAgICAg
ICAgICAgICB2aXNfdXNhZ2UgPSBhbWRncHVfdnJhbV9tZ3JfdmlzX3NpemUoYWRldiwgYmxvY2sp
Ow0KPiAgICAgICAgICAgICAgIGF0b21pYzY0X2FkZCh2aXNfdXNhZ2UsICZtZ3ItPnZpc191c2Fn
ZSk7DQo+ICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZtYW4tPmJkZXYtPmxydV9sb2NrKTsNCj4g
QEAgLTM0MCwxOSArMzM5LDI3IEBAIGludCBhbWRncHVfdnJhbV9tZ3JfcmVzZXJ2ZV9yYW5nZShz
dHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdyICptZ3IsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IHNpemUpDQo+ICAgew0KPiAgICAgICBzdHJ1
Y3QgYW1kZ3B1X3ZyYW1fcmVzZXJ2YXRpb24gKnJzdjsNCj4gKyAgICAgaW50IHJldCA9IDA7DQo+
DQo+IC0gICAgIHJzdiA9IGt6YWxsb2Moc2l6ZW9mKCpyc3YpLCBHRlBfS0VSTkVMKTsNCj4gLSAg
ICAgaWYgKCFyc3YpDQo+IC0gICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsgICAgIHJl
dCA9IGFtZGdwdV92cmFtX21ncl9xdWVyeV9wYWdlX3N0YXR1cyhtZ3IsIHN0YXJ0KTsNCj4gKyAg
ICAgaWYgKCFyZXQpDQo+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+DQo+IC0gICAgIElOSVRf
TElTVF9IRUFEKCZyc3YtPmFsbG9jYXRlZCk7DQo+IC0gICAgIElOSVRfTElTVF9IRUFEKCZyc3Yt
PmJsb2Nrcyk7DQo+ICsgICAgIGlmIChyZXQgPT0gLUVOT0VOVCkgew0KPiArICAgICAgICAgICAg
IHJzdiA9IGt6YWxsb2Moc2l6ZW9mKCpyc3YpLCBHRlBfS0VSTkVMKTsNCj4gKyAgICAgICAgICAg
ICBpZiAoIXJzdikNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPg0K
PiAtICAgICByc3YtPnN0YXJ0ID0gc3RhcnQ7DQo+IC0gICAgIHJzdi0+c2l6ZSA9IHNpemU7DQo+
ICsgICAgICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJnJzdi0+YWxsb2NhdGVkKTsNCj4gKyAgICAg
ICAgICAgICBJTklUX0xJU1RfSEVBRCgmcnN2LT5ibG9ja3MpOw0KPiArDQo+ICsgICAgICAgICAg
ICAgcnN2LT5zdGFydCA9IHN0YXJ0Ow0KPiArICAgICAgICAgICAgIHJzdi0+c2l6ZSA9IHNpemU7
DQo+ICsgICAgIH0NCj4NCj4gICAgICAgbXV0ZXhfbG9jaygmbWdyLT5sb2NrKTsNCj4gLSAgICAg
bGlzdF9hZGRfdGFpbCgmcnN2LT5ibG9ja3MsICZtZ3ItPnJlc2VydmF0aW9uc19wZW5kaW5nKTsN
Cj4gKyAgICAgaWYgKHJldCA9PSAtRU5PRU5UKQ0KPiArICAgICAgICAgICAgIGxpc3RfYWRkX3Rh
aWwoJnJzdi0+YmxvY2tzLCAmbWdyLT5yZXNlcnZhdGlvbnNfcGVuZGluZyk7DQo+ICAgICAgIGFt
ZGdwdV92cmFtX21ncl9kb19yZXNlcnZlKCZtZ3ItPm1hbmFnZXIpOw0KPiAgICAgICBtdXRleF91
bmxvY2soJm1nci0+bG9jayk7DQo+DQoNCg==
