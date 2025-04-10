Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F13C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 08:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194DD10E7B1;
	Thu, 10 Apr 2025 08:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DNvf6Yot";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6526010E7B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 08:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMHWLxq8OBjNI8FMy1nU5R2xl7yyUaq111blj1TaExo2ZJRqwwvzzsUpYlm7PNL0UC/GvTzyJi1DjY89tA5ga5e/dwaH2ayzEZ9nvJr+Q3dmKIKm7fZU/rLptI9dj99uWZdH5AQ8tj/0kfaJEZsEpUbpIK0fBl81hzqO4xqKqSC0l/A3owBw0kxJMDa8v/SUj1f3z5Fqf3hJ5fc9fwPuGNnRkmi2nfJIiLaaPDaUawfC8zungN/yr4rupbNrF49HkW1hm8VsYd+G64D/Sa+6IUeuEFYH8wgczHQOst4YDySms5O+d/qv/ZW4HhxDvHxsh58UCbi41dhuPnS2hFbWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5SfswgZQs+Yer2Ycuz5Co92OYmPJqNLzPd9Qqb3DqU=;
 b=gaISbtBaYfFy9SD/MiE1S3xddRZvE6Ymx4jlW5l+kuKyykxZQIRtb1jD/ruUjnGzZ6BjVBW8ifuGMMt2AIzLXIWpl5klc+18QS3msSERManbAiPLbuqLl8UmBiUjcG5OUfFbBRo60GpnrRLzermbpNx0y3BBKTA36cgWFP6fskwSme9N5g6F+aDs3CeGqefsAidULhw1LPQ2nfnxXRG1vfYFwxah3Rs/mfQfsILB0DHbYyoSix+itfYq92JREzcV0+gseoj3q5U7N3nFY39pWWKPXO2cQZg203KmtQJohxb6KzWdQ7nUwnp7jA7aNp0hFeVqm7Uyv1BvtKJq/ExLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5SfswgZQs+Yer2Ycuz5Co92OYmPJqNLzPd9Qqb3DqU=;
 b=DNvf6YotDowx9SDuGjDYeCAD5DGPSmcGpHLlKsn0iLnG31I8j+NT2sUajuRDuDaealjvDYjNMFlSxYY+DphyfHSLEBpQMwknGfR1qQEqRuWjYd5D5dYbZbJChf0WRKBg7WA9v/vQY8tWj3ZRDRSzBMrRSLidXDK3vXgQiYQzd60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 08:09:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 08:09:12 +0000
