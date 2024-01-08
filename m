Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78171C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 17:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D4510E102;
	Mon,  8 Jan 2024 17:03:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D87210E102
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 17:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBdXo6z3sWZsrrVy/1RJuM1rZkf431ZtKbKN0QULguNB4s938OHm4pVkBl/Cx6eKhnDfkSgZ743/PXYYaeFSu8SlOOr5ClsWVfu3u0l4ACuN2E8Ls9SXrNqMFBF4FrVH0y1Kj7j9HFWcZxR9OkLsnvC59HP0F3rlZwwBxr4YDr8FqFY5If8zA0+qu58gR/qoRdoZYKqR+auUWsTkFnw1bS91SkgVeWbdFU8Z7ztNK9k0K+6YTPHE4DSLvEN+xBQzRLZVpWaAs/jy+nQiSphKPeDnBwVQn73M0SA+TWL/3D7Mhqy2V3x2Kkd1zFD4L3C/NAKUMIPzb4yDK5tpmR7+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+9Jh9LNDqDk7GS8IXSm6n5dhCjTWx+8fodlHJVLBds=;
 b=Cbjer85QKtSHRtQjbKIiZVCBWz/14BBbsPF9OIeS44hJ2mXCzbTTW/IgIFDfqIyCxpyoWb1CfS/2uwiFURnqbXeCNnkA6Ec1vFdAkCoSNekjrUTyayGJJOt5f8Lm9itotA7nDjgpUvbJ2ODkF/kY/6E8awJy+89I1U2ZNqE9I2Kcr6wByiU4wWHosUEYgzFVbXcTkOFK9gqNB2WZFR7b1WG7ipSm8vjWs0YSewRzFqzIXXSFbjY6eSN3fSe+KZPv33e2WNcjQAVsa022JExXsY4eTDZqvEj8rNgzFdxJ/39+pIK7Y3MzGX6AJFjm0KhwslvMfEpRZWKEeFr5Xa5boQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+9Jh9LNDqDk7GS8IXSm6n5dhCjTWx+8fodlHJVLBds=;
 b=0Ai+M2bC9TAkqyZSVGXQQAwp4GFz1YNDKkZdiL9hyrT4lsPCM6AqBjUqWFB2lgyIj+n83gdtTpAdA4zVrPLbpqqOy9eQKCfFQs9YPtE267o2EHMDVuSQ4DxkBZ8mmlyi9EVNQiB4xaEfOMrLAGD8IG4r8vi84rhrQ+s170NkiKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Mon, 8 Jan 2024 17:03:43 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:03:42 +0000
