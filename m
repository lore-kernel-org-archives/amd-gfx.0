Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0FBFCC9AA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 05:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17BE10E0B1;
	Wed, 11 Mar 2026 05:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QkXYxId4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0556B10E0B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 05:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmFMsucAsWLi7QEI6UmuXi/5MhCIdTj5yiiihmNo3b7pHLeHG9yIHhZy94Gq9JvA0ITqosw18jpQkTWvKFOveOLYMc396V+86aIpKlg1indBQX+FS03EeRO4GDkvEVhWoOqOrCnjekdkRr2twbnNNELmfwYyJfUhFhoP+b7120sBTCGDcMnFoUmQIw4eFGie5NQHCaD66cQcwuKGkALdKbvFGMoKPIag5NDRmQJzM2JsvxOaYq2DViy+noYLpr39X1fTbFtC8DGaEVS54JQMqmX1p8/YaCJUlJPTS8FiOoNR6N4XEzOHp3sdEkkNP2+T3KYTAXtDrOCa0xYkfVeOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzgcNgKKiWc4CI5cRx/CvyWVvDzxjbSmSBBpIa0OD2o=;
 b=f435gbfZNocyw0N7YlSaO8egW5zDeSRVpbSxMVaQqw6CmuJOGpAjaymVb6ZgjJC46pOmZW3jJQtOjNkowyizElbzc4tiCdwRePogqRL2aamhmo2lZcDY2Or+UpfU+Xz2iTuW6SKJfHD6ZKYevwKVWNv8BjZSVLwVZ4A/JBIT1JrPW3mjJ4Xk7PCWgMnBSUILTM1maJGEF1+2OtvdNXDaFqQUFi4eXt8bNiA83mbojR4flaPW4QRvbuyguKVsPptUDumW1sIXh+2hnFSIPr4H2Bsjzb/JyHENloOwXIZHoUFj3U63AwJClEyEvY6rVaekFFL0PEjOe1SeR/cCJiqEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzgcNgKKiWc4CI5cRx/CvyWVvDzxjbSmSBBpIa0OD2o=;
 b=QkXYxId4xopbufsRrS3J89Il2VBPbKE1jkQAM2eyOgWXWAULaTBFSVgE0tcrW28PH3Ylt21xcD2NAN0rxPqjCWqlZ2AG8CONZ7ShpXtPt8r6Fkb6J1/Ew5isFZ3iXWWxIg0Zei/7MA8ExWmyoYF9geWahBgvX861ki3h1wNluvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 05:26:57 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 05:26:57 +0000
