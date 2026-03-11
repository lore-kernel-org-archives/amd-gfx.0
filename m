Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB01125857
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 17:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A014110E3C8;
	Wed, 11 Mar 2026 17:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/hsBpI8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3229910E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqJcbPc272oVNe3jpyMtsQIYzlc2s5ntEfsL9E5Oa9b76yxeUm0aG4cTJ+Av9X2lIN6fc/WMMx1KBdXL02ougkwa0Ay7YFA0BSngiF5TjngRgRg9syXZ7jsAs84txnCMu8TFiC7K8/OA8CRi/0jNkclWLPEGfYgI2o9vRVlZPQbKjzvKXIynUVg9laESVrXuaROKpcgrT7bPZc6xdqfcMr1udX2JDSZeKhP/82oStQRp+ipEXCUU3hf+1B0rTGOJWu/c5pCbLr6vTyiX98iOIKIRGqc+wChoc7vrO3O1ok6McABI2LUzw3eVnCL3UfBVNcE4ubQdm78T//2HRzLTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTIRUs5yX/a1UpXd1fhgGVMWoz6bGEEnZ/g8jASvUN0=;
 b=vxFplxRRePifSCnZ+unY8B3imvXiaXqGGQqmf3Z+8aQ8SSACT1CRc56cBnlpH9sfVIPn4/qBB0Jykbmw55tjphp5y0y+1/dwNqWrHUBq0pIdY74uaY8x5HUsdIbaQpSz4qm6gzqq67L8hgrC3Lll7jjEHWMTkR38RVNMFqsy+mxX9NCKJAqutrMcBWahXdAqvbyO55ewsv6OJziNr/zh2D6Er3gnurW2aegtoSvaoHyqmllsLAZJBjeC0R/U4NHlkDC6W+6Jk0+IWTJXMPxppqZYdQFoVLrSh8MuHrc+i5cvR2zKAl8QO6Yia3YuoglZO58Z2TiqnBzXTBlWZcOa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTIRUs5yX/a1UpXd1fhgGVMWoz6bGEEnZ/g8jASvUN0=;
 b=l/hsBpI8Z9nIFnAEheSbHBAfqn8EusxuZKNmYkMCa9A3spiNuU9Mm5DKTGYKV580bdV5ux4qw5xV4kW/XZ4IMRa6ODOrqTyzNzlNb/U6HFIhAClCsTN8tunDukidw2q2w+V7gvzoTs+58scTzw8ZLYvx8TgOHfSt8JptAx3xxbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 17:02:28 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:02:28 +0000
