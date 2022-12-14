Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8703CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 21:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F4910E4A2;
	Wed, 14 Dec 2022 21:50:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC4810E057
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 21:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0ucDoKGwqSuB8DFgqu82SgGC3EC1Nj2JiUOP7cAmvCRS+sHv5Pwdt+E7j/Ez1Cjfz4iHZKwHDZeKAZHl/DdST+RG6GQAkSu0eGhBh4Ll+JwM3yATc6j9MZ6MNnY0WO5fjLNWsV1gQy7SzrurxSydkBmLZ9MxmPKK/rmcfLjbvn+DRQV2qGC5I8/5nRot3yFIrrV7CyHXyhyqczAXPWBTyVzemVakwfuU+fqcGLtaYyN59pzTTgy4gzOvy3qroFEZaE9KeLtxRwWagkHixfOcjijsoxLx3d9Q5+xx1fG80DIQfiNQZcLo7hW0PkPNRRN4lfb8zPHgXujgqaM1wmxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhAmGOHKVIeeIsXoU5n4zqA/5xyczBK0RtDt8px+K/Y=;
 b=ETwr13f0VNOo7sb7469zEO4O5UnI89JRn0Wpo6tCEfsQhFrKwVXr1+jmfcwsogbS0518bWt200jR0ICBGDuF+CocxVOjQ7r9XTGCg2mpWMI3arYW/nGic+G++42M9v1VPTbdXaw9vmrGLroE3KDydU2XXdpwEDcqCWz8oevGL5z15/bZ0rfW1pRMAtO/ZiiVrmimNZ6tCVoJyTd+2ENnEAo5zJCWyaTQCczAaB8NNXRXqYzotPrvTWcm9jbltBDO8JQSLcqDPEpTIGsvdT7FtGmx9+RVAm9NOzPMXrDYdssbuMLKZRalUn4YOFjHbJuux6jeZwNvQWmRxqmEPitcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhAmGOHKVIeeIsXoU5n4zqA/5xyczBK0RtDt8px+K/Y=;
 b=Dt8jSjSBWgH4pT5xj8RJKasrPBUXqP7DY7kfyguSVjyMNgjRTQ7RpT90gJz3xJEXE4RoHVKE+Ocy3+MTMxBXhqZDarPcd2oEBBG9ydJ2kPMMIjf9HkyydMA5eSjmcg4u8dDX12wYGr0B29mtcUh+mGGB46NLTClPS07rgd/eO4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 21:50:23 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 21:50:23 +0000
