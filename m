Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E00DEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD1810E432;
	Wed,  9 Aug 2023 12:43:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8685210E432
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1pbMCczFEm++9muTz3grThbYNOPqzeDds62EGFpkjkgcfghCmt6C8cqIy5+o77QVUnuw7BynVGj2B6GnkbIQmWLGznxZhW6RbQisZJ02Xf8OH500Ymnnp/HFFx9wrsM/wWpHPmw4bVqtYrzAoXJu/nR0yAG/3wkmR0pdoY/p4g4tzQEQlQDzbamF4CvTt++wn+ChVlIS4clOVonRT30QyrA+MHfUZteqeQzVw+EvzGYD6EWE+o/3hBTIBFEL7Uprh+luyA/hGSfkZWAGsdA9O9b9qDzermZF/Ixx9bxAnvUjVt3W1loRxjKwK3S7k+BknUGOjqdpEBjK6glb0gZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxouxo2kKqrBgbBN9rB2D/zkXqR8Fsh8wlfZl960Kjs=;
 b=ftNmu6+BJuVSYP3elT3wsbVekDnm930SMD3Ahivhfwfqb/xByJfa0uhRhn7b4sXqOOYLRSzZ80k6Y060aBESheU9+juRbh88nVG+90yeTdM569+2oUxbtQFTf7RChwBNXyIHQPJagWVbAspx+UXSl8pY4o45kDuD1rWMRqN4AJWpTKhuSkQcRdDg0E5rD3AUw0Sf/Tai4ltswfNq1eDd5Gt0L5ljcQxJiSspS21yInLsQ34HqriRS1PuUxH31xw4S991XDU+LIKhuEFOdcp9qQAN0IliMo0ww9eWnwUGIEaZ9TS4p1Yc0cwNJwdwZg7Sk3NFFlO+SoP9cu7OzfS5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxouxo2kKqrBgbBN9rB2D/zkXqR8Fsh8wlfZl960Kjs=;
 b=VO/b4wfnWpgc8oW7+2LV9+PEyV7IDM93rnrJt9txgILOmhxxUlmNhAfg5y6IkIa1Cdc6SR5/DGjfB57ZFsZKAnIW5QuuFTjcsrbzNdeOBf/aVT49I3vrbwqMgGZp88JCBf9bH9Ed+BlwQJcE88crGn9/WFwjl2WXq7eqxvTWJAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:43:10 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:43:10 +0000
