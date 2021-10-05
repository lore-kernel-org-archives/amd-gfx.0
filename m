Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF446124F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAF446124F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB016EB7A;
	Tue,  5 Oct 2021 12:58:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9856EB7A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ugonjeo7mNMaZdKus68GcG4+HJZliJQUvEcUAnxME1Wf6lOQTgmlCk3CAg7XR2xD8f6ISYN8UOLcgWW73+RI06r7BlwiBO3tTIQM0TNDsopZakcOenOk4dmlwU/Ufz5BQvbMoHPSoIfjTycz+HtG+GMJKWXJJ4YOotQSjnWPqV33mSMZPDgsc/lCLmaSBcjva9Bo+yizMo/aFKgd8bs2CpoCftnYzq9IbVJS72wye5M/Y481u0+19ZZ5kxI7JwO8QGiP62Q/1XzFrM7Klg5G4iLr2iSPmYVW+5dpsavhj27i3/jsSDknsqKfE6pJ1pvecmmynVBwjYpdP5Qr94fUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdB5MLZZVGstlHGvtaZvMOJet6nMgEg8AvvGwwjf3dE=;
 b=Hs3nZrmVZsk8BqtMwyAF/8imU8A+K8A8y8r8nPFAkGxewuTk7qACPzNf7Xax49dlT8bxEG0t04hOEdd5ApLTIWxEQ2SNWiSGs8v+/cN3/vFi8JPaDGh9mMIRwfHhca7KWKtfKA2EDW3yml65NEar8JIxXDp+vjnRbzgLoC8e0Fzm5bYknmaRiS/F3y3XkSfH0aNf/PO5u2+HSobfVLcC0qpdGfXyBrl6QYdtEdCacsGR5q7exd4OBu9xwMZdUjLeIZavKZ2CbV0Of2uiccBpqRbUtUpzBSqGGP/Do4Dr2Ox76D7/9Zy61c4b9J+HNRmA0utE5LjiPfeSX0K7Y0JJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdB5MLZZVGstlHGvtaZvMOJet6nMgEg8AvvGwwjf3dE=;
 b=iITFTKauLufiXpfG8sqjk3p2zLqOQhSXzAXLIEXxqPOlWii27HPjAxMyMY4sDfSqSAIoHLji0Bo68CtaeFmQ8TcGVQwujPzfZSbm+P78vbvfgEOVXIFJPAa4Hbia0QPirM/P/GY8DRanA9PGBouxboqt/EjSfgzLfaB9E9b2vCE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 12:58:38 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 12:58:38 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
 <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
 <0e7ba8b4-9a66-6664-83af-839072458d7a@amd.com>
 <b10471fb-8978-4d68-9fd0-29c851454dc7@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <28d796d3-47f2-4e61-56ab-1d590ff89a22@amd.com>
