Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 21:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E196364F0B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 21:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E196364F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4F36E0AC;
	Wed, 24 Feb 2021 21:31:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EF76EB2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 21:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmVa3BmiV+O0l8B+NH/8m1DdZ4x01yNg1jhZ2tZHv1DAUQuL1MPgg4oXLRAgUq0eF/kIoUoFKx04Spm6VGUbkqfET49WhEurICpJsrQ4HmniHnPCPchJt0RN+5ho5EZ7Ipty+XLE9zpcBCtxEgpI5xra+XEl32RQu8K69546ecchTu0QiotdnO7XDIRg+oIuQbhrgF65j0vNAqsPMELvYDUcLutW6TCmm73+CR/XVqVOfDhrx4X/ONzxsjcO+Z6757pBVAbPWXVT/QYivPaQe9ZWkqeigN1edo9tFTC8q6k+tx8Q/0OZ7VuDOtLmV9jw8MXrphk6KDTDQrso09yzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaABeLRjgaQH04OcyjcN7OZ+95gqrJsK37ec93eoctM=;
 b=iTmx8qPzs5tCYNUkVUMj8SIPqMAUtitjSA3jQmBSLcOO+yGIjwrMCyqHSfKtdijz4E8HKvxDYDNm6ljqMB7t48Om7zcgJSTcC5VMIWa9JTIn1OfzzwMyDQCcfrwbffLsY7ys7KKNnb33OMjcz+nfo7guXp7Yw733eno4sc6CDFdZYor7J9/9obehowPir8eyqjpM7OYYH1m2YS8xf69UB6cLNUfuGccqZ3LCamI/D8VZkhQFxPcYDwVmfMmXTITdgWf8g482H/AQlN0WMn+6BebuDX+jEg8C1+5TeGcJlfe93ozVnqGLj/mHiCsS99XyKKq9Oq0cJOjy3jdCsv0mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaABeLRjgaQH04OcyjcN7OZ+95gqrJsK37ec93eoctM=;
 b=g36WBZ5ZxK4Pu3TiKkQZsaO5zMKjefVCJfBaIl5SZ7PGAtB/BPcuCF4Qw10tBo7bYhkINgbu9CbByOZSFN0u7zH/EMAYz1sZ7u6VcxWxjJdp2eS6nEKDRERpyolLZsCaOcQRkZ8Va+Yit5CJykeG1nfNvN0FdaHt3+jTRLx6S/k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1417.namprd12.prod.outlook.com (2603:10b6:3:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 21:31:47 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235%6]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 21:31:47 +0000
