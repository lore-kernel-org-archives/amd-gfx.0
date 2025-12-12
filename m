Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D72D49223
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 13:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313FC10E348;
	Fri, 12 Dec 2025 13:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqO8wFp5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7771E10E116
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 13:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqMRVQwuEZ6gMQNYCJszATl54F+TP99EpUUhgmYTk2MJGrHPid+A9qGmNH4e8aVZSTSzT6X8rUGWLqb2U/1/RLFHq3WN3gN4nLLZkdTMhfaPRdvaKvPirp5zwm9EXQEIHxpmLJ4HTE+mD/c4Kc27ZF9kc4+mefIk3J9tnNAjVxqGL8zs86wwhl25rBSrBPm7WfKLZJIfJqllNVBnNA+IL4Kmk7fblV7MonY1Oag+CsPxMEs9JSToJ9jb/69mOKMRKjRZdpo2KpQRACvWfznRpHctNMWSiAzG33g1NkcafbcHo7IViKseaq00AwdRcRhDmjF35Db1TLVEc7ixqr/uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kNBIVhD2NqwMoY6Wb8IfpxstppB3xjBWgHrMCBN1zk=;
 b=lFlI03+p/L6Otw0HnloePTEfS2uXPk9jlrg4ZAMcsa2mYKBci/zI2bNoYG2NTFDHPak1Dj1DeVrWEsbne7ZYPVLV4ydzfrOpzZC4Q4q1viVuuZTCCa/su1OmztNImspdJddX2S0exTmTYZp1BgBVrdMyJYJEIzwJgtZdF0ovVErps8RQiZN5e2pv+OA9c0JIX5bRf90y6CptKf+QOUN5LAPnEB0tap+Bov78shxP9PjlrzXI9ejP+rHMjed575/HQF7zMmyRB+4OeDRp/G3IQgaqlf/l1KSxxizMa5JN2CEAoiyyCEryF2FKjr5/fg7dGo2n3ylm411uSppSPSg+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kNBIVhD2NqwMoY6Wb8IfpxstppB3xjBWgHrMCBN1zk=;
 b=EqO8wFp5LEtm7KR58jCHR4YAuAI5p77+FpJWTs2bTRMXE5m3F+st3JqphBGvCeL36LW1aoeSu0VHtX/iLoYydAJV8IcTFrJdHh1dxz7aGXF/sj1IS5nWjTkQC5F9Z4ddQIm/qOj3tKKnX4b4oVO1i9DYjvvKLlRN3ybv165Auk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 12 Dec
 2025 13:01:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 13:01:24 +0000
