Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBFCC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 18:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E89A11377B;
	Wed, 17 Apr 2024 18:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQXcS/yt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB2C11377B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 18:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHfHEBBqGWFDe8tDRy4hE4+5jIj4FT05wH7oLskaT1fQlZRK3xCaonIGnACOWt2JVICuLOdGowLsEf0vNNrU/26RqqA3TdooPoxr/50NTHp1vxvUO/HjHv37CLolMibFsJ/k5mDZO5kD5+1un+AcOJBkeGy71mZqKp+uL8UO0PKZqG9jP5B+61f32hQz9HCeKJ13SKPj/HotJrZVoKqOqrH28Gew3Y0YrzclhcRTw57GEGjN5YA851LmTqbfobxxtGBjgvwlLqEZUUWo2W4cG21B2xE2CEEAahdPFXb0unA5cibRvT+iTBCvb/v012ug2eKN0YGCBm/yuPcwpk0BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtJU4pHwoITpvlGHrwvdoiFdmystqY96r0sQTflJgOE=;
 b=eGemrbZO4qT6OFBcs3Mtz/qW9YzUktOssvCwD3lwawk5rOYaAW5WUkjxVYTfmOFWsPBogVHxxfVckNhXNCARJ66CFx/SDJpX8Eln5glPz8NzZoHaqNOGBPXtQVc0Vgd1aDVmxJMNVzh5pr3KMCLdOENnKV8nUwNfOnPtZRwLTN5GP1d0Qh2+ckpSgVChzcBXixHAAy4hNpM/kNcjnM8X3gkp4Fqan0irzuxUTPhosnexbAIxQUW7cVP3KwQEC5cbLxr3N8Gwmcbsthm1dUkZ5H7U/uhTmetCNu/2xHeiQ8h/z0+4SQh364awm6EgcJzIZyF+3iy58Ap3u9tIr3fRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtJU4pHwoITpvlGHrwvdoiFdmystqY96r0sQTflJgOE=;
 b=kQXcS/ytD8rQDcRYfFugLq+0al/Tg0dAVb6HdAK2rKo/Vrk4dT2JhUrALS41/fgtxAOpg4Fp2qhDQSMJP1e7WIRbj2orfRLApZsDo5oiw1wtJaTk35gIuBlLAXyRYQRohk2s7TO+bUXHYOFUNtnYjb5/a+xvbCE7EOu+M4RUUyM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 18:52:14 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 18:52:14 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>, Leo Liu <leo.liiu@amd.com>, "Liu, Jenny
 (Jing)" <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
Thread-Topic: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
Thread-Index: AQHakLrW26cfjP3uuU+ZieQaRutjYLFsaeeAgABfmmA=
Date: Wed, 17 Apr 2024 18:52:13 +0000
Message-ID: <CH0PR12MB53727853A2173DA703452EF5F40F2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
 <20240417113025.2886905-3-horace.chen@amd.com>
 <8997494d-4b4e-4522-acbe-af44a8320c3d@amd.com>
