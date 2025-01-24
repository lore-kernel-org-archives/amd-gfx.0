Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D40C0218C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 17:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440E910E129;
	Fri, 24 Jan 2025 17:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFfDcaeY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBD010E129
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 17:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRQ56WJaQ7bJgwDRGxM3JpUyMcqeo6WnBSdQKptySKqQ+OY3pT1r0nHReUvuBE3Z8GMB5Ek8qRzlLXGiONm+dsPuAh4F8/KOY2xJt9FxlFuFwL+a5mHO+T5wNYEs4kgru8LvN418XIYp8H8tBL413nRuVPHF3E4XYlFf4c7Vyj6UjHNTnb6Oka7dS3gvwPoe0YGqubOCqQbFDq/fsn8q/supybXrPK20bfHsJfRSWGUzLdiyLaqOLjes5uHXuQpJfuPbwTWLUqs/bGjpouvnB5y7eBV06PgdLL06fCWu4XQCAjslCCQaHEwqyrw3V4VHg5C5e6KszZOKQVYw0xKlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxb+vwwtFWXbOx9jxq7wwqjK+qegaNhixH+CparF+2Q=;
 b=n4LoHGRUeHLADTAIetjmmf095ofYVV8HnxPy8SgsS2chbClvzlDwTh0QQyJfyFuaaK8wuU15XGJKvE4D9LLdDMZMHyjY//EM/cZWhIWqNAt3hv7p6c8XL7UCxzMVTSagJvctFqyxeJWSgFOWoRGg4mkI36x+g3fr3OdDe97001cvr5vQ+7RPjt5sR2ZVB5YwyedQ+rCqvRb+E5kuVS9nLZhI9xSRkOGTtDP5SN5rlILCzjNcjReHRxWAcSoRf+hrBbxJtf4EHT3okAdJ0JxeSYlTzosm2wFJdaIwwrFrcpELCiWrcRZp/njfojuUODGUYO/uRNuWpb9zkksMUBOr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxb+vwwtFWXbOx9jxq7wwqjK+qegaNhixH+CparF+2Q=;
 b=lFfDcaeYkGGcILEOr2zyaB81sHoIHLg2zYX2OibeKU/oEreJKa1IxfMnoetgygBBO1PEhOQWKvO6ad+pCLlmbbxZReJ5emIlLGaStQPGSKmw6zADQtMjcHw5tI0GQwC+JBoLq/4wamSqJijCXHTm10LjbGtL4tI/SEvGL2J5z4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Fri, 24 Jan 2025 17:30:12 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 17:30:12 +0000
Content-Type: multipart/alternative;
 boundary="------------houN32WI2lmrLPDjJYJWBjSk"
