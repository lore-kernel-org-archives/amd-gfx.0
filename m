Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9830EFD88C5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 22:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4B510E7A5;
	Tue, 10 Mar 2026 22:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35jzLzl+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C385210E79F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 22:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0g2mg8pakdHppo7EcPcX+fRK/rdX0UxEMb+Zn7kGp8qNeAG9V39NwYSw8NH2UiOaVZdCUXoWZqwrf9VrprvvrUk5rLBEdjMXHgEYJkmlkqC4d2CuCZaG/cV69DOfS5BD5dFWk7XkyuZ5wuNqDO5pmkHEvnkLmycV5KxjXxfjG+Oczik9LSpZ5yiQwqzsuWZQ6g8gVsJ0AXwxfNp8SwuGUS+YRormtpznrMbcnatgA/By1caNLsAsW17v0zcoCI2QiGedEaXkWyGu7L7MjnugOvDc0L0eG5pkQjd2PLsaoJ6bl5RDp5JilOAJckuLTxMrqYowWGRLV605lwcYbpzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcYPui/ByjaM7GfCbVDoxdf8AYehMZtBWUbFql39gRg=;
 b=PCWLBX/7yPab/aHqS+lQHBPmBDgfhCIqEPbOQyCsAbisXTbRW6BSUWKs8195x/LQ5RhFnUHLzgKmWhx87bxNu6TyfFldmqT4ppMkTr7R3DhItt1F2Z69Q04PTWQskJzROOsyOwBbGQ8j3AUG621duMRRObwMMXpsRnR/cYRu25K7/WaRh0LQKWQXMqwr7wKGDSnfnV0VQwwCJa/oOzN3+16y0svR5N8F8nMomtw+gpV2KctgOVMGpL+65XI4Hj5w7PzFT/kBWX5Jh/QEthuJgD3fL3N2sL5ti2o2tg8vDDdFSITWlBDHYj0td2pO6O9vzsDXNm0H0kZNeU2mQWpIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcYPui/ByjaM7GfCbVDoxdf8AYehMZtBWUbFql39gRg=;
 b=35jzLzl+0gJHNHrXxWjvuyF6H2M7YvRfCEasqwigSgO5zp7nbWfN48VVxVEfv+t6iGDaGW1qf7ykDn23CuIzzIg/8B2jAeJC14mz2a7Ht3MLzKv9ev7DOeyBYs79sDa66bYh//xBK1A1QCiSNKMOv4apyeX0zxlaOe+BUFQIYpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Tue, 10 Mar
 2026 22:52:14 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 22:52:14 +0000
