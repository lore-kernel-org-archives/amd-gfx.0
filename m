Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF47C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9D810EB7E;
	Wed, 11 May 2022 07:21:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF3510EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilRgAHiMQM8yGBDIJqGmka+KpyUe7SfEOhgpJCIVr2oylKmINXX4P5OFEkJnQJuda5oGv2a1U8FPM6OTCu42ptZUjn/CpQxmxb56sC9LkxN5bN9VK8BiwOC/8Sd5U41gjqtzWvUTuIhBrNODHnGmVr2eaZYmAoCl2/KDkDDRESYMh75RWZximqNpOjBTvxW5rx1sjDX+7Xu1F3VD/+bHdtKvNSglCzMKSlxkCmT1PCUy9yaH212k9ASbPpWUrZaIA7eFTuRJRbG7MxPY4ytAJnXE7/hzOO3qqAFdjEkVdhJvunOGgvYdtiTYzXxLcl7DedomUYw6FRWw35r3N8jBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr8+hTmA5zNUamiw1cCmOW7W5ehqX0n4xmj5Wy5z60I=;
 b=h0bhZ4yGbr4XsjEFOxU0qIiNyuetSGx3+zgLHvoSUEZ0Ges/vmXQ3Pd9kQ+uMCE+92OTRS6DuPukhaKTnwyOiWv14jr5PdAzB0uyorfUnZCY1SeLUSq2aiRmC2LjSuEKVKqTutEtY/F3vyjB82hbB2MT1qmpMFlU6qKeBKgtB7Yhe9Uuc6LMzwjcuF7/CelM3EjSSmONc4qB8Zp1cFalWpLBsJnCEslmkFedaohRZIKdYPhjntSQ/yEFUBROUTd77G8nCf/Kk+fbKFGjp7QrlWn48RMb+j5Wjk3eklXimWM4MpBxbbGK4g8VPrG4RKKh4syTAHwEKEfHLGphxaN0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr8+hTmA5zNUamiw1cCmOW7W5ehqX0n4xmj5Wy5z60I=;
 b=NurfNf/pP4AAEhgQHX6/dO58yAC9b2A2fsHmRIQu1wkXwSuORPf2XrRGpMg3Ta+COYSoK5P4Qc/paVP8xVm63rPFBbQtd2++R493Y2i3YcM9ThM4BjZHRbwFM+GsglYKuSSZZyCeB6AgBfh0SgWl6947rvQU7RXOhBBHgXWcuI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:21:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:21:12 +0000
Message-ID: <cf4246db-2114-0da0-7467-5f42c3bafd1d@amd.com>
Date: Wed, 11 May 2022 09:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: switch DM to atomic fence helpers v2
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20220509074712.163899-1-christian.koenig@amd.com>
 <c4109fa8-18df-866b-948c-d598c5fea905@amd.com>