Message-ID: <b3bcd170-305a-4e1c-9d7e-814dcb249d14@amd.com>
Date: Thu, 10 Apr 2025 13:39:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250409133955.26169-1-cesun102@amd.com>
 <a79917f2-0883-4855-9802-9c1f127c8f02@amd.com>
 <a6e37b47-a089-436d-be55-da298e844d14@stanley.mountain>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <a6e37b47-a089-436d-be55-da298e844d14@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b53439-dcc6-4c9f-cad3-08dd7806fa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czF1V05FVkdJZVFxVHAwbG9rbStUa3RPZlZhNlJHcEN6WmRIdldpTml6S0FY?=
 =?utf-8?B?b3JWbDFSQ25lekFFMkxzeG5JMEd5QTNGUmlFZWlEdWVmRjZEcnF4UHR2M3RI?=
 =?utf-8?B?S0c2cTVGZkRLQW9BbXltU2dXNzBWVmxZVHg4TTVxSVJtRm1QVzNIWHBPcTNy?=
 =?utf-8?B?dHJJNG5XdE5FQlBsa3dXRkJMTGwzUkg5TUxBblUzb2N5ei8ranhGZmt1RWpX?=
 =?utf-8?B?T3A3MmxKK0J2bC84TEV2bHdseElnRVhHSDRnNnlTa3l0ZDBMVkJ4M252LzNQ?=
 =?utf-8?B?UzJFRlpEQW9ra3A0enY2WU5SRDg2QmtXMEpUSkJuU2R3cHBRdWFqejNxSW9v?=
 =?utf-8?B?NGlWaUlHNVNnK2F6eHNSWEd5U0NXMm5xSkFCUWIveFU0eVBMcGYvNG5aSiti?=
 =?utf-8?B?aEZna1k4WFZaYnAvY0tyQkxyU0t5MjEzZ2RIYUtoZmNvK0xLK1F1bk80TTJy?=
 =?utf-8?B?ZzNuL0xMMkhqZ1lGaXhhMW83NkRBbTZ1N0QwYU5pMzFObWN3R0wzNHpFU3R2?=
 =?utf-8?B?Si9GMGt2UUlhNUhFTnVacVlqUlQvbzhsdFE2WHN5cFlSSWg5eUJHWWN5UnpC?=
 =?utf-8?B?d2twb3UyUDUxZkJuYmFHNGhGZi9BRzNUaVB3L1paaDl6NUxMR3hJUFErS2Fx?=
 =?utf-8?B?Unh0eEkrb0lVNnlWMnptRFJsN01Xa2JVb2Y0REJmcXp0MlU3a1AxZFAvblBv?=
 =?utf-8?B?K01lWjE3RzBNOW85d0J6aGhRSTJlNDN3UERWaDBXMlpsQ3poSE1WSG9tTUtN?=
 =?utf-8?B?YTZ4ZEVpQS9oZllYbkxLMTlVeU9VMk5XVjJxdjFzeEVOdnlRanFaK3lpWWhn?=
 =?utf-8?B?eXNYRExnV0F1eUhMMU1NU0lvZ3JiV0txbklTQTVCc2M4QTFFTXBMQmN5elJH?=
 =?utf-8?B?STNhYnVuVGFlb3NZM3ZHMVFmcWFSWGt4N2U4Qllvd0xsdHJSb212eExxTDFQ?=
 =?utf-8?B?c2hyRlVvUEFrUmtvbDVSMFpMMm5QNzdsSXJ1c29EUjJWeWZzSGZxUGVja0R1?=
 =?utf-8?B?N1ZPR0RzOHdCZEZJUEhQUlU1R2x0Umtua1Z1MEgrek1JUnF5eTZTRUNPa05X?=
 =?utf-8?B?NlNROVVzWHEzZlZQRzhOVHhna1BFUDZPTDFCSmltT0xXRE9NSmY0eUxhcW16?=
 =?utf-8?B?ZkxyMEc1OWJha0NGVnQzQzNiMUR4enA3UUs4bFZmRUg1enUwR3YzcDBLWndu?=
 =?utf-8?B?WHFVMFFRN0tLZSsvUW9DQUo2NlBPVkgyanVOVG5DSXNUdWZmc0YvRW82U0VS?=
 =?utf-8?B?Uko0R2xla1NxRkFvbHp0MVgxYmZUM29FQ1REUkxiS2JQTjM5QnU4Y3VZOVh2?=
 =?utf-8?B?VkVNT3p0WE4zSFFRUjBoRmtCWkRlc2RWblVtaW5hNS9GYmRFbE9Bd0JBUW8w?=
 =?utf-8?B?WGE3d0hTUVJmUEtIMGs0ZjdwbmlvSFdKK0MrNCtBNG9wVVhLUmUyd1RnSDBM?=
 =?utf-8?B?VlRVRHViN0s5QTZtMEoxVloyWHkxWUlqOUJlajJDK0J6Uk9VVVJ0NlJFQnlW?=
 =?utf-8?B?Y25ob1FDTnZhajczSlFxbDFOZ25OZ3VtUHJrdDZvcXhlL0hpYlFlVk8xdVhB?=
 =?utf-8?B?WTY5SVJVeVBxdldRbmQ5eXdIZDJycitsZkVPRHVTQ1RoRGZLbUpydG1LeW9M?=
 =?utf-8?B?cDdOZk1hT0JjaGdYODlsOVpOTXMyWHpic2JPMHFaaW1wSWhtQVdsSDFSL2M1?=
 =?utf-8?B?RDVaWG9hbVBhUzcrWHZVZDZ4dWVZOWgwQmc3UmFPZitleVQxOXp4Q0xVemMz?=
 =?utf-8?B?b2YycmZ6ZFg5UHRocWNzMURBQTY0Vms2L0FzejBib3d3S1JRWkc5S2lzaS9J?=
 =?utf-8?B?TEN6bStMUVc3S2VIV2tnMG1GVmUyZWp5WFkvZ1B6a2srcHRFQ0dsRnlBbytM?=
 =?utf-8?B?SDUzdFZnK3hxblZmaTVlaEx5eGFjdVMxVm9WYkprNk9DTWJxK0ZRcU9seUY3?=
 =?utf-8?Q?4hQ6GzCsJ+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtOZUY2b3k0NkJqYXJFMjhMaUM4ZFJ1SkFxSUcyc2NoMTZSeDYvaDJ6Mzh6?=
 =?utf-8?B?enVjOXNYekk0MGhzbmNnUzJTOGtHb3dXWTV3QWY2OS8wU3dVdElBV0hza2hr?=
 =?utf-8?B?blJnK0dGUWZDTWlRK3VFUFZIQWRSdGhCekdDNVhKVy9qNjQ5T0xVbFpTdVFa?=
 =?utf-8?B?eFcwUnRpTEVTWGhOOHIzUTJwakhMUHNtbk1LQmQxTWQySmRFR0hJUUsxQzZ5?=
 =?utf-8?B?Y1drNzZiUjAzWjBKeXdVUWh1bzBDTUtWQTYvcVU1N3hHS2ZDYS9OZzgwUnRD?=
 =?utf-8?B?ZTRzbVo5aFJ6enJ2dFRIenVuWGY4VDZ0Y0dIVVdaT3pkSzFTTGpvdjluQVdN?=
 =?utf-8?B?c3ZDRU5YVURCdy9NU2pramdrY2pnQ1FlYnpPUWFPak1JWWZ4ZDFJK2tCOTAy?=
 =?utf-8?B?bFNVM0d0d3B3RjBPcDJOeHlYbzdvUmVuUWgvRVpPL0lhdTkvdFlrUk5xYVdp?=
 =?utf-8?B?MXJWbHlEQ0laa0UyYlUzL3NWWjgxMEJzdFhSY0p1UFUrdFNxU3QwSjhNUzVo?=
 =?utf-8?B?c2V5NGEzMXd1bVV3Yk1ienk0TVJXVWFNZWUvaG11SzR1WXM2TUFGb09BZTVF?=
 =?utf-8?B?SEVlNitiY3kzelNldUc0bGxYczdBdmJSMnFHcFJ4UWNUN1BXTXhRd3lWSDNO?=
 =?utf-8?B?aVRlZG5FM1VqRm91dzFrV2lUWTV2anc4c1ZWcWlEdDRjVjNFdGNzeTRxRVNo?=
 =?utf-8?B?QnBWVUJ0RlNOVnJnNXN2YXJiKzlNa2lQRXQ3azZkSGxvaWlCQzkreVNQN3Rz?=
 =?utf-8?B?UEJXMHlTLzhtUExTTVR2eGIvQ1NpTytJZDNLdDg0bExnMTE0R1RZUjZ4R3Zy?=
 =?utf-8?B?WS9DMndkRE93d3lWZmt1elZpbk9QZis0R1BUa3VuR2tWb1lGdzVZemlaZnN6?=
 =?utf-8?B?ZDNCSnJGck9wL2pSd2tOdXJ1K3V6Nk1adFFicTlQbnhUcnNYR21OYTVXNmFF?=
 =?utf-8?B?NjRzU0o2TnBlNVVJYkVETHJKQXRPb2VRU3RHaXVPQi8vR0FYVmFJYWtHN29S?=
 =?utf-8?B?Znc1OFROMnY5MDgzK0NxaXo3UjZ0dmlmZldPd25SSFdWQWg1Wkl0R3dNVWxa?=
 =?utf-8?B?a3RkNldNMUxkMTErZG5KYkZjN042TlcxR0NCMjg4UWhmMXpHRDAwb1dmYlQw?=
 =?utf-8?B?T0x6S2NKMEdzUkVRNGx6QzlWbEkxWkk3Q3NlQUdsT25DcjBRUFM4bE5ZMnhJ?=
 =?utf-8?B?eXpkT3lrclllWkNzRTNkaFY0eHl5aDlsNnphVS9VRlc3ejZrQ2Jlb2k1bHhr?=
 =?utf-8?B?YnZmcnltYkRNd00rcXBjNmV4di9FeFg1alJ6UnEyamtwN2FyVWxWaVpuRlpF?=
 =?utf-8?B?c1puNzFwemR6K1ZNQXVyYUM5OEdwcnRybXVnamt1MzhpL3dXWEZtMjhtZGxR?=
 =?utf-8?B?a21wUG5vVGI3UWpUcVZKVkQ4dnl0S3htQzFheGt6ZmNPcUIwSlFtRFJqWmUv?=
 =?utf-8?B?MWErcUU5cUJoM05SRjNzdm1NYklOMHdoZXdSbzVCSFdEV084MzYyM213Zmlv?=
 =?utf-8?B?Z0dVVGNyU0NnSFRGak5oYmhDa3d3aVRpQVljbjhST0RRTXRIbHJHNmFzeFhR?=
 =?utf-8?B?bHF4aitrNjVLVjFUaThVMkFYNzZaVlBYMTNWMjVqQmpRdzlQaFcrV2xKRmU2?=
 =?utf-8?B?TEJUN0dDa2wwaDkyZHpWc1ByamxkY0NHanpEU1NHVVlSb1dqSkNxcXJaR1Fz?=
 =?utf-8?B?UmZIWDVGZnFvenZHVGpoNUV1SjJMbGdvSXk4K2QvWmN6M3QyVEhORERLc05N?=
 =?utf-8?B?RlhGS3pvNEx6VGJxVnJvaHlpbVpWWGp3TFRLeDF0NitydUtka0dLbzkzblJl?=
 =?utf-8?B?Y3p1Y1BSNzRVeFRnakIvQVVoY3hCdFovTW93ZGMwdjhMa0p6RDMybHNpd0hG?=
 =?utf-8?B?ZEpFSWs0cnVGNWR6T0plQnVHRXcxYzhzZFQvMjJvRkZXVEJ1QzhKUzFGRVJ6?=
 =?utf-8?B?anVpR0g0amZKVGxWdXJGYVRoek9QcTNqNmVkZGdrKytGRFRLY2VaMEQzaU41?=
 =?utf-8?B?V21zMER3L3g3SnJwYU9xR1V1VDZjcWJ0eFp2WXdtTnBZaWQ1alhFd0FUeGFh?=
 =?utf-8?B?WDkwK2JLSHo0MnA4dEp6VHF0YjM4Q0Z2V3BrbkZhdEV3ZmZadklMQ1ZVMzdY?=
 =?utf-8?Q?Ke3vk6XFy0NlIsXP89FBTpbZ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b53439-dcc6-4c9f-cad3-08dd7806fa70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:09:12.8383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjtUzKb9LcRj3xnJUmm50eQUFaaDZCf06EzlzopjIC+qdKBgvuWMIQ+L+++Ryfv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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