Message-ID: <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
Date: Fri, 12 Dec 2025 14:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <871pl0567w.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f1012b-f0a9-4dc1-316c-08de397e8da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTVBZExacVBWUEZCc25rMVV5WG8vbkxrYnRsUHVUWkZ3WGZ2czcydUoyQ0J6?=
 =?utf-8?B?Mk5xZmQrbjlWMmJkZ2g3RmU2Vkw0aUVQdVVSMHE4bEZmdS9wUWdSKzcrWE5W?=
 =?utf-8?B?TWJDVWJ2WVRDSmVBTXNnNUxQdnk0ZGxYemV2UGY3ZVZGSlI3NEdRTFlpOEN0?=
 =?utf-8?B?VndZM3Z5cXlhZmxyNUZTSGYrUGNSeFJlYlcwMWNHY3VGeDhuZ0oxUy81MER0?=
 =?utf-8?B?MFVkR3dqOEF0NG5rSndkYTBMTjhBNVdnd2I3MVM2S2o5TVlPN0hHSjFEbHZR?=
 =?utf-8?B?RTdkZVBLcENJeEptemZTYXJOYU1PVGxkbzFpSHgydUZBSEVvK09LU1NvQmRY?=
 =?utf-8?B?ZDFybTMvbWdvK01YWmFTTXlJc083dzFRK3RaYmhWc3dXc2pKeitycklGOTJv?=
 =?utf-8?B?UHU3UHlWdVlkakJkakdPRDJJaUpIWFJQUVJaYVI2RnlITXhaM3Zncm1sSXdw?=
 =?utf-8?B?UUJBTUh4K2dGcXk3L1NCK3NreXFqVWtGV1BIZWlnMFg5RW85SThwMW1qZFFh?=
 =?utf-8?B?Qy9RaWlOQXE4andVdS9DckZlVit1NkZISEV1YllzcXNRVncyQVkwSEtDQm5z?=
 =?utf-8?B?V3NNYnVTWnhCSHdYaGlhaWNLNjF1cWlFQkJYcXF5N0RTUXRVQmN3T3I4dElQ?=
 =?utf-8?B?MmVsUk5FbkR6NTZPbDFmS2ZvemFhUlhGL1FyeDNENkUyOW8wWFdYbDJ6Zk1R?=
 =?utf-8?B?ZXlkcmxvb0RCUFhPZ0hqb2xSSnFnT0NoNFFwT3JzRjU4ajNuck1MRTZKVkgr?=
 =?utf-8?B?Z2ZFN0lVdDdFUFROY3RSZ0VvUG9tZkdJVmJvNGdMaENkajhGUVdpU3MzVnVz?=
 =?utf-8?B?TEtKaCtFT3JFRDQ3OWFYcTlGc3p2UitEMzg4d3ZudUpXaGNza2lSN2pLSG40?=
 =?utf-8?B?enIvakliZEw3eWNLUWFnS01GREFUSkp1TG5LWmgrb29qSUlRM0dtelpqdVA2?=
 =?utf-8?B?OVpaUDJnY3ZMSnEyOG4wMUN0cU1wWFIzVG9wSll5REZqU0o2ZElJZzZlc3Ft?=
 =?utf-8?B?QUNpSno2bTFFcmpxY3JIQzVPcTNuOGRPSDc1MXk5NFd2UU50elgzU1BEaGNB?=
 =?utf-8?B?eHhFMk9sN3RoNGJRQTQreW5iV1d1SWg0SnVmOVNhL2doUDBBUyt2M0VqUmVa?=
 =?utf-8?B?MkRBd2FwMmlUVnFWVGFUOEZNTFlVMUxFZml0a3FzMGEvNWMwK2lRNzFmR3lC?=
 =?utf-8?B?MzY3RkJRdlRCNlovY0hlZGxBdER3Y0lTeW9mb0M5SndIYjZoWklaalg2andF?=
 =?utf-8?B?cnhndlphVzFpbTRpYWZmNmRQQ3FrY01uVWVJdmppbk1ENnpKRGtPa1JSd0xR?=
 =?utf-8?B?R2UwcUJrb29pNEVaZnBFM2VpcmVMYTRMRnZYTnoxdjNaN3dnODN0UjhMYlNH?=
 =?utf-8?B?U0tlL2tsdGpMdlpvcUh1RHdOU3p2Yzl0YW9TcTZZZjUwdzRTdmpPdlh6d1ky?=
 =?utf-8?B?bXlQY2lzSW1aTUFIS3RGMFVrVXBlUlpCVEs3a2xEdTdrUXdJM2x1Uis0N3BO?=
 =?utf-8?B?elZRaDV5UWhxMUtsbTZoTHgzMTFDUGxMNHUxNit6REZlRHo2ZDVRZ1lCNXh0?=
 =?utf-8?B?ZFliY0tEZDVjZ0t4Smh0dGtiWndMZG4wZlgyMjBoalRLcndVSW9oTkNvNEh6?=
 =?utf-8?B?VUlESE9LeDdaY0Q5NEQ2S2RHbWJqNUtKZjdyUDVVQlNOVm1FZlE0Tk9Gb0Fi?=
 =?utf-8?B?NUxPWVAxL1JPUC9oajlxV0dIOG1UUjNvQ1RMT2RGeW5tVTlqR3FSMWZNV3FQ?=
 =?utf-8?B?b2VCendGV3hiYUZ2N2JHYnp6R3Y4WlV0eGI1WEJMSk11eU1ibU9EOHM0QnlX?=
 =?utf-8?B?dWRSWE5YNzZKb2g2bzZ6WWQzbjRhb0JwRmkxem5qUFhlZEtCbzQ0U1p5eFBZ?=
 =?utf-8?B?QVpoVisvVGdrNXQ0Y3l5c3ltRmROQXZRZXdCa0pvb3BWYmZVSHhzQmpUWmk3?=
 =?utf-8?B?RUkrTFZrVmE0WDBqUHhsZkErR1ZQRlpueWRzOHNlSnRXNmx3Q2UxYXpFOXor?=
 =?utf-8?B?bWRhcDZveDRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3U0WnFhTVdMSzJhVWdSeWFEZVRrWXd3Z1B0MG9Sd2pnTjIzR0tQN0E2aVl5?=
 =?utf-8?B?NlhyWGszK3FJWDRHRy9YeUxhd1MvMnJKblRlc2V6bVljZW5CUnhXaWR1Ymhi?=
 =?utf-8?B?cjgwRUVNdE12azdCRlhLTDA4eTJWL3luK2ZJMDN3Z1ZmdHZYT052MW4zRUlU?=
 =?utf-8?B?YllMOVdrYkFiMjRkYURqRUVBbzl4b2t4NDB1SHpXVGxOQThEWXdsUGFPVUFy?=
 =?utf-8?B?RTQrbHhBUWFWc2NFbkpwa1JhYWNsMVh4d2EyVWw4b2JIZlM4alZ2YU82THpt?=
 =?utf-8?B?ejNIbTZyVEU1SFZjU0t5SWdTN3RNbDc1SzBBQ3EzSjh3QUhJQVNlalNXZW5W?=
 =?utf-8?B?WVdoRFFtRXFiLzdNNnM4Wk4yZWZvZ25Lb2w2MWpHMXdHbzJid3pnZEtHRXRk?=
 =?utf-8?B?Nk1KT2liZU1QSHphRXErOVVOdzZXL2hwcllvZTlGSlZmUmhSd2luZ2ZLYU4r?=
 =?utf-8?B?Z0JwcUx1NWpFTTgxRmcyUmw1TUFCSmg5ekd0d3Bwa3lqejZ1clNHc1Uwem9r?=
 =?utf-8?B?czBiSkpmdzgxdFpRL2tya2dhekVoM0ZwSGZ5RFVxS2dPWHUxTktId0JyVVJG?=
 =?utf-8?B?bmJCa1ZOUzdRQ3ZHUlJIaS9LY0ZGVHFMSHl1VEJVWWZKV1ZodGltcWRVaHl3?=
 =?utf-8?B?dnBWRElKUDQwWmNldVdMNkhjalA0SjRxWDllM0pscXBVUHM2Z3Z1UkJUNTda?=
 =?utf-8?B?OEM4UWhrYXV6MXk1NFFsOWxsREVEVmI1cFRPYTUzbldiOVdyUjdiUytHUEJ0?=
 =?utf-8?B?UCtmSGhxU2xiSmJqYmx6azBiQ2JzM2xxNDZ5WHg3N2NNQXlPV00zS3lIa3FW?=
 =?utf-8?B?WCtmakpaa2gvTW1wOE9MQjdmeE1qcXJXb0toZmJCMEU5dXYwMHRpMGRvU2cw?=
 =?utf-8?B?N0dlTWRSWGExcmQ0K0JPSzNRSXhiem9yUWRuMWpDeXBJa3VPSmZkSkNUNDVa?=
 =?utf-8?B?SXZxalZxS0orZVFzMXVkeW5HWG95SU5TVGdVSXhjeHQ3ZlFEOWlwVmdrWGR3?=
 =?utf-8?B?Q3diL2JjOWFmZjhlWEU4WUtKREhFMjdNUFRVMFowSWZob3p5VDVtRy9MaXRH?=
 =?utf-8?B?TVduWmtZQ3Z3SEt4STEzaEU3d1lMSnQzSmF1MjFlWnludDRqQWxZQlB1dDFm?=
 =?utf-8?B?eDk0V0FtdWVNWUhrbFVCVXRBdjUyLzNGZXU4cS9JWnhhL01Qb0hoTnYraWI0?=
 =?utf-8?B?QnZLV0U0aTE2dldrMlBiV3ExRkhNb3JLMzBFMEhNQnJSSWYyMVFRVzhPcHIw?=
 =?utf-8?B?elFUUTRsVHFkY2FJeGhzQ1dHcjVSdWFjZE16Mnk2eHQ2TDgyVTY1YTgzWmtK?=
 =?utf-8?B?dmowcTFta09uL2Z2ZEhPckxnU2NMU0tYYnJjMEJwdFN3Y1ZyNzdsZDJiMW9t?=
 =?utf-8?B?b3Z0UkdRZzZuS25mdDNFaE1RVXZDUC9WZHNJWGxpR2VXS3VIbC8vdk9mdkxz?=
 =?utf-8?B?eDZleCtwYnAyTkFpNG50cEY0Rk8yY1MyeGl3YXJCZmFUT0k4SVRxKzFCOGo0?=
 =?utf-8?B?MTVZWmFmY3VadkxiSnlHUjZIUDBtaGRuMW8zTFBtaWxESFRIb2kyNUhBQUVx?=
 =?utf-8?B?ZEhmM21wdFJDMlc0OEIvNmp5NzgyTUpnb05oTTBIcko4SlNFb3Iwb2llZDY0?=
 =?utf-8?B?NnJRYXBaclQvLzU2YnJuUDhZeFpiUHBmbGJLQ0swa3BtV2JqVlNUdU5tU1Y2?=
 =?utf-8?B?UzF1ditMTjBPSURxT2pMMEdsdStvR01FTDdiaVpzcHJocDhmZW1BZHdUTUtB?=
 =?utf-8?B?a2k0OUxKV2syN0dwaVlQcVhLUFo5Ym9XS3hleWFVSWxkZ0lFYVlpUlI5Qmh6?=
 =?utf-8?B?UmxkK3F0bk8wUU4zSXA5Wm1nM25lMnh3WS9PVEVOZ0RGeXl6aGFLdHZCd1Ur?=
 =?utf-8?B?d244NmZIQzdpMjBJL1RUMmtIMnRYbUsvdDE5N2dyNGlnTlkwUllFYnR4S0pp?=
 =?utf-8?B?T2x3NXFXTzJFZEQ1N28xT25DRlJCMk1SOGJKRGhldlEvRG9hT2I1VFo0Vml6?=
 =?utf-8?B?NEdzMUxHS2VhYWdzR0tYekhZdHl2VldHYVZhV2NFU3h3dUVaSlVlM1RNMHZM?=
 =?utf-8?B?SXE2QlVJMlppdG9YeXU3eHZwdlV5Y2RQTUs3ei8wVERDcm4vYmUwSkdZeUIz?=
 =?utf-8?Q?XXEc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1012b-f0a9-4dc1-316c-08de397e8da9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 13:01:24.0149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSUV5PDHmatpIwiCpt2yqV4YPhZDOlC4QRM71AItM6AC5PnQa8yr244ZGWzeOwXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
