Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC9FC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 16:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EE010E193;
	Tue, 30 May 2023 16:36:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E5810E193
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 16:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq3q0LZPEdjtcYkmuCdwGf8E6qhdIkFlS4ub4lgZXQ8Abrps5QoF75xFA2LD61ny9In7K9Jq665If+FJfiMMHK3Auggz8GEcRiDent1jHz4o6jjhFNrwSf0+lA9hO9NCtW146mioyiNf+F+EOKPamp49VI3qBnvrN6KkDQYZHvzeXdBhTYdt/QAAhx7MCFRuk7opr+kTF3fZ+ukH1vXAlNowMkZqEibt9gXSly4CBQFSj2b/gl7bXf1ZtINRgo177tLG257Jh4krOKbjNAzY5B2uHFhrq+QXuVwaNJhAaEXfKxQq7/UUByUaZctfE9OlbFBZwQGTjngz2y+qJcNaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4acijCy/iVfkxYPJkd0dxFRwGVGky7hPJDOEnASHng=;
 b=HlotvpCgXTOqeLByFVZWk55++7tDpteNCtJJc+MJUe58tPitgtZpin7k+99C3+Jkf4eELoXA2nzkp3pYTMfwNf7xbNV884HD3SLGs2t2U3NFvEt/FbVfuqDAlX/aP1fz7cnoBKSyzImVIWV2t1Lf5AtFfk/MfQbTD510gXaHHPwWphSQD6b6cFBHjSm7eJV+5DFlmrUtbJFqX9IQR4DpVWF3cq4jWreeCAQPnW4QAH/1HUg0wdokG7+9XPA2gNMySe7zbHMbEId19SiVTIAwctmvyJWZqb+C7wyDuevpgFq3yQQVcI2qOMn9+KN5VtfQ07IcReKF1JYDW8G2k0WikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4acijCy/iVfkxYPJkd0dxFRwGVGky7hPJDOEnASHng=;
 b=pLD0TgYKE/l3SGcJw+SVlyPnwkzQovXrXaVNkRbJ0F9npInEAYm+ratVeVv/WA4ZePIwlKxTLjDUtRZ0JOgv6VYcN7602Xcs25pyvj0vIEV/eYx0QlJHpMcWzHXYTUpB9hOGx+YQrozB0ygcIfDWKTFL5fojIQcyhG64xpv7X/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 16:36:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 16:36:28 +0000