Message-ID: <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
Date: Tue, 10 Mar 2026 18:52:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::28) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: e851ae27-7612-4be6-8494-08de7ef7abfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: pJlJZwTwEk1jElvsrRzE4Oa9mK54m0zsPerxZadKpDq4NJ16vJ+iJ/hx8AOyU3IuApds6NUT1wIBIICxc7EZGOpt9wBzs7jtAWTtuz97/tHWY7htMzRMVYABuP0CuyXqSwUkXFZpEVJGD4wxnq8TxVvwmG+HjcvWI9uw+AIRII7M6TsaV8dZFY+x/TtYB68Hxl4y/P2OV57HQ+poDg/jndcxpclN3V0FKeSLr7yhkogE3lYj4cWsd5L5t47ftePmhgthDXrN21XQjfg57qNDTys51vdrjHKlXaddRMBnQiiSlkE64n6zrC4pEsB956mqDp8IlvuAaOdpc3pMPaRKnHZz3uOk8vLpCywzTMu8hTWpms4JykGsqpgnIpaTSLDDo9VbQkoft06/ee3RiUEiPKJ6OamrMzQfrxdOjmtvldpUa1NhpsxjyIZGnE3vb7CYLs3EU+o+tyfVUgG69RWYOE8VChRYK02qxp6yrAJYiip97Obn60YRrJiFvYcKERaTGtxv66rxs92X7UCwMyg34YzMp/16FQzMaN181ibysoqd+/Jdt3qLW1umzM5nEWG5dur9RlBlsHM7a3GnxYum340y39MJi7tu80L8d2dsIMM/ZFwSGQmdhL+J82Giheh49gsS/d67pikgAuozd/OyVeWbRfOS4sakxcH2yScPxDqnNyjp27RVpraMBDQN2nPga1t+e+9VPwRB1nK+sQMSlHUMjo2cvF/9Hzw3jcCgduJC/n9s3CPMkceF8FO0/6Hj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpmZS96Q2plbGNwQ3M0UDEzYUJjODlmOGJoWllLL0QzTy9rMHdUa0t2SGdL?=
 =?utf-8?B?K3NHejBqV2NOS0tZTy9RSkMrSTRMN3hqL0h2TTR6Ukhoek9zTDhzekFsM3l0?=
 =?utf-8?B?RnhVY2paRFZXbzNGZzlCM05nOWNrQ0NyMm9ESENuVDVvZWx0QVc5RGZRakw4?=
 =?utf-8?B?Q3AraTFoS1hKNGlvMXhmOVhGM3M4VGlQNmJCcmU5aTFZaTdJYjQxUzNPWTBZ?=
 =?utf-8?B?U0g3Q1FGVmlid2FGai9TQ3Z6eXpxeEM5clFmVS9KaXNVWk5pVklMZnBQMUtW?=
 =?utf-8?B?YU85RHNLK1FQR3V5dDEweHNscU1jYjlZTmVodFFKOE81eS9pcHJ3Skt1TjZx?=
 =?utf-8?B?Zk9NdWlhSVFnREk5SldhOHlQajRVSFFVb0VLclpOMFV0dDRWYURlck1QSnYx?=
 =?utf-8?B?YWt6OExjWW1rdEJjeStGS3l0bmtEUDQ5MWpCbW5XQU1pTEtIc1RxbXhMVEgr?=
 =?utf-8?B?cERabUZBNnpiZHlVY1RNUDk4d0lIR2RSYWlXNFZ6ZHJqQWNqSXNqV3p0N25R?=
 =?utf-8?B?czVEWVgxUjVmWWZSV0RGTWV5ckRWMDNvS3IxcjVSaGdxaHNwVW51aU1CR05X?=
 =?utf-8?B?TFNueFNJNFRsanVTMWQvbzRLdW9hT2x1N1EwSjVmNVU1S3NwRjhmbTBwZVZa?=
 =?utf-8?B?bW83bWQ5dTl3VVhoZ3JtZFRqUitEWE8xdTI2SUR5TG5WRnBtaUpMOUR2Viti?=
 =?utf-8?B?YWQ2bmFSTGhLaUtKWFNTaXpLM1NZZUZKTWtGRXNKYlNvNlpvb0M0UzFMdWJi?=
 =?utf-8?B?VW5vMzZ4YWZVajdUWE5IYTZsa0Ztc0NHQmk4VVRLRHdhcTV0NWw5TTBMTGd6?=
 =?utf-8?B?QUVZbGdDL053emxaVkJTclJMdk5oQ3dCTFJvR2YxVEZYNGtKWjlva2tZeWtT?=
 =?utf-8?B?NmVlSDNXNUdGc2pNYThVTWhkREt6U1dUMjFWUFhLRjVxZDBxdVNzQWhqWW51?=
 =?utf-8?B?UHRncEJ0RDN4QSt0a05vcDlLMlFhRFBWWFhxYUdRaEd0ZDIrMExqbUVFZ213?=
 =?utf-8?B?TWlhMHMrZzkvQnRJWG40OHRwVFRJT0w3Qi8wZ29qM3hqUlM1T1hDQWpUOHA5?=
 =?utf-8?B?UjdUOGRmKzdud3VvSlEwcVpnbjFvZzhEWjJ2RndCaE54ZHNLbkV4MmVzeVRP?=
 =?utf-8?B?QUZsNThISkVoTUdMOFFSOTNpOGpDODlaaFdrdWF5SXFhemtZVWZTL29KOExm?=
 =?utf-8?B?akk1YW9mZW1kUU5sMFZaSlIvcTJZNCtlR25ESmZyS01vNmREbGhhL2s3Tmdz?=
 =?utf-8?B?ejRvbkpPWW45RDk3Vjl0YWdXdXJtVnJqLzVyL3ZWMERqdjJ6Z1BQWFNTelFa?=
 =?utf-8?B?UG0wM0hLMWpobzgvdlJ1T1JrS1Z2ay96OU9paUEzOVFLNFVCcmhmMDRteUkx?=
 =?utf-8?B?MjkwYlBOSkRHU1hhdnRLeXNKaEdxQk52bzBFTjFDbDQ5dXVSU3hMRkNUQzYr?=
 =?utf-8?B?QW9LOWhLY1p0WDRmQklNMlQxK3VYWmk2YmtGZkw3M0cxSC9xRlJ4QmUrOVJO?=
 =?utf-8?B?R2VLdEdmVnVScnY3ZUpJV09BRXkyZmoxM1VlMndoNldFQTYydm1SdnJwL0kz?=
 =?utf-8?B?b1dkUnU0VFQxUlF0enpyc3l3NWFNVEpITDY1WXRnRXVBT29EWXJGY1hqZTZV?=
 =?utf-8?B?blBFMXZrNGIwUXRub0g3MXVHeEJla3d3SlNUWmJVeDlOdkdJVTNSYzRxYWNt?=
 =?utf-8?B?RXdpWjVxeXF1TnlDZjJ2akRENVFZeGZ0ck5pTGEvc2hGMHVMb2duNXdpWk1q?=
 =?utf-8?B?T25tWEc2eitUOWowOE0yYnZXSWJpb29obHk4ZWNkRy9MMjVKd2xzcEVlVSt6?=
 =?utf-8?B?KytEcitEeFVFSDN6S1JGNDc3TFNGZFhzY1VHTFhHS2F3N29SSExhRno1aktx?=
 =?utf-8?B?V1U1R1F2REdab0ZMd1pMc3d5RUJSbER3b0NQUWJJc09PM0lkcXlldmZNbXRU?=
 =?utf-8?B?WEpQQnIxOE5Deld1ZnVocWhBSkZPYTJGa2xOMUtPc29DSlQ1bTFrU2l3dWoy?=
 =?utf-8?B?Vm9iaGFvRjVjbGN5N3BSRmF0MFljcVcwUlFQb254UjBnNTE1QWRTOFRaWFZa?=
 =?utf-8?B?dUl3VjB4aXduR3BDN0Z0bE1kQ094aFM2KzhWQUY0SklVRW9UUENMZFF1WUdH?=
 =?utf-8?B?V1AyQkoveXZaMzlQWXk0Q3RBRXVFZUZ0WllDT2tUNytScXo2Rlh0OFFFNHpE?=
 =?utf-8?B?N3Z2d0NlcVJSdmd3WnRSZVhEYXNTNUF6MW8xWDl6ekMrSVlGTGZCQzlMcDZC?=
 =?utf-8?B?THVOMThjcUVZWEQ4TkwwdDA5Si9jeU1DMTNpb1UvbFBxcjc1T1VMNkdYdmZa?=
 =?utf-8?B?YjQyaWEwMXh3eXNnS1RBQlNxTmpjc0hIaWN1VkVEaWYyOFAwREM1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e851ae27-7612-4be6-8494-08de7ef7abfc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 22:52:14.2598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoES268Y5WRMm9kF6qEv/QxdJp2EqJxNOQ+UynX0Jduf5ZgNd5fKPzXvCg6tjYdX/AKVlplUEWhlpvoGfjEZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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



