Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D729E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F6A10E171;
	Tue,  3 Dec 2024 21:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cNVOxKVF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C331810E171
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTtg9NLnyhMsf7OVC6FBUxlYBGNurbn7o61Hv/BQR/S87JQ+BtFYQIwA3FqvJZ181l5xdSLe+CfYtkqw/Jhx3amahtpixMhr43G9E8tQ21nAPaMfF+VbEIczKSpAG7r9i7/rqEoQd9mxqCwUSVQZd1WOtzAaVBIZNLXOIBFDdalBNtedzdAT1NCXOZrSpClY2gy9TxqdlsMbgmSNI0exyyJpcQeDb2Utjh9n1qOAWCWJ1VN8BnZJT9FgiNDVy7IGbxEcJ8xmJlCGRyEYb9do4bIguwWkCsNNwmUwVc4tw2AREIPmNEZtkOR4wKaLZV9kQM++tYJsa2tP0f6YITd1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r5i8Cx1JH4/5kZPOo2ApdyAlfkglMUINTDIi1zZTF4=;
 b=pxfgnaPhlRTstmjD8JOblIRRvPMK5XZKP0uAmrQIi8Z0cSLoaa/giYsQC+foBsc474dh5SFQ01YZ2cx03YPll0eufs743nvOHJJwP+6IPqlhJWH9u3IOSYtWIeVajOVrpqjA2IzXFsckY3XSpwB0CJcV6cTaDge0Zf+jeBB6oehRp3F9xSrTayhpcY9jaRJmPSXL41c+DFGDWXQp7bGH671sMx9BT2sRetcVGRiKVMiYJMbx/uojXZVluFNXVXeTfzCZMenFCcIOtDx4vx93uRn7MUULI1A6kfjMMnQkVZJMLVYGcNXeiXKgvrh+XowtbjJprhnfKMSde6iMgQ+eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r5i8Cx1JH4/5kZPOo2ApdyAlfkglMUINTDIi1zZTF4=;
 b=cNVOxKVFW6OtdTTUb4H1+efSr4yyeRNJXQBVvaLaPiIog4ArGAIVgahNBuBuxYEjeQAjwFr79NLehsC+VjSF3j2brzsC5/ylfwbiMXfkTI1xT89ioCW8L/BusWNhOZIFTTMYqQXWndrZpdRuNwH7nE7bY9dqYbPc3DWCPeHm0E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 21:52:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:52:37 +0000
