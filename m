Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B6DC6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 06:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17214112541;
	Wed,  3 Apr 2024 06:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAQNRw8A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F4E112542
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 06:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsW7/FhDH1j+ZPZlRXNS1jlLXj56i5yBGVGmMSlzKtV8nSfiaw3PsFlBmlNUgsNqQaZVsuP+gLGJV0D8Lqtl671TD4kNKCo84MbTVQ+iaOm279tuPKJ4LVK5UwaDkMLA99JXowH1XcQtOdcsnfcBGhbjBcYDuWa3nPKyLuGng5xRkKtEL9eL0t8WRnzUY0r9cNc7zcg1nNp1viPGTElO8Jo/JrDOtzlk7mNdfO6B9vGHlyw7n2ZyJ0C/mtnaHYLf8sZJN1LvM+x8E4fRsYV0JMScWHjLXRGZAMKOtuQSbZSZDBEZmawT4kyk78IMjSi247P0OeiHyfhcVRGZ/R+E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0oNvcwHyJU446r6HAmCuzb0R+OyCkk/X7oWacS2maI=;
 b=V7Ael8Q6ogvpoCimIC+nUracFrZdCGzeDn4hw1iCAdA+8+fsIU2ctwhQ5Bg4gIvLib+UGymvSNxcZSw3SkS55cSJ+4KlQRzPmAi7UdMYk2AEq2TVQCb3ZyK1c7FQTWDa7JsBHfofJhbcXrU7YN4homosNmfSXrBul7M46TB03rCfZZFmpPLwqEIg8vjZFq6ZY911V8CHcAHr0p0Lg2rwSBDm8VNCMOzgGy0R17d65HRhLu7hD8tPfdaugbeRuTazuvbfG1LtV5HGwbtqRBux+iwTJWZnRpy8bvtju0AHEYlb5eH1h6CgQ9Qt3uhdyiD/2RluQToJcESn/0efTDyDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0oNvcwHyJU446r6HAmCuzb0R+OyCkk/X7oWacS2maI=;
 b=VAQNRw8AHn+tBAZAKL5tYc0br7dC7AB/bCK0hERRA4B+k4yRnzOwJVgBcrdKgqmOcxlppjDY9MW+lyTF2FtRtwbUFp3bNSoD2MHfT9aW5uZYz5ftpl9ahY50J/t0RDIhBqKAq/3S+x7ReyjFZejvLidNbM3tv8OIL7s1tlQEc4c=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 06:51:19 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 06:51:19 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Sharma, Shashank" <Shashank.Sharma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add post reset IP callback
Thread-Topic: [PATCH] drm/amdgpu: add post reset IP callback
Thread-Index: AQHagMoRh8yAeQygPUK7fOTrq+2pC7FVBIIAgADccUA=
Date: Wed, 3 Apr 2024 06:51:19 +0000
Message-ID: <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
 <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
