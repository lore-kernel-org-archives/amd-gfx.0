Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD0AD116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6B10E9E3;
	Fri, 25 Oct 2024 02:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBhcMG/O";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E85010E9E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7LFituwpB/3zarZsnY4qm874swQ5QdCpj7Q9mLjIZWLac8nfkaKbOkEpIpP9/CILLpSEl9swhxHyprr3n16NCth3s57J5tDlU8tVUbAP/onkpNTreaw2VcvlWTnxYlau9uga8yp3ocmaD79+pCIV/3nVX0jDTLfwbi+nWKkBQrlDWQHAMI0b+yDDWiFmQeSVf+4k3QPhJ7Gem/H4FSytJAX3RbmSgKh5PTZLrLwJNuoWqgUjzCzLXID5juM+KPksATxsV1vjK0dMijhduUG6I/WM2a5azTnonss3EsbZJSx8zQrJSwlfdAl4/RrZuIQkjgRMSpvNoEU0/1vP/ScCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTluUpRVtqVWkJUppsIplzmmbzm4r0lDjjSONrt/+14=;
 b=RW6A2EJcuRcnbJ1VQdG1Y94fWieJcm6aMWl81FrEUXOLzK4LoMHlKbbBNWv5qb1pDVy2uaR7qnFJ3zjhkyP9nACmp1HAXBHS5xL2F7MlOAsWILABEoUcazvOtXZ4M3zemxE3gXz6wje95Pi+hmrRgeUikGDIARSTl2YZ2GqV8dJe3oVjDbjFAsqrwe10H9H06yhmaDMi89Ml2KgBA9lj0i53SJvMUbaxGvap/d4+Afopl/uuJJHGS2mOjxcqbV4pGXYs8qYv1g6msRAhzZYdhI7KK22UfzogV0LWlUflrsyT5b0wtzrggUzlp2wQBRyyRX0eFXUaP1E5H4kteHQlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTluUpRVtqVWkJUppsIplzmmbzm4r0lDjjSONrt/+14=;
 b=MBhcMG/OGf47dHeZVgvQN1uhw/itZ9Amn/wqf92EriNq2EsI/e7ntU76ho4h381V1og9C7cmerJJo6LMIyXh0wUO9pvGpjwAs+4WvI+PtWjEVu1nJOq8Pr0CiD7zpBMVZ1h5rZ+RphsAAKXT6sc5ayUluteXbXSSDW4VMt8FKic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:48:02 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 02:48:02 +0000
