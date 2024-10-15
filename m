Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39800CFC501
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 02:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6D210E200;
	Tue, 15 Oct 2024 02:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDkUsFL/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFEB10E200
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 02:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYvWQJ7bhIx/dEanMz8WW6WTuo31cuF12eGTgwAGd/66VnrRHrS1Pk8hvGrxySCKRrGIqv8yBJa+maZOLdkShlO/s/eS3dp8XS59Ps+y6QXZw4omIUedvBc9U38oYUAAqQ8UH1sseI734r2XwXJHVvc1KHRT9NjZcJbTVPTUjf8DBXd71NAT4g5vkTk0jbzI42WdkrnUC5fK+Rbn+Bq0MkJBrLakcTY+s6nMVZWu1jMU7lyQ1oRBL4rtR8k0wI905aoIzIj5Wv+Mp+BpWpkEMuslx8UYHmplZ4+dPRSKQdIf6JdpoMG18NwjQ5TQE/ImSHeqMX9m/7EJoY7ptrrU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+RgQrtZzckQmlzGojGEmRH0oigNZn0AxkxqZM+nFz4=;
 b=BUrB6scvpXqqYP42gED2AlRbJ3/u1AhInQgVC4qNih6amShp37gbgFf7A5o3RwqXRq4Op7ztjXA1hLACof5yzKpoUwbtuz32qBgJrH5MaOkMhAK+gOudEM8V0MikhGQKNF/ZGd8UMvXcuitQsPtNuzFRQTlGfKqgyYzCeldGDDxKVFif7235vprb7vQSdKmX8uJhzSZLpd2A3cflN7nFzwBADap41NKq9mgTg+GnfuPS4lg93x9hFNugu7Lou2qNqM7dPdsIU2ZnFhMP/6jgpwXahtO0WiV7kaKX1X9yHAf0GyaBB/P6aU/qo5irhSERL1PCWeX0eghWr8a7zoGdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+RgQrtZzckQmlzGojGEmRH0oigNZn0AxkxqZM+nFz4=;
 b=sDkUsFL/vYb8Tyo3Fc+AijBQubUjJ0j5uTx157M7LAQYyN9Hv1KEMrdAY7IbJRMfzbEqsKm1BLorerJqgKu9otbQnNkq7j+tclIDTfheSFfuf9PGvi60ziXyHsUXV0WWXSdE7amiv1e0k4ygotqLzUL1yMHz+1fh/kv84O7C+p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Tue, 15 Oct
 2024 02:51:46 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:51:46 +0000