Message-ID: <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
Date: Wed, 14 Dec 2022 14:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Deucher <alexdeucher@gmail.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D0D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:6) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea7c715-a7df-47bb-ec58-08dade1d33e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOzlyuSfxEmN/zMRoS0vdOuq1bEaETtvJBGlgpfeTA4aAVpT+6Ys1WNPS9KBaZ8gey6s+wptIntax0dr8R4bXd+qxPXh+AG13I+Aqv90VmngQJsw2DY+m7kGZAZmIDeRBW9ZtVVided8ek265bO2Q7sAEbpEqt0aueutW9VkhrepmCesNpKdDD5ZC5efbGhg3Zz550UkBQLwRzRYCLxdfxPUfp9xy81B+YQdc1+SyzkY79mTb1LboIRDPrutM08043xjvKK0GNJGtHsmnT/OA/c198x0NhMK/7lhjpOtWTlv9TR9aCbZKd7UwtpFk4GNdqN4sXtXAkpVIBCnyV/4fCyHr1Gy1YdMjcTEBgDKK7qzsMN0WfTFE0KMPQItUdYIR6WkOcnyYPzLElLlnuV0ycCOxE9tR7/nckkjNTHRd6Dlt5zVKb4aGTGnwyEzR+BdPUkh8bbMlcyVU8s1qniCIUEsxC6dWq72hdrYioVZWYg7lpeiPgcQ3wLPZilAPUY3LJKtEKuCx/CSw0xcw1ErlSdUhMq/6cYMNjBZVTVXb8Ikx1mnEayVo1yTwaH+1Abcj4Rk+lxKnt1hUoGexwtd/LDIh4/OIREeZOyPlirDZ0MgDzBLDe2oS5vE2wTBTyGYbeTAaJ/5aznmzPjQHIK1x1hxsl9YLJSEMgiQqsqwFMZjYoFbiUW2DAoBhosjl09x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(2616005)(31696002)(86362001)(83380400001)(38100700002)(4001150100001)(2906002)(8936002)(44832011)(5660300002)(4326008)(41300700001)(6512007)(6486002)(6506007)(53546011)(66946007)(478600001)(8676002)(66556008)(66476007)(316002)(110136005)(6636002)(186003)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFvWEJVNTlQc1N2QXdETmM2TTJxUVVuU0VZSzBEVU11eUpxbnRmMDF1MlBl?=
 =?utf-8?B?eWx1WjE4VWVGcWFHb3dZbnc2SGhqZkhkT1ZDMm9GNkc5V0t0TnFoYzIwMktS?=
 =?utf-8?B?ck1saEozVkpkcEdLQ25jcE5vL0dzZC9nU2kzM1hjbDBiaHpIZnZoS2xlaDZt?=
 =?utf-8?B?RjBzR3VnR01qckpyVlpuejh6VHg5NDFxVlJ1WmhCYTljSk1ocmVGU1RzU3FR?=
 =?utf-8?B?eUJHRGlDVmlDRGd1SFlkQStRcTQxM3JaeEhJS0NIeWRVT21QMitna01ENHhY?=
 =?utf-8?B?eEtLY0lsTWkvYkl5aTMzTnRxcnZ6N0ZTd3dDMXJXbTNqRGRmdmEzV2JZMDJ0?=
 =?utf-8?B?V205enp5cVZLa0FLMmtwK2g1ZE53NlNTT0w3cUZEQU1ua2ozNnZaQjBRKzhJ?=
 =?utf-8?B?M1cxZlhZV1VsckRCWmVUR2JEUjgxVE95YkFIclB4MnZ2c0ZzLzd1TWFTKzUz?=
 =?utf-8?B?aUN4YTJBcTI4akE1bTlxL1BRc2VWVFQ3bldMamVJTFZ4SUN0QmVUM3RTdG1t?=
 =?utf-8?B?VDVrbW4vbUR3dHNzVlFtcW1wR2l6NkpscjZvbHJPZXlDMnV6OU1nWmQ3VnBn?=
 =?utf-8?B?T2FtNnV1SEVCWHRTNEJvRm1VaXhGMWlDWmRjWWlyVHdIRlVINnZ2YU03S0Vj?=
 =?utf-8?B?VDQvUCtJRkU3QkMwYlVsWXFsUnk3a0hISFF2ZzdmYWlRMEQrMGZGdVUvS3Zn?=
 =?utf-8?B?bUdOUFZaOXIrOGdybjF3WUdoNWJORzJ6ZEZ5cFdPWGlyM0s2NThxV1lRSFZW?=
 =?utf-8?B?c09IOExkTFBkbERDNExZUVI1SzN4eEFwSFAwR1FSRndBSDRuR3RQRVNZTGg1?=
 =?utf-8?B?Z2tlN2lkeU9VKzl4N2pDTHlMbDNRMThFc2JNMjd6OTJvZmNIZkk4TTFRaDFz?=
 =?utf-8?B?V0U3TUZpVC8xcXE2dkNNZzZkcE8wTndFSm9ScVdJOExkY0ZKWDFoRzVZNFFN?=
 =?utf-8?B?WDN2WXNZVTFmMUVxNThuT3FYL2xIVmcwLytWWkxiTU02YldXYWwwRWFnTnpV?=
 =?utf-8?B?cXQ3SUJ4Q0tiT1dHWEJEdVlxTjNpNkpwZUtFUThrVlNYem45bTBWZWtBWXQv?=
 =?utf-8?B?VzVQYjlFOTFpK1U1UUhtYkVpSW9vYXhORFhUbWVjMGVvbWh4eG83ZSt1M2Jl?=
 =?utf-8?B?V1pzQThjS3VFZTFkaHZoQjgwZFQwR09rc0IvaDV4TTFqYUtkVGppck9lMzE1?=
 =?utf-8?B?S0xnb3R6MzRWeGJ0VWlobTJyYW1ZWHZNZ2VtMGloUzEzeFBTYjV6RXpITGM1?=
 =?utf-8?B?QmRWQWhXN1pCSlFPd3VCdm5RTWFiTVBnQ0RYVW94bzdrclREMWFQN0VWVnpY?=
 =?utf-8?B?ZklUM3I1V2szSjJDNzc2N0ZYdnU2M0JBaUZoQ2pwSFFLNlp0WTRtSjZSQU1t?=
 =?utf-8?B?dE5FemFSSHpKSnFMb2tFQ01wbHFVdk5ybEZ6R0VyQ3d3STNXM2RWM2pHQWNV?=
 =?utf-8?B?ZnE4QjhuWmgxZjdGc01jczZWbFd1NjZyY0FRR2orOVFMdzBtT2FJSjlVTHhH?=
 =?utf-8?B?akFpVlBWWk02MmhOVUNkd01jQm5vbmlORU1yejAzTXk4MXVMNjkvNHlwY3hV?=
 =?utf-8?B?NmV4Y29XTC9BalorSjFpM3BNeWhXSHR3dXo0Z2RBOVJUUGxaeXE2K09SSW4r?=
 =?utf-8?B?WDIzOUtBdlNIMVZZM1ljaFlGaDdKS1ZiZjVzNHltb3VzQzYzc05TOTdGWUVQ?=
 =?utf-8?B?eDV6aHhKSndmdEVIUlVOc1lGbi9Sd0ZkVFc4V3dxRzZ2WGNBa2pnN3EvaFZs?=
 =?utf-8?B?MzI1dHRtNnRudzVrUkpxVXBQSDhSQk53LzdHbHFOM1NNcUZoTUw5ekRjOXRO?=
 =?utf-8?B?VW4vNEU0WG1yTEdNMGRQTGhWTkduandWZjh0LzhQbUJhemZjN3ZIZDE5Qk96?=
 =?utf-8?B?bGFrdWxPUDVYcjE3b0RJR1dIOEFrVzZyT2hoWXM4NmVQSWNBK2kyOHhvdk5B?=
 =?utf-8?B?cDRPeXNMbWNGRTA3eFMvVU5hc2l0UURRaFV3WGZRMHRBSnZBS3h0SE1tREQx?=
 =?utf-8?B?bVh1RHRFem1NckJPTkFhb0NjN0pwN1U5T21ZZHdsM2NldUtZNnBTOXRYRUZT?=
 =?utf-8?B?SEM5UTY1L0lINjc0a043aUdhZ2d1YjVZNjdJNlJiWmRmdFE5eVE1eVJnQ3dT?=
 =?utf-8?B?dzdmY0pPMVhCSlltbXhSYUV3ZlMyNGdRMldmOW1Zd3FEV3FnRDNaZjkwV3hK?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea7c715-a7df-47bb-ec58-08dade1d33e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 21:50:23.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PB+6VMx5qDhCZbp6s/142OgUmbsbD18Fd2rx+UXT7frl2dECzy+IUQDzZLahcJ5qW9nA/ZYlmKZa59kBtgkXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-12-14 13:48, Alex Deucher wrote:
> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
> <aurabindo.pillai@amd.com> wrote:
>>
>> From: Alex Hung <alex.hung@amd.com>
>>
>> [Why]
>> When running IGT kms_bw test with DP monitor, some systems crash from
>> msleep no matter how long or short the time is.
>>
>> [How]
>> To replace msleep with mdelay.
> 
> Can you provide a bit more info about the crash?  A lot of platforms
> don't support delay larger than 2-4ms so this change will generate
> errors on ARM and possibly other platforms.
> 
> Alex

The msleep was introduced in eec3303de3378 for non-compliant display 
port monitors but IGT's kms_bw test can cause a recent h/w to hang at 
msleep(60) when calling "igt_remove_fb" in IGT 
(https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197)

It is possible to workaround this by reversing order of 
igt_remove_fb(&buffer[i]), as the following example:

   igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]

Hangs:
   igt_remove_fb with the order buffer[0], buffer[1], buffer[2]

No hangs:
   igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]

However, IGT simply exposes the problem and it makes more sense to stop 
the hang from occurring.

I also tried to remove the msleep completely and it also work, but I 
didn't want to break the fix for the original problematic hardware 
configuration.

> 
>>
>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> index 913a1fe6b3da..e6251ccadb70 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
>>                           * After output is idle pattern some sinks need time to recognize the stream
>>                           * has changed or they enter protection state and hang.
>>                           */
>> -                       msleep(60);
>> +                       mdelay(60);
>>                  } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
>>                          if (!link->dc->config.edp_no_power_sequencing) {
>>                                  /*
>> --
>> 2.39.0
>>
