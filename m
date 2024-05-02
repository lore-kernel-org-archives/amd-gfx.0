Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9575C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 03:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C6910E8A4;
	Thu,  2 May 2024 03:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPMQX5aO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B15610E86F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 03:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFwd+SgOLiAqOa3a6GpGu4SXOoSiliTHeTIYJS2gyFDFrDmc1lzo/NnT2HpbwsEhIkmNYg62yhKcQOtoY1se1YefQ5kn92/+ehtpKKi/EfCQI+//haR2OOV0M1XoXq39mPWSrrSY48Zd5JFgG9eWTZ/JOGp6+7XLFW1dsiTXs91nwoBZbXjldvhhbcdkx4asm228b60N7VXz18pITJ+h9cgR/CDV8Xl5omQRM0FArZiBdXMnCAqdkPelUh75o+D5dEH8JTlWUPg/dKOonr8xoGdXcbNpgkQ34NnFATDUVA0Mp2E5IDs0Sul320qF0oRdvNoHbqkrqp7uMpKEzAZq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DqR/e1E6XS/IEQf4oGLK8eLMjbk2Qlvk53RCVPcWx8=;
 b=QFqeC4V8UrrhbIgMco7RayqWOXsyXrj5yhFJgDn3ojv3koFX0NkyIUnezH2hcA1OhN+3vxAE5cbY5bxa9L1XY43r9jwxzQgVainyYAlErT7yKm3VGOWXtIm92Oq6xobrvpXCs2Q9Yt80K6BlCypnNxlUi0Aoj7LS6xBSRIlAalqQlA5KSpVJIT2up/+wv90ePHX3UC+FM/3fNcB66KYojvrLYWYqzoDGsPZnF/not2uMSVMFqNDzoPi3LggFo1v1bGRfilCF151sTH2gAHSZWMrEWSj/AngolLyM0pXr60zP8mUS5t0+mbjkcJ7o17Q+8mYUGjvRoOSm9tcLJjwXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DqR/e1E6XS/IEQf4oGLK8eLMjbk2Qlvk53RCVPcWx8=;
 b=TPMQX5aO486mebNvsxSqMmnx9EICN70Fr974UQuy+y5KIsanz531rzXQIwhrSC2/pticdfYtx3AetE4BpGutk1fA5PsFz8eBSWOttKjkBW6xr5lkbCcc6nJuQeEtjyN34SN0cI1trgMXkyQg8GXm6PBFOcJDmGX9W1bmxQXFVV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 03:47:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 03:47:08 +0000
