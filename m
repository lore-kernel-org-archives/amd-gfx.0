Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1EECCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 12:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A974410E7AE;
	Wed, 29 Oct 2025 12:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTicDb9x";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1205F10E7AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 12:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5O8/GpFjLlykrMOfFriAZCIgNJnTC9l8Mc2y1pZTnRMpCL4W2Ah50C9Gj65V5nzJkUHCCX1k/w3pLxzkiq9wvOSP73AJTFg+hYF/TWio/JTBz8LCtwfbXfgwd1JBZGbPbi/XhYV9xeJLt0NFliP5G/w1noqmTfX+CtIjC9yXK5cy81JxLbZlY+RnVnalDZin2SZqpWagfZI1I1sCVsWVh18JsCSZvzbiRmzwOXUXVe2yhDaslJE9nGxDJ7lPXPaH4ZhX8I4HzBP+paqH4ZLnbsoboNrKNKVKY4Cl3gs0XYjgPbzmZhhBxv5WrVFRpmj3Hcim9gCq5Uy3afmOiD9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwjwM/Usq5MppUDmQvIQU9JC2APvGwueJDpRvbuhvZw=;
 b=IBg2yQRb01d4zVKKlN6LFHEH4yKMVHmQwiMw7oeN7+UI86wI63ivkCote2j7+LlOqZUsFOLnzqDu4xomsYFFeksvOk1HSv9HXlyIoufKxn9nOjmg88Ou9/ZAVKVPc3GefqNqhI4gEE1d4Vg+nEg025bz+SQQPyQz9V4FWQH1sx2ANLkXnbhMjfWseKcsO1V9sjDr+lwSer42hTaGpo6DSwCVRLXWX3fn7Mi5gkUbh+U55uYq6OSmNunj+sI4wV9Rlq/EjFm7IlLDNzzPyjID0ckyLsXq2eJ/fbMoTM5sdPfrQbU1pUxJrAhLjJohWUQ0dFQHqfASAD8Xaon2hAtBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwjwM/Usq5MppUDmQvIQU9JC2APvGwueJDpRvbuhvZw=;
 b=fTicDb9xDSuoPTxeiVSCE2a9Ha6zwgHKUWbv8KOOtAah1sMZLbx3rf/jlyoiq/DoNdylPOp89LTHlAHDY3qa+52D9h7cfJgvFriDHlV793etJ1zOlzhiyEjXmS1YKKqW1tDfri1NaGKJf0CZ7WhyG74YVRUnlT4Nr1fbLWRwRq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 12:02:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 12:02:05 +0000
