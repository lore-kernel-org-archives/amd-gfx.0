Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42F3105A589
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 11:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4223D10E064;
	Thu, 12 Mar 2026 11:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYa51GBL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4808D10E064
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 11:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvLDJO0chVPOGHsyfDUpk1FwzQD3zUlLMvqgywywE+RpCbyGjiEsGWAid0LolOnTIHFIrG4eAcRi+tuA6BQlhdZ4ggKoGLkHfTK3GoSAV/XKa1fyt4clGREDSC5wHwB/jNkx3RCFNEwfYKcwiWfhkkC1sIApIlmLosv2RAC+ba9XxIrjpXk3EBKpEXnwHvaduItlOoPeoG876VdyY5eOlVj2OBYlkmtP68gOVx3AMhxwVFjL+hOnoD3TBsshPiLfoB2lOXvFBeH1rzxjvKpMhrCdaa9u2FrlVI0MDIGIoTqs75EJbeEFDpLhGI1kT0yaScOxFDx3Uy1GTNvoCX580Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5gxvgF/4Xz3lVHe3lIlhf6aUx6DoJEBIFLM44l4p1Y=;
 b=T+tuhTYy6KGyA1oSa2iiE99zrbyiapazo8YuRSEYy9Xk2eP9x2HU5KYsyQs4donO9LuV8cJ5PHsSgUyGrHKOdlgRDy2aCX4BcSByxRACyRMF2tV/wKVV5dj8Y/5VlTtaUOZ07eTIdk4MXKOG1XBQ+LD4nkJFXPF0p+ffisy18W9mMi+d+DBzc5KNIWvNoMReawjj4vnSbUs2ZAZ4sfvTTGnznzZZMdyFE0osZ0RnzuA55DaCySmsjQ7C4vmj4eAPxq4n5MvWhz3lAHku0Pd4sbNsJopWd8F3GkTCpg/jHcni9/SwKwBA8Tr5PgMYN+BIv2ecMDyAKulCjSchji/8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5gxvgF/4Xz3lVHe3lIlhf6aUx6DoJEBIFLM44l4p1Y=;
 b=yYa51GBLgRnR0NjZQkHqkK8+chRJ3BURzT+fWtxgZMXKFBrir4Fc/mqIIdDq0gtoVzHVohcg5PHe2ssqS3OMqsw6D8UnAbfKTUbFQdH5PwS2Vl2UHi0SnhQeJpZkpOn8eMUTCY2RkAPIjJZv9/CTmT26qMwSoakYXr1xj9MXqgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 11:32:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 11:32:39 +0000
Content-Type: multipart/alternative;
 boundary="------------6binA0VmODOQaL87CNYn32kp"
