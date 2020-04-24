Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A5C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E66520728
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M+718LE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E66520728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1726EA94;
	Fri, 24 Apr 2020 08:37:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6526EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQVMSG2HGMm1pyPSYQQSXi+AdcmwdanC6sN9C7rlrCRMo4r8FW13vfRsID0aAapPx5T/G5XI1sI8xGxIHWEIcayZxGgcZ86p2GM0nqjoDierM3xyKMwceeSx2/HtOJ6uX4AwILi4ud2tapMvlAuLU+ryOmzIJJIaxVlm97haP9OGZmWu0cX/sG1PNmdag8IeaaRYqBw/XHJGiFMBTw4Z+IOPw/8ZhtWziRws4K82qAHAvV0c/g/BrY8OAOgIZnHO5S5CWaf+CQk+bRTh//b5PxpnTteY/1+Jd4xbMgJoi9xmS96Q1ukhuuJMdCyaclsFwkFOSqUizRW+NYQvuFZvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXyIwpSRj9BlBk4oAK2s8DThj3YGdpo4NK9CQQ5RGgs=;
 b=htD0AyEAtREYmrD8aBktZWS0GWDRw4F7LWf+TcsH/JwRQFJlQHKZil/kilyyYu1IT9SHvURmRnG1I+HSkBHxiOPindz61JJMxUDF1RTmMz59D24p14fzDbRVpALCRI92N4Se3ZjUjJimlYGLmYGQF9t4NbxLk6qLwavoCji9BW8FyinWD6/XGoPHApqWtJyHhs5yFSETwOxK+VCkvus2fMo0EpmE1JxPDwt3RaMbRtF+/znaswvKytGqR/uDFMhImdeZVoTVMEXzW9owoEbGCMJR/mDT7n+O8DycmDXiI1Aj45iCq2Mn16zmzzBJQfsxEKbmg1dcVNprN5zimVKRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXyIwpSRj9BlBk4oAK2s8DThj3YGdpo4NK9CQQ5RGgs=;
 b=M+718LE5Gxew+86zf0+lFDqW2xdS5NMM9bzVxrlC6w79rEvHrQ/fYpXi6VicfB54RDYcuiSk7DlrvdAw7BOxLczFAIu4+KEMzZNXYNCHOrbkKA1LHLG9Jjmd41rphz2vBjBa9w31+SUOE7CrtbSmboWmFYfwUaCJ+F7QPqQJez0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 24 Apr
 2020 08:37:31 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 08:37:31 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200423071941.17440-1-jianzh@amd.com>
 <01ebed4a-b376-f5aa-3740-2006119271dd@amd.com>
 <BY5PR12MB3844DC59B0DACE73ABDF2E27E1D30@BY5PR12MB3844.namprd12.prod.outlook.com>
 <8078fb6a-c398-a02a-da6f-79a67e5d9e3d@amd.com>
 <BY5PR12MB3844347BB5326DE7B769A7FCE1D00@BY5PR12MB3844.namprd12.prod.outlook.com>
 <44568adb-320c-23e6-8b66-723cfb0255e5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a3b5c927-df96-8620-1320-70b6bcb7ce7c@amd.com>
Date: Fri, 24 Apr 2020 10:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <44568adb-320c-23e6-8b66-723cfb0255e5@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0032.eurprd02.prod.outlook.com (2603:10a6:208:3e::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 08:37:29 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74b66e79-b944-404e-0997-08d7e82aba75
X-MS-TrafficTypeDiagnostic: DM6PR12MB2905:|DM6PR12MB2905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2905549706875BC0EA56EB6E83D00@DM6PR12MB2905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(66476007)(53546011)(316002)(8936002)(6486002)(4326008)(2906002)(66946007)(186003)(31686004)(16526019)(478600001)(66556008)(30864003)(110136005)(5660300002)(86362001)(8676002)(6666004)(31696002)(2616005)(54906003)(966005)(36756003)(81156014)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtFwhJTE0PWNsq6KA0tn7qMO2+7hqtBrbRGLUe9NO+1p3S+pxLVuTUySyB5+EO1CkjS7YiPBB0Vs2tWUa5WvhG9Vp1BY8PIUqjNnTXSAI6bk4ubF3qEMheD++efElJhyEGWtcNrdLrqHtDgUeKweofNaKqHdi7o+q0IOOJ2q6huwIO0McYzSAjJkRvYBf8uhKvJfQSY+izx4HoQuUGs3PBJuhlFIrHvC9v0vuy3QUxsnSVrunUIIzT9nVOiNOTYNWsN22o5b+O3CGMdl/u/7K490iX8og8WzeNmcsP2vJdGbnzPmwPU9hW5HEnT1A0kemU6Hc+3rmljzLQi5ee62IhWOjTXGisULZcNhyv6Y9ybZYK/4hZmSNNbu9PHaoBfO2QcMyi11gwYuAmtFPdSw6L3qB6tWUQOPeK3kqjv8GtRBiMQ7kcDZw9XdcCm/r8M/xUGNDo6gTW1bcFXgmgMQFzfd5VVTNwtNmC9X7Tl8wBQ=
X-MS-Exchange-AntiSpam-MessageData: tabDlZCBydyE3hVIpK9mcr+k0SpvD6+3IRpwnkFDzKwpb3sbi0rW8mDCX1kp7OHqpV0/aYQ3t6qig+OfW0FAOV2TZW9euzpxxD/0aOL+i00aQ1dFZEAKadFFjVSO9tba1+InBI77qK69itdHGd1g8XxIUuaMlpAMT6JNxwkJAtJMnyazwbjdlJGJ2BjFPk5oqGIYO1goDQl/m4WQb6/TqXVVhcOXL/R/OGKVbJuj8T01UvtNtCVZCTvheDLo2TnR/9jWeWGpEdP3ZeonLD7bJggddX88RwkYPNtCHVBVPwggQQOOEUEg/vcnj3MKD/qu5JV6KDkG24yWlYrtJWRUcU0/Mas95gf2oAorMpfEc8mxVccqMH8zvNFPLBDobjmVCXzZ8I8EvNNvt1SybZIQI0JJ2pbYYDMZmVdwucBUldA1uTk++rEVH8bkBSIw8w8jMnCW5q+pH7JBv79xRMcIGl36KxPT5sP3S+HpXAO2Mgm2DErTYdmpYcHqy7O738smI6Jml3L30mDfSH4qO3hYIlGT9OMii+nbBLxVsL/s/CKhgBZ5QLWNXgoSWO1XTiRnlGqmYsYKOGPskABokZmA4kDkX08tGXyqICbUnuOzTF3OzV6SJmOPY1nBWQp/AUJaNHayLbxSswY+ZOnw7x7WVg3b84AI6UqsrGogSf0Z1x1djsuWOhfGo0/3yuRFiSvNM4pfzLuv4LqO1YpMl62tf4O4fUSHG/+SQB4PLhSEg+JXk4QG0GtzvQC3VdUcHOtUWJM6y5iXCSxoZbhKZh8tJD1I/PdiIpSO3sYeAW5OOHth0LujclsPi2Gf+ln/y6pm809tI8NWGopwyD549olfMyyDX+plEkGJm/KlHbpLU9s=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b66e79-b944-404e-0997-08d7e82aba75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:37:31.2867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4bc1aDrje1BRDeFWWfIgtxBzkYcGi207G74GM98GhHuODhj7rnNv0gA8IOsKZUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I agree. Closing the node is fine, we just need to make sure that =

reopening it gives us another try again.

Shouldn't be to much of a problem, except for a single line the last =

version already looked like it should have worked for this.

Christian.

Am 24.04.20 um 10:30 schrieb Pierre-Eric Pelloux-Prayer:
> Running "umr --autodump" currently does the following:
>    - open the debugfs autodump file
>    - wait for a hang (using poll)
>    - dump gfx rings
>    - close the file and exit
>
> I don't think adding support for a "Done" message is necessary, but I'd e=
xpect to
> be able to restart "umr --autodump" and be able to perform another dump.
>
> Pierre-Eric
>
> On 24/04/2020 10:24, Zhao, Jiange wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi,
>>
>> Of course, considering all the suggestions, I will implement a write cal=
lback for usermode app to notify KMD that a dump is finished by sending "Do=
ne".
>>
>> In this way, usermode app can do multiple dumps without closing the node,
>>
>> Jiange
>> ------------------------------------------------------------------------=
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
------------------
>> *From:* Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>
>> *Sent:* Friday, April 24, 2020 3:46 PM
>> *To:* Zhao, Jiange <Jiange.Zhao@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pi=
erre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kueh=
ling@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu res=
et
>>   =

>> Hi Jiange,
>>
>> FYI I'm working on adding a new "--autodump" command to umr that uses th=
is feature.
>> This is not yet merged but you can find the code here: https://gitlab.fr=
eedesktop.org/pepp/umr/-/tree/autodump
>>
>>> (3) At the same time, considering the use case of this node, I believe =
that only the first GPU reset is worthy of a dump.
>> If it's possible I'd like to be able to do multiple dumps instead of lim=
iting ourselves to only the first one.
>>
>> Thanks!
>> Pierre-Eric
>>
>>
>>
>>> (4) I didn't implement race condition guard because I believe that this=
 node caters for a cautious super-user and a single client is enough to do =
all the work. I can add the logic if you think it is necessary.
>>>
>>> Jiange
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Thursday, April 23, 2020 4:53 PM
>>> To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-er=
ic <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@a=
md.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
>>>
>>> Am 23.04.20 um 09:19 schrieb jianzh@amd.com:
>>>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>>>
>>>> When GPU got timeout, it would notify an interested part of an
>>>> opportunity to dump info before actual GPU reset.
>>>>
>>>> A usermode app would open 'autodump' node under debugfs system and
>>>> poll() for readable/writable. When a GPU reset is due, amdgpu would
>>>> notify usermode app through wait_queue_head and give it 10 minutes to
>>>> dump info.
>>>>
>>>> After usermode app has done its work, this 'autodump' node is closed.
>>>> On node closure, amdgpu gets to know the dump is done through the
>>>> completion that is triggered in release().
>>>>
>>>> There is no write or read callback because necessary info can be
>>>> obtained through dmesg and umr. Messages back and forth between
>>>> usermode app and amdgpu are unnecessary.
>>>>
>>>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>>>> ---
>>>>  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 9 +++
>>>>  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++=
++++++++
>>>>  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |=A0 1 +
>>>>  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0 |=A0 2 +
>>>>  =A0=A0 4 files changed, 97 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index bc1e0fd71a09..a505b547f242 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -724,6 +724,13 @@ struct amd_powerplay {
>>>>  =A0=A0=A0=A0=A0=A0 const struct amd_pm_funcs *pp_funcs;
>>>>  =A0=A0 };
>>>>     =

>>>> +struct amdgpu_autodump {
>>>> +=A0=A0=A0 bool=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 registered;
>>>> +=A0=A0=A0 struct completion=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 completed;
>>> Registered and completed seems to have the same meaning.
>>>
>>>> +=A0=A0=A0 struct dentry=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 *dentry;
>>>> +=A0=A0=A0 struct wait_queue_head=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpu_hang_=
wait;
>>>> +};
>>>> +
>>>>  =A0=A0 #define AMDGPU_RESET_MAGIC_NUM 64
>>>>  =A0=A0 #define AMDGPU_MAX_DF_PERFMONS 4
>>>>  =A0=A0 struct amdgpu_device {
>>>> @@ -990,6 +997,8 @@ struct amdgpu_device {
>>>>  =A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_number[16];
>>>>  =A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_name[32];
>>>>  =A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial[16];
>>>> +
>>>> +=A0=A0=A0 struct amdgpu_autodump=A0=A0=A0=A0=A0=A0=A0=A0=A0 autodump;
>>>>  =A0=A0 };
>>>>     =

>>>>  =A0=A0 static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>>>> ttm_bo_device *bdev) diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 1a4894fa3693..cdd4bf00adee 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *=
adev,
>>>>  =A0=A0=A0=A0=A0=A0 return 0;
>>>>  =A0=A0 }
>>>>     =

