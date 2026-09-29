Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41600CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 09:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CAB10E9D2;
	Tue, 29 Sep 2026 09:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rA0ug0tQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEEAA10E9D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 09:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRJ2iZUGE1PIoOsLrd2HFvEkmL+sfAeH+SAxHDo/FziQWSwCxYZ55sgap9xi+esp026+CTEJcwc+uopOPzqQER4hUASO9LyZK50HyPrjYnIHFdVDtezRIOrUq95veNurrQ+4U9ftEKcPIflrd5ewe3YCb7xvfCXA8UAidRSrWPGSnGe/1rLsGaovgw7heamTjU7tGLZMmpVRSz7b8ZtDcRv1mWRaYKty3ZgWevFdfgevBZ08X3FEhkUlcwl3T5Ig5JgFvu1+3Jh/jzohm9d20wzXJ2/gQG9M5EfbIC6mYFeOOWsOXfKW595QUwkiYoK1mCAwI/PPKhlhtsy3QlSzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEV/5VaQW/ppzr4clSaILbiDsi+Es9b7h4tJmg8jyIM=;
 b=pXUEuqZVFDrJo0u6RkLp2/whFcG1RaZYhlC1u3UuHoXyyuLTmdnZJqKEIZzlEMLiATIxc1rDJwO0Gunln52K3yeJm7ppWPdFkGx4a+DyhEJYcC6RuTdVigPkDo5HX6fmBb4J1xS26DG1EvcI1I8SbjXkuaaYFmkA8phrQ87YWgGIc4g8mrp1tsO8j6ba99y7AWD4dVwvdSYrX4UmqngioaubCFnA/7fGh7qRsLGFzfXHneIRGSHZbinHjC8iBjxQsLmLpaYQHalGRnrjUkknxwmnuPWzfpANoLUyYMf6dDydx6MFZf+Epxx11zwvfymmkatPwSKpMLn11u5DC7hDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEV/5VaQW/ppzr4clSaILbiDsi+Es9b7h4tJmg8jyIM=;
 b=rA0ug0tQ39TY55dSJAp91e+uVEDUJPWURXZwys8+qZAuru5g61nOvSlwa7zHwpKXOLpSPp2REsJs8PwEdN7l9Jv3FtPjN20qxyenaQDHkxDMweRAoyeTjDhGLQVDM8KjpZRgiascq6wBr7CnIsMLEupWg5Rol0V2iW8DQOSK5Ig=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:36:00 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 09:36:00 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nmMq5HTaPVj0+C645FmSOmiLblQ/QAgAACu2A=
