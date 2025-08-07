Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EBDC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 11:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F8310E0EF;
	Thu,  7 Aug 2025 11:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uaQ3JLfS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB0710E0EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 11:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uajtW50DtDQWBfMAiSPq8evRK2YLCj3efoJJgi+ONg3EUt7pjMSdh9g2QQyDr517kgzkEfBNpDWY5353whozl794XasMmSY8+OJc+ktwGgUBC2zlQ+rph6o2Wtpv+QMN5EEo5IL3MtbvPD/Shno1Ruia9NBmclO9EbKrcVfOE05T1KNBSYeTyp6WoZ4VrwEuu3O68X8s4xF6dkYSYewFSS4NrjEqYeNbGFfXlpmiSkBvVlCKsQ/KBa6e6FFaLcvaQ/4AEm/2EfZTK4ry79TlduRHPi9oipDfOyK9gsC0sLbHFONANeuleazmb8F/jUB4Agw3BdAcvoL+tRIrV0wU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAG30l5pj+BYq5ylJgvVfU2A9iCE3jDc5ciDwO54RIo=;
 b=DgwXGRke2saERkG7lTuvjEw9XEQzQOJJt6uYRGcW9U8tC5zYYIqMKmtID31/Y9ZLxpSZ+8uM8WQ38pMvXAQNBAXnhh5E7FGRn9TD5uEVSX+uC3o1UF0EFIrFxrfuENGSIqqnGjjB8oZrQS35AlsX7JuPJpClr6BH4S1oOSJ+1O+D7TtnYrn1Yvrjn8dqr5jG+ApCkyeROzEvDACkXrCqQI+b0K+qRgfGpL34H5KbjijAxJ5853hdEjsZohtU3dVFGlvG//sKj2AZV2/LpfB3wOvmm9zQnfK2d0MFcIhaS1RIDaQnoVpFtQsZM8g4Bb9y+IPEpkTyUB8imTRjWq0h8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAG30l5pj+BYq5ylJgvVfU2A9iCE3jDc5ciDwO54RIo=;
 b=uaQ3JLfSHaZCWlh2KI1p3ar1RGba85Xn5Ilqk2+DBkRi8celMqiGFl4XdJJeehQV8THz/NQh3sVeKR+DowWVOePw2ki8rPdoEuVt1quFekEs+aAfUpWnYi0NK8lXobSY6Hwvytvpco8y7ZEXR4f9MxHbpMvjWecpK9qBXidUVD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 11:18:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 11:18:15 +0000
Message-ID: <ddd67e1a-3b8e-4ed7-9001-862af3b0e2cb@amd.com>
Date: Thu, 7 Aug 2025 13:18:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Is amdgpu open to converting logging to drm_* functions
To: Brahmajit Das <listout@listout.xyz>, alexander.deucher@amd.com,
 sean@poorly.run
