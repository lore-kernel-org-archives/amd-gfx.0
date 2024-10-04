Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66575CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5D410EA83;
	Fri,  4 Oct 2024 18:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yn/W/VTQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796A310EA83
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypSgfyfvcmiYYzUxrc68ZK3E/3IVlNGtJrRYfbSGLXAOXJKPOyYJem3mp8UnjmWZEtesZ3l8kWCIU13Q5jR/q/Dw2bFKUd8tJlEWh/Ebi2Ozvb4G7I06HPSSyjuyTznucSHgOREyYgJ/IxzZ7xIvBh4k9QE8nZ7ilFsZTaVR11lMKVm9sU8mWV1q2snaKOvBjml4Rurfwphbx38WnmDFoHvyLpn86E76uyxahbaGqi674Iba/cjIdndslXelVpREduBHT7kRNClR3UmNl4f8TMLHkslT2SkQM3b+heC85S00l3xge4BLjvmIIPZyBaJdU1r/3MUGjojhODr6Zg0xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dTkqKpGsiJu802yDN9eFkVqYeH2fjsI3r5l2olw6S4=;
 b=btjdn9MO1yPlxuNgOGQeUfyyai7Mjz6gYXbWbSY4tjLsnAe8FoDHB/5LZSGppFtlAcnWroJdc7/fEVKziW002OlNtbVuKm7iV9K8EJK/UrJWIB6DRumkIquNSiRk/pK7LjlUMFRzWrCLGoMGoO09dnUcqedG8DzYEoMf9KBT2+Hh9SHEY4lTixCqnzElFV4Q5F9Ke8ggJiB9ggaTPMmjYfjv25VR/1QvMdDiUJuI6uuViJCbbAAXFdX22QN3CnAvbvyDyByNjxLQldlsUgPqey+NmuzvWTzpbNVQtwgSlE22P5EXd6M//BSqoGWjJllFCpajm4IFzgDdYYjsw7qnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dTkqKpGsiJu802yDN9eFkVqYeH2fjsI3r5l2olw6S4=;
 b=yn/W/VTQlXGnqCakVX3F8YSeLWtvAcUGcSo9iYhVRNmxhGiY9CbvRp5XKYQbCMNGrPcfkfEmKfciPkpri+1gMrHinf/+buo1YAoDQieQ+97uIdfiOZ2uXYkX0IM9+FoRHd7nCec/tdlz1NaVRRdP+fYmIoapwYXxJ5i4JRMADt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:42:46 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:42:46 +0000
