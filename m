Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79BFC27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1E510E060;
	Wed,  5 Jun 2024 08:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wh99CkHB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BD210E060
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMwJ0UATv3pJfLWC6JizLHAGwEQEDikVWRTSZFmsE0oCaqiE2BOWtzU9jxIRqh3oYihSK0rZqN24X25YfvVC0OHe+EQKcMhM8jQbeLalNOXAVyV/NcEqGExkcU2pRbsKnHtnKklgDC+ecV16Up/4UZmlxCOpsOJ0Sqk+i5mS15l5kYXS2DR1itxyS0RWwJUFubNyGXvxVo0ajYzFKp1DknO+g7Czoi084Yx+Goey8HzA3r/HuqpmFD1q0y+olcyaIHmRe9RUBrm8lNc/z+5KdS+nOorALDzBs/OOYCoYQDrtrZqbRpoxQX1FHi9zivmrovW94c3JJMnTn72o4LO7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh11Thlbn4rQgAgkYEUkgfBDG4s8zhAo6IyvuiDLuas=;
 b=Wbq68PRiL7BBJstEg48ulik3Eep4JEDErSy104xU4RUE5IuAL22JyMjt4YlUqK7uCGuI2jHjXAoOM9dBDjMK0z40bk8cUsRudI/38UYIALSPKHp8XRydGnCYNc/GmKl2nzzFdtP/qvGekJrtiHEDCqHSv8BKG0/AV1ypDCzbqkO9nJn32sr2sapuc6yTyn2ahJ7AK7GaX1XwOZtbtTgc6aPjIuofvB/6RGSYWbiZyjS+WKmeq1Z90uUh1EDyH3N+JTr6mHfXJzV6AfcJM3TYk/HNyEx83PjngcwmRFSYhua4a2fJQ4xnQn8AbDor5sU3w9V5NjMA3jkHGVoOaSNylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh11Thlbn4rQgAgkYEUkgfBDG4s8zhAo6IyvuiDLuas=;
 b=Wh99CkHBTB995OV02GqfdkFMmea9+DwBuGHtL6deSohfh+aDQA82ih0pQPP98b2hA4MWlu6FqEhI5hO+fmEsc+pfcHNtpSkz0Tc9J//stdrXXR89j+LGADfIsR6jPZjvJ1iVoKYl0RmWUlZ8KPxNSVc1XGr0bREqbCPlfKuj+kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 08:26:59 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:26:58 +0000