Message-ID: <91fb8f7c-f252-40fa-85ca-e77c04a6fd31@amd.com>
Date: Fri, 24 Jan 2025 23:00:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
 <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c77d4f1-74cd-41a6-ab33-08dd3c9cc1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1Y2bG9RZllIZkI3QjAycUsya01QTmU4Ymt4M3RmY2IvY2hSRTJZNHpsWC9J?=
 =?utf-8?B?NHlRSzVrQWMxWXN6b2JvS0lJSFFoZHhQUTRUbnU4R2RMVGNuT3JaTDVaYXFa?=
 =?utf-8?B?NzNOaVdYYlZYNmI1eGt1NStVbmozR0Q5eTFsWHdKcUxZaEVSNnVIY3NDY0Vq?=
 =?utf-8?B?N01GM0NpN0pRbmhGTzJyei9JRmJhQUVnTEQ1QU53SnoyMmxvSnlTZmN1VnN0?=
 =?utf-8?B?VzVkWVNvWE9ocHAxUWtiRHg1bGFnZ3R0dWh2TTVTN3FxVEpNaHZQWi80Y1N2?=
 =?utf-8?B?NnF1NnluQjFqNHpxQ1c1VEluWmZ5b0gzMzBQYVdBV1k1Rno2Q2FhQnliNWVU?=
 =?utf-8?B?NHFXT3h4Mm9ZM0NUK1psT2Y5R1J6dVRqZ3RiZFFua2l5azJnRTVLd3NuckZE?=
 =?utf-8?B?b3BlWCtKOExQa2laaVBBYXhXT08reWpGTGMwSEZFRkxXUzY3QVAwUnkraDc0?=
 =?utf-8?B?bEl5RW50SDY2UDJ4N0lidjBUZUttMm9uYTUxOXozVkMyVUROS0tTVDN1TlBH?=
 =?utf-8?B?c2dDQlptemNaYk42V2pLYjVPdzNHTUtvY1lkSVYxcjJXck5xL045QzlFSVA0?=
 =?utf-8?B?R3NDckFtYTh5Z2VJdHlvNThtQVgxYk5mK1BKMngyNlhVckh0b1pIdnNIa2tG?=
 =?utf-8?B?Q0tUd0ttVGdjWXF1eG4yNWQ5QlZWb3ZibG5DTmRNbnIrNk12N0ZRVkZKaXFG?=
 =?utf-8?B?OWNFRG1mamtMSDBzRVhzYmdudm9GZ0NVUnRJdnNEdlJBaTVVZy9KWlY1Q084?=
 =?utf-8?B?Z3NrZXBPNFZlNmcwMjliZFRwMUVEOHVDSzRQb1F2T3RINWV0RmxOY0hFbHU3?=
 =?utf-8?B?eUkrRmtoT0xadVRtd09QdDdZdHZLbWJvMmpmdFgzU24wTlgzaTVZMzNsMkdk?=
 =?utf-8?B?ekVwYnppeE5xd3JzVEhuYnp0czNXMndSczBKczFwN3NYRjNFUHc0TlNmazNV?=
 =?utf-8?B?WVVrb2xGSHhYVWFQRjJDNW1JcUhia2EwaWloRHlzbFNScnlYczM5UTl5V21J?=
 =?utf-8?B?WnBJZ1ZMWmxVQ3FDYWVHdDBMYk53TDNsbkpoNC91ci90V09jaTNzbHl3OFQw?=
 =?utf-8?B?TlN6dmNWTDhBeEgvaXBHQkdGckRLVGJVNHFDZjlBcWRFTFFsT0Y4THVPNG5K?=
 =?utf-8?B?R05ad1Q0NEo0UGVZcnNacWM3RlNlTnY5TTJ1VEFVYnhPS0E2ZWwwMnJjNjls?=
 =?utf-8?B?NTVXVGJvUTBSSnpkOVNTdW5CWWdEYmxOTms0NDgvK1JOczREbHRqS3pLV0d3?=
 =?utf-8?B?RDM1SGRpV3E5NnlaQmR4TkNDWTBqMkhRdmQyT3h0RzYreVBYemFBcFFsNnAv?=
 =?utf-8?B?cXBOZ0o0MnZBZ3hFVW1lYlJxV3cwczZQTmtXUzNEaUZKSUgwWUg1RmlrRlBz?=
 =?utf-8?B?TEpSbmxQVnVLOGwzZVZ0WUVWS1NRTjl0c25kckQxQ1RtWWFxbXNHZTNWbEJI?=
 =?utf-8?B?RUJPT0RUZGtRa01VYVAzVlhNbUN3aDEzYkZJbStCUnlWS3FUcXJZZjlDcytD?=
 =?utf-8?B?aFdEZ29sYXlPK3IzeHFEbE5RZzZzWGxiNTRpL1lpRzRBbnhBMnRjTXhrcHd4?=
 =?utf-8?B?bGJVSlp3ZGx6UG8wYmFXdnNMYjdtWTA2UXhTM1pjVEhwWE9EQ2hOanpRYngy?=
 =?utf-8?B?KzNyQnFBMXhYUHB2dUMzRldWVk0yblAvaTh0ZHliYlFKYlV1WUhqNWpIYUg4?=
 =?utf-8?B?aHQxUE92SG1UeFRnOGVGRUh6WE5GME5VdGt2REF6dzVZTG9RTGpoSVpUL2xK?=
 =?utf-8?B?WHJoeVh4aVhyRU5ON1RtK1RSQ2tGQzMyZS9DdmV5dDkySUN2ZGYxbHFxRkNL?=
 =?utf-8?B?VFpzOCsvQXJ2NWc5UWJpOUwvMmFCYkhHTTBkbXZMU01GeVJ3NWhDQlAyc1M1?=
 =?utf-8?Q?fzZ+B5Lg27HV4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVQrbjIrQWh0L0FpMldJdjh0SnJpcVNlQkxNNnJ4MXlobHBza3BiQWhiYVBK?=
 =?utf-8?B?aUVGWGhJbkFYUFMzeVp6OWluZDB5SjVtMEtBQ1JaMkxaRjNiS0RnNWdMdEp1?=
 =?utf-8?B?Z2QyOVN2YnFRNDdveEZROHl6dnd1aHdyWkgrVTg3cS8zZ0lBVXdvUlBpNEly?=
 =?utf-8?B?Ky9nQURNMElmWkZXTzhwVGtQS21MVUt1RjNJSzVUeDZkM1dqQ3ZjeXVTUG5T?=
 =?utf-8?B?eDl6UytvSGRqRkZsQXVkQmRvTmp3Q3FXRWFLakgwbStHVjdLNWFhenZ3Wnhs?=
 =?utf-8?B?UGVocUlSWnRkcFAxWHlZMENLc3ptdXhkM04vVTZZc000a2NtK0w2M09XeXVp?=
 =?utf-8?B?amtwM3BGcUZYWkhtc1E1a1VTdWZveVFTWUZBTmNFcFpCZ1VRazhWYVoxbWhw?=
 =?utf-8?B?RmUrM083REMveWYwYkVMQyswQ3VWbWtrRkhKTUFJQ3M1T2huZHV2YnpqaVBk?=
 =?utf-8?B?Zm9pajRucnRtZ2czSDdERDZ6YjFLS2ZmUzNnb0hNWG53dTFNd21hTEk2YzZt?=
 =?utf-8?B?V1JDL2JhYWhSTnJTSkVzRU5lYUdsWmovZ1NaNW9xaFphcDFXYWg5dnExMXc5?=
 =?utf-8?B?Qm95QmpiTkhGNS9BZjJ5MmNvUng1d0R5a0t0L0ZDTWRURy9KTFJIN0tNNmZj?=
 =?utf-8?B?QmsyZXVOWWFKdGpEb2NLTlYrVlBES2c2czdJdThpMVJMa1Q2QlhBZzFHRjBG?=
 =?utf-8?B?UG5nVmdJNmhqV3VBZDVYK3lZeTN3dUk3NUxncXl6ejBWV2pPbitSQjBVSWFj?=
 =?utf-8?B?MUxvS3h2aUNLSWRzV3JLdWN5UklZUitHRk1mbVNsQTJ5NlR2Q2F4Y2IweDEz?=
 =?utf-8?B?TVZpQ1dISjV1a1R3bGk1YzA1dXVHNHNoWk9CMWlWU25HaU9HZHY3S2dqSXow?=
 =?utf-8?B?cmhuK1NBZFFxTllHZm9mWDdiZkdnZkNFQS9kYUd4Q3FPNzNIWTlPNWtnRUxX?=
 =?utf-8?B?NGJpbUlPbFpwWGVhdG40cGJwODArQUhYaHJLeU9PRTJRV0UxRXJXTEw5YXUy?=
 =?utf-8?B?b3JTTlF3dmc2QTlYbW0yejVPK3F2dUJheEFwT0pkOW1OVHEvQmhkeDRQMHF6?=
 =?utf-8?B?Ukp6TmZwckdhRW5BQVdOVTIrbDRLSEh2cW85b056WkRMVnMzZXQ2ZzRNTFBX?=
 =?utf-8?B?d2x4cG5YNDJHZzVhd21oZU5PRTErbXYxM3cyV216dmFDdTBCWlVoZTZRSEha?=
 =?utf-8?B?VFpqVDZaNEwreW5FQ2gwK1dtNmYrUjlQRCtSdTBIZWtMM0lOTTIvOFg2R3F0?=
 =?utf-8?B?dFJBRTBadlVqcks3UFRwOGJORUExRnRQRk1YODhkZ1JIZ3pRYU43WUhTWGtR?=
 =?utf-8?B?VFJlckxwMzVSK0JwTDl2a0pCTlVzL1RXSU9Ra1FTYnJJd28zYTM5ckt1WjRx?=
 =?utf-8?B?ZnBRK20vK3BNVEZtbkJveG5rejNUbVpwMGZWcjJYRXM1eFVMZTlXNzZiSFRv?=
 =?utf-8?B?VE5qS1paeFpGdHppL3FCVHdKWjkxNEFBb0dBejB6M1JKRWE4R0JJTTNwNWlk?=
 =?utf-8?B?N25PSkxsRzIvMG5xeGoyRkRiVTJVTk1peitTek9IS01GcDI5dS8xT2dmNWZk?=
 =?utf-8?B?M3dFMjhqTXpKMXRwUWxVME9iYVlvdlBlQlExOU5XVkZyTXNqUlg0TXkvU2xm?=
 =?utf-8?B?clRJL2s5VkdtcjFkY0hJb0dUNmgvcWtNMmI1OHN5Vzh1UFZPUE9RNStNNlRt?=
 =?utf-8?B?NHRuUzQ2N3VPa21QMkRtV1YyNlVaMkI1dWlNcUMvbDliOWJHWmdEbVYxR1p1?=
 =?utf-8?B?MjhVbzVWclNiMlhsQW0rV0N6bFJkMFRQVCtvMG5rNzdPSzdkMExSM3dGb3p0?=
 =?utf-8?B?RUowVVp3ZXJnT0xWM01NS2pVMk1LaG9BQzFKRk43cTVvNFRvOWZ2dTNrSWJ4?=
 =?utf-8?B?aGQ1eStkeWxjeHlUdTd1WjBpeVdOV2x1NjNhcytEeEJRWDRtV1VURXlYblEx?=
 =?utf-8?B?NEtKZzNENmdSWG5CT0lKZkdYY0pRUTlveXZvbG9seE92YnBsZWlvbHIyS2hZ?=
 =?utf-8?B?VHYwYndZeWpOK2IrbWV4VHlBc2lWWkpBL21pVWUyQUtTR2RxVHBoVDYrT2Mw?=
 =?utf-8?B?aEQ3UFdjVk1IVnFiSFM1Z05kNGRDdEZzWU5IaU1RTjZhSmZmNFFMVUhGR1pO?=
 =?utf-8?Q?P6geB2wKwXwS9KUxd2UFW+dzU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77d4f1-74cd-41a6-ab33-08dd3c9cc1b3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 17:30:12.1977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IUXnveA99MYOx5GvGHsaz7RjgFny1CP5s3QCyvm82SvbosSOIOMTqBIbFIPMbkupH+WKbe4ApS6kZ0kzpewog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

