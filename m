Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BC0C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A483210E064;
	Wed, 26 Jun 2024 20:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JW2HZlwN";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A5F10E064
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeJRlDOrpnJU6QiIhUF3EgQDOjge8TcJGr1xNbfwrPRkIXo9O7z2S33GkOtCF/zuUHiDmf81oaIa0SReQ7o9gfASmqKcWOE7YMQNwX5Ynd3S19qa/598hoqoTFXGlq1b4QlxEjO5VnMNbOo/VOFxxzkES+B1/L4Ux0JsCzZ/7yk2SpxjHM8VMejb3COa+/a60AU5euOof5ZYMZr172+/QZ8kWGh4LpYICaAb3Y3fu35SMK6vbSU4NHNQCbqfDQVluHvrVRoCAybQ4OU1QBN0Je7enovCE5poCx5n6ZN0ajokog17Cdw0SREboNKBH5ULkheWNq7XuPKDO/Qhjzm61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o61sZQ6BBim+h6BImds5cElUjKu9QWKjrQZ4T/1YxY=;
 b=moX/8NPcmGzEYszXSbVbU/LFRYbuZHmQThlUrJ0BpYds8Q4HcbkpPa1BCYlXUgqTqI8UPaqo15C/Vw9AsviNckp4jlIY6owdes7DzHZ9dbjr1X2qyDnnziBvjLtOCND4lcF6UE2fRQc/IahihsBX3RoLY4pqaGn97aympdK4e8O6EQ5avtd6FKof7KjVLqdYf+YEi1WxlZY+u2YyCfeHSvNqM5mBOEL+77XFokhMHiKCzuXOxwRVfMUdNIOntlXJj11s73ElnZ8cC8zHq57OL8gAArgunF8MpYnQ6dyzXTelcYjNB23SvMzUZf/gpyy+Q7+PhrZmdcVnkGVChF5a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o61sZQ6BBim+h6BImds5cElUjKu9QWKjrQZ4T/1YxY=;
 b=JW2HZlwNXK4OzpMJjIkN1tfZS4nBvCGnWhkszouPBDmpCO3J+ixLLkn5F9/zC7ix/RGCueguJYMiQI91b/kNMwJVM50M1MTXGzKrOAOsRdivl7Wss3Gi7w8EdEOUJ9/4lxj/18A1jyzGLOmla2hzOhdzIx9KAzocCGHUnZ5YLB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 20:16:28 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:16:27 +0000
