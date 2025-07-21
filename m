Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E8C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 14:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5E910E3A2;
	Mon, 21 Jul 2025 14:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Qa7zQgP";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B63B10E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 14:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmw2iITLkwfn4vE9ztwC361sBeJjFV6Cwhrnh77/r6K5Aa9gYgpMgxEShANrFNbkZ9L61GsxRBOVfR2GHh9q6xSNmd6JKnbRsBuhni5hT8JsV98kWBTgxb5yQsrigNjTuJI5ZWJiXpusTALMq/pDim1CNr1HWGOCeHIjGNwW4teQS9Pm4XP9ofjkxL0kglxxXs3LIUszA+OtV7dbvKh/RkSOzQbSuIRMlzDhj8eOpU7UAugvtR1AanlufuL0UgIYi7IEg86OVa85OnCBkUj02NOJnoxJuMPXcRZjwox/22u31eHuYRMq0GDo3w0TOam8vnTj1SbF7IjWmfJGiVK5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6ILHhi/pLN3V+apssz8KgAbNKv4LDvspzDim7bLZmU=;
 b=PKRh6duJJPpoxtEDxKVGZuyu8q6K4nWUOrwEMPJl2BT+PmqXVak2k73wdmwPx/dDXicyIGgnMVN/kGhbe93paMBtE4/uCOJv+NLSpaW2hgrVcVZBEjQ9UXFF/pXDKwxQ6DpPJIh1Con2cJ7/dAe6lBKotjC+TbIg19JdohcB2/ydJF4MeWs5IWhei/BmhCFsJMLj1AtMuFQRr/4iVXtYhOw3CW3PrqJ/gU6YhjOEJKrx21+4ccM9yI36kI2u1mwf72MPcroUssuqVVclmV7mzj6SHoB2JbUiYwBO9zgzNqYuw+iWriiDOO7m2KJHDkk6v3OXUalkNt5AVaFsU+5xSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6ILHhi/pLN3V+apssz8KgAbNKv4LDvspzDim7bLZmU=;
 b=5Qa7zQgP4uNgo25Sb378kU6QEKswkZAK9qsn3zXjmuzqK5NL9ABjJ/yMmrnOqnyC8yZwGMYicK1kMWKccMJxvXBSvT46tAa836Dx1VUyTOuVjJ+ejcv3t+MhfjIuZWjLPEBTTPpJntL25l0+Rb7s8Kf9P3COzcW/y9nTYyzU6Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 14:56:53 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%6]) with mapi id 15.20.8880.021; Mon, 21 Jul 2025
 14:56:52 +0000
