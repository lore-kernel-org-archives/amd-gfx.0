Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BDC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C271F60FE7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C271F60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1DF6E817;
	Thu, 26 Aug 2021 12:12:18 +0000 (UTC)
X-Greylist: delayed 85041 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 12:12:17 UTC
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32B66E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmd/ciFFTAHXSQeoZgVmO58++XsCSHC6bdxaeFGvqrfeyGHnrsWh1xou6TaOpVkyTk91/PQ8awJy5/+5maLo0ToxqezUGcVbl3NcbLD+LsUUvqeSn/gY8WLimrfp4ZvyFE7gVnRVx1as3z5RCoBLpOip8eK2lDjoTusbl7QmazcolpYUdWJ87vrYxw/+LGVDfp2dn6knuAQfryrg8kkvfvKNDDPcYlGS9bMhTSZ73j47EkSYouX6VbTHclhynL46qRSwsy8UKVH2if9xXVB4gfXvh/lVruVo7D5Z0qbLB4saz1RlchXKFlmppNvx5klPYWEJZU7gs+Q600BNdX5udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUGCyTaTCfCkxfGJL7VIqlYtp+CbvTM3qCjNayl138M=;
 b=Noavth68+E/PUQmUGWswbsO435LjKoYsInV8BleCfVo0X44zu6crbdN6ZVSswYwpmS1n6rO32tDJVYKn08lS61R26I3KVhzcCOusVM/ZbAeaVq9hN09vyFIE3oY0kLVI0azA5H83cFZfwM2TfZd/41fXkN34baXsbDu+RUk7aas7CU/LzPBf2A5Vt0svxL9gMae5+6mILm49e2U3COBo6jUza3KBvdo689R3k/T4c1CjEPdKuP6LAriSdET4Xe+SGwO234EnvodJv9wMqAUoKzrsJKjPxxwO+pGHgS9j1o3pkN/yRuTb2mRecL9q92/TV/ADIqthC5nHGMvz9+NMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUGCyTaTCfCkxfGJL7VIqlYtp+CbvTM3qCjNayl138M=;
 b=BhlbC3Ysz5QX/GsLv1QVXSvw2y7kBH4Qrb4rc/bRDfV2rV3jDGW583CiiuoVZKxxn+QoPT8dpcF8kgo9i8FsM1FQDOHFyYI5EnILtTNCo8HPn/e2Krz7A6wdwXgPS2503lAJQ9Uxlf6Mv6WTvhKV0d+qzppndDPa9hTsyOmZ+DA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Thu, 26 Aug
 2021 12:12:15 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 12:12:15 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210825172659.247530-1-tom.stdenis@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
