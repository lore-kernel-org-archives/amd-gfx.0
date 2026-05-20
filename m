Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47647CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 22:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29A210F177;
	Wed, 20 May 2026 22:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRj7Eu/y";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C1010F177
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 22:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy922Rta5hxu9r8nu2aSMRrYEH1cBoP5rpXl3czt24kJPdj2AniVdTHvFB50rJd9y0OdHq7jaYz0SrIObjJSOLmPUoonLSlWLnm97EHW40TO3zc86PnjybbGMQ3eD922FM3GpxQmJeRgxSmAgcjQ/yVF1Uq4UYdOS/rmx1BByee7hJP1lS4kgyy7RtyoJlvAurJpjBpCJfFUodhv/vV1a0QqRHbbkIsE5t8ExIbuU77jzeB/PUBk6nSSWJwDsh0KaJdxmjf9Pdw5CwHsp0RAUIkararscKdmuANS8ZUWx+/PZ/LKWxV48628tJyyRrmJ35ve5lQ63xgNkoXPq5DN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0BdFhms2RksqHo8MvR+60+ndoZp/IRko5In/J/r2/4=;
 b=YI5CFDNJeXIDmTDXY3bVXjbHdl9Q1dog8Qj+4Y974VajiYApnDTC/6kxkLNN1yggixMXrFCDbXSOncYdwOqirRfRUdcdBkfx6vP7EUs/c0mVsaOdE3L61VgejDnA3i1U4bHfXVYne5vOkQuPT0k5doUXpQdCjmIGA2x1lfgYo9M0dkr+MmbxvGGbcPYc/TYWjt+8Uo4/QCEGXLwfY27Ua81JsHCVdyM1FRnlG5XpN7c2Vadf+9LDKxbHdW9vfHuVOtwpYNxUfLcoP7pwnhtSMZymJvfruHl+BmCJH5Eu6VC5v8zlC7jztO5QZRLkwwI+aNhrDCb3oWpTijWSoPAHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0BdFhms2RksqHo8MvR+60+ndoZp/IRko5In/J/r2/4=;
 b=yRj7Eu/yZVJG6Rh5WZsFibBGeS8gPaTYaTGyCl+rxfZXpRMDLESpG3JAvrL9T/0SrQTmVF3VYKYZscbEcdhcPAlpMbcDfpkvt1WZT8L0C4PqM8ig6FO1pqEftmM0C8AGNMQ8viuvtgheZth1Low/+vM3xf0zxTtQf+TkpKt4cyM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 22:51:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 22:51:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Minxi Hou
 <houminxi@gmail.com>, "jwollrath@web.de" <jwollrath@web.de>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Eric Naim
 <dnaim@cachyos.org>, "Pinninti, Bhuvana Chandra"
 <BhuvanaChandra.Pinninti@amd.com>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Antonio Quartulli <antonio@mandelbit.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: 7.0-rc4 dcn31_program_compbuf_size trace
Thread-Topic: 7.0-rc4 dcn31_program_compbuf_size trace
Thread-Index: AQHctUi/s/tP9U7CjEC9hOZFrJoOxrYT0HqAgAMytYCAAOhwgA==
Date: Wed, 20 May 2026 22:51:20 +0000
Message-ID: <BL1PR12MB51446F6F4534CBB69C7F979FF7012@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260316094232.6bb6f0bf@schienar>
 <20260518080835.100682-1-houminxi@gmail.com>
 <3e181f99-42d3-484f-a89b-2f5955146a5b@leemhuis.info>
