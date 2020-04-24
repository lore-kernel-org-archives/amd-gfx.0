Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E472C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13B520736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u9DqAQEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13B520736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907516EA88;
	Fri, 24 Apr 2020 08:24:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113406EA88
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REN+RZlsuEKckzuQZqpgr2r+AdnBHSoLUqInkSFRGuu3INcRl4WzFVo3QIzQa38EpH71ddN4MJ5ZYZ4hVaRj+lAG24yMbQnPKKjDf8YLyvDX+3mId3p65rH9AEvDsQ7bVzzYpPUfpYww3CIRqQEdcvch28v+nLMd5dJsHl7o43nhz1bJ0GZFlXn6fPqCa4JzfsFltOJCPvbq15CvKDCA/s4E5ZhjkO5PuRMhijUDKaB5AIjwWnSsJfQzeFMkJUD1Je0Ay2yk5C2oEgZtgH6JI5aYpQPcLzcN9NJzZfj82/+AXu4TnN5O+iNHh76wtOMG5nwKEdQ77FLY6xe7dGuV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF5IuBBFHXOZzwF3XxUxDOFiCjp3JwRM/AOV4tuypuM=;
 b=J8IFDLEfU3ZFNUuLAA7hrkOmOQEuORbDXOckTlxoJ1Hn3HcpXEjFuo9PbRtT+e3DgLLMV8L7LOHleC8xwT5hQoA++OUTzRbNxoi6xv9+WCgUW4k/lv0HCod2E36c7BNATTW0wmKy4+sJx82bcIdNF7i309FMHTqc4h9I8uxs9E6Obrd9Dwh26M5awycCoaZgOb3clneGoS2cY7W7Xb58uQ5jpp5425a2M2k3UV8My1vvLH/ZPHhhPVBf0r1d+PQuapA4HpFyuy/2OCguYK8fzxWh/b3nBTv4ur4s++SIEE8B6BtwzwSxxPc4l1ltj3/yJfYW5L5WtZDUyC6gnHAppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF5IuBBFHXOZzwF3XxUxDOFiCjp3JwRM/AOV4tuypuM=;
 b=u9DqAQEnyjtwKuip8Pr3SOOnaEeqpEUWL01NV24FFv+7pIEhajsurzo1p4ueHfnhI0d/islke7U740EKfMZtj0TZPrO/qtI/dz8d/VUwBEC0DSDGzH+Q/ZvHVo0FFil6gTyssSVzddZja3vMO7OlUrANY+4Skr9iXI9/Ja4fDJw=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 08:24:08 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 08:24:08 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Index: AQHWGT+bbBcsTcYgg0+m/750iqjke6iGZp+AgAAaBaCAAWXngIAACMZy
Date: Fri, 24 Apr 2020 08:24:07 +0000
Message-ID: <BY5PR12MB3844347BB5326DE7B769A7FCE1D00@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
 <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>,
 <8078fb6a-c398-a02a-da6f-79a67e5d9e3d@amd.com>
