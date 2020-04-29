Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE6CC83004
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB012082E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Clnur5+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB012082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3726EEA5;
	Wed, 29 Apr 2020 14:05:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DEE6EEA5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 14:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPWDYccGAcxLefObGcY2IjtGOSVP5zUJdCc8Uf0OEOJEoHexcXrX0MXIBAGNO6p5YsxyYYPu0Aj474fp3wPYkCpA05tvTIkBWSBRC25C2BaFIEzvfHT1gE+QABpk5TU7OWsUtIbzBOudA4EfHZSrIejB1rbzylzbT9vr9r7iNoXRG+FbA8SyFk4sS5CVw0r6822Tz3G4zhHyOmwm/77k+TJ1ApgI9bXwvvX+XlFsQd5GfiK2bRb/75qDa5CMblQsSWjbbmzKfIJT82BK3AFdYPLYboSQOK/kmGs0vsPxb8WPeSwlycFuRThQZgw5v87pbfdcfinKm+g/W06d3XOzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1pu8BL32//s4RbGP/fI1EHwsewq6NVgWG35KU+2DBw=;
 b=AxMKjpNJVRdzHCktKlyqnO7eDqPbIZOLceFRzQP6nWV70PjpG577yy7nfzQMUSRNlui3yPSh8+V7YgRndrXeRz+wMEi4nDlX3fk/em9nNrN/08+6Z01fvEHbIedZ8/zXOsBb0po3H9uBP38WUAoMT2cH87k6p+JoQPqrXTSgjfmPCSnWIDckIaLonmuNzxea883KI47wGvnC/wDg7y5wtVeHAZuMfhMbZUH4PPYNa6iPmho2RjRud7RFGqNNJ62g2fcA1CYS8p3gihIPVJUQyDT1FYixAPJMryOVCCkF4avKWf/8V6MbwfjTi2wiHaV2OAD3VTERKDEYjxKwfA+Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1pu8BL32//s4RbGP/fI1EHwsewq6NVgWG35KU+2DBw=;
 b=Clnur5+GC0ZEWhoYkNVMXNpxXTEMO0ZpZniLFcf0ybmuP0ni4E4GzRICSE2BGHFCN3R38NeUVnI5A2kZlKOxMkdVyKi1Y0uif7HaBofjnm+tvYhwQNiGIAe0FfWvRGg5zwhXN/04z0y6IGQdYQ3k7Knc/z/Qxag/WFpbz8oTN1M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 14:05:09 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::950a:443b:a92f:4e46%5]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 14:05:09 +0000
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200429050639.20859-1-jianzh@amd.com>
 <BY5PR12MB38443C7B1DE143B954671CECE1AD0@BY5PR12MB3844.namprd12.prod.outlook.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <3b89b70e-6f21-241d-77e1-9cfbcbbde60b@amd.com>
