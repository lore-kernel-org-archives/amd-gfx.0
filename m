Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C618EC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 10:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F7110E0C4;
	Mon, 28 Apr 2025 10:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcAPpVfe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473F710E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoQaTEOt8nlzQoD1XPxt6We8SYh7XGOF9pvfkWhmJR8Zj33jnnHtDPU6JDp2tnk/UADDd+D6TJDooLwloR+guUeFU1KSHkzQ9xbPwtd14utk0Q8FpnAd3D8mZJmEt/UYUSeUhV5VBwxdH3lElgaOtEEMf6xjTbvfu47uY0O0mq0jAMzOHCzo/s5WOIgd+q5Rs1q7n5tYPXND4+Niw6Eoia6YYcG9v6uA2KQhfq5UIEB7QtdR4hLsFd869K4LiVn7tFu/U+vc3NgpxeJx6BvnUrznmnPVdRs2eMJVz7JGH0drravN2aO25y8bgxjG3dpk0zGj+F95nMnazrjUXvievw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8mHMcIklW+MVdTJoKhseE/SadIdtXgd7z/p55FoqLk=;
 b=w3otCF3z5AcQ/fhkQw4qYWw9uRVI8uH+gp5+SiYbYmEe687RoA8mOWtmT6bOTJ6j7Mzb0LgujeiTC9OEPS1zsTNtRhNeWX4QKTzuNrcC3YbbHFGt1v1vf1SQ0fc2ptwq7ZIayfdic9RDZqK0jYpL9tE3aASn1sy+VL00DuZ6b2U4J08sdcw14UnY8z3mfBUQ6gmkCLggxl9aB4AOuuNqjSS/SwFCc0qkdD4CetrlRyZ17PbNfZiHchLy3552XwLMJLBk9cA77fGjc195NE4G+q0Y025DU7R9CXYEjDFDpVKCgdgM4W7oKHW3G9G9iOYJD4XPPVqXFCdpCvao9MFmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8mHMcIklW+MVdTJoKhseE/SadIdtXgd7z/p55FoqLk=;
 b=rcAPpVfej1tjWXkVIfGcT41K2V97HLGx/WZDT8qIvvPGWH9pxOkVQa+ztKAx3yobHFE52C2Gv0UY4XghdZf5wFfPLMhpFSaNixxnGt0H+zixtSWvc7RjiqfIlcrTOm81Ch6h5DWMudw74OQcZxEGUFpFajx2fTWX8ffSCvJyWZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 10:04:15 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:04:15 +0000
Message-ID: <ad465cb0-22e8-4ef0-8b8f-115ac97823ea@amd.com>
Date: Mon, 28 Apr 2025 15:34:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: add UAPI to create user queue gangs
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
 <091c7fe0-b6ae-4d6d-af0c-8da9e4e84e08@amd.com>
