Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78BBCCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED3210E3D4;
	Mon, 13 Oct 2025 07:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WaKgPL4N";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCC710E3D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhZA3gakPyPzr20bvQcakg0lwzY0iF9I/DNnRctSAorrRxIrrm/EMLo00ay0u0cAR3uRfreVdxUTTI9wQ5pXPYohss6Jyunlk69ktQtUBQaAiejKqEnRMHgvxwZmzwJI8Jp3Krt5RMPgtmkGilxcqgE9b/AeGq7uM0yKwJpxDxjHd8CsSmWb9lEaU5+5YLRg2YRf0k/+gCeFGfxdWNk6Tz2YuwlGnCfE5ifcmmDgvwmbHuUgJUieYDpfQSKUl1o0NZGZzv6idhn6cyuaUaBIEASPJXnBCuZ5hGUSfFbtLQcKA2mTvtmkZcckih+z8+jEyoCrG/3iK8jITwXpVQXnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADA6CPV0uDZiEzhyZN0wgTnqFtFHQ7UNYa6SrQL4JRQ=;
 b=AQQa0CGCEixrLkyJoP+/Iw3wOidxK/Gq57sag8WOo+dPUt8dBDMO0jI0HlHalqUiZdRJ9n6gXR3ydDDeLq3hqanqFU8IvWtDX1qKl2H+RAM6smslws1YvKrB86aLz17zuzaHprZlPeYafZ5ZXesXhi9Jijw3Rn1CZq9NYHOzxgPDf9wcB5+NP2TLZpgOfD/sKesrgo/EvW+Cd99ifcizeBkPlh+qNxUOfM+ER0n0Ob+L0JN5qs81Gvv9qUdW6WvEMlDo/OkJE1oZo5heEvkWXOA6KHQmZID+HHTYvAmTy7MVjvo120s2wclccrzRC7OxkgrCeIl4oiHHdKYoHrWeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADA6CPV0uDZiEzhyZN0wgTnqFtFHQ7UNYa6SrQL4JRQ=;
 b=WaKgPL4NEWE16RP6CF+L1N4DgnXJox0rXBBS8+LeNdKsg58ysog9yh9GegmjVAbSlHgpsvlUy4Q4F9JFTTlvEdDa0gbQAnwIahABV/EZmSzgXAMa4vGymDBVi6zPC9R77ggvz9J/CWWRBYO+ZsB3+eFMNbVF/MA5XIRrZQJxqXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 07:19:29 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:19:28 +0000
