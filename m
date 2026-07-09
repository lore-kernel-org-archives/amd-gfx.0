Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141FCC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 12:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FF410E6BE;
	Thu,  9 Jul 2026 12:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yH22KHz0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA07A10F585
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 12:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMOoArbxVAxYGG8wATc4UDEQ+g7VhwjdeIe52Q8vuc/em+zzebHVITxSUCPgpJ+3kYqwf4iyi5MESv+uamf/pxPUTXLngtg/XTevzkbE75OVxWFBTbzDqRT3YzQokV2c9m1TPgg1V+Ed8eX6cN6AMRKdrI0SOuyGg/3ixkvtvPhuKyiN8gFpwYCRA+jBhBlM0uAbqKy615Svvol5bPt9UT8LSXw77y8N5uMg35S3CTbKxAC2tdmKbrbijqz2Mt3/dWwG6dgEMlrPqXW8wCW1LYYiMDIId+nyQOBwSwWQlIWE+VZa72kisjyXaQ5y/yciedVNsNAsUhMIcfqrMn/Mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpejX1HZaK2IDsVTmK/XdLKgGN/ieOM5DQPoyJnmaYA=;
 b=sChRZc/vjugi3YiHqzU77l6OXyk1k7jzbmc/d8XtNVvNls4F9B54o7dCe6eXkBMni3WhbfPrEQ+NTY49ZA56HYnjwvJTCZ9OM111J1GPxmnqOEuX+/1SnGbNHwdRX6SQ5JyMAmxEfe+EqSDU3m4D8dC1J6ym5YW2zgN7ksNdHTLxPUSyFw5i0CX5Z1lD+Wx6c5o9F6jXea8hEaUUXZcWvk6BjLjp5ugFQnZueTS8rtot3amwTy77U2Jx3h0LmOAYFKyFVB/afOJ2MG0OzoQGz/K7dg9w/B9YOwMqeUQTA2dIRgfh9WLv6cJd/cNUez2etXla8+v61bZnLIoh8UPKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpejX1HZaK2IDsVTmK/XdLKgGN/ieOM5DQPoyJnmaYA=;
 b=yH22KHz04EnS2+jbnSKX00NMRSggHR+zaeaDDUWmMCBiN9d85XVzjkZfQ0fq6naVI8crDku9jNc4vBaYzS7FImcofa1g821oKOkwLNlZN8Xkg2+9x7DkqlpbMJFXms7OcfOvY332j573Y9Ef62U6B5bcY+i5pHscEeDH4HsH99g=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 12:19:14 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:19:14 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Remove vbios bounds check from
 pp_entries_max()
Thread-Topic: [PATCH] drm/amd/pm: Remove vbios bounds check from
 pp_entries_max()
Thread-Index: AQHdC52ZpVyGCwlSn0y4D/0mrYcqe7Zj2PoAgAEh3vCAAAw4AIAAG/pQ
Date: Thu, 9 Jul 2026 12:19:14 +0000
Message-ID: <DM4PR12MB5748979CE743162FA87C69EB8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260704101120.674980-1-john.olender@gmail.com>
 <CADnq5_ODf=T4VD9_RptQaEtJr5Zinsom8jW8GJL56GN6shvJsQ@mail.gmail.com>
 <DM4PR12MB5748B149AA0BB0C5CE58BD3B8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
 <c26d3312-0d50-4e2c-8516-7cee2b41bf83@gmail.com>
