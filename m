Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3BAC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 22:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B06697536;
	Tue, 12 Jul 2022 22:57:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538CC9752B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 22:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdXDUaH75zz/4FbnN5Jg5uVj474UP9pyTdZsqjwWL0l9F/ubnC8rVBFvJis5xwrUn53pP2IPsY/Y/gwWuQb0/b0SZjTMBsM6lwKy7lABuqNmXny7W+kuwzGQh1lh86YiBGZmyX2RLLNYSzKMk/yDQcj2x8yEiU4zNYCKZ+NPxiEslHCiKBccMjjmnNT80puM3a6CTzJz1e5LtXqCRSKrgrRvNrdysf4gTUPMdiDA9eWfUvRUADFlZGhODt7dfvxXyzaqLCtCLlvpwQAXoXquGfmDAwEhfQl/6YbocpIlNscRShW9BZLlTstzkKj0qCN2co2LLK31XCWnvf4/LmMsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAXNDIXN46A0oeJqEgJIHKHFXi/ewwQbIHQ4XOjHp08=;
 b=Q7/0EaAqeCsJbpYUaKt3KHyf8wk61CS8qkFPGD+eJ37JPc26WOyT6OrwpfxcfaTi1L5mrtE4BzG4OsxrOj2330OWUiGh+eL4SqBejxo0Y2fv7/zTw11JnW4bWAOQIKUsBreiT8Dts0o5XkUUzIlLzSEI7g/vJF08HFu+Dz6pEdrO5wHHlVufy8j2YdZUhctnBK5ucgPoLSlQBZ874dQ1NZrSkctd+w5CQB4hSrzP1UmILNbCEdnHRflKy/ul8b4MGrnlMFx7L0pAIR4/i/K77kh7fDYWzT9ZAUot5b786o/pVNZG0OpPT+isV/nScDBVRKkIMoRYu0vwF+ZMLrF1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAXNDIXN46A0oeJqEgJIHKHFXi/ewwQbIHQ4XOjHp08=;
 b=lQhepJ5qIpjCrtKIwxmaebPBNk+FkMgGrP1H4Z7/K2fXNG4VH6avn087g7bNOlsiuHaJiquBOeG5dPAQrE6J+IA+BOumCy9WKeilhBvsSsfOtiZygYXRFJ1b6qhAyJgTJcwjmmlQU3JhGv41hsIiPs7ApHlj5rgmQihjScXht/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 22:57:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 22:57:21 +0000