Message-ID: <b25476c5-0d0c-46cd-871f-b9056e25edab@amd.com>
Date: Wed, 26 Jun 2024 16:16:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/display: handle gfx12 in
 dm_check_cursor_fb
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-6-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-6-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0086.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::20) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 316ee552-5e1e-41e2-e494-08dc961cdc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDVLSHRVM3BkdWNkdlJGcTlTcVlpWVMxQm1TalNqTzlyTzlMQjdGU1V5WDho?=
 =?utf-8?B?MkI1MFFjTFNkSmF6NHRIZ0pjUUdGS3lqNHp6OFA2b2hnZmh4TEFEQllMbXVu?=
 =?utf-8?B?KzJUaXM4NWlTdkltcVlSWTZQK1JuQ3JFUytFUTFpblEzUm8zMnNyOE11cE5y?=
 =?utf-8?B?Y29mSzJsMnZqWXZVTjlsanVPMzIzOFdXVjB6ank1WHhFRzRza3B4WHNtNVI1?=
 =?utf-8?B?M2hzTzd5d2JGK3hPcUtMeXBLL2hsY3VqaW9hNmk4WllwRW1pQTQzMjlnOEEr?=
 =?utf-8?B?ZlNSSkxaYjRhc05lZHFxYVpGTjlmV0h6MzhKS0pveWxDQ0hqRVozSEZxd3Vz?=
 =?utf-8?B?ZmQ4Tlp6dGcvQjFvZEZrczByRitEcHNRaXg3K3JJVnlRVzdnMm5xa0NhYy9N?=
 =?utf-8?B?T25YRHhZaVZYYjBtWkFmS04vdEZteTJRSWhBRnM1TG01TnZmL3VFV1FYUVRw?=
 =?utf-8?B?RTVSaDZHTEprV3MwMzA4N2hKd0hMY2M5d3RrRnIyTGp3VmFEakZPenpGR2Fn?=
 =?utf-8?B?WGgzT2FzOHFwUWpuazg5RWthSUtPWmdIZFk2Q2psMTA2ajBLWEY0SVFhVFlk?=
 =?utf-8?B?YzJQTFNyUzBNU3R4N2VRNmJSaGRZYXVXWDBoSzBCV29oWjFsekRSQmFPOFdx?=
 =?utf-8?B?QzZlNTRVNkZ3dGJmTzJQUWFVaFZudXV2R0p5Ukw4UDJid2dDaC93dE1EK3d5?=
 =?utf-8?B?c3Z6a2RFV3lGb3VXS0JNbHlabDlyK2J5aFBvbmxEOXlRYnViS29mUldwZXFz?=
 =?utf-8?B?QVVXVHhrQ2o4QW9UN2pxSEF5amhBeDZ1T1l0TEVkM3h6T0Qrc0toMjF0VmlJ?=
 =?utf-8?B?TitpNHhVdWtFelJlZ0hjTzJiWTFIN05lMkcrVDRaTlJ5bEZqYTRWOTY4aGNX?=
 =?utf-8?B?MDY5MVNwZEc4WEh6T295N2pWMnZzbG5iZUF0c1JnSHNtRGZOSlpnREdycjN2?=
 =?utf-8?B?OUlCQUZ4NVh3amhUVHpBL0dhUkZtOUZBNGZWRk14Q1A3YkJ5REJ0M3hGSndR?=
 =?utf-8?B?REU2ZVhIVHhGYjJkYTVuNlNUekZmdWlkaTRORjEzdzUreGptb3B4dVlYYTRz?=
 =?utf-8?B?YjYyR3JidlYvYWtoUThaZnZIck9WVnZXQnBEVXZXa29WM2NrTlpndzI2MzJ0?=
 =?utf-8?B?aThVeHVOc0tmRHhWNmR4ZVg2MHcxUXY5Sk9sRTNoaFZOQ3dlZmxSRDNyOXBG?=
 =?utf-8?B?MzBqWG12R3JRYWhZRXozRFUzT0o1cDFLcTRKeWJJekFhQWE2VWNiWGxzTkcy?=
 =?utf-8?B?TGYxM1ovZ29WOFlPYm9Ka1MxMTdZTVU1amprSTNydHZUcHlrcFMzbnBOWUZV?=
 =?utf-8?B?aUp1Qy9VbVVnOVRaU1JnTGtyVzNJMkVXZTFsYW8xM0dTNWxCNWRjMFRnNWxH?=
 =?utf-8?B?SlMzRGVYMFR5YlU3dklRTFFWMXN4UzNiK2tSWGVSMnNRcEJoQWV2REpPa0Rq?=
 =?utf-8?B?UGF4aFBIQnkzTjZMV3dBTkIrS09EUWUzeVppRzBKN0JDWkNsaUUwRzIvZnJG?=
 =?utf-8?B?MkJJbmxLeHZTM0tvbDVSZVhNUHQyMlQ1TlBZcHEwZU1HYUMwV2tZd0xMZkRG?=
 =?utf-8?B?QVpKcllrK09pWnA2Njd5TzFURFJLeHJncS9Fb0NNbHJzdVkwaW5oa09PclFz?=
 =?utf-8?B?RTRXK09HZnAzTGIzUm5tT1JGU1pleTgzdHpWemt1aGtMNTBzai9vVm03NXVv?=
 =?utf-8?B?R1RCN3I1R1RydkxqYlY1QWd3M2xBQm5VSCtuSjBpUzlPNkl3alJtdzEzcUI5?=
 =?utf-8?Q?KVYRQ1Wg9yJ2K73dA/YrwcT5lbxDg8TKSxDISFE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(1800799022)(366014)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURtZ1E0eFlIOURRUGM2cXY0eG9NSmk4V2U4VXlIZGtuc0RiNVd4Q2JGcnFq?=
 =?utf-8?B?TEdOK2s0bjg4TSt6aEZLWVl2ejUyRGNLczZFcERQZ2dSRUtFRTNoMXRIM3ZH?=
 =?utf-8?B?YmtCZGpIc3NJUUhFYi9iUXVDY1RQRWViM3AxTjZ4aVAyRUpTZHlRTnZyV2o3?=
 =?utf-8?B?UEI3RFRmOTNpNWFzKzNVR3F2SzNDaHkrOGNZWENWdTZPMXlqYXk4QzZlTWNX?=
 =?utf-8?B?SmIzSm9Ub0tPQVYxZXlDOStzbi8xK0hwM3BqdDRvb2luL3Q5VUFXNlFxb3Fp?=
 =?utf-8?B?R01ib3NlMHA0U1MrTGtwbzNFem5SaVpzNXRrQzRKaU82ZTBRRlN0WVhMK3No?=
 =?utf-8?B?WXpPWWNQZWZ3MmJLbWV2VTJxRW1LZkVrc0sya284bG5mMHlJYUZORzRZVXRU?=
 =?utf-8?B?eXY0ZzVxY2RzdGxwdENGdDlhTHFJcmZ3Zm5Yb3dOdUVlVURzejY5UXRXTEtz?=
 =?utf-8?B?eWJuY3VxNVFEVm81VDVNL01HRW9Wa0JCdW1ETVBUdDlDblFjbUxldjMwYW9N?=
 =?utf-8?B?OWF0MytJN3hLaXF5azhxekZxY2xTTUpjV2RDbFlQcUl0amp5Wk1zbTErRlhZ?=
 =?utf-8?B?N0NOQm9XRmZIeXRKYVI5L2Ewc3A2TG1GVksvdmpXaE11ZHNiVHp4TTZPVUl1?=
 =?utf-8?B?ZmpubWxsY1NQbGRTc3ZTdXJldHNBYWVMeGZRUkZqbm9NeFNNczFJQ3dNUDlq?=
 =?utf-8?B?akZCUW9Wd3JwN2N6VmV6L3dScExqRDlTMUcveXVEUHp0VE9sYUs2d2MybWpp?=
 =?utf-8?B?OUFiZmh4VkcvcHdMVjdyNmtmRWtRSlg5ODJBc1IwMythTWFGUm1vei9KT3Y5?=
 =?utf-8?B?ZlFtbEI5M1pJVkJlaC85T2xubEJKc2RBSFdldlJUajhsTDVHenA1NXJhMmpK?=
 =?utf-8?B?eWo5MUxGakJrK25jc1pJK25kSUZGbUVGV2JNUk1IbmZSdzZRRllyekxkcHFR?=
 =?utf-8?B?dXlnYWpjMzZKVk1hMSticjhkT3lvT1lsTE1HeDdXNnlrSmJwYkJJY1BTc1Bv?=
 =?utf-8?B?YlhHYm5jQ1cybUZQS3ZIM0xSL2JiMUpHNTU5eWNyemM2SlJIVk1Hdlh1b0VN?=
 =?utf-8?B?ZXpBcmZOZnlQckpDVWJnNUN4dzJCa3p5YzlqamRvd2NQVUF2UWZwTUszVTRr?=
 =?utf-8?B?YlVrRkk5R09JRURoWnhMZmZQZnMreTR6ZHZJWlVaT3ZNRU9Bc2FQWWM3MnlR?=
 =?utf-8?B?Zjk4Ky9SeFNMWnhCVGZwUmM3K0FsWGxSN2FyQmkwM1hrRXI0VFQ2dWV6amdM?=
 =?utf-8?B?aXBXR0I0ajNCclIyN0pDY01qZktSYXZTbjJrMkVMOGFXV0pEWlpuL056dEtV?=
 =?utf-8?B?VGltODVCOXMwMXh2eUExTjdaWEw3VHdxcHUwRWdjM25obE1mSDRqamI3aUlr?=
 =?utf-8?B?T1dZUUFQSzgvRmg1WnYwdityZzVMSUxWWVRnYTdxaUIrbVR1NVJmUzBsZSt4?=
 =?utf-8?B?M1JjNkNXRzI2WXUwOXhNWHFUK3pPdEZMNzlObnVoQXdwSEZHZGVUR2Q4Lzgw?=
 =?utf-8?B?YXhsV2R4MCtvSzQ1VVFGTEE0V0psdGplQzRzYTRtTGJoYXpiM0FwWXBGYlky?=
 =?utf-8?B?Ryt0NDkxM0NpazRXQ0FNSlVGejgyOUVQN0FKSmlOZkQxUnVDM2ZPcFU1VmJE?=
 =?utf-8?B?NURKMEpZQnVyM0wwYlprS1hpUVZ2U01VdFlkM1A1Si9JdlpUaWdMNTJQV2dk?=
 =?utf-8?B?d21oNWxUTXMxWFROQlRiMWpxNFAycmgwamRkMS9zUVc0aDV4dm9QZFJjOFRK?=
 =?utf-8?B?eUxLRXNtZkVCdlZSb2RLYWpVdWM4ZzNYMDhZNDFURmNvMGN3SnpWMlc2L3Ex?=
 =?utf-8?B?blJ0bFhZQk1yK1gwaUQxd1UwMUd5TEZOdHVTSm1kanJjUVdQRmFlWnJpNUN2?=
 =?utf-8?B?M0dWYURPR05wWFF1OEhRVjNjQit0OU16SU1QcU00UytlWTlZOUVzZ0hDdDZz?=
 =?utf-8?B?L0s0YVlJSUI0WjdPSTJwYi94T3J4TzJNaFJxS1BGS01aTWQ3aHpqd291NGNV?=
 =?utf-8?B?NDkzUHhzNWhzOW9uYWppbThUNG5CZ2JzWFhrUmd5NTBDOS92eUZYOThMYmlU?=
 =?utf-8?B?ME1wcHk3YVlLelNpTWthRHVjVXR6U1Fjd1pFNmRjeURTYjlvZldNbnlGdGlL?=
 =?utf-8?Q?MmhpmjNlKttvoG144jIwuzZZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316ee552-5e1e-41e2-e494-08dc961cdc0a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:16:27.6805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCI1Oi4m0YjlIU6nt43QNaMatxn9CfJDBhiq/ubuJEfpi6RT2rbToya+IcsqGN0Xh2//MoMrpSdA/zqQLZmuvw==
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
> Checking SWIZZLE_MODE has undefined behavior on gfx12.
> 
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f99ba6aa6a7..c3347e8bee54 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10666,12 +10666,14 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
>   	 * check tiling flags when the FB doesn't have a modifier.
>   	 */
>   	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
> -		if (adev->family < AMDGPU_FAMILY_AI) {
> +		if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
> +			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
> +		} else if (adev->family >= AMDGPU_FAMILY_AI) {
> +			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
> +		} else {
>   			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
>   				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
>   				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
> -		} else {
> -			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
>   		}
>   		if (!linear) {
>   			DRM_DEBUG_ATOMIC("Cursor FB not linear");

-- 
--

Thanks & Regards,
Aurabindo Pillai
