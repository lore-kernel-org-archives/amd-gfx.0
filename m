Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBDC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 22:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A12810E749;
	Wed, 14 May 2025 22:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kffjLxz2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B11110E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 22:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/NqoB6KU20OiebnMiO/ljqILRagK5h+C3iBPsoz5YZ0wkOo8bHw6VqbRGn7uWJL706DgArwSOV07wMXPvoVD42jpXUwZ+S64WaTVXB80mviOx7+hg5fkkv/SZ51QpBU3YPM2Yi2+wgghK7gqAOu9qqJBJjWKVzFIGtgUWANpeGhfAfepffTOFZKYJ9yIfwhmDN6YH3c2l6q1ykc4HWBsPyVKfbUxEZ0TDyDvWlX8hbc1P6RKIudtjOINdv+fluAdDeJ/Ig3yJ84e5MQiZjJ4VDIa7Q4BvUTX6xNqbkpIPjNz8fA4MzHmOxSx1FfATtEksZct0iSdlc+FMRIVHyrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57MhXQop1qaCYS38c+aClplDPlJdld01/1QHBeLYMc8=;
 b=zIbAAs3MMPNQMwOpmavBt4cRPgADCZJfsBXj/YWyZ9cpRihFKcvYmbKok3S3pEspG+0HMy0KWOGeISB0Xb0IlZMlRNgqwf79KuQNqx4zhV8M+T6S/pQz+YBhcWZUhG7ENwGIyRaFV49I0IaexcQq4OhhnRPVDr96sUBlVFRsXymPJIE9BRBK9M0ncRxI5d5OWZ+t5cD9bqTwFT5YGTzEmW78Wso8ZTvHueHeWJYaAg6PBDasizDQu1qCM6GjhODGVwxEvm89KWJ1yjldnN8m7OfmhTddzo22OdWKmB71Y2EeBunYeuaqQZUPvS88n0+tOA5mBmxeL03eNd28xmW9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57MhXQop1qaCYS38c+aClplDPlJdld01/1QHBeLYMc8=;
 b=kffjLxz27YcySXX4HB6imopJDsRlqdrK7MLPhrvy7g/s+p0YRhyTDMkJvIzhHvAAmfH9+K8NRU6ivAl791OI/pZ/Ue+Wpl9ZIf7xgUK1RwHlENHo9ktXUHueREZFQzquns08HfyrJl9sQYtU/QwZfK6Q1UOovrYdpAcYEgZj9Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 22:05:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 22:05:20 +0000
