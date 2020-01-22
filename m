Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3CC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412D1217F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uY0pMLeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412D1217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB626F88B;
	Wed, 22 Jan 2020 19:25:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4716F88A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 19:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJh728nNV+yP69qn5iaqM+TKkW26FUIXpBOPkzVMiL46wmHKXBtTLbe1o1nQPm6swHWZxv6iwjtC5TZT9BdMEPb3DEktbk5qYzY5DOq6Ljz22uzlkhPZ2JsmwsYNwoqcfVRMaYKZAOdoZdVetWIBWt8EIXNUKhZ72YG8uuHW2gJTK/iwFsMli/0GEN6agPNntSFpNIqNNQWu76eINrkMKSVUwJFS4auFZJWZJh31bMxLgm0HqYgyHePkaJadPHQFPCYzaMvUyyhU6E/ewHlT3G4ob3M/jM5Q9hQZv7FhpQv4PFQmumMEzYxqcF9yHqkd7RVdfr1djmooY+7BaMbiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vor5vl80UlF3mCJ7XCGX1SbYMqEr60qocuiau65XyfY=;
 b=ksaG6nC7KosgntoRuD+Elv+HWdqc/ctJA0vsTGTmFjQITLFWu0g81Z3YOD9ZJEGWK0FOc/Us/XFI/ncd1Lk3rXYLNXNM20nXIi/j1w/qEnLlPv30/ZOkVopDiD6tfv57lCjIGCFT6IppIjNeNxO306TwmemKxk6oYb17AxhMy1Dgd872dZHum30x02PxFZE5dvRCiINM+ZJVUoesPDDJdZFAuM1QSQ/enz8u8ClTHAxW3VaA7O3iL8YGsriwTTXgCafTmrNwPjpd7ku90QbnVKXnLrmty9qytkATx0sPevhyfpDWH+0ok+VEuhn35SoHX7RjKhtrAPbE5OH3uY/Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vor5vl80UlF3mCJ7XCGX1SbYMqEr60qocuiau65XyfY=;
 b=uY0pMLeKuLy8ub9wvg6SUGW85fNgPVxXGya2DTPZOumBSJp/5bIrulrt5tm9fg7J82+rm0W3RcnpLssx1TakIX5udLh5V77xROYFy1eYx2ZalPpRkXRNolMd43ow39u5GeWvbkU5RS+lRpeOULqu0jVfFO9s9wNj1Lmdgl7Gncg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB2482.namprd12.prod.outlook.com (10.172.108.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 19:25:25 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2%3]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 19:25:25 +0000
Subject: Re: [PATCH 5/5] drm/amd/display: call psp set/get interfaces
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <20200116202945.21801-6-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <5a71d02c-1859-3b9d-4b0f-a0e206ed61c7@amd.com>
Date: Wed, 22 Jan 2020 14:25:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116202945.21801-6-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 22 Jan 2020 19:25:25 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc7f505-d6a7-44d6-703c-08d79f70d50e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2482:|BN6PR1201MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB248249B4E70AB2C33B0909F08C0C0@BN6PR1201MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(26005)(5660300002)(66946007)(4326008)(6486002)(81156014)(81166006)(66556008)(2616005)(8676002)(956004)(31696002)(66476007)(16526019)(2906002)(186003)(52116002)(36756003)(316002)(16576012)(31686004)(53546011)(8936002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2482;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeYfycWjj7P12SsZ7ibLTX1nkx0hy0Fb1DgkdFVIweK4cRRlciWtsw47pAFOtQkZbYPQ1B0j/F3j+hLCGjIuS2ftFHGgnRaIGLDvgPQcfeXrs+EUMWRVODU2no9tzkR+99aypBvfshTKgm3F6gaaWT3ZEWAxyV8xPgz/WqSuRnWPU4/Uh1Lig7oO+kvR9M+IUNdtyeMQDpnNYaZnSvZtvrH8NWRZdSEMQt+8IIKKuMs3vHuPwstBzo2n/3KntEFhzfdvL16FEoGwuebZuINQDdh/49xcFGOZ0q/2782BcSvbZkP6MIWDJCAFH9ylPl3iWmrT3PNEvpV7FvTcw+wAqQfD46w/OYOijbRVyKBw9RrRs9/H6wxn5Do+/def2ECiitEv2oDDUWWVxPfqgrRLcw4Z2ezS56LC/bAgSiRD0azyl38OIdYsthhLZ91qmIDp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc7f505-d6a7-44d6-703c-08d79f70d50e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 19:25:25.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF9ZayERfBfSYfCDrus01v49pYaQYzQsYsfDtioT3MQixIOYtM/qY18Gao25MTuChIkn1gp5anclYrdt6omf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2482
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
Cc: harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:
> Call the cmd ids for set/get srm according to the sysfs call
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 49 ++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 129696e997b6..913d0e1e0828 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -71,11 +71,58 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
>  
>  static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
>  {
> -	return NULL;
> +
> +	struct ta_hdcp_shared_memory *hdcp_cmd;
> +
> +	if (!psp->hdcp_context.hdcp_initialized) {
> +		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
> +		return NULL;
> +	}
> +
> +	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
> +	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
> +
> +	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP_GET_SRM;
> +	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
> +
> +	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
> +		return NULL;
> +
> +	*srm_version = hdcp_cmd->out_msg.hdcp_get_srm.srm_version;
> +	*srm_size = hdcp_cmd->out_msg.hdcp_get_srm.srm_buf_size;
> +
> +
> +	return hdcp_cmd->out_msg.hdcp_get_srm.srm_buf;
>  }
>  
>  static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
>  {
> +
> +	struct ta_hdcp_shared_memory *hdcp_cmd;
> +
> +	if (!psp->hdcp_context.hdcp_initialized) {
> +		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
> +		return -EINVAL;
> +	}
> +
> +	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
> +	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
> +
> +	memcpy(hdcp_cmd->in_msg.hdcp_set_srm.srm_buf, srm, srm_size);
> +	hdcp_cmd->in_msg.hdcp_set_srm.srm_buf_size = srm_size;
> +	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP_SET_SRM;
> +
> +	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
> +
> +	/*
> +	 * If the SRM version being loaded is less than or equal to the
> +	 * currently loaded SRM, psp will return 0xFFFF
> +	 */
> +	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS || hdcp_cmd->out_msg.hdcp_set_srm.valid_signature != 1 ||
> +	    hdcp_cmd->out_msg.hdcp_set_srm.srm_version == 0xFFFF)

Can we define the 0xFFFF value in this file instead of using and
documenting a magic value?

Harry

> +		return -EINVAL;
> +
> +	*srm_version = hdcp_cmd->out_msg.hdcp_set_srm.srm_version;
>  	return 0;
>  }
>  
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
