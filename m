Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56E5D3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AF010E6BB;
	Tue, 29 Oct 2024 17:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbHexBMx";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459CA10E6BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4/7/giGEzJxLCqIN4IdA0s5n4a3PiFJGLKu8v6e0rstBn6R7EJ40GJypP8FdZX+DIW9YTQkttiA1rxBDLm7QcuZdYX7fUfxxXtKz/bOw93C917WBxBpKnLhJaF2qgTZheJ94be9MhQFZb6kfWGO0ixwC8aAuffbxEH1kACvkoSeAQy2T2t/s4Xj8dHSMiYJ33+/X67vRqgJOAHHTA8DTx6Pu31ZOae4Ti5DJ3EVKQSyliyCJs7FXMnqM2Jm8snLjARZ8EHAdL4Jpb4svQ1fotEaMye2yrynVfNODHYDLB+gWSsxp0Qed30L+OMfWObUpaDS5V3ohJgwU5ns48J+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=melfLueVqdnwUs4sMFd4oR71pbCw8LLs6EHqLvJmPZM=;
 b=IV5XV2Tl4rewfW/pZikPf8qWho01eGbNIeusljUrFWQSG6RK5f36TgCeqcCxtvMSENvhlBL+1mLRJXPb8bMffX8SsDHrwnx5gj+9+QV1L8CZnDdzuAI+nIkGjvuRsDLweI3ZYhSK+T6lkSaC9UQ9+l6gXg8Qtk50GW2GKuoPosh4lK8qolpRRN62GH/FQowfImCVAeF0oxdRhok4u2T+fWWbZm4tJW9AbT0DlbcN3hIGEXzYm/Fu9qzZ4ar/S0BA9XGt+MnLbpJv2OAWxMTO/oy0xhkCghcYpaISeo/beo6hRyh0vZCErG8zkfKI5/Ii543Jha9aexLlYmvYwN/rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=melfLueVqdnwUs4sMFd4oR71pbCw8LLs6EHqLvJmPZM=;
 b=gbHexBMxM9AGNtqT1k//M/83Fv72TlVIK6CnPI2jEjHCfufwcvBx5JPiYAkjvA3bVFBtBLEkLG06NIDpli1gREjGsDufbzoOzx+Hscfwn7+GbxbzZEquzgPYxUUYhZj0Ishas8wOdBOPnUQjcwrJCxBR6q3mDldKJPtNv7Sqms8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:47:40 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 17:47:40 +0000
