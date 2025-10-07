Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1172CCCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 10:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CA910E5D1;
	Tue,  7 Oct 2025 10:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9rNR7er";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0043410E5D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 10:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiF39Rcow1YGj0z6Ow43R4+yS63YZrlzFkXfNCvEVe0XPOayt1L0PMWjVT2uch6qfMu8M4mD5gU6wsxB/yXNXfM6R7RQoP1RngDKvbKZCkFfxqDc5Yix9tBlzdwEsbKHe6EHZG9B5Ci/vLg69+bh/NgaMNyGPqZ4R0QFkRqOQbJqn21zrgc/emVrOx1GqkrdxZsyUBesOU3zD0vkMdbk8yXApsIvSqzb496XFDwkaHncaBo3JdEvh/O+5YUhRoUJnvibrl1Xl8uOBGGJXSc7oJOVOCnS8WrDfP7n1rrF6EAZm/BXyB88wBGdh/wab1TwLmyl7EwdrhPoBcHBPmBqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLxGxzvOx46M15mX/6iFvjgHsMXk477jShJEQJ+Fsv8=;
 b=LRBDFL0GKQlf92A4U5a2GHHfhXk9BQF26toJ0EmTbCjD7qO+JIukdERPL4KGjSY4NAMpO0evhhjliPBzpPM2y7pJuxKs3AB2gDZ/vz27Lln9GYiqpP7dZJLh7j6+3O458QG0mO1oaxHNS4DDd2qdGHtDiZMErYayUfP8imFDr8UTHIyde4BGT5udmtvmj+KKmxx08rm5+KW5j06YIsFwAHeaCmIb68URNHVSEWmkjKXpgxsXwTchT5TmJigyxgIlSkxWd6htHYkVR0U74Z/iAeIOkpt2hWLJQaaFCCdlDbhIZKGn489h0Dihi3luLuluUxGwOy87sBgcOqN2ygA4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLxGxzvOx46M15mX/6iFvjgHsMXk477jShJEQJ+Fsv8=;
 b=u9rNR7erkdNmZFZIbB7CnGRRAO6EZsmti8xWY7f+ADyLSNqEd9Xxds+GoRHeiM/M4sESqvx6bjLrnYL5Z359YfeuzmUGuS0gB2OIfppSC0MQlg3UrMY9gs93JiVoTVYAZQdr9ktDq1a1aig9KIWzMmbxnhql5E/ggZyF3cIGpFE=