On 4/9/2025 7:26 PM, Dan Carpenter wrote:
> On Wed, Apr 09, 2025 at 07:19:25PM +0530, Lazar, Lijo wrote:
>>
>>
>> On 4/9/2025 7:09 PM, Ce Sun wrote:
>>> Checking hive is more readable.
>>>
>>> The following smatch warning:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
>>> warn: iterator used outside loop: 'tmp_adev'
>>>
>>> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Signed-off-by: Ce Sun <cesun102@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 60269fba5745..6fb234832ff3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6784,8 +6784,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>  	struct drm_device *dev = pci_get_drvdata(pdev);
>>>  	struct amdgpu_device *adev = drm_to_adev(dev);
>>>  	struct amdgpu_reset_context reset_context;
>>> -	struct amdgpu_device *tmp_adev = NULL;
>>> -	struct amdgpu_hive_info *hive = NULL;
>>> +	struct amdgpu_device *tmp_adev;
>>> +	struct amdgpu_hive_info *hive;
>>>  	struct list_head device_list;
>>>  	int r = 0, i;
>>>  	u32 memsize;
>>> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
>>>  	} else {
>>>  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
>>> -		if (tmp_adev) {
>>> +		if (hive) {
>>
>> This doesn't look correct. I think the original logic is to have a
>> single device list or multi-device list when there is a hive. Now this
>> skips the step for single device case.
>>
> 
> I don't know what the original intentions were, but what I know is that
> this code will behave exactly the same as the original code.
> 

Yes, this correct with respect to the new patch. But the patch which
triggered this warning actually broke the single device handling path.

Thanks,
Lijo

> regards,
> dan carpenter
> 

