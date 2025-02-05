Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA18FC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 13:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C93D10E165;
	Wed,  5 Feb 2025 13:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2vkuq3YH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DC710E1EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 13:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhqAYOKQEpvxn8rAghUN1tHJixsWMaCetX77mgzw4WY8kYxbOEKUgiKztz7Gr+MyIhxrtJmYwJjyjIwy5g5/iL188NzOafQIWAnC+2D+zN0drN4a/6LijtUCH035UCArzUDR6UGCydAOFfbjwtTmll7AsRtI7MVXJoM3eP2/oQWbU8FTAtKmEa+JVU5ocdJ6MNII3mHrcQIL8SbtbaoqUdtVA57DjSit+HLiG7WO8w6u2sAmGD279Pmr8+UR5tPIYtegT27TXvGD3gcFrGq1VV0C03gI4h0v5q8Dfjme+hSXgpaWvpdUkWz6XExSdLaX/8HkTGnXZNHBzLBEbIgCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJC4lofn/Sz4HMyBN75MDY+FeU1DbY3yzh+UhDm9pQw=;
 b=bi2qgVng9W3TaPs98jRdB0ryOE8T/OY5/g2yjrlTofoRSrRWQWHX1UiX61OnbpYj2c0kjUaHkVRQ/S3WJF+DdhlvXfn9wnAI6KZq1k86BDXsZLr7FdMcS3uTfk9mHc6qcSTDjQCMC2thgav5UvzoM5u0TBSANMsZ6qd5qXOdAypAE2ylp7YgmwN6rStpIsZPJTkenToQuLJp9t9UWspBPb5bbSu89gs0Fm9gzdH0kQKdCFcAATQkL3B7wacAjTcnDOMrrINWQROB0VIuFTaWT3SqI8OBAZ5d8Ul6dAHZErFQu4DLOhQjwvj5ywAO+YR9j8AK/Y0xDZCEPEmL9zXJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJC4lofn/Sz4HMyBN75MDY+FeU1DbY3yzh+UhDm9pQw=;
 b=2vkuq3YHmg+IUes5twnyEMnFnM6EvQjd+//y8EBk/Z57p2Pm2ll3+ObUt4/5nlSZAQfYdBdXrY/E2h9/UTynsUXlSKlGIrHoKdgWIaa+JZyJtKyQ+LUT7HkO6B0MCIiOH9tyaJ8H9928urpNKoykacrgBxM/sYWLKPh1333wSlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 13:23:13 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 13:23:13 +0000
Content-Type: multipart/alternative;
 boundary="------------L40c6FZhrjPg4Dd2nkqfKj2k"