In-Reply-To: <8078fb6a-c398-a02a-da6f-79a67e5d9e3d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T08:24:07.258Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a0c2375-60bc-4163-3380-08d7e828dbdb
x-ms-traffictypediagnostic: BY5PR12MB4114:|BY5PR12MB4114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4114B2D172CB1EEF23696D61E1D00@BY5PR12MB4114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6506007)(9686003)(5660300002)(54906003)(19627405001)(966005)(8936002)(81156014)(33656002)(110136005)(53546011)(26005)(7696005)(316002)(478600001)(55016002)(2906002)(186003)(86362001)(66476007)(64756008)(71200400001)(91956017)(66556008)(66946007)(8676002)(4326008)(66446008)(52536014)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOungw87ya022AiH9R+ArbNYx2dvBJJkO+PvKhWiyOBtxycPXakVQSe0sZHWwTFePh2nW85GY7ktd1+6W7QkOpGXoD1T0w59yMUJh/xTFmlu5Xhtt74f6TKrmjubgcoM5HT07K7Bnpz6oxVXfx77oFt4tyvMBwovBTTvHx3IfOB/03eTxK+zo7VytoM6ZJsA7U76XYxgHIQHqcRvPbd4QnnH9rBujpe0b3/g11J6WZnhFsBgRCrV5UEgHfKuE5/kM5FYvjTOv/m27CjAYNlqijr3DnJuNLD4/yKyZfsNLZOMNMtZ1qbvHzs/fZ+Z/HnyD1Y2Zrmd1FHEc/D6+JS9G8BiezJy10HURNZ1pJQsQcLJQdJe20k9W2RZXAwqU9TEVTuYsU8zvCaienm2VLlE0WLh7xlfIBR255hG8g8yTZZ+4zvzXUH3uKPIp64kojL93INFe22Y8rKTAh+NqJzZnlFQ+2lD+EzY6BJhpjpwGnw=
x-ms-exchange-antispam-messagedata: RLt3jb/3TERjv+5NwOyZ8/Lx/Q+UckXzPWJusVmHI43dflPUnHzQSTZQxT6610axHuXSnDMUm+nuZ+OJeUF6rgSQzYlZCoIJ5kNUd5WBt6E5VbOwUWFPsjcuOcuizsmLh8ZhnZ7q6MUvRtaPvNTUaQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0c2375-60bc-4163-3380-08d7e828dbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 08:24:07.9527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylwbsTM1ryAD+87QfjE6RbhJk82XrEoWszFwzZAHdeclO26xQJ9eCdKeM5XFO+g0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1776845710=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1776845710==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB3844347BB5326DE7B769A7FCE1D00BY5PR12MB3844namp_"

--_000_BY5PR12MB3844347BB5326DE7B769A7FCE1D00BY5PR12MB3844namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi,

Of course, considering all the suggestions, I will implement a write callba=
ck for usermode app to notify KMD that a dump is finished by sending "Done"=
.

In this way, usermode app can do multiple dumps without closing the node,

Jiange
________________________________
From: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>
Sent: Friday, April 24, 2020 3:46 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pierre-=
eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kuehling@=
amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset

Hi Jiange,

FYI I'm working on adding a new "--autodump" command to umr that uses this =
feature.
This is not yet merged but you can find the code here: https://gitlab.freed=
esktop.org/pepp/umr/-/tree/autodump

> (3) At the same time, considering the use case of this node, I believe th=
at only the first GPU reset is worthy of a dump.

If it's possible I'd like to be able to do multiple dumps instead of limiti=
ng ourselves to only the first one.

Thanks!
Pierre-Eric



> (4) I didn't implement race condition guard because I believe that this n=
ode caters for a cautious super-user and a single client is enough to do al=
l the work. I can add the logic if you think it is necessary.
>
> Jiange
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, April 23, 2020 4:53 PM
> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric=
 <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd=
.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
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
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>>   4 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index bc1e0fd71a09..a505b547f242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -724,6 +724,13 @@ struct amd_powerplay {
>>       const struct amd_pm_funcs *pp_funcs;
>>   };
>>
>> +struct amdgpu_autodump {
>> +    bool                            registered;
>> +    struct completion               completed;
>
> Registered and completed seems to have the same meaning.
>
>> +    struct dentry                   *dentry;
>> +    struct wait_queue_head          gpu_hang_wait;
>> +};
>> +
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   struct amdgpu_device {
>> @@ -990,6 +997,8 @@ struct amdgpu_device {
>>       char                            product_number[16];
>>       char                            product_name[32];
>>       char                            serial[16];
>> +
>> +    struct amdgpu_autodump          autodump;
>>   };
>>
>>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>> ttm_bo_device *bdev) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 1a4894fa3693..cdd4bf00adee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
ev,
>>       return 0;
>>   }
>>
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if
>> +defined(CONFIG_DEBUG_FS)
>> +    int ret;
>> +    unsigned long tmo =3D 600*HZ;
>
> In general please declare constant lines first and variable like "i" or "=
r" last.
>
>> +
>> +    if (!adev->autodump.registered)
>> +            return 0;
>> +
>> +    wake_up_interruptible(&adev->autodump.gpu_hang_wait);
>> +
>> +    ret =3D
>> +wait_for_completion_interruptible_timeout(&adev->autodump.completed,
>> +tmo);
>
> This is racy, in other words it can happen that a new client opens up the=
 debugfs file without being signaled but blocks the reset here.
