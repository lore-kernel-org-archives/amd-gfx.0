Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C41D2592C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 04:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF27110E036;
	Tue, 27 Jan 2026 04:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5rbJWy7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AAC10E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 04:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGGM3rBIYeA8DIJfLzviN/q+NE56ohApy8VCnZoMsoGPyLWx0AIAWYIU+wyKf2fMxzN0cj3djl8VxMpPwcXJz8xaoSzDSbxS+Err2UcUQ0wVgs+5x7euFs62LfOAu0otzMQtceXR7VK/RZuLxlmTuhUZWKjer2y+8yLev9ydR43r8vxbG2oAU/n/sG3qnGQWCJrYzRk3q+aKbv84g1mDTXNV2YvDeqF5w3ZZHVIUNQXZdzRdJtgApVu7ob/Rkr20cWEsh/SYX2oi1E2xt3G66lT1KlWkisxoZEP+btKKeIfvaZVqVnIJj9r9DV2pkz4OyJw9hxDLcLIah/vZvrZaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTM1EeC0c6O03syr7AA1qDprH6cPbBzaQu05cyvmp7A=;
 b=nQo8Z8HE6K9mxwAHY5ljW7itNYGoGLqAUWvDHyqVbLzEZnWCzp5ckt6+qE1EZvpVVITQY2qdMyW83r72RQxPETmYyjA1vIGGdSJev8DwZfCHrE3S0FhPxHvR+E8q17hwLdc0qVF9ylY7LPWEnUnA3rFgcfgksnfns8bSLLggoaqVY504ropSGqf0jvB4jRsRIsTyBh6imSLlsphdSFNzGUG8cU8aRpE3dG4nk1+VCLcoazsOGCPH2IJcCljKM5aYm5xLas3XyL+XuqccpoHDKm2RtnbCePef5W1bL0oAt08MH+2YA/v4rCeUzxgu0BiW/VorEq1KN4uWDR3PfmcBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTM1EeC0c6O03syr7AA1qDprH6cPbBzaQu05cyvmp7A=;
 b=Z5rbJWy7gxN4v6LWg3rBrVoq4xzpwuswauKtarXoHSxNDy/CbA16+gtSjSOdfrOg0L72tZEDjRw70E5Tlqx3uUZ6I+wlDjS3uoezqmAdxkgqC958Bgt8G1hdeLsBc+CvcLyHR+O2+NoKkbJG9TZ02583EwW/0NZQDKTeEAkh0a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 04:52:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 04:52:26 +0000
