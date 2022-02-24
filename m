Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFACCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 03:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9B4890B8;
	Thu, 24 Feb 2022 03:49:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE2E890B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 03:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1jkTa6PYrN9M0UidiPOdPpnCjMDOeBDGtHrvhy44IpEgwdnpOYMTY/dH9bUkdPX+tP2mwecIG58Z378hJIRGmxTKdwxcF4ci1PPD9LGhwZ4Q6jaal/CQ/6cj4lPBayTM7u8w7n428ymKf7iyi7XIsVPSdNGjbMfAIayPIN/J6+Bsc+/t3SXJjUKortYvV7kG8W+V9hWv095M+IM5mi4AIq/HgklK34IQRKDH6ZYh/gKQUnKFy2omqPZTQ70suWI+SfmckDTjaD30Os6RURh/3NEx9NMCxtskw0inDXsHKanFXLYXYzShZygAQKKFs9RXandgy4xFLT5o6IAdRHQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER32pUvzF7oHIoQ4AsU231IcmR5jfhivXlTjVq6DKi4=;
 b=UBmoBWmVBrTzia7ml9ARzVEHl9rzJmpUCJGeB6ww4ia+0PFE754/m+sI0Z1N7f4YcZj5USnefed/kSh18i9+TX2Jc4hWNLAK46tg4Tfs1lfS+0oGP4MD6ovNCGf++RbT51Omc+hbYI+JrxeqcUzj6+pDEqipXIUwdxdOf6Q1+nJSwKbwcPqXypJTYQKa8TER6SZdlPQkwi9UpE5d2UZYtPIpsv1Leo8+1dcGGra+YROYM7aoOX4iwfwkF42MJpLKk0XQwFovjIy3sz42RQQjZva/iyTUpxZFc7iEt7bPKjSxv3M5fOleHaVTjFwvEZ7iMu5rZ+Q4vCc3CMWj1nq2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER32pUvzF7oHIoQ4AsU231IcmR5jfhivXlTjVq6DKi4=;
 b=SAXIc1LRWMxij459pummyku43fQPYOvzAZpE/iDLsQAK29PRwKnTUB4C477WrB951pJd5D9FYyOp1vtUpZvfdff1UBIg6gCo96dKgzrer7BrcqPYMMAdqvZeNUxijhlc78sYb2diCzq0fh9f/7W0tEbtSPZUqI4lUIgqtqEBKmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CY4PR12MB1559.namprd12.prod.outlook.com (2603:10b6:910:c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Thu, 24 Feb 2022 03:49:43 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 03:49:43 +0000
Date: Thu, 24 Feb 2022 11:49:21 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix mode2 reset fail for smu 13.0.5
Message-ID: <YhcAQWU2QkCEjwmB@amd.com>
References: <20220224034543.1631630-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224034543.1631630-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cdd876-00aa-4374-45d9-08d9f748b135
X-MS-TrafficTypeDiagnostic: CY4PR12MB1559:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1559678F38DECD70CFCE2F1DEC3D9@CY4PR12MB1559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkleFDinqp7AEqydKvh6qRTqiFC2Kz9gf0sGka3h8Y1/apdRFMCsOJLDlvCSQEUiiU1CxmXTj7e4p7VyR6s+ZlTwq6NHHGICSej6MdlKEEhDiQ0o0+pdz9z9enjkJO7FRRFknum761a9Q0EL04AaJGjQ5gq0m0hYNtPuTv5kp9plUDP1VmwQPhMo4SBQ844nrpSC1uTr3z8eQnorxRBuNlYExuylNBC3aKuRtX9qrHOcBcHwqZ0kTrGmcaI7x25ddQ5gYtctLlyM7nJN7mshg/7GQcGRhmic+laaAFN9HGVSuwpf5a1crs8V8UdowAR3t9dc92LBUWHLobWy+JwNgJZw+y73v9mZxpgHehoFcwTlYaKmWWW4zZYioexZxiDhVw21Vwkc37BipyxqD3NTZUYpyRitsDPkHAYUBIfMdST+l2IsZE6tE/Z1AiqxrG2AOU2RnOqZ8g9SM7e1xbbbKt75EdIZ+6+T9tPunGjkd7OhplX9ildx5eJNvu1n42PJVe8vVtqEOoLmKcHAeyW4TqMaY25YGNsUCdCtsCfrxU1Gw7Vpm8j31SL6oJlHClbNDOkxJ71El2BUQdkXUHwMcr7Cum95Y52PezatYdj0ogw4iu3ZAjfAjfJcYYri63qSeXQXLMe212+QGJEpDxwbaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(316002)(8676002)(37006003)(508600001)(6512007)(66946007)(66556008)(6486002)(6666004)(86362001)(6862004)(2616005)(6636002)(54906003)(6506007)(66476007)(83380400001)(36756003)(4326008)(38100700002)(5660300002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFZm5QvhIm+iPDNwkec9A3aqkQLWqmaHarGw8k4stQ+XxVzJQu6w6+P5gjLp?=
 =?us-ascii?Q?y8MBUpMlkFkP+tfoOIhgRO0G0jg14EaIk9+pERgZqfO22Qo7Q33FZFEM1NAu?=
 =?us-ascii?Q?htuZaNIIyaQATgcUMChc5YKhv6rjkG1v+39nnncD1WJ1TiM/cf9x6hiJt1Za?=
 =?us-ascii?Q?YAKKbnNZlZWm+z2Hwpijeqa/vRpuqXGn5YqBSaJBZMBLz4rTkra+Iadkthn0?=
 =?us-ascii?Q?YKIJ/6EdWL1KMI0C0spSKXM/KrM6qNibnW9flEjI285DBLtKnR6GLv4T0D/L?=
 =?us-ascii?Q?keQYWH9TiETXdwI3lwq2U1WiLr0VSO+/ZfR1SbKxHs1wfugMxvZCQPERXWAp?=
 =?us-ascii?Q?se64UZ09EnmuMDGR7vMcDjmmYB7DZ6xQ9tTqlpS4gkPk1eziSUyXbsmNBme7?=
 =?us-ascii?Q?DXpdPnO5HU1qArIcqcogeAlcqjor/jHJGo8zDXWu945p1SR87wWtA11bAMGz?=
 =?us-ascii?Q?aFDmbRl5LmQYtmcxkqNr0z9o4/Q3xfrWYBl2AgzFqInQFdALXvlMVxlDy3Ys?=
 =?us-ascii?Q?sf+5oJbkZwYQWm1uT29g8SZjki5F1Sij160xVbb4pNQu469h4luiuKCPPZDT?=
 =?us-ascii?Q?T3MU/YiZGiiAR61ir5JBd1LNJ2fLHPFtkLxWxtYlFegdjtsPxF0BPfFQvODB?=
 =?us-ascii?Q?BQuCHFog8bGGbBja+843b1BKl0zslFd6iqip3Bhxdi6WZUDnG7P141gUqgSn?=
 =?us-ascii?Q?RIuJHPc02U3XmsnZLasBiDVDe104agy10sOqWi/5er2wrxn4zkNVVRcX6icK?=
 =?us-ascii?Q?iTxhi24N6wtzk5r1XQHV3XKS2oPl/IVZt0bCiRl6JcNn0W0GxtymqdZM62T0?=
 =?us-ascii?Q?Md0gTJnVk+hXv74vfVff/BAT1/Y1m2hc8AkAUvvt+0xbEfDjUckWfgQF9se2?=
 =?us-ascii?Q?FaFKPEpv8QAXlzVq481GqzvPkKjX1ueJ9I7S7cJKEKOwE+9X2q/B6ewwUqBr?=
 =?us-ascii?Q?0DqyLDH1qIYsuYoAd21ib4YVQC0T9wlIIchofeCmyjckFbNk5ugFLo28PWxZ?=
 =?us-ascii?Q?whicyovkgJLiYP9zwOhktk0RT94ZfACCahcAi5SxP8tc6OdlEVQf2U4QYGHT?=
 =?us-ascii?Q?c+OKM6zJEHAlds3JU54TNySZCv2xiL+hzNZFPDKs+4ArdyQ+FNqMwXeXHt8D?=
 =?us-ascii?Q?lWr2yLQqmUj6tAjZde+nxxY7ziMT9iqw1vrfMPYYaRQu5Jpvs4+nOo3QrIFD?=
 =?us-ascii?Q?MedPgIzvknSMtdZi+7VordGEMm3J1IfBrkWBs1gvBUbcy4sTtPqGifzoAe+v?=
 =?us-ascii?Q?UyxqZSQj/CzUtqQHhRzi1cSZtVCz8zUKIhQ34Q8PG4dKKwP3V2q7psYr7CCG?=
 =?us-ascii?Q?LBLBlFPjgujqDIjbNbEThqKlUQKuneasraqoC51AOA11C/YRHg0Rx2gAvtYq?=
 =?us-ascii?Q?ExuMFP9wC8Tqo8lIBazuo1DVtEP0b9nKW4oNaKavnN8PjymgxjTXmOoAF8iw?=
 =?us-ascii?Q?2plJBR8AFrdSl5guiES2MEgjkVUILyZyrHO9wjiVJrQevGBcKGOeTuQM6K/f?=
 =?us-ascii?Q?iJF8mTar4/eMoY0389K0HsUGUvT+cq19J+hjFrE02CvniFRk7Np0e70t2C0I?=
 =?us-ascii?Q?1CI+J4/Ij/nbDTW+50gIISef+fP8v6/DcbldWEfSItnkcn15zXwqTKQe4nPT?=
 =?us-ascii?Q?8uR8QelMkXPyrpRY3fBao60=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cdd876-00aa-4374-45d9-08d9f748b135
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:49:43.3337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3Xxx0NZWkf5Th5iwhkB3Pu9c+cLIA+DvytiuEJ944Sw0vGZmmq6nMcJJ1voVYMwE9KYO7zEqWgy77/37V7pnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1559
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 24, 2022 at 11:45:43AM +0800, Zhang, Yifan wrote:
> SMU MSG index should be used as parameter.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 093b9144464b..8ee5bcb60370 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -245,14 +245,9 @@ static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
>  
>  static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
>  {
> -	int ret = 0, index = 0;
> -
> -	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
> -				SMU_MSG_GfxDeviceDriverReset);
> -	if (index < 0)
> -		return index == -EACCES ? 0 : index;
> +	int ret = 0;
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "Failed to mode reset!\n");
>  
> -- 
> 2.25.1
> 
