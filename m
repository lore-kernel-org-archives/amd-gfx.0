Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11292C77B76
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 15:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C0A10E2B1;
	Mon, 17 Apr 2023 15:23:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269A310E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 15:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtkfe8hB7mBhyhROabArUueW1Weao/fktHKzdyUP3qnMNuxLz638Cb5FKdGtJwL193b6w1Tom7YCICOywNvjr7P+KdFmRn2qs/Jy2cv/Hv5T4lILNatrNZWYJum4iNoZ3JMtR6feRysC1ewRRy70DrpFc5fSaI9J/wepyPEckLyDnKpllPhV72kZhfg4ekHkHYuVDulANXGpwOxgPRdla3PnxwkjnLH/Z9MChrmJ+TyMDYXtdB/7GEbkfy/j1lbr/FRuf65EIELy3kaWojRLRCM7y2qKAmFxZB0/IeXGxsfOnnR1a9Q+kkQRzxSOKo51HgD5M5DqNyNCs8PSXFoUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De90eAhjiP0MhU7SvjSXk2mjahN0hdVkCycbYEXgLcw=;
 b=O7QrLX1XJbxMwV6n7RJmJcMN/+rEHfvQKlEWyYwpjR1GluKLMsDg5bYjQuMeXoln38JPmvD/0Fc4nCDXP/vEL5B2EBFADEy2QqLtJjtP7J1PfNd/gxBadErJ/kJS0P4BDtSln+557P5meZ8T2cRiTxX+NYVu8pqM1ht44VP6m85p6Db4dnmqzY3WFW9oGvto0lu736dHQlbSTBveTqgInocnmnjrygok8MAjlwvFcjmaSBz+awL7ZHGWfH6xibiTpxcM5+gvVHYSeM6rtVNDR/YeUGJ6LckNsLY2DaBBwNU4cE8o4lVXSfYfao8t2yYJUiCJ2BM2iAukgRn2TRftzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De90eAhjiP0MhU7SvjSXk2mjahN0hdVkCycbYEXgLcw=;
 b=krU/TKaiqF/Fb2ldxg8Sz2MB5LHsbFLLu8+sImvMCh8J5ih0yJRLw94RvuAfJaoULiSkLviBHCN67TSWNLj5HjnDBHp+GXMcf20Zytz2EldSaJokM508f6o8r2NAyVToP6srpfEYW+QNWdd0dR32bjODRVew+xLRG+Sfa1DV6MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:23:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 15:23:46 +0000
