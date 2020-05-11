Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB01C54E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E242075E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ev5lq/ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E242075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F3389249;
	Mon, 11 May 2020 19:48:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE72F89249
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 19:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXJmU0ZWI1rffjD6pFfsqK79b2zyo/4+jQ8592tw75eRDG8zSPxhfprfYD9udHXdutrZpgVcHkMuO40808gCyw5tZbWpT2GizH8SowTjfKlvWKSqh20pKEJgr8JWSIfCIc7nypYDeWNRbZi8i7Hmn1sBj7B45x86tOY17zanKGSYAf/33JVMsuTTVQc6y5bYFs8ev2n9FhuWTAihqk0Ggzikkxgrcovbg6Hheib1OpdoyO3lSxhMHhJlFpz/gfT3e3ucSzZJlHSuT0rT+V+9+7trR0f6Xw11PE7+TXe7syzssMkElM2lmJy8+VcePzo6//nchRQmLl6IBEkFH0IUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4NC6ZylK4Z2A1jSbCFVhJKADH55layrP/8EYf6vEQM=;
 b=Ue+G70iAI74ey8pbtDjbi1MB2+pXpV5+oNxW1QCY3UkXPXRZtRBrnVm3gODJA8EutwRyN70kP3m45TbRCiNQDcCe6xcxo1lSS/OONv/NtnNgozbG+eaveIdGOW5JnT26UP/cv52r8m7bRKedLar6zGG1ekiW3bABn0kt8PEBa+Z9F5KGeEnC3aM34mGsXuf9ZDyYvo5yshpoU6bBhnVWFkgZshqJ+YwhzkXshtCc5aQVqmTjO5jP2Jy5nYyJJdwhXvuaQI7N1G2C75+XzP3gCkLemmQsteqOz9XappF16n1gGcj/QCe5lSv89i1Fdx696bPUmb8Ggx5WPwztY4ptVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4NC6ZylK4Z2A1jSbCFVhJKADH55layrP/8EYf6vEQM=;
 b=Ev5lq/aegmspoF4knsDut1CrcoAzN8u69pkonU80zCxFjFh08NLorE/R82Z3rnjXk0EvqKkwC6Qpe3yquRGOq9kW1GRS7YgeIYe+9CvftAUJ1uWsGSh81cGrxu2LrclMup/BXddDKsMotUU/QofJuuyWO5OKFA6jnBmUfE4/s6o=
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 19:48:27 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::9de3:cd20:5d34:3ca]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::9de3:cd20:5d34:3ca%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 19:48:27 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Topic: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Index: AQHWJ8s/gnWcb/5VT0aeBl48VaUdAKijShQAgAAAP5A=
Date: Mon, 11 May 2020 19:48:27 +0000
Message-ID: <SA0PR12MB43493D1ED5333EFF4170B001F1A10@SA0PR12MB4349.namprd12.prod.outlook.com>
References: <20200511192853.11150-1-hanghong.ma@amd.com>
 <8954f030-f222-60d0-21ad-bb7155c67440@amd.com>