Message-ID: <ea05ccc0-e020-4df0-81e3-ec035e53ba45@amd.com>
Date: Mon, 21 Jul 2025 10:56:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: return migration pages from copy
 function
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
Cc: christian.koenig@amd.com
References: <20250528171908.82639-2-James.Zhu@amd.com>
 <20250714124634.98951-1-James.Zhu@amd.com>
 <2eeb8cfd-20b4-4e6f-92a4-a6a4a2430e8f@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <2eeb8cfd-20b4-4e6f-92a4-a6a4a2430e8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::27) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bad08dc-42df-4c14-e6f8-08ddc866d3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QThzWUVKbXh2alJTcitQRlFxSEJ5OGRKZFdmUEkvdUFPYlVHTHJYQ2c4SGlw?=
 =?utf-8?B?UlJ0VXRhVGNqNTNQckN4bmRVbHpqOVB4VUc2U0ROTUZIUS9ETGxSTE82TUFI?=
 =?utf-8?B?NDhiOU1uZllCOVg0NnpXckN5dmZ5VGVwS1h2MXJiM0plNFh5T0FNbXUxb2xn?=
 =?utf-8?B?YUF0NXBRRlY2WWM4TjNoVE1CYUM1c1RPVTFyTkR3dXhwR0ZKRG82dk01bGp5?=
 =?utf-8?B?OUl5eDkyekF1VFYwSjBnSTQ2dFEyZU85Ui9OeG9CNWdmZFE1azBvMlQ0L0Vz?=
 =?utf-8?B?czFqYm5vcUZTdGJzSlc4TE9PTzd2djNqWnlvUXN0MmhzY1lZN0JvMEhaU1Q3?=
 =?utf-8?B?dmxEVWFMc1oxRUpQT2dSaVVndloyZC92Y0swdTA0UFRYK0RmQXcwaklMOGpV?=
 =?utf-8?B?R2l1dDZmTVkvZ0RzTXR0Sk1mZUI0TnZCaEpaQXJqVEdsWDdycGZUc3ZJTDNN?=
 =?utf-8?B?UGM2MExDa2FrOUdFQm8xTEJVcHp4eUpCR0w5VFd2ZUhmYWdSeWFuL2dDcFJr?=
 =?utf-8?B?ZEF1L0MzOEFUbEc5MldSU3JDZjRRcVEyNXFuay9LYnpGNGgxYkE0T1lmTE9C?=
 =?utf-8?B?dkp1aEpHNzJ5WnRMVVJ0MmdrZ29oY09Ka0lVaW80SFp2dmdEMmtqd1kyM2JW?=
 =?utf-8?B?MXEvL0p6R0ZJQ2UzL3I0bmpYTE5tc1ErUHR3OW5OMjZHYjNhMFlLelJ4eWZN?=
 =?utf-8?B?TnlXSWUyeWtteU53dW5pNnJvRllFQ2ttb2FNaVMzcXkyNjYxRC9Dc2VKTzlH?=
 =?utf-8?B?ejRmVWlHcXFQRlE4SUxuVkNrb2dUTm80YStLWGpBcE1qcEFSTjBTSEV0Q25S?=
 =?utf-8?B?NmFsZnB6TE9DT2UrSXRGVFZhSXBhczcvck9UV3FEQ3JrRHJFRTRmTHU2U2Zz?=
 =?utf-8?B?b2hLM29icE5aUUZZSnNrQU1XNjJ1blppSVNjSTM5MVNTQS9tYjN2Q0hHajRZ?=
 =?utf-8?B?QnEzT3lxVVB6RFo5M3ZHNm9yUlpHdW5iaVc2bk9EWHoxV256b0xLRHRvSXV2?=
 =?utf-8?B?cDRjejUwZ3hBdS84c3hreVA4MjFackF1OUtNWGM3cVd6VFNPSS9odGhldU04?=
 =?utf-8?B?UDhyOERSR01iQUFFaUZvZXZFY0src0FuQ0w2eVB5NzRFclloNkoyNGlVVnZo?=
 =?utf-8?B?eEpPVExkVmI4TGdseS85WEdRWjgzRlM0VC9nR1dUZm0vNmNicHpBajhpUksv?=
 =?utf-8?B?TnRJUEE3QWs5OC9BUmUzNlFzSEIySUlTNWcwWkdSZmVVdlVYZmhJNlpsV3cv?=
 =?utf-8?B?TVZaelFCb3hmU2g3UlNZZmZjOFN1ZEFLWjNlZlM2NGdEc1RiQ2Ixck13d0ow?=
 =?utf-8?B?QzF0OXAzMytqTzVmMnFTT3pQSVdiRndHaXFLZkI0WnpUa2RjU3RzaE4rZDMv?=
 =?utf-8?B?N2FVeHlsWEFCRTczbUgrZmZKaGdrN2lDTUZMNkFhSEF5MGlxekIrSjAvZXRa?=
 =?utf-8?B?cVVSeTlyTHFya2dLdlNVaFNMdmpNZzgva0RGNFpwbi9iYy9UTlh0eUVsVVNu?=
 =?utf-8?B?cU5jM1lIUjJDZi9KY3pTazZHS2lsNXI1d2NXUWhVL3pPWk9FbTltZnY0SDl3?=
 =?utf-8?B?UHVDdDZ3b2hRdDdKSDZ0LzVqaDFVNk9qeGZaYmFIc0NtZWwxbWliYmVtdnIv?=
 =?utf-8?B?dDkrSnNlUS9LM29ORjI2b1FGRitJOHRmeG5TRU9VRXk1ZkZ2azZGMzdxVWRw?=
 =?utf-8?B?RTZ2R2JvQ0tqNEFucGwvYlZrdEJwS3BnemhYd1E4aWVLNEhKaHAvRXByczB0?=
 =?utf-8?B?T2JFOXlwcFVtdklmbWdNdXlUZ20rQTQxc2I1VzZ1UVlwWUdIN3B6dVRhRGRM?=
 =?utf-8?B?VzZid1A2SXd5Uk5TQVRRZHpWSGtldndjdmw0U0d5eUoyNkZqcVlHRzlYb0Nj?=
 =?utf-8?B?R2g3ZU40aVBpT1hIWUJtbEgvV2EzSGt0azh6MGQ0QmRROXFlZTU1OERFa3U0?=
 =?utf-8?Q?g2JLjn330jI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFZMnd2UFhOR1R5M2pEbzFZTmFyVTJkR1ViQ2tlSXBqMXlEb2dXRWVKZE84?=
 =?utf-8?B?Rkhtbit2WUlOMDJmLys4eHJFT2lBSVFVOE9DOEVUcDVXV0tIU1p3cW1XMHFI?=
 =?utf-8?B?QXJITzFueDdBdUwxTWMzbWNwRCt4UzNITTZ6S1I2aVFSY1UxT1ErczNlRito?=
 =?utf-8?B?YndtejlRTkNtNmF5NERicmVYZDNtVllzTE1pT1l0VHN6SnhqSGNSeWlVMlpW?=
 =?utf-8?B?OHdyY21US3lSUTZnODFiclNrVFA2QWpsN3BTa0VUZUsyVXMycEtUazFickEx?=
 =?utf-8?B?SkkwN1hzVmxnaGtSa20xS1RWOWZMWFRIR2JFWFNVMGpPNFdLZ29OT1pTTUZr?=
 =?utf-8?B?bE9MS2loakFSVHNLRlVoYnNSdmoxRDVoVjlmdDJxR2w4WWIzTnkyWm1iSnBR?=
 =?utf-8?B?UTRiYUFCdmxCc3hFUkt2S25BOERjS29QcFdJcnE2R1dJd0k5QVFGVU9rYTFD?=
 =?utf-8?B?bG9SS0NGTU5EeFU4TEJadE5GQWw4bnBxK2ZySUtiSU8yNDF5TjVmK0N2QWZ0?=
 =?utf-8?B?TW9kQ2h4MzBWejd3YVhJcEpIK1laNFhvR0I2N3dEZXIyeTJ3RDFGcmpyRTA4?=
 =?utf-8?B?YUFWWEF5Z1ozUlAzdzdET0JLbFh2OUlURUR3QVd0NytRMHEzMVh0NVh4bkdL?=
 =?utf-8?B?YXFtYTdiZEtvazlzNW9UWWJpa3hVb3VNL0pyUjUrb0ZjaG5GeTQvTWpYM084?=
 =?utf-8?B?NmdicVduclF4dHY1bHZ6cTkzQ1JoTExRQ25yZi92cTJoWU9ZNWZKOTZFSmt5?=
 =?utf-8?B?dzlra0F1b1hPRDZsdUFFQ3VhdFovRXEwclVtWWJtT1ZkNWg0RDZsdjdqcU84?=
 =?utf-8?B?aUdHSzVxNmlrS3llekd0bTJhRElSM3lRTDVrak91cGRzOFdJS1lmcXNndTEy?=
 =?utf-8?B?WHhoNHA0UlJaWUlRREJWVjNYSUNaRFhKa1d1aTQ4ZDNKOFpsckFSc3M1ZEVh?=
 =?utf-8?B?RWlmVGlxNnF5aTlDdk9GQ1RDZnc3aGI0bG5laHU3WElIOVprelRjWWt6SEs4?=
 =?utf-8?B?NDRicFRmb2Rkc1VHWC9wWEpyMHlaMXp5azVWYXdhR0gwZllhUmJ5azBhNm1l?=
 =?utf-8?B?TWpKRGxvZ29XV2VxaVV3amhjVmt1V1g4c0pGcGRSUHNxakF2aVdqRm1ncnNC?=
 =?utf-8?B?YzNvNlluZE44N2czY01VTGc1V0x0NzFRT25xazVaS1E2Q1dzdFJEdEhUblR3?=
 =?utf-8?B?dVVmb043ZElYejFyaGpIb0xuV1UxV3ZWOHg1Y1RJNnVhR09OTTFTbDBkeU5p?=
 =?utf-8?B?RW9DdHRpVnFtK3hyK1QzMzE3UFR0VkJwMXNSSm9aT2J0KzNtbG5LUTltcVBY?=
 =?utf-8?B?NVowQ3c3WEFpM2JKaSsyT2RQTXRSUFFaU3hNS2lvVTVHUzZTVEVFeHQwYVM5?=
 =?utf-8?B?SHJBTzFjK3RUOHBOUDVlQVlmM2NnVU15clBHQTRZT0tVa1FaejRwVGRTdHRF?=
 =?utf-8?B?bERFbFJobmp1QXArL0x1Z2V4UFhQcERBQk5MZXNwTzhMYzBvTmRoTXZFUnRN?=
 =?utf-8?B?d0UxYi9iUDl0SGtKL1N0S2k5NW9OOUZvUHZEdmRGaDFkM1RZeTVndHk5bDFC?=
 =?utf-8?B?MUtUa3RtcDc2TDNlRW9CUllmRDRCV2txNldOT0I2QVpRSDg3ZDZ3a1pUUmFD?=
 =?utf-8?B?MmFpdzREdEc1MWdxV1lEMWpCVUZ1N1N3S3AwaEVhZkRMTkE5ejIwTUZxYk55?=
 =?utf-8?B?VUVES253Z1NuQ2l1eTlBbGF1aGwwaVEwdmhzOTRwMGVHUE54eU5oZFRDYnFP?=
 =?utf-8?B?STNNQ2tTclBGc0M5aUxuR3Bnb05ndnBmMktWdWs1TUtDa2xoUkl4OVVTUGtm?=
 =?utf-8?B?bHI3M2h5dHU1cjZsS0Jnd0VoQVROTFZwNlBoY2lEdUxLUkkyK0FoVjY2WmhU?=
 =?utf-8?B?RTBYUzhIdHMrTlR3S3dFVXA3SDFaTFRmK25qbHJGUVhVby90Q1ZwaWRkSTFS?=
 =?utf-8?B?UmRRV0JXTDNOMnZLd25oYzFYRnE0NnFkZmFlR1hoVHNrUC9uQTl6NTNVSU5W?=
 =?utf-8?B?eGcxeEVnQ3R6WlBHVkRjRldCdG1UdCsxMVA4MEhraTVrZkZpaUFHUkJVcWR0?=
 =?utf-8?B?YWsvVDZ3WFFjZ01vSCtlSVhWSTNZM0FUVkJuMDRDQXVQNzJaOXRzVi9BclFG?=
 =?utf-8?Q?sg8R9p7ukSi+kRl9PywzAwoHI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bad08dc-42df-4c14-e6f8-08ddc866d3e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:56:52.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW8yL8lJk/4MUqV19PilyPzCvmx86TNekw5dYvhmqQ2009f1g4FEVpyyi2OUz80a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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

