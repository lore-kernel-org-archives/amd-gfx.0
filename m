Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E6AEE209F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1008C10E692;
	Fri,  6 Feb 2026 13:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTAEI3+u";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76F010E66B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CObk/znRWZ9mopAIJ8aielR3gCFWXO11RhVAFIfUBYjUt/x43JC8F8psfP2kWvc5JAUBImfV2/uAf3M0ug2aqQHghQ3m9+8pXsu+pM5ULoNkCWq7mK93rbGQUFnk4cxD+3aik1QERPH59fuseutY+8/E7hcj3fU3wwrlH/b8fViLM2W/HW028agHw83y0FARX5wMtSBZDpckHWxQR2qEWfUFtnd5dSUtCS8Yhrdelr99HJWbAW7TQiv+MneIw2aMT10RK4ARCVnEksydKhyrdDaxgWt8d2hY2EuTUKUAhU9+pluLlN5+o22RxNpI4493ZLbU5KWkxEEVWj7QWEMT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcqF/j+ptudDTX9YGb/KzJ15/nsn1GXp8p4z/KuXzJk=;
 b=P7gZw+XiGIhcUUXiHKSg0wtFA7DR+2XV5p5QpL6++UGvjeMJD3qBjGK1fsT2fVtSbIriFn8F/KVnQge9Pvd8xUvkYkW8pruicLWFtw6jgHhKZxWa5z1b3w8UB1sFWFuyWPT6P4v2Zh1tUTip6mFa1/aJgE2VQ0o9AsRnoHvsTw5r5d/lJ+8qxzQSk8jdBs9XzlGseWc9xbyQ+qGWPuA5cJKVg2jylLIy+75bLC97bwRs6aVMuI2tDl7iSewdAb5PcrOiqAUPN0tQ0bFJ0YIzTbaRUVM7VCnkwdd1aVZtgFWVR8LRlBOwuybswexD8U7XsbNZjst0XvU/SM25GX82fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcqF/j+ptudDTX9YGb/KzJ15/nsn1GXp8p4z/KuXzJk=;
 b=qTAEI3+u73PhXv3aji1Nto++KmK5z1Vs2ezIHGWPxrhYKmrlcgJjgBGvAdwFKXjlyA09XNX3lC89ajrMxHS+m4wKrMJTxgaftCAcrE8OkSiW0O6/jRctAA3P8vqaRgv1vNDN4ALQK3heRgRKEhMCmJuUy4aDyTTPd2LkRP9lMKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 13:28:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:28:37 +0000
