Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1CC54E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95FB2075E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GZo07bdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95FB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D526E53C;
	Mon, 11 May 2020 19:45:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9FB6E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 19:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSOKpeMW9UJtk6+6pBW5duBPdtQ5KG/4oYTwz0SyhleUtdmptk28/dgFbL8iPcZwDafxa4WLJCKKxM3ryD80da64PUPec3Xi5+zRdw14vWwNzqZ1oDBxcYdLLIQUCrZvRewXoFwg5OoQlsm8BwFNvbemxt8LD+YFUnN7ExauJI78QwsbrG4sQSgxdMdVxbySDS5yz6k8hSlNCuht7cCGTf7lix1TSMJdjDOFvufi3tRVrUI09jyERk68nB0nPbI24W1GILUpY8tPT7QWT+/FRZ0hC/ozaM7AMqwTxPIhWzLkOFTMpQ42SxgyGJGx4vdfCTrIkYY8bl7a63SAn7vRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2HndifnzuE24N94cl9ojpX9QhDca9BoOnVTAqlVDjI=;
 b=d4+RAYN8LuJwn6a8VwTDKdEvsxKwIQfHmnbj2bfDLzDUghqJD3eiH2yw6kd/lUaRhNlOed8dwh/3Gl1bUQEKI4lqhFKcI1BZttSrtNXNrWjUsrCxR6ck5SDFcsL25hnj+OMXu/M+x0uy+js1Td8mU8mAmnyOaNZLSy2ucqR1ZpHaxTVH6ecGnXypMuETlAgkv+K2L8ZpWqgoU3x3BzGaTv7Dai9wybW79rhGjMHb03qhiYsw3C248KctP+4GrO48t1ZSwr0C1QHN8zPh+VyjWPg1QIaXF7DHxc3dek4OIpBs4E7Uzd7z1pzC5QhL22RgJD/P57ebffK3VP0fD0fGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2HndifnzuE24N94cl9ojpX9QhDca9BoOnVTAqlVDjI=;
 b=GZo07bdDT2rKSduZnWNIC7PSBJuKaqprjMRTiqCdMeewNDVvrnqUqx71mu/MZibGGeas0J04cKip42DN8hdVloriH0XYlNasdBYzniErW0EXumhto8CTmMUdjHci4VVuGYseBpRPqI67H7F2kisLclQ75QSDw/enLTH0VCLV+68=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 19:45:55 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 19:45:54 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic
To: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, bhawanpreet.lakha@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200511192853.11150-1-hanghong.ma@amd.com>
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
Message-ID: <8954f030-f222-60d0-21ad-bb7155c67440@amd.com>
Date: Mon, 11 May 2020 15:46:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200511192853.11150-1-hanghong.ma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.16] (99.254.88.27) by
 YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 19:45:53 +0000
X-Originating-IP: [99.254.88.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05142e14-7428-4da7-2706-08d7f5e3eaf4
X-MS-TrafficTypeDiagnostic: MW3PR12MB4426:|MW3PR12MB4426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4426586A94885EBECB8F5F298CA10@MW3PR12MB4426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwD7yF6DnptaxDxofB9dGrpC+RJZmrUeLnPWqwh7Z437eFE4pqiLMMP3kSQIGdZNgyTQMEC4Hk87MoiLXTtJctrPf+CFWqMU/eFW/Fo1LOluoHgHqgXeg0VqH2EjmmxTjkD+n3YzfoW++uSHkcCeu/oMndiAbczdqPH+ttAdegrW/FXOr6Irn5El6hFawbXBXzZepxLOTDifzkVdaotf06Ffx9+PBzdQhiZ1IutqwUKTigX/lkWAd/Y8VJ+Eh017G7VW+MYTpO/7hOwn935qNuWbY19VFNPPQSe1WFD3XUnojEPcQPYEVZv/1N0D+wR66vI41b7e4MDF9ALSMsaN1823jj3udh5//p7tZVf9QR1nVxASZEJbMvgUCx8+DVtHq9zBfdgbiXgCxVNndPmzxH8v3oSw2BtyyfbEV+alWXLkGgvif+yl00RY+onRWgIVy8fOc9vZ4ue2sIA4+J99tJaaMIFkLb35BW2O3zozrL9yVH2g1Z0vWXF6dpWQHPHxQTBA7GfAdkBJa0WyUH9D3YWa2BEQxg14JYe2/2jzwbreMAL4akwCvykG33Ka4rur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(33430700001)(2906002)(33440700001)(186003)(5660300002)(31686004)(53546011)(66556008)(16526019)(26005)(8676002)(52116002)(8936002)(6486002)(36756003)(31696002)(16576012)(4326008)(2616005)(66946007)(956004)(66476007)(478600001)(316002)(6666004)(15650500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4KKBdi3lRFFFqfUAJ5LFbGBlYNZn4Gsc3n0ZX7KL14UZKbj1ijmpotwEi2CtSvOij6wVy68zZwuJJXajUemkkH3+z7NZktDVA7nDVbWW8GGO9PhZ2bSLg0kw6A5oFiPB5qTkKfyZBR3plxaaIcHJf+6QEbaCOCL6WgFimGNilhm/O/kjx+xpGzz2NnA1eqOuHTiOdUoKNAeB/HDqNCDZxVtomc+8rPP33YstQN6iXVGGqww4MsUdPA5M3Tc5vaSVUM969jMu9tNcbD2U9PhwJSin0gmBWK3Xux9mZgeACuJ3ZyKKhLwAJ17QUNhRf0DmPX7wdIZC/8sTMxzRBWNu8ORB5f7LjssGBwvR+byWhnrS7db8y6xue0FjlETxpXSDocQhQ4JvFfLJlhGzNjEDXaXdqw6ufbfeqKF5V7/KRaWTV/HOEN2uk0JselsEFBWNJBFjWkwVi3TUFUbZuWzpWUc2o4y0ykIRolLRpKO2HsE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05142e14-7428-4da7-2706-08d7f5e3eaf4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 19:45:54.6705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02Z0N48AQiSrMilq54cskDb9gaH4fmSQawCz9Vz0NocobS+q0YwuGi1J+CGHkzLrrkdS0SpljmBtAiaKZRLsmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:
> [Why]
> For MST case: when update_config is called to disable a stream,
> this clears the settings for all the streams on that link.
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
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
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
