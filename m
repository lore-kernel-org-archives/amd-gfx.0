Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D24DC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 07:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0581810E8C6;
	Thu,  8 May 2025 07:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YoKg4iIj";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7F710E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 07:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAuxOL0yhh7MUp32PRCO+z69exI6/DasXxQeFp0QcWvkT81wFgzV0Rjlwhc5C2FdVPkeHX1T8e7nkNBeqXI1DXymUYDuJaVH05H1fCjiqrsz6sfB+RPeQxwgJnTe16REVzSaZrh4OVlzwej96KwebcVjSGteS70SF9vTReS+nWLyVGWrbheGkaqbihPajq8AoUUy4kyzRF8iGHR2sFHMgMnY2Qlz/mkYBHSVvDuy140u8KbEWQsNhDUowZ8RRGzb86iairHzwaOp2lmG1IOk7hcjf5iruC7wqrckGDu1YwBNohuXDINYT9/h26FTxDfZTAjMpmbTXXIgHqusaZZnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRIrHpd87vphj/o9QLqNrCGE/g96CcEBJp4tp+PFG3g=;
 b=IAJQ2yASYF/pxQTVLs+UWgRaE7ajrXqcIFsAgJXUfv/I+4Lvr7cQjfDiC7AFpK3ypU+4IsTaonsXk6KoAv1h4r2PUmqONc52/26lMWm8c9qM5AiFsvDR1hMjt0iDd8u37Enua9ecbtknGGSQQ1flUaIai2+Rd1++0eTbfKp0jsK2BNAxRexx7FgMPSCUAST2JkbXKv43QAha6gRi4Pgqjf1X3tBj737pKWQapqpfzeJhMv9OFw1PrJrUCW4EhF0gwV/vIwvtq6xBpTKuTJqoJ16lmIUA5ZxIz/GM/SS/r3CG0olFzRyv1AYuzXakdLOhuAPxnScA7KOeQFfscOfeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRIrHpd87vphj/o9QLqNrCGE/g96CcEBJp4tp+PFG3g=;
 b=YoKg4iIjCa6ezf3Cw9hJM3LqW8qP8YN1bwho8e1vYvE0k2oaFiNhTp+zK30ERNPKLdZD3QFTtSy4nyPH29a0LH0A+qMU0wJtAfo/JEDlqD8WsmQRRFtmR5D7WL9/Zn/3VApGYAG3aIihB0S188uY6GSGMN6OnV6KkMV/BFEEsNI=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 07:03:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 07:03:38 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
