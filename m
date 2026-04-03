Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CD9E8536E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E1610E095;
	Fri,  3 Apr 2026 13:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rkj3jiKb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB5110E095
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+mcfX+sI7DX9R4P3EezuDzS/b5Jgw3lbHQE7kMSrQPEOcOP8HhDkJSOPi+Sz1zZycfe7SK4ez8ZcNRTb3UrsYDxRKsNey6wKfVUY3/InCvpKe3to4X/v54zQ6fv0ISUfkfRdgaSHc4BaBb3r9WVMuOuIqbIuN8jMe5OeQZPQpRFlMoySS6qAbiomBvUE1/IhH47eRMpNsqpw5PMB3JOgPO8Qf1W3BtlmxOvyizSMOX28PdASrAd5pRtSFvNY3jNfeUkKB9zTHC6OJGBKqWQhfoapzTTmLCvQKauVraNNiJz3Kry6HkaxAI9md8Og4tUkgvNPfC3Ll+AlDxBr+GYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWYjzMyM5QI7+xVA9ofeGCc1TPcqCfapfRdoQ9/nQl8=;
 b=FKOxXM7pWNlzjLGHpMgWJLxIc4xPe80OBxd5bqpHKPl2otgKGGZCoAto5THFUOxwrIXe7rb48tKrAcyslnpG83P7GIUX1TBlUvcWAQFmPqm5UEauF+gJulDYPmCpBK2nm27ehTnWtHplKUeu6jct1ZDVhXpvoj6nMYQtuhjxPmLY3n9qd8oN3X1arPVUcp7IM5I6c95e6oy4mv79PEn/ezLLbLPl7qzMv9FW3GOzJ8W7GqcJC+Jfp7bJl5W4RW1CTh9vwLlmUZ/6J2a2QMFyAldVB79HMWg7PiEHMpAxN+sRozg03co/pJxjC+pyD/qnigJH0+XYD3ZADXjGYrOARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWYjzMyM5QI7+xVA9ofeGCc1TPcqCfapfRdoQ9/nQl8=;
 b=rkj3jiKbCLQFLdXs/zI5OSPyTqcWzZWtP2tUMLVv2+uu6iwh2oEGuRTmTBvDM9svMdFweC+trwQzJMG3AdEje8P8tWNGLjR8jNizd3lNxGM9jV2zzHvR6riAUm6+2DJfkDqMrhw0PWd6y6t3syc4fBoiwp94FQRIB/6HGGJHO9k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 13:56:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:56:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use amdgpu by default for CIK APUs too
