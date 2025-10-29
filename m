Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209C8CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B979C10E778;
	Wed, 29 Oct 2025 10:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zmK3FYx4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A193510E778
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na2A7aQ+F/F/XHSLRyrkETC4WDusJhyYEm+1tyRMCvpVWedUEM3PS6TYpFyVKWQcP3GLqe6Y20pFgVOFw0zKxwCHdx06soiSosbnYQ54tKk98+BsD2OtzvdKO+uQmPV4sKfIvkG1l8EfDhZh1PRNZdbTo0NhFaqkzd2c0+BxqXt+i2u7T1dMG3yBZPAKL8v4QjPrspsWrjtwfmjT/P4Cn+IDXSRSHWoO4Ih+WE91xI+nQvHn3mDd9N4y2sZqKAudWUdSFbzGB3SDYngZuvDTYLXAfPZLp9z6MVjfE8E74LpHCy8Je3jHGZwYZ0eyZUr7AXJMFap6ewI+PtTm/F0U9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMzEvKOI9kqWq83XfWS2Bw/ACzg8hzQBiOjphotLiqM=;
 b=dtXjDg1e2O/FDoycARtqlpud4d/mFaKx32Wl8qvqYCWdlkjh/JaFZfcuPENlVlzusYyRILop2cceq1SNG1cSMOR0uUwK8O+IFz76jye1jMEqsaINwUgJjuTki0GP0ZjWKpVM92rjI7Xkxlex47upiLJ5I1jasPqxk8Z95yNaOeGoNj7vfAkIKZr4LqJ/JhyM0Q3xv6MLaJxD0NOcRsZphHTXuizf6lPce9LUFirkdh8xRoJ3T51hGwuTr6M87QyGviPqEyNJpTAKDyWvx4tq/Kgn5tyTNvtmVYWsRwXxt2hbI/Dh1t0KTY20PWXvu270bS7bc3j7PvAAanQRvFoJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzEvKOI9kqWq83XfWS2Bw/ACzg8hzQBiOjphotLiqM=;
 b=zmK3FYx4te2FIlcvWQ02rxmJKAfCb8zZaONrw5BGROZ+2F52RmvCKagi02g2P2pVM4o+PE/c96ZiF2GLGQ1kJJRWBu9CSk8Vn0BovSWrX7sLDbUR6kp+rehOQmdLHTSdGCTK3ZBPXJyMGlnZ05v5RXNhiWOTjp9b7bzq6BhbBbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:26:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:26:41 +0000
