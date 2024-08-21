Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648D4C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 10:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112D310E5CF;
	Wed, 21 Aug 2024 10:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xnl60gMI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6B610E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 10:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xH12KtpSUkNasD/tMPz8gobOPFgCDNnxgE0kGzv5/pfcP+pZiT6q0joeRDvd9OelkGHAjPkr/KJ/aNzj/GB7DfFNkd8zOJnetn6lKFIYe/LTxve1JL7bG+ECJzW9bSVPl0gUQl8i1cPJsvThWOoRfaBEA/jw65LwZvzFgeAQ7Yjnp34MuI4f32NxG6GLMXsq1ElfnxFI/OVOHD7VaAT7pZNINeLJByCfrVOJeUqTgXXjmATyHys2oaP28d/NheO8RDM8fZ9qX7m53zASY+Dn4VrxeWpmExq9bl6Yd3sCWWtUwChIfnHxZpA+1rylnY49o1l7E8M5LPm3aWiIdF8CpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcUPU7T4/y+JNg9cAqq/FthSWsptqVrZP87jjIhiQ7E=;
 b=NJnIUNrylj2TitdVSjnOnJqr11wWf6BcGQD1TN9AOV7gRmqN93CZz5DfGG+YdQdtDYsN+7JNfksRKiACNiNpRl7bbpGDVOxzsufmYYg0rRS1AP4sQFBHYT0pAqMncTvwsTIzaXH9ybxSqyNGPsvYa8st5IMRonQGZKwqUoFf+PYM8VcTR5J99loHhxpnHzI50PIGKz+AzpY0Rn9D7BIVDdc2L4w/OGnIqnYi2qME1vIv32ow+nIHJ2piIqebFJp74ClAexP0nVK3ey1FQNTqzWwjcg5sj7sj8gyAELeGCqM3m595kfBLTShqa91NKDUrKcr7xcyjSr8CMh8xuzRj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcUPU7T4/y+JNg9cAqq/FthSWsptqVrZP87jjIhiQ7E=;
 b=Xnl60gMIYREOWJUN3v2WSJmk5W1vfYxdM5/m/KeNCFZlTIEPGk24QkDLffh1wI+tPzrmRZOBc5M30/La1g2UIO3kV5nHxkaMvteZOrR6Ur5Vl4w+/utr01S0H/DuLurcNhdqfDKiMusw459srKLdTVDa59rpicsHkx1y+mGBEF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Wed, 21 Aug
 2024 10:02:14 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::1f77:f353:36cc:ca6c]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::1f77:f353:36cc:ca6c%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 10:02:13 +0000
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: Trigger.Huang@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240821083841.477392-1-Trigger.Huang@amd.com>
 <20240821083841.477392-3-Trigger.Huang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <16208ed2-e049-9fe3-74ef-81048b4d0ea1@amd.com>