Cc: amd-gfx@lists.freedesktop.org
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: dd87d01a-0343-4bbd-717a-08ddd5a41a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVlZeDg3ZTBvMnM0eC8zVWRIL1g4OWx2RGNEeVdaT2FuMjNYZWxqRFUrS3k3?=
 =?utf-8?B?eVgzT0ZibE5GZW5wSEloSDVFZGw3b3RnZUQ1aWdWd1V5akVKY2kwL0hNRThh?=
 =?utf-8?B?dHduazI5S0VYdk9UNWlKOFZUSlFMb2Q3N3VEZ2NteDFZNGRuZVo0UW04VGxU?=
 =?utf-8?B?WEFReDhRRzBpc3I1YzhzTG4wSW1rZnFJand0Y0Rlc1RsVUVXYlEwdkZEMkFt?=
 =?utf-8?B?VHg0MFZ3dXovZE5UN0RLYzdQOTF0cERrTkpmdnBaanluUTZQMnNJaEdOTmpB?=
 =?utf-8?B?SmhhMExoYmpNUzk4WXJzaUEwRkkrTzBVVG1xVXQ1UUNzRk43K3lONmNkc2h2?=
 =?utf-8?B?Y05rUDd2NlJuNUw2d2VHN2ljaUlEaVBWbFA5VlBDeDdIOC9Eb0t3YW9iV091?=
 =?utf-8?B?am9TdXhUNEVqOE9laWtjK2Q5YjFvUVV3bTZtcFhvRVYxczBpMXQrV01CeEI5?=
 =?utf-8?B?Z1RVYWRVa0w5SzhUZ0lxd01CaFBPVlVmQlhhaEF6MWw3bkE3b2ExRUlZeFh2?=
 =?utf-8?B?SmRjbnFob09ycGVtY3E2Tmloak1EdXBWM0U4YlJ1dTQ0YWp4VnJOb3h3ZTZ6?=
 =?utf-8?B?K1YwT3g0NmFZRzlLTnNuQzRjSEwrRXY2MXN2TUU1bWNSODQraytoTlh6ME96?=
 =?utf-8?B?aHpUYnNFWWhSRW9jRmZUM251a3dPNHdYZGpueWFJeENOY3B4NFZqTkxjSHM1?=
 =?utf-8?B?bHhYTTNNOG1QK2gwVzQzalZQaUovNk5jOEJLS2piL1JNMjdsc0taSWI0WU55?=
 =?utf-8?B?MmVtbDVGS1RscVpsSFVwQVZSYWtjSVd3TFN4djBLenNwcWROb2J0K3Y0Qldi?=
 =?utf-8?B?UkJJQkZRN2ZKejc1RW52Q1FCUjlVM2Y0cHZiS3Q4cHN1S1BmMGJVbDZLWEZ4?=
 =?utf-8?B?cU1PRXFkN3VuM0tVbzMwc2dqaFFzUHgvYlJtZGtFclhoRi8rY2lmNzFtN2Er?=
 =?utf-8?B?UjNFdklQU1U0SEFldE12TlE0Q0g4VkFlN3JQM0pBbm10dXB1WjhnMjJhVGZu?=
 =?utf-8?B?RmNmUytLYkthczYyQjJGeUZDRURXaUsvZEp6UXE5TVlJK1dQbUl6T1IwVDN4?=
 =?utf-8?B?a21CTU01VHlXVmpwV0V6MjZoeWZZekFpSER3YXZrSkUxZU0zVnpCS01YQWNF?=
 =?utf-8?B?QzFEcUJEVnRnMHA2SHQvUUw5ZkMvUEl4WlhDQmVHTmlGUnlSNUM4ZmNlT3Q2?=
 =?utf-8?B?Sko1K3JDc3VFbDEzNkl2OVNaMTIveElDSHE1T3JIVkxTSTJ0NVNaeWFVVWFi?=
 =?utf-8?B?L2dTQ1NJVFdtVFJEOVJXNm1BbkRhTUNIQWs0T05DR2VlenEvMjE3U3puUXZU?=
 =?utf-8?B?b1ArMGZ6Z1A5Ujd4aVcyeDhjL2FraDA1Wi9tdXduSDlQOEZER3VUYzMxZzlG?=
 =?utf-8?B?SmJXeUdmN1JveDNsNE53UE84emRXUkJyZ1Z0czJ5M21OakJQWlFoTkp4cE4r?=
 =?utf-8?B?Z0VaVGFTcmtOUkJvMEtxNE8xOEJMdmw0WVBkRksrSGlPdGwzREtFYy9iK0Rx?=
 =?utf-8?B?VUF4dDF6OVR1UEFtazFLODU1eGkrRXlVSnU1UmxnVU9VMld1czhwSlE0bHhC?=
 =?utf-8?B?RzFMRVZEN3F2c0t3WjkvK09vdnI3eTFyUW43clRVWVYyRUl4MVhJT3VjVnU3?=
 =?utf-8?B?cFVQbys0ZndWYjljaWp1Nk5HQ2RkMXI4RnU5b3J4bzNPRElGcjducHRmbVJI?=
 =?utf-8?B?eU1zY1F2azR0U084cnBZM2pFSU9LeTYyUzdLdVVoRnFLdENSbEVhNlMwMWRQ?=
 =?utf-8?B?MlZid2gwOWkyNlRGcVc2ZndUZGtDR1RkdVVxUDU0V2d6aDVMZXRCYlkrREdt?=
 =?utf-8?Q?idPfU99FaedLLRqEmYkX5z8uL3O08s8K6Htos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9tSDRtS0RXYStpU0s5dVR6TnBTdERXY1NUbmxoaXN6REI4T015cWl3Rm9K?=
 =?utf-8?B?WHlnV2JlbHVxdTBFNStZRSt4ZGs3aGJzeEU1VXE3YUF5RnlNZkJtb3pmeHRl?=
 =?utf-8?B?QTlFaDFBVW12dUpRU3FiTVZYSG1oSGxSdU4wcERyUWxRR3J6WmpobzhwTkN2?=
 =?utf-8?B?L0FBcFJxSGlvUVRzZi96UUU1TmhYNWxudlY5dEJIaEdBOFYvRnFwb1FCdjNj?=
 =?utf-8?B?OUY2dnF5Y2pIYmQ5NERmVzhWOW1FQlNZRXRURm1GZWpMaVF0WFY2MkV2KzBx?=
 =?utf-8?B?cXRMbU5BcWUzQWc0cDh4MXlBYVJZcndsdnJaY2oxTElSVFNpM0hvZDFvdU1a?=
 =?utf-8?B?T0QrY0psUWVxVkdub2tMb2xOdzZqa0RuWGtkbVFzdnNQWUFUSGxjVGNoQWdq?=
 =?utf-8?B?UHJhUjVuK2czRzUyVVB3am96a1pyMnd0YVM5aHJtTGFvZ3lxandGbzNUV3lG?=
 =?utf-8?B?TkxUR1FBUWhUMStZYWdSTEtwUHVIajMxblNCcUVaU2NHbEIrdkVLWklMblU4?=
 =?utf-8?B?Y1lFTXY4aVh6cU8vWWhrQkVwQ2IrbFdrT2VvbTE1R0dXVVdKam9GYTd4TGg1?=
 =?utf-8?B?ZWQxZVNjRElnWGdkbHhpcVRmTHZNK2t3Q08ybHBKek9IQVBFck83enAyYXhX?=
 =?utf-8?B?VXNpS2N3SkNUbFE0ZjhqbTZVYVdXeWQxSktqOXF6aVBPNEdrbDFIc3NXU014?=
 =?utf-8?B?blhaYit6dy9NQWdVSDVQcDZZamROeXB4RVpGY043eFBZd0k1OVZ0MHhWRFJJ?=
 =?utf-8?B?L1VnbkovcjloWEVFSENwVXpxUnpMZUJZclJyN0ZGdGRVQzlRcVp3OFluaWo4?=
 =?utf-8?B?VHVneW5nOE11YkZkUEptTGtheU5kajI3UmNSeEc0NStEamcxM2xrdWdOMlh4?=
 =?utf-8?B?YjIxbDJtUHFOTXc3NStaTUtxSVU1TTVjT2hoT3g2V1VKNEROV3dkai9NQjBC?=
 =?utf-8?B?VGd6aVFtY2Y4L01IcWxnVVFTRGF4RXlaRUNVcjFPSVZsS2srK1ptNUovait1?=
 =?utf-8?B?dHhEblh2VWxNa08zSGRwQkJwTGc4NDFFcHdOUmFsekwwdHdhRThLd1dCYWRM?=
 =?utf-8?B?ZEtGTk9GcEo2bjhPTnpZNXVhdmxkV0VSTjRMMWIwam5tdW5SUHQyM0dMa1hU?=
 =?utf-8?B?UkhpNG1HcXBrQ1h5eXQrMWpYRy9ERzMwTE9ON0JaMEgvd1lCSVh2MVMvUTBx?=
 =?utf-8?B?c00va3lZejh3Y1NOR012Y0poVnQ0cTV1L2JubTJlZDV2Y0lQa2d0ZkhwdW5L?=
 =?utf-8?B?QTBFbnZCSDJjUU9VTFY4dGNGeUZlSzlRSkYrOHJTblFxNVpuTHN3bTVXeDI4?=
 =?utf-8?B?TkRpemlkNEMxVlhLTDhTbnk5VWVXczN3U1M2TFdJcFEwaHlVUlVwaHg4R2pF?=
 =?utf-8?B?N1R6NU5QUVBvdW9CMFZjN0FlcHJEUGE2Wld3MnAzY0NSRUJxRzNqRm1OU251?=
 =?utf-8?B?VDdGMHZ1VlN6UmNiRXpEb05RV1M4YkU3RGNieEhvR0lnYjMvZGZBNmtpMGgz?=
 =?utf-8?B?VlpTOGNxeTlSVXAyNUVjc1lIYm01UkJhZXpIeUhFOWYwQXBmOFJrTnU2aldy?=
 =?utf-8?B?c3ZqWlVaL3F3ZW1rUEZ1Z0FXQUs4RUxycXFycGhuc1krSGZ6bVYrQUNnQzRE?=
 =?utf-8?B?WURpWVBoazBTQzQ4YWgxTEdkcTExMVJUbTN1c0NSV2wrTEJlQ1NqRTNxQWtu?=
 =?utf-8?B?YW9oa3NlRDBWMW1UNlNFbVlXWlpTT0hEYTNzQW1LZkFRQjY5Uk9pTDF2ekN1?=
 =?utf-8?B?Q0RpYVBvMmQ0NjJZaHc2TUNqV3ZDcjJYUXdlT1lDelVBNHhWcXN2UVB0REJy?=
 =?utf-8?B?VlVXZGlCcGs5NWNEWVBsVXlCbEtySDBBc1U5bzgrSW9vVUVLNVJSR1hMQ2I2?=
 =?utf-8?B?NWJzR3JEQnBDeGk0REJGblEydUhqNzEwZU1jMGpQOGFseThmNUZnRm1oS1lG?=
 =?utf-8?B?RkpkR0hlZEZpcXRwNkhNN0pCNnFrbWUvNjBWNXpqWnJsTU9OZTA4ZjZ3OVA2?=
 =?utf-8?B?YmhOOENqejRaeEtRcDR6NFZ5VlBicmJmOTRscVVvSHdYTk84MWc2NTErV3l1?=
 =?utf-8?B?QldGUjhackZqUGFJWk1qR05rdjF3dVRsUWtxWG5pWWRwdWZJV1llQW1TTTN1?=
 =?utf-8?Q?0cWPuu3iWpvQaFe28OW8emk4E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd87d01a-0343-4bbd-717a-08ddd5a41a6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 11:18:15.3829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SqT6GbNfmQt9QXQiKDHj7kBjtrLMibrOy03j/uT7oZazsJKqqjUEf1YtIxiG4Uu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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

IIRC we settled on printing everything DRM related (e.g. display, device lifetime, clients etc...) with the DRM macros.

But everything related to general HW information like PCI slot configuration, BARs, speed etc... is printed with the general kernel functions, e.g. dev_err() dev_warn()....

Background is that a lot of messages are printed by the PCI subsystem while resizing BARs for example and it just doesn't make sense to enable/disable the amdgpu prints based on DRM log level around that.

So as far as I can see there isn't much left TODO on that side.

Regards,
Christian.

On 07.08.25 12:20, Brahmajit Das wrote:
> Hello Alex, Christian,
> 
> I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> TODO list on the kernel doc, and specifically this section[0]. Would
> amdgpu be open to this conversion. I saw that before starting it is
> recommended to talk with Sean and the relevant maintainer. Hence I'm
> emailing you folks.
> 
> I guess you can also refer to this,
> https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-daniel.vetter@ffwll.ch
> 
> [0]:
> https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
> 