Message-ID: <b6cdc0d9-1e06-4a3b-b4e0-06ad15e4f4cb@amd.com>
Date: Wed, 5 Feb 2025 08:23:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/44] drm/amdgpu/vcn: switch vcn helpers to be instance
 based
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-12-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-12-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ad039f-a9a0-4bfc-604c-08dd45e83dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Unh4bDRRQXpPTFN5djgzdEFDRld3NTZlK2U3QW5kWkU4d0dZY05IakU5dDNE?=
 =?utf-8?B?YU1pbHArdWpQOHVyQzNER3RDSjNkU05wbGtBckdhbFRCTzVDamhrYXlyVldG?=
 =?utf-8?B?MXMzM1FnQ2ppL2lzZEZEcUZVMlJhajF5bEhjVklkcGRhZ0E2eFEwY09yZWQ5?=
 =?utf-8?B?dnRmbTdkNlFWcXNVejlvQUlLSWhxR1dyWVJSRVl3cWJjL29OYTRLMWFFSi9Z?=
 =?utf-8?B?OWg5eUZoSVdxemdFMTNnOGxlcVQrNHJaYUpiNEtpaUxreElJbzFpTjFFUENH?=
 =?utf-8?B?NWdqTVhHNDJLa0QxWkxRZmNtTXY2dGthSC8zaFFPWERLbEhrWmh5aXI1c2ZY?=
 =?utf-8?B?a1FiTG9SUzI2aE1tSUZ4aTB2SGEzQndmOWJVaGQ5V3BiZ3ZrOUJpQUZBenh2?=
 =?utf-8?B?WWZKdWNDK01BV0dudzdJbFkxOE0zN2Jud0o3OXQ5V0Vpaktma01FRHBNaE9Z?=
 =?utf-8?B?bVZWOWcyVXpjTG41VmVtWFZqY1Z3S3pERDBvT3JxS3NnYkdxR3YvK0pvM2Y4?=
 =?utf-8?B?dUFIZkd6R0h5V3hsOXBIUVhxQ2VHVndxKzhZU2pEOXhlYjRLaTV1am8xVkpv?=
 =?utf-8?B?Mkh1eFJ4UnBCdUlzd05TbVVleTNPZUlPZ3RST3g4QW9IYkV0ZmNQK3JRWEx3?=
 =?utf-8?B?SkZqdTFXZHdObkU3TzVKNmpiUGF1S3I4MTQyN29TY2FlUHBNTjNCZ2kwamM1?=
 =?utf-8?B?SytmZEE2bU9IbGlhc010SU56d1pBQ1VxdmM1VmxTbmRQeldXVlIydEdxMjZs?=
 =?utf-8?B?SFY1TmdDcFBkZmV4MWNGVk52SDZFNi85RTJreDhXUzhhcjlyd2xTSXF5d0lt?=
 =?utf-8?B?WlBlV0lGSnN0TitQMUVxWmp5c3p0dXhGVmRDbnpHa05iamZQenNRdjZ5ckFq?=
 =?utf-8?B?MkZJRnBhWmJ1cmxMSzc4Z25tYXJFaThsR05UZTV0dmZJaUx5T1pLd2FTM2g4?=
 =?utf-8?B?YUQzY0Y1MGgvd3dkd3BRUXVCaFdIMURpTWhMd0Z1TUk0YTFKUHVhMWF3TTBN?=
 =?utf-8?B?VnhCSzRGL2VYWE44eTNhakp3eExBTThtTXBCdEhyT1p2RnVmdzcySFJGRUtL?=
 =?utf-8?B?ZFBhYlROc24vemxlVldaMnhkaGU4MktzT1o2YzY2bkFlRWxiR3ZuWFYyQkdY?=
 =?utf-8?B?SDBKYjUxN2p0R3JYMWNjeHVRSkIwSW0yZXdtRU9zZHEzaVRocmdCNmltN2da?=
 =?utf-8?B?MlJjaWFxYW5yZHgrdXY5MkZwNk8xaTVlZlVUMHpYVVZ5SzNWTVZ2ejJaN3BT?=
 =?utf-8?B?TjRKTVFzZ1BiN2g4b0pHdUtHUVhLQmtNbHlxRGN1MzNjcVNHTE9rTDEvLy9x?=
 =?utf-8?B?Y0hHK3FDbW9mZG9sMUw1QjBEWXFQT1lNQUtIQ1hiQTlUakI3N01rOElYZDh4?=
 =?utf-8?B?SVU3RUdlbDk1RDN2QUVoQ2NGbUFmMWFsWVFvWjEwMDE2MEU3SjU3ZW9nbmZF?=
 =?utf-8?B?YllwOEVYTHZWTUs0Z094QWs4UHQrMkhYRUV1OHRJeTZVT2RDei9NRnZOc0Rx?=
 =?utf-8?B?S3EwZGhoL2R0MTZDb0phVzd3bFIrdWxMakVwbnhkR2tIM2RlM0NrOFNDQmly?=
 =?utf-8?B?eEY0UE95azFMU1lCNjdGaTlQWDFBVk96WWVRanFYaDlPYVhWMjZhazRrWVZD?=
 =?utf-8?B?Mng0RE9KVCtwSTJlWGVDMEhOQ25MZE1KZTZXYWpsMXc2ZVhUUnZPWnd0R3Yx?=
 =?utf-8?B?ZzRJU3dIWWt6S3dJaWdEbEtVVHdNQ3pudnN6azJ6WGwwN2JiL2VyYmJhL2c3?=
 =?utf-8?B?WXhjdktIZ1ZpYkN4UlR5Vnc5YlpMblBKdWU4eithWWtlUUx0eUF5VE10dWQ3?=
 =?utf-8?B?QW8rWDFoWEtMNmtJUXJ1aDRBNjhLT25jK2QxY2QrK2hIZXJqS2tpK2cyR1NM?=
 =?utf-8?Q?ih6AhnRDeNayt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC80ZjBIYjVudERjZm8vWVBlVDNjMkpoSUIvMHZsVWtHQlIxWVp4czRRNHI4?=
 =?utf-8?B?dlk1dUNXNmhOdTE1WHdGSFhsSEFCbXlFb3Z4YXM1MFZQVjc5MUpBd2FaUnpq?=
 =?utf-8?B?YnI3WjdyMzM1UVY4b1k3NXRNektoZXRtL0h5RnVaVmw3WWpiOGE1K3Q4MDRV?=
 =?utf-8?B?d3B4VXBCMHFjUS9KOUJzblJXQjlFNldOOEVjZ2RlUWwvd05BamhZR3A3THlJ?=
 =?utf-8?B?U1U4aU1tbjhhdkhlMzcweXF3K3BwWVFBa1h1NmMvMFFHR1RSdXpabEw5c0py?=
 =?utf-8?B?L09SYTZjSmdWTWpHSzg3SmRuOStLYWNLNWxQQ1YzbkpuUzd0ZFhBTCtHL3VU?=
 =?utf-8?B?V05aeTBvZ0VCcnFTK3hKWXN4SzVaTUpPUy9mMFN0YlEvOWQzVENZSjJqL0VW?=
 =?utf-8?B?SlMwNUFOdFp1VmI1d1IrUkF0WER5aWhsdHN3MStxbHIxRmFUbjJ6MnFrSDYw?=
 =?utf-8?B?bWlUemV6Qmw0Q25GMWlJM3VPenh3UVBIcCt3TkprMkg4ZW84aU9jb0NnKzBj?=
 =?utf-8?B?SW5KUkxER3dTbThQYmtGWTRhL3VXWkJqNkRZWUVSOFBqdU5wUnEyai9kVXEz?=
 =?utf-8?B?ZEQ5Mm1rNnpZMWhXcmRsODI3K3FObVpoSThPa05QYUtLVXBjeFlzYTZWbVlm?=
 =?utf-8?B?ZXBudjUreE9Rb2RtdVJmRzJEYmtKZGdNbXhwc0V1TDRCZXZ0dEh5UitiQURj?=
 =?utf-8?B?VUJhY2pndEFmOXUxSStMa3EzWHE3MkplVTRla01OQkJ6VXhJTFN2Z252Y1Bv?=
 =?utf-8?B?bGFsNmRpNDQ5VnNobjJsTk5vakgzZENUNFRRRDVjczlUREZPZlBrWk1sWnln?=
 =?utf-8?B?aTNGSVpuS0JvY1JuS0xHT3Z5U0o2cFVGQ2JSa2Y1Mi9YT3VxTmp4ZGEyamZs?=
 =?utf-8?B?UkFWQkV2QTRlT00zWGJadGlER0JoZmpnS0hOZkZVZHdBY0VZelp3YUxCTitC?=
 =?utf-8?B?eWhhU2c1VTJGNitaenlzdjlRZmJ4bEhiQlVYeER4ZEl0dmZQN2FkS3pqcGFC?=
 =?utf-8?B?T2c1WkFFQWJzMkJtMzJXYll1eTJ5NnU0NHZVYTVQSWVUbDJ3eVZ4VnNlbzVw?=
 =?utf-8?B?b3JDK21aWWs4THFBZFllbVVRb1RnT3BLMXNMYmNCNHlHVmdSTzQweURIUmZn?=
 =?utf-8?B?b0x2bXhGK2tSQlBPQmtMbmJzalh6aGUxVlQvWE5ZT3NaOUFOZ0oxKzZLNjlC?=
 =?utf-8?B?U2NwV2d5bDRScFd1dnFxNE9iMklYdHo5TWxhbzV0SWRsTzZNODlYUlFtdFJq?=
 =?utf-8?B?UWVRUUF3eVdHejZwOEJNYi9nVTYrU3pIQnl3WXdPRHdZVUVlem1oUmNMVVU1?=
 =?utf-8?B?eVNNNUtLeDdCeENWdzl2NGxCbVlBSFFRd2xFYUpKVk40TDFhNUR1dVJSbjVL?=
 =?utf-8?B?d1BaRlpaVEg3RVpqZ1NPL3REREk4VEVLSEVhK1dpSkpUbnVzTU9xRjNZWktx?=
 =?utf-8?B?SjdOU1pXQ2ZZYWhUM0UxYUhqU21GZE9CRTVBaEYvRXBENC9pamMzcDM3bExJ?=
 =?utf-8?B?NmN4aCs1Yk4zK1Q0ZDdOZWQ3eXR6NTU3QWJvV25ZVk5PYklJaEkyTW8xdytK?=
 =?utf-8?B?ck1kYjJSK1dHblhuMWVqeW5JbXMrOFFJYThRODFRdVh3dUpJKzVETnZMc1ND?=
 =?utf-8?B?aXRwV3FzNTZmODZ2R3pMQWZFNzRuTzhib1Rka0NNMWt5a0lXc09QRS85ZTRQ?=
 =?utf-8?B?OXFFODFRZFZOOFZmRnd5bEhDTkdpdWFSY2RWVlFCQ0lMQUQzSjc3VUhUT1Fi?=
 =?utf-8?B?cFlhR0RvTkQ4Y2NrejJBVjFOb1Zha0Q4cWVSZWt3K3ZNUWQvZEZvbGhhbjBZ?=
 =?utf-8?B?TjZ6KzJTNUw1Ykg4dDFwMkQxTWE1eFUvTXUzVDdZbXhSUlE1bzB0Sm81YjN3?=
 =?utf-8?B?YnI5dlM1Yk1ydEFTbUhBbkg1dkgrUTEvendvdlIzWWxVeUxkTEE4cXA3RDRp?=
 =?utf-8?B?M3M3WGVhUkJWOTdWOSs5aUJlby9SVXE0c3hsVlU3cEhzbHBJK3RlczR0akgy?=
 =?utf-8?B?Qzd3SEJHK3Jib04zanZZa1Y1UjZYOEpjZVFndnEzcGRNb3k5ZWp1QVhidmJ3?=
 =?utf-8?B?ZGZrNXo4T2ExaWUzaTYxTTVTTTh5ang1NnlXRURCNlZFdkZIeDlGa25rcmEz?=
 =?utf-8?Q?bRHxfp3Cf06LPLQXO+FB9zCob?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad039f-a9a0-4bfc-604c-08dd45e83dda
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:23:13.2262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKOHkm6/3PUCakJfGRe1N3r6h7MSsEXpouCGQ5R5pKh+KcB98XQtchZ8M4oPImGsj5hHI8j8pNfbImHkGKm2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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

