Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E10C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFFA10E18A;
	Mon, 24 Jan 2022 07:35:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EE410E4D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azX9eQNgX2cbQdFLmFAfwmoeUDzKrFY7FOsDFxNszzGuM2pheHSo44W/JoqHLBLb9U7160DwnfYDEeONYBOxdBiuy1GtCD45ZrEWM30ndeMFeXCLlRTK/3+VnEpwPm/mLMbMNf9SHpZxln2wVCMs6m8VOQvMjjWUMRCWluOinSH69ij8uw1MBmEUyp505KJZlG6K1TMpV+/7d4pCYxQj+4e9/tDlwZQnffI7+MMxopIvX7iH3+8oPar7tWZouJU2HFekmluVrpw5EZRKri3JZg6mLvF1v/XvrObmJp+9HMfjfvVS2iZKdn5mDM+fiLTq7Jd9DgwtitBonSILsOX4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uROXz8oZ14l8Rx/lTHEbzjvp+doEQZdlIXSDpE8jItw=;
 b=WMfNU74QC9XNKSEyDS8SeWhoTi1YHmcnA71nnM4QWMyAj81OxVY+Qr+JKzmYBIvq9pXzSYwAaL/r/8J9EUf7LlTdq21cykE53o3WYEVAXZQ4cka2SCPwqdgICbsNRFfBMbl0V+VPcGCN73g2nJm39If6aZaqaDlW5jYSIPmWHVZNikEZ6eTQOuaekvKEWhaJOfnQTwRkpFzdUPGLK32e1ixtl28uW7i4rXr5uvGLTA14l7mAffYJxfhUllsR3QPshVqOEpJxmbsRgUssGJnsl1yMC7dwW6Y1znKrepLHGOmoodQPa2RnujjcXw0fVZiU/hhouzzgD5bL5HqT7PF+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uROXz8oZ14l8Rx/lTHEbzjvp+doEQZdlIXSDpE8jItw=;
 b=AsThdLCfhmVSekW8ZW+QYrw4AGfKNiqSziKOu2hFk5h3Yu0B8aUTL3g5Ep+LA61s39N+426Vv75Jk0koaZu+D/uOcwWA6YK8bt9pTDof+7McvO9E3GLd0w/jFxng5fL9ZFy9fe2XRkEwo/Wp3ZO9x6q8nfnf3Af0fydEr5ilVyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Mon, 24 Jan 2022 07:35:14 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:35:14 +0000
