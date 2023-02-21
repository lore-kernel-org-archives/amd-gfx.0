Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5782C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 13:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199C310E15F;
	Tue, 21 Feb 2023 13:27:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9581610E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 13:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRMglYNJ0VUXFaaRZkNOHzNJVJiSB+K9x0iyDyihSXI+LSKiUazBQ0+MKuvwl70Spw5uHfhIX/fvQ0+9QjXgm1rou+MiB7jMKm7qPIN+Um0ITiOKmR9gtidK3JD/o0HEvSvyYVgmCGvdFwmaYcH5J9HVSONnp+LP5VIdmo0eGKkV/csC7bnDR7C/c8NszVsTXqipuMB5HMbF+9G6dyQZGlk7904RyaZGaM4uNnLjMFx624S4idZqC5VoplRcIg/eHoUqfSIL4cJsVFz9X616f1mFgiyP/nx3RXC6yHrTrVbAEoyVqkKvLqnIMjfBSeznR0446Gv6mBS0tS78fPtdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmUbtP4BzNTMPwiqFv/kEcxtGdSRFZc0ZvvpJ4nVveQ=;
 b=oEIMh6ZoFYySforMXByqqD81TAjqkhzhrWgIq/hVktegGIToHGOGzzsnkVLygQ7F6+Uw4B0RgsCJ9eQRJzfJDU92nCiSCI3P1vzAOmf0ESYxVWrOvUZrGQdT6w7wOY8BOoKiTZtN7p6IbO+A9wUeUEYWzvz+kTUuK9o+bZS0uX5+tG5lqMOIGzFUaFVMVUipwBFxTCegvEDfCxOAzIF5NdodAklBLDuJ5x1oI1mz/lf+sIRBLRBPLAPFDGEaFUTY+o2prnlI2qXub5r7IoVeIpmkO/yHXLFH7UX+h6Wr6Ed/YVTBEb8HIeQr+DAsnEAfNWo47JV6mcvHWf7vBgVFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmUbtP4BzNTMPwiqFv/kEcxtGdSRFZc0ZvvpJ4nVveQ=;
 b=yLUPqF5FsNUrQQRPBqKXgCI+rBwLdMNMuadedn42QrYnsyk40EwNV0s/Km+6ZIJynAzmp474TGlr65kvOYQCGxBIpFATlrYe4CoIp+Ox2IqtaonqJbEVqRmzpV4OPAKqpMfGkHyavt4VvTxApVLb/Jt1aZmwa/eimeirCeodnw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 13:27:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 13:27:15 +0000
