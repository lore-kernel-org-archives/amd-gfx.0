Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A63AC369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C986C10E1D5;
	Wed, 16 Apr 2025 05:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uDc3GJx0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A31B10E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBJ2hJxeW+DuzwwfZbiuFtmeDRxF2o21kaxwX1VsZ8T4RwQv8YQ4iPclxjFhuph8SrZcpQNp3LUGzLpVIwz+DYBK/XZNXiz5oIEfaievzzICEmOwinSqgUa75S5w6mcOqsbbCtbIHMB1fO5X0WbD1fyywZgAM7sSmNY0okDwovL7zXpoIozxLd96dOMdT8/5tdOV9n2ltqocKcCYcsk02tMWmANBCM9TK7WxwnYd/6PDVGq5qGdYuN2NqGycjdUu/Q228V9QaxzNC1oVjc4ZPqGpYhACQ9VAdIPpHp0IYLKRN+pLgh3y6iuW2jdR7oAGh8qP/Q/NtVCSrCwlTOm1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51UWmcqt2alJX6hbb8IO9K/GlkI4O9ICmrpAaL4nctY=;
 b=s+Uj9IyrAPWzDgLDEB2pvskVTrIkc8+cnq043EeVc24lnRavb5GCfaZenrx7mFwXTc9HWYTCUbwD5QJ29aCMW/7f1vxb5CP7xDa562gbIsyAhuhFmmEFBGXlhSAuyZq1O6l/G34M7nFj/Bb/G+rFr0gRyzvS+6yP2gJYvbKUkdcRrLZeFjyObbL921vguSx+8av4SDL/fLbX/Tp3gn67AomyzNLhcTWsOe+Srh2+n8WBokX8jVnGbzVygCfjv09cs5IaREzW6Zw7sVzt1ilkdyvgYDuElpSwG0U3tLVICaJClB35qRWYUoQsAUkDb8M8C2CQeIeiAnLm4h0y1m8/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51UWmcqt2alJX6hbb8IO9K/GlkI4O9ICmrpAaL4nctY=;
 b=uDc3GJx0onAOGwd5Vl93jy33eGDHuoIt7kfubVbIg/xajzzlE/Ge26ZuyMUS84BedbvY0OTZi+6sQKOafbrp0aiKS+R9I75lXpGmiWbHc41Ol3o9TUq9309Lkm/GHKCUetvR9ssNnODinYJl3jne9bm/iHaOrYoDnohJSocc0Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 05:20:54 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 05:20:53 +0000
Subject: Re: [PATCH] drm/amdgpu: only keep most recent fence for each context
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250415141848.58478-1-Arvind.Yadav@amd.com>
 <e41f6932-6398-4bd3-a85b-0c7d6a259a37@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <eb459015-3e60-c3bf-75c8-b73617e5e584@amd.com>
