Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB6D0BB5A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 03:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EC310E899;
	Thu, 24 Oct 2024 03:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLDgHNNN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B485B10E897
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 03:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8Lptw/+MFsrfbs4Tr8jc6z4y/XUkaNjXL1eKq788P6Nso26lv3bOzKBiGouO5ug9G08sIAafWZAbOLvBAwrxKLQyG0j3DbsN+4MkfQS1Pb7lciWylUoAvRDFyuncZTR6PCdvZCw3VcdbFlM+eMUbDovsaoAeONgI9/eQolcku8L3vvHuiS8a0rBcd1HZQO3v2OD5rp7M3i2dKczC97Cc1c4RknEyuB7eDJGk3oo+z4Nj3gcVapriu/zqzkQcqfaeDHEpSvSJnX4t/gQ5SqwuFix455nYpr3MGar8L8R0uJyJI62UEhc+4+Vw35kT8hScVKyJ91jPcuRj05rN//OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKoM+vqnu8xLkOEzBWfHrke1jXLWGQ20vzSaiMOFK8Q=;
 b=CP8vusrAfr26Kgj9ZnWkEZzT7yRUtWODgptnRu9+ReC6DHHHx+OWo6onNHWXWdrIg8ZrkLsw6iBB/wc8J3+ZFu62OpXl9tuQUeax0ZPsk/CB6O4QS9wEbBvXrQ1tK7PGNohMjKvtCrujz139esvueK3jwJKFHYplu1vuJf6U0cqurb5aKu7dNf876+ex2vKAW3bqdZXb3PDgEEfSVt266Jws5ZDMy/NulrMQ5X4VZy881IGQYOVoHszVSYhzmoHXKWaoMAQv0m8YndbmQOGjQt4PXVyPN+HElUr1LUIXHIIAXiDz9KLaqVbAgRWGbFs3STiG0psZsMBUY9IGA2+vhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKoM+vqnu8xLkOEzBWfHrke1jXLWGQ20vzSaiMOFK8Q=;
 b=eLDgHNNNXuQ0Ah43g62HCwNd2kJiPuPeXfbjCPBy3obpCd5sX84o0LJOnZFoa2Albcieo14IhT7QPU2hA3yf1zpHF2QWHdi2f5hZ29zG4f/AF7H9Cce+Tsw39vT8sruT4VGCfwNA8lBk5TQDgziWrCaNj00zfuuroj0wfWcGC7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 03:38:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 03:38:50 +0000
