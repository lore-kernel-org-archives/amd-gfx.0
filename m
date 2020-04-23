Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90CC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC15321569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RYymMQBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC15321569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA556E083;
	Thu, 23 Apr 2020 07:56:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC28B89F38
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCrjAEhNvaJLb1ErzVLYjxKtBD4s1RpZ93GuCew6XuYnHlQn4keoOliMCaW9yWrVlmWbi2r3CUWpoF3/y/ku1XBV+SsQCd2mO2xmRHv2ifLgG2m2ib+vEtbnneXyB8xmiEyEVNZkActMqj4ehr+YyyTALu/DVwgSBkcHXFQUAum/ZU4Fda7sUUyz5+OfgPwuIFLfCehRwN3K+hpopyVsdP2sEfvQRG6HSABAVOWfiRB+DkyYtHHev+PVFv23nVEnwZf67iavvobLgyM0gWB13Hh3kcySs+TulkY8KU24wl0wJMy5Mh22o2W2qPYFr8bhFHRhweevul2Vp/VdeTh8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1QlIRTkYKo2xkwRlU0/oaCd++vmx/HDuasCeD+/S2o=;
 b=cF9ZgOawgM+XWDxbZhRvzbstPOdkrQdoFUFRS/G15ym52q4J+eWfPUtENPwUMbX2Z+Ks+Q6ohkA6ml0+nAH37yTRp5+9xpQ82kjLS/075ppWrgsumx0XGZldftAVGRZOHlyvUzN4RdvMkk89qTNBaNlSXnXoPNv7Xuj1YXdPePqucNgxJCYh79wLdlqcrRa2+NnGbTP8QuxiLoTS+ZuQ8J0A9bX5siooOhIS7CGdrJ+c4MHE5q5SGjbvSybxqw36m37NE1DsuIMxWeorw8LFdf00wUyCXssypUkROOD2xWf0sQedpP/+0WpKYuN7xZ2aWxTBYi2B/M8NDHlCyMkKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1QlIRTkYKo2xkwRlU0/oaCd++vmx/HDuasCeD+/S2o=;
 b=RYymMQBtY9tAcqz67v9CrKG03h0Z79yR9g6zAvDpDarsVt9QM7yT9M5HIeLZwfcvsaK44ieBQ/FPHeoXrx2LsL/sOLhMNwCU72OoBA2jqnbAsj6n/cpFJ0MRKIZNfqZKFrlGWUfQX1vmSzJHDWVcnOgMgYAkGqXiF4U+JPxKh58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 23 Apr
 2020 07:56:49 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 07:56:48 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200423071941.17440-1-jianzh@amd.com>
 <DM5PR12MB17086B8DDF96EA605925575E84D30@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB17084210FA29054678C0BC1484D30@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a15e8611-41a4-a9f7-7c4a-6a6cc7056e3a@amd.com>