--------------houN32WI2lmrLPDjJYJWBjSk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/24/2025 10:01 PM, Marek Olšák wrote:
> Does this commit really enable it though? Or is it just for sysfs?
>
Yes it enables cleaner shader support not only sysfs.

Best regards,
Srini

> Marek
>
> On Fri, Jan 24, 2025 at 1:42 AM Srinivasan Shanmugam 
> <srinivasan.shanmugam@amd.com> wrote:
>
>     Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
>     isolation between GPU workloads. The cleaner shader is responsible for
>     clearing the Local Data Store (LDS), Vector General Purpose Registers
>     (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
>     prevent data leakage and ensures accurate computation results.
>
>     This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
>     previously available for GFX10.1.10. It enhances security by clearing
>     GPU memory between processes and maintains a consistent GPU state
>     across
>     KGD and KFD workloads.
>
>     Cc: Christian König <christian.koenig@amd.com>
>     Cc: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     ---
>      drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>      1 file changed, 2 insertions(+)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     index 1878c83ff7e3..938f7d60a0ee 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct
>     amdgpu_ip_block *ip_block)
>             }
>             switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>             case IP_VERSION(10, 1, 10):
>     +       case IP_VERSION(10, 1, 1):
>     +       case IP_VERSION(10, 1, 2):
>                     adev->gfx.cleaner_shader_ptr =
>     gfx_10_1_10_cleaner_shader_hex;
>                     adev->gfx.cleaner_shader_size =
>     sizeof(gfx_10_1_10_cleaner_shader_hex);
>                     if (adev->gfx.me_fw_version >= 101 &&
>     -- 
>     2.34.1
>
--------------houN32WI2lmrLPDjJYJWBjSk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/24/2025 10:01 PM, Marek Olšák
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com">
      
      <div dir="ltr">
        <div>Does this commit really enable it though? Or is it just for
          sysfs?</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    <p>Yes it enables cleaner shader support not only sysfs.</p>
    <p>Best regards,<br>
      Srini<br>
    </p>
    <blockquote type="cite" cite="mid:CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com">
      <div dir="ltr">
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote gmail_quote_container">
        <div dir="ltr" class="gmail_attr">On Fri, Jan 24, 2025 at
          1:42 AM Srinivasan Shanmugam &lt;<a href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">srinivasan.shanmugam@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Enable
          the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data<br>
          isolation between GPU workloads. The cleaner shader is
          responsible for<br>
          clearing the Local Data Store (LDS), Vector General Purpose
          Registers<br>
          (VGPRs), and Scalar General Purpose Registers (SGPRs), which
          helps<br>
          prevent data leakage and ensures accurate computation results.<br>
          <br>
          This update extends cleaner shader support to GFX10.1.1/10.1.2
          GPUs,<br>
          previously available for GFX10.1.10. It enhances security by
          clearing<br>
          GPU memory between processes and maintains a consistent GPU
          state across<br>
          KGD and KFD workloads.<br>
          <br>
          Cc: Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
          Cc: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
          Signed-off-by: Srinivasan Shanmugam &lt;<a href="mailto:srinivasan.shanmugam@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">srinivasan.shanmugam@amd.com</a>&gt;<br>
          ---<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++<br>
          &nbsp;1 file changed, 2 insertions(+)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          index 1878c83ff7e3..938f7d60a0ee 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
          @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct
          amdgpu_ip_block *ip_block)<br>
          &nbsp; &nbsp; &nbsp; &nbsp; }<br>
          &nbsp; &nbsp; &nbsp; &nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
          &nbsp; &nbsp; &nbsp; &nbsp; case IP_VERSION(10, 1, 10):<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;case IP_VERSION(10, 1, 1):<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;case IP_VERSION(10, 1, 2):<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; adev-&gt;gfx.cleaner_shader_ptr =
          gfx_10_1_10_cleaner_shader_hex;<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; adev-&gt;gfx.cleaner_shader_size =
          sizeof(gfx_10_1_10_cleaner_shader_hex);<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (adev-&gt;gfx.me_fw_version &gt;= 101
          &amp;&amp;<br>
          -- <br>
          2.34.1<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------houN32WI2lmrLPDjJYJWBjSk--
