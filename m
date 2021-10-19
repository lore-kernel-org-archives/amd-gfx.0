Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C78E60FD8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C78E60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD88D6E7F1;
	Tue, 19 Oct 2021 18:42:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562866E7F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqYPfWQu5cS/J2v00YqTNqGsZOH6rUdifigJMblvitaQKSRr/srn0dEtVToKU8cd5Br4sbeeMWTO3ZxJPaH+Jze8oT6TKcxY7xjMikIbiCXI88byI1ccGGxzFz1qAwartbwVrBSSN31uxDruUR5pO99tOR098/I8s/SUQQhs5NiZbmQVQqiKoSmivSQEjUNo1GE0pmUWGTfO+5Kof+F1EE4k8XfIZCLyr3/heXAcyJurDYJSX1Ox1KESJsz8ETQbMlVx8nsbUsOxjKvG9lhrr1rSSfmLVejlp0swzIz5wD0y8Ve+MVuzge6dbdjEDNi7tNpqtCbArgHVVha4zj9jLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aToJ2K84MM6PJ9fz6pRmbbI9sMIXiMJ9ilnXYzij/YE=;
 b=V/80iWnbcFPPf4SwOrJAp2rV06XVhy33D0bdqBm0y/hU94+yxWm7s8QzxOldGFtNGcAci88sn1yeTr2VKbnGu8uSxrxLBaRB1Gcumn0aOwlzl8dxH/kJVjhoZoI3QGyXrx8hMflklafvVoVbgdls5UejtJRW2MlflF9vlXo5ewARkmELzsMThmdAmOvwCT7eiZrqI8rSpkPMJaAxG2uaVpGf9gVJPUYSGuaGfxY7hJN7O03e4wr4Zog+czL9ktReboPAnJ28g+Kj/WiVQahQC/Y2ASPyNwOw4TmarE3t5fBbYWvAo3T+LZCPujt7T2eEzeN0st8aOTy0a6u+TUs8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aToJ2K84MM6PJ9fz6pRmbbI9sMIXiMJ9ilnXYzij/YE=;
 b=FCUpql43RDWdcMKvgfg3gh08Khb7w6MfDAMRGVPhLKvnsu21/0m7HjOlTRhlz7bFnM3TEu+CAJzMIWBF3iI+g+0ir73lVcuNtd5XE5cm1Khs7w120V84KD6kZ2/EBwOdBE6c2Xkiafr0LfFqSM9zIG2wczA5zCkRo4D8Br9uWv8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:42:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:42:34 +0000
Message-ID: <0414b32f-95ac-1d63-2c8d-ac2f95366e9f@amd.com>
Date: Tue, 19 Oct 2021 14:42:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <c51879d3-5434-d8c1-aab2-471ed1ab6931@amd.com>
 <DM6PR12MB3324F45AD12D4D86590917C585BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB3324F45AD12D4D86590917C585BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 18:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79602c1f-9f43-42a2-0084-08d993303730
