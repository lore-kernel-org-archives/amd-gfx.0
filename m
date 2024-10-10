Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12429CF07DA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 09:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B235D10E2BF;
	Thu, 10 Oct 2024 09:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJRlhtzA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC46E10E2BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 09:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX6AIiJ/VaG4JKWLReEJ7L6Axxd1AxBYDld0nd/LFDsh8zocM8iCOogaYCtXPz5YrZf1Ebagr0khv3N3MbMja8jLExy6HP7u7v0ajBJQxrSZ3Z6UbpNYRfJ2F5a/qlb+EVFG1uODaVIhYNjFpxEm321/NWV0qxmE1lAJUyrl8annsJifeY1Lp3BDHPJdN7jrjgx0iF7MqCAuYobd+08rNl+oC1qGMWjQBX+KW7leVtcRMCNj0qhSzPZgbr8lPA3RRucgeTZqQnL5hxhTdTMA1lUhN3ghD7VDhjnuWwGRc5Eaxlgu4zvngCuIVNs+rzqjHVOQBkRCX64d4ytF3kEwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXNJ0PiDBhVOobNarpZNA2JDaGYaXVsNz9aKRWVWLEU=;
 b=BAmfI583A98rMAQSaXR4H8VMCOco3sSkbPPnL4osC7MwPCmInrFR9qfIHz3Wh0sFVbss+0RS9ea+VDc4tGBkEIEd3jmYkw7ETlYa0vxVtu5M3mLTtNGYziF26lqiFF2slJ4izJFaUTkTyMC8SupucxII9Lg/dAic98J+6LePMtsHegd7EQfftlVMswAs9uV93jCSJXNHUjxOY/WE0FrKX++nmorJTKsLxc6elj/dl0sGRosLWJR8E5B63yXnq8dpmT2vpsJK2HiyMQT1a7inmlfWr1reeQRkhNDgfFyIUqKnEQFSiWwIGO75xyJz3m+kqymnnMZ3q7PL/bldomb3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXNJ0PiDBhVOobNarpZNA2JDaGYaXVsNz9aKRWVWLEU=;
 b=UJRlhtzAn3zbfiLGfZcduW3m+81HPkzszKPtLo2hhrFDDqBxPSBGkHI8GH0j6/1l9TXREoKhbVTnSgNA5UvTOKsu5uMsRCtWU9WOiki7clHc5ncBIt5pOu+9PqvOscl98p2XtGn6HnAq/pjZVyZHRz9IYSIdI/M/vrVd7w05w2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 09:04:22 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 09:04:22 +0000
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
 <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
 <85fe3fd1-53e3-2c00-d27c-96ed595634b3@amd.com>
 <b774ebf7-f191-43dc-ae35-7cfbee126e1b@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <63e9aa2e-e584-5927-b1b5-19b47da8ebca@amd.com>