Message-ID: <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
Date: Wed, 14 May 2025 17:05:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250514213721.519943-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250514213721.519943-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:5:190::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d99cf7-d25b-4bf3-43d2-08dd93336a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R05OcjhBRkZsbllsanNhbWhFZFFXeTlrWHVjTkVPanVqTUZ1Q2lBemJVM3hi?=
 =?utf-8?B?RklzNHNNTGY2aGZDanA4THdvUVBpYkovUDBiZlJuUlJKemp1TG1HR1NzVGR1?=
 =?utf-8?B?eG1SNEorK3R4T1g0c1p5YVZHM25LWmhiZnlJeUFhck5YcHRNcFdEdGljNUgx?=
 =?utf-8?B?Z2hCUVkyRlh1MXZmVHFMT2tnUzFlMWNhY1JZVzR5K2RPOU5zVTQ3eTJEajk3?=
 =?utf-8?B?bFNjd1EwWkQvOWdyR1Q3cUhBaU8xbE0zTWNwSlIwUU5xd0pDU1RLeTNyTlFI?=
 =?utf-8?B?blo3bGZrek1IWjFEcUZGTDdod0VKUjNFWjh0VjBMa3JXcTZoQ09hRGxnZURX?=
 =?utf-8?B?NFdNdm5hQmpJQmZYcjUvams4ZmhVTmNwdUVZUm9ub3JYQzRaU1RLUlRSUWpI?=
 =?utf-8?B?K3haMkpaQ3d3V2tpdGwyRm5JUjRIWU9NY3pRQndlOTZxS2krd205ZmpxRmIy?=
 =?utf-8?B?YnlPNG9XM0NYZnJQVVU3WTVVdXI1KzlQbEJnVkhLeWI2dGl3NG94Q0kyZHhy?=
 =?utf-8?B?dWcvZDMrMlRkUmEwSXh2SjIzenIzZURMYlNhaEw5Q0VleWk1QVVpM0F6WGd3?=
 =?utf-8?B?aVMvaTdidjBhSDQ3bUFIVXpvNGZRRkdBSDhDYXJMbmFkWnBtQzRpRjNYMERh?=
 =?utf-8?B?NGRlSnNOdlEvNFlDQ2o1UlRxNFdlTzZiR2t2a0J5Z25PN1FMWFg1UWhXZW1R?=
 =?utf-8?B?U3FlN240eW42NVdxaVNuWUpNRmRYM25tRE5JWWFFWldaRzlnNkpreW1RT3dU?=
 =?utf-8?B?ZTFaUXBKNk5uK2l2c2ZWeURiUllxSm5YRHo3SWJHUkxsUWR1T2FKRDVtQ3B6?=
 =?utf-8?B?ZU1BN1BwTG1ac0dlN1lONm9GRDB3M2F2SCtoL0RtekNWMmE4WUJnSFM5UzJY?=
 =?utf-8?B?dXNkdlJreWphak9RdkRyenFGR1pRZDNhMkMzdERpS1ZNVGdwU1ZlZG5mNTNT?=
 =?utf-8?B?NHFzaHdUVHF2TDg4NTRZQytuOGVNSjk0MUJxSkplbHpvQ3BETUVkdHl5bDVR?=
 =?utf-8?B?YjVTeEFhVEZUOGl1MGMyTUJ3T1BJREwrRWpBRWNaTmtkZldybFB3R1cxUFdh?=
 =?utf-8?B?NUJHZk9GaDE4MFQ1Z3RvT0daclNKQ3pRa3prVTVmWjFvSFJLSjNrWjFxZTc1?=
 =?utf-8?B?VWlVTzNDV3NQM3EzMnRuR2tDOFpsaWtqdllSYS9uUGhseHFPTUFqcGFkUVpD?=
 =?utf-8?B?SG10N2NVOUM2ZTNKMXN6VFNrWFFFUXY4cGlhMzVyWEpKZDlueUJ0Z0dKeTRX?=
 =?utf-8?B?Q2k1V1dWSTdOTDQ4RXVIUkRabk1SSEN5Y3hoc0xXNlFCbHVhMDBWdmJaMnM1?=
 =?utf-8?B?WWFFTXFLdVNoRCtwZk9TRmtxODZ1cVc2Ynp6TjRvcmd2VWxrZVRDalJDYSs1?=
 =?utf-8?B?SVNPS0RUOVlucFM4WDREOUZtVW9ib1FYQTRhcm5oTEtmem15dmZ0RFp2cmFP?=
 =?utf-8?B?UTM0WDZRZ3dlTjQ5Z2tUZEIxRFRQMFFEQmFKejFBMnRBejFSZE9LdlluOG9n?=
 =?utf-8?B?MXdrUXZwaS9CWk1SSEI2bmcxcElJRTRtVHFVUFVrY2M4Q2dGb0l0K285Vjdx?=
 =?utf-8?B?WlNPRXRyVnJUSkFMRUZRS2ttM2k3cGM2NmNNdlRYMGhicjNZcDQySjJGRVNJ?=
 =?utf-8?B?UzJUVmt6SWVwMERtYjVFTWkwc1NNL3IyVHFIOHdLVnZ6UWJLYlBwdTVDa2Ev?=
 =?utf-8?B?bGtOekZrd3oveXd6OHFOOGxQQWZ0SWd0YzEyQjE0SUxLbGxBaUIrQUx5Q1FX?=
 =?utf-8?B?ZUs1bk55dzRCb3grOTl2VzN0SlNFNVBnNDNoUVBNM24yOUV2Tm5GRXArQzFi?=
 =?utf-8?B?TmRtSWo5RDkrS256aUEvb003eG9Ub0hMSlZhOXI5Rmg2VjlIdmhPMWRiZng0?=
 =?utf-8?B?UVQyZHVERWFab08vcUovTjlvSzc0djNoNjBTcG5uTTdLUGdRWncwcGYyQXBJ?=
 =?utf-8?Q?+R+nfpURPZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVFYktsVTVmY3ZoSVVLZ0ppSkloMVFnWjhTRFJHZmUwOFM4bGpUdy81L2Jv?=
 =?utf-8?B?VHhBUE43TVplZlhqYzZqTVU5d0R4TWVuM1YybVlTSlo4akhnTmt5RWlIQXA1?=
 =?utf-8?B?ZjQrVE1zZ0pLektuSTAwbjUvVDNqRnVPRm5NU1BPeGVpQlo2V3JBcnc5M3VO?=
 =?utf-8?B?c0FhNkhqdVJGcUd6ZklFaWpUeThoM2FVVnZBYXdJUHI4anYxL1VRT2R1UlBO?=
 =?utf-8?B?TDJCVmExend1QW1MNHFhL0VGeCtpdXlCQ3JZNlRKOVlCYjVaQVAzZGFSUTNZ?=
 =?utf-8?B?WnY1Rldhb1lESFFqMy9kL1EyRHN5SmljVm5DRTJCSEtWNGdRbDVvNzFHRjM4?=
 =?utf-8?B?VlI3Z3BydmoxL3pZQnZncWFyWFdzaHBPUC80UHZ1M3RFbjZUOFN0bVVrSFRC?=
 =?utf-8?B?a3JaRDZrT1hmb2VZTG5vV09qLzFQcFhzeEZaOUpXbjZUZHdoVzk2SnRuZzUv?=
 =?utf-8?B?Unh1TVM1TEJoVXVGdlZXcUNWejFjSGxmTXBtY0g3TW1TWXdEMyt2Nm5NYy9l?=
 =?utf-8?B?bGNRRDAxK2JCUmYybUVUc1NGZk5RRko3dGtjTHNFQ3ZsK01WcWphQUxmODRo?=
 =?utf-8?B?bE9ONUpicFlGcGVoZXJab1lCaUFPT0hXVk1qTlorNmJxTWJUOEthem1sSWRV?=
 =?utf-8?B?eVc1QmpXNHV6T1Q1ZkJHd200TXQ2QVBlYUx1RmZEejR3d21wenlvZ0hReDdP?=
 =?utf-8?B?MTlJdUZiMWhMNDEzdDJFV3FWdlF2bGlEdDFXc2JwUnJSdzlTcnFsSldmNUNw?=
 =?utf-8?B?d3RPVVd0WUtpS3VRTDJScU56cm5HVHdJOTd2MzRMSnE3ei9QRjIycDA1UEZ4?=
 =?utf-8?B?Z3dBa2ZGeU96eW5acGRvd3FjcXUyV2lyNXFEWktWdHBTZGw2QmswMlhIOTMz?=
 =?utf-8?B?VnZGUUkxVDF4dE1hMTg4QzNtbCs4VmJjaVV2aXQ4d1ZIWThaLytQVFFjNlJ1?=
 =?utf-8?B?amtBZUh5MDh6TU43VVpxY2lsLzdrcGVmRkFXVEhGek41WG1aVHVRRWJVMjVp?=
 =?utf-8?B?bGxsWWRVZWZUS1lQcHY5bmRwYmxuMlpXSWZ3Y3dYbkJ4SjJ6ZzhydGRnZHly?=
 =?utf-8?B?bTkwTFpPQjVLQXBoaUI2YmRYd3FmNTkxdDdpZ2F4K3Qxbmh1TGtjVld6ZXNx?=
 =?utf-8?B?bTFIaWRKb0ZXa0VTM1FhQnF3NFVqSmtjQWNkUWhDS1RPenZTOG9qajlrbVhq?=
 =?utf-8?B?aWlXc2ExU2RkdjYrL3FOSlZMU1pPWUFkeGtUcFY4K1JWOElHRjVXQVJKM1FP?=
 =?utf-8?B?UEUxNU5KdGl5djlnbXhQOFlLK3VIRjJ3NlhyWXRSTjluMnBlMHZsR0ZjVk1n?=
 =?utf-8?B?UXlGTk5kUGdOaGNQQXB3ck5wN2gwMGZaZUsvZlQ5R2RLV0IzZW1vcFRDMldK?=
 =?utf-8?B?SXA3dlVMNUh5TXdYSFlxakduVW1rRzFNbzR4WnQ0aXJ5T3crQXpRdDROWDJF?=
 =?utf-8?B?aWZOZWVtb1NXVW9adkdxTks5UG93OUdndTc4K1p5TktUM3VTdlRSQWNoUnRD?=
 =?utf-8?B?VXozdnpYVmlZTGdKMjh3ZUZyVDEvczZzSFVidXJEaUVuREFKTHdhb0xLV244?=
 =?utf-8?B?ZDAyWlhIVFdabHdQNDZOUXgxOFY2WVpQcmdnUjB2Rk4rRlJib2VlR1RvSVRn?=
 =?utf-8?B?S055cUJsUG0yaVVZYitqVGxIbEg5ZFczSVZQMGdmWFI5NisrOXZ3STBYbzYr?=
 =?utf-8?B?WGpIZDlwNVh5bzg4VEpYUm13VUNwOVFiaXZTb05oR2F5MG82bU1DbWluYzln?=
 =?utf-8?B?K2I2YjUvVW41Mk9wZ3VhUHk1KzNYZVdUYlJVRTdqZ2FXd3VNaGlTN2wvMy9W?=
 =?utf-8?B?d25UeThCMk9TbElYYTNLWjlDK0FCWVM3bHhHdURCOHB5c2tIQ0dxQWlFRnZj?=
 =?utf-8?B?VlpEc05RMmNpYlNKWnl2ZVlZUnBJWXNZdWlNQTJaaUpHLzlOdFRENzlhMHVq?=
 =?utf-8?B?ZytZd095cUZhZVhEcVJUUGNQR0VPbTV2SUt0MHJuN1Y2a3FFdnJKWkhiOWR4?=
 =?utf-8?B?OUd1L3N2WkpPL3RMVkptMi9KS1VkOHFjR29jRm9uNEUxV0xDS3laNkRpbUg1?=
 =?utf-8?B?WDJmeHo0V2xFc3dEMmhWcTNnOGs4TjFZTmhodm9Ya2dIZmRiRVNld3F6cGM3?=
 =?utf-8?Q?lf176/ytHXWdXis8+HXz8KscG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d99cf7-d25b-4bf3-43d2-08dd93336a94
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 22:05:19.9013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEau2Z2kgsOv5Z5+qSD8DmBtWhEOOjCWQiElzZ6UREBti4KvYvobNF3IK43w7rcj/SLKlMT6FoH8ncbkEqxAWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

On 5/14/2025 4:35 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 +++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..c488af6c8013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,60 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
> +	struct acpi_device *acpi_pdev;
>   	int idx, int_idx, num_res, r;
> +	struct device *pdev;
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
> +			PTR_ERR(pdev));
> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +	put_device(pdev);
> +

Can you please move this into a helper in amdgpu_acpi.c?  We try not to 
have ACPI code outside of there in case someone compiles without 
CONFIG_ACPI.

Sorry I should have mentioned this sooner.

>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

