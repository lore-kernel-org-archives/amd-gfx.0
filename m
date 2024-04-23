Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A04C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 07:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529FC1131E0;
	Tue, 23 Apr 2024 07:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fz06452";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3EB1131E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 07:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE8JtDx1mWPyJL+kJjVZy1axG5hJ+sYRWXRFBmBu/ypvPGXWbUVtJD7KLUyyQwPjzm1Ru3LTTxGZC8IQbhAgT31YHxClzFbbFuQZeSwyUkTUgr/XIKoHOTA8oJ3dJqdKOIPYCjR+yQ7DEG81/Lb+UWb2xoE2cUqF/iZn3Coof/BXjLhGxP+ZvqmAceZ5VHpAYE0rUtFdyX/9XUsmgQAQu61WlBzelrYpVaHB1Tw4WbxJ8vqIrOf5no4ZOPlVnco1qhbqOD/73Q+it22W6cfI5IVg+BVySNu6p5WdWEqWRvDLy//SVMQjKSeovhREWu5C+jiHFeNGLo7SD9Axwhw9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXy8jJSrC2W+WSKgqWfq6tT0d4SUbITkztB9bTz6gBk=;
 b=UEk4NfRvvpkjsWM9P7q49KmyP18Qjndt/Vjo/EfZzYG4uLWQ7o0b2AIJTmyZsYgQqNQm+NokkqWrbgpauS7mkicY59LZ20WWC0p2yJw/5bCYsLXa6HsLRpT4MeiRitXPO30cG1+11HwLlcZ07Edt0Lrt+xmFh8aBQgbd//S4AisNAAkEbX+cM8tY1coCcIbhBsKDRg67feHuPczeJ//ESXGR5Vh/AtkC/2L1LKlinSZbnfR9o/2osc7vD4oTH8jaRt47wdT4Ngx908Ndo2mqyBSqyAFROwLRPzzFKPmBqVe3HDiZrVxMSJjQwb4XGB4nUhzQtZU4ZaA+UC6wh2fcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXy8jJSrC2W+WSKgqWfq6tT0d4SUbITkztB9bTz6gBk=;
 b=0fz06452DLjZsYqjraIla0FPZLHDg4h2WdrBggu4JqDfaTuYTawTmSxxGraG5FFeddRORpzUm2kGTu5Rr4koh/EfNI7F1/BYYULoOAhXb+o0DHX9XE5GBhYUsLw3pJTRJ5nMg4dYFaSLRyoHg/kFQEzlMEQgFHXYmQeMfR8W8Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:42:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:42:49 +0000
