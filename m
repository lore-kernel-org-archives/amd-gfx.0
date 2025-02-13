Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E77AC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 18:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AF210EB76;
	Thu, 13 Feb 2025 18:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ov6BgFC1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C461910EB76
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 18:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvXAPHtjmRBWYpsPTvTiS2zzuT6axcczIL64dDA/qyUWbzDBU2MpDHI7l0ygf4Z1pm9ULizWTq0f8vvgpLCmR9KeL70s9d2pvgEKS5izIz4Db5kuGGBdAqqs6xa+fAp7es8aonjijRmEH/KoSME/6Pboq3QOwxA42q/yt/joH3aj6JGTOsJzqm23HORE6UrhehSr2dZ61cNVPYKqnjQcBmyfU58+FILW+plQA7OA1sxe6XpRH2Ag8Goz1WZDwXHqJk0wQVkxBpOj8NxUCMUs24kCr2Y1dhAD2Yn5wbVGm3tx4ZglJe/7Nuz2lNvGRt/o7SLT8cMkHKukuFfMhiSngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wLeBcbgeTxrztNfD1sEFYrgZ4f/Y+GG5CeT9QXxcV0=;
 b=kO1p2rX787OuzIjTpl8xUtEE2g7j4ubut3fehh5HYltYkOA4j09Q4qR2ev5EZHZIdFhvbspKnQHXU+9yyUJqdooXTTP+R82vB1a6+VzyGRnkqQ1wsRnTP4vOmf8q2wqKozs9WvzI22SdbCSRf2KY29AbdCBcNwKaPN03H4p8Mn/LGgZzdhDXyRH8AI8uaSNExncX7We0ljF/HZmEzAb49w4iRUsTBT2iTKp3pHUQQ19ELpuEYbfMd/V3uo7RPnYzQDiMy8tKXM8JziPKdCtObC478YKLRcB+H02Kw9SbhbnQGu5wi3DgBFz5L5Dhpo3JBv5l1AziqK6Hpti9bgD7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wLeBcbgeTxrztNfD1sEFYrgZ4f/Y+GG5CeT9QXxcV0=;
 b=ov6BgFC14ZMFP4+gDyDzMrZs+3oAxpfIJjaCw/MB8MjqUtiJukOpugdoSzrR0WHS8mUg60qOHVg6/oIrwEyFgCyTLC3Oj3okOyc6MfLll6H0L1L2wfqpVTm0ce2hlhjrkAWUByUUvlWea9+nKHEWiG82GdPBsGQcUE7od4+n1ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 18:43:57 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:43:57 +0000
Content-Type: multipart/alternative;
 boundary="------------IjdgRf2dhKm7Mk00Yo3L95Cf"
