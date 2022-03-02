Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 08:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92D310E59F;
	Wed,  2 Mar 2022 08:50:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AC010E59F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 08:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjBHBdpv7Esny3dAVEGe990SLgF+O2iLyceR//LePMRn7DYB5//gbvDcslUPAVzDRFryTl7Jv+FIARYCDH0fpLgeOUdwxupC0zaF4Mkm7khq6LMvd7wQsNpQ5Fq2eZ1UJSZD7uJX18ULIgPZ7D5PXoPQMa03DjSL9WK+KUlW42wUFe5FPHNkKtMx46tL7a2+iP/SqmxL1B3vTo1yPU1dOGzBrJ1+H7thJXbRL9TfrNM9eHzcRptuyJXIO2qhgL/6Bgz5HtusOp6W3VGeEv0bHt/UuSnHRzEqJmsUYydEuI8cNLpQVpBbbS+9i5ai8oWU97RVVwMteGLUWVz05pX+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEqb9rFBNvWqHgwvWsDELBn+JzC13nmCS9CS0FiSBt8=;
 b=csmshUoz5fOu56hZWNVU6Xb8zbdlL9fCaaXaG5/8RD0wvyOAFphRmTDGsKwKdhf3S0GsP8tz393NUvCX55frlB7kR8ctzumHnEZB34J4Dk4uqrUne7vIT0Kj20ib3N1/2PBkTmvHzEoSs1EIs859yvdKmWXfosflx6d6k/GAZZN7PvyrfQSTDgzk+E3dPRAW7C6OebBUJ4gkzmxNrng4AkyUvNNd8AHMo9IrAGAjJhbJkrySM1btJk5bGYpK3WUpi/ev/vHl1QRITunE1s1iqlFkj2WFYleFiuI6Yb6/LS6ApHsuAdZCwGpg4Mwx/jnzBy0egssi30JrlwENU+2bBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEqb9rFBNvWqHgwvWsDELBn+JzC13nmCS9CS0FiSBt8=;
 b=CUWOGRdJJ/gbLoV51YitJxmVSFrhTJtyOCg6V0nBEOpklYB6fylQRyi3MDj3mXDXtxPYU34WiF0vw+tTOo0HSXJRpm2AJU6Kydg/ehQNvTAGJ3D/8/h2zXIbOoYeeS2uB/q85IbWC7I/vl+D9e2fbFk4GslIDkBeNQE9X5s47So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Wed, 2 Mar 2022 08:50:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 08:50:17 +0000
Date: Wed, 2 Mar 2022 16:49:52 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: move amdgpu_gmc_noretry_set after
 ip_versions populated
