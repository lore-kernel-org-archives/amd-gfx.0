Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A5ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852510E128;
	Wed,  8 Oct 2025 15:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSLaOyiM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077BE10E128
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0EggGnCCr7bdBLrvk9Bdk04GDpHE1K9a0Jc15O3lrDdm0zhrEVbapJabQpUJ/i1ytuA56UlSV9P3ydtAbcAe4v9sT+Vm6pdJH7kkxQhWcqj1l9cyc75G3bhRaJ21ll9OkzI2kl01mV7rZrokhP2EnKD6y3yjIQpkE6pP8/5gyPMmF12eSIVT3qGx7wfE4GYv77JWFfdM5371TYrvKa5EVfZjMCz4QCRbumPDV2HwL282AEWpRosKTwsepUZSkOy2q+8ZGmcCE4tnTHSFX4SJNYI/Zpz659BWsAxfX8YhwFCN79zH61V4+pq/oV5888KIhKrEtRJsIk3T851tGZqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHOV0rU4sYHAAAHELDpzuQlo4v9LCuqeeSj8zpa1om0=;
 b=OEE8wqho5GexEcrGxuuqfda0qin8bYvTTIOvXo+QhIYGBriJ1RysKHGL0RSikO5J7hsNuRufs1bI+8o7U40FIf7r3P0O8RWylQ6R95nGYzlHBnpMnXL5sME8ZlFBJevdxN5lGLE9jJn/xsJd81iFKAjp2X31gydFAKwef1+R0lR2OXVclAv3T38K9TSx9DjZKW83Nn6tj2LBW5K2wMLD38AvIc+LvktQvtwfgbIY8+8aOP+qdLeBFh1aZ9g+VzfLZbIeeIXQLQD8/OAU05bVMlz+5eyZT/dhAdAbTJri3W4r6GUrM4yeDDO6rfkepV+l42QIc3LJkwYJob21Ty2DsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHOV0rU4sYHAAAHELDpzuQlo4v9LCuqeeSj8zpa1om0=;
 b=pSLaOyiMNTKMGM0AwE8u0ix1rfrWZQBnG8a9XsWDDMSCa3Uz8xduSqstizVIh4bV7CxsqPEsYOF4ymgFt51VwRyaE46SnXHVGK1bqT/XXmNHfmXebpzvcC/9lG/Jwil6jmhniD068wNHbhaIp6juYmtFNNVVQSxTaTqUQkSTUrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 15:33:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 15:33:33 +0000