Message-ID: <48516ce1-37ac-4278-ae35-57f641ea1efc@amd.com>
Date: Wed, 29 Oct 2025 13:02:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] drm/amdgpu/vce1: Tolerate VCE PLL timeout better
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-15-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-15-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: c76999c2-97e7-4b88-9bab-08de16e2fa71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NaYU9VZFM1NEZDMG5CeXNQVFRhL1BzWmk3N1E2NXBBNVdlQ01wVytOQmMx?=
 =?utf-8?B?ajhhU1RFWXJ5MURrUXhjaWVpcFZNOTV4SllZK2lVeU5HS3UvVjREL08vNy8z?=
 =?utf-8?B?VW9mT0lmRVFkQlVmdGN3bUM0WWFRME12SHV1UTNLQ2xSNjhFM1ZwdEYvbmVp?=
 =?utf-8?B?OXpQNFZQQS9FMTdzK0M1QXRaZXoya2lqMHVPMitDZGM5NnhaSFVoZE5raE9C?=
 =?utf-8?B?d2FTRktCL1g4UDVZNGowVXlNWVVDb01xV2NrbFg2WlRUdTlUcTA5OWVkVFRa?=
 =?utf-8?B?ZFdFeDBuRTNFRDhrL2ZMbjFGS3V6alFSR0hBQUVEOU9tNUtRUStzUTdRdXZk?=
 =?utf-8?B?Ly9ldjl0NkpvaWxqaDkvSzZDRHhFT1UvN0dxTlZJeWxlWlhHdDM5RHUyNWtI?=
 =?utf-8?B?a1E0UjhQc2k0SjNMZFc4WDlQUU02VURFVU5BQ1VsVEdML1ZmVWtOa2o1eDBR?=
 =?utf-8?B?R0MwOWFJbHNhQ0VZbG0yWmkwYlFTVnpiOWpEOUtDUnlabGcxV3JNTjVIaDl6?=
 =?utf-8?B?U05WNmJVeEJoZU1XU0szdS9YcmNXNGhaeGhYdTgwWmZRQi9uWnQwdy9zNEwz?=
 =?utf-8?B?UWFNNzZXYXd4VFdMcCt4OHBZUUhrZHpGdHNCWkxUZmFLYU80SDYvR05ESVRV?=
 =?utf-8?B?ODRMMFJSTldza2FjL0RJbENnQjhrWkxwamlUNE1LdjFoU0xiT3hMNGJ0Y3Q0?=
 =?utf-8?B?emYvalI2emlpcXoycTUyZm1SbFQveS9CbUlJLzhvdUY1QnJZK0xZSDhJN2h4?=
 =?utf-8?B?TkFQK21ndHpUNkNMZVdnYjgyWm5rLzJ5NlJNV2lON3gxZCtpU0dLcHMzemRz?=
 =?utf-8?B?SFR0TlBkdlAxM0ROeGtUN3Nldk5aN0JieWlHL3JoaFQvbVZ1V3pEbytMYmZG?=
 =?utf-8?B?NU03dUhteG01enlLQTc2NjNwZVdxd2JSK1E2K3FXR1BQNkJ2ZkdPbTlLUno5?=
 =?utf-8?B?VDYyRm43UjlqaGxCbytReUZRNnlOYWZFK2FhZFE5WDhCYld2dDNUaFNrV0RY?=
 =?utf-8?B?VkxHNm02OHBQN0w1c0loVEdtRjlYYmxjS3FaSUpSd1EwbXUwOEpPVkZZb2V3?=
 =?utf-8?B?R2Z1TWlGMjJ1c0RHb1BNMXNOUUI5TEFmdFJTRng0U0t1RHJkWUFOYzVoMGpH?=
 =?utf-8?B?NHlpcGRLOUx0ZjZXUzluUVFTeFdnd3Rrb3ZsRVVnNkMxT3hnV01LZUFPeVls?=
 =?utf-8?B?OWg1d3BNRHB3djhHVUdYS3VBWjR0SmJWcmxpS0tzYTFxN3lRWmJUTzlqKzVH?=
 =?utf-8?B?SjRRNG55bWVqTitzQ0dJa0NGRjdGcFZSQWhCdGlySjlOcUJxbFJ0MWtjVDNL?=
 =?utf-8?B?Rjl1YXIzOWxoNXhPUTlXSGxFMUlpTGFTbGhOUmowYXB3eVIvNWdvaVhhTDFI?=
 =?utf-8?B?eEJtMDNvMmNtQnd0NWxIL1cvTFE0Q2Z3V2J6RWxVVWd0WU9kSVV4S3l6bzN5?=
 =?utf-8?B?YXdtdDBON2hYUzJ1V1B4dzFZT21CbHJvdTRVNGhKeVBmVmxDcFpBYlorNW5J?=
 =?utf-8?B?cFppVEZFNVVhT3ZRdG1UWngvVFUyUmpveVFMbUFsWDVyNU5nRXJ0SnpORmdM?=
 =?utf-8?B?RDB4ZDhkeFRQNmFTYitSejYxTTR1Sytmcm00cVdDak1aVXJxT3pnQVBpRWg3?=
 =?utf-8?B?NGFQVTJVMXlYRm9RQ0QralNNSGcyUXl0WW9MbGV0aGU0Mkg4Z2pSVStGRFNK?=
 =?utf-8?B?SFNHdy96UjhIYmJyK2hwbW1RN2wyMzVyZ2J6cGdybVdHSDExYnE0ejIwYjBa?=
 =?utf-8?B?eTAyZ1AvR3ZnZ2ppMlliME1NV2NYSGtiNzNFMGVNVkN2WGhTcnpWQmhBUFNy?=
 =?utf-8?B?Q25VWTEyTkFsUit4c1pjSVgvKy9VM3ZxRnBTbmcrd0M1Z0JSakF3UVBsS1h6?=
 =?utf-8?B?eGVoakx6RzRtYWRWN01INVJiSlhtMDZuQVJzUEE0V3RLdFh5c3ZTbGZnVFpx?=
 =?utf-8?Q?XjJWwm9lpCklSOQ54PA/sITSGAAuWgS7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpOUEx5TFF5aFhqSmRpdXVyMGNwS0dVZ0RQYTIwT0cvVlg5UXFCajlXbE1H?=
 =?utf-8?B?dHFCblZ4MHF5R3IzWmFHTWxKbU1yb3VoZ2NRMW55MVVEYWtsaG01UFhzUDh4?=
 =?utf-8?B?a2NGczIyc3BVM1ZPTFkzaEpXd1p2TXB3dlVYYXlaaVlUOVBrcFZFSkREMk5U?=
 =?utf-8?B?VXFwdDdCV0lZMVIrM1krRTVBOGhGclVyQWZlemlUbi9QMFp2bnNPMjcvcmZy?=
 =?utf-8?B?ZmI4VzRpQXJxcDJhRk5BRlhXNnB5eWV1S2NLQ3E2aEhkNmxWd1VpRUl3anNa?=
 =?utf-8?B?anVQR0picGhPak41SHZReUdsK2VMTnV4SHkrckVmZXkyRWdZT0FVZVVORWpV?=
 =?utf-8?B?bVZOdkc2Mk1zYStGUHBOS04yMUJ2eHN2RTFGK2xscDVtb3Nod0VrQ3V4cUtO?=
 =?utf-8?B?cUNPWmZNZWR4YnpUYXlOS3J5RjNKT1E4V2V6dUZjVVQ4R1VKMy9NcGVRVElV?=
 =?utf-8?B?b3dkNVgwaGJJbkVVNXltcCtUaXMzM3pEaXZkOUE0bGwxdzRPY3VlTUQyL3VH?=
 =?utf-8?B?ZCsxVVZCdHZBYWJuQ1p4NVZSODkzT3g0YVhEQWkxYVFiTUhBRVNLazNGUktz?=
 =?utf-8?B?ZWZoS1pKbnRiaXoxVXpNUS9xK2hyWFBLUlQxVUtaeWduNDQrU2ZpeklGblcz?=
 =?utf-8?B?MFJ1K0lBbzF6VWFVSkJWWlU1L3FzckdDbEpySG5qVzNVS3hrQ1dCWjlGQXp5?=
 =?utf-8?B?RjBRcEpjK1lzbDQzT2gyYTRLQ2tKYUEwaUlFVXgrNW1adWhuMlZoRzg5aUxD?=
 =?utf-8?B?NHpUU1pzRUxNRW1lcmdiZjBKU3B6NzJxbEY0SVdUTmdETHp3aDR2TWNkNGpt?=
 =?utf-8?B?QUV3UEVpYVFTYjZyYUVJSjNuaTY5d0c5a3ROajEvRHhqajdNNVI0VUlRZzRE?=
 =?utf-8?B?bXVaZ0FJSzhSRHpmN1Z5OTNieGFCZzFSaWhocHFJOE96N3pmb0pCTkJWWWcw?=
 =?utf-8?B?N2xVWmQ5TkJPaFVlWXVQdkxYVFNZcVBpTDFoN0RtZ0Zac2I0VVNEK3RGcHJH?=
 =?utf-8?B?TnEvOE54OGtVNkE4bHJKQ3dRdDNqOUVKTlJBcUxnZHRsRzZJSU11aU1PVnBC?=
 =?utf-8?B?OFNleFFxRFlkN1B4RFRIYWRnOU5xZDRYVUNYOGJZRERzb2VJb2hNMVNQcjJj?=
 =?utf-8?B?cXFVU1QzWnd0elFQS3hyb2ZCMWlocmFKcTlkbjNkLzhWZWxlemFvbjlocWp2?=
 =?utf-8?B?UTN1cy8zRUhOQVhDcG9ETXlDR09wSkxwY3NtTVJSeFlVNEp2UnpkTGVIazdn?=
 =?utf-8?B?MmZlMCszM2syeXBMMW9ncGdlczFJMDc0QVM4UUdTb3ZoaFkvYTdEa1VvbjJW?=
 =?utf-8?B?Yk05UnRLWjQ0UkZsTFRzdVgwSXVrSHpETk1yNzdTL1B3ZWI5bXZ3SlJzcm9R?=
 =?utf-8?B?N05rUk5wd0Yrc3BKVWV5dnR0ajZkSnliUEV6UEU4ZytGQUNUSkd0N3U2RnM3?=
 =?utf-8?B?ejlZbFQ3dUd5Qzg5TWxTVmZPRVQxTUx0Rm0xdnRlTjJjdGMva3VNNWhvRHpl?=
 =?utf-8?B?SG9YU1AwSE80dHVUNktaSDFIUVRmRGJoNjVzd1h2SUkwRUplMFAxRXVhYUtr?=
 =?utf-8?B?MGUwM2dQb3RZQS9ZajAvTWwvUTQ1Sjlkb2xwQWgwWmdwbERtNExSTkJDZEsw?=
 =?utf-8?B?KzMydXRzaWZnQXJ3MmdBeHZkUHRtRU5UalhHTUI2cE5oQ21tdlFjRkdGZGRN?=
 =?utf-8?B?a2RjQjBiT1laZitKb1lwVHZ1TjRoZ1FYSFZoT1ZPR1p4UDEvZlF0anRpK081?=
 =?utf-8?B?UDA4U2FOa1FFQ3hxcnlCMm0rYVV6MnZPVTVjOXhHU1hNQmtvbk02ZnpuRitk?=
 =?utf-8?B?T1E4NDRnQktGYWkrNk5kTUMrM3JlWG9Ka0R3d25FcitsaDI2TmRlMjdpKzRS?=
 =?utf-8?B?ZzY2Tkh0VFo4c1dSSzRxeWd0T1Ric1R2Ri9SZXlUVytZdXNmUWxhM0phWkFB?=
 =?utf-8?B?ZnNENGQzL3p1VWlWcXcyRjNZRGwxTWlxM3dMcXhWM0VaQzJBUzlZVGpBOVBt?=
 =?utf-8?B?Rk1VWWxIdUJGU2R1cERSY1FlWFFtektkZXUvSHVXZk1OTmtMTzY5Y2tVbFNj?=
 =?utf-8?B?SGtrUXFybUNCRHhyUGRiczBCdVZqamptN3pxV2VyQ3dJZGxVWUJxSk1MMFBm?=
 =?utf-8?Q?YGJ1fLKEPEjHhnWv2Mj+YARCu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76999c2-97e7-4b88-9bab-08de16e2fa71
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:02:05.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imJQ5BBgZlD9Y16Wtp+hu/cO+CXdL8We9N1fo4DiWstgya4O9ZiEwwEos/MmBhzk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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
> Sometimes the VCE PLL times out while we are programming it.
> When it happens, the VCE still works, but much slower.
> Observed on some Tahiti boards, but not all:
> - FirePro W9000 has the issue
> - Radeon R9 280X not affected
> - Radeon HD 7990 not affected
> 
> Continue the complete VCE PLL programming sequence even when
> it timed out. With this, the VCE will work fine and faster
> after the timeout happened.

