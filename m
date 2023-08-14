Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253E9EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 09:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B16F10E17A;
	Mon, 14 Aug 2023 09:31:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE57610E17A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 09:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAxPzzJhdIF0e7bmrmD9UETimINHdMSIDEzlP79YiR9e+lPKcgX813P+qwEkbtO8KtTgGopS9v6ZPYWhcZDvgCEj+t9IPvaARMM8Mt7NnfzoQFH5e4XxylmddDsOSUbcj9TWIXeCVV25ZtwzIttDwuA26Xr6SkyijtjPtiEitOMH/5xhxYKizyqEJKkG7r5Yg0HPHZtAstYEKr+M+5QIohq/gQ0Wo1NiRxBq5QBscdZOKFJAzx9RpqbqrgALBBU6S2oUjd2l446abGaqBaR8u1V1tGriAF7x0cAchvMjlg/YhPgdORu3Bb7Zw2ExNXJxElCtUj26yll534ig7HuRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tCC6XRdbMR4jvvqKPZTe9n8gsBVyIoCb+YJEtfG+A0=;
 b=Zxz2M8u9GTlH8h3w52Zc8BkTN8E+xLQparo8sxCSh5BESPEGChDiIh3z66yrLWqOam1X7pxTldSPcU2BN7znPMqkQLeIO/nPhYswtN+COJveBKxtj2O4QxnGYmaRmZDTcE4ig6/AcqDQGRUfEhMafKKDSIIMKrN8l0JCMKHhorwB9S28hqCVLI/q6kmHR3MoO3FkbR8HtQdYPihouPMTjE+xXT8LvpznW1RXlDkx8KOyYQL7bq4toIZ++lJepQJFtyXYOW9qpd8g0jSKYNOxjJrcH8p7OxsrjjzwqRvZd2wWU6FJ1KX0qbtA87OUS566SWu4UZQxMvSei0acowsAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tCC6XRdbMR4jvvqKPZTe9n8gsBVyIoCb+YJEtfG+A0=;
 b=VFoEXix27PN9MNUm90x84IfKf2QOGITBHEaAf6MC0iBld79ZDLlnXAYuu7AUFMmK9IQiaHCAJaJhq3ALZjtY1uqpsoUPcFGjQsw2H/0CfNPPsBLncvVBzfTJJTWFiOev3GJiy7ClMqDDldIw2Y9RmKP1NWSPt5jtgVBRMDr9yUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 09:31:20 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 09:31:19 +0000
Message-ID: <e441ef2a-eacb-4618-b67f-8998250d020c@amd.com>
Date: Mon, 14 Aug 2023 15:01:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace ternary operator with min() in
 'amdgpu_iomem_read'
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230812144724.468189-1-srinivasan.shanmugam@amd.com>
 <750a0b2e-7a53-a572-549e-87426d04ab1b@amd.com>