In-Reply-To: <3e181f99-42d3-484f-a89b-2f5955146a5b@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T22:50:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6165:EE_
x-ms-office365-filtering-correlation-id: 1d93b61d-919f-441b-b603-08deb6c24f3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|4143699003|38070700021|56012099003|22082099003|18002099003|11063799006|6133799003;
x-microsoft-antispam-message-info: ga8Q+5JPvxNNyiTyjIGwTqSH1q8tgx2TmAbrje97772Gm2va10VHCzChLhTITcZRxwo0Q4uIY95QNYTmeDuX+2VJUvBSNKCdMqgxpL1+SvWMdGta3XMtjPrDeAvkaefiM5E7QINvOlKLbZJhoaggiXKFDtFVAU5VIipYoV/6+CDE2LWAVbITu4SLatB4hU1a/+MBk9TA47Q6/HVojLGT8QuT8uh6etd9wGDjuhh42KIzd0LaAmx3HOfDmnVAgNNNSfg6mkTLZbxTAbT9wKPxMiXYGAhzqtHLtCKIPPdnrZCDTR90USOyOGf0V7JKgHlSGM1nZAWJ//INw2BvXpLN2aDE/WgQcc/cbULXBR/IR04iRLSRGrw5QV6ZevxVDNCMTxByVUbc6qxy1ogOqKAUNDmaZzebgIXeundKs82N3+UBkmsY0f46kv1VJbzosteX6viyaYZvRYpGomx5WTiWxJ6HxbpSIVBlNcviWzxJukeUCKpaaW0Ggz+4J7o57RaPV06y44jIwqQYSutLkuGG4+Bg5MdN6oT82rB8vMQLP2pRzml2WvRUF3ngsebaPzW7uuOEHQGhuqIAZbhS7d4hOAB2I/SYl7C1morISMdsI6XLXVusGswLxHoqN/XKopzfs8W38zfTy60gwRk3eV0fspFy4e5ZNX/wjodMpULYsnrX1GTQDkkgFdyfP+pQYb/EDwfBVUF8wKFt7YxrTP/4lQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(4143699003)(38070700021)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUIxdUNaQk5LTEVhbmZHOC9NTkE2bHdLS0dXRGl6a2cwYndZOHhxOWp0Z3pZ?=
 =?utf-8?B?UlBEK2xzTVhzaHhaMlRsUFBEZFU1anBmZjBwQU5oTW1KcWVQVHRvZGxzUUx5?=
 =?utf-8?B?cW5vYjVYNUE4dFQ5S0MzUytvdDc1enNCSk9WL0o0bXJzME53K0c4UkFGTTVj?=
 =?utf-8?B?bDFHR0ltU0RiV1VIcnFqNUQ2T3d2dmorc20vRWc2NnVxYXVGY29oZTJlSkZp?=
 =?utf-8?B?V05nNmFQNlgwNUplczZYQ2tnSWFDWGtzOVlFRWpzMDd1SXRmeGQxNjYzaVA4?=
 =?utf-8?B?b0JjTEFkTkpmMUh3S0RRcGJMTDIvanNqUmRab1ArZkZMMkgwdHdubWFVMDNY?=
 =?utf-8?B?cHB0TDFwNDQweEhZVWlhTFU5dXN6S29MNVVoVEpUSnNkUmEzeTlHVk1yRHhx?=
 =?utf-8?B?RTRSQVExbm5oQWRxeVlCbWpVRzRWdmhkbHJMK2NtTXZzZmhXRVZrcFI1b0NC?=
 =?utf-8?B?RWpKOHpNZG92RmNHU1l6VUdtc1FVL2QycWUza2FGV0VzUysxemRYSllWUGlr?=
 =?utf-8?B?dXRWYTFNenY2M0tPcnU2MzBBb0hheFpxc2h0Z3FNaXp5bFB1c1k5YTdydEdN?=
 =?utf-8?B?c3BDcVdyYVZxUEN6YkFBMHBxQ01jNldjc3NLM2NNRXJBRk5aNXBYZ1daU3JJ?=
 =?utf-8?B?WCtISTVUYnhicE1qelN6YzhhM0hDYWM0QnRlVHBKWG45KzNaeUNyajNDcWY5?=
 =?utf-8?B?RWtTbWpKMC9XdmpTaGhOVDdPTlZIMWJobURIcmJYOHFmcElFOGRpZGNiK1hN?=
 =?utf-8?B?RHFuYWRGTlI0Zi9wL1RvVGxuS2NCUXVlTnBxaFZOYlNwcGpXT0M0TzFFcEk4?=
 =?utf-8?B?VTBzUlN6ejhNVGJMa2x3Wko3cWVSNldVRmNoTmdrUXc4cmoyTWFMYVEzdnhD?=
 =?utf-8?B?dCt5bVJrZGlTSTJ6WGU3eUVQMEViNEZBenZ2eHdhSTZrOER6OXdUWituT1ho?=
 =?utf-8?B?a2F2YVlQUHJEYVVUbGxKS2N3SFlGbDl1cEZxSDVZN2ZSUlRTWVNmc2ZlN1ph?=
 =?utf-8?B?YTNFODBiR1FkMktsdWxkRVJMMkYySmttRkRFdktJYmpjT2NmVm05d2JIUTh4?=
 =?utf-8?B?azM4WEVSSDlGK3F2cWN6WGpJWml5SVViMGkrRWxNMW5rM200aGtleGJ0TEFN?=
 =?utf-8?B?cGVNV0xEVHduaW1zcFIwT3Y0MHgyQkpzZ3FDeUhVaE5GVlVTdEZUSDF2VWxs?=
 =?utf-8?B?YXhXdGhoMVN4U0lSZTUwVGdva1JnTDV3b2pvajlQRjFmVEhBWUpicWtXdDFU?=
 =?utf-8?B?QkV6OUZlK2FMMUdzRzRKMmk2dW9NWjF3cXNYNHc4bHJKN3lkN283SjhYa1pG?=
 =?utf-8?B?Z2lVQUdDS284dlJodjBXVlc4MUhuVERZUCttMU5ZNXU4eVpkZFBoNDVLM1RV?=
 =?utf-8?B?YW0zRE5aTnBXb1JRQXJBbFVicTJibXZ4VHpKZUVxWWJrSjJvZ3Vvb2VlUmR3?=
 =?utf-8?B?aEVvbmxCOXZ3cDZMV2JGcG81c2dGaVlKMVJsYWQzVEhyYlRRdHMyVDhTbWU2?=
 =?utf-8?B?ZFdueDRCWGhaVE1FZ1pRQUxRSzlOamVhRklvcGQwMEg0WmVLRHdxRXYrOENt?=
 =?utf-8?B?S29sNjVGRzVUTEhEeVExbks1UXNmNU94QlFmZFczNTRFSjN2UXNLOVBHK3A3?=
 =?utf-8?B?U0p3Q1hLUjZQMXlISWRZS1lMODFuTjd6ZU0yWXR6OHRlSXJzSUdxT3BBdERJ?=
 =?utf-8?B?QTh0WWRTY0lYREFlWTVPSmh1a0JUcXIrem5vbklQaWN6Ly9CR0xydFBTVVNN?=
 =?utf-8?B?YkE4WFpqTlFxODZaa3FJd3l6YnN3NjA4cFFqMG1rVWZiaUFiUjdBR3dEVVo0?=
 =?utf-8?B?TjArMEZrV1U4ZVdrNHNxNG1jM29OWnRBY3UwK1VhOGxLMGE0Z2g0eEloa09D?=
 =?utf-8?B?bVJJZjRpNFBQOElXTzFEMEIydURiSkNabVE0bFBmVjI4Y2I3bmt0YUFjNTdQ?=
 =?utf-8?B?OVB5TTNpWHFWaUZTR2xQSm5icXpWbk9Bc2VpU2ZkQnJkdW5PbXFUS0xoVW1L?=
 =?utf-8?B?eDRLSUw4ajZjNG4yZU1uYlB1K09xS1ROMTdqMmMrV3QxUUIxYk4wTDVjbURM?=
 =?utf-8?B?S3k5b0VWeklGUWhybDZtam10RTBOTHpyYjEwdGJrUm4zN1Y4Uk1IUlNFVlpO?=
 =?utf-8?B?U3Q1TVBuSVNqRE1GRTZFaFFISEdaRmJVRTVZbzZJY05TTzBFZHpQMEx2UUla?=
 =?utf-8?B?am1ZeHl4NzRsRTZlNjNlemVxUFBuNmJHSE4zRTBiaWxMamJvSFN5dHBFLzl3?=
 =?utf-8?B?bHpMUFhOTVVPSkFyZHBjNm9mTE5WWmdYeXM2SW5iTjVwSjVHUklwUlE4c0w1?=
 =?utf-8?Q?9aWxbLuQF3OPh1Uxwj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d93b61d-919f-441b-b603-08deb6c24f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 22:51:20.1781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAGoKcCm9hKQTkIPcRW4W5tFjtKt974S5UUMJbaYak0jJ3pIDNNOOAylXBkFF4pM4PHAFzLXAXPnyjxLvQMw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

