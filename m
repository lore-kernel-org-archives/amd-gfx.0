Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EF4C83004
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20CE208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l2Idyl9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20CE208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8296EEA2;
	Wed, 29 Apr 2020 14:08:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111466EEA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 14:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laMxYeUt2Tt2RG+ebpU/qNIsqbCT4KTiucvVhJSIhD6RCn+rhTPipGx45GUJdiPEE19uXQp7vc4zh6MpqRv9Qmh9/WVRaNlWDA/W/yb+6zPtoTAz6ajo+dcrMbcVnb+q/9NyHoIdKqw0KzrCj3Cr2sGxb4ObFIls5zmeHsfkRA+IM8IUO4VPUBguTaPSQA+cy4peurqFQLC5SdQRZF8cHeEXv9rhYbdZ3ipCXd8AoBh4UdraMgqcvvCxcM1Wv54Wb2GGcym+yr3bnNFgbzriLSZ8+Y74jRG0RM2WXJoszFcM8/C74C3yR7zQpcHb4Tc+1rPxnmUZ2QJhPcIHVwdWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDo2ZHksLMc8wm2n3wj5DLyIulaHnmwOOS4czooPjK4=;
 b=Q9SglcB11YiC+E1Z4gq40/6KFdJx20KEotmLPt/X0wfjeae+ZQdfan8D5Kowa2nB0SEtFPriu7BEYxrQjVGc1RGaJYHLAg1vs2I+SsFKOlf5RkDPCQxAgSA/7QRkItqU1kL3RDLG8koWoP/18BdvWAMK5AhfkoASBIfU5lVSczQ5VMBe+R02SKxUp09SUYa3itm5Xb8heAm59mxMXDlN/l/Gv2KpIO1Txxg30frh5cY5r9QVMc6U7fRisDg3HqrO/aQoTNY5hcT9UrNOtMj5YmSxTL0PGUe4+X/nJX4m8ix10yHQxbuwRarbrzTmIVHFVC7ewmefh7QG/WghLY8EUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDo2ZHksLMc8wm2n3wj5DLyIulaHnmwOOS4czooPjK4=;
 b=l2Idyl9xJvCmBt66d1Y0w7/pvl5gZDaME4tLGzggz+4rdM/zrvu5fF4CTlH2q37dK0BdIlzKDi/5aeBuUdHdWJ3fVXl31byJeZSIWS/5il5SoubJqTdNKDTTu1+fXdZ52Vm/+NG89xJKHOvxmoCHyWS9FyG9pKo+6pU7kd+umWQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 14:08:45 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2958.020; Wed, 29 Apr 2020
 14:08:45 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200429050639.20859-1-jianzh@amd.com>
 <BY5PR12MB38443C7B1DE143B954671CECE1AD0@BY5PR12MB3844.namprd12.prod.outlook.com>
 <3b89b70e-6f21-241d-77e1-9cfbcbbde60b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c8ed8549-3cc7-2b67-70f9-016fab7016ad@amd.com>
