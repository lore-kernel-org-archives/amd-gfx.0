Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE574606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r2RvcbVJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDF410F31C;
	Tue,  3 Nov 2026 02:30:52 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38ABF10F31B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKcR4MzQtm8IiKHGKX9hKKnPJjt0Zt5cvK3k3fo8XL/3SWNmGhllUJ5bP+kG50m3z/gsX4TnnoGnT+9ZqjEEIPy2tZpLrCwy18iYV4hNEBpCo/NA867GfpdoXqScpFQrrHpqtvFSypdEiOUdg/4a7xzGj79kA9mIgRzVma31t7/ci2J5Ke5sy3M/ZAxynF8myOJBXe3I/qVBF/ECGkzHqa3T1YfZh9YYGU5fsGr/EKqiX0VP1xffPdqVgZR09HhdWe3x0SqAReBTeiAuoouN/+SkHRjetBdz+dB4y0ImCwEehLT2fg6LsD4kYSoBUYKEQPP+rbe2VpEI7FUT9FBVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTn4nsSJuMyhpHZqMNVzAgSAQmDJ/Jue95A4BjqJl7Y=;
 b=taBeVQftF1PKzr9OzCipuJOqA496fYKjVuFT05tvQRZvre8+geFhXkrywZF3CUKyfGp5X587szNcncqaZPxOVfdc1J0KuvDW00uJpPT33n8zdKRmaZdPjSpJDicoljvXw0WYKdGCdNYnZlvYOL/OeErWtJGTuLMvBgEdsoSxKjRB3so2qCqBmw3p/k0lEaunDXMJsxqcVLMBPP7YMDd+9KiePPZ/OPmlenOJ5WRKAllZZLc4EEjyqeTqOn2fkqvt8EtLBzAqJMfoe/vhQ69Fe45iVhucKiybqXIhMGH86CiUnCjYXDDQONmNWdNlkRp77Va/6DkbngnsX61smtGq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTn4nsSJuMyhpHZqMNVzAgSAQmDJ/Jue95A4BjqJl7Y=;
 b=r2RvcbVJ5SL6/IU2PI4s5+wei5j1oGdFomOn6l+b1n4EZ1qQ/O4zR+I0FthswdGLz7DeYdjLKzQ3xBwH6TJ8lJhpelFN/zEsbRVGL/5goBTGBVPizI+OknlR1CqykLP9mEe4vKJ28gWlDbgkr6wU7rmDL6OccQKs2y2dOtcfYMU=
Received: from CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7)
 by SA3PR12MB208015.namprd12.prod.outlook.com (2603:10b6:806:517::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:30:43 +0000
Received: from CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd]) by CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:30:42 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Natalie Vock <natalie.vock@gmx.de>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
Thread-Topic: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
Thread-Index: AQHdaqRdn7DUxjcMkkq5Ot4RR0m0+7caygOAgADW1dA=
Date: Tue, 3 Nov 2026 02:30:41 +0000
Message-ID: <CH2PR12MB4168F265C2CD9B48811A65479C692@CH2PR12MB4168.namprd12.prod.outlook.com>
References: <20261102082915.2289352-1-perry.yuan@amd.com>
 <361f5ae9-8beb-4263-9042-b9f3c65e6fff@amd.com>
