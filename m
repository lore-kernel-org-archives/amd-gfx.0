Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0560B6108E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0560B6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7FA8906C;
	Fri,  3 Sep 2021 08:13:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACBE8906C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 08:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez5NoxADdzVk4SuEc29fiGnFIdvIli9TCsFUcbcpyM/2DClm7JZAIRWz96FHLo3qxf666auR+EgTIETUFrp4ehH9l64RdXa53UFyw5HaKuCb/Hs0oETZ59heDAcBcxdb6ldVWovZQhD7/aavt2K3ZCkdXjmkT7zbK2REmDMpGwfFZefQIihSKm3CGdKB1XecGjqDDpeXyeLO/4lUtjHcDK4bdyhE2zKreY0jFCzW0IfMYI2TYlUaTHJdTQv3qbuQprgojmeZmO16FyVuJQd4sNfTgcNyyqdOE/mX+jyAFkEn4arROon793H9dQlydc1F3+u6zwQ8FoC984ykLmuKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LCTFFq2kk68xe3RBPNvjRNya0KN9iQabxTrkuEeQFmI=;
 b=AR0LKGNFvlQHHOYSbMfl+AYEf+ZcCL3V/3KFq03PwY2xyUKidmHEhnlwiAlZJPUz9ICPKz2e5aXtpG2WVTarpPkyJEVFT1CkrqRd1F+VpZD9HEVw9R2d+h0b5MkDA4TFz8bNUAI5sQC3+buo+xTJzOBPWr+o45RlsPm4Zv89M6JboIDJ5GpBiG7uJsa3uat6Z4JOTylZzAEdFNd/y1tNShhgfsk/OviJFiSh/ap7oJRHN+f/wH91KeyN/2W5Eh2xz4WfGz0fLYMEZ+Y0PRz9eRUXfZbaUSjkIwUPpsokiDqihHXgxIpIhpzKNaFuWSR05+h7ce52+BjuSV6lb0h38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCTFFq2kk68xe3RBPNvjRNya0KN9iQabxTrkuEeQFmI=;
 b=ri4FF139ycvrcyg9KexzoDKn+NBz6Zj2ePbhxhQkxc6EEGbyCD4owa+kerR1FgunnG/q1ShuSioODLE1oeITBBd+gv2Tt8M9Ik8Wi4SJLjFmsKLoVrls6Xr/eg+3EIZgG1PCdCF+VJZ9WijXWy9PcscktdPrrGR7a1f+uvm9oPM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 3 Sep
 2021 08:13:40 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 08:13:40 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use IS_ERR for debugfs APIs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <5aeadf99-0864-1e45-63fa-a9f299d373f7@amd.com>