Message-ID: <a901cf92-76b4-4b84-9f5c-e4c0fdcf5981@amd.com>
Date: Wed, 1 May 2024 23:47:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Improve chances of unique gpu_id
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
 <20240502010804.125461-2-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240502010804.125461-2-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8fca0c-2dfa-47d2-f641-08dc6a5a8a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVQ5bDNpdS8zcnlwb3ZzVDNUTkxZbVorbWFsY2FIc3pDMGhYOVNhUUxUZWNv?=
 =?utf-8?B?OG9xeXhtVEwzbUZlVzUvSlZsSXoyNjdVeEo5Qy9VemIyS0FPQUpNUVU2aWd0?=
 =?utf-8?B?dXUrN0VaTEdBdTZqM2tDUXc5Z05KeEViMTdkN2Q3TTVac0ljT1U0YjRNQWxT?=
 =?utf-8?B?c1UvS2FaOGpiOW5SUXRsRTYwMldqRjk0MldkWHp6aGd6YmNGVTVDZmNFamJ1?=
 =?utf-8?B?QVhjOG1aV3pqbVVTYUdvTE9uRWQxS3o2eUczQlU1azI2Z1l4TE1GZzhaNmFn?=
 =?utf-8?B?c2Z4TjBrM3Rwa253c0kya1BOMGE5MHlUeUFCWDVjRHNmaWlmK2czZ0h1dWZG?=
 =?utf-8?B?dExoS25rWHJBdDcwRWY2SjlOREczS0d5NmF3NFNXNjJONjZZT2pPam5qSzlh?=
 =?utf-8?B?S0hlcEhlQWVyL1dYR1Bzclc4TEpzQ2dhZW5PNmtKTGJXV1FBR2RpM2tHMUxY?=
 =?utf-8?B?MkxXd3B4WDM3bEgrUkJCdTEvd0hGWURXeVNzRUdya2hQV0VtRWtVdHdFamJC?=
 =?utf-8?B?clJqTE8zUjBYaXFBNkZtLzRWbDNvb0JEZDMrU3pPVW1ydnNuSTZSLzE3Ykxr?=
 =?utf-8?B?OUJMZm1pMW1BeUdPdEg2UkNweG1sZUxnbWNPTFIwYnlBUVdLbXA1QWpxVEZ3?=
 =?utf-8?B?ZW9DNHNJTnFUZG1rMGd1T2R1WVp0RkZ6ZFFKM3dvOXFTcEJwZlI2aUNHeTZH?=
 =?utf-8?B?SFF4Y0wwb2ZxTy90UUF2ZVJudkhKTWR3TFhMUWFrdHpiSFNaOXRQaEd5OGpq?=
 =?utf-8?B?MjZJMS9pZVlha0lDR04zS1BITVNITXBnbEY5WE9VNHZzOFJxc3dIWlZWTUtW?=
 =?utf-8?B?VlBCRHpCUVF1L1Nia2lIMG8rSlhLYjhDSnVMVG5zN1pzT3J1eEtVek5LajlY?=
 =?utf-8?B?aHRoRWtHQll2c3VyVFBROHRpa3ZLeTN2WER5Q1pqKzdmVlZWN1JTY0kyRk5R?=
 =?utf-8?B?Skk5UU8wZDhZY09vNHVjY0ExQWJOR2hWMWFmaUxDRGNUOFlYZkZCc0hteDhX?=
 =?utf-8?B?Vi9JblFsWElvN3pWSkQwejR4Nm0xa2hodDNxTVlkZUlOblFVSFF1bU5nWGU5?=
 =?utf-8?B?MFJJa3Y4RGR4TlJoY3NSWWd4YVZyWkh3VEZ3RS90OGNjMnAza0MxOEV6NUM4?=
 =?utf-8?B?N08yNUxGYWowelpnTlNzLzVES0kyb2ZxbGlZT1ZMa0Zjd2VLRFVOVkQrbUpV?=
 =?utf-8?B?MzVnZkx0SkhGZWFFMHVrRk8rd0VQdWFXV1Y5elU3cTU1dzFvdTFLa09sZ25u?=
 =?utf-8?B?Q0xQZ2d5dE81U05LdzdnZ050cmM1eTdhWkRQbEg5Y2RjMHRjNTIvcEdHai9q?=
 =?utf-8?B?ZUM4U0NQekZ4cUNyeS9rZ1JHOFpYUHNoVzhoMlZ0RURQS3AvaU9QNzRvUUZv?=
 =?utf-8?B?YWhzQUttakliV2wyTmdIa1RxTTY4MnNqSm1tcVR2VzgzUVVoYnZ2TCtraWdo?=
 =?utf-8?B?RFd4M2hkSmxUYmtkMWxxL2VzSkxtVU1SUjRpL2U3Sm90RDRFNHQyQzZLSXlo?=
 =?utf-8?B?OHZLSmdnbDJZL0FZbU41dVIzdTJwRnR2dkd0UmtxaHpVR1RMMno4K2QvVmht?=
 =?utf-8?B?NmpSK3lXUFUveVEzZk52aEYyMEZYdXhsZWJoaXFVRTYrSGcvMkFjNm5WVHJF?=
 =?utf-8?B?ZnY0UktRbjk2ejJCYmU3a2lqRmwvRllBVHFEYzZYM1NpMDZmLzIrN01yRHZX?=
 =?utf-8?B?cWk4VFN3TjBJVWdHZzR4VjNPQUUwU09tcVRsRU9td0NsRU1jdzQzZ0JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2o5dTBqME9OTWFibDdoYityRFE5bGkraWgzZm9Pc0dBNUwxNm92Z0xneG9t?=
 =?utf-8?B?bTg1RnQ5SXRUcUYrZlk0RndQQm5wU0hxTldkbno4RGt4VzUwQ2VLMmpPWDFu?=
 =?utf-8?B?NmQyOXIrWlBzcmIrajVYYUV6L2ZjM0dXV3RSaTJXRm94VS9NaFpYZVRUOFNX?=
 =?utf-8?B?Vi9peHpXbkpFU2hlUWpxYXU3YnhqdUx4RDVTb3YwaWdZVTM1Uk5aL09pNUtk?=
 =?utf-8?B?L3JrKzdNTG52bDlpRWlQOTEyOWpTZVhoTllyR2kxZURqZXoyK1FiTzMwODF0?=
 =?utf-8?B?ekgxak5oZEpQU2RxSUF3b2Z5azBRbTA5R0NIcndTQWU2RXRRVTd1aXdNUDVQ?=
 =?utf-8?B?UmwvVXNWcGtkTkl2U0kxYUUxYUhSL3A0UjFNZjZmajBCZnNOK0U4Nm50Q1I3?=
 =?utf-8?B?K3BibmhFWmVlQWpXcEtIa0dCUGtjM0FtVS90R3NvaGMrNCs0bEdyeE53UjlQ?=
 =?utf-8?B?QlBDMTlCN1FZYUFMKzBMaXA5OHRXSHJtWkV0YkRzMVQwRkN3djk2TW81TGNW?=
 =?utf-8?B?WmlSVG05UUpKb3hYK3pLa2c3YkRrWTBvUGZqcmc4R0RkbkNZZHhQSHNaV25M?=
 =?utf-8?B?ZU5VdVlId1VnaU5IN2tNYi9EU1FKdTJHU2I4UjNtcVpEY010TlJPMmpoOU1E?=
 =?utf-8?B?NVd5RVl6YU8wTGtGZVJZS0pyRVdGVkZYc25qdVowa1QrYzFUczZBc3lCbDdl?=
 =?utf-8?B?U0J0TW5ocURBNnZTK0xaUGg4eFlyVlVWc0tERkdEU1ZiRUN6d1hOZ0dQdHQv?=
 =?utf-8?B?VVJVbFlHVnV6djM0cDczWHdrQUpSeHZNQ2szeGFiem1zcUdPWVgwcTVDTG90?=
 =?utf-8?B?ZUhMcUYzOGY4ZzJlSWhjLzZlMGxpa1p1d2ZkTGxaS05OWFRySmtsRzFJNGVL?=
 =?utf-8?B?Ly80ODYzdW43bnpBNk9GcWpRcFFFU1BqRnpPUjMwN0kycTFuOVB0SDhoMGtv?=
 =?utf-8?B?dks3VUduaThVY292VFpEZUtrenNuaktUd1Zla3lQaHdqRm84UzM3eGgyV1d1?=
 =?utf-8?B?dGtBQXBGSjA0TjZST2FpS0MramVOWXRFVlFuUXZRK2ErYjdKS3F6VDRPbWJ0?=
 =?utf-8?B?M2loSU9lTDl3ZlRpZ1VUYU9wZzhNUjFvYTV0TXFlSUFDNFpYQ2lYc1BjOTlx?=
 =?utf-8?B?bWJ4aHBkVlU4b2VISVE2dnAyRVlkektDSjBzcjUvUGxOanBOTGo1b2RVZWFY?=
 =?utf-8?B?RDZoWUp0emxJY3RjMGlWYjdhWXEvcXFYT1dKTTN5WS8zbVdsRTFJNjhqa1hi?=
 =?utf-8?B?V3UyRWMyOVlvQW5MMEpZRTh4RFBoQkpFOTdPRCszTzUrNUhteTI3MEJZN2lm?=
 =?utf-8?B?YWZ4cTlrNm5SVUlTbDJSUmdWL21KS3lNbkJDcHh1anRMeEpXZlJjZkhyTmlB?=
 =?utf-8?B?MWtFdHRKL3loY2I5bHdLNmNLNmExcDcrQjdCREp0aExCOUV3anhFY1lzOExu?=
 =?utf-8?B?blNlYWVyUUNmVXJuaStEVXFWL2ZDQWU5cXVaSEo5T1pKS3NvdVl3R1JoaFVa?=
 =?utf-8?B?S25VMTBBNUdrY0JTSG9Cc1lZbnZLSVBzU1A2eGwveEFjQnpNRmFFQ3AxYm5i?=
 =?utf-8?B?YnFzTDJYRkxIVThaZloyRDlxTWJtSFlGM2crZXJMY3BZTkNBNmlVSEU1NVVn?=
 =?utf-8?B?Q0QvY0JkUWUrOXIwSk9PWnJtN1pSNzUyYktrTi9SNDRDTEYzMVVJUUp5ZWxJ?=
 =?utf-8?B?R1dTckVqUlJaMUFHVW1kR1YwN1E1TDJScms4TzJ2cHZDZVhSZlBST2JncWgw?=
 =?utf-8?B?UWdRSFUrUlhrOWJkT0VKV05VUTdJckFDOGJMWCs1M2VvcEpoT0Z2MFZ4L3h0?=
 =?utf-8?B?OTc5ME5yendybnVXV0YvZWlGN0toc1QyTGpPdFFhcm9sS3N0MStXL01GaE9V?=
 =?utf-8?B?YjdNSXNTVklUM3dRQXYxSXIzTWQyZW4xM2tGWEx0QjYyUHpKWXJNYjA4ZjA0?=
 =?utf-8?B?NVNtY1FDTVlmc0F1Q2xWZGFqbUpvVTk3QWgyRWEvd0pxMG53aEtuREdlUmlm?=
 =?utf-8?B?WnJXdWtuTEhRM0dxSUNxcnVZQnliUWZJSjM3V1VSaXlkYmlhRk5BMVFVbzlK?=
 =?utf-8?B?YXBsYUxxamtKbkZFWm9yTmpjZEZoTmpOTlVDc2tjNXpCaW94cjNzMVAzV0Rl?=
 =?utf-8?Q?UqEbFUF26TljpFduaBjsjJaQb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8fca0c-2dfa-47d2-f641-08dc6a5a8a76
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 03:47:08.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n7sK4ZTpgM1c0HJOxG/XqJ6Wh/QwvaS4K5vUbIY1BO/CteUy8CJiECBTc4A5xoNOedUUHXUU+2uocw8pnbDdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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



