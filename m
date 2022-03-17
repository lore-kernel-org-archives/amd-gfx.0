Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EE0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D9D10E1F4;
	Thu, 17 Mar 2022 13:58:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E97110E1F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gma8CX27JDkdT921B6BITNpbkiSxLVlxdklpfIhbHN4DTb9RuFCfoluVUS1dOH/hRyUp9CxC2LfU0K44a2nzl3NqsIEQ+fsZtRAar+jcAjEkH2RssFRzMdRmvizDFwwNRgqi4lvNJ7l6/DGcaNwd17or4XGQW4ONr2FBL4oF54v9LmyEpCouulL96xyWYbCDbE6pr97H5zAyNTQFxOhpzJKKEkdtzqfafgTSGjhEf7Tx4i2XxvzlSmS+eccvUvhTEDWif5nMF7Qu/GwvS7f2HBZB2lQuWCdr92J33DeQS9TJwND8SBuRLjuxyqgma7LM85C0CYp8zwqf5cPQzX2Qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGZtydsGVLlv88yIrRZcOIDAvNOQ1otTZC5hUBbYgaQ=;
 b=Lh67mdRx63hwqi4LeM7Idv9btMOi85jzwU5ikd+EQtaGoSsiEC4ihKb2uMNUnAyuG3Dlqcr7Lf//WQulZg140/mQEN3eC1IBvji8p8g3B2FYyXNYoFqoa4DC4vrXJqiLNkZ7bzj8R2bUd8o7rgMcPplYCEVIqvLqT42qqxpZutmYuu+ZDIk0ls82J3ya6uaJtQaME5C6Uld5acve3FO4sRGw6IBWa2A/BkPLv398hi0PadntjfRrJTfYMqAF1j8ygB3hA/CeP21C0nrS+vkZcuqmWqPWcLPQaU2EJUW6EofsJQ+8r4CyiVRZgITwA0r2hm6qg3Smhhtoo1EG9cufaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGZtydsGVLlv88yIrRZcOIDAvNOQ1otTZC5hUBbYgaQ=;
 b=aF1dfGmfrwQH8jd/T8fABNLH0KVX0GMcZIOtTNDP6f+oTOjRIdqfVbOyTKHgLVK/VLaTim3oq4mcbrVPZzSlCdVtMWdnak17++z/IMKIPS3nZwN41cJUe1O0mAfuNRyQYWAoFwt8qdkjZ+m6Xx/eZ14nnVpAbeBuQ4Xmmucskck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 13:58:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 13:58:53 +0000