Hi Felix

Thanks!

Best Regadrs!

James Zhu

On 2025-07-18 18:09, Felix Kuehling wrote:
> On 2025-07-14 08:46, James Zhu wrote:
>> dst MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit
>> should always be set when migration success. cpage includes
>> src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID bit
>> unset pages for both ram and vram when memory is only allocated
>> without access before migration, those pages should be count as
>> migrate_unsuccessful_pages.
>
> I think the patch is correct but I'm not sure I agree with the 
> explanation. Pages that were never accessed (and are not populated in 
> system memory) should be counted as successfully migrated. It seems 
> they were counted as unsuccessful by the old code.
[JZ] Yes, yo are right. I give wrong expiation . Since vram_pages count 
the un-accessed pages in dst migration,
>
> Some more suggestions inline.
>
>
>>
>> -v2 use dst to check MIGRATE_PFN_VALID bit(suggested-by philip)
>> -v3 add warning when vram pages is less than migration pages
>>      return migration pages directly from copy function
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 44 +++++++++---------------
>>   1 file changed, 16 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index f0b690d4bb46..aad1346bde79 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -260,29 +260,15 @@ static void svm_migrate_put_sys_page(unsigned 
>> long addr)
>>       put_page(page);
>>   }
>>   -static unsigned long svm_migrate_unsuccessful_pages(struct 
>> migrate_vma *migrate)
>> -{
>> -    unsigned long upages = 0;
>> -    unsigned long i;
>> -
>> -    for (i = 0; i < migrate->npages; i++) {
>> -        if (migrate->src[i] & MIGRATE_PFN_VALID &&
>> -            !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
>> -            upages++;
>> -    }
>> -    return upages;
>> -}
>> -
>>   static int
>>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range 
>> *prange,
>>                struct migrate_vma *migrate, struct dma_fence **mfence,
>> -             dma_addr_t *scratch, uint64_t ttm_res_offset)
>> +             dma_addr_t *scratch, uint64_t ttm_res_offset, unsigned 
>> long *mpages)
>
> You could return mpages as the return value. That would match the 
> convention of svm_migrate_vma_to_vram.
[JZ] Sure
>
>
>>   {
>>       uint64_t npages = migrate->npages;
>>       struct amdgpu_device *adev = node->adev;
>>       struct device *dev = adev->dev;
>>       struct amdgpu_res_cursor cursor;
>> -    uint64_t mpages = 0;
>>       dma_addr_t *src;
>>       uint64_t *dst;
>>       uint64_t i, j;
>> @@ -296,7 +282,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>         amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>                npages << PAGE_SHIFT, &cursor);
>> -    for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>> +    *mpages = 0;
>> +    for (i = j = 0; (i < npages) && (*mpages < migrate->cpages); i++) {
>>           struct page *spage;
>>             if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>> @@ -304,7 +291,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>               svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>> -            mpages++;
>> +            (*mpages)++;
>>           }
>>           spage = migrate_pfn_to_page(migrate->src[i]);
>>           if (spage && !is_zone_device_page(spage)) {
>> @@ -356,12 +343,12 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>   out_free_vram_pages:
>>       if (r) {
>>           pr_debug("failed %d to copy memory to vram\n", r);
>> -        for (i = 0; i < npages && mpages; i++) {
>> +        for (i = 0; i < npages && *mpages; i++) {
>>               if (!dst[i])
>>                   continue;
>>               svm_migrate_put_vram_page(adev, dst[i]);
>>               migrate->dst[i] = 0;
>> -            mpages--;
>> +            (*mpages)--;
>>           }
>>       }
>>   @@ -441,13 +428,12 @@ svm_migrate_vma_to_vram(struct kfd_node 
>> *node, struct svm_range *prange,
>>       else
>>           pr_debug("0x%lx pages collected\n", cpages);
>>   -    r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, 
>> scratch, ttm_res_offset);
>> +    r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, 
>> scratch, ttm_res_offset, &mpages);
>>       migrate_vma_pages(&migrate);
>>         svm_migrate_copy_done(adev, mfence);
>>       migrate_vma_finalize(&migrate);
>>   -    mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
>>       pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>>                mpages, cpages, migrate.npages);
>
> Maybe change "successful/cpages/npages" to 
> "migrated/collected/requested". I think that would be a better 
> explanation of what these numbers actually mean. 

