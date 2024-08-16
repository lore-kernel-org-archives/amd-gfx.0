Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE6C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 06:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC2E10E3FB;
	Fri, 16 Aug 2024 06:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fSMAlMar";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3900910E3FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW9nuMj8p0pQ2Zc61MSkIGJSltEWKtKPXJsbQoR0Dcb21qEraX6nYS3NMQvgyM2LS1dicT7lNZvYUndSvrmFszhEsu8P8MR9jFgl/JgE3OimZg10dS5gWUBBnycRYa0ZBxHZmW0RAVLaPYTI++J7lltXCpaX2yvI9CXOcbeVyvGaQwy+AzWwMZjntn5pEv3iLrkxYRH44lWoxHgltJKhjvPl2g7y+Bez5Yh59KmjQPFrokEYKssaji5ESscCXt2K76cTXOlhUWxyJDEaj1fiHSuZ0VTxstsnZd966BGzVa+WoRyMYkgbFMEa0pqIBvzQhcNomHzx+yLfRAE9gWnr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zZuFK0cjmGTzFDWYYONV5JVj6yez8gGYFEklPmn5bc=;
 b=OL3Jgb6PimrfGfWHE6a56zDzVB7xY1b7NBkCSJJcclDMRKh6ZmUaO8flWWwW3SWLp8Hns3JBJciA3dK4YnuysnYiS+P7pclM2kECPE47PiebTqGOPEbq6H3r8M3rwP5fDFqB23yp3XVOZwv1id0pansLQYPhOaXXdvYidlVg1g1HylWpD1inRh0ICh1lPB0Se+MdOmp/mAoaiCp2o9+0NbxntanejxpMnPuee6EfShwBt+XUpAzcRugJcAUZ1VbAqBjzCorn2RcBQfw49I4QlheV87m9/9AgtzVV7fI5tAVXeC7XBSe13ET1PiPopi6/26pDb1QKvjF43WzVx2OQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zZuFK0cjmGTzFDWYYONV5JVj6yez8gGYFEklPmn5bc=;
 b=fSMAlMar7dUpsK+Mkq0HdwePKc66kS6STeCCz15Y3IWZsM+mnzINpSX2EqxDlRiN5jI8okwR3BBGJ3wI+fvicuC/nzeVVa1SImTkDOTJ3mh8h/OjXtkVncDfmzrZMKI5Lm31ZNTxooA1vBu0OpvQLoyPWz1xPlv7zf5UU2OuJnw=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 06:37:06 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 06:37:06 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Change the timing of doing coredump
Thread-Topic: [PATCH 3/3] drm/amdgpu: Change the timing of doing coredump
Thread-Index: AQHa7we6sEHvkc4UF0SRqk3O+nZ2GbIofPGAgADsltA=
Date: Fri, 16 Aug 2024 06:37:06 +0000
Message-ID: <SA1PR12MB74425084E92F3A82B5F5C863FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-4-Trigger.Huang@amd.com>
 <CADnq5_MmzVx2we4a=odouhdwBZ2t=L+H_Bdrr0-WvrnoA0vMaw@mail.gmail.com>