Date: Wed, 16 Apr 2025 10:50:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <e41f6932-6398-4bd3-a85b-0c7d6a259a37@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::6) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f6ef5-45e7-45d9-16aa-08dd7ca67501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXNLWXVDemMwSkxsSFMzVHpiaWUwTTgrQ3daZnJxQzBYNWFzZm1qSlJwQ3l2?=
 =?utf-8?B?MHhFTHVISFRpVnVrejB1UDFtek5uQjdQQzZxMkxWdlZKcXlwc0Q1ejlMR1or?=
 =?utf-8?B?MjA5VGRMQjE0YW80aUw3MjBSc3c4eW84Zks2NGdQRWhkdHFLbWdXWkdkejh6?=
 =?utf-8?B?UmZ4VzlBV1FOcXAxZ05ndHNGbVJSbmtRWFBSTHFjaWZDNWRyam1BU09RaHoy?=
 =?utf-8?B?Um9QVklRMG9SeWRyWDZzemd1eno2ZHU0L2REVjFWaFFRazc0WG41NUprTURS?=
 =?utf-8?B?ekplM0h4VmVUWjhBRWRGZUhvY3ZXRUs0MS8xTHd1OUl2ZXYzYjlBc0xHTTJJ?=
 =?utf-8?B?Y0tiMWxGNkh4RGR2YngyNDc5VmJ1NEJxVVd2WFk2R1VHWHMwQWVoV2s5NzZ2?=
 =?utf-8?B?eHp3blRTbzdqcHl4akdPSE1nbzJRV1k3bWVuOTg3azRYZnppOVdKVStndDU2?=
 =?utf-8?B?MHBTaWZwZVBpR05TWFhwS3N4NjVCcnBtQlg2aFNnU2NpWHBYNHFXL1M3Zm9N?=
 =?utf-8?B?VFJ5SC9nWEZQTTgrcTVSWjBSTURpYjZyRDJEanh4SXBzT1g5K1hGRDYxMDNT?=
 =?utf-8?B?cHVmUjhmWWJ1WjVQakRBU3FJY2FuMHB4a0JaelBZaVRGRVFmUVB1NXZNWVJB?=
 =?utf-8?B?RVg5UFJQdEVHVTRrVmxOUUFkKzFzRzdXN2xQYUEvQ1E5WlIrVXk1Qk5pV2Yz?=
 =?utf-8?B?OFJiL2RVcThvbVFjcCtvOHdLM0s3bXptU0Q0WmN6QlFNSkVQZ0VEdEZ5N0Y2?=
 =?utf-8?B?cnFnaVdoSUNuYUF2eTJsSU13emhmSklGRC9DZFNlWVVNRVR0QjJJNnAyRW42?=
 =?utf-8?B?cWYzMEIyNFAzYnBGcXhqbUNVR280Y0RZYXU4TGFxYUtzQStrZUNHT2ZoMjdh?=
 =?utf-8?B?bnVEQzJ5K2d6WHRMRFdyRnRCWFZvbE9jb2l4VElhekJKS3QyS0RDV3ZoRDBw?=
 =?utf-8?B?dE5hK1ZlR1hhQnFyM2UwV053QkZ3WjkxcjlYMitSendIUTE3Y3FYYWhaejQ3?=
 =?utf-8?B?Rm53TjZSY3NhRThRekUwaHYvQnYzSXE5UDdpYnV3N2hqcjJnRHpoTUZMK2FV?=
 =?utf-8?B?cXJ5QXRkRmJ6dEMzRXkrMU96dC9nUE82aHlvcXJXRExBUWkyaGxJZUxSUVl4?=
 =?utf-8?B?NnRwVFh5bWR6citRY1YvdWw4bzlxL2ljbmFHYlAvZjJtNEdTOThRMFpDcnJ3?=
 =?utf-8?B?T0Y2ZTI1ZFVMUHIwSFdIUFN5c016KzY3bTU5Y3JqMWNDajFtZW12Q2tXZ29I?=
 =?utf-8?B?WmlleTBVYTlaV3BnblVQM1NhZmFKRTVqR1FFL0FiU0hXTmhwcEQ2eGtYdUIw?=
 =?utf-8?B?YmNrRzhGbm1JQXhxdnU5aGdsRjIrSVpEVHJkWTAwcjh2djltZWJsZXdqWmtX?=
 =?utf-8?B?a3ZxcGV4T0tzVFo2c2xJY05UWlNnRkw5RUVVUnpBajZmdEVtdEJQUWk0M2k2?=
 =?utf-8?B?UmNyMW8yL1p1eGdwaE5ZTTloSUJ1NFZGQ2RidTNkTThXb21KaEhvUk5EREEz?=
 =?utf-8?B?ZWV0TDhmc3V5aFRDSXdLa3VLcE9ycHBDQ1NPRzNsLzVsM05EbGFzYWNzN0tC?=
 =?utf-8?B?UW1LRUR2QTdPWjRyYVpsV3VLeEQ3RGZkOVlKRnVKWVpFbnNhK044UjFNaWpP?=
 =?utf-8?B?c3FVRHFsY2oxWEJLdUFPVjlwOGxxcWhkVWYyU002eFBSdVRxdXB4MURqL2xh?=
 =?utf-8?B?d3pwUko3YmR4b2RCRThTeDc4bFJaa2Rjc2t5M0JjaUV1aEZSRHlEUTJndEt1?=
 =?utf-8?B?Y24wM1ZFczd4V2pSNWVUcGRuSy8vVFczbnlLT2lUaC9QbU1pd3cxVXVjQTlm?=
 =?utf-8?B?ckd3bE9hdk96d3gwK1R1MzFQTFlKa1ZzMWdySG4wbzU4LzA3cjE5UkJOZjl1?=
 =?utf-8?B?dTRzdmcwbXNLQm9IZk1pazF1a1NyMGd4N2xIck5YSDBTcWY1ZEdMbGY0eUtP?=
 =?utf-8?Q?8P7VB3zPHyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRqNlhRTW5ISWJOYXVmSURwd2U5YXRqUWlYdDZiMFdqdC9mWjdxS1RhSlk3?=
 =?utf-8?B?aEVjU2lONzNiQWtzdEFhSStPWnBkYm9wdkQvOUVRRVZ0YkkrL2UybjVwUUlT?=
 =?utf-8?B?eERBWGVlMlI4VEZBOFk1NW9LOUlZSWV1NEpyU29ScUtNWjB3WWUyR1pwRlJP?=
 =?utf-8?B?VFlBUWNxS00rQVVUNVpDTGVCem9pK0xHWWpMQWJKSHdPTUFhcXFHRHBGRGxW?=
 =?utf-8?B?dEF4cU9GU05hTXJNMXZXbjBMUXdkUnZJOWI5alJ1T0RlVTB3L1Y0dUcwYk5R?=
 =?utf-8?B?bFVuU1hKVm9JVUFoNjZrcmh6UlFCTlpWTTBKYWRkczBYNkRPZ2hna1JLeXlw?=
 =?utf-8?B?NEVGb1FyRk5SLzI2N3ZKQzh5Qmh3b0xHYWJJTjE0SGQ4S21nN2dHekMvZC9E?=
 =?utf-8?B?aEZLVXZ0bThyUnFDWTFrTFRDRnFmQ1ZTRUJOV3JSN2RNbWtuM20wRlh1cDR0?=
 =?utf-8?B?S0NFUWkzdlI3N1M1YWRtZDltam5wQ0h6eUZSa3JXbGN1SDVucXpFV3ZwOGNx?=
 =?utf-8?B?b0VOcklPcFlsY1ZUOHdScGhpZEhhMlVtSkJHWnJwdWNJM3M2WkkrRUhjdzI4?=
 =?utf-8?B?dTFNVFBsbzJLV0g0QXBlVVlhcjZoQ2FSVjdKL1A2ZU1pcUc3S1RKUUZjZUJB?=
 =?utf-8?B?TldQdUp2S01pK0I5SGxEMTk2MG5tZVV6S3ZBVHVmWGtuSGZsUEpJdEVrYndx?=
 =?utf-8?B?WkZha2RYR0JJVGcxSDdWRTlnMmVST2RwUFdueUFDa0JDeDBOb0EvVmFGaUFM?=
 =?utf-8?B?bWIxRWNUam01TlpvaXNaYWlUY1ltT1BKcGhPdFhmdE1NS3dHd3VCZHYyc2Qx?=
 =?utf-8?B?QmN0VEM2byt1cUV6UlRrWmdpaFpmV0hXYlYxYkZhdmZtbm9oN1pvQ1Flc1Bz?=
 =?utf-8?B?M0srYkZKVTE5Q2lMVzdEZnB0c1kyOFB1RURwdVhZWVFPK3Q5RDJFNlJjeEl2?=
 =?utf-8?B?VEdpYUJFVDl0WU91VEgwSDByQ3Zza1VrNmlzN1VsU0FzZHRRTEN2RzBCRW9o?=
 =?utf-8?B?SnBwWmNPUklHUXhGbmF0aHZzNXlHeURKTjNiNW9lTlpOOWJoRTFmR3JVQmtE?=
 =?utf-8?B?ZkpFWWEyV1kwdFNaMVMzdzRLMngwYUtFV25XSnhjeERVNXpZZCtPOEdZSlVp?=
 =?utf-8?B?eFliZUxzcnZRYVhLVmFlTkNmZ1pzaTMzTVZUelNwK0REeEVITUtVbE1oL0c5?=
 =?utf-8?B?TFFtaWRhUmdHL3hxQkJtak91RTQ2UVVKUEcyS0xQQlEyeGpQalczL1FoQTBY?=
 =?utf-8?B?OUpnSVNiZ2lMd3o4SWxwNjZkK2h4Q3loY1plcVhVLy9mS3RackxoZ0dkbDRr?=
 =?utf-8?B?TytVSVVBMmozMEJHSUhwRlZCT3hrTTA3Ym8rOFlhNlQyeGNZMW9oSHFBN2dp?=
 =?utf-8?B?VHYvRnBmaGlqampiOWpKd3dlNkh3d01XMSsyUlFhR1Q3VjgyeHRUTXFIa05k?=
 =?utf-8?B?OEU1NFBieENGNHh5NlRsNXF0Sm1RNnlDZXEzZUE4VzR2emRYbC9FeU04TXlz?=
 =?utf-8?B?RkxkVDZxTHl1ZVB3SVFMbmFUT3hQT3pkRUNxeEtnYUhab0swb0g4ZGpFUW9x?=
 =?utf-8?B?Q2xHbVEvM1IzSW1XazM0dXQ0RklsNE5zcVVGSlowVE9YTHYzMit1QzhJMmJH?=
 =?utf-8?B?L3dZM2VuUk9TOURtME5NRHVpUjNTdWlGam1kQ2YwdXdoWEFYWFlOMVZCRE42?=
 =?utf-8?B?T1JrUzVTcW5vYm1Vaks2UnVpOG5WZ1U5cWM5a3JpNnFlUi9KU3dnSVZuMHZ2?=
 =?utf-8?B?L1pTOTdydy9PSUkzRElSdkhQNU4yYmhUYkZrWnFYcWtvT0NXWmZLTnBtRmZn?=
 =?utf-8?B?V05nT3Izd3FaOUxnWjZpUHdSemk1cFovVG1sTVhzblJIZG5DTnZYMHV6QU85?=
 =?utf-8?B?YUExWGJVSWgzdk1JUURKQWFueGRyUGpuOU9CSFRRMXZCLzlrZHVSTWQ3Nm5Y?=
 =?utf-8?B?TXBZb0dOU0xHYzlQd28wZzRyQXN0cHZySURFYUd1eTh3L1JGa2gxMklZSnJR?=
 =?utf-8?B?TGdkbkZaZ0JrdDhyWS95OEQrVjQ4ZC9PUGtSbmJDeU14NS9nYURydzhUZ29Z?=
 =?utf-8?B?UXk5MmN1Ylc4ZmxycU5Rck0zOUZMZXBraDdmdHVZMGQ0VUZ1MncxVkpRK0JB?=
 =?utf-8?Q?kk4JNCEM5Uyw2p4xmsvJo2mF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f6ef5-45e7-45d9-16aa-08dd7ca67501
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:20:52.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAJ2UeVWnV/BGKejgFnlBFhQj0cjc9WO7nyY/v0lq719acuTAazpno8Gl4wfVu6LqR3A3nG9TlNwq7Mup2rDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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


