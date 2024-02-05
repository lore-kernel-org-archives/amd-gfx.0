Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC11AC4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 15:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5498810E290;
	Mon,  5 Feb 2024 15:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXSu3TdQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD3410E290
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 15:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY8eGbFLZqMsSswCvX5W0/FfJPbGCA/fL+WMdlYhbxn/puGsY21RN2ZWfbN7XB03xzSQrRKezw9E91TxOQW64R7EGBkInCNe9/omIBz0Gfe+qTUgnlvZJSYSgmoQgBk/HZH4bVZ3JpjZlxTdab3+ltXDYsL64Ng4E15tiF0qpUZT8MpECv89QHGK1JYbt4xZ85ZzlqqJ8D6rOuJsb540SPfhPIiKhCiZ8gy6Zune4CzXZ+TRhzJTZx0bJOc490k+o0XfhwsXUMqDr1GyJEJETmrKZ14LkXBk8rHAjOtd7bHiCuwALQT8Kh94EYG2u3riySpisGNoc2OE9AavdM4cGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVJrQbtuX3h9qCqtD+LcPN3tMYE/JZXCTuA/L3iuaLQ=;
 b=bQ7h+1LY3I0A2eQZzUqXbL52tJKRMIyhY8v2SYtPWllE+lQUdeLChZ/yc4sOdiVELmSgWhPren/GwRXDwJShn+E/4XeqDsukdPzac9kTB9KUXvAfnlublCBQvHLLga5oQMbYb95qZuwQ0GnPCOWBpAMMGgBIrJmIO43ASHAgfaPrgsH9vsAd+ft6xpZNBqCMvoAYX1pr/Pq8n+L7pnBHWQtNknAMl66Ijp/n3YANIo7CWuMPqIuQOyr9AuMdaOoFDS0M8HZhpqlbTSH5L2t9xq+vU4IbwZ+pDAT4r8cSE6RDvLalTCXtW26XPKSVXkBqS0AoV/YGuap2L+eU2sJpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVJrQbtuX3h9qCqtD+LcPN3tMYE/JZXCTuA/L3iuaLQ=;
 b=cXSu3TdQyy7rAq2Kye1q1Iu5Z9mbUYYAP4SgAfyhQ0ouRz03QefJbYGVcdIMUS69rjgTiZWCS2AEbm2xJUNHBfDw+elpXdyrvC+s2lebQWunCwsRWswX7K017eCiEuJ/lnvhUUJmgrhY9KJ3UVq2kRzjNRN30Ldq4E9WiuT+qN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 15:27:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994%6]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 15:27:24 +0000
