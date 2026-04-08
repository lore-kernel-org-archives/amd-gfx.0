Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE410F994F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 15:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E8E10E68E;
	Wed,  8 Apr 2026 15:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h5VvlyGu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D2510E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 15:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuCxHzUJQaoxcN2BtLL9uVBvC/wVb6VqnpXoLCzQQ9Z6oXlMGIWpa7mIB2sbWUr26yo9SbJYtJDCjDw7VAfRPj+UUUK/fu1hhuTN8ti9XJl19skzMsfjeEMOPrLsIn6mbsJgcPnrD8ZVk+dmoSi4dxWSdH+0Cc2lz9GMFG0/k/tdGKmnDBTuvsUlTjlzWl4yjXAo61EAW8sx/Id8oo3suIPKkwFBiBe84cXfRJAnxomt2IDju3Qve70kZTnYaWSRSnR+5yPt1tA54ud6Oo0Rv+4fTMqcmhuVlcbl05UMrZ/if/Nbqu6P8VH6JiqSLKECAtkZCF+n/qDbfqdUXgDRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIvtYHN+XB9Cm+pPTW0EL7FAwd2SJODHIucDGI3hUzo=;
 b=BdSYim0uepCXi8Ov7Wbdm83LE36/GkMVwhmGF6gJ+o0t1LLVDr4f44sUfq+ttgiDd+hdEuute2185v5FrHQXQawLV/q6JYwKsNJqykM+xPA/bAPiKMj5rz7mIl7gRZZoUvFhJ4BPbHO1v44VL3qD+LlVlUOewXl+3AGFppX0fZraK24sihTxfxapBnC0p8eKWTO9Zt19B6N940lMRZTIOnGih+3IIV3igCdFhdmW/dH5UTGw+oXETooLPD7ciAFjEHYF+V6BKznoLeCF6WrPTfRuNKp5VpgzpnbQRd9ceLsYeJet9X3vMeYxPzeVF3lRbXHGOvgyQ3SRFKzLoc7h4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIvtYHN+XB9Cm+pPTW0EL7FAwd2SJODHIucDGI3hUzo=;
 b=h5VvlyGuOd9+c5hH7FPV3Vsv99B4YNXWGsc8aSe04S5txYNgJ7R1ayM39c/ZP8gzRekQ4gOu8BYLLKV6FX+Ew1amKXhG8/FD7qCcmA1x1x31Ni87uac+bIPkVcr+Od/+lrenaYwGRApTFoZh2JaVZ8UW7eAkgUXhnNtDbl+38NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 15:22:00 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:22:00 +0000