>
> You could use two completion structures to avoid that.
>
>> +    if (ret =3D=3D 0) { /* time out and dump tool still not finish its =
dump*/
>> +            pr_err("autodump: timeout before dump finished, move on to =
gpu recovery\n");
>> +            return -ETIMEDOUT;
>> +    }
>> +#endif
>> +    return 0;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>
>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct
>> +file *file) {
>> +    int ret;
>> +    struct amdgpu_device *adev;
>> +
>> +    ret =3D simple_open(inode, file);
>> +    if (ret)
>> +            return ret;
>> +
>> +    adev =3D file->private_data;
>> +    if (adev->autodump.registered =3D=3D true)
>> +            return -EINVAL;
>
> Probably better to return -EBUSY here. And this is racy, and might need a=
 lock e.g. multiple clients could open the file at the same time.
>
> If we use a struct completion for registered we could use the spinlock of=
 that one for protection here.
>
>> +
>> +    adev->autodump.registered =3D true;
>
> You also need to reset the completion structure here otherwise only the f=
irst GPU reset would work with this.
>
>> +
>> +    return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_autodump_release(struct inode *inode,
>> +struct file *file) {
>> +    struct amdgpu_device *adev =3D file->private_data;
>> +
>> +    complete(&adev->autodump.completed);
>> +    adev->autodump.registered =3D false;
>> +
>> +    return 0;
>> +}
>> +
>> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct
>> +poll_table_struct *poll_table) {
>> +    struct amdgpu_device *adev =3D file->private_data;
>> +
>> +    poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
>> +
>> +    if (adev->in_gpu_reset)
>> +            return POLLIN | POLLRDNORM | POLLWRNORM;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct file_operations autodump_debug_fops =3D {
>> +    .owner =3D THIS_MODULE,
>> +    .open =3D amdgpu_debugfs_autodump_open,
>> +    .poll =3D amdgpu_debugfs_autodump_poll,
>> +    .release =3D amdgpu_debugfs_autodump_release, };
>> +
>> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
>> +    struct dentry *entry;
>> +
>> +    init_completion(&adev->autodump.completed);
>> +    init_waitqueue_head(&adev->autodump.gpu_hang_wait);
>> +    adev->autodump.registered =3D false;
>> +
>> +    entry =3D debugfs_create_file("autodump", 0600,
>> +                    adev->ddev->primary->debugfs_root,
>> +                    adev, &autodump_debug_fops);
>> +    adev->autodump.dentry =3D entry;
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>    *
>> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
>> *adev)
>>
>>       amdgpu_ras_debugfs_create_all(adev);
>>
>> +    amdgpu_debugfs_autodump_init(adev);
>> +
>>       return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>>                                       ARRAY_SIZE(amdgpu_debugfs_list));
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index de12d1101526..9428940a696d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ade=
v,
>>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3d601d5dd5af..44e54ea7af0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amd=
gpu_device *adev,
>>       int i, r =3D 0;
>>       bool need_full_reset  =3D *need_full_reset_arg;
>>
>> +    amdgpu_debugfs_wait_dump(adev);
>> +
>>       /* block all schedulers and reset given job's ring */
>>       for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>               struct amdgpu_ring *ring =3D adev->rings[i];
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--_000_BY5PR12MB3844347BB5326DE7B769A7FCE1D00BY5PR12MB3844namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Of course, considering all the suggestions, I will implement a write callba=
ck for usermode app to notify KMD that a dump is finished by sending &quot;=
Done&quot;.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In this way, usermode app can do multiple dumps without closing the node,<b=
r>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pelloux-prayer, Pierr=
e-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;<br>
<b>Sent:</b> Friday, April 24, 2020 3:46 PM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; Koenig, Christian &lt;=
Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pelloux-pr=
ayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;; Kuehling, Fel=
ix &lt;Felix.Kuehling@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Zhan=
g, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu r=
eset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Jiange,<br>
<br>
FYI I'm working on adding a new &quot;--autodump&quot; command to umr that =
uses this feature.<br>
This is not yet merged but you can find the code here: <a href=3D"https://g=
itlab.freedesktop.org/pepp/umr/-/tree/autodump">
https://gitlab.freedesktop.org/pepp/umr/-/tree/autodump</a><br>
<br>
&gt; (3) At the same time, considering the use case of this node, I believe=
 that only the first GPU reset is worthy of a dump.<br>
