Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA8FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 08:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E66A206B6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 08:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNlReQ1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E66A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12366E30E;
	Thu, 14 May 2020 08:28:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05676E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 08:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNvWdvmUGtH/SQwhgjXADcHYoFw8/iBfPZX4m4G3w8ikjdE6TINf8dRctdR4rjVSjWeQIhbConLVeppRHoK5GQbvnwuJZac72vKLTeZDg8cM50CZtBjShp/xmqz7fKtN59CLRklHCJeg0j4DDSpPWKYf8g+52yQLCKTmp46+aFndNyNH/hRKBYDfa9RRcG971WdnKnIgLP4P93wwI55fDpw2oOoGYW93IoB/vYsJa+hXXzWKT2SULYBZm281qW0zJOa7aLt7Mxm3guLYnQcEBExQiDgu5J+K9qfZDxLnLzZYP26rcCzSRDhnxoAJeTsDD0g1QS/c/BfuzJrA0m33MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57/cRRwREOpYOr99HF4kXGkUFgilpSQWIgpINXrk2dU=;
 b=ZoyqipfqmldwiA+8nnZtS4+UtmshE0D120z7IkBaFqFtI5FPIV+RNGgCIhgLXnJ7GupkTRaUIei8u51GWEf7hxqHIaGmI1WHufEw4XYktCNRacP+PBqg4gYvDmM8ZLplR/L7q2nyM58w2Msf4mS0McHRETmmnPDR/8HaaPPKc3Htp5M3DNPpOunkZUvFAaSsv5yT7bMpv2JO7dZKenGnXefGjLYRlNNu2DhrVg79pr3roRJnGkdN7IdNMpQvvxDRdTYsYE2SPiUW7E6SZTu3Bs5KVdhtwBgG+u/Ribq7YnocVOjKivyggkr9OBElGImHCIXnncYB9EE+vUfYhqR9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57/cRRwREOpYOr99HF4kXGkUFgilpSQWIgpINXrk2dU=;
 b=dNlReQ1cyxcY2zsS0WmDjfZtc5Nw+nuAwYqx6yNrjFLkLr7bCNGyGD4+S/Bq3GIdZZvf3Mj9te9Pm24O+hKVuJff8VZMbgWqyf+gRjYFR3CXMRhq8kN9fuJ21nurCk0Rzpk4r0TZh/HBR6mmLTnsn7kJB/xch09pwKFoWTo/D8E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 08:28:39 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 08:28:39 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200514052952.19260-1-jianzh@amd.com>
 <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
 <BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2b3b8be1-2627-d58b-56f6-d6bb915aefcd@amd.com>
