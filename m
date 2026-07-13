Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC484C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 20:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB4910EAF9;
	Mon, 13 Jul 2026 20:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5a4DkVGa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CC710EB0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 20:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeD1ZgycCx4nacSlQKkA1TnhDgRPKJuaEcjRHRhptCTvb21IKrz5X63Tdb9nFuoyj3M17myyrAaKPXdMcmT1l6WHfg0wZXRrsOZuhy7CPxJbvpprd0cMQPMIHxn6kHvcJ94f7InOd/aOA50J7f5DvfoOd/1ADEG5cN1cbF1YP/1d97O5xGAP5DgL85gMwX83CD4wfhwLvyufOnN4J/vZF2ugEFxI/LNSMzU3Mj0QVh9evZb3stgpwo4htkEKY/S5ZIR+hlpgOlmSs6eVtKYQyqAx1/GcIZWY/3x1j7OPS5Ar0VV9h7vFOeVIaZ4IpL9UtH7vnhaBmKv37oJj2FUmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHKFHfYkZ/T4Yiko5e3HlNaoQ44dVAFwINhvQfg8h8g=;
 b=iX+1wCh8kAuZGO5TFf6k4z4uxcCgaSbSbMyXGUnf4TTzB4Fp8is/F372ZitkU3v74GmqsNDVxJ8wsoJhjzSHGCcpLy5A4dFVzBW2HogTxHRzBJe8VMpmebiUmiE4qGyjXfFv8XnEPYMmPzCF4oG8GEBsy4OmNm1ii41LlvVDlD1KmUj10dt8IF+5AbbzWR11ruNyOq15TuIqfNPVohGOVqATdTmaAZv2HkIyvLPoBGW0ZcuB8zyOGn389p9GjEW8j+0bgW9fdGKyoz5LGv2DpDN92IifjHCTWURIgc33SynApMJAK3NmC9tMXDxOPaU4YKasV30yafLaZrMRUeYncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHKFHfYkZ/T4Yiko5e3HlNaoQ44dVAFwINhvQfg8h8g=;
 b=5a4DkVGawjldOjIJgJs9NYSvJJs0bh7rC45dGumArKyLzXfP5jW/IqJ2bp7qg7V6P58ZK2kK2wZoO/mQeAZs4d8Rk0rjfxZ4TUgoncwYqF28HdtcDhnqt2g1gWa585igyjb5CEbXjCNgnY+H1/bAyxzey0PMjztYXNqriuaoTwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 20:38:05 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:38:05 +0000
