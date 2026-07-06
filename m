Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D8C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 17:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C5A10E1AF;
	Mon,  6 Jul 2026 17:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZ6sRELa";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3344610E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 17:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9nszqYzIpibOhYO3TBFSwN28wRc53HRb6gWFnlEcuW72K5HNmdh0yQGYJES85gzH0xEahe6qNx6GZ8V5zBYXO7N1SEl/4nhCgJvVczEAJ0gdwXYIZaVQNajbYs/YKhimIwGymNeOkk73aiIVVmsUkiBjq/AumYp97M7d4oOZuwp7z58FOliQvKeUOihdCKj+2ijr9arvzi21J+FdVBnbJg30fLbV8t34J54sk2jekFNXcIgmCddkrdibrXNbt2Uz6HXOA+bJr+sNTBeM9R5eE9vq8y5OfeEl6wYbzDKHhZ8+KfRD0l/lGUnKMnUPLIgODg5I20LRBZOiW7ZIFtYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8wyWeb3Yw4q0PgKElM/5Ptx5u+H8t3L+x6iDMrWcTo=;
 b=TABHZvwhmyiUhSXzLDmoSgqxJPuqB+A38YUIlvsaWRQtk2/GIOP0XAcT9nikFwbDFmH+xcPhfgrA2hR+ccOaUqBFXku9pIAiP6Y/Be8NJz8r5WpW0zpZj7Cl2QtEKnlISs6E0iFkhFE6th+xGCFhAnLkUVNH/8Q3MNez1PTHdUqaDrn/UYA/8IyRP33al61JhdPdBNwprznZNafaEwcXW+iVqWDRfTHZ4wJtxidUMvgil18fEZEMRKXMZCcb4y3rt0KyYbLFVTOV6f1waUOYOzqeXdvblXjyaw1pdJYfaJKfuZBQIr8Gj5kjQr8v0OMAh1FIWtSvOVR2Nu42mYxoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8wyWeb3Yw4q0PgKElM/5Ptx5u+H8t3L+x6iDMrWcTo=;
 b=DZ6sRELaUsnog8aKhNZGiM0my7d++fAXX25rhf1eCervr0iI3yq6wMf0ovEjfnZWrzgg1X6HGaMIDf5VLXLTp85+8wWL9AARvo/V7zMqudO2klPep0DSSk0p+cUtHYBWD70rqaGFuoWgdYS9X4l6V73+hZFMsCjnVZpUtQe161w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by BY5PR12MB4049.namprd12.prod.outlook.com
 (2603:10b6:a03:201::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 17:54:45 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 17:54:44 +0000
Message-ID: <b4c86f72-cf00-4059-af34-4fca30331924@amd.com>
Date: Mon, 6 Jul 2026 13:54:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: properly free secondary context id
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260701081433.11134-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260701081433.11134-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::34) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2294ed-e089-4842-56a5-08dedb87a9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1i1N8Vrp3jBmFgsBmqBa6fA4nq2+Z5mCXh4mtFQRXw7ry93VA8iQVbldomTTsiMDYGi7UzQSGr6n6ylCbvhpjopb2yq1PwhZ6S39Y9g/4U8ONX/dUlxk8iMhS75YFMJRkvhMRJPvTsV5wIaSuNIs7RvxbzFZBPpqPaDWqiQr5bBOzyBcMFjEoQUQyz9uJO5fDpn1pgL8TZc9naC7n/IEhuKrA3KQYfbnpGJqhj33VPrMnm8hXlDh6/occ+CTKWzMO2ExFxSZ9nzFcsR4ocCRePa9vECJlwEpMCPfAZOvLMNiW1QsmFEc+5nxIuvCKBAiGGdIH/0iszuMlM7MBNw0TkyoDk4m3sfGImqW3TVQnQ1vVAJgx3E9Fhy9+R6Nshy7YeHStHoOf8oX6MpHxp3S31HnRxVgUDPDxbJxEmhr3nzzNKhs3xcBYROioPl+Y7seNorLlv2QdMKqlVDRK7s2yYBrByFE49QQPh0X4JubT5un3qMhdt9noddUNJZRTqiQ7qIJXWycxKjfGB5AVo9O/9XtC9xJojiQnMwEf90nf9vGjRE5+9hPwlf7ch4pCJENjFoK3SRBDUh8E9fQ2jsbh7OzHVqVrwOleTU8z8iu+l8+WIr8yfIm0RhZZzNqjsz0MXBNg6EuBFrUZ31QgsY3L47iBf7zFO1LR6UEfVf+zI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5xVkZ6NHFTdndLMmhpNnlFVzNyVTdzV1Y3cnptYjd1eFlNVGl2UXFMYVFB?=
 =?utf-8?B?b1FzazBYbllsb3crc3RWWWVuUCtJZ21MNFFDLzFUZTUzZTYvY1QremxvTUxQ?=
 =?utf-8?B?em9ZdXRtbUdrVUZLT1FSMWpQa0ZUVWZJVlVFcVozL3ZkS0o0SjEzVHU2ZjZ4?=
 =?utf-8?B?UnJ1VGx3L2xWZjVBV3ZTalRjaTl5VUh5Szdab1lHQWUrRWo0eFoxUW05YmlF?=
 =?utf-8?B?blRFSkZZT3NOUUJCY3Z2M3g0L2JIcnJnd2NFaE0zSmtwdHNYTHlXdmZFdE1h?=
 =?utf-8?B?eUxjR2Nhc1F4VEVWZmFzUmcwZm9NcVBoWkV2ZkdKWVZvWFRoL1F4WnVkcGx2?=
 =?utf-8?B?YWJzK3N2ZE9acnRBWW1WeThlNEc1SFpVWHIwRGE3T1BrZWk5c0dvUEpFZlBT?=
 =?utf-8?B?OFRFQ296bjZzM3BNcDYyUytlZ0tYZjYzdTUxb09UUDVZOWwzbUsrZENoNjNk?=
 =?utf-8?B?aTM2TVB2MUpxWENnTm0ydHFaayt1Zmw1b1RSOU85T29JR1hHMllhbTQ0Y0Nl?=
 =?utf-8?B?Q2lLSE5qbzhKOHlFOWc2UFJzRENUUCtuOElDTXo1Y3llK241L1g1dE1CV1Q5?=
 =?utf-8?B?RnV4N3VIanN3cWxiMkpucjlKd3pqNlJVY1BOdjdWUGYxT3pzbFRBdDJ5UWl4?=
 =?utf-8?B?SStGdjlFci91SmZ1NUJDajc1UTNOYXZ1Rkp3THRGMS9CNndyTXlPajRYdlFO?=
 =?utf-8?B?Q0MzNzE0NlB3RnhYQTNUL045b3kzdzM4YjNsYzh1cVJRRG1pQkpyQlVIcEhU?=
 =?utf-8?B?RzFGL2RpMDRQMnBXbE1BcWN1UU80ZjExa0dXTEpQRExOQlVEdmtCb0xqc1hQ?=
 =?utf-8?B?a2UzcnBkb0xodmlGMG5iUG1mTnJmRktSc3R5aUdCUGpVblA3TFlyeExtSVZH?=
 =?utf-8?B?R1k1N0w4UUtkck1jaVBTZDluVzcrM0RtbXEydjA1ekxycERXQlN4Z0JaNTlv?=
 =?utf-8?B?YXNrV2R5Z1pSMW1ZT2lWOE92SjJSSlVBOHFGQWRhb0o0Q1RIS2ZXRGlVUmQ2?=
 =?utf-8?B?RzRvTzErT0haeGk4dXVXZHErYW1BckZIZlIxRzBIMWVLaE1DT0pGRUtGNDZI?=
 =?utf-8?B?aDVDT0lGUFBSL01pSXRWbERwVmwwZkpHNnN3VTVTZmNRblY4UFBHVUsvMml4?=
 =?utf-8?B?djg5c1FpK0tJRmh0WlVUa1NHZVlrNU5SVTJyajNYbVZyUTJscnhvdTJnRWlV?=
 =?utf-8?B?cWtmTHpQVVVJY2c5ckhyU3dzVHgzc1ZWcWNTSFZBTUtmUExYbVhyMFVZd0th?=
 =?utf-8?B?aFJxR0Q1WVptTWllQlhkdUJ3S3BkWkw4cXFQQjJ4andDWEMrNXAzTi9VMXU2?=
 =?utf-8?B?ZnVBd0VERFZZR3E4Wm1OT0s1MTBaaURuV0Q5MmVrWFdkZ3U3K1kxN1JBb2cx?=
 =?utf-8?B?QU1wOFV4cUdaZ2JjTTBxVHREbkp1RG5HZkp2eGtuUk1wVEpkdDFidFJtN1Qx?=
 =?utf-8?B?T2NiejRlcnIwV1pvRFJkeGowOGdTMEZpWVRESUo2Sm1IRWplb2x3ZmVzdi9k?=
 =?utf-8?B?b1NjcWd0YytHVHZ5RkY2bUZCaXBqVVUyNmMveTNRSTBaQkxSYzBZSW5PR2I0?=
 =?utf-8?B?WEQ4bEtJVjRxb1FZWUlYR05LSmpjSk50Q1p6akpaOTRGTTNmUWg4eTZMSmwy?=
 =?utf-8?B?aGVhSS8vVlI2alFWTmRGd3M0eXFVQUtmR3dzUkozTVg5cHh1RFEvUEV1UHlV?=
 =?utf-8?B?UmRXUk1KZDQ1ZTJGS0RJcldmVDdlU0Y4MnFPdTd4YjUzWXZoVnF1ZHVncFhZ?=
 =?utf-8?B?enRtNzFKWkpMZjBMM0VmZmVPTmRacndnWGIveHJjMHNuL1VWL05nc1grZW10?=
 =?utf-8?B?citmRmdLNGFWYnVMZzZzU2hJTFFMNDgvSlFWeDZSTkJKWHREaDZQQTlUeW82?=
 =?utf-8?B?S2lhME5zZkJsZjEvTlYvN0xjOGZhek5sQ1NWQVpQeG0xWlpZbk40UGgwbFJE?=
 =?utf-8?B?VlNZbk5lbjNmN016RVBoOU1lOSszYXFSdnZxNmppRDk0NmsxWFoweWFsK1BY?=
 =?utf-8?B?S2xEMDFxaXZWRVVlL0dZZmNqSFVqcDlNV0NpQ3VEUVpaQUk1RzRCWS92Mlk2?=
 =?utf-8?B?UWVyMWFISys2citxaHhKSjQ1eWRiSkZYWG1pQ2pJZm0rcXkvTzhwaVE2TmI0?=
 =?utf-8?B?cjFVQ0VlYVdvY05reDE0a0VxbTBlWnhWOHIxZk9UNUcvY2FFY2JDWVBySTky?=
 =?utf-8?B?cmxrK2VoaWt6UmJmVHNpVDFtV0RRZXpwYkZMbkdyTWk0SzVDZFpEV3ZwQ0sy?=
 =?utf-8?B?QitNYm5zRmlrNWZSYTJqTFRndzBDTUxlTmZ0QjllNDhMTGVFQjB6WG81VEJi?=
 =?utf-8?B?TEtZQlZrMW5rVVg0eGhFamVGZVNUb1d3SVRqZktNb04wQUNZWTUzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2294ed-e089-4842-56a5-08dedb87a9ac
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:54:44.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzduvQkXSVyHuXbbpp2dNX6KNuloko+/aRqIhiEuHBMM20q0WGDsyD9Bk+QSCZ2YhHOR9RIai3vLOrgk1/MXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

On 2026-07-01 04:14, Zhu Lingshan wrote:
> Function kfd_process_free_id() should skip over
> the primary kfd process because its context id
> is fixed assigned, not allocated through the ida table.
> This function should only work on secondary contexts.
>
> Fixes: fac682a1d1af ("amdkfd: identify a secondary kfd process by its id")
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e701dcda8ec..d0c083e018b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -931,7 +931,7 @@ static void kfd_process_free_id(struct kfd_process *process)
>   {
>   	struct kfd_process *primary_process;
>   
> -	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
>   		return;
>   
>   	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
