Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90991C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 06:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E995C113E16;
	Wed, 18 May 2022 06:07:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4F2113E16
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 06:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI1CHTS2FCQCqtIFg0XyLwQT/nIyZhbH327GaCCUf4ZOAEmWzJMhy6+8+0PGIiEc40SWJTVCnMDwFVB026F1f2PEXwMz+bNiYz42vwE72dPbvWOUo99TZl588wNQlBy8H1aCaS32054luWzlFRuni8vxl6xTfPrEYwIAsjry+bNssHS/pMjybt5RFBZBaYfiiUQ3ujMi43SladGJsA6fJFnvwYtLNqHS4mfjsxyJ6/BRVHIpOSBTmld/847CD7CocYkeHcT077WgMUbmjgPXKqVKydn3HpSJq4hwmbHvdyj87HhGputfp6E261CnmLSdrtFDmXlBeYScapZ8fUw6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVYBmtxd4lZQli6RSA+yRK8kJuM13IwvjMhDjs6dCrc=;
 b=bOJyIuFMypsI/cvW2TFRrqtCSg0PuxIOOobfNL96JcT53AwENbSfWvSz7F9ZegJ64xkSENM1nVArQNEX5X3sfuHQbA2NuWnl0Rnc/s18H3YfkmuLBz52wZMkMymzw7weElPaVqtnkSz3haQFJzNDZONzsw6K3zOUGs5y1KSYf3tEtKBT8p1UGxss7PAnWqCB8nVnTWYJk/EF1kdRrnuoGHlmuvZNAJ5zg2xGtOgitBxE9zWKW4vYOGi3v43RY1GOupc1lKRMheyjsJzFr9oZEtx+Ls3Rg2gkf7c+uz5RrY0n6f4SOP15My9PHEvdSXVwbDsopQQt6pWDILKmx5wZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVYBmtxd4lZQli6RSA+yRK8kJuM13IwvjMhDjs6dCrc=;
 b=c/6xZYovv5gAA2/QsiRsH3gJLpcKmRmBvNkjTh0Cp281nF9gq/BcHiuAHHKETM9uIn3wCHGE4gVM7+LjbWlmz53XH8wXE/BTzFK5ok9zWHzmdNqewJ5p/QL25yG6v6SWsXflBaUvOqxvb5SD5+Gp1157AHslN9HlpuzXTO0bNTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR1201MB0250.namprd12.prod.outlook.com (2603:10b6:4:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:07:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 06:07:15 +0000
Message-ID: <1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com>
Date: Wed, 18 May 2022 08:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/7] Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0154.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a431ae4-8dce-433b-636a-08da3894a7f8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0250:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0250DF375DF43DC0AB55D92483D19@DM5PR1201MB0250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44F+Oe9fNxPLqlUIyFk1eiO1SrvRiKuFrmZKcR1KgxKSlChVBxXkGp3ArcFJcuSlKnLqpoHJSRoMiEhz8vu92Q8zMRE+TuvsMusLVE27MPJ3Pqxjqvk+AouHAP2cm3SmFVQHx15Gs1UkIfBVb+1oKAWMvcrMRPd4XdaGBLyDOFWLvZEZPPeq0bUY5PyDmCPxgAYL1Gc38sVe6r3RWY2kPmMkZ7+fVAxDLBXiYya9gEe9dXwdGB9NRJ+GPB1yEnEwafL7er+kLMj8Ccva8jQDXCIXQH0i0YqlAE78o1kOajQiK9DZ6sdSCvmYoy2MxhuHJljDksdyeeqzL1mSDmOZdlPXuS5O3L/o1teAItPr0LnXSQFYo8g0R0ljcwWL67MNiiClKCoulUIwsZw/J9zlB6aSLvQjEUXsLDgO+TeMsFzHOB7/P0214wljKsiyFpcI8Olo13f05u54f++vw43sHAC8L81EQiAdfWnWqZH7ntpeYXqCHRexhE4qGyeO0qqpytsLwRfiY+bLiY10r4DuEdkmlQP1K+gwe4KdCsHaeEiv0msksFHJqAPoIp7cY1RMmBJAP5sfLAq5iY9daUyTvRqpuZIDWSDCQOBjGAqgQ0GnnkwMyI563XFDd0XMQEwBAttI11CX8AXCoD9pyjDgXRXgTF7UpybwD4uakEHCaAKO6jv2m16aNW/90CdlLh8xK8CDobvu19fbltPw1ZZ0GGcut12YSvIIAcIbHUcRJMn0MQEF9z7dsPGrgjYcOSgOLdKUi0BDN3IrBZOAQg6MyZPXx54idQkFfFdSU0TN+jM6qf06qCeO/6ldGDR34a9+bfFsYnGoQOS/GrtucOObsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(316002)(6666004)(36756003)(6512007)(31686004)(86362001)(186003)(966005)(8936002)(4326008)(8676002)(2616005)(6486002)(508600001)(66556008)(66946007)(66476007)(38100700002)(26005)(2906002)(31696002)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJNbVZ0dW4vb09INXArRTNMdWtTWXhJekpEMHdvWk5BTUwwMjFLeWV0U3lB?=
 =?utf-8?B?RERhbDZlWWRUbEV4RXhpdmZYWHFiaDgrK3k5bjRhYnFuUGNudUpycTJGbGJs?=
 =?utf-8?B?QWhjS0VOWVVVZXJ2MmU5L29mSG9hU2FwSkwyTFYzMGx5OEticUpJQWFuTS9N?=
 =?utf-8?B?c0lueWJRbmUwYVhPcHJibXNldE1OK2pWc243Q3JnVnpFS1lsNTkyZ0lmMU45?=
 =?utf-8?B?V1B1enVCZ2ZTUnQ3b3AzbWRNYTA0OXJoTVQrb3ZYbTFNdm1LSGVwMmlCcWly?=
 =?utf-8?B?blZUVlgvNUVXWWRhMERGN0tuVm1VYkZONmFrUGpXQzUwbyswQlZQQ0VpbmdE?=
 =?utf-8?B?L3VHa3NyMkNIeEV1RmVURVd4U29zRFd2UkpYR1JxNjNYUElrRzlqWE9pdTNU?=
 =?utf-8?B?VEhNaFFvSlkyTktkTEttbEY1LzBjQ05POEhTNmZqOFJrYlRFajFqT0lXcG5m?=
 =?utf-8?B?bWVCMTNOaTFiNm9taUFMOTBtSWRmVXdHVndJRlYrWUZpMEJDZ2JXOVhIck5k?=
 =?utf-8?B?TTE5ajl2S01sR1pudUtsYVg3a0Y3SzkyeEUwVmZnUVg3NVJUeXlYYWhTSVdV?=
 =?utf-8?B?Sm5ScHluNDBQMUp2TlJPalNkQnBTbnYzcWttSGJ1VmhrU3grVDlxV3pLOEZX?=
 =?utf-8?B?eGpvNUFTUW1RdE9ZUHdPUFRZc0RaOUFMWkN4WUpEdVJXRTYwdzAzV1Jid2lx?=
 =?utf-8?B?SU9Mby9rOGtkcC8yeXBnRS83VTBYSkVkbVI4d2ZITlNrQkJ5dmpqclI3MUZT?=
 =?utf-8?B?Uy9BNXp1Y0cxRUdOSWV0S29kNU9wakxzSW9nQkVCL0E5TXBEKzB3VkVOK3lR?=
 =?utf-8?B?SVBjZHhMdUpSaXU2N0pTTTFFZ2lzNXZxdnhnWHkzdHNVcTIxRFNSRy9DZjNo?=
 =?utf-8?B?MTVGMTVMbkFGNWwvcE0yMGN3ZWhxVEdNR2pQbGovaGpFQXFRbUdyMXUramxz?=
 =?utf-8?B?ZW5RMTlKRy9wOFJOZ0tHNTNOUjJpRjJ5MHhEZklvUFh5TEtvQUg2aWNwUThn?=
 =?utf-8?B?ajhjSkhPeXhieC9yUldka2E3bGEwVzl2emZVR3FRTDRHaDhUeFZIZnF4MU1T?=
 =?utf-8?B?ZTVqUy9MM1dWejNpcXp1cXNDdjBXME5TaEVZMi9CTmpoZ1c0dGgzY20yQXUz?=
 =?utf-8?B?WlFKb2xTYjBBSmZkNHJrS0liRHhDNVM5SEJVL0dHeExUblcyRFVTaGhVR2hs?=
 =?utf-8?B?U1NkVlNWakJWVkRMSnNBNUF5eFptS3EwOE9iN1JWaXJZd01zR3h6ZG0rNlhV?=
 =?utf-8?B?QzZvOWFPamN0emtYWlNTTU5TeGhsNTl6L29vOUZDdXNGMlZDODdLQWkxZmt6?=
 =?utf-8?B?cTljZ2dOMEl1VFlaWHZCRWpQWU43eXh1aDZIb29mMk53dnpzS0QwSnhOeTFZ?=
 =?utf-8?B?eUtMZlhjWjN6L3l4cVFBNGFkdUpWRTlmMlh2MHJ6blhmM1JSY2Y5cXFUN0J1?=
 =?utf-8?B?cWFyc1MzaE12OHFhWEwrZzVTK0RjQ2Rhb2Q2d05mc1BEcm1OTGpjZ0VUTTdX?=
 =?utf-8?B?UWhIU2wrQm1sR0h6UkwrT1hONWlYNHlEZUpJaEVwMmc0K05JVjZtdlFOVVM4?=
 =?utf-8?B?WC9XUTRxS1VWUFhGODJGVVNjRUs2TFlHbnpVK3Q5ZHRkWXNtOTZyd1EzcENY?=
 =?utf-8?B?Qi96ZnBDb1hhalQvbG1NeGw0dHNGcUVITFhCbzNqVHFFckhRd0Y3V2EvOWpW?=
 =?utf-8?B?SDVjOHBCME8xT2pRclFKVEJPUEM2MFFQQ3pzekxxY2JFajZFRUYxZGJhQWJz?=
 =?utf-8?B?U0xBWDVLMXZEc2liREVVcEVaekswS2gvd2NQZ0ZwMHRvQXVIL0gyeUNUVGZS?=
 =?utf-8?B?bFErUTRoMWFjMncxVStVeFZUc0xGemhEemRNMTdhbFJIZXpNL2g3dFhJNjN0?=
 =?utf-8?B?aHRuZmFxeEo2L0t4cGtkemI2QkpUblZIQ2w3dGpJclRjWml3dUN3dVIzaDRF?=
 =?utf-8?B?aVFDai9NaGhUcnpCeWhycEo1cXZwZDhueTBuM1BOMlVaWnpBUXB6TU5zR3FY?=
 =?utf-8?B?Yk1WVDFWbnZNVHJyL0ZxN2NoNGY3NU1vQTNnVUVTek1HZzVsQVFEOU1KblNy?=
 =?utf-8?B?NzYyWC9hOFVGTUJISmFIZElZZGtHTTNZRUM4bGlRb2dyNUZpbjFQSElDa1Zm?=
 =?utf-8?B?THJpaXRqVElReE13MXRNSGRWM2RvUkwrelQ5aXJ3VE9JWDNpUjVJaG9aVUtx?=
 =?utf-8?B?QmNaUjl5VjZGamovQkdZZEdmL2srRzJZV1Jaak40RkdhTHcvRXFEa3VuSmxR?=
 =?utf-8?B?UmlnYmllVHQ5d29uQmRzdUlybExmbTFYbjBIWUJjZHROZmhlRkU1dTBMbjR3?=
 =?utf-8?B?U0M5QnYxYm92Wm80S3NHdmZZMmRyU0FaTzc3aXFicndZVkRGbE5kZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a431ae4-8dce-433b-636a-08da3894a7f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:07:15.3235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le/qTZotwUA3DunVfQwqgtuSdKSni0UwesC0CtEYk1cmsk4nlGVlmwQmmb2Zaixn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0250
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.22 um 21:20 schrieb Andrey Grodzovsky:
> Problem:
> During hive reset caused by command timing out on a ring
> extra resets are generated by triggered by KFD which is
> unable to accesses registers on the resetting ASIC.
>
> Fix: Rework GPU reset to actively stop any pending reset
> works while another in progress.
>
> v2: Switch from generic list as was in v1[1] to eplicit
> stopping of each reset request from each reset source
> per each request submitter.

Looks mostly good to me.

Apart from the naming nit pick on patch #1 the only thing I couldn't of 
hand figure out is why you are using a delayed work everywhere instead 
of a just a work item.

That needs a bit further explanation what's happening here.

Christian.

>
> [1] - https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/
>
> Andrey Grodzovsky (7):
>    drm/amdgpu: Cache result of last reset at reset domain level.
>    drm/amdgpu: Switch to delayed work from work_struct.
>    drm/admgpu: Serialize RAS recovery work directly into reset domain
>      queue.
>    drm/amdgpu: Add delayed work for GPU reset from debugfs
>    drm/amdgpu: Add delayed work for GPU reset from kfd.
>    drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
>      amdgpu_device_gpu_recover
>    drm/amdgpu: Stop any pending reset if another in progress.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 19 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  6 +--
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  6 +--
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 +--
>   14 files changed, 87 insertions(+), 54 deletions(-)
>