Message-ID: <41674c0f-9c63-fc9e-9d3f-0b777924a7e1@amd.com>
Date: Tue, 21 Feb 2023 07:27:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-4-mario.limonciello@amd.com>
 <ebeab4bf-4394-0638-1ab5-697e1bc24a27@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ebeab4bf-4394-0638-1ab5-697e1bc24a27@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eb9da7-cb30-45fc-92e1-08db140f58f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQbwNCTK7Rh1S/WYGs0EJ7M3hgeZ1Kivl5yFXfQT+EghNPAtL5jvmQtwBeckw9mP/3hKQBzbdVC1I03iRwTObOGxb93Cy7P0kzO/H8J35cRJpsldaBC4+esgW0qsURPVqwnYpG1zQJrxmtUV1SG/3FQ/inbq44eMPZhnQ6cHrxviDkDZd3dn0HQPTOJ93Kj19DPhIl7hfBvrZKh0bacDSRYsEmwX3dn3XLmhEVtv8dHl8OK+Uq46QbrgqjXe4aP4b252Ncek6To0bADHh0gqIJ3b/fe0AiIh0LmFXLXDhf8fSJ5UnIfBW4mXG8nXch6kSE1vlDJG/psUjg1TuhRpq5Oh2WTHLK3nAZeBFtFBK8qeqyCr7K6QMjKxRYsZ8TtOSPGygJaTDNGnTe+yPu43N8OeevtiOpWNkYGSv2svU89fj8/Ye6qm+KtFXPrfi3usS6usGrPP83nACUM3CiasRaCHNjpRLh43hx65G5uCM+BvOoq8v44FEtl5ERBz9p8dZ93ZOZxhJj4VaYpI0kZeMcXb9X1qIX4WkO5V+zKOQWt1q1hxtKnGEvuc2zgoY5/PqeUp9+HdNuubw32uAD0oBqyWeuVcdDs/J9JRgTl00loINy/i26IzMGaxctuakzjjlONtGuFKaxvvYEyS5h60tz3aN48tQvNXJaYC22AeQX1ZKO30oDHmnqrq6iDSLgyIqZ3BSxZjb7poO5phLy3G6cbxFP/kcROZpPbxYGlySas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199018)(2616005)(478600001)(86362001)(31696002)(316002)(6512007)(6666004)(53546011)(6506007)(186003)(6486002)(44832011)(38100700002)(36756003)(2906002)(5660300002)(4326008)(41300700001)(8676002)(66476007)(66556008)(66946007)(83380400001)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDREelh0ajZLTVNhTlRxKzFGL0JjS0E4Ymx3WTFnME5CT0RxZ1pWbk1ucXpv?=
 =?utf-8?B?Q1p2dXJPaFZGeUlJMkNhVG9vSFhwZU9hcGJNcDFMUEFpOUdtZXB4a2lLb1I3?=
 =?utf-8?B?MUloYW0vVWFqeXlZZ0psQ08zOHRqK1ozMVlITEZTbU1xcEs2akNMYUZXV2lv?=
 =?utf-8?B?ZlhDWU1jOTgydVRxT1JjSTRReVFqS2pidEdSa0ZkOGRRZ2NEbFJwRldTb1I3?=
 =?utf-8?B?SzRhT2R4R3BlMWhRY1BZRHdiV1RlN3k0VlhkMGZkYXlCdk0wRXhRb3lpL2dP?=
 =?utf-8?B?NkpRU0VmejJFQzA0RllhNUxEZUdqTUVVQ1VreGI0bU5obzJSYysxd1psN2o3?=
 =?utf-8?B?U25wUGlZL05zR0ZaZWFVN21kNlNrWUZmL3ZpLzFnVkw0YnphY0dIRkJ0akVR?=
 =?utf-8?B?K3kxekp4VWtleDBtN1U5OEVBRm1Idy9EYnBsVEIxRWFta2pYay9ZSFVHcmJO?=
 =?utf-8?B?L2J1SVM3OFd4SWdOUUxROE8yZldkcWwrYzloR05wbWpvM1AzeGhvd3ZBTXBW?=
 =?utf-8?B?UXJHWWRFQWJqNDE1RkJ1SlNHb01RSDY1ODRjTXhKMGhZMndjK1YrWEpOMGdP?=
 =?utf-8?B?VEYxMEVsNnhLQ29NbG1SYi9URjl1Q2M3aHIvRWw2bWJqUTZHSU1yU2JUcFRB?=
 =?utf-8?B?Y0NSdjAxZUtLd2JlVmRKVjNUR29QYmRINEgzcldtdDh0N2dWMzFPL1BuOVd5?=
 =?utf-8?B?cStvVVk2NjdNWXU0RFN4Rk1tbDAvOE9Nak5zQ08vSStRdDRPNXE4S3g1WnBj?=
 =?utf-8?B?RTR2QjNNb1RmVzZBYW0rZU5TQjBmS1h0M1RubjlFeGlJa28xRHBrSys1bEhB?=
 =?utf-8?B?aDFuZFl5SjFDOG5VdkN5eFN0NXVFQVJmWnhBdDZjRnp6dmVMT1FYMDFoa2RW?=
 =?utf-8?B?QXVWYTUxZGpmaEwyR2NoR3ZkNW0zMkdJMVY3SUhRaFVWaUdnRFFOWHRLTzl4?=
 =?utf-8?B?TG5oNmdZaVVIdDRjRVdxRmtFV1pBR2tOcHFYcXBaSkttZ1drZXVaUDhSY0Js?=
 =?utf-8?B?a0ZHN216a1JUUGxvbi9MRytjUTVCR1l4bGF2MUV4K0s2ODZuenVCb1dISWpY?=
 =?utf-8?B?WGlLK08zanNtODg0WDdnSWJlV0dPRHJxRlFTZnZxOTNiZThINytMYkFtQkpl?=
 =?utf-8?B?dW9TQnRWVXM0aEZ4cEZMMDdTby90VUZMdDJ6TnVzZmVxRlZjQldrNmdSNnpY?=
 =?utf-8?B?MEpSWXYwSElTQzZNQjZPaVV4cWVVNTM1WnhzQzVUczB2QU5ybGdvMEMxYVR1?=
 =?utf-8?B?TFcyeWtIZi9JNHNjODdSZTBtWWZoeXQ1Y2NLeGNmSEJETjVicEtrNmIxMGVJ?=
 =?utf-8?B?aWZwREdqTVVTMjI4am1WTDFlb3JTTlVsSkpKR1NjaE5VYjUxTlU0aS80L05m?=
 =?utf-8?B?Z1A1OWhZQi80M0JMdHdRdUd6ZnQ0bkhQY01YNEJwRWg5QmEyMlhocW9GUVNF?=
 =?utf-8?B?eFBUbC8wdDRJb2RLaW1vUTdTdk5rekpSNmdYTXRVc0Z6TUhGSDVzUDJFUGpx?=
 =?utf-8?B?UUtEVGI2OW5MMHY5MnU3MCtMNVQwNnE3a3V6dkJHMHQ2NERtWnBhcUVMaUZY?=
 =?utf-8?B?WlNPUjR1aEFXR1Q5QmI3ZU1pL2NuQlhWVG8zeU1mNTdIakdlS2hNRG1aV3lU?=
 =?utf-8?B?NW5aRXlIdlRnVjRNUElCTm5iNkJxamd2eTY3b0dWNmJDdURPcDkrQTZoUzQw?=
 =?utf-8?B?TkU2ZWFmWmNXMGwwbTFVL0F0MXcvTzU3UjhaR1pydThXZ21CcTJIUFphc05Y?=
 =?utf-8?B?S0ZuL0RyY0d4QU9rT25KWERzalpQNDJPay81YzdGdHYwZG5JR1lMWXMvWjlu?=
 =?utf-8?B?TFBDUDB6MUowWVpFUnR1TUNod1VsdmFRb3l6cEFvaTRyU1Y3SytFdzZvZlNO?=
 =?utf-8?B?ei9kRkJsWnpGNExhZzcvWnBwV0Z4eUhqWVZpVEFXR1JQUkhOd0lXREs4azdM?=
 =?utf-8?B?NGxjYmNUZG41TFc5SkZ5Z2JSWjRMK1lxR0RrSlNQVjVlMDZLbW5ERWxKeFlX?=
 =?utf-8?B?ZTE2aVVKMkVxWnRMQ2NHZFY2UjY2TUhnaUp0bHhidkZqWkhXMEVTcHIyOW5C?=
 =?utf-8?B?WlpEb3plVWlJV2F3L1NkeDczeGRCUDdNNDM4NGVUdFRtbjJtZDcyOTRxWTdS?=
 =?utf-8?B?S2kvQ3ZuUUtaVTdUSG40aHp2eU5OelAzV3FjTFRBZXMySXNESTEzYzAwT0tH?=
 =?utf-8?Q?yjLHp971+DSqXriKFKSnAYGl0zf0RUv8cqApmzhOlxw/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eb9da7-cb30-45fc-92e1-08db140f58f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:27:15.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4yLte1ZdVWSuTT43G6VxReskyJimkCpHCkLap3hU7sYdJR7sYISu9mq2YmbApsX1pj6hGJY/CRjxrxmp9jGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/21/23 07:25, Lazar, Lijo wrote:
> 
> 
> On 2/21/2023 1:46 AM, Mario Limonciello wrote:
>> dGPUs that will be using BACO or BOCO shouldn't be put into S3
>> when the system is being put into s2idle.
>>
>> Cc: Peter Kopec <pekopec@redhat.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index 25e902077caf..5c69116bc883 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
>>    */
>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>   {
>> -    return !(adev->flags & AMD_IS_APU) ||
>> -        (pm_suspend_target_state == PM_SUSPEND_MEM);
>> +    if (pm_suspend_target_state == PM_SUSPEND_MEM)
>> +        return true;
>> +    if (adev->flags & AMD_IS_APU)
>> +        return false;
> 
> What is the expected path of APUs which don't support S2idle?

They should staying powered on and not running any suspend code.
Since they don't support BACO or BOCO I expect the call to enter 
autosuspend to be a no-op for them.

This was shown to improve power consumption for such cases (a reporter 
actually measured it).

> 
> Thanks,
> Lijo
> 
>> +    return !amdgpu_device_supports_baco(&adev->ddev) &&
>> +        !amdgpu_device_supports_boco(&adev->ddev);
>> +
>>   }
>>   /**

