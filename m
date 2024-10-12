Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCA5CF2572
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Oct 2024 17:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4614F10E0BC;
	Sat, 12 Oct 2024 17:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjTfGyt6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116C710E0BC
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Oct 2024 17:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTZqR+IiPLwtBYfBOSkqGdKbI122BguJIaqKcDRKiQDbdQoKVIrbKA7csRrR8QmgARLcTYKQLemvtXi5WijFgpe2OjsuxAnkbOiUDqN8leF/AQcnMmM14pCTOOmQPpNhbExDyIo5TVAk+tjzfc2imRcGEYqiXwJzv4C/MykvPjRHYRfKfqgLgfY3QUEZf/VpCr0E0E9okKDA4AYjvlhf8HW3Ha5GGTsynfSMnoJbiU3cH5YMWzfE7PGbyWkhF/gh7w2OulmIMuTPskGsmlh0OU6C5osFgHwU0CqsbuUSOJLQF6FdC2kKPr0xbWXqloliD1MlmweX3VRjIT0rBCeWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zfswohsdxxHtGyUzO+NAgMYRyz6kU5MZpUkgdireYU=;
 b=eoyTpsXNFVjAbKZ7bsIwh+Aoh00lqKAjYpTNalyUBw33VqXrlPt8PWsTqi2n6KPYFkyHhxoUu8+h3Pd3ZlM42v5AXB+NPv2+d5vc0Fo8iPwsFAz9WqZXOKT3RSWL4+9PHf1D1NACWszXADH/rJMBtthX1ntsle/zmDISJv90wKiku6GFxtPlRuYz5GtQK9E6e+nIDkMyr/5hAFF+3V242p0nIb8G0N57/B9l2Gzs/Uhr/R0Rw8BbUi+Oo8RJEBFmPWZaB0LF6qkbPY/TnxJRdRSBwQMGZhHYGS7sFVC5M0EqyLLuoiZY2dsBBIG+NoeBeiAjuc7U9iOHDSkKy8JLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zfswohsdxxHtGyUzO+NAgMYRyz6kU5MZpUkgdireYU=;
 b=kjTfGyt6r7AihaB9/EtfsQvNG7cXa6ZoIkAzG+JiEA0ACbEpwA1rXnYKgn1XHg5gqaaVi5xOLT9Z9I9PeP0s/6QbIZj5f1CliADaKbxTn/piJ2LEdfCD924SiioxStviCvzkA55ADskxOhebmYZKCJM8eBmV+6MdvcRpx2E6lQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 17:30:41 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 17:30:41 +0000
