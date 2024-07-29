Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBEFC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 08:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60AB10E31C;
	Mon, 29 Jul 2024 08:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sY10BD+7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A85F10E31C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 08:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoUxSfPKUu33zC40Vi0nKQH3a8OtISg7C/lx7wSOLEt2JXNE0JuyqhgAjuHnBMiDNRuWHG/5J8MV8NdmT5DPCM8olZ2QopKOFHNXmsl7uiPwvK5rGU4XUBdewLRFk748ejcaxlg8Rkmse/asoJdHfV7UZS+7x1Pmp50+DZh/TEYlUq/LPQyOPKLbS+y78TAtk/7Lg7MWUc7Or7tTx/Ox9KlpSaKg5r0QBUrxa4i8jv6SoE7X9HtGQRDPYtOCNeWVzuVV0UIn1hSA902X6it6Tyy7WjmnE1+bs6Wc+Dgb822dOsC5bHJJ/2HPu5WfH1di93WXBMTZdGSY7BjMxdW5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvRhbbk7LcuotjrMHj56nguhAqmpExml1nVUfvDi7Yg=;
 b=AEf0ZLKp3uMdTiL8nwuu5IqIvl8GeZZwG7o/JJrf8X7a3TCO5pnQPgPL2SXJTx30vuQPiAUCMmDXW4Wo3uJoxptPa8l0Sw/kjC9vfBg6dLzF0xxX7Dm+wbhHJfj8NopRDmDuQs4VA/rhKT3CDHjCLD29nlO6AYp47CHupwQZK+Jc9xqUG6GKqaSMaR/6J1YoXg5s4kVOPN1Ruwc8cqdLFLOKvKIgIANQdOkQb31od+Pa9NEYpZqDrrkZWojSckkQzbWe1jPtq6dopG7XKe5qIipa5xeX23QKWDODaIyyE7lj7nX5PExMiyAXbKyPdbSeDfxN195hUJvMTBpRpvKFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvRhbbk7LcuotjrMHj56nguhAqmpExml1nVUfvDi7Yg=;
 b=sY10BD+7UBXqzLPXDV9xUKjuH1hZBxCaFsAuln4C9lY+MwPqRJnJBAUwm6aceY4dvw1LheWfFmG/AzRiz/w62kthzOvqz5P1FO24cTMRG1GUbcH8wfSfRBl7GHOI6yc3+HHSwlclkExg/QE369csygmBsgmLU9WJkcfUEXhd4iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Mon, 29 Jul
 2024 08:27:47 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 08:27:47 +0000
