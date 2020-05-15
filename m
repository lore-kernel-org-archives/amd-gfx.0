Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC49C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 06:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2FF206F1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 06:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fj0nmDSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2FF206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4966EBCC;
	Fri, 15 May 2020 06:51:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680068.outbound.protection.outlook.com [40.107.68.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8A96EBCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 06:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlmLFYPCjITstqvaQU5PoeSiV4e61945y+U4bI35oWrs0+A1qyyEqt1Ycwsz39rPgnmiDwL7SiFYAZ0pkQI9F6TM7pKAWlA9OUNltYfxAV18Ig+7TQslxrPY7AcnGirUqfMHU6CDHbrur1+6G6gi6H7dJYhcshVxt2DJrzk6xdKTzIRl4SFdGrqzPpTROta7Jyu7oJIH3e/DKcLvE5FTO0lFf88qbdmqC99Dfmml9QHf4BG6HVqAqLGktNHK6wiHXLxv3xVYlTJKtpKsAwGWSlXYfs8mLYapxq6BIIbR1HuEmZvyGhVmHZiUWzLYNAORZSA/50NMXvvOWqqK4KKDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBvFP/dhV4CmteXzK5qfBzqxiGPE6jEn9WultbIRH6o=;
 b=S9Or2XQgUbSAV6xw8EVhSDJ1fGPzbbC2KeLZxe91gGEowZHPyfnmyb1riVMP4uec2LrIaw+G7XOokUs4UJYWMmryn6odOquqTxkKpDG3Nb6l4zH6QZsvIjvQoImP5jGhqbvoXyiCE7JTLA/jJSA3/Glyn+hYv9eCux+uugXq81+hjAXLTBRLRHqbLxjA/DduJXRnnme2cIn7vzj07sQl6229r8mTYi3vQaQSCOmlXDNxdOp7/wb4PcmkjJWVrrsYo7igGFKmMdJqLQAydki0gcnEH1yqBbRAVpsCgfR5dv28rHKLMcLzuEEGfdTBg8d5iROJMzpQjsXo8syphxI0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBvFP/dhV4CmteXzK5qfBzqxiGPE6jEn9WultbIRH6o=;
 b=Fj0nmDSsOYQuZvG/wA10o4k9HewBd/jXGOS81U8XjY06SVNWfxW9f4n4cE0T1XtvrA+4E/64RAYt0iF7D5ge+DAIrevG43L5t1zuR/znoAYho+PyMr1x7VWa80i97J/BnX30aNWdlBD0TI7I0hHjpSk8Mz7/EuVULlFKtsKOIH4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 06:51:24 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 06:51:24 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200514052952.19260-1-jianzh@amd.com>
 <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
 <BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com>
 <2b3b8be1-2627-d58b-56f6-d6bb915aefcd@amd.com>
 <MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0@MN2PR12MB2880.namprd12.prod.outlook.com>
 <BY5PR12MB3844CBB43151DE705836A6D3E1BD0@BY5PR12MB3844.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <365e31c7-5fd0-51b4-8897-2fc15072dc28@amd.com>
Date: Fri, 15 May 2020 08:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BY5PR12MB3844CBB43151DE705836A6D3E1BD0@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 06:51:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f5512d5-d730-4057-f2c5-08d7f89c623e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31784F56B64C0459C2E02B0583BD0@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILmfHsrUKFSY6VJYpcOza+M2qCDF2DwtIXo7kalSR2VO/CVMM8tl+2iqmc//WGN/xCPPPRL/lC6oBCwgNbh3AfrDpAvnQZOfLXtCcBRLe46S6JpOB4c3RrBVH+FsQV/nW+MMKT6Qjx6dvknBrcVSmHjlSyoIgnQp+s5heFvKxyWmP7Pdx/0A+H3edyBwcSwrC2r5EpJ4yni83YUZxx7ii4N7j1JiVw1SQXz3Rbc5kdSTFsXvQUEFYNCdVd+BliGs8t1/utjG2PM1qhiJrV+og0iRwuwUsDWUVAAYlgsW1CkY+dBrW8e0wputRf16mSMBKVO+hogrJgdFFFsdQEbzjIUAwFgf4gQiMKYVCk3Wzoj4ucgkUGRKsW5McNMi5TJ3ZQAC3HrKzAFXrJkBMWfLY7l11usUgqAG2MRi7s7X5R8hrRlVkNz4vmSdx1P0T+8CwZveesrK/YxoJGEFsKYB874wVuX06SBGatAJIxQesTnrl9NFepu9oxCd2q5oJZjm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(36756003)(5660300002)(4326008)(478600001)(66574014)(66946007)(19627235002)(6666004)(66476007)(66556008)(30864003)(110136005)(8676002)(52116002)(316002)(33964004)(6486002)(31686004)(53546011)(19627405001)(8936002)(2906002)(16526019)(54906003)(186003)(86362001)(31696002)(2616005)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j447TbptzFO7oVdZf8nDhiRqfI1IeBFAXFcRq4WiLi2+/4LmOHQGXcHILiMIyZG5rTxCIS4N096LWaib73fjd6mdzoe59zhqZNB9mV8mQGNFQj9Dx8yHHAs9NJHkSVnq9evVTubGX5RigDEc4a8mLEHV/W7hk7O8XWIwd2YWRNKmZnPzqa1ch7kbtMx29ya+e9n+g2sR4W9wOXRBw0/VueCIN3U+PO5lVaI3ivKk6l2bxI8UKUD02aIy2AKfsW0HXVD89wH3o3P7vuGBoj0ntJYHIObLyusQn5OBORQtcqlIlJjtdFAX5loM83XvP3N6j+NWfbTT4vhRFoOz5z0ps1NtbnxUUYFNVL7ebjIeui6+APRrMNm+vecdJwVCAaZdKvW+VgSWY8bcg0if0Ub6hLOPeFDlKOJ0Mm+nLBObZyzVB8qLhNATHBpQzKGNvfym2S6Dpra3xSpbt5LQIhAaeOE0NJpt6+a8W3QhobkL00Tjt6oQRcH3Vvb9odxN1q5xtE5yP8MVQcy5BrZbwE76tkwHxvf83JoIr5tM20KKEvQtHrvjNMJEpMtG5iAZ7rk9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5512d5-d730-4057-f2c5-08d7f89c623e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 06:51:24.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVbl4exlLSU7MgsdANDDUboPr5/VezINhEab0glpytKA2lPBOb+YNXlnnqe7Gioi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1474829510=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1474829510==
Content-Type: multipart/alternative;
 boundary="------------F1F74979E16CDC85E9364F0F"
Content-Language: en-US

--------------F1F74979E16CDC85E9364F0F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The first application to open the autodump node gets the right to use it.

All others only get -EBUSY until the first application is done with the 
hardware.

Christian.

Am 15.05.20 um 04:40 schrieb Zhao, Jiange:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Dennis,
>
> This node/feature is for UMR extension. It is designed for a single user.
>
> Jiange
> ------------------------------------------------------------------------
> *From:* Li, Dennis <Dennis.Li@amd.com>
> *Sent:* Thursday, May 14, 2020 11:15 PM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Zhao, Jiange 
> <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, 
> Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu 
> reset v4
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Jiange,
>
> How to handle the case that multi-apps do the auto dump? This patch 
> seems not multi-process safety.
>
> Best Regards
>
> Dennis Li
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Christian König
> *Sent:* Thursday, May 14, 2020 4:29 PM
> *To:* Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, 
> Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu 
> reset v4
>
> Hi Jiange,
>
> it probably won't hurt, but I would just drop that. You need roughly 4 
> billion GPU resets until the UINT_MAX-1 becomes zero again.
>
> Christian.
>
> Am 14.05.20 um 09:14 schrieb Zhao, Jiange:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     Hi Christian,
>
>     wait_for_completion_interruptible_timeout() would decrease
>     autodump.dumping.done to UINT_MAX-1.
>
>     complete_all() here would restore autodump.dumping to the state as
>     in amdgpu_debugfs_autodump_init().
>
>     I want to make sure every open() deals with the same situation.
>
>     Jiange
>
>     ------------------------------------------------------------------------
>
>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>
>     *Sent:* Thursday, May 14, 2020 3:01 PM
>     *To:* Zhao, Jiange <Jiange.Zhao@amd.com>
>     <mailto:Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>     *Cc:* Pelloux-prayer, Pierre-eric
>     <Pierre-eric.Pelloux-prayer@amd.com>
>     <mailto:Pierre-eric.Pelloux-prayer@amd.com>; Zhao, Jiange
>     <Jiange.Zhao@amd.com> <mailto:Jiange.Zhao@amd.com>; Kuehling,
>     Felix <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>;
>     Deucher, Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>     <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>; Liu,
>     Monk <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>; Zhang, Hawking
>     <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>     *Subject:* Re: [PATCH] drm/amdgpu: Add autodump debugfs node for
>     gpu reset v4
>
>     Am 14.05.20 um 07:29 schrieb jianzh@amd.com <mailto:jianzh@amd.com>:
>     > From: Jiange Zhao <Jiange.Zhao@amd.com> <mailto:Jiange.Zhao@amd.com>
>     >
>     > When GPU got timeout, it would notify an interested part
>     > of an opportunity to dump info before actual GPU reset.
>     >
>     > A usermode app would open 'autodump' node under debugfs system
>     > and poll() for readable/writable. When a GPU reset is due,
>     > amdgpu would notify usermode app through wait_queue_head and give
>     > it 10 minutes to dump info.
>     >
>     > After usermode app has done its work, this 'autodump' node is
>     closed.
>     > On node closure, amdgpu gets to know the dump is done through
>     > the completion that is triggered in release().
>     >
>     > There is no write or read callback because necessary info can be
>     > obtained through dmesg and umr. Messages back and forth between
>     > usermode app and amdgpu are unnecessary.
>     >
>     > v2: (1) changed 'registered' to 'app_listening'
>     >      (2) add a mutex in open() to prevent race condition
>     >
>     > v3 (chk): grab the reset lock to avoid race in autodump_open,
>     >            rename debugfs file to amdgpu_autodump,
>     >            provide autodump_read as well,
>     >            style and code cleanups
>     >
>     > v4: add 'bool app_listening' to differentiate situations, so that
>     >      the node can be reopened; also, there is no need to wait for
>     >      completion when no app is waiting for a dump.
>     >
>     > v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>     >      add 'app_state_mutex' for race conditions:
>     >        (1)Only 1 user can open this file node
>     >        (2)wait_dump() can only take effect after poll() executed.
>     >        (3)eliminated the race condition between release() and
>     >           wait_dump()
>     >
>     > v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
>     >      removed state checking in amdgpu_debugfs_wait_dump
>     >      Improve on top of version 3 so that the node can be reopened.
>     >
>     > v7: move reinit_completion into open() so that only one user
>     >      can open it.
>     >
>     > Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>     <mailto:Jiange.Zhao@amd.com>
>     > ---
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |  2 +
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79
>     ++++++++++++++++++++-
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>     >   4 files changed, 88 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > index 2a806cb55b78..9e8eeddfe7ce 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     > @@ -992,6 +992,8 @@ struct amdgpu_device {
>     >        char product_number[16];
>     >        char product_name[32];
>     >        char serial[16];
>     > +
>     > +     struct amdgpu_autodump autodump;
>     >   };
>     >
>     >   static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>     ttm_bo_device *bdev)
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     > index 1a4894fa3693..efee3f1adecf 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     > @@ -27,7 +27,7 @@
>     >   #include <linux/pci.h>
>     >   #include <linux/uaccess.h>
>     >   #include <linux/pm_runtime.h>
>     > -
>     > +#include <linux/poll.h>
>     >   #include <drm/drm_debugfs.h>
>     >
>     >   #include "amdgpu.h"
>     > @@ -74,8 +74,83 @@ int amdgpu_debugfs_add_files(struct
>     amdgpu_device *adev,
>     >        return 0;
>     >   }
>     >
>     > +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>     > +{
>     > +#if defined(CONFIG_DEBUG_FS)
>     > +     unsigned long timeout = 600 * HZ;
>     > +     int ret;
>     > +
>     > + wake_up_interruptible(&adev->autodump.gpu_hang);
>     > +
>     > +     ret =
>     wait_for_completion_interruptible_timeout(&adev->autodump.dumping,
>     timeout);
>     > + complete_all(&adev->autodump.dumping);
>
>     Sorry that I'm mentioning this only now. But what is this
>     complete_all()
>     here good for?
>
>     I mean we already waited for completion, didn't we?
>
>     Christian.
>
>     > +     if (ret == 0) {
>     > +             pr_err("autodump: timeout, move on to gpu
>     recovery\n");
>     > +             return -ETIMEDOUT;
>     > +     }
>     > +#endif
>     > +     return 0;
>     > +}
>     > +
>     >   #if defined(CONFIG_DEBUG_FS)
>     >
>     > +static int amdgpu_debugfs_autodump_open(struct inode *inode,
>     struct file *file)
>     > +{
>     > +     struct amdgpu_device *adev = inode->i_private;
>     > +     int ret;
>     > +
>     > +     file->private_data = adev;
>     > +
>     > +     mutex_lock(&adev->lock_reset);
>     > +     if (adev->autodump.dumping.done) {
>     > + reinit_completion(&adev->autodump.dumping);
>     > +             ret = 0;
>     > +     } else {
>     > +             ret = -EBUSY;
>     > +     }
>     > +     mutex_unlock(&adev->lock_reset);
>     > +
>     > +     return ret;
>     > +}
>     > +
>     > +static int amdgpu_debugfs_autodump_release(struct inode *inode,
>     struct file *file)
>     > +{
>     > +     struct amdgpu_device *adev = file->private_data;
>     > +
>     > + complete_all(&adev->autodump.dumping);
>     > +     return 0;
>     > +}
>     > +
>     > +static unsigned int amdgpu_debugfs_autodump_poll(struct file
>     *file, struct poll_table_struct *poll_table)
>     > +{
>     > +     struct amdgpu_device *adev = file->private_data;
>     > +
>     > +     poll_wait(file, &adev->autodump.gpu_hang, poll_table);
>     > +
>     > +     if (adev->in_gpu_reset)
>     > +             return POLLIN | POLLRDNORM | POLLWRNORM;
>     > +
>     > +     return 0;
>     > +}
>     > +
>     > +static const struct file_operations autodump_debug_fops = {
>     > +     .owner = THIS_MODULE,
>     > +     .open = amdgpu_debugfs_autodump_open,
>     > +     .poll = amdgpu_debugfs_autodump_poll,
>     > +     .release = amdgpu_debugfs_autodump_release,
>     > +};
>     > +
>     > +static void amdgpu_debugfs_autodump_init(struct amdgpu_device
>     *adev)
>     > +{
>     > + init_completion(&adev->autodump.dumping);
>     > + complete_all(&adev->autodump.dumping);
>     > + init_waitqueue_head(&adev->autodump.gpu_hang);
>     > +
>     > +     debugfs_create_file("amdgpu_autodump", 0600,
>     > + adev->ddev->primary->debugfs_root,
>     > +             adev, &autodump_debug_fops);
>     > +}
>     > +
>     >   /**
>     >    * amdgpu_debugfs_process_reg_op - Handle MMIO register
>     reads/writes
>     >    *
>     > @@ -1434,6 +1509,8 @@ int amdgpu_debugfs_init(struct
>     amdgpu_device *adev)
>     >
>     >        amdgpu_ras_debugfs_create_all(adev);
>     >
>     > +     amdgpu_debugfs_autodump_init(adev);
>     > +
>     >        return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>     > ARRAY_SIZE(amdgpu_debugfs_list));
>     >   }
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     > index de12d1101526..2803884d338d 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     > @@ -31,6 +31,11 @@ struct amdgpu_debugfs {
>     >        unsigned                num_files;
>     >   };
>     >
>     > +struct amdgpu_autodump {
>     > +     struct completion dumping;
>     > +     struct wait_queue_head gpu_hang;
>     > +};
>     > +
>     >   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>     >   int amdgpu_debugfs_init(struct amdgpu_device *adev);
>     >   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>     > @@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct
>     amdgpu_device *adev,
>     >   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>     >   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>     >   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>     > +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > index cc41e8f5ad14..545beebcf43e 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > @@ -3927,6 +3927,8 @@ static int
>     amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>     >        int i, r = 0;
>     >        bool need_full_reset  = *need_full_reset_arg;
>     >
>     > +     amdgpu_debugfs_wait_dump(adev);
>     > +
>     >        /* block all schedulers and reset given job's ring */
>     >        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>     >                struct amdgpu_ring *ring = adev->rings[i];
>


--------------F1F74979E16CDC85E9364F0F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The first application to open the
      autodump node gets the right to use it.<br>
      <br>
      All others only get -EBUSY until the first application is done
      with the hardware.<br>
      <br>
      Christian.<br>
      <br>
      Am 15.05.20 um 04:40 schrieb Zhao, Jiange:<br>
    </div>
    <blockquote type="cite" cite="mid:BY5PR12MB3844CBB43151DE705836A6D3E1BD0@BY5PR12MB3844.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi Dennis,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          This node/feature is for UMR extension. It is designed for a
          single user.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Jiange<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Li,
            Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, May 14, 2020 11:15 PM<br>
            <b>To:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhao, Jiange
            <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Pelloux-prayer,
            Pierre-eric <a class="moz-txt-link-rfc2396E" href="mailto:Pierre-eric.Pelloux-prayer@amd.com">&lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>;
            Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Liu, Monk
            <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Zhang, Hawking
            <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add autodump debugfs
            node for gpu reset v4</font>
          <div>&nbsp;</div>
        </div>
        <style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
        <div link="blue" vlink="purple" style="background-color:white" lang="EN-US">
          <div class="x_WordSection1">
            <p class="x_msipheader4d0fcdd7" style="margin:0in;
              margin-bottom:.0001pt"><span style="font-size:10.0pt;
                font-family:&quot;Arial&quot;,sans-serif; color:#0078D7">[AMD
                Official Use Only - Internal Distribution Only]</span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">&nbsp;</span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">Hi,
                Jiange,</span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                How to handle the case that multi-apps do the auto dump?
                This patch seems not multi-process safety.
              </span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">&nbsp;</span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">Best
                Regards</span></p>
            <p class="x_MsoNormal"><span style="color:windowtext">Dennis
                Li</span></p>
            <div>
              <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                padding:3.0pt 0in 0in 0in">
                <p class="x_MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> amd-gfx
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Christian König<br>
                    <b>Sent:</b> Thursday, May 14, 2020 4:29 PM<br>
                    <b>To:</b> Zhao, Jiange <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Deucher, Alexander
                    <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Pelloux-prayer,
                    Pierre-eric
                    <a class="moz-txt-link-rfc2396E" href="mailto:Pierre-eric.Pelloux-prayer@amd.com">&lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Liu,
                    Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Zhang, Hawking
                    <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump
                    debugfs node for gpu reset v4</span></p>
              </div>
            </div>
            <p class="x_MsoNormal">&nbsp;</p>
            <div>
              <p class="x_MsoNormal">Hi Jiange,<br>
                <br>
                it probably won't hurt, but I would just drop that. You
                need roughly 4 billion GPU resets until the UINT_MAX-1
                becomes zero again.<br>
                <br>
                Christian.<br>
                <br>
                Am 14.05.20 um 09:14 schrieb Zhao, Jiange:</p>
            </div>
            <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
              <p style="margin:15.0pt"><span style="font-size:10.0pt;
                  font-family:&quot;Arial&quot;,sans-serif;
                  color:#0078D7">[AMD Official Use Only - Internal
                  Distribution Only]</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div>
                <div>
                  <p class="x_MsoNormal"><span style="font-size:12.0pt">Hi
                      Christian,</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal"><span style="font-size:12.0pt">&nbsp;</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal">wait_for_completion_interruptible_timeout()
                    would decrease autodump.dumping.done to UINT_MAX-1.<span style="font-size:12.0pt"></span></p>
                </div>
                <div>
                  <p class="x_MsoNormal"><span style="font-size:12.0pt">&nbsp;</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal">complete_all() here would
                    restore autodump.dumping to the state as in
                    amdgpu_debugfs_autodump_init().<span style="font-size:12.0pt"></span></p>
                </div>
                <div>
                  <p class="x_MsoNormal"><span style="font-size:12.0pt">&nbsp;</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal">I want to make sure every
                    open() deals with the same situation.<span style="font-size:12.0pt"></span></p>
                </div>
                <div>
                  <p class="x_MsoNormal"><span style="font-size:12.0pt">&nbsp;</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal">Jiange<span style="font-size:12.0pt"></span></p>
                </div>
                <div class="x_MsoNormal" style="text-align:center" align="center">
                  <hr width="98%" size="2" align="center">
                </div>
                <div id="x_divRplyFwdMsg">
                  <p class="x_MsoNormal"><b>From:</b> Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">
                      &lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                    <b>Sent:</b> Thursday, May 14, 2020 3:01 PM<br>
                    <b>To:</b> Zhao, Jiange <a href="mailto:Jiange.Zhao@amd.com" moz-do-not-send="true">&lt;Jiange.Zhao@amd.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                    <b>Cc:</b> Pelloux-prayer, Pierre-eric <a href="mailto:Pierre-eric.Pelloux-prayer@amd.com" moz-do-not-send="true">
                      &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>;
                    Zhao, Jiange <a href="mailto:Jiange.Zhao@amd.com" moz-do-not-send="true">
                      &lt;Jiange.Zhao@amd.com&gt;</a>; Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
                      &lt;Felix.Kuehling@amd.com&gt;</a>; Deucher,
                    Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                      &lt;Alexander.Deucher@amd.com&gt;</a>; Koenig,
                    Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                      &lt;Christian.Koenig@amd.com&gt;</a>; Liu, Monk <a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">&lt;Monk.Liu@amd.com&gt;</a>;
                    Zhang, Hawking
                    <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump
                    debugfs node for gpu reset v4
                  </p>
                  <div>
                    <p class="x_MsoNormal">&nbsp;</p>
                  </div>
                </div>
                <div>
                  <div>
                    <p class="x_MsoNormal" style="margin-bottom:12.0pt">Am
                      14.05.20 um 07:29 schrieb <a href="mailto:jianzh@amd.com" moz-do-not-send="true">
                        jianzh@amd.com</a>:<br>
                      &gt; From: Jiange Zhao <a href="mailto:Jiange.Zhao@amd.com" moz-do-not-send="true">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                      &gt;<br>
                      &gt; When GPU got timeout, it would notify an
                      interested part<br>
                      &gt; of an opportunity to dump info before actual
                      GPU reset.<br>
                      &gt;<br>
                      &gt; A usermode app would open 'autodump' node
                      under debugfs system<br>
                      &gt; and poll() for readable/writable. When a GPU
                      reset is due,<br>
                      &gt; amdgpu would notify usermode app through
                      wait_queue_head and give<br>
                      &gt; it 10 minutes to dump info.<br>
                      &gt;<br>
                      &gt; After usermode app has done its work, this
                      'autodump' node is closed.<br>
                      &gt; On node closure, amdgpu gets to know the dump
                      is done through<br>
                      &gt; the completion that is triggered in
                      release().<br>
                      &gt;<br>
                      &gt; There is no write or read callback because
                      necessary info can be<br>
                      &gt; obtained through dmesg and umr. Messages back
                      and forth between<br>
                      &gt; usermode app and amdgpu are unnecessary.<br>
                      &gt;<br>
                      &gt; v2: (1) changed 'registered' to
                      'app_listening'<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2) add a mutex in open() to prevent
                      race condition<br>
                      &gt;<br>
                      &gt; v3 (chk): grab the reset lock to avoid race
                      in autodump_open,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rename debugfs file to
                      amdgpu_autodump,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provide autodump_read as well,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; style and code cleanups<br>
                      &gt;<br>
                      &gt; v4: add 'bool app_listening' to differentiate
                      situations, so that<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the node can be reopened; also, there is
                      no need to wait for<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completion when no app is waiting for a
                      dump.<br>
                      &gt;<br>
                      &gt; v5: change 'bool app_listening' to 'enum
                      amdgpu_autodump_state'<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add 'app_state_mutex' for race
                      conditions:<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)Only 1 user can open this file node<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2)wait_dump() can only take effect
                      after poll() executed.<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)eliminated the race condition
                      between release() and<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_dump()<br>
                      &gt;<br>
                      &gt; v6: removed 'enum amdgpu_autodump_state' and
                      'app_state_mutex'<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; removed state checking in
                      amdgpu_debugfs_wait_dump<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Improve on top of version 3 so that the
                      node can be reopened.<br>
                      &gt;<br>
                      &gt; v7: move reinit_completion into open() so
                      that only one user<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can open it.<br>
                      &gt;<br>
                      &gt; Signed-off-by: Jiange Zhao <a href="mailto:Jiange.Zhao@amd.com" moz-do-not-send="true">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                      &gt; ---<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      |&nbsp; 2 &#43;<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                      | 79 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                      |&nbsp; 6 &#43;&#43;<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;
                      |&nbsp; 2 &#43;<br>
                      &gt;&nbsp;&nbsp; 4 files changed, 88 insertions(&#43;), 1
                      deletion(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; index 2a806cb55b78..9e8eeddfe7ce 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; @@ -992,6 &#43;992,8 @@ struct amdgpu_device {<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      product_number[16];<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      product_name[32];<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      serial[16];<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      autodump;<br>
                      &gt;&nbsp;&nbsp; };<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt;&nbsp;&nbsp; static inline struct amdgpu_device
                      *amdgpu_ttm_adev(struct ttm_bo_device *bdev)<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                      &gt; index 1a4894fa3693..efee3f1adecf 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                      &gt; &#43;&#43;&#43;
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                      &gt; @@ -27,7 &#43;27,7 @@<br>
                      &gt;&nbsp;&nbsp; #include &lt;linux/pci.h&gt;<br>
                      &gt;&nbsp;&nbsp; #include &lt;linux/uaccess.h&gt;<br>
                      &gt;&nbsp;&nbsp; #include &lt;linux/pm_runtime.h&gt;<br>
                      &gt; -<br>
                      &gt; &#43;#include &lt;linux/poll.h&gt;<br>
                      &gt;&nbsp;&nbsp; #include &lt;drm/drm_debugfs.h&gt;<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
                      &gt; @@ -74,8 &#43;74,83 @@ int
                      amdgpu_debugfs_add_files(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                      &gt;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;int amdgpu_debugfs_wait_dump(struct
                      amdgpu_device *adev)<br>
                      &gt; &#43;{<br>
                      &gt; &#43;#if defined(CONFIG_DEBUG_FS)<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout = 600 * HZ;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      wake_up_interruptible(&amp;adev-&gt;autodump.gpu_hang);<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =
wait_for_completion_interruptible_timeout(&amp;adev-&gt;autodump.dumping,
                      timeout);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      complete_all(&amp;adev-&gt;autodump.dumping);<br>
                      <br>
                      Sorry that I'm mentioning this only now. But what
                      is this complete_all() <br>
                      here good for?<br>
                      <br>
                      I mean we already waited for completion, didn't
                      we?<br>
                      <br>
                      Christian.<br>
                      <br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == 0) {<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;autodump: timeout, move
                      on to gpu recovery\n&quot;);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; &#43;#endif<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                      &gt; &#43;}<br>
                      &gt; &#43;<br>
                      &gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;static int
                      amdgpu_debugfs_autodump_open(struct inode *inode,
                      struct file *file)<br>
                      &gt; &#43;{<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                      inode-&gt;i_private;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data = adev;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;lock_reset);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.dumping.done) {<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      reinit_completion(&amp;adev-&gt;autodump.dumping);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = 0;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EBUSY;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lock_reset);<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                      &gt; &#43;}<br>
                      &gt; &#43;<br>
                      &gt; &#43;static int
                      amdgpu_debugfs_autodump_release(struct inode
                      *inode, struct file *file)<br>
                      &gt; &#43;{<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                      file-&gt;private_data;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      complete_all(&amp;adev-&gt;autodump.dumping);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                      &gt; &#43;}<br>
                      &gt; &#43;<br>
                      &gt; &#43;static unsigned int
                      amdgpu_debugfs_autodump_poll(struct file *file,
                      struct poll_table_struct *poll_table)<br>
                      &gt; &#43;{<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                      file-&gt;private_data;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file,
                      &amp;adev-&gt;autodump.gpu_hang, poll_table);<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset)<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return POLLIN | POLLRDNORM |
                      POLLWRNORM;<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                      &gt; &#43;}<br>
                      &gt; &#43;<br>
                      &gt; &#43;static const struct file_operations
                      autodump_debug_fops = {<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .open = amdgpu_debugfs_autodump_open,<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .poll = amdgpu_debugfs_autodump_poll,<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release =
                      amdgpu_debugfs_autodump_release,<br>
                      &gt; &#43;};<br>
                      &gt; &#43;<br>
                      &gt; &#43;static void
                      amdgpu_debugfs_autodump_init(struct amdgpu_device
                      *adev)<br>
                      &gt; &#43;{<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      init_completion(&amp;adev-&gt;autodump.dumping);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      complete_all(&amp;adev-&gt;autodump.dumping);<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                      init_waitqueue_head(&amp;adev-&gt;autodump.gpu_hang);<br>
                      &gt; &#43;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_autodump&quot;,
                      0600,<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,
                      &amp;autodump_debug_fops);<br>
                      &gt; &#43;}<br>
                      &gt; &#43;<br>
                      &gt;&nbsp;&nbsp; /**<br>
                      &gt;&nbsp;&nbsp;&nbsp; * amdgpu_debugfs_process_reg_op - Handle
                      MMIO register reads/writes<br>
                      &gt;&nbsp;&nbsp;&nbsp; *<br>
                      &gt; @@ -1434,6 &#43;1509,8 @@ int
                      amdgpu_debugfs_init(struct amdgpu_device *adev)<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_debugfs_create_all(adev);<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_autodump_init(adev);<br>
                      &gt; &#43;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_files(adev,
                      amdgpu_debugfs_list,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      ARRAY_SIZE(amdgpu_debugfs_list));<br>
                      &gt;&nbsp;&nbsp; }<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                      &gt; index de12d1101526..2803884d338d 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                      &gt; &#43;&#43;&#43;
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                      &gt; @@ -31,6 &#43;31,11 @@ struct amdgpu_debugfs {<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_files;<br>
                      &gt;&nbsp;&nbsp; };<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;struct amdgpu_autodump {<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dumping;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      gpu_hang;<br>
                      &gt; &#43;};<br>
                      &gt; &#43;<br>
                      &gt;&nbsp;&nbsp; int amdgpu_debugfs_regs_init(struct
                      amdgpu_device *adev);<br>
                      &gt;&nbsp;&nbsp; int amdgpu_debugfs_init(struct
                      amdgpu_device *adev);<br>
                      &gt;&nbsp;&nbsp; void amdgpu_debugfs_fini(struct
                      amdgpu_device *adev);<br>
                      &gt; @@ -40,3 &#43;45,4 @@ int
                      amdgpu_debugfs_add_files(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp; int amdgpu_debugfs_fence_init(struct
                      amdgpu_device *adev);<br>
                      &gt;&nbsp;&nbsp; int amdgpu_debugfs_firmware_init(struct
                      amdgpu_device *adev);<br>
                      &gt;&nbsp;&nbsp; int amdgpu_debugfs_gem_init(struct
                      amdgpu_device *adev);<br>
                      &gt; &#43;int amdgpu_debugfs_wait_dump(struct
                      amdgpu_device *adev);<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; index cc41e8f5ad14..545beebcf43e 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; &#43;&#43;&#43;
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                      &gt; @@ -3927,6 &#43;3927,8 @@ static int
                      amdgpu_device_pre_asic_reset(struct amdgpu_device
                      *adev,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp; =
                      *need_full_reset_arg;<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<br>
                      &gt; &#43;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset
                      given job's ring */<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS;
                      &#43;&#43;i) {<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                      adev-&gt;rings[i];</p>
                  </div>
                </div>
              </div>
            </blockquote>
            <p class="x_MsoNormal">&nbsp;</p>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------F1F74979E16CDC85E9364F0F--

--===============1474829510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1474829510==--
