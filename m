Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF2DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 21:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A0610ED5D;
	Thu, 23 Jun 2022 21:36:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B7610ED5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 21:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAi6IU3m1JfTsHUeAzbW+Kx0S+zd3On8h/uwcqjEkXNuh0iP7tXYskyrLwp2sUeqldTuQ6xu4jzUoka2KTF00gvm5j32S/7j8LdwTVOSuxB4DuKWFL6XkPJu7tTpT9aUqcV5fpYASfGGTDivkoafSJTrmjmYA7YyXK/erMwIZNYaprEu5V/gmu+cqZayyVk5EIFASiwXMxEZIkmhUIvcCjVz/gjL2x6hgfku6onz1vhdXdraNGOKEdeQaRoIdlT+JmE4DqjPGcypLQ0gM0qukKEUq7tF7l27R4X9Zi+q2P7Nw9H4cJhLB1QJRgx+BUpEV5x2aC2VoJm97q7XWwrW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OFKFZU1OelaMTrNCRByokftqeAS+0wHEzrzbDpjUu4=;
 b=AbyHg2ueoO3deDNVl+Zi2/syz7P8EGf72TNQvtfZ8tg8DaEFFqxkA9kHeliHz+b2nIou14lx72h5zBM2Vx3pOuWFluRm9s9X/wqPsMbqhaBrsn7qrKMy97MyOaWphb+6E57zKb/rxOndlBcrEhDAO6UPX7Lx/vMTG7vz9uOkQrPuzPSp9vQj7g8HBGHF5/tTFVSUJlSi/SlIZfLL5sqKT7r3ZFMTSaeHfd3EgL+p97JADvZmY/mJX7HIhDHWTgprPhZZkhXYhRhPNqLVsZJP0ORuq2ffAz4NOKW/Ajxei0ueWWXiFhv01NhTOK25JerjIVinPXY6aQOiNna7frl05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OFKFZU1OelaMTrNCRByokftqeAS+0wHEzrzbDpjUu4=;
 b=FdJd0qyXfrCfdPATjSQNeJX9EoZ4VMnrQpGEj7OR0ZJMwbNFArrdPwoBSXOs1yZsBu7944aE/kWYMCmdAmwr8OTt60Gw/RdGIdpWchMWI43lVxB7hHy0UJpVVTY0XdknAtoZXaq+Gw1Vxc45BabXCuGaYoujqhVCAAAQReBog+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 21:36:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 21:36:10 +0000