Message-ID: <1462e3a3-dd43-4903-9371-32d3245542aa@amd.com>
Date: Wed, 8 Oct 2025 10:33:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amd: Unify shutdown() callback behavior
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
 <20251002174245.1691343-2-mario.limonciello@amd.com>
 <CADnq5_P3wW=89cuFUgs493jdU1tHiovCLCTMv=ygNo=g3yXdBQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P3wW=89cuFUgs493jdU1tHiovCLCTMv=ygNo=g3yXdBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:5:54::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 468277a2-a140-4246-15c5-08de06800a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXAzV0xpb3N4Z25EUlVaOXZiQWdJcUpRT282RENNY0VVWVVrSVZtUnoycTdm?=
 =?utf-8?B?NUVQMzhyMTRJbGwzMXRWbVI4MFVmU0s5N003WkhtdEZ6UXZpWjZVby9wd01P?=
 =?utf-8?B?RlFHaUQ1bVAzYy9DQVZpOWc2QW9wS040RlduSFh5NjNHUW4xLyt2b2lTMHJR?=
 =?utf-8?B?VHZMdXIrNnpQaWFYOWlkTm45b3hXUmphK0JJamJnN0JjcjF1dlRzT2diZ2ZM?=
 =?utf-8?B?Tzh4QTUwVHVqMDk5YWZwRTd5dkRXRGI2QmtIL3JaRlBVU1dQVEsrZXdGY3BO?=
 =?utf-8?B?QmFFUkVDVmd4RmNmSFpZdWNZOC81RFo1dnRBVGVFSHRITXFjR29OWXpXSXY2?=
 =?utf-8?B?eDdmK0czeHJoajIyVmFselNKdklYaDB4MnFDVlROd0VmR1lLck1xbmU0Y1dW?=
 =?utf-8?B?cE8rVU9wemQrclU4TmRMbGxHOGtFZGxUVGVWZnloVENYZ3UxaFhZeHJFOFY1?=
 =?utf-8?B?MXVqQlluL1NTRVN5SFhrY1oyc0xNMVk1QTNPYjBTbFY2SGRTdUMzdG13d1BT?=
 =?utf-8?B?K1lOY2Q0UkNQY3AwVVgzVktZa3NVTzFDQ0duQ0tlSTducUQvS1hVVTI3dmMv?=
 =?utf-8?B?N2dDcHl1NTRKdXRYcitnU0lpSU9aYVk1emc3WDVYbmNabEtkdzYrS09jZ1BT?=
 =?utf-8?B?UFV4R2o2cTN4d2s4a04rK1JKcEE4Z1YwRVlxZzgxUFQxSW1yQk9iN3dxekMr?=
 =?utf-8?B?MmNqUVRlQ3JoZHlPOWRBemd3MGJGdjZzTk1oZFgvVzVobkVud25FOVRCcU5n?=
 =?utf-8?B?bHpFY0ZxZjN5Zy90L1ZOWjF6Y043VVAxblpBK1VSN1FETGl0R0tvL3RKYUZy?=
 =?utf-8?B?QlI1QWt6dlJUaGVGVWRaWiswVXFYZGxBSGpsQnJidlU1UXIxTUorV3NVd05S?=
 =?utf-8?B?REtGNkxVZnhsYlYxVGFuak1qRkxoRVh2ZDlZa3ora3pvNmVtRGo5ZmJpSmJ2?=
 =?utf-8?B?cXlOTkNNWU8ySzNwVS9QRjd5Y3dSamtrcFh0VTA4ZStRYTAyR1hjajRFRzVu?=
 =?utf-8?B?bHlnTUR5MlRqc2lNU2o0U1k2QkVSdWd1d2ovNWdJRG1GaHVQbzEzbXFqWmdS?=
 =?utf-8?B?SFc3NG9DQS9odDFqNU10R1lpMHcwTFVJdzdlWHdWYnNFWENZeUxwVENTQTQ2?=
 =?utf-8?B?YUNLenNoVTFxV0lDZlI4TkNLdGpDdHdqckF2S21LY3Z3ZXFGanlqN3E5UUpC?=
 =?utf-8?B?b2cyMERQcmxseGxKd293bTFiaTNUNm8xMUI1NkxEanhTa2lnNkVFaU9xbFhj?=
 =?utf-8?B?RTlCWEtiWm1RNmtaR013ZE5IcWRZeVM2UklGQnFNWEQyVENZK05tL0FDeFh6?=
 =?utf-8?B?UWE3a0VyYWZTdEFzaG9iSUVYRk9iaXZ6c3RycXZGMUNraGJuRE1mbnR1Q0t1?=
 =?utf-8?B?RHpOSUtUM0FaOWc2U25kY1h4bSt0VkVERlh5LzJHT3ZLbnF3Wllxd1NuN3NE?=
 =?utf-8?B?U2NmWWhyN2gxbzFlOE9WakVWaFdQQW1vV0ttOTJiMC9oRVlqN0xWdlE5VThz?=
 =?utf-8?B?MThPU1IrVFpQYW10TVZvZit3Ni8zSWhjT1YyL2I0d2Z2S2FqbkNhWVdpcDdZ?=
 =?utf-8?B?YXBic0xjNkxOZ1VrZHJ2clhqREMzR0hBM2lGNGxKZ3JzdmRGc2JiWkRJTmxp?=
 =?utf-8?B?VGhJcXRUcFM2SXNDYmdPU1B5Z0l6M2tyV0RERDl6NzVhYWdhMDBUMkZ1OEhG?=
 =?utf-8?B?QTczSWVNdzdLalh1WmtsVEFKN1lVQmZkQ0Z3T2ZkUFVHODI2QUI0VGRtRi9Q?=
 =?utf-8?B?TGpWSWNMTnVyTXZTREtqa214YkpFUGl1ZDJsbDVEbGxWVGVWTFE4L2crTTlp?=
 =?utf-8?B?RlVxckJ5eGJwVldEbDM1YkxFTThWa0hhUjB3VjF0WGdhVUhLbXByZjhvdWp5?=
 =?utf-8?B?NlVJcURCN1FWSVBnTjVsU2ZzUk01N0Q0elFUTlozUmtDRUtnbERFTCt4dWpJ?=
 =?utf-8?Q?RqMabItvcLiQJe5cEYLzmvxOS5bwkciK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjJDOTJEQ1dIZ3FjVXFhVU5xSDhacWhMUllPaDBpS2pwVHpseVlXUVRwcDg0?=
 =?utf-8?B?ZHY0bEdMcExaZ1hjeitheDJqeC8rVXh6RzFwWUFUK0xQTjNoMzFtVEZIYWho?=
 =?utf-8?B?NkU1YUxFT2lML2s3b2NLK0J1S0hleXdnYk1Da0wzV2ZiTnhQZFBDTWZpeDdi?=
 =?utf-8?B?aHZ1d0JGMGdiR0FxTFozK0hWUlgzZGt5a21zSDkxR1hBQ0F4ZzRBZHNTMUJS?=
 =?utf-8?B?U290bWQ0Smd1N1dGOWFnV1QrZ1l2OS8ySVBhMW9HRkpWTkd6eXV1NnZDaTVH?=
 =?utf-8?B?aFFQdmU5bUNxV0VlNTJaT05VK01wSUhGcW1jeFhmS2x5UVV3Rk9ISXkvQzhU?=
 =?utf-8?B?Qm41TDVXSHNVc2hFL0xDVGVWS3FIcXJGbjVuK21JQ1hKanRsMk9LOUlpQ09a?=
 =?utf-8?B?R0prK0dBL0JnbWd5K2E0TXhVVGhHZWY3RHE4WUpteG4wNWNYY1hKaE5TOGRZ?=
 =?utf-8?B?NHRZRW1QRzhWUjEvbzJ1TjlTaDhnMG9wT1pUOGNoSHJDY3dHcXVVNXpOaXZN?=
 =?utf-8?B?clVLczRTbHM0anF2bzl6V2pWSHU5cFFpQUdZSXVEaHNhOXVhSjh3Rlg4cHl0?=
 =?utf-8?B?SjFwMFVDSUtHNkptSndaMWJxMi9zYzNmamV3d2RHaGF1bTlYZzBFRW9LTUZo?=
 =?utf-8?B?Z0kydWc1bjNOZU9FeGdYcDZNYUxoZkpxYkRER1kweDA0bjQ2ZmN1aFBXKytN?=
 =?utf-8?B?TFVac1hMTDIyU3hWZlBMNnFuTkpiVVVRS0FFaFNWaE1iWjRnYmovTWxEZlNH?=
 =?utf-8?B?ZHUxYmRoa2t3VU1PSmplQWRCcWE3a0IzbkNYUEJXVFJqd2hlRWhJN0cxZGdO?=
 =?utf-8?B?SWNxbEM5UDFkVVJpODNVazV6RVl3cHNRMzBsWVdSSEJpODdHNitycjFPZlpM?=
 =?utf-8?B?cnRmR1RWYUdPUVB5OEhCUDBiYlJlTzVQcjhWNmVRQVNYekxZQjF6bzE0aFgz?=
 =?utf-8?B?T0l0QXg2aFdydkpjbzBpNjNUU2JURXU2dkJyelFLajFKRkNMQTg4ZFNra1lI?=
 =?utf-8?B?VHpQRFV4NlpiemFYdDFiOWQyazJHQUEvL255NWErTGYzNHowZlk5UERvTnMv?=
 =?utf-8?B?U1BMaTdDYnJpdUZWT20vZHNYY1BYMzRYelo5VXozR1RvZlkvR1BHM1kwOE1w?=
 =?utf-8?B?emtSdXRGK2NDU0Z4c0EzODBrZnZZUmJsVjJFVGx5K3lhaE9uZWtTcTVtcFl4?=
 =?utf-8?B?QVkzSi9Ca0h0Ym0xa3haK0JZNUZWNitRR3Y4RU5rWGNpU3NYSVc0SDQ5TGJ4?=
 =?utf-8?B?amhabWtKUC9DUXlGb2d2OVM0c1BhV1QzOWtUL2tSVGVKWjFhWE1FOWFEeUMz?=
 =?utf-8?B?dnFWWElMbTg0Y3VQcnd3YzVDMGNiQTVuSkcvZmVRR0hDMVRXQmcydFVWT1Fp?=
 =?utf-8?B?ZlFpTkxuWHNwc1oxVjdrVVlkS2JlT2RwNTJWN2F5YmNHTExSRG1jY2VCdjQ2?=
 =?utf-8?B?NHgxVFlad21SY1grVUw2TmVHSk5kRFlYUkllQUhhWjk3VUNxUXQxaUpEZWZ1?=
 =?utf-8?B?Q0RocUNPMTBRMHVSOS9zTTFBUWRoZzJYMFpqc2RoSFY0S2w5UHgxczRjSTBE?=
 =?utf-8?B?dFhISXFlTnl1aEhNSXQ5Zy9HaDJJR1BJKzBUUEMvRjRWQTlKdzlWRVNocnhR?=
 =?utf-8?B?dTR1NUdPMVhQYk1vTmpEb2dqaVk2OGpUanFoV3ZhdzRtTDNGWjBlYnhRdjNy?=
 =?utf-8?B?T05KelNnWmJMeGhWa092aXRmdVU1NHd2U2VmaWJpWVlSa1ltTHBEUGRWOFJU?=
 =?utf-8?B?eG9HMWx6Qk02TUZpUWdnVkgvLzRFTzhxTVp0SXlPYlhBRlRCc2VycXF3MWJ4?=
 =?utf-8?B?MSt2bHFVY0U4R0NVYzJieWJFc0d3UWxLb0dvTWRmeXdjTkhCSUlGaTkyUFNE?=
 =?utf-8?B?a2UxRjh5Wkw2ZTZMa0J4ZWQ3dWxMdUdFNzdnSWJ5ZnBSTjcyWHdPQThuSDl4?=
 =?utf-8?B?WmxDcmVrSWRZVWlvVGxLdnVnTjhkWVR0T21sN1VjNlI0RnNvajdlVnZBNThv?=
 =?utf-8?B?UkZqSEMxblR4bkk2dDNvUldCYWUzdFlJTGtiTWRDbFBQc1NPdUxjUlozQlZX?=
 =?utf-8?B?QndEZXlUaXoyZCtON1hISTFjVlZzZUE4OTZzRWdTYkY3SmtiZm5xWjVvd2hQ?=
 =?utf-8?Q?+NVCSUEE2aSZ2zV0k/q4nnovQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468277a2-a140-4246-15c5-08de06800a3c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 15:33:33.2183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr3v0iSv3QJ55ZdjFS5DetvlYOBv2yH1QFR4e9vVSxWKbpaZvES1vPhYUf8fgRv6iTjeDbcuYfuhkg4R8ydVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

On 10/8/25 10:31 AM, Alex Deucher wrote:
> On Thu, Oct 2, 2025 at 1:51 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> [Why]
>> The shutdown() callback uses amdgpu_ip_suspend() which doesn't notify
>> drm clients during shutdown.  This could lead to hangs.
>>
>> [How]
>> Change amdgpu_pci_shutdown() to call the same sequence as suspend/resume.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 4905efa63ddc..e377fbb43e96 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2558,7 +2558,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>           */
>>          if (!amdgpu_passthrough(adev))
>>                  adev->mp1_state = PP_MP1_STATE_UNLOAD;
>> -       amdgpu_device_ip_suspend(adev);
>> +       amdgpu_device_prepare(dev);
>> +       amdgpu_device_suspend(dev, true);
> 
> I think we did this before, but users complained that it took longer
> to shut down their systems.

That's presumably from the evictions.  I think that it should be 
improved because we now have:

drm/amd: Avoid evicting resources at S5

> 
> Alex
> 
>>          adev->mp1_state = PP_MP1_STATE_NONE;
>>   }
>>
>> --
>> 2.51.0
>>