Message-ID: <fbaa55f0-b6ae-6dbf-7951-bdb1239017ee@amd.com>
Date: Tue, 12 Jul 2022 18:57:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, JinhuiEric" <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
 <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:610:10e::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ef6d18-fc83-4d87-1edb-08da6459e0c9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6021:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZD8ZkcJyDm5ZfLN1BQxP5aLg1qucFRLRe3v64Qi0VfR7/1kRdtVoQYQf2VM4YoWSIFnGVUzHqZ4nM7GM15zwDb02/U3MQhTwvxvQiAv8McpvSDRER0pSRITvF7C0yvWmOHsr47rjoW+ATSf07Ut52OcrH5KPPnPD2jQDmhltQ+mvkMFmqAoFttHLwUJsqWPnumn1xF2WWUAidU8zJ/aTzGi/GXtp2K5Ev96/AK3YcK9ynIo0qNAzH7QPdGNkHiXo0zRybbMXZhD9YyVQIMBaznS95NAmyGinXqCoog9xXC1gd5n4iDTusEjtTEYJOCwx7h6zLoWOabfdMINx0wBnO/XN0sSFg3Px4RKP121U6SowMq4Wc2oQi+Q0sYA12QtqdEPSrUhNwruU4D6SQbwvtTgSoedK+iJE4ivQVm/Q/45761ifIzjBh1gLIhMZiMzxon++CiJVY9WBe9C69nCOCTC2tJjsZAV6xKBkU6pKxNV0VxaTqjtUqVueJfrp46zN5CWQqj2Rr4pvCg5e1HWt6FQFtyEU/GPrNyJLM7M1Mj2u78aOLLqlRHUqXEhqbTx+OSZqpxGR4Es+PvefU9qxrIxqWDH+FQHGLp3ztF5wAza6NMa3XAXDyd8adUDXWwScaVVr0gGIRBBQ1lY+UypqikLq+jWqLnj2e5g5a4U3eHCeOWo3VFOaf5t9Ul/K9/8DVEOGDyihaN7bPuRhWELvTdBSoRyye4eK67T5wAOCXILfAKEJY6gw1BNubfT6L6PRd9nFGB7DpckDdtEJ21rMPad4iVerSADq4Td75qcckwDLjqQA/J9DtJqmdIdLi8Q6S6MDgKGqhvlQdwIOnA3+KVls6y5LERjxicxl8cxWKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(44832011)(36756003)(110136005)(316002)(2906002)(66556008)(36916002)(2616005)(41300700001)(6506007)(478600001)(186003)(53546011)(26005)(31686004)(66476007)(8676002)(66946007)(86362001)(83380400001)(6486002)(31696002)(6512007)(5660300002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJ3bWc0eG5uMTltN1NtMXRvY1NEdk40cnRUQU9RVlp2S29hVFAwbzhEM2l4?=
 =?utf-8?B?dkc0ZFpDVlFSenpSVXg0c1ZqaTFzMEpPTXh0S0t5ckcwWmIvdHF5b2EzME5w?=
 =?utf-8?B?UXVKTEFVSFdYUys4bVBFbU9RcjVncTQ1ZDBncW05ajYyS2VpL0NiSUN4bGg1?=
 =?utf-8?B?UUh1QUZDVW5DRS9kNjMrL05rOVUwWGVyaEE1cGV6dVA3MzlHa1Z6N2hZYnlQ?=
 =?utf-8?B?VFlYajZnN09meGZIcTlyMmttS0FoS1B5RVFHaTBrTkFMbEQ4T1BnS1RyNloy?=
 =?utf-8?B?NGFDVERjYUlUVWRUY2RaQWZGLzVFMEhvQWlJa3RxbFJFbkNDN3NSWE5SK3dG?=
 =?utf-8?B?UDdKZ3F6NmdzbVFwYTBoZkVJNzVxRG81bkFWVjNTZ0toQ2ZQM3l0RzlTRWVj?=
 =?utf-8?B?STlHTTRZRHlmM2VEZTZtT3BsZFVKUVlCbys5Z1NUZGlLQjgyWld2cVJHNmtH?=
 =?utf-8?B?NnZwUE5ZZFhlOVAxYXBvRHZhQk5DdWp4YlFLa1ZDUmFzVVJEK3FIdDZsbGNm?=
 =?utf-8?B?QkNSaTdZKzZEclFxZFpBclRCVkhINW9pazU3czBIKzFOTno4d08rTm81U1VY?=
 =?utf-8?B?UVAzQXc4QVVhdWRPYWE5YzhFRFMzZ29zRUJRd3lobDR0UlpxRFpLa0krWjNh?=
 =?utf-8?B?c0FrZndZM0RSSkpWOEtraEE5Mys4WnIxekE4YlYrUjhxQ1o3SmIvNCtsS0FW?=
 =?utf-8?B?UUxrcE5WOGI1Sm8wUTIvUVdqVnRwL1FjdTNYeG1UdkdXdHFBd1ozci93d2NM?=
 =?utf-8?B?WGhBT3ZYRCtVRTJQWmZmeWxzSHFDZTNzMkFhcmIzQXdwL2J5bFk3WVZnYUd2?=
 =?utf-8?B?dzM5anNuTzdpN3dqazM4OHZtVHc2bVZyUTRPcG5yR0tEOFRuQmowZGxkYWxm?=
 =?utf-8?B?ZS9GYnV1aEJWOVhoVXN6N2ZQaDJZeFExQk9qNEkwcjdtK3A4czZOTzNGZ1Jw?=
 =?utf-8?B?RTFvYlNoSVpNQ1hiTG8vYnJ4em1yaXg2YmZ1K0FQVVhINCtiYnE1TDBWdUNP?=
 =?utf-8?B?ZXZwdmRVZVdkaUFzU1UreTAvcHRnQStVQ3NoL2Z0UjEwcEVVL3FuK25jbklW?=
 =?utf-8?B?LzhDN05nd1lmb1FRVUt4anZpZmwzODNoTUowWGZBQ2ZrdEVzNE5aU3huZk9R?=
 =?utf-8?B?V2MvK0JtS0s4SGRQQlNkMzVDMkVxcitaeUE5SzBHeU5jY2Y1OUloaUFwWGp0?=
 =?utf-8?B?bHVDTmFwYkRPYVV4S1c5WExkZEd3ZklJdHlYeDl0V1JCcFYwN1I0dUlMeGpP?=
 =?utf-8?B?aXQ4OFJyaS8zZjE4RjlxbTJjelhvajlvS1JNRnFQLzRjYk9UaVVLd05Ua09V?=
 =?utf-8?B?M0FIQWJFQ0tYdG90ZzVzUDM3U0VoK2w2TmY4VkN5WGpYcnJ4OGZvN0dhTmZI?=
 =?utf-8?B?VTEvRHlUd3RiVEhzUkRnay9VemY1ZmViT1RiZkFKdjJ1dVNFN0poNXlwOENY?=
 =?utf-8?B?cy9pT2Z4SXUraFZER1pMVVJFS1dUTEI5amtqL0FYVmw1SDFwYmNNbVhQeGYx?=
 =?utf-8?B?b1dUV016L2czQnRkY2k4SmlQZzBRYkZMVzd2UGxZQlRSUWxlS21LQ2lnOVNX?=
 =?utf-8?B?MHlqaWpMdjFFVytGOVJyeHJRSklyWTU5SVM0NDJqd1gzalVsZkpMVFNsZDZY?=
 =?utf-8?B?ZWUwTHRKY29SajBRcll3T3ZGZkVtajEvMmVTcm1kYnVUaTR2Vk5lLzU0VE5U?=
 =?utf-8?B?QVk0S1hZUHZNZjUyQW1vZ0U3dThuRGVBT1pNUFJFZXhMa0c4WGxhcWN6NGNo?=
 =?utf-8?B?SGNkaDJ3ZTV4UTRiNXh5djBoRHJXTWdXZWhVSFFiUS9DbnFRaXFoR2tEUGFF?=
 =?utf-8?B?YXBYUmI4MGdvc3hWVE82bW04RDU0dlhWTXpwUzFMQTVtTnhicW5QS3RWcWNH?=
 =?utf-8?B?WGl1N3JxSGZ5bko1MGpOeVJpUzRSZHI3c0p5eUVQbU02OS8ySklJZ1JGcVRQ?=
 =?utf-8?B?cmE0QWpxRmFGYk5EeEQ2UG1aV1hYakNSY1ZGUHBmTTRWRlR1NGxBTXZLNlhH?=
 =?utf-8?B?bzVOSlBFS0xtM1BNWFp3ZzRHbEdTY0c1b3BxbWpnWjNid1N0eXl2SGZuWW9k?=
 =?utf-8?B?SHN2NUNBMUROcXQ5RmZtSlNNcGNNT1MrR3lmSFg2MWpzZW5Ma0FMNzUrTGF1?=
 =?utf-8?Q?jgqL4Qs4nGWZmstCPiJyWNr4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef6d18-fc83-4d87-1edb-08da6459e0c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 22:57:21.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JANTE3jm2lbQ3/WK+9za9nPfp3qnJdQ7hcNq3yhhLY34Ufpy+Zxkr3UZbd/JjLlMvE7bylOKg6WD0UuOgj5ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

Eric sent out the corresponding user mode patches to the mailing list as 
well. It looks a bit weird, because it looks like they're part of the 
same patch series. But patch 2 and 3 are actually user mode patches. The 
interesting one is patch 3.


Do we still need a link to a user mode patch in this case?


Regards,
   Felix


On 2022-07-12 09:57, Deucher, Alexander wrote:
>
> [AMD Official Use Only - General]
>
>
> Can you please include a link to the proposed userspace in the commit 
> message when you commit this?
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Eric Huang <jinhuieric.huang@amd.com>
> *Sent:* Monday, July 11, 2022 2:41 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>
> *Subject:* [PATCH] drm/amdkfd: bump KFD version for unified ctx 
> save/restore memory
> To expose unified memory for ctx save/resotre area feature
> availablity to libhsakmt.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h 
> b/include/uapi/linux/kfd_ioctl.h
> index 7a423855a86e..afd8ff29c74f 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -36,9 +36,10 @@
>   * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
>   * - 1.9 - Add available memory ioctl
>   * - 1.10 - Add SMI profiler event log
> + * - 1.11 - Add unified memory for ctx save/restore area
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 10
> +#define KFD_IOCTL_MINOR_VERSION 11
>
>  struct kfd_ioctl_get_version_args {
>          __u32 major_version;    /* from KFD */
> -- 
> 2.25.1
>
