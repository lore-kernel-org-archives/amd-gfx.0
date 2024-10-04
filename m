Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95241CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B42310EA84;
	Fri,  4 Oct 2024 18:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T0W7VgJI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F0910EA84
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1OYsM6M0a1HhWVyJ2tu38WMC0MHlVfcySa3DN46eDM6UPWp/erGK/yzrE+SiWyULnOywnoxciYOW+SvnMAHzjcSmnr45GgsfvJIPKtYZszaScrj8xx7b8veibMmPXDrxJOx8dy3buogyn0bTsqCiPZneh20J6bYuxqUBcOw6s3COosLWs2SYa4aPDVQVz18H5yf+4IufLhbgRhT6MrboPaFr/zzN3iviCwxbc3R+GnTUeB9VPqPz/KUc3gPkPHHq98qhOZkFaGeQlM4h4Z/317XWdeKz/xu+QxkNOH+8io1GeV7T4QZYTz9toG/gbMOYZfAzeoclq5wuADo0TwDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bEu3TekTBMFuHp/RsNvhcmyacjRkwQ2FMXqMNUOpus=;
 b=npDxGSUrGuCu84mXLHLavj0asWvYCr2Yq8Swg25Md7NwA9QcTFjIkMwj+cK4JayCWOu5kz6dK5rDz/4fB3NgsMdSu4BGYR/QB6n1thLBNuKRIOYaH5cY3AGsBVIhcJyRV0kMx7Qe4wfGibjAVrCD7oXzt3Dyy2UapZh9dRf/F9pGwtJTQ4+MKvrlM6WfYy8jsHcngBgmyzayF150cWzdwOUDNAVphSKxZtcUELkRWQ/CRvJ9AK6ZcLWSaixVNIOmNgO68+8En65shluVkOpc1kXnYtWNZVx6+Y60gSaRgGmrB2+Kyf6XtuH4e7E7JAO5N4mhTTJc+bnHL7pLTibeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bEu3TekTBMFuHp/RsNvhcmyacjRkwQ2FMXqMNUOpus=;
 b=T0W7VgJIkbHgfD+cbrxvFfNqRTthc3kyeySCNciHO808RqGuAMhvTin8Sqa1TpvLiX0lubvwP0wVq4Ex43E2+7PmTufz8YKTtKRWgjv5j8GKF7IPMrf+oIsT+iIx55q+tQBcKvp/NA3kB8jTpdsRYJ2YvufMQ6s4kNm/rA7dC74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:44:31 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:44:31 +0000
