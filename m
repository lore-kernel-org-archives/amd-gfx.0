Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD6C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 01:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63AA10E3AB;
	Fri, 10 May 2024 01:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNCXDKyx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21CD10E3AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 01:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiG0Fceem5REPHCxIUi/S9yiRgzOvStYAIJzIY/DRkNqEnAjuXqk/kZPSIKy8pzQDPYUC9rte4X/Xr6WS8GpL7EqfO8peloYabXdfrYcybkVebJ5dHJNsLEbTKElajOTft5StagFSFSBkNVndJc/O4KGvftMd2t1RUvPsDDsK62jeHxt/haqsJrE8NbvLQnuI2RxU/FEzQZ1H14M/z/wxiyaN6rIOruuAjWQfURUK1lQB9BtVjvB2DvH4hX19t3sa5vrrHcvG04f//MKKrssDTo1/h2lOsuFsXT/qX+vEcFH8l4JvqF42+/IS6UwIQRiyvatkWdpjFyHbLAoGlvasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyDBfkrcCPy4uqGgQNgji6bSChoqbDdh1o1E8q+y4dw=;
 b=aTmOEodCBkJVOqVs2JG83089GSsnDwD7isHQVWZM7EFuRXnAGx8Bp0FQIweBPua8pYPgIqu0k1vTFLopyYJnVaYhlAWsXuGOoQqPPpWKE+4w9Kvw8YilWJnegZh+agP1k8Qyzo5LCvOqmq6z8+Iud8sJj1Tf+IN4GFBh7NBTbAnX8vdKojLldtca91n/26mDarZDUGJ1tcTvMKyPRwGjHs9fxeFsWfx5Z4Qn9wnKZ18vbIpVMiqUiF/LHCczHkdWsAJ9kVhYbghbznTz6PHfCJbD9EJadRnGzE4xVHWjFgOdPBldBBrJxtSCu1oC7vOojafdz861Oenmk3uSKehJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyDBfkrcCPy4uqGgQNgji6bSChoqbDdh1o1E8q+y4dw=;
 b=QNCXDKyxz7yshGbIo9mjpRM/laZ4Hry238Jk7ffULmr4zFgLgImzohEtM8YrPN4CNC2RVJC1PgQwvv60PRfYZT9BoScDEgHTMo0zqxAyO7jYmOVHQo5CcuoluhPd0AiQ26x+Dh/5qaWLQP3xmz5bxli5AtxqyHu3Vj2l8vMSRIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 01:53:37 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 01:53:37 +0000
