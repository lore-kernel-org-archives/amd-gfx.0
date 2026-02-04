Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D224DE8B397
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6965C10E730;
	Wed,  4 Feb 2026 04:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5XzMJ4lQ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8270E10E730
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU9JMML+YiLuv5g5Id1KEStJFLD1s9eG6JovjZ3HfTTy711AwiK5kTaPC+hzKojrIridiQ//NCySUwI3W/KZENabYAzAMGm8/0k01hdqqCl0pG21u3tVRvDJ/hRcQOQm+qTepRSid+eLbkKVqtybxeCaLzUo6lXgOdxrK7/gKGy/aKBepiHUoyo1NJAfCQCHDZ3aqwzhb3HjoW64+HCiYfpaXtoFct6xQ4CnVdbuEg1MqfvwEeoK5I7NSnObkq7gFlEUfUCNRshgB+vT0B+rzpwutHGiq6nUd3uV+utDljFl+KEwvD0QUiC6sFoIAIHFztABXxx8ykxui8Cur8mhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+wDFVxjDoPOW3i8XDKGkHsE9Yk5QZGSQyFr5mUCfsU=;
 b=cNwqMVH/iHPMk4pQj4btXjz1Pwb6T1minAJc+EgOZaQrgHpLq5iZYB0iA1Q2umh5ntkLhHLvmfUWjdV4W8MfWVViUkDaNwWT7aWlmrnqt7RwH9x6wbT9df7b0hI4EEI3Hu29p6+M/pALBi2OyBZW9aTQ1rbF/YVlZ9iLAl/FH1NSs8DxAtK+kKNVVlwPB4rA1wHjiitmKMg6xkAJ6dBr8PRwXkGpiUfJcGgFkXiFHCuu3Rp+NBYuEdYEp3H/WMWqYWtU4yBX+dHrtoArAlKLkhdj3AG242rRoU1/ZiXHGlK99brdSR1lVgAXGFBG2qMGo7WYAVzkGenfN4ME/wO1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+wDFVxjDoPOW3i8XDKGkHsE9Yk5QZGSQyFr5mUCfsU=;
 b=5XzMJ4lQIdHHoX7Yaft5a3VPKKwz3V35ygJK0z90vrh+avyxQAmuyytYR5GnXhb4bGhXo1YRvRdMM9A2GgwSslHXLavO0K3m1DD7pNImqC9evfdYH5/HQ/hkIz5Y3GtXppnTszBHZbzH+T0Ij9jDcZzwNVlhapLGupc6tRV5tgY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:08:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 04:08:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
Thread-Topic: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
Thread-Index: AQHclYj9SE87hagoR0ivomno8hQ/NbVx6CqAgAAEXQA=
Date: Wed, 4 Feb 2026 04:08:30 +0000
Message-ID: <PH7PR12MB59979ADFBC092D6DF4549A228298A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260204034732.187325-1-kevinyang.wang@amd.com>
 <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
