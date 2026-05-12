Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F4CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40B610E4EE;
	Tue, 12 May 2026 15:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="33DoBOwJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDCE10E4EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD32hIvXDwINqUxf5Aurgk0Pid8GZYpSQr4sY3B7i6/bcyxWyI88+u4szWiiZcAii8CIbz+Daw9hxmbTjc6G7htv0i740ug6zufY9OcFMlJ0BJQTvm4mEngo2tfJeX0SG0US/dO5leV24yCYWFu2wM7IIEf7AaDclfiuyUyvAQ8+m+KJhZVSptYQza7FBeM1jPMOasYldLOopGRAsDLGuN9Nbm4YSuVhG5EJOU0K3Ax86Af9hjV3yOf1MR/mewbkVMxAhwCFVdZ89xnQ1IzJFT5xCOlJFWVCaItN4mBMYTWWm37+FuTYj9loSCgW4TuGpLy0E7HT08m+ndrc0sQg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB9FeyE12a/q4Ia5fg9cyBpu9ILJUz9dnYqVLTsL1eY=;
 b=P/eZDoVNjE/UMdAJlsdn8yrjNLo8Wssu15dwFYjaAEs05o3ANw6zn8GorBhPW3A+066JU5dRXM5WKdz+ByKLgoi4JUYXB/NaLbB12Wz3BpVpeYx9+yBEOxuEBJcWRNS5012PmHnY/nPTS2s2KKCBGI3l0Hu1lKtprnipuB2eZio3RukGaJ7liR5KebSnMxjd8iPsgVUqHSSmsxTCV6DdEnsnQUELsohbTf8uXI3jZ1gkLzR/8bsuFX1taL+SaV1SKETWPFmTnjaAFrqRQG1bELiy70ewk/durKr7plijmI9OyvI/NxSgCqgrGlr+7tPsUWksPwbwNqRJawjStjQIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB9FeyE12a/q4Ia5fg9cyBpu9ILJUz9dnYqVLTsL1eY=;
 b=33DoBOwJI699fvtH46JeDMykIcL3c6+fqPN2zfm43pBN9l2v8lmE1FtgYYhgm6vKaajcNREiMbIX6ZK31fbsDHePiZrr1R/QE7cOYi+TuHvEXs+s0oKWRv7Xs0TKhboYKXK0x3uT3Scj0Q0fTv5MqrQJdzpDyRTNNEhQqsaTDJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:09:36 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:09:36 +0000