Message-ID: <a7da80f8-d9c1-ef8e-d8a1-b0e57dd06d60@amd.com>
Date: Wed, 9 Aug 2023 18:13:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: disallow the fan setting if there is no
 fan on smu 13.0.0
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230809101235.285114-1-kenneth.feng@amd.com>
 <CADnq5_Ot96o8RdopafMVOT6jZKgfkuxTOT4CVQJ6k8aBVPNBSw@mail.gmail.com>
 <d98258e6-ae06-f353-0fc8-a2add9cfb1e4@amd.com>
 <CADnq5_Oe2rG58c3LSCnP9S_xA4Xh+=2Aqqr-uv3j6CeoZCF95w@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Oe2rG58c3LSCnP9S_xA4Xh+=2Aqqr-uv3j6CeoZCF95w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::15) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4711db9e-3ec8-4a38-1810-08db98d63013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShTkU2HYbYFEL4NjMWuewj/xUuGgKCdrqQYPnOF9bt2DeKF3Kgtf4zIwlddhBxRMDFtxDj1Yktumx1yikUstCvdvJgU4K7o+/fp0vizl8Z/R1hYb4K8aiTxE4oRMA73A7Mu6599/HgtFqXL0YPzCsavpHLOlGkBHBaUWW8hPMK0LOaTrWZiUKn65hArKEZUNK1Af5pO5emBp2a7yuL+ooCu31O8gVDxww36xtvcjVsZ11prAHCK0qC5dJHfZ/raCuIcbSlNZ/eX/braZBtt6YKxxAa2j0NTxsy0o0BKL26oosS06NoUB1KTV4Xyv/W5OxDCEX0h3t+wZxFpLNa0KRHlg3f540XT2V/MsHeo9/1FwcBbnobCICQgCZ+rHtABw2rOWdImd6KIlfG1MBIS3jXAGxpAC61FzM+Me5FMXCPOkgEkNW9P0Ty9VSgi4BKZWPPTFamXxJnCkri4dkhJwInmfGJjKPpvntWoLE/xRSnPpnkK+jyQTop5qjaBDs/SS6JeQZ+A/cIhkHm7wNs1e1d2AtJDmPCsEkrxD6fquHWOI1xJJfsTTqlKihE28JOZonLo8SVKu8G/VfeCAMnSCGnidH40sGi4/vInOwEJbaoiRretFVfT49JeB+onekikHvfcUNUOEI5C5EshI3Pd2ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(31686004)(83380400001)(478600001)(2616005)(6512007)(53546011)(26005)(6506007)(8936002)(66476007)(66946007)(66556008)(41300700001)(316002)(8676002)(31696002)(4326008)(2906002)(6916009)(6486002)(6666004)(36756003)(38100700002)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtYSE1xa0tpNDJFcVlzRGtlZU5WOGdralZ6Z1BrYWJ4RkxCbElQRktZbEZR?=
 =?utf-8?B?UzROaHlWUXd4MFJWTlJYVU14OFFpWTdVOHFNWk9kMHhhWERaL1F3SVFFQUY5?=
 =?utf-8?B?alluODdrcDhYbEdQZ21sbHRodW5hUGlrdDBicTJZOVplTFNzT0dnK0VQTzhT?=
 =?utf-8?B?ZUovbkE4N0wyMWdwd3g5cURFV3AzSGpkSHJlVUVvRUc3UDRWeCtpT0Jza3RD?=
 =?utf-8?B?dXhLb1lNb1N3cnVaUFp6Z3JDelNZV0hzK0pWQXA3emc0ZHlZY1piMks5K1Ar?=
 =?utf-8?B?T0dQbFlpVFpaWmM0RENoUVBLTGswZ3ZDanBWOU1SYklaL01JcDRqdmVXWTFL?=
 =?utf-8?B?Ti9uY3lyWlpxbGR6M2txeWRhUTZITWdQOUFRN21sa2hTSGhQVUhqSndjaGdY?=
 =?utf-8?B?TmdRUFBtdUpabjdhYlVhOTViVnVtUzRsbWNncllMeUthOVR4dy9odGU0OEh3?=
 =?utf-8?B?VDAxR3RITWpXY3BIVEV5WUlxc3dkNXNGZkJZdGsxRWFWWFhMTzViZVh1czhh?=
 =?utf-8?B?dlc1VnlSNi9PbXlGZzFiS256YW1tQzFheU9xeEJlWWluUVdNLzBDcE5UTU4v?=
 =?utf-8?B?Vld6TFBmR1NRWjd1RzJpZkpQbGRBOGN6dkRNejNpaHNqOGo4aFlNS3R1YnBi?=
 =?utf-8?B?L25NZ2ZPM1pGc0NidW1aQjNhRzZWK2dxaEc0UnVJL0ZHL1Q5YWFTdkpkMlRW?=
 =?utf-8?B?WExHUzhoeE5tTkRQYTRKMDFORHNQSzZlR3NURnZuWS9IM0tkckFtQktSdnlT?=
 =?utf-8?B?VzFmNHRJSi8xUW5iOWN5WGlsbnprQzdnT0RyalI0VVpIU0VFbUNmdjdSNWF1?=
 =?utf-8?B?VE8veXJUNUpJV0g4RjdSOVV0R0QyTnBtTlp5WU5oZVVCNXYrOVQ3VTR5UkUy?=
 =?utf-8?B?RHQvNzhjYi9USGVzMGxBUkYvYXpQbE5COS96ZVg3TTBMNWF1eTkyL0k0UGVk?=
 =?utf-8?B?cVhlYUhlSngwa09ZRngrM3ZrMTRjaFdVeXJJbVJwM0E5RUpVbXlwK2xEMjc5?=
 =?utf-8?B?Q2pYY2NyM1lXS0I4d2dSMjZUaEVVNVFPZWNrOHJBRzE0cUNRVVEzMVVNcTYx?=
 =?utf-8?B?WFNJemRkU3Rnd2J4NDU0UHovaGREZjNwWTQ4L0VHNDNIbld4QUV0VXZYTkVP?=
 =?utf-8?B?YjQ3a1RtMlJMWmdBT3IveC8wVGRSajZ4ckZCcjBGRE9OS3EyTkV1L3dBLzdZ?=
 =?utf-8?B?VlIrZXZvZW1NNEQ5ZkhhUEtXR3dFSEdjNDNhbDgzTTlzNXJ6VXFqaUtXejZ5?=
 =?utf-8?B?YTJSV0FTSFZMSXRjdTIxSE9qTExJd29wUUxjaEE3WVNQc3JrSVBURTB2MytM?=
 =?utf-8?B?VG5aTmNjY2prZkpGeGpRV0dRdXdFT0lVWi85Y0ZmNXU2eHdwVzVKcDJPQksw?=
 =?utf-8?B?QU1BSCt4MXN0aHlweDBjSjBDdTd6N1FNWUhhTTRpVVliOTViYWVnUkMxUE1S?=
 =?utf-8?B?S0pMUEpKaEpJTUJ2WktSM1pHUjVLV3NXTUppNTRDamh2Zk9mdlpCdU9xK3BR?=
 =?utf-8?B?OW9rM0c4UUxOSFdGb1NkTjhnQTJPVWVZckpFQlZ6SGwrU0V0VjVlVHJSYlYv?=
 =?utf-8?B?ZnZnNGZaYTF6ZFJ2TDcxVkgxSnVpK3JJcDVubUt3akJrMHJrTWlybFRya2Vv?=
 =?utf-8?B?YzVhTGlHbEhlMlV5TnRteFllTGpBb1Rib1JrK01ybVJlV3lzUEJLMXVYOEk4?=
 =?utf-8?B?Y3NFTWw4MFJRaHlXYVN1NnBHL2Uwa2x3RTRYd0hkYzFtN211MG9nS2t4QkhM?=
 =?utf-8?B?d042R1FxVFpJZjF3UXU3TGV2UFkzdzg4T28yalV2b29uU2dIVWMycnNuOWFW?=
 =?utf-8?B?ZXVKMlBjMnZmeldOWndYakpDN012YVZhMERqd1lKS0hGaEtpQndEWEdUU1Jo?=
 =?utf-8?B?WkwrU1J6UFJuSm9sSi9vNTdJZ3EzM0ZJM09sVml5YVJvbmNjNmswL2lZcjlH?=
 =?utf-8?B?enNsVnNxV2hzSlFzT3VNMlhmdFFWRkNLYXBIQi96OElxMndGZ2g4NEhPdkxR?=
 =?utf-8?B?SmlqZFJOeG5UN2xBaFB0RlgzaUVzaVJMWk9YWFQ3V2RZbytkUUcxRWhaSkpq?=
 =?utf-8?B?ejNGaHJBci9xdHAzNm02djl2bXZFSzRGSENjM3hVRWFNcXFuRWpkbGdnWXlV?=
 =?utf-8?Q?JvXXnqdT4iXIks4UsZZEgtk/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4711db9e-3ec8-4a38-1810-08db98d63013
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:43:10.3777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wcrW3CPLBp0GCAg+Fb61FqbcbjgW+B+GM540yzAn6txRS8+zCJmeY7Lpaq1Z5YO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, maisam.arif@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/9/2023 6:07 PM, Alex Deucher wrote:
> On Wed, Aug 9, 2023 at 8:28 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 8/9/2023 5:50 PM, Alex Deucher wrote:
>>> On Wed, Aug 9, 2023 at 6:12 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>>>>
>>>> drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
>>>> V2: depend on pm.no_fan to check
>>>>
>>>> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>>>
>>> You can still read the fan speed though right?  Don't we want to just
>>> not expose the ability to manually set the fan speed?
>>
>> If PMFW is not controlling fan, there is no guarantee that the cooling
>> solution (any other external one) is using GPU's fan controller itself.
>> In that way, reading the speed from controller doesn't make sense.
>>
> 
> Ah, ok, I misunderstood.  My brain isn't working yet.  This is for the
> case of the PMFW not controlling the fan.

Yes, not the overdrive related control :)

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> Thanks,
>> Lijo
>>
>>>
>>> Alex
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>>> index fddcd834bcec..0fb6be11a0cc 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>>> @@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>>>>           struct smu_13_0_0_powerplay_table *powerplay_table =
>>>>                   table_context->power_play_table;
>>>>           struct smu_baco_context *smu_baco = &smu->smu_baco;
>>>> +       PPTable_t *pptable = smu->smu_table.driver_pptable;
>>>>    #if 0
>>>>           PPTable_t *pptable = smu->smu_table.driver_pptable;
>>>>           const OverDriveLimits_t * const overdrive_upperlimits =
>>>> @@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>>>>           table_context->thermal_controller_type =
>>>>                   powerplay_table->thermal_controller_type;
>>>>
>>>> +       smu->adev->pm.no_fan =
>>>> +               !(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_CONTROL_BIT));
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>> --
>>>> 2.34.1
>>>>
