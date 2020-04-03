Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD2C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCA5206E9
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKh0jBA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCA5206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF636E161;
	Fri,  3 Apr 2020 16:02:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AF56E161
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiJefUYPjlLmNzZpNUftqYRJqocj7W157R9p5hkDYItcVy+AfVLQgKXTqU5rcev2AA/5upSJZiD02L+KBc7gPtPrwJB3/O8aIBZh5yZh/CaPpEd8mZwQXV/+3vLehvPrIGSxD779fuwFuNCcqp0E9f8Z2jTQP8rGmB9WU7bPk32LthBl5VTgpj53DYBG7lkYVnrRSGncbfWl0fImBPRnKvQx5xAlgswGfXwj5XgYzqdEZybsUmAS9OCRrZYOhdXKgknDtK23PgZpkoMZF/IEd0NkZ5ctVECN9Sv3QPtyn0/5g9mCeWXDXUSMOHLNBE8xfkOsuCJCqRUILcVZYsFf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW7Ip6HPkViSlZwSicNmCECrHlZyqfb39+jrvO2x/ek=;
 b=C7BEFPjyZpNmDQJkssYWc+3Yq1ZiuhQmrQPa12hMkCHwpMdkgLUduxFQkOpbKwmXtAJXUeNDIG7UWnNGe3L5UN43pDax2acAnXMf4/rZiZXczw0Qnh2rSrMPvyqdwQ2xzPWvvKQOXS4/aGKjuIj4yhmRjKtLfhYSwOZ9txgF4BaYpVommSVVqTuwyP9ifcfRUAYED9CnMifv5UToAjaHbO/37cgrEcC/4JY0d9o3rwqKhbRtVfZO3fqZhvvvkACh9O+0/Wi6RhudZCyVrxnGhMHe97rEVLlpE4KbVyTkXUHGQsS77il8De10V0hbe7GhNLtiAtmSfAg++XM1qepWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW7Ip6HPkViSlZwSicNmCECrHlZyqfb39+jrvO2x/ek=;
 b=rKh0jBA5ejxz3bghWG7LUEIFO34jTmjlwVbJ3YnopGFdkuiYy/BMv528+oa43I7vw16vSAtBfMj7P2k5Ws7ZmheZewgsV0ha/Ysn2kK/eY5Xr3evFbAzQDcEyKxNKIdVpPd67Wi+E4bwQOR6R5HNGAsRogHNJ/q2lTC1nQglcgE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 16:02:34 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 16:02:34 +0000
Subject: Re: [PATCH] drm/amdgpu: fix size calculation in
 amdgpu_ttm_copy_mem_to_mem
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200403152147.1485-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b0c955d4-accf-684e-0367-339b751dc1f8@amd.com>
Date: Fri, 3 Apr 2020 12:02:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200403152147.1485-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Fri, 3 Apr 2020 16:02:34 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 058d1287-c500-407c-4d27-08d7d7e86c58
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:|SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB236596BA66AB22866A7E111492C70@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(81156014)(52116002)(44832011)(81166006)(2616005)(956004)(66476007)(86362001)(66946007)(4326008)(186003)(2906002)(8676002)(66556008)(16526019)(26005)(66574012)(6486002)(31686004)(8936002)(16576012)(31696002)(36756003)(478600001)(5660300002)(33964004)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdXV/60iDYrloL/wqwOYcuAzfUYwCiIqv9+sZRXoZSp2w9L5GJB2+t8E5t678SpwxFuvxFykfigm9fryfRzLISQJUCHPDSPRIBlZhCTEIZPrTVDk+vZWhw4aalVg9oPrOI66a0441GNWm/HzN2qalEiPlKyACWtUjXXVSdxLjIRibFdXzQAlx8Qyb3DcJqHdbJE1H5ZBUeXNdfQ7jE/fTkOCus0LM5Onnw6nL5D/sR95X2Ua4rwbiyJN92ivBEZaLllZ29mC8KO3G+wrYQ7OwL7YrQOhrwOYmY28FD7SVZpKrf/MxZ03wsm0w00Q1dQ9QoHNBkCV5s7N+IGB6tM0pQqQjmuKoBVf8YYDX0Ph9GUG0kD/007FGNbT+YEYewWIeqi4TCNDxSIEPlsDBHyodGjzbO/LNuRZ9M3ikHjtgIADmOigMaOJvQZarzlJYuzW
X-MS-Exchange-AntiSpam-MessageData: 9qFx+KXs1Qzwe9NAFISk4BI/tuSMblX8FTva82tu1kzIqpIDstabKSP1wepqtr4Y8/CID7QqLncu3Rl21HP7iCCVJ0XBCpVJz9C+0aWMSHwzhc65CvKGmnnKhtP4jYJZZkoxZUJ99SM+BIyZdnM0Sw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058d1287-c500-407c-4d27-08d7d7e86c58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:02:34.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQErA9H0Kzr8eMylXvyPWqTebxqOrocQpAqpDFBSFqxZJeo7pP2X5Tfy60uiwPB9KylT0s9GBmBBPrB7jj0TRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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
Cc: Candice.Li@amd.com
Content-Type: multipart/mixed; boundary="===============0314289847=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0314289847==
Content-Type: multipart/alternative;
 boundary="------------4701843B1422146FC8FAA532"