Message-ID: <a150b2fa-63a3-47bf-a689-76b864acc8b7@amd.com>
Date: Fri, 4 Oct 2024 14:44:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] drm/amdgpu: add ip block with instance
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-11-boyuan.zhang@amd.com>
 <CADnq5_ODBr=ZFtZmgRym5FjEazp5BiFVK8U=fmairLKHef9zVw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_ODBr=ZFtZmgRym5FjEazp5BiFVK8U=fmairLKHef9zVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::15) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: a837726f-8f57-4f72-b523-08dce4a493e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWUyZG5FYjZYUFNvRklnUU9jQUxoK1VqOWtiL3g5V3pxTmJsSzdlV0s2Zlh6?=
 =?utf-8?B?NUlmelcxbjVoNTJBc1FzaHRpVUdnOFdVMHpJbnRId1RQVlZJTm5vcExkdGk3?=
 =?utf-8?B?aGJ3YTZTOVY1SzN3VUM2dWJJU1dIaFV3YkhkRlZVNm5GSkE5Wi9uT0FZWHQ4?=
 =?utf-8?B?K24yRVEybWpvMTlkQXB4Q3hVL3JuaVZTQmdRS0lrd29SWUxaQUhIdzV5WXZp?=
 =?utf-8?B?N25ZWC9LUDN4Ylg1aWl5Y0dMUWlJSnBoZ09jQ05jdEt6WUNlSytyOHJaVThn?=
 =?utf-8?B?eWlKUEVjSnBrNUF0UjFPVXhSMEpjYUQybU85dmVKUHpOYkFyYU5YSXJTSHli?=
 =?utf-8?B?dzFKMzA2ZTNzTkpMU1hQVFpha2RqVGhFb2I2QlllV0VyU0pvd0lGR2xWbUlB?=
 =?utf-8?B?bm5kUXJqQVZpYUxWSE1ScmpoUjdZdndOdGtwbWU3M1BNUUNzS0ttR3lBY1Ex?=
 =?utf-8?B?OWsycmx5WHUwVk8yRDRFelVZTm5STk5Jb29icTVZSGhNeklNZklqTm91OXAz?=
 =?utf-8?B?Q2FNTXJxR2pGaGdCQjNJNEVlVzdSZm01VXpoWDU4V0tjT1g2bDhQTUtrVk9E?=
 =?utf-8?B?Qkpvd2NqQnJKTm9VbTBDNzlEeEJoVVdXWG5RREJQMjFnNmRSRlVYc0JnWEpO?=
 =?utf-8?B?dXk0Wm1ZWDc4VnJPbnJnVFlzMkROdHpGNmJ0eHZEaFppeVpQVTFNcEMxN2Uy?=
 =?utf-8?B?SW1uL3F1bDhkYTlkOUdnUEFzMmJ5QWlwbFJtN00zaU83WjJQSk5kZ0JxM1Yv?=
 =?utf-8?B?REF3L2U0b3AxanlvOTBZZGszWlhUNTQ3a0dRVWJLZENUZDRjN0k0WHdZUDh3?=
 =?utf-8?B?dGdNb3lGN0FJaVdPNy90d0pDUC9PbmlDQkpueWp6OTl2OStRaWRBU0pSdERW?=
 =?utf-8?B?RGNzeUtVb3pHUTFSUmh4U2thMXZ2TTVjb2NFaUlwTlJoVXhBTkhHY01JUmMz?=
 =?utf-8?B?RHlLVGVGRHZQVTFLUkxJZ0k0MG1GdExjdDdKd0dlUVcwR2JqZTVKUGRBODFL?=
 =?utf-8?B?aUFIa1N3UjQwWjRTRVRKUzFkeS9rbUZpakV4YjlYbGhTQS9LM3U4MTA4Wlkz?=
 =?utf-8?B?U1BTTWVJcmtISjY0K01raStFRk1iYVFZRkk2UnppTHVvb0x1aS9Sck84K29r?=
 =?utf-8?B?Q25TazlJNEtyaVM5Q281RXVoUFZMTXpaVkF6TWZoRVVuVnMxQnVmTjBnNVlL?=
 =?utf-8?B?RVhsMXRmbjg2U3JFTkUrK1NuTUk5ZUswTzRLa0prRjZVVkpjMEROV0R3cEMv?=
 =?utf-8?B?bGlnUXIyN0VJMks2d2NveEsvOHgwYit5elRRK2paTFFVbVR2dEE0Q3JVNFJQ?=
 =?utf-8?B?TERIV3pmcXJucVBNVTNEYkF0R1VJTDB2dHVPVS9uNWVjeGFabFBnaUIzdUt4?=
 =?utf-8?B?bXFiSTJoV2ZpTVVKTGV5bzBKZzlTWDJuU2dvNlhjVWxaamx5ZTF5d1hZeXRQ?=
 =?utf-8?B?L0s1eFlaSk1Xc0ljNU92N1YzSnk3UFp2bytTeFJZYzdNMkt2VkxlcXJFaHJr?=
 =?utf-8?B?SlA1eTdITWN4VDR0K0xMMFRrVnQvZXZCUjV0VFltNWhoZy9tWGUvWklFSU5P?=
 =?utf-8?B?Si82YmoxVjQ4Rk9DdnFQaU5MUUhwOGlJZzhEYTRGQWFjWTNZUUJNd2cxbGYw?=
 =?utf-8?B?blBwR3dibXN4b3lXOVpzS3J5cU9jSEVLOUNiN2hvTHI2dVphdFBLZlJQSzBP?=
 =?utf-8?B?QzVRbisvRk02UlYwZmtqTUsxaWhhQlBTSHlNWloyV3ovVEttNzgwYXhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGRNcDZlVnlVamlMSzVKaVBNK1RFVktHdENndGZweHFoWFpJdm9ZVUovcmsw?=
 =?utf-8?B?Wm1kSXpCb1Nyc3RTYnNudHAySE5CUUsvV0NRcTVjZDZwV1J0dm5KU2RYdVR1?=
 =?utf-8?B?QWtoOG91Z1FZVzZLajV4RDZRUjdCeXE3eExoSG5odTJYdHVLNFhpTXNKbEhp?=
 =?utf-8?B?L2pGS2NLTVJHQU9nOXlyeW1aVnlSek5vQ3RLMUI4N3QxVU90VDY3dWVGM0Vm?=
 =?utf-8?B?eFRnUnhtaUpQUFN1SFBoZGtGajZ6dnJ1ZEkxaU5UdERYOU9Nc3dQSGZRN1Rp?=
 =?utf-8?B?R1MwRUF2NHpsWHZ6NGloSVVYVXRIQmpuMXdxYTdjKzFCK0NIa1ZvMWZ6NUxK?=
 =?utf-8?B?WittaFZuQ1lsS1hSZ3RPKzRHM2oxZm4vZmhtNVQ1amI4VWFPUWtaWm5kdEI1?=
 =?utf-8?B?Q0VnWUpVVVdnK0crand6NnJYbHpOVHBZbG5QaVJxMG04ZlVkR0lKVHF6MGQv?=
 =?utf-8?B?MWJYd21GZjJYMnJ1SW9ZdFhLUEVTWmhmZEVQbDhOUXJPQVphV0dwZENCc1hV?=
 =?utf-8?B?WFdYZUVXUGw0ampFck9Id3ozR3RJckY0cEd3MDJIR01UT3FRNlB2eW1NZnBX?=
 =?utf-8?B?Q3FxcUtDQWsyU3lCcTV4VjRYSGN4OVRUYjM5bUd1dGtmOFFrYm1saXl1YzJo?=
 =?utf-8?B?K096d29kekdJUzl1TGdRVVRtMzNjNmxMcTdUY1BBaTVJQVh6N0ltR1JiWEFm?=
 =?utf-8?B?OVlweHhZc25kaElDc0Roa0tKK3FxTjBSV0NzdVdEbnFPKzQzNDQyVjByTlhH?=
 =?utf-8?B?b05IK3ZQWDdyWmlmRDF1Y2EvUFd2NzlNYURTNGc2SGFjRXRKbzQ2MWl0WXpI?=
 =?utf-8?B?NjZqUG1qdEZEZ25tOXJ6dEZna0RkUWtSQXRHQUo4WnQ4RVZ5V1ZUMUoyamx1?=
 =?utf-8?B?QkxsSER6eVhOZEFoTWgzaHZrMCtoMmhFdzZLN2FwT1QvYnVoNGVBSVdzMElY?=
 =?utf-8?B?TStxWFI2SGNmaGZzS0hpL0lPd01lY1NkNmVVWG5ReE1zejBXSjc5UjUrNi9Q?=
 =?utf-8?B?ZTljYlVFS25mL2MyN1EvY1crTStmeU9zbXRZbUxKa25JOGU0VzUxb1l3ZFY0?=
 =?utf-8?B?T3gwRWtNUTZvV0hmZGxEVEROYnNlSG82dGNIUnpaTVF3V09STzZUTXRiZnJP?=
 =?utf-8?B?emtsOG5VSGZJWDVSSFhmK1p3N254NW5BcHJlcFlFeUNhcGVibElzdWZ4QSs4?=
 =?utf-8?B?a0ZhMlpxWjRYSEMzQ21TQXNxNVZubm5UUE9saEhsV0l0aVUrV3g5TFVkQ1lP?=
 =?utf-8?B?MlM4V1ZZK3kzYnFvRDJMcy9PdG52SmFLc25HV1lDL01PZDQ5QlVWcHJROUh2?=
 =?utf-8?B?K3AxU0YyWHJNMkticmY1VmEvNjZ6dUhybWRrMlk2M0NSVXB2aG1pRS8rMlRQ?=
 =?utf-8?B?djF1NENqL2lmb2tuQVZHSTNGbk95blNZd0k1Qk91bHFTUkFDOTlUSUJxa3pq?=
 =?utf-8?B?a0lJZEZjeWpMSTRsbXhKRHpGTzN3WW93RTBmM3laeDFBTjNEU056azdOY2Zn?=
 =?utf-8?B?SzBxRGhPMXlSNjY5eGJYZmVVOGdMVjNVUVJxYVVXcnN2ZlRFWjlyMEQ2Qk0v?=
 =?utf-8?B?ZU1xaDFSVjkzUG1ZbXQyNkFWaTNtd0FyMEV4QVlEMi9wNUxKT2VIYmVBK3Y3?=
 =?utf-8?B?c2dGVnNJY1FUMGVTTFVkeFBWeUQvN2RkcFMyRGtWZ0hJdmJ6WGc5L2k3bTZi?=
 =?utf-8?B?WkJud09DaFB6Z1Fvam5vbDJHSzd5RjVMM1pqNGhoUGorVHlKWEVEWCtQTGZN?=
 =?utf-8?B?bHoxYlNVNG1TY1M5akYvMlU5RkxmS0lOcmVMUy9sOG4yTktyZzJEcU5SNlZI?=
 =?utf-8?B?dlgrNXE0SUxRVUJNWFVPdEZNSTRtYjRKSTZGVUR6UFJtRGNKcjBBZ2JQRDdQ?=
 =?utf-8?B?Z1NTdEQxaXNuUThncGhJNStISVJLYnowNGZmNGZ6RkUzOGQ4Y3ArUTNtWEFa?=
 =?utf-8?B?TEN2ZDJ3RVdCczhlL0h4R0ZSTUE1UW15dmhZZGIxSXVISGFGemdyWHBGTnZy?=
 =?utf-8?B?Zk0wQVNhakN0ZlUybDJiWVE4YStqazc5aGhmenZuT2kxc2l1bVJBZHdjUmhF?=
 =?utf-8?B?enZyVHZHT1ZJWW9sNW0wWWpYWjlNbWFoYWEzejZIOWdXRkoyNFRPVm1taG83?=
 =?utf-8?Q?jjPJUTWkHQiakwSr0AWFzOzMR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a837726f-8f57-4f72-b523-08dce4a493e0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:44:31.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdA/7V9j4tujdfXGIJ8MgK1eCZ4ksK9j5MPgpHphSBMmayfRAcotPBqCmvXpobT9Hr8p03Tj+gRFHY4zGdhcEw==
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