In-Reply-To: <c4109fa8-18df-866b-948c-d598c5fea905@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0203.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4e1e42-edd8-4107-caf0-08da331ed3cc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3766:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3766F755E0D64949FDB5F65783C89@CH2PR12MB3766.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tty8ivjD04lzQvuGCC6PMZdTFhQggr82CzJ1EmjkJ/22cMz5RlNEtcjPkQNsInp5vQrTf873VNaN64/QrT2zlqPWYT7i2WXO9thYBGQHmHV4iOUghIDxZa+ImiSdCBWwx1O2GaSzR/YW5eqAzy4z7Pcn9y9t0bOq00Ga5T/4V5sxdOMbV37EOqPWJJGLebFiduVO9rTnEfI8qiWHL6RVi9XsOUamYuFXP3mZbxRzPzuoHSS69/0ZsNIcAGBX6z1IFHMdENGKmdIatWcqpDNW0VNdqYiKTb3PbkQVCC/kFCnCdedlhwIAJMPNIEc1WF/cj3I1x5IpZlsRLB2dKFA69Dqt0a+s0s1SO0YbyRRlEBmka2faGodPiOgo3PXl0GJbDU0iWyCl4BMBlpg9CearmrEFwijC1GXhIH4IWKCmjyhw9LCykrnnTbH2aZ0akMN2awIbX+FLM0Ei8QQjcrMClKxD6U2EWEyw1XqLmfSSCRXF4ScUN2yI029NzbdWWNGHjpw/53tzFOdFcTDVq6H5v25RPfZiku21liLjCGkPnb5dichF1Y/kjlRAtKNCjmXQNFMwCJfoM6QQIOVxBA/Ct+7WnloiUqoOJ+wQ7kKbsmx1RXDOTFKWOm2oJYoAEWcdZaMniJplqkePzMWTD9qhfNLjv46QuHVjMjnadrb5uL1Ceyzu668Jx3c+d7Bhi/cvKHqy2lqAuRZ8W7DcpxCRl9Ab4GA8RrEkkXtFippJ6QICLQ6APqw741vxUZ3N8raD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(31696002)(83380400001)(31686004)(6636002)(186003)(66574015)(8676002)(4326008)(66556008)(66946007)(66476007)(2616005)(6512007)(36756003)(2906002)(26005)(38100700002)(8936002)(6486002)(5660300002)(86362001)(110136005)(54906003)(6506007)(6666004)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZnZjQ2VEMyYUh6UFgvNFJLZXZUTFZja0dYNTlpS3U5NXdMMTk0ZExuWE90?=
 =?utf-8?B?a1ZNMGhwYXZSYjB6aVAzTFFjVkVYclVhTUR2MnI4RzZHcm5JdFhSM3RRWnFZ?=
 =?utf-8?B?MkZvd0FVall0R3pzcnBFTmVtRC9ibzByRGdQT0FiSjZoVEZNVEM4MXh4ZlN4?=
 =?utf-8?B?VDVESW4vQTRLTCtHWVlrb3dDbTNNZVRYR2VNTEJxOXEzUnVpdjRPRTRwd2xl?=
 =?utf-8?B?aHg5eHFXN1JReE5DcnFDRG1FV3NPT0FEdEFaMDBPcFVPOE5YRmI3SzNyZWgv?=
 =?utf-8?B?S05nTThLemlINUxRVFRmS2xkMXl2WUxFVXVRbVNFcHlQNXJPekZ1dkN5RFQw?=
 =?utf-8?B?S2dVd0drVHdwdkd1U253V2RrMW5mUW4rbXlmaUpPdE9GSGNIdFFLcFp0YWVY?=
 =?utf-8?B?eGp4Q0ppV3NvaFlOUnVIVGgzelJqV0JTVTNiNnVqakU2K3B5Z20zbjNDdkFv?=
 =?utf-8?B?b21GUDlzNHZjWEJyWGF4Yk5SZmJQM2h5SmMzY2lWalRVTTduNEZTUHQrWnF4?=
 =?utf-8?B?YUhXUkgvQ1V0Rkk5Q00xKzc1MSszSUhvTTJUTzA0OUVnN1RQVzdqZ1JLRzJU?=
 =?utf-8?B?WFZGc1FrY0srVUxYUTROMTlseWJ0V0hvanA0VCtMcFE3QytjaFFBWm5HMk40?=
 =?utf-8?B?T2lKZzJwYTYya0V2cUlRL09RNTIzWWZGTHkrMzhEazR5eHZ1b09GS3R4Qkto?=
 =?utf-8?B?eTg2Y0pTYVV3ZGFRVDIrNk4rNktjYlJNN0ZVNU94SVkzNUs3dTBCWW5DdXFJ?=
 =?utf-8?B?S0RMc1pmTmhCSGxxZ2tob1lnMlNVNCtrV0E4b3p3bDFrUmM3OWM4b1NrbVMw?=
 =?utf-8?B?ZWtkVHVRdjc2LzBhb3poeXFEZWRtTVRxMG1zc3JJbkM5bHV6ellnVnN5ZGFE?=
 =?utf-8?B?RC9Da2ZheXRvTDlETEZ6aTJTR1F0R3ZqSEpJRTV4SmZ0S0I5aG0yQ1dIUzdX?=
 =?utf-8?B?cERxNWluUko5VEhBaUxUR05HcW9CU2h4bTZvUXVuRXkybmJ0Ni9VZ2FYRWw1?=
 =?utf-8?B?Nm1ydlRjVHNzd2xINnNLYzFGazBaNUJTWVBUYjNydjJTckFETVJYZWFxME9w?=
 =?utf-8?B?ZlltbVhkN0N3b2szeG9EcjNLZTg1RTIvU1ZvQVVNaG54MVg2OHRiOXRpSmFz?=
 =?utf-8?B?ejdHOTVuRVMvRnZ4Y1pLRGIxOStIYlJmcFBvRDBPSkcyYzBBUXh1dVB1WitV?=
 =?utf-8?B?SzVOZ085YXRuSlFYVWtROW9JUXpzWTBQTC9vVWM1R0tnbHN2R0o5NlJueWRz?=
 =?utf-8?B?L21LQVF3a1F1dm1zanZ0U3NiVitnbzBCQzUyU2RJQ0NjWEtwWnQ2S2RuUWJ6?=
 =?utf-8?B?a2JuN2p3eFo4ZmJyeHM3UGZkVjc2cnY3RmZlOTlqWTZyQnlRTVZITEdNRlJF?=
 =?utf-8?B?VlQxQmdDOGhXeUJsdDFsVmdGMnVDamlrR1dQVGdWTVNhNzVsMVdOakNSRkls?=
 =?utf-8?B?WXVnNEIvTkFZdEFEeEVFTkNCVlRpU1Y4Qm5weTFGa0Jjc3ZyOUU0YVpmRi85?=
 =?utf-8?B?aHJlMzA4aHZpeVN2dy9QTTlCN2dZTzRQTXJ2Ynl2UGlxd2pBSHR5ZkdxUXI0?=
 =?utf-8?B?MEpJMUFzckJ4OW13SDRwdUtjZVI1S2tQMTcwOWdZQ0x0c3FoMEQ3YldDb09Y?=
 =?utf-8?B?VE9MN0U0RCtTTUhJYlFmVDhLT1BETm02Y3J1cEFZRkxMV2ZiY0lOVEU5dklD?=
 =?utf-8?B?aE8rNUc0dnBtV1pRazMrQ2wzRitEMmNZZER1dmhVSHlKQzMrWWw4ZFhKMENM?=
 =?utf-8?B?MXF2dXVvQ0Vtem1lTzBqRFRPNzlBYzRrRHZaRStwanc2SzFTT0U2NzdrWG53?=
 =?utf-8?B?dnZHTnR3TUt3RVJxZjZxQmxINndGMUhUWnppaGYvTE9HRERTcWp0S0dpb2xO?=
 =?utf-8?B?S2NoNXZQd201VVFDcTZqNlFkMHVCSkk1OGNsaUgyenlKRjRicFhsenptN25X?=
 =?utf-8?B?REpwdVM0T1NWMjhhTmxkTzFKRTNyY2phNTcvZFBrMDByRDlCYkUvWm5lOVNN?=
 =?utf-8?B?YWpWNGtpbFQreWt4a2RpMXZrcVFnRHllUS9POHppWkE5OVRmTEpndERNaDRj?=
 =?utf-8?B?dFVneHZ0YTlUWWovejBvTDVpUG4reDczYmJNL1Ywb2VQS21FbWxhT3Z2eXF0?=
 =?utf-8?B?K09SRU5FNkUrUXF2NGFtYTJrbHV1amR0U0g1V3pQN0ZXbVpVdGlheVF6Ujdw?=
 =?utf-8?B?TG9pRHRXTVlvZERNZDZ0U1dXZ2JYSS9md280V1cyU1ByWW43bGoxYnBCQjdW?=
 =?utf-8?B?Mk1KVmN4cDE0SXU3WXVmb2NGeFc5b054Y1d3ZUoreWZWSXlIeDhLMWwzUzZq?=
 =?utf-8?B?RmdjMS9WYWJMODFxZ21WaFhEZFUyNUI0ellONEFtdFFOcmhrNXR1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4e1e42-edd8-4107-caf0-08da331ed3cc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:21:12.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b93NQUh7WswrlzialiSweqyl1iwKB5MrR/Dm7lMkEpZ1vM/8QAFH2Nw+JknJ13/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 Jude Shih <shenshih@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ok, since I don't get any objects I'm pushing this patch to 
