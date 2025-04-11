Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5659C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590CD10EC39;
	Fri, 11 Apr 2025 17:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBc1PhgR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F1C10EC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWQlCJXXyay3XOsK80HnCXjZ4DL+Np1pU3H7O5Qd1DJFyLQF85DfKRnt3Xrb9HEg61IRIeUSHEPsutLfKKYGLzfUjXKcAwt3P7H8lpkMKUVlQAWa6C1zpVhSLUxSKL3HdvGXKWf+L7qslBddP65nEpbyw98zVOmKFTYPX4K083WMe61ozDHTD1zgsTzqohQ6yU6bjtA4Gcii+LWSxnZvH6ss3DqEUIF+nl0dZ+Sk4HkgjWmVHcKfu+WmlsWyNevRJ8k+NmKULT35whO/LJB5lLU4zHJrgKwufilxqDPSu6iA45YtX7uuCeUZpbULS4b81vRZX8hcqGDxJ9FrpANHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyrvi2zmyJ0pGC6GaYbbW+AFRy2lQ5HOomRN7LcVPvs=;
 b=J5EnUMJm30pYj0uYAtUBLvslapDkr4/H+X2DqXQG8tlkrFGsdRMyIDg8ZipGKLJXn6S6BFNUwVVDhageLMDRP/FkZDVqsH35lO8CzFAII3v8aB8lD7xbZRiG83gevJ3Blldc+spwXXB+TCcAo6cczyIY/bzwpkKW0aUr6XvGBPnM1DYMwBwtEtGAeGzcm+L4s6z5LWR5BuEYPpBxvLBRJmpQD3o3AwhhvOJyNyYM2uY5LIj4LmYF92lwtPfI0+Q0j/Qtt8R8+lYMiUWOMmmJfXl4lYumiT1b1cN/0fCqjaaJ337A3h2f7c9b9NRIzahvwXIuAz58D5K4mO70JzP0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyrvi2zmyJ0pGC6GaYbbW+AFRy2lQ5HOomRN7LcVPvs=;
 b=EBc1PhgROh4m9LYhSoQv4loZkg/7PQNn8XpXqDZhNrrFd+HHW4tFaNwn6XX2CGdqsHVHT/G3kWSu/vgOScp0h9v8GnxkrfYtJigKUVN3lC2sN5sMeybS4GqpJLuAtfKf7FAkA/mOpKhkhIcuoGiZIJCmZPuJCpl989V/Qd1LsCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 17:07:30 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:07:30 +0000
