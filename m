Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1C6C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 16:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3125113C5C;
	Wed, 24 Apr 2024 16:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k3qQGWOQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327D7113C5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 16:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8liEs5TFiPAjikwQ2SIqUjviQZ45s9QPAH8htRQHYeTgHpLFAGH5nSp/31scYe5dfS6Y1Hb+hYYsLQQllocQUYKJfqoNiDCOHhlz70wawQIs1xZqvbx44zJeFV5MTi/Lq5s+eoKYvibYoa+B3wm7ZCLrHXmSAy6SESHGgV0p4bYiEskI1+KHIOig6d80IBNkK4s1JFpt8S3P5wv8YbEHyYpaNsUw/SOJuhhPqJMwMsNN1TjngNEW88TU4zIXmjSph3brDaHfFRE9AiJrFICkXJtd2CCVj6TZK/RPjhNCbqsklXAv6pMZT8pd0TZhf3VG2CJx/WENHanW13q6ah/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biZr6Ct2z31XyHFPFg7CTjUMzfxtUxjRBp05rhSQ5TA=;
 b=eJDTqMF7pp6D4C4ztVhojx2ZcsYFN6IiwsLGgUpMC9iCWHNTE1VBSYG9ZktEWUCUcF7CqvtOWwt6OIJ+QaiwWg46jrKfOPgCilKJESUceI7OncuiSnGo7dOV8wK5HwiOFwh8A2nf2UyuijZLNCPVJ88hpuikw05bF3IrQfK8nA2Bw0OpOiR2o1GZR6AaVoyDUoKdlFWiXdvERZbumy3nlFzs9PCPkuRRoyABPjTyH2kZEpJgYm6cy9aFphLMo+ZVfy6fsOEEdKZE+cMUX5oMM0Hhc8rYRjvEoAdwKWshNoXYK8WvFWTThtt/mB65/SMrWsxAlPJD6vAdw/Jks5/01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biZr6Ct2z31XyHFPFg7CTjUMzfxtUxjRBp05rhSQ5TA=;
 b=k3qQGWOQYearzwhZlhJ2q8rymosT5Sj7EdvYZNbJUTjGz4Me82q9/fTfJQfsdf3k0zuIXzBo4mehtU/txQAUSpQ7v2NmWvubAB1HchTxR9Fu18WSOchc+po+v5iwALKddLhhBO+Z5mFoPUfkIfE1HlgwI49+YocScMdm/iiUreA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 16:15:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 16:15:54 +0000
