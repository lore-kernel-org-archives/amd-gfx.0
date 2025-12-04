Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AC8D216A4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 15:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8070310E98E;
	Thu,  4 Dec 2025 15:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBp4K9wA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20E210E98E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 15:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxHPyo7QOt/1Mmjs3bkQfQdmIDPqWagiZzXJDbOpVU/bHLo4i9c5x/LfZZeqnSK8Ac6rMddWWgwkoKgZS3YhUtvFSvDEOJ2p3cCEAj48ULf4uDMsy7Yo9LvAfmg+yLY/a3k5Q7TzLJKiVMthJ/fDswyT+tmiIzb52NWHca1GAR3znbuKDW6W1/71DWqWkjuf5kj80CgdxJ3bor++1UW4H5DsglWL9hnM6kBWTWPMXFUb+7y76KubjWq06xgpiNENj2m1V78IivLJYYZ6iOl3fLjzOvRpQysQToc94iojmc6iVntnQ4uobrh3NqgdLZkPpF77saZhRNQM+vxvzbGoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYKwmDenvA3JKP3/aCDzUkfWTccX6e9lKzfdrjZ7UMU=;
 b=W6zyPTzfeyG6jmd2+gL1mKwkFOsC6a72mbfSsU1tbw1PxmRVYpXRbgt6OOoXtcFaPFevfK6ivrDRheJWlkLo6I1tOTLr9ianEqSZX1xRalxnxVEaS4LLhyfxJwIMauswyou8LdiaDycmNSC16mOZCuQMQHvlodXjNHDLnhja/Dz94pdZbhUOOr2UQEhYWqtDxoGx4IszidR2Zkout5SuCxilEgPZjxIclS9jAv7suIK1BiZwue2IdXA4o4M11KKpjAhslRK07mPc1Sd96qWdbMK5Vrij8BPwi75WJJmebfYrWVJFCDbFJDujiDxEOJ6Qg/Bxy583nejykCnsuMZXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYKwmDenvA3JKP3/aCDzUkfWTccX6e9lKzfdrjZ7UMU=;
 b=dBp4K9wAqjhvYzEZEGP3mlnupmta+NdUBHl0yZ2RklFvM+xzO+va4SUMyXOHSUCyFFbdWf0b2BsW4DIxqYMz8nFVFMNU5wtys/peD1dR021pgaYZV+RXZoCrPcC3Gcteonip95yrF1ZSzWClbwOw2MQGE92QnGSyAOZjSVI1yXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 15:49:43 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 15:49:43 +0000
