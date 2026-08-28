Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D43C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 16:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D5910F40B;
	Fri, 28 Aug 2026 16:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dGz9Dty";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF6610F40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5/rkmKo9YVpHU6DB/RWpjHzbWc9dOCpHaBjjTV/BShcr6XGBQkrCDsLdEVr0wAdSaTugxe5arX+DL8F6IQspQIXDXHTCwtIygNIwvMpbm67UcCLLAlfTF0mN75/V5xkh0bEjwMe7we4tWZu+73M0T8wz+n5I9FEg3cZzXVg6BW6K0d8DJPrl7HRISq3h64KUDhcAvwrGdSgePkgRfNxdcfsI7wOpFMiijXRucSGFVwBAx4ofaOG3CWf2BMlJTBdFkO8MqAvo76QWIAHB/N1VHeP9yk86li2SY7Z530SLS8rm4Te3Olw2uSFd6fcq13mBxsKmrenyfR8gTTQYr2fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5IbD4sSSF2Py9v1k1eJ91BLX90eG8VC1LbHCl66s00=;
 b=TX5nGnBRmvX6jxWucpZ7H2Dm0H2PxT76dzbJq/AVd0CIiO9Ww2Nk0yJq2cfoNqN/UNUsCW3B9atA2HUtXoyxFnaLF2mzkVwCkSGBDqgdTvYu2lJqBYQV8SBSPxtXfQeEFKk29bT/h7PIY5zTZ/CtCIofVnv8VEcjIiyC4jQByhGrmm2162vXDOLbAD0HSahP8KyL8biYGTTUgHoeWUmpRcfggtOmETH8lr4lu3G579FnKD5ztgXW+xtGBkllB7oqE7w24ZS7Ee43+VW3p3XDb7N8wxme/4qlUH7o0FYNWRYBCileoPIzp297XjdF8qXAYhv/afNmihHS3OJpmRdeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5IbD4sSSF2Py9v1k1eJ91BLX90eG8VC1LbHCl66s00=;
 b=0dGz9DtymdnDG3cFVRbC859x72y0RV+I8mQ8+xs1VcSO1zjjMwfyNM81Iqr1kZrEVoqgAWXZ0X9j5NdaeZKesWEcd+b/Y1uFnoBTdCuEndr/m0q7NhhrTHaC90HODyPC9W6VVJ0pmXtcHZwsz/ec4WiT3mE3uTqOWB+KKD8imNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:59:55 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:59:55 +0000
Content-Type: multipart/alternative;
 boundary="------------dTxOZc5IXy77X3tA92x9PCHj"
