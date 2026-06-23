Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBBCDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 11:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC4A10EAA9;
	Tue, 23 Jun 2026 11:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lz9MjMkG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B60F10EAA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 11:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuGaXwckCIAFJiTHA6I/YhUSi4USjVCbLl1CnNmJyAEgHU6VMqfG1awsU0lG1tCWF3t90CR3raYfPrtmx6pzCZdvcNXdIxVUFn1OEPmtdq2MJsFOpHnnKamC5pDQndX4FQaHxWP9YT7fuPsTyx75xMvh8Pg7rsDBHD+DHyLRk4GJbS9xtygunwtrzE6Gm09GNqohhuNbRChPXDDsjrIBrWZx5xCNz+VHrJtZXlfp+jL/e7TQpID/Z3ghnYlvH2HGPGwtG6uF/o90k6LUWBsqO2Ns7XAPDVMqwei2HWiRghTh0w7odaeB/8CCRoRKdUa54XwYo9cIXmQmac5TlWyp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Vz2sCQyW7we9Vf8qvj8bSwhnwBj50D4BhZgytiNs0=;
 b=GZa3Rt8Z3cWTBpF2I7HQc4USLeiIzXObvHp2OWRh7pU88bfoCwciSHebU39YJT8tVDF309FHy/fzi0CaqTaGm9tyEyqlTxF1hBoua8OaaUkdzA3Yyr5RnMISUMkaDnFnSjoHw0posWK1vWLxa3JproIuvdZuCjW9z82wns6NDHsiSOtooNkJjIwKbRkCqS4tUY2Qavp8cXekZo24YPfmUZ2SzkfBs30CpITbJC7qYJcUWZh50orPO8V+seaVAIeKMuUJz3fhNy4NYkBO22vCVVIw0OkGsikyebZL4HD/2Nq/+EKv2/kW5SxbBbLUspLZnaMUS7h9wh3p5QMooaX9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Vz2sCQyW7we9Vf8qvj8bSwhnwBj50D4BhZgytiNs0=;
 b=lz9MjMkGVbSCvXg0rWjtHXhl5tMfDOQJd2l3LjuDqfHTfqdSHLVHIQ4NVKPx5r4JdkNcDZdxhsDVlRnh+zT6/23WcCPNpwWrpYufXtXAQzR3M+ZfjKbb8Bd+hO9pfszmAv873P3JVwifW4e7ovWBfu4XRSnqjgP9USdaLqEl/sg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 11:32:03 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:32:02 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
Thread-Topic: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
Thread-Index: AQHdAugp19Ohd1ICYE6Fxu94J3Z7g7ZL3WSAgAAh+mA=
Date: Tue, 23 Jun 2026 11:32:02 +0000
Message-ID: <IA0PR12MB8208E2D6348B44DC32D40EED90EE2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
 <20260623081301.3046023-2-srinivasan.shanmugam@amd.com>
 <5c4c0c82-b2e2-4c42-8515-3de93814b408@amd.com>
