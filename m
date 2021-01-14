Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88BC23A5E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88BC23A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585196E405;
	Thu, 14 Jan 2021 14:40:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD97B6E405
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 14:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8jsNWqioX2nqcDfvsL39FtUijQnqFjswqnABoF+5cOW4r6pGVlQboMrZypG6yCjyjTqlH5bS4aQG8OAIyyfu0v0h0pIWsjBdYEXdwUy/+xoeOYCBA9D8xrOsof7ylkN7Pw8Ql4cOUULowGAfASJD6Xhr9SipY2JVtzeyc/C6nlxlmPu/xNGdKmxA5ffujw16gRPWrHZjntxPGozcNStl2mvC/YxUesnJga7qPjX7ooMkDQcZHuXpTaMqF3jtJt3Hh8bm512EVGpMzEFTLMn5hXRXd8a2h8WqTRoMcF5uFPXFOb0QKNQ4WRgXPl22fbHBf1bdxN1xW2iID2UNVigYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0HSxyaUyVtDjQq6BL3MVj0gDdntp2BxeIvKGRigOQQ=;
 b=QxRo1LeHvTDlzjgQpKz+gPVbDwY92rhlafWLMzQJThxfc5sQhShSDTZYPKqVJKM3tW+nRACVqKhif81R+v8Nxk49v/iK7qfj90lgBJE/FRo9x4J603IdvVQzboDnk/w/ReZZKPnEyD8zAyv+q83wgGY835XC5l9lwHoaPgBU6/QadlYlni1mElU0XlGGBtczRgVDNjAt1mjmx1o3kp5p/CMDPCcp1b1c4VgoB1axwte4cyJ6vi344vr18TxQuF2AdRxluIgqAXn7hyhWdxona6dgNKMQMIKoUjVzGno9kjutQ3chXCPk/idLka+Hslx0fnK89gqlKAaLnBUk6ElaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0HSxyaUyVtDjQq6BL3MVj0gDdntp2BxeIvKGRigOQQ=;
 b=OXEyypzOMAcJWxXk/+i9SxUVM7VGrBDxbXkzzsWpDBD73Wd1QOOPZocvorEPmjndXM6CB8+fEVA0bHAt0euKPrk0U4aP2W8lcNdcZah7/nYriFBbs0TmIrFpsiJ48TB13C3SOOaghH/qmFSYHFukWn9TKkHgKq2fV0yXN9TBaoI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 14 Jan
 2021 14:40:19 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 14:40:19 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210114133729.24169-1-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <f2c13858-723e-7463-c347-942dc67559a2@amd.com>