Message-ID: <f495cd99-8483-40a3-92dc-37dcd1e99475@amd.com>
Date: Wed, 5 Jun 2024 13:56:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the BO release clear memory warning
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, tvrtko.ursulin@igalia.com
References: <20240506134842.4688-1-Arunpravin.PaneerSelvam@amd.com>
 <2eff77f1-d811-4a13-81ac-9c2ff18ebb75@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <2eff77f1-d811-4a13-81ac-9c2ff18ebb75@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 476529cc-5a38-4bd1-6141-08dc85394464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnMzeWhjUDc2ZVJUU2hUaENQYWN0b2l5bkdCSzB2Mzhpd1dGVUxzbXhiQTVu?=
 =?utf-8?B?TkEzY05GdXBrR1pRQVczMmVVaXArS08xVkd4Q0NlRnN0VEF6QWJkdmF4ZzAr?=
 =?utf-8?B?WjE0aS9ZdWxZSUY4T3BqVy84ZmZVamlSaHBMNXc3a0s1OGVZSHlSVkk5Qnpu?=
 =?utf-8?B?YTBoNzBFVCttYU1qZlVzUFRaZlB5TStRa3N2U3ZjamRWdk81WERqNzFYYVZI?=
 =?utf-8?B?L2dyQnQ5cG5CT0RxN292dlJoMG53RnBqQTdycGZLQWlKSkZ5eHVQd2dPQ09M?=
 =?utf-8?B?dUZ3VGlTeTl1N3VpMVRSZ29wcHFHTFhwUlUwODN2V0ZaTGxXd09ETVdvOHBC?=
 =?utf-8?B?bDZ3S0Z0cCtkZjdxbnBGSmFYWTFZNjJySkxUMTV5WDU4LzVaT2RYbEFlSC9r?=
 =?utf-8?B?Mk91Tm1vcyt3a05nVzJEc29oTmJjMGxuNWxBVnQ1NldFNTVJQjZ3SGlZYjFv?=
 =?utf-8?B?ekorTWhJcnQ3RXRlbUZBMnB0NSswREpyOTg4aGxzSlRlTWNUWmRDRVBYVUQv?=
 =?utf-8?B?TmNFcDBDVzUzYVFTM2xncWVJV3lmMVE5S2E1MkdEcUlIQldPZWN1dWpoUitX?=
 =?utf-8?B?ZmV6dGxxNW5nVDQyS2tNdEdjc3NMZVVFS1FCSkhuQkxVdUxkSUpvT3NGc3hL?=
 =?utf-8?B?YkNGdU9CS2pBdHlLZG1FR1h4MjVEVTJtdVBuZDErSUxPYjBRTU9Cb215ZHFC?=
 =?utf-8?B?VElKNHE4aUEwS2lyUDUxUkU4VXQ0TWFSNFU5V2M4Q3FXMnVGc09UZHNPTDIy?=
 =?utf-8?B?OGM5VWdTTHI5WEVLM3daUlIrNWp1aVRSUTh3aWZhaVdIdW4wenpkMWthMGdX?=
 =?utf-8?B?b0hLTit3WTlYQytLYStRaVdWWWM1MUIra1lVS1lUQVB6dG1pcVpDQUFzWXZ3?=
 =?utf-8?B?dHpHTHhWL0RMVDZoaWVOcWxGTFFGdTQ4VDZhd1VSazNwbjl5Tzd4MjBqMnB5?=
 =?utf-8?B?VDNWTEtuZmdqSXpkQ2RUZnp2eUxmdlhvOWhtWHFNdUN6bXNlQk1pVkxXY3M1?=
 =?utf-8?B?b2kxS3pNT3BIK0JOU3FjNnRzZSthNEJoUjhzWGpNQVZsY0JVK1RWS2ovY3NK?=
 =?utf-8?B?ZDdtb2xCc0syS21Bek5lOWxLUjZqOThrN2F4QzZkSjNxKzdBVytHMUpqVm02?=
 =?utf-8?B?dktvM2QwK0NFWUpRMkhrSFE5UENhUFN0MitScEp5SlU3REczMnNlVzViK3V2?=
 =?utf-8?B?RW5OVGFZU3RxOXhYbWIzZ2ZwV3dkVnJUbDRWbnlLTXJjb3ZoQ0dwVUkybWxN?=
 =?utf-8?B?Z1FFNEQ2MytMYkhzd0Vhd2dKcnk3bExYNGhGdVRwWnFUeEN3SGN4QWVyRm5p?=
 =?utf-8?B?emkyREs4Q2YxYVIwZHZRbmgybG1DZ1g2NFdNK0k2YWF0OWl5RlpDVmVoOWt6?=
 =?utf-8?B?UHpwOXd2UnRadzIvNENEUFdkR2g0SjVKRDhvZ0xhV0NZenhleTFpTjRJUHFm?=
 =?utf-8?B?azByZHZWZWNTV3ZMSVBGeFdPaFVrRUlQRE1HVnVJakVZZk1xVjgwYUptcUI0?=
 =?utf-8?B?dWttU2d3Z2crcmlVVlVlMlBjS2pBNk1xcUhrQy9rYUJpUkVGelhHRTN1SmEr?=
 =?utf-8?B?SHhxRjE3UVhBamFGcXpTODJnMnNtS2NIelVLZy9rUWdoWUZJU3pvcWIyendp?=
 =?utf-8?B?dnk2QVdXakhzNXNWbTVncGt1cGErb21MbHB3Zm56Z1VFVThoTCtzcWswaXZw?=
 =?utf-8?B?bFlkMkZCd3ZRQkFQRUFuU0MwdjhrY3FNeXp4U0NUMDlWb2w3MXk0NDlyNlY2?=
 =?utf-8?Q?w6R2vQqGUx3Ujp1FZKZPsCdMrXkOCXlQxEykyPv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVJdDUyaTZhMnFaQlovRkpVcHNRWnBJZmRuWFluL1lpVkxzRnM3NVBuUFJw?=
 =?utf-8?B?L1h1SUNCOUY5TzlVS09YMHBIWmdYdUM3dmtFNjVSMXUyWlQwUFpNUlcxbWlG?=
 =?utf-8?B?ZXpQSmtzL2FMcjlnUGZ1RERaWjJDaHRkaFZsQ0ZvcVFEUzBEZnpzNEYvdENO?=
 =?utf-8?B?dFlkekhGeTQ4MFB1TWY5bmZ5VWQ3bGxaMFFzRlpDTGwzaFRYV3pzZ3pCbzBP?=
 =?utf-8?B?YUErb2lvU1RrTzB4dnJhZ2pOOE10V0hSbGI4dk93SStoR3cyTko2cVdSN1ZK?=
 =?utf-8?B?ZFFYbFVqcWdLbmZYUUtoMzZuQW9hc2xPNVFEck5Pd1Zobm4xM2RZQ2J2Q0pt?=
 =?utf-8?B?RXdLQW9nSWdBaW9ueEJoVm9rR285ZDAvckQyTDBESEM0UGxwRmxXeCtWL1BY?=
 =?utf-8?B?MHJxcFE4M3REVW1UZE10WmZRRFE1TEVCWktIQ3hTWjBhN1BnSlZXNXZ2VVk0?=
 =?utf-8?B?MUltKzB2cmZjWUdlUzhVL25qUlJBdkxJVUV5dVlnRTZxdE41UU5Xb05vOHZJ?=
 =?utf-8?B?YTJ3MjIrTG1NU3lBbmFNOUYyRFQ1bDI2WTlFTVJ0WE5uUlNLRitTRWZHYWty?=
 =?utf-8?B?QXFyelpqS09hZ0hXTjFGSmlqQyt1c21GWndZSUl6c1RaREVaYVFxT3EzcVZQ?=
 =?utf-8?B?QVpFZWIvZHFEdTlDL1A4cXFENFpIanVWaDlnUklTM0kzc3ovTDdueUlCUmVW?=
 =?utf-8?B?ajdhM0tuWGRXN0VDODhpUFJ0akJGVXJoWkpxQ0p6clVCLzZvN2NKUCt0VzRj?=
 =?utf-8?B?S2JRRkxmeWd1VmFKZENkNEkwbnUwVVM4N0F1c0haSGdIL3F0K2xFcVc0WFVZ?=
 =?utf-8?B?K0EwUk9JMEQwVDRvM2FZbDV4ZGxNL29mQS9rRWZ6b2FqWnpBMUNSUWdwbW53?=
 =?utf-8?B?L2xoTGZRbDRLSkdhNjBLa2YwUXd0Yy9PYVp6WHQ2SjJOT0FQd0daMXlEVmFI?=
 =?utf-8?B?Ky9QTEpWOFBHbGhOV3NpTDNJcnVyOUtUVEpnVHAvaHhIeDhpRHM1T0FvNTNN?=
 =?utf-8?B?MzFRZHJBeW1MM3RobjVMUkxlZ1dLWmpkb1hzMmtNc1pWTElsWm5WYXRKQlEz?=
 =?utf-8?B?MFFHK0ova3BDbFE4bmFqZlhiVEh3SzBpaFc3N2xRdmFZTnFob3F4alBRT0ZU?=
 =?utf-8?B?VzNqMFVCc1UvUHEyS0kzQWxwQVIyc0pHbzc5ZkZhUE1vNFhQSiszSVlnc2NI?=
 =?utf-8?B?UENMbG9oVW5VY1MrSmp4QVJDMDBpNTRBSmVHMEhhR2hTcE5OY2lNUElkblhH?=
 =?utf-8?B?TjZycDI5dTZodDlOMHJVNXpaZURva3Y1R05Db2xjZ2t1SnoxSm92YWRacGJ3?=
 =?utf-8?B?NDh2ZE5qZVZNYkRTN3VMdmczV2NqaHQ4bURKdU5VWTFqaHNVSGt5ZGZNWmVV?=
 =?utf-8?B?MlB4cWl4TTd5SUpMSHpGNGxFSE5CTEZQa1N6VWZ0OXBXN2tidkhDR1hRVlNv?=
 =?utf-8?B?RTBhTUlRVHEyNXhHZkFJUGMxVDd6VjcyVWRkWFZ3dUFRWlE0WmdsMDM1UnB6?=
 =?utf-8?B?eHl1U01YRVJOOTFrc0hKY1IxeDVXUVFTVXh6amEzWWpSTzBML2dVR2JYMFps?=
 =?utf-8?B?cUtDR1FNaFRlUXcwOXhNcFovS0hxNDRwajBKTEZWaEtxeUpvK0VZTmkrQkJF?=
 =?utf-8?B?VnVhR3hPbFZ6ZWVMeXFmdm9IZG9vU294RjZHcXZUaUsxZ0MyOHI2UzZRRTN5?=
 =?utf-8?B?NFNrSVZRM09JUndaLzJPSlFoRit5UzlEOVhCa1daU2IyTzY3VEJmZFhzZGhB?=
 =?utf-8?B?Y2dva3JnSUVuelVrVTZhakExU0dRVW43R2lFZ2NRU3Jaa0dHL1U3S002TEFl?=
 =?utf-8?B?L216Uk5LVGpPRmtYUlF4ZGRhUzd1TEx6eFo4QTVZMGtDY2xhWm5aeGxBNU83?=
 =?utf-8?B?MzVycXltQkFvUmgrUUo5RlN2U245ZDU2Ykw4NFBrYXZybEdCTUFKRkpMSlgv?=
 =?utf-8?B?WnFFL2k1bC9WZjVmbk1Vd01PUk1JYmpYQmdlK3hoNUo2U2l6R210Z3FaUk0v?=
 =?utf-8?B?UUFHSGhjaWp6cmluTHBxM1JKVXU2Y3duWnlvSHdVS2MydUFUN2RodTQ3N21n?=
 =?utf-8?B?bFpGZS9QK3NUaUROUHFZb2YzOGczMHFFbDRNM0Frb2hSUUovMkZYa1VGa0xZ?=
 =?utf-8?Q?pEvUJBdkxyf7jN8SVI6A27IZS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476529cc-5a38-4bd1-6141-08dc85394464
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:26:58.8026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shx6+W8lNvKgSGqg8xe/ttS+8yymbSgtS5XxqmDiUkGLrzwCss2ZDWGn/piucv4iI3A7ULMB4qoyhJ/P5mKc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

