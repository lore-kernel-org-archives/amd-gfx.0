Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45167C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 12:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA1910E760;
	Wed,  6 Aug 2025 12:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QCxpi5Hz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B303310E764
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 12:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa75qpNYsAX0Vi8UA65JZq/NI7YmWG/h/0jshRvmFnRhQEUTdOJLNmwI2kzZz76MoFHbgskW0sychAHmm7Icp4iGZKgGo4dRlZgDYJWwkW3dZLZz7wfZGZ+IIo7ii4vTa++Gv3OLXxfffEjBSOBSbOP0xERAJhtB4F0GKcSody1wP+CQ1nDz+SwuUnk6SeD3q6h8PgCr8mHh7bxDKLAXJ0ftGjWVvfLjevEQMNbutiQE49U/1Q8wLur5Jr+wFxNss7X1O4JUzYAHZWteL+6EhOXHrFinagFIJ5b/0vkqPd5ylvMo3x4wyiXsnSTuLI6Yf+TWKAR/lW0zWbCdCngjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNaXK0gcPr2JmQXYCVjTNkUnN8MCSu+JgXg3ZkUu1AM=;
 b=uwCprzzekGBXxnsfQv092yBSQN9emXsZKJpHqGVADms4e24qEPXYmC8QL1fOKQgG4Gw3sGHyJPF6G0+JhUa9JyIcGjelOH3cnXxEMD8O6g1imrmmszZ8baoOG5gRh0OHo39prMZIl+t6cHpwqRrqFXAjDADNMTyR0Fy89G+2E/ib97I/snboSk9u5ao4o2vdVSK4xK/mtEVKyvbhfERmLumxm1si1hllttGK2hxZftB5mEjSXqZUpvJVWySw0XxXMBSwDgH+RtHGrut7eE7bR1UZ0dlr6C4QQrfqM6ZJiOHTHZo6ZUy+m4EUJxdutDB0jBUPV0mveGBUi5oWiFcNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNaXK0gcPr2JmQXYCVjTNkUnN8MCSu+JgXg3ZkUu1AM=;
 b=QCxpi5Hzzptu4NvDnewDypNKcWxIomtduu0sRqsNpwwpHEZXM2X0PUYO8xksJvebYKaUb0ZdBYp0bCznKqkiSaHE+yn39+vxQyQ61pNGHj2jXjYt7c+7k+kgFf/57tSuUSwcCm6ESJah/QrFdDd8l1wHXd4+w1z8IHnKdAWjDlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 12:27:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 12:27:23 +0000
