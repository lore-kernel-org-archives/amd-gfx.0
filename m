Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3BFC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 17:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD75410E0B7;
	Wed,  2 Jul 2025 17:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GVt03kG1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DA610E09C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 17:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwQKN4T01jsB/wKkfLTJslb2d+7xa6Ek9dNdsfzVXUICJ0AXGV/+RcHfDKkpnpCZclKZq8CquyO/34pDoSQy6ytaQdRHuVQ4rl4oOAcdPsBlDtoRAypyDPA/fnv7DPUvboNMN201VH9BeeD1znveWEze93XlYqAWUVv5SFjDRKy8Y3QrXFtLkJSwlT1IpACrHZv0L/HcDmmpRz8Mx/7mr+SSGI2I6p+FOR707zyn9cjUcSUxdm0LsQ6xfPAP7NaxmdaySU+rTtIpy54DtjFM7NLXpl3adpt0OZ7/fmOFzAdxa3QEZTtOFpJ9fHZu5aSvWnqSOCgouKFlIzkztKjyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmzj+15GDWZsh+pCFrJwW5kPw7ZuJvNNfVBF+D5/1/s=;
 b=hhBqxtlFMqev+VtummR1w9K481D3TGoaBAGiVLj2+AJfqFSTZkDdAfvCMRNnXgB1+Zm6zkrvPlRzUSEBKIkl/GXsuWJKP6jvzxPi3B901qvynkEWnL7mq0WrhGb56jQXtlL7R9/hc5jq0vd+ZeLgVNRCBhIRvJ+hmBtRsSZoYHmvwhXb8eKgpbJpYegHKSxC4zxWDwnk1TqerGGFvMK9c5Que41Hn17AqcsP2LAVqo1Km3Xc+VA2XyOg7KsrSMHtIacjfQDux6RCxpSN1WlZ8Agm9zevQX3BibFjCnSjE5M2ErX9IZDWR5BlMirUNHH3HqhpXUdb/bM4uuS1/imvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmzj+15GDWZsh+pCFrJwW5kPw7ZuJvNNfVBF+D5/1/s=;
 b=GVt03kG1Qifx1nyT5spDj0SStXWQY6V7t6G/wOvOEtCZmpYKW7ELG0F2/JRy1QU1vq4VjHt02QCrdUMPaZqKoYupTVeTqQ9j29zp2OVmpUl33Kva/p4LUmUN3WWIPOY7m2+nsa4C0mhG52d/NOS8agGTofWa05HTNDBX2E9c5ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 17:44:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:44:31 +0000