Message-ID: <c8c19f39-008c-43ab-bfd4-d3b88263e279@amd.com>
Date: Tue, 29 Oct 2024 13:47:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-10-boyuan.zhang@amd.com>
 <CADnq5_OQ=Nj_U5gYODLkHnoPpvKBpWrtVQynKJ=z=1E7_QUeBw@mail.gmail.com>
 <69ceb132-9cd4-45ef-973f-6dab0dfe1dab@amd.com>
 <CADnq5_OiMxw4a6ejyY944+AQ+k9aAHYw9ucFKJbO758-ry-_aw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_OiMxw4a6ejyY944+AQ+k9aAHYw9ucFKJbO758-ry-_aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::8) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fe6386-dd7e-45e6-ed60-08dcf841c87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjQ1SGNWdm1LNEZuNWdBSUpGMTlQcWowSXJHSjZGT0tMZkR1Y25DSm5CazYw?=
 =?utf-8?B?aUJielNiMmNNSnhTMEcvQ3RvbHFPYkx6Mk4rbjBBclVWb3pPQ3RtM254aFdn?=
 =?utf-8?B?ZkFncDhZQ3V3Nk0yYXN5ZFJFT1ZFZjI2RTFvUU9JNVAwQUtYMi9ndWV6Wk5S?=
 =?utf-8?B?U3MrbDVrTHNBUjhQbkNkcC9TbW5Vc0tRSDdYZy8zZkp0cE03VFFLWkZ1L2pW?=
 =?utf-8?B?VEhmdUxLN0NhZEtaU1pZVDhMVm93eWplK1RHTlFCSmZjSjZSUFlORS9IRkND?=
 =?utf-8?B?TkZFcnBsODZOOTVWR0ZwUFVCak1KNmpDVm92TjNvcDBCd3ZEaGs0MWZRcG5L?=
 =?utf-8?B?UHdPZTBoYnFLNkYzZkt1UXpZalk0T0FVcUxTanM2RzF1bVh1VFFnWkZSYXhD?=
 =?utf-8?B?cERtMTFrYTZNcU8rZ21jNXJNeDlxUkdZZlhWeW1Zcm1GL1l4bEhwTFVIM05J?=
 =?utf-8?B?TTJvYzRRU3JxdVZ2MjVmQkltYzVCVXlBdEFIUk1mTUJMSU5MaTloNGRrNDN2?=
 =?utf-8?B?NnU4dVRqeXpweGpvMjdmRGFwNWlhRTBmeS85T3F6a09BZVlhWG5jRFNpMmFQ?=
 =?utf-8?B?TG9FWmZtejNUWnJVN0xHS1lMRXdtWFFKNWlpNllVODNPMFFZRlBIczJxQy9S?=
 =?utf-8?B?bmVUVkJJNHRPMG1QZTJUMHB3N3VtRm8wV0NZdFhiM1JwM0tzY2ZSb3VjcHNm?=
 =?utf-8?B?bjRxeHhSMXVMd0ZtclhWdyt4KytVcGxJdU4xdFdVaW9VbS9kWHd5NzBLTVJp?=
 =?utf-8?B?bUpFMEtkeFB3aTZIWVd2c05yei94YlZmSE9GRFJJT1VyRGRjcGtheWIveith?=
 =?utf-8?B?MlRFamFNYStXSUw0WGZWeXYxRXFFUjJncjB0Z3NSaDFSNWQ3aHlxMVFvVk1H?=
 =?utf-8?B?WU5KUExLeThhSi9NcHpIdzU5S0xiMmZOdlZGbjBWbzR4RkJxa2ovWnhYeGlu?=
 =?utf-8?B?UUk5QzBMZVNWSHE1c2ZlN1BwOG9RTjdubzJOdW93dzJ3Z1JQVkVVZUZXeEov?=
 =?utf-8?B?SnJQVzh0bWtyS0FFcmZGczN0dkcxeWtNeVMyNjVld0ZtUUdLbnhPUFcxQTQv?=
 =?utf-8?B?NGdIUE4vd2Z3dEVvKzBRSy9GSlc2aFdUWkExZUFMcTVPR0J2aDF2cFBBWUhT?=
 =?utf-8?B?OXRtSmZneWFWVWFTVFZLVzJ3KzZrL3YxRmFWOEpaTzlkcHZmYlluZkNmMFlH?=
 =?utf-8?B?aDJoT0ZXQWRiUFhDQTZsNVRnVDh5REhRcEpudjRZSjBodXArcGpTYzljV200?=
 =?utf-8?B?OExNWGdvKzBUL01DeUVoRHE2Z0JNUHdId0lISEs3ZW12Nkw2WlpDdlNZSHg4?=
 =?utf-8?B?VC91NEFyRlUreXFuMXI5VGViQzd5b0FCVGZZZzRhUnpsd3dFclhUbVpIQUNw?=
 =?utf-8?B?RExaY3B0Q3VnWWdRZmt2TzhORVNqcnY5QjR5WVR1S2x2dmZOYkt4MkFoaDAx?=
 =?utf-8?B?QWFXdFdhanZWMktpYkMxV3RvK1NValBoR2NSWmJ1NU1sbHlFMHNPNWovVTF6?=
 =?utf-8?B?NFd5bktNaER1dCtiL0lSZXZCQVI1RDNOazR6OVVqR3pNcmp2R3RFRlpKNWkv?=
 =?utf-8?B?b0ZkejUxMmpYMk51dUlXcEN2UDhQMGxVdFJQVW1xMTRpVEFKTGY5OVllZXZr?=
 =?utf-8?B?WHcrRGJ5aFAwOGJsTU52U2s5ZXY3UWtHZDVOeEZleHBFaGZxcTFFYlduVSsv?=
 =?utf-8?B?TzVZQnJ0YVRiNUw2V2JaaGF2WGpBbnZnT2dkVTc4WkM5VkhMRXJtQzBqa2Fh?=
 =?utf-8?Q?4Bz05vxPulzesfk/QFAaz6Wn29moIJ6O4f/DotF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1hakFGeEE3UjdaM1ZUMU1QN0F5bDJ0a0ZsdkZPZEdqeCtGb0pVQi9RbWJi?=
 =?utf-8?B?K0x2THJodzUrNE5HR0FDLzNXbFp5VjQ3dng4NlhxWk9oMmc3TVlCdnd3UGFL?=
 =?utf-8?B?aEtVOFUySWhQQ3ZHT01yUFhyVWUwSVc4WkUvc1ZJaHoyWTREQWVIYzgyNVkr?=
 =?utf-8?B?cFAvUDEwRlRyc1FwZDZ0TWFUN212dkdVSlg1N1NIT0kxTTNybit4bGcrMlRF?=
 =?utf-8?B?aHhDb2sxSUV2TE1FOWpHMEw2azljWmNTYnZVdThNT1FjamFyTzhjQzVUMmM4?=
 =?utf-8?B?cjlMWkdGTklXdmFkdzRIbkJJT09kbkR0bnlQVmFWWjlpc2JPanN1bTZpOWwv?=
 =?utf-8?B?Z2ZFcE1Pd2xLaDNkT0NMT1RNME9lMm1UVFc2YmFDbEFaUHdjRzUvWW1XWU14?=
 =?utf-8?B?VlNKSEF4TmhCZi9jZ1JDYldwS0NQRng3anE5dEI1ckZuRTVDTTlEa1I3dENZ?=
 =?utf-8?B?c3lYaktGRHp4VUFZdllqQU1YeWRROFpGOFVndGJmTjZ2UjNEd296SEU4czFy?=
 =?utf-8?B?eXUxeFM2dk9zeTFIK1hPNVRVYzZoNnNkZjVIOEpKRDNGcWkvRXdGRkZBU2pJ?=
 =?utf-8?B?b0VvbkluaWdERGtpTjlUMFJrb2ttb3U0VTN5VFJEZGN6OXZZRFk1RnhVWisw?=
 =?utf-8?B?TWF1eHpkQmxQYjAxLzVaRTdZMDZWaCtTRW5vUHQxTzBkTlJyWnZFVjNXRHRV?=
 =?utf-8?B?L0pYNGZYREpMK3FaTVFPOG9LS2VnTnV4aDdoaFh5d2RsYUM4Vnh6cGJUcnpJ?=
 =?utf-8?B?RVE4c3gyTlVIUmJ0aEwzMjJ0OVZXanoxU0pKYko1cWpJOFBWcUkrZFdhdXJs?=
 =?utf-8?B?Ri9hdURiQnhsdy96VUsySDgwem03TWpxWExjR0pHOFVlRG8zUThRM3RaOWlD?=
 =?utf-8?B?OXJ3RVMyWEtSZkZtRzlyd0xkSExuMVRXZVozOE13MlpLM0pERmUyNk1adFlF?=
 =?utf-8?B?MklGU2RtaitVWmVBMFpRYkVIOG1mWWJUM2RtOVkzWS8wRy9YRmRBWGFINkRk?=
 =?utf-8?B?NmZlaTZNOXgweDJrazhkeVpMSG9zYm5LZ25EQmx1R1pPVGFsWlpLdlFEU0ZJ?=
 =?utf-8?B?OTNCUzN0ZndaN09nc0dQMVhwdWpyenlOZkRhWTlKditTRm5pNUVHVGlKVjZO?=
 =?utf-8?B?YWJ4Zm1ISGpCaFl4Z2JtZWhlTjNzL0RYSEg5UzdaWFJHVko5dWJteDRta05n?=
 =?utf-8?B?b240RCs0UkwzZFZ6YkJNdGhQVUlFM1pRdWtubzc4OXBkaG5oblVHTk9INFNP?=
 =?utf-8?B?ZU5wU0ZnVXp0UytHTjlNaDdwQS9DVmhZSmtNemFIQkw2c3pvcmdoUWVxLytw?=
 =?utf-8?B?SUp5elVJTHJXQ05DNFMwSktCbHlicXl3enl1ZDkxTzdJREVTdFN6dTMvei8v?=
 =?utf-8?B?bEliWGlhd09veitqcUQxWnlGdTRLT1gzQlhna1BDek9QRUdCV2RIcHdBbUl4?=
 =?utf-8?B?S0g3ZDVFbHE0N3o3NjRuaG1hUDdxOFdEeThsWEg4bVpGdkRWVUFuUWJPRjRU?=
 =?utf-8?B?ZzNoZ3NremMrNW1hQzQ4RVc0ZHl4M25tZmhHSzh0YzVRcWUxb0Y1MTIzQlUv?=
 =?utf-8?B?YjRVUnBwRjFZd0FxU2V1bjJMbGFvVWo1RUpobjByQ09lZVROb2lxS0JhbnNN?=
 =?utf-8?B?cTFBQVE3eEdEK0Q1bDc5UEJPL2Nybzd0NnZSaTAzcUxIRUx1QWJzaDJVY2lP?=
 =?utf-8?B?clVNNmc0SmpRWXZMUE5nNTVBblFablJzN3ZiZndCbGp2VHIrRDNaNUdiaFZv?=
 =?utf-8?B?ai9GOUw1VjQ4dC9uY3Y5Y3AyamtzdFNFZlhyYnNnSjRHdFVFOHRBZ3BiallZ?=
 =?utf-8?B?cHR1THFiY1BQZzVUTUFQaTQ3QmtLVVk0bURjSXc0c28xcXRKSFh6bHZmV2lP?=
 =?utf-8?B?RmtMV0RuV1d5SjVrcnFGdkJBOC9nUVZoWXhzSy9ibTB0cUs5TUlJaUM0NWhl?=
 =?utf-8?B?cnJSdG02RHA4a0hwS0VJQXU5QkkyYXYxZzZlbTFzRjd0ZUhaNDdKM2xlRXZW?=
 =?utf-8?B?ZFBXc296MW85a0pUdmVZVUVnN0hVbWRpUi9BRHZkQ1QvUU16QkQ0UjlqRXRu?=
 =?utf-8?B?UVY0SUlJcTRSOUR3bkd6QzlkUXRma3pwQ0ZXbFEzSEJBMzBBb2JxMGhtVTZS?=
 =?utf-8?Q?kI4O8ozmUlBOPgZv/BTHdpR9+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fe6386-dd7e-45e6-ed60-08dcf841c87f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:47:40.2131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E6SWvBKMxFLlCCWvXotTV1oZtkdOY9ImsEKV2U8H9+MLFVBfLaGYBbdIxBO0p+af2tvgIqrCSPhUZ7HJdBVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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