Message-ID: <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
Date: Tue, 27 Jan 2026 10:22:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yifan Zhang <yifan1.zhang@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e632ee6-ee65-4279-fa23-08de5d5fdde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0l4M0IrdlR1Q2NvWTBaMDNBOUJZakNRVklNcmVlUmZUMVk5NDVSMkVQYWRw?=
 =?utf-8?B?a1dmMnA2dFZ4S3R1ZkNha1Z5d1hHVjFGYzNIZ1BiUHNrRm1uUWVNTE9QZ3N5?=
 =?utf-8?B?R0NnYUlRUytGSmdpUnYxMElTRjdDdlh2b1hHS2RqZ1F4SkFEbzB4b2xwQm1k?=
 =?utf-8?B?UlZrWTg0c0NQL3lTL1RVVmxYZ1M4RHNMMmxxUGxTMjZzM1BuWlk3OTlDb3Nw?=
 =?utf-8?B?YStqeVI1N1Eybmw2QjRvc2NHN3JOMW94R1VZOEpTbnM3TmIrVHNkckFjQm9R?=
 =?utf-8?B?M2ZJSXZtVG92TDJmWU5UTWtpMVFXMmlOd1RYa3M2bTU4azVrQ1RQNjNINHMw?=
 =?utf-8?B?TVA4MFh1ajhOb1VDanlQL0FTcDJQOXY5TUJCTmdsR1RhSzM2MVlQMHA3LzVO?=
 =?utf-8?B?RHNFMnNoMU9oM2JNYi9JSkRscCtjaEZmTU00SkRLZ1VGQ3J0QXJVbHUxakpk?=
 =?utf-8?B?Tzg3YURsVmJHNjZYYnd4ZU9pck5DUkIxSklmZnc1MjdZR3A1TDBnQysxVUdl?=
 =?utf-8?B?K1FEREprMDdnSnhBTnlWQjk1Z1M0bUdwbjZZUURwZThDZE5BU2UrZkNCaWxT?=
 =?utf-8?B?bFdXUnV0cm9pS3JpaDhoSGNhclZhY0cxSEZLQURxS0lSNWFFZUFzTnJmZDlZ?=
 =?utf-8?B?NEk2a2tZV2NNbklXandhYXAvRUIxUVhZTnZESWFJY3JvZElGbkRrWTlzMXdw?=
 =?utf-8?B?anlydlpjdzhPMG9QVTVwbGN4a2RXZ2F4OEFXVXdzZ2RydXhIamNSNmlzTGZw?=
 =?utf-8?B?cFVaSzVDWndNMG81QkJ3dklUTERQNm9ORmwzaHBaa0tzMmd5eWx5UkRFNzNP?=
 =?utf-8?B?SUpwckg1b2ZzMWUrRDJyMTAzQWlRaHp5eVQxWCs5UENteW0rdlJrU3hCaE53?=
 =?utf-8?B?c2RvaU92OHoxaDdmYlZxQU1ZeWRnNTd1anN3RUhqRjFmZFdpWXF1TmZyZ2V3?=
 =?utf-8?B?bVZTOHpyaFZJYjNVWW50ZEljbUNFTXJwV0JMSUxBcWlTQlVyNk9mUm9PQ2ZO?=
 =?utf-8?B?dUxuMnBTSFhDTU15RndTZU5YVFJNUmx1SkU4OWs1OG9WaEwrdTVGdjdmUmR6?=
 =?utf-8?B?UGU0L2RkWjNhZGJzYnVDT1gzaUFoaGdMSzA5aDgxOUFVazB3QlBhWVZjRUpL?=
 =?utf-8?B?Q3N1TTJsMFliUUI1QlBkSlJnUHNxM1hndXZIN2tlQWV3RnRQdE1wdmJpbkZ2?=
 =?utf-8?B?dzZ2RnV5bklwdys5bVNheVFNRjJTakthazk1bUhHbTQrdmRpZGNJWjJGQzM1?=
 =?utf-8?B?QzRIaWxPdk1NMTVza0xHU281ZDZCb0JxU3VuOWd0NVpjTVhFQU5pd1NtZkpk?=
 =?utf-8?B?ekVMdkFJZjM0WE5EMVpiL0g2amRKMjZENmhTWG9UdDVOenB3VjNDVGZXSW5B?=
 =?utf-8?B?S3JuRlN2aW45a1FxNHRySVBaM2V1TnZMNFY5SU5XQVNmOHhMSW9LUzVVNmRE?=
 =?utf-8?B?Y0Z4clBsZFAwdXBxMzZFd0crS1ZlQzRXNjlkd0Y1OXFhTFZyajVuM3M0bUxh?=
 =?utf-8?B?TmNKaWdFeitjM1dIbzFaR3g4M25hZmg3RWx2VjdremtlNjRvZ2pMSVFpM2M4?=
 =?utf-8?B?dy9jdUY0cklrdVMyUENMWHpidXlYME1jWkpTNmRUR0E2c3d5WVpCdVhQZUZw?=
 =?utf-8?B?SGV2azJaTGExeVlsM3pJc0lwRVR6MWozb1dkd011dllyZUN4SE9oeFRQT1ht?=
 =?utf-8?B?UERIYjdra25DRkFRWVBvU2RWS1RBdUJqN3R0UmxVRGpWUU5xaG9uZWlYazd6?=
 =?utf-8?B?enJjZjQwTjQxc0o5SlYveHBRNURzd2plWEtxY0VVNWlpbUJpVkxmcHVMWUhB?=
 =?utf-8?B?WUJBbHRCc04vdElFVEJtMzNqT1liMzI4ZnZsa2M0ekdTOTZuWmppRTdhUkg2?=
 =?utf-8?B?UmpaWm5lSVEyMVV0N0Flc2hVbzRSZHM2R0VEZWhEeU9sdDluazBjWCtCNnUw?=
 =?utf-8?B?STcrd2kvYkViN1lZRmxncGdNWGlremZRSlZPSmc4eEdIT01CRGNFeGdvdHpj?=
 =?utf-8?B?VGRQMXROWWVHbTNYMUR5Rmc0ZUtwYUtkTEo5ZVI3c2ZqMmNQeUV4VDAxVVZT?=
 =?utf-8?B?R25pZTZTamRHT1BLd0dxWlZ1dkdLYzZiVTJRQi9PNjJDNW5WS3lOUExpbE1N?=
 =?utf-8?Q?7tXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzk3SVFhMklIdHI5MVgwT1NyeGZvT1Y1M241cHZFR3pGSlg3eG1PR2xxWkhU?=
 =?utf-8?B?QWJEU0NPVXNBeGpObWVSVkoyRis0dDR5RlovUnE4a29ZeXA0enQ3U1hRZnF2?=
 =?utf-8?B?RklSRTNMNHZtSVExbFQ4ZmJ3RkR0MXRYcysyR1g5aGNTakE4SFhoK3N5Sys1?=
 =?utf-8?B?TnRPcEZyd3NMbTZuN1dsTjJsMWpaa2MvWFZ4TGJSMkJVd2RJZEhRVjNqUzF1?=
 =?utf-8?B?QVZTeXFSQjQ4TFVuSG03K3BNS3ZHVmt4Q1ZPOXdqTFhIcERPUmVQU3ZpdzRJ?=
 =?utf-8?B?UjQ3YzlZTXZSK1BSN2liME9PeEIvMzBKMm1GWTJkbVk3dkhDM002YzI2QVk5?=
 =?utf-8?B?RElwRUJXUzh6d3l2dXJVME5qd0FvM3YzZUhBOXc5amdoRkY2Unl0bUdDSnFm?=
 =?utf-8?B?Uk45dWxlSlpVcFp3QTBPWll5bEI4ckZEaTljclh3VVhsc0lRYmRNYmRWR2pT?=
 =?utf-8?B?Zmo5V08za1grTjl5UWtWamtxU0szVFlVRExQZjQyNGU4VUZ4UTFrUUpxSUNh?=
 =?utf-8?B?Nzd5ZDZMUTFBRVZrZk5YcHJmMXdHWHdWMzVoSVkvVUNHYTBETXB5L3J4bWxt?=
 =?utf-8?B?SmN2NG80eXU5VUtSamhjMk1DQTYydmxaOEg5elNYMzZoV3dicFhLMkRBcWJn?=
 =?utf-8?B?ekU0a0Fqbkcycm13YlNQNnpEUjlDUmNTUmt1UGtNWWxPR01lSGluZVJ6K3pi?=
 =?utf-8?B?ZkpyN0VvRnV3M2hUbWdsZ1MyeWI4SnNvaVlxa3ViU3BPS1lVOGFNNFVDVGxK?=
 =?utf-8?B?cHArb2RUMCtmNFFZaURNTnUxSmFpMnBTcTNFVTZnNTR4U1U4MHJZMmdRd0My?=
 =?utf-8?B?WU53cHhKTTR3L0FCZUNscEt0WWxWWE9iVnczSHZDTDlaU0ZDRmJWcjkxS0tT?=
 =?utf-8?B?bjExMjIvNCtnZU9XNmdUWkZ6ZE02dXJiY3M0S1dnTUdZYkFIa0Z2SEFvYjRr?=
 =?utf-8?B?bDlzb0UyY0hJU2QxdmltRW1OQ3BNMWJIY1ZaelYySUZSV1FGem1jWGFzSDhZ?=
 =?utf-8?B?eTlOLysxTXBVSjA4Yjh4NDl3VHJTZk4vcjR0ZHJKb2hFelNrZ3grZTQ1RUd2?=
 =?utf-8?B?R3dBUzBtR1M3WWUvNk9xdm9QbkI2bC9zOWpkV2tkcmJqVXdkQ1BmNFNaTVBz?=
 =?utf-8?B?SC8zTzkzUHZIV2VVV1lqYVg5TnBTTEtHQ3JMVENUOTJPUDdHY3Y3UVA2dlR5?=
 =?utf-8?B?dXlZVjdZeFMxQ0hUdTV6RHNYMkY5V2ljZFhsajYvdUJrbWVKRDVsSlhhQjVr?=
 =?utf-8?B?V0pNaFdHK2VHUWFFd1JWUDZlZFNhYVM0QVBTRmtkeWlQN2JlTkJJSGhXb2pa?=
 =?utf-8?B?TVN1QS9MUDgwWkFIWGF6aE5JTksxOUJ4Zk5Ua2QzZkdDQ0pVNXozVlBUS0VN?=
 =?utf-8?B?TXduM1lnaTBSQ21OYlZwSHJ5cGlvamlVR3JRWnVmaklTUnhhckFVNlVmRURs?=
 =?utf-8?B?OG90LzI1d2lQdllVeXIvUm5hRjU4VDFCcHRjU21jSjhlblpLbHN2bUo3RmJR?=
 =?utf-8?B?MGN1cHd2ZElFRW8zUEFQeWR4UkgxNFJDNHQ5STlicUtnMmlSdXIzTnZSYVZR?=
 =?utf-8?B?ZDhUQmFSOUw4QTQ0RGpzaHA1L1JaTFBaQzFHV1JNVXpoS0NpMzJuWDYzL0Ur?=
 =?utf-8?B?VG9ZbWJSemVRRVRQc09ERys0cEZIeWhoV0Z1bkFRdlFlK3FzbHdOY3RkdnND?=
 =?utf-8?B?a0dBSW5NYm5kZnRFaCt2NDdueGtUV3RTZFJTQTFnclh4dEU1QnR0MzZaei9y?=
 =?utf-8?B?Q3k1UWswU3dLQ0Y2QzFnMFVIeGRRNXAva2hRa1V4N2M5eGg4MVAwSDRYd3pY?=
 =?utf-8?B?Zk10NEw2QlozMTM2S3lvd0xqZW4zaC9zaGVuYVk4TmN6Tld1SDJDQUE1M3FI?=
 =?utf-8?B?SktOTVVkY0RlbDRoSzJHbGRpM3VlbThodEpPTnhMMHlMTmg3Tmh6bVZiL3hl?=
 =?utf-8?B?Ty8rejBsNzlCZDRYQWl0emptcENPcFRaN3JYK1Znck5rS29wOGYvZ1JYRlJI?=
 =?utf-8?B?Sk1wRTNTMFBhVHAwZXJxT2Z1SHBzVy93MHN1NFR5Zm0xZXFURnNpakpJa0hF?=
 =?utf-8?B?bU9hL0JoSEM3NUpKbnExYjdSSnF6cjdXdW9KWmZsN21nbTcwSlpSRUsyOUZF?=
 =?utf-8?B?dlFmTmoyLy9iY0tGZCs5QjVmUVRmMWRna0lFSjc5TVFOckNPVlExdXIyUnpq?=
 =?utf-8?B?RlhzRGltd05tdHNoRHdDL3ZxYkEwSWFqRjFScGZyWTZ3aGNDLzRsTWxOY3hr?=
 =?utf-8?B?ajFLNGtrOFVCOXZBK1Q5SCtIcWZMQkxKdVl6WUFXTFBtVkJuaThvMUhia1NK?=
 =?utf-8?Q?SJBb+/Fe0tiBfUAWlJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e632ee6-ee65-4279-fa23-08de5d5fdde7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 04:52:26.3148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2B08sOLoCAtN554hdNjlyieqLXtyQOuJ0ZzVeX283Lz8UXbk8ztsj+38ER/bmMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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