Message-ID: <85fa35a9-8fa2-4c1b-8214-5451bcfa60e9@amd.com>
Date: Wed, 24 Apr 2024 12:15:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Best effort contiguous VRAM allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240424152814.9608-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8c88b3-98a2-4f97-32aa-08dc6479d130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXpQMEJ3b3RhcHVZUHl3RHlXb1Eza2x4YnYwWHJXRm1mK1NmK0lTdlhvS2lh?=
 =?utf-8?B?N2w2aDRXSDRDT01jeStNcXFVSEdBQlRuRFhHS3lYTXRUaDFocXVjQjlOcm05?=
 =?utf-8?B?a2c4WmtWb0h3TGFJN1dGRmN5VXlRVkdEdWlvNGdNbGFabUJ0OWsvUlk2ME80?=
 =?utf-8?B?c1BEUHNFUXdraU5nVE5OM3kyRDRNOFFWendXRVcvWGJUbUlSTFM4emZEQmxW?=
 =?utf-8?B?cVBEcCtjUVJvcXlCMW05S1VObSszdENiYlFNcGxJb2ZvbkRsbzdNSW9YQ2Q3?=
 =?utf-8?B?Z2I4REZKR1BzRGE3K2dkVllJSDUxdnBlVWUwdFNHdFNPL0sxRHJpRWh6WWFJ?=
 =?utf-8?B?a0hSazh4WkZGSVFtQ2RyQThJZG5zTFE5K0lHR0cxUGFMRC84MnBNZVNCdUFj?=
 =?utf-8?B?bW9oTit4RFlTYVc0QzNOeUwxNFliT2wxdFN5VXM3WlBiY25PVjFFRFVINE8w?=
 =?utf-8?B?WUFYRVphRU9VU0ZTMWdPWE1ScndlVGgzTEZtVGJteVdhcnN0K2V4ZEJadWcr?=
 =?utf-8?B?ei8vSTltZkhVQkNycm51eWIyZUFQWTc0QjVXTm1XV2huUzhkVnVER1c5czRC?=
 =?utf-8?B?QnRPZko3d0VhQXk1STBUTXpRQkEzWjZTUS83Z3ArUEFXb3JVd2sxVTRHS09X?=
 =?utf-8?B?T08rQktNZEJxbkdQcGxlWFJTa3RsOW11aUZrNFRhNFA4ekYzK3NPa0IyV0FU?=
 =?utf-8?B?VERabXRobDIyTlo5YUlodm9FekVXbTNlSzJXZythV3VVR3JjbWVKVkd5Wm93?=
 =?utf-8?B?emoya3kvbGxLWEd2eThzRkVxaWpEU0lpa3ExT0g4eHlrVTNDVHhpcmVRM2kw?=
 =?utf-8?B?R2p3aU9vUFJkODQ5M0V4eTduN25MYTA3aW9YZDFwT0lBN1N1WnYwZERZS3hq?=
 =?utf-8?B?eGlIR0lLUElCZWZlaXl5YzRBWUxWU1c5ZHpBWklBMkhFSG9Ld3M0bG9qWUs1?=
 =?utf-8?B?NmpERjVkUWUzZ0FCVTZxb3crR3VxZ1dpeGtVUDJPVUM5QVdVaGhxYmd6UE52?=
 =?utf-8?B?eDBxWjhwcU9ya0NURnRSbitVUkJEOVIrK3ZmTTNYd1EvaHk0M2xzN0l4ZTh4?=
 =?utf-8?B?QXpkZzlPT3o5NVJUbHJ4bDBsdHlOZXNSNFpvQTlKNmhMb1hEZUFUTmlCM1A3?=
 =?utf-8?B?ZTFUbGdBOHFxUGRmM2dEMVVFeEF4QjdVazNLdG9uMXkxN2NaN3ZUUlJZc1BL?=
 =?utf-8?B?ekdya2RyTlZPbGhMMGhBNVp6M2JzVEh6K0xOZFNzZlpsWkxWNkNWOVpZMWRE?=
 =?utf-8?B?Mm1YOW9VbEJ2aHdKcHVkZ0M2UU9BZDUzcFN1QUw5UXRsNUNMV0RjZFVnaXZS?=
 =?utf-8?B?TWdIODdKbEdIRjk5UkZZUHF3WFplSHZqYjNodzViWHo5eG9LRmJtMjJHa3lu?=
 =?utf-8?B?aTE4SEJ4NzJlU2ZKNWg2cVlCS3VRVS9WQTNwRks3cnNvbTRBNk5ST2xSS1Ay?=
 =?utf-8?B?anYrRmpqOEFHSzl5WFZTeVAxTWhXL0xJMExmaDMzOS9nRlFZVzdnczg1TXNN?=
 =?utf-8?B?ZTd0aEt2L0hET0tzc2RWUE9HN1JHaktUTnRERXl2NjBCUFN6ZDVXQlFnT3Aw?=
 =?utf-8?B?ZWxBeUJMQWtTTzlNeDBGenAyQm9pMjBiSmhYVVFVTWVmSkhxeVJ4V2pIbkdl?=
 =?utf-8?B?NWl4OVVSd3ErMjRrZytxZHBhQjAxOUMrZ0FsUG1maXFNbDBocE0xTGhha1cx?=
 =?utf-8?B?aHExUlloZlc4cWZneUgxZHltVUJFcU5QWUlNdUNPOXNydEl6WGx2dVJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlIdlNybk4vY0FjVkxNV25xTElWRWJCKzFxMEVWbnN5RnZXcWR5bjdydTBt?=
 =?utf-8?B?Vzh6MUJXelpESk44SXVEck84V1g0M2tBQWpZeHJIUU5VMEtmRC9DZi9YNmNq?=
 =?utf-8?B?WGFxNUdVSlV0WmphYzJPKzlsR0N0VFpmcTFteUptdmtQNDBqMXVZWDJHNVdZ?=
 =?utf-8?B?YzdGU29xQzhYNjlSak5XTTVONlJEK0xsTzJPTWJ4OVJhY1JCMFJoSXhBSGNF?=
 =?utf-8?B?NVYzV0I2dmJ1aDlaMVJlNmlqUzhYUTV6UjJodUM0d20vcDhzdEQvcUp6OGd6?=
 =?utf-8?B?cXVHZ045Z0wrWVpIcXJ0ckR4aGo4Nk5WYlhzaWVSM3FrRm54ZTNneDV5Q2d0?=
 =?utf-8?B?bE9Ed0hxZ2ZkYmxpdHY1K1NyTlZBY3lVQ0FLbysrcmE2OTE0N0V4U2JodlJE?=
 =?utf-8?B?S3VHSFdmM2JRRnB3eFhGOTRUSkJFWTVCeWYzUVprU2FWQ2ZLbWJFUit4TkMz?=
 =?utf-8?B?dDJsSWNmd052N3pkNEowYUxpZGlIMjBRdzhCbllEQ1ZmVGZxTFVwOXQ4djJ0?=
 =?utf-8?B?N2VtRGRmR1hudDFXMDVRTlFmK29oNDd3YWZqamdnNkhXQVNSLzFubkRZNThG?=
 =?utf-8?B?cGEyWlRwV3YzbFRnd1g0dEpWWG5vcWYwazNNUjltNVZ0TktYMmkwWitZL1V2?=
 =?utf-8?B?eFZXN3dSWFkrQ2RLYVBQUFB1azNpbk9pbThvM0w0WG1CS09Ob3lWMGswc1dK?=
 =?utf-8?B?ckxtTWg5QmtKNFdBTkszWm1HcUJBZHQ5ZDZrT1ZKeThVYTRIT1ZkWHhDTXJN?=
 =?utf-8?B?aGM0SzUvdjNjU2RjR1A0OUlHcnp6L0FCRUhCT1NlRUN6a1FqajdiOHo4U28r?=
 =?utf-8?B?TDA3dFBvTmtoemcrOWNHYVEyRzB1ZUEvTlJqV3h5TllER3dhTk90bXZMZzFp?=
 =?utf-8?B?QjZLV3NvUDlUZk9YMXloSHZOaWt0MWFTcGZ1OXh5U3N5bUFMNkFBakJ0T0Jv?=
 =?utf-8?B?V1loOG9GSzQ5S1YwVmlhTXRnclBHd2tmbDZIQUt3SUlmb24wWWNKbEs2bXA2?=
 =?utf-8?B?NWpFVjg0eDZBVW9FR0c3T3N1TXY0QnN2THloRmw2MnR0MXF5NWFHK2RmQkVJ?=
 =?utf-8?B?c0NaNHRzbWs2dVZUSExzaVlRYXA0VUJIODI1ZXJVaGtISjArMzZCN2xScVow?=
 =?utf-8?B?Q2FGaWJEZEJ4Ri9hU0JXVEFQemFaUkRIS1NBaVJYaktKKzdJMWt1Nit5Vmdn?=
 =?utf-8?B?dWQxQVZ1cHM0dHN3OVcwM0xsSHhDVHZ1QllQT2g0Tk95eHZTNXZIZm1BaUsz?=
 =?utf-8?B?eWJhanV4ZThxT2JUbFRNRWE5eU5LT0RTUFE3ckt4V1RkME9IQmhvbGt2UXNN?=
 =?utf-8?B?WE5ySkJ6S0NScGlGMVNXeWtTMUttckNIaGNUNFl0ZGJieC9IaFVycUpGU3ZP?=
 =?utf-8?B?N0d2ZnB5czBZODhiUmRZbUpmUWk4cEJOYnN1UjZQWjJVNjFDd1pzUVhuRldD?=
 =?utf-8?B?NnZwTy9uMXRhUVJ1YW9oVFV3ZGxHdGsrUjY2d3A1RkU1N2FUMjNBN0N0NVdS?=
 =?utf-8?B?eDhpY1JuU1JIem9KN3RkcU9qUDNSdWw1bkpRcDNsUWh4dFpiK2NvK0FSUjdC?=
 =?utf-8?B?N1o3WU9uRjBYY2lyRmJaNjV4VDQzVkl6V1lDQUVCL2JZcXdNMGlPOCt5NU9j?=
 =?utf-8?B?N1oyLzFKUGxuSDVOSXR2cTVBRzdRZEgxaFo1NzhRMUtGZFl3RVRVTzd2VTNL?=
 =?utf-8?B?NkwvaHp2QkkwUWxVcEdqZW5pamhtcVppb09hdnpneDBHYWZSUmVqSUYrSWU5?=
 =?utf-8?B?L3N1NS8xMy82Q09nN3lrcTJzOStjUEIyOC9QM2xFUWVTNXpXUm9Ma3pObEY1?=
 =?utf-8?B?aFcvR3IxL21EYUc4dTVkdTBETGRXTDhnUkgwQnIvbTlxZDZSNEJpSkZ3T0hk?=
 =?utf-8?B?WFpUWmxkcGdCRVRuYXozMUFUNzdDajdlZkErYkpCTnU0Z0RGcld3dkkrajhN?=
 =?utf-8?B?cGdiOWd2NWNGelkrTHRXVUpycWlNbURBWG52WTlJMzY4OHBvZ2haK0hjcm52?=
 =?utf-8?B?LzUzb2lQaG1idzlJRFNZU3RQZmlZb093WTZxQWdzdW85eitJR3p2cG5td0U1?=
 =?utf-8?B?K2ZTcGErb0xGeDArbGN0MTh1SmNkbkhhNndydEpOQno0TzhYcmQzTnJvVFdO?=
 =?utf-8?Q?lBHA0fheqSbKWLF3qjT2CdL6d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8c88b3-98a2-4f97-32aa-08dc6479d130
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 16:15:54.4421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbsunous9gRvis8i4ytP9/uImmQOUeIoffjog5pBeeWG21QAGZF2AMmXc+PJEqtzYhhSxgi7CXsUGgdyvZqHGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