Message-ID: <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
Date: Wed, 11 Mar 2026 00:26:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:610:4f::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 54954951-d7c0-43f7-99a5-08de7f2ed043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: L7kYb+kZP/F+An3xv2wfmUW8xBqsTXLJYEolvKZ71tIJvywXfmBjxILd5UZF8mrtBIcoz3glyC4W7egh1FxYRWikda1ds8rzCb37exywA2r87gWj+AyZ2UtNeejJMDoJPWJLUcgeWMWwgUWInUyzsFnGmx7rgUM/dC5t0PNhkIjN7yIL/yqDN78GTxfeJJC3c2dJK6V5gcyLGGs4aNCO2NGR5WTdG9+vAQzYT+eMSg5q0y/KxuJsUjeFHYNpiftXSRzrrk3cuHO1wojIjkb57d6h/FNg03IW/euXFW9zQ2SU2xtIAXAf17hRvzvS6f/fJY5ChvRplt5tTfcEjPzw3pE6op6IHewnGgIylWhmb4s3cX6Drmw7136XDY7LqQWGi7GbZ9lzGSgvHTadBTkmIrOhaeRIQE+7z2kw0AFS2ExRe3xP3Hcq2tGj6/fQBwO0LI+xCEX1Yjy71L/vKPtpiZCT9GvwFjs7jB9a+cCyKVzWt48qZDAanPG25I56RdBh/LaQW9LGMeJCbezGX8edRnjY1TfCK96dGfABt/JPWKaDSRYYHOjz6ZaoYZcq9NTZiVORw2ZiJ9sF3nnmKoxWdE0QOD9TP2owfvhAPQdAJV8Nt4vWMSv+k7WsA+e02FphIAkqSAVJvnC3e0t3pro4Xf4+pv3XXHGyNE49UC6hiE/6W6jMc8dUQXWvl3rcNbBt94xVAuhoCgta91oddBuE5SXrmLmnfQr3/eN68THKd8peeUtyPmuRV6lEbo/0iLgI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJFSzJWZGl5Y0M2SXhzZmVvZzNSa05Qak0wa1VLMkE5ZVN6QWxRa05Odk42?=
 =?utf-8?B?QW1LUnpLSWtCRXJlSElZT3k5WCttSmw2KzFZWXVndGV2UytxTjZNU3FPM2NF?=
 =?utf-8?B?UVljbERacEFPMHhVSXY5L3JNZUxCcllpU2d5WUljdFJwcWh6a2pwUzk1YXRF?=
 =?utf-8?B?UDAwWHlya3V6aUxVVHdIMUwzK2U4V0h1aUhhTDFEdXlqMGYxUDdMTzUrYUVx?=
 =?utf-8?B?Wnd6aGorWmNEN0pxdHFRU0ZPTHdHTSsvRk9VSE5xeUNnd3psL295a1h1SFla?=
 =?utf-8?B?R1kxZktQRzJPdGVtQUlWcVM1eXZpdVdYQ2xkTW1kalNQaXZBNVI4RCtvSW5C?=
 =?utf-8?B?QU5rSmp2RmZ5bUNtN3Q4UWh3SU9vRCt1L09oQTJLL0dRTmRYRzdTckdNSXNk?=
 =?utf-8?B?ZjBDZDhOdXBiZlQwTVJNeWxmRDF0cDR6Z2pNK1VYVms2blc2aW95aUh5YXFW?=
 =?utf-8?B?RGliVW8rWkxTa1c1WFBEdEczTW5JTDdDa1c0bWtpV2dmMlM5V1dXbXgzcFRk?=
 =?utf-8?B?OEdIOGM5VStFOEJmQUh4MlN1UDY3VlBrUU9PWlNFb3dsTW9Hbk5PcTB2QUVv?=
 =?utf-8?B?MWdZQlozTUpnQjZuNmt1bGFZTExXYjZCVnBOMDBsYlo3ZVNKUEVZaFNvYnJZ?=
 =?utf-8?B?ZjJadjhlakEzMEdVR1N5NnJwK3pub3BoczdSdWhPczRobkE5NDV6SnMvQW5o?=
 =?utf-8?B?VWhqM2xPVDUxRmlzMWN3YW8rcmd4UThBNEc5eSs3ZUNkakE0Y1Y3TUhrMzhH?=
 =?utf-8?B?N0R3YTVwQStpUjNJQytKbVR1eUpCVmtpTXR4SkgzOWJ0OVBkVTRmeVpDeUFo?=
 =?utf-8?B?K294RSttR2phYzJxTFdJYnlLVlY5cXA4Qlh2ck1xaUtqSzVjYXlmUTl3d1Ju?=
 =?utf-8?B?ek9lYzV0ZG80UnA5dU5tNUdUSzJwMlkrVHdCQXF3SlpKRnRPb2UwVHcyRXVV?=
 =?utf-8?B?d2czWWJ2eC9BNVVudmp3RDJsK3FpUU9wUFFpcUh1M0dobzdXSkVTYk0wSDB6?=
 =?utf-8?B?dDdUVDVQb3Bmb0k0OFZ2b2xXSzZvdzAzcWdCYVBLaHhqcndaU0ZmR1ZTejdF?=
 =?utf-8?B?REtWRDRRWmVmcUovQzk5RTJpK3JFcjBuMlZxbEZBZnRJQlBjRVRKQThVWUsr?=
 =?utf-8?B?YnVYbENFRmFYYzNRTTJYN3pldTRvbFp0WURYd3pEUGUxYlBkb1hVQ2ZQRSti?=
 =?utf-8?B?dEJqRll5Yk1MdmlVWHBYb3hROS9zdVlsNW45TlJmbURqTlYrdGk3VTZDeXNQ?=
 =?utf-8?B?Y05Bd2JUVEl0bWNSdW9jOWtiSkQvMlJMNjBpWXRpVk5aaDlYTVdTZUlqd3lR?=
 =?utf-8?B?eEpWZlpqZExrdUxrdnhYbzBoczE0R0xzckpCL2h6NHYvN0VSeW15ZEdrcGI3?=
 =?utf-8?B?ZEdhTWZmSStSVlRjY1l0R0YxKzd1dGQrQzRvZnp5Y01EU0tTNnNTU1FHYVdH?=
 =?utf-8?B?WUhKQjBic3lDM3lHZVBGbFRXMVJPQyszb2c4dTVTTDhlUHdmMzJPYVJnVWtC?=
 =?utf-8?B?aGE2RHp3U292bFFoZThHWFRFN21iZHRLTzhmZ2UweUo2WHZZZTNMWXQ4TC85?=
 =?utf-8?B?dEdrRGoxWi80MVVzRWRHT1Ntc0t3R2YzTzJvRXRkbGgycG5wS29UZ2RjNGxw?=
 =?utf-8?B?YW9WT25wNUZrdENCYkJDZDBRR3hNR3c2TzY2NmpJUCtOcUxtZjdhSURYNlZh?=
 =?utf-8?B?UWI4Q1VGcjd5aXN3ZjN0N1R5alI4dGRhb3Vudk5PUjl2MTRuVFdaWERMbXQ5?=
 =?utf-8?B?KzVHTXZUWlluY3NhYm93Y2VIUkxNdXJEcjBubkpCOExYNXNlc1ZPSDY5YVRH?=
 =?utf-8?B?bjhiNWJQLzdIUDgrTGpXRjhWMlRFVlg2Ni8yR2tTOWdiUHlCY3RaYzdEby84?=
 =?utf-8?B?dzBDNmNMQ0Q2Vmg2RWl6TnNPVWRGVHF1MDdOZlcvMXhqL1FlVWY0ZVVMZU5s?=
 =?utf-8?B?SCt2dSs1VVkxUytvN1dFbGJtUEJmMVNEajRGY0hGRHdBdmtyR1FVWTNwakFm?=
 =?utf-8?B?a1hKTkpMOTFwT2xQN2NrZ2F4eC9mOVJGTSs3MWxreVZVbEVVK3J4V1lwNHIx?=
 =?utf-8?B?aXlVODY1cEFTZFNvQWs4QmRjQ2l3cjh1SDJMSnFPeEVDY21oL2NUNTVSTG1p?=
 =?utf-8?B?QXJQR0pFbWpCMWVuNWRmMGRFWmF4bEhxazdhQmN5Vy9YajJFRHgvb24zbWgr?=
 =?utf-8?B?bjhkeWpJbmVOZDVTc3UzVUNDR1BtV1ExTTFTM1RVTGJ4SUw3WFphQUgwb1Iy?=
 =?utf-8?B?R3BDZlJJVzM0V3JPK25Mam5wZHVuSlRXaEQxaVo0NXV6SjErNTIrVU80MWg4?=
 =?utf-8?B?eUtaVXU2cWNNTGN1a3R2RDREZnc1UnpDUlpGOStURjlWbzdaWWo5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54954951-d7c0-43f7-99a5-08de7f2ed043
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:26:57.4101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVHn+KJ/PSe1TEYAV1V8SJa3HpYlOCBdRuYtE+9T1SHpUpBqQAU8XMGjlLpEHpbU40d6r+BrUWuknL284S4j9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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