Message-ID: <054d770b-e1fa-47d6-a358-cd5256cfe410@amd.com>
Date: Thu, 4 Dec 2025 10:49:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251202201502.2038707-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20251202201502.2038707-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::27) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b47a88-4747-4b5b-6e86-08de334cbde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9sM2p4ckhVc1hpZG1JV3BrM2RXVkh1bDBsZU5HY0ZJUGJhTGZ3T0RXQ2ZT?=
 =?utf-8?B?YUFrRFJTbERuekZnVkpGOEVHaTV6NGJUMlRwWXRiZHAzMTl6NENVaVc4b1g4?=
 =?utf-8?B?SXY1eHM1VW9qYWxleGpoaWk2d095b2JQNjRDWUZQa1prUE9rSlhOaFh4M1Ur?=
 =?utf-8?B?RVZIWlRURXlLMjN4TGVJdFJsTkppS2tQb1dxWGw1U0Jmd3BhSXZpanp5YkJN?=
 =?utf-8?B?TEVEZFlrdFJmdGVEQTRkRHpEQXZMWTVZaVFWQ2p4QzI2di8xYlphZkhPWGsr?=
 =?utf-8?B?ajRqZlRtVXNoSFBPd1RkMjV1YktpSjlOTmltdHZockJjWVNXN3Zxb2ZUcEFF?=
 =?utf-8?B?V0JsOEwxTk9TdS91V1FpRTNYQ2pLZW1ZTjAwM0hhalVlRWFqUUpTQlNzaUFE?=
 =?utf-8?B?T01vVFFUNWVxQi8yTDZYM0hnbU10bzlKY2VpNktjanQ3Rm5wYnk4OWM1MnR0?=
 =?utf-8?B?WDBNTG02NTZGVGdlc0poSUVjcTdYKzZGckJYSDYxMUVmRk9ETjloYzFKcWxO?=
 =?utf-8?B?QmVKaEpaeXhhU0hRZXkvWXR1T1ArQng2RWNSVkxvNnphVHFGQjVaUVllT3Rl?=
 =?utf-8?B?ZWhINWhmZzBZdEtiNXZMTnFaazRma2NKZGJWSVkxZmhFa0tVS1lwclRCc0Vv?=
 =?utf-8?B?MjdUWW1zVk1welNWOSs5SE04SXhuTVN1NVZjS0VxdGZYNko3TXl2SXdQTjNi?=
 =?utf-8?B?YTlvMFMrWlBWR0tBZFJaWkZBY3BYbThYZzVSMm13SXJzS1ltVHl5SWh1R0tt?=
 =?utf-8?B?U3RYa2dLQVBCSlZJMnlIcTdONWlSWHBhS1RLUEVKRGNRcTJLMU1IT1hoNWdq?=
 =?utf-8?B?OThTZHF0bTZ1YkFLeWtaZlNwcHh4YUM4RVpHNXZnOU1FMkRLVzQ5QWxWdXl3?=
 =?utf-8?B?M3AzOFZVSmt4YVNwV2xGeTdMVWU2OW05ajV0cERmZjJwVm0zMERJei94Rjl2?=
 =?utf-8?B?QTNDUzFuZllKeVM4aDdqZEp1T2hvTERpMkhmSnpud0w2QTlZVkxCVkdEUW5O?=
 =?utf-8?B?eXpaK3dMUFFrTjdjc0EyRXd2angxNitPWnAzWE1KanBpbFVFTE0ydWZZYlRs?=
 =?utf-8?B?TFR3VzQ1QlFsL0tsdXpXT0NWMGdwS2NzVW9RRmZ1WUtPQWN2TWVCZWV4Y256?=
 =?utf-8?B?eE54MERGVDZhWTZWdlo2SWM1SnNBK09jSHJESHVSbU9uYi9Lb0pMVTFZamZ5?=
 =?utf-8?B?N2ptTk14cUpHTEVtTlFyQmZ4ekx1UTlLTElTMDhwb1E5YndGclE5cjN3bkZV?=
 =?utf-8?B?V21kYUJ4U2I2cWJzMXo1azNaUVBnRWVybHA2RFNhYVBpS2g2clhjNWNmM09G?=
 =?utf-8?B?RWY1UUFnUlVLeDh1Q2FSYWZwdHpFQXBUeVN6dnhBUDBEZ2lBT0UxM1JUT1dW?=
 =?utf-8?B?QTBKNndWSFVUOWo3MlJxdUs5Slp0V3ZoeE13NGRNcUxYM204OXVhWGhjOHla?=
 =?utf-8?B?QXkvckhNN09JSFRvVW9jQkNROEdtZEhoRWFnYVZkUkRWRFZQMXhqaGMvRWJn?=
 =?utf-8?B?QVl3bEhKUzN2WGh1TzZrSHJ3NGg0Nzc1TUVSUlo4UzE2RVV4aUpVS1ZpSlhm?=
 =?utf-8?B?TU5pa20xYWxuYTgxdmlaNEVtdk1wa3Q3TWpoa2hQMUs4NmRXR3dsVFF4V0Fx?=
 =?utf-8?B?M1RUMlZ6cFBmR1RwRFh0SHdhM2xGOXhSUTUwL3RUWDJpYmxRR0plbVdOcUZC?=
 =?utf-8?B?a1JQejFub3N1S2Rta2N6elFXK1VPVW9DZmVsbUJVRi9uZHhKY20vTDV4bDR5?=
 =?utf-8?B?Kzhya0o0Y1NBbk45eFRwdzl6REgrb1BiWWlRdzJpL2k0UmZSKzl1Uk1xQ3ZH?=
 =?utf-8?B?aTNpMXA1MnlXRFhLMXZvMTBSVFZWM3FLdTNtanNSUjAzRlEwVktENWY4Y1hX?=
 =?utf-8?B?dHBIZGxONUh5U2NKQTdNVGMzaDNhOG05YW51RjN4YlplOXhBZ0lJNXVnY2hh?=
 =?utf-8?Q?KTUFdX2MDOmf3n7rlu9grENoGiaGkLEk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZ5VnM2T2FyMDh5dVlNTVlaTFkySlkyYWx1dzRidlEvVFdBeVZsdkZYK0xr?=
 =?utf-8?B?SHE3OU1MSUFzWXNYcXRwS2dLMGFzVExtSjBvMUFHby96alhOc0IwaFk2QjIw?=
 =?utf-8?B?SEQwb2dRYmlRUTF3ZXRhS2hEaWxrS0pIUkVXd2d6eHVOYllLUklJaE5xOG5w?=
 =?utf-8?B?OVRES0UzbU1ReElWMU10ZEI1NU9MeFVWekZrc3dldmdjNmZHblE4T1pVNUhs?=
 =?utf-8?B?K2NCbmJFUmJJRHNickpZYi9Rd1pueG9lY2Y1S002SFNJMzM5M1ZiUWhpWW41?=
 =?utf-8?B?WUU0ZlNtKytGZGFtQTJWNEcrRmp0Yk4xNm5vYnE2V25Tcjhkek1RMklSRlow?=
 =?utf-8?B?U1NSc01tZm5Fb09RZmtUMFZla00zMFVxQytFbnlQWnFYNEowaG1Xamxac0gx?=
 =?utf-8?B?ak1KZzNoUTdES3lPNHVxa0xSdDl3Wmo4aDRURGJKU096UmZrS1ZlcmJnL2c5?=
 =?utf-8?B?dzFQK0FKNGZLQlo5TldHVlZuUGcvZ000L01UdHRENUhhZjVWRzh5eCt3RnJm?=
 =?utf-8?B?em5oa01qL25rSjNTRnhEdUpJTnBQc0JRZ3Y0WWp0eTVoQ2pDNmxhN3p0dGhL?=
 =?utf-8?B?UWNVSzROTVl5NzIxbitHTmw1VzRTeU5FS2NqSVF0REswdG0wd01QS25zOGRS?=
 =?utf-8?B?ZWNDQk42ZHU4Z1NVM2VRWlF5K2FrcTN1T0lSY0pkR0RMR2NGdjZmWk5EMUdL?=
 =?utf-8?B?UXI1VytwS2Q3aDdQWWJLcXRLUE9WUWU2aythbnUwRVdSWUpENXN4OEVQbUlE?=
 =?utf-8?B?S0VNT0hjdkdpRkdtNFRzaGtVTUo4Z3dxcGJqalcvNW5qSE5vQzVmbmYrNmVO?=
 =?utf-8?B?eUVkM3pBWVlSdlNWQzFGeVFnQXRDZzdaV0R2N0xtcXN1WjBONHRkR2RwZ0Jn?=
 =?utf-8?B?Z20wbVNZay9QdE9ZeFljcTdOVi9LMzR0c04xL2xkUk4rMTIvcm1qRzdtQnpU?=
 =?utf-8?B?N2Q5aDNEalZBV2NqazBXWjZhT3kvQW1ydk90SXF6TEI1d3M0QVV0M2srRU9h?=
 =?utf-8?B?cW8rYjhxQTlLLy8zbmQ5eFQ0c1ltRDBTM2xBUFNvOCtBMWVHbkozZUNsYWc5?=
 =?utf-8?B?OEFiQzFtbFJoeGtWWUxiMWhPNVZER3hGY29abnc1U3V2bFZPQjg3ZE52V0FV?=
 =?utf-8?B?eVBtZThzNkppaG55RXBwcGk2clFvdTNKaDdrV2xObW9VbjR2S0l5YWhIRzlL?=
 =?utf-8?B?QW5LcDR1TVBlVUJUVWpabDFJNlZ3MEd5SmRsaStaeTFVbk5JaW9rS0IxNVJa?=
 =?utf-8?B?K3BYUmF2UUoyT3NUaFdsc09jdjFiaUJKV2dlK2cwRG9JR1d3OFk0NHE4Q0tU?=
 =?utf-8?B?aHFqZDZzUlE1akdzS2FycTBRRzFQaEowYkJkVnJnd1NFOFlKakdzU3ZGVGth?=
 =?utf-8?B?Z0MyRXdzSzZLdGV6M2oraEFlcEFVeUJ4N1gvTUZrMEtXZXFGWU12S1p2MXlD?=
 =?utf-8?B?a2dPTStSUjhrUEdaQWhBUFRSRzBBclMxS1VuamdwaVBnSDkrSk5BcWNtYU13?=
 =?utf-8?B?R25LMllJSWRkTmRSeVl6R2hvOGJ3VGpMVjBQRFEyWUxCUEZ4WkhoY05BUXR6?=
 =?utf-8?B?TmI3U2pKbzhsTlVlbHFFQ2Mzdmd1YkI0MnY2eFI5dkpWVThCN3V4SEhoYVd5?=
 =?utf-8?B?VEhPUURYUng0WEJHdnVoR1hNQXY0WEVMTEFiMVNtQURFUmNJeWtLNUlIakpS?=
 =?utf-8?B?bU13SHZ0SUdHemEvY2lGU3lPSjJmZkR6NEpmenpZRjNWSkZJMk5nZ0lrbkVZ?=
 =?utf-8?B?L3E2TDVKZXBuUE14UjNtcWlCVk1TREtEaW1ZQUhJM0lVdUo4WHRxZkpkZmNa?=
 =?utf-8?B?KzJyWjNYWmtHT29PUG9JSXcyZzc5eWVvQllFR2VncmpIRWNYMXNDY2lPSXcv?=
 =?utf-8?B?WGFyUEFoaXNPUFhuRnBlS2h3MW0rTWJZVFNoM0hqd29JY0RicURJNC9Hd1A3?=
 =?utf-8?B?a09KLzk0a3g4cW44dDg0REFuaTFUZlBKdnkxUFRqeWJZbytBbnZPL2dqNjZI?=
 =?utf-8?B?NjVtNXI3RFMrSStQbktvdG1IMFgxY1dUcGVhbjZVMWZ2cXY3aUJ5czdJaTdp?=
 =?utf-8?B?TUVacGRhcDY0Y29uRzRvREhjYVNoQW1yemFDQ0p0RDFBY2NYYTFrMkMwUkRN?=
 =?utf-8?Q?txHKoqG4JTQByGDe1/uTmj5JT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b47a88-4747-4b5b-6e86-08de334cbde8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:49:43.1757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU46ZtIqG/Cts8aH5guhHb81AgS1ghSjfhS3DPl4zdKuzKrsZEbEwdu+cxWLBZLnBpuO/8II8fQ1SgnrCF48LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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

On 2025-12-02 15:15, Alex Deucher wrote:
> This can get called from an atomic context.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4470
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 922f23557f5d9..0971dfa258454 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -86,7 +86,7 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
>  	struct dc_plane_state *plane_state = kvzalloc(sizeof(*plane_state),
> -							GFP_KERNEL);
> +							GFP_ATOMIC);
>  
>  	if (NULL == plane_state)
>  		return NULL;