Subject: Re: [PATCH] drm/amdgpu/pm: make unsupported power profile messages
 debug
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210224172858.2779680-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a67b669d-bc2a-5c07-4352-286ffeb45071@amd.com>
Date: Wed, 24 Feb 2021 22:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210224172858.2779680-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.239]
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.239) by
 AM9P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 21:31:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19096e89-20b0-49a4-7e25-08d8d90b969f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1417A2FC09305C4EA80CBFB58B9F9@DM5PR12MB1417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UE6IFVMYARtlaMjdas2vRJ8//i874A4+RXkDGj/QzEmAcxI4mTgluN2m2buoYsC38riizx3NGtBN+RKggBnkhwjIe9DiqkO2mMPq2Gdzh5qtR790WzWqPDDd22J7mPybEf2vmKdMBhafW9i+44HL7CN68e5op+dxW5RPpjnlpXcpbYvcGN/JX1sVEp+QyvwTw3Y3OHTn3Io4E8Q9qsSNDo20lEvV9dT5o6YziXBjF/6ot50itjwXi5cNXZMUvbY+uJsWvm3IkZpaeOmChWJAFUvLrJpGJIyDn2XZ84lzwhfxPdqehfhZXYsfTd8wiuu6X3GMtqBUWy3ASxeed/DIPsVvmut/Ahj6phZgHhTcUef9MUEYusFJ5o1h/iXlmbJl3tabZ97sPcup8et8qXyJDoorgx9s5rON5HrfbDGK/wQ3X+yacw0Ysb0OInizJdswvXDr6C/8B/cswxGAYsLd8wGDcZGgj5EfZosPrPLfZHZjhBU+s40C4EBBsig1JKSQNM4VyL+94r5Sz9mzcAdHFG7ubp1rNKUAaVXgPdMzwY+zA4XvKfbMUMnUlbFQuzRntgG2HcUwlz6OV2DAHcmqYvk1gEfnmvPsKWpdU1NHTkJ9HW8gC0np+E/bB8DD7thHTttxf1fNvwaNGXkQEyAuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(16526019)(186003)(966005)(316002)(8936002)(26005)(66556008)(66946007)(66476007)(6486002)(956004)(2616005)(5660300002)(4326008)(83380400001)(52116002)(6666004)(31696002)(478600001)(8676002)(16576012)(45080400002)(2906002)(31686004)(36756003)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MTFTaDVCUXNFa0cyOWlKczdObkkrL0dVTHhnNHBNU1FQU2RHTXNJY3R1K3hZ?=
 =?utf-8?B?MjlGcWFYa2xuYkFVTjdmQmppdndKa0pVUXdMWkp3M3J5ZUNvZVkzYTB5NkRq?=
 =?utf-8?B?YXY1UHpEOEY4ei9jNFVKVVRDUGhmcWJGYmkzSG4xK29pU3ZWQW5IWFBkRU53?=
 =?utf-8?B?YU4xckdBeFN3NmRPbm1KbWNWQ3h5L1RuekFoKzg3OWV5VzFFTE5qWXdwVkhq?=
 =?utf-8?B?UHFCM29ONHJ1S1dmbmZEOFFiQ1E3Q2NhL1l3WXZJUkJkS21FdktNZU1jWHQ3?=
 =?utf-8?B?QWl0ZmdheDJndzZsc2tRa0pvckZVSE9yN3h1SXF2aFV0QWNiZFlvMnNsZ1dh?=
 =?utf-8?B?akp5RE1hY0QvMVgyOFVTYVErUE1HeVY3eGFiNWlsci9iVXlYUXVtQm03MHZX?=
 =?utf-8?B?ZklINWNZTUEyTTExcUJiaVQrWlBYdGRleGp3QnZqdmFCWFd2MGxJQ3VpVkdI?=
 =?utf-8?B?V0hoTkhZY3Jiak8vcW1QVUtKbzFVMTVXY2w3N0I0VC9aZDMyQllmMHpzcmZD?=
 =?utf-8?B?UmJrSDJPMWgrbmRrbTNiQ3VYT0FkUjJvcEg1Tms5MHUyMDhFR3FYejFzM0VC?=
 =?utf-8?B?anBHK1VIYnpYYnVKZzJuL29SZnZaT0tNLzJ4RDk4Y2U1Vkh1d2xkTkQ5aVM2?=
 =?utf-8?B?aUxFQ2xWaXpMUXJPMkpGMFVqYWtSanZKZkdJRnpMRXdNZ0xXRGROKzBDT3ZZ?=
 =?utf-8?B?YWFDSzFKakJOTkQ0Rmt3Z09QQ1psempZTmg1SDVablVLaXBQcUF6czVJNmdQ?=
 =?utf-8?B?ZkhKc2VPR3JhczRVay9KZHVCNS9sTVRPZUhHZHROZXpvSEtQeC9DdTR4Zzls?=
 =?utf-8?B?cEc3TmNNcVhiR2grRkJ2MTlWU0xJL3BYMmU2ampBNkNnSVF1YXdEaURZVVNw?=
 =?utf-8?B?UEdyK1h4azFlUHQycVo4YTluNzJGalAzdDNOUTFaSy9RWklwdEVaT3B1Qzls?=
 =?utf-8?B?OU5qamJmeEMyNmdxNVkrenFXVTNTUnJnTUdkSHdGeW00anJxNFJMZUpPWjBm?=
 =?utf-8?B?c3dhWjR5ek9SKzVTb3ZaenFZUFpDTnA3ZlU4NEY4YUZNMzZNMWovYlhlSy9p?=
 =?utf-8?B?V3QyaWdobytNRC9PT3p5WU1oUkxTYWpPVDR1L25vT3c0dnVNNG1SaTBsd3lH?=
 =?utf-8?B?RjRtK2VVUXNURTNzT3A1RXRVdEs2bWhVVzJ5VTBodGNVenk0eUk3cDlaSVl6?=
 =?utf-8?B?Y1puUUdWbGJxamJRV3NKYXFhTmRKZHdJMWl4dkRXTlRnaVllcHpjM09yVk1W?=
 =?utf-8?B?Z21GRHhJTktSWWoxT3pWcDd4VlBtNW5hVUUxQ2VSOVIvMHI5TXJqdlhFTzN5?=
 =?utf-8?B?OG0rSkV6T1ZpcEcxeWpzS2tBSURmSW9udDkzQzhDMjFrU0NOeU8xMDJ4bXUw?=
 =?utf-8?B?bEJoeG9oYkIrUkdjZ1BtNzVTMGdMbnhuVkxFZXJTdFBwd0krSjlkM0QrY0Jk?=
 =?utf-8?B?U1ZHYXVkaHpXRGhjN0hqaGFvZ2o0b1ZiVlczcXVtNDhtamFmRmhheU9LZ1Y3?=
 =?utf-8?B?QUNlbjJ1YkpxM245ZXgzSGtWbHJmcExVamdxdW9yQkhmVEV6UjZmU09hUHJN?=
 =?utf-8?B?elhSay9KVFhKQjBhZVVLUTBCVzdQRFdWSFpsWTd1YmFYNXd0K2VDTXNEVlNo?=
 =?utf-8?B?ZU9uRjBZOWFMckg0YnB6ekd5OTl0cE8ySjNPbnlvUE1oZVhoYldRK0dWdS9a?=
 =?utf-8?B?Q3ozS3lxVnVIdmlyK2h3WGlLUWVIcFNyTS9CQmVLUkNMbkdxYUlnNnh2Qkx5?=
 =?utf-8?Q?vmJ5J+u8m9KUHqm4yttx28GCoUR36gVNs1ObehB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19096e89-20b0-49a4-7e25-08d8d90b969f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 21:31:47.2235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTujPyt9nVEyVkuFYJGcKUwSGXV7d+RbIR7AO+bL2n3ReoXpCk8xiWX1lNMwCq4Z/YbgB8pBIKcBiJhFhgEg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 2/24/21 6:28 PM, Alex Deucher wrote:
> Making them an error confuses users and the errors are harmless
> as not all asics support all profiles.
>
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1488&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C4e46d63ffe1d4cdbda6608d8d8e9b2e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497845534449026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FRCM%2FzZyJtkIpdRDsN0UUxZIT1Sqd6HwSbman36vveQ%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 45564a776e9b..9f0d03ae3109 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1322,7 +1322,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>   						       CMN2ASIC_MAPPING_WORKLOAD,
>   						       profile_mode);
>   	if (workload_type < 0) {
> -		dev_err(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
> +		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7b7ae5532ddb..fd5539f8b53a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -810,7 +810,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>   						       CMN2ASIC_MAPPING_WORKLOAD,
>   						       profile_mode);
>   	if (workload_type < 0) {
> -		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
> +		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
>   					profile_mode);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 9a8b1a1e148e..c9f766cbe227 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -826,7 +826,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>   		 * TODO: If some case need switch to powersave/default power mode
>   		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
>   		 */
> -		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
> +		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
>   		return -EINVAL;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
