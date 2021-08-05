Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E056DC4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 15:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF78660EEA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 15:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF78660EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B556EAC6;
	Thu,  5 Aug 2021 15:10:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BD36EAC6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 15:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ2tKvAniVb4juk5QblI6/54Y5rp5ksqeb7P6f+rygJpn8aKQjLsP4NVFf1TgL+fk9V0RkzxZp0QdXy4xAc68FBNFf2QqADNOubRjJ6ywdMMtASe0+4OyqynUhGshXTmvFFYakbS1lz3Pbj3igI0WSttv3aWn3eejRPtkBohzURI4lKxnq9ime8Cm3JdBupyrmvuBrGtTgL73yxDAXZ4j++GDFWBH7DuNpoOac4ZSvEKvKoMYBfwJdwB83U/U00VHgK+jtdNrCWlPHIYK1utK79sxpoXv0HLA4LpthmmZ6fsUj3GxqLcclZhNRtIPnICZbdgAwmZoR4eeKmP0aAzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INH6XC6sG5Hp035aT9DqOrt4KPw92+FDyoue0aDjlUg=;
 b=GxgasTmOqIkd38dEVw9xMNW+wRsGKWtGGSQGNENAEkGvJh1DspqFQDoWuhdqeBCfoU91lPpIPMVzFzyXFLdIlOf+DucFr6NYSqIHYOwQ2SOAv2IAHWLDjV90GKBS6UFUqFaCg221oC95HdixUf8raC4Gfsxr91HG0Ym7vxUwsVbj4zxZuQe0zECYCtltWOKP69yfSjVJo6SaDFMENKbSWo4uI6aRQhukdwx/QBGl39pnLES0MJavFYEh67eIRl4ekVnZ+dQJYdbQw4FShFYTNl1YnHBZD+U7IX3TDYaD+3x/C86oPHImRpdLwghhJv2jHfxYoDCAjhc8rXjvFdgY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INH6XC6sG5Hp035aT9DqOrt4KPw92+FDyoue0aDjlUg=;
 b=j20EGA2qcMhU3s831pcKVx7CaDMYo2hN6ejTTTzrURsk4phrnnE1gM3F1RTPlK9rLnUQ9AcGP81yddLLZp4luMl1Q0k56LbHXXZ/c674fYWNOk5OVSNElgditQ9FIeeXN+LRXbaMUauL5QsU39ffHQGkRdzBqIJXCkbpJlK9lFA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 15:10:27 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Thu, 5 Aug 2021
 15:10:27 +0000
Subject: Re: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues
 for raven
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
References: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
 <7d68484f-b293-31c9-15a8-6ed700777dc9@amd.com>
 <MW2PR12MB4684ED779CA54E8C67D027CEFDF29@MW2PR12MB4684.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2eedb134-d0c5-a5c1-c93b-28f6b3b4a3fa@amd.com>
