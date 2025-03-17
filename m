Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B9C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 17:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6749310E145;
	Mon, 17 Mar 2025 17:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ou4AKpNu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927C810E145
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 17:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb2CSuvfgbE6atJWgjM0UvW7xsCsidJxg4eEWB1CttAXTIoTN+a9f2yBOoF4TN072UMcYXUdk6Ds7bbSrNLHfv8ivgsb7NzUKS1jodwp5kkEpEIWcuBHzcIhlg4gPKN+JNlLgPHzz+CAjizH1jr/WNaGcXX0/O5N+axkMmU6azYTTFUDxmehmmUj792ExRoRyzN8ba/WUeHi5ckyL3W0AQS3cBB6Ss306WkYi+ERLOeP2+03tTfGBN6S3+9r0ozJZeM+6Vn+7H/ue82xcb8PySwXrd6g9LcVAUCkhyqgDq0q8yNrsHtdDn4XNNMb7OygPdsvXXd7b1aXPyxPAkgd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI2bzUXGNFwT8BR/ckLHYUERWC6js/LjdG2fDPVHqjY=;
 b=YueYT1mXEMMGQ4UltAnwSAgOXYkV1Y9RAxJwFimKhJCxbw0na1UKYFuKFgqehci/T2rJVQxDJ54RChQ/FRYk2YCzZLgosNxI+hyxjrNO1QG0Qjq8/9iaCTZb8p42H5vQ+IAR4BPY1V4ceVERMW6tQZFn5JPh2iXH2ZMr9w4p1BpZmOF0UnPUG12esWHbgqLa0A4jFF5NK6qBimIjSwU6ZwzCuKVxqGiDFz+3dSQcul5xTmvlZJZB3lpMmJqk4/cgP07KKc7+h29N/BKj4T4RABLp5rcEky+6NOzY/eFaI+3RnFYvNwmkc1RPcxu7o608HLY91T3MVcwozFSwCAkbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI2bzUXGNFwT8BR/ckLHYUERWC6js/LjdG2fDPVHqjY=;
 b=ou4AKpNuH+cvOJs4R7zS/pj3xK1EI/SYJLIUlLBlyA9NSiPUj9TCE9xSKzxxw5CYtqHJBGMv2WsArDejJiNChm633yT5WTZLW1EL9WTl5fd1Rm+EwMd0dcPU71YiEJmCJmiVWtHCYPstDnpYPUmlvxEPxbMeqJiFO1cQLYhgOzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:49:43 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:49:43 +0000