Content-Language: en-GB
From: "SHANMUGAM, SRINIVASAN" <srishanm@amd.com>
In-Reply-To: <750a0b2e-7a53-a572-549e-87426d04ab1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: c04e16de-3703-46a3-dbf0-08db9ca93751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atlYQzR0PgbcY3OvGhWQj8v0/Ush+Hi05752SFBjFvKzEQgHUTR6HwAAf7bJr6ZUyhgXXI58UITt2y5NenOvwid/hGRZOCVAq090lphqNhHEyG31Nw95y+iazRoOOmY5LJE1Zc38NXgTBwuUyKVR5zHQcTMDvunYbkxANGUbXglba24pDttVNEN5cW4h8GiU5lFzRHVA9hNlRziYb9CQWe/kDX+UmTjfIxDwjHQt6Q4lqGffPd4RGgtfK3RjWlhJQ18ck9IPIg0Me8Sfvz+rMDn6lnQEFcSuv/Ye1y9RYuQ3LyLfsRU0TRG6NCbxdd/G4nXehGn8ro7vym/hxc+Q4xZgxny6FEmqIU+bJZocR10qA3GdWcTrf15uZBkME/wo+3iSuQMmNFNpagURDOs2JESnGppaiPFBpCaBK4ZNOU/pAZP3+bKd6RjyDH5ThV9fM+quWnkJX1syjGEdwcQW7OgC5XWXU94V45SMZEaEaJZLpstBt/3eR3y3gDoMfdO3VrDL5QN0LRH8EDK67Rn4WaCKWNF4IFpSJ/A6EQ3gxvhG+8ScdRFR5owtr8sG6t1xL71oj6NIqbNCqBT4yaDUXD/wWTAyUVuq+dTWbHhgaRPRk3bLizCmV2GVWaqjyqYO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(186006)(1800799006)(451199021)(478600001)(966005)(6666004)(8676002)(8936002)(4326008)(66556008)(6636002)(316002)(41300700001)(110136005)(38100700002)(66476007)(66946007)(83380400001)(66574015)(6512007)(6486002)(6506007)(53546011)(26005)(2616005)(2906002)(31696002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG14VW1aQm55eHBWRkl0U2JNZ2RpQWE3K3VFc1paZU5RdjBzN1Q2YUVGd3FQ?=
 =?utf-8?B?emlOUTVTMndRbDhTK1pMQ25QRkFodExJWVU3QUFZdDFMTExnTll0SWdxUTZn?=
 =?utf-8?B?YjRXaEZEekZBTlJKYmFmNGdZWGgzYlg0N0I4RXpnb2xycWR2c0ZJVXZJTlpR?=
 =?utf-8?B?czY4RTRpa1A4VDVHbDkrMytrZWM0OUtDbnU0YTF1VUpxWDI5OXNIeGxHQTBW?=
 =?utf-8?B?b1BxQ3A2RHREbEFqTUlMV1BLcWdSWElOS3c4a0JaaDh6Nm1JcmZLQkhiSGZl?=
 =?utf-8?B?cm5nTDRVQ3V6QTE3bjN1MzBlZ0FXUENob0hkWHV2TFlnWlVXQ0NMSXVBQTJ0?=
 =?utf-8?B?akhJT01TT2MxL1NVMi81aVJjN3RSR1BTTFN6dExLdSsxbnQ0ZlZPdVdJTWFz?=
 =?utf-8?B?TXhCdlU1WUNscklaMkhUaVZsQWN4RFU5cXk5ZURkWUhRYUtJT2k0ZUxHbmdJ?=
 =?utf-8?B?MUgxMFFRRkxYRWJBUWlnSkgvdkJCbjZDMjI4QXZxZGFhMFFoZ0NxWUszd1Rt?=
 =?utf-8?B?b051ajB0b1ArMDZWWmdvdEVVZ1hqc3JjdzV2YVQvV244MEZXeThUZkx0Nkd6?=
 =?utf-8?B?dVpXY2pLL3JaWmNmKzVxcDA5eE0wcnUxSWdqc21YaW5RMFRRNjFvQUV1b0gz?=
 =?utf-8?B?N2RXdnVtSmlrYklEWURxVnlVZFhJYWNBUUVwQllrTURsT1JYQWxZeDAzcXlC?=
 =?utf-8?B?MFUrTk0wUFJhMm9uUkpldHZRaVZMRVY4ZVF2WFlKVmQ1U2FFRmlhcmNCT1Jk?=
 =?utf-8?B?QnVpL0RqZC95QXgzbEdnQzdyWG5ta1JUQ21HY0s5UmVoWDYwVHpOY3VoNG1N?=
 =?utf-8?B?ck9RRFUvQk4vMjltL0ZQRmxlMzZITlBQR0RFNU5DMElXZHVvWVVQbWw1UUQ3?=
 =?utf-8?B?aU5qSTlFY3RNbHJaL01RS2wzRnUwUW5JNUM3UGZXazZHV2VMQWc3Q05kNitl?=
 =?utf-8?B?MG56MGhyY2lCS2J4NzI2Q3FNTWRwNUpzYTZDNGticHRyTHJwN1lGWFBacVhu?=
 =?utf-8?B?dG91L3U0Qk5CdEhkNjNUYmtPNGdxb3QrNGR0RGhuWDZrY1BRdFYrdVI0UDNW?=
 =?utf-8?B?cEljaThRdUVuU0VJc1dHV0pvQm1NM2lHdERGSlV3bmFIWFMvSlpLNzFvblRK?=
 =?utf-8?B?YVcwbWVPRU5kL2p0Wk5wblcweVBPNnQwendpMTVRVVJ0ZFJjN1BwU0Z5K1Iw?=
 =?utf-8?B?MjgrdlVTVjJoYkNmVjZEeW50MEtYSUhRSVN5eDdHdzkvNkM0SHNPeE91cGt5?=
 =?utf-8?B?d00wbUp3L1V2MkhUSUNZTXlRbHV5d0xOVHRQYjJZSG9ZdStKd0FyNzlHa2NM?=
 =?utf-8?B?cXdpSnEvZVZ6MHAzTTFSODR2NjFMb1BiTUo1bWhxUjZqRGJvVHVGdVJJRDBB?=
 =?utf-8?B?Tk9tTDRidmhsQStWbTJEWUZMb0xSUzFWNVYxeGJNeE1CN1JuS0dHaVhZMyt1?=
 =?utf-8?B?RHF5TGwwN2padVBROWd5SUNEcXo3Tklxb0tCU0wzRnRNOWdRTDgzdjZlaUN6?=
 =?utf-8?B?RTN3cGw5MmFMNFJsZGxPYnhQUjNnVWh6YThXSDFwZEhYRGI2N3gzanlvc3hZ?=
 =?utf-8?B?MGp4Y0plOFVTZm9QbG9NU0N3K3Z2MFNNTXIzRmZNVkhydUtuQkJ2YUlPbmxO?=
 =?utf-8?B?Y1pMTXdhbEpBY3NaVjVkN3BwNDZQWXdwS09PMEU3Z1FmRFg3UGV4TGlOZFJN?=
 =?utf-8?B?WkxicjhGR3l6ZFlCOVJ2ckMrUHBTN2VnSGNTcFpQZzlHd2pBNTJNTFZjZTJU?=
 =?utf-8?B?TUFMdkRNNjFXMi85RWVFQVUyVkdJbmZQYlVVZkZVQU1VcTZZU3JMbHlFRjg3?=
 =?utf-8?B?VElpS0IydkNRRml3ZU82TkRGSTZQU1IxdTNIUk93eFpTUlN1d0ZObWF1Nk5C?=
 =?utf-8?B?T0hNaGJmdG1hQ0NLcE1SbFZrdmdtalM3dnpzR0tUbVhLNFVTSExDS0JQbnN4?=
 =?utf-8?B?QzFCMHNidHNibVNReklPSXdncEdFc2RKRWJiWlFSOHJvNmNWVE1Jak5xbGQ4?=
 =?utf-8?B?dnpoanpERDFiU2hSc0dyY2hZRUNaRkpUVjc0NnZSN1pnb2IrM3Q3Mmw1WG9v?=
 =?utf-8?B?akhOYnBTK0U5YmdRaVJHQisvdDhxUWYzdlJuV0lGdkdjcWFTd1VKdGtFT0xo?=
 =?utf-8?Q?yRzs//cwjCdf8qEyCneQPNtCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04e16de-3703-46a3-dbf0-08db9ca93751
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 09:31:19.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWOtkdgTN1/NNWVV9IkQK8qDc0ou/oqbpzATIRqDCQnFC0iRMRO6YXZq3y1Nrb/u9UXQg374lLkU97BtEtR6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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


On 8/14/2023 2:45 PM, Christian König wrote:
> Am 12.08.23 um 16:47 schrieb Srinivasan Shanmugam:
>> Fixes the following coccicheck:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2427:16-17: WARNING 
>> opportunity for min()
>>
>> min() macro is defined in include/linux/minmax.h. It avoids multiple
>> evaluations of the arguments when non-constant and performs strict
>> type-checking.
>>
>> Cc: Guchun Chen <guchun.chen@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> Please double check that we don't need min_t() here.

Thanks a lot Christian for your reviews! Highly appreciate for your help!

min_t() is needed if there is any explict typecasting for any of the 
variables passed to min() please.

For ex: some references pls:

1.

commit 3434392da74953727f6c27bcf24aa7d8ae789c80
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date:   Sun Jul 23 12:29:14 2023 +0530

     drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

2.

https://patchwork.kernel.org/project/linux-omap/patch/1307877290-26672-1-git-send-email-tlinder@codeaurora.org/#1917462

Best regards,

Srini

>
> With that done this patch and the _write variant are Reviewed-by: 
> Christian König <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index df32785a8b36..c03fe7ee555b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2424,7 +2424,7 @@ static ssize_t amdgpu_iomem_read(struct file 
>> *f, char __user *buf,
>>           struct page *p;
>>           void *ptr;
>>   -        bytes = bytes < size ? bytes : size;
>> +        bytes = min(bytes, size);
>>             /* Translate the bus address to a physical address. If
>>            * the domain is NULL it means there is no IOMMU active
>