On 2024-05-01 21:08, Harish Kasiviswanathan wrote:
> gpu_id needs to be unique for user space to identify GPUs via KFD
> interface. Do a single pass search to detect collision. If
> detected, increment gpu_id by one.
> 
> Probability of collisons are very rare. Hence, no more complexity is
> added to ensure uniqueness.> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b93913934b03..f2d1e82e7bed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  	uint32_t hashout;
>  	uint32_t buf[8];
>  	uint64_t local_mem_size;
> +	struct kfd_topology_device *dev;
> +	bool is_unique = true;
>  	int i;
>  
>  	if (!gpu)
> @@ -1115,7 +1117,13 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  	for (i = 0, hashout = 0; i < 8; i++)
>  		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
>  
> -	return hashout;
> +	down_read(&topology_lock);
> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev->gpu && dev->gpu_id == hashout)
> +			is_unique = false;

You can break early here.

> +	}
> +	up_read(&topology_lock);
> +	return is_unique ? hashout : ++hashout;

We should make sure that hashout stays within the KFD_GPU_ID_HASH_WIDTH. And if we're already adding a collision check, we may as well make it air-tight. It should be easy enough by wrapping it in a do-while loop. While we're at it, can we also check that the hash is not 0, because that value is used for non-GPU nodes? I think this would satisfy all my requests:

	do {
		if (!hashout)
			hashout++;
		is_unique = true;
		list_for_each_entry(dev, &topology_device_list, list) {
			if (dev->gpu && dev->gpu_id == hashout) {
				is_unique = false;
				hashout = (hashout + 1) &
					  ((1U << KFD_GPU_ID_HASH_WIDTH) - 1);
				break;
			}
		}
	} while (!is_unique);

Regards,
  Felix


>  }
>  /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
>   *		the GPU device is not already present in the topology device
> @@ -1946,7 +1954,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>  	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>  
> -	gpu_id = kfd_generate_gpu_id(gpu);
>  	if (gpu->xcp && !gpu->xcp->ddev) {
>  		dev_warn(gpu->adev->dev,
>  			 "Won't add GPU to topology since it has no drm node assigned.");
> @@ -1969,6 +1976,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	if (res)
>  		return res;
>  
> +	gpu_id = kfd_generate_gpu_id(gpu);
>  	dev->gpu_id = gpu_id;
>  	gpu->id = gpu_id;
>  
