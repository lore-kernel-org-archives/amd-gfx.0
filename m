Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B997C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 16:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D2210E2C7;
	Mon, 31 Jul 2023 16:17:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA3C10E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 16:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnaRgWAmn25skpvTFh67Wncvwse3UdTmaYAi+2qpIJQ0ERTcMAy7pvnMFoBX2QOaF8oLEd/FJkzzzybI2mm4+Mi/g/1PSkipHMF/aPHcfvxXbUkjhLAusGZb9Op/A9iuDKzuVgHP4G5ZnJmah1IFrbtRQ66/HmGZcOVrSbTholpqm5Y07ancNiIwAsoUk9fnOKzYKe/HGPQZBPIvpEzin5Zjc1slat9XKF+fZgz/OI11Csk6ozC6O0HDbRbtmnVKv6axscowbCyn06CDOqZA5iWUXwN+rtDQQn2FWo8XUhX9b0NmZt8g+vSrY+7AUPA5WBXjiKPfXazSNJsm1B+QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkji0tyzTHl6DbxKdjoNjSYESitFYiqtqsiJwjdRkuc=;
 b=luOOydbq5yJ5ub+TuwFZSOEbGMjCYKxNaQKJpjI2+AG6tyCCU9vVQxPmiCYnCWBk2iWN/nJ/G/wuoOBFO2XbFXBIw8ihCGNVp12v6jOdTdLKBCFLqJ4/byulSYeQ1zBoYSPA889WolkN927gBFkXSXtF5+7kusZ7cPaGUDyEy63pKgrIwYnQ7W61Elt+WfIrdqltReiZO9zUlczhZ0F7n0xSQuC+kLfDSYncv0wgx+PDluhZXPGgReHJJi/QlFjA+jmWbxTf2BfADgZ5FWs3ixjvsgOGZLAj30h6F/EZfX/Mu5HA25JlWVzfdWyTLLSsz23S4mx6yucs1wUo4e4VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkji0tyzTHl6DbxKdjoNjSYESitFYiqtqsiJwjdRkuc=;
 b=tyP5x8ZHn8f2AsQUqOX8TQ4I36sURA08Gap30Hn51HeTs9fqnlQCwBWrD9lmOcafSwmHgu16usVr4oKiIfsKjRzDHtbIg0auFibex1LCDAtvEgdEYUEPEsFlNy6rzWHNeYjo/HIP8QyjW/pFGyqzjp8DwH0B4SHkbml31TFKqDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:17:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 16:17:18 +0000
