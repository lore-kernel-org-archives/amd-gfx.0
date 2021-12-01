Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B39C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 06:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BF46E0FF;
	Wed,  1 Dec 2021 06:56:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96806E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 06:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKdEdLeQVesieeB8+MzVr8tONh4W3JacU9HjXJLC2b3/IJ4/ZkelsFvyIIaYY3dLjhwjwQga61ocXIKmaKbCUd+XsU/VYNjxRcNEVg/agIdZUs67HicxquAXzZUdiPsshZfBq+4GElielar3cg7fCIc5hqFnH+yLiItuHAdPFJa76q7EPK8FlYzzevlX1AZnsIrSjZTaq6cVmQFhS3xzIKCGL3/eHbDRgKq/ZihDnLJADPSNkBo64TTdmY0uSKQPaui9lgXFtzb1DzcSwGwNmozNerYNIy0tkzplMtRxRnsoGz+td9LzLrJzBYk84yV2hWkCT0KrxVXp+S2H5UCVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9WQwXeseGFwcxynkQ/JFLIwrOPz/o9eWNzLTd0ZTCo=;
 b=Z/pmUQtlNQjXHuX+pMhVntm1buFPmva9uPKmKhe0795O7foxUxGydaPBv1/GGQVCp6FkkS5SxPjCUbRuO9W2UZXVurofd2FKhWMqyu1QyXpZCMeN+SCdb6092uheu3tMa8oXkQPFbRNiVOH7DJKLDl5itSVlIlAIwBPb6szytEjdlZ7CU/TtdWDvtZ0MgBigUFiylHg519EyhgP3ANiSfLjzI0mcm9px/SgFWZObFuw/gYyoR2Mh/monuBXZ8Ny0NyAhsoL9Pmc8ab1oYCylnAKXj+gxHF2qshtLL8k4RqlArKy+SZ42RUTw79sYul0D+B4RLcSXKg2D1tx5tACneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9WQwXeseGFwcxynkQ/JFLIwrOPz/o9eWNzLTd0ZTCo=;
 b=3V3y76GZtyiqLSgEx+VBDWLEWIbacLDGUzaoWfp2A0z4KRdYIub+CqUyyQsSLMNkxhzr8U57oyYRDzGv1tJOP3qwYOe68v9eVq3BRYuaIYMYCes68JkkTF7xcvtb4ASKP0y63EUNgES+a0Z1xiYjcRNlaWNiQ2i436hxCiizoH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 06:56:19 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 06:56:19 +0000