On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
> 
> 
> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>
>>
>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>> Add NULL pointer checks for dev->type before accessing
>>> dev->type->name in ISP genpd add/remove functions to
>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>>> ISP driver dependencies are loaded in correct order.
>>>
>>> The regression was introduced in kernel v7.0 where MFD ISP
>>> device enumeration doesn't complete by the time it is added
>>> to gendp. The timing of ISP device enumeration has changed
>>> because of the changes in registering the device sources in
>>> the device hierarchy.
>>
>> It's a little bit pedantic; but I /think/ there are two different 
>> problems here with two different root causes that both happened in 
>> 7.0-rc.
>>
>> As a consequence I think you should have this split out as two 
>> separate patches in a series linked to a Fixes tag with the reason for 
>> each of them.
>>
> Hi Mario,
> 
> Few things to clarify before I split into 2 patches and submit v2.
> 
> - Yes, you are correct, the changes in this patch are not directly 
> related to the Fixes tag 02c057ddefef mentioned. But since it has the 
> dependency on the below patch for automatic modprobe of isp to work, I 
> have used the same tag to cover the dependency. My apologies if this 
> approach is incorrect and misleading.
> 
> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
> 
> - NULL dereferencing issue with dev->type observed on v7.0 is specific 
> to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As the wakeup 
> sources are registered using physical device instead of ACPI device, 
> wakeup source device (wakeup14) is added as the first child of AMDGPU 
> device; and since its dev->type is not initialized properly it has 
> resulted in segfault.

