Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA0C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA0360F70
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DA0360F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2C489913;
	Tue,  3 Aug 2021 08:16:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9719C89951
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 08:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO2PUNFcWPwG/u7X6PbekHrgTmzjnmr//FVoqh/PzERIvKkU5UzfTY/Bi3w1Snb3hONaBCJhp4tK/lquqnammzNaQEPf6Z13Tay+3IEoVLGLeXvINFxyLov7n4f90k5TE8c1k+tHFgFRtqDaICXbpuIIWXkwHQ8+Fq9GBf6YmNcyQB9BgKnl+62VRxpL8sbj4sZnPoLOhUMTCcy+tkS9D2luyJ00d3yU0MAnRMgpQnekPkZZBJDS5gK28sj0Efg6ZoJtwcT7rItNeXvh9P1xHuEcwChOEa+2q4w5NCXeRFjvMKUPbYa/RLlHaySH5w/BglcggUMFBir43sf3ZCLQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvwDJQ7EBxX5YnDOP9bqxyBmACSgthHqAUidlgxb9ck=;
 b=I9BtHfj+GkYgVLrOzA4FNAHAP96MuBnPbr1B80hwLZ+kPyyeApxeVD/yNZizFs4MfpcgGZlGlW5aVJvtNfEDm5Qyjd7Sj/ZEEH6w8c5y/74X/fGwiUhLoo1xyaqSyjZTvpwbcVgDJWDImGxn0RLQsHzUfcNeUXdkyOeNYHoNtGBywLJNhHeF2MDqzy9xiOl9idR80iHiqRo0WEy5BxjwgNuTGqtIIfgevWQT4gfT0waNYxXFDsGkmQKEiSDN8pHl+d6g9iAR3yP7BOPmbvpnrRRTT50vFOK1zZ7mmYpOu9CeuGto8ovH34W2hopmZ4ok6GiMcCEjj2TXvv9MmtcUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvwDJQ7EBxX5YnDOP9bqxyBmACSgthHqAUidlgxb9ck=;
 b=J0bbn9RlEKkCT2OpbcUenlPM0ZB9hWAtaEhoAaWkzofXseliqaUdtfmTY8Ovc1qbYotgchITr1Hcp0TewQ/97w2G2phd5MRKhrERML0dXob2TW85IXRnC1FqEknSjJMRZw13UcI73luSKf+64wF8linEvR376zjLTQlrtGJxSzw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 08:16:21 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:16:21 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Li, Candice" <Candice.Li@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Clements, John" <John.Clements@amd.com>
References: <DM6PR12MB46495DFBA7AA7E20614B7CC591F09@DM6PR12MB4649.namprd12.prod.outlook.com>
 <9c4fe075-d02b-cb5d-3965-d78e5b937540@amd.com>
 <DM5PR12MB2469E5043B5DF107A5FF413BF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <79a173e3-ce1d-4877-ad38-6b4bd127b52b@amd.com>
