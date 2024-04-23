Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281BEC18E72
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 18:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89E911355F;
	Tue, 23 Apr 2024 18:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTE0iI3I";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A6C11355F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 18:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL8Qs2vi+9cG1zwV0dH2UYJibCInksEZYjQ2ogdU0nRr1ktBFb1PJ34c/kXVH1aRkT2t0eIdaV+LP40yuQIuBYzVxjZDKH/ZUsxGyobi4jyrsL/Rq75ovWATpsnXuRGyLiVgjU3pdLWM7IaFxzqGUEYq0EcMzvTI0Jz+Sy/8ELiteObsRS6oL45RdW8EcgxfXO2U7xAvN0OXR3Wc8WKkucyVw2tf4zAZSPMcoqt5bqylmwhu+iyKnvwZuNx1PRIB7u6utfKNwX7RGs9pUqlPwV4CS1+LitGe1O0MmWIVZIr/OLqDmjwFf/D9qmztom+L2hddrA8g9xYxwy8uXtOf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyTlONtv61Gx6DehPq+Tkne6u2XKuKmclaPhd4sBAkc=;
 b=TPK5MA1IjVnNhpOfIQDtTqjMEyL8WQyWjMz21C28W2EHvLN3N8aaAJ2cu9KldHZCbMqjwdgSH9hn8dEQZri5MEabBi7Zc41T/La4Hc7+i5zoP5/ZfLGKbrvzAUDPAJSeUM7FC8nxbYWaL2k5aa9T2K1DBDxhbu0thiRxyBVv0yjvtHj2395Rh+99Z3+ywqPDHlpb0YZQ7VWJSoojPPRZ1uehDxRT7RKsn8dCZZrMdGX01xrNQ/LIW+5o1LCtKlnYgVc2oHMI+A20BJy9y1+Og8BfkwIq2LOE/4qc3KO7X4+E1m4OzJk6d883VcnYSck6rmnuM7QfEMufMdsMA3f6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyTlONtv61Gx6DehPq+Tkne6u2XKuKmclaPhd4sBAkc=;
 b=lTE0iI3IZEAEJsERCn5tbsS2PW1z6NclBhHzCpOvm4Pf5n6+aAOKmvcTxzIrHQUr9d3fSfqjFlX1EUlxbQXoxQY9BjFzHgW5NaKIEsM8QIK+yLR0pCQYgw3UxPUCQw6/gUXrdpBseLSImaHxG31snKHm4YWh8zB+fRwYIC5PeP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:05:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:05:17 +0000
