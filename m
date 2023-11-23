Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD77C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2073A10E18F;
	Thu, 23 Nov 2023 20:18:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E0D10E18F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZK2+cqYLZQHCrOlPmglW2IQya1nR1sAYdoIzh1/is2PHkoOoBQt2v12vUYyShsha/X54jU9rY91yw8NEsuS1QPGqBFzVtPI+O2zXsHuBJ97KaleLnZTEANxckHmnP7O5HR2ovtKyExL8WqaTbJrVQYr/HpUE33riMugHMBR3H04gol8RMGnUM+gzjMT8UPhXY2oX4yPIHUhCrBKy/oQU+eObTCy0GijPi8hGVRmuw2Oa0rlqpdmpM8QNQk01p5P5sROp5R+T6K4FtNVHXwvESXBq88MWfPvP3hjmJB4Wytmc8v98ilM5eLeehrq/0+FUiGXBt+2O1fIkNZ+Z/GEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkLvp5EKK5NKnGZPrSOoI4jC/Q2WDlvfTmhKVfAFYoo=;
 b=JRYLazp733k/4thV5EMrY1QIjCoNGGB7H0cRrLwQcQJUNuV/1dOihcnTVdIbMxzmjUzLDPaaybnnrclcQetvgyXUvvfZfgGcONX31EK1ABSh1AcFRdkCTyqhZusecOgj6EvxLNrqxY9rFoTo6jnFBrbc6Jwlbyxrf+pjA6vcdXA5cxv/mg+KBX8bXwl5d7+ek/ET+5c8z4gq/zxUBshLQyke/RindtEp1IgGRd2+eZOylLRc+QRUN4xm95XFLaCv+R9qTUOfVIJY4JjTZ4ms3RX4RfKyK1IxS9/+vOzWXYHyr0dnnt8uWCzz9smUkSQ1Dw2r1Yh/PpQ6ppEoZ0eRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkLvp5EKK5NKnGZPrSOoI4jC/Q2WDlvfTmhKVfAFYoo=;
 b=yrIJwvV3/mEimQRcdl5wUINxhd54wItXK2X76qcLmL1W3M3Pe+iZR0YkW6TGOC3tcEJUwhlk56fdsnmfTOozcUPlsiTSjyq3TTJd8nIhBOBaYb4L939gd6VfNw4YqEm/wdz9Z3ZDldisNGaTPdhKIJbCt77dlumLRqRd1Wu5AEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 20:18:08 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 20:18:08 +0000