Message-ID: <c842f2ad-c4f6-4d99-8db6-b98a767140d5@amd.com>
Date: Tue, 12 May 2026 11:09:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260507200408.208219-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260507200408.208219-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::7) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 892b68bd-e464-4b99-1ae2-08deb0387ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: nmHKuwxGskwnaSehx1BcTeWaoqtEq75p3IgzthS+6bxBweKUREDJamQnylKfNrCJLNJ6tqkk+Ti0NypJevsAG6W+5y9eZq1MMbVUGg0sgpgWTvp3+voAMMeff/VhxS8TK+jEEPmR5+4Ywuimnv05n3xrKouSLd5qzTRvw5fnMLHvkef+Z782vwATx8NHTAyED2YkgDaV4mbO63MorJ5Cw1zR+Sof5hXb6WwjzcxuSF2X+vhgVyIKg1jB3edBh3oy1BcxrdwTvFmyu23xOgfdSp1/Flpo/QuwzIX5zGP9zWUmRM8Wfw/pSiXHpXIcWotgoV6QcHisMUPZZw0RBKUMQ7vAC8dXvXnynHQBNJIcijWXrZDBp217Od4GuL3zUVEswht2uR/DBr9kV3RELCnr8tteUPsEP5hd6u3AOBZVHeyORAlz7JYPBqDB3ZEihFSpwqEOk2nRTM42/o4MMO4yCfkF1aTk5yZkR7a6RDbkP3e1tLva2NwqK0/sWPTBqm9Lg4fDttHHPxyYTz1Twfh205G9P6ClXDt02flIFt+zAc/suzgbVLrXsPswxFTWfD5/CT0y4CJ8lzSGWf3+75eYHuCqSnoTOi38qCsBEcd80r5xFtyL8k3pLOhN+knrG+9HvsDsBxLF2zwhoZy068n6e67mJqMYYIuwkIqKLyZkK5el34il4GURzIabmclH29r/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1paSlZMMU90dU5pZVJBRjFtaU5VVll0L0lsV25ZUVFvYjVxbm9xR3JyOWVu?=
 =?utf-8?B?Y2tiYVJMMm5CZjAyTDlZUStSRGQ4T1FENGZ4M3AvRDRTMnVLZzMvT2xnVkhU?=
 =?utf-8?B?SklNR1RiNXgxK0czM2JYQlVVWGJHM1h1Q1ZRTzZjWnVCVzdwa2crQS9USktp?=
 =?utf-8?B?SUdVdnZVejJWd29LZlQxTStuTjZUbW42RGhmdmx6dkFFQ2xiMXdtYzZXUXhq?=
 =?utf-8?B?Rk9neE03T3hDYUZKZ1NZZlpXVHdkaGJBREZnTDBGd1lkRjYxVFRUa3VaSDJY?=
 =?utf-8?B?TDZqcXkyNFFqUytNSWN6QnZLWGlaSnhadFlZM3lYQjlIUmRwT0h1NTQ0Qmt0?=
 =?utf-8?B?dWk5ZW9raDBDSWZtYmtyT1ZMSnYxYTNMeWYvR2s1Y1NteVpheWFvSHZRMTRk?=
 =?utf-8?B?TjlXSjhGeXZ1ZnpRb0xzblVIMkEzbmQ1VEU5cCtUTUw1a3AxcmJNSUtzNTFv?=
 =?utf-8?B?TENLZzNSNkxpMTVoYmY0dDdxTEZmbE5hQVp1TlhsdEtIbjUzMEZxVmcvdVZT?=
 =?utf-8?B?MnpFeU1Ea0lXWVEyM1FLbi9Dc0dZeng0YmlQVWczd2FQTCtoM2pLOFZaeDVo?=
 =?utf-8?B?OGRGQWkvb1kya0hCVkRTM05US1JKUzM5MjVuRDZibG1JZ2Z2UDFRQ3orV3F3?=
 =?utf-8?B?NUo3cWUyMlFQVFFCSG1tOFlhazEvalorOW5yTUV5Mnl4b3lIeFl3QzczN1E3?=
 =?utf-8?B?Tnkzbk1hQTRjckowTWVJK2hIenVTWHRrS2VLdVBQYVl0NS9WLzJ2ZDdsNUo4?=
 =?utf-8?B?R3gvQjVUaTA5dGdnUWs2NTRQRm5VK0I3SVArdXhtWkpLNWdXbkdJenRQZzRF?=
 =?utf-8?B?UTh2b2NWYXBpWkI0azZHUURNdlphSHhCTjUrL1A2REhLdk5RT0xHV1A1U1Jm?=
 =?utf-8?B?UXAzQkpYUEUxVm1rcmdhVHkzODF0Y2ZUa1h5Z3ZCVW1RVndIdjhzVjEvT0pj?=
 =?utf-8?B?VVptZ0N6T2NEVmNKcko0K05tRXlVM3Z6YlJXbzZ4cDh5NDVmNTllMS9xeTBX?=
 =?utf-8?B?N09Mekt1SEx6d1NCVWZaam1rcTFDcWw1RVYxY2pQdW5PZ215eXRPcERETk1a?=
 =?utf-8?B?VnNMLzd2eW1JenVxQktIc2pGMmZKc2RWSXdodGE0REJOQlltMWlHcGV1d2hi?=
 =?utf-8?B?SnJPTndXa2pOWVpLTktsN29XSkhGSmc1eFUxU2diT0VtMisrL2d2VmZCby8z?=
 =?utf-8?B?aUNpNWZZWFdXR0ZqVkhYQ2pCOGVpbXc2TEdLN2tNQmNEc2d6UFJuREFQWEwx?=
 =?utf-8?B?OVcwQ3V5a3RKanFHWXFnL1FORmk2NXd3ckFrQXBKNy9nOGNwY0E4ZzNQQjA4?=
 =?utf-8?B?dzA1RW5Xek0vNTRqbjFaTE5YejBiemJ0NjVHOE1QQ2tSSGQ3NnRhamZ3OWwz?=
 =?utf-8?B?bDFDc1JiK3RDWUIyWUdsWXhmREV0bVlFeXVmMlZqL0pLWUp6aklxOGtocXlR?=
 =?utf-8?B?RUtDZUU5eCsrOHdQWjNrTC9keUZZRElFWW1wb0hGcFVkdmpCcE1JRGg1QW9J?=
 =?utf-8?B?blJ5cGtEZXJSeUYzNWMxajAxNWhEMUpqcm96TUcyUkpkQmVsVi9VMnREUDIr?=
 =?utf-8?B?UjZOZlBkRE1BVzhTbnhzQjl3S3pHQzZpMEhqWjdoV1UxbjA4eU94UFQzTm5S?=
 =?utf-8?B?SHZzMFFZV1l5ZUxUa0lDTHZhUzBIRHVRcWwySzQrWlNsSUxpdlQ5SXErOEYw?=
 =?utf-8?B?K1E1K2Y0ajBlSVhOeS9IRGZMVjI1VXp6S3M2WENEMlNGTWtqbTQvUVY3c3Bs?=
 =?utf-8?B?Tm5NN3V2T3VMZ1I3bkR6ay9PQzVyOXRPb0F3amNIY1NlaC9FSHdKMkJWekU3?=
 =?utf-8?B?VGFlUFg0V2kweElibWR6eHRxbTQxYUhnK2pWZ2k4S0QyRDhreFV2RkxRRmcw?=
 =?utf-8?B?cW8xMlFNTy9LNGhKaGMxR3Y3WDZ1elM1S0NHRUxWcXk0cGNkVG5pOTQydUpo?=
 =?utf-8?B?TmRrVHp5QlFYTkQrVTZ5N29SRlNRbklBS3QvcC9YbFNEWDRyZ0IrSVNNeFpN?=
 =?utf-8?B?bFVMb1BpalpscHBKRW5aRG03b0lMZk90MTNxS1hTRmFpQWdTRStWaEpqcnF4?=
 =?utf-8?B?OE1QOUF1MUZZYlJLUzlTbzZqZU9RTy9VNDdTNGl1dnI0akxoMzBoSVdkQ1dm?=
 =?utf-8?B?blZxMFlreE8raCtVY1FHd2NpcEdjWmt4OWEwVEpFNU9JZjZRdm52b1JCOHdh?=
 =?utf-8?B?elNWWmk2dVZJcmdPbnE4YzZ4bExNeW11SnQ2LzVUeG9xS1NML1o4Q3lzeEt4?=
 =?utf-8?B?YkZQY3RidWZTbTU2RFBQVDc3YTBqd25KM3pUY2ZsSzM5Snkvc3JsRnZTS3RC?=
 =?utf-8?B?clJlWThFZmkwT3hQLy9VSWxLUjdZQnI5R2lCN2Y0V1U4REJKQktqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892b68bd-e464-4b99-1ae2-08deb0387ad7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:09:36.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNcaUIqExBIeCYKWk870o2fUU5PhTPWR/OVt1UnLjCsV2Cnb0GVofNwcTLHx3bRSEiEkD5djUJR47gFc2yGz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

Ping ...

On 2026-05-07 16:04, Eric Huang wrote:
> The process_info could be NULL if user doesn't call kfd_ioctl_acquire_vm
> before calling kfd_ioctl_svm.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 25b3ecf85f30..72cfb4a6ab3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3732,6 +3732,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	svms = &p->svms;
>   
> +	if (!process_info)
> +		return -EINVAL;
> +
>   	mutex_lock(&process_info->lock);
>   
>   	svm_range_list_lock_and_flush_work(svms, mm);