--------------L40c6FZhrjPg4Dd2nkqfKj2k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the instance to the helpers.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 437 ++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  12 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  16 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  16 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  71 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  65 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  69 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  70 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  63 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  67 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  64 ++--
>   11 files changed, 541 insertions(+), 409 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9901b8e17f305..010cc64a950a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -93,192 +93,186 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
>   {
>   	char ucode_prefix[25];
> -	int r, i;
> +	int r;
>   
> +	adev->vcn.inst[i].adev = adev;
> +	adev->vcn.inst[i].inst = i;
>   	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		adev->vcn.inst[i].adev = adev;
> -		adev->vcn.inst[i].inst = i;
> -
> -		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> -						 AMDGPU_UCODE_REQUIRED,
> -						 "amdgpu/%s_%d.bin", ucode_prefix, i);
> -		else
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> -						 AMDGPU_UCODE_REQUIRED,
> -						 "amdgpu/%s.bin", ucode_prefix);
> -		if (r) {
> -			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> -			return r;
> -		}
> +
> +	if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> +		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> +					 AMDGPU_UCODE_REQUIRED,
> +					 "amdgpu/%s_%d.bin", ucode_prefix, i);
> +	else
> +		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> +					 AMDGPU_UCODE_REQUIRED,
> +					 "amdgpu/%s.bin", ucode_prefix);
> +	if (r) {
> +		amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +		return r;
>   	}
>   	return r;
>   }
>   
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
>   {
>   	unsigned long bo_size;
>   	const struct common_firmware_header *hdr;
>   	unsigned char fw_check;
>   	unsigned int fw_shared_size, log_offset;
> -	int i, r;
> +	int r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> -		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> -		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> -		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
> -		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> -		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
> -		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> -			adev->vcn.inst[i].indirect_sram = true;
> -
> -		/*
> -		 * Some Steam Deck's BIOS versions are incompatible with the
> -		 * indirect SRAM mode, leading to amdgpu being unable to get
> -		 * properly probed (and even potentially crashing the kernel).
> -		 * Hence, check for these versions here - notice this is
> -		 * restricted to Vangogh (Deck's APU).
> -		 */
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
> -			const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
> -
> -			if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
> -					 !strncmp("F7A0114", bios_ver, 7))) {
> -				adev->vcn.inst[i].indirect_sram = false;
> -				dev_info(adev->dev,
> -					 "Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
> -			}
> +	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> +	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> +	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> +	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
> +	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
> +	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> +		adev->vcn.inst[i].indirect_sram = true;
> +
> +	/*
> +	 * Some Steam Deck's BIOS versions are incompatible with the
> +	 * indirect SRAM mode, leading to amdgpu being unable to get
> +	 * properly probed (and even potentially crashing the kernel).
> +	 * Hence, check for these versions here - notice this is
> +	 * restricted to Vangogh (Deck's APU).
> +	 */
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
> +		const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
> +
> +		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
> +				 !strncmp("F7A0114", bios_ver, 7))) {
> +			adev->vcn.inst[i].indirect_sram = false;
> +			dev_info(adev->dev,
> +				 "Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
>   		}
> +	}
>   
> -		/* from vcn4 and above, only unified queue is used */
> -		adev->vcn.inst[i].using_unified_queue =
> -			amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
> +	/* from vcn4 and above, only unified queue is used */
> +	adev->vcn.inst[i].using_unified_queue =
> +		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
> +
> +	hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +	adev->vcn.inst[i].fw_version = le32_to_cpu(hdr->ucode_version);
> +	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
> +
> +	/* Bit 20-23, it is encode major and non-zero for new naming convention.
> +	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
> +	 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
> +	 * is zero in old naming convention, this field is always zero so far.
> +	 * These four bits are used to tell which naming convention is present.
> +	 */
> +	fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
> +	if (fw_check) {
> +		unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
> +
> +		fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
> +		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
> +		enc_major = fw_check;
> +		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
> +		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> +		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
> +			 enc_major, enc_minor, dec_ver, vep, fw_rev);
> +	} else {
> +		unsigned int version_major, version_minor, family_id;
>   
> -		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> -		adev->vcn.inst[i].fw_version = le32_to_cpu(hdr->ucode_version);
> -		adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
> -
> -		/* Bit 20-23, it is encode major and non-zero for new naming convention.
> -		 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
> -		 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
> -		 * is zero in old naming convention, this field is always zero so far.
> -		 * These four bits are used to tell which naming convention is present.
> -		 */
> -		fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
> -		if (fw_check) {
> -			unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
> -
> -			fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
> -			enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
> -			enc_major = fw_check;
> -			dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
> -			vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> -			DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
> -				 enc_major, enc_minor, dec_ver, vep, fw_rev);
> -		} else {
> -			unsigned int version_major, version_minor, family_id;
> +		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
> +		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
> +		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> +		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
> +			 version_major, version_minor, family_id);
> +	}
>   
> -			family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
> -			version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
> -			version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> -			DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
> -				 version_major, version_minor, family_id);
> -		}
> +	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> +	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> +		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>   
> -		bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> -		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> -			bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
> +		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
> +		log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
> +	} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
> +		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
> +		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
> +	} else {
> +		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> +		log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
> +	}
>   
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
> -			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
> -			log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
> -		} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
> -			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
> -			log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
> -		} else {
> -			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> -			log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
> -		}
> +	bo_size += fw_shared_size;
> +
> +	if (amdgpu_vcnfw_log)
> +		bo_size += AMDGPU_VCNFW_LOG_SIZE;
> +
> +	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM |
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &adev->vcn.inst[i].vcpu_bo,
> +				    &adev->vcn.inst[i].gpu_addr,
> +				    &adev->vcn.inst[i].cpu_addr);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> +		return r;
> +	}
>   
> -		bo_size += fw_shared_size;
> +	adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
> +		bo_size - fw_shared_size;
> +	adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
> +		bo_size - fw_shared_size;
>   
> -		if (amdgpu_vcnfw_log)
> -			bo_size += AMDGPU_VCNFW_LOG_SIZE;
> +	adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
>   
> -		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> +	if (amdgpu_vcnfw_log) {
> +		adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +		adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +		adev->vcn.inst[i].fw_shared.log_offset = log_offset;
> +	}
> +
> +	if (adev->vcn.inst[i].indirect_sram) {
> +		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
>   					    AMDGPU_GEM_DOMAIN_VRAM |
>   					    AMDGPU_GEM_DOMAIN_GTT,
> -					    &adev->vcn.inst[i].vcpu_bo,
> -					    &adev->vcn.inst[i].gpu_addr,
> -					    &adev->vcn.inst[i].cpu_addr);
> +					    &adev->vcn.inst[i].dpg_sram_bo,
> +					    &adev->vcn.inst[i].dpg_sram_gpu_addr,
> +					    &adev->vcn.inst[i].dpg_sram_cpu_addr);
>   		if (r) {
> -			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> +			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
>   			return r;
>   		}
> -
> -		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
> -				bo_size - fw_shared_size;
> -		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
> -				bo_size - fw_shared_size;
> -
> -		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
> -
> -		if (amdgpu_vcnfw_log) {
> -			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
> -		}
> -
> -		if (adev->vcn.inst[i].indirect_sram) {
> -			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> -					AMDGPU_GEM_DOMAIN_VRAM |
> -					AMDGPU_GEM_DOMAIN_GTT,
> -					&adev->vcn.inst[i].dpg_sram_bo,
> -					&adev->vcn.inst[i].dpg_sram_gpu_addr,
> -					&adev->vcn.inst[i].dpg_sram_cpu_addr);
> -			if (r) {
> -				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
> -				return r;
> -			}
> -		}
>   	}
>   
>   	return 0;
>   }
>   
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>   {
> -	int i, j;
> +	int j;
>   
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -		amdgpu_bo_free_kernel(
> -			&adev->vcn.inst[j].dpg_sram_bo,
> -			&adev->vcn.inst[j].dpg_sram_gpu_addr,
> -			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
> +	amdgpu_bo_free_kernel(
> +		&adev->vcn.inst[i].dpg_sram_bo,
> +		&adev->vcn.inst[i].dpg_sram_gpu_addr,
> +		(void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
>   
> -		kvfree(adev->vcn.inst[j].saved_bo);
> +	kvfree(adev->vcn.inst[i].saved_bo);
>   
> -		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
> -					  &adev->vcn.inst[j].gpu_addr,
> -					  (void **)&adev->vcn.inst[j].cpu_addr);
> +	amdgpu_bo_free_kernel(&adev->vcn.inst[i].vcpu_bo,
> +			      &adev->vcn.inst[i].gpu_addr,
> +			      (void **)&adev->vcn.inst[i].cpu_addr);
>   
> -		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
> +	amdgpu_ring_fini(&adev->vcn.inst[i].ring_dec);
>   
> -		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i)
> -			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
> +	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> +		amdgpu_ring_fini(&adev->vcn.inst[i].ring_enc[j]);
>   
> -		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> -		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
> -		mutex_destroy(&adev->vcn.inst[j].vcn1_jpeg1_workaround);
> -	}
> +	amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
> +	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>   
>   	return 0;
>   }
> @@ -298,91 +292,102 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
>   	return ret;
>   }
>   
> -int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
> +static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu_device *adev, int i)
>   {
>   	unsigned int size;
>   	void *ptr;
> -	int i, idx;
> +	int idx;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->vcn.inst[i].vcpu_bo == NULL)
> -			return 0;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
> +	if (adev->vcn.inst[i].vcpu_bo == NULL)
> +		return 0;
>   
> -		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> -		ptr = adev->vcn.inst[i].cpu_addr;
> +	size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> +	ptr = adev->vcn.inst[i].cpu_addr;
>   
> -		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
> -		if (!adev->vcn.inst[i].saved_bo)
> -			return -ENOMEM;
> +	adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
> +	if (!adev->vcn.inst[i].saved_bo)
> +		return -ENOMEM;
>   
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> -			drm_dev_exit(idx);
> -		}
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> +		drm_dev_exit(idx);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		ret = amdgpu_vcn_save_vcpu_bo_inst(adev, i);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	return 0;
>   }
>   
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
>   {
>   	bool in_ras_intr = amdgpu_ras_intr_triggered();
> -	int i;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
> +
> +	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
>   	/* err_event_athub will corrupt VCPU buffer, so we need to
>   	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
>   	if (in_ras_intr)
>   		return 0;
>   
> -	return amdgpu_vcn_save_vcpu_bo(adev);
> +	return amdgpu_vcn_save_vcpu_bo_inst(adev, i);
>   }
>   
> -int amdgpu_vcn_resume(struct amdgpu_device *adev)
> +int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
>   {
>   	unsigned int size;
>   	void *ptr;
> -	int i, idx;
> +	int idx;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->vcn.inst[i].vcpu_bo == NULL)
> -			return -EINVAL;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
> +	if (adev->vcn.inst[i].vcpu_bo == NULL)
> +		return -EINVAL;
> +
> +	size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> +	ptr = adev->vcn.inst[i].cpu_addr;
>   
> -		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> -		ptr = adev->vcn.inst[i].cpu_addr;
> +	if (adev->vcn.inst[i].saved_bo != NULL) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +			memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> +			drm_dev_exit(idx);
> +		}
> +		kvfree(adev->vcn.inst[i].saved_bo);
> +		adev->vcn.inst[i].saved_bo = NULL;
> +	} else {
> +		const struct common_firmware_header *hdr;
> +		unsigned int offset;
>   
> -		if (adev->vcn.inst[i].saved_bo != NULL) {
> +		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> +			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>   			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> +				memcpy_toio(adev->vcn.inst[i].cpu_addr,
> +					    adev->vcn.inst[i].fw->data + offset,
> +					    le32_to_cpu(hdr->ucode_size_bytes));
>   				drm_dev_exit(idx);
>   			}
> -			kvfree(adev->vcn.inst[i].saved_bo);
> -			adev->vcn.inst[i].saved_bo = NULL;
> -		} else {
> -			const struct common_firmware_header *hdr;
> -			unsigned int offset;
> -
> -			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> -			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> -				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -					memcpy_toio(adev->vcn.inst[i].cpu_addr,
> -						    adev->vcn.inst[i].fw->data + offset,
> -						    le32_to_cpu(hdr->ucode_size_bytes));
> -					drm_dev_exit(idx);
> -				}
> -				size -= le32_to_cpu(hdr->ucode_size_bytes);
> -				ptr += le32_to_cpu(hdr->ucode_size_bytes);
> -			}
> -			memset_io(ptr, 0, size);
> +			size -= le32_to_cpu(hdr->ucode_size_bytes);
> +			ptr += le32_to_cpu(hdr->ucode_size_bytes);
>   		}
> +		memset_io(ptr, 0, size);
>   	}
> +
>   	return 0;
>   }
>   
> @@ -1058,36 +1063,32 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
>   	}
>   }
>   
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i)
>   {
> -	int i;
>   	unsigned int idx;
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		const struct common_firmware_header *hdr;
>   
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		if (adev->vcn.harvest_config & (1 << i))
> +			return;
>   
> -			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> -			/* currently only support 2 FW instances */
> -			if (i >= 2) {
> -				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
> -				break;
> -			}
> -			idx = AMDGPU_UCODE_ID_VCN + i;
> -			adev->firmware.ucode[idx].ucode_id = idx;
> -			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
> -			adev->firmware.fw_size +=
> -				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -
> -			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -			    IP_VERSION(4, 0, 3) ||
> -			    amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -			    IP_VERSION(5, 0, 1))
> -				break;
> +		if ((amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 3) ||
> +		     amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(5, 0, 1))
> +		    && (i > 0))
> +			return;
> +
> +		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +		/* currently only support 2 FW instances */
> +		if (i >= 2) {
> +			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
> +			return;
>   		}
> +		idx = AMDGPU_UCODE_ID_VCN + i;
> +		adev->firmware.ucode[idx].ucode_id = idx;
> +		adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
> +		adev->firmware.fw_size +=
> +			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 3b059f51894b9..5f92cf28cc752 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -503,11 +503,11 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev);
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> -int amdgpu_vcn_resume(struct amdgpu_device *adev);
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>   
> @@ -525,7 +525,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
>   enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
>   
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i);
>   
>   void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
>   void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index c870d9ba64c69..f74767843e85d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -113,7 +113,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   	jpeg_v1_0_early_init(ip_block);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, 0);
>   }
>   
>   /**
> @@ -145,16 +145,16 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, 0);
>   	if (r)
>   		return r;
>   
>   	/* Override the work func */
>   	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
>   
> -	amdgpu_vcn_setup_ucode(adev);
> +	amdgpu_vcn_setup_ucode(adev, 0);
>   
> -	r = amdgpu_vcn_resume(adev);
> +	r = amdgpu_vcn_resume(adev, 0);
>   	if (r)
>   		return r;
>   
> @@ -223,13 +223,13 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	int r;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	r = amdgpu_vcn_suspend(adev);
> +	r = amdgpu_vcn_suspend(adev, 0);
>   	if (r)
>   		return r;
>   
>   	jpeg_v1_0_sw_fini(ip_block);
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, 0);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> @@ -311,7 +311,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev);
> +	r = amdgpu_vcn_suspend(adev, 0);
>   
>   	return r;
>   }
> @@ -327,7 +327,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> +	r = amdgpu_vcn_resume(ip_block->adev, 0);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index b0a957664250c..8ff5a9d67cbd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -118,7 +118,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v2_0_set_enc_ring_funcs(adev);
>   	vcn_v2_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, 0);
>   }
>   
>   /**
> @@ -153,13 +153,13 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, 0);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev);
> +	amdgpu_vcn_setup_ucode(adev, 0);
>   
> -	r = amdgpu_vcn_resume(adev);
> +	r = amdgpu_vcn_resume(adev, 0);
>   	if (r)
>   		return r;
>   
> @@ -254,11 +254,11 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> +	r = amdgpu_vcn_suspend(adev, 0);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, 0);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> @@ -338,7 +338,7 @@ static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	r = amdgpu_vcn_suspend(ip_block->adev, 0);
>   
>   	return r;
>   }
> @@ -354,7 +354,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> +	r = amdgpu_vcn_resume(ip_block->adev, 0);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index a3bac39e4c9db..4f9f3de023ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -121,7 +121,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = 2;
> @@ -139,7 +139,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   			adev->vcn.inst[i].num_enc_rings = 2;
>   		}
>   		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> -					AMDGPU_VCN_HARVEST_VCN1))
> +						 AMDGPU_VCN_HARVEST_VCN1))
>   			/* both instances are harvested, disable the block */
>   			return -ENOENT;
>   	}
> @@ -149,7 +149,13 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v2_5_set_irq_funcs(adev);
>   	vcn_v2_5_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -168,6 +174,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> +		volatile struct amdgpu_fw_shared *fw_shared;
> +
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
>   		/* VCN DEC TRAP */
> @@ -189,23 +197,17 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
>   		if (r)
>   			return r;
> -	}
> -
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev);
> +		r = amdgpu_vcn_sw_init(adev, j);
> +		if (r)
> +			return r;
>   
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> +		amdgpu_vcn_setup_ucode(adev, j);
>   
> -	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> -		volatile struct amdgpu_fw_shared *fw_shared;
> +		r = amdgpu_vcn_resume(adev, j);
> +		if (r)
> +			return r;
>   
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
>   		adev->vcn.inst[j].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> @@ -323,15 +325,18 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_vcn_sw_fini(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -421,15 +426,20 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v2_5_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -441,11 +451,14 @@ static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v2_5_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index fabe4d75a7f6b..724f36467b068 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -127,7 +127,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> @@ -154,7 +154,12 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v3_0_set_enc_ring_funcs(adev);
>   	vcn_v3_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
>   }
>   
>   /**
> @@ -173,16 +178,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	uint32_t *ptr;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> -
>   	/*
>   	 * Note: doorbell assignment is fixed for SRIOV multiple VCN engines
>   	 * Formula:
> @@ -202,6 +197,16 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		adev->vcn.inst[i].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> @@ -333,14 +338,18 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -459,15 +468,20 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v3_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -479,11 +493,14 @@ static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v3_0_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ee87594fafa60..1200815b3eee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -117,7 +117,7 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
> @@ -137,7 +137,13 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v4_0_set_irq_funcs(adev);
>   	vcn_v4_0_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> @@ -180,20 +186,20 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
>   		if (i == 0)
>   			atomic_set(&adev->vcn.inst[i].sched_score, 1);
> @@ -294,16 +300,23 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev);
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -394,15 +407,20 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v4_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -414,11 +432,14 @@ static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v4_0_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 35854e074d142..1407cb4b553b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -114,7 +114,7 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>   static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>   		/* re-use enc ring as unified ring */
> @@ -124,7 +124,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v4_0_3_set_irq_funcs(adev);
>   	vcn_v4_0_3_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> @@ -156,16 +162,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> -
>   	/* VCN DEC TRAP */
>   	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>   		VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
> @@ -173,6 +169,17 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		vcn_inst = GET_INST(VCN, i);
>   
>   		ring = &adev->vcn.inst[i].ring_enc[0];
> @@ -261,16 +268,23 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev);
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -375,15 +389,20 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v4_0_3_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -395,11 +414,14 @@ static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v4_0_3_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 0700a5f96084c..c3a2826a59631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -115,7 +115,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>   		/* re-use enc ring as unified ring */
> @@ -123,7 +123,13 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v4_0_5_set_unified_ring_funcs(adev);
>   	vcn_v4_0_5_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -141,15 +147,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -157,6 +154,16 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		atomic_set(&adev->vcn.inst[i].sched_score, 0);
>   
>   		/* VCN UNIFIED TRAP */
> @@ -252,15 +259,19 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -332,13 +343,18 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v4_0_5_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	return r;
>   }
> @@ -352,11 +368,14 @@ static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v4_0_5_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index eeb3c9875ad50..d3e4d02c12a06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -98,7 +98,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>   		/* re-use enc ring as unified ring */
> @@ -107,7 +107,13 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v5_0_0_set_unified_ring_funcs(adev);
>   	vcn_v5_0_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev)
> @@ -138,22 +144,22 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i, r;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		atomic_set(&adev->vcn.inst[i].sched_score, 0);
>   
>   		/* VCN UNIFIED TRAP */
> @@ -231,16 +237,23 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   		drm_dev_exit(idx);
>   	}
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev);
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -312,13 +325,18 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
>   	r = vcn_v5_0_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(ip_block->adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	return r;
>   }
> @@ -332,11 +350,14 @@ static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v5_0_0_hw_init(ip_block);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index f428d23eb2857..f49fdf2bb6e33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -58,7 +58,7 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>   		/* re-use enc ring as unified ring */
> @@ -67,7 +67,13 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v5_0_1_set_unified_ring_funcs(adev);
>   	vcn_v5_0_1_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		r = amdgpu_vcn_early_init(adev, i);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -83,16 +89,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_ring *ring;
>   	int i, r, vcn_inst;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> -	if (r)
> -		return r;
> -
> -	amdgpu_vcn_setup_ucode(adev);
> -
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> -
>   	/* VCN UNIFIED TRAP */
>   	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>   		VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
> @@ -104,6 +100,16 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		vcn_inst = GET_INST(VCN, i);
>   
> +		r = amdgpu_vcn_sw_init(adev, i);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vcn_setup_ucode(adev, i);
> +
> +		r = amdgpu_vcn_resume(adev, i);
> +		if (r)
> +			return r;
> +
>   		ring = &adev->vcn.inst[i].ring_enc[0];
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 9 * vcn_inst;
> @@ -157,17 +163,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>   		drm_dev_exit(idx);
>   	}
>   
> -	r = amdgpu_vcn_suspend(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_sw_fini(adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -229,13 +241,17 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int r;
> +	int r, i;
>   
>   	r = vcn_v5_0_1_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_suspend(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	return r;
>   }
> @@ -250,11 +266,13 @@ static int vcn_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int r;
> +	int r, i;
>   
> -	r = amdgpu_vcn_resume(adev);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		r = amdgpu_vcn_resume(ip_block->adev, i);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = vcn_v5_0_1_hw_init(ip_block);
>   
--------------L40c6FZhrjPg4Dd2nkqfKj2k
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-12-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the instance to the helpers.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <pre class="moz-quote-pre" wrap=""></pre>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-12-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 437 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  71 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  65 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  69 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  70 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  63 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  67 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  64 ++--
 11 files changed, 541 insertions(+), 409 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9901b8e17f305..010cc64a950a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -93,192 +93,186 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev)
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
 {
 	char ucode_prefix[25];
-	int r, i;
+	int r;
 
+	adev-&gt;vcn.inst[i].adev = adev;
+	adev-&gt;vcn.inst[i].inst = i;
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		adev-&gt;vcn.inst[i].adev = adev;
-		adev-&gt;vcn.inst[i].inst = i;
-
-		if (i == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
-						 AMDGPU_UCODE_REQUIRED,
-						 &quot;amdgpu/%s_%d.bin&quot;, ucode_prefix, i);
-		else
-			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
-						 AMDGPU_UCODE_REQUIRED,
-						 &quot;amdgpu/%s.bin&quot;, ucode_prefix);
-		if (r) {
-			amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
-			return r;
-		}
+
+	if (i == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
+					 AMDGPU_UCODE_REQUIRED,
+					 &quot;amdgpu/%s_%d.bin&quot;, ucode_prefix, i);
+	else
+		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
+					 AMDGPU_UCODE_REQUIRED,
+					 &quot;amdgpu/%s.bin&quot;, ucode_prefix);
+	if (r) {
+		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
+		return r;
 	}
 	return r;
 }
 
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 {
 	unsigned long bo_size;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
-	int i, r;
+	int r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		mutex_init(&amp;adev-&gt;vcn.inst[i].vcn1_jpeg1_workaround);
-		mutex_init(&amp;adev-&gt;vcn.inst[i].vcn_pg_lock);
-		atomic_set(&amp;adev-&gt;vcn.inst[i].total_submission_cnt, 0);
-		INIT_DELAYED_WORK(&amp;adev-&gt;vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
-		atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submission_cnt, 0);
-		if ((adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) &amp;&amp;
-		    (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG))
-			adev-&gt;vcn.inst[i].indirect_sram = true;
-
-		/*
-		 * Some Steam Deck's BIOS versions are incompatible with the
-		 * indirect SRAM mode, leading to amdgpu being unable to get
-		 * properly probed (and even potentially crashing the kernel).
-		 * Hence, check for these versions here - notice this is
-		 * restricted to Vangogh (Deck's APU).
-		 */
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
-			const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
-
-			if (bios_ver &amp;&amp; (!strncmp(&quot;F7A0113&quot;, bios_ver, 7) ||
-					 !strncmp(&quot;F7A0114&quot;, bios_ver, 7))) {
-				adev-&gt;vcn.inst[i].indirect_sram = false;
-				dev_info(adev-&gt;dev,
-					 &quot;Steam Deck quirk: indirect SRAM disabled on BIOS %s\n&quot;, bios_ver);
-			}
+	mutex_init(&amp;adev-&gt;vcn.inst[i].vcn1_jpeg1_workaround);
+	mutex_init(&amp;adev-&gt;vcn.inst[i].vcn_pg_lock);
+	atomic_set(&amp;adev-&gt;vcn.inst[i].total_submission_cnt, 0);
+	INIT_DELAYED_WORK(&amp;adev-&gt;vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
+	atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submission_cnt, 0);
+	if ((adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) &amp;&amp;
+	    (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG))
+		adev-&gt;vcn.inst[i].indirect_sram = true;
+
+	/*
+	 * Some Steam Deck's BIOS versions are incompatible with the
+	 * indirect SRAM mode, leading to amdgpu being unable to get
+	 * properly probed (and even potentially crashing the kernel).
+	 * Hence, check for these versions here - notice this is
+	 * restricted to Vangogh (Deck's APU).
+	 */
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
+		const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
+
+		if (bios_ver &amp;&amp; (!strncmp(&quot;F7A0113&quot;, bios_ver, 7) ||
+				 !strncmp(&quot;F7A0114&quot;, bios_ver, 7))) {
+			adev-&gt;vcn.inst[i].indirect_sram = false;
+			dev_info(adev-&gt;dev,
+				 &quot;Steam Deck quirk: indirect SRAM disabled on BIOS %s\n&quot;, bios_ver);
 		}
+	}
 
