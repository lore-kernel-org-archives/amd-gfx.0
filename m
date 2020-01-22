Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E58C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C439C20663
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="omNlcsjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C439C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F15C6F5C5;
	Wed, 22 Jan 2020 16:10:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F726F5C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WehAakPm9QP/RlnfHkiB4PjYqEgD9J6ab9ZiKq8Jq1lypn8qKAzMge3B8pjrgSGE2xZYUmRTafBmdtsAItgld3kZ1IzQENb/9GeTzgvn+AXe43rVBefiTgg0ZkpQ3xZFpZhVZEffGNaKZMqs4wxcE5gwTQsJEooib37DjdSw1xZshUK7MtLeiDN6qztT56G71rqlJyIL1Ce6j7gVFOiOeh538z8YT3RNtpu4TdEbA+u14dEHqKMotY4y50nlEN64HCBQh67CNkTJUPWwkFx39iQYcXV9nYdJ4WF+1X40blQYU8zTalkXTaPPB6c2oJdlVVLgFq7n3NpJvdTVyK4iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiA8pGPdelsyb47U48J+5ax/PZM6dvm/vL+oCHecld0=;
 b=Fl0b4s5sJWH4eGCp3hNiTgXM3AVoJ7Ez9VIW/xaAWoMp7Q+Z+Pvkmfx2ZVW4wKoLMYr6hQx8g3alGiMfBXebRFwyFetWTS+t9RwI9DneCGN7mGFAxJgI+A5/7K9G5Kw2/9XIKOjNcaLq+M2gzyp81pbMdf9oBE6OeFS++b00jzEC2UgE326ChEaLc0WklXooJZZtve6zGc8JeQu14jorcmeL1TF4v1fVde1u/g2M2GjyL4Tu2HDUYnbSS4wOojbPLEqr+w0gT8eQs4QB8I22SDZmmiHc/LIkyZZwz+IS0MlTxIJ4YJttAcEMuJFqO2vM4b9s9ak1cnCWlnb8SKsx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiA8pGPdelsyb47U48J+5ax/PZM6dvm/vL+oCHecld0=;
 b=omNlcsjxkDMBbrmZ/rM+pVWUJ6jaCSAGeolDUssOcUGUOJ8hx/puw5EZdqY/I05PM5p4fG5iciY/5W5U+EaQ6gKvE7PGq7qUmmpEB+Akjbg7JvX/mhGjikybSrOAVAQIVyI3k3b4Sq9PJFCCTcqcTOX5VJTJuMHf64xz0UVne5g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB0082.namprd12.prod.outlook.com (10.174.113.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.26; Wed, 22 Jan 2020 16:10:45 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2%3]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 16:10:45 +0000