On 3/9/2026 5:58 PM, Mario Limonciello wrote:
> 
> 
> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>> Add NULL pointer checks for dev->type before accessing
>> dev->type->name in ISP genpd add/remove functions to
>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>> ISP driver dependencies are loaded in correct order.
>>
>> The regression was introduced in kernel v7.0 where MFD ISP
>> device enumeration doesn't complete by the time it is added
>> to gendp. The timing of ISP device enumeration has changed
>> because of the changes in registering the device sources in
>> the device hierarchy.
> 
> It's a little bit pedantic; but I /think/ there are two different 
> problems here with two different root causes that both happened in 7.0-rc.
> 
> As a consequence I think you should have this split out as two separate 
> patches in a series linked to a Fixes tag with the reason for each of them.
> 
Hi Mario,

Few things to clarify before I split into 2 patches and submit v2.

- Yes, you are correct, the changes in this patch are not directly 
related to the Fixes tag 02c057ddefef mentioned. But since it has the 
dependency on the below patch for automatic modprobe of isp to work, I 
have used the same tag to cover the dependency. My apologies if this 
approach is incorrect and misleading.

https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/

- NULL dereferencing issue with dev->type observed on v7.0 is specific 
to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As the wakeup 
sources are registered using physical device instead of ACPI device, 
wakeup source device (wakeup14) is added as the first child of AMDGPU 
device; and since its dev->type is not initialized properly it has 
resulted in segfault.

In 6.19-rc4 or earlier versions, this issue was not observed as the 
wakeup source device was never part of AMDGPU children list.

For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 in v2.

- MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic modprobe 
of isp (and other amdgpu mfd child devices) to work in v7.0. But 
couldn't identify the specific commit in v7.0 that is causing the issue. 
I can confirm it is not because of commit 057edc58aa59 as the automatic 
modprobe doesn't work even on reverting this commit. Can I submit this 
as the fix needed for isp probe to work in v7.0 without the fixes tag?

Thanks,
Pratap

>>
>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_drv.c
>> index 95d26f086d545..920595f0d22ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>   MODULE_LICENSE("GPL and additional rights");
>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl- 
>> amdisp");
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index b3590b33cab9e..485ecdec96184 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>           goto exit;
>>       }
>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device 
>> *dev, void *data)
>>       if (!pdev)
>>           return -EINVAL;
>> -    if (!dev->type->name) {
>> +    if (!dev->type || !dev->type->name) {
>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>           goto exit;
>>       }
> 
> 