Message-ID: <40cc9c63-0b69-488a-8bce-30dfe6d97604@amd.com>
Date: Tue, 3 Dec 2024 15:52:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Better recovery from DMUB load failures
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
Content-Language: en-US
Cc: Mario Limonciello <mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e34edf-834e-4ea1-5464-08dd13e4cd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFk5eWNtUmF4TW5QUlpOQ3I5L0s1Z2sreTVrMUNEU1RIUDM0dkJ4QnB6K2Mz?=
 =?utf-8?B?N1NMZ0lBSkdoVHQ3MTNNdytaa0R6Z3QxOTlyMVdGYmZlbkllb05zTEM3M01Y?=
 =?utf-8?B?M0Ztcnc2YVk5VGRDVG1JUnF5N0hRSXFrazNKS3cvdlRyTjFVTi9PeXJkcnFM?=
 =?utf-8?B?WnNPRkQ4SHJUc1JraXNjcFhnczFhWjZNWUZEOFplckgzRGtGdXl5MHJhbFFP?=
 =?utf-8?B?TThiNFFHcWlnUFRQbHJrbk5Da2MvUVFHYVRvVTZwczh3SXN1ZkNwL3F1NHZz?=
 =?utf-8?B?NE5kckZWQUh4WWtYTDI2VXZlRnNDYjNMRWM4Q2FsT1FQKzB1Nk8xZEpWa0Fs?=
 =?utf-8?B?QUFFSkdGWGhpMWp6K3pLd3k0Q1cxVDlpeDEzSC8zMS9QSnZFOFA3UENwdVdh?=
 =?utf-8?B?QzRWSHlya25qWXFZVU9VQ1ZMY2pmV29tc0VTTXhiSWtqOFVlUDRvM2RxditJ?=
 =?utf-8?B?dldxa3pDYU1ES1ZpS3hqQ2dzYUFKVitkOEN5cFBOZjBMQS9heFQ0dnRVc1Yz?=
 =?utf-8?B?cmNKVmRLQWV6d01ibHdFODR3bHY0UTczSFp3Y09NWHNnOS9UL0VrMkFHUzRm?=
 =?utf-8?B?YjY2bWg3aWdodFJkM0F2UU9naVlLbXhWL1RyZFMrSTVUWXl5bkZzb0NRQmNO?=
 =?utf-8?B?RXlhQ3RNckd2SWJWYUF6bXBhZkJ0ZmxwTms3M3phR1JtZDQrQmZqOC9NRm15?=
 =?utf-8?B?VEIzaG1BZ3lEV3YyN1hDT3I3aXhnaTJlckJpemdHL0lkcW1ZY0RPWkFxRUJ4?=
 =?utf-8?B?TXgwV0ZhN1Yrd2tCaTh0aStkT3ZMeDVXWkYzK2JSWldMWVc1ZHNzK3dTbHdV?=
 =?utf-8?B?S0VLc3JUY1ZZUkxzeWY3Kzk2RzgwdWEzYWtBRDhwNUk1UXhub0VubWlxc3lz?=
 =?utf-8?B?VEl0K0tIQU1mdEp0dGhSWGZOSEFFYnZJTnFjUVEvRis5NzFPWGlMMUl5RjVm?=
 =?utf-8?B?YnZ0ZjUyQnBzVm9vcVJuYjA5QUtGTXNVL283NlM1MFlTcTBlWnJ1ekhNZlNz?=
 =?utf-8?B?dlQ4SG1UQ3ZwTGp4dVZXalVET20yb2JkV3NxY0JXdzAzdEtBMlhuSGlZeWhx?=
 =?utf-8?B?cU5GZm9QS0xsMURuVDlDc3RHd28yN0hWeVpxZjloY2lGT0pLYVlLM1NpbkdH?=
 =?utf-8?B?VnEyc3dGU1JnbHduMlltQ3FySHZ3OVBac0NESXd6MDFhaGZaNEJXbWpBeW5E?=
 =?utf-8?B?YzR5VEhEU0ZlSFlLb3dka3pSb2c5UGs5UkNFWDJnRy9YOHBDWGI3OFI1SmNN?=
 =?utf-8?B?VUNTM0Q0aGl3aUdqUWppdzdMUFFEZnZRNGg4TzJ2ZTBiaHREZUJZaWNmcGxV?=
 =?utf-8?B?blBZYXN4VG43K0hNVHR5SVNtWE9wYk51dk5GR3FTbGFDdmwydDA3V1ZST1N4?=
 =?utf-8?B?ZFNjcUY3TzlWMzgwNDZ6N3FoczloZ2x6NndidkpNaEtuSlU4eFo0RU84V0pi?=
 =?utf-8?B?enBaY3RBdzJaRExmMnNSdTc3ZnlKcWtWYkhtWjJjWTc3ZDVNZTkvQ1ZRQnpl?=
 =?utf-8?B?N24wQm82Z3dFWEt5RU9iYmVjcHBoT0VXb2E4bkp5N2x5dmFMR3VOVE9LSDho?=
 =?utf-8?B?MzZLZmJxaUR0MlkvaENEeTNPbjFBYWp0NWMwZXQxQ3dBZGFHNHdvK2RtQzV3?=
 =?utf-8?B?K1h3SWQycFU5eTJQZXNFQWJtbmJPQXZIU2pBa2pSUmUzbnhibDFxaVpRV0Zk?=
 =?utf-8?B?ajNXNTBndzFPL1dYYU8zd1ptckhQclBULzJDdWthZFA2cWpFSDFiQ1hPMTRH?=
 =?utf-8?B?R05uOG5zSzNXbUNJUGMxQ1lNOFQxVG05RHd1V0tady9XZGMwS2piQ0F3V1BV?=
 =?utf-8?B?anZjYVIrNlZaa3BPZFZHdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitzQjAzdm14dkc0OWY2ZEZHSXhMWDdKSWNRclFxMG9lTHkvejVaU1pVdFV5?=
 =?utf-8?B?UGdtSVJYdEtVZkF6cUNGOElHellNVGU3WkFFNHkrZVpPOGE3ZXh4UkVVZDVC?=
 =?utf-8?B?OVZtcFVVdVFIalA1RGtlRm0wYzEybUFReGwrUVZJYmNyUlRoRXMybEdWcnE1?=
 =?utf-8?B?T1BmaHRRVGQ4Y2FNTHZnNlQ4SUVVVTNyd1VKcGFNenlybm9yL0dUNzhJOUFY?=
 =?utf-8?B?V3BVQmtRV0M1WmJzMlN5ck1nejlPOU96RXNGMzUvR1EvNVZzZUY2TmhScDZU?=
 =?utf-8?B?QlV4YitmQkNsQ1RwNDh2emdTTU9HeGdYVm96U25KblZJMDI1Nk5QNzdwMklY?=
 =?utf-8?B?T2tuVStwc25EVHlqOGxVSDJlUGY4OFU0YWV3c2ZyUzI4bURJZ2dFZ21FZmZO?=
 =?utf-8?B?cVBiUGl3WGpVRHZQNkxHZ2paWk5aTVJyVXBFWkZ6dE90bEtYZkRpMjdlRlJM?=
 =?utf-8?B?QWVNbDIvUXRLUHJnTzFqTDJQZERpVjlOVWhBNUtKczA0R2ZtZ2ZTMVBaeENN?=
 =?utf-8?B?YXVTNzBsUG5TTENMcXJpazg3WEFVOTlJQStmclZ5R2VjdDkzZ2FaaHpEbHND?=
 =?utf-8?B?bTVwc3dOMDNDamJlcUpVQnpJYmZiVUI1SnpLVUpXTGJQT2JtbnlqcDFBbE54?=
 =?utf-8?B?Z3FXeUFmd3htZXFRUytrbndTbDV4d0x0RU5ld0FrcnRIMEhrbmZNWEo1WDc0?=
 =?utf-8?B?bi9QSDZXNWRVUmJLRHRQZDRyMytHaDQ0NkE1aGx6M3ZMNXA1ZjdXYzJwaGZi?=
 =?utf-8?B?OENOSGNKYTQxelVvMzAwaCsza1NnNmwvKzNMWlVSMHpSVUhWemltV3FTMXky?=
 =?utf-8?B?ZUowMFUxRk9KSmZhRXFGZHc4cFp5bWFFQmJMeHhUNWNzQXZ0c2VVN1FBemxw?=
 =?utf-8?B?MWlYb0JhWmhKUVJ5aDhPOGVLeTU5ZExzS3lkbERCOEx1TXhDdjJOMHVwRy9C?=
 =?utf-8?B?RUVId2NlSUZxM29UNXRRMHhWWmZiaGFmMXZNclNtMU84NVFCSk13WFJqTEVT?=
 =?utf-8?B?Yk5VZWJnZ3RFZmdTam5lOU5hVFAwa0Q4ZVViSkpvYlRkZWRPWFFEZ1N0MTJX?=
 =?utf-8?B?VEpSbmhlc1J4TW5Ra2k3Zkk5SHZMaTNIRGpySVQxM2hRZ3FkOUxFdStNbm9r?=
 =?utf-8?B?SUM1bk0xTUg1eHAxc2hpRktxSDNjb21yS0VtQjIrc0g1L0dDYVpkL01PRjBX?=
 =?utf-8?B?Ukd1bGZEd3RWZTMyK0twTUxuZERrZ0FSTTZrVURBOUhZbU1FeVZXRFJ2MldT?=
 =?utf-8?B?djZXZWFHTmVOQXR0SGdOVXZNZWVVcHB1MTllQVNFemFEWEJYTnFEWVVwSURN?=
 =?utf-8?B?R1ZudU9pSDAvRVg4bFFsN3pPRkJieDMvM3lOWE1rdEorZkNBZjBsQUZGQm5v?=
 =?utf-8?B?aXFMWHRSYzJiWlRkSnJRRHJiNE1SckpYYUNOVCtPMFZFeHcyU1owemdHYkMx?=
 =?utf-8?B?QWN6Y2FFbXVSQlExaDJ3OVJYbi9jb1o4WTFWWHZHNjZiRFRTOVFQWmdzcnNs?=
 =?utf-8?B?WkVYR2x3by9hRzlMazZwU1lDdWFqczBSM2xKaXpBSzBhQ3RmK0tIWlZqa2p2?=
 =?utf-8?B?d09IcWhoUDR0NkpUWHZrcTlaQVR5ZFJ4VWdOaEluYmdXWVJHdnRyYm9JT2g3?=
 =?utf-8?B?eVZhMXRzdjFZMjNNVjZKeU5mOEZ2bmxYUzBMWDZkVEJabmhFUDRVbkdqVkRV?=
 =?utf-8?B?ekZMVWtNK3dSNlRHaVBtbnNLRHgrOHNOM2w5RXphbUxTTHFPdHJkL1pJVTB4?=
 =?utf-8?B?MkVrWXRDWnd2djRyMWk0anE0c0YwS3BNTWZVakV5cXFoait3M0xPeHNlUmp4?=
 =?utf-8?B?L3haT3crM2VxRWg2dEhPUU5TZVVEaVFwK0tsdkFOUDFURzFGVXE1b0h1U3g0?=
 =?utf-8?B?djVIRnAyeTVFaUhPbU5UTWs4NlhxenlMNG5yaGQ4SWpkZjRzWGtkNWhYcTdu?=
 =?utf-8?B?NzRjK0VaMVZ4bVRBUThuWE42N29YbG45dDhnOHY2N21Ib2wzamtTN0Z4WUtU?=
 =?utf-8?B?cVRxZlJ5N1d6TytZSjVPdVFvaXVCckNzU0lvY0EwbzB3V3B4WEVZckY3ZzZu?=
 =?utf-8?B?eFhsOEZzcjcvYTFBY0FidlZHemlnMm5kL1hmempRTEZMRnNBc0R2djdmQ2tZ?=
 =?utf-8?Q?kfhyBkYL0wiimZcvMVRV0lA++?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e34edf-834e-4ea1-5464-08dd13e4cd67
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:52:37.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHqouvoRk8k20N7hy3aTp77Gmcbhe5Nx/rD9NsSCAdzDGj6mTJpTsy0db3brHlI2lLIIgxsunvbWabJxywNVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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

On 11/15/2024 00:09, Mario Limonciello wrote:
> When a DMUB load failure occurs the amdgpu driver is left in a pretty
> bad state because the display core thinks everything is fine.
> 
> This explodes once the core tries to do a register read which stalls.
> 
> Instead of papering over these errors return error codes up and do
> the proper cleanup.
> Mario Limonciello (5):
>    drm/amd: Disable interrupts after amdgpu_fence_driver_hw_fini()
>    drm/amd/display: Fix null pointer derference in amdgpu_dm_fini()
>    drm/amd/display: Only free dm private atomic_obj if initialized
>    drm/amd/display: convert all DRM_ERROR and DRM_WARN to drm_*
>    drm/amd/display: Make DMUB auto-load failures fatal
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 388 ++++++++++--------
>   2 files changed, 217 insertions(+), 173 deletions(-)
> 

Ping on this series.
