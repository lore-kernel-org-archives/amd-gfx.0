Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F35C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 20:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162EE10E7AB;
	Tue,  4 Apr 2023 20:58:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61A710E7AB
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 20:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7RYBER1UXW0PPENnHWo2HZeR5XfgNHpDLu1pvPMkRzOH3milrcqH0A2KbGPlSfmjImRvriIeZolUT8MPAtQsjGcqUgJkHwYRyTY0Di9lYZJ/YUvXyF8bevZb4fECwrBesqFtyVPxBfJYZJsK5KA9hRpLGG3t+7qLXqigkKjifhT1jKCJUyrc/5RGZ5MtJ2qatG3Sqndb6TCNddJrs+fOhBaCCPJqygjdM6z6LlxmgVKFidfVUZzRGuwWN16kUNJWxBkq7g/ixpqKgMGhYp1RRfERgr65bdeD8D7kHaFdiLYwimADC5Wpoo0Kut7fkIR3E/LYX2t53lSlaGUr5IHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veCPxOXKZ67Du2dYLmlFKRwtvGDbQvlxE4PA4ZSEnvs=;
 b=QBS8YLXN3B8xCeIfZuAP4vc/JZce7omDkniB7yy3EKe5Dyzp4HPojAgcKC2caFr2Jgdr4JXmai80lEawdme59ntxVsr433iKdLOzNfBzWI8Ae2Qr7FF8mez201ZMMx1XVSjdotNLi9rzf+/MOH14KQzyS/KGFEld6PoBPDjL8EjR/Ph3uKs+xY4YJzYrmkMtcv3yK7Ve1tcv0J2MfFvwtL6mtCCpBCwFAWUH8dzLtmPwZm+TUm8tSCv24NSQoXeXf2Zy15bEWRhHOsrNSbDzXjHo6YYS1PVLqLybLWMY4aHUdeBIPGOGjjKKaQC12Zwea8YW1wC5NMv+fe/sOj32LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veCPxOXKZ67Du2dYLmlFKRwtvGDbQvlxE4PA4ZSEnvs=;
 b=0z+2gWvwe2HqvMx26hQDsU7PGPI39J/QydMn520dLdoA8EZJKojAwhbf/zVfcGKuNxJl+FXnBIqY9oxQ6xtdNAePkQ+6ImOtRbAj9H2sA0RlOsGiFnV9K39ZMvLz4trsJB4OVm7YTejXYnQnSDwc0kb9UVBnYxrqbWDZg60i4ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Tue, 4 Apr 2023 20:58:20 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 20:58:19 +0000