Message-ID: <64292a17-0bc7-4fc1-ad9c-e0f509a1e876@amd.com>
Date: Fri, 4 Oct 2024 14:42:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] drm/amdgpu/vcn: separate gating state by instance
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-8-boyuan.zhang@amd.com>
 <209c9c2a-1af0-4255-81c9-716658dba516@gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <209c9c2a-1af0-4255-81c9-716658dba516@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::13) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: c853942f-fc29-4d3a-ed37-08dce4a4569d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkZHT1RvdTRQNC9aK09SYlRjK1NXS3BaTzQ0MUd4R0pGNnY2VDl4Sy9CSy80?=
 =?utf-8?B?N294RDcwSTNKampKczVXcVJyOXhOZHJxQTRRbFNSMnArV1NhMi9YSGZneUpU?=
 =?utf-8?B?cFA0K05yaTdwbHZGa29RZ2g4QU41WjdkeCsvaTVaN2NPTElFU1hLTk92L0xl?=
 =?utf-8?B?VkVrUTdCZmxiL0RvMDd3aHI5dFVZSk95THc0R1BuMUR4cHNBa3FEcTZxL0dN?=
 =?utf-8?B?dmNLb2M5MEc2MWdEQkFOT01hRFZyZEQ3VUJYWXcxQkpiSDJocEJwVDUyVEFm?=
 =?utf-8?B?K2VqT01sdGZTSU1JK1RKNHFEUlcyZXVZaDRkNEFBMXZuSThkaTFwYnEvK25S?=
 =?utf-8?B?bkxJMkwwYkdhOGVJRXNiSnc3eFFMUDFrOUtRT2NjQXkrZUM5T0h6Z3FwbEM4?=
 =?utf-8?B?cUxmNGZGOUhJaCtoVjlHZ2tFNGVhOFNxU2dsbURZbTFTUFF0b0RIK1BteXBQ?=
 =?utf-8?B?VWhzelYvb2FrYXRKamlRZDhHR2dUZ242cXpEUStNNWhPK0ZmQmk2ZXpWampL?=
 =?utf-8?B?S203dUY3ZWo3cFZhUDliVjRyVnZtZ3hReVhTSGZmVWt4WlVKK1BSVnU4T2VZ?=
 =?utf-8?B?ZjV1bklDODB6SEYyc0cwMkc4bHJOSDRVN25Jd09jRC9XSWJyc1NES3J1WFRE?=
 =?utf-8?B?dG44TlNxRzRSUTU4ZU9iTnNaOFlRMmprQzJzcUVYL2xFSllQelJuNkdUMHk2?=
 =?utf-8?B?ZkxMNzQwVTdHOTFpMGhQWE4yTjN4eDhuR3dGNDhBRjJKZGVna0ZNZ2U3QkJY?=
 =?utf-8?B?V0V6bVNUeEpEUzVYbi9IeC9PZE56azFWOEVCNk5Kelp4Y2FXRHcwaE53bUNh?=
 =?utf-8?B?RGFPVG8xSjA2YlM4RTJtU3RYTVBYaGFzSHVhUXZidG1yTWkrcDF5b0lXQ0ln?=
 =?utf-8?B?aTIxditTUVY5RVNOSWczeDNRMThra0diS1d2THRwdkJSRno2SWlHOEhBNWVC?=
 =?utf-8?B?anZNMzhQeEFJVXpUK0w3L1hqNHhhLzZPbnFPZ1Fnd3BDSlMxTitMUi9NNVNB?=
 =?utf-8?B?My9ZMy9WS2NYTHpOMzNjTUlIQU0xSUFreHBJaGd4K1dEenUzQzdYL0VLRTZS?=
 =?utf-8?B?M2ZBVmpCOThTZGVpWG9Sb0JJME9idlkxM3hZYTFLRkZQeGgxV0FRdnJrTjNT?=
 =?utf-8?B?bkNxeDBnWTl3UW9lZEZERnV2NnlHalRlRFBDbUdPSEhmdVNEMXFLSERNYXMx?=
 =?utf-8?B?SitrODAza0QzRWFpajFIYVVxbnhqZmpydTB1Tzgvbkl5WkVnL2Y2YmtsRi9B?=
 =?utf-8?B?cmI3VnlYVExZSUxoVUZxaGd5TkU0Zll5a3plN1psWk9TdFk3Z2ZCaWZLNUdj?=
 =?utf-8?B?MnRhM0Y5WXJqbXFCaGRxeG9UblhNZXRtaDgwNGlxYXptb25Lc0RScnRGZ2p0?=
 =?utf-8?B?RVZ2eFJkNm5kbDJoZDBybldlZ2dEYjhYeVB3WEMxSDVhS011aTR1elYzeTZx?=
 =?utf-8?B?MVBpY1A5NXgxVGR3a2xJVmk4MFJBWDI1ZmpScUxWcG8wQnQwZzcySy9LMEIy?=
 =?utf-8?B?SEs5eUVPRW1lSDM2clo0ZHozaUw2RjZjTnFtQmNyV1pkbGQraXY2NktBV1Ux?=
 =?utf-8?B?S0lwWjBsd3cwYzIvdGdKOFBka1VVMnhYL2l5Yno0ZEhwNnI4QVk0bkpEOTZu?=
 =?utf-8?B?SmtFRmZJZDJBS1ZxRUxla2xQaWNRblFla0sveVJwcmk5bzd5SnUyNHcvZE9x?=
 =?utf-8?B?NzNxN1kvc0xKeGFBV2pMYi9QcDV6S0d3T2kza2taRVhTK0NjRjk0eWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzA3SVlsM3dqUGxvZ0dtWnlleTdUTGx4Wk4vcG1iRjJnTU9UKyt2Y3ZNTXI0?=
 =?utf-8?B?dnU4YVJoUVJDTk5YYlNiajdVSEIwNHpCakFNNXJMM0FDYVVwT1c1TDRwMjUv?=
 =?utf-8?B?VHZKbG1VSFJrc1FmMjBTbkhiTDkxcThBOEFhMmlyL1BEZGlDTkJRam10Sjhh?=
 =?utf-8?B?bDFDVkR4aGZvRklRNUkwdVZpNGh1MjRtWTZ0ZU0waFJqbjA2TGpkdGZHSTJH?=
 =?utf-8?B?RVNBTTJpbnBQeXlpUldQNkRhazRQTnFmVnJzWmZtSUZEanl5NUdua092Wkgr?=
 =?utf-8?B?aVlPMUJhc3BnaHF5ajZZSEJLTHBLOStTNjh6QVE2STc0bjJITkFLdFlDMU55?=
 =?utf-8?B?Rk9YOXl0VVlnbGlVNzNSS044NkgzVkN0T0JJemJxTFJoeTVmdTVDekxodTJm?=
 =?utf-8?B?Zk1XZEJZaGtpMGRVSlFLVm5vK29DNHFkVzIxYVE1dkNuU0d3RGZEWU9kRk5P?=
 =?utf-8?B?M1ZKeHFmcFpWWk1KQTRsSHkvV05rWFREMmhUelNRNW1NU2I3RVF0WEZtTStX?=
 =?utf-8?B?S0g1bUdJUDBaRDVLd3o1UDRWcFNnUFg1bGQ4dFFIL1gvZ0RiUU5OQnpOWGQ1?=
 =?utf-8?B?ejhIK3BSZ00xMUZuT2dQSUYwTm1PdDAwZTJvVlVPN2IvYVBlRm5VUzNtWUZ2?=
 =?utf-8?B?bEVWZHZoTCs5dzRWOTZQTWRCRVhIekdPZjVqSFBKWnhXNEp1ZGwyYnluU0FI?=
 =?utf-8?B?MjZPaFIwWHVpVWdoem9udjF4Y3FXZEVweDh0MWROelZ1QTFIM2VIdnZxcVRl?=
 =?utf-8?B?MFZudzhWZ1RqOHoxZ1RsZzJDaWpLczgzZW9rQzFhM0Y4RWlJNjVHc3JvaDFa?=
 =?utf-8?B?TnVseWRkS3RBbCtNcWdVY2huSFdzckRkMVNnMCt6QndpUm9Xdk5zaVpmenUx?=
 =?utf-8?B?cGRNdUZyT0VLanhUOFlURE5PQjhqR0FCT2dsRXM3ZGpFM1NsY2NJZTFMSGE5?=
 =?utf-8?B?YnAwOERDWHplT0Q1bTVUV3NReEtnTmYzZkIrOEFHVFdDQ3BpdjVWSnYyWXlu?=
 =?utf-8?B?c0hFUUM2d25HaTJYQ2NYY0xFWmxEWlJoSkJ2YTYwR3p3VDZiS2xuTDVIYmpM?=
 =?utf-8?B?NXpZS2RyYTQvczNLTHZoT2E2RGRqVEs0eno2RVMzRGw1Q0hZckJtdHROanpS?=
 =?utf-8?B?T05UUFoweldPWi9jMUlzYmhOa240MmtvOWpjYlZaWmMrV1phVEVyTzg3dTUy?=
 =?utf-8?B?b2ZvcmNOaXNZRVQ4MjU1RmxPQ1J6SHZneGxyblVvL2xITmg3elVzUVN0ajMr?=
 =?utf-8?B?Uy9vYzdyWmZRY3ZPYlhiZGRKSVNMemEyVUE2cG9BYlVsaTlGTlNYdTFnU2dz?=
 =?utf-8?B?TEFqekdXTzROSnVFdzFZdUFYNGlLTitGNVJWRi91OFFOZTdwTVl2bVIzVno0?=
 =?utf-8?B?UGhMU3NKbGlxKzdNWXlrbVlIUWx4b0IrVDhENTEzaUVTcThNRFVvcnNISFBn?=
 =?utf-8?B?akg5OUZ3TWN2ay83R1UxNmlFdHZ2ZnZKbG5QZWJEcXhXamlVM3g0b2RtbUkv?=
 =?utf-8?B?TnJvSjNiek9XVU5Xc3doS1ZkTkJNV1d0WUdGQ3ZMdjlLZ3krTVM5elNsT1pQ?=
 =?utf-8?B?N3R3alA5dXRuWFBOM3I5M3BwQWZPdkZTMHlWRE9CYng1MURTNFE3L3RoZjNo?=
 =?utf-8?B?ZHVRRWo2cmZUczJ3ZW5zN21MbnJnZVVmeUhYeEZUNERpR2Izamh0NVNQQXZh?=
 =?utf-8?B?SEcvVWVzcGhrNkZOQ0g2K0NxNzk0VEJWd3pWTkQ3aHg2eTFyVXFEdEphdkYy?=
 =?utf-8?B?aUhlZVNxd1drb3pYalhlUUo0OGVpekIzK2kyRHZBUWtpZllsWXJTbDFhL09t?=
 =?utf-8?B?NGtVRE8yTDVmTHRrRjh5RWFhdzFrc00zd3R5MjkxUUc5SmxUd3Y1OFQ5Q0pr?=
 =?utf-8?B?bURwcnZhWk5mdGRBQ2JHWXIzS0hvZzR4ZWxOb0VjUFRxR05EWWVZcGhMTWJr?=
 =?utf-8?B?aG9kaUp4S2tDaHNqSHpEcjFCSE5TT1ZxNEFraUd0ZlQ1TEEvYjdmOWVvb1dG?=
 =?utf-8?B?VUtYVDZNOWh6ekZQZmpHU2lNMW9wTXBFamlPWkcxTU9LSXJGK0lmZ3JLcnIz?=
 =?utf-8?B?eDJsL1EyY1pZTXRtU1FmT2VJSGkxUWFhcmtsanRzb2prVTFpeW1aQWVaUWZT?=
 =?utf-8?Q?VNp3yRkTKYE7OnvnazKeYDcBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c853942f-fc29-4d3a-ed37-08dce4a4569d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:42:46.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfgpRkt51oriDC97g7EuAav63iCKx4Vo98M6ODw4culBHHVAkmZYUylgARFUurjMryxEVOQHZoqHRuL4ZFQT1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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


