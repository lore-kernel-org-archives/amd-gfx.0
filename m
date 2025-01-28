Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A24AC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 14:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B1510E052;
	Tue, 28 Jan 2025 14:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ky0P7QUm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F5410E052
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 14:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2GczYwYZ5vJ4UP4xK6vevQbZMDhW6CZR2SlvBxU6wwS/SK3JtQPjfeKn0UM66FW6t9nqI4Y+4JHNDaOdJuAYDOm4zZ5jZPv/5Mg7Z4Oiz/Ye+vlJK+jV0tstNgqMRz+qPiqrnG3wW2DIj7i3mpRB06IZPYSUumWEiXi2GGSu/QxYKwOGY0I6EnYi+ybgzmpWOrG7n6EgNTvIpRDTdPNB2RvzdbfAcyxB/tIjNH0pVruWjrtXF6PIRJe6Vz7p25CkjUvJ2LxVgPv1eVIjuAhQz2cM91ac7J3F4d6M5mdjC1luItMXBC3OHv85+xoHIz5Fz4+z6WIOP0p1RFKzSniWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwW8VTCWrI89lljfofA4leBmGtvK9N4SYGqW1ajpCp0=;
 b=WTtp3/moQ3yXe1AVACQvLafSCVo3k/fC1d1Ak09iEBzSOVhKa8bLNhuzBjBuju9mibqIkDLARt7Pxp5swsTzh18E5uqjGGDEqpTyn+jcdHHI4XR4vYnOoZYfHm5LNm0UIEE+/cLgmDaSNU9MODzEenBl3Asa5RlDW6SzY5E90dShh+AyYHn4Y3ZM9VQL3/7XPCgIKMsEtGHA/gwifvLT4MPSYt0O2EgDAWO2KckNInsB/AeQuumL7D6nv6y6UyuQ0E35Qz8qw3gSh+t3W03T2ONoc4o2DnRnI01w1K4XaL/YJ+J3fIK5yFoBw/1HfpsVT2lulYBxSMQnBX2P34U60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwW8VTCWrI89lljfofA4leBmGtvK9N4SYGqW1ajpCp0=;
 b=Ky0P7QUmDzPdbQlkruvCc3bMygbdk4HZvoCn1nxIg3qu0pTLmmKzBf063OJBXPa5sr72CkPOSIVf+8kBKDwMG1DB0puhyZWw8AtHXc3CaQZn4kQ++lS1kr7UFXzkmuLtyqUW6NcRni+FWJ/1UmcCujoK7cxhphhjHViHDag0hso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Tue, 28 Jan
 2025 14:25:31 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 14:25:31 +0000
