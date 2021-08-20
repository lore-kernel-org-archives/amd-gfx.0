Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F45CC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB74610FF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FB74610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89916EA9C;
	Fri, 20 Aug 2021 14:14:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB6E6EA9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 14:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMXgvHhH4rSk3YUj8uQUYR4I9+vcg7fXOKH+svVVqpCKPzpw+qgwWa5WuW10BDHQZRCgwjKNL2G+GAAsz0dB8EiYiIXEBq4gSOiGhLRQbZy7TiNzFtsRAICScM0ZNQo4ve2RE+eLxoVru+D3NVzbQu/kJTqc/KK2kItbDB7bgcu6HYE3ygE99JuZ3RvOQkqK7rDiTS3omdL/y5w3D3St8bgRDNsXXninwqCjexEq2g1iBjWnbmcKqb7HY3xBr/tl1mcwbf/Ur8HU8J6RF2DlZwuQJUCWkz8kDPW8R7LsGI1H/HbY2gBaklmEkWizx0gs0OmYYyr7PwKQ9E4he5Lj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOk58DtcqCfJiziEcGVdhRqH7eb9D4514iQmzic0W+8=;
 b=DN9g+xePo/v5FQghq71zzd8cQYcg56VPb6VyaImCnE7iTf++K8RJI2fUQ5ACAuTcYPMinAxlEUVVXBKxcUsWYomfa864OQt0ZfPEN82H1IAkFNm6nOU9hIHnA2oOd9CL4ThXksbmAuwrx02LPYSSGTQgRfxyJmmLkGc6DL6qug031fUPb6ud3eEYOQiX5ekE5PZZFT7vxA2OEtWsZ6YRN229a1DwKtPeMm1XBtxmNihTBfxcqDypVf5e4HxS9LiNfsnTYmWVTLFBDRcG5giyhm926D4GVQZ9qCdeCRolGAMcWF6lvBmkIgcb9cMLCO21GPDCfzSU11n/vny1LEHuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOk58DtcqCfJiziEcGVdhRqH7eb9D4514iQmzic0W+8=;
 b=wJlKOM+Dz9OqluVGGtLFiW3h1JmIULg3qzj5E4JscqPooVpn43T1tYwFbzKLPTlHkrzRW+UIuKTDDxKcZ7ss8Bz29/yfnS7GFN/nxj6wFLHNMMTrGgszToYJpPyG2PeumW64LaxnQ7ox1CdQLPt7kWOVh9M4WTBvcm5ZlPJiaoY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 14:14:33 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::812c:c10a:1b16:6e71]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::812c:c10a:1b16:6e71%4]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 14:14:33 +0000
Subject: Re: [PATCH v3 5/6] drm/amd/display: Add DP 2.0 BIOS and DMUB Support
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
Cc: wayne.lin@amd.com
References: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
 <20210819185840.3682559-6-Jerry.Zuo@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <795aee32-0a3a-8940-4d63-b685c21049a5@amd.com>