Message-ID: <3543a18d-5042-468e-813e-fca3fe114efa@amd.com>
Date: Fri, 6 Feb 2026 18:58:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] drm/amdgpu: Fix is_dpm_running
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
 <20260206112449.45381-6-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206112449.45381-6-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: de6e479f-67d9-4b11-1d9d-08de6583a278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDhLNWg0MzNvc0lQOE9lL2dHaVR0K2tiOVAyRFpGdFZQeHBaMWZ3UHFhMkJm?=
 =?utf-8?B?U0F3SHJGRlloSWRUS290VDIrSGV0V2RCaW5Qc2ZHWm0xSWNWRkE5eDE1Tncv?=
 =?utf-8?B?SUFmS3U1MnNKZDFOak1PeHZpWGtmTDB5QXpTVkhraEJhaTRzMWoraEltOWY1?=
 =?utf-8?B?ZnNoeWNENVVLVnFvN0tsb0FjYUoya1k3ZXl6VWk5UXRYOWJ0UHkxaDlER0E5?=
 =?utf-8?B?NXl0RTVVT0hydXZVamlxV2d2eUYwVzUrMGJOMGsrRGxzVkRzRUdrd09sa3c1?=
 =?utf-8?B?VncrRy85TTVnSEc1VWkyU3lvemxYTFhnNGY4RjBuaTJNeUwvRDZsT21iNUFp?=
 =?utf-8?B?ajhzWVdmV3RXU0lPMGtzYTFpLzhleXpjYkpRSXpic2srZDJzREp3TDN0QzdV?=
 =?utf-8?B?dkRPUGw2ZmV1RDl2WE1yY1p3aU5oU1VMRWpzemZlSktOMXhrWGsrVFhEaDNV?=
 =?utf-8?B?UERNTWR6VVp3YUJrcFdDNFZCcXlYVDlYaU54cVViaklPMzdHa01XMyt6T05U?=
 =?utf-8?B?b2tpL3haQUJwL3F6alhqa1N4OHFzVXR2c2R2S1FZcEJrZGZHcTNDSDdMUTVq?=
 =?utf-8?B?MG05YWpuNHovb3JMNXVMK0xjZUk3S1d1em9uS1QvMHFwUmt0L3JrQXFEbVlZ?=
 =?utf-8?B?S2FGL2VlRHg4TFRIc3B1RnVnSjJXcTlEa2tReEpaUDd1ZTRxbUx0MjNJaGlC?=
 =?utf-8?B?ekRDQnVMV1ZWT0phQ2VjOG1MRnQ4cW55clp5ZU14SWFPeVFZcVR0V3ZvaVJE?=
 =?utf-8?B?OHA1WFVXaUE3b2dyMXBqcUJxZFlQbml4QXBjbjdXYVJWWHllVUw1TjVTQmZs?=
 =?utf-8?B?YXNLWmttSXJweVBCQkR3eDhsLzl1VzBKR1dlNmRkSnExUnM3Mit2bExRZklu?=
 =?utf-8?B?NTJ4OW12Ry9LdGVabWNWZWQ2bzFaNWJkbHArRFlXQ2FQWjBKcWJZT3hMMFMr?=
 =?utf-8?B?ZHdrVjNidmtYeXlreUFIYjViZWhFRkNxWEJoTXduWDU5M0Qya2FtSkZZL0Mv?=
 =?utf-8?B?cEhsRWRKOUszdy8wcThFQmdxdjVqUkRQUzR2SnFQWEpZU2xXeVl5SFh6OW5L?=
 =?utf-8?B?cXYvQ05TNW1admM2RG9BVGFTbGppdkkxRXpKSmcwV3lFR1BoL0U4S0JsZVpD?=
 =?utf-8?B?aDRRUXFKYUlxOEcvNlRmMDRUQjVjemJycjlSTGgzTmNKbFZhSVgzOEgySjQv?=
 =?utf-8?B?UTJicWJkb1J2WjdrM0ZLRlQ4QlBwZkhmY0kvS252aytKZzc0QU9RTkN6YjdV?=
 =?utf-8?B?RFVwSUY4QnRidWJlQWpyRlEwNTZhUUN1NUpmK2RrV3BXakRyQ1VUM1UxekZn?=
 =?utf-8?B?MXBpVDlYUUcwSFlxU3dCUWdoTU1kSk0zS2dZN1p1RWJZb0pqcGlQaHdOQWNG?=
 =?utf-8?B?MHh4Q0xyamZ6YXVXRC9IYzJmcTNkZGVDM242NU9ndFkvYjE4WHpDMnI3QUo0?=
 =?utf-8?B?RXB6NHlycXFhaWw4RHdDeG1sdXZaeURVQjJIdm9OUzNyWG1vbzI4Ym9QemhS?=
 =?utf-8?B?SHlySFo2cVZldFJoNHYwbklUVC9lK0ZiRC91UzZta2RGeEV1eWhIbDNtd1I1?=
 =?utf-8?B?SElWcm04Yk1LazZaVXpqWmg2ajdQSis4bFBrNTJDYi9kYmJCMUVGSVdkTUJw?=
 =?utf-8?B?eDMxUFJIaENRMU9FdVJpWTZpWDAzRTlHbTlPWXcreldkWmVwVFYrUFpmeVB0?=
 =?utf-8?B?cGdoRkI0YUxwMFNqWCtMdzVockU0ZCszZC9CdGM4VnNaeCtST0dBU1hxR3NT?=
 =?utf-8?B?NVkwTHM2azJnTDhBV2RTdVRpenZFLzExWG1kT01OOGF0LzczdjZDRlcvWTdZ?=
 =?utf-8?B?N3ZPUjhNYkV2dTVMeHZ0U3N3Y3FhVnZXbk9kRUdGOWRYTE9QWFpZTG1KVVFH?=
 =?utf-8?B?c0Jtd1RrYVcrMnkwQ3dTRDhTQyt2bUIvNlZiV1FjazIvWXBTNjBtKzE4MUhF?=
 =?utf-8?B?dTlqUTZEZVlYcVBwbGZCL1RpYXhWUXYrYW1DYStCTGVidklycTZqZy9CWTEr?=
 =?utf-8?B?MlNzL2F2VEcwcTZzSld1K0lVc002QWhTbld2WGsvOG5ySzdUdmEwVE9MaVhH?=
 =?utf-8?B?ZjZpeCtYQXVYUmhaeERLRVNQZWdYTURuM3kzZXdiYVl4eDhVY0NJY21rbjd2?=
 =?utf-8?Q?DQg0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdTZiszUmFwbEJSTFIzN1lrQy9oRWZqQXl6czhpZXZwTWFENUVqQXB5RzN0?=
 =?utf-8?B?YVhoWDJFYituM1dwZEFzNzRma05zdFRDOWhoZm9WOXFZOWREa1lMTGRQS3ov?=
 =?utf-8?B?SzNubjNqR3MxSFFCQnFHbkxFNFhkaklzVlJUUWdBWnNPWFlaeU9XZ2dQRUgv?=
 =?utf-8?B?QUppWThZdWtHK2JFdm1FSWJyc2srbFdLR3lhd05SNm9WMEFZcktSci9ZRzh1?=
 =?utf-8?B?QUlsOCtrbS9JMjY4aHM2RFFIa1hXdGcrZEl6cm1kWldzYmhEblRMTGIycXc1?=
 =?utf-8?B?VjFOOFJZSjZDaTVxNkFxbWRuTDVsSzFaWnBtMVBvZXNPc0ZKYm1mTlJNL3lt?=
 =?utf-8?B?RVhUbnQvbGFXWkZibkk1RnR4UllVR1pGV2hZZ0RjWmJITlRkSVd6eDViYWtT?=
 =?utf-8?B?N2syVEtGSUJlSENrLzNmR2t3YlpRK29OcmxjYUNsb3hyMEpCZG11aFlmN05Q?=
 =?utf-8?B?Z1hMODNTdFJaWmNsMFZqdHFwVFkyZ1RldTlzbzZBSHhNVE5KVlJqWVJEVVdX?=
 =?utf-8?B?WCtyY1poWlVwbVI5RWxqSkF3ZEVXcjZuUXY0RHRxQWJtQ01zSnZqZmU1QkVK?=
 =?utf-8?B?Q1lnVjZZZTVyYVNpaHVOcVJXTmZ1a0VXZlNvS0lpM212UkQvQ2EzTFpqWmYy?=
 =?utf-8?B?Nkkwb0o1Z0R5UGFxZU5hTDNCZ2RnMUFOK3IzbHBUNzQ0SndmWS9nN2ZRSmlW?=
 =?utf-8?B?a3EwTnFEVlIwQXVuL3JHYUtkQjlob3NURHpzalBkcHRlZWh2eXJCMWNRWmtt?=
 =?utf-8?B?Q0Vud1pJbXJ6d1pPZ2ZLV2xiUHF2ZHdsOUQ5TCttSzQrTlpOUnJvQld6Q0l3?=
 =?utf-8?B?YmhSbXdhWEs4ck4xY3RTREtScjdsSFhxQWQ1MitIMlFmMEZMY3dFbzBpZ2tj?=
 =?utf-8?B?QWg5MzBmZDU5NXNSRWFyWDRZV3duY2ptaXJzZitQSGdsVVRiMjVkZFF2NEI4?=
 =?utf-8?B?dkFqbXRIOFBCZHVaMUVCbk5ta2NFcCt3UjY3VGphSkpuZWk3bk5KS0YxR3po?=
 =?utf-8?B?alNBalQ5R1hDK0xJQ1hYQTFqdmNxbFJlQjJLaU1jRXpKMUlKd1FzUm1jRm9a?=
 =?utf-8?B?cUVacXJ6bjFUeUwwekFySHVjRE04bXFSQ3FlQXJ1cFdaY0NoSE5NSmsxYmhT?=
 =?utf-8?B?RXRHbWJKc0RJMXVuNnpKc0NZZ2haMmlZdUFoZ2IzTXY5N0oxUkVPR0Z1N0tF?=
 =?utf-8?B?L0RHZVVRT0R3TkdpaXQ0ZGNFZHBJS010KzFScGRLazF4amo3SS9kSjl1eUVs?=
 =?utf-8?B?eE1LbzU4YzRFNkJuQlBCRHBab2I4Sno5d3lnKy9hVndabG05YTNuWDZtWk1C?=
 =?utf-8?B?K3MyVUU0YVNtOHFFNmRDR0UwZ1NIRjBlK05SRE1OWWtMNEh0UjQybkpEZC9i?=
 =?utf-8?B?N0hieXhHdXgyU2JFdUNHYjNPdGlySDc3cDRJVTdxSXZaODNGYlUvWHhBN1gz?=
 =?utf-8?B?WTN6Vk1oYTBmRmU2K1Y4UThNaWdTSnprK1BlYXBIbHNWYURjQWQ4M1Axb2NN?=
 =?utf-8?B?TGRaRE5zUWVBZmg4QlVQN2FoczdlS0pGVDF2SDdDaWZDM1p4dXdsd1p6MXF3?=
 =?utf-8?B?TVdSL1VWeGozMWIzM2FXQW5VbzlpMzRlYmI1TTgyS0xYTXkxUW1zWkxhd0pO?=
 =?utf-8?B?RnowTVZ4M2kxdWhkVG0vYUdncllzSUZObnY1d0tuYktJSlJiVmJYVkhVdWZ2?=
 =?utf-8?B?VG9RdThLcW1TZjg5dFd1djRydllZaFlLRC9RYlYwY3RvaTZ2QnVoaVhXQnNM?=
 =?utf-8?B?cVlSUDlUTThZZ2RDazczUlZ5T1ZWVGFCV0FVU3lwVFZWUVZJaWNEL3JmVTE0?=
 =?utf-8?B?Q0xUYnlXN292WGtmR1ViYU1xVkF5SXpvYTBjZU9HSHVHV0RKWjd4TE93cy9t?=
 =?utf-8?B?UzRTdElHRW5hK1Zrc2pSWTFCVm9oTVU1MER0MUhmcDcxUmh6SUdWWk5raEhK?=
 =?utf-8?B?a1gxdmMvQmh3TkhFU1JTV3NxbFFCZmJYb2hQT20yRU8wd2J2alR6WUxIK2xu?=
 =?utf-8?B?eFVac2VNT2hPN1ZhVWcvL09aSkxuRHJOWHJwUmdoSWhPRTY4cGh3VjdaR29u?=
 =?utf-8?B?V0M0UEYzeHJrYmJIUGQ0K0xJSEg3ZnFyMmJkWlZTcUlxQVlmdzRNK2w2T3Ry?=
 =?utf-8?B?SmswQkpDRkVkWjJPTlhnMFJlZnZLdTZ0emNaNE5lVzg2a2J4c3U3TW93Z0Mv?=
 =?utf-8?B?WjdsUFdLZUJZNHBTdkViU2xhUmwvZGMvdDVGcGN3REx6MFBvdnhZU082VjdY?=
 =?utf-8?B?MVdOcXJoWklLU0Frdkp1b2tISEZNYmtPNFdCSmg5MnloWHhvTXQ4OW5LcktF?=
 =?utf-8?B?VlpBcmxxOFlrTUpTWjNBTm1mUzJ1VzNudm9XOUpOVFpzOTFYTkNwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6e479f-67d9-4b11-1d9d-08de6583a278
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:28:37.5556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrJ4mtR0xzUiRbSU+WP+jdHUbAQWDKogsWVhsehjFbKa3PZWmGLlZWNnVAh05img
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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