>>>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if
>>>> +defined(CONFIG_DEBUG_FS)
>>>> +=A0=A0=A0 int ret;
>>>> +=A0=A0=A0 unsigned long tmo =3D 600*HZ;
>>> In general please declare constant lines first and variable like "i" or=
 "r" last.
>>>
>>>> +
>>>> +=A0=A0=A0 if (!adev->autodump.registered)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>> +
>>>> +=A0=A0=A0 wake_up_interruptible(&adev->autodump.gpu_hang_wait);
>>>> +
>>>> +=A0=A0=A0 ret =3D
>>>> +wait_for_completion_interruptible_timeout(&adev->autodump.completed,
>>>> +tmo);
>>> This is racy, in other words it can happen that a new client opens up t=
he debugfs file without being signaled but blocks the reset here.
>>>
>>> You could use two completion structures to avoid that.
>>>
>>>> +=A0=A0=A0 if (ret =3D=3D 0) { /* time out and dump tool still not fin=
ish its dump*/
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("autodump: timeout before du=
mp finished, move on to gpu recovery\n");
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIMEDOUT;
>>>> +=A0=A0=A0 }
>>>> +#endif
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>>  =A0=A0 #if defined(CONFIG_DEBUG_FS)
>>>>     =

>>>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct
>>>> +file *file) {
>>>> +=A0=A0=A0 int ret;
>>>> +=A0=A0=A0 struct amdgpu_device *adev;
>>>> +
>>>> +=A0=A0=A0 ret =3D simple_open(inode, file);
>>>> +=A0=A0=A0 if (ret)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>>>> +
>>>> +=A0=A0=A0 adev =3D file->private_data;
>>>> +=A0=A0=A0 if (adev->autodump.registered =3D=3D true)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>> Probably better to return -EBUSY here. And this is racy, and might need=
 a lock e.g. multiple clients could open the file at the same time.
>>>
>>> If we use a struct completion for registered we could use the spinlock =
of that one for protection here.
>>>
>>>> +
>>>> +=A0=A0=A0 adev->autodump.registered =3D true;
>>> You also need to reset the completion structure here otherwise only the=
 first GPU reset would work with this.
>>>
>>>> +
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_debugfs_autodump_release(struct inode *inode,
>>>> +struct file *file) {
>>>> +=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>>>> +
>>>> +=A0=A0=A0 complete(&adev->autodump.completed);
>>>> +=A0=A0=A0 adev->autodump.registered =3D false;
>>>> +
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct
>>>> +poll_table_struct *poll_table) {
>>>> +=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>>>> +
>>>> +=A0=A0=A0 poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
>>>> +
>>>> +=A0=A0=A0 if (adev->in_gpu_reset)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return POLLIN | POLLRDNORM | POLLWR=
NORM;
>>>> +
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>> +static const struct file_operations autodump_debug_fops =3D {
>>>> +=A0=A0=A0 .owner =3D THIS_MODULE,
>>>> +=A0=A0=A0 .open =3D amdgpu_debugfs_autodump_open,
>>>> +=A0=A0=A0 .poll =3D amdgpu_debugfs_autodump_poll,
>>>> +=A0=A0=A0 .release =3D amdgpu_debugfs_autodump_release, };
>>>> +
>>>> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
>>>> +=A0=A0=A0 struct dentry *entry;
>>>> +
>>>> +=A0=A0=A0 init_completion(&adev->autodump.completed);
>>>> +=A0=A0=A0 init_waitqueue_head(&adev->autodump.gpu_hang_wait);
>>>> +=A0=A0=A0 adev->autodump.registered =3D false;
>>>> +
>>>> +=A0=A0=A0 entry =3D debugfs_create_file("autodump", 0600,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->ddev-=
>primary->debugfs_root,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev, &auto=
dump_debug_fops);
>>>> +=A0=A0=A0 adev->autodump.dentry =3D entry;
>>>> +
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>>  =A0=A0 /**
>>>>  =A0=A0=A0 * amdgpu_debugfs_process_reg_op - Handle MMIO register read=
s/writes
>>>>  =A0=A0=A0 *
>>>> @@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
>>>> *adev)
>>>>     =

>>>>  =A0=A0=A0=A0=A0=A0 amdgpu_ras_debugfs_create_all(adev);
>>>>     =

>>>> +=A0=A0=A0 amdgpu_debugfs_autodump_init(adev);
>>>> +
>>>>  =A0=A0=A0=A0=A0=A0 return amdgpu_debugfs_add_files(adev, amdgpu_debug=
fs_list,
>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARRAY_SIZE(amdgpu_debugfs_lis=
t));
>>>>  =A0=A0 }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> index de12d1101526..9428940a696d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *a=
dev,
>>>>  =A0=A0 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>>>  =A0=A0 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>>>  =A0=A0 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 3d601d5dd5af..44e54ea7af0f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct a=
mdgpu_device *adev,
>>>>  =A0=A0=A0=A0=A0=A0 int i, r =3D 0;
>>>>  =A0=A0=A0=A0=A0=A0 bool need_full_reset=A0 =3D *need_full_reset_arg;
>>>>     =

>>>> +=A0=A0=A0 amdgpu_debugfs_wait_dump(adev);
>>>> +
>>>>  =A0=A0=A0=A0=A0=A0 /* block all schedulers and reset given job's ring=
 */
>>>>  =A0=A0=A0=A0=A0=A0 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_ring *ring =
=3D adev->rings[i];
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
