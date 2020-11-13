Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E247C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 21:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67D22068E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 21:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AiRPU8Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67D22068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8348B6E5C5;
	Fri, 13 Nov 2020 21:55:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569E66E5C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 21:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgzlxOhUJDB69b4TxEvS+J5lAm4fd86WUy+G+cxnwCbIbYR1PJk6NeV9qiBku/SVlnzia2cenyCcX2XjU8BUFI4EHzsU0/pD+vO2VnNYlFhdb2JhrDA8W78Y54Hbp5OH0x1OW1Y+2WE8B55erJI49OdG98HMZzkQc15ztgb2vnkJyCee5cpQEofHBa2z/XBQCYNUvbDyIR/u836SL6zx6OTG82DjvSRRHQWK2XEcR5eer5CEKGtiBGzw0kmrUjUo/ty46wAoKa0SJw1xt2uFMmQWtdnWi4aAmHHCowFOe6E6zDjFQHUq7oLm03oNa0wZsu5GLnt9mtPXN1ZGUkFRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NttcqOOrbGofs/QK/ag5aNKa7RN5W5pPP6Puo+XBWSY=;
 b=ZdL+ak9Y/Nd6qFbzKxPdmXm4sePRVOzL3190y9mDob+GH1N1ZqnTkRTGBoX2NHm/1RH+/NZ0GLcZMnWulwSxtiUviCq8NOmr1HZ1Ur+Y132jeiU/vSAzckSQyySBVHTdpY9347inCcrVSh1HJr2FQkpfjcGJDL19fAynHcRxwT7RqzdsxlRCQVlGEFaZtZae3FvUWI0QNgoyP4CaoJY+dtcRAJ7jlFlQwCd5pE7Ya0BVczt1xS4/aclhK2iMYdSkDzUzpYmePi9NXnKzsRDUIaZD2ucG9cJ6HdoC6kG0b8/39ViaVeV4wV3M4f3HNEGpGsRbFe86IatTP7nJi2H7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NttcqOOrbGofs/QK/ag5aNKa7RN5W5pPP6Puo+XBWSY=;
 b=AiRPU8Eh3v3dtXf/IrXZ0WrAHnpuXnMsmldB/4ZlmltvSO9TPGwAKstZ0C+/aUZerWP95i/u45wyRldQY12y0yjsuUeinzamnWaVsAsHdicJkHWszrmS430QoYL9KmX1kpnmB14w3Fp/lAHTEfQxT2GfBovnLzd02ZPdJknH1MY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 21:55:35 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Fri, 13 Nov 2020
 21:55:35 +0000