Received: from IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:29:10 +0000
Received: from IA0PR12MB8350.namprd12.prod.outlook.com
 ([fe80::ca56:ab90:c6cd:826f]) by IA0PR12MB8350.namprd12.prod.outlook.com
 ([fe80::ca56:ab90:c6cd:826f%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 10:29:10 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without
 VRAM
Thread-Topic: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without
 VRAM
Thread-Index: AQHcN2t/viDXvnXWLUyTbjGP80AwVrS2eu7Q
Date: Tue, 7 Oct 2025 10:29:09 +0000
Message-ID: <IA0PR12MB8350EC511F009E018D745E01FDE0A@IA0PR12MB8350.namprd12.prod.outlook.com>
References: <20251007091925.18470-1-christian.koenig@amd.com>
In-Reply-To: <20251007091925.18470-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-07T10:26:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8350:EE_|CH3PR12MB8936:EE_
x-ms-office365-filtering-correlation-id: 8e0744dc-ecce-47fe-e3fd-08de058c5a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QTZKZ3pOV1I3d3VGdjM4RWExa3dsVVVBMGpsTEd3NStTVzBJcWR3ZE43aTVT?=
 =?utf-8?B?S29sY3YzUVBvVTB2Y0RlaDJmV3YwdXdoNW1LRTA3YnRkN29iSFR3ODdhOHdS?=
 =?utf-8?B?SGRNRVE5VXhFSGo2dE03Z05pM2gwL2hDNXhtQ0FCMzQrTHV6OGVuMkxoU2xn?=
 =?utf-8?B?Z1BnWWpIR3Fsc3NXaVhoZFFjaDVQb3dsSXBuTTRMZGptN1dQM2dvWW9oeVZ3?=
 =?utf-8?B?eVRoQ21wL2c4OSszL1RtTUpoc1hxSDB1T3ZtZENoVFc2N1p4Z0IvbnordGdE?=
 =?utf-8?B?MVdlWjFpK2hNNDZ1VTl2L3ppTCtZTzJzeFBDWnpwMkZRTGVybThHMlNNRTZB?=
 =?utf-8?B?UU9HalNQdkFSTmgxdk5Rakw1TzBHNmM4Zkl4UXBPVU56SGEwcDMrRXRKZ09i?=
 =?utf-8?B?WU5KRjlmQXFieWZTWGg5UVd2R3pZMmZhR09ja1E0YlJoaWZEbUFwcWlJL1lz?=
 =?utf-8?B?SDFGcDVrM0JtNDNmWEU2elU0NU5oQXNlajRmaFpvNWdRWUpUdVBvTVZDZ3lB?=
 =?utf-8?B?OFIvRkRHdVpUeVNmUEZ2VUg1UWtuNitjOVcrWGs2REdmRm9yOUFiSTVDTHkx?=
 =?utf-8?B?L0dhenkyKzM3Sm55UlJ6aDVFc01Ebit4QnhWU1Zoc2xsVW11VXVpbys4SGdF?=
 =?utf-8?B?RGFKQk11V0UxUlpJbXpscWZ3UDJLR1llNHlSUWpnenNOc296dmhtMmtZMWpn?=
 =?utf-8?B?RlpjQ2lKOHo0WXdOMjBPQWxwTnhYREcxOUh6MlhSSUxxUFhFQXY0Q2ZlTHNw?=
 =?utf-8?B?Q2dvT083bjF4dk9mdmNxUHB1ZkxJby80L3pNeHNURXRHaUZTVk0wYXlWTnBw?=
 =?utf-8?B?M21DUkF1NmlpelpxQy9kK0NUeE9GRzVTbzVxSVdqYWE3Z2Zhc2VBMTVadWxm?=
 =?utf-8?B?THdIaE1KZWJGMEpSRG1mNFFoVUxHRGFIRTF4elU2SHB6WnlyVGl1TUg5ell6?=
 =?utf-8?B?Yzc4Vi96UCtXNGtoZEpTdWlKMjdzY29sbUR3VENIOE1PN2xUbmNyWFVORUNN?=
 =?utf-8?B?OVltVm9wRWlKb21McUl2TE9vSnZNWkxyNnM2Z3UwMWk5OXRGSnZaNEJHL3BE?=
 =?utf-8?B?b3VOdWU5aXFwUjYxWllBM1RFNGw3dkJGRFhtZkI4K3l3SDBUdi9EY2JMUDBX?=
 =?utf-8?B?ME13dmdRZnI4UlYyd3BiUDRhS0dPT1Flb3hJQ3RrajdyQ3FzOVdEa083MEpu?=
 =?utf-8?B?S0dkNndINWN6UCtadWNEN2NTM3hnK1lmSG9VaVF6cUl5OXBSSDUvY282QzVi?=
 =?utf-8?B?a2RlZ2d3STRDNUlVaVdMcTVBb0I2TmNHajRhcENiY3I1Z2s3NEFBNWc5SjF6?=
 =?utf-8?B?OWxGZkZ3UlpZSlk3c3ZGS3ZrR1Y5ZU9yWXp5bmpuWWxPdERNMzdYMng1ZTdk?=
 =?utf-8?B?blliVmNodjVnUno4SGVkZFZJbTB3Q0I5TStyVXBueUk1NjZTZGpiR1duUHh5?=
 =?utf-8?B?RjJvZHRmRnZycHIxODhvSDR2SklycHNYcEZDR3pBeUk2clVEcnk5U2tFSDlL?=
 =?utf-8?B?bTd5ckpkYXFtNE5yYlZWN1NjaVAvbDU0b0M0Tks2L0Q1VjRWdi9GdlNkY3Zv?=
 =?utf-8?B?aDFobVVlSXZrOE9OUnY0RjR3T3VWbzBNZXdBKzhmYmVMZW5OVWE5MS9QTk10?=
 =?utf-8?B?cGVFaGVva3NtUzlLaENKRnhMcmZMK3hyZkIvb0JZRi9rQzNwTytIc3drdG9H?=
 =?utf-8?B?RWJ4STVtb3dXaWhrZXFKODd4Z0JsWll6NzBCM20wRldpZVhieXRFOWhibk1N?=
 =?utf-8?B?c1NMSTRVZERRRmY1ZFBObVdFOE1udFE5ZVQ4UW1qaGZDQTVoTjh4VXJLNWx1?=
 =?utf-8?B?UXF0eHBVUlBCbmxwVk95OVUyb1IyRWdRU3ZaVTBjVEh2Z2pOZUFHRE5nekVk?=
 =?utf-8?B?UTlTZVI1cStGdlRXdWhlL3JTeG5XTTdqUXJ3WjFKMVFoRVJDWGxROGVlYkx1?=
 =?utf-8?B?Tm1rVmg1ZXM2dVFrbUpqS1NmYnpJYzRUMVZ5T09YK0x1QWN2eVg1S2xWRnlZ?=
 =?utf-8?B?cGxHZVU0T2lFTGJnSDl0RXcvZXlOdjZsTEJsSklzNTYyNFh3amlMVERENGh4?=
 =?utf-8?Q?YnNVa3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVQ5K2FmTkRKeFhaVjlEZlNwMzNIQ2VtZ1A0UFo3SlpmczZKU00rWGhQMzhT?=
 =?utf-8?B?a3E5Ujh2cUdMQmxtcmp0OXY3MVNMVklRUmlzR3RhcFUvcDNqZUNOcEIwV013?=
 =?utf-8?B?V3IzVC8yMVVDSkgydk1ndEtFdlBKbE5ORG9xRUZtS01VcytJdzdUVFZLZEhw?=
 =?utf-8?B?anF4aStQK1VDeDFWWFJkdlVzQ0NXV3VXNStHcXN3dndqSGdSNXVWS3hUYTVX?=
 =?utf-8?B?VEw2ZTh2YzR2b1RrOTYyTVNXWU8yR090NmJnWFBKMC8weHByYzdnQnV2bzZu?=
 =?utf-8?B?UlJ2b1dLTjhiZzdnNzNzMVQwMWVqOWxXZDA4bTFNNzFuclNWZUNhUGdXU0xG?=
 =?utf-8?B?NXNTdGdwMG1mTkVjdHVsbnYvOU1GeElFN2dwTFlROUxqNFhldkx3SGZLTjdt?=
 =?utf-8?B?dDh6bXJhR0xhbWJzMytqNEkvNUpwY3dBaktCelJzU1FFenl3cVlHR0duL3dK?=
 =?utf-8?B?c0NsanA4dVFpSDJjWStQNWZodUlCWmNuc1NpcEllVnRNVjR5b0RhMEwvd3M5?=
 =?utf-8?B?dVM1Q05XdUhmRDBCb2FEQytVL1FPMXdvUTJyL0pqOEN4ckpjTnNHSVA0azFI?=
 =?utf-8?B?R251M1NUR0FRS2xSLzhJMk12bllYTmF2Q3VUSGt0bDVaM0RlczRwNGtPOFll?=
 =?utf-8?B?Wk9CbU1nMGdJV0w4QUhUY1FuZzNhSzluV0JSc3p0MXE5UFdMdmVVZWtIeDdj?=
 =?utf-8?B?b2JBeENadjU3U3FhSndvQy9ieFBWTERsV2NQNkg5S2JVNm9WcFFGK0UwM3Iv?=
 =?utf-8?B?STQ2MDk1Y1o5NFF6MnVHWk9UWmgwbFF5b2YyRHdvOVZIc3RkcFFEUDVjaVgy?=
 =?utf-8?B?NHBSbGl4bTRiUUtCUWM3OEJGd2hTWGpMZ1NPeW8wZko5TWczc1FyY0hZRUli?=
 =?utf-8?B?Ty9WMnFMYWU2TkhFUWR6NnFKdk9ITHErb1VaYllUZUtqYUUxZTlPUngyVHJT?=
 =?utf-8?B?WldOTGVjSFkrSC9MQ0lEOFNremRVbUdvdUhRUnRvV0RtY1pZZlh2V2s1ZVhV?=
 =?utf-8?B?OTNnaUpTK0tnV3VVRmY2UjMydkZXOVdxMmNVM00yVTdGUGRvVFdzZkVwMXBD?=
 =?utf-8?B?OUVLTmRWbEkrOFljOU12aU1abEtOeXMxb2JYbzcyVGc4QTVDUi9MelZtTnlM?=
 =?utf-8?B?bG13Sk9wN3B4VnpBZ09BRk9JL2tqZ1JGWXNqSVh5THhmRFJYRzFrUzFBM2g3?=
 =?utf-8?B?TlllV3RIY285OWVDcE55S3ZveWV6MlJBTGhHT3pxMWRmUVFMOU5XSnJ0c05s?=
 =?utf-8?B?bm8rSFpUNnNvRTBIUVNTZVpubGpwalVpbWt0dkhkV0xkTXN1TThYVjd6RVg4?=
 =?utf-8?B?enhJTFR1TXAyVnFzK0xaNFhzei8yTlg4T2d4UUNCaFZTN3VhVGl3YXBEUS8x?=
 =?utf-8?B?SnVpbDArNy9OSGZHNGkxanptZHlJV3NYN0tINDkwRVJTWFZBKy9KendGOUt3?=
 =?utf-8?B?b0MyVklnVDkwZVdHTlNNT1ZIMUxWZlBRdUZyTHlIdUZsSmRmMDZHZ1piTFFJ?=
 =?utf-8?B?QTNSQ1BvM0lVSmNkdVNrMWpQeUdDQlVGVFJFR2JOdU4yd1BaQUZlQy9YMStH?=
 =?utf-8?B?am92NFZ2N1VwTGFNbWxjSHhPOWhIdk93Y3N6RnBCVGdYZUsxL1RVY1JoOEhx?=
 =?utf-8?B?WFI3Wk5udVdFVDFISWZBOEF1eEZLRjh5cTZLRjV3Q1NYZnNqaFNtbDNMUndY?=
 =?utf-8?B?Z3V5b1hQaFVrUnRpRlJTaVBnTWllZ3ZBUklJcldhczlybWtlQjZYR3dnZWgr?=
 =?utf-8?B?QzVmbWxwZzhBc0N3b2tnTldDNjVKYnkvMnJWUmdkNzF2VnZFK3M0US93bWph?=
 =?utf-8?B?eDUwOW9naG5nUEtCZ3JoSUNZYVFBMzN4M0hDUEI0enc3SEtCUHRQeUl6MHkv?=
 =?utf-8?B?ZStOVHJlUXZZajZDV0MrUVo2NTNpdUpCNlJaUHRGZ2g4VWlQb3Rnb0g1MGFo?=
 =?utf-8?B?dTJpOC9nYmIvcWE3Vjg1ejRtNmJuVFg3cGNoVVFES3ZFQktxQWFLMk9ETWs0?=
 =?utf-8?B?MHRQTUxXcE9rZEEybHZkWXhFaUQ5Q21SenNzZVFlYlgwVVYycW9LNTZhd2wv?=
 =?utf-8?B?T2N2cm1vUlJPMnVxUDIxcWZKQWN5Y1dnYWZRMW5seDFza1FaWUgzNGV3R1Ry?=
 =?utf-8?Q?QDJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0744dc-ecce-47fe-e3fd-08de058c5a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 10:29:10.3488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6C+lHMoZTAA3ZFBuFGe16Yv+rW4ikHXESBrmhvjsprFrozTT23NaebuJFYPhas2L/umD8TRrRGXT145p3HKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936
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
Cg0KVGVzdGVkLWJ5OiBNYW5nZXNoIEdhZHJlIDxNYW5nZXNoLkdhZHJlQGFtZC5jb20+DQoNCj4t
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJpc3RpYW4NCj5Lw7ZuaWcN
Cj5TZW50OiBUdWVzZGF5LCBPY3RvYmVyIDcsIDIwMjUgMjo0OSBQTQ0KPlRvOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+Z2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogaGlkZSBWUkFNIHN5
c2ZzIGF0dHJpYnV0ZXMgb24gR1BVcyB3aXRob3V0IFZSQU0NCj4NCj5PdGhlcndpc2UgYWNjZXNz
aW5nIHRoZW0gY2FuIGNhdXNlIGEgY3Jhc2guDQo+DQo+U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPi0tLQ0KPiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDMgKysrDQo+IDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj5iL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92cmFtX21nci5jDQo+aW5kZXggYTVhZGIyZWQ5YjNjLi45ZDkzNGMwN2ZhNmIgMTAwNjQ0
DQo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4r
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0KPkBAIC0y
MzQsNiArMjM0LDkgQEAgc3RhdGljIHVtb2RlX3QgYW1kZ3B1X3ZyYW1fYXR0cnNfaXNfdmlzaWJs
ZShzdHJ1Y3QNCj5rb2JqZWN0ICprb2JqLA0KPiAgICAgICAgICAgIWFkZXYtPmdtYy52cmFtX3Zl
bmRvcikNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4rICAgICAgaWYgKCF0dG1fcmVz
b3VyY2VfbWFuYWdlcl91c2VkKCZhZGV2LT5tbWFuLnZyYW1fbWdyLm1hbmFnZXIpKQ0KPisgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPisNCj4gICAgICAgcmV0dXJuIGF0dHItPm1vZGU7DQo+IH0N
Cj4NCj4tLQ0KPjIuNDMuMA0KDQo=