Message-ID: <5e372d79-ceca-4509-8bf6-f18175744817@amd.com>
Date: Tue, 15 Oct 2024 10:51:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
 <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
 <2da699ed-634d-4710-9539-a28ede17c41b@amd.com>
 <50fd40a9-3369-4016-a93b-b90b5b25e444@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <50fd40a9-3369-4016-a93b-b90b5b25e444@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:404:28::18) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0123cd-a42f-4f34-f0b2-08dcecc44efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmgxL2tFUnVDL1N5WkVrTnoreHFHbC9OVk0ydUhMcjlGUlFndERud09VYUVw?=
 =?utf-8?B?QnFBakVQMFFrdFN2RHA4MlhjaTNuTFI3OWxVallpMHo0TzJydWRNQ2tzWlRR?=
 =?utf-8?B?dnlkK2plT3FCWFVjVHIzTXZWYTR0dFVWQUFYeHhzSHB6YmIvdzRUdEhjMHlO?=
 =?utf-8?B?SUxUbEprbjhWcFhOUmVqUFlSRkxUNWE5cTJyZERvOFFRUXNSTC8wUHdEYzVm?=
 =?utf-8?B?emdya0JZY2ZidTlxUWRTQ2gxQjZ0Tkh3RFNHUlI1WXJ4UGJONE5DbjRQb3lT?=
 =?utf-8?B?UTRzcjhpdWVJNXE3OVhVZmhHTmNvYzgyYWMzNllwWVJmNGxlYjJhdTZNQXdr?=
 =?utf-8?B?OUt6SXRlQmVuMm5VR2pBOXZiTnJkZnJwbWIxQXkzNDRtNzM5bGtCY0VpRUtY?=
 =?utf-8?B?YkU5cXJmaXpJMTZzUDg5c2I0bytRYkxvQWluWDF1aUtqdDVSRVI4OEcrSFht?=
 =?utf-8?B?bGcveHNTYnVKT211Lzk4Y09HRnExMStEMXpTbWR3V0w1M1Z5R2NSb282ZGFB?=
 =?utf-8?B?K1YvUEJJREZISTZKSXVraXNvYVJkUHNDWk1RamxENnJOWjNTTHI2M0tXeUJB?=
 =?utf-8?B?MVJaZVNqck5WTlN1Q1JhV3dQdmVaUUNVZ0s3bXc4bWNjbGltSlMwdFlhZTYy?=
 =?utf-8?B?d2hXSUZlRVhkcTExVEN4dG1ieXhWT1VJWmdVUUVZS3F1UUdYWVlXdm03L2ln?=
 =?utf-8?B?SHRJcjI0bWZYM1R6UXZTZjU1YkhkVW1LSjBNbVl3R2xlRi8wdjE4ZUhNVFhp?=
 =?utf-8?B?NmVzcURhYXhSYUxFV1JWSlV4c01HWm1uUzQwenJ0YUxUZU9ya2RLSlYzYTRZ?=
 =?utf-8?B?M25JVWJiaUpaNmxha1FGZTRWR1JNdG04eG40dEY4cTZzdVJhM2txRTV1d1pM?=
 =?utf-8?B?UkExQm40QlZpSkIydHJ6VG9qM1R1Y0FjK3BhOERGTUhxaUFuQ01yL2ZCNXhj?=
 =?utf-8?B?eEJZUWF2NVZWaUJBajN2b0gxVGE3NnlCdm1sV3J5VGVjNWVCa0VIMGZNeHJX?=
 =?utf-8?B?UURoK1hadmtQSUd6djBESnExaTlBT09td0hHT3Vncy9OOWxlS0FrajhOWVBj?=
 =?utf-8?B?a1RCTmxxSlpOOGt1ZmNpOU9NRjBoLzZ1Wml5ZVpHcjl1UC9EYStXRDdVaER2?=
 =?utf-8?B?TmViR0lnRXNPUXRKeVZXVlNwYmx6RGNEaFArZ3UyTHFnN09WMUZCcExIYlMz?=
 =?utf-8?B?TUdJL2IxQWY2eks4QTJTSmRxWWlIWHM1NHptdkVrdWtYVUhYMlpHMm50ZTFh?=
 =?utf-8?B?TlJMN3ZEemowR2VZbFNIM1lrSWpnb1hMd2d5Uzdnc1hKRWhlVGJlSUZFVlFN?=
 =?utf-8?B?U3c1eE9PWExyRXJvdW9SQ2Z0WXE4cUxDOC9lNU9QcHRtTWZkNzVxU3RNRUww?=
 =?utf-8?B?M01GaXp4eUtFOTRNbks2NDdnY04vaGlXSStBbUZoVHV5bjgrMjZ3K2FucHE0?=
 =?utf-8?B?RWtpdjJ1aE1BamlvQTlENGZKM2hkUWkxS3lBSjFQdzlGajVBYmNNYkNEZkF4?=
 =?utf-8?B?V1BnUk5UWkhHN2h1ZS9WT3ZrMzhld0t6QWpBaVNmbUtmcEJqMHB3V0p2aWVs?=
 =?utf-8?B?dVc2UzVLKzREUjdHYm9ERDVVWENaUUU0TjF1bUs4NEY5TWwzTkFPbEUxN1Ax?=
 =?utf-8?B?TTJ6RU1jbTJtRjhSTnRXNkwxMHlqRVBka3lDQzdvc083TFROaVlUVFNvcFp3?=
 =?utf-8?B?eEMycEl2NSs2dERXU0RxamY5NkFaL3N1WExtMEk5aDJjTnh5cGQ0MVZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGg5NFlESjg5WXE1Q1VTNnU3a0FRQ2wrSlpmRi8zWmhSaTJud25uOXpSYytn?=
 =?utf-8?B?Ti9kSjRmcXNzQUFkVFJjQTF1UjBrMFo2c1VjT3pqdXhiSXliakI0VEN2SCtW?=
 =?utf-8?B?NG9LRlJYRVpNbCtTZ1Q5RjlieTlmL0dOc3l2WS9PR093cDRyY2d2YklzMFNl?=
 =?utf-8?B?RWJNMnhNQ2N3N2twZFRmaGZrVVE1b3dhcjcyWCtYaE5xQWJXVlJ3NDMrbTZH?=
 =?utf-8?B?NDZnVnhWbnYzZXNTVHdGVzFNOFNjRXE5RE1HakxFNjRmRUZYUjdNNkJyVm9m?=
 =?utf-8?B?VnkvOGJPeDN1TWo1UHovc3AzbDRBSU9LQnZJSC90eWV1d1piYmhaaG1uUXFj?=
 =?utf-8?B?NGRXRGlSWVlOY1ZGeUxHTEY1VlREWjBxaVJsaTdMTDYrMW9xM3ZHVTRYMUla?=
 =?utf-8?B?OVhLUVgwcXJ5eWFDaFJDcndyMjRUS0NTMUY0RVFGRXZCbGVtMCtyY08rUHN0?=
 =?utf-8?B?cEJQb1d5VEkxUHk5em8vL3dISWV5L05WTFRlNXBuQmRackdjMTNhM2Fhb3Jp?=
 =?utf-8?B?N1ZPaDdsd281WVEyNEE3QVlxMnlmV1NqTVY1V2tCaG9OZ1YzZlNFSW5OMTB2?=
 =?utf-8?B?NlZyNHFZU05TWnRmUlpBOWx4b3EvWjR4WFdZTTNmNmRZZ0doc1B6RmxySFdZ?=
 =?utf-8?B?NkQrRnJOc2kwY09jL2lxVnJwRzU0RTFmZk1ZMTZUODJtSFNka0F2dXZuNUdr?=
 =?utf-8?B?SlZ3KzREbzRzYkdKcFZSMFBnUGZvU1VCeXppdjF0blA5NmpUelRabE4rYTRV?=
 =?utf-8?B?b2pmekE5VXRVdElpekhOcG9zaUFkM0E3RmVWUXhTb1F2L1doNDYyQ3ZFWloz?=
 =?utf-8?B?NDZJTVFKUFBQT2lBSXJxTGRjdlc1WUtDVG5qVjQ2WXFzSHBCdzZnSlBEMkk3?=
 =?utf-8?B?bnVDZzRvaUJkNVMxM2NwTmRrY2pRSU5VSTZMeG1DNHFncHhkV3hMRUZYSGxs?=
 =?utf-8?B?SHU5VjdGVitHNUN3ZnAyUnBscTdzWEpmaEJSbTM3OTRpNHh4Y1A3TFRvZzRq?=
 =?utf-8?B?OHcyYXdMQlFGOUxkUXBNK29XazBIKzJ3WjJvbFkzN29kb1hEcjZlQjVLLzZo?=
 =?utf-8?B?ZFpSVWMxYWdja2ZEQklYbHE1MTdrTzNOUEN3K3A3NlZxZjBra2FKT0c2MzNG?=
 =?utf-8?B?dlFJRzNqc2lzRDhjayt2VFhsbUpzS3JsUkM0RFFPMTlyNGpWR2owV0dxOVVX?=
 =?utf-8?B?Njd0cXN2dlM0WGUrblZwa3lTUUpmT0lnM1o3UFRTR0dnQm9PV0ZkcmdGcG82?=
 =?utf-8?B?cTFSa2hDSTJMcFBoMXZrSXVrWlJSVURmMkZ0bFFCdEhFY1ZQTnhNNE9RUEhD?=
 =?utf-8?B?MzFzLzRuVERoL0VEY3BucVRvQk45NjQrNE5iZUdUc2RzbGxyd2krOGV0TlpT?=
 =?utf-8?B?aTI2KzduRW90aEhkVnp6alJITWdsYVd1aWZkY1V2NGVLWGEyNXc1anZUV1VZ?=
 =?utf-8?B?dGYwRk1iWjBxQTk2c1d5L3dTQWloREt1MU5KNHExc2RTYTZJaThhaklTN0Jk?=
 =?utf-8?B?YTE5UHY4cHBQZldxNndwZkhzVnozei9MankrandDWGw0cDJpbm0zU1ZEaHp6?=
 =?utf-8?B?NVlrUXMzWGllQ0VVeTBoSXJHOEIvOHpVNVpKd0Q5Q3R6YW5NWWdqcURNNG1s?=
 =?utf-8?B?WFA2ekdaOW9vZW45VlRXSXJXV0RMUTNxYUtZKzBveHBHUjlHY0NkMGRadHkr?=
 =?utf-8?B?YWpHNXQrK3J5NkZESktIeGt3UGh6OEdrbnVQZStkSXFSL2ZkQmd2cTVtTFBv?=
 =?utf-8?B?dHpaQXQ2WVFsOHZhaFNPSmt1SzRHZjBYdEs5OWlzMDArbkRibDlOd3F3amZW?=
 =?utf-8?B?YWF0a2NlTFM4ZEhQbm91ZDJyNUZtMzdDZ2pSb1dZK2dkTWo1cVNVUjU2d25Y?=
 =?utf-8?B?SzVYRFY2YmxVakcxT1Qyb29tWS8vei9pTVY3UDBzOGUyTUZaR2xZNEJyOVBs?=
 =?utf-8?B?T0FxRlkyTXZUYUxYL2ZZVWszdjBlQ05MV1MwQStWRS9YSTJteWtqWXFXOU1r?=
 =?utf-8?B?OUovSzNWVXhjUGc2d1dpUTB4NlBTY1NHWFZOZitBbkdaWUtOdW5jendwSlZP?=
 =?utf-8?B?bWNBdTljVlZ1MGdQUlE4ZWNLYXQ1MytseWc5Uzh1bi96T1VWT2ZUL0gvNEpj?=
 =?utf-8?Q?Acwcm5G0eRzzzxlOeecan3rhS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0123cd-a42f-4f34-f0b2-08dcecc44efc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:51:46.4955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlEWzPvftmOsA2UdAAGGjZKvFy631Y9Lg8nqcoX6jpEu12WcH7fIuAd1nMKSNrw+dEzzxLiWXG301zy8hFIIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

