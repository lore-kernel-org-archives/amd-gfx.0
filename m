Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3983FC197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 06:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79E110E2ED;
	Fri, 17 Nov 2023 06:45:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2075310E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 06:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETxto4HBleZmQx6xcVKFHCPMjhKUOj8n3HWIDqAgEwNqpkfP+TE6G/XmQZiIkFtgar038nhMFW0CePDVxa+d6cATzv7jVu4oOip5vM2QJQy6o77lhcdOQ6jKrw2/XCZJEgywolQQTwJa1wbYtRMr0kIhhjukJdLN7bgABgmvAavWQK6TS0RUMXgnBer3M59Vw7KlR5CMraCdcWRdeB8JknKNk5+j3DnoUkbEFIHrMsAfuXHHBc2aT73I9Goo923fIt68BiHDukF5gRyQq2GiiFBnjKVws9bETqxi+5Ibf1pejXvFU84FkSq61tCcneyFTktA/e52sE4eoyegXfLgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39yST67Vm7YLr/kLwENOLcN37DNsdldfLGEXnuIPO6A=;
 b=h9Dbjq1/H3gCMKXrkU5HiUVq52LhdPbKOUUTpQVf2G/yBp+1tUqPfiA19QVOvp5cohHJMyNUCnXb0soYpWo6Kahvx7iPSnQwV907HighVjt0pV/WFPz32bnW+P3xtFH7AFPuqvZ0AD9MnDmBfDzR1cPW27SxBMjmmhidYcFVdp85ffJHGH9Scs5etWPCwattBZXzl3+gr+Kux5CiLoSIgBxhr5C3drzr/k0pXnZCSLueNczlCSBYyHhYJOMtrcV62OqWWrvYU0i5UHpNYMsE4+OU3c39MQyiLOgQ2FhgI0HH/e6IOfct+jKf103U9V1BJ1LkMTikzJTyacvrFXOOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39yST67Vm7YLr/kLwENOLcN37DNsdldfLGEXnuIPO6A=;
 b=YA0Uuus0PljYxUyBlX4L0d/3aWXM55yZ5FdlqlNIGUMq0/bIRE1/iJyjTnLopwbAvEsstBMMPb/FmBP9iJCr99fjxZJzn0LSNtSUfn9MIjepy2dnw1X9akjlYDKadELa+lFZeFdqXkmz51laGnTxzpWpvoER8xpp4a5VvjmlAW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 06:45:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 06:45:34 +0000