-		/* from vcn4 and above, only unified queue is used */
-		adev-&gt;vcn.inst[i].using_unified_queue =
-			amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(4, 0, 0);
+	/* from vcn4 and above, only unified queue is used */
+	adev-&gt;vcn.inst[i].using_unified_queue =
+		amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(4, 0, 0);
+
+	hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
+	adev-&gt;vcn.inst[i].fw_version = le32_to_cpu(hdr-&gt;ucode_version);
+	adev-&gt;vcn.fw_version = le32_to_cpu(hdr-&gt;ucode_version);
+
+	/* Bit 20-23, it is encode major and non-zero for new naming convention.
+	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
+	 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
+	 * is zero in old naming convention, this field is always zero so far.
+	 * These four bits are used to tell which naming convention is present.
+	 */
+	fw_check = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 20) &amp; 0xf;
+	if (fw_check) {
+		unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
+
+		fw_rev = le32_to_cpu(hdr-&gt;ucode_version) &amp; 0xfff;
+		enc_minor = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 12) &amp; 0xff;
+		enc_major = fw_check;
+		dec_ver = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xf;
+		vep = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 28) &amp; 0xf;
+		DRM_INFO(&quot;Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n&quot;,
+			 enc_major, enc_minor, dec_ver, vep, fw_rev);
+	} else {
+		unsigned int version_major, version_minor, family_id;
 
-		hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
-		adev-&gt;vcn.inst[i].fw_version = le32_to_cpu(hdr-&gt;ucode_version);
-		adev-&gt;vcn.fw_version = le32_to_cpu(hdr-&gt;ucode_version);
-
-		/* Bit 20-23, it is encode major and non-zero for new naming convention.
-		 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
-		 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
-		 * is zero in old naming convention, this field is always zero so far.
-		 * These four bits are used to tell which naming convention is present.
-		 */
-		fw_check = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 20) &amp; 0xf;
-		if (fw_check) {
-			unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
-
-			fw_rev = le32_to_cpu(hdr-&gt;ucode_version) &amp; 0xfff;
-			enc_minor = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 12) &amp; 0xff;
-			enc_major = fw_check;
-			dec_ver = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xf;
-			vep = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 28) &amp; 0xf;
-			DRM_INFO(&quot;Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n&quot;,
-				 enc_major, enc_minor, dec_ver, vep, fw_rev);
-		} else {
-			unsigned int version_major, version_minor, family_id;
+		family_id = le32_to_cpu(hdr-&gt;ucode_version) &amp; 0xff;
+		version_major = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xff;
+		version_minor = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 8) &amp; 0xff;
+		DRM_INFO(&quot;Found VCN firmware Version: %u.%u Family ID: %u\n&quot;,
+			 version_major, version_minor, family_id);
+	}
 