Content-Language: en-US
In-Reply-To: <091c7fe0-b6ae-4d6d-af0c-8da9e4e84e08@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cec300-d934-4de7-030e-08dd863c082e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T29LQ2JOMjlTZCtiTVFWSWVWeE1KSjNEK0RhU01FeThsVC90QW43WjdycFlt?=
 =?utf-8?B?VEVpZHZlbXBsdVU4ZDFad2FGVTFKdXpmRlRJSkdMSzlPVEt6aE1oNklaQnow?=
 =?utf-8?B?OWh3K2EzTnFMa1dpTGk2Q1RrdHh5SjZCK200REswRUplU1VmTUNtd3FqZGpI?=
 =?utf-8?B?eXMrM1BmT29uTXNPeXVKNDY0NDdGbUhMNXdDQjRLSEhLbUZiYkdLckt5V3JL?=
 =?utf-8?B?ZWdDTkU2aGZKbU40TDNtS2xDMmp4MmxqaXh1eUpmMUtKWWhPSU1KVWtwRjht?=
 =?utf-8?B?RjNGd242T0FMQk5HRGtyTmRidVhLeFdXS2ZZcXhOWndXQkVlUDEyK2J0dC9h?=
 =?utf-8?B?UGdEb2Y1cVFoUWlQUGxleGQ4K1YvVzBMcjRFOGtvSnFkRG84MXRBb2hxOS9w?=
 =?utf-8?B?UnFIUXNHQStHQ1RobHdOSTN6T1NkVFRyREtwdWRYQkJpYktUKzVPQVV1VXRW?=
 =?utf-8?B?VzBYTEg2UmZ5Tmp2VmdVUDdLWGNwZGtnMjhlRk9JZDhlTmhiVWQrb1ZJWUlk?=
 =?utf-8?B?MG5RTVlSMGhDeFdHL1BPVzJXY1FnWGU0MFAxRWs2eXRaVlRkYmVYRlFqZWI1?=
 =?utf-8?B?UjhnZ3JzcVgxN0ZMcm1hS29WaFhHdndaRnFHZlZGR3JXcVExVkpQMXl6YnN5?=
 =?utf-8?B?Qmp6MXNnSTBSTnY5L2NQMHE3bWIxNGhwSG1RS0t2YnF5K1ZHOVZBU0hiY2Vt?=
 =?utf-8?B?enQ3NkY0RmRFTjFxVkZ4QmYrUDFteFFidGpWQklaUy9vcGRUMmo3ckUwSDRt?=
 =?utf-8?B?TjRKT0thY2tFekdheEx1MjVVSEtBazZheHVWcXlzT3BMUXN0eVF2clZLd2Nj?=
 =?utf-8?B?UnRheGdoL3Ztd0VoWkdEL3NQTm1lSlpUZkFGak5YWWtQSTJXeW1uMHNwRi9H?=
 =?utf-8?B?WUlTUVpXU1hGdFBQSm5yOUFnTkZVaC9sTUlHdnB4WUtjQmV5L3BST3FqMUV1?=
 =?utf-8?B?WUhwa21iQkthaEhFWW5BTk9UWkpsZFJHdnVodGlBSlRHQVhhdXdrMnFMclV5?=
 =?utf-8?B?ZzVjNktoUkZIajB5UkZpWmdHVE5iT3RTOHFycU9HNmJUKzd4MmlYUjNNNmt2?=
 =?utf-8?B?Zk9PY3YrZEF3ZGRZbzM1YWsrSFRFbkVtV0ZmS0N6c2lqZEdZRnNOYU1JSGh2?=
 =?utf-8?B?aU95TWRSb29QRkl0blI5NkZaYy9KZ2JJQ20zNkphWkRYQkNQUGpIN1ZwOVM4?=
 =?utf-8?B?UkZhLzBQTUFyNS9OQlFvcUtJTElaS0U0RGFRbmRIOGk2TVM2NXdkTDdTSkxD?=
 =?utf-8?B?QkE0cDk1TnIwckp1SlkrYzNYbSsreXJUNlJNYlpuUVFJQXdLRGNYbFNSS3F1?=
 =?utf-8?B?QWZrWVB5dGF5azcrR1orUDVhdk9oMHBKUEFZL2Jha0VuQzF2RTQwa3IvWmQ1?=
 =?utf-8?B?NzFBd21KOWtEUTZYeFEycTZSZDlPSTBycFpVNG82MU9QOE9NdCs4cTRxUm15?=
 =?utf-8?B?VDc5dDJ4eUg5c3lEcmsvdG1DelB3eVA5aDU1U0loN0s2L2kxS0FkVnFtVzJo?=
 =?utf-8?B?akYrVGZzZFVRU3JlbTYwMi80dmZoYXRpSlU4N0JwUDI5c2k4ckFiOHJYaGtr?=
 =?utf-8?B?OWNOazA2d0p0NXNxaGRoQVpRU3BRdTBIU0lZQ3MyL1pmOVFSRHJwQmVqNUdW?=
 =?utf-8?B?WUZuamZIUjBReHJPQ0RURDIrR1c2NnhvbUNEVjQ5OG52SDlnNEdtc1lxUVl3?=
 =?utf-8?B?MC9pQTRoMUdpaEYwTnlXT21oNzRndlBiZWVaVU9CUEpOMTBWS25udWNRMkFD?=
 =?utf-8?B?NHhTdUZMU1k5bUxmVmt2cTFLUWNxUGJEU3ZHSW5OSllja0wvTXFTNXdFeFRv?=
 =?utf-8?B?d25VZk1lNmpORG4zOUUwQlgwN3VUQXlLdzhMVW51cVlueDBqYVRGbWtxQ2h5?=
 =?utf-8?B?RnZxd25iRVM3VE9BRXMrTXZ4NGRpODRVcDRCVEsvTmdRYUtBVmN0bkdDOUFu?=
 =?utf-8?Q?blh/evW5qT8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNVc1NadmM0T1JpVDBYSStSV0lweHVrRm44eCt2Rm8zTjRkYldSVk5CSHdP?=
 =?utf-8?B?MXFaOFhOZjF3MVhiTFQzZGd6NEtJVWhzbStmT0dyNVFsOXdVVzRoMyt1S0t5?=
 =?utf-8?B?N0JDbC93aDQyeWphUy9qQ3Zod21TOXloR1J6c0tGMGVzYk1ZVjhXTlBvekl5?=
 =?utf-8?B?VTYzL1pYd2hzZFF6VllpUURVTWJoRmgwY1ZUSXZWVHYwa2hIZ1hTS3QyNWVo?=
 =?utf-8?B?bHpJN3VGaXJFdEpzcE1LL0lmWG10T1MvdUNTSjF5eHRvai9ndTRhNW5yOTRG?=
 =?utf-8?B?N3oreUYwU3pWR1VXSDk3MFVOMitzOGI3RkpRUGppZTJLUXk4Zjg1Qno4WTV1?=
 =?utf-8?B?dmtXRnc5Ti9QTHJLMmVPMlhXQWFUam9rN0NUTWlycGMxVTdBc1FmZEdORUdt?=
 =?utf-8?B?c2RPYW9TMThGMWlqcEpzS1hhd3A2Nk1FNWsxbUk4TFQ4MUNEUmlXZGJBYjRN?=
 =?utf-8?B?d2x1aDZQY01kTnNxTlY2MWVva2dLQnV0YmVmc0NwakJ4a3ZFUmJHMTd0bkls?=
 =?utf-8?B?K05lbWlrOXJNT1pZS0ZpaEFmbVhiTjA0SGYyeUhHcVUvRHp2amxsemppaEFS?=
 =?utf-8?B?QmU4bDFxUFo2VVpobnpJYnYvbEpwUUkvaGN1NEluNTNrVGhwQnNramhqMmhq?=
 =?utf-8?B?b2RBbHNRbEYzZ1JJM29XK2tuYkwxS2JIcHJCZ01VVjNjZnZ3TnM0bk5vTVJa?=
 =?utf-8?B?eEViSHJQZ2x0ZUpWQi9wRDlUZ1ZWNFNYaU9TbDFybmxndEp6RkY3ZUhlR2lo?=
 =?utf-8?B?UjZjeGdrbVZCK0NCWDJ2NE9NNG93QnZVRnVWMzhpVGJKQ3M5dVdjWnBTUTR1?=
 =?utf-8?B?Q0JFSDR3WVgyNG5SWXU4bEIya0MraG9zNkxpUlN0b0VJeTMvdVZLWE1wR3dD?=
 =?utf-8?B?ZlhzY3pOa3RrcVFlQVpZbStBZEQ2R0V0MlBSd1picElKWXI3bWxsK0lOTXFZ?=
 =?utf-8?B?akcrWk5Ha1VGOURhU1RBcmhJVkpyais3TzA1d0h2bzRvUVdTL2UzZGNQUnl3?=
 =?utf-8?B?RzJHQkVBaGZGOXdCV3hLb2dBdzgyRjZoM01EWDlDajJVTFJRS25HMU5zbEx1?=
 =?utf-8?B?aEVNNDltelhBT0dFSEg3TUJwMDIvdGxiR1NBR29xQWdSMnlJYVllWTEwL3JO?=
 =?utf-8?B?a3Q3Z2dKbDRyajFXdjRXbmNlbGNlY21MWXBkZ1AvQnFiNXg0UDk0QU1SMk5v?=
 =?utf-8?B?Njd1VlMveGt0d3c0UkJVZW9qL0szN1dySWtQRk5qMllscGZsbEp3cm5nTHNk?=
 =?utf-8?B?WmhkKzFJOGxaT05yb2JjRWc0SWZyS0U1bkFYVENOMFBYREZNb28xbGFhZFA1?=
 =?utf-8?B?YnBhMG9USkVEaW0xMUoxSzNNK3I0N3dJdjRkaU4ySnpzK1Zqd0JkWWF6SkEy?=
 =?utf-8?B?RkNmaWtueDlRNjhUTHVaZGJ4dEsvUGc0RWN3cGowcm1kOGE0VitYMFUrZEFl?=
 =?utf-8?B?ZGowbzBUWEZpb1QvbHR0dFRKUTJsZm1kdW1vTUp1YVBoeEhxeFNYWFJwQThX?=
 =?utf-8?B?YlhhOXFuY0U5ckVHYnE2VDN4aXhPcE0xS0ZuMVZydnlPL2ZjNjR6M1hYZ0Q4?=
 =?utf-8?B?MFFHT1ZzaHg2WG5mTWEzYkRSeGdqVGRSaWdkYmVLcG5lT1hxRllZWDZSNGVF?=
 =?utf-8?B?dDJqcXB5ZEh2SUl0VDFCODVML1B4Mlpaa1J0RHZjVStid2dMdlFtS1JoaHI3?=
 =?utf-8?B?dmlSNGpXdm85VDNKSmp6QUlMS1h1eU9VM2R6RjNoK0p5OGpBT2RXWTE2TDly?=
 =?utf-8?B?N08zTXJ6SXU0anF6eUhUTDRmZzc2TER4UGNWMWZlQURtN29DelFYc1FMTmU0?=
 =?utf-8?B?K0NqemZuaHozYmRhVzR3ejlQdS93Y2FWRFh3TTYzRTFvMm42TW8rSE14aWc1?=
 =?utf-8?B?Skl4YW9rT0xxNzg2NzRHNnowRWlCL3ZmcktqdTdoYXg5c2RWQlozV0ZGSndN?=
 =?utf-8?B?TFRCRUdpNUNzNGswMlQ1SUsrWk8vSVdMNmltUExCeVlSM09tdVQra1dPUFIy?=
 =?utf-8?B?cFhwZmROTjlPUXFTZ2o2elo2NElablhJRGI5QktOWE44RXU0L2d1aTFVdWI3?=
 =?utf-8?B?aFBiTjhhT3FIa3lmMjVmbFUyMmxUcnRwN0xJVU0xbUt0ZzE2dlErd1AyS0Er?=
 =?utf-8?Q?WRvKZOjGbI31792mqTRYHcgYt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cec300-d934-4de7-030e-08dd863c082e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:04:15.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2ZUFKx3Y9IG5qQ8qz8uU/8SJdFLwWZZxS130fws2TnTpjauTmT+y3sHHSiOX9r0gyfQzbtbqLuSP38z88PRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