Message-ID: <d3c2f107-3107-43a0-9b18-f8c41aec7766@amd.com>
Date: Mon, 17 Mar 2025 23:19:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
 <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
 <6face0d4-8adf-488f-84c8-12a012bdde15@amd.com>
 <6fa6d314-3da3-477f-bdbc-31632cb3c774@amd.com>
 <53f74142-c74f-48d8-a3bc-4f5f0e65ab25@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <53f74142-c74f-48d8-a3bc-4f5f0e65ab25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0846d4f7-3d93-474f-62a0-08dd657c1931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkE5amxUVzI5RXQ1bXVqU3d6dUNhaEZOWFdnWDlVbmpIY3JQQk1MWUpQeWpI?=
 =?utf-8?B?TWNHbW05ZkZaOXU4R0cxL0UvcHBEZUpaYnJpNXF6ZW9MQzd1N2Mza0JzbEhL?=
 =?utf-8?B?bDMxSUR0aGpYYTZ6UklYanQ3SXR4Vk9URXRPZ2tveWJIbDBNdUM3alVmaEVU?=
 =?utf-8?B?NzZOaU1OTm1RMnNVZCtBbmRQVmpYSkd0OGNMbmNtZ3RaMFdKUXlMLzV5eHBY?=
 =?utf-8?B?Mkk5ZkhnZ0VhdkdwT3Y0UGFXWnlMQ2Y3MnBzMEVORjZJajREbGRUVWI0UDJp?=
 =?utf-8?B?VVRqQldMdW9FcE9QMlBYWDNLYXFCOGRJbGRwS0ZmSjJvNGVpalo2dnhkQnpj?=
 =?utf-8?B?YmRTSGVVdm15Q0dVMWJvSzh5U25sb0NJSUdjdCtmRWlvanhNenltZHhNK2Rh?=
 =?utf-8?B?SktTYThnUWg4RjBWYldmRExOc3dzR2dsbGw5dUdER1ViYTBKcnJtalNlRXh0?=
 =?utf-8?B?d3dkMzZ6dWpvUWNRd1dFN292NDg2SmJUdERETEY5UDk5ZXF3YmlVemxyRjF0?=
 =?utf-8?B?RldmNzhqL2ROM1FHbjNnbnYzVzAvbFQxMWxna2lTUVgrcXRJTHN6VmlGTXZH?=
 =?utf-8?B?LzdIaW1zdmN5c1pDOXZ5NGpWWFFINmVoUnFnL0pKWTRNcGhuNUt5NG9EMnMv?=
 =?utf-8?B?Nmd4T3QvM3hFU2F1YzQ3QWJFam9Tcit0M01aMEhkZVlteFhCZStDbEk0bXgx?=
 =?utf-8?B?SElKT0Vad1hPTWhHUEFHb0JMUXcrbHZZWW1kZDd0VytVTTVRM3lHOUJIajU5?=
 =?utf-8?B?YmJLblRzK293dytPRE5hU1hLL1AyOVBwSWh2OVo3ZmxSQWxESzFnOXNCMW02?=
 =?utf-8?B?eXZoWDJpMFVMaXhycENyZGx3cTBjVEg1cmk1UE52ZjM5S3Y2N0ZHSFpaZGJO?=
 =?utf-8?B?WitFM3pqaUdRdVBhdzBnUmR3dUd4RGp3dkxMR1JzbnNYRDQvTHloQ1hrc25L?=
 =?utf-8?B?UURrdjFoeHBhQkx4bStOOGt1WVFjeFRUb3ZyL3paTEFxcDBNWEh2RXdUSmFP?=
 =?utf-8?B?dDIwNktxbGh3U1pZL3RUc3k1Y2YwY2JvY1JZUnZFKzFNOGNENk5uK0VTNW5W?=
 =?utf-8?B?cmNsblo3elpzaXZTemVLS3hKQVJIWTROcHE5YXE3RnF5QXI3YklSVzI2US9S?=
 =?utf-8?B?K25jM05iRkNTdFJyR25kNFdENlZLWmRWUUIvbG1hZkNtcCtIWUY5WU9BRW9Y?=
 =?utf-8?B?UkhlUyt4Y3lIQ1RmZmlKanFNdnlHbE9ZNG1rd1VpSloxWnRsTEVLQ0krMVZ2?=
 =?utf-8?B?SUMzTXBPSkw5OHZNSWNhTzlBWjM4R01vMmNCNHkrSld0MGcyL0NBRzJKcm92?=
 =?utf-8?B?eXFjUjJwSVNHSGphRnhySnVONkFLOXVnM3RId3Y0c0hQaDBjUkttTHpINDNz?=
 =?utf-8?B?dWpNMnJyeEszOHRZRVMwbW5FVEcxVlhzSkUvZDR1QWEwM3k2TnNYYUh6Qm5k?=
 =?utf-8?B?RElEVzZGU25kZGpNQTVxSkpGVGN0eGJxWWQxOXVCV0ZsTWxIVUsrL2Rkd2JX?=
 =?utf-8?B?ZjBDK0d4NFdNRmxpUkFLa0dkb3Q5R2ZnU25POVZ5ZTIyam5OOG80S0F2eWx0?=
 =?utf-8?B?YkxlZ2lvNmlENTRHUWFKMC9zd0N3SHUxTy8zOTR6MUNTNlYrVkJtVGVKeloz?=
 =?utf-8?B?TGFxYW1JTCs5RWwvcmQxR2xNdVlUcGRkUW1uSHd5YUM0K1k2S3h2N2FNOWZO?=
 =?utf-8?B?MnJSK002WTFmZjZuMWZpYVQxT2IvakhRZ0w3MzlObGFHVEloZHJzd2pnaWFo?=
 =?utf-8?B?U20vN2EyMXRtWDdvOTQvMElKQnRFcytCVW1EN1IreXZUQUZ6ZTFHT25LSGxC?=
 =?utf-8?B?YVFGVTRWSGs5OHFITmVKbUxUMEQwSHBQMkc2SDJuZXE2NDRJYTU1UGc4WStk?=
 =?utf-8?Q?yQBzWRfoP62lQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENxRXI5WmZMM1ZnZDNzYU1GWm9WVGZvWEtiZDhGMllBUDh6eERQSmFINm1J?=
 =?utf-8?B?aTh5OTZzeWFyditEZVdJSkJjREplUTJ1RHpaeURIWVJhRGR4eWNwS3pyUm5G?=
 =?utf-8?B?Ni9kSmQ4aktieG5zdjVnZGVyemlzaTlrTVBkWlFBa1c0T3llZGVnUlVQSnRa?=
 =?utf-8?B?Z29DTDllcXI0YUxubzNzRmZya0RodWlRKzdVU0Z2OS9LYW9mV3NSUXNXWS9S?=
 =?utf-8?B?eHB3SmF1TytMWXR4clVlbVB2UVR1alNVeFJ5WVpldlJNc25FYmJuZ1M5VFQr?=
 =?utf-8?B?Z2toY01VN1RzcTMvSWN6Y3F5cCtqTGJ2ZnRoRDU0ZWJrY3NTUzM5U3pTN3JV?=
 =?utf-8?B?NmZ3bWQwTXRKR2tZS2tIQ3NwTk9CZXQxUWpvQjFYUU9GS1JtejlYUS9VY2tV?=
 =?utf-8?B?VTBGVUVvdGZRSXp0c0drQzRoWnhlVDZXL1hBUUxBODVRdDhiYVVVYzdrMmtk?=
 =?utf-8?B?Y2p4Y3BwZ1VSa1NpRjY1V1ltTjBCWEtzRytiaEhmVHBlR09kMEN5OE02ZU5Y?=
 =?utf-8?B?bUhkQ1BTQnRRWVFpZEZ5b3Rqa1FkMTRHNVBmQU9wVzJGa2Vkb3FTMkZ3RW55?=
 =?utf-8?B?Q1lMUkJnajUrMlNZcnJjWlV0ZW5SSit1Q0N3aGhtOHZFS05SaXBmVmdjdXh6?=
 =?utf-8?B?dUhzdUlRQmNVYy9BMHZWa29nRkNELzZuT09uSFIxRnBkT2ZIcUJSaldlMWdv?=
 =?utf-8?B?MTFkNjc3WXIrbVlvblZyR215Nkd6b3RWTnV3YzREUXgvV1AzTHZtU0w3Qmdq?=
 =?utf-8?B?V0djRXpWclBxVnEycXZxdE9TUHlRYXdFU09KNXhXY0tlbldIZmlpbjZGN2Fk?=
 =?utf-8?B?MTdTdmJnL3lQT1lGNG9Tb3prbDhvd2Y2S0ZzazhZM3F4M29DVkdKQjJmTjNZ?=
 =?utf-8?B?WVEydmhDcjNhcGxTK3JrdVlJL2lYVEIxKzR3dEY1a0lHMjF3VGs5SEZTSThy?=
 =?utf-8?B?WE52aUxOdkg0QlpIbVhxRUtzOU9tYmF5Wktydm93SlNXRW5McVZTTmJua2xN?=
 =?utf-8?B?RzBtMzhCdU13ZXRlWm41UDJ3cW9QVG80dHZ1NVU5aDg1UDNvdExxYVdTTDJ6?=
 =?utf-8?B?RVUvTElLVEVNVm1rRWljTFNnNEw1cy9BcEdnZXFZbkNXZ05XUjJTYUFWOVpm?=
 =?utf-8?B?WHlGMFVscXFXOFl3TVdFalMrUWpRRzI5WE1lM0xoNG0yRWxmREQ4M1BRSXdW?=
 =?utf-8?B?VFYwUTc2SG9YQ21LRkFvNERlY3U1dXJsTk5LdGI4Q1NmRG05M1ArbFJ6Nit5?=
 =?utf-8?B?Q0Q2VUNKbTRHM2RKMGY4MmRtcndkTkFHaU1XTWRnVG42ZW5WcHNpcWpoV2lB?=
 =?utf-8?B?ck94d2pyeU5oc2pHdXZvais3WUdSeHdkdDFvM1g3Mk5TNmNnQTlKdCtZK0JC?=
 =?utf-8?B?YnBiNFk0aDNkWS94SEMrdTJ1OGkwZWpiR21nV3RxUXc0UGVGMGgzaGhHdVpR?=
 =?utf-8?B?emxaTTMrNFFrWndzRythNGw3WTRyYVNvWmtCQldSRGYrNEY3cCs1UXBXTDA0?=
 =?utf-8?B?elA4NUlwT2NzcTc3WXYvc1Y4QS9NdEFac0xPLzFaNGxremU0b055c1hvVERV?=
 =?utf-8?B?SzIzTVFEMnVHdHZRU0I2U0Izc0k1MkRYUG80SFdNd2k3K3JrcEh6dDBaWnJk?=
 =?utf-8?B?cFVaTVNpZ0lidTd5M0dpRDZ3VFFFKzdzYmJFWHdabjl1MmNXaWtkWmtGeGpl?=
 =?utf-8?B?bVZScGxiN1lpWEJXOGtyUllsbG1mRXdRREVNdmYxVzdxRCsraGIxWjlLbUpv?=
 =?utf-8?B?OEszamdlVndDM3NYRDZLaUpIVFEvaHB2VG1ZSSt2cnJqNHd1bkRFTXNQN0da?=
 =?utf-8?B?Qk9nVnlzQ1o4bUZIMTRwVzlPOEg5YmNRcUcvRFNZeWVsR1lRbGtySnppUmFY?=
 =?utf-8?B?YktmN0p6WkFkZ1U5WTY3cVhRZ2ZLWjNaUjA4TXByQmowL0hIQTdBZjd6SCta?=
 =?utf-8?B?MXBSSjhNUSs1WU9BZjBXRCtOTWhtTzBBOHRMTzZZTlQxZzF1VU1neFZoMy9M?=
 =?utf-8?B?TTFBcEhGL1hpZEMycG1EUWs1SUg3QVpFWWhZNXl4Q3BlVkQ4MHVIS09IZFZI?=
 =?utf-8?B?QXFvY1FQRGkrb0N5ZnRpenRIREVZdWpnWnF6UzdaM1JvZjQwa1NLNlpOTTJV?=
 =?utf-8?Q?JhYW7WqCgiLxagX3WHiGLy6aH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0846d4f7-3d93-474f-62a0-08dd657c1931
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:49:43.2536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrDHRMkUyIvyI8FJW5d5WjSafhr5fawbXg63Th7MEQDZPpbApAyxJhzlPg2jAcbp+Y/pbXVOK2O/OeIGkq9N1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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



