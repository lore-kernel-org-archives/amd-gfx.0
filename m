Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B57C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E56020736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IUla0sAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E56020736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426C26EA91;
	Fri, 24 Apr 2020 08:30:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B325F6EA8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/QTQhubY42R/nay+ROS9stvQ3SCfWjJ3xeiMMjTkBekqwe3qoxYXIJif6TESlBRv4HIKzfEh0LSkYlkbHINMMsB9KbAb+2iZ1gxEh0R3IWO7fpBpmaz1tofylPIot67epQ1lMVFGNoBTsEy//xjplRN7AW22VZuaCyyJBw3HbOTs7YpUv1eSXNXEO6C/SVTdnNac9VEVA6fUH9KHxCrZnfwMFhe4RwRkeVpjKSU6LjuDxpKPWpuNH8Se9xX+Gl/aVubRSuSvKYrNlpZXjTip1zJBCQutE2vwJceEO48fxXnzVOjAr32S79xh/TbGO0rCgBUveVzjpTsi+g7nYTBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igcbIEjPFGWAfQwg8s8cUdD8uWIIi6ChiUer45oSBRM=;
 b=TixLH1puSG6vzQJHAVwDqHBwQQFtsS2i6B9GHZwiZVrnPAb+Vr+EgB9o92VEuBABwRx02LiODQDrB9PcOIE4Y0sINzBdpHZ7RC0pPNyJRh/J+4iAAowfRq0v3d5GQGGRDIIcIaN2HwWHhhs8XvMwozAIr9Hx8OWDSZxvmDLdPklSBRE5RD7EeUf1QsTqkABRF7kUYtRS7HIORFQckToDRPPv2Jxq2RRlAIDtmyUGMU71j1btNY+fUs/KyDiq2dHt/nIw5AuIWRflJiI/jD0a7w97puNZKFq4cRO/HUqcshEuqdncAIEqJZnfScmSbiQaCh98MLVl5bPFDcPxvNvysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igcbIEjPFGWAfQwg8s8cUdD8uWIIi6ChiUer45oSBRM=;
 b=IUla0sAKXplANctUUsXKDJ4YFvv2BMuhcbAZn8DDECT/lDNcO3k1tqBv6xmO2rcoe8c5sVTBycOta2rrcQhjw0UsyAHvLiA9whvXF7iucp69Lc/WD7FgPNXXfHPsflL/aUL01RTvBdqfEXZ1b8rsu0x+B8KgtNsYdE5fkXbDP6c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2345.namprd12.prod.outlook.com (2603:10b6:907:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 08:30:49 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 08:30:49 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
 <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
 <8078fb6a-c398-a02a-da6f-79a67e5d9e3d@amd.com>
 <BY5PR12MB3844347BB5326DE7B769A7FCE1D00@BY5PR12MB3844.namprd12.prod.outlook.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <44568adb-320c-23e6-8b66-723cfb0255e5@amd.com>
Date: Fri, 24 Apr 2020 10:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <BY5PR12MB3844347BB5326DE7B769A7FCE1D00@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0184.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::28) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.219] (109.190.135.109) by
 PR0P264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 08:30:46 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 984dd987-bbcf-433f-e3eb-08d7e829cab1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2345:|MW2PR12MB2345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2345A79D6580CF8ED8DF929E8DD00@MW2PR12MB2345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(30864003)(8936002)(4326008)(966005)(31686004)(86362001)(54906003)(16526019)(186003)(36756003)(478600001)(6486002)(81156014)(31696002)(2906002)(66476007)(66556008)(66946007)(316002)(16576012)(110136005)(26005)(8676002)(6666004)(2616005)(52116002)(956004)(53546011)(5660300002)(55236004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azPFdZLW0efzPSIiG9y5dSLAItsxJ8GdEeIHMKZyq1p70V4DxwX2IQS1oWS+qfNjFfBz1hW5yX3W+zq75iBX6YTrxnlITXy6cuFEKk64GFr6/PrTLk2rRxHypAC+3loSaVi5zsYF3wh5hb+RotVTSoCVfboIdqtwmftvsVsI3jb5NFuElXDN98tEC8RrcVSYFm68D5fZvyfyEPUoXc5/czFPRd/v0PXWDtdORegXToJbrGvrh23Y+DT4HOnBLPqzIlAB2NnirD8A7x8XnVq/3LvCVsIlxFwqrTDxHDzq1QuV+YuS5R/5w7bEkZyDjobXEl8Q0s4lXP5mLg19t/ddAgkPmJQ1qIov5Wc+FMQdehurxLYsXkxvr3L12qBhfkskVZg9XFwcw445jlOIyplSDMBjTQ+PFdmhUI00kFImqO8Z1KtPuyZQO2sh5UyRLUAxsoALpogLiLZd5pTswM9rb9lmEB9Cst7KYVkcZpgUbEU=
X-MS-Exchange-AntiSpam-MessageData: eYWKuK8aKV0VPQBxlHsEkDzjCdsN4sGkctyM3SG5q6mL/OfOZG5CBlQvnhewOLl/3vFEn2fMC/g0Y0+PbKJ8yqpJpPOwUGJ5FO41WPybAoIAL9+/C8jOADJoAVl3o5VO5pU0qzbPjTYfCqesUrD4kA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984dd987-bbcf-433f-e3eb-08d7e829cab1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:30:49.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0M6KxcMBwmWn0nw9cM4Vt1lttmgT90bbSkh3ax4VH1p/k+1D6AVVdLx55CqCCxniiZPG1BJaeWLsrkXK4JglQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2345
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Running "umr --autodump" currently does the following:
  - open the debugfs autodump file
  - wait for a hang (using poll)
  - dump gfx rings
  - close the file and exit

I don't think adding support for a "Done" message is necessary, but I'd exp=
ect to
be able to restart "umr --autodump" and be able to perform another dump.

Pierre-Eric

On 24/04/2020 10:24, Zhao, Jiange wrote:
> [AMD Official Use Only - Internal Distribution Only]
> =

> =

> Hi,
> =

> Of course, considering all the suggestions, I will implement a write call=
back for usermode app to notify KMD that a dump is finished by sending "Don=
e".
> =

> In this way, usermode app can do multiple dumps without closing the node,
> =

> Jiange
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:* Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>
> *Sent:* Friday, April 24, 2020 3:46 PM
> *To:* Zhao, Jiange <Jiange.Zhao@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pie=
rre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kuehl=
ing@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
> =A0
> Hi Jiange,
> =

> FYI I'm working on adding a new "--autodump" command to umr that uses thi=
s feature.
> This is not yet merged but you can find the code here: https://gitlab.fre=
edesktop.org/pepp/umr/-/tree/autodump
> =

>> (3) At the same time, considering the use case of this node, I believe t=
hat only the first GPU reset is worthy of a dump.
> =

> If it's possible I'd like to be able to do multiple dumps instead of limi=
ting ourselves to only the first one.
> =

> Thanks!
> Pierre-Eric
> =

> =

> =

>> (4) I didn't implement race condition guard because I believe that this =
node caters for a cautious super-user and a single client is enough to do a=
ll the work. I can add the logic if you think it is necessary.
>> =

>> Jiange
>> =

>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com> =

>> Sent: Thursday, April 23, 2020 4:53 PM
>> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eri=
c <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@am=
d.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
>> =

>> Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
>>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>>
>>> When GPU got timeout, it would notify an interested part of an =

>>> opportunity to dump info before actual GPU reset.
>>>
>>> A usermode app would open 'autodump' node under debugfs system and =

>>> poll() for readable/writable. When a GPU reset is due, amdgpu would =

>>> notify usermode app through wait_queue_head and give it 10 minutes to =

>>> dump info.
>>>
>>> After usermode app has done its work, this 'autodump' node is closed.
>>> On node closure, amdgpu gets to know the dump is done through the =

>>> completion that is triggered in release().
>>>
>>> There is no write or read callback because necessary info can be =

>>> obtained through dmesg and umr. Messages back and forth between =

>>> usermode app and amdgpu are unnecessary.
>>>
>>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>>> ---
>>>=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 =
9 +++
>>>=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 ++++++++++++++++=
+++++
>>>=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |=A0 1 +
>>>=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0 |=A0 2 +
>>>=A0=A0 4 files changed, 97 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h =

>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index bc1e0fd71a09..a505b547f242 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -724,6 +724,13 @@ struct amd_powerplay {
>>>=A0=A0=A0=A0=A0=A0 const struct amd_pm_funcs *pp_funcs;
>>>=A0=A0 };
>>>=A0=A0 =

>>> +struct amdgpu_autodump {
>>> +=A0=A0=A0 bool=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 registered;
>>> +=A0=A0=A0 struct completion=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
completed;
>> =

>> Registered and completed seems to have the same meaning.
>> =

>>> +=A0=A0=A0 struct dentry=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 *dentry;
>>> +=A0=A0=A0 struct wait_queue_head=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpu_hang_w=
ait;
>>> +};
>>> +
>>>=A0=A0 #define AMDGPU_RESET_MAGIC_NUM 64
>>>=A0=A0 #define AMDGPU_MAX_DF_PERFMONS 4
>>>=A0=A0 struct amdgpu_device {
>>> @@ -990,6 +997,8 @@ struct amdgpu_device {
>>>=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_number[16];
>>>=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_name[32];
>>>=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial[16];
>>> +
>>> +=A0=A0=A0 struct amdgpu_autodump=A0=A0=A0=A0=A0=A0=A0=A0=A0 autodump;
>>>=A0=A0 };
>>>=A0=A0 =

>>>=A0=A0 static inline struct amdgpu_device *amdgpu_ttm_adev(struct =

>>> ttm_bo_device *bdev) diff --git =

>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c =

>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 1a4894fa3693..cdd4bf00adee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *a=
dev,
>>>=A0=A0=A0=A0=A0=A0 return 0;
>>>=A0=A0 }
>>>=A0=A0 =

>>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if =

>>> +defined(CONFIG_DEBUG_FS)
>>> +=A0=A0=A0 int ret;
>>> +=A0=A0=A0 unsigned long tmo =3D 600*HZ;
>> =

>> In general please declare constant lines first and variable like "i" or =
"r" last.
>> =

>>> +
>>> +=A0=A0=A0 if (!adev->autodump.registered)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +
>>> +=A0=A0=A0 wake_up_interruptible(&adev->autodump.gpu_hang_wait);
>>> +
>>> +=A0=A0=A0 ret =3D =

>>> +wait_for_completion_interruptible_timeout(&adev->autodump.completed, =

>>> +tmo);
>> =

>> This is racy, in other words it can happen that a new client opens up th=
e debugfs file without being signaled but blocks the reset here.
>> =

>> You could use two completion structures to avoid that.
>> =

>>> +=A0=A0=A0 if (ret =3D=3D 0) { /* time out and dump tool still not fini=
sh its dump*/
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("autodump: timeout before dum=
p finished, move on to gpu recovery\n");
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIMEDOUT;
>>> +=A0=A0=A0 }
>>> +#endif
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>>=A0=A0 #if defined(CONFIG_DEBUG_FS)
>>>=A0=A0 =

>>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct =

>>> +file *file) {
>>> +=A0=A0=A0 int ret;
>>> +=A0=A0=A0 struct amdgpu_device *adev;
>>> +
>>> +=A0=A0=A0 ret =3D simple_open(inode, file);
>>> +=A0=A0=A0 if (ret)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>>> +
>>> +=A0=A0=A0 adev =3D file->private_data;
>>> +=A0=A0=A0 if (adev->autodump.registered =3D=3D true)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> =

>> Probably better to return -EBUSY here. And this is racy, and might need =
a lock e.g. multiple clients could open the file at the same time.
>> =

>> If we use a struct completion for registered we could use the spinlock o=
f that one for protection here.
>> =

>>> +
>>> +=A0=A0=A0 adev->autodump.registered =3D true;
>> =

>> You also need to reset the completion structure here otherwise only the =
first GPU reset would work with this.
>> =

>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_autodump_release(struct inode *inode, =

>>> +struct file *file) {
>>> +=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>>> +
>>> +=A0=A0=A0 complete(&adev->autodump.completed);
>>> +=A0=A0=A0 adev->autodump.registered =3D false;
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct =

>>> +poll_table_struct *poll_table) {
>>> +=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>>> +
>>> +=A0=A0=A0 poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
>>> +
>>> +=A0=A0=A0 if (adev->in_gpu_reset)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return POLLIN | POLLRDNORM | POLLWRN=
ORM;
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static const struct file_operations autodump_debug_fops =3D {
>>> +=A0=A0=A0 .owner =3D THIS_MODULE,
>>> +=A0=A0=A0 .open =3D amdgpu_debugfs_autodump_open,
>>> +=A0=A0=A0 .poll =3D amdgpu_debugfs_autodump_poll,
>>> +=A0=A0=A0 .release =3D amdgpu_debugfs_autodump_release, };
>>> +
>>> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
>>> +=A0=A0=A0 struct dentry *entry;
>>> +
>>> +=A0=A0=A0 init_completion(&adev->autodump.completed);
>>> +=A0=A0=A0 init_waitqueue_head(&adev->autodump.gpu_hang_wait);
>>> +=A0=A0=A0 adev->autodump.registered =3D false;
>>> +
>>> +=A0=A0=A0 entry =3D debugfs_create_file("autodump", 0600,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->ddev->=
primary->debugfs_root,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev, &autod=
ump_debug_fops);
>>> +=A0=A0=A0 adev->autodump.dentry =3D entry;
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>>=A0=A0 /**
>>>=A0=A0=A0 * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/w=
rites
>>>=A0=A0=A0 *
>>> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device =

>>> *adev)
>>>=A0=A0 =

>>>=A0=A0=A0=A0=A0=A0 amdgpu_ras_debugfs_create_all(adev);
>>>=A0=A0 =

>>> +=A0=A0=A0 amdgpu_debugfs_autodump_init(adev);
>>> +
>>>=A0=A0=A0=A0=A0=A0 return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_=
list,
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARRAY_SIZE(amdgpu_debugfs_list));
>>>=A0=A0 }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h =

>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> index de12d1101526..9428940a696d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
ev,
>>>=A0=A0 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>>=A0=A0 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>>=A0=A0 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =

>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3d601d5dd5af..44e54ea7af0f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct am=
dgpu_device *adev,
>>>=A0=A0=A0=A0=A0=A0 int i, r =3D 0;
>>>=A0=A0=A0=A0=A0=A0 bool need_full_reset=A0 =3D *need_full_reset_arg;
>>>=A0=A0 =

>>> +=A0=A0=A0 amdgpu_debugfs_wait_dump(adev);
>>> +
>>>=A0=A0=A0=A0=A0=A0 /* block all schedulers and reset given job's ring */
>>>=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_ring *ring =3D =
adev->rings[i];
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> =

> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
