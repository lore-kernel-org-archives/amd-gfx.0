Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35DC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AC010E963;
	Thu, 10 Apr 2025 11:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAJqRn26";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211610E963
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/fx+TgIcFEpwbGIl+wCGkDASRv0IX4WWyhcQJZTp9cl0xA5YrCMO0ojurjV5MT3pa0+QvxHYDW3p4ENwfSNzPnYR1UX7Vk8C1s9GC4j3RgCnbS3K5puSBj5MTz8DsviHUOv9m7Qziph8s3VoNciI65IrrGsLsto5hCTHx3oc7tmtL9/vypvGhW+lcANUV83KpmrNmB7yXRxL1YIaQSkipJH9OOPS3EmwMwst6HhtKaopABhy2nF45b/DU0jw7bQgoW9NexiJBMX1IDCAtArpWXudB3sxn2G0OqXliHEXlGIg7tovxos1w9btlhn/+ZYfjJZJyB64z2bHllrJb+9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5RWHSLadX6/+cHo3VVb8z+tDqFZoPBwWUXkdghPpeI=;
 b=o0+RJAsv5+XdjxauN6mEEUIykOO5J31tpzjkzNMahCmE2wVWtM5ekJxwJHNEL8EsQsilqHNTe5ttY9rNGFfgTMWeGgzqnCLQdagl9gYhLWME4n6M2s3uXezoX1L5JfuOorxbvRBk56ON3xNJNjnX8yNiMFQUlav9TmiR12gZkS0VhRjuzsZSZ9woarA4pyP8TkfwTdj3/Uc1V3P6DcRE+QGcCyXMkxQcBHS+XH9eVLgFuwgCL4hVme9Wpcb9kz6Y5kmiZj0eZb0JchtAv1/lXmFO19wfxb4y9U5+n56J8QjuN50bbKpfUsqBVAf7xFRJFlksV8S9Kvi9pXIlalquXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5RWHSLadX6/+cHo3VVb8z+tDqFZoPBwWUXkdghPpeI=;
 b=uAJqRn26oTAXykW7PINv+oar0/OeONBnRklK2DPa84uNFy49JedAEKZHFvE3GopnPygLSfJnhJvc19kHbwY0Bucd03b0h2q6bls3ldl4kAih1zRE6uk/Ck4UXnvLwHheKxdCbd6H8Zwg/DTrYFUBDHiGSf2i9lwrg/A6OMmQcwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 11:40:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:40:59 +0000
