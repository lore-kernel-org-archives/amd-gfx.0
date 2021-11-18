Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 05:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F033E61A8E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 05:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F033E61A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EC26E976;
	Thu, 18 Nov 2021 05:50:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545536E974
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 05:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtL/aZCVzez7Fz7+XfH770/k0ovqUc6S1axs3xFcT5NwIU5H3/RkNfFvtPQylSTM2pyM3vc7sJ9q/Hao1MFZ3GR40kfUp+GUUely4lYPKcoqR0/8HCiZrBGTRgMh0aQMhiTgyaZOQVZPqnumWIp2Kt5R5mpdZAaXLcJLYInWtXdi7TZ1Vh0PWLTqKKqiuZZ+EDV1W60Cde2i3g+Xy4giGjBUSqsI8CXcXD2Zfd18d4Q2wWrJcYl9I3bf9OjT/2O6W/ZnkhRdwyA2RGjvuLPd6xlF9d2VpZ/zFKbjjojPBXTSjbLUT9pndjy8uWUUiYzjodjYnjIi0Ys0xANempB8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnRRttvrSMVBaHSa9ECGG5M1cm/1B5lR46FHMEgqUng=;
 b=WTBRzja5e5QgqjQYcEGoOXqiYaKLKVryPfVhe5VCOrqtLpXI1NsuzY9kRKy+zAsNH/SZcTFXkLvvcRK2Me3NskEDr2zA16BfmbqR9+Xq8EmQoBmvNvNbkxw/UZ0XHJuG1+JY1Kq/1gy8fi+HBJZSNgm5okstmD9bm+D1NMMZNirwKtZ52E2pVd1apFjjUHQ7f6D/69FAuiu5xsEishWWN8XGEosiYs8D1owzaqT0PklHC/4gBaty0w9DszPgm3UsOrrQ5tKKDEb+ErNZFqwuykR5EDJAk0h6EtFKo9hU+StWaxj4SRbCYOQNUFAHma5CprMxjG45+MtHijE9T3R2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnRRttvrSMVBaHSa9ECGG5M1cm/1B5lR46FHMEgqUng=;
 b=vZ7oEuvkYtNbqt1PcLCPkepSp6089bDssE37m1IoIn0uqlXmiB3ybhRqFopOZadrAmO4gWNlmv3REW5oBwlWOZ2y9tLfLCrGD0ImDPUpdog/xA3iqddN6zbitI3pC/0JyxJawu8Oo3ZFJ83EGaxGbSaOe2Z9GAxwB0wdweHwq/E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 18 Nov
 2021 05:50:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 05:50:52 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Retrieve SDMA numbers from amdgpu
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211118053959.15006-1-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <df885962-1864-d50f-837f-6ac76a957e5f@amd.com>
Date: Thu, 18 Nov 2021 00:50:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211118053959.15006-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 05:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ab8b31-9004-49f2-4318-08d9aa576196
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5189B4BE315DBAC569C6CCD7929B9@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XST8YBcqmoxrr+xl66YDZYZPzHzZEqYhJkJjuitzecl+qYycqEmywB7qOPDEkI+HgIYppqsGY17yAT3zZuX5UFpqI/zMCNMwjo2MV/Piqj1/+uAK0tBrvUY1zeCpRwNNwAUZvRxOULFE/6cCrZ8lcAE33QK4aDvofu9Ih59FxxN2ARrFYdO2Z4TlltUqgD00uMwYLhh5SckK5JxT3LGThban6WZNeSJXr4J6y7A0gGF5Xhj6pTgN/hGZsn9kI26rf0z7ySjGTp6m2CylZiKeBdpezR4vyquOawnxpWRhNVkcirX56mkovamWI32FigvddMeEezUe9py4CQQG5yJ0WHhs2Dtqzyzi6tUhZPDgwiKFm8+4R3TSrxKx9qccBpl8l8XT18Ow3CtMScaGRdiZN6mQp2d4ytzZQs/LCfL4/kZM+5imkXmHfSUlugVgjIe+VDQ9ZNmBF59mE18vRRyka9X0FzIrQ1IZ0bOTQchOWMBu/DFFfVTNLn0ZkE99cBYR/A/Vshhjdw/hkAeY5lE9wkVXqphuLHvc+D5hzULTdO/P3RXaO1ZqeSqQbXwqRGmevDCTFQr9owXyJ/hd34QMLvEToQef4+wKgpWXB4O3W20NDTXymqEHMyEWPVl/X3TeMNyrC8SI7tCyfPb5fYMhC76sgU0hOoGmpLYjUWWojDdvb4jYsMkxQ81MRTvpkQhkKLKC2tul1FA62NpCBgqZIgP1UU/jXFOQJPUjM3nZ1rJM4ysYOiAs5Co3YxWeS23k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(8676002)(186003)(66476007)(5660300002)(508600001)(4001150100001)(86362001)(316002)(8936002)(2616005)(31686004)(36756003)(2906002)(66946007)(6486002)(26005)(83380400001)(31696002)(44832011)(38100700002)(16576012)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJxREF5MGQyWU01OVlNT28vdzN1N1dOUkZnTldaMFN0MHYzRThvYW5xVlU3?=
 =?utf-8?B?eW42U3RFM0tYN0ExWm85bUpMTHJyZXV1bXBqRUYwVFYzeEhsNGcvWjlmUDQr?=
 =?utf-8?B?MzVheDdCbHp5VGFqd3h6dEVISDZuTHlRMit1dlIxWWFhQzB5ZEtCKzdNUkhn?=
 =?utf-8?B?MFdLTDZrTGVEallMZVdsZkswN2hpTTFKczdTR2YyOURZWU5ScHlpRi9hZ1p6?=
 =?utf-8?B?VnM1bmExcWxKK2RmZGZlRTlOVVJmekNiSXEvYnNOVWlMVklmeCtURVZwQW5l?=
 =?utf-8?B?UHR2QUFDNDFhK3NMNzFkV1lNUkVXMmhCNXdSc0ZyRGxYV2dHVkFkRVFlOVgy?=
 =?utf-8?B?R1BsZDFBcE92Z09vbUdOeUZHZkJxelN5cFY2R1h2Zk4rTCtIOEwyZmpvaThh?=
 =?utf-8?B?d3V0d2JoUmdKUm1BRFdEcDNNYndiUXMxR3BYeVhFZDVjRWppRm0za1BJQ0Zm?=
 =?utf-8?B?RWpTZ1lrWmJtR1VxTkZSem5WRG5Eak55aFJSYVIxRzVZbDAzQUZ3V0taS2E4?=
 =?utf-8?B?d2NsTFZ0bll5bU8xT0dwOElRdXpWSHl5VExDSVpJSlVjVi9oZzh0VlVUbU9Y?=
 =?utf-8?B?YSt5TEJaQ2NldmttenkvUVZib1F6RlhBRUFZZktFbkI2M0VoTDl6S0RISDBL?=
 =?utf-8?B?eWEyWGpGYUVxZ1BPa0I2SEpjZktBUzE1NFI3Mm9SQUcyT0NpZHZYMVcybTZ1?=
 =?utf-8?B?MXNvSDdqVzVjN2dhbC9BbXNEREQ1ejIrUG5ERTNEMDgzWVYxUG14ZUtmRU9T?=
 =?utf-8?B?dVpLa2s5dkV6L1JrK2VxYkRaczA5cit4dnRFWEYwdWxFc2pmWVRzQk1hMlBO?=
 =?utf-8?B?L3ZXSXZjVHI2UnhKK29wa3Y4WE51WmtJamRvTld1OUVISEZBZXVmUHQ5amh4?=
 =?utf-8?B?cU1PNnpLZTNUZUkxc3Q4Y1dnRFN2SFd6V1pMZ3czT09sd3FDOVdEdjE0RGFk?=
 =?utf-8?B?ZWdQNzJwRE5GN3B1QmZEcTJVTlVMZnh2cXV0SGEySldKZDhQZGV3MThBK2xB?=
 =?utf-8?B?RjltSEJMLzlweC9BaGs2TjhCYVJhekFGU0d4d2ZvRVZBdDZIWmVxVWs4RExq?=
 =?utf-8?B?V3ZyOVkybktCeElpaEN6V3JINDRybUpHbGVUTUpFbG0xSFd5U2kxSGp5MzFk?=
 =?utf-8?B?QW1nSkFjRWZvVFhoNEYyQks2RzFJeW1rUVFOUEtmUGkxM2E5U0hXenBKbkg1?=
 =?utf-8?B?NDROT0U5NlljM2lNdUljQ0pPbUdaRFZPN1JHSExsemNWdlBhd1FTT3ZpejZi?=
 =?utf-8?B?VFBpNzJGMTlFeWpyekRKeXp5Si9XdXRaSFJJU1crNlMrM0pXOVBtNDM0ZFY5?=
 =?utf-8?B?czlyTzQwdTU1TU5mTWY4WDlWbms3RjFGZEpQVG04L2F2bWxEQjQyZXpLZU1Z?=
 =?utf-8?B?TkplVHJReCt4VndRdndmVWNDR1RPbUpsOVh6dkppekRXbGtIbkZpaG8ya3Ay?=
 =?utf-8?B?S2lwUkM4RTA5amtCZ3dxZnVWQjFQcWRMa0dOUmtFY0NtdWI0NE5kU2VEc3J2?=
 =?utf-8?B?YlpYRGFnVDF2eVZ1WERSYm5BNDVVTDMyUHhZQytJMVRMeWVzK0VJUit3RzM1?=
 =?utf-8?B?Q0w1eGdjQisyOU5FZlBBK0Uwem12d0NJQTFRU3BQQ3hPUDJqN1FWZlVMMUZR?=
 =?utf-8?B?YUxrMVA4SW5VYk9oVWpBQTdGK0pDczl0MkxQSXpFNWl3TU5oUi9yc1JuVXRj?=
 =?utf-8?B?VDFia2lpdkFnOWJTaVRFVVhNcjhwM05LTmRNb0d5L3l4bHFPRS9pd2svbkUv?=
 =?utf-8?B?Y3k5TWRjUy9sOEJRQ2w2Nkh6MFlMWXZHekhIMjBmaUZ3cHlWL2duNHREQmkw?=
 =?utf-8?B?VnRmYW1SUlRWNGZPMS9QK2xhVm1UVHdjNGVHVDNHT3paNWZjNDNKMUNMZGRK?=
 =?utf-8?B?Z3JMemhsZ01JdkRaWlhjcHZaeEJvUlpjaG5zQk1EQ3ljdGU2NitTS1VMVWc4?=
 =?utf-8?B?SlFTeERJTXMzQi9lS1VoT0dRRW1nN0JTM3N5S2ZTN1ArVEVndk95S2wveWho?=
 =?utf-8?B?d1VSSVVDanMvbllhUjd4R3hqUVhUV1daUS9VeWVRanc2cWVUY3NYN2NHMUhZ?=
 =?utf-8?B?bFZkVS95UzV5Q1FsWXNlYlhzYkVzL0Y1c3VFTFZqOHRldXl5cjdZc1o4dFpr?=
 =?utf-8?B?ODhVSWtEbWFLZXFUNDhwWnhDM3c3WU9GVm9sS3JuVWxIUDFKTG50UUZ2bzF4?=
 =?utf-8?Q?mwndL9qGqj5uMCbyoMde+xk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ab8b31-9004-49f2-4318-08d9aa576196
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 05:50:52.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2rqcgMPrIlGYjkpCPNWdxFvSeVcTLhedQsKvrUs8ACpAXKH7IACmhMzL9OIKHnaJcqmbyCV5F47lwLYwiOuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
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