Date: Thu, 26 Aug 2021 17:42:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210825172659.247530-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 12:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef94943-136e-4465-3f30-08d9688abe13
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5237268E3FDA6E77F5AAE33C97C79@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvfZPjog29Gv/+qschm5frRIzjxFy152YZ1/jhNTuKkfOlIbiVLjw6Ar/wg8R/p9zYeWoJOhS2n3ooUVgXP6L9/9/jZMhKBqKXdBT6XMxBlzCwkgD2h/iVSqA/T0PoYuH+oE7/AJoy8Hd+6vKrkSbAUkgt22hRXhyjljHY9wxzKAsluDjAOZ2KWH9iXmL43hqVyNDMzwBCZiPSI5odQugrN+9H+3asUzxmhjXHlYJlxBrLnlZi2WockyNnn12k5nu+QGaPK3/8IB2agjUkRN9aWO2AAHpgmx8cvJJnVqnA3KuX/xlad4nvbCoH1gS6/hpdklLvKgab8AFkYtCtv7WNNaJ5gSYXalnWAPx19NUibHpn7yAuiNqi3KUg250yN29kLAc9YFEWBGh4cLak1lJlPxMRbKj176+mljQwV6Jtwki4YsCZjnOkl2dydC6nFuwf3xgGXwXEV/9CdMLLtt2zAylYY+7/bMzVHRZtNz8EB8eqkdKz/ndoWecT1/XjkorjRQcPNCTyLWAcJJu/GQBNOVYrUdl5votQvcyDPRHLNhGjHqqdibqaMjxXcgU6alrNaE4m8RhBS+uEj7vQFKtgRsm9nKBQPp9Uc8yAZMvdMueN1QyS/s5OF9R0EGzXrSWw3u9PMVob2A3ksgvlxEWGxOVTZHhZ10YyD3UA4yDcrol8zbznfATIQH9BYHkfww8S0qf6vOEkD4ER4H2L28Sp6ZDUOUFY3fXJtwQSdk3TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(31686004)(478600001)(956004)(5660300002)(66476007)(6666004)(26005)(36756003)(66556008)(2906002)(66946007)(2616005)(316002)(16576012)(6486002)(83380400001)(86362001)(8676002)(186003)(31696002)(38100700002)(53546011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkt1RFNGVjB2Wmt3cjR0Q0orUllrRGZlMll0Y3lEekMzOVBod0g1T2VuVnB3?=
 =?utf-8?B?TFpyK0lIcGR4YlpTaFZKUHB1U1VhMThLcVZJZ0E4cmNHOXcxSlFQZEl6TEdu?=
 =?utf-8?B?VzFsa2h3bDNMMHk4cHhXOHV5UGoyV1ZvQUpxdC9GakgvcjZEeWQycnRUYmV0?=
 =?utf-8?B?em9LMElFOVhWQWFZclpZZStjMW9jYU1IbVNwRjNETytOUTFGSW5sVncvQkY0?=
 =?utf-8?B?bXY3U0tkWUpPZjYzZlRXSXlscDBtbDV3THU3UWZoQnBqRVVmeUl3WlZnT29O?=
 =?utf-8?B?K1RodWdkME1pY0d1THBzenFwMDR5Mml4T0FUMWNwa0I2Z0ZRN3BVSkw2dms5?=
 =?utf-8?B?VXlJcU4xeEJxTHpyYS9LWThjVFJSbWtETFVLeE91YTJLajB3VmhpbEpJODcy?=
 =?utf-8?B?MUpHbFF6c2RrNE5INUErNHVGUG5oejlMdkZKRU9NRlQ2Ynd5bU5YK1UvYkU3?=
 =?utf-8?B?QmVxbm1rTUVvZmNSUDV6OTlENTBmVTRCOE52US9Kb0JlZVN2VUQyalVJeEs4?=
 =?utf-8?B?NktjWFpTSnYwcTNuUDc2eXdKSjZWREpubHBFNmhDbms1eiswMzJkUW84L0U4?=
 =?utf-8?B?RjFkNlEvOWd3U0Rxb2lzNGl3dnAvazJYdm1UcnRkcEVWdFpzUzkxNHZXUnRI?=
 =?utf-8?B?NGZYejU5U0pPc0swQXVLVTZiaTZXdnpsNWhDaWY1UXpLU3owTW5UeDk4UC9l?=
 =?utf-8?B?dmhjcnZndWpSSlgvVjRPaVRGRnlwWi8waFJsRmJLdGMrblNLZWtkdVJRUWli?=
 =?utf-8?B?QnVTVzEwa1cxRFJITlVFd2hzRGNBUW9BVW1mbDVFaVhQcUR5T2dhRHJNNjU3?=
 =?utf-8?B?VUdHUnhvblBETkQ0Z3F4VXd4OGhTbDROZzdIU3JaSVFuY2JlUHdTVjUwVGZ5?=
 =?utf-8?B?R1RlVzVHZFZoWE02V0dFc3BnZytic2c3U0J0MHVxV1habDNCODA1MTBhTW9o?=
 =?utf-8?B?T0dkcXhzSGJjRlE2UHg1aWF5dlZUbm5KOWx3U3UvT1p0d2pzOGdSSk1DMG5N?=
 =?utf-8?B?NmQwYVFGWVkyREVrTTNPcTgyWW9FcktxSUdpeFNVOGVySlIyc3RZcm9GUVRO?=
 =?utf-8?B?R3g1Mk1lNXBkUUFSZVVjY0VHS1pXOUJURGVtQjNSVDhWdlZjM2xBcVlFbi9M?=
 =?utf-8?B?a2pLMWREQytBN09zYmdkMzJEbFhLWjNVT3Uvb2xGRWRHTVI3SEJ2Y2NNRlB3?=
 =?utf-8?B?U29vWUVSelpyMkwvQ0lsQjJtckZPZnBqUXdvMUkxUWVQaVJqT0J1RmtiTTJP?=
 =?utf-8?B?NksvZDhyWUxHbnlwaWNHS2R5a3R4eDJYK3lLbXF3TFJ6c3dDS1JmNGlEai83?=
 =?utf-8?B?ZzBnQ1NwMVUvZGNBYmsxYkQ0QkUvZVBueFhuaDVrOVVRT2FVU1F1MWpTaFhN?=
 =?utf-8?B?NW5LRUt5MnhZaVlkekc2R2dIWWVjMnlnQlNxd2h4Z2NJSml1Uko3bUZobTJC?=
 =?utf-8?B?dGFDUHNWckplN2dKY2FlMzA2c1I1UmxOcUN3K2JOaXZZRDk0eDRSeDd4ZW5K?=
 =?utf-8?B?Nm1OSjREajRURElrTm9vbWVjVGNzZUdPY1MyWmFtMnlEVDQ3NEQ5UjEvTXNR?=
 =?utf-8?B?SXhwZ2hBS0szQ3VJVE1zdDNRSmRmQmVtZVVIWFpJNi8zeEVOK3gvOUlHeDM2?=
 =?utf-8?B?YlBTamNsd1NPSXR6TUc1N2JZTWZkcmV4cmh6eSt4NnlJOVBzRms2RWhRdlB0?=
 =?utf-8?B?dWdpVTFxT1h0Wkw4MFAwK1NvNkFORmlXTERLNk1yQ1d1VnhYMUJBdEs1cVdJ?=
 =?utf-8?Q?DSQe/sFKzJo/T01+N+WJBEZM/KJW1on5o3WW47T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef94943-136e-4465-3f30-08d9688abe13
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:12:15.4797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxPg8iHILZaA28vjawKjp7H4NKwmYpn+YHK1kuUOg0Qf1cdohQNP7gNMzQPHnfMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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



On 8/25/2021 10:56 PM, Tom St Denis wrote:
> This new debugfs interface uses an IOCTL interface in order to pass
> along state information like SRBM and GRBM bank switching.  This
> new interface also allows a full 32-bit MMIO address range which
> the previous didn't.  With this new design we have room to grow
> the flexibility of the file as need be.
> 
> (v2): Move read/write to .read/.write, fix style, add comment
>        for IOCTL data structure
> 
> (v3): C style comments
> 
> (v4): use u32 in struct and remove offset variable
> 
> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>        instead of 0x3FF, use mutex for op/ioctl.
> 
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>   3 files changed, 201 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..87766fef0b1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -36,6 +36,7 @@
>   #include "amdgpu_rap.h"
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_fw_attestation.h"
> +#include "amdgpu_umr.h"
>   
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>   {
> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>   	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>   }
>   
> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd;
> +
> +	rd = kzalloc(sizeof *rd, GFP_KERNEL);
> +	if (!rd)
> +		return -ENOMEM;
> +	rd->adev = file_inode(file)->i_private;
> +	file->private_data = rd;
> +	mutex_init(&rd->lock);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	struct amdgpu_device *adev = rd->adev;
> +	ssize_t result = 0;
> +	int r;
> +	uint32_t value;
> +
> +	if (size & 0x3 || offset & 0x3)
> +		return -EINVAL;
> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	mutex_lock(&rd->lock);
> +
> +	if (rd->id.use_grbm) {
> +		if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
> +		    (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
> +			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
> +			mutex_unlock(&rd->lock);
> +			return -EINVAL;
> +		}
> +		mutex_lock(&adev->grbm_idx_mutex);
> +		amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
> +								rd->id.grbm.sh,
> +								rd->id.grbm.instance);
> +	}
> +
> +	if (rd->id.use_srbm) {
> +		mutex_lock(&adev->srbm_mutex);
> +		amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
> +									rd->id.srbm.queue, rd->id.srbm.vmid);
> +	}
> +
> +	if (rd->id.pg_lock)
> +		mutex_lock(&adev->pm.mutex);
> +
> +	while (size) {
> +		if (!write_en) {
> +			value = RREG32(offset >> 2);
> +			r = put_user(value, (uint32_t *)buf);
> +		} else {
> +			r = get_user(value, (uint32_t *)buf);
> +			if (!r)
> +				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
> +		}
> +		if (r) {
> +			result = r;
> +			goto end;
> +		}
> +		offset += 4;
> +		size -= 4;
> +		result += 4;
> +		buf += 4;
> +	}
> +end:
> +	if (rd->id.use_grbm) {
> +		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +		mutex_unlock(&adev->grbm_idx_mutex);
> +	}
> +
> +	if (rd->id.use_srbm) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +
> +	if (rd->id.pg_lock)
> +		mutex_unlock(&adev->pm.mutex);
> +
> +	mutex_unlock(&rd->lock);
> +
> +	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +
> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return result;
> +}
> +
> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
> +{
> +	struct amdgpu_debugfs_regs2_data *rd = f->private_data;
> +	int r;
> +
> +	switch (cmd) {
> +	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
> +		mutex_lock(&rd->lock);
> +		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
> +		mutex_unlock(&rd->lock);

As this is a two-step read/write, I don't think there is any protection 
offered by having this mutex.

Thanks,
Lijo

> +		return r ? -EINVAL : 0;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
> +{
> +	return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
> +}
> +
> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
> +{
> +	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
> +}
> +
>   
>   /**
>    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>   	return result;
>   }
>   
> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
> +	.read = amdgpu_debugfs_regs2_read,
> +	.write = amdgpu_debugfs_regs2_write,
> +	.open = amdgpu_debugfs_regs2_open,
> +	.release = amdgpu_debugfs_regs2_release,
> +	.llseek = default_llseek
> +};
> +
>   static const struct file_operations amdgpu_debugfs_regs_fops = {
>   	.owner = THIS_MODULE,
>   	.read = amdgpu_debugfs_regs_read,
> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>   
>   static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_regs_fops,
> +	&amdgpu_debugfs_regs2_fops,
>   	&amdgpu_debugfs_regs_didt_fops,
>   	&amdgpu_debugfs_regs_pcie_fops,
>   	&amdgpu_debugfs_regs_smc_fops,
> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[] = {
>   
>   static const char *debugfs_regs_names[] = {
>   	"amdgpu_regs",
> +	"amdgpu_regs2",
>   	"amdgpu_regs_didt",
>   	"amdgpu_regs_pcie",
>   	"amdgpu_regs_smc",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..6d4965b2d01e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -22,7 +22,6 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> -
>   /*
>    * Debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
> new file mode 100644
> index 000000000000..919d9d401750
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/ioctl.h>
> +
> +/*
> + * MMIO debugfs IOCTL structure
> + */
> +struct amdgpu_debugfs_regs2_iocdata {
> +	__u32 use_srbm, use_grbm, pg_lock;
> +	struct {
> +		__u32 se, sh, instance;
> +	} grbm;
> +	struct {
> +		__u32 me, pipe, queue, vmid;
> +	} srbm;
> +};
> +
> +/*
> + * MMIO debugfs state data (per file* handle)
> + */
> +struct amdgpu_debugfs_regs2_data {
> +	struct amdgpu_device *adev;
> +	struct mutex lock;
> +	struct amdgpu_debugfs_regs2_iocdata id;
> +};
> +
> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
> +	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
> +};
> +
> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
> 