Message-ID: <4f194096-ad01-4b5b-a5cc-3cefd59f31a9@amd.com>
Date: Thu, 12 Mar 2026 17:02:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: unlock cancel_delayed_work_sync for
 hang_detect_work
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260312091655.1948356-1-sunil.khatri@amd.com>
 <a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com>
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5089eb1b-f5fc-49da-485a-08de802b114f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: yUFKoTc1YL4seoND31pN+88M4zdZJ0vomD5lF7vc6Rald9f0XujZmHfMBBq7hSJi3aVbNEU3m25qC1XE5p1XLMewbg565W9Mm0wduPSF5Y9Wqn4wSyTJafhGPyxRL9EAlbc4uS/xzwvitBQDPY74OovtpNJCB+ACRCqq56Tijz0+AbMd8HwxBlQFQRATd/9rSlnWywT+ryIABnJf4I1WQF1lCgIbcCptZsQ/ek2NJ+AKc+KfhWOi7HjQzXyR2/9kwg6r9bjm/Qx07YE6ihvyRsk1jw6Jqx91RAJCWFT/vqTSyBQGsI1R6v2hiVRO1iISQekwk6bwRQAOE9UAT/oVXtr9AWedxjq/5MyJVBr2Imq+RQVU539yI++Pgza/Qv2FhnMRSQVk/bqlEmlvUXZqmImz66/BzkilBmru45sGePWePT6dYVqEF7q0ci5TVn/RrwAOcHojgSXEkRueX+vd8452C3sUaWeeYqGZHXortfHrYRItb4Y+st51WstkFTGox0Mh5sq+HNTwOeopKZEeUe4XQlFEL6zn1teiV8AAgaLzyMufwRYIFZsKxo6qU7LCK25UmvZloZCVPkZB1xO2XBsg/EkxLPpppq3dPRn+Qt1WQnEpnMZ/qNq0sW+so0ZYMTl+FFIDqTOWwNGzKuq4VGJ/FrUnIAc2sbHpgyfw5wbxCWYk3C/6if030/muHJ9fNhoV0ViDiaUIgijLu1zmPeQ52gHa2V88o5IoZBxigH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1UxNXN3TFZEUDRLNkxEZkYzTnRrRTYrNVlEUHUxUXNHL2p0QWFIaTltcmU5?=
 =?utf-8?B?K1BCUDNjdzBkaEY1REgwc2M4QU9UZWxpU01LS0hRSndJTkNyUU9GekN2VWs5?=
 =?utf-8?B?ajR4YTVuUnAvcXFCVlhUK3VoSjF6YjB3YVU4QmdtM2lrZGR5NXBiNVFvOThr?=
 =?utf-8?B?dnhheWFIZ0dzS2daeGRxRXJza2YrL3NoN3ZPeHhBK0ZweVpkS3ZQVGtraTdh?=
 =?utf-8?B?OUFSSzhIZ0QvTWdQU0ZpUVpRZ3VrZ3p2djQxSGI3TWtQZERzc1ZhQnpqUGVu?=
 =?utf-8?B?Q0FjTGVsL2ZMRzdzMnpOcUplZXdKVVI4ZVZFRVhyZmZ2ajNyaHh6N3AzOVBE?=
 =?utf-8?B?dUwzRU5pZys3MFZ1TzdNVlBka3BrbnhGVnl2dFpqTVZIUWxjOE8zMTJ0cUpq?=
 =?utf-8?B?VVltMW0rdTZlMGY5alhlYm5XWGFlRGlSd0UxaDNhNzZTL2RzazJMcVFnem5w?=
 =?utf-8?B?c2krN0xVUG80dWhKN3dCSDc4b05lcDdmRm5tN3RESDYyZEhNUThJbWljbXRU?=
 =?utf-8?B?aGkwTVkwZXVYOHZTWVZxSkhDL2tjVGoxMERuZ3BGdTd3Vk5KS0JzbU5IcCtP?=
 =?utf-8?B?ejg5Y3R6WTJkbDI2dWhPbCtrZTE5SmVwdjh0dEg2UStxaHd0WVpLaUxaN3Zm?=
 =?utf-8?B?ZktFOVVYaXJPa3ZtSFBoT2ZONHVYUWFDcDUzSmhYMHliei9QSlozYWsvQ09I?=
 =?utf-8?B?ZDNmeElzZjlWVzlVQkhZaHVPREE4TjdlczlpNnZJcEtzeFBFNmE0Kzk4UW50?=
 =?utf-8?B?eWNyeUNpUGEwWkFhM000SVJUejg5aVMrS2JveXNvMldlYndxTk95WG5nWnMy?=
 =?utf-8?B?S1EwdHR0WWdUTXJIMzVyTVVGWlJtSmwvb0plWE1VcUNaZ3ZDYlJVbFZJd2h4?=
 =?utf-8?B?M01hMGduWUxlZ1dGRlZZcDJPeFVjOTlFYmQ3TmlhejR6TksvWDVNZU0wbDUv?=
 =?utf-8?B?S0N0cTFTTEo3NnVjKzA3d0I0YVRWcTdabVZuYXMrK0piNjhWNVRoOTNRNDRr?=
 =?utf-8?B?UWdzTTg1SlVQZnlFQlFwTGZyb1c5bzJnK3FrWk9IOVhpMHdqaXV2QysxY1py?=
 =?utf-8?B?cW44TlMxZG1pV2dBZTNJRmd3dmdJUlE0Sm1kL3lLVVd6S1VJSnZqVHZZL2cz?=
 =?utf-8?B?Qi8vclZWN1M5eEY1S0hlVHdhMWFxVkVJRHNWVUtkTjErdlZmWWJkT3hvanRz?=
 =?utf-8?B?eG5HVXVGTmEvcm1aRnJId2xtcTVkcE9IMmZaNGwrZ05XYlJIa1V0NnVEREt3?=
 =?utf-8?B?dE5WSiswczJKRXNrazB1UGxwME1wRG1TandXYm84eVlGWFdnQW9aUEZ2QlJk?=
 =?utf-8?B?TGR1blY5c2ltMmZkdmVYd1pDcElBOHhxWHlLWnhVdXorRWNnTEtiV2dlWjVM?=
 =?utf-8?B?ZllYRlAyckRYaWQwN3ArQTgzTWd1Tlhyekc3a055KzB6MDRrT05ua1VTaU12?=
 =?utf-8?B?VTUvTm56UE4xSTNtZlYyMU40TkU1VnEvYWF1OEtndXQzWmlTWVQ2bndKNzhU?=
 =?utf-8?B?V1QxdUJoU2pyTkJUODgyNWE0eHUzellTUjY0RmIrMDROL1FFVkZ3NUxMOFVR?=
 =?utf-8?B?T1NKUVNnWERDcG43djdtM1djajl3dzJnWDB3ZVBiZEVzTk8zMXdUWFB3ajR4?=
 =?utf-8?B?Zy9OUUFpOHRELzh6UGxtYW9QTDZyZ0hHRDNmK085NDBVMWdnc3BveWtoRExD?=
 =?utf-8?B?b1J2NDdmSWdKVXNqQ1dZeUh5V291andHSE43aHdFZmVCWVN0MEFaWEM3cWdY?=
 =?utf-8?B?NWZjcUhvS1I2RU1OUlJpajdxZFJxVjJ4QUIvSWsxL2xLYXVrNGo0YkxQc3Ba?=
 =?utf-8?B?b1RUYi91TWFDSDRoaldiQTZLdWwvc1pQU1ZHelZ0VnJpWFRUUUlSNHZwY0ti?=
 =?utf-8?B?aUdXNE5BVDJ1TUErQUV6RkU3QlJpTTN1U25CUjV1MjRNUHQvWks4ZHJVMFln?=
 =?utf-8?B?aVJZdTlDSVBKREpoR3RQMEFjZFBnVHZBN0J5Z1B4T2I0eTg1QzlIOThOK2V4?=
 =?utf-8?B?VlFGd0Z6SDJtdm5HVzVGYmRCcFVFeEhmdFlnVmlrK0RiMlhscjZMQ3JJWUMy?=
 =?utf-8?B?eHExbXRYSzhCMXQrYTA1K3E0S2V4S0dRSGlHZC80bXhtUGdGTUx4R3Q0WkNP?=
 =?utf-8?B?WmdKaHNFYzdPNC96MUFSNHlMajFpNzV2cHJPUXlrcWZuUnVnR2lEMXNpeERH?=
 =?utf-8?B?d2w2TlVkejRhSERxRTk4NzNuenlRdUNHWjg2WVV3d043MGZKNDFWaGNzdTNO?=
 =?utf-8?B?RXFuNFhMSTdVaFdBZkdENkpuTnd6cVNFRWJNMlJERzZIN1B4Ry9hWmhiQUQ2?=
 =?utf-8?B?MFZhUVc5eDZ2bndkTEIxZVdVbThMNWRmOHZmZEEyTkZ0SGwvSFZ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5089eb1b-f5fc-49da-485a-08de802b114f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:32:39.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYBgnot489Azcqsw/LxTcjhOzI6I/uLEDa0slu5IsvrF0QPrD715Q+xHb8lMWeLedTdu7nOR8iC1TbTjt0Jlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

