Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF8EC3ABDD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 22:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C8E10E96E;
	Thu, 15 May 2025 22:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B58AH14P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E41810E97D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 22:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETQVy/jCzHCLsII1RMqcDdZEgQKyM2LkwfQiPGk8hNET2sZ4IIwvRJYiC9sWWaQVEtg2WBrzobWR7xmiICoKtdL5dEXrvwTWyiGoI81Uv1pUJJkkR3qJ0yFFrZIleys1Oclk0Y9jKedMkRpTo4ikEzIJv2tiZtnJ5FJbapROqScIbmJY+AtdkdQqhrsPdEHCdsOalcotxicqF6UPGkizsEVZvpBgIKGoMkDp9yv9Ddr5MaFImVgXrA150m3O0U+JhQCFWXFEKqnn0/Shljgdaf9IPa9vA9WO1/nr2vxKJScQwNXHGYE8QW8SdTgrnXBxoIcdD7UM+ycmuxOkD2Nkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOXr1elbRoTkGFnpb+Egq5AxbtSPaNobu3GyzDNSB9Q=;
 b=pNyZuT+AeGcqPEzCwoOj8WmoHvng+1SuIn0L+n6XHDPYo/jKcjXIjRWlElGssceZJKqJX4n4OR7cd8tEgwcI281VzhR8PlQiRD0Kc6LkeZ2MAh9yUe4o9O9kDZpOz8gmoLWUz5DpiG/NHCcoSNH4weJYD2Pd2k60guRrXkbu2VgymzDzpiBkbb4P67+w2JmvgBhTXIp+N44ranh76HDb9n82jBai4bKG6uMAG0yz9TXFSaJIhV8NHv0t85XHPOw6pShYSFJsdPZvum5DdO1gOqJNh/osZwWTenz8iIA7DOKQDTo7RnqqAsSJHy/MLZEZHZBJv1DuLz27L/Qs1r2g/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOXr1elbRoTkGFnpb+Egq5AxbtSPaNobu3GyzDNSB9Q=;
 b=B58AH14PYV9f5ddsMakqnq1YIOVWFJMAkjYeuIRbGQ1VdFyOAvOUhdog9BrgFIFfS0reuplvKjGeH9x3r51hni/pkJvoP+5RmwIHzy6JnVBgu9rGMicgBJ0zAvc47cjIBSHoKfnnFHE8Uwk/x+0LGHkOdgtFQCfFUmr669wBGBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 22:02:41 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 22:02:41 +0000
