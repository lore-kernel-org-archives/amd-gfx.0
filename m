Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E4F53D87
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 19:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3DA10E118;
	Mon, 16 Mar 2026 19:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXNa3HKt";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F33410E118
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 19:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CutB/uHuIEmIgW89LDgQUyElOUTijiUZEr+3zPeAHY0QBFmUnUjIoH/9EZpuustMbaZ0ehVQrOyU6hoScO+xgGmGGyXYKw2B8mjfVlISBvzwTiC+qHqQdqgvhGhtgQzhU1pQ3pJ3fMB2+8x80Zd/gASh4tVWoyN0ZXSYZUAB6kYoX7FvfX41Pdbsb+G+Oido2W4PU3hLlS9b2/opYSMngzdL1KbyGsixtYb9D2m3kjlNldQtsMMfWWy5NufoMiDaChfr2awonk2bc6itwIomoZ2rQgj4Td4GUwbJD9SdjGpIQrx5DmzkcDVwYUxRoIoSJFOTc9vDYAUKovq5nMoMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/7fHghBu0Y9dt0i68ye6QxXvfd8znPOErE2u7QzwRs=;
 b=E/Ksd/RAV4LRTz/6GIEqXfM7S8fc9r406810r2E6Bc5uGK4pwgclKPMNSzvBXnHs9OmsvPLJRYiGSy+c3Nw+bVI0Ow+HLBtPRJbgr9CeWyuQpjx2UUO913t9DNUXeSQB/kBtbzczdEgJz/mfKLqfAwr2sDzmuKFHZOflZXJVgN5dpl8+De84wJso7s1q/iwADkyPQngeZunntDqqjyyWb6Kzb9jfB+xZCWD5kcTFvDTUfs+0GvJe2kvdpmWp9lR6ZCUH1+CTq1MiuW8TFOGPUkaNWkL7zN9hO/5fJav9RTPpt1HhwGPyXtKJVOM+LUnZ0jNauDiQoRmWjAS1XxC4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/7fHghBu0Y9dt0i68ye6QxXvfd8znPOErE2u7QzwRs=;
 b=tXNa3HKt/l49T9hCnE+w6G3Hn+Y6MBc/qbu5TY/Zi6dJ1adpjAS5mG5lX0fg5EvCqu8zK/kfcmMJD7SNG0wzFEjd3fFdFBA3IKWAr7wMpBtSNC5LRBaUOxGGftEBIUfE4SPq+UnAa49sIhquNFvL3FXQ94uc9IVLDosmukjjBgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 19:20:27 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 19:20:27 +0000
Message-ID: <dd5aa9ee-989a-4d32-ba9e-9b9232fe164f@amd.com>
Date: Mon, 16 Mar 2026 15:20:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/mmhub2.0: add bounds checking for cid
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
 <42e624f7-5190-49b4-95c4-dc22a6ba1ab8@amd.com>
 <CADnq5_Md6LQ2n7ciXKuhvvbcq7NZxHZ2VsY0TpPQyDNwAko7iA@mail.gmail.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <CADnq5_Md6LQ2n7ciXKuhvvbcq7NZxHZ2VsY0TpPQyDNwAko7iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::18) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: a584fbba-817f-49b5-38f0-08de839114c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: oSyRkuo6d4R0slIP7AFMSiZGzavYNtJ6ufCUk9xV6qe59P78og+MvwP4XjXSntmjF4+is3w7KHO+Lh12vfDHjNveIFnGyzZ7ugHggWrug1NgloAWJomcNAEcJZAvccmJmN6A51s7xYXwqvoGDGPM0OKTdO3t8FDU8zViWNPUz9KkDvtCKdK4Gekt7zulQW8pNcE/6kfCyBlFeaRVjXbWdRzvdgkvmTEdAFT3XyskC4TcFWV4ay+AOW8Cc9fDru58LC8+UzoUv2KMdKzZggmkpfVbclsehNqiwArhhCsn8rncM/0wNZN+oFrzlzMfwQ+cuJfUyMA77Wf71LFOGokvv27xto+Ozp+GnNOIrvaVap/rCxOPXmBuJ4YdrAoS6Hr+uknTTYDpmeG/YvG+MxwTtJ+OWXKab13SYJ/5IZdKIcTzpZLDDiFkJ8ILUjiJeu6NSq2MM6R5coXt75kmLBrTdtxshnePz8eb53hY62+JkVaWu1CWtrRe5nb/PTQkIgI8njkrQ7UHVoukhxChALE/V1LKhuC6R5HuCeS99pm7Z+FfOkbFoI1/pkvWzUAWQFCHZHmRsjv8Iu9mxbf/5TfJ58zklUKCRS3ch6XWoUAGik3YJyuNOWmGSfTNynO5VE21c/5+LPjDgeCALTNeBClz4JH3H+jlLP0ySvMh6L6COBmWC5v6ijnQJbl9e4wrMsMIB62Y58PdkT7f0hd6NpEy4kzAjmAp0HhkqeDY+F1FbzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBhVjBQbzR6elFkZ2ZzN2dINzFDVGgvc3hVWDJRVUlhbmNCVnA1M3dqdFFS?=
 =?utf-8?B?d1ZIdmNNdlBQN3N1TDBKNmNiN2hmOVllOGUrOFVaZldvWHd0ckkwYjJJeXFU?=
 =?utf-8?B?OHVvRWhJNjNjSjVpaWM1b3dlMWY0USsyMkxQKzRyRmM4K3R0OEcrU0JDNmsr?=
 =?utf-8?B?Z1NuK1Evc3NHVUpMS2ZVK0t0d2FOTGVBRjNiZzk2dlltZjh6VDM1eTU2c2Jo?=
 =?utf-8?B?dWhMVEhRTzFTMDFXMzNSMG41MWxKZlhXendURGxabnpkWXZmVnZ6MHN4a3Jj?=
 =?utf-8?B?aWpRYnRxZDZoTkthTjNRUzQxYmNYTURySVAvUE4rVzg0RVNpZFY5enF0M0F1?=
 =?utf-8?B?c0NVc2FMMDB4QU5HeWFYMlJ4VzZwWEhrSmdkWng3SzY0Qm9DTlRaYXcxV3VP?=
 =?utf-8?B?aEhINVQyTnhKakNucnk5ZFRyYTVOMDI3MW5SZXZlclpqVTREOFJHM0NYeVVm?=
 =?utf-8?B?djhpRktrTm8zTWZDWEUwK2NKT3FvYkZ5ZGM0d0R3cXEvRUZMZW5JcGdiU0dQ?=
 =?utf-8?B?ZEE2M3l1alNOeFdpN1ozeVdhVVlCWW91K0NoRkROTU9TQm5hdDdzbHZISENT?=
 =?utf-8?B?UjZBSDQyNUpSYnNtZ2grcEJrbVpZU0dhdnJpWkN1U29rSGFRdTN1M2dzbVUy?=
 =?utf-8?B?Q1Azakl2cHI5OHV5N0VEcTNBWEJtK3VaUUdXaUZmeGlKVUdmRXNkWUl1cWNR?=
 =?utf-8?B?M0NNZFU3akJhcWZRZVBKbVBTMzFkbHlaVGpueTNLaW14Y1daT3Joc1ZOSXNP?=
 =?utf-8?B?a1ZpcjduMEl2TllQQ0o0OUpUVG53Yld3Z3RxT1IzbEJBVGJRdEpwSjZFUk85?=
 =?utf-8?B?ZXliNWJDc0kzc3QvdkRHaDkzejk2aE5vS09sSndveFluRkp0bWdzaTRKbnNG?=
 =?utf-8?B?akhrWnhzMVNCMVV0R0RBdnU4d3lHb2haMU1MOXlRR3JrV09OSDJxRkZXbzZo?=
 =?utf-8?B?aUwxUWpnenA0cm51czhuYlVCaDd2TnEwSHRZTVVVcEtvWGJCMjR1QjV0eHZp?=
 =?utf-8?B?TkJlNi91cUNxSXlBUi9HZFppbi9YUkE4ZXVVZFk2dStVUm1leS9BNEZxbWo5?=
 =?utf-8?B?aE5vNS80dUxKQm5mWTVVZFAxY2lMS2YwMnB2ZytCZStlL0JhUUNkWVRYWitG?=
 =?utf-8?B?cFB1ZDV0WjVKVVBpYjNBeGlZeGg4bWNOVlhUOXF6NnNZQWNXQ0o4YXB5TUpC?=
 =?utf-8?B?TThON3EvdnFnQ0R5aFNLa2VPRUN0eWNqMmYvQTAvd0VJR3NVeGJ3M3FXZSti?=
 =?utf-8?B?MEg3NnVOU2tVMXJva3dldFhFQ053YUdXNmY2bGtoVnIwaUJ3SjEwZW5iM05V?=
 =?utf-8?B?dGFwdFZkZHlFbUNMNWNLYnVCMCtVTnBTb3czalVRbG1icWIrajQzQlRSNDVJ?=
 =?utf-8?B?RFJocTdUL0RBbmpLRnVYdlZ2eFhMV1VGUUU1UGZjQmdDOUVrd2daT1RZZnZB?=
 =?utf-8?B?bkF2VDNxNkpHTzhpUGU2Mzc2RmNLSzNJSjVzQ3YxWkU2bjBNNzF2a0lKSnNQ?=
 =?utf-8?B?UXh3SXVDNjNEZjMxamJHRjVtODZxSzZwWjRkSjRCbHpVTXdCSDE4OW9tN1dZ?=
 =?utf-8?B?NGRPZXgzaGh3N3ZRQkhSRi9kUmJtdU0xaU84Y2swNHBpTXFHbGR1WUltWkZ6?=
 =?utf-8?B?bWRJNWhEL1NiU1luWUJGN05wQTVMM2hpc2srTldHSzE1bTBTZnVGV3ZHM2FY?=
 =?utf-8?B?Q3JKcHRRQkM5WGZ6WW9vbFFaNmZiYit4Zm5vWThFUXRBWExaZ1VQa2tqRXY3?=
 =?utf-8?B?c2tzTElCY2VmcmNMNTdxd0p3L2ZKRTJYeWxhcVhpM042MTdUdUlJMUFSWG9q?=
 =?utf-8?B?bmNycXhnVHg5b3dvZGFtL3dyYlZ1TkpQZEpPNWJEZEUzZzlxKzRyV2JaSHlU?=
 =?utf-8?B?TElBcjZoaXU0WW81VDZ5K2ZIUEtVVFNwNjYzbDBwMzZ3cGcxSjhRdGFYb0NQ?=
 =?utf-8?B?bkE5d3NULzl2alU1SlduRzl4aWpoeU5acVVlQVJFVXZVc21MdUNLSVYwT3lK?=
 =?utf-8?B?aGZCMUlWRHRtQ2JhL0VsYXVIU0NmWjFNMElxb3BWaWxkelI4R3M2TGFZUTh5?=
 =?utf-8?B?QmlxYWEzQ0V3NERIYzBXcFBWYkRRYkJjNG1yTmdYTythUGpqQVRJelVBWVBD?=
 =?utf-8?B?MmR5dk9IbWZtdC92UWVqYXRzNTZ2MkJJYlpXZHFoZ2FSNUZ6RE9xNloyeHla?=
 =?utf-8?B?T0xvR2pGQWxYVm9pRzkxMWcwc1FkT0dlczdYcElIM3FxWk1odFVGM2tpaDRy?=
 =?utf-8?B?RzdYNExiVkVYaXVhUE5lcmFGK0oyM3lKY3lseEdMNXd6UjlxYzdDa0E0WEY1?=
 =?utf-8?B?TlFGV1JMTFQ1T0F3VUk2YktlQitGdU5wSHlud3IvN3NLdFN6VlRYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a584fbba-817f-49b5-38f0-08de839114c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 19:20:27.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVEkcKitHhfUx+nk/fMzQkzBSTMJv8TCfqCi+0077GHmOo4+U3Lsc8SwyowI5d/HPdgK05zOySFymjn0NmNjgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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


On 2026-03-05 11:16, Alex Deucher wrote:
> On Thu, Mar 5, 2026 at 10:24 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>> On 05-Mar-26 3:57 AM, Alex Deucher wrote:
>>> The value should never exceed the array size as those
>>> are the only values the hardware is expected to return,
>>> but add checks anyway.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> index a0cc8e218ca1e..534cb4c544dc4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> @@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>>       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>>>       case IP_VERSION(2, 0, 0):
>>>       case IP_VERSION(2, 0, 2):
>>> -             mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
>>> +             mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?
>> Does this introduce speculation and requirement to use array_index_nospec?
> I don't think so, but I'm not really an expert on side channel attacks.
>
> Alex

Also not an expert here but I don't think this can be used as an exploit. The cid is read from HW and is not controllable by users.

This series is:

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>

>
>> Thanks,
>> Lijo
>>
>>> +                     mmhub_client_ids_navi1x[cid][rw] : NULL;
>>>               break;
>>>       case IP_VERSION(2, 1, 0):
>>>       case IP_VERSION(2, 1, 1):
>>> -             mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
>>> +             mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_sienna_cichlid) ?
>>> +                     mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
>>>               break;
>>>       case IP_VERSION(2, 1, 2):
>>> -             mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
>>> +             mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_beige_goby) ?
>>> +                     mmhub_client_ids_beige_goby[cid][rw] : NULL;
>>>               break;
>>>       default:
>>>               mmhub_cid = NULL;
