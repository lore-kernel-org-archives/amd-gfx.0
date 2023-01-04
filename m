Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852F6C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 08:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60B910E448;
	Wed,  4 Jan 2023 08:58:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A618210E448
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 08:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npK22gysJOLzsWHFLuvLYZjO0bE6JbXDimHBml+6kQ/ztgekQaD+/aGnklSR/ZAo/27IwoQ4KJ+277CUwPp6OTU8lI75xO+ukA3rdv+0IniDPf1bkSbHyYxUshnbzY3qvTgtADn1JnyWbhlYyeyBWkg3Ka90I9LwaT5M4VYwfsECzYKlD6W+Twh5wXvWcAI18yeOpAtnDqQYRnwJrdvwyApn+Tc8hmB14d7oS0avSoYoADUaJxQNlIa730o92EO+4+dDlTM5BjaFfkJNqiMzQuUUcWvYnFvqrJWWe0qkAOagt7WuvoneH9Ck7C1VtjUO+IaTRylraZJC3C3F7LszUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kSnYU5P8ZlCOVBX5oL+sZkopH9rxkYcUbWdx/w49PQ=;
 b=jDgBkfWtQQhdlU2lHBuIUdWFjsSzKE3Zt72KHeaAR+9iy1z4eNQmkIPJay4wpzubpHp65qmgt4O6dXYjs0Gh5quq69GNe5dojpzKfkWsdefa9yl/40u4U7fvX4TUmLMeAcnz8x8FdTXdIBUMMJUHXrKnx52afkArXNpiI6WCE2sLJfJ+uPCkKEf1kmqEwkKHFUhLuTEdR2rvqIjMTSSSldNVeymwBK3ROhFtxCwwBNLWi2E6AVdlBDU0hxAUyc7mLPoV9es8+R+KxmAOhkebuXlcrWTe5l6F4/zIg3Kt6XGwXRKZ9sgZPTIinGE6ZWMHJzZ9l6P8T/WbiHIg9SZbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kSnYU5P8ZlCOVBX5oL+sZkopH9rxkYcUbWdx/w49PQ=;
 b=aE45LWMmqwNVEh8FkopM33p1q7NFYw7Meg0dCIRSJjQnK3G0f2Wmmm8JolFz2EMNs4lKRURik8AeVX0bvbzOHddIZH70XyilxQYjIi9F1wrwUb9Yus1F6ot0OH12JuPo7cQ9oG8ggLXrBZ09QROernHAPrAWZccZyQYd6TZdloA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:58:21 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:58:21 +0000
