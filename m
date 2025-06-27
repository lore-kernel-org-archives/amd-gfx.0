Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0326C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 20:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0500810EA28;
	Fri, 27 Jun 2025 20:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E70WBu15";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4388610EA28
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 20:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvDSSp5NgGSxBj64YYJwfZ85npXm26d4UMMXjBLao6wmEHEWRHrcJRvFRkADIKIeBAtQOktC0QeYRLZqxlgqDw7fS6MDhXfz9eFxXz9HXTrs5DQ0ao5JaVYXso+fTa3xqS5NlIjiTOz54dQWRK1tOWJFhahhXlNdY55ErBP2WrgdID3ee/ioOjyKHRaj/y5Wg9GMbKuFaB3ELYBDslbR9xxmLY+HKndf/jAtqVRIgSZz1ZdgswL5837c50EsfbIwGTF27UnjYdNNVyf6FspEFEqpqCzzbMBGYPpYP+re2eYSmNmiXLD6gIujoWisZxHs0fbUfrV1gOSES+d8AZIYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9TP8r02YJMMr5gRkriHt4ROruS/zVOMblhWTgTre+A=;
 b=g5LteoAa9Qms9bRHUD1eHOX2xAhMSVhzH4/fNRMOOJXCGjMCw1C+FcI308swzHkXG5xAthEYpsSsFrqTyBb8vEUa5KYy0tFwmuZfVz7MOQPvr5gDqoqkBwREw+I1tTB89ZPytOXFI/f3z5eHhQKJnm4XtAkJsuuw5jr9ecCz3ssC0ykQJXonScy9RcVuHAnubuDMKNh9eX3zYY82EtAswCcF+ck8Wu6DehWr1kx2gbQUHtS0SceP1RSyJEbH5I4ru/KAbjEi15OGu6olAv+m+pvyW72cR+JqhNbJ2y2WADRw4p7zIOnXeIc2W0w3Bh+HqZirvaKRaXyNmkBEDHkFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9TP8r02YJMMr5gRkriHt4ROruS/zVOMblhWTgTre+A=;
 b=E70WBu15budKvXMZW7//c7vC5YAliumR19wyZZaM+GqhbjcZ7vgTVah/pBAglJVZxV9g/ZFUWJ0LAreVSMJDuCaMIvheVATUmUZ7SKGvUVWWf1sfgjCmLDuEG6MLpRW4vultN20rfUOeRah92ExDjh21v2X375Tgl0UuQiiD0b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 20:27:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 20:27:14 +0000