Date: Thu, 10 Oct 2024 14:34:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <b774ebf7-f191-43dc-ae35-7cfbee126e1b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: f16b9445-481d-42f7-f50a-08dce90a885f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTVvZklaMU45VHgrZ0l5Z1pWYkhPTmM3MUN5OStCZGJsSjc3VVZGbDFtNEpi?=
 =?utf-8?B?OHJIZTNpVUx3SVU2VTB4ZTJjZit6Z2hkRE5ZeDBIa0tsR1gvNnlVNndkZjdh?=
 =?utf-8?B?L1pDa1MvZGdlR1FLdEJUMkJuR3g5MHBud0tLbXZtUzE4SkoxVDZWN0dHMlJX?=
 =?utf-8?B?bzVzQXg2R2c2SUVnaHVyM1BKcWZkK3FqNHljV3I1UkdWTWY2aVFXM2tyelZZ?=
 =?utf-8?B?aXVyN2pVb0hVcUlSZG43a2V3NkNMSXY0dzNkK1hkTk9meTZoL1NicE1VZmdk?=
 =?utf-8?B?MzJMbUV5ZERZL1VIdG53a1RFUHZMcUdqSDgxSmhOL3RuekY5YzM5OXQ4Z3Ru?=
 =?utf-8?B?TXNxS1huSkk4RXJjRWZKQ0hzRktwNFN3cDVsamIralFodW41aWthWWdkeEUy?=
 =?utf-8?B?ZmtjOVRuQUR4MFZacnZ4N0R3L2ZrT1FsQUdyVW15cnNCVmd5Y0V1N3pMM2xZ?=
 =?utf-8?B?RGlvQzA0MEhPMHRKaVY4WDN3YlphWlpzWEwyZnhpNW02NmJ5SG5HR2xxc0Zj?=
 =?utf-8?B?TGRTeHlkTFhVdW1ia1JTL3BoSWVhT0JVVFY4MzBaeVNnQmU0YUJYUENnRm5m?=
 =?utf-8?B?NllzQkxtMU9LVW5NblVhUmkrZUxQWlRCcGZpL1NTcFhyRCtiWWNYUUgyYzd4?=
 =?utf-8?B?Z2hHSG1jUWhweHZSRGkwbncyOU8zTVhVSGNNNTVyNUxHblJJTFdFQng0Nkw4?=
 =?utf-8?B?VnRNcmRwK2IxL3hyZ2pWTktad2dUODNqLzc1c1RRdzVKMkJzUzl5aUd0NFlw?=
 =?utf-8?B?TWNPbFd3eFYyZTZvdnM5WnprZGFBcUJGZzdNNHF3Y05pc2hMS0g0bVV6OExI?=
 =?utf-8?B?RjlPTW5yWGtOa2JNTVFrTndraEFCNjFNc0g1Qk5BSmZnZ0FEZnozaFB2QzdH?=
 =?utf-8?B?NmViY2gvYUdHTHU3NVlVTmhDQXNUTHFIUElkOXN4QnZCVFltNDZnbXk2K2Iv?=
 =?utf-8?B?dzhUWjFhQmRCdk5XeGFSNU5BRmlhY1Vmcm1hVTZNQ205NFFEanZVTC9Temsy?=
 =?utf-8?B?WGk4bFd5Q3JQc1p0bW0xaDJUYXlVVUJIcnNLOG1ZRzkyNjlmR2twM2ZlcmdQ?=
 =?utf-8?B?S2RtU1dxUnFCNkVoUFNjK1RHeTlEUWRDZHBnbVNta21MZEs5RndnaS96QzRQ?=
 =?utf-8?B?YmtuM0doVkE2QVJMZ08rTzRiRnFiQTZpY2VWVUcrUGcvaDJ1NGdTeDl3UUFB?=
 =?utf-8?B?cS8zUjRLeEFNTDR6eWM3dnV1aTJOb1FzL1p3SHFLU3JnWllvaG1lVnlDMkVF?=
 =?utf-8?B?Sll4WVVkWFo1MGt0dDMrdkFRWHlNdmJRUkRldXRNQlVOOG5CMi91RHhocnU4?=
 =?utf-8?B?M2g3clB3aENDVllibS9INW9iM2JpNTZYbGNKeEt3KzdtZFVtNkM2RFdxVW5R?=
 =?utf-8?B?UWFCOTRJcEN3cmxoaVcrTGFRZGljakRjUmpaeHVPZ0NzN3lEMy9KWGM3WGw4?=
 =?utf-8?B?S01Kck1YcFNhZ1BYVmJIWnVCZTVXclBHb1NNZzV0L0x3WHFjUkZBc1JiZUV5?=
 =?utf-8?B?Y2dqS3Z6dEV2MTl5a0hHZUd4NkxvQkNNVWl6UUxDaSs0SEczbTZPbHJXSFlr?=
 =?utf-8?B?ZW8vR0hCRTI2NlpCRjNWRXI1V3NoSFl0M0VzMVVGbnYrNlk3ZXZ3T2xPUVY5?=
 =?utf-8?B?NzJHdExWamZ5cmp3cW0zdDlrSnZtMWJ1dWJxZ2RSakN3d0QvOGs1M09TYVhx?=
 =?utf-8?B?OURBN0JIbmdUUEswSGdZbkNHWWdTNE9FbWZvbjFQeEx3OFFqY3MvdW9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhWV0VVZjNWa21mRTYwUnlGWFVwaGg2amtwN0JCdE9HcVJQVDh2MTd0Rmhp?=
 =?utf-8?B?OHB0dW1qTW1mL25Ub3BGNXFEWVF4YnBmeGJWSERiVnJKMkNlTUxGcWhvU1Vh?=
 =?utf-8?B?b3ZRdkgrRCtkYlJBbXRRN3ppYUhKdFBnRmsySjErd2p2UmRjWnVxY016MjRV?=
 =?utf-8?B?dUxZVCtQanVzNmpEY1lkbU5JMC9GRlVwNWRxVXJSc3E3OVlackVxQ3Vxa01X?=
 =?utf-8?B?emQ3a08yTW0vWkNHK1R6ZDd1TTFkeG5MWENhMk1LS3VJWjRxd1VQR21PVXUv?=
 =?utf-8?B?RHE0eFM4QVBuSTlMcFpDNVkyTWMwcDFMKzJ3cWxybzd1VVI1eWk1YzVxZmls?=
 =?utf-8?B?U1lJVDBoN2xUSWxIbzZ5ZVVqUm4wZ3VYYjRZcVlTNHh3UC9rRGQ1RUtaZi8z?=
 =?utf-8?B?dE1NOUxKQ1ROUFovSWdlS3NqVGp1YzdpSFBmWW02OWVPdjEyYURKeU0wVCtZ?=
 =?utf-8?B?ajR2MXBZNnhVR0gycFdnS0E1REZhNk56emZHSnl3YlZIM3ozMFdzaHlIMThu?=
 =?utf-8?B?Mmg2Ynp0ZGhaanpoYU42eFI0cVZNakg4eUFnOHRUcEl2VlRwMU9CaTd1S0NI?=
 =?utf-8?B?U0kyZ1FDeDIwYTFrQTU5ZHhJYnJZb0NEOVNpYlNQVDBFY3lwRzc0WlRaOEgz?=
 =?utf-8?B?MFhVSTRFbSswcmVDODUzSmNkV2Z5Rlh4SkRvRFFVUVhvemw1VndIL3hvRXFU?=
 =?utf-8?B?eTc1eW5uQ29YbVNIK3UvL1AyWlFlTUVYUlE0S3RRMllWVVNWUGZQZkdzQm50?=
 =?utf-8?B?NGVWYlY5Q0MvSXg2SG9uTHhKeFpPMTh0SnoxTXZRY1p6bDNCRWxMK2U1M0Yy?=
 =?utf-8?B?SzlJVHdnNVd3amF6eDhwRnhYbmxWa243VEpIbWx1TS9BMSszR3dvb05rcG9z?=
 =?utf-8?B?c3Y2QllDYnVUYnRTblB4OEc3WUVhcC95NFA1SWl1UHZQa2NjaXNxZkRqZURi?=
 =?utf-8?B?S1draHpBak1BblNYUlF6N0NLTnZXMUtiY1l6TWVYdkJ4VDRTRU44dVNSNHZF?=
 =?utf-8?B?bDhiQVd3c1hrYVdZT2JuZStFQzVaSXptaEpsTVBEdjlVejdUODIyaUJ4NTFU?=
 =?utf-8?B?eUNzT29IdDB1RGlRSUF0SEpjMnQweUIvNFBHWjZsbmxBSjUyYkc1blZOY0Uz?=
 =?utf-8?B?aFdubytGUkFXWHFpMVZFVEhHS251bUkvbFdLWEZJaXYzT0NFVnVkdmNQNFZQ?=
 =?utf-8?B?N3k0Z0JqbDl3VjI3ZnhxWHJEM0sxVDlDb0JRVjBObGpzYXJ6ODJkY1RNbGU5?=
 =?utf-8?B?bmRxS3k5YkxHV2ZkNjZYY1RMRWlCcUZOYkk0SnRFdW1BUDhLcXhJTFRFeU9v?=
 =?utf-8?B?ckV3ZnVsemVNUXJYemxXekhVVEg4dG1aMkpZZjhHQVhoblNaMTRyYkxhVUlh?=
 =?utf-8?B?YU5CZ0pRYUtveGxCK1BZYlg1UTBEYjJqdmxGcVFPMGtVNVM2Z1dSRlJHaEZU?=
 =?utf-8?B?Ry9GVThjMnRoTnBNM1NkWisyOU41MDBkNWNzdlVZVjNRYWxvRnJhSG0xbDFo?=
 =?utf-8?B?TTRlcWE3Wks4a0QrR1FGWnp4UEJEb3NHUDdaZHdzMFJxeWFNSFk2SHlXK2N2?=
 =?utf-8?B?R0grUGlBWE40SjNNY0hzV1BXZjEvWjdkd1RGOXVkb3QwWHJuazRYUTRMRzNx?=
 =?utf-8?B?ZFZhWkE1S2wvL2lCZnJGSVhkTWZOOTJ2bHBHLzVuWEpmMTRuOXJyZU90WnJB?=
 =?utf-8?B?ME9kY3NEaXFTZ0JNN1MvVDR4cnZwQWJYSXlvU2tmWm4vUXFPSDhGblBOM1Jl?=
 =?utf-8?B?VHpKNXFKOGdtVSsrakROaTI4V2F3WURRQnhNa0xBWE9iWkZQNXExQjJsY3lX?=
 =?utf-8?B?M3NoUnQ0b1YzSnAxQTVaMnR5VDhGSndna2s1Skt6R05OMnVRWXdnVXptSStj?=
 =?utf-8?B?Z3JUdEFVZ3I0NkpuQU1NNUtQaHlXWHcyWktzWk5lNFI2MFdQdjRIY2U1VDhl?=
 =?utf-8?B?UHU2QVlwUHRmMmJsd1dIRm1YZUhQQ05JWVJ1YWJFcjZOb3JYZElvbU11bE5r?=
 =?utf-8?B?QURxR25TTmlmZnYrbFVKd1Z5bUFxZjJrNDcwQ0N6MkVYRnNXR0E1QXZ2SFRF?=
 =?utf-8?B?ZjQ5TW9kZWtLK09qWHc4UXhtSTUxUithVGkxVXdESVVudmtIWXpXSUJCdGdF?=
 =?utf-8?Q?eNVj11slhUtndAEUN9TDwhiKn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16b9445-481d-42f7-f50a-08dce90a885f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:04:22.7473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqKpn0aSd2+mxVbFMNgY1OkJZZGS3jNuIXGIS8+1wsW3pWfOjMAXFsJ42SaQyVIpYNtnIlnh+IMBcriagwk6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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


