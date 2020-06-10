Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCCC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 18:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E5820656
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgGe05Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E5820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8851589F35;
	Wed, 10 Jun 2020 18:30:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF9689F35
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 18:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfU6O9hQ4mQPUFUYgdvWmdohvlwKBuzvmSJA5kNbe2wfydZOPnDoGHfBuK9HK2leF1mnCOcWD8fI0ZQGj3prc+CdlfncpyD5UcWsGysjDuySVwfPnJc1DXglIHaJTMZt9x2U3xmtHl1OqlgwbpY0io6mCN3hS1dCa7BT2hZe+XUcTHXxBWsO9RHeErC4YHS1nYb10FBVahNsIeG3ITEAFt5Hdb34hqGRcjEDgphf2QFRTkE3HbNzuob16RbXIgDlsw1eZIS1lqvvywS1Q0VMzXxM6Jl+qO0w4KYTY0UNCy+HbCmiqw+7ML0bR8u6mYF5zNChnX+VgIzfD//ohSDonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTN1c7dUXNUp2reayKnYEED3rA8u6hqoD16n0+564A=;
 b=a73BbN++sa0dhRUZ9Y6OsDO+FEoje7Dl85eL0/4d1YIWclyeLV08y3MN6kh330KdK5giYbJEFN4NedaM1Ih4SVDMdJFA1W715UgSns+RJSM0ZfYTRxp2eaBdYdy2UznpgovYqIutpt3vD16T5WNkvTMAA+voeEcPlVlP3iBRKF0vtnG8Qe4LWnqFZI5Dfr1QyaFSoMs7UkkcGPQ+2ySh1EC7tq2NgRyoczKi2lRvT9FWapF8eP3IdNgb3WZ/OnaK7Hgas8mqO4GUTmKbow4KkGohn8V273SSVdzrOBLhO+uTW2Ui8MTFqHwjEx34mH/fp9uJ6ZrBWqPwDcVcEI48nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTN1c7dUXNUp2reayKnYEED3rA8u6hqoD16n0+564A=;
 b=tgGe05Z1QhKpiU1Ka/1YKQ6mQKycbpLP5CaddRLy24uQEawjFDqZO/ITSIzbtRnABEDF1vix9ykLIQnoMzrTkMONtt4sd4DfUklkLnT4LNYyNbcWjUZooc67p94MxnFFFJAuWAgEJzNI8ENfzcvESpeL81yZQmmC5X75uxjKEl0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 18:30:33 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3088.021; Wed, 10 Jun 2020
 18:30:33 +0000
Subject: Re: [PATCH] drm/amdgpu/jpeg: fix race condition issue for jpeg start
To: amd-gfx@lists.freedesktop.org
References: <1591806961-11227-1-git-send-email-James.Zhu@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a5c5cbd0-f1dd-5e8a-f5dc-8777a7dea4a9@amd.com>
Date: Wed, 10 Jun 2020 20:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <1591806961-11227-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:208::42)
 To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f20:8400:5208:b733:df0d:5c3f)
 by AM0PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:208::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 18:30:32 +0000
X-Originating-IP: [2003:c5:8f20:8400:5208:b733:df0d:5c3f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0919d7bd-0d26-4e5c-71e4-08d80d6c5c0d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4504:
X-Microsoft-Antispam-PRVS: <MN2PR12MB450448FEF791B0F3C58BFAA88B830@MN2PR12MB4504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r1v1I/1iVzl+x6yASb4or6P1prXx7DQr0jWMpfrUAQT3yzmi+5xsOG9+OtGqKSbDg2TpvS2jTEh+LC7WtALzissb9K1IJau5fa+0thHEOJaFlscCyu5IkJbHq98eK4qD2bZ7iafHopTJyZvB3OUZgpcC3Jddzx5Pxye9U0Pm8OTy6tR4g1A0ulcGfK2Yc1YuLIYpgkNQ8+HrA855uN9f3/4Cq7z3zW8sOYQqG7U4nlrFJ6noNeGMJE7R0l78yfuJXLxlioU4ViHfGq/8Wg1mdS8/2RiBv+v7LmIDheN1sSBGq+hYsHnb6GZ3zdC6GxSkNP5s8da1oxQWm2juJ9yMomAYA9qOJHWzdphQnsGsDMaoNpIwDpLvYdx4SeFztjE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(31696002)(83380400001)(2906002)(66476007)(66946007)(31686004)(8676002)(478600001)(66556008)(36756003)(8936002)(6486002)(6506007)(6916009)(5660300002)(6512007)(186003)(16526019)(316002)(53546011)(2616005)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PAnARfGj3qcPHItHORJnHaxQgq4vnjgSlbIdIiMIyQL6FpsgOvGfYOjP7AFl3LkCQzZeXprCGgtD+tb3sd4eHcQBKQlkNNa2CUzm9BJm2vIq9SwoDWO8N0IG7aX4Y2p0DevcNFLI5wkYwRKU8thrcy+kmnD0NuRFidN/0bkjtHNyKb+ijYJFV+EfT5DwM0e+jPSyp0vZe9cuhsRktqxRs88kOVExVV8NX4TWuPjAVBBEM0M4PRWXSbh63nhk9iWf/ttTGvvLBwmu++xn5RLxkEznr+TKw/A/LxNLF9W71TN/m148FHQOPj3NRnXj1zfbc4tbP4K82vyx7MIgP6SNlw23waXbIL+FCmDMC594sm5NGbKCP1EDxMa7Ii3TKQy33cEPWb+HjAfxNVOzNUJf/vwg6k2VQi7Ybky0Tbkz8ue9JwRuG+GXhEAQY3xA38cAWmMXvjQSFl1h3eS1mYJcjh7tE8peIVIOVULRvhW0UGLL/8+Xii6nj6VvCbee06lqzH7TkjehoYxLpyjnGMR3MdbSyHhmDYZmMsbw0L+4+ZU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0919d7bd-0d26-4e5c-71e4-08d80d6c5c0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:30:33.1405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GFrfON09Rw3K3df3TXEd7hRcWymxbRpw0IvYSltdT5GEC4mIEc9aZ54wSloAaXHwpmNdky8WMLRVMhd8nwg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/10/20 6:36 PM, James Zhu wrote:
> Fix race condition issue when multiple jpeg starts are called.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index d31d65e..8996cb4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -37,6 +37,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
>   {
>   	INIT_DELAYED_WORK(&adev->jpeg.idle_work, amdgpu_jpeg_idle_work_handler);
> +	mutex_init(&adev->jpeg.jpeg_pg_lock);
> +	atomic_set(&adev->jpeg.total_submission_cnt, 0);
>   
>   	return 0;
>   }
> @@ -54,6 +56,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   		amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec);
>   	}
>   
> +	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
> +
>   	return 0;
>   }
>   
> @@ -83,7 +87,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   		fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec);
>   	}
>   
> -	if (fences == 0)
> +	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_GATE);
>   	else
> @@ -93,15 +97,19 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
>   
> -	if (set_clocks)
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> +	atomic_inc(&adev->jpeg.total_submission_cnt);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_UNGATE);
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>   }
>   
>   void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
>   {
> +	atomic_dec(&ring->adev->jpeg.total_submission_cnt);
>   	schedule_delayed_work(&ring->adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 5131a0a..55fbff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -46,6 +46,8 @@ struct amdgpu_jpeg {
>   	unsigned harvest_config;
>   	struct delayed_work idle_work;
>   	enum amd_powergating_state cur_state;
> +	struct mutex jpeg_pg_lock;
> +	atomic_t total_submission_cnt;
>   };
>   
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