Message-ID: <b4960798-bac9-2b3a-f00f-98ebd5941f0b@amd.com>
Date: Mon, 8 Jan 2024 11:03:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] drm/amdkfd: Bump KFD ioctl version
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240103231503.339427-1-felix.kuehling@amd.com>
 <20240103231503.339427-2-felix.kuehling@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240103231503.339427-2-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: b5130ee7-6bf6-4378-c5b1-08dc106bc4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3el32V1T/h9eiKcuj077SudQGE/qBgjHL7xhtIj7q75qoarMCE4EiFWZM4H8Ev5EdDLlcteW3UgF8M4a7I6TNRroX4javvvJ+M+Xzm6cWT9X06/QczeM5d/GcC7Ec57AqsBamEStUUx8tYhwxSCv+jLHlliumX0NXfZXn4mwovzaw43usWl3fk8/Gw1rHT/RMck7fRx882C5AQDabN8M71OX1nVGmzaDS6TkDXkO5ztKPiZGpz7txeLa8gVUuGci0JvyBIFiyrtGHH2UjT7YHdFTrhBDUob+dn4YqJ1ZhW/FUYrqLnof2eDvUtA2Oppx4z90POOv8UhGXMjQo8p87cqwLWzOwKJ3aq5dudq9Y2VaPhbdoKe5EDtzk8trB0JdD1MCI4fkbbadzpGvxhFQmH3nmdDG3tRnlyn9SMR7cZvfUSniVU2erVplpYktq952GZnHgD8z1JT09vEYLgyKLfcj+MhtIs5WXCAr9AwJIb8TQNLtgPtar/esZp2HcccfzTTrJTXALSfbZ2N4F9mC41AoFZyri5TwGWvn+LiVS8GJ9UolcHUfJBm2fbArOH1SodprdCK4GpVSkQ1yucHA0HhhxrGMqyxcaL9xEZtZVJgvoFF0aNN/b6qEvYOpdYhJB5eQhjU5iNMGeeIJlLr8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(26005)(2616005)(53546011)(6512007)(6506007)(478600001)(6486002)(38100700002)(86362001)(36756003)(31696002)(5660300002)(2906002)(41300700001)(83380400001)(66476007)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVOQnNjaGZKWGlDcXpDNmtxblBWSEdRSGV1c3RHWGhiTzZZRlcyeDFjK1R5?=
 =?utf-8?B?Nk1GNFYwL0t1ekpSN1cxYkxBY2kvd0ZvTUhzQm9tVGoyNUhlWnpheU5VcTMx?=
 =?utf-8?B?SzlTVHhncEEyUFJlWVBpN2xwN2k3Tk9xVDNDcUc5cXdJeGovRmk5cVplNldy?=
 =?utf-8?B?RExyekR1VzMvUm9BakxMbmdZci9QTjhXNGxlT3ZFdlR6Q3dzTUxKbm1RUWZ5?=
 =?utf-8?B?Qjk2Z1RNTklVL2dvemJ5MnhWcWVFd3Z0aXVOcE1DQ2RjSHN1a3ZSOWlOdVBR?=
 =?utf-8?B?ZnZnbldyUE9BZ0Rpa3hIZHFIM3RrMmsrNHFYVnhnbnptT1AwYTA2dzdPa09h?=
 =?utf-8?B?enNwTE5vZzFnd3RMRytZZEMwdThMM095SkxpbWJzRnV5bzE3RDRxYnlXNTFY?=
 =?utf-8?B?ZmJFZGxyVG5iOG55MDhBYWszZEJEaGVsY1NTdEtDSEdGbHI0a3pMcG45VUxJ?=
 =?utf-8?B?OS9LNUREMXJZTVZYVFhvZ2pDbis0ODAxMGdLTmJxTnNGeDhjRzRZWER1WFVz?=
 =?utf-8?B?VTNtYnhYT1cvc2Z6Y1U0bk4veWhtUFhmdXljZXd3TDQ3M2tiSC9OTTAvTjdi?=
 =?utf-8?B?ZVhEbitHbDc3OFp1YUlCU3k0SDRqNzI1aFdwaElCQUxZQ3lDZ2tLekNFcFhl?=
 =?utf-8?B?V091R2pWanN2M21zenRpTHJlbWhWOFQ4MHk5RUFEVjhneGg5akROSERWNjFB?=
 =?utf-8?B?NXVuSGorMEFjVS8vNmRUbWwvNzlQQnhUMFJSaUY4NEFDSzJzVENYYjBxclM3?=
 =?utf-8?B?d2g0elN1ekF5QUhhV3BxMjduUWVqVzB4RmtUTFY1ZFVYOUtFR0pQYnV3ekMy?=
 =?utf-8?B?NGhKdzluUUNPdDVDNWVGbWwyWU9XMFVpd1J4d0o2OVBNTVRLYThpdmxIQVoz?=
 =?utf-8?B?SXE0R21VTnIyVStDdDJGUFluQ09adU9sYzZiYlIyN3c2bnBuYUFjRCtON0tT?=
 =?utf-8?B?eThTU1FtU3NCaUk3RU81bGRlNnVNNVRTZUdOQVpUdFFMeW9mRDcrcGxmMjFz?=
 =?utf-8?B?VUhiQUgzdklEaCtwVzdOYms2UkJtcmdxVG1XMS9nZlhrTUp0TmNhWnRmUG1K?=
 =?utf-8?B?OGUwUkp2MGZZSDlTTDZiMDFIYUxnemJ5Z3RkUlVQazg0azV5YkxyOEMxamll?=
 =?utf-8?B?Mmd2MUd2NWs3VkNCV2R4dGlUYUlGdkpvSytiMzJEdTlFdEw1MkVOVVBkTits?=
 =?utf-8?B?QXZxdk9URjV2K0tmNkRvTU4rUUU4MVpLN05YOEYvMkl3QnhOdDNNeHdxU3hO?=
 =?utf-8?B?ZjBuamttN3BYZWpldmNvQjZnSW5lbm9vNWIza1RKN05jaklJLy8zajRnTGVz?=
 =?utf-8?B?ZmMxSUpRZVJucGVTdlVscVBINmc4N2tqWld2OVJFRUJNYy9aZTZGSkYyNUN5?=
 =?utf-8?B?NVFaTHZCVFRSSlg4SHJBMWppQWM2Nzk0L2NjeTlyRzh1SkhjU0dRKzlFOTBU?=
 =?utf-8?B?TWhwaE5COWd0MGtPK1pJVmJyd1FqbHIwWmpLWVFNM3NMY3d5ZmRHZUM3V1Fp?=
 =?utf-8?B?WEowY2ZLeVlYUE9DWWVGRXhLbXBrM1hQSVhrUHB0bUViY2xmQVR0S2dtQWx3?=
 =?utf-8?B?NUpLUmFaaDhlZE15WVNvYllYaEg0QzZkY2l2aEZGYlBnRUVhNzZmUUJUYWNY?=
 =?utf-8?B?WkdQTDR5eVUwVkVhQ2Z3RDVaQUg4dnUwRXBqeHJyK1pVUWFJOGtWQkpSQlFn?=
 =?utf-8?B?eDJDU0YySUQzWUVkNDQ4SmxUU0FOaXJHMFBLU0grNGV6czdyQVNnMW54d052?=
 =?utf-8?B?dW12czVOVzBRa2JEWDJKWEhtajVyUnFSQ0ZaS3lXT0Q1cnNRZUJzYkxCSlpL?=
 =?utf-8?B?eWhrclJEamRuU0p2cUIxUDJncEtacm56Z1FoWnNrWjN1dDlmSTNLaWg5K20r?=
 =?utf-8?B?YzJnZVRMWnhSVzcwdTRBeXZxOUVLZVk3dU1DY25wakoxUSt5Z25PMEpCbmVE?=
 =?utf-8?B?UjFXVGhWeHRqZUMyTXZOYlN6cHNvVnltTEsxWjk2MnQ1blRNUGU1d2tjQkRU?=
 =?utf-8?B?TkhUQWgyMytldzJGL2FBRE1hN0tjSkY1cjFnSGpzSldLQUJWY3g0bmV5a2NU?=
 =?utf-8?B?MUhqeGlZRVJocndqZmdJRlM1VGNSWnRWT2Yvc3R3YWxKQkJyOTAzd2FUT0s4?=
 =?utf-8?Q?Q9Ts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5130ee7-6bf6-4378-c5b1-08dc106bc4a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:03:42.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3aT2jMdgEd/FiS9wEv/2MOZGYRwOSMbKysYENA7bxmstX5FlggpGj6QNb3lHziG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Xiaogang Chen<Xiaogang.Chen@amd.com>

On 1/3/2024 5:15 PM, Felix Kuehling wrote:
> This is not strictly a change in the IOCTL API. This version bump is meant
> to indicate to user mode the presence of a number of changes and fixes
> that enable the management of VA mappings in compute VMs using the GEM_VA
> ioctl for DMABufs exported from KFD.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f0ed68974c54..9ce46edc62a5 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -40,9 +40,10 @@
>    * - 1.12 - Add DMA buf export ioctl
>    * - 1.13 - Add debugger API
>    * - 1.14 - Update kfd_event_data
> + * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 14
> +#define KFD_IOCTL_MINOR_VERSION 15
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
