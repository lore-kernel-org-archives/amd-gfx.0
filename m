Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19CC61CE3
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 05:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146FA10E12E;
	Tue, 25 Aug 2026 05:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="phABz33b";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B776C10E12E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 05:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxcLNhFy9CyIvYxIuuh6ZUQ6+aZXznqC6fC7wNUrPb3HYXaG6siVq3/P7McEGbmsgiZuOEwNhuVRTGVKhsQh9tEotDguWdxaa7UxzsyjkmNoCCg4zLKhiENfUBOABc/CQcS+Xh6z1SUHpfXqjf8g6xO0Pd0P3BqHYhxKnAHSrt+UJ0oKfLie5gHgf1yOPezYvy1XB7j8w+qyMWtghamLn+ZqVJM5ZAonIMTXNOgygc0VM4izQVYyz//yz1sfhQ+xhChtc5g0O1f4lHuhwbxxGZ8kzK0gHoZM7IM2A4WQRwV8cBGl6MzAX92rqjcRbEnyXw8P/GFqSEN/Y5i07HKU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om4HsTxSW1cwaX2oBVp4Mrj6pSj1tBJBto3456KjVVc=;
 b=FiCkMvpLDqCu1ukn/OkJ+B2SULVQl8ENhYGNRKM1hNSv8ztUxoHSSiP6ZdZCGUgOUuElYbv7FY58xjaCuknuvTtXgwF58b5RoyruEEqxIfnAUjtLfslHcmPdkUg1o02Aqru0hMlyk87W+Y/QoI3LHl9BxOWrFJ/SQ0U2IdS+tNTwP0v3Itd3LR34eKqKqaw4tPgo0F5dgIZa63J4kYSOeIDjhUTCQJZCUATR6pe90waCwK5B1jhaRsXOHfxd6+8kT2KRezGfz73LTj1mbrR11zGNwCsQE9jPP0LRKquQ5SiUog8n1rwBc36P6Ly5ikArvPzdxFeCJRScqb/sJUqIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om4HsTxSW1cwaX2oBVp4Mrj6pSj1tBJBto3456KjVVc=;
 b=phABz33b4N8WvsvMCYQHrojzab69A8ipLD8XFSfJe4DDUmnuoMWTynbrs/i2i6LJFTgI4FZRYRa4VGRbcgZbsdeFVuoQgAbY068Xg4LSy38oGzx3JKCB3FUcdOSaldIMa2PVnAVu2aTimLpbHcbuYunLEOs5HKuU3JtiZjrpTq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:58:08 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 05:58:08 +0000
Content-Type: multipart/alternative;
 boundary="------------7EXRCXrX0rIHfMnyMzHs70f7"
Message-ID: <dd4bd2d2-095a-4b7a-881f-27ae79485b02@amd.com>
Date: Tue, 25 Aug 2026 13:58:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the userq manager alive as long as its
 queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260818115753.127358-1-lingshan.zhu@amd.com>
 <d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com>
