Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B88BCA90AF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 08:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C39C2078C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 08:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l9AYM7Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C39C2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BA46E9AC;
	Wed, 13 May 2020 08:20:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CCC6E9AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 08:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW6sfxCgtxSHijBVI6lKKJyInwRzhBXqk+WTnq67fuafXl9XLb3OdTzqoD/uo5NDcINXC3whMQdJ2Hz7Me2aX2V6vYXilL1aSFJvsoRkXDzVhjAMyrp43SlOltpgsbZbhYTYtg1HknvqWXddil0vF1qUOTt9f+s8lhsQG8kPrLyDnIGSo+pRpLGEAsZsZOFfgsLdPNqg9FPSyeb5LWUBAUCYP9lE2TkJEQ3czlGb7cdhRugFpFSyJQxefTvSbUaiAZIqpKvm1GsUWYvBEph/hNjEDfrdoZTs1vF25o38U99Bmub27x56Z7uJibuhOTfeSw28375niDmoRvByMpR0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uor2aBxz3I0LlVIhIRznw1Ac//nqGhIrcznm+6/dgY8=;
 b=Z/uiLURY/P1VYo3upOlQ+YF7FsXetJDKwRqwKlanvfPALievtvjwIBzPQzEUNtnqBjPBo1ifvsam7V0ld1RX2LMRe8oA4uIW3K7iPJvvXNRLDfLmA9+tB8jzXDs2NcXzJEMrrhFMnwongIfNTGlw6E9Gk6zGdn9Ueviobybcrx7uiine6Q/wruE6vR5lWeZawvokWgli0tP92PEVu6u7TPTUJ8RUdn41gl8fXmOFGBGwcahXO9TP5u2TE0zY+7J29h3b1+nFRxzj3Mvto+88oFQANyKoa++RHc1xD6Jv/29FaolwoBCbBgDStcZI5WjpYDjMX/b9nwQHxpq/yZShiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uor2aBxz3I0LlVIhIRznw1Ac//nqGhIrcznm+6/dgY8=;
 b=l9AYM7SyBsWxkAyLGG6WM5W7CzV0oH8VgT36AY89FbjcKCSZ6pvfr4dwYfo1mxCO2CPN84ioaiVqT+qDQ9QngbrmCx38p4L0H8o6cd3l6r2teSjsTJBjZBalwlBgaMvaK68st6mDFeDhXWQwsVBxnzmiBo1SO3/W68lvkleTnMQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Wed, 13 May
 2020 08:20:39 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 08:20:39 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200509094508.28909-1-jianzh@amd.com>
 <BY5PR12MB38445689BC83AF85CF770F19E1BF0@BY5PR12MB3844.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3778093c-dc83-ebf6-aa55-966fe223df5f@amd.com>
