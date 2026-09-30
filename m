Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A931FC9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 03:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3351F10F163;
	Wed, 30 Sep 2026 03:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exXMqwQ6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20CF10F163
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 03:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlh8w92291NypzEEW1qC+SVsRMEw56QUCNNMuhikwvGm0CQSUDeWea9NI90JpvFP6Y8LNkVkXl7Nf8w5xoCgE9w8Ip6NlWf/WSBEpllPLWR7vyDquCQZXHtniJ6oPqbs6ekS8GZdsJ3mxjn/JCJbe7pXeoRxx86AdYo8VXuDZHIB25XtXUrfhuuhyXa7lUVZQCfEQzVVqy+sJ0lo8RRP6AWaxkavj/2N5tP5au2UWFkZ5JAWujRAIgMWwfe0dTBYChvGtlwvwnljCo44P23lbs6HriYH8fA7GuxR0CxWMO1GgqpqxTavoD/tuyxN7MJ9EXuWecZl92ylkiaorojg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8rftt8f44F/tcdPg7IHZDXI6mJY+lrlqVNnr+pYxXI=;
 b=fs8ipc1hhIPfUJuINtHAIrlkdpijKTFsBV7896ALtFLPur/3aXVFPYD1y8WgKGqdoVWcTtZG9153a0q28v/KCYzmuKz+fFCpwnSUx8SP3LZzIyQG/OTbkxIbwfN9TjWL0A5nw7cQNVQj9PfZB7UX31+2x1uAk0xNwq1xvXDglBlj552W4AP7RwDoi5fl2nVBpQ2m0p34D4AYMmCnBoMnDTS+gdEEFxrWoSWSuilFufgqBTCkBYktuIh+xwZF2SGpL/72dQBXC2RZVoj1oGRoHp1y/+dk3SylMeAKan/Yjp8YZOLGkBzbJCndj7zgPOqsOSbWDTMXdv/ZwXITGQZuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8rftt8f44F/tcdPg7IHZDXI6mJY+lrlqVNnr+pYxXI=;
 b=exXMqwQ6zWXVvpYtxewNR2zJUClAkwr6Oc0ym9o8AVqrWKJcg8IXZvaNT9v4wxzcKCjp1fqfUNqS+jbpiZ1pOGoEwm59wEnI7pyjUt3YVEs191sOKvXiY8XfHLFr+j8m1RJGQduVDcp3zaGF5vsFWp8CQbYBk72CK7mZxuyYi1o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 03:36:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 03:36:54 +0000
