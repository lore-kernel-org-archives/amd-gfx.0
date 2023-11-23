Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550DBC5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 16:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA7210E722;
	Thu, 23 Nov 2023 16:36:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A8010E08B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 16:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl6XWSnOtEtOqyZdAuQ83b5O4z4sYa6tv/hGYzIUkFIJIb/P2YRwXE1n4ZRAJWMVUSS+cjdWs50P880n1iQdFUsJNYdvv4FKLm3eQGITigegZAtD1JA525v0lpyekqYbL5OvPSV4S4D9mmPCw4vcxjbZhm4YHwK7G/eqrPDmnxZL0eAhk1wHmqS7FuzQJlA/PzwnVNAapMdRKUVBy0b3Dkj/Q+hg7itnP45G+a6L8XNdYv/wUdsPaHGyymvNaptd1WMDWDQIovJIUZ/ejn5oSgN8XladVxe/rDtYxIalcrNUBL2iLKnsaYO1FffUnD85PPPRQYpRPZMZvZN+Rpi2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=774jxKIdIzO1bNY6XkxtAFv+NeW0k6d951eh7XRXOvs=;
 b=iTrJ9K2R0XvEgHZ+A41RMosICH7EdBhGvfkj9lAYgs4bbXIoRa+2pQ5TUl2c85ygdRLTn8okaECL2AjtR5TZK/lY//QD6jZVdhPjjukg1xqUhciPm83sKkLA2X1mp923Kqgrnpczu0nxt6HRKhTmSUN3cf0FDvedp4BmUAPtWGR0fv0H3oTp44bd5Kd2/s1tVCGUOjMW8+hF/kZtIbxGb1ZCyB7S67AHlwQBUWFwnPT6NK1rtuVIrHZFEEJ0bg6VRsKcwGt2aYRJMrFpazRopWq4XU98sG1nrGcRHXcXkmYv2+2p25YjjfvyQ4U96c8XmlQpjQkljIHWDxuiKoF2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=774jxKIdIzO1bNY6XkxtAFv+NeW0k6d951eh7XRXOvs=;
 b=cUTosAp2Yc9B4qUNhQD7ApkCaDtCIXYX7U9rp4S+32iW2Edkv2gVKUV0Q9hkKNGVyDOVmjAgNn/++iPjm0uXS4faPddD9SYiSPxVtu3NyzD5bdxiME7KAxU+S0P58GoI02LyOQfMBUVj27TaQYnWcCd61MSwQVD8nW/DGpY0gUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 16:36:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::5e7e:d568:2bfd:a53a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::5e7e:d568:2bfd:a53a%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 16:36:23 +0000