In-Reply-To: <CADnq5_MmzVx2we4a=odouhdwBZ2t=L+H_Bdrr0-WvrnoA0vMaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=efb11f1e-7946-4a8f-a0c5-6c2e6f2bfd4e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-16T06:16:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|MW4PR12MB5667:EE_
x-ms-office365-filtering-correlation-id: f544ea0b-6fa3-4fec-eaaa-08dcbdbdd8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y1FGeFNjcnBZenBsMnR4TlRaUHBUeFoyTEJKVTRNM2Q5bW5qMmxrUmg3OUNt?=
 =?utf-8?B?VGlrWVUzVll0WHZYWjBJZWJyM1gxNjhEOW4yZmRvaHV0aWpGQXFtdDJGYndK?=
 =?utf-8?B?czB2OTNHYVJBVDFMcTZlZEp2WHREK1NEbVBUaUhkSFRiZ1IrSU5kSWdJMGlB?=
 =?utf-8?B?Zk5aa0xTSkdXSUF2cWhwSUtvOWVraUc4dE5oWGhycW5pa250bWNRQUZEMXo0?=
 =?utf-8?B?cXFRekN6WlJzM2Z2OG1Pd2FKL2VnRVY2dzdTdVpvR3hFTEpXS2Uyd1daMW90?=
 =?utf-8?B?b0dtTW5ISVNxQ2txcERXVlMwNVBQNC9BUVlZbU12QnM4M3hHOVFMeHRLcDdT?=
 =?utf-8?B?a2hhN1d1aC9Qc2VvaXZZZmdqaWtuQ0syZUlubDhTQm05Zy9KYlFaOUpWSVlN?=
 =?utf-8?B?MVRoRWRKU3Z5elN5blhUQ0xMbDNQd2ZJMUZENDFOQUlZYXhDUDkvS2ZUa0hh?=
 =?utf-8?B?NWNXSENOSEFiUWd3TjExRnRFSXp3UkFVVzcwTXM2akdIcWpscUxrYi9DWkZz?=
 =?utf-8?B?eEk3SmVZQ0ttRExPWmNLMWh0OEpCdng1U2tqamY2SXNpR3QzQW1xaUtRZEVu?=
 =?utf-8?B?WFJkWTdxa090NW5EbE5wMmY1Z25wUDJJb3lNUVJtWWx6Sy9xNkY0V3BGdzN6?=
 =?utf-8?B?cXB4a3djcjZIVUI3dUVFektwWHkzbDFkV2tSd2lzcXVGdkdHcW8vUFpoN3ZY?=
 =?utf-8?B?cW9ZMU13dUd1ZXJhbngxMGVMQ0xYenExZDVGYXFza2JnVUFvRHRZOVJKQlpm?=
 =?utf-8?B?TGVsWXc3SEZhUFJUQ29CQzZoN0xTK1o0b0diTWNNWWZFdFlxU2Y0TVlKMmU1?=
 =?utf-8?B?QkVwSHdaUENCWHRITkRTWXBxb3ROOHRtQ3BlWjZ5WnlwblJ6VVZ3dkJQRnAw?=
 =?utf-8?B?aFRCWVUycG50UHF4dURtSHI4eGpsdVdmM3pWUmxTQjVtR0tPUjhQWkIzanhU?=
 =?utf-8?B?cGJ6R0hhUm5HdnM5ZGtISVQ0bU1HUkN1a0M4QmtaWGlabEg5ODV4bTZXTnp0?=
 =?utf-8?B?STVaZWUxbzI5eiszTkxBbUQza0pyZnpkNXFWbDF3WFVBRWRJT1ViQU5GdkJt?=
 =?utf-8?B?Qk0xT2xBY2U4c2pVS01uS1dyR1dpODkrRVN4bmhMK3pIaHM1UlM5cTJKV0lH?=
 =?utf-8?B?dzdDYld4aURHb2VENWZsWXdMRnFCK2s3RXQycmhvT1pKTXpKdHNrZytNeVBo?=
 =?utf-8?B?aXBiNkltaVBYU2VoUER6WTNSbnQ3d3VpZFd6TkxzNlltdjFMQVpaNGl5K0tV?=
 =?utf-8?B?MTVic3JGRWZJZG11SzB1T2k5b1FiamRtT2swbGxSck9iRWRNWHNYWWN6RHFS?=
 =?utf-8?B?cGVkdU9mWU9YY2h0dHVHdGFYbjVjQUQzRDhZLzVVbUpsaG8zWEhJNHQxcGRE?=
 =?utf-8?B?UEorbUtZbVBGSm9oQXZXV1p5YjBXQXI2dWExb3hHZ0dnd05EV3RwcWw5Znlt?=
 =?utf-8?B?V1FpblhKeXQ4Qy9qS1Z0MzRYRUgwVHVMNkdhTjV1NmdCZytSRzBWZ29pKzRL?=
 =?utf-8?B?VGFFMUhUREp1VXJxZXRNcXJDQlZjdVRHR0JXMUNnNVVyRFNRU0JzUEtwaG90?=
 =?utf-8?B?d3FybHNxcVZRQWJjcWFld3o5cjBGb2Q4YWZERnFEa3Y3SUlVYjhTYTRYdndn?=
 =?utf-8?B?YXFWSkp5ODhvYnlVYWNpRjVmeFNVSlBHSnV1WktOWm5UUmRPZ0hDSHpjTnpY?=
 =?utf-8?B?RUNMRWt6TW5pOEFBNzVsb1VYK0xMRFBjSnpqOHE5UGpUbGNrSGJwYUVWK2lM?=
 =?utf-8?B?NUgwN2FtaEZnSmpVZG5QbHFwYmJvSmJROHg1K1VCN1NiRGRWREhNV2hZam5l?=
 =?utf-8?B?UkswTmRvcVp3SDM0ZTE2ZjJqV3lGVVBCTmVMdDZFcXp1K1V4WEIrVXZxbktE?=
 =?utf-8?B?MGxGSElvS2NyMFlFb3BRWmkyaFVoM1dXTGQ1b0xqVlFpNUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym02dlU1MmtjMEFDcEx0TTNPYW1tM3hpY2RZMSs5dm5UZCtxcXFmb0NXZ0lY?=
 =?utf-8?B?TVVPWkVkaVVMWEVDRmJWMUYvRUNCMFRWYnhHelU5MzN4NzJOd3cwOW9FOENU?=
 =?utf-8?B?L21uc2xlMEhtTFRmSGgyVERqdjB2V3VZRFFsb1JOUUppWVREdjZIWnc4YTFH?=
 =?utf-8?B?WUNxbitCa1FNN2xFcXl3bWZtd29xR3BQckdXbFVWUXFLa3Q2MnRGYWt2L25Z?=
 =?utf-8?B?dkt2LzVkMmFncU1waWxaSXZiOEtjeC94NWgzYWdudWJYeElxY21hUDBxb0Iw?=
 =?utf-8?B?cEtDZlpOTjdUZUh4Rmh2d081blpMSTVLcnRQYTBjek1IaUdPYlBzdWdoUzJY?=
 =?utf-8?B?d1pQRGh3eUVFdFVBblUvM2VLOTh6ZkZjY25Vak4yRGNHcklxY3MwUFRtcWpQ?=
 =?utf-8?B?QzJhdFhaME0yVU9HeTFwa0JSR09DTE9sSFZacWUzUzZ2UFZ0eDBRUkU2Qjhm?=
 =?utf-8?B?WFZKOElCdHkwVWhhdGVEQjNITmFGRlJnQUxvMnVWUVNIOXFmMFRvSTBqNk41?=
 =?utf-8?B?bXJiR3IzQmpqRFcxM2hkc2N0WUZpeHFRZEM1QnZGTEFPa0xYaEVKY0tOaWVw?=
 =?utf-8?B?RkhHSWNUZkwrV0JkUUU5T2JWOXc5NE8yRDBTcVo4MTlxSnlRNEZib3lMTEQw?=
 =?utf-8?B?YytYcmQ2RXlOR1VFanYrZE91Ukxjbk96d0crcWdURlBxZ3B1NGlYZXVSQ0pw?=
 =?utf-8?B?bGRucXE0ZG1xUE02MDFJY2Y2RHYvdkdwejRiaVNBQlIwRitiWUZ0SmhHenhD?=
 =?utf-8?B?UDliOVJZdkg2UlQzZTdVYzBna3BjNjVtc1IvRFg3bmhPLzNXcW1qc0JMRTZE?=
 =?utf-8?B?Q3JDK0dDSjl0ODFUaVZ3aFhURFYydHg5RUNGK3VJYUtCUHpXT0JYSTdjOGJT?=
 =?utf-8?B?c1lQbTVucHBqaEFTVGJCZVJ3cjlyVmE0WFBvQzF1WXY2Q3dBSk1WRFRTVUR0?=
 =?utf-8?B?WUY3eWh5NUtFOE9IWjUrajBQYnhxaHJxemxUUXc4S3BuVStMcjQyQXNRQk8w?=
 =?utf-8?B?bWxkd1lkS1lOS25UZzlFRS80c0EreVZ4NDV1Q3l5Z0MyNDB3TlBaVG1VekNL?=
 =?utf-8?B?TkMyTVBTTWhlbHNHa1RwZjhnVENENTQzbUhwNVpJTG9jMytoaTFDOEtwQitI?=
 =?utf-8?B?L1hoUjRnMXRNZ2xEVi94R2tMM04zUVR3RHhyaWNNZkpyVVd3VWt4bjUvdzdM?=
 =?utf-8?B?ekhzcDRpUjl1aTJrcjRZbW92L2E5bFpaRTVFdlc3emRhQlZIcTZRZkhROGIy?=
 =?utf-8?B?OThoSlhDKzBnWEJua1dKNkZhdGxHdFpzUU1IcWpWNG1zU1RxZ1pJdVBlUy9j?=
 =?utf-8?B?UE1NSTlSeVdIMFp6VDJtTG9waVZGL0UzWGlLblpjMnVkREYyZVd2R2E2V3pZ?=
 =?utf-8?B?TGE4Q0o2VDBDanQyYlRJWmYydSttNTJoV2t0dUJySzBOaUZtaUpiZWxjUks5?=
 =?utf-8?B?Vk9HbTh6bm81dHhaQmlTMStyNGJaYmxQT2RTTEhTUU5yc3RkcG9QNTV0Ukk2?=
 =?utf-8?B?RGVuQkx3V3VsSDluOEc3b1NCMlRReHFqa1lKY1NKbTd1VlNXRTJSMlJ5M3Bx?=
 =?utf-8?B?dTRqQ3o0TXU0WVlHN3htbFY0Ukx1dVJLTnBhUVZZTFVlSEtoeFVJY21jemZw?=
 =?utf-8?B?MmN0cHJmT3RJY3V2MG9SSjRUR2hIVmZkbVZaUzVkdjFCMWMxMVozelAwYkFj?=
 =?utf-8?B?UzdXTE8rc244cWw0M250aWhlVTlCeVY3VzZVYmNNL1MyZkQ5OVJMU2daRUE3?=
 =?utf-8?B?UFVjclIxckxwZG5jVHRwUlpSU0lxa2dhUTlGNll1di9UWWRDKzRadlJTN2Nn?=
 =?utf-8?B?S3lYR3hjQW1XeWZDbzBEU1FwcEo5RDZkQ282eVBTVkdESHdCRFlDZGlDM3FZ?=
 =?utf-8?B?NkdyV2RjaEREcHphMHZydjQwTUxXVWVCd1hBYXdpODVEVTUzcVhyOE9WVGVS?=
 =?utf-8?B?TXh4OHpqZGFzbXk2ajJwRlVlZzFwSUc0OFFJWTdqZzRqdHJFSzRlS1A3djJn?=
 =?utf-8?B?eEtoZi81bXc2QmhJNWdQem4vWFVqeUtjOEp5bkVxOGJOOEdhTUlZQ0xaWllQ?=
 =?utf-8?B?WTRTV2JTWk9kK3MrRURFRS96bWsxTys4VWpUL2tNSDBBN2R0RVZwdmk3MHRU?=
 =?utf-8?Q?GhHA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f544ea0b-6fa3-4fec-eaaa-08dcbdbdd8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 06:37:06.4481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auUJy7QTt1dRegDP+OX21SA58wHpKfaLxMJ9TBTy7gzxRZr4svhZeIOiX58qEbh2HBmRNnmNEaun6+35msYAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgMTI6
