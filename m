Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756F7C30653
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F3F10E08C;
	Wed, 26 Jun 2024 20:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o36uNdhA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E7C10E071
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs+TxUCgfgAU2Z/sdxZlDorqekV9UOiLd+TgL7ZSpNbX/JF0yBemqCR0Ub1E6tPR/nOzxge5LGa24fVtE9duAYnDcTb9KiVU67ZrBwwtqFT0p8ZC74xb9Kid2eXWzqS63PPca//vK+WarGd7NDgGOV9a/MqkAD11g81eDmS5HaO+/GWvqQxD4sgT1SmLM572Tu50df+v2OI4OVVrpwvpTL90Dp+EoSlSjXjGOO4UAADrzxBUXvaltwNMqI+gz/Bzyf4HFUa9IIO6URNjYMkAZhP1hUw23p/b7O+1w1PN3CONKd6nEq+7+FddqqvZcPe3OyycNJl/JMBujyqncEKiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP0n7UOMw4geKJtyC6IrGZrbyj7KdEOKeLxZGyerV40=;
 b=MSpkjRchqIqZQzA8OeoQTq0OwZXWpH82CRa0doutepwfO3VymoNJ0OnKV7DzVbhN1GZZRqRc6PsMbDbrhn9MRwnXHGPYPQgjIj//Qp29UCHIKFn1YxdmOaFA1t05eJilD+h23H2t4FbK2JqzzvqX8+fMJbTZK3JMza6gLkXxV4+y1cfCoSVByMe4dqmZ2IiEzyeRVB9wv+ZXJ209AK8I41YYfj+PUejGbWTHyaWaLpj2U1MnWgSGRk49o1E+8eGbuQCZmBitShRlHnMEtGHR+PcXtAiPfsKbt2PPmSxEma11iWNYDjDxZwqipHYPiJ9S7w81I836KgXtlm5FVtPHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP0n7UOMw4geKJtyC6IrGZrbyj7KdEOKeLxZGyerV40=;
 b=o36uNdhAgEmCnyoK5wpbYzzh6SOgr7DEQqcG49bzTfDx/9zIjDgTS5k/yUxhGBKHriz99t5wn1UYe4jkwBWOQgAKYkTUQjXk//rdTNFWkdm1Mh3BpOPU50BPr0Iie4pl9ZX3YfXMj3ng4+7ACkCt5QP314ws/OqC7bUMBjZwsGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 20:16:48 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:16:48 +0000