On 2024-10-02 07:28, Christian König wrote:
> Am 02.10.24 um 06:36 schrieb boyuan.zhang@amd.com:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> vcn gating state should now be based on instance. For example, 
>> instance 0
>> can be gated while instance 1 is ungated, or vice versa.
>>
>> Therefore, change the cur_state to be an array, so that it can track the
>> gating status for each vcn instance now.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Mhm, some questions. See below.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 ++--
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  8 ++---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 23 +++++++------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 38 +++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 41 ++++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 41 +++++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 23 +++++++------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 23 +++++++------
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
>>   10 files changed, 114 insertions(+), 94 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 2a1f3dbb14d3..f6717f780acd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -308,7 +308,7 @@ struct amdgpu_vcn {
>>       struct delayed_work    idle_work;
>>       const struct firmware    *fw[AMDGPU_MAX_VCN_INSTANCES]; /* VCN 
>> firmware */
>>       unsigned        num_enc_rings;
>> -    enum amd_powergating_state cur_state;
>> +    enum amd_powergating_state cur_state[AMDGPU_MAX_VCN_INSTANCES];
>>       bool            indirect_sram;
>>         uint8_t    num_vcn_inst;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 6717ff692d8d..bafdd6d5ff24 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -279,7 +279,7 @@ static int vcn_v1_0_hw_fini(void *handle)
>>       cancel_delayed_work_sync(&adev->vcn.idle_work);
>>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> +        (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>>            RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>>           vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>       }
>> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(void 
>> *handle,
>>       int ret;
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    if (state == adev->vcn.cur_state)
>> +    if (state == adev->vcn.cur_state[0])
>>           return 0;
>>         if (state == AMD_PG_STATE_GATE)
>> @@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(void 
>> *handle,
>>           ret = vcn_v1_0_start(adev);
>>         if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        adev->vcn.cur_state[0] = state;
>>       return ret;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index be6998ed56bc..72e36fbaad39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(void *handle)
>>       cancel_delayed_work_sync(&adev->vcn.idle_work);
>>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> +        (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>>           vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>   @@ -1812,11 +1812,11 @@ static int 
>> vcn_v2_0_set_powergating_state(void *handle,
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>         if (amdgpu_sriov_vf(adev)) {
>> -        adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>> +        adev->vcn.cur_state[0] = AMD_PG_STATE_UNGATE;
>>           return 0;
>>       }
>>   -    if (state == adev->vcn.cur_state)
>> +    if (state == adev->vcn.cur_state[0])
>>           return 0;
>>         if (state == AMD_PG_STATE_GATE)
>> @@ -1825,7 +1825,7 @@ static int vcn_v2_0_set_powergating_state(void 
>> *handle,
>>           ret = vcn_v2_0_start(adev);
>>         if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        adev->vcn.cur_state[0] = state;
>>       return ret;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 7ab0314b27ec..09b342ad02cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -397,9 +397,10 @@ static int vcn_v2_5_hw_fini(void *handle)
>>               continue;
>>             if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -            (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> -             RREG32_SOC15(VCN, i, mmUVD_STATUS)))
>> +            (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>> +             RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>>               vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        }
>>             if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>>               amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 
>> 0);
>> @@ -1832,16 +1833,18 @@ static int 
>> vcn_v2_5_set_powergating_state(void *handle,
>>       if (amdgpu_sriov_vf(adev))
>>           return 0;
>>   -    if(state == adev->vcn.cur_state)
>> -        return 0;
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>
> Shouldn't this only check the first instance for the HW generations 
> which work with only one instance?
>
> Could be that this becomes redundant when the function is called per 
> instance later on.
>
> Regards,
> Christian.


Yes, there are some redundant codes, removed all of them in v2.

For vcn generations with only one instance (v1.0, v2.0) always use 0 as 
instance number. For vcn generations with multiple instances (v2.5, 
v3.0, v4.0, v4.0.3, v4.0.5, v5.0.0) use the actual instance number.

Please check the updated v2 patch set.

Regards,
Boyuan


>
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v2_5_stop(adev);
>> -    else
>> -        ret = vcn_v2_5_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v2_5_stop(adev);
>> +        else
>> +            ret = vcn_v2_5_start(adev);
>>   -    if(!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 38452446fcb0..ee9a40443d65 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -430,8 +430,8 @@ static int vcn_v3_0_hw_fini(void *handle)
>>             if (!amdgpu_sriov_vf(adev)) {
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -                    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> -                     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>> +                (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>> +                 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>>                   vcn_v3_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>> @@ -2163,25 +2163,27 @@ static int 
>> vcn_v3_0_set_powergating_state(void *handle,
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       int ret;
>>   -    /* for SRIOV, guest should not control VCN Power-gating
>> -     * MMSCH FW should control Power-gating and clock-gating
>> -     * guest should avoid touching CGC and PG
>> -     */
>> -    if (amdgpu_sriov_vf(adev)) {
>> -        adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>> -        return 0;
>> -    }
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        /* for SRIOV, guest should not control VCN Power-gating
>> +        * MMSCH FW should control Power-gating and clock-gating
>> +        * guest should avoid touching CGC and PG
>> +        */
>> +        if (amdgpu_sriov_vf(adev)) {
>> +            adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
>> +            return 0;
>> +        }
>>   -    if (state == adev->vcn.cur_state)
>> -        return 0;
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v3_0_stop(adev);
>> -    else
>> -        ret = vcn_v3_0_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v3_0_stop(adev);
>> +        else
>> +            ret = vcn_v3_0_start(adev);
>>   -    if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 078bb30497e0..aaecc680b631 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -355,11 +355,12 @@ static int vcn_v4_0_hw_fini(void *handle)
>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> +
>>           if (!amdgpu_sriov_vf(adev)) {
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -                        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> -                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> -                        vcn_v4_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>> +                 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> +                vcn_v4_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>>           if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>> @@ -2040,25 +2041,27 @@ static int 
>> vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       int ret;
>>   -    /* for SRIOV, guest should not control VCN Power-gating
>> -     * MMSCH FW should control Power-gating and clock-gating
>> -     * guest should avoid touching CGC and PG
>> -     */
>> -    if (amdgpu_sriov_vf(adev)) {
>> -        adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>> -        return 0;
>> -    }
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        /* for SRIOV, guest should not control VCN Power-gating
>> +        * MMSCH FW should control Power-gating and clock-gating
>> +        * guest should avoid touching CGC and PG
>> +        */
>> +        if (amdgpu_sriov_vf(adev)) {
>> +            adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
>> +            return 0;
>> +        }
>>   -    if (state == adev->vcn.cur_state)
>> -        return 0;
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v4_0_stop(adev);
>> -    else
>> -        ret = vcn_v4_0_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v4_0_stop(adev);
>> +        else
>> +            ret = vcn_v4_0_start(adev);
>>   -    if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index be7b0bfba27a..87c04c512357 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -318,8 +318,11 @@ static int vcn_v4_0_3_hw_fini(void *handle)
>>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>>   -    if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
>> -        vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        if (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE) {
>> +            vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        }
>> +    }
>>         return 0;
>>   }
>> @@ -1627,25 +1630,27 @@ static int 
>> vcn_v4_0_3_set_powergating_state(void *handle,
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       int ret;
>>   -    /* for SRIOV, guest should not control VCN Power-gating
>> -     * MMSCH FW should control Power-gating and clock-gating
>> -     * guest should avoid touching CGC and PG
>> -     */
>> -    if (amdgpu_sriov_vf(adev)) {
>> -        adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>> -        return 0;
>> -    }
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        /* for SRIOV, guest should not control VCN Power-gating
>> +        * MMSCH FW should control Power-gating and clock-gating
>> +        * guest should avoid touching CGC and PG
>> +        */
>> +        if (amdgpu_sriov_vf(adev)) {
>> +            adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
>> +            return 0;
>> +        }
>>   -    if (state == adev->vcn.cur_state)
>> -        return 0;
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v4_0_3_stop(adev);
>> -    else
>> -        ret = vcn_v4_0_3_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v4_0_3_stop(adev);
>> +        else
>> +            ret = vcn_v4_0_3_start(adev);
>>   -    if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> index 0e70df04ceb9..2092360e133a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> @@ -305,10 +305,11 @@ static int vcn_v4_0_5_hw_fini(void *handle)
>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> +
>>           if (!amdgpu_sriov_vf(adev)) {
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -                (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> -                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> +                (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>> +                 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>>                   vcn_v4_0_5_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>> @@ -1534,16 +1535,18 @@ static int 
>> vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_s
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       int ret;
>>   -    if (state == adev->vcn.cur_state)
>> -        return 0;
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v4_0_5_stop(adev);
>> -    else
>> -        ret = vcn_v4_0_5_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v4_0_5_stop(adev);
>> +        else
>> +            ret = vcn_v4_0_5_start(adev);
>>   -    if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index 6b38927024d1..045ac9c8d8be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -269,10 +269,11 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> +
>>           if (!amdgpu_sriov_vf(adev)) {
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>> -                (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>> -                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> +                (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>> +                 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>>                   vcn_v5_0_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>> @@ -1261,16 +1262,18 @@ static int 
>> vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       int ret;
>>   -    if (state == adev->vcn.cur_state)
>> -        return 0;
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> +        if (state == adev->vcn.cur_state[i])
>> +            return 0;
>>   -    if (state == AMD_PG_STATE_GATE)
>> -        ret = vcn_v5_0_0_stop(adev);
>> -    else
>> -        ret = vcn_v5_0_0_start(adev);
>> +        if (state == AMD_PG_STATE_GATE)
>> +            ret = vcn_v5_0_0_stop(adev);
>> +        else
>> +            ret = vcn_v5_0_0_start(adev);
>>   -    if (!ret)
>> -        adev->vcn.cur_state = state;
>> +        if (!ret)
>> +            adev->vcn.cur_state[i] = state;
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 449925105889..86001682e13e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2112,7 +2112,8 @@ static int smu_hw_fini(void *handle)
>>       smu_dpm_set_vpe_enable(smu, false);
>>       smu_dpm_set_umsch_mm_enable(smu, false);
>>   -    adev->vcn.cur_state = AMD_PG_STATE_GATE;
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
>> +        adev->vcn.cur_state[i] = AMD_PG_STATE_GATE;
>>       adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>>         if (!smu->pm_enabled)
>