Message-ID: <ab9865e6-02db-416a-83b9-484410f0aa0b@amd.com>
Date: Wed, 8 Apr 2026 09:21:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add missing do_mccs parameter description
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20260407082708.2265795-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260407082708.2265795-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4b0b6e-6774-48e3-c1e9-08de95829467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: J+cfuqq3wTjbvP4NRCZ8cRk4HuMqs40ll4n8shEY4Dr3jftRf1Zv/YE+ePCMfBVZqkHYZBR3Mc1GVlThx5EX5S/LppwhLe9kuQcciZ1Dt6yRoTHxHxtkNaRpmZnBC4K9Id7qOqxK7oFFj2tVxzvaPSN3qeNUcbTsCSlhR2Fqp5ERFKMAydrskQtanQ5gqnUGk6TFsULq0wQWwC1IPyqQxaqexuB9mfGy5ZNvGfk0GV+Fpyy66Ydq9ak3DWKJ7RFocDGYMD36QnCAQRT8gmzJJSkFVCHTC/aruHLE//N2pN6lGMHwgmE30j79KRdPua7uOXmEUAaoYOniQZdUoKpRGOUzqesGkd2OjusjTFMQL6AKrZEpUMdl3cXyWG2jKDS++ZwUK/mexJAhuTP4E114CrTEg3LPsUDmHtkov2ZFkxMHzF2xDz+LlU6J91ykiV58uKgmRaQ+ZXKwl/GRSaK0HCmLRjKDR06w97S82NdAjgSS1XU2yOVaH6ojzJ39ge8X6+K/MDf1TfgKmUnKBZ0EJiulDKF8Z+ZxpoLeFPkzITaLI/Gdju3vRhwg5J2iSxvKKGdjOGMjMELa92yx5wvkm7BgAcx2uk8R4rGqPPPrGlXMj9x9LzT4S1xbolHZGyO6J4AkEycN/nGZEDsfQ7qsKMVJIrHe+RaliETIv7P572uwaRDv2Mst30WAlojW7SRiAq+pLL/EK1C/CoyrgHGtzeBhtcpPu5YXttOz5+lFzbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0M3a3QyVmYzWlh4VGVMZVRiRnpROUpjdnpyU1UwN285eVVTSXZ3ek9FZ3c1?=
 =?utf-8?B?eUV6U0dwVUxZUmpKYkV2dmNsMFFUc25nNEZVeHpnNWVoL1haVjUzbXBRbUZ1?=
 =?utf-8?B?eXpuR0d2ZFYzR3NIa3BQSVZzTHlrQ01GOGwwa0lHNGVCMldwdVBGdThWejN2?=
 =?utf-8?B?ZHl6NHJweXBzZkplQVhxYWdnNWI4U0xBRCtKV2ZJaVF5YW8xRXZMcVp2Y2dy?=
 =?utf-8?B?NWZsYTFDdXpYK2UrdXNuTVVQK3dBT3QxUllYcUQrQkwvVk1sSGEzM0x6Ym1o?=
 =?utf-8?B?Ly94YldQZzhydXFJWjUvYkhRazRndDFtVkJjVHU4eDBHRExRWXl6SjFsTjJN?=
 =?utf-8?B?SzhiY2RuZDlVQWxaYllpTHdVcUFZSklxMXA4RWVGYjg0Slk5Njg1SjRVZDdh?=
 =?utf-8?B?R0gwQjcyU0IrM2hMMGNUUVVOc3ZBcUdscEdJTVFyM0lDN0JhUzlUOTJ4SnZO?=
 =?utf-8?B?NFlpRm9GY3hiZGxDWVZMdk5pTlFUamlIbFBpM3dZaHR0S0xKZkNRZFJsTWht?=
 =?utf-8?B?VEcyekp1VXA4Z1BSSTB4c1p5NDIxNXhjbVJKdFJWYlFPckZhNGt3SEFZUmFl?=
 =?utf-8?B?U3piMlVPaXlGeWUvTHNvTTJSNVZrNktXNkJZTS9vN3VMQXc2SzNBN21jTVJJ?=
 =?utf-8?B?ZUUxV2JrQ1J0bmxqQkpVNU8zSHRMOEk0NDJ1ejNhSXZRZUxmbDZ5cWV4R2Zv?=
 =?utf-8?B?Y0dsNmN4aTRZZHdKSTNxTCswaWFvRWduZmRmTXM5cVU0K3JJU0ZsamVvUDlo?=
 =?utf-8?B?dUl3K01IczBucUFGYkxVUUFOZjMraHZqbktqeTU0RlBycmVKR1h4TTZUeUNa?=
 =?utf-8?B?KzFsUXlQQ0h1T0VvOWV4aVZlb2w4UEhLZ2doVUFnSk1ZRHI5ZVVlbXJEc0k3?=
 =?utf-8?B?eEZWWmY5Z0xYL095SFVYenBoWWxpb2k4andFOTM2d21RSUpYVEl1VVhtTXl1?=
 =?utf-8?B?OU9JSmJucUQzTTJIYmZ1TjdDODdTaWJBVlMxelU5ckNFY0VlajJkSThmaVZh?=
 =?utf-8?B?U0h5VFl3ZGFvMVY3S3AxVzUydGVUS1RQN3NIdlg1Uk96V2Jya05qWUJId2Nj?=
 =?utf-8?B?RW9GSnpHUVo4eXh0MFlWOWd0S0pPcVkvY2FwL3MrSlR3Ty9JYVdBRDdoS3BK?=
 =?utf-8?B?ejRoR3dQVmMzS2cwYUNYbFp1bzJnWWFFZ28vSVlOMVJTSkhlVjJXL2s4KzN3?=
 =?utf-8?B?QXFpbzdxZUdzQTVGRzVVSitDam0rRVBMdzBzazdxcHhMU3BIZkpQYWJucnR2?=
 =?utf-8?B?L21INGtqQWQvckNLM2JJd25sRmt6RjBEQzhIa1hHeFlKUW51OEVCNWkrZTZx?=
 =?utf-8?B?V0dLdktUT1RoVWtXMHpTUFRiNFdsSTNWaWVsRjlNelVldGdCWTJBUExKNnVP?=
 =?utf-8?B?WGlpdXA5QWhiNTVIakhaZ2gzb0svYU5PTktWemFWb0E4ZlFiaTFtdlBIWDg4?=
 =?utf-8?B?ZG43QUE1K1hDSG0zQzNCbmd4WXkxZ1RWR2gyRWg3NnU0aUV2VSthejZqN3p0?=
 =?utf-8?B?YzVxMFdRalpOSkJyL29sVFd5Ny93Nkhuc3VPT2RsSzNqbm9MUDgxMHN2K3VT?=
 =?utf-8?B?UXZTYS92R1RRaURrUWxTdWV4SWlnOGtEQkMxdFoyc2lONnU1OWZSQTNkSjdo?=
 =?utf-8?B?czI2QzgxZmZDVHM1QmJJQU1PbXdCVXF1Z2Foek1NQ3pyWnJ0OVFqMzJ4L216?=
 =?utf-8?B?YzhpNzRCYnFEbFdHRVVJZDRDYnBpY2ZzZEsxZTFNSkxwVDNqZERHNEc0Zytl?=
 =?utf-8?B?S08renZuaHdYUHdwdHBiQkJ6ejN1SG9ISkE1T25GMlNuTmJBNFlGbW9sQVIr?=
 =?utf-8?B?SmJ5TkNBVXdnMVpxQlQwSWUvRkxidDR1TVYvSy8zNlpWZkNMMm1PbHlPNGpO?=
 =?utf-8?B?eXc4dUlweFdER0t5MmtRMzR0QXE2VGhhdytPNWwyUUdVUE1WY3pFbFAzNGNP?=
 =?utf-8?B?R0JwRFZmT3dKYmRvekJ4UE1OTVkyWGlLMkdpSzY4ZFZya2txdGRORk9qUU5a?=
 =?utf-8?B?cm5XUnVaL1JKNHJrcE9Qc1NHOEJCejkwK1dydTBVTFVIL1dxYnpHbU1tVk5H?=
 =?utf-8?B?REdxZHhnMWFJUEhTYzJRT2s2aEJiRmlkazZFQ3BabjBPcnlXOVR4N0c4TEhH?=
 =?utf-8?B?UnRCaUNITlU1eURKZUZNWU0zNHU1NGY3NkhDRGRtbldMdTBVUGJCZHRPN0JZ?=
 =?utf-8?B?NDJ4M2ZvRE8wUUEwY3pSNnVjb0NLWHM0VXlFN1RRanAwS2VlN1lXY2tDbXlt?=
 =?utf-8?B?TitwU2hJbXY3OTlmeXZuazd2aWF1TUd6K2o2QTA1ckFsTGhCNjk1VWZkb2hJ?=
 =?utf-8?B?QWhHck9iSzZmV3V4S3NBV2xGWkZqU2tLMjdQWEoyckxWTHJyOElDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4b0b6e-6774-48e3-c1e9-08de95829467
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:22:00.3082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/AqJIM9tN3mEof3KWdANGXOXN8/3iDj3I3wT7DpNQOZQjzAXM3yVgWVfif1vZY5pAUKDqy026C60mJpzP/b7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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



On 4/7/26 02:27, Srinivasan Shanmugam wrote:
> Add missing description for do_mccs parameter in
> amdgpu_dm_update_freesync_caps.
> 
> @do_mccs – This flag controls whether MCCS/DDC transactions are
> performed.  When true, the driver queries the monitor using MCCS
> (Monitor Control Command Set) over DDC (Display Data Channel) to get or
> update additional FreeSync capability information. When false, these
> transactions are skipped to avoid unnecessary communication with the
> monitor.

Hi Srinivasan,

The above description can be moved to amdgpu_dm.c. It is informative and 
people rarely check commit messages.

Thanks.

> 
> Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bac02ea15b8a..4b6a1c62bfa8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -13259,6 +13259,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>    *
>    * @connector: Connector to query.
>    * @drm_edid: DRM EDID from monitor
> + * @do_mccs: Whether to query/update MCCS-based FreeSync capability handling.
>    *
>    * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
>    * track of some of the display information in the internal data struct used by

