Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00589CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 12:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8083010E71E;
	Wed,  5 Nov 2025 12:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKOBx9CK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCFD10E71E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 12:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOxldSrCX4bAohQHHGZbelLHPGdOsmUaaN2PldOlmTOfziAY7DjQWGf9nHVKfLX4JoaES6jmT3grMf1gC3vc7VQCTLsP/i97/GTJHKFdtCNBjfwkRQalD2PSjkCAeX9kigweJnoZhZEVXGoEgxOqZpxvZeHeIdtUsy/yemr9lKaT/lTnrYeBWJiyv+/xs9YRCnrzCVJWFhdd1sHmdUoDfm0gGkudRHHTjdZ/eBBfk0nSLkha7odHHbTNMPl5PAXwDMPH++NzFZYi33NlyId0j2ah72niTCznhhlPnhbpKFYSsJFuhWCtG56bIcTtuhkgB4swUV+PgNMd8l+E20xCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syXJEFCCTNLqHtsierfAIKDqvKsYHkaWioWWLtzrCPs=;
 b=E3QwlB91lDRQDWNGX7TcaF9SMQecpPLLbuqBabRbaTFX0Q/qUxlOzkWr53IjlP8tni3Spuk6PyI5Tw4BMGkNoR2qKYm15shswSEm4XjWHDW/5vSLb5t70cUf5gsxBZVNYipQKM5lFQnk26BtA9uhH/EZU0RMHl72GfXXJilfeP20ncYA55+w+oKq8+rKcoHp5I+F8dhGee6FCg7s3SuyXMhB0JWvcd2RfsMue0JU8JmHusnYg4b+DBWJSnG7rZ519MTvYDiPdKGJxgllUM+CAgi4VIev4d1sMZOrtnoUQ69Dx966OBfBY6MNM6PEAW86sAzH1eGxLZa8HQ+gdVidRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syXJEFCCTNLqHtsierfAIKDqvKsYHkaWioWWLtzrCPs=;
 b=yKOBx9CK6sZyh/TPTEAXbSECok9uASP4/+GnNJ8lukDzDrZdshW5VIn+vNMX+HMa+YEcXSQT1Zh+73L1zl/JbOLgkmeJSPUvRVyIqut6xC5jocn35d4sFMVyy056EuQJtS3iRyi1CiJXr+aSJf/M5XhYOBvMDgHzuHzfh1lfb2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 12:50:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 12:50:06 +0000