Message-ID: <062deaa3-fcb3-40d5-be7b-a8b6c03e53b2@amd.com>
Date: Fri, 14 Feb 2025 00:13:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: only call mes for enforce isolation if
 supported
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250213183951.954001-1-alexander.deucher@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250213183951.954001-1-alexander.deucher@amd.com>
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5774ea8c-2ac9-464c-e907-08dd4c5e5fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEl2eEN6NEUyYlk3V1VFdGdoU2twd3A4aGljR3hNeE40akdmN1U5b05LNWtW?=
 =?utf-8?B?M0EvRVhpeGR3cW1INUNmNi96RTJyRVRLSGRWRzVqa2k0ZVZUb2FTKzl2MHk1?=
 =?utf-8?B?WHFQd29KTDc3b1V3RjhuTXhoaUk4TjNVeVR2YnA1YzlXNWR3YVJzeUJ6eFlY?=
 =?utf-8?B?Y0h3d1NKMlhNU0JCcGIwa1NUWnNabkE0b0t2bUFMOFdWOFpSclk0Mk9nQ3Np?=
 =?utf-8?B?a0pkTVM3ZU9MOFp5UmpiUThRUmZiMDQ0aGZoanF3VHRuZi9TZ1g0cnBROU5M?=
 =?utf-8?B?a2hnbjc2U1orV0plMyt3YXV0a1pZMmxBbmxzeCtTdTZ1M01TazFRRzNGaG9V?=
 =?utf-8?B?emtSNnJsYUQvOU8rOXhvVHBkRlNJWUZEaGtya01kTHhZUEJrOFRuQ25IZXAr?=
 =?utf-8?B?OHlOMSt3a0I1RUh4Vys4MDdoQ1F2c1BENVRCTk9kQXp1eUlweTJXZHloRWpl?=
 =?utf-8?B?MzVnb2UxWTlHQUJ2d0hzZm9aOVYxMVNNTnhoSjM2REhkZnd1c2orejYzKzBD?=
 =?utf-8?B?SkhKRHo0bkczM0Eva0JDNVVaYmxLa1lMeDJ2UEhyVDFKdlIvVjBuQ3huYXdV?=
 =?utf-8?B?d2JDVDVvdU5SVjhSc3pIdzlQUEZXUXhQbER2SzlCWHM0YWlIT24xV3VFZE1W?=
 =?utf-8?B?dXRmaG4wMVRaai91ZCtCUCtRN21Pd2NydnN1L2pWUGRDREcxaTV1RUFwdmNM?=
 =?utf-8?B?cGZWUmNWLzE5bmpjSmNVYzFJNnA0V1VJempIUHE0clY0Mll6UFhUeStYUWlJ?=
 =?utf-8?B?TmFsOTBmckd2U2ZVc2NJU3dpUGxaWDNFU0QzcEdJMi9tV0xoSXhuR3UySGhy?=
 =?utf-8?B?WEtaR3cyaEtGRm9NZVJMaThTdkxxWnZMR1BwM2ZjY210UVhiOEMwVGt2MnJY?=
 =?utf-8?B?b1ZQd3hiKy9nVWlwMU44Qk5kV2FtQ0NvaWhhZHNLN3Y1U0xhVlFmdUZkOHR0?=
 =?utf-8?B?N3IvNWx6VFZyMlpmSTVNT29IZys0Z1RTMU5FNFVKdmdpbEd4K2pxUjdVTFRZ?=
 =?utf-8?B?bDVLc0xGRy9hUjFJUk9NZyswTGJlNmNDVkpJTTV5Q3B3d0k1L0ZrVllSQTZC?=
 =?utf-8?B?TDd4SHBVUDdmUmYxSTI5UzlYMmMzT0lsZ1cyWlpiSHhYcy9PVXVxcFFRMjA0?=
 =?utf-8?B?ejI0R0VGNisxOFNRK3k1ZlFOUmZRSjExdjg1VTBLcDlhTW9XU0lvNVIrTVBv?=
 =?utf-8?B?KzRoSFhFVWNRYzVIVWJaVi9XVHBKeHUwRzdNUm9FN0o5SFJpZE1qRkZlNmRp?=
 =?utf-8?B?b2dmeGdCc1ByanBGd0FabWgzdXZZVUdjUzFvN3dBdldRQU45MTRWSXpWK1E3?=
 =?utf-8?B?eWxPLzBtOXoxZGNMNFROQjlSRDgvR3RIekJIY09ub1E3Uk1jaGlPVFNTVUdJ?=
 =?utf-8?B?RDVwWnY0czB5M3c2dWZCMnQ4ZGRRVDdRVndRY3I2bVZYWnFPUWw0NDNkK3FX?=
 =?utf-8?B?NGs0WTRGZVlpMnhVWmVXai9lam40MzdDWFBuMEI4d0h1cFBGdFpScjVsVS9P?=
 =?utf-8?B?KzRTcmdBUHZKRVlWck4wT00xbDN6bk4xV2pMRUV5b0JRZWh5VDd3KzFJcGdN?=
 =?utf-8?B?ZG5tVU5uMkM0WW5ISVZJVVQ5cCsrREdSbjA4dGp6dklqczljL0lKUjR2VFZD?=
 =?utf-8?B?Y1pmWGlSeitkWUt4RllRYXdKT29COGdqU0RBT1pXU0c4bU9yQkw2UlM5ekhp?=
 =?utf-8?B?b1pVSHZlTWpDWEswR2RVNC9LUjZ4L3BEcjFidDJjT1kySm5UeEZwd3dGSklZ?=
 =?utf-8?B?UlFOTWNJajU0b1FPQWV3NW5pYW0raVdvSC9GbGZoVFd2WkJQbWswUXhxSStk?=
 =?utf-8?B?NlptdFB3bXpNQVBUVGdhL0p6R2U2VGxqaVZnS000clFoMno1MGd6K0xzWmpG?=
 =?utf-8?Q?xSVslgtbNhLis?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0gxa0o2TFVhZTh3bTRwZytyd2dWSng1WW1tK0hmSkNvaE0wVDM4bUs0dlp5?=
 =?utf-8?B?TWdNUis4aEswNEtXQ1ROTVR4SWdzTzdRSSt5MWxLRXdWUnJwSXN6VTc2cVRB?=
 =?utf-8?B?ZjJkWGlkd2RiWUMxY0NUVWVDSjZkUGtDUFp1eWQxZXpuQWZGWGI0UHkzYlFV?=
 =?utf-8?B?V09KM1V2WXRlckQxNjAzL3pFbWM4Ym95OXBuNEV1VHBsMmRSOXh6TzBCdTAr?=
 =?utf-8?B?bmhpeEJhQUF4VFRWYXlaWW5FZ1JPRCtxVnZ6dGNOUXBwaUpIT0dKcklTaU1V?=
 =?utf-8?B?dC9KMk9BY3pMa01oeUJKaWl5UnVYYitTZmlWS1BabXNvdVJFM0prSFh3VlVL?=
 =?utf-8?B?L21WWGJUWE1MdnM1a3pvOFFCNjdWL2phLzF1aFp4WlBxQUo5M1V1WHNTdXFp?=
 =?utf-8?B?M3FMUVNrU3hzTTh4RTBwTzk2TTBxUnRJSWt4MTB5WEdmaDhFUDR0U2dNbEFO?=
 =?utf-8?B?VGVVajRFWFpoK05UeTNPV1M0WWpqb0MrUkVaLzQvL2ZRbVlPa1ZLZllraHI0?=
 =?utf-8?B?djBtaGcrZVhJaCsxZURnOGhCbDZtOVZ5VWNyK1ZHTkFNUlFJQUNHeHQwZDY1?=
 =?utf-8?B?V0F0QXg0L0RyMEllTm1NVjNNSm5LQzZheHRuMFc2blZReTBraC9SbEwzK2Rq?=
 =?utf-8?B?N1lWL3RDOFFlMktSeUEzdDhFenFjRVh6RlRrbFJoazZMM3dyT0VHMmNkQXox?=
 =?utf-8?B?aGJubTVLQUZWb0psQktaUS9YVVJTV3ZlZ0lWdkI5d0VRaG9IYnBlazhrNkNL?=
 =?utf-8?B?NDliTE5XcWpCdkJrRzJGWHNjbC91cFhHQytzQ2R3ZXZpaUw0SXBnUEhMaUox?=
 =?utf-8?B?dnFnVitlLzJVa29WeGllbk9OT1Z2TFdkYzVCeFVRUDhoR2duNnI5amJIbzZ2?=
 =?utf-8?B?SHRFTFhDeGZ5Um1qWVREcmc4ZW5XSVI0SnlqQVdJMmlZRTEzNW1vTnYvUXZp?=
 =?utf-8?B?bEZlNTNPeWRselYrcTBkSzIweTJScjB1MEdaV3B6bjBhYjZ1K3pMTVYyY0Zz?=
 =?utf-8?B?R3pYR0hCZ1NSRGx4T0lkUzU3dHhOSEpJTGdmU2J1ZDFQR0dyV1lRdE9pcDVi?=
 =?utf-8?B?dTQ0b2dTMVNwdHFPY0F1UEhjejQwcU41TTBxVVBBb2l2WWt2ZEp6ckhWV1dz?=
 =?utf-8?B?aDB4dHBkSFh1UXFWSEJNSFZHc3dvV2xnK0VaZEtVajZZNE12QnBWU2FoN05l?=
 =?utf-8?B?cEw3eDR0ZkNZTmpYNENLM2JQMytSclZUYXdPK0lmbmdHNEpndnhDbmtYM21w?=
 =?utf-8?B?WVpHWmlEemJ6M2ZlaEZyTVhLdEFVTlZoZVFmQjhsUFBWb01yV1hYTXpDRU1Q?=
 =?utf-8?B?UUhvdjRsb0swbk1DMlh5UTFTMUZleDdScGVZUE1uSmZnaDBqTGdLRHQwaGw1?=
 =?utf-8?B?SmR2OGtnWHZQdzBWV3dGUFZHL0RJR01lMGJsbkJtMXErZUloQVVVWWVacERu?=
 =?utf-8?B?MnFHRW1BaXhZTHRaZ2VEclZNUzBINkRWczZORXBkRTdVSkp2QWJCMFRmNWpu?=
 =?utf-8?B?YlVQaEJhaG8vQXhycGFMUHh5TEdkOUJHN0E4aTNKZGp4Y0p6MjRCb282eFli?=
 =?utf-8?B?elF4NlpoNFZ3L2EwRW1yMmFYV3dlRHp5Yjd6KzNZVFQ3TXRLdWhLdm5aa3Q2?=
 =?utf-8?B?R3hGbVQ4YnhEQ3pzOVJyajk3aWh3UjlWL3JqYUxjdTMxTDBvZURhY1hUSWFS?=
 =?utf-8?B?dlN5bi8xbko4cnFleGJGWjBSekVhQTlLTFQ5ZGl0WXArd09tdkR5SXpjN3Fq?=
 =?utf-8?B?eVlBcW5BdDU0dWcxT0lNdWkvQmo1bnZaTGd1aDcyYjY0VTQxdTNpSE9oTnBC?=
 =?utf-8?B?MFJ1dE50Z2U0bUh4aVUvdmJicmJITHo4NmVLU21IMUkycGQwRUhMa0Y5WXpN?=
 =?utf-8?B?dWZxdFFrY1VsR1NlV2szN3cvVGZkTHZvdnNOVTJnMTdTR29VaTY5ZVlzSXJC?=
 =?utf-8?B?RExHbi9ZOUQ4aHVmc2tNK2ozVUlIMmp4OGI1cUhiZm9MTlFkemUzTTh3OWJU?=
 =?utf-8?B?NHlQUkRwZTVnbFdLblMybWQzaTlhb1oxejJQK3VCa2owbzc4YlpvVW44L2My?=
 =?utf-8?B?TGVKTDZjb28ycjIyYWFpN291MmxRdExuQ1hlYzNGRG9GMGVTRklSNHZZbDl0?=
 =?utf-8?Q?qlZOBRlUMXVAXLkdmImReKHPF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5774ea8c-2ac9-464c-e907-08dd4c5e5fd0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:43:57.7861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IAZek3CQ2YYTO9LVqwsvGmkjUaHOktP0/jIJnZBxH337T/VL1hEnscNYWiHNjfVWyYLi2gwgSoT/3PYqQReuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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

