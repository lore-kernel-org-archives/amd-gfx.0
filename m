Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441FFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 13:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668D010ECF7;
	Fri, 30 Sep 2022 13:29:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C439F10ECF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 13:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAmdl/w9Qe09/BTNo6oEwW5zQ4Duir4inmLFiWaJhzx9Ok3NBer4zTeazwx6tt7VpgdHtHVJlVvEuPQOrdNB1yG6VOD+p9bvYcfXjO8aSrxkDItbAGktYot72J+iEgXrk00O4+ogEIepkOyupihHQYWZqILQ0882ziMipAUErcYXYqae0wM0JajJH4Q/T3GI+tLzEJvXsKStQbf4R+rL47L6OMVPTLEPvYGRaD1PPao104H4DaOHYhG6UNguKAFDYV1GMz3KGZFcxavtaZdnLA/pjx4rzIOLhZi/MQpCkcfzTqip/YRcoNFHtPHIrNQbbem+EQCTd4MRBKeS31Kq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY96BhYagFRd1u6n1rQdDp2geGj14v9z1JCkqay1uJw=;
 b=mj/j97S7LBZMO1ebeDHXBXZ6mTYT1lvMn3olwle1Uj+xuVgxxAdrmkfzVhd95aTaLq3/RL5/fCsUFyQ8jAKE4ZV8JNzpr9vZHpku+kO6sac/7trBZ7r4YvCVFZpAQUvpCGlCYN/5B5gtJ278CKhjxgAU9uNXKmTqmM4FCLr5com5P7y17O9x8BeECCDaYmYdARm8C1mf+9q9ZCnut3gmrIBA/Oomf73UcxzYzRizQDk7OHwZ0SQUh3FmMZqedcD4GJrsJpZccpbErZs0vk3ou27Tib2JdnUMAu9UMKO7uleecqBX3rioVkdp197sVLrA9geKfwDvtkJN4y2vjO9mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY96BhYagFRd1u6n1rQdDp2geGj14v9z1JCkqay1uJw=;
 b=PaJ+AYYZeR5tHPzS4+OWF4ZBJutJMmWprztoWZQbfGSnD3QosJHdREcWM96p+XJkZ9ukMVH2aBsKVVjfYXrxZ7REYrDGh/yVm2rCsA+W8d1IOzNICVjXwMNiBOygg8Qe0M8I3lC5dtfvGQ7ocOYR0k5XXZ357cej1RAzbGD0G0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 30 Sep
 2022 13:29:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 13:29:42 +0000