-			family_id = le32_to_cpu(hdr-&gt;ucode_version) &amp; 0xff;
-			version_major = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 24) &amp; 0xff;
-			version_minor = (le32_to_cpu(hdr-&gt;ucode_version) &gt;&gt; 8) &amp; 0xff;
-			DRM_INFO(&quot;Found VCN firmware Version: %u.%u Family ID: %u\n&quot;,
-				 version_major, version_minor, family_id);
-		}
+	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
+	if (adev-&gt;firmware.load_type != AMDGPU_FW_LOAD_PSP)
+		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes) + 8);
 
-		bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
-		if (adev-&gt;firmware.load_type != AMDGPU_FW_LOAD_PSP)
-			bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes) + 8);
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(5, 0, 0)) {
+		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
+		log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
+	} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(4, 0, 0)) {
+		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
+		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
+	} else {
+		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+		log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
+	}
 
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(5, 0, 0)) {
-			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
-			log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
-		} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) &gt;= IP_VERSION(4, 0, 0)) {
-			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
-			log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
-		} else {
-			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
-			log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
-		}
+	bo_size += fw_shared_size;
+
+	if (amdgpu_vcnfw_log)
+		bo_size += AMDGPU_VCNFW_LOG_SIZE;
+
+	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &amp;adev-&gt;vcn.inst[i].vcpu_bo,
+				    &amp;adev-&gt;vcn.inst[i].gpu_addr,
+				    &amp;adev-&gt;vcn.inst[i].cpu_addr);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;(%d) failed to allocate vcn bo\n&quot;, r);
+		return r;
+	}
 