Date: Tue, 29 Sep 2026 09:36:00 +0000
Message-ID: <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
In-Reply-To: <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-29T09:22:24.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB9281:EE_
x-ms-office365-filtering-correlation-id: ab2a78f5-a190-423e-5dd2-08df1e0d127d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 7YAc4CsXQOA/47l2yIdLFYGSkqgY1xV7rR+utsr23K/w2awFZmfDDvvdxET1pQyLnSAtsT+vb4SYvtvYbQsBQvOgiY0TxOacjpMzkL/0l2F/RPKYmuRxrE4eTnhz3AIHqjYIen34icSUZbwbniLzFHwx/4wDP0YFcSRVrGGttEnFAtJQCAtPLQ3yLZ0S/VjH9e1SG1v65fwdy9i/6b9IN933mLnpYKYEaLoMkRtA/srNIpfQgF0NHEBgFb/fyURd8j5lRvI91Xw1wWc6HkWQl8sC5cAdwI543diYrUP/Jo1EzkNVER08DSI2KnIR/Vuloz0UvH4QHnRzE9IT7BumgwiBqwujUMMWXVTBc8x7vijylBHilh7iv42uk+Xp4z1XnApM1twiYmrpp6wSHCLplADyUp83+aDFL1STlBBgYYASfirztzrn/BOJ/TjbM9xObOr6goU2flRtlkBWaEHpHB26rwssD8tAKuZNbOfXlfoYD251nxFcXh3bnr8GfcV0nYRZNX/8ksK81BUPqsSbxuZd63NvmKnRQrNBNhVwe8QgAPxGtMSpTdvDblkiZf7cis0NZL8Sm93S2zkmfbVfH8lhAHbbhWbAmrdntlNOQFQGYQw9IGYZKLCIhKb7TdaSXMpLn7YQhpStLpsTq9trV7CAWk8n6oKv0qFsrCUMynf9P35lIRJElLMwqgmNEmqkr6Dc7YSSBccpNGKhD6a4SnAfdFVjv+gcmbMcNfCyebI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3NRWEFSVkNjTzlxOFI3OThMaHQyN1g0cDVYNTdXTnkxMlBoN2JIV21weHVw?=
 =?utf-8?B?RFBPRzlnMHZ0cUxNWWhjUmdWUUl5cFVTTENpYnlwNngrQkI5ZkQxWkxIUVBw?=
 =?utf-8?B?MCs4YXBrNXFkbXhBM0ZYV1NiWUZLWHc0Z0JsMmN1WTQwN24xK1lwVWZZL3Bn?=
 =?utf-8?B?Q3h4ckx4QUJPM0NtOE9zaUlwTlpSVFlFa01sVkZxZWJCRkNERlRaUGg0Y2tX?=
 =?utf-8?B?WWM3WkhXVWZSSEoyRUlpbEtEaTdSU2QyTEhkbzdrellnNjk3NWg1enlLMXJP?=
 =?utf-8?B?b0hmSitCUzYrNHp5aHBwUXV1RTk3VldER1c5Z0Q3T0RMektxaW1SZFhZTktQ?=
 =?utf-8?B?cDlJTjlKZVp2amFjQVBnMk1mSVJMR2hRTlZvNGRodEtSdm1OMWxIUjNMUVNv?=
 =?utf-8?B?MExkRzFxbTArVkhVR3pKQmd3VmZOODZhVCtScnArRjYxdVEyZ2Z4c1VMVERz?=
 =?utf-8?B?MkJyYkhQQ0xUV2FNWUpGcWVEZkJMU2l3d2lPRlhWWmRvMjRVcW5aQ3BJQUNV?=
 =?utf-8?B?NDJ1VEc0cDU2TWFaNnZLeTZ6dVk1UStkZzc3djdqQ1ZaWWlGcndKeUNDSW94?=
 =?utf-8?B?ZTlhdU1oOVhPNXlITUI2dGtRWlVyK3dDWmFpRkJJc2hRSUQwb1Rvc0wwNUxo?=
 =?utf-8?B?N3NLZDZZaDUyR1JJQmRtZC9RR1NNYlYydzliWXVFQkdoM0ZaOFU5QnkwR3BF?=
 =?utf-8?B?My9aL0FCeFJ5RS9iN3NrYU9QMG9hUmFOdEhLdE9IbzZvZnAvWUs0NXJIT1pv?=
 =?utf-8?B?Wld2SG1sRFZqaGt0V3dUN0M2MGRvNFo0Uys4anV3UDB6Nk13UUZudHlRZGpy?=
 =?utf-8?B?UU50TU1YSWZicGtyMWljcFUrblk0elZ5WW5MUndRRXBCS1pNMVRyZjhETmk2?=
 =?utf-8?B?cEorNG9oZ2FvcTZJNWxNZ2dTUDFIV3NFSWVNYWlHMnM5WXZjalhXeHQvWHpJ?=
 =?utf-8?B?YWl2Y2U4Q2wzd2JsUTZ3NktobGpveVRTa3l0YWUxRkwvenhNZVhJWVJFdmRl?=
 =?utf-8?B?SmlXM2JGZVU2R0ppUHZtZ1RRQklNQm9LSTIrTUxEMkdWYTdZdVNQdld2d1ZF?=
 =?utf-8?B?Y3RQeGVMQm5jeFZnWWFTL3pzb3orcUhFSTg5VzVOTlFqbE9CSU5vbU5sNGRS?=
 =?utf-8?B?SlJlUFlIaGhuZS90eXJyWGs0YmlwMktMNENzdko0TWZiblYyWHdrTFluZXRW?=
 =?utf-8?B?cTVrZWxTV2I2YmNIRGFrRHhqelp4VjFvNDVnaS9OWnJiOSs4UDlIN2pkVDlz?=
 =?utf-8?B?ZStVN1NwU2Y3YmZFbFJzYnVTa3hlbHlja1UrZG55SE1RRUFPSWtvZmxVNXN6?=
 =?utf-8?B?YTgxR285YnJ6d1pmYWxVeEpCMHlhRmVhVUVkSTMzSjhRZ0lRYlFCU2s4VERw?=
 =?utf-8?B?bkRpSG02RG1pamhjYnNKaGJzbm84cCsxa3lGaDBsUFJIMno0cG9ORVNLTWdQ?=
 =?utf-8?B?YmFWVDJQT01rQzRyRzZyU0tQeUtBVkFEWDVsVWlYR0dCUFhyZGQ3SExoUnFh?=
 =?utf-8?B?dlhub1hHWnMwTDJGOEd4dWdxNEhrUytmUnZWeElZNk1Hc1FWMzJaenN5MnR0?=
 =?utf-8?B?TVJGUEorL1RFbTNPa1U2YTZFYmp1UytudWpNTEs1Zmt3U3ZLM1NTMmlDaGNo?=
 =?utf-8?B?Q1JDWllPMGtjd25PSHlJUGU0YzREVmQxNEdJN3lxeWNxUXloTzFubGlBMTQ5?=
 =?utf-8?B?UFRwYlBjZFhQcXNsVUIzL2Uxb2VyYXM1WTcrYktkaTNXZHp6aUZnaW93WnlQ?=
 =?utf-8?B?eXZVdFJyeFpNaGF0QmVoazErMmpjMFhUVGZmNVBjWkxCbjNaWXpyUzFuaVpo?=
 =?utf-8?B?ZzVhMU5SV0xKejVnRG51WGV2NXNXTkM4U2xuNWFtQnVCMXlabjVSYzU2Qmlx?=
 =?utf-8?B?NFB1b2JXaVN0VkJ6U0NQaUhOUzlpS3VyaW9sdlRrVEM4NG55SzJGejltTHhq?=
 =?utf-8?B?c1E1K1NzZXpvclo2NnFENTZLQ2FiM1J2ekJSSTJmSURjUFYzYVNjS0JPdkFZ?=
 =?utf-8?B?eFVmZHNVRzBvYldGbDFGS0txUlplbUpuaXJjWmxQcnBaVFpLMWlGaDZvbzNx?=
 =?utf-8?B?SVFxK0ZmWXVRamdFbjQ2Z20xUFRBcWx6c05RL2xxVHBTS1BWTytCZXNCZ3k5?=
 =?utf-8?B?TnRqQ2t4S2krb1ROanpFK0c1cE5meVNjdDBxd3ZvbWdpaVdJeGlCbU85UFk0?=
 =?utf-8?B?M3ZESkJhSDRRSEwvMU51MVZSVmxQSkw1cjZtV3JJU2ZPbzZ3dzYwdmIzZ3gz?=
 =?utf-8?B?RmU1alp1R1Z1aXF6VDZJQnlvMENkR2RaYkdHcWFPVitNU0F6cjcyNjY4MXly?=
 =?utf-8?Q?Yj1bAs7WoEZ2ZlR3F6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2a78f5-a190-423e-5dd2-08df1e0d127d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 09:36:00.2826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8sWTlgu9NOiEb94IpDX8AXER+Mm+eSjtWsTOVhw56z6j10pCC/3po/B9vnYG98t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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