Message-ID: <0779279b-4b6f-4f48-9379-58d14c222794@amd.com>
Date: Thu, 10 Apr 2025 17:10:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
To: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com, shashank.sharma@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250410112917.13725-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410112917.13725-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 198c95be-fc4d-4dd9-b1fe-08dd7824906e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUN3cndROFJTR3oxNHZmZTM2S0RkeXRzWGxjc2FkaWNuaEsxY1EwZWRFcDcw?=
 =?utf-8?B?MkNDa0NEcjFOcFpGbjdLdFJ0WXZmNThJMEVhYTc5ZUVNa0w0bmtTejlLcGlO?=
 =?utf-8?B?S1Q5bi8wS0Ryem9BR3YwYWlPUWRvbnpuc1I1cnMrY3dWSGdnZWFua2ltdXg3?=
 =?utf-8?B?SkF3NkhCUTJneHZsVGpacmhIU3FVbGIrZWhNZWpyNEVYNXkzVC9MQkJtNyt4?=
 =?utf-8?B?ZTFkck9ncmxYMXN2SE1mK0txS0gweG1mSlk3WXMwQlM5Z3ZsQzFIMS9rWkNr?=
 =?utf-8?B?RFJGaHNyVnBsc2d1c1RBcmZTNjhQbzRJcWZIOGJRdG9SZG1BNERyWVljNits?=
 =?utf-8?B?SHhXdHFWZTFxU3B6YlhiMWViZERRRGk0WmFKakgvRlRqdVd4SUdRNEJtYkta?=
 =?utf-8?B?ZlF3NkVuTW10aFJ5VFh0b0RWajRGcjk5MlZuWDZuR2xrYlprTGkwbDJLVllh?=
 =?utf-8?B?L2VwYURkUllCN3A5VkptVldsblB3NkxOK01kK2ZaTFFML3BHRW1DVUczaDJS?=
 =?utf-8?B?eFRuOGxpY0w1d0JOU0NFaG1xSXlVK3cvc3M1Vk5xVjU1c0JTRndBUzQ0UUdJ?=
 =?utf-8?B?djRvVFBWREh6Y2pQMUYwMWpRY2VFNXorZEt6d01LUWNoYzFPSXpCeTBtZWNF?=
 =?utf-8?B?T3JEZVhwb2QxQWp0UzI5VmExWnVYTHZaYXRuNzBWTE5JMmY4S29qemxkSUVI?=
 =?utf-8?B?M1l1TEtaUUNHZzRKV2VXQm9JVWVMekxPcDRlV3JVU1RiVDJuNVArTDdhcU1L?=
 =?utf-8?B?K296K3hNYzlnSU41WjBEWDVLZkNRZFNCdVB4bDJ6OEVYS0poakxSRFdYR29Q?=
 =?utf-8?B?a3o4Z3Z2SXE4SitLU0E3YVNDYi9uU3l0MElKY3Z1T1ZXT0prUjdHd3ROUWpG?=
 =?utf-8?B?TTBZb253R0NERDlVeTQvT0hFWngzYVIwSU40bU5NUnNRSktESU9pWGZDeG9h?=
 =?utf-8?B?WGxHVlc3UER2ajB1Q1IxNUdHeE54RnIxWmV5eURNSDg5bDIxOEkwMmZuUXYx?=
 =?utf-8?B?eEJ5TWlWMDVPSG8wMmZwbG4rd0EwUmdYMzk5aHdrdXdsS1dpTEo2QVV5dHdq?=
 =?utf-8?B?T0hZQndldVFESjRRWHV0MkNrOHlkU0ZoL1Qxd25rNDFqRjJYRXJHRWdQeGky?=
 =?utf-8?B?VEo4enhNOVFJTkdNR29ub1dKL3lGckNPTmpKVi9kZWpjbmE0TFMvSFRvK1Z2?=
 =?utf-8?B?OEJFVXgzQThuNWNHZE5xTnV5TTZMUUdCY2xMTWlVbUsvdmxHT2hhNjFDWklJ?=
 =?utf-8?B?MVBFTWtmQ3pCbFJmdTR4N1h6RHo5MmFMOWs0ZXJFQUd5WnlKQ2MzdmgyZm9u?=
 =?utf-8?B?RCsxdEd4cGVrN1FoaUtmcEFjWDc2cWlwSmNhZThLLzRNR1N3NC8vZGs5Z2kx?=
 =?utf-8?B?bFJvNk5UcDNLbzlWUU1MeGROU2o0b2swcnMrK3dyWVdUQUQ3QXBUZDQvR3FH?=
 =?utf-8?B?WWxQVW13OHR4WTVuSXZkSEo3TG5wVmJNNlFFQjEvODJzR0hKNWlhWnNNVHR4?=
 =?utf-8?B?MERqVFdrSnRVZmZzUjNmcmJ2WExVMmhDeVZwUGJpbWdvQ0g3a1dPRksvVXVn?=
 =?utf-8?B?cXhFRzd4eFMvUXB6MlpRWXB2RFVvbmhadFhMb2JzWUZwMU5MTTA3ODFIVDlC?=
 =?utf-8?B?RGQwOHd6eHlMTUMrWm5ud1M2dlBUM3ozWWxlV2lJTEo5RjI2U1ZRYjZCZHlZ?=
 =?utf-8?B?ZUJpZjlxRFFtb1ZJanJTQXRyS1BoU2pEalF2N01PYXV6RGJ1Qk1zMDVXRXoz?=
 =?utf-8?B?ZFhoOEhmSG5KODBydnRFeXpPS3JCVDQ2MFBuZXFxYjgrZ2ZLeWNlWm1ZZnZw?=
 =?utf-8?B?Z0FhNVR4U3dvdklKM0F6cWNabmltcUIzWU5TVzE4dlI1NzMwZDVuajJxbHB0?=
 =?utf-8?B?VlczRFZTc2w4R3BGM3ZBQVN5M2k0T3lNTHZBVjNOeEpJemRsb245Z3Y4aFc0?=
 =?utf-8?Q?QzD5C8H4F7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czl0R21NcU5ENEhVRFVHYlZ2aEtQbmN5T3hOQ0JoT1hFL2lqc0NTRWVGNGNw?=
 =?utf-8?B?cHdXNnNBMXczUWVXMFRBbjQySEJzOUt3L0FtazNkY0J0M0UzbWNzeUtTdHVF?=
 =?utf-8?B?U0FFai9oaFcwUDhqZGk2a2o5MFQ2THZWU0JrRVBHTnZGK1ZvTkM2RWlJdHJK?=
 =?utf-8?B?enMybkFzeG51NUN5dDdEbVQzMXVYcmgwcHhaQ2FkL1Y2OVlPUEJZOERrYS9T?=
 =?utf-8?B?TTRhcGlXbk95M2djQ3pQWEtuM1pETFlMdFFtK1FkU1NvKy9GMnI3VmJtY0VX?=
 =?utf-8?B?ZEJjMEdmZ1RNTVF2cW9vamwxRGNQNkVaclZkSTVkeVNsS3N0RVhNeHpBWkE2?=
 =?utf-8?B?ak9tb3hhRkg5T3JMVVJLQnh1bFc5RTJSMzBhM0djTm1aMkpjSEROMmRDTzVi?=
 =?utf-8?B?YUsyM1BQNG1rK0hVcm9uSHpBb2xUT2dhUjFFREl2VUJud2dVQmJyS1pvaE5F?=
 =?utf-8?B?ZTRuSkYwbFJHUkJya1E5VldZenRaeDk2TE9xZjJUZlJISzBHZFluWklRN3Bo?=
 =?utf-8?B?M3pocmRxMmFSN2Jia1NIUHpTbmFWRjBzQUFzcWwzQmVWQnhmQVpOY0VnTUVo?=
 =?utf-8?B?Vk9qdU1HRkJTbEFVVm1zVWJMRG4vckJiMlhsa3dCZlFjTkNpZWtxRTR0UEZN?=
 =?utf-8?B?cmpxU0lhSmF3RGhiTkRkaHl1blVENjdxWkRGd1ZwbkV0b3FpeXBqRTk5bEk5?=
 =?utf-8?B?eFpMUldHRnRzdFpxMFhndDNDOE1OSW1uRUs4ZHExTUw2Q0N5cU9OUHpmYzhJ?=
 =?utf-8?B?YWtoaDgyNWNnUjhsUlYzK0ozRVZqM1lKTEVhemQvalh0N1BJT00yMDV0RTk1?=
 =?utf-8?B?UVZSeHh2amtlTm5vbEJPN0kxWFU2aUxVVjZSTFlCc21xUlNJTlkxR1MyMFl6?=
 =?utf-8?B?Z2FldlcyczVFY3NJaDZSMmxFY3lMcGhMUmRLSE44VVV1ajJ5MUgrOFBhNlU0?=
 =?utf-8?B?bFErZXEvbVcwK2x1STNTK29CcUlBRjZnYW1GVlRSZUYyOGlZNVloMXd1aDNQ?=
 =?utf-8?B?d1N3V0RMVXQ2dU5XbUlCVkZINDZadU9SZHQvZmtjb01mM2F5WmxZcmV3QTQ5?=
 =?utf-8?B?cjVrZHgvaFlMSVlRa3VxR3JHenFsU1N1Qng1MTgzMy9kRUcxMFNTWjZpYzk4?=
 =?utf-8?B?V0JjRlo5R2pyZmcxcVc1RGo0dVZxVk4xb1Z5aW9ENnJiL29LMkwyZWJTZzhX?=
 =?utf-8?B?c2tFQVY2MzY1UzdaTlVVMERBZDBHUXlPL2s1a0FKYmdhNWJXOTZ6bW0wL3BK?=
 =?utf-8?B?OStXN3JpN3p4aW9ESlMyUEFaeFM4WEhwSFpza3F1UGZKV041UnNZc0Rxazla?=
 =?utf-8?B?M3V4VHdhU2t5U0lZT2JiN2VXZWQrUVNGbEVWNlFaM2FwYTIrN1RIK1EyeEV2?=
 =?utf-8?B?OGlHYXl5aHlOMVdIS25kWVh2bFZpcWFJNUxOQkw2dnVyeWREbHRtV0Uwa1pp?=
 =?utf-8?B?VkVJVmRWZkRZUElRNWtjYTJYRW5CYkgvK1pWVmlINGk1bU9hMWZxdHg0SUVs?=
 =?utf-8?B?UldwaGNvZ25nSzRtUUZzQmsyTmVkSnpVcnV5NWd0dUZxa2hQZmcyc0xaQTRh?=
 =?utf-8?B?emY4YzMxZHZ2THFKM2NoVVdNNExKanB2WVQvd0k1R2RLMm1ZZ2NwV2x2dks2?=
 =?utf-8?B?OUZGZ3pyWEZlVkNkRDJMZWh0cEVFNnJzQW5jRXpxbHduTWtRWmNRdTBGaDFD?=
 =?utf-8?B?ZnowczFYOUxuUkJrZWpoQzlhUnhmcVFTVFh4RXFHQ0pteGdnU0RJcldvbHI3?=
 =?utf-8?B?bU9YVHV2Zjkrb2pLSDEvbTczNWU0dkRqV2YwMUdiNm1qbzZNVjh5UnROMXQz?=
 =?utf-8?B?K3k4VTlCd3k3aStrQUpuRnA5aWpCU3J2MHlQOXRUOXJTbW0xWTNmNkk2alhD?=
 =?utf-8?B?bXEyNkRvWkhoNVpuSTJyNTBlRTVZeGtaY09YYjJGN3R4SVc2VzdBbk4wd0RF?=
 =?utf-8?B?TWhYQXJvMnNRSGsrSzhFL3M5UTA0TXVrWmdiY0ZONEtwMlRMcWhTR0F3Smhq?=
 =?utf-8?B?OWJxREozeVh2TEM4M0J3SWRvcFkzZGp6WkorU0RoUE90cGRZKzFFTDVYRGMy?=
 =?utf-8?B?RFRQMzJybzBSSFRxQnl0V2lPRHkrTndEbSsyczVvcmhOMkV1cmJ0alRSZ2Zs?=
 =?utf-8?Q?rN6N/NyCsxydd3lW7W20lJlk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198c95be-fc4d-4dd9-b1fe-08dd7824906e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:40:59.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KFj12GBDT3nlHXUvl8uaLagbgu4SGcSiHQARIi9iGThogEW5/WnXtMp3r5gDKhoIo5G4tyVm8atbuAAwNLqyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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

