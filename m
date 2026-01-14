Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2009AD29FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D34C10E5F2;
	Wed, 14 Jan 2026 10:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YeZ2bQqd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E76910E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2jhJ7zgsyHcjUrDyJBK1gmhtowHSpG2pww2n6NjWx7jOKDo9KN4T0IrJRwxLi1P2azo8R9xH7w5Iec/TlqNAy5iIkyftSNizmK1v2FwhfR6AaCnqANLb8siOA0XoE1ytuI3NW1Apba62kHUsJsp4RsMdOYZVtHg0o/QXQEHh27fBPjtJ2eklY93JYuHMgtmA8lhciMuwm3ncbvZcISns5dEUJjgEhMaLCTixkCS933EfYUUBqrgV+KF+W6r/rMtvw1aR+Npu/LThkH2JTmRetz4QgO4p2msmXHuoC2qeZN9rI9E3WEq29eWvgtgzkhQ5KLeOOpcXGcJWd6PV9ghaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJFN0nPGdLLyzrl0w6yxq1CsNjvYSMNS1hxZ+12DCVQ=;
 b=b8KrNw9BEV8vehceYcn+WAsPymZmIqng8CHUshrs67LO86G9U+nvoOSlrTalZnPjdB5141gm4Z1hPeMO3m5lxpqikkbuuhB8x9zkjqiYzhuqP8JYf7HCOc68FfIjciBrGzgQyVCozOSJr6lRh8NMIqzGJ7DgYgadoCjsPDaLWHtlQrz90c5puKSLvPojmO40k98Y08fAHG5sKMttm+Tj3jfq16Q8uPAcsdTqqdxUeoZNhrQ68xT2E1I7Dqd4xxvzGqnM5jzAp9NtJIMdddjYHASuDsabBAYNGOQBsmswoL9oj9rauR5rKIDZnybWWSZTMY3bpz84DYmsJhA52TbjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJFN0nPGdLLyzrl0w6yxq1CsNjvYSMNS1hxZ+12DCVQ=;
 b=YeZ2bQqdg8pIU6P++VQiHL9CYAai5H50/Gl/qMh20Osr7rLtOGPBeshLTfpkayBSI6+rYfw2I0EjPyZd3i7aGTJdX3UElsmlRJbsZ14vHAhyb0KI1HXhXsue2b2KpNF3517dcVoMx/U+fiD0g9rFFUmOKQNoG8MURxrS6Cx7QzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:50:39 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:50:39 +0000