Message-ID: <27d3ff9a-155f-449c-9986-21368b460deb@amd.com>
Date: Wed, 29 Oct 2025 11:26:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] drm/amdgpu/vce: Move firmware load to
 amdgpu_vce_early_init
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: c2350226-1967-41df-a496-08de16d5a6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDQwY2FDeFFIT1Jyd1JmVFkzenUxSEhPdm1sZ0hmOHh5ZUZlZ3V6S0V6UVQ4?=
 =?utf-8?B?dThVNnc1ZFIrV2tWS3luM2JQeWVrcTVJSjRZQkFOaVZWZXUvc2RzV1Jncms1?=
 =?utf-8?B?UG8wZ3c3eHk3OERyWkdxcTIzcGhJUTN3WU1PUHN4bGYrRzliVU40RjJ6ajBE?=
 =?utf-8?B?NDV4M0hHeXFuRUcyRGJQdEoxbFB4Q1BGNDIzMC9yaVczcEpnRFZSUmdkTW01?=
 =?utf-8?B?ZCtjWWtUbGxyQnppaVl2SW8vVXNTQ2RUczN1aVhHTmlKSXYrTlh4WjlaRlZw?=
 =?utf-8?B?SXFTdXViRnVuelpCUFhjUlpwQTZEMHpsdGIva0JWeHhES00vdkFDZWpUU1Ft?=
 =?utf-8?B?MTV0MjZ5S040QmZpOXhSajRXMlB2ZXo4TDBHQUdEVndLOEhsc00wcit3SjhR?=
 =?utf-8?B?Wm1JTzI2Wm1vUWdHMW5PWXFtNXdOQ0xiM0lDQW94NjdBSVRybmdacWlGMTRv?=
 =?utf-8?B?ZStGeitONXVVY3FVZHQ4dERibk9yS0EySlNHVUNrY3N2TktibXIvWG1kSGNW?=
 =?utf-8?B?UWFWY0R1dFM0b1BndnA2YXRkQkd3NkRHUXVyVW9wRHJWSG1XR0dodjBhMzVp?=
 =?utf-8?B?Z1JsUWh0RHU0K09JT0FITWgva3VvT1BHcHZDVjJVZktncG53T0h4TFVjQjhD?=
 =?utf-8?B?TDUzcy8wRDNCVWVBUzl6SEFvSWtJRlZ4M2U3eU5pL3NNRE1oaGI4L0lyZVcw?=
 =?utf-8?B?MW9PQnlXcW9uelBxa1JxYkdlQkMvZGJ1a21aVnhHbzVJSUpCOVhLazFMaWJP?=
 =?utf-8?B?RWRIK054SmJJY01JVm5XOUI0M0t2N1N1U25qZUM2WC9MdmJQdUJHUkdXQWlV?=
 =?utf-8?B?b2lBcDVNNmsxTmpBbHVUbmpOdkduN3dBVFhKK2kxM2RoL0xQdUhQVHdWNnk4?=
 =?utf-8?B?eExwR0p0ekpIUGlqOHhiWTJ4d1AwY0UyWEpBcjBrSWdPbVkwZVIwY3NIVTlz?=
 =?utf-8?B?eUtoNXluMW4xZ2w1RVJRSnZJSk1CY1hyZDQrRjFPWmU2clF2YTdWSlppTXdX?=
 =?utf-8?B?YmJVUmZuZUdiVTRaaG53cWF2TzBjVnUyMDVyTXphblhtWUZqemczY3pON1JS?=
 =?utf-8?B?aHh0ZlNPR3NoRjcrZjR5V0dYbGdnUVJ3VXU5V3ZoM1p1R05YNWpBWXFSVy9R?=
 =?utf-8?B?NmFTaCtmZDVkTmFxTHdTUVJQcUl5a3RnTkZnY3lSTGx5RE0xTFc3VlpSRnBr?=
 =?utf-8?B?N3hJTUo3QUNzUkFtV0ljU1ZhWWR4RHprRC81RUtZL0JyZlNkVjUxS3pQbXR3?=
 =?utf-8?B?NFk0ZTVrcXNUS3ZKUVlld0JIa1ZwdUdGdURmQ2pxUUNDSDJEL3l2dEtBQzBo?=
 =?utf-8?B?a1hMU3JqU1FCV296ZmhxTS9HYTJ1QytzcjJzMzM4S3RteDZ6ZU1TbGNkRDVr?=
 =?utf-8?B?M25KR1hlbEE1bG9vUnlneU55YThBQ3BPT0Y4Zi9ubFNkRTFScEpCck9JUFVj?=
 =?utf-8?B?T2ZWc2RqUDdpZ0xGZ0lxK2NlY0ptOHlxSUpqeDROdDJIZlFPYWJySFNiVlRY?=
 =?utf-8?B?VEtyQWlnanRQbTdsa0tIc0NhU1BGZjdsdVJEbTJEaFJDYXlHaWtSNytzWS9B?=
 =?utf-8?B?Qy9EVW05SGt0aWVHdy9BNURsRjNtN09mWXYzYXVwTlY0SlpBTVErbjRzVGRC?=
 =?utf-8?B?YldQQXVHd2Zzd3MzWkFLdW1vRTVFSlJFQk0rckJlRFJlbkhxZm85b2JGR3By?=
 =?utf-8?B?R2d4YVEwVm1kK2JDY1pZckhEVlVzTWtNUDdhRElObFhDaE1yOTNKS0RjVUpl?=
 =?utf-8?B?bWJ2c2owSzljTTVScmxYSHlHaWpZaEk3Si9KT0xhdmk4aWdCWjc1YU1RamVS?=
 =?utf-8?B?cnJkaFpZaW5aWXZrMTZaMEoxRWQwdUpKQlQwRGhGT3FLTS9QZlFzb0NsZzVq?=
 =?utf-8?B?cWhDRWtLc2tMV3NqNHpqU3RpUmcrVUN3d0lHZlFYUm1FcXk3TCs4UG4rNy9h?=
 =?utf-8?Q?f2hae4DydaYTAz6vOMNE7/KmgINJDZqC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVCcEs3TzFncWx6N0ozRWk5ZzNZeG1LR0FwRlNTUFU5SlEyYkZPTkczaTFh?=
 =?utf-8?B?WEJsZXZLUmIvWUdEZU5HTW5jYTVMRTBIVkxRWlJGQy9aTU1USEQrLzk1dXZh?=
 =?utf-8?B?cUJCZDlGTndmT3dwNWlsRyticDBNSDliaGNQM2JrYW5EV0dDZXZnbk5jTS9i?=
 =?utf-8?B?SXBGQnNPMVpwaDcwUDErN29rM3J3dXB2djhIemNlV1dVb0VHem1lSjhpSW93?=
 =?utf-8?B?NFN2VzN3dG9CakVYQmF5bTNSVUJYbndFSlFEVUU2OGpIQllTUFBCeGFTbGZV?=
 =?utf-8?B?aGQ4TWNEeUYrVHVZK1M0SnNHUU1tcVBVQXFzeU5PU20rK3cyOFI3RmpZY2ZW?=
 =?utf-8?B?eHUvVDg0dDNXTDU5Vzkwdk5QUkxSSFdQM2NPdnFGM1lXSXFoWXRjMlh6SGRp?=
 =?utf-8?B?NVZ1UU1sWGlqWi94VGpIeExMSG1LdlM2UmYvU0tkWElhMHBNTTBGMFl6YzZC?=
 =?utf-8?B?SFJTQUE0a2lnbFRqZ1NlYzByZzR4eVJPMkk0SC9raU1oK1JreTlPYVdCOWZl?=
 =?utf-8?B?TmljMkp1NWdGa2xVYnF6SkxvMlROSVBpSm1nWS9Xc251UHFBM3kwcEZZMmpU?=
 =?utf-8?B?Z2E4bTYyRk4zbWNQY3M1cWVJTVJsZGxNUHpZUHQwYjgvQUZPeGhBTGFyNEdW?=
 =?utf-8?B?RTk0eDdacFh3RU15dTdpQzNQV0RrNUpGU0xYZVcwbXZFekRPNGpJQlB6c3I0?=
 =?utf-8?B?NUcxZUFPM3VPdmFqN3VyN3lSS1BSMXpOV3VNckVRVC8ya0tIOVpCdzdrZ2l3?=
 =?utf-8?B?T0lZcjg1QWlKVVFxL1hFZkozZjQ4WDdUS1BMWEtaRzdNOXh2U0tRYlRDL3dj?=
 =?utf-8?B?aUlSZkVOK1REL1E1MzMvWWdtbW9DM1RJZUpPUERHMFpsQ2NOVGlVYmlZa2lo?=
 =?utf-8?B?K1JmNm5rYkFxZkJ5ODgrYks5L1hLTzgwT0V3SnNUVXRtbWNkTUVoVk5walVv?=
 =?utf-8?B?clpMS2dDV0lmNTluUTNlazZOOHhxTFkxaWlmU2hoMUF5WFJiS1JBbUVoYlFS?=
 =?utf-8?B?VTE3TXdmQ3JOMXl1LzZmZHIvc0JVWVRwZVRyczFWRjZhK0h1L1dlV25FQmZB?=
 =?utf-8?B?cDNrcTh5T3ZPL2RyaE16K2Iwbld5di9UbVdubmI4RC9iOXp6YVp0NDJYNlJT?=
 =?utf-8?B?SFhCSjhWM3E4eDhXcGtiK01ZQ203TzdHLzM4eUtyYURxVWlyRnI3U0tkYUZR?=
 =?utf-8?B?a09BaFVNYU5LbkErS1l6ZlNXYVRCeHJCeTNxaG00SU5TbDRWVFR3U1VVekgz?=
 =?utf-8?B?MWVrRVVJaG03Zm4vN2JhZlFaVTM3MEpleUw1eXpFS1BlNVJYMWs4cUJFSjRT?=
 =?utf-8?B?ZjdkaGlUaGdGZDlkUlNBQW1udnFSemxKOHR5N25xUlZrV1lwVmVUMmFNVU5m?=
 =?utf-8?B?QXFMSlh4aytwZlBpVFFjYzBScVRBc2o3NW9ESW9saDRLSDRjRGdjVjkrWlBT?=
 =?utf-8?B?RFk1NXA1RVBuYm11RmFpNG5pWGxBc1F4VVFoTmIzZjZVNXdueXZ3MGMxLzlC?=
 =?utf-8?B?VmU1T0Y2cTNiak1BQ2UrbTRmWm15UktNbklQc3FlUnNVSnVmbXNaZDBGUmFp?=
 =?utf-8?B?bm5KTGRmRkJjRGFvZUhuY3kvWTVyZWxnNHBBVmRaOVlONmZkNzVma2tiUEJh?=
 =?utf-8?B?aUZvaHFkQnVGeE9RdkF6bXIrTUhvaDJvZGxRQ3hqVnJuenFOTTA3cUFkb0ty?=
 =?utf-8?B?bnA5akdha0p5cmNZMjZVVE02THl3MVp3cmRsdTI1eVNYZ0ZEMDk0RUlSS3pV?=
 =?utf-8?B?c0RjSkRCc0VuS051aWd4WWRqWW1ZMlVWUzgzYVVKYmFjbVdEZUlzeEFyaXVh?=
 =?utf-8?B?dThyQ0xheVhLRGFXMDFSYUlFdTQyYTNpQWplREdvUzZTcFMwWk8zZnFZbTlK?=
 =?utf-8?B?cFJMYkVwcFhpd0pVSjZYc2xjOEh3N3lhVExST0VqM213Mm5tOGNwT0JIVFVV?=
 =?utf-8?B?d1c3OTE3aFlta0FSelpaNFpzMERpMHIvTXgvUStiNHJuQ3Q5S1Rza1YyR3NY?=
 =?utf-8?B?VHFlUXJKbVRGY3dLR2phL1RwUCtWdW1YTUZmYmJEd0hINDNScWRwckV1UUd6?=
 =?utf-8?B?UnRNS1dQT1ZxcEt5WmttVEg3QUoxQnp1SE1nb3hMbmlGcFNYend4eUN0RnNz?=
 =?utf-8?Q?u3vryAaeVpIOL68hyeRmeMX1I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2350226-1967-41df-a496-08de16d5a6c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:26:41.8075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYDREOvfxnkRCWMQuGKUdyB0+QHKR0/7s8MskGfz+YLvpeYSguA3EhlmyDzkPKmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Try to load the VCE firmware at early_init.
