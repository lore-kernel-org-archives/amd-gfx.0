Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78C9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 17:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2726310E411;
	Mon,  4 Apr 2022 17:03:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB6E10E411
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 17:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs+L9QGESG1grzynBsTp40WUiRBCK7nJXA+AEUgydgaYxlfBwrcKHRmN7IWzvnIAALemudY+RwszImuvRaVxUC0H4xCt5GD+mVjuq3dggOaQR+cTH3fgixIu98Ww9ZTK776ei60r3w+k9nAUCUrIRllZeLwNIfqcEXfUhSDqKP+xzj9qLr1ffmlgPzbNOHKAWWg35oLKCYrnQ6VUHybMxmQbNaiVfcLhhsgcjvSryDZIVOPBpvXxaA9mQScAKCk0iQPkDcdnh4mUPIphMj2JC5PzIt4kvfwOKJtJ+Uae+UtAYjcG5KQVP1jWoD9xWLg2Xl6ReWz4QBxcxLsdftuG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4evD9ldowQdioHz/cCzzmn6h4vvXw8WZJ5cYIcK8Cc=;
 b=QB1QuQdBNKZVPYfXqer8oPuonYVAvtDkFSo/RZUnZmPnsirq1VwNOloq7ADmCpwjR/Pcj5LKdF+7ebsUa+6+UUvImEhWXKspf4gZc1QsnS1ZIn7BAUR1GoXOcVtC7tNcPfZIhhy9GIgjhxnsphn28tYIEjvEdPxS699icOQ83eX+yjGgG34itfewIQFPI473GQoD36DEAlD0pY0ARJQoiVjSSDLHxbq3Scl9g67lGIB9C+3b2yTQtIYsr1ZyggVsI3wCy4gRY9/M7g2QZ5QqZq8wz68z12LcfI25/d4i8/8z6gMscbDWQ4Exo2xs2L6sWhoSjWB7mHTjFblk0B3Z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4evD9ldowQdioHz/cCzzmn6h4vvXw8WZJ5cYIcK8Cc=;
 b=IYP50v9nFjOjo3rrn4ps5szEn3+sRVoF4APWadQvAwMb/VXaTScioqG8EHMSJR50thEcWC4hlq7avrsgpApqSOzlAI3sDYSrDaBH36XSsp8TE+mhid4UGeueyacLEXMCjYq4FbQqztOvlOyoUT5+Jjtm9HBxZXAcG/Gr6yFpmC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 17:03:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 17:03:19 +0000
Message-ID: <f125dd0d-034a-9d7a-c446-19e817a94b38@amd.com>
Date: Mon, 4 Apr 2022 13:03:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Philip Yang <Philip.Yang@amd.com>
References: <20220401195726.21436-1-Philip.Yang@amd.com>
 <daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 703b395d-e55a-4d8b-4949-08da165d0477