Message-ID: <585f1f3e-6e1c-40b6-a7ca-da0e871ffb00@amd.com>
Date: Wed, 14 Jan 2026 16:20:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260114090056.356633-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::15) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b976a2-6e07-4e59-9680-08de535ac129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q214RnpYeWVtVzhrQkFlbnVHUmtnVFlzZVcwemUyNzAzN3BTVWV5K2xFOUpr?=
 =?utf-8?B?bGdscUNNVnk2Wk45RWdEam5ETkJhQmd1M2lJd24vb2dpVjcreDVsaTNLR0Ro?=
 =?utf-8?B?VWRGcDJvbDliT1czd2d2bGZsMDhGWnpvWDhLZ1NNSk4yRnczVUpvV2pacjdG?=
 =?utf-8?B?VEk1UnN2bnU0eGZ2WUJ2Z2NobjQwRDdxTGhVcTA2WWI3bnJOZTk1NVIyUjh3?=
 =?utf-8?B?OTFnY0FIWEJ6Y1VHR0owRjNGWkFoNXpEcHAwbHhXbXF3V1h0bTNlQ2MvOHpU?=
 =?utf-8?B?SExpV2E1cnh3S1BWSjhDWGhOYVIxNDZweDRGL3NNc0VIRE5xUElZUTROeE9S?=
 =?utf-8?B?d2EyWXY1Tkk5VVdWamlka0MvK2N3ZUxEWW1KSjJLM2ZxdTRJcWhiMXhyUUY3?=
 =?utf-8?B?ZHc4ZW5jL1d3N1h0cURRdkhMcDlRSThDNWw2REI3ZTI0Ti84YldxdlE1YUNv?=
 =?utf-8?B?ckwvbnYyQnpBaEI4K2ZaaUdiK0dLZ0pmVEtLZFlycUorZFZNWXgzZmhENjJS?=
 =?utf-8?B?WllXWXBORmY2OU9ySFNuSzU4SjFGMlBxb2UxWUJPdHFBd1FrdGdxTmNUa0Q2?=
 =?utf-8?B?OUxOLzgxa2FJcjlYS2svRlhRZXlTcGNsYmJadHY1UHNScDNZenJSRGNOYmhs?=
 =?utf-8?B?OVZxNWdhVjUxZWRKT3lvdWN6Y3NDeVVMY1RubjJoT3dxWUxTNE1nOWlMN2JL?=
 =?utf-8?B?Wlg3cHYxSHRzZm05eExJUy9NOVF4ZGxrSWNRdTIyWGlnd1FSbyt1Uk8yUElJ?=
 =?utf-8?B?Q0FmK3Z0eU43VDlYZkE3NllGVmczRlNpbURhZjJVZVVybXBMUm1WZUxoaW1G?=
 =?utf-8?B?TDBHdHlrVitEai8vTlNhL3BrbDMvMUc1MUxvWkxaV3VsN0szWDFXV05HSVVy?=
 =?utf-8?B?T09Jc05lakNtTjcrNnhzNDF1SldtYUhsYlhtWmtUN2U2KzJHaTJrMGxQa0Zz?=
 =?utf-8?B?eUhEVEVxWlRvNFlzSlY0OHoraTJSNFRQVGRQMStsUEphSk9tNmF1SEFIUXh4?=
 =?utf-8?B?ek4rWDE1MHNPQUNkQ1Blc0VhNjcwWnRJNDlCR21xcFExSWhSWHo3TmY1Q1gy?=
 =?utf-8?B?ZjZqb29nK0dRRDh4Q3FvMlZLMThOazNRY0IzSGVSbVB1eFRvb3diT3B3UWsw?=
 =?utf-8?B?WGJrd2psQ0grTm5tb1YzWFIrOVByQU5wSjk4QWMyalJETmpPRjR2ZFI0TEhR?=
 =?utf-8?B?Ym1KVFg2UmNYS3lBZlp6c1NhYllrUkY3RGFpOFRCVTF4U1B2UCtQVGpFYnVu?=
 =?utf-8?B?VlZVaVByWDYzK3BjV25PYmVacFhjeTVqMDNTNHpyR2lKSlRxSzdwVVk2MmF1?=
 =?utf-8?B?T1lRY2Nwd053angvdGgxTWFnSElYVXltREhVQWQ3aFN0WCtzdTU2MVREdUNX?=
 =?utf-8?B?bzd2VXpQWUVkOUFsa3JnTitreGpBcytiWDZRL3RoMmZidmtKeUVqUXpFdXpy?=
 =?utf-8?B?MklTUUtVSFk4R0tKSDZwenJNSWNqSmlWYzFEMlN0RGNvaHp3bkRWTHhVMVJR?=
 =?utf-8?B?cDZxcmFVejl2cE1waEEzU0VzN1NuUVdSNzFLOUdrQ3I0YlhNOGQvNG1SeUZ3?=
 =?utf-8?B?SkdkdjNva3FqUDBYRVRLRTdrTXpYQ1BobFlEWmg0MEJJUEc5NGFPbGxTUHRW?=
 =?utf-8?B?RW1DN0lZN0xDV2RqRnBzZFZ4U2RNVEFsYlMyOGtRWHZNZ0gwTTJRTG0xdTE3?=
 =?utf-8?B?OVVUUlNEWi9rZmVIeUZaYUhNelJjd1pnbnBUYmQ0OEJrTHdXWFkxQU5uZFpX?=
 =?utf-8?B?RE14blZmbWNud28zZFJFc1pWSDJmNFBZOW9tUkJvSWlVWUNOcXAwekkxUUNU?=
 =?utf-8?B?bEV0QWg2UXBsT01ud1ZnT0dKcnBuT2tLSkczaUgrMU5wa0s1RXdXR1Y2UG8w?=
 =?utf-8?B?cnJOWDlTSzg1aG1LYkY2MGx6bjJvK3MrckpSWUlhT1Zha0lGL3g0SkNqa3R5?=
 =?utf-8?B?RUNRRjVjVDhUUUhBeW4wNUxnaEtVN3ZkMFFkOWlPekdIRnFYdlp5Rmx1Mmxt?=
 =?utf-8?B?ZGFEcWlFdjhBS2hQcG14cVgrc0VKR3VCdWxIeGo4c0phTFFmM2I2eXF4ZTE2?=
 =?utf-8?B?MmdBQjR1dzkvQ3pJclNrMHVRWUlFZjYwSXBGdUU1TlZtT29hTGdrbXFoZXZS?=
 =?utf-8?Q?x78E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cyt5MU5nQm1XTUE4TjJXd2pzZjMrZmd5cVBwSmFKVEs5Zy9zVXhVLzZBalB4?=
 =?utf-8?B?MTBLZ3dIeGhvd2kybllKZ043TzRtQVRyZ3V6ZU9HTXZsb3QrZmVYOVFyWGUw?=
 =?utf-8?B?MzVITVJwYmhoT0p2QWdib1ZTRzRBc2xiNHV4blNTK3NKNTAvQ1FHRjlWZGd2?=
 =?utf-8?B?eTRxWWc2MlZheEZVSDhqYzZpck1SOFRUaVlmOVZuOUZHM01MMnZTV0hMYmRX?=
 =?utf-8?B?RVk2RU9jM1hxOHNpN3VuWHkyNXQxeGhValV0cEV4bkYvWnpmbk9PcDQxSC9p?=
 =?utf-8?B?V3hsYWZObTNSQkdUdDQ2Uk1xUE9RSmVzbENpSERRYU1IbFV3WjFySGZDVEtD?=
 =?utf-8?B?YXVydTBzUVVqUHdET01rMDlaRWZTMXFWYnZaY01WM1hEd3ZwRU93MEJVSUda?=
 =?utf-8?B?NVlpcmJTNXUyVFlvL3o2UDUrT1E5d2hkbmJmWjZ1aExnMGFwREtXQXM4ZnIy?=
 =?utf-8?B?ZFBmVEthZHdEaG9EQzRxTXpxa0dNVjMwZDBvVGgzcnFRb25EcC9OZkFaaUFU?=
 =?utf-8?B?ZkhCK3d5a1RYNXNDWmZsZHFLTHlPWFcrVGxuaVRidllUcnRGRXNPQUlGZE14?=
 =?utf-8?B?bjFlSUZJUGg1aThweldRUmNKNFJpUng5OXlqVDZscnYzNit6SVA2d2ZvOHFz?=
 =?utf-8?B?bi9MYnpFcHZRSWtkSmd2a1FCc0JWUU8wOWdpTlVjdVJMUjZkLzZaRTNKS0tS?=
 =?utf-8?B?Znh4MFBaZEgrenVnSjFHUDI4cGNGb0dpSFpZU2JvTzN4M3c1SHo3Y2RJOWxo?=
 =?utf-8?B?cXppNlRmNXNiVHBnSEFsWGFrVE9PVU5xQngvK2s3STVvblZHYWFGYmJSREtk?=
 =?utf-8?B?b2hzUHFML0VVRTNqUWd3ZWJBd3lUZkJaTkFkQnBobWpqTGVvS0gvelJZUUU0?=
 =?utf-8?B?ZWM5OGhXTmVsZVcvRnVSMHo1VTZOcEZaY2hNM09rclh6UGppQ2VFNVZteTRV?=
 =?utf-8?B?czRpM3pmNzFCQk5rcFhkM1N5ZDBXalkrV21NWUJ6Uk1kZjljcHJVcnF3dTlm?=
 =?utf-8?B?a3pBOXBscVdidm5TL0JHWlM4T1BQbmNMSkMwVEJtTnhkVHJDL1pVVC9sWFp5?=
 =?utf-8?B?cW9OSEdtSkRjOVJzRVY1ZmVvZzNTbzA0WE5VOWpBcVlBU0pIZ0YwK3hVaU5H?=
 =?utf-8?B?Kyt5aFlOTjQvQkFOdXJMdjdYQjVtbDNaVnlyWWRsY01yVHMvZFdCVnAyY1li?=
 =?utf-8?B?VW4yWEl4eG03UlVTb0ZTNkUzVnhyUXpzY3FCVDZnZ25POGNmYU5YandScjJw?=
 =?utf-8?B?REhMa014d0ZtTWkyWmRnaE9rMFZxUldmWGhYYlJ5VVZhZzd5QUV2RUF4ZnFG?=
 =?utf-8?B?VG15M0hsNXBka0gzS1NlS1F6eG84NmsrWWVuaGJNa2xHeThDWVZ6SWJXZTMr?=
 =?utf-8?B?NEdHcUdTaDBXWnQ0K3IrNE5HOVp0Y2JjSUtsNmFLeGFqV3RrRHJHaVdsWDBY?=
 =?utf-8?B?MHVEanEyMG5sUkU1V1E3b1p4ellJaVNVZVIybktmb2tuZFZoOEQyWHh5WGxS?=
 =?utf-8?B?OFEyQUFPSnJLREpEb2F4dDRkTEhEcXl2azlNbGc1UmFwdXI1bUIzU3VoOEtC?=
 =?utf-8?B?NURyU1VBL09QdHdqYlFnbTV3QkhOUlhqdXBTa0tNNVNMUHFXU3hsZ1FJa1lz?=
 =?utf-8?B?dlpaSWt5Z296a2k0d3Z5MFB0a3lIb2lGRVU4NmRRd1hPUTA1MlkrQWY1d3Yy?=
 =?utf-8?B?UWlwNVhRWG4zUmx1MEg3aC9jK0NaTWFjazFremM4TmNVWXl0TENvUHpDQmJY?=
 =?utf-8?B?YlpPWkUwUWdPMHo4UHcyRGVmOEFNS0J6TVBWM055TTZvMkZ2d3V2T28rUmJR?=
 =?utf-8?B?VVFsZElQSUY2VFVuMlU4REJsUEhtenJ4eFd5TGIrbU4zREozb0F0RmdtRk5v?=
 =?utf-8?B?R2VaT3FhOCtPV3RCbWUzY3UxcEZPc2h5RGtGcGpJTS9JMEZ4SkNxTTJIY0JR?=
 =?utf-8?B?T0tFLzhjcXd6U0VRdXIxdWJOUlNrdUdjSkdmTDFLWEhoVVB5Y0kvWk84ZnVo?=
 =?utf-8?B?ZjhtYkhHejR6SDBCNDJOVW9RYmFiZlhaejNqMTVjN0dqT2YyelFuVWgyY25v?=
 =?utf-8?B?OWxmcmFiRnBJbUZUY0tBZXdCcERuOHJmMHBlb0N0TlBvT0ZuSFRwK012QjdV?=
 =?utf-8?B?Ni9sQ2VmcG5rQlRPSzJPMUpqTjcxRnBPKyt0NEhhRE5oUTcvUjZ0dVprR0lp?=
 =?utf-8?B?RWtLSTNFTjhRSnVLUUhEaWh5cGUzd0Jja1JnOW9GMHlydjU0QjR2Wld2QjRF?=
 =?utf-8?B?QTdON0h5U3hab0JMWlpxSnF0MS9tOHluTTFGNW1SSHFiQ0ZZeWVzNisxR2x0?=
 =?utf-8?B?VTJOeFpiZ2VJM0pleXJXV0Evc2JzUnFlNVhwb05RallHK1VKbXJSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b976a2-6e07-4e59-9680-08de535ac129
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:50:39.3273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSYtR+BMioz1M31KVdKUTP1LYCsOJBLJ4P2x+s+V/QjG/PWGbUwWU/byxggddp1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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