Date: Wed, 13 May 2020 10:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BY5PR12MB38445689BC83AF85CF770F19E1BF0@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::18) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 08:20:38 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce378a00-e5e6-4261-173b-08d7f7168516
X-MS-TrafficTypeDiagnostic: DM6PR12MB4354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4354E443958A2F4767862C1C83BF0@DM6PR12MB4354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/ZUbE1cAA5gV249ILbYySNrpIjVbmtOglQSV+aQHB+VxE3jbNYzJPfd+uRv90UbcDN56rxrS/+YjbUI+EtMpYK+Nle7xoqUYpV3N/hnJJPg3MNzsWDRWwfTh4KBnCIo5cnPif0yEPUZq9kuFZFEeFVotM4TjnzHJSFvInvgMbn3ZpX1SNsJ9xfE6VCW34eD/hO/6tV4qsulhfnKThOOmHNL2Z5l9Eg+b3j3iNB2uqu7CCvj4soJ3cZUK9j5ZVgXzwuMvzJuTwXAbsjuqONz9mlNsiktl76RCPSRhMy1VTdoHhFrJ8brvTCvBG64i7uYrRZB5kW5otuN+4GDIhv5MriboftAEMXuBgPeWbL1TDY9EGIjirERFzAbOa1FWUt80r5ehdzSMEBASUhxLbr3ihRuj5AzmwPbu2Z6Tk00blU+/i7TDeXtcEhxf2Te+5uvrBvVeiy4S93eKAkATra1BmaPb8fP0vq7GJ91YawVJ9Z7BE8Ib//OOxqF4AANTVwsn0XZPr7O9xx0JPy97pYQmNRgWUuvHxNH2ajFP/eHYCsDjOFCpAowZAbqpYGnirN0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(33430700001)(54906003)(110136005)(6666004)(19627405001)(33964004)(186003)(16526019)(53546011)(6486002)(52116002)(2616005)(30864003)(4326008)(8936002)(31696002)(478600001)(66946007)(33440700001)(316002)(66476007)(8676002)(66556008)(36756003)(86362001)(2906002)(31686004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: W5N2w65wQfENAFholrF7gdhPIQEKkKPb0X/d3n3sU78pnQ3tNHx/nNkFNYKd0eFZtSBO7rVR02SntEWqkMfcvOefN3zMkVuUybycWVz8w1dThZHnNbeOEPO28g9MnauqhbbieOetOcqtYCuq3nvnVx2uhfPQwZ1e9dIAcutK7CRNhu8mBamqWxu/K0UuTtc5VWwsbHiexGlsbaAFB+q7if6n/Fh581mGPNDxMXV0aaIzE9CX2N1q4x2Co60A3/B5Up0c10WUkWkJgXM52BMI68nye54bxW5b8MRKg6BDT/Skwr9bu7sKfF/+hR7Gc0bNt48WrNHayqLC35kk2yQOuJfs9Dam7CtvPcu0PcTD63aqiXmeRFjqkZO8bSU4GkXHT9QzODEAWhnu7E2Pc65hhCRJoR892owHAAFlwWsiWv8KnyL0D5SgdlepdKNvqYujhQYIfmQLDeikAWD3IsErTnY8kuXr1S5LUKcdKxqjMguvXKDl6R85nPBfAcpQ1RiY+ZbwlBZnTb6EyHbOXj3dtF0Gbb9Sg/KgTp4Aoza77c8FXUUrgaQE90lVu3JFK+uQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce378a00-e5e6-4261-173b-08d7f7168516
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 08:20:39.3638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjlcEnbcj038679NlJ0agy9WfV7GatnqHgj65h6/ugA6MpHV5i7PtKGh3ZHjfmv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0391727476=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0391727476==
Content-Type: multipart/alternative;
 boundary="------------C304ED659962E5D84817CA8D"
Content-Language: en-US

--------------C304ED659962E5D84817CA8D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the reminder, had to much todo yesterday and just forgot 
about it.

Christian.