Message-ID: <803921d9-c743-4c13-bff7-06df704f300f@amd.com>
Date: Tue, 28 Jan 2025 19:55:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
 <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
 <9b7392c7-6085-4c99-93b4-2bfac8b332ce@amd.com>
 <174adca3-3b0f-4174-bf71-a57598db912f@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <174adca3-3b0f-4174-bf71-a57598db912f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ccd636-873d-4eef-c888-08dd3fa79ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3JHNjNJV2k2NUNjalZoZUZ5MVlXb1FXdjVONmo4YjFyYW9KMDUxTk9LYlN2?=
 =?utf-8?B?YlUwWExIa0c5N3c2V2RPTWxRRkIxdCtBMFZMNlcza3ZJNWRaanEvWVZ4U1Bn?=
 =?utf-8?B?MDdMeXNPQzd3ZFNPd2YzWFlCdnFhNWxJR0dVRDBSYmxrVjZuazVNQWpJaHht?=
 =?utf-8?B?TVcwSTZEbDMya1hFWkozTDYwdHFCM1lxbXlPZWE0WUsvcnBSQzZ4bFhVRzA4?=
 =?utf-8?B?WFBySDJZZ041d24yU0JnZDZnQm1QY2NadHZ3RHFOVXoyQ2hNQXlTQVpLekhE?=
 =?utf-8?B?bWtrM0gxdmZHdDA0UVhGS0szMTIyYkpxOXdKWVZCV2p1SmZmYWNJd09TbFpJ?=
 =?utf-8?B?eUs5a3N6Q0RsYVc0Q1EwVFVyYVFORFVjZTB6Uk5oamF1WUJ5M1RiR0I4V0lH?=
 =?utf-8?B?QWxNaDIrU3JUZnZMMWhqV2xGUURSd1g5QmR5UXVRRVUyVG44bXExY203QjR0?=
 =?utf-8?B?cnhueEtUS3dsWjk2M0N2VEJ1czdBL1ZtQ3ZzdXJaNVc5NCtjTXl0NkFRRVJt?=
 =?utf-8?B?VGxUWnB5NXowM2tOZ3RKS3doRUIwVXVHTDBjTTZMVmljUFNoUlRnQ1kzY3RW?=
 =?utf-8?B?N0U0VGk4UUE5TmNKNGlhcUdIL21wdzVsRHQ2Rzc4VGNSUzJyUmVOMFdVcHZE?=
 =?utf-8?B?SFpQdFZ0RHRBbEhiSENmOG4zZk1DcXk5THJwbSs5Q3dZWFJGemU1QXMwemI4?=
 =?utf-8?B?QmRSZHFGSDlLcU9yMFFRQ0JRSUVmV3ZKTExOWFE0UGNGYkhGUU83QW01YW5G?=
 =?utf-8?B?UUlVa1hXTEtjanM5UVd1TkNKQ1kydXNZNlJzRzVEM01tSlA3TTJYcDNZN25F?=
 =?utf-8?B?Nkc3Z0Q2NGhCdGc1VDk2Q3cwbHBjSFpjWS9ud3c0RkNFMVZvUTJVMHNBMVcr?=
 =?utf-8?B?QWJhbXZYQ01qbDRFSnBUdXQ0UTNrT1kvM2lhRVU2VFdWOTlYcWZYbHdnNUdp?=
 =?utf-8?B?TzZ5RG1IVmlRV3BFZm55SU9sSHkyTURQVW1GR1lNV1N2T3Fnd1hKcThLbkl0?=
 =?utf-8?B?MU5DN3hDRzdUOWFGbTR0d0grdmxyYWpCKzlqd2VIKzI1eVByTnlOcjFTTGpv?=
 =?utf-8?B?NFlZd3cvd0FOc0F3MDE4N2RQSndQV1FFSmlmV0VVa1V6M25LR3pRRmRWZDJJ?=
 =?utf-8?B?MW1IUkkwa1VnbGh3UFZiQUE4LzNlQ2wwNkphb0dyN2ZBVmlaN2dWdmljcGxN?=
 =?utf-8?B?eFc4amluZGF6MUl3TlN6NG14bW53UDErOEtoUk1RQTl5d3NjeHRTYjQ1TTRB?=
 =?utf-8?B?emtwTllyTmN1OHMvTUhyblA5dTk5TFFRQ0N5Y24xdDlBVFR0eGdVcEhsS0lX?=
 =?utf-8?B?bGNBUnFEOFcvSGJjOERrYjhIQWpRcXVrbHNFb3lOMXZsblNNbjlpc09RM21i?=
 =?utf-8?B?QnlGaGFOc2dpWDF2Mi9GRzh3K1hkZVFaSUMvTGlIZTBLMGVoMnpaeW83ZXhX?=
 =?utf-8?B?UEVvZzhmMlVBQ2NCRnR2bGhBWkNxeXRvZUtRb0srcVZScnozS25sOHIxRmZV?=
 =?utf-8?B?UEtJVkRsRElXbGovck1lSzJjaUdVdTRrZi9RNTZyUHU1OG1QSnVRd3hKbUpa?=
 =?utf-8?B?b3c0QTJPaW5rOXdUWFFkYmQ4N002VWgxMUhkSGUvRlpLM1VwRzdUa0VSQmRk?=
 =?utf-8?B?c1lTM2E2V1FpQWNmdWdvZitNenVqT1dCb2FTcXdTUXJkR2w1WEV2SG1DWW1v?=
 =?utf-8?B?MUZ5aWVLUWE0bFBhTlp5TmpiSHhWakVZMnBGQlY4SHAxTzJpY3hMWXdTZGd5?=
 =?utf-8?B?bHg5Q3FRSWVrVWVoaVI1cndPNGFqWVhrcERxSjAyT3NiTDEzSHJKVjY4UXRm?=
 =?utf-8?B?K1RzNDJ6ZGt4NFVYb05JSlZTT3JURmswZWcxU0J0TzNVa3BHZUg3UERrUkMy?=
 =?utf-8?Q?Kp/5HIMTczb83?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1IrMlpuZzY1Z0pCYUJmQWg2b21GcDRqVTVYM2s3L3hLek1Iajg4QWhkMTNY?=
 =?utf-8?B?Wko4WTZSK0lMSm5BTEJ6endkeHA1TjlYbzVPYjZBNmV4UHBTNzllTlBsb0FU?=
 =?utf-8?B?Q1BrQXUzTzdYWldJOVYxaVVDSEpZcThsZTAwZ0JCU2o3L00rcC9LcTc2eFFt?=
 =?utf-8?B?c2JqaTE2RlM5MDgvOUtrYnhtS1BzSFdlclJ2Q3E0bmZQdFhJYWVYSlppazBY?=
 =?utf-8?B?VVpreUh3UVVpQmhYNW4rWnhGOEdaWEliZ1hLSzNqZGZoc2RCNENZTk5iUTFn?=
 =?utf-8?B?bjJrSGJrNm52K0U5Y0ltZDNJTFAyZmZTVUp0eUdEalVlWGhjbHdCYU95aDZE?=
 =?utf-8?B?K2J2RjFyaFpDNlk5QjBLZlBvWnBiWDN6V1JkdmN3NXMrWDFQR3RDaFg2RWZG?=
 =?utf-8?B?UEpMbGh6cmVDRmtMUXlXNUR5WWR2UWZIS1NFS2tOb010OXM1KzhQVzAySE5Y?=
 =?utf-8?B?K1Y3bU52VlJOMEl1bnBjdFl1NTdxVGw1bDdwZjRZZEZyYWU3NURYT0tWck94?=
 =?utf-8?B?elUzaUcvWSsvYWtFdkszVGhHWk1LRVFLTXNFZHhGM2JHaHo2SXQ4Umw2N3BV?=
 =?utf-8?B?SnRIZEFXMTRXZ05qODBrbkliUnkxSjBzN0JjWDlPMzdmM2xDd3VHNHBiNVVn?=
 =?utf-8?B?eHRDVDRtdnVEMGYyYVlyLzFkelFnazRSbzZENktHZFRyM01JNmlUakp6UkdL?=
 =?utf-8?B?d3VZeWZYNExSS3FaTDVtQU9mRkpCS3EvRmg2YUV6WFkxTVQzMHR0L1VVUUJT?=
 =?utf-8?B?YU45RFZIOWsydHovOUxVNVJzTWg3VytaTUI3UVhuKzVUaTJDTWg5aU5QQU1q?=
 =?utf-8?B?TmVsM0JrSDIrMnoxeGZEeFptNlBPOTRGZ1hmWEdvUVZKbVZJc1IzK2todXBo?=
 =?utf-8?B?cjZpTE00TzRFQXdPTEtEelZoOHowNWx4NWh2OGJmQ2Yxc01rRU1wK1YwQzd6?=
 =?utf-8?B?cURITmhyNGR6cTgrK3BVU1FqbGwxbnNnYjBtWkdoaU0waDdUcGp1QnA2MEVh?=
 =?utf-8?B?OHFaemZrNk1vSUpmSlVsV3hRUUJGS2sxZUpseHJzWVlTQVBaYm9FK3pBcEJm?=
 =?utf-8?B?Y0dMc0dHc3pzUk5kSnNyQTVaaFBGaDB6TnFFaFp0VDk5YUhuMkMvbWJHUHpu?=
 =?utf-8?B?a3cvb2ZvZ2ZkU0JlR2pSbThVZXpJQm1iS05DS0VDRW1QVzRuOWw2bFYwZFJY?=
 =?utf-8?B?Y3lSZGxpYmMxR0NJd0UzcnZxcmhuVG1RYnlFSkwxb3lIcE1rVCtiUzRTdTQx?=
 =?utf-8?B?WTlFN2JaeGdpYmJTdlFlVzBWWHN4NXE0eGU1cC85ejVWemFoZ1dQL1ViVVJn?=
 =?utf-8?B?eHptMmE5OXdiR1dhMmw4TXkwRWZPSzBSSE5sZWlTbHVyUDViQStHb0N4bFF3?=
 =?utf-8?B?bDZnSzV5ZHFuVUxaTlh2RTdGeU51UDg0dFY1WklsUHBQMWpybXlMcTIvN0tC?=
 =?utf-8?B?bFdXeWhVSnRlUUgycEY4SjMzdmNyMCtuVUVrK3loVXo2MGRNS0tBM0Vha0Qx?=
 =?utf-8?B?RTJBcGNGUjVxcVdQK29hVSt1bHlJeUJVQjZwdXBuUTF5Slk4TXVISjZUSHZY?=
 =?utf-8?B?d0wzTEYwZzh6OXNQaWEwL2JDQmhvMldISEh2K1BOaFlFcGVZYXdWM2RNRmVQ?=
 =?utf-8?B?cU52RGRWazBoUW9keEllME91WENIUXlTNm5lWER1YmVXQk5MeFh3UEs4alAr?=
 =?utf-8?B?ZzZsRG4xb2F4S0wydm9lODlUUy8xTTAyR0ZXQ2RYcjZFbE9CTlZ0T3FCb1c0?=
 =?utf-8?B?a0F3NlUxVVZTNGZEYlhCeWdWdnE2OU5lSldjMVF0WHpISnZUcWw3KytuemNr?=
 =?utf-8?B?SWlBZW1XSUx1Y0pWNnNJd29yUWFhY0RDakUzQTh4QW5hL0RHOTViNVB3Vnlx?=
 =?utf-8?B?L1RLM0UxZ1E3cnFKeXJrRjZrK3RZczczMG4xK0s3WGkzazQwbU5uQ20zZ21x?=
 =?utf-8?B?ayszMkROTG5oOTB0bXdIQk0yV0dFMWZCU2pETUx6bWYrOFdodEppbWtZV3VI?=
 =?utf-8?B?VTlFN2wwTDgvM3JzYzIyMDllREg4TXkyRnFhajBMRk1qNVdxc0c0UE1zeHRC?=
 =?utf-8?B?UERReHNKOUVSa1A0WXpVbitOYW01cnBLR0QzcGFhT3NSb200RG54WWpMeWlU?=
 =?utf-8?Q?crNcZ3YSJ8lOxayetr99ycztl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ccd636-873d-4eef-c888-08dd3fa79ea8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 14:25:31.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG3evOZy5YdKMqDOs7VbR8gGtri+DWQ2M2HUMPWEFXCpgnhjXXRvOOQ3/p3x6NVLKmH9JVhjds0u0q5lqtN2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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




