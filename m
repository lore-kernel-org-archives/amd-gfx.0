Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6AC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 10:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81142074F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 10:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AuOglYC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81142074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D576E185;
	Thu, 23 Apr 2020 10:44:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2C26E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 10:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc/kUmUZf9oEgz6SoE47hrOuFES6gmgzx6doJwWYYlnD8c0LDB4YEzbUFBpvWOdRMTvCYVXJ6nSPeo1mJO6jDbY4kHORoUMESKT232bdwvkg8gm9N7BruiZJqGHK/EIN/EjpKP7Wj0tjmfvMj2gcWRmKWj3qXiKBC/NgQyLAAweUyfxcQNtryWuwshDHBl9JuGPjJPKO27bH7WlrtkCSPktBG8ny8Gtv226BD7MNvra8LUYlr4mOYZxaPR8pnmUTkaZdqGS8gUKASD5b6asHhnZI1XO6kXX6IPPHbLDRi9VyegIUIkQnAubtYSxPuUk4mlV2UCuM/O3zU9izfdl0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkJ/h1WOYyllJUVabHFd3pmviNkWDaQcqf+fwwKHLcw=;
 b=NWXT9IpDgrNcHZkQr0bdMBKjfn3heVrcRYCnKtYWcvNy8ziAeJZ/IZlHKDuMDuwLARALOHhyOW2SAIEQkWVs58atOvDdS7s2Qe8BqyWBVfh0wRJ8+AAYY+eo0W2RM9BJoN1UOjoF1gjlxYpHsE2w71/RS4NC+Rl5vo4PbDLJWAfQ08WvQNbl4nbVsgU9UeXRIEcmGQhd4gzyVYzv4ORwdgJdwydV49XxetKXLRhU0yAQ56lAXG60AVa643ys/7UL3K0fdgUaEAIiXzdBw9CAKpFWQ9NrsRfhyl49Wlnu8xqLdHf77OW7kpch9CaWwJQJFhfl70xxHEkBJxRfdAhIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkJ/h1WOYyllJUVabHFd3pmviNkWDaQcqf+fwwKHLcw=;
 b=AuOglYC0VDFpJBZbi0WCVBAGTnLe5y0Rt91zeaydEAf1VqByB1RyrUdDHEfLn6k+1Y0VYVu39LGTpGJ4KXxOhrtKXciXdoMgUYu4okm11OPc6mrnYurY3Zgy6xlIhDQBzHWsov8bGfevwXAPd23cptalWe5MbHlv+PbO5vzPrvs=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 10:44:43 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.020; Thu, 23 Apr 2020
 10:44:43 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Index: AQHWGT+bbBcsTcYgg0+m/750iqjke6iGZp+AgAAaBaA=
Date: Thu, 23 Apr 2020 10:44:43 +0000
Message-ID: <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
In-Reply-To: <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-23T10:44:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b43827f9-628f-4ee3-bf10-0000abdeb331;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-23T10:44:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f9ccddcd-6151-49f5-9bf3-0000e01b7e05
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac614fc0-601a-44f9-aecd-08d7e773554c
x-ms-traffictypediagnostic: BY5PR12MB4276:|BY5PR12MB4276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4276E12E312B68D3DF5A1540E1D30@BY5PR12MB4276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(26005)(4326008)(33656002)(71200400001)(9686003)(2906002)(7696005)(8676002)(55016002)(76116006)(54906003)(110136005)(186003)(86362001)(6506007)(53546011)(316002)(478600001)(66556008)(66446008)(5660300002)(8936002)(66946007)(81156014)(64756008)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbs5ZAoeFiNqq4Paq6wRuV7xi/VUk9wdHk+xZ+ykn4s7b9VUHXnXLeBptTQl3qfKX0aSvjTqEd3P/hds/Dzf63cjsxbhsNxfHY8BQj/2oZ1NO9IvEPauUn9hp52iaKgbxMmm6/ioQCxmYKgAcGKhtUNePksXCMZUGhEDjyCLFTL9qIrDN+kw4Y+0Bd4smuYhfvpphazyXxG2fSVVJzCoFSwoU+zdn+VWMvSh66ew5ZFgr9VRkBAFjCqJywmYyzSdHzICB65blsnbOdCkFbPRp4QOF3c1/PjsHHri7KW1b8axEyxDgNvgQDV5eLFvDQ9wKd4N7aMQuXh/d27AyVt8nN2f+muCCtvSqvKMvUMGMSZC+liSyFPnhhZ54Pp7sbWX5TZq+PGP6Y5pTDSl8XAbOCuuGB1MUbQdZuaWActLCweU5CQo4WXTVTmANiNTCzto
x-ms-exchange-antispam-messagedata: kwreY90RjKx3eWyCz0sPdP4CZCBuxAvWJRfE7GfMKDWJdQZ6OBFdHmMBJQlasXhICLa8+e/PUqL3iqRT2tCZuSA4hqYCMvAVeMgmvWVTWk1mn5J5YhaTk/Ux/5NABpVlVp5poyu5ODTaPWni7nyDag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac614fc0-601a-44f9-aecd-08d7e773554c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:44:43.2629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGqLcsXgkVZrackwytptFuaZvXyCtmK41y1vMDAgRZLNHczOt9ebTCTPSgx93TBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
 Felix" <Felix.Kuehling@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,

Here are some explanations,
(1) registered means that an app is listening to this node, completion means that this app has finished a dump.
(2) after a dump, listening app would close this node. If it wants to get another reset hang, it needs to open the node again. In this way, release() function can wrap up and make it ready for another dump.
(3) At the same time, considering the use case of this node, I believe that only the first GPU reset is worthy of a dump.
(4) I didn't implement race condition guard because I believe that this node caters for a cautious super-user and a single client is enough to do all the work. I can add the logic if you think it is necessary.

Jiange

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Thursday, April 23, 2020 4:53 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset

Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part of an 
> opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system and 
> poll() for readable/writable. When a GPU reset is due, amdgpu would 
> notify usermode app through wait_queue_head and give it 10 minutes to 
> dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through the 
> completion that is triggered in release().
>
> There is no write or read callback because necessary info can be 
> obtained through dmesg and umr. Messages back and forth between 
> usermode app and amdgpu are unnecessary.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 97 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
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

Registered and completed seems to have the same meaning.

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
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct 
> ttm_bo_device *bdev) diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
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

In general please declare constant lines first and variable like "i" or "r" last.

> +
> +	if (!adev->autodump.registered)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
> +
> +	ret = 
> +wait_for_completion_interruptible_timeout(&adev->autodump.completed, 
> +tmo);

This is racy, in other words it can happen that a new client opens up the debugfs file without being signaled but blocks the reset here.

You could use two completion structures to avoid that.

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

Probably better to return -EBUSY here. And this is racy, and might need a lock e.g. multiple clients could open the file at the same time.

If we use a struct completion for registered we could use the spinlock of that one for protection here.

> +
> +	adev->autodump.registered = true;

You also need to reset the completion structure here otherwise only the first GPU reset would work with this.

> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, 
> +struct file *file) {
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
> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
> *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..9428940a696d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
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
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