On 10/14/2024 11:07 PM, Chen, Xiaogang wrote:
>
> On 10/13/2024 8:55 PM, Zhu Lingshan wrote:
>> On 10/13/2024 1:30 AM, Chen, Xiaogang wrote:
>>> On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
>>>> On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>>>>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>>>>> process mmu notifier allocation since we decrease the ref at free_notifier of
>>>>> mmu_notifier_ops, so pair them.
>>>>>
>>>>> When user process opens kfd node multiple times the kfd process kref is
>>>>> increased each time to balance kfd node close operation.
>>>>>
>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index d07acf1b2f93..78bf918abf92 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>>            goto out;
>>>>>        }
>>>>>    -    /* A prior open of /dev/kfd could have already created the process. */
>>>>> -    process = find_process(thread, false);
>>>>> +    /* A prior open of /dev/kfd could have already created the process.
>>>>> +     * find_process will increase process kref in this case
>>>>> +     */
>>>>> +    process = find_process(thread, true);
>>>>>        if (process) {
>>>>>            pr_debug("Process already found\n");
>>>>>        } else {
>>>>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>>            init_waitqueue_head(&process->wait_irq_drain);
>>>>>        }
>>>>>    out:
>>>>> -    if (!IS_ERR(process))
>>>>> -        kref_get(&process->ref);
>>>>>        mutex_unlock(&kfd_processes_mutex);
>>>>>        mmput(thread->mm);
>>>>>    @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>          srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>    -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>> +    if (p) {
>>>>> +        kref_get(&p->ref);
>>>>> +        return &p->mmu_notifier;
>>>>> +    }
>>>>> +
>>>>> +    return ERR_PTR(-ESRCH);
>>>> this cb should only allocate the notifier (here it returns an existing notifier ),
>>>> so I am not sure this is a better place to increase the kref, it seems coupling
>>>> two low correlated routines.
>>>>
>>>> kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.
>>> Who referring kfd process should also un-referrer it after finish. Any client should not do un-refer if it did not refer. That keeps balance in clean way.
>> I think we already do so, see any functions call kfd_lookup_process_by_xxx would unref the kref of the kfd_process.
>>> The current way is using  mmu's free notifier to unref kfref that was added by kfd process creation. Ex: if not use mmu notifier there would be extra kref that prevent release kfd process.
>> I am not sure this is about paring, current design is to free the last kref when the whole program exits by the mmu free notifier, so it would destroy the kfd_process.
>> MMU free notifier would be certainly invoked since it has been registered.
>
> This patch is about having "get/put" at correct places, or keeping kref balance in a clean way. We have 'put' kferf at mmu free notifier why not have 'get' kfref at mmu registry(alloc) notifier?
If we place increasing kref in mmu alloc notifier, it is still increased at kfd_process creation time, actually no difference, but inexplicitly done. Others need to dive into mmu ops to understand. Current approach  actually has a better readability.

MMU alloc notifier is invoked through locking, it locks the whole mm, so better not to add extra dispensable code there.

Current solution runs for years and this change actually does not fix an issue

Thanks
Lingshan 
>
> Regards
>
> Xiaogang
>
>>
>> Thanks
>> Lingshan
>>> The final kref is same. The patch just makes the balance in a logical way.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> Thanks
>>>> Lingshan
>>>>
>>>>>      static void kfd_process_free_notifier(struct mmu_notifier *mn)