Message-ID: <b8f6395a-0f24-6fc3-020f-b753b7daf4f4@amd.com>
Date: Thu, 23 Jun 2022 17:36:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] drm/amdgpu/display: drop set but unused variable
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220623164113.1503249-1-alexander.deucher@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220623164113.1503249-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13be0fb-1c77-496b-a3ed-08da5560637a
X-MS-TrafficTypeDiagnostic: MN0PR12MB6054:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcpDEmfh5NXai9N30VGOgzEihq2hs7/9TVz8k1IFu9HrVGX1woNt0JzL7Ym3sDPihYaEnpRc6AR1H2vRyTVhvFApu8kZxVBgPaK0Qp2wU9FQo2Y/W6KDUmOR9MunvPSgrC9QnFE1K+tdmYHcN/DE9Syn3ttrCx1THMkA3aqtG3/AP4blaKGADGSjgK2Vf/7WU/h4NiSjPWP5100GMV4McP5Ak9O+D1EZ6jmI1Gi2/SAyk2ePN2xzhY/mI8mmV3/5f7Aw776ovHc33Trt+dVCvc/VrovVPgHkl8MclCxO5kYhYFU9qe2vvnHBhCzbshC/JU2nGtwXRAREPWfjGaooRTYnZPxNfDAm1fNSUpsh4nVE84ejJqOPVcmbvYvxOhAdPy8K8tuHNL6QzNcjrIfSSXV0IB2oWKsJh8lA5qsdjVNpHKHXXfIW57CYnTBugoTUfVZsj1+pMypM3ovYyuaE/P78DjKKI82G5Z11Jy47CCtsB2JoJqLAJbdddOjXNzjukkP3t/RnIpx0KhKQZlxxq/j2j1CHvfiead0evYusEX9KPN22NO8gvvSqf3siGDQLbcYdCmFe7EiAQ5mlUS1BdtV/qrYcuDVn+U9HnvzWAhyBvSBWcU2gQyXfbpbOnJlMNxpYEMh+2dyPSZ0qcDUBJc9iegLsW6D9ynLnUUoRtUfAfC5bThGQDWG8K5+BHQ/g3TyrZNWiif79EyYFC4gUNX3am6EoJXy5+QH1S7cbsmrBkRTQW00tUF+mbQjdO2z+sAIjnMNo+Y8OkM4vXpEQBxIUKKj43LItOXItNz6HlPePLdoH7+DgXsf9gACoX5RN6I5XimCpZ1qdq4mfdGeBAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(66946007)(66556008)(8676002)(4326008)(66476007)(316002)(2906002)(41300700001)(36756003)(83380400001)(38100700002)(31686004)(53546011)(186003)(6486002)(6506007)(6666004)(478600001)(5660300002)(6512007)(8936002)(31696002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01QRVBPc0FYWHRGL3lmcVAxMnhaTkV1Tkttc2pTNXRZV3ppN1NIVVZZWUVN?=
 =?utf-8?B?K09oYVdnRFY0ci94NlJPMHRVRkZ4dVlhcEV3MkdZWDlvcm9XMVVZbER2YnVy?=
 =?utf-8?B?a0VmcnMrKzhhbjl2MGNRQ09QQnhhTVZ0dDVyaEMyWHRuend5N1dhNGpqNDRU?=
 =?utf-8?B?L0ppTWljajZQbkJMbHEwOXRmTzBsQlFESGwrWXhaak9aMXAvM1ZyZ1dBM3JM?=
 =?utf-8?B?di95ZkR3bEUrSC9UWkVQSUIzanZSREZBZlpTWVNLM0d4RlVBTFBjMjRDcGxz?=
 =?utf-8?B?aUMzdzcyTGxWU3B5S1o1SHJwbWYwOEt4WGNXSGl1MW5ZcEpLaG4veFdNcFVQ?=
 =?utf-8?B?SVozNEpRSytVTGgyVjd3QkhwWnVzaUtqTHRHSjNVNVRiSStCc2ExZWpZRFlP?=
 =?utf-8?B?NGhlZHc0MUpWU2pZUGVEZ1FoUjJCK1lIMDR4VEZTUThXQWFnTUdWV1NqaGpR?=
 =?utf-8?B?ejlJQmFRTEpOSmQ3eXNXVTg4Mkt6WW9CWUhpNzQ4eGJHOGw0NjV0bUNRNWFD?=
 =?utf-8?B?dzY0dkFwd25leEVVM0dwS2FkclFpMmRzNno4c3FORlNhZDZCdjNVUTdBWkFT?=
 =?utf-8?B?RytadWFpNjc2MHFIMy9PdTYySTRXRmw4T0lKQm0yV1F1cmFXWEIxLzNCd0NN?=
 =?utf-8?B?TkgxNlhsYUlIL3RmeTVjWmhmZjJTbzJSWmdVRFNhUU9JeFhuMWptZDV6czVG?=
 =?utf-8?B?Y1ErOVFqTFNjU1YwaVFoTTlQempTT1JITFJHYzdGNDVZWFd3Ymt4R3RJZVhx?=
 =?utf-8?B?ZnJrZ2JXeXdVZmhzZzBCNkVTWnpsSUJuYTJxeE9QYkt0ZVhGSmVRZk5CWGl1?=
 =?utf-8?B?YXRubFlDVFNkbGFxSnUxQ2s3Vk80TW5RUEdLV3h1MGlsdXdiZHFkbkxUUXpn?=
 =?utf-8?B?K0EwanQ5QS8yTHdiVThlV0tWbVk5YmtMVUoyTEpnYUczQ1VlV2dIREc0UHND?=
 =?utf-8?B?eHN6OS9taWJyNWRBZEdrL2dDK29SVk5ZSGsxODZTWFExclVwRGh2dS9tMFVR?=
 =?utf-8?B?WFVDMWlFenA1aXE1aS9nd0lLdFhYcmhDS3ZiUkI0QU8vOWNGcjdoSDlXVlZq?=
 =?utf-8?B?UUI1NVJsN1RzZENpMVJ1YjJLQWxCTkRxbzRGaWFabDV5bUFlTk1uZnplUTdh?=
 =?utf-8?B?dlIwelBUTmtzTlZrZGlxbWRwMzZaV2dqQ0RKM3ZqaFdxOU9jYS9NZVU3ZENm?=
 =?utf-8?B?TTJkdzd2TFBCTEw3dWdoMU5yeGkrVE9nSUpqRzJoblZJOWEySVo4T2lOTDRR?=
 =?utf-8?B?eFk5S3dyUS9xdU8rNWNXaVY1eUcrcGV5dVNybm4za2o2QTdOMGFoQ2JEazZI?=
 =?utf-8?B?aThja29Eb096d2RFSFRDVGttR2pvbHFOSjNzQzB3VHkzSjc1YXQ2cm00bU82?=
 =?utf-8?B?V1p5NTBmR1hJaXdtTmpsTkJYVnpwNGpmNFFPeEtoeTBMejJqN2xJZXZvd1Ev?=
 =?utf-8?B?bjVuNXc5SmNXN1NHQzZNUFB3VFRaZlZYbkdLNjNCcTYzUE50NXZwWDhpY1li?=
 =?utf-8?B?R3JDRUVKN3l0UjVNMkNpVSt1aldqbXIvamxha1NjKzZyS2lzNXMxQjduMVBR?=
 =?utf-8?B?N0xNbUNkQS9Qd21aajlidzJRbS94cUZJUnpzd3BiL1ZVejM2VGVBTzJQbTVN?=
 =?utf-8?B?V1BtbE0yVDN1MkNzeUY5MW1DVWRlNTFQUTVFZ0FLMkk3OGlXSHdxY3dnZmla?=
 =?utf-8?B?TVh1cnBzVDU1SmZuMkhxRXVHY0l4TDJsbDh1VTRJTEpjMTBiS2VXdklPWjBC?=
 =?utf-8?B?MXFpV29ZVGR2RzhQY0NFSnA4VkQrSXE3QzlGN0M5MXV3WVRhYWI2bUJXblVB?=
 =?utf-8?B?dWdIVmdTUDk0RUQzVVRQMC8yRzEzRTRhUmFlbjNDRXA1STZBMzJwNlVTWmE4?=
 =?utf-8?B?RmQ2Q3EweVZFS0d2c094dnF6R0NvQmI1T05MZnZXL09KOWVDYmRNakZvS2ht?=
 =?utf-8?B?MWo1UWEvYWVURUx5YnRtY0NGdHQ0NE5wYmlOWmxNN1c5bFdBWGRtS3g1TjVo?=
 =?utf-8?B?eElXNlZYRnZzN1EyTmNQcklJSzlSeGlvTjlmMWhWTkJldDczYUFXSDFxdnow?=
 =?utf-8?B?VGYxYWFiblZWdmdScFdsaE15dEZVMWJVbkpwVmpSWkFqNXVKWk5qOGJWMjNS?=
 =?utf-8?B?TmV1bXhXVVFXUlovVk9XcTB3L0dpbENodmIxbUU3V3NLSmNHY21hNmRBMTU1?=
 =?utf-8?Q?gYGyoyuhYsiOyJutZC16x7vjvAbyJ/nXIfcMZOSVRDxf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13be0fb-1c77-496b-a3ed-08da5560637a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 21:36:10.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSOUHSqF5/p5ViZhYXShoKYNHLoxV67R9GdAeq2LiDtw6D4v+SACXP5OY4CiFUBH8gdRjKY61DZQFrwpKkHVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/23/22 12:41, Alex Deucher wrote:
> No longer used so drop it.
> 
> Fixes: ec457f837890 ("drm/amd/display: Drop unnecessary detect link code")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 1206a3dd746f..86a553757d14 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1022,7 +1022,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  	struct dc_sink *prev_sink = NULL;
>  	struct dpcd_caps prev_dpcd_caps;
>  	enum dc_connection_type new_connection_type = dc_connection_none;
> -	enum dc_connection_type pre_connection_type = dc_connection_none;
>  	const uint32_t post_oui_delay = 30; // 30ms
>  
>  	DC_LOGGER_INIT(link->ctx->logger);
> @@ -1059,7 +1058,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  
>  	link_disconnect_sink(link);
>  	if (new_connection_type != dc_connection_none) {
> -		pre_connection_type = link->type;
>  		link->type = new_connection_type;
>  		link->link_state_valid = false;
>  