Message-ID: <13c3f252-e971-428a-bb5d-00df4ec5078e@amd.com>
Date: Thu, 24 Oct 2024 22:48:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/32] drm/amdgpu: pass ip_block in set_clockgating_state
To: "Khatri, Sunil" <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org,
 leo.liu@amd.com, christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <20241017132053.53214-9-boyuan.zhang@amd.com>
 <1afcd9aa-0efc-dc0f-997d-d14741736e24@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <1afcd9aa-0efc-dc0f-997d-d14741736e24@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0430.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::13) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aa46ec-8a53-46e7-244a-08dcf49f7162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUl6Q3FiOFBuU2MxZkRZbmV4NzlhVk1lYzdFZ1N2R3Z4TkJJd1FlRFRkY2NM?=
 =?utf-8?B?N3dpbVpZbmJuaTAxL09LWVFmckpPSlFUSnRnTUczMDQ2V2RTT3ZMZlJJeWU3?=
 =?utf-8?B?Z1NURlN4Tm9qQkFENTAzL29LN0dkb0U3T0o3Ujh3aytIaWc0V1BGV1JaUlhN?=
 =?utf-8?B?SDZ3RlFhczl3Vm81dDhtcTIxRldTQU9JNWMxcEh1ZGpRVkRWeC9Hb01HMDhy?=
 =?utf-8?B?ZG1YeHI0M3JidFlvSk1haS8rWGpoQTRFZXhDWXdDUGhZOUxJYTFQUUNOdEd4?=
 =?utf-8?B?ZnA2Y0QxYzV2c1krWC9wUktlUndnTktVYjV1aWFwNG91UktrZkloSjlkNmta?=
 =?utf-8?B?VTdvbGUxYXdHdSs1Ui9DRy9xeUF2aWxoMUErWU5BQ1huT2JOSVJBQjY0akFX?=
 =?utf-8?B?M3NaL09xNU1rMHYvdk9pK1loNTkwa2J4NXFPNHpPUEVwWlhIS1l4djBjQzVt?=
 =?utf-8?B?SG5WVHlGZDR3cDVBTXNsT0w4R29kZHdlNzlnTXhPL29vYmFrTGdiTmpBNE1Y?=
 =?utf-8?B?RnQxajJybFUwWnVXQlVMdndGdFovQmQ0a3paV3hDYnFXZFhsbzVxVm1lS3kr?=
 =?utf-8?B?eEhXTXUyTmlXM2ZUQ3ZsdGJkd1FIdEs3MlFmZ2h2Sm92cjBQTktQUExwU21s?=
 =?utf-8?B?Z3ZIUVFCYWNYbHFGakdXZm1vK212SGZhY3VZa0xvV1dRMjJaNUNYb2RlWDZz?=
 =?utf-8?B?a2VWUFduMFZiUm9jUmNkdER0ZFU3UjY0VDRGbXByWEprVUdVZ29Qb0o5Q21m?=
 =?utf-8?B?V1BnQnlkTHIvOVBHZDVtWGtEKzVYa0RVZHFrd3NBUUY4emRnYUROZU0wVmRS?=
 =?utf-8?B?SHRBSXpqTG1pMitqY3NxYlA4ajVMUzlWbk1UZ1NNMUZIRjFRWHdnTFh5dU5m?=
 =?utf-8?B?VGlVbXZyNy9tKzVlNERITXlheUl4ZnplUUplZjBOYXY1NlNCWkhHS1ArVHpo?=
 =?utf-8?B?OGZCS2ZtN1grcGs2VmlvMmJKNnpLV2MySkcvbGFWSWVrcldWZDlMYTFJeUgr?=
 =?utf-8?B?RWFML3RWMS92VkdvV0tUaTVFOXhZejNubWZWTnUybEYwd1VSaCtnQUdDYXFz?=
 =?utf-8?B?T1ExVUxveXoxSm9zSFF2V1VlUjh6MTdoMVY0RS82STZJRk9pYTJOUk5GdUNp?=
 =?utf-8?B?QnlNN1FVaGllTDR0ZVgzdWNNSVU2dG5BUUxIVVJEdG1JMFo3d0NuZmk5Z2I0?=
 =?utf-8?B?S05yK2RHV3BlUDdHSTcxNFZWRE9jWGlReG9pb3NHOE1FRzFEY1EvdlRIajJT?=
 =?utf-8?B?TEoyZkgvQ3BsRjhvQUxENVRNOG9aV2pHQzdXSDlLWXpYZlBsTGVubGxDUkx4?=
 =?utf-8?B?ZTVlZWRzdldTdGRtM0RMaGtzbHhSSlhnR1dYVGVXMjdvT3JCTWRpSTE0Yldx?=
 =?utf-8?B?VUZ0bUJtL09yS0xVRnJDUUMzc2MwbjRLakJScmV4djNDdFBvRFByVWcvRE01?=
 =?utf-8?B?VEc1ZVNnS2FFZkJMbU15Y002Z0J0cElnRkI3WGZBbGRTZWRISFEyQlgrSm9N?=
 =?utf-8?B?bEQyaTVyekVPbzBwQ1FYRGJtKzlWM1BBMzZzdnI3cGtYUHRrYmRPcElHdlNN?=
 =?utf-8?B?aHkrQjExRnc3Ky9wVVJOeU1JMUo2WDVkZDBEdHhXVW5nWkUxN2IyNXRpNU1F?=
 =?utf-8?B?blc5WkdiWkRXQXpSZnk4d0ExdldLV2lSc0d4eFY4NldSRUdTWWtxZW1PcEZr?=
 =?utf-8?B?SkhlRnlpNng5bHMvL2VLRndkWUZrYytIZVhNd09yRTBEaXJvU1ZnZ25YRUVY?=
 =?utf-8?Q?kU9BcWxWnaYH5FTjzWAocirq0YKWdNbaAbUgriR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTkxenBCVStheXJpMllOaGQ0TmJsaVI3RzRrMlIyTHZ6LzJqSGZFK3FDeEpY?=
 =?utf-8?B?STBDeDYvaUV0cFFjT1dHVmVBeHhrWVhJeDA1SWtadmUreUlnVktielRtZmsz?=
 =?utf-8?B?c29NdkgrWWhpWjFqdjF2Y2sxQ0Y4WEMwSEExR2ZqaTlPSTI2OXNTZEVVeGVu?=
 =?utf-8?B?SzNDRGlqL3ZVdnZHL3F6MVB2amhnNGwreWcrRkt2NzJtWTF6UnV1L1AwSFh4?=
 =?utf-8?B?OEVGNUlodWhiTFZUVlpqVXM2NG4wL0lJT21WbldLVFFGMEtRQlJDZUNyOENY?=
 =?utf-8?B?aGt5MHcvOEZ2dzdpT21nSmo0SjhlL0tub1M1eGpkeTRCeFM2cnA1ZGQyclRs?=
 =?utf-8?B?bTA0TVFLQmFCeHJmRHkrY214dzgybFUvcDVtV1BsRWEyN3g1Qmk5MGxkTzVV?=
 =?utf-8?B?Y3R4cGxiVWxOZ1RDelRpR1FQSzdXM0dYZzVZTkFqeEdEZ0x1K0QrL2FsYmx0?=
 =?utf-8?B?ZVVSRDM1ZzlGekpMb2NidzIyV1pXd1lhcEowSzhYeDNMaGcrRE5aZmRoSm5v?=
 =?utf-8?B?SHlQQklyKzFWcEYwS1E1Y1YxS240dmpaZ0M3MXY2TU1HUldoM0Vzc3F6L0k0?=
 =?utf-8?B?WFJxNlNqMlVBUk9sZU5ZYXRTY0c0QWZERGJuRTYzelg3bFZ0WXQ1M2g5NEk3?=
 =?utf-8?B?UWQwTjl6M1pyd3JoV3dQUTRhNWlRd0oxbWUxOWRMZm03QkxHS2xCREZ0L1dU?=
 =?utf-8?B?Vk1VZERXKzRNblF3NE43c0ZWb29kMjZjbGpQSGM3YmtBSmJaUlR5Um9DZURL?=
 =?utf-8?B?emRaSVd0VmVwYlNuK3A2bnV3eC8rUU1JN21KR3lVMHFMdzl0TXF6MHQvdVpR?=
 =?utf-8?B?b3ZGMnppZ05LNWI0UUpSS2s5Zk00cmVEUU5ZUk91eUgvUDBRMDhRL3hYWW5o?=
 =?utf-8?B?M3ZoOTZNTm91NjE3Uk1JbjUxdXF2Z0xIcG96Qlp1dzRlUjMwcU1zejZIMmJN?=
 =?utf-8?B?N1owS3ZTdnVDWjkwOHViQ1NWamluRnB4TWRiVkovOWROeEUyNjNiTi9GcVRu?=
 =?utf-8?B?M3pRaVVKbjZidXZTZWYxTnFoNFpwcWlvMGw0cFIwMFpRWTRGd0pMSElEdU9B?=
 =?utf-8?B?c0tVTHd3cjJMMzRrM1BobUZ6VTArWm0zNnJzRzNGS3lVQWkxWnVrSkkwaFVn?=
 =?utf-8?B?V1pXTDlvSThLL2UzMTlFNFNmTUVLclphcmxZckNEVFVDMDVNdkRQZFJQT2x0?=
 =?utf-8?B?VUZNczVlS3NpaFRPOGNEM0g5dGI2b3d5UmlXNm9mY0xqWWM2dVFJblp5MUpr?=
 =?utf-8?B?a3BXMEkwT1BrYkFxT054SHB5ZnoyQ21DM0ZTT29obWovenZmaWJSYUpud29H?=
 =?utf-8?B?cW9acCtTTXcvTzNWdlczeEtqc3p2TUh2cEx1V0E3N3M1SDFINFlUMWhibnZK?=
 =?utf-8?B?SmtGNXV6TStPbVppb2ZzeDE0aW9XdnIreUZpTW9xYXU4ejhsNnk1N00zN09i?=
 =?utf-8?B?YzZTYTl2RXprK2xGbTR2MFZsUU40TDYzdGdLQ2o3TUt5MytUa1dETUUwSElu?=
 =?utf-8?B?Nmd4Z0gxeDV2bzRzdndJNEdMdHlhT1o5QVhLS0hFSUJlTTMxS1RxNlVoVTRD?=
 =?utf-8?B?bjlBSVl6VFNtSElEbmtsVzk2MXRMRTdEK3FiTjlORTJnSTJXU2VmMm4reDFE?=
 =?utf-8?B?a3ZkeUp2TG1taG1rdHZxbXVEUXFxNGw1RktUSHVHMWJTMW1wZW43K1Erbkdn?=
 =?utf-8?B?TXJBZUt5K2J2a0t6dlBIOFhEdTRZYXRIbU1KMHlyaWtXbHc5b1ZKQ1h4MGFR?=
 =?utf-8?B?MmRlNDJSSUJmcEpBMk4wdllCcjFPRmhBQzd1NDYrOVZVMlJJLys1MXJBdGFm?=
 =?utf-8?B?WTZJMXQ3ejdGWlhJZ0RESWVsc0c0L0pQOFNCOGxsVEN1YVRmYjZTT2UzcHM4?=
 =?utf-8?B?NHg5SHJLSWhBUGdLM0x0U1hCbFd6YU03YU52SURhTHh1R1ZmNjd5VXNyUFYy?=
 =?utf-8?B?cVk5Q0pYdDdzNzVXVVBLakV1UW1PcWxCN1gwbUVMcXNQb216NlBJRC8vbTJC?=
 =?utf-8?B?MEN1cEsvLzVKbTBCazEyUlhoeVJaQmhGWVhGWUZuSkpSMTl3b3NXUm9Vdks3?=
 =?utf-8?B?bGtMU1g4OU5qaUtpcVVpT0ZuTXVyZmNDSTN2Y2NkTnNtMk8veFhYczIwMGpV?=
 =?utf-8?Q?Efm+NakF923iRiUY0psEov4qG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aa46ec-8a53-46e7-244a-08dcf49f7162
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:48:02.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLhJk5FTAADNCudLhF4/4Mxv6nZyiTIru5/BMEhBOr0/ZSQTFNKTxQTjM8H2YXWPQ+Bcq8P5QbT3vDkE2+A4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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