MDkgQU0NCj4gVG86IEh1YW5nLCBUcmlnZ2VyIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hh
dHJpQGFtZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1OiBDaGFuZ2UgdGhl
IHRpbWluZyBvZiBkb2luZyBjb3JlZHVtcA0KPg0KPiBPbiBUaHUsIEF1ZyAxNSwgMjAyNCBhdCA3
OjUw4oCvQU0gPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBU
cmlnZ2VyIEh1YW5nIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+ID4NCj4gPiBEbyB0aGUgY29y
ZWR1bXAgaW1tZWRpYXRlbHkgYWZ0ZXIgYSBqb2IgdGltZW91dCB0byBnZXQgYSBjbG9zZXINCj4g
PiByZXByZXNlbnRhdGlvbiBvZiBHUFUncyBlcnJvciBzdGF0dXMuIEZvciBvdGhlciBjb2RlIHBh
dGhzIHRoYXQgbmVlZA0KPiA+IHRvIGRvIHRoZSBjb3JlZHVtcCwga2VlcCB0aGUgb3JpZ2luYWwg
bG9naWMgdW5jaGFuZ2VkLCBleGNlcHQ6DQo+ID4gMSxBbGwgdGhlIGNvcmVkdW1wIG9wZXJhdGlv
bnMgd2lsbCBiZSB1bmRlciB0aGUgY29udHJvbCBvZiBwYXJhbWV0ZXINCj4gPiBhbWRncHVfZ3B1
X2NvcmVkdW1wIDIsIERvIHRoZSBpcCBkdW1wIGFuZCByZWdpc3RlciB0byBkZXYgY29kZWR1bXAN
Cj4gPiBzeXN0ZW0gdG9nZXRoZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmlnZ2VyIEh1
YW5nIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE2ICsrKy0tLS0tLS0tLS0tLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jICAgIHwgMTAgKysrKysrKysr
Kw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+ID4gaW5kZXggNjlkNmE1YjdjYTM0Li5hOGViNzZkODI5MjEgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gQEAgLTUzNDEs
MTUgKzUzNDEsOSBAQCBpbnQgYW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldChzdHJ1Y3QNCj4g
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4g
ICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBpZiAoIXRlc3RfYml0
KEFNREdQVV9TS0lQX0NPUkVEVU1QLCAmcmVzZXRfY29udGV4dC0+ZmxhZ3MpKSB7DQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8odG1wX2FkZXYtPmRldiwgIkR1bXBpbmcgSVAg
U3RhdGVcbiIpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIC8qIFRyaWdnZXIgaXAgZHVt
cCBiZWZvcmUgd2UgcmVzZXQgdGhlIGFzaWMgKi8NCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgdG1wX2FkZXYtPm51bV9pcF9ibG9ja3M7IGkrKykNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0bXBfYWRldi0+aXBfYmxvY2tzW2ldLnZl
cnNpb24tPmZ1bmNzLT5kdW1wX2lwX3N0YXRlKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB0bXBfYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLT5kdW1w
X2lwX3N0YXRlKCh2b2lkICopdG1wX2FkZXYpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
IGRldl9pbmZvKHRtcF9hZGV2LT5kZXYsICJEdW1waW5nIElQIFN0YXRlIENvbXBsZXRlZFxuIik7
DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgaWYgKGFtZGdwdV9n
cHVfY29yZWR1bXAgJiYNCj4gPiArICAgICAgICAgICAgICAgICAgICghdGVzdF9iaXQoQU1ER1BV
X1NLSVBfQ09SRURVTVAsICZyZXNldF9jb250ZXh0LT5mbGFncykpKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2VfZ3B1X2NvcmVkdW1wX3NpbmdsZSh0bXBfYWRldiwN
Cj4gPiArIGpvYik7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgaWYgKG5lZWRfZnVsbF9yZXNl
dCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X2RldmljZV9pcF9zdXNw
ZW5kKGFkZXYpOyBAQA0KPiA+IC01NDQ0LDEwICs1NDM4LDYgQEAgaW50IGFtZGdwdV9kb19hc2lj
X3Jlc2V0KHN0cnVjdCBsaXN0X2hlYWQNCj4gKmRldmljZV9saXN0X2hhbmRsZSwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4NCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZyYW1fbG9zdCA9DQo+ID4gYW1kZ3B1X2Rl
dmljZV9jaGVja192cmFtX2xvc3QodG1wX2FkZXYpOw0KPiA+IC0NCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICghdGVzdF9iaXQoQU1ER1BVX1NLSVBfQ09SRURVTVAsICZy
ZXNldF9jb250ZXh0LQ0KPiA+ZmxhZ3MpKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhbWRncHVfY29yZWR1bXAodG1wX2FkZXYsIHZyYW1fbG9zdCwNCj4gcmVz
ZXRfY29udGV4dCk7DQo+DQo+IFRoaXMgbmVlZHMgdG8gc3RheSBoZXJlLCBvdGhlcndpc2UsIHdl
IHdvbid0IGtub3cgdGhlIHN0YXR1cyBvZiB2cmFtX2xvc3QuDQo+DQoNCk9rLCB1bmRlcnN0b29k
LCBzZWVtcyB2cmFtX2xvc3QgaXMgdGhlIG9ubHkgZGVwZW5kZW5jZSBiZXR3ZWVuIGNvcmUgZHVt
cCBhbmQgR1BVIHJlc3QuIFdpbGwgbm90IGNoYW5nZSB0aGUgbG9naWMgaGVyZS4NCg0KPiA+IC0N
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmFtX2xvc3QpIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0lORk8oIlZSQU0g
aXMgbG9zdCBkdWUgdG8gR1BVIHJlc2V0IVxuIik7DQo+ID4NCj4gPiBhbWRncHVfaW5jX3ZyYW1f
bG9zdCh0bXBfYWRldik7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9qb2IuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2pvYi5jDQo+ID4gaW5kZXggYzZhMTc4M2ZjOWVmLi42Mzg2OTgyMGMzMzQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gQEAgLTQ4LDYgKzQ4
LDEyIEBAIHN0YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRfc3RhdA0KPiBhbWRncHVfam9iX3RpbWVk
b3V0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpzX2pvYikNCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIERSTV9HUFVfU0NIRURfU1RBVF9FTk9ERVY7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAr
ICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBEbyB0aGUgY29yZWR1bXAgaW1tZWRpYXRlbHkgYWZ0
ZXIgYSBqb2IgdGltZW91dCB0byBnZXQgYSBjbG9zZXINCj4gPiArICAgICAgICAqIHJlcHJlc2Vu
dGF0aW9uIG9mIEdQVSdzIGVycm9yIHN0YXR1cy4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAg
ICAgaWYgKGFtZGdwdV9ncHVfY29yZWR1bXApDQo+ID4gKyAgICAgICAgICAgICAgIGFtZGdwdV9k
ZXZpY2VfZ3B1X2NvcmVkdW1wKGFkZXYsIGpvYik7DQo+DQo+IFRoZSBwcm9ibGVtIHdpdGggZG9p
bmcgdGhpcyBoZXJlIGlzIHRoYXQgd2UgbWlzcyBjb3JlIGR1bXBzIGZvciBHUFUgcmVzZXRzDQo+
IHRoYXQgaGFwcGVuIGZvciByZWFzb25zIGJlc2lkZXMgYSB1c2VyIGpvYiB0aW1lb3V0LiAgRS5n
LiwgcmVzZXRzIGZyb20gS0ZEIG9yIGENCj4gaGFuZyBkdWUgdG8gYmFkIHByb2dyYW1taW5nIGlu
IGEga2VybmVsIGNvbnRleHQuDQoNCk9rLCBJIHdpbGwgbm90IGNoYW5nZSB0aGUgbG9naWMgaW4g
dGhlIGNvZGUgcGF0aCBvZiBvdGhlciByZWFzb25zLCBidXQgSSB3YW50IHRvIGFkZCBhIGNvbnRy
b2wgb2YgdGhlIG1hc3RlciBzd2l0Y2gsIGFtZGdwdV9ncHVfY29yZWR1bXAsIHdoZW4gZG9pbmcg
ZHVtcCBpbiBvdGhlciBjb2RlIHBhdGhzLg0KDQo+DQo+IElmIHlvdSB3YW50IHRvIGtlZXAgdGhp
cyBoZXJlLCBJJ2Qgc3VnZ2VzdCBzb21ldGhpbmcgbGlrZToNCj4NCj4gaWYgKCFhbWRncHVfZ3B1
X3JlY292ZXJ5KQ0KPiAgICAgIGFtZGd1X2NvcmVfZHVtcCgpOw0KPg0KPiBUaGF0IHdheSB5b3Un
bGwgZ2V0IGEgZHVtcCBpbiBib3RoIGNhc2VzLiAgTWF5YmUgYWRkIGEgZmxhZyB0byBza2lwIHBy
aW50aW5nDQo+IHZyYW1fbG9zdCBpbiB0aGlzIGNhc2Ugc2luY2UgaXQgaGFwcGVucyBiZWZvcmUg
cmVzZXQgc28gaXQncyBpcnJlbGV2YW50Lg0KPg0KPiBBbGV4DQoNCkdvb2QgaWRlYSwgbGV0IG1l
IGFkZCBhIGZsYWcgdG8gc2tpcCBwcmludGluZyB2cmFtX2xvc3QgaW4gam9iIHRpbWVvdXQgc2Nl
bmFyaW8sIGJ1dCBzdGlsbCBwcmludGluZyB2cmFtX2xvc3QgaW4gb3RoZXIgY29kZSBwYXRjaCwg
bGlrZSBLRkQgaGFuZy4NCkFuZCBhcyBkZXNjcmliZWQgYmVmb3JlLCB0aGVyZSBhcmUgc2V2ZXJh
bCBhcHBsaWNhdGlvbiBzY2VuYXJpb3MsIGl0IHNlZW1zIG9ubHkgdXNpbmcgYW1kZ3B1X2dwdV9y
ZWNvdmVyeSBjYW4gbm90IHN1cHBvcnQgYWxsIHRoZSBzY2VuYXJpb3MNCg0KUmVnYXJkcywNClRy
aWdnZXINCj4NCj4gPg0KPiA+ICAgICAgICAgYWRldi0+am9iX2hhbmcgPSB0cnVlOw0KPiA+DQo+
ID4gQEAgLTEwMSw2ICsxMDcsMTAgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0DQo+
IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ICAg
ICAgICAgICAgICAgICByZXNldF9jb250ZXh0LnNyYyA9IEFNREdQVV9SRVNFVF9TUkNfSk9COw0K
PiA+ICAgICAgICAgICAgICAgICBjbGVhcl9iaXQoQU1ER1BVX05FRURfRlVMTF9SRVNFVCwNCj4g
PiAmcmVzZXRfY29udGV4dC5mbGFncyk7DQo+ID4NCj4gPiArICAgICAgICAgICAgICAgLyogVG8g
YXZvaWQgYSBkb3VibGUgY29yZWR1bXAsIGFzIHdlIGhhdmUgYWxyZWFkeSBkb25lIGl0ICovDQo+
ID4gKyAgICAgICAgICAgICAgIGlmIChhbWRncHVfZ3B1X2NvcmVkdW1wKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHNldF9iaXQoQU1ER1BVX1NLSVBfQ09SRURVTVAsDQo+ID4gKyAmcmVz
ZXRfY29udGV4dC5mbGFncyk7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICByID0gYW1kZ3B1
X2RldmljZV9ncHVfcmVjb3ZlcihyaW5nLT5hZGV2LCBqb2IsICZyZXNldF9jb250ZXh0KTsNCj4g
PiAgICAgICAgICAgICAgICAgaWYgKHIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsICJHUFUgUmVjb3ZlcnkgRmFpbGVkOg0KPiA+ICVkXG4iLCByKTsNCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
