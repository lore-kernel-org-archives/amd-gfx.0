Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BBC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 09:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199BE10E389;
	Mon,  7 Jul 2025 09:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIoxBdgq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32EE10E337
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 09:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2RmT89F7wAN8OsB8zZjChoHOilqtgzuT5d5OBIxRK9sAAbUdpIW/h48IFQheIv/bS2nFPNKKs5WExBfzgD5oOjvx+S2mKdU8K4y53gA6NBB5OqocD4FixYHKnrqf+WrYVK2vFL/XJZkh0mDjnn3dlxY8saiRLz4ogFZK6goV0XPwUscsth4i5sAwCWMAlxGd9jLt+xdFpF1IT+Uzzknx70W82ryBeksImT/UzdPhL0y69bobtMurkuiAAm0BDMc0NRwSwVpM2kO6sWW6zvIQkOe3fr8u9xVsArjJlgIGeJHymSKjlUHIeOydxsfZ7c/moE8oijQE2DcHdRdcSP2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/1FisTxOf5PrarCvFieLtbxOwgtuEbWCE62RA7JLHk=;
 b=Jlx3QaEYDO2OWvJ3rrp3fFfeLP5MDpuQuR8MMSmzoEsb2H72f6X2VdO5OLKXfp94H3/KnNYB5LgjLXywV9fbq6X+H2T5LddU1ZDRE3JbNaFJg9nFae2Rb61Ov35rL2tgeiOBvDA7CDs9agjMJd4dD6CzrRXOgXeHA6agC5ju0Cjlu5txbQFbNcRltCiVQfUzRrOCVzlXzy+4zba5mUER9bSt+/a18RdxSnRUcoATOhREcFBfhvI+g9nbGxVOGMO8fmR9ZuK2LNG0WjSzitbu5CZ7t2iQlSzG1xRrMjlhoDoEmtKlsGIz1Zz97h9DqXV0LgLodPl4zEZqfRgLEwou7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/1FisTxOf5PrarCvFieLtbxOwgtuEbWCE62RA7JLHk=;
 b=EIoxBdgqwujG0AQFD145+2o8Lu64vdVx5lVZIBFnJIOcEr5ZQJ8Pp1rSPTrmARJH3aESS5eR4XTP6IBtvhX81LIhvzGLFbNHrKsaG65mYuywQaRkq12O8b6QjNLc0/LWGMY6dO8MOi1C9SHZodQ84Fq7Ed4cOEUpVreUYyg9TdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 09:37:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:37:38 +0000