In-Reply-To: <8954f030-f222-60d0-21ad-bb7155c67440@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-11T19:48:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cc364026-d09a-4180-9460-0000f9f55362;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-11T19:48:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8b8286e5-3295-40bf-9dab-00006a64d084
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a8acbd8-eec5-4361-60ca-08d7f5e44617
x-ms-traffictypediagnostic: SA0PR12MB4543:|SA0PR12MB4543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4543561A9B63A1C35160EE63F1A10@SA0PR12MB4543.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9SrFHiX3zv9A0WXQ41wSgkh8sItqdOugj+8JWQd5a+7bRkYKcDqefAa53v91Nn4pVco33gXMTIibCpKBSNZJT8DymR/FW+Hebzhzmyh3512peoYKt+QI/PDnW2SGIvE0haW6SfF6LbheQtcvTSK/zo5Oz0xUSK3c1Sc0s3kzZXU2LHtJhJwqE31XU/HzRS3U3/IxCjdUukVxsd9AvfmnpQ2yzcxsnZRcjvvvUpwIkd0hka3j7h/JVE6T1s6YaUIYatPNCi6mpEEOFNGFKveKk6BDxD4o4rcLxHIr9t9qDwMmKAA2C/6UuoHzHWCU2FnpO9CQXVf1caqLfyP1FIhsavYang/7XKqIzYpZEiD7qeH3Uqff/jdvgFdy8CdJ7GWen9fTaQn7xGtSvcI62gQlkxYHtvLOcFALv4+jYgIJfjwj7Xbn0nazq+dObAwj8zHOOmY3iskgKS+a/VNudDV60QLs6UIM2+A6zGOhBanZtPwQ3p2DOYD+M5SLgjQyhfbcasi1AuHMYr87YOqq/i4ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(33430700001)(33440700001)(53546011)(66556008)(66476007)(76116006)(66946007)(71200400001)(86362001)(7696005)(5660300002)(8676002)(15650500001)(66446008)(8936002)(54906003)(64756008)(55016002)(9686003)(6862004)(6506007)(2906002)(33656002)(52536014)(316002)(26005)(478600001)(4326008)(6636002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: K1oJ6Br7FXNKkc7d8WzL/ebJ2YKmDrRH19r4kEPvciFUtaYijdw6etD9tx1kbMZ0lIp77lwfd9bNib0+63YM5OdCkk0UTp55wfMZeanh0Tda2brnUIQlIpjEJhW7SxYWq9LZVv56+j7a/JWgagp5qNGotkYJlLuR8Wj4EI3QGk5Eq5HyF3iFCIJlfmLHzoEmzg1XhtBpDeYY396zA4pfaa/bE6sJLZ85ZiKgqd/kj0LziU3V3y4qqrQPvk6tXkDhd4K90kxcxSD2PktgLcOp5mlR37G0H/uik+gmphlPjia4z695n5BZ17R8tCy0aN1EL1dVpN9lfLG5/Od5i91RvOrBzdnw385yicMUAy80Rhx4j2iYdHK5fcgtVtgRDts77vzuUMVfZrJyAsyJVvDKoPwn+ApA4iRpxNxN/A7xG3zDEdzQS2CJ78Moq7con8WFCKrWZjQ06er5eNfvYQhfofsyb6/8okeIljCl/jf0dGOyfrKtRCqdt1ZBf1mOQlJ1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8acbd8-eec5-4361-60ca-08d7f5e44617
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 19:48:27.2544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFw4Er+in8Yjo3yY4aEkw3pkjyUTK0YDLF/t/LoyncUH/susNklSlfbBMz2HwUX+KcsSt+LqAy/4s5uxbXNS0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks Harry.
I will drop the Change-Id before merging.

-Leo

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com> 
Sent: Monday, May 11, 2020 3:46 PM
To: Ma, Hanghong <Hanghong.Ma@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic

On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:
> [Why]
> For MST case: when update_config is called to disable a stream, this 
> clears the settings for all the streams on that link.
> We should only clear the settings for the stream that was disabled.
> 
> [How]
> Clear the settings after the call to remove display is called.
> 
> Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375

Please drop the Change-Id before merging.

> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 
> +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 78e1c11d4ae5..dcf84a61de37 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -398,15 +398,15 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>  	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
>  	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
>  
> -	memset(display, 0, sizeof(*display));
> -	memset(link, 0, sizeof(*link));
> -
> -	display->index = aconnector->base.index;
> -
>  	if (config->dpms_off) {
>  		hdcp_remove_display(hdcp_work, link_index, aconnector);
>  		return;
>  	}
> +
> +	memset(display, 0, sizeof(*display));
> +	memset(link, 0, sizeof(*link));
> +
> +	display->index = aconnector->base.index;
>  	display->state = MOD_HDCP_DISPLAY_ACTIVE;
>  
>  	if (aconnector->dc_sink != NULL)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
