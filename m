Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EB9C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 19:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECCA2071E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JmPbi+3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCA2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C378A6E435;
	Fri, 24 Jan 2020 19:28:01 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700065.outbound.protection.outlook.com [40.107.70.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1356E435
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 19:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT45SCZZrJcAbf+KP/bG49IV+52R2B3hoJFD3v6cgHW1ZIntTI8zjiDLwhwLV+MvyrH9SOufMrIXgYTNmSnoE1WlYuFvgya2O/0QV0B4k4IDaQb9YOPQUSvoGLSJId3qsflanXgKUSquAuQwqp6bpvIcPH1hATth0NaDd4kcdaHU7E4agV/I87bs4NHFFsjEkclt0UUAFzAcFqO7zpxjwiL0s2uKR2VmVlCeonN84wi3LT2vsuvBwNBAVpe2+c8mWcXwfQYgvpHnQkwwPXvqPyGt8a3RCzpupNv73KKhYenDk85vsDbmrGnzFAF+bp+NMGDWsQDRu6V52UR1QKTwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmoxULsuOOA0n1cIFHwfLni8RV3ynJSy1ZBOyViUZ8=;
 b=ae2dNNx1ZuWv7a8Gt4qUIBr+Fue2JKpFFGvTysxdRdla+2Vt90OpUyv1GYPCL08OMSTtAJ1Gxzy52e87kgQvj0FtfEiRTFa+Cnx3JEXPKS+STDViLN4xB/eDC3qWO3TasRxp/Bs0Shdy0RPD6FBlOUDIHGcJhCctPdAELx0lrBaWkTL7F1hfxDrX20PU5ful6qz4pW9dNJPsXmlQ3jNSq4bOL/QAAB39ALHarpg1bPSEzlVV5AX28bhYqZzDLi/ZGDFcf3ic05PpZe+CgBlAahs+o+Q7vEoww9XF+h5zSUcOSgHt4wOMLhOkFLTOeVB2pRQUComcLFvs7lQ+sARpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmoxULsuOOA0n1cIFHwfLni8RV3ynJSy1ZBOyViUZ8=;
 b=JmPbi+3zgEvbOEI0MtEwpMeWt/tMPS84W87s8a9zVYMGbW+JRUZxITWLAzUE6g33aBtYewgc4BUVvN0hKA7Uot7KO0Kkdl7yMCYmkuDu69xOJarQ5XS+caY9UEetoMcwxhF8XVLhyQPZmixKxLfDhIJRp6h9elXPrb8ZzQirkkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2533.namprd12.prod.outlook.com (10.172.120.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Fri, 24 Jan 2020 19:27:59 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 19:27:59 +0000
Subject: Re: [PATCH] drm/amd/display: Fix HW/SW state mismatch
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116202046.10991-1-Bhawanpreet.Lakha@amd.com>
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
Message-ID: <aee63cb2-d140-3442-aef4-884a9df9ef11@amd.com>
Date: Fri, 24 Jan 2020 14:27:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116202046.10991-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Fri, 24 Jan 2020 19:27:58 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55a0c1fe-2eca-4f76-5f58-08d7a1038527
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2533:|CY4PR1201MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25338EB78F23188A07CD3A7F8C0E0@CY4PR1201MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(5660300002)(53546011)(81166006)(186003)(31696002)(6486002)(2906002)(81156014)(66946007)(66556008)(66476007)(478600001)(26005)(4326008)(16526019)(52116002)(2616005)(36756003)(956004)(8936002)(316002)(16576012)(8676002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2533;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQXUwS7XUdxaiCz4Trmpp0YFuT0Y7jixHHZkHe4woDf/cyWi+JhLlVTduaBqKWk4CwFO9fP98ZMcFtlBLWiB3CYsvpEyX8f9Jqy/a9+PpGztDnepJ+zO+T1Wgra7mSkvtMMxkv8qF+FdIXaD30nnPfRNPXAy/OVF4wJfgvslaifkavHkU0bbgTB+bOPgTPGScCw0E4LdVf0v3XbhGJhARYEfpmOqonzvJuywSVogIPZKgJDd/8npr20rhzWmi1L42sikjrHizTOukBO3U17WVyF7nXq/n++kZgYyMRyNFvs+QNloDnB/AqN3nKR92gDs3puiX80nNwUdfpahEhcgisy552grlpMfyIE70/jgdPv7cO8PywvEgmYi5bMjI4Yf7sNk8tOwEvtfTHDJ7zbC49bTJIQv6ige8hGE44EEItXEm6e2wKg28/2c/PPgMviL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a0c1fe-2eca-4f76-5f58-08d7a1038527
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 19:27:59.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oosE7bvHMkVub5tsSzvZIhIARh4AFg7FHDS7cVDzd7xa3anyjJ8O9fi20/pFT2ZcIwCwjgnj5dza2n0eaOVOsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2533
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
Cc: rodrigo.siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-16 3:20 p.m., Bhawanpreet Lakha wrote:
> [Why]
> When we disable a connector we don't explicitly remove it from the module so the
> display is still cached(SW) in the hdcp_module.
> 
> SST: no issues because we can only have 1 display per link
> 
> MST: We have x displays per link, now if we disable 1 we don't remove it from the
> module so the module has x display cached(SW).
> 
> If we try to enable HDCP, psp verification will fail because we are reporting x
> displays while the HW only has x-1 display enabled
> 
> [How]
> Check the callback for when we disable stream and call remove display.
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index ae329335dfcc..0acd3409dd6c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -135,6 +135,20 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>  	mutex_unlock(&hdcp_w->mutex);
>  }
>  
> +static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
> +			 unsigned int link_index,
> +			 struct amdgpu_dm_connector *aconnector)
> +{
> +	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
> +
> +	mutex_lock(&hdcp_w->mutex);
> +	hdcp_w->aconnector = aconnector;
> +
> +	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
> +
> +	process_output(hdcp_w);
> +	mutex_unlock(&hdcp_w->mutex);
> +}
>  void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
>  {
>  	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
> @@ -303,6 +317,11 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>  	memset(link, 0, sizeof(*link));
>  
>  	display->index = aconnector->base.index;
> +
> +	if (config->dpms_off) {
> +		hdcp_remove_display(hdcp_work, link_index, aconnector);
> +		return;
> +	}
>  	display->state = MOD_HDCP_DISPLAY_ACTIVE;
>  
>  	if (aconnector->dc_sink != NULL)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
