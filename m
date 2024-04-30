Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85478C10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F9610FE37;
	Tue, 30 Apr 2024 14:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kNHTTF5s";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FC010FE04
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQQNGPWzcqGteZDrd6k/KUS+6kiJ6JR+tAGsQtgZ59J+87pwPDiuFTjw5wB+7tpMXXUwHd4N0q0y/KXTsf5eiDxXK9UcE5rdlubjj4QuzZm4y/MIMeZ3ZpzcHNrmSfIMymU0Kky4J3/JmOANKOlE1QR5AeUea0PDlBE43JQfi2C9TWsJEFKE7AzXpv7lPNQEOKY6+4d/R1ZmmLYhNJL8/jnDzmJbMT5erIvSVhuE7Z6WEoWn/ok2PClVbXuhePJGiQnLvPyot2sPQorlNy+OPBgyIFhRRiITbzhwMzelznNNifLVK0l/LJPDH8RMlc7CsKTQy992e2W1a7J+VwAPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzjrGF6EJxqaziMtZIQW+hv4JYpFfucpFlza+2wQSJo=;
 b=CAYBojP1VvTXU1IrOlUnMiUDtu/9UsrlklTG7kZGoDxIhwz5F1XtQPX+mZGCAqDzA6mzueGETh0HTVNO7fsTp5cxIrtCPGsQm6Xu5qVl8ZZKk5hXc8ZiDPvfUYHLKpO2egh9lgd3r5yt8wyxR/erTZcjvcbC2XhKQ5yNb8OwaKhJ7obj8QIMmvpkxb+xIy5sm3WpdUEwxWtNANWQg4Hnjh1iCdtu0otV/kbAON00vyq4uTzokfYXCOczwb2vkOEgCYGbYv9Yb6uVSlGT35YMFsWgpnuLoHjgPKAqDqpsKWa/QNgo8JwyQp03j0iAaH5M2XgaAzkHiGdkfdaxCcUG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzjrGF6EJxqaziMtZIQW+hv4JYpFfucpFlza+2wQSJo=;
 b=kNHTTF5sAUokS4tdc++mGK1puPUc+YZoFJJf4+xq24CUra6g4BMORnFPtZOh5faQxLps9LSffK1LDMldwb5qBiCjwcOkczDHTScEvFrlSyR7f2HQzlyYQYtSdOAS75QBUTRWUOa5NYByPxELFEzLgTgyea8m6fDjg6I1SGWKPIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 14:31:35 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::b71e:4549:3c2f:64f9]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::b71e:4549:3c2f:64f9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:31:35 +0000
Content-Type: multipart/alternative;
 boundary="------------NLIaRKRQi8xNv3D0hNwZ0tpQ"