--------------6binA0VmODOQaL87CNYn32kp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12-03-2026 02:50 pm, Christian König wrote:
> On 3/12/26 10:16, Sunil Khatri wrote:
>> cancel_delayed_work_sync for work hand_detect_work should not be
>> locked since the amdgpu_userq_hang_detect_work also need the same
>> mutex and when they run together it could be a deadlock.
>>
>> we do not need to hold the mutex for
>> cancel_delayed_work_sync(&queue->hang_detect_work). With this in place
>> if cancel and worker thread run at same time they will not deadlock.
>>
>> Due to any failures if there is a hand detect and reset that there a
>> deadlock scenarios between cancel and running the main thread.
>>
>> [ 243.118276] task:kworker/9:0 state:D stack:0 pid:73 tgid:73 ppid:2 task_flags:0x4208060 flags:0x00080000
>> [ 243.118283] Workqueue: events amdgpu_userq_hang_detect_work [amdgpu]
>> [ 243.118636] Call Trace:
>> [ 243.118639] <TASK>
>> [ 243.118644] __schedule+0x581/0x1810
>> [ 243.118649] ? srso_return_thunk+0x5/0x5f
>> [ 243.118656] ? srso_return_thunk+0x5/0x5f
>> [ 243.118659] ? wake_up_process+0x15/0x20
>> [ 243.118665] schedule+0x64/0xe0
>> [ 243.118668] schedule_preempt_disabled+0x15/0x30
>> [ 243.118671] __mutex_lock+0x346/0x950
>> [ 243.118677] __mutex_lock_slowpath+0x13/0x20
>> [ 243.118681] mutex_lock+0x2c/0x40
>> [ 243.118684] amdgpu_userq_hang_detect_work+0x63/0x90 [amdgpu]
>> [ 243.118888] process_scheduled_works+0x1f0/0x450
>> [ 243.118894] worker_thread+0x27f/0x370
>> [ 243.118899] kthread+0x1ed/0x210
>> [ 243.118903] ? __pfx_worker_thread+0x10/0x10
>> [ 243.118906] ? srso_return_thunk+0x5/0x5f
>> [ 243.118909] ? __pfx_kthread+0x10/0x10
>> [ 243.118913] ret_from_fork+0x10f/0x1b0
>> [ 243.118916] ? __pfx_kthread+0x10/0x10
>> [ 243.118920] ret_from_fork_asm+0x1a/0x30
> Good catch, but userq destruction is completely broken in quite a number of ways.
>
> Have you taken a look at my patch "drm/amdgpu: fix eviction fence and userq manager shutdown"? How does this here interacts with that?
Yeah even after that patch the below is still open, and a deadlock with 
amdgpu_userq_hang_detect_work is still possible. So i guess we need this 
fix still, irrespective of your fixes in drm/amdgpu: fix eviction fence 
and userq manager shutdown
if(queue->hang_detect_fence) {
cancel_delayed_work_sync(&queue->hang_detect_work);
queue->hang_detect_fence=NULL;
         }