Message-ID: <0da1dd59-d59e-9c56-a954-49924a27548c@amd.com>
Date: Wed, 4 Jan 2023 09:58:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <DS7PR12MB63337071189F0F5D018D35DDF4F59@DS7PR12MB6333.namprd12.prod.outlook.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <DS7PR12MB63337071189F0F5D018D35DDF4F59@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cddde3d-14a0-4461-70a4-08daee31d45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ropoMoUJxwQtGXcwmjD/DXDU8hQQtfnu2rEX5VwLTs+aEBAA/0BciNKqnXxpa1Ov0CVPUcHyjM47Tb7MaAmuIuu6WAc7RmzYlZqpNSGb0ornu5lkJ394kVsj4XJZJ2mJnFbjbnAKmM0uyUHm6QQbkUHsF36Pn5zolxi7e2uWv0+u5S63pcjvPfKg98ke+YQWOdPpAJDjlBH+mShnMxI/LwUZdJ9xwjLnEKcH0DINOwAUEKT+LdA6ACAeJg8TF2Z2SFMWNqbieIyC5BWVzRbfiXL50xT514sit2ULTlNCMLNsKbHTEzNGvhdY1K8N+ApLeaJyjd/SEmeyMyhaxUn/jpi1p8DmTLZj61hxeZcEAcOYM5rlTzyifggi58LCBO8ffbs02EMEQgKkilygBPzrr7WTtxKvFKnqn346FUPcl2ihNqHcdBNoHUGhN8z9FYH9uV5krkdV8OdChS//PGs2ZPNzz1NM3b0X9dCUoi96cBDamN9yTizUBcjgz/erRpdoUdPFjWacSD332cdFyhejaG8epaAj0ZYuQ8qBsbZ0JHMDAzPJbAuDIqIsXWBarFW8Lys8ResOpWBxL3JDMR8iFMJP5VS3Hoso5AYovaC+Tudgkte4z51h1mVXuxlCSOv44wxrx/ft9czBPcZ0HBCZhiVQvwSm2DzL7Pp7ydyoinXxMKZvKdP/L9zTDkULg8npVLMGONfpjlWW0uV4Ia9TR4AcK47ADfWqsJGVD0MUKCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(8936002)(41300700001)(4326008)(66946007)(8676002)(5660300002)(316002)(54906003)(31686004)(110136005)(2906002)(66899015)(53546011)(6506007)(6486002)(66556008)(6666004)(478600001)(66476007)(86362001)(31696002)(186003)(26005)(30864003)(83380400001)(6512007)(2616005)(38100700002)(36756003)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBud1ZtRFZxdUswTnZpMjJlL3Y2bkFDVzROVUJON1ZpeENyRlZ2Wkc3K3p3?=
 =?utf-8?B?YzJJaTk0K2kvQmgvTGVmZm9FYzRMbDZVUCtJWHNCaXdSWVJqc3FoMnk5UHFE?=
 =?utf-8?B?SlNVd2gvVXAzVVBDR3JPamhLMHRLSUpURCszU1FZVFB0ZkluTS9OaFN1emV6?=
 =?utf-8?B?ZTdHK0FHMXFRSTFmWHNFNjZwS1NOQWN5a1VmK0ZiZGR4THVOcUpPaU9IVW1W?=
 =?utf-8?B?d0dOOVB1ZjFFNDRRdXlIeGRrSXR0OVJpNnZLQjZaYkxaNUIwSDdJa0VxYVNq?=
 =?utf-8?B?WG52RHNBeTVzaVZJUjcrM3RiWGZtOGJ4ZS9yT1pibmlWcVlDMjBWUDFWZEVx?=
 =?utf-8?B?bXBmczZEdUV5NXEzRTViYURwSWl6U056ZDN3dlFVMUlGbGdkU2NsL2QwS3k1?=
 =?utf-8?B?eVZVRE8yZXp1aC9OQ21DRFlGbUhsM05FcVE1eWdLWGhsVHdDekpuQ0RzL29W?=
 =?utf-8?B?QXVoMzAxUnJRSTRIdEZwRVpLZkVkZmhQU0VNTlB3R1lid2hKNGpGa1NFVVVM?=
 =?utf-8?B?ZllXdEh5VWk1dmQrVFhyZWNxaWw2Kzc2bDNiRHdqMkhHVlhITUNtUHdjWW9l?=
 =?utf-8?B?MUREYzEzMzJtODEzRWxFUGR4MTFEd3hKa3JLRm9qMXFyVWMrUWcyUk1TMWR6?=
 =?utf-8?B?QkxnNlI2K2hNWGVicWhQeGF6Tk0vUEh4RStyaWtyUnVYTlYzSTd5TWRmSUhE?=
 =?utf-8?B?STFlNDA0SDJXUTF3QkFVNnRaVGxQWXNrdmZnUnBXOG5HelcrVlcvKytYTDRq?=
 =?utf-8?B?WmlwUncyR0RPRDl3Q3hwTHBQejBKaW9OZHF0Tm1ZSUc2RXNwVTE3NEkwU1c4?=
 =?utf-8?B?SFlDYXhBYlNWQjVLblpjaVdmV1haZnlMSHB6L0QyTzlDd2M3TDFIU1NDbmJK?=
 =?utf-8?B?NDhYeXpjZlg4UjBIM2VLLyszVEI5MGg4am5UM1M0WUpYRnJQTHFVM0N0OW9D?=
 =?utf-8?B?dENlbVo3RXoxNmh5NXNGU09KN2hJbzRJTGJyeXhRM3pDNnMvR0F4a0lOK1Nk?=
 =?utf-8?B?ZUovc2hQbjRSZUFGUjFaZHp2Q3R6d3FvWHJHS1hXOCtYS0c5QWllL3RzeHhM?=
 =?utf-8?B?TjZOam9KL2hRdlE5R2I3V3NnOWNMZmdaZFFJOTdDSDNPdXdPZDhMSWtoYS9R?=
 =?utf-8?B?cWJCNjlqSHR5ODdlSXB2SmNUTTBHM3RmZERZRlpMZmZ3Q3l0Sm5BUHU5N1dh?=
 =?utf-8?B?OXdmVFFqazJDMzlSZUhEWTZzNkh2ajVwOCtlL1cyc3gzcW5wQzJSSTJLYkxP?=
 =?utf-8?B?aU1UMFNwWHpFWldWaFZzREdoaFZ4TkJvdDMrU2FYb2xMTExXaEtuY0ZTZTlo?=
 =?utf-8?B?ZW9pMjcya1hGMmtVOFhJbDV3ZmVxbklnTytxcGRkbnZxVHpXa0YyeEc1N3dH?=
 =?utf-8?B?dVB4cWFQSTNjU1RDcGlMNVMyRU9NMCtPaHk2cll3QmlMNHFnd2pkNktzR0hv?=
 =?utf-8?B?MFY1bTJoWU1IMDd5c01lcmVESC8vN1ZKbXlNNnRPL1R4SThvMjdiRFAvL1JQ?=
 =?utf-8?B?dkFJNlRKN202cTcySG1WeWdNTWpZU2pyb0F4UXpmYmJhY1ZBWGoyc0pXMWFX?=
 =?utf-8?B?UVBzSnhkR2FaRHhKSUZCTENhZWc0M3lFYlRjc2gwVGhKWkFtTFdRMGl4VTJs?=
 =?utf-8?B?MjEzWmNqRnJKelloUE4vRFhIbWtjYXdwR1V6U0J2aU9JenhjMWQxYjNUME1P?=
 =?utf-8?B?NCtHOXFaRk1Mb2tUVlRFSjFlN3FvbngvU1czREp0UFJQOG5YRFJJb1hoTXNT?=
 =?utf-8?B?bjN1RFUvdngzN2VhdFZiT25zN041b1hlbi82eWQ4N2FLaHFObDJUbmNadzRN?=
 =?utf-8?B?ZE9FbWEyZVhqdXFHc1Y4a20vQUpJRS82dUg2ZEVML2ZRbkZwamxkY2ltaHAx?=
 =?utf-8?B?bEZJc0JaeVh5NWx5VEYxUnJ6WW5BV0phNHplM05WSkRTWEo5MFAzanFrMjMz?=
 =?utf-8?B?clJKakE4NmoyVzBVbXpsNytwaUNHRjAyQVA1V2k5dFhhQlAwV2Fza2pUTnBV?=
 =?utf-8?B?eW5Nd2IwTFI2ZU9xYWMxdnBwTDByZTczUkpld0ZxZlhiOUx1bkZIR1dkTHc5?=
 =?utf-8?B?dkFsWnBxaWlTc2hmL1cyWkMwZFZRejVkSkxSRE1NT0pDT3cwWERpVW9ZVXZX?=
 =?utf-8?Q?qhz6cRrleHVbZFB4Ioxj+VZwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cddde3d-14a0-4461-70a4-08daee31d45b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:58:21.3040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GkPt4cGZ/4cSP4LM7/d9lG7deDQiwmKek+pb6bAULV6uikwUbuB/dsXPvwj1ts6G9S7JTr5cBJmici0NrtTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Jiadong,