Message-ID: <d7435713-8a6d-4658-97ae-8706f40862a6@amd.com>
Date: Mon, 13 Jul 2026 16:38:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes11: set remove_queue_after_reset for reset
 unmap path
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20260623063218.188781-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260623063218.188781-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: aa802104-5160-4a1a-65ce-08dee11ea40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3K6efKDCECG1D9xMVkVi9zEzP/tErR949bYLm21MvJTjIDIDQmfDi7PbV/I6T7Srml8hUgU8Is6odfRCOCMLFSNUZteYG9sV/SLoGvMPFOl5KU9+Jhg86SsBDXVdptH9xWo5IRY355Lf9+IZmpuENU3go0Itd2xw6avahGoj/Qmj8Q+9HsIGKls7v2hTot0QdzWQ5DppTDAejt1OhAnRljouPVDSW+SZ8SiNDWLyTGuEDQ8PCA/QrbPibkXqsAB53iX4N6mfbSn97xi+p0sfVT8cHICNNchr+1Av0mYl7ezjJX2h0DHHrmH/kTivSOlF09jSulGTt+aotlCjUEU11SxAkm5xxUzvuWM79KOKMqq2D0gagxJ3oESzOHnDxZ2rz66NfISe6CsPHDtObYCbyTep2E1p7SzzC5QLfOs92iMgrM+LtXWX5+s1WVjB1j1RaTnar0D8Ga5LZfDbmUZByk0cnxVCY066WGyzs0wI+AOncie/mi9S1yGKJFHyNyAVuMIlcXXB4LagTbc8RbSukCkS6+q84I4sn5rjS1RxDVrhYnkW3AvRjiEfF9oTsckyVeqth+0gBXxLeVgQ2BzkH/5Sf08UMHZ//aT8L/tNfLfnlU6vH6HohOHVEIMP7jqZW/8xbMldYe4u7b9CzG1CcvAkBvlJJQosegDjka4foiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JOcFQ3UC9qOHJJOW1sTjVUZEI2VW0wY29xOG8xTFJ2OHozV251eksweGsv?=
 =?utf-8?B?QU5sY3RtazRQM1h2dGpCYVJrUEJBSHpPL1R1MzBXbEhPYmJsVDF1RFJUTmdj?=
 =?utf-8?B?UjRZWHhtRkJMY0c1USthZlVLTEwzdTFwcDEvRnRnWGF1TlJ2eFZwczEzd1dl?=
 =?utf-8?B?OVdnbGk2SjR1Y3paY2tJbHVuZ3dEMmRpejVPelFQZndzYjVXYS96MnN4QTUv?=
 =?utf-8?B?azkrNXpFVWJrUVhINHJMeXZDRTVQQXA2V1AxRXlPODRhaU4wTXFVdmJROUNQ?=
 =?utf-8?B?RkZDa0k3bkwydjNtZ05LN244Nzd6TXVpQjFrVDEwaVA0L0dCUEMyOTY0UXVt?=
 =?utf-8?B?OE9IMDIxRUlWZnprL2Z6YnpJN1k2UlJRVlVFdUtDb2FFV0JBNjJuYTVmRmx1?=
 =?utf-8?B?bzM0WDdXcVlXVHdOWUtUMEx2Tjgwdi85ZGFUbEtkNjM5ay9ITG9kQzY0RDRq?=
 =?utf-8?B?WkNtRG5nek13ekc5TzNOQkRkMEw3bU5TYlJKMmVYNEU1R00vbnFIS21IUDNz?=
 =?utf-8?B?bEdpNno1SzJKTG1LeUowekxsQXZYVmFxVHljdndKTVZDbHozVGRHTVZUZExM?=
 =?utf-8?B?ZEoyQWdLWGZNa3lSbXF2amdVOHlDN3k3YVNNVFZEbjhqM0tpbUhiNEtmSGwv?=
 =?utf-8?B?RzlNbzZvc3lpNU0yaUFZbjhKNTZVZ05HQkQ0bENTQnZBV2Y0UU9BK0VKcGpU?=
 =?utf-8?B?MUpFdG9zWkFDR0xpYXB1L3J6ZWNPOHFNbWdEQURJcVg2UXo3eWQyOWczeER6?=
 =?utf-8?B?b1pweWhqOXZSQVRNQ2J0U3FtU3VqTGtqU2JncVNza0xZZlRWM0xMTEpsckpo?=
 =?utf-8?B?cUliVVB4LzlqMEwwMURFM3Z0ZTkxTitGMmFuUVpjckFuYnYxR0UwcGo0cTEx?=
 =?utf-8?B?ZFB5REdGeWVaTG4zS3ZTRW8rTTlFajZoRTZOeThJaitrSytwRm85OXZuYThi?=
 =?utf-8?B?blhTMVMvY3k2Q29VSnNoaHRDMVY3bjFaclRpQkY4NytVQ1ViNWNGNXZKTzdn?=
 =?utf-8?B?dnU0SFhrd1NaY0VJYXdCTVg4RkFqZExpTWpxdXVlZVpjRmk4cVFrZkUvaXVa?=
 =?utf-8?B?S3llU0NSb1Z1dC9xTldZSGpTdkJkMEJVOWJjaTJFeVlYcC94NG1sdnk4a1NG?=
 =?utf-8?B?N2Z5QUd4dCtYS3BzVkpzT1lWTTlkajJEeW04VEppbmFpcjhPMUFMZEp1ZnNC?=
 =?utf-8?B?akZhSDJxYlpiZkMrNmVYaHh5K1o1c0FzUnJrZVdRRDlYbDRBaUpKRkZyMkdW?=
 =?utf-8?B?ZFVTTVBuR2lWUFNkSm5UYXZXQ0JJS1J4VE1pM3UyWFRRWlVLaCszU0dvRDU0?=
 =?utf-8?B?T0pFN3dFVTVqaG9FZG9FOFMvUEx4bEFQSi9GemZiT1ViOFdGSXpzUCtIdFJi?=
 =?utf-8?B?YUczWUY5VmdlaWpMM2xhV0tJUGFiM0t1RVh0U0FwUnVBTTYwRjluTUxnMFRJ?=
 =?utf-8?B?RWdYS2NYRUlSTlYwOFhlU3RjRjhWbVJBWVhhVytoTGV2Z1B3cTNwVE5xM0ZU?=
 =?utf-8?B?SmpPTGVub3dwTjJYa3EvSjhzZmVZd0tXaGRXNzFRQ0Y5dE1yVnZQbDYvYVEr?=
 =?utf-8?B?QUxGL2ZlQ0VNSS9mUVVSYlBKY3BVTHcrMnJLeDdzZ3lITHJhWXNYSy9Od0J5?=
 =?utf-8?B?aS9nd1VubFNWTDl2SFhETEFKZjBGOW5mRi9wWFhZRm0rV3o5ZDJkeGpkSGcz?=
 =?utf-8?B?eHlyWlhDR3RIS1EwUXVGMlR2aWt6Z1hnM0x2UDIwbHlnQy9BdlR6K2YyVTZM?=
 =?utf-8?B?TXFMWm1SaEtYd1ZUTFVpcnJXaDZDeWZYNHU0QlZMS2JHWXRkS1lLSTAyRGZh?=
 =?utf-8?B?ZlY4Sk8wSlhYcG5kS1ZzaXcwOWdCKysyRGFxTWJTMVpseVc2YXVVY2N6UTlR?=
 =?utf-8?B?cGVDdXpteHhWZ05Zc0YvRmxDZ2MvODJVem52MktMUWphY1dMYVlyWjFyMEY3?=
 =?utf-8?B?U0FjVFJXejlRcktwQ2xsUHNOM0F6eGU5L28wTTgzSTNvS0hpNmJBcE1tOG1k?=
 =?utf-8?B?aG5UME8rMFFybmE4QVRqejVrYVZycTIxdi90UzdWSXpVTEJoTTFLSkxwVG1Z?=
 =?utf-8?B?VmZsR2J2T3B4alNDc2hxWjE0K0FaOVMrUjFRcEY2R2t4UHFmbTREQ2NnL1NC?=
 =?utf-8?B?MTg2VjNqQ3JwNEY0dnFIMW5SRmcveWw1b1hWM3owYUFNaEs4cHFEM2dTTFZD?=
 =?utf-8?B?OE4wUThhbVpseEVpa1dQZ0VHcXhCeDNOWC9lTmdWd1c0Z2ViZ1ZkRUJ4aU5J?=
 =?utf-8?B?VEk2a2d6eGtYVUxEYnhoODVSS0NGWS9TeW1pVmhZRjc2a0F2eHNrM1ZhWjh4?=
 =?utf-8?Q?3GRxBL7C1XLdagNEI8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa802104-5160-4a1a-65ce-08dee11ea40b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:38:05.3755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/+WLrPf+m0IFhpWdnHgrykH7YK4CvDBql5D9DivAaIGxVa4ZZQzo3Nh+ovCzWSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
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

Reviewed-by: Amber Lin <amber.lin@amd.com>

On 6/23/26 02:31, Jesse Zhang wrote:
> In mes_v11_0_unmap_legacy_queue(), set
> remove_queue_after_reset=1 for RESET_QUEUES.
> The queue may already be MMIO-reset. This
> flag tells MES to drop internal queue state directly instead of issuing
> another CP unmap flow, reducing timeout risk during recovery.
> 
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9e27d01cbfa3..7bc756ce7aba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -761,6 +761,11 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
>   		mes_remove_queue_pkt.unmap_legacy_queue = 1;
>   		mes_remove_queue_pkt.queue_type =
>   			convert_to_mes_queue_type(input->queue_type);
> +
> +		if (input->action == RESET_QUEUES &&
> +		    (mes->sched_version & AMDGPU_MES_VERSION_MASK) >= 0x60)
> +			mes_remove_queue_pkt.remove_queue_after_reset = 1;
> +
>   	}
>   
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,

-- 
Regards,
Amber