On 06-Feb-26 4:54 PM, Pratik Vishwakarma wrote:
> Use multi args for get_enabled_mask to fix is_dpm_running
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 35 +++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 2987ff1b13e4..f90d274c0f67 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -479,12 +479,43 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
> +					struct smu_feature_bits *feature_mask)
> +{
> +	uint32_t *feature_mask_high;
> +	uint32_t *feature_mask_low;
> +	int ret = 0;

This init may be dropped.

> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!feature_mask)
> +		return -EINVAL;
> +
> +	feature_mask_low = &((uint32_t *)feature_mask)[0];
> +	feature_mask_high = &((uint32_t *)feature_mask)[1];

This kind of usage is not expected. Use 
smu_feature_bits_from_arr32(feature_mask, args.out_args, 64);

Thanks,
Lijo

> +
> +	struct smu_msg_args args = {
> +		.msg = SMU_MSG_GetEnabledSmuFeatures,
> +		.num_args = 0,
> +		.num_out_args = 2,
> +	};
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	*feature_mask_low = args.out_args[0];
> +	*feature_mask_high = args.out_args[1];
> +
> +	return ret;
> +}
> +
>   static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
>   {
>   	int ret = 0;
>   	struct smu_feature_bits feature_enabled;
>   
> -	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
> +	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
>   
>   	if (ret)
>   		return false;
> @@ -1356,7 +1387,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
>   	.is_dpm_running = smu_v15_0_0_is_dpm_running,
>   	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
>   	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
> -	.get_enabled_mask = smu_cmn_get_enabled_mask,
> +	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_driver_table_location = smu_v15_0_set_driver_table_location,
>   	.gfx_off_control = smu_v15_0_gfx_off_control,