Message-ID: <ea83c4a9-fcce-4179-acc8-dfe87aeac51d@amd.com>
Date: Thu, 15 May 2025 18:02:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amd/amdgpu: Add GPIO resources required for amdisp
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250515195504.1099467-1-pratap.nirujogi@amd.com>
 <293be6eb-6b48-4433-8137-576732f0bef3@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <293be6eb-6b48-4433-8137-576732f0bef3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0061.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::15) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: a83171ff-fb6a-45ac-d77f-08dd93fc3684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yzg1dDhKOXpBV1JHSFJPaVFhSS9MQ1h6ZEREdmhDbnZ2YTkxNXRwVjFwT05z?=
 =?utf-8?B?L0pEZC9ZdE8xV2dEUzltclJvbFFPOW0zVjdQVmRTMEN0SS9KdmdPNmE2T0RY?=
 =?utf-8?B?Z29lMnV3cWlXYkMvcS9aRzN4SEd0NjVsM2lqRnRQaVJOcHpwOGVTOGZNVlRi?=
 =?utf-8?B?Nk44d2prS1VUNXVrK0NOYjNyM013TFhsaFdjUjFrZ0I5ZERrQ0hUMFlPQXI4?=
 =?utf-8?B?QWIwZ1pNMVpRYUgrMzdCejNtZjJyVDNqZklib0JiMnlrbTFhODkxT2xabWor?=
 =?utf-8?B?dHd3QjVwczllTU9Zc1hSN0NKYXpDZkVxTXNGNnBsUkx0elZOR2JJNnB3ZFBI?=
 =?utf-8?B?WldZUDVHc0NPaE10QTJGN011YWpuWGpVbkxsN2ZYbFhBTWVhb3FRckRjbmhq?=
 =?utf-8?B?aUEyV1NSYzhXdlJINlA1ODdzbFc2MFd5YTJEbUxNTzlvOFBUcU5YT0hOZzdm?=
 =?utf-8?B?WktPdFdCMGluM3FsSFJsZXdROWxaQW9STE5Xam9taGxFa2taY2NsVU1vWjBq?=
 =?utf-8?B?Zk80a2J5eGREYUlyYzYwaCtvbW16eE4zdDE4MCtvSnhETVFFajZreEZHRTFU?=
 =?utf-8?B?cHlUY2F4bXlxdzhPaUk3UUJla0d1R2lHUWZTeWU0aUJsbjRIMUx6TWZ0VXQr?=
 =?utf-8?B?L2FUNmhWRHhwYUVXYUtNQk5pTE9hdnlHMi9tZDVoejJkcGxyYlRXOUJZajQv?=
 =?utf-8?B?UG0reFQ4SE5MVmJ6K1hqbGdwdG5NQTVJSmhGSXh4UzZWMW5VVEROMm40L0Z3?=
 =?utf-8?B?M05uUmU2YXgxZ3JKcjdoY0R0cmsrZUJQR1lXM3YxRm5ONjZjQnFNRzVCM2VF?=
 =?utf-8?B?ZXY1YjdIcXNacTVMK2Y4L3pSMzlaTjFNaWxvNDZwV2JOcnJGTkEvVEVqbldr?=
 =?utf-8?B?TVdHb2p0MHdqUlpWQUdUNDB6R1lIODhIMW9WVUJqYzFhRGljODgyZWx5NGZx?=
 =?utf-8?B?S1kxNlVRcWVUa2FVRk1vZGR6clJnQ3U3SE5NakR4OVlNbUVGbmxuRGs5L0pj?=
 =?utf-8?B?YVV2Z05GaHg4UUdkOUllWEdOTzVCVkdTY0xWMklTTWJTTlFBQXE0cU1lOEd3?=
 =?utf-8?B?UFVjeEpQdHhyV0tldlZDUTkvejI0ZXFFUFJBbElNaFA0Nmp3YTRDMmptTXJS?=
 =?utf-8?B?QWZoNy9TM0tpbjV1NGQ5Ri9ySVk3MzdGKzdUK3VJUmcwSkdjZUhlTVg5M0E2?=
 =?utf-8?B?cFRldFlBV3FscVBHTGhUOTN6cVk3WFJ4MnNjTkFnMXFUSTRKbEFrc1IyYzhm?=
 =?utf-8?B?TmtuRzJBekF6UTJXRXFyYnhLMHNHbDdDYmt2dytWM3QwUWg0aXNKTDV5RDZY?=
 =?utf-8?B?dFJXenE4c1VickhqcUZScDlzK0k0S0djakU3K1lxOEhSRkhhbm9HZ1JFSmNU?=
 =?utf-8?B?WVQzMU9HeURFY0VqcEJEL1FjTzZKVm5pNllBVTN6QkVZdU92MU9uNHFCbDQv?=
 =?utf-8?B?bmZHbkQzM1duUTJaUVJRN0tHejZJbGZ0a0RhejdMV0pTdVIyUlNTQkoyQVJC?=
 =?utf-8?B?RXpUMURmMGpUVWdTYmtVUGRMYVBDaUk1NHZzazNaUEVzYlVGalYwbEVYZlhs?=
 =?utf-8?B?aFJIdkU3WmZvT1JpRWJkT2dUcWJ2R3JPUGlpZEZFZkJ4alBRZGdaM2FWV3JU?=
 =?utf-8?B?QnFGRVExNXpjQjRBVjA1bk54RlNsRnhCMFJ4aXB5VFJTeFUvZ2FXM0lNRmd6?=
 =?utf-8?B?UzlId1NIeWljbHlQZm5vYUpWRlorbDBQci9ZQnRoTGd4OHlYc0s1NnQ0SzJW?=
 =?utf-8?B?Rkk5aTZmY2NOWjNPbVVVekNyMWxHYzZSbS9lMmxxa1ZkY0RGcDZ1dkpuRG9l?=
 =?utf-8?B?MVdTTXBtalo1MnpDb2E2TkwwdEF4T1VGWlJqWTN0NjE4YVpoMnA5M1o1R0to?=
 =?utf-8?B?YjBzNnRFZVFJa0N0SU5SV2xpOGZ1QVdRRXZJdlp2OTlYRURuM2tjZVpDT2xK?=
 =?utf-8?Q?o/mIhQ57GiU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJiRDgyVEwvWHN5OVYwYmdtajVmOHFBZ09zbDU2L2tOekorT1RBRHpLUE5Q?=
 =?utf-8?B?ckJWTHNWb2tUTVFhY0JOTWZka2l3ai9jQ1VHN0c3M3VucVNJcmdOdm5La0hv?=
 =?utf-8?B?NThUOE9XMnpHSFNDK1RIRU4vSktVbG1SVnI3cFR4UGNEalZzR1ZSSHRia0Uy?=
 =?utf-8?B?UXd1RjJZbVZqTS9YL29uaE1iVXJ2OWdZRVkxamppbkZZVThxZG9HenJ0SXdj?=
 =?utf-8?B?Mkp6eGdwdSs1Q3Y3cS9OVlYzSEdxYThSMHIrM1d2bWJSMS9kaGlIc2ptQjJJ?=
 =?utf-8?B?d2NkWCtaV2V4UGRsN0xXRi9wTy9LaStHTnZldnErQTJiNjdNUGhMaEd6RXB3?=
 =?utf-8?B?Q3F4dXUwa2VJNFBpUlpQeGJwcUV6THRYL0dUbXpFOHBvRmY0TEhxYXJzZDMr?=
 =?utf-8?B?Sm03bjZidHVjakxBMkRid0cvWTRxdmxhMUthcUJmOUFsN3ZRcXU5ekVJYitH?=
 =?utf-8?B?WVhRbDNUZ1RlVWVtREJoSWt0VmwyRzFrbUxreDFsOHFWaFNJZWNkS09uUXE4?=
 =?utf-8?B?b0FtQ2ZGSzA4a3ExNWZ5THZSNU96Um1WREx6RTBqWDBNUFhSTE1xTHNqWnh6?=
 =?utf-8?B?T3lBRVptbzNCOVMrbzFTd0o3clVCa2RFS2E3VzZiWlA3UlRQV2pvenc0WGVD?=
 =?utf-8?B?N0FUbmdSaWJTMDRhbUsxZXd5RisrWFpXazI2NEZHRVJvZGZMVzFaV0VmVG9y?=
 =?utf-8?B?UnBJeHkveUtmamVIRGR3L0ZDWWdFMTVUbk9EK1FOd2Y1N1MwVG5lZHlCbEZB?=
 =?utf-8?B?a2VoNlRrNTFrOVVtWnFwekRDbmphcWU1NEdHYTZsdGgzK2RpRk9TYUJvSDNz?=
 =?utf-8?B?cXNXVTRNZ0RuaWVlTWV1OU9EQ1llZ2htRFhMd1BsUzNkUVFEQ0FhY0p2U1dn?=
 =?utf-8?B?VkJCV3RWTzRrdUZ6T3ZRYkhoREpoWUFib2pBV2NWeU1lektpL3o0OWNDb2Rt?=
 =?utf-8?B?alI3ZmdmSGI0Qkd0QUg4cTBnQVhQalY3SE9DVkpCWDdxcnE4WTU0YmN5T3Zw?=
 =?utf-8?B?dXZBWE9tWnVKWnFNWVlST29jOFhkbzh5MU9XTjhBdWZja2JEN2dBUEVsWVY0?=
 =?utf-8?B?VWpRUXBNLzVDMVR5TWo5bTNnWDQva1krcDdmZm16MVVya2VLUTFKSmVtalZy?=
 =?utf-8?B?emQrQkh2SU9CYmlVVnQvU3hlTmlBeG9aVnExZm5zWC9hS000Mjhma0FKYnZp?=
 =?utf-8?B?cEk4cm5iTElFUGZPMGdiR2wwVzBGY092N282WGxhaTZ6K0FpVlFtbndlNGoy?=
 =?utf-8?B?VnBYbjFyRE5teFlJUHFaaEFSNVpBTlZiWm1yNlU3dC9CWk90S1drN1lKTERG?=
 =?utf-8?B?aDZPZEpmNDQrSm9JZ2EzVURNM3NVSDFhMnZTNFB3N0hIZDdtd3pPak83cmx2?=
 =?utf-8?B?a2o2SXBDcXg5Kzl2dVIrT2NiQ29DaWpHNW5ZWUhlVHowLzAxcDloalBqNXZO?=
 =?utf-8?B?L29LSmhsby9SN3NwTjR4Z1pXZU1XVWlVdkREOWQ2dE5lUmlnSjAzdU5kRk5a?=
 =?utf-8?B?eVpSWHUrQXpHQ0ZQaXJ4OEc1T2NMWEd5VHUzVW00ZUI2TmlDak93a2JjN1pu?=
 =?utf-8?B?dVM2WGVOVHI5Wm9zVEtJMUZ6aFBMUERVWGpxWklob28vcFJ1Y1R4Nlp5dUFR?=
 =?utf-8?B?QXNVTmVOcCtFT0dubkVNSzlRUjJHZmRWWSsydi9pdCtQUW5scnIxWnFuV0pr?=
 =?utf-8?B?UW9jTnIwR2hpZjNaZCsvRmQ3TXd2RXgwcGhYalNyMk52dXhjNnhzRVR1c2xz?=
 =?utf-8?B?OWdDM2NjNUVVWDFmcEVyelluT1ZJbjNsRk1LZW9MNkNaMWRuUjZxWm5jRUFt?=
 =?utf-8?B?MGlnVTl3d0xCSGFyRVFLamZUR2lPUSsrSEVTczYrSUkyci94ZmZqaTZ1UzlO?=
 =?utf-8?B?UFh3UVE5Mmg4bTRFalJwODFJWXJySkFTQmV3Y08xaGk5aVFNM1pzTHI0aTVq?=
 =?utf-8?B?UFo0MnkzU1VhUStWa29DczJEbWFybzlmck9EOWx5RlBTbHNtZjNCUHlQN3Bu?=
 =?utf-8?B?S1c2STNUZ2wrRkNMNXhaVktmejR6MzFqWU1LLy8zSENHWlpFU0tCVEVVdkZM?=
 =?utf-8?B?L2hnU1U2OVcvZlg2ekFXN3FpdnZOUWk2LzdoUk4yV25pZ3BxZkQrbklRSlJo?=
 =?utf-8?Q?K0IGgdsr4tsjel6PwmFRRVThW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83171ff-fb6a-45ac-d77f-08dd93fc3684
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 22:02:41.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKwwZeNCCrbGXmxOYTnKFHkAhiHPfRnwOttwpYX2FDaj76daX8WpoFWEeySZnIMkZ3qlwAm9Qo1k4PG7bKAaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
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