Apart from a minor alignment issue LGTM.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 4:59 PM, Arvind Yadav wrote:
> This patch is load usermode queue based on FW support for gfx11.
> CP Ucode FW version: [PFP = 2530, ME = 2390, MEC = 2600, MES = 120]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 91d29f482c3c..d7a401ff79db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -81,6 +81,11 @@
>   #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
>   #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
>   
> +#define GFX11_ME_FW_MIN_VERSION							0x00000956
Looks like some alignment issues here  ?
> +#define GFX11_PFP_FW_MIN_VERSION						0x000009e2
> +#define GFX11_MEC_FW_MIN_VERSION						0x00000a28
> +#define GFX11_MES_FW_MIN_VERSION						0x00000078
> +
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
> @@ -1590,6 +1595,14 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static bool gfx_v11_0_is_userq_supported(struct amdgpu_device *adev)
> +{
> +	return (adev->gfx.me_fw_version >= GFX11_ME_FW_MIN_VERSION &&
> +		adev->gfx.pfp_fw_version >= GFX11_PFP_FW_MIN_VERSION &&
> +		adev->gfx.mec_fw_version >= GFX11_MEC_FW_MIN_VERSION &&
> +		adev->mes.fw_version[0] >= GFX11_MES_FW_MIN_VERSION);
> +}
> +
>   static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	int i, j, k, r, ring_id;
> @@ -1632,7 +1645,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 0, 3):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (gfx_v11_0_is_userq_supported(adev)) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> @@ -1646,7 +1659,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 3):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (gfx_v11_0_is_userq_supported(adev)) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
