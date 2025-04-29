Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58BC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 23:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5389710E579;
	Tue, 29 Apr 2025 23:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1QV9Ag4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31ED110E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 23:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJt3VM8/nKXE2mcBUVSzMTQRUMBcTVGEIYAqOe+TRSskPcFUp7L5t6F/Eqivj2oOUQ712BJznRY0GYVng1gKd39PKoxJeRYF+iB5q3UgLxDK+Er6hoMj8Pt0B0TzYXoXsrg5mGp46EVlX89WCZtPMi5zANZOTHWv0JxwyO7+ifZV92bq9+xDIrC7j8xHM9fEK0ZPe+lZJmk5tMV3NSkf7L/jlE/cdkpsTUjAYyjjmcn0DhQ5GCV8G7/KFqrAls70ZV13z/LCPPZUsYEipL3h+L+8/BQp29fDDwjT8rH9UyhAVdnagQVRusw3O1OiF0cxil6KpLG/Glp4x0JCeHeuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjY7wKhw7rQYQmfSnpP85r532HGg1WKRrM4IlGWS6tw=;
 b=ZIdrMjh4kZAhsXpU4P3wNytrgUB495+PAS1sza689FtIHnx6Ky8JwAWXTfq6ENFoXtv9HBr/TvMZlJU5E6xUxccTOCj5HKTzBeZlZ+wQSxro6LW79uI1r5P28+HlJKtkexufy+cM4eLlhmzWMQYbhr5sdSFFsFrXY0hnWMGI6buTRCVv+dg+tD8i9XkeUtD/F0+2tnfFPrcOohljncW4RVWRwZQMV9wUF8RZJFUjvBfodNyPAOsBAPRfuqa3kk43g9LWD2G3aAU1RasbR03oUyz9mj67WjnczmmG/ZQUlcqyDri+b552VhUuhTbwzRZATKPuOlNc8hBUnzjsObdYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjY7wKhw7rQYQmfSnpP85r532HGg1WKRrM4IlGWS6tw=;
 b=m1QV9Ag4gHl9g3EhxJagXmWABvECzqzJhDii/0qCSlqNAt4tmkrhwLyHOBT5wrdHerNw2nwfAVzY+ALSctpDsIrQTfOWcYDqrPQdFLYWX+REebRKtpOSHQGmQFPh1hVJT86IGTllF/CvyXQK7oQqVhChwEVYEiB94cq8G4ySLHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 23:58:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 23:58:20 +0000