Message-ID: <31999931-7b97-4046-8949-461424bb23c8@amd.com>
Date: Thu, 23 Nov 2023 11:36:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix ABM disablement
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231122222409.53901-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231122222409.53901-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 07758a10-12b8-4ef5-6ea0-08dbec42547e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhT3O3PtrVELQE9W4CrxyISzbqSRvdSs52hfmaoqj6nmc5XMsS7eZql+jTorWQFI1ti/vNE7eTfJmQYWUnMX9t9/+c1rhEkQbf+ZnR890LdEY5GF+juAV2TJZUcafKjSJ7q88jx0MrOt0NE10AmuBXa5Y5H/9j1yP39ewGbf/81+bJbgLNOrzJlUupYopOq9Py9jum9Jj5Zx6Ijg6Zz9qVnne80YimGOENf59bRrVGL9KPgG8qXimvw1Ji8+5La9gA2NAV7GW6jkGn6yPEI7DBl16RXRN0Jptk8E/2pCOaA285nZm0Vy/b/bcufDmR6HFNlBaPnLOj3hvuDygsk2dxdiw2LIYjYNOCBdkfKS1eBFflYm017+lqT1U/IgKwwwvkBDEGR3FHqKvoh6yCp6nov0hGF7uRMNk1w8gI4nopDWNT7ftl420FINtqVwRBK9GQQzBYYRMw9/c4NhwdTOPF98RVKzNpyBHGcL2z9VV+davn7IGzjF8LHGaMXW4NOQRBP6hFsu60Moe7kHpFBe+Q05iD2PbUEHFuzCALnV9YQW6U4Qg1cGphfGyIApxDr6bfwG/YEXY0CWCLC9LKXbfdTevpmtTHA/ejeTXTT+I/2J+dsDFS7yxl2isSndu0uuC/M7XEbSE6n5IaX5pn5BMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(54906003)(66556008)(31686004)(4001150100001)(41300700001)(5660300002)(2906002)(44832011)(8936002)(4326008)(8676002)(316002)(66476007)(66946007)(86362001)(31696002)(6486002)(478600001)(38100700002)(6666004)(53546011)(6512007)(6506007)(36756003)(2616005)(83380400001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWd2YXJOQnplZVNicmxMWTZlUHlENzV3T3o1clllQ0FyU1RZbkYzaE1NcEsr?=
 =?utf-8?B?clNIRGxlVkQzSzBrT3piWWMwc2hId2FaR3prREdQOUxqSjhBNStrMkg2ZjFo?=
 =?utf-8?B?dFdkMWtreGp4VGF2RXhZWktySnc5Z3RuVGhyZTQ5bjUvbWhCak5ZOERXM0px?=
 =?utf-8?B?WlErelZNbGlrdHJlbGNCTWRuS1MwZ2hGUEJOTUcwSXVwOVZ2enRpMytNSlBp?=
 =?utf-8?B?UXZ4d3BTMXVYNlJnTldWQTd3T0hGYTZVdFc4OXZ3dWw0TTR0RmRpTUY3ZDRM?=
 =?utf-8?B?ZGlKSXkwYWtuMWZWOWZ3WnVxMEU0QTVTdE9IMlF4Y0dhRHdSSEZwZzlYejJK?=
 =?utf-8?B?OExUSG4veGlLU1NQcnB3b0w2OFVpQlk2ZTcvRnhla0NoQXJJTCtwT0lIcnlO?=
 =?utf-8?B?TDNaK0toUVZNWW1HRE4yNmcxM1orb21HSW94dWE2dlpTNkZjSkIrbnU5cEd2?=
 =?utf-8?B?VHV1NnhjR3FNa2tWV1A2N056d29Ra1JiK2RhbjZQdWJ1MXlQUEJTNWhod1Nh?=
 =?utf-8?B?Ulh6S3dTRm5IeFFvMjZwZG9iS09talVQSktIWWtWVU5ORG5vRVd1eC82UFpD?=
 =?utf-8?B?eUhxNi83c25GWmxESXJnNStEbGpUSHNBd2xmQWEwVDVnanVWUXlwZ2lwQ2JP?=
 =?utf-8?B?UkNXWjVVSyttK1M4WlFuNWhZdGlIMkpENmw0YTh6N2dSeE5vb1ZrV0EwcjdB?=
 =?utf-8?B?bXgrRyt4UmJVajhPNDExUWV6SGVVaTdaUW9pSVlMWVBIbGo3cm9kVHV0MXhl?=
 =?utf-8?B?YWVhdmVMcDEwSkVJNUZOUDdKVDZYazgyZWRRdDVYeE42cVowbW5mV2xJU2Rw?=
 =?utf-8?B?WWJQUlQwU3BNK3dRem9Zd3JORzRIYzZ0Vm5MWXNHQ3czNldnaVRMWjY3azFY?=
 =?utf-8?B?VzdQZ3BqMjU5TFdoblhscWhvdW5nd2M5QS90bEtGMjYrVWt5U0JEVlhrdHJu?=
 =?utf-8?B?dDRsMVhwK0x5d0dhS2c3ZHJkQ0tTeHd4SW43ZEk1bzZPQWx5Zmpkd2VDSFJ4?=
 =?utf-8?B?YnVBMXpWZ1pVbnhTcDM3Tlh6bnh3WjJCcnRpdUxNcUh2ZUJLZXdYM0puQWc4?=
 =?utf-8?B?RE1vWmRjQzhQa2VRdjl5YVdlcVFER2ZRWkovSmsyNnZhQlgxNjRxTnFoRkUr?=
 =?utf-8?B?MUdlY2VkUFlORDNoYndPNWxPdGdPbzEwaVF2aW5wc2tYcnkweVpQMEV3c1pR?=
 =?utf-8?B?ZStTVXgwSlU5TlVhVC9YOFNNcWJ1aXd6NXcrSWNmUUJhUnZXaXlwdktqOSti?=
 =?utf-8?B?RzUzUFM3Q0Q1enNMMGlvMFF5eldaUW5PblZlYktUVml2MlhCRC9FcllIeEF1?=
 =?utf-8?B?TWNtQ0U2Y0ZsOWFLM0pIcC8wbzQ4VXNLajFkeEJnL1l4eU5xeDNNNmQ0SG5U?=
 =?utf-8?B?SmNpT0xQM1I0VlpyamZBNXhjWW81NmVhZW9vcE1IaWFqbExRaWI1SHBjUHZI?=
 =?utf-8?B?TGM2eWhGQzZRRGlJMTN3dHlYZW81a09PUmZ3Si9yRjlhZmxCUmpabU1lWmtD?=
 =?utf-8?B?L3Bxa0NrNUNvUjN3TGw0ZjJXdHcvSnZuMk0yL1Y2WDBiTkYxSlhtMjBDZVFp?=
 =?utf-8?B?QUZRQm50K3dxWDRvdnMvbHNaY0hiZkZlRkx4YjMyaGdjM21WdzI2UmZOZUVE?=
 =?utf-8?B?ZWt5ZGpNbnByWVI3RVIyMDdwazRyYU5wSVdqUVZ4VXNKUVV0d0NHNzJObzkv?=
 =?utf-8?B?UGVGUXJUK29YSXJTZFdRWm1wc0FNeGNBdklVaDRiMUpMZE5ZaGpPWStOV3Nt?=
 =?utf-8?B?Qm50Z0hUeGQvRFFuL2lGYnFLWk9YVzhxdkJWOG9oNVNmbzBpZmhjeld2dEpD?=
 =?utf-8?B?elZLUlRzK25zN1lMWC9rVUZIVEhKcUFYUXM4bXNzNzB4YkY0Z1d3SjlIaExR?=
 =?utf-8?B?MXU0TWNkU3p1cVVyUGI3TG1sdUJBclk2MGFtZDl0dkNOQnByU3RBemdrajBO?=
 =?utf-8?B?VU9FV2h1VGtZUDNXOEdhZ2VOMWxpdlRpdVVoaDdqUm00bWJzc1d1L3dFT1RY?=
 =?utf-8?B?MXdUZnBXQlZaeklIOE02K0JtS0hUYllCMHMyYTdkVW5ZLytuTTR0Y0w3T01p?=
 =?utf-8?B?aFNENzBRejIzRDR2cGw3ZVlRSlZwOHpjZzZsUFBkVThKd25DaVNFSnlxZ05C?=
 =?utf-8?Q?hYecpKUUk+PlnVROjL2EJq59t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07758a10-12b8-4ef5-6ea0-08dbec42547e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:36:23.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBVezCEFbbOnyHUhgbL22r/nSuIwe0ecW6q8jB84Vs4n2Joy33OKBxFjxeU4qTVWyxTjGNIR/QtXY7oe6UR0QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-11-22 17:24, Hamza Mahfooz wrote:
> On recent versions of DMUB firmware, if we want to completely disable
> ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
> level to DMUB. Otherwise, LCD eDP displays are unable to reach their
> maximum brightness levels. So, to fix this whenever the user requests an
> ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
> to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
> to 0 when a user tries to read the requested ABM level.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5d9496db0ecb..8cb92d941cd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
>  		dm_new_state->underscan_enable = val;
>  		ret = 0;
>  	} else if (property == adev->mode_info.abm_level_property) {
> -		dm_new_state->abm_level = val;
> +		dm_new_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
>  		ret = 0;
>  	}
>  
> @@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>  		*val = dm_state->underscan_enable;
>  		ret = 0;
>  	} else if (property == adev->mode_info.abm_level_property) {
> -		*val = dm_state->abm_level;
> +		*val = (dm_state->abm_level != ABM_LEVEL_IMMEDIATE_DISABLE) ?
> +			dm_state->abm_level : 0;
>  		ret = 0;
>  	}
>  
> @@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  		state->pbn = 0;
>  
>  		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -			state->abm_level = amdgpu_dm_abm_level;
> +			state->abm_level = amdgpu_dm_abm_level ?:
> +				ABM_LEVEL_IMMEDIATE_DISABLE;
>  
>  		__drm_atomic_helper_connector_reset(connector, &state->base);
>  	}