Message-ID: <c76fcb75-5a54-47ec-a2b6-5113e56a1562@amd.com>
Date: Tue, 30 Apr 2024 10:31:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, james.zhu@amd.com
References: <20240430113620.322882-1-lijo.lazar@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240430113620.322882-1-lijo.lazar@amd.com>
X-ClientProxiedBy: YT4PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::7) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: f300c4c2-cdcf-4636-c01f-08dc69223cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3RabWQybnczZW9hL3lJMEJsRFFxNitPUVhpdE1IVlBSbUZsWHJYVXMyUStF?=
 =?utf-8?B?NW4wV1dzQjRjNHIzckI0QTQzMnEyTHk0NDNCaDhZUTU0Z2cwSXVJaVVwb1Bv?=
 =?utf-8?B?VXZRYlJJbForUkYzQXRLZ1BqTHFuRWh5OEt3YzIzUXdvOEZhWVVrWGdZL3VU?=
 =?utf-8?B?bVBJOEhKcGRaMWQ3OGJpdVNTSG0rZ3k3d3BYSGpBc0I4WEhVbElPVTZCQUdm?=
 =?utf-8?B?eWg2VGoweEg0aGpkZnF3S3FPV21YalNsU0tmenlmTjQzNktPTmxHTGVtVlBQ?=
 =?utf-8?B?aDlXWkNTMU5URlF3Q0lGOUxuWS94MTBiL3RnRW5VVkp3ZDVZWHJYcUNmRk9F?=
 =?utf-8?B?d1g4TmdBMEFCSEdlMlB3UlEyU3pOdUh0eDFSSXBRMkJZL0dHWHRRNFBWN2dq?=
 =?utf-8?B?emtyUldZK0NGQWxORlRIdnlsQStmbzRXS2xXMUVmR09lSEZEWDBqR2I3M3Bq?=
 =?utf-8?B?dVc0RjZvdiswRDdGa2JEaGxkYUI5VHB0aEVBd2JOczBBb2k1SUZ6OW0zZlJY?=
 =?utf-8?B?YXBLREdRdkdTbi93L3pIN0RTNEdFS2xMMlFERlZQN0tubEdMYmk5MGNpUzEr?=
 =?utf-8?B?enJIeEpySW10WmhKUDFZcWZIMi8za3EyYkc3cFN2V244QjZHK29PYXVla3R4?=
 =?utf-8?B?b0R2RWM0Y1NMaXY4Vjc5WDZIL2NBZTlMaEo2QmM1SnBaRDdaeW9INkN3N0JU?=
 =?utf-8?B?WGIxQ2NEODhwS3UrU1cxdlB2ZmdVTVZpWmNMeTVwajdMSUtJbjN6TTY2Zzlz?=
 =?utf-8?B?dG9WSTU0bWRrcXMrd2hjckdrSlJGeWx1a3pLWkw0bEp6dGVjUVVjejFud3FV?=
 =?utf-8?B?RUFMa1AvREZXcS91NWt3UmZQVkZSd0ZIR2NqWlU0TTJ1M2tYWUU5dHFqa2ZI?=
 =?utf-8?B?bGIrZkMxczBnT2xkbmxEcWRvVjk3WTBtTTQ0aDE5Y2ZuZ1BqR2IrelJVRVh5?=
 =?utf-8?B?S21HM3IwZGhVSHRSQXhLeVZ1WlFYTlAxTkIyNHpxVG1seUxJenMyRGhteVhm?=
 =?utf-8?B?emlmeUc3TE9OZmJOcHhOUm9HaitQYjJVdTE0NVVGOE9rNGUrOXZ4cWFEQi9I?=
 =?utf-8?B?RmNabEZvb0ZuZmh6WEZFZGxDRTlFWWFrcngvYUZBTGFsVXU2bnd4cGMrUkJa?=
 =?utf-8?B?cm1nUXNaZW0yc3F2cCtlTTY0YTZOajdmQngxd3g4UDRKeS8zbFI2WmhsZTJ3?=
 =?utf-8?B?b2NjSXRLamxKS0UxRW93QWNScGFjUnF3REFtMks5UzEvOFU3L0NTNzlVUmgx?=
 =?utf-8?B?aVZ4RzBKcEUwbnd0ak5zR2Qzc1RTOHdtWmdDclBDWXo4SURMNDRjb0N0SmdO?=
 =?utf-8?B?TTFoNmxwd3JhSG9sOXJ1Y2t0R0paR21NQk8yaXd3Z3RiQmR1c00zeUNaVWNL?=
 =?utf-8?B?cXowc05DR0wwNzhvRHlrTWJZbndsMUN4L09ZWnFTb1RvV0JOdmtXSlA2MGxL?=
 =?utf-8?B?amh3bEJMQXpydFZveWtjaEtEcC8vNzZKZ2ZaSzA5THFjRFJvS1J6a3Rudnpn?=
 =?utf-8?B?aXh2akwwZGF2c0pBb3MwZDAzc2hWZkNFYVcxSW9DYyt1ZVAzRVY2dGRXY0xy?=
 =?utf-8?B?ZkRwd2I1b21PN0hjZ1YyQ0NkZ3J3dndjc3pFN2VwY0pibHp1Qy9DWVlMZmxB?=
 =?utf-8?B?K1FFTU5rbVRyV3B1aldKTEFMR3RPelhwSXRPdjkybC9ZNk9FdkxRb00vZ2RN?=
 =?utf-8?B?b3FDRDJDWlB3RVFlend1K3ljYWNnYWJYbTlmaWFheG4vWHVHVW45cjhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xDV2c3SW1DdTFTdmxrOGthMDlIa09meGIrMFZOYWl4cXhnQmJIais0ZWxm?=
 =?utf-8?B?eU12UmZINU5DeVRVMStKdGIva05Oc043Qzh0NStqNVA1MFBKcU96U2ZtcDhR?=
 =?utf-8?B?Y2VrZk1GZ0V2SnhPYmpEcEZ0OVZWc0tjcVBBYmM1ZlB1VlNTZm45VVBLNzNV?=
 =?utf-8?B?Zy8wUThWVHB2ZnBRRWtyNXBQUWdVV1cwVjdNeE5iVTd2UTlOQ2ZtYXFpTTVZ?=
 =?utf-8?B?VnB5VnJUSHdKTjlYL296Q00vem1uTWF5aDQ2WEp1cmhSdm9pYnZpNlVwM3Iy?=
 =?utf-8?B?Z3RMK3d6QjNzektkSTdVdnRKU1RkWEdFbDlVdCtITDlIWmpWU0RnbHlaV3JF?=
 =?utf-8?B?YWp4ZHZiTk1RUW9MWHRyUTFuMWlwelBFUFZQVlFHTG5aU25FRlYwUnppdEIv?=
 =?utf-8?B?RkJPZllCeC9MSXBmbGZScHUzNVJ0c1h2RlROcm1hNGc0MTVxTWd6Y2lFQ3kx?=
 =?utf-8?B?WnQrTUdVUWd5VitWd0JucGFSLzZ4SEVBajJXT0o1T2VjUE1XYkhjTXNhblBT?=
 =?utf-8?B?Y3hRcGhHOER0ZkhBME9QM1d3dmFwMkFxVENsUzF5VWdKbUFaMVdOUHFMRjRo?=
 =?utf-8?B?OXBZOHY3UklYVjZLTG9FUjlISE9YRmEyb0tTVzJObzlPNXZMcXdSbHVMaFJB?=
 =?utf-8?B?YjBWQzdvcldJdHNCYkxNems2bWN2cXZHMEhvL2d0WHJrL3dKRUZQSEZDY2Zt?=
 =?utf-8?B?Tk5FOXU0YWVYcmVSYmV5bGxpRXQvaHdMNEtzL2wrR2E5b3BaRGpDY2kxUitS?=
 =?utf-8?B?VTgreDZmYnF2VjFxUnkzQXZ3a3A3SE51ZmZqQnc4V2phYlArMkpRb0U1NzZl?=
 =?utf-8?B?S1FaU0E5eDU2dUhzZzAvd1JoRW9GQ2pMaW1ELzgvRzFtYW5aSCswODhGbncr?=
 =?utf-8?B?N1d3WEtsdjdSVDRRTmpBTXRMMUpjOHI0L0ZpSzMzNkI1VExoSnZTcXZSdFJw?=
 =?utf-8?B?NDRBMDgvcWJwdHlZZ0RQb2lSQXMvajNYWThoNlJHc0J4VCs0K1NJejkvc0Fl?=
 =?utf-8?B?VjRaTnA3b3dmQmo3c3RnVnYvQ1FGVEp4WmNpVGNDMSthZHY3dERKSmxDNm9o?=
 =?utf-8?B?YjVzSEhWUjNnYmE4eitEYjUySnN5Tm5uWElqTEI1S3RtQmR3aDgyQXdvUklt?=
 =?utf-8?B?NHJIcFZXbFpEd0czWjRLb09oaFVYL2JPWkNBRTFqQXIyKzRjNVdFWTNRWWN3?=
 =?utf-8?B?am9NVTlZYWZXMmUrYVZOajU4VHBnckFJQ2N3K1lMSUovZDR1T0hLK3VWaTdF?=
 =?utf-8?B?ejNWcS82bHI3NjNpQ3lweHdiMDZsOS96TjMvRHc5UEdlRXNOY1RRbmRBK2Y3?=
 =?utf-8?B?eDdqUDNTMmVHTXNwVVBhWjczQ2tlSU5ibWFzeExEV3RIb3VYYkwwczBlTnZJ?=
 =?utf-8?B?VHRCRVl2VkN1aEdoL04rY00zcFQvT2VqWmUzb3RxbzZOMkN6Zk14NVkrQlBL?=
 =?utf-8?B?VjRTNFdFYXRtQVlFWmJnbzh1OVpQTFlPYU5UUGdmRVNwc00zM0pKUEp6MVJ0?=
 =?utf-8?B?elRMRlJuaG81OURrMkRHa3dyTjZLNnBjaHh2enpMUnpvemVUeWdnSHY3aW5m?=
 =?utf-8?B?aXJ2aE5iMVZqSDJza0FJWjloQVN4TU9EYzhnQ2w3VTAwbE1JL2orRkRoNkF0?=
 =?utf-8?B?VWI0d3V1YXVvMXBIbGZrWWFlZStoK1pEbEROU3BSaHEvVjJvZzlBWEVaeFd0?=
 =?utf-8?B?dkR6b1N2RHJKWW1YazNaRTBoL254OUxXUGQyUUJWc093VkNwQzlrNXRYUSsv?=
 =?utf-8?B?WENpV3JtRXhFNE5Fa1llSU9ERmZMcWFNV3ZuOWFKOGp1dlVtNU9hQkZlR3RB?=
 =?utf-8?B?S2prWW9JOGdvN0NrMkZxS2k1dzRLVGthVlUxWXU4dnA0QS9jNTVLSU1XNy8r?=
 =?utf-8?B?VVNKdGtmNjQrRzErZkIxc2Rramx3NmpjRnEvY2pHY3B1eVNvYzdPRHJ6cVgr?=
 =?utf-8?B?SktmczE0cC9OczdFNTlob1JVYU1zUG9NallRaHZjeHowN2JPNUcxeEc3NHRY?=
 =?utf-8?B?R1hPQ1VBNkJKNHEvRUp2bW9tNGV3ckJrbDlRdnFEL1FjVFdyT0Yxc0wrNU1P?=
 =?utf-8?B?MWF0UDJqeStyaFA2ZjVieHR4dzBvb0pteDhoMHUvR0JKVC9DSjZFRjJjUmVJ?=
 =?utf-8?Q?ClkdAmDXQyGbAvjAO2zjSb7Yl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f300c4c2-cdcf-4636-c01f-08dc69223cba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:31:35.1015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/kvpCYMuj4R1ZuN3ZHLN8PhQ+JyDKbsPTNuIVDdb2jLqCxX3zhQCXrtFHcXACMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

