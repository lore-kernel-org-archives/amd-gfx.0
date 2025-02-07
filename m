Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37325C0219F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89BB10EB5E;
	Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QklPqAae";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F19610EB41
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToKtt8mEHZI8Cgso5opXRn0ruXbub18XZ+BCHZMQCGyRdQ0M089Y4TBEfKfVJHPR2fkDD9edhhhfbqmC8RAik27Dh3KDEhRbK2KsxHDBEHg9OXv9M7h/IzbxNNikPXnIC+O+a/o6bUIu46U/D8T+rF5xQ13c77hKFM018rAH9bfTu7p52WjK0K6N5Nm8uezx/eMn6phjTOLLNNQ/DjV7XbTW0HClDlDx67/qD+pOhQYoJtke9psexI0v4IoVSGkeoahsaoExfo+BYxa0aUyYaUsUyJviFmJOp3u2+AOCi4unvzCr9f9g3q1ESR2ZVLZp0lzL6YhWK+SStKdH7d1G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEarzJvNSV1HaxJvgOCtyuh1VPZQzk1b0jwUvV6HmBY=;
 b=dzeE//g3DLzoCqOn8Ug3olL/8TswQyc+PhkZRkbFxhxZL886V1ykHevCnqR5t8EwlCzxNNSX3o0/le1abnK91pDyb5YY3BAyILZBMzYz1Vc5+VcwO96cNsI+U0oFWqNvcRrQs1j8Mt8mKGHhhDdTuDNH1mvgNjbu6rbREbZZtMbB9B6tUpBX8mCrOtb//4+0QJPqGZcLcphbEfxju5fHCWdKvSijmVAkUdcmI0TDe7prH+VC91OzZkBVFt+8bt+5Tcstvcv+wV+rfGCwB8LcouvAU8g0KG1F0tf34qJx/n/tTDL3r9DhINElEsOW3c2X/up5+GWhOUghh2SUQ6xB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEarzJvNSV1HaxJvgOCtyuh1VPZQzk1b0jwUvV6HmBY=;
 b=QklPqAaeYp2CEa0KAGKk4QCUu24fSQqR5clWaVzHzP5XDHVX7XqV1DBgLjEhU8ISnFj0NcWGCYi9ASRODy+IPYA+Pf5a9l1POSWUOb+7crlj1aXYVgFKgKkDGfC6DSG2zfrHu0EydfrumGNfx21ZZOvrmuLkcG847270+AcSKDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:29:20 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%3]) with mapi id 15.20.8398.014; Fri, 7 Feb 2025
 15:29:19 +0000