Date: Thu, 23 Apr 2020 09:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM5PR12MB17084210FA29054678C0BC1484D30@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 07:56:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8190009e-a3d5-4bca-4559-08d7e75be039
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:|DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2748B2397088854BC2A40D6E83D30@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(36756003)(66556008)(53546011)(52116002)(31696002)(4326008)(2906002)(6486002)(8936002)(86362001)(966005)(66476007)(478600001)(6666004)(316002)(16526019)(110136005)(186003)(5660300002)(45080400002)(54906003)(81156014)(66946007)(2616005)(31686004)(8676002)(21314003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHj3brAhsZna8DLRM7XagfUVorxv6qXb1SIlbAE6VPgIpD5/3ZRJ59fa58d4WTuYIdjkeBP2g2yQWc9rj07sK6in0HKJorjIkCcxCPuBVAqTg7tpyIEQqewy8O3ZuN7nj/qk8V+Av501t1Ks8UMCsiaawfZuVVaxF83Y+/5eFXrC3hqYMTefzRMPPWiFBKko3KaHZ9IC3Bdh91myBVjektfvIZ3hfup05LqEpfzrpCxs7nAGnQ+ONkyOfqFKGn2kjO0ip0/pU0N660G1aRp8LsVlX7h1M6Kga5IH9Z8XDCaXfA9dya9UzPYuluACPcid59gBZhCSmyldgJNaY2JQpIupKGLTpt0jPc5ActwsEWQIaVgzOasW1ZAWEhlNk0bvw+IyijDL9cHrmF2yKZP8ZZ9gUZqZKqhYBKyufKdu1rivrWTckvDkM/FUPEqcbfUu1JzE4GwZEU/uyf1lgPwGvSO9i/bHMxPJOiylpQwj/OvaedUi+2u8lWm+4NwfgV1CcE7zr8Iq/W36yGefVw6f5w==
X-MS-Exchange-AntiSpam-MessageData: 1usaoDxWudR8nvTqcMEux03wHUMduQEOloLb2mjSnoV1YJRQN9EvntUxiZCepIDoSR0ylragsHNELvHq2C4zodpoQHWheAkDSza152YvCJnunBJ1VzYSqYaFeNt9KF5qvKCZqICbyaomML4F12cQISfjo6+M6VqHCyiFojZya5VhSy+E+B1n5dwdMVWSbMEQGq3exPS4KwoxdxksB2nW8ZDINEZHpOrVeVidjiyMpqUnOClwadGXNW+JyZwCuAMQgi12Ji4vF/nFbv2vTGnfhGmycD7zQDxFLgcMR46VRvZSchNrp+R+ig2INvZ+p859X/5y9yj61mRh2PevJqj1RXPt/0nt2SLAbIYZGeupiVy49m2dSC81AsRSIW7pM+dTluNwnoCY4gRMihCHZABwl08mM4nHcxIb/FFYcphl/9gxPdMXj5E8k9uYplCVSFamKhiT6747ZszzhBxjRcfCeUiCbkw6DTyJvmvbMwgjbALhateQUuBsuOgINDNRiOXj3VmUlRD+C6jGWGh0J4geCpBQXz9BzRVP+2GOBgRqMLkiVVjgyBvRoUPO259I9eyi1j/gfwl24RjATdqp5lHRKnPgxYd4bHr6TZ1OzhQJ/iEaqStSZrgxyaA1NywZiouk6rSqGEGM8KMEtP8KhfDnHT5csul1VgD0G857E1I1L10+QSadbMqlNgWsIz/mDfTUJs7KrJZmMm2CC0EoTPlkQG6vq0WNUwQY+KMvT0VX/OZfWbq8KyxIaWdecgNQ+2yZEp3s6aFHzUyiCOiQVmmf04HYw0upl4NKb1fINOHtpEiqzeineIdKRZmv2HWVbLszeY++pV09vjK/GcgwO5/W9OhusTGK1x5h3yPsQo+8B1U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8190009e-a3d5-4bca-4559-08d7e75be039
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:56:48.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFDkv6J37iiDd9nTQrggxxv6aw/M5ZA8J8I8Owvqb97QcvDqCj+mr4LOsPf6c0tv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
 Felix" <Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, an open file descriptor holds a reference to the driver module.

So it shouldn't be possible to unload the driver while it is open.

Christian.

Am 23.04.20 um 09:54 schrieb Liu, Monk:
> Oh, looks if the daemon is opening the node KMD don't have a chance to enter the path of shutdown/unload driver, thus no chance to return "kmd unloading" to the app...
>
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
> Sent: Thursday, April 23, 2020 3:52 PM
> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
>
> Hi Christian
>
> Do you think we need to kill the daemon app if we do KMD unloading ? usually user need to close the app first and then the KMD could be unloaded
>
> If we don't want to manually shutdown the daemon app we can do a "KILL" signal send to that process, or we can implement "read" and let app call "read()" to fetch information like:
> 1) xxx process hang
> 2) kmd unloading
>
> And daemon can close() the node if it receives "kmd unloading" instead of doing the dump
>
> Thanks
>
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: Zhao, Jiange <Jiange.Zhao@amd.com>
> Sent: Thursday, April 23, 2020 3:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
> Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
>
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part of an opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system and poll() for readable/writable. When a GPU reset is due, amdgpu would notify usermode app through wait_queue_head and give it 10 minutes to dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through the completion that is triggered in release().
>
> There is no write or read callback because necessary info can be obtained through dmesg and umr. Messages back and forth between usermode app and amdgpu are unnecessary.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 97 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bc1e0fd71a09..a505b547f242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -724,6 +724,13 @@ struct amd_powerplay {
>   	const struct amd_pm_funcs *pp_funcs;
>   };
>   
> +struct amdgpu_autodump {
> +	bool				registered;
> +	struct completion		completed;
> +	struct dentry			*dentry;
> +	struct wait_queue_head		gpu_hang_wait;
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -990,6 +997,8 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..cdd4bf00adee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if
> +defined(CONFIG_DEBUG_FS)
> +	int ret;
> +	unsigned long tmo = 600*HZ;
> +
> +	if (!adev->autodump.registered)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);
> +	if (ret == 0) { /* time out and dump tool still not finish its dump*/
> +		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
> +		return -ETIMEDOUT;
> +	}
> +#endif
> +	return 0;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct
> +file *file) {
> +	int ret;
> +	struct amdgpu_device *adev;
> +
> +	ret = simple_open(inode, file);
> +	if (ret)
> +		return ret;
> +
> +	adev = file->private_data;
> +	if (adev->autodump.registered == true)
> +		return -EINVAL;
> +
> +	adev->autodump.registered = true;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct
> +file *file) {
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	complete(&adev->autodump.completed);
> +	adev->autodump.registered = false;
> +
> +	return 0;
> +}
> +
> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct
> +poll_table_struct *poll_table) {
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
> +
> +	if (adev->in_gpu_reset)
> +		return POLLIN | POLLRDNORM | POLLWRNORM;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_debugfs_autodump_open,
> +	.poll = amdgpu_debugfs_autodump_poll,
> +	.release = amdgpu_debugfs_autodump_release, };
> +
> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
> +	struct dentry *entry;
> +
> +	init_completion(&adev->autodump.completed);
> +	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
> +	adev->autodump.registered = false;
> +
> +	entry = debugfs_create_file("autodump", 0600,
> +			adev->ddev->primary->debugfs_root,
> +			adev, &autodump_debug_fops);
> +	adev->autodump.dentry = entry;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..9428940a696d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,  int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);  int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3d601d5dd5af..44e54ea7af0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_full_reset  = *need_full_reset_arg;
>   
> +	amdgpu_debugfs_wait_dump(adev);
> +
>   	/* block all schedulers and reset given job's ring */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C2d5beed35028403ebe1708d7e75b4353%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232251473250650&amp;sdata=SmXKMH9LgbD5K2gkm6Vqysu%2FgvtHLtLoJpJGcLGFd%2F4%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