On 1/28/2025 5:29 PM, Lazar, Lijo wrote:
>
> On 1/28/2025 5:06 PM, Sundararaju, Sathishkumar wrote:
>> Hi Lijo,
>>
>>
>> On 1/28/2025 3:04 PM, Lazar, Lijo wrote:
>>> On 1/28/2025 2:39 PM, Sathishkumar S wrote:
>>>> Add devcoredump helper functions that can be reused for all jpeg
>>>> versions.
>>>>
>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 ++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
>>>>    2 files changed, 66 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_jpeg.c
>>>> index b6d2eb049f54..70f1e0e88f4b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> @@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>>>> amdgpu_device *adev)
>>>>                device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>>>        }
>>>>    }
>>>> +
>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>>> reg_count)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    u32 inst_off, inst_id, is_powered;
>>>> +    int i, j;
>>>> +
>>>> +    if (!adev->jpeg.ip_dump)
>>>> +        return;
>>>> +
>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>> +        if (adev->jpeg.harvest_config & (1 << i))
>>>> +            continue;
>>>> +
>>>> +        inst_id = GET_INST(JPEG, i);
>>>> +        inst_off = i * reg_count;
>>>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>>>> +        adev->jpeg.ip_dump[inst_off] =
>>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
>>>> +                                          inst_id));
>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>> +
>>>> +        if (is_powered)
>>>> +            for (j = 1; j < reg_count; j++)
>>>> +                adev->jpeg.ip_dump[inst_off + j] =
>>>> +                    RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
>>>> +                                       inst_id));
>>>> +    }
>>>> +}
>>>> +
>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>> struct drm_printer *p,
>>>> +                const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    u32 inst_off, is_powered;
>>>> +    int i, j;
>>>> +
>>>> +    if (!adev->jpeg.ip_dump)
>>>> +        return;
>>>> +
>>>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>>>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>>>> dump\n", i);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        inst_off = i * reg_count;
>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>> +
>>>> +        if (is_powered) {
>>>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>>>> +            for (j = 0; j < reg_count; j++)
>>>> +                drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
>>>> +                       adev->jpeg.ip_dump[inst_off + j]);
>>>> +        } else
>>>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_jpeg.h
>>>> index eb2096dcf1a6..1d334f35d8a8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>> @@ -92,6 +92,8 @@
>>>>            *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>>>        } while (0)
>>>>    +struct amdgpu_hwip_reg_entry;
>>>> +
>>>>    enum amdgpu_jpeg_caps {
>>>>        AMDGPU_JPEG_RRMT_ENABLED,
>>>>    };
>>>> @@ -137,6 +139,7 @@ struct amdgpu_jpeg {
>>>>        bool    indirect_sram;
>>>>        uint32_t supported_reset;
>>>>        uint32_t caps;
>>>> +    u32 *ip_dump;
>>> It's better to keep this at per jpeg instance level (amdgpu_jpeg_inst).
>>> If the hang happens for a single jpeg ring, that will help rather than
>>> dumping out reg settings for all instances.
>> The devcoredump infra in amdgpu does not propagate the job itself or the
>> hung instance, so there is no feasible way of doing this, meaning
>> dumping only the affected instance.
>> And if every instance is represented by an ip_block then I can implement
>> this with a flag to handle per instance case, but I doubt it is, as seen
>> from the below commit
>> fba4761ca00f drm/amdgpu: partially revert VCN IP block instancing support
>>
> Even if the API in its current form doesn't support per instance dump,
> suggest to keept the reg_dump data struct in jpeg_instance. That way it
> doesn't need any calculation to find the right offset etc.
>
> On the other hand, a single copy may be maintained for the reg address
> list if that is feasible. As I see the address calculation is dynamic
> based on the instance id and it may not make sense to keep it in all
> instances.
I am aligned with you on maintaining a single copy of the reg_list, and 
so, yes address calculation is dynamic
based on the the instance id as you pointed out, in that case 
maintaining this inside an instance tracking structure
doesn't feel right, as multiple instances track the same reg_list 
pointer which is the same list for all instances given an IP version.

The request I am proposing is to maintain the reg_list inside 
adev->jpeg, a common list of registers for any instance in the ip, and
all the ip_blocks of type JPEG refer to this common list when separate 
instances are represented by discrete ip_blocks, and dump per instance
register list in the future when that is planned and enabled.

Regards,
Sathish
>
> Thanks,
> Lijo
>
>> Regards,
>> Sathish
>>> Thanks,
>>> Lijo
>>>
>>>>    };
>>>>      int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>>>> @@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct
>>>> amdgpu_device *adev, int inst_idx,
>>>>    void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>>>    int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>>>    void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>>> reg_count);
>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>> struct drm_printer *p,
>>>> +                const struct amdgpu_hwip_reg_entry *reg, u32
>>>> reg_count);
>>>>      #endif /*__AMDGPU_JPEG_H__*/