On 10/10/2024 2:15 PM, Lazar, Lijo wrote:
>
> On 10/10/2024 2:05 PM, Khatri, Sunil wrote:
>> On 10/10/2024 1:42 PM, Lazar, Lijo wrote:
>>> On 10/10/2024 1:13 PM, Christian König wrote:
>>>> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>>>>> Before making a function call to suspend, validate
>>>>> the function pointer like we do in sw_init.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26
>>>>> ++++++++++++---------
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>>>>     drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>>>>     drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>>>>     5 files changed, 46 insertions(+), 37 deletions(-)
>>>>>
>>> Original patch series is somehow missing in my inbox, hence posting it
>>> here.
>>>
>>> Below ones are SOC specific files where we know those blocks implement
>>> the suspend sequence. If they are taken out, then that needs to generate
>>> attention. But this check will cause a silent skip.
>> Hello Lijo,
>>
>> I have not idea why the series has not reached you in first time.
>> Second i did not get your point clearly, I am just cleaning up code
>> which just return 0 and doing nothing else. I guess those suspend/resume
>> functions were expected to be implemented but right
>> now its empty and just an additional call in stack doing nothing and
>> hence needed cleanup.
>>
> In those files, the logic is to call suspend resume of SDMA/GFX blocks.
> The implementation is expected for those blocks. For others, it's a
> 'continue' statement.