Message-ID: <d03237e9-d2e5-4ec1-9be6-6e91aeb5c2b4@amd.com>
Date: Fri, 10 May 2024 09:53:28 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240509093705.414124-1-Jun.Ma2@amd.com>
 <PH7PR12MB5997A8C067197492C30A64AC82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
 <37128b62-3b01-435a-8607-28c67c119927@amd.com>
 <PH7PR12MB5997A8B37D969667A64A197782E72@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB5997A8B37D969667A64A197782E72@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1e54a3-5d45-411f-073b-08dc709401c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlFqVm95NENMLzZHalZnT2UvVlZWNjEydWtLYXpFUzdoNmJBaE9QQ2JaYVJ5?=
 =?utf-8?B?Tkk0anJhMFdPSWVRNTJHWTJ6aWQ0Rk1RbXltblNYdGROaHYwc0I2aVNQb0tt?=
 =?utf-8?B?MWpUKzNPcmxNZXdsK0lnZXFHV0k4NmxwalJGc1JJakxtWXlyNWNJa0MvS1Vz?=
 =?utf-8?B?RGVxQ0cyZDVrUEY3S0RQQi9zUDZFT2UzWElUQkRTMUNuTE1MczZ6MDV4T1RJ?=
 =?utf-8?B?NkFoQS8xRWQzNldheDMzWmxKSVNZM0R5ZGJ6K21RMENzbE9WVlQxUjZQMzlC?=
 =?utf-8?B?QnZ0ZzZDMEs4dTNUQUJ0dWxsZGxLcVM5cnFudHU1YlBOT2xzcEk1RUExL24v?=
 =?utf-8?B?YlNSYVYzT3NXYTk5c0x4TjRpUzV3NCtkWHp6Wjk3R0pJamJldzFwZHV1L3R0?=
 =?utf-8?B?aHZoQys4a3NXVE9HWEJMT2R6MURvYThwZEdFVFZIZm5jRzlubVNCdE92MmJr?=
 =?utf-8?B?SzJFaXZrZUxpSDRUYzZ1Y2tBcENBOUZkbzdueU10eFczZDExLzNWVkdGMjlz?=
 =?utf-8?B?eitCUjhqd0FjOVdIOVRTTmRIdG5zMnVVTFhYTG9qVEo5eDhoWjE2cmkydnhR?=
 =?utf-8?B?bjIrd2RuMEhQWnVYWEJtaDhrZXFnaWh1MnMzU2lnbDZvMFZUTktwZXNjVndW?=
 =?utf-8?B?SG5uaWVMck04TUUvdmdKQ09PSGtSUTlKa2ZEWGdYYmw3U3l2UDJhNldXS3BC?=
 =?utf-8?B?bGo2THBxdnZQYTR3a2w3MWVCZUJ1S1FSbDJ4VHloeFhJUldERW9BcitzeEl4?=
 =?utf-8?B?SzRBMFlVUFF4UjhkbzJTTnc3bWtyU1BzK1N6KzV6ZW5VeGtiVmJzNFdUbzR0?=
 =?utf-8?B?Z2xLTkxac2xVLzZnUDUreXJmeUhibjJHNFJXdTBIc2V5eDlTZXVpQmtQM3pL?=
 =?utf-8?B?Q0R5d2Y4T1F2dnlnSGJTRmcyREZJRFJuM0ZyMldoWW4xbmJUWnV1TGJ6NjNr?=
 =?utf-8?B?ZEVXSGJoSUNINllUcmM4WmM5Q1NYZU9FSTNyc3ZCdDgybEg2czdienJiME4w?=
 =?utf-8?B?YnJaaDJrb3I2dTdwYjlUMFk2S2o4VUcyNzIwQklTb2xOT1pnWXRDdUtiV3F3?=
 =?utf-8?B?T2c0MmZnUWNzTnZZQXVnNFRXVElvQzNITmdWc29vaVl1eVJkS0plUTZhaHVG?=
 =?utf-8?B?T1VVa3FOWmFQT3ZRS0d4aGplME9LcHRHU3BQUDlBbnBvdlBYWkQ4cmJFNG9O?=
 =?utf-8?B?Zjl3cWdIUExYalZZeGNJcVhWaVBTMlNnbU9BNXExdVdNYVp2NVlhZGltWi9H?=
 =?utf-8?B?K1owcnovYzM3REp1WXhibWZKb2loTjN0QlhoUjF3OXp1aFhMNSt1T1g4anpY?=
 =?utf-8?B?dU5NSnE1dm9yL3F0RlRUNDA0MUxoNzdKY2plKzU4dFNIT2docUhVbkFVNDNS?=
 =?utf-8?B?YlpjUUpWUm9oWmkzQmViZTJLSzR0RFZJb3VMeTZxdmN1dmd3dFlLZG1md2xw?=
 =?utf-8?B?aWFZVU5qQUxkMlZreFRVUXIyVUZEWlE1VTRnVEpIU09iUXhRY0dZMC91eVl5?=
 =?utf-8?B?dGh6RXk5Q29QZmk4eXR4emRMcTU5Tm1Wblh5akVUdXdhbDBIVGtYUzZma3Yx?=
 =?utf-8?B?RE5kN1d2UllaK1V3VEkvS0sySTRNdUxXY3MxaE50VEJPS21QWnF1aUxEM0Y3?=
 =?utf-8?B?MURIZGpYRXp0R1JvZTl6MU42UWVENTFtTW5SeExPT2hwUy9QR245WEJJQnFE?=
 =?utf-8?B?Y2FPMHdJTnVhNVU0UjZ1Y2hlZ1FQT0FlSUNRenFsR1I2U1VlOW84K3VnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEkxV0djZ29BL1JqdEhFZUw4OHpSOXVzVW9VWUZNUEYwY0xXL1BoYyszc0Zk?=
 =?utf-8?B?VmdGa0YxbjU1R0VBdVNTdTBlMEFYN0dTakFRN2pVMjNLMkNhVHdyeTZWcjlE?=
 =?utf-8?B?a1F5KzlTdHc1QmUwcnpURkovWk5UdEpsTjk3c0FpT2NOY2lVYThqMmtqR1lr?=
 =?utf-8?B?Y1psWFE2Z0h6R2NtekUvanJ2Vlg2NmZHekowRktnUW5PbzMrV3M0Rmd4V3o5?=
 =?utf-8?B?ODdYV1FFZWF5emQzSTdzSWlxUmFMWlpjUTVUc1ZON2tvZVlNdy8vQm1FTU5u?=
 =?utf-8?B?Sys1MkdBRk9lMDBZMlB3c0VjUlpCTXAzT3NYNmxaU1c5OGFWcEUrTXJ0dzlj?=
 =?utf-8?B?eW1hNjVtWjgyb1lRSFViSkxnTUdnRk92Y0Z6N0thRzZyb1ZHaTBJMER6MDBD?=
 =?utf-8?B?VHZIb2VGWmVsVS83NkpOdjdmc01UZ0lXb3JqSkdTT2U0NzVDKzcrYkdMYllK?=
 =?utf-8?B?eGxTTnRwN25yRGVYSWFyVnFkODVXUlZqQkNvOUQ3bW9HS2F4YU9UUWFuSktY?=
 =?utf-8?B?N1o2c1pwclloYnBlNTEwL282Y2IyQXJuamIwQUJDU3pOS0YvTy9oVGNFZXcw?=
 =?utf-8?B?ckpMbDNTeDUxcTM3RFlGbTJURGhidnU2d3V1UnZUVjZsQ25xMkdkeFRaUTJB?=
 =?utf-8?B?WmNxSWYyKzdhcm5vbWZBeEVLVWw4RHRlMzlNSHV2QzcvUUlIWlY3b2E3b00x?=
 =?utf-8?B?a29lSklmQU9Iek5EcnJJV2haeHNMSXVFdzh2MGtzNWwrQnN4YTlWWDVYQi9y?=
 =?utf-8?B?aGN0dUl2b1pYdjZzZW1QVjRHbFIweW05UDB4QXZ4UUp0bEcxMmxmcUEzRTh1?=
 =?utf-8?B?TlJTMERKc0lIR09ldE8rbEU4WmZaTnBYK201Qk9XVTRpWGJuN2hFZTNXcHd1?=
 =?utf-8?B?bGVOZ1N5YnpkVWpRRDJUcENLMEhMN1JFRXVTeTZxUlVhS3loeTNvYzFvTzY2?=
 =?utf-8?B?V3BIWmpiaU5samNYU2NDY0dkVUFnQXo5QlYxM2dSNEJrWTdqNWQ5TmxNWDgw?=
 =?utf-8?B?Ri8rN05CUXlidWpmRzRJZTM4dUN6eGl6MmRpdDE1NzRwMVkyWTZla2RxNUhv?=
 =?utf-8?B?K3pXbGN4UEltb091ZkVpMnRvV3JIZjU3NXJVUXJ3dzVFUXM3VEdIbUZQa2Y2?=
 =?utf-8?B?VTliM3ZMKzlDTElQaVFkaHF1WUs1bXFraVFPRlVXcXVhTVpsR0ViK0dzalBD?=
 =?utf-8?B?YzloTGJTaG05cGorL3hjRW5xaXBRTy9JdXc2TmduMUFUSFh3dzFHK1hZZGRs?=
 =?utf-8?B?Q0pFampDM0pFcHJicEdyTEdEVzFOT2lvMWFFb1UzMlpLVEVGeGRRMExDbEF1?=
 =?utf-8?B?QWUwNUFnc2tYdjNRTldrVlptbGdXdDlmbWZDM29mQTh1TVdnUjJlQ0FVUGh6?=
 =?utf-8?B?RFNxUDNkUDUzSE82VkN5NHllT2xtTGVLQ3B5UWNUcFMyOXE5K0FNOFQrbUd5?=
 =?utf-8?B?OHV5VlhuSFluMHA1blRFOTJ2aStGZkZJeU9SU1hCMDNpeWtuV0dUeDBhYms1?=
 =?utf-8?B?SmxFd0pWZnhjc1BUUjY4RG03ZkhKY29pNzVRYU1jREhkb0VOdU0xU24vb2dS?=
 =?utf-8?B?dEQ2dW5vVHhQRlFUR3Q0TFRYZDJVekVIYTlUaXM5eEtabHp0OVV1M3NDZXc5?=
 =?utf-8?B?NzFqTnk3b1E5eDFGVlVsdVpZVHNwY1hZMGJFWWlkV0hQd2xVZ3F5VUgrY1pz?=
 =?utf-8?B?RlVDTE5OUlNaVzhkcURPaWxsRk4yNWEwbWw0OFlNZ0t4MHhDWVEycC8za0FU?=
 =?utf-8?B?cWZUUEtsbEdYcGNRUDZSK3UzbjVhdU5sL01kcGVrclBxdHlHOVIxMnV2MDds?=
 =?utf-8?B?amFRSDBibHZkSjJhS2R5RHc1Y1JCWVVFWnBwUG9UYVMxS29odHpZMjhpempC?=
 =?utf-8?B?OUtEbHFhWTFDOU03ZUJ0cklwYzArc1c3aHhiV1MvRmo1UXRSa0V0cVlyanB0?=
 =?utf-8?B?RVVrbnJxQk9NZGFEUzFUUVV2QmdEakphaysvME1Kc2dQRWk2czYxWFNnQU5F?=
 =?utf-8?B?b2ZrUENCbVVOT0ZpZndOVVpkOGRlZDJseU53Nk0xRnlJdzh5UEJtRFhVZzJv?=
 =?utf-8?B?dUphN3J0ZkhCV09xQ3ZlNjdYSmJEb0l3OHVKSC9PME5OczNucGFtRWs5RDNZ?=
 =?utf-8?Q?Wm0DCxePl/2WY+Pf63FTObvUO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1e54a3-5d45-411f-073b-08dc709401c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 01:53:37.0288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0vJengu2MfniWuC73r3td3M8eaiKj/b9A3yFVuS0FdBuuc88AiX/eVCPH+0NTky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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