Date: Thu, 14 Jan 2021 09:40:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20210114133729.24169-1-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0::799c]
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0::799c] (2607:fea8:3edf:49b0::799c) by
 YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Thu, 14 Jan 2021 14:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efae1239-9c8c-457f-1bf0-08d8b89a5101
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2352650D21712989634691C3EAA80@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYo0n73lEXDvIA7xVlYngzhYSWBzjJp26cYM9cWBJzh+Q7WeV7r3Ph7RchIj9om0xVUhLnIXMF7RrcK8kci8a8DNUdNR6RRtAt6YFMBgT+BqZ8e9syULyCvgKpQd31lIMSNPMJPalUhHHjhedITG/YQpzBE7vk4J8OI10YECexss0EQyDca4mqc4yKbkeTQ+g7NTFn6qZ6FNMXKDumAmk8SLUYwAT/urZk9SA0JP2IzDnyiFOyr2f0gcyPfMPk34joGorUZoldG/XPDfuMiqTz8Yhwm7U5aOH4OaS32/cMYeY7O0ZZRqyTm71c+RN+yWyqCZ8br1f9WRxAIvEGxrAuiz/pgVYV42HxV1aYJFeMQ7hr1CxIwxXo79pV3h/Xi/cs5+jeB6KDtNYLiYaLSvioDTgA6BOiMJPVKsn0rH47iXuPFtNDzABzbjPL4YUf0Y8rN3BLQ/LJ7z8gJdRZsV1jg6jXWDQfNaqud9HFotZ68=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(5660300002)(2906002)(31696002)(31686004)(83380400001)(316002)(66556008)(8676002)(52116002)(16526019)(54906003)(8936002)(86362001)(478600001)(36756003)(2616005)(6486002)(66476007)(53546011)(186003)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVBKbWhDcG1hRWhvZHJ5eWh0MVdMMVdZcnhwcEd1QUN0eFh3Z3ZvOFFINkNE?=
 =?utf-8?B?TWxDQmZsYnFXV293Qy82NmU5MzYrWHkxcVJKMEFoc3BZQXBsQnFZbVJtNUdY?=
 =?utf-8?B?NGlnYlhiRVF3RXNnSFVESjBEbzN0YWZlSktLRVd6dE5sMUpuZllIeWkrRU9i?=
 =?utf-8?B?aUo4SVBpWUpBZDd2eHY1SDV6TC8xTml0aXE1M01sM0F4WkRkdmdDaEZtWndj?=
 =?utf-8?B?d3lLTW1ZVG1rWkppaHhBdFNVc05PNUN6SXk1UmFuWm56dWM2SU9vNVg0V0Ex?=
 =?utf-8?B?bUJGaS9uSUl2NkM4ZE9lMVlIOXVEL0VHazlDNzZ4OFp1bkRwSEVRcXNvYXMx?=
 =?utf-8?B?YlNnQ25FMEdWVDcwZ1huR2JMYUluditDWFBHSGxPc0ZLdHljcDhyWU1JVEpM?=
 =?utf-8?B?Z1ZTYlVvQmNKT29uNXA3Yk5TcTN5MFQ0Ykx6YTliTm0xcHdxaHhhZmRoVjZO?=
 =?utf-8?B?Umh5TjNDa0IyeElVOHU1MmJVTGlXWkl3SU00RklydkJMVWp1M1pPejRGK3Bt?=
 =?utf-8?B?NTFFcytOaFhad01xamU3U09nMFljWlNVTGNjaU40SFNDZTUwN1BzS0QxNG9U?=
 =?utf-8?B?QjRaaHN3RXFrd2pzMTRDczRKSVQwempMSEdPZ1FiUVhyTkUvSHpCMThvaGNV?=
 =?utf-8?B?VVJBYUh1YnQ2WWlEMkZBQ3B5Wk5VVTZyeWtyTW4yQ2wwYlkza2tUdWRTbWZk?=
 =?utf-8?B?eFcyZFc4RVJNSWxlUFZsa0NnSVB2eTlINWpneDdIN3RmYnhqbkZkckI0N3Q2?=
 =?utf-8?B?bllCcVFGMmcyckJka1hEd2dSVjlzUktKYkhHblJQMmR5cGc3dXVaemV0NkJ1?=
 =?utf-8?B?TTFhM3krcmJQTVZVd21rejBSTldhcjJzdk1ZRHA2bHlPNVZlUEh0SkZGbUR2?=
 =?utf-8?B?UGRvNXZTbnQ4R1U4OTVsTGhvY1htK2U4R0hKQlJSL0dCTUF3K1JMck5WdWpD?=
 =?utf-8?B?VFQzblJsRDhHblpBTTVMaXhkOXlmVHorVVVKTG9CNVVrbHhIUXhjUEFvVHM5?=
 =?utf-8?B?Y3dsMmM1a3hEVEo1bFVIMWlPbDJ4TkZjSzk2OHFIK2szNmhxVnRNU2FqMzcr?=
 =?utf-8?B?WWFSbyttMjFsWnpreFpjazJOSzFqVnZvVTErdTd4WU1TN2twbTFBUGc0OHpE?=
 =?utf-8?B?MzRhQXgxUFNZdmlmeTgyOUhGcERHeEE2Wk5oL2xqZ0IvazNkYkpJWjB5elJj?=
 =?utf-8?B?NGhpK3duSm5wTno0OXhkTHM3Q0dwRVpTemRnUHY5NVcwRVRkblZZRzBvZDBS?=
 =?utf-8?B?ZkNXOEFoNHZZU0FLVDJSeW9neG90R1A5OTlRNWo3RXdKaVUwcmFveTFVekNN?=
 =?utf-8?B?ODQyL1NQMkdRUVJvamRrVEVSQVdGNFU4RGVCTE16d2FuR1RML2cwV2lPcDgv?=
 =?utf-8?B?dVV6MGMvS1F2Mmc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 14:40:19.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: efae1239-9c8c-457f-1bf0-08d8b89a5101
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTZb5bQjvTtajqOWAcjzfsp8slyLkc8M5uE8MGwDfH0GWz4p2JcTrEK4hQadB61YCtzHqSw7fKSIvrgZe9w98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/14/21 8:37 AM, Horace Chen wrote:
> Fix a racing issue when jobs on 2 rings timeout simultaneously.
>
> If 2 rings timed out at the same time, the
> amdgpu_device_gpu_recover will be reentered. Then the
> adev->gmc.xgmi.head will be grabbed by 2 local linked list,
> which may cause wild pointer issue in iterating.
>
> lock the device earily to prevent the node be added to 2
> different lists.
>
> for xgmi there is a hive lock which can promise there won't have
> 2 devices on same hive reenter the interation. So xgmi doesn't
> need to lock the device.


Note that amdgpu_device_lock_adev does bunch of other stuff besides taking
the lock and I don't think we want to skip them for the other devices in case of 
XGMI.

Andrey


>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d434803fb49..a28e138ac72c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4591,19 +4591,20 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>   		device_list_handle = &hive->device_list;
>   	} else {
> +		/* if current dev is already in reset, skip adding list to prevent race issue */
> +		if (!amdgpu_device_lock_adev(adev, hive)) {
> +			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +					job ? job->base.id : -1);
> +			r = 0;
> +			goto skip_recovery;
> +		}
> +
>   		list_add_tail(&adev->gmc.xgmi.head, &device_list);
>   		device_list_handle = &device_list;
>   	}
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> -			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> -				  job ? job->base.id : -1);
> -			r = 0;
> -			goto skip_recovery;
> -		}
> -
>   		/*
>   		 * Try to put the audio codec into suspend state
>   		 * before gpu reset started.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