Message-ID: <83602bd7-cf0b-4b74-8b64-48d16105de42@amd.com>
Date: Wed, 5 Nov 2025 13:49:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251105121403.4154169-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251105121403.4154169-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:408:fe::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adf09f3-c01d-4dfd-607b-08de1c69d86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGNZcS9WajZRcE9YS1JDQjJWSzJIWHNVeUY3Y1FLZytZWThJUU80aDRGdXdO?=
 =?utf-8?B?ZjRKSHVNczdpVjlUbXE3SlhBT1RKKytVWi92WXVsdzIxRWxLUC9RZGNYTjl0?=
 =?utf-8?B?QjR0WTJON09qVUZ2QnBncWt3VHFqRGJoemZWN0VSTEZNaHpRMGRvVHJURWNW?=
 =?utf-8?B?VUtpbXYvVmhSbUJWOHVFNlZhTE9tU1RlV1FtWkRmZ2dyRXVnQXFaV2J3NVZX?=
 =?utf-8?B?VWU1NzViUExyaitaTU9EZUVTeWtUZFJCejVaMWdHWU9kS3lSdklFdDFuTXpD?=
 =?utf-8?B?SFQ3MHJYK2I0ZE5Cbzh5YW1Od0hpV09lVlpiREY4TUsrQ3BYNTJIUjZ4MkFL?=
 =?utf-8?B?N2ErRXNWbE8rVWJhbm40ZVE3WmVRL05hTnhPUE9SU2x5TWErM3ZRTkNwOFpW?=
 =?utf-8?B?eks3cjBab2w3RGVPVWNtSmp5djM3ZE9IcU80dGJlcGJGSWc4c00rRndPMlVt?=
 =?utf-8?B?WFd2cXB2akNSbFFXVTN4bnpZMkw4SjRMOUQ0QlNTWUV1QnFOdDMyeU02azVG?=
 =?utf-8?B?SVBoSlhoVzJrOTd4eDFQakdWR0Q3cW5FdGxlY2JBSzM5dnh4VnNkZ1ZJQ1VJ?=
 =?utf-8?B?L2JSSWZBTS8xVnhZUG42K21sMUR2TURJY0VNMkgvV01RaitobFZ1aFdEaVQx?=
 =?utf-8?B?R0JLNFNFYVc1MmtjaGhsb1FEZ1NvcSt0QndKdk9ldUREOHlYUENjbEtDSUpr?=
 =?utf-8?B?QWo2dFZ6eEkxK3htdVhXMEJQdmhuZlBBWEpwTEprdlVFaStnMXlxVksySG5P?=
 =?utf-8?B?dlF5SjYxdWpjakF6TjdqSGNicDE3YmdDN0lyL3pSd1dJdERrMUF4VU5VM2RU?=
 =?utf-8?B?aVl3R3loV2RmMWtQNDhGa1owMm9INjFpYVdET1NtUU12cHI4Y2JoMXZpTEFl?=
 =?utf-8?B?dW9Dd2Y2ZGZpTXVoOWpPcmJNVDBlMzRpNG9NTnc2SnB0Rmh0MS82UGwyVzNx?=
 =?utf-8?B?emwzeTkwWjRuVFl0Qm0zczd1eDRRWGllQm94b1hXU2ZGc0t3Y2w2TWFYZ3J2?=
 =?utf-8?B?dndnRTlJTkZKdnRnZkMwNnJUdE85biticTN3OVpsbEhTOUdKUFNDRk9UeXRa?=
 =?utf-8?B?RmFmV2xHZ2U5WFd1Z2VqTXpLQzcybkNRWU1GdEZsdTRPN2RldGdOcFN0RGFu?=
 =?utf-8?B?OGRiR3h4KzcvMXRsUFFlRmVzWTl4OHV6M0RtUU4vbG5lQmd3QlZWb1FkdHFt?=
 =?utf-8?B?ZmszYUhtSTVZU3p2bHJGRlQ0amdmTkxOeE5FV3k1VTRxZnpid1pUTlYxaGFO?=
 =?utf-8?B?VUE1UkdKTmR2ZnA4YnJIdUk1bWdkcksyK1RxaVl5NG9VQjBNY3M3MXpwSHZm?=
 =?utf-8?B?VDZTa3lET3NYRTJnK0FtNjJCQWdrMmtTVU93bitpdUFCSVJuQTRCVmZIUm5w?=
 =?utf-8?B?VGlBb1YwZ0tQeWV3OXp6YldiR1pnMEo4R1pRQ1VCNzBvUStrOGVmOWRzVEF2?=
 =?utf-8?B?TmdhbnpZdkttTXlUZXdKRjYzczlkaHZicFRJZys3Q29ML2xSb3h3eXhCV1pB?=
 =?utf-8?B?N0Z4TnZ3RnJSbHQ1T0RaZUZCVU9lZEJtaHNNVm1oNFhOWUM3WWt4cDFyTW9H?=
 =?utf-8?B?S0tDYkwyWDgvdnpJeHB3TUxHWXZvT1ArdUswdVVvd28yMEpXb0ZYZlNKdTJh?=
 =?utf-8?B?Q3cwY0NURTZvNS9RSUtSeDZHS2dURWtyM2VMZnltUjhOd2R4emorSmc5aytx?=
 =?utf-8?B?bWVWQ2hyYlA1QmlFOUhpdy9tQ0d1K0NmeVdZMlJVcnJMTmYvcTlVNENndW16?=
 =?utf-8?B?eVB1U0NoTVZkbUVqYUdRYUV0a3hXSVAwdW9RYk5KTW5lbTM3YVI3Rit2ODM0?=
 =?utf-8?B?NmhqcnhJTGdyeXJtUjhUV2FXVjNKZWVhcGVjZ1N4bHBlYVF5aWprY3dHT0Qy?=
 =?utf-8?B?dnd6cHJRaHZnUmVUcUl2KzlhZndSOTlSSTd5aXF0c0hJd25ob24zU09YdG1D?=
 =?utf-8?Q?+Z/6xd7fH9Dg3CkAE/hNFNsQPKt5+S1V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStHdG51QjFKR0p3VDBwSFlBa3plVGZVRC8vVWpGL1pyNEpObjk1M21nZHlB?=
 =?utf-8?B?eWlVVXlXOHBoM1FjMEZrWVJqMjl0Y2ZtcHhHVytzcXRTTnIraXAwNDFibjdY?=
 =?utf-8?B?M1RlMUJ1dUVSZkJhN3ZxZzltMzF1dmhGZnZpT3hoaVJVZTBDSlNhMlByd3Iv?=
 =?utf-8?B?cW9vMVF4TlRqNVQ0dUhiRkhxWjlUTmRWeldRYTJNajh6RngyUXVlRnFZbHhl?=
 =?utf-8?B?SlBxaGJVWkNyN0pyVTNxSTRHQ05oOUxhci95MjE5WWpXWkF3SXpCTlgrUTlz?=
 =?utf-8?B?dEFKcDZSeVpLbEdEc0RiYm42MGNOZHZ3anJYREdaNnBJdHdHVjBTclVOcGVs?=
 =?utf-8?B?UXgxOURrMVlLQnhqV1hkWnJXMXFVcUs2ZjBJOWpmenpKb0Z6MWp0WGR5L1pS?=
 =?utf-8?B?QTFVRDlTNWZQWDRRK2srSlcxczEreWl3WVBPaXRzRmVYZWdFTGZ2c2FJNTFI?=
 =?utf-8?B?UzUzZFFwbUNaUi9Ra1RVNXdXYlp2QnhiM2Z2QkVVRnlIbGw1WEpwSXA5Q25u?=
 =?utf-8?B?MVNSaFZlcUlieStkeGpDMHVWRE9MSzlSRVZxQjRXKytRUUhCNTNyZUJTSEFX?=
 =?utf-8?B?aHVCREJzWHZLVTl5cTBpS3VJMUtXNURGYzZXb0xSZXBnMjlPSG5LeXY5TFd4?=
 =?utf-8?B?bkFuU0JRbXo4eHl2R2F1bEtiU3liMkJXY25lelRybGx3S0NKUzFqVUdQUVov?=
 =?utf-8?B?TWNsSjBOU1Y4OHlwMHVlRVlnVkI3a3FNeUZ1aFpFNXVPYUt6eWIrSGFBbHA0?=
 =?utf-8?B?aVp0eXI4eDFvMmZ5RWF2TkNqdm56bGp6ZDRDSlhuajFiMFVjQ21tL1UySFFp?=
 =?utf-8?B?UFRjSWdPUHN4c0VmMHk0NlloQ2Y4OGxsS1RYSmx4UHdrb2pMSUd0TlF1YzNE?=
 =?utf-8?B?UVVpRlB6cGtSTGxIeFBVL21Qb2Niam1EQW0zbkk1K210QjNzQ1M1V2YyT0VO?=
 =?utf-8?B?YnYvKzRQNEVrZTduRzNPWGt0UmxBeGpOQ05hMURjUUJRS2xOLzR6SXVxcmpM?=
 =?utf-8?B?M1R0UHIzSGRqQzZES1oyamlCSGRTTnB0Z29jOTI1aDV4TW5GdHdUYWFrcENN?=
 =?utf-8?B?QkU4RVYzRnpSRW04NHhpcXIzV3Q5R2ExTkhmNDNOaXE5Znp2UFJSSWtoc1Bt?=
 =?utf-8?B?UTAvVjd5Q3NUdkpQSytEVEtlMXoyNVl4dld3eFZzMzRVUEpnVjhxbnEvR0xw?=
 =?utf-8?B?dXliZHFPQTNMYXcrTlloQzNnUWU4bS9MZFNEU3hUMGJDeWRiUno0VDhOZjZD?=
 =?utf-8?B?SUVsZmwya3kyQUhvaEFvU0EzNFN4dm9rY2NQaWVGanBVWWlFaGYrcUw0Z3dj?=
 =?utf-8?B?Z2pINmU1Vk1MZitTL21lOWIxRVYydlEwcnJ6Q3d5dEFwRFJtRnBENklTaFcv?=
 =?utf-8?B?bjZUMnZHOGZBcklVNGE4aEI2T1JuZ2sxZXpybFhLWkFJblNxQW9SQ29rOENT?=
 =?utf-8?B?S2JHQ085N29PT2hFeGFiLzd5Vnl5QzBrWGdkYmo0RzhGTk5mMHVSOVdEV1NC?=
 =?utf-8?B?UTBxUVB3MWZWY01aN25CMTZlQUorLzBWNU5ueXpyVkJjaUIwZ2lHdng1MEUz?=
 =?utf-8?B?TXBnMnUvTVdFNHQzM3pXMlBCOUorSE9sSWxGUVQvejg1YTBQMXE2R21ONzBq?=
 =?utf-8?B?ajZQRElaeXpBTjVLZ3dvcjJtVDdTMHlScXdaNDVtUkttOEhhTXlIMHh0cE5w?=
 =?utf-8?B?QTBNZXdwbjNHVGFkZmtHMUtiR3Zkb2ZDZjB3cGJtZG5NVFFua2dTaUZvZVE1?=
 =?utf-8?B?K284ZmRkNEtqRW5LbTdUSXNWUUkrNmxUMkl6Sm1XVUhPcVlRNUo5Slh1NElx?=
 =?utf-8?B?YWlWUnlxa1h5OS9mUzZjSnViSmtJS2RSNmo1NEdMbk5oYitNVHBjNTd4WElP?=
 =?utf-8?B?aDNOWDVDL3ZDL2huWGFwR1NteWZCalhZSktlcUhYNUhQTTdBM0NNRzNLWGJU?=
 =?utf-8?B?TVdYd2J4TG1ZYnVqRUowbFloOWRkd0Q3eGhpRTBUYW9Sbi9qZ1prWjdmOGNK?=
 =?utf-8?B?andtYVNnWnFQOWUwSWJWU1U5aDB4cWVDaXFXczBReXJtRmI0cEczSERCWXZB?=
 =?utf-8?B?S1ZOYXFFUTBSZmtwUU9iZEJQR3JaeWk4c240eHZ3YVdqWUdqbWVNNUU2cHRy?=
 =?utf-8?Q?OOc0iRJEpMdFn17pIPONDSO4d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adf09f3-c01d-4dfd-607b-08de1c69d86b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:50:06.3915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7SRBpc++gmnW8aza9Mk5qQqwsFSM5sllSF2QNFNBtfKWcSB4jT/Ss31bueRlAmv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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



On 11/5/25 13:14, Prike Liang wrote:
> Ensure the userq TLB flush is emitted only after
> the VM update finishes and the PT BOs have been
> annotated with bookkeeping fences.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Could be that people start to complain that this results in extra overhead, but that shouldn't be much of an issue.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db66b4232de0..79d687dee877 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1062,7 +1062,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	}
>  
>  	/* Prepare a TLB flush fence to be attached to PTs */
> -	if (!params->unlocked && vm->is_compute_context) {
> +	if (!params->unlocked) {
>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
>  		/* Makes sure no PD/PT is freed before the flush */