-		bo_size += fw_shared_size;
+	adev-&gt;vcn.inst[i].fw_shared.cpu_addr = adev-&gt;vcn.inst[i].cpu_addr +
+		bo_size - fw_shared_size;
+	adev-&gt;vcn.inst[i].fw_shared.gpu_addr = adev-&gt;vcn.inst[i].gpu_addr +
+		bo_size - fw_shared_size;
 
-		if (amdgpu_vcnfw_log)
-			bo_size += AMDGPU_VCNFW_LOG_SIZE;
+	adev-&gt;vcn.inst[i].fw_shared.mem_size = fw_shared_size;
 
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+	if (amdgpu_vcnfw_log) {
+		adev-&gt;vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev-&gt;vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev-&gt;vcn.inst[i].fw_shared.log_offset = log_offset;
+	}
+
+	if (adev-&gt;vcn.inst[i].indirect_sram) {
+		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_VRAM |
 					    AMDGPU_GEM_DOMAIN_GTT,
-					    &amp;adev-&gt;vcn.inst[i].vcpu_bo,
-					    &amp;adev-&gt;vcn.inst[i].gpu_addr,
-					    &amp;adev-&gt;vcn.inst[i].cpu_addr);
+					    &amp;adev-&gt;vcn.inst[i].dpg_sram_bo,
+					    &amp;adev-&gt;vcn.inst[i].dpg_sram_gpu_addr,
+					    &amp;adev-&gt;vcn.inst[i].dpg_sram_cpu_addr);
 		if (r) {
-			dev_err(adev-&gt;dev, &quot;(%d) failed to allocate vcn bo\n&quot;, r);
+			dev_err(adev-&gt;dev, &quot;VCN %d (%d) failed to allocate DPG bo\n&quot;, i, r);
 			return r;
 		}
-
-		adev-&gt;vcn.inst[i].fw_shared.cpu_addr = adev-&gt;vcn.inst[i].cpu_addr +
-				bo_size - fw_shared_size;
-		adev-&gt;vcn.inst[i].fw_shared.gpu_addr = adev-&gt;vcn.inst[i].gpu_addr +
-				bo_size - fw_shared_size;
-
-		adev-&gt;vcn.inst[i].fw_shared.mem_size = fw_shared_size;
-
-		if (amdgpu_vcnfw_log) {
-			adev-&gt;vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev-&gt;vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev-&gt;vcn.inst[i].fw_shared.log_offset = log_offset;
-		}
-
-		if (adev-&gt;vcn.inst[i].indirect_sram) {
-			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM |
-					AMDGPU_GEM_DOMAIN_GTT,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_bo,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_gpu_addr,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_cpu_addr);
-			if (r) {
-				dev_err(adev-&gt;dev, &quot;VCN %d (%d) failed to allocate DPG bo\n&quot;, i, r);
-				return r;
-			}
-		}
 	}
 
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 {
-	int i, j;
+	int j;
 
-	for (j = 0; j &lt; adev-&gt;vcn.num_vcn_inst; ++j) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; j))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-		amdgpu_bo_free_kernel(
-			&amp;adev-&gt;vcn.inst[j].dpg_sram_bo,
-			&amp;adev-&gt;vcn.inst[j].dpg_sram_gpu_addr,
-			(void **)&amp;adev-&gt;vcn.inst[j].dpg_sram_cpu_addr);
+	amdgpu_bo_free_kernel(
+		&amp;adev-&gt;vcn.inst[i].dpg_sram_bo,
+		&amp;adev-&gt;vcn.inst[i].dpg_sram_gpu_addr,
+		(void **)&amp;adev-&gt;vcn.inst[i].dpg_sram_cpu_addr);
 
