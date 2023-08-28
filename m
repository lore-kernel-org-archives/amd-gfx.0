Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BE4C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88CA10E0AA;
	Mon, 28 Aug 2023 17:55:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDFA10E091
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 17:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJZ1GBCm/rZJFgvy/p3uYSjvMPkSBl2LQeU3K4xuG6ObOhcz+ZUcaZnhAEYeFyp5b0KYVrLwMJhX8cikICVrh/pZ9pEBarkKDMwJUpYx6qeDWimlMgLdFPxJgo7+0A+ZuYHtNAPGjwBptfTHjT+Ar0gI/qintrqQrj2ybEjiPq1svI1ZWYKfhSM44dwvaTpDG4RRn+ZBZhKqmUXQHtEc/RTopwDSIiM/iomDIt+nXeotYuPKBKGQyhXEAZv2THOe3ioP4iRYMoRE2ISXLTKhIU3fgo/2fR8PB0jyA00F6On9CdVyyQqys/xMEji59Iha+l5i+c5GTDJIyzWyR0FV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diHaYfwEvIOgYGTzHojVJaNr1ntnIXUwnBBcGSa+ycA=;
 b=L3qpNNAKikSAgAJCUW26mmGDpGZv0IU6PH6kzhmuJzeE2vFXmVm6KgrnExiNfN+ClSC/xxm7UR51GgcGBeq1/2CU8XlS/Docx6sxvzwgmxbdw3bA+FrQ7LlbHP+7zSXFMzYVr5MQOsDA9onynDoapkQgc3GBSy0TmZdQYRgr8C+t+HyVQaMeirsSuL+UIAangFR6wElxwOpL15tk2NKBWjJpnObyKxK9ugOA4F3tMHj7uXXZo9Is/efDm0ggI9RFgx23+A7/vqLRsiSb2cXhRIcpqDZ0Lrdb4ptceoB89KDY0DD9VtqePFyhA/EA4WfPCHb0lzamtZ6gqqKraNtXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diHaYfwEvIOgYGTzHojVJaNr1ntnIXUwnBBcGSa+ycA=;
 b=QZoEtvLO3/MBWXJvhQnqOAXkU2CUHxSQZYhqDDZ3bYN2OP/8vmw/xKL7QG5ctG24a+bBPNaYJkJV7T9zG060wcA3SqPd2t1s2fL5rJ+0XCMknRz3E+ufJttL6O3NC7bS/t/sp/vfIGTwzPDl2r6O1ubMXlATyblLMKD/GRL+M2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 17:55:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:55:25 +0000
