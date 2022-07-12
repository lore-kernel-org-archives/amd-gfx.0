Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0415ACCA481
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 03:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7232C10F36C;
	Tue, 12 Jul 2022 03:29:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ABB10F342
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 03:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxWdLQyJamG7o8LDaft5zY6x6ZRmUzweM09rvUIeqODzKBAf3to3jORE/447QaZQC9j2VAWiFXHxpcx92nfAAuKnaEeAqHg3/+hZ6Uc85926UEahTGr5NGPL1Bkcr5/GncAtBqzKMQgi76l2kmAC297asdDXZ3tMwxAsPHPqIPE33W3C7zlFSX/ftohl1Ybdr3ZyZRIb6cItl1c5JABX2lpr347XgRwr8zG3UUhXP+9w8JebIKUOhapGfjPmJ+9f3xD927iTOi47sdoVgpf2t5VcMwix37FWCp/Odo93+sSPhyphzsCbhAsYS5gqIqw2Tei/8lX3/WkB+Dua0goS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bq+vmbxDUpH+ERQwaqrS4kPygTqH9/sNhoifGBmeuI=;
 b=F3Z30VEAXdE4XNzCyDVRHXKB07RUDzXhpl7+qfjeYncWrrop7gPB22fEQxmOjG126cjKlNegQPopl+wjVlNhgiURhMiCfDjuJ+qMliNQ+9I8HsRxxVmMf2Xhu2Udcz/mzw0tD71iGKd0D+KY6hUPfvlBmji6bMIqjvQf+CTpWP5rvZ05nZi0Qg4C2vnhSSc9lTSqKSr4IHXaSfLX9PTZK2EMlGr3B8MRA1qfszft7vUMfd3r35uO1FJzuUoM13TPlo7vaZfK03NvcgUkjbk6HZUsVzgD9WDkk2aCGjKdNYba8Fz05tGMiywUdUxaqTRN6IEsh26536oGzmvJUD1cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bq+vmbxDUpH+ERQwaqrS4kPygTqH9/sNhoifGBmeuI=;
 b=TlVxveLht0qk4fT3YRMG66IfLtL8jbeguFRknOCrcLZra4h3P/0O7abrIQcGSpo8WBR2Osh5OhdYJeSU+hMWo7pRB5c4gZ8OUrqVDfOlXEtNZHPLsUGrClW5xl+gm26366tzF4Q7lRSQl4nWxOyznEFHppDUn024aXyqSjYM5DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 03:29:29 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:29:29 +0000