Thread-Topic: [PATCH] drm/amdgpu: Use amdgpu by default for CIK APUs too
Thread-Index: AQHcwxCyeXiDwM6Q+EyX1YEwkjidrbXNXP1w
Date: Fri, 3 Apr 2026 13:56:04 +0000
Message-ID: <BL1PR12MB514447B8B4E054FF60778906F75EA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260403022208.232991-1-timur.kristof@gmail.com>
In-Reply-To: <20260403022208.232991-1-timur.kristof@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-03T13:55:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYYPR12MB8963:EE_
x-ms-office365-filtering-correlation-id: 361bf6f1-6119-4fd7-809f-08de9188bfb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: E00mvTmQrSpDYmone6Wneg+eN0gGeeBKktbz8TVKMMFHr59UTGdwZhF14Gu1/aAyqOuJanmVtPwINlOqcH9uYZcFh9l03jVBZFmswqwv5NDGMxbvct4Hgv4kSoXJ8k5HaYRG2bNfP27NntYrArDF7Syg9ijKT8zATe45gF77cFdkV2bVHkwkgsjVIMad5oMx6YkCvj9tTAmAPjINLrti/kqN0DqBVUj0XNp5IWwnGsIxvnvZUj5vvkyVO9PgFP6UyH5Q1fkYp3kNK+CZCBE6vgZxis3nRxVCVt8QMuteR4+QQ7gz5dz0aVzmxeFOKY7Sf7kNyI5OOR1zIt2cwJXv+XlxlDId31cc+lkzqfsvsl3W3BYe5hqUJFUnSq+Z6X8HAth7OJfbHgz3d6ZpOk+CItshpp/ZvA99XL+F7iP1MTgDcoGjtkgbdPYntl/0idHifuKNC7tnZVeYaumXv2Qa0kzPBJNBvIR6xNCbKyT0jEXFPiDfFeUd5rCU0IDYfEZmTwAXnKsIKNWll9DrDuhMYiijk8uGRgExBdcZyp5tRa130ApHJNFi106t+IkjdHM4qdOM1H24Nn3ISDrn1qx7SkH4GR6U5bC/tQ7arm/zSFEf8mu4iLl9hQHI68bha7kbigmxLmCLVL2bcyhAMdCMMSbUSAB8drN3OkizbEYoveJ4e8YL8OI2jBISSKFV6+/qW+6ISGXwQW7aVax18hzuRnYuEjjRJfRw00ACobc3YlgE6TKCTjdQRsuq7/DCve+xHtc0X//FufO4uR1N55aJwb1dgyQzGbp85vF5hNZmD7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVJOWEdFelZNTTVxeHNPejZqWERrdFRNNGhJaEw4Z1Q0VDhNbEpyQTBqVkV1?=
 =?utf-8?B?a1hTMSs1MFc1YzVmRGlTeFBNR1RmNStIYVdNdzBsQitzUEswdmdJd21RNCts?=
 =?utf-8?B?dVJEL1dsQm5ONmNKVHlEZUx5cEw5UDNaWUR2bko1MWdGY3dhK2ZJZHNkbWtK?=
 =?utf-8?B?dlhacWZVZ2JCQVFzYlZRNDV3MklEdDJhcTI4VTR5aHUvcHp4bDYvb2M0ZU1r?=
 =?utf-8?B?U2tJYlRacnM0bEhJb1BWSnhjZG5WWlFpcUZnSkhVTU4xYVEzTVFGYlBUVGJX?=
 =?utf-8?B?UVM0dDY3Q1NjRUNjTVRjbm90d2FkZENWenRyS0ZVME52ZnRhaTk3dTZNcXJo?=
 =?utf-8?B?MzNqVEx2d2lNOVl1NkJjUnM5OEd0SU1DOXVVT3JaTkNSYitoK21zcWQ0OGtO?=
 =?utf-8?B?eHBnTWNMVWcwWXR0TVlTVXFhTld4NW5XTVAxelJPa3pvaW5GMFh1ck1TaU9Q?=
 =?utf-8?B?aEtTa1hVck5WOU9zN25XQlI1WjZHNDNLVjkrOTZxMXRwRUY5RHMrNDlSSk9i?=
 =?utf-8?B?K0ZEM2g2d2FNZ00vOHhBSmlRQ3kxYm5EQldjMHpIM2FQRjZCQThxSkU4UUQw?=
 =?utf-8?B?bUtnMlluU1U4dmxNcDlTa2ZYR1htWHIwT2FOR2l6WStUa3oxdmZlU3VGTVNr?=
 =?utf-8?B?blhtWCsrZGZqMWEzRm9XOXg1aHhzZG05T1JxVzkxM3JXZ3hhZVVzSXZpaEFB?=
 =?utf-8?B?ZjUvb2Y0VHgzRFBUTFN3WEtVQ2RFemwvYVc2eGdwOUFQZW9rd2VnN3NLNU9K?=
 =?utf-8?B?QlNOQlJxZ0UvejhubzNXZVYrRFI2Yng3d1ViUDFOM0d1aDlqY0pqdnY0cFFa?=
 =?utf-8?B?VlltaUY2ODBBaUd3Ynp5djBDRU5JOS9zRTZHcXZHeTIzMlhDWVFsNEE3SXVB?=
 =?utf-8?B?UXBlNEdDbXBGRVNjb3I0Yk00aUZMVjNXTWRKWVRSSk8xeC9NL29xYlhwaWVm?=
 =?utf-8?B?UEE5d240YVhpUnlIQkErOTlBQ2cwemR0MlQzUm5qbEh6akd6Vk9RMCt2K0hG?=
 =?utf-8?B?eFF2ZFd0bGFXam9ib1dNa05rais3M3FRMFVnQUk0OU5mU1BFbEpYNVJWY3Qw?=
 =?utf-8?B?U0d1dFQ0bTdVVGFoZ3Jqcy80NE9qbWJmQ2JqZXB5a1NGUEErSk85dXZhbVhp?=
 =?utf-8?B?QkY0K2NDWmxlanNKa1pTeDdCcXV3bllSeHE1cFp0ZytMMWtKQXdWaEZBWEg3?=
 =?utf-8?B?Q1k3Vmw2Y1k2MGZQb2tTOFZ3cXNocWJWZDRHRFN3Z3VwU3BGcHA2UldrN0M5?=
 =?utf-8?B?cEVYbHF2SS9zbDB4T0dyOGhBdzdNbGFsWkNNSFowcVNKdzh0OWgyT0lSY1R0?=
 =?utf-8?B?ZGdSK0JkZ0xuWTNMS09jMnUrSzdzU29RcXlZVmdOZ1VVM0RYRE5WbHpPbDRr?=
 =?utf-8?B?cXVPenZzRmlUN0JuL1dNdnNUSnl2UFJjWGJ1V0Q0TWlhbkdpclljOE5zMWt6?=
 =?utf-8?B?TnNKRnpXNWRjVkc2S2lmYTJlTGZ4ODhHWHBaVnpPdUxJeFFxZXJxVUovam1Q?=
 =?utf-8?B?THFOV25vNlNHSzM3akdRMDNjMGI2QkZkUDZYRU92MmlJWE1EZFJ2Ui9yWVMz?=
 =?utf-8?B?a2tXM0gyWnhuWlo0SW9GVW5YblNnbEVvRWU0NlhsdHN0MTR0ZVc1SWZ3YzBH?=
 =?utf-8?B?NWhGR2tCZ0E4UzdJR2krS1pqQkVVZ3lubk1TaHBGQVdETGNoU091OE5wdHJY?=
 =?utf-8?B?M0MxYlExa0QxNjEyTTROb3ZCMlBOUm9iNG5Rb3N2UGZCUytaT1BCRlR3OHoz?=
 =?utf-8?B?MXBwWS9ZK0QzTUFhOC9kSFk2cWFVc3dxOUwvNDJnaEFFbzA0Wkt2VGpYSjU3?=
 =?utf-8?B?Z01haDJJZ1FJUHpWU2tyazdtK2VtaFhaMVYxdFVtSXlEVmRITkl2SjhXZlI3?=
 =?utf-8?B?SEkvVXkydTZhQ2FkcXpmalFNcTZSMExCNWFCWSt6QU5neWRuY1doWFkwVVlj?=
 =?utf-8?B?SHA4YmdYNk91N2FLaVlDTGZiN0poQ0ZEUFJzcDUrdEQxYTNVZGtUMnBSbGRO?=
 =?utf-8?B?UnNHTVZIZ3l1aDVHR21GTG8rd2V1ZktPQUJndmx5ZFVjdUxXSEgxSUNoclhm?=
 =?utf-8?B?NlpKZmtLRGFsODZ2ZjQ2MVpMdERXd01UTmNTc0NFTUxpWHNEai9oNDRJelQ3?=
 =?utf-8?B?NnJKL0MxNmxZZ0RnQys4eE9HOWRjVHdsdUc0dmVzRmFFSE9hM3J0bDFNSVNn?=
 =?utf-8?B?WVF3SVE1L2RObFZrbDZtSElzNnZhYTcwTjI3K1BrZjBTdjI5RzBOK09rdFlZ?=
 =?utf-8?B?OVhmM3Z0Y0RDOUlNSldvQlVYYWo0a3paRFNCVmlCNGFjRzhOYnJLcFNNcmZC?=
 =?utf-8?Q?uIWu24l52mk0UqdCb9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361bf6f1-6119-4fd7-809f-08de9188bfb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 13:56:05.0583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/NbU34Qq254LZqD2DdzDyB0Wq5whcta8eVAR4b81o2eMMdVN9sBlelg8/ti5ncfKVPewantbpQ2K+vxocbNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11ciBL
cmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJp
bCAyLCAyMDI2IDEwOjIyIFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmln
LCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IFRpbXVyIEty
aXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kZ3B1OiBVc2UgYW1kZ3B1IGJ5IGRlZmF1bHQgZm9yIENJSyBBUFVzIHRvbw0KPg0KPiBDSUsg
QVBVcyBhcmU6IEthdmVyaSwgS2FiaW5pIGFuZCBNdWxsaW5zIGZyb20gMjAxM34yMDE1LCB3aGlj
aCBhbGwgaGF2ZSBhDQo+IHNlY29uZCBnZW5lcmF0aW9uIEdDTiBiYXNlZCBpbnRlZ3JhdGVkIEdQ
VS4NCj4NCj4gVGhlIGFtZGdwdSBkcml2ZXIgaGFzIGJlZW4gd29ya2luZyB3ZWxsIG9uIENJSyBB
UFVzIGZvciB5ZWFycy4NCj4gRmVhdHVyZXMgd2hpY2ggd2VyZSBwcmV2aW91c2x5IG1pc3Npbmcg
aGF2ZSBiZWVuIGFkZGVkIHJlY2VudGx5LCBzcGVjaWZpY2FsbHkNCj4gREMgc3VwcG9ydCBmb3Ig
YW5hbG9nIGNvbm5lY3RvcnMgYW5kIERQIGJyaWRnZSBlbmNvZGVycy4gTm93IGFtZGdwdSBpcyBh
dA0KPiBmZWF0dXJlIHBhcml0eSB3aXRoIHRoZSBvbGQgcmFkZW9uIGRyaXZlciBvbiBDSUsgQVBV
cy4NCj4NCj4gRW5hYmxpbmcgdGhlIGFtZGdwdSBkcml2ZXIgYnkgZGVmYXVsdCBmb3IgQ0lLIEFQ
VXMgaGFzIHRoZSBmb2xsb3dpbmcgYmVuZWZpdHM6DQo+DQo+IC0gTW9yZSBzdGFibGUgT3BlbkdM
IHN1cHBvcnQgdGhyb3VnaCBSYWRlb25TSQ0KPiAtIFZ1bGthbiBzdXBwb3J0IHRocm91Z2ggUkFE
Vg0KPiAtIEltcHJvdmVkIHBlcmZvcm1hbmNlDQo+IC0gQmV0dGVyIGRpc3BsYXkgZmVhdHVyZXMg
dGhyb3VnaCBEQw0KPg0KPiBVc2VycyB3aG8gd2FudCB0byBrZWVwIHVzaW5nIHRoZSBvbGQgZHJp
dmVyIGNhbiBkbyBzbyB1c2luZzoNCj4gYW1kZ3B1LmNpa19zdXBwb3J0PTAgcmFkZW9uLmNpa19z
dXBwb3J0PTENCj4NCj4gU2lnbmVkLW9mZi1ieTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0
b2ZAZ21haWwuY29tPg0KDQpBcHBsaWVkLiAgVGhhbmtzIQ0KDQpBbGV4DQoNCg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDcgKystLS0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgICAgIHwgMyArLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IGluZGV4IDhlZDYzN2Y5MjMyMjYu
LmU0NzkyMWUyYTlhZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMNCj4gQEAgLTY0MSw5ICs2NDEsNyBAQCBtb2R1bGVfcGFyYW1fbmFtZWQoc2lfc3VwcG9y
dCwNCj4gYW1kZ3B1X3NpX3N1cHBvcnQsIGludCwgMDQ0NCk7DQo+ICAgKiBDSUsgKFNlYSBJc2xh
bmRzKSBhcmUgc2Vjb25kIGdlbmVyYXRpb24gR0NOIEdQVXMsIHN1cHBvcnRlZCBieSBib3RoDQo+
ICAgKiBkcml2ZXJzOiByYWRlb24gKG9sZCkgYW5kIGFtZGdwdSAobmV3KS4gVGhpcyBwYXJhbWV0
ZXIgY29udHJvbHMgd2hldGhlcg0KPiAgICogYW1kZ3B1IHNob3VsZCBzdXBwb3J0IENJSy4NCj4g
LSAqIEJ5IGRlZmF1bHQ6DQo+IC0gKiAtIENJSyBkZWRpY2F0ZWQgR1BVcyBhcmUgc3VwcG9ydGVk
IGJ5IGFtZGdwdS4NCj4gLSAqIC0gQ0lLIEFQVXMgYXJlIHN1cHBvcnRlZCBieSByYWRlb24gKGV4
Y2VwdCB3aGVuIHJhZGVvbiBpcyBub3QgYnVpbHQpLg0KPiArICogQnkgZGVmYXVsdCwgQ0lLIGRl
ZGljYXRlZCBHUFVzIGFuZCBBUFVzIGFyZSBzdXBwb3J0ZWQgYnkgYW1kZ3B1Lg0KPiAgICogT25s
eSByZWxldmFudCB3aGVuIENPTkZJR19EUk1fQU1ER1BVX0NJSyBpcyBlbmFibGVkIHRvIGJ1aWxk
IENJSw0KPiBzdXBwb3J0IGluIGFtZGdwdS4NCj4gICAqIFNlZSBhbHNvIHJhZGVvbi5jaWtfc3Vw
cG9ydCB3aGljaCBzaG91bGQgYmUgZGlzYWJsZWQgd2hlbg0KPiBhbWRncHUuY2lrX3N1cHBvcnQg
aXMNCj4gICAqIGVuYWJsZWQsIGFuZCB2aWNlIHZlcnNhLg0KPiBAQCAtMjMyMyw4ICsyMzIxLDYg
QEAgc3RhdGljIGJvb2wgYW1kZ3B1X3N1cHBvcnRfZW5hYmxlZChzdHJ1Y3QgZGV2aWNlDQo+ICpk
ZXYsDQo+DQo+ICAgICAgIGNhc2UgQ0hJUF9CT05BSVJFOg0KPiAgICAgICBjYXNlIENISVBfSEFX
QUlJOg0KPiAtICAgICAgICAgICAgIHN1cHBvcnRfYnlfZGVmYXVsdCA9IHRydWU7DQo+IC0gICAg
ICAgICAgICAgZmFsbHRocm91Z2g7DQo+ICAgICAgIGNhc2UgQ0hJUF9LQVZFUkk6DQo+ICAgICAg
IGNhc2UgQ0hJUF9LQUJJTkk6DQo+ICAgICAgIGNhc2UgQ0hJUF9NVUxMSU5TOg0KPiBAQCAtMjMz
Miw2ICsyMzI4LDcgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3N1cHBvcnRfZW5hYmxlZChzdHJ1Y3Qg
ZGV2aWNlDQo+ICpkZXYsDQo+ICAgICAgICAgICAgICAgcGFyYW0gPSAiY2lrX3N1cHBvcnQiOw0K
PiAgICAgICAgICAgICAgIG1vZHVsZV9wYXJhbSA9IGFtZGdwdV9jaWtfc3VwcG9ydDsNCj4gICAg
ICAgICAgICAgICBhbWRncHVfc3VwcG9ydF9idWlsdCA9DQo+IElTX0VOQUJMRUQoQ09ORklHX0RS
TV9BTURHUFVfQ0lLKTsNCj4gKyAgICAgICAgICAgICBzdXBwb3J0X2J5X2RlZmF1bHQgPSB0cnVl
Ow0KPiAgICAgICAgICAgICAgIGJyZWFrOw0KPg0KPiAgICAgICBkZWZhdWx0Og0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYw0KPiBpbmRleCA4N2ZkNjI1NWMxMTQxLi41M2QwNjA1
M2RlYzhhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYw0KPiBAQCAtMjc4
LDE0ICsyNzgsMTMgQEAgc3RhdGljIGJvb2wgcmFkZW9uX3N1cHBvcnRfZW5hYmxlZChzdHJ1Y3Qg
ZGV2aWNlDQo+ICpkZXYsDQo+DQo+ICAgICAgIGNhc2UgQ0hJUF9CT05BSVJFOg0KPiAgICAgICBj
YXNlIENISVBfSEFXQUlJOg0KPiAtICAgICAgICAgICAgIHN1cHBvcnRfYnlfZGVmYXVsdCA9IGZh
bHNlOw0KPiAtICAgICAgICAgICAgIGZhbGx0aHJvdWdoOw0KPiAgICAgICBjYXNlIENISVBfS0FW
RVJJOg0KPiAgICAgICBjYXNlIENISVBfS0FCSU5JOg0KPiAgICAgICBjYXNlIENISVBfTVVMTElO
UzoNCj4gICAgICAgICAgICAgICBnZW4gPSAiQ0lLIjsNCj4gICAgICAgICAgICAgICBtb2R1bGVf
cGFyYW0gPSByYWRlb25fY2lrX3N1cHBvcnQ7DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X3N1cHBv
cnRfYnVpbHQgJj0NCj4gSVNfRU5BQkxFRChDT05GSUdfRFJNX0FNREdQVV9DSUspOw0KPiArICAg
ICAgICAgICAgIHN1cHBvcnRfYnlfZGVmYXVsdCA9IGZhbHNlOw0KPiAgICAgICAgICAgICAgIGJy
ZWFrOw0KPg0KPiAgICAgICBkZWZhdWx0Og0KPiAtLQ0KPiAyLjUzLjANCg0K