Message-ID: <b372fade-f4d6-4eb5-8654-354d6ba4d1f7@amd.com>
Date: Fri, 11 Apr 2025 22:37:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] drm/amdgpu/userq: enable support for queue
 priorities
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-7-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 91496cfa-79af-467f-186a-08dd791b57ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWFJczJpM3ZzYzd6SHdVUGVkL1NUMW5vVk9SOHk0Zzlzd1podmw5VmdFbW1Z?=
 =?utf-8?B?ejBKOU1MYlVMUFRWVVZ0RzZ4R0Qyc0NVMkpFZHJMWFR4cThDSzF4UVRuTFRS?=
 =?utf-8?B?M3RuR2dqZHZTL2hRTlNCZDZLdDd2QzZ2OE5CLy9BNzExOWsrSGlTajBVZklw?=
 =?utf-8?B?Z2tpa1I2KzMxTGdNN2ppUEF0YlRqb0lQbWRWNVZQL3R6enFZTTNvQ3hOZ3lO?=
 =?utf-8?B?elRPUjRCcEpESXBaRnFGRG1vOWlxdEVqUGlBTXRMcnRpMmg5VkI5SzZSQytY?=
 =?utf-8?B?UTlpRmFOdVRXbW9hU2VWUlVhajliRmZIS0UyT0NQQ3JSQU9LdElLd3cyNnI1?=
 =?utf-8?B?Z3RFMGl4MVBMTnNEZW1nZ1F2S21zWklmWXNVV0ZGUStYWmozeFpsQkNNZnM4?=
 =?utf-8?B?a0R3S2VQSUhVYWhrZlVGS1VpNUdncFc1Rk5GSXl1bVVsU09xVUFhOS9SelU5?=
 =?utf-8?B?Zk8rVEFESngxTk1UODljTjIxK3grWTByMSt2akh2M2xjYmxjOHNIdllqTlg5?=
 =?utf-8?B?UmRlYlE3THpVY05tZi92QUd6bXlLY1RTN0dUY3Z2ZFVuZVpyckJBMlJsNTZv?=
 =?utf-8?B?SS96RVpZbmczditHVmt5dzNodDNsNHczSnFDSW5hbDc3VE9BbXR3MXJQeHNF?=
 =?utf-8?B?QmxnNnE1NHpsQzdrbDRSWmlQTU1CcC9wbzlSeVVuVTNveVR0ODBnNU1mblVl?=
 =?utf-8?B?YU1KZ1dBZlk2S3Y4RVZaRFB6cmFTSzMyckdzYlN2ZnpDZGxzVHhxU2o3RHow?=
 =?utf-8?B?ZDV4cjNQYWxreDBFY1NnRGVjeG1vMzdFU0N3cXlTQXB2WDA4b0t1cUIvbk9O?=
 =?utf-8?B?dFM1V1RXdXl4amsraWtZS2JhUzJ0Mkx0YXRpQUhFeWFnTUpyTjVpS2s5N0cx?=
 =?utf-8?B?WDduNE9mQU1ZNDkxSllTL3ZNRkQxZGdTZUJtb2QxNURObjJSUzZ4Q2xFbWhF?=
 =?utf-8?B?MWNKWkpMWTN1QXB3OHRZVzdvM3NxU2EvNmRiRmYxaklwV0UzVStVeTk3eWNT?=
 =?utf-8?B?MXBwKzc2UEQ4ZEJuVU9aNlBEOGtYK011UWYyUElxMkYrZGV0OGs2TG1aZEhI?=
 =?utf-8?B?S240eHVBc09GdUM0d1hoSi9aL3VmUC9udEpGYmNEbE1MQWd2RzRuVVFjNFRS?=
 =?utf-8?B?aWl2QmJJSEM3QWROeElrZWZ4VEFaQkRsZHU2ZUpmRW1Wd2s5VEM1bkZpenFS?=
 =?utf-8?B?NkU0UWtFTmw5bWpUSk5ORktLN2JIbFhzSjg2dm01VFJlWVVyNUxiajRQWnp6?=
 =?utf-8?B?QnQ3RmJaR09lTE5kZDhuUWFiVmtEVCs2VTBkcTZKMklGeExkTXZCV21jTGgz?=
 =?utf-8?B?cTQ2amxqa3NYTUtNQXloSWxWY001UW8xc0lIZWI2QW1yam5jVVZLc0ZpclY5?=
 =?utf-8?B?MDVhSEhlUlp6RkdHMWZBOTJLa0tGTlJEYytOSnAwQkljbFNNd3RlOU8vV0pL?=
 =?utf-8?B?MU5tcWIzU0c5R0ZBRkwxYm1xQkx3cmdBeHhqL29icldxbzNGcHlQcG1hR3Ru?=
 =?utf-8?B?OGtFem9nL2crSVprSjlNVDljRTlqNE9mbkpZOEwrbC82Szg2NGpDSE5LU255?=
 =?utf-8?B?aWUwaEE4bHdkQnNsbWx3TWtnZU1vOEtFR0tUUW03RVFyb0xkeGZzTnVMd0dF?=
 =?utf-8?B?TjZ5Ulg0Ti9sSkhSWXpLUmtVS01HU0U5ckEraHhoQ2xiM1JUQXpSSnZjZDdG?=
 =?utf-8?B?enVVNTNGRU9la1cycVhOdVEzT2N3SExkdGFZRTVsV0RNd0F2NWFyRjhHZXY3?=
 =?utf-8?B?aC9hOVM1aDJsbVk4ZTRFSGozZDlLblRjK3BZdGFwcnFxTGs3RVN1WjJ4bmh6?=
 =?utf-8?B?Sno1V3FNVDhySmFrVkMyRmdEZVVkbnVlbWI0dkhhcTRFR2pDenFwTCsvWkNE?=
 =?utf-8?B?OUtaNlBTRnBsQk9LUWF0b1hlN1BoelQ2NHNOVHB6R2hiQS9FYmNxYi81c05F?=
 =?utf-8?Q?FzODqHKktyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGphczBuT2dFZjlRZmgvYU9LUDhrdXNXUTJ0V0c0VGNDVWNCZ0pMSWFyQUFu?=
 =?utf-8?B?c2hkSE9XU0hSRVBVYXVxS0o0WW83Y0pTVzdwVmdZdTk2bmtFUEJrWnQ2a2xJ?=
 =?utf-8?B?UkNxem45dWZFakFBQUoycGI5OTNka2djb0FIZytSY3kvM0xRWTJuWnYxcGox?=
 =?utf-8?B?ZkVWc2ZnWlZtSWR3RUFzMFphM0dFb00xY1pSNDduNUw3a2I3cGZNUE1Gb1pT?=
 =?utf-8?B?ZlZvaWREQ2hGZXBZckdWSmVqdEsya0tiZFFsdW1jaFRvV1ZyakUxMnl5T0hJ?=
 =?utf-8?B?RXAwTVBHd1dESElFZVE1NUdiOWNxNDFWMG5sTTVDbFFEb2QraGVuV1JubHlL?=
 =?utf-8?B?a3hmY25XcWVxN013eHFraTg5TkJWVDZjeEpXWmxaWWppSDZFR3RQQTFWTitS?=
 =?utf-8?B?ZENEeU9pZ2hUZ2MrNVZ3M3FjOUI2WFNsTTdNK2h5Q0szcWx3V3RtckVRTU9R?=
 =?utf-8?B?M21nSWtzS3JsNlNNWWx1RHlxaWlLZVRoM0hKdlh3cjNCKzNBc01kVm9EQ3V2?=
 =?utf-8?B?dnhyR3NHUWxQdGlOTWpaTjdicFZ1dHg0bG9xaUdlank4SW1aNlBCNWlPbnZH?=
 =?utf-8?B?dDM0emh0UlFKTmVhaXN5SUwwM1lJc1ZxQytwQWxvWWQvVW94R1gvZ0tLVDYy?=
 =?utf-8?B?bG1NTDIwQXdYM1NVa1o4OGc2Z3pYYzNjUnZ6MUhxaW1HRXdDTnNLTFBSRCty?=
 =?utf-8?B?THZRZmpKM21XVHBhV3RnT0xCR1gyL083ZFk2b21CdGU0T3dwVDFVZVRaZ2tj?=
 =?utf-8?B?ZFFMYTk1R1ZyRDRZQXRMclc4NXVobnIvU1FjMk1OMVV6TWp1WWtxWWx0NElQ?=
 =?utf-8?B?ekFYL3gzV0s3Nld2ZmdtWDRFNSs5bUs1aGYxbGNpU3p4YWVGU1hDNlhRbFJP?=
 =?utf-8?B?N1ZZT2JyVVRDRHhuczkrOXNNQXIwcVc2OGNWUk5LU1FFV1Rjb1MyWUZ0dHB3?=
 =?utf-8?B?a3VTVTNxZlFtUjM4ZUZQcWlVbS9nNThuK0M2S1N3K1dGQ215UFgrM1BMWHli?=
 =?utf-8?B?RllCbTg3S2MwWW14cS9UQnppUnV4K1hVaW5CUWRPVWNGYUN2YWp2OSthcE9j?=
 =?utf-8?B?RGVxdEFobzlONjN5MkxzWUdUb0xoN3JRUDZudTZ4MWg1M21va3R2OHNsTnFs?=
 =?utf-8?B?Y3hQQjZra2hGL2F5U1FYbE83dFluRTR2QjRobUhkKzBMMzVReWo3cDZ0YU90?=
 =?utf-8?B?ZzVnY1ZjQ0hSYytRZm9scnNVYVFKZDYrYVhRSnlWVzNGTW42OFcyNnhoSlJl?=
 =?utf-8?B?Q2dHWjN0c2xwdWVhSE01WjhHcWxtUjdRT0NXYnNRbVVReCtiRXZWV0l3Rm1Q?=
 =?utf-8?B?dXMvN3FKQllyT0hsR202a3ZTbGRuZTM0UDZXRUNIajZvUWdzSEp0K1dSUGZO?=
 =?utf-8?B?bCtqTWM3T202TUlZcE5NK3FJZGhEY3NXZmJPams4ZHRUemh0dDIrbGZWcGhU?=
 =?utf-8?B?bENiZm1TQ1pEemxPMEZsZW5uL1hNd0d6aHlZU3plTVBKL2tzcG5yOVI2dnhv?=
 =?utf-8?B?Tis1L3JMN0dQN2dTbWNaeGZGYU43bm8wTjcrWjFWeVJDY24vejBDUjZOSlhM?=
 =?utf-8?B?c29yTDY5d0xoYzFlRU5LbmhmeGlld0VVSlpCS3NGYnh0cHhmdnRUWlc0aDI1?=
 =?utf-8?B?QlNyQUtWTEdHanBCMEVHTFAxSmlXZEVVODNzOFVEcktvK3c5ZE9rN0FKZFlN?=
 =?utf-8?B?K1A4ZzhFTVJmSUxyWDNOV00yWHRENVduV0RCODRWMFZCRzhmeUcyTnYxOEJl?=
 =?utf-8?B?b1JWVVBTK1llNlRwTElTSjhzVEdMOVZOUm90bEYzRUtIZHdmUWdqa1c4Q0Jr?=
 =?utf-8?B?ZW5CNVdCZkp1WUd4MExxVVBGbzIrSlMzbnlwS0NsQm9ZSmZOZHZCdVo5Tmtn?=
 =?utf-8?B?SExuWW5xQlQrVE9KU3JtUHJ6WlYwNkkzMHpML0ZadDhjeGtMS0d5WFNTNUt0?=
 =?utf-8?B?aDBkZThNblZmOEkxa2pJMksvbDcwS2Z2Y2lhOHJON3hQeHV3SUNscGhrcW1p?=
 =?utf-8?B?dWdUSWYrNnJjSmE5dDJiTFduTVpPNDU4d2FXVXozY2d1MnRqdHpWU2U1K0pO?=
 =?utf-8?B?dCtyWmo4NDhRZXYxRlg2bVdkdENuMFk1TjFUZ0FYNEd2RmNKOHByOXV5RGtj?=
 =?utf-8?Q?ange6rHgYNagXkDV8xm3AHYA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91496cfa-79af-467f-186a-08dd791b57ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:07:30.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwjVov8SbaK+9rWPmQiXYzVEL9LP+jH5R+IBXc/iviZ1jwGxDWVzFVxqpAU8qMQKk9JbfnOV3gElnILzp7dzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