Hi Christian,

On 5/7/2024 8:21 PM, Christian König wrote:
> Am 06.05.24 um 15:48 schrieb Arunpravin Paneer Selvam:
>> This happens when the amdgpu_bo_release_notify running
>> before amdgpu_ttm_set_buffer_funcs_status set the buffer
>> funcs to enabled.
>>
>> check the buffer funcs enablement before calling the fill
>> buffer memory.
>>
>> Log snip:
>> [    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to 
>> clear memory with ring turned off.
>> [    6.036667] ------------[ cut here ]------------
>> [    6.036668] WARNING: CPU: 3 PID: 370 at 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 
>> amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp 
>> drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper 
>> drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm 
>> nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi 
>> xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm 
>> crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy 
>> crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common 
>> usb_common video wmi gpio_amdpt gpio_generic button
>> [    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 
>> 6.8.7-dirty #1
>> [    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 
>> 2.10 03/26/2024
>> [    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 
>> 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 
>> fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d 
>> ad d8 66
>> [    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
>> [    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: 
>> ffff90dabde38c28
>> [    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 
>> 0000000000000001
>> [    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: 
>> ffffbbe140d1f3c0
>> [    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: 
>> ffff90cba9e4e800
>> [    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 
>> 0000000000000258
>> [    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) 
>> knlGS:0000000000000000
>> [    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 
>> 0000000000750ef0
>> [    6.036901] PKRU: 55555554
>> [    6.036901] Call Trace:
>> [    6.036903]  <TASK>
>> [    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036998]  ? __warn+0x81/0x130
>> [    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.037095]  ? report_bug+0x171/0x1a0
>> [    6.037099]  ? handle_bug+0x3c/0x80
>> [    6.037101]  ? exc_invalid_op+0x17/0x70
>> [    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
>> [    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
>> [    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
>> [    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
>> [    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
>> [    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
>> [    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
>> [    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
>> [    6.037826]  dc_create+0x28a/0x650 [amdgpu]
>> [    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
>> [    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038087]  ? prb_read_valid+0x1b/0x30
>> [    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038090]  ? console_unlock+0x78/0x120
>> [    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038094]  ? vprintk_emit+0x175/0x2c0
>> [    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038098]  ? dev_printk_emit+0xa5/0xd0
>> [    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
>> [    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
>> [    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
>> [    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
>> [    6.038505]  local_pci_probe+0x42/0xa0
>> [    6.038508]  pci_device_probe+0xc7/0x240
>> [    6.038510]  really_probe+0x19b/0x3e0
>> [    6.038513]  ? __pfx___driver_attach+0x10/0x10
>> [    6.038514]  __driver_probe_device+0x78/0x160
>> [    6.038516]  driver_probe_device+0x1f/0x90
>> [    6.038517]  __driver_attach+0xd2/0x1c0
>> [    6.038519]  bus_for_each_dev+0x85/0xd0
>> [    6.038521]  bus_add_driver+0x116/0x220
>> [    6.038523]  driver_register+0x59/0x100
>> [    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
>> [    6.038618]  do_one_initcall+0x58/0x320
>> [    6.038621]  do_init_module+0x60/0x230
>> [    6.038624]  init_module_from_file+0x89/0xe0
>> [    6.038628]  idempotent_init_module+0x120/0x2b0
>> [    6.038630]  __x64_sys_finit_module+0x5e/0xb0
>> [    6.038632]  do_syscall_64+0x84/0x1a0
>> [    6.038634]  ? do_syscall_64+0x90/0x1a0
>> [    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038637]  ? do_syscall_64+0x90/0x1a0
>> [    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038639]  ? do_syscall_64+0x90/0x1a0
>> [    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
>> [    6.038645] RIP: 0033:0x7f2bd1e9d059
>> [    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 
>> 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
>> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 
>> 89 01 48
>> [    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000139
>> [    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 
>> 00007f2bd1e9d059
>> [    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 
>> 0000000000000024
>> [    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 
>> 000055a9b23000a0
>> [    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 
>> 00007f2bd1fd0509
>> [    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 
>> 0000000000000000
>> [    6.038655]  </TASK>
>> [    6.038656] ---[ end trace 0000000000000000 ]---
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Mhm I'm not sure if that is a good idea.
>
> We should probably not always set the flag to clear the BO instead. 
> And warn here when clearing the BO is not an option.
we are clearing the memory always in BO release by default without any 
flag set. Should we use the AMDGPU_GEM_CREATE_VRAM_CLEARED
flag to mandatory the BO clear.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index b2a83c802bbd..ecd0cf6cdd2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1371,6 +1371,9 @@ void amdgpu_bo_release_notify(struct 
>> ttm_buffer_object *bo)
>>           adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>>           return;
>>   +    if (!adev->mman.buffer_funcs_enabled)
>> +        return;
>> +
>>       if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
>>           return;
>