Thread-Topic: [PATCH v2] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
Thread-Index: AQHbv9sXqub/ULNBF0SUtPs7DeSJ8bPIS9Qg
Date: Thu, 8 May 2025 07:03:38 +0000
Message-ID: <BL1PR12MB575323CE3A61B86ADDC8B3AA938BA@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250508053538.57744-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250508053538.57744-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=223cef6b-295c-4137-9d8e-662b9dca87fd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T06:52:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CY5PR12MB6552:EE_
x-ms-office365-filtering-correlation-id: c877fa8d-1d9e-4102-a2be-08dd8dfe7548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?NXI5cENEaFlSK0pXRDN5c2Y5WVlLeE11ZlZob3NWeFZQR3FOaldRL1lybC8r?=
 =?utf-8?B?d2FiWFlDaUJEQXNVS1E3Z0plWG1abWFPZmZVQ1ZlSEVSWWF6cTFEL2VHcWFa?=
 =?utf-8?B?dHo0Q3pHTnhGSkhnTnNqYU4waEZkb20vL0hlZXFEbEpmK0VvcXZaa2tkNUl4?=
 =?utf-8?B?ZlBJQXVTenNNN2pOMkpuTjhwNlVNdWJBemt2enlHRlBsUmdQVFVmOUFBY1k3?=
 =?utf-8?B?VUZCQkROWDRrM0JJcUVWUE5Mcjh6UlV6YTdpTEdhTG9Ba0xRZlI3aGNJNDdJ?=
 =?utf-8?B?SGRFM0lNb2dNREJnNENLbkdlS044LzNVbFE5UWg4b2R2NFpOVVpSV05DbitM?=
 =?utf-8?B?eHVzckRXRVRYUzY5ZnVDTGREZmNNOXNtWGw1Q1cyL2ZSakpTczljUkgrSjVK?=
 =?utf-8?B?MjZQaS9GZk8yYVdOUUhWN0xIREc5UzFSMEcvRHM3TzZrNUdnMkErOGNCMENJ?=
 =?utf-8?B?SElWNzhoNzR1ZnMvd2hmblVCcFlYb01pWjRQSUFkT1U2R1ltU1EvWjhVdGRE?=
 =?utf-8?B?VDM2TFh6VkhWNnBnU1RMM2Vxb255ODFWc1VmaXl1dGJHb2UyMHRhVzhFN2Np?=
 =?utf-8?B?Rkx4bW1TY0YzUmUvVzJYZUhuOUltOEZRbG1TcUlhZFBJZ0ZEd09UL3lxWWMz?=
 =?utf-8?B?NlR2a3BqdndVbHdmUmxnM3FnbEpEUlRzWnIyUVBtR09vWW1MeTNTdDFBK3px?=
 =?utf-8?B?dGxmS09EUERETjBTVWtSWDZLeFFoUmRoVVA5MWt3c1didDRkN3FackpQWXlN?=
 =?utf-8?B?WGh1Q04wTXR2cTIydHVmWitXeGtKZWI0R3BJdnBnSVhZdHpKekZhbHdWTE4x?=
 =?utf-8?B?eDg3eEJYWExIRHBVQkhOMjZzRDNsQ2xvK0YwK3huVWRlUkpMZ1RRRW1kd0pK?=
 =?utf-8?B?c0Zoa2JOd3lWMzVLRjdOM1pxSytoRDFWOEtOSTdNOVBQVVdESGxyV3VzbHZF?=
 =?utf-8?B?Ni8rT3VDNzFkWEI3U3FTTGd1ekZ0WWRXZnFTQWlTZm9EOENiZ0IrUW9wSVhY?=
 =?utf-8?B?aEJkT0tZRXBpY2dKbHVZUmFaVUJqWkpGR2FCUVBGWHllUEZSakl3Y1d1bWtB?=
 =?utf-8?B?emlRQlB2bVRZS0NXQmZ6aGR2aUZMTHpqVlpZWmhuT2t6SVhWSkQrMDZBTm83?=
 =?utf-8?B?a25mL1FVaHRlMG5MRkdPS0laV2NLMm50eTY2MFVwTi9DSktUSDNDbk0rMWUr?=
 =?utf-8?B?REtXV3czTTUwUWZmcGJqUmR6b3ZpQWg2WnQ4NW1tWDhqemlWM0dDZk1UeTU3?=
 =?utf-8?B?UlpLTHgwSHNRc2ZrdDFYZEF4eVBOTWlvN29JTVNuL3JmamNVWkNwalNhQjZB?=
 =?utf-8?B?ZytIREJUTlR1NGpPZCtsUmtuQWRTS2krbHJSUlJrM0pLbU02eHFockIxdVp4?=
 =?utf-8?B?U3pCOXRzVUJJd0pEaUw3dGFIZ3hLdE9EQmpXeE5tUlgrRnVvbE13MmVTRU5R?=
 =?utf-8?B?QlZFc2w4aC9EcHRjcEI1czdyVlJ6STUwYjUyd09XbmJqZjNiaFUwaGt3a0c3?=
 =?utf-8?B?RjYvTmRNdVppMkw4WUd6NFBtOHBrUEtVTUFtandRYS9JVlRTVXpYWUViVUsz?=
 =?utf-8?B?ak1vbnQ1Qnk2OUY1UXh5dmhzb0RFd2pieXJVT01EYjFoR0wrNUN4c1FabldN?=
 =?utf-8?B?UGw5WmRISG8xY0xwWUtGT204RmtTeDE2SG14VEZEL2lYY0ludW5GQzhMdnY1?=
 =?utf-8?B?Q1lJQnk2Q0V1TExmMS9HM3EzUS9NeTFHcE05T2U0V0hwVjl4YnRyYUVuU0kz?=
 =?utf-8?B?Mnk1N1BVQ0d5R2s0UlB1aHFOcDdVOE1MWVNxbzU2WEdjWnVENEk3TFhNVnpD?=
 =?utf-8?B?UE9WZ3h0b0NaVCtkNEprTUxVN1RSZmdkbW5pNWhMS3FpVk9xRm43NHV1YVpS?=
 =?utf-8?B?aHhJbkllYU02dzBwR2V5ayt2bTk2dDAwc2FUR0s4TjNOcFI4dGdEYVFOMjgy?=
 =?utf-8?B?WHRYS3JCbWV1bThNWklyNXB4UnRnelpPUjEwL1hFQjl2TnNCN0N6a2RVVEND?=
 =?utf-8?Q?uuoq96KYdVW+8R4+8NQo5vy6QWTios=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjY5eDJSRGt2RzNiS05SL25PRVRBeGJJM05TWk1OT0duRUZ4bkZ3WWRRbU9n?=
 =?utf-8?B?elpaRVk3bXlCNHdmajZvY3ZyUHF1clNkNW5rZWliOVBYMWpTY3dzQzZkZFdH?=
 =?utf-8?B?dEFaQTBCSGxxK2VrZkJHM3FjL2FRaHNPSU04Z2I3bnBlaENub0pqR3YzQzB5?=
 =?utf-8?B?SGhDVEpEN0J3YUtyV2ZsUmJVUms0TTQxTDFMckxteVNNNHhpYTEreXNHT3BG?=
 =?utf-8?B?Mm5tUmNXMkhRZWVYNlFwVDYycXNHbkN5eG5idGphdVJKNEQ1Rm4xQUZmMlpC?=
 =?utf-8?B?ekdnZ0RuczIvcDUzL0xQNUFRWFFZUmNWcXBzYWFZSUZNS1VuUzM2TW1qSk95?=
 =?utf-8?B?aVZuNzU3VXpjT3l4c29hNDZ4TDdyMmg0RlZCdDhOaWd0VnFNOHRvR05UMU52?=
 =?utf-8?B?b2o1MkJSdUk3emNGTmN3aGwxYTQvcjlXWXZ0STdyUmt0WGc1TjB1UnhNeWtj?=
 =?utf-8?B?Z0FiMmxaWmszRTQ0L3pWMllFQWh5QmNQdzFNY0Q1RFJSdURsaGJnNVUzUDR0?=
 =?utf-8?B?bGp0WllYUzlCME1lVHh0VlE5RTFUcTQxek1nVHpBT1haQkozVS9yQ1ZhL0R3?=
 =?utf-8?B?L3J1dC9NQ1UwbGMxNFFoSTNNQWRYWWdMYXI1dTdOd0M1d28vWUpGeUlrRFdS?=
 =?utf-8?B?ejhwcTZGTEJtYzBnL1VQb21PQXA4dE93ZmJNeWRZRHRXMUZGUEFlblNKWnhV?=
 =?utf-8?B?NHZGSzdFS2JjNG1XbUVNWllJMy9TcHprSlNMeFFSNmx2cXZ3RXRYS2dtdFBT?=
 =?utf-8?B?ZVMxL1dJaGpZN24zTy9VYnJzR0o0TzRtRzhtbzZZMlpmYW9ZV3hZbXNvZi9t?=
 =?utf-8?B?UE5EU0sxWmZUN1pLMXFrNlNRdFhRK2lwdnpBcFZLKytZRW5SWWsyd2ZTRVFy?=
 =?utf-8?B?YmtBeFF1ZlFCU1ltcFAzcE4rNU44R1VuSW1ZeFprWFhlaEdLc3Q3d3Vab0l4?=
 =?utf-8?B?aTltSEowSDREMUcvcUtjZ2lEUHIzb3lXNE1DVTlkY3p0eGE4SFFQREpSMTBC?=
 =?utf-8?B?Qmp2a2l3QWEwdTRNTDV1d214Z3g1bnlkaU81WnlPZTJTa1B1NDJTYmNrSDUz?=
 =?utf-8?B?YnZFYURialhrKzBMZnYzWDBVTE9qTEZuaGt4eDQ0TEJDc2NkckNuZUY0SzBv?=
 =?utf-8?B?N2hZZEJ3THFaWDVVd1d2Ulo3S216YzVvK2RnRmxhdjN2TzlaRDZoM2tNTWQw?=
 =?utf-8?B?TFJOUXEwWlBLQzJPbDZxTk00SytoOEp3dnNoUGFwRE5hb1Y5TWNlZ2tvKzVm?=
 =?utf-8?B?OEdLMUNjR2dOVGgyRFVwVThuTUlZcys3SWY0Y0VaRnFOellQVWF5L1RRbW1j?=
 =?utf-8?B?VGxHZDZyalp2RWlQWUxBY1VUanBMQlNDMDBsckJiNmhJUTloS01BektOcmVi?=
 =?utf-8?B?OWhSK3ZBTlRVdmFRSkN5cWRHTGNIQXF2aEJ2Z1NQalNaNzVOZEw3NldYb01C?=
 =?utf-8?B?QTZvU0k3eGI0cGpYNkVQZFJMR2Q1RmsyM2JrUE5iN28rUlBocmN0andrTlU2?=
 =?utf-8?B?T1BKMnRhbzk1VzFINzVDS1ordWpIL0VScTlNYWxidWtYUVprdjd2aTVTS09v?=
 =?utf-8?B?ejZSZjFQRTBuNTVHZzF3U05qQmNuNFFiSGZXL0w5WlV4UW5QOFV0U200V2FH?=
 =?utf-8?B?bGxiNWFqRC9KZ3pyNFhQa2Q3Kysrbng3YWFTVGtQT2RXbWU4V1lWWWorY3ky?=
 =?utf-8?B?MnREUmFkeHFDYkVlT21lRU05WHFTYkNUSnZhQlo3bm15cHE5Q2FWdWJHWXNp?=
 =?utf-8?B?TnJXaTdCeHkvZjNVdXVjL1ZjcHpWODI1L21TL0lENXZBQXNYUzR2VjRHd3c1?=
 =?utf-8?B?TzBmQ1hPL0JrYVdaZUlwZG9HbGQvUlBDWUdGaStqeFAvQnM2NXFCY1M0bVZp?=
 =?utf-8?B?TFFjbnN0OENrUFRKL0pySUJhbVlRdXhkT3IrRnJaMGx0N3VtTHR2d3NCOHFN?=
 =?utf-8?B?YVhQZm5iTStmMm9yWGNXVDRvaFpXYWQwM0U5WDRqNVpHVTdiYkZqajhYU2tX?=
 =?utf-8?B?aXc1cVk0RG9yaS9RcjJsUmJKNUtTKzRRV0svaVU2UnZFRXRKVktZRXEraEEv?=
 =?utf-8?B?UFFWNXpyRUxrSXJER0kwR3Y0bkUvSUdzZ0trRUdmWUFxVk9nejRQQ3RFSU5i?=
 =?utf-8?Q?ZkMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c877fa8d-1d9e-4102-a2be-08dd8dfe7548
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 07:03:38.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFa/fY9T2MyVa7IZluJu7dTXFNtvZ4ybvIIfK0dmOuUofU8Ly8WHzGW0YuU0xDRKd7r+VCGXur2m5aC+exlWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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
Cg0KUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZYWRhdiwgQXJ2aW5kIDxBcnZpbmQuWWFk
YXZAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBNYXkgOCwgMjAyNSAxMTowNiBBTQ0KVG86IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5L
aGF0cmlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFkYXYs
IEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgWWFkYXYsIEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IEZpeCBOVUxMIGRlcmVmZXJlbmNlIGlu
IGFtZGdwdV91c2VycV9yZXN0b3JlX3dvcmtlcg0KDQpTd2l0Y2ggY2FuY2VsX2RlbGF5ZWRfd29y
aygpIHRvIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIHRvIGVuc3VyZSB0aGUgZGVsYXllZCB3
b3JrIGhhcyBmaW5pc2hlZCBleGVjdXRpbmcgYmVmb3JlIHByb2NlZWRpbmcgd2l0aCByZXNvdXJj
ZSBjbGVhbnVwLiBUaGlzIHByZXZlbnRzIGEgcG90ZW50aWFsIHVzZS1hZnRlci1mcmVlIG9yIE5V
TEwgZGVyZWZlcmVuY2UgaWYgdGhlIHJlc3VtZV93b3JrIGlzIHN0aWxsIHJ1bm5pbmcgZHVyaW5n
IGZpbmFsaXphdGlvbi4NCg0KQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBh
ZGRyZXNzOiAwMDAwMDAwMDAwMDAwMTQwIFsgICswLjAwMDA1MF0gI1BGOiBzdXBlcnZpc29yIHJl
YWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlIFsgICswLjAwMDAxOV0gI1BGOiBlcnJvcl9jb2RlKDB4
MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlIFsgICswLjAwMDAyMV0gUEdEIDAgUDREIDAgWyAgKzAu
MDAwMDE1XSBPb3BzOiBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNClsgICswLjAw
MDAyMV0gQ1BVOiAxNyBVSUQ6IDAgUElEOiAxOTYyOTkgQ29tbToga3dvcmtlci8xNzowIFRhaW50
ZWQ6IEcgICAgIFUgICAgICAgICAgICAgNi4xNC4wLW9yZy1zdGFnaW5nICMxDQpbICArMC4wMDAw
MzJdIFRhaW50ZWQ6IFtVXT1VU0VSDQpbICArMC4wMDAwMTVdIEhhcmR3YXJlIG5hbWU6IEdpZ2Fi
eXRlIFRlY2hub2xvZ3kgQ28uLCBMdGQuIFg1NzAgQU9SVVMgRUxJVEUvWDU3MCBBT1JVUyBFTElU
RSwgQklPUyBGMzkgMDMvMjIvMjAyNCBbICArMC4wMDAwMjldIFdvcmtxdWV1ZTogZXZlbnRzIGFt
ZGdwdV91c2VycV9yZXN0b3JlX3dvcmtlciBbYW1kZ3B1XSBbICArMC4wMDA0MjZdIFJJUDogMDAx
MDpkcm1fZXhlY19sb2NrX29iaisweDMyLzB4MjEwIFtkcm1fZXhlY10gWyAgKzAuMDAwMDI1XSBD
b2RlOiBlNSA0MSA1NyA0MSA1NiA0MSA1NSA0OSA4OSBmNSA0MSA1NCA0OSA4OSBmYyA0OCA4MyBl
YyAwOCA0YyA4YiA3NyAzMCA0ZCA4NSBmNiAwZiA4NSBjMCAwMCAwMCAwMCA0YyA4ZCA3ZiAwOCA0
OCAzOSA3NyAzOCA3NCA1NCA8NDk+IDhiIGJkIGY4IDAwIDAwIDAwIDRjIDg5IGZlIDQxIGY2IDA0
IDI0IDAxIDc1IDNjIGU4IDA4IDUwIGJjIGUwIFsgICswLjAwMDA0Nl0gUlNQOiAwMDE4OmZmZmZh
YjFiMDRkYTNjZTggRUZMQUdTOiAwMDAxMDI5NyBbICArMC4wMDAwMjBdIFJBWDogMDAwMDAwMDAw
MDAwMDAwMSBSQlg6IGZmZmY5MzBjYzYwZTRiYzAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwIFsgICsw
LjAwMDAyNV0gUkRYOiAwMDAwMDAwMDAwMDAwMDA0IFJTSTogMDAwMDAwMDAwMDAwMDA0OCBSREk6
IGZmZmZhYjFiMDRkYTNkODggWyAgKzAuMDAwMDI4XSBSQlA6IGZmZmZhYjFiMDRkYTNkMTAgUjA4
OiBmZmZmOTMwY2M2MGU0MDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMCBbICArMC4wMDAwMjJdIFIx
MDogZmZmZmFiMWIwNGRhM2QxOCBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiBmZmZmYWIxYjA0
ZGEzZDg4IFsgICswLjAwMDAyM10gUjEzOiAwMDAwMDAwMDAwMDAwMDQ4IFIxNDogMDAwMDAwMDAw
MDAwMDAwMCBSMTU6IGZmZmZhYjFiMDRkYTNkOTAgWyAgKzAuMDAwMDIzXSBGUzogIDAwMDAwMDAw
MDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjkzMTNkZWE4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwIFsgICswLjAwMDAyNF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAw
MDAwMDA4MDA1MDAzMyBbICArMC4wMDAwMjFdIENSMjogMDAwMDAwMDAwMDAwMDE0MCBDUjM6IDAw
MDAwMDAxODM1MWEwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWYwIFsgICswLjAwMDAyNV0gQ2FsbCBU
cmFjZToNClsgICswLjAwMDAxOF0gIDxUQVNLPg0KWyAgKzAuMDAwMDE1XSAgPyBzaG93X3JlZ3Mr
MHg2OS8weDgwDQpbICArMC4wMDAwMjJdICA/IF9fZGllKzB4MjUvMHg3MA0KWyAgKzAuMDAwMDE5
XSAgPyBwYWdlX2ZhdWx0X29vcHMrMHgxNWQvMHg1MTAgWyAgKzAuMDAwMDI0XSAgPyBkb191c2Vy
X2FkZHJfZmF1bHQrMHgzMTIvMHg2OTAgWyAgKzAuMDAwMDI0XSAgPyBzY2hlZF9jbG9ja19jcHUr
MHgxMC8weDFhMCBbICArMC4wMDAwMjhdICA/IGV4Y19wYWdlX2ZhdWx0KzB4NzgvMHgxYjAgWyAg
KzAuMDAwMDI1XSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyNy8weDMwIFsgICswLjAwMDAyNF0g
ID8gZHJtX2V4ZWNfbG9ja19vYmorMHgzMi8weDIxMCBbZHJtX2V4ZWNdIFsgICswLjAwMDAyNF0g
IGRybV9leGVjX3ByZXBhcmVfb2JqKzB4MjEvMHg2MCBbZHJtX2V4ZWNdIFsgICswLjAwMDAyMV0g
IGFtZGdwdV92bV9sb2NrX3BkKzB4MjIvMHgzMCBbYW1kZ3B1XSBbICArMC4wMDAyNjZdICBhbWRn
cHVfdXNlcnFfdmFsaWRhdGVfYm9zKzB4NmMvMHgzMjAgW2FtZGdwdV0gWyAgKzAuMDAwMzMzXSAg
YW1kZ3B1X3VzZXJxX3Jlc3RvcmVfd29ya2VyKzB4NGEvMHgxMjAgW2FtZGdwdV0gWyAgKzAuMDAw
MzE2XSAgcHJvY2Vzc19vbmVfd29yaysweDE4OS8weDNjMCBbICArMC4wMDAwMjFdICB3b3JrZXJf
dGhyZWFkKzB4MmE0LzB4M2IwIFsgICswLjAwMDAyMl0gIGt0aHJlYWQrMHgxMDkvMHgyMjAgWyAg
KzAuMDAwMDE4XSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMCBbICArMC4wMDA3Nzld
ICA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxKzB4MWYvMHg0MCBbICArMC4wMDA1NjBdICA/IF9fcGZ4
X2t0aHJlYWQrMHgxMC8weDEwIFsgICswLjAwMDU0M10gIHJldF9mcm9tX2ZvcmsrMHgzYy8weDYw
IFsgICswLjAwMDUwN10gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAgWyAgKzAuMDAwNTE1XSAg
cmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIFsgICswLjAwMDUxNV0gIDwvVEFTSz4NCg0KdjI6
IFJlcGxhY2UgY2FuY2VsX2RlbGF5ZWRfd29yaygpIHRvIGNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygpDQogICAgaW4gYW1kZ3B1X3VzZXJxX2Rlc3Ryb3koKSBhbmQgYW1kZ3B1X3VzZXJxX2V2aWN0
KCkuDQoNCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpDYzog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IFN1bmlsIEto
YXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBcnZpbmQgWWFkYXYg
PGFydmluZC55YWRhdkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXNlcnEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycS5jDQppbmRleCBhZmJlMDExNDllZDMuLmM3YzkyN2RiMjRhYiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KQEAgLTMwMCw3ICszMDAsNyBAQCBhbWRn
cHVfdXNlcnFfZGVzdHJveShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludCBxdWV1ZV9pZCkNCiAg
ICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqcXVldWU7DQogICAgICAgIGludCBy
ID0gMDsNCg0KLSAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrKCZ1cV9tZ3ItPnJlc3VtZV93b3Jr
KTsNCisgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ1cV9tZ3ItPnJlc3VtZV93b3Jr
KTsNCiAgICAgICAgbXV0ZXhfbG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQoNCiAgICAgICAg
cXVldWUgPSBhbWRncHVfdXNlcnFfZmluZCh1cV9tZ3IsIHF1ZXVlX2lkKTsgQEAgLTc0NSw3ICs3
NDUsNyBAQCBhbWRncHVfdXNlcnFfZXZpY3Qoc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVxX21n
ciwNCiAgICAgICAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX3NpZ25hbChldmZfbWdyLCBldl9mZW5j
ZSk7DQoNCiAgICAgICAgaWYgKGV2Zl9tZ3ItPmZkX2Nsb3NpbmcpIHsNCi0gICAgICAgICAgICAg
ICBjYW5jZWxfZGVsYXllZF93b3JrKCZ1cV9tZ3ItPnJlc3VtZV93b3JrKTsNCisgICAgICAgICAg
ICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnVxX21nci0+cmVzdW1lX3dvcmspOw0KICAg
ICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgfQ0KDQpAQCAtNzc0LDcgKzc3NCw3IEBAIHZv
aWQgYW1kZ3B1X3VzZXJxX21ncl9maW5pKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1c2VycV9t
Z3IpDQogICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cW0sICp0bXA7DQogICAgICAg
IHVpbnQzMl90IHF1ZXVlX2lkOw0KDQotICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmsoJnVzZXJx
X21nci0+cmVzdW1lX3dvcmspOw0KKyAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnVz
ZXJxX21nci0+cmVzdW1lX3dvcmspOw0KDQogICAgICAgIG11dGV4X2xvY2soJnVzZXJxX21nci0+
dXNlcnFfbXV0ZXgpOw0KICAgICAgICBpZHJfZm9yX2VhY2hfZW50cnkoJnVzZXJxX21nci0+dXNl
cnFfaWRyLCBxdWV1ZSwgcXVldWVfaWQpIHsNCi0tDQoyLjM0LjENCg0K