Subject: Re: [PATCH 2/5] drm/amd/display: update psp interface header
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <20200116202945.21801-3-Bhawanpreet.Lakha@amd.com>
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
Message-ID: <7850186b-9556-1aa2-ca3f-5a02b71da97d@amd.com>
Date: Wed, 22 Jan 2020 11:10:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116202945.21801-3-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 16:10:44 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e08d08de-cc35-47a0-4605-08d79f55a2db
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0082:|BN6PR1201MB0082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB008264247B0D53F8686EADD68C0C0@BN6PR1201MB0082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(15650500001)(498600001)(31686004)(2616005)(956004)(4326008)(6486002)(36756003)(186003)(16526019)(8936002)(52116002)(81156014)(53546011)(81166006)(31696002)(8676002)(16576012)(66556008)(5660300002)(66946007)(26005)(66476007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0082;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NwkO8oqYubFeToyOOgTwOQYmI+vhrM6ut43ySczp0GVpphYqQ4afQw7etWXJwrSJhbqDZ7HiVWr9sXg7fcYv4ws+YQ9dh8oUCWFbwgkgibSpAgdF581p3ndVr8ZCSz2PO6mKKOapSgb8CMyI8KeBx8D/XBYZHT5lqOB7al7DrcFvTSgOrSMMLeGmnU9pIAJCtuW54lSr5tGIhDwmXTdftCTTJux7n/dgGz8FrA4bw9yTjtHT6euYu/mpFmNyNGfaoPDt3n+tERKTgHsSt+/9bopH//hlJcQVNzOPFJrR0Ulkof9gA/tI3fdZ6dlggvnevmjwAxBnKkFG98FxeoY01XZx8+z/QQTO1tu8a502wLvDViD+ommEfpOp+Mj1Q42hwDnP+GMwZNtkg+MM2VzpDRcq/Y2BX+nV2l04qt1bqLv981Die4UWf6ihG1bKCje
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08d08de-cc35-47a0-4605-08d79f55a2db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 16:10:45.1599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1NBaS9eA+lBJxB2MSo51glhPGRSJFn7A4eG/8i0do/YqxenhygKTyy/PojZBXwdOtvFf71B533xzH9xV1+9QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0082
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
> [Why]
> We need to support SRM

Why do we need to support SRM?

Please refer to section 5 "Renewability" of the HDCP 2.x spec and its
requirement to store the SRM in non-volatile memory.

Why does this involve PSP?

Describe that for AMD's content protection solution PSP owns the SRM
check but has no ability to store it in SRM memory directly, hence the
need for the kernel driver to facilitate it.

Why a sysfs?

Describe that the kernel driver cannot (or should not) write to the file
system. Outline how we expect usermode scripts to facilitate this and
use the sysfs to retrieve an SRM from PSP to store it to the filesystem
and passes it to PSP from the filesystem. We'll want to highlight at
which points (boot, suspend, etc.) we expect this to happen.

I recommend documenting this whole process here in the patch description
to provide a reference for posterity as it's not necessarily clear from
the patches why and what we're doing.

Harry

> 
> [How]
> Add the interface to the header file
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../drm/amd/display/modules/hdcp/hdcp_psp.h   | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> index 82a5e997d573..d5cb3f46606f 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> @@ -117,6 +117,8 @@ struct ta_dtm_shared_memory {
>  int psp_cmd_submit_buf(struct psp_context *psp, struct amdgpu_firmware_info *ucode, struct psp_gfx_cmd_resp *cmd,
>  		uint64_t fence_mc_addr);
>  
> +enum { PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE = 5120 };
> +
>  enum ta_hdcp_command {
>  	TA_HDCP_COMMAND__INITIALIZE,
>  	TA_HDCP_COMMAND__HDCP1_CREATE_SESSION,
> @@ -134,7 +136,10 @@ enum ta_hdcp_command {
>  	TA_HDCP_COMMAND__UNUSED_3,
>  	TA_HDCP_COMMAND__HDCP2_CREATE_SESSION_V2,
>  	TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2,
> -	TA_HDCP_COMMAND__HDCP2_ENABLE_DP_STREAM_ENCRYPTION
> +	TA_HDCP_COMMAND__HDCP2_ENABLE_DP_STREAM_ENCRYPTION,
> +	TA_HDCP_COMMAND__HDCP_DESTROY_ALL_SESSIONS,
> +	TA_HDCP_COMMAND__HDCP_SET_SRM,
> +	TA_HDCP_COMMAND__HDCP_GET_SRM
>  };
>  
>  enum ta_hdcp2_msg_id {
> @@ -415,6 +420,22 @@ struct ta_hdcp_cmd_hdcp2_enable_dp_stream_encryption_input {
>  	uint32_t display_handle;
>  };
>  
> +struct ta_hdcp_cmd_set_srm_input {
> +	uint32_t srm_buf_size;
> +	uint8_t srm_buf[PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE];
> +};
> +
> +struct ta_hdcp_cmd_set_srm_output {
> +	uint8_t valid_signature;
> +	uint32_t srm_version;
> +};
> +
> +struct ta_hdcp_cmd_get_srm_output {
> +	uint32_t srm_version;
> +	uint32_t srm_buf_size;
> +	uint8_t srm_buf[PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE];
> +};
> +
>  /**********************************************************/
>  /* Common input structure for HDCP callbacks */
>  union ta_hdcp_cmd_input {
> @@ -432,6 +453,7 @@ union ta_hdcp_cmd_input {
>  	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2
>  		hdcp2_prepare_process_authentication_message_v2;
>  	struct ta_hdcp_cmd_hdcp2_enable_dp_stream_encryption_input hdcp2_enable_dp_stream_encryption;
> +	struct ta_hdcp_cmd_set_srm_input hdcp_set_srm;
>  };
>  
>  /* Common output structure for HDCP callbacks */
> @@ -444,6 +466,8 @@ union ta_hdcp_cmd_output {
>  	struct ta_hdcp_cmd_hdcp2_create_session_output_v2 hdcp2_create_session_v2;
>  	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2
>  		hdcp2_prepare_process_authentication_message_v2;
> +	struct ta_hdcp_cmd_set_srm_output hdcp_set_srm;
> +	struct ta_hdcp_cmd_get_srm_output hdcp_get_srm;
>  };
>  /**********************************************************/
>  
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
