Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED1EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 11:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2774710E1AA;
	Mon, 21 Mar 2022 11:21:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B30110E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 11:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6I5KAPVSGfMXjaLkwoalIR6uCrPXKRWG8W8ayJ2fPsPVBKUqdsv1SOuHgILyTL60X0uvf1ogJfdWlxYj4AYZj+UY7/7PEFkD0FIpIUgffflSd3/0g5PwG1mtAMLODkkIk7gf3Ah0rz2JBXhObTsZr5KxV8uJbvddyTkDCSwCztKbY2lHsiOSUNG+uYN6owd3kyw6UQAIW6Zq8gvRzz9NxkTmFttJAg+ByoAB62m/75S/gvH/Zry3mX7Z30JzXvd+zwKplxPTyI4JlMinA4PfT0PtX+UFdbnoLfsS4TPJGz5eTZfhC7qlgcYo+O6w82Ju8qQ6yHIdhfeZUspso4pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3KxNwiOqG/oBtp6jrXKBJjJ5rBzI9EZWEfedGSnbs8=;
 b=ZOOwv/42IEwaHMDJ3+GZMhHFMxn8f3fsXNvZXmUocQdE7M7V/u44dvdMj7NSSixmfGgDv3IBnVgkCcsY0GqyAF7QBKpIyDHG/0wB+RcSccAVeTXH8Wvpd4PKmwgDYFvzvzMRqYgHY83IDStiio5DsUWojXtCJM0RpOyV1TbdEzk2DQ9qINhQEVoI0KIZGxh7ava/NuXZZ6i7OVaCUIom1sfGD/I88QtzfSwg4KeXmADani/SrPv71Jd9/rZZmKe4YrDYIMN4fLDKYEpRr3XlFvjFoIWcmXq7pcioeywcmPReNiUdKb7fZK6b9iScJ7VNWhkjBZCn2CagQ83BK6otAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3KxNwiOqG/oBtp6jrXKBJjJ5rBzI9EZWEfedGSnbs8=;
 b=G/BMvVOpt89F9YJkuAqeIcaLhGhd3tb93eqNea3mCb3PhiladcIG4ExBnpXOB39DYSmq+RY7gMj8LRQhVmY6v3GWJqkP5NYtPWMrrVBVnHrbj83WHMsq7NUgxiGxzh9RWAuOLE7QnuHijHwkW/5jVZcFgkjg5JOwY9Olw2rmZ6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 11:21:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 11:21:43 +0000
Message-ID: <25fe0aa1-aec0-4dc1-0238-24dc496f3528@amd.com>
Date: Mon, 21 Mar 2022 16:51:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, Felix.Kuehling@amd.com, stanley.yang@amd.com,
 yipeng.chai@amd.com