Message-ID: <2acb9e4b-6750-4800-9841-cf2da94558f7@amd.com>
Date: Thu, 24 Oct 2024 09:08:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
 <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
 <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2411b59c-7aa4-4311-e1df-08dcf3dd5fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE9GdGRoSGxJZ1dQQ2puTUYxWG1Jemo5NXl3ZElyLy94YldRcUlKYzNPV01o?=
 =?utf-8?B?QTh0VVF2R0JRK0lHUmtub01pMFVMeW16VkNZbDdCeVRXQVdjYjhDTmJtYWxB?=
 =?utf-8?B?SUNPQ0RLM3doVXlsSFFKWTVMYmRYNHVaaE8wZHN0UG9ia01jQ2xWb3U4ME5Z?=
 =?utf-8?B?NVUzUm9Cb0F6U3IwRHRnSkRLYkh2SEhJNjkraXNubXlQUlVwaVNUbTBqenp6?=
 =?utf-8?B?bTBrS1JFODEybjNuRFgwcHJza09XQ2dkZFgxb2JybGh5NVlXMENrbFlsWitZ?=
 =?utf-8?B?eUpqZlQ2amZtdlRnMGxxd2dwbFl5cXEvTHJXTkY4dzI5akliOU9OS0Y1SlpD?=
 =?utf-8?B?VUFiV2hvbnMvR0VMaFU3REFlL0VNQXI4OFRDTzdhbGF0WGNLWUdhTVIyVE5m?=
 =?utf-8?B?a0Vyd3htTGFtdU8rejJWSGZYUnhnYWdSYUFuVlFXcW9WOE0xZ2FnMG1JWFJX?=
 =?utf-8?B?SC9lY1BHbmNQVDRzWTltcys0eWQ3SEprcGJnb1o4b0hpZEZ5WnJFeE1hWXJn?=
 =?utf-8?B?REE3eDlFZDV4c3JyOGxjRnJIY2dVOTEwS253dElCR1JiMmdVT2d5SVM4eStB?=
 =?utf-8?B?Q3o2WXpBL1pPQWxhWkQvYmVMVDdwUWljZi9XbjcxNFNxa25JN2ZsSGs1RjV0?=
 =?utf-8?B?SzU5Q1I2aUlxdThiMGwyOHpNU0lhTTNuWWNWY0ZVUURoUnBicjdiZ2d1bzBp?=
 =?utf-8?B?S1lJSEhMdFJINEhvOUlZSFdMZnVKbFpORkxwYVJiTDMxbmRScGUwYko2djNR?=
 =?utf-8?B?SnJvS21ZQitwM2tkd3RhQWJkV1dZZ2txd3EvQlVvRFdjaWtqR3U5bjJWT0JZ?=
 =?utf-8?B?VzIzVHEvY3JLVjhXSGFGbVdKTmFVdTRVUDlBdnd4ZU5EelBVRUtQWmxIUHI1?=
 =?utf-8?B?aEExelZoT2MrR25NWmtXNmRPeUhYZ2pqWUZudGpHUnpkYklGSVRWWWRQSWF1?=
 =?utf-8?B?aHpPU3QrenZoSnA5YWV3c3Q3VDEvYnFxN2dNVDY0VnNBNTBJR3Jvbi9vUElP?=
 =?utf-8?B?RUU4ZXR0WG92bHhxdVBkRmpCRlRKa3NZOVNHV0xHeDIrQ2gxRllrQjFlRWNT?=
 =?utf-8?B?aXJxaDdFcjVDY1pDdVpxeG05OWg2QitWc3B1bTdhTmFqU0JNdTNVQ3NILzJ2?=
 =?utf-8?B?a2ZwbEJNUmp6MlBLTTNDWjVVNWFyTXFCdXhybS9qVlpWUXdOVmd2UjB3dTQ3?=
 =?utf-8?B?MzVPYVhpNHVXcDVPeTI2ZTdmdmw5RS9PZVhVaWZJZlJENExNSkVXU0xVY2hp?=
 =?utf-8?B?SGFJSVduVHczZ21uN3JjQkJsUVE2NHg3UXZzeU0wczlUaHZMcnV4M1ozOUE2?=
 =?utf-8?B?NDZhbVBzN1ppbTc5RnQ4WDlpS3k5d1g1VEFJOVZVcm8ySUN4dEtYOExab0Qw?=
 =?utf-8?B?V2hCNDdIUGl5eXpTTWFSMkVjbWdLQmk4RWpHTThIZjZkU1I3ZFllYTZPMG1H?=
 =?utf-8?B?UU10dVNZVXZWY3ZZWlU0b1hJVHEvWHVNOFFJSnhFTHREYUM3T0lDNllXbTFU?=
 =?utf-8?B?TG9qdnI1c3hWUFhRVWl0MHkvdFcrWVVSa3JJVnNtaGRldVd4Sk5LL1NEVm41?=
 =?utf-8?B?K2NBeVBJSXQxZTFFUVV4TDRBcTRsaHN1QURmMENXcnZWcnNuTlNCdjB4YWU5?=
 =?utf-8?B?TlVKTnNDTEVPSmhLNU9ZaW1KSTVra2NOSGpkd2pyWDgzR0pNNWFtNG01d0Zo?=
 =?utf-8?B?TW9MZnB3cENaVjdtU3VtTVRoc0JPV3BmYzIwYnNaWVhTYXNqVFFqU29DMk5W?=
 =?utf-8?Q?k3v1bnGqmXGORmQ90VBpIqNOdmpXXgqe6bi3LVg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmZyb0cvaE9pQTZ0R2JadzlnVW5Ic2hBejdJSUtPTU9waFU5L05OZjJnOStT?=
 =?utf-8?B?L2I0QUkvS1d1V0JZMVFkL1p6UXZKSFRBVUIyMnlzK0RpUG1GL2NhS2J5K09U?=
 =?utf-8?B?RUZHUVZxZURYdzk3SkdrOVNZblVuVG1VdE1KYjRxSGtWa2I1M2VuQ3hOMWIw?=
 =?utf-8?B?aDlCV1lLNlFuMmNxNjZHQ1poUEcvZUtWanZnekYyVCswWldFV2RGZmxaSHV2?=
 =?utf-8?B?NGJTK1lMNUNXTU9WV1ptajFSL2dzbUZqQTBPNUU4aitEbWhRaWQzM3J1TU5r?=
 =?utf-8?B?WVpmaWlQZGlEUnVjZkUvQ2haTjFTODRUS1c0UE1OSkd6b1NBSnVQODJ2bHFO?=
 =?utf-8?B?L3hMQVN0SkxSSTdFcWtPeXV3a212aVNmb0U4Zzg2aWNCZTVyYTRyU2pyWVNP?=
 =?utf-8?B?K240eFRydkVOWkZGc01ZdVJtQUFJcXZOMUpDL2ZuVDNtdnBDSHdPTDNrVEZm?=
 =?utf-8?B?ak40VDZZaXJFall6K2xUMmRUQ1ByNWFwaXM3OFVyc2hjbzlRckJzMlJCMzNl?=
 =?utf-8?B?TzlUNzlBTHlXbCt6QU9weEdrNmtITkM4VGpMWDlFT213YzBOcVdmY25HcTB3?=
 =?utf-8?B?VEdDRG5obENSOFQ0eUpDRWgrSks2M3pzRE1HWFBFMHlDYlNqck1WOU92cjBw?=
 =?utf-8?B?VmRreGxsMzQ0NXVOeDF5bzU0SVRtMWR4SFZqek1scS9iV2F6OVQvV3cvVW0r?=
 =?utf-8?B?Wk96bUxwTXozWUxIdlZ3emp2MncrMUZPcmNCbThmYkdEZzBUQk9hb25DaEQ4?=
 =?utf-8?B?a3FCU3UvUWxwK1pmbzBsdWltQkVyRkE0bWJmbVorcGRuZzFWclNyMENIeTcr?=
 =?utf-8?B?RHo5dnptZDR0Slc4aWV2M09HaTBBUVEwMG9EUVlNajVqR2VESWtwV0h4Q1gy?=
 =?utf-8?B?d0hYL2s2eFZPUUUzOElPdzJTS0V4ZDlqVkxpSUlLUU5ySjhLdlpsRjhJNldh?=
 =?utf-8?B?UXptM2FvOVNRLzFCcFRnUXF1TnJqZTZKbkE5Z0RnY2tHenRRSG4xRVpIVTcz?=
 =?utf-8?B?bDRxSDVWWGNZTGVnalNmUExnZ2pzajhpLy92cGpNdWFFMWRDVzgvUzNubENt?=
 =?utf-8?B?TUdMYzVxV2pnb016UEdMai9ISU91RVVIM1U0RFpHMmtLb3ZqV1VLZUFCL3hl?=
 =?utf-8?B?cWJFTGRIYUl5QTdDdXN1YktYeVFIYXhQTXhZQ2h3bUJqUlM5QjVHNkpXVG0v?=
 =?utf-8?B?ZkZZYkJ6SkNKUlNPeHU5ZC83dGFoL1FLQjIydHJseGFUdW1VRFErRDAzMGIy?=
 =?utf-8?B?a21nTHJaL2NubGREQUNSenZUTlNZeUlSRTBYcDlPbXhDZFlDaFJiVXRMNEZ4?=
 =?utf-8?B?SHJEcVg4Qng3NzFSeFBqS3B6bndZZUpwUDJ3M3VXMkwxSlA0a2xLdEFjdHRy?=
 =?utf-8?B?SVppbUpOdGVjd0tpNGJrcjVzb0tJbE9jQkt4YkxTKzBhZWhNUy9JMWkyRElv?=
 =?utf-8?B?eEFCY2I3NTIvNUVHTFFBK0RraTltNXlJU052dkxlaGU2NThHakNoUlF0ekxt?=
 =?utf-8?B?bWlESmczT05yTzlBVnpWWG1TZ09XdDZvOE9jbkZWVHRLeGlMQkgzQlBvcXhI?=
 =?utf-8?B?b0ZtNy9TdkZ3ZWo4WGpQNE9WV0F4ZHoyaGRIcnVkNk5CNERkNVBHelZ0QmpE?=
 =?utf-8?B?bXQ5b2t6OHhhdm04SytGc2JjaHRQNGRvZ0UvV21MVGFMakdQVmIrYUJzUUcr?=
 =?utf-8?B?ZTk5dmVWTVo5eVU1YmpDZjVJVlJNQnVmSU1aVTBHTVg1dVpPNWQ4Nk5jV1dY?=
 =?utf-8?B?aVRGV2swT3VxeGVQdkoxMVNpczdneFl3eUFaVDdzaDdwbVZzZit0dFkwRWkr?=
 =?utf-8?B?L2p6L3BzcGZGcGVQdkhrWEJtQ0FxenlQQ2Q4YkR5TnVrN2R2azRMZ01UYlRK?=
 =?utf-8?B?Um5KS1QzU0d2N0RRbW9wVzlidWNvL3FCKzgrYkdDOUwyQUNCUkl5Ynpyckdm?=
 =?utf-8?B?NUZzZmd0NlBwNEt1TmpRN2o5T0RmQnU0UVl4U3VYSXVYUnZ4M2tnWEtjVmgx?=
 =?utf-8?B?aElOelgyV05PNWNiQzQrNERwWUYxcVZoRTVYcmcvNlkvb1B4c25EdXVCbXFn?=
 =?utf-8?B?R0Y2cFNBalljNG1YQ0lrU2d0QW1qMWgrdEFvN05iK3ZkbG93NUIzcUxVUXF6?=
 =?utf-8?Q?HqtmAEA/QYlZDLx2airbegzXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2411b59c-7aa4-4311-e1df-08dcf3dd5fe4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 03:38:50.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt4kOWckU93DgGTrxnJIQmUukC55zzP2hX8+P3+QziZz2Ngwwp5pBsuK/wGjb4nI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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