On 2024-10-02 13:32, Alex Deucher wrote:
> On Wed, Oct 2, 2024 at 12:39 AM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Add instance number to ip block to track which instance the ip block
>> belongs to.
>>
>> Also, add a new function to allow ip block to save the instance number
>> along with other ip block driver information.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> I think the logic can be added to the existing
> amdgpu_device_ip_block_add().  Something like the attached patch.
>
> Alex


Thanks for the suggestion. And yes, this is a much smarter way =)

Applied in the new v2 patch set.

Regards,
Boyuan


>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 84a9749dcd7d..d77db73c71f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -386,6 +386,7 @@ struct amdgpu_ip_block {
>>          struct amdgpu_ip_block_status status;
>>          const struct amdgpu_ip_block_version *version;
>>          struct amdgpu_device *adev;
>> +       unsigned int instance;
>>   };
>>
>>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>> @@ -399,6 +400,10 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
>>   int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>>                                 const struct amdgpu_ip_block_version *ip_block_version);
>>
>> +int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
>> +                              const struct amdgpu_ip_block_version *ip_block_version,
>> +                              unsigned int inst);
>> +
>>   /*
>>    * BIOS.
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 263f25ac2d63..4bc109a0d832 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2321,6 +2321,45 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>>          return 0;
>>   }
>>
>> +/**
>> + * amdgpu_device_ip_block_add_instance
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @ip_block_version: pointer to the IP to add
>> + *
>> + * Adds the IP block driver information and instance number
>> + * to the collection of IPs on the asic.
>> + */
>> +int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
>> +                              const struct amdgpu_ip_block_version *ip_block_version,
>> +                              unsigned int inst)
>> +{
>> +       if (!ip_block_version)
>> +               return -EINVAL;
>> +
>> +       switch (ip_block_version->type) {
>> +       case AMD_IP_BLOCK_TYPE_VCN:
>> +               if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
>> +                       return 0;
>> +               break;
>> +       case AMD_IP_BLOCK_TYPE_JPEG:
>> +               if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
>> +                       return 0;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
>> +                 ip_block_version->funcs->name);
>> +
>> +       adev->ip_blocks[adev->num_ip_blocks].adev = adev;
>> +       adev->ip_blocks[adev->num_ip_blocks].instance = inst;
>> +       adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
>> +
>> +       return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_device_enable_virtual_display - enable virtual display feature
>>    *
>> --
>> 2.34.1
>>