Message-ID: <524ee95d-7938-6232-bcd3-443cacbd89de@amd.com>
Date: Mon, 31 Jul 2023 11:17:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't show stack trace for missing eDP
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230731160824.1992-1-mario.limonciello@amd.com>
 <cbfaff3f-6570-4ff7-8376-4824b52b35e1@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <cbfaff3f-6570-4ff7-8376-4824b52b35e1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:5:bc::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4a3b5e-fc5d-4c13-c579-08db91e19c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMXQelYnif0L2m1AaRuaJORaAptr2FfJ3lkAhP7eBUBpqAhwNXcP5Vua75TrJUBYfaN7QnD0Y5EddKidheNsjWo/Oji92jGLVwijaMGrOACH8Y5UieQYA3CDks9CD6s/MxmEghIS69zeyNz3D80YK45mp/kmRF8hKiIVp3bU6nVZsM79XZENAKpIeVUTfS7Jx+pGEKBa6rspIhp7Ze/9/uLGfi92l3aQx5kRuXaIWWRV9JhAI7YKQuJAjWQFopxHBz5xqjPyDGAFaboU0V3QVaeNwueTyqZT7NQNeo7T5WDbcKjwi/A26XnPwm7v8H579dLenk/j85eoZwWuvvNLP8y6iFb7mhXhgJpJyhBHa4q9bI6chZePegdIREdKCzZcSO63pSUCffMr4BvTtZwnTOcunIxS5COrGM6EW3Gv3UymtkBgdKo7IBfPWw2IERk/HJBkLx4w5ti0PQesXrtq9+7asN35TrNHzSvZA/edfzHe/20D/mKMZ1glUTZKmu6FaKRN2fCDxdVRlGx06dShofIFHOf9PgZvVnDVcv45QSPLsOEvqo9kkrwlbYpip1ITdcibAZrTNHQCNWanzG6W/IUIbiUPY3imnoFmWQaYxCo6mNXiRDvlrq00IcTqN7z2SfqheTQkkszBRvPX5wdtgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(478600001)(38100700002)(31696002)(86362001)(36756003)(6512007)(6486002)(6666004)(2616005)(53546011)(186003)(26005)(8676002)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(31686004)(41300700001)(316002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGl6WlMzNWJERk1IOVhNT2tlRVZ1STdBTER1TVRhS1puTWdLVHQ5eXoxb1J1?=
 =?utf-8?B?OHJWVkFaMlg2YXZqeXBrY1RFaXRZbDREclVOQmY0ZkRGYlUxZUlqUHlFTWhs?=
 =?utf-8?B?WHhuRG4xMzNJT3Zaa214MEsxRUJZYTlpdWZ3L05iQitDOVZ6Z0lpVmJoME9m?=
 =?utf-8?B?N0UyQ29UR3V1cWxPYkZ5ei81RG9lQytMbHFhMC93NjBPWEJvaVVIdkdGU093?=
 =?utf-8?B?TkNNNlZacmdxMGJzUmIvUDgzcDVLd1BnMklpWVlUMldFOElmS05TQitFMnV4?=
 =?utf-8?B?aXpHdlNVbU82aWZHeHdHemV5cjQ3eVpmT3NDTzBITElHMDhFWW83Q3J4MERy?=
 =?utf-8?B?bUNDZGNWUWFtZ2oreHVZVnV6d21hVWRXVkdUemhKTnNaNXc0dHYvcnhhbW0y?=
 =?utf-8?B?b25YUlhzandUV3VRcnhpMmtOcWFGQ2RKWThGY0RvWGpiUkdXK1BibUJUTWg0?=
 =?utf-8?B?YlA3aHdSM3hrQVFsQ0dOMTI5RTVoNWZoSkxrZElFUTU1dFIyVDhVZk5BNTk1?=
 =?utf-8?B?Z1ZtU1RuelZOMVRMY0phelowNC9ieVdQSlA2eUJNbVgzM25rb3UvTEs1Ny9O?=
 =?utf-8?B?L1ZibHpLMlhaUW9PaUVIaXZZOXM4SmlMZVY3ajVjNGt0bmxERW1EUHRBeGx4?=
 =?utf-8?B?MmtOUUk1bjMza1Z5a0FIUmhVUUlFcWdCQ3Q1Y0JZZkxtTEVNOE1iSS94WHIv?=
 =?utf-8?B?OXJsWEZVak5yLzNZR1dMWDdYR2ZGa1FYanMzQWJzd0Nsbmw0UEVTTFFDeitN?=
 =?utf-8?B?MG1IY2FsTjgrWHZMaFNGN3BKNGJRUWVBeVhSRkN2YkMyaGNjYXNZWk1FSm5S?=
 =?utf-8?B?aDFZVkF3VXV6RFhpcnNkTWdVOGlsSDhGMjZmK3o1SjZ4K0k4dmN1NWVzSnk0?=
 =?utf-8?B?Y2hNQ2dOZE1kL3VqNUNLK08yaFAwc1Z0MDZiUDBBcEhkako3TjlwTEtsZ2h3?=
 =?utf-8?B?bkFvVEkvRFlWVEJRNTBSSTJ2UXpHTVdqZ1djbHFtd0o5cmYvUS9pTkFPRHF4?=
 =?utf-8?B?Si85bzl0YzlFRUxPWDR4Qnk4RHdWVjVqSWdkSCtlNnpIN0NnUzhLTm5SZVJq?=
 =?utf-8?B?SUF0OVpVRzQ5TE9TZDd0c1haVExkYkFrOGE0SGVZbnVSK2syZXdGZWhxZmFM?=
 =?utf-8?B?aVd2UnFleEx3a28rL3pmMVhQQ29neFNpRWR1bEpnWTc2b1ByaklSSlkzcG8v?=
 =?utf-8?B?WVBJelNBMnF4K3NZY0ZwR0RIRWxmL1V2R0NIUmRlMU5RNVJETDNmT2REcFFE?=
 =?utf-8?B?dEVJZmxzVDFlZjBJcmExenl1M2ZHSUpVYWNiV2Z0RERaNnZnRTJvUk5ZcjQ1?=
 =?utf-8?B?YnB6K0ZVZ0k4UUdiQ1FIcFRROUNLcFlRQks2enVGYXl5WU5HaUphdjBaUDJs?=
 =?utf-8?B?UVU1ZlROR01WNjhLU09oTlFkMFBFdjJWMVJ1SGhCeFV1Vk9JTGlFMGZiL1h4?=
 =?utf-8?B?VjBtYUFqVjlXakJBcGw0K0I3QWpnVHlxOHJ1aDZxNmplOUNGZy9qaG5Nei9m?=
 =?utf-8?B?anhRS3lXVlpvZHdyQS82aTVxZWhKRnpNU1duemEyTnZPQ0kxSjhHcjliT09w?=
 =?utf-8?B?UTVaTk9EcytkT1NqcTZreVIydUUrOWpZclY3Z2gzY0tGOFJkUzVLZE5idlhF?=
 =?utf-8?B?dHBVTVZqLzhkT3NGcTNLZEE4aXdIZE1FOURRNVhDQ2UrN2krVzVYR244WDdp?=
 =?utf-8?B?SWV2ZGs5a1FFZlpIb2F0ZU1FNitCL3pIV3MzSE1VMFlOamNhd1RhYU16TWQ5?=
 =?utf-8?B?N2ErWHJ2T1pZb0Y3cTlmN3ArVk1vTlppYmNRS0Q4R2VmdSt3R3hVNjVsUytC?=
 =?utf-8?B?ZkFkYTF3c0VhQ0ZxdkZ5eVVFTjV6NDZGREE4RHVFYzRlUWhreFBGWDJCTVJi?=
 =?utf-8?B?YTA1Tmt5eGI3OTVPZUJpeGhmeWY3RlVhelhCeWZtK3pGYlJOTGVXaitCYjYy?=
 =?utf-8?B?c3U3blJsR2NHaENzK1hjWlIzUXhFVjBSL2lEamh4dU93ckFuUFl6SHdUbzA3?=
 =?utf-8?B?dkVWM0RFMFB6SmxBUE55SnRicHJPKzlDVXorR3dGdEJya0NSMnUrMlFqTWFS?=
 =?utf-8?B?WDZoVER3N3pVYzlhemwwOUxubzR2Q2ZWUDBOejFRRXhJUWRpR1NVRHorWlpY?=
 =?utf-8?Q?tiKryQ4NVN14Mef/UEWoAQbCN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a3b5e-fc5d-4c13-c579-08db91e19c42
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:17:18.0260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnBcdCuw1FrMWtf9jFa3Hmi79RWOuyT6XNChnDRspxzwG8meAqsvP8oiI3R/90rEXAloYWGEFwoRUySwAlHzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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
Cc: Mastan.Katragadda@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/31/2023 11:15 AM, Hamza Mahfooz wrote:
> On 7/31/23 12:08, Mario Limonciello wrote:
>> Some systems are only connected by HDMI or DP, so warning related to
>> missing eDP is unnecessary.  Downgrade to debug instead.
>>
>> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Fixes: 6d9b6dceaa51 ("drm/amd/display: only warn once in 
>> dce110_edp_wait_for_hpd_ready()")
>> Reported-and-tested-by: Mastan.Katragadda@amd.com
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c 
>> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> index 20d4d08a6a2f3..3ce3d3367b288 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> @@ -777,7 +777,8 @@ void dce110_edp_wait_for_hpd_ready(
>>       dal_gpio_destroy_irq(&hpd);
>>       /* ensure that the panel is detected */
>> -    ASSERT(edp_hpd_high);
>> +    if (!edp_hpd_high)
>> +        BREAK_TO_DEBUGGER();
> 
> Can you print a message using DC_LOG_DC() here instead?

Sure, will respin it.

> 
>>   }
>>   void dce110_edp_power_control(