Message-ID: <5c656869-fc11-b7d0-65a6-aaef0217b98e@amd.com>
Date: Mon, 28 Aug 2023 13:55:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: use mask to get v9 interrupt sq data bits
 correctly
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230828153509.30399-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230828153509.30399-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3336b5cf-4953-49cb-ba32-08dba7eff525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fq9upu6UtXEt0k15FfJ0vcUg7nWv6ZbkwpBi62EheJfj6ZnFU+qwTtjjA3gQZ0fbhIgZip9nyunUf5qQYTANVgw9msQgtgSaXjbxb273XvZyyLo2U/CjGZcPzhh8WYOYa5EJgyJhmXIAQYvoPHo4ASUn28YsQPiK2OstJwWHfW1LRJxGgOLX+UGTX95e179rFv/Dd/XVl3sdaVWkdYxlXMkyqJ20dVddM+Xx/nshuT3bhMTiIAi5NVjOnb3U2YN79ReOuQGLkofKKrwlXPRkfzinQzH3vLkBtJE86SxlGDoGQg7etsO6xoplvgY/uas7Ma5tg4iNsSCXl2q8n7/XHH910XTwlL5NPa1O+oLzAZg4TCGyegQsP9DD7V2M6ROQp6ad84P7eFkOkA546rkCvS1mfHlEfvOTRy0DMxgM2KdnqTfUREd171oxp5q3aYftjxEv0wYZ3SOzwEzYwdPK1IOloRaXgSYhauP7HrlaqeDDn7saKb8IYjbDMAYx4huPKgNVgwLzyiV5KcSNkqloXcj5/muEqKhVDss/Kz9zMQbvt/dRxOgrV/o1EFoAjCkHAxncSqq6wufYp0Zb5U4vtW2S08dgVQCkouBCDPCHixz7/YJWJr+yCKFEL1zKQRMqSYL3TDsUey9eHxvp0GYcUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31686004)(26005)(41300700001)(36916002)(6506007)(6486002)(2616005)(6512007)(53546011)(38100700002)(478600001)(83380400001)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW15dTNXeE9QekwzL0pGdy9QNFYvc3hDU29jVGVYdmlzeFJYbG5TWk5VRGQr?=
 =?utf-8?B?bUNEQUg4ay9FSlVNN1BBbzlQMWRIc0hJY3AxbnFXRGRhOVhicXpIYVBXNDU1?=
 =?utf-8?B?MXpHckt3ZjAydTBnMUcxdDk4R3o1VFRKYTgxVDd0eUxkM1dBRWI1RFJKQVpl?=
 =?utf-8?B?Z1lHU0NJZUhrNXJGTmhsdFF1a3hFUWt1bGJEbUsvUmtTVFo5NGRxelkraXk5?=
 =?utf-8?B?Y3NOdkhPUDhXUHFyV2pLdGdTMlYrWENCMk41WU5oek9GeHlTRVdzVWxlUUFn?=
 =?utf-8?B?Y21yV0JnMlQ0cFlQdFVsRW1ROXlndFVpQ3czWjZ3bXZEblFVREpxdTk4dXFP?=
 =?utf-8?B?b2VMYzQ4RHhaUVlNYnRVbFNGdElBYUNGWmoyaU80TWtheERNR2hqamtiQ1Z0?=
 =?utf-8?B?bDROa3FPVlZVSG1UNDE0ZWZaSVBQcWRONE95TVgyYS9leFlBeVNKU1Q3TFBu?=
 =?utf-8?B?YnNIWW5KWXVRSGpQcTRERHlRMGxwVEJMd1FPczBLSUN2djR0S2luUDZJSFc1?=
 =?utf-8?B?eE9aS3JoMXZrTktxQkJHbmkvOVMyaVRPR2k0NGI3K3BHejMyV2c2N2xVSGdO?=
 =?utf-8?B?dDRhNVhEb0JkRTFCSFBpQWtYUlZFM1I1Mm4vd0hJbldwVmdQanlyZVJnVDBh?=
 =?utf-8?B?YUdWOVJrZDQwOGFWcTlyTS9aWWZ2SjFIR2tDMmJGK2srOTZ5REwyRStCMGlN?=
 =?utf-8?B?cEdBV3hSZDBRRUFEa3hCVFJVdW16U0h4dnhwSUV4TlpLZkU5c0JFUFJVSnlM?=
 =?utf-8?B?bDIvQXdyMG5OeHNiZnhjTG00V0xoZXl1TUJwcmZGaElWa3dibTZKRTRObjhq?=
 =?utf-8?B?ZTNLMXFobWkxZ0NIc0o0bCtYUFRQNGFpMjdLRVppbTcxR2xuT3lOTStMcERn?=
 =?utf-8?B?RDZGRjdnS0laSHkvblFXREsvbGExY1RjUnBmVjhQRzgvdGlacS9ZQjZ0ZkNs?=
 =?utf-8?B?Sk9CbW5EY0diV0RNL1V1d0hyMTgzd2lycEU4MjVhTHRRcDJQMXEzcFk0Q1FD?=
 =?utf-8?B?eWNJNU9PUUFVdTdRcy9taUlUN1FwUFJlR09LczJrNVNqT2lLTmszVXJ4YWk1?=
 =?utf-8?B?KzJoWWVSam9mdTdDREtHYVRDT2xJS1Bpa2Uzd2M0eURUYzc5K3V0RXMxNEhu?=
 =?utf-8?B?NU0wYWpJYm0vcjdFRGtBSGFiU2tDNGJxRGdnZWwvaWdxbnVPWHBlRVdkT1dv?=
 =?utf-8?B?VkRRYUc2L3FGSGQzcUNEM3lQOUpHd2xrOTllMmo2QUlPMTFpc2NQVm1Ya2Vj?=
 =?utf-8?B?U2J4bWlobDh3V2JjdjAyR0FnSExLMUxWOWRMdUVMbTJSQzluQ2tNM2I3dzdo?=
 =?utf-8?B?bWdmYTNNbmlsOFVDSDhDTHl4WGd2bjVRZVkxM0pST1pveWhrOXpoY0xCd0U0?=
 =?utf-8?B?a2NEdkttMVNRd2E0Vi9HTy9idjdyeTZRYzZubFdnOXRWL0hxUUR0ZXF5V042?=
 =?utf-8?B?VFE0dlRiZk5jMFRYQUl3c2JCVloyZUtrYUlxMExZOW1VVHREdkhMcFN0UTNQ?=
 =?utf-8?B?cTFuODQrdlZoOUU1bGFtd0FXdnh0Ui8ydUtiTU90OTJNMUFsUHI2a2RvR1NC?=
 =?utf-8?B?bnc3S3ZTSWp2bTU5Y0F6eTMrYWV1UTkwL2hCVFZhZXVzU21sT2lFUUNNQ3JZ?=
 =?utf-8?B?SGlMRitSZ1VUcndCUXRPSFZoYkZDNDd6eTQvdXUyUkVZbmg2Y0pNUVBobGNO?=
 =?utf-8?B?N2dnU1oySGd2L1NGY1RYTmg4NkgxRHJoMXBxL2RraEE3NUlFK0tkSGZMQ1dP?=
 =?utf-8?B?UGFXRnpnZ29GKzdWZGJQOERzNUJKZVg1cFlWNGFiT2RyWXlaWmgxUjcyazR6?=
 =?utf-8?B?djV3TVcrQUo5RFlhUXdFN2RxYWZSWGc2bUM3Ulc0Rk9QUzBSSHA1MDNuTjU3?=
 =?utf-8?B?Ym5MeGpBZlVhNkttaC9BdkN3VmdPNmZQVkdVZXVJSElLdE9HbHlpVVlFWXMw?=
 =?utf-8?B?NnVVLzhOQ0xwbnV1NkJDRDlPUVZ3bUJwQkZQeTZnZVJCcy9wcXFMRFBzZ2hk?=
 =?utf-8?B?MDlUQUZQYngwbnBGQm9QUkNKZkM5WTV1Wm81WnZ3bUNQVXl5cU5GYkdYQW16?=
 =?utf-8?B?bm5sZllRUU1qN01GTUR5N1hVd2g4Z3BKTWE3RFI0TUVPdkx1WU56V0Y5d2Nl?=
 =?utf-8?Q?W/RuiZerSBxYoA3vqNn1PfqRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3336b5cf-4953-49cb-ba32-08dba7eff525
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:55:25.6693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYe50JfZhJVPbV6T7UReNzjy/fAVXwIQ32QHPnrhH91MxdqRUF90P6rjeZwj8kQGG4hdCj6s/3OdZmq6qG/zZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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
Cc: jonathan.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-28 11:35, Alex Sierra wrote:
> Interrupt sq data bits were not taken properly from contextid0 and contextid1.
> Use macro KFD_CONTEXT_ID_GET_SQ_INT_DATA instead.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index f0731a6a5306..830396b1c3b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -384,7 +384,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>   			default:
>   				break;
>   			}
> -			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
> +			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
>   		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
>   			kfd_set_dbg_ev_from_interrupt(dev, pasid,
>   				KFD_DEBUG_DOORBELL_ID(context_id0),