--------------IjdgRf2dhKm7Mk00Yo3L95Cf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/2025 12:09 AM, Alex Deucher wrote:
> This should not be called on chips without MES so check if
> MES is enabled and if the cleaner shader is supported.
>
> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> Cc: Shaoyun Liu<shaoyun.liu@amd.com>
> Cc: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 27f5318c3a26c..b9bd6654f3172 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1670,11 +1670,13 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   		if (adev->enforce_isolation[i] && !partition_values[i]) {
>   			/* Going from enabled to disabled */
>   			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> -			amdgpu_mes_set_enforce_isolation(adev, i, false);
> +			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> +				amdgpu_mes_set_enforce_isolation(adev, i, false);
>   		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
>   			/* Going from disabled to enabled */
>   			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> -			amdgpu_mes_set_enforce_isolation(adev, i, true);
> +			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> +				amdgpu_mes_set_enforce_isolation(adev, i, true);
>   		}
>   		adev->enforce_isolation[i] = partition_values[i];
>   	}
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
--------------IjdgRf2dhKm7Mk00Yo3L95Cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/14/2025 12:09 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250213183951.954001-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">This should not be called on chips without MES so check if
MES is enabled and if the cleaner shader is supported.

Fixes: 8521e3c5f058 (&quot;drm/amd/amdgpu: limit single process inside MES&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Shaoyun Liu <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>
Cc: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 27f5318c3a26c..b9bd6654f3172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1670,11 +1670,13 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 		if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i]) {
 			/* Going from enabled to disabled */
 			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-			amdgpu_mes_set_enforce_isolation(adev, i, false);
+			if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
+				amdgpu_mes_set_enforce_isolation(adev, i, false);
 		} else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i]) {
 			/* Going from disabled to enabled */
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
-			amdgpu_mes_set_enforce_isolation(adev, i, true);
+			if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
+				amdgpu_mes_set_enforce_isolation(adev, i, true);
 		}
 		adev-&gt;enforce_isolation[i] = partition_values[i];
 	}</pre>
    </blockquote>
    <span style="color: rgb(51, 51, 51); font-family: &quot;Source Code Pro&quot;, &quot;Courier New&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Reviewed-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></span>
    <blockquote type="cite" cite="mid:20250213183951.954001-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------IjdgRf2dhKm7Mk00Yo3L95Cf--