Message-ID: <046084c8-bae4-fe6c-7a35-30d7e7c729a4@amd.com>
Date: Mon, 11 Jul 2022 23:29:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] Revert "drm/amdgpu: remove ctx->lock"
Content-Language: en-CA
To: 20220621144227.664800-1-luben.tuikov@amd.com
References: <62d06aef-ff23-93a3-dc36-c4840b1f6d80@amd.com>
 <20220621144227.664800-1-luben.tuikov@amd.com>
 <62a6f649-5026-49a0-a574-1e73d63bdd67@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <62a6f649-5026-49a0-a574-1e73d63bdd67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80bef82-d02b-4cb5-37d3-08da63b6ba99
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHC2/bLodpN5h1YEwKGcTKkm9uRMoayZQLYw+XBM9LlRuf9sHY8uqLt8z7EGgTc+3Wb3x4ISsfaE24qyrhBEoxceSzU3MJPuQ8HISg5Ckcm/LG9ABUi5FBgKH2MMInypzmKEj/dSjRYZDWaNiJ7MEmD5h6FGKcYno1J1q2FGAx2c+lTP3Jjhzi0t8WpQ6NW1BXWheXq2t3mLhNaJh5fLYeFmYAUOQEZb+jsMQRvJWOMRiCOb8B/kGG/G+HUFOkgFRJlMIbU2dSqDFrg1GRdSh52+q7qOgPDp3UcUztr/TiuQ+iNRUNQ0Y3+Mbp87iQUCu6JfoH9EXNXhfbfb5lNbkFiTFG3pb0TJM0eCgHRTIlp8NincO6q19uV/2yoIO+IfPZ7Yvcn2qUNFVjZfJGT3MPZ8KdRD2K6lP3V7YUCzs0ehjkKtjJTxiPDnhRx9Dy6rPMYMiW3nsX+V9Rbnbk6H5hoihIC+YejpDMOx706l2WuXh/q87hmPLnxPs/CefakLEUOjQqi6HE4lGvzfPsr8OGbVsrX7aEd55WD78oDv+60OICBqw65QI5OY+SsBrXQ6hGlggZNhSp+s6yawQVVq5f+5g6YDCcCFwzGjcaXyyt5KY2KtTj0Uidl1cnPIdkhXeeANlU9BPs/xMfHb0KKBKzCiqvdgcjoFFy47/os1flt4zFNJ0in9FSa6KpV96ZNlGImMiOMJjlrmc23yrvoC8tuzyl7w7LCF9U3xIlboV8bwI9sJJ8nd5G4/4oqepmXPW8sv97tSxwjIpvwMxgkf8UYDVPyWvW2DP9JqLgVDn44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(41300700001)(2906002)(6512007)(6506007)(26005)(37006003)(6666004)(53546011)(316002)(38100700002)(83380400001)(66556008)(8676002)(34206002)(44832011)(5660300002)(66946007)(66476007)(186003)(86362001)(4326008)(966005)(31686004)(8936002)(31696002)(36756003)(6486002)(66574015)(6636002)(45080400002)(478600001)(2616005)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BXRWdNeithcTV5VCtadFlEMjR0Z1dkUDFMTlRJNjNzUEVzREkrSFlzcmZk?=
 =?utf-8?B?UDBnOUJvU0cva3cyUUhhcFE1ak80UVF4alRscFc5dm5adThOYklQalZBNU00?=
 =?utf-8?B?dGFlcmR5aHRaSEJvSDhxcTBOeHMyaFd5WHhMNU9Fc1pxQmhjWVRFM3J3eFhv?=
 =?utf-8?B?ZFN4U1c5VVJuZDA1dEFYSjFCZHVaaXNuTW9CNmp0eFNENDJqemFZRTdLOHpC?=
 =?utf-8?B?eXFUNDBYK1lsSUdZQWNMc29nbWdSanBxQWFoK2FCTWlmS3I1RElDOVFtbmFu?=
 =?utf-8?B?bUtCOVk5TWlQL0YrUUovQlE3L3dwOVAzUHVTSXhLaE5FN3NGL1JTK0tDMnpI?=
 =?utf-8?B?dlhTcmVDaUlqSXIrcnR1YzhGYjJscnpkbWJYYU9mOGo3R0RHRFQ2U0t3aDRt?=
 =?utf-8?B?MmNldEMrNXFRem5ZMmdjeEx2dmp5SUg0U0Q4bTRmdWN1OE9wdXdFRmdmdFJ2?=
 =?utf-8?B?c1g1V2ZhNzhYSDJaV2hRTHVGMndQZElkUUNUS3RGYkxXOUhKaXlsVGxUM1BW?=
 =?utf-8?B?V3lDdFMzL3FocUlXQm55UGdhUjQ3WXFIM1ZzUnplWDBxZVV0bElKWjhkQ0hC?=
 =?utf-8?B?MjgzQzhQTUZZQk5iOHJtWlU4S3dvcHhiMkQ2RVFRMFBDaHllM1hWdEppT1J5?=
 =?utf-8?B?K3NtOUNwL1pRb3FjZnZWZ2h2TC9PV05ZQTg5SHMvcDZKcitHMXBSa0N2ZU5E?=
 =?utf-8?B?YlU5a3ZBU2Fpc1hLaWxLTTVoeXNHanVvQldIY0k0d0ZuOXBsSnIzNVptVk1z?=
 =?utf-8?B?TjBCOWNQV2JCRjJhRFB4Q0tBQkpZUzZVTkxWbHgwdStjNWxGUVphZlgrTEFB?=
 =?utf-8?B?elVXekdZRjBxMjlBczEyalZpcEx4d1dTR0NGREk2V0Y3bmxxRHlpUU9Zcll2?=
 =?utf-8?B?U0Vid3VFYWJraWRGeWNrMFdLY2s1U0lTSHZiL21oclIyS2JUZXpnTWFZeWs5?=
 =?utf-8?B?WGo4N0VrTnYvaDhCRHJEVmZvOXROL1N1ckwxSFBYUjRDUUhtT1Bsa0pmZERu?=
 =?utf-8?B?SGorQm44ZHR4WTVZdGhQSjhTTjJWOTkxWjREVUJTNVhmQ2lGdHc4TnUyb1M1?=
 =?utf-8?B?eUorNjJiK2xVd08wc1dUU0RmTmgzaXUxSzNmelV5b1VONHV0RTM5dzQ5dC82?=
 =?utf-8?B?VUlYTXFFVGpBTEVqRGxuV3B1aHJuMzJFN2tsWXlQVjlkZGlXdUlUQzZDckdG?=
 =?utf-8?B?ZnFLNzI2cUo4SHZrSXY0Nk8vdjljNlZhMzFYSnY3QnJOcHRLRlhtV0RDR1lP?=
 =?utf-8?B?cnExellMMFpCT2xwSVplb2tuSG1rYzJnUlR1VEwwenIwamtlelZLVWJtMWdG?=
 =?utf-8?B?cDJQTGxHMnVaK2xkdUoxWGJjcHk3WG5MdjVxaExiTVdoVlJPYmRUNmJaSDVh?=
 =?utf-8?B?RlV6T1dWamtjUndLNnFJbW82ZmFFUThOVEtPTkVPWDg2eGdUeG5wM3I4NFFE?=
 =?utf-8?B?MUNxRXFwQjdEU1NWZENiT0JoSlBzeWVuWTd5ZjFQWkY5TFNYZjdTaFVFa0Mr?=
 =?utf-8?B?a1FqVEFySHRTMzY1NS9ETmx6SXRKb3V2NCt3NFQ1WFI2WFNnbjZHT3BLbHJE?=
 =?utf-8?B?dHkzY1d5aCtYZkV3N2lpY3ZQbVNGazNSNDMrdlk5cTlqSy9Zei9IZ0pscHc1?=
 =?utf-8?B?VWlTc2hMcVZ6U1VYd09UTEFjUFhydG9DR2FKTnpBcnlxUXdRRFJVTU5tWlpZ?=
 =?utf-8?B?ODNNM2tCcGZsUEpMOXdOSmtEZ1JUNHZnbkhScXhCM2FUM2ZxMkY3NDFlMi9v?=
 =?utf-8?B?UXE4aVp2b2tOTEdXRExqWUdNUysza0pvWFFBNi91UjE1YWFOemM2enlqQmRz?=
 =?utf-8?B?Rmk2ZGdhSVVyVWVGeEU4L3JtbWVVa21SUy91SkE5cmg3Zm0zbmtXaFlJZ1hK?=
 =?utf-8?B?dXVvL05iSjg0dXg5Vmp3NmVTdFgvZUZmWmVnVWlNL1VTaGNITUlvcVJzbzBh?=
 =?utf-8?B?d3ZEb2hnMkIxSkE0NXdmeU5TOVJTMHdpRVlERHJvRC9rcitPY1dYeDVyR0th?=
 =?utf-8?B?UlBGY2M2K2dhcGJrd1IyT3VmVC9rMTNUN3FudTVieWxPVWVSUldQelBwSkU1?=
 =?utf-8?B?cUpmWWJkbGdZZVE0TS9jWVNaMUJMRStkTkQ1TjRNUVExeGZLd1JycjZTYjJF?=
 =?utf-8?Q?3Hiyh5GEXMnKJ4s2b7QEHfCVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80bef82-d02b-4cb5-37d3-08da63b6ba99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 03:29:29.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtmwIb2NGdjH2EhVAG8pPpcFsfG5XqWV4cc0XNAVcKKgWaQM521zMvHyC36ikLTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, siqueirajordao@riseup.net,
 magalilemes00@gmail.com, =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
 amd-gfx@lists.freedesktop.org, Melissa Wen <melissa.srw@gmail.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-11 23:22, Tales Lelo da Aparecida wrote:
> On 21/06/2022 11:42, Luben Tuikov wrote:
>> This reverts commit e68efb27647f2106d6b545667f35b2ea39746b57.
>>
>> We see that the bo validate list gets corrupted, in
>> amdgpu_cs_list_validate(), the lobj->tv.bo is NULL. Then getting usermm on
>> the next line, references a NULL bo and we get a koops.
>>
>> Bisecting leads to the commit being reverted as the cause of the list
>> corruption. See the link below for details of the corruption failure.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2048%23note_1427539&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C32a7f3eaffff490fc69f08da63b5c925%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637931929684937036%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=eXMfeyqaPhBIl9iJa4kbQtN1r4OhFZSGkZiGRJ3MQsQ%3D&amp;reserved=0
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>>   3 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 36ac1f1d11e6b4..e619031753b927 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>   		goto free_chunk;
>>   	}
>>   
>> +	mutex_lock(&p->ctx->lock);
>> +
>>   	/* skip guilty context job */
>>   	if (atomic_read(&p->ctx->guilty) == 1) {
>>   		ret = -ECANCELED;
>> @@ -585,16 +587,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		}
>>   	}
>>   
>> -	/* Move fence waiting after getting reservation lock of
>> -	 * PD root. Then there is no need on a ctx mutex lock.
>> -	 */
>> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
>> -	if (unlikely(r != 0)) {
>> -		if (r != -ERESTARTSYS)
>> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
>> -		goto error_validate;
>> -	}
>> -
>>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>>   					  &p->bytes_moved_vis_threshold);
>>   	p->bytes_moved = 0;
>> @@ -722,6 +714,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>>   	dma_fence_put(parser->fence);
>>   
>>   	if (parser->ctx) {
>> +		mutex_unlock(&parser->ctx->lock);
>>   		amdgpu_ctx_put(parser->ctx);
>>   	}
>>   	if (parser->bo_list)
>> @@ -965,7 +958,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
>>   	if (parser->job->uf_addr && ring->funcs->no_user_fence)
>>   		return -EINVAL;
>>   
>> -	return 0;
>> +	return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
>>   }
>>   
>>   static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
>> @@ -1384,6 +1377,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		goto out;
>>   
>>   	r = amdgpu_cs_submit(&parser, cs);
>> +
>>   out:
>>   	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 53f9268366f29e..2ef5296216d64d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -286,6 +286,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>>   	kref_init(&ctx->refcount);
>>   	ctx->mgr = mgr;
>>   	spin_lock_init(&ctx->ring_lock);
>> +	mutex_init(&ctx->lock);
>>   
>>   	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
>>   	ctx->reset_counter_query = ctx->reset_counter;
>> @@ -400,6 +401,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>>   		drm_dev_exit(idx);
>>   	}
>>   
>> +	mutex_destroy(&ctx->lock);
>>   	kfree(ctx);
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 0fa0e56daf67e9..cc7c8afff4144c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -53,6 +53,7 @@ struct amdgpu_ctx {
>>   	bool				preamble_presented;
>>   	int32_t				init_priority;
>>   	int32_t				override_priority;
>> +	struct mutex			lock;
>>   	atomic_t			guilty;
>>   	unsigned long			ras_counter_ce;
>>   	unsigned long			ras_counter_ue;
>>
>> base-commit: f4b3c543a2a759ce657de4b6b7e88eaddee85ec2
> 
> Hello,
> 
> Applied on amd-staging-drm-next (with two additional commits from 
> torvalds/master to allow me to compile using GCC12: 52a9dab6, 82880283) 
> and tested with IGT using a RX580*; the errors on the "amd_cs_nop" tests 
> are gone!
> 
> * Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 
> 470/480/570/570X/580/580X/590] (rev e7)
> 
> The remaining IGT tests matching ".*amdgpu.*" were not affected. (FYI, 
> amdgpu/amd_plane, amdgpu/amd_bypass, amdgpu/amd_plane, 
> amdgpu/amd_vrr_range are failing in here, some should skip instead, but 
> that's another thread to come)
> 
> Tested-by: Tales Aparecida <tales.aparecida@gmail.com>
> 
> Thanks for your time,
> Tales

Hi Tales,

Thank you for testing this patch and letting us know of the results.
This helps a lot.


Best Regards,
-- 
Luben