Message-ID: <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
Date: Sat, 12 Oct 2024 12:30:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Zhu Lingshan <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: b436f0d6-47cf-438f-1901-08dceae3981f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdnZ3gvM01RYUlqRkY1UnJrL2xiUGp3Q0ZaeXN3TDZubUR0QzdxTkI4bDdi?=
 =?utf-8?B?eUl6Q0M0eVBOeWRST2dTTW1kTk9HUWlvSmdVbHFTYjUwdzAya3laWlJzc2xr?=
 =?utf-8?B?T3pjaWNzSVMxa3l2b0VyMStPMno3cWVpV2dady9rZURYNEI1Tkp1ayszTWd5?=
 =?utf-8?B?elBTbk5uTmhoNDl3WHZOWDFPTkVOSHk2b2VTNmFUc2hvdWJGdUJKT0ZsLzJ0?=
 =?utf-8?B?MFZmakpIcG5hSW4yT3JHMEZFU09Ob3BibWpCTlRtY21jK1RtWmh5N254UFFW?=
 =?utf-8?B?NUl6U3NRN0Eya1BmUy95N01vS1h5NHVqSFhoZnMrbzJGWXNjdEttVHozck9k?=
 =?utf-8?B?WVY2ZHFmTjFMMzZ2SmhSWkhqS1FROE5FYW81ZTJsTkhJaVBTZ1JJRDdaeW85?=
 =?utf-8?B?VTlGcHY3SXNrZ2JkbEdQQThROHhWWGlBdFVod2dHczNEcVlYZnViaVJIU2Jh?=
 =?utf-8?B?UlJXZXE3dXdhWHFrdEFZdnpwQy9PU1BHUmtEK2pLaE01RllDKzRhNmdpUmR1?=
 =?utf-8?B?RHp0S3JIemxqOTA0MU82MHd3QXp5VmpDeTA2MTlpemFwZlBPWUVpVU5iWkcv?=
 =?utf-8?B?NHZ1VDJjcnkzU1REcmlzbWlBTm9oOUxieVd3Y0RKWW5uRTludXpIYnljc2w1?=
 =?utf-8?B?QnZnRnEyOTJLcmhmcGw5S0xaeTFycDhiQTMxeFJGR0M5TzN4STBRK01BR0tI?=
 =?utf-8?B?SnhobUFPenl5UFVUSFNhL1Bwc2VwSFcxdDhkTVpleDVBUWtSOXhMQWJpbXdU?=
 =?utf-8?B?bEtNWVlzbTZkQ0JFdVh1Y0xFS2RUbTN1eUpWbkFoOVRGVURkSTFMMzF5elhH?=
 =?utf-8?B?OXp0N1FNczBVRjgydnZNN2hmc1lWRm84eW42eHVkZ3BLdXNydFN3VTkzbXBh?=
 =?utf-8?B?Qy9JdEJiSzFXT1YxQzRFYitCbFAwOW54TEY1UDFRL2pKc3FGQjZUcVVVRy9C?=
 =?utf-8?B?V1JOQnFsWlpOM0F2dWVDSzAvNWsvcnoyalNnQng0dFgxdG9QU0I1TDB2WUp3?=
 =?utf-8?B?VlBnVWhQb1NCYzFrWmtIcy9CeFpyNXlBL0tuWkdOM1BYQnFXQjROV3psNGRy?=
 =?utf-8?B?OU1lK2VZWnFiOEdGMzBuQVRLVVk1QUdHYmNUZWJicExpMHR3RnlocjFYVks2?=
 =?utf-8?B?a0hHUitZVGtVdE1xOUJUeVlUeWJuSVFkL29GR0x3b082eFgvbDc3L2xManBh?=
 =?utf-8?B?MEVyNVVZRDJxQmlDQTBsVlhKbnNNendQVXpuOHJ5TkhOOFFWSDhwT0hlYWUr?=
 =?utf-8?B?NDROdTYxWG1URExTU0pYbWM3YmVkL0N0TEVDNzcreEw3d0doenlJSklqZEFi?=
 =?utf-8?B?TFkwWUZhSUZjRnZvOENNUHY0YXZYajJSaHZtdDBiRStoSUdHd0Q2MXlFbHg0?=
 =?utf-8?B?MHRIRnhCYzJYcjhpSmo0cXdwZjgwTEQ2U3RkZHJVckJIeC9wSVJadHhrQjJY?=
 =?utf-8?B?eVhRRjhhZDZ0cmcvVGlUbjVGNDVoMTN3VS9CRmUwUzVGdmJEWkNUYXVYUXY1?=
 =?utf-8?B?QjJaQlNVYXE0amh1enFmZXlkdGNuOHE4aUJOcVBIMGY1TGlQd2h1Tkgwb3h5?=
 =?utf-8?B?K2sxcnNrL1F3bzBPdHF0ZktBZitTbGxHYnB5cEMwVFhJZ2szVXBrYnhHL0NK?=
 =?utf-8?B?QWw0dGVVa3ludDZNNFZEd0hGWm9VUjF3c2pzYlVxUDhlUW1pbVhqZkpmQi8z?=
 =?utf-8?B?clM4NlBYWEVxS0NhcllpbmlUc1N2UGJBWTRFb1JjTGNWWXlmM21tQ2F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJBdWFSU3BPY3VTM3A2RWlWdnEyYmtWbWdCaVhySUpkelQ5ZDRMbzd0WXc0?=
 =?utf-8?B?SmNZemZDUE9MdU1TQW5hYnZjK3d2NjA3Z0hIQldsRUdzQmZ6MEkrWmtMQnpB?=
 =?utf-8?B?WDgvTzd1MjByZSsxK2xpMHBrUVM0N1lqUGdiV3lSTmtFd2VUVE1qREl0cTVS?=
 =?utf-8?B?enF5Z2VMbHFrY2xVaHF5ZnoxcFFWbENaVUVRdUQvSTdNdkNtNmVwWi9haGlq?=
 =?utf-8?B?TW84MVZJd3YwQWpoYUZyR3Y4TlBnK3doRW82bTBaNFVoYlBaMEdjT2p4VjFR?=
 =?utf-8?B?cWltK0hGQXlUb2xKaFJvajVieDhKT05iVmZxdlZEYnUxSUlIRG8rU2VEbE5C?=
 =?utf-8?B?a1F4aVdQVXh0VUE3ek1BNlBUVEpIcXpxbDhhTG9kVm1EdUNMSnh1SUlxSDJE?=
 =?utf-8?B?ZjlRVUNhNmdTVXN6Nk9ZdUh2ZTNqQ3hOcFBmdXFzVzJzWllGc01zS1pSbG9P?=
 =?utf-8?B?S0lIc0xKeTdRcWp2N3J4V0RRcFNXWHRzYmV3anM4QmpTY1ZTZHZ4ZExhbmJH?=
 =?utf-8?B?dWd4MTI5UkhESzhtTHVRQjhsQ3JsRnh0MEZqL2FEQTRlckRDRGZZQVRjNk0z?=
 =?utf-8?B?SXZsT0ZaaWMrSWZ2L0w1Vlh2NTZoQ2Y5ejhZai9aNFYyMlA3RENXMTNaMm1L?=
 =?utf-8?B?WEp3YWExN2dLWDRJQzBNYVdUeUpQQ25jVERKNmEwQ3Z0aDlzZXhSREdMUm1z?=
 =?utf-8?B?b3h5bzkxamRaU3pJOHhjMnk4TzBOZVFiT3ZKMmxyREsxWGphN0xTMVhHQmMw?=
 =?utf-8?B?TmcwRDNPV0dKUHZ5SzFpdjcwNFg0VjVqcHRGYndVTVhWZ1h1T2hJelpad0pC?=
 =?utf-8?B?WUhHRWVoVkhhQWxFRjdJd0xDbENEYk1zS2U1Y0FtTS9IQ3c0UCtubzF4Mk5J?=
 =?utf-8?B?dzNWUjI2Tmk1QzVPbDVoY0xNcEVpcHVGU1pnRmd6TWdMWm1sSy9BTW00MjI0?=
 =?utf-8?B?Mmp5Nkhvc3JWbEVPV2FocTI1SmxvdnVPYVBYQS9CL3VXQlVJM1preVY1b2Vw?=
 =?utf-8?B?MW4rYlRrV2hBcDZTZExTZCtZU010MmhmczZxMklkYlc1dnBLaFQ4Y0huaVk0?=
 =?utf-8?B?L1lFRlMzblg2T1ZvcC9QT0U5aUp3cUROYldJTlJ6RnlxNk1DSCttQjJRZ0Fw?=
 =?utf-8?B?T1UvQ1FGU2pPL3pCdFJHTllBQkNxc2FJZ1lDbi9BVkx6Zjd6RGRIdnB2aGNT?=
 =?utf-8?B?MWVENDFZL0wwZ1d1WE5TUG1keEowU0pRWVdCWktVU3RuTkRlMm1QdklwdHdG?=
 =?utf-8?B?UTU5RzB1VnpXNHh6c0lYa01GckUxZlJjbmR0Zkl6MHY2QnY0bnliSE01bmdC?=
 =?utf-8?B?Y05VK0NpOWNIek9oUmdzSXFoeU10bHNWWHBObnVta21meCt4OTQ2TC9YU01B?=
 =?utf-8?B?Q2Z2SXVtSUZYZWRkcjlrTzgrVlI1bmlQOHBIRW5KQVVLTVJkSUFHOWMxdVJG?=
 =?utf-8?B?eXRyeVJhWFl2Yk5GR1VIUWdsUWVtNDJrS2NlZzN6YWRlQVlhWEVmZFNacWhU?=
 =?utf-8?B?Uk5HdFdRN3lTSGVzUFJJOGtrdVpRK21FWVhHS3dmYjJQZnRtT1pDWlFtL21Q?=
 =?utf-8?B?YklwY1BiY05KQjR3N2dYUjhSYTR1eURJV2ovdVQ0NDN5L25zRHluVktHTHpD?=
 =?utf-8?B?VkhQNHcrZlFjVzM1RTY3QVQ1T0NTbjJwMVpWUGorQW9ySkluZ3F4ZVYzN09K?=
 =?utf-8?B?bUJOSWJSL0N6UXk4ZDg3V1JNTW9EVHZPa0Ezb3hqWnZnWFhBUHBlb2lDL0VV?=
 =?utf-8?B?U0tkVDlWTFRVNzdlWTliYWVRbVNjK2MzdU9UQS8yRHoyMGdRTGFnWlNaNm9J?=
 =?utf-8?B?UStnNHFzMTlneDhwRWVWMTcya1Q0Y1Zkb0JFUzV3Smp2TjNld1NscUxjV0RZ?=
 =?utf-8?B?UW5QUEowN3ZCNDcrWHY5V3Vvak9nL1EvQ1BPY1JwbElNMFFCQmVzYk5uQU5u?=
 =?utf-8?B?MkdGc25IN0tPb014SlYxVy9xZ0ZRSlNiR2FUUzlOSTlNVjZWK2ptY1lPbGFn?=
 =?utf-8?B?UEE5ZVFjV09OQWRWNS9oZXE2bkxwS3N5UHNBbTRwM09DYWVOcGd5M1lxdEJB?=
 =?utf-8?B?ck5MRDI5M0FHMVVpcXZSTEFITldGa2pxUUVqZTc1L3h0aG1hMitoUTMwSXF0?=
 =?utf-8?Q?oPJ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b436f0d6-47cf-438f-1901-08dceae3981f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:30:41.1775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tM8YbkNCTasuCVZmBaiqD6Db/6Z8D7hKFfSEgyEWol5dp37JElkDZv8lBe/329I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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


