Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81967D2595F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0619D10E4CD;
	Tue, 27 Jan 2026 08:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpYcGPWu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD4110E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 08:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysx/z5cRsTdoJ9akOYXl2sVAZjYFf04w165PAuT6m1tlDZS4HhTgHNd8f3Abrz3x4EsdgdAzo0I0WVvaNe9kzC/FwykNLeeFRLTMCZtSPzocbknZ7wdntHfOVJrbAtSigHDWqqo9t/gfty4ZK+nsESjYtPR09fvfaVFY3mfbTUZOK+923ghHSGHq+hKlgcXogu8nRRSuNaAvB4S0ZzOqVIoE+VxaU1VBO0UQuGpZiPP3d3mTP99JLFZIGi8alQCNcAw1FI98vGarwQ7z6i052OZYVgyJ8OCC5ncHQfDMdMvXmgCdOnoKXkRVcX5vOlY5BOvFjbhj5eHU54/NQ1Mybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW1H8XxqLzigdSIZU1JWKvD2k05xQhCYOwG74NoLKFQ=;
 b=wfskPicjdP4IP+ogUY6hKzuv1k7v8lWMUoHhRMb6tCaDNn/savVE6PzxbaZWakUe6I6lYtL4STCHkkI/vM59c21tHLr6d5YugFLeYtImB28wya6FbEuojhCddeYsxuAWhRN26cWis95Ur13wwZKwosteQOzB6hijX8KMMkYQe+aZkvSK5VHTfNaazddh/lze0eHhAMgmHuNRwO73m8zHlu+BxEi6woUlItKDonbUF76F+geRvxdCp2bv33MtiI6WZITLE3P7nxVPv7+I1KaC+fGIE61yfwdv43Mcx3xfk7a2okIJ1pdQKCFwCc5QGUi+sqLNusTrlheDTE/1argmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW1H8XxqLzigdSIZU1JWKvD2k05xQhCYOwG74NoLKFQ=;
 b=RpYcGPWu9w5ltFrmKDkjIARfkuYx9F03zcaaYGYYoKhavuNwAagtarAQJtjzV8LaQWgpRL0XFDFzCitEVDafLGCmlL3rNQaN1nirEcbjWrqz774GcI4TGv6XNck/WBiCCedwbFbhW0Jt0XSjVPsSW+J5+52m2HP5mvkmcFFxJbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:13:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 08:13:59 +0000
