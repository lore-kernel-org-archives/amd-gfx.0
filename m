Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5FBD2F7EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B00F10E7A8;
	Thu, 17 Oct 2024 06:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCZJfZfu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B651810E7A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjjsbWaP2d4Kj2QZA16HMHkFxWR7VFosPvqwHD80Oth5Zk3HFFXLxRcVOxfiRlbEAjwUfYOhDatiV7rplKDhH0fQKEDAm82ZUsV4QNz7eyoEqCEnNal32WgVZjFByORD2sGdo9Ob0n6olaSVoUNtx4U5GFHSyTlj+Hrw8m8PJZR89iBc3TucNeAsXjzXDqQQmp3loxmTbSGa8GZ95Ef2uJohTl0WkjQWTgzpqiXp4V6dN6Pw0ZU2xd3dqKS1f+UHz/apC+lzHvq82Kq9w0QcFVYD6+/26knyo/wVICmk1BU3XNc+CN6chNCNTOKsuJE7UJo20/0EDQJGLSUWo7rIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru1eFTzHSl6M4Wj5FoLrZs5OStLUF1jHEOlFhh3+4sM=;
 b=Iz7QL2GVqimtUeJj9ycxYOa3oBjnEpP+Ykptl7KhxUEWQtXqV6YYEizj4Y2Lc+qeJC4X+J4QulDWxaL4ISUAJR8ARocPVO/TedSLpOXelJ11oTv5/n+1+SsXAHL7bV7mcAl37JQ7j28/IfNSKJqripiHEG0S6V7NcugN68H5dFqu3auA0Edh/Z8LfET8susnXrURs+ZFw15xJop4Obzujq0IAe0uNsvdlLQxoBs+Ch8l9zIA5TDeC9n6DDTDNw+BCt/Tpbskrsd9U9WtD/ZHNnH80tndywAwZZg19HkBLxMh5wRv4RswdbJUbaxhnT2G/J0KZLXS1Qr1nb8kutE0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru1eFTzHSl6M4Wj5FoLrZs5OStLUF1jHEOlFhh3+4sM=;
 b=gCZJfZfuG+txYWo17IQv4wydz09gDU3pJdy/g0T5RICfcmBHd85HUc2sw512K3YfZdT9Zx6FsoNNILMmYZDgWmJ5QDIucLer/mJ7gQx+JedvO84yIiWOwgqyFNghN6Z0cE0WWDJ+WVYkM2IYFO6XpMxOlLEH7dagcDcL5forEWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.20; Thu, 17 Oct 2024 06:59:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 06:59:53 +0000
Message-ID: <86928824-e911-4f38-b537-8293392a8efb@amd.com>
Date: Thu, 17 Oct 2024 12:29:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: update deep sleep status on smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20241017062332.2151448-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241017062332.2151448-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: d98aeb92-b7f9-4761-78a8-08dcee794d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUlVMTM2eUJ6VHQybEdPQWNZUTlGQ0dUV1BFemt4bk5DZTFSZ1hDM000V1p4?=
 =?utf-8?B?NTVnQkpwS0VMSis3alF1RUV6dzlMa05BcFQwZDhPblJvWFRiYW53dHBvNW1K?=
 =?utf-8?B?QUhBQXFLVTU2TThZRHBsTWdsTUh0OTVCY3dPLzBkN0h2ZXJ6MWV1OHZwZDRQ?=
 =?utf-8?B?L3lEekp4ekx6b0l3bXB4eDlYRG1MQmZTaklPbUpSbksyR1Y5Ulc1MEZTUW5N?=
 =?utf-8?B?K210d1RpaGNpdnc2RU9TVDJpc1gxMmpNVXU1b2ZsS1BuNmdzbXJtcktWSlk0?=
 =?utf-8?B?MTZWeHF6dWx4VEs0WUFrR29yN21QR2tvYTlUNytKNXdKSHZVdnF1YUJxb05j?=
 =?utf-8?B?R1hHWkJDTHhaQVl5TmtSbFpsWXJydElEMUFjcDFzOXM4RlRBS0xKWU5LbkQx?=
 =?utf-8?B?UDhtN0JJaW9XNmx1NlFWU2JPU1p4cDZoaVJxVWdoeWNHM3pJM1ZuMGZPckFl?=
 =?utf-8?B?Z2x3Zi9ZOERHYVFaallIQ2JMcHpEM2hXbjZ4K2tVUFp5L2IwbFR0U0lQNTF1?=
 =?utf-8?B?UlNSck4vWm1YTFRoejloZWFzVFZtZHoxdEtGcm53clcwNWZYL2syRUVIcGI2?=
 =?utf-8?B?YU5MZHFRUUxpUkl6aFF2UWdnNUVndFpxWU1KWlBQVTZvSUp6YWk1UnMxWWN2?=
 =?utf-8?B?VThuVzFzRXRnenptRnc1NXpycnpMeEZLMjlQeW1NanpzZm1CdEoxR0c4dlZa?=
 =?utf-8?B?T1ZwekpUUjlCKzl2RnBYRG9NYzFmRXNCYjc0L0k2RUlZQ05icXNJUk5ibWRL?=
 =?utf-8?B?TVlML0x1THJPc3RmMmFiNHU2c0tWU1JvbXNFQ0lTWUt6OWxTTktTTERwL3cw?=
 =?utf-8?B?S3pTbEV0bERyanpab2pneUkxOEJNTi9rZXhHb1ZWR1A2TUdpTUtoVWVqZGdL?=
 =?utf-8?B?REpCd0d5Y0RSMjQ4dlVxVythTlhyaW9JMytTbGw3QTM3NVFwWmxzRGp6dkYw?=
 =?utf-8?B?MW1TWEVkQWFEWkl6MnE1VkRjdUlQdHZ6bGJ6TmFEYk41OHorMmE4aTY0bVpV?=
 =?utf-8?B?WEx3TG9wZllyaXE3blpHQ2VBeDZFbnVTRStvS1hZaXVKaEFNN3JQL0tTckN4?=
 =?utf-8?B?eEhGbUdoL3VFNmFwcDJYS0xNMmNQeG5qQ0dId2RsZ0xBM0x5UlB5ck5KcHB2?=
 =?utf-8?B?SGlLdjAyNW5zWkxxalVaU1IrRFJVS0R3YTVYUHBITDl0Rk9Gb05obmhsYUt4?=
 =?utf-8?B?VUxxNWhxUnl4cFVQNU1EclZCc1VMV3VVUkJDMkFLODBNWVZHK0VYaGRsTmhZ?=
 =?utf-8?B?ZmJJTmRRQTFaK251U2g5NHh2R2FrVFowTXZrYjJwbG1oZmdBL2t0NEFpREs4?=
 =?utf-8?B?M0NmRU9vZ2QzRGVydGhWUzNOSVVHWHJsMVZ3VUFGRy9Va2xNdzNvM3J1YTY2?=
 =?utf-8?B?VjNmL0ZMbitjaWRZTW1qNHh5eUVEREEyWDFmdW85YmV5bmtWTFNCM1VOeGFE?=
 =?utf-8?B?N1BYb2xBQ0NEU3k3Qmgva1RIMEg3a0owNVRHdzJGSk1ocGk0QTFtQ0pPbTFh?=
 =?utf-8?B?WWUvY2xOeWZ0NlVrRitCZnhSZlRMYzN4aEkybkNHemtDVlJwUjhLLzk4TFhr?=
 =?utf-8?B?WFlUUjh3M2lwcm95bFVVaGhXaE9QVnIvUEoxWDc1ZlhCZ3J3ZlZJbmlQYmRO?=
 =?utf-8?B?ajMxQ0lxbnNJSXM4Z3JtQjgwVmVleHhndE40YjhzYTUrckE5S09JZWZWQjh5?=
 =?utf-8?B?TUl1TlZ6WlI4dVpwVzk5MDBlRmRSQ0lnaDNNQ0N2dE4zRFJjSk16Z0E3ZFRO?=
 =?utf-8?Q?rXCKbhLjQkOvTxs3a8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emE5K29LUzBUN0tJaUhrT0dHMklhMEVSS3lEL2tHNWlXZ2JaUnVaNGI2cytL?=
 =?utf-8?B?MHduZC9aeVBOa3JnMkZrR2tpN1JOaWF2NnYyWmlwTXFjdUhlNTRZY0ltOUZW?=
 =?utf-8?B?cTd4NjRUR0o2VFcyUDlaK0lWM2t1eXB1Y0tBZGRMaGJsdFNPeTJpQzNuOWJp?=
 =?utf-8?B?ZWYvd1dHWkh0eFBOU0ZsclRYZ2tEQW9nQ2c0Q3ZsM1hnaEhqU2l1WXlQRlhO?=
 =?utf-8?B?S2JTV2ozOE80azRZNzNqWWJrMFlzUHF2d0ZuM043MDEzWlB3MFdsdTlCOUZx?=
 =?utf-8?B?aC9CbFhIRytqQUFNWklINzJVYVlPMEl2R0R2RnRvcTAwOTlXb3NXQ1RZcjd2?=
 =?utf-8?B?SDNsekhWb2FvQnJBK2hNSXM1bFJQcEZLWWdVZW1zbGRTdTA2cVdSeklQWkJm?=
 =?utf-8?B?NmFsVWcySzhOYlRIM215eTlydjk1MS9XcnRtUHQ2Q3gzN3drUjV5UUNzeEJx?=
 =?utf-8?B?TmRKWXJNaE5INGpEYk9xSFJxd0YxalE0Zlorc1JBK29FNG82cHpzemdwZ0ZL?=
 =?utf-8?B?QnRVYjdXV2ZvNFVQSEJEOGdZK2N3Mm44VVJzUFRVTkYvNnJNd0FKa3UyVmhq?=
 =?utf-8?B?VlRrZHBZbm5XVitpa001bFdLMlI2RnJVUUE0bjlHSXJvR2NneldibldzWTNz?=
 =?utf-8?B?dVhMOGp4S1d6MFlXVjhhdXdLQ1FnRjdQeG02NG1Zcm5DTDY2N0dXNE5qTjd2?=
 =?utf-8?B?cXB3L0hkOTZmQyt4cG1hczlWT2JYM1E0WGlUV3BpNzl0a1F0SGl6Y1h4R2tV?=
 =?utf-8?B?NG1yUmxHZWg2ZlhVVkNxUldHMVAzSWJrcVRPaDFyY2IwdGxaMTNETk96Qkt2?=
 =?utf-8?B?aW9paUs5NEdSMnlSR0NORDJNV1ZWWEJYeUc5M1FvTzd1N2lsenBmR2tMN3RJ?=
 =?utf-8?B?T3ZXaE4zNW5TL1VLdk9pMEc0MVJUbEE3NFVXK3NDTldwd1FUUm1CeUtReWZK?=
 =?utf-8?B?WlI0UStVYUZETjZXYzRudVI5SE9oVS9YUVVPY0FzRkRtYm1WOCtpMVJSYWtl?=
 =?utf-8?B?UEptZ3NaZnFxRlBFZGdhU2pxNVRQUmRsZVF1aVJKMFQ1SDBFQnFTWnBxL0dM?=
 =?utf-8?B?S3l0UE9mMmJEejJLUlhvaXBDNWlXdzByWGtsaE1OUVovRnBEZUI4T0lnU0Fk?=
 =?utf-8?B?V01VRGMxb1MzOW9XSW50ZVp6T2dFZ1ZCTCtZS20vZUVkRHM1cW93a3ViY0Rx?=
 =?utf-8?B?OTBuOFdiU2RMUEhHRklCN0U3bmxFakczMDlHcVQzVDBXbW1CQkRyZlRYL0tm?=
 =?utf-8?B?dmtuK3Q5aXhpckMydmdqNElJMkFaYlFUSms1ZmdGb1V3MEtFakI1TVdOZ2NM?=
 =?utf-8?B?bTBLZGtINVB2c0pnYWpRNDNRSTg2Z3dUNHRjUTRNQWFWWXRML0JQNTdoR2Er?=
 =?utf-8?B?ZVk1ejgwNGVQd001cjEwL0toTHlRL0VNWWFZTmdIR1k5c2JpbnZSaVlLa3ZR?=
 =?utf-8?B?dmQ2RExmSHE1S2UrN1JURklLSHlHbXlTaUFwVndtR0JWbk50TTF6bGUwZ3dK?=
 =?utf-8?B?WTFTMmM5T0FYOUJxNSs3NVpxZXpTeFZNRUtNZ29aTkl3V08xenhKZjRMRE5D?=
 =?utf-8?B?ckZESXFOWEFKeis4Um9WNGx6bUNxbjd1Q3B3WmRDVkNzeXNESkhuZ013REI2?=
 =?utf-8?B?UWphN0ozWGd5ZSt2THF3dnI1eExVRVAvTDFNZS93RHRaei9vaFI3NzJHOG00?=
 =?utf-8?B?Z09vdEd3SXVSeTBFaFFOdnhMd0VSczgzeS9ZdlQzZ2lkQXBQZUtvQlJ2MWR4?=
 =?utf-8?B?UUpCcUVxVkpNL1Y4SWl3TVBaMTJzMXN0QUtacm5HaDNyUFhXMjFXdVd6TjZX?=
 =?utf-8?B?TSt0a1A4SExUWDV4SXZjT2dTN3AycnovSzcrMVI4cmx6RnRxUUZuRTN6UUFF?=
 =?utf-8?B?WUt5c2sycnlaMzQzeGtFUWJLNDR0ZTVTYzBvVWl3di94bnlZYU5ZVmdkQ1Va?=
 =?utf-8?B?ZlAxdHRvNFp5Nms1YlFlMlA2ZU5YUEdlWWZpT3FFcC9MeXVZSjV0NWZXdGRk?=
 =?utf-8?B?Qndpb0RJMTZxQ28vRmsrNyt1djFyMHRkM3gxL2ZvWVlMNVpya0VrcEhaNkZ6?=
 =?utf-8?B?eHFsdktBTkMxd2VoTWt0SHRsUHdVcXpydG5kakp6ZW1idkN3T1hwRE1nOE9p?=
 =?utf-8?Q?q8QRm8lqwzgdlm864IriUEHz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98aeb92-b7f9-4761-78a8-08dcee794d3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:59:53.7493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VXE4+DDflMKX22amxK921uJT99QDbHFRIpIhsfNq+r/XN0xhZyBt8IxHUY+IT3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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



On 10/17/2024 11:53 AM, Kenneth Feng wrote:
> disable deep sleep during the compute workload for the
> potential performance loss on smu v14.0.2/3
> 
> V2: consider the case when the compute workload is set twice
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index da448523ec60..618a8e17c457 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1787,7 +1787,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> -
> +	uint32_t prev_profile_mode = smu->power_profile_mode;
>  	smu->power_profile_mode = input[size];
>  
>  	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> @@ -1845,6 +1845,14 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  		}
>  	}
>  
> +	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
> +		prev_profile_mode != PP_SMC_POWER_PROFILE_COMPUTE)

This check shouldn't be required. If the current profile is the same as
the target profile, the code shouldn't reach here - that check should be
at an earlier stage than this.

Thanks,
Lijo

> +		smu_v14_0_deep_sleep_control(smu, false);
> +
> +	if (smu->power_profile_mode != PP_SMC_POWER_PROFILE_COMPUTE &&
> +		prev_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +		smu_v14_0_deep_sleep_control(smu, true);
> +
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
