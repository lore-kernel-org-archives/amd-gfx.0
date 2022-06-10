Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B556BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 23:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3156011ABB7;
	Fri, 10 Jun 2022 23:08:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7628311ABD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 23:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOxWazh/b3MrY+Y99UBHBVRDa4yQkeH+qRbOT3+uF6SdjGVHmgys5EpK/onJaT6X0kZLo0zRRveSgUozv6Vg4mUJRMyHtIzOlX0bZaGUIFn/72BK6WrEidefpcst4dEW4RuauBKbdOUm9iyN3O0cts116vcHOdYLuMYjdpp6SBMr291sfxIT7ajYWalwUkpkSgeTim2+kO3OJObLpQ1ldFh1w486Gufipob0Hl1ghA2L3dvuk+uARbuOaAufMX8ofkroN8mIwJU+4reqhz0uj4UINYZEZrJ4MhAJnXgGRNyK8WN7TuYEbhtp7MnSPq/OUrS7IOzwQHr5LT3LWWgVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsP8J0h4DbcT8i6MxwyyEdiKK9kpbvnzraH+mW7/574=;
 b=QShvBN9V7UXj/btW1h+XwI9sM5mgZqIoY+4Cp74OtH16RvZwd2nQax2Xc9l7n5QqkUe7GEx1flWWeLY1v861h4qGH9sDFpCYtugvGyFYrPoKMRzWZ3ZKX8zfidP0MX97vcWwSDgPoOII/orbdYvbdmGQ1q17E9PefIe7/2hQahxf1cC7ltkK/4OTfpODbQMVTakOSmEiAfnYxcF3yNJd3OzyFy3HKy710qNA400RuOeqxD9q9WMshdX4v8BDYLA4MqN8qcyfY9CyYX+8TUkZnd1pShzx9ZmW0BqrG9tW0ZO+FoHCASeUP4qx1GO5tWnN1rRlCRI/MY4I7KKktIo2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsP8J0h4DbcT8i6MxwyyEdiKK9kpbvnzraH+mW7/574=;
 b=d3vMVBvkdkOVo0lC8uz7ieDyTZZzY6wBzxBpiZsQVAH2PaVvPhmn2YhpdCUgDx1H2sx7h3DlZO306OVu4WwQLa12VbK+rvvrCFYlWin2iB4L9fWMXhfGMPX91T4yl1o2vWq/iGPCPGCPlKLvTDDHefgFHbo8Owz3Df6MGMoz5rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 23:08:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 23:08:00 +0000