References: <20220321093818.24270-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220321093818.24270-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725dd3c3-0724-4510-8b34-08da0b2cfa48
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1573EB4477B7C07C5E94B18897169@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBHI8PWiy9E9ERvMJSVDF2xiSIqk8c6xDOPzK7Yrjpn2SUTzrAiohxICrPk5tr3kP0oSFupTVMTNi05H/1C3PzeCZqnd1pbHjwZTcxRdNSn+/pcGgMHjZ8wP3EB8q6sczCytcafKkVcnzHVbMHFEfVnQyQmwqyPiXzn5AEXBWlNBY6uOZKFMFMqq9E1k3skswE6WKerFrZ8aD+4xQAkqiwgvoyaopT7oPalT4s+3u77DzCXajp/mxPi+uYd7jqXSavar0ZnGt1SisFgLUpdjVuqTwH/GLfDtL7H0v4vqM0dKrxWeWdJf5k1KOpAM5kiik97cUQno0opUn6JUIQMcUKiIT63z4ltLpG0ptcyX1Z/AEIdlFV4MWYKiGpwZa4vRisDhL1LU4nVotvH8hcYg+yG/6h+0UVaf/oNdrf2wF3uysTxyB8fEnbj3BznoIyI+N+Q2ErHN5yDu7+SmPajFhJrRupWO0DPH6o51A5rzRbLhw+DCtl1U+Ct0penrQoM5PHBdmfjnl3PjXvOqEhX5iQk4qDI1bu5tZUuz2pOVfACppOJv60ApvqRLsygXoSHNyW73VVfbo7UnGObsDl52hLDnyFunIlMGme7vzRClyHRj6tsBgg61/aDOWZctVrMfZGCpOb740sPetAHE/yi/nAInLPDV2Phe7/MxpBe3JQFlLtRa64fPWepqPrNpvJrGQhi8wopfA9UHclBodcvZLd3HcC2E38oECN/JXgsX8tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(316002)(6506007)(2616005)(83380400001)(6666004)(6512007)(186003)(26005)(53546011)(31696002)(86362001)(508600001)(36756003)(66556008)(2906002)(66476007)(66946007)(8936002)(5660300002)(31686004)(8676002)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxiMVZ0T0hoSlpCczk5WWNYQy9kZzdUMC9mS3JmMlpMdTdyR21GNm1RcWRl?=
 =?utf-8?B?NXBoUGxvdWtUZWlQVFFaWGdHOHBQMk12VC92ZjJ1aTVwZ05VcnJSbys5NkEy?=
 =?utf-8?B?dzZSR1I0TzJ6cmZuR1R5bjBkYllONlNFS3hXOWtuaDlVejEvVUpUMDUvWGlD?=
 =?utf-8?B?RlN0T2RBUzZ4Vk45dXpMNHdIZ3pRZXB0dlBycHM4RzdHSlFtUk84dUZubHFo?=
 =?utf-8?B?K0R1NUwzd0MvMUIwUjhwcFgvUnhxdmF5MGtvZjVtenIwUy9DejhiRExOU0lZ?=
 =?utf-8?B?TjhkSGdmSm5Gb0ZmdWFFOEhuZlNhMXI4NlZlM1kzeEFaK0VNbHZIc1cwTFUr?=
 =?utf-8?B?alU3RFE3STVhU1FKbXc3bVZCWnBMbStnOVlHYkFrSnZ4MkhNUG01TS85RS94?=
 =?utf-8?B?elRob3NPQy9YNmlCcE9mT3V4bzIzOHJmV0tnZ0lRb2Uxa0lHTkpSRTlVOER1?=
 =?utf-8?B?RDB2enpMUVVnQlVoVHZrNG52OXNRVTFad0ppYWN1eHN0bThpUnh4dkx1NE5j?=
 =?utf-8?B?cTc0cmczdXEwUTR3a3ZZL1FReTVGc3Fqb1hIeXA4YjdtN0tTMjM1MEF6TG9D?=
 =?utf-8?B?aUtYNHhUZXp1clFKTmhRMlFxWTkvUHp4WlJHK2ZvbkwyZkZPM0VoOEFPSllm?=
 =?utf-8?B?WlVOeTVUQXE3WjVLZzNFcU1vemtsS2F2WDliS2kvbXFmQnoxM05EWmtKaGRz?=
 =?utf-8?B?aENqVzQvZEhYNnd2WURMclEvSm9uN0JpTGNNUDM5SXlJM2owN0JTRmt1TExX?=
 =?utf-8?B?QlNuWk1zM3N4WklpOVh4ZGVPZ3I2OXdoQjhoNmplVStmMWdwSnlCaDF6bVdw?=
 =?utf-8?B?R0xPLzVBVmY5Y3hXZVBZWmczZXl6dGpvZVFTdEk2b0l0c1BmejdlL1F3OC9n?=
 =?utf-8?B?dllobE8yQjVTbXRIcXVsbWo4NG1LTERQM3VIZTBEMmp3SmRMekxaYnBRRVFF?=
 =?utf-8?B?VEtJbC9vT3IvUGg4STVvcnovaVhLTm1MNDNDdnViWHNtMDA2TXJRZkJCRXJx?=
 =?utf-8?B?U2c2eFJKUFc5VXdNYXlLY3lRTGl5UUR3N0FwWW52dnFPZDVRaDVCUTl6SkRG?=
 =?utf-8?B?QXRCNzZzUVVjZS9rRkVrMmFnNU16bWJJMWQ1Zk1kZk0zK3pjbkRvT0NZeWVu?=
 =?utf-8?B?bC9nWnZhdVdhUm4wSFJpRGM0U3k4WTE0cUQ0ZXY0aWhpN01XbHE0MFJzdjBV?=
 =?utf-8?B?Z0RZSWpnbUc3ZmdvbEZEc2RQcUJvTWtOVnk2STVEYldNb2J3Yk5uR2hLUVp0?=
 =?utf-8?B?ZHBWbmN2TEd2SDloR1FSVjVNUnZvMHJOcWJUdUlLOVE3U1pSNStqcFhKeFRi?=
 =?utf-8?B?TkV3eDVkOE9SVjlyM2ZSNVFmelhKMzZBY3NkODdBRXJ4Um10QVphVVBldzAw?=
 =?utf-8?B?bFhtL1c0OW9OeFhvWFdQVTVSNS9ZeXJZQzFWblRKTHY1SUFORGtSb01HOWUz?=
 =?utf-8?B?elVnOHJVSExFVHhGQ1ZyMTI0Y2RMSE4xQmhscTFzRXlFNjRRTzBVSWhtVUJZ?=
 =?utf-8?B?RU9YVWM4cUJTbFlpUnM1VzNEbnlEekNLL2Z2SkViNFU2RCtETEpjZEU5cHBP?=
 =?utf-8?B?V1o2T1UvcEN4OXVGbzVhazdUNDN2UTZuMWRqUUt3UVBXRzRlakZlTS9uN0F1?=
 =?utf-8?B?UXpBbExaVmI1TWlYU3VwOERwZS96RDRFckJrcjh0YWQrRHdudGwrSkxoM3l0?=
 =?utf-8?B?bDJXbGIxSGJTV2V5eUZRNDZ1RzBNbmdKblpNRndtdFphZnhLS1RRcmYwVnAr?=
 =?utf-8?B?eTlDYy84aGdIYmw1Q3M4NHlRZkNtbytvRlB0UFJCZ294WkN6T0p6N1Z5bkcw?=
 =?utf-8?B?aTczWXI1N25aWFJ3eXcwaXhITFc3dStQOWdSSk4vZEpucjdFQUlWcksxOWZ1?=
 =?utf-8?B?cnpjbysxUHBYbEVieWtCR0djNzUramhuT0w3UGpTeFRPeGdSQzlpdWhOcEdC?=
 =?utf-8?Q?QMGV0QiEA+HD2UMV7SGtcbsdCOZbBIby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725dd3c3-0724-4510-8b34-08da0b2cfa48
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:21:43.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3wSlpTZccl8v20jjQfylpiCrRLYapfwlaFzsH1FX9oSOXqdVbqC3lrAB8HvklNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
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