Message-ID: <19b5cf3c-9ced-4abb-6d33-f5c4408a6e25@amd.com>
Date: Wed, 1 Dec 2021 12:26:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211130051721.3192979-1-lang.yu@amd.com>
 <53f6a9da-9197-3cfd-3d9c-586dbad4584c@amd.com>
 <DM6PR12MB39306D37D616E811E56A1E6297689@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB4250B9CF078EF70E804BCA1FFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB4250B9CF078EF70E804BCA1FFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21 via Frontend Transport; Wed, 1 Dec 2021 06:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0909b0-90c0-4608-cf4e-08d9b497ad25
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR12MB133914D0AC7C062A9912A09097689@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UK5HMSsBIxQI9rHNq5rtiiI+kiB8IkdsR4hISGZ34DXCKaAWzytlZvFukf/v5iicCC04VwKEv+KD0N4vtCgMEwNzkScLKkMO0VnkrNZbN+gRz3ilzFK27VaX11DudL7rY1XKY9RPgfsKOFN7HGpBCm6qV9FB4VHNwOAU0ezAsvLoLgNtG3742FELp5xj00I0nrQAG6X0la6Af+uMnC9pwfBjgbckCdGbKT3rtTgF1i4ej7TaIhD/cGSvxkgV/h0F8+k1KBCY9mJIqBFYV5YleIacG0aHAKY6qMdsyEB3LPEjutPh/Boar+KKLlNtGKPyqXRzsb9sY3AgRbXsUrLYlUQoycYeQTzfBO/sorm8L3zeI6/yc3Nl2IZSoLZzBwUX1jKMmG2lf3qn3RdyaDuuVB6uDk3w3xJTDhaHgpQC2tYYEeIE2q5ncqVWDHpJJQMI1rv24fd9qHokIg4ZjBahlFw3g38U8tYo5N6R4ZSX2Rxy0bSGprUPIciVpNXQTeR4c9tY8bfRyLZjHmxWGHEJZhw9HxlPW9reysYYcQ8QHCLpvmoVyXTLSMoPA5pvPC6nW4/PaExCH8s9b8orgIMtCNl91v0vc1xU66ldBim9PNdoRjdvkKP4KN4rRzB6RHmdE+cLctKNNC3rFER8k0fp2kRT2xR8V40MaLBjLH5yWAiz23rb94rfsGrgksZzgYb/sWXevPaQtns9nb+ittWn+DjJd6Uj/9ZexJXmXK7thwR1TCowwC2DiQWRXj6PUwfn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(66556008)(66476007)(4326008)(8676002)(956004)(66946007)(83380400001)(5660300002)(110136005)(54906003)(2616005)(316002)(16576012)(31686004)(186003)(2906002)(26005)(508600001)(86362001)(36756003)(53546011)(6486002)(6666004)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9qcEtPbjhyekNLZ1hwaXd5UHlaMWRNUkpscm1Cc1hYcmVwalp3dVpaMlQ2?=
 =?utf-8?B?TW51cHZtaUkrUHB2SW04b2liZml1anJqR1RZWFIyVHQrYVJBZW50aEN2dmR1?=
 =?utf-8?B?akQ0SE1SZWJ5UmhPOTlYNWo0R1hkK2NkWE1kcFNFamhPQkNmbWUwdVBRWnlO?=
 =?utf-8?B?aGNwNkd5eTlubW9JMGx3Rk5ZN0RLRkQ0eHJabVJTVVRvd0E2VjFGRlEzbll6?=
 =?utf-8?B?ZFRsbXRVbkxrZ0Jsa3pKSDBsUEdvem1ydTlISjBxVHl6d2Z6cjU3NUdkcFlF?=
 =?utf-8?B?Nk1yUnlyaStrRUNwTU1rZGJQRkEvaHo5YlpRbEZlRDVKVlJPbmdUTW11em8z?=
 =?utf-8?B?QXR2R1lUY1c1YmtJQXVsRWtPbElGNU4vWFBNOEFpZTdmYjcrVlp6a242OXo4?=
 =?utf-8?B?bjZ6Mm94OVdsbm1lLzQ3dnFXL3Z3enVPT21PTHk1OXBuNEZjTm1JZ3lGTFRB?=
 =?utf-8?B?N2xYL0xIdFJLWHVKWWZ2T3dKNHh3ZlBBNTE1QUJVZlQ4WXo0aGRud3hENXlD?=
 =?utf-8?B?a3ZydVlEbTNFeTFYbUxMTE5hYllYU3hNL20wUGFZK21sS1QraUpWSEtUb3ds?=
 =?utf-8?B?VEFaV3hjV1k2TXhqa2IwdHZlTzZHQ1Ryamhhdy9vWW1NTy81em5kQW91WEl6?=
 =?utf-8?B?dmJWMGtaVGFlbFhtbmR2cTNtdG95S3QzSmYzYndtbURYZlBBb2drL252L0pr?=
 =?utf-8?B?M21YK3dwU0VBNmcxRG85eG9QczFMRlp5cWtXdEJHU0VWcWU1VzJkMHJ5cnAx?=
 =?utf-8?B?alVNSUthKzE1ZW53Mm1sT1ZnU0lKS3RSRVJOSHBOYXgyd2JyQjF4MlI1Vlh5?=
 =?utf-8?B?amhEZExSWjNSK1ZUUmRsNjFMY3JpdE5rV012WThMeTlGMnAzYWxnaHFzZmx0?=
 =?utf-8?B?NEk5SUUzT1MySnEvN0tNM1k4TUl2Q3R4TU94bkxyWUdRS3IyeFJCMDRsbzJO?=
 =?utf-8?B?VlhuMC9UcHAwMThHNHp0ckErSlBNOUcrSzZqbGJ3QWdkQ1AwZ0pIa21EaVBv?=
 =?utf-8?B?OXZBSzJ1RE50R0cyeFJiVFljenVEZmordzkrZmZpOU9pZmVYQVRxS01NZzEr?=
 =?utf-8?B?ZnRBM0JzdVVaOWx1Q1lramlrVWNDL0tjUzVnSngxejVhM21MTlFHUDZIVkRS?=
 =?utf-8?B?QmYzNjRPK0tzTDdzdU4wRWw0MUwvRk8wRDZvYmVEMlRlSlJBYTdBcGtRR1FK?=
 =?utf-8?B?R2VhbjVWdzFNVnA2dTBOUE1mYVV3bjNsT1RNSXl4QiszRlBBbFdyNkVEWDdt?=
 =?utf-8?B?Z1RxeklxeWFKcFNmVFVZdnlVclJiN1JyRERDcnNITWVtWGF3Vkl1RjZtakp2?=
 =?utf-8?B?eUQ1RHQ4ZGF6RFNYNjVoK0UzL0s0U2dtNzRVOSt6b3YzcmI5cFlFRFdUaWhG?=
 =?utf-8?B?WnlPNVRzMGFJNXNoUVV2SzA3YkZVQ1hISmRmZWYvMm5IaVN0Ym1qclR6NTgy?=
 =?utf-8?B?a3l6aWYzVXV0NWVYU1lHWWYyU1dSQUlFU3k3RFBucVNHM3pPb2tsWERDOGt4?=
 =?utf-8?B?aUFkN3Iwb2ZCREFKSFhBajRkQ0NzTEJETUJiKzFNcERQdjMxYkF2K0ZkNDRt?=
 =?utf-8?B?Z25ZSUVUQlV5dHkyaklqMjJ0anlXaUdodDB2cHBzcTlWN05oS2czcUdXRE90?=
 =?utf-8?B?RmRhZlJEOU9oM1l5dHhvQnZ0N3JIWEZ3S0M3aDF3dlo0SWdDV0J4UHJUWGx0?=
 =?utf-8?B?Wkc1SU9ERlNUbUpFSmdGb0pHVjFlWHhkZnJlVW1JMkswRXpSaHUwMlVZN2JS?=
 =?utf-8?B?TE5FRzFEUXRJdHpHdTE0dUJFZmFXVG1RRUd0clE4N3lGR0JDTkYySFlna1hB?=
 =?utf-8?B?bU40OThTVjhTclBaa0VHQXZiZ2Y4bDlJdjRFalBkR0FZSVhvbGEyOXpFOEpZ?=
 =?utf-8?B?dUd1bklkMnVBZ01VZ1FGNkl0VE5OSVd6dFBpZHVmUkpyVUM3MjJUSDRBTnFS?=
 =?utf-8?B?Mm9PcXhzbC8wbXlSTjNzVGdjTWRGVTNWZkh1Q2JHZkdoOXgvZnkxSlpSR2Yw?=
 =?utf-8?B?U0pySCtzc29hcmliU1pCeGRJVDlsQllNV0NraU4vZkJISUFkdTR1RUxPSEsv?=
 =?utf-8?B?aml3UTBaUzFiQnl4ek1zR1o1bk1VQldpcVBuZ0VHU2NocFgrV3VQNGg4WUla?=
 =?utf-8?Q?KIwU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0909b0-90c0-4608-cf4e-08d9b497ad25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 06:56:19.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFUY2gVfyeLk65XS3OnZroem8rWj7fvxEUEGzlYUlcMzRWdKhhCAaXHTUh5rCSBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 11:57 AM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> Hi Lijo,