Message-ID: <d5429483-4597-4065-a605-7ca569dafc94@amd.com>
Date: Tue, 29 Apr 2025 19:58:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Philip Yang <Philip.Yang@amd.com>
References: <20250425033513.1535517-1-shane.xiao@amd.com>
 <20250425033513.1535517-2-shane.xiao@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250425033513.1535517-2-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 69609d89-48cd-43c0-744b-08dd8779b80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXF5OG13MFN2N1FEUC8wMkpWdEJxYnpNS0RMb1ZrM1VralhEQ1hKNGc4OGVw?=
 =?utf-8?B?U21idmJ1bmthcnduWFJmMDVra2Z4KzlpRVhiOHc4L1doNHh5RFZFMXcxRWMz?=
 =?utf-8?B?N2t3OEdwZTA4b0ZRdG9aRmNMZjFjdmtVT0hrQkN2ekN3M2preW9zVzlDMHN1?=
 =?utf-8?B?bjB0OXlCamVQaUgyUEZZdFR3a1c5Zk5nTGo2cktYSE1zdGVTSTUrVit3VkxR?=
 =?utf-8?B?OHJ2aXg2OTl4V1hZZHBDeC9BeUVnV00wdndkaDFqeG1zRWxPcU41SVdCRlpa?=
 =?utf-8?B?U0xiREhWY2dxeURkZ0xJekc0T0FOUUk4aTY3U1NFVnlGa1JzRTdENnF0RHhL?=
 =?utf-8?B?YWpxUE9HcERPUUdJUmxaTGRBZXNrQmpBdUpsTitMSlZ2SDlGV2VlZGpTNGFv?=
 =?utf-8?B?MXIyWGowWDhVUXltdEN1MVJ4Q1R5RDV0Z3FNMHViL3VrVlhpWm00TEJ3Mm9B?=
 =?utf-8?B?c29VcTNVOU5ubXV3aUxobVFvb3B4VVRINWZFSVlBUEhJY09nbnVSNE5ISzhS?=
 =?utf-8?B?RTIzVnNEMUdINjR4VzVxdTlqZ25ZRWw1YmJyT2ZHejM1ZXFlNXFSYnRwY2Zp?=
 =?utf-8?B?emFPdHNxYVpRdzQ5TFM5T1VGalBINENVUkszSEZqT2lVWFAxR3VKQm0veXpj?=
 =?utf-8?B?d2NvZjYweGNIazhqQXBCQSsrMjZUb0xrbjRxNk50RzBVb0lHUEVhNUU0SVVx?=
 =?utf-8?B?OFZlZWxZckRkN1JnQWh0R2xqVTJndkFRdUk3M0IvSXRuTitpVEkwT2ZDMVhS?=
 =?utf-8?B?eXlZelliNUNaa1VNSEQ1REVSUXVFc3NpMVVrbUtoQVBGTmZlY0JGRWgzREdJ?=
 =?utf-8?B?ZWlsRW9kcitTY1Uzdk9mTlFUQk5tUG9KM2d5RmdzZUZKUnhBMnIybURBMUxj?=
 =?utf-8?B?a1BwNStKUTMrR0o1T0R6R0Z4L1gxOVM0THVXUVl1bFlWUHQ3RENxVld1WEZ0?=
 =?utf-8?B?OEVGaGZESUhkTWJER3VkQWVMTUF0S3NDTmswMnVwM1hVT096MFBGUzhUZzdv?=
 =?utf-8?B?b3VoRzNJZ2EzWm1JOVl2d2VNSGRTZE5WQ3EyNzF3SUVBOGViN2dPbXE0WWlv?=
 =?utf-8?B?bzFDdTBtcXMyMHFlYTVWcGhpTTdlcUZaRWZYS0JLOC9MaXgzT2cxdEV6K2pS?=
 =?utf-8?B?MG4zQUs0dnp1UVI1WmRnd0g1dWMwUFRQM3JFRGx1ZnlJSkZOMEZMbmlVMVdy?=
 =?utf-8?B?Q2hIR3VOL1pOSS9ZKzQ3QWNQR3lpQTVQYWpJOUp5d2JGTWVZamlCNTBYSE5z?=
 =?utf-8?B?V1lzWmllWGo5VVNHNVN0c1JvVTdsMTlzNE1WQ0VDcHNkOUZTTVdCbkR1RC9h?=
 =?utf-8?B?ejJ6OHF4eHdiOXB2b3NVMk0wSzU4MVlCQTRVdUUzZzc3aXMwQmVOaGNkRFVx?=
 =?utf-8?B?WlFGSFhWdThzeE85SlFLT2lKNDFkSm9nZ2MrZy9rbzhiUS9FS1lhemR2NmNV?=
 =?utf-8?B?c2lHaHpqRHVqWVdwVkV6c0lJblByazRsNkQ2RnhqK0cxaUlhdGtGYjJzbEp1?=
 =?utf-8?B?YmpDM09yK1lka2VyOG9GYkJPNzYwSGxCbzd3a3BIckpDS2JkOXZYS0hzQU9J?=
 =?utf-8?B?bFF2OVM5TjRzallTRGsyRG0vQVJ3dE5CMUZSa3JneGk2cXFwTFhUcGNjNThC?=
 =?utf-8?B?cGVlcHdxTHp1Wk4rTjJ3Z1o2dmQ4OGVraGF0VnNJMlUxQzZTM0tkMU9UMzh6?=
 =?utf-8?B?ZDRmK0Z0dVVRdkpoeUNUQU00K2F5aGVseklqQk5wK1R1ZTU1aGVsek9MSm9w?=
 =?utf-8?B?K2lJVWgrWDZrMWlEMklqSExETHNrRTFXRm1NTEhET1BXdXgxanNFK25ITkxL?=
 =?utf-8?B?Qzc5Yy80VFJ0MjBETU1aRWFzUWlRK3l5SWpvN1lhZ3VINVRRMW1hbjRBdEFF?=
 =?utf-8?B?cHVFd1JiQkM1a25WQzlPNnUvdUpBRmJRVmFVRmVyMUIxZDJwcGVOdmJ4VG9W?=
 =?utf-8?Q?Xd7yP/fJm0Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dzZzhnUC84YjE5TlUyVVBTU1Y2YlAwT2ZBbTNRM2xOYjFEUmxkS3luNWxp?=
 =?utf-8?B?VW5HWTFzVUtrZ0J4ZWFsditWMTFuVEQ0MDliMTFGNXcxVVNRRDlKZlZIck9J?=
 =?utf-8?B?dzl0V3M2TFQ2VXh3MHh4b1dIYk1DV2Rpblk2UXZtdndlZWVMTFE2M1lBYlI4?=
 =?utf-8?B?MG12Zjk1aWtKbXYwaVpwSXptaFNlTEEveFhaOWlJMEVZRU1LL1RCMkhkemFo?=
 =?utf-8?B?Y2xLZmtpSXVVWGtNaC9SWnhUNHlQcFh2bjRISmpWbzFlQVhia2NhN3ZMdjlm?=
 =?utf-8?B?Skt6dGZhTklEK01lRHJvdm9DTktVNWZGT0Q3RThVZnZ0WmV1anIxcDZrbVpI?=
 =?utf-8?B?dHBzTXFkMng4dWdEQ3ZLeHdXTkFid2NtUHhQK0hrcFpjSzQ5bkVYQ1hMS3Vs?=
 =?utf-8?B?SHpkUnpYZExrZUgwSlZodkFKaU9DcjV5VEtUSWlBWGwwVVFTUDZWYTFMOG1T?=
 =?utf-8?B?amtpbmRsR1N6RzhMMVN1czNFV29rb0hNNGhDVitERGV4QkErMWk3RDRaWm1M?=
 =?utf-8?B?U3BHeE9vemFZb2g2VzRFSmRQVU1raUZQdmlTS1U1MUgzZy9pcWZkNDkvNU05?=
 =?utf-8?B?d2NKaXlzbVlRSkJkdWRaZ3F1bzJVVlZNSXlJekI3UEplMXI2WmFZaXVNZXQr?=
 =?utf-8?B?Z01mbVJSMHhCTUNGcGxXa2VZLzhoamIvdGtvQytPN1pzQ0hyMXJPVXJ5eHJw?=
 =?utf-8?B?NitXRW43dU9YV2JWalFnTWwremNOWTJBandHMjhTSEpDclI0eVZVOGZrNTRB?=
 =?utf-8?B?WTZtOEEwZVJKTTcwOFpaZmxmYWdxMDJPUUdER1RhT3Y5MzFoaXlpOHNnc24z?=
 =?utf-8?B?N2E5bHZjRHM1TlRRM01YZ2ZmUXJwUEovWDBkV296OXJkdWVWOEhUUkh1eEo2?=
 =?utf-8?B?YWJvSitCUlZsSm80a1YwQjh0bEtmS0E3M1ZnOSs1UGxaR3JkbnVQYWpKcm1s?=
 =?utf-8?B?SjFvNGNHV1FORkRBdEd3dlZQSVJKZHlpMHJCZzJOOVh3Rms2b3A3UUlmbTd1?=
 =?utf-8?B?TktCM1dvUjlRakpUSjhKY1Q0NXExQXNWZ0lvb3VUNW52eWxJMGpmQ3dXaDhL?=
 =?utf-8?B?WTM1RzJkTzB0MjQzYmRBQmFPd0Q1S1ZWUnUxT3VIaEJGSGIrRjZ3MVpIM3cv?=
 =?utf-8?B?aHVUL1FKU2lxZHdzZDFxYnJJMjhEK2didzVxN2xOY2krL2pjQ1dQR01ZdlAw?=
 =?utf-8?B?NDZDK1RJcGhGMU1uVytRTVdTN1JicHQyeVBIOTdad2hKTnc4WjJxaHJIbnAr?=
 =?utf-8?B?cmxHemd5aVZVRExHb3NHZDRra2xsdXlHN0xRMXBUWEo2cmZoTHFZWlIwR0l4?=
 =?utf-8?B?VVcxN2drRlJnR3dGRVpwYTNXSHBkakhWbFVSTElGVHFObkZ5WTJjWlVGaVRF?=
 =?utf-8?B?N2F2Ty8zeTljNUx5WmJSeXl1VHhIVFZTbkNGSFNsb3dGenhvdjlBSXIvSUlL?=
 =?utf-8?B?ZzlGTjlaNkRkMldWa2oxZ0NiaGhNOFZOb0dJVzJLdlBZaVova3FyYXpabDZ1?=
 =?utf-8?B?MW02VVNYNHRhSmNQcnd1WGFYckdDcDBqR3R1ZkhDbFlaRGMya3ZSbEVxQ082?=
 =?utf-8?B?YzZSa09ydkttNEZaWW9kRkNJQXU3Tk93SGEyVGJlRi9NMmxQbFZKZWxUdmFE?=
 =?utf-8?B?WUIrcXozTThmb0dkdThOREhxYWZXT3RLN0FaakdNdHozYzhmQlR6RlFPdkRR?=
 =?utf-8?B?cC9oV2l4cDVuOFEyUnh5UjRlci9kV0o5b3ZaYkY2dVo0eHR2eXdCQ05Nd0Fk?=
 =?utf-8?B?eW5sTFcxVWlvQVpXK3lPbkNHRFE5aHIzZUZ4NmpHLzBEMWRZbGFYaTBSZDZM?=
 =?utf-8?B?blRuRTR2N1JJQWJlNm43MVRQd1ZKZVExLzg1WG5oN09VeTZ5SVNYTHZmZkRM?=
 =?utf-8?B?UnRDWmVuM0I5cUUwYmdyVkRnakFVSVV3RkVVemxvZlRkendQZ2UrMmw2TkF3?=
 =?utf-8?B?NlZwNVFWbkRQbXExSVlUU1hXQ3pzRm9rYlRURU1EUE96MzhvRjJ1dmlnVGQ1?=
 =?utf-8?B?cXRyUXVLaW9mVHl1Q3FLc1N1VDBFZXRYTmZ3U3MrNFhValBhY1JYTU55NkZQ?=
 =?utf-8?B?eHozQmlyOE5oT1ZDbURYSFN4b1BGdTBoWnpITlplS0JyNjRuTCtVbXVDaGpz?=
 =?utf-8?Q?EnqGe9PL1UCf5E5SqtG11e87y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69609d89-48cd-43c0-744b-08dd8779b80d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 23:58:20.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvqikggbuylfUY6kJ6Q/Jxv4kxRmBr1VfucZCMV3NK01GPAjLZ+/fgqcxfIzDD5/WhNKbfCkkcWWKEpVsqP5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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


On 2025-04-24 23:35, Shane Xiao wrote:
> If applications unmap the memory before destroying the userptr, it needs
> trigger a segfault to notify user space to correct the free sequence in
> VM debug mode.
>
> v2: Send GPU access fault to user space
> v3: Report gpu address to user space, remove unnecessary params
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d2ec4130a316..61a698056fb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2496,6 +2496,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  	struct ttm_operation_ctx ctx = { false, false };
>  	uint32_t invalid;
>  	int ret = 0;
> +	uint64_t userptr = 0;
>  
>  	mutex_lock(&process_info->notifier_lock);
>  
> @@ -2559,6 +2560,20 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			if (ret != -EFAULT)
>  				return ret;
>  
> +			/* If applications unmap memory before destroying the userptr
> +			 * from the KFD, trigger a segmentation fault in VM debug mode.
> +			 */
> +			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
> +				amdgpu_ttm_tt_get_userptr(&bo->tbo, &userptr);

Userptr is only used for printing the message. That's probably unnecessary. You should get that address from user mode as well when it handles the fault event and error or warning messages are enabled (HSAKMT_DEBUG_LEVEL=4). The kernel log doesn't need to be overly verbose. IMO it should fit on one line. It may be useful to include the PID of the offending process. E.g.

	pr_err("Pid %d unmapped memory before destroying userptr at GPU addr %llx",
	       pid_nr(process_info->pid), mem->va);

If you remove the useptr variable, the amdgpu_ttm_tt_get_userptr call and shorten pr_err messages to one line, the series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
> +				pr_err("The unmap userptr cpu address is 0x%llx, gpu address is 0x%llx\n",
> +								userptr, mem->va);
> +
> +				// Send GPU VM fault to user space
> +				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
> +								mem->va);
> +			}
> +
>  			ret = 0;
>  		}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index fecdb6794075..e54e708ed82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1177,6 +1177,25 @@ void kfd_signal_hw_exception_event(u32 pasid)
>  	kfd_unref_process(p);
>  }
>  
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p, uint64_t gpu_va)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_hsa_memory_exception_data exception_data;
> +	int i;
> +
> +	memset(&exception_data, 0, sizeof(exception_data));
> +	exception_data.va = gpu_va;
> +	exception_data.failure.NotPresent = 1;
> +
> +	// Send VM seg fault to all kfd process device
> +	for (i = 0; i < p->n_pdds; i++) {
> +		pdd = p->pdds[i];
> +		exception_data.gpu_id = pdd->user_gpu_id;
> +		kfd_evict_process_device(pdd);
> +		kfd_signal_vm_fault_event(pdd, NULL, &exception_data);
> +	}
> +}
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>  				struct kfd_vm_fault_info *info,
>  				struct kfd_hsa_memory_exception_data *data)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f6aedf69c644..8703be8077b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1507,6 +1507,8 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  int kfd_get_num_events(struct kfd_process *p);
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>  
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p, uint64_t gpu_va);
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>  				struct kfd_vm_fault_info *info,
>  				struct kfd_hsa_memory_exception_data *data);