> 
> When the correct firmware is not found, return -ENOENT.
> This way, the driver initialization will complete even
> without VCE, and the GPU will be functional, albeit
> without video encoding capabilities.
> 
> This is necessary because we are planning to add support
> for the VCE1, and AMD hasn't yet publised the correct
> firmware for this version. So we need to anticipate that
> users will try to boot amdgpu on SI GPUs without the
> correct VCE1 firmware present on their system.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Looks reasonable to me, but Leo and his team should probably take a look as well.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 121 +++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |   5 +
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |   5 +
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |   5 +
>  5 files changed, 91 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index eaa06dbef5c4..b23a48a1efc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -88,82 +88,87 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>  				      bool direct, struct dma_fence **fence);
>  
>  /**
> - * amdgpu_vce_sw_init - allocate memory, load vce firmware
> + * amdgpu_vce_firmware_name() - determine the firmware file name for VCE
>   *
>   * @adev: amdgpu_device pointer
> - * @size: size for the new BO
>   *
> - * First step to get VCE online, allocate memory and load the firmware
> + * Each chip that has VCE IP may need a different firmware.
> + * This function returns the name of the VCE firmware file
> + * appropriate for the current chip.
>   */
> -int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
> +static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
>  {
> -	const char *fw_name;
> -	const struct common_firmware_header *hdr;
> -	unsigned int ucode_version, version_major, version_minor, binary_id;
> -	int i, r;
> -
>  	switch (adev->asic_type) {
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	case CHIP_BONAIRE:
> -		fw_name = FIRMWARE_BONAIRE;
> -		break;
> +		return FIRMWARE_BONAIRE;
>  	case CHIP_KAVERI:
> -		fw_name = FIRMWARE_KAVERI;
> -		break;
> +		return FIRMWARE_KAVERI;
>  	case CHIP_KABINI:
> -		fw_name = FIRMWARE_KABINI;
> -		break;
> +		return FIRMWARE_KABINI;
>  	case CHIP_HAWAII:
> -		fw_name = FIRMWARE_HAWAII;
> -		break;
> +		return FIRMWARE_HAWAII;
>  	case CHIP_MULLINS:
> -		fw_name = FIRMWARE_MULLINS;
> -		break;
> +		return FIRMWARE_MULLINS;
>  #endif
>  	case CHIP_TONGA:
> -		fw_name = FIRMWARE_TONGA;
> -		break;
> +		return  FIRMWARE_TONGA;
>  	case CHIP_CARRIZO:
> -		fw_name = FIRMWARE_CARRIZO;
> -		break;
> +		return  FIRMWARE_CARRIZO;
>  	case CHIP_FIJI:
> -		fw_name = FIRMWARE_FIJI;
> -		break;
> +		return  FIRMWARE_FIJI;
>  	case CHIP_STONEY:
> -		fw_name = FIRMWARE_STONEY;
> -		break;
> +		return  FIRMWARE_STONEY;
>  	case CHIP_POLARIS10:
> -		fw_name = FIRMWARE_POLARIS10;
> -		break;
> +		return  FIRMWARE_POLARIS10;
>  	case CHIP_POLARIS11:
> -		fw_name = FIRMWARE_POLARIS11;
> -		break;
> +		return  FIRMWARE_POLARIS11;
>  	case CHIP_POLARIS12:
> -		fw_name = FIRMWARE_POLARIS12;
> -		break;
> +		return  FIRMWARE_POLARIS12;
>  	case CHIP_VEGAM:
> -		fw_name = FIRMWARE_VEGAM;
> -		break;
> +		return  FIRMWARE_VEGAM;
>  	case CHIP_VEGA10:
> -		fw_name = FIRMWARE_VEGA10;
> -		break;
> +		return  FIRMWARE_VEGA10;
>  	case CHIP_VEGA12:
> -		fw_name = FIRMWARE_VEGA12;
> -		break;
> +		return  FIRMWARE_VEGA12;
>  	case CHIP_VEGA20:
> -		fw_name = FIRMWARE_VEGA20;
> -		break;
> +		return  FIRMWARE_VEGA20;
>  
>  	default:
> -		return -EINVAL;
> +		return NULL;
>  	}
> +}
> +
> +/**
> + * amdgpu_vce_early_init() - try to load VCE firmware
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tries to load the VCE firmware.
> + *
> + * When not found, returns ENOENT so that the driver can
> + * still load and initialize the rest of the IP blocks.
> + * The GPU can function just fine without VCE, they will just
> + * not support video encoding.
> + */
> +int amdgpu_vce_early_init(struct amdgpu_device *adev)
> +{
> +	const char *fw_name = amdgpu_vce_firmware_name(adev);
> +	const struct common_firmware_header *hdr;
> +	unsigned int ucode_version, version_major, version_minor, binary_id;
> +	int r;
> +
> +	if (!fw_name)
> +		return -ENOENT;
>  
>  	r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
>  	if (r) {
> -		dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
> -			fw_name);
> +		dev_err(adev->dev,
> +			"amdgpu_vce: Firmware \"%s\" not found or failed to validate (%d)\n",
> +			fw_name, r);
> +
>  		amdgpu_ucode_release(&adev->vce.fw);
> -		return r;
> +		return -ENOENT;
>  	}
>  
>  	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> @@ -172,11 +177,35 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  	version_major = (ucode_version >> 20) & 0xfff;
>  	version_minor = (ucode_version >> 8) & 0xfff;
>  	binary_id = ucode_version & 0xff;
> -	DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
> +	dev_info(adev->dev, "Found VCE firmware Version: %d.%d Binary ID: %d\n",
>  		version_major, version_minor, binary_id);
>  	adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
>  				(binary_id << 8));
>  
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_vce_sw_init() - allocate memory for VCE BO
> + *
> + * @adev: amdgpu_device pointer
> + * @size: size for the new BO
> + *
> + * First step to get VCE online: allocate memory for VCE BO.
> + * The VCE firmware binary is copied into the VCE BO later,
> + * in amdgpu_vce_resume. The VCE executes its code from the
> + * VCE BO and also uses the space in this BO for its stack and data.
> + *
> + * Ideally this BO should be placed in VRAM for optimal performance,
> + * although technically it also runs from system RAM (albeit slowly).
> + */
> +int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
> +{
> +	int i, r;
> +
> +	if (!adev->vce.fw)
> +		return -ENOENT;
> +
>  	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>  				    AMDGPU_GEM_DOMAIN_VRAM |
>  				    AMDGPU_GEM_DOMAIN_GTT,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index 6e53f872d084..22acd7b35945 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -53,6 +53,7 @@ struct amdgpu_vce {
>  	unsigned		num_rings;
>  };
>  
> +int amdgpu_vce_early_init(struct amdgpu_device *adev);
>  int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size);
>  int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index bee3e904a6bc..8ea8a6193492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -407,6 +407,11 @@ static void vce_v2_0_enable_mgcg(struct amdgpu_device *adev, bool enable,
>  static int vce_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_early_init(adev);
> +	if (r)
> +		return r;
>  
>  	adev->vce.num_rings = 2;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 708123899c41..719e9643c43d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -399,6 +399,7 @@ static unsigned vce_v3_0_get_harvest_config(struct amdgpu_device *adev)
>  static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  
>  	adev->vce.harvest_config = vce_v3_0_get_harvest_config(adev);
>  
> @@ -407,6 +408,10 @@ static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>  	    (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
>  		return -ENOENT;
>  
> +	r = amdgpu_vce_early_init(adev);
> +	if (r)
> +		return r;
> +
>  	adev->vce.num_rings = 3;
>  
>  	vce_v3_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 335bda64ff5b..2d64002bed61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -410,6 +410,11 @@ static int vce_v4_0_stop(struct amdgpu_device *adev)
>  static int vce_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_early_init(adev);
> +	if (r)
> +		return r;
>  
>  	if (amdgpu_sriov_vf(adev)) /* currently only VCN0 support SRIOV */
>  		adev->vce.num_rings = 1;