X-MS-TrafficTypeDiagnostic: DM8PR12MB5480:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5480D33270F5A1266119AFA392E59@DM8PR12MB5480.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkOQhgqdrFEnaDdG0H7s6TgYGuXs833zJ4ELmPnkejY+vINGbw4AWARmZb6Z2tWDQQSXuC/vRsqJda1BmolHyKeJwKaal/5LwlGqkr0Ulqy91JvA0ekbC/YsrOoH1I6yAinjSOBciiVVj+ZATBhC02iHa52DK16BXITAM+uMb1Im/q4qbM0JrBmIcABwfb5riYJwj3GXBPToEdsffMJOHiQ6AterZxJYQ1Jq92InUeZ2uRSwyoDsLDcZsXq9/diPT7qHQrdzxf9HnhpWOAUQ5/nwSXNnIuZ1Wa4XFW7HH34bZ04MP5+7II0ThQWFhUWWjw8cOreXaeu+KoTttRAyG2Nh9JrzP/vvw84RPkG09X6gry7WBdePAqUbSaJTGnQpjbSzBVchz5xztuUlGAPTq5tqwUYdsvs8oHWCblpQgSa8455Iltsr54XQ7TtdD0VZIp+XMEo5yR+7IfJAsT/D9ZFeZFtoPsqn/9ZWSg4OyEki4ctS1ex+MEdrZKuqY4iVtk79w1x4IsVBO6kZBOBPQYM2ZE49yUjWI+/pDRKpFOHCGkWsmBWLftmSYISSNbmT8oBRtMNm3PwydHBAbrSq8vlgeSyf4b8qA6YsZIJ+FVL8pFE7QOzKcPcrRo68l/4g6mZABIqGG9U2xr14dln3xoWWHMx8C7Enm7yO1vFfSooE34yuncRV7y6GHmSEAuTaz/8Ws7I+76iRVpTthckz6/3NQM8ekRKJ2DgeGGqFk7H+RckU4ZNFlhYfZMWITeml
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(26005)(110136005)(31686004)(508600001)(83380400001)(316002)(38100700002)(36756003)(6486002)(44832011)(6512007)(6506007)(2906002)(186003)(5660300002)(4326008)(8936002)(66556008)(2616005)(31696002)(86362001)(66476007)(8676002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUpZTUxlU0Zwd3hGVVAxQzU4VWQ1UUF0M2Y5eHJCTmlIeXNOOWg1TlBWc0Zp?=
 =?utf-8?B?ZWNCdlBJOFVlUmxVQ0lTOTdzV0ZkWldnZElUYkN3VGt3OGhpZmlYVWx4bkM2?=
 =?utf-8?B?VkxBcXVxVVQ3UUlSMXlXa2c1VjN3a2VpaEFxbzA1QWxmaVltMGRKUGJFNHBT?=
 =?utf-8?B?eGVwd1VFNDVGcjZWOXFMUW42elZPWHlRQllDUTc5d2JGTVpiTU5HNkZGL21v?=
 =?utf-8?B?VlhsZ3dXd2ZoVjFlaXh2c0x0WWh1NDNtWUtraUU5TnZFbGMrekVwVHpEWnUx?=
 =?utf-8?B?ZGVNYmVLeGQ4VVZqbGlOZGo0RzlQYU1md1hVdDNFTHM3Vkw2SlcyeWFyc09F?=
 =?utf-8?B?cmNmMEFvZEpBVFk4dDRwdTFrT25NeHIyRE1pSEdYQk5VSDI0VlBycUxNbTY4?=
 =?utf-8?B?anNTNVl0NnI1YTJxV0M0YXNkMVkwM2V4aDRpNEpEQVVTK1RUL0JsUjg5SS9k?=
 =?utf-8?B?ZE9ZK3RSQkxzSXVNeFd4bVdiai9yQ1RPTTJpWUo5SkVOYXRoNkphNHBCRXk4?=
 =?utf-8?B?T0tQUnk1TzhZNUYrUEE2TDZqVUxkZDhyYUpXWFNacGFxRnlXTzdjWkZmOHJ3?=
 =?utf-8?B?cjExc0pnbmpFbGdFeGZQU05HbzVCMnByN0J0OHFKU3plRm9seVFmclBIM0tD?=
 =?utf-8?B?a0xQYVlodW5rQ0dkN29OWXNmZEdsK1BiVlBUWXBHZ0xOOTAxMjcvYXdzZGlF?=
 =?utf-8?B?eGlja25zUHhWUlFEU2xQZDAyajQzeWdpc1B0WFhJekQ5Zjd0UFlnUStLb0Rk?=
 =?utf-8?B?djRxczZIaFQwZkpnTFRmT0NIWFRUNjJJMkY1YkxhVXY4cUVSWlJGZlEwd1dL?=
 =?utf-8?B?Q1JyaGFpZEY4WEVZR2J0NERTbmFKbzVCMEhrZTRRMm5uUHY4a05YVjVzL2dT?=
 =?utf-8?B?Q20zV2RNTXdnVStNV0xQTVhwWFA3N2RKMDJkS0ZTaHR4UlI2NGg2UW1tYmhk?=
 =?utf-8?B?OEtPZ0dmdG8xV2trcm9GQitLZ0hXV2pvc2h6NzBWZEI1bHp2bGovV2thcmt6?=
 =?utf-8?B?QmtzeUV3dkt4M0VNNldlMVR2MXJaVk5LVDB6ZzVXa3FZcFZjaXBPUTY1ZFNX?=
 =?utf-8?B?MGZzMTNrWFpwU1IvcmF2SDJmd2FXM29DMExGclFLTnFpaWw0OEs2SFAvbE9u?=
 =?utf-8?B?aGtDRUtZckNTd1g3SjRxM1BiUmNiTTl4akNhV0VselNpR0M2Yyt4Y2Z3L3ZK?=
 =?utf-8?B?TUlRMndDRm0xUzV2WHJqMU5pTGZLTDlHOWRHTkFQcmpvVTBtZjRBWEZjRitL?=
 =?utf-8?B?TmFwd0hiREFTRUV0Z0J4dHVHaytXSEhjOThzbFBFZWhtWGJ4dFNpQnRXSERK?=
 =?utf-8?B?cU5nbVViTFJTTDNzQ1A4d1MwTEZUZEhPb2VMODYwOGVZaUplc3NwejR1SEt5?=
 =?utf-8?B?azdtRG5TNFBaZ3Z3L0xKMFE4cXlsTG5NaTNXaFBOSWpZa0J2UzlVVTV4TUVY?=
 =?utf-8?B?VStLTy8wSkZjMDVxOTJyalNMMmpOeXBxdXI2QXZzSzh5QXRDUVkxSHFqM0F6?=
 =?utf-8?B?TDVZbHR2ZCtSS3kzbzNkMTd3NjV4WmMzUnRaV2s2Q3RLUWVtR0JVYXJ1aENz?=
 =?utf-8?B?OUdiNmpYaElFcEJWUWozNmQ2cno0VlYxV1Q5YXBpNW1VQ09KSFY2VDh3TDVi?=
 =?utf-8?B?N1JOVnNNMzIyOUlHeWdYSEJEQkZlQnpCQzRvaXl6V0k4QnBRQUJvRWl1RUFl?=
 =?utf-8?B?SWQ3WWlmbFFlWFhabGNoVTN4d2RFOWsyU2dLSFhMMjkxNWZ4M2lEQzQxdW4z?=
 =?utf-8?B?Rk03Z1hMQm1LMm56anFzbWtDN2FjckNnVHVhb2ZxckU4MFZucFVZM0IyTWpT?=
 =?utf-8?B?N0xyeDBlNTYxOElsTit0YTdhWWtQT0ljOTlzYis5MGh6UkxaWllueE8xalpV?=
 =?utf-8?B?ZlRmZkgrK3hSd3ZwTW9HOTRlOC9SK0RBekVveFZISHFuRGRoWStlRjg0MldP?=
 =?utf-8?B?YXVmVWtKcmlPeUk5NjhTQThSdXdlaVdhTXQ0VWlTcFBuZFdaTFovbS9RL1pl?=
 =?utf-8?B?b1BzVGd0c1RJZUI5NlJhYVZzdi9SSzV6RTUrdWJuUElMYnVjdWFYQnl0K0kx?=
 =?utf-8?B?dWVaR2dlMGNkcFNSSTFUdG5ueStJQkh1eW50VndWZm5qTlE1YnVpd0xpd1BR?=
 =?utf-8?B?ZGEySE1mMTVzMk5Vczd6SmkvY2N0MUNKa3NkejRjbXZFVkxhaFpFb0dZZngv?=
 =?utf-8?B?ZnQ3NHFteUVTYVJSSGlpbEgvVi9uN0huNmw5Y1M0V1JwTnVZYldQQm9DeC9R?=
 =?utf-8?B?YzJPV01oZzlsOWVEbEZtNUxZa3V5K0NUaUVDZG1nd2VTMDZTWWowQWsyQjVQ?=
 =?utf-8?B?WDJqcmxrWnhHTjdVMDZDT2crY2NMc29mTWZVQ0pPdzlFd1hxeExyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b395d-e55a-4d8b-4949-08da165d0477
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 17:03:19.0135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN8I1nYQ1jYuggB8733x5wbQZRwgidufWuUNeZeawPh7QrK4Mr+5s4r4b8GT/8JUrbAFP7ebzfwM5EhIpwE8Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-04-04 um 12:19 schrieb Paul Menzel:
> Dear Philip,
>
>
> Thank you for your patch.
>
> Am 01.04.22 um 21:57 schrieb Philip Yang:
>> For VG20 + XGMI bridge, all mappings PTEs cache in TC, this may have
>> stall invalid PTEs in TC because one cache line has 8 pages. Need always
>
> Can you please rephrase. “may have stall …” is really hard to understand.
>
>> flush_tlb after updating mapping.
>
> Maybe:
>
> So, always flush_tlb after updating the mapping.
>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index f0aec04111a3..687c9a140645 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -837,6 +837,12 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>           goto error_unlock;
>>       }
>>   +    /* Vega20+XGMI where PTEs get inadvertently cached in L2 
>> texture cache,
>> +     * heavy-weight flush TLB unconditionally.
>> +     */
>> +    flush_tlb |= (adev->gmc.xgmi.num_physical_nodes &&
>> +              adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
>> +
>>       memset(&params, 0, sizeof(params));
>>       params.adev = adev;
>>       params.vm = vm;
>
> Did you do any performance measurement, if that flushing affects 
> anything?

There probably is a performance impact. However, this fix is needed for 
correctness. And it is very specific to this GPU configuration (at least 
two Vega20 GPUs with an XGMI bridge between them). This fixes a 
regression that was introduced by recent changes to the TLB flushing 
code. The workaround was originally introduced maybe 4 years ago.

Regards,
   Felix


>
>
> Kind regards,
>
> Paul