Message-ID: <7424b281-4101-432b-a1b7-fe7226bb49fd@amd.com>
Date: Fri, 27 Jun 2025 15:27:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add helper functions for isp buffers
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com
References: <20250627201736.696030-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250627201736.696030-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:805:f2::46) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b336c79-9b78-4c90-5059-08ddb5b90100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bndIRkpaczhWVGdlNk9FdXAyZ3NIWWcxSUx4VThmVytpWXh6RmxQS0kzamVp?=
 =?utf-8?B?VTcxYWd0MGs0OUlOVll3VEpLQkpSdEZJT3dJaitqK3pjVTFvNjhaM2xEalha?=
 =?utf-8?B?NVZ1bnViR24zS3VqV2RvdG9pOThzbk9GTkdZSWI3d3pEZXBJa0NRd2tEN3NP?=
 =?utf-8?B?SWhVU1ltMUh3RWk5eVFIY0M1dGhZQkZ4WjA1MEFNYVNlN0QxYTdxM0QrQkRE?=
 =?utf-8?B?VkpTQ0IvWXh0U2xhc09qSVAvSEJjbzk4cnk5QllaL2hKYjZSNTg3ekR1aDFM?=
 =?utf-8?B?N1JpVkg3QTVIdzBUWncxQXBTdUtEcTc1b0cvUzJGZDIzMC85SEc0VFpyZDlY?=
 =?utf-8?B?Q3RmNW5HVmFRclgwRUM5Q3N3dDdWbkkrZkp3ZGswZGdNVXd2NHRjNy8wZlIy?=
 =?utf-8?B?V1dBK1ZUb1VoZWhURGtnSGkxekFIUUNmRXJsUWtvUXp0TVJEVjduNFVXTnlD?=
 =?utf-8?B?Q3VWS0ZuYThFUUIwZFRyNUFPK2hHYkg3NFkyc283U1JUQk1uaXVqVkxxUDl4?=
 =?utf-8?B?SXdoRk1uM1lUOC9Mb3hzKzRMODZEUXF4ME8reWRNTUQ1Sk1qdW5IVHFTMUV2?=
 =?utf-8?B?K2hoR1d2M1E2ZDI0K2FLblV4cWVpTFBFalZmUSsrbkRSZ1dzcnZMNnM5QlNS?=
 =?utf-8?B?M3cvVUxCKzdrSEdVVkdJOWptM0ZHc1dCRW5BZUw0UVJSWUV2T25yOXZ1clV2?=
 =?utf-8?B?YVdEeEdvTTZnL0xET2pycXR3SjR5VGxnSk9odmtleWx4RGxiNHdXTUt5cTFx?=
 =?utf-8?B?UXhKUk1UZThRaGpLcjUzRWpxbUE4alk5Zm5jME1Lb0xHUGdwd0hndXp5RkxQ?=
 =?utf-8?B?VllZYkZLd1pyV05XbVZMZVZKQUhqUVJxOUdZcU1RQ0NheU5SU2EvNWdndkla?=
 =?utf-8?B?aXhvTXpMSWZhaVM0bjZtNzJZcVNUMXlpYmdBT3VuWnIrTE52SDF5WWt6UUh2?=
 =?utf-8?B?WmQyR1RJQkgxUjNMT05JTU9xazQ3eEFsazR1UVVyL1lJdHkvK3V0OXFST0Zm?=
 =?utf-8?B?SnJLTFQyeDhVY2I4TndzL25IaEQydVNzZGdWUUVzQ2JzNGpyREJHcnEvek1r?=
 =?utf-8?B?dkNPaTIrUittYkNLY29YTkt5YzFveWdIdDRCdFYzNU5KejY1Nmp4L3lqM3Vu?=
 =?utf-8?B?Y3BDR2w1ZmhmUjFHcjA5cmxlVHJQOVVlQTMrZDRzL0M1R08vOHQ5WWRaNGxY?=
 =?utf-8?B?L25IeVBmeDQxTVY3cGp4aVIxMDVEdVBURWs4Q3M0cVZRYk40Vm1qR3JHaFZB?=
 =?utf-8?B?UCtFSlVjNmVvdVlCREJ1SUpoaGF2RGhlYUNnUGVqM2tVRk0yQzAzNnZEWGxw?=
 =?utf-8?B?MTVrUFBsMFRReTZsNWxHZzRrQ2l6anorS2NCRndQTmxRRVIyRHo3TlRTTWNL?=
 =?utf-8?B?Kzl5SmhhbWZUNmYrOXdQcVorL01IMkhQanhpcHlqdCtEUnYzK0hWaEpOZktQ?=
 =?utf-8?B?eWt0czhkdXQyMTFObEZSamhmY09IcklOc0FTZHlLZ1d4eGtmc2RMaGNLOGZC?=
 =?utf-8?B?WlE1ZnA2MVVkTmg4ZVNoWUQ3SGc0VHU2bElWSVZRUmcrU3NjdkJadkRKbXhu?=
 =?utf-8?B?eGhzTjRleFdjM1RJN0dXNWVxSUxONmVrTFI0Z1h3dGtIVmJOMGhWeUQraXRO?=
 =?utf-8?B?N2J4VXRDdGdmdGhBNnEzU0tvdCtjNXFGYy9DUlgwMG1oOUNja2lheEV2UThy?=
 =?utf-8?B?R0hCdDZGU01IU0wwVFJocWRkUzZmMkVkUHg5RE1EU2VqMW1TU0RxeU1MSTVo?=
 =?utf-8?B?VGUrNEh0aGxCSm9ubzBwUncwMXd0eEdiSWZIa2ZGSmVzRFNwdXRabWdRQTFJ?=
 =?utf-8?B?VmRPSGxsUUVBSHVsQWNBNGFjSWFkUENYTmlGN0F6RGRONUVmUWdrMzdOWVdY?=
 =?utf-8?B?U1BqcVppSE9UUWJnK2NpbmtodGdUKzQ4TTNzVy84MktFNFhXRk9QSTVNOTU2?=
 =?utf-8?Q?UkY/RGBCy1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdHWEhRK2hCc215WFpQSS9wMS9SUTRvVytOQ2ZPSkluUG1GREExc2YxNlpn?=
 =?utf-8?B?eGlxNUlrMEhXWGVHSVNRcU0wTXRmT2s3UWxhcXZGZU9PMHVmWVZmSEZicWdI?=
 =?utf-8?B?dlVsUHBwdUI0V0k4U2xkbWY5ZVFaOW1FamxxOTdaenZwK0tDd1dhQnBKOFk0?=
 =?utf-8?B?Qi9MZTc0VlhNY3VqbGpsQ1duSGdJd1dCRjBra3BYb3o2d0ZJVFFGNzZRTUF2?=
 =?utf-8?B?SWRVSnNOQVhrVGFlQmNKNXo1ck10NndsMFF5RUlrNUt0bDdmRFNHWUFpMjVZ?=
 =?utf-8?B?UWJ4YWhuSVZEZ3RDR3hyYlpNU1VxeGlkRnZzdzJBd0IyY2lsQnVVUE1yb0VZ?=
 =?utf-8?B?dll5QzVsUjNNM25iUVpZdFNBL2ZaTVlrZzhXbXp2c1BoOUhhQUJxaTdYSGts?=
 =?utf-8?B?cE0yc0gxdzFDcGkwY2VnOFVWOFJLb05YaTBpM1hSOWZxTjU0U3ExNVorWVo1?=
 =?utf-8?B?YjM2bk9hV2VvZk9YU2F3OEZpR012OGtzV2YxWkRCcUx6V2F4ZU91cXE3dko0?=
 =?utf-8?B?SDZUcDA0RXhpSHdkRWczaEVqVThDUDdRdHBzSWxZVmNTRVU4dEE1c0w0MTZ0?=
 =?utf-8?B?b1dWY1Ayc2VUQU5WS2xZRkFJbGF6S1lJN0tnclJmU0lJWVVRelpwaFRGSm1w?=
 =?utf-8?B?QWpIK0Rsc1F5bGloL0xteWxleEpsNm9xQm5PV2wrem1hQm5KK3dtcUF0RE5B?=
 =?utf-8?B?ck5OZmxkRTlmOEQ3S0lSTW4vWC9MZzhLQW9mQStkNjlGdWNHQWJCNFAzakxk?=
 =?utf-8?B?Z3Fxd1BmaHhpdmd0a1RWQ0F5alZNc2UzanNkT1hYSmR1WjlVQm1kWTlwaDRL?=
 =?utf-8?B?TnVVT01KVHI3RmlSczl1czBZbkM2MHdrQXNFcFViUklOd2RTb3BaczBVY3Ux?=
 =?utf-8?B?aFRXaVNCS1lybjRDNVdDSjRCR0JVZmN1cmlMWlh0bVJoUG9zQlV0NWo5aHRS?=
 =?utf-8?B?VG5kNk9oNHVYenZ6L240RUZnUDB0MHJMSXBzZTMxdDl4Vmk2VkJvWXFpdVVw?=
 =?utf-8?B?NUpPL21GbjJaMVhVSHVTNnEzUWg1N0FNNVRnMWkyTEFMajlnSnBEdmtMcm1t?=
 =?utf-8?B?eVh6UCtVNVNZZlVlaU13WHhlTldhQkliL0xnU2c0VW1VK1pPNzdwZUkvUnNY?=
 =?utf-8?B?VTMrdE5Pdzd1ZkY0UXdBT3FtQjB4YTcwUjRPLzV3dmNiK1hCeVdTWGxublhE?=
 =?utf-8?B?Y0dYcWRtWHp5VlYydzllc3JTUXphajRMdXZjMXF4aXl0M090aTIxdmlmaG9h?=
 =?utf-8?B?ZHBjSm8vbm5Ud1hYMjd3bHhuMTUzS0ZKN1ZydnowWHFkQ3l5YlBjZWJsZlpT?=
 =?utf-8?B?ck41YzV1UVBQVjR0L2o4OVh6eXpKemRhSThlNG9xVk1hSTZCNzQ2eDE2WFM1?=
 =?utf-8?B?U0RmaEF0YTNaWnpQdm5IdVlGTTI5Mk9iMGUxd3RmWCs4dmU2ZFROT0tTM3U3?=
 =?utf-8?B?Ykw4Z0pxblpPeFZzOERtNHBoZHhoTk10MEhTWW9zdUJoaEZzTisxYUVkN050?=
 =?utf-8?B?bGhaOHlGd2VWNnRlckJhamJIT05zSHlKRmxVY09LdGxzaXJPSkpxU1dEK0lB?=
 =?utf-8?B?RTNhYU9ZNDZJRnhibEV2amxidlc3K211VkdmVVpNT0ZWODYyT08zYU5YWGNn?=
 =?utf-8?B?OWZiZGtReCtzSXA5Ulc2Tlp6Y3E2SUc4aUpnSmFFK21IQWhQeXhEdUJYZzJu?=
 =?utf-8?B?ZVBlUldSTGNrWHg3N1NFdXFWZ04xc3JnTEpMWUpWbXluRWU1NGVZUHV5N3Yy?=
 =?utf-8?B?elNOVTNpRmNlSjhpUzYwL0xRNWcwOUJHT04yUkVxTWdWSmdzeVFjTlBVYlVx?=
 =?utf-8?B?dGl5bVJuN0xsaWw0UEErYXNyNDRucjRKcTJKb2VlTFJwR0w3T3d4TVRmSkg3?=
 =?utf-8?B?ZnRmTzR1c21odkJ6bDhkaU53VkRWTkJWOVF1UzJyU3pKZmFzQVFib3ZpdTIv?=
 =?utf-8?B?WGhhRFgyaFA4YUIrZzFaR0QweUdGWGgzYWNJcGhCdjVzcVdCZmNXeHQwaVMx?=
 =?utf-8?B?eVRDRmVvVHd2ZS83azhGQ3BnQ0JtZ3d0cmRBRXlGaWs4bThSWTVWaWNEQWts?=
 =?utf-8?B?OWlEVGtxdVBzTkhBelBFZjloT0NuaVlRWW0zL2dNMjlzVHNrNC9HREhpN2dj?=
 =?utf-8?Q?A/edllXqw2utkRXwOpA0CbxuQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b336c79-9b78-4c90-5059-08ddb5b90100
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 20:27:14.8291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE0PobKQgPbgP4cUTp98uBoay0DBKteV+sCBKWkfFhzqJ+HiCwMXbOkkZh8diSL31lEmlYag75hc6r01XtgzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