Date: Wed, 29 Apr 2020 16:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <BY5PR12MB38443C7B1DE143B954671CECE1AD0@BY5PR12MB3844.namprd12.prod.outlook.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::22) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.234] (109.190.135.109) by
 PR0P264CA0202.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 14:05:05 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cd8f440-d97e-414c-6637-08d7ec4653b7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2410:|MW2PR12MB2410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2410EFD2F08705742CBE90788DAD0@MW2PR12MB2410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBQHaxkC7KC+i8TnZubA6e96Iw5B82Uaoa3/HarPiNKPXXi5dQ/soeuc1d8rmhg7OjUjGb+wB9BjGj/js92sjuDAawECr/ZN+mKx1OdOCqYJesEDo5lu/uIX9j2Io6UCDxIR2uk6PTceUBT1J0ZTH5QBcR5ylv17qQaaVg0+QwOkdDhUo3ZEByEADLLqZavMO1ayCcC2N0U3DigkHg8hjlJL5Jv6n+NzK/kzZonG3nqH8zrpi7nfahTMAS7+w2EhGS8tdPlZVKq85CnaeZ5vsqZWXLp5U6xVapjBEBZBLhOw49U0b2oWW0ThSRXpB/BXtMVf51tQEVb0y4Ar3x4slpN3MPcqhsEh5OIwfTELEyA1au6sW53SgPWL3eEocvkrjYhIrhvLK8TDYlsYi8Xu2v6ZawZCcVwFv4demiSupe+htXGyyS31FgOkANYnaBuEpGT85331/YQ7SrTwe78ieZvkc+w2kZwgNuXE5fYZvQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(8676002)(8936002)(478600001)(6666004)(16526019)(186003)(36756003)(26005)(956004)(6486002)(86362001)(31696002)(2616005)(5660300002)(31686004)(55236004)(316002)(4326008)(54906003)(66556008)(66476007)(66946007)(52116002)(53546011)(16576012)(110136005)(966005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nArBMOCUSDshvOaUb/gRoNMh/GwXkPAmm6yXvBkMQnPfzNeIqRORuqqcVQmkDXfTLxX8cV8rxBNzYdEQrv14rPT/dqbqSLIzxldyACQ/lDEVlTp7X8fihXFa01Q9HlwdHpGsugSw+qAGwka5NTIoYXdJJOYTpRNPjmQmmABPOWBY/eQRLDElHE3Cyg77luTYksT5qea+F4KLnTfIZeeGB3YHotANW0W8OVVBfhEtDc6ECyug5Xc2aE4oj+GRWoMk4W2UYjJ4s+taC/2+oEsgwJK4RIj9uKkGGot4Gl7dOI6LN6O4BYOhHHxh+MP8QjHKujpV5oQFAVlENCX90kDhmvCsQK88xWuChkmMswVaXc9eEEUBwF/c+x2ybuWbK4IdPOV2Rgmb/nRzIGritPqT+N7dJ+xzJuLnT6JUHUBqUBKE6gui3/L45kMIhF52MUQ6ro7sDUnyWXubiz5gVeE/pjH8gXKCjjeLJepa/HaFVa5f1s+svvp/8IKGJyDju2/hUOQA+wxvNvnpedq1EMbamZmRqBoWwp9pIRQsd5vD91urSMGTKNWZ3RDSPCJEijgs3Dz8aezCxwtn01cgXCyhK7AnTJX44oKP6mJmFGmsrQFws1l3GafF7v//bU7L9eCIW9zlXN/EsNRW/3Qwx3sXX9FHR+4kLHnacVunDxVJ4Q8KC+66uRjo3AGa04RGY5qXTCkmoD3FeBmiXO1XhLQx+yAuNQod/Rvqg/X7vfyFOwfZPgj1W0YmJesBU2+LLJ/lihTHD1SUBdNLEJtvCRYmsVM3BsSsduoy+N6JTe7PDqsyom1tOSkBpgGH2GtxYJyR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8f440-d97e-414c-6637-08d7ec4653b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 14:05:09.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2BbrGidqZ/wl6okm/Ao5FxtY4D6wz9TnpioojwW1cBP30KcVsK3gCcXi89GVfTVh2AAxJ+mfT9SO9U6bymgVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jiange,

This version seems to work fine.

Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>


On 29/04/2020 07:08, Zhao, Jiange wrote:
> [AMD Official Use Only - Internal Distribution Only]
> =

> =

> Hi all,
> =

> I worked out the race condition and here is version 5. Please have a look.
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
> *From:* Zhao, Jiange <Jiange.Zhao@amd.com>
> *Sent:* Wednesday, April 29, 2020 1:06 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Feli=
x.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-praye=
r@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking =
<Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange=
.Zhao@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
> =A0
> From: Jiange Zhao <Jiange.Zhao@amd.com>
> =

> When GPU got timeout, it would notify an interested part
> of an opportunity to dump info before actual GPU reset.
> =

> A usermode app would open 'autodump' node under debugfs system
> and poll() for readable/writable. When a GPU reset is due,
> amdgpu would notify usermode app through wait_queue_head and give
> it 10 minutes to dump info.
> =

> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through
> the completion that is triggered in release().
> =

> There is no write or read callback because necessary info can be
> obtained through dmesg and umr. Messages back and forth between
> usermode app and amdgpu are unnecessary.
> =

> v2: (1) changed 'registered' to 'app_listening'
> =A0=A0=A0 (2) add a mutex in open() to prevent race condition
> =

> v3 (chk): grab the reset lock to avoid race in autodump_open,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 rename debugfs file to amdgpu_autodump,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 provide autodump_read as well,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 style and code cleanups
> =

> v4: add 'bool app_listening' to differentiate situations, so that
> =A0=A0=A0 the node can be reopened; also, there is no need to wait for
> =A0=A0=A0 completion when no app is waiting for a dump.
> =

> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
> =A0=A0=A0 add 'app_state_mutex' for race conditions:
> =A0=A0=A0=A0=A0=A0=A0 (1)Only 1 user can open this file node
> =A0=A0=A0=A0=A0=A0=A0 (2)wait_dump() can only take effect after poll() ex=
ecuted.
> =A0=A0=A0=A0=A0=A0=A0 (3)eliminated the race condition between release() =
and
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wait_dump()
> =

> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 14 ++++
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0 |=A0 2 +
> =A04 files changed, 109 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index bc1e0fd71a09..6f8ef98c4b97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -990,6 +990,8 @@ struct amdgpu_device {
> =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_number[16];
> =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_name[32];
> =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial[16];
> +
> +=A0=A0=A0=A0=A0=A0 struct amdgpu_autodump=A0=A0=A0=A0=A0=A0=A0=A0=A0 aut=
odump;
> =A0};
> =A0
> =A0static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_devi=
ce *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..1d4a95e8ad5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,7 @@
> =A0#include <linux/pci.h>
> =A0#include <linux/uaccess.h>
> =A0#include <linux/pm_runtime.h>
> -
> +#include <linux/poll.h>
> =A0#include <drm/drm_debugfs.h>
> =A0
> =A0#include "amdgpu.h"
> @@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ade=
v,
> =A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> =A0}
> =A0
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +=A0=A0=A0=A0=A0=A0 unsigned long timeout =3D 600 * HZ;
> +=A0=A0=A0=A0=A0=A0 int ret;
> +
> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state !=3D AMDGPU_AUTODUMP_LIS=
TENING) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.=
app_state_mutex);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> +=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
> +
> +=A0=A0=A0=A0=A0=A0 wake_up_interruptible(&adev->autodump.gpu_hang);
> +
> +=A0=A0=A0=A0=A0=A0 ret =3D wait_for_completion_interruptible_timeout(&ad=
ev->autodump.dumping, timeout);
> +=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("autodump: timeout, mo=
ve on to gpu recovery\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIMEDOUT;
> +=A0=A0=A0=A0=A0=A0 }
> +#endif
> +=A0=A0=A0=A0=A0=A0 return 0;
> +}
> +
> =A0#if defined(CONFIG_DEBUG_FS)
> =A0
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file=
 *file)