Message-ID: <fc62b461-8bfe-4646-95eb-e9b152f6bef6@amd.com>
Date: Tue, 27 Jan 2026 13:43:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix jpeg ring test order in vcn_v4_0_3
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260127073918.2415931-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260127073918.2415931-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7b1010-bdd5-41f4-6f38-08de5d7c05d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXc5UWlaK053c0hTSW9zMFFqZDEwdHhQVDhWNlc4WlVOMzdYYTM0OEh3T0V6?=
 =?utf-8?B?Q0pmR0t6WTNueUFKU09yMG1BcEpnNit5UVhvVVJaZFBtTk1aall5d1FoNit5?=
 =?utf-8?B?U05tNkZMVFE4R3pCbTRteUZSay9iS3hNZGxqbFFHU0JtMWhzY2d1Z3pOd1dI?=
 =?utf-8?B?Zm9NcTZIMmNPSHd6WUxINXNCSTVpcjl6amV3RE9SZTVvT29KemF2cFhaSFl2?=
 =?utf-8?B?Sk5qWkoxaGZ2aWdUaVo4aUNiQUpYcDRYazhtcGx5OUx5dEIzbGx1N1FsWmRz?=
 =?utf-8?B?MXk2c28yMVVDQUpIVnd5Y2daZWNMRmVLdERZMnltMFVpclpsNng1anF0Ym1I?=
 =?utf-8?B?VElaVkpTS1ZpazZrdU9zRGFwQ3NFSDNYMUFkZDYxOFFsMGwrM3hEWHgxMm9C?=
 =?utf-8?B?RVVlQjN2VUJJSTN2dGRlWFFMaG9IYWNMbnAvUTNNNzlvRmV2alRiTmZvWStm?=
 =?utf-8?B?QUpnSy9Udk9BbzI4aUFhN2pRWm4wY0lTcHIwQ1dWMDRVREhjc3Q5c3FQL21H?=
 =?utf-8?B?dVNXOER4U3MyclVaVVRnT00vSFBYTnRKbWVvOUtxMFJZb3lUTlhFV2x2TzVR?=
 =?utf-8?B?QjVRc1VQTkpVd3lPRktTMHl2Y3NmM3I3YWJTYlVPWjVlZk5rTmVJSHJKaVov?=
 =?utf-8?B?QWVOMkZpQnhEWXVQT2ljMTVscmc4VkhoVjZpVnBnV3plMUdJMWdIU2NYSElG?=
 =?utf-8?B?UTIwUWI1T2JIcXZaYy9NKy9HOUo5aS83ZFlJTW5vN3hLOXJOMnZONkZJUERt?=
 =?utf-8?B?c085bzNXdk5QNUEwUzhLOUpQZEthckNYRWpmd0VKVXkwVnhqQy94cThQMjlP?=
 =?utf-8?B?MVp3Qk5NczVpTjhJUlgyMkxPZW9XWHBMMUdHeXlJY09tVWpZWmw0QWRBMllQ?=
 =?utf-8?B?NlpUZVNRRS9ZbjE3VGJLYmN3M3p1V2RCWnc1Vm1mSitPU3lXTENxY0RnUUdV?=
 =?utf-8?B?aHFnWk83SnBCaWhzZ1k5bmhUVEdBa25oaGc1UDBWaWpoSVhtTVVmTUdLd1hD?=
 =?utf-8?B?bkJuZ2I5eXFGTDRaeW03eDVYeW9jZVNqZ1UwMkpsZFlPd3pQVktrWnZFaGU4?=
 =?utf-8?B?REJFSldtOE5wUDZIS2lMMnhQNE5sY00xUmRLSTlyS2M1elJlMTZxNUhmdGpM?=
 =?utf-8?B?cERnVFJYeXBSNXJKV1BpbkxqSFpVSUMzVEN2aE1LbkoxbWZqUjFOWkZXbmda?=
 =?utf-8?B?T2ZsNTZvcVMxQUdyTGhPRzBML0h2THE0azFtU3J3N0ZNVXk3YnhvMlZNcUZl?=
 =?utf-8?B?aHFoWFFGc21jYWVpQTFoNXNRNU40dFQ3bHBzVWNpNmxnNy9uZEtXSUtPOFJN?=
 =?utf-8?B?ZU9BSzRONXAxYS9LSlJITkRsN2Y4M1BsV1h5Y2Z2WTRxUWd3ZzVRQWFKcmpR?=
 =?utf-8?B?cFVDM2lqeHlqekpXTHNOVlQ3Y0ZuVkxvbGpQWGNEUHpONHk3U3BaOUpjOFhj?=
 =?utf-8?B?N0hjblRkbmlwNzE3WElpblJ5a0c1ZFczd0wxZ2J3UnoyYnFlbUJ5SzlLcVJJ?=
 =?utf-8?B?NkNtRDhVUWxDOW9YTGdENyt3WEwwa09xUjVGT1poNkxwRS9WeS8wNkFRTkpu?=
 =?utf-8?B?c1FRcS8vY3FaRmFjNTRwOXZCbmZxZW5xdk5HTU9RTUZqUFVvTVREUVEwR2M5?=
 =?utf-8?B?R2RUdDl1UFdOMmY4TmlHdG9ObkpZeUVDbWkwTmhWWGFSRzFsWEpJVzA4bzk3?=
 =?utf-8?B?bEdZZnZlbGlzMlZIQkNOSXFTbEYvZXJNUWZKRW5QTTNsUFdXMWtWbDhNZkpE?=
 =?utf-8?B?VlRoOWJxckRPd1RNRE1aNmR1NGxEQ2V3UWFZQURVcFNGQ00wNWp0SDAxVUtj?=
 =?utf-8?B?anNNdklNY3VyaDRzdFdUUFVkWHFnMTl2eFRwZVRVd0tBNHhLdDlnWmFmcGF4?=
 =?utf-8?B?cVoySVhQNEhaR3YyRmRJWVVvcmRnVnBTSGFQTHR5M1I3KzJSUmRFZ3M4a0l0?=
 =?utf-8?B?enFwSG9YZHp2cFY3cS91WUxCektkVUZsV1pIbHVqZzZya2EwTk04cEZxY2t6?=
 =?utf-8?B?MldJRU8xeDhPZ2ZsOHFGVU5jUjZENklIZlVPZ0FLcWVlRHFJNGdFYlNvODU3?=
 =?utf-8?B?MUNPS281RnJLMnBvOUlCZHpZV0FUMGpLU1lpYzBLVVU5b1U2N3ZxNnZxNlJM?=
 =?utf-8?Q?JDwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVB3WWE0Q1ZSQmlWZWZWS1VKT3BpSHZlUCt1cXJqYVduRFlDL3pQUitqdmlE?=
 =?utf-8?B?Rk5wL0dmWHpFNjIyNHdEcnBSQXhaTTlQR0dCQzBnRGF1U3FQN0hFZm5iK2VI?=
 =?utf-8?B?WnFtR1pQWkQ4VUNSTmpwSUwxR0JIZUxaZ21ObEgwcGZKWEp3SVVnR1J0aThP?=
 =?utf-8?B?eTE1UUVWSWJuYStReDYvcjJXb1dmVHdBUnVSbVFRYTY0S3NacWJnV1M3bDQ5?=
 =?utf-8?B?dmVVWHFiVSs3cmlaeWRTLzVFYUtabG9WOUxQdXBXV29meC9YaFhnei9hUjd5?=
 =?utf-8?B?TkZ1V0pKc2tqcTZpNG5aVlZwVVRHNy81K3NxMncwOWwvcnJCSEVRbGtoMHlE?=
 =?utf-8?B?clJYWG1ycWlsTUFweTZxNERhYjQyOU9vN2hYSUIweStvRXBadDNNQkRTa1hI?=
 =?utf-8?B?d1NFdjFQRGYwME56VlE5UFlabFM5eG5jQjF0eHViR0ZwSUloc05XVHo5V2dm?=
 =?utf-8?B?UER2TG14S3gzTWwvVDhRUnFnODd5SEZrdXpWMWZPVDN5VlVvUExEang5Y043?=
 =?utf-8?B?eUhEZG1NS25zQWVzWlpvS1pBNmN0QmdxdGN1Tldscll6REVpVWtGUHV0UXl6?=
 =?utf-8?B?VzlZWnNzZlB1VkZoOHViVnVudUQveDNOQVRoUThnNGRmTG5pYXAwM3FDKzRq?=
 =?utf-8?B?emdDMUIrbWtBNXhlaDBkMExTM0p0SHNML01UckdBcGdydHpzdlJIaHpmcGl3?=
 =?utf-8?B?REp6cnFwV3Vmc0xqQVVqRGFVSU05Mmw3RDB0ZmpWVTFlbTBqL2ZweTRBanVT?=
 =?utf-8?B?Nk5QL2pTdGErNUNRQThaTHBGUmtXRjFEQzZKN3Yxd2dsSHl6WHJONjJkaUtk?=
 =?utf-8?B?RUFSSERNT3lIemdnNHpJVEVianVDWXdKVGk1ZjZJMmxWOVJFTEVoT2lVQ21R?=
 =?utf-8?B?dW1QdjR4Qm1jaFpUS256MTBDVHowOTlhdElKYTRsM2x4RVJ4R2hKYjJrRDBn?=
 =?utf-8?B?aHFZUk9XZVdnRldoT2dOcldVVmRzVzBlYWlvb000SW1BMGU2cGpEcXVhMUZD?=
 =?utf-8?B?NCttY2tLNmIxSWZtV1NoeWRtdy9UNzNJbGZtMlNZR1ZmRU1jeHhJQ2krMnpt?=
 =?utf-8?B?bVNiNDdna3dpdThxR2VyRUs4MGRIRFRYMTdIUGVqL2dBeTlCOExWbklNU3BU?=
 =?utf-8?B?dXhZS0FLcDEwUWJNcmRmd2VIdnF5NlBsQTI5N0Fpdm9IbldLc2dIS01OVHhQ?=
 =?utf-8?B?K0d0UlcyVVFvV3l6MEF3elg5QWN4WlpKbE1QMWJnTFY1MGR6YW9WWU8rWTJa?=
 =?utf-8?B?YU9wZUdVMjArOVJtcC9EaHBJczgwTTlacXkxVmRCb1hSRGE3WmQvcEtSVWxV?=
 =?utf-8?B?M3RTVjlqcHpKZ29ydFZ4SCswTkpIWm5FWW54Q1FEcC9Ja2Roa0xjV3BQVEho?=
 =?utf-8?B?Q2lLM2JWdmFVeklnekYrUnZma2NPV2lCTnBCZXgycTYrdFlRVFMzWjh6S08v?=
 =?utf-8?B?MUlLRHRtQlNYSEZGek1kMjB3dlBNV2ZvM2x4NWJFQVhTZkJrZjhseE1CL3hZ?=
 =?utf-8?B?bmd1U0s1OFhVb05icngzU3dDbFRCSUxDc2Y3aGV0ck8ydEtDbFZXb0JsVUVR?=
 =?utf-8?B?WDJCV2JZQjZrL2pPaUFKSXNzakt4UldLdDdTaTI4Nk5HdDVIdk45ZEgyNDIy?=
 =?utf-8?B?dTBaL2JGSjE1N1NBRkJtWExqbmIxRHE3N29YMkE4SzFlSXVJNWdSUjMxcEtS?=
 =?utf-8?B?SUVoWnBkOHg2K2pNaEtyVDdOTDFYT21EbnU0NFVYMjNCUWR0NFFqY2prR09k?=
 =?utf-8?B?dW42NkVrL3N3Zk1qUUtRZTl6R21FOEV4ckR3My9LVFoyZ2FDVlBkb0xGeVR5?=
 =?utf-8?B?Y2ZJY2tmUzFobmE4TjYvNkZTVVNxY20zVWI1UTd5TFFUczgrc01acjcxWDJn?=
 =?utf-8?B?UU5MemZlUS9QM01mY1BRZTAzZWozTmZBOXFUNzBuQVdyYS9NSGNnUlNhWmlB?=
 =?utf-8?B?Yzh6OG4vVEFxZjFQRFprWkltUWlmSkV6TU94WHAxdTVqOU0xaU4vcExxRmp1?=
 =?utf-8?B?ZHBneVFJWndoVlNRVzEwRFIrKzJOQ2U5MHRkYWVHOUg1TEd2S2ViLzZiQmdP?=
 =?utf-8?B?ajJGUWpVUHpZSFdVWms5ZUdZcFpyUWY3U1ZzUWI4bUJmeVpsVW1keDdUYnBZ?=
 =?utf-8?B?ZCtXb2kzZUM2TytpU1J4TG5PSnNzK0gzZnV2QnlMSjdOdmlybGlmRktEdnFu?=
 =?utf-8?B?aTBIazZYUnd3OGgvb2FLcnltRFdGOHRnaFFaaWc1SlFlSWtMUERuZXlHZmxF?=
 =?utf-8?B?K0Juemw5dEdRU0VWS3BRTXJINE9DVjBlLzlaTktRejd3MVJ1QTI3dXFGQk9D?=
 =?utf-8?B?R3BVUmJoRmptKzQ0TENOTUpHdFlaWWw0QUhQWGQ5bmY0amNpYXpTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7b1010-bdd5-41f4-6f38-08de5d7c05d8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:13:59.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkr3ox8D1zxbQE3GF09+Xp0FgU3mNRT9y5ItfV4WMuDAr653ELR1GXOwiqH29WPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
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



On 27-Jan-26 1:09 PM, Jesse.Zhang wrote:
> Fix the vcn reset sequence in vcn_v4_0_3_ring_reset() to restore
> JPEG power state and unlock the JPEG powergating mutex before
> running the JPEG ring post-reset helper.
> 
> Fixes: c50beca39115 ("drm/amdgpu/vcn4.0.3: rework reset handling")
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index dd247abce1ab..e78526a4e521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1742,11 +1742,11 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   		goto unlock;
>   	}
>   
> -	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
>   	if (pg_state)
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_GATE);
>   	mutex_unlock(&adev->jpeg.jpeg_pg_lock);

Probably, we can revisit this later since ring test logic will make sure 
that jpeg will get eventually power gated if not in use.

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
>   
>   unlock:
>   	mutex_unlock(&vinst->engine_reset_mutex);