Message-ID: <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
Date: Wed, 30 Sep 2026 09:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 7063fcc8-0607-4a06-2373-08df1ea41230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ysIHzH2R5GQ73qRz1askbtEJhG3lRF7RZomCGVVwyrQ8ZSnc9A4k/UckBEeb3sb4Qk6muqOlCirMvgpQPhxd8vztIEqwl2aeUbVttnhm5wUFd9iIiioExBZbUNoHc/Xz9iiTfuYIoSI7jX6cz6t2+AcOWOQ/IXHGzMZHRerQcraBOlyyS3cJ6VlWBqlAqdh3lMgKZb0WYga8umEs5s2VgcXaHmFY03+7fiOkAFsXMSS/vc2pV5rRiQ5uEGAEEv8Vv1BNCv+88eA8OrWGxg18rADu/nYBLCMhb1wdY1vd/YU5In+Vwar/gAmAFWAx3oYM6DKrp1BGZEHYFYEhjX+rzw6RlYd1UuOwc31Ww/ZWFMFIqbiHwnVfyqJUlk+qUcOTkNnTHJmNZPts6T1MorI5AruPZdRTJ4E+RejJZT428VAsBA5WvqnKQBT9ifpZTSG3JsdZV6Lned/UMDmgwkmdEZlmmbNlAlg7eRKjoSCr6O4BEu2So7ZKVL65t90Pvi6BfjLquE87HHCnhgbwv7fYtH0j+IMLRK04eq8U/fnxwQGQYGlbg2zJRMnj/3tfUYXtevLAn8jI5Y8swb4oj0fQVrQkityY931H9EtEBBNQh0kOkSVBbtUmtFFjNBDKswD0q3ajI2hWpjJa5WjbEmkss9aqLKeQjzN+TquRXJJ71D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BiaUJ5VzZoSURNTU41aXZTU0Noc0dVYlFHdHMzYnFodzJzQzVEanVyaXdO?=
 =?utf-8?B?WmVYenFvQi9seFRuZmtPK0N5aHE1TUduS2d3VGFvdG80Tkc0UGVVakRKS2ZU?=
 =?utf-8?B?Z0plWGhGczRkbURwa3YxYndlTkJBVEthU25IdkE0cHVFVjJqN2ViTiswU24v?=
 =?utf-8?B?d3FLRFdrOHZwOU03Y001TUdNSWdZMURRQ1pRWmZ2V3pOS0U5OWszT2dXZTJE?=
 =?utf-8?B?N1JvcVp0cnZTWWxJVDRRK2l1bU9PdXlUOTNiMFd1USsyRFZZNExVZ1czYnBN?=
 =?utf-8?B?R2hjczhNTWR5R09sODRhMHhQcHBld2pXREoxOU1qZm1HWkk0bHFjVzBxUDd1?=
 =?utf-8?B?dlZzb0ZjUnVBNU1TMHFla0hpbW1rTVF0YXNaWm4vRkN4SHl1ejFEejRrVWRF?=
 =?utf-8?B?dm1JZ1M4RzFxY0lka0VLMEhYOE9qN3ljYkJ5b2dVR0owdmp2RGdVNy8rN3hT?=
 =?utf-8?B?cDlMZWZPbklqbDNiTW9wTllnYU5iTzlzT1ljTW1LYU04dXR1bDlyUm9vN1dZ?=
 =?utf-8?B?b0I5bnhBalY4T3EvN3Q2WnZmck9rbFNoZDBXNXpnYzB4aThZQWFlcC93Zk11?=
 =?utf-8?B?bmZUVWdqeG1pTS9CTUFHU2t2eDJSRUsyU2o4Tmh6OXp3azBheHlNcTRjblZB?=
 =?utf-8?B?SjFmMnA0QWczdlNJZTV4N09Ya2F3cXQxZFhiVVp0cUdidzRnbmR0b3JCeGVy?=
 =?utf-8?B?ZGpjdThYSm5UamxtdVdLZjcwRWFCZytqeDNxY3Ntd08rdFh1THQ1dnNFNGV4?=
 =?utf-8?B?TDNpaWJla1BKL2JzMFN1dWZZMHdWV1lGOVh4ZUZqWlVJSEs4K3BQVjdOWFVC?=
 =?utf-8?B?eEpKRmw5UzNYaXJ0TDhLTG9jUmRvenF2QnJlWHBWd2x6NHhPOWxkbmVuV1hn?=
 =?utf-8?B?MzY0SW9sOUdUY0ZlZndPaWg5VW5qUHNoUHJrd2pSbmg5S1IrL1NpZWRFUXpZ?=
 =?utf-8?B?R3U1M0gvSUs0alU4QkJLYmZNQVZxZmdsVThTSERXWEY0RlQ4NFNKWGwxbmFZ?=
 =?utf-8?B?SE1QQnk1cmFJT283eTRaUlBLOEdxeFY1QVRkQW1oRUhWanBTamFtOWhONlhG?=
 =?utf-8?B?OHhEc2t6RWo1RWdEcyt0ZkRSSmRoZVlxM0N6amtIaXppd0JqRWJrWWNmai9Z?=
 =?utf-8?B?YzduK3FsaWo3ZUp6WnJ1VVB1NEZNZ3ZRZll4WWd1L29iRXJ4cVJNckErb0c4?=
 =?utf-8?B?ZGRmWXNMQlNCYm16b25QampCYXE5RWFkRjhKcytoYm1jZ0FUNEU5bFViVERi?=
 =?utf-8?B?RVV3dG9JT0VkcG5lcXhIMnE2TzBtcE11SXU0M3B6Z3RhU3dCQlBDaUxYRm1U?=
 =?utf-8?B?UzZNVk1aZTNUd2VzMzdXdFRBUlRPeklsdkZDYVBTNk5RSUV4S29aZnpncG9Y?=
 =?utf-8?B?b1g5czNNWWlkQU9QVE53UnBlRkxxS2pjVnk5TVF4Ujl0M3dyT1VRT3ZDWkQ3?=
 =?utf-8?B?QmNKeXVXVWFJVmdvZkhsRmZZMVhGNm1IL1g5Rm8vb1JPVGhmbForREtxeERq?=
 =?utf-8?B?dy9pYldYcENvbnE4UjJjM2xpLzhNUTg4ZEJ0RmhxUTFMOWIrWlhqU3NxcnRj?=
 =?utf-8?B?QjE4TVVPc2NZZ002d0RjK1M2NlQvRHU4ZHNLZXhuQXpZUVNTNVBoY1c2WWt3?=
 =?utf-8?B?VnUwQk9VejNrNFBvdysycTlQZTZSYUpzSURiS3YxVUNaUmVzM2dSRWMvTHhx?=
 =?utf-8?B?dUdqa3IwQ1dXcTdqYmlyV1lWaVdPcUlpN1Q2bjA2MEpZN0pEa0s1dy9EMlVt?=
 =?utf-8?B?ZlMwQ3drYzVwdFNnSjcwK3A4Q0J0aTR0NFNMY2NTREE5NCtQOUVEbFFjNGsr?=
 =?utf-8?B?TGl0Y0RVZ1pmazdyL1pjcHJJVVFHYWZTdFYvMGdhaXR2Y1FVWUxHRW9reWRu?=
 =?utf-8?B?L2tkOStreTF6QWgxK3ZQbm5YVmhQT1Q1OW41T3JqdmowTDBzdUNlVEZiMTNi?=
 =?utf-8?B?bVE1L25UWUYreThxQysyMHhPajI0SDZ1Mm9keXR3Sk50b2FqWVpiWU5UUEFJ?=
 =?utf-8?B?U1VrUTJSOTZ2d2h1c0xqL0pZK29rQlBOQm1teEY1NUNBSllVNktuVG8wa3ln?=
 =?utf-8?B?ZzRVUU4vdjBad0FHTTFNU3h2RkdrQ0NSVVJhTXcxY2pKN1VPZnJvMU9wckVE?=
 =?utf-8?B?MUgrcFlGQmFucWRuSTB5b2xqcU90c2F4aUoxVXFkbzRwMXNoRDFWd0hON2RV?=
 =?utf-8?B?dHlMN01qZ1R4aml0U1FUbkViSzJxWlBkQURCa29qY0ZoSU5yUGVrOTE4SWFB?=
 =?utf-8?B?SnJlREVCSklBamtIOEhHN0ZURVRsM3dPV3hrc2YreVU3V0FESEpzckg2a3Jh?=
 =?utf-8?Q?eTElRAP9/yht7s67fT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7063fcc8-0607-4a06-2373-08df1ea41230
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:36:54.3893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zryOF6PCtulxYugoWIF+Bse/uH2yiTTcNoPw/D6yltz2nVHm9hp1xtVTj8W/nhNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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


