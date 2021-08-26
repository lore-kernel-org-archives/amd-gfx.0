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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FFEC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46A86108E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E46A86108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783756E5D2;
	Thu, 26 Aug 2021 10:48:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE9B6E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLHvfSTFF9P/UX+xtmWv5lGOAlyO0Xme3AL+vm2AQG+d5gAz09hh/EWpu3sgJb+Z5NrQivojF9qeFHHpKl01HaOJdsLsXuyo6JdiP90QxDchoNrkPhi93E63ZdRiUrx8mOvWwErpAjdPP2j0Y8aDJeBgB9Ui1OZ83DynK1f0c7nSbIFYEbl5fze01COvgEblFVi6TwS21gEjh5P/ZFWeHmpPptDKgUf2g5sS5W09gxvLou7pSDCooQGcjnqRUIAnsNsDknAgPgsTwYUIkI67DD5ezlBmgR9mOF/h67lJURT/XI7WnFp3YQ+/UsuNDbcry52MQ81hi8DG4yJOwrfBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzh/owSKTXdT52o4C8+G1nBlYxkpX3LycAqrVyicCKQ=;
 b=fh7gmPyOnRu39fpUAQzbyc6QYVfN6DJ6f110HZDE+DI7c3SMdlxHSZq237//UCBUDmOxbYLgYecN8orO4Cj/phutm3/ZqvoU0hB/3tMj3iKenZFVxmujtgA3oXKXYFk8S7R7AxWs8ANJ7c4LJImhTImzQ6Y9JDJpdnDXdVVTYhw7vyQYB1bDJjh01CVIMCAZM+Sq7gD6E5Biqa56iSGepX9lPVQBXmmWYmhcfzQuTznnb3zNxYANkvws3Nj6Cc/3D7tqzYr2Hny55za//SFOKJ8ze4kDvAjA/0d6lPdVP+U8tKPUgo8uRz98fce82+RYoD6lt1GHm0nF2i338G5Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzh/owSKTXdT52o4C8+G1nBlYxkpX3LycAqrVyicCKQ=;
 b=KN74IYzK/yRD9YVXLK9RKXhdU5f6HoZ9oNvwPu/NycUw2RHuWzWUUEmRbSrUj16dd23zJxHynrwkl9mKtpOc+/f7VTaRYnXghmNgJlMLo2ouEy0c36H9hlgEOPC1YUDIDUDVswYsiuhGo/XLPceqCEmphnNZNkZTfPzkh7/dC1E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 10:48:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 10:48:07 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: detach ring priority from gfx priority
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, satyajit.sahu@amd.com
References: <20210826100824.38041-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0f3102bc-b5a4-b892-82a3-0e16f0bdcae6@amd.com>
Date: Thu, 26 Aug 2021 12:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826100824.38041-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR2PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:101:16::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:53ec:f9bd:d7cc:10a9]
 (2a02:908:1252:fb60:53ec:f9bd:d7cc:10a9) by
 PR2PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:101:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 10:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39acda57-f96d-4dcf-fc09-08d9687efd41
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB388719929D0585B90C5C87A483C79@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrWlceaMNWijMhwjrbP4ucpniMaIFABB7Ozm73ZHyrNMcKY4puMXPNtAeaVQIxav4rbU53w8BgIKCEukIWChpNMic4kByLJ5zlucR2Er1wT8CR2IAtoQGi8W/jFdyOywB9E3FGJDOkEXN71/44CjFi4eqAa8TwOmN12dFYu7fCmk/Jxc+h/iAHn2p0VzUUuaTJubjsVrhds3prKXRn248motOdo4fqRNsX7y/+giD54xtqs5FbvQIqcSZKb/OrqJOT+NEfHFI3a6+WHPyLGj5Vu+wEam6vDksFoVd9xvjRdLehhou3kBUS6nzZn6DLK3VgtmlXF97/u20NwvShrhc/x7Kf1XQQrFuLnq/VT5CeoB2Qed93YjbS9IZhq6JW+hcl2EZEXBjcj0YHCNptcikTAYdJT8/T8rqr8WZu02j4Kf2RoY+zk8XvLOdaxaJiI6UGgMmE7o7rRtG3uPykJ9M3dXhR7OnPMY8AbY9iT320cHQW0EkFtT7TqI2oqY8SCGQw1L5LkB6wOIuC1BmKQ6zKufRzHJbHMVWnaM02s+8lD95j1H73x04BvUy5QjHuSTETxnhb8kBw6HnMbdFwhMCvpz1rgoZ7JoWwyR+KtbyJMQO+4qgMAQmXB0hT0KwIns3AqMKjPqOAW+LdtJtWMa9lBn0pZKce8Si+oTB1vdeULmkhpC36UiXOCK3CEzIK4NylTu9Fpe4d8+ojJ33H1FCxGptSzIyKH1IAzdjJfSc2qJ3RJD/CKAsMAcKe4Rt2rf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(5660300002)(31686004)(83380400001)(2906002)(2616005)(66476007)(66556008)(66946007)(478600001)(31696002)(316002)(6486002)(186003)(38100700002)(86362001)(4326008)(36756003)(6666004)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpGbGhKMUFkQUpENnBENXo3LzVrVlJ6YXFnYncrOVFGOStyNmdKcEp5bEFR?=
 =?utf-8?B?TjJkTlVTK3VhR0J1SFVOblVWNFBCcER6S0VReldhTmNFSnVQVlVVWjhVcDRB?=
 =?utf-8?B?NUs1MFIvdGpJeUZYL0FIcDA5MlBob3lKcjI2QVQ1ZGNvYmdpOGJwUG5Qc21n?=
 =?utf-8?B?bzY3cmxja29vcFJibVVqdmdLNzJ5SXEyVTNRV2Fja2JMZ2NyZDVhT2NCeEM3?=
 =?utf-8?B?Um9nUFFzWW5UZ1BsU1BaOER5S0ZWRUZ3QXJxRHdUTGlzWjBvcGh6bFU4ajlw?=
 =?utf-8?B?UGJsMU1rMkMva0NaUXJ5UWpWNHArODFSR3JlTS9yVzArVU1uQlU2RjlFYWt3?=
 =?utf-8?B?QXZZc3JmT3QxWW56MC9tZSszQnZyanYwY01aa2h4QkV2NFdXZllGdGVXZUlQ?=
 =?utf-8?B?Z05DdGdHODNRUFI0Zyt4aXBXUzBuM2l2N05FMkhBMEZIOWhUZWswQkxYdFRn?=
 =?utf-8?B?VWlpc2I4OFU4TzFPMFVzanQzS1Nlbkk5L01qNjV6b0VsMVM5a3AzRTNwM3Yr?=
 =?utf-8?B?Zm1nTTNaVitaVzFHUWVsaTlYdWJibWVVbVhmc091Zit6dTVFU2hBMTRLbWk2?=
 =?utf-8?B?NkE4bGNmazZnTHIzVzlsZEp0Sk00K1d6TlRWeGw5YkJUY1VQLzh2WDhObFJl?=
 =?utf-8?B?M2wwSEdpY2dCK2FTNzFlNTJUazc4UGYvSCswQWJEZUJWenVJTlNCVVRrek9X?=
 =?utf-8?B?WUxLS3Fzd3hPNjdEZVQ4UUpUc2VBZnZKck5sTEt5QmZOeiswWnlMWEl4cWUv?=
 =?utf-8?B?UGo1b2NhRzY0ODVzSGFMaStGczNvUGxXaXBBTEE4WnZOQ0U2NjZTenFGUjc0?=
 =?utf-8?B?aEVaS3dzcnlOSWgvL0NucU5rcmtvN2hlcGNncnZYTFQyRkRTNjFIakkyL2hH?=
 =?utf-8?B?d0ZDeGlCdmVJa2dmV0pPY3d1MmpJRDQ0VFBMZE1HWlNLTDhJaHhlbFpKTlU0?=
 =?utf-8?B?ZS9JVGQrL0FHREptUmE3dG13WHlESllCZTMrNVNHRUF3QTFzOTFOMWNJb3hV?=
 =?utf-8?B?eTlvTmhQNjVSeDRndUpaMm82WFVvUDhMcnVsVkNudTRONlVRVnZUVEhHMHZj?=
 =?utf-8?B?Q0xveWxKOWpYRENhU0F4b01veENGZEZ0SnE3OVlla1VVSDYrRi9qYmVldkIx?=
 =?utf-8?B?VUttNWh2eTZrbUxTSklXQ0h4bVkxU3FmbWh1RmlJQzdZMUxPdW1DSWhiS1Qy?=
 =?utf-8?B?Y2FwWkVsbzd5eW5mSXVweStXQS9QOVhQUDE4ZysyeUdnOFcyNTNCa245VGFi?=
 =?utf-8?B?dkVHdjBOQ3V6bCsvUStkZVoyZWdWSkpNVmxqVmFncmFZWW1XeWN3Rm1IMjlT?=
 =?utf-8?B?MUhoQ21nUWpnYkQxVHRHMjBCRW0wajcweU1mc2hCRkVySHhwa25aZXBlV2pM?=
 =?utf-8?B?YkZSb1AzdWdYYTJTaytJR3pDZWhJUnRxeFdSRXNaQUF0bFI5M0FnQkt5MDQz?=
 =?utf-8?B?VkpLdyt0cFdwWGZGNjNkb1JkSnRBQm9ONUZvYk4vdTZ2YzJHdkJRdG5aUFd1?=
 =?utf-8?B?Z1dueXRDMTZ1SHdUcUZyKzlEN3prVVRmT3F1d2FZb0tDMGJrTlVZZ2E0aGlC?=
 =?utf-8?B?c3JOZGt1OC9OYUIwc2FXOG9lZURwK3dJZU1ldXU1NUdWaUNyVzZCcFJTaFdR?=
 =?utf-8?B?QUVqalpwVFBJczRmMk9EYVB4aVRRRVpqTCtWaHJGTXdlTTNZQjc1V0J6RmtE?=
 =?utf-8?B?VUttOWdFNndPZTdJM3FsMEFja0lrWFZRSVlxaXRsdHRjZldUaXJJUjZZNFVo?=
 =?utf-8?B?Qmg5RjlCRlo5ZGV2QWo1amYvcGgrejdxUjBSTHF6dVZSNVVSV1NSeCtOc0tN?=
 =?utf-8?B?U3ZHRnMwUVAvUkh1Q2FqWlVQZHQxU0w5UXpWUmhJZXg4YVpXZjA4YkNQb3ZW?=
 =?utf-8?Q?m2VPBw/HUMsQF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39acda57-f96d-4dcf-fc09-08d9687efd41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:48:07.5892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVMWOxiPaxPYgFlYBHi4reaHjsV3uRIeQQqa2TYohizhqnycLTe42jbEtc3lyVHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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



Am 26.08.21 um 12:08 schrieb Nirmoy Das:
> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
> max gfx hwip priority, this won't work well when we will
> have a hwip with different set of priorities than gfx.
> Also, HW ring priorities are different from ring priorities.
>
> Create a global enum for ring priority levels which each
> HWIP can use to define its own priority levels.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 5 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
>   2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d43fe2ed8116..7f747a4291f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -43,9 +43,8 @@
>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>
>   enum gfx_pipe_priority {

While at it can you add an amdgpu_ prefix before the enum name?

And if the enum isn't really used maybe even replace the enum with defines?

Thanks,
Christian.

> -	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
> -	AMDGPU_GFX_PIPE_PRIO_HIGH,
> -	AMDGPU_GFX_PIPE_PRIO_MAX
> +	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
> +	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>   };
>
>   /* Argument for PPSMC_MSG_GpuChangeState */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e713d31619fe..88d80eb3fea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -36,8 +36,13 @@
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
>
> -#define AMDGPU_RING_PRIO_DEFAULT	1
> -#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
> +enum amdgpu_ring_priority_level {
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_DEFAULT = 1,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_MAX
> +};
>
>   /* some special values for the owner field */
>   #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
> --
> 2.32.0
>

