Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7101C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9F4112304;
	Thu, 13 Jan 2022 07:56:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66310112304
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU6jWV7cY0kWCr5FT10LATwRQBGgcsaDfqaMVkhIX69RyMfBt/KRG4V7jBMcP1OtJocQPNcf2DHMSb8LZdMtBJPtoghpNui+WpACUwhDzyfHAT2yr2FNhmlbqU1S96c0zQveKE6wwApoT24NsfyJJpdvwbtOdvvv45n7POpTJGHpoeyXVf5y038odBPMTXLPsjTJjJPRGFV+R88DFFdYxPB5x/3G/4r/a289P47k+UEM5hoJvsR8OnypgVIOTKNHmN04m3gDr1nvdFBm/S2/fFhDL9+0iOvd7zIZebIBe8aXhf2GDIu0BqFPY3gtJFHqZvvTsAw3wPUytIG9MrZfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7GEo3lSjHaQJv5NqITOSsWuJV2ZzUQUXzKkCUngdKk=;
 b=D+IzeHi8oICQ5HqYSGC+R2aRdzJfZD1BSZ245ZijPfj0CWWLK6tfwAZo+FpXWfdz9QQJRe674yJgRCl9/lsF6LEze5bvzjcsdljlddTWm8INrgyoMnvWHGDVgmaTkxUR9sKjdf59ZZmVbkbIDr/6TTwtQ6RMmXBTTgIKNK7S19IRrAe8LvmRvVt1cTgghSo1P/+j9VxtDdsKppSxhsJ/0XSC6pqbPzcHgBd0prN7C7FUCkSSsZJL4YukZBO/mJInxkZDVxoNSOXYELkI1yfNpvLnU43AvZHQNySnj50rWC6wspljyvka8aalH0QG5IQx72gG4Zl3vV/I4XCcsfOeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7GEo3lSjHaQJv5NqITOSsWuJV2ZzUQUXzKkCUngdKk=;
 b=Ve23rvCMMlux5NsgwtWQ+x1OAhAWPQhaF5y571ENuUQybGn49NEn1RlV2smugRcy4IEhgHGy+PUYMaZ3dN7uwZVnmhr6nLcGE0vDaQPEuP/kATl4IYRVEQr1fnbr2E5RvuVNsofAlY4cqVmPakoguOFhxe+DejSq9qx8Fevz3n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Thu, 13 Jan 2022 07:56:04 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 07:56:04 +0000