On 4/15/2025 7:53 PM, Christian König wrote:
> Am 15.04.25 um 16:18 schrieb Arvind Yadav:
>> Mesa passes shared bo, fence syncobj to userq_ioctl.
>> There can be duplicates here or some fences that are old.
>> This patch is remove duplicates fence and only keep
>> the most recent fence for each context.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index a4953d668972..9a09d545ceb5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/kref.h>
>>   #include <linux/slab.h>
>>   #include <linux/dma-fence-unwrap.h>
>> +#include <linux/sort.h>
>>   
>>   #include <drm/drm_exec.h>
>>   #include <drm/drm_syncobj.h>
>> @@ -584,6 +585,24 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   #endif
>>   
>>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>> +static int fence_cmp(const void *_a, const void *_b)
>> +{
>> +	struct dma_fence *a = *(struct dma_fence **)_a;
>> +	struct dma_fence *b = *(struct dma_fence **)_b;
>> +
>> +	if (a->context < b->context)
>> +		return -1;
>> +	else if (a->context > b->context)
>> +		return 1;
>> +
>> +	if (dma_fence_is_later(b, a))
>> +		return 1;
>> +	else if (dma_fence_is_later(a, b))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   			    struct drm_file *filp)
>>   {
>> @@ -840,6 +859,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   			fences[num_fences++] = fence;
>>   		}
>>   
>> +		if (num_fences > 1) {
>> +			int j = 0;
>> +
>> +			sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
>> +
>> +			/*
>> +			 * Only keep the most recent fence for each context.
>> +			 */
>> +			for (int i = 1; i < num_fences; i++) {
>> +				if (fences[i]->context == fences[j]->context)
>> +					dma_fence_put(fences[i]);
>> +				else
>> +					fences[++j] = fences[i];
>> +			}
>> +
>> +			num_fences = ++j;
>> +		}
>> +
> We already have the same code in drivers/dma-buf/dma-fence-unwrap.c.
>
> I suggest to export this code from drivers/dma-buf/dma-fence-unwrap.c and just use it here as well.
>
> Something like num_fences = dma_fence_shrink_array(fences, num_fences)
Noted.
>
> Regards,
> Christian.
>
>>   		for (i = 0, cnt = 0; i < num_fences; i++) {
>>   			struct amdgpu_userq_fence_driver *fence_drv;
>>   			struct amdgpu_userq_fence *userq_fence;