X-ClientProxiedBy: TYCP286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::11) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6cd916-7731-4e57-8393-08df026dd647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|8096899003|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: zdQ2bJ5HYRVOOAW4a/t1DLRl3X7WZqwShiFBNyPEnmnES7tMks4LT0X02KQGDm1XNl5jC6hEhwwFKS6f+DaMGDlmZR5n+mxHtO1ZxxkPnjwT4NLhcsdvtqNHUOF+Z8ZYEGLBs93zT/auWRmokXJwZhzZLzArYAGDXUCrlG/Dq/SJ3wMlqulZL9WDuBhLLoDiv8OuJJ4VuPQYJPSwZyGeaNGRr3WB1RAC2cRqj7fzDjOPtt9Bje/64OXyPUMAD1rGnK6tCjg8WV1/Vng+SVzfHhonUpkgci0wIwiA0OvVRAZFD2Q5auYOi48Ct2H/NKA+hVtFOtJ058sg7BhY1AM1b2jr2KXTDQK75p5u4shV/BHHpjH/BoHSv/cb1M2TnXnJMcOQMDU6L8uDnFvfQMwX4JR7a9ly1GiOUuIMsbN4X8G2z6cAPsdaRgJIlZPrneOj7X62Oawpna+efT4QigxFOilGIv45ZhKge2m2Xf9E/y4R64YFxIWk2GLrtZbzrPQyoB9tRmP2KhVudUqG1hTI7Cfr0qw04SSPRcYdpkQ3BEk8EnJinrxoF4g2qUiu0UoR6wheTkwNf75gSEV2xBHBN9QRhltnt/p9ld0E/f026uGgfHxpiGhGia45jaIissWlkfUcNUxf+1qdUA9C5ZQYo2oqoZUobUbA7Jcm5a25NjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(8096899003)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZxTjNFY0x1R1RUWFFXdWprUkpRVm5RQ1NBUDZCS0dYWE1ORlhodFROYzNy?=
 =?utf-8?B?WGh5VlB3NC9pZ2hWM2tIK0piL1RCVi9CMkt4b2Y5SkdkNzNWbmR2cWNPb3JP?=
 =?utf-8?B?SzRBR1pjNTVTdTZvQ3U4bXZUQndGc3EvV003VVNwV0hIQzRIRndpaDFxbE1R?=
 =?utf-8?B?VjROdzBYVkFuMFVCY0ZBZXVTRS9zQkNQZTlxdFhCRG5OVXlUMExSSVJERkpO?=
 =?utf-8?B?THArSWxoSzlmNEYyZmpIOVJjYVZ6U2RJL1NadzJrYTRaNnExemRKTkhNWTFE?=
 =?utf-8?B?dG5IbXljdTRGb1hXb2RkcEtZKzhxcFNUb3FJRy9mR1J3SXJYbFp4MWlIbll5?=
 =?utf-8?B?bVZEN1I2WWZGaGNJaDMrSmpXWVVZaHlrRTl1a0t5L1VZcm9NcGdSTTErdjRO?=
 =?utf-8?B?OU9CdUlIUGNhSDZvS2dVVHFzY2JUb0U0cUNvcXZxTUpyUlBpMEt0RmdMU2tS?=
 =?utf-8?B?ZHRZYnlhVTVzYVhxK25UOEJvM1gxdm51YXVLV3hqM2lKTEYzeVVDRDM0b0hB?=
 =?utf-8?B?MHRGOUhoRGdqaTJiYXJzT2tLWDJZcDRWaU1zdENTVFhRc25KTDE5ZDRKMVlM?=
 =?utf-8?B?cjAraHh3VUI3cEptd3ROcGowaE1BTmg5bll0S21vTW8vQllGVkY1Q3NlNmxJ?=
 =?utf-8?B?M3ovR1pmb0lZUHhoaERmVEYzUUNUeXpkM0lUVHJYbm01WENxdEN1WGFkb1dk?=
 =?utf-8?B?K2F0ZHJoazdwZ2VLWElmdTZaNlpiT0tjOEhkcENZS1ltTlR1QVdJL3hkN0Na?=
 =?utf-8?B?THEyMXRXcGFwditjNXc0MCtraDhLYlBFblkwK2lxMGtia21HS3pvR1dxZ2lN?=
 =?utf-8?B?V2VrOGJCVFJTSGUvK2RwdTVpbVM3V1hQVENzcVYyMUp0dzZOMHhXSEFlNGpL?=
 =?utf-8?B?c3hmbUZZNHpFWDNaM3YzMjhUaUFoRWw0ZnJVS3FOZ3p2dWt3V0NqZzROalA4?=
 =?utf-8?B?NXhsQnlheVRNTGdkT0hCUFJ6U3ZnNm5hV0YrQkxXNnRpY0FBbk53YXdiTDlC?=
 =?utf-8?B?aFRuTlp5RXdhTzlmMTdIRW45TWhLWHlqYU9qS1pMcG1halk4SjczTmwzaloz?=
 =?utf-8?B?L2NHbk96a2UvelZ2WHZXMy90dy9acmh3SFFrK0tmRVhpMTU2R3lyWGppajFO?=
 =?utf-8?B?QTh4Y0wwVDlMRDRZclp6dDFZWndJUGdZQWYxY3ZFWmU4VS9wS1VSakN1WDB4?=
 =?utf-8?B?eUs2ZEwvYkRtU1hGMmlLdENFb0ltMytjQTMyRG5yd1VhL1VEQS9WbzRvKzI0?=
 =?utf-8?B?bUNMc2szUUZxSENOMVVtcHR6bEFobW1mWmhlSlhhYTMyOGtmWnM3U2pvaVNK?=
 =?utf-8?B?UFFOR2dzSVo0VWhVd2c3UHIxRDhkSFV3RFlwTGNNeWllM1pCZW1zaFVUYndp?=
 =?utf-8?B?SHpxV0UxMjFab3lUQVZGaVlSQnRJOXVzcVk0ZzVJVUwzaktHUFBmV29wYURi?=
 =?utf-8?B?aWQ0Rmh2b2h1MFlLWU1sRGFra3E0Q0xBL0VIb3pibU5qVktVdm4yMU9xampl?=
 =?utf-8?B?YmtkOEtBQkVjcjRUSmc5ZERGOTJsU1UzMUNTZ1N5NVVkNG1RdzlLQm44U1dl?=
 =?utf-8?B?ZXBJTCs3UDNrY21kZkRCYUthbzlrQXFkUTVKcVNTelF6bVdVdlVwMmlkQ29X?=
 =?utf-8?B?VldXbkgvTTdUUzdXdktGL3h5VlZUVklwTEdMbjV4RGJnMVcyZnZ3eDVFYUI0?=
 =?utf-8?B?OU5WUklNbGFyMm1GL0FyUWY3N1E4U1B3ZTUxTmcyYXg5aVc5OFdlcVc5cFlT?=
 =?utf-8?B?bnE4alNacGxVQVJkdHppZVdiYXJFSTFmMy8vWG5YRmMxcFY2eVFPd1NIbjhs?=
 =?utf-8?B?V1pQMHFsdnZGOENieE1NbzZFYng2aTRCeERUY3BnYVQvanlXZVpGRlZyK2Y1?=
 =?utf-8?B?dUVWWlFzM0d1OWQwNmxpcnQwS0xPakJ2S0xGVVNucVd1b09IRVYyVG9zdjYr?=
 =?utf-8?B?cTMydUJPd1lOeTR1dTZnS3NpUm4rendUaUc4bU1nV25tR3NzSWVob3B3ZVFI?=
 =?utf-8?B?V0JRemU5dTROTHUrOGdxTWFYakYveW5rb1I4ekk4VmZyTmNkajc0UGhCMWts?=
 =?utf-8?B?VndaRTZLUFpIbGU4UXRSYUF2VndkRC9SWURlbzZVUUJtQmNLTWdRUlRReGMv?=
 =?utf-8?B?cHBiZDNQSGZFaWI0VDQxNndjbDZMalZDMkxZNXBGbW1aTFVPd1M2Y3AxV2JE?=
 =?utf-8?B?eGg1a2t6eFdocFoxU1YyQ3cwL0Z4ckduelZ4TkZPUldRR1dNY3dLM3RIN3J2?=
 =?utf-8?B?d2JVb2pmY1A5cjcwbGcrMTdtbDFhY0Q2T0c2N1N1OTVXOG9oWmIweDRUU2JC?=
 =?utf-8?Q?65x7qMmIVH05ykE64+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6cd916-7731-4e57-8393-08df026dd647
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:58:08.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NodLloMCNeYnQTWW3rPaxXBKCbdPmtZ8/2TFGUYAH8k8w6dFfLyi52ytCEz/EpyWwKNNOwwxzMzxw3+6UFLzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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