Message-ID: <48687d21-a901-41aa-bca4-7ac7916b305c@amd.com>
Date: Wed, 2 Jul 2025 13:44:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Use scaling for non-native
 resolutions on LVDS
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250701201438.424760-1-alexander.deucher@amd.com>
 <20250701201438.424760-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250701201438.424760-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 983e5bf6-2b11-493b-80fc-08ddb9901960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3Nhb2tLMHY1Q0dsUHJUemNrd2hlNWpvWW9TMlc2OUQrZG52L2dPdGowejZR?=
 =?utf-8?B?UFh2dGZHZ2dQYTcrNGM4U2NEUFhMMXZLMzNLYnRzbjVQdEd2emhJM2FjM3dG?=
 =?utf-8?B?ZlNtQUFZa1g5ODUyRnhKN1RoMnhMTkNnSHhuK2p2dTBHRGxCa2wwWW9XV3hE?=
 =?utf-8?B?b3ZRNFNlRVdaZ0pvSFBiOVAwSnpDNEExZUhxeXZZb1dhZytkd05BK1FGWXFo?=
 =?utf-8?B?cHpMdTNGSUwxSEw0Mjl1WVdvS2hadmZaaDZHVExpaUNoeXlOTnZ3b3VsLytQ?=
 =?utf-8?B?a1luQ1poWkdiQkZIVWEwbG5LdVF6WHNWMXVjWVpDeS8vQ2tqNjkxSHRyb1do?=
 =?utf-8?B?b0ZNcVg2dGVualB2ZHlJaGJibUN2NWQwLzd2Wmh5ZFZMUksrYk10V2tnaktv?=
 =?utf-8?B?YTZTYkJRRWVVTDgwRzJEVW91MkdOTmRvSGhlL3JEUHcxdFQ3TUd6RHF3YUJw?=
 =?utf-8?B?dW9FbFBCSW05Z2w5amxDeUk3Zmw1ZHBITnJtZlllcU1UZVc5MEwrODJEVjll?=
 =?utf-8?B?b21xck9Qc0JUS0hQZFpMZU0xQ3pjSEh1SjNwZmFWNDlQQVlRU3JIdXBzM0or?=
 =?utf-8?B?Y1IxWXRSd2h3YjFwNlppN3hSYlFtdGh5U1pLQUw5RVJ4TzJqSGlLYkdMMng3?=
 =?utf-8?B?WEptM3FRTGJTZlRsQzR2a1F3NTVVN2tXTmdzcGMrSFpDZi9tMm1BbS80TkRQ?=
 =?utf-8?B?K3d2anc1NkRCNnBOdjZpdFZZejMreWxiYytlK2VoQzg5TVMzeEMzUGZIekpm?=
 =?utf-8?B?UzJPTndIaFdjak8zQUFIb3NTc05acEVmS0xnV1lmZXJCbTBFNjFVOG1CcUFw?=
 =?utf-8?B?dlE0ZzI2dTRRWjl0SEYvVSsrQ3luU2xjUEt6ekt5ZXl0R2d5N0l2NnlCM1JE?=
 =?utf-8?B?ZitOK0x1ZVI1MzZINTc1TFZ1OUxYRURyWVp3K0s2dlBBUmdOM2dUT2t4OGdi?=
 =?utf-8?B?NmJzSllUd2gxKzlYbVVnUmZ3MUlxTm43KzRpTWd4bGxlOVgzWkRPYzN5eE5v?=
 =?utf-8?B?Umx2RlA5Wlc0RHpQWVVZYWlwYmRBUSt1R1V5M1B5dU1MTnJXZXBKcStSbXlu?=
 =?utf-8?B?eE5LR0Vzd0FKVTNjNUlVczRJUzNDMWZmb2x5U1A2NVBqQzhyZDREcjdpOFA1?=
 =?utf-8?B?NldSZytTTnljVnVmUTE3ODVFckQwYjJqdmV0WEdqNTF4eG5mOG50Tjk0RGFC?=
 =?utf-8?B?aWhteXFxNGlabzM0eGhkRG9GN1FOejYwMVpKSThYY29ySWZnU3Y2Q3AwZlB6?=
 =?utf-8?B?WkRmS3JJMjZpVzJJNjNnSElpbE5KUlRwVWZZN2hmdldkL1hic3VXd2FIZGRo?=
 =?utf-8?B?QXdMKzdwb1NVOE84QjNmc2JUaDk1Z0Z5d0lCQmF4Tkc1bGVDcmJEQldXWGNR?=
 =?utf-8?B?RXJNcUlqa0dFTXJ4T2l6MHV0TEVFaklJandlcStkajV4UFpWUnZiNERtN0xW?=
 =?utf-8?B?ZlRXSjRWSFB0dUlaRXhXd2ZIdWlrbmlEank2cGJNSVpWcEczUGZuTHo5dG95?=
 =?utf-8?B?aWJvWXcyY3U0aCsxUWZMSWlzRVBKVDB2N2NwNWdCOVlnZ01IbGViNHNscEJF?=
 =?utf-8?B?WmRqb1Y4elI2UDhTanBTcWVianl1M0NLd3Q3N0N5OW1tVFRiOEViaFRkWlhP?=
 =?utf-8?B?dks0ckxFaXBFNk4zdnhEWFFjbU9nUVpwaTJOY251YlV5SC9LcW9uZHlaaUZq?=
 =?utf-8?B?RE1iRFc3ZVZzRmkrZG5aQjg5amxMZ2g1bDdVZlhvMnV1QUFFUzBIZHg5VGZ5?=
 =?utf-8?B?YzBuYlNycXVBbkhuNGExdHpSVmFvY3lmWVMyclhRcE5BYVMvNUFlczU3cFVK?=
 =?utf-8?B?OWtPa3BZdlBoVzNNZER0SHEvQ3ZuUEo0Ly9FUWdlckovY3ZBOGM5RGwxUlJr?=
 =?utf-8?B?WU85WXFESXZ4WUZBM3ViNWtseGUxWlg3RmovSFl2bGliYXFLN21IVGViM1Jk?=
 =?utf-8?Q?S4IuYRyzD9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVSeFV6Zkd2MUxzTnVKdjYvUjVhMkFwK0N0dDNvTUdDR0pyMGJvOENUR2J2?=
 =?utf-8?B?NVA2a1VXS0J4SEttUVJvbFlKTm9hamR0RDc4amE1OU1HK29nSHh3Ung4eG9t?=
 =?utf-8?B?T3NUQ24rdTVJTGVYWGhrWkN0Ty9MbVAxbHZHZW9YRlpJK0lNNFlWZW1hZ1U3?=
 =?utf-8?B?RHl0Vkh4WHpsZlBWcm1KNHZtVUVMd1BYNlo4Q2VFZUU0RitHTDhGWW9TVW5r?=
 =?utf-8?B?WEo3RnNwWUNvb2djMmsrTTl4SGF6V2dKWGU3Sy9pSUlZVkh6bjJRY3BRUFZq?=
 =?utf-8?B?U1N3QWs5aDVnQzBFcEVySHdZdVREQ2oyU0NzbmVYL1RHSWgxblZYSWVybml3?=
 =?utf-8?B?OWhrU0wxbTdXalkreWN1VzFZOWc1SHZpZUxSMElUb1FYdjNYWi9hTFpMeHVr?=
 =?utf-8?B?eWlCZElqMWpUbllBSnA3akx4NmV4Umx0OHMzcnpWQVVOSGRpUGh4blNoNXVV?=
 =?utf-8?B?T20wNjhLWFJFbFlzZnVsUTl1djFiUHoxVWl5OFpOTnhpTldtWi9FNUFQODZP?=
 =?utf-8?B?R0lQQmlETjVOdm1EY05GWkMwa0NDVnNjRlNvN21JYnI4bEg3aXpjMnBGR2Qz?=
 =?utf-8?B?bVVrSVdjTk9CaUVFMjduSlNnZ04wWVVLRDRxVFJVdkRzbjdLZ05GeHgwamtV?=
 =?utf-8?B?VVpiTnY4VTk3cFBzSXlybkFJOGNrZW43SnNrclVJbEZUL1Y0bG5IV2hGQktr?=
 =?utf-8?B?MG95TDNkay9GVmlmY3J3aEU4Q2ZPZE9jcGZRNEZjTUdUVDVBb25zRXN1aU9j?=
 =?utf-8?B?NHpWckgydFV1UTkxK1JPQlNSQmp6UTUyWGlaMTNpRnROV1oraDUyNkdESTZB?=
 =?utf-8?B?MXgzMHZsNkhxUlFMQkFwbkhSYnFqeHJpT09ndE95b0lYWEcxS2xaTTNsM3JI?=
 =?utf-8?B?bjhsOStGajhCTWdJQkRYU1RBaXB6MTBubGtXZ1lHNWVCeEh3b3UrOTkxd1Rp?=
 =?utf-8?B?bVRvMGNzbmc3ZDMzamhxYkhzUlJ4a0piSW1EdkRYZTlnOFBMaFQvL1piYzU1?=
 =?utf-8?B?VS9QUFpkNzk5a1kyOFNRcDdCSnFFU3J0cTFsbzFrVmVNRzhlVkVrTGNveTZH?=
 =?utf-8?B?SmFEQ3UwalQvQWRtT05vT0ZCSjVPaEpnaGg2YWNqeGtmUVBxaTE4c2NUU1BY?=
 =?utf-8?B?SmdPbDNNWXFiSVRrVmhXYWJJU3VoQS9qRlFxZHErQloxbG14Y3NhR3dYODR1?=
 =?utf-8?B?NkhxdWs3S2VQNW1QM1NRNlJIcmoxSmxVa3dCWmRpMzYrcTZCeXhVL2dkMElv?=
 =?utf-8?B?d1JhVkwzSHlZTnRsSHBpY3VTZUdPSHZKTERZaFFwMUIvZVdCbXpKdWs5ZWV6?=
 =?utf-8?B?Ymo4RkQ2bmlZMHJwdWZwcEhpaVhabHVuVm83TWYvS3ErOGkwdEU1bXdxeXNw?=
 =?utf-8?B?Tng3SHNNUHBTYUJXZS9UVm90R0JPbzJkY0RIQ1FEMEtDK1VibUNLbnROZjg3?=
 =?utf-8?B?ZlgrSnBIL041THZpS09mMnIyY3VyZlRlZGhoTUhGVFRvem5xODBFeWlkYndi?=
 =?utf-8?B?M3ljV2JKVU11TTVJcFRlYWwxNFpSZUJSOHR6UDlRNmhFYWdMbis5Y0tWTWx4?=
 =?utf-8?B?eWdLa25ITjlWT0w5eVovZ0xaUGVsbUZxZnJlZGwzUFFGNDVaZUN4UEFaNUlq?=
 =?utf-8?B?eTJmUVB0K2REZjBCblFobUZTZTlvcjNRT2IwQjRkYnlmc0EzMnJ4NHVHUUww?=
 =?utf-8?B?M1dyVW9OR0dPS2paSjFLSktjM3I2cGRHcTBSK2NqZExVRTlNVlcyUTI3bFIr?=
 =?utf-8?B?UGhBSWo5ZEdxRlJaSC9rRm1vTncxMmg2MjE3Mm5oOEtrUysyMzBCdHp1UDRw?=
 =?utf-8?B?UEE3NzlpZHR4eGR3TmhpUXArNTU4SjlFbVZkSEVoWStvSnQwNWJLNFdRSG00?=
 =?utf-8?B?RTgxWnZaYVlSbHlqTTJwdFhHdlIvK1N2MU9FN2JXTC96QW9Yb2hxNzBrTDQ2?=
 =?utf-8?B?bWU5NUFlaUxOZzVBaVdXZk5tUVBaeUk1NUliT0MyS0pSdE9wV0pTeTlicGNK?=
 =?utf-8?B?OFZUbWlRZEwxRzdaRUwwYjBaT1BEbFhBUEhmMmcwWVJNZ1VHMXFoUzJiemFw?=
 =?utf-8?B?V0xYaHZLdk9wRHVtYytMUjg2MjhWVHZ1MVkrWGpwTXFlcmp0SHdObmVXL3hT?=
 =?utf-8?Q?+8Vu37wXTJk1QqpeZ6+T7j9K4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983e5bf6-2b11-493b-80fc-08ddb9901960
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:44:31.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Dg2GvToehrm87jNhtFpVAAQi9Qd+36F/rLBfMAgUzwMFDhPeP2nIZtEaq3/BOq8Bm+nYgXBrVFSmw7LdRgMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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



On 2025-07-01 16:14, Alex Deucher wrote:
> [Why]
> Common resolutions are added to supported modes to enable compatibility
> scenarios that compositors may use to do things like clone displays. There
> is no guarantee however that the panel will natively support these modes.
> 
> [How]
> If the compositor hasn't enabled scaling but a non-native resolution has
> been picked for an LVDS panel turn the scaler on anyway.  This will ensure
> compatibility.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7a4fca9a61bbe..096b23ad4845d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7901,7 +7901,8 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>  	int clock, bpp = 0;
>  	bool is_y420 = false;
>  
> -	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +	if ((connector->connector_type == DRM_MODE_CONNECTOR_eDP) ||
> +	    (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
>  		struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>  		struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
>  		enum drm_mode_status result;