Date: Tue, 3 Aug 2021 13:46:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM5PR12MB2469E5043B5DF107A5FF413BF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::34) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21 via Frontend Transport; Tue, 3 Aug 2021 08:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25682c64-8e32-439b-d3e6-08d95656f98e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030319FDEF9A73DE816891197F09@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUNQPTlzgCvYdaNk3QdlJHrkD8Yx+XOm0uk4a4JxlCuAuoGfRltlgX04OlClvUzp06vZUCBAAx7RiYFoEvYO63txIug5g6ex3hQH2mcLaXakZavLDR5i+ni/UMXd/U5rjbtJUAQDEuElsblmuQJsZA6mDroQi2ofL9/65zOkO8QKo6JxLaun9OqMb91BxvSDzfM93Pk7DabpId5CSOGJzR/xO6GcaHQ/GL2prcwUEVA9Rf07kp6089cTkmjE1UxDuogTFukMjWvC3eyepEYDvSdUo+gRdfvqfNELznkbNCNbO/QkLv9o+E5JQlyf4TAbeWwjsb4QaxyKf3W+nKw8P0kag7IseHZ4YHcNIPU6jYhkRjxFG6CdxMpAk68PydSSTP+YdZg0YQaDVWchUeBAnljtyf5LxMCPzhTdfXM13EQ3tl2HVrt9WAOn6Wym2lIQy3qL0e4ROIuCynNatAL2uyCUSAwAo9TvSnjbak0McUdfE8ZGalsPuw3wvIHbky0OzzhLsNFB92Sn5GysknPFNOHwI1xyXNqXljToogE45JKS/nt8uUYhd22SVO0S2TRkg+s7kuoZv0NVk7PO27LuaIZI/XgzGz+6f+IOm+oqLH8PUi2mS7JwVdWTb5hzjkiVeS6hJyA7q3/E8Ps+hwduHWdaZrUx+YMW7ieoTl6kBfno3MA4PFtp4mniNVelrISqo36aLwEzha9tYBdlt7NXSW5NYLjWugDwreIeVqN0ccw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(38100700002)(36756003)(8936002)(83380400001)(2906002)(110136005)(4326008)(6666004)(316002)(26005)(5660300002)(16576012)(31696002)(8676002)(30864003)(66556008)(66476007)(53546011)(478600001)(186003)(2616005)(31686004)(956004)(66946007)(6486002)(86362001)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elB6V0VUZE9kdHBjS3JEbU9EUXcyMFN0Nk9JV0VXVXpyYWtkT0NBTGxJb2xC?=
 =?utf-8?B?eW1mV0NEM3RIbGcva2psMmNsUzdLS3FBWXlmTk1UU3RjL2pYMHBJTmlyTHlt?=
 =?utf-8?B?WEFteCtLak9vZUQ3ZUlGUHJlMzEyUXIvNEdzTWMvQ3dTQmdOS1dLNWNlYWxH?=
 =?utf-8?B?alNWTmFjM2RlNjBsTStHK2FaQ0VNUEp0ejBXNE9GbHVqRVpsSzlRbWoxRUdn?=
 =?utf-8?B?OGZyZ1pZT1l2S3ZUeE5hMkxTUFBxSFlBRVBWZGZIQUlTaWkvRXhFc0VjRmJ5?=
 =?utf-8?B?MGgzRlg1V3YvdVpFbW5mYU1oSmZMWnBEVFV4OFRpZ2Mxd05nTnVDYVUrUlhG?=
 =?utf-8?B?bXlOUnVLbUNyOFZGSjQ0SmpYanJSdUJaeThUZUllRGdjaGYrSm4weVVYY1dt?=
 =?utf-8?B?bjZjd24yUlU1YmZ3ZC9VcWp5ZUtEN1hPaVo5VjgxeXhjNUJ0bVZJYXluNEJM?=
 =?utf-8?B?eWl5NERRY1NMOGhiMWNHTW1UdVpOOSthaGM3Zk9kRVlNNGhGLy9JdmprbUpo?=
 =?utf-8?B?ZXFaSkRVM3dwOW4xUUY3ckl2Q0J4Um04RHlBQzBraWsra1loT0MxcGpTSjFJ?=
 =?utf-8?B?RFdCNUtObGpBLzhvL00rZTBjL3NDVEYvM3ZhQlNoRmUzSXpoQ0ZSSTB2eTYx?=
 =?utf-8?B?d1ZlTjZnZHZ4eGFiQ1lsNGhCdndzdis5d0w1UHBYMTZMSWdQZDlkWUlTRTB5?=
 =?utf-8?B?MkFjUnFqaHJEVkVYRGtSMFhDNUpkTTBMSVNuYS9pdjFyNXZVaEZUSzluSVFl?=
 =?utf-8?B?TnVxK1FuN1VObGtWOVBXdzlWdlEzdzNFSlRPQVBRclVoRC9TN3NzWUQrMmNr?=
 =?utf-8?B?V013cVpYQ3RJT1FLY3lsUFo3V3hJL0x2K3Q1L2Q4ellvNThXQk8zdDNPL2lT?=
 =?utf-8?B?SStIZnBaM2dUTU1qZDl0UXc1cTJ3TndrNnkvellHV1ovcjR5MXFXdk5QOTJZ?=
 =?utf-8?B?K3d0NnhXUEgyVzh2a2h6Y3pVNWQ4bGE3M1Q0NkR6M1pKOE9zSjZnQmEwRUxQ?=
 =?utf-8?B?S0FzOC9rZy9hQXpjZEhKL3JNeUl0bEtLMUpZMUovQ2pqMFA2SHRqMWRrYzA2?=
 =?utf-8?B?OExtU2FTU1gzOUhvMGFQSHNnbEppajdwQ2YvYVEwQkpmNHdLeTFUdk1nZHhR?=
 =?utf-8?B?dk1VaEJvdzNjUllqRXRsbTFDY214VUJKRndwa3ZRTjBmV3lyTGNrV3k4Mk1w?=
 =?utf-8?B?aHFrWHVQTjNPcXdrbDFsU0hWVUhrcXhQKytjRjFIZHNldlBBY2dBd1prMXMw?=
 =?utf-8?B?WVR0T0J1bjZkNnJVdXdxRUZhcWl3KzFyNHlUSDdPQk91YTcvdkRWdkE1S09C?=
 =?utf-8?B?MkZVSHhROUFSWkk5RVBVbVo3UXF1YnNpdUxLN0NFUjQ3dGN6OGhQTUphM3da?=
 =?utf-8?B?dzBIM2VSTjlZV0RiUnczMWZJYkJ2TkRhRDc1RFFxNjFPR0VrcVZGc1kyNTYx?=
 =?utf-8?B?cDB1bTRJaldRQi9MSkp5YnNuaHdoVlNCb05KaExGajBNY0MySy9QUFlPZVht?=
 =?utf-8?B?KzhoN29jKzJydHFVUGJwUXlSVzJzbXdKYVJjVjJRMUIzTExPTTdtcmRZK2NV?=
 =?utf-8?B?My9oRUpQWDQ3N3F0RkowN25PTHN3RTg3dDJkWkpXQVhJeURKSkpHS01EV3ZI?=
 =?utf-8?B?ck4xTnFrMUM4V0JaeVd1YTdHYTc3ZjNrK3RnSTJYd3RZMnh4dXk5QVFUWHp2?=
 =?utf-8?B?akV3YWJFaTd1WnNHa091UG5hdVIwTTdlY0kxcUZNcUxYdGlocGlXVHR3R25m?=
 =?utf-8?Q?6rN6ydasYIkHv8BFUvCQfOlHSJk7y+FJ7VToofe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25682c64-8e32-439b-d3e6-08d95656f98e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 08:16:20.8239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJC0/2dQHrTMsr9HcM9cjbHWKAogyvJQSmP69qkzPqiqCJOK9QTeUFAa9c2Y2q6C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
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

