Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA24CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C5F61057
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85C5F61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019AB892FD;
	Tue, 19 Oct 2021 18:08:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F044A89259
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvE3TBqfWGw54jYu9V5fUzYwbvds8w68Z+WLlmuPqxQ5fokpH03Sdl9kUpaBqLk5fiyuklfrY+VGgHSdJg6FZFkNFI4s8Au/YLY/7ZB45gnTcwzMKC9hEvUW7tIOCl/vhrqQhrAMMhVDkzIpApwhNnoNQSqKIPDur0N6IL7BOBeuaUD9wiLh5VRC9uQ6fIsoe4uyEvA9sSmyVw2A9zWHC+77i4ZM2aVb216YFsVU4zEr/fS7qFZJE18k9ZDgAXNjrzOJGr3W0S8Rm9+47qOijTATJm1aUQ0lw84tQGx6bVbl2UxvQn7pXAcRzbIDrEB//8VyKfP3/gscQFbAW1/dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oW7aM1dczWBZT3EgZHU6PawIvIaOmzSpZFGZdiey6I=;
 b=JVKUIM7haztQHDdCN5zEkhN4tDaHt82pId/qURCSeEQWieXXhu213QOjNb1/37YKK4T4DyrhjIgXbzS18pOHRO4U9f7xqrQec7Onao6cNSM/JiOrWxwU5z6KSY/xBRBQyniw0z5aWTFnNMLSzmyspQxSvtkHdILJBztys9Czx5Opso232W1cK8fses/yyz/GXKPmGD1wAuczGZJhXm4xFQdoO4QkmHMAIAeYrjUR+4KFAfH0WekKc986XJSFto7ahNvucRWYVePEmkANnXY6osBJBp7YESMI9/m//T0OnhwBVaouXfSd49B9IdQMgGoyVRVppvm1xhiO16FAnsI/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oW7aM1dczWBZT3EgZHU6PawIvIaOmzSpZFGZdiey6I=;
 b=ft8yWbFjOi0QC8ky0P4ofKqF0q4ThXMk7sJOI95lfJInWPA9OAm9OHFvB3EPVhrYYF0iUdo6aAgdcfa5ov282ssGLkaJMFBiAfNPwy0M6RvtxR5QmJX7MsJNrIRSNlcto9uye+G+ambyiPBjwKWkp1HtIxU+2gyqSwt5qgmjJ1I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:08:35 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:08:35 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c51879d3-5434-d8c1-aab2-471ed1ab6931@amd.com>