QU1EIEdlbmVyYWwNCg0KKyBIYXJyeSwgTGVvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIwLCAyMDI2IDQ6NTkgQU0NCj4gVG86IE1pbnhpIEhv
dSA8aG91bWlueGlAZ21haWwuY29tPjsgandvbGxyYXRoQHdlYi5kZQ0KPiBDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IEVyaWMgTmFpbSA8ZG5haW1AY2FjaHlvcy5vcmc+OyBQaW5u
aW50aSwNCj4gQmh1dmFuYSBDaGFuZHJhIDxCaHV2YW5hQ2hhbmRyYS5QaW5uaW50aUBhbWQuY29t
PjsgTGludXgga2VybmVsDQo+IHJlZ3Jlc3Npb25zIGxpc3QgPHJlZ3Jlc3Npb25zQGxpc3RzLmxp
bnV4LmRldj47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEFudG9uaW8gUXVhcnR1bGxpDQo+IDxhbnRvbmlvQG1hbmRlbGJpdC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogNy4w
LXJjNCBkY24zMV9wcm9ncmFtX2NvbXBidWZfc2l6ZSB0cmFjZQ0KPg0KPiBbK2EgZmV3IHBlb3Bs
ZV0NCj4NCj4gT24gNS8xOC8yNiAxMDowOCwgTWlueGkgSG91IHdyb3RlOg0KPiA+IE9uIE1vbiwg
MTYgTWFyIDIwMjYgMDk6NDI6MzIgKzAxMDAsIEp1bGlhbiBXb2xscmF0aCB3cm90ZToNCj4gPj4g
d2hlbiB0dXJuaW5nIHRoZSBkaXNwbGF5IG9mZiB2aWEgJ3hzZXQgZHBtcyBmb3JjZSBvZmYnIEkg
b2JzZXJ2ZSB0aGUNCj4gPj4gZm9sbG93aW5nIHdhcm5pbmcgYW5kIHRyYWNlIHVuZGVyIDcuMC1y
YzQgd2l0aCBhIEFNRCBSeXplbiA3IFBSTw0KPiA+PiA4ODQwVQ0KPiA+DQo+ID4gSSBjYW4gcmVw
cm9kdWNlIHRoZSBzYW1lIHdhcm5pbmcgb24gZGlmZmVyZW50IGhhcmR3YXJlIHdpdGggYQ0KPiA+
IGRpZmZlcmVudCB0cmlnZ2VyLg0KPiA+DQo+ID4gTWFjaGluZTogSFAgWjY2IEc2IDE0IChQcm9C
b29rIDQgRzFhaCksIEFNRCBSeXplbiA3IEggMjU1DQo+ID4gKEhhd2tQb2ludDEpLCBrZXJuZWwg
Ny4wLjgtMjAwLmZjNDQueDg2XzY0Lg0KPiA+DQo+ID4gVHJpZ2dlcjogSERNSSBob3RwbHVnIHdp
dGggYW4gZXh0ZXJuYWwgNEsgbW9uaXRvci4gVGhlIFo2NidzIEhETUkgcG9ydA0KPiA+IHVzZXMg
YSBEUC10by1IRE1JIHByb3RvY29sIGNvbnZlcnRlciB3aXRoIEZSTCBzdXBwb3J0IChkbWVzZyBz
aG93cw0KPiA+ICJEUC1IRE1JIEZSTCBQQ09OIHN1cHBvcnRlZCIpLiBDb25uZWN0aW5nIHRoZSBt
b25pdG9yIGF0IGJvb3QgY2F1c2VzDQo+ID4gdGhlIGZpcnN0IHRpbWVvdXQgZHVyaW5nIGluaXRp
YWxpemF0aW9uOyBzdWJzZXF1ZW50IGhvdHBsdWcgZXZlbnRzDQo+ID4gcmVwZWF0IGl0IGF0IHJ1
bnRpbWUuDQo+ID4NCj4gPiBUaGUgY2FsbCB0cmFjZSBtYXRjaGVzIHlvdXJzIGV4YWN0bHk6DQo+
ID4gICBkY24zMV9wcm9ncmFtX2NvbXBidWZfc2l6ZSBsaW5lOjE0MQ0KPiA+ICAgZGNuMjBfb3B0
aW1pemVfYmFuZHdpZHRoDQo+ID4gICBkY19jb21taXRfc3RhdGVfbm9fY2hlY2sNCj4gPiAgIGRj
X2NvbW1pdF9zdHJlYW1zDQo+ID4gICBhbWRncHVfZG1fYXRvbWljX2NvbW1pdF90YWlsDQo+ID4N
Cj4gPiBOb3Qgc2VlbiB3aXRoIDYuMTkueC4gQ2FjaHlPUyBjb21tdW5pdHkgYmlzZWN0ZWQgdGhp
cyB0bzoNCj4gPg0KPiA+ICAgY29tbWl0IDU5MmM1YjgwMTEwZDVlOWU1MDg3M2I1MzY0ODE4Y2I2
ZjQwMWUyNmQNCj4gPiAgICJkcm0vYW1kL2Rpc3BsYXk6IE1pZ3JhdGUgSFVCQlVCIHJlZ2lzdGVy
IGFjY2VzcyBmcm9tIGh3c2VxIHRvIGh1YmJ1Yg0KPiBjb21wb25lbnQiDQo+DQo+IEFudG9uaW8g
cG9zdGVkIGEgUkZDIGZpeCBmb3IgdGhhdCBjb21tZW50IGhlcmUgd2l0aCBhIHJlZmVyZW5jZSB0
byBhIHdhcm5pbmcNCj4gdGhhdCBvbiBhICp2ZXJ5IHF1aWNrKiBsb29rIGxvb2tzIHNpbWlsYXI6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDUxOTE0NDUwOS4yNjQ2NjgwLTEt
DQo+IGFudG9uaW9AbWFuZGVsYml0LmNvbS8NCj4NCj4gV29uZGVyaW5nIGlmIHdlIG5lZWQgYSB0
aWNrZXQgaGVyZSB0byBnZXQgdGhpcyByZXNvbHZlZDoNCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zLw0KPg0KPiBCdXQgZnJvbSB0aGUgcmVwbHkg
dG8gQW50b25pbydzIHBhdGNoIGlzIHNvdW5kcyBsaWtlIGl0J3Mgbm90IG5lZWRlZC4NCj4NCj4g
Q2lhbywgVGhvcnN0ZW4NCj4NCj4gPiBPbmUgdGhpbmcgSSBub3RpY2VkIG9uIG15IHNldHVwOiB0
aGUgYW1kZ3B1IGRyaXZlciBkZWZhdWx0cyB0bw0KPiA+IG1heF9icGM9MTYgZm9yIHRoZSBIRE1J
IGNvbm5lY3Rvci4gV2l0aCBhIEhETUkgMi4wIG1vbml0b3IgKEJlblENCj4gPiBFTDI4NzBVLCBN
YXggVE1EUyAzNDAgTUh6KSBhdCA0S0A2MEh6LCB0aGUgaGlnaGVyIGNvbG9yIGRlcHRoDQo+ID4g
aW5jcmVhc2VzIGJhbmR3aWR0aCBkZW1hbmQgZHVyaW5nIGNvbXBidWYgcmVwcm9ncmFtbWluZyBh
bmQgbWFrZXMNCj4gdGhlDQo+ID4gdGltZW91dCBoYXBwZW4gbW9yZSBvZnRlbi4gQWRkaW5nIGFt
ZGdwdS5kZWVwX2NvbG9yPTAgaGVscHMgYnV0IGRvZXMNCj4gPiBub3QgZml4IHRoZSByb290IGNh
dXNlLg0KPiA+DQo+ID4gUGFydGlhbCB3b3JrYXJvdW5kOg0KPiA+ICAgYW1kZ3B1LnJ1bnBtPTAg
YW1kZ3B1LmdmeF9vZmY9MCBhbWRncHUuZGVlcF9jb2xvcj0wDQo+ID4NCj4gPiBBIHBhdGNoIHBy
b3Bvc2VkIGJ5IEdpdXNlcHBlIFJhbmllcmkgaW4gdGhlIENhY2h5T1MgaXNzdWUgdHJhY2tlciBb
MV0NCj4gPiBjaGFuZ2VzIHRoZSBSRUdfV0FJVCBwYXJhbWV0ZXJzIGZyb20gMXVzKjEwMCB0byAx
MDAwdXMqMzAgYW5kDQo+IHJlc29sdmVzDQo+ID4gdGhlIHdhcm5pbmcgZm9yIHNldmVyYWwgdXNl
cnMgd2l0aCBEQ04gMy4xIGhhcmR3YXJlLiBEaXNjdXNzaW9uIHRoZXJlDQo+ID4gaXMgb25nb2lu
ZyBhYm91dCB3aGV0aGVyIDItMTB1cyoxMDAwIHdvdWxkIGJlIGEgYmV0dGVyIGZpdC4NCj4gPg0K
PiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vQ2FjaHlPUy9saW51eC1jYWNoeW9zL2lzc3Vlcy84
MTANCj4gPg0KPiA+IE1pbnhpIEhvdQ0KDQo=