On 2024-10-28 16:05, Alex Deucher wrote:
> On Mon, Oct 28, 2024 at 3:53 PM Boyuan Zhang <Boyuan.Zhang@amd.com> wrote:
>>
>> On 2024-10-28 15:27, Alex Deucher wrote:
>>> On Thu, Oct 24, 2024 at 10:48 PM <boyuan.zhang@amd.com> wrote:
>>>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>
>>>> Add a new function to count the number of instance of the same IP block
>>>> in the current ip_block list, then use the returned count value to set
>>>> the newly defined instance variable in ip_block, to track the instance
>>>> number of each ip_block.
>>>>
>>>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
>>>>    2 files changed, 25 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index fba10ad44be9..2e2c6a556cc8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -390,6 +390,7 @@ struct amdgpu_ip_block {
>>>>           struct amdgpu_ip_block_status status;
>>>>           const struct amdgpu_ip_block_version *version;
>>>>           struct amdgpu_device *adev;
>>>> +       unsigned int instance;
>>> Thinking towards future work, we should add a `bool harvested;` member
>>> to the structure so that we can skip harvested instances in the common
>>> code going forward.
>>>
>>> Alex
>>
>> OK, so do you suggest to add it in this patch set, or a separated patch
>> set when we implement it later on?
> Later on.  Just thinking out loud for when we clean up adev->vcn.
> I.e., we can remove all of the checks for (harvest & (1 << inst))
> because we can set ip_block->harvested = true in the common code and
> then in amdgpu_device_ip_early_init() we can do:
>
> if (ip_block->harvested)
>     adev->ip_blocks[i].status.valid = false;
>
> and we won't have to check for harvested instances in any of the runtime code.
>
> Alex


Really good idea! Sure, will clean up this part later on! Thanks!

Boyuan


>
>> Boyuan
>>
>>
>>>>    };
>>>>
>>>>    int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 7c06e3a9146c..065463b5d6a9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>>>>           return 1;
>>>>    }
>>>>
>>>> +/**
>>>> + * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
>>>> + *
>>>> + * Returns the count of the hardware IP blocks structure for that type.
>>>> + */
>>>> +static unsigned int
>>>> +amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
>>>> +                                   enum amd_ip_block_type type)
>>>> +{
>>>> +       unsigned int i, count = 0;
>>>> +
>>>> +       for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +               if (adev->ip_blocks[i].version->type == type)
>>>> +                       count++;
>>>> +       }
>>>> +
>>>> +       return count;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_ip_block_add
>>>>     *
>>>> @@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>>>>                     ip_block_version->funcs->name);
>>>>
>>>>           adev->ip_blocks[adev->num_ip_blocks].adev = adev;
>>>> -
>>>> +       adev->ip_blocks[adev->num_ip_blocks].instance =
>>>> +               amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
>>>>           adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
>>>>
>>>>           return 0;
>>>> --
>>>> 2.34.1
>>>>