Mhm, interesting. No idea what could be causing this.

Not sure if just ignoring the error is ok or not. @Alex?

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c       |  6 +-----
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index f7b35b860ba3..ed3d4f9bf9d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1902,7 +1902,7 @@ static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
>  	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
>  
>  	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> -		DRM_ERROR("Timeout setting VCE clocks!\n");
> +		DRM_WARN("Timeout setting VCE clocks!\n");
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -1954,8 +1954,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>  	mdelay(1);
>  
>  	r = si_vce_send_vcepll_ctlreq(adev);
> -	if (r)
> -		return r;
>  
>  	/* Assert VCEPLL_RESET again */
>  	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
> @@ -1988,8 +1986,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>  	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
>  
>  	r = si_vce_send_vcepll_ctlreq(adev);
> -	if (r)
> -		return r;
>  
>  	/* Switch VCLK and DCLK selection */
>  	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 27f70146293d..fdc455797258 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -401,7 +401,7 @@ static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  static int vce_v1_0_start(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring;
> -	int r;
> +	int r, i;
>  
>  	WREG32_P(mmVCE_STATUS, 1, ~1);
>  
> @@ -443,6 +443,14 @@ static int vce_v1_0_start(struct amdgpu_device *adev)
>  	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy. */
>  	WREG32(mmVCE_STATUS, 0);
>  
> +	/* Wait for VCE_STATUS to actually clear.
> +	 * This helps when there was a timeout setting the VCE clocks.
> +	 */
> +	for (i = 0; i < adev->usec_timeout && RREG32(mmVCE_STATUS); ++i) {
> +		udelay(1);
> +		WREG32(mmVCE_STATUS, 0);
> +	}
> +
>  	if (r) {
>  		dev_err(adev->dev, "VCE not responding, giving up!!!\n");
>  		return r;