Date: Thu, 14 May 2020 10:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::14) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0109.eurprd06.prod.outlook.com (2603:10a6:208:ab::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 08:28:37 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7ff555d-c803-4bd2-3d18-08d7f7e0cd77
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:|DM6PR12MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779E9D56ACDB337CD51656B83BC0@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNl2LSko7lD6hUwS/SVo5Jo7J1kTqqelZlah+I64C80JinSJP/Q5Jd+TiGpYTwl+AxA3WAGepkSs6ZTemNDhAoN6gO24j9ikcG+ZYSNqxwr1RjnRsPpgjKDbeJNUh3GbepucyD9OTNM+92fodVpjroMYTx+llEbTI39PP2AHB4XOMh97HhCLLUU+04v7ewao1MZ97FZzMCYM4ZVLTuaIwxTY+bcaYIVzKSwfTbSeczsr6i4uTvidByC0JusAO3BJKoQiXs+0uDa7rDmxIDmcxEc/4pBbIZtHuBnwHm5lX2P9597Chp2PSCrrpODycYpqJs6gsIUk+AJL0k2l/FqywB703hN8MHxETZMydB+NIFtoGLm6cE9UKLxDu2E7pmvkYJ68M7abZUGv1/GXZtX0W6lloHpIxr1navSqXurz96/jtthVP5uRB+a+39o8v2cFzmHSY8WgfBsm7CEzahfOds854HEloOI88ZfXsz+we9GWU0ALWh5X76XUG4X2j2V6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(8676002)(478600001)(2616005)(31686004)(110136005)(36756003)(54906003)(316002)(66574014)(2906002)(31696002)(53546011)(6666004)(8936002)(16526019)(19627405001)(66556008)(52116002)(66476007)(6486002)(86362001)(5660300002)(66946007)(30864003)(4326008)(186003)(33964004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xhy4U3aUBC6X53XqCQL8683uEFgsgMsEwdh/m8XMjb8vAWxlEV796aV7RZTz1KH+K7bYcisjiAulSGtCpsLYfyi96d3Bejsp9hGY61T5I7LDXDniXwjnfhxak4hhzxEUS3Ord5egLx2o3HpARjtXmOxy7pwXQGnIBr/VjX7n6IzVE0w0/hre5LnGWRHoMfexC+2A4svlU2Zpf1q0xMFljFrY2itOUK4OwfW8EVZVnl/mkO45HKwJU4wf60XW1fdBLwdIJhrT5t1ZpauliDCb6GevIOF9Y6kE+VIyEndMX+VyuFUuUYtqixUzDv24EO1fe+eDdZpVdHPAQsC/++iTmP2d/y1D55QLOh172w44mC87o41zxwmRr7uURmNlOlO7lFggIaYW3CVA5ZJscKHb49HALESR73O8ZLmlvWxF9Ao0IOrM6oAic3KeinJqiDTfLndl3uHIBUJw13hUDoLirxf48Iipx1kNh0/UIxoaMJl6gWAAwr1p8nX8Y0WL7KNq/nzVsu6g9wbFc5Up+Uj55Io+61D/57Q+lEE8qFtePxhrLW854ZlT4HTVzYB2qxST
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ff555d-c803-4bd2-3d18-08d7f7e0cd77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 08:28:39.2702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5exLfw/dfQTeX9ftAp6PiVEfaAO9OUen6sI6F1qOXryQjjFLrCPQFKjQlSUxxZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
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
Content-Type: multipart/mixed; boundary="===============0956957633=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0956957633==
Content-Type: multipart/alternative;
 boundary="------------6197AC80FF06F36D0D7DA28F"
Content-Language: en-US

--------------6197AC80FF06F36D0D7DA28F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiange,

it probably won't hurt, but I would just drop that. You need roughly 4 
billion GPU resets until the UINT_MAX-1 becomes zero again.

Christian.

Am 14.05.20 um 09:14 schrieb Zhao, Jiange:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Christian,
>
> wait_for_completion_interruptible_timeout() would decrease 
> autodump.dumping.done to UINT_MAX-1.
>
> complete_all() here would restore autodump.dumping to the state as in 
> amdgpu_debugfs_autodump_init().
>
> I want to make sure every open() deals with the same situation.
>
> Jiange
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Thursday, May 14, 2020 3:01 PM
> *To:* Zhao, Jiange <Jiange.Zhao@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Pelloux-prayer, Pierre-eric 
> <Pierre-eric.Pelloux-prayer@amd.com>; Zhao, Jiange 
> <Jiange.Zhao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, 
> Hawking <Hawking.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu 
> reset v4
> Am 14.05.20 um 07:29 schrieb jianzh@amd.com:
> > From: Jiange Zhao <Jiange.Zhao@amd.com>
> >
> > When GPU got timeout, it would notify an interested part
> > of an opportunity to dump info before actual GPU reset.
> >
> > A usermode app would open 'autodump' node under debugfs system
> > and poll() for readable/writable. When a GPU reset is due,
> > amdgpu would notify usermode app through wait_queue_head and give
> > it 10 minutes to dump info.
> >
> > After usermode app has done its work, this 'autodump' node is closed.
> > On node closure, amdgpu gets to know the dump is done through
> > the completion that is triggered in release().
> >
> > There is no write or read callback because necessary info can be
> > obtained through dmesg and umr. Messages back and forth between
> > usermode app and amdgpu are unnecessary.
> >
> > v2: (1) changed 'registered' to 'app_listening'
> >      (2) add a mutex in open() to prevent race condition
> >
> > v3 (chk): grab the reset lock to avoid race in autodump_open,
> >            rename debugfs file to amdgpu_autodump,
> >            provide autodump_read as well,
> >            style and code cleanups
> >
> > v4: add 'bool app_listening' to differentiate situations, so that
> >      the node can be reopened; also, there is no need to wait for
> >      completion when no app is waiting for a dump.
> >
> > v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
> >      add 'app_state_mutex' for race conditions:
> >        (1)Only 1 user can open this file node
> >        (2)wait_dump() can only take effect after poll() executed.
> >        (3)eliminated the race condition between release() and
> >           wait_dump()
> >
> > v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
> >      removed state checking in amdgpu_debugfs_wait_dump
> >      Improve on top of version 3 so that the node can be reopened.
> >
> > v7: move reinit_completion into open() so that only one user
> >      can open it.
> >
> > Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79 ++++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
> >   4 files changed, 88 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 2a806cb55b78..9e8eeddfe7ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -992,6 +992,8 @@ struct amdgpu_device {
> >        char product_number[16];
> >        char product_name[32];
> >        char                            serial[16];
> > +
> > +     struct amdgpu_autodump          autodump;
> >   };
> >
> >   static inline struct amdgpu_device *amdgpu_ttm_adev(struct 
> ttm_bo_device *bdev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 1a4894fa3693..efee3f1adecf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -27,7 +27,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/pm_runtime.h>
> > -
> > +#include <linux/poll.h>
> >   #include <drm/drm_debugfs.h>
> >
> >   #include "amdgpu.h"
> > @@ -74,8 +74,83 @@ int amdgpu_debugfs_add_files(struct amdgpu_device 
> *adev,
> >        return 0;
> >   }
> >
> > +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> > +{
> > +#if defined(CONFIG_DEBUG_FS)
> > +     unsigned long timeout = 600 * HZ;
> > +     int ret;
> > +
> > + wake_up_interruptible(&adev->autodump.gpu_hang);
> > +
> > +     ret = 
> wait_for_completion_interruptible_timeout(&adev->autodump.dumping, 
> timeout);
> > +     complete_all(&adev->autodump.dumping);
>
> Sorry that I'm mentioning this only now. But what is this complete_all()
> here good for?
>
> I mean we already waited for completion, didn't we?
>
> Christian.
>
> > +     if (ret == 0) {
> > +             pr_err("autodump: timeout, move on to gpu recovery\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +#endif
> > +     return 0;
> > +}
> > +
> >   #if defined(CONFIG_DEBUG_FS)
> >
> > +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct 
> file *file)
> > +{
> > +     struct amdgpu_device *adev = inode->i_private;
> > +     int ret;
> > +
> > +     file->private_data = adev;
> > +
> > +     mutex_lock(&adev->lock_reset);
> > +     if (adev->autodump.dumping.done) {
> > + reinit_completion(&adev->autodump.dumping);
> > +             ret = 0;
> > +     } else {
> > +             ret = -EBUSY;
> > +     }
> > +     mutex_unlock(&adev->lock_reset);
> > +
> > +     return ret;
> > +}
> > +
> > +static int amdgpu_debugfs_autodump_release(struct inode *inode, 
> struct file *file)
> > +{
> > +     struct amdgpu_device *adev = file->private_data;
> > +
> > +     complete_all(&adev->autodump.dumping);
> > +     return 0;
> > +}
> > +
> > +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, 
> struct poll_table_struct *poll_table)
> > +{
> > +     struct amdgpu_device *adev = file->private_data;
> > +
> > +     poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> > +
> > +     if (adev->in_gpu_reset)
> > +             return POLLIN | POLLRDNORM | POLLWRNORM;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations autodump_debug_fops = {
> > +     .owner = THIS_MODULE,
> > +     .open = amdgpu_debugfs_autodump_open,
> > +     .poll = amdgpu_debugfs_autodump_poll,
> > +     .release = amdgpu_debugfs_autodump_release,
> > +};
> > +
> > +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> > +{
> > + init_completion(&adev->autodump.dumping);
> > +     complete_all(&adev->autodump.dumping);
> > + init_waitqueue_head(&adev->autodump.gpu_hang);
> > +
> > +     debugfs_create_file("amdgpu_autodump", 0600,
> > + adev->ddev->primary->debugfs_root,
> > +             adev, &autodump_debug_fops);
> > +}
> > +
> >   /**
> >    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> >    *
> > @@ -1434,6 +1509,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
> *adev)
> >
> >        amdgpu_ras_debugfs_create_all(adev);
> >
> > +     amdgpu_debugfs_autodump_init(adev);
> > +
> >        return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
> > ARRAY_SIZE(amdgpu_debugfs_list));
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> > index de12d1101526..2803884d338d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> > @@ -31,6 +31,11 @@ struct amdgpu_debugfs {
> >        unsigned                num_files;
> >   };
> >
> > +struct amdgpu_autodump {
> > +     struct completion               dumping;
> > +     struct wait_queue_head          gpu_hang;
> > +};
> > +
> >   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> >   int amdgpu_debugfs_init(struct amdgpu_device *adev);
> >   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> > @@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device 
> *adev,
> >   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
> >   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> >   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> > +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cc41e8f5ad14..545beebcf43e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3927,6 +3927,8 @@ static int amdgpu_device_pre_asic_reset(struct 
> amdgpu_device *adev,
> >        int i, r = 0;
> >        bool need_full_reset  = *need_full_reset_arg;
> >
> > +     amdgpu_debugfs_wait_dump(adev);
> > +
> >        /* block all schedulers and reset given job's ring */
> >        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> >                struct amdgpu_ring *ring = adev->rings[i];
>


--------------6197AC80FF06F36D0D7DA28F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Jiange,<br>
      <br>
      it probably won't hurt, but I would just drop that. You need
      roughly 4 billion GPU resets until the UINT_MAX-1 becomes zero
      again.<br>
      <br>
      Christian.<br>
      <br>
      Am 14.05.20 um 09:14 schrieb Zhao, Jiange:<br>
    </div>
    <blockquote type="cite" cite="mid:BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi Christian,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">wait_for_completion_interruptible_timeout()
              would decrease autodump.dumping.done to UINT_MAX-1.</span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
          <font size="2"><span style="font-size:11pt"></span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">complete_all()
              here would restore autodump.dumping to the state as in
              <font size="2"><span style="font-size:11pt">amdgpu_debugfs_autodump_init</span></font>().</span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt"><br>
            </span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">I want to make
              sure every open() deals with the same situation.</span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt"><br>
            </span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">Jiange</span></font><br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Thursday, May 14, 2020 3:01 PM<br>
            <b>To:</b> Zhao, Jiange <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Pelloux-prayer, Pierre-eric
            <a class="moz-txt-link-rfc2396E" href="mailto:Pierre-eric.Pelloux-prayer@amd.com">&lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>; Zhao, Jiange
            <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Liu, Monk
            <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Zhang, Hawking
            <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump debugfs
            node for gpu reset v4</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 14.05.20 um 07:29 schrieb
                <a class="moz-txt-link-abbreviated" href="mailto:jianzh@amd.com">jianzh@amd.com</a>:<br>
                &gt; From: Jiange Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                &gt;<br>
                &gt; When GPU got timeout, it would notify an interested
                part<br>
                &gt; of an opportunity to dump info before actual GPU
                reset.<br>
                &gt;<br>
                &gt; A usermode app would open 'autodump' node under
                debugfs system<br>
                &gt; and poll() for readable/writable. When a GPU reset
                is due,<br>
                &gt; amdgpu would notify usermode app through
                wait_queue_head and give<br>
                &gt; it 10 minutes to dump info.<br>
                &gt;<br>
                &gt; After usermode app has done its work, this
                'autodump' node is closed.<br>
                &gt; On node closure, amdgpu gets to know the dump is
                done through<br>
                &gt; the completion that is triggered in release().<br>
                &gt;<br>
                &gt; There is no write or read callback because
                necessary info can be<br>
                &gt; obtained through dmesg and umr. Messages back and
                forth between<br>
                &gt; usermode app and amdgpu are unnecessary.<br>
                &gt;<br>
                &gt; v2: (1) changed 'registered' to 'app_listening'<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2) add a mutex in open() to prevent race
                condition<br>
                &gt;<br>
                &gt; v3 (chk): grab the reset lock to avoid race in
                autodump_open,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rename debugfs file to amdgpu_autodump,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provide autodump_read as well,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; style and code cleanups<br>
                &gt;<br>
                &gt; v4: add 'bool app_listening' to differentiate
                situations, so that<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the node can be reopened; also, there is no
                need to wait for<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completion when no app is waiting for a dump.<br>
                &gt;<br>
                &gt; v5: change 'bool app_listening' to 'enum
                amdgpu_autodump_state'<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add 'app_state_mutex' for race conditions:<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)Only 1 user can open this file node<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2)wait_dump() can only take effect after
                poll() executed.<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)eliminated the race condition between
                release() and<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_dump()<br>
                &gt;<br>
                &gt; v6: removed 'enum amdgpu_autodump_state' and
                'app_state_mutex'<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; removed state checking in
                amdgpu_debugfs_wait_dump<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Improve on top of version 3 so that the node
                can be reopened.<br>
                &gt;<br>
                &gt; v7: move reinit_completion into open() so that only
                one user<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can open it.<br>
                &gt;<br>
                &gt; Signed-off-by: Jiange Zhao
                <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2
                &#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 6
                &#43;&#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2
                &#43;<br>
                &gt;&nbsp;&nbsp; 4 files changed, 88 insertions(&#43;), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; index 2a806cb55b78..9e8eeddfe7ce 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; @@ -992,6 &#43;992,8 @@ struct amdgpu_device {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                product_number[16];<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                product_name[32];<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[16];<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; static inline struct amdgpu_device
                *amdgpu_ttm_adev(struct ttm_bo_device *bdev)<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt; index 1a4894fa3693..efee3f1adecf 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
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
                amdgpu_debugfs_add_files(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device
                *adev)<br>
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
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                <br>
                Sorry that I'm mentioning this only now. But what is
                this complete_all() <br>
                here good for?<br>
                <br>
                I mean we already waited for completion, didn't we?<br>
                <br>
                Christian.<br>
                <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == 0) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;autodump: timeout, move on to
                gpu recovery\n&quot;);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt; &#43;#endif<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt; &#43;}<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;static int amdgpu_debugfs_autodump_open(struct
                inode *inode, struct file *file)<br>
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
                &gt; &#43;static int amdgpu_debugfs_autodump_release(struct
                inode *inode, struct file *file)<br>
                &gt; &#43;{<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                file-&gt;private_data;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt; &#43;}<br>
                &gt; &#43;<br>
                &gt; &#43;static unsigned int
                amdgpu_debugfs_autodump_poll(struct file *file, struct
                poll_table_struct *poll_table)<br>
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
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release = amdgpu_debugfs_autodump_release,<br>
                &gt; &#43;};<br>
                &gt; &#43;<br>
                &gt; &#43;static void amdgpu_debugfs_autodump_init(struct
                amdgpu_device *adev)<br>
                &gt; &#43;{<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                init_completion(&amp;adev-&gt;autodump.dumping);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;
                init_waitqueue_head(&amp;adev-&gt;autodump.gpu_hang);<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_autodump&quot;, 0600,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;autodump_debug_fops);<br>
                &gt; &#43;}<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp; /**<br>
                &gt;&nbsp;&nbsp;&nbsp; * amdgpu_debugfs_process_reg_op - Handle MMIO
                register reads/writes<br>
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
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                &gt; @@ -31,6 &#43;31,11 @@ struct amdgpu_debugfs {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_files;<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;struct amdgpu_autodump {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dumping;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang;<br>
                &gt; &#43;};<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp; int amdgpu_debugfs_regs_init(struct amdgpu_device
                *adev);<br>
                &gt;&nbsp;&nbsp; int amdgpu_debugfs_init(struct amdgpu_device
                *adev);<br>
                &gt;&nbsp;&nbsp; void amdgpu_debugfs_fini(struct amdgpu_device
                *adev);<br>
                &gt; @@ -40,3 &#43;45,4 @@ int
                amdgpu_debugfs_add_files(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp; int amdgpu_debugfs_fence_init(struct
                amdgpu_device *adev);<br>
                &gt;&nbsp;&nbsp; int amdgpu_debugfs_firmware_init(struct
                amdgpu_device *adev);<br>
                &gt;&nbsp;&nbsp; int amdgpu_debugfs_gem_init(struct amdgpu_device
                *adev);<br>
                &gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device
                *adev);<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; index cc41e8f5ad14..545beebcf43e 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; @@ -3927,6 &#43;3927,8 @@ static int
                amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp; =
                *need_full_reset_arg;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset given
                job's ring */<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; &#43;&#43;i) {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------6197AC80FF06F36D0D7DA28F--

--===============0956957633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0956957633==--