Date: Wed, 29 Apr 2020 16:08:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <3b89b70e-6f21-241d-77e1-9cfbcbbde60b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:207:8::30) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0144.eurprd07.prod.outlook.com (2603:10a6:207:8::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.10 via Frontend Transport; Wed, 29 Apr 2020 14:08:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b992e04b-5dbd-4982-b5c9-08d7ec46d473
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:|DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431414F5FEB2828FB69349AC83AD0@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmMV4B6s2ev7QXdI0/VEmnXpmBlt+x7n7t/JQksOXZufkjTBG8HhxfiLvXW1NNiyjN61P282WPvI9kCE3X0uOIWOX9KpM6QbLTvoBPzmLut4RwzZ3leDQiNP1TGZAO4kH02ZNvQW7xdfRtObFDtpR5CWfOqqEu4FPoii2tQLTwp8r1hDnNmYxywJ96zvJs1AJFtsTQDHYIwrVcYHicKqFkrRYUphKEJdwS/L2BgTE+toEjGxnWLSM7RZU00eHApxqBqfdBpz8PQyLqofusd3m5A3FndbIq3cNVnlENt2tnRqXXeUOvpFTmzy8j08Ar/Al5y1+oG163+ct1K5jSu+Q9PZzXo34UeSw3Om66FLU3TYJQ1atzB+2eQDubpu8NgtDiZhgJGcV7DGe6wSDSFwQEE/h9t0jftFHcwiXSzHLAHywc65mWQKkDlid6A35k6YuS6pk+JfSPA81KpV+CZQOp6tbIi6fWC6HuEFgtzHaGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(66946007)(66476007)(66556008)(2616005)(30864003)(36756003)(31696002)(6486002)(31686004)(53546011)(86362001)(52116002)(966005)(5660300002)(478600001)(8676002)(4326008)(6666004)(8936002)(54906003)(16526019)(316002)(186003)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jgd4kpBaWJSnZQ8XG+Az1wwZQ+gd8e7jbNOqJbB7BmGagm0MZt4xtx/u7wMDwaYH+0O4RnCtRumftFwQUxnF16yO5oCOU3jQTXHLbpeVf2jgQyBE//piybZiOv0RWY5wfeyfwNxxuZi8X7OGO1mEKPMT3+RPR63JUSY9yhDSPbOD+EJ/gRA6x+iW67aojsm6dVF219JJ6cC6TnJI539UFB5PigdxbeczYIEOK1wKJSxBVXhI5Cwm9BEI4vvOkyoeyYJ8W0qZy8NA43Wqf2RQWUPO1yalAG2GH8tPCaJUV8vXc1O/WJNQGD32nuxTeh3/YktnscMgxZLv8j/Tl+nBi3wurxJMQDq2tlqMGwN/uuaVPp0S/JJBmJ5LPgkYX3fZs2MiTizp5wlAKzi8CGJBpscStap4klVNxsQOtWqJQHnxbdq1AEoEF8iYyeDu0EG1zH44/99PcKNXFTby3i42oQJJEKAc+O5JtIgWY092XRKNw9m878KR9pYCyY8yHURB0ihBxaCCzKfLMDL5+r8kjTs7H899r4cBn+HnC5AWQVZYYwUbnYTgwJ22pUTxzTmnqGPdnjoafPRJiNPpWv2xjihgmILeSDe7ca/NSVHEgzdQw771SGwHEMNqYiClN7AqWeoQl7+JlNzvRpquT95MRSNcIXgIfj6mNCKkH9c74kdVO4yBn/CW7a8MTsSE/321WBSLeaehVwvFQne0OVdGaefB3UPJPTFnRlsM5ax6Mj72a0PrtIUha1rFUs1d5kIAEs2UhKNskTpDJmFNaQ84xb65henoaE4MI5cedvG1lUoG9sJh8WeRpIhX+j9CRdasmG2lrLcoLtGKu0K05CCgpa6CdoygNuTthF68YVKaMQg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b992e04b-5dbd-4982-b5c9-08d7ec46d473
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 14:08:45.5579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cznu3nGk2Wi4v3HTIaNcdjIMoeNmbLO1Q4noQRffMXoxqkr7c6DOE3JQu/IUyV/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

Am 29.04.20 um 16:04 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Jiange,
>
> This version seems to work fine.
>
> Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
>
> On 29/04/2020 07:08, Zhao, Jiange wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi all,
>>
>> I worked out the race condition and here is version 5. Please have a loo=
k.
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
>> *From:* Zhao, Jiange <Jiange.Zhao@amd.com>
>> *Sent:* Wednesday, April 29, 2020 1:06 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Fel=
ix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-pray=
er@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiang=
e.Zhao@amd.com>
>> *Subject:* [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
>>   =

>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>
>> When GPU got timeout, it would notify an interested part
>> of an opportunity to dump info before actual GPU reset.
>>
>> A usermode app would open 'autodump' node under debugfs system
>> and poll() for readable/writable. When a GPU reset is due,
>> amdgpu would notify usermode app through wait_queue_head and give
>> it 10 minutes to dump info.
>>
>> After usermode app has done its work, this 'autodump' node is closed.
>> On node closure, amdgpu gets to know the dump is done through
>> the completion that is triggered in release().
>>
>> There is no write or read callback because necessary info can be
>> obtained through dmesg and umr. Messages back and forth between
>> usermode app and amdgpu are unnecessary.
>>
>> v2: (1) changed 'registered' to 'app_listening'
>>  =A0=A0=A0 (2) add a mutex in open() to prevent race condition
>>
>> v3 (chk): grab the reset lock to avoid race in autodump_open,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 rename debugfs file to amdgpu_autodump,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 provide autodump_read as well,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 style and code cleanups
>>
>> v4: add 'bool app_listening' to differentiate situations, so that
>>  =A0=A0=A0 the node can be reopened; also, there is no need to wait for
>>  =A0=A0=A0 completion when no app is waiting for a dump.
>>
>> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>>  =A0=A0=A0 add 'app_state_mutex' for race conditions:
>>  =A0=A0=A0=A0=A0=A0=A0 (1)Only 1 user can open this file node
>>  =A0=A0=A0=A0=A0=A0=A0 (2)wait_dump() can only take effect after poll() =
executed.
>>  =A0=A0=A0=A0=A0=A0=A0 (3)eliminated the race condition between release(=
) and
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wait_dump()

Hi Jiange, well that looks correct to me, but seems to be a bit to =

complicated. What exactly was wrong with version 3?

One more comment below.

>>
>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>> ---
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 +++++++++++++++++++=
+-
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 14 ++++
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0 |=A0 2 +
>>  =A04 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu.h
>> index bc1e0fd71a09..6f8ef98c4b97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -990,6 +990,8 @@ struct amdgpu_device {
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_number[16];
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_name[32];
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial[16];
>> +
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_autodump=A0=A0=A0=A0=A0=A0=A0=A0=A0 au=
todump;
>>  =A0};
>>   =

>>  =A0static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_de=
vice *bdev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_debugfs.c
>> index 1a4894fa3693..1d4a95e8ad5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -27,7 +27,7 @@
>>  =A0#include <linux/pci.h>
>>  =A0#include <linux/uaccess.h>
>>  =A0#include <linux/pm_runtime.h>
>> -
>> +#include <linux/poll.h>
>>  =A0#include <drm/drm_debugfs.h>
>>   =

>>  =A0#include "amdgpu.h"
>> @@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
ev,
>>  =A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>  =A0}
>>   =

>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>> +{
>> +#if defined(CONFIG_DEBUG_FS)
>> +=A0=A0=A0=A0=A0=A0 unsigned long timeout =3D 600 * HZ;
>> +=A0=A0=A0=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state !=3D AMDGPU_AUTODUMP_LI=
STENING) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump=
.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);