A small comment otherwise it looks great.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Enable users to create queues at different priority levels.
> The highest level is restricted to drm master.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 ++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 57a4ef64e0b8b..b8b13b6ab4631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -22,6 +22,7 @@
>    *
>    */
>   
> +#include <drm/drm_auth.h>
>   #include <drm/drm_exec.h>
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> @@ -260,6 +261,21 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   	return r;
>   }
>   
> +static int amdgpu_userq_priority_permit(struct drm_file *filp,
> +					int priority)
> Do we want this value of priority to be unsigned as we only want values >=0.
> +{
> +	if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
> +		return 0;
> +
> +	if (capable(CAP_SYS_NICE))
> +		return 0;
> +
> +	if (drm_is_current_master(filp))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>   static int
>   amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   {
> @@ -271,6 +287,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	struct amdgpu_db_info db_info;
>   	uint64_t index;
>   	int qid, r = 0;
> +	int priority =
> +		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
> +		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>   
>   	/* Usermode queues are only supported for GFX IP as of now */
>   	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
> @@ -280,6 +299,10 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		return -EINVAL;
>   	}
>   
> +	r = amdgpu_userq_priority_permit(filp, priority);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * There could be a situation that we are creating a new queue while
>   	 * the other queues under this UQ_mgr are suspended. So if there is any
> @@ -305,6 +328,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	queue->doorbell_handle = args->in.doorbell_handle;
>   	queue->queue_type = args->in.ip_type;
>   	queue->vm = &fpriv->vm;
> +	queue->priority = priority;
>   
>   	db_info.queue_type = queue->queue_type;
>   	db_info.doorbell_handle = queue->doorbell_handle;
> @@ -377,7 +401,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   	switch (args->in.op) {
>   	case AMDGPU_USERQ_OP_CREATE:
> -		if (args->in.flags)
> +		if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
>   			return -EINVAL;
>   		r = amdgpu_userqueue_create(filp, args);
>   		if (r)