> +{
> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D inode->i_private;
> +=A0=A0=A0=A0=A0=A0 int ret;
> +
> +=A0=A0=A0=A0=A0=A0 file->private_data =3D adev;
> +
> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state =3D=3D AMDGPU_AUTODUMP_N=
O_APP) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D =
AMDGPU_AUTODUMP_REGISTERED;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
> +=A0=A0=A0=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
> +=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
> +
> +=A0=A0=A0=A0=A0=A0 return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct f=
ile *file)
> +{
> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
> +
> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
> +=A0=A0=A0=A0=A0=A0 complete(&adev->autodump.dumping);
> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
> +=A0=A0=A0=A0=A0=A0 return 0;
> +}
> +
> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, stru=
ct poll_table_struct *poll_table)
> +{
> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
> +
> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
> +=A0=A0=A0=A0=A0=A0 poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_LISTENIN=
G;
> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
> +
> +=A0=A0=A0=A0=A0=A0 if (adev->in_gpu_reset)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return POLLIN | POLLRDNORM | =
POLLWRNORM;
> +
> +=A0=A0=A0=A0=A0=A0 return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops =3D {
> +=A0=A0=A0=A0=A0=A0 .owner =3D THIS_MODULE,
> +=A0=A0=A0=A0=A0=A0 .open =3D amdgpu_debugfs_autodump_open,
> +=A0=A0=A0=A0=A0=A0 .poll =3D amdgpu_debugfs_autodump_poll,
> +=A0=A0=A0=A0=A0=A0 .release =3D amdgpu_debugfs_autodump_release,
> +};
> +
> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +=A0=A0=A0=A0=A0=A0 init_completion(&adev->autodump.dumping);
> +=A0=A0=A0=A0=A0=A0 init_waitqueue_head(&adev->autodump.gpu_hang);
> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
> +=A0=A0=A0=A0=A0=A0 mutex_init(&adev->autodump.app_state_mutex);
> +
> +=A0=A0=A0=A0=A0=A0 debugfs_create_file("amdgpu_autodump", 0600,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->ddev->primary->debugfs_=
root,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev, &autodump_debug_fops);
> +}
> +
> =A0/**
> =A0 * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> =A0 *
> @@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_ras_debugfs_create_all(adev);
> =A0
> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_autodump_init(adev);
> +
> =A0=A0=A0=A0=A0=A0=A0=A0 return amdgpu_debugfs_add_files(adev, amdgpu_deb=
ugfs_list,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARRAY_SIZE(amdgpu_debugfs_=
list));
> =A0}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..51b4ea790686 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -31,6 +31,19 @@ struct amdgpu_debugfs {
> =A0=A0=A0=A0=A0=A0=A0=A0 unsigned=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 num_files;
> =A0};
> =A0
> +enum amdgpu_autodump_state {
> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_NO_APP,
> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_REGISTERED,
> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_LISTENING
> +};
> +
> +struct amdgpu_autodump {
> +=A0=A0=A0=A0=A0=A0 struct mutex=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 app_state_mutex;
> +=A0=A0=A0=A0=A0=A0 enum amdgpu_autodump_state=A0=A0=A0=A0=A0 app_state;
> +=A0=A0=A0=A0=A0=A0 struct completion=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 dumping;
> +=A0=A0=A0=A0=A0=A0 struct wait_queue_head=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpu=
_hang;
> +};
> +
> =A0int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> =A0int amdgpu_debugfs_init(struct amdgpu_device *adev);
> =A0void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> @@ -40,3 +53,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
> =A0int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
> =A0int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> =A0int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e6978a2c26b7..8109946075b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct amdg=
pu_device *adev,
> =A0=A0=A0=A0=A0=A0=A0=A0 int i, r =3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0 bool need_full_reset=A0 =3D *need_full_reset_arg;
> =A0
> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_wait_dump(adev);
> +
> =A0=A0=A0=A0=A0=A0=A0=A0 /* block all schedulers and reset given job's ri=
ng */
> =A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_ring *ring=
 =3D adev->rings[i];
> -- =

> 2.20.1
> =

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
