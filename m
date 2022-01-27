Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 02:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEEA10EE48;
	Thu, 27 Jan 2022 02:07:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4221E10EE37
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 02:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn9qcwr1aTfQXumO0BabWmCIgiG5QO7+Dgej18fU+ulF/FIRjYB13I/KBR5p6FP7MbVwRLe0VhxaU5YItF3S7lXO7/fpMFRfWwzevcdodUJ4duKVMtQ35QKaFkGT1cmbvujddYKWkdelH/bKbyChRmtZChQyoQD6i14XRbXbpwVd6levkHrwWscFKcwrJfEG50dRwMXYrRDXA/gquSXzcRHklNtIiK7bREsOcmMa4W7UCtBADZQiUnWQUcKAjT8ADXPVmQALMl5KngfbskU4S33xdMCcZnGrplA9akOzrJAr6ARDNyFG5TRThwa7Hd1jRhRQrwT9uBe4VEWKRFh5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlkS1jTFVylsAHYPb+9wI7/WhHqZelY4/anlPsFO0bY=;
 b=g/8pTq6ppt0Y32hMyoAdi2hIDw0qmypNXoQskxnTvEzAQf5kx/AkZpMSJCWVEqauWMPTKhEBx9qQiRhDP0sKmlrGAgtROvR0tRC55WZNfPd4GdjV3eQxrU+f+OdYLYwxIEo/n/+iePXX2oLYVU9MoljmSFN2QzXWY7vNJN+jTE66X5Mr/Bb3bBimjtU7OrKqHW1utpmoz7Z0yKUSqUIjv4MGOaOm3A5n4XjCEZUk3dLMJzX4SJFIz36gxwOz0guiNJUA9D6BEArAaXJV70QS7NqrCZK+c5hyT4Oyr7d3EPNEhxrksfSALT9BSYnJrad+qCycyPFz7izVLRzm6funuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlkS1jTFVylsAHYPb+9wI7/WhHqZelY4/anlPsFO0bY=;
 b=wvosYVzzAC+1nGnWKmUl8HHwDjcfh+wwyVSpXvrGM3h6SwlsfyOFfA61YqIUx73PkxW0YTXH7l5LIAOfQkL5IwPKgL0IkUZKFB9+lUDRFfzXOrJHL61VkO6EAmB0+L4M3T0B4kanh88krb3nbWf+A7Ewk6Iei/AbwAVxx3klNi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.17; Thu, 27 Jan 2022 02:07:20 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 02:07:20 +0000