Message-ID: <fed314d0-c0af-466b-8025-76367d880964@amd.com>
Date: Fri, 28 Aug 2026 23:59:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/amdgpu/gfx11: hold userq refs in private fault
 worker
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-4-lingshan.zhu@amd.com>
 <7d6223cc-4071-4ade-99c2-3a1acff50663@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <7d6223cc-4071-4ade-99c2-3a1acff50663@amd.com>
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 425784a3-731a-4f36-1f2f-08df051d66f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: BonpjkwP/dXVqB8DejngclGI6Hg1gKQegUJlQ0TKJLjThMmnqKuigjZcvhvm3jE2kn/xdWMAyFjOiFi4jN96uXgLuVRqtIlsRTQn0PgaR+dNtSE2cHfFn0UFg06k6k4MWUDx93aP/5lEyiGIrxZkt8L8DNrwGxtQyBXDkrX2rrU5RBKP+rpk7jPI+d0RNmi9AH+fWrX4BYzVQQSmqmJ3qHsgTMOG7p9za+aoHtMt3dAgRRCFLSHO6l2WaGXJ/khoa9ZtXFn1IIzfITezHSb1MYd+fPdY2DAaRHoX4z2UgzZiNZXIb42EBueWoDAu2Z8MJeG5jFJaAAkyljgDQcOduLZSsdJwm33WHcFbv0oZrA2/5FL1DW4HxdUC9a0uW4MgfSm7ViHHIev4AVNDKwHhqwgc82tCHPgwcP1C1kvIkgcEr7pCOSKOK6cw8vWjlBV0YTHerr7DUfV20zQGi/jcD67swTi/9TkttRTZBqzvR9D7gNsQZERGFC78uAgXj3gDoU4/BcZSmyjxWIbZvwOxKGdk0IawgQ6HYBXUz/OT/V03JA4al0YDoDLnU63XeT3iG+8c1LGHE+D4mp4SF+NhD9x0Lu+qLG9TNeJtfIYMg4xi4ANWWMbkpM2+/KY4WDGuwl+Y7418jHvJpw6Y0DThasfJ+IEd6jXFvBsrSutBQdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBna0I0ek13R3doZ1YvRzRZbVpZd0Q3ankwM0JMRmhHcDluVTlsL09lRjg5?=
 =?utf-8?B?YklabHFsUmhDbjd2RUdSS2xjeUMzd3lmdUUwcEw4TXR0eFZwcVRCWVI4RGwz?=
 =?utf-8?B?VG5yRVQ5bDZNTGtRcDFNU3JUZ2xYRnJQcWpkeWFNMmdDcHU5SnZTZkpIbDZH?=
 =?utf-8?B?T3dLVEh2Qm5nQ2lNTjNoTWJMaXpNYXBQbk5jbm9zNE0vUXBnZ3RNZXN6bDMr?=
 =?utf-8?B?TTdMVnE5b3BvMUdiVmx3ZXBISzdtSTMrSncyVlQxZm9hRk9kRlR5RVhsRUZm?=
 =?utf-8?B?cmZOZEVPRllFaDVXSnNZWUwwOWFrdFFRRU5WZk8zQWpVVkZwREJKTVZIVi9P?=
 =?utf-8?B?MzJMM0NNY1FzMWdlWWNRUDZNbGNJbFRsWHR3OGFGVnc5L09jL2R6OStIdVI4?=
 =?utf-8?B?cUhvV0crTmNkOXNHNDU2WVNNZE5VYWhMTTlKQ20wTHBsWVZBdHRLbTFVVTh1?=
 =?utf-8?B?NFJPbzJwL2hrRlRMZ0srNlB6MEVxUjk4UlNMaDJsbE9HYnF0S0Jvdk9Vc2Er?=
 =?utf-8?B?VnBFNGRlRTg3RmRZNEhmZnF0cXVPRlJyQkxpU1VZSmg3ZG1Dd2xvN1VqSjA3?=
 =?utf-8?B?TXlDRmhsSEp0RmRlektDTGQ3Q1VmZ1ArNVBhYXJzSks1RFVDZmgwdDU5R2Zo?=
 =?utf-8?B?dFM0QlhQTXR3cDlOcUx3dG1uWEhnc25lcHpLZVVySVV6L3VJQ0ZjK0hBV205?=
 =?utf-8?B?ZGZCNWxxbDllZ2Z0NjdpK1cwWG0zTXJqeHRiTEg4L0gxekJDaFJ3blcra2tt?=
 =?utf-8?B?Vmt5eDVscWV0anUxL3RSdG4rZUtxWWFLWWJCVHZKZVhZdlJsNnVveS9tUlpD?=
 =?utf-8?B?ODRYS1AyMlZyUVMwSzZYRFdsQUtHVXd2bU55WUIxZGZNSXNqcmZZd0hOL1Vi?=
 =?utf-8?B?bEVjMFptN09mS2FXZ21EckFoZTRhU2gzcEhGUVE5eElRc3dMdmxCY20vbitV?=
 =?utf-8?B?eEVRVTVmRVZ0NHJxdDZGQ2ZLMzZZU1ZNVUhyMG8zbVo1bWx1WS9JUU9DeEE1?=
 =?utf-8?B?SXI2ZEpWb1lJMzNDaUE2UitQUFlJYXdhbVo3eS9UQWN2NVhaSm4vWnczVHhX?=
 =?utf-8?B?Qi9yT1RiQjcxWFZFWk1xRURqcFdCV3N0M3dNQVlTeDRxTFNNdWw5M0diWmlv?=
 =?utf-8?B?UGxFakxPUEt3MkdmUCtic0M1Sll5RVhRcEJ4REpCZ3FtbnZsQjBDNW9kYWRW?=
 =?utf-8?B?Tk1hSGs0aUFIQjJhaHJUdDIxMWZYWE9KK0RBUVQyTTdvbmFjUFYreStsbURi?=
 =?utf-8?B?ZmthYmpKNkh4WnJPb29wazhaNDV1UHBXS1RHczlKNTduMEpDWW83QU5BdDZJ?=
 =?utf-8?B?Mm9oeEV2L2VkQnNiYSsrTGJLZGJIaWdCbHdwNWZDWDVZL1V5UkIva2oySU8r?=
 =?utf-8?B?VFZsZTZLNHdqN0ZnZHdkMU02a3BVR1lRRmhZOHJRT0NnZFEyaXdueml5NWhL?=
 =?utf-8?B?NUw3cG1JUTkzYURqTmk5RmtTUnRqa3ZBdFU2aDgwQTFJVTJMbGRMdGt2LzNs?=
 =?utf-8?B?M1lPdmpwQ243dWtUY3p3bmJZclpjdEEwSHNDV3BQZEVZSVRLNUhRSG0vbnNj?=
 =?utf-8?B?SEhPRXdvWjRHaUtnQXZRdE9Ybmc5L2UvYnF2eGJoblc0Tm1zYmY0T282M3lB?=
 =?utf-8?B?dUpBZHFCekkvQnN1eldiaU41VE9GeUpXSDdQbERYNnBSTEtPRFJZY1BKMTkx?=
 =?utf-8?B?eWxFazlnTTZsRHY2VVNXVzlWMU0vVmlKNG1SZHhxRkFpZG5xZGVLUW5Hdkgv?=
 =?utf-8?B?UGFXaG5seG9MMUhnUnZTOHVSMnB4YnJxZUpDdTZ3T2F2Y1RhQkhsdUE1YWVF?=
 =?utf-8?B?cG9RcGJ3UHBhTlZtVFUwT2NyR0paaVRXS0UzREtYd3dlMnlyMTJlRFFjQWxx?=
 =?utf-8?B?S1UvYzBYcVlvK1FDUHZHWW1LSzRrM0VQS00rWWVDRkQzR1lxNUdvQktCSlVq?=
 =?utf-8?B?ZnhpMUVWa242VHZGWGlVWjBxeFlKK1BPTmVGRlJyRnc0OFJXV3pKQW9uSjl6?=
 =?utf-8?B?QmVqbGhBOTVOb0FpczUxNWQ5SWJ3ck55M01TNmVKMlB5RUI0TkJIZHlJZThR?=
 =?utf-8?B?SitvZWk1Qk5VODNaSUNMYU56UXRRSDRndzlTTWNHZEg1NldJRjBnNWNEMUc1?=
 =?utf-8?B?Mys1Vk1LUVBlQWtDc1FXam1EdkhMVkFUT2dmeXhLVHRESmNHMUMrQ2xLdUFH?=
 =?utf-8?B?amExc2o3OFBEWDNXZ0QvNFVESHFiU04yWXVHekdkTFVmRVpybHR3NFlSNXAz?=
 =?utf-8?B?R1BpUklxRzEvZ2lMWm9kS2R3V250VVVFRmlSeFhWR1l4NWYxdXlnUHN2d2FQ?=
 =?utf-8?Q?U37aA8eIvaUVcAEh1F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425784a3-731a-4f36-1f2f-08df051d66f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:59:55.2987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fVrQflYTzNU+GBH6RYak/hUZmOau2ubBnPTfQK2w6OpZPKBfgy0J9rvk2zIdFbJIviqFqIrt0H87ruf+3t4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