Message-ID: <e60cebb8-c007-4770-9026-ef55e8b0e033@amd.com>
Date: Mon, 5 Feb 2024 10:27:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: only call sysfs_remove_group() for eDP
 connectors
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20240205151828.20716-1-hamza.mahfooz@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240205151828.20716-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH0PR12MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 06724c12-5c4a-4640-1949-08dc265ef3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhJ9DnnEW7+jywU5EwOYVAIpt1Dnm0epM5kCwnELvAsV2k8Y/MTyeJbCPXNLy+jwwTft1qMFuZo9kPHlVnGbEDJdzZppXVYddRPmY85TjkrB3O3OJFcPrgYXNrBjCkwpUFOrBYVTu2rx6wXVQT0t+I9FK+fcaDnXMsxlcHuwbZS9Js12zNz4+/L9AyuRdF8yY751GCv5rwWeBPdS2COX+7RWN1P/HWUz5zDvgY+u/Sse2N5n1ESUhp4ARrIXHIEQphzGrmQiLQ12brZ+wO+57ZQBuQAj92fIsQKIrIMzDfOs8clNACe79jvaFYm4umTRPtKkJH9MZFbQeBIAWOqJ3uLGLw86gQoBWCfB6VU19gfLhLzAgg67gRxFBgUPUjSinOrV+mBLKlop8c5U9+arVz/zSQWacmXeLXIbOuYXW49qClRQl8Zew5Xefs7LCBm/KUiW8VuLlOh7L296iVmKdv+fSXXGti8TjbGBVEImVmB/1KTk/oOx70BjRaMVx3buP9Nn+BF2ZDYz7EhcT+iWFbyFH7Zg9iIWQJHYgss1QcsjRoWNh89lUT81mL1cHwPXqt4L0Lff+tVL4HsrXcwIFU8iKHpwIGxQIpEa61whr6lNQDB/WoCEwFJaIox/ts6MAvh5x7bL0huKhXjk6JLXjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(44832011)(478600001)(8936002)(4326008)(41300700001)(2906002)(5660300002)(8676002)(86362001)(6666004)(6486002)(31696002)(66946007)(66556008)(2616005)(66476007)(54906003)(38100700002)(53546011)(316002)(6512007)(26005)(83380400001)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dESEZnNWhPRGo3SHZYNDVZaVFuZTBnQmlWd3ZlaXQxbHVTYnIwZWg4YnU1?=
 =?utf-8?B?RDhLa3cvOFo3MFlVZjlGSzNzN3NDM1lIU2tTL0U3MUZkNE5LMWkrNERjT21H?=
 =?utf-8?B?OXVFYlpCSFlJM3Ivc2dRSFlFMnpDa2FwTWFyZ3pqbExyZmJpbHBMYmt5RVZn?=
 =?utf-8?B?Y01ENTIzWWRkYzRudkJrbzNTT2FkVVZPTU1UbWdTSlN4RCtET1FMbkpub3E2?=
 =?utf-8?B?TDBjVWFwL0JTZVU5VzFZU2VuQU9mRmc1RjFiaU5wRjQ5Vm1yY1ZndzRsc2RJ?=
 =?utf-8?B?WFpHWjJZeWFXenM5SnZrSkFCeCtNUnVPSm9ySWJZRnptNHoyZ09PcTdiamN3?=
 =?utf-8?B?ZWpvYjY4QVVHOHh1TTRwelhGdnlwYU95MGZ6b1BSb2x6bVJKNVpQdXYyODk2?=
 =?utf-8?B?NzZ1Z3FwZFhPcjJDcFNCNElGeHE4K2tOL1hQajF5V1hhWjRJWXc0YWJrTys3?=
 =?utf-8?B?SU11WmZ3Vm5Edm4wVXJScnVqbk9yQjJHTGo1dzc2WUdaZEVLYlhkYmhhcElN?=
 =?utf-8?B?U3VrRUJlR1FGOWRpaC9CdDFDRm43b3l6UDNFTitVeHUxRFM5eldCVmFUcEJX?=
 =?utf-8?B?UStHNnRNL3hvbnVqZDNnNTNtZHRObjZFV3pJTW96UG9EOTBrWXlDOWxhYlZw?=
 =?utf-8?B?WCtGcGVGT2hCRUR6V3IrQ1l0ait3UHpQZnZ0VG43bU1ac1hyVHFvd0hwMDFN?=
 =?utf-8?B?V3NCTkpNMWc0b3JZRnUvWmZxOGFOam5YbGZVdDN6dFNGS00wdmVad1hkcjJm?=
 =?utf-8?B?bjFVYUU3djQrdXRLTWlZOW5tSDV5NCswcUhyWFBxdWViZW8rZEpoZzZZdjVh?=
 =?utf-8?B?UzlyNFhtd3JUOVY3blRycENGUUV0YXZlTkxlam1GK0MzRUhrUmNRR1NJb1Yw?=
 =?utf-8?B?dFhQcXQ1UjBSdE9mRGlwOHRBdnU4RHJ2RmtuNWRUcU0xUTRQOGpQLzZYR3lP?=
 =?utf-8?B?YTFaLzIvWmVoUDhQOU5vOU8zcXlrRWE5ZWNMaEdnM1hxSzJYcXRkL05ISEVP?=
 =?utf-8?B?Tmgxc1Y4b01oSVAxRWtZWHF0RStrRGZvRE5mb2pZM3dUMGR0Tmt2U0FjQXZz?=
 =?utf-8?B?WVI3Y2QzeUltVUVFMUJFTVRpMkM5UEQwSzdLdER1UmNEcUFEWXBtRDZ1YWlK?=
 =?utf-8?B?NTRxNVQydmh1S0o2d2VBeEIyeXJucU9nNE9yNHl4RGFvajZXRlkvc21hU3pv?=
 =?utf-8?B?Umt2eHVtU2tzLytJYnJFVjBwN2lhcWI3ZUtjUE11bGpBdFJZWVdVUDR1VXE5?=
 =?utf-8?B?dTRhRGlGczdSd3dmVEx6Ym1TcFFvd0FDaHNZR1FFY1M2anliZVJrUmpURHZY?=
 =?utf-8?B?VnFKL1NIbTFtWlZ5eUhoUjBjTkk2TWFyOGNKWk9ZWU1xdWdtc3pQd2tXK2p5?=
 =?utf-8?B?REZYTkgvQmdFZkJFcVJHUi9tSWxncjlOR1VWTE1aTllOWVpNamJLZ085RnhI?=
 =?utf-8?B?YnZpdzMwNGRMWXZmdWo2VUVER3Nic3ltbnprZm9aTGRmSkNWWEU2eisva3lw?=
 =?utf-8?B?RGoxVlRaMURhRXcvN2tpZmhyRnFGVXpRazBPVUtKeGNiSGZ0bWc5bkpjR2dy?=
 =?utf-8?B?YWJPN3FSN00yWDRjemZnemU0azQ2MXFQditTQ1RQWGdLZDJzZC9uV2xhcnY1?=
 =?utf-8?B?NlZtWlVNaTYwOWY3Qmp2V1ZKTGVId0VmWXVjeWFFYWMvRkYvKzNxRVJMR1M1?=
 =?utf-8?B?YkVYMVlyR2ViUDNyU0FOVkswZkdEOXlDSFVjUlp1cjRoWTI5ZWZ4eFdLZWo0?=
 =?utf-8?B?WlBRNmJaWm16ZnNab2VDb0ZvR3B2enNUN1hoNDMvTjNTS0Ztc3ZyczZJTnlm?=
 =?utf-8?B?dHV0QXJVNEVlRGNwMW16dzJNNXVsZXowUXh2UGZKUWExb01DamVUbmRDVVBp?=
 =?utf-8?B?b3NkYnJvblRlMW1SRThzenQvcVo3RC8rTjZESmtFS3NmSHg1WmZOekVJY21N?=
 =?utf-8?B?eXJKdW1VbHltVEwxdGIvamdkNEdoOU5qSFUrZE9WTkE4c3B0Z0VXOHlvbDVV?=
 =?utf-8?B?L2tuWkNHSUNTcTJvTzJPZlVwODhsSmdzOVcwNjZpV1R6TUVIYnp0ZzdMU0xP?=
 =?utf-8?B?aG1UblU3bUlwdjBsMXoyRkJPM01oZXhZYWxuOXNDV1ppU0c5RFNyYWhUT0lh?=
 =?utf-8?Q?EmcTVWDOkqx5yfcnLcYldgIJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06724c12-5c4a-4640-1949-08dc265ef3cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 15:27:24.0385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuB1Cocf91uZU/d5AgmtF1CpgkwXw8e6SPHJ0k7ESmOxMoKMUrdhz6MpbJo+Qf3Dq8Ayv3StrFnDnfiF3+HE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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

On 2024-02-05 10:18, Hamza Mahfooz wrote:
> Since we only register the amdgpu sysfs group for eDP connectors, we
> should only remove it from them. Otherwise, we run into a harmless
> WARN() on device detach for all of the device's non-eDP connectors.
> 
> Fixes: f97e4303da16 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index adda423615a1..b3a5e730be24 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6508,7 +6508,9 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>  {
>  	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>  
> -	sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> +		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
> +
>  	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>  }
>  