Hi Mario,

On 5/15/2025 4:05 PM, Mario Limonciello wrote:
> On 5/15/2025 2:54 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>> Changes v0 -> v1:
>>
>> * Add amdgpu_acpi_get_isp4_dev_hid() utility to retrieve isp4
>> platform device hid.
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 35 ++++++++++++++++++++++++
>>   3 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index cc26cf1bd843..b63ceead2499 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1657,10 +1657,12 @@ static inline void 
>> amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>> +int amdgpu_acpi_get_isp4_dev_hid(char **hid);
>>   #else
>>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev) { }
>> +static int amdgpu_acpi_get_isp4_dev_hid(char **hid) { }
>>   #endif
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index b7f8f2ff143d..5e04f4b7d0ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev)
>>           adev->in_s3 = true;
>>   }
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>> +int amdgpu_acpi_get_isp4_dev_hid(char **hid)
> 
> Looking over this signature two comments:
> 
> 1) To help avoid any risk of mistake in the future I think it's a good 
> idea to pass in the size as a second argument and then use that in 
> strscpy() below.
> 
> 2) Does this really need to be a pointer to a pointer?  The way that 
> you're using it I think you just want a single character pointer, 
> especially if you use my suggestion below of on stack memory instead.
> 
Instead of pointer to a pointer and passing size param, I will switch to 
pointer to array to simplify the implementation.