Message-ID: <4bfc42e1-1d85-bfda-3871-17a5d9dc1f7f@amd.com>
Date: Thu, 17 Mar 2022 09:58:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220302202014.2439629-1-Felix.Kuehling@amd.com>
 <525659f9-bc04-de58-c416-ab000c1de9eb@amd.com>
 <DM5PR12MB2469D2F198B4D1362768747DF1129@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM5PR12MB2469D2F198B4D1362768747DF1129@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce401ad4-fa3f-41f8-37ef-08da081e454f
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55182A3A2E3E4C042C21D6B792129@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNT21PDiXN4rd4hwKT4c6K+VLr1904n7KOuEtL48okEU3RxXYuVkEAjtLKhuG0kxmvOiMqjrfzPHgfMJYlxT1ISYNL8bh7P4ux8xBi3XlkRVB7jXU4yD6ngc7gWN7gwPPE+TqYMFBNw0MkoTROZ9aFiRYIga0cAe2bBISXrd4SYcKR3QJhn5H45fFFqmE93p8aQEBzgC+lTG9zwMaQBPYOdtfAgvd2Z/RmxdXS0XBeiCp5gXqRjt1uejzj7J32b2Pwpn7WjatPOBiTKH1ZLkkEcMtMqwZ2HQrGbj2boaR3pB8LZweJWF1QGgScKZnO0KHQH8pt9Q2c0HYZV9qJIDEuuFGvfWf0T1lr8obAgQ8ILAqCTov5P/FoyokVd0SIak0a+F/Hq5ZVFpeUrHl9NLRsB3DQGjdOOYYk93OuUjeDmRXNl/Z+IFC2IYc4P9L62YDryWMZq9bloaUU/SYRLg9Trolhs/RHRbv8/t48dkpia1VgnN8YURYjYhxdI8x/F9DQS7r8cv5X+x/7XWJb3D83njeAiTmSD249dKNFKqPke6RNsHdFkzOz/UeIKioYkb7ieeehkUW4Lz864e80AVvZPRgnyONhLYc55YAhSupaGwri4S5A1shP6G/Hv1nVM1jhC62PgnUxVFkcHlliW6P4Lj2Cj8iJ35all5WkNFsbhm4r+Gu+QPgjjUxDSMGwVFD6FCPBFfc/M5J/yW3ytTAG4MsECQ0hOnab9C7WnNIKWbw6LvWEo3twZutwMnOEow
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(6506007)(86362001)(5660300002)(31696002)(8936002)(83380400001)(110136005)(31686004)(36756003)(6486002)(66476007)(316002)(2906002)(508600001)(2616005)(38100700002)(44832011)(53546011)(66946007)(66556008)(6512007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFLejJRM0RRZmJHaFdOaTU4RTcrWGRhZ0hVM0NmSytwTWlxcWUzNEdPdVAy?=
 =?utf-8?B?R1VydmR4QUlMbGhvWlRFMU9oTEdicFBPRXVDRmhjWnVBRDhnQUU5dWRpdGJH?=
 =?utf-8?B?UExINW1CcVcyRjhVM3J6L0xYb2pOU0QzcFFhNnJ3N3B4UEdzL2xvbHRqaXdv?=
 =?utf-8?B?bk5hNTFnd1R5Y2h2Y2JTVmJiemZTU0h1NDh3SlNTQ2J4RDR1VVd1TjZvVkhV?=
 =?utf-8?B?Y2tYekErdk9BZTRhVFJBUzFVN1VjL1hUdlF5aGMzNjRFQjMrM1pnaVY1SU5V?=
 =?utf-8?B?cmhOWlhJNS9vY01tdVJjUWd3aGRQbnVHYURVbTdySyt5TWF4TnZnTVE1V2RL?=
 =?utf-8?B?WlgxWlVDUmJ1UUlCNGdMT0x1MnFOWW1DRTVFYWc2bElLWUtNMHdaNUVzZDd3?=
 =?utf-8?B?WEJCbFZqZEdXSTg1OERaVUhmN1g3cDhoK0hhYWNuZlg1VzExZVZoMkx4Qm9n?=
 =?utf-8?B?b3hVcUpabGdyMnhkZGV5Tm5kY0dUVlc2VWtyWCtIdVE1TUtOSm5rb3BGTVNo?=
 =?utf-8?B?aS94OURTZUdhNm05T1U3ZlVVN0N0Vk1MbExLZkRzalU5OXR0YlJJWkdNTU5v?=
 =?utf-8?B?RWR2eEs3TE9neEFOZk14VmxKeG1TUEVDS0FuckIrNm1xZ0t5aHhyT3o4eVE2?=
 =?utf-8?B?QUNWTWs3cmlmRDhaaUYxMmNOeHVsREFUWFdaelozRmVKZDFXTVloR0FoTFhV?=
 =?utf-8?B?WVA4bzFJaUMwM2psWEFDRDFjc0JqS3VDTCtiQVZVeW5LWFQwZDN3ZXlqSm9p?=
 =?utf-8?B?M0VvRWY2aHBPQzI5OGFtbnRXSG9uVXo3cmhQeHVQbm5wUm1nSXVuN3QwYXVF?=
 =?utf-8?B?WEt3TlYraXZDTVdVWS9BMTlEYlNRRVpEWElGMFpYQnNpci9Oajg3NjYvWWsv?=
 =?utf-8?B?RHhjdEVHcWNEWVdkZitHUEh0ODc5STcrK2hnekxBenM2NHdCZWdsL3JTRE1z?=
 =?utf-8?B?b1RoWUpUcktiMDFuVEtBdEJQazFpdHRUZEpnSTM5Rm15L2dBVU9BQ0RJZlpS?=
 =?utf-8?B?VkVMb21HMk9Bbm5MR3R4Tzh1cU9kd0VueWxBa3Z2dnJhanV1amZoQlpjb0xB?=
 =?utf-8?B?ajZnVGo0TVIxQVpqR3A3bFQ5dHBFVU1kUFUzWHRxYmREckVYcm5KR1FMSm5I?=
 =?utf-8?B?Y1lxV2dOY0xKNjFDdjhpVU9oVWh2RjZzZHFoWVRnaHpKZysveHA1czUycVhF?=
 =?utf-8?B?NVpTNEVIb2RTY2oxWUxjNEVvNy9jWFJhcHZCUUdwWGRyVXR0dm4zTkRnNEp0?=
 =?utf-8?B?NkdyMXNkUXBkNm9ETmpybkxra2M2UU5IMHVPZHdQamJtR0szOUJRYVFQNGtL?=
 =?utf-8?B?WDFSUE1UbUFWVVVFTlltcW5DN3h5UEhlamNCcUtGVFh5NitQWG02S0ZtcjU0?=
 =?utf-8?B?VForRTRId3A5RzB1Nmc0dHg5ajFCMGJOTkFXbFgyU1ZyN1dUcnRHMGpRbUMw?=
 =?utf-8?B?T0VqeDAvNlhnZTFhVGZSdUQyOFZEYjBSc1Y2Qi9lTjFGTVNpZHppaFUxZkFG?=
 =?utf-8?B?VnFKYk82eFdXbER1NU1zMS9CYlA2MzJnUTRrSWwvRWhjb2lvTHNlcFBVS1BF?=
 =?utf-8?B?eXdVVkRuWGNwTjNoLzBRbjRmMFFoNEVkdHNYQWd4SFEvZTRXajMvdEtKeXpw?=
 =?utf-8?B?Nll2WWZxZUtnWHEwSkZ4cVgvMVE0aVp1WGVGQldoSmdESTh1WG9ySjJUUFhN?=
 =?utf-8?B?RGZLSG1Icmh4VjY3SmZ2QmZPT3FGVE9abzVON0JsVDFzanFRZE9wN1Z2bHVE?=
 =?utf-8?B?Q3EwOGJsY2ZSYVNhYkxlRzlGVTFjY01jQ3ZpYW9RRWRhQmVkQ1RzNDhjaDVt?=
 =?utf-8?B?b2ZCWDNlL1RYaCsxODlrOVhtT1FaVEc0eGtNMkp0YXdIRmZqWWNXcG1xTUhM?=
 =?utf-8?B?VUN3STRjVnFEeVVxR0tXejV0YlZHbm1MWWh6aDI1Z05JYkNQRjkvZndqaXVE?=
 =?utf-8?Q?hQ49SXNjjzpDfqLl4jl0OwY/OrNFeje/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce401ad4-fa3f-41f8-37ef-08da081e454f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 13:58:53.2741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdQmYsjaw2TqnjbKTvTzmD71hzkTrXtrnluJIen6VAFGgXYboFPkjsAlnuox/cnH7FjTxjcqG58uSHOPBfpd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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

Am 2022-03-16 um 21:01 schrieb Chen, Guchun:
> Shall we sort it? Anyway, the patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Sure, I'll sort the switch cases before I submit.

Thanks,
   Felix


>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Thursday, March 17, 2022 7:33 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
>
> Ping?
>
>
> On 2022-03-02 15:20, Felix Kuehling wrote:
>> Retry faults are not supported on GFX 10.3.4.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 7c2a9555b7cc..622eeda9ea45 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -568,6 +568,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>>    	case IP_VERSION(10, 3, 3):
>>    	case IP_VERSION(9, 3, 0):
>>    	case IP_VERSION(10, 3, 6):
>> +	case IP_VERSION(10, 3, 4):
>>    		/*
>>    		 * noretry = 0 will cause kfd page fault tests fail
>>    		 * for some ASICs, so set default to 1 for these ASICs.