In-Reply-To: <c26d3312-0d50-4e2c-8516-7cee2b41bf83@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T12:19:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|CY8PR12MB7266:EE_
x-ms-office365-filtering-correlation-id: 8289175d-0d52-4c57-9e2e-08deddb44a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|18002099003|22082099003|3023799007|6133799003|5023799004|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: fH0ztqGP0hZshhcsfVx+oskWm+fPD3bGXMjLN3mK5IrJ3vpt9CUHQGusKo04bk1kAAn9/d134JRxMM80ylmM+/q3rXK7/ZDfs1BM8odIqAbZAPSxHmXr9GTDkHszFoW6LFxKFcnkrVtoQUpibDXUNfnT3RBkgFOVj5GTY29ipT5vqDYJS9eB7NaT101Tyx7BNC1CWFHDtDS2OuFqzLTEvmlytPZrOaCtPl/L7aqRthbwLZXijUdWOSzyJ2u/HUFW8NU70AjA/Z0rI31t6ocrQhS/ETzvvsaYLRp8lUsEgrnKwl8AO+Eb2QioTKSG7+RkrWNXuhQbfOuTCkPEVJcThiwUqZsTGbjxv28/FaSyE/TGmYfyDPSY0jYo3Q8EovIthvcaiht5VAITPkoYrxG566kULZidt097Mix+0MZi0vJCkObpmUzuCGOWkjntrv80ozFAO2kbkrPxGVgJXfZ8QyDdogZ1iQTQrfvdD+FPlB75UhCS33uFWmkBl9YqlTxaAJob9bC+P0muP4kzc8/TUk8cHxiW6Td8yDoUNV0wWLq0vJiRU3KW+ldZK2GIkIRDZaYDA7RzqzFsWhccO1Tf1zx/7lkEGJtacdJ2VcVaGrG2W1HU8fbYMTlONPGiBrlT88CXR8PbWPQWXckx7p7yhGilchqQuZRSGj3HKpNBFhnYDfmgS2PUXm4DqMocicdLK4drKJsCHhJuqw0xneRoYi1eBNhappgArlgDWbBznBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(3023799007)(6133799003)(5023799004)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm1zVzJrVVB3RkV2UFRMYTF1UmUzTDdqNThYU2VsYlkzUWdBL29iWlB0dW1u?=
 =?utf-8?B?Sit3K1I1UHdNdTNzb3hGYzNhd2dKM1VYRUFaaGxQNTY4U2xpVXhDeTAzNDVN?=
 =?utf-8?B?TFlCbjlwN1RWRVdKZ2VKaHFaaFhacGV4RSt3a0t2eDg1bGJxVmxMVmdwTHc1?=
 =?utf-8?B?MkJ6RUc5MUxrUk5XMGcvVFUyVjBnaG1XcnNzcnYwbDgvR0xkN3Y2S0ZOb3BS?=
 =?utf-8?B?OVZ5cXNCMDlqUUpLU0JXcHB4eWdxRXB4WU1XRmwyanpKcDczRmpTZEZnQzV1?=
 =?utf-8?B?b0trVGxxZTdQSlZUMHlnRHdKRFVxMk1rWGRXUDVEalhpV1AvRjVZcWg5NVcr?=
 =?utf-8?B?U1I0UXhzYUVXQVVxTjZXSDBPeGRXY0MvWHZ0c0R1Y2d2VXVuNEZSVHZKN214?=
 =?utf-8?B?SVRCREpSb0c2cjRVUWZUSHdJSFoyZ1Fac1h3ZW5leGpxbzMwM3kvOEFnTlk1?=
 =?utf-8?B?cStXZ1YrQ3djUFZZT2Z1bU4vL0pwdTZaWVV2bDJZUWdZazBJNm10S21UVFRQ?=
 =?utf-8?B?alpYTnNIR016eVVPUE1TV0h1NldjTGdUSXVQYWY1U2NHNzd4K2pzc1dGTUdB?=
 =?utf-8?B?bXNOL2lYYlNaNlcvQnkrU08wdUdUa0NZMXpnMUdoS09YbEd6Z21TY1dqSWdw?=
 =?utf-8?B?MGVHTTZzWmpsb2d6b09BTkJ2SGlsd2dEcUZEQU9QY2U1WWFjVkpOZWl2VFd4?=
 =?utf-8?B?NUlyT1N6SElYMVlHQTdLRmxDa2FBeDVmNXFVbzg1Tlh3d3Y1YUtIZlN0MmZX?=
 =?utf-8?B?WnNTUWtEWVU2WGdPZE1GNzhsc1IxZ3RUN1dyYys5WWN4MHB1ZEc5TXdVWDlQ?=
 =?utf-8?B?YUdQNUlGNkUrSHlSUXVqTUZJMVhhclR4TVEraWpGZlM2WEEwOXBQZkUvWmRr?=
 =?utf-8?B?UUd1ZG9pWEVzQXdRMU5pelpPaVhMZFh0Y3ZZc2NObVdWc3dvSnZ1cTk1dklp?=
 =?utf-8?B?R1c4L2dwWi9rbXo4SUxVQ2NBVjlaQ0xCSEVQamV1YXJ0WmZ3cXNJYUdSRG93?=
 =?utf-8?B?WFFYM2hhSUFpS2F1UU1KS204Wk1CdzBHR1lWcDZFNU1GaEZkRWp0ZFdyb0hP?=
 =?utf-8?B?Tlc1Nm5uOWYvOGdjTk5USVBxTUNDak9vR0MrZ1dKYXNYNXdncUZtd2s0NWox?=
 =?utf-8?B?V2hFQjRZY0FGLzlDVXFpelQ3cnFGOFlpa1dIb09UbjdGR3hYUXhuRW03Umhl?=
 =?utf-8?B?dFRjZ0o4TGhtRWZtTFV1VDkvR0dzNWg2czNrTnd6T2Z6NG9UWE9ySlRxWWtX?=
 =?utf-8?B?TGNjSDlvbWZWK3JzYlV4ZHhwYkZ4cUhNWjh5OVdRcnNyMmZLUVNST0hKZkZU?=
 =?utf-8?B?SEIrMkkyeHhwT3Vma21vcGFPTmdmVXY0Z2VhTnRJcXNTbm5sNkRwNlhGajAv?=
 =?utf-8?B?dUlnMnoyVVBFMHZrNWVVeW81OVRiMXVPQ3dFQVoyU3RQalNuVXQyR3ZmcWFl?=
 =?utf-8?B?cWNkTS9Sdzd0VjJFclJJdGFWUk5lKzl4RklCR2JHNFBlVThhNnI5MjVWQ0xN?=
 =?utf-8?B?K3VVQkNabXNXNytaMTNMTHB1ZXhEQytvc2tFdUxGTXo3SU1SOG9qNHhvQjJk?=
 =?utf-8?B?QnVCRHJXeGx5YURDSHU3UlJleTh3aHRxWFVKaUZJSEcrUHhlVDRyc3p6dERm?=
 =?utf-8?B?RXI0ZjBwSC94QTRiRnE3N2Y2Uk5wQ1Mzb3lxYTdCdFozQXFHVjgvZWl1VVho?=
 =?utf-8?B?anVYSTRQNzVSQ1hFNzdmVlZPbWxLOGllTmdZaEg1SVJUYWgyUnNwQ082VGVR?=
 =?utf-8?B?azdERXRmZnF3d2tnZmRoMzJJdm5CK3RJWjdlRVZhcmxzWDNkakxsVTFmcG1u?=
 =?utf-8?B?MEdpVlJkOUxIaGNjNnU3MG1meDhMbU9UaWdBaFU3WEQ5b1ltWVZnUzNCM1BO?=
 =?utf-8?B?S1dEalVuZEZiSTd4cGtCQm0xM2xHQ1NJdFVZSzExcjNpWGJaRmtidUo4MDMy?=
 =?utf-8?B?dUkvNlRUTGlPSHZrTTIwTDFyclJtbTJnWVJiY3haTEhQUEdwVkhoNkg1RFFx?=
 =?utf-8?B?dG1vaVByc0dYZG9UMTI3T1BDa3hySFV2Q0Y3L3NEZ2FSY3luYkhVYzF1TXJt?=
 =?utf-8?B?NS9uVE5OKzZnTUxzdGpNZ3J0SnZLdjZ6WXFqZWt2aXdoWVN5MjBYY09FKzhq?=
 =?utf-8?B?L01rVnU3QWtGUmJIcXd1V0IybFhxYjRBb2tSZUovemh6eW92a3pselhYL3VE?=
 =?utf-8?B?cWpnZG54Skt6MjBJbFREUkN3d0FKWE1aRFFDMEs0dWFMc0loeHZiZ09nMmQ5?=
 =?utf-8?B?MXkxaElMb0RMVTB0dGtQK25uL0xnWWF4bDNFNHRTdkVHUXFHN1NtVmhueXFS?=
 =?utf-8?Q?p+cVAkfXIaBazs1bJr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8289175d-0d52-4c57-9e2e-08deddb44a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 12:19:14.2893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES2FYc9PIiRGlN6P2QFs7SrRcsEXoNYEchzvf4LilcdaQAJWg610XLCibbObR3yzJ1KH3o5+TMiGe2LgFPHMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
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

