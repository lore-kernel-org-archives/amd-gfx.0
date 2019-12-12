Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A23C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 19:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225622173E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FBaaUO9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225622173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC03C6E194;
	Thu, 12 Dec 2019 19:05:26 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0FA6E194
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 19:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCSLXWHaeispEIbM3jkd6KRF0cbn0D3z12Ir/R4lsshabvPrAoNlOAQNvW4KBLdLYXYsRj3bpAy0Ynn6R80Nr+k+GGAwn5XDBmQdx9uu4NPd9cEldnxdiZf3T7JHjjWBkLyitbTQ+W4GxA9cjq73PBBc+9SNdMrm/Mq8D86G9UJ/GaLikw6mF3rGlcmLabxwRZL4h/qFcCtmsjU6xzE8YxJyQtVGqPFX4gM5oRqK6WGTam0KIjSnvqjWAFo5kp2ZVGNe4WRluVUQqKRlu1UFc2vKlB/IvF45QLPlCAhf1DqtuyZ5PmMVV/mSyLoX/iNbfs9hopa1fdYOeHa3w3KivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJhnKg2VCcytnx0jtUNk+lmVPiR6tFjv6/YA0qvFLps=;
 b=TpEH18slnvYu2MMCV5ZZbrMDPOEbHFqClY3YZWLClclkHj10G4M8O4/dpRxWdkBcl5Vjw+KRf2YuF4MgEYWPqL0vZ87T6eC1lTQAd7AkHEbr/Tpb1mvP2sBDa964dQ8MlKLw1TlAK5bEPOpjahe2lW910jPzzq57a7K/zT4gfFsQygpDocXy+4Ba56j86VhHVDaWOygfJrtRVTdyzwOA9f+CdB8MOclsT32oygIzjd4q1vg+8C0K3rSM/sdfqOQjRB7+r10Nz0reQ9QI+szzjcXJktc2fNKxqFUKz9zsItvEcOwoWJjLVE6TwdZytmT5EUSKTiXmi8vKklQI2g2arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJhnKg2VCcytnx0jtUNk+lmVPiR6tFjv6/YA0qvFLps=;
 b=FBaaUO9NzNfcN+IejTB/dgpBtSEidWiNhEWHX5dfVIUn+dK4F/irerfA87XbQkOtxT5ahc3mjmj+CVAPHN8tgMfCHkbAlUEfYiCYguJf1XuCI97X3Wu0O05vmbsHB1efald3p8LFyf5G62KcIE19ZxHt+djHHQdoQ+88xxmTiH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0150.namprd12.prod.outlook.com (10.174.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Thu, 12 Dec 2019 19:05:23 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d%11]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 19:05:23 +0000
Subject: Re: [PATCH 6/6] drm/amd/display: add event type check before restart
 the authentication
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
 <20191212170614.24837-7-Bhawanpreet.Lakha@amd.com>
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
Message-ID: <ad5640ca-52d8-9ea1-dd11-3d80461980ea@amd.com>
Date: Thu, 12 Dec 2019 14:05:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191212170614.24837-7-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f6efa06-555e-4564-31a5-08d77f363d6c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0150:|CY4PR1201MB0150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB015043FD15FB72B1EDD1A67F8C550@CY4PR1201MB0150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(43544003)(189003)(199004)(478600001)(26005)(316002)(6506007)(53546011)(2906002)(52116002)(66946007)(66556008)(36756003)(6512007)(66476007)(5660300002)(186003)(81156014)(81166006)(8676002)(6486002)(8936002)(31686004)(31696002)(2616005)(4326008)(4001150100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0150;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXB/DQPFj+XZLgARSf3RvOKCMUcVXVmCKuZSoMx0Nb0b8U8xoyg6PzQKSJTVcNoJJNCm/EaXnqYbeR9Y9aXC8E/XrxERyjTIw/EJSW6lpFhAjmgUl3fHFbaxUOIxcOsapNBod1lmxnbDk07FsGJiqLuoobEFdRYklrrfvi5AS6IGrlc2CLJb2lEXpTyozL4ZCQOZ4QKd5kKnN6IPDZfzxk18XJPZRB2NbQtUMj57/GxrPHx1VRYrRacjhWEAxykJVuxBydc6qqvf3ZbgtDraYXYEx7R2phYcVKbf7oOYA8DBEsIFhnEQoLtGLlzkZpvSxK+fA7D7NZr0TLhD34NVQvCc1Mi0L2kDTP61BbhCMW5+Tm6kkGc9/8j6qHtZXjLOdPEk1mJMGUbqRkaz95SllpgEkQazj1xpBx41ZSMt/T+osjrRVvMN0BQk76COmGQK4wGxdCGSyedJ7suZg8Y/eGroS1vuLmFP8+vPXSTPdPb27aPiSfIdk6VZU1bTfm4p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6efa06-555e-4564-31a5-08d77f363d6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 19:05:23.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v912j3RHQOedwz1SuJa7A2FMHSeD5ubqKDTaLxyP5MxWvgY+x8IzFa3zj00aWag0syXuC9mYJRWwgVh0DbgdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0150
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
Cc: Xiaodong Yan <Xiaodong.Yan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 1-3 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Patches 4-6 are
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2019-12-12 12:06 p.m., Bhawanpreet Lakha wrote:
> From: Xiaodong Yan <Xiaodong.Yan@amd.com>
> 
> [Why]
> Some combined docks will always trigger CP_IRQ but there's nothing the driver
> needs to take care of, but the CP_IRQ breaks the original hdcp state and
> triggers the driver to restart the authentication.
> 
> [How]
> Add the event type check before restart the authentication or resend the stream
> management
> 
> Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> ---
>  .../gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c  | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
> index da190739a969..8cae3e3aacd5 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
> @@ -630,7 +630,10 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
>  			break;
>  		} else if (input->prepare_stream_manage != PASS ||
>  				input->stream_manage_write != PASS) {
> -			fail_and_restart_in_ms(0, &status, output);
> +			if (event_ctx->event == MOD_HDCP_EVENT_CALLBACK)
> +				fail_and_restart_in_ms(0, &status, output);
> +			else
> +				increment_stay_counter(hdcp);
>  			break;
>  		}
>  		callback_in_ms(100, output);
> @@ -655,10 +658,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
>  			 */
>  			if (hdcp->auth.count.stream_management_retry_count > 10) {
>  				fail_and_restart_in_ms(0, &status, output);
> -			} else {
> +			} else if (event_ctx->event == MOD_HDCP_EVENT_CALLBACK) {
>  				hdcp->auth.count.stream_management_retry_count++;
>  				callback_in_ms(0, output);
>  				set_state_id(hdcp, output, D2_A9_SEND_STREAM_MANAGEMENT);
> +			} else {
> +				increment_stay_counter(hdcp);
>  			}
>  			break;
>  		}
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