Message-ID: <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
Date: Tue, 23 Apr 2024 14:05:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d797979-3f53-4647-5561-08dc63bfee82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEFEcktNQnE4QTFaUnVlSWRMOUN2SzlaRDA3TUk2UFpQWjlkb001K3JsMG14?=
 =?utf-8?B?RElleXlmSjBZTlRmTHV4eFlpYWdmRjJnN0ltU2JiUXo0K1dtK3NuNkErclVj?=
 =?utf-8?B?djNNNTB4aEYyQnJpY3c2YmlCdG5KRHdRUkc5UnV4UG9UTkZlVDVwRDQ2Ykl0?=
 =?utf-8?B?dUE5RmE3YXRzNWx1eFBNK3k5TEhLMjRqZmJzK0pNMExNWEF2ZG5EM0Q5c3M3?=
 =?utf-8?B?N1JHZ0gwV3VnV2gvUTNFZEswRE1kd1o3Y2JnQkJST2hSbXRtN2h6a3lHTk92?=
 =?utf-8?B?YXg5NCtMdXJ0ZDZGVXJVWU9JQ2lBZ1NFWTJHOG4yZ29YeGdJK3RpVHRyUkFB?=
 =?utf-8?B?c2ZZYW4zZXk1V0ZGRWNJWmc5dmFqeWV1WUU1aGQ5WkNjVU1HMG1xdytZV01E?=
 =?utf-8?B?eXlQMzIwY3paK05SN3FXdm4vS2doay9lYnRJbzg5OVllMmg2cTVBSkZCQzFh?=
 =?utf-8?B?UHVKODdNOFlRdU9aczFPSEprcjhBQnF4VHBHNEh1eTJjRkNLYnd2bjBPUDhv?=
 =?utf-8?B?bStDU2N5OENyZGFSSVBvNC9rOTdqU29sYTNkbjQ1bXhmVjNFWnMwUmkxek4r?=
 =?utf-8?B?ZTVjenZvamlwQ0tnSlhYeXgvUW9vVS9oVVl6Z3owMHNBeStlMXdneE9Wem5r?=
 =?utf-8?B?M1JIRjRnQVQ3VFdLakpuZkN2VnF5WWhCcHBVRkNkMitWZS9hSk9UL3Bqc3I4?=
 =?utf-8?B?ckdIUGYzajNvZlkrdy9CYlZnVUxVRUZZS3VYNlNOOVordlJGMEQ0Ymk3bU9o?=
 =?utf-8?B?S3dLWWZ5VFhFNnhvMFJoNjBNbTc1NDFObzdvMFVKSXlJSjVocG5YZHhRSEtS?=
 =?utf-8?B?R0VXa3NLQkxkTW5XUlkzbHNaSXRtcnJaV01VZW5IVXhHRUFleVpoR2hPMWhz?=
 =?utf-8?B?OXE1Yk5iTGs2ZUUwS3FldHpYZ3ZOaTI3azNKME1USTBhQURrU1hRY21wOHdu?=
 =?utf-8?B?VTlRTEYzWXN5VUZyVlpybWlNUmh3ZkJ2ZmRHNDdNbUdIY1BHZk5TeFFwbWVD?=
 =?utf-8?B?ZHQ4TGZSZmhRYjNHL0ZId05WeVpaRUZQMFZ6NUFwY3kyWnV3em1YOHBxdkQ1?=
 =?utf-8?B?bTM4Rkh5ZytqQnJuUFd1bldSMlhWSnhUWnVCbUwrQWRsU0ticUxIOEM5K3c5?=
 =?utf-8?B?aUFsSWRZSjFZRWJrZTg4Q3lnZ1JFOFhnakJ0RFowcEdpTDAxRVp3K2xiVFFW?=
 =?utf-8?B?OUxVSVlmNXl0YzhrVlNhU3M2ZXRpQ2g3bmFiU3hsSG1Xb0R3dFVPY3NiL2VS?=
 =?utf-8?B?enl1Y3FCKzN2aWJpOE5UZEpiMzd5NndaTmpiN3NSM3RrYTVtWElvMU5wcDVj?=
 =?utf-8?B?MjBIcmFTZU81aDltOXlMRGdRdzc0OWt3SFdRUW53T2E1emNRUHZQOWEvazlP?=
 =?utf-8?B?V3pTVExEVUZjSTZkV2pZWVpJL2k4UlFDcnRTV0tXaVRFb3NwWm5iR0p6bVI4?=
 =?utf-8?B?OVBGTmZYRDdTbXR6TGp6bnplRlRxUUdqZFNHYjJpWWEwT24xMnJCK1RNZ1A1?=
 =?utf-8?B?S2RMS3diM3k0Qk5KL1I2cVVIbDBZNzZmcU9ENTdPdzM2REY0QWtoa0FVdkU3?=
 =?utf-8?B?cjdiUUoybXN2Q1Jwb0ZRekJoaGRtREdqdGdMTndKWXNDTWRlWXdvYVV6SlBp?=
 =?utf-8?B?VGkyOVV1b2wxNExpNVFLMGhXWk1CUkFXekVFNmMwZ1o2blpvdzQ5V25pRkJi?=
 =?utf-8?B?emhsR2ZhR0JvQk1lOVdETGM4VjhKenU1K05TMFh2azJPVVF6ODVLWWN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZtcGhDa2lvV3ozazBSYTNtdFU4ZmNsTnZmUUN2ZlBwa3M2VEpxYVRuZkph?=
 =?utf-8?B?S3kvcDV2UHd0bkdscEVGTktqeXRmSUdLTVMzSElCdzNZbnVKejlMMHpJWG9y?=
 =?utf-8?B?RzVBL1FLU2hjMklRSWpMcXU1em5RWHFYTVJ2eDZzcTlRV3ljaWJpRnliSWtz?=
 =?utf-8?B?WEMzektmN0NjUHNHVUZFbFRiU3JIYTRVZDdPR1orczU0YXdpYWFwcGJWSkJD?=
 =?utf-8?B?ZWNUUnNJQ0haY21BekMwdFpRYUtoc2JVd3VPbDlua1hFSHozUndZL2UzY3ZK?=
 =?utf-8?B?S0d3OXFnQWd0SSswVFd4b2kzeUtldW9MSTcvMGdHMm92NWdtdWlRT0lERW9I?=
 =?utf-8?B?cko5OElYM3NDNUpiOHJ5OEx0NUN1VmFzbmMvdmR6bU4xNVZtV3JidklGc3RK?=
 =?utf-8?B?TlJXUktONVJOTE1BMk0reXVMa2Jkc1lYSGxpL3FLSi9PeldmbjdSMTQxRkVL?=
 =?utf-8?B?aWhMelRRRVdrUjdDRkFIcDJxcUFKSkpJbiswR0djWDF2U1l5Z0grcC82WmRr?=
 =?utf-8?B?NHNnbXVxaG5GNGdpWlJtY3ZpdEZMWFlZdWlST1ZkSHErNERwMXBxdnk3KzI3?=
 =?utf-8?B?TUJDUU9CWlpvZUpWMUxGcEdrNFErRUY4Zll5YVlHLzdXelpmOVBiTi9kblJX?=
 =?utf-8?B?anlkZU9BLzBxUDVteURXOEpHaE01bFY3SXlzendobXF5alRielBXcTRLOUhN?=
 =?utf-8?B?NXpDRkdDZEgzbi9KajlxK0dxemxtQ2ljbHBvTVduQkZmdEY1dkhqa1Fva3dv?=
 =?utf-8?B?QzVIWkVQRjA5V0t5MDRoSS95cFNZa1lTbk1tYXc1THJXbk13QW9uNzRSeDlv?=
 =?utf-8?B?M1VHUDZuOWc5SkpHOUhqeUI3cDNrSklPSE5ZOEV0NVpKekNLTktHUzBFWG9l?=
 =?utf-8?B?UWVLbnArTVNnSmwyQ3dTMFpEaFArUllvc01OMzAxSFJMMC84czFrNFVQUi9J?=
 =?utf-8?B?M3ozYVVZb1JyWThlTWV5Mys3WDdlekJtb1JFeFkzd1l1dHlPbzVFdmlueXV4?=
 =?utf-8?B?R3JXMXFVVllDTitpbCsydVBzSnJ2ZkhsdWxDNU8vWkYvWHFkUDNaMk44MVJh?=
 =?utf-8?B?VElvblZ0YklEaHRtaWh3RU1rTjNTT21uMXhBZWovYVFQZkIvdXQzN25tZWJy?=
 =?utf-8?B?OTJzditUbldOYStZeVJkTmxoWWQ5UGRoOXVTSTA2UENyb3RERnEyaXFUNkNi?=
 =?utf-8?B?MkZUWkI3RHZWNUVFZURTYThwWFlxNUFDcll4bEdkOUZ2V0VVWVI2Z3RJV0I1?=
 =?utf-8?B?QUs1UnZDNlJPVG9LN085Tkw1ckExVHkyL2JoZ3hkUHlqRm0vTzN2S0NBUEIv?=
 =?utf-8?B?ZjI1bHlaSlYyZExscTZEY3dzcFRlU3lNMlNjY080ZGZQc2l6eGc5Y1lBNWRy?=
 =?utf-8?B?WFh0NFBDNUcyYUlWQWpBZS9ERi9GUEROekhub1VVZGxIYmhlYWQ1K2Y4T1RK?=
 =?utf-8?B?eXVDV2Yzb2J0d1AyWTNPVkJ6bEI3aFJnUHVnN2xkREZhQXZTeTRvVkFrUTRm?=
 =?utf-8?B?V3NWREJ5Q1RtaUJJd1RuUjZEWGh0eUxldEZLWDZmbkJlZVhBNTNGTE9BNlY5?=
 =?utf-8?B?U1M0WVhaRWNKYmhkMGQ5d2hLaU5EazhvckxMRW9LVkgyUlBpTHV4c3Uzb3Vu?=
 =?utf-8?B?bElCMXJDQStXeDBQSUswdDdvTGRtbkxYMDh2RUZENVFkTHdjbTFxNkhiQ0xl?=
 =?utf-8?B?eU4rOVV2RmUvNmc5VnVDMFVLY3hzUnptL0o0c3pKL0Rlbnc0UmNoVVd1OHdz?=
 =?utf-8?B?YWxXVnROSEJRV3JkQ25LbTZRSlBoWEJ6WGZhSm5QcmZSdFp2UmI1QTA1Y2Jw?=
 =?utf-8?B?M3hFVHFTZlZ0Mk1uYStNVEJVd3hwTUQrK1RGckxZTDRJTmNpS2tlaEtJejhD?=
 =?utf-8?B?YUppUjcraXZhc1FiTlZTK0ViT2pDbGJkazNMWUZrbVV4OVJPMHAvWXJ2Uk5H?=
 =?utf-8?B?UmxBNm9SZGVuOUJTWENEWVdDNXNMNUJzd25OczYxRjBBNzNLSU1sK3pGeVY5?=
 =?utf-8?B?NGZHZlE4dGNrL2Z4eFNGWXZqbzZ6ZnZ3ZEZCRkNncHR4dWNZMmFWZXVGVk9p?=
 =?utf-8?B?bUJIU3ljWTZtM1plK2Q1aml1OWFtdU9qcTVVTlpyeFNZR0tYb0pmNFNSMkcv?=
 =?utf-8?Q?aOaS72+hIvs2LglFtH3kv3i/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d797979-3f53-4647-5561-08dc63bfee82
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:05:17.2295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRotumy4p7IJy8k8r7HqL4MaXPV5ry3pTGUfPZXVtS0yyABx7Cw6nttPBakoMNfqlLfgIPIuG1tJsadA4l6ZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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


On 2024-04-23 01:50, Christian König wrote:
> Am 22.04.24 um 21:45 schrieb Yunxiang Li:
>> Reset request from KFD is missing a check for if a reset is already in
>> progress, this causes a second reset to be triggered right after the
>> previous one finishes. Add the check to align with the other reset 
>> sources.
>
> NAK, that isn't how this should be handled.
>
> Instead all reset source which are handled by a previous reset should 
> be canceled.
>
> In other words there should be a cancel_work(&adev->kfd.reset_work); 
> somewhere in the KFD code. When this doesn't work correctly then that 
> is somehow missing.
>
> If you see the use of amdgpu_in_reset() outside of the low level 
> functions than that is clearly a bug.
Do we need to do that for all reset workers in the driver separately? I 
don't see where this is done for other reset workers.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3b4591f554f1..ce3dbb1cc2da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device 
>> *adev)
>>     void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>   {
>> -    if (amdgpu_device_should_recover_gpu(adev))
>> +    if (amdgpu_device_should_recover_gpu(adev) && 
>> !amdgpu_in_reset(adev))
>>           amdgpu_reset_domain_schedule(adev->reset_domain,
>>                            &adev->kfd.reset_work);
>>   }
>