In-Reply-To: <8997494d-4b4e-4522-acbe-af44a8320c3d@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4007f108-04da-48c9-88df-51eaede0a4b2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T18:31:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB7881:EE_
x-ms-office365-filtering-correlation-id: f2e538fe-9f2c-470e-1c50-08dc5f0f7f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6GnICLV52ya5LwOg+5cJ5CfdRJ5yyziMafL+no4IxBdiEYzsvQrqrmMyZHnMMjcIPpMK0ejraYapTNW2zaCewXCCkvSN8O3LhzsfyNUe0RRmqzEUgz7+AUxVVfTw9bdLYTsV4GdV//5a92TQMH4V/xxb8csDUjeGAoivIEkvdWaG29gUivxkJW6+2lFhGvxPFVV+1KMmRaqo8EnXx6t3kHJ7CanCmHEvtUmsjQGYcTVVoLzvlClXzXnVHDj2M4D0rtEPZHjTkahlaBQNDZ+atBXXHgyI9zMJLj/3WrqCJTWybGw4QHJBF8tYXtzsD4WPofvKQ6NO+sdYqthqxDn2LrDdb5FXuDfCaHUsLRw9r1UvlzEZ3mej5IEHIk6PD5TEUETOwtw8LueUKSconIK92XY/W0dY5R9Zs3/nxnlpM/XujgzwDZbc+XSsOlBREuFIHmSAMWGW3aWIclxksfq1KD9wsNfQjH7hSEnbUamwoebCmGsisMUUwhPEy2haji99gZ1pcStUSjrm1Mx4BG4nShFRjFeewoO6jk8AYheDEmeoOQaQUyKHANh8M6pTSu55M2iZRr7uXa864nxCRQaClwocKBEpJ/Xu0YjK9jMglq0oPFt7qi+X7W6YUQaRKJdbTKbZ/OSJvl7IyZX1dxItH0SbD9EtbH2LC2gC73x2zWGSigSX+wkEhk7KH50mN44OpIrwq8BZIt0clQtLUKZRb7fv1ZqEkY/Kr57yGU5wFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1YxcHBuM2Flam5ZL29rOThHOWtuKzVLMTZxRUxXUEFoSWtwc3Jlcm9pRnk0?=
 =?utf-8?B?ZktsSGM0RWRkY05Nb092WGNOMGtRNDlITlRVM1NmSXNQWG5ZT1dJUUVSNm1r?=
 =?utf-8?B?L1ZlaUNDbU5FYi9xcGNIRUlzSHNjRVhGU1NXTnhET2trRzVieExTQmx3Y3pW?=
 =?utf-8?B?OUpGdDJoeHlTQkRVYVNUZzZBajBramt4TmhLT1dPeWVqR1AvWGtSSW9JeGd5?=
 =?utf-8?B?Z0Z3TExsR0ZaVmtTWVhFOTM1MGdNZ09YRFFkWXZtQnJpTFF3VXJUd0gxcFZl?=
 =?utf-8?B?bm9Sc2Y3UmVzcHNDVGhBdzZJNzByNC9HN0RwSFg5UU1IUHpBRlBJQVJRcVpK?=
 =?utf-8?B?K1dzTzduellxMkkrYXJUWXl0NEFhQmw1QXdRcXRsOHdaeU9MZmhVL3FoZG0z?=
 =?utf-8?B?dm1DUGlQYTBpUWkxQmMrdlB5RXRSalBPM0E4R1k2VEpoNnVXUFk5VWpFd21w?=
 =?utf-8?B?U0RCamxrWG0rVnhEbkhhRW9sY3N1VVFVbkUzaTV5dm5HbVcxL2U2clNTNEpD?=
 =?utf-8?B?TmhpcHFGS21VaTZqU0JONjJkdERBczhOL2pibUVYZUpOMldNZmoxdzAvSGtN?=
 =?utf-8?B?VU4wQlFWUHIySEYyVmJ3cGYxalJ3US9Jai9SQ1k5QnNORm8xU3V4RWcwYWxv?=
 =?utf-8?B?ZkJiYUYralNhRHo1NzJNa3FLNG00aTdUeHI4MTJDSURpYm8vdWlRbTJoeXdI?=
 =?utf-8?B?bUE2SlVZcDJkY3dkMnRHeC9BUWdZSTNlcjJNTmJobG5XRk1hRkxQall6QlVl?=
 =?utf-8?B?N2FsemV6b2wxSXVOTWNocGxFVkkrbW80VmVMRW5UVk1vTnNnK0Rhck1rSUx5?=
 =?utf-8?B?L2NjUWFBWlFydms3ZzM2dzZEcTJjN2FuS0d5VElWQURyV2loVkl1QUhMalgr?=
 =?utf-8?B?SXhMbFNVVnpKNUh0dkx2OXRsK25Xc0djdVZ6b1doU3hramVCemJqM1FRY1NB?=
 =?utf-8?B?Zy9mbk1DNjZrcW1vTmtqMmNVNFdPN0hveXk4VmxIQUM3bVdWc0U2a2lleTlZ?=
 =?utf-8?B?S09QaTdqdE56Y0RETmp3b3J2SkJURFNKaDZsSTljVDhKYWhuQk9rSWladU1m?=
 =?utf-8?B?RFZPeVVEbzF5YUQ1ZjcwRmxMYVdQclJReHFmN09LS01jYXFibTJIUmJGQUU5?=
 =?utf-8?B?OHVLQml1UitNcTc3MFpMdTlUa3BBeVQzTFJkd0k2SHpMcTJWdVhpY2tXeEtY?=
 =?utf-8?B?ZHltWTlNbHZPMHJNMTB2dGpjdmZBdGJCL2NXWEhGTm9qZDVlZ2ZNUWpXVnpO?=
 =?utf-8?B?OG1OTmJNdnM2L3pqZ0FEdWU5TC9Bd0tlV1NNYU9SZXR6cHgwL1p6SUw5YVN5?=
 =?utf-8?B?aGtMNTV6QXBEMXk2Y21Yb3duenRPcmQ4ZEQydGN4eWt5V0NNZVdaN3RKK1lT?=
 =?utf-8?B?TU8yNVZ1TkRrSGliSHVvREZpbjFWYjBZOHlEdSt6QmJsZEtrZ3htbSt4WStL?=
 =?utf-8?B?VTZhRXByT3BDby90ZGVRNlNNTGJSaTVxV2FxMm5renVMR2phNzRHMnpWUUtR?=
 =?utf-8?B?OEtwOWloSGpaUlJpUzhXQnJTRUhJY0xxdkFDU1BtUkZSR3VBL3NCQnlCZ1Ax?=
 =?utf-8?B?T2M1bHY5TitsbU9URHRNNFJXcmtaNG1TZVZ6NUJJVGtmT2dJT0w3YW0zK2pR?=
 =?utf-8?B?WVFIaGhSVG9VK1NRMFpRT05NOCtXcnVqN3FkMy9BQkpuRldxajVUZXJmdWc1?=
 =?utf-8?B?NTB4MnNYSlI0WUZTeHBJcG9FajR5VGU3QThhYlAvUkUzT1k2RkhRdm1HU0dV?=
 =?utf-8?B?U21WaVlWalBISFJ5c2xNT3BOd1Q1aStkZVQ1VHFGd1RUUGdZbW52RDVnalJn?=
 =?utf-8?B?VnUzRjVpRmN5TGRVSEpoeVV4a0t4TUt4ajVnOU5pWmlpamR0MFhSbDQxRGVH?=
 =?utf-8?B?dS82M0YyUldDdFBqVXRkNDcydVUreFJYY3JLWjhlaDY2aG0vN0kzeGxHT2xi?=
 =?utf-8?B?UWpudkt3Tk8weDV1bzJhQ2NEaVlTbEZ1em43dEUwdU94dzFaSkFkTmxFUEo0?=
 =?utf-8?B?cWxNUWJDaWpSdHVnY0NUYzVmQWw4YldSZnhQaS94MWlmY0NlTDBhQXdqR1Vl?=
 =?utf-8?B?ck9oR3BzajZvRXQyMEsrYmNZVDlBanhGQmtpbGZQYnYvWWk0V01LZGxRd2cw?=
 =?utf-8?Q?N7mE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e538fe-9f2c-470e-1c50-08dc5f0f7f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:52:13.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qI/NxmCmpskESjEbOcYI5tZQQ7kYZo1bu9DNukb8AjXXtCWf7oYpM8z7qWMz6Pc98t603UIl5tMjO6JN+b0h9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkkgaGF2ZSAgYSBkaXNjdXNzaW9u