Date: Thu, 27 Jan 2022 10:07:00 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add 1.3.1/2.4.0 athub CG support
Message-ID: <YfH+RLzLIXzPZXmp@amd.com>
References: <20220127014806.2592589-1-aaron.liu@amd.com>
 <20220127014806.2592589-2-aaron.liu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127014806.2592589-2-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba00ac96-87ab-4ac4-67f6-08d9e139c00a
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46142C40BD007979F6885281EC219@BYAPR12MB4614.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3nz/cpckBzksVs9XWeGTYNcEFANS+RE7sh771y//GHgdQF/OQH38R9nOejmApG6iQHaduvILRi8DhpAh63FnRMp8oVgqyzet109CQ87Sm3iZdnLyEpYjs33wZ5UtsXnW6/WTSZxTd2hG9ZlB/Y7HD9fxbr3jKJO/47z+HSXnmasZsfp2xBfdHmV0ZqfVVHgtxnlSdI8bKIvHUTWtpFg+Ybeu1VKT9we6mHUOHEeblklREjtOgTWCteNOv2DeIq7C3MtXza5tYZaKnBmyi3/k/2T+OUzqo0ZN2/GGsn7Ogzw7/Ch8feP82DScsWXPbv81Tk1zFMXr39E7Esuy5OcQQoB8eIO0ZsG6c6by32C5V4vFhYzBqL64bCtStlXzueAO0P4+0yxBJsHscXInZhJ/c8+IcTgPeh8OjAgZVx5PUpWth9XLERby3gsElvzvdO3KI9ERI3rQjaLKBURcMzc1AZDKptT701fYvC5kHJ8w7Y/v4NB0I758pYBXe/V71FhIyd7YSUQNuybbu9pR4at/ohQKIX11wiPfeBc0f43Sc7DbgFaBwUSaf7DjG+ioUvaSGdAMqz8RYX2K+De+R/YikDq7R0VuBBVmT5DKtBOAxdu74V2LQ9U5cuFH9wMUcSnJFPeFkzrdUTjsBZAQ5aWdved5bIiBeJyB63+WMWfW0NDD3j1Tlnt2OvkrtqVeeoAPphtv/iEsHS9j2yWiKqtBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(2616005)(8936002)(54906003)(5660300002)(6512007)(186003)(36756003)(6486002)(316002)(6862004)(86362001)(2906002)(6506007)(83380400001)(26005)(4326008)(6666004)(66476007)(38100700002)(66556008)(37006003)(66946007)(508600001)(6636002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1T1S5DuH4gaZtIvpGQ7R80D8Th5Ozsa9O2fhz76NTpgbYagYoKCRuuhwc57O?=
 =?us-ascii?Q?LqTFHBtawZOfyjZjqAvFNWLefaa54ZQ8tx98nsjl4Xqou/ewH88hicGkP2vW?=
 =?us-ascii?Q?fnKqndcyd/8YAUQoGTz0uivO/8XHlIsq+t9slahzMA5x21ZGbULBRdJ7ZsYa?=
 =?us-ascii?Q?Hl8/Za8OKIEsIz7zO2LS29w1uFq8uIsNhKX4sArBvVSxENqw5xQDbwn5K8Qe?=
 =?us-ascii?Q?mbxV9iYRS6GV72GtnIlgpO4/bDylTsn3Lg/cJkIoPTAujRrTY8ue4bWW0bZM?=
 =?us-ascii?Q?MMc9GmKw49qMIv3Ul2DJcT85Zfa96cyt0Nj7MKMAjWrHSx59mucPcpBwdFMj?=
 =?us-ascii?Q?gPkWfWQPtKFb8clphKWn6tlOsfv48XLYTLkpKTMU4syFDlFWdMaqtx7C6yf8?=
 =?us-ascii?Q?PMN84Xb+Ykr+31NUXHEOAplSoxsk3PKVkwtJ3WGzizYXgWjjGp3L77lwZoKV?=
 =?us-ascii?Q?D+xMr0LDrBa6C3/50MDUPoEIhc6e6Mf7uLJiMnSfYQhGiOkA4On+A/JuUeH0?=
 =?us-ascii?Q?Qm0vdeeCRIgWS0mJHoljKwC1pZRr9/BxERGo6SlDCL6qLALIqfAlElUetl3O?=
 =?us-ascii?Q?cMolgxqAXFNgWjJjrsAMI4cCuQmKUrbocBuXhXUMbuhpI4oLL2MKuz5tzZeK?=
 =?us-ascii?Q?fd3GHuYN9fb8ZCA0EhxgNm9GJhEckqxEfhzkTifPOjedRbvTJ1VPVHy5n+Wg?=
 =?us-ascii?Q?aWRagm86xgdjE9w5XvsoH+g25Y89pG/mDrgLAAtz14trTRlI7kuxMxfzY4S8?=
 =?us-ascii?Q?6eK8bdEOTSY/+Olisusg4X5ACBjbCvAnXGOwbqJC1aSqLO3rY34VeI8jhtlm?=
 =?us-ascii?Q?U9zelIVxZ7tTgoLegMTjxjV1nmjKH2QHqKlUCnMgvT/wy7vsO8cqlxjTVAKz?=
 =?us-ascii?Q?miyCAXfQVBiv+XFtIBq4yoNI0H5Ozu3IuTE5+NB5sbD+b1GUrnmlgPTBWyS/?=
 =?us-ascii?Q?yj+PheYOoGbce2ggvKFujbZUzeOYU+W+PA+bQ+9AZsIV/4A3cussTPAHLN9i?=
 =?us-ascii?Q?PTa77QD4AyMG+oGag8HU+e4fCjNANlsWDeRFqeEaZsotI7m0ZWUcex2PWGMo?=
 =?us-ascii?Q?H2FbxIgww2O75qpnKoAgCJDW+826sb78bSZDrzGMBR/rwy4UHvbNq46tYUCM?=
 =?us-ascii?Q?wP4ii9PMmwp19Hoco01Q0drqfnX2yg/KC6ZAwhK1hiTNSLNZAuI31MiMd1DO?=
 =?us-ascii?Q?fn1JX5LiHazubwTFfiJDvNiKwvPQd8V0LbId7LLph/0NAVAGb418j8hcT9MI?=
 =?us-ascii?Q?bND1rtWjRWZaO5lybKAUQ3Zw82LSoIqXFDIK6Njc5W8OXW56pPzoD6d6SpJT?=
 =?us-ascii?Q?oIKaUL0ka7rITq5ErjY1LTN4/ArfLnezcPZzyeYvjme1hUIKMU47oTn6gLN0?=
 =?us-ascii?Q?bz8DxEDNE57Qckt5M82zKrvXFkHMdhGXNDU2qjLERSx7uYCOeABEKqBVZlsm?=
 =?us-ascii?Q?9mv4zO4K7bbLhtC7n2K1jVhMRVDEzERp+tS3USPJjmuMHcUooOSbLyzZpTza?=
 =?us-ascii?Q?Vv+Y5/v1BeYUGf6KBvWMqU7IkvNTD6RbBcxKFx5yZ0itdNDidoPlxUN2GXDm?=
 =?us-ascii?Q?FmbNa+TxV/TsQZiIUdh5Wl0B3qb3aVPj9waeJnvP+8dU3TXFeNHR20UWwOd0?=
 =?us-ascii?Q?CrhSwtKrZEalhmrhaWTYc1U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00ac96-87ab-4ac4-67f6-08d9e139c00a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 02:07:20.2803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srUkYoGIPihTcK8lb7KQ6z+y0Qd1nA5bB6EVxAIC/IRNt4eswWLttV3eA7gmYyLzfTUE/t7Xrn4lUD7LeDAQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4614
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

On Thu, Jan 27, 2022 at 09:48:06AM +0800, Liu, Aaron wrote:
> This patch adds 1.3.1/2.4.0 athub clock gating support.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/athub_v2_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> index ab6a07e5e8c4..a720436857b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> @@ -78,6 +78,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
>  		return 0;
>  
>  	switch (adev->ip_versions[ATHUB_HWIP][0]) {
> +	case IP_VERSION(1, 3, 1):
>  	case IP_VERSION(2, 0, 0):
>  	case IP_VERSION(2, 0, 2):
>  		athub_v2_0_update_medium_grain_clock_gating(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> index 2edefd10e56c..ad8e87d3d2cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
> @@ -74,6 +74,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
>  	case IP_VERSION(2, 1, 0):
>  	case IP_VERSION(2, 1, 1):
>  	case IP_VERSION(2, 1, 2):
> +	case IP_VERSION(2, 4, 0):
>  		athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
>  		athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
>  		break;
> -- 
> 2.25.1
> 
