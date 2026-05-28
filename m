Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5B0CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 22:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE7210F66B;
	Thu, 28 May 2026 22:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVuuGAbA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB18110F66B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 22:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVxLO7PF7VlEDpL56xii/XGnR4HPbGd31o4E16bn6LUYvE14QSmCiNzevE6wjaWYB9HEsvKpBwZCw6zMro/ydxz800auui8/OJwgUBwvMsI8SmtWN6h3+FyvfuzMkqcqKx76Pkql5m77oq797qehI8q1xdW6Y0vxbnEVPvIMkgVCQN52lpXsQmaHHzLXJJzf1AIHfs3bicq2IRogxi4Z+0HMYmNKigclGOcOknKilYcEU/Yqs/H+CcBaQY/kN998xcevhoccGARPqfIlpvEaFuIqlNzhtT+n55DfZgSHU2C5YlMh33MMbwK0hCmDdPXqWB5/5GMBdZq+z8VzZjTzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlERm+Fy5zDhMWFVWB7S/lb5Nb/oBa5zjYumb7mIiZI=;
 b=lbzk7D8vO1yZ8dnA3OpzL0blHA+p1iDBk0851dWcmwg+sRH596xJf9UgxWKIaNplCeS2hQ9Tope6nrnulJvjYpIldNSY75j7IvJZNZsAzQOoV4RLS4vnUpjrUOPo6/w8zlI8keL4YsEg/s4S/IA+vjh6dmiFuDqGQ2UOmLbbMTileo+JQ4KkBqwOFBFPakFveI27w19INLLF1DPoQqdFpF4uNbqKyMB0KOocHp/EK7A/KozYX/WBRXvFlok339S1XHBd6IID6r6sJgcxG0rabjTnGexVP3UMJm8YfqQ+40cMm8vicPuYajoYg85FJvyzU8zSL5AR8CgDBQ4VZyNTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlERm+Fy5zDhMWFVWB7S/lb5Nb/oBa5zjYumb7mIiZI=;
 b=pVuuGAbAv9YsZRQ3A5RC3iK22i5hkeJNF618lmXjLWgelQ5vEVXliGSIkYOg1DhtqXudZ2f4yPzb+doA3HExdV7P9eFygmBJDxfMTRfa4N48alOLfqX6gVCDE82gvohf3ORAMPBXMY5+vHCOa5AHOCTsrZ4cSlfkeYMeQ8zS5yk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:02:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:02:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>, Pei-Hsin Yang
 <peihsiny@valvesoftware.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Linux
 kernel regressions list <regressions@lists.linux.dev>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Topic: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Index: AdznyYW5KuL81IotTPmWr+1olc6y4wAY6MWAABDxboAAH/h2AAForNCAABaFTtA=