Message-ID: <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
Date: Fri, 30 Sep 2022 09:29:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220930102705.43367-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 80adb157-a045-4cb0-fd9f-08daa2e7d51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Azwbp3plJTOiUqMkqjCBIkfaBPX2EyaD6ZGRGNEKxKYquYfy7doW+KzBtEWDmQnJCuaVkRnFwobr05FS860dIbKatBso6FHUGJg4UOl5tmfqRVVSTli0CXbBbu3hXuerKrkryBStxq/Uho8EYoi23mPgf2QWMnVh/SUuB07uEaRcuVW43v937ivntMT3eB0O88MfiE6ms2KEvZc3xdt8BIkUqKDRCC2N0kWF4WLnoCshrn12cN58mD9VgZWY3/ycEAkLTnohx68xut1PbeuGDRIWpb2CFMjf0k8TaZtmp76IVYMTo6WGPBmGMus2/J2wS7Wpj5o2OVUXoR4bzqysHx0ZOUi3oz7ItTF+qyg4RQMzyP2tbykD1T2OfpVoIoH6Agr4JZpKn9rhEt5QnIL2PX2Imb30nd4QXVXSSZEq/ORtsrkX5R3Od7vAzZbIR7g7CkaRbTKLMHtG768aEJZSDWP1nHdfHXkRJpmKAzQp+7IS+56CaQK97qCgOCZj5/ydYTFCdDVjOrt3jjFd6YQZqESACaUkLk0DdG97w61cOUWAZpik7TZ+V2jTy8Q8Jm4WLi1Alu/1eYtKiyl+zs3d5kdCXONzIa2JE3RFFb10JGtZoppxx+XPzxTGJi8viOXLAdW8+HrBuebA21tZkpl2QV4jYC6O1sfe2ToJBNf5uHtn+fj/X+RWvO/pNAFlG6/4FRKR4+ms8u+TrmU05JVhyjyAGvB7e3rBLjKQnTn3mazVcHhUyzI8OVyNHDUnMwtxpdblMhWJjk+zcR1YMFn60yNJbruoQG6JIGSE1p9ma8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(478600001)(41300700001)(6506007)(6666004)(6486002)(53546011)(186003)(6512007)(5660300002)(26005)(66476007)(83380400001)(2906002)(8936002)(8676002)(6636002)(66556008)(66946007)(316002)(110136005)(2616005)(31696002)(38100700002)(4326008)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNMSEc2Ly9vYmt4Ync5QWhwMGV1VGlrWm1yelI3TFE4eExzOENRcHhZWVl2?=
 =?utf-8?B?TUxoUHJXQjh2TkZmS1k5UVlLcUZZbXUvNWRuelM2K25YVFBpWU1vNjZTb2o4?=
 =?utf-8?B?OEhlMmZjdUt6YXh2Z0FqWElKVDN3V0ljZXlaT3piT3UzMEYwcmtKMTNJSGxh?=
 =?utf-8?B?OGJTS1pHNTFyUG10eWdNeVViVkRXNEdLczFkMS9qUU52bmpXeGNjUGh2YWlC?=
 =?utf-8?B?NDhOTjhxTFAyUXMwWEFnOWxmR2o1RlZGR3VKYmU3VnpjQURnTk9oeStCbnd2?=
 =?utf-8?B?WDY0UzJodEpYajYrNWVaek84bEVRKzd1M2V1YU5yMkRnaHpVN3k3V240ck5D?=
 =?utf-8?B?d0FQQVE1TTA1akcyN3loK0lhY2ZMNWRnTjJ0ZVcxQ1RmUHFSbHZFRzI0aGpo?=
 =?utf-8?B?b05UNVUzMGtsWW0zU1ZEaWlyN256Um1MUVZXWnlvdzExRkpsUTBCMDUwQ2hG?=
 =?utf-8?B?Rm5yUTJIZm5aRHU5Ujd1QWlVTFpLQmYzNW5TZVJ4ajkyK0V3bjBuWGJjVDE3?=
 =?utf-8?B?eURZNjVadmtReFNYWEVpYnJpamQ3Q0F2VG92c2ZUMHVkcFliVDF1Unkzd0Vt?=
 =?utf-8?B?SFMxSEFLa3VFS3dHa2ttUXloVkkxcnNrcVViczRYTmVoWDVIVm9ldlNNRzli?=
 =?utf-8?B?a1hBRFFVUlFlRjJubWhqczZEeG1wMmwvcG1DTWk3OG10bGR1MlgxSUJkR0Rx?=
 =?utf-8?B?YWZhblVQNHVqZC9QWmVGbitNRGZDVFNXRjN2NEhLbUNmUElkRTROcUtZSHZv?=
 =?utf-8?B?c1lEUXhYUkl2aFI5WlAvczd6bGd2bkdtdkJmcTNhbDgvOWpFTEZIa2dIRlkz?=
 =?utf-8?B?UWpldDA2RkVmVFJhN0l2N0lxaW9VczRFYlhGYitDbU5hWENzdEdPdnlPeCt2?=
 =?utf-8?B?SWNpN2RaeGhuNXZwZ0NPbkZlN3lhNUVvdXJ6VGZ5THdjM1IyQi84cHFPRGxa?=
 =?utf-8?B?cmg2N1BoVkk3MWhhMzY4cExvUGJLMkdBSHRlN2YxWDVyRk0zNjkxenZLMmV6?=
 =?utf-8?B?TGZUR0E0U0RUWmNtVEtJVk5QTC8veGdNV0xXcVhYNUswUXo5MlRYZ3RPaDY1?=
 =?utf-8?B?MW9ZL0MxRlhmOGlPdngyRTdmbDJmWXY4bCtERkt1VnJyREE4ZlpERllaNExG?=
 =?utf-8?B?c2Zzc3Q4VmNyQWxNZkczYzZUcnI1TnNTS3F6TnU4Q0xLYzhjMmRKT0JlVWFr?=
 =?utf-8?B?SGhEVmRKcWx4WTdMWlJqNjZSc0xJT1RxZlFmanVaRzd3L3F5cW92S1RGN2Nr?=
 =?utf-8?B?ZGZnY3o5OVgwSFRwajNTbkdUaVRNYmZ2MWhKRnpPN1I2M00wQzVHWk9FVzZm?=
 =?utf-8?B?czRkei9rQktlY0hYcEZ6RHNrdzE4S29PbWdUTzU1anVBNHVsQjkrSlVmR1dn?=
 =?utf-8?B?N0xWZUtnV2d3Zm94bDh2UWoxb0lqUnc2N056UXpaWlNCTUg5amhNVDBGTWI0?=
 =?utf-8?B?VHQxeGhOQVoxRm14Nml3VmNBcFI1cExraXBydnY2V2pmeThDWXpuZFNJbU52?=
 =?utf-8?B?RnVtVWFSdENUZGY5akNZT2llU0lDc3U5K0UvOExoZUh1TkxPc0x4ZG5UUE9H?=
 =?utf-8?B?NjV6OHJPMkZXL3oxc1dHUVJKYWdpWUJMZm5IWFNSWG5mdXpNc2RMMXhnSWt4?=
 =?utf-8?B?SWFlMUw1TUVKVms0aEtPTFJ5WVVBampVQkRVUW1mZTN1aGQ0VHQyWTlGd3oz?=
 =?utf-8?B?VUlwWGJCSzJVYXZZNG1WZDhiUFRsZS9sc1FIR1hUTVI5YVVwZHliZVhFVmpM?=
 =?utf-8?B?eXJ2ZGZOZllCZVBUUkh6U1JyU0w5MEJUYUl2L3VpbGRLaFcvelhoRTg3b2pU?=
 =?utf-8?B?d3laUFlRaWJtNGUyZi80R05nTkJYS1E2aFM4VURyMTlMM1h0bFNVWHA0czBY?=
 =?utf-8?B?a1h1L1Y1V1hNek15bFdaUFdtaEt2R0EzaXptQjFnY3JTaW80K0RYL0dOeTlZ?=
 =?utf-8?B?Vy9jaDgya21FUjRLSlpJVkp4eWtCQ1JRMFFaek1CK3JlTXJjM1lOamNJTWox?=
 =?utf-8?B?LzJ6dndSR1NmQTNEWmlMdWFVbkRNcStISXBWT3VHYnc4SzdVM3czd0J2eUts?=
 =?utf-8?B?Sms2VzhlcmNKTHEzRXhMWjdjTkVNeGRYdFhVSmdadVRGU090R1FOY21jYWh1?=
 =?utf-8?Q?/bSvwOx0lBaoOGp6/ouvm0Zys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80adb157-a045-4cb0-fd9f-08daa2e7d51b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 13:29:42.4903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9l0mp33j7l/+qroAzFG4Resu3sHL6Hgy8pURTJ/9Z/9wcqbLFd3GOOfjeUCWOuSInDd7dSuZ4dJb5mVIRZdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Leo

On 9/30/22 06:27, Shirish S wrote:
> [Why]
> psr feature continues to be enabled for non capable links.
> 

Do you have more info on what issues you're seeing with this? 

> [How]
> disable the feature on links that are not capable of the same.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 8ca10ab3dfc1..f73af028f312 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
>   */
>  void amdgpu_dm_set_psr_caps(struct dc_link *link)
>  {
> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
> +		DRM_ERROR("Disabling PSR as connector is not eDP\n")

I don't think we should log an error here.

> +		link->psr_settings.psr_feature_enabled = false;
>  		return;
> +	}
>  
> -	if (link->type == dc_connection_none)
> +	if (link->type == dc_connection_none) {
> +		DRM_ERROR("Disabling PSR as eDP connection type is invalid\n")

Same here, this doesn't warrant an error log.

Harry

> +		link->psr_settings.psr_feature_enabled = false;
>  		return;
> +	}
>  
>  	if (link->dpcd_caps.psr_info.psr_version == 0) {
>  		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
