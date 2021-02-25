Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBFB64E6C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBFB64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554306EC41;
	Thu, 25 Feb 2021 05:42:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893C56EC41
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 05:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs5yt9EOtKW1CUNVS4YCuxI1+xda3GsPfw8984TGdBy4F/YGH/M5SfAMNYwshUJgenEmvKt68KdTp71YQE18mdNPhX6wC3fFJxI7ci7HKLlUBmQrrAnk1VHMztbO2JXU4LzrM5KUQFNe8b3dfn4FdhI/ivyxFxdH0aibqtOvZELw+0JeqVDh0faC1zvAymOyCmtkCLyV6wjsjz6hAtqlAgX4BrHhRmT6tzmCapF2lRD/+iTn9FnziryWtIKi7JFMwkemkgC0OU9urZfhZ4fNnmY9iNG2P3AC19+dJkQkyQNjoW7nABLPvMNsLh6zE5N3c1XDeWPVuKEwQOO9vD7NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZZbVB3lv+7+4kTsvbNg5v0ZW+UgSYuXWEmCeY7Tpwk=;
 b=ZLhqX41T+Br+wBvvqzoSnb1uO1m8q2h1z7OMQIyFxae7/C84y/p52g2vSyYuc9cxjG9SJHMeztWzdzoVeZ6ta0Pielh9LdFSqJ0onLVdkDun7FoeTXvaVwuEI4atyGEtLtvhfistgCZzhyO2UjXYvCxBFKiWqPAHTwNwGlMEzxn1qZtq3UqomUP9bjPba+xdL1Cv4+g5oJhAMPQZpszOUMWqBs84oaVVkQyUyvk4Uz5Lue1RFkm0pKlhSUQwAXhWz9QvtDC/DJR6BYN+HqHhnc71CWegaeue2k1Qw1+QaY7TvLRPgLwKEY1DOMogZyWi4gq31HSRVsY4y73Hf5ylOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZZbVB3lv+7+4kTsvbNg5v0ZW+UgSYuXWEmCeY7Tpwk=;
 b=y1AxpIdivOXFpsvLSy7uq/9pumnYQfgi6+OnUiZv1Lqs5RsVZ4fSSC9ywkHJj7+M0rtWfOkK2fA8leVo15G37XAtZf2NRnKIyZm4d4sKNFH+lI6N4HeF2zmFj7YhTv5hDqhAE8uBUklELxAtuI3ekkecxQkrFYqDKTrvm0qDKtY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2588.namprd12.prod.outlook.com (2603:10b6:907:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 25 Feb
 2021 05:42:32 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 05:42:32 +0000
Date: Thu, 25 Feb 2021 13:42:21 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in
 renoir/arcturus
Message-ID: <20210225054221.GB587137@hr-amd>
References: <20210224091055.3410-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210224091055.3410-1-changfeng.zhu@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 05:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 616b3b80-253d-45a8-f300-08d8d950252c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2588:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25880BF5B8906657CB150A72EC9E9@MW2PR12MB2588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWSWrnIGzSw4dbDp/x5MLXeXmPKvG+cRze1BaomIPU6Xnk5ACjgKlac0WLizCxwn+LObZBZU2qgMXYbB0XYIP+X3BubA19o2j9Hpfru0wakAaHBQSh664Aex3HsYGqawkNFb6qr76kBr+vg4dxJpoHsgp1rCH0O/xm842nEuOxNe1LDOdbhf6xXZWYz1O/4OZhDyYx+SNa5vIFtMprfbkS/cupqr+T1oQK84/7r9zFazPOa+YzY89fZgXLxlIUeELD1i0H07hYKSQd2wbcY8IS3pCU407RLU8K7F6Bhew5VgBc4G3Py51QqtLtO1qIbX3ox0Iaz494829IlXWFRlfFZGHD/0yeuskww8HGJJASf6qF2PxkK/eT3QrTyE6q4WBq/yBmSECPpG1ECD6HqMVtGZK9iu9NRGj7oJ4fby6VNZEmGKWm7bzjBAGdUweTyu+hiJiNexkbPgXAM3vkDVv4RzXNpoucQgNAmS9eJjmDKDF/A7SY35TlXG7z30Us3XLd+TEZTdiUqede2kCtC33A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(33716001)(8676002)(1076003)(66946007)(26005)(6666004)(478600001)(33656002)(956004)(186003)(86362001)(316002)(16526019)(4326008)(83380400001)(52116002)(6862004)(6496006)(55016002)(66556008)(66476007)(2906002)(5660300002)(6636002)(9686003)(54906003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6/S0zuEH/CM4GutiHAMukkht7l4I3HPSx8gdlU3fo/yGkkuH8ezsVmicIfLN?=
 =?us-ascii?Q?OvyFGz5rC2ZOAe3ej7PP4+quQ+sn4DbRa5O1Me9CUU+jpV8O8gSazwRin4z0?=
 =?us-ascii?Q?8SfGiSKPkJuDQKhUK5H1ubgE2aFw2KjOk5xrtvx84zfkGwOtBFjCwmV62X/D?=
 =?us-ascii?Q?n1Smg3ZxshC7Ag3HkgiiSNT5ydDRnG10oYIKdmQJ/q/mxz/A9e3RRA5aMnn7?=
 =?us-ascii?Q?HICQoGeTLAFydHwRVcBNC9XHZKtQEyh9Jtvc041FYwxoBtHYNqe6RzOL+fMM?=
 =?us-ascii?Q?9rQxix6O9EcFyIct+lMB3v9ZMrTzWhMOUX7kpsm/A/TRKv+0R0cUVJyd2ZJX?=
 =?us-ascii?Q?CZUTp2Iu3XDxjPo/xCSwZ2vic6zcf8bReQq1573zJ5LKOJaAKmS/yIgkE+QT?=
 =?us-ascii?Q?qxF8pEQGpRm50lusjPXm3ZIcjqIPXehjZCteUA8/I7FxFqxvHsodmK1+qKtL?=
 =?us-ascii?Q?5ONsFHfXklJEISTPoDLaPMqGRl76/Fw4eIhHL7vx7jcnVB77NV6Qhd87bljI?=
 =?us-ascii?Q?jFa176rrdBtUqEmIpu3/XFKKjQpM5jimRT3K+7GtKiNIT3XGKJ6GvMULZGes?=
 =?us-ascii?Q?VkRkbB/bw8cZQfDHevCvVwBGN4yI6p2XadpmIrqiRYdNnum4uPGt6ZcpIcu6?=
 =?us-ascii?Q?DPRvb5JY3JdGVYFBY02gkcEXF5sAFgbKVWxyDnX2HZmp+TckuMsLBmh6yybq?=
 =?us-ascii?Q?sd6dqZoW03rPO2jlH1YK5NaK3xURLveo2RPs6thrweSNnAeCNdXmb3u42T6T?=
 =?us-ascii?Q?58T1bK2mTxpxbKsrnD/uUt17R6jEOm98l7Js7iPKwOLoNUPDnohhFZhevDhv?=
 =?us-ascii?Q?fk3Nl6sHsAzqyLx3bjVEylIE4MaV7EOIm963VP2CJ57zBthiPe24ZNaUcOfZ?=
 =?us-ascii?Q?Y3rZQ6eYG8rEyw9qhFt0vpUAkckBKsC36jtNMFpP7DYgpurUpEt2tnUHytpO?=
 =?us-ascii?Q?sSGFAr8Dbk3hmqTlLUYXBzfmmFzXSqXv5t6uHbho1Q32+SEdnhqVsAFGhqKj?=
 =?us-ascii?Q?VdyRJQRLvqKUo+TBYWl+Kb7pa/dvml2NG8KUv7REfgsXUBOHJAkL9V5+89I8?=
 =?us-ascii?Q?i3oWMQRamKGwKNR4fRtYbiI/X9WhOfS4SXIdUADiOX7jWo0/cM/G/y8Lid3k?=
 =?us-ascii?Q?FBJ7soZyYHBfEVT4SC65yCS3QUj2xtrw/XPGSoiQDHB9ixw2u24wxUupcQ0i?=
 =?us-ascii?Q?xgN4Z5qO2pOhDpYn0cwlQdil3tQYdnpHV/TFv3e6qlIFiL/mFSAaPaSyvERP?=
 =?us-ascii?Q?IXvlPRdZcwwgOw7mrnkUZ9Cvq0WykV2vIaTkaQQW0ixEqPOrU8DiSePgT6Wj?=
 =?us-ascii?Q?IROuGIuBuXJsMqg3V09d9krv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616b3b80-253d-45a8-f300-08d8d950252c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 05:42:31.9178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS6mHWzrSkmWK1JhsUekHqHi5ZYqptghb7d3xhcHDkM+zyjDjPXqQ5FWZhwFnmgIivV9SZmEOJ0A2hGegs7VhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2588
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
Cc: "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 24, 2021 at 05:10:55PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> The value of max_me in amdgpu_gfx_rlc_setup_cp_table should reduce to 4
> when mec2_fw is removed on asic renoir/arcturus. Or it will cause kernel
> NULL pointer when modprobe driver.
> 
> Change-Id: I268610e85f6acd9200478d0ab1518349ff81469b
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2f56adebbb31..300a07227597 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1890,7 +1890,10 @@ static void gfx_v9_0_enable_lbpw(struct amdgpu_device *adev, bool enable)
>  
>  static int gfx_v9_0_cp_jump_table_num(struct amdgpu_device *adev)
>  {
> -	return 5;
> +	if (gfx_v9_0_load_mec2_fw_bin_support(adev))
> +		return 5;
> +	else
> +		return 4;
>  }
>  
>  static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