--------------NLIaRKRQi8xNv3D0hNwZ0tpQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-30 07:36, Lijo Lazar wrote:
> amdxcp is a platform driver for creating partition devices. libdrm
> library identifies a platform device based on 'OF_FULLNAME' or
> 'MODALIAS'. If two or more devices have the same platform name, drm
> library only picks the first device. Platform driver core uses name of
> the device to populate 'MODALIAS'. When 'amdxcp' is used as the base
> name, only first partition device gets identified. Assign unique name so
> that drm library identifies partition devices separately.
>
> amdxcp doesn't support probe of partitions, it doesn't bother about
> modaliases.
>
> Signed-off-by: Lijo Lazar<lijo.lazar@amd.com>

Acked-by:JamesZhu<James.Zhu@amd.com>

> ---
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index 90ddd8371176..b4131053b31b 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   {
>   	struct platform_device *pdev;
>   	struct xcp_device *pxcp_dev;
> +	char dev_name[20];
>   	int ret;
>   
>   	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>   		return -ENODEV;
>   
> -	pdev = platform_device_register_simple("amdgpu_xcp", pdev_num, NULL, 0);
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>   	if (IS_ERR(pdev))
>   		return PTR_ERR(pdev);
>   
--------------NLIaRKRQi8xNv3D0hNwZ0tpQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
<style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2024-04-30 07:36, Lijo Lazar wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240430113620.322882-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">amdxcp is a platform driver for creating partition devices. libdrm
library identifies a platform device based on 'OF_FULLNAME' or
'MODALIAS'. If two or more devices have the same platform name, drm
library only picks the first device. Platform driver core uses name of
the device to populate 'MODALIAS'. When 'amdxcp' is used as the base
name, only first partition device gets identified. Assign unique name so
that drm library identifies partition devices separately.

amdxcp doesn't support probe of partitions, it doesn't bother about
modaliases.

Signed-off-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a></pre>
    </blockquote>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Acked-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <style type="text/css">p, li { white-space: pre-wrap; }</style>
    <blockquote type="cite" cite="mid:20240430113620.322882-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 90ddd8371176..b4131053b31b 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
+	char dev_name[20];
 	int ret;
 
 	if (pdev_num &gt;= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple(&quot;amdgpu_xcp&quot;, pdev_num, NULL, 0);
+	snprintf(dev_name, sizeof(dev_name), &quot;amdgpu_xcp_%d&quot;, pdev_num);
+	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
</pre>
    </blockquote>
  </body>
</html>

--------------NLIaRKRQi8xNv3D0hNwZ0tpQ--
