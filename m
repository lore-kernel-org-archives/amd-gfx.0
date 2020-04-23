Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1435C54FCB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 11:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787B82077D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 11:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xF3oSdQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787B82077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206336E423;
	Thu, 23 Apr 2020 11:50:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDFF6E423
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 11:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu2VPt+yJxJ83Mpd2DOLyZYSvYa7FhDrvkjGqVfdRCZ8OdvZi9F6ga8rzcdfchgfscgHKwLSkVES2EO85K/lhKYQIgByhafrJhAQyWBHUcOf5yWNEAtJfpyo1/xiW7CiCFsBshBBlQzLTcsWUGs6fAO05Xmqb5G7DyjNykFIQ63GNI7GpQ5lhTz1DpWnV6cjM9U+0IU8Zs/RAHwekwzN0p5g+/7Gx8CKF229xA8Fa7nJRTiwaz0rMYSNepdbdkiydSZ0U13ywUJVodiQKShh+RI6o/oYQlKZWV1HwGyYbUpPRYtKZ02WC3cXwqs/1EMtgwu5NkJ8AkXLNeDSAXg7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx6e/S4Heoazj04NT9+xUbQ+W35gMAtAzbJjFj3KQ34=;
 b=LvebH3oK2iX9QRXYhjfvz/nkvqwGdymZKlbU9z8jv81qWN3teWEVTuCInD3nAjbo2mbaM4KcbsqvNt4r4LpGIQaCQ8VOREIdlwIjw7efvZirnKyDbSP0qKH51hZlMwev6AXuWhrXieMkG4cbG4zo6B63CD1M5UVE1HWLzlY8g6Q11JQQaoThds51u4aT+Y6eFZfMiTTTnvAbaQzss/WLrLM2nVccNDaFSEf62MjI5IQ/94I1YKLjTSSl9uShpKUkNveptc93qz6TyX2FJV0KAnJqgqSJo1oqPffnEcEp/mr+6e6R/Iw4QjS8IPPk0k4tVBYJ4OcfXmzFiuhtF5GIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx6e/S4Heoazj04NT9+xUbQ+W35gMAtAzbJjFj3KQ34=;
 b=xF3oSdQ6s7Y305UuFAMXWlpk76mTapYnArMxfPogbcdNEAK4doL4rXfWHW81Mq74Ub3A89vXhokQcejGanWJeaxpLuasquMnfb9BJ4nDMZDD0jRFg0WtM1L8Ogv1OWnp2Rkn/34UTFv8UnAa7fFmAFj+Im4tgPg8PJlGCWrVuv0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 11:50:11 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 11:50:11 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
 <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <46a35e71-023f-faea-6b86-5413847c10e5@amd.com>