Small edit,
Series is Acked-by: Sunil Khatri <sunil.khatri@amd.com>
On 4/28/2025 3:32 PM, Khatri, Sunil wrote:
> LGTM functionally,
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>
> But i would like @christian to look once as he is one of the original 
> author of gang submission.
>
> Regards,
> Sunil khatri
>
> On 4/26/2025 12:11 AM, Alex Deucher wrote:
>> Queues in a gang will schedule together.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 56f052a10ff38..83414563779fb 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -329,6 +329,7 @@ union drm_amdgpu_ctx {
>>   #define AMDGPU_USERQ_OP_CREATE    1
>>   #define AMDGPU_USERQ_OP_FREE    2
>>   #define AMDGPU_USERQ_OP_QUERY_STATUS    3
>> +#define AMDGPU_USERQ_OP_CREATE_GANG    4
>>     /* queue priority levels */
>>   /* low < normal low < normal high < high */
>> @@ -417,6 +418,15 @@ struct drm_amdgpu_userq_in {
>>       __u64 mqd_size;
>>   };
>>   +struct drm_amdgpu_userq_in_create_gang {
>> +    /** AMDGPU_USERQ_OP_* */
>> +    __u32    op;
>> +    __u32    pad;
>> +    /** Queue ids passed for operation USERQ_OP_CREATE_GANG */
>> +    __u32    primary_queue_id;
>> +    __u32    secondary_queue_id;
>> +};
>> +
>>   /* The structure to carry output of userqueue ops */
>>   struct drm_amdgpu_userq_out {
>>       /**
>> @@ -436,6 +446,7 @@ struct drm_amdgpu_userq_out_query_state {
>>     union drm_amdgpu_userq {
>>       struct drm_amdgpu_userq_in in;
>> +    struct drm_amdgpu_userq_in_create_gang in_cg;
>>       struct drm_amdgpu_userq_out out;
>>       struct drm_amdgpu_userq_out_query_state out_qs;
>>   };
