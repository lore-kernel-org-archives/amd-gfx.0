Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC683C2D0DA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 16:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E60206CB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T7VRlr7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E60206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC79489C55;
	Thu, 26 Dec 2019 16:13:14 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C4689C55
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 16:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHRAQmUggXs6n1A+fVeWUd1kZXA/z7PgCiNq8mb9IaE4mDC8xfR6nOLL1TovsPHgw6ZoTfvUdSmUnvuiOkmgQJVpkjmd/3eOlZh2aRggtBSn6J43ppXdpslNL0SRcKaXOvTMWjbqHVBBLb5rQY70A31FBsZckTbYz6aQTM5bBF4SXo3Q3Y9ZuMzkd8cZs6mQXO4SxuyU9sMi1Y0pfdxqRjiCJp07INDyUX7X1OF42jiERyn0x//b929XyudGa7cwRrw4cJGJVEwx8FCLrdS4ORu271ac/I8tszJlPd3Ju87bAPcYzm6PFfQ+uYgQr9X9mtoRc7AvicK/PRC4T7qiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTINFVQO2zWT1fO2RWV+H9MPf/CxvLHKi0vMB/6S7jo=;
 b=d/d+Pb3hV4q1f7le0CPSbqJgEJBoncTeuwWDpgjjcLnrK6SB/D7hXvHw3LH3wVvJ3A9nRoOxd4mYnqvYfdHQMa4v9StmOQTi/XoXVB/IBb3peoETzvM4x6rasdT/xlR8ZfTX1Ln0WQoqB4D/GrpD9sENPkYK/4smfJWoLABunpMlj8RmLBStX4EXPae1cTYLX9Ixd5ptLpQWsFv6q9OijfDL4pRhlSGagnh5lo2t4bVQ7iWke3uyg2Bhcf9FWxpnlaXrb+E2ffxSW+rKm+OH/LseQ3/Noz5LzalOHgxaTskX4nYx6qreuPcz1YzTbvcZf4iWmO3OQCHPjDh7ObJJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTINFVQO2zWT1fO2RWV+H9MPf/CxvLHKi0vMB/6S7jo=;
 b=T7VRlr7dqp5yVJR1esytr+nPcRhSxH1G85O0UOSsSrWdr6KgLRUVBBM8jMTMxKpUMDgc+5R2WTHhlMvOSWmnNB9iNdQxo6nSKqAdxnupjUt6xgQwg8EOkTY2n9XyD8HUAeSPTOi+P2NFwJXzmKRArVq4kjT1kjER0kIAbDkL1jE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4063.namprd12.prod.outlook.com (52.135.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 16:13:07 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 16:13:07 +0000
Date: Fri, 27 Dec 2019 00:12:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: Likun Gao <likun.gao@amd.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix NULL pointer issue when SMU
 disabled
Message-ID: <20191226161257.GA31960@jenkins-Celadon-RN>
References: <1577336793-18367-1-git-send-email-likun.gao@amd.com>
Content-Disposition: inline
In-Reply-To: <1577336793-18367-1-git-send-email-likun.gao@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 16:13:05 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8a25e94-4555-48bd-83b2-08d78a1e7e78
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:|MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40637B5FEFC92BBF851764C2EC2B0@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02638D901B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(66476007)(66946007)(81166006)(316002)(26005)(16526019)(186003)(81156014)(54906003)(66556008)(45080400002)(55016002)(9686003)(2906002)(1076003)(8936002)(966005)(8676002)(6636002)(5660300002)(478600001)(52116002)(956004)(6862004)(33656002)(6496006)(33716001)(86362001)(4326008)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4063;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUpTuF4sot33P3hlvKqSYA0DmV/G7QJtNYoBDjw1azN/JNJiSWfQheyotTbzS78RuQWxv7QCvb6q/cU4V39K9qBGNuk4Dd4UZndz9qs1a9ttUGWlrQXTHYD461WxTzQtZqYoEnQRg1SjLiN+nHf+F+1JYjapfxbadGZDV8IHLOy84H/T/MM7LyKCaH9p6avI3DUiThnUPOufTkoQR/DchSZiCFodFUhjY/p1BBux9iLIcpd0w1Mq5chUAWuCdF9327e8CoYLarKf8caeI/FCrItwTQEpkxZr/yWK2hth6zzruVJXj+eKgTyoRWq65HmawxKD4F9waIhm0RxEblQkVv8xaP9DAbml6DN0H3I+pSvZkX6elMI1efqHaTWYE8wkCBiVbA1y4VdgE3pCBq10r5ncJx9RrDmv7WUjrp6b3izfMGIcdXZksl+6qKnl0sgLVtTbJhU8u+3MW2uT4XfIEYJ7h+eFTX3enObYv6fWgOA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a25e94-4555-48bd-83b2-08d78a1e7e78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2019 16:13:07.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/RkzkDroeC+amzGbvUYK4eqz6PTJqTAdwiec3bj1VehRppltbDImaso6iBnnl2ugy0R3if2aSW2zR5ctYUkrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 26, 2019 at 01:06:33PM +0800, Likun Gao wrote:
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Fix smu related NULL pointer issue which occurs when SMU is disabled.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index d07c4f2..3724085 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1905,8 +1905,14 @@ int smu_write_watermarks_table(struct smu_context *smu)
>  int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
>  		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
>  {
> -	struct smu_table *watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
> -	void *table = watermarks->cpu_addr;
> +	struct smu_table *watermarks;
> +	void *table;
> +
> +	if (!smu->smu_table.tables)
> +		return 0;
> +
> +	watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
> +	table = watermarks->cpu_addr;
>  
>  	mutex_lock(&smu->mutex);
>  
> @@ -2398,7 +2404,7 @@ bool smu_baco_is_support(struct smu_context *smu)
>  
>  	mutex_lock(&smu->mutex);
>  
> -	if (smu->ppt_funcs->baco_is_support)
> +	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
>  		ret = smu->ppt_funcs->baco_is_support(smu);
>  
>  	mutex_unlock(&smu->mutex);
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C8178f1e683574741c2c208d789c17815%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637129336353672102&amp;sdata=yuJP7XrQbabqM11I8sdymfpCTi9cBmQyqc8mx9l%2Fe4c%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