-		kvfree(adev-&gt;vcn.inst[j].saved_bo);
+	kvfree(adev-&gt;vcn.inst[i].saved_bo);
 
-		amdgpu_bo_free_kernel(&amp;adev-&gt;vcn.inst[j].vcpu_bo,
-					  &amp;adev-&gt;vcn.inst[j].gpu_addr,
-					  (void **)&amp;adev-&gt;vcn.inst[j].cpu_addr);
+	amdgpu_bo_free_kernel(&amp;adev-&gt;vcn.inst[i].vcpu_bo,
+			      &amp;adev-&gt;vcn.inst[i].gpu_addr,
+			      (void **)&amp;adev-&gt;vcn.inst[i].cpu_addr);
 
-		amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[j].ring_dec);
+	amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[i].ring_dec);
 
-		for (i = 0; i &lt; adev-&gt;vcn.inst[j].num_enc_rings; ++i)
-			amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[j].ring_enc[i]);
+	for (j = 0; j &lt; adev-&gt;vcn.inst[i].num_enc_rings; ++j)
+		amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[i].ring_enc[j]);
 
-		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[j].fw);
-		mutex_destroy(&amp;adev-&gt;vcn.inst[j].vcn_pg_lock);
-		mutex_destroy(&amp;adev-&gt;vcn.inst[j].vcn1_jpeg1_workaround);
-	}
+	amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
+	mutex_destroy(&amp;adev-&gt;vcn.inst[i].vcn_pg_lock);
+	mutex_destroy(&amp;adev-&gt;vcn.inst[i].vcn1_jpeg1_workaround);
 
 	return 0;
 }
@@ -298,91 +292,102 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
+static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu_device *adev, int i)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		if (adev-&gt;vcn.inst[i].vcpu_bo == NULL)
-			return 0;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
+	if (adev-&gt;vcn.inst[i].vcpu_bo == NULL)
+		return 0;
 
-		size = amdgpu_bo_size(adev-&gt;vcn.inst[i].vcpu_bo);
-		ptr = adev-&gt;vcn.inst[i].cpu_addr;
+	size = amdgpu_bo_size(adev-&gt;vcn.inst[i].vcpu_bo);
+	ptr = adev-&gt;vcn.inst[i].cpu_addr;
 
-		adev-&gt;vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev-&gt;vcn.inst[i].saved_bo)
-			return -ENOMEM;
+	adev-&gt;vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev-&gt;vcn.inst[i].saved_bo)
+		return -ENOMEM;
 
-		if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-			memcpy_fromio(adev-&gt;vcn.inst[i].saved_bo, ptr, size);
-			drm_dev_exit(idx);
-		}
+	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
+		memcpy_fromio(adev-&gt;vcn.inst[i].saved_bo, ptr, size);
+		drm_dev_exit(idx);
+	}
+
+	return 0;
+}
+
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
+{
+	int ret, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		ret = amdgpu_vcn_save_vcpu_bo_inst(adev, i);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	int i;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
-		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
+
+	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr)
 		return 0;
 
-	return amdgpu_vcn_save_vcpu_bo(adev);
+	return amdgpu_vcn_save_vcpu_bo_inst(adev, i);
 }
 
-int amdgpu_vcn_resume(struct amdgpu_device *adev)
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		if (adev-&gt;vcn.inst[i].vcpu_bo == NULL)
-			return -EINVAL;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
+	if (adev-&gt;vcn.inst[i].vcpu_bo == NULL)
+		return -EINVAL;
+
+	size = amdgpu_bo_size(adev-&gt;vcn.inst[i].vcpu_bo);
+	ptr = adev-&gt;vcn.inst[i].cpu_addr;
 
-		size = amdgpu_bo_size(adev-&gt;vcn.inst[i].vcpu_bo);
-		ptr = adev-&gt;vcn.inst[i].cpu_addr;
+	if (adev-&gt;vcn.inst[i].saved_bo != NULL) {
+		if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
+			memcpy_toio(ptr, adev-&gt;vcn.inst[i].saved_bo, size);
+			drm_dev_exit(idx);
+		}
+		kvfree(adev-&gt;vcn.inst[i].saved_bo);
+		adev-&gt;vcn.inst[i].saved_bo = NULL;
+	} else {
+		const struct common_firmware_header *hdr;
+		unsigned int offset;
 
-		if (adev-&gt;vcn.inst[i].saved_bo != NULL) {
+		hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
+		if (adev-&gt;firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+			offset = le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);
 			if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-				memcpy_toio(ptr, adev-&gt;vcn.inst[i].saved_bo, size);
+				memcpy_toio(adev-&gt;vcn.inst[i].cpu_addr,
+					    adev-&gt;vcn.inst[i].fw-&gt;data + offset,
+					    le32_to_cpu(hdr-&gt;ucode_size_bytes));
 				drm_dev_exit(idx);
 			}
-			kvfree(adev-&gt;vcn.inst[i].saved_bo);
-			adev-&gt;vcn.inst[i].saved_bo = NULL;
-		} else {
-			const struct common_firmware_header *hdr;
-			unsigned int offset;
-
-			hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
-			if (adev-&gt;firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-				offset = le32_to_cpu(hdr-&gt;ucode_array_offset_bytes);
-				if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-					memcpy_toio(adev-&gt;vcn.inst[i].cpu_addr,
-						    adev-&gt;vcn.inst[i].fw-&gt;data + offset,
-						    le32_to_cpu(hdr-&gt;ucode_size_bytes));
-					drm_dev_exit(idx);
-				}
-				size -= le32_to_cpu(hdr-&gt;ucode_size_bytes);
-				ptr += le32_to_cpu(hdr-&gt;ucode_size_bytes);
-			}
-			memset_io(ptr, 0, size);
+			size -= le32_to_cpu(hdr-&gt;ucode_size_bytes);
+			ptr += le32_to_cpu(hdr-&gt;ucode_size_bytes);
 		}
+		memset_io(ptr, 0, size);
 	}
+
 	return 0;
 }
 
@@ -1058,36 +1063,32 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 	}
 }
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i)
 {
-	int i;
 	unsigned int idx;
 
 	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+			return;
 
-			hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
-			/* currently only support 2 FW instances */
-			if (i &gt;= 2) {
-				dev_info(adev-&gt;dev, &quot;More then 2 VCN FW instances!\n&quot;);
-				break;
-			}
-			idx = AMDGPU_UCODE_ID_VCN + i;
-			adev-&gt;firmware.ucode[idx].ucode_id = idx;
-			adev-&gt;firmware.ucode[idx].fw = adev-&gt;vcn.inst[i].fw;
-			adev-&gt;firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(4, 0, 3) ||
-			    amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(5, 0, 1))
-				break;
+		if ((amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 3) ||
+		     amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(5, 0, 1))
+		    &amp;&amp; (i &gt; 0))
+			return;
+
+		hdr = (const struct common_firmware_header *)adev-&gt;vcn.inst[i].fw-&gt;data;
+		/* currently only support 2 FW instances */
+		if (i &gt;= 2) {
+			dev_info(adev-&gt;dev, &quot;More then 2 VCN FW instances!\n&quot;);
+			return;
 		}