Content-Language: en-US

--------------4701843B1422146FC8FAA532
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 2020-04-03 um 11:21 a.m. schrieb Christian König:
> When the node is larger than 4GB we overrun the size calculation.
>
> Fix this by correctly limiting the size to the window as well.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 029b661faef6..1b658e905620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -454,9 +454,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>  		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
>  		 * begins at an offset, then adjust the size accordingly
>  		 */
> -		cur_size = min3(src_node_size, dst_node_size, size);
> -		cur_size = min(GTT_MAX_BYTES - src_page_offset, cur_size);
> -		cur_size = min(GTT_MAX_BYTES - dst_page_offset, cur_size);
> +		cur_size = max(src_page_offset, dst_page_offset);
> +		cur_size = min(min3(src_node_size, dst_node_size, size),
> +			       (uint64_t)(GTT_MAX_BYTES - cur_size));

This makes me wish for a min4 macro. I think the most efficient way to
write this would be

	cur_size = min(min(src_node_size, dst_node_size),
		       min(size, (uint64_t)(GTT_MAX_BYTES - cur_size)));

Either way, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>  
>  		/* Map src to window 0 and dst to window 1. */
>  		r = amdgpu_ttm_map_buffer(src->bo, src->mem, src_mm,

--------------4701843B1422146FC8FAA532
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 2020-04-03 um 11:21 a.m. schrieb
      Christian König:<br>
    </div>
    <blockquote type="cite" cite="mid:20200403152147.1485-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">When the node is larger than 4GB we overrun the size calculation.

Fix this by correctly limiting the size to the window as well.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 &#43;&#43;&#43;---
 1 file changed, 3 insertions(&#43;), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 029b661faef6..1b658e905620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -454,9 &#43;454,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
 		 * begins at an offset, then adjust the size accordingly
 		 */
-		cur_size = min3(src_node_size, dst_node_size, size);
-		cur_size = min(GTT_MAX_BYTES - src_page_offset, cur_size);
-		cur_size = min(GTT_MAX_BYTES - dst_page_offset, cur_size);
&#43;		cur_size = max(src_page_offset, dst_page_offset);
&#43;		cur_size = min(min3(src_node_size, dst_node_size, size),
&#43;			       (uint64_t)(GTT_MAX_BYTES - cur_size));</pre>
    </blockquote>
    <p>This makes me wish for a min4 macro. I think the most efficient
      way to write this would be</p>
    <pre>	cur_size = min(min(src_node_size, dst_node_size),
		       min(size, (uint64_t)(GTT_MAX_BYTES - cur_size)));
</pre>
    <p>Either way, this patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20200403152147.1485-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(src-&gt;bo, src-&gt;mem, src_mm,
</pre>
    </blockquote>
  </body>
</html>

--------------4701843B1422146FC8FAA532--

--===============0314289847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0314289847==--
