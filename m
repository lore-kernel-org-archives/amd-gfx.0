Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED31DCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B6B10E5DA;
	Tue,  4 Nov 2025 13:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GE90OngE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126DB10E5DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU0jiTYyuAwdgMeoNSlmVoVfjG+dkupoLJ2XbxpxFCNN534TSFlDcAZiyXaSx7CYSMSS4nwgVqh7fgwz/8P/NS+nJuADYOboN/gIMCZQud2YVDtpj4XR8+2jtiTdUBmmIYQlHTDM+uFj8FwKazkIpaa9QpZa6/TuRfKXm7zZnecRKMmtLz5Wf0e2unAnKn5DxoEvaE44bO+N7xR7Y2V4mhEyGhKSvkGdUQnYBJuUkPfu6ror+3IceCi7cqZpRpZOhpv2fGBxDTsRqzL9wfic3vK/WOJ8pV62ctnKvrOf+ijrLx/YjIJ371eKbM3TqQnu2mX0VxGtx70bpXG25041yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzwtEemwcpgxzXOSOMdnhQEwa1JMNItAybnSQSAM53w=;
 b=FmTeKNl2hhkfNyAqVBXyP4TeZBVqrhpp9ToSVMR7sjjSyhzgIj9fhvch4JuvbZfIVIr/wLlnclVxGHdhQy9T1pZd/+saiW0r8g6A89UVCif51SIGTIhOyFXow81WKqDD9+qpmhtqpwyar4DTtrlhd/o7DUCxFzvgr22RIbe6hVUh9E8d4yO/NoQZyvS2gq3BfIPUFY3FgWLQdwmU861SI9nH4I/HQybUuK/Vb8aKp0WTDJrnWYciNrjA+HwLX1+1+DW+rEWCzbJXWPdAyQUoqnZnFBBTD08Yj7rGqw1R/tbDbK6JzOK9/76lHQRledZNSKBpRg2mEVXt6eBE5ZgbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzwtEemwcpgxzXOSOMdnhQEwa1JMNItAybnSQSAM53w=;
 b=GE90OngEa97hPWv2IB5y0c7SUZbGYLP7XYy0vl3bNiAUwIWXkzDHWCmbhtQsD4VspFjjo4++ExT3F1aWu7mm9QJuzyyxHjkJMhxYqeELltJ0Ru8qVPFeMyxYF3cbSLJCP7B8t2D0eBv+IiWaTsXdCvlhATZnhHyhBcb23Kokil8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:52:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:52:01 +0000