Message-ID: <ac2c4a67-85f3-4cf2-95a6-78c59220ee5e@amd.com>
Date: Mon, 29 Jul 2024 13:57:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
 <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
 <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
 <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
 <a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com>
 <16cfb6c9-c2de-4d19-909e-f06df27c78a6@amd.com>
 <5ead684a-e70d-4388-ac45-c59995eb8161@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <5ead684a-e70d-4388-ac45-c59995eb8161@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc85e1f-0df5-43b7-4d4f-08dcafa853b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZzbUpFamZIakpoUFhlL3N4N2Urd0YzMFhBSDVjdDBIdzZjeWg4RnlHdWs4?=
 =?utf-8?B?anRNbStCbkJGdHh0VFVWcDM2Yk9POS9rdHQreEE0NGtTbkdpa3NibVFlTUhi?=
 =?utf-8?B?NSt4U1dCcnlyNGk1aXhPalB0VXlSZEYvT2V1dDJlNGh0Ynl4ZUFVZDB5U2JR?=
 =?utf-8?B?RmJ3dmEzRUhXYWlCS29xRjNlVmllaTJxdDFJbjIxSFJJTWc4Yjc5NkNtLzBk?=
 =?utf-8?B?WVU0QjVrSzZjcFljS1d3NDA4amlaVjUvRGJacWg3ZXdYVm41Nk1mOFJyOGU5?=
 =?utf-8?B?VjhNUFNob2E3dlhaL2F2UTQvWjJXN01LL3V6YjJKelRReUtVUFdzTllSdUQ5?=
 =?utf-8?B?VllibG5qMkFnc1Q3aG5JWjFZYmV0dE5qZW1wanNzcFdkVjZGYnh4UkhoNzF6?=
 =?utf-8?B?Q0FzcnlUUXdVWS9GRUFCMEZJN2ZRcWdVb3F1SEtkN296Z1VLc2RraWhGalQ1?=
 =?utf-8?B?aWFsYmxCSGFHSUFoQmtLVnZJUDhuVGpXZUpONTkvU3F2a1V2NUtXY201Z0hM?=
 =?utf-8?B?dStZdG9wMk8zcEVVTFc3RTcrckNwc2NOOFZwU0s4RDhqZnF6YTROUGx1V2Vp?=
 =?utf-8?B?eUczMW9YVkpGcGttRHA3N2ZydjNCTFVsVkxvOG5UcXJPTWVrTlVIclJ5dDdt?=
 =?utf-8?B?ZU9jV1BYUDJydTlmaGREbDVUdlBsRm4waGdmK3VCWFc4SDlHa1pLL1ZDcjZ2?=
 =?utf-8?B?ZDVZOVNDUnBrOERqdURTczlLR0RudEFHM3o1czdSMGF3WGV1YlFJV1phcE55?=
 =?utf-8?B?T0RnQWtTQmdlQVBLbmQzWG1XN3VwRlhJODl4UG5VSjhReGoxcTB4VDZOVDM4?=
 =?utf-8?B?aXNaclc1NW9weU94NjRtTFU2STFoSVUrWTcwSmxuUjY2Q1paMmdpVGJKdVBT?=
 =?utf-8?B?UlNMZDRZYlRJZU85SjRVbGN3NlhrT3hnM2pEWXBJVE10TC9uRy8vZ3dUbzBI?=
 =?utf-8?B?WFNOdkc3QXlnSUN1dXBkd2ZVOFhNdVU2RTEzZ0ZBd2VIL0cxTlNXME56cXov?=
 =?utf-8?B?eklVbVlnK1VMOEJBRmtRNU85V3ZKL00xaFFTUWZKS1JWSGwvYjF0eWJWOXhZ?=
 =?utf-8?B?ckV4STlIdm9Cdm5OQTcvVDNZd2tpYlJ0bWV3QkREQnNheHNpRlY0S2I2NEtM?=
 =?utf-8?B?eTZPZ3FzMXRSYUJHKzdvRWhEQWU2MFU5MmRMdFVvYWJ6OUJLT21JK0o1TCt2?=
 =?utf-8?B?S0xUNFZGNzU5WkV3MUlzNHo2SC9xSkNXQllYTE5PR3BYRDR5N0ZVbktaQlN4?=
 =?utf-8?B?SzhzeE9iMG80ZGNwK1pGUkp0RjRMOW9jNjJHL2pHMGdkWGFwNElWeGVmam9n?=
 =?utf-8?B?YnI3dlNKS2dCVGtDUTc0QjFKanFCWDVYSE1CRzIrYmV5RXVOd096VUYvU1Iv?=
 =?utf-8?B?K1B6RUZ3TENmMHc3QTFPNW9XRndwVU9qYzRhdGc3dk9RRlp0a3prbExYSmFH?=
 =?utf-8?B?cCthUmE5WlMxQVVKWUxNeGxKS25ScWx1R0I0UVhWcERzNlFMRUwrRFcrc21w?=
 =?utf-8?B?RERXQXlNL00wS28wamZVZG4xM0V0ZklrWk04dUk4d2ZtcU94RGhsTXhWbm54?=
 =?utf-8?B?N3padU9JcnAweWhXWm1PVkZoQ1BEMGVTbDNaMEMrTThXd1dKTmZBQi9kTml3?=
 =?utf-8?B?RGZBTjNocmVkVGlRSCsvZFNJOUhqRGpyZittdTJDQSszUDBmMzFDbmJuVXZm?=
 =?utf-8?B?cHk3WE5tRTB2T2FPS2NEY1ZFcDhDdHRneE5wWEJ5Z0pkZG5TMnNJWCtncTh4?=
 =?utf-8?B?NjlLbGFrbmR1bEhjS3VvSXIybWplSko0bWt2dE5Vd1l6UnVza3Znc3RSQUxQ?=
 =?utf-8?B?bHUxRmd0OU12ZEZlcVZOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZuUTUzRjc5TlhmS201Z3FJWG1GQVdSdlhWZUplakxiTUZaNlQxclNUWlFL?=
 =?utf-8?B?ZGxtVytidy9KZHZuQURXT2s3MmpEdTBGYjJtNldzb090OHVnbUtFRUFJVWdi?=
 =?utf-8?B?a0NmQlI0ck14RXZqeTJPQnZaZmVjZVB5M0dDK0FGc3M2TURxeVZZaFBTTTIy?=
 =?utf-8?B?VHFMMDV0ZzhoTmQ0WGdnTjJyZU9rczlIVk5EVmxNTGRYRmlUVnZ6aUIxbVlF?=
 =?utf-8?B?dnpDdnFjUjNIRkJTQ1VqMHRVVkVTVDk0NkVPZDIyRm1US1BYdTVKa244MW5p?=
 =?utf-8?B?eFJ2YWsvK0hxRk91NGoyUmN4bWkxR2xZWjlQUVRjaXA0c0REYUgzL1VhZmVy?=
 =?utf-8?B?L05LSVlIOUFIMDkzbSszVndITFFra0dEeGxxTjJEL29hT0l5NnphRCtSc1Va?=
 =?utf-8?B?L01OaHpkSWw0QWhmVjQxWkhRY3VibUJ6VWlpenRXYUhCYlF1RTc4STlvbmNF?=
 =?utf-8?B?YXR5N25nbDlpeG1Ta0dqdVNSUlNlUnBZODdKNk9mbVNJaGxNZzN2L1NjcEVu?=
 =?utf-8?B?RktIc2Jzb2VwU0FYeXhmbHBGUjlPOU1Jc2JrZVhQZXZ4Uko0Qk1Tcm4vOTIy?=
 =?utf-8?B?YVNxODdXbnZNYUppYmU3VUtLN1F3ejlCR3pYVWtVMnJxbi94NTdZU0JBbjdF?=
 =?utf-8?B?RnllaVJ0dDhXd1hCUWJiTCtrcnJPRUtRT3prU0o4QkI2YU1FTHc1dU4weHBW?=
 =?utf-8?B?NVpJSFNSc1lBc1VYNUFRUkNXMkZkMGZ3WXlWdDhrL29LNVZQWE8xVDlabFJE?=
 =?utf-8?B?ZjQ2Rkp6d0lsWU1DUEhEVWZzNkhKSTVyeklqRDVWcWR5aStiWmVyWVZKYlZP?=
 =?utf-8?B?RUM0MWtYNVpHKzBQR3hwd1I4L0x4YmtCVXRNZVhmMjJ6OXRsemQvaXpDOWF0?=
 =?utf-8?B?WGFYRy96Zm1QTG8wc0o0UE1CVHNOQUcvcnh4alJlMWZQTjRkYlNia3VzRGtC?=
 =?utf-8?B?eS80VVlqRkc5Q2VkZFByM1BHTWh0ZDNlc1F6ZENwUUh2UmtheU82UEdlRDlw?=
 =?utf-8?B?dVVSYzh4MlE1OHVIMDU1ZldjTUY4b2lSSGViM3pRN0xmaWMrQlFhcW1IdEV1?=
 =?utf-8?B?RFVTVmpBeEZRbjVFdGJpZUxvZjVsOUpsSUNPV0pNMkRMc1JNTFNteWJyQkQ0?=
 =?utf-8?B?dEs5Y0tXQm9TU2ZQbHpHMEprZjhaQzUyTGpwZFk1dTZnVmZkbExobXdGOHd4?=
 =?utf-8?B?NUpxV01OU2F1amNHMkoyL0sydUo0WGw1TnU1RWYxdUgxVDZjSDBId1JVQkhP?=
 =?utf-8?B?ZlZ4dHFLQ0JjbUYwQzBnTmxRY25Hd1dQOGorb2c1M2pxcnRzY2sxbFdzRjZH?=
 =?utf-8?B?b0Mxcjk4VHhnUmU3U29oSFhUeTZJOVF2NDRzWnd5QlhEVkVDb0VudGliTFAw?=
 =?utf-8?B?V3VCTGZablJhQjBkQjVXRkRuWnUrbHdxZmNsek5QSUJCb1BNay9aZ3ZXSm5C?=
 =?utf-8?B?NXpBSHRodHRqWlhJTFEyNzJOMjkzNTBaYjVGM2ZOR3FQRmozQnZHd2QzVHpT?=
 =?utf-8?B?NlgvUUM2YXFYOTd0TlVFK0FDdEtMOGRwYklhR2R5VzduTmR6OEg1NGJoZjZD?=
 =?utf-8?B?S0RkRzYrRzhvUjdvVjdaUjNvbkg5R2JJTXZ1aEkrWFZjNTV2Y2YvMm1BbzlU?=
 =?utf-8?B?UjhFWC9zWUpUVW9CczMrNmU3ajFsbzNtbkpwd01MeXYvc1VjYzhjR2hFUEow?=
 =?utf-8?B?U1hEeVlEejlKMlprZUVMRTJPb3VEWXN0QjZTNmlMd3RhazZVWkp3M08wc3Fr?=
 =?utf-8?B?UEdHNll4VmVHcHkzUFJVRzlCZFQ4MHZ6ZHJlcy9WNFkwREZFQnZBOXBFS3FJ?=
 =?utf-8?B?UmxlTlEyb0JzOHdVbjFyQllWWXM3S1FwemR6Szl6cFdhbmJUWmRtTXpuYUlQ?=
 =?utf-8?B?dGltNVZMVVZXMUt3T0FJYnh0dUh4L1p5eDh4NzNJbEo3NkhuL1RscDU1OFRX?=
 =?utf-8?B?NmdRZVhQcXhGZ0JWdDVReVVmSXdubWxsb29tVHRmcTJNc1phTm93eERTemw0?=
 =?utf-8?B?Tmozb3ByUFdqQi9aR1FCZjBUTlc3K2t5c2w3enBIMVluZ1pnNlJUYWVKbUtV?=
 =?utf-8?B?dTJHNFZOY2ZFVVdZd3U0QmpXM1Bmd2QrdTYrMjArWENHdXJsa2VKRHcxcmNo?=
 =?utf-8?Q?9kWBmm2uUdrn8yP2ivpPOPkdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc85e1f-0df5-43b7-4d4f-08dcafa853b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 08:27:47.6833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fBmgClyTTCrMl1hK+dkHSxWuXBOf14Ja9D6q0lY/S2pn27FoN/OMq3ETcABTGXsI9Kyf3PI2t1pD8GpYeFLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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