On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
> On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>> process mmu notifier allocation since we decrease the ref at free_notifier of
>> mmu_notifier_ops, so pair them.
>>
>> When user process opens kfd node multiple times the kfd process kref is
>> increased each time to balance kfd node close operation.
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d07acf1b2f93..78bf918abf92 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   		goto out;
>>   	}
>>   
>> -	/* A prior open of /dev/kfd could have already created the process. */
>> -	process = find_process(thread, false);
>> +	/* A prior open of /dev/kfd could have already created the process.
>> +	 * find_process will increase process kref in this case
>> +	 */
>> +	process = find_process(thread, true);
>>   	if (process) {
>>   		pr_debug("Process already found\n");
>>   	} else {
>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   		init_waitqueue_head(&process->wait_irq_drain);
>>   	}
>>   out:
>> -	if (!IS_ERR(process))
>> -		kref_get(&process->ref);
>>   	mutex_unlock(&kfd_processes_mutex);
>>   	mmput(thread->mm);
>>   
>> @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>   
>>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>>   
>> -	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>> +	if (p) {
>> +		kref_get(&p->ref);
>> +		return &p->mmu_notifier;
>> +	}
>> +
>> +	return ERR_PTR(-ESRCH);
> this cb should only allocate the notifier (here it returns an existing notifier ),
> so I am not sure this is a better place to increase the kref, it seems coupling
> two low correlated routines.
>
> kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.

Who referring kfd process should also un-referrer it after finish. Any 
client should not do un-refer if it did not refer. That keeps balance in 
clean way.

The current way is using  mmu's free notifier to unref kfref that was 
added by kfd process creation. Ex: if not use mmu notifier there would 
be extra kref that prevent release kfd process.

The final kref is same. The patch just makes the balance in a logical way.

Regards

Xiaogang

>
> Thanks
> Lingshan
>
>>   
>>   static void kfd_process_free_notifier(struct mmu_notifier *mn)