In-Reply-To: <5c4c0c82-b2e2-4c42-8515-3de93814b408@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T11:22:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SA5PPFB2BF91BC0:EE_
x-ms-office365-filtering-correlation-id: 133f0283-4292-4f9f-df3a-08ded11b0bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|22082099003|11063799006|56012099006|18002099003|4143699003;
x-microsoft-antispam-message-info: K8aWMjKEGH9FQFEFiJfExSxAMoC70SGMIBySJCh9Bkyh40Z4dSo+Qw3XlYWSimUFPBjzUDS4DkwBdhsLIAPxdgXT4PSavPHx5Jl1RbYqY2+ryUdyjQpT8z5oH6bHK+rdHGRrxqMCJ0yuapnR0ngfAOqmCN5YL9VgJ1bCiiEF/U3zE7mzxWX7NhGXgMy7AvZ66HkDQtOFCkbfRU10PCXUDlRMHb3hZhhe2VH2AYmYDsO6yDnGxM8L9uYM7y8eSsD56rqR4Gfw6nodroTYaFWDiJoOIq5QofPivgHzaAnOjjVYgxeYRo1NG6bjiPInwsrMg4EJINzHWV9ASaz3tK06OElyrod112zwO+Q5gYORVzfw8Ts/z0QsvI49NfLHGLVx6R2LyNdg+vXHJleAsw0urtz55B6vZrx7FwnhpRGEo5FUYShJAaZOvakmqB4tzfneZQOIT1xSes+WQ00ASZSIOhtDfqwGri/nfLXanJXftClYcxIBFK2Ki/MZn7C5xjd99wIIgiYsHBw3mSA+TpYmswVx60iDLEctwMAEuxl4D0LQ90eqIN52NJycj8bxBUj3WQrKzE5tUwVHMab4iDn0/XkqAZBtp3xjdNr+Dv2/v6sB0amEzlrVf3TmsUxWnhky7JtBDaSfDhpJjwoggaHYz6asH52rk7/aWkmRlmU93N1SO2Ro3dm6mrC+nWvn0n+Lt0k0TtMm1Eo9ZWluPUvD3ic9yuJW3RgOCMi/7q79HCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(22082099003)(11063799006)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2RwaFJvOG5vSHVaVWRiOGJDRnN6amZsVmhIaVN6RU1XeHkyU1JTUy94Qmhy?=
 =?utf-8?B?Zi9QNkhtZEdwQ2IvbzZ5bUVNUG85L0h2cHJPYTFmV1J0Nk82QVV3N1daS0h1?=
 =?utf-8?B?a2JsbkdrcGpKempiSVZFWk5vZGw3QmQ3SGpkQktpeXpkSWRNVE5BeUFLRTlN?=
 =?utf-8?B?RzlNQ29SQVJvanVPT1JKcmh6bEhWb2RKSk1RQ3hUekdWamVYRi9xQ09sbktN?=
 =?utf-8?B?ZU1yMDJTTm4yQnFOT29nMkpic1Y1aHRydnMwRUpYelBhSUlFN0Y1d3RPL09J?=
 =?utf-8?B?bE0wNUVFTHk4citnKzFSOENyQ0Fic25FMFpxRnpPUnhtREtIeW5LeVN6SW5D?=
 =?utf-8?B?VldYSDlGOGlLQVBrUnExU1pKU044SURaakxsRGtQRjB3UFRCQjhmak9LVDFU?=
 =?utf-8?B?dEdNNVBmbVlkUmFtYXpWditkdUR1YW11djRYcXIxbkliYWNTV1dnQ2pyWkFV?=
 =?utf-8?B?am9lWjYyNjF3Q3p6dEdxejZaREgwYVBORFlwYWkzWCtrNHVJN3prSnUzSmZW?=
 =?utf-8?B?QTNLbXdPN2EvTDBLSTdQMDVyY3NkeGxjbjA4L0xYdXk4NzViR0JGczhwdkNM?=
 =?utf-8?B?ME1MeWs1RmxHRzRZakpXcHV2L0FHdStPRkRmZEhKd0Y2alJkMGVHZGhNRWZx?=
 =?utf-8?B?cnlteFZSNWxFcC9TUlRjNlhYOFlEZkNxUmxNUWNkNXpKc1dvdlFLMXFtN1JU?=
 =?utf-8?B?MTFmdHZzTk11eERvQ291aDdwazlrM3JHa2VqUUhaeUdWZjcyQkQ4dkxtZnVK?=
 =?utf-8?B?eHNucmp2TFU5MHl0ZWdOaWpiSjUzT253Vk9ESGRlMUhtdkQ1U2YxRlhWbVN1?=
 =?utf-8?B?Q3ptdzYwQjgrRmluK21ZN2krb3g5OEMwZlpuTVQxbURXY0FmcHRuWFlOVGhE?=
 =?utf-8?B?V2pDSE9nV0dPRkY2dXJMSHJZUGcrZzNiYU13ZkVqaER3cmF5UFBhdUlnZW9J?=
 =?utf-8?B?SUF5cjZVKzluQzZkaEkzR0dQWkNmYlZMOWFpSjNCd0F2NzFpUEtYdmlScmY4?=
 =?utf-8?B?dC9HZC92MGhDQm5LSk1ZcWJsM1prcDkxYmM3MzYzVUQxcHhOckFpTjVoMUJv?=
 =?utf-8?B?cXduZXRQZnZ4TlBjVHFvWVh5VVo0aXdUU2hZd2lZN0RmYVdUalpXd1VtbkJ4?=
 =?utf-8?B?L2ZjSWx4WUlEazV2Tm43Q3UxUVFrS1ZST0JxMTc5ejhUVHNJSkhwQUZGSUtl?=
 =?utf-8?B?Zk1QRVNyYlZpV0ZPSC9zS0tqaXFGYWdJWHZaRVRUNGVtbHFlMHVXbnQ0dzBQ?=
 =?utf-8?B?RlF6REZwRlN0OW13WUlacHg0MzlqT0pBNnZsQWtvd05HSklIcDhZZzdLOVk1?=
 =?utf-8?B?M1dCNjY5L0NCMnZ3WUZUNGJ1MnBtak5qdS9CbWRqR3B2UDFRbEZJcmRFRllH?=
 =?utf-8?B?cVJQWXVUZVZGdFNEdzB1TVloVkJiRm1FUW9GdFhiMkc1NUllUEZlc1Q0ZDJH?=
 =?utf-8?B?M3VxMEZtZ3pjTmVSUW53Q2ZrTFV2WGkxMmNvdUltM1FweE52L1U3RlhJcXk2?=
 =?utf-8?B?Y0p4UnZOeGxQejZreGRyanQ4WkdlRlkrKzVsTWdORVZHSTlDMzhGYWZOMUcx?=
 =?utf-8?B?RXg0SnVYRURSN1RnamRRaG9sUktYUjlMWkFNSWNNQkR2QUJoanNwUXpMY3E0?=
 =?utf-8?B?akVNWGwxd0pINTZoOEVucW9RNDh2amptUWNndmt0c1VkcFhZRjNsaitVbGRo?=
 =?utf-8?B?WXBESWN0M2ZXZGJuYlNXNzVqMTdza1NKSXdnQlg1dW9qOUZwamlPbW5xdlFP?=
 =?utf-8?B?blZDRUR0QmE4U29ia05GcjVydThCNW1zRkY0RlBWVlN5UnBxRVA4ai9MOUl4?=
 =?utf-8?B?YnBKL09Ec05xdGRJL3FsQ3BOMGVpT09mVGVHUWl6RGR3YUQ1YkYwbnVHTEc1?=
 =?utf-8?B?cC8rWm9EZUV1TExoNUJseVVMbFdYbzdMalF5cjNoUVdyQW50TFJRY2ppdEMx?=
 =?utf-8?B?SnNQYVRLNVlXejhPWEVKSWN3UlNqNU1ENlp0MmZrVStCck9LT2lvWGNoVW9t?=
 =?utf-8?B?QnhGUkk0Mzl3V1BSM3B3ak1iMHNBRDdMWnlUR25ZbCtrekFlaXVrQ1ZnTzR1?=
 =?utf-8?B?TFRla0hyVjNQWEpSUkp2dGxZYzlmZXA5R3hoeS9hMGF3aitDOWtNZWwzeHM3?=
 =?utf-8?B?ekRMakoxWGVJNnI4L2Z3SWY0OXhYaGJ1bVZGS0RCQ291SlJYWldXV2lQbnF5?=
 =?utf-8?B?WU9OM0owMUQvd3RwSVJuL3dNa3crYlhtcjdPaTk3ZTRqNmlmVS9xWkdFU0hB?=
 =?utf-8?B?aW5sQzhreGkyQVhvSVFTL1lTdk56MzVJSzRNd296RWV4MlBRVm5RK2RTdWFp?=
 =?utf-8?Q?ZVx3nUCDsntYbdPdh0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133f0283-4292-4f9f-df3a-08ded11b0bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 11:32:02.7845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5R6BFupol+/T5ZtNz3IfbtTYX0cWSYCsvPVRV9sj9SP2D2y7vX4Ppv4xQfBVrk2eBaW96Cof/T43Z7olAUfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjMsIDIwMjYgMjo1MSBQTQ0KPiBUbzogU0hBTk1VR0FN
LCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS8zXSBkcm0vYW1k
Z3B1OiBBZGQgUEFTSUQgZnByaXYgbG9va3VwIG1hbmFnZXINCj4NCj4gT24gNi8yMy8yNiAxMDox
MiwgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gQ3VycmVudCBWTSBmYXVsdCBoYW5k
bGluZyByZXNvbHZlcyBQQVNJRHMgdGhyb3VnaCBWTSBzdGF0ZToNCj4gPg0KPiA+ICAgICBQQVNJ
RCAtPiBWTQ0KPiA+DQo+ID4gVGhhdCBpcyBzdWZmaWNpZW50IGZvciBWTSBmYXVsdCBoYW5kbGlu
ZywgYnV0IHByb2Nlc3Mtc2NvcGVkIGV2ZW50DQo+ID4gZGVsaXZlcnkgcGF0aHMgbmVlZCBhIGRp
ZmZlcmVudCBzZW1hbnRpYyBtYXBwaW5nOg0KPiA+DQo+ID4gICAgIFBBU0lEIC0+IGFtZGdwdV9m
cHJpdg0KPiA+DQo+ID4gQWx0aG91Z2ggYm90aCBtYXBwaW5ncyBhcmUgaW5kZXhlZCBieSBQQVNJ
RCwgdGhleSBzZXJ2ZSBkaWZmZXJlbnQNCj4gPiBwdXJwb3NlczoNCj4gPg0KPiA+ICAgICB2bV9t
YW5hZ2VyLnBhc2lkcw0KPiA+ICAgICAgICAgICAgIFBBU0lEIC0+IFZNIGZhdWx0IGhhbmRsaW5n
DQo+ID4NCj4gPiAgICAgdm1fbWFuYWdlci5wYXNpZF9mcHJpdnMNCj4gPiAgICAgICAgICAgICBQ
QVNJRCAtPiBwcm9jZXNzLXNjb3BlZCBEUk0gZmlsZS1wcml2YXRlIG93bmVyDQo+ID4NCj4gPiBB
ZGQgYSBQQVNJRCBmcHJpdiB4YXJyYXkgYmVzaWRlIHRoZSBleGlzdGluZyBQQVNJRCB0byBWTSB4
YXJyYXkuDQo+ID4NCj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPg0KPiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hh
bm11Z2FtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIHwgIDUgKysrKysNCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uaCB8IDEzICsrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jDQo+ID4gaW5kZXggNDUwYmQ5ZGM2YmMwLi4zMTQxYWUxMzgzYjAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IEBAIC0yODY5LDYgKzI4
NjksOCBAQCB2b2lkIGFtZGdwdV92bV9tYW5hZ2VyX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UN
Cj4gPiAqYWRldikgICNlbmRpZg0KPiA+DQo+ID4gICAgIHhhX2luaXRfZmxhZ3MoJmFkZXYtPnZt
X21hbmFnZXIucGFzaWRzLCBYQV9GTEFHU19MT0NLX0lSUSk7DQo+ID4gKyAgIHhhX2luaXRfZmxh
Z3MoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfZnByaXZzLA0KPiA+ICsgICAgICAgICAgICAgICAg
IFhBX0ZMQUdTX0xPQ0tfSVJRKTsNCj4NCj4gSSB0aGluayB3ZSBzaG91bGQgY29tcGxldGVseSBy
ZW1vdmUgJmFkZXYtPnZtX21hbmFnZXIucGFzaWRzLg0KPg0KPiBUYWtlIGEgbG9vayBhdCBhbWRn
cHVfcGFzaWRfYWxsb2MoKSwgd2UgYWxyZWFkeSBzdG9yZSB0aGUgUEFTSURzIGluIHRoZSBnbG9i
YWwNCj4gYW1kZ3B1X3Bhc2lkX3hhIHhhcnJheS4NCj4NCj4gQnV0IGluc3RlYWQgb2YgYSByZWFs
IHZhbHVlIHdlIGp1c3QgZ2l2ZSB4YV9ta192YWx1ZSgwKSBhcyBkdW1teSBmb3IgdGhlIGVudHJ5
Lg0KPg0KPiBJIHRoaW5rIHdlIGNhbiByZS11c2UgdGhhdCBhcnJheSB0byBzdG9yZSBwYXNpZC0+
ZnByaXYgbWFwcGluZy4gSXQganVzdCBuZWVkcyBwcm9wZXINCj4gbG9ja2luZyBhbmQgaW50ZXJm
YWNlIHRvIHJldHJpdmUgdGhlIGZwcml2IGZvciBhIHBhc2lkICh3aGlsZSBob2xkaW5nIHRoZSBY
QSBsb2NrDQo+IGlycXNhdmUpLg0KPg0KPiBMZXQgbWUga25vdyB3aGVuIHlvdSBoYXZlIG1vcmUg
cXVlc3Rpb25zLg0KDQpUaGFua3MhLg0KDQpKdXN0IHRvIGJlIHN1cmUsIGZldyBjbGFyaWZpY2F0
aW9ucyBwbGVhc2U6DQoNCjEuIFNob3VsZCBhbWRncHVfcGFzaWRfeGEgYmVjb21lIHRoZSBzaW5n
bGUgUEFTSUQgb3duZXJzaGlwIHRhYmxlLA0KICAgcmVwbGFjaW5nIGFkZXYtPnZtX21hbmFnZXIu
cGFzaWRzPw0KDQoyLiBGb3IgRFJNIFBBU0lEcywgc2hvdWxkIGFtZGdwdV9wYXNpZF9hbGxvYygp
IGNvbnRpbnVlIGluc2VydGluZyB0aGUNCiAgIGR1bW15IHhhX21rX3ZhbHVlKDApLCBhbmQgc2hv
dWxkIGFtZGdwdV9kcml2ZXJfb3Blbl9rbXMoKSByZXBsYWNlIHRoYXQNCiAgIGVudHJ5IHdpdGgg
ZnByaXYgYWZ0ZXIgZnByaXYgc2V0dXA/DQoNCjMuIEZvciBleGlzdGluZyBWTSBmYXVsdCB1c2Vy
cywgc2hvdWxkIHRoZSBsb29rdXAgcGF0aCBiZWNvbWU6DQoNCiAgICAgICAgUEFTSUQgLT4gZnBy
aXYgLT4gdm0NCg0KICAgdXNpbmcgJmZwcml2LT52bSB3aGlsZSBob2xkaW5nIHRoZSBhbWRncHVf
cGFzaWRfeGEgbG9jayBpcnFzYXZlPw0KDQpJIHdpbGwgcmV3b3JrIHRoZSBSRkMgdG8gdXNlIGFt
ZGdwdV9wYXNpZF94YSBhbmQgcmVtb3ZlIHRoZSBuZXcgdm1fbWFuYWdlci5wYXNpZF9mcHJpdnMg
eGFycmF5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpTcmluaQ0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCg==