In-Reply-To: <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b81d2323-ceb5-4c18-8dd9-2f6636adba25;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T02:47:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SA3PR12MB9227:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDJudxtNFKtEAlq/FyaP2a1Tw7i24V/bi/nSJSqwoEBsolb+3rxM3OZ0KAUY6ZfTKsArEXKjTjQFWcYbviuOJYs020WMO5DHKXP2JIn/I5w3DOZcctDDg3+be+eTRtnkNO8id26lvQ5ul4ilxDnM3815QMIgwMw2lsfXDCuXY2utdZmIUWjpjxOVAdeW/dbSNa5Rc0ejgHjH5tDkkJqpq3Jv0+jKWQAkpuyqUi6BxILIxCtcQGQcBPX7uK0sGB4+Wr8zcb6B8ljo86K9em5JgaXQZ+VYQoQHnx5t+TlTf0/bWfwp+UK+wlOYWDSUyRexnoybY8oCC5zceSQOKAjkP3ag5Hb1txus9lCR5tA38Wp8chIgRakDnTIybNcmCEevQfrGhONZZ+U1Wro7YWsfrS2FJpMqjYlxtR6Rn0xNt+zNQ4TDadpw+23wGg2Xp3j/SOzjFDWpkFMHpmch/hSONpiI+r3Brqv6MrtZnMwPd9FBBiJunqpJmr8HK55XDzkh5AZeZpXRQXVEDv2Qkb9uFN5xursTkXtWt80cJHI9AzjGkFJOPoM8PAJEcJ3Bn/uM8iDF9Bcnh5E8dXBs064gQgKBQ3BKMpTOm1ekbKp0B+IcJgO6ZVQK+GWNMIaZbLFHCgbN4jvZ0tvfh8L/7ni1X1Dy/wFtLemBMWoXAvuBWP8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnloWkcrWGhnOGpvYTFMalovRHNZUlIyQUtHZTJwVDEzS3NXeER4clRzOUdQ?=
 =?utf-8?B?ek1pRThiSGFRNGJzdnpTMGtscEJPdENLcmpQcnhpdmFTNDN0b3lpRlJIYlhm?=
 =?utf-8?B?aHMyRW9JYk1ZeE5BQk5rQ0lKZkdwZVpBY0J2ajRvUW1PeUg0MDVLSmg4aTcr?=
 =?utf-8?B?ajZtS3pBSVlOR01Qak5LVGRWLzNNNGEwZnM0N2hnRjMxNFA3UnVWRXU5VWJU?=
 =?utf-8?B?VHpDaEhzbjZGcHJtSFJ1RStONFJFUm1HR215NHZOMEt6MFlENXNFZVJ1Qm93?=
 =?utf-8?B?Skl0VlBIb1RZRnNWUGVGaGRXdUdveFFodGxhV29QT3EwU1E2azlSMkIyeEF0?=
 =?utf-8?B?ckNSZTJzNUtDUTYvNnRiNlRIbGlLMGRDYnExMEpXYVBDMmZYN29UNmlFZGNE?=
 =?utf-8?B?ZzRaVytKLzBxLzRTK1Z5dFgyMjduQXByYVllWlRxU3ZuWU5Lc1JYaUI2OTBO?=
 =?utf-8?B?VkpOOWtvMU1qY3plZ3d4YTlGMzArdGVLKzZBZ1ZsbEZtNlV0VjV1ZmRjaTVs?=
 =?utf-8?B?MFF1dFByUW9LZCsyMVg1b3RnL040ejA5VmRlT1NxSGtjcUZFZU4vdTZDSDZ5?=
 =?utf-8?B?WWM1UGNUSWJqUWNqRDU3VXgzTy9Yc3NpN2RwNlJxelNNcVJOV1ZTeDJNbzZ1?=
 =?utf-8?B?aW1KT2RjTVZDYUJLMXpYYStySFVidXJtTUxKLzhNYkdXdytWUk5yT1ZPU3Uy?=
 =?utf-8?B?MGhNb2RMOUo2QnVVd1lqc1I2YUluVFJncG42bisrdk8xcG5oSkZvRnYyeEIy?=
 =?utf-8?B?SzFadU9HWlpOd09FQU44ekVDSVJWbGtWWW8zUDZXVktTK3Z5U1YvZ1RBS1Ax?=
 =?utf-8?B?OWpGRHRNajlWYklTT1Y5TWRoMjZjdzNqVzhvLzdvdVVNQWd6WHN2TGZhR09w?=
 =?utf-8?B?QjUxZkJKdGg4a3MzTzFvUFdBVkw5UGpjZDAvVmMyUWVzMVJCVXFxTWdFaW1E?=
 =?utf-8?B?djRUN1NwTGVtdEplcXpOWTVrenk1dFFYU004a0pGTzhGVzQ0WS9oNnJGVjk4?=
 =?utf-8?B?b29GVG5CaGM1b2dSWVNkY09JaWRNeStiVFBuVStlcXQ5ZVhzcytiQUQ2dVgw?=
 =?utf-8?B?NzNMT3p6ZUhhWXQxcnNzZ1IrRkhSeFY2YmtTdzhpNnNsV1JOa3krblFKeXhJ?=
 =?utf-8?B?Z1RzOUQ3VVU0emREN3NYbHVMN0FhdU1rd2E2c1JNb0lmcC8xdDNNb0lBQXJs?=
 =?utf-8?B?V2w5NmlYVEY5dHloME5nanpxZ3hYeE9HRnRtWE1Fb24wbGVnZXR0cm5GNk5G?=
 =?utf-8?B?elZWWVk1OWdWT2lLcC9kVENhcHdEZStzMzh5ZW5Mc0pBcnYzayt2YzRNdnl4?=
 =?utf-8?B?K0NFVzNlajJERlVWOS9hYmF2RG8rMFkycFJRQldLejlvK0lvODFaZVNTRUJr?=
 =?utf-8?B?Yi9SQ1FyR1pjbW5JK0FnYUUxWmRHOXYzSnNwckg3Y2t6cktWWXJBSTZEM2pu?=
 =?utf-8?B?RmVzby81dzZhMHAxcUEvWEFNek53Z3ZvcVRRUlduTmQ3cmtUMXBRWDlhcHBP?=
 =?utf-8?B?ZExDVitYd0I3U2MyVGNZc29sZEd6WUZERE02NU90VjJ2cWJzYTBvNG1kOTV3?=
 =?utf-8?B?cmovVHRvb09wZlZOb3dxUDA1eGFpeXRRdkp4Q0NaUkM4UVZ0Qmo5aWovdTFx?=
 =?utf-8?B?K1BxWG1GbVVqN0RqWFB1bzVOR0o4NVlaOFhRcHI5cmZPM3pMdXUxTDFLTVRv?=
 =?utf-8?B?ajByZ05jTVpodXpoNlNvVEw1a2xnRXhVVHhTL3Vmd25jNFp3aHRpcWFlNDF0?=
 =?utf-8?B?Mkh5N1pWN0NrbXpmR0VPQ3ZBWXZFUEJpUzQ1SEFXTk1WZmtqSzBJOXlML1lP?=
 =?utf-8?B?RlZpSW53SzZ3QkZCRXRpNXNmMTgzSGU2UHVYSEZQL2JPV29jTTIwVGNBa3J0?=
 =?utf-8?B?bWxRNUtPK05XMzNmNkZNRFdPTHlGTGlJcVFEUTZLZWlwc29kU2pFeEVnZDI1?=
 =?utf-8?B?VGwrbHB1QTA3cXo4b3lnN1lkVlNCVHM2ZzVONlg3cjRDa1FxYkNnV2VNSjBy?=
 =?utf-8?B?MTA5UW1JRk9ZbGg0RElEMEhCMm1zdEhLdVNHQ2dmakFldlhzclVpUElid3pG?=
 =?utf-8?B?aHRCRXBIWDluVktZTDVrcGFSS2ZJQkhsVkcxTjBUcWRvbmY4TzBKdVVSZWh5?=
 =?utf-8?Q?FdfM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d35cc6-3ee2-436e-d822-08dc53aa778d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 06:51:19.4566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HG0zLfl4neiENzztdaCUCyqxbMfH1GtoA6FSRO+D6SDcpKX2WC8bB9RNf7xpgRRJ7KNMwU0il7uOQ5TfeudEcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5A