Message-ID: <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
Date: Tue, 4 Apr 2023 16:58:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
In-Reply-To: <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0358.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::19) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a49c8c8-ff2b-479c-80ad-08db354f51f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfdEtVtm2D6GybqsmB+Pe1z1VsvOyjHRthw4e0e4b7lamTxUijmgb5xMQRoksnT+vIFh/VXXeSxqZbrOJdposLU+dxsudb8MzlDjSaTl5R4Ho+tXppzu8f9W+KT1Fhg8IqacEb0qZ/pkqdkMdxUQJiPjJOn3aAkmXwl9iNZHw/AzZYksJd0+ETMrxCcuAVX6u/7BXlQJSlC1QEFPIMbKmJTDqedbndLvhYp67fqZ454JcG9Utkx7t4a6D9Qnut3CdN4MkNf6Yilg9ur6OW09PfWFrBIKkTxOkL29I7K1nUglYLxwjGRaN/1qxbx9rkaV2i+2RCbfVGXTFfhlqhM9fyuFe/KMy4zeVHa2ocZi2DbDHnl7AyVHKytVj76UjuWpPNPE9YiV7dTU3uLXYkj6rKJdjNYVzeYMgMRSwkU3R5KR3h/VCEx+8l8F0sIxeMX+PfZjkRZuuOyDI+iyaw/dS5eQkSBf0S1TqqU1bMPQxTcF3BFjNMJLgq7hD22Ijcq0xr5ISI29bgINhVXoLJ7eHZOi6IMOc4OzX6RVoAHD/MVRNe5ioTDZd6pGKkY2OsOvohLiN9BIzrzt0KNiINFr8o8YgNTCTe1HxlQ+vZGmpS4PMvp1Y9+MghWuHbYBsWYleFCbnJ5qzyVsqfGgW6gAIUY2OYTEPnWpdknAC8KgYIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(66556008)(8676002)(66946007)(478600001)(66476007)(4326008)(41300700001)(8936002)(54906003)(316002)(5660300002)(38100700002)(55236004)(83380400001)(53546011)(186003)(66574015)(6486002)(966005)(6512007)(6506007)(26005)(44832011)(2616005)(86362001)(31696002)(2906002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmVNVHhWVUpNVUMxcWRiWlprU1NuUjlrMlkxOTR4TU1IcFFaVmtaQjRYZWJs?=
 =?utf-8?B?eE90OEhTcGJrUkZHRXppYmJsSHVaRE1PM1k2L0xGUWZWZXdLS1JqeU9PS3h3?=
 =?utf-8?B?elJGM3FleHp1VXBHUXVoV0NjNzFZNEZKT2Z5SGp2c1U0czhXQXcvMnlITFZq?=
 =?utf-8?B?SkpNMWdZT2swbXpYK0g3eXg2UUVxTWdIdFdxVjEzK1FUSmhsaEgrUEZaM1ZD?=
 =?utf-8?B?R2JyRjgwUDRLY2Nvd0RFSGdpN25jV3RyODVzUityTWd1WGx4dHNod2RaVFpN?=
 =?utf-8?B?ZC96NURxdlR6TUg3emhZTFNDTDh2ajlYNHAwV3ZmVFZFT2tjVnA0SzlSY1Mr?=
 =?utf-8?B?Z0ZQRlBaYml4d3JyWHMyTXhJWE9VWFNJSGQrZDRIRmZHUSs2bG0zZlhsNXVy?=
 =?utf-8?B?YnRKZWJVd2dVMTNmTVhFcDBuUWtJcnUyREdMMCszKzBob3kvZkROWVNldjdV?=
 =?utf-8?B?N0twWHJiRFl2OHRFN3M4NVZ5cHhYRDlIN0VyMnpRb0tNcUMzQlA2enRVdmpZ?=
 =?utf-8?B?OUJ2YzhPYXBCcHMzWCtRRzI1bGh4eVdPMDRuYXF2SVJqazhyQUMxZjhpVEp0?=
 =?utf-8?B?YVM4ZDhmdVZoZlVEUUJvRnpCNHB1ek1uR2xvSDBza0cvUHppYXUxOWVzV002?=
 =?utf-8?B?MFROZU1CNk1iMHhKajNrRXROcEZvTjI2WWtoK2lkWklCRTdIcnh1VEdZV054?=
 =?utf-8?B?WmlrdEJlVkQvZVZkRVdsTTZ2am1Jc1BBM1pneVhKK1hYNnNOa01HTC9vZnRO?=
 =?utf-8?B?MmYzSW9ubE13RVA4YitNOENCMmhlZHJPU2ZhM1Rsd1F5MHNjQkYvOTNFTEJx?=
 =?utf-8?B?Y1laNis5ODdxaE15YlZvRjloTlRmTWtqNDRKa1ByVU9hclFHSmlraDVHUmQy?=
 =?utf-8?B?V1ZGeFpNVkxoTDVZQVN3VWF3Zms5OUlzMWsyU3NEV3ZPQXZOR2pwaEtOVEhp?=
 =?utf-8?B?ZEtiZVRCdUc4ZStzRmQ1L0szMHNCU2c5VXlYcFM4aFRSVXVhczkyY0xkbmJF?=
 =?utf-8?B?QXo0aDBzSVhPenNVR0prRDJMK2lTdXR0Z0FITVErYkRyNno5MGJ2WVNjaEFM?=
 =?utf-8?B?NFJTZURVU2k1WkxnVERrNEx1TDYxY1ZKcFF1c2s2MWhrMFRuMVV0ZkZqRFk0?=
 =?utf-8?B?bXZZcUIwc2txYWJpeFJNSU9rdmI4L2p6SW85RVBxWjVNUCtxbjRJMEtta0wy?=
 =?utf-8?B?bmRBTERaUGZ4cjNvMEltd3MxakM2Vm1JYUZkSm9jWGxMbW1GRXR3Z3NNcG5Q?=
 =?utf-8?B?Z09SeGIrd1paSk8zbU1WODByTWNKNkE1bnd3akpENjNvOWVubStDajZiYkJE?=
 =?utf-8?B?ZU96Rk9zdmRqOG9Db01GT3NTZXg2ci93YUUwdjdObUdZUXBsRUJXbHlLVDVO?=
 =?utf-8?B?eTBwS3BJUnRyQkRYN3hEa2w3VHdZZllvbzBnTVRmL2lpd3JpMUV2RHFKS1VU?=
 =?utf-8?B?VllOZzIrcVZudjB4WnNkcFJPSEU5aXd5MURycVpTVzVlblpaazRpZFpKaXBu?=
 =?utf-8?B?d2hKMjViV2FoL0VXZmpFWWZ3V1Y3bnlicTU4dVQrenU1K1ZkaWp4YlpzN3kx?=
 =?utf-8?B?bXlVUWtBUmYzZzRFS09McDZrbVI0Q2N6YUh5OHhROUUyOSsyVE50ZTJOS1RH?=
 =?utf-8?B?UnhzbzJzeGJ2S3RpNENlOExPeGsySU5CMkZOOEluem9reUsyZ29xUXNBVWll?=
 =?utf-8?B?UXZ2S1ZUdjFlQnpFSHJjcEVCeTJwUDhIZlpLTXdwSHBHNmEyYzRCVDd6VG5t?=
 =?utf-8?B?REFTQkJKWGUwc3hQMVdXZUxwS1JiNURaWVpVOTZVWFVvdDlQdkxDbGRhOGMy?=
 =?utf-8?B?YjVZSWV1Y21lS0tubjIxa1Q1TUhCN2w0NjB3U2NGZ21Ld3h1V2F6Yy9LY1ZU?=
 =?utf-8?B?MkxieWJNcFZ0dHNpYXZ5QVRpWnBVQ0Vqay9JbFpEMlBEemFlUWI2T3ZKMDNt?=
 =?utf-8?B?NFRGV1dTSm1FRk9IQ2lCUlh6SnJ5N1cwKzVvRVVBVmVpaWhhcWNwd3FUNm1X?=
 =?utf-8?B?bTFWZ1BKSXBhWVhqR251NW5PdXlGb2NpZnIrNXhRQlFBbHhndVFHUWZVKzRy?=
 =?utf-8?B?QXlGbXdueTI5RzBHeUNjTkk4UjlOci9IQzRSc2NSM2xsUFhTMjVwZHZ2UFc4?=
 =?utf-8?Q?aT4Vcgi/wrB0i2E7/0oVzZibD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a49c8c8-ff2b-479c-80ad-08db354f51f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 20:58:19.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX6jRqfXOWIcQ+pV9EEHmYwBdKJRqHSObjSpgnU275XI+bsUYkDq3Vn23lTu9x+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-04 12:36, Shashank Sharma wrote:
> 
> On 04/04/2023 18:30, Luben Tuikov wrote:
>> On 2023-03-29 12:04, Shashank Sharma wrote:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch adds new functions to map/unmap a usermode queue into
>>> the FW, using the MES ring. As soon as this mapping is done, the
>>> queue would  be considered ready to accept the workload.
>>>
>>> V1: Addressed review comments from Alex on the RFC patch series
>>>      - Map/Unmap should be IP specific.
>>> V2:
>>>      Addressed review comments from Christian:
>>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>>      Addressed review comments from Alex:
>>>      - Do not add fptrs for map/unmap
>>>
>>> V3: Integration with doorbell manager
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>> Just add all your Cc right here, and let git-send-email figure it out.
>> Between the Cc tags and the SMTP CC list, Felix is the only one missing.
> 
> No, that's not how it is.
> 
> You keep people cc'ed in the cover letter so that they get informed 
> every time this patch is pushed/used on any opensource branch.

The cover letter is optional, and you can add Cc tags
into the cover letter and then git-send-email would extract those
(any and all) tags from the cover letter too.

When you pick and choose whom to add in the Cc tags, and whom to
add to the SMTP CC list, it creates division.

> People who are added manually in cc are required for this code review 
> session.

No such rule exists. It is best to add all the Cc into the commit message,
so that it is preserved in Git history.

For instance, I just randomly did "git log drivers/gpu/drm/*.[hc]" in
amd-staging-drm-next, and this is the first commit which came up,

commit 097ee58f3ddf7d
Author: Harry Wentland <harry.wentland@amd.com>
Date:   Fri Jan 13 11:24:09 2023 -0500

    drm/connector: print max_requested_bpc in state debugfs
    
    This is useful to understand the bpc defaults and
    support of a driver.
    
    Signed-off-by: Harry Wentland <harry.wentland@amd.com>
    Cc: Pekka Paalanen <ppaalanen@gmail.com>
    Cc: Sebastian Wick <sebastian.wick@redhat.com>
    Cc: Vitaly.Prosyak@amd.com
    Cc: Uma Shankar <uma.shankar@intel.com>
    Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
    Cc: Joshua Ashton <joshua@froggi.es>
    Cc: Jani Nikula <jani.nikula@linux.intel.com>
    Cc: dri-devel@lists.freedesktop.org
    Cc: amd-gfx@lists.freedesktop.org
    Reviewed-By: Joshua Ashton <joshua@froggi.es>
    Link: https://patchwork.freedesktop.org/patch/msgid/20230113162428.33874-3-harry.wentland@amd.com
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

As you can see the whole Cc list and the MLs are part of the Cc tags.
And the rest of the commits are also good examples of how to do it.
(Don't worry about the Link tag--it is automatically added by tools
maintainers use, although some use Lore.)
This preserves things in Git history, and it's a good thing if we need
to data mine and brainstorm later on on patches, design, and so on.

A good tool to use is "scripts/get_maintainer.pl" which works
on a file, directory and even patch files.

I usually include everyone get_maintainer.pl prints, and on subsequent patch
revisions, also people who have previously commented on the patchset, as they
might be interested to follow up. It's a good thing to do.

Here are a couple of resources, in addition to DRM commits in the tree,
https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format
(The second link includes links to more resources on good patch writing.)

Hope this helps.

Regards,
Luben


> 
> - Shashank
> 
>> Regards,
>> Luben
>>
>>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>>>   1 file changed, 70 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> index 39e90ea32fcb..1627641a4a4e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> @@ -23,12 +23,73 @@
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_userqueue.h"
>>>   #include "v11_structs.h"
>>> +#include "amdgpu_mes.h"
>>>   
>>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>   #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>   #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>   
>>> +static int
>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>> +                         struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct mes_add_queue_input queue_input;
>>> +    int r;
>>> +
>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>> +
>>> +    queue_input.process_va_start = 0;
>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>> +    queue_input.paging = false;
>>> +
>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>> +
>>> +    queue_input.process_id = queue->vm->pasid;
>>> +    queue_input.queue_type = queue->queue_type;
>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>> +
>>> +    amdgpu_mes_lock(&adev->mes);
>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>> +    amdgpu_mes_unlock(&adev->mes);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>>> +    return 0;
>>> +}
>>> +
>>> +static void
>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>> +                           struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct mes_remove_queue_input queue_input;
>>> +    int r;
>>> +
>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>> +
>>> +    amdgpu_mes_lock(&adev->mes);
>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>> +    amdgpu_mes_unlock(&adev->mes);
>>> +    if (r)
>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>> +}
>>> +
>>>   static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>                                                    struct amdgpu_usermode_queue *queue)
>>>   {
>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>   
>>>       amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>       amdgpu_bo_unreserve(mqd->obj);
>>> +
>>> +    /* Map the queue in HW using MES ring */
>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>> +        goto free_ctx;
>>> +    }
>>> +
>>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>       return 0;
>>>   
>>> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>   {
>>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>   
>>> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>       amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>       amdgpu_bo_free_kernel(&mqd->obj,
>>>   			   &mqd->gpu_addr,

