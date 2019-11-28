Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F8C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D4321774
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D4321774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E766E037;
	Thu, 28 Nov 2019 20:20:14 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720077.outbound.protection.outlook.com [40.107.72.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B596E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 20:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPV7fyTNfQfmGlRP/Vp1rltcTf9NfGtulLZR1zn8Q8gWVV/fbYFvXnZvFwVON9wwoMxZjp0emmXqSMMnI6IAtxUyK93zV5HT8wfHkW79fMs4TNDJiTbKPeyNo/WFc7A2/f8tr6r2iHs3AH5HDzwweoC2S/3RFKy/rcw8E73UIE50iK4WB/KsRLRB4pZaZSZwL3yE2ioZfJUOjaoSN4H5xkRdcGnHzTjD2XqXZYn5sSaa5CWFPE7GrXNx2XK+cZD71z3c57JzqL4shm+gaCcVZr3gBaCqtXNxkwQdS0qP7z3Yd+7Boy3G3GCRgKIOVmPVeQTK+9o1qSQJ10/g9S4z7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhN3UtejmypZ6vtl/uyWm6QbQaMg+Vm/WKjht7DUqI0=;
 b=Ob1M6MUNhEuhZM6zOT2yuNa+gvpJw6thBsYqW7+HtGE88OZLUcD8MQLyp6qNyphABdMfSWE9kjzBfQWIDWipSYlQTuP/QICs9qYIuhGzMqLXEl8RjnKr3Cc3ZbXoGznEnX3E1UNGT56ThBFYXPHdg0L2TLl7KXm/qJ1/RG6IYrpMhTFMkq4UBgeVH8lH7KaD8lLE5SGDaRBjHnPk1hgKKpDyrXSkvFWxPg8kSLu1XHJJi6rH8TfBNRdQcOgIYBhsMrYMqfMsFvftxspQtMDrx5e5qM5cvMRMopXPg0zGBoj9HTk3cW7ECqvs4vF8osiQVhroaYn+TmDJbyIIBghhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4231.namprd12.prod.outlook.com (20.180.17.216) by
 CH2PR12MB3783.namprd12.prod.outlook.com (52.132.247.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.24; Thu, 28 Nov 2019 20:20:09 +0000
Received: from CH2PR12MB4231.namprd12.prod.outlook.com
 ([fe80::4ced:894e:2bea:d5e4]) by CH2PR12MB4231.namprd12.prod.outlook.com
 ([fe80::4ced:894e:2bea:d5e4%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 20:20:09 +0000
Subject: Re: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <e883aa84-0a91-d562-3501-927cba50f61d@amd.com>
Date: Thu, 28 Nov 2019 15:20:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To CH2PR12MB4231.namprd12.prod.outlook.com
 (2603:10b6:610:7d::24)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c563ffc4-fb08-4d31-79bf-08d774405d2c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3783:|CH2PR12MB3783:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3783ACA02F8F46AB9F1A2936F9470@CH2PR12MB3783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(52116002)(66066001)(6512007)(14454004)(71190400001)(65806001)(8676002)(65956001)(99286004)(81156014)(6116002)(81166006)(14444005)(16586007)(478600001)(31686004)(37036004)(8936002)(2906002)(110136005)(966005)(2501003)(606006)(11346002)(36756003)(66556008)(76176011)(19627405001)(236005)(58126008)(6306002)(54896002)(5660300002)(316002)(105004)(3846002)(66946007)(6436002)(33964004)(53546011)(2616005)(186003)(7736002)(6506007)(26005)(6246003)(25786009)(86362001)(386003)(66476007)(229853002)(446003)(31696002)(6486002)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3783;
 H:CH2PR12MB4231.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zbm2xGOb55JnXVpJ3FPfIsc8umJKiFsopjfTxWvD+lPtCQ8dcoAOCmDPgqYXJd3qIpdvLHz4Yg39MIrOyoydky/0O11JtIxcdHWKEBaFp0oayqNsyI43TjkUX6nnNWQGQUhaS4Fb2osrs+Hoc+v9ONjRlac0WCDkrp8g2QXKUANyWgQPErh5KYKAZxqDc60S0dl8DNvUzAqTwSsawPHah7SZpIc8+Qrj/u1MoJwx/E7otBncxXzHRqxylICsz9Bw/OWvvzeY2yboF+GAqb8rkmAIX75z8wt8lR+eWcRb2+R/1MF1UR2XOsc8XG+3G0vtB2XIWaSdg2XJbCaxuRmt7iXHEBGYrwF2VsFPp0IW+4IVCEG/L9SkEfeT5aA6wCgm1PeE2ZQba+ndC49CiJAkeNxneFePibhNcitXmXDuU/69+WmZOpB/HDy1dbUMegKtEwcgdoF5ucwWo2ZIveHoqy9y5PaTa8uNC1lwlDLUB4Y=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c563ffc4-fb08-4d31-79bf-08d774405d2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 20:20:08.9345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riPWIrSW1lWQAmgwFDj3Yi9Lb4odM8osTfO2h9dGDaDHi6Jkp6QgrrkT9yBl9dD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3783
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhN3UtejmypZ6vtl/uyWm6QbQaMg+Vm/WKjht7DUqI0=;
 b=0XvbRkDHBY4JuvUy/haXhSWUBKA/4RwI/77d02IoedRSLaXa5Yfppm7tC3AVZjgn2I3MZXwV/JrlH76eQYKu0RQqa+f09DHfX74m0g7HZ+nuAeUUykxEofCQ71s7qz96lWWmfOVb6zf8neZWaAV64qOXAvgbHsLhr3+2EwtS0bE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2016313954=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128202007.MNWSXxy9tVGHyR9G4MAeb7-RA3W7Tczp8HWE-bKGELs@z>

--===============2016313954==
Content-Type: multipart/alternative;
 boundary="------------EFBA3E412223238D312E71DD"
Content-Language: en-US

--------------EFBA3E412223238D312E71DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Harry can you please take a look thanks

On 2019-11-08 5:01 p.m., Deucher, Alexander wrote:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> *Sent:* Friday, November 8, 2019 4:57 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> *Subject:* [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
> load the ta firmware for navi10/12/14.
> This is already being done for raven/picasso and
> is needed for supporting hdcp on navi
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c 
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index ffeaa2f5588d..daf11be5416f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -186,6 +186,31 @@ static int psp_v11_0_init_microcode(struct 
> psp_context *psp)
>          case CHIP_NAVI10:
>          case CHIP_NAVI14:
>          case CHIP_NAVI12:
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", 
> chip_name);
> +               err = request_firmware(&adev->psp.ta_fw, fw_name, 
> adev->dev);
> +               if (err) {
> + release_firmware(adev->psp.ta_fw);
> +                       adev->psp.ta_fw = NULL;
> +                       dev_info(adev->dev,
> +                                "psp v11.0: Failed to load firmware 
> \"%s\"\n", fw_name);
> +               } else {
> +                       err = amdgpu_ucode_validate(adev->psp.ta_fw);
> +                       if (err)
> +                               goto out2;
> +
> +                       ta_hdr = (const struct ta_firmware_header_v1_0 
> *)adev->psp.ta_fw->data;
> +                       adev->psp.ta_hdcp_ucode_version = 
> le32_to_cpu(ta_hdr->ta_hdcp_ucode_version);
> +                       adev->psp.ta_hdcp_ucode_size = 
> le32_to_cpu(ta_hdr->ta_hdcp_size_bytes);
> +                       adev->psp.ta_hdcp_start_addr = (uint8_t *)ta_hdr +
> + le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
> +
> +                       adev->psp.ta_fw_version = 
> le32_to_cpu(ta_hdr->header.ucode_version);
> +
> +                       adev->psp.ta_dtm_ucode_version = 
> le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
> +                       adev->psp.ta_dtm_ucode_size = 
> le32_to_cpu(ta_hdr->ta_dtm_size_bytes);
> +                       adev->psp.ta_dtm_start_addr = (uint8_t 
> *)adev->psp.ta_hdcp_start_addr +
> + le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
> +               }
>                  break;
>          default:
>                  BUG();
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------EFBA3E412223238D312E71DD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hey Harry can you please take a look
      thanks<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2019-11-08 5:01 p.m., Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
          behalf of Bhawanpreet Lakha <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a><br>
          <b>Sent:</b> Friday, November 8, 2019 4:57 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Lakha, Bhawanpreet
          <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a><br>
          <b>Subject:</b> [PATCH] drm/amd/display: Load TA firmware for
          navi10/12/14</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText">load the ta firmware for
              navi10/12/14.<br>
              This is already being done for raven/picasso and<br>
              is needed for supporting hdcp on navi<br>
              <br>
              Signed-off-by: Bhawanpreet Lakha
              <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a><br>
              ---<br>
              &nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25
              &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
              &nbsp;1 file changed, 25 insertions(&#43;)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
              b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              index ffeaa2f5588d..daf11be5416f 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              @@ -186,6 &#43;186,31 @@ static int
              psp_v11_0_init_microcode(struct psp_context *psp)<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name),
              &quot;amdgpu/%s_ta.bin&quot;, chip_name);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
              request_firmware(&amp;adev-&gt;psp.ta_fw, fw_name,
              adev-&gt;dev);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              release_firmware(adev-&gt;psp.ta_fw);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw = NULL;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp v11.0: Failed to
              load firmware \&quot;%s\&quot;\n&quot;, fw_name);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
              amdgpu_ucode_validate(adev-&gt;psp.ta_fw);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out2;<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_hdr = (const struct
              ta_firmware_header_v1_0 *)adev-&gt;psp.ta_fw-&gt;data;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_version
              = le32_to_cpu(ta_hdr-&gt;ta_hdcp_ucode_version);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_size =
              le32_to_cpu(ta_hdr-&gt;ta_hdcp_size_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_start_addr =
              (uint8_t *)ta_hdr &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              le32_to_cpu(ta_hdr-&gt;header.ucode_array_offset_bytes);<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw_version =
              le32_to_cpu(ta_hdr-&gt;header.ucode_version);<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_version
              = le32_to_cpu(ta_hdr-&gt;ta_dtm_ucode_version);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_size =
              le32_to_cpu(ta_hdr-&gt;ta_dtm_size_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_start_addr =
              (uint8_t *)adev-&gt;psp.ta_hdcp_start_addr &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              le32_to_cpu(ta_hdr-&gt;ta_dtm_offset_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
              -- <br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------EFBA3E412223238D312E71DD--

--===============2016313954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2016313954==--