--------------dTxOZc5IXy77X3tA92x9PCHj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/2026 9:11 PM, Christian König wrote:

> On 8/28/26 11:53, Zhu Lingshan wrote:
>> The GFX11 user queue private fault woker loads
>> the relevnt user queue from the userq doorbell xarray.
>> However it does not hold the spin_lock of the xarray
>> when walking the xarray, and does not increase the
>> kref of the user queue, so it races with queue
>> destruction path and may run into an use-after-free
>> userq problem.
>>
>> This commit fixes this UAF problem by utilizing
>> amdgpu_lookup_queue_by_doorbell helper, which
>> properly hoding the xarray spin lock and the kref
>> of the user queue.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index a447562977ab..a063f86a8847 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6733,9 +6733,12 @@ static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
>>  
>>  		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
>>  			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
>> -		q = xa_load(&adev->userq_doorbell_xa, doorbell);
>> -		if (q)
>> +		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
>> +						    doorbell);
>> +		if (q) {
>>  			amdgpu_userq_start_hang_detect_work(q);
>> +			amdgpu_userq_put(q);
>> +		}
> This must just lock the XA irqsave, this code has been suggested like that before and been removed because it doesn't work correctly.\

The xa spin lock is held in the helper amdgpu_lookup_queue_by_doorbell().