On 6/27/2025 3:17 PM, Pratap Nirujogi wrote:
> Accessing amdgpu internal data structures "struct amdgpu_device"
> and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
> buffers is not recommended.
> 
> Add new amdgpu_isp helper functions thats takes opaque params
> from ISP V4L2 driver and calls the amdgpu internal functions
> amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
> alloc/free GART buffers.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 73 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
>   drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
>   4 files changed, 121 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 43fc941dfa57..1b776c966bf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -33,6 +33,8 @@
>   #include "isp_v4_1_0.h"
>   #include "isp_v4_1_1.h"
>   
> +#define ISP_MC_ADDR_ALIGN (1024 * 32)
> +
>   /**
>    * isp_hw_init - start and test isp block
>    *
> @@ -141,6 +143,77 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr)

As these are exported symbols intended for use outside of amdgpu, I 
think adding kernel doc explaining how they work and what the arguments 
are is a good idea.

I recall you had some of this on the old exports.

> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
> +	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];

What happens if a caller calls this function on a system without an ISP? 
  Couldn't this be a NULL pointer deref?

So I think you need to catch the NULL ispdev case.

> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	struct amdgpu_bo *bo;
> +	u64 gpu_addr;
> +	int ret;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = amdgpu_bo_create_isp_user(adev, dmabuf,
> +					AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
> +	if (ret) {
> +		drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	*buf_obj = (void *)bo;
> +	*buf_addr = gpu_addr;

As this is from an external caller I think you should either WARN_ON() 
at the beginning of the function or guard:

if (buf_obj)
	*buf_obj =
if (buf_addr)
	*buf_addr =

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_user_buffer_alloc);
> +
> +void isp_user_buffer_free(void *buf_obj)

Same comment for kernel doc

> +{
> +	amdgpu_bo_free_isp_user(buf_obj);
> +}
> +EXPORT_SYMBOL(isp_user_buffer_free);
> +
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
Same comment for kernel doc
> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
Same comment for NULL ispdev
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	int ret;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = amdgpu_bo_create_kernel(adev,
> +				      size,
> +				      ISP_MC_ADDR_ALIGN,
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      bo,
> +				      gpu_addr,
> +				      cpu_addr);
> +	if (ret) {
> +		drm_err(&adev->ddev, "failed to alloc gart kernel buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_alloc);
> +
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)

Same comment for kernel doc

> +{
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +
> +	amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_free);
> +
>   static const struct amd_ip_funcs isp_ip_funcs = {
>   	.name = "isp_ip",
>   	.early_init = isp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> index 1d1c4b1ec7e7..cf26d283469e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -29,17 +29,12 @@
>   #define __AMDGPU_ISP_H__
>   
>   #include <linux/pm_domain.h>
> +#include "isp.h"
>   
>   #define ISP_REGS_OFFSET_END 0x629A4
>   
>   struct amdgpu_isp;
>   
> -struct isp_platform_data {
> -	void *adev;
> -	u32 asic_type;
> -	resource_size_t base_rmmio_size;
> -};
> -
>   struct isp_funcs {
>   	int (*hw_init)(struct amdgpu_isp *isp);
>   	int (*hw_fini)(struct amdgpu_isp *isp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index c5fda18967c8..122a88294883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>   
>   /**
>    * amdgpu_bo_create_isp_user - create user BO for isp
> @@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
>   
>   	return r;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>   
>   /**
>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
> @@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   	if (cpu_addr)
>   		*cpu_addr = NULL;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>   
>   /**
>    * amdgpu_bo_free_isp_user - free BO for isp use
> @@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
>   	}
>   	amdgpu_bo_unref(&bo);
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>   
>   /* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp.h b/drivers/gpu/drm/amd/amdgpu/isp.h
> new file mode 100644
> index 000000000000..6c8214ea28e1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/isp.h

I don't believe this is right location for this header.  It needs to be 
included by drivers outside of drm doesn't it?

So I think it should be in one of these locations:
include/drm/amd_isp.h
include/drm/amd/isp.h

> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __ISP_H__
> +#define __ISP_H__
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr);
> +
> +void isp_user_buffer_free(void *buf_obj);
> +
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +#endif