Message-ID: <610f9fe1-3ae8-6356-a397-d5c04a9038ee@amd.com>
Date: Mon, 17 Apr 2023 11:23:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] drm/amd/display: Check & log if receiver supports MST, 
 DSC & FEC.
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230415182706.3341057-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230415182706.3341057-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d3e461-3e0c-4adc-9cdb-08db3f57bc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDaHLk9HryOEmCM/nbOXIC+8kjzGNe/5UFgBTWEUwZmciy6jzd2vhoQUPxtcIiQJgW6MVbsg/eszTQ52r+1Bfb3Eh1o6R5iMRMA5XoHYD+iX0kV6iBf9vJXEmDOWt13EYMw7wYLhn4Ny6GsgCpEPaRNCfpjMa3GHb+eyRdXyKM/km+3LPecp+VISF7jqHS6qobUYJVYnC0vWKbjxnYUOCMD/k8Gh3shzPsGzBosXzf1VmzfAJ0PVScdti7cZDwz4TkIfbHNmcWMttQq8kV2kwB6PGB9+fJBMJhfKnALJ8wgeDvDIYNeRQ3pR6hHwdOFRbCAQNa+1BMhYSq2ayNaVAmpk1DlZngiAXZu9nArBfrNybPHsNkEYf5ck1EwfgLrMo5MTtgNN84sLkZj+BqkH1OgCAm1G2ucVIZJ52Jd79ZrZsyHjGUiAxr1uZg6OJCpUpXcqy8IIO23oc4dsmA+rM3pfVePuScUheBFRw5T0hK8Y0JRlf7BKKPAWhUGACSn5EMSMwzPSfVz+Is33ObUyDygsdrsAbRuyG68OnZ3/Yi+CmL9cmh32Uap4cjYBwLrz52VJmTtbi0o88MMc0gnp+RNFE2xtikkQq2XVChD5wPqu20i1k6VQ+Uk0Bo9byWb7Ro+/NTDbihwDa2xVfX8yMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(31696002)(38100700002)(2906002)(478600001)(6486002)(2616005)(26005)(53546011)(6506007)(6512007)(31686004)(186003)(86362001)(36756003)(41300700001)(44832011)(316002)(5660300002)(8676002)(8936002)(110136005)(6636002)(4326008)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9DblJ6eVAva3VsNUNqa0RyUkJzOFlmd3Ivc1Q2M0tsY3hHVjY5cXI1cm5y?=
 =?utf-8?B?aDdyZkFGV0lrYWVIcUp5RlhwdmdGUTYydHF1YmFoRmdHRWtvWkQydkhTaUlC?=
 =?utf-8?B?RXVUWjVWODFld05BZ2M5a1JYOVJ2RkRCK2M1OWd1a0txaFBJZDFYeFpPZmZa?=
 =?utf-8?B?dGxhbTNxZ0pxRjdycUE0bTRSV0o3OWEvek9mK3NWaG5EUzBtSFZ2UlgzektO?=
 =?utf-8?B?SlZKY1hGTzVteVdYTEpWK29VM0Y3Vkh4eXlYVnI5bTZLOXRSUStNL1dGdVhX?=
 =?utf-8?B?Qi9LZW00cjlXTmhXam92ckRBNmEzNkJZRythYW9NKzRFWitFczZvSkZkd0sx?=
 =?utf-8?B?RHUrbGFpWWVQa3VTUmR6SFVnbGpvSVpWcE5BaFE1dnduUVlRZFdPKzlFTThH?=
 =?utf-8?B?TWpCV092RWw2ZXBIakRzaEpNRWpHUlNMNmNIUjhJRElPZ3U4amhoVHlsdnpl?=
 =?utf-8?B?R2M3NXErRTAwTnRtYVU5eXVzWG1TWkNLclNSK1dzQmk1VVNuUElFMmE0NVpT?=
 =?utf-8?B?TDNHODNOaHFUV1I0S01tMDNhNEc2cVpnbHkraW9CVzY5L2NQUUhKbjdUSTA2?=
 =?utf-8?B?S0FiRnpSQkFaR1hNMkttWks3c3pQQ09xZ0x1QVpSRXFBbC9JL2tFeFVzWlgy?=
 =?utf-8?B?YlA0MWczWnpVTHIrVFVCanpMQ1k5bHNINnVKWTBhV1YzaGZZRk5UeVdIRmph?=
 =?utf-8?B?SzRLY1hSNnN3UWQwc1lzcXRuM3BGbHVzUTBIWk9rYTg3K21TRjUyQmx5c0kz?=
 =?utf-8?B?bThzVVF0UWU5WUhEMHdRaWFOK2UvNmplRTJWUTEybU5jWlBjVDViM0Y5MGZa?=
 =?utf-8?B?M3JuanA1MitLTjNCa09DYmI4b2x5VUpHL2s2YlBPNnEycUN3TDd0YmM2d2tx?=
 =?utf-8?B?dVE0RFc0N1lRb2pPREpqaDRJUGxjNi94YTFNK2pQSkJhUTl0ellJYnFDbzdP?=
 =?utf-8?B?QWswWnduMVNLM0x1Sk4xY1dsWGtGb2piNFR1WGUxdk84SzBRano4ak9CNmpO?=
 =?utf-8?B?aGFLOFdlUnNwZWM5anRNTHE3eXRyc2RkditvZ200NGJ5dzlnZ2NUL3piQ2Ex?=
 =?utf-8?B?UGM4Y01GL1VVRyszWVVXWGE2Y1dNZFBxbTQrUkNlYjFDQ1RoMk13eG1NOFNU?=
 =?utf-8?B?S3FtMFpkTXRKcFpKcDEvYm5tQVpOSVZ1bUtpZmVxbWJGdm9yb2NCQ2xFM1dM?=
 =?utf-8?B?L0hobUlWcFIycE9UT0wwazhwZFVOQVNSZ2hDVDhRUGJObm0xTjNNUitSSGp4?=
 =?utf-8?B?b3JCZkdoOXcxMy92UmU0bEpJaTBlNFQ1NHVxNG1sbjlQUlRVejF4UHRmRkRG?=
 =?utf-8?B?RGJSeTZxZ25xeC9jQmo3US9hZjgrQlhaQkRhRzRJdDN2S2N1eHJ1MnFXTHJw?=
 =?utf-8?B?VTFrWmdSK1JHbVVPSFpPUjRmczJYQkg4Z2pCTDNWbHZLNCtuaHZTaUF0RExP?=
 =?utf-8?B?VUZuT0RSQW5NcUR4WjcveWFuSEtnNk1DOHB1UjI4aEs3Nm04SXJqSjY4K2pF?=
 =?utf-8?B?UnlpdEJHT0p0bzB4UHdqMThEL3YvV2JqNHdiNTFlRHpBNHRZeHJUbW8vVllR?=
 =?utf-8?B?aTF1UTNJTm03WndLVUkrMHp1WDN3YWxkaU1HTXN4WFU2dGFsK0RFdU04dTJz?=
 =?utf-8?B?a0dhUGQ1OW1lRU9jVExXYlk4K05NZnlyZDhtdEc1MFpTZWE4cjBQUU9ZekRs?=
 =?utf-8?B?a2tDMUR3aWJWTCtYd3RYMUNwZ1I4N1JUbXlZcTRpMkRFQUtSUDZ0LzhVOS9s?=
 =?utf-8?B?UW1jVFRYK2QwL0gxWkxIY0twdUZaOVFrSTN3VnFELzl5V3h3ZkIraUdrUEhY?=
 =?utf-8?B?YVV0K0k5VFZ0Y256UjhXM2NIN1JZM0dMUHRYZ3dKalhIdkgwdjg5dklZUjdI?=
 =?utf-8?B?TEdySU5tVUt2WXRRWk9oWEp0bzBxclB6M3RkcTBiTEc0SmVUS2hiNkJpRnFX?=
 =?utf-8?B?cFlVdUx2MVBKMStraE1HRWJWRitjV0pxcUU5YnNkTjRpeGluZ3RCMG9ya3VQ?=
 =?utf-8?B?bWFIMC9XTWNwSkpueG95RHlGZlFZTUo3Sm1iQkl2ZUZlTUVkMEUydkpjdmFE?=
 =?utf-8?B?d3FuNEhKVzZoQndWRE4wN205eTBIalJkQnFwS3RDVTM5eS9xOURJN1lQSzEv?=
 =?utf-8?Q?4uncpbBIVwUcR6v82hCNyA2sY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3e461-3e0c-4adc-9cdb-08db3f57bc8b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:23:46.3193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4JSz1MJnWtfPz2whoX9SnOCHEEdORFVSvlh6F2l2Nc4gAQqicNIxMTsV4DVm36aK7WiauQ8CVKxSiCwkqjaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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