drm-misc-next now.

Regards,
Christian.

Am 09.05.22 um 09:48 schrieb Christian König:
> Harry, Nicholas once more a gentle ping on this.
>
> Any objections/comments? Otherwise I'm going to push this through 
> drm-misc-next.
>
> Thanks,
> Christian.
>
> Am 09.05.22 um 09:47 schrieb Christian König:
>> This gives us the standard atomic implicit and explicit fencing rules.
>>
>> v2: move the wait to amdgpu_dm_atomic_commit_tail
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Cc: Roman Li <Roman.Li@amd.com>
>> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
>> Cc: Jude Shih <shenshih@amd.com>
>> Cc: Wayne Lin <Wayne.Lin@amd.com>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++-----------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a6880dd9c0bb..f9ce8cb45e6d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -83,6 +83,7 @@
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_vblank.h>
>>   #include <drm/drm_audio_component.h>
>> +#include <drm/drm_gem_atomic_helper.h>
>>     #if defined(CONFIG_DRM_AMD_DC_DCN)
>>   #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
>> @@ -7627,6 +7628,10 @@ static int dm_plane_helper_prepare_fb(struct 
>> drm_plane *plane,
>>           goto error_unpin;
>>       }
>>   +    r = drm_gem_plane_helper_prepare_fb(plane, new_state);
>> +    if (unlikely(r != 0))
>> +        goto error_unpin;
>> +
>>       amdgpu_bo_unreserve(rbo);
>>         afb->address = amdgpu_bo_gpu_offset(rbo);
>> @@ -9160,7 +9165,6 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_state *state,
>>       struct dm_crtc_state *dm_old_crtc_state =
>> to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
>>       int planes_count = 0, vpos, hpos;
>> -    long r;
>>       unsigned long flags;
>>       struct amdgpu_bo *abo;
>>       uint32_t target_vblank, last_flip_vblank;
>> @@ -9235,18 +9239,6 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_state *state,
>>           }
>>             abo = gem_to_amdgpu_bo(fb->obj[0]);
>> -
>> -        /*
>> -         * Wait for all fences on this FB. Do limited wait to avoid
>> -         * deadlock during GPU reset when this fence will not signal
>> -         * but we hold reservation lock for the BO.
>> -         */
>> -        r = dma_resv_wait_timeout(abo->tbo.base.resv,
>> -                      DMA_RESV_USAGE_WRITE, false,
>> -                      msecs_to_jiffies(5000));
>> -        if (unlikely(r <= 0))
>> -            DRM_ERROR("Waiting for fences timed out!");
>> -
>>           fill_dc_plane_info_and_addr(
>>               dm->adev, new_plane_state,
>>               afb->tiling_flags,
>> @@ -9591,9 +9583,14 @@ static void 
>> amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>       struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>>       int crtc_disable_count = 0;
>>       bool mode_set_reset_required = false;
>> +    int r;
>>         trace_amdgpu_dm_atomic_commit_tail_begin(state);
>>   +    r = drm_atomic_helper_wait_for_fences(dev, state, false);
>> +    if (unlikely(r))
>> +        DRM_ERROR("Waiting for fences timed out!");
>> +
>>       drm_atomic_helper_update_legacy_modeset_state(dev, state);
>>         dm_state = dm_atomic_get_new_state(state);
>