Date: Thu, 5 Aug 2021 11:10:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <MW2PR12MB4684ED779CA54E8C67D027CEFDF29@MW2PR12MB4684.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 15:10:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c386bf2-2cd3-49e0-f34e-08d9582327f9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5180DD480B3E49CAA88DD9F292F29@BN9PR12MB5180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4nR9sD/0fQJM14X8fOe9qAErnV7VgGDbPotG15DHMj9JeQjqo2YWF7BZVdEj7PsMpR2QUfavNefO5fFHBIk2EsKz4SFAH+1JNP8mgCE3YtKRdv73ygrq+Af2djc5fzVyekpGjobxWQOISSR7F3Ghw39hexv9RrCWiRHEXF4BXwDHE6YcCZ3BVefGEBA+A+66Aa4uNINeAgykLQQDi5MtM5zSHYj4ULxgmkkEZnexYMFQkGj2UJHIWvACYctj6+fBo1nOlqRcw4Q1N1+6LGqPzVNB3Uf9zF70IA5w34RLADiqRHwzl2qJiAenJ9pKBsKzzOjfVazqcHbzrcToh9D/lWJt0kPwMTPds04E8Z50ZD4Sp/XUtv2zLVWhsRC2eBYFG7VmHgronEKp7wElrgPrhIuUWL27jMg+d2oZHCGB0IHd52FAUtnmNs41vY76k/c/Cvvt9ij+HjQXkjujabq3mOaMjEKyRi80mpsdVRou7qENxMTiBp7UVFv9V5e9CrK2+2WykSQVsu+O1IKvXGpH7Z5ZJ3TbARCCDgYdUNu5ZUTE3taSjIiRH0zA32Ay5KPbCmho7bs6qnw7q6eyoTyQviyriCMEIEbCbWaamGT78M7in+E6MeIG+OtLBRQAzcL5uthjITRTdiOTJnaiq6unQsV9dbkiE6Qq7USUXScTaeuPqZOiIKdTOviy+MoG+/0DJfxIwKOmMX4nJ8dl4HP22hSAuOQLih36mCtP4GaTQcZkKCz0g1jo4QbjwLaIMa1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(2616005)(6636002)(5660300002)(86362001)(316002)(31686004)(2906002)(31696002)(956004)(16576012)(36756003)(44832011)(6486002)(8936002)(110136005)(26005)(53546011)(66476007)(66946007)(186003)(66556008)(38100700002)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NjZ1ZLU3ZhSnRIa0QvTTVuWVhIamQ5YjVIVE9renF0TCtPUDhoZTBYcDBn?=
 =?utf-8?B?aTZSTkdWT0F3dFdPY2FERFNzY3dxVWVYQVJDVWpZaVBrNjVvL3JmaGpvV1JP?=
 =?utf-8?B?c1Y3TVBoWE1mamtScGdMOVJJbmMrV2lTdHdxZVdhcDlSTmw4MmpFa0JrTXg0?=
 =?utf-8?B?Y0ZEaS82cGhnR01GemU2b1F4Wk4xTno4a01DUFdZN2xpUTBrMlhZYzVhZUk2?=
 =?utf-8?B?c3VTV1JiM0pnTmdjVWJncVByKzRjTGxYN045ak5NL0N5Z3BhSDZpcjE2R0I4?=
 =?utf-8?B?U01UVzFuQTYycGtWV2s3Y2tTenlLQjZOOWl5Qk8yamkxSnlGYUxpNlczRmxO?=
 =?utf-8?B?UmdBMTdnRk9Yd3hKakxtNUs3RmZlRUZSL3FmY1NKWFBIVWtXOVYxaVBQK013?=
 =?utf-8?B?VCtYRkZDdzhoR0dnRUNGSEFMT3FyZlNENGczVm5GM0JvME5XaXVEVm13NmJY?=
 =?utf-8?B?ZTRZRmpLa09UK0Uydit0YTFmYmtRYktURW5sWFZ3Mk0zRVVudkR4Rmh3RTRD?=
 =?utf-8?B?Zi8zYUVoRjA4YXdWeFhUOWhpaWZPbFN1ZFlKS1lsamg3TDUySm5sd3pDeGla?=
 =?utf-8?B?cTZoRGFlU2dwTG5PWHFwV3J6Ky9KTmp5dHRzSWpmazBpZlNwMHRsUUFzT295?=
 =?utf-8?B?ajRqNWV2WHdzVkxYajA3N01sdEFBTytlQzVPUTgweVZPQWlxM2EyNFdMUkcx?=
 =?utf-8?B?dU4yMElLblVKc0JjMENQRXR2cUpNZXVzSzNvZVkxdEdkWUdHS2J6YWVzUVFS?=
 =?utf-8?B?ZXBMK283VC9DS25aUHFiMXBzelR0Q25kOTlteEkrb3JNNEcxS0VEby94T1pC?=
 =?utf-8?B?eXA2ZG9lY0lGL2QxcUZSOUZMNVBWRWZPcWIrRXM4Y0ZTT0FpWWNTcWh4VUcw?=
 =?utf-8?B?YXh6R1ZIWDRaRVpJcWxYdmU1dVlIb1ozNndBdVJmOHJuSzAzclpwT0dMVEk0?=
 =?utf-8?B?RWk5anIrZ1JTaVhCbldhTlFpYlJ3YnRjL01iOGJXYUVZYkVRcmtNZXRObVdJ?=
 =?utf-8?B?TlVIcW5lSmE3SkZjcHJxdWgwRTFTQm5zdUlDTk0zY3h3N0UrZmgzdS9GOTlG?=
 =?utf-8?B?OFZjQk1VTkpFYnpmZnRhOEprd1g2VHhOR3V2NlFxTGdsTEEzNjcwU05TaTc5?=
 =?utf-8?B?WEFRL1pxc0x1cGdxN29ZNGN5bHNwVkVESnRHamJjMm5uZldOZDBBN3NHUUo5?=
 =?utf-8?B?RDd6SHJwL1diaW9BaW55cUlGZHRQaDRRK1VCVDE3bzAxaFlLZW1aZDU1eDFJ?=
 =?utf-8?B?QW8rNWU1b1dKb2Z0UXlzN0tHajFDVGRmamtUMlo2cEtFMGVKU1ByVzhRNkVk?=
 =?utf-8?B?d0t1WDlieklSSlJLUHNNWmFWa1ZXL0UyQ2IySG43TkdQb1hzTGhqOVVCVFJV?=
 =?utf-8?B?ZTFnOGtxSklYRWxkSk10eXI5LzRZTVBFbTRmMyttcWJOZzc1S2lEdENNT0o0?=
 =?utf-8?B?NFgxQTU1Z0h6WTNYU1ltVjRYK21qUUdGaEZWZzEvUlVsRjdDZDNhbkZtQ3Er?=
 =?utf-8?B?TFA4M3hWaHdYaFV2K3BhS01XWXNxbHNoTENuTGpIb0F0WlVDUHlOYVlCMVhO?=
 =?utf-8?B?R2M5NnZPQm1VdjQ5SndSbzZFMnFZNkVJRXc4eFVXUE5ZSFpzUEF5MG1mVnZH?=
 =?utf-8?B?OFR6YkVpZWJScDhiRGpSR1QyVnBLU1BQYnlaYTdUS0t4emgvNERxZGxCeEJ2?=
 =?utf-8?B?SWJ6UDd2aTIreXVMQyt4NTRpSEZmZEtML3FHRDlyUWZ0U0lMUU03aWpkcHoz?=
 =?utf-8?Q?ZcaBimyAYDVvoHsMnfAbgUFUKdQAUpSV/+4DwVf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c386bf2-2cd3-49e0-f34e-08d9582327f9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 15:10:26.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3IOBgNo6RiG0x/IDayvdAmmAA6dXA1CtA64sJC7IWhG0YtCeOmkvnEk6FTqHGbu0LEA0iUB8cbKmIn8x63/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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