IHdpdGggQ2hyaXN0aWFuIGFib3V0IHRoaXMgYmVmb3JlIC4gIFRoZSBjb25jbHVzaW9uIGlzIHRo
YXQgZHJpdmVyIHNob3VsZCBwcmV2ZW50IG11bHRpcGxlIHByb2Nlc3MgZnJvbSB1c2luZyAgdGhl
ICBNRVMgcmluZyBhdCB0aGUgc2FtZSB0aW1lIC4gQWxzbyBmb3IgY3VycmVudCBNRVMgIHJpbmcg
dXNhZ2UgLGRyaXZlciBkb2Vzbid0IGhhdmUgdGhlICBsb2dpYyB0byBwcmV2ZW50IHRoZSByaW5n
ICBiZWVuICBvdmVyZmxvd2VkIGFuZCB3ZSBkb2Vzbid0IGhpdCB0aGUgaXNzdWUgYmVjYXVzZSBN
RVMgd2lsbCB3YWl0IHBvbGxpbmcgZm9yIGVhY2ggTUVTIHN1Ym1pc3Npb24gLiBJZiB3ZSB3YW50
IHRvIGNoYW5nZSB0aGUgTUVTIHRvIHdvcmsgYXN5bmNocm9ub3VzbHkgLCB3ZSBuZWVkIHRvIGNv
bnNpZGVyIGEgd2F5IHRvIGF2b2lkIHRoaXMgKHNpbWlsYXIgdG8gYWRkIHRoZSBsaW1pdCBpbiB0
aGUgZmVuY2UgaGFuZGxpbmcgd2UgdXNlIGZvciBraXEgYW5kICBITU0gcGFnaW5nKQ0KDQpSZWdh
cmRzDQpTaGFveXVuLmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTcsIDIwMjQgODo0OSBB
TQ0KVG86IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5
QGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxK
YWNrLlhpYW9AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1k
LmNvbT47IENoYW5nLCBIYWlKdW4gPEhhaUp1bi5DaGFuZ0BhbWQuY29tPjsgTGVvIExpdSA8bGVv
LmxpaXVAYW1kLmNvbT47IExpdSwgSmVubnkgKEppbmcpIDxKZW5ueS1KaW5nLkxpdUBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGRybS9hbWRncHUvbWVzMTE6IG1ha2UgZmVuY2Ug
d2FpdHMgc3luY2hyb25vdXMNCg0KQW0gMTcuMDQuMjQgdW0gMTM6MzAgc2NocmllYiBIb3JhY2Ug
Q2hlbjoNCj4gVGhlIE1FUyBmaXJtd2FyZSBleHBlY3RzIHN5bmNocm9ub3VzIG9wZXJhdGlvbiB3
aXRoIHRoZSBkcml2ZXIuICBGb3INCj4gdGhpcyB0byB3b3JrIGFzeW5jaHJvbm91c2x5LCBlYWNo
IGNhbGxlciB3b3VsZCBuZWVkIHRvIHByb3ZpZGUgaXRzIG93bg0KPiBmZW5jZSBsb2NhdGlvbiBh
bmQgc2VxdWVuY2UgbnVtYmVyLg0KDQpXZWxsIHRoYXQncyBjZXJ0YWlubHkgbm90IGNvcnJlY3Qu
IFRoZSBzZXFubyB0YWtlcyBjYXJlIHRoYXQgd2UgY2FuIHdhaXQgYXN5bmMgZm9yIHRoZSBzdWJt
aXNzaW9uIHRvIGNvbXBsZXRlLg0KDQpTbyBjbGVhciBOQUsgZm9yIHRoYXQgcGF0Y2ggaGVyZS4N
Cg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBGb3Igbm93LCBhZGQgYSBtdXRleCBsb2Nr
IHRvIHNlcmlhbGl6ZSB0aGUgTUVTIHN1Ym1pc3Npb24uDQo+IEZvciBTUi1JT1YgbG9uZy13YWl0
IGNhc2UsIGJyZWFrIHRoZSBsb25nLXdhaXQgdG8gc2VwYXJhdGVkIHBhcnQgdG8NCj4gcHJldmVu
dCB0aGlzIHdhaXQgZnJvbSBpbXBhY3RpbmcgcmVzZXQgc2VxdWVuY2UuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEhvcmFjZSBDaGVuIDxob3JhY2UuY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMgfCAgMyArKysNCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmggfCAgMSArDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+IGluZGV4IDc4ZTRmODhm
NTEzNC4uODg5NmJlOTViMmM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfbWVzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X21lcy5jDQo+IEBAIC0xMzcsNiArMTM3LDcgQEAgaW50IGFtZGdwdV9tZXNfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgc3Bpbl9sb2NrX2luaXQoJmFkZXYtPm1l
cy5xdWV1ZV9pZF9sb2NrKTsNCj4gICAgICAgc3Bpbl9sb2NrX2luaXQoJmFkZXYtPm1lcy5yaW5n
X2xvY2spOw0KPiAgICAgICBtdXRleF9pbml0KCZhZGV2LT5tZXMubXV0ZXhfaGlkZGVuKTsNCj4g
KyAgICAgbXV0ZXhfaW5pdCgmYWRldi0+bWVzLnN1Ym1pc3Npb25fbG9jayk7DQo+DQo+ICAgICAg
IGFkZXYtPm1lcy50b3RhbF9tYXhfcXVldWUgPSBBTURHUFVfRkVOQ0VfTUVTX1FVRVVFX0lEX01B
U0s7DQo+ICAgICAgIGFkZXYtPm1lcy52bWlkX21hc2tfbW1odWIgPSAweGZmZmZmZjAwOyBAQCAt
MjIxLDYgKzIyMiw3IEBAIGludA0KPiBhbWRncHVfbWVzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+ICAgICAgIGlkcl9kZXN0cm95KCZhZGV2LT5tZXMucXVldWVfaWRfaWRyKTsN
Cj4gICAgICAgaWRhX2Rlc3Ryb3koJmFkZXYtPm1lcy5kb29yYmVsbF9pZGEpOw0KPiAgICAgICBt
dXRleF9kZXN0cm95KCZhZGV2LT5tZXMubXV0ZXhfaGlkZGVuKTsNCj4gKyAgICAgbXV0ZXhfZGVz
dHJveSgmYWRldi0+bWVzLnN1Ym1pc3Npb25fbG9jayk7DQo+ICAgICAgIHJldHVybiByOw0KPiAg
IH0NCj4NCj4gQEAgLTI0MCw2ICsyNDIsNyBAQCB2b2lkIGFtZGdwdV9tZXNfZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgaWRyX2Rlc3Ryb3koJmFkZXYtPm1lcy5xdWV1
ZV9pZF9pZHIpOw0KPiAgICAgICBpZGFfZGVzdHJveSgmYWRldi0+bWVzLmRvb3JiZWxsX2lkYSk7
DQo+ICAgICAgIG11dGV4X2Rlc3Ryb3koJmFkZXYtPm1lcy5tdXRleF9oaWRkZW4pOw0KPiArICAg
ICBtdXRleF9kZXN0cm95KCZhZGV2LT5tZXMuc3VibWlzc2lvbl9sb2NrKTsNCj4gICB9DQo+DQo+
ICAgc3RhdGljIHZvaWQgYW1kZ3B1X21lc19xdWV1ZV9mcmVlX21xZChzdHJ1Y3QgYW1kZ3B1X21l
c19xdWV1ZSAqcSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9tZXMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0K
PiBpbmRleCA2YjNlMTg0NGVhYzUuLjkwYWY5MzVjYzg4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPiBAQCAtODUsNiArODUsNyBAQCBzdHJ1Y3QgYW1k
Z3B1X21lcyB7DQo+DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAgICAgICAgICAgICAgcmlu
ZzsNCj4gICAgICAgc3BpbmxvY2tfdCAgICAgICAgICAgICAgICAgICAgICByaW5nX2xvY2s7DQo+
ICsgICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgICAgICAgICAgc3VibWlzc2lvbl9sb2NrOw0K
Pg0KPiAgICAgICBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgICAgICAgICAgICpmd1tBTURHUFVfTUFY
X01FU19QSVBFU107DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tZXNfdjExXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5j
DQo+IGluZGV4IGU0MGQwMGFmZDRmNS4uMGE2MDlhNWI4ODM1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiBAQCAtMTYyLDYgKzE2Miw3IEBAIHN0YXRpYyBp
bnQgbWVzX3YxMV8wX3N1Ym1pdF9wa3RfYW5kX3BvbGxfY29tcGxldGlvbihzdHJ1Y3QgYW1kZ3B1
X21lcyAqbWVzLA0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmbWVzLT5yaW5n
Ow0KPiAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgICAgICBzaWduZWQgbG9uZyB0aW1l
b3V0ID0gYWRldi0+dXNlY190aW1lb3V0Ow0KPiArICAgICBzaWduZWQgbG9uZyByZXRyeV9jb3Vu
dCA9IDE7DQo+ICAgICAgIGNvbnN0IGNoYXIgKm9wX3N0ciwgKm1pc2Nfb3Bfc3RyOw0KPg0KPiAg
ICAgICBpZiAoeF9wa3QtPmhlYWRlci5vcGNvZGUgPj0gTUVTX1NDSF9BUElfTUFYKSBAQCAtMTY5
LDE1ICsxNzAsMTkgQEANCj4gc3RhdGljIGludCBtZXNfdjExXzBfc3VibWl0X3BrdF9hbmRfcG9s
bF9jb21wbGV0aW9uKHN0cnVjdCBhbWRncHVfbWVzDQo+ICptZXMsDQo+DQo+ICAgICAgIGlmIChh
bWRncHVfZW11X21vZGUpIHsNCj4gICAgICAgICAgICAgICB0aW1lb3V0ICo9IDEwMDsNCj4gLSAg
ICAgfSBlbHNlIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gKyAgICAgfQ0KPiArDQo+
ICsgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgdGltZW91dCA+IDApIHsNCj4gICAg
ICAgICAgICAgICAvKiBXb3JzdCBjYXNlIGluIHNyaW92IHdoZXJlIGFsbCBvdGhlciAxNSBWRiB0
aW1lb3V0LCBlYWNoIFZGIG5lZWRzIGFib3V0IDYwMG1zICovDQo+IC0gICAgICAgICAgICAgdGlt
ZW91dCA9IDE1ICogNjAwICogMTAwMDsNCj4gKyAgICAgICAgICAgICByZXRyeV9jb3VudCA9ICgx
NSAqIDYwMCAqIDEwMDApIC8gdGltZW91dDsNCj4gICAgICAgfQ0KPiAgICAgICBCVUdfT04oc2l6
ZSAlIDQgIT0gMCk7DQo+DQo+ICsgICAgIG11dGV4X2xvY2soJm1lcy0+c3VibWlzc2lvbl9sb2Nr
KTsNCj4gICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJm1lcy0+cmluZ19sb2NrLCBmbGFncyk7DQo+
ICAgICAgIGlmIChhbWRncHVfcmluZ19hbGxvYyhyaW5nLCBuZHcpKSB7DQo+ICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbWVzLT5yaW5nX2xvY2ssIGZsYWdzKTsNCj4gKyAg
ICAgICAgICAgICBtdXRleF91bmxvY2soJm1lcy0+c3VibWlzc2lvbl9sb2NrKTsNCj4gICAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gICAgICAgfQ0KPg0KPiBAQCAtMTk5LDggKzIwNCwx
MyBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9zdWJtaXRfcGt0X2FuZF9wb2xsX2NvbXBsZXRpb24o
c3RydWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgIGRl
dl9kYmcoYWRldi0+ZGV2LCAiTUVTIG1zZz0lZCB3YXMgZW1pdHRlZFxuIiwNCj4geF9wa3QtPmhl
YWRlci5vcGNvZGUpOw0KPg0KPiAtICAgICByID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhy
aW5nLCByaW5nLT5mZW5jZV9kcnYuc3luY19zZXEsDQo+IC0gICAgICAgICAgICAgICAgICAgdGlt
ZW91dCk7DQo+ICsgICAgIGRvIHsNCj4gKyAgICAgICAgICAgICByID0gYW1kZ3B1X2ZlbmNlX3dh
aXRfcG9sbGluZyhyaW5nLCByaW5nLT5mZW5jZV9kcnYuc3luY19zZXEsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRpbWVvdXQpOw0KPiArICAgICAgICAgICAgIHJldHJ5X2NvdW50
LS07DQo+ICsgICAgIH0gd2hpbGUgKHJldHJ5X2NvdW50ID4gMCAmJiAhYW1kZ3B1X2luX3Jlc2V0
KGFkZXYpKTsNCj4gKw0KPiArICAgICBtdXRleF91bmxvY2soJm1lcy0+c3VibWlzc2lvbl9sb2Nr
KTsNCj4gICAgICAgaWYgKHIgPCAxKSB7DQo+DQo+ICAgICAgICAgICAgICAgaWYgKG1pc2Nfb3Bf
c3RyKQ0KDQo=