This is the behaviour of this bit -

	Memory Space Enable - Controls a Function's response to Memory 	Space 
accesses. When this bit is Clear, all received Memory Space accesses are 
caused to be handled as "Unsupported Requests"

On AER enabled systems, depending on how the platform is configured to 
classify the severity of UR errors, that could result in System error.

On other hand, if you are sure that there is no such access during 
mode-1 reset, we don't need this patch in the first place.

Thanks,
Lijo


On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
> AMD General
> 
> Hi Lijo,
> 
> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data center GPUs? Are their PCIe BARs still being accessed during a mode1 reset?
> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, September 30, 2026 11:06 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on gfx12
> 
> This doesn't work for all (at least on some datacenter GPUs). With AER enabled, this will result in AER errors. Depending on the platform config, some may classify this access as fatal.
> 
> Thanks,
> Lijo
> 
> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
>> Public
>>
>>
>> Hi Alex,
>>
>> I think it is reasonable to apply the patch to all ASICs. I will sync
>> with the hardware team about this change; so far we have only tested
>> it on Navi31.
>>
>> How about adding a common helper and calling it from ASIC-specific
>> code, starting with Navi31? For example:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_device.c
>>
>> index b690a07e31ab..075de681ab86 100644
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>
>> @@ -4931,6 +4931,28 @@ bool amdgpu_device_should_recover_gpu(struct
>> amdgpu_device *adev)
>>
>>                   return false;
>>
>> }
>>
>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
>>
>> +                                   unsigned int delay_ms)
>>
>> +{
>>
>> +       u16 saved_cmd, cmd;
>>
>> +
>>
>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>>
>> +       cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>
>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>
>> +
>>
>> +       msleep(delay_ms);
>>
>> +
>>
>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>>
>> +}
>>
>> +
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/
>> gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>
>> index b250c5e41e45..356e09b7eef9 100644
>>
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>
>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct smu_context
>> *smu)
>>
>>           ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
>>
>>           if (!ret)
>>
>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>
>> +               amdgpu_device_mode1_reset_wait(smu->adev,
>>
>> +
>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>
>>           return ret;
>>
>> }
>>
>> Best Regards,
>>
>> Yifan
>>
>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com>
>> *Sent:* Wednesday, September 30, 2026 2:59 AM
>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> mode1 reset on gfx12
>>
>> Public
>>
>> I think this should be asic agnostic.  Any asic doing mode1 reset
>> should do this?
>>
>> Alex
>>
>> ----------------------------------------------------------------------
>> --
>>
>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com>>
>> *Sent:* Tuesday, September 29, 2026 5:36 AM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com
>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org>>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com>>
>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> mode1 reset on gfx12
>>
>> Public
>>
>> Hi Christian,
>>
>> The no_hw_access flag was first set in commit
>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix the
>> Mode 1 reset hang, but it proved insufficient.
>> I think the flag was set in the SMU code so that it would apply only
>> to
>> SMU13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.
>> I’m not sure whether we can drop the no_hw_access flag after disabling
>> PCI_COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need
>> another round of stress testing to confirm that the flag is no longer
>> needed. Should we remove no_hw_access in a separate patch?
>>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com
>> <mailto:Christian.Koenig@amd.com>>
>> Sent: Tuesday, September 29, 2026 5:06 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>;
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com>>
>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>> reset on gfx12
>>
>> On 9/29/26 04:25, Yifan Zhang wrote:
>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve the
>>> random mode1 reset hang issue.
>>
>> Interesting idea, that is much simpler than trying to mess with CPU
>> page tables in the GPU reset path.
>>
>> The only downside I can see is that we now drop VRAM and doorbell
>> writes, but I think that won't matter since VRAM is lost by a mode1
>> reset anyway.
>>
>> MMIO writes are dropped as well which means that we can also drop the
>> no_hw_access flag.
>>
>> And BTW the SMU code should absolutely *NOT* touch that no_hw_access
>> flag in any way. Who added that there?
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
>>> <mailto:yifan1.zhang@amd.com>>
>>> ---
>>>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
>>> ++++++++++++-------
>>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> index 072d9c4e202d..25b9085ead71 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct
>>> smu_context *smu,
>>>
>>>   static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
>>> +     struct amdgpu_device *adev = smu->adev;
>>> +     u16 saved_cmd, cmd;
>>>        int ret = 0;
>>>
>>>        ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
>>> -     if (!ret) {
>>> -             if (amdgpu_emu_mode == 1) {
>>> -                     msleep(50000);
>>> -             } else {
>>> -                     /* disable mmio access while doing mode 1
>>> reset*/
>>> -                     smu->adev->no_hw_access = true;
>>> -                     /* ensure no_hw_access is globally visible
>>> before any MMIO */
>>> -                     smp_mb();
>>> -                     msleep(1000);
>>> -             }
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>>> +     cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>> +
>>> +     if (amdgpu_emu_mode == 1) {
>>> +             msleep(50000);
>>> +     } else {
>>> +             /* disable mmio access while doing mode 1 reset*/
>>> +             smu->adev->no_hw_access = true;
>>> +             /* ensure no_hw_access is globally visible before any
>>> +MMIO */
>>> +             smp_mb();
>>> +             msleep(1000);
>>>        }
>>>
>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>>> +
>>>        return ret;
>>>   }
>>>
>>
> 