Message-ID: <057275cb-7883-412d-930a-136802d0b5b5@amd.com>
Date: Wed, 26 Jun 2024 16:16:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] drm/amdgpu/display: handle gfx12 in
 amdgpu_dm_plane_format_mod_supported
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-10-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-10-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 16754b24-3459-46e0-7a37-08dc961ce8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtOczdJZGNvaFpEL1lNV3FEUGF1ajg3QmU5cDlrY1huYmhIRnVlUkZUaTI4?=
 =?utf-8?B?d0NMUFFlTDErckFNZ3A2a29nSlVua1IrTzdVUlNnQ0srTlkyVVlaMnliUEM1?=
 =?utf-8?B?elh4K1FzVHJKL0Rqem02cUlvcXdXeEtzMHB0bkJZWTZEclhFUkQrbUZwb2ZT?=
 =?utf-8?B?ZkNQYmtlR21QOWYraVV6c1ZlU3BvTENpN2hOSnIrcnlMYzlGcEV5RjdyeWxF?=
 =?utf-8?B?c0xaU3REaU43L0twWDFrZXhMWHJTZDYzcWpQWDI0YnlkdXNSdDZ3SWV2UzA2?=
 =?utf-8?B?dEx2OHdvTFdxTm1MYUlEbkRBTUZYYXhpTUlnOHF1Q1ZUaGc5OE03UmppR1RL?=
 =?utf-8?B?VkhkVGt2RlBDektxcERmUURLYXNwaHlEbDlwcUpQME5zTTBjcHpUbllsaHhF?=
 =?utf-8?B?dUFETllDcmdIbnlVdFNibndqVTFReFIvZnNSbVJwWEkra2RQd2h6bGd1OEhZ?=
 =?utf-8?B?aDdNSXlkZnhQWHQ3bDhnblcxQUsyL2RHWEpKMHUwVCtqbElleU9JRTRmclk5?=
 =?utf-8?B?N2ZKT3VlU2lpT2gvRzI3VDlNZzBlZHk3bFp6c2JtTlhmd0FRYlNqaFkxUENQ?=
 =?utf-8?B?V3ZCeTkyelRtMnNlZWFCWFJiT1VROEtIYnhqT0tXb3pob3VlTVEvV1plYlI5?=
 =?utf-8?B?T1Bmc0tGNlcvbFozUU9TSEtrNkZoVlcyRTRzS3U0QnNUS0J4VmFJVmwwdWQz?=
 =?utf-8?B?MDU1dFh6UUFHVEFjMFdYdjkyeUNZaXlBTi9TUFliOVRJZzFER0pRRTV5VUkz?=
 =?utf-8?B?djgxOWZJazF6TWQ0cHlFdk9GdE51SmhTdCtWTFFaN1cyaGJKRHNvNWZhYXVU?=
 =?utf-8?B?b094STRwQzdPM3g4dzdKelZzRWxhWWFicmlOQU13QWZyQ2tsY0E0dmJUOEpM?=
 =?utf-8?B?cTlhSmFnbzRIRlJDMCsraHFqOHU5N2lseDExdU1NZ3lHVlF3UEh1U0ZiNXRr?=
 =?utf-8?B?VGprUnVlL2tyUTl3Y2YveW9uSjBjQ2JCYjI5Sll0OUpnZy93UnZEWkVLalZV?=
 =?utf-8?B?ZHhhZWI1U096cWMwd0E2dkRXSEZzL042YmlmZS9wK1RwRkRRdGJyd0d4Mk16?=
 =?utf-8?B?d2JrVVNoQ3o1bTJMODBuRTB3Z3k2dGNpUDM3V1FsR1E4ankrNUJvV0tRdkxL?=
 =?utf-8?B?OXMzK2pKYUtKdmUzVmZpWnhsVGpva3ZEQ05uMHp2VkxOUzU2OHZqYVZOWEcw?=
 =?utf-8?B?QWh1cDRKd0hXV3lCZVBjeGRYS29tYVFZZ2dHTS9YNkNXUVBjeE8rUG9vMmQ2?=
 =?utf-8?B?cnJxd2xVYW9yQ1R3WWdXU09lM1dTNHdJVlEwSTU2dGhjWVVaTVhGaGtkNXd5?=
 =?utf-8?B?VHdIOWpBbnBXWVRjdzAxV1VKL01HU1o2djRFUTYwTml2T0xtT1ZhWjNFS3lZ?=
 =?utf-8?B?SENSNVE5bWxzVlFtcmR5YVJaUWpsaUpsWi9aM0NTSDRwTEtrTGZaNEhhU1Rm?=
 =?utf-8?B?M2hnc1haSXVRUmVYam1sUjZjNjd6WFJmMWo0bFo2Nm55TmlqM0JQQnQxai9m?=
 =?utf-8?B?TzBnMXJjZnpCdDBWdEhQeEFMN3poejU0dml1TmE3NHFhMWp6amdiTS9DSEpu?=
 =?utf-8?B?VitCVnA0VjZ5dUJFdDFZYzJ6VVNaajAvcFZmc0xmVndFUm5hSkdkNjJyRWhC?=
 =?utf-8?B?T2pneUg0dWU2RDBhREVjR0NZajNjSGpFS01iNnpVd2hrZFFaSVl4N0lpMGZV?=
 =?utf-8?B?Wmg0QXRLNjIyV1VSSEN0c052ZU5vQUtqNy9POElzSUVBVlc5bU5WVHFVdlc3?=
 =?utf-8?B?Wm1hWVgyVzRjcGRhdjVuVFB4M25ieGJKa080YXhZbWJ2ZzBYYlUvbGFLWWIx?=
 =?utf-8?B?QUZWd2g1QWx2dXVBZ2RkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(1800799022)(366014)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lhejNZODVCR2NDeU1JY0JqeWRjMUZSaTc4NW5QK295MjRIcEJRajdwMGtW?=
 =?utf-8?B?YmQ0QTRmWTJzYndmM0UwQzdmd09zRVY1cWNNMkt5dlFLS3hreHhCc2t1aDVz?=
 =?utf-8?B?ZStVaGhod252d1JQSFk5WUJ2SkVxZVNvMVJ0SXJTVUkwRFFFYjZRUDVKWWs1?=
 =?utf-8?B?aHdGOXNaTzVCZGpOdzVLUDRzdmM2aGpGdlJ3YzdXUnFueFFTbmZyTkR1enBy?=
 =?utf-8?B?MEw5RHNVdzZaajJmWWY2L2ppOTFKT2xVa3VuZVB3MlBkSXMyVUt1MXMrQ3Er?=
 =?utf-8?B?OStNYWR2VmkxQ2pKRmJNM05LL2ltSVh5cHlEaUFDTXE0ZWJyOWQ3RE81R3Fz?=
 =?utf-8?B?TGprWndYWVlQanVjN3RFVVlUZmJHWFZqaXlsanVLKzdxYTZaREQ5VXFWckEv?=
 =?utf-8?B?MG5UZERjRW91LzZnYnk1WGRRWWVLUnhOdFM2dDBDSHlSRGd4akxwZms1OTVP?=
 =?utf-8?B?c0FDL25sZ3RiRTNDdFNycGpLS3cxcTV4T1hRMmYxdGpoRmVkc0JKK3Bkb1RH?=
 =?utf-8?B?d1JKN213OXF6aXREaW1BZ2N5bGxta3lBQjhsWjhzUjJUYitNVjV6Z1JKTGtL?=
 =?utf-8?B?L1FOcU8zV1BJVDlzTnZjZWVVcTlDSDNuU09iZXJJT29vblJzaU11VDFNcmdR?=
 =?utf-8?B?dmV3c1Nub2d1d0QvZityOG9oRTZ3RUJRTHFUM3BJTWpHU2FITkNrcG9XbUc0?=
 =?utf-8?B?bEVEaUdIVDBmL20wK2dVcVRtOEx1MGlqck5OUnJUbVFOeUtxdEVyN0tHcnBy?=
 =?utf-8?B?ejFuRmVWSnI3QUMxRDluSW9SVlZ1THFVS3BNTlNiU3l1bUlId0NMWmN3WG0y?=
 =?utf-8?B?TzIwZnUvalZweW9WR3lIcytpcXpSSWlOTzBpcEtmQ1MrY2Q2dDMwbks3TGxl?=
 =?utf-8?B?SjZkQmVETGFabVdRVUM2Q2xXeVh0ZEVDVDlkVmhsMmIwTUorWkxnSVhBOURE?=
 =?utf-8?B?UlVidUVRbXg0Z2lEemtkVUR6RFJJQ1NCRjN0ZjU4TmN6T2FCd09lNFNrWkx6?=
 =?utf-8?B?UEV2eTRlK3JXSHA3bFBNK2xsWjlMRWlJRWROcTJMRm9DTnRNcVkza1lnUzZt?=
 =?utf-8?B?SnhJUmhVNUo4amtOU2IyMHBkZHBpclNSR3VhWXlXaGRodzBJWFh3ODdiZm5u?=
 =?utf-8?B?RE85bXg4UzQzM1pwcHcxRXJFenhTbWZFZVFzenVaTVZqZkVyNVZ4blVvOVhQ?=
 =?utf-8?B?aUlxL2NTeXFBMkpxT05RWHA0QmVTOG5IVGpnYmVjUGlZK0ZodXhYSnJ0dmwy?=
 =?utf-8?B?RDU1eWF3aGdBWmRsVXEweHlJNytRc1N0V3hXZzhMSHlWK0piQ2hHd3Y4NjQr?=
 =?utf-8?B?YUU1R3ptc3hKODE3YUtOOERZOGExMXpSUVJIakE5am5jbXRIRUNpRXo5cHoz?=
 =?utf-8?B?QlZUN2I1aElmTmpZMXNyS0ZNMU1DL3ZlT2xNTGdhRWoxNVFIaG1FYUJXMW5a?=
 =?utf-8?B?ek1nRGQvdnRySHhJNTRMT3g2TnJqakdlT3ZNSUU0VjVRTVovNVg1cFRReFRj?=
 =?utf-8?B?SkE2amtkTWZScnRSa0RSM0Z1emYxUEVQbURKUkhwNDlMdmtydFF0Y2VFSVcv?=
 =?utf-8?B?WWpRa1kyZG5QL1l1ZGMzNy9jY2h4aWdGYTZIeGpQUEVXbU13V2FqT1lqVXMy?=
 =?utf-8?B?cnpSYUZudTVnVEhIbis0bnFpQjJaMWpQdHBqRVBRdEtzZjVjR3FRL1JlMmsr?=
 =?utf-8?B?cXY3TUVaQzY2UWxGRXZhZ2lGODJORncrbEIybmJaSHhHUmllM1Joa05IRjhy?=
 =?utf-8?B?RHkrQ2lUZHFZYlZucTJoS0ozcXhRRURmWlFHOHEzNW1WNkZ5QmRLM2xWam1x?=
 =?utf-8?B?Q1oveVc5NEh1djY4dXdCT1BpN1lCcGJJZWxYbXZ0TXdObXgyeEwvMi9LV0s2?=
 =?utf-8?B?OUFlZDdQQWZmM08xM0tWZmZDcnoxT01JVFFVY2VHREhndlhSY2VIaHNJa0NZ?=
 =?utf-8?B?V2lKWUN0SmhndDdqZEtrYnlEQnBBUHFvQldaUXpNa3lIVEVabEdHYklWWkxX?=
 =?utf-8?B?Ujc0S0hwRlpBRkVTS3FjdFBwL0dHWGtCSklXYUJhVGZjblFvZk02d05XbHFJ?=
 =?utf-8?B?K3VGM2lPZzAxWkxYa1pLRU03dW0reUFvOWNLOEJLaVlGQjIycnhLaGtPQWZn?=
 =?utf-8?Q?EpdE6j2J6+ZavmcxLZiQeG6tC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16754b24-3459-46e0-7a37-08dc961ce8af
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:16:48.7906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlC+R7Dl1bYlse4jT5/TOvK7mkME930fqBWJDV1hq4TYqzR0NhcbBrtUXWkCam9yn8ozriFQGcZ+jqnN7c7nhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 6/26/24 2:31 PM, Marek Olšák wrote:
> All this code has undefined behavior on GFX12 and shouldn't be executed.
> 
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 47 ++++++++++---------
>   1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index bb534b2b0b71..5a6a21e28548 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1419,8 +1419,6 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
>   	const struct drm_format_info *info = drm_format_info(format);
>   	int i;
>   
> -	enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
> -
>   	if (!info)
>   		return false;
>   
> @@ -1442,29 +1440,34 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
>   	if (i == plane->modifier_count)
>   		return false;
>   
> -	/*
> -	 * For D swizzle the canonical modifier depends on the bpp, so check
> -	 * it here.
> -	 */
> -	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
> -	    adev->family >= AMDGPU_FAMILY_NV) {
> -		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
> -			return false;
> -	}
> -
> -	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
> -	    info->cpp[0] < 8)
> -		return false;
> +	/* GFX12 doesn't have these limitations. */
> +	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11) {
> +		enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
>   
> -	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
> -		/* Per radeonsi comments 16/64 bpp are more complicated. */
> -		if (info->cpp[0] != 4)
> -			return false;
> -		/* We support multi-planar formats, but not when combined with
> -		 * additional DCC metadata planes.
> +		/*
> +		 * For D swizzle the canonical modifier depends on the bpp, so check
> +		 * it here.
>   		 */
> -		if (info->num_planes > 1)
> +		if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
> +		    adev->family >= AMDGPU_FAMILY_NV) {
> +			if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
> +				return false;
> +		}
> +
> +		if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
> +		    info->cpp[0] < 8)
>   			return false;
> +
> +		if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
> +			/* Per radeonsi comments 16/64 bpp are more complicated. */
> +			if (info->cpp[0] != 4)
> +				return false;
> +			/* We support multi-planar formats, but not when combined with
> +			 * additional DCC metadata planes.
> +			 */
> +			if (info->num_planes > 1)
> +				return false;
> +		}
>   	}
>   
>   	return true;

-- 
--

Thanks & Regards,
Aurabindo Pillai