Message-ID: <845ea941-ace7-4460-b0b5-6fe5943cf34c@amd.com>
Date: Fri, 7 Feb 2025 10:29:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
 <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
 <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
 <DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com>
 <b8f65db6-a4fa-4d13-809c-ab8061276e7b@amd.com>
 <c4efb797-6d9a-4586-ad98-56edf79f85e3@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <c4efb797-6d9a-4586-ad98-56edf79f85e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::9) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e0b85f-bcc1-40ac-677a-08dd478c30d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHdIdWZrZ3pXdjZZZS9PWnJlUGVHZkJkc3B3YXBTSUJCeEh3M09ld3A2WTRl?=
 =?utf-8?B?b20zOHZTWFo3WkRsSmZ5S01Ea25oVng2MzJybkpPMHZvOWRsNlE1YkxETTBm?=
 =?utf-8?B?c0o2SE5ZQVJMcCtxMWFtR0ZTVlBUcTlUdGJJTTVrMy9UeHpla0gwS0xSV1hR?=
 =?utf-8?B?VjRMcW9oY0ZsK0FHMG54N3hreTFkQ2lGZmxObllFd1VnNURSZ0RyYys1MXJ1?=
 =?utf-8?B?SkVFcUcyN1BiQkxEang2NjF2c25yVmhWbkExUitOdVlCUTZ0dW9DVHllY3Na?=
 =?utf-8?B?UEtlZkdjcUg3clVGVnhKZmNYRmgvWWZUSkxHUFh0cG9pdVBYWkVVUHpFYnVs?=
 =?utf-8?B?TFJoeXNuU0tadklINGRldzhMVWY3Snc3OXkwRUV6aE5zd0dxUWVBZWdMZC9X?=
 =?utf-8?B?M0hDQjJrU285Vkk2UUVTT3RpR0RlV0hWNEVXL0pBcTdHeXBvZjZjZ05rNnVV?=
 =?utf-8?B?a0pMV1pLQ3QyR1lxNEZMWWhGK3BPd0xLRjRGM3IycUw0N3Z3aG84L09iSUtx?=
 =?utf-8?B?NVFUREVmUFVoc0ZVUjFTL25uZlU0UkNtUU5YZDVYS2l6OVhrM3JMZUV1eTBV?=
 =?utf-8?B?YmNubHJHMGptYTBTY2lvdXAxQUloNzBpUDU0cFRQTURiTFR0WE1kYXI3U1dC?=
 =?utf-8?B?V2tqV29IUnZtNGNaZXlPb1pZOW5seHdVOWgwTmNuV3UyWTkrSUI0Q0pWQUp2?=
 =?utf-8?B?clVrdUlPWEc3VUQ3bHlJSVFpWUZ3VG5XRFAwcDc4UU5xcng2Yk0xczlmaUlX?=
 =?utf-8?B?Tllad1hKa2JOdTB1RGlYUmtxeVFGSnNUeFZtNXVoUG1yM3VaWTV6TnFsL1hB?=
 =?utf-8?B?ZTg0S3p2Q3VTcVhoeEgyVU81ZnpUZWkveWdaZ3ZVbkJuYTVPTHplRmFxbVpY?=
 =?utf-8?B?M0oxSkJMZkZpRWVvd0owamtWQjhWNHpueFc5YWMwREllckdicm9ybWh2R1JZ?=
 =?utf-8?B?ZDdHYWNSL0NqOGFXTzRkWERPRTlGS0t4N3pVckozMjZJZEpxZDI4TnhXMmdO?=
 =?utf-8?B?a3EzMjlxcm8xYy9jWmVJNURzaTYvU2NpTlZoNVdUcmQwd2FPdFZZY1lhTmdK?=
 =?utf-8?B?cXk0ZUJITjJtZlA3cGJLcEFKZjdEdWtuVjhENUdHY1UyNG9hcnp6OE9pNkQr?=
 =?utf-8?B?bjNrU294T0RjVCt3bUhGVml0ZTRVTFhYeXFxbGNENDBpb2x3QWRUZm9sdjBE?=
 =?utf-8?B?SE5IcWVHeCs0ZUtzbkpnQ0VldUtNOW9Xd2JzRVpKWWFuTkRUOEZKdGlvcGVm?=
 =?utf-8?B?RWovY05TRDg4dVhpSFBBQitRRFpsVUF4MTRmRk1xY3ZFbzJDOHpQMGlzM20w?=
 =?utf-8?B?V2FEN1A4YVJSYnFpUkRFUnpNcEZhUzBoNjRtcVRjUjFleVhTbXFuN241NWdx?=
 =?utf-8?B?WVJnMVFQZ0tpRVh5QjJjS0Rmb0Z1NEdMSGVWRFNTVHF3WElOMmZjbU1xUVd3?=
 =?utf-8?B?Qy9DL1hDVTlxT2xZek03QU0xU2RGTjdjOXNncGVjb3RTN3BUMlA3SzZOdFRU?=
 =?utf-8?B?T1FPM01yZXJPWG1OdWhsTmNhZFNlaFFoTGJwS1FITXU2TVcrejBFeDg3aklX?=
 =?utf-8?B?ZFRNNDJ0V0M4ckcyRW1yZE84UkE1Rm83ZFpCaGxvSWVvVS8wYktEMC9DSEdh?=
 =?utf-8?B?VUxJcTlDb0JOejZLQlBaSjdXYWkxVzJCN3paaHNuKzNWS2hCbkIvOHVyVGEr?=
 =?utf-8?B?VTdwRmNFeTVTUUpJOUF3TUJtVWg2TGFkbnFwbDQ2V0JZckRtays2TktaZ2JL?=
 =?utf-8?B?UzdscXdsYWpmMHVIWVpxaUFldlFWMzJrMXAzaU5nQWxzRDBySmdKUWd6RFdk?=
 =?utf-8?B?bDlPWFFMdjVOVkFyUnc5L3BrazN1ZmVCalJ6ZDROMGZoYXlCZWZicDhzOWZB?=
 =?utf-8?Q?c6s1Exv2WeEZA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJvTngwQVJ4SzdXbW4wNXJyMTJ4TlMxV0VMbHh6RmRPVWlYOTk5ZGR6YjU4?=
 =?utf-8?B?Y2FQZ2hLaFp5NDNPV3MzYVRZeXVQbld2VU84RUlUSUZGYWtyZFlqWUhiNWhS?=
 =?utf-8?B?d1Evd2FTeXNyd3lqQTJQVTNtWlkySE9pQTBqUkpuL3ozU0dBNXArZmtoaU5i?=
 =?utf-8?B?TDI5eFVRMHJyQ2pYRjJmRysycjA4dyt2Uk9KK1A0UDlHbTRUWkFvQmIwdHFP?=
 =?utf-8?B?SjhQcHVnZ01uU3ROSzlnTytReGFaNFBPQkd5cUVlcTZXd25mZWpXUnhpQXF6?=
 =?utf-8?B?bnBXRFFsVVA3TS9EYzZpOXdtOXdZdjBKYXpDbjYzejBsT01RZmNJcEl2TDZY?=
 =?utf-8?B?MmRLWGJzZVdQMzFqR2UrdzBnaXlqbHExcWJ6bW5MblVIWU45Z2E2Snh3MDdx?=
 =?utf-8?B?WmRhaGJpRi94UXNVaEVQbWQwaldwVHM4d0g3QnBYZmJhMDlVT29FcVk5SXo5?=
 =?utf-8?B?TWJQS0UwUkprbkEwdVFEN0hCaFFKcWRKRnV5TUlkMytYT2tkS2NCczF5bW1W?=
 =?utf-8?B?NndpRnNOY25pVGZDSk9Da0FPQVcwNGpWczNXdkJXTk9lTVd3eG5qVnBILzNC?=
 =?utf-8?B?aXd5dEFpQUZ3bmlYN2RXZEpoZU43RlA3bEdsR0c3U05mVmxnaWM5bythUnlD?=
 =?utf-8?B?K2JjZ3AwR3F4RzJ1OU5ENDgrVENwRGZwNEM3cEFnM3NZblhiVHdtaHpIalNF?=
 =?utf-8?B?ZkZvZzVJVlZlS0h0dWdOZGdMQi9yT2ZUS2VmaG5UL0NCNDhnNFNNUk0rdjhy?=
 =?utf-8?B?RS8yK2k4Qk50RmZqeUFlZ2U4ckJYRXF1UE1JdDZNd3ZJNHpIVTdxdE1KZG1y?=
 =?utf-8?B?NkNPczFrVXErM1FEOTUrY2V5MjVNZUg1Y29HbkxlSXlGbThEZWR2cnBiM1Jv?=
 =?utf-8?B?RWlWYU41Y0s3VFoxWC9sU3V4YzgwWDJXUDdDU3ZTQ1dLVDhtYitoR214UUNu?=
 =?utf-8?B?VFJMckxMemJ2OWhXTTh4MDJiMFJ6VUxIYUV4dG93NkFQTEtmNU1vQ0JkUk10?=
 =?utf-8?B?VmE5MjV4ODZLTElBRUdnZElsUGFOK2ZKQlRpNEZXMVo2MFYwTHZObm96L0pH?=
 =?utf-8?B?cnZxdE91YTJiNUNWZFNGbjY1RlY2M0pmQjFONHBxMFNPV0tGZ2VXKzVFVzhT?=
 =?utf-8?B?Q1ZQY1cyVE8vbE9zOVZHRUNPeWFKNnBhREpFRDhwbStJRzRVUEFRb3k5V2ts?=
 =?utf-8?B?UTNPaStEUE1EcE1CSXpMT3B3bmY1K3E0bUlOS1RCMGU3RUR3Y1krS1RiSmI0?=
 =?utf-8?B?cEFGaWFRcTUvU1pKdGFCZXRtOS9JK0VDZVlGR2d1NTlmN1VkWmNhRnh0Y2NI?=
 =?utf-8?B?bXZoalltQVVMZkNBeHlVS1IxeE9meDgzdVpxY0NQZldLd1lhQytZTUlmbjdS?=
 =?utf-8?B?WjgybUdKNE1OUnp4NUh3cEZnc0lMb29Sd0xkbGdFR24wWlJxcFhLQVVxeFZ0?=
 =?utf-8?B?b29oSWtWSTFYcmFsOHFXMGxWaDZsaFZJS2x5V3dZOG1zOEsxM1FGUXdLN2hP?=
 =?utf-8?B?eXlhK1BHZnY3eXNaUDl4NUxlRlBwV3RvUWdoZXhsY1ovZDFPSExTUDlIMWNl?=
 =?utf-8?B?ZkNNVHRHUS9GQ01YYUw2SURNNUhqZFU2Q1lTK0pjSEtET2p1NUFJSk9vQXVD?=
 =?utf-8?B?Q0R6OTBjV0Q1c0VjT3JxcE82bVB2ZmZRTFIzc29ubU1mcVZGd1VseDNWVHhv?=
 =?utf-8?B?ZDFlc2dYL2F5Z2FZQ1Q5cE1IcGtJVTEyZG1mWVBJVVVFYVU5Ym5BQmZ1WDVB?=
 =?utf-8?B?REN3RlRjME1tUG56SmJFVHVBVW4zWmpwYzNUTy9SZ3lVM2ZiZ1FoOWkzdXg2?=
 =?utf-8?B?bWU5WGlBZC9uM0FUN0lYZ2k2d1ZtYmlBWWpNdXd5UlpZQjBWWml4bjE1L3Q1?=
 =?utf-8?B?dGx5RGloQmlNcEw3clJVbk84R2xHdVFZb3UyZFJ6czB4c25VNUoyRndOenB3?=
 =?utf-8?B?N3FEWFJQS3ZONnFpTjZtR1NMS2RnMGRoLzdkNFBCcmJRT3Y1MW00c1BtRDJw?=
 =?utf-8?B?a2tqNk5ITnNIYzB4ajlRdWlKRHZ6VVcydDNyUHlkWW5oMHdNSndLaXE4LzRr?=
 =?utf-8?B?ellXN3EvSDZtNTVFQldoanM5QUgrem1FSTdxdTYxdkV1d3owSkd4U2RJR3N2?=
 =?utf-8?Q?bhR0wlh08dgeF3bUlDr/HA7ZG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e0b85f-bcc1-40ac-677a-08dd478c30d9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:29:19.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9Fa+6XwnM7Q/EPFdTtYUQTVmeoOP+ckC/IYUwsFlxAZZHhaqag0t3AS/Y6O4NhFqNsbAxmxPRQVth8o0huKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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