X-MS-TrafficTypeDiagnostic: DM6PR12MB4941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB49411A493E2E383F5BC9267199BD9@DM6PR12MB4941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Nc3qg7DR2+maEKHOTjh6AzDWuVy3xnoDTQBBd+TGVpN3vEPBC5D75ZdoOGPdugLj8o4Veq4ECrdfyxPkWWtluZ6j7engzn0xuXByFCUhDpAVxC/vGvPAvSQCMFPpMdw/Jg1BjDPcGDEdaJzH/ctgR9E3L0nClur03uCphjOrb1eUgIlVAF+29QN0Hz9y5XcfGyTHAE70pCPmsbgW1KXeaPfDYDTmZMmY5QAS3Pc85+cV3uDOu8rPho40D7FZSWRTUcr8J5J2G/LNwQly4laNG/vCFApyUlkroBFJdFFjcIo5KuvMoqoT3IOjwL4G9nmzFAXV0yWO0VCVcBr6Zsy2DJbokj03CVFXZx4T1TsUVM51JEqY8zmo9xRdko7bJ8qxX16edcOgoyTci5IIg2UInQweBGnxRUR0L9uwOk/8OMCHw6ZZihTixb5EOM+LvjDcE2DC7j+SS4FyPRR2PQ5kGUdv5rFK5LELyAhj/RWTOLD+ngpgAOaXoKjxA+DjVJCQF5OsQBxBoh2DPmJxJTJFxrC76TAnTvFRyMaOYPW75nHsPZgKfJexpsHQB93ICLv1mOarJJUCNHprrCefKZabQ9OFthbEI4LLv4kCP455tVhnjM9LYCIdMzmt2kbXzHaIBYhlzibUJccX4w5eZ4JuM1aNc0vRZ9cCBGSZrno5lo9lZB0xMaSajd8Ok4uwoaUket5Q0bEyPf9AK6CB0/YMqG8m0tB2cCdjfP8GzRZ0PjKIIUmozWaXdgLJ7z6OIMY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(36756003)(2616005)(6486002)(31696002)(508600001)(53546011)(4326008)(66556008)(66946007)(44832011)(66476007)(316002)(26005)(2906002)(8936002)(16576012)(31686004)(186003)(110136005)(4001150100001)(8676002)(5660300002)(83380400001)(38100700002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlSMWtOa1M4a0Q1TzAyV3JkYXJUcHNRejd5c0NQYytxcE1jY3RJNE1PVGlm?=
 =?utf-8?B?QzRqKzRDdmZSSVdsbG5yU3VGN2JuR2F5aGtjK3d6bFZUcVAxRmxuMHhieGsr?=
 =?utf-8?B?aXdkSjlvcVhRTnlMMlBmTnN4dXNuaHdFbjBFMHdvRGlSZnN5QUhqeXNUNmN0?=
 =?utf-8?B?Y2RMdzhucFpCUWQrVUFHNnJCUnl2VnRrZU9EQ29vVXIzc0dYTU5jcDdpMDRL?=
 =?utf-8?B?ZkxpNU9XdjRyZG5FQVU3Tm1saUtZRDVVRlBjb0VsTXJjOFZKN1I1RTkrT0xF?=
 =?utf-8?B?ajhUZG9oV2pZbEg1VnR1VEx0Ukt6TUVlWXNQS1RTcTlPbGl6cnBFVFEzVXRy?=
 =?utf-8?B?V2oxak9sNUxnQlJkeEttaDhaQXJsS3hBbDFUUFdSU0svZFU0cTd1RmNLSWF2?=
 =?utf-8?B?M2VXZWc1K29sSnBteVl2ZEZRaWl2Sk04eSt5RHVJU3NSMUNhU01kQ3p0bUlJ?=
 =?utf-8?B?VEdRQWw4clcrMjYrcTZ3UEg1VWhvOTMwalB6NWRMcEdGSmVPaXdpUVJQcXRm?=
 =?utf-8?B?MHdWdkVpMjl4MnVrVDJ0V0NzYlVsVWdPcFc4Wkt0dkxxZ3c0aWNEZVdXcVp3?=
 =?utf-8?B?WmsxMWxQOEgya1Z6b1JaeWMzWkZ2cDY2L3dwc2xtTkxKMVBLNWpBbUxyZStH?=
 =?utf-8?B?STlWcFRCdXozNjk4M2FEbWdQOEFIUDdKd3UwS25FdmJVTzkxak9ua1JsSUd4?=
 =?utf-8?B?MkdxUjY3Mk1yRm11M3ZqZ3NnWHNLbHo0RGp4VFppNUJtakVrb1dlcVhnRnhi?=
 =?utf-8?B?MWhqZTNmcVJqanFnbm1Wc0g2WlJ6OTRZbTg1a0FtcldHdmIrZk5DQXNYU1dl?=
 =?utf-8?B?TTdrMXdIeGEydU00NjBPaEFIaGx6RW9aNFdOZHk2MUtPZDNKZ2Q5ODdTMlBx?=
 =?utf-8?B?ZWgrOURNWW82dUlWSy9RMEZPekwySEhrOGxUTTVhZURlRnV2eUk2VEFVcklt?=
 =?utf-8?B?NnFXSjNtZFJzMDJvaTlVRWtIai9FaUxrZ0RCT1V1NlJzQVNEY2laaXp1STNZ?=
 =?utf-8?B?Vk9WMVQxQUdueXg3MUh4VyswdjRPZndYVUR1TXVVL2NxNTRGRlB5RkRvK0Jh?=
 =?utf-8?B?UkMwaXRJbEd5d0sxdEU4T09DOGhxdFZyaDdKM21MekNCMDFjYnZkbUtLQUpr?=
 =?utf-8?B?R0pVcGxCV1BVTDV6V3RtbVZQL3ZodEpvRk8yTUpxa25lK1c4clJEUmJ1K3FH?=
 =?utf-8?B?YUJ3S2txVm5VSXBlTEJqbVZKcWR3dEJCSHNOQms5aE9Mc05PRmFpR05NeWJS?=
 =?utf-8?B?L0JudG5yenlBOGE4S0xzQ2FDMERhSHJoakt4WmpieE1HNkZxa2JWSUF0S3ho?=
 =?utf-8?B?VFAyeHBFcng5Y25lcUZvS3gzR215amFESlZJa3dxby8zcDRFTUttUzQveGZs?=
 =?utf-8?B?c0ZMQXlnQW9CcFdjVDlYR1NwUlNBZWlBWm9SaHZKM2RDMXZCTHpNT1dPMU1L?=
 =?utf-8?B?T3g5UWpLK2JsSWNHN1J3SUlxeDVXc2lleTUyRzRGWkplbGVWOUVWYVpjMEwy?=
 =?utf-8?B?R0VpVEt2a3ZDcDJ3ZjRVc0hnNWtvMFZmeVFsenBHTFpGdWk0T1BWbzR3dWRl?=
 =?utf-8?B?SlhtSWFVdC96a2VIamR2M3NwYkl0NlczMUhPU1grYVk3cXdZenYwNjFYUzBu?=
 =?utf-8?B?bjF0cTVMc21Za0pmbk9UUTFyUExlcUxGYS8zWGRwaHV0MTNlUHEwUTZPc29V?=
 =?utf-8?B?a014ckhCZ0dLTnFHRjdUUmpDNmUvSVUyUFJUTkVsV0hKZDZROXNLWnNrMVRN?=
 =?utf-8?Q?Kggjl+zxGJjn7oNmi0EHhD6e9sT3NwVGoIk6HPi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79602c1f-9f43-42a2-0084-08d993303730
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:42:34.4271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU3+4XLh5+sh/Fd42MjYSrlFd4lYVesxIn7fErXpDplccCes22DNuQwYHFMzIsAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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

On 2021-10-19 14:22, Russell, Kent wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Tuesday, October 19, 2021 2:09 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
>>
>> Am 2021-10-19 um 1:50 p.m. schrieb Kent Russell:
>>> Currently dmesg doesn't warn when the number of bad pages approaches the
>>> threshold for page retirement. WARN when the number of bad pages
>>> is at 90% or greater for easier checks and planning, instead of waiting
>>> until the GPU is full of bad pages
>>>
>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> index 98732518543e..8270aad23a06 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> @@ -1077,6 +1077,16 @@ int amdgpu_ras_eeprom_init(struct
>> amdgpu_ras_eeprom_control *control,
>>>  		if (res)
>>>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>>  				  res);
>>> +
>>> +		/* threshold = -1 is automatic, threshold = 0 means that page
>>> +		 * retirement is disabled.
>>> +		 */
>>> +		if (amdgpu_bad_page_threshold > 0 &&
>>> +		    control->ras_num_recs >= 0 &&
>>> +		    control->ras_num_recs >= (amdgpu_bad_page_threshold * 9 / 10))
>>> +			DRM_WARN("RAS records:%u approaching threshold:%d",
>>> +					control->ras_num_recs,
>>> +					amdgpu_bad_page_threshold);
>> This won't work for the default setting amdgpu_bad_page_threshold=-1.
>> For this case, you'd have to take the threshold from
>> ras->bad_page_cnt_threshold.
> Yep, completely missed that. Thanks, I'll fix that up.

Please also fix the round off, third conditional:

a >= b * 9/10   <==>   10*a >= 9*b

Then, you can also drop the second line, since from the first:

b > 0  ==>   10*a >= 9*b > 0   ==>  10a > 0  ==>  a > 0.

Which shows that,

b > 0 && 10*a >= 9*b
               is true iff a and b are both greater than 0, so you don't need the middle line of the check.

Also in your message, say something like:

DRM_WARN("RAS records:%u approaching a 90% threshold:%d",
             control->ras_num_recs,
             amdgpu_bad_page_threshold);

Regards,
Luben

>
>  Kent
>> Regards,
>>    Felix
>>
>>
>>>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>>  		   amdgpu_bad_page_threshold != 0) {
>>>  		res = __verify_ras_table_checksum(control);