> 
> Thanks for your comments.
>   
>  From my understanding, that just increases the timeout threshold and
> could hide some potential issues which should be exposed and solved.
> 
> If current timeout threshold is not enough for some corner cases,
> (1) Do we consider to increase the threshold to cover these cases?
> (2) Or do we just expose them and request SMU FW to optimize them?
> 
> I think it doesn't make much sense to increase the threshold in debug mode.
> How do you think? Thanks!

In normal cases, 2secs would be more than enough. If we hang 
immediately, then check the FW registers later, the response would have 
come. I thought we just need to note those cases and not to fail 
everytime. Just to mark as a red flag in the log to tell us that FW is 
unexpectedly busy processing something else when the message is sent.

There are some issues related to S0ix where we see the FW comes back 
with a response with an increased timeout under certain conditions.

Thanks,
Lijo

> 
> Regards,
> Lang
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, December 1, 2021 1:44 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: add SMU debug option support
>>
>> Just realized that the patch I pasted won't work. Outer loop exit needs to be like
>> this.
>> 	(reg & MP1_C2PMSG_90__CONTENT_MASK) != 0 && extended_wait-- >=
>> 0
>>
>> Anyway, that patch is only there to communicate what I really meant in the
>> earlier comment.
>>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar,
>> Lijo
>> Sent: Wednesday, December 1, 2021 10:44 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>
>>
>>
>> On 11/30/2021 10:47 AM, Lang Yu wrote:
>>> To maintain system error state when SMU errors occurred, which will
>>> aid in debugging SMU firmware issues, add SMU debug option support.
>>>
>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file. When
>>> enabled, it makes SMU errors fatal.
>>> It is disabled by default.
>>>
>>> == Command Guide ==
>>>
>>> 1, enable SMU debug option
>>>
>>>    # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> 2, disable SMU debug option
>>>
>>>    # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> v2:
>>>    - Resend command when timeout.(Lijo)
>>>    - Use debugfs file instead of module parameter.
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32 +++++++++++++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39 +++++++++++++++++++-
>> -
>>>    2 files changed, 69 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..f9412de86599 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -39,6 +39,8 @@
>>>
>>>    #if defined(CONFIG_DEBUG_FS)
>>>
>>> +extern int amdgpu_smu_debug;
>>> +
>>>    /**
>>>     * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>>     *
>>> @@ -1152,6 +1154,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct
>> file *f, char __user *buf,
>>>    	return result;
>>>    }
>>>
>>> +
>>> +
>>>    static const struct file_operations amdgpu_debugfs_regs2_fops = {
>>>    	.owner = THIS_MODULE,
>>>    	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl, @@ -1609,6 +1613,26
>>> @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>    			amdgpu_debugfs_sclk_set, "%llu\n");
>>>
>>> +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val) {
>>> +	*val = amdgpu_smu_debug;
>>> +	return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val) {
>>> +	if (val != 0 && val != 1)
>>> +		return -EINVAL;
>>> +
>>> +	amdgpu_smu_debug = val;
>>> +	return 0;
>>> +}
>>> +
>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
>>> +			 amdgpu_debugfs_smu_debug_get,
>>> +			 amdgpu_debugfs_smu_debug_set,
>>> +			 "%llu\n");
>>> +
>>>    int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>    {
>>>    	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device
>> *adev)
>>>    		return PTR_ERR(ent);
>>>    	}
>>>
>>> +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
>>> +				  &fops_smu_debug);
>>> +	if (IS_ERR(ent)) {
>>> +		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs
>> file\n");
>>> +		return PTR_ERR(ent);
>>> +	}
>>> +
>>> +
>>>    	/* Register debugfs entries for amdgpu_ttm */
>>>    	amdgpu_ttm_debugfs_init(adev);
>>>    	amdgpu_debugfs_pm_init(adev);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 048ca1673863..b3969d7933d3 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -55,6 +55,14 @@
>>>
>>>    #undef __SMU_DUMMY_MAP
>>>    #define __SMU_DUMMY_MAP(type)	#type
>>> +
>>> +/*
>>> + * Used to enable SMU debug option. When enabled, it makes SMU errors
>> fatal.
>>> + * This will aid in debugging SMU firmware issues.
>>> + * (0 = disabled (default), 1 = enabled)  */ int amdgpu_smu_debug;
>>> +
>>>    static const char * const __smu_message_names[] = {
>>>    	SMU_MESSAGE_TYPES
>>>    };
>>> @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct
>> smu_context *smu,
>>>    	__smu_cmn_send_msg(smu, msg_index, param);
>>>    	res = 0;
>>>    Out:
>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>> +		mutex_unlock(&smu->message_lock);
>>> +		BUG();
>>> +	}
>>> +
>>>    	return res;
>>>    }
>>>
>>> @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct
>> smu_context *smu,
>>>    int smu_cmn_wait_for_response(struct smu_context *smu)
>>>    {
>>>    	u32 reg;
>>> +	int res;
>>>
>>>    	reg = __smu_cmn_poll_stat(smu);
>>> -	return __smu_cmn_reg2errno(smu, reg);
>>> +	res = __smu_cmn_reg2errno(smu, reg);
>>> +
>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>> +		mutex_unlock(&smu->message_lock);
>>> +		BUG();
>>> +	}
>>> +
>>> +	return res;
>>>    }
>>>
>>>    /**
>>> @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>>    				    uint32_t param,
>>>    				    uint32_t *read_arg)
>>>    {
>>> +	int retry_count = 0;
>>>    	int res, index;
>>>    	u32 reg;
>>>
>>> @@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>    		goto Out;
>>>    	}
>>> +retry:
>>>    	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>    	reg = __smu_cmn_poll_stat(smu);
>>>    	res = __smu_cmn_reg2errno(smu, reg);
>>> -	if (res != 0)
>>> +	if (res != 0) {
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>> +		if ((res == -ETIME) && (retry_count++ < 1)) {
>>> +			usleep_range(500, 1000);
>>> +			dev_err(smu->adev->dev,
>>> +				"SMU: resend command: index:%d
>> param:0x%08X message:%s",
>>> +				index, param, smu_get_message_name(smu,
>> msg));
>>> +			goto retry;
>>> +		}
>>> +		goto Out;
>>> +	}
>>
>> Sorry, what I meant is to have an extended wait time in debug mode.
>> Something like below, not a 'full retry' as in sending the message again.
>>
>>
>> +#define MAX_DBG_WAIT_CNT 3
>> +
>>   /**
>>    * __smu_cmn_poll_stat -- poll for a status from the SMU
>>    * smu: a pointer to SMU context
>> @@ -115,17 +117,24 @@ static void smu_cmn_read_arg(struct smu_context
>> *smu,
>>   static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>   {
>>          struct amdgpu_device *adev = smu->adev;
>> -       int timeout = adev->usec_timeout * 20;
>> +       int timeout;
>>          u32 reg;
>> +       int extended_wait = smu_debug_mode ? MAX_DBG_WAIT_CNT : 0;
>>
>> -       for ( ; timeout > 0; timeout--) {
>> -               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> -               if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> -                       break;
>> +       do {
>> +               timeout = adev->usec_timeout * 20;
>> +               for (; timeout > 0; timeout--) {
>> +                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> +                       if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> +                               break;
>>
>> -               udelay(1);
>> -       }
>> +                       udelay(1);
>> +               }
>> +       } while (extended_wait-- >= 0);
>>
>> +       if (extended_wait != MAX_DBG_WAIT_CNT && reg != SMU_RESP_NONE)
>> +               dev_err(adev->dev,
>> +                       "SMU: Unexpected extended wait for response");
>>          return reg;
>>   }
>>
>> Thanks,
>> Lijo
>>
>>>    	if (read_arg)
>>>    		smu_cmn_read_arg(smu, read_arg);
>>>    Out:
>>>    	mutex_unlock(&smu->message_lock);
>>> +
>>> +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
>>> +
>>>    	return res;
>>>    }
>>>
>>>