Subject: Re: [PATCH] drm/amd/display: Update dmub code
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20201113202706.1890613-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <a7795007-12b0-09d3-23bf-c72900b682df@amd.com>
Date: Fri, 13 Nov 2020 16:55:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201113202706.1890613-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 21:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0764ed47-c883-45b3-0bd5-08d8881ed98a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2918430443E2CB1C42F36DCBECE60@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sOQUDK9muoCba0HpKqQIbp7yzV6jcRhr1pE6CTlCD+PQtq9IMK58UVTMv5n2Wru98/UTt/N5oZ1nc4+OvxoZVHpFX0MTd6xsAO5Clcw1lZPHuhHsUCQhBOaICiX/IG+C3z4+FQjUrO4snx/3PhJe6Qnan9OkN/HAgT2caS3f0chspGvxVQ2AdIydFXBF5ZtJ5vRriy86v9LauZKvOFkOgUPwhOCwHw3d/cO67clTxGv6QfgNaTSBL+gvkF48U3xYUSORYfGbW09vYqFK5I+7nmjfxyHw8T8fFfT7U9aLJ7FL25aTfbwY3bde87xXXOtwGJO7huH6DUw64gFphToLiT48uoqbw5+wKDP/q+Z+zGh+VEbkpmm2vrH0FOzmOI9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(8676002)(2616005)(2906002)(15650500001)(16526019)(52116002)(53546011)(31686004)(86362001)(6486002)(26005)(186003)(6636002)(478600001)(316002)(31696002)(6666004)(4001150100001)(16576012)(4326008)(83380400001)(5660300002)(8936002)(36756003)(956004)(66556008)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D7hndWFq15zLj75cupjXqjXC7XPuci0vDwjHAoZYGQz2X1kHJVBBbcs/arHxqvi7JYUm/VyHT0d2D2Et6TVg2UNqtP3xgMxdHyPKoz/guEJJAeTFcnD7JRxWkvj8vnigZKyjHU1avsuWwe4bzikCyFceWC3y72tVHYTgFY2294dADFINep3YBq/y6ljcOuhurfHWtadHnYvHGltRhMgOSEZqDEOsJAUNC7WRw8sI/1UXk3ihxOqD+RIgkoGItnryZASfzFu8P9xmlHsz/V/zsNxG8isulCEujhwX0z4njlD4Dc8TYxTQhRrp+CcNvOSqjHTFdJwBwmOzGJLdaaOX8MwMadFkiPSEDTVT30dMvworEjjm76XvKpAbQzhfurMnpU+3d+LrXhmPnSJwUjVsIzAskU0sc3tqX3zMBorCW7XKrWQ9bRV2xsqFoiFL9l0/+pTcY+XOneEKF/JhJKLIPvzyOVtEA0qJRQGk+7vdRzZ/kDBvSoOMNR5cvDN3b+GBuu0adpA/85gkcglpTts6k9qG7MpFAIN67Xlif4aXsNcgmf4sukAj6YyO+bgicDIH7y7ZLCtowb0MhAKh+NKMevpMopg7FezK1+KhOxgXoTg91weA9FKEF0xsoF03c3b0u3VEDNX/qkmj9iIHq2ZYVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0764ed47-c883-45b3-0bd5-08d8881ed98a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 21:55:35.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHWz0JXPUDAgSXQRUY/5W+3JTD49IAg1nstQ5wc9vl6wUyjEuZJnG2XEE9dfsJlg19Y+Trx2H6xXWwp4rSqhgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-13 3:27 p.m., Bhawanpreet Lakha wrote:
> There is a delta in the dmub code
> - add boot options
> - add boot status
> - remove unused auto_load_is_done func pointer
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 20 +++++++++++++-
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 ++-
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 23 ++++++++++++++++
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  6 +++++
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |  5 ----
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  2 --
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |  5 ----
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |  1 -
>   .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 26 ++++++++++++++-----
>   9 files changed, 70 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index ac41ae2d261b..b82a46890846 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -265,8 +265,12 @@ struct dmub_srv_hw_funcs {
>   	bool (*is_hw_init)(struct dmub_srv *dmub);
>   
>   	bool (*is_phy_init)(struct dmub_srv *dmub);
> +	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
> +
> +	void (*skip_dmub_panel_power_sequence)(struct dmub_srv *dmub, bool skip);
> +
> +	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
>   
> -	bool (*is_auto_load_done)(struct dmub_srv *dmub);
>   
>   	void (*set_gpint)(struct dmub_srv *dmub,
>   			  union dmub_gpint_data_register reg);
> @@ -309,6 +313,7 @@ struct dmub_srv_hw_params {
>   	uint64_t fb_offset;
>   	uint32_t psp_version;
>   	bool load_inst_const;
> +	bool skip_panel_power_sequence;
>   };
>   
>   /**
> @@ -590,6 +595,19 @@ enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
>    */
>   void dmub_flush_buffer_mem(const struct dmub_fb *fb);
>   
> +/**
> + * dmub_srv_get_fw_boot_status() - Returns the DMUB boot status bits.
> + *
> + * @dmub: the dmub service
> + * @status: out pointer for firmware status
> + *
> + * Return:
> + *   DMUB_STATUS_OK - success
> + *   DMUB_STATUS_INVALID - unspecified error, unsupported
> + */
> +enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
> +					     union dmub_fw_boot_status *status);
> +
>   #if defined(__cplusplus)
>   }
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index b0d1347d13f0..9fd24f93a216 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -191,7 +191,8 @@ union dmub_fw_boot_options {
>   		uint32_t optimized_init : 1;
>   		uint32_t skip_phy_access : 1;
>   		uint32_t disable_clk_gate: 1;
> -		uint32_t reserved : 27;
> +		uint32_t skip_phy_init_panel_sequence: 1;
> +		uint32_t reserved : 26;
>   	} bits;
>   	uint32_t all;
>   };
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> index 2c4a2fe9311d..cafba1d23c6a 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> @@ -312,3 +312,26 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
>   {
>   	return REG_READ(DMCUB_SCRATCH7);
>   }
> +
> +union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
> +{
> +	union dmub_fw_boot_status status;
> +
> +	status.all = REG_READ(DMCUB_SCRATCH0);
> +	return status;
> +}
> +
> +void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
> +{
> +	union dmub_fw_boot_options boot_options = {0};
> +
> +	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
> +}
> +
> +void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
> +{
> +	union dmub_fw_boot_options boot_options;
> +	boot_options.all = REG_READ(DMCUB_SCRATCH14);
> +	boot_options.bits.skip_phy_init_panel_sequence = skip;
> +	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> index a316f260f6ac..d438f365cbb0 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> @@ -192,4 +192,10 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
>   
>   uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
>   
> +void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
> +
> +void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
> +
> +union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
> +
>   #endif /* _DMUB_DCN20_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> index e8f488232e34..1cf67b3e4771 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> @@ -53,11 +53,6 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
>   
>   /* Shared functions. */
>   
> -bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
> -{
> -	return (REG_READ(DMCUB_SCRATCH0) == 3);
> -}
> -
>   bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
>   {
>   	return REG_READ(DMCUB_SCRATCH10) == 0;
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> index 2bbea237137b..6fd5b0cd4ef3 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> @@ -34,8 +34,6 @@ extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
>   
>   /* Hardware functions. */
>   
> -bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
> -
>   bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
>   
>   #endif /* _DMUB_DCN21_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> index 215178b8d415..f00df02ded81 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
> @@ -188,8 +188,3 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
>   		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
>   		  DMCUB_REGION3_CW6_ENABLE, 1);
>   }
> -
> -bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub)
> -{
> -	return (REG_READ(DMCUB_SCRATCH0) > 0);
> -}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
> index 4d8f52b8f12c..9a3afffd9b0f 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
> @@ -45,6 +45,5 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
>   			      const struct dmub_window *cw5,
>   			      const struct dmub_window *cw6);
>   
> -bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub);
>   
>   #endif /* _DMUB_DCN30_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index d11b96d132ad..ba8494cf005f 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -153,17 +153,18 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>   		funcs->set_gpint = dmub_dcn20_set_gpint;
>   		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
>   		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
> +		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
> +		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
> +		funcs->skip_dmub_panel_power_sequence = dmub_dcn20_skip_dmub_panel_power_sequence;
>   
>   		if (asic == DMUB_ASIC_DCN21) {
>   			dmub->regs = &dmub_srv_dcn21_regs;
>   
> -			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
>   			funcs->is_phy_init = dmub_dcn21_is_phy_init;
>   		}
>   		if (asic == DMUB_ASIC_DCN30) {
>   			dmub->regs = &dmub_srv_dcn30_regs;
>   
> -			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
>   			funcs->backdoor_load = dmub_dcn30_backdoor_load;
>   			funcs->setup_windows = dmub_dcn30_setup_windows;
>   		}
> @@ -535,11 +536,10 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
>   	if (!dmub->hw_init)
>   		return DMUB_STATUS_INVALID;
>   
> -	if (!dmub->hw_funcs.is_auto_load_done)
> -		return DMUB_STATUS_OK;
> -
>   	for (i = 0; i <= timeout_us; i += 100) {
> -		if (dmub->hw_funcs.is_auto_load_done(dmub))
> +		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
> +
> +		if (status.bits.dal_fw && status.bits.mailbox_rdy)
>   			return DMUB_STATUS_OK;
>   
>   		udelay(100);
> @@ -634,3 +634,17 @@ enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
>   
>   	return DMUB_STATUS_OK;
>   }
> +
> +enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
> +					     union dmub_fw_boot_status *status)
> +{
> +	status->all = 0;
> +
> +	if (!dmub->sw_init)
> +		return DMUB_STATUS_INVALID;
> +
> +	if (dmub->hw_funcs.get_fw_status)
> +		*status = dmub->hw_funcs.get_fw_status(dmub);
> +
> +	return DMUB_STATUS_OK;
> +}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