Sure this makes sense and is a no brainer to get in.  I would just send
this one right now and we can keep noodling on MODULE_SOFTDEP (more
comments below).

> 
> In 6.19-rc4 or earlier versions, this issue was not observed as the 
> wakeup source device was never part of AMDGPU children list.
> 
> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 in v2.
> 
> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic modprobe 
> of isp (and other amdgpu mfd child devices) to work in v7.0. But 
> couldn't identify the specific commit in v7.0 that is causing the issue. 
> I can confirm it is not because of commit 057edc58aa59 as the automatic 
> modprobe doesn't work even on reverting this commit. Can I submit this 
> as the fix needed for isp probe to work in v7.0 without the fixes tag?
> 

MODULE_SOFTDEP is generally for ordering, but I don't think you have an
issue with those modules loading before amdgpu do you?  I'm not really
following why the modaliases stopped working and I'm a bit worried that
it's papering over a more nuanced issue still.

To identify the root cause, it might be helpful to do a bisect, although
it's a bit complicated.
1) At any point that has that platform driver conversion you need to
either revert or add the change to auxillary
2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
need to apply the NULL pointer derf fix
3) At any point that has the changes in linux-media for API adjustments
in 7.0 you'll need to pick what version of ISP series to apply.


> Thanks,
> Pratap
> 
>>>
>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform 
>>> one")
>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_drv.c
>>> index 95d26f086d545..920595f0d22ca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>   MODULE_LICENSE("GPL and additional rights");
>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp 
>>> pinctrl- amdisp");
>>> \ No newline at end of file
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/isp_v4_1_1.c
>>> index b3590b33cab9e..485ecdec96184 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>>> *dev, void *data)
>>>       if (!pdev)
>>>           return -EINVAL;
>>> -    if (!dev->type->name) {
>>> +    if (!dev->type || !dev->type->name) {
>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>           goto exit;
>>>       }
>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device 
>>> *dev, void *data)
>>>       if (!pdev)
>>>           return -EINVAL;
>>> -    if (!dev->type->name) {
>>> +    if (!dev->type || !dev->type->name) {
>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>           goto exit;
>>>       }
>>
>>
> 

