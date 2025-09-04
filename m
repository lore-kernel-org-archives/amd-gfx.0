Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB302CA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 19:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD0A10E277;
	Thu,  4 Sep 2025 19:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DoyFlzqt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E7210E277
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 19:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDNzfz/LHDZZerKMsQF2NOm3ARHQ2ApUL//CHNCDMfJAhzNS1/ShvK5JqRChQ295sLp/mhkyKrVL2O7alLH2cO9R6qJ3hv0DDal510j8/+HDoClivlhdzbmxO2h36jaeqxvFmwVr6V/eGYttAaFz2bDJMPMCMMmNauYsaOwp1aOvH6AnrKtCapesk3/gEZjtxlTEa1I1xsi3hUHtsi3rAjhZ4QmAVvHR+417HgLQ1pVHrKAd8X53DMvwKn/7vGp/9mBI3QUOZUl8wzkIUIwsNjgZZ0bfyrMSu6pYVRpuvSKjOZn52RvbmcZ7iHCWAPtZYsUsqPsBSBVxYj5midpAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+TTTAdq2jN9MkOYZGK9zkBJbGAkZ2KExDPbBVuHuRs=;
 b=oQv9h7d3ocewIeWKgWpQkO0Qqft/r984rGxCn8Ejud5AYtl2U8SGWTKmOMSS1ndQ7cHy1eHv8FhS+/t8ohuvpNRgf6woMtb7nRXctsuQX66+Bczeyi7MMM5kVZoxzlZddgVFuObOlATNGHW8n8s0IKthUlfWEK8u8reEdjbUvFwZ+9gmOawiqsaztSENDOnV3Tt1mbveENbQFrXM9NrQDJWrtWs6YfN9lcT8CDb/rflGWjeFkJ9MwWrZlxxkXX15XMshNLHgm9RKO2CPi9+AZ98hR75k6TVbkr9w2QKMZn8f9Igp6Nz6wIXSlcsTvHrUagaTsJJ8j7ISF2o0yVRvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+TTTAdq2jN9MkOYZGK9zkBJbGAkZ2KExDPbBVuHuRs=;
 b=DoyFlzqtfSWKU5i/JQaqKGOrSDAUfr/9Bt0hUsa4NtSxZ9kdNVjIqkY59ypWVPAX6iI+zfrniIFzLHlRJQCegkivfaDRBXGqXCqIJD16NvGxW17OWpnAQ5Dqs25ZlQPoD7wd7bHfV8uo0yuvLksmVnQeI9fHa8kAYbOjs5XfRGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 19:42:02 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 19:42:02 +0000