Am 2021-11-18 um 12:39 a.m. schrieb Amber Lin:
> Instead of hard coding the number of sdma engines and the number of
> sdma_xgmi engines in the device_info table, get the number of toal SDMA
> instances from amdgpu. The first two engines are sdma engines and the
> rest are sdma-xgmi engines unless the ASIC doesn't support XGMI.
>
> v2: add kfd_ prefix to non static function names
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 ++++++++++++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 32 +++++++------------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
>  4 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index ce9f4e562bac..3fea47e37c17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1516,6 +1516,26 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
>  		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
>  }
>  
> +/* kfd_get_num_sdma_engines returns the number of PCIe optimized SDMA and
> + * kfd_get_num_xgmi_sdma_engines returns the number of XGMI SDMA.
> + * When the device has more than two engines, we reserve two for PCIe to enable
> + * full-duplex and the rest are used as XGMI.
> + */
> +unsigned int kfd_get_num_sdma_engines(struct kfd_dev *kdev)
> +{
> +	/* If XGMI is not supported, all SDMA engines are PCIe */
> +	if (!kdev->adev->gmc.xgmi.supported)
> +		return kdev->adev->sdma.num_instances;
> +
> +	return min(kdev->adev->sdma.num_instances, 2);
> +}
> +
> +unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_dev *kdev)
> +{
> +	/* After reserved for PCIe, the rest of engines are XGMI */
> +	return kdev->adev->sdma.num_instances - kfd_get_num_sdma_engines(kdev);
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>  
>  /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 62fe28244a80..2af2b3268171 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -99,31 +99,22 @@ unsigned int get_pipes_per_mec(struct device_queue_manager *dqm)
>  	return dqm->dev->shared_resources.num_pipe_per_mec;
>  }
>  
> -static unsigned int get_num_sdma_engines(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->device_info->num_sdma_engines;
> -}
> -
> -static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->device_info->num_xgmi_sdma_engines;
> -}
> -
>  static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
>  {
> -	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
> +	return kfd_get_num_sdma_engines(dqm->dev) +
> +		kfd_get_num_xgmi_sdma_engines(dqm->dev);
>  }
>  
>  unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
>  {
> -	return dqm->dev->device_info->num_sdma_engines
> -			* dqm->dev->device_info->num_sdma_queues_per_engine;
> +	return kfd_get_num_sdma_engines(dqm->dev) *
> +		dqm->dev->device_info->num_sdma_queues_per_engine;
>  }
>  
>  unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
>  {
> -	return dqm->dev->device_info->num_xgmi_sdma_engines
> -			* dqm->dev->device_info->num_sdma_queues_per_engine;
> +	return kfd_get_num_xgmi_sdma_engines(dqm->dev) *
> +		dqm->dev->device_info->num_sdma_queues_per_engine;
>  }
>  
>  void program_sh_mem_settings(struct device_queue_manager *dqm,
> @@ -1054,9 +1045,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>  		dqm->sdma_bitmap &= ~(1ULL << bit);
>  		q->sdma_id = bit;
>  		q->properties.sdma_engine_id = q->sdma_id %
> -				get_num_sdma_engines(dqm);
> +				kfd_get_num_sdma_engines(dqm->dev);
>  		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_sdma_engines(dqm);
> +				kfd_get_num_sdma_engines(dqm->dev);
>  	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>  		if (dqm->xgmi_sdma_bitmap == 0) {
>  			pr_err("No more XGMI SDMA queue to allocate\n");
> @@ -1071,10 +1062,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>  		 * assumes the first N engines are always
>  		 * PCIe-optimized ones
>  		 */
> -		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
> -				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
> +		q->properties.sdma_engine_id =
> +			kfd_get_num_sdma_engines(dqm->dev) +
> +			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
>  		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_xgmi_sdma_engines(dqm);
> +			kfd_get_num_xgmi_sdma_engines(dqm->dev);
>  	}
>  
>  	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 1d3f012bcd2a..1054fedd7b3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -213,6 +213,9 @@ struct kfd_device_info {
>  	unsigned int num_sdma_queues_per_engine;
>  };
>  
> +unsigned int kfd_get_num_sdma_engines(struct kfd_dev *kdev);
> +unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_dev *kdev);
> +
>  struct kfd_mem_obj {
>  	uint32_t range_start;
>  	uint32_t range_end;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a3f590e17973..2d44b26b6657 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1392,9 +1392,9 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		gpu->shared_resources.drm_render_minor;
>  
>  	dev->node_props.hive_id = gpu->hive_id;
> -	dev->node_props.num_sdma_engines = gpu->device_info->num_sdma_engines;
> +	dev->node_props.num_sdma_engines = kfd_get_num_sdma_engines(gpu);
>  	dev->node_props.num_sdma_xgmi_engines =
> -				gpu->device_info->num_xgmi_sdma_engines;
> +					kfd_get_num_xgmi_sdma_engines(gpu);
>  	dev->node_props.num_sdma_queues_per_engine =
>  				gpu->device_info->num_sdma_queues_per_engine;
>  	dev->node_props.num_gws = (dev->gpu->gws &&