Date: Tue, 19 Oct 2021 14:08:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019175050.934527-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 18:08:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbbe75a9-6a82-4ce8-5794-08d9932b7788
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4636B94D98877D1A169D336392BD9@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzXJ+wFRMw3Na6Pz9VmFg9dFPWOqFCMsLvlMbDVtuxqetfNUNFc4WAMA4pl5iPNp0uSNP9241PgO1tVibdcOLg+/gdQsc8QUMMGp/u3GAf8I97XaYUP7iaQDwJEkYIi6EqDFB+IW+Bs7Z681TvpvaNSuMyJvCtbmij97vmwqFflXDrstnYH8MU3FSwNBJxpBVl2Chev8m+5sOuhAGz911QaXTwHO3kIjemENUfjmFQz4riyktw38DmR6qolnGOt9uUoNDc4O7ACJHO0emqFZyTREpscnF7Em3z6BDY8bwUkLh6w8Knq6hdJvMoR9S/C2wqZ4dQtzjQDG8tmxbQphcAA0kagjaHOr9iTJPh4JOj7G0A7yca0hYsG4b6az5Z+JopAqhhzSyVVasJxW0rVE+S2vYPL1fp3nDnNF3ah7ATmVm5ww2+7EEkYqEpzHcdtYZjBWw18Vab2g1KOOCD6mhWjhSQ/HXcp+fE02KNXyYyxn62yH72m6fLRlqC6GpaDbzumdM/OnLowM/7fIPKUV+3gXYK7MD67o/SiNEQvq/S2uzGEGM29nfbfKrfBQzamHZNEPPoTXIoZLI+5uo7zIktPoowV7A2FFtlRGej6YCJ0XJLmfv4Ef9BhXarswhiIjTEL98zkD3EmE3UMElqTv9tLwwR5s9c3Y2F6maOPH0JCWbzI/g0cN4mQ6/WuYa2nIdoWu53e7zJ7y7ZJZ0MQifx7UtPtHhq6KbiNCfqroP3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(66946007)(36756003)(2616005)(956004)(86362001)(26005)(508600001)(44832011)(186003)(54906003)(38100700002)(8676002)(5660300002)(6486002)(4326008)(316002)(83380400001)(8936002)(16576012)(31696002)(2906002)(4001150100001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRRcjNLRjZIVm8yVWJQQkQyWEt0STZtUFFhVEZ4UUlKckpXZGhnZzJHUTVi?=
 =?utf-8?B?aTNVOE9KQWJ4Uit2MDVoLzN4cm9LcnJlcHVJNjZldE14S2tIY1p3aFNWZVNE?=
 =?utf-8?B?Y04wb21uR1BCOXVmbmx6VHRmMTJsNFpmUGJVa2FiK09DUmxFQmlUTFdCSnR5?=
 =?utf-8?B?YWlwaGlUME1rejVSK3UvcFpCL0daQ1puejVabEhHU3ozelZHUjJ4OXV1aVhx?=
 =?utf-8?B?SjRlUFRmaGdVMmNIejlxY0pDY1QxNUd6SDhJTDIvcTdWSzRtTHkzSkdoNVJ1?=
 =?utf-8?B?ZC9PVVFsV2xKc0IxUUpFYm5DamJJcjhqVDF4RHhFSHlPN1hRRGJGbjBscHQz?=
 =?utf-8?B?RWxuWXdqYThCQ1BPNlFRME1kYW5BV2kyY1h6bURYVmpEZkRzTW12MTN1Snls?=
 =?utf-8?B?YzVFTFNzZGlRUVJERGNOY1BNRWpYd21Tdk5RRytUL3d5cFh0ZXN1dVN6OUk2?=
 =?utf-8?B?empQTzZsS3BOd2wzT1FZa0VBclVBbzM1UVBjU1dnY09nZjRNZVd0d1hKQmk1?=
 =?utf-8?B?dlptUUV4WkF4a2twSnl4VGtZK3Q4UTROZVVORlVVYTd4V2hkT25zWkw5OVN1?=
 =?utf-8?B?eUluY3BiVXp5c3g2MHBwZ3hWYjhGSWtoVVk1N0JCR25YNmtQRUJoRE1DS21V?=
 =?utf-8?B?Z0JGL3ZyaS9ralJFNE9WeWpCaG8yYVZjTjViWjZpeGxSYVN3V3lqK25KUEJM?=
 =?utf-8?B?NEd2SThHaW1VSFF4bkpBT3B0VDNSVEJhU1ZnY1Z6K2NnVHoxbTcydzM5OWJQ?=
 =?utf-8?B?QU1MVXVqazNxcWdaSDdhd0FYc2d5SHNzTjZiZkV3OEZSaWh1UXhkUnJsbkZZ?=
 =?utf-8?B?MHczUWQyNWhja0tlMmxhVHU2NTJDVFZuY2NrUm1pYmZnYUlpZEhOcjNva2pH?=
 =?utf-8?B?SHNvcTZPa2dETGRHNENMb1JmWkFlekZQR245cmVlRVpDTVB4VWg1aGdiRUI2?=
 =?utf-8?B?WlBFRXY4T0JWMFJCYk1nKy9kRUFKVmd0b0orYXdkcE0wZmIzTEJaSWlNYUs3?=
 =?utf-8?B?Q0xFU1ZOTHd2U2RZc25QeDBCeEFVOVhpSGlkcHlBZHFpNWNScmw5NWt3cG5t?=
 =?utf-8?B?d2lRN0FtVVNLRVpoTm9TdVhMa2h4QWV0eGhUM3AySVg4RjNKQjA4QWtScStH?=
 =?utf-8?B?bFlOTFFJN3paUnU1eUpVUDI0S202bzdtbm81ay9qUUQ4QjZBbm5RSSs2dm5h?=
 =?utf-8?B?VUl5UFFaUWFsQ3JNMDl3MkhCdDZpS1pWT2FjQUszYzZFQjJPaDRtaWtPeTJu?=
 =?utf-8?B?cEFLV3I3eWk2TGx3bTI0d1ZRUXFIeDhVVEh0WXJheXd4bWZEMlRwQmdqeHFJ?=
 =?utf-8?B?RjlnbnJvVXZINllsVDdLUjBRMExlNU44eTcwekdqQTU2Qml6K0tVZ3B5MFl3?=
 =?utf-8?B?NEMwRVR3VUZZcnQrZ0x6ZTZwSnVRNHdKUkY5VjhEZ2t5NjBsUE1kSWJtK3Y4?=
 =?utf-8?B?L1V3S3R3LzZYWDhGTncyNmtsMlhpU3N1WnZ0eFJaTCtYYTFsTnpBMDdxNzJ6?=
 =?utf-8?B?dXhpaWVwVEt3SW03bXUyeHMrMVVrcWtObVlHRkNtVnJSMzVwUklpUENmTEpL?=
 =?utf-8?B?WmtPUDY1eGdUYkRGTUxHN3QyYnE2K3dIYTNSc1FiNW9IeEVJdG9qbHI0Tnhm?=
 =?utf-8?B?SHBIZkJMUm91QVBOblY2RUZzdW5TaW1SdXNuQUFRRGRMdzNXU2drd0QyNjhu?=
 =?utf-8?B?RFJHUVRjVjBtaTUvVDN1aCtXbmxrODZXVDJRVmNZQ1gzQXovRDVzK2FhQmhk?=
 =?utf-8?B?eDBhTmkxRUFjTnhvcWVWTG93NVVPVkw5V3ZySjVwcWNkcXZtenovakpHMExC?=
 =?utf-8?B?QnRSSmlqZU00LzdsVTl4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbe75a9-6a82-4ce8-5794-08d9932b7788
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:08:34.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okDV/qzqcTQa8zNLIPCJf+EHRac5Bjotro51EWgQGphMB3p7ZlAr2JX6vB0J2xDBvUouEMNnJv4d2x6MXleFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
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

Am 2021-10-19 um 1:50 p.m. schrieb Kent Russell:
> Currently dmesg doesn't warn when the number of bad pages approaches the
> threshold for page retirement. WARN when the number of bad pages
> is at 90% or greater for easier checks and planning, instead of waiting
> until the GPU is full of bad pages
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 98732518543e..8270aad23a06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1077,6 +1077,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  		if (res)
>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>  				  res);
> +
> +		/* threshold = -1 is automatic, threshold = 0 means that page
> +		 * retirement is disabled.
> +		 */
> +		if (amdgpu_bad_page_threshold > 0 &&
> +		    control->ras_num_recs >= 0 &&
> +		    control->ras_num_recs >= (amdgpu_bad_page_threshold * 9 / 10))
> +			DRM_WARN("RAS records:%u approaching threshold:%d",
> +					control->ras_num_recs,
> +					amdgpu_bad_page_threshold);

This won't work for the default setting amdgpu_bad_page_threshold=-1.
For this case, you'd have to take the threshold from
ras->bad_page_cnt_threshold.

Regards,
   Felix


>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>  		   amdgpu_bad_page_threshold != 0) {
>  		res = __verify_ras_table_checksum(control);