Message-ID: <79bb0b1f-687c-4f6f-8a3e-728e8d0c8800@amd.com>
Date: Wed, 6 Aug 2025 14:27:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
 <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
 <99761dc3-7814-42be-8d08-c8ff7b2a76cf@amd.com>
 <8baae4b5b5af6078a27c8a20202fa1b660fc8aef.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8baae4b5b5af6078a27c8a20202fa1b660fc8aef.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d86a1e6-cae1-4ae3-dbc6-08ddd4e498bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R00xMDF5YXgzc0w3T2NvM08wSEhwRXd3eTlCZGJkYXNPTGJnUG8vTDFqb1ZU?=
 =?utf-8?B?NG04SXJSSC9PYWJmVC9tQkpoelVsY2dseElucmt0SnJvalZrUHpmYm9ET0xN?=
 =?utf-8?B?UnpDV0E1dFF6NTlaMGJ1RXVIbS8vSTRRdFpkUEUrVVRIOThrb2RlcENYYkhR?=
 =?utf-8?B?RFF3TUVtRWtMcUxydWZpTmtlZHh5TFNSN1NtZXA4dmR0SnlxR2xGM3E4MnRZ?=
 =?utf-8?B?SndhdXk2NUVCeGtCM2hDQjh5TFZSdkZtYm15NitqN2JJRUo2YnBOZE1SLzVL?=
 =?utf-8?B?UTY0Vk50S2VSSGRBUnROa3d3eTVWeVgrOTZkb3gzV3hQTkI3cjdTd2R0Nkl3?=
 =?utf-8?B?VGd4VjNqQVZxSmtiaGJHUi8wbnFUNkcwaEZrNUJ4bVdXVFdYd3M2OUJ1dkpJ?=
 =?utf-8?B?Z1NMYmlONnNNeUlRUFlzaG50TjMwMWpzK2hCRjBLL0ZJQk00d3JvS2NvdVlE?=
 =?utf-8?B?b1FkeWlST3JaMDhXMFZCQnUxQmV6Nnl1b0lPbEZXWlhvRXRmM2xRSURMYVZT?=
 =?utf-8?B?TnQzSFFnS1VxMUpzMkg0MHRoMS9CYlZwNngwUVlGRzZtbXFGeVB1cUxSa0JD?=
 =?utf-8?B?RGZtYnV1T0tUWVIrQzduMHUwejVNRUtzSXNsc2NYY3FDRFcwTVB6NjBTTWR3?=
 =?utf-8?B?dDY4NWdlMkFmeUM1REVZMUU0aFlwdGFtVXU5Z2U3d0o1VVVOM1Zra0wyZ0N3?=
 =?utf-8?B?eTZhTWFjd3ZxNG5VYmdJWlJxWkxVZXZ6MnZUSU45dU1nSi92UERCd0d2UUFz?=
 =?utf-8?B?WU5PeHFzZWpJUVdGdk1tM0c1cjF1Rk9Mb0tnamFqZlZ2bGZmSUN2VU5wMWRF?=
 =?utf-8?B?K0lmRE84V2dscklXMDRPV2RKWHFBM0xSQ3JDbjRNS056NW5RK20raUIyK1Nj?=
 =?utf-8?B?cWUya1Q4Q01obEgrRFk4bldFU3ZGM2pKTlpPbk91cTJHOXp4N1JwOHFScUZy?=
 =?utf-8?B?d0RNNVk2SVVMbS9UR3BjazQ2WFlaNEZ6QVh3TlVvYjVEWHNJRlB2U3lFdTUw?=
 =?utf-8?B?RHFFVUthdksrN3pMMVZtQ0ZieEhrU0o0QUsvR2o4a2RUa1R4RFJ1S2FtVjJB?=
 =?utf-8?B?SHNDdStiKzVDbjQ2Mk1GaWNKRlpxNmVKWm1ka1ZLbEtMU1dBYStqaWVzeWZP?=
 =?utf-8?B?VHdIc0FrUERKTVpDWHpNNDZYb1ZwWThwK0lpRWZTUldZeDRlWVcxandLRzhF?=
 =?utf-8?B?MHdaQ2xFVGNseU8xaE1iMWVxRmkxeXFHMVIvajlmaWk3dkJ3bDBFM1JvWEds?=
 =?utf-8?B?R1ptb3FKc3hWWDJaeDNiTklrZ2Q4M1FSQmxvZHd3NThjK1hPNUsyUlIvU0Zy?=
 =?utf-8?B?K0IrclpjYndiMkhpeDR5TkZsSlhGd1UzRGdYdXROMGdMWXBFNVRaUHVBZkpR?=
 =?utf-8?B?Z0RGZytrRWtDTWQ3eXQyd3U4c280dTBtSU81NVFEUkkvbVh4cFE5Znh1dzl1?=
 =?utf-8?B?NEdXc25JV3M0ZFBIMTZldy9BZ2YwQ2lwdXdxSXNGL0d2dkxKelZWdEpYQVJW?=
 =?utf-8?B?V2Y2bDFsT2JpdzdBbnJGZ0ZXREh4bjlIK1VoMGRlVm54ZEg0b2FyTkJzQ0lL?=
 =?utf-8?B?REkybXd6V0ZsWllHZ20rS1U2QXcvN1Zsa01QVUgwcmczTFBRNEVjQUhSTGJo?=
 =?utf-8?B?Q1dVakszMXFtT3BuNzhmN0ZGME12NEpRSWRuM3A0MzlwbkhiWmhpazhBeTdZ?=
 =?utf-8?B?WENPTmpFNUpTWHdXYjJHSjhGM0E2dzFtNlFvR1Y1MnVzYVI2QlFPbzh5cE1I?=
 =?utf-8?B?L3VCYW94WENlOHVWTHdrODQ0NWxBUUxDbEVESUhrU3hMMXVvNXNMb0RYMjNZ?=
 =?utf-8?B?bEtjTldZM2xQUDcvZDU1ajRoUml6eGxUZlRJMklTekxJc2xJRmUvY0VSMEFL?=
 =?utf-8?B?WU5Oby85ZmZOMjZqM1ZYSDN1SzVGZ2VZVW94ZkFkSXFMUzI1VzJSQ0dOaDJv?=
 =?utf-8?Q?5TppKe+a0Uo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FmeGdIS1UwR1M4Sno3a2ErOUlhZnhKSmZFcWY5Z05sM0loa3FId0pWdklB?=
 =?utf-8?B?UzRtVi91MUFWTUVjM2hKY005cjdPRllpTmdHbTR4dXBzYjAxSTVTOWR0U3BF?=
 =?utf-8?B?eFlSWXNXVjFiN3RpdGt0bXhNYTFlc1NVZGZneDZHKzJCdjgwZWptd2lHb096?=
 =?utf-8?B?RTNEQ3FJcEwrYlFia2Q5ZmV1QVlPZXo1bUtPWnVzdDg1aTUxQ29rcHM3eGxR?=
 =?utf-8?B?YjRRY3IxUG1ETlg0dlc4RUpQbVpjbWZWemVMaE1tU1FURmEvTVhQZ1E4UVlk?=
 =?utf-8?B?VVU5RGx6N0NQWmdha2tFaVpXK1YvYVA4a2cwNTJKV3l6RjE4bUFyQ1l3T3M5?=
 =?utf-8?B?dWs0ZWJackg1L1UwQXBESkZYaTU1MkF1a0pMZ1l1cnlDcjZTYUZWcVduVlZy?=
 =?utf-8?B?QTN5eXZXbzBldzdDdDdtUFY5Mk9mTWJPb1VhTXZzdEI5MDJWQzVPL1hhYWtI?=
 =?utf-8?B?UzVkVnkzRml2SGtkWHBxN1N4QWxyYlZvZmNnZXFiaWkraTh1cS9sd3NmVTYw?=
 =?utf-8?B?WXREVjZqck1QUGlpTmh3QitJWXp2akk5Tks3blU4ODl4bE01ZjlOaytHYldx?=
 =?utf-8?B?eEhHM3BIdmNOK0JrQ3RJMW9xTlJueUpycm9tdkxhTm5VYk5oVUxNV2p6OTdY?=
 =?utf-8?B?SWszZE1OcDRuQStTN0Q3L1U3NXdBZnlMWlZxQkFqQjcrUm5TWGRKQ2xYR0NP?=
 =?utf-8?B?bW9CZUdQeGVpWjhMaE4vOE1uSDdjaHBFSkpaaW9mbytzZnFOZzZHdXRFNXNi?=
 =?utf-8?B?UjBaWE5UekpkNys3VC9ON2VLbWJvTG85REJGOVE1Z1VkWnc4U3VNMTBaQTha?=
 =?utf-8?B?akYyK0JHYlBPc2Z5ME9NeWF0bVB5ZnZWM01wZEwzMWlmL1pBR05RTU9hZSsr?=
 =?utf-8?B?RkM0SzN6b1JKTjh2cU16ZWhKTEtpOEF6d3N1Yzh2d0hzeUVnWlYyUEJ2LzN4?=
 =?utf-8?B?c1BJeWRpZWRqQW9LTGU1cTBvZmFCR1BPaWZpSWJ4a3pxbEw0SVltTjRkS3px?=
 =?utf-8?B?aHRnVWtKTjRDZlExYzBKMG5aK3FBQlF0d2lTVmlCZ01UUEVDOUNkUEhMWStx?=
 =?utf-8?B?SGE3WkhReFlmK252QVhJZUdtSVdxc0lZL1RZb0w0cGp4cmxaTDhDdlZmYWta?=
 =?utf-8?B?R2FGSHFKM3BNMHBNRUhhU3g1T3FWdjVOaVRad2tvVGZHU3ZibU04VlhzaWYx?=
 =?utf-8?B?OGRVOU1mbUljbjJaNy9xRHhlRHBGeXpDY1Nubld2YUIvY1FPQ1ZEaGQ5Z0Uz?=
 =?utf-8?B?TDhzYWJmWTZWbVlZaFdlZUk0akpacVVFQkZMV2VwN0pjY21MOU5TN2VsS21h?=
 =?utf-8?B?c0YwU1gvaHAzRmlPYlVEK3lWUFo0a3E5d2VaVlRzSVlnUlU2ZDlQbjJ6RmFS?=
 =?utf-8?B?d2pna2UvQ2ZQYXBxTzZ1UENjQmdiZkVEUkpvbGNEVlZKQzhQV3dVekx1QUxo?=
 =?utf-8?B?aUZ1RXFKaGtPNDUwcU55ZzdZRW9vbEhkVldocFNuSlIxVEUrRzJrdk81S3NH?=
 =?utf-8?B?cXA3N2xzYlFaQU5JZ1JTcEFjRFdsdFdLeUR3am14dEE1ckJOanYrMk9jTVJQ?=
 =?utf-8?B?M1ZvU25MQTJGRmQ3enkxSDRmd0p3TEZZYnVOTnN1VitmSklxZzd3aHBxdGtY?=
 =?utf-8?B?NEtHL3ZjN2FHODY4d1JmMlJZbmREb242SDdlSHVhdE0wem9scU1MTk5pZm9J?=
 =?utf-8?B?Z2tYd0pmNHk4bU5TRERyMDhxeFBObTF4QmhXTW11dGZnSnJaWmIvRlN1ZDFr?=
 =?utf-8?B?eGJ1YXdvNGE0bjk1VEZHR3BsajhFbmJVVFhqUU1iS3dsOE54TWlVODFhMDY1?=
 =?utf-8?B?R3UxSmxLTDhGM1R5L0JxR3lBVHpLQ1grUi9UMUVFMkVlTzVYOEJrUWY4bVdG?=
 =?utf-8?B?bm1YYS95Zll3ekNYRUNXZTJYTmUyWGFPZ0VaM3k5SnhuUmpHVVFvQ2pLZVAv?=
 =?utf-8?B?REVSaFBud2c4Smx6aVpIUHF4WHNUUWZ5cVlDNzl5ZDZTMnBURjZOb0R2SlYy?=
 =?utf-8?B?VXNGMXdvZDhiaWFzRGEyVlBnNStpdkhQRS9sWE4xUVRBajdsWTZEWlpFaEEy?=
 =?utf-8?B?NHBjR05lZFlkOHhwUGJFa3FnZ3R1N0hqNkdBckVYVWRwcmFRaXBhR2tNTkNm?=
 =?utf-8?Q?tDRejt1K4dZxMUGFFFtrTa/zF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d86a1e6-cae1-4ae3-dbc6-08ddd4e498bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:27:23.8308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg78nZQa0QrwSslt4bRDO4AXunjrq3B5gjfby9jhPF1efaRYhwcxA41rIVkuFIVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