On 2024-10-22 03:58, Khatri, Sunil wrote:
>
> On 10/17/2024 6:50 PM, boyuan.zhang@amd.com wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Pass ip_block instead of adev in set_clockgating_state() and is_idle()
>> callback functions. Modify set_clockgating_state() and is_idle() ip
>> functions for all correspoding ip blocks.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/cik.c              |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/nv.c               |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 12 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/si.c               |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c           | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         | 17 ++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 19 +++++++------------
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 14 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 11 ++++++-----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/vi.c               |  6 +++---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++--
>>   drivers/gpu/drm/amd/include/amd_shared.h      |  4 ++--
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 ++--
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  4 ++--
>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  4 ++--
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
>>   82 files changed, 293 insertions(+), 299 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> index 64828cb7c2f1..5b0856b89801 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> @@ -579,7 +579,7 @@ static int acp_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static bool acp_is_idle(void *handle)
>> +static bool acp_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> is_idle isnt used and based on last discussion with christian we left 
>> it as it is as this might be removed totally later.
>> @@ -594,7 +594,7 @@ static int acp_soft_reset(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static int acp_set_clockgating_state(void *handle,
>> +static int acp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index fe5de35eef64..af159ebe9cbc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2120,7 +2120,7 @@ int amdgpu_device_ip_set_clockgating_state(void 
>> *dev,
>>           if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
>>               continue;
>>           r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
>> -            (void *)adev, state);
>> +            (void *)&adev->ip_blocks[i], state);
>> Casting not needed anymore.
>>           if (r)
>>               DRM_ERROR("set_clockgating_state of IP block <%s> 
>> failed %d\n",
>> adev->ip_blocks[i].version->funcs->name, r);
>> @@ -3091,7 +3091,7 @@ int amdgpu_device_set_cg_state(struct 
>> amdgpu_device *adev,
>>               adev->ip_blocks[i].version->type != 
>> AMD_IP_BLOCK_TYPE_JPEG &&
>> adev->ip_blocks[i].version->funcs->set_clockgating_state) {
>>               /* enable clockgating to save power */
>> -            r = 
>> adev->ip_blocks[i].version->funcs->set_clockgating_state((void *)adev,
>> +            r = 
>> adev->ip_blocks[i].version->funcs->set_clockgating_state((void 
>> *)&adev->ip_blocks[i],
>>                                                state);
>>               if (r) {
>>                   DRM_ERROR("set_clockgating_state(gate) of IP block 
>> <%s> failed %d\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index 844f71eeea27..fc89dee1b972 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -143,7 +143,7 @@ static int isp_early_init(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static bool isp_is_idle(void *handle)
>> +static bool isp_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> Done need to change is_idle.


Fixed in new patch-set just submitted (patch 08/29)


>> @@ -158,7 +158,7 @@ static int isp_soft_reset(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static int isp_set_clockgating_state(void *handle,
>> +static int isp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 527470323c33..86a68d5ee05f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -3787,7 +3787,7 @@ int psp_config_sq_perfmon(struct psp_context *psp,
>>       return ret;
>>   }
>>   -static int psp_set_clockgating_state(void *handle,
>> +static int psp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                       enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> index f44ce5edba6a..89ee35f980cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> @@ -626,7 +626,7 @@ static int amdgpu_vkms_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
>>   }
>>   -static bool amdgpu_vkms_is_idle(void *handle)
>> +static bool amdgpu_vkms_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -641,7 +641,7 @@ static int amdgpu_vkms_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int amdgpu_vkms_set_clockgating_state(void *handle,
>> +static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index f3a9ea3f6044..416d1a073173 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -638,7 +638,7 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring 
>> *ring)
>>       return r;
>>   }
>>   -static int vpe_set_clockgating_state(void *handle,
>> +static int vpe_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index 08b398aa6c6d..1f637c7a256d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -2163,7 +2163,7 @@ static int cik_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return cik_common_hw_init(ip_block);
>>   }
>>   -static bool cik_common_is_idle(void *handle)
>> +static bool cik_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -2179,7 +2179,7 @@ static int cik_common_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int cik_common_set_clockgating_state(void *handle,
>> +static int cik_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> index 42c3eb8b6a95..a1ad74f6d581 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> @@ -345,9 +345,9 @@ static int cik_ih_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return cik_ih_hw_init(ip_block);
>>   }
>>   -static bool cik_ih_is_idle(void *handle)
>> +static bool cik_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (tmp & SRBM_STATUS__IH_BUSY_MASK)
>> @@ -402,7 +402,7 @@ static int cik_ih_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int cik_ih_set_clockgating_state(void *handle,
>> +static int cik_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 5283b0e94f02..ef352d7be29c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -1023,9 +1023,9 @@ static int cik_sdma_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return cik_sdma_hw_init(ip_block);
>>   }
>>   -static bool cik_sdma_is_idle(void *handle)
>> +static bool cik_sdma_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS2);
>>         if (tmp & (SRBM_STATUS2__SDMA_BUSY_MASK |
>> @@ -1189,11 +1189,11 @@ static int 
>> cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int cik_sdma_set_clockgating_state(void *handle,
>> +static int cik_sdma_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_CG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> index 4bf5402bd3aa..c9fa011308d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> @@ -341,9 +341,9 @@ static int cz_ih_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return cz_ih_hw_init(ip_block);
>>   }
>>   -static bool cz_ih_is_idle(void *handle)
>> +static bool cz_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
>> @@ -398,7 +398,7 @@ static int cz_ih_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int cz_ih_set_clockgating_state(void *handle,
>> +static int cz_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       // TODO
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> index e7505934cce2..96acbb56cd4b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> @@ -2943,7 +2943,7 @@ static int dce_v10_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return amdgpu_display_resume_helper(adev);
>>   }
>>   -static bool dce_v10_0_is_idle(void *handle)
>> +static bool dce_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -3307,7 +3307,7 @@ static int dce_v10_0_hpd_irq(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int dce_v10_0_set_clockgating_state(void *handle,
>> +static int dce_v10_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> index 8adee675f4d5..48c5270b8a3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> @@ -3081,7 +3081,7 @@ static int dce_v11_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return amdgpu_display_resume_helper(adev);
>>   }
>>   -static bool dce_v11_0_is_idle(void *handle)
>> +static bool dce_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -3439,7 +3439,7 @@ static int dce_v11_0_hpd_irq(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int dce_v11_0_set_clockgating_state(void *handle,
>> +static int dce_v11_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index 66cb19f9b073..65a9fdb36d06 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -2838,7 +2838,7 @@ static int dce_v6_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return amdgpu_display_resume_helper(adev);
>>   }
>>   -static bool dce_v6_0_is_idle(void *handle)
>> +static bool dce_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -3129,7 +3129,7 @@ static int dce_v6_0_hpd_irq(struct 
>> amdgpu_device *adev,
>>     }
>>   -static int dce_v6_0_set_clockgating_state(void *handle,
>> +static int dce_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> index 57a5207b4e76..c48f8a1fdc4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> @@ -2861,7 +2861,7 @@ static int dce_v8_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return amdgpu_display_resume_helper(adev);
>>   }
>>   -static bool dce_v8_0_is_idle(void *handle)
>> +static bool dce_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -3217,7 +3217,7 @@ static int dce_v8_0_hpd_irq(struct 
>> amdgpu_device *adev,
>>     }
>>   -static int dce_v8_0_set_clockgating_state(void *handle,
>> +static int dce_v8_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index b5da9a1e8216..831beedcbaeb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -7486,9 +7486,9 @@ static int gfx_v10_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v10_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v10_0_is_idle(void *handle)
>> +static bool gfx_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (REG_GET_FIELD(RREG32_SOC15(GC, 0, mmGRBM_STATUS),
>>                   GRBM_STATUS, GUI_ACTIVE))
>> @@ -8377,10 +8377,10 @@ static int 
>> gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>>   -static int gfx_v10_0_set_clockgating_state(void *handle,
>> +static int gfx_v10_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 92786e3bbf0e..72ef40a6eb3d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4737,9 +4737,9 @@ static int gfx_v11_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v11_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v11_0_is_idle(void *handle)
>> +static bool gfx_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (REG_GET_FIELD(RREG32_SOC15(GC, 0, regGRBM_STATUS),
>>                   GRBM_STATUS, GUI_ACTIVE))
>> @@ -5460,10 +5460,10 @@ static int 
>> gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>>   -static int gfx_v11_0_set_clockgating_state(void *handle,
>> +static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>               return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 4ff78c9e3e43..64551c8cea97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -3653,9 +3653,9 @@ static int gfx_v12_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v12_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v12_0_is_idle(void *handle)
>> +static bool gfx_v12_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (REG_GET_FIELD(RREG32_SOC15(GC, 0, regGRBM_STATUS),
>>                   GRBM_STATUS, GUI_ACTIVE))
>> @@ -4097,10 +4097,10 @@ static int 
>> gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gfx_v12_0_set_clockgating_state(void *handle,
>> +static int gfx_v12_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 429aa895d6bf..37ce7193701f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -3163,9 +3163,9 @@ static int gfx_v6_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v6_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v6_0_is_idle(void *handle)
>> +static bool gfx_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (RREG32(mmGRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK)
>>           return false;
>> @@ -3179,7 +3179,7 @@ static int gfx_v6_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (gfx_v6_0_is_idle(adev))
>> +        if (gfx_v6_0_is_idle(ip_block))
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -3378,11 +3378,11 @@ static int gfx_v6_0_priv_inst_irq(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gfx_v6_0_set_clockgating_state(void *handle,
>> +static int gfx_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_CG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 7c04dccec8d7..fb8e56472e65 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -4509,9 +4509,9 @@ static int gfx_v7_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v7_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v7_0_is_idle(void *handle)
>> +static bool gfx_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (RREG32(mmGRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK)
>>           return false;
>> @@ -4846,11 +4846,11 @@ static int gfx_v7_0_priv_inst_irq(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gfx_v7_0_set_clockgating_state(void *handle,
>> +static int gfx_v7_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_CG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 22ada2ede46b..15db88295288 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -4830,9 +4830,9 @@ static int gfx_v8_0_kcq_disable(struct 
>> amdgpu_device *adev)
>>       return r;
>>   }
>>   -static bool gfx_v8_0_is_idle(void *handle)
>> +static bool gfx_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (REG_GET_FIELD(RREG32(mmGRBM_STATUS), GRBM_STATUS, 
>> GUI_ACTIVE)
>>           || RREG32(mmGRBM_STATUS2) != 0x8)
>> @@ -4871,7 +4871,7 @@ static int gfx_v8_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (gfx_v8_0_is_idle(adev))
>> +        if (gfx_v8_0_is_idle(ip_block))
>> Can continue to use adev is not removing is_idle.
>>               return 0;
>>             udelay(1);
>> @@ -5975,10 +5975,10 @@ static int 
>> gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gfx_v8_0_set_clockgating_state(void *handle,
>> +static int gfx_v8_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 6516e88c55aa..bc8853b65787 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -4084,9 +4084,9 @@ static int gfx_v9_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v9_0_hw_init(ip_block);
>>   }
>>   -static bool gfx_v9_0_is_idle(void *handle)
>> +static bool gfx_v9_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (REG_GET_FIELD(RREG32_SOC15(GC, 0, mmGRBM_STATUS),
>>                   GRBM_STATUS, GUI_ACTIVE))
>> @@ -4101,7 +4101,7 @@ static int gfx_v9_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (gfx_v9_0_is_idle(adev))
>> +        if (gfx_v9_0_is_idle(ip_block))
>> Same as above and other places in this patch.
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -5259,10 +5259,10 @@ static int 
>> gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>>   -static int gfx_v9_0_set_clockgating_state(void *handle,
>> +static int gfx_v9_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 627652cab308..dd4b62764b23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -2396,9 +2396,9 @@ static int gfx_v9_4_3_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return gfx_v9_4_3_hw_init(ip_block);
>>   }
>>   -static bool gfx_v9_4_3_is_idle(void *handle)
>> +static bool gfx_v9_4_3_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, num_xcc;
>>         num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> @@ -2416,7 +2416,7 @@ static int gfx_v9_4_3_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (gfx_v9_4_3_is_idle(adev))
>> +        if (gfx_v9_4_3_is_idle(ip_block))
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -2766,10 +2766,10 @@ static int 
>> gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>>   -static int gfx_v9_4_3_set_clockgating_state(void *handle,
>> +static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, num_xcc;
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index b398021d5b90..22a158091674 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -1073,7 +1073,7 @@ static int gmc_v10_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v10_0_is_idle(void *handle)
>> +static bool gmc_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* MC is always ready in GMC v10.*/
>>       return true;
>> @@ -1090,11 +1090,11 @@ static int gmc_v10_0_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int gmc_v10_0_set_clockgating_state(void *handle,
>> +static int gmc_v10_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>>       int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         /*
>>        * The issue mmhub can't disconnect from DF with MMHUB clock 
>> gating being disabled
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 36e2f4e5a865..53ec799832ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -981,7 +981,7 @@ static int gmc_v11_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v11_0_is_idle(void *handle)
>> +static bool gmc_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* MC is always ready in GMC v11.*/
>>       return true;
>> @@ -998,11 +998,11 @@ static int gmc_v11_0_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int gmc_v11_0_set_clockgating_state(void *handle,
>> +static int gmc_v11_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>>       int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         r = adev->mmhub.funcs->set_clockgating(adev, state);
>>       if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index c6510f12afb4..06472c90a58d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -965,7 +965,7 @@ static int gmc_v12_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v12_0_is_idle(void *handle)
>> +static bool gmc_v12_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* MC is always ready in GMC v11.*/
>>       return true;
>> @@ -982,11 +982,11 @@ static int gmc_v12_0_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int gmc_v12_0_set_clockgating_state(void *handle,
>> +static int gmc_v12_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>>       int r;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         r = adev->mmhub.funcs->set_clockgating(adev, state);
>>       if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 3965b9ca8e9c..c7b3b18d6152 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -956,9 +956,9 @@ static int gmc_v6_0_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v6_0_is_idle(void *handle)
>> +static bool gmc_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         u32 tmp = RREG32(mmSRBM_STATUS);
>>   @@ -975,7 +975,7 @@ static int gmc_v6_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (gmc_v6_0_is_idle(adev))
>> +        if (gmc_v6_0_is_idle(ip_block))
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -1094,7 +1094,7 @@ static int gmc_v6_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gmc_v6_0_set_clockgating_state(void *handle,
>> +static int gmc_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index b43eaa42e5c7..7d084f98f3b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -1131,9 +1131,9 @@ static int gmc_v7_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v7_0_is_idle(void *handle)
>> +static bool gmc_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | 
>> SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
>> @@ -1307,11 +1307,11 @@ static int gmc_v7_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int gmc_v7_0_set_clockgating_state(void *handle,
>> +static int gmc_v7_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_CG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index d36cf90d4133..ee279518b5db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1262,9 +1262,9 @@ static int gmc_v8_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v8_0_is_idle(void *handle)
>> +static bool gmc_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | 
>> SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
>> @@ -1658,10 +1658,10 @@ static void fiji_update_mc_light_sleep(struct 
>> amdgpu_device *adev,
>>       }
>>   }
>>   -static int gmc_v8_0_set_clockgating_state(void *handle,
>> +static int gmc_v8_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 5aac51d9db2f..b2b907c82d9b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2446,7 +2446,7 @@ static int gmc_v9_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static bool gmc_v9_0_is_idle(void *handle)
>> +static bool gmc_v9_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* MC is always ready in GMC v9.*/
>>       return true;
>> @@ -2464,10 +2464,10 @@ static int gmc_v9_0_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int gmc_v9_0_set_clockgating_state(void *handle,
>> +static int gmc_v9_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                       enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         adev->mmhub.funcs->set_clockgating(adev, state);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> index 879d34e88014..784a77e06935 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> @@ -335,9 +335,9 @@ static int iceland_ih_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return iceland_ih_hw_init(ip_block);
>>   }
>>   -static bool iceland_ih_is_idle(void *handle)
>> +static bool iceland_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
>> @@ -392,7 +392,7 @@ static int iceland_ih_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int iceland_ih_set_clockgating_state(void *handle,
>> +static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index 4f271d9f43ba..47e105659177 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -652,7 +652,7 @@ static int ih_v6_0_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return ih_v6_0_hw_init(ip_block);
>>   }
>>   -static bool ih_v6_0_is_idle(void *handle)
>> +static bool ih_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -693,10 +693,10 @@ static void 
>> ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
>>       }
>>   }
>>   -static int ih_v6_0_set_clockgating_state(void *handle,
>> +static int ih_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         ih_v6_0_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> index 5b0a1eaa1fd0..a18778a50272 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> @@ -631,7 +631,7 @@ static int ih_v6_1_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return ih_v6_1_hw_init(ip_block);
>>   }
>>   -static bool ih_v6_1_is_idle(void *handle)
>> +static bool ih_v6_1_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -674,10 +674,10 @@ static void 
>> ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
>>       return;
>>   }
>>   -static int ih_v6_1_set_clockgating_state(void *handle,
>> +static int ih_v6_1_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         ih_v6_1_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> index a584863f1bed..b5c3e7886167 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> @@ -621,7 +621,7 @@ static int ih_v7_0_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return ih_v7_0_hw_init(ip_block);
>>   }
>>   -static bool ih_v7_0_is_idle(void *handle)
>> +static bool ih_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -664,10 +664,10 @@ static void 
>> ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
>>       return;
>>   }
>>   -static int ih_v7_0_set_clockgating_state(void *handle,
>> +static int ih_v7_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         ih_v7_0_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> index c5f692a45bee..e13d1c2a9378 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> @@ -655,9 +655,9 @@ void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring 
>> *ring, uint32_t count)
>>       }
>>   }
>>   -static bool jpeg_v2_0_is_idle(void *handle)
>> +static bool jpeg_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return ((RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS) &
>>           UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
>> @@ -675,14 +675,14 @@ static int jpeg_v2_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int jpeg_v2_0_set_clockgating_state(void *handle,
>> +static int jpeg_v2_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>         if (enable) {
>> -        if (!jpeg_v2_0_is_idle(handle))
>> +        if (!jpeg_v2_0_is_idle(ip_block))
>> Same as above.
>>               return -EBUSY;
>>           jpeg_v2_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> index f1ddef8e60ee..091baf408a86 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> @@ -482,9 +482,9 @@ static void jpeg_v2_6_dec_ring_insert_end(struct 
>> amdgpu_ring *ring)
>>       amdgpu_ring_write(ring, (1 << (ring->me * 2 + 14)));
>>   }
>>   -static bool jpeg_v2_5_is_idle(void *handle)
>> +static bool jpeg_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> @@ -518,10 +518,10 @@ static int jpeg_v2_5_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int jpeg_v2_5_set_clockgating_state(void *handle,
>> +static int jpeg_v2_5_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>       int i;
>>   @@ -530,7 +530,7 @@ static int jpeg_v2_5_set_clockgating_state(void 
>> *handle,
>>               continue;
>>             if (enable) {
>> -            if (!jpeg_v2_5_is_idle(handle))
>> +            if (!jpeg_v2_5_is_idle(ip_block))
>>                   return -EBUSY;
>>               jpeg_v2_5_enable_clock_gating(adev, i);
>>           } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> index 69f0a9006b96..1f284f1f29d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> @@ -445,9 +445,9 @@ static void jpeg_v3_0_dec_ring_set_wptr(struct 
>> amdgpu_ring *ring)
>>       }
>>   }
>>   -static bool jpeg_v3_0_is_idle(void *handle)
>> +static bool jpeg_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 1;
>>         ret &= (((RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS) &
>> @@ -466,14 +466,14 @@ static int jpeg_v3_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>           UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>   }
>>   -static int jpeg_v3_0_set_clockgating_state(void *handle,
>> +static int jpeg_v3_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>         if (enable) {
>> -        if (!jpeg_v3_0_is_idle(handle))
>> +        if (!jpeg_v3_0_is_idle(ip_block))
>>               return -EBUSY;
>>           jpeg_v3_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> index e304108d7024..e78135cdddd8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> @@ -607,9 +607,9 @@ static void jpeg_v4_0_dec_ring_set_wptr(struct 
>> amdgpu_ring *ring)
>>       }
>>   }
>>   -static bool jpeg_v4_0_is_idle(void *handle)
>> +static bool jpeg_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 1;
>>         ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS) &
>> @@ -628,14 +628,14 @@ static int jpeg_v4_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>           UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>   }
>>   -static int jpeg_v4_0_set_clockgating_state(void *handle,
>> +static int jpeg_v4_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>         if (enable) {
>> -        if (!jpeg_v4_0_is_idle(handle))
>> +        if (!jpeg_v4_0_is_idle(ip_block))
>>               return -EBUSY;
>>           jpeg_v4_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index f4d6a4768ee2..83c211b48208 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -899,9 +899,9 @@ void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring 
>> *ring, uint32_t count)
>>       }
>>   }
>>   -static bool jpeg_v4_0_3_is_idle(void *handle)
>> +static bool jpeg_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool ret = false;
>>       int i, j;
>>   @@ -941,16 +941,16 @@ static int jpeg_v4_0_3_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int jpeg_v4_0_3_set_clockgating_state(void *handle,
>> +static int jpeg_v4_0_3_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>       int i;
>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>           if (enable) {
>> -            if (!jpeg_v4_0_3_is_idle(handle))
>> +            if (!jpeg_v4_0_3_is_idle(ip_block))
>>                   return -EBUSY;
>>               jpeg_v4_0_3_enable_clock_gating(adev, i);
>>           } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> index 2a28eb479a34..8f53f3a40084 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> @@ -619,9 +619,9 @@ static void jpeg_v4_0_5_dec_ring_set_wptr(struct 
>> amdgpu_ring *ring)
>>       }
>>   }
>>   -static bool jpeg_v4_0_5_is_idle(void *handle)
>> +static bool jpeg_v4_0_5_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> @@ -652,10 +652,10 @@ static int jpeg_v4_0_5_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int jpeg_v4_0_5_set_clockgating_state(void *handle,
>> +static int jpeg_v4_0_5_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>>       int i;
>>   @@ -664,7 +664,7 @@ static int 
>> jpeg_v4_0_5_set_clockgating_state(void *handle,
>>               continue;
>>             if (enable) {
>> -            if (!jpeg_v4_0_5_is_idle(handle))
>> +            if (!jpeg_v4_0_5_is_idle(ip_block))
>>                   return -EBUSY;
>>                 jpeg_v4_0_5_enable_clock_gating(adev, i);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index 692d0083b5f7..8329692dff07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -532,9 +532,9 @@ static void jpeg_v5_0_0_dec_ring_set_wptr(struct 
>> amdgpu_ring *ring)
>>       }
>>   }
>>   -static bool jpeg_v5_0_0_is_idle(void *handle)
>> +static bool jpeg_v5_0_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 1;
>>         ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS) &
>> @@ -553,14 +553,14 @@ static int jpeg_v5_0_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>           UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>   }
>>   -static int jpeg_v5_0_0_set_clockgating_state(void *handle,
>> +static int jpeg_v5_0_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>>         if (enable) {
>> -        if (!jpeg_v5_0_0_is_idle(handle))
>> +        if (!jpeg_v5_0_0_is_idle(ip_block))
>>               return -EBUSY;
>>           jpeg_v5_0_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 9ca248ea3428..6094e41d3960 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -626,7 +626,7 @@ static int navi10_ih_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return navi10_ih_hw_init(ip_block);
>>   }
>>   -static bool navi10_ih_is_idle(void *handle)
>> +static bool navi10_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -667,10 +667,10 @@ static void 
>> navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
>>       }
>>   }
>>   -static int navi10_ih_set_clockgating_state(void *handle,
>> +static int navi10_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         navi10_ih_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 6481f72b32d6..bdad7ec60db4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -1039,7 +1039,7 @@ static int nv_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return nv_common_hw_init(ip_block);
>>   }
>>   -static bool nv_common_is_idle(void *handle)
>> +static bool nv_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -1054,10 +1054,10 @@ static int nv_common_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int nv_common_set_clockgating_state(void *handle,
>> +static int nv_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index 6a1028baf16d..7cfab1adbcb1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -909,9 +909,9 @@ static int sdma_v2_4_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v2_4_hw_init(ip_block);
>>   }
>>   -static bool sdma_v2_4_is_idle(void *handle)
>> +static bool sdma_v2_4_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS2);
>>         if (tmp & (SRBM_STATUS2__SDMA_BUSY_MASK |
>> @@ -1080,7 +1080,7 @@ static int 
>> sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int sdma_v2_4_set_clockgating_state(void *handle,
>> +static int sdma_v2_4_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       /* XXX handled via the smc on VI */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index 42d996d4136f..ca8cab33c026 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -1198,9 +1198,9 @@ static int sdma_v3_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v3_0_hw_init(ip_block);
>>   }
>>   -static bool sdma_v3_0_is_idle(void *handle)
>> +static bool sdma_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS2);
>>         if (tmp & (SRBM_STATUS2__SDMA_BUSY_MASK |
>> @@ -1483,10 +1483,10 @@ static void 
>> sdma_v3_0_update_sdma_medium_grain_light_sleep(
>>       }
>>   }
>>   -static int sdma_v3_0_set_clockgating_state(void *handle,
>> +static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index a2f5f2be699b..a57c2aedf182 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2015,9 +2015,9 @@ static int sdma_v4_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v4_0_hw_init(ip_block);
>>   }
>>   -static bool sdma_v4_0_is_idle(void *handle)
>> +static bool sdma_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -2297,10 +2297,10 @@ static void 
>> sdma_v4_0_update_medium_grain_light_sleep(
>>       }
>>   }
>>   -static int sdma_v4_0_set_clockgating_state(void *handle,
>> +static int sdma_v4_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index 95d5de2bd186..12386220515e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1505,7 +1505,7 @@ static int sdma_v4_4_2_hw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int sdma_v4_4_2_set_clockgating_state(void *handle,
>> +static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                            enum amd_clockgating_state state);
>>     static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
>> @@ -1513,7 +1513,7 @@ static int sdma_v4_4_2_suspend(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_in_reset(adev))
>> -        sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
>> +        sdma_v4_4_2_set_clockgating_state(ip_block, 
>> AMD_CG_STATE_UNGATE);
>>         return sdma_v4_4_2_hw_fini(ip_block);
>>   }
>> @@ -1523,9 +1523,9 @@ static int sdma_v4_4_2_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v4_4_2_hw_init(ip_block);
>>   }
>>   -static bool sdma_v4_4_2_is_idle(void *handle)
>> +static bool sdma_v4_4_2_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -1812,10 +1812,10 @@ static void 
>> sdma_v4_4_2_inst_update_medium_grain_clock_gating(
>>       }
>>   }
>>   -static int sdma_v4_4_2_set_clockgating_state(void *handle,
>> +static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       uint32_t inst_mask;
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 82a8bbd53d49..d4f2ece8c1f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -1512,9 +1512,9 @@ static int sdma_v5_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v5_0_hw_init(ip_block);
>>   }
>>   -static bool sdma_v5_0_is_idle(void *handle)
>> +static bool sdma_v5_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -1835,10 +1835,10 @@ static void 
>> sdma_v5_0_update_medium_grain_light_sleep(struct amdgpu_device *adev
>>       }
>>   }
>>   -static int sdma_v5_0_set_clockgating_state(void *handle,
>> +static int sdma_v5_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index b84d5c27bb94..cc1eae69df68 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -1412,9 +1412,9 @@ static int sdma_v5_2_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v5_2_hw_init(ip_block);
>>   }
>>   -static bool sdma_v5_2_is_idle(void *handle)
>> +static bool sdma_v5_2_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -1789,10 +1789,10 @@ static void 
>> sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>>       }
>>   }
>>   -static int sdma_v5_2_set_clockgating_state(void *handle,
>> +static int sdma_v5_2_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index bc9fe03ab145..911151c3d41b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1410,9 +1410,9 @@ static int sdma_v6_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v6_0_hw_init(ip_block);
>>   }
>>   -static bool sdma_v6_0_is_idle(void *handle)
>> +static bool sdma_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -1583,7 +1583,7 @@ static int 
>> sdma_v6_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int sdma_v6_0_set_clockgating_state(void *handle,
>> +static int sdma_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index c224e7e7e103..d265696553df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -1368,9 +1368,9 @@ static int sdma_v7_0_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return sdma_v7_0_hw_init(ip_block);
>>   }
>>   -static bool sdma_v7_0_is_idle(void *handle)
>> +static bool sdma_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 i;
>>         for (i = 0; i < adev->sdma.num_instances; i++) {
>> @@ -1518,7 +1518,7 @@ static int 
>> sdma_v7_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int sdma_v7_0_set_clockgating_state(void *handle,
>> +static int sdma_v7_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
>> b/drivers/gpu/drm/amd/amdgpu/si.c
>> index 6b0211c94836..8a1100bc4f17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>> @@ -2660,7 +2660,7 @@ static int si_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return si_common_hw_init(ip_block);
>>   }
>>   -static bool si_common_is_idle(void *handle)
>> +static bool si_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -2675,7 +2675,7 @@ static int si_common_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int si_common_set_clockgating_state(void *handle,
>> +static int si_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c 
>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> index 26782dad9311..7527731322f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> @@ -541,9 +541,9 @@ static int si_dma_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return si_dma_hw_init(ip_block);
>>   }
>>   -static bool si_dma_is_idle(void *handle)
>> +static bool si_dma_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         u32 tmp = RREG32(SRBM_STATUS2);
>>   @@ -559,7 +559,7 @@ static int si_dma_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (si_dma_is_idle(adev))
>> +        if (si_dma_is_idle(ip_block))
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -629,13 +629,13 @@ static int si_dma_process_trap_irq(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int si_dma_set_clockgating_state(void *handle,
>> +static int si_dma_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       u32 orig, data, offset;
>>       int i;
>>       bool enable;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         enable = (state == AMD_CG_STATE_GATE);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> index 976d803bef8c..f18887145887 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> @@ -210,9 +210,9 @@ static int si_ih_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return si_ih_hw_init(ip_block);
>>   }
>>   -static bool si_ih_is_idle(void *handle)
>> +static bool si_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(SRBM_STATUS);
>>         if (tmp & SRBM_STATUS__IH_BUSY_MASK)
>> @@ -227,7 +227,7 @@ static int si_ih_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (si_ih_is_idle(adev))
>> +        if (si_ih_is_idle(ip_block))
>>               return 0;
>>           udelay(1);
>>       }
>> @@ -263,7 +263,7 @@ static int si_ih_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int si_ih_set_clockgating_state(void *handle,
>> +static int si_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 9fbada694cd7..c4c5f688ff26 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -1334,7 +1334,7 @@ static int soc15_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return soc15_common_hw_init(ip_block);
>>   }
>>   -static bool soc15_common_is_idle(void *handle)
>> +static bool soc15_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -1393,10 +1393,10 @@ static void 
>> soc15_update_drm_light_sleep(struct amdgpu_device *adev, bool enable
>>           WREG32(SOC15_REG_OFFSET(MP0, 0, 
>> mmMP0_MISC_LIGHT_SLEEP_CTRL), data);
>>   }
>>   -static int soc15_common_set_clockgating_state(void *handle,
>> +static int soc15_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> index 6497a65f9738..1f5f7ab4a304 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> @@ -927,7 +927,7 @@ static int soc21_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return soc21_common_hw_init(ip_block);
>>   }
>>   -static bool soc21_common_is_idle(void *handle)
>> +static bool soc21_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -942,10 +942,10 @@ static int soc21_common_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int soc21_common_set_clockgating_state(void *handle,
>> +static int soc21_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>>       case IP_VERSION(4, 3, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> index 7b43d8908448..1392fc88b857 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> @@ -522,7 +522,7 @@ static int soc24_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return soc24_common_hw_init(ip_block);
>>   }
>>   -static bool soc24_common_is_idle(void *handle)
>> +static bool soc24_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -537,10 +537,10 @@ static int soc24_common_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int soc24_common_set_clockgating_state(void *handle,
>> +static int soc24_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                             enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>>       case IP_VERSION(6, 3, 1):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> index 77fba40e1dbc..d987637b0394 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> @@ -353,9 +353,9 @@ static int tonga_ih_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return tonga_ih_hw_init(ip_block);
>>   }
>>   -static bool tonga_ih_is_idle(void *handle)
>> +static bool tonga_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 tmp = RREG32(mmSRBM_STATUS);
>>         if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
>> @@ -448,7 +448,7 @@ static int tonga_ih_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int tonga_ih_set_clockgating_state(void *handle,
>> +static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> index 561fc15173b6..d5a5a5189ac6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> @@ -758,9 +758,9 @@ static int uvd_v3_1_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return uvd_v3_1_hw_init(ip_block);
>>   }
>>   -static bool uvd_v3_1_is_idle(void *handle)
>> +static bool uvd_v3_1_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
>>   }
>> @@ -790,7 +790,7 @@ static int uvd_v3_1_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return uvd_v3_1_start(adev);
>>   }
>>   -static int uvd_v3_1_set_clockgating_state(void *handle,
>> +static int uvd_v3_1_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> index 6bd728153b4c..9e3ac12d0127 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> @@ -44,7 +44,7 @@ static void uvd_v4_2_set_ring_funcs(struct 
>> amdgpu_device *adev);
>>   static void uvd_v4_2_set_irq_funcs(struct amdgpu_device *adev);
>>   static int uvd_v4_2_start(struct amdgpu_device *adev);
>>   static void uvd_v4_2_stop(struct amdgpu_device *adev);
>> -static int uvd_v4_2_set_clockgating_state(void *handle,
>> +static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_clockgating_state state);
>>   static void uvd_v4_2_set_dcm(struct amdgpu_device *adev,
>>                    bool sw_mode);
>> @@ -658,9 +658,9 @@ static void uvd_v4_2_set_dcm(struct amdgpu_device 
>> *adev,
>>       WREG32_UVD_CTX(ixUVD_CGC_CTRL2, tmp2);
>>   }
>>   -static bool uvd_v4_2_is_idle(void *handle)
>> +static bool uvd_v4_2_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
>>   }
>> @@ -708,7 +708,7 @@ static int uvd_v4_2_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int uvd_v4_2_set_clockgating_state(void *handle,
>> +static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> index 02e0e5c9e701..a16c99d0b85d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> @@ -42,7 +42,7 @@ static void uvd_v5_0_set_ring_funcs(struct 
>> amdgpu_device *adev);
>>   static void uvd_v5_0_set_irq_funcs(struct amdgpu_device *adev);
>>   static int uvd_v5_0_start(struct amdgpu_device *adev);
>>   static void uvd_v5_0_stop(struct amdgpu_device *adev);
>> -static int uvd_v5_0_set_clockgating_state(void *handle,
>> +static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state);
>>   static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
>>                    bool enable);
>> @@ -155,7 +155,7 @@ static int uvd_v5_0_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       int r;
>>         amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
>> -    uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
>> +    uvd_v5_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
>>       uvd_v5_0_enable_mgcg(adev, true);
>>         r = amdgpu_ring_test_helper(ring);
>> @@ -580,9 +580,9 @@ static void uvd_v5_0_ring_insert_nop(struct 
>> amdgpu_ring *ring, uint32_t count)
>>       }
>>   }
>>   -static bool uvd_v5_0_is_idle(void *handle)
>> +static bool uvd_v5_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
>>   }
>> @@ -790,16 +790,11 @@ static void uvd_v5_0_enable_mgcg(struct 
>> amdgpu_device *adev,
>>       }
>>   }
>>   -static int uvd_v5_0_set_clockgating_state(void *handle,
>> +static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>> -    struct amdgpu_ip_block *ip_block;
>> -
>> -    ip_block = amdgpu_device_ip_get_ip_block(adev, 
>> AMD_IP_BLOCK_TYPE_UVD);
>> -    if (!ip_block)
>> -        return -EINVAL;
>>         if (enable) {
>>           /* wait for STATUS to clear */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index fdf23d2b0e42..5da51118a184 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -48,7 +48,7 @@ static void uvd_v6_0_set_irq_funcs(struct 
>> amdgpu_device *adev);
>>   static int uvd_v6_0_start(struct amdgpu_device *adev);
>>   static void uvd_v6_0_stop(struct amdgpu_device *adev);
>>   static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev);
>> -static int uvd_v6_0_set_clockgating_state(void *handle,
>> +static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state);
>>   static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
>>                    bool enable);
>> @@ -467,7 +467,7 @@ static int uvd_v6_0_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       int i, r;
>>         amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
>> -    uvd_v6_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
>> +    uvd_v6_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
>>       uvd_v6_0_enable_mgcg(adev, true);
>>         r = amdgpu_ring_test_helper(ring);
>> @@ -1143,9 +1143,9 @@ static void 
>> uvd_v6_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>       amdgpu_ring_write(ring, vmid);
>>   }
>>   -static bool uvd_v6_0_is_idle(void *handle)
>> +static bool uvd_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
>>   }
>> @@ -1156,7 +1156,7 @@ static int uvd_v6_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (uvd_v6_0_is_idle(adev))
>> +        if (uvd_v6_0_is_idle(ip_block))
>>               return 0;
>>       }
>>       return -ETIMEDOUT;
>> @@ -1450,17 +1450,12 @@ static void uvd_v6_0_enable_mgcg(struct 
>> amdgpu_device *adev,
>>       }
>>   }
>>   -static int uvd_v6_0_set_clockgating_state(void *handle,
>> +static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -    struct amdgpu_ip_block *ip_block;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>   -    ip_block = amdgpu_device_ip_get_ip_block(adev, 
>> AMD_IP_BLOCK_TYPE_UVD);
>> -    if (!ip_block)
>> -        return -EINVAL;
>> -
>>       if (enable) {
>>           /* wait for STATUS to clear */
>>           if (uvd_v6_0_wait_for_idle(ip_block))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index 55fa858328f6..591db2da8067 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -1779,7 +1779,7 @@ static int uvd_v7_0_set_powergating_state(void 
>> *handle,
>>   }
>>   #endif
>>   -static int uvd_v7_0_set_clockgating_state(void *handle,
>> +static int uvd_v7_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       /* needed for driver unload*/
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> index 836643c99572..f4bd28af41e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -201,9 +201,9 @@ static void vce_v2_0_mc_resume(struct 
>> amdgpu_device *adev)
>>       WREG32_FIELD(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);
>>   }
>>   -static bool vce_v2_0_is_idle(void *handle)
>> +static bool vce_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
>>   }
>> @@ -214,7 +214,7 @@ static int vce_v2_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       unsigned i;
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -        if (vce_v2_0_is_idle(adev))
>> +        if (vce_v2_0_is_idle(ip_block))
>>               return 0;
>>       }
>>       return -ETIMEDOUT;
>> @@ -578,13 +578,13 @@ static int vce_v2_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int vce_v2_0_set_clockgating_state(void *handle,
>> +static int vce_v2_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       bool gate = false;
>>       bool sw_cg = false;
>>   -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_CG_STATE_GATE) {
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index e985cf1e63f1..679033481616 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -65,7 +65,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device 
>> *adev, int idx);
>>   static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev);
>>   static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev);
>>   static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
>> -static int vce_v3_0_set_clockgating_state(void *handle,
>> +static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state);
>>   /**
>>    * vce_v3_0_ring_get_rptr - get read pointer
>> @@ -497,7 +497,7 @@ static int vce_v3_0_hw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>           return r;
>>         vce_v3_0_stop(adev);
>> -    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>> +    return vce_v3_0_set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
>>   }
>>     static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>> @@ -597,9 +597,9 @@ static void vce_v3_0_mc_resume(struct 
>> amdgpu_device *adev, int idx)
>>       WREG32_FIELD(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);
>>   }
>>   -static bool vce_v3_0_is_idle(void *handle)
>> +static bool vce_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       u32 mask = 0;
>>         mask |= (adev->vce.harvest_config & AMDGPU_VCE_HARVEST_VCE0) 
>> ? 0 : SRBM_STATUS2__VCE0_BUSY_MASK;
>> @@ -614,7 +614,7 @@ static int vce_v3_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>         for (i = 0; i < adev->usec_timeout; i++)
>> -        if (vce_v3_0_is_idle(adev))
>> +        if (vce_v3_0_is_idle(ip_block))
>>               return 0;
>>         return -ETIMEDOUT;
>> @@ -760,10 +760,10 @@ static int vce_v3_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int vce_v3_0_set_clockgating_state(void *handle,
>> +static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 30d64672f3c5..adcbf61411b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -684,7 +684,7 @@ static void vce_v4_0_mc_resume(struct 
>> amdgpu_device *adev)
>> ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
>>   }
>>   -static int vce_v4_0_set_clockgating_state(void *handle,
>> +static int vce_v4_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       /* needed for driver unload*/
>> @@ -911,10 +911,10 @@ static void vce_v4_0_set_bypass_mode(struct 
>> amdgpu_device *adev, bool enable)
>>       WREG32_SMC(ixGCK_DFS_BYPASS_CNTL, tmp);
>>   }
>>   -static int vce_v4_0_set_clockgating_state(void *handle,
>> +static int vce_v4_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 34b1e55a907a..37ff3c140e81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -1377,9 +1377,9 @@ static int vcn_v1_0_pause_dpg_mode(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static bool vcn_v1_0_is_idle(void *handle)
>> +static bool vcn_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return (RREG32_SOC15(VCN, 0, mmUVD_STATUS) == UVD_STATUS__IDLE);
>>   }
>> @@ -1395,15 +1395,15 @@ static int vcn_v1_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int vcn_v1_0_set_clockgating_state(void *handle,
>> +static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>         if (enable) {
>>           /* wait for STATUS to clear */
>> -        if (!vcn_v1_0_is_idle(handle))
>> +        if (!vcn_v1_0_is_idle(ip_block))
>>               return -EBUSY;
>>           vcn_v1_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index 6c1f5d05f90a..bda39d2dd7be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -1317,9 +1317,9 @@ static int vcn_v2_0_pause_dpg_mode(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static bool vcn_v2_0_is_idle(void *handle)
>> +static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         return (RREG32_SOC15(VCN, 0, mmUVD_STATUS) == UVD_STATUS__IDLE);
>>   }
>> @@ -1335,10 +1335,10 @@ static int vcn_v2_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int vcn_v2_0_set_clockgating_state(void *handle,
>> +static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>> @@ -1346,7 +1346,7 @@ static int vcn_v2_0_set_clockgating_state(void 
>> *handle,
>>         if (enable) {
>>           /* wait for STATUS to clear */
>> -        if (!vcn_v2_0_is_idle(handle))
>> +        if (!vcn_v2_0_is_idle(ip_block))
>>               return -EBUSY;
>>           vcn_v2_0_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 35ded346771d..aa6c01f5854e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -1775,14 +1775,15 @@ static void 
>> vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
>>       }
>>   }
>>   -static bool vcn_v2_5_is_idle(void *handle)
>> +static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> +
>>           ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == 
>> UVD_STATUS__IDLE);
>>       }
>>   @@ -1806,17 +1807,17 @@ static int vcn_v2_5_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int vcn_v2_5_set_clockgating_state(void *handle,
>> +static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>>         if (enable) {
>> -        if (!vcn_v2_5_is_idle(handle))
>> +        if (!vcn_v2_5_is_idle(ip_block))
>>               return -EBUSY;
>>           vcn_v2_5_enable_clock_gating(adev);
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index c02c9ef8ddeb..dbe432e765c1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -2103,9 +2103,9 @@ static void vcn_v3_0_set_enc_ring_funcs(struct 
>> amdgpu_device *adev)
>>       }
>>   }
>>   -static bool vcn_v3_0_is_idle(void *handle)
>> +static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> @@ -2136,10 +2136,10 @@ static int vcn_v3_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>       return ret;
>>   }
>>   -static int vcn_v3_0_set_clockgating_state(void *handle,
>> +static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 319eb5a3d061..37e60d6e11b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1959,9 +1959,9 @@ static void 
>> vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>>    *
>>    * Check whether VCN block is idle
>>    */
>> -static bool vcn_v4_0_is_idle(void *handle)
>> +static bool vcn_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> @@ -2007,9 +2007,10 @@ static int vcn_v4_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>    *
>>    * Set VCN block clockgating state
>>    */
>> -static int vcn_v4_0_set_clockgating_state(void *handle, enum 
>> amd_clockgating_state state)
>> +static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +                      enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index b6c1135d6fec..a7aab3102aca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -1553,14 +1553,14 @@ static void 
>> vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
>>    *
>>    * Check whether VCN block is idle
>>    */
>> -static bool vcn_v4_0_3_is_idle(void *handle)
>> +static bool vcn_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
>> -            UVD_STATUS__IDLE);
>> +                       UVD_STATUS__IDLE);
>>       }
>>         return ret;
>> @@ -1595,10 +1595,10 @@ static int vcn_v4_0_3_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>    *
>>    * Set VCN block clockgating state
>>    */
>> -static int vcn_v4_0_3_set_clockgating_state(void *handle,
>> +static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = state == AMD_CG_STATE_GATE;
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> index ebf6301b13be..895f82b9e81b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> @@ -1453,9 +1453,9 @@ static void 
>> vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
>>    *
>>    * Check whether VCN block is idle
>>    */
>> -static bool vcn_v4_0_5_is_idle(void *handle)
>> +static bool vcn_v4_0_5_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> @@ -1501,9 +1501,10 @@ static int vcn_v4_0_5_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>    *
>>    * Set VCN block clockgating state
>>    */
>> -static int vcn_v4_0_5_set_clockgating_state(void *handle, enum 
>> amd_clockgating_state state)
>> +static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +                      enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index 50c102f1b5fe..dfc974ff4f6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -1180,9 +1180,9 @@ static void 
>> vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>>    *
>>    * Check whether VCN block is idle
>>    */
>> -static bool vcn_v5_0_0_is_idle(void *handle)
>> +static bool vcn_v5_0_0_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int i, ret = 1;
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> @@ -1228,9 +1228,10 @@ static int vcn_v5_0_0_wait_for_idle(struct 
>> amdgpu_ip_block *ip_block)
>>    *
>>    * Set VCN block clockgating state
>>    */
>> -static int vcn_v5_0_0_set_clockgating_state(void *handle, enum 
>> amd_clockgating_state state)
>> +static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +                      enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>>       int i;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index 8df4f4352d65..217df1d08cc3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -556,7 +556,7 @@ static int vega10_ih_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return vega10_ih_hw_init(ip_block);
>>   }
>>   -static bool vega10_ih_is_idle(void *handle)
>> +static bool vega10_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -605,10 +605,10 @@ static void 
>> vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
>>       }
>>   }
>>   -static int vega10_ih_set_clockgating_state(void *handle,
>> +static int vega10_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         vega10_ih_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index 4ac43aeb85c1..35f1e9fa6430 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -624,7 +624,7 @@ static int vega20_ih_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return vega20_ih_hw_init(ip_block);
>>   }
>>   -static bool vega20_ih_is_idle(void *handle)
>> +static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* todo */
>>       return true;
>> @@ -670,10 +670,10 @@ static void 
>> vega20_ih_update_clockgating_state(struct amdgpu_device *adev,
>>       }
>>   }
>>   -static int vega20_ih_set_clockgating_state(void *handle,
>> +static int vega20_ih_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         vega20_ih_update_clockgating_state(adev,
>>                   state == AMD_CG_STATE_GATE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>> index 6b58723f0b2e..614f049d88b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>> @@ -1741,7 +1741,7 @@ static int vi_common_resume(struct 
>> amdgpu_ip_block *ip_block)
>>       return vi_common_hw_init(ip_block);
>>   }
>>   -static bool vi_common_is_idle(void *handle)
>> +static bool vi_common_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -1960,10 +1960,10 @@ static int 
>> vi_common_set_clockgating_state_by_smu(void *handle,
>>       return 0;
>>   }
>>   -static int vi_common_set_clockgating_state(void *handle,
>> +static int vi_common_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_clockgating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev))
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index d5a0417f95df..3297f2ed51af 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -314,7 +314,7 @@ static int dm_crtc_get_scanoutpos(struct 
>> amdgpu_device *adev, int crtc,
>>       return 0;
>>   }
>>   -static bool dm_is_idle(void *handle)
>> +static bool dm_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* XXX todo */
>>       return true;
>> @@ -955,7 +955,7 @@ static void dm_dmub_outbox1_low_irq(void 
>> *interrupt_params)
>>       }
>>   }
>>   -static int dm_set_clockgating_state(void *handle,
>> +static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>             enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 03c77bbc2e6d..42445413b27b 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -390,13 +390,13 @@ struct amd_ip_funcs {
>>       int (*prepare_suspend)(struct amdgpu_ip_block *ip_block);
>>       int (*suspend)(struct amdgpu_ip_block *ip_block);
>>       int (*resume)(struct amdgpu_ip_block *ip_block);
>> -    bool (*is_idle)(void *handle);
>> +    bool (*is_idle)(struct amdgpu_ip_block *ip_block);
>> let it be same as original code.
>>       int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
>>       bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
>>       int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
>>       int (*soft_reset)(struct amdgpu_ip_block *ip_block);
>>       int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
>> -    int (*set_clockgating_state)(void *handle,
>> +    int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
>>                        enum amd_clockgating_state state);
>>       int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state);
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c 
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> index d5130da88162..3cafc9493e88 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> @@ -3094,7 +3094,7 @@ static int kv_dpm_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static bool kv_dpm_is_idle(void *handle)
>> +static bool kv_dpm_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return true;
>>   }
>> @@ -3188,7 +3188,7 @@ static int kv_dpm_process_interrupt(struct 
>> amdgpu_device *adev,
>>       return 0;
>>   }
>>   -static int kv_dpm_set_clockgating_state(void *handle,
>> +static int kv_dpm_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c 
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> index 18c47fa89bc1..b61f44844d25 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> @@ -7837,7 +7837,7 @@ static int si_dpm_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static bool si_dpm_is_idle(void *handle)
>> +static bool si_dpm_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       /* XXX */
>>       return true;
>> @@ -7854,7 +7854,7 @@ static int si_dpm_soft_reset(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int si_dpm_set_clockgating_state(void *handle,
>> +static int si_dpm_set_clockgating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                       enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c 
>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> index 069b604d6e7a..8b678be90089 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> @@ -239,7 +239,7 @@ static void pp_late_fini(struct amdgpu_ip_block 
>> *ip_block)
>>   }
>>     -static bool pp_is_idle(void *handle)
>> +static bool pp_is_idle(struct amdgpu_ip_block *ip_block)
>>   {
>>       return false;
>>   }
>> @@ -277,7 +277,7 @@ static int pp_resume(struct amdgpu_ip_block 
>> *ip_block)
>>       return hwmgr_resume(hwmgr);
>>   }
>>   -static int pp_set_clockgating_state(void *handle,
>> +static int pp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                         enum amd_clockgating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 4aaaf0e0b851..15310f74c483 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2178,7 +2178,7 @@ static int 
>> smu_display_configuration_change(void *handle,
>>       return 0;
>>   }
>>   -static int smu_set_clockgating_state(void *handle,
>> +static int smu_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_clockgating_state state)
>>   {
>>       return 0;
