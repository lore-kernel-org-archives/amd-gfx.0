Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A05AE81BDC
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 16:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B2B10E100;
	Mon,  9 Feb 2026 16:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SAhENDxd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A77610E100
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 16:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NErgKiL5fov4ywzSPkj1I2TnUuaC2buwGO5KD+MCGE7pK9xwviRPXl1La8Uogq3h5khNGrWfUEDLjolztROnkw87M/FitmB1V542WSXb1BAxhYuvHWpNZdFuPrIA+lREpjR4guUTBTOxwIFKyDk+M5p1leP5+0wMZqvPZ2P1KXqVDcdPjk8Y5gEtgCNdpQcdsendn6bB5pWDrznHLJdoQJrAldqPhMJ4NZ+syfZVyINcqYTQdaqgTfn0JijcHbpGXZqaKEbBfxMCgE3gY4jz1v7ZgehKUHwkBp+D2IT/3pe74XbiDX4DKYHSyOhk453bvGS0pkRs9VjRBD/v9Pvr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udqysXfdIDaauhCQzIzbjubcgaeNvKQhD2PUTRMarb0=;
 b=LMbO6OixhB0ogFLdIAqyKcZGHJHFNhJ8ydpUj/T7ShkAUQ0ppafV2LR99MqaaxrrN1xWFjWgCyCrkb3KnH40SF0r73o0Sg4gTX55UD/bV9cpNDBzrBF6LbeMbuT6PjeCRGl3G7UdVI19gljBAYNMawCBxVmIB7dPyF5OPpBgk4W27lzCl87oOO6ti+OGJ15ZGLncl5nPjDjPrQptDaeKPjSTe3eUOqI4vpHnyDSt7PjQcTQaZZq+VwkvQBUnKV88E3jJDb/jc2sXkwPsUGPWmIC85vAWMPupghLjVufPLhpIltgRQ9lCeO1pDUcLJ+O5GNTQ0Us4YvUZZQb38mru3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udqysXfdIDaauhCQzIzbjubcgaeNvKQhD2PUTRMarb0=;
 b=SAhENDxdC3dwzKXGafe6tGI76ae+NYhv/R1d2d6gOfCBDboHxuovMVGh99JWlwLM1jMQJTAjgj7sGmEgNboJnXdNcQtj4cCkltVRGH+LclyFSKHdVC4ZPs3hSaP0bNZWMyd8yZnK7xR2D2Vzqaf3kVreg9DihDY41bA26auYApo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:08:07 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:08:07 +0000