On 2025-02-06 22:41, Lazar, Lijo wrote:
>
> On 2/6/2025 10:18 PM, Eric Huang wrote:
>> I understand your concern. KFD currently only reports one L2 instance,
>> but not every L2 instance. If customers want to have more detail in all
>> available L2 info, we probably can change the logic in this function,
>> but it is not related to my change. My change is based on current kfd
>> logic and fixes missing L2 issue.
>>
> Even for that case, do you need to loop through all xccs? Expectation is
> there are some set of active CUs in any XCC (in general, XCC without an
> active CU is not expected to part of KFD node).

Good point. I will send out another patch accordingly.

Thanks,
Eric
>
> Thanks,
> Lijo
>
>> Thanks,
>> Eric
>>
>> On 2025-02-06 11:37, Lazar, Lijo wrote:
>>> [Public]
>>>
>>>
>>> Yes, the problem is that. If a node has 2 XCCs, it should report the
>>> L2 of each separately with the number of CUs sharing each L2.
>>>
>>> In this, it appears to loop through and find the first non-zero of all
>>> XCCs of a node and not based on the first non-zero per XCC basis. It
>>> makes a difference in number of L2 instances available.
>>>
>>>
>>> Thanks,
>>> Lijo
>>> ------------------------------------------------------------------------
>>> *From:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>> *Sent:* Thursday, February 6, 2025 10:00:38 PM
>>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>> <amd-gfx@lists.freedesktop.org>
>>> *Subject:* Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
>>>   
>>>
>>> On 2025-02-06 10:14, Lazar, Lijo wrote:
>>>> On 1/29/2025 8:50 PM, Eric Huang wrote:
>>>>> In some ASICs L2 cache info may miss in kfd topology,
>>>>> because the first bitmap may be empty, that means
>>>>> the first cu may be inactive, so to find the first
>>>>> active cu will solve the issue.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>>>>>     1 file changed, 16 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/
>>> gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> index 4936697e6fc2..73d95041a388 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct
>>> kfd_cache_properties **props_ext,
>>>>>                                 int cache_type, unsigned int
>>> cu_processor_id,
>>>>>                                 struct kfd_node *knode)
>>>>>     {
>>>>> -    unsigned int cu_sibling_map_mask;
>>>>> +    unsigned int cu_sibling_map_mask = 0;
>>>>>         int first_active_cu;
>>>>>         int i, j, k, xcc, start, end;
>>>>>         int num_xcc = NUM_XCC(knode->xcc_mask);
>>>>>         struct kfd_cache_properties *pcache = NULL;
>>>>>         enum amdgpu_memory_partition mode;
>>>>>         struct amdgpu_device *adev = knode->adev;
>>>>> +    bool found = false;
>>>>>    
>>>>>         start = ffs(knode->xcc_mask) - 1;
>>>>>         end = start + num_xcc;
>>>>> -    cu_sibling_map_mask = cu_info->bitmap[start][0][0];
>>>>> +
>>>>> +    /* To find the bitmap in the first active cu */
>>>>> +    for (xcc = start; xcc < end && !found; xcc++) {
>>>> It seems there is an assumption made here that a CU in one XCC could
>>>> share this cache with CU in another XCC. This is not true for GFX 9.4.3
>>>> SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.
>>> In KFD topology we only report L2 cache info of the first active cu in A
>>> XCC, which could be XCC0 or XCC1. It is generic for L2 info in the
>>> certain XCP/kfd node, and not specific for every XCC, so it doesn't mean
>>> the L2 cache found in XCC0 can be shared with XCC1, it only means there
>>> is L2 cache in this kfd node.
>>>
>>> Regards,
>>> Eric
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +            for (i = 0; i < gfx_info->max_shader_engines && !
>>> found; i++) {
>>>>> +                    for (j = 0; j < gfx_info->max_sh_per_se && !
>>> found; j++) {
>>>>> +                            if (cu_info->bitmap[xcc][i % 4][j % 4]) {
>>>>> +                                    cu_sibling_map_mask =
>>>>> +                                            cu_info->bitmap[xcc][i
>>> % 4][j % 4];
>>>>> +                                    found = true;
>>>>> +                            }
>>>>> +                    }
>>>>> +            }
>>>>> +    }
>>>>> +
>>>>>         cu_sibling_map_mask &=
>>>>>                 ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>>>>>         first_active_cu = ffs(cu_sibling_map_mask);