Date: Wed, 21 Aug 2024 15:32:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240821083841.477392-3-Trigger.Huang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------2ED90B38453EC37B7F07CF0A"
Content-Language: en-US
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3957:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b80072-d153-4a20-b6bd-08dcc1c8543e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnZDMUM5bXFCb1hDY3RacUJzWHBUV2p4QVhJb280eUlPbVg1bVBWbzRkekg4?=
 =?utf-8?B?OVQ3aStsMnRTcnFBNjduazMrSDBIV2Y4NkVZaU95ajZaSCtZZzkrYUVwQU45?=
 =?utf-8?B?LzRLQVpsaEF3MVhoUmdRcjZFd05yNkJiZk9mZ1FQVXQ5NGZRU3NGL21jMTZr?=
 =?utf-8?B?bWZmaHBmSXZPell4UzYxeEQ2WHhSTk83NER6MzRNV3d0VWoxV3k1WHVGWVhx?=
 =?utf-8?B?ODRVYkJ2elhtOHVKRXJSYTgxQ21SendKaUpRakoxU3Rpdzh2RWxvbVhDc3JU?=
 =?utf-8?B?bE5KVERxNldtRURwUkZFMnNtOWx5Q3dUY1VGTFl5TEpoYUwxbGRRMVVCK3lk?=
 =?utf-8?B?SmVZb3ROQUs0Q1JQUlhxYWVUOG9uVGhKbVNiaW5GOVo1a1NzclFwVnBqbGN5?=
 =?utf-8?B?V0RNWGVIbTJoZlpMZm1FK2d3bFhyV0ZaVXl3akp0ZWc2Qm1waUFXMTBmRHZW?=
 =?utf-8?B?WndvMldEbGxrQm5BZG9zcTR5QW9vWmN5WDZpUVlJQjdpZGxTVXo5akJJTFZk?=
 =?utf-8?B?QVNOUDI2QVptMDdjRUZJOC9Ldm9ZY25iV0hMc2p0SzNQYTdjY1FtUDVkcnVi?=
 =?utf-8?B?QkZMVkRySFZBUnJFVTdlTzBBOStGbk9rRkJlUDVsTE4yaUd4azFhRllXUkQ0?=
 =?utf-8?B?TUhnRjVmQzY1YThNdndVT3dqV1FyYVRwRGpsSVowK0hFWXRxRFQvQjVMbjlp?=
 =?utf-8?B?eDhVWFU5SFFqWlRDTW91aTNrQUpsck9Id0dDNUtuMTEwK2h5RENtZzV6VmJo?=
 =?utf-8?B?K3R4UXJHSWxZTTUwdnhNK1pFWGkrRFFWWXRjL3RyVGxKTEs3Z2ZlcW9SVGhr?=
 =?utf-8?B?alB1M1lLbVhhNnd3SStDSkRPYUk2MWV1WWY5UU5TWVRoRFdERTZ4Z3pyc1dX?=
 =?utf-8?B?MlR3bG80a3Y2Y09qcDVpY1hJYlRCUFJWaFNWZkptK2MvS3lTS29VTnkxTlN1?=
 =?utf-8?B?aVJCVy9vZlZEeEFFTkx1c1dvUlRrcEE0alVxRnNXckwrS0pIVW91aG5xQ0FL?=
 =?utf-8?B?RUtuQThqb0NYbENENDRzelZkbTJhTzhQOFRRQ3dJZURIUmxKWmNPOFNnU0Fl?=
 =?utf-8?B?dk96a1dRUGM3SndFT2ZzMENmNms1RFJacFNZMWxVOXlnWkRKZ2o2a245VHNR?=
 =?utf-8?B?SWx6czhEYkhiNXI3aDNZL0ZOL0V4RVJNTll2MUhXYzFKSU1ENlY2dW1JUEFN?=
 =?utf-8?B?UW5Ub2hKRmNieVY3MjBJVWF3Y2NLbWtHWXNJTFlVVGlMa2p6VTlBNEFLOVFL?=
 =?utf-8?B?MmZwMEFNQ3JZclRVa0lMYXpaNTJzY2dEU1M0d3YvOVI2MjRabWJQdnkvQjV2?=
 =?utf-8?B?SDZSdXVqNW9kNGlyTzJUTkhJQjZNQWpvRTBkaGVWcTFJQ2s5KzA4Rnp5Z1c0?=
 =?utf-8?B?TnVLdktvaTlac1NQdVVLbEVyZDF1eGtDNSs3NlV6WE1aN0dTMlRGTUNGdFJ1?=
 =?utf-8?B?ZG56WlluWVFEc2htUVdhdnZMTTVOY0pSbGRkby8yVUlobjVkTzdSWjFDbDhW?=
 =?utf-8?B?U0pWTEdnWWRuY0crNzRxVjdBSmhRZEpFc0pWWEJxdTB5OE1JbkMzMktmRWlz?=
 =?utf-8?B?dmQ0WVdTejMxcGZqVE5KcFhSbVdTUHMyemlrb2RGaFVSZDRqazVJOERyVHBz?=
 =?utf-8?B?NUxkT0dSajQxVU83QitFUEtCc1dJdHk1THgrMVhiZVZNNlN0Z1JlbkRhVXVF?=
 =?utf-8?B?OEs4b1FSaGpJeitTazgvRjNtQkM4cit1L2NHbTJTMnFzZ3JiUEhJKzZGTnQr?=
 =?utf-8?B?TG9ZRm9QMzUvWU1UMEhBNHdDQnNoL1V1WXZPNW55UXFzNWY2TnVLSWlSQTEy?=
 =?utf-8?B?VDU3UjkwODlaSWdDdlNVUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERpUnZoeis1S3VRa1QrTTJNMUpKLzI0OW9DejhQNzJwdEZlekNDTWRrYVdT?=
 =?utf-8?B?aVkvT0dBclh0dmE1WmEwUk9JUmRGODNZTkduTEZmSlVsZnZGditJQk5QYmY3?=
 =?utf-8?B?ZUliazVweTJVcDdRcmpYR0VIOHdsTnRzOWxnOWlHS0RyOVdxS3U1bVlIWHpu?=
 =?utf-8?B?ZGh6dG5oUlo2L3g2ZDlncnJFL3hHS3Y1RTdEUWhKNjRRRGRSbnk5REcrUllz?=
 =?utf-8?B?b2hkbGYzT3JpeVY4NW1HdnZCdlRUQ3JIZUVOQ3BpOXVhNGgzTURvUi9OaUli?=
 =?utf-8?B?REZmcTE5dTdoZ1BQMzBsQWZiME5UdmpaSGJyUWU4Q0VtaDM0U2l5ODUyckxZ?=
 =?utf-8?B?L3cxc1pIaWNxV2JnNCsySFhZZXFmdHVaL1JzNTQvS1hPbzZuNUlZelM2Um1Z?=
 =?utf-8?B?YllLUGpGSlMzcGxNMTg5SU43bUFYcnpmbkwxOTRBci9sYzJ5QjFmcjhqUjRi?=
 =?utf-8?B?VmxHOWp6UUVnZjdnVEJGeVBKZWdYcnRPQVJyZmhHelpuTkc4SHJIcm9pT09Y?=
 =?utf-8?B?VGdGMHhmZE81eVIwdUdCT2I4WFhFSjFsWWZSOTNkazk5WWZDd1hnMllwN09z?=
 =?utf-8?B?SW9PNlNSbG5WNS8vM0hVb1NsVWhJQVlYRS9VaDN4THJJWGpDSEgzVlkzTThG?=
 =?utf-8?B?a3BSY2tvOG03a21BTFZwQUtYdEtmTDZlTkxnKzE1VndoZVpwVW9wVnVFMVR0?=
 =?utf-8?B?Y2NPUG9yZmMrN3k2NmdiTjAwZzdZUXorMDdpaml4S1Y1V2MveDdBM2R2akxB?=
 =?utf-8?B?cFZPZWsvSGw3aERKS3VPbWZSL0g5dkE0WFhha0h6ODdBcUJWWStIRU5rNzkr?=
 =?utf-8?B?TUdEWTZJVmhDSU80RkVHclJDQ2Y2ZnpZK1pxanErQWhtUTFHS1J6L3h1cUlt?=
 =?utf-8?B?OENQRkMwOE9pSlBTdjFLQUxYdFhlRmkrcWNvQkQwbXJTa1IyTmdYc2d6TFlk?=
 =?utf-8?B?RjVpZDBZeGFBOURUNTVadUZkTTJwR2tkdGo5cXJTVG5pV1JtVTBwdWNLcXI3?=
 =?utf-8?B?QUJQN1lOMTRkT0ZDbXZQcm5VRXAyV3pneFpJcTA5SlZueVFFS2lnTHljTndu?=
 =?utf-8?B?SlJFU3F6cUZLb1pqN2JSdHdQUGdFTHlIaGtielFJbjh5MnR0U201V0VLa0F1?=
 =?utf-8?B?VDkzOWRVTVJ3RG9samk2MTFacXVaMjQwUVBPZ2NjRmNIUzRmdmJzVWJ2bFB1?=
 =?utf-8?B?V3BleGZrc1IvbUFmb1JPbkloWWZtU3d1MEwrTDdNM3IrcHRZYk04K29UeTZG?=
 =?utf-8?B?OGtIVXFBb0dJcjlCeUY5cjJza0xHSk4xM0Y5RHJYNkRNOFMvR3VPMVhobWhq?=
 =?utf-8?B?aW1lMC9RN2lvSzFwN0d0T2FGZFYzYnhQN3F5Vmc3QWlsSmYwOXV4aXpoMXkw?=
 =?utf-8?B?djNseWhSQzBGMDlhemUwSG5xSjczdHdsaFJUUDZxQ08vREJLYUJ4ZWY5TTNK?=
 =?utf-8?B?UVNneG11MFpDck1jcExMKzdvaVYvQ1ZNZjdMZEF4d1pkeWNwVlhLK2pUR3B0?=
 =?utf-8?B?QWxRLy9GVFgxRGk5eVNPUmovWFBiclRlUzZkVXVVSTlZTEM2ZDRnZzIrb2x4?=
 =?utf-8?B?UUdRdlhMZFBYMDlSZ2xSMFEzUGM5azQvWTUxaFZDUTlDbXA5SmpYYmJjOXVG?=
 =?utf-8?B?bXByZEcwVFBQQ25DOFRoZzNHcEZya0U0YmRuTXN5TEx3YkZ3NFJIeTVmUWE3?=
 =?utf-8?B?Rm9MM2xJM0h1TVdZUEtscjlQRFRSamZ1ZzBvQTVRengyMkZHNU1qUDhUbW5W?=
 =?utf-8?B?RkhyYWFEVWdXSFBqWm9JOTRJdld4RDdvNkNBRWRjMjc1OHV6eXpIU2NNcldw?=
 =?utf-8?B?ZUpoL3p0Vyt4QzNnQjdiMFRjcndjRHRlZjZxRjRvYXp6cmZlVEFZTHFReVdX?=
 =?utf-8?B?V0JwalhSQ2VobVJldWpsZ0xGc3dmdlEyK1lFeTc2dmUrbVl3RTI1ck1yMDRZ?=
 =?utf-8?B?RU9PR08xQ0tTU2tmK1pmTngxdFRVdXp0R1pjaXFOV2RyZmQrYjBPRmRYaXUy?=
 =?utf-8?B?M3QxUEl0R0JZUDdmclZZR285RHU1MXhWK1VNOVJJL3dqWnRNRmx6Sk1Pekl3?=
 =?utf-8?B?a1hLU1Jabkowa3hnelFsV2oyRm51U2tQYVY1M0hYK1hjSDZMT1BRV01xRndJ?=
 =?utf-8?Q?uqbZZYV2nVats1q3Zhs/oFwxv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b80072-d153-4a20-b6bd-08dcc1c8543e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 10:02:13.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V29Yn4OWzmCKDq+bhn2K6okG9zlbdhh5mWkg1Mj6ghAI2jXaz+KFe4ili0uuv3OtimyjrCkaoNMwytR1B3lVBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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