--------------7EXRCXrX0rIHfMnyMzHs70f7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/24/2026 10:38 PM, Christian König wrote:

>
> On 8/18/26 13:57, Zhu Lingshan wrote:
>> The userq manager is embedded in fpriv, so any code
>> paths trigger kfree(fpriv) would destroy the userq_mgr,
>> even some of its queues are still alive,
>> resuting in userq->userq_mgr use-after-free issues.
>>
>> This commit fixes this problem by introduce a new
>> counter refs representing for the number of its queues,
>> and only free the userq_manager when refs == 0
> Well the userqueues are kept alive as long as there are IOCTLs using it.
>
> And and IOCTL in turn keeps a reference on the file and so the fpriv which contains the userq manager.
>
> So that here doesn't make any sense at all.
>
> If there is still an userq alive when the userq manager is destroyed we should probably call BUG(), cause that mean a major reference count issue in a core kernel component.

This can be more complex, what if the amdgpu_userq_put in amdgpu_userq_mgr_fini is not the last put of a queue, that means the queue is still alive even when
the userq manager has been destroyed. I will put this patch in my next series where the problem is better demonstrated and more reachable.

Thanks
Lingshan

>
> Regards,
> Christian.
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 19 ++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 24adad7be251..434384b53b85 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -533,6 +533,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>  	return r;
>>  }
>>  
>> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	atomic_inc(&uq_mgr->refs);
>> +}
>> +
>> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	if (atomic_dec_and_test(&uq_mgr->refs))
>> +		wake_up(&uq_mgr->refs_wq);
>> +}
>> +
>>  static int
>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>  {
>> @@ -594,6 +605,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>>  	if (r)
>>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>> +
>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>  }
>>  
>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> @@ -677,6 +690,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>>  				fpriv->xcp_id : 0;
>>  	queue->userq_mgr = uq_mgr;
>> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>  			  amdgpu_userq_hang_detect_work);
>>  
>> @@ -789,6 +803,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>  free_queue:
>>  	trace_amdgpu_userq_create_end(queue, r);
>>  	kfree(queue);
>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>  err_pm_runtime:
>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  	return r;
>> @@ -1277,6 +1292,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>  {
>>  	mutex_init(&userq_mgr->userq_mutex);
>>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>> +	atomic_set(&userq_mgr->refs, 0);
>> +	init_waitqueue_head(&userq_mgr->refs_wq);
>>  	userq_mgr->adev = adev;
>>  	userq_mgr->file = file_priv;
>>  	userq_mgr->proc_ctx_allocated = false;
>> @@ -1326,6 +1343,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>  		amdgpu_userq_put(queue);
>>  	}
>>  
>> +	/*
>> +	 * userq_mgr is embedded in struct amdgpu_fpriv and get
>> +	 * freed when kfree(fpriv). This wait_evet() blocks
>> +	 * amdgpu_userq_mgr_fini() which is drm_release path,
>> +	 * so keep userq_mgr alive while any queues holding it.
>> +	 *
>> +	 * This prevents queue->userq_mgr use-after-free issues.
>> +	 */
>> +	wait_event(userq_mgr->refs_wq, !atomic_read(&userq_mgr->refs));
>> +
>>  	xa_destroy(&userq_mgr->userq_xa);
>>  
>>  	/*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 6412a7f7b6ef..7141383ea2ae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -24,6 +24,8 @@
>>  
>>  #ifndef AMDGPU_USERQ_H_
>>  #define AMDGPU_USERQ_H_
>> +#include <linux/wait.h>
>> +
>>  #include "amdgpu_eviction_fence.h"
>>  
>>  #define AMDGPU_MAX_USERQ_COUNT 512
>> @@ -126,6 +128,23 @@ struct amdgpu_userq_mgr {
>>  	 */
>>  	struct xarray			userq_xa;
>>  	struct mutex			userq_mutex;
>> +
>> +	/**
>> +	 * @refs:
>> +	 *
>> +	 * Each queue increase this counter when join this manager,
>> +	 * and decreash this counter when leave this manager.
>> +	 */
>> +	atomic_t			refs;
>> +
>> +	/**
>> +	 * @refs_wq:
>> +	 *
>> +	 * Waited on by amdgpu_userq_mgr_fini() until @refs drops to zero.
>> +	 * This wait prevents userq->userq_mgr UAF
>> +	 */
>> +	wait_queue_head_t		refs_wq;
>> +
>>  	struct amdgpu_device		*adev;
>>  	struct delayed_work		resume_work;
>>  	struct drm_file			*file;
--------------7EXRCXrX0rIHfMnyMzHs70f7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/24/2026 10:38 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 8/18/26 13:57, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The userq manager is embedded in fpriv, so any code
paths trigger kfree(fpriv) would destroy the userq_mgr,
even some of its queues are still alive,
resuting in userq-&gt;userq_mgr use-after-free issues.

