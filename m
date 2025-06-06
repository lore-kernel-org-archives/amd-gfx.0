Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD52C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 07:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B629110E92A;
	Fri,  6 Jun 2025 07:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TAUOEQfq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E0110E92A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 07:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBA2CbrRZdt1l4a6waxWtE+D90t68bMaT67fDgvjRiNiNCCQ03srVXg9FArSvRQiN79MQCa34HkJjdBFGTM/VbnHn3zI7I/OYMbg0IPQ1tSG6cEUbfDfOOndMtlZW/1inh4qgxndeHjXoXxhioyQyHT+7qxoZ6zLmAT0mheLOQBL9PeJYt022a2Hq4+bsn6vEbYeotYrQpZNPjnButwUk6uCYHo3bN6ve9EY/uE9wSM6Hn8Bmy9estePZ9nLycB7qkGYB4tt90e3bIuArzhF1sn+FfPfmfMAZoC2hkjNPe+IP93d4esvqjqP1amNkIK//TnksMSl28GJCzCXnWeg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Pdr7CEV/uPz5VyhjlR8lZQkekmyvZmGhbBpkQ0Pzo=;
 b=EYjvKs5JUvIwtHOiQcf+iSAb6h80V8o9JQ6g4YrT23CB5GDFypYKCY7Yk0dbW2WC78oese4/cXZRGWQN3JdJ4/PY+uP3D1ANMIXXNPIKs7hQiufnmiCqrRRFl4h5LpJcNNk+gRdDYmJMC0RfU85ofialsiG74X22tfgp/AVhxiecNo0UJdLwfUZuuWGWjBde8qLeFTNSTAnOacSlfyJVpgw0k7hw1Gzz5sQ8T9WxeHb4wTHhuIJlFzwgdHjR28kckG+WFfDkBZFOlQDSQsGE07ho5BTriAer6mH3qmmVXGpUDBUt/VO1JVnkZSB7f6v9wtkNZi2XMK/Hi3ngjibWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Pdr7CEV/uPz5VyhjlR8lZQkekmyvZmGhbBpkQ0Pzo=;
 b=TAUOEQfq3PlTuM6XmROb1oPv88xVtyc8rzII31KBTOJLzhN55c82NMVcALL2+Cok80pfdLQ5Q7v/Hhk77IK+ZcLiByhX0P3BFtBnsLT0p4GYlLleZ78cWgIYL/eB1or1ZOru2ho5+Z1+QOyETOJhKHXwSi+9INtWfmubifi++tU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:51:16 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 07:51:15 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
Thread-Topic: [PATCH 9/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Index: AQHb0Tg6LnKdYSvlfUexW3DcvtQeK7PruFoAgAoSIIA=
Date: Fri, 6 Jun 2025 07:51:15 +0000
Message-ID: <DS7PR12MB6005C42DAA5C3BBEB72B2290FB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-9-Prike.Liang@amd.com>
 <CADnq5_M1nRDbPXRkbtdTbjgFBNRwJ_jHgCUp2+rhZcfrYogaAA@mail.gmail.com>
In-Reply-To: <CADnq5_M1nRDbPXRkbtdTbjgFBNRwJ_jHgCUp2+rhZcfrYogaAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=996d2517-ce5b-4f95-90e5-d8992ccfc79e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-06T07:41:59Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB7709:EE_
x-ms-office365-filtering-correlation-id: e55b7b93-f81d-43aa-6735-08dda4ceea52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnBNaWRmcE1CU1pHZUpPSGFFL2dMYlJlRnNKRnVIVXRCOXVwb09UT0o5SVhn?=
 =?utf-8?B?NXNvZDJGK3VhYlkxRVdqL2F3S20xOXErWWJESUVBYUhjYng2QXdsbFpna2JC?=
 =?utf-8?B?L3VwM1hXemR4NXhlcVl2NVF1V1QwUE5CbFdhbHBzME1iNCtqRWVCeFh4RWt1?=
 =?utf-8?B?SExvcVFRVTY5YXNMMUVRYWZiOEI4MkZZaEQ0bWlUS1VJK0pKTm1UWm1PcVRK?=
 =?utf-8?B?V0grWW1YcEhWWEhyTkZINkI2RzBCTWdXQWJINDM5WU5WWE9kelJra05Lc3py?=
 =?utf-8?B?MHppYWd0Mm01NjcvdVV5bHlOSVdYNjFhTWNwaVVvVy9xd0RxR2lMbFVKSVpt?=
 =?utf-8?B?dVpZV3ArWXhjdzNaRmZjKyt0MHhVclB0WUlMZWRKejZKcURZOCtvRkZCbzdr?=
 =?utf-8?B?U24rdG1ZUGtVOUl6cHErUnRsY1M1VE9KN2szR0hwbnJTc3NkRFFlNG5GVWdu?=
 =?utf-8?B?b0NudG9jTGNSQVJjdkhIUTMvMHU2ODE1SGpMMDNrcnlTbWtMcWMxL3BGWUkv?=
 =?utf-8?B?VmdJbUIxZlk4am5URENXTjduSU80dk4wVmJ0bHhZczRwdkxhYnVXK0hXRnFr?=
 =?utf-8?B?b3JPUzA0SkozZnorWCtVQzBWK2xvdXFraGZ3ank4Nm5kOUJid2Zua3lvdEtk?=
 =?utf-8?B?MFVLaWRLc2RRRGtGZnhJL0Jqb2tNdVI5YTR2NHJYRitPYktvMTBlV3NrM2lr?=
 =?utf-8?B?bmRvZ20ranBJM1lYVTlmanNSNVVhUHdCSEFjOVp5b29IOE92ZldqSmw1b3pY?=
 =?utf-8?B?NURDeTdieHJxcEQ1eEQ1N01HQlFCMEhldzB0T1FNRHByZjhnQm5zMmpHWjhM?=
 =?utf-8?B?amxQcjNhL1NiWDJBTll6VHZKODJITVZ4YXJ0RjZvWG9scmxOUWNzWXB3MjY2?=
 =?utf-8?B?YU02bTFaeDVTS2JiV2p4Y0FXNEpELzloOWxFVHNnc1ZtajZkMU1mWHlKMFlj?=
 =?utf-8?B?UFlLYzNGUGRXNjNjVzBBQjJTU3RRbjY2aE1Cb2h4MXE2T0d5S3pqdEYwZyt4?=
 =?utf-8?B?K3JMbTRHRDdSWXpDcXB0STJ3TUNYRVZVRThJRnZKZklCQUV3eUhGVHZITmlN?=
 =?utf-8?B?VEVFWVBoYm5PSWFsZDJsTWVla0RmMjR6U3NhYkFyOE5JZSs2ME1UNElERGt3?=
 =?utf-8?B?czlMZ1JpSnhCZEpzdzQ5M1FIaEdDcGRUdURPUUxNNnZOemNhL2tHV3NtQ0N5?=
 =?utf-8?B?V3NpeHhVbGYrYWU2VXJLV2pxanp0cFVINUkybFN5SnE5c0h0V0p0dFI3by9v?=
 =?utf-8?B?eDhUQ1ViY1pSQnJ5Wm53RFMvSTBIdVpVbUFzMkloUGlIekRjV0tsNlZ6OE1J?=
 =?utf-8?B?TmFEcStsaGI3NVlvRFJBMlJYOTZhcHh5aHREUmpzdG9meS9OeENTbXRVQXY0?=
 =?utf-8?B?b0tnSnNsNW1DWGFGRzNEczNlMks1WW10WDltMms0bDc1a2RkUzdSVm83bG9v?=
 =?utf-8?B?b2VxUE44WFJmV1hDTSt5MzVOdWRFNVE2MEZyWENkMlpOS1FYQzBjMXMyeC9E?=
 =?utf-8?B?VGxIZWg5c05xa3BXWWx5M04rclMvZ1k0UUtzMWtlK0ZwSktzdEhsSFpMbTZm?=
 =?utf-8?B?VTFldVA3K05BRzIxUFVnNVlYZFFjbTJNWmtKVnVOSXQ2UVdsVGRWbGxoRlhm?=
 =?utf-8?B?elBscHRwN1dTbTFCbkg1eWtXVHlMRlhRZnVCRVduM1hac2w2bEt1VnRPT2sx?=
 =?utf-8?B?L1hJQWJrdE5Ua0dobU9kTTJaUmlQYVJZaFpzNEJVbTJMZlZvU1REeUlaRGt3?=
 =?utf-8?B?U0lNSmFva1pjSDJocXM4UXhNSWNaZURXVll4QjIvNDM5eElGVDEwM1A3REVM?=
 =?utf-8?B?K1J4b090eTI4VlNKbVJMMjZWWXJ6K0c4djdVNERrblFrZWNMcnFPT3ZLTDc1?=
 =?utf-8?B?VTQyYTZQSDdYaFYwVDJSeEZldlNqRVhialRkOHdzeVB4S09QR29SeDc1bUVv?=
 =?utf-8?B?N3N2OXFiR0xiWmxFV1FsaEQybmRrSjB4alJwc2Jsd2djaUpLS21YQ1laZEg3?=
 =?utf-8?Q?6wMpc8LK4ZYq5XSBQ2R7kojdB461jQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alB6Mm1FT0V3Wk0zYXg0MmYyQVFBaTR4S012Y1hoWUhTREl6Wk1rdEhuZEJl?=
 =?utf-8?B?M1JhMlVhU0FNZU0vTkhvMm8zZUI1Nnd5S3dBNGh5ZktFUytOcjlVbWU2ak4w?=
 =?utf-8?B?d3NVYitONUVpSGpEY3NWV3YvUU1FNDhRRUhjaFg2L0podXVmMytqdVU0QnJJ?=
 =?utf-8?B?YkM2N2c2OXFmYU1oRGNTWGplbjlacThlVU1BbHNxS3oyR3dHU01KSFFQTVpR?=
 =?utf-8?B?NHhZRmdkMDJPTFI5d2RnSk5rUHpHQm43UXJEZW1TalllN1RURXFYVitOVFBR?=
 =?utf-8?B?MmtERDQxdWxQVHl3MWplTEdJdGxKRHNRVmk2ckJaOEdzT1RTeThvd2ZmU3VN?=
 =?utf-8?B?QTIxVXcwQTZscGQwRUl3bHEvdzYza2ZzMjVpK2NQR0tPYXV6ZndpWFA5R2tz?=
 =?utf-8?B?TitqOFRhS0h1MzhrWkJCcGlQVk84cjFoVG1Ba2w2YU1BNTJsWFVPUEhPMVhx?=
 =?utf-8?B?a2k4ejdwNUxDSDVvcmtBZHB3UXZoYmVnY1J1ZzZNVnRpazBmNUtQWHB4SDF5?=
 =?utf-8?B?ZzdyZktJaHp4ZHpucW1zbkVZazRUSS9mOVdrUUFCVXc2ZWdSaUd6TjJnNUlh?=
 =?utf-8?B?dldMdXQydHlvd1NTcTJMZUxWd0VwdS8rcVJrNXBGU01xSTI5dHh4dzBrcGJu?=
 =?utf-8?B?RWIxMmhDbW1DZnJHUm8zeCs1cGhzWE1FSThMdHA0VzF6VlVEaTBWVyt6MGRK?=
 =?utf-8?B?a3BZU1dhcWVQcWk5a253NFk3Qy94UHladHA3cHdOeHA5ZlZpSmtRdVFRR2RT?=
 =?utf-8?B?eVd5clhWQ1hlbzlZbHROa2pIMXVpWVFUM3Zub24wbE8zN0xNS2FFM2JLYnlY?=
 =?utf-8?B?ZkJnWGYxOHI3RUFvM0trWW1IUDFkS0h4SUYrM2s0TFI5dGlCZ2VIMEgraWtO?=
 =?utf-8?B?Tkc2bVZ5ZGltYUV5V2JuMDMyVVJDVUFCS3pkWjVGTENXUGpiamRFT3VSSy9h?=
 =?utf-8?B?SlR1b0U4QlpxRUNSMGt6aUloZWFQV0lIOGRnaC9MWWx4TnJGZTVETkhTakw5?=
 =?utf-8?B?YUJvVDZkT1lNWkhJamtwdzU1dGJnNVVSMHhKK3RmL25EMVBrODFpS2dtNlpX?=
 =?utf-8?B?dGxia0FqS0ZEcU80MU1HWXhzUEVQQmxuRDJseVRDUGttZElWeFhzay9FS0pU?=
 =?utf-8?B?OWlaR1IzU01VYTlTSk5MMm9DTDVLZlZLR1ZPUEkrQUw2dy9DWU5Fc0RFTENY?=
 =?utf-8?B?cVY4S0tJVVczK3FZdmtFMnhyNGx4RDZidVI0OG9uVHNEK2hhdk83elhoWTR6?=
 =?utf-8?B?OExYaTRaVUg3b2xnSlJ2d3BYV2I3SGZQRVk0dk80SEpCZVBVRktEbGhNOU1C?=
 =?utf-8?B?S0xJM09RKzJwT3VaVmJjUmM0b2tUOUFIeTJ3UzNwdkFBbmU0alZhdUtFQjk3?=
 =?utf-8?B?cVE2Nm1CMGM2a2k5NFVtdGdDRUQrQndoU0I1MnR4SVFVa0lEYjV6a0lvTTI0?=
 =?utf-8?B?UEtMb0NJVWdHcEZHRm82c1N3Sm54WHVvUTZtSlNIMHlSdi94eW91clgwYkgv?=
 =?utf-8?B?azdCbU5Damg5T0FtMUZ1cHNlUE1WU2NhUkVSbmhxVDBkbjE5ekZhN1FXR3JS?=
 =?utf-8?B?dlNHOVhKWmF5WGF4ckJBNTV5bTZzZlNMZlJRaThHdVA4bmR2Tzdrang2WHZZ?=
 =?utf-8?B?czBXcDB3QUdJSC9BUUJ5VVJxcTZLMWJPS0dFZjBZdUQyYnR6VDZ4U3dSdHNH?=
 =?utf-8?B?YXZyWi9UUW0yNlIyOWRPYWtzTG8xWVFHQ0VVdUQ3SExQTzdYelh2bmNFUG5Z?=
 =?utf-8?B?OTUvREJ2YXlHdjlId1Qxdk1nS2hVbVlxUlU0aFBPYnV4aEIzNTFIUHd4Vm81?=
 =?utf-8?B?WDRBcWxzWURxazZzdnE1NUo2bDQwejBPdm5FQmhWSTJLWDF2Yk83cVFEVnhn?=
 =?utf-8?B?RTRkaC9SZWJtcWFHcnBvQ0J1TWZ1UGhtMEN4bWNXWTdSdGpsK2pVQzR4RDIz?=
 =?utf-8?B?REk1SHUyTk92Z3pJV21nM2IwWldIQTcvd2ZXK3Bta1JFazFWQndmRzRLbmJB?=
 =?utf-8?B?UkdJdDZJYlRQYmFyaW1Qc01GOUxabndPRjdpaHl5ditwdEs0WkZzcGFpeFVz?=
 =?utf-8?B?Zm52TlJLbnN2WjhWSms0djNjd0FSc0txRGdBUG1UK0UrcTNlQXE0MFJSaGVI?=
 =?utf-8?Q?gZ6M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55b7b93-f81d-43aa-6735-08dda4ceea52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:51:15.7917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBidXmFjU6Mv4QIEs5YMIl9rst8WbvCizLhBbA3b4doFo2dQ3wL5csY3awkye6dv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogU2F0dXJkYXksIE1heSAzMSwgMjAyNSA1OjU0IEFNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47DQo+IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggOS85XSBkcm0v
YW1kZ3B1OiB2YWxpZGF0ZSB1c2VycSBhY3Rpdml0eSBzdGF0dXMgZm9yIEdFTV9WQQ0KPiB1bm1h
cA0KPg0KPiBPbiBGcmksIE1heSAzMCwgMjAyNSBhdCA0OjA14oCvQU0gUHJpa2UgTGlhbmcgPFBy
aWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIHVzZXJxIFZBIHVubWFwIHJl
cXVpcmVzIHZhbGlkYXRpbmcgcXVldWUgc3RhdHVzIGJlZm9yZSB1bmFtYXBwaW5nDQo+ID4gaXQs
IGlmIHVzZXIgdHJpZXMgdG8gdW5tYXAgYW4gYWN0aXZlIHVzZXJxIGJ5IEdFTSBWQSBJT0NUTCB0
aGVuIHRoZQ0KPiA+IGRyaXZlciBzaG91bGQgcmVwb3J0IGFuIGVycm9yIGZvciB0aGlzIGlsbGVn
YWwgdXNhZ2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlh
bmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMgfCAxNiArKysrKysrKysrKysrLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgIDUgKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IGU0M2E2MWY2NDc1
NS4uZTIyNzUyODA1NTRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtMjM0LDcgKzIzNCw3IEBAIGFtZGdwdV91c2VycV9tYXBf
aGVscGVyKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+ICp1cV9tZ3IsDQo+ID4gICAgICAgICBy
ZXR1cm4gcjsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkDQo+ID4gK3N0YXRpYyBpbnQN
Cj4gPiAgYW1kZ3B1X3VzZXJxX3dhaXRfZm9yX2xhc3RfZmVuY2Uoc3RydWN0IGFtZGdwdV91c2Vy
cV9tZ3IgKnVxX21nciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSkNCj4gPiB7IEBAIC0yNDMsMTAgKzI0Mywx
NCBAQCBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9mZW5jZShzdHJ1Y3QNCj4gPiBhbWRncHVf
dXNlcnFfbWdyICp1cV9tZ3IsDQo+ID4NCj4gPiAgICAgICAgIGlmIChmICYmICFkbWFfZmVuY2Vf
aXNfc2lnbmFsZWQoZikpIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gZG1hX2ZlbmNlX3dh
aXRfdGltZW91dChmLCB0cnVlLCBtc2Vjc190b19qaWZmaWVzKDEwMCkpOw0KPiA+IC0gICAgICAg
ICAgICAgICBpZiAocmV0IDw9IDApDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQgPD0gMCkg
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRybV9maWxlX2Vycih1cV9tZ3ItPmZpbGUs
ICJUaW1lZCBvdXQgd2FpdGluZyBmb3INCj4gZmVuY2U9JWxsdTolbGx1XG4iLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmLT5jb250ZXh0LCBmLT5zZXFubyk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gKyAgICAg
ICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsN
Cj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkDQo+ID4gQEAgLTQ2NCw3ICs0NjgsMTMgQEAg
YW1kZ3B1X3VzZXJxX2Rlc3Ryb3koc3RydWN0IGRybV9maWxlICpmaWxwLCBpbnQNCj4gcXVldWVf
aWQpDQo+ID4gICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRl
eCk7DQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAgICAgfQ0K
PiA+IC0gICAgICAgYW1kZ3B1X3VzZXJxX3dhaXRfZm9yX2xhc3RfZmVuY2UodXFfbWdyLCBxdWV1
ZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGFtZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2Zl
bmNlKHVxX21nciwgcXVldWUpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRybV93YXJuKGFkZXZf
dG9fZHJtKHVxX21nci0+YWRldiksICJEb24ndCBkZXN0cm95IGEgYnVzeQ0KPiB1c2VycVxuIik7
DQo+ID4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiAgICAgICAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaiwg
dHJ1ZSk7DQo+ID4gICAgICAgICBpZiAoIXIpIHsNCj4gPiAgICAgICAgICAgICAgICAgYW1kZ3B1
X2JvX3VucGluKHF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gaW5kZXggNWUwNzVlOGYwY2EzLi4xNjhmYzM4MzVhYWYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IEBA
IC0xOTMwLDYgKzE5MzAsMTEgQEAgaW50IGFtZGdwdV92bV9ib191bm1hcChzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfdm0gKnZtID0gYm9f
dmEtPmJhc2Uudm07DQo+ID4gICAgICAgICBib29sIHZhbGlkID0gdHJ1ZTsNCj4gPg0KPiA+ICsg
ICAgICAgaWYgKGFtZGdwdV91c2VycV9nZW1fdmFfdW5tYXBfd2FpdCh2bSkpIHsNCj4gPiArICAg
ICAgICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAic2hvdWxkbid0IHVubWFwIHRoZSBWQSBm
b3IgYW4gYWN0aXZlIHVzZXJxXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKyAgICAgICB9DQo+DQo+IFRoZXJlJ3Mgbm90IG5lZWQgdG8gd2FpdCBmb3IgYW55
dGhpbmcuICBKdXN0IHJldHVybiBhbiBlcnJvciBpZiB0aGUgdXNlcnEgaGFzIG5vdCBiZWVuDQo+
IGRlc3Ryb3llZCB5ZXQuDQpbUHJpa2VdIFRoZSBjdXJyZW50IHVzZXJxIGRlc3Ryb3kgSU9DVEwg
cmVxdWVzdCBhbHdheXMgY29tZXMgYWZ0ZXIgYW1kZ3B1X3ZtX2JvX3VubWFwKCksDQp0aGUgb3Jp
Z2luYWwgZGVzdHJveSB2YWxpZGF0aW9uIGlkZWEgaXMgdGhhdCB0aGUgdXNlcnEgQk9zIG9ubHkg
YmUgYWJsZSB0byBiZSB1bm1hcHBlZCB3aGVuIHRoZXkgYXJlDQppZGxlLCBzbyBoZXJlIGRvIHdl
IG5lZWQgdG8gZG8gdGhlIEJPcyBidXN5IHdhaXQgb3IganVzdCB0ZXN0IGFuZCB0aHJvdyBhIHdh
cm5pbmcvZXJyb3IgbWVzc2FnZSB3aGVuDQp0aGUgZHJpdmVyIHRyaWVzIHVubWFwIGEgYnVzeSBC
Tz8NCg0KPiBBbGV4DQo+DQo+ID4gKw0KPiA+ICAgICAgICAgc2FkZHIgLz0gQU1ER1BVX0dQVV9Q
QUdFX1NJWkU7DQo+ID4NCj4gPiAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkobWFwcGluZywg
JmJvX3ZhLT52YWxpZHMsIGxpc3QpIHsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
