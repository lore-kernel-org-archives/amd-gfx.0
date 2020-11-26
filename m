Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358BC56201
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 03:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E6621534
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 03:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C7DnqGQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52806E4D2;
	Thu, 26 Nov 2020 03:11:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9D36E4D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 03:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTNcorWq6Vk+Kqa0nW7eydP2fLCDWch/GtVVwwbk1PGhm00BlICLT9a1XJm7MNB+3Ky26e3QySPp9juRkvytXtVtZeQL6i1b4ftmH4Z/qQaZBrSw6mpgSE01Lp61NRlqbm9iejrUiCknU5SIXrTKzeJExWL1es4uKJTgS4hLZGLZrEtS1S9pHp3XiUtbRXxcZxGX5K/WfTEN07ZAC9+3RW4ujF+wGVE22AR0Myy3a7FF5cMOmKxMSuQBgmuCqy5sbprqScyvcT9XjieGpRFKY4BHEtunNKT+rOIuAcP5dWWTI79dG2hhk2MeJFhgL+rxlox4mV6vYchT5aQRMZh2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHp8gE8GpiLd86FyE7pNaO6UXSqMxhAHb33OLJEAQmo=;
 b=R06lcGxleUPK4zrbA9XWuD1IsK4SxK/2m0+Fpq9LqWa8hNRhtXzTYEEk6cR2cJ4I8eVvoEo6TgHaWBgpMtLRrdWN/PjL9ffP/+zM+DXjAWCx9JY7mqaLe6WJIHa6IcUYKSu+hUBi1VeigVhjtNpq3J//4TCey47lKiOjxuc90AiH/zjdEliBsIElglhxu1P8JB2vumiL4tp20l8VDjxfxZuP2ygP8H9aD7rK0B9CwM7B/Q90H2X1uiIFWePO+MZPogCf5A9odP9lSzEwsqU9TVYIuPYQ9RKngAxfxJGH8uLIV0JqMJ+9QXmdqY03tvoz0PBnpunVYFwUqmBI64BSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHp8gE8GpiLd86FyE7pNaO6UXSqMxhAHb33OLJEAQmo=;
 b=C7DnqGQ6j4wchrw2sSzo4i3fvGmYFhofSiV6D7I3AsV7S2tqcYIXnXCzH4ibYQcbN4dh+xBcaM5GPDhSxEvPX7t6QtXUOwzf3wI5SJAWuIc4dhX0KQu6hBHc0JOXQKd5YI6QuP/o3lBzUQco5ko+6KhsRur4Vw+lF0ZjgLnZpQI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Thu, 26 Nov
 2020 03:11:52 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 03:11:46 +0000