>> +{
>> +    struct acpi_device *acpi_pdev;
>> +    struct device *pdev;
>> +
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev)
>> +        return -EINVAL;
>> +
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +    if (acpi_pdev)
>> +        strscpy(*hid, acpi_device_hid(acpi_pdev), ACPI_ID_LEN);
>> +
>> +    put_device(pdev);
>> +
>> +    return 0;
>> +}
>> +
>>   #endif /* CONFIG_SUSPEND */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..1bb927428847 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,49 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>>       int idx, int_idx, num_res, r;
>> +    char *isp_dev_uid;
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    isp_dev_uid = devm_kzalloc(adev->dev, ACPI_ID_LEN, GFP_KERNEL);
> 
> Normally I like device managed resources, but I'd say this is a case 
> that device managed resources are overkill.  This is only needed for hw 
> init, and any device missing this ACPI ID is going to have wasted memory 
> from the device managed allocation.
> 
> ACPI_ID_LEN is 16 bytes right?  We don't care about the use of this 
> after the function goes out of scope AFAICT.
> 
> Why not just put a 16 byte variable on the stack as part of hw_init() in 
> this function and write and compare with that?
> 
yes, I agree, having a local 16 bytes array is good enough and need not 
allocate using devm_kzalloc.

>> +    if (!isp_dev_uid)
>> +        return -ENOMEM;
>> +
>> +    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_uid);
>> +    if (r) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected");
> 
> Since you have the error code in 'r' I'd say include it in the dynamic 
> debug statement.
> 
sure, will print the error code too in the debug statement.

Will submit v3 addressing the comments shortly.

Thanks,
Pratap

>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", isp_dev_uid)) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +
>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