True. That why i have added a check first to see if the IP provides a 
suspend/resume functionality and if not then no need to just call a 
function and get return 0. Earlier there was no check and it just calls 
an empty function and that is what is changed in these patches to add 
check for valid functions and then call it and for those where no 
implementation is needed are cleared and i think this is fine?

Regards
Sunil Khatri

>
> Thanks,
> Lijo
>
>> Regards
>> Sunil Khatri
>>
>>> aldebaran.c
>>> sienna_cichlid.c
>>> smu_v13_0_10.c
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>> index c1ff24335a0c..e55d680d95ce 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct
>>>>> amdgpu_device *adev)
>>>>>                       AMD_IP_BLOCK_TYPE_SDMA))
>>>>>                 continue;
>>>>>     -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -
>>>>> -        if (r) {
>>>>> -            dev_err(adev->dev,
>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>> -            return r;
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            if (r) {
>>>>> +                dev_err(adev->dev,
>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +                return r;
>>>>> +            }
>>>> I think we should probably create a function for that code and error
>>>> message repeated a number of times. Same for the resume function.
>>>>
>>>> Apart from that the whole set looks good to me.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>             }
>>>>>               adev->ip_blocks[i].status.hw = false;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 340141a74c12..51607ac8adb9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3471,12 +3471,14 @@ static int
>>>>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>>                 continue;
>>>>>               /* XXX handle errors */
>>>>> -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -        /* XXX handle errors */
>>>>> -        if (r) {
>>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>>> -            return r;
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            /* XXX handle errors */
>>>>> +            if (r) {
>>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +                return r;
>>>>> +            }
>>>>>             }
>>>>>               adev->ip_blocks[i].status.hw = false;
>>>>> @@ -3553,11 +3555,13 @@ static int
>>>>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>>>                 continue;
>>>>>               /* XXX handle errors */
>>>>> -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -        /* XXX handle errors */
>>>>> -        if (r) {
>>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            /* XXX handle errors */
>>>>> +            if (r) {
>>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +            }
>>>>>             }
>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>             /* handle putting the SMC in the appropriate state */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> index 3e2724590dbf..6bc75aa1c3b1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>> @@ -40,11 +40,13 @@ static int
>>>>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>>>>                 continue;
>>>>>               /* XXX handle errors */
>>>>> -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -        /* XXX handle errors */
>>>>> -        if (r) {
>>>>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            /* XXX handle errors */
>>>>> +            if (r) {
>>>>> +                dev_err(adev->dev, "suspend of IP block <%s> failed
>>>>> %d",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +            }
>>>>>             }
>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>         }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>> index 475b7df3a908..10dece12509f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct
>>>>> amdgpu_device *adev)
>>>>>                       AMD_IP_BLOCK_TYPE_SDMA))
>>>>>                 continue;
>>>>>     -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -
>>>>> -        if (r) {
>>>>> -            dev_err(adev->dev,
>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>> -            return r;
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            if (r) {
>>>>> +                dev_err(adev->dev,
>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +                return r;
>>>>> +            }
>>>>>             }
>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>         }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>> index 5ea9090b5040..ab049f0b4d39 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct
>>>>> amdgpu_device *adev)
>>>>>                       AMD_IP_BLOCK_TYPE_MES))
>>>>>                 continue;
>>>>>     -        r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> -
>>>>> -        if (r) {
>>>>> -            dev_err(adev->dev,
>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>> -            return r;
>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>> +            r =
>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>> +            if (r) {
>>>>> +                dev_err(adev->dev,
>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>> +                return r;
>>>>> +            }
>>>>>             }
>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>         }