<pre>This commit fixes this problem by introduce a new
</pre>counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Well the userqueues are kept alive as long as there are IOCTLs using it.

And and IOCTL in turn keeps a reference on the file and so the fpriv which contains the userq manager.

So that here doesn't make any sense at all.

If there is still an userq alive when the userq manager is destroyed we should probably call BUG(), cause that mean a major reference count issue in a core kernel component.</pre>
    </blockquote>
    <pre>This can be more complex, what if the amdgpu_userq_put in amdgpu_userq_mgr_fini is not the last put of a queue, that means the queue is still alive even when
the userq manager has been destroyed. I will put this patch in my next series where the problem is better demonstrated and more reachable.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 19 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 24adad7be251..434384b53b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -533,6 +533,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	atomic_inc(&amp;uq_mgr-&gt;refs);
+}
+
+static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	if (atomic_dec_and_test(&amp;uq_mgr-&gt;refs))
+		wake_up(&amp;uq_mgr-&gt;refs_wq);
+}
+
 static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -594,6 +605,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	r = amdgpu_userq_destroy(uq_mgr, queue);
 	if (r)
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to destroy usermode queue %d\n&quot;, r);
+
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
@@ -677,6 +690,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue-&gt;xcp_id = (fpriv-&gt;xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv-&gt;xcp_id : 0;
 	queue-&gt;userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&amp;queue-&gt;hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -789,6 +803,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 	return r;
@@ -1277,6 +1292,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&amp;userq_mgr-&gt;userq_mutex);
 	xa_init_flags(&amp;userq_mgr-&gt;userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&amp;userq_mgr-&gt;refs, 0);