Message-ID: <4ba298d2-e2f4-2a1c-3f6f-aaf7d6276180@amd.com>
Date: Tue, 30 May 2023 12:36:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcp_id' in
 amdgpu_amdkfd_reserve_mem_limit
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230529145606.1914552-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230529145606.1914552-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b43f68f-7ad8-4232-096b-08db612c043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nerjwgse++NZ1KI1MIIAtPRkZtQoZlAxb1uGS+w1wvM8FcbtOArQ1Q+/yVo/5oguhF3wR9VC5BZScNFf84Gm6kd2p+xoIwHJcghug0ZWwdX3SjsyAq4u8Lp6sDWEpUrSDl3zIuZkQt4STl6VOwWUS/HgqFnvlWwTFRcgX1OLVXNbC178H8GpODXRP49SFZ2BK2fvsR6ZuAaGKkdcdU2ulEF7ejJPyCpbq1Eil7up3HK6R9DN/aHV+t3pGcd+QeWoy3wpQdTiR8C0IrzZ+D3Eh8/9CvDTB8x9D9Y3/Z4brulYkWeRrTZhCEeXc8ORKb/FX/VxjZYsMeJSCMIuJL2/QRPf6KdjXEb2+mFBNkyir1qyO8ZAiNwBZ/hMqXsOaYsDZg5OH5Okoe4PmzREzrxpd6hS0UTyOoC64NneQk8A/KNyF3RmkriL/OeGRkqfoGwB1Coxs+m85lyPUlZ9aIDRkVv3Ys8VN/gnctQtyj7yz7kNnJsz4nw0/LA4lwSn9zj/lHhAdJioHjKAgVy8nFI7fCNFktfCNZUVaf3A4mrueXHQZ3y4nYV/WVlJC8/J1UpNAb361hE3EbsPClRaOLjA52C+fp7P1j3dLY+SqNpfdgfcNYOnevckJ0xDnatyFivs/avJvCdLktzKWNDOD5fweg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(31696002)(6486002)(86362001)(41300700001)(478600001)(4326008)(6666004)(316002)(6636002)(66476007)(66556008)(66946007)(36756003)(44832011)(5660300002)(186003)(2906002)(6506007)(6512007)(31686004)(83380400001)(66574015)(26005)(2616005)(8936002)(8676002)(38100700002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnE3YWw5b3JRQmRjRVNCSzdkcWhnWS9UYnZNdGMzcXZDTlJzUVRlaURwNiti?=
 =?utf-8?B?S2xoRGZ6M1hSQ0lUY3JLYXBXNmFmY0VzK0c0bjQ4ZHFiU3JoOFp4ZjlqVW1T?=
 =?utf-8?B?SGRCZUNLTHJFLzgvMEIydDhoQ0NobGhVcVg3WmRMN0QyRTB5aXFiSmkwTnVU?=
 =?utf-8?B?bDBRek1RV0lydzJSMEdNZ25udzNCbnJkSTBVYUdHTDlORzBaVzhIL282OWxH?=
 =?utf-8?B?b2pVcXk3U000QkZKMURxMFVvOENZU0NwZjcxNjVJbW53WXY0Tm9WUE1ZSWdK?=
 =?utf-8?B?OVNTNnF3bzlOYW4yN1VSNEtTT1NCTzQwRmJYbmJPRXp1MHduQzRZR1Ura2hp?=
 =?utf-8?B?K3RFWEJNNzB0THVRdDRHaDdHL1h0YjIwaFdEK0VtY2pDeGQwcHgwbnpCSVRm?=
 =?utf-8?B?K1Q5L1JLc0pVSFNmOWQvNEc5dk1HcitOR2ZHcW1nRGEzNkdoZ1NxU1hhU2Z2?=
 =?utf-8?B?K3ljWnY5SUNFbkNCUjU2dWxSVXVpZ0hRZUNKS2ZDK0dUdk9PK2dPOUFIMDQ5?=
 =?utf-8?B?dHRuR2wydHl0cTlJcCs3ZHZKZkxTZmJaQ0QyQXdhcU45T3d2UGJCSVZKc0hZ?=
 =?utf-8?B?bmFQN00ycFZtVmIydS9FUFdwSEUvT1V5cnNTeTEva2hlQzBsY3cvZ3F6UTZB?=
 =?utf-8?B?Q0tobGs4U2NvQisrZDU1QjNnRjlZVkN5U0x0ZmZUOEZ4ZTFUOEdhT1FNemZD?=
 =?utf-8?B?eThDUXNhNGsvM3pSVFN0VlM4cjRSeStVQTJ2RG9MMUFQTnNNT3g1RjU5NElk?=
 =?utf-8?B?VU5mZVQ0R2lBd2Rha1o2UnlLSWdFZEpxaSsrM2VZUHg1cnd5TjdnQzBrSEt0?=
 =?utf-8?B?WlJrSm9zdzFyRnd3RXdJOFNqbDdYRFQzTVFHNzhRSmlEZ2t0ejJsSzN0MTdL?=
 =?utf-8?B?MTJkeXh0NUY2SlhNVVQ0Q2xDQnIzN2N5YTBoMHVUQnRrVkFkc3ZtMjFPYTBz?=
 =?utf-8?B?S0FaY2J1SjRZa3hXSWNFQTAwaGNCeHVVWkNKcXptaERESHdjd08ybzljSi9V?=
 =?utf-8?B?TXk5R2tnQzZ2bklNWnhhcUozdjdvdnVEREtyb29QMmcxMG5YMXM0V1JORUdD?=
 =?utf-8?B?TXl1SmZMWkFiV2ROUnIrZVdvUW1Idm1pMmNPNzFyREk3SXFUcWhCcjVYMHlm?=
 =?utf-8?B?OS9zMXNWQ2cwWVFBanZpbXdWWEpLdzZSa3RvdmphcUd6OUtTZFlTUUFVcUVD?=
 =?utf-8?B?Z1pyYUpINTh1NDNlSDV6bnpVaGUvKzVrQUYza0N0WVlJckFRZE9ObER5Uy95?=
 =?utf-8?B?VnhxbElodDVQaHc3T2hTUWRRUE5iM09VVlUrK0JTQTJkZzRqSVN0S3h3VWtF?=
 =?utf-8?B?bTBkd1RWNkxYZUZvaGJqV0t4bytrWlZ4a2pVekluVi9iMC83TGtpK2x1V1RC?=
 =?utf-8?B?OHV6M2ZoaURveUhpTTBYMXc1b1dVbmhPbUFXOHVRSGE4TXhXOTAwSExPRHlw?=
 =?utf-8?B?YWVLRERaZXUvOXpnSnlSRTZDMk16TmNnRTBuYzI5QzlxdWVuNURHMjNIZGQy?=
 =?utf-8?B?WTJqQ0h3aHc1QUhKTERySUsxS2lmSkN4QzBkMlE3MHA0cDFSek9WRGkvclJ0?=
 =?utf-8?B?VVk4UmZRZ2orVlhSUG1TaEw5VlBRWEU1MUtQS3lZWlJhWmVoL1MrWVVIT3Ri?=
 =?utf-8?B?bGhQaUNtazY5N2xNTXJSUmtWYjNHSWpBZHB1T05DNzF1QUdDdXpJN1Fkc1pO?=
 =?utf-8?B?NDZ4T2poNHk1bUVPL2NuT0tNNzNNUldjMWpzTHRRYklmQ0dONzJCWFpaLzU4?=
 =?utf-8?B?czJCK3BtZ3l1YUlobHNrMkpFM3BSdlVtc2hRWGIrMzA5SmJUUUpYWFdWSUU0?=
 =?utf-8?B?ZG54UnZ6YUlrdUVZTk8rZm5Lb25NcUw3by9wcTNpTWhpSEk1L1ppSER6RWNY?=
 =?utf-8?B?bXRJV1FtaVZpYmI4dUxDYzdnc0UyZXR4cWY4RFVXUjEwQzlIOUV2WW5TTU5H?=
 =?utf-8?B?WjdhZHBHeFZuc2RmdjQ0ODAxcU1iRllKRlBaUnhuN1dkZ0w1MCtOSTkyODhk?=
 =?utf-8?B?UWlJelZReG9GelVKZFd4MlRzN2lodVp3dGpFaUNFVUVHbis5STNnbnlUNHBz?=
 =?utf-8?B?dXJkQlRUZHZXMklqeWJGZzlSNzJpSUtVMUFxTEZuTVRraU1Pay9jZkpreGlV?=
 =?utf-8?Q?C6N+yERMZCw53lT4p9T+s19rf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b43f68f-7ad8-4232-096b-08db612c043f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:36:28.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfM8BwTD/rWdzauhvRaYqoWr4c7XaWStJHl30jHK04GJKd2LUIeJtro0Ngxr4nulhgJMgIw86lzWjzBJ2hh/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-05-29 um 10:56 schrieb Srinivasan Shanmugam:
> Fix these warnings by adding 'xcp_id' argument.
>
> gcc with W=1
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:160: warning: Function parameter or member 'xcp_id' not described in 'amdgpu_amdkfd_reserve_mem_limit'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index fa4057da0d7f..cd5d7a39ad0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -152,8 +152,11 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * @size: Size of buffer, in bytes, encapsulated by B0. This should be
>    * equivalent to amdgpu_bo_size(BO)
>    * @alloc_flag: Flag used in allocating a BO as noted above
> + * @xcp_id: xcp_id is used to get xcp from xcp manager, one xcp is
> + * managed as one compute node in driver for app
>    *
> - * Return: returns -ENOMEM in case of error, ZERO otherwise
> + * Return:
> + *	returns -ENOMEM in case of error, ZERO otherwise
>    */
>   int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag, int8_t xcp_id)