UHVibGljDQoNCkhpIENocmlzdGlhbiwNCg0KVGhlIG5vX2h3X2FjY2VzcyBmbGFnIHdhcyBmaXJz
dCBzZXQgaW4gY29tbWl0IDBkZTYwNGQwMzU3ZDBkMjJjYmYwM2FmMTA3N2QxNzRiNjQxNzA3YjYu
IFRoaXMgd2FzIGludGVuZGVkIHRvIGZpeCB0aGUgTW9kZSAxIHJlc2V0IGhhbmcsIGJ1dCBpdCBw
cm92ZWQgaW5zdWZmaWNpZW50Lg0KSSB0aGluayB0aGUgZmxhZyB3YXMgc2V0IGluIHRoZSBTTVUg
Y29kZSBzbyB0aGF0IGl0IHdvdWxkIGFwcGx5IG9ubHkgdG8gU01VMTMvMTQgQVNJQ3MsIHdpdGhv
dXQgYWZmZWN0aW5nIHRoZSBNb2RlIDEgcmVzZXQgcHJvY2VzcyBvbiBvdGhlciBBU0lDcy4NCkni
gJltIG5vdCBzdXJlIHdoZXRoZXIgd2UgY2FuIGRyb3AgdGhlIG5vX2h3X2FjY2VzcyBmbGFnIGFm
dGVyIGRpc2FibGluZyBQQ0lfQ09NTUFORF9NRU1PUlkuIFRoZSBQQ0kgaGFuZyBvY2N1cnMgaW50
ZXJtaXR0ZW50bHksIHNvIHdlIG1heSBuZWVkIGFub3RoZXIgcm91bmQgb2Ygc3RyZXNzIHRlc3Rp
bmcgdG8gY29uZmlybSB0aGF0IHRoZSBmbGFnIGlzIG5vIGxvbmdlciBuZWVkZWQuIFNob3VsZCB3
ZSByZW1vdmUgbm9faHdfYWNjZXNzIGluIGEgc2VwYXJhdGUgcGF0Y2g/DQoNCkJlc3QgUmVnYXJk
cywNCllpZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDI5LCAyMDI2IDU6MDYgUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gYW1kZ3B1L3BtOiBibG9jayBHUFUgUENJIGJh
ciBhY2Nlc3MgZHVyaW5nIG1vZGUxIHJlc2V0IG9uIGdmeDEyDQoNCk9uIDkvMjkvMjYgMDQ6MjUs
IFlpZmFuIFpoYW5nIHdyb3RlOg0KPiBibG9jayBHUFUgUENJIGJhciBhY2Nlc3MgZHVyaW5nIG1v
ZGUxIHJlc2V0IG9uIGdmeDEyLCB0byByZXNvbHZlIHRoZQ0KPiByYW5kb20gbW9kZTEgcmVzZXQg
aGFuZyBpc3N1ZS4NCg0KSW50ZXJlc3RpbmcgaWRlYSwgdGhhdCBpcyBtdWNoIHNpbXBsZXIgdGhh
biB0cnlpbmcgdG8gbWVzcyB3aXRoIENQVSBwYWdlIHRhYmxlcyBpbiB0aGUgR1BVIHJlc2V0IHBh
dGguDQoNClRoZSBvbmx5IGRvd25zaWRlIEkgY2FuIHNlZSBpcyB0aGF0IHdlIG5vdyBkcm9wIFZS
QU0gYW5kIGRvb3JiZWxsIHdyaXRlcywgYnV0IEkgdGhpbmsgdGhhdCB3b24ndCBtYXR0ZXIgc2lu
Y2UgVlJBTSBpcyBsb3N0IGJ5IGEgbW9kZTEgcmVzZXQgYW55d2F5Lg0KDQpNTUlPIHdyaXRlcyBh
cmUgZHJvcHBlZCBhcyB3ZWxsIHdoaWNoIG1lYW5zIHRoYXQgd2UgY2FuIGFsc28gZHJvcCB0aGUg
bm9faHdfYWNjZXNzIGZsYWcuDQoNCkFuZCBCVFcgdGhlIFNNVSBjb2RlIHNob3VsZCBhYnNvbHV0
ZWx5ICpOT1QqIHRvdWNoIHRoYXQgbm9faHdfYWNjZXNzIGZsYWcgaW4gYW55IHdheS4gV2hvIGFk
ZGVkIHRoYXQgdGhlcmU/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9m
Zi1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIC4uLi9k
cm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jICB8IDI5DQo+ICsrKysrKysr
KysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTQvc211X3YxNF8wXzJfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jDQo+IGluZGV4IDA3MmQ5YzRlMjAyZC4uMjViOTA4NWVh
ZDcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3Nt
dV92MTRfMF8yX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTQvc211X3YxNF8wXzJfcHB0LmMNCj4gQEAgLTIwNzgsMjEgKzIwNzgsMzAgQEAgc3RhdGljIGlu
dCBzbXVfdjE0XzBfMl9zZXRfZGZfY3N0YXRlKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0K
Pg0KPiAgc3RhdGljIGludCBzbXVfdjE0XzBfMl9tb2RlMV9yZXNldChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkgIHsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFk
ZXY7DQo+ICsgICAgIHUxNiBzYXZlZF9jbWQsIGNtZDsNCj4gICAgICAgaW50IHJldCA9IDA7DQo+
DQo+ICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9kZWJ1Z19zbWNfbXNnKHNtdSwgREVCVUdTTUNf
TVNHX01vZGUxUmVzZXQpOw0KPiAtICAgICBpZiAoIXJldCkgew0KPiAtICAgICAgICAgICAgIGlm
IChhbWRncHVfZW11X21vZGUgPT0gMSkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgbXNsZWVw
KDUwMDAwKTsNCj4gLSAgICAgICAgICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgICAgICAg
ICAgLyogZGlzYWJsZSBtbWlvIGFjY2VzcyB3aGlsZSBkb2luZyBtb2RlIDEgcmVzZXQqLw0KPiAt
ICAgICAgICAgICAgICAgICAgICAgc211LT5hZGV2LT5ub19od19hY2Nlc3MgPSB0cnVlOw0KPiAt
ICAgICAgICAgICAgICAgICAgICAgLyogZW5zdXJlIG5vX2h3X2FjY2VzcyBpcyBnbG9iYWxseSB2
aXNpYmxlIGJlZm9yZSBhbnkgTU1JTyAqLw0KPiAtICAgICAgICAgICAgICAgICAgICAgc21wX21i
KCk7DQo+IC0gICAgICAgICAgICAgICAgICAgICBtc2xlZXAoMTAwMCk7DQo+IC0gICAgICAgICAg
ICAgfQ0KPiArICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsN
Cj4gKyAgICAgcGNpX3JlYWRfY29uZmlnX3dvcmQoYWRldi0+cGRldiwgUENJX0NPTU1BTkQsICZz
YXZlZF9jbWQpOw0KPiArICAgICBjbWQgPSBzYXZlZF9jbWQgJiB+UENJX0NPTU1BTkRfTUVNT1JZ
Ow0KPiArICAgICBwY2lfd3JpdGVfY29uZmlnX3dvcmQoYWRldi0+cGRldiwgUENJX0NPTU1BTkQs
IGNtZCk7DQo+ICsNCj4gKyAgICAgaWYgKGFtZGdwdV9lbXVfbW9kZSA9PSAxKSB7DQo+ICsgICAg
ICAgICAgICAgbXNsZWVwKDUwMDAwKTsNCj4gKyAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAg
ICAvKiBkaXNhYmxlIG1taW8gYWNjZXNzIHdoaWxlIGRvaW5nIG1vZGUgMSByZXNldCovDQo+ICsg
ICAgICAgICAgICAgc211LT5hZGV2LT5ub19od19hY2Nlc3MgPSB0cnVlOw0KPiArICAgICAgICAg
ICAgIC8qIGVuc3VyZSBub19od19hY2Nlc3MgaXMgZ2xvYmFsbHkgdmlzaWJsZSBiZWZvcmUgYW55
IE1NSU8gKi8NCj4gKyAgICAgICAgICAgICBzbXBfbWIoKTsNCj4gKyAgICAgICAgICAgICBtc2xl
ZXAoMTAwMCk7DQo+ICAgICAgIH0NCj4NCj4gKyAgICAgcGNpX3dyaXRlX2NvbmZpZ193b3JkKGFk
ZXYtPnBkZXYsIFBDSV9DT01NQU5ELCBzYXZlZF9jbWQpOw0KPiArDQo+ICAgICAgIHJldHVybiBy
ZXQ7DQo+ICB9DQo+DQoNCg==