Date: Thu, 13 Jan 2022 15:55:44 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH 1/2] drm/admgpu: add data struct for vram check
Message-ID: <Yd/bAF7bOoLD4sU1@amd.com>
References: <20220113074526.29827-1-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113074526.29827-1-Xiaojian.Du@amd.com>
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b542377-64eb-4eb7-48e1-08d9d66a261c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2796885DED7CB36DFAD6CCCAEC539@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlCU5P0o6VX8nsrfxQhWVJ+oP8CMDw0+T0T9o6Lk9Wsc837+bW9ZfcGjPIQG+P5J02Zdfg6zJT+fUG78vdq1CLWT9mThDqq5r9d7ayG4qP+mqPpr4LjqfbsexaQDAvYHKIDYwJSJ7lNnTNJsSvxTY2ub1Yf7KyrmyxmHsWbVMSQoO02zT953wLm84WFgvezxCB+/idmn5PSTcAZNJDZX6JHIslx72BAzwBRZgFPYOxLAUipmgbnao7nd35AyaWPuhMeGIWJHcCMj0qYKbZY54BleT2P/EyTIyj+u9vlsEz8PYnp3xuTlcJaeAGvfqbIIvEFw45XETK1ZJS44+zQmtga8HC5GqnE8kzdmQELhNAuNtSmTEcU+Hx8v+q0NBk4leoHyG463u01R5L2LpyexFEQSZNlOGf5HU1AAQvRi3vBUhx9I282V3EkS9j/zRz4k7GHDLbRelSYPLGwZlOS69L69drvmv7k1EU3q1nwU+Xvxidxk23YqtB+RKu6TAcqSZT79DILzYgwJcHE9UD7q+eyAtI4duJs//w/vTKq4Dy1OUg0nVAmmG6SKACpubkDu/Sg+cpt0alDPoi3b4zRN846AyKeWxEJ2WRw8+Y1jvG+5FTPRR9tIdAwByhhLRw7xDKO7Omt3qkTbUZwVhJCQOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(4744005)(54906003)(6666004)(37006003)(316002)(2906002)(66946007)(66556008)(38100700002)(6862004)(6512007)(36756003)(4326008)(6486002)(8936002)(2616005)(186003)(508600001)(86362001)(5660300002)(6506007)(26005)(8676002)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnBm0PAGb/3huRiFsdqPtf5JxB+7+foHwdzylKXu2YcmU7GELvtDgxlkZ7i6?=
 =?us-ascii?Q?DoimenlgfdPM7tYmdVCda33+hEgVpMLqV2CSd23VRQnNyDmIMxhNiJsa8iVw?=
 =?us-ascii?Q?p/cGp92tYskvTnP8kQoPEo2Bm/lYiYuF+WPQYwo1NpbTLWOqlvZOmfLwE2X5?=
 =?us-ascii?Q?l6GZcdi3tc8SKMn3U4hqIS/8oXUw4E3t7nJLVmDVRp+ZQm2D3PW8CanHtYIU?=
 =?us-ascii?Q?DbDJ5TNsCgQYSqR0fTkzUqcVzLnZBIOh8Gn6Ibj+dnLr4a/LPqy0bCg9Edhm?=
 =?us-ascii?Q?P5MgGd5sFRTXBJmcUhXj2vmlnsDCklHLFRfJNlX4j+CwlViBszX8K3NRdvjn?=
 =?us-ascii?Q?q2+AYJ18WMPjmwHJgNXj+uaJBPfJACAe6k7HX/I36uucEY0ubVi8clYEO2j4?=
 =?us-ascii?Q?5ZjNxLutnftvgImdIVInwCkHSKIxMY3hJXv35Mz7GoNeK+YL6X2aa/ddU+L7?=
 =?us-ascii?Q?H45OnxBLy4gIpTpDcIKW6/NvbtdAAYyiU5Zfcu9OoeeTpnUCOxs/5sCXkNHO?=
 =?us-ascii?Q?Ae92uO3eJmDRDb+bBKgevjDvDbrtVDNMIReuELlzS/pivrSXSW2ji9Nd539h?=
 =?us-ascii?Q?36sBqY+gvymJbqrfH309LAFUAVyY4n1TH8Pr/3rDv1j5LabjUOev9JLO/TDM?=
 =?us-ascii?Q?tzyRihOwcBbwXSB0Muntq87txA80Hl938Peyy52GCr/KXv4C7PW5WIHTefDR?=
 =?us-ascii?Q?K4YuUP2kQ5xb5cY1us66fh1nOp4K1yTuVC7FoW9AD9FT4AvVE3SIg/G4BmcT?=
 =?us-ascii?Q?Tqayu4uX+c7IGAIezaRu3aWy995pzbU4+xHfOti8gntSn2pbmeD5uI2r7+BV?=
 =?us-ascii?Q?xJtbiUPCevyA0W2HfPvi8FCfy8BwZPppeduBVMhZh1S8freaXQa2m/KvKkBR?=
 =?us-ascii?Q?x2T4IiplTk1IFAvMMkkx+4RoCJNEUH4jGoScWFmmQFjc1+LQ0VVufSv9XfXo?=
 =?us-ascii?Q?peSTh4pkgwcRpxkZPEm3Y6RMKLa6Pvc6Nd9jDsHfesopchlNregOB0p1LzuA?=
 =?us-ascii?Q?vvqU49pHGnJ3v5v5YYGJh+uY32KZ8je7uVxPMqNRoPnfSDz46iabrtz17UP/?=
 =?us-ascii?Q?kgd2Snqyu4Faq22KsA5Na0mn0xmfwnAFiBv7fciFpTAn0EAQyuMg1WwaasTj?=
 =?us-ascii?Q?OpStZwZSKVp6X7Jom5WefHz7bgffNFNMUkNORXL7rpVJZwifStuy46lIk5IA?=
 =?us-ascii?Q?CpGETxStIIHCqOh0JH0TB7wdT6c1lkzN7fVVgtHjM/1woGycSFJa4QyS5+Fa?=
 =?us-ascii?Q?6dGzZG43B787dI10vxRfkJhfDSc3sUYPSgUyG29r2N9wfkWBR02aW17iGgOd?=
 =?us-ascii?Q?LfDbepjAZbNpxajmO0dhEEuziw7qjyNm9U6YAF9pHEKp+ExHS7PiLcE49ggI?=
 =?us-ascii?Q?4C6TzYYGBqd1WZvvO1iIrHcMuwE/AVvSiCNVxgRSy0gLT2hlQv3sGWcm9+WI?=
 =?us-ascii?Q?taM+4XrLzo68V0zFq1ntvMIi4XDaeflskMxDphARDOjwZtGorb9AWIijlZ+f?=
 =?us-ascii?Q?1GmFrK218+lJg8dpG+4UzzJCtB9u94rS2Er2srMZbCdViKxex/9vgh2w10m4?=
 =?us-ascii?Q?p9jDZ53nAQRM/94zDIYp3DH2pxWkcGlMqjKFBXoAbuQd/9yHNn1K5SLqp7RE?=
 =?us-ascii?Q?iMsM8du2HM72h68JXsHobbM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b542377-64eb-4eb7-48e1-08d9d66a261c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:56:04.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIoeX0HYzvdaWS3qPHmtEkYkqNt/qGRaSW3se471bUiiTuJK80qLeixXhE+aSN4C1Js5JHeXggnfOPEL/rPEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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

On Thu, Jan 13, 2022 at 03:45:25PM +0800, Du, Xiaojian wrote:
> This patch is to add data struct for vram check.
> 

The subject has a typo: admgpu -> amdgpu

> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 64cd80d050eb..13196e50a98a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -928,6 +928,11 @@ struct amdgpu_device {
>  	uint32_t			bios_scratch_reg_offset;
>  	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
>  
> +	/* vram check */
> +	struct amdgpu_bo                *vram_bo;
> +	uint64_t                        vram_gpu;
> +	void                            *vram_ptr;
> +
>  	/* Direct GMA */
>  	struct amdgpu_direct_gma	direct_gma;
>  	/* SSG */
> -- 
> 2.25.1
> 