Message-ID: <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
Date: Tue, 23 Apr 2024 09:42:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
To: Tim Huang <Tim.Huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240423062853.1022925-1-Tim.Huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423062853.1022925-1-Tim.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 2943ddcf-efb2-4d5f-9127-08dc6368f959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VllyU1g0TzFvT1BadWxWNkRYdW9ueGJCallqWWVCZ3AyMlgzM1hLLzZMTW9j?=
 =?utf-8?B?d2hhWEorQXRXWVNPanFBR28vMi9HS3VpMUdRdDRVTzVSUE1PcXNnTElya29a?=
 =?utf-8?B?aS9xZHEzMFIwSDdLVitpWENGcmJGVXRQOEg4RjRpYUVpNlkyYjZnQnkySmNs?=
 =?utf-8?B?SThQRyttQUxuYjI5UGJRemc2dEZUQ0daZ2JwWjlRWnN1UWQza2JpbWVoVXNE?=
 =?utf-8?B?Zk92ckwzUStxV3VQZ0NucVdTZkhUbys1aHMxZUZwelAxV1JYYUVIY1FaRUs3?=
 =?utf-8?B?SU91WVhWUFBWbm5iZWdrVnRlMlRreDQ3ZGNzTExwY2JQdkJLNUwyVTU0dlY2?=
 =?utf-8?B?UThBYTF6eXE0bGlXMDlESjNFd1ZmQ0RaTTZvZ3g1WVZTaEpJRnh1d2JDK3BS?=
 =?utf-8?B?TVdOa1V2S3RObVVvazl1Tk5XakI0TFRDclhnK0crTDQzYjVaRElmdlBnNms2?=
 =?utf-8?B?OTRJck5VTTBUSHVobXdWTTB1Yk4rK1JheGtQTTQ2SU82RWh0bXBGOGgzTEtq?=
 =?utf-8?B?bjFRZVk5Z204TVN3SFpBckh6K2ZRZ2NhSlJrWDRZdTM2NWJVT0xzWFR5QWRo?=
 =?utf-8?B?OTVnYWNYVks2MElUTmJFZElBOXpxSUZ1dXh5SkNTN2NySmRycDFWNVdjVFBB?=
 =?utf-8?B?K0dZK2x2QnlqVEt4aVk1ZmhLa1BSTExmVXFabjlaZUcvOU4vcnQvM2tQdHkv?=
 =?utf-8?B?SEtjNlo3dlcyU3BzSWlSTXV4MWUwWUJWelo2TFFkd1Zaa004L1NKZThzYjFs?=
 =?utf-8?B?NGFWUGdXSkJ6VGhRZEpwbVp2eE4vQUs0OHd2dm84WGhJV1lpOHZLM2p3U3Rr?=
 =?utf-8?B?L1JybGQ2VXRQc3VMV2tVQU5oeHM2QUIyQ3hYVnpTSHhMcU9PQ1Fkc2VmbTF0?=
 =?utf-8?B?Wi9maXFoekRKUTdMTVA3T2FmanFIV3N4YkczV2hZRWpFQkIrNXByVHZUYXlG?=
 =?utf-8?B?NzUvQ3pJaFYzdWpROXRGbkxhclQyekkzUzhNaE9lZWFiZmJjWGlyaG40MHdL?=
 =?utf-8?B?RHkvL1BSMHhDaHE2bllaUUNkRTAzaWRKNmZ0K2dVTytFeUl4SnpJakNGeHht?=
 =?utf-8?B?K0EyYlQvTlFzaUY1eEgyT0d3YVR2eUFIZENidzlTZ2JPS2N4ZzdYSzFZUEJW?=
 =?utf-8?B?TC9QYkE5SWtMQjBHWWNIQ2VXSjJWTjd6SzN5T2dMS2M4c3hUWmxXeU0rYjJt?=
 =?utf-8?B?aFZyTGZLR2NGTFluOEp3VktFcXI3TkhUZzZTaDFNOXgxZHNkaU9sejhlcWk2?=
 =?utf-8?B?eGRyVHpMMWxJc3JMMGpJYkF6bEMzdmNGbTA2OTRkSWFHODZ5dmZwRHgvOXBD?=
 =?utf-8?B?QXVaT3NPQkx2VmpGT0Z2dWpvUzlDbDc2cExHUG5DUlV1ckxWSHNvMG9ZQTEv?=
 =?utf-8?B?QVFqc2N2aUtaN3hkUC9sdnl5eHdCaGZNeGdLMzJoZ0REN3dLeUZnNHZZZm5L?=
 =?utf-8?B?R3RyMjBiVU5jSGxpMk43dC9GQVVJc0pXZmI3bXU0aHdlWWpuUERpclZRVGhE?=
 =?utf-8?B?WkhJNHA2OFR4ZFBVL2VRN0pyYzg5aVZoNVM0MUl4SFh1RldnZWF6LzRvWGMw?=
 =?utf-8?B?ZkdWTFRhTkNuVU5CT0x1QVk1Sm82YzEzU0tOZFdZdEk5eHNrRDBTRlRyTVJE?=
 =?utf-8?B?ZUdhVER6RFFIclRvNWlRT1V4SXdlY01kdVN4YS9Rd0xOV0tBZnRiYWRWS3Zu?=
 =?utf-8?B?VVZzbTdPUFFXbGpuZTAwanBiZ0JRVDI1WndoZVNJWWhLSjMvWFI3MVF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNsYnh4ZUdYcUovdmg3d1h3QktjdTd1clJxL2g5Y0VlMGhXZzV2K0FONE9W?=
 =?utf-8?B?c2hzaDd2eXhwNlk3MTUrVHVjZ3hCWkFZWmtqZGVsZzRnTUZydGZaUDlySng2?=
 =?utf-8?B?Mno0aDhPMkNLWUJ3THZWK2xWMWdOdmRHVW9yeTB6ZFltaHBHZXovYUFzRWtJ?=
 =?utf-8?B?V0VRSlQrTHlrdUkzNTUyZmhIdllCc0xqdmhiQkZQMEpjZ2NGTG9KRkk1anFN?=
 =?utf-8?B?Wk1jVjY1VUVKZ2xxZDNORlVGU0p3aTlTa2M2b0ZYTm5tZ2g1MmtXL01zcCtH?=
 =?utf-8?B?bXdmNkdLRENQdXFuSFd0dXZZOG1iTENid05hMGlZcjM0NEk0YW1CdzBRdHhU?=
 =?utf-8?B?eEZOQkozcDZjLysyOE9CcHZKTE9KaGkzd1VIdHloL2tnVzJacHdsY09DeUhP?=
 =?utf-8?B?b1c5M01SWEgzKzFTa1YyOGxkcmFqNytEZUJOL1BtcUlOOS9VeTZNQ3l0a3hU?=
 =?utf-8?B?Y3pNemtEUldzd25UaUdMY3FSNnBtOTFDTVJ3Mk8zSGNGeU40NXQ3SGVSSDlr?=
 =?utf-8?B?amMzQlNYU1kxcHJEVUZLM2Z1d2tOVnFVeUkrWkdXZXc5ZkQvTTlUTFEyTGVw?=
 =?utf-8?B?cGhkcU9qb2NTdTFFcmMzU0c4cEttTHhTZGxmMGRZRXBvak81a1AzUnA5Q29E?=
 =?utf-8?B?SFptSS9qQkFMZ2w1dFRrTzIxY1hQOFZteW51Q1F3MEgzYmxNTFdlKzd1cWhN?=
 =?utf-8?B?cDJ3ZTQrUnM5Mmc1SXQ4TnpwWk5qWjZoYitJZW9wWDJ5dHFXSUxyaFJBZDlj?=
 =?utf-8?B?NmNWODJQS2VieFRGOWczTkhjZ3BWYU5JOFh6a3V3dDhOS0Y3MDRMQXZRVFZs?=
 =?utf-8?B?TWhjZVdMeHNoaGdyQjJQR2NUM0Uyd0R4YjkvU3dyOUxQdDJjdU4yYTFncmhj?=
 =?utf-8?B?VDZsd2VNMzlzTzVUNXUyV1JpWlhnVU1rMy9WWkh6allkRnFUbElIYzR0Y20r?=
 =?utf-8?B?ZlJTT2RuUkluYXRNWWhQTmkzRFFWWGhqdkhTSlJ3dlNBaXZoUk1ScjhYYlox?=
 =?utf-8?B?dkd5M3NtcXFPLzhEWjR2MjMxekZUWGZPMGdwbmg2VVRLOW9Fd3ZaOE5wNkZD?=
 =?utf-8?B?bnFvYk9EM3lDalV5QTFENGgvVml6UlQ2VVovVEhmMVlScXYzUUZiMW9EVkZD?=
 =?utf-8?B?YTFaUlIydmxrMkVPb2xLOWQxVSt2bWtCN1BJOXJDcCtaT2IrVC9uVkFDaHBP?=
 =?utf-8?B?VTJXTDNDWlFSb3dsZGZQRVF6a29WdmRsVEhxK1JCeVZSRVN2MG1LczZ3Z1Bp?=
 =?utf-8?B?TFZuNGhPWHNTQmlBK2tKbXd5bmtLdTh3cXZMMVBjUFlsclNCK0dsZ09ENFZ4?=
 =?utf-8?B?Ylc1aXBkMldYZkZvMm1ZU1k0cGI0cGVzVTNsL2hvL0RLWGRIWDV5T1g4a1Zw?=
 =?utf-8?B?cFp2ZFk0NnZvVzVvNnYzenlXOVdQdlBOYkRNakVYbUlwMDV0K043dDJpcFI5?=
 =?utf-8?B?UTNad0MxRTViWG1nTTJmZkF6dUc2R1FZdnNiWkpMVjR0aXRpTUlvQzlhM296?=
 =?utf-8?B?UjNsblNVS2RGaFBxL1g5czBrdjF5cnNlc1RMd3JTa1hKNzI0MnJWQlYvby9E?=
 =?utf-8?B?VEFmbmtNckFzR2RHaFNVeklZQmxUK0tKYlhDbTRxMDNqK0g2bSs4YU1qVCtO?=
 =?utf-8?B?UWxkdUJmTDlRWmk1Tm5sWE1UK3AvdW1wU2dQVjU4ZXpTL3E1MUl1RGVBbEdr?=
 =?utf-8?B?eFRBVUFZa1A5T2MxbnNZQnJBdmRRTmRvaC9ibGErLzhuYWxHd1FONm9TdzNl?=
 =?utf-8?B?dXlhZlNxSHBEeUc3RXUwaVQ2S3RXL1Z0aGdrODJYM2xKeFJnRUY2Y2FzME1X?=
 =?utf-8?B?djZrdE14VXhpRzZpckQ0ZGszNmRHdFNSWHhNRXdkd3hlYmxKVWZaTG10SGRr?=
 =?utf-8?B?eVA1VnJGVXVvN01oSlExUWpockEvT0o4aHFENVMyTyszc3VpL3JTMGtaSWF5?=
 =?utf-8?B?NE1KWU83Wkw0ZlBlSnlUQi9rdFRMa1VXekpDeXhmVERuQkkxRlFzSUlrN0JO?=
 =?utf-8?B?SFpUWDVWeExyWGs0NXBOb1dKZnl2Q1E1eS9pd2kzWlNxTlc2UWs5VGxGZThH?=
 =?utf-8?B?VFA4dkx3bElZdXEyMlpZcFVMbWFWRGtTeUxNelpyL0RtTTM0UXJ5LzFlK1Bu?=
 =?utf-8?Q?UhGTwfj3f9PB15z09fJen4tVM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2943ddcf-efb2-4d5f-9127-08dc6368f959
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:42:49.3319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xISuUwJAYWVSzc03+8SuyCahXOrHo0UaVPPKKQHTYG334I9SX2StSpahiIR/pEk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
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

Am 23.04.24 um 08:28 schrieb Tim Huang:
> Clear warning that uses uninitialized value fw_size.

In which case is the fw_size uninitialized and why setting it to zero 
helps in that case?

Regards,
Christian.

>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d95555dc5485..6b8a58f501d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1084,7 +1084,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
>   	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
>   	struct amdgpu_firmware_info *info = NULL;
>   	const struct firmware *ucode_fw;
> -	unsigned int fw_size;
> +	unsigned int fw_size = 0;
>   
>   	switch (ucode_id) {
>   	case AMDGPU_UCODE_ID_CP_PFP:

