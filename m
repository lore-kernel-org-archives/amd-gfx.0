Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752D0C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 17:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023F210EA3A;
	Thu,  6 Jun 2024 17:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVeYZsAO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494C110EA3A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 17:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNm5UCzn41Y4/w+RC4H5/8NjEHak8TDWZtd8F5kZXC2sJ3WL+yqFppx2N2+KgLslhzBZvg+UFieS8WQv+YWK98wTO4CUYiA9EQ+o/zwdhMC2ek0YqrEH3VqetKqgQzwopT2wMbRmER66lKhxY+xpso7Gd2+f4zwyHEtqVjcD8n/zO0jxFFTSQSRKf/huU+eig82ML1KH9ohBSmIO1DLEOqit5bYQ5K+ptuT1G9l3AJoo4BMcxe8GuV8gFGamnxaS7+JOOx/yX3eZFHgV7jJzXv7JjbCAdUWxnSYQ5uYe/XkLAHjiCbi8PTuHlL4pMfIA/bD8VB4pBpKbfQncDTK2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EOOG4Oo2fugsHnLKCoWjsx/1LLTG1H8/MSduPHJcu0=;
 b=LJWz9Y1d/AGEMpvoozqxTN7YukLrB+JoDXbUIhSG+/KTE5HaqnAKcqYdj7HRBoqz+1t/iA1rZLXDHFbJTUAhoUXr3vmTOitQjtQyiwEH+oOZMv8ZX7GpSpLp2/5v0BZAcOpXGGhlZ/Ivs+Rt5JMfukCrTU6sWVkRAjb1POs2lNCPDNCwKGG/cyYB2iPAP/Vm0DS5XskJzxRpWf0FEKHtx2adZs1W/86PHxmpOeH5zQCkm+axH5tA3We+s9VdnG4r5XvxM06LQ8Di6IlIa0OPmRUMiO21XXGMFRqOCGAhDyCZVoaK3EJPsvkczmVii3JYxH3tLeKuflGcVnTOWP4mtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EOOG4Oo2fugsHnLKCoWjsx/1LLTG1H8/MSduPHJcu0=;
 b=yVeYZsAOFncCAAHKU/uoSpcEwad2huZhTSxPtLkhkaZlXK+DITXBnlYfD0yEqdVNorMn5d7qvr3MqfNfThZWJWCwQUlY+vb0ff/gJPtAVjzW4lIAM8UU5SiRNK8UFFeyKW/2BStGLfroNEicGL6DuxgPkGr3xpSAtr1QW1xs3Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Thu, 6 Jun 2024 17:28:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 17:28:44 +0000
Message-ID: <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
Date: Thu, 6 Jun 2024 22:58:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::25) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6788c804-d05f-488b-98d0-08dc864e1dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0c2WCtVbmVuY2hNMWF0ZEZRWHlPYTdjV0o3VW9Ndlh5NGpBMGtvNDV3ZCtI?=
 =?utf-8?B?S2FsVFFKTlR3TWpOOUpuNjM3cU9TaEQxV2lHSDcrckpITDJYK3hId2s1RXVr?=
 =?utf-8?B?cXE5MWhMMVYwT3U1SmxLSzBlNDRiaWt2MGM4d05sR01JY3F4VHlPQmtRQkdS?=
 =?utf-8?B?bVNPalNRQ3VwM0RNYUo0VjBrcmxjV25LblV5SXFyaGk2MUVKNzJCbWJqcHM1?=
 =?utf-8?B?cVppTmhVcEVJSCs0Ly8rakNNYWU2ZDNLWGNrTjB1UHFjcGN2REZVUjNJRkJx?=
 =?utf-8?B?ZlBhaGVseXVGWm91VFRUNHZYQjdBdzRSUnhoaUkvTVQvNWZObjJXUEZXUEFF?=
 =?utf-8?B?dXlJSXQ0ZWt6Z09KWmVLZUN4bXZmOW4vY2dtaEJnbmNUWWdWLzZEYXhQWnYw?=
 =?utf-8?B?ZlpROExmcExpZEdVb3E1QmhQcFo5OEQ0cTFNRmFldkloN2lHYnZ0RmZvSEdU?=
 =?utf-8?B?c1JyNDhGdDlDdU5OMTJjbTFBckdxQzVwZG1kOGdEUnZQZTk3bkpmL1pZZjJt?=
 =?utf-8?B?ajVHbS81ZEJrc3l2TUZtRHk4enVic3U3MGdpckh4U0VzZ0cxTUZSYTdXWjRK?=
 =?utf-8?B?bnZhZThrQmdYRm01WWxSYTVzNDJkY092NzRiVkwrWkFQOXE3dnJLWVNDRmlw?=
 =?utf-8?B?UU9ZOFB0RUFnSS9TSVlwclh6cHFXOHpvWDlBM2grOVZuMWk2ajNYY1ovcExz?=
 =?utf-8?B?dXhhTjFTVWFJUTFqR1pKYXp1cFRPN1lQajRHeE40NXJGTElvaHBBbmtySUVt?=
 =?utf-8?B?RVIrTCtGcVF4OUFYRE1oTHdxcEtETnBOd3JxVWlIQUNkOEhPckpIUlREWngw?=
 =?utf-8?B?RXl2Y1Q2SnJNc1p3NHdmYVBzNEcvK2ZIQzREVTdVdXhYMUhzbURsdU4wSUlB?=
 =?utf-8?B?dzVEWkE1NDgrKzF4dnZZNzJjaGJ6Q1c1R3RvL2szbnRoSFlzaHVEL01jdmZ2?=
 =?utf-8?B?eWpjMU9mZnZjWW5scEQ4TWNYOU41V2NEK0tDRlZSRVFUYk1nR0ZoNmdJekhl?=
 =?utf-8?B?NE5GR3VNckRnWGsyYnQ3YTRIb25hSlpmd0ZXSFo2RytabmtFbHBKU0MwaG8z?=
 =?utf-8?B?ZXVRNEtMU0hpby9LVHVTdWlTWWpqM1hKYmFJNlZNNytkaFFJaUNXWHBLQTNq?=
 =?utf-8?B?ZnBacXkzUzkxV1dHVnRuV1NMWHFNMXpTKy9ZY2IvdWgvNk1EaU1pQmIzSm9h?=
 =?utf-8?B?dnl2V2pnRWd1dm03M1dKNTErcUxLSGV0bGdZZkM1WFRaT3J2RVJxOHVDTDVZ?=
 =?utf-8?B?YjNLdzVxVE1kMU9OOVI2enVQZkRiMGJST2RTRitVR0JqRXZTR25PRmlhYllF?=
 =?utf-8?B?U1RTd0JCUnVHcUpPM0h6aFU2SlJzMFRQaHVYQ0ZMNHZmeEpHUnFSSkZNYjBM?=
 =?utf-8?B?ZjRTRm9NUkNpUW01cGpkQVhjQ1pjSWUrcU9YMlhlNStydlo3citkVUdja3NI?=
 =?utf-8?B?aVEwMHRxZ3hXS2poUnl5S1dRVW94UzYxMU8xN2VLUm5td2tLMmc5by9jM1kx?=
 =?utf-8?B?SGlFUmdpZlBFN3hud3VOT2lYa3lLaGl2QnJWSDhObDhPZFlCZmVic3ZjdXp3?=
 =?utf-8?B?SmNzdFR2Z0RyaERTUUxtUzh4V256RXFRdllyeEdUZC80WTloNk5CdlhRbnJS?=
 =?utf-8?B?THFMZHF5VG9vS3dNUmNvMTdqNkRLQXg3UEoyMHE3Vkh2TjVRVmRGRDBnbXd1?=
 =?utf-8?B?MUJaWTJHYnJtdUtkMllXRCtjcUtMWHZ1eTd0QTFOWkxIVDRjVkVIc1hOT2ZB?=
 =?utf-8?Q?ORkpmt5b7R8d6z7rwNHCW9HCAh5yHNOIPvKBEbf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXE5UTcvWW1zcjY4SWdBWk1mMC81eFhUWHgrckJmR0c2TW1OU3gwcHhqUEJK?=
 =?utf-8?B?MWRoS3pYYnlzUFVPcmorN1ptSEJyalhrS1ozeFFpbW1DN3MrUTBZbzY4M2F1?=
 =?utf-8?B?b2RWa2JENTBTUDJUZlhtRzBGS2U4WUlnSWFmWmNIQW96cmtDZ3pseXhsNXV0?=
 =?utf-8?B?KzU0R1A0Slo1RDBTcWRoSlg5bURmTU03N2Ewcit5ZXhIdE9FQjRQakptZUdh?=
 =?utf-8?B?aWJXRC9VVjIxbm1IeXRzTzl3R2N5dFA3MnFoUXJSczNvZmg3WTZZb1BuaTIr?=
 =?utf-8?B?UG5STC9vNFoyOU96cllGQzFqZGxoWTJST2J0VGZ0SG1YdWlOckQ1RnVYRDZ5?=
 =?utf-8?B?UUtPcjNhRVA4YnNzSDVmQVFqeGsraEsvVDdGeXc0YVFOMmxHRVdmZE1yVmZ5?=
 =?utf-8?B?ZUNaVWRzdFlnem9kMG1DbkI1ekRpTERxQ1h3MU5NYWtlWTh4OEpwZVhoU3Bx?=
 =?utf-8?B?VnJEYjJqblV3RTJWcm45NTBXYTFiM0xpZGN4UkxtQ2lDdVRkaVFFMXVsaFd1?=
 =?utf-8?B?RXUxaDBnbHNBSzcyd1ovcXJjUGhudzh5c2d1ZUlCYUQ4RHVzTWFISXpiNVRz?=
 =?utf-8?B?NUN3V3pmaVhqZGxHSWcyZjA1NmY3NHdoOG1NY05nekR1aGN3ejhrNHZ3YmhO?=
 =?utf-8?B?Z0lSQkNFeG8vUGErbDBEc1RBTmlUbG1WWGN5S2M4RGEvZEJBTnVtVThCSjhW?=
 =?utf-8?B?ZVRNdHFKZEc4TGZ2Rm5VNStDRTM0VWY0bXFHSkVXMnJRS3Nnd0Q3UEU1OThO?=
 =?utf-8?B?czk4cjZZTENTcUtibWJ5TU9ndDU3d0FVZXZVVFphM0d0NjlTTklEMmFCcXVu?=
 =?utf-8?B?TkJ5RW5YUDhIRzgzWFJlVmYrTitFZDJFVGt1ZDdlU0Q1YzJRZWw3OHF5NUFQ?=
 =?utf-8?B?SUdmWWNycGJ1eHYwM1lHdUU0S0dZMTZtczhONDdjWlozRjNjQmRLUXl0RVVj?=
 =?utf-8?B?OS9MN0JmbFVibUVGWmtOeW5ZMXpUdDRoR21FVXNMRzRvTkZUMTk1YTNiVSt0?=
 =?utf-8?B?VG0zbktWbEMrMjdTQk5Ha2dMQVoyRHVBSUJSWTZjWEY5d09aMUdXVmZVeWRP?=
 =?utf-8?B?c2x2UVhkeTlrMTN6M0N5OCtlOTZjazEyRUVUM0JyaU5sY0h4QVl4Qkt5QTNy?=
 =?utf-8?B?cGFLUnlDNW5VVVFPMEdyR3U4cXNYcUFjY0M5OGNjd0dWYTJCRTYyWVRnN3hQ?=
 =?utf-8?B?RUdpLzlldFpEcXR3RjlrZTRWOXVmbGtqUk1BaTNpenpBa2lpczBkZmc5NEt3?=
 =?utf-8?B?Ujd6bGZPcm9iTHlaMTRnRVdRZFE1bTYyRWxyUGIza3BxNlhvYUlTaHRJaVYr?=
 =?utf-8?B?SHZWSU9sUFJTZThSazc2dTVNZVhCcXpBSlBuTlc3ck1rV3lBWU8raU9IcldW?=
 =?utf-8?B?bEhHSUxDczBvZTRreXBCbStNQ2lTdWs2UWYycHdVOUdIcXk1c2o2OVN3bVln?=
 =?utf-8?B?MTkyZUxKeGp3UFd5bmh6TmVZT2g3TkhLeXBLajdncHg3OVMzYTJraERQTkwy?=
 =?utf-8?B?clRmUE1pWkkweHQ4RkQvM29rSmNhY040aTgrOTAzOHVzNytwRUowUis1NGw1?=
 =?utf-8?B?OGE5VEZGNzBITm9pelNWWmNYWFlIRTZBSHU0QUt1Nm00NXQwQkVxYTBZcHVW?=
 =?utf-8?B?dG03TEUvM2JhdUtRZ3JIRUtFRmdheElsNlRXSTlLRkZ2d1ljbmQrWmJjVmU5?=
 =?utf-8?B?cDhER1c3SGNsbXFFZk9VUzRBS2srWTVuMEYxWTFGbUVsdlk1T2JjMi8xcDVO?=
 =?utf-8?B?SHRhbjVPSzFUVlBTVmo1dzBmTkVQQ1BGbDh1a3NuRndRbkl3VGFzWS9QWU1n?=
 =?utf-8?B?ejBwWUcrN1NxdEZLcGpsc0s3WURxUk9ZcGFjUmoxUXYzcEx2ZGtGQjBIallX?=
 =?utf-8?B?M0dXMHI2bGlCdW1iTmEyVlhpMU1jSVVGNy94Z0dVK01UV3VUNVBmMVdzZkxm?=
 =?utf-8?B?dzB0czJWN0sxNUx3L0hWZ0YrQW9LYWZwOFJxNE03d2Rvei9Vem8rdUtLNk04?=
 =?utf-8?B?R2hObEVjaTY0RlVHZzkyRDhNTHNTRk1GQ2tiMXhiYm41ZEF1TURzOFRzT1Jj?=
 =?utf-8?B?SXhSeENNdXV4bjlaYnpSMHhhd2hGRERGa1VINXJCbjVxcWFpQ1Rva2ZGMGhD?=
 =?utf-8?Q?r02M3/b6fij5LyKoCcxkZdsmP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6788c804-d05f-488b-98d0-08dc864e1dc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:28:44.8190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMWGMAzVAcp6DkqAcKWIm5PUKY61Xc6jAcpVZGugSyCZFu2k4mvBFMdVdy28iyhy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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



On 6/6/2024 5:35 PM, Srinivasan Shanmugam wrote:
> Previously, this check was performed in the gfx_v9_4_3_sw_init function,
> and the amdgpu_gfx_sysfs_compute_init function was only called if the
> GPU was not a VF in SR-IOV mode. This is because the sysfs entries
> created by amdgpu_gfx_sysfs_compute_init are specific to compute
> partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
> mode.
> 
> By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
> function responsible for deciding whether or not to create the compute
> partition sysfs entries.
> 
> This change improves the code organization and maintainability. If in
> the future the  conditions for creating the compute partition sysfs
> entries change, we  would only need to update the
> amdgpu_gfx_sysfs_compute_init function.

This is not correct. If this has to be true, this will reside somewhere
in amdgpu_gfx and you would also need IP version inside this one. If for
a new IP version say gfx v9.4.5 this needs to be created for VF also,
then this check here won't work. This is the specific reason why we put
the conditions inside IP code.

Thanks,
Lijo

> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
>  3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 19b1817b55d7..72477a5aedca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>  static DEVICE_ATTR(available_compute_partition, 0444,
>  		   amdgpu_gfx_get_available_compute_partition, NULL);
>  
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
> -	if (r)
> -		return r;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
> +		if (r)
> +			return r;
>  
> -	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
> +		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
> +		if (r)
> +			return r;
> +	}
>  
> -	return r;
> +	return 0;
>  }
>  
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
>  {
> -	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
> -	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
> +		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
> +	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6b0416777c5b..b65c459b3aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
>  						struct amdgpu_iv_entry *entry);
>  
>  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
>  void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>  		void *ras_error_status,
>  		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index aecc2bcea145..07ce614ef282 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_compute_init(adev);
> +	if (r)
> +		return r;
>  
> -	if (!amdgpu_sriov_vf(adev))
> -		r = amdgpu_gfx_sysfs_init(adev);
> -
> -	return r;
> +	return 0;
>  }
>  
>  static int gfx_v9_4_3_sw_fini(void *handle)
> @@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>  	gfx_v9_4_3_mec_fini(adev);
>  	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>  	gfx_v9_4_3_free_microcode(adev);
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_gfx_sysfs_fini(adev);
> +	amdgpu_gfx_sysfs_compute_fini(adev);
>  
>  	return 0;
>  }