On 3/21/2022 3:08 PM, Tao Zhou wrote:
> Print the status out when it passes, and also tell user gpu reset
> is triggered when we fallback to legacy way.
> 
> v2: make the message more explicitly.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 56902b5bb7b6..32c451f21db7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   	if (old_poison)
>   		return;
>   
> -	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
> -
>   	switch (client_id) {
>   	case SOC15_IH_CLIENTID_SE0SH:
>   	case SOC15_IH_CLIENTID_SE1SH:
> @@ -130,10 +128,15 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   	/* resetting queue passes, do page retirement without gpu reset
>   	 * resetting queue fails, fallback to gpu reset solution
>   	 */
> -	if (!ret)
> +	if (!ret) {
> +		pr_warn("RAS poison consumption, unmap queue flow succeeds: client id %d\n",
> +				client_id);

As discussed in another patch, I understand that pr_* is the legacy 
usage in the file. But it won't be helpful for this case with multiple 
devices. Would suggest to change to dev_info() - the message here and 
below seems informational about the handling of this situation rather 
than warning of something bad.

Thanks,
Lijo

>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
> -	else
> +	} else {
> +		pr_warn("RAS poison consumption, fallback to gpu reset flow: client id %d\n",
> +				client_id);
>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
> +	}
>   }
>   
>   static bool event_interrupt_isr_v9(struct kfd_dev *dev,
> 