Message-ID: <20987a17-e3f7-487d-ba9f-c2296534d56a@amd.com>
Date: Mon, 13 Oct 2025 12:49:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 1/2] drm/amdgpu: update the functions to use amdgpu
 version of hmm
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
 <af6a5ced-07e7-400b-83c5-613ed7f06a30@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <af6a5ced-07e7-400b-83c5-613ed7f06a30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::53) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e60ebe-d0dc-4cda-aaea-08de0a28d8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy96OFVLampIdS8rTUxXT3k3SjBXNzRBd1Y1MTdudHgrektaemlxcnpnT05Z?=
 =?utf-8?B?b29wNGxONEsrdVBDaDNoQjBEd1N6c1I2RmdaMmJBNkh0NG1Mdkp3cit6cWRs?=
 =?utf-8?B?SWxqQzlLTEJLQWZFcWxSUDlIRWhrc1lZZ3NlQjVya3Q5c2pmMDZreFk4K3ps?=
 =?utf-8?B?N3VzWEJ1OGlPQ3o5WDJDSDlWVjJzMDVYOUNESi9KME9TZjlHaGJSYTdoY2hH?=
 =?utf-8?B?Umw3TzMya0RPclpKOVBSNVJnVlBHa1VIZ3lQcWRWa2d3YkdyRGtXMm10K3Vy?=
 =?utf-8?B?cUd5dDhvRnRzVlpCWkJxa2NScjZSN0lWbk4yT2ZIYzBsWHl2L2E2TFBsYVlH?=
 =?utf-8?B?SWxjanZ3UWVqWGRod2l2QS9IRTQ1QWVvSWxLdlNsYml1RGw1MDM2NHJ5VEta?=
 =?utf-8?B?YlpmdnlUWDVZSkdDd1dyR0JsOTA1eVNUUGtaem4valpFc2VLNU9PTmtSNEdu?=
 =?utf-8?B?d2VudUlaZkRmS1VnWXBBYm5reUlRS0xabVowQzdoZVhkNG5CTTZzdXRLcVJ6?=
 =?utf-8?B?MDAzd3JSMnBwZTRaSGNva2xVVkw1VjFXT0M3WUh1SUJsY0lnZGxIU0FvVysz?=
 =?utf-8?B?U3NzZ0h3eExPaGZMUVMvUVJmaDJ1aWtlRGV5NzlhZkQwWG4zeUgyYkt0dE9I?=
 =?utf-8?B?SDNMbXVnVVVFS0grQnl0TVdyUDZHejRreElNZ1hEZWRIV0JBbkQ1R0VIWVJB?=
 =?utf-8?B?N01wVGd5NkxBMWJsdGNCakFKMktrVjM2MlBrVFplVnozNGh6ZXgvNVp3Zng1?=
 =?utf-8?B?Q0J0d2FtK3pXV3dlN0NjU25JRDZmYmdsTkh4cG5kcG1pZVdpZVp4Q2YySXJU?=
 =?utf-8?B?ZXV4ekV1R2x6WThDaWxvUXR3TE9HYVp3SDBUSG9ZVjhTU3h1aWdBWlNTVVJs?=
 =?utf-8?B?dFBJSXo4bEdQUlh4S1NZVE1PRXFSWEJ6dE4yUm5TVkh1cDZ1Vy9aaTBpZEFB?=
 =?utf-8?B?QkgvUEwrcWw1eFhMZnAzS0RoMXhSWGpSaEI4ODU3Q0dudit6a3BPdkFxZTFx?=
 =?utf-8?B?OXVkUTUxNC9vTmU2b3VtendYeTc4YmtsS2tDbVNyVXozT2xZTTV5RjJmZVg1?=
 =?utf-8?B?T09nR0l4K3EzcmVpcXdKcmxmZ04ya0pqN3M1RzFHQ1VzalIraStkcG5CblUy?=
 =?utf-8?B?NjdEYzZudi9uUHBrN0lEMjdYZ2dnakIxSEY4a1FXcks2VlI4NDYyT211NVRS?=
 =?utf-8?B?eGRVU0JVVTFEcDZhQm9XL01OTTdPU1Jwd1FuZGgrWW9TQ1Q0SkdpazZ6S0hk?=
 =?utf-8?B?YXIwU1A1UVorV21OZUdtNW0wYWFveXV0MHE4eDVTSTMrNmNiYlFObzRIeGI2?=
 =?utf-8?B?aXB0L0YvT2ZRS0w5Z090a0V5azU3Zi9wTUQrTTZERWQ4V0tRekQvcEczUU9M?=
 =?utf-8?B?OUFBNkNMNGdsMmNLbzlDOVJNQytpb3RwT3NjZDR0emZodnNEMXo3OWFvb3lG?=
 =?utf-8?B?UEdBVzFqcmxSN3R2NHlKQ0NnRGlCWkxHWmRPRDJvamVEQmR3ZDlEaFptQllU?=
 =?utf-8?B?RGVVZ3ZWTXQ2aGNlYk1JUGVpZFZacTMxb2FDR0NGMXJUaU4xbWFxamM2SDRM?=
 =?utf-8?B?eklkaW04a3JLbGhJaDhab09CVXJNdmFUYUFWNWxjTkpseHpZT0NRTGdJeXBv?=
 =?utf-8?B?V2RTRHI2WkRrREpaTHdIU1E2TVA4Vkx1bG53U2VlSko0UVJDVVNFVTkyV005?=
 =?utf-8?B?OVhxVDFEN1NoWXcySzNza2d3elhYZ3N6TytOVHJWUEdmUXFQR2lnWXcxZHJH?=
 =?utf-8?B?aFFjNHBBYW8zYkh5clovU0IrTGdleWdGaE5GTitkcVBJVmIraUhXUVhEeW1t?=
 =?utf-8?B?ZktocTFUa09RMnJFNS9tNDY1OWI2Y3BSbERiQ0d0eUZmdTNVdTVKNU0yUzBs?=
 =?utf-8?B?Tytuc1RPMVJXcnFlNXlZK04vOHo1TjUwU1Yrck1tUWZZSWNKT2VkRVhHNSsr?=
 =?utf-8?Q?HbBVpg1BjVEMlnBStO6AAchV7U0WAoh6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJOaUtLN2JwTUpwaEFsK1BDUTF3NnAwMm9KRkNLMkVuanR6aks1dzhQc05o?=
 =?utf-8?B?eWl1cVVaUnlDRjdKZUN5Uy9FWlJiWnd3ZHhJem5DTlJvWHBwc2ljMlBvMkIx?=
 =?utf-8?B?M2d4aVhVdnc1MXVKbXdlaHBIaEtxQWdUUFFjTDhlTDZ1VkdCbUlnZ0IwQ2xB?=
 =?utf-8?B?ZGxic0dYVHYyamJYSHI3Und4N1VEYUZRb2pxNStyMGN2OFpCY0VIZkhjM2Jv?=
 =?utf-8?B?K3pKL09lTG5TdW9xdzhRSVhYd3VCTnEwb0g4UnplS0dZOVpFN3FsRnJoT1hm?=
 =?utf-8?B?cTRyM2dYODFTbVlKTXV1d0gzdzdNalZET2xpeEJCSGI4UU5EbVNYWjlvSmpJ?=
 =?utf-8?B?V2NBTUtNeS85NFloSnlDcXhlNXlWbGoyYVZXRmRNU2MvcUZDQngrMm9hS096?=
 =?utf-8?B?YUx2bGlmYUpDVUVCRFFtaUwydEtpd2RDWlNCbXNtT0lJWCt5ZVZRSlpaZzFZ?=
 =?utf-8?B?bDdZci9wTXBRVERVTTMvb2t2ZTNsQWdSTmJQTU8wc1pGb3krUzNwWmZVOW40?=
 =?utf-8?B?b2hENEl0U1F3MFdGTEthYWZ1V1JWR3lUWDJ0U2prdkxicWtDajh6OWxmdmkz?=
 =?utf-8?B?SnNoYUpoZ2VBZ3h0L01QdGpVcHMvbUhHNjJmTmorTEhWWlA1NDIwMXlIZlBO?=
 =?utf-8?B?V21uRUpORTlFbUczRHFndFFKQVVwQVpaamNxQU50OCtnbWxIWEhxdFVURWE4?=
 =?utf-8?B?endkT00zMDhTbjduY2JPMEFrUXQwRkoyWmFHOVIrVkRXREQ3RFhSWHVjOU13?=
 =?utf-8?B?aEtVWXUrNVNyYUhEMTBWQW05RWx6QXh5bGh2c25naU5JbWVoOFE2eldBUnhZ?=
 =?utf-8?B?R0lISkxIblNKYkpjS0VxdjhLWENka2x3WHdseWZjNjFVMUxoMzFrY1hERldQ?=
 =?utf-8?B?NWpjMk42dkY5TzQ1TUxzWlpyTWM5aXhtd1o4Zjg0amxuWnBOQ01IUTFMdUIx?=
 =?utf-8?B?cU1kNmFzODdXa2JHUC9SYW1ZcVdJU2txM1dSZlZFbmFqRVRqaDJGcEVXV1lM?=
 =?utf-8?B?V05BV1ZBdjdIMkRJUlhtOWVQUkk2REhZT2lkYTV4QStRWkVuQUxjakhTYnhq?=
 =?utf-8?B?YTdITGd4RUNlK29yWmNxdEtVcWhObjRXTWxxRUVLMk9BZE80d0lTM3NXSm0w?=
 =?utf-8?B?UWo4Yk5lcEZTUGVqYWhvRHhPZ1RnaEZWMVZDWDFpUnZ6UTREUTZRUnl3RGZk?=
 =?utf-8?B?Z3ViLzRRWWVvUWhaaWpzcmpzbDZHYTgxY2RObmFJM25BRGhISDFwcUFldHVE?=
 =?utf-8?B?ZFFvcURHbFdHUytWQ0xJbFhtUGtINmYvemcrcEhTQU1QWG9XeUpWWFdzVnpH?=
 =?utf-8?B?eDI0UU9XMzNHNmI2QXdLTmRiZmVBV2pOTG9aeGlJU3hLNEEzRGVnbDhjbVRz?=
 =?utf-8?B?YkxlYVk2aURsTHNPMTB6d20waW5wM0RXM2EvdThCSHd5VzZGNEo1YVBONGla?=
 =?utf-8?B?eDdRVDdWOFZwQ01uRGgxUEJhREk5TVZ2VVF4QmoyRnd2SWxoVWIyeDVadE85?=
 =?utf-8?B?QTBwQkE1cEt6TmJwZytZZ0VVR1JzRk9pY1ZweXp3V1kvUjB0UVVVOVd2ekcr?=
 =?utf-8?B?b21tQTMvVzFNSW9pcTJQN29MbWZ3UVRFdUlyeUlVRFZDblYxRy9Sc2VYQ05O?=
 =?utf-8?B?ZnU5UDFJL3d2YTMwTisxdWxhR3BWbXNKa290OVBZVC9EQ2ZWTUtVS0JQQzB4?=
 =?utf-8?B?KzVENzFpcGY2dmVtdWIyczYzTHZPTjUwb3ZYcnJOK1Uyc2NlMUVGOUFBNWd2?=
 =?utf-8?B?dUROMS9QaWZPekFud1orQWptM3hVTm1uKzExbzl0TlBMZnl1Q0JWZ3hMbTdX?=
 =?utf-8?B?NVBYODJ0UHlmbUc4VitWT3lxUldOUGhpdHZLdFczelpYR293aTg0SkpPUGFr?=
 =?utf-8?B?WDFFbEUzT3FGbEs1bXRnRkNiSUZtQmlGYjRvZ2VydlZYbGt5a3I0QWJEeDFP?=
 =?utf-8?B?RHJMVFFXM0pQRlB5NkxNT21yL3NDQzNMb1lrakdrckNkanpxMWFGdkgybnhB?=
 =?utf-8?B?RStKdXlkM3hpUmlCUnRrVG1MMWc2V3BhTkpveU5hbmcvcW9FTER3czlqLzhO?=
 =?utf-8?B?SEhqUWhObndLTmhubE9pSDhGamt5TkhHRlJHNVdMM2t5bU9WeGhHSzcyRDl2?=
 =?utf-8?Q?312NspZNYVB7Pe+WGPItjC5y3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e60ebe-d0dc-4cda-aaea-08de0a28d8e8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:19:28.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQ5XI4PXpNMdkFuH0Z3hPaLrkrF7h7QZsnkMhXwBKKW4m00uwS8N5xlVtqgQXByMsyECUl1UYnP2JbgPpbZEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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