Message-ID: <fb0cd79c-2de6-4444-89f3-78c9a0b23307@amd.com>
Date: Mon, 9 Feb 2026 21:38:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/11] drm/amdgpu: Add support for update_table for
 SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
 <20260209130413.118291-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260209130413.118291-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 87440aa3-60f7-42f7-0a27-08de67f5696d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkhEVFhoY010L2d4S3FVclk2ajBxUnBMc3pHMzdnTXpJZFlDbCs2blBpaHRs?=
 =?utf-8?B?dDFtUXFIVllzRWxKZjA5WHNrNkdvaUgyZnVDL1lPMExtVi9HbURSK3pjOFhr?=
 =?utf-8?B?QjZ2STFYNmZTZ0tWaHBLNVY3Vm9xVVlvSm5Kem1oOU9QZlZMaFhwdENLeXc5?=
 =?utf-8?B?ckNIbFRMTWYrekJKY0p4R1M1aGxpemxYTERSQ1pNNGVMZ05SYkFhS1JodmRG?=
 =?utf-8?B?N056RUxaaUZjWlUxTGxsNUJVUG9PdjRIbis0M3hyNm5lQ05xK1BCUjRZVUFG?=
 =?utf-8?B?alNzUDFqZTBnTXRnY3NxSHQvelBmTmIyTUl1NWdGVTk0Z3VyVnpuTUJvaDU2?=
 =?utf-8?B?aTJTNkcwYnZxdmxRSnNIU0EzUVRpSHhPREpobXJ6ZGIyOGhVUkFNeEoyZkN1?=
 =?utf-8?B?Qnlza2ZXUm5hTWhrN0RFSDZyZ0NBandaaGlFNU5IOVlaMkxwcWJGSDBsRlBa?=
 =?utf-8?B?NmVsZXBNTFJRVWpnVVN3bi8vZ1lBSnBNZkVFa1ppbFNUOVMyMnNGdWU0dFVC?=
 =?utf-8?B?YVV2REcwK3JkWWdHb2lvTWJ3RVp0bmxWclFUckUwUS94aGgyU3dxaXdXcE8y?=
 =?utf-8?B?VVc2RXZrdWV6akphZXBLaWF5NjV2QndJYTdYSEE3SEh5UFgzVmhzOGRrVEVC?=
 =?utf-8?B?MDJCazlaaENxK2JGNTh3WS9TWHJjbE9mbGxyazR6OTBsN01Gc1VHN1dyMHVu?=
 =?utf-8?B?RjViSHFEN3pKekE2d0oyRDN6OVdNTmExWXBXMlNNWk94SjNMdklpajlaRFlu?=
 =?utf-8?B?MEhJWW9wMmJzTHN2b3dJMFBXVDhLU0VEZUZSME5QT1laeXdWL1ZXcVdqMUVX?=
 =?utf-8?B?SFppRkdXTFVjN09IRVU1S1VhdHR0b1JRdThXckVjdUltZHB3cDNzSU9PNHc3?=
 =?utf-8?B?NElBY08zNHdYbWlXUncxWUVLS1puYVBqVVlJb1hVcGNCUUo1RHE1TmJHTGV1?=
 =?utf-8?B?MjNtZHpZREFINGFNbjk0eDJpRFNFdDFmMjNueDRDMEhnY2tIQzVjdmNhMHR6?=
 =?utf-8?B?dEdyblo5c1Y5TThyeWRjTFBXVGFsVDhIaU5QNkJHMStNMkVEaTFnSThXTVNj?=
 =?utf-8?B?Vjdsd21LMGl3Z3lEVHVGdHJjTmlQMVJMV0JZWUowejRXNUtwV2VPZ3doWVBZ?=
 =?utf-8?B?c25KbERDOUxTWWtxM2xCUDZ4NnlHRm1NUFJadEg1dXJOcVBwUjBUY0ZoaGVk?=
 =?utf-8?B?YlVpMlhoMGYrbFdwWTlxNURqRHZkWFlHMGx5OFlybmNEWXRpUTBQeWFVbm1N?=
 =?utf-8?B?NUtuOFo5WElXaVVITWlhOXZRVG5SUFZ2amlUTnVFcTBmVGt2V2pDalBMQlVD?=
 =?utf-8?B?UUIxZ0NrMng0cmllNCtkYTVCYnNuNWF4L3A4TGRYUWg2SzRSWVFIVHlXWFFN?=
 =?utf-8?B?WWRzL3ZYdExVK2pocFBrTElqci9sa1VvOG42bkh4M0MrZWlOMExPQXNmRlFo?=
 =?utf-8?B?aFBRNjdLbHdkWkJzVkZmVmJFYVZBakZrbUxYYjFzUFoyMTBEa3pFSzJBUjdk?=
 =?utf-8?B?ZlJydjM0ckN5TURmbi9DTE9nekZqUDZxTlVzaXJZcnZDTnJsaHBxRVpiVytl?=
 =?utf-8?B?elIvVVA4OXptczdFWkJzbTRnbzVBbm96cWdCY011eG1nbFd5cDNrRVNGSjRX?=
 =?utf-8?B?bUg3SWI5cFROanVWY2pleEN1NVlvVWhJWHM4bzNCUXkxNFFxbHNRM0d3bjhT?=
 =?utf-8?B?QzVEVFNkandSWVNaMGF0d0psSjN6UytzV2JSSGpJNUgvUVk3VVJaWTZ0Ri81?=
 =?utf-8?B?cjdJVFp0SEZPTFNaY00vOHBOeWhxRi9nVXZGSWxyVWhrc2JFNDFkUlM0S1gx?=
 =?utf-8?B?MTFPVU1IaDE3alVGS1E5NHR4YklPaEZtc1hHdjI3UXVhRitWNW5WRGZ1ZFI5?=
 =?utf-8?B?d2VhZG12WnBZR1l2c3ROcHdPVXdycVU5MTZwOWk3VXptWitPaVZ0TjEzaGEy?=
 =?utf-8?B?VFl0bFc3SDZVVDc2RGx4ZE0va09mK0pIVVo0TGlqTHlEVjhSQkwrTjZKOUo4?=
 =?utf-8?B?R0dDVGtFb1FXbVk1SkZhVEV6SEZMZ2V5eUxEYzNMb1d5VEc0emFSWUc2SVVE?=
 =?utf-8?B?cWZTQ0lYTnB0ejdlUHo3ekJ0RUszZ00xNDFtSFRqQzBpTmVrRWhzSS9JaGNp?=
 =?utf-8?Q?9R+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVMczVGV2dHeEorWVJ0Sy8vbmd1L0xVKzludnYxb0gvTXdPTysrbzkwNVUy?=
 =?utf-8?B?dVRTVElsY3h6ZUxxV044K0QrbW1aaXZmZXorWFd5bm5LQ1lWcFVraU1GS2Z1?=
 =?utf-8?B?TWU5ZFFFbUtqQ3M3aGxGaHh5WkJyK2UyNzRiZ3NXejZjNDVudllFWGxNVTdz?=
 =?utf-8?B?am9nTFRZdU51SlphTUhKRXV1ekZ4RGc0eVdkTndwbUZJQnVsNk9BRC9yTEE0?=
 =?utf-8?B?UVN5YTVuT0pyOEtpOHpIVjBzOU41YzAva3VrVDFNSzNHSjdOaUwxTGZaamJx?=
 =?utf-8?B?K2ZYSm5nQnljZHQ3VUFTWExod2d5cnBwZmVSRThWanMrMWFFWkZoU25aMVFB?=
 =?utf-8?B?MzAvTnRicUxUdnJqTEkrazE2ZTZmdVE3L2ZINE43VFNxaGRLUzdwd2VtZEk4?=
 =?utf-8?B?TDlNNDNFbWJzb2I4NjZCUlo5K3NiTitFa1pSQllqWmlCNEJrcFdJMExBQk9Y?=
 =?utf-8?B?b3dJZDRzRmdRaTNoS2NJVldJbmhqZno0VDVnUDN1elZ3a096bDQ1SkFhUjBx?=
 =?utf-8?B?NGZtNVJaWS80SFliaDhxVGg0RUYxZ01GMUlHL2VTNTNzVlYwWTdkNk5UUU9u?=
 =?utf-8?B?T3lnampvbjZCUEIxcHR4WGNQa3AwSlRiaXJ3MWx4RENxeUJ6VnhrNHhQQ3BD?=
 =?utf-8?B?UW4zcTVWUXZBNkROSkJVQUc2Y3p3cHBPMDIxcWlaRFQyMnBzZ2VNN0prS0xL?=
 =?utf-8?B?SGZlN1ZCQnpXcjhjcFlYMkFieUE3WHNDMHgwVFhKOWRIUU5LS29ocGV3WGMv?=
 =?utf-8?B?eTRoL3VOSUNoVW5JVzN3alBmeGQwTE9yR3U2TXBIb0hHQnFGd1ZXV08rOEgx?=
 =?utf-8?B?VmovcW1UaFdCZ1Y4ZkFwUnlYd3Z1TlNFTDFmbjVNSVZHUXh0dzcxamtBYTZi?=
 =?utf-8?B?ejkzc2o0YW9JZXdvbjNkVEVITFV1UjlHdENmMmpEd21CY0lQUEZUeGhxKysz?=
 =?utf-8?B?akpxYXRwcE1ZWDVaV1pnaDE2VEZDcDE4WXV6b3orOGZJZEpMdUZFc1hWQXFJ?=
 =?utf-8?B?SGlCUGpwVzV6MkZnc3lqVG1pRSsrdzgvanFIczQ2cmZONlBzaWJZNGRza1Bn?=
 =?utf-8?B?SGtRT1hrWlhMa3dSaEZBMnRyZEh5MEcwekptU3NpN3k3NEZsc0lieE52WUN4?=
 =?utf-8?B?VzF2R213ZUdORklKa0p2MkRxb3dEVzdrNEpVRjgvSG13dEl5Z09QSmlHS0JG?=
 =?utf-8?B?Y2VXcmkvV25XeGhwbHhJNE1rUk5tTUNwd3lXM3Zwa08xbUs4VXJ5amZ1T1hm?=
 =?utf-8?B?WDBKSjV6Um1VZzNwYnBuSHBuU2tZWDlqQmswMjBKZk02aGpLZWlMc0pGOFBO?=
 =?utf-8?B?T1dEdVI4Z3hlMElHUkFNZmRnbitZSSsyZjNxR0RnamJlaXFaaGczdmlzRldh?=
 =?utf-8?B?cDExRnhmTG1nRXMvaFN2bStWTDVqMUpjMVZweUtzWVJ4UndxRjJhZkorM3BF?=
 =?utf-8?B?ZkQ4bjMzMmFyVnFPTHBUaEl5M2pIQXRrZHpmWjFGMHM2TFFqNG54TTlNNzdR?=
 =?utf-8?B?VFFuMDR3aHBSTGZkUis5ZkNOL1NjRFU3TUtrd2hOM0tRS2JqMFNKaXdwd2Vi?=
 =?utf-8?B?OGNPUERqZ0IwWnozWENzTWdzMkZ5VFpVdVYzZzBkZ2NUeTFjMDMrZnNzUU9q?=
 =?utf-8?B?U1pzeGFvU0RXMHljWGVJZDZkRWR5VGVLMGlrZDNRd05ycGdWQnpCbk5BSTl4?=
 =?utf-8?B?amd1eWQvSjkxK1FXbDhYN3liejJNMkEzK1MvRTlUWlFKcktyWHRJdTVYUXRB?=
 =?utf-8?B?aGZWSTBvVEVOZnV1cVF1OWpGcE9LbFllNE5FNkl1TVlkQXUrckl5VUlwdmhs?=
 =?utf-8?B?QUpGNEpWMk1mWGU2UkxWVFhZaHV4SGtCVWVtek9rc1VQSnBWRkdYQXJZdDdi?=
 =?utf-8?B?UStkOUhpVjE3NHBmWFpmSXlLd1JDbjM5YnB1bVltTlZjRVp2Rm1yUlg1M1o1?=
 =?utf-8?B?RHRBb0NEWUUwRXE0UTl3bnlxUXVMTWY2NExkTXpaN1JtYWxjc05ZRFJmZEd0?=
 =?utf-8?B?L2NmSVVtL1oxMnZHWGR4Tm1JcjZ6U1A2U01CWit0cEk1MWsrWElON1ZhS0pK?=
 =?utf-8?B?OGUyamVJRjU0Z3Q3RjN3a3lwQmRJQjdaOThualVpc21hbS9hSU5CUFIzRDQ2?=
 =?utf-8?B?N3BVcHcwVERtOEFuUXJlTVZveDEzcmp2U1p1cDdaZTJpOEpSYTA3NXdFUzZt?=
 =?utf-8?B?SWZmT0R0N3NCblY4WU9EblFCSk1yZEdNYW5BeWZHQWVMaFBoeTFxM2ZLME9t?=
 =?utf-8?B?YUZheFNuTERPOEJWY1pOKzBZcVpNaENQWHl6Vkh6b04wblhZUzBKWGZWRm8w?=
 =?utf-8?B?RkVrc3N4dStLM0lwR01ncGJUaURVZmtpR1d3dXpLZDY0NTRsN0lhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87440aa3-60f7-42f7-0a27-08de67f5696d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:08:07.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf3eObwLkxZxa++sC+FSuIb1zBJ0LxOodvI0wbDhmddGtrkIRE4vhYpqhI+1iNy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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



On 09-Feb-26 6:34 PM, Pratik Vishwakarma wrote:
> Add update_table for SMU 15_0_0
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 58 +++++++++++++++++++
>   2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 14e8d8c7a80a..af87c31ca9a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument, void *table_data,
> +			 bool drv2smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..d7a4d5d6cc8d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,6 +1726,64 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	address = table->mc_address;
> +
> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
>   int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;