Message-ID: <ce86ea02-f0f2-4f09-a168-22f89c9efaf5@amd.com>
Date: Mon, 7 Jul 2025 11:37:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-7-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250704103308.1325059-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 9801cb22-b199-4726-b057-08ddbd39e924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG04OVo3Sk1oNE1WdVRwelV5aEo3YWp0ZjBOQUV2UXdNR1V2MkxDVkNYOWQr?=
 =?utf-8?B?TU11L29iejJzYytVODRGSFlQR0RDYktqUFJHR0lMUGJQU2hZVDF6Wndhd2Vz?=
 =?utf-8?B?WUlSK2d6V2xLUVJqV0ZxZ1BBRkJHTEtCY0xlRjM3bVYydzRnbmNWUDMxUlkv?=
 =?utf-8?B?T05YLzdZSWk3WjM4UVc5dTNrNVZiRVJxaXVhQk1TbVZ0dXd2Sk5wUXAzMnVw?=
 =?utf-8?B?TUFuaEFTNjlxbFdXa3pzTUNjWHJBZHJTM281aXBTdThxVDhVYU5qeHhDZHp0?=
 =?utf-8?B?bWJGbTNYeGpEMFB0TXBLakRWcC95L1drY3FQRUVCZ2ZnUnY0UXRNS1o1RFVk?=
 =?utf-8?B?QnRGZlpPUmYrYlMxWlhFOTRYaHdyVzVVckpIYVdlZUU2dGg2M2FidzVFZDF4?=
 =?utf-8?B?VzlkNXplSDlNK1plVVQ1UzFJQS9yQk4zanZIVkxpcWJPYnRZSDBPclJ4MzYx?=
 =?utf-8?B?bWY5dkg1VTFJUTJXOEp3dVg0YTFIYTNVSjJBU2FHRVpoVUpyeEdSUXU1ZkVH?=
 =?utf-8?B?VzRVK0Yvd1doR1B1RHVWR1l4RTFpc29rYUxGNFFKWGl1TWJaRnhVdFBsM0I3?=
 =?utf-8?B?RTNtUEtmQU4rZ0M3WWN0QjRTeHhhLy9ScjM5ZHRiREVCaWFIUXJkdUJsdy9h?=
 =?utf-8?B?VlRuSFlZUG0xWGdNOXh2NDBCMkpHWmViQmhCamo1L0ZEekpaUW9XY21xRnh5?=
 =?utf-8?B?MmU2V0IzejUySG9YdWxSQXJnTDlXN1l3K29aaXZid2hFazhCTEdFdU1TVG1R?=
 =?utf-8?B?KzBPTkt2UGpwd1B6ZEUwenMrd3JOU3h6V3I0Y09ITXhyVTNiVGRRQldsN1kx?=
 =?utf-8?B?YjRjd2Y5aXp3Z3ZzMitwazFja1Y0UlA3ZXZDRjdXQWdwT21EeXFvWDMzUkk5?=
 =?utf-8?B?TFFjVDZScVZJK21oei9UZkZXUGhHSm92WGtjeGs2VXBzZENnalpHdktycm12?=
 =?utf-8?B?VGtNcW5LN1dLTmFMN0hYVHZQOGFZNzBxMDVlWmNkMXdpSUNaK0VQZ2VUandK?=
 =?utf-8?B?VzFSTU1oaHVGZ0JFNEVJT0dNVkdBb0IxWHQyVVF6UFpmV041S0p4TVFwbmox?=
 =?utf-8?B?RGtqbklPQjNiajdKNE9XcnpuSVpMTEs0Qm1SSEllcEpvSGcwMFNkOUJoUC94?=
 =?utf-8?B?MGZQSDRObHhhaHZweXVkYnl5L0t6K1RlRVNWS1ZuWi9LbU9HWDVWZFpjV3N4?=
 =?utf-8?B?bG5iVkxMenpRdmxQL1B2ZHlLaFpYUjgxanRyQWh3SkpDUDJndWdNOVZlSFcv?=
 =?utf-8?B?WGVnZzlUbXVDSEd5TjZXZVo1MFJ1K1pBMnRkTEVKTWJpNE5OTEREMEpGMUZU?=
 =?utf-8?B?L0hKSHZvL3lFN0QwdExnSnk5Ui9pSWwrMkJWamwvQVdjRTZMM3RicW8yU2lL?=
 =?utf-8?B?NWpCSFdjWkV3Uy9kMENlRTZSUEFacVhyY0syZGFucWlHaGtrcjFsWm44czZQ?=
 =?utf-8?B?b0RIR095UHlqWnYyeEhZMTVBTldHM0pjdU1LM1BrN3VvcS83RDNXdFdTVlVw?=
 =?utf-8?B?MUhoeWcrVmxpeUN2blVYYm42K0hiLzRDbDErQ2J6YWRtVXRoWGlQejVHNENY?=
 =?utf-8?B?T3pmemFBdWJEQjJ3cGRyU0htNHk5YVA2S2NHQ2IxVHBOaGdCVllCcGhPQkEy?=
 =?utf-8?B?TnZrbTdqQzZYU20wMWhROXdLaG5PNFAzanBUalZpSFhPWjRmZ3ptODRVb0hy?=
 =?utf-8?B?ZEkrbzdQSmxsWi94YUdsbU5HUU8vSVBCYzcvZCtibVRXRFREbkVQWHFvYmls?=
 =?utf-8?B?MkNsOWFxVWd2bkNlcU9kQklzWTY2bE5URjI0ZkVEYVNBSjBSbXZOUndRVCtm?=
 =?utf-8?B?ZEFRRi9BcDdTU1NXSlBObVo3Wk45TFpNdVU2Ly9rcnR1NG9aNUFnUzN5M1hq?=
 =?utf-8?B?Y3hFRGdHcTlMeGF2WjhhVnUwMHkrdGp1azI1VkYzNlpTV2wzdjhsZ05GOXBy?=
 =?utf-8?Q?G/0UtPcrcMM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2F4YWthUzdWRHhYellINDVpYS9QZEVQQTc1cWN3Y1orbjVZZVl3UEdNVm8r?=
 =?utf-8?B?dlN6c3hFWENoL01XZWM2Vld2aERPS3RsaWZaMG11NlNwM2ZpRXRaaHVTeFd4?=
 =?utf-8?B?RjVjSTdEQzdQRkxBT1ZVeXhMK3NEODJ4LzdweVFVazhTVnVubnVOM1pYVEpQ?=
 =?utf-8?B?aU5wRjVLY2doRlRVamZyY3BxNzlOY2tINlp0clZJd1A5Lytyb3dZWmpObkYw?=
 =?utf-8?B?VTZpOUVVUWlLdmh1cy9KQXdHSWNWRDVjVGpVb25mVlFIR1A3R2tZbk9wLy9y?=
 =?utf-8?B?dFE2TitzVmwzZmFkMTUyQVNWUVpZMWVOMjNYd1JJMlQ1emxzTWw2ODMwUzg3?=
 =?utf-8?B?SWNZVzFTTjRzYkUvaEhBcEFGeEo2NkR3SXZtS3kxSEI5ZFFnQ0hJRkdPYXNa?=
 =?utf-8?B?VnlTbGdIOFVFZ0lTT2h1QzBVZndDSUNkanRaSXZ4algxYzlTR0lVZmpaMVdQ?=
 =?utf-8?B?d0NvN0prUkp6NHNUbFV1dVFMdzRhK3p2TFVDQXF2OHNTVmV3Nmh6QStWc0Ez?=
 =?utf-8?B?dE1jMXkzeHNXVktNWkFDVzREU01XVjNmQ1hRazdzQnRNbVhHTnlvSHhzQTkv?=
 =?utf-8?B?NUpsRHRyZHUzL3FCNld0cEJydHd1VDRSRXFEVGF0NFlSL0JsSXNBV1NCQ3ZF?=
 =?utf-8?B?Z1FuQ3dlNmRQQ1pnZWZ0NFpEVkhOckRwdEFvLzk0a1ZpSXN2U0pXZnJMN2l0?=
 =?utf-8?B?OS9WcEpQR3lycHpKc2hXZi84dmRKTDhldjRzWURlMlY5NnJDdUhNdE8yUVdG?=
 =?utf-8?B?YzF4M2tRSnkwMEwwVStHQXV1a2l4bktIQit6SExLVm50TyszSG9KdEdmS2xX?=
 =?utf-8?B?U2VkNmw5OVFhK2xNS1psZ2dNcFRpNmR6NGlVbFdXaFpZaTBwWXJha3l6L2RD?=
 =?utf-8?B?a0Z6VlBYTSszYzU3d21uZTBrSk85VmVOZzRGdHg2YXNLeTBibjFuUkdLTndv?=
 =?utf-8?B?amRzVGdETHR3Z1Y2SUdER0Z2alRyV2tYUThlbHhuemhQczNDNWpCRDZZb3Fa?=
 =?utf-8?B?Z3U1Yjl4MjhCeFR2TFB6MFhVbmQrcStlRkwvQStDUUg4VkVub2Fkd1FIb0Q4?=
 =?utf-8?B?bldoNnNEbUU5WnlONWxsYkg4VExiNkZrQ0V5RGxhbklobGlzclJabXhjL2lR?=
 =?utf-8?B?RVM2Wm9hbWdsTmVCMEIrZWRmMFRBOTF0a0RYQXkyb3owellnajJUMENYM0NE?=
 =?utf-8?B?alF6ei9YWFVpMy9ibDdTTEtrRlF0V2RXazJMUENaVGFhN0JyM1owOXA1aTRJ?=
 =?utf-8?B?YjdQL3I0OTd6MjBJa1NMVFVXZUZ5Y25WcEl4NDlGcitDUzB5RFN2TjRsWUI5?=
 =?utf-8?B?VTZsK0tlZkN0K3N1cnQ5Q085SnllRW1BUktnWndzTGlPcG95TWZ0YUhBNGYw?=
 =?utf-8?B?aEVIcFVqVG5oTXl4UlY2SnJCYzE4d0t3YWhMeTRQRXFWTGcvOXhQNUc0a2gx?=
 =?utf-8?B?aVkxcEZkczN6VjdSeGxsVFNVTUVjY0FQekNudjZvWllpTmJxR3U5V2Z3YXZ4?=
 =?utf-8?B?dThROWcyMHUxeVNxbmVES205L2c2MERTekE2ckx1VUxKYVViWXhnbys0cWVw?=
 =?utf-8?B?akwxcWxtUEF0NDRwR1FzMDIreHZPZjd2NlVQcGZLOXIrdlNrbG1uRkR1WUxs?=
 =?utf-8?B?WlN5SXNBeHRnT2N5bmNmdFNrQkRxQS9GWXc3WmYwb0prc1lEaHhSUXVpZERs?=
 =?utf-8?B?YWMvZWFiR2I1S2EvVG9ka2hIb2l2a3FBQkJ1Tk9nWHlLZjFURGRBNnp0T3N5?=
 =?utf-8?B?NHBmcHdJZHJRcyt3VVJvcDlOdmNHUitybmVnd2Fjd3Q5bmtYcnE3Z1NCNm1R?=
 =?utf-8?B?dFZTeFdFYndxZW5taGV5cFphZVVSY0JUUW5tTDFPRGlJSWlmN2FFY0hzQ3lr?=
 =?utf-8?B?T2VnQThsa2VkcXl5SVFXbmxGZkdmcXZLZmRxYXR6OEw5akNrSExWWGdmQVI4?=
 =?utf-8?B?M0dsR1U1dG1oKzZpRm5hak9Qc1JIU3U0RC9kQ2FMUzR2ajJ3TGQ4OVVvVTNQ?=
 =?utf-8?B?OTQwNy9DdzRKT1hhSHVxYUozTDlySmRxdlhuYnV6ZGN6SlVMbmdiM1B6cWp4?=
 =?utf-8?B?cktnWndMbUpWc3A4ZVZkVDBBVXBTQVltYVZMZWw1elpmcFBMVDNxNjFDc2NJ?=
 =?utf-8?Q?wcdOALWG70I7T2TTZzKMr9TLN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9801cb22-b199-4726-b057-08ddbd39e924
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:37:38.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv7aRJEMKLlS0KZSCT5NUygTIrKxKUrCAjxsU/ENw+MqDiyduDDGEybderrTYdMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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