Message-ID: <48fc86a2-7682-4e90-8aa2-ae5c520c2d38@amd.com>
Date: Wed, 11 Mar 2026 13:02:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP segfault in kernel v7.0
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260311161937.3089824-1-pratap.nirujogi@amd.com>
 <6f7c5cc5-7aab-42b9-b9ae-5312f3da4e3a@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <6f7c5cc5-7aab-42b9-b9ae-5312f3da4e3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb33283-3f86-45bd-2dd2-08de7f8ff988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: bLGqOO/5txLZsBQ9lo0oIpZ1/4k1rLy1G7qG6pUUwQGrleRqpdSHatNq1xl/EmMup4ar1TrDYXiVXxKFvm0WNdIkJXHgfg7fPsCw6rF76F9hKiTX8JYKQFITdqj6OOIwhlplb1vyv6eBrbs1q5J51fk2c4AgxEZpDxzzVuVJvhmUIcBz+0jUIB/NnEItSKXhBc2SYS9V77k/CEOQ+akx7fSxRKjyWKnBN+CaIvjZjpyGOOUL0vaqDIZOUKtOw6z+lWutA8pzRihH9ctP0vRMGBShZmWMVlxHJXRXXDbNxioLC9rJZu28NVY4Wh2UELsPp8VYzRqvSQ9KbQlWU91X6xMqk4U7Ryj5DH27iUjiw6qwKZ7PXx1meXWNtKU/0movITK7gLKAKLg2i/VqkKeh/6RsoiNp/sgmXRt3ohpkcEep5/ZWEOQosdujLbm9XhFb0me7V8nhTh1RhBkUcrtA0M20FX/DOqTRL/SmBhTM12e49Jxc2aNFCYYPlV/hD8C1SOoq6kREux4k3sRQohNSoQY7A6oqFzGOpjnZbov9G1ZMcXEavHLFuzZbYVZpbtnOdoldSvcHCf7ZThY+h/Dym7u2be5TTnZXnhchUDRqwTYWSHXWqZljzUhbVNusNPlhGCGAPC4k70EBwqBW0ykswl6b5V5qqIKIZOiQd1lInPhh+1w8SwXacu26Z6sI8r3Bkp1Cc0l7zsAQY+dxjKJO8z+86PXP6Wbf8uv+KNC9wi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9RRGtpUzdwQU9kallBZDdjak4yOU45dkVGM0hES1YxTXBmVDR2emduK2pK?=
 =?utf-8?B?SFR4S0xBQ1JISGNmYURlaUNib09TUjVKL2NmRU9FeXNCYlVyTUFzQWluQWhx?=
 =?utf-8?B?cDdkTWF2b2JNQ0tHYmpoeWtmR3VRUWN0ZDJCS0t1WHo5akhMbkFjSkFCSWVI?=
 =?utf-8?B?bk9wTmNqRUNZbjJMc2ZIRnZORi9PVUpsR3lJZ2pxLzkvN2Z5dmE4WmErd3hw?=
 =?utf-8?B?c1c0V0Jyb1FHMHF3bzVoQ21INi8vQU1GQ3FGRVd2b0xNSHBxQ0cyckJueXl5?=
 =?utf-8?B?U0UvUWt5SzliMHJob2Nja3NhSWRCdTBoNFVSMFJ2RXVUMEEyUklSU29maHJX?=
 =?utf-8?B?ZVk0S1hJQ28vMnE2WEM5OGQybnE2aHpsRkdWai9BaTFvUnc2WmFEK3hia1o3?=
 =?utf-8?B?a3JNK1pSOGExYlV0cS94c1FLamNva2M5SklxejUzdnl4VWxVMUlCVThuSlZP?=
 =?utf-8?B?LzR2SXltOEJQUndTNld5VE1kOEF4dkVybWxSN0xwM1Awek81Mk90MUVTamVy?=
 =?utf-8?B?cUdwK05nTVAyTkdKaWdyTmovQlZtMkhqa2xGQVZpNG53TC91R2wwelI0TkZK?=
 =?utf-8?B?bGVKK0Y5QmdYTWlPNEV5QXNRcWtTYlozRk1pUHFRaEFvNGQyS2VPUStPV1Zz?=
 =?utf-8?B?eC9IcHRwNFN0cktwMTNaVU1YazNsSlBUbnhnL0V4L2dRQlRWcEdtcEQrajgz?=
 =?utf-8?B?NVJVZXUwRjNPUnRlbjd6aUlZeXpjaDFwd3VjL3psQktCY1Zwa2NYYnlBK0d5?=
 =?utf-8?B?c1UvbnM0VklmdVFadDlQdm5NN0srbjdNWVVYZDZSSmFWOGtncUtRdC82UXJ3?=
 =?utf-8?B?aTM4SjRXcTRNVk9XdTE1WkJmMmNHellMb2ZvUWVndXdONzZIdTZLL21kTFdQ?=
 =?utf-8?B?OCtCdzNHU2FkelpEV1B2WUJEVVNFMW90a2FLUytJcVFFcGhkYmx2NVFIQURS?=
 =?utf-8?B?Mjg4TERnT3I0VU83WVB5cTcvME9kNXNYWG9pOHdFdS9Za2kyUDc4a2Q2NU5C?=
 =?utf-8?B?bFNObC9UcDhBYjZzdDlXZnAzRC81ek9EVWNLWGw0TFBnMFFUZXVUaDA3R3V1?=
 =?utf-8?B?VUltbUJ6REFKS3BVWDJ4TzVwWHEwN3NndTNuOTJhc3BITUQ1ZG40YXNzVjFK?=
 =?utf-8?B?TjdrYzA1UG42dEZscUdrUWRFOTRBVDJYRXpEaHZTREJiOFZNYlBWcnFvUGtt?=
 =?utf-8?B?SVZ1bUc1bmptZmwvZkMxVW5VS1JnZTFVdE8wV0pPVUppT3NZS0o1SHkwRmg3?=
 =?utf-8?B?eVZyVDVRWUlNNDU0SFM0VEpkUkNGTXdrQmQ2c2JKT1orL01QS2gwRE9yRzVa?=
 =?utf-8?B?c3RhSlNMRXRKN3dDWW1uZTA2N1MveTZDZkF3b1FaUXhMUSsrZGFlZUtlMHln?=
 =?utf-8?B?eFVwVjNhS2RSNkJMTjdXdTBCRFIwb2dWRjBCbmZ3cjNyVU5meTl5RjB1dVpi?=
 =?utf-8?B?Y1RhZzNIbHlTTVh6OHcvQWNpRlN5bG5nZzZUQURBVk5zVGNuOFF4WDF6bDZS?=
 =?utf-8?B?OWVwTFJPakp6VmRVY1h3cWdZTytxUnRlai9TYk5TRElTNFF1Q0lZdnJHOHQ5?=
 =?utf-8?B?c05LTHZCSTAzVXFqWWxZd2gyOGN3eVZlUnhPcUJnVFppNzc4Y0hDQklsdEZn?=
 =?utf-8?B?RGRrT1B2U0ptNERIOStvMWpCOGVZSU40bTh6dHdvL3BqVllvTllac2hSNnVK?=
 =?utf-8?B?Slg3U3I3Ylh1RWxwbStRd203MXd6MVpRTnA4ODcrRngySlkvaUJNR2tVTVIw?=
 =?utf-8?B?UWJMTlBBWGUyQUxUY0xsay84NEhGYTJ1VWZqUzZmMGttbE53RjIyZ3pMeVlQ?=
 =?utf-8?B?UldSbzIvTC9CNDZOVnh0L1lxbzJIZDdoUkYvaHgyRG4xMjRiQjhocm1Gcld6?=
 =?utf-8?B?T1JMQ2NJMzc4SjNiMzFwZnJrNmVIOFh5NjNpYXdzYkx2WDlHU2VabVE4T2tv?=
 =?utf-8?B?UGhQanB2dUoyeHpudXRtK0xsbVdsdE1UMEJOWHlPMStYNVFsWWJ0VmZTUVlN?=
 =?utf-8?B?R2trcm9ya2tUOGtlNGdyMnI1eHJMMzlSbVBSYk9EeEV5UWh4UmIzQUEyc2Zx?=
 =?utf-8?B?L2dteDhtbjZ4T3h4b2hEVGQzYkQvdFdZZnJsZ2V2cml2OCtNMWdNdUZmT0cx?=
 =?utf-8?B?TzMwU1pUMWU1RzR6cys3bnByRmxjS0VHejNRNzAra0UxT2xzU2lDajlSRnBS?=
 =?utf-8?B?bkFlZGwxdk1scTRsaGwrZTNwYlI2TGJqQ2lyR0tOaTR0Y3ZUZm9jdkQyK2NY?=
 =?utf-8?B?MjRaQkJLUEc4MkV2VEtyTmt0cjUyNm1PWCtMYjM4UW9ELzNUK0JqUXFPcThs?=
 =?utf-8?B?TFR6N2tMWlZhNk1LampnL3NpVy9RT3AxKzhKVG9lTkdLRjlHcS8zUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb33283-3f86-45bd-2dd2-08de7f8ff988
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:02:27.8952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0top5ZpFPCYZRkt+NHU+aLedStW4fgOCSweiIzsg+GFF6mx1ccFiiJsdthCAfdJL3kMDvoUd7wWfq094EWCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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



On 3/11/2026 12:47 PM, Mario Limonciello wrote:
> 
> 
> On 3/11/26 11:19, Pratap Nirujogi wrote:
>> Add NULL pointer checks for dev->type before accessing
>> dev->type->name in ISP genpd add/remove functions to
>> prevent kernel crashes.
>>
>> This regression was introduced in v7.0 as the wakeup sources
>> are registered using physical device instead of ACPI device.
>> This led to adding wakeup source device as the first child of
>> AMDGPU device without initializing dev-type variable, and
>> resulted in segfault when accessed it in the amdgpu isp driver.
>>
>> Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical 
>> devices")
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
> 
> Did this pass checkpatch?  In order to use C-d-b this should have Bin's 
> S-o-b I would expect too.  If it was just his original idea for the 
> issue and you implemented it a better tag would be Suggested-by.
> 
I missed the warning checkpatch reported, will fix it in v2. Sure, will 
use Suggested-by tag as well.

Thanks,
Pratap

>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index b3590b33cab9e..485ecdec96184 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>           goto exit;
>>       }
>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>           goto exit;
>>       }
> 

