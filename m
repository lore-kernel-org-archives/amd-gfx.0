Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF29DC6FA90
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2024210E57F;
	Mon, 19 Sep 2022 08:06:10 +0000 (UTC)
X-Greylist: delayed 1201 seconds by postgrey-1.36 at gabe;
 Mon, 19 Sep 2022 02:49:38 UTC
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A698210E4E8;
 Mon, 19 Sep 2022 02:49:38 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MW7qf2xGzzHnrw;
 Mon, 19 Sep 2022 10:27:26 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 10:29:32 +0800
Subject: Re: [PATCH] gpu: dc: fix enum conversion in display_mode_vba
To: Zeng Heng <zengheng4@huawei.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Nevenko.Stupar@amd.com>, <Pavle.Kotarac@amd.com>, <aric.cyr@amd.com>
References: <20220919014125.3295213-1-zengheng4@huawei.com>
From: Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <43f17686-538d-030b-1121-2770f12cf04d@huawei.com>
Date: Mon, 19 Sep 2022 10:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20220919014125.3295213-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 19 Sep 2022 08:06:05 +0000
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
Cc: liwei391@huawei.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022/9/19 9:41, Zeng Heng wrote:
> Fix below compile warning when open enum-conversion
> option check (compiled with -Wenum-conversion):
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:
> In function ‘dml20_ModeSupportAndSystemConfigurationFull’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3900:44:
> error: implicit conversion from ‘enum <anonymous>’ to ‘enum odm_combine_mode’ [-Werror=enum-conversion]
>  3900 |     locals->ODMCombineEnablePerState[i][k] = false;
>       |                                            ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3904:46:
> error: implicit conversion from ‘enum <anonymous>’ to ‘enum odm_combine_mode’ [-Werror=enum-conversion]
>  3904 |       locals->ODMCombineEnablePerState[i][k] = true;
>       |                                              ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3907:46:
> error: implicit conversion from ‘enum <anonymous>’ to ‘enum odm_combine_mode’ [-Werror=enum-conversion]
>  3907 |       locals->ODMCombineEnablePerState[i][k] = true;
>       |                                              ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3960:45:
> error: implicit conversion from ‘enum <anonymous>’ to ‘enum odm_combine_mode’ [-Werror=enum-conversion]
>  3960 |      locals->ODMCombineEnablePerState[i][k] = false;
> 
> Use the proper value from the right enumerated type,
> dm_odm_combine_mode_disabled & dm_odm_combine_mode_2to1,
> so there is no more implicit conversion.
> 
> The numerical values of dm_odm_combine_mode_disabled
> & false and dm_odm_combine_mode_2to1 & true
> happen to be the same, so there is no change in
> behavior.
> 

LGTM