On 10/24/2024 8:24 AM, Liang, Prike wrote:
> [Public]
> 
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, October 23, 2024 6:55 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>>
>>
>>
>> On 10/14/2024 1:19 PM, Prike Liang wrote:
>>> To check the status of S3 suspend completion, use the PM core
>>> pm_suspend_global_flags bit(1) to detect S3 abort events. Therefore,
>>> clean up the AMDGPU driver's private flag suspend_complete.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
>>>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
>>>  5 files changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 48c9b9b06905..9b35763ae0a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>>>     bool                            in_s3;
>>>     bool                            in_s4;
>>>     bool                            in_s0ix;
>>> -   /* indicate amdgpu suspension status */
>>> -   bool                            suspend_complete;
>>>
>>>     enum pp_mp1_state               mp1_state;
>>>     struct amdgpu_doorbell_index doorbell_index; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 680e44fdee6e..78972151b970 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>
>>> -   adev->suspend_complete = false;
>>>     if (amdgpu_acpi_is_s0ix_active(adev))
>>>             adev->in_s0ix = true;
>>>     else if (amdgpu_acpi_is_s3_active(adev)) @@ -2516,7 +2515,6 @@
>>> static int amdgpu_pmops_suspend_noirq(struct device *dev)
>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>
>>> -   adev->suspend_complete = true;
>>>     if (amdgpu_acpi_should_gpu_reset(adev))
>>>             return amdgpu_asic_reset(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index be320d753507..ba8e66744376 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device
>> *adev)
>>>      * confirmed that the APU gfx10/gfx11 needn't such update.
>>>      */
>>>     if (adev->flags & AMD_IS_APU &&
>>> -                   adev->in_s3 && !adev->suspend_complete) {
>>> -           DRM_INFO(" Will skip the CSB packet resubmit\n");
>>> +                   adev->in_s3 && !pm_resume_via_firmware()) {
>>> +           DRM_INFO("Will skip the CSB packet resubmit\n");
>>>             return 0;
>>>     }
>>>     r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 12ff6cf568dc..d9d11131a744 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct
>> amdgpu_device *adev)
>>>      *    performing pm core test.
>>>      */
>>>     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>>> -                   !pm_resume_via_firmware()) {
>>> -           adev->suspend_complete = false;
>>> +                   !pm_resume_via_firmware())
>>>             return true;
>>> -   } else {
>>> -           adev->suspend_complete = true;
>>> +   else
>>>             return false;
>>> -   }
>>>  }
>>>
>>>  static int soc15_asic_reset(struct amdgpu_device *adev) diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> index c4b950e75133..7a47a21ef00f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> @@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct
>> amdgpu_device *adev)
>>>      * 2) S3 suspend got aborted and TOS is active.
>>>      */
>>>     if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
>>> -       !adev->suspend_complete) {
>>> +       !pm_resume_via_firmware()) {
>>
>> Looks like this will cover only ACPI based systems. Not sure if that assumption is
>> valid for dGPU cases.
>>
>> Thanks,
>> Lijo
> 
> Yes, the pm_set_resume_via_firmware() function is only called during the ACPI_STATE_S3 suspend process. However, ACPI-enabled systems are popular in the desktop world. If there are concerns about ACPI configuration, one option could be to check if the dGPU needs a reset by directly checking the SOL register. As far as I can see, when the dGPU completes its suspend process, the SOL value will remain zero until the dGPU is resumed. Conversely, in the case of a suspend abort, the SOL value will be non-zero.
> 

in_s3 is set for dGPU in case of s0ix as well. Probably, that's the only
case where need the flag to avoid unnecessary reset. Otherwise SOL check
could be sufficient.

Thanks,
Lijo

> Thanks,
> Prike
>>
>>>             sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>>             msleep(100);
>>>             sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