Am 2021-08-05 um 4:51 a.m. schrieb Zhu, Changfeng:
> [AMD Official Use Only]
>
> Hi Felix,
>
> Can we set noretry=1 for dgpu path(ignore_crat=1) which doesn’t to through iommuv2 path on raven as below:

There are other possible reasons than ignore_crat for Raven to work in
dGPU mode (broken CRAT, disabled IOMMU). However, those are not known
until later in the initialization.

Regards,
  Felix


>> +	case CHIP_RAVEN:
>> +		/*
>> +		 * TODO: Raven currently can fix most SVM issues with
>> +		 * noretry =1. However it has two issues with noretry = 1
>> +		 * on kfd migrate tests. It still needs to root causes
>> +		 * with these two migrate fails on raven with noretry = 1.
>> +		 */
>>  		if (amdgpu_noretry == -1) {
>> 			If(ignore_crat)
>>  				gmc->noretry = 1;
>> 			else
>> 				gmc->noretry = 0;
>> 		}
>>  		else
>>  			gmc->noretry = amdgpu_noretry;
>>  		break;
> BR,
> Changfeng.
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com> 
> Sent: Wednesday, July 28, 2021 10:22 PM
> To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues for raven
>
> Doesn't this break IOMMUv2? Applications that run using IOMMUv2 for system memory access depend on correct retry handling in the SQ.
> Therefore noretry must be 0 on Raven.
>
> I believe the reason that SVM has trouble with retry enabled is, that
> IOMMUv2 is catching the page faults, so the driver never gets to handle the page fault interrupts. That breaks page-fault based migration in the SVM code. I think the better solution is to disable SVM on APUs where
> IOMMUv2 is enabled.
>
> Alternatively, we could give up on IOMMUv2 entirely and always rely on SVM to provide that functionality. But that requires more changes in the amdgpu_vm code.
>
> Regards,
>   Felix
>
>
> Am 2021-07-28 um 2:36 a.m. schrieb Changfeng:
>> From: changzhu <Changfeng.Zhu@amd.com>
>>
>> From: Changfeng <Changfeng.Zhu@amd.com>
>>
>> It can't find any issues with noretry=1 except two SVM migrate issues.
>> Oppositely, it will cause most SVM cases fail with noretry=0.
>> The two SVM migrate issues also happen with noretry=0. So it can set 
>> default noretry=1 for raven firstly to fix most SVM fails.
>>
>> Change-Id: Idb5cb3c1a04104013e4ab8aed2ad4751aaec4bbc
>> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 09edfb64cce0..d7f69dbd48e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -606,19 +606,20 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>>  		 * noretry = 0 will cause kfd page fault tests fail
>>  		 * for some ASICs, so set default to 1 for these ASICs.
>>  		 */
>> +	case CHIP_RAVEN:
>> +		/*
>> +		 * TODO: Raven currently can fix most SVM issues with
>> +		 * noretry =1. However it has two issues with noretry = 1
>> +		 * on kfd migrate tests. It still needs to root causes
>> +		 * with these two migrate fails on raven with noretry = 1.
>> +		 */
>>  		if (amdgpu_noretry == -1)
>>  			gmc->noretry = 1;
>>  		else
>>  			gmc->noretry = amdgpu_noretry;
>>  		break;
>> -	case CHIP_RAVEN:
>>  	default:
>> -		/* Raven currently has issues with noretry
>> -		 * regardless of what we decide for other
>> -		 * asics, we should leave raven with
>> -		 * noretry = 0 until we root cause the
>> -		 * issues.
>> -		 *
>> +		/*
>>  		 * default this to 0 for now, but we may want
>>  		 * to change this in the future for certain
>>  		 * GPUs as it can increase performance in