On 2024-04-24 11:27, Philip Yang wrote:
> This patch series implement new KFD memory alloc flag for best effort contiguous
> VRAM allocation, to support peer direct access RDMA device with limited scatter-gather
> dma capability.
>
> v2: rebase on patch ("drm/amdgpu: Modify the contiguous flags behaviour")
>      to avoid adding the new GEM flag
>
> v3: add patch 2 to handle sg segment size limit (Christian)
>
> v4: remove the buddy block size limit from vram mgr because sg table creation already
>      remove the limit, and resource uses u64 to handle block start, size (Christian)
>
> v5: remove patch 7 which is not for upstream, add AMDGPU prefix to the macro name.
>
> v6: use shorter flag name, use interruptible wait ctx, drop patch 5/6 (Felix)
>
> Philip Yang (5):
>    drm/amdgpu: Support contiguous VRAM allocation
>    drm/amdgpu: Handle sg size limit for contiguous allocation
>    drm/amdgpu: Evict BOs from same process for contiguous allocation
>    drm/amdkfd: Evict BO itself for contiguous allocation
>    drm/amdkfd: Bump kfd version for contiguous VRAM allocation
>
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 12 +++++-----
>   include/uapi/linux/kfd_ioctl.h                |  4 +++-
>   4 files changed, 33 insertions(+), 9 deletions(-)
>