Date: Thu, 28 May 2026 22:02:57 +0000
Message-ID: <BL1PR12MB51447AB016BB28843BAD0216F7092@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <1c522568-1d5e-4210-8f25-1aa96e0d3c3a@leemhuis.info>
In-Reply-To: <1c522568-1d5e-4210-8f25-1aa96e0d3c3a@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Harry.Wentland@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-28T22:02:14.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7379:EE_
x-ms-office365-filtering-correlation-id: 1e430e65-e4ba-44e8-0727-08debd04e044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|5023799004|11063799006|6133799003|56012099006|4143699003;
x-microsoft-antispam-message-info: kM9/xZy+qSYN81lmsuqqoThKn2Xe9/4pT4hypcqTNHMT5uK59Q1Ud1ErkVYeToRA5sMS/xiGtf9UXefhyruGZqlnruRbaYhqUkXZBPVcq+49XIkzVVoBpr5vxgo35T6/xFpPSCj0adIMy4BeDHEfXzTwipQtYZNZsKT/h3uEgUuh1XyWfF6sVttMUJdB5e7P6aeH2ntb2QGrUgrMl5EPlXndDxcEG+6Nu28QnWZbAjA083/RJoNDPGFZEhbnShVsMUImv79l1/cERpwb6P0awnv/insnY7JTEzl/8LExCIrSTLsVB3nDFnLIv6iu2aOR1WJ/9FLDuT7l6ZM0XQw87jAJvVVVsJNAcX2e64oDSkLU77KbV/9W8T0+gIpC6S5Tl5WlwY7xsiKrOCzKYvZRHIGeySViSpkvADcr0o90bob5PZp7AtofuMTqlZHDvqi2UvzQch6H8ImWgRaIz/L95ERIpy1aoWiE6mgAMgx1JMATiWVG8TRivKTEGqyQjk8jValwDRXlh5wkbhlsVYavpfV6nbVNacIiKItH9mvRnN+otmE+662qW5vnug5FhQnQ1OAuU25TZKLMuiAyKD1ehVs02taGqtwGmb+LXNd0GnCih+eBQFIIZ+htYBAVTTDXqqnULbm+fV5qNO6ShQ7iIb9zVHiGmi3c7zQt2n+Cg3nx1nBszNjCq/1JdVRR/BVmfpXJwdhgY/H/WS7CqTwf1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y25aV3lOSlpLY043RFBYQzZJMUxBN1ZTR1JWU1ZwQ1J0c2pOazRucHdLRVMv?=
 =?utf-8?B?V0tzeTNEUU5aWjRQOFRFcnBvbWkyQ0hiMmNjWEZVcU11Z2lTQ3g1eDlWN3hy?=
 =?utf-8?B?cHJqanMrdTV1U2p1cnRHY1IrYXJ2RkRJQXhvcFc3WmpuR0dOL2lyclRZeVFT?=
 =?utf-8?B?Sysvc1VKNndBcmV5Z3lHYVcrOURuVmM5WG12MFo1ODRNU0hPM0w0blhSZjlu?=
 =?utf-8?B?NkF6YisvY2lTamlzVEVjYWh1WkZ1MXQrZ281OW5vcGkyVWtMeTNuUUc5b213?=
 =?utf-8?B?NHdGK1Q2em5QTWJyREYyWjFOSk93TTFKT2d1RWlUVkVva2N4bUh1VG96RXpZ?=
 =?utf-8?B?WDJJQ1BoL3ViekVGSU83K1A3UkpvWHNNQjdYK2hZTjd6SHVncDNlVHJyZ0pH?=
 =?utf-8?B?bC85aDVKMDlDMjBsaUJZelNxc1N4YWZsdWFzc2poRFl3YmhIMjBLaSsrMU5r?=
 =?utf-8?B?YW8rb2RhS0NaTE1GcFBaakp0TWFZSjkxL3JGWTZjbkEzazVhQXhCUWJ5bXh2?=
 =?utf-8?B?UTQ0UkdFUUthUlVkSU8rZjlUY1p6RUc3aTUrTW8wdE5RNVRLRkpTcm95MVpD?=
 =?utf-8?B?MHkya1VTRzhHOEdpTTFIbWZ2dVVNZTFVMmw1MWFDY0ZZRmdPdlB3c2I4MUpW?=
 =?utf-8?B?UjhkcjhFUWF5WlNPSTM0UkpnUGs3OXdkUUVnRmRUa0FVazRtbXJQYmU5Nk5u?=
 =?utf-8?B?Vy9vL3I3Um9kYXFmRTJmNnY2U2NoWFVuYUZMYW5lL0UxSW0vcWl5N1lLWGlt?=
 =?utf-8?B?eFY3K3BSL2x4UXhhRGpjR2o1M2VoZ2dBRkphYXNGaVltUlZxRGJCZFhpdG0z?=
 =?utf-8?B?bXFhbFRHQnF3ZGZLMTRvSUhIeVFIOEJURVhzV1k2UGhzb0dDV1dCTU1vZDlN?=
 =?utf-8?B?cGc1b21EUnBLbk5nTHloMzE2WjlJRGRMRUxUVVF5SFBMM2RtWXo5bk9sK0k2?=
 =?utf-8?B?MXJFTFBLd1FrN0hVaXpkZGxOUGF3UExPQTFRNk9SZ1RvWktXMjNRbFNNNkEz?=
 =?utf-8?B?Z0IvUzBNdk9tTHNROGpNRGxidEs3L1VoZ3J2RXN3TjdsbGJmYkFPMzFUTkpG?=
 =?utf-8?B?OTJ2SUxkay80OGwrQVBnQUVUdVduL3UzcjNoKy9QMnZQeUNPMENFV0RGL1Ev?=
 =?utf-8?B?ZnhLZ040WjJVUlRuRzBGanR1OS9xMkZmcEw1ZkFMMUt5SFVGSFcrOFhmWFIx?=
 =?utf-8?B?REU4ak1TaFV0U3VnZzZMbW1hbmdCTGxwTmVMTU9MWVMvVWFRQUhLUno0VHJ6?=
 =?utf-8?B?QlZvc25WbEhOOUtmSVJIdHFHUTZGOVV6am5zSzRMdmtVbWlpd3BSQ3BXanZl?=
 =?utf-8?B?R3VrbXVSR0FaWG40M2tZdGMyVDZoUzZzNEJveGJkMGFmaHNZdnZHS0dOM1Qr?=
 =?utf-8?B?dllubnVpV3JydHBhd01OREU0U0lxTVRxVkxRZC9mWlpORnNIS0k4czdsdmZF?=
 =?utf-8?B?SGcrcFV0Y2FOaWhZMGlNZ1lSQTlmM0xkYWFCODNKRmdydEVZT0RCV2lyTkR6?=
 =?utf-8?B?T1lHeHlLdFg0YkwrcE9TZGhKRTJacXlZY0VzSGp3VVRFMEs3cG1RaU9MaExR?=
 =?utf-8?B?T1hIVC92M2M4dTNsMzlzY3pvaFdDNjRHaTZSd0NFVTBYSUZQMEVHOFk5ZE40?=
 =?utf-8?B?Q053OVNMZjFSQS8zU1ZIZ3BOeTdpdnU5K0dPdEN5eE96cHk1ejcvTkRVRCtO?=
 =?utf-8?B?RUtSZEhRQ3F4L21COEZBbWVnRThCUkVYeW1KYldaNmRiWDJ6Y2REN2xGNldz?=
 =?utf-8?B?ejdYSWN1bVNibzd4OVZnTTNMMENzaUlJajhDUitpZDh5NXA1Mm5wMW1LOGQz?=
 =?utf-8?B?bFBoS1ZXOWVaQ0JuTkVjUFdVN3FDRmJDWWhyWXA5RXZYMFlJNGM2bmEyZ3hD?=
 =?utf-8?B?MVR5cEk0cmFXWHcvYkVtV0xuTFU2T3RpRHo0VlVzL1VuTXVtK1VNUlIvLzhZ?=
 =?utf-8?B?cXpiaUR0ZU5aNTJJTi8zdVJtbzZRR0h0OTNrUEo0eUhmZCtzQ2xPZUg1TkMw?=
 =?utf-8?B?cFBWV0ZoMkpIYlh4MEd0djJWWDNwMFJWK3c5TmRGWldZM2Jxb0hvQkZ2T0tW?=
 =?utf-8?B?R3B2VHFQR3VyMGxqUEpYb3JvSmMvU1BRbzl4VHRDOEtSTDd1Q3FhVU1ja050?=
 =?utf-8?B?bmpkUHhPd0RONUpvU2FQa3lxcFFDVkFyWEV5dzRpY3A5cTFWVnFQejJVdERS?=
 =?utf-8?B?dVN5WVRRWHI5OFZ5Y0VReXppZzVIOW5yTHZUSmVjOUVvQ2ZjbDBvaHVoOW9Q?=
 =?utf-8?B?QVdzZGRHazFWanhxSXQ2R1Q1UEJncUNjUFJCYkY3a1lDV25zQ1g1SStsSVZN?=
 =?utf-8?Q?OS9uRgIvB4tvCqnt00?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e430e65-e4ba-44e8-0727-08debd04e044
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:02:57.2571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8JWFc2Kx6PCBlr9ROp5UKi7ziQQWPop/oDxtyQBtnlN5OrNNQPwef9grvs+iTIywdATRKSS2SQ+FtBuvGEAqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvcnN0ZW4g
TGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXkgMjgsIDIwMjYgNzoxNyBBTQ0KPiBUbzogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QG1haWxib3gub3JnPjsgUGVpLUhzaW4gWWFuZw0KPiA8cGVpaHNpbnlAdmFsdmVzb2Z0d2FyZS5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGludXgga2VybmVsIHJl
Z3Jlc3Npb25zIGxpc3QNCj4gPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj47IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRXh0ZXJu
YWwgTWFpbF0gUmU6IFRlc3QgcmVzdWx0IC8gZmluZGluZyBvZiAiZHJtL2FtZC9kaXNwbGF5Og0K
PiBDb25zdWx0IE1DQ1MgRnJlZVN5bmMgY2FwIG9ubHkgaWYgcmVxdWVzdGVkICYgc3VwcG9ydGVk
Ig0KPg0KPiBbK0FsZXggK0NocmlzdGlhbl0NCj4NCj4gT24gNS8yMS8yNiAwOTowOSwgTWljaGVs
IETDpG56ZXIgd3JvdGU6DQo+ID4gT24gNS8yMC8yNiAxNzo1NCwgUGVpLUhzaW4gWWFuZyB3cm90
ZToNCj4gPj4NCj4gPj4+IFRlc3RlZCB3aXRoIDMgSERNSSBzaW5rcyB3aXRoIGRpZmZlcmVudCBG
cmVlU3luYy9IRE1JIFZSUiBjYXBhYmlsaXRpZXMuICBJDQo+IHNhdyBvbmUgY2FzZSB0aGF0IGEg
RnJlZVN5bmMgc2luayAoRGVsbCBTMjcyMUhTKSB3aXRoIEU2aCBWQ1AgY29kZQ0KPiBzdXBwb3J0
ZWQgd2FzIGRldGVjdGVkIGFzIEZyZWVTeW5jIGNhcGFibGUgYXQgYmVnaW5uaW5nIGJ1dCBpZGVu
dGlmaWVkIGFzIG5vdA0KPiBGcmVlU3luYyBjYXBhYmxlIGxhdGVyIOKAkyBhZnRlciBkb19tY2Nz
IGlzIGNoYW5nZWQgZnJvbSB0cnVlIHRvIGZhbHNlLg0KPiA+Pg0KPiA+Pj4+IEFuZCB0aGF0IGRv
ZXNuJ3QgaGFwcGVuIHdpdGhvdXQgbXkgcGF0Y2ggYXBwbGllZD8NCj4gPj4NCj4gPj4gVGhlcmUg
YXJlIG90aGVyIGlzc3VlcyB3aXRob3V0IHlvdXIgcGF0Y2ggYXBwbGllZC4gICBPbmUgaXNzdWUg
aXMgdGhhdCBpZiBhDQo+IEZyZWVTeW5jIGNhcGFibGUgc2luayB3aXRoIE1DQ1MgVkNQIENvZGUg
PSAwIChtb3N0bHkgYXJlIFRWcyksIGl0IHdpbGwgYmUNCj4gZGV0ZWN0ZWQgYXMgbm90IEZyZWVT
eW5jIHN1cHBvcnRlZCBhbmQgVlJSIHdpbGwgYmUgZGlzYWJsZWQuDQo+ID4NCj4gPiBUaGF0IHNv
dW5kcyBzaW1pbGFyIHRvIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0N
Cj4gL3dvcmtfaXRlbXMvNTI4NiAuDQo+ID4NCj4gPiBJIHdhcyB3b25kZXJpbmcgaWYgdGhlIHNw
ZWNpZmljIGlzc3VlIHlvdSBkZXNjcmliZWQgYWJvdmUgd2l0aCBEZWxsIFMyNzIxSFMNCj4gaXMg
cmVwcm9kdWNpYmxlIHdpdGhvdXQgbXkgcGF0Y2ggdGhvdWdoLCBpbiB3aGljaCBjYXNlIGl0IG1p
Z2h0IGJlIGEgc2VwYXJhdGUNCj4gcmVncmVzc2lvbiAoYW5kIHdvdWxkbid0IHNwZWFrIGFnYWlu
c3QgbWVyZ2luZyBteSBwYXRjaCkuDQo+ID4NCj4gPg0KPiA+Pj4+IFRCSCBJIGRvbid0IHJlYWxs
eSB3YW50IHRvIGJlIGZpeGluZyB0aGUgcmVncmVzc2lvbiBJIGhpdCwgSSdkIHByZWZlciB0aGUg
QU1EDQo+IGRpc3BsYXkgdGVhbSB0byBoYW5kbGUgaXQuDQo+ID4+DQo+ID4+IFllcywgYWdyZWVk
LiAgQXMgRnJlZVN5bmMgTUNDUyBzdXBwb3J0IGhhcyBpbW1lZGlhdGUgaW1wYWN0cyB0byBWYWx2
ZSdzDQo+IFN0ZWFtIGRldmljZXMsIEkgd2lsbCB3b3JrIHdpdGggQU1EIGRpc3BsYXkgdGVhbSB0
byBoYW5kbGUgaXQuICAgSERNSSAyLjEgVlJSDQo+IGFuZCBWVEVNIHBhY2tldCBzZW5kaW5nIHN1
cHBvcnQgbmVlZCB0byBiZSBpbmNsdWRlZCBhcyB3ZWxsLg0KPiA+DQo+ID4gTm90ZSB0aGF0IHNv
bWUga2luZCBvZiBzaG9ydC10ZXJtIHNvbHV0aW9uIGlzIG5lZWRlZCBmb3IgdGhlIHJlZ3Jlc3Np
b24ocykgaW4NCj4gNy4xLXJjLg0KPg0KPiBZZWFoLCB0aGF0IHdvdWxkIGJlIGdvb2QuIE1ha2Vz
IG1lIHdvbmRlciBob3cgdGhlIHJvdWdoIHBsYW4gdG8gcmVhbGl6ZQ0KPiB0aGlzIGxvb2tzIGxp
a2U/IFNvdW5kcyBsaWtlIE1pY2hhZWwncyBwYXRjaFsxXSB0aGF0IHdhcyBkaXNjdXNzZWQgaGVy
ZSBpcyBub3QgYQ0KPiBnb29kIG9wdGlvbj8gUmVtaW5kZXIsIExpbnVzIGlkZWFsbHkgd2FudHMg
a25vd24gcmVncmVzc2lvbiBmaXhlZCBieSAtcmM2LA0KPiB3aGljaCBpcyB3aHkgSSdtIGFza2lu
Zy4NCg0KQFdlbnRsYW5kLCBIYXJyeSBjYW4geW91IHNvcnQgdGhpcyBvdXQgZm9yIG5leHQgd2Vl
aydzIC1maXhlcyBQUj8NCg0KQWxleA0KDQo+DQo+IENpYW8sIFRob3JzdGVuDQo+DQo+IFsxXQ0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbWQtZ2Z4LzIwMjYwNTE4MTU0ODA5LjY2MDA2MS0x
LQ0KPiBtaWNoZWxAZGFlbnplci5uZXQvDQo=