On 27-Jan-26 1:37 AM, Alex Deucher wrote:
> Need to make sure gfxoff is disallowed when we touch GC
> registers over MMIO.
> 

I think interrupt enable/disable sequence is only supposed to be done 
under ip power/clock ungate sequence like in hw init/resume/suspend 
sequences. The fix probably should be in the higher level sequence which 
doesn't take care of that.

Thanks,
Lijo

> Cc: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 36f0300a21bfa..05178ee8e0e3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>   	u32 cp_int_cntl_reg, cp_int_cntl;
>   	int i, j;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   	case AMDGPU_IRQ_STATE_ENABLE:
> @@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>   	default:
>   		break;
>   	}
> +	amdgpu_gfx_off_ctrl(adev, true);
>   
>   	return 0;
>   }
> @@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>   	u32 cp_int_cntl_reg, cp_int_cntl;
>   	int i, j;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   	case AMDGPU_IRQ_STATE_ENABLE:
> @@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>   	default:
>   		break;
>   	}
> +	amdgpu_gfx_off_ctrl(adev, true);
>   
>   	return 0;
>   }
> @@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>   					      unsigned type,
>   					      enum amdgpu_interrupt_state state)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   	case AMDGPU_IRQ_STATE_ENABLE:
> @@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>   	default:
>   		break;
>   	}
> +	amdgpu_gfx_off_ctrl(adev, true);
>   
>   	return 0;
>   }
> @@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>   					      unsigned type,
>   					      enum amdgpu_interrupt_state state)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
> @@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>   	default:
>   		break;
>   	}
> +	amdgpu_gfx_off_ctrl(adev, true);
>   
>   	return 0;
>   }
> @@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>   					    unsigned type,
>   					    enum amdgpu_interrupt_state state)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	switch (type) {
>   	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
>   		gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
> @@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>   	default:
>   		break;
>   	}
> +	amdgpu_gfx_off_ctrl(adev, true);
>   	return 0;
>   }
>   

