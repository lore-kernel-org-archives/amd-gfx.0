Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1687DC44503
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 10:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB70610E74C;
	Wed, 21 Jan 2026 10:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4KdQpEP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3847A10E750
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 10:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMmrC05tvCWIJyuhlrBBta1hmKg9ekF44m42g+VcDSq9TUgy6EsyF89i5SdIk5is2sf54PhWEC0YvDtX58jWE7LYCpm9XyuHOoIax+tE6tBNu7fY9xwfLm/MQqKGus8x1DdW074Gy6QnJuGROAvhSvHFjPCMu/3LbGfVcP91gao9J5xP6VyXFk3hdW//0TGMENBrbfEp42hkGzc4iEvNH1H8Hxrog8xaij1SWwFvv7Ef/3qRJW1p7L7Jg8oC1IcGr73rkVHK94KlfDUguhNr7zpX2WcDMffXl65UEurJs9MJRELBKI5C6GgTsozBn1I+zQUuGcB27YfUZqutFIfTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3hCSa40SSiIIywfskoeRdQVjEZ8ADQ6gUfTkCMw6uo=;
 b=yNfsx5nh9kGSkDvpzO34FWOW8h1enKx/E49XnPIL+nDGS2yWneuMDcjE9bhTVOQSyHeePmVtXja4IjchDDcdk8UNgxYDcUDkhTO9GKVKcYRvyDso3XqqJbWUiVV9ukclqB6HnlJMbar+L18eLvlX2m2GEnqd9YtXiRlcTE7LJvWSoj10XHqJ0n9P3hR4E6B1yvu2FbJh2TrH1jzhPB8NNjgupb7vdm36CXCwIZ1/kA2CrCQ3T81zD5PxFssWS6mhSh3b+inK8UxPs11yEYjNWcMCHNdkCXUbbzSdJz4NMfrHTwtVhW/SyevUUbLrM+V8mXOjQEwW9DFM2Cq6ZhwvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3hCSa40SSiIIywfskoeRdQVjEZ8ADQ6gUfTkCMw6uo=;
 b=S4KdQpEPUV2iVfnaLB45jMz/Al2N0ZDqBTPKD8M/eGZbxsTr1hAYrU9ID8PqCDwkZ9CtU2xp9+YAW4jP1ePa5TKUn0dZNRwcxPiNNf16vh+6YA8yfbfba5YP6mMwulOQb83R6dP6LRvfUXvTZtC4/HABSTVj6zYe4lTMOVRac2Q=
Received: from IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 10:46:15 +0000
Received: from IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0]) by IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0%4]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 10:46:15 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdkfd: gfx12.1 trap handler support for expert
 scheduling mode
Thread-Topic: [PATCH 4/5] drm/amdkfd: gfx12.1 trap handler support for expert
 scheduling mode
Thread-Index: AQHchyhe5KFbDy1DUk6hf4fFtuQlsbVbuyEAgAC8mlA=
Date: Wed, 21 Jan 2026 10:46:15 +0000
Message-ID: <IA0PR12MB864721669DF6FA5B69D4D1C79A96A@IA0PR12MB8647.namprd12.prod.outlook.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-5-jay.cornwall@amd.com>
 <1471efbb-6431-4a3f-8361-2666efa485c8@amd.com>
In-Reply-To: <1471efbb-6431-4a3f-8361-2666efa485c8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T10:45:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8647:EE_|SJ1PR12MB6219:EE_
x-ms-office365-filtering-correlation-id: c984c6f6-e6a8-4255-23fc-08de58da4d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?QVZpc1F5a3p6Tm11T1luT2RmWVZUdWJVaFBuR2Q0M0xPODBQVTZINEF2a3Vi?=
 =?utf-8?B?UHUxUjNZNHU4SVZFUW9hcFlMYXRnbGgxNEg1SXBHazRqeG9pZFN2Z3dJeTVD?=
 =?utf-8?B?STVsdFErNjdURjdjcG1tK0tJR0xYeW5iNGJiWXVQSVljdUFGbjlaN3lCOVpB?=
 =?utf-8?B?QTFac2dPWUd5Y0tiSmczYTdoMllDMU1EKzFLQ3FidnhzR2hudnJjdnpOakpF?=
 =?utf-8?B?L2ZXMzdScjdPVkNWdEhsTWEwcEljME9peitKV3dLeEcrUnBWVDFrZlRQMllJ?=
 =?utf-8?B?SlJUb2ZzOXI2WTA4eGp0ZURqQUNZVTNlZktSWGx0RUlwVnZaQXFYNDB4cVpw?=
 =?utf-8?B?OHZrUUtzQ3QwbzZvWHdDbWdUcHRUVFcvNWlLbnJ5UDJvaDdjT3ZzeWUwSzhx?=
 =?utf-8?B?NU5hLy8vWEFQUUpqaEJtYlQ1bzFWYUt6WmlOYk5kQVc0Zk96KzByTFBDdlZL?=
 =?utf-8?B?TGtuYWMyQmdhTWkzL1FISDVFWFQyejR4M2VzQ3YzUU1PYTlKN0JFcDR6VFdq?=
 =?utf-8?B?WHM0VVBidXQrSkl2MVB6cEdJeGRtTElUaXZzbGNpV25Kb0Z4NE5vUnpvV0NW?=
 =?utf-8?B?NkRuMThadDIwb2Y5WVllVCtMTU5WRDdLNEZJdGg5Q2ZrWGZVVmtXQmxpR3lp?=
 =?utf-8?B?enlaRk9oaDdpUDVwS1c1Qk9LNlE4NkQrQnBIL3QzVEdSbDN5aEFVRUtqOTNy?=
 =?utf-8?B?T1pkRVpFY25oS2pDcFdzL0ZOY1BTUWJrbzlmRE0zS2p6L2RLZm1FVTJpSGc1?=
 =?utf-8?B?b0tmYk44MmpncjNPMU9rS1gzcjF1NW94QmpoZ0NjeDVvWGMwSFJIYzQxWTFK?=
 =?utf-8?B?bkV2eDBWZ3R1bmtaaWw0VElHWEdBNjU1d2lGdW05a1BhV1lMSWJaSGYxV3hz?=
 =?utf-8?B?RitRSlkvUW5sWWg1Z1VvemkrWWpuRmxhMHgwQWFiSjByVGJDWldKK2F1Unla?=
 =?utf-8?B?RnVuZHpFQ05ZMkQ0NlU0RFB6aUx6enJIODB3ZkQvVmdOLzF5T09IcDM1bXpw?=
 =?utf-8?B?Y0h0QWFONFlxTk50L1lkdWRwZm56eVVBNm1oTVozd0x2Tm83U1Q2SmNkR1No?=
 =?utf-8?B?OWNVbGpJN2ZBaVpkeHdnZjB1SGhHTnF3MXBLMEJLd3RET2NPb0xUUkw3YXZj?=
 =?utf-8?B?eDhsSTFuWFB2eVpLV2pQYkdqSVJsSXJ3Vk01cCtmUmd3ZzJ4UzkxL3JobjhR?=
 =?utf-8?B?dGVUZnpWYlV3cmlGcWY5SjJlOUtselFRUUNIOW5uYzNVOFJseWtFY1Z5b1NZ?=
 =?utf-8?B?WUVNWG1JRnB4UHg4b3hIS093LzQ3bm1xakVmTFhoKytpUEN5Wit2b1FMNUVz?=
 =?utf-8?B?WnpMRGtVWGVQbUZJNVhxUC9ESHhJSmNzaUVKZ2dCek02RXdwWmtKajBFOGt0?=
 =?utf-8?B?elQ2eWhtcHN0MFVwOGxpL3VCZ21INGhvRHEzNWZBMnNqUHUySDg0NUNzck9o?=
 =?utf-8?B?bUJQc1JQcnA4bmdDdDRxVWVJZU5MUkZ4eDJZQmlWSTVveXkwdnJPMlprMkpB?=
 =?utf-8?B?YldXbHpUUW9QQXgwNEpPY1JWNDFzVVcwN0FvaU9VY1Ixa0I4Z0t4enlVeU1L?=
 =?utf-8?B?L2F3V080Wnc3eUZDN24zQXJYeHVPNkkvYk1EOXllUVNmNkoyM1FNcDdaRUht?=
 =?utf-8?B?UFgzMThkcGthTXVwV0h2T2RReWVocnFrZ084MlpOTC9CZVBiK1RmSm4rTm5s?=
 =?utf-8?B?QmFSalZHajlrMFh6djVnRXBEZXhBcjNsY21UZmRGVmN6dUUrSWFuSS82ekFu?=
 =?utf-8?B?aGV6cmlOQ1FEYlBxbnZzRFRCbURYZXE2SU9kQjVUZzJMV245a0kzbFowOC90?=
 =?utf-8?B?VFFKWXl2eFNUMWtla0RUQXUyNmNBTnJhRGtZOGhyc0tDdURDU0Q5NlpzWHJD?=
 =?utf-8?B?TzNDdHNHb1U1MndFN3BQRElSQ1lBL0M0MDE0SlFXTUFBODBlaXJEWTJyWE12?=
 =?utf-8?B?cXdLbnZsVmE4ZHUrWEY3VSt2UTd2MmFGVkNhWGR3bUVxdVAyNDc3bWpsd3Y1?=
 =?utf-8?B?MGpyVGJRZHVYM0VTUGRjNDZJZHpCQjkvZ3l4UzlRMVBPVU80SGU1U0RDTnFo?=
 =?utf-8?B?UC9tbkpraUlqeEU5T0tnUloxSkgyd29iVkJXbjNVN0FPWVNxL0VBWDF6eHFl?=
 =?utf-8?B?Q1ZjMTBBUTROWmJGZXNUbFk4OTdGU1pESnhXOEtDdkw4Y2ZBeUwrcGFEVnlZ?=
 =?utf-8?Q?qWXJdoN3lKbzEAJw4flmxfs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlhPUXVZRXN3S1p0Y3h1QmNBRXl1eGg3a0diVHNJZzFRR0FudUtkVXZRSmxU?=
 =?utf-8?B?QytLWHA1TGVzaDJrMlRhelRhMmNVanFZelRORFpDSStPL21KZFFHTURvWHpM?=
 =?utf-8?B?K1Jzck5nTmM5WVdJeTNCSW50ZGVkU0N0a2ViUHQxYVBrTXZnQmc0WTU0SGpG?=
 =?utf-8?B?MTdCMEY0ZGRlVURnSU5JY2hWOGJCbmpiZUNyTXNUUHJyZHJqRGpFNkJKa2Jx?=
 =?utf-8?B?bWZDbTNxNWkvU0pYUkVrZE42NTJod2prYmhrN2taYVhFdmNuL2ZHOEdwWU40?=
 =?utf-8?B?eFA2SkJZTkEyWjVROGkweXdNZUxkc2QwMjNNWnRWcjVhT2JaRjUzUVRacExq?=
 =?utf-8?B?Ujd5OFphYVl2VHo3b2tRUlRXTDdkSTFkQXBNTHB4bTRuZE1KYWNBa0RjbWFp?=
 =?utf-8?B?YnRaZE1vYXZ2YXBiOTNQSHM0M1FlcHdGZGFRRkVpZGczeHBBdm1nOFBHYy9O?=
 =?utf-8?B?TGRodlYwdTNxYTlMT1R6eWxzNFA3NmtUc3R1cWJPS29OVTlleDA1bG1tNjVv?=
 =?utf-8?B?T2lscFdKUnFHWUl0Y1NETHVwMW5mM2xHUklOeVJnOTVtb0QzMS95b3REQnlQ?=
 =?utf-8?B?c1VDRE4rb1NaTElZb3J5MjVrVnhsR1hROTFKbENuNldESEJ2NmUzaFNxT3dS?=
 =?utf-8?B?dFR3U3Vzd3ZvdFMvTm5kVXhCeHZhczc3bHc3amdyR0ZFbmxEbldsQzB1emJQ?=
 =?utf-8?B?U25kbWZIMjdoRjB6RThtOVUxN0Q5dndnNG1jSmMrenVxVVI0RkluZnhhTkRX?=
 =?utf-8?B?RWpBWkxxclR1cW9HRUd1dGdYNVlWdC9XbGdJalV1MjBJaXQyTFdFWittNStP?=
 =?utf-8?B?UHlGRlIvcGtWT1ZzZ2xJMWtGMDM3RzdHMFJXY0M0a1o2N05VZktRdTU3NWxK?=
 =?utf-8?B?YmpDdkhqOWRRc1FVQTVsRXd0Q1ZWMllab0hkalJLR0g4MUw2NnBzbzNFazVZ?=
 =?utf-8?B?cGQzekZOZjJGL1laRWtaK3BFVXo5Q2hRa1JoRGhqQ0tMOW9iaDE2bEpjTmZD?=
 =?utf-8?B?QlZxOWF0YW5OcGZXV1Y0cDByQW5HeHZhOWV2L1QyTFYzb1R6S0t2VStjVWRs?=
 =?utf-8?B?NVVzN1RkVjEreXZ6THlsTEJ0SU9mV2xLUEUxeXZQdUJwVEFBcnlqQ3NoL2M5?=
 =?utf-8?B?QnVjOFpxbUtXbXlvRkhUbm9FRGRocm1vTWM2MHNzMkVhc3pyYmg1aEtLRERk?=
 =?utf-8?B?THBZSUxhS01MQnhnRDhRM2FKMmFXVkEwRFgyT09tZTNlUzFtSVp0Y0NhdjZI?=
 =?utf-8?B?TUpJV2tYK2haRzJjTHNrT2ZETFBnMURPc1QvajVnWDdwb3NHWko5UVd1NmJ4?=
 =?utf-8?B?TzhkaXR0RCtWOWswclBYcVZwUFAyTUhRSm8zamNmVUoyWEFzQnIwQXdnUVAy?=
 =?utf-8?B?NTFZWitBT1c1QkVCalpXQjQwYzdjeVZVSSt6SXArcHR0WWdUbWRGS3I0c0o3?=
 =?utf-8?B?OHNzcHlabHh5UkQ4N3hTWXdLT2poUGhZNmlWRlNJL3Nudi9HWnE3VVhld2ZC?=
 =?utf-8?B?SmI3Ykc0QWJWL3hiNnkyWFIrOTQ5QUJsWkNPNHZsbmdyZ1hPYUFtdUo0bUxC?=
 =?utf-8?B?VDFLVmhrRnhuYXpoZE8vOTJWMzlVOEhuc2g3U3ExNkhjVjNxYUV6a3dlTW5T?=
 =?utf-8?B?OW01VEVkNitYeFFEbENrczd3K2dCSkV0YzhlM3ZTV2pPNDFJMEUwSzZSeUJX?=
 =?utf-8?B?T3UydTBFVG9vZDhYc1FaMUJuSFViT0N4NE5hTDJTOHBzZWM4blJDZUk1dCtG?=
 =?utf-8?B?Nnk3aXJJSXBGZGVvc25vSUdIb1B3YldOMVMwNzBEZHdMa3dFcm1ZWTRqVDAx?=
 =?utf-8?B?Q2RWRkNyZ2FzS0toSG9ORHVnV3B2ak4xNG5xMi9xcldDRUVGNWFvdHFJMlJF?=
 =?utf-8?B?WkgwaE83Y282dzZMK1Bqa1JvWlhJZkdxWXNHbVRLeGpWQXNnanNHZWl5bmFC?=
 =?utf-8?B?Qnk1MGIyZDlubjhLdDB5aDVxU1JBQWJjRVVKMGFHV2xaU3RiMnNDcUxkcFQ3?=
 =?utf-8?B?UWhKUXJPNVlIYkNYRllSZElWanlrcEZ6M0gvWlN3ZTd3M0k2SFZ5cGFiMmYz?=
 =?utf-8?B?dzBjZVhrSFgrcW8rb283RXYvaEV3QXJqbkFDelVtOFdMbTUyM01HSDBzblp3?=
 =?utf-8?B?cUZ6TFFWMlBnalJoRzNuSmdBa1FkNzNvdkZOZjJnU1F1U1hqR2xUakoySU5i?=
 =?utf-8?B?TGs2NUR5YVpKZHBsejJjNjFFTnlPM0pYa3JONUJnaHZxaWRxOEZFaFlXYzdL?=
 =?utf-8?B?VE9TMlhkSzRDTjcxVVJINGtjYWVRNkc1M1E5ZFZPVTIrM1RXS1p5blJ0UXU5?=
 =?utf-8?Q?kIfihPGQiq3mGJ6Vdt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c984c6f6-e6a8-4255-23fc-08de58da4d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 10:46:15.1890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjP+yM51aIZqI53F3+kKYquxdwgYZpzJvOFipJJ4iWUtBlo6RA4Khi0bkhMQLgBSVFYatzilzP5dRttjlRAmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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
Cg0KT24gbW9yZSByZXZpZXcsIExHVE0hIFRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWly
IEluZGljIDx2bGFkaW1pci5pbmRpY0BhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogU2l4LCBMYW5jZWxvdCA8TGFuY2Vsb3QuU2l4QGFtZC5jb20+DQpTZW50OiBX
ZWRuZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMTI6MzAgQU0NClRvOiBDb3Jud2FsbCwgSmF5IDxK
YXkuQ29ybndhbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
SW5kaWMsIFZsYWRpbWlyIDxWbGFkaW1pci5JbmRpY0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSCA0LzVdIGRybS9hbWRrZmQ6IGdmeDEyLjEgdHJhcCBoYW5kbGVyIHN1cHBvcnQgZm9yIGV4
cGVydCBzY2hlZHVsaW5nIG1vZGUNCg0KSGksDQoNClRoYW5rcywgdGhhdCBsb29rcyBnb29kIHRv
IG1lLiAgVGhhbmtzLg0KDQpCZXN0LA0KTGFuY2Vsb3QuDQoNCk9uIDE2LzAxLzIwMjYgMjA6Mzks
IEpheSBDb3Jud2FsbCB3cm90ZToNCj4gLSBMZWF2ZSBERVBfTU9ERSB1bmNoYW5nZWQgYXMgaXQg
aXMgaWdub3JlZCBpbiB0aGUgdHJhcCBoYW5kbGVyDQo+IC0gU2F2ZS9yZXN0b3JlIFNDSEVEX01P
REUgKGdmeDEyLjAgc2F2ZXMgaW4gdHRtcDExKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgQ29y
bndhbGwgPGpheS5jb3Jud2FsbEBhbWQuY29tPg0KPiBDYzogTGFuY2Vsb3QgU2l4IDxsYW5jZWxv
dC5zaXhAYW1kLmNvbT4NCj4gQ2M6IFZsYWRpbWlyIEluZGljIDx2bGFkaW1pci5pbmRpY0BhbWQu
Y29tPg0KDQpSZXZpZXdlZC1ieTogTGFuY2Vsb3QgU2l4IDxsYW5jZWxvdC5zaXhAYW1kLmNvbT4N
Cg==
