Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2746C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD7020771
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oGSUUMN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD7020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8207D6E2E4;
	Fri, 14 Aug 2020 08:49:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF37B6E2E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 08:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv66VO78QVbhxeYvi7gyMD3aHG3zavwrsr408XEzLjy+9Cl4+Xvxy1BxQpOWZ0bfvBLLKavm/1CVUvzETW7aHE0p0j/nugHa1EfydO5ohQ7ZnCYDpuKY4WHxViHCoc/97zX1/6hxRBFuUzoeGN1MmF4jC9o69e8rfbABAEaQORGSN0R4e/QYysuVCodYShdgUTH+FZ9tVe2zmYwREJO2vODsi2AyCj+eHo5lZiY/el0/JFKJScrSRBcdsTbK+Tq9iW/dHQ48gV4kLuGFmNds5ON73b6us1QdkGCTJW+giaL5+R4kj1FvkQJbEJd4My+QE2MkZVORfjhD3ERJmwtc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwEGK3LLAnU4diYAGM9KkBPsMyUlp6DbP3SVzmjSkRs=;
 b=kItM1T34Kd20OuJ29gAVUOBxx7Ak6Pjv5bozjBxMZCeXzdcZ5fBItm1YMbI3XayXzEPQEBDDXHe7elFoiiEaLaCCGQkaT0ASVB/j/eMpyI8fV++PHwhjpLxvGuMuJcC5fmD2TIOcu4f86Ao7KReKtDn1pv3+RoXAjyaG3KkKajeje2m1Dy8Q8a2RVFCgSjYFxSkOr8Mj1mEDCyKLZxBUGwkeIKmciuu+3dZaPupNlIAnf9G5iH7oI/Df4BheSCBRiR1h0+IzbwTy4oUQo4ToI6D1G0iKPCInBK93MxcVZTb1z97bl/xEif8H7fmKjEeWOyoByf64ilgI18CoaLXxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwEGK3LLAnU4diYAGM9KkBPsMyUlp6DbP3SVzmjSkRs=;
 b=oGSUUMN9isG+27qMaJCo2NwIYB8LuiAuKAXH4wpay/KnVpUxhdakjYZyXJ/fyBnQAHrQ7uAvrYmVtkSbICPRt6c2I6xmSH0tEdYpsDTn3e8vdY4zTfAkQZrmtv7l89MaOPp2QfCT71yMAeNSFtAxh+14b8HrVfUxG93EoJ6e/4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 08:49:26 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 08:49:25 +0000
Subject: Re: [PATCH] drm/amd/pm: drop redundant MEM_TYPE_* macros
To: amd-gfx@lists.freedesktop.org
References: <20200814084355.3440-1-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <03fcaeda-6acc-3591-0b26-f776b126d433@amd.com>
Date: Fri, 14 Aug 2020 10:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200814084355.3440-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:200:89::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.108.42) by
 AM4PR0202CA0005.eurprd02.prod.outlook.com (2603:10a6:200:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 08:49:25 +0000
X-Originating-IP: [217.86.108.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed3d5d94-9fc3-4be5-c2c7-08d8402ef2ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB4316:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4316E5A4F4086D66A11A37E58B400@DM6PR12MB4316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuwmYODhZROlOfM4DS5LYw0Qb5a2pMVtUbQ6WLjmxXafW6rS7gR4j6iXAScaFsXh2DyQVCP5h5fTEBkF+nBu260vcyIVlLyvbQTo58Am8d/UQUDAThzKAhYCE/f17sCtX/upSfT53+oqayZPkdiNjvP4pASdWeY47zlap7VBgOCFpsiL4mALFzgNocP4rKhHuOQrOqTZwiCV7kVx+43xjC3/qCDntHcxjw1cav1K+KiqyAZvrxNsVDxDGmtQ5Bhqf2vHqWRr5MDCC3ryb6UaevKi1+SYOij2NGla63RY7O+KyXl4eSTmvMUo+8eSvqPpbJsgoRki4JUX0L+Ti4b7XjFgQtUDiQE80DTEllZDquYUQWgpfPfZg/u3MH31HGZF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(186003)(53546011)(8676002)(956004)(478600001)(26005)(2906002)(6666004)(2616005)(6916009)(316002)(66946007)(66476007)(66556008)(52116002)(83380400001)(8936002)(16526019)(36756003)(6486002)(16576012)(31696002)(31686004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HfXsauzxlp6ukr3JbyJOeEUa3tryutcI5SYnFhfz0c/OqADqO3Iqq8Vr5+CkoQCmSBB2MM8+WtBKsQTLs+rmVZLsNCrAUnhZ/R7hhWSOO2xxno/u86BgsjcjqzY+wjAvA+e8lLCFHk6CMYSfQ/0Ur4T0YI8XzPqhWxfawukpJEbo7IbAPD0UmyUNkdE6h4Q3dBiRgC7hKAVfI8dRkVeIc3OVFCub/nLmM3MLsm6fz5FRrdATlHSRPQNBaINQ7KYnRHZ9YRoFSmW/mliIWv+ncKFc2Cf5YFLTy3u7/kUvGYFjA4ej8Hg3IkKnLJ5GPSzOawyRws48LXtofbgIAZZlES8kRHe5nsP216mNlhmuYNcYpj88n6tRoTDu3Vj52jqVJThwiHXU0G8ZV/C/3utxtiNE8ZVu86S3h8XP18+YkW7kD/DPwtj/E9l3DMtRA2wOCHaieJtLcP6oW702NJcY/MYogiKF8roGJdVDNh0AEDG+UGNJe/l94W43TrQWYclHw0Fn+5BbWSu4mvd0y/FYqX9KQj+5OtyI0AFt7kNuOk9J+yzWqy29+GqTboFBLSWbHjJLWCzo+PSix+BEGymze0lNHni8HCjbIf8lGuCk8BQl8IFNTt80UIPC23ghr9Nhnwh0p1au6y5KzXaUcR67Iw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3d5d94-9fc3-4be5-c2c7-08d8402ef2ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 08:49:25.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ze3ImzXZph/J8493YoT/WlvwEdBO3YsKaYjuIG2Qwg6cysa3td+0LKC5Li3n2j07FNQXtM6dMhrrfdafyFKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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


Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>


Nirmoy

On 8/14/20 10:43 AM, Evan Quan wrote:
> As these are already defined in amdgpu_atombios.h. Otherwise, we may
> hit "redefined" compile warning.
>
> Change-Id: Ia2a9e10b35173fedcbbd8e0abb8ad38dd231baf4
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> index 3ee54f182943..76ed2e413594 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> @@ -26,15 +26,6 @@
>   
>   #include "hwmgr.h"
>   
> -#define MEM_TYPE_GDDR5  0x50
> -#define MEM_TYPE_GDDR4  0x40
> -#define MEM_TYPE_GDDR3  0x30
> -#define MEM_TYPE_DDR2   0x20
> -#define MEM_TYPE_GDDR1  0x10
> -#define MEM_TYPE_DDR3   0xb0
> -#define MEM_TYPE_MASK   0xF0
> -
> -
>   /* As returned from PowerConnectorDetectionTable. */
>   #define PP_ATOM_POWER_BUDGET_DISABLE_OVERDRIVE  0x80
>   #define PP_ATOM_POWER_BUDGET_SHOW_WARNING       0x40
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