In-Reply-To: <361f5ae9-8beb-4263-9042-b9f3c65e6fff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T02:28:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4168:EE_|SA3PR12MB208015:EE_
x-ms-office365-filtering-correlation-id: 7108590c-909c-4222-93b0-08df39527503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261102123227099003|38070700021|261021121427099003|4143699003|11063799006|5023799004|56012099006|261009220027099003|261028144727099003|261009223027099003|261009223327099003|261009221727099003|261009221227099003|261026140227099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: RodF7QqY+ICNWqN68HbyT2pXdliSRyocHqJvibQEFoLqbTGtzjvN14AWeuiaFMRrWmXFdYoYa6Io3s+doPT6jLUqNW/Be841ol9124i4/sd07RLc2ifua2T31EK4sKFOLkazHuO4xlxq52oxdrKG6P4lF2nsuueQ0EuyQHQUrchHs/XQqUOUBr3LaLrVrBx6Icg6Yy9PWuDI2SxwLxDMdA0P+xoYsDO3RfJIek6MM0mw952Qo2P11myR7BNYL/qevkyUCtce3NgLMb6RlPdlEJUonRMtFhH1E3p5edY/iExUQPkS82tgRWtzXlwAvrf2xgzGGLi8aannSJTD5CJa9yoJTs74sjqyL6Kh81rE50BWMM+bOt5Yv/dy6hU824qIxE9BhRCMddS6Csa/H5TTfI593wwYN78qvfnRuQXKjO5wQMGYOev8wwLExu+LkfLCx+hYWh6Y2TZrJSuwUYP3YuTr84qfaQlZUt1SwCLVQEkWoQdFosjkaDdP9jvpnWufZSv/+YNLLbu7ezbXVxpdGS7uUUqVOB6ni8FLcG24RSbGImS1kN3919fD2S6nV5xNZx7EFF4jd6MbRqljD8b3lebRB/qiaX2tDv3Z3ll7UDHaqk1ZwBvQqnvdIK2KQSeV7BN/NlfL/14T33+DXynpLklgpf9tDXXGAk4uytHpFOztZwhtKSQF6lmd6ktBfKrR/ZcwhitQWSm6e/lMQziLcZx5LJQQ4odu16WzNRri1MQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261102123227099003)(38070700021)(261021121427099003)(4143699003)(11063799006)(5023799004)(56012099006)(261009220027099003)(261028144727099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NKQjJiWUJqa0o5N3pKWExaLzRHaEwvRHEvUnJlbGJ2dktFYlBJcUplS2pk?=
 =?utf-8?B?Sis5dGVsaG5TVnFnR2F0dEpzS3JsYlhvYVNSaGxXdnlqb3JNOVBBRlFxQnZL?=
 =?utf-8?B?VDBzWEc4a1B6Uit2TWJSanlBUWhjWjFrQWdFc0FHYm9Rdmdab3hvclpwN3Jl?=
 =?utf-8?B?dCt4U1R2a2M2dnV1c3Z4NkdMcnRidzJ0OFQxNnVVa3pieGVDcDc4ZWFsTk83?=
 =?utf-8?B?RzFueGtlWm9Oc3hrT3NDUEhYUVovMStqdHVjbGpNS3JnNVhSYVFJRUJXcmUv?=
 =?utf-8?B?NGliUEUyc2pZTVNraVFKZHdock5GQjRYcHVJSWw0TDlXc2s5YVZSbG16UjlE?=
 =?utf-8?B?S3NoOXI0MC8vSElrYlVPcTRyWHRudG03bFhVdTVmY29FL0prMzNnRkdBWXNB?=
 =?utf-8?B?S2ZMVmtueVE2cHd1N3JtN0RhSFNjOUE2R1oyVm9QcHE3MElNaFlYR0NBOW5I?=
 =?utf-8?B?STkrNkM0b0pQVDUwUTYyVTR1NEMwU2xJUGxPL3FqWWxSOUlnQjBrbFAvZjVr?=
 =?utf-8?B?Ni9WVnlxdmxvN005UzJobGZoSUZ6a3FKeVFOQ0tHMEdWWDJoak1wclI3MUNB?=
 =?utf-8?B?WmJnTmFlc3VBY2xmZGJ6em9Gdi9RbG94L1pxQ09YVWVrU2QwcVYvTmh1RDAy?=
 =?utf-8?B?NWI4L3FuUnpnelBWaW9HTGxPcnV2clZ4Z2hPTXovb3RLV3Z0QWsyNUhuQzR3?=
 =?utf-8?B?NXpQampQOXBaRkJaRTFFb3p6Zk1rV3pWZHZjVUgrdTIxTTl4c29hRWFST0JV?=
 =?utf-8?B?azRsaG1NWTR6Zm50UjJ1bWYrT0o5TThOVFhPT2tHZ2paN043OUpDcit2Vk1X?=
 =?utf-8?B?TXNkYlhVOXgzUnVhbkNwU2tCQWZXeGczR2VBNXNoVmh0Y090YVR5TUJ1VTNo?=
 =?utf-8?B?cnpSL2VlelRDS1o4d1ZUd05IKzVrTTh5S0k3OS9GcGdkVXV2c0pDbEI1c0hS?=
 =?utf-8?B?RmcvNXJNQjd6QXJpOTF3OWhiV0F2ZHF2eTg1ZFJvTTY5M3FBYnM3L2MyOEVW?=
 =?utf-8?B?MXJUUml5Nlc3alBOSzJpQ0l0eDAvOXl0dGs5cjVxbFdNZm9VZ3FNcVMycjR1?=
 =?utf-8?B?eVMzUzhlMmErVFdkRXNKaWtkMjl6VlN3QmZGV2E2N2hsSDNKc0JVTWFDQnBL?=
 =?utf-8?B?U1lndnZxZkEzbXErVTd2VTZ6ajJNTkNzUkNXdENkdk5wNE5hengrYk1iSUhw?=
 =?utf-8?B?RDlKWFhGNnZ0WnA1WVdHMXN4ZjFrNTFobFIrcGNCSENRTnhhZURZdEhXN1lH?=
 =?utf-8?B?QVB3YzlhbjhWaWpLc1F5SFd5Z1RtZ0twQUdZWG0yS09tNm9RZWtWQVVkQ1Bo?=
 =?utf-8?B?SGNKWXdFbGRqcU95bFl3TkQ4ZDFhMGk3VE1oR3JyZEFVZUJaV245UnZwcmdk?=
 =?utf-8?B?WFJNdFFYQUFId3NqVmpHc2QwWUpOTUxENHNFaXE0UEV5UFh3QlZyaW1LdGU5?=
 =?utf-8?B?Sy9IWTBFcFU2bjZiTGdEQ09UemNjWFMyWk5KaTgydGl0SmtWYTI4amI5WDM3?=
 =?utf-8?B?QVN0a1RmV21pVGk2NXJubHV0U3NtTm5iNDYxUHlxWFZsQVRMTUFWb0lxRE5t?=
 =?utf-8?B?VnNkc2o2ZG82TVBrSGtyVmw2Z3BlSERuOFRkeDVXVzR6a25JY0ZqWGtETkE0?=
 =?utf-8?B?bllwNmVCL3NlY1B4N0diYzU2K3FFRnpSZ0FEMkZWQjc0dGk4TjYyTTJFdVpl?=
 =?utf-8?B?eURpdnJVaG5WZi9Yak1ZVG9DWVFGdWFrMzAzT2VQTDVybEJPdnJ4WVpSQlpJ?=
 =?utf-8?B?SHc2Z05HUkMwZ0N2U3pTd0JjOUtKT0NWOFFJb3FnSHBwKzVpN0FUR1NxcTBE?=
 =?utf-8?B?NGwyTFlXdFo3anhCWmFmeENDUDA0TDlJVjJpK3lWbXFGb2grazlJZitDdUc0?=
 =?utf-8?B?L3Nwd1JsYXAwVGZkWExmVTQwdkt1YXMrbVBVSTBiQVFPdmhDckY3NUxkVTZo?=
 =?utf-8?B?WGVjRmNYdy9QMXJiTWVGTkQ3YzZndlZqSU9TNlVlbWRxdStPYm9UZzJ2ckpx?=
 =?utf-8?B?ay9JajNBUTNjc3RWSEM3WUlEWk9Oc3FieVp1akl4TkdoSitoQXhaYlBGdW1X?=
 =?utf-8?B?Uk9OK0NOVUZIQ3ExU1lTVER0QnB6MklPS0RDeENOU3pXTXhxWE1kdXdVWEov?=
 =?utf-8?B?Z0VQUnR0QUk3ZWxsM00wSmJmbDJzUWpUeUlkZmNOdHo1VHlqU3p5dVdyV0dP?=
 =?utf-8?B?YWpRNHBoZ3N0RTEya2EzNDEwMzRkTkoxQ2xXYlE1WndvWDlHS2tQSUVUeUFO?=
 =?utf-8?B?OFRxRlJuYnpSL1Z2elcwRTBJQnlCYUx2ampxNTUyYkVEaG9PQlM3MEY4K2du?=
 =?utf-8?Q?rQsItlcjW8e/FyPOm+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7108590c-909c-4222-93b0-08df39527503
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 02:30:41.9731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekOqRMFOYRKnu7S4GJ1j5AxI/uG5n7wsK57StLdS7jcV0LQWTdEozeLI9mFQra2Blv5h/fRIH58NzXN2DAQRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB208015
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyLCAyMDI2IDk6NDAgUE0NCj4gVG86IFl1YW4sIFBl
cnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTmF0YWxp
ZSBWb2NrDQo+IDxuYXRhbGllLnZvY2tAZ214LmRlPg0KPiBDYzogWmhhbmcsIFlpZmFuIDxZaWZh
bjEuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogdmFs
aWRhdGUgdGhlIHNpemUgaW4gR0VNX1VTRVJQVFIgaW9jdGwNCj4NCj4gT24gMTEvMi8yNiAwOToy
OSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBOb3RoaW5nIGxpbWl0cyBhcmdzLT5zaXplIGluIGFt
ZGdwdV9nZW1fdXNlcnB0cl9pb2N0bCgpLCBvbmx5IHRoZQ0KPiA+IGFsaWdubWVudCBhbmQgYWNj
ZXNzX29rKCkgYXJlIGNoZWNrZWQuIEFjcXVpcmluZyB0aGUgRE1BIGFkZHJlc3NlcyBmb3INCj4g
PiBhIGh1Z2UgcmFuZ2UgYW5kIGNsZWFuaW5nIGV2ZXJ5dGhpbmcgdXAgYWdhaW4gd2hlbmV2ZXIg
aXQgY2hhbmdlcyBpcw0KPiA+IGV4cGVuc2l2ZSBlbm91Z2ggdGhhdCBhIHN1ZmZpY2llbnRseSBs
YXJnZSB1c2VycHRyIGNhbiBrZWVwIHRoZQ0KPiA+IG1hY2hpbmUgYnVzeSBtb3JlIG9yIGxlc3Mg
aW5kZWZpbml0ZWx5Lg0KPiA+DQo+ID4gT24gdG9wIG9mIHRoYXQgdGhlIGludGVyZmFjZSBpcyBp
bmNyZWFzaW5nbHkgdXNlZCBhcyBhIHJlcGxhY2VtZW50IGZvcg0KPiA+IHJlYWwgZHJpdmVyIG9y
IHVkbWFidWYgYmFja2VkIGFsbG9jYXRpb25zLCB3aGljaCBpdCB3YXMgbmV2ZXIgbWVhbnQgZm9y
Lg0KPiA+DQo+ID4gUmVqZWN0IGEgemVybyBzaXplIGFuZCBhbnl0aGluZyBhYm92ZSAxR2lCLiBU
aGF0IGlzIGZhciBtb3JlIHRoYW4gYQ0KPiA+IHRlbXBvcmFyeSB1cGxvYWQgYnVmZmVyIG5lZWRz
IGFuZCBzdG9wcyB0aGUgaW9jdGwgZnJvbSBiZWluZyBhYnVzZWQgYXMNCj4gPiBhIGdlbmVyYWwg
cHVycG9zZSBtZW1vcnkgYWxsb2NhdG9yLg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPg0KPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3Igbm93Lg0KPg0KPiBXZSBt
aWdodCBuZWVkIHRvIGFkanVzdCB0aGUgbGltaXQgYmFzZWQgb24gY3VzdG9tZXIgZmVlZGJhY2sg
YW5kL29yIGRpc2FibGUgaXQgd2l0aA0KPiBzb21lIGRlYnVnL3dvcmthcm91bmQgZmxhZy4NCj4N
Cj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KDQpTdXJlLCBXaWxsIG1ha2UgYSBmbGFnIHRvIGFs
bG93IHVzZXJzIHRvIGRpc2FibGUgdGhlIGxpbWl0Lg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcg
JiBmZWVkYmFjay4NCg0KQmVzdCBSZWdhcmRzLg0KDQpQZXJyeS4NCg0KPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA0ICsrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+ID4gaW5kZXggYzk4MmQxMDI2MTRlLi4zNDg2
OTMwMjM1NjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jDQo+ID4gQEAgLTU2Niw2ICs1NjYsMTAgQEAgaW50IGFtZGdwdV9nZW1fdXNlcnB0cl9pb2N0
bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiB2b2lkICpkYXRhLA0KPiA+ICAgICBpZiAoIWFj
Y2Vzc19vaygodm9pZCBfX3VzZXIgKikodWludHB0cl90KWFyZ3MtPmFkZHIsIGFyZ3MtPnNpemUp
KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiA+DQo+ID4gKyAgIC8qIFVzZXJw
dHJzIGFyZSBmb3IgdGVtcG9yYXJ5IHVwbG9hZHMsIG5vdCBhIGdlbmVyYWwgbWVtb3J5IGFsbG9j
YXRvciAqLw0KPiA+ICsgICBpZiAoYXJncy0+c2l6ZSA9PSAwIHx8IGFyZ3MtPnNpemUgPiBTWl8x
RykNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gICAgIC8qIHJl
amVjdCB1bmtub3duIGZsYWcgdmFsdWVzICovDQo+ID4gICAgIGlmIChhcmdzLT5mbGFncyAmIH4o
QU1ER1BVX0dFTV9VU0VSUFRSX1JFQURPTkxZIHwNCj4gPiAgICAgICAgIEFNREdQVV9HRU1fVVNF
UlBUUl9BTk9OT05MWSB8DQo+IEFNREdQVV9HRU1fVVNFUlBUUl9WQUxJREFURSB8DQoNCg==