Message-ID: <38d9edc4-e025-2062-873d-d3d4c1a43e1e@amd.com>
Date: Fri, 17 Nov 2023 12:15:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdkfd: Copy HW exception data to user event
Content-Language: en-US
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231117052010.3166816-1-David.YatSin@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231117052010.3166816-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 57115d02-0585-4dc8-f859-08dbe738cc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYvH9yAotNjgj7gNegB4lXBXjXQkkBa3zeoEVF4ey63z6CcrimYhxBITSqWrKatZaiGLs5LJNcFqgXpqDISBagYIRvNHIUjvIIv494G2FE8YfvWXez+1hk9ivt6DICWBn3629OEEB40lEarh9Zfnd70RlQoA/jwtXfIggqo3Ob1lOXHrTTt8jhA83eYq22YsDBqe2Kx8fj+B459L9aD9SjbxhCQ9KCff6wYDIJ1Srbi4z3UihWtz9rSfLWuefKu9dOBPc5IzwYPSpFjoOoIchG3UCI4NiTiu9T/zPRa25rA/BJAvRnPkDq94AZotmOxsfnq3wqVOXryjusttpzLzW/o8cARVPohc0RFKWBtZxd+Os8Y76/Y2/p0VrsEqbfTuAZdrXVZSouP2Fi4ni4iJO8aebmK7eTPfmRqVwrg6hgO1naMoxWK2vLhvMyU1880vK4pAXvyRyobOQBZ16eaPU7+1DIwGpU+EpnxiKkP251C6H7x7HcJbC8M/FKQGNN4Z1sLkSRI7CVGPqdDURVnPXqptyTtvufDoWQniYGoLvG+HoJ0LVR1ktcwCX9/YGTrnKxF5w4RkkoRxzCUOg9XoUG5eAUxwRp+JhhYKiyeD/p2cF9kKtFcKHFYhKSY3Wq/Dw8IdsBp7cjoMAIWEAUxfwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6512007)(6486002)(316002)(478600001)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(4326008)(6506007)(26005)(6666004)(31696002)(86362001)(31686004)(66946007)(66556008)(66476007)(2616005)(2906002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5pemU5SE01cHVFdHdaaGl0ZXZhSGFEbnE0OEJWU3lNSXUyMXNFVEdPUlBY?=
 =?utf-8?B?QlYxTm9jM05xeHQvdW9hTFJiL3lrM3c1c1BDbktvZDZnRERubWdaK2Y0R0JN?=
 =?utf-8?B?UTQ4K0swQUhqbzVRUEFPM2t6ZnhyS3NLeEpuelo4bmE3V29JMWhEbFRUc0U1?=
 =?utf-8?B?a3ZTYW5TSmJkRzBwaDNVMEhFWnVNQ1M3UitIczRidU1DZndQdjR0TVBwQmUr?=
 =?utf-8?B?SVJEN2k2THgrbThlOHdLanIvU3psZHZiZzZDVllEWGZkc0dzL1NiV1dXQ3Rv?=
 =?utf-8?B?Q25JQk85RXJsZk9wcWhIdC9jMkQ5UlcwYWh3WFZmWStTMnFNdFlXNHMvTEc0?=
 =?utf-8?B?b2wvTnluSDFUOGtmV2ZPKzJpY1VFYWhHdXJudkZNOVdvRW05TEt5RXRrRUJL?=
 =?utf-8?B?STl0RU5iWVR3Nmg1VFdqOEc1V01qWVlvQUw5V3lxYXhBcmpZTVVmUERIRTg5?=
 =?utf-8?B?bmxuaVRZcTR3N3FNUDEvaVdjNG56Ry9jbXZHQVRWcWhYNWlzN0FwNG1BSXZY?=
 =?utf-8?B?MENNUlRNenBGU3ZMeFlZM0NPNVd5TVlYTC9iZWttWVJvL0crcW9YSS9uUkN6?=
 =?utf-8?B?Y2U3cHJpck1wU1pIem4wUDkwS2p2MG9JdWNVOTl6QU1EQ1ROZUpPZ0ZYdWdy?=
 =?utf-8?B?ZC9RR3JJVzAvODdlQnNmV2FSbTZOS1c4dUlnZDhNTlgxQjlJeWZKTUF0QTY4?=
 =?utf-8?B?ekZ1Mk5nYjU1d21RM043V1FzMitpWVB6ZHI4dzlHN3VDNFhGTjB4K09rdWts?=
 =?utf-8?B?WjQxdGF2WGc5UmdCd1NkNFg5dVBPeG8zTjJvVGg2SDVjSW9WWFhEVjNUVzFx?=
 =?utf-8?B?clZiZVVxQngyQkZQS01WOFFGc3pCdkRNeC9XNU9oMXlXMnlsYm03SVdDVmZa?=
 =?utf-8?B?UVNiaEU4a09pbXRCTE9kejBzKzAwU0U0TTRHSEkzNmdVUHZRMVBqNW55VmRJ?=
 =?utf-8?B?MENZL0NHcmxIbHNkSG02UnpuSUMrVWk5eDlxWDNrZUZvcWZDbGVEQ0dlUjIr?=
 =?utf-8?B?OVFlUUloNXpsZHN4QWRoeWhZSTd1ZDFabmZqeVpXTlJuUGJNVWFIL1BzQ3A2?=
 =?utf-8?B?UDhjcWxOYXJEZlFxVzFWb2tPa3VrOVNvekNMcFAzeEpwbkd6VTNQY2F5Um5O?=
 =?utf-8?B?R1pUNkRUUkc3SmljR1ppVW9UelE2TXRqbk9JTDlvZmIybnpBMkNGL090RFJO?=
 =?utf-8?B?QkVua2tDQTJKL3NvUWlKWU05dGE1OHpDZXpzdzJ5ZDNzZnJGdUlmdC9jQ2xU?=
 =?utf-8?B?djM3V0prT0g5eS9TZVJtTTRIdm1la2thLys1bGtUYis0cTZ3bWhGaDRxR1Z6?=
 =?utf-8?B?ZTZlYUlBY09iL3hKSFhZMDMrWUF5R1U2RDZpYzUyRmVNcGk4QlFBNzFSTUZw?=
 =?utf-8?B?UVllMjZtSThiM1AxSTJlOWZMOVFMenZMYkFGSjduUEhiWVpJRitKK294Q3Rq?=
 =?utf-8?B?UDZHdUtOQTlrQldYSCtOL0xFWERSQkREVFVZY3RObU40akZtN3AzdWVPbjlC?=
 =?utf-8?B?L3RFelZrOWp6Z0IvdDc3TmJlVkxFenlqbUpJdlVIOWkyZE1CWjhXbnBBSFZt?=
 =?utf-8?B?Sm54TWFteVF1eHdnMmVuM2xKbXBEVE1OVzUxMEhnQkxOK2dCWHJ6WHdjUUVn?=
 =?utf-8?B?SEhTV0FzL0ZUUXVRR3Roa3F5NG9QeDUzTUE5N2FkRWRSeUY5aGRQaFZYY1hr?=
 =?utf-8?B?Sm94N3dUdVdNcFJ3dFlQck96cThlS2hwQ3NIQm9TWFdHckJwN3IzdHpwa00r?=
 =?utf-8?B?d3IwYkpnOWdiUWMrQXBya1UveFhNalVuOWpDdnp4c3ltSzJlT0xEcXI5NlI5?=
 =?utf-8?B?VllUeWFQVnd6MGVZazJoNjBLeWxiN0VJYzFaNTdEcWZvN1pWSWJmZDUvVjZB?=
 =?utf-8?B?OVo5RkNoS2U0U2VFOFNEN3pqeTMva0wrUk95OHpuZVM0NitIeXB2QVB5R3dt?=
 =?utf-8?B?aENSSE1lL1BUMEFKSmtwV0Y5cVI3Rmsxd0wrSS9DcTVnTUszSjhQbUh6SXd3?=
 =?utf-8?B?UjRYL2M2Q0hOMktoNTBrb1JmbkxqWXlFb2IwMVNiRU0yRnFrcjdQajcrRXcz?=
 =?utf-8?B?SDhGaCt3c2RnZHJLWlU4U3A4MWNHbUYzdVlUanJlTHJzd0I0UngvZGx4WlBY?=
 =?utf-8?Q?2pMQ+5CZ7OkaAdD97nmz2tnYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57115d02-0585-4dc8-f859-08dbe738cc7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 06:45:34.2222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL1cT550ARFTkUMxQDPiGj2ZUJHP7aiMwd+N2LcePpTzPOfkSY1ttsfwxrVnNWz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/17/2023 10:50 AM, David Yat Sin wrote:
> Fixes issue where user events of type KFD_EVENT_TYPE_HW_EXCEPTION do not
> have valid data
> 
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 0f58be65132f..7d3db017f8d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -880,6 +880,10 @@ static int copy_signaled_event_data(uint32_t num_events,
>   				dst = &data[i].memory_exception_data;
>   				src = &event->memory_exception_data;
>   				size = sizeof(struct kfd_hsa_memory_exception_data);
> +                        } else if (event->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +                                dst = &data[i].hw_exception_data;
> +                                src = &event->hw_exception_data;
> +                                size = sizeof(struct kfd_hsa_hw_exception_data);
>   			} else if (event->type == KFD_EVENT_TYPE_SIGNAL &&
>   				waiter->event_age_enabled) {
>   				dst = &data[i].signal_event_data.last_event_age;