Message-ID: <3fc881ee-06c5-4b67-bc0e-a19da4f1919c@amd.com>
Date: Thu, 23 Nov 2023 15:18:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-8-James.Zhu@amd.com>
 <8a4a1994-f92c-407d-8e12-4466b27ca53f@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <8a4a1994-f92c-407d-8e12-4466b27ca53f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::20) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fca0da7-995f-447f-eaa7-08dbec614eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzSA0tEMiWY3jSQqbzc2xFsuFBlNtAGKbVfeihE+Yhvfb9uva+Uv/kzhpwTGPj/Vo0xOv13Rt5hNviivFVDPrTNpyLK7FloOcU71NgQ/o9iidn6GNMzk7GvjH9YYAZ7RCW9DRddaRbEXb2RqzWhvh7/txF+osd8NrpalW+t17s4SAZmQsOnceAeF9/9xuxSt2ZYvgUkJH8SU4NlNnAxOb6THovH2DQTaGRj1jUpmOOZ/GUEPtuAd8/dQ/L80aopz54x2xU54ts6zsN1DZMeU3tv5O311VUy62TTU/u9C6u+Uj4RALXR5rIQQhYZk/xyFon1NA/3Yk+vLaFPtPLBBpcmm9lMTR/ywTxSBlHNk26aQZA76Y2jMhNvIWtGXb94YFeRMjLRSvETXDTlmGPIpSiDWewTocN3PZznmc4mmSc4JOnrF2G/UKIww0aDkJB4q7JitX4cLIuBChmBUd/ydPyPwLvYHmsv37QIw3cpYBn7CFY8T/eAnPuyIvvE9H3+rbockLsGLAOQQU/56ctqrqOAHCE/5OpvgqIKzASGu+ViMXMRRa0xD1G0zrVYkMejHlDn4RhbwpApqgQMT4BAoEOB+dlGHlwTSBgBFeeiqxf3XzmE+L//EG8iU6Qki+15mgHuhIGweTAyiwprZedhZjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(38100700002)(36756003)(31696002)(66946007)(8936002)(8676002)(4326008)(66476007)(316002)(66556008)(41300700001)(110136005)(5660300002)(4001150100001)(2906002)(31686004)(36916002)(53546011)(6512007)(26005)(2616005)(6486002)(6666004)(478600001)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9DTWwzb01xaVFCaHd0Uzh6eDBWbzRoaDloeCsyK2hKV0R2eVZHYUtkN1RP?=
 =?utf-8?B?cGl5Q3lhRmZTVm1mNUpRQWlnR0ZsRE9xOUtlNjRHczhTMzRWaEVvRUhDVCtl?=
 =?utf-8?B?S3hoZ0p5bjNVbk15MW4xejZtdmlOM0lZNW5IYzNvRE05NEZUT1AxU0k2aFla?=
 =?utf-8?B?S3JGSEYxbVRlaHdidGxpTVlwdFRrbXlKdEs1VlFpVkd4MGJweDlPN0tPeFBN?=
 =?utf-8?B?L1RVUXpQb2VmcFBhRmgyMEZ0ZDZsMTBZcDljWFBBVG81ZWVtampocnAxaGJX?=
 =?utf-8?B?TkV1YWsvdjBaTU1QLzJESktTdWFDZUZFL0Z3V21OQ0k4UVhWWS9pOG9aYjZy?=
 =?utf-8?B?dEdLZ2JjaVhsbTlHZjBhVmdUWWZCa0c4N1pYUFNVTEUwU0VwUmEwNmhmay9w?=
 =?utf-8?B?WXVSUm9seVVVTDljWjFwUS9tdVNXKytSMGtQaDA5Y3JBK0REUXR0VENOdkhr?=
 =?utf-8?B?UDY4ckNSYnh1amhmZ0VOUE1MZ2hWVXlPMGUzalFmRWNsRHFYaWJjaXp3QkR4?=
 =?utf-8?B?OFlFb0VMNlhRM0EvMm1xdWdiMlRUNFlHMWh5c0IvRmhYZFAwZXVUcHVLS3dr?=
 =?utf-8?B?bjhSNlgvV0Z6WXBQYWJ5MDIyN2FpcnA1dktlZjdFTFZiSmxBSktSOXF1M283?=
 =?utf-8?B?VjBQS2Q1L2ZGaTlrVWNxZEdMY1dKTS84QVJrMC80eFR1ejBwenZVVVlpOUVv?=
 =?utf-8?B?L3dRMFRXcU52NVlZV1Bvb0I5QXVJUWNhZk9leXJqWkxRSGM5MXFMWU4yOVor?=
 =?utf-8?B?MVJka3FWZS9sMkV1cFc0MVZqbGFSSGNYWm5iMDQrVHY2YjNwZS9uNWtqQWJq?=
 =?utf-8?B?andCRHFJSXNjS3pST2NpOUJjNVJnMHJvc2tCdlNwNXZ0d3E2WC90VHgrc0xJ?=
 =?utf-8?B?a2VJNXp4bkFjaUlWK3M0Z0F5OSt1b2U1ZlZoMDVoOVVseFN2T28rSFY4dDFN?=
 =?utf-8?B?VUlIUHZVVUNCUVdQblk2a3BlY2RPbjVFRVo5ek1XR04wc2lBNm1JbE5wUllO?=
 =?utf-8?B?eXpucVdFa0MrTE05bjl0SThmc2RhQU15MkVGM0c3VjUzdDh1YWtOMkZsNVkz?=
 =?utf-8?B?NVVpV2dPMW82Z0diSzN3ZUVtQnJNZHlMci92dXJ6aEFYNkJ2WlBoK3VIclQv?=
 =?utf-8?B?SFdNTFlkN2ZJUjduNGxnK0ZxSm9hTGUyR1IwZmRBQXlTWXR4VmtLSGM0VzRI?=
 =?utf-8?B?SkJBcHR2VnZRR0x1QUp2SE9GNVFwV3JZV3BLalJEY0hCbnFVUG5QaDNrc0pY?=
 =?utf-8?B?eXd1a2RRamZqeXpjUTQwTERZcUV6eHdQdU14OEtkTlAzZjd3UlpMUVprMmF2?=
 =?utf-8?B?OUlpZzlYTHpjZWFpMFF4WExrNVdSVW5EQ3NyUldvbWM4TGtJWHF4bk0rL24x?=
 =?utf-8?B?WTR2eHZiWlh3ZnV2emtPYXZMOXR1aVh1MGc2T1pDRURkRlk0OXlKWkNSMUZX?=
 =?utf-8?B?TGp3aFBJeGIxK1R1aGRwRUNadU9Wc1RURGJJMEpKSGdydGRKTFVXQmpSeGNh?=
 =?utf-8?B?VmR3S2J6SFl0TUdGa0dScERBbzNSdk91MU9aMGZZRGdFRm9EUldkWFlGWkxJ?=
 =?utf-8?B?ZkFvb2xDUHo3Mkc0enZSM0xXZmRWLzRuVU44VVVSRHhYYlg0a1daVGFFMmV4?=
 =?utf-8?B?WktTNExUWFRYYXpQanhPVmFqb0x3ajBIRU9HZUd4VXkyd0ZlaGNqaUwzS3Rl?=
 =?utf-8?B?Z1h0VW5xNTJWeUt5Mnh3b2FXUzZtdnkrRFdtbEJEenJWWFhWaVplSndWb1oz?=
 =?utf-8?B?MXlQYzRLZmIrQy9BT1Y4L1YzeDdEdVVSSEplc3VzMkZ3aG5ZVG5jSDdLNW9s?=
 =?utf-8?B?TWhyTllxRVFLVytHZU5vTm5EN2pPS1lIRi9zZ0JGejlNbTRHek1yOGk0eEJY?=
 =?utf-8?B?REM3eEV5cW8rL3hyRTE2ZlVJNlNYSGV6OXNPZDhIMU12MlFENFBOd0dMSytN?=
 =?utf-8?B?bjcwZWEzT1ZJNnFSQ0Y3a1ZFR3R3cENqTHFqckUra2piOWRqWWE3YWYzM0Vz?=
 =?utf-8?B?NHpRZXpRN3Z2aTBKaDZmVTErVzl4S090eVRHK2VkUXU2Q1ljN3J4cFFuRVMr?=
 =?utf-8?B?eXFPT2lRc0lvMG14RDIrKzFhTGo5SFVva25iV3Zwb3JKNkNjdkJsSEJaN0RQ?=
 =?utf-8?Q?PhXpk850Y0/0eXvVCvIApqote?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca0da7-995f-447f-eaa7-08dbec614eab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:18:08.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck2HQvc/XHfwc/MShx1RYrUvTGK3z8v/PKZ2HWSWo6nWHX79hM6835uxzFL/CLG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 17:15, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> Check pcs_enrty valid for pc sampling ioctl.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 ++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 4c9fc48e1a6a..36366c8847de 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct 