Am 13.05.20 um 10:16 schrieb Zhao, Jiange:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi @Koenig, Christian <mailto:Christian.Koenig@amd.com>,
>
> I made some changes on top of version 3 and tested it. Can you help 
> review?
>
> Jiange
> ------------------------------------------------------------------------
> *From:* Zhao, Jiange <jianzh@amd.com>
> *Sent:* Saturday, May 9, 2020 5:45 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Pelloux-prayer, 
> Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, 
> Jiange <Jiange.Zhao@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part
> of an opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system
> and poll() for readable/writable. When a GPU reset is due,
> amdgpu would notify usermode app through wait_queue_head and give
> it 10 minutes to dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through
> the completion that is triggered in release().
>
> There is no write or read callback because necessary info can be
> obtained through dmesg and umr. Messages back and forth between
> usermode app and amdgpu are unnecessary.
>
> v2: (1) changed 'registered' to 'app_listening'
>     (2) add a mutex in open() to prevent race condition
>
> v3 (chk): grab the reset lock to avoid race in autodump_open,
>           rename debugfs file to amdgpu_autodump,
>           provide autodump_read as well,
>           style and code cleanups
>
> v4: add 'bool app_listening' to differentiate situations, so that
>     the node can be reopened; also, there is no need to wait for
>     completion when no app is waiting for a dump.
>
> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>     add 'app_state_mutex' for race conditions:
>         (1)Only 1 user can open this file node
>         (2)wait_dump() can only take effect after poll() executed.
>         (3)eliminated the race condition between release() and
>            wait_dump()
>
> v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
>     removed state checking in amdgpu_debugfs_wait_dump
>     Improve on top of version 3 so that the node can be reopened.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 78 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>  4 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a806cb55b78..9e8eeddfe7ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,8 @@ struct amdgpu_device {
>          char product_number[16];
>          char product_name[32];
>          char                            serial[16];
> +
> +       struct amdgpu_autodump          autodump;
>  };
>
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct 
> ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..261b67ece7fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,7 @@
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
>  #include <linux/pm_runtime.h>
> -
> +#include <linux/poll.h>
>  #include <drm/drm_debugfs.h>
>
>  #include "amdgpu.h"
> @@ -74,8 +74,82 @@ int amdgpu_debugfs_add_files(struct amdgpu_device 
> *adev,
>          return 0;
>  }
>
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +       unsigned long timeout = 600 * HZ;
> +       int ret;
> +
> + wake_up_interruptible(&adev->autodump.gpu_hang);
> +
> +       ret = 
> wait_for_completion_interruptible_timeout(&adev->autodump.dumping, 
> timeout);
> +       complete_all(&adev->autodump.dumping);
> +       if (ret == 0) {
> +               pr_err("autodump: timeout, move on to gpu recovery\n");
> +               return -ETIMEDOUT;
> +       }
> +#endif
> +       return 0;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct 
> file *file)
> +{
> +       struct amdgpu_device *adev = inode->i_private;
> +       int ret;
> +
> +       file->private_data = adev;
> +
> +       mutex_lock(&adev->lock_reset);
> +       if (adev->autodump.dumping.done)
> +               ret = 0;
> +       else
> +               ret = -EBUSY;
> +       mutex_unlock(&adev->lock_reset);
> +
> +       return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, 
> struct file *file)
> +{
> +       struct amdgpu_device *adev = file->private_data;
> +
> +       complete_all(&adev->autodump.dumping);
> +       return 0;
> +}
> +
> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, 
> struct poll_table_struct *poll_table)
> +{
> +       struct amdgpu_device *adev = file->private_data;
> +
> + reinit_completion(&adev->autodump.dumping);
> +       poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> +
> +       if (adev->in_gpu_reset)
> +               return POLLIN | POLLRDNORM | POLLWRNORM;
> +
> +       return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops = {
> +       .owner = THIS_MODULE,
> +       .open = amdgpu_debugfs_autodump_open,
> +       .poll = amdgpu_debugfs_autodump_poll,
> +       .release = amdgpu_debugfs_autodump_release,
> +};
> +
> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +       init_completion(&adev->autodump.dumping);
> +       complete_all(&adev->autodump.dumping);
> + init_waitqueue_head(&adev->autodump.gpu_hang);
> +
> +       debugfs_create_file("amdgpu_autodump", 0600,
> + adev->ddev->primary->debugfs_root,
> +               adev, &autodump_debug_fops);
> +}
> +
>  /**
>   * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>   *
> @@ -1434,6 +1508,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>
>          amdgpu_ras_debugfs_create_all(adev);
>
> +       amdgpu_debugfs_autodump_init(adev);
> +
>          return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
> ARRAY_SIZE(amdgpu_debugfs_list));
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..2803884d338d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -31,6 +31,11 @@ struct amdgpu_debugfs {
>          unsigned                num_files;
>  };
>
> +struct amdgpu_autodump {
> +       struct completion               dumping;
> +       struct wait_queue_head          gpu_hang;
> +};
> +
>  int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> @@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>  int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc41e8f5ad14..545beebcf43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3927,6 +3927,8 @@ static int amdgpu_device_pre_asic_reset(struct 
> amdgpu_device *adev,
>          int i, r = 0;
>          bool need_full_reset  = *need_full_reset_arg;
>
> +       amdgpu_debugfs_wait_dump(adev);
> +
>          /* block all schedulers and reset given job's ring */
>          for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>                  struct amdgpu_ring *ring = adev->rings[i];
> -- 
> 2.20.1
>


--------------C304ED659962E5D84817CA8D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Thanks for the reminder, had to much
      todo yesterday and just forgot about it.<br>
      <br>
      Christian.<br>
      <br>
      Am 13.05.20 um 10:16 schrieb Zhao, Jiange:<br>
    </div>
    <blockquote type="cite" cite="mid:BY5PR12MB38445689BC83AF85CF770F19E1BF0@BY5PR12MB3844.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi <a id="OWAAM832723" class="_1OtrSZdhKXVv3UhaivrdJ4 mention
            ms-bgc-nlr ms-fcl-b" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
            @Koenig, Christian</a>,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I made some changes on top of version 3 and tested it. Can you
          help review?</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Jiange<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Zhao, Jiange <a class="moz-txt-link-rfc2396E" href="mailto:jianzh@amd.com">&lt;jianzh@amd.com&gt;</a><br>
            <b>Sent:</b> Saturday, May 9, 2020 5:45 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Pelloux-prayer,
            Pierre-eric <a class="moz-txt-link-rfc2396E" href="mailto:Pierre-eric.Pelloux-prayer@amd.com">&lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>;
            Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Liu,
            Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Zhao, Jiange
            <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: Add autodump debugfs
            node for gpu reset v4</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">From: Jiange Zhao
                <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                <br>
                When GPU got timeout, it would notify an interested part<br>
                of an opportunity to dump info before actual GPU reset.<br>
                <br>
                A usermode app would open 'autodump' node under debugfs
                system<br>
                and poll() for readable/writable. When a GPU reset is
                due,<br>
                amdgpu would notify usermode app through wait_queue_head
                and give<br>
                it 10 minutes to dump info.<br>
                <br>
                After usermode app has done its work, this 'autodump'
                node is closed.<br>
                On node closure, amdgpu gets to know the dump is done
                through<br>
                the completion that is triggered in release().<br>
                <br>
                There is no write or read callback because necessary
                info can be<br>
                obtained through dmesg and umr. Messages back and forth
                between<br>
                usermode app and amdgpu are unnecessary.<br>
                <br>
                v2: (1) changed 'registered' to 'app_listening'<br>
                &nbsp;&nbsp;&nbsp; (2) add a mutex in open() to prevent race condition<br>
                <br>
                v3 (chk): grab the reset lock to avoid race in
                autodump_open,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rename debugfs file to amdgpu_autodump,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provide autodump_read as well,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; style and code cleanups<br>
                <br>
                v4: add 'bool app_listening' to differentiate
                situations, so that<br>
                &nbsp;&nbsp;&nbsp; the node can be reopened; also, there is no need to
                wait for<br>
                &nbsp;&nbsp;&nbsp; completion when no app is waiting for a dump.<br>
                <br>
                v5: change 'bool app_listening' to 'enum
                amdgpu_autodump_state'<br>
                &nbsp;&nbsp;&nbsp; add 'app_state_mutex' for race conditions:<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)Only 1 user can open this file node<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2)wait_dump() can only take effect after poll()
                executed.<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)eliminated the race condition between
                release() and<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_dump()<br>
                <br>
                v6: removed 'enum amdgpu_autodump_state' and
                'app_state_mutex'<br>
                &nbsp;&nbsp;&nbsp; removed state checking in amdgpu_debugfs_wait_dump<br>
                &nbsp;&nbsp;&nbsp; Improve on top of version 3 so that the node can be
                reopened.<br>
                <br>
                Signed-off-by: Jiange Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zhao@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 78
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 6 &#43;&#43;<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2 &#43;<br>
                &nbsp;4 files changed, 87 insertions(&#43;), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                index 2a806cb55b78..9e8eeddfe7ce 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                @@ -992,6 &#43;992,8 @@ struct amdgpu_device {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                product_number[16];<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                product_name[32];<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[16];<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
                &nbsp;};<br>
                &nbsp;<br>
                &nbsp;static inline struct amdgpu_device
                *amdgpu_ttm_adev(struct ttm_bo_device *bdev)<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                index 1a4894fa3693..261b67ece7fb 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                @@ -27,7 &#43;27,7 @@<br>
                &nbsp;#include &lt;linux/pci.h&gt;<br>
                &nbsp;#include &lt;linux/uaccess.h&gt;<br>
                &nbsp;#include &lt;linux/pm_runtime.h&gt;<br>
                -<br>
                &#43;#include &lt;linux/poll.h&gt;<br>
                &nbsp;#include &lt;drm/drm_debugfs.h&gt;<br>
                &nbsp;<br>
                &nbsp;#include &quot;amdgpu.h&quot;<br>
                @@ -74,8 &#43;74,82 @@ int amdgpu_debugfs_add_files(struct
                amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &nbsp;}<br>
                &nbsp;<br>
                &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device
                *adev)<br>
                &#43;{<br>
                &#43;#if defined(CONFIG_DEBUG_FS)<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout = 600 * HZ;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                wake_up_interruptible(&amp;adev-&gt;autodump.gpu_hang);<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