Message-ID: <e22f89ea-f0f8-40fc-b22d-fe547715cfb4@amd.com>
Date: Thu, 4 Sep 2025 15:41:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David.Wu3@amd.com, christian.koenig@amd.com
References: <20250904144546.59539-1-alexander.deucher@amd.com>
 <20250904144546.59539-2-alexander.deucher@amd.com>
 <4ec67fdc-af10-46fb-aca3-b5933b306f54@amd.com>
 <CADnq5_NCJfv=+e29b=cCaPVdJOo_9WEXcqtZh7PGkwhtnkKUSg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_NCJfv=+e29b=cCaPVdJOo_9WEXcqtZh7PGkwhtnkKUSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a80d3db-9583-4a90-b9c7-08ddebeb1e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDVVUkVDUjhUR2xIYTlYZURzb3lseGo3WXhHcXFwK2VBaVFETFNpVDE2Q1VL?=
 =?utf-8?B?ZG00Y2FqZ1dzbzYvRms3S01EMEwyUWhKd055SWw3MVAzT25lZEhGbkg2bTFK?=
 =?utf-8?B?enZzTlN0alh1VVF6bllPR1gyTGNWcmdWNyt2cTUrUmhVV3VScFIzM1NONmND?=
 =?utf-8?B?N0pyMzRPcGJpY1BWWDVSSHpiMTNQbVZEYnQ0S3dvdThPSm5RQWZaR1N6cnQ2?=
 =?utf-8?B?MTdJNlpEdW91aVNISjNvQ2VvZ0Z5OWNHTDJ0cFpBbVFJaFh2Z3JKMWw3T1Rm?=
 =?utf-8?B?ZDZoRmlHZThyUnlWak1vWExoMWl2NDdSZFgvU0ZOUTNlbXNYOFNoUFRHUmFR?=
 =?utf-8?B?b2hYVmVFWjhMWXRBYkI0T3IzYkhXa2FhMFM2WWhKSUMxRlg0NzFJdTRVRDJx?=
 =?utf-8?B?amtrbTFSdXgwR2dnVU44eERYRXBqUHBoUWsvVkE3TDlKZHQ0Zy9CRFNSbTVP?=
 =?utf-8?B?ZHNQYThxQ0xWN0tidlZzM2ZwZFJoR2hDbnRzUVgwQlJ3bDg2OXhZM1ExemY0?=
 =?utf-8?B?QkU4QlprSDl4ZW53YWJmUTZ4TXBwaStnUmFuM2FoNXUzeWtnRHR1MlhtM0lq?=
 =?utf-8?B?RW1TRVdib04vSU9BNlB6a1FhNG8wVGcycHJ0eWdOYTNaczFMWXc5T1RCbHI5?=
 =?utf-8?B?OXJ0aU0yeHpGSXpNRW85SEgzRW9KamxreFhDTWtZWUJzTE9wVmRCUTUvSjA1?=
 =?utf-8?B?Rk05clRsNGR2aFlsdi9WKy9wam1GZitGY0dqT3lva0RnQXUxdjRPVUVwTjhz?=
 =?utf-8?B?YlFFS3p0UG1tVEd2bklvQzRZVkVpeGp4RE1yWDU0cHZEV1J0WHE0V0V4REM1?=
 =?utf-8?B?ZTlGcWRKVjRGakFvTjBjZVQ3NU1mUU1Cbi9zd3paVS9yVXQvQ3ZpRmxDcitG?=
 =?utf-8?B?MmNYRWJONmtNTWZwOUUvQ1V5M3I4RDNHNFYxUGtnaUt5cHpnc0JIUFVpV0Fo?=
 =?utf-8?B?OVQ1S25yQkRLSHNwdW5EOWpzZjkxUDJDZ3pYRmZjSVpEdDRmWUNBa0RudUpu?=
 =?utf-8?B?cEpyZVowdzExanMyTmJDQzR4U3NXWVZaSS9rcnpKcFBoMUZhQTJLUHZBNjg2?=
 =?utf-8?B?dUtHZk1nbDFaUTA4M0Q2c1ZoTHdSVEllMjZGQTlKK0dJdmtxQnRFV1lUdVI1?=
 =?utf-8?B?dGVvaUNoUi94RnFoMTMxWmtrSmxlZ1NsMlNjMk5GYWVLOC9ENTJlQS9aSDNm?=
 =?utf-8?B?Y0Y4bFdyM01CdC9uYWx5L08rQXVEWE15NkVWMVNrdWluMU9qRzdZSlM5aHpL?=
 =?utf-8?B?UVh0cm9IU3BKc2V2Nk9Jc1IxQUNmRzdnUjBJaUo4L0M1dnQ4SDlTZFNhdG5K?=
 =?utf-8?B?K1VyZmJKbnNKU1poSTIwVG9Vd1BNY25sRzBlcHZ1WGxZREUyVEpUeEZDYlZS?=
 =?utf-8?B?WG94TUhEcDljV1Z1anUvaHhGc0M4V0xmNS9Mbk1nSm03ZkUwcWNpd3FNZStx?=
 =?utf-8?B?NXZyRitZRmNiTUZId1pJeEFtQVpsR01YZ2ltWTRMZXBCb2x1emtabk9JYXA2?=
 =?utf-8?B?LzZPVnU1b2hUV1lSd1k3eGV4TE9nYnNiakhNZW5KMlhNVVJrVFB6bXBtK2RE?=
 =?utf-8?B?V1hLVXcyWDJaRC8va0tZTXgzUksvV3NFMjBrbnFXdVkybHBYeDc3WGVwTHIy?=
 =?utf-8?B?eG1MVElNTGJVQjFnWmVGbE9lR0YzK3hrS21RNzB4UFpRaHVuWTNodG5kTXdS?=
 =?utf-8?B?UEI1RGZiOXNNdHZLaG5JT1ZzUytwb2IvWnNjaDF5K0xXR1ljc3BSeDFLdDN0?=
 =?utf-8?B?c1E3R2JCMVhBSG1NOUNkbi9wTEswQ2NudEozdWd6Y1NaRitYL2kvaHNyRnVn?=
 =?utf-8?B?eEJYR3JGWThLdzYydUk3RnlZR3RrLzlTNm04Z3YxaTlGWm1ha0doMllDK2xa?=
 =?utf-8?B?aVgwcVhIVE9Lb1FBRTJxTm9DR3RRVkJsZGZyM1Q4d04ydCtmWGp3Rkg3NGE4?=
 =?utf-8?Q?gY1IGh5x5sE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB1Tkp5ait5VXZKWTFUY05XYTgvSTFEUStKWGsxMkFIWVZvMWRCbHAreUtC?=
 =?utf-8?B?YnU2d1pyWnpMWWZ3eUpKckdaL2M5U24vZTg2L3NuMytKanh4VC9HT2dMMTB4?=
 =?utf-8?B?MVNWYnAvUUhwYjRyeURqSmR4V09WVlh2YzR5MFVXK1JobzFCTm5zMjcySFJv?=
 =?utf-8?B?aXhlY0g0NnNyZWpQWmNSUGVLeW5VcUtPYkpVbmhJUEE1MElBSWd3RWMzTno3?=
 =?utf-8?B?eWNEcng2VCtvR1lNeVpBdUV0bzkxdVh4L3FQM2dYUGhCV1ZrSXErR1gyVVcr?=
 =?utf-8?B?cU5vWVpqWTUrRzF3WDZrbEJVTm5RTHdSdXp0R2UvSEVBZSthMHo1SlgwSzhz?=
 =?utf-8?B?UGx5MW1TTDlKZ29kOUdRTy9IaDFyY1pjaVhrUlFEbzQ2RWVxbXJRc2hoMDV1?=
 =?utf-8?B?c2d5VVdQSjEwZE8vRnVZejg1UWJ3ekhhalRQL3RwVENNOXNlMEN4SGw2S3dt?=
 =?utf-8?B?ZWpXMEx1eEFRMVVJeTd1SEpMQ3VQdXRSWUhJZlV1V2huYjN3dmJabzUxUGdx?=
 =?utf-8?B?SC8rMGR5b1AvOFIxVVFzWHhhMGlIaE9sY2tMbEtCRFZLeVNTNGdTRU1OM3Jt?=
 =?utf-8?B?S3NzUDRCVEpjd2daaXJtNWkvNTB2K002dDBaUGp0UUt2ekgwSm10cTVjTGVo?=
 =?utf-8?B?U1RhMmwrU3hlcGc2NmtqQlBQTUNMMXV0TFBZTjJBeEVSS1hOWDdtY0hKekdZ?=
 =?utf-8?B?QkMvVm80RVZJSFpkbmRCOGRFa0dWTklFR1FFWGpmUFJkTDNhSDlEa253R21O?=
 =?utf-8?B?cEw3S2c0bGt3NHdkS0h3blRSelgyK1VBK2VlWnlucEM1Tmg4eXRpNHdFUmpu?=
 =?utf-8?B?N2JLMGFDSEk0MTBSVXlVd0RuZmkwaXpXT1h2MXBEV1dMMVB4U3B2MWlKK1Vj?=
 =?utf-8?B?bGpuV2kzOGpoTjF4Zy9BYTZUckdmZ1kwM1VuQzdTczJhajBkQ3V4SUFDQ01B?=
 =?utf-8?B?YUdGTko1elBPRzNWYU9VVEF4R0lhbnBFSVhpcm5BTFBBSy9MRlYvQXl3ck5O?=
 =?utf-8?B?Nmt4VWdMd1orVFNlL0lEVzEzeG1IL3hnVUJTMHY4ZTd4THNJVXdBQnlIek9y?=
 =?utf-8?B?NFJ1Y3VvZFUzdVFMendkTEtocVdXdWgwa2FOVEUxaUkwbXcxSE9RdXFHK0ZN?=
 =?utf-8?B?QjFVRWVKcnZya25MWm5MYVVjU0NlOVlmb2N0ajlTdTVSSlJoTURDNjZJMEVn?=
 =?utf-8?B?RStObUJ0RTZLSDhQakVPWUhXTDBZZUF3TlB6UWR4Z2ZhcnJoczBuUTVPdG93?=
 =?utf-8?B?SVhXdmZibnI1NnR0UWFkYUFSY0VuOVU4RTlXdkFkUEVta2JqSjYwa29MT25O?=
 =?utf-8?B?WWVUV1JVdnY0cUpUSlVYSGNyVW5mOHpHRzNwaEl1ZHZabG9uVUdnOXZPS3hu?=
 =?utf-8?B?R2JxOHBBMDVtTVh6Z1hXTks2NVhYN2YwczM3Rk9kWFhrYmY2c1gvVmlVZklQ?=
 =?utf-8?B?czV1dXhLNmwzUHkxUFpJbW4zak55bS9lS3NqUzQyazFSZ1ViV2lrb05PbDJ2?=
 =?utf-8?B?dURFQThjTlR2bExuOHl0OWFWUVZqVG5vWWxoQ3pqeUFyLzB2WXYxQVkyNVM1?=
 =?utf-8?B?b2dScWptNXFTY09aYS9QQW9tT3VXaVNhamR5MEw3M2lPUlVTRmQ4TzRoaDJp?=
 =?utf-8?B?TWxXaU5QQ25JK3hNdzlWTXRxbk9PeGVQM1R6VGw2dUNHcTdXelZqemtWeE54?=
 =?utf-8?B?bndlUDQxYmZUWkVzVGtPdEpBM2pISi9NTlFrMFYvN3czYVdSdkphM2RqYmFv?=
 =?utf-8?B?T2w3SDdwaGVIamZPM2hORlBvcjZZOUtRZ1ltSmZkSTlFV2dFR2lWemJqK292?=
 =?utf-8?B?cjFOZGt6RGFoK3B5dUJLMWhaTUdQMXhpN2k1ajZMclg5bnU4ZkZ1SnhKZStY?=
 =?utf-8?B?VlBvZkNLeXJGL0tLTWtPWE9qVVJPVFdQZkpHc1J4YXpCb2U1K1N2TUpqL0pI?=
 =?utf-8?B?ZzBYVnNIVmE5bHBBeTUzMS9Pc1NPbXFvT1MxY2lQNUpCVUVyNW5QZ3psV2Na?=
 =?utf-8?B?TlpwNmRiTzVOV0ZIbklUY0MvL3A1aWtWRUxWYjAzVzhYQThmbHRiV2o1bFVJ?=
 =?utf-8?B?SUVTWGdBeTZoTjJvSzdXWXR5WmJRNC9HSU8xencvV1VlaEt2L3pYSU1RaGU4?=
 =?utf-8?Q?ujvwgAilhnNAX7lp3A740vWz4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a80d3db-9583-4a90-b9c7-08ddebeb1e86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:42:02.1773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6RVgBV5S0ZfwBzJP+MqvQo4xdLNJDDtrTGx22lvp/d4MgvTEgaUZKseo7Vk7D9U6hCD89Qf8wQMDZWP8VWhmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