Please completely drop this extra check. Waking up the queue and waiting =

for completion should always work when done right.

Regards,
Christian.

>> +
>> +=A0=A0=A0=A0=A0=A0 wake_up_interruptible(&adev->autodump.gpu_hang);
>> +
>> +=A0=A0=A0=A0=A0=A0 ret =3D wait_for_completion_interruptible_timeout(&a=
dev->autodump.dumping, timeout);
>> +=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("autodump: timeout, m=
ove on to gpu recovery\n");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIMEDOUT;
>> +=A0=A0=A0=A0=A0=A0 }
>> +#endif
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>>  =A0#if defined(CONFIG_DEBUG_FS)
>>   =

>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct fil=
e *file)
>> +{
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D inode->i_private;
>> +=A0=A0=A0=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0=A0=A0=A0 file->private_data =3D adev;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state =3D=3D AMDGPU_AUTODUMP_=
NO_APP) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D=
 AMDGPU_AUTODUMP_REGISTERED;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
>> +=A0=A0=A0=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
>> +=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 return ret;
>> +}
>> +
>> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct =
file *file)
>> +{
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 complete(&adev->autodump.dumping);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, str=
uct poll_table_struct *poll_table)
>> +{
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 poll_wait(file, &adev->autodump.gpu_hang, poll_table=
);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_LISTENI=
NG;
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 if (adev->in_gpu_reset)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return POLLIN | POLLRDNORM |=
 POLLWRNORM;
>> +
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>> +static const struct file_operations autodump_debug_fops =3D {
>> +=A0=A0=A0=A0=A0=A0 .owner =3D THIS_MODULE,
>> +=A0=A0=A0=A0=A0=A0 .open =3D amdgpu_debugfs_autodump_open,
>> +=A0=A0=A0=A0=A0=A0 .poll =3D amdgpu_debugfs_autodump_poll,
>> +=A0=A0=A0=A0=A0=A0 .release =3D amdgpu_debugfs_autodump_release,
>> +};
>> +
>> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
>> +{
>> +=A0=A0=A0=A0=A0=A0 init_completion(&adev->autodump.dumping);
>> +=A0=A0=A0=A0=A0=A0 init_waitqueue_head(&adev->autodump.gpu_hang);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
>> +=A0=A0=A0=A0=A0=A0 mutex_init(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 debugfs_create_file("amdgpu_autodump", 0600,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->ddev->primary->debugfs=
_root,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev, &autodump_debug_fops);
>> +}
>> +
>>  =A0/**
>>  =A0 * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>  =A0 *
>> @@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   =

>>  =A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_ras_debugfs_create_all(adev);
>>   =

>> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_autodump_init(adev);
>> +
>>  =A0=A0=A0=A0=A0=A0=A0=A0 return amdgpu_debugfs_add_files(adev, amdgpu_d=
ebugfs_list,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARRAY_SIZE(amdgpu_debug=
fs_list));
>>  =A0}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_debugfs.h
>> index de12d1101526..51b4ea790686 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -31,6 +31,19 @@ struct amdgpu_debugfs {
>>  =A0=A0=A0=A0=A0=A0=A0=A0 unsigned=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 num_files;
>>  =A0};
>>   =

>> +enum amdgpu_autodump_state {
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_NO_APP,
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_REGISTERED,
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_LISTENING
>> +};
>> +
>> +struct amdgpu_autodump {
>> +=A0=A0=A0=A0=A0=A0 struct mutex=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 app_state_mutex;
>> +=A0=A0=A0=A0=A0=A0 enum amdgpu_autodump_state=A0=A0=A0=A0=A0 app_state;
>> +=A0=A0=A0=A0=A0=A0 struct completion=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 dumping;
>> +=A0=A0=A0=A0=A0=A0 struct wait_queue_head=A0=A0=A0=A0=A0=A0=A0=A0=A0 gp=
u_hang;
>> +};
>> +
>>  =A0int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_init(struct amdgpu_device *adev);
>>  =A0void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>> @@ -40,3 +53,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ade=
v,
>>  =A0int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index e6978a2c26b7..8109946075b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct amd=
gpu_device *adev,
>>  =A0=A0=A0=A0=A0=A0=A0=A0 int i, r =3D 0;
>>  =A0=A0=A0=A0=A0=A0=A0=A0 bool need_full_reset=A0 =3D *need_full_reset_a=
rg;
>>   =

>> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_wait_dump(adev);
>> +
>>  =A0=A0=A0=A0=A0=A0=A0=A0 /* block all schedulers and reset given job's =
ring */
>>  =A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_ring *ri=
ng =3D adev->rings[i];
>> -- =

>> 2.20.1
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