Date: Thu, 23 Apr 2020 13:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0137.eurprd05.prod.outlook.com (2603:10a6:207:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 11:50:09 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b543c2be-db2d-4aa9-70af-08d7e77c7a4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:|DM6PR12MB3019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019537F42E8E97362FB223783D30@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(81156014)(52116002)(4326008)(36756003)(31686004)(2616005)(66556008)(53546011)(66946007)(66476007)(54906003)(316002)(110136005)(8936002)(2906002)(6486002)(6666004)(8676002)(186003)(16526019)(31696002)(86362001)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDOnJhtI+GPsKB8lBqvd/buw3bxcs8JSCzBbU4nRMQy6ZDA42TeolCL0n4LyIHeWffsI10gY4GiijxfySHqMUDVDZWrVHqqNr3Vp5hhyVQ9f72Br9rXWK/LU4igdgS2VJygS1qc/SkRtOuWlp9B8ttpaY+jEV81TgjIiK9d+NztqF5Jt3M+UhSsswtiibFNxZK39NjGI8+kVJkzshAZuNW2RX8FrdZey5OMbOAPxmvPddWtCLlRFyRaD9J9mAARyacSV2cW+N9Eote0lWV5gBSdjTcTsg4kVNHjQUTPYW4X950JXuSsWiPbyf8XrNAJ6BDmTRwDroWteQULV/d20gl8wOMYsCVPlQgV19KWDNQl8NabwxdaznEK72qEcqqY7GOvWBooklz4wkfTKk1JEGjD5UZiC3Dj2/jhOUSJbqzMa2HFLu5bmM9iOldOpcJRq
X-MS-Exchange-AntiSpam-MessageData: Kjkpd+R8yvhyInCZfMTAaO0NABEpPf7FPM69qgl9rafoKeJFXIaypHj6CvUgWUkJroaJPRr7WZLXBF6sOaOh5VP7qg18By6H19+sWe4U3YbZ1EEPlCNzQJujgkLhdMqolc9RfEKcaK1MoFqJsyre1noAG4a0uKaf2Fbfgw05uUNEZweJburp4s21qJ59oz1luPbUnPGf88bYdj5ZQKRbv7Um7wutmn5ErqZYw2i1LAlbRcppiTk8wbwODRuIk3gZkgrHMY45JYw1TYTZCu0qbOELrHcaG5l8An2gz4v2/17Zon5nBd8QyMsK9EstR5fxfeEzq4V8YLOiKPJbUtb2jxGFC4THoxSftmIfMlZZaNjeuhyjj2pa3nSLPSq6ep5dlSkEpodL3at7l5unLwHl8qH6nEFLVbrxJo6TqRuMdVcwZJrghVcF+3w69nUgSpwvOQ0KqsQ9zvVhU3c9Bf/0wJrcs+96n5HdjYH+jjOH2ZQokYOpHeIoV271y5Mu9w5mLg6PKs+Sf0WfySl09yKQ53Y1Z4MmVwbT33/jwV4Gn+9Wj+59gW8AYW27/aKYmQUuR7NVZS4oSngV+tZjCQ/0YmUEA77LymIkFJYjCLHYOQ5oc+NeunuOG0zmU2g74iGM1YwJLw6PQ4JZfSyPKdnFWGb+UEi2OHvE1in1r4hl6zAxuv2Zf6ewdg08r4s6kxvXoRVQHcKGakn/Wdq2tkMETViaVBcX9OqphJlpsrufjoZ/x1CmmDvRsc55sgxylb0JceKfQcE+AIeIkI1GlVNK5IF/kOM0a5n3GkMxeopOo7EjNBYXxBjsTnRwyvurcfgdpDe+IM2POOYAxfn+uhz4OTjRd9+fCYrnfjp4u3AZCTs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b543c2be-db2d-4aa9-70af-08d7e77c7a4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 11:50:11.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPDZSk2cDDOhTpq1ezId1+yKrz2jH2LuwUEFKBGaQ0gsMwBLb8wugdvZlKc3NNv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.04.20 um 12:44 schrieb Zhao, Jiange:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Christian,
>
> Here are some explanations,
> (1) registered means that an app is listening to this node, completion means that this app has finished a dump.

Yeah and both are the same thing. E.g. when an app is listening the 
reset code needs to wait and when no app is listening it doesn't.

We could rename the member to something like app_listening if that makes 
things more clearer.

> (2) after a dump, listening app would close this node. If it wants to get another reset hang, it needs to open the node again. In this way, release() function can wrap up and make it ready for another dump.

Yeah, but you are forgetting to reset the completion structure. With the 
current implementation the second timeout will reset the GPU immediately 
without waiting for the app to do the core dump.

> (3) At the same time, considering the use case of this node, I believe that only the first GPU reset is worthy of a dump.

That is probably not such a bad idea, but we should leave this decision 
to the end user which can either restart or app or leave it like this.

> (4) I didn't implement race condition guard because I believe that this node caters for a cautious super-user and a single client is enough to do all the work. I can add the logic if you think it is necessary.

That is a very dangerous assumption you made here. All kernel code must 
in general be free of such things.

Regards,
Christian.

>
> Jiange
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, April 23, 2020 4:53 PM
> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
>
> Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>
>> When GPU got timeout, it would notify an interested part of an
>> opportunity to dump info before actual GPU reset.
>>
>> A usermode app would open 'autodump' node under debugfs system and
>> poll() for readable/writable. When a GPU reset is due, amdgpu would
>> notify usermode app through wait_queue_head and give it 10 minutes to
>> dump info.
>>
>> After usermode app has done its work, this 'autodump' node is closed.
>> On node closure, amdgpu gets to know the dump is done through the
>> completion that is triggered in release().
>>
>> There is no write or read callback because necessary info can be
>> obtained through dmesg and umr. Messages back and forth between
>> usermode app and amdgpu are unnecessary.
>>
>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>>    4 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index bc1e0fd71a09..a505b547f242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -724,6 +724,13 @@ struct amd_powerplay {
>>    	const struct amd_pm_funcs *pp_funcs;
>>    };
>>    
>> +struct amdgpu_autodump {
>> +	bool				registered;
>> +	struct completion		completed;
> Registered and completed seems to have the same meaning.
>
>> +	struct dentry			*dentry;
>> +	struct wait_queue_head		gpu_hang_wait;
>> +};
>> +
>>    #define AMDGPU_RESET_MAGIC_NUM 64
>>    #define AMDGPU_MAX_DF_PERFMONS 4
>>    struct amdgpu_device {
>> @@ -990,6 +997,8 @@ struct amdgpu_device {
>>    	char				product_number[16];
>>    	char				product_name[32];
>>    	char				serial[16];
>> +
>> +	struct amdgpu_autodump		autodump;
>>    };
>>    
>>    static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>> ttm_bo_device *bdev) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 1a4894fa3693..cdd4bf00adee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>>    	return 0;
>>    }
>>    
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if
>> +defined(CONFIG_DEBUG_FS)
>> +	int ret;
>> +	unsigned long tmo = 600*HZ;
> In general please declare constant lines first and variable like "i" or "r" last.
>
>> +
>> +	if (!adev->autodump.registered)
>> +		return 0;
>> +
>> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
>> +
>> +	ret =
>> +wait_for_completion_interruptible_timeout(&adev->autodump.completed,
>> +tmo);
> This is racy, in other words it can happen that a new client opens up the debugfs file without being signaled but blocks the reset here.
>
> You could use two completion structures to avoid that.
>
>> +	if (ret == 0) { /* time out and dump tool still not finish its dump*/
>> +		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +#endif
>> +	return 0;
>> +}
>> +
>>    #if defined(CONFIG_DEBUG_FS)
>>    
>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct
>> +file *file) {
>> +	int ret;
>> +	struct amdgpu_device *adev;
>> +
>> +	ret = simple_open(inode, file);
>> +	if (ret)
>> +		return ret;
>> +
>> +	adev = file->private_data;
>> +	if (adev->autodump.registered == true)
>> +		return -EINVAL;
> Probably better to return -EBUSY here. And this is racy, and might need a lock e.g. multiple clients could open the file at the same time.
>
> If we use a struct completion for registered we could use the spinlock of that one for protection here.
>
>> +
>> +	adev->autodump.registered = true;
> You also need to reset the completion structure here otherwise only the first GPU reset would work with this.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_autodump_release(struct inode *inode,
>> +struct file *file) {
>> +	struct amdgpu_device *adev = file->private_data;
>> +
>> +	complete(&adev->autodump.completed);
>> +	adev->autodump.registered = false;
>> +
>> +	return 0;
>> +}
>> +
>> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct
>> +poll_table_struct *poll_table) {
>> +	struct amdgpu_device *adev = file->private_data;
>> +
>> +	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
>> +
>> +	if (adev->in_gpu_reset)
>> +		return POLLIN | POLLRDNORM | POLLWRNORM;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations autodump_debug_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = amdgpu_debugfs_autodump_open,
>> +	.poll = amdgpu_debugfs_autodump_poll,
>> +	.release = amdgpu_debugfs_autodump_release, };
>> +
>> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
>> +	struct dentry *entry;
>> +
>> +	init_completion(&adev->autodump.completed);
>> +	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
>> +	adev->autodump.registered = false;
>> +
>> +	entry = debugfs_create_file("autodump", 0600,
>> +			adev->ddev->primary->debugfs_root,
>> +			adev, &autodump_debug_fops);
>> +	adev->autodump.dentry = entry;
>> +
>> +	return 0;
>> +}
>> +
>>    /**
>>     * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>     *
>> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
>> *adev)
>>    
>>    	amdgpu_ras_debugfs_create_all(adev);
>>    
>> +	amdgpu_debugfs_autodump_init(adev);
>> +
>>    	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>>    					ARRAY_SIZE(amdgpu_debugfs_list));
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index de12d1101526..9428940a696d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>>    int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>    int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>    int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3d601d5dd5af..44e54ea7af0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    	int i, r = 0;
>>    	bool need_full_reset  = *need_full_reset_arg;
>>    
>> +	amdgpu_debugfs_wait_dump(adev);
>> +
>>    	/* block all schedulers and reset given job's ring */
>>    	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    		struct amdgpu_ring *ring = adev->rings[i];

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