>> kfd_process_device *pdd, uint32_t trace_
>>   int kfd_pc_sample(struct kfd_process_device *pdd,
>>                       struct kfd_ioctl_pc_sample_args __user *args)
>>   {
>> +    struct pc_sampling_entry *pcs_entry;
>> +
>> +    if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
>> +        args->op != KFD_IOCTL_PCS_OP_CREATE) {
>> +
>> +        mutex_lock(&pdd->dev->pcs_data.mutex);
>> +        pcs_entry = 
>> idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
>> +                args->trace_id);
>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>
> You need to keep holding the lock while the pcs_entry is still used. 
> That includes any of the kfd_pc_sample_<op> functions below. Otherwise 
> someone could free it concurrently. It would also simplify the 
> ..._<op> functions, if they didn't have to worry about the locking 
> themselves.
[JZ] pcs_entry is only for this pc sampling process, which has 
kfd_process->mutex protected here.
>
> Regards,
>   Felix
>
>
>> +
>> +        if (!pcs_entry ||
>> +            pcs_entry->pdd != pdd)
>> +            return -EINVAL;
>> +    }
>> +
>>       switch (args->op) {
>>       case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
>>           return kfd_pc_sample_query_cap(pdd, args);
>> @@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>           return kfd_pc_sample_create(pdd, args);
>>         case KFD_IOCTL_PCS_OP_DESTROY:
>> -        return kfd_pc_sample_destroy(pdd, args->trace_id);
>> +        if (pcs_entry->enabled)
>> +            return -EBUSY;
>> +        else
>> +            return kfd_pc_sample_destroy(pdd, args->trace_id);
>>         case KFD_IOCTL_PCS_OP_START:
>> -        return kfd_pc_sample_start(pdd);
>> +        if (pcs_entry->enabled)
>> +            return -EALREADY;
>> +        else
>> +            return kfd_pc_sample_start(pdd);
>>         case KFD_IOCTL_PCS_OP_STOP:
>> -        return kfd_pc_sample_stop(pdd);
>> +        if (!pcs_entry->enabled)
>> +            return -EALREADY;
>> +        else
>> +            return kfd_pc_sample_stop(pdd);
>>       }
>>         return -EINVAL;