Z21haWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIsIDIwMjQgOTozOCBQTQ0KPlRvOiBZ
dSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj5DYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj48Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgU2hhcm1hLCBTaGFz
aGFuaw0KPjxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgcG9zdCByZXNldCBJUCBjYWxsYmFjaw0KPg0KPkFtIDI4LjAzLjI0IHVt
IDA1OjQwIHNjaHJpZWIgTGFuZyBZdToNCj4+IFRoZXJlIGFyZSB1c2UgY2FzZXMgd2hpY2ggbmVl
ZCBmdWxsIEdQVSBmdW5jdGlvbmFsaXR5IChlLmcuLCBWTQ0KPj4gdXBkYXRlLCBUTEIgaW5hdmls
ZGF0ZSkgd2hlbiBkb2luZyBhIEdQVSByZXNldC4NCj4+DQo+PiBFc3BlY2lhbGx5LCB0aGUgbWVz
L3Vtc2NoIHNlbGYgdGVzdHMgd2hpY2ggaGVscCB2YWxpZGF0ZSB0aGUgaHcgc3RhdGUNCj4+IGFm
dGVyIGh3IGluaXQgbGlrZSByaW5nL2liIHRlc3RzLg0KPg0KPkkgbm90ZWQgdGhhdCBiZWZvcmUg
YnV0IGp1c3QgdG8gcmVwZWF0IGl0IG9uY2UgbW9yZTogV2UgY2FuJ3QgZG8gYW55IE1FUyBvcg0K
PlVNU0NIIHZhbGlkYXRpb24gd2hpbGUgZG9pbmcgYSBHUFUgcmVzZXQhDQoNClllcywgd2UgY2Fu
IGp1c3QgZWFzaWx5IGRpc2FibGUgaXQgaWYgaXQgZG9lc24ndCB3b3JrIHdlbGwuDQpCdXQgaXQg
ZG9lc24ndCB0YWtlIHRvbyBtdWNoIGVmZm9ydCB0byBtYWtlIGl0IHdvcmsuDQpJdCBjYW4gZXhw
b3NlIGlzc3VlcyBhcyBzb29uIGFzIHBvc3NpYmxlIGFuZCBpcyB1c2VmdWwgZm9yIGRlYnVnZ2lu
ZyBwdXJwb3NlLg0KDQo+VGhlIHJpbmcgYW5kIElCIHRlc3RzIHVzZSBzb21lIHByZS1hbGxvY2F0
ZWQgbWVtb3J5IHdlIHB1dCBhc2lkZSBmb3IgdGhlDQo+dGFzayBkdXJpbmcgZHJpdmVyIGxvYWQg
YW5kIHNvIGNhbiBleGVjdXRlIGR1cmluZyBHUFUgcmVzZXQgYXMgd2VsbC4NCg0KSWYgdXNlciBz
cGFjZSBjYW4gY3JlYXRlIGEgVk0gYW5kIGFsbG9jYXRlIG1lbW9yeSBkdXJpbmcgR1BVIHJlc2V0
LA0KaXQgbWFrZXMgbm8gc2Vuc2UgdG8gcHJldmVudCBrZXJuZWwgc3BhY2UgZnJvbSBkb2luZyB0
aGF0Lg0KDQo+QnV0IGZvciB0aGUgTUVTL1VNU0NIIHdlIG5lZWQgYSBmdWxsIGJsb3duIGVudmly
b25tZW50IHdpdGggVk0gYW5kDQo+c3VibWlzc2lvbiBpbmZyYXN0cnVjdHVyZSBhbmQgc2V0dGlu
ZyB0aGF0IHVwIGlzbid0IHBvc3NpYmxlIGhlcmUuDQoNCkF0IGxlYXN0IGZvciBVTVNDSCB0ZXN0
LCBpdCBvbmx5IHVzZXMgVk0gbWFwcGluZyBmdW5jdGlvbmFsaXR5DQooaWYgd2UgY2FuIGNyZWF0
ZSBhIFZNIHdpdGggY3B1IHVwZGF0ZSBtb2RlLCB0aGF0J3MgZW5vdWdoKSwNCml0IGRvZXNuJ3Qg
dXNlIG90aGVyIHN1Ym1pc3Npb24gZnVuY3Rpb25hbGl0eS4NCkl0IGlzIGFjdHVhbGx5IGEgY29t
cHV0ZSBjb250ZXh0Lg0KDQoNClJlZ2FyZHMsDQpMYW5nDQoNCj5BZGRpbmcgU2hhc2hhbmsgYXMg
d2VsbCwgYnV0IEkgdGhpbmsgd2Ugc2hvdWxkIHByb2JhYmx5IGp1c3QgY29tcGxldGVseQ0KPnJl
bW92ZSB0aG9zZSBmcm9tIHRoZSBrZXJuZWwuDQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+
DQo+Pg0KPj4gQWRkIGEgcG9zdCByZXNldCBJUCBjYWxsYmFjayB0byBoYW5kbGUgc3VjaCB1c2Ug
Y2FzZXMgd2hpY2ggd2lsbCBiZQ0KPj4gZXhlY3V0ZWQgYWZ0ZXIgR1BVIHJlc2V0IHN1Y2NlZWRz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1kLmNvbT4NCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyNA0K
PisrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaCAgIHwgIDMgKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQo+PiBpbmRleCAxMmRjNzFhNmI1ZGIuLmZlZWFiOTM5N2FhYiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiBAQCAtNTU1Niw2
ICs1NTU2LDI3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9oZWFsdGhfY2hlY2soc3RydWN0
DQo+bGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUpDQo+PiAgICAgIHJldHVybiByZXQ7DQo+
PiAgIH0NCj4+DQo+PiArc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX3Bvc3RfcmVzZXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4+ICsgICAgdWludDMyX3QgaTsNCj4+ICsgICAg
aW50IHI7DQo+PiArDQo+PiArICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tz
OyBpKyspIHsNCj4+ICsgICAgICAgICAgICBpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMu
dmFsaWQgfHwNCj4+ICsgICAgICAgICAgICAgICAgIWFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9u
LT5mdW5jcy0+cG9zdF9yZXNldCkNCj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
Pj4gKw0KPj4gKyAgICAgICAgICAgIHIgPSBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVu
Y3MtPnBvc3RfcmVzZXQoYWRldik7DQo+PiArICAgICAgICAgICAgaWYgKHIpIHsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgIERSTV9FUlJPUigicG9zdCByZXNldCBvZiBJUCBibG9jayA8JXM+DQo+
ZmFpbGVkICVkXG4iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmlw
X2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+bmFtZSwgcik7DQo+PiArICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcjsNCj4+ICsgICAgICAgICAgICB9DQo+PiArICAgIH0NCj4+ICsNCj4+ICsg
ICAgcmV0dXJuIHI7DQo+PiArfQ0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogYW1kZ3B1X2Rldmlj
ZV9ncHVfcmVjb3ZlciAtIHJlc2V0IHRoZSBhc2ljIGFuZCByZWNvdmVyIHNjaGVkdWxlcg0KPj4g
ICAgKg0KPj4gQEAgLTU4MDUsNiArNTgyNiw5IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNv
dmVyKHN0cnVjdA0KPmFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgICAgICAgICAgICAgYW1kZ3B1
X3B1dF94Z21pX2hpdmUoaGl2ZSk7DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIGlmICghciAmJiAh
am9iX3NpZ25hbGVkKQ0KPj4gKyAgICAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX2lwX3Bvc3Rf
cmVzZXQoYWRldik7DQo+PiArDQo+PiAgICAgIGlmIChyKQ0KPj4gICAgICAgICAgICAgIGRldl9p
bmZvKGFkZXYtPmRldiwgIkdQVSByZXNldCBlbmQgd2l0aCByZXQgPSAlZFxuIiwgcik7DQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgN
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaA0KPj4gaW5kZXgg
YjBhNjI1NmU4OWY0Li4zM2NlMzBhOGUzYWIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvYW1kX3NoYXJlZC5oDQo+PiBAQCAtMjg3LDYgKzI4Nyw3IEBAIGVudW0gYW1kX2Rw
bV9mb3JjZWRfbGV2ZWw7DQo+PiAgICAqIEBwcmVfc29mdF9yZXNldDogcHJlIHNvZnQgcmVzZXQg
dGhlIElQIGJsb2NrDQo+PiAgICAqIEBzb2Z0X3Jlc2V0OiBzb2Z0IHJlc2V0IHRoZSBJUCBibG9j
aw0KPj4gICAgKiBAcG9zdF9zb2Z0X3Jlc2V0OiBwb3N0IHNvZnQgcmVzZXQgdGhlIElQIGJsb2Nr
DQo+PiArICogQHBvc3RfcmVzZXQ6IGhhbmRsZXMgSVAgc3BlY2lmaWMgcG9zdCByZXNldCBzdHVm
ZihlLmcuLCBzZWxmIHRlc3QpDQo+PiAgICAqIEBzZXRfY2xvY2tnYXRpbmdfc3RhdGU6IGVuYWJs
ZS9kaXNhYmxlIGNnIGZvciB0aGUgSVAgYmxvY2sNCj4+ICAgICogQHNldF9wb3dlcmdhdGluZ19z
dGF0ZTogZW5hYmxlL2Rpc2FibGUgcGcgZm9yIHRoZSBJUCBibG9jaw0KPj4gICAgKiBAZ2V0X2Ns
b2NrZ2F0aW5nX3N0YXRlOiBnZXQgY3VycmVudCBjbG9ja2dhdGluZyBzdGF0dXMgQEAgLTMxNiwx
MQ0KPj4gKzMxNywxMyBAQCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHsNCj4+ICAgICAgaW50ICgqcHJl
X3NvZnRfcmVzZXQpKHZvaWQgKmhhbmRsZSk7DQo+PiAgICAgIGludCAoKnNvZnRfcmVzZXQpKHZv
aWQgKmhhbmRsZSk7DQo+PiAgICAgIGludCAoKnBvc3Rfc29mdF9yZXNldCkodm9pZCAqaGFuZGxl
KTsNCj4+ICsgICAgaW50ICgqcG9zdF9yZXNldCkodm9pZCAqaGFuZGxlKTsNCj4+ICAgICAgaW50
ICgqc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKSh2b2lkICpoYW5kbGUsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW51bSBhbWRfY2xvY2tnYXRpbmdfc3RhdGUgc3RhdGUpOw0K
Pj4gICAgICBpbnQgKCpzZXRfcG93ZXJnYXRpbmdfc3RhdGUpKHZvaWQgKmhhbmRsZSwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0
ZSBzdGF0ZSk7DQo+PiAgICAgIHZvaWQgKCpnZXRfY2xvY2tnYXRpbmdfc3RhdGUpKHZvaWQgKmhh
bmRsZSwgdTY0ICpmbGFncyk7DQo+PiArDQo+PiAgIH07DQo+Pg0KPj4NCg0K
