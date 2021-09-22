Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8BDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 09:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA32A6126A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 09:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA32A6126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BE26EB38;
	Wed, 22 Sep 2021 09:18:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EA26EB38
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 09:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SccmEwoLOus/b1Rjw8kB+QmhfQGc3qol5vG7KiUWSTqhkgIdmAWR2OaVNusZJmUVow5TFo0GOuHXEQD3SQGbyhuK71UWQh30t4wKYbYRkTzMKB+bxWOSC80dHutDaUCQ9Mr3CE4vWKFan0F+EQWiEIbEE4UuO3MkCaK+jTv0rgiTQjQ1IOsjZNouvWxGQ2P5KeM3T+amTe6dARR2HkkYOQCoFWSVjX8AdXSsC5dDwHfXCwrSyvxdz9waZR1LWNtSYSRl0tbioZs4BE4VuPqwRVgccAvxplPG8gOYbdRtWLPEEUcpDTxK8xEYQ6Ii8C4n40J/a3TyrQP0Hvqr/NqBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c98XIA20BIXOdV6QVBFU/ZszYGp/2LbZIGghreI4BG0=;
 b=Ds6f6HvHzPnzpGdB6jv3Y3Y+lDpBBfq9UOlsco8D4YRnWv2ODOB7UNt9Fqgp0B0q+DR5ssbH83iep6KppgA0VX8H/791o1jEftwE3W3hlkgmyuBf/QIWFPTWfnueBr/D83nQSP94yo3xD2MEHalWqz6w8NflgF16hbuHA/y6SgwZD4Pi6x1FWy7w/ECNlXTlst5EEusMYzDk3VlcBywlORg/0AMN97tJyTi6dgQ7UeWM2IJUUOCjNESI/CWhLZf2ZQHOsxSvmFy+9Uvnvb/CPgNIVh2oUmC1cl9xrAfyQek66Mvd/pScP8h2v6uwVPwGXkC5Q85f5Bsd25uBaqg/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c98XIA20BIXOdV6QVBFU/ZszYGp/2LbZIGghreI4BG0=;
 b=b8x36bYvs66NcpcpboM5R1uPbpgvMwStJ5+NwguU3rqN6niu244x866LEsgESr6vf9f8ex5xUep9noca4XrnB8jgDvMTA4Dk2Dm05B9lAxtfClMe7+siUVAmIxt55RSBhwVhBaWKV7C85ybWzJ1GgyzX1awftmGbNezytciCfK4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 09:18:55 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 09:18:55 +0000
Subject: Re: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-10-alexander.deucher@amd.com>
 <54ac4a03-2858-6289-6b32-128f65334073@amd.com>
 <DM5PR12MB24697A6907D44E8EEB3343C9F1A29@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e4fe477f-fe1d-e296-94f4-e9475ff001df@amd.com>