<br>
If it's possible I'd like to be able to do multiple dumps instead of limiti=
ng ourselves to only the first one.<br>
<br>
Thanks!<br>
Pierre-Eric<br>
<br>
<br>
<br>
&gt; (4) I didn't implement race condition guard because I believe that thi=
s node caters for a cautious super-user and a single client is enough to do=
 all the work. I can add the logic if you think it is necessary.<br>
&gt; <br>
&gt; Jiange<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Koenig, Christian &lt;Christian.Koenig@amd.com&gt; <br>
&gt; Sent: Thursday, April 23, 2020 4:53 PM<br>
&gt; To: Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
&gt; Cc: Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Pelloux-prayer, Pi=
erre-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Zhao, Jiange &lt;Jiange.Zhao@amd.co=
m&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu res=
et<br>
&gt; <br>
&gt; Am 23.04.20 um 09:19 schrieb jianzh@amd.com:<br>
&gt;&gt; From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
&gt;&gt;<br>
&gt;&gt; When GPU got timeout, it would notify an interested part of an <br=
>
&gt;&gt; opportunity to dump info before actual GPU reset.<br>
&gt;&gt;<br>
&gt;&gt; A usermode app would open 'autodump' node under debugfs system and=
 <br>
&gt;&gt; poll() for readable/writable. When a GPU reset is due, amdgpu woul=
d <br>
&gt;&gt; notify usermode app through wait_queue_head and give it 10 minutes=
 to <br>