Date: Tue, 5 Oct 2021 14:58:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b10471fb-8978-4d68-9fd0-29c851454dc7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f22:7600:a4cc:46c0:2b2c:fb20]
 (2003:c5:8f22:7600:a4cc:46c0:2b2c:fb20) by
 FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.8 via Frontend Transport; Tue, 5 Oct 2021 12:58:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b93914-a2d1-4286-c50f-08d987ffd931
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51984A1BE2A0BBECA84F02228BAF9@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDMHXIVNCqMGFuNVzFrk+BeehmzaCmJSWvar8oVXbTwfjXJzv9HPev6nsnZ32oYWdTr39CfbcXObjUD+hyU80O1gNsaYGf85mStZtn0Qzowsy8xXsqHyS1SZfM8VxPIQpf3v4OnpaAMoDfNsZQHTU9yZnHOim6XmO2ygC6dCmSh1FmOAbEmj0T4zkRxYJvGtbj5tLUEX4D0RedOFKPY4+aU2Tnt3UkvB8pQzZfR4xbjsXoxJMiZIhf2HUP7PiblOVJTVbO4CgWmNcCBtmajjpWVN9j16HTwiru744qu3ZeBjhxGRWNEPBESm42XullN+mpxO2Nv3ovXC5s34p3niFKmfKU+dlInB/P0RDqUwrVQWqm7DGPg/iHD5rIyTEnbpDO+s6aBfDEBU8PuA0awjWtthcQu0htuaqPcxGHAEjp4XNC17KFwzsKJPszwX1i7QCiT9ojCPYD7z2r/py5V/+gkTXshOGV/io44vH3gUiB/AYpXYi0CFkbPIi0Ja/H7xYvYXZGn/dzdJ38QeW9Yj37Ca7qm7iTGAMZox6iptLLZO3BWA9syUEUhpIlOcuC6bQe75PTKg0UURW7rHIhiHvipbalhhs5ln+dOeoeYb4sraRMUWAaaUL/5r6pb0IVZAHzjGdQ4M2yLfDIWQ4DyDs2uyrCKyCvpzJKjDDVO/LHhEb8Mov9bKXUQxi4fF4tVs7RpwNQSJapm1XdBuslQENwODm9Y75irvc9rsbGWA+Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(66556008)(316002)(6666004)(45080400002)(508600001)(38100700002)(5660300002)(66476007)(8936002)(2616005)(6486002)(31696002)(31686004)(8676002)(66946007)(83380400001)(53546011)(186003)(2906002)(52116002)(36756003)(4326008)(86362001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkcvRGhzWDVqeTNuQUZDNWNINVBTWjZYNm5ONTBxeDFJd0tKQnVZS0dxOXBI?=
 =?utf-8?B?aFhScmdwRisvNW1WZTdEaUxaR1Q5ejdCTHpMV2ozR2ZiUWRobjFnODM2SFZo?=
 =?utf-8?B?cDNFS1RGcmlpMUJSNVFITXpaNUg5ZU9jQ2lqa2daTlpRYTZkWlpzUHFLK2k3?=
 =?utf-8?B?OEdZWDM2UEZ6UHNvbzU5c1MzYVNXcjhiTzgrWDMrZFlqZm4reGxlZmplRnBn?=
 =?utf-8?B?V1VFY0ZseWplcDFUR2FnKzhsalRCdGF3YzJ3TUVSb0Z4VnlQQlRRVk0xbWZD?=
 =?utf-8?B?QkNKV3Z6TmQvU3V0SHMvSDBsNU9MZldFUjZRcW9YalhHVGQvb0h4cEZQMnpk?=
 =?utf-8?B?OXlXS2ZlUXNtZW9jM1phK0hZaU1OSGdMcGdCc1Z2Q0pvNmFZalF1TjZ5KzNT?=
 =?utf-8?B?ZHRGci85alBwUkQxNzh2K0ZMR0pWNyt6THc2UmFHV1FhRXVHUmZ5eGtqMEZx?=
 =?utf-8?B?ZnNMT25XWnNTVWVsc1ZJYnpYV2V2ZFQrc0V0cnJBNnVmMGF4QzBzVmxZdWd6?=
 =?utf-8?B?TGdIM082ZlJtVkE3N3Z3OVhONzljR1U1M1dabGJZcEt1Z29vMmE3WVVsa28v?=
 =?utf-8?B?RmlTK3lrTFl5eUUwS1A1YlZJSGVoTzVoVVdOdmZoQmRmaVZYN0ZRbmp6VmJO?=
 =?utf-8?B?Um5yVjVLSkRwVmRHTE5jamJ5S1hlWWdsbWh0d2crUURjSDZhWEVkNC9rekIw?=
 =?utf-8?B?ZHF5bWdIUTlHYmJrYnYvSldtanlGUVpmVi9ESFdwYi9xU1hIMHNhdldwQlN3?=
 =?utf-8?B?UWtWSXpZWEc3ZDZnZE1BeGYzZkV4UFlVc1JsOVRlaDVVMi9MZ0R3dEI4SFAw?=
 =?utf-8?B?OXF1MUljb2lUcGxiTHVRMXNwMkF5MXNVelE1WTVJTnVVakV6RXRReWZJbDJs?=
 =?utf-8?B?L2xaWFcwNlgvL2YzK3QyM0UzUGF4UjFqNHVuMnlSRGlzeDlheUZZNXRjUzlh?=
 =?utf-8?B?RkhzZnlBL3dWaDVLTDNiTXloQllla0NKUTh5YVk5dDJDdGwxbVVGQWl6NXB1?=
 =?utf-8?B?SW5JRjQwU2Y0K094cjQrcW5adVlYYkcwZ2xOblRrNGV4Q3dYMk14cStCQWhz?=
 =?utf-8?B?UlY0VGlvVHJOQ25ENjd1MC9GUnBPNDVkUnp6SlZyS2pxWkNKZSs4VkhPZTBT?=
 =?utf-8?B?anRIa2xYL1ZpVHNqWDZ1VXg5SysvTnF3eklPL0h3YWo3K0tWVXZFQzZqb1ho?=
 =?utf-8?B?WDJ2TGtjbXFwQXQrS0hBWTVHQ3pETkRtN1dvdkY3cDNQVzBBbDUweFdLL0FM?=
 =?utf-8?B?c1JwMHI4SlI2bjB1dlRtbzNuV1RFWWFNa1QwdmJUWjNUV1NqTmxYOC9Od0hX?=
 =?utf-8?B?OWkraGQvSDNBSkVDSWErMDUxazhmb2VDVVZjMEhJWjZxNVd0WVV1TGtLR083?=
 =?utf-8?B?SWQ1NG9HWk5mazVhMVYrdUpUVXo0bFhJazZUNVhKNVJ0akgxbXdvb240Wno3?=
 =?utf-8?B?T0lJcElCQ0NFNXJzeTlFY2N5K1JDeEVXNnJNTER5MmtFS2lRcm5pWmtHZVp1?=
 =?utf-8?B?VVFzQ254YzdBdGg0OFZOeklzRWFsSDlvdEVmRnpaTHN3VEFnQm5oMndoLzUr?=
 =?utf-8?B?SzJLbWJJQ3Z2OWgwZHdsKzQ2VVlxV1UzblRmcG9IRmR5S3g3RFRHL3pRSS92?=
 =?utf-8?B?RklqVm9XMjhJOTUvL2Q2VENRbHlVekhPUzYrYm1FOURLb0ZJZjRCNk4rS0xE?=
 =?utf-8?B?cGRwalpROGpHMGUvaHFkSDNtL3dOZC95akhRNCt2RFEwTXZKaTd0T2k1blJD?=
 =?utf-8?B?WVZYRndQMmFsKzFQd0FyTVNsRUllU0xIa2lSaVRCQmhtbHpQbEhoUnhHNzFY?=
 =?utf-8?B?ZjgxZWhKaDJQTTFJYWVDNFR1WGIwVW1UUlh6UkJaczFaQkU1MDg0ZG9XdHBE?=
 =?utf-8?Q?LTFoNaOGC1+IQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b93914-a2d1-4286-c50f-08d987ffd931
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:58:38.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Lc4zb2ONbwh5xZA/eiQeSMi3FAt7xeF4YkRA9EOZeb+tvCQTUieo+xxPca/aAb2dBAWeQIlA26PK5Hbkm+Ehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/5/2021 2:41 PM, Christian König wrote:
>
>
> Am 05.10.21 um 14:20 schrieb Das, Nirmoy:
>> Hi Christian,
>>
>> On 10/5/2021 2:01 PM, Christian König wrote:
>>> Am 05.10.21 um 13:58 schrieb Nirmoy Das:
>>>> drm_dev_register() will try to init driver's debugfs using
>>>> drm_driver.debugfs_init call back function. Use that callback
>>>> also for amdgpu to intialize debugfs.
>>>
>>> Mhm, why is that useful? We rather wanted to get rid of all this DRM 
>>> midlayering.
>>
>>
>> Actually main issue I am trying to solve is:
>>
>> When user disables debugfs with CONFIG_DEBUG_FS_ALLOW_NONE, amdgpu 
>> gets EPERM and throws a DRM_ERROR even though it is not an error as 
>> this is user controllable.
>>
>> Shall I just make all debugfs error logs to DRM_WARN ?
>>
>> ref: 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686%23note_1052168&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C63032bdca1394c92e88808d987fd867b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637690345246933980%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eXyj6wlxD0YGiNsjB4smmRAm2KKGRtq%2FWiDSMzEWTo8%3D&amp;reserved=0
>
> Why not just add an "if (!root) return" at the beginning of 
> amdgpu_debugfs_init() ?


This is fine too, I will resend.


Nirmoy

>
> Regards,
> Christian.
>
>>
>> Regards,
>>
>> Nirmoy
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>>>>   3 files changed, 9 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 6611b3c7c149..3076742f8f85 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>   -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>>>   {
>>>> +    struct amdgpu_device *adev = drm_to_adev(minor->dev);
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>       struct dentry *ent;
>>>>       int r, i;
>>>> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct 
>>>> amdgpu_device *adev)
>>>>                     &fops_ib_preempt);
>>>>       if (IS_ERR(ent)) {
>>>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>>>> file\n");
>>>> -        return PTR_ERR(ent);
>>>> +        return;
>>>>       }
>>>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, 
>>>> adev,
>>>>                     &fops_sclk_set);
>>>>       if (IS_ERR(ent)) {
>>>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs 
>>>> file\n");
>>>> -        return PTR_ERR(ent);
>>>> +        return;
>>>>       }
>>>>         /* Register debugfs entries for amdgpu_ttm */
>>>> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct 
>>>> amdgpu_device *adev)
>>>>       debugfs_create_blob("amdgpu_discovery", 0444, root,
>>>>                   &adev->debugfs_discovery_blob);
>>>>   -    return 0;
>>>>   }
>>>>     #else
>>>> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>>>   {
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> index 371a6f0deb29..06b68e16e35d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> @@ -27,7 +27,7 @@
>>>>    */
>>>>     int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>>>> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
>>>> +void amdgpu_debugfs_init(struct drm_minor *minor);
>>>>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>>>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>>>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index df83b1f438b6..ceda650895db 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev 
>>>> *pdev,
>>>>               drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>>>>       }
>>>>   -    ret = amdgpu_debugfs_init(adev);
>>>> -    if (ret)
>>>> -        DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>>>> -
>>>>       return 0;
>>>>     err_pci:
>>>> @@ -2479,6 +2475,9 @@ static const struct drm_driver 
>>>> amdgpu_kms_driver = {
>>>>       .dumb_map_offset = amdgpu_mode_dumb_mmap,
>>>>       .fops = &amdgpu_driver_kms_fops,
>>>>       .release = &amdgpu_driver_release_kms,
>>>> +#if defined(CONFIG_DEBUG_FS)
>>>> +    .debugfs_init = amdgpu_debugfs_init,
>>>> +#endif
>>>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>>
>