On 04.07.25 12:33, Prike Liang wrote:
> This helper can validate the userq whether can be
> unmapped prior to the userq VA GEM unmap.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 78 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 25a35ab7395b..30838e5279bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1180,3 +1180,81 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
>  }
> +
> +static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
> +							uint64_t va)
> +{
> +	va = va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;

Still clear NAK to doing that here.

> +
> +	switch (queue->queue_type) {
> +	case AMDGPU_HW_IP_GFX:
> +		if (queue->queue_va == va ||
> +		    queue->wptr_va  == va ||
> +		    queue->rptr_va  == va ||
> +		    queue->shadow_va == va ||
> +		    queue->csa_va  == va)
> +			return true;
> +		break;
> +	case AMDGPU_HW_IP_COMPUTE:
> +		  if (queue->queue_va == va ||
> +		      queue->wptr_va == va ||
> +		      queue->rptr_va  == va ||
> +		      queue->eop_va  == va)
> +			return true;
> +		break;
> +	case AMDGPU_HW_IP_DMA:
> +		if (queue->queue_va == va ||
> +		    queue->wptr_va == va ||
> +		    queue->rptr_va == va ||
> +		    queue->csa_va == va)
> +			return true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
> +				uint64_t va)

I don't see an user of this function?

> +{
> +	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +
> +	if (&fpriv->vm == vm) {

This check is complete nosense.

> +		struct amdgpu_usermode_queue *queue;
> +		int queue_id, r = 0;
> +
> +		if (mutex_trylock(&uq_mgr->userq_mutex)) {
> +			/* If here the userq bo is busy and needs to deactivate and prevent reusing it.*/
> +			idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +				struct dma_fence *f = queue->last_fence;
> +
> +
> +				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
> +					dev_dbg(uq_mgr->adev->dev, "queue(id:%d) not belond to vm:%p\n",
> +						queue_id,vm);
> +					continue;
> +				}
> +
> +				if (f && !dma_fence_is_signaled(f)) {
> +
> +					dev_warn(uq_mgr->adev->dev, "try to unmap the busy queue(id:%d):%p under vm:%p\n",
> +						queue_id, queue, vm);
> +					/* Need to set a resonable state for avoiding reusing this queue*/
> +					queue->state = AMDGPU_USERQ_STATE_HUNG;
> +					r++;
> +				}
> +			}
> +			mutex_unlock(&uq_mgr->userq_mutex);
> +			return r;
> +		} else {
> +			/* do we need a try lock again before return*/
> +			return -EBUSY;
> +		}
> +
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 194ec7a6b3b2..08c49d738ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -31,6 +31,7 @@
>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
>  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
>  #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
> +#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)

NAK to that, the VM should not be casted to fpriv.

>  
>  enum amdgpu_userq_state {
>  	AMDGPU_USERQ_STATE_UNMAPPED = 0,
> @@ -148,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
>  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
>  int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>  			struct amdgpu_usermode_queue *queue);
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
> +				uint64_t va);
>  #endif