Message-ID: <e3a7eb88-dfc9-4496-9b31-de93add56524@amd.com>
Date: Tue, 4 Nov 2025 14:51:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] drm/amdgpu/vce1: Implement VCE1 IP block (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-13-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103222333.37817-13-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: cf357bf0-da7c-45d6-e793-08de1ba95483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0hRdi91bUxsTUxiRHlabXg3MTBkL1QyUFdWNGRXWWVTSm9KOTYzYjRJbE9v?=
 =?utf-8?B?N3JWdktqT21pUDM3T1k3SDRwOUtBeDBkUVhtZzRjbTZKYnFKSmNCRm4yK2Yr?=
 =?utf-8?B?Q3J5b0VUQ1cwY2U2cVhSSGlRM0JJdmV0VGE0djNLWXJUYkhYZWRkckxUa2d0?=
 =?utf-8?B?MmlSaVJ5VEE2ZXkzUEYzeWNJMGM5VFJiTlZKRTRTbDRHbDNvRXNPVlBIazFY?=
 =?utf-8?B?QXkwRmRsS2k0VlpMMC9lQkRDWWRqOTFQTVF0QjB2dGRXb1lQUlRLempFM29V?=
 =?utf-8?B?R0lneUREL2Z2ZlVqRzJLOXZCMGxIQ2NMcFdBdXhkc0VsbklZdURsank3d1Y2?=
 =?utf-8?B?VnlTOHc2VktQbTl4NnM4cmhUVENVR2hZdk1iS2svU0w5cG1YQk4vMmNBNys5?=
 =?utf-8?B?eTUraDF3RFVtRjBCaFJiVUhRVFlJN3VCcnhqbTZLc2Z5U1NVU1IvMWh3a0Nn?=
 =?utf-8?B?K3NZVlpRTlpjN3VGc2VCOGcwcFE3bnk5bHhjMU1uT2ZuU0d4bDYvdUV3aWZy?=
 =?utf-8?B?UWZIcU5zS0lTQzY5eGhoWk5jTnhXRlBKc0JocGdjclc0TUFhcG9Ha2V6TzRV?=
 =?utf-8?B?Y3c2YmFXWnJxZmp4WktjSEt2ZUdiNWVrbVd5RjE5Y1EwTkhnNzBSS28xRWxN?=
 =?utf-8?B?U0R0SGRnMGtid1laVFk1blovRS80NGNrR0R0TW1neno2RWtvM1Nyb3B1WXFm?=
 =?utf-8?B?VzNJYUZCRWsvZTFHTld1NUc0OGR2ZGtiYlJrRUpOVDRnTXZBamhhRlNjZ0VX?=
 =?utf-8?B?Q0FKcWR2dnFvZGpQRVJqQjdHeTVrRUg3T3JMbmhuZE1TL29tWVY5bE15SFBO?=
 =?utf-8?B?cjdFd1dxUDFMZ1ZCN1h5SlcxY050NHRiMnUyU3VYcEpQRk5hQnVZZkpYWFBs?=
 =?utf-8?B?dHQ5TWhRdUNvdTl3Y0NuSGlGT0tJWUs5K1JRYWU2eVcwMWJrQStFL3BGTkNq?=
 =?utf-8?B?Tk9JaWxrNk5EcUFWUnYwakZteHFOWldjbVYrbEtKR1FDOWNPKzJJY01odCtY?=
 =?utf-8?B?L0dIZHRkOXZRME5aVWNuRGFhZjExeHN3WUFZOHNjdiswQ25NcUNtbTZMaVJH?=
 =?utf-8?B?elFxWWlkUTFselg3Ri9iQ3dBTDNLaHZTM2tLdDJoSGc0MnBqQzFpb1gxNjVv?=
 =?utf-8?B?YXVVci93KzJGOE1MSmFNbGV1Z1JEUzdiaTFoMlRZTDlrYUp4SXVEa2M3TjUv?=
 =?utf-8?B?eHBZbGhHSkZyK2JLUk1aYXlIbzd2Y1VxZXZoTmFlMnJPbGRUTEd1ZFBtRjJ6?=
 =?utf-8?B?ek02MlUzRVFXM01iUnZKVW1ZVjZGL0paNElFeEhHQVJrZ3VIUVIvSy9oMWx0?=
 =?utf-8?B?OWUzaU5iZVVXams0ODdZZkZyTGVpTk1vdFhFOFdFTVNERWlmRmp6aFhxck1n?=
 =?utf-8?B?VmtTOGtjKzVyUnordDBLajJsaW93Q0Njait4OUx6eHVkcU9QZGUyR2FZaDVq?=
 =?utf-8?B?amt1MmRaVEMyRitzd2o3LzZ2Zk50MElYYkJReFpRNWtIOVlveEUya280TWtB?=
 =?utf-8?B?SWVMaWp6djZtL1lvaUUvUW56MFBSQnlXWlJ3NmdZVmVnTitRUE1HRkxrV0Vh?=
 =?utf-8?B?RTMrL2JoTXVHQUpmYkJIekU4VjQwcG1keXJpaDRZWFdaRFlqR3l1S202Mkhm?=
 =?utf-8?B?clVzOVdzN3psai8wdkg4ZkQ1NVF3TzAzVE9mSlVJZkN5YjFlcUJpTGlReGdO?=
 =?utf-8?B?U09yeU1PWk93VndqZHZPSWRTSld0MW9zd0l6M09uTGlacFY4TGV0R2RpanN6?=
 =?utf-8?B?V2dzTWRkMlJwcVorLzY5azQ1c1ZaaWlqVXFPNzB3RHkrTUdsbExrUVNkRFdK?=
 =?utf-8?B?eDBOR2lYck5BOFdJZGFkOVlzaHJwaG5yOXpNMFJnQjgzaE85ME1rTG5MS3dP?=
 =?utf-8?B?Qlg4OVhONnBiMDdkWitvZktjbXZiTDE4S2ZjRnEyUlJLd25uQ0JQUWZ3NWYw?=
 =?utf-8?Q?t6D3Ve0X7OmHqdEzkq001BrURpxVMsCL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpJaEc1NTFxcE5PUXZVdXdYUHFzenB2Sk10RXdwcUkxYnNweWpBZHpnRkRj?=
 =?utf-8?B?NXRsWGg0MURZV1FXL2lVaGNNa1hvU0dWSGVBc3FONHpwdzhldWZoYnJjaXJ6?=
 =?utf-8?B?WVlNL0Q5M2xYd2tMcWtrOEMvbnE4SnJ0NTRSZURZcDc2WTV5bWxla01wM2Ry?=
 =?utf-8?B?VithTmNza3IxSlRjelpBeVRsbDB4Q0d5YTdVRVZaaEVCT3FQaUgyMHVpdytp?=
 =?utf-8?B?WkduS2lZcmVsb1hIZStDSnF2L25FeUN3TnQ1VEVxS25ybXJteEExdks5SGtL?=
 =?utf-8?B?M3dLNGRna3BLT1FkMVcyQVdqWEY0YjlJTUx1L0RZKzZMenczRFZZOFQ2OVV4?=
 =?utf-8?B?QjJ3MVpqUGMxUUs3RjhKOTgrOFY0U2tjNkMzR0Jvd0hRcXM2ZTZDL3hQeWw4?=
 =?utf-8?B?WDNFUnRtM2J1Umg0ZUM2UEFENnNRNG9HK1AvWXFZbWdnTVkxZjJLa3ZtTHFs?=
 =?utf-8?B?QkgxN0dYOCt6SHhaUVEzM3FISWVRbkFIVTNUa2I2MXJldVcrQitDY00wS1Z1?=
 =?utf-8?B?bjh4ZlNDM3lWU0ZTUW1VODBLeVIrVTlrUGdVWTZhTklUU1FOYndISm5qdThx?=
 =?utf-8?B?eGRZMUdUdHpZZGNMUm9sT2J4b1g0UDZtelVCWmJxRnkvamF4NkxpMmVTSnY1?=
 =?utf-8?B?T3VkbjEwdC91Q01zQmdNb3c5SWJlblNRZ25oS0V5SzJybGt1WnQ0NEUvbkor?=
 =?utf-8?B?aEgzY1Z5b3d5N2xiRmVGRGd1TWFJdnpzLzRMNEZXMG45VjdTTHlKdDU4S1dC?=
 =?utf-8?B?N1lvZTBLSE5pczlqUVp6Yi9zNDc2MnFNRFpWOFpZZllxN0Nnb3d4UFNJRkJr?=
 =?utf-8?B?aW5hZW1LSnlBOUFSRk5QWFd5RkpqQlRFY3loVzhiZDRaVHVRSGNrQkxETjBO?=
 =?utf-8?B?aXlIRFQ5M1dFcjR1Qm9leVRhWXpMbm5VQU5SeDM1eFZESmpGdFVCK3NqT09k?=
 =?utf-8?B?MWJZaFJ0d1F5Z3hVTlFMR1RoUFBEaWdtbnluWlIzNG93OUJFUEpIR0xhVElF?=
 =?utf-8?B?emJQREtETzVYMllNOUN4M3duUjNFd0NrZnVUeFRSWFlxMEtQMDFONDVwWkZH?=
 =?utf-8?B?SXhKTFVjb3FZMllWSTdlcGRNdUZRK3NSZktIRGZxU2JqYVN1RXNuZFJKZ2My?=
 =?utf-8?B?ZUUrRnVNOWtHNy9JQlZraHJHdkVwWnlrZ2NCemVuTE1kcmtwSS96MVljZTZl?=
 =?utf-8?B?YnptSm93RXBONVhLL2FJWnNlVm44Ny9VZnZhL3hzRmN2eS9rakd3eDRickhk?=
 =?utf-8?B?cXo1czdZcVd5cjFMZXBxODExcDdtQm5HeTdaQkp1Sm9FSklSMEFxOFAybmcr?=
 =?utf-8?B?UFNLbllYbHdCM3I2bHAyWjAzcDFhdmRCOW9oL04wQkNwQkF2WVpraHFGUnY3?=
 =?utf-8?B?YTFyelhrSlhwcWtWbit3TWx0Z09IUkhHWW0wKzNUR1F2eFZiakFsdjJ3V3JD?=
 =?utf-8?B?NjVCandPcmtsckJwckVKazJjdC9YOXl0T0pUNkd0cU1VOHd3bjY3SkY2WWEx?=
 =?utf-8?B?UlMyTzlhQWU3OUp3bXBHZ0lnVSs4VjkrRE1mWDl5K3ZDVHZoU1F4OUsveVdi?=
 =?utf-8?B?UDZlaXNVc29NYSticjFJMjgrRUViOHRVVUdkcUFjNk5aakk2Y1dYV1VRQ242?=
 =?utf-8?B?a2xERGtiUnlPRDM2cnhRc2hweWViTTAyd3Q3b0ZIazZhNkJCV3dERWlYeWZi?=
 =?utf-8?B?T3AxWWg1Q0ZJK2owaG54TzlLTDB1ZmQ4LzdjSVhaei9xZFVZNEk0Yi9rU1dy?=
 =?utf-8?B?WU1zNW9OT0E3OXpPNTFiaG04cUhHK203cmk2MmZzb1c3Q20zZ1dLVkJJVGJn?=
 =?utf-8?B?OSthRnFYS2o4djdGRlVrdUI3dloydmdWVjkxZjBicmV0U25vRE1xUDBrNlBO?=
 =?utf-8?B?RG5HTDZXMGxRZ3Q4N21LRHBTRkY3cFVBVWFseTJocXp2RTduTmpyTlp2cFNL?=
 =?utf-8?B?STFsbUxUdWdWVElXZnM0VlUzTEJvckNaY09tRmplcktMMUFEWW8yb0hZVGZx?=
 =?utf-8?B?ZkFkZzhRZzJHaEozL2E2SC9IZWZNeW83VTFmZTVCSlhPdm13T2FrTEJRL2Iy?=
 =?utf-8?B?SXVjZjlnUGptR2xaNFRvZml5aUN6K3pQOFViZEVLbC93M2Jtb0hYSnVrbnhy?=
 =?utf-8?Q?VBZ0E5L9vx5DgrFW3c6dugiTP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf357bf0-da7c-45d6-e793-08de1ba95483
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:52:01.8014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb7lPGh2ST0IKTFCLebs7cpR85Z1kTzSLtjUPLBF9fcF6hYpMnpd89n2zOOb/eaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

On 11/3/25 23:23, Timur Kristóf wrote:
> Implement the necessary functionality to support the VCE1.
> This implementation is based on:
> 
> - VCE2 code from amdgpu
> - VCE1 code from radeon (the old driver)
> - Some trial and error
> 
> A subsequent commit will ensure correct mapping for
> the VCPU BO, which will make this actually work.
> 
> v2:
> - Use memset_io more.
> - Use memcpy_toio more.
> - Remove __func__ from warnings.
> - Don't reserve and map the VCPU BO anymore.
> - Add empty line to multi-line comments
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 784 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.h   |  32 +
>  4 files changed, 818 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ebe08947c5a3..c88760fb52ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -78,7 +78,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o \
>  	dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
>  
>  amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o \
> -	uvd_v3_1.o
> +	uvd_v3_1.o vce_v1_0.o
>  
>  amdgpu-y += \
>  	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index 22acd7b35945..050783802623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -51,6 +51,7 @@ struct amdgpu_vce {
>  	struct drm_sched_entity	entity;
>  	uint32_t                srbm_soft_reset;
>  	unsigned		num_rings;
> +	uint32_t		keyselect;
>  };
>  
>  int amdgpu_vce_early_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> new file mode 100644
> index 000000000000..bf9f943852cb
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -0,0 +1,784 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2013 Advanced Micro Devices, Inc.
> + * Copyright 2025 Valve Corporation
> + * Copyright 2025 Alexandre Demers
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + * Authors: Christian König <christian.koenig@amd.com>
> + *          Timur Kristóf <timur.kristof@gmail.com>
> + *          Alexandre Demers <alexandre.f.demers@gmail.com>
> + */
> +
> +#include <linux/firmware.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vce.h"
> +#include "sid.h"
> +#include "vce_v1_0.h"
> +#include "vce/vce_1_0_d.h"
> +#include "vce/vce_1_0_sh_mask.h"
> +#include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
> +
> +#define VCE_V1_0_FW_SIZE	(256 * 1024)
> +#define VCE_V1_0_STACK_SIZE	(64 * 1024)
> +#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
> +#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
> +
> +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
> +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> +
> +struct vce_v1_0_fw_signature {
> +	int32_t offset;
> +	uint32_t length;
> +	int32_t number;
> +	struct {
> +		uint32_t chip_id;
> +		uint32_t keyselect;
> +		uint32_t nonce[4];
> +		uint32_t sigval[4];
> +	} val[8];
> +};
> +
> +/**
> + * vce_v1_0_ring_get_rptr - get read pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Returns the current hardware read pointer
> + */
> +static uint64_t vce_v1_0_ring_get_rptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		return RREG32(mmVCE_RB_RPTR);
> +	else
> +		return RREG32(mmVCE_RB_RPTR2);
> +}
> +
> +/**
> + * vce_v1_0_ring_get_wptr - get write pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Returns the current hardware write pointer
> + */
> +static uint64_t vce_v1_0_ring_get_wptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		return RREG32(mmVCE_RB_WPTR);
> +	else
> +		return RREG32(mmVCE_RB_WPTR2);
> +}
> +
> +/**
> + * vce_v1_0_ring_set_wptr - set write pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Commits the write pointer to the hardware
> + */
> +static void vce_v1_0_ring_set_wptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> +	else
> +		WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> +}
> +
> +static int vce_v1_0_lmi_clean(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 10; ++i) {
> +		for (j = 0; j < 100; ++j) {
> +			if (RREG32(mmVCE_LMI_STATUS) & 0x337f)
> +				return 0;
> +
> +			mdelay(10);
> +		}
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int vce_v1_0_firmware_loaded(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 10; ++i) {
> +		for (j = 0; j < 100; ++j) {
> +			if (RREG32(mmVCE_STATUS) & VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK)
> +				return 0;
> +			mdelay(10);
> +		}
> +
> +		dev_err(adev->dev, "VCE not responding, trying to reset the ECPU\n");
> +
> +		WREG32_P(mmVCE_SOFT_RESET,
> +			VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +		mdelay(10);
> +		WREG32_P(mmVCE_SOFT_RESET, 0,
> +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +		mdelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void vce_v1_0_init_cg(struct amdgpu_device *adev)
> +{
> +	u32 tmp;
> +
> +	tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +	tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +	WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +	tmp = RREG32(mmVCE_CLOCK_GATING_B);
> +	tmp |= 0x1e;
> +	tmp &= ~0xe100e1;
> +	WREG32(mmVCE_CLOCK_GATING_B, tmp);
> +
> +	tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +	tmp &= ~0xff9ff000;
> +	WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +	tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +	tmp &= ~0x3ff;
> +	WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +}
> +
> +/**
> + * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * The VCE1 firmware validation mechanism needs a firmware signature.
> + * This function finds the signature appropriate for the current
> + * ASIC and writes that into the VCPU BO.
> + */
> +static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
> +{
> +	const struct common_firmware_header *hdr;
> +	struct vce_v1_0_fw_signature *sign;
> +	unsigned int ucode_offset;
> +	uint32_t chip_id;
> +	u32 *cpu_addr;
> +	int i;
> +
> +	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> +	ucode_offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> +	cpu_addr = adev->vce.cpu_addr;
> +
> +	sign = (void *)adev->vce.fw->data + ucode_offset;
> +
> +	switch (adev->asic_type) {
> +	case CHIP_TAHITI:
> +		chip_id = 0x01000014;
> +		break;
> +	case CHIP_VERDE:
> +		chip_id = 0x01000015;
> +		break;
> +	case CHIP_PITCAIRN:
> +		chip_id = 0x01000016;
> +		break;
> +	default:
> +		dev_err(adev->dev, "asic_type %#010x was not found!", adev->asic_type);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < le32_to_cpu(sign->number); ++i) {
> +		if (le32_to_cpu(sign->val[i].chip_id) == chip_id)
> +			break;
> +	}
> +
> +	if (i == le32_to_cpu(sign->number)) {
> +		dev_err(adev->dev, "chip_id 0x%x for %s was not found in VCE firmware",
> +			chip_id, amdgpu_asic_name[adev->asic_type]);
> +		return -EINVAL;
> +	}
> +
> +	cpu_addr += (256 - 64) / 4;
> +	memcpy_toio(&cpu_addr[0], &sign->val[i].nonce[0], 16);
> +	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
> +
> +	memset_io(&cpu_addr[5], 0, 44);
> +	memcpy_toio(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes - sizeof(*sign));
> +
> +	cpu_addr += (le32_to_cpu(sign->length) + 64) / 4;
> +	memcpy_toio(&cpu_addr[0], &sign->val[i].sigval[0], 16);
> +
> +	adev->vce.keyselect = le32_to_cpu(sign->val[i].keyselect);
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_wait_for_fw_validation(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	dev_dbg(adev->dev, "VCE keyselect: %d", adev->vce.keyselect);
> +	WREG32(mmVCE_LMI_FW_START_KEYSEL, adev->vce.keyselect);
> +
> +	for (i = 0; i < 10; ++i) {
> +		mdelay(10);
> +		if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)
> +			break;
> +	}
> +
> +	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)) {
> +		dev_err(adev->dev, "VCE FW validation timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__PASS_MASK)) {
> +		dev_err(adev->dev, "VCE FW validation failed\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < 10; ++i) {
> +		mdelay(10);
> +		if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK))
> +			break;
> +	}
> +
> +	if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK) {
> +		dev_err(adev->dev, "VCE FW busy timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
> +{
> +	uint32_t offset;
> +	uint32_t size;
> +
> +	/*
> +	 * When the keyselect is already set, don't perturb VCE FW.
> +	 * Validation seems to always fail the second time.
> +	 */
> +	if (RREG32(mmVCE_LMI_FW_START_KEYSEL)) {
> +		dev_dbg(adev->dev, "keyselect already set: 0x%x (on CPU: 0x%x)\n",
> +			RREG32(mmVCE_LMI_FW_START_KEYSEL), adev->vce.keyselect);
> +
> +		WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> +		return 0;
> +	}
> +
> +	WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
> +	WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000, ~0xFF9FF000);
> +	WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
> +	WREG32(mmVCE_CLOCK_GATING_B, 0);
> +
> +	WREG32_P(mmVCE_LMI_FW_PERIODIC_CTRL, 0x4, ~0x4);
> +
> +	WREG32(mmVCE_LMI_CTRL, 0x00398000);
> +
> +	WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
> +	WREG32(mmVCE_LMI_SWAP_CNTL, 0);
> +	WREG32(mmVCE_LMI_SWAP_CNTL1, 0);
> +	WREG32(mmVCE_LMI_VM_CTRL, 0);
> +
> +	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
> +
> +	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
> +	size = VCE_V1_0_FW_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
> +
> +	offset += size;
> +	size = VCE_V1_0_STACK_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
> +
> +	offset += size;
> +	size = VCE_V1_0_DATA_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
> +
> +	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> +
> +	return vce_v1_0_wait_for_fw_validation(adev);
> +}
> +
> +/**
> + * vce_v1_0_is_idle() - Check idle status of VCE1 IP block
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + *
> + * Check whether VCE is busy according to VCE_STATUS.
> + * Also check whether the SRBM thinks VCE is busy, although
> + * SRBM_STATUS.VCE_BUSY seems to be bogus because it
> + * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
> + */
> +static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	bool busy =
> +		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK | VCE_STATUS__UENC_BUSY_MASK)) ||
> +		(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
> +
> +	return !busy;
> +}
> +
> +static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned int i;
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		udelay(1);
> +		if (vce_v1_0_is_idle(ip_block))
> +			return 0;
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +/**
> + * vce_v1_0_start - start VCE block
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Setup and start the VCE block
> + */
> +static int vce_v1_0_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *ring;
> +	int r;
> +
> +	WREG32_P(mmVCE_STATUS, 1, ~1);
> +
> +	r = vce_v1_0_mc_resume(adev);
> +	if (r)
> +		return r;
> +
> +	ring = &adev->vce.ring[0];
> +	WREG32(mmVCE_RB_RPTR, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_SIZE, ring->ring_size / 4);
> +
> +	ring = &adev->vce.ring[1];
> +	WREG32(mmVCE_RB_RPTR2, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_BASE_LO2, lower_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
> +
> +	WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK,
> +		 ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +
> +	WREG32_P(mmVCE_SOFT_RESET,
> +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	mdelay(100);
> +
> +	WREG32_P(mmVCE_SOFT_RESET, 0,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	r = vce_v1_0_firmware_loaded(adev);
> +
> +	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy. */
> +	WREG32(mmVCE_STATUS, 0);
> +
> +	if (r) {
> +		dev_err(adev->dev, "VCE not responding, giving up\n");
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_stop(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ip_block *ip_block;
> +	int status;
> +	int i;
> +
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	if (vce_v1_0_lmi_clean(adev))
> +		dev_warn(adev->dev, "VCE not idle\n");
> +
> +	if (vce_v1_0_wait_for_idle(ip_block))
> +		dev_warn(adev->dev, "VCE busy: VCE_STATUS=0x%x, SRBM_STATUS2=0x%x\n",
> +			RREG32(mmVCE_STATUS), RREG32(mmSRBM_STATUS2));
> +
> +	/* Stall UMC and register bus before resetting VCPU */
> +	WREG32_P(mmVCE_LMI_CTRL2, 1 << 8, ~(1 << 8));
> +
> +	for (i = 0; i < 100; ++i) {
> +		status = RREG32(mmVCE_LMI_STATUS);
> +		if (status & 0x240)
> +			break;
> +		mdelay(1);
> +	}
> +
> +	WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +
> +	WREG32_P(mmVCE_SOFT_RESET,
> +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	WREG32(mmVCE_STATUS, 0);
> +
> +	return 0;
> +}
> +
> +static void vce_v1_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
> +{
> +	u32 tmp;
> +
> +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG)) {
> +		tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +		tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +		tmp &= ~0x1ff000;
> +		tmp |= 0xff800000;
> +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +		tmp &= ~0x3ff;
> +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +	} else {
> +		tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +		tmp &= ~VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +		tmp |= 0x1ff000;
> +		tmp &= ~0xff800000;
> +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +		tmp |= 0x3ff;
> +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +	}
> +}
> +
> +static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_early_init(adev);
> +	if (r)
> +		return r;
> +
> +	adev->vce.num_rings = 2;
> +
> +	vce_v1_0_set_ring_funcs(adev);
> +	vce_v1_0_set_irq_funcs(adev);
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_ring *ring;
> +	int r, i;
> +
> +	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 167, &adev->vce.irq);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_vce_sw_init(adev, VCE_V1_0_FW_SIZE +
> +		VCE_V1_0_STACK_SIZE + VCE_V1_0_DATA_SIZE);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_vce_resume(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		enum amdgpu_ring_priority_level hw_prio = amdgpu_vce_get_ring_prio(i);
> +
> +		ring = &adev->vce.ring[i];
> +		sprintf(ring->name, "vce%d", i);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     hw_prio, NULL);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +static int vce_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_suspend(adev);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_vce_sw_fini(adev);
> +}
> +
> +/**
> + * vce_v1_0_hw_init - start and test VCE block
> + *
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> + *
> + * Initialize the hardware, boot up the VCPU and do some testing
> + */
> +static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int i, r;
> +
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vce(adev, true);
> +	else
> +		amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
> +		if (r)
> +			return r;
> +	}
> +
> +	dev_info(adev->dev, "VCE initialized successfully.\n");
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	r = vce_v1_0_stop(ip_block->adev);
> +	if (r)
> +		return r;
> +
> +	cancel_delayed_work_sync(&ip_block->adev->vce.idle_work);
> +	return 0;
> +}
> +
> +static int vce_v1_0_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	/*
> +	 * Proper cleanups before halting the HW engine:
> +	 *   - cancel the delayed idle work
> +	 *   - enable powergating
> +	 *   - enable clockgating
> +	 *   - disable dpm
> +	 *
> +	 * TODO: to align with the VCN implementation, move the
> +	 * jobs for clockgating/powergating/dpm setting to
> +	 * ->set_powergating_state().
> +	 */
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	if (adev->pm.dpm_enabled) {
> +		amdgpu_dpm_enable_vce(adev, false);
> +	} else {
> +		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_CG_STATE_GATE);
> +	}
> +
> +	r = vce_v1_0_hw_fini(ip_block);
> +	if (r) {
> +		dev_err(adev->dev, "vce_v1_0_hw_fini() failed with error %i", r);
> +		return r;
> +	}
> +
> +	return amdgpu_vce_suspend(adev);
> +}
> +
> +static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_resume(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +
> +	return vce_v1_0_hw_init(ip_block);
> +}
> +
> +static int vce_v1_0_set_interrupt_state(struct amdgpu_device *adev,
> +					struct amdgpu_irq_src *source,
> +					unsigned int type,
> +					enum amdgpu_interrupt_state state)
> +{
> +	uint32_t val = 0;
> +
> +	if (state == AMDGPU_IRQ_STATE_ENABLE)
> +		val |= VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK;
> +
> +	WREG32_P(mmVCE_SYS_INT_EN, val,
> +		 ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> +	return 0;
> +}
> +
> +static int vce_v1_0_process_interrupt(struct amdgpu_device *adev,
> +				      struct amdgpu_irq_src *source,
> +				      struct amdgpu_iv_entry *entry)
> +{
> +	dev_dbg(adev->dev, "IH: VCE\n");
> +	switch (entry->src_data[0]) {
> +	case 0:
> +	case 1:
> +		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
> +		break;
> +	default:
> +		dev_err(adev->dev, "Unhandled interrupt: %d %d\n",
> +			  entry->src_id, entry->src_data[0]);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_clockgating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	vce_v1_0_init_cg(adev);
> +	vce_v1_0_enable_mgcg(adev, state == AMD_CG_STATE_GATE);
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	/*
> +	 * This doesn't actually powergate the VCE block.
> +	 * That's done in the dpm code via the SMC.  This
> +	 * just re-inits the block as necessary.  The actual
> +	 * gating still happens in the dpm code.  We should
> +	 * revisit this when there is a cleaner line between
> +	 * the smc and the hw blocks
> +	 */
> +	if (state == AMD_PG_STATE_GATE)
> +		return vce_v1_0_stop(adev);
> +	else
> +		return vce_v1_0_start(adev);
> +}
> +
> +static const struct amd_ip_funcs vce_v1_0_ip_funcs = {
> +	.name = "vce_v1_0",
> +	.early_init = vce_v1_0_early_init,
> +	.sw_init = vce_v1_0_sw_init,
> +	.sw_fini = vce_v1_0_sw_fini,
> +	.hw_init = vce_v1_0_hw_init,
> +	.hw_fini = vce_v1_0_hw_fini,
> +	.suspend = vce_v1_0_suspend,
> +	.resume = vce_v1_0_resume,
> +	.is_idle = vce_v1_0_is_idle,
> +	.wait_for_idle = vce_v1_0_wait_for_idle,
> +	.set_clockgating_state = vce_v1_0_set_clockgating_state,
> +	.set_powergating_state = vce_v1_0_set_powergating_state,
> +};
> +
> +static const struct amdgpu_ring_funcs vce_v1_0_ring_funcs = {
> +	.type = AMDGPU_RING_TYPE_VCE,
> +	.align_mask = 0xf,
> +	.nop = VCE_CMD_NO_OP,
> +	.support_64bit_ptrs = false,
> +	.no_user_fence = true,
> +	.get_rptr = vce_v1_0_ring_get_rptr,
> +	.get_wptr = vce_v1_0_ring_get_wptr,
> +	.set_wptr = vce_v1_0_ring_set_wptr,
> +	.parse_cs = amdgpu_vce_ring_parse_cs,
> +	.emit_frame_size = 6, /* amdgpu_vce_ring_emit_fence  x1 no user fence */
> +	.emit_ib_size = 4, /* amdgpu_vce_ring_emit_ib */
> +	.emit_ib = amdgpu_vce_ring_emit_ib,
> +	.emit_fence = amdgpu_vce_ring_emit_fence,
> +	.test_ring = amdgpu_vce_ring_test_ring,
> +	.test_ib = amdgpu_vce_ring_test_ib,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.begin_use = amdgpu_vce_ring_begin_use,
> +	.end_use = amdgpu_vce_ring_end_use,
> +};
> +
> +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		adev->vce.ring[i].funcs = &vce_v1_0_ring_funcs;
> +		adev->vce.ring[i].me = i;
> +	}
> +};
> +
> +static const struct amdgpu_irq_src_funcs vce_v1_0_irq_funcs = {
> +	.set = vce_v1_0_set_interrupt_state,
> +	.process = vce_v1_0_process_interrupt,
> +};
> +
> +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev)
> +{
> +	adev->vce.irq.num_types = 1;
> +	adev->vce.irq.funcs = &vce_v1_0_irq_funcs;
> +};
> +
> +const struct amdgpu_ip_block_version vce_v1_0_ip_block = {
> +	.type = AMD_IP_BLOCK_TYPE_VCE,
> +	.major = 1,
> +	.minor = 0,
> +	.rev = 0,
> +	.funcs = &vce_v1_0_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> new file mode 100644
> index 000000000000..206e7bec897f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + * Copyright 2025 Valve Corporation
> + * Copyright 2025 Alexandre Demers
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __VCE_V1_0_H__
> +#define __VCE_V1_0_H__
> +
> +extern const struct amdgpu_ip_block_version vce_v1_0_ip_block;
> +
> +#endif