&gt;&gt; dump info.<br>
&gt;&gt;<br>
&gt;&gt; After usermode app has done its work, this 'autodump' node is clos=
ed.<br>
&gt;&gt; On node closure, amdgpu gets to know the dump is done through the =
<br>
&gt;&gt; completion that is triggered in release().<br>
&gt;&gt;<br>
&gt;&gt; There is no write or read callback because necessary info can be <=
br>
&gt;&gt; obtained through dmesg and umr. Messages back and forth between <b=
r>
&gt;&gt; usermode app and amdgpu are unnecessary.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 1 =
&#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbs=
p; 2 &#43;<br>
&gt;&gt;&nbsp;&nbsp; 4 files changed, 97 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; index bc1e0fd71a09..a505b547f242 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -724,6 &#43;724,13 @@ struct amd_powerplay {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *pp_=
funcs;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;struct amdgpu_autodump {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; registered;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completed;<br>
&gt; <br>
&gt; Registered and completed seems to have the same meaning.<br>
&gt; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct dentry&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *dentry;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang_wait;<br>
&gt;&gt; &#43;};<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; #define AMDGPU_RESET_MAGIC_NUM 64<br>
&gt;&gt;&nbsp;&nbsp; #define AMDGPU_MAX_DF_PERFMONS 4<br>
&gt;&gt;&nbsp;&nbsp; struct amdgpu_device {<br>
&gt;&gt; @@ -990,6 &#43;997,8 @@ struct amdgpu_device {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_numbe=
r[16];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_name[=
32];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[16];<b=
r>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; static inline struct amdgpu_device *amdgpu_ttm_adev(st=
ruct <br>
&gt;&gt; ttm_bo_device *bdev) diff --git <br>
&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; index 1a4894fa3693..cdd4bf00adee 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; @@ -74,8 &#43;74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_=
device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #i=
f <br>
&gt;&gt; &#43;defined(CONFIG_DEBUG_FS)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; unsigned long tmo =3D 600*HZ;<br>
&gt; <br>
&gt; In general please declare constant lines first and variable like &quot=
;i&quot; or &quot;r&quot; last.<br>
&gt; <br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (!adev-&gt;autodump.registered)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return 0;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;adev-&gt;autodu=
mp.gpu_hang_wait);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; ret =3D <br>
&gt;&gt; &#43;wait_for_completion_interruptible_timeout(&amp;adev-&gt;autod=
ump.completed, <br>
&gt;&gt; &#43;tmo);<br>
&gt; <br>
&gt; This is racy, in other words it can happen that a new client opens up =
the debugfs file without being signaled but blocks the reset here.<br>
&gt; <br>
&gt; You could use two completion structures to avoid that.<br>
&gt; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0) { /* time out and dump t=
ool still not finish its dump*/<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; pr_err(&quot;autodump: timeout before dump finished, move on to gpu r=
ecovery\n&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -ETIMEDOUT;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;#endif<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;static int amdgpu_debugfs_autodump_open(struct inode *inode, =
struct <br>
&gt;&gt; &#43;file *file) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; ret =3D simple_open(inode, file);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return ret;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev =3D file-&gt;private_data;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.registered =3D=3D tr=
ue)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -EINVAL;<br>
&gt; <br>
&gt; Probably better to return -EBUSY here. And this is racy, and might nee=
d a lock e.g. multiple clients could open the file at the same time.<br>
&gt; <br>
&gt; If we use a struct completion for registered we could use the spinlock=
 of that one for protection here.<br>
&gt; <br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.registered =3D true;<br>
&gt; <br>
&gt; You also need to reset the completion structure here otherwise only th=
e first GPU reset would work with this.<br>
&gt; <br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;static int amdgpu_debugfs_autodump_release(struct inode *inod=
e, <br>
&gt;&gt; &#43;struct file *file) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D file-&gt;pr=
ivate_data;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; complete(&amp;adev-&gt;autodump.completed)=
;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.registered =3D false;<br=
>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;unsigned int amdgpu_debugfs_autodump_poll(struct file *file, =
struct <br>
&gt;&gt; &#43;poll_table_struct *poll_table) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D file-&gt;pr=
ivate_data;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;autodump.gpu=
_hang_wait, poll_table);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return POLLIN | POLLRDNORM | POLLWRNORM;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;static const struct file_operations autodump_debug_fops =3D {=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; .open =3D amdgpu_debugfs_autodump_open,<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; .poll =3D amdgpu_debugfs_autodump_poll,<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_debugfs_autodump_relea=
se, };<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;static int amdgpu_debugfs_autodump_init(struct amdgpu_device =
*adev) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct dentry *entry;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;autodump.com=
pleted);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;adev-&gt;autodump=
.gpu_hang_wait);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.registered =3D false;<br=
>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; entry =3D debugfs_create_file(&quot;autodu=
mp&quot;, 0600,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ddev-&gt;pri=
mary-&gt;debugfs_root,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;autodump_d=
ebug_fops);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.dentry =3D entry;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_debugfs_process_reg_op - Handle MMIO re=
gister reads/writes<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; @@ -1434,6 &#43;1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_de=
vice <br>
&gt;&gt; *adev)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_debugfs_create_all(=
adev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_autodump_init(adev);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_file=
s(adev, amdgpu_debugfs_list,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ARRAY_SIZE(amdgpu_debugfs_list));<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt;&gt; index de12d1101526..9428940a696d 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt;&gt; @@ -40,3 &#43;40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_d=
evice *adev,<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_debugfs_fence_init(struct amdgpu_device *ad=
ev);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_debugfs_firmware_init(struct amdgpu_device =
*adev);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_debugfs_gem_init(struct amdgpu_device *adev=
);<br>
&gt;&gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index 3d601d5dd5af..44e54ea7af0f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -3915,6 &#43;3915,8 @@ static int amdgpu_device_pre_asic_reset(=
struct amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp; =3D=
 *need_full_reset_arg;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and re=
set given job's ring */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MA=
X_RINGS; &#43;&#43;i) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3844347BB5326DE7B769A7FCE1D00BY5PR12MB3844namp_--

--===============1776845710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1776845710==--
