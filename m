Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84392C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 21:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264D410E5D0;
	Thu,  1 Jun 2023 21:00:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C72410E5D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 21:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHI88DsEgC7OfDqDNioYWUYoPuojTRHDoRDEwdjBrsbAO+7jK/zYFMsSrEBdv/oDkLDQZbBCKEclnUG3xf/avO8Sp7G3dYECaDa3gjfwJatNUU/zP4v9m0Yn3lRiVxcSrakz5C3n4E1dz0fb9FrVTt1ardQiiww6ry1vVaX7mfel/2MXIyLkoHbUR+bR3dcqx6/cQ8woxgJ3/W2pzTNaoa2wJUqk0lX+d90DzoOStwsYkQoVIVhSza69LQgb0tVmF593xJSMeZqzVfXP/SNZIFnyaum/+QkuSj5ljJS8CMj9ZitN5rVK5ub60eZD1akNv2qZQiaVSj4ixoIeCSIwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNMXTdjLpNf+T1V3mDSd0Vx31wDvbdx/yfl6ZMG51rI=;
 b=a9aRoZae5k9a5lBb21QXqTFiD3V6D0kq8XYckJ0Y1QgWo80pHDjlpQdCK5/bKAtGgC+/GQ1dmbzirPIGZ3URO+RM1JjwurL5v3PNSxxfyYlnjhxKdGiqk8Mc5RI2dDvDo8otTWTjw+rAnmgt82/QpONbi/1qyyf9VeJt7DdJ4TaXu3YMWYBJVLtcYHHuL4LKWrM3fQ/67gvNhjt8pE5g3RU5T63xLznSEa3jGOwea79G9OUxZstlETmuWXrmOtfR/d2xb2peTSmL7z8PZy0sWU6AjAAPtk4tXG8J/CwPb2FasELIcjNKHkqtJipF0YorXP3xlXhDrUEA1nk0/6sNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNMXTdjLpNf+T1V3mDSd0Vx31wDvbdx/yfl6ZMG51rI=;
 b=Wt7u8tDiDRdAAZlc0Jv0P5ngjmLqOLquR0t44MMCSZ4TgBNtrcsxDhZR2KJ98BTM0hXgq86pPNL4v+XbWbg4WTTamDAWq/TCL6aVXhiBSTVl/A+mBEc82lCFP6Jq10oC1qc6ByX5kf3Xa1erDEU95BX7I17WSZny530O8v3xrPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 21:00:11 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 21:00:11 +0000
Message-ID: <a3ee1d1e-08c3-0f70-f045-61981fcafcf9@amd.com>
Date: Thu, 1 Jun 2023 17:00:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add event age tracking
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
 <17389962-dd68-fbc5-c523-0b47d9381a8b@amd.com>