On 14-Jan-26 2:29 PM, Jesse.Zhang wrote:
> From: "Alex Deucher" <alexander.deucher@amd.com>
> 
> Resetting VCN resets the entire tile, including jpeg.
> When we reset VCN, we also need to handle the jpeg queues.
> Add a helper to handle recovering the jpeg queues when
> VCN is reset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 +++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 42 ++++++++++++++++++++++--
>   2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index aae7328973d1..1a32dadf8c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1145,13 +1145,20 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   				  unsigned int vmid,
>   				  struct amdgpu_fence *timedout_fence)
>   {
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> +	int r;
> +
>   	if (amdgpu_sriov_vf(ring->adev))
>   		return -EOPNOTSUPP;
> -
> +	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
> +	mutex_lock(&vinst->engine_reset_mutex);
>   	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>   	jpeg_v4_0_3_core_stall_reset(ring);
>   	jpeg_v4_0_3_start_jrbc(ring);
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	mutex_unlock(&vinst->engine_reset_mutex);
> +	return r;
>   }
>   
>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index cb7123ec1a5d..31d93c10dfb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1596,6 +1596,32 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> +static int vcn_v4_0_3_reset_jpeg_helper(struct amdgpu_device *adev,
> +					int inst)
> +{
> +	struct amdgpu_ring *ring;
> +	int i, r;
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
> +		ring = &adev->jpeg.inst[inst].ring_dec[i];
> +		drm_sched_wqueue_stop(&ring->sched);
> +		amdgpu_fence_driver_force_completion(ring);
> +		if (ring->use_doorbell)
> +			WREG32_SOC15_OFFSET(
> +				VCN, GET_INST(VCN, inst),
> +				regVCN_JPEG_DB_CTRL,
> +				(ring->pipe ? (ring->pipe - 0x15) : 0),
> +				ring->doorbell_index
> +				<< VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> +				VCN_JPEG_DB_CTRL__EN_MASK);
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
> +		drm_sched_wqueue_start(&ring->sched);
> +	}
> +	return 0;
> +}
> +
>   static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   				 unsigned int vmid,
>   				 struct amdgpu_fence *timedout_fence)
> @@ -1605,6 +1631,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>   
> +	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
> +	mutex_lock(&vinst->engine_reset_mutex);
> +
>   	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>   
>   	vcn_inst = GET_INST(VCN, ring->me);
> @@ -1612,7 +1641,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   
>   	if (r) {
>   		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
> -		return r;
> +		goto unlock;
>   	}
>   
>   	/* This flag is not set for VF, assumed to be disabled always */
> @@ -1621,7 +1650,16 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>   	vcn_v4_0_3_hw_init_inst(vinst);
>   	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
>   
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	if (r)
> +		goto unlock;
> +
> +	r = vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);

This doesn't seem to handle any ongoing jpeg activity before doing a vcn 
reset. Is that fine?

Thanks,
Lijo

> +
> +unlock:
> +	mutex_unlock(&vinst->engine_reset_mutex);
> +
> +	return r;
>   }
>   
>   static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {

