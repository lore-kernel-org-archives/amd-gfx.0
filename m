Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38243C369A4
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6EE10E655;
	Tue,  8 Apr 2025 13:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVWoyDnx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FE410E655
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 13:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9FPPj+gsD9T8TQaPS46lNl3C/LTRQH5nkuOuqg/h4dkzmn7THfRAUilMTTqmf2naedMbmBhPn+Kquy3vowDC0t0gxIsFSudW0cCPz4lgSpgdPI8cIFvG6XOWo6ru25/AtW602lBUOw3yTcOsG5YB3GUsNMBKhoKl3UAwO3mowIGwHLrGwI0viRULdqKi87IjqvmIAPQEK/Ck6D9Xg+ymO5nS/yH7ofhifgeKw5BH9TCa3H/jko+wZ5ChSdTwNJG5YLwqdW8fvkZX0VY4sn1kRpG6VeGgZx0etiwfrUSrtqRRqAumPrkqBWmub32MjrE/tgFfEMpXCrRtg0g57aV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZv1Dn3oQ62lED2I/Tb7PWNH4x7ODfb3NvcOVJ3T0f0=;
 b=QtVwsfr61OWeRJSrc/iwoNJwwuw0dm2vrnC/pyfWTg0SbJp9yurHPOMOeVzpAbYUJL3PwjGJhNxfB0K+P1Cqy9XlR2CArsYjozRdze4RfP9CMVhlmGkJCUXAqURK7n82iojcpXiZVa/HzbjjLLb/S55v/m6CnwOFUtlT5Hd2qCmpKupadRNivhyn/QS9DscQLFqh4j9Kx1GdQkxUKkDxt2wgbm22jfHOyB6vuOdMBayuvqFdgPK28mi/9F2jPtOOmrzdcsnjY07XkUpW2vqcUJMwJVl72tLJL+oUw8oO+DzSGr2rLD5rQ7DeWsSdy3Ia0nzeVqpMTT4Q672EfBvAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZv1Dn3oQ62lED2I/Tb7PWNH4x7ODfb3NvcOVJ3T0f0=;
 b=xVWoyDnxxNddu3b+FtbN/4uSxXkR/BLrYBmVWbUgjhUtu+1tCxyS/ebxcl4tZaInBfoTGtzymPSnTnyzGt8OSdtHAKFZFhvObEhOayCnF8j23GGnGfF0QoOTJ6uxx51r3wW0bh4QRwOXYWBpSA2diahYZaafued9Fz10uMUL6IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 13:07:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 13:07:04 +0000
Message-ID: <a910756a-179f-4668-9c74-217c22b99b58@amd.com>
Date: Tue, 8 Apr 2025 15:07:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: add pid and name of the process with
 userq manager
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250408124150.950175-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250408124150.950175-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3dec7a-e5e4-4bf8-0f91-08dd769e41ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2djWlU3VTAzUzA5NGdXdlRUNldoK0xnY05zYlo5OWJHeUFhR1FKRyt0aUtC?=
 =?utf-8?B?Q2NQQm10eTB4d0RucVZjNisrdlR2V3VxUCs0eTJtOGRFN01hU2JPTSs4RStN?=
 =?utf-8?B?SnV0b1FPdjNJbUJjVWorTHlJYUpjRXpZUzkrUUhSVmdNUlY5dHI1aE5PWHdQ?=
 =?utf-8?B?RHRIT2RLa1RwM09ReUhMZWVTNWNRVnFWRWZuVlk1WXJpem90TjBDOU1kVGlU?=
 =?utf-8?B?bThpdzBWY0dWS1pvWUdCdWczNE9rME5xNHc0S2pwSERCZ3JlbnZBeUI0Q1F3?=
 =?utf-8?B?bFlrZGhXa1hBZytYeGlhTmJmV0VhU3FVUk1WZk0yajd5enJYSzFkRlRJQ0gy?=
 =?utf-8?B?TjNsZHJPVHJ5RHdGbkUrQXhUckdHMnBsNHhZQW5mV2VGenJ0dDRJZTRDTE8w?=
 =?utf-8?B?N0N0SlAzTFZ2alBHdUtFZzE0SGxCRjZ5c1ZtenJQUndlaUpKek1JUkgwMmdD?=
 =?utf-8?B?bVhBZ3IvWnAwaTFwNHNuVzNrZWFHemFwYnlXRm1UejBLWE9IUUVvQVFaM1Yz?=
 =?utf-8?B?NHZNb2NwOXFOaVRKRnMyVjl3ZVFrOUQ5cWpVVDYvWTA1eTVDYzRXTisvOC90?=
 =?utf-8?B?N3RLdXU0bWNFb0lXZW02YXVOM0RFOFIwTDdiY3ZjcDhvMXJZaG92eFVaVUk2?=
 =?utf-8?B?RlplQmJrMG5BVm91SFdOWWpreFJUbmFVVGlEQlNHb28zcDhacDh5L3YwKzZN?=
 =?utf-8?B?L0lqSW5IN2Y0RmJGMnNNR0I3K1NUMk1LR0RTTkx1Snk3clBvL1o4MVZud1dF?=
 =?utf-8?B?ZHpaQzNKRkFDV0lrU1B0bTZ5ODBxaGowMm5sdmZva1JmTXZ3aUlaMFR0UWIv?=
 =?utf-8?B?NjVTNVUrYjZUQ3JNV3RMRGtZc25mY1BvNlZNU0VaWklJc09zRXBDY3VLQS9H?=
 =?utf-8?B?WG55bzA3OWt2NzRtckJHQndEbVMvc0lsckNNdWRDRWtnTUxsQkFMMTM2WktN?=
 =?utf-8?B?MzBORzhGRUJGMVhLbGFMckxsTlBWYWNKWXBwZ2hXSjJqbjBWYXpsRVRmbkZi?=
 =?utf-8?B?ajdXbHdtMnpKZ25VR1lVaEtQU2gxdEJHZEY1M0pYRU1MTEQyN0t4bDd5SHU0?=
 =?utf-8?B?N3JOTk8zOVVqVCt6bWxLcVJodUgraWM1MCtjMFRycytIbVk1ODJHVVI5QlF0?=
 =?utf-8?B?RmU2ME5xd2tOTGtUelpoVGFRMmh2eWg2K1JUZUdVU0RQc3VJTU5SUHM4SWVy?=
 =?utf-8?B?SGJKalUrSGc4R1JpSDlydjJXbm56aTQ2SmpESHA1OHFUWVIzOU11K3ZwTWRS?=
 =?utf-8?B?UkorUHNaNUMwRE9SZis1emlCTnlaOWpqMStmbFFnTjgvZGdBbjNITmZaanFw?=
 =?utf-8?B?N00yV0J1Wk1uZExDOGtQWG40TzNDVlEvTXI1SW4wSmQrbG5JZzRaNHZmQ0dz?=
 =?utf-8?B?WmprQ3YrSDUyUWtpNmhaNEpjWWlRcW53eEp0dS9HZnhGNFMyRVFHUGYyakxm?=
 =?utf-8?B?ZFR5NUgxc3JSNk9TMGdmUUsvbW9tc3A5TU5SRkVKYlB5Y2RMWTV1LytoRk81?=
 =?utf-8?B?ekpqT2ZBK29mOG1OQ01tdnV3N1NzTEFFTUFTaityUVZNS25ocEVzZHdISlNx?=
 =?utf-8?B?VjkvclYrSXpVUEFVUTJvUDJKMDRmNW1tWVptSTYwc1hNNW9xNnJ0QlhWekNj?=
 =?utf-8?B?dkJBUDRFcEt3M0lCaHUvTDladUtBYWtEV21DUkNhb3pqVUhUYTFHN1k3WFB6?=
 =?utf-8?B?U1NRVGVsUTNmdk12MEFZMnVWQ0NrUnQxS08vVGJFRDl1eWJiKzB5b1k4aVlU?=
 =?utf-8?B?L3JTdXNiYlkvYnFJWFZuU1lVS0NXRkk0VzdDQ2p6QnV1TkVNcmF4a05sd0NE?=
 =?utf-8?B?bUxhbWZ6UU50SG40YzJ3MXhrUUVqaFltbENhK1NjNWpjSlB1cTlyMmRMOHFS?=
 =?utf-8?Q?PlchLItksQjUn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZTZ0t6MVUvcHNJOFRRekNUVlluTDRJNm84a1ExSzNjMUJaenc0V0Z2SnV1?=
 =?utf-8?B?UzV1S2UwVlcxdGlpcU1vOGVLSGRxanE2S090VmZLQmkzSzBJTUFra254S3hv?=
 =?utf-8?B?ZllJSkxXQ3lqSWJMSlhQK1hRbFdDejdXTTV4cFkrU01wWFB4OTY3ZFI4ZmI0?=
 =?utf-8?B?NmljSmhkTXRmdVBndDJLeTFXQkN3TkNlNlN0ajliRGpLalI5ZE52d0ZSK0pD?=
 =?utf-8?B?MXFmNlJLY0k3c01EY1BFRUpDSzlQaTRVODJSbU91RkFTMU9vcDY0NWtVSVcv?=
 =?utf-8?B?U1VGc2hya0hDTzB6SUZ1aUtzYUpTK05ob0xYdFlxNFBQWXQ1a3VCdVlmTEJz?=
 =?utf-8?B?ZTk2YzZIbHJCclMwYk1sOVUvODRWNkJhdm0zQlc5THVsditFbnRWVlRLUjdJ?=
 =?utf-8?B?ek9vdDhVdzhnR0YvbjZYWTlLTWlncEl1U0lzUS9KMzVUVTVCbVl1V3IvdEZW?=
 =?utf-8?B?Q2l5Nzl0K1pPRkx5NlZVRis1ZjVOUUZDVzJaZ3VlSVpSdU1ab1Njd1BiS29k?=
 =?utf-8?B?MUZHMUVZb3FxcHVhOEtQNGhsK3FvU2tjWmtScTUyYkZPM3l6ZGZ3Uno1MDZi?=
 =?utf-8?B?UWNnMGgwdTBBdkc5OEJRSVdjcmxmS0ExYXltY1NNN2k1MWM0am9ta0FLMzQ3?=
 =?utf-8?B?Qi9ocmN2MHhZNU41dXZWQ2I1RFgydDJ5cUt2ZjZ6N0VQRlhXWnY1QWMzZGlP?=
 =?utf-8?B?RVFDM3Avd3BYRmFubWx4KzR6RkJ4NEdNWlFlNlY5NkVxMTJURi9hRjZ4WXAx?=
 =?utf-8?B?TnRtRVNURUhCTG9MV1hjZEEva0hWaXFjNXJNdXUxdTJYKzVKaUQyQkExUk5H?=
 =?utf-8?B?Zmp2WjJwTUNGMTdBT1FwWTcxS3lwSkI5TEFnUUNxNE9jdVA3eFRDYmVYSlEy?=
 =?utf-8?B?L05CNC9WL0czWWFwOUQxSHdtVzRxb3Z5Vy90b1J3cnBLbEU0RFQ3T2t3ZVBp?=
 =?utf-8?B?NFQwbWVnd1l1TW9XNDMzQ2xYT2xxZytMZ1VqQ1U3ZmdQNm82YmNYTkNPekpB?=
 =?utf-8?B?eWM4RmJpRmJSVlRqaW50TnJhMktYbUpzUWZpendjanlMbWIwN0NpdmtVUjA4?=
 =?utf-8?B?UVk4TmFhNkJ5cTlZYkIzM0JMUExGUWNxNVdKMDVFQ09HQnZrdFA2a0dhODQw?=
 =?utf-8?B?emhpZ2s3QnFmTFFlZ3d3THJDdTBGdDNZK3I2K1IxajdBWmJ5bFpwKzFYd3I1?=
 =?utf-8?B?Y1ZYanlsZktwKysxRldIZktlVmJ6bm5GQUduSUhsaWN2bm9pc1k3akZtZmpo?=
 =?utf-8?B?c0ZoZ0FQa0pRR3NFMGdBZVVuMmJmMTRFUjhmSHN6bGRPMjQ1UjFDMEsxTlpX?=
 =?utf-8?B?ck9RcGR6YUwzeHRnUGdOMHU1NXNtVVBueFRKUkNza1JXcy8zSHc3eEhBM3Jn?=
 =?utf-8?B?aWpmTlZLV3pBTGpVeWV3dTRoNUVWbUdSQXRndEIvcU9OL1BIMFJTVlkyNjJx?=
 =?utf-8?B?RmlLa0UzWnpZZFEybEZoV0h5Q2NneUJzdXhrbXRhdlAvSXZNci9sdVJUSHRS?=
 =?utf-8?B?U3R4SE83QzZMaGsvU0pON0thY0MrKzcrUlBOcnU3NGJKRFVuWEhKbmpGczVs?=
 =?utf-8?B?WCtIQi9selp4cVYzalZ4QTBjWFVIelR6bkdSNWVSZEZIamgrMC84NjZuOWxM?=
 =?utf-8?B?MUJyTzdGZ3JsYUR2MmVHR1BlQmUveFpoejlRYmdVRDdaNDlTSi9RYzlUaGFI?=
 =?utf-8?B?N0V5dW10cU1sWVA0bnFBcklCT1FGSFZVNkdpdVFxTVFvVEpMbmlhWTUvNmZJ?=
 =?utf-8?B?YVFYRFY4ZEFNZFJRTDJBR3dLWUxxTGdEZDU1cS82ZXVKOFNmU2hlOWRrS2p5?=
 =?utf-8?B?YUQ2N3FRSjJ6L2pKb0paZ2dzVkYxc2RWcmdsMFpzbHRYSi8rcjk3NU5ETjcr?=
 =?utf-8?B?MzYyY1VsaUg2NnkxeHY5dEcxVFpnUFdvRlRYd09iSjFPVVcxK0pwWnk0c003?=
 =?utf-8?B?Z3NuRy92eCt3SXB4RWszUEVoNHFGMU1aOUJycFY5QWhuWlBYVzYxSEhoYzFm?=
 =?utf-8?B?M0l0clU3T3Jqd3QvYXloeSs5VjhKMTBBUDBaOHYzeFNHaTdpZy8xbS9XS3Ni?=
 =?utf-8?B?YVd4YVZqenlDaTFyZXMzUlEyTnZLSW53QjY5WkdqdFRVa25QNEMrQUpvWmti?=
 =?utf-8?Q?FcDlvRzZQkkVRqbdERpzpVYtC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3dec7a-e5e4-4bf8-0f91-08dd769e41ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:07:04.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elNJHlx6WlYOxorNx3kc0/uUPWIJNXsZjQZM6MYJ778UFsGRBsNEtAjO52YEfxpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

Am 08.04.25 um 14:41 schrieb Sunil Khatri:
> Add the pid and the process name of the process
> with the userq manager which could be used in
> debugging and understanding error messages better.

That should be unnecessary.

We already have that in the DRM file as well as the VM which is also updated when the fd moves from the X server to the client.

Regards,
Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4262c320ad1d..f73bcca35287 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1357,6 +1357,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv;
> +	struct task_struct *task;
>  	int r, pasid;
>  
>  	/* Ensure IB tests are run on ring */
> @@ -1426,6 +1427,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
> +	task = get_pid_task(rcu_access_pointer(file_priv->pid), PIDTYPE_PID);
> +	if (task) {
> +		fpriv->userq_mgr.pid = task->pid;
> +		fpriv->userq_mgr.process_name = kstrdup(task->comm, GFP_KERNEL);
> +		put_task_struct(task);
> +	}
> +
>  	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>  	if (r)
>  		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index ec1a4ca6f632..a495b24165f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -77,6 +77,8 @@ struct amdgpu_userq_mgr {
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct list_head		list;
> +	pid_t				pid;
> +	char				*process_name;
>  };
>  
>  struct amdgpu_db_info {