--------------2ED90B38453EC37B7F07CF0A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sunil Khatri <sunil.khatri@amd.com> <mailto:sunil.khatri@amd.com>

On 8/21/2024 2:08 PM, Trigger.Huang@amd.com wrote:
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Do the coredump immediately after a job timeout to get a closer
> representation of GPU's error status.
>
> V2: This will skip printing vram_lost as the GPU reset is not
> happened yet (Alex)
>
> V3: Unconditionally call the core dump as we care about all the reset
> functions(soft-recovery and queue reset and full adapter reset, Alex)
>
> V4: Do the dump after adev->job_hang = true (Sunil)
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 68 ++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c6a1783fc9ef..3000a49b3e5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -30,6 +30,61 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_dev_coredump.h"
> +#include "amdgpu_xgmi.h"
> +
> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> +				    struct amdgpu_job *job)
> +{
> +	int i;
> +
> +	dev_info(adev->dev, "Dumping IP State\n");
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> +			adev->ip_blocks[i].version->funcs
> +				->dump_ip_state((void *)adev);
> +		dev_info(adev->dev, "Dumping IP State Completed\n");
> +	}
> +
> +	amdgpu_coredump(adev, true, false, job);
> +}
> +
> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
> +				 struct amdgpu_job *job)
> +{
> +	struct list_head device_list, *device_list_handle =  NULL;
> +	struct amdgpu_device *tmp_adev = NULL;
> +	struct amdgpu_hive_info *hive = NULL;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive)
> +		mutex_lock(&hive->hive_lock);
> +	/*
> +	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
> +	 * devices for code dump
> +	 */
> +	INIT_LIST_HEAD(&device_list);
> +	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
> +			list_add_tail(&tmp_adev->reset_list, &device_list);
> +		if (!list_is_first(&adev->reset_list, &device_list))
> +			list_rotate_to_front(&adev->reset_list, &device_list);
> +		device_list_handle = &device_list;
> +	} else {
> +		list_add_tail(&adev->reset_list, &device_list);
> +		device_list_handle = &device_list;
> +	}
> +
> +	/* Do the coredump for each device */
> +	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> +		amdgpu_job_do_core_dump(tmp_adev, job);
> +
> +	if (hive) {
> +		mutex_unlock(&hive->hive_lock);
> +		amdgpu_put_xgmi_hive(hive);
> +	}
> +}
>   
>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
> @@ -48,9 +103,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		return DRM_GPU_SCHED_STAT_ENODEV;
>   	}
>   
> -
>   	adev->job_hang = true;
>   
> +	/*
> +	 * Do the coredump immediately after a job timeout to get a very
> +	 * close dump/snapshot/representation of GPU's current error status
> +	 */
> +	amdgpu_job_core_dump(adev, job);
> +
>   	if (amdgpu_gpu_recovery &&
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>   		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
> @@ -101,6 +161,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		reset_context.src = AMDGPU_RESET_SRC_JOB;
>   		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
> +		/*
> +		 * To avoid an unnecessary extra coredump, as we have already
> +		 * got the very close representation of GPU's error status
> +		 */
> +		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> +
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
>   		if (r)
>   			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);