> Christian König <christian.koenig@amd.com> writes:
>>> Setup details:
>>> ============
>>> System details: Power10 LPAR using 64K pagesize.
>>> AMD GPU:
>>>   Name:                    gfx90a
>>>   Marketing Name:          AMD Instinct MI210
>>>
>>> Queries:
>>> =======
>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>    these changes. Is there anything else that you would suggest us to run to
>>>    shake out any other page size related issues w.r.t the kernel driver?
>>
>> The ROCm team needs to answer that.
>>
> 
> Is there any separate mailing list or list of people whom we can cc
> then?

With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.

I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.

>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>    size HW dependent? Should it be made PAGE_SIZE?
>>
>> Yes and no.
>>
> 
> If you could more elaborate on this please? I am assuming you would
> anyway respond with more context / details on Patch-1 itself. If yes,
> that would be great!

Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.

The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.

The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.

>>>
>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>    Do we need to lift this restriction and add MMIO remap support for systems with
>>>    non-4K page sizes?
>>
>> The problem is the HW can't do this.
>>
> 
> We aren't that familiar with the HW / SW stack here. Wanted to understand
> what functionality will be unsupported due to this HW limitation then?

The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.

>>>
>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>
>>>
>>> Please note that the changes in this series are on a best effort basis from our
>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>> supported with amd gpu kernel driver.
>>
>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
> 
> That's a bummer :( 
> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?

You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.

This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.

Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.

> - Are there any latest AMD GPU versions which maybe lifts such restrictions?

Not that I know off any.

>> What we can do is to support graphics and MM, but that should already work out of the box.
>>
> 
> - Maybe we should also document, what will work and what won't work due to these HW limitations.

Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.

Could be that there is already a fallback path and that's the reason why this approach actually works at all.

>> What we can do is to support graphics and MM, but that should already work out of the box.> 
> So these patches helped us resolve most of the issues like SDMA hangs
> and GPU kernel page faults which we saw with rocr and rccl tests with
> 64K pagesize. Meaning, we didn't see this working out of box perhaps
> due to 64K pagesize.

Yeah, but this is all for ROCm and not the graphics side.

To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.

> AFAIU, some of these patches may require re-work based on reviews, but
> at least with these changes, we were able to see all the tests passing.
> 
>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>
> 
> Thanks a lot! That would be super helpful!
> 
> 
>> Regards,
>> Christian.
>>
> 
> Thanks again for the quick response on the patch series.

You are welcome, but since it's so near to the end of the year not all people are available any more.

Regards,
Christian.

> 
> -ritesh