In-Reply-To: <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T04:07:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: 283fbc30-e5bd-4961-5c6b-08de63a30eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VWpENVlHdkxNN2pSdmxRaERjL0NrRjI1MWhFOGowUVJ6dyt4S2hGN3BsK3U2?=
 =?utf-8?B?ZmRDVW9GaDV3YmxlK05jeUs0SHJ2Vm13dmdlVUREdi9mbDJZN2x3UFh2M1VH?=
 =?utf-8?B?K0pjUU9ZMlZiUm1TNWV2ZkV1SmZ4Y3pRN1FzL3JRN2FaZ3dyMjN4Z2JvRlBK?=
 =?utf-8?B?TmdDbkdVekVlczZ2aFF4TUs5N2RmaVB0dkg2dGtZSXhNWXpla0UvNmJzUnJn?=
 =?utf-8?B?SUp6YnlIeWhFNWlhUkYzbXZDeDk1MzhadU1XNWordXdFZHJlUHpCaUx0Z1J6?=
 =?utf-8?B?S21VNEpkKzZJbGpmdlRrYzVxR2hFejNHY1djM3JDWjRtZEU4L3pydFFrMlRa?=
 =?utf-8?B?NnFRaDVMd2kxVjNSdHlwUHBWbXdnSmNHMitabWs3WnN2d0dBZW9JWnBsQW1V?=
 =?utf-8?B?ejFSUmN0RE9udTVHQVpIMjNDK0luVmw2SmxpOWJBcVVwSi84cGdvN01OUUYv?=
 =?utf-8?B?YXNwMG5JeWUxdmcwbDNJR1JKZEUrY3dZNlNmNnhLcHdUb3VyZXdNWVBmZlh6?=
 =?utf-8?B?dWlucmlORXM5enQwMmpiT2NlUFdmSjN6YmU5ZVBCVkhkNUhab1ZJUTk2cnBT?=
 =?utf-8?B?SVliaHV0VUlNMGV5QXdpWmJQV1ZrMEo1aUZmV3BoZ3dsQThpK0VmazZlbW9K?=
 =?utf-8?B?RGpZVVBrZHo2R2g1L0RwelIxSXl2WUVaZlFpSUkrcG5jQ0cxdklDRTB6dEtl?=
 =?utf-8?B?Rlh2eTh0Y3NmN2FvRGExaEU3UlFKYi9Ma1BxMGJodEUwZXJLekpraXBhdzdY?=
 =?utf-8?B?ZTlZK3F6azhTVFUwTUtVa2h1YjFMUlRNbHN2dTFiTE5OSUJEVDBYalVFTCsr?=
 =?utf-8?B?ejBPTWg3czNHZnJ6NE93TDR3NFRVNGx6OTZhUFU1VTJtZVpjVmh5b3NsMnNO?=
 =?utf-8?B?N3VHYUFvWFpRZVJhY2JseWRKQW1KaFk5TnB3d3JnZENJRFNkVnZuQ3ErWENH?=
 =?utf-8?B?b2Jmcmhpdng0anM0Q1JpNE43NkV1c1VVN3BuKzRKRFN0QVEzUld4YnozMVE2?=
 =?utf-8?B?Nm9DWWZKcDlpMWZkeHErMXJuRTNxckI0WGh5T0Z5Z2M0L3hPcmxwRjRTa1Rn?=
 =?utf-8?B?QWtacnA3MVI2b09XSG1TT2I1MkxGaE9ZcWxKYTNGalRwT2UyOUJWQTRxWUEv?=
 =?utf-8?B?OHErN21IZWROQ3U0M0VsZ0hZZjlSaWNWYjZqNkJ0MVhHeFppWUdocFpOTHM2?=
 =?utf-8?B?cThDOGllMXFiM1R4SUU3ZEhhdDlqNko4emcyaTB2STh3RU5JUGNXakZxbjdX?=
 =?utf-8?B?L1U0N09YNS9vMzFwQmJjWk1xYmJqR2ZYTFdZQWoxbG5OVXhkdTRBNjVsUHhG?=
 =?utf-8?B?Yit1WkVIQlJkc3hVVHRkcUNobzNTdlBsZGRvVXQ2SjJLREFrQ25wcCtKbGtj?=
 =?utf-8?B?Y1A4N1BCQTlmR25ZUFBOc24rNDZ5d0ZwdDJPa0tRTzFNQm42dXp1anRBczR1?=
 =?utf-8?B?NVFvTExXd0htYndUQUkxYXdxM0d0bHBJVVhGK1JwRm9QM081eDJxWFFsanFK?=
 =?utf-8?B?dnIzRnErL0dJYXdFdithR3NZaS9YL09ESk94eitFQmtra0dQUVBlQXR3YzE4?=
 =?utf-8?B?RFI0dEpOK2JxNUJZV3ZJcjRSNm5WSU5NVlhKZ2NBRnRTcTgrWUFhNnhxb1pO?=
 =?utf-8?B?dXZIYUR4L1owZnhqUzBFbjhERnpWaGFCV0ZKQmJxWTJlTVB5RjdHenl3VW9w?=
 =?utf-8?B?Q3ZsZW1PUUovYXpqZ0Q0ejBPaFkwMllCdjNWRytMS2tRdW5PUkM0NnZzWWRW?=
 =?utf-8?B?cVhWRWlEZGtrcGUvcE1XRnVnRkpzZy9wZWcweG14dUdvdVAwNjhFK1BQY1V3?=
 =?utf-8?B?OUtGOE1NaVBla1NaTDdnOW9HQklOaU1qZi9wcFEzbXNyb3dkR2lHeVNxZHZo?=
 =?utf-8?B?Q2VvWTNTVVllRUhvMkxrU1ZPemZybmRDUnJ6OWs0d0R4b28zUll1VHAzaEpB?=
 =?utf-8?B?OU1zRnhjaDdkYzlpUElEd3RLVVlidWo5cUhMUFMwYlVXcEZoUG5vRzdqS0pr?=
 =?utf-8?B?T2JGUjRzYlBkTGxoVmlHZWpCejJud1hXOUZXMkZ3ZHMwR3NJMmVtbng1L3Zs?=
 =?utf-8?B?NGdMQjgzZ3YvUFRwdHBxWEczS0d3LzZIaXluMEhIWUVYa2s2MHdWSHVNd0FR?=
 =?utf-8?B?bmZNalYwbWV1NDNyRG12VjFsamdwT2syRTZvMGs0NXZWRWkxbXRLcXE0Rjk2?=
 =?utf-8?Q?K4LILpSWK1nKt9bOmKFkucQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk8rM09Pb3lMMXE5S1VCMlFFVC9JZGJVYmJHNGhteTRrWFR3dFltWWE4cG9U?=
 =?utf-8?B?RVhsWjNlTTgwNUtuZkZHODRjQlU5V0s0dllnbmRkWlYzVFJ4VFVkc3ZUMVc5?=
 =?utf-8?B?aThLcGtvd1d1NldRb212b3AzcFk2TlZSRHdMVnBPeHV2MlhXL3U2MzFnUTBE?=
 =?utf-8?B?R1pKTXpRc09URWRsZ3FtYmMzQWRXT3B1T2pqb1JndTJmZ24wcXNGcTh4QmxL?=
 =?utf-8?B?UjhpZmQ1NU05WGI0clBlaGVUUlpFWnh6bUFyTFNtcmx2dFFUZit6VnpnTVRv?=
 =?utf-8?B?SElOcXdJQkFkVlptVFk2RVJzVUZFNDBuRDFUNW5NTHQyVFU3djlMczcxUm9O?=
 =?utf-8?B?bXUyc3ZYT3F1N0FjSlRZaVNUd0JSZVYvOWZ6SW1WUytqOTlDaEJGRFlmRnJE?=
 =?utf-8?B?VThmMlQwQmhjZlBwRzNvVXhITEVDTmNocHh0SDhTUkpmcEd0VGltNkNyM1Vz?=
 =?utf-8?B?ODdnd3NBMFQ4S3BaUE8zS3NZOG94blV4TEFudmFYNlZ1VEh3Q2JIdWpBdXds?=
 =?utf-8?B?aEZ2WjVNTnNabEhmcWIvTTd3K1dZTGR0MHQ2Nm1BQWROMkEzZkxPdVR3S2I2?=
 =?utf-8?B?dGJhVjZHR2M1TlI2NmhEVGRQZlZzZDRlQmttZzJNaEZZQU1IbklQTEhHZHla?=
 =?utf-8?B?Nlc0RmJMV1dvUlhnN0IrUDA3R0w4RTJTdTJCck1sUjhwd2gxOWF0bTdvcVZE?=
 =?utf-8?B?WW9tOEdZQnJ2SUZMNlhqTldmQVhxT04yWE4wK1VUbXlpT1hBYjFlTmF4OXIz?=
 =?utf-8?B?dzBKbURrbmo2MDd4bU51VDRyS0sya2czSUU3Umw4VUFzNSt5cmczejBxdmZm?=
 =?utf-8?B?OEdobWcrbXVybkE0TWpoYnNwWnhBbzVGcVVUWnltWlplb3h5dzRrcVNoUlhy?=
 =?utf-8?B?YVFJaVZJSFh1enpWMmZpZWNrWlFYalZvL2lCRHExcFJLSDFFMDdvM0dSOGt2?=
 =?utf-8?B?N0hnbHhmTlY1U2xvK1NuMnFVWHlQaG90TGg0UUk5SHdSTUxmMThZZTRIZml4?=
 =?utf-8?B?MnlOamdaYkV3TUtPQWx4dy8rWWFiOEg0aFM2bGZSTFpYdlZxK0Z3bkhBUW56?=
 =?utf-8?B?MmpySHVTNStJaEpvLzNZZlVIbUlwNUxvUUg3RUhkZVlmT0FRV1RJSWdnNGp0?=
 =?utf-8?B?amxCY3B0dnozTm5DTU1XOTJCTzIxWVlDQkI5emRUais3cktkWVV4YVVZNmlY?=
 =?utf-8?B?TkRsZTdpeGlEZXpGU1lpZjA4SDZVRXRGc0dvNjg4dHhnU0xZWTEzbDJReldF?=
 =?utf-8?B?M05qMWgxbHk4eU05NTVPNTYvQmEyNkZ1UWdOYTF5dVIrYVhjM2JTV09jZjcx?=
 =?utf-8?B?Mk5nWkE1YmZLSHhrYXRGenMxSStJd0ZBWkkwdnZYWWpZZnNDK3NjNG5yWmRk?=
 =?utf-8?B?c3NybFZSQ3JrRlFMNFhvVHZzVVR1RGNLS05ERTdnanpkN1FaZ3VPbXdYby9P?=
 =?utf-8?B?RWR0LzEzblZSd3RRT0pkUjNDQ21HNDJ5cmRubVZIeUZvT01WWWxRLzVtaHlp?=
 =?utf-8?B?dTlFbEF6OVV5RHhvOE9WWkdTc3lDbGF4NmhzRmtTMENLUEhiZTBONVNwU1Bo?=
 =?utf-8?B?MERwY0htNTRRWHJzbXZXY1FvcFZLU2NQUHlrdWJjNnpubjdnU3Y4S2M2YUFV?=
 =?utf-8?B?ZDRKSC9JcnF1ejM5S085SUZybDJUUklTYnZsQkhNZE9CZ3VRYjYycHA0V1VJ?=
 =?utf-8?B?RkYwMUR0Z2UvRDNLZlh1VHdqZ0l3TGFnamdFZkk0NVYxZm45UlZOenJ0V0cw?=
 =?utf-8?B?bXRiWFU1aktUMzFTL0x1VG43NDN3TG1RMnpSTldRT2Z0Z3pmazBwVFVHbDBm?=
 =?utf-8?B?V2hNdXIwcnUwTkZ4THV5SHhLZmVHTlp2RnhNcDdXM21zUjdmTkhhWWpTVDUy?=
 =?utf-8?B?TVVQcEE0TTBIenhtejZaYnErbTlKNlVQMFFlZDlvamRhWlpSNGxpVEtMa3lO?=
 =?utf-8?B?aG9CajhhY0ZKMGN1OE5FYk1scmVpbWNRb0hIL0JHUFhzZFpzQUthSTBJMkdk?=
 =?utf-8?B?b2JNbmZxQ3htVFM3NUZaWTAyRGdjblFPR2VlWks2T09mSXI2RktEUnFkZ2di?=
 =?utf-8?B?MER1OEJWbFRpUmV2a1FVVThvLzdXaFRhOUtBbHZydHBDWC9xN2c5Q1VVUmc3?=
 =?utf-8?B?R2gxMkl4cGhXV0RjNm1yVFNqZ0YvQ24xZlN6Yy9IVVdxbWpuTEcrbmQ4bExp?=
 =?utf-8?B?ZjB2Lys2NHVPTUF1dkpPakZwaTNwc204R0tLM01uT21nbEdsMk1UZjV5K1Fa?=
 =?utf-8?B?YTNqV3pOQVZGcXhRcTl4dHlRaS9JOHphOWR3MU1yWDFmM2poU0pVVzdyK1Ri?=
 =?utf-8?Q?IaQN3PL0p9QpMoto9I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283fbc30-e5bd-4961-5c6b-08de63a30eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 04:08:30.9930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tHI3+u1HjXzSvlNOdKk6LZFrefijScCPdoWb74KM8+/X+aiNcDQ9EraMOaaqoBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
Cg0KVGhlIHRlcm0gImludmFsaWQiIGluIHRoZSBkbWVzZyBsb2cgbWF5IGNhdXNlIGFtYmlndWl0
eSBmb3IgY3VzdG9tZXJzLg0KVGhlIHNvZnR3YXJlLWRlZmluZWQgcGVyZm9ybWFuY2UgbGV2ZWxz
IHNoYWxsIGJlIHByb3Blcmx5IGhhbmRsZWQgYnkgYWxsIHBtIHN3c211L3Bvd2VycGxheSBiYWNr
ZW5kcy4NCkluIGFkZGl0aW9uLCB0aGUga2dkIGludGVyZmFjZSBzaG91bGQgcHJvdmlkZSBhIGNv
bnNpc3RlbnQgc2V0IG9mIEFQSXMgdG8gZW5zdXJlIHRoYXQgdXNlci1zcGFjZSBwcm9ncmFtcyAo
ZS5nLiwgYW1kLXNtaSkgY2FuIGludm9rZSB0aGVzZSBpbnRlcmZhY2VzIHdpdGhvdXQgaXNzdWVz
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwg
RmVicnVhcnkgNCwgMjAyNiAxMTo1MiBBTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllh
bmcuV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFt
ZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBmaXggbWlzc2luZyBoYW5k
bGUgUEVSRl9ERVRFUk1JTklTTSBsZXZlbCBpbiBzbXUxMyAmIDE0ICYgMTUNCg0KDQoNCk9uIDA0
LUZlYi0yNiA5OjE3IEFNLCBZYW5nIFdhbmcgd3JvdGU6DQo+IGFkZCBtaXNzaW5nIHBlcmZvcm1h
bmNlIGxldmVsIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BFUkZfREVURVJNSU5JU00gaW4gc211MTMs
MTQsMTUuDQo+DQo+IGtlcm5lbCBkbWVzZyBsb2c6DQo+IFsxMjE3OTI0LjgxMDUyOF0gYW1kZ3B1
IDAwMDA6NDQ6MDAuMDogYW1kZ3B1OiBJbnZhbGlkIHBlcmZvcm1hbmNlDQo+IGxldmVsIDUxMiBb
MTIxNzkyNC44MTA1MzddIGFtZGdwdSAwMDAwOjQ0OjAwLjA6IGFtZGdwdTogRmFpbGVkIHRvIHNl
dA0KPiBwZXJmb3JtYW5jZSBsZXZlbCA1MTINCj4NCj4gRml4ZXM6IDZiZTY0MjQ2ODRjYiAoImRy
bS9hbWQvcG06IEVuYWJsZSBwZXJmb3JtYW5jZSBkZXRlcm1pbmlzbSBvbg0KPiBhbGRlYmFyYW4i
KQ0KPg0KDQpEZXRlcm1pbmlzbSBsZXZlbCBpcyBvbmx5IGF2YWlsYWJsZSBmb3Igc3BlY2lmaWMg
U09Dcywgc28gdGhlIHRoZSBlcnJvciBtZXNzYWdlIGlzIHN0aWxsIHZhbGlkLg0KDQpUaGFua3Ms
DQpMaWpvDQoNCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQu
Y29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMC5jIHwgMSArDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVf
djE0XzAuYyB8IDEgKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTUvc211
X3YxNV8wLmMgfCAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEz
XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMN
Cj4gaW5kZXggNjNhNjVlYTgwMmZkLi5kMTdkNmNkNzEwMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KPiBAQCAtMTY1OSw2ICsx
NjU5LDcgQEAgaW50IHNtdV92MTNfMF9zZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsDQo+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgIGNhc2UgQU1EX0RQ
TV9GT1JDRURfTEVWRUxfTUFOVUFMOg0KPiAgICAgICBjYXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVM
X1BST0ZJTEVfRVhJVDoNCj4gKyAgICAgY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QRVJGX0RF
VEVSTUlOSVNNOg0KPiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICBkZWZhdWx0Og0K
PiAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiSW52YWxpZCBwZXJmb3JtYW5jZSBs
ZXZlbCAlZFxuIiwgbGV2ZWwpOyBkaWZmDQo+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxNC9zbXVfdjE0XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTQvc211X3YxNF8wLmMNCj4gaW5kZXggN2RjNjY4N2MzNjkzLi42OGVjYmEwZDVlMGIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3Yx
NF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0
XzAuYw0KPiBAQCAtMTMyMSw2ICsxMzIxLDcgQEAgaW50IHNtdV92MTRfMF9zZXRfcGVyZm9ybWFu
Y2VfbGV2ZWwoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgICAgICAgYnJlYWs7
DQo+ICAgICAgIGNhc2UgQU1EX0RQTV9GT1JDRURfTEVWRUxfTUFOVUFMOg0KPiAgICAgICBjYXNl
IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfRVhJVDoNCj4gKyAgICAgY2FzZSBBTURfRFBN
X0ZPUkNFRF9MRVZFTF9QRVJGX0RFVEVSTUlOSVNNOg0KPiAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAi
SW52YWxpZCBwZXJmb3JtYW5jZSBsZXZlbCAlZFxuIiwgbGV2ZWwpOyBkaWZmDQo+IC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNS9zbXVfdjE1XzAuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTUvc211X3YxNV8wLmMNCj4gaW5kZXggYTI4NTRk
NTI4YmFiLi4xODYwYmQwZjEwOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211MTUvc211X3YxNV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxNS9zbXVfdjE1XzAuYw0KPiBAQCAtMTIxMCw2ICsxMjEwLDcgQEAgaW50IHNt
dV92MTVfMF9zZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgIGNhc2UgQU1EX0RQTV9GT1JDRURfTEVWRUxf
TUFOVUFMOg0KPiAgICAgICBjYXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfRVhJVDoN
Cj4gKyAgICAgY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QRVJGX0RFVEVSTUlOSVNNOg0KPiAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAg
IGRldl9lcnIoYWRldi0+ZGV2LCAiSW52YWxpZCBwZXJmb3JtYW5jZSBsZXZlbCAlZFxuIiwgbGV2
ZWwpOw0KDQo=