On 5/10/2024 9:41 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> Ok, I miss this patch #2.
> 
> And please merge swsmu parts in patch#1 to patch#2. (patch #1 : powerplay, patch #2: swsmu)

Thanks, will fix this when push.

Regards,
Ma Jun
> 
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Friday, May 10, 2024 9:00 AM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Ma, Jun <Jun.Ma2@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Ma, Jun <Jun.Ma2@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile setting on smu13 and smu14
> 
> 
> 
> On 5/9/2024 9:01 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - General]
>>
>> please fix similar issues in other xxx_ppt.c file together? e. g:
>> navi10_ppt.c, etc
>>
> 
> Fix codes for navi10,vega20, etc. are in the patch 2 of this serial.
> 
> Regards,
> Ma Jun
> 
>> Best Regards,
>> Kevin
>> -----Original Message-----
>> From: Ma, Jun <Jun.Ma2@amd.com>
>> Sent: Thursday, May 9, 2024 5:37 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu/pm: Check input value for power
>> profile setting on smu13 and smu14
>>
>> Check the input value for CUSTOM profile mode setting on smu13 and smu14. Otherwise it may cause out-of-bouds read error.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
>> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
>> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 5 +++++
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index e8b01662e164..6c24e2306383 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -2495,6 +2495,9 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>         }
>>
>>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>> +               if (size != 9)
>> +                       return -EINVAL;
>> +
>>                 ret = smu_cmn_update_table(smu,
>>                                            SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>                                            WORKLOAD_PPLIB_CUSTOM_BIT,
>> @@ -2526,6 +2529,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>                         activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>>                         activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>>                         break;
>> +               default:
>> +                       return -EINVAL;
>>                 }
>>
>>                 ret = smu_cmn_update_table(smu, diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> index e996a0a4d33e..4f98869e0284 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> @@ -2450,6 +2450,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>>         }
>>
>>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>> +               if (size != 8)
>> +                       return -EINVAL;
>>
>>                 ret = smu_cmn_update_table(smu,
>>                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT, @@ -2478,6 +2480,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>>                         activity_monitor->Fclk_MinActiveFreq = input[6];
>>                         activity_monitor->Fclk_BoosterFreq = input[7];
>>                         break;
>> +               default:
>> +                       return -EINVAL;
>>                 }
>>
>>                 ret = smu_cmn_update_table(smu, diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> index 0d5ad531c764..3f040a4d374e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> @@ -1418,6 +1418,9 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>         }
>>
>>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>> +               if (size != 9)
>> +                       return -EINVAL;
>> +
>>                 ret = smu_cmn_update_table(smu,
>>                                            SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>                                            WORKLOAD_PPLIB_CUSTOM_BIT,
>> @@ -1449,6 +1452,8 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>                         activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>>                         activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>>                         break;
>> +               default:
>> +                       return -EINVAL;
>>                 }
>>
>>                 ret = smu_cmn_update_table(smu,
>> --
>> 2.34.1
>>