Cc: "Sharma, Shashank" <shashank.sharma@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <1fdd6081-b332-fdff-2190-5f8ead784b59@amd.com>
Date: Fri, 3 Sep 2021 10:13:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5aeadf99-0864-1e45-63fa-a9f299d373f7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0198.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::35) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f20:4c00:bdd8:5b76:521a:8f56]
 (2003:c5:8f20:4c00:bdd8:5b76:521a:8f56) by
 AM0PR02CA0198.eurprd02.prod.outlook.com (2603:10a6:20b:28e::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22 via Frontend
 Transport; Fri, 3 Sep 2021 08:13:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17d2b7b-11e3-4df8-988f-08d96eb2bcdf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50547D6E1F86847AD67CEAEF8BCF9@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwv4uZRV+G9o9AUtghJyBeqhnjIQetz2wzJooYiQzbPM66XGYi97acO38cTpGYRHb+DpDcpF1W5EiwintTs7etsc7GlPnmvDaSRaLKXU+s6HrvuVaja4xFuzL2WdFJXzg/vQ8CqiVqILDcTPyC/r3zpumA+kh7tXbuW9hzgoZMEhMzOZjy2IB1n0+vipE2lFtk33QPyzsHiX77TFsBCyocUFhZfUoE9fXoVwTSwiX8Xml9pxPgcdOyyzb7tgYmfuoq+l+TeeuDWj2FIXGg2tT96W4rADw02dnw28aFSRJa4usdZBr2Q84qs5L8lKxKlZJrl2Ust7g3zWl34SGy9grGnnSKgp4PwSeN/gKvAyVwynUkfFvlNlrSXw2Vjnjs4kFQ8gojKwbkUtdxGHtu9jugYf3JTKcAPBFw60GhW5EMv2cBW+jELEfL+hWE8s7+uVxtnMSX2RBoPIuK6PS5ccXajBbhGpdOdEjA9CPyyGPhYtZNWpj1n9wTrVRb97mh3z32RJIXSCSBG6Jt2PoEiNJHyveNNloWYT7m3Gz1tdui95q5GfslG0PR4TtDcS9/JfWHG2JMAyF0OettDJUPylciZsdoLwqpgxqFeClaBqmHsaY0uCjmb6xfwMzbitVees9Dk0AivaimDbdvthN7CjqZrzXdwiSsmm8oeQPva7amQuc8HpyMbVXeo8PTyx6EBuHJYoCHm95WJahVUUvJvYeIDhDoxhhGCPfxNbu7g4BJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(31696002)(2906002)(36756003)(6486002)(66476007)(86362001)(66946007)(8676002)(66556008)(53546011)(966005)(2616005)(316002)(83380400001)(5660300002)(52116002)(8936002)(4326008)(31686004)(38100700002)(478600001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZQaW4zUjk3S2RDNEtzYXFoZ2pHeGNlOEhEOWNnL0ZiVThKcWMrM1BkbVZ0?=
 =?utf-8?B?cXN6Y2wxN05qejN0Qjk3UEFlRGFBT0Y5UWZHK0o1UWoxM0VGT1VoaDZXaWsy?=
 =?utf-8?B?eVREOXVyR2g4dWg0VmdRQ0s3WGkwMUdOWjBXckVkdml6NmlhU3ZueGlzZWl4?=
 =?utf-8?B?SUthb2JTVThPOEQxZXp5eHM3dXNNZmlkNFROTE15a09saUZyUVY2Nk5mR2t0?=
 =?utf-8?B?di9tWFI4ZGIrR0JQVTJibDJYNVlKM2M0U2xUdHhhTEpIV2JuSWdITmxKV1lk?=
 =?utf-8?B?VFZ0VHBTRDN2STYzeXl2UzUzV0l0Ull0TEVYb2NnajNyZnFadDlscll2SU82?=
 =?utf-8?B?NVZlOXlpbWczT2piRGd5b01KbFlNSjFOOVZNT0lNMGtnZmFTTTU5elplY0ZM?=
 =?utf-8?B?NGcxWGJqd25YTTU2ZWJLMy9TY3pLd3B3ekZ4RThmNGg3VlJhMEx6Z0FiZys5?=
 =?utf-8?B?aDh2aUEwRzV1Vkp2bUVWSnE4VEt4RStjVE1iYXc3UzRZc1J2TDMyMmJsaXJa?=
 =?utf-8?B?N2pxck80ZlBETHAwekc4YWxFVzAwWGc1M28wZFN0L2hNUXhJTDFmajhKNEk3?=
 =?utf-8?B?OG5ranhOZisvaUtXV3VQREpZL3VrWkN5cEZHeHptR2lIVDdGSW9ESHV6RTZH?=
 =?utf-8?B?YmlGa01GaFNQbGg0SDh4UE1wT2JPelMzS1NLYTM4MnFrWjdoNFFZSzJLZk9Y?=
 =?utf-8?B?OEpzS1Zvdkcvd3llb1JNaUM4VkIvOVpQbitJNHhuNjFTcHp5Q0V6bXpZMm9o?=
 =?utf-8?B?dWVJMVlBd0JhMFZVcjQvMm14WmR4N0hSdUdRcExBN2J6UjNGbllURHE2SG5T?=
 =?utf-8?B?OVJFSitsYURJM2l4TDd4V3dhZW1lMnFDejRZMUswNXVQZ3UvWFY2aFJDeUxh?=
 =?utf-8?B?WFdOZXNwWWVNQXRHdkhtVG5DMkN4aDZCdDdPU2NZMW1vc3ZaNUV0eGF3MWdi?=
 =?utf-8?B?M25JbjVvVW1xcGMxQ0xDV0E0N1lXK2htTUU0UklhZWhLQXp4RkpEQTBQUDh3?=
 =?utf-8?B?eTIvYm83ZFJmNHlyUTk2ZWJ0QVZCOHBvNGZ4MTczMGU4eVZoQjJqcXdyWERN?=
 =?utf-8?B?WlVvNTh2SzA5Q1p3VUlEaEV5MDVpWUE0KzVYcGpFMDVOZFFxZFhDWm9BRkRS?=
 =?utf-8?B?WlhvN0ZzT3EzMERtRkMySC9ZT1dNSnBXZWkwVkNBU2txYTc5Kzk0dTNWZVFE?=
 =?utf-8?B?MGlKN2JqR0NOWXk0SEdkSy9QWmN4MlBiRkF5ZS9mZTlkajJSQXZpeUt1QzhM?=
 =?utf-8?B?Y1BwcGpBMjVJUjVSWFlURGgyWE9hUHBkdmZlaW1NNGVpT1FuQjh2MWU4TkNr?=
 =?utf-8?B?bGhqSWhhUW5xMHQzVmw2eWdJS1RSblhZWWsxM3NqOWN5ODlUL3k0d2hmMHVB?=
 =?utf-8?B?ZWpZcTRZZGJmZ3F0c3FkL3E3R1lYMDk3bmhXRFQyUk1GOFZCRmZmdzhrd0Uz?=
 =?utf-8?B?NGpJMFdSa2N0MktOWmkreDlwM2dtOFhvSHdEcmlTUWVscTAwZExuTy9VZHhH?=
 =?utf-8?B?a0NVSFhRd0kvYm9mcjkybmN3VWtqZzFaV29wejl4ZXdjbEFGS01PTS9hS1Jh?=
 =?utf-8?B?TnFFMDduTm1CeEdJQmxGcWhMT3E4dlY2RnZDb0R2WEplZTc3RWQzcjduSm50?=
 =?utf-8?B?MzFoM0ZqQytVelFDNTdpdThBeFlwVEZQeDNpVE93a3dqME54cFVJNnUyNVVX?=
 =?utf-8?B?ZnE1eW83RzF0L3pzTEErMUNNOHdDdG9oZms0Rk1sbEExRGNzb0l0UUtyYThr?=
 =?utf-8?B?K2h3T1VTNWgrdWpPek1ISEJZSllEYzhzcnp5R1R2QytRTUpMbHljTXZVMk1j?=
 =?utf-8?B?QXlLUWwrRFltNGd2NS9ZYjU0K3UyTmFiYnp3SU1vZkFzaVFpMmxsbEhrOTRX?=
 =?utf-8?Q?P6psgM/BgAHC+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17d2b7b-11e3-4df8-988f-08d96eb2bcdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 08:13:40.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V+GFqCj/iJrEb79m0IVah4vpiuRMByY0v2Qyh5Cd9N6dzF9b9ns9w0lcngJTY1FD3xTJH/DLBK2ozaQPWBTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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

Hi Christian and Shashank,


Please review the v2 : https://patchwork.freedesktop.org/patch/452175/

In v2, I am returning "PTR_ERR(ent)" instead of -EIO which I think makes more sense.

Regards,
Nirmoy

On 9/3/2021 9:53 AM, Christian König wrote:
> Am 02.09.21 um 13:44 schrieb Nirmoy Das:
>> debugfs APIs returns encoded error so use
>> IS_ERR for checking return value.
>>
>> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index d256215ab2c7..077f9baf74fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       struct dentry *ent;
>>       int r, i;
>>   -
>> -
>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>                     &fops_ib_preempt);
>> -    if (!ent) {
>> +    if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>> file\n");
>>           return -EIO;
>>       }
>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>>                     &fops_sclk_set);
>> -    if (!ent) {
>> +    if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>>           return -EIO;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 7b634a1517f9..f40753e1a60d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device 
>> *adev,
>>       ent = debugfs_create_file(name,
>>                     S_IFREG | S_IRUGO, root,
>>                     ring, &amdgpu_debugfs_ring_fops);
>> -    if (!ent)
>> +    if (IS_ERR(ent))
>>           return -ENOMEM;
>>         i_size_write(ent->d_inode, ring->ring_size + 12);
>