Please see patch 1:

38 +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
 39 +{
 40 +       struct amdgpu_usermode_queue *queue;
 41 +       unsigned long flags;
 42 +
 43 +       xa_lock_irqsave(xa, flags);



Thanks
Lingshan

>
> Please check the git history before suggesting bringing back a buggy approach.
>
> Christian.
>
>>  	}
>>  }
>>  
--------------dTxOZc5IXy77X3tA92x9PCHj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre class="moz-cite-prefix">On 8/28/2026 9:11 PM, Christian König wrote:
</pre>
    <blockquote type="cite" cite="mid:7d6223cc-4071-4ade-99c2-3a1acff50663@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/28/26 11:53, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The GFX11 user queue private fault woker loads
the relevnt user queue from the userq doorbell xarray.
However it does not hold the spin_lock of the xarray
when walking the xarray, and does not increase the
kref of the user queue, so it races with queue
destruction path and may run into an use-after-free
userq problem.

This commit fixes this UAF problem by utilizing
amdgpu_lookup_queue_by_doorbell helper, which
properly hoding the xarray spin lock and the kref
of the user queue.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..a063f86a8847 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6733,9 +6733,12 @@ static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
 
 		doorbell = (db_ctrl &amp; CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) &gt;&gt;
 			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-		q = xa_load(&amp;adev-&gt;userq_doorbell_xa, doorbell);
-		if (q)
+		q = amdgpu_lookup_queue_by_doorbell(&amp;adev-&gt;userq_doorbell_xa,
+						    doorbell);
+		if (q) {
 			amdgpu_userq_start_hang_detect_work(q);
+			amdgpu_userq_put(q);
+		}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This must just lock the XA irqsave, this code has been suggested like that before and been removed because it doesn't work correctly.\</pre>
    </blockquote>
    <pre>The xa spin lock is held in the helper amdgpu_lookup_queue_by_doorbell().

Please see patch 1:

38 +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
 39 +{
 40 +       struct amdgpu_usermode_queue *queue;
 41 +       unsigned long flags;
 42 +
 43 +       xa_lock_irqsave(xa, flags);



Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:7d6223cc-4071-4ade-99c2-3a1acff50663@amd.com">
      <pre wrap="" class="moz-quote-pre">

Please check the git history before suggesting bringing back a buggy approach.

Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	}
 }
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------dTxOZc5IXy77X3tA92x9PCHj--