On 3/17/2025 9:09 PM, Christian König wrote:
> Hi Sathish,
>
> Am 17.03.25 um 15:40 schrieb Sundararaju, Sathishkumar:
>> Hi Christian,
>>
>> On 3/17/2025 7:33 PM, Christian König wrote:
>>> Am 16.03.25 um 16:36 schrieb Sathishkumar S:
>>>> Wait for vm page table updates to finish before resuming user queues.
>>>> Resume must follow after completion of pte updates to avoid page faults.
>>>>
>>>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>>>> amdgpu:  in process  pid 0 thread  pid 0)
>>>> amdgpu:   in page starting at address 0x0000800105405000 from client 10
>>>> amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
>>>> amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
>>>> amdgpu:      MORE_FAULTS: 0x1
>>>> amdgpu:      WALKER_ERROR: 0x0
>>>> amdgpu:      PERMISSION_FAULTS: 0x5
>>>> amdgpu:      MAPPING_ERROR: 0x0
>>>> amdgpu:      RW: 0x1
>>>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>>>> amdgpu:  in process  pid 0 thread  pid 0)
>>>> amdgpu:   in page starting at address 0x0000800105404000 from client 10
>>>>
>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index f1d4e29772a5..4c3edd988a05 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>>>>    static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>>>>    {
>>>>        struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>>> +    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>>>> +    struct amdgpu_eviction_fence *ev_fence;
>>>>        int ret;
>>>>          mutex_lock(&uq_mgr->userq_mutex);
>>>>    +    spin_lock(&evf_mgr->ev_fence_lock);
>>>> +    ev_fence = evf_mgr->ev_fence;
>>>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>>>> +    if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
>>>> +    /* Wait for the prior vm updates to complete before proceeding with resume */
>>>> +        dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
>>>> +                      DMA_RESV_USAGE_BOOKKEEP,
>>>> +                      true,
>>>> +                      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
>>>> +    }
>>> In general I agree that we need for PTE updates before resuming userqueues, but this here is just nonsense.
>> Okay, but the reason for adding this is, I was able to verify that corresponding vm sdma job fence is signaled few microseconds after the resume queue call in the timeline in tracing. I verified this by adding resume trace point after amdgpu_userqueue_validate_bos has completed (hoping this should do the waiting part), but observed that resume timestamp is before the sdma job fence signal timestamp.
>> Whereas after adding the dma_resv_wait on root.bo, the resume happens after sdma job fence is signalled, and was also able to see that page faults stopped after adding this check.
> Good catch, but you seem to have a bunch of misunderstandings.
Okay Christian, Thank you for explaining the details below, will try to 
understand further based on your inputs, that's a lot of valuable 
information to ponder about and understand for me, thanks again.
>
> See the queues are suspended because some BOs are moved to a location where they shouldn't be (e.g. VRAM into GTT or even SYSTEM and GTT into SYSTEM, etc...).
>
> The function amdgpu_userqueue_validate_bos() moves the BOs back so that they are accessible by the GPU again, updates the PTEs and then waits for the PTE updates to finish.
>
> It is perfectly possible that there is a bug in amdgpu_userqueue_validate_bos() and we don't wait for the PTE updates to finish. You should probably double check that.
Okay got it , will double check this code and will also try to 
understand the below 2 points and think from that perspective.

Regards,
Sathish
>
> Alternatively it is possible that PTE are made while the queues are disabled, but we don't need to wait for those to finish before re-starting the queues since they should be explicitly waited for by userspace.
>
> In the kernel we only need to wait for all implicit PTE updates triggered by kernel BO moves to finish.
>
> Regards,
> Christian.
>
>> Regards, Sathish
>>>>        ret = amdgpu_userqueue_validate_bos(uq_mgr);
>>> This call here is validating the BOs, updating the PTEs *and* making sure that we wait for this update to finish.
>>>
>>> Waiting before that just doesn't make any sense as far as I can see.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>        if (ret) {
>>>>            DRM_ERROR("Failed to validate BOs to restore\n");