On 7/29/2024 11:17 AM, Lazar, Lijo wrote:
>
> On 7/29/2024 11:08 AM, Khatri, Sunil wrote:
>> On 7/29/2024 10:08 AM, Lazar, Lijo wrote:
>>> On 7/27/2024 12:51 AM, Khatri, Sunil wrote:
>>>> On 7/27/2024 12:13 AM, Alex Deucher wrote:
>>>>> On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>>>>> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>>>>>>> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>>>>>>>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>>>>>>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>>>>>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>>>>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>> Problem:
>>>>>>>>>>>> IP dump right now is done post suspend of
>>>>>>>>>>>> all IP's which for some IP's could change power
>>>>>>>>>>>> state and software state too which we do not want
>>>>>>>>>>>> to reflect in the dump as it might not be same at
>>>>>>>>>>>> the time of hang.
>>>>>>>>>>>>
>>>>>>>>>>>> Solution:
>>>>>>>>>>>> IP should be dumped as close to the HW state when
>>>>>>>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>>>>>>>> any resource.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>>>>>>>> +++++++++++-----------
>>>>>>>>>>>>      1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>             return ret;
>>>>>>>>>>>>      }
>>>>>>>>>>>>
>>>>>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +       int i;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>>>> +
>>>>>>>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>>>> +
>>>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>>>>>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>>>>>>>> individual IP call backs, they could just do the same or better
>>>>>>>>>> to move
>>>>>>>>>> these up before a dump.
>>>>>>>>> Suspend also put the status.hw = false and each IP in their
>>>>>>>>> respective
>>>>>>>>> suspend state which i feel does change the state of the HW.
>>>>>>>>> To get the correct snapshot of the GPU register we should not be
>>>>>>>>> fiddling with the HW IP at least till we capture the dump and that is
>>>>>>>>> the intention behind the change.
>>>>>>>>>
>>>>>>>>> Do you think there is a problem in this approach?
>>>>>>>>>>             amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>>>>             amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>>>> Adding this does sounds better to enable just before we dump the
>>>>>>>>> registers but i am not very sure if ungating would be clean here or
>>>>>>>>> not. i Could try quickly adding these two calls just before dump.
>>>>>>>>>
>>>>>>>>> All i am worried if it does change some register reflecting the
>>>>>>>>> original state of registers at dump.
>>>>>>>>>
>>>>>>> I was thinking that if it includes some GFX regs and the hang happened
>>>>>>> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>>>>>> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
>>>>>> those IP's
>>>>>> I am not worried and also based on my testing on NAVI22 for GPU hang
>>>>>> their registers
>>>>>> seems to be read cleanly.
>>>>>> Another point that i was thinking is after a GPU hang no where till the
>>>>>> point of dump
>>>>>> any registers are touched and that is what we need considering we are
>>>>>> able to read the registers.
>>>>>>
>>>>>> For VCN there is dynamic gating which is controlled by the FW if i am
>>>>>> not wrong which makes the VCN
>>>>>> off and registers cant be read. Only in case of VCN hang i am assuming
>>>>>> due to a Job pending VCN should be in power ON
>>>>>> state and out intent of reading the registers should work fine. Sadly i
>>>>>> am unable to validate it as there arent any test readily
>>>>>> available to hang VCN.
>>>>> We want to take the register dump as early as possible in the reset
>>>>> sequence, ideally before any of the hw gets touched as part of the
>>>>> reset sequence.  Otherwise, the dump is not going to be useful.
>>>>>
>>>>> Alex
>>>> Sure Alex. I am also of the same view that we dont want to change any
>>>> power status of any IP as it could change the values.
>>> There is a debugfs interface 'amdgpu_reset_dump_register_list_write' tp
>>> add registers to reset_info.reset_dump_reg_list. Presently there is no
>>> check about which registers are added to that list. For ex: if user has
>>> added some GFX related registers, this is going to hang while in GFXOFF
>>> as ip dump state comes later.
>>>
>> this isnt being used and i will clean it up. its original intent was to
>> for dump only which we based on all conditions are taking care. So this
>> needs clean up and i will check on it.
>>
> Right, that's why I asked before whether this generic dump is really
> required - "since there is already dump_ip state which could capture IP
> regs separately and handle their power/clock gate situations, do you
> think this generic one is still needed?"
Sorry i could not understand that you were talking about debugfs reg 
dump first.
i got it and i will clean that up. With that in mind we will not be 
needing to ungate
or change the state of IP but just before we dump we would use the ip 
specific power
calls based on need and hence generic ones are not needed.
>
>>> Also, all IPs don't handle dynamic wakeup; therefore, regardless of a
>>> reset scenario, direct access to powergated IPs could result in a hang
>>> and that will make things worse.
Noted.
>> Before dumping any IP we are taking care of Power status of the IP so we
>> should be fine. Like for GFX, SDMA we make sure GFXOFF is disabled. VCN
>> we are dumping only if its power is shown as ON and like wise it will be
>> done for other IPs too.
>>
> Yes, it's better to handle at IP level itself and remove the generic
> interface. If the IP that is hung is known, it's likely that there is no
> need to power ungate as the IP could be in some sort of busy state.
> Also, there may not be any response to further operations from that IP.
Got it.
>
> Thanks,
> Lijo
>
>> Regards
>>
>> Sunil Khatri
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards
>>>> Sunil Khatri
>>>>
>>>>>>> BTW, since there is already dump_ip state which could capture IP regs
>>>>>>> separately and handle their power/clock gate situations, do you think
>>>>>>> this generic one is still needed?
>>>>>>>
>>>>>>> For whatever we have implemented till now seems to work fine in case
>>>>>>> of GPU hang withotu fidling the
>>>>>>> power state explicitly. But Calling suspend of each IP surely seems
>>>>>>> to change some state in IPs and SW state too.
>>>>>>> So i think until we experience a real problem we should go without
>>>>>>> the generic UNGATE call for all IP's
>>>>>>>
>>>>>>> But i am not an expert of power, so whatever you suggest would make
>>>>>>> more sense for the driver.
>>>>>> Regards
>>>>>> Sunil Khatri
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>> What u suggest ?
>>>>>>>>> Regards
>>>>>>>>> Sunil
>>>>>>>> I quickly validated on Navi22 by adding below call just before we dump
>>>>>>>> registers
>>>>>>>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>>>>
>>>>>>>>        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>>        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>>>
>>>>>>>>        amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>        dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>>        /* Trigger ip dump before we reset the asic */
>>>>>>>>        for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>>>>>>>            if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>                tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>>                                        (void*)tmp_adev);
>>>>>>>>        dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>>>>>>> }
>>>>>>>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>>>>>>>> Thanks,
>>>>>>>>>> Lijo
>>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +
>>>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>>>> +
>>>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>>>> +       }
>>>>>>>>>>>> +
>>>>>>>>>>>> +       return 0;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>      int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>>>>>>>                                      struct amdgpu_reset_context
>>>>>>>>>>>> *reset_context)
>>>>>>>>>>>>      {
>>>>>>>>>>>>             int i, r = 0;
>>>>>>>>>>>>             struct amdgpu_job *job = NULL;
>>>>>>>>>>>> +       struct amdgpu_device *tmp_adev =
>>>>>>>>>>>> reset_context->reset_req_dev;
>>>>>>>>>>>>             bool need_full_reset =
>>>>>>>>>>>>                     test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>>>>>>>> &reset_context->flags);
>>>>>>>>>>>>
>>>>>>>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>                             }
>>>>>>>>>>>>                     }
>>>>>>>>>>>>
>>>>>>>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>>>> +
>>>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP
>>>>>>>>>>>> State\n");
>>>>>>>>>>>> +                       /* Trigger ip dump before we reset the
>>>>>>>>>>>> asic */
>>>>>>>>>>>> +                       for (i = 0; i <
>>>>>>>>>>>> tmp_adev->num_ip_blocks; i++)
>>>>>>>>>>>> +                               if
>>>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>>>> +
>>>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>>>>>> +                                                       (void
>>>>>>>>>>>> *)tmp_adev);
>>>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>>>> Completed\n");
>>>>>>>>>>>> +               }
>>>>>>>>>>>> +
>>>>>>>>>>>>                     if (need_full_reset)
>>>>>>>>>>>>                             r = amdgpu_device_ip_suspend(adev);
>>>>>>>>>>>>                     if (need_full_reset)
>>>>>>>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>             return r;
>>>>>>>>>>>>      }
>>>>>>>>>>>>
>>>>>>>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>>>> -{
>>>>>>>>>>>> -       int i;
>>>>>>>>>>>> -
>>>>>>>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>>>> -
>>>>>>>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>>>> -
>>>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>>>>> -
>>>>>>>>>>>> -
>>>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>>>> -
>>>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>>>> -       }
>>>>>>>>>>>> -
>>>>>>>>>>>> -       return 0;
>>>>>>>>>>>> -}
>>>>>>>>>>>> -
>>>>>>>>>>>>      int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>>>>>                              struct amdgpu_reset_context
>>>>>>>>>>>> *reset_context)
>>>>>>>>>>>>      {
>>>>>>>>>>>>             struct amdgpu_device *tmp_adev = NULL;
>>>>>>>>>>>>             bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>>>>>>>             int r = 0;
>>>>>>>>>>>> -       uint32_t i;
>>>>>>>>>>>>
>>>>>>>>>>>>             /* Try reset handler method first */
>>>>>>>>>>>>             tmp_adev = list_first_entry(device_list_handle, struct
>>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>>                                         reset_list);
>>>>>>>>>>>>
>>>>>>>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>>>> -
>>>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>>>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>>>>>> -                       if
>>>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>>>> -
>>>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs
>>>>>>>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>>>> Completed\n");
>>>>>>>>>>>> -       }
>>>>>>>>>>>> -
>>>>>>>>>>>>             reset_context->reset_device_list = device_list_handle;
>>>>>>>>>>>>             r = amdgpu_reset_perform_reset(tmp_adev,
>>>>>>>>>>>> reset_context);
>>>>>>>>>>>>             /* If reset handler not implemented, continue;
>>>>>>>>>>>> otherwise
>>>>>>>>>>>> return */
>>>>>>>>>>>> -- 
>>>>>>>>>>>> 2.34.1
>>>>>>>>>>>>