Date: Fri, 20 Aug 2021 10:14:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210819185840.3682559-6-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.161] (165.204.54.211) by
 YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 14:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f58e43a-66a6-43eb-ef01-08d963e4d571
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54291513F0A14D98D2A51259ECC19@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5x6ZkqSHSh8+SucbHRXTVOdMYeaYJSXTCU4o+LJV/4GP2hLhsU6tKR9KapZAqn4C7UP4PmNrsQHytniKSlnou5sRJBxeIC3P5w7+NcI/bmx0qsoy2GDK/7jbkJUnz10C3/6LUOaVQjnV7h9xtLg+cX0taMoDPj6E70z3UW/Nbxv4HJuToilorQtgCV7bDEYJYx8ljfbjpAWIgXSmOG2HtN5TN/j2YH5qfPeWtttzK5nUJ6Wlanwq07PQ3f2nSVd6oxviwsy79Tf4vrZlVBBf62KBWFVUBn/OUa5QGXSyE6vGz5iph9LBfmeV/j6XvjJ2+pjszxPq+dErz0mGZrGN9vZJEx6AZXWrJompXy++FD8zZOTWaDTKJFiFFoLixz2TTh1klZ5VdQ2qI8z7EvKNnEJveiIk4pEXmQ4zlODC2jOhBBTPcmBXdqSp7sCm63xzohkTUZKFBu4A2DGWIMw8uJ0r1pWsahHT/1dw149YNW95efjTMxjtptIxiEY2ldU9zWhp6NHHMrud7OwmpKt84omq/Xj1ih7beJX3o9DF8u/fDLL6Gp44qHl/B3tRHuWbxOYrkb+IZQcaosBfo7xNBVNaItRTE9Hn3b7dW9use5XtXmt3LG0fUwZBx4cLG0s0yygOVPNfmtaFVykF8G8ZlMv/bPvyM5bObZqmoQQPEwW1+zZdP8v0hY1ldLq/LoMOeVnjH5ZgBQKVvavVU+dsFAhgNo3azaQezt9fc9/VeTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(2616005)(478600001)(53546011)(31696002)(31686004)(38100700002)(956004)(316002)(6636002)(66946007)(5660300002)(6486002)(36756003)(2906002)(83380400001)(4326008)(66556008)(66476007)(26005)(16576012)(86362001)(8676002)(186003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJtTFFwejlBSm00ekVUVlhnTTBlejJaQm1xN2tqeng5bHNmUlNaT3orTlFh?=
 =?utf-8?B?anFvWTNSSlU3M0NqUVpwK1hwSTVZV1ZXc25zR2hIY3Q5UkYyeC80UDF4ZTVl?=
 =?utf-8?B?T2thbnlLNE5ueW5SaFJYNzlpVU9mM0JUanJCS08rTld4SUlHeWFyY3ROSUlX?=
 =?utf-8?B?Vkt2RUpTT0QrcHhjNTVUVWhiQnJhcnNKWkUwNS9rcDByQUpXVy9Wb1JHUUsw?=
 =?utf-8?B?UUd4TFFDNUNZQ3RiTkdEQVViNTVzSFpMUWVNODFDOFRoWVFyTWZLMkd0V0lv?=
 =?utf-8?B?bkFMdS9PamlMaDY3TU9XbzJKSXdYbnBsWnFMYlFqRkcwRWlNTitpOWNJV290?=
 =?utf-8?B?NVZVdCtCd1JzZzZTb2lmeHArc1JRVTBmUGNibm0zNjhwU0w4NHNhNTJmS3F6?=
 =?utf-8?B?TmZxUjduaFVhK00xbEorZ29pQ0RtVjN1a1RsaFV5T1ZjQ1JQSU9JUEk2TWVU?=
 =?utf-8?B?MktRWjArK0FpK2taKy80emhHZXdpbzhkRzVQZXZHTjdXVG12YnAvY3Z5U1l6?=
 =?utf-8?B?dWNmdnk0RmN0VUJaenJrV3E0ZGlLY25ZeHllZlJQdDY4N0FlOVJiYnFiVHha?=
 =?utf-8?B?VEN4L05IcFhZdHNXc2RlZFg1UnkrY1gydzRiNXRSMWxPVVBMNExmbTA0bmx2?=
 =?utf-8?B?OVJ3bnI2Z1JCMjd0TXU4eXp1Nm1XMEY5WDZiU1VnSmlQVGNGM1FzVDNTTVFG?=
 =?utf-8?B?YzV0YU0xTk5ydnIvbzFSMTRlSzdqdytOZk01TVJBak1JN3BQUVcyV25NTndU?=
 =?utf-8?B?NFlBM3UxRE5FSlpCcUl1NVpRdENtajVlTThEc0k5aUcrU1d6cVJzTXpUYTlu?=
 =?utf-8?B?VjRCL0Z3M0xVRDhxcUVlNVF4elNvMUhHMUlkSUNmOGhkSVZGdG1NU21rNHJY?=
 =?utf-8?B?S2Q4UVliVExmcy9yVW5jQ0d2dmhRWjlRZXYwTTdJNXRXYjErbG9WNlVRdEcz?=
 =?utf-8?B?bCtHdFUxSWZSK2JwMUhXYjBQUXVjRHhoRWs5M0pDcGtBTkg3YTBXR2ZOWW1M?=
 =?utf-8?B?TEp1MW9oSTBHVm95UTR3VDdmejVHUG16WjZKOWdLRHZ5K0tEYU9uSnlwYUxh?=
 =?utf-8?B?cnRtc2VEb0FLN3RaVk5SU3FGTkpuOUsxTWlrY2x6ekhFTVZkbnlYbUlyOXBB?=
 =?utf-8?B?Ylg5ZVNWZlNvSmd5cHBWUWdHOW00dFB5eXlBVlV6dTdNNkpSSmRGUmNrTWt5?=
 =?utf-8?B?ZzBsSm4wNTRkVTRUc09OVjlpK0dDdWZ2WDh5cWFIVEwzdEJNSnBJQ0lmSHE0?=
 =?utf-8?B?dHVmUnhPS3JUTU5zTjRqNmZiYTNEdU1rM3BMNlNqWEtYNGdwa2h5WGt3Ukh2?=
 =?utf-8?B?dkFwL09VbEJ3K3NCQXR6aHNxamJKb3pXcXJXdVA4YWNlbTVRT0pPakowbzV2?=
 =?utf-8?B?Z21jNTc5TXdVOEg2bGFidFh5RzlxclkrNWtFQ2w2bUxTU1o2ZUxPWHJ4ZkR1?=
 =?utf-8?B?YlhpSm5POHZOa1RFUUh4c0ZCVEd0bXFHaGxBV1VyNlNWR2p5blJaTVF0cjdl?=
 =?utf-8?B?S0d1dDQ2TjNjNXZFRHNEV0FPeTdURENEN2QzRURXckJlRTl1UFM1OGVIakFl?=
 =?utf-8?B?VGZhUG1rMWJjWkNiN3JhcVRISXRTZVRud25Gb2YyTGFtZ0ROVlBrWVpoaTZU?=
 =?utf-8?B?ZCtQc2JUeklvWjNpbFYxeXBhaTZWSE1GV01KUG5WcTZDTUVmSWpNOFlPSHZs?=
 =?utf-8?B?NlR0aHFRcFFmbjBHdzRrUVIyMk9JTUdsYVdUa1c2YjhvRmRvZzFCamZ1UE43?=
 =?utf-8?Q?3Lv3+jcIcLMEub7KgGrbypTFihL1D0RCgPAydAq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f58e43a-66a6-43eb-ef01-08d963e4d571
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 14:14:33.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDIUI2aQH3Vn4JZYgS8fWN8p7MqTHMLlEOQ4ty2Wra6etpaBAW2DBetTX+i47XNS8eAs0Uuz8qcuuhrv4BWLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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

On 2021-08-19 2:58 p.m., Fangzhi Zuo wrote:
> Parse DP2 encoder caps and hpo instance from bios
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c     | 10 ++++++++++
>   drivers/gpu/drm/amd/display/dc/bios/command_table2.c   | 10 ++++++++++
>   .../drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c  |  4 ++++
>   drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |  6 ++++++
>   drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h        |  4 ++++
>   .../gpu/drm/amd/display/include/bios_parser_types.h    | 10 ++++++++++
>   drivers/gpu/drm/amd/include/atomfirmware.h             |  6 ++++++
>   7 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 6dbde74c1e06..cdb5c027411a 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -1604,6 +1604,16 @@ static enum bp_result bios_parser_get_encoder_cap_info(
>   			ATOM_ENCODER_CAP_RECORD_HBR3_EN) ? 1 : 0;
>   	info->HDMI_6GB_EN = (record->encodercaps &
>   			ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN) ? 1 : 0;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	info->IS_DP2_CAPABLE = (record->encodercaps &
> +			ATOM_ENCODER_CAP_RECORD_DP2) ? 1 : 0;
> +	info->DP_UHBR10_EN = (record->encodercaps &
> +			ATOM_ENCODER_CAP_RECORD_UHBR10_EN) ? 1 : 0;
> +	info->DP_UHBR13_5_EN = (record->encodercaps &
> +			ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN) ? 1 : 0;
> +	info->DP_UHBR20_EN = (record->encodercaps &
> +			ATOM_ENCODER_CAP_RECORD_UHBR20_EN) ? 1 : 0;
> +#endif
>   	info->DP_IS_USB_C = (record->encodercaps &
>   			ATOM_ENCODER_CAP_RECORD_USB_C_TYPE) ? 1 : 0;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> index f1f672a997d7..6e333b4af7d6 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -340,6 +340,13 @@ static enum bp_result transmitter_control_v1_7(
>   	const struct command_table_helper *cmd = bp->cmd_helper;
>   	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {0};
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	uint8_t hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_0;
> +
> +	if (dc_is_dp_signal(cntl->signal))
> +		hpo_instance = (uint8_t)cntl->hpo_engine_id - ENGINE_ID_HPO_DP_0;
> +#endif
> +
>   	dig_v1_7.phyid = cmd->phy_id_to_atom(cntl->transmitter);
>   	dig_v1_7.action = (uint8_t)cntl->action;
>   
> @@ -353,6 +360,9 @@ static enum bp_result transmitter_control_v1_7(
>   	dig_v1_7.hpdsel = cmd->hpd_sel_to_atom(cntl->hpd_sel);
>   	dig_v1_7.digfe_sel = cmd->dig_encoder_sel_to_atom(cntl->engine_id);
>   	dig_v1_7.connobj_id = (uint8_t)cntl->connector_obj_id.id;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	dig_v1_7.HPO_instance = hpo_instance;
> +#endif
>   	dig_v1_7.symclk_units.symclk_10khz = cntl->pixel_clock/10;
>   
>   	if (cntl->action == TRANSMITTER_CONTROL_ENABLE ||
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
> index 46ea39f5ef8d..6f3c2fb60790 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
> @@ -192,6 +192,10 @@ void dcn30_link_encoder_construct(
>   		enc10->base.features.flags.bits.IS_HBR3_CAPABLE =
>   				bp_cap_info.DP_HBR3_EN;
>   		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
> +		enc10->base.features.flags.bits.IS_DP2_CAPABLE = bp_cap_info.IS_DP2_CAPABLE;
> +		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
> +		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
> +		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;

Please drop the DCN guards around this section - don't want to modify 
the bit field structure based on DCN vs DCE only.

>   		enc10->base.features.flags.bits.DP_IS_USB_C =
>   				bp_cap_info.DP_IS_USB_C;
>   	} else {
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> index fa3a725e11dc..b99efcf4712f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> @@ -59,6 +59,12 @@ struct encoder_feature_support {
>   			uint32_t IS_TPS3_CAPABLE:1;
>   			uint32_t IS_TPS4_CAPABLE:1;
>   			uint32_t HDMI_6GB_EN:1;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +			uint32_t IS_DP2_CAPABLE:1;
> +			uint32_t IS_UHBR10_CAPABLE:1;
> +			uint32_t IS_UHBR13_5_CAPABLE:1;
> +			uint32_t IS_UHBR20_CAPABLE:1;
> +#endif

Drop them here as well.

>   			uint32_t DP_IS_USB_C:1;
>   		} bits;
>   		uint32_t raw;
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 5950da7bf252..15c823c8ae93 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -959,7 +959,11 @@ struct dmub_dig_transmitter_control_data_v1_7 {
>   	uint8_t hpdsel; /**< =1: HPD1, =2: HPD2, ..., =6: HPD6, =0: HPD is not assigned */
>   	uint8_t digfe_sel; /**< DIG front-end selection, bit0 means DIG0 FE is enabled */
>   	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	uint8_t HPO_instance; /**< HPO instance (0: inst0, 1: inst1) */
> +#else
>   	uint8_t reserved0; /**< For future use */
> +#endif
>   	uint8_t reserved1; /**< For future use */
>   	uint8_t reserved2[3]; /**< For future use */
>   	uint32_t reserved3[11]; /**< For future use */
> diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
> index 76a87b682883..d2fb018d31d0 100644
> --- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
> +++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
> @@ -152,6 +152,10 @@ struct bp_transmitter_control {
>   	enum signal_type signal;
>   	enum dc_color_depth color_depth; /* not used for DCE6.0 */
>   	enum hpd_source_id hpd_sel; /* ucHPDSel, used for DCe6.0 */
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	enum tx_ffe_id txffe_sel; /* used for DCN3 */
> +	enum engine_id hpo_engine_id; /* used for DCN3 */
> +#endif
>   	struct graphics_object_id connector_obj_id;
>   	/* symClock; in 10kHz, pixel clock, in HDMI deep color mode, it should
>   	 * be pixel clock * deep_color_ratio (in KHz)
> @@ -319,6 +323,12 @@ struct bp_encoder_cap_info {
>   	uint32_t DP_HBR2_EN:1;
>   	uint32_t DP_HBR3_EN:1;
>   	uint32_t HDMI_6GB_EN:1;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	uint32_t IS_DP2_CAPABLE:1;
> +	uint32_t DP_UHBR10_EN:1;
> +	uint32_t DP_UHBR13_5_EN:1;
> +	uint32_t DP_UHBR20_EN:1;
> +#endif

And from this file as well.

>   	uint32_t DP_IS_USB_C:1;
>   	uint32_t RESERVED:27;
>   };
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 44955458fe38..d4b245f12651 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -768,6 +768,12 @@ enum atom_encoder_caps_def
>     ATOM_ENCODER_CAP_RECORD_HBR2_EN               =0x02,         // DP1.2 HBR2 setting is qualified and HBR2 can be enabled
>     ATOM_ENCODER_CAP_RECORD_HDMI6Gbps_EN          =0x04,         // HDMI2.0 6Gbps enable or not.
>     ATOM_ENCODER_CAP_RECORD_HBR3_EN               =0x08,         // DP1.3 HBR3 is supported by board.
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +  ATOM_ENCODER_CAP_RECORD_DP2                   =0x10,         // DP2 is supported by ASIC/board.
> +  ATOM_ENCODER_CAP_RECORD_UHBR10_EN             =0x20,         // DP2.0 UHBR10 settings is supported by board
> +  ATOM_ENCODER_CAP_RECORD_UHBR13_5_EN           =0x40,         // DP2.0 UHBR13.5 settings is supported by board
> +  ATOM_ENCODER_CAP_RECORD_UHBR20_EN             =0x80,         // DP2.0 UHBR20 settings is supported by board
> +#endif

And lastly from this file. We don't want to modify this shared header 
with DAL specific guards.

Regards,
Nicholas Kazlauskas

>     ATOM_ENCODER_CAP_RECORD_USB_C_TYPE            =0x100,        // the DP connector is a USB-C type.
>   };
>   
> 