> [JZ]  Sure
>
>
>>   @@ -580,7 +566,7 @@ static void svm_migrate_page_free(struct page 
>> *page)
>>   static int
>>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct 
>> svm_range *prange,
>>               struct migrate_vma *migrate, struct dma_fence **mfence,
>> -            dma_addr_t *scratch, uint64_t npages)
>> +            dma_addr_t *scratch, uint64_t npages, unsigned long 
>> *mpages)
>
> You could return mpages as the return value. That would match the 
> convention of svm_migrate_vma_to_ram.
[JZ] Sure
>
>
>>   {
>>       struct device *dev = adev->dev;
>>       uint64_t *src;
>> @@ -598,6 +584,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>       src = (uint64_t *)(scratch + npages);
>>       dst = scratch;
>>   +    *mpages = 0;
>>       for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>>           struct page *spage;
>>   @@ -646,6 +633,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>                        dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>>             migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>> +        (*mpages)++;
>>           j++;
>>       }
>>   @@ -688,7 +676,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>   {
>>       struct kfd_process *p = container_of(prange->svms, struct 
>> kfd_process, svms);
>>       uint64_t npages = (end - start) >> PAGE_SHIFT;
>> -    unsigned long upages = npages;
>>       unsigned long cpages = 0;
>>       unsigned long mpages = 0;
>>       struct amdgpu_device *adev = node->adev;
>> @@ -745,12 +732,11 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           pr_debug("0x%lx pages collected\n", cpages);
>>         r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>> -                    scratch, npages);
>> +                    scratch, npages, &mpages);
>>       migrate_vma_pages(&migrate);
>>   -    upages = svm_migrate_unsuccessful_pages(&migrate);
>> -    pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>> -         upages, cpages, migrate.npages);
>> +    pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>> +         mpages, cpages, migrate.npages);
>
> Maybe change "successful/cpages/npages" to 
> "migrated/collected/requested". I think that would be a better 
> explanation of what these numbers actually mean.
[JZ] Sure
>
> Regards,
>   Felix
>
>
>>         svm_migrate_copy_done(adev, mfence);
>>       migrate_vma_finalize(&migrate);
>> @@ -764,7 +750,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>                       node->id, 0, trigger, r);
>>   out:
>>       if (!r && cpages) {
>> -        mpages = cpages - upages;
>>           pdd = svm_range_get_pdd_by_node(prange, node);
>>           if (pdd)
>>               WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
>> @@ -847,6 +832,9 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>       }
>>         if (r >= 0) {
>> +        WARN_ONCE(prange->vram_pages < mpages,
>> +            "Recorded vram pages(0x%llx) should not be less than 
>> migration pages(0x%lx).",
>> +            prange->vram_pages, mpages);
>>           prange->vram_pages -= mpages;
>>             /* prange does not have vram page set its actual_loc to 
>> system