Date: Wed, 22 Sep 2021 14:48:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB24697A6907D44E8EEB3343C9F1A29@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::15) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0005.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 09:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e9e25f-a3d0-4a5b-e3e9-08d97daa0037
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3017E627BC043AAB8E085EA797A29@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Xn1Qxgsv8iLw6n0GAoj9lOP4ptyjZEIH0pjyti9S1OOC0x0PMAYir6zc10+aE6lFQX3Kj5bzVgUKtEtVS/8XgCINEKI91/drkIhwSck2fBwYJRv3/XbP1qN7A+wmuRHQnPa4K04C5R1GsDMmwNaZILQ2iyB3+jNRSkFbRKqtdufnd1DQ5vYYNwB1g8QiGvFl4rY8jiXwxFELqb4Ft6enBRh/9ap1MUZY9y4NJ1bcgsWWLPmPsKe6YY/nv0Olfgl3wNqZLJq3DseCdUgeUS5R9zG8flHNvgx+ZFuZ3V+zdQ9Hpgkq40MS5DUDvPyTibLApMqz9DTpI243+5QvcO/tnivvH5FjIKXeG8ak2WRKsVkOURr0OkH5OsIzqey7WmgIK3FfpIveVSmwXGYhfnip69WGk3/aexhY0YII7D1nEbJY+/HvYNIiX3MEC5AktY2afcTdqw3vfq/vlfvY/F84HUOl7mCsSE008U02spidbYqr36IY+e9toW6mdnQrJIr9YFnbSEtmAAKgZu2ftDFY1bpZyBbT/FWlj3mxHxNN/39RTjQu+/ed+24FtrXEFnY4qZx+ZDSbZGHRhywBqeGSye1hmRImbuw2raD7GbHm05aRJe6LIkLAyPqCZgvPzrjx2lOF4zk6m4z+FdeOLXiEyLh1oX+ZM0x8/UCOFhJfOuHzZCNKezOQNoaf1CDY6SmCa/l4CJRrllehG1qX7x+qi2awb/fcP0O+tiBzNC5tn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(316002)(83380400001)(508600001)(8936002)(6666004)(26005)(6486002)(31696002)(5660300002)(66476007)(36756003)(186003)(31686004)(2616005)(66556008)(110136005)(8676002)(86362001)(38100700002)(16576012)(956004)(2906002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZMeVh2SG12QUhjUVhVSUgrbWVxUDZhMXdHcUdVNzNuRk41Mno1NTdHeWYx?=
 =?utf-8?B?aWZTRlZhdW14ZHVLWFp6SW1iK1RJUm1jM2RiUVFSTkI3MUduRWl4VlVCb1VC?=
 =?utf-8?B?Wk81RS96VVFNSmR3Z1E1dWFYbkppUUwvanAvSVQyZWZGVEh4NjhZMkVuVGQ4?=
 =?utf-8?B?UUtTQ1lwb09XOXluSkt2bGg3eUhLaWxocklYV2N4aW1uVHgzdnZ1YjgzL2gy?=
 =?utf-8?B?UEM2M1BsR2lEb3g5Z0orYWF5UGszWDlrRDkrRExhOXliSFkvdFMxYlY0dWdx?=
 =?utf-8?B?bThBU2thMzVGK3RFMENpVTlIUUg2aTJJRkdHZ09hc1lMQkRnZGVXQ0R5cW03?=
 =?utf-8?B?MkxoVUhRTSthTGMwS3BtWmoreWt2K3d2QTNDNzlWOGFuWmdZM2o1TzlGK2E1?=
 =?utf-8?B?RlhlRlU4Qy9sK1NEQy9uZ3Rtb3MxQjdFLy95TXEzdUhqeEdPcVkvekRNSndv?=
 =?utf-8?B?dFZxRFovSDlWdS9CRWNMbDc5Vi9YN25oNDZOOHJ3OUZDY0VDdTVmRFdmQ0Vu?=
 =?utf-8?B?UFRSTzZFN09yMHNGSmoreXgvcWM1Kzg3Q3JYTUZaOE1LQnROZExZd2tibXVM?=
 =?utf-8?B?WlRZWUpqL05vc2w5L0ZxQW1yVDY2dm9HUkVWb0NjSGdneEJ0L3lZeiswQlVC?=
 =?utf-8?B?YW43RkdUVk5ZeGlTRHpvbGg0V2hNWjBBNk1jNERBQnJLZkJORExkREVxMmt0?=
 =?utf-8?B?RFlDa2hxQ1RiYngwTCtuSE5CcW5Sb3VOTTg0cVZKY0pKdjJEU0xHUlpkOHd1?=
 =?utf-8?B?RktHMlF2em8zY1ovSURPcm9GMEUxY0w3RmJIcjkvM0VaYTdtckgrRHNMQTFm?=
 =?utf-8?B?OVlaTXNkNWdqT2Z1YVJsMFRPMGRmaVc0bGlVMDhYTUV0TEdPTW90UkVOOVox?=
 =?utf-8?B?VWV4eWtoU1hxUUtxdGkyQkliQ3hZUURjc3ZIWmFLNXVXbUY3eTF4ay9RYXYr?=
 =?utf-8?B?cFNFSFltWlI0S3hVeWE1TkFKaUpRMXkwMmZPZ1BuSHFOaDEvWjMzbTJWTVRP?=
 =?utf-8?B?Yy9KbzBXaXd0emVXVDNvRHk5am9LRjFMbXd3L2tDNDhweU5HTGZXWGZHRlgx?=
 =?utf-8?B?RXk4cG9DeEVkdE91Qld0aWVtMTZLQWJKZDFYWk1YNXpzNG9OV3R2R0licElV?=
 =?utf-8?B?KzJwbk1vaW9TQnJKODA4aUtGajFHa1FSdlhjTkhjYmJFRmFQV253YjBwekUx?=
 =?utf-8?B?K0pmMnVOQ3QvWkYxeStlT3pNRDRoY1JTRExFWGlnRW1OZ21mWEpzMjI3Y3Ew?=
 =?utf-8?B?MEJqc3I5MCt4TDMzWWtWV2J6dUdoY25UdWhKM0t4NVZxOGJwRE1jaFA5T3lj?=
 =?utf-8?B?S3dSQi9Yekd3SU1XemRoVFdoRC9VaXZoQzFhKzlYSFA0LzFHRU5CUzJ5ckll?=
 =?utf-8?B?UmxyUUNrd3dZN01LcUVnSkZ2cWJ5VkF6dHUwbnNBZ0ZVbnVJZzVIMXNtOUpq?=
 =?utf-8?B?aWxYR3ZlZ3ZNODVVT3R4YlFtR1U1Z0NmcEdBdWtmVEJ0eTZRMlFDaU4zT1Ew?=
 =?utf-8?B?eXJVQ3ZLd0ZxSjJuM29pZ0txdkp6bC90aWxhYjZNdm9ISC81R0ZlZGx6WmNs?=
 =?utf-8?B?cUNLNTgwckVOU2g3ME9TaFd6WjVzNUlTTmNBVlRScG4xTHNPRmRsT2lOQnVt?=
 =?utf-8?B?Z2tCaXZxWjFrVWN6dkMzY3R4QjZkNHFKTEQ3OGF0ZFo4SG1OMU1vNUM0RWRZ?=
 =?utf-8?B?eEVyeDEzdUViRnl2L1FTOHBrQk1kaGZwZnFBOEtLd3h2Mm5TeEZqdWMxQTg1?=
 =?utf-8?Q?XclNhS4eTCH7LtnR5WG9RWjC750xEgxjd6RqnFH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e9e25f-a3d0-4a5b-e3e9-08d97daa0037
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 09:18:55.4039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QcTEY8gOKYKUiBwgtNtEYtLvEOBGMa5CFt4L0afwahFh32pfhUJF7i5W57KlVzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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



On 9/22/2021 11:38 AM, Chen, Guchun wrote:
> [Public]
> 
>> +	switch (adev->ip_versions[SDMA0_HWIP]) {
>> +	case IP_VERSION(5, 2, 0):
>>    		adev->sdma.num_instances = 4;
>>    		break;
> Isn't the instance count also expected from discovery table?
> 
> This will be addressed in patch 54 of the series.
> 

Thanks Guchun! Saw that after a while :)

Alex,

Please ignore the comment. Apart from a few comments here and there, the 
patch series in general looks good to me.

Thanks,
Lijo

> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Wednesday, September 22, 2021 1:56 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
> 
> 
> 
> On 9/21/2021 11:36 PM, Alex Deucher wrote:
>> Use IP versions rather than asic_type to differentiate IP version
>> specific features.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 48 +++++++++++++-------------
>>    1 file changed, 24 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index e4a96e7e386d..c5252f12eee9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -136,23 +136,23 @@ static int sdma_v5_2_init_microcode(struct
>> amdgpu_device *adev)
>>    
>>    	DRM_DEBUG("\n");
>>    
>> -	switch (adev->asic_type) {
>> -	case CHIP_SIENNA_CICHLID:
>> +	switch (adev->ip_versions[SDMA0_HWIP]) {
>> +	case IP_VERSION(5, 2, 0):
>>    		chip_name = "sienna_cichlid";
>>    		break;
>> -	case CHIP_NAVY_FLOUNDER:
>> +	case IP_VERSION(5, 2, 2):
>>    		chip_name = "navy_flounder";
>>    		break;
>> -	case CHIP_VANGOGH:
>> +	case IP_VERSION(5, 2, 1):
>>    		chip_name = "vangogh";
>>    		break;
>> -	case CHIP_DIMGREY_CAVEFISH:
>> +	case IP_VERSION(5, 2, 4):
>>    		chip_name = "dimgrey_cavefish";
>>    		break;
>> -	case CHIP_BEIGE_GOBY:
>> +	case IP_VERSION(5, 2, 5):
>>    		chip_name = "beige_goby";
>>    		break;
>> -	case CHIP_YELLOW_CARP:
>> +	case IP_VERSION(5, 2, 3):
>>    		chip_name = "yellow_carp";
>>    		break;
>>    	default:
>> @@ -174,7 +174,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
>>    		       (void *)&adev->sdma.instance[0],
>>    		       sizeof(struct amdgpu_sdma_instance));
>>    
>> -	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
>> +	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP] ==
>> +IP_VERSION(5, 2, 0)))
>>    		return 0;
>>    
>>    	DRM_DEBUG("psp_load == '%s'\n",
>> @@ -1209,17 +1209,17 @@ static int sdma_v5_2_early_init(void *handle)
>>    {
>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>    
>> -	switch (adev->asic_type) {
>> -	case CHIP_SIENNA_CICHLID:
>> +	switch (adev->ip_versions[SDMA0_HWIP]) {
>> +	case IP_VERSION(5, 2, 0):
>>    		adev->sdma.num_instances = 4;
>>    		break;
> Isn't the instance count also expected from discovery table?
> 
> Thanks,
> Lijo
> 
>> -	case CHIP_NAVY_FLOUNDER:
>> -	case CHIP_DIMGREY_CAVEFISH:
>> +	case IP_VERSION(5, 2, 2):
>> +	case IP_VERSION(5, 2, 4):
>>    		adev->sdma.num_instances = 2;
>>    		break;
>> -	case CHIP_VANGOGH:
>> -	case CHIP_BEIGE_GOBY:
>> -	case CHIP_YELLOW_CARP:
>> +	case IP_VERSION(5, 2, 1):
>> +	case IP_VERSION(5, 2, 5):
>> +	case IP_VERSION(5, 2, 3):
>>    		adev->sdma.num_instances = 1;
>>    		break;
>>    	default:
>> @@ -1547,7 +1547,7 @@ static void
>> sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
>>    
>>    	for (i = 0; i < adev->sdma.num_instances; i++) {
>>    
>> -		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
>> +		if (adev->sdma.instance[i].fw_version < 70 &&
>> +adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
>>    			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
>>    
>>    		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) { @@
>> -1584,7 +1584,7 @@ static void
>> sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>>    
>>    	for (i = 0; i < adev->sdma.num_instances; i++) {
>>    
>> -		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
>> +		if (adev->sdma.instance[i].fw_version < 70 &&
>> +adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
>>    			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
>>    
>>    		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) { @@
>> -1613,13 +1613,13 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
>>    	if (amdgpu_sriov_vf(adev))
>>    		return 0;
>>    
>> -	switch (adev->asic_type) {
>> -	case CHIP_SIENNA_CICHLID:
>> -	case CHIP_NAVY_FLOUNDER:
>> -	case CHIP_VANGOGH:
>> -	case CHIP_DIMGREY_CAVEFISH:
>> -	case CHIP_BEIGE_GOBY:
>> -	case CHIP_YELLOW_CARP:
>> +	switch (adev->ip_versions[SDMA0_HWIP]) {
>> +	case IP_VERSION(5, 2, 0):
>> +	case IP_VERSION(5, 2, 2):
>> +	case IP_VERSION(5, 2, 1):
>> +	case IP_VERSION(5, 2, 4):
>> +	case IP_VERSION(5, 2, 5):
>> +	case IP_VERSION(5, 2, 3):
>>    		sdma_v5_2_update_medium_grain_clock_gating(adev,
>>    				state == AMD_CG_STATE_GATE);
>>    		sdma_v5_2_update_medium_grain_light_sleep(adev,
>>