On 2025-09-04 13:46, Alex Deucher wrote:
> On Thu, Sep 4, 2025 at 1:34 PM David Wu <davidwu2@amd.com> wrote:
>> On 2025-09-04 10:45, Alex Deucher wrote:
>>
>>> Decouple the amdgpu fence from the amdgpu_job structure.
>>> This lets us clean up the separate fence ops for the embedded
>>> fence and other fences.  This also allows us to allocate the
>>> vm fence up front when we allocate the job.
>>>
>>> v2: Additional cleanup suggested by Christian
>>> v3: Additional cleanups suggested by Christian
>>> v4: Additional cleanups suggested by David and
>>>       vm fence fix
>>>
>>> Cc: David.Wu3@amd.com
>>> Cc: christian.koenig@amd.com
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>>>    8 files changed, 63 insertions(+), 167 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 0e6e2e2acf5b5..7119cf658de8d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>>>                        continue;
>>>                }
>>>                job = to_amdgpu_job(s_job);
>>> -             if (preempted && (&job->hw_fence.base) == fence)
>>> +             if (preempted && (&job->hw_fence->base) == fence)
>>>                        /* mark the job as preempted */
>>>                        job->preemption_status |= AMDGPU_IB_PREEMPTED;
>>>        }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index b9e2f0293d617..79af75032d0e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>                if (!amdgpu_ring_sched_ready(ring))
>>>                        continue;
>>>
>>> -             /* Clear job fence from fence drv to avoid force_completion
>>> -              * leave NULL and vm flush fence in fence drv
>>> -              */
>>> -             amdgpu_fence_driver_clear_job_fences(ring);
>>> -
>>>                /* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>>>                amdgpu_fence_driver_force_completion(ring);
>>>        }
>>> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>         *
>>>         * job->base holds a reference to parent fence
>>>         */
>>> -     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>>> +     if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>>>                job_signaled = true;
>>>                dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>>>                goto skip_hw_reset;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 1a2710f453551..85cefbe40aef8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -45,16 +45,11 @@
>>>     * Cast helper
>>>     */
>>>    static const struct dma_fence_ops amdgpu_fence_ops;
>>> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>>>    static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>>>    {
>>>        struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>>>
>>> -     if (__f->base.ops == &amdgpu_fence_ops ||
>>> -         __f->base.ops == &amdgpu_job_fence_ops)
>>> -             return __f;
>>> -
>>> -     return NULL;
>>> +     return __f;
>>>    }
>>>
>>>    /**
>>> @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>>>     * amdgpu_fence_emit - emit a fence on the requested ring
>>>     *
>>>     * @ring: ring the fence is associated with
>>> - * @f: resulting fence object
>>>     * @af: amdgpu fence input
>>>     * @flags: flags to pass into the subordinate .emit_fence() call
>>>     *
>>>     * Emits a fence command on the requested ring (all asics).
>>>     * Returns 0 on success, -ENOMEM on failure.
>>>     */
>>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>> -                   struct amdgpu_fence *af, unsigned int flags)
>>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>>> +                   unsigned int flags)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct dma_fence *fence;
>>> -     struct amdgpu_fence *am_fence;
>>>        struct dma_fence __rcu **ptr;
>>>        uint32_t seq;
>>>        int r;
>>>
>>> -     if (!af) {
>>> -             /* create a separate hw fence */
>>> -             am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>>> -             if (!am_fence)
>>> -                     return -ENOMEM;
>>> -     } else {
>>> -             am_fence = af;
>>> -     }
>>> -     fence = &am_fence->base;
>>> -     am_fence->ring = ring;
>>> +     fence = &af->base;
>>> +     af->ring = ring;
>>>
>>>        seq = ++ring->fence_drv.sync_seq;
>>> -     am_fence->seq = seq;
>>> -     if (af) {
>>> -             dma_fence_init(fence, &amdgpu_job_fence_ops,
>>> -                            &ring->fence_drv.lock,
>>> -                            adev->fence_context + ring->idx, seq);
>>> -             /* Against remove in amdgpu_job_{free, free_cb} */
>>> -             dma_fence_get(fence);
>>> -     } else {
>>> -             dma_fence_init(fence, &amdgpu_fence_ops,
>>> -                            &ring->fence_drv.lock,
>>> -                            adev->fence_context + ring->idx, seq);
>>> -     }
>>> +     dma_fence_init(fence, &amdgpu_fence_ops,
>>> +                    &ring->fence_drv.lock,
>>> +                    adev->fence_context + ring->idx, seq);
>>>
>>>        amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>>                               seq, flags | AMDGPU_FENCE_FLAG_INT);
>>> -     amdgpu_fence_save_wptr(fence);
>>> +     amdgpu_fence_save_wptr(af);
>>>        pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>>>        ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>>>        if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>>> @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>         */
>>>        rcu_assign_pointer(*ptr, dma_fence_get(fence));
>>>
>>> -     *f = fence;
>>> -
>>>        return 0;
>>>    }
>>>
>>> @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>>>        }
>>>    }
>>>
>>> -/**
>>> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
>>> - *
>>> - * @ring: fence of the ring to be cleared
>>> - *
>>> - */
>>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>> -{
>>> -     int i;
>>> -     struct dma_fence *old, **ptr;
>>> -
>>> -     for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>>> -             ptr = &ring->fence_drv.fences[i];
>>> -             old = rcu_dereference_protected(*ptr, 1);
>>> -             if (old && old->ops == &amdgpu_job_fence_ops) {
>>> -                     struct amdgpu_job *job;
>>> -
>>> -                     /* For non-scheduler bad job, i.e. failed ib test, we need to signal
>>> -                      * it right here or we won't be able to track them in fence_drv
>>> -                      * and they will remain unsignaled during sa_bo free.
>>> -                      */
>>> -                     job = container_of(old, struct amdgpu_job, hw_fence.base);
>>> -                     if (!job->base.s_fence && !dma_fence_is_signaled(old))
>>> -                             dma_fence_signal(old);
>>> -                     RCU_INIT_POINTER(*ptr, NULL);
>>> -                     dma_fence_put(old);
>>> -             }
>>> -     }
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_fence_driver_set_error - set error code on fences
>>>     * @ring: the ring which contains the fences
>>> @@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>>>    /**
>>>     * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
>>>     *
>>> - * @fence: fence of the ring to signal
>>> + * @af: fence of the ring to signal
>>>     *
>>>     */
>>>    void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>> @@ -781,15 +725,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>>                }
>>>                rcu_read_unlock();
>>>        }
>>> -     amdgpu_fence_write(ring, af->seq);
>>> +     amdgpu_fence_write(ring, af->base.seqno);
>> af->base.seqno is a type of u64 - but the amdgpu_fence_write takes a u32 argument. Should we
>> cast it? (assume seqno never overflows a u32)
> The seq number will always be 32 bits.  dma_fences have a 64 bit
> sequence number but we use a 32 bit one for the hw fences.  See
> amdgpu_fence_emit().  We pass the hw sequence number to
> dma_fence_init().  No need to cast it.
hmm.. understood the situation - my concern is a u64 passed to u32 
without a cast is
more like a coding error even though in fact it works in our case - by 
casting we
know and accept 32bit from 64bit value. Or add a comment so anyone not
familiar with that implication knows why we can do it. Not sure if all 
compilers
allow it without complains.
David
>
> Alex
>
>> David
>>          amdgpu_fence_process(ring);
>>    }
>>
>> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>>    {
>> -       struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
>> -
>> -       am_fence->wptr = am_fence->ring->wptr;
>> +       af->wptr = af->ring->wptr;
>>    }
>>
>>    static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
>> @@ -850,13 +792,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>          return (const char *)to_amdgpu_fence(f)->ring->name;
>>    }
>>
>> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>> -{
>> -       struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>> -
>> -       return (const char *)to_amdgpu_ring(job->base.sched)->name;
>> -}
>> -
>>    /**
>>     * amdgpu_fence_enable_signaling - enable signalling on fence
>>     * @f: fence
>> @@ -873,23 +808,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>          return true;
>>    }
>>
>> -/**
>> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
>> - * @f: fence
>> - *
>> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
>> - * only handles the job embedded fence.
>> - */
>> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>> -{
>> -       struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>> -
>> -       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>> -               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
>> -
>> -       return true;
>> -}
>> -
>>    /**
>>     * amdgpu_fence_free - free up the fence memory
>>     *
>> @@ -905,21 +823,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>>          kfree(to_amdgpu_fence(f));
>>    }
>>
>> -/**
>> - * amdgpu_job_fence_free - free up the job with embedded fence
>> - *
>> - * @rcu: RCU callback head
>> - *
>> - * Free up the job with embedded fence after the RCU grace period.
>> - */
>> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
>> -{
>> -       struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>> -
>> -       /* free job if fence has a parent job */
>> -       kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>> -}
>> -
>>    /**
>>     * amdgpu_fence_release - callback that fence can be freed
>>     *
>> @@ -933,19 +836,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>>          call_rcu(&f->rcu, amdgpu_fence_free);
>>    }
>>
>> -/**
>> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
>> - *
>> - * @f: fence
>> - *
>> - * This is the simliar function with amdgpu_fence_release above, it
>> - * only handles the job embedded fence.
>> - */
>> -static void amdgpu_job_fence_release(struct dma_fence *f)
>> -{
>> -       call_rcu(&f->rcu, amdgpu_job_fence_free);
>> -}
>> -
>>    static const struct dma_fence_ops amdgpu_fence_ops = {
>>          .get_driver_name = amdgpu_fence_get_driver_name,
>>          .get_timeline_name = amdgpu_fence_get_timeline_name,
>> @@ -953,13 +843,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>>          .release = amdgpu_fence_release,
>>    };
>>
>> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
>> -       .get_driver_name = amdgpu_fence_get_driver_name,
>> -       .get_timeline_name = amdgpu_job_fence_get_timeline_name,
>> -       .enable_signaling = amdgpu_job_fence_enable_signaling,
>> -       .release = amdgpu_job_fence_release,
>> -};
>> -
>>    /*
>>     * Fence debugfs
>>     */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 7d9bcb72e8dd3..39229ece83f83 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>          if (job) {
>>                  vm = job->vm;
>>                  fence_ctx = job->base.s_fence ?
>> -                       job->base.s_fence->scheduled.context : 0;
>> +                       job->base.s_fence->finished.context : 0;
>>                  shadow_va = job->shadow_va;
>>                  csa_va = job->csa_va;
>>                  gds_va = job->gds_va;
>>                  init_shadow = job->init_shadow;
>> -               af = &job->hw_fence;
>> +               af = job->hw_fence;
>>                  /* Save the context of the job for reset handling.
>>                   * The driver needs this so it can skip the ring
>>                   * contents for guilty contexts.
>>                   */
>> -               af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>> +               af->context = fence_ctx;
>> +               /* the vm fence is also part of the job's context */
>> +               job->hw_vm_fence->context = fence_ctx;
>>          } else {
>>                  vm = NULL;
>>                  fence_ctx = 0;
>> @@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>                  csa_va = 0;
>>                  gds_va = 0;
>>                  init_shadow = false;
>> -               af = NULL;
>> +               af = kzalloc(sizeof(*af), GFP_ATOMIC);
>> +               if (!af)
>> +                       return -ENOMEM;
>>          }
>>
>>          if (!ring->sched.ready) {
>> @@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>                  amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>>          }
>>
>> -       r = amdgpu_fence_emit(ring, f, af, fence_flags);
>> +       r = amdgpu_fence_emit(ring, af, fence_flags);
>>          if (r) {
>>                  dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>>                  if (job && job->vmid)
>> @@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>                  amdgpu_ring_undo(ring);
>>                  return r;
>>          }
>> +       *f = &af->base;
>>
>>          if (ring->funcs->insert_end)
>>                  ring->funcs->insert_end(ring);
>> @@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>           * fence so we know what rings contents to backup
>>           * after we reset the queue.
>>           */
>> -       amdgpu_fence_save_wptr(*f);
>> +       amdgpu_fence_save_wptr(af);
>>
>>          amdgpu_ring_ib_end(ring);
>>          amdgpu_ring_commit(ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 172620880cada..55c7e104d5ca0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>                     ring->funcs->reset) {
>>                  dev_err(adev->dev, "Starting %s ring reset\n",
>>                          s_job->sched->name);
>> -               r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>> +               r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>>                  if (!r) {
>>                          atomic_inc(&ring->adev->gpu_reset_counter);
>>                          dev_err(adev->dev, "Ring %s reset succeeded\n",
>> @@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                       unsigned int num_ibs, struct amdgpu_job **job,
>>                       u64 drm_client_id)
>>    {
>> +       struct amdgpu_fence *af;
>> +       int r;
>> +
>>          if (num_ibs == 0)
>>                  return -EINVAL;
>>
>> @@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>          if (!*job)
>>                  return -ENOMEM;
>>
>> +       af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>> +       if (!af) {
>> +               r = -ENOMEM;
>> +               goto err_job;
>> +       }
>> +       (*job)->hw_fence = af;
>> +
>> +       af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>> +       if (!af) {
>> +               r = -ENOMEM;
>> +               goto err_fence;
>> +       }
>> +       (*job)->hw_vm_fence = af;
>> +
>>          (*job)->vm = vm;
>>
>>          amdgpu_sync_create(&(*job)->explicit_sync);
>> @@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>
>>          return drm_sched_job_init(&(*job)->base, entity, 1, owner,
>>                                    drm_client_id);
>> +
>> +err_fence:
>> +       kfree((*job)->hw_fence);
>> +err_job:
>> +       kfree(*job);
>> +
>> +       return r;
>>    }
>>
>>    int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>> @@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>          struct dma_fence *f;
>>          unsigned i;
>>
>> -       /* Check if any fences where initialized */
>> +       /* Check if any fences were initialized */
>>          if (job->base.s_fence && job->base.s_fence->finished.ops)
>>                  f = &job->base.s_fence->finished;
>> -       else if (job->hw_fence.base.ops)
>> -               f = &job->hw_fence.base;
>> +       else if (job->hw_fence && job->hw_fence->base.ops)
>> +               f = &job->hw_fence->base;
>>          else
>>                  f = NULL;
>>
>> @@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>
>>          amdgpu_sync_free(&job->explicit_sync);
>>
>> -       /* only put the hw fence if has embedded fence */
>> -       if (!job->hw_fence.base.ops)
>> -               kfree(job);
>> -       else
>> -               dma_fence_put(&job->hw_fence.base);
>> +       kfree(job);
>>    }
>>
>>    void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>> @@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>          if (job->gang_submit != &job->base.s_fence->scheduled)
>>                  dma_fence_put(job->gang_submit);
>>
>> -       if (!job->hw_fence.base.ops)
>> -               kfree(job);
>> -       else
>> -               dma_fence_put(&job->hw_fence.base);
>> +       kfree(job);
>>    }
>>
>>    struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 2f302266662bc..d25f1fcf0242e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -48,7 +48,8 @@ struct amdgpu_job {
>>          struct drm_sched_job    base;
>>          struct amdgpu_vm        *vm;
>>          struct amdgpu_sync      explicit_sync;
>> -       struct amdgpu_fence     hw_fence;
>> +       struct amdgpu_fence     *hw_fence;
>> +       struct amdgpu_fence     *hw_vm_fence;
>>          struct dma_fence        *gang_submit;
>>          uint32_t                preamble_status;
>>          uint32_t                preemption_status;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 0704fd9b85fdb..5d44f1354c8d8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -147,16 +147,14 @@ struct amdgpu_fence {
>>          u64                             wptr;
>>          /* fence context for resets */
>>          u64                             context;
>> -       uint32_t                        seq;
>>    };
>>
>>    extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>
>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>    void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>    void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>    void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>>
>>    int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>> @@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>    void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>    int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>> -                     struct amdgpu_fence *af, unsigned int flags);
>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>> +                     unsigned int flags);
>>    int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>>                                uint32_t timeout);
>>    bool amdgpu_fence_process(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index bd12d8ff15a42..76bae546df11c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          bool cleaner_shader_needed = false;
>>          bool pasid_mapping_needed = false;
>>          struct dma_fence *fence = NULL;
>> -       struct amdgpu_fence *af;
>>          unsigned int patch;
>>          int r;
>>
>> @@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          }
>>
>>          if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>> -               r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>> +               r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>>                  if (r)
>>                          return r;
>> -               /* this is part of the job's context */
>> -               af = container_of(fence, struct amdgpu_fence, base);
>> -               af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>> +               fence = &job->hw_vm_fence->base;
>>          }
>>
>>          if (vm_flush_needed) {
>>