Organization: AMD Inc.
In-Reply-To: <17389962-dd68-fbc5-c523-0b47d9381a8b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::31) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 081136e4-ab2b-49c5-b6d0-08db62e330a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhNMkDpi0GHGWuDAyjXA5Y+81dQFadDYqevc52kpDVLsIxpmExv+7GGQPPlrRlUwx72qKYa8vnLCBzDThQJWc21Nbto+ChQTyxbseu6r31jVeQibg3v/ucE04mCGn7C6szMQggptLo44+5oEUTaZmLH6jYFymRuYH+OS34oRByGUM5h/TrXgrcYoX9XXfpHy7CnNYaoY6wejFmz57WTtr6txo5HXmb97yo5QUeAah/tFEPFaQDKIhEHbX613GAlQewLftH6ibiih5bhkuKSU2e4hSA4rO5J3lXiwynqlwU6EJfSbi5K9mGxsIjHwwk1vYfYDrpCZSYUrK9TCMeYd3Rg3wfL57FUe33n10izobokjLuI5vchS+dNXSO/i3XJRvasGp2S5goksUkBgifmeIA1zuUFRBUdUNyaIBTjw5eYLVEX7mIQj26xsqt/k/l3Pn96WY3kNqppUGfxxTr+b2AAvi9twkjc66xdTzWlv6V2biTB5Fmb5c/EYHV3pewgckFWLcnXaSrb0d/T0AnouJ1ZqV6DUWBT/WwJb6jGVUjC8fo9q82xbigFcbMIVdedih96ecyPt1EFaI68xXc6D126Sn3EcWuC4uCJa9DR+nHV4oXOzMK1MkkbPM1ezU1BnVX9Jwrz4RD0zh0eIF38OiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(478600001)(66556008)(8936002)(8676002)(4326008)(66476007)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(36916002)(6486002)(6506007)(53546011)(26005)(6512007)(86362001)(31696002)(44832011)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTV4ZTNseTR4OUM3elpjRDJ3bVNPUjVRT2NXU2pldXFpVG4vSlZSRjUwYWRX?=
 =?utf-8?B?bkgrTjBoeDNCbDcwc09pOXcrUnp4VGxmZ3l2eUtZa3ozOFZtckQ4dzNtdkl6?=
 =?utf-8?B?eUdSTWN3akZLc3l3dVpxYldmS0dVcHN5Q0ViM29jRUZkdldFWEF6akRtcTh5?=
 =?utf-8?B?bWtMS3BZSEZ0eDV0eFMrNmI4NDZ1TWJ5bFZuTWF6UEpveWtmL2pUZ2s5eG4v?=
 =?utf-8?B?bXNjZlUxOXFJKzNSdmRjZFBJN3haWFBJdll3L1lTU0JpeFk2MTVYODNyNVBQ?=
 =?utf-8?B?cHhwS2RDOXhPdm9jWjBGQksxUEd2SXdydGQ2aGJmaWJLdVhscE53bnVjUkhL?=
 =?utf-8?B?NllrSm50MkpsSWpUb1ltZ0piUTFXOXo5Qmh3bnNJcDYvZ0tHZ0RUbkR5UGdm?=
 =?utf-8?B?YUlSRGc4MEU0anQ0dlhYMjk5bWtVblNqYkF1TjBqMjVkaTdjS3FSeGtONkMw?=
 =?utf-8?B?U1A3UXdtaGtMNEtmQURGVUh5U3JNTHRMZmYzQlpEazhJOS9WdTJtZjlRWHQ4?=
 =?utf-8?B?d3RwY2gvRlNNMnlUb1hBZnBSYU1DSnBTdWdEN1N4QXZDTmVXQkgvNDcxK090?=
 =?utf-8?B?LzVOQTRreG1EcXk4SUswL3RRWTJKRGlXd0M5K1hjY0J0bzZ6R1hjMWdYZkIw?=
 =?utf-8?B?aXBySmtaWnExZ3Y0NTlXWHhPbjNJbCs4RUtVZXF0ZWptZ3pILzZrcFJSWHcz?=
 =?utf-8?B?Y3dWcVlCNTl1K1dRMXRCRVZPcnBUN3ZHTG5GM2pxMExidVdaajkrMUhKMk9a?=
 =?utf-8?B?RHgrT3YxMlBlQVBUQTJKQy9EMVlPL2N0eEx2SkVjTUkzRjRKM1ZXd2wreTk2?=
 =?utf-8?B?bWlIbkpPa1dLV0NpR3IxRkFxYzFZOE1URGlIcEo2ZURsQ29PS3V6V3FLUzJB?=
 =?utf-8?B?cnQxS2NjLzVXZWFnd1QySUxRb3pMcVRGc3Q3UWVKSGk3a25MRExLL2JHYS9x?=
 =?utf-8?B?MU9YTXpjYWFXbzBkOENRc3ZES2dZT09Lb01Qb0U3Yk1lS0FVdnZhL2tMTktX?=
 =?utf-8?B?Rjd3SkU0WlNHMGtOaUdES3dwUWhSTjFkZmw2anhnMVZDSkQvSkZBRU54UVlj?=
 =?utf-8?B?aXNiZ1RXUUlYbEJHYzVMOUNQZjZOcFhRQS96Vm9tZUhib0hOTnZCcldNZjZl?=
 =?utf-8?B?VFFxUUYxSXM5SFVGR0ZKaHJwYlBId1JYaktqS1M0cmFtVDVCdDBKaGUzMTRu?=
 =?utf-8?B?TXZYZ1o0ZGRRdHp5WmcwcmMzaCtQWmJxUEVnMGRkS044cVU3TWNkMEQ1STFP?=
 =?utf-8?B?ZGhleTVIOVFGdjNsQjFkQXV2d3Q0RzR5VktXYXl5NE1mbnF2MGdtVitRUkdy?=
 =?utf-8?B?ZEF1Y3NQaG9rWjR2ZlVtUnR2LzdmcjgyQS9abU9aWE1KQW05MGtrR1RRa0xQ?=
 =?utf-8?B?U0tXTnFpbGhSOUIvaDJ0RVhXQVI1QTNuR0lRcDhhaXlHL1hmU2JMRXhTUFU3?=
 =?utf-8?B?ZitTTjB3TXhRbHMyL2lLTmdxZzViRUFJM2J1QmhZV3ZDNnExSlNlTnRqZjUz?=
 =?utf-8?B?ZWFHTHd3Y2Z3M3NPVzh0aWNHY3pWK2tmRi9VemFRUXRBUmdNZ3NOYzVHQ2hi?=
 =?utf-8?B?a3NhNkZzUEFudWp0bmh1MkZXWkx6ZEdTRm5FNFVBRkIyTlhmQ2FSWC9OTHVB?=
 =?utf-8?B?U1BpSFZvTVJ6TTRMVUc5TUxyOFQvWGY1STdpZExnakRDdTNEakIyc0pmVkE2?=
 =?utf-8?B?aTZPMWo0dWk0TWM5cnVzMi9WMElqNnlxWjdEa2FSS25kZnJnMDNzbWRGdVdF?=
 =?utf-8?B?aEc3YTgyQS9CREdqWmJDeVlQTmMyYU9BdEw1Z1IwcGVqaFRjdzUvYitZT1dL?=
 =?utf-8?B?di9HVlVhYkJXQmNjblB1TnVlajNCV010V2xPOWlxOVVLSW1jTENSdkdpWC9r?=
 =?utf-8?B?b1ZjbVZKUlpFbWo2d3FheHpSbHhZS2xldFJuR2hMMTFNUVhpenZyQ0lHWEs3?=
 =?utf-8?B?NlRZVGdwSTBLNVF3Smd0SmwrNUZOV3FKVnhla2IvV1U2VVhXM2J3S0tURVRH?=
 =?utf-8?B?MjE2aXpndWV4dW5OT0NKakNFc1lZak9zRml0UE4rb3RabDdkQWRnY2ZubTFM?=
 =?utf-8?B?OXBzVDRtMjRSZGtXRkxIMHNiWUtFTFM5dkpIRnFhazlIV3J6eFVOYkxEcjNJ?=
 =?utf-8?Q?rnFx1LM0aHs/jPFA/ye1IdfNz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081136e4-ab2b-49c5-b6d0-08db62e330a8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:00:11.7862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNfzGmshLTZYckfxtutN4wTBJW+p0IN5mMpYUMMiax0PMq8Kuc3DDPgACqBR+ensfREllvOvrNFqZSf0HlOlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We'll also need a pointer to the user mode changes in some public repo, 