Date: Thu, 26 Nov 2020 11:13:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: fix mode2 reset sequence for vangogh
Message-ID: <20201126031311.GA587229@hr-amd>
References: <20201125162132.237264-1-alexander.deucher@amd.com>
 <20201125162132.237264-3-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20201125162132.237264-3-alexander.deucher@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 03:11:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3b3376e-a7a3-4973-5aff-08d891b90220
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24603646D319185DE31EC63CECF90@MW2PR12MB2460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nb4bY+q7P12xMxTD3OGB6iHN/FMkWCpqJK9xP436YATw28G+KwwPjvvR0C18nJqaN+9IG5qiSotYvltWk+siVqkirQ/qqvkHqCqA68XxC4Pv5Bzp5ZsoWG25eMzOWxldihmUm3onYuHwis9r4b5BUNLgXWpLAhoyw/Tyl1fvCHfa0vaWo0hcpyfm07sM0WBomPnYYt9R1n9xDFjL1H0VMsLjAWeWxmnGLOfVfkuCAxC/+8PbmU+/xTpTVrztKXXww+KsTIe0R2tn4Lkh4CW++TshTEJIOlbYtOAW0N9hIBx/9uK4pWumiGMGsyZErgMUvbQExXrEWtjVEuNJycuAuMMGklhaTGx77KpZvzDGdy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(4326008)(52116002)(8676002)(55016002)(956004)(33656002)(8936002)(66946007)(66476007)(9686003)(66556008)(26005)(1076003)(5660300002)(33716001)(86362001)(83380400001)(316002)(2906002)(966005)(6666004)(45080400002)(6496006)(6916009)(478600001)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oDFr+XwIin44qp7D7glNE6LVOpK/LEnu43AW4tg/co84PgG+W21AT7UJVw7H?=
 =?us-ascii?Q?uWMJi0owu14lX3hoQ47VggzZDArBZXSm/DHI4UDOKq7sRYsC05Ml+tivA/5i?=
 =?us-ascii?Q?zMJdh6ru0IjppKTG9veJnBFwOtCCvPNWnxEGAB5ZbY2FfLGE5JtJzL7S6eQu?=
 =?us-ascii?Q?HHNMiY7kZWssj/iuWrcszErrs44+Yy+T4FBGl70HAX/Bwr/+Lc+ne05rzjtE?=
 =?us-ascii?Q?1AMgmVGEJJK6+WycmXCpOlJHImoCWw4iVX4Bz6UgpE2RfBWMr/xdOTZDNXvs?=
 =?us-ascii?Q?HUBCbUSB1pCWrIzWvshiUrmpKpsy+6Mq2so1gRkFAIPEOCneMS9vruRzxqDZ?=
 =?us-ascii?Q?WBLy69o7NHRlmuasq6MbiQ9XIdK1PphsPcJuI0sbjdLBL4FKOLB3j81o2yg/?=
 =?us-ascii?Q?GXbXo55vmDPw8TLNe5U9hCL3+WgT6fvmkM+N1duLbeagegZP7tmMm+wHc76E?=
 =?us-ascii?Q?eqI/B/DaLgGTcPiuJ4xULawqQrd0RyQGQ5SIKHf16RCc8MNi+1E5CvMjTIUn?=
 =?us-ascii?Q?zt81QGHmAkVb1uKOxcrXxy9NPQuHR/gocrdLlezCoJ7sGlxKuASl1JSnrEYU?=
 =?us-ascii?Q?YzkuIreZ+r0KeUqIVlNRLyDiuXMJuhvlLzvmEKouwu4+POH6jFPB4EKGi9+n?=
 =?us-ascii?Q?DdheAD+nxdnvCtjYfttSRVPnpXydTOUjEaKeimC7TqDUOat4TCg3qhXVmROk?=
 =?us-ascii?Q?5/DUHTrSCHST3MMOBMBn9+ph9x2/rze00tIotBcIZxs22HagbhZ8yPanyz+3?=
 =?us-ascii?Q?QC8aAevnzgstcybg8/OLc+od4TQNWrWVp6F0Tv5nxsjtLTrG6HNwYdKz/avQ?=
 =?us-ascii?Q?K8K6Bxc0BfQcggWbLK0aqqvxOeXBAu5W2uWan0krOZQdpNETSEl7xhr9+beD?=
 =?us-ascii?Q?5Yq+3N0nRBTfKfd6kgcOsM7faXMSwkQNpG3ViXt7Cy9sjfBlJomGPL88ElQU?=
 =?us-ascii?Q?H9TPHtdllXkfWvv6r3NKy7adZeWZlocbz0NcYL4Aa8Kbp5zk4d2ERb5rMalK?=
 =?us-ascii?Q?2Btg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b3376e-a7a3-4973-5aff-08d891b90220
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 03:11:46.7365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S72Fk9V1aTnGVayHiyP5SEwFTUauZO8e7PW+ydrTWcwQCvcZkJQR6gH4KrNUw54eoDNonZt7z7Yw+jBh+0lUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 25, 2020 at 11:21:31AM -0500, Alex Deucher wrote:
> We need to save and restore PCI config space.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

Hi xiaomeng, let's verify these patch set in your platform.

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 34 ++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 221a29cdc0aa..70d6556cd01d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -336,6 +336,38 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>  	return ret;
>  }
>  
> +static int nv_asic_mode2_reset(struct amdgpu_device *adev)
> +{
> +	u32 i;
> +	int ret = 0;
> +
> +	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
> +
> +	/* disable BM */
> +	pci_clear_master(adev->pdev);
> +
> +	amdgpu_device_cache_pci_state(adev->pdev);
> +
> +	ret = amdgpu_dpm_mode2_reset(adev);
> +	if (ret)
> +		dev_err(adev->dev, "GPU mode2 reset failed\n");
> +
> +	amdgpu_device_load_pci_state(adev->pdev);
> +
> +	/* wait for asic to come out of reset */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		u32 memsize = adev->nbio.funcs->get_memsize(adev);
> +
> +		if (memsize != 0xffffffff)
> +			break;
> +		udelay(1);
> +	}
> +
> +	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
> +
> +	return ret;
> +}
> +
>  static bool nv_asic_supports_baco(struct amdgpu_device *adev)
>  {
>  	struct smu_context *smu = &adev->smu;
> @@ -392,7 +424,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>  		break;
>  	case AMD_RESET_METHOD_MODE2:
>  		dev_info(adev->dev, "MODE2 reset\n");
> -		ret = amdgpu_dpm_mode2_reset(adev);
> +		ret = nv_asic_mode2_reset(adev);
>  		break;
>  	default:
>  		dev_info(adev->dev, "MODE1 reset\n");
> -- 
> 2.25.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cray.huang%40amd.com%7C232f4d9376fa46595ab708d8915e348c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637419181097974222%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=G4MJVzemXHXDbWv53OWKVtD3DnJGgSs4TYbIEkQE2PE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