QU1EIEdlbmVyYWwNCg0KSGkgQEpvaG4gT2xlbmRlciwNCg0KYW1kZ3B1X2F0b21fcGFyc2VfZGF0
YV9oZWFkZXIoKSBkb2VzIG5vdCB2YWxpZGF0ZSB1c1N0cnVjdHVyZVNpemUgYWdhaW5zdCB0aGUg
QklPUyBib3VuZGFyeSDigJQgaXQgcmVhZHMgdGhlIHZhbHVlIGRpcmVjdGx5IGZyb20gdGhlIEJJ
T1MgYnl0ZXMgd2l0aG91dCBhbnkgYm91bmRzIGNoZWNrOg0KDQppZiAoc2l6ZSkNCiAgICAqc2l6
ZSA9IENVMTYoaWR4KTsgICAvKiByYXcgQklPUyByZWFkLCBubyB2YWxpZGF0aW9uICovDQpTbyBz
b2Z0X3BwX3RhYmxlX3NpemUgaXMgd2hhdGV2ZXIgdGhlIFZCSU9TIGNsYWltcyBhbmQgY2Fubm90
IGJlIHRydXN0ZWQgZm9yIHRoZSBWQklPUyBwYXRoLg0KDQpSZWdhcmRpbmcgb3RoZXIgQVRPTSB0
YWJsZXMg4oCUIHRoZSBQUCB0YWJsZSBpcyB1bmlxdWUgaW4gdGhhdCB0aGUgaG9zdCBkcml2ZXIg
cGFyc2VzIGl0cyBzdWItdGFibGVzIGVudHJ5LWJ5LWVudHJ5LCB1c2luZyB1Y051bUVudHJpZXMg
ZnJvbSB0aGUgQklPUyB0byBkcml2ZSBremFsbG9jKCkgc2l6ZXMgYW5kIGxvb3AgYm91bmRzLiBU
aGF0IGlzIHRoZSBkaXJlY3QgZXhwbG9pdCBwYXRoIHRoaXMgc2VyaWVzIGFkZHJlc3Nlcy4gTW9z
dCBvdGhlciBBVE9NIHRhYmxlcyBhcmUgZWl0aGVyIHBhc3NlZCByYXcgdG8gZmlybXdhcmUsIHJl
YWQgYXMgYSBmaXhlZC1zaXplIHN0cnVjdCwgb3IgZXhlY3V0ZWQgYXMgQVRPTSBzY3JpcHRzIOKA
lCBub25lIHVzZSBhIEJJT1Mtc3VwcGxpZWQgY291bnQgdG8gYWxsb2NhdGUga2VybmVsIG1lbW9y
eSBpbiBhIGxvb3AsIHNvIGFuIGluZmxhdGVkIHVzU3RydWN0dXJlU2l6ZSBpcyBoYXJtbGVzcyBm
b3IgdGhlbS4NCg0KVGhlIGJpb3NfZW5kIGNoZWNrIGluIHBwX2VudHJpZXNfbWF4KCkgaXMgc3Rp
bGwgbmVlZGVkIGZvciB0aGUgVkJJT1MgcGF0aCBhbmQgdGhlICFoYXJkY29kZV9wcF90YWJsZSBj
b25kaXRpb24gY29ycmVjdGx5IGdhdGVzIGl0Lg0KDQpUaGFua3MgJiBSZWdhcmRzDQpBc2FkDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb2huIE9sZW5kZXIgPGpvaG4ub2xl
bmRlckBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVseSA5LCAyMDI2IDQ6MDkgUE0NClRv
OiBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZlbmcs
IEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmlu
KSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQv
cG06IFJlbW92ZSB2YmlvcyBib3VuZHMgY2hlY2sgZnJvbSBwcF9lbnRyaWVzX21heCgpDQoNCk9u
IDcvOS8yNiA1OjU3IEFNLCBLYW1hbCwgQXNhZCB3cm90ZToNCj4gQU1EIEdlbmVyYWwNCj4NCj4g
SGkgQEpvaG4gT2xlbmRlciwNCj4NCj4gR29vZCBjYXRjaC4gSG93ZXZlciwgIGFzIEFsZXggcG9p
bnRzIG91dCwgcmVtb3ZpbmcgdGhlIGNoZWNrIGVudGlyZWx5IGRyb3BzIHByb3RlY3Rpb24gZm9y
IFZCSU9TLXNvdXJjZWQgdGFibGVzLg0KPg0KPiBJbnN0ZWFkIG9mIHJlbW92aW5nIHRoZSBjaGVj
aywgY291bGQgeW91IGNvbmRpdGlvbiBpdCBvbiBoYXJkY29kZV9wcF90YWJsZT8gV2hlbiBpdCBp
cyBOVUxMIHdlIGFyZSBvbiB0aGUgVkJJT1MgcGF0aCBhbmQgdGhlIGJpb3NfZW5kIGNoZWNrIHNo
b3VsZCBzdGF5LiBXaGVuIGl0IGlzIG5vbi1OVUxMIGEgY3VzdG9tIHRhYmxlIHdhcyB1cGxvYWRl
ZCB2aWEgc3lzZnMgYW5kIHRoZSBjaGVjayBjYW4gYmUgc2tpcHBlZCDigJQgc29mdF9wcF90YWJs
ZV9zaXplIGlzIGFscmVhZHkgc2V0IHRvIHRoZSBrZXJuZWwtc3VwcGxpZWQgdXBsb2FkIHNpemUu
DQo+DQo+IGlmICghaHdtZ3ItPmhhcmRjb2RlX3BwX3RhYmxlKSB7DQo+ICAgICAgICAgY29uc3Qg
Y2hhciAqYmlvc19lbmQgPSAoY29uc3QgY2hhciAqKWFkZXYtPmJpb3MgKyBhZGV2LT5iaW9zX3Np
emU7DQo+ICAgICAgICAgaWYgKHBwX2VuZCA+IGJpb3NfZW5kKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+IH0NCj4NCj4gVGhpcyBmaXhlcyB5b3VyIHJlZ3Jlc3Npb24gd2hpbGUga2Vl
cGluZyBBbGV4J3MgY29uY2VybiBhZGRyZXNzZWQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiBpdCBv
ayB3aXRoIHlvdS4NCj4NCj4gVGhhbmtzICYgUmVnYXJkcw0KPiBBc2FkDQoNCkhtbS4NCg0KQ2hl
Y2tpbmcgZm9yIHZiaW9zIG92ZXJmbG93IHdoZW4gYSB0YWJsZSBoZWFkZXIgaXMgcGFyc2VkIHNo
b3VsZCBhbGxvdw0KcHBfZW50cmllc19tYXgoKSB0byBpbXBsaWNpdGx5IGRldGVjdCB2YmlvcyBv
dmVyZmxvdyBmb3IgdGhlIHZiaW9zLXByb3ZpZGVkIHBwX3RhYmxlLg0KDQpJcyB0aGVyZSBhIHJl
YXNvbiBhbGwgYXRvbSB0YWJsZXMgYXJlIG5vdCBzYW5pdHkgY2hlY2tlZCBpbiB0aGlzIHdheT8N
Ckl0IHNlZW1zIG9kZCB0aGF0IHRoZSBwcF90YWJsZSBoZWFkZXIgaXNuJ3QgdHJ1c3RlZCB3aGls
ZSB0aGUgcmVzdCBvZiB0aGUgdGFibGUgaGVhZGVycyBhcmUuDQoNClRoYW5rcywNCkpvaG4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gQWxleCBEZXVjaGVy
DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA4LCAyMDI2IDEwOjA4IFBNDQo+IFRvOiBKb2huIE9s
ZW5kZXIgPGpvaG4ub2xlbmRlckBnbWFpbC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgRmVuZywgS2VubmV0aA0KPiA8S2VubmV0aC5GZW5nQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLYW1hbCwgQXNh
ZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgTGF6YXIsDQo+IExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ow0KPiBXYW5nLCBZYW5n
KEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZC9wbTogUmVtb3ZlIHZiaW9zIGJvdW5kcyBjaGVjayBmcm9tDQo+IHBwX2VudHJpZXNf
bWF4KCkNCj4NCj4gT24gU2F0LCBKdWwgNCwgMjAyNiBhdCA2OjE54oCvQU0gSm9obiBPbGVuZGVy
IDxqb2huLm9sZW5kZXJAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBUaGUgc29mdF9wcF90YWJs
ZSBpcyBub3QgY29udGFpbmVkIHdpdGhpbiB0aGUgdmJpb3Mgd2hlbiB1c2luZyBhDQo+PiBwcF90
YWJsZSBvdmVycmlkZSBzaW5jZSBjb21taXQgM2NmZTQzMzYzMDUwOCAoImRybS9hbWQvcG06IFVz
ZQ0KPj4gdXBsb2FkZWQgc2l6ZSBmb3IgbGVnYWN5IGN1c3RvbSBQUFRhYmxlIikuDQo+Pg0KPj4g
Rml4ZXM6IGUzMGIzZTNhYjUxYWQgKCJkcm0vYW1kZ3B1L3BtOiBhZGQgcHBfZW50cmllc19tYXgo
KSBoZWxwZXIiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJA
Z21haWwuY29tPg0KPg0KPiBSZW1vdmluZyB0aGlzIHdpbGwgZWZmZWN0aXZlbHkgcmVtb3ZlIHRo
ZSBib3VuZHMgY2hlY2sgZnJvbSB0YWJsZXMgcmVhZCBmcm9tIHRoZSBiaW9zLiAgSSBkb24ndCB0
aGluayB3ZSB3YW50IHRvIGRvIHRoYXQuDQo+DQo+IEFsZXgNCj4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oIHwgNCAtLS0tDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+PiBpbmRleCA3ZWJjMTM0NDAyM2ZmLi4x
OTAyM2E4NTBlODgyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvaW5jL2h3bWdyLmgNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJw
bGF5L2luYy9od21nci5oDQo+PiBAQCAtODMzLDE0ICs4MzMsMTAgQEAgc3RhdGljIGlubGluZSB1
aW50MzJfdCBwcF9lbnRyaWVzX21heChjb25zdCBzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzdWJfdGFi
bGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBoZHJf
c2l6ZSwgc2l6ZV90DQo+PiByZWNfc2l6ZSkgIHsNCj4+IC0gICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilod21nci0+YWRldjsNCj4+IC0g
ICAgICAgY29uc3QgY2hhciAqYmlvc19lbmQgPSAoY29uc3QgY2hhciAqKWFkZXYtPmJpb3MgKyBh
ZGV2LT5iaW9zX3NpemU7DQo+PiAgICAgICAgIGNvbnN0IGNoYXIgKnBwX2VuZCAgID0gKGNvbnN0
IGNoYXIgKilod21nci0+c29mdF9wcF90YWJsZQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICsgaHdtZ3ItPnNvZnRfcHBfdGFibGVfc2l6ZTsNCj4+ICAgICAgICAgY29uc3QgY2hh
ciAqZW50cmllcyAgPSAoY29uc3QgY2hhciAqKXN1Yl90YWJsZSArIGhkcl9zaXplOw0KPj4NCj4+
IC0gICAgICAgaWYgKHBwX2VuZCA+IGJpb3NfZW5kKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPj4gICAgICAgICBpZiAoIXJlY19zaXplIHx8IGVudHJpZXMgPj0gcHBfZW5kKQ0KPj4g
ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gICAgICAgICByZXR1cm4gKHVpbnQzMl90KSgo
cHBfZW5kIC0gZW50cmllcykgLyByZWNfc2l6ZSk7DQo+Pg0KPj4gYmFzZS1jb21taXQ6IGUzY2M4
YzEwOGY5YTkxNzI4ZjlmZjZlMjRjYmYzYjQxYzU4YjhmOGINCj4+IC0tDQo+PiAyLjQ3LjMNCj4+
DQoNCg==