Regards
Sunil Khatri

>
> Thanks,
> Christian.
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 32541f1bde6d..c5875e175918 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -621,15 +621,22 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   {
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>>   	int r = 0;
>> +	bool hang_detect_fence = false;
>>   
>>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>   	mutex_lock(&uq_mgr->userq_mutex);
>>   	amdgpu_userq_wait_for_last_fence(queue);
>>   	/* Cancel any pending hang detection work and cleanup */
>>   	if (queue->hang_detect_fence) {
>> -		cancel_delayed_work_sync(&queue->hang_detect_work);
>> +		hang_detect_fence = true;
>>   		queue->hang_detect_fence = NULL;
>>   	}
>> +	mutex_unlock(&uq_mgr->userq_mutex);
>> +
>> +	if (hang_detect_fence)
>> +		cancel_delayed_work_sync(&queue->hang_detect_work);
>> +
>> +	mutex_lock(&uq_mgr->userq_mutex);
>>   	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>>   	if (!r) {
>>   		amdgpu_bo_unpin(queue->db_obj.obj);
--------------6binA0VmODOQaL87CNYn32kp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12-03-2026 02:50 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com">
      <pre wrap="" class="moz-quote-pre">On 3/12/26 10:16, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">cancel_delayed_work_sync for work hand_detect_work should not be
locked since the amdgpu_userq_hang_detect_work also need the same
mutex and when they run together it could be a deadlock.

we do not need to hold the mutex for
cancel_delayed_work_sync(&amp;queue-&gt;hang_detect_work). With this in place
if cancel and worker thread run at same time they will not deadlock.

Due to any failures if there is a hand detect and reset that there a
deadlock scenarios between cancel and running the main thread.

[ 243.118276] task:kworker/9:0 state:D stack:0 pid:73 tgid:73 ppid:2 task_flags:0x4208060 flags:0x00080000
[ 243.118283] Workqueue: events amdgpu_userq_hang_detect_work [amdgpu]
[ 243.118636] Call Trace:
[ 243.118639] &lt;TASK&gt;
[ 243.118644] __schedule+0x581/0x1810
[ 243.118649] ? srso_return_thunk+0x5/0x5f
[ 243.118656] ? srso_return_thunk+0x5/0x5f
[ 243.118659] ? wake_up_process+0x15/0x20
[ 243.118665] schedule+0x64/0xe0
[ 243.118668] schedule_preempt_disabled+0x15/0x30
[ 243.118671] __mutex_lock+0x346/0x950
[ 243.118677] __mutex_lock_slowpath+0x13/0x20
[ 243.118681] mutex_lock+0x2c/0x40
[ 243.118684] amdgpu_userq_hang_detect_work+0x63/0x90 [amdgpu]
[ 243.118888] process_scheduled_works+0x1f0/0x450
[ 243.118894] worker_thread+0x27f/0x370
[ 243.118899] kthread+0x1ed/0x210
[ 243.118903] ? __pfx_worker_thread+0x10/0x10
[ 243.118906] ? srso_return_thunk+0x5/0x5f
[ 243.118909] ? __pfx_kthread+0x10/0x10
[ 243.118913] ret_from_fork+0x10f/0x1b0
[ 243.118916] ? __pfx_kthread+0x10/0x10
[ 243.118920] ret_from_fork_asm+0x1a/0x30
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Good catch, but userq destruction is completely broken in quite a number of ways.

Have you taken a look at my patch &quot;drm/amdgpu: fix eviction fence and userq manager shutdown&quot;? How does this here interacts with that?</pre>
    </blockquote>
    Yeah even after that patch the below is still open, and a deadlock
    with amdgpu_userq_hang_detect_work is still possible. So i guess we
    need this fix still, irrespective of your fixes in drm/amdgpu: fix
    eviction fence and userq manager shutdown
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">queue</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">hang_detect_fence</span><span style="color: #cccccc;">) {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">cancel_delayed_work_sync</span><span style="color: #cccccc;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #9cdcfe;">queue</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">hang_detect_work</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbs
 p; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">queue</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">hang_detect_fence</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #569cd6;">NULL</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; }</span></div></div>
    <p><br>
    </p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com">
      <pre wrap="" class="moz-quote-pre">

Thanks,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 32541f1bde6d..c5875e175918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -621,15 +621,22 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 {
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
 	int r = 0;
+	bool hang_detect_fence = false;
 
 	cancel_delayed_work_sync(&amp;uq_mgr-&gt;resume_work);
 	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 	/* Cancel any pending hang detection work and cleanup */
 	if (queue-&gt;hang_detect_fence) {
-		cancel_delayed_work_sync(&amp;queue-&gt;hang_detect_work);
+		hang_detect_fence = true;
 		queue-&gt;hang_detect_fence = NULL;
 	}
+	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
+
+	if (hang_detect_fence)
+		cancel_delayed_work_sync(&amp;queue-&gt;hang_detect_work);
+
+	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	r = amdgpu_bo_reserve(queue-&gt;db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue-&gt;db_obj.obj);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------6binA0VmODOQaL87CNYn32kp--