On 10/13/2025 12:42 PM, Christian König wrote:
> On 10.10.25 16:07, Sunil Khatri wrote:
>> At times we need a bo reference for hmm and for that add
>> a new struct amdgpu_hmm_range which will hold an optional
>> bo member and hmm_range.
>>
>> Use amdgpu_hmm_range instead of hmm_range and let the bo
>> as an optional argument for the caller if they want to
>> the bo reference to be taken or they want to handle that
>> explicitly.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  6 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 36 +++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       | 19 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  1 -
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |  1 -
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 14 ++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  1 -
>>   13 files changed, 61 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 9e120c934cc1..8bdfcde2029b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -71,7 +71,7 @@ struct kgd_mem {
>>   	struct mutex lock;
>>   	struct amdgpu_bo *bo;
>>   	struct dma_buf *dmabuf;
>> -	struct hmm_range *range;
>> +	struct amdgpu_hmm_range *range;
>>   	struct list_head attachments;
>>   	/* protected by amdkfd_process_info.lock */
>>   	struct list_head validate_list;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 22c1bdc53d2e..56097fb6eecd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1057,7 +1057,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>>   	struct amdkfd_process_info *process_info = mem->process_info;
>>   	struct amdgpu_bo *bo = mem->bo;
>>   	struct ttm_operation_ctx ctx = { true, false };
>> -	struct hmm_range *range;
>> +	struct amdgpu_hmm_range *range;
>>   	int ret = 0;
>>   
>>   	mutex_lock(&process_info->lock);
>> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>>   		return 0;
>>   	}
>>   
>> -	range = amdgpu_hmm_range_alloc();
>> +	range = amdgpu_hmm_range_alloc(NULL);
>>   	if (unlikely(!range)) {
>>   		ret = -ENOMEM;
>>   		goto unregister_out;
>> @@ -2574,7 +2574,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>>   			}
>>   		}
>>   
>> -		mem->range = amdgpu_hmm_range_alloc();
>> +		mem->range = amdgpu_hmm_range_alloc(NULL);
>>   		if (unlikely(!mem->range))
>>   			return -ENOMEM;
>>   		/* Get updated user pages */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> index a716c9886c74..2b5e7c46a39d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> @@ -38,7 +38,7 @@ struct amdgpu_bo_list_entry {
>>   	struct amdgpu_bo		*bo;
>>   	struct amdgpu_bo_va		*bo_va;
>>   	uint32_t			priority;
>> -	struct hmm_range		*range;
>> +	struct amdgpu_hmm_range		*range;
>>   	bool				user_invalidated;
>>   };
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 087e5b5497e4..87872c0282e4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -29,7 +29,6 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/sync_file.h>
>>   #include <linux/dma-buf.h>
>> -#include <linux/hmm.h>
>>   
>>   #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_syncobj.h>
>> @@ -886,7 +885,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		bool userpage_invalidated = false;
>>   		struct amdgpu_bo *bo = e->bo;
>>   
>> -		e->range = amdgpu_hmm_range_alloc();
>> +		e->range = amdgpu_hmm_range_alloc(NULL);
>>   		if (unlikely(!e->range))
>>   			return -ENOMEM;
>>   
>> @@ -895,7 +894,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   			goto out_free_user_pages;
>>   
>>   		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
>> -			if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
>> +			if (bo->tbo.ttm->pages[i] !=
>> +				hmm_pfn_to_page(e->range->hmm_range.hmm_pfns[i])) {
>>   				userpage_invalidated = true;
>>   				break;
>>   			}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 82ddc8c22b64..ce073e894584 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -530,7 +530,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>   	struct drm_amdgpu_gem_userptr *args = data;
>>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>   	struct drm_gem_object *gobj;
>> -	struct hmm_range *range;
>> +	struct amdgpu_hmm_range *range;
>>   	struct amdgpu_bo *bo;
>>   	uint32_t handle;
>>   	int r;
>> @@ -571,7 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>   		goto release_object;
>>   
>>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>> -		range = amdgpu_hmm_range_alloc();
>> +		range = amdgpu_hmm_range_alloc(NULL);
>>   		if (unlikely(!range))
>>   			return -ENOMEM;
>>   		r = amdgpu_ttm_tt_get_user_pages(bo, range);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index b582fd217bd0..9da1c5c69632 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -168,12 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   			       uint64_t start, uint64_t npages, bool readonly,
>>   			       void *owner,
>> -			       struct hmm_range *hmm_range)
>> +			       struct amdgpu_hmm_range *range)
>>   {
>>   	unsigned long end;
>>   	unsigned long timeout;
>>   	unsigned long *pfns;
>>   	int r = 0;
>> +	struct hmm_range *hmm_range = &range->hmm_range;
>>   
>>   	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>   	if (unlikely(!pfns)) {
>> @@ -226,25 +227,38 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   	return r;
>>   }
>>   
>> -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>   {
>> -	if (!hmm_range)
>> +	if (!range)
>>   		return false;
>>   
>> -	return !mmu_interval_read_retry(hmm_range->notifier,
>> -					hmm_range->notifier_seq);
>> +	return !mmu_interval_read_retry(range->hmm_range.notifier,
>> +					range->hmm_range.notifier_seq);
>>   }
>>   
>> -struct hmm_range *amdgpu_hmm_range_alloc(void)
>> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>   {
>> -	return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
>> +	struct amdgpu_hmm_range *range;
>> +
>> +	range = kzalloc(sizeof(struct amdgpu_hmm_range), GFP_KERNEL);
>> +	if (!range)
>> +		return NULL;
>> +
>> +	if (bo)
>> +		range->bo = amdgpu_bo_ref(bo);
> The functions amdgpu_bo_ref() and ...
>
>> +
>> +	return range;
>>   }
>>   
>> -void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
>> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>   {
>> -	if (!hmm_range)
>> +	if (!range)
>>   		return;
>>   
>> -	kvfree(hmm_range->hmm_pfns);
>> -	kfree(hmm_range);
>> +	kvfree(range->hmm_range.hmm_pfns);
>> +
>> +	if (range->bo)
>> +		amdgpu_bo_unref(&range->bo);
> ... amdgpu_bo_unref() have intergrated NULL checks. So checking it here is superflous.
Sure will do that.
>
> It would also be helpful to have some kerneldoc on amdgpu_hmm_range_alloc() and amdgpu_hmm_range_free(), but that is not a must have.

I guess that will be in a new patch set. will see how it is done and if 
i can use and existing one to update that.

Regards
Sunil Khatri

>
> With that fixed the patch is Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Regards,
> Christian.
>
>> +
>> +	kfree(range);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> index e85f912b8938..140bc9cd57b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> @@ -31,15 +31,20 @@
>>   #include <linux/interval_tree.h>
>>   #include <linux/mmu_notifier.h>
>>   
>> +struct amdgpu_hmm_range {
>> +	struct hmm_range hmm_range;
>> +	struct amdgpu_bo *bo;
>> +};
>> +
>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   			       uint64_t start, uint64_t npages, bool readonly,
>>   			       void *owner,
>> -			       struct hmm_range *hmm_range);
>> +			       struct amdgpu_hmm_range *range);
>>   
>>   #if defined(CONFIG_HMM_MIRROR)
>> -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
>> -struct hmm_range *amdgpu_hmm_range_alloc(void);
>> -void amdgpu_hmm_range_free(struct hmm_range *hmm_range);
>> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
>> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
>> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>>   int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>>   void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
>>   #else
>> @@ -52,17 +57,17 @@ static inline int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>>   
>>   static inline void amdgpu_hmm_unregister(struct amdgpu_bo *bo) {}
>>   
>> -static inline bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>> +static inline bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>   {
>>   	return false;
>>   }
>>   
>> -static inline struct hmm_range *amdgpu_hmm_range_alloc(void)
>> +static inline struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>   {
>>   	return NULL;
>>   }
>>   
>> -static inline void amdgpu_hmm_range_free(struct hmm_range *hmm_range) {}
>> +static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range) {}
>>   #endif
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 96bd0185f936..fd00ec7c99a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -709,7 +709,7 @@ struct amdgpu_ttm_tt {
>>    * that range is a valid memory and it is freed too.
>>    */
>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -				 struct hmm_range *range)
>> +				 struct amdgpu_hmm_range *range)
>>   {
>>   	struct ttm_tt *ttm = bo->tbo.ttm;
>>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> @@ -762,12 +762,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>    * that backs user memory and will ultimately be mapped into the device
>>    * address space.
>>    */
>> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
>> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range)
>>   {
>>   	unsigned long i;
>>   
>>   	for (i = 0; i < ttm->num_pages; ++i)
>> -		ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_pfns[i]) : NULL;
>> +		ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_range.hmm_pfns[i]) : NULL;
>>   }
>>   
>>   /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 99c46821b961..0ebb99e8d792 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -28,6 +28,7 @@
>>   #include <drm/gpu_scheduler.h>
>>   #include <drm/ttm/ttm_placement.h>
>>   #include "amdgpu_vram_mgr.h"
>> +#include "amdgpu_hmm.h"
>>   
>>   #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
>>   #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>> @@ -191,16 +192,16 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -				 struct hmm_range *range);
>> +				 struct amdgpu_hmm_range *range);
>>   #else
>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -					       struct hmm_range *range)
>> +					       struct amdgpu_hmm_range *range)
>>   {
>>   	return -EPERM;
>>   }
>>   #endif
>>   
>> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
>> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range);
>>   int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>>   			      uint64_t *user_addr);
>>   int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index d10c6673f4de..3653c563ee9a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -21,7 +21,6 @@
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>>   #include <linux/types.h>
>> -#include <linux/hmm.h>
>>   #include <linux/dma-direction.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/migrate.h>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> index 2eebf67f9c2c..2b7fd442d29c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> @@ -31,7 +31,6 @@
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>>   #include <linux/sched/mm.h>
>> -#include <linux/hmm.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_svm.h"
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 91609dd5730f..f041643308ca 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1698,7 +1698,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   	start = map_start << PAGE_SHIFT;
>>   	end = (map_last + 1) << PAGE_SHIFT;
>>   	for (addr = start; !r && addr < end; ) {
>> -		struct hmm_range *hmm_range = NULL;
>> +		struct amdgpu_hmm_range *range = NULL;
>>   		unsigned long map_start_vma;
>>   		unsigned long map_last_vma;
>>   		struct vm_area_struct *vma;
>> @@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   			}
>>   
>>   			WRITE_ONCE(p->svms.faulting_task, current);
>> -			hmm_range = amdgpu_hmm_range_alloc();
>> +			range = amdgpu_hmm_range_alloc(NULL);
>>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>   						       readonly, owner,
>> -						       hmm_range);
>> +						       range);
>>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>>   			if (r) {
>> -				amdgpu_hmm_range_free(hmm_range);
>> +				amdgpu_hmm_range_free(range);
>>   				pr_debug("failed %d to get svm range pages\n", r);
>>   			}
>>   		} else {
>> @@ -1753,7 +1753,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		if (!r) {
>>   			offset = (addr >> PAGE_SHIFT) - prange->start;
>>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>> -					      hmm_range->hmm_pfns);
>> +					      range->hmm_range.hmm_pfns);
>>   			if (r)
>>   				pr_debug("failed %d to dma map range\n", r);
>>   		}
>> @@ -1764,12 +1764,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		 * Overrride return value to TRY AGAIN only if prior returns
>>   		 * were successful
>>   		 */
>> -		if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
>> +		if (range && !amdgpu_hmm_range_valid(range) && !r) {
>>   			pr_debug("hmm update the range, need validate again\n");
>>   			r = -EAGAIN;
>>   		}
>>   		/* Free the hmm range */
>> -		amdgpu_hmm_range_free(hmm_range);
>> +		amdgpu_hmm_range_free(range);
>>   
>>   
>>   		if (!r && !list_empty(&prange->child_list)) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 01c7a4877904..a63dfc95b602 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -31,7 +31,6 @@
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>>   #include <linux/sched/mm.h>
>> -#include <linux/hmm.h>
>>   #include "amdgpu.h"
>>   #include "kfd_priv.h"
>>   