On 4/15/23 14:27, Srinivasan Shanmugam wrote:
> After reading from receiver via DPCD, check & log if it supports MST,
> DSC & FEC
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
> 
>   - Added %s: to print the function name.
> 
>   .../amd/display/dc/link/protocols/link_dp_capability.c   | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index ba98013fecd0..f93fc35a1a50 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1554,6 +1554,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>   	int i;
>   	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
>   	const uint32_t post_oui_delay = 30; // 30ms
> +	bool is_fec_supported = false;
> +	bool is_dsc_supported = false;
>   
>   	memset(dpcd_data, '\0', sizeof(dpcd_data));
>   	memset(&down_strm_port_count,
> @@ -1696,6 +1698,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>   
>   	/* TODO - decouple raw mst capability from policy decision */
>   	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
> +	DC_LOG_DC("%s: MST_Support: %s\n", __func__, str_yes_no(link->dpcd_caps.is_mst_capable));
>   
>   	get_active_converter_info(ds_port.byte, link);
>   
> @@ -1803,6 +1806,12 @@ static bool retrieve_link_cap(struct dc_link *link)
>   				DP_DSC_SUPPORT,
>   				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
>   				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
> +		if (status == DC_OK) {
> +			is_fec_supported = link->dpcd_caps.fec_cap.raw & 0x1;
> +			is_dsc_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.raw[0] & 0x1;

Can we use the defined struct instead of the bitwise logic here, like 
fec_cap.bits.FEC_CAPABLE? Makes it more readable.

For DSC, it would be useful to print both basic DSC and passthrough 
capability.

> +			DC_LOG_DC("%s: FEC_Sink_Support: %s\n", __func__, str_yes_no(is_fec_supported));
> +			DC_LOG_DC("%s: DSC_Sink_Support: %s\n", __func__, str_yes_no(is_dsc_supported));
> +		}
>   		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
>   			status = core_link_read_dpcd(
>   					link,