On 06.08.25 02:35, Timur Kristóf wrote:
>>
>>>>>
>>>>> Alex
>>>>
>>>> Hi,
>>>>
>>>> These are my observations about how the UVD clock works on SI:
>>>>
>>>> 1. It seems that the SMC needs to know whether UVD is enabled or
>>>> not,
>>>> and the UVD clocks are included as part of the power states. See:
>>>> si_convert_power_state_to_smc
>>>> si_convert_power_level_to_smc
>>
>> Correct, yes. The design was that either the KMD or the SMC could
>> program the PLLs.
>>
>>>>
>>>> On SI the default power state doesn't set the UVD clocks,
>>>> and SI has a specific power state to be used with UVD. Actually
>>>> amdgpu_dpm_enable_uvd has a special case code path for SI, where
>>>> it
>>>> sets this power state. If I print the power states from
>>>> si_parse_power_table, it indeed confirms that there is only one
>>>> power
>>>> state that has non-zero UVD clocks, and the rest of them just
>>>> have the
>>>> UVD clocks at zero.
>>>>
>>>> It's unclear to me what happens if we try to enable UVD clocks
>>>> when we
>>>> selected a power state that doesn't include them (ie. when we
>>>> don't
>>>> tell the SMC that UVD is active).
>>
>> IIRC there were two possibilities.
>>
>> Either you let the SMC handle the clocks in which case it would lower
>> the GFX clock in favor of stable UVD clocks.
>>
>> Or the KMD would lock the SMC to the highest level and then program
>> the UVD clocks manually.
> 
> As far as I see the si_dpm code does a mixture of the above two.
> When UVD is enabled, it selects the VBIOS-provided UVD power state and
> then it manually enables the UVD clocks to the value provided by the
> VBIOS.
> 
> When the UVD ring is not used anymore, it then shuts the UVD clock down
> manually.
> 
> (I assume then it goes back to a normal power state but I haven't
> actually verified that.)
> 
>>
>> The later was not really validated but requested by a lot of people
>> because otherwise you got a GFX performance reduction whenever you
>> used UVD.
> 
> Yes, the UVD power state from the VBIOS indeed has lower shader clocks
> compared to the normal power state.
> 
>>
>>>>
>>>> 2. When setting a power state that enables UVD, the UVD clock is
>>>> enabled either before or after the engine clock by si_dpm. This
>>>> is done
>>>> so in both radeon and amdgpu, see:
>>>> si_dpm_set_power_state
>>>> ni_set_uvd_clock_before_set_eng_clock
>>>> ni_set_uvd_clock_after_set_eng_clock
>>>>
>>>> The specific sequence in which the UVD clock is enabled by
>>>> si_dpm_set_power_state leads me to the conclusion that
>>>> amdgpu_asic_set_uvd_clocks should not be directly called on SI
>>>> outside
>>>> of the DPM code.
>>>>
>>>> Please correct me if I misunderstood the code.
>>
>> That sounds correct to me.
> 
> Thanks!
> 
> Sounds like the patch is correct, then.

Most likely yes.

> 
>>
>>>
>>> Yeah, I don't remember the clock dependencies.  I thought that you
>>> should be able to program the UVD PLLs any time you wanted and the
>>> ordering only mattered when you were also changing the sclk.
>>> Programming the PLLs directly works as is in radeon, but I guess
>>> maybe
>>> we init DPM in a different order in radeon vs amdgpu.
>>>
>>> It would also probably be a good idea to disable the UVD clocks
>>> again
>>> after IP init to save power. E.g., something like:
>>>
>>>        if (adev->pm.dpm_enabled)
>>>                amdgpu_dpm_enable_uvd(adev, false);
>>>        else
>>>                amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>>
>> IIRC we always disabled the PLL manually when UVD was unused because
>> the SMC sometimes failed to do this.
> 
> 
> Yes, as I mentioned in my previous mail the PM code does that already
> when the UVD ring is not in use anymore. So it's not necessary to add
> any code to shut it down.
> 
> Maybe I should edit the commit to explain that in a comment?

Code comment please!

That's basically the only chance we have to keep the knowledge why we did something the way we do it for the old HW generations around.

Regards,
Christian.

> 
> Thanks,
> Timur
> 
