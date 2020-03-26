Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD72DC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC92B20663
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V8UeUVwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC92B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647C76E958;
	Thu, 26 Mar 2020 23:20:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFFB6E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 23:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB1z+dl/TvrNTgi9iuRoG9MYkyO3uJgXTnmkB3/ZlWhIZTNLh6jtgFcS0wuKHW9pirnsD0OxuyX2QOfaZ/hmSymW1aR0rRUeZvR3560HHO2M6Azkuagvw23ugDj1dCNtNQYSZ0hnitckZ1JdsEg9pfSUUb3/vS2Hop2ovFRg0Q6Jnd0Ua/F/rDn5kvTGwdz5HEUyribp8bunVwJVEL4vOqP1yH8kmdaIAbIUiJC+j+WBQEDS6YuDNif3RMmVMmx51SqyqA1GYgzu8chsM1mpmGOw3RcclSKwEqRrWFxIUQT2xJAKsTvroBSH3BL2qfLqkEm0X9mbMCmSxVSZAA/2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIACZ6pCnqC4pXbhBIX5L7cdzQIScJt+BsjEdHA+b+w=;
 b=l2q3nNiiCDTSzaAOfy5nRZtSrCrWOR/YNlLMr7zDEfNCxiZe2c+SISLRofUvaFCBDqIVnBKAM87MmcnyKW2jfwR9nMbyLq+eU1TKSVdgb3oOT0ZaxKzj/XIvOw+UdCfW4Kb9m4cethIreU0Nr6j7241edPSJl7KC/hpdwztR16fInwd5UfybKxAKS16XyyuipJRiwQbjS4s1yuHfZtNu/Y3dAyijoYGAOXj/Pm8mLQNvzWmyjlRjx/MgfUHRmJMCoPJ6uPtkqWGyWOZ4jtEKe+ra1Bqd8bbkY8wEoyrASIPuKXidusjLe5XVcbOHY6QcCUfizIDVLadzlv9Uf9hBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIACZ6pCnqC4pXbhBIX5L7cdzQIScJt+BsjEdHA+b+w=;
 b=V8UeUVwddrMjtUIqZXbtTH0DeTUjaZ643iawErs3GTZ3c9SmWu4HerW5JY0a/ep/NGD812yZ6bd4moAltmVdoKCfeWmNBajnJRDci6+og5BpRBY8675FGJcf+IJSC5GNpEBvMi/opXz/BJp2tRvL3H01VimqbTgDC8yJpDqpoX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 23:20:05 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 23:20:05 +0000
Subject: Re: [PATCH v2 0/4] Invalidate and flush caches at the beginning of
 every gfx IB
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <86b2c848-2d09-8803-2c22-66fe29c3c0fb@amd.com>
Date: Thu, 26 Mar 2020 19:20:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Thu, 26 Mar 2020 23:20:04 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8af527d8-aab4-4d72-4659-08d7d1dc378e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4201:|DM6PR12MB4201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4201741594ABBFF0AFCC6BAE99CF0@DM6PR12MB4201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(4326008)(44832011)(31686004)(956004)(2616005)(2906002)(186003)(16576012)(316002)(31696002)(52116002)(16526019)(36756003)(53546011)(66556008)(66476007)(66946007)(26005)(81166006)(478600001)(5660300002)(55236004)(81156014)(6486002)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4201;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq/LSv3br0a6QqDZvO+uCXSitFKBPo0T5CEp4El/FiCqsyr1pGJV8Geh13yabUJ1RFYWxlALD3/h5qHgfT+RZAOLbsbYU5iDy7fWjT2ogS4Wbko2wJ43HKMrpGgINM0VH0T/iqi8VQ4T47wflsta9xLC/vVlFDQvUoF3BPx6R00KmzdGJlWNhCs3Q2zv+IqqAnR9NPdBiBnYnlgUD5GKlTUsJli9KDt+ARYs0xNGJi30beyUZyO5s+0m4oQQIQyqLCYTAC3sh3S7K5rTdGPzUFFroh5i1aHMT3Bvx8cAIC3PpZmS9T++6D0oV2ebr44aAYoGJf5lJ+E3nd3oHIFZud8SyFR3NyhP/Fk8Iu2s7ygjLE+mNYvb44xdUHkwD9quZCczXnjGlbkAJKvBSufoQFAZV0Kol5UzjJ4OXY6nWLph2LK/vzIN8ZuCnISNiz/N
X-MS-Exchange-AntiSpam-MessageData: eLQWraisa7ixREZf8e/36cLseYviUNpXUdWUK2Z/v3K/Xjxg4LAp9Sgr+pgV+2JzeU/08NxkuABuuiNWTF8WYvgeugetE4+zR7nuK2rBBN2XXzMPpsI8Jp6vBYodQBafcas+PlPwGGnSaHzwpffY0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af527d8-aab4-4d72-4659-08d7d1dc378e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 23:20:05.4234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2z6SP4FTjpjaolx15dieQAe0hvo5lk5DHTHqGlzywPE2dec/cVUnMspfanWup/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: alexdeucher@gmail.com, Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks great, except the note on patch 4 about the commit description text,
and perhaps we don't need a period in the title of patch 3.

With those fixed, the series is Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Thank you Andrey.

Regards,
Luben


On 2020-03-26 16:02, Andrey Grodzovsky wrote:
> This patchset introduces AQUIRE_MEM packet submission at the begining of each gfx IB
> if requested by user mode client. This is helpful in solving issues with cache coherency
> during amdgpu_test and Vulkan CTS tests.
> 
> Andrey Grodzovsky (4):
>   drm/amdgpu: Add new ring callback to insert memory sync
>   drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
>   drm/amdgpu: Add mem_sync implementation for all the ASICs.
>   drm/amdgpu: Add a UAPI flag for user to call mem_sync
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 27 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    | 16 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 16 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 17 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 22 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/nvd.h         | 48 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc15d.h      | 25 ++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h            |  4 +++
>  11 files changed, 175 insertions(+), 7 deletions(-)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