Please check the first patch of the series, where we added the UAPI


- Shashank

On 04/01/2023 09:55, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
>
> Hi Shashank,
>
> I don't find how amdgpu_userq_ioctl is called, shall DRM_IOCTL_DEF_DRV(amdgpu_userq_ioctl...) be added somewhere to expose the ioctl?
>
> Thanks,
> Jiadong
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shashank Sharma
> Sent: Saturday, December 24, 2022 3:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Subject: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
>
> This patch adds skeleton code for usermode queue creation. It typically contains:
> - A new structure to keep all the user queue data in one place.
> - An IOCTL function to create/free a usermode queue.
> - A function to generate unique index for the queue.
> - A global ptr in amdgpu_dev
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
>   .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>   5 files changed, 246 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6ad39cf71bdd..e2a34ee57bfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -209,6 +209,8 @@ amdgpu-y += \
>   # add amdkfd interfaces
>   amdgpu-y += amdgpu_amdkfd.o
>
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>
>   ifneq ($(CONFIG_HSA_AMD),)
>   AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8639a4f9c6e8..4b566fcfca18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>                          struct amdgpu_mqd_prop *p);
>   };
>
> +struct amdgpu_userq_globals {
> +       struct ida ida;
> +       struct mutex userq_mutex;
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   #define AMDGPU_PRODUCT_NAME_LEN 64
> @@ -955,6 +960,7 @@ struct amdgpu_device {
>          bool                            enable_mes_kiq;
>          struct amdgpu_mes               mes;
>          struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
> +       struct amdgpu_userq_globals     userq;
>
>          /* df */
>          struct amdgpu_df                df;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 0fa0e56daf67..f7413859b14f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>          unsigned long                   ras_counter_ce;
>          unsigned long                   ras_counter_ue;
>          uint32_t                        stable_pstate;
> +       struct amdgpu_usermode_queue    *userq;
>   };
>
>   struct amdgpu_ctx_mgr {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..3b6e8f75495c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_mes.h"
> +#include "amdgpu_usermode_queue.h"
> +#include "soc15_common.h"
> +
> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a,
> +sizeof(__u64)))
> +
> +static int
> +amdgpu_userqueue_index(struct amdgpu_device *adev) {
> +    int index;
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +    return index;
> +}
> +
> +static void
> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct
> +amdgpu_usermode_queue *queue) {
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    ida_simple_remove(&uqg->ida, queue->queue_id); }
> +
> +static int
> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct
> +drm_amdgpu_userq_mqd *mqd_in) {
> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || mqd_in->doorbell_offset == 0) {
> +        DRM_ERROR("Invalid queue object address\n");
> +        return -EINVAL;
> +    }
> +
> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || mqd_in->wptr_va == 0) {
> +        DRM_ERROR("Invalid queue object value\n");
> +        return -EINVAL;
> +    }
> +
> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= AMDGPU_HW_IP_NUM) {
> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
> +        return -EINVAL;
> +    }
> +
> +    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) ||
> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
> +            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
> +            return -EINVAL;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
> +    return 0;
> +}
> +
> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
> +                            union drm_amdgpu_userq *args) {
> +    int r, pasid;
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_vm *vm = &fpriv->vm;
> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +
> +    if (!ctx) {
> +        DRM_ERROR("Invalid GPU context\n");
> +        return -EINVAL;
> +    }
> +
> +    if (vm->pasid < 0) {
> +        DRM_WARN("No PASID info found\n");
> +        pasid = 0;
> +    }
> +
> +    mutex_lock(&adev->userq.userq_mutex);
> +
> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        mutex_unlock(&adev->userq.userq_mutex);
> +        return -ENOMEM;
> +    }
> +
> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
> +    if (r < 0) {
> +        DRM_ERROR("Invalid input to create queue\n");
> +        goto free_queue;
> +    }
> +
> +    queue->vm = vm;
> +    queue->pasid = pasid;
> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
> +    queue->queue_size = mqd_in->queue_size;
> +    queue->queue_type = mqd_in->ip_type;
> +    queue->paging = false;
> +    queue->flags = mqd_in->flags;
> +    queue->queue_id = amdgpu_userqueue_index(adev);
> +
> +    ctx->userq = queue;
> +    args->out.q_id = queue->queue_id;
> +    args->out.flags = 0;
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    amdgpu_userqueue_remove_index(adev, queue);
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
> +                              union drm_amdgpu_userq *args) {
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
> +    struct amdgpu_usermode_queue *queue = ctx->userq;
> +
> +    mutex_lock(&adev->userq.userq_mutex);
> +    amdgpu_userqueue_remove_index(adev, queue);
> +    ctx->userq = NULL;
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args = data;
> +    struct amdgpu_device *adev = drm_to_adev(dev);
> +    int r = 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r = amdgpu_userqueue_create(adev, filp, args);
> +        if (r)
> +            DRM_ERROR("Failed to create usermode queue\n");
> +        break;
> +
> +    case AMDGPU_USERQ_OP_FREE:
> +        amdgpu_userqueue_destroy(adev, filp, args);
> +        break;
> +
> +    default:
> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +        return -EINVAL;
> +    }
> +
> +    return r;
> +}
> +
> +int amdgpu_userqueue_init(struct amdgpu_device *adev) {
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    mutex_init(&uqg->userq_mutex);
> +    return 0;
> +}
> +
> +void amdgpu_userqueue_fini(struct amdgpu_device *adev) {
> +
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> new file mode 100644
> index 000000000000..c1fe39ffaf72
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERMODE_QUEUE_H_
> +#define AMDGPU_USERMODE_QUEUE_H_
> +
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_usermode_queue {
> +       int             queue_id;
> +       int             queue_type;
> +       int             queue_size;
> +       int             paging;
> +       int             pasid;
> +       int             use_doorbell;
> +       int             doorbell_index;
> +
> +       uint64_t        mqd_gpu_addr;
> +       uint64_t        wptr_gpu_addr;
> +       uint64_t        rptr_gpu_addr;
> +       uint64_t        queue_gpu_addr;
> +       uint64_t        flags;
> +       void            *mqd_cpu_ptr;
> +
> +       struct amdgpu_bo        *mqd_obj;
> +       struct amdgpu_vm        *vm;
> +       struct list_head        list;
> +};
> +
> +#endif
> --
> 2.34.1
>