+		idx = AMDGPU_UCODE_ID_VCN + i;
+		adev-&gt;firmware.ucode[idx].ucode_id = idx;
+		adev-&gt;firmware.ucode[idx].fw = adev-&gt;vcn.inst[i].fw;
+		adev-&gt;firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 3b059f51894b9..5f92cf28cc752 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -503,11 +503,11 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev);
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
-int amdgpu_vcn_suspend(struct amdgpu_device *adev);
-int amdgpu_vcn_resume(struct amdgpu_device *adev);
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
@@ -525,7 +525,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i);
 
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c870d9ba64c69..f74767843e85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -113,7 +113,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_early_init(ip_block);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, 0);
 }
 
 /**
@@ -145,16 +145,16 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, 0);
 	if (r)
 		return r;
 
 	/* Override the work func */
 	adev-&gt;vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, 0);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, 0);
 	if (r)
 		return r;
 
@@ -223,13 +223,13 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, 0);
 	if (r)
 		return r;
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, 0);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
@@ -311,7 +311,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, 0);
 
 	return r;
 }
@@ -327,7 +327,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
+	r = amdgpu_vcn_resume(ip_block-&gt;adev, 0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b0a957664250c..8ff5a9d67cbd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -118,7 +118,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, 0);
 }
 
 /**
@@ -153,13 +153,13 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, 0);
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, 0);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, 0);
 	if (r)
 		return r;
 
@@ -254,11 +254,11 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, 0);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, 0);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
@@ -338,7 +338,7 @@ static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	r = amdgpu_vcn_suspend(ip_block-&gt;adev, 0);
 
 	return r;
 }
@@ -354,7 +354,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
+	r = amdgpu_vcn_resume(ip_block-&gt;adev, 0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index a3bac39e4c9db..4f9f3de023ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -121,7 +121,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.num_vcn_inst = 2;
@@ -139,7 +139,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 			adev-&gt;vcn.inst[i].num_enc_rings = 2;
 		}
 		if (adev-&gt;vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-					AMDGPU_VCN_HARVEST_VCN1))
+						 AMDGPU_VCN_HARVEST_VCN1))
 			/* both instances are harvested, disable the block */
 			return -ENOENT;
 	}
@@ -149,7 +149,13 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_irq_funcs(adev);
 	vcn_v2_5_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 /**
@@ -168,6 +174,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	for (j = 0; j &lt; adev-&gt;vcn.num_vcn_inst; j++) {
+		volatile struct amdgpu_fw_shared *fw_shared;
+
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; j))
 			continue;
 		/* VCN DEC TRAP */
@@ -189,23 +197,17 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 			VCN_2_6__SRCID_UVD_POISON, &amp;adev-&gt;vcn.inst[j].ras_poison_irq);
 		if (r)
 			return r;
-	}
-
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+		r = amdgpu_vcn_sw_init(adev, j);
+		if (r)
+			return r;
 
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
+		amdgpu_vcn_setup_ucode(adev, j);
 
-	for (j = 0; j &lt; adev-&gt;vcn.num_vcn_inst; j++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+		r = amdgpu_vcn_resume(adev, j);
+		if (r)
+			return r;
 
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; j))
-			continue;
 		adev-&gt;vcn.inst[j].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
 		adev-&gt;vcn.inst[j].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
 		adev-&gt;vcn.inst[j].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
@@ -323,15 +325,18 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
-
-	r = amdgpu_vcn_sw_fini(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -421,15 +426,20 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v2_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
 /**
@@ -441,11 +451,14 @@ static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v2_5_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index fabe4d75a7f6b..724f36467b068 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -127,7 +127,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -154,7 +154,12 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_enc_ring_funcs(adev);
 	vcn_v3_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+	return 0;
 }
 
 /**
@@ -173,16 +178,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
-
 	/*
 	 * Note: doorbell assignment is fixed for SRIOV multiple VCN engines
 	 * Formula:
@@ -202,6 +197,16 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		adev-&gt;vcn.inst[i].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
 		adev-&gt;vcn.inst[i].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
 		adev-&gt;vcn.inst[i].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
@@ -333,14 +338,18 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
-	return r;
+	return 0;
 }
 
 /**
@@ -459,15 +468,20 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
 /**
@@ -479,11 +493,14 @@ static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v3_0_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ee87594fafa60..1200815b3eee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -117,7 +117,7 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.harvest_config = VCN_HARVEST_MMSCH;
@@ -137,7 +137,13 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_irq_funcs(adev);
 	vcn_v4_0_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
@@ -180,20 +186,20 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
 		if (i == 0)
 			atomic_set(&amp;adev-&gt;vcn.inst[i].sched_score, 1);
@@ -294,16 +300,23 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
-	r = amdgpu_vcn_sw_fini(adev);
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -394,15 +407,20 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v4_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
 /**
@@ -414,11 +432,14 @@ static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v4_0_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 35854e074d142..1407cb4b553b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -114,7 +114,7 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
@@ -124,7 +124,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_irq_funcs(adev);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
@@ -156,16 +162,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
-
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
 		VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &amp;adev-&gt;vcn.inst-&gt;irq);
@@ -173,6 +169,17 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		vcn_inst = GET_INST(VCN, i);
 
 		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
@@ -261,16 +268,23 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
-	r = amdgpu_vcn_sw_fini(adev);
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -375,15 +389,20 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v4_0_3_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
 /**
@@ -395,11 +414,14 @@ static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v4_0_3_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0700a5f96084c..c3a2826a59631 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -115,7 +115,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
@@ -123,7 +123,13 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_5_set_unified_ring_funcs(adev);
 	vcn_v4_0_5_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 /**
@@ -141,15 +147,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
 		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
@@ -157,6 +154,16 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		atomic_set(&amp;adev-&gt;vcn.inst[i].sched_score, 0);
 
 		/* VCN UNIFIED TRAP */
@@ -252,15 +259,19 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -332,13 +343,18 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v4_0_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	return r;
 }
@@ -352,11 +368,14 @@ static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v4_0_5_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index eeb3c9875ad50..d3e4d02c12a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -98,7 +98,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
@@ -107,7 +107,13 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_unified_ring_funcs(adev);
 	vcn_v5_0_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev)
@@ -138,22 +144,22 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i, r;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
 		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		atomic_set(&amp;adev-&gt;vcn.inst[i].sched_score, 0);
 
 		/* VCN UNIFIED TRAP */
@@ -231,16 +237,23 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
-	r = amdgpu_vcn_sw_fini(adev);
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -312,13 +325,18 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
 	r = vcn_v5_0_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block-&gt;adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	return r;
 }
@@ -332,11 +350,14 @@ static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int r, i;
 
-	r = amdgpu_vcn_resume(ip_block-&gt;adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v5_0_0_hw_init(ip_block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index f428d23eb2857..f49fdf2bb6e33 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -58,7 +58,7 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int i, r;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
@@ -67,7 +67,13 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_1_set_unified_ring_funcs(adev);
 	vcn_v5_0_1_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 /**
@@ -83,16 +89,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 
-	r = amdgpu_vcn_sw_init(adev);
-	if (r)
-		return r;
-
-	amdgpu_vcn_setup_ucode(adev);
-
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
-
 	/* VCN UNIFIED TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
 		VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &amp;adev-&gt;vcn.inst-&gt;irq);
@@ -104,6 +100,16 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 		vcn_inst = GET_INST(VCN, i);
 
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
 		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
 		ring-&gt;use_doorbell = true;
 		ring-&gt;doorbell_index = (adev-&gt;doorbell_index.vcn.vcn_ring0_1 &lt;&lt; 1) + 9 * vcn_inst;
@@ -157,17 +163,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
 
-	r = amdgpu_vcn_sw_fini(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -229,13 +241,17 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int r;
+	int r, i;
 
 	r = vcn_v5_0_1_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	return r;
 }
@@ -250,11 +266,13 @@ static int vcn_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int r;
+	int r, i;
 
-	r = amdgpu_vcn_resume(adev);
-	if (r)
-		return r;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_resume(ip_block-&gt;adev, i);
+		if (r)
+			return r;
+	}
 
 	r = vcn_v5_0_1_hw_init(ip_block);
 
</pre>
    </blockquote>
  </body>
</html>

--------------L40c6FZhrjPg4Dd2nkqfKj2k--