--------------2ED90B38453EC37B7F07CF0A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p class="MsoPlainText"><span style="mso-ascii-font-family:Aptos;mso-ascii-theme-font:minor-latin;
        mso-hansi-font-family:Aptos;mso-hansi-theme-font:minor-latin">Acked-by:&nbsp;
      </span>Sunil
      Khatri <a href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
    </p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 8/21/2024 2:08 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:Trigger.Huang@amd.com">Trigger.Huang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240821083841.477392-3-Trigger.Huang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Trigger Huang <a class="moz-txt-link-rfc2396E" href="mailto:Trigger.Huang@amd.com">&lt;Trigger.Huang@amd.com&gt;</a>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status.

V2: This will skip printing vram_lost as the GPU reset is not
happened yet (Alex)

V3: Unconditionally call the core dump as we care about all the reset
functions(soft-recovery and queue reset and full adapter reset, Alex)

V4: Do the dump after adev-&gt;job_hang = true (Sunil)

Signed-off-by: Trigger Huang <a class="moz-txt-link-rfc2396E" href="mailto:Trigger.Huang@amd.com">&lt;Trigger.Huang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 68 ++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..3000a49b3e5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,61 @@
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_trace.h&quot;
 #include &quot;amdgpu_reset.h&quot;
+#include &quot;amdgpu_dev_coredump.h&quot;
+#include &quot;amdgpu_xgmi.h&quot;
+
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+				    struct amdgpu_job *job)
+{
+	int i;
+
+	dev_info(adev-&gt;dev, &quot;Dumping IP State\n&quot;);
+	for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++) {
+		if (adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
+			adev-&gt;ip_blocks[i].version-&gt;funcs
+				-&gt;dump_ip_state((void *)adev);
+		dev_info(adev-&gt;dev, &quot;Dumping IP State Completed\n&quot;);
+	}
+
+	amdgpu_coredump(adev, true, false, job);
+}
+
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,
+				 struct amdgpu_job *job)
+{
+	struct list_head device_list, *device_list_handle =  NULL;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_hive_info *hive = NULL;
+
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
+	if (hive)
+		mutex_lock(&amp;hive-&gt;hive_lock);
+	/*
+	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+	 * devices for code dump
+	 */
+	INIT_LIST_HEAD(&amp;device_list);
+	if (!amdgpu_sriov_vf(adev) &amp;&amp; (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) &amp;&amp; hive) {
+		list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgmi.head)
+			list_add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_list);
+		if (!list_is_first(&amp;adev-&gt;reset_list, &amp;device_list))
+			list_rotate_to_front(&amp;adev-&gt;reset_list, &amp;device_list);
+		device_list_handle = &amp;device_list;
+	} else {
+		list_add_tail(&amp;adev-&gt;reset_list, &amp;device_list);
+		device_list_handle = &amp;device_list;
+	}
+
+	/* Do the coredump for each device */
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+		amdgpu_job_do_core_dump(tmp_adev, job);
+
+	if (hive) {
+		mutex_unlock(&amp;hive-&gt;hive_lock);
+		amdgpu_put_xgmi_hive(hive);
+	}
+}
 
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
@@ -48,9 +103,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-
 	adev-&gt;job_hang = true;
 
+	/*
+	 * Do the coredump immediately after a job timeout to get a very
+	 * close dump/snapshot/representation of GPU's current error status
+	 */
+	amdgpu_job_core_dump(adev, job);
+
 	if (amdgpu_gpu_recovery &amp;&amp;
 	    amdgpu_ring_soft_recovery(ring, job-&gt;vmid, s_job-&gt;s_fence-&gt;parent)) {
 		dev_err(adev-&gt;dev, &quot;ring %s timeout, but soft recovered\n&quot;,
@@ -101,6 +161,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.flags);
 
+		/*
+		 * To avoid an unnecessary extra coredump, as we have already
+		 * got the very close representation of GPU's error status
+		 */
+		set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);
+
 		r = amdgpu_device_gpu_recover(ring-&gt;adev, job, &amp;reset_context);
 		if (r)
 			dev_err(adev-&gt;dev, &quot;GPU Recovery Failed: %d\n&quot;, r);
</pre>
    </blockquote>
  </body>
</html>

--------------2ED90B38453EC37B7F07CF0A--