Message-ID: <Yh8vsB182O9cGBOR@amd.com>
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301150121.3785743-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742abeea-b76c-466e-4e3f-08d9fc29acaf
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4758A66E36EBE3CA63261F5AEC039@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev/I4n/RT1VtKdYrgq+aRKOo5KcZ5byhcNcVxzy+xBLjQCLEMC2ELo2VvCOibjoVab2/frR3tAluHiwKZu3hqQScH6svlUKy3qrBXhLRpoXoBN4jtk8HVh8VIZ4k0K4B7zDY/idlJ4KD80WvlMx1Ro12nb1OzVMwk+kXvO+gqeAk3u6V6dyAEq/cVAJV+vyOg8nRCNtqDCGTyzsB+d5M0X1pnlPAgmoNZjj514ZdDHeO7KR0nq9skzbXOcnT4NqSMcVqcqi9/egbriF3cSu/FRzbEHjaP7Vr43pIrJ0H3gIqtlOLk06iW/yWlkrB6dnIe60huOUmEVMgYsUBHQWWzKVmwR/1y6ij9zMkNZBhVtjtAmCYfZ/717CQfNbGjTNqa7XNqog7MVlD+6eetcSY1Ii2XHItnypeDrEGEzX5Xsr4DPt/JqigNxwkdep9ovXS3pcEWTBN1Kil55otPQO8HZvVl8YZdXZCJYVxpFnjBMzK6K/ErxacYWtIvUZtrv5ON4kVAsIGsEJSB6E9r3s3uSSZ33q2zx+asNDDrRuiCngObUiJf54f3GB64CwcMn6LvqDw8c9DpTLcj3Fnpc/iY+iCN9UG88jiF7Y2U6mYrucMG0LkLP9lauVfORXy56alThYaRzlqtQLvsw6q+pLedg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6506007)(6666004)(66476007)(4326008)(66556008)(6486002)(316002)(36756003)(8936002)(8676002)(54906003)(66946007)(6862004)(37006003)(6636002)(2616005)(186003)(26005)(83380400001)(6512007)(5660300002)(2906002)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhXlLvakWHOnWF9AjLaX9Ugw3YkTSH9BXrjccsTdT4FuFmI9Gxw4Ye67Qan+?=
 =?us-ascii?Q?XuhJxh5X6p4YvBNMUroKiav5kJDrBKrN9YKrQon6Z/Uaa/oZPLQum8RGIQ5P?=
 =?us-ascii?Q?ReDBFXJXSJhffvvymIuZrF4/1y5bfyyOZKLoaSlpqvy1xmxNjYdw0zDBwl2g?=
 =?us-ascii?Q?vcdf2azL1ozps+WfyvHfYQ8YyjmnMVLSVkx50GDV0Yle+EOX0lhDCE37q1KR?=
 =?us-ascii?Q?ug80i2hcwqSeZ8CGHjL/JV5oSocpHUdCNbhimeX7SkRGCsq5oD49daMqKGV2?=
 =?us-ascii?Q?5v4e3Vv9F0N7Yk+rPYpuTsktsVCCSkQIrcvGF8QotFhSG2q1EAKjzotgD4hP?=
 =?us-ascii?Q?UIAEzsGOg6vmAKwTO0usMnfaJtS18HOm0ydFHhD8dU4F7s36VuMosA8s1yvL?=
 =?us-ascii?Q?ughdol0wJGJpO2zo3vzKZbTweTcDXhd+T0Ba280WryDNyj3TEiOPo15fREl6?=
 =?us-ascii?Q?9wZG5NYnASC72UvyKak7YIxULOOSprwz+Tav6bZYCFugTUTAP0ciTadUJs24?=
 =?us-ascii?Q?nAwyCY/Q8fsmbZDQGWYbVLHYWhR55Cei/XWj+8wDdI2FmjebYJrR/i3qXp/h?=
 =?us-ascii?Q?tN88DacgUzqlwKh1iz0s2rkr4HqPYUbpHoYpaPaRGeLKia/CmMuKg7mDyMyj?=
 =?us-ascii?Q?3b3PyeCpRtfkoyzXMVrCAfYAz9ppEx5JULKv+8DTE4Ofukdofp26uEE1bIS7?=
 =?us-ascii?Q?6iAIyplKVCvGNfJ6e/0gI4/fEP2cpBnRGhESg0RnaAkU636z1D6NpogQo7ih?=
 =?us-ascii?Q?05KtsquAJJXQiNkGqCMaoy/V91nC16GeqMMUUfS1Pcug052dkKXlxUoFTFdT?=
 =?us-ascii?Q?/xr9yRjhSN393zJQzUK3ikTPTEsaaIA5ujM+rx7XV19xybxDTjvZ/8wi2wVV?=
 =?us-ascii?Q?KU3nAHzslkjL1lWmTRWU/xITGSFhkBst0J02BHYxVKlCsOp0RZjm6mBTSyRX?=
 =?us-ascii?Q?KlR/+ik23wYYj9uvFy6TN1sKCgF71qdUf153o9g8GPCnwy61cTgLPWuMh9Rt?=
 =?us-ascii?Q?9MYRdjm4bC1WVmTS7+5Ut0/AND6tSfk+6O2x6RgVZpEzZ8jZpZBUmkYYk2Eq?=
 =?us-ascii?Q?232QDttgZiJaqkh38Lwi1wLW4rdfjtvhbLj0vld9IoUPRXtBC2uysF9O3wFS?=
 =?us-ascii?Q?8FQH/9l6h0ZbzLcyqw+1gc9W8tO/n4U62/fE9oOZwGBAQYAWtK12TKsBFKzY?=
 =?us-ascii?Q?Epbm+FpyO856XCwCPvxMUn0Yw1soO37YBW6t4J69I2Rn8d5fz54nwLxArF6G?=
 =?us-ascii?Q?njItjXJgjWmcNw84s3etOW49d1UgWypWGICp8yvHXYL8I879o7EpD+nz4hj6?=
 =?us-ascii?Q?ph0KbMmPhmtwXt1nJhjKeb4zQa+ZqpvZVGFHlwzSrwp6sBll1UHY5n/XXzJV?=
 =?us-ascii?Q?FjhIH2QPH0GUdMxoE0nCiq2+V0ZuIuZRnCoNwv7QOawiv24zJ7U0/IAHpjCC?=
 =?us-ascii?Q?YCeKM/cBaJ+erFsg8fgQfKhBw2OnraFzsnTdBdvXsfEnwAI7Rh0IP7tUzUTw?=
 =?us-ascii?Q?PYuKYuSihzjJQnC5qfW7d5DkQpgLw/jFqrnxhOr+YKmKPdHSdeMV1JvaTNX8?=
 =?us-ascii?Q?AYkZqh/itrclS0qUyDQUzKDQjnqA0XxQnW9JPy8zohb9veO1E7LSQsTCOV0d?=
 =?us-ascii?Q?zgNH06qot29n9LbLq9hcWmE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742abeea-b76c-466e-4e3f-08d9fc29acaf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:50:17.3008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Fb6lwNqoFqHIDl2iKDMlnmn50CllBPRz0xm4qs+aIE/mX2jw1b1E776uS2qONLkT75411RfLubnzsXSahnFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
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
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 01, 2022 at 11:01:19PM +0800, Zhang, Yifan wrote:
> otherwise adev->ip_versions is still empty when amdgpu_gmc_noretry_set
> is called.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6113ddc765a7..61a6a7920c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1554,7 +1554,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  
>  	amdgpu_gmc_tmz_set(adev);
>  
> -	amdgpu_gmc_noretry_set(adev);
>  
>  	return 0;
>  }
> @@ -3641,6 +3640,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> +	amdgpu_gmc_noretry_set(adev);
>  	/* Need to get xgmi info early to decide the reset behavior*/
>  	if (adev->gmc.xgmi.supported) {
>  		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -- 
> 2.25.1
> 