wait_for_completion_interruptible_timeout(&amp;adev-&gt;autodump.dumping,
                timeout);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == 0) {<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;autodump: timeout, move on to
                gpu recovery\n&quot;);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &#43;#endif<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &#43;}<br>
                &#43;<br>
                &nbsp;#if defined(CONFIG_DEBUG_FS)<br>
                &nbsp;<br>
                &#43;static int amdgpu_debugfs_autodump_open(struct inode
                *inode, struct file *file)<br>
                &#43;{<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                inode-&gt;i_private;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data = adev;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;lock_reset);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.dumping.done)<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = 0;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EBUSY;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lock_reset);<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                &#43;}<br>
                &#43;<br>
                &#43;static int amdgpu_debugfs_autodump_release(struct inode
                *inode, struct file *file)<br>
                &#43;{<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                file-&gt;private_data;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &#43;}<br>
                &#43;<br>
                &#43;static unsigned int amdgpu_debugfs_autodump_poll(struct
                file *file, struct poll_table_struct *poll_table)<br>
                &#43;{<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                file-&gt;private_data;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                reinit_completion(&amp;adev-&gt;autodump.dumping);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;autodump.gpu_hang,
                poll_table);<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset)<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return POLLIN | POLLRDNORM | POLLWRNORM;<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &#43;}<br>
                &#43;<br>
                &#43;static const struct file_operations autodump_debug_fops
                = {<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open = amdgpu_debugfs_autodump_open,<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .poll = amdgpu_debugfs_autodump_poll,<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release = amdgpu_debugfs_autodump_release,<br>
                &#43;};<br>
                &#43;<br>
                &#43;static void amdgpu_debugfs_autodump_init(struct
                amdgpu_device *adev)<br>
                &#43;{<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;autodump.dumping);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dumping);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                init_waitqueue_head(&amp;adev-&gt;autodump.gpu_hang);<br>
                &#43;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_autodump&quot;, 0600,<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;autodump_debug_fops);<br>
                &#43;}<br>
                &#43;<br>
                &nbsp;/**<br>
                &nbsp; * amdgpu_debugfs_process_reg_op - Handle MMIO register
                reads/writes<br>
                &nbsp; *<br>
                @@ -1434,6 &#43;1508,8 @@ int amdgpu_debugfs_init(struct
                amdgpu_device *adev)<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_debugfs_create_all(adev);<br>
                &nbsp;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_autodump_init(adev);<br>
                &#43;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_files(adev,
                amdgpu_debugfs_list,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ARRAY_SIZE(amdgpu_debugfs_list));<br>
                &nbsp;}<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                index de12d1101526..2803884d338d 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                @@ -31,6 &#43;31,11 @@ struct amdgpu_debugfs {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_files;<br>
                &nbsp;};<br>
                &nbsp;<br>
                &#43;struct amdgpu_autodump {<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dumping;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang;<br>
                &#43;};<br>
                &#43;<br>
                &nbsp;int amdgpu_debugfs_regs_init(struct amdgpu_device
                *adev);<br>
                &nbsp;int amdgpu_debugfs_init(struct amdgpu_device *adev);<br>
                &nbsp;void amdgpu_debugfs_fini(struct amdgpu_device *adev);<br>
                @@ -40,3 &#43;45,4 @@ int amdgpu_debugfs_add_files(struct
                amdgpu_device *adev,<br>
                &nbsp;int amdgpu_debugfs_fence_init(struct amdgpu_device
                *adev);<br>
                &nbsp;int amdgpu_debugfs_firmware_init(struct amdgpu_device
                *adev);<br>
                &nbsp;int amdgpu_debugfs_gem_init(struct amdgpu_device
                *adev);<br>
                &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device
                *adev);<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index cc41e8f5ad14..545beebcf43e 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -3927,6 &#43;3927,8 @@ static int
                amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp; = *need_full_reset_arg;<br>
                &nbsp;<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<br>
                &#43;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset given job's
                ring */<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; &#43;&#43;i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                -- <br>
                2.20.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C304ED659962E5D84817CA8D--

--===============0391727476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0391727476==--