or a public email code review of the user mode changes.

Thanks,
   Felix


On 2023-06-01 16:58, Felix Kuehling wrote:
> On 2023-06-01 16:47, James Zhu wrote:
>> Add event age tracking
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>> b/include/uapi/linux/kfd_ioctl.h
>> index 7e19a2d1e907..bfbe0006370e 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -38,9 +38,10 @@
>>    * - 1.10 - Add SMI profiler event log
>>    * - 1.11 - Add unified memory for ctx save/restore area
>>    * - 1.12 - Add DMA buf export ioctl
>> + * - 1.13 - Update kfd_event_data
>>    */
>>   #define KFD_IOCTL_MAJOR_VERSION 1
>> -#define KFD_IOCTL_MINOR_VERSION 12
>> +#define KFD_IOCTL_MINOR_VERSION 13
>
> I think minor version 13 is used for the debugger changes that are 
> making their way into the upstream branch right now. You'll probably 
> have to rebase this and use minor version 14 for this.
>
>
>>     /*
>>    * Debug revision change log
>> @@ -693,6 +694,7 @@ struct kfd_event_data {
>>       union {
>>           struct kfd_hsa_memory_exception_data memory_exception_data;
>>           struct kfd_hsa_hw_exception_data hw_exception_data;
>> +        __u64 last_event_age;    /* to and from KFD */
>
> It would be better to create a new struct kfd_hsa_signal_event_data 
> for this to make it obvious what type of event it applies to. And to 
> keep the union more uniform.
>
> Regards,
>   Felix
>
>
>>       };                /* From KFD */
>>       __u64 kfd_event_data_ext;    /* pointer to an extension structure
>>                          for future exception types */