Message-ID: <a00a3ce0-bf06-d57a-4b9b-af1aee138a74@amd.com>
Date: Fri, 10 Jun 2022 19:07:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220610171316.2668611-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1666b69-26aa-4d20-3c93-08da4b361030
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3099E8F4348E7141E66F5C2792A69@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfxTPNaK5HWVdiTA3nGjJ6qLY8nrRbeQ//ECOejznazUE4gt8lyM2dr+CkL9fbBbpsbfedAYD+Zwk+BqdMtVlNn0Q4ztZUYWNhR5kdsFdQQyAGfUX2ycDwrH64dXKSgYAHhJy82pi3/rZHiT+jGlmszzFQ7MLx4/e+TtjqJMmdY2BWw+2VwMDFaTTpzDlCH+R1Zw391t0DP+4odV3HgId5Xc2Bzr9/q1CYYYfO5C6L94X6O2x2mYj4sJ+a3xkROqa5gIM3p7UmTabz8Ue8hhbylf2/Yfwhpjh/W/zAxcjsDFnO+wZifWJe0uHAar/H2slGv2rEErYNmOjTgjNvfR6RYjDkSces2d+rJ0bPq73WdxXZO9aDD2YwKSE2OaDS1s2VvnX7TAo2sTPfPyrWvIlg3jpkiY6pov1UFCmikaC/ow9fmCGbJpuZQg2ECXlVQL8adf8V7OlS/4jeo/k2bUQT5IwOkzPxL1ChAHZwWb4pU3ZbFER8gkcsM4xNLePM4Yo3/pGbO+Zu1eSH6012bfyHq1CFj1F5dK1lh7OyjSjyxie8Ipf7pvXxeVu5BFYtXjMs+YyRTVUI79KlN+O+uin7cx9Tsx7SQjdb8PmpILXlFxdw6qtV23jOp0w2eYWJ6ose342cdNZpG0DyyRAm3z6RjWbdX74Wn6szaxHz3SNhTB7414Tx6wQwmJ9Kh1nmzjYM9kgUY8awSiLG7rL7yQaCxXgpt+syi4pZEP///YR9G/SPZTaKG6j6t2a8BAQduu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6666004)(26005)(6512007)(508600001)(186003)(2906002)(44832011)(6486002)(2616005)(5660300002)(8936002)(6506007)(66476007)(8676002)(4326008)(66556008)(86362001)(316002)(31686004)(83380400001)(36756003)(38100700002)(66946007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05KY1gxVlJtK0FjNFJmMTI4MExRQzJaUnM3cmVvQnhLcCtQZjRHcnkzVGpD?=
 =?utf-8?B?dGg1WkRzY3d6YnY3VVZJa3RpTHdZZ2VmNkt6S2RoT0ZhekdadnZVbUI0ZmJT?=
 =?utf-8?B?Q24wd21JTGJxYWxOVWpINzRyVFFGY2NHTm9qLzg2SDdCU3BHamxIcGdpbWZ3?=
 =?utf-8?B?WmkzOGVwZlJTcnFNbWVXbzBPWWtzMjgzQW1FTTlCNzk0Wm9MZksxa2RXY1Qy?=
 =?utf-8?B?aUhjRnk2UUpBWXdpeDR6R1dONmlMazdhSXo4MEdld2VST1pkRVFtYTJOVlox?=
 =?utf-8?B?VUV0VVV1K3FKRk5CZG5lOTFJYjJZSVBrUXhaMUZHM1pTWlhPQVZVUExVa1lL?=
 =?utf-8?B?elNLWk9XMzNnTmJLTjVQczIvd1BXTjBrTzQ0alc4TkJYckF4eEtWZ2lIdU4y?=
 =?utf-8?B?Qkplc2xiTElxcnpjclgvTjMwblB5MlFZY2dDVG5PcGxFd0ZsMjBXYmZ3U2RL?=
 =?utf-8?B?ZDBJRkxEb2pNczFiUE85MC9XcVlaRVZIa3hnS0R2S0FzM0tQN0EyNU12d2Fr?=
 =?utf-8?B?WUJza0FpSkxkVTNhcDN4QlBPVTZHRlEyV0MzRElXYklSaWY5djlITmRqb3dq?=
 =?utf-8?B?QjBIalFzSFhhSUN6dXh3LzJzL1hOYlBnbHZ4TGxNUW0ycGtuQkNabThLZGFM?=
 =?utf-8?B?eThMZjZhaGJzd2haa2lmZkxQdWhDbU85a3A5VmVNTks5YkVEQTd1MWd4aUFx?=
 =?utf-8?B?aEVkR3BzY3hVRVdwcmU2ait0V1hWaEdrcTl6dE45VWlGRmdudFhlS3lsRmxT?=
 =?utf-8?B?UjVPUEZ1bEZXM0FyRGJpTlVSOUNyYXA1Rk1RSHhHeFVCZU1IQ3JmdlNJVmFW?=
 =?utf-8?B?UkhTL3BiVkM1c2FtOW85TXJnaWV0WjVBeWk2NlpLcEUzVkF4elh6aDVzdVlQ?=
 =?utf-8?B?ZWR6a3RKenBVQ3l6STBmeUFnWEJxNGlvOFdMS3poUW9hWHdhbXZHdzhaK2Uy?=
 =?utf-8?B?aWxVL3NtdFRjWmtaMGtQRFJBa1JIeHFHR1NFTGpiZFZ1Wi9SMEJhVTF6Z2lu?=
 =?utf-8?B?L2dnTEoxaklGZkJTdWwzVm1oYk1PVXNOZGFQZWt2NVRXbXJEQ0F4ODZYaEVm?=
 =?utf-8?B?Rlgyc2t5MWI4dmZGcFc0THhyeTJFTU1DL0RYckFkYVZ0ZnBaTVJUS1VSWmlx?=
 =?utf-8?B?akJaV0Y2bUEvdUdsUzdkRVNub3FQMWdkbUtiQlpVUUZQRUoxdVloaG1VbGZE?=
 =?utf-8?B?aDNVSUg1bWJ3cFBOdS9tV1d1WEtqVktmR0RWRnNLaXdacnhSYnljaFpkSnB3?=
 =?utf-8?B?TEhkWlRGYVBZZzkrNklnSDQ4TnBDQ01ZTUJVN1B6NHA3QS9vN0RldjhxdnJX?=
 =?utf-8?B?OFpGeUtFLzd3R1Y2d0puK01NM1g1S2xxVlR1RFNEL0MyMmFNaUZ2OVFYRGUx?=
 =?utf-8?B?QWs5WnNUNXNBYkZtSTJkeWFPd1BWUDFMbzN1OE9LcXBSTGJ3SHJvLzI1b0h5?=
 =?utf-8?B?Z2FiN2RPa0UwNzVyNXorZy9sNWxWczZnb001SzlBd3ZnSkh0UXQrcEJuVHVO?=
 =?utf-8?B?cFoxSk5ZS3FLODJnUGh4NEFUOWcvc0tmS2ZDVHVkY0g3TTE4clhtS2pzUy9B?=
 =?utf-8?B?WGtyUTZmQ0RPQnFQbnNpbDhEanNueTVwa29sWUcveTM1RUtHTWZhZ1gydTFW?=
 =?utf-8?B?NkUvaE1iaEFiNWhGRjRjRlZwTXhRcStEUGl3QlUxay9veDczdGphWExER3kv?=
 =?utf-8?B?ZTRsd0piQU9PYlA4SlJYTmNCK29EMTZQSng0OEp5MEpaRjhJTVZhejJZcXFm?=
 =?utf-8?B?Z2Z5NHIzVENWc054QnBlMWVzV21SNlQ3ck1DbnpGMTROc1hwWnp1UVNFOFp4?=
 =?utf-8?B?NW9jMkVSNERjZkdwVjhacGxEZHdFbm4rMXd3c3U3b2RzNDhiVzdmdUQvMUdS?=
 =?utf-8?B?ODhNNnlCcWxCeWFJLzJESmY1cmYyREtyWXBLWkRzTmxMY29Nc1NKSHFTbkFl?=
 =?utf-8?B?SlZxUlhxakJaNTI5Y0hJNGEzOWxObzdCUHppODhSTmlETldxSjFqbUd2aTZP?=
 =?utf-8?B?Zi9sb0ZHZ01MMVBvRXpSS3ZWc2RKa2xUemRISjFuZG9zcEJaOElZVUtiaWZs?=
 =?utf-8?B?NUUrMFlzc3VvVGNPVHRNNVhwcWRlTEtGbU0yVUlqaVJVbEhGSDhRbk5GYVYr?=
 =?utf-8?B?blprb2VSRG8ranJFR3NzSFpWVzNhakxWUHkzcEptVXJRVjVwWU9uMGJDdFRj?=
 =?utf-8?B?MFhlTE1QQnFZcG1zOGptZVl0WUNJeEdOb0NEU0NiYkRQNkFvcGVSYXlFbk4x?=
 =?utf-8?B?eDFhcTNmRmViaUVibzdoc3V0RHNmaGluODVPdGtUM3JjaURPZDFqS3NkNXdF?=
 =?utf-8?B?R3JpNWpmc1RvWk5uRTB0L2w3dG5EQ2E4YlByWmtOY1ZuOTRVcGh1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1666b69-26aa-4d20-3c93-08da4b361030
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 23:07:59.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kj+xXMfu4FRBPDpE3TW60UDSsm7pp+e45VEGaJZPRfk7lR3vYoyqjPw/wNRnoH9tkHp78eJqqPBwdrx9YkI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: Mukul.Joshi@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-10 um 13:13 schrieb Graham Sider:
> Store MES scheduler and MES KIQ version numbers in amdgpu_mes for GFX11.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 92ddee5e33db..aa06c8396ee0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -64,6 +64,9 @@ struct amdgpu_mes {
>   
>   	spinlock_t                      queue_id_lock;
>   
> +	uint32_t			sched_version;
> +	uint32_t			kiq_version;
> +
>   	uint32_t                        total_max_queue;
>   	uint32_t                        doorbell_id_offset;
>   	uint32_t                        max_doorbell_slices;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e4eb87689f7f..2a9ef308e71c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
>   		mes_v11_0_queue_init_register(ring);
>   	}
>   
> +	/* get MES scheduler/KIQ versions */
> +	mutex_lock(&adev->srbm_mutex);
> +	soc21_grbm_select(adev, 3, pipe, 0, 0);
> +
> +	if (pipe == AMDGPU_MES_SCHED_PIPE)
> +		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
> +	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
> +		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
> +
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +
>   	return 0;
>   }
>   