Date: Mon, 24 Jan 2022 15:34:54 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>
Subject: Re: [PATCH 3/3] drm/amd/display: convert to DCE IP version checking
Message-ID: <Ye5WnlhvM/6cml4Z@amd.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
 <20220124032042.1974371-3-xiaohu.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124032042.1974371-3-xiaohu.huang@amd.com>
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2049fa13-6aab-4da9-e2e0-08d9df0c0fcd
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB125204E852B43300B321017AEC5E9@BN6PR12MB1252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EThyvpv9oFo9v91a3/leWHqKsJzmVx2RoIef+U4KVMCkOwlWnPSSXWsygFZDHgP0LcTInXUWn7h5LUMRVLhxFtT0IookFuUuf6uChUA6X+yeLQx+LGEKPMCy2sdoH0Nd+hUKeZ6DWLlr8fAjT7ZlI0W/yelmgNnxAvPOPYHV0hOKsYURk/1A3voLnc7HMYj2yx8+pbbMWDMuHSq3Sd751PoOrF7DUuGGMM+DU3GOh6mNqsCXqcwxy7TlIUiczhv9A9k9n9PXBZi2bK9FmKtx+WeD4v6ntxoHe6iXFfNXE56wdXCFqNXVe8+dotG8y9N7VdqctH3kIjFLyePJg+8z0XxPpyqKidTfEQvYFjQDiEwgrCwOltWp5gmQXQVDB4hyCMMCd6g22vDaMyR/FGhpjmhoAn4nWkhjxx/o987RIyoLjlcoHEYhzLSTn7BXH4VWd7GxxGpEAw/upjulHtAzT0mPe4mbcVAUxNJqyy/cMwwRHSsWxaICgcyWU+TuHYPotfIU8/+Wgjt3LCwExAkpt0ZGY5YiKHJaaeHd2puZOkAvzBIaYJyJvZdbsGbfR/VUPdWX0I0cQRGE8m5FKbQ+KU1mI2fl+4L89U1Yn3QH9DnPXINCYmPtOwgr1MMvbqL8+MqfeJmUG5IqSblvY8Daw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(2616005)(186003)(66476007)(316002)(2906002)(37006003)(6506007)(6636002)(36756003)(83380400001)(5660300002)(54906003)(66946007)(38100700002)(26005)(6512007)(86362001)(4326008)(508600001)(6666004)(6486002)(66556008)(8936002)(6862004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4J6wXVXDGyzgd8xiHTsZ5y83erWwNXCi5zN4ZxYhYGXEZgf2/ICKsW1LRhS?=
 =?us-ascii?Q?YRi+u/HNfqBAT0F2PNb5h2lLCY2FAgDL12EKSYSlnaFU5niU4wJlBKVxtl5r?=
 =?us-ascii?Q?9ptySULcSU/7PvWB7SXa8QBXxQSeeYDPuhgBDI0AzkA/5faCQNKQEqlFRSub?=
 =?us-ascii?Q?CIKCr6NnJ9iQMSLM5nAbmev+sgV1SYnNSd/IReCgsX1gcoec+gIhLciOu0vV?=
 =?us-ascii?Q?J4Nn0c93z+aceKyv20tiSchMMdKeqtjUZOkWYQOGq0WDaaUkE1mWNuT3wbS4?=
 =?us-ascii?Q?d1bATvkM3Z1SEkeIKZVzOkxw66DZXNE0eAzC9Fnc47B1uEB8UGW481StwPCx?=
 =?us-ascii?Q?B66y8xUgGt74BVVc61bdlvSG97GilLLg0cpBHhhX7IqcrRtg6ct8mYlewFtf?=
 =?us-ascii?Q?X6TH0BYgWZEncvR+/RNbIweFAQQQ/JYUCoV4c19GVVFdThRPqZ7ajISNm9As?=
 =?us-ascii?Q?mzYjkJPJeWE0RzC9nywKTRzFnYUnwALMLzWJTQmL2fAKGQS5b+OFwAsgxQwF?=
 =?us-ascii?Q?wgp6ql9c0Imn/gUCGjJk1kRWKkpXxhpgunDUknb0/TrZMqORBE5Bz7Vxc7vH?=
 =?us-ascii?Q?CsxUBdFDdrqeCaKq6eOzLdNN4cLXmNNZjSWmDbE1hqLd8cw0BdHLPsRr4wKx?=
 =?us-ascii?Q?blW5rr3PB3SvCPAySW79UAmctLI+hDOv4WcfNwiJD9GsktnyhrvjLPg77BzL?=
 =?us-ascii?Q?nI3izOpFJrJ8YSzntPrs2nBv+JULXptHoxNOgQSB7kiLcrP0GQsXJRbagKSl?=
 =?us-ascii?Q?Rk2huU1d7pZm4Eg4mBIjaBObcIE+RsRX1ZURFjr1JpDq1/+bMJ508cJAWOje?=
 =?us-ascii?Q?ZnYlZ/4C2lJH/RuaiYBzRii6gFVKuOI0aBSM1RXHDu3eKs5Rfmysa7YOkmtk?=
 =?us-ascii?Q?ym8jXp9aJgehUUVQxmzrrzVp2+vENH72I6CXvA8vFNRAcJQ36nVGXvDw6s/P?=
 =?us-ascii?Q?xfKDyhrvtL1HHTEtnNIQoJZSLF1R8CG4NVAZIZpceVB8rwBv5FSsEVBD8naL?=
 =?us-ascii?Q?w5Al5zabcO/UBA9NN072XEm6gzmy5trkXXfaBbNMF2tJkgAePKykhNdU0WYQ?=
 =?us-ascii?Q?KvyXXjX/rznf4fdikapovOFhgdei7H9IvyHzPXPEzBEzx4w3nmhVw7pWCgkz?=
 =?us-ascii?Q?wNqoN3Oo8K0TIFL5uhJoOUE14z+2BgsiwmiA5dgSyPV6oOa8XdVWXZnudNZg?=
 =?us-ascii?Q?BAY9iCmPqp6waeCmQqQsRvcNq1TVyMSAYID0grkafW+6sdWSbaYjcqGIQdPQ?=
 =?us-ascii?Q?1ZlcjFEBjtLqRyi9tZKKCL8DxMT5P5Me6EVV99ZUWTQZ6Al+wJ6rs8DVYN6S?=
 =?us-ascii?Q?DR7QdrzMONVtbqFSFoGYbP5ZABuLD1KiTnl4M3t7/4j7ZgUloxx972Q02OhZ?=
 =?us-ascii?Q?GLanK/Ym0zSusXHDRGJvII1Fs3FOpTKBAuGks7jtnMhLoGpS7fxbqGtUfev/?=
 =?us-ascii?Q?DZ7bBzUiy6MDJfT4k/F1prS265oHXxx9wMI0a1mqTxpA2eBzaXL+BvOswXRM?=
 =?us-ascii?Q?OVMntl7G8PXEy3Y6JZoYWweJF5kGbG14UiCECMZpJaZ6uwHlD3I/VhL5o0Nv?=
 =?us-ascii?Q?BRqdxI78rsNpaoTsoYxZSHayMSExNOWSCViS70a6h6ZkvhmVNTfJnCy6OlMj?=
 =?us-ascii?Q?IbN6yRc5GiddsDGDP2Y6GLU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2049fa13-6aab-4da9-e2e0-08d9df0c0fcd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:35:14.8326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYzhKLbMNbsfdE4akiUr7Dct1SpJcWxrLepBIkb3vpB7M2LI4f8NMsw7TTUMwYrnJoXFQefhbIiLL7Kz8uq5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 11:20:42AM +0800, Huang, Tim wrote:
> Use IP versions rather than asic_type to differentiate IP version specific features.
> 
> Signed-off-by: Tim Huang <xiaohu.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 87299e62fe12..c967e1e344e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1119,19 +1119,17 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	for (i = 0; i < fb_info->num_fb; ++i)
>  		hw_params.fb[i] = &fb_info->fb[i];
>  
> -	switch (adev->asic_type) {
> -	case CHIP_YELLOW_CARP:
> -		if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
> -			hw_params.dpia_supported = true;
> +	switch (adev->ip_versions[DCE_HWIP][0]) {
> +	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */

There is another way to define a APU flag on enum amd_apu_flags to
differentiate A0 and B0 for yellow carp.

But this way looks good for me as well.
Patch is Acked-by: Huang Rui <ray.huang@amd.com>

> +		hw_params.dpia_supported = true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -			hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
> +		hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
>  #endif
> -		}
>  		break;
>  	default:
>  		break;
>  	}
> -
> +	
>  	status = dmub_srv_hw_init(dmub_srv, &hw_params);
>  	if (status != DMUB_STATUS_OK) {
>  		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
> -- 
> 2.25.1
> 