Not really. Below clearing and changing the buffer happens outside of 
the mutex, so it's not fine till the memcpy happens in psp_cmd_submit_buf.

memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));


Thanks,
Lijo


On 8/3/2021 1:37 PM, Chen, Guchun wrote:
> [Public]
> 
> In psp_cmd_submit_buf, it has psp->mutex to guard this, so it should be fine.
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Tuesday, August 3, 2021 2:30 PM
> To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>
> Subject: Re: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
> 
> Command buffer in psp context means different command buffers cannot be prepared in parallel. Any case of submitting commands for different TAs in parallel - ex: for RAS and some other TA?
> 
> Thanks,
> Lijo
> 
> On 8/3/2021 8:35 AM, Li, Candice wrote:
>> [Public]
>>
>>
>> Signed-off-by: Candice Li candice.li@amd.com
>> <mailto:candice.li@amd.com>
>>
>> ---
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 253 ++++++++----------------
>>
>> 1 file changed, 78 insertions(+), 175 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>
>> index ed731144ca7f..9c18558e3bc0 100644
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>
>> @@ -253,6 +253,12 @@ static int psp_sw_init(void *handle)
>>
>>                struct psp_runtime_boot_cfg_entry boot_cfg_entry;
>>
>>                struct psp_memory_training_context *mem_training_ctx =
>> &psp->mem_train_ctx;
>>
>> +            psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> +            if (!psp->cmd) {
>>
>> +                           DRM_ERROR("Failed to allocate memory to
>> command buffer!\n");
>>
>> +                           ret = -ENOMEM;
>>
>> +            }
>>
>> +
>>
>>                if (!amdgpu_sriov_vf(adev)) {
>>
>>                               ret = psp_init_microcode(psp);
>>
>>                               if (ret) {
>>
>> @@ -315,25 +321,30 @@ static int psp_sw_init(void *handle)
>>
>> static int psp_sw_fini(void *handle)
>>
>> {
>>
>>                struct amdgpu_device *adev = (struct amdgpu_device
>> *)handle;
>>
>> +            struct psp_context *psp = &adev->psp;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> -             psp_memory_training_fini(&adev->psp);
>>
>> -             if (adev->psp.sos_fw) {
>>
>> -                           release_firmware(adev->psp.sos_fw);
>>
>> -                           adev->psp.sos_fw = NULL;
>>
>> +            psp_memory_training_fini(psp);
>>
>> +            if (psp->sos_fw) {
>>
>> +                           release_firmware(psp->sos_fw);
>>
>> +                           psp->sos_fw = NULL;
>>
>>                }
>>
>> -             if (adev->psp.asd_fw) {
>>
>> -                           release_firmware(adev->psp.asd_fw);
>>
>> +            if (psp->asd_fw) {
>>
>> +                           release_firmware(psp->asd_fw);
>>
>>                               adev->psp.asd_fw = NULL;
>>
>>                }
>>
>> -             if (adev->psp.ta_fw) {
>>
>> -                           release_firmware(adev->psp.ta_fw);
>>
>> -                           adev->psp.ta_fw = NULL;
>>
>> +            if (psp->ta_fw) {
>>
>> +                           release_firmware(psp->ta_fw);
>>
>> +                           psp->ta_fw = NULL;
>>
>>                }
>>
>>                 if (adev->asic_type == CHIP_NAVI10 ||
>>
>>                    adev->asic_type == CHIP_SIENNA_CICHLID)
>>
>>                               psp_sysfs_fini(adev);
>>
>> +            kfree(cmd);
>>
>> +            cmd = NULL;
>>
>> +
>>
>>                return 0;
>>
>> }
>>
>> @@ -491,6 +502,8 @@ static void psp_prep_tmr_cmd_buf(struct
>> psp_context *psp,
>>
>>                uint32_t size = amdgpu_bo_size(tmr_bo);
>>
>>                uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
>>
>>                else
>>
>> @@ -506,6 +519,8 @@ static void psp_prep_tmr_cmd_buf(struct
>> psp_context *psp,
>>
>> static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>
>>                                                                  
>> uint64_t pri_buf_mc, uint32_t size)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id = GFX_CMD_ID_LOAD_TOC;
>>
>>                cmd->cmd.cmd_load_toc.toc_phy_addr_lo =
>> lower_32_bits(pri_buf_mc);
>>
>>                cmd->cmd.cmd_load_toc.toc_phy_addr_hi =
>> upper_32_bits(pri_buf_mc);
>>
>> @@ -517,11 +532,8 @@ static int psp_load_toc(struct psp_context *psp,
>>
>>                                             uint32_t *tmr_size)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>>                /* Copy toc to psp firmware private buffer */
>>
>>                psp_copy_fw(psp, psp->toc.start_addr,
>> psp->toc.size_bytes);
>>
>> @@ -531,7 +543,7 @@ static int psp_load_toc(struct psp_context *psp,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>>                if (!ret)
>>
>>                               *tmr_size =
>> psp->cmd_buf_mem->resp.tmr_size;
>>
>> -             kfree(cmd);
>>
>> +
>>
>>                return ret;
>>
>> }
>>
>> @@ -588,7 +600,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
>>
>> static int psp_tmr_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set
>> up TMR.
>>
>>                 * Already set up by host driver.
>>
>> @@ -596,10 +608,6 @@ static int psp_tmr_load(struct psp_context *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
>> psp->tmr_bo);
>>
>>                DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
>>
>>                                amdgpu_bo_size(psp->tmr_bo),
>> psp->tmr_mc_addr);
>>
>> @@ -607,14 +615,14 @@ static int psp_tmr_load(struct psp_context *psp)
>>
>>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
>>
>> -
>> struct psp_gfx_cmd_resp *cmd)
>>
>> +                                                               struct
>> psp_gfx_cmd_resp *cmd)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
>>
>>                else
>>
>> @@ -624,11 +632,7 @@ static void psp_prep_tmr_unload_cmd_buf(struct
>> psp_context *psp,
>>
>> static int psp_tmr_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 psp_prep_tmr_unload_cmd_buf(psp, cmd);
>>
>>                DRM_INFO("free PSP TMR buffer\n");
>>
>> @@ -636,8 +640,6 @@ static int psp_tmr_unload(struct psp_context *psp)
>>
>>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -662,7 +664,9 @@ int psp_get_fw_attestation_records_addr(struct
>> psp_context *psp,
>>
>>                                                                          
>> uint64_t *output_ptr)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> +
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>>                 if (!output_ptr)
>>
>>                               return -EINVAL;
>>
>> @@ -670,10 +674,6 @@ int psp_get_fw_attestation_records_addr(struct
>> psp_context *psp,
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                cmd->cmd_id = GFX_CMD_ID_GET_FW_ATTESTATION;
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>> @@ -684,29 +684,26 @@ int psp_get_fw_attestation_records_addr(struct
>> psp_context *psp,
>>
>>                                             
>>         ((uint64_t)cmd->resp.uresp.fwar_db_info.fwar_db_addr_hi << 32);
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_boot_config_get(struct amdgpu_device *adev, uint32_t
>> *boot_cfg)
>>
>> {
>>
>>                struct psp_context *psp = &adev->psp;
>>
>> -             struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                int ret;
>>
>> +            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                if (amdgpu_sriov_vf(adev))
>>
>>                               return 0;
>>
>> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> -
>>
>> -             cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
>>
>> -             cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_GET;
>>
>> +            psp->cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
>>
>> +            psp->cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_GET;
>>
>> -             ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> +            ret = psp_cmd_submit_buf(psp, NULL, psp->cmd,
>> psp->fence_buf_mc_addr);
>>
>>                if (!ret) {
>>
>>                               *boot_cfg =
>>
>> -
>> (cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
>>
>> +
>> (psp->cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
>>
>>                }
>>
>>                 return ret;
>>
>> @@ -715,19 +712,18 @@ static int psp_boot_config_get(struct
>> amdgpu_device *adev, uint32_t *boot_cfg)
>>
>> static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t
>> boot_cfg)
>>
>> {
>>
>>                struct psp_context *psp = &adev->psp;
>>
>> -             struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> +
>>
>> +            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>>                 if (amdgpu_sriov_vf(adev))
>>
>>                               return 0;
>>
>> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> -
>>
>> -             cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
>>
>> -             cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_SET;
>>
>> -             cmd->cmd.boot_cfg.boot_config = boot_cfg;
>>
>> -             cmd->cmd.boot_cfg.boot_config_valid = boot_cfg;
>>
>> +            psp->cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
>>
>> +            psp->cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_SET;
>>
>> +            psp->cmd->cmd.boot_cfg.boot_config = boot_cfg;
>>
>> +            psp->cmd->cmd.boot_cfg.boot_config_valid = boot_cfg;
>>
>> -             return psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> +            return psp_cmd_submit_buf(psp, NULL, psp->cmd,
>> psp->fence_buf_mc_addr);
>>
>> }
>>
>>    static int psp_rl_load(struct amdgpu_device *adev)
>>
>> @@ -735,14 +731,14 @@ static int psp_rl_load(struct amdgpu_device
>> *adev)
>>
>>                struct psp_context *psp = &adev->psp;
>>
>>                struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                if (!is_psp_fw_valid(psp->rl))
>>
>>                               return 0;
>>
>>                 memset(psp->fw_pri_buf, 0, PSP_1_MEG);
>>
>>                memcpy(psp->fw_pri_buf, psp->rl.start_addr,
>> psp->rl.size_bytes);
>>
>> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> -
>>
>>                cmd->cmd_id = GFX_CMD_ID_LOAD_IP_FW;
>>
>>                cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =
>> lower_32_bits(psp->fw_pri_mc_addr);
>>
>>                cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =
>> upper_32_bits(psp->fw_pri_mc_addr);
>>
>> @@ -755,6 +751,8 @@ static int psp_rl_load(struct amdgpu_device *adev)
>>
>> static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>
>>                                                            uint64_t
>> asd_mc, uint32_t size)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id = GFX_CMD_ID_LOAD_ASD;
>>
>>                cmd->cmd.cmd_load_ta.app_phy_addr_lo =
>> lower_32_bits(asd_mc);
>>
>>                cmd->cmd.cmd_load_ta.app_phy_addr_hi =
>> upper_32_bits(asd_mc);
>>
>> @@ -768,7 +766,7 @@ static void psp_prep_asd_load_cmd_buf(struct
>> psp_gfx_cmd_resp *cmd,
>>
>> static int psp_asd_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /* If PSP version doesn't match ASD version, asd
>> loading will be failed.
>>
>>                 * add workaround to bypass it for sriov now.
>>
>> @@ -777,10 +775,6 @@ static int psp_asd_load(struct psp_context *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_copy_fw(psp, psp->asd_start_addr,
>> psp->asd_ucode_size);
>>
>>                 psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
>>
>> @@ -793,14 +787,14 @@ static int psp_asd_load(struct psp_context *psp)
>>
>>                               psp->asd_context.session_id =
>> cmd->resp.session_id;
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>
>>                                                            
>>          uint32_t session_id)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id = GFX_CMD_ID_UNLOAD_TA;
>>
>>                cmd->cmd.cmd_unload_ta.session_id = session_id;
>>
>> }
>>
>> @@ -808,7 +802,7 @@ static void psp_prep_ta_unload_cmd_buf(struct
>> psp_gfx_cmd_resp *cmd,
>>
>> static int psp_asd_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> @@ -816,10 +810,6 @@ static int psp_asd_unload(struct psp_context
>> *psp)
>>
>>                if (!psp->asd_context.asd_initialized)
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_ta_unload_cmd_buf(cmd,
>> psp->asd_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>> @@ -827,14 +817,14 @@ static int psp_asd_unload(struct psp_context
>> *psp)
>>
>>                if (!ret)
>>
>>                               psp->asd_context.asd_initialized = false;
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static void psp_prep_reg_prog_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>
>>                               uint32_t id, uint32_t value)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id = GFX_CMD_ID_PROG_REG;
>>
>>                cmd->cmd.cmd_setup_reg_prog.reg_value = value;
>>
>>                cmd->cmd.cmd_setup_reg_prog.reg_id = id;
>>
>> @@ -843,22 +833,17 @@ static void psp_prep_reg_prog_cmd_buf(struct
>> psp_gfx_cmd_resp *cmd,
>>
>> int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
>>
>>                               uint32_t value)
>>
>> {
>>
>> -             struct psp_gfx_cmd_resp *cmd = NULL;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                int ret = 0;
>>
>>                 if (reg >= PSP_REG_LAST)
>>
>>                               return -EINVAL;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_reg_prog_cmd_buf(cmd, reg, value);
>>
>>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>>                if (ret)
>>
>>                               DRM_ERROR("PSP failed to program reg id
>> %d", reg);
>>
>> -             kfree(cmd);
>>
>>                return ret;
>>
>> }
>>
>> @@ -868,6 +853,8 @@ static void psp_prep_ta_load_cmd_buf(struct
>> psp_gfx_cmd_resp *cmd,
>>
>>                                                                 
>> uint64_t ta_shared_mc,
>>
>>                                                                 
>> uint32_t
>> ta_shared_size)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id
>> = GFX_CMD_ID_LOAD_TA;
>>
>>                cmd->cmd.cmd_load_ta.app_phy_addr_lo          =
>> lower_32_bits(ta_bin_mc);
>>
>>                cmd->cmd.cmd_load_ta.app_phy_addr_hi          =
>> upper_32_bits(ta_bin_mc);
>>
>> @@ -899,6 +886,8 @@ static void psp_prep_ta_invoke_cmd_buf(struct
>> psp_gfx_cmd_resp *cmd,
>>
>>                                                            
>>          uint32_t ta_cmd_id,
>>
>>                                                            
>>          uint32_t session_id)
>>
>> {
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>> +
>>
>>                cmd->cmd_id
>> = GFX_CMD_ID_INVOKE_CMD;
>>
>>                cmd->cmd.cmd_invoke_cmd.session_id = session_id;
>>
>>                cmd->cmd.cmd_invoke_cmd.ta_cmd_id = ta_cmd_id;
>>
>> @@ -909,35 +898,25 @@ static int psp_ta_invoke(struct psp_context
>> *psp,
>>
>>                                 uint32_t session_id)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_xgmi_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the loading in sriov for now
>>
>>                 */
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_copy_fw(psp, psp->ta_xgmi_start_addr,
>> psp->ta_xgmi_ucode_size);
>>
>>                 psp_prep_ta_load_cmd_buf(cmd,
>>
>> @@ -954,15 +933,13 @@ static int psp_xgmi_load(struct psp_context
>> *psp)
>>
>>                               psp->xgmi_context.session_id =
>> cmd->resp.session_id;
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_xgmi_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                struct amdgpu_device *adev = psp->adev;
>>
>>                 /* XGMI TA unload currently is not supported on
>> Arcturus/Aldebaran A+A */
>>
>> @@ -974,17 +951,11 @@ static int psp_xgmi_unload(struct psp_context
>> *psp)
>>
>>                 * TODO: bypass the unloading in sriov for now
>>
>>                 */
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_ta_unload_cmd_buf(cmd,
>> psp->xgmi_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1204,7 +1175,7 @@ static int psp_ras_init_shared_buf(struct
>> psp_context *psp)
>>
>> static int psp_ras_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                struct ta_ras_shared_memory *ras_cmd;
>>
>>                 /*
>>
>> @@ -1213,10 +1184,6 @@ static int psp_ras_load(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_copy_fw(psp, psp->ta_ras_start_addr,
>> psp->ta_ras_ucode_size);
>>
>>                 ras_cmd = (struct ta_ras_shared_memory
>> *)psp->ras.ras_shared_buf;
>>
>> @@ -1247,15 +1214,13 @@ static int psp_ras_load(struct psp_context
>> *psp)
>>
>>                if (ret || ras_cmd->ras_status)
>>
>>                               amdgpu_ras_fini(psp->adev);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_ras_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the unloading in sriov for now
>>
>> @@ -1263,17 +1228,11 @@ static int psp_ras_unload(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_ta_unload_cmd_buf(cmd, psp->ras.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                             psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1514,7 +1473,7 @@ static int psp_hdcp_init_shared_buf(struct
>> psp_context *psp)
>>
>> static int psp_hdcp_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the loading in sriov for now
>>
>> @@ -1522,10 +1481,6 @@ static int psp_hdcp_load(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_copy_fw(psp, psp->ta_hdcp_start_addr,
>>
>>                                   psp->ta_hdcp_ucode_size);
>>
>> @@ -1543,8 +1498,6 @@ static int psp_hdcp_load(struct psp_context
>> *psp)
>>
>>                               mutex_init(&psp->hdcp_context.mutex);
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> static int psp_hdcp_initialize(struct psp_context *psp)
>>
>> @@ -1579,7 +1532,7 @@ static int psp_hdcp_initialize(struct
>> psp_context
>> *psp)
>>
>> static int psp_hdcp_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the unloading in sriov for now
>>
>> @@ -1587,16 +1540,10 @@ static int psp_hdcp_unload(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_ta_unload_cmd_buf(cmd,
>> psp->hdcp_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1665,7 +1612,7 @@ static int psp_dtm_init_shared_buf(struct
>> psp_context *psp)
>>
>> static int psp_dtm_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the loading in sriov for now
>>
>> @@ -1673,10 +1620,6 @@ static int psp_dtm_load(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_copy_fw(psp, psp->ta_dtm_start_addr,
>> psp->ta_dtm_ucode_size);
>>
>>                 psp_prep_ta_load_cmd_buf(cmd,
>>
>> @@ -1693,8 +1636,6 @@ static int psp_dtm_load(struct psp_context *psp)
>>
>>                               mutex_init(&psp->dtm_context.mutex);
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1730,7 +1671,7 @@ static int psp_dtm_initialize(struct psp_context
>> *psp)
>>
>> static int psp_dtm_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 /*
>>
>>                 * TODO: bypass the unloading in sriov for now
>>
>> @@ -1738,16 +1679,10 @@ static int psp_dtm_unload(struct psp_context
>> *psp)
>>
>>                if (amdgpu_sriov_vf(psp->adev))
>>
>>                               return 0;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                psp_prep_ta_unload_cmd_buf(cmd,
>> psp->dtm_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1816,11 +1751,7 @@ static int psp_rap_init_shared_buf(struct
>> psp_context *psp)
>>
>> static int psp_rap_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 psp_copy_fw(psp, psp->ta_rap_start_addr,
>> psp->ta_rap_ucode_size);
>>
>> @@ -1838,26 +1769,18 @@ static int psp_rap_load(struct psp_context
>> *psp)
>>
>>                               mutex_init(&psp->rap_context.mutex);
>>
>>                }
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_rap_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 psp_prep_ta_unload_cmd_buf(cmd,
>> psp->rap_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -1982,11 +1905,7 @@ static int
>> psp_securedisplay_init_shared_buf(struct psp_context *psp)
>>
>> static int psp_securedisplay_load(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 memset(psp->fw_pri_buf, 0, PSP_1_MEG);
>>
>>                memcpy(psp->fw_pri_buf,
>> psp->ta_securedisplay_start_addr,
>> psp->ta_securedisplay_ucode_size);
>>
>> @@ -2007,25 +1926,18 @@ static int psp_securedisplay_load(struct
>> psp_context *psp)
>>
>>                mutex_init(&psp->securedisplay_context.mutex);
>>
>>    failed:
>>
>> -             kfree(cmd);
>>
>>                return ret;
>>
>> }
>>
>>    static int psp_securedisplay_unload(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> -
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>>                 psp_prep_ta_unload_cmd_buf(cmd,
>> psp->securedisplay_context.session_id);
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>> psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> -
>>
>>                return ret;
>>
>> }
>>
>> @@ -2552,10 +2464,6 @@ static int psp_load_fw(struct amdgpu_device
>> *adev)
>>
>>                               goto skip_memalloc;
>>
>>                }
>>
>> -             psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!psp->cmd)
>>
>> -                           return -ENOMEM;
>>
>> -
>>
>>                if (amdgpu_sriov_vf(adev)) {
>>
>>                               ret = amdgpu_bo_create_kernel(adev,
>> PSP_1_MEG, PSP_1_MEG,
>>
>>                                                                          
>>                 AMDGPU_GEM_DOMAIN_VRAM,
>>
>> @@ -2709,9 +2617,6 @@ static int psp_hw_fini(void *handle)
>>
>>                amdgpu_bo_free_kernel(&psp->cmd_buf_bo,
>> &psp->cmd_buf_mc_addr,
>>
>>                                                   (void
>> **)&psp->cmd_buf_mem);
>>
>> -             kfree(psp->cmd);
>>
>> -             psp->cmd = NULL;
>>
>> -
>>
>>                return 0;
>>
>> }
>>
>> @@ -2875,17 +2780,15 @@ int psp_gpu_reset(struct amdgpu_device *adev)
>>
>> int psp_rlc_autoload_start(struct psp_context *psp)
>>
>> {
>>
>>                int ret;
>>
>> -             struct psp_gfx_cmd_resp *cmd;
>>
>> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
>>
>> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp),
>> GFP_KERNEL);
>>
>> -             if (!cmd)
>>
>> -                           return -ENOMEM;
>>
>> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
>>
>>                 cmd->cmd_id = GFX_CMD_ID_AUTOLOAD_RLC;
>>
>>                 ret = psp_cmd_submit_buf(psp, NULL, cmd,
>>
>>                                                            
>>    psp->fence_buf_mc_addr);
>>
>> -             kfree(cmd);
>>
>> +
>>
>>                return ret;
>>
>> }
>>
>> --
>>
>> 2.17.1
>>
>> Thanks,
>>
>> Candice
>>