+	init_waitqueue_head(&amp;userq_mgr-&gt;refs_wq);
 	userq_mgr-&gt;adev = adev;
 	userq_mgr-&gt;file = file_priv;
 	userq_mgr-&gt;proc_ctx_allocated = false;
@@ -1326,6 +1343,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_put(queue);
 	}
 
+	/*
+	 * userq_mgr is embedded in struct amdgpu_fpriv and get
+	 * freed when kfree(fpriv). This wait_evet() blocks
+	 * amdgpu_userq_mgr_fini() which is drm_release path,
+	 * so keep userq_mgr alive while any queues holding it.
+	 *
+	 * This prevents queue-&gt;userq_mgr use-after-free issues.
+	 */
+	wait_event(userq_mgr-&gt;refs_wq, !atomic_read(&amp;userq_mgr-&gt;refs));
+
 	xa_destroy(&amp;userq_mgr-&gt;userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..7141383ea2ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -24,6 +24,8 @@
 
 #ifndef AMDGPU_USERQ_H_
 #define AMDGPU_USERQ_H_
+#include &lt;linux/wait.h&gt;
+
 #include &quot;amdgpu_eviction_fence.h&quot;
 
 #define AMDGPU_MAX_USERQ_COUNT 512
@@ -126,6 +128,23 @@ struct amdgpu_userq_mgr {
 	 */
 	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
+
+	/**
+	 * @refs:
+	 *
+	 * Each queue increase this counter when join this manager,
+	 * and decreash this counter when leave this manager.
+	 */
+	atomic_t			refs;
+
+	/**
+	 * @refs_wq:
+	 *
+	 * Waited on by amdgpu_userq_mgr_fini() until @refs drops to zero.
+	 * This wait prevents userq-&gt;userq_mgr UAF
+	 */
+	wait_queue_head_t		refs_wq;
+
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------7EXRCXrX0rIHfMnyMzHs70f7--
