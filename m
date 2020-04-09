Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE31C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 00:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D055E20730
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 00:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R3XfHOgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055E20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACA26EB15;
	Thu,  9 Apr 2020 00:23:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328606EB15
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 00:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZRv4sJgFADVRWSrza8LD00vXESt4sA3IxQi/bOABP9iRjjOaxQxC6Lz9iC9OJzjgAsWtA+Uh/oETL7OH3q0vU7DZMYw2M5DheMCX3e8wBWYKQRji+0LZ7hyn1yNsvaOpG/gDDz8MPkUsS7qxkpxXoArjpUsfYLd3nHC+5/gg/V51HtEOTFMUPJ5mUceMDLGKnkoHbsjinJUFwvSa/iGUjQe0sLIFY5qtcYrVDtAgzYROfBtWHSbr4AQ45yvcnQfgHFlNNtRcH1loo+R9/6uBqfdhoZ++M8Xwbh6uEvefnHB3ki4PN2sm1Of/WFT2JVG/zC2Lhewpz3hIVPmUCtXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9wo2iWWTEKG7w2JD5/a0S1Ou8Tq6A4MpMhwDGW9ePw=;
 b=FLe1PgtoZt2bRatgBUyHO6E648pCRvApo5Ezs5hHpriunt2/ESURyqSipLkUkUkNfsY44e4tsYyDAA1203ulReJ5bXUXG83qvPWoFRD+2rCwPalI3P3Q8KUx4nEwVarwawXT4hU9Pt0RvDBic2SN1SL55YOzgSsWBTPL0FcXPsTC4tB29LCp1e1233kne3MyJ3bR9C0WBfD27e5ZOy23NNEdc4rVM7epdoT/C8KDH1j5YLyKm8DLG16XPyHmqHJpdR+Ao94PNfjx93FEq1rQ1aFuGWuPAaAYlog2Bw3btsn/lV4d9JLjVN6k8p8eAObOXAZY5qRATa3kE60uKArcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9wo2iWWTEKG7w2JD5/a0S1Ou8Tq6A4MpMhwDGW9ePw=;
 b=R3XfHOgXNMgT5rB9RtZQtiSVnaLzhv6G/ePe10ohc2/r1/EPdteQ48EyeiSDyBv9ebaW7RbwhaGOhmKr2TQ4KR25pvI90uaZxWfu6WWwyCA/ZMNNpqFuUh+ZB/c6fcKyHM39OoTcEhS5oSmPtzAMF0vwLx+JalO5uauisVu8ITY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 9 Apr
 2020 00:23:52 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 00:23:52 +0000
Subject: Re: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
 <MN2PR12MB4488FA323BA0F10D1D894BFBF7C00@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f44f6128-60f1-bfeb-b6e3-20c7ca16a689@amd.com>
Date: Wed, 8 Apr 2020 20:23:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <MN2PR12MB4488FA323BA0F10D1D894BFBF7C00@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: QB1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::21) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 QB1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 00:23:51 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 679526f4-109c-42bb-5877-08d7dc1c47d2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:|SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448440B7CAA5C2D09AC02B392C10@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(6486002)(966005)(45080400002)(81156014)(478600001)(2616005)(5660300002)(31686004)(31696002)(956004)(81166007)(52116002)(36756003)(86362001)(186003)(66556008)(53546011)(16576012)(8676002)(8936002)(44832011)(66476007)(16526019)(2906002)(26005)(66946007)(316002)(110136005)(19627405001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea9GcVPF67c5yq/Ehmker1B5DIJPWHkk70YCuyh8Cl1dY/deibnDyq9m34KDIzhzZPKgl4Fr+8uHzDhqKEOG3PUwmwtt4YOpmkN+OWhXQChlfocyPrnn56cU2UedMhea2to5alGtmvLgrpUE9iV0+8fWmgtdYFVoWv2QW+F7NSRkZFZRtuNKwPXHI6xlJrlkn6/k6fEOwq+Hd2Kp4jA2uZG2CSkYy0DimuI44ecK9JdCMqfFpYipEzKyoQOWk1aHMYGoN0f8b6HEEXTuKwKLETeRRPxEDbin10nPoGyNJN7IJb086KdxZnAEOs4O5OiX+5XavBItm4nR1UfwPcDQp4q+7Yao2ZGMn59CKgaJOBbgwZWb80uYX4oXymyanFzfVWUW/ijk3OfAKIUPwurul/DdzLsF1hhGzCec7szIbh3HsNhj2N7m+TKO5UeUxuui7y9d4ZgExpgjUbOyOoK7IMx1z2/ZODSaEvp3De8Cuxc=
X-MS-Exchange-AntiSpam-MessageData: KIZZaNDhudb1iidNE5bz3I4NrBLXjG/KJdNMIVXLIzVDwhSS0qgSm+hwn3LjLyYny2lDLHA6G9tFKTH3Vc+mh0Yzfx3IYPNL1O1uo5Tp392LBSNH9P7QcXy0spj4TFbqih38Bp4b4kmpabZfHgKM6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679526f4-109c-42bb-5877-08d7dc1c47d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 00:23:52.1095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9WP87f8aXV67OwNx4DFi99V/+Sv0ROh5oScexUCM4RjL8F1IC/g9w+AYhCHrNDqhe8b3yubz7IyTVCiJklWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Content-Type: multipart/mixed; boundary="===============0037268573=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0037268573==
Content-Type: multipart/alternative;
 boundary="------------50AFB72EA680F484BCD2112C"
Content-Language: en-US

--------------50AFB72EA680F484BCD2112C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit


Am 2020-04-08 um 9:27 a.m. schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Jack Zhang <Jack.Zhang1@amd.com>
> *Sent:* Wednesday, April 8, 2020 6:33 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *Subject:* [PATCH] drm/amdgpu/sriov move program of sq_config to PF
>  
> Since SQ_CONFIG will influence performance behavior, it's
> unsafe to program in VF. Therefore, program of SQ_CONFIG
> need to be moved to PF under siov. Skip it here in guest driver.

We'll need to change this register when the debugger enables address
watch. If this setting is global across VFs, it will be a problem. Can
this be saved and restored on world-switch so that each VF has its own
setting? Then you could allow changing it in the VF.


Otherwise we will not be able to enable the address watch feature in the
debugger under virtualization.


Regards,
  Felix


>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2d56b067..9bb89f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2575,7 +2575,8 @@ static void gfx_v9_0_constants_init(struct
> amdgpu_device *adev)
>  
>          gfx_v9_0_init_compute_vmid(adev);
>          gfx_v9_0_init_gds_vmid(adev);
> -       gfx_v9_0_init_sq_config(adev);
> +       if (!amdgpu_sriov_vf(adev))
> +               gfx_v9_0_init_sq_config(adev);
>  }
>  
>  static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C38604ab03f8142a547f808d7dba854d4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219388971131150&amp;sdata=gBSa%2BchPmFMSaTgAq8z5Sabs3G6ARuHN8wAPSi%2FoJqA%3D&amp;reserved=0
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7Cda6c5ebaaf6c4f1619f108d7dbc08d98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219493056058157&sdata=MAhOm9usqEEnTCO1XMxteWqFHMnlOeDG0V93sA%2BhE%2Bo%3D&reserved=0>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7Cda6c5ebaaf6c4f1619f108d7dbc08d98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219493056078139&amp;sdata=HCjruFYRNoF4bWVTCgwuxqk0h3dnxP%2FJBsq6%2Flr%2FFXw%3D&amp;reserved=0

--------------50AFB72EA680F484BCD2112C
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-08 um 9:27 a.m. schrieb
      Deucher, Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4488FA323BA0F10D1D894BFBF7C00@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Jack Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, April 8, 2020 6:33 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Zhang, Jack (Jian) <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu/sriov move program of
            sq_config to PF</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Since SQ_CONFIG will influence
                performance behavior, it's<br>
                unsafe to program in VF. Therefore, program of SQ_CONFIG<br>
                need to be moved to PF under siov. Skip it here in guest
                driver.<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p>We'll need to change this register when the debugger enables
      address watch. If this setting is global across VFs, it will be a
      problem. Can this be saved and restored on world-switch so that
      each VF has its own setting? Then you could allow changing it in
      the VF.</p>
    <p><br>
    </p>
    <p>Otherwise we will not be able to enable the address watch feature
      in the debugger under virtualization.</p>
    <p><br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB4488FA323BA0F10D1D894BFBF7C00@MN2PR12MB4488.namprd12.prod.outlook.com">
      <div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">
                <br>
                Signed-off-by: Jack Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 &#43;&#43;-<br>
                &nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
                b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                index 2d56b067..9bb89f2 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                @@ -2575,7 &#43;2575,8 @@ static void
                gfx_v9_0_constants_init(struct amdgpu_device *adev)<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_compute_vmid(adev);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_gds_vmid(adev);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_sq_config(adev);<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_sq_config(adev);<br>
                &nbsp;}<br>
                &nbsp;<br>
                &nbsp;static void gfx_v9_0_wait_for_rlc_serdes(struct
                amdgpu_device *adev)<br>
                -- <br>
                2.7.4<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7Cda6c5ebaaf6c4f1619f108d7dbc08d98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219493056058157&amp;sdata=MAhOm9usqEEnTCO1XMxteWqFHMnlOeDG0V93sA%2BhE%2Bo%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="LMSc7q8PYLxK4VsGcI6XfAZQtG7rlmiyHEpcW&#43;bvBV6Uv3wvMnT2iqo8SBKx4q6SWK2ggBvSyYJkp0yNstoD1lCG9pngWlwgnuQE8pgnwscW0ZvEmt8gFATrkA/NGHr3jjgQT902LStCeGvMk8AEEn6XDq6h/91O9Hahv6zASeg=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C38604ab03f8142a547f808d7dba854d4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219388971131150&amp;amp;sdata=gBSa%2BchPmFMSaTgAq8z5Sabs3G6ARuHN8wAPSi%2FoJqA%3D&amp;amp;reserved=0</a><
 br>
              </div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7Cda6c5ebaaf6c4f1619f108d7dbc08d98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219493056078139&amp;amp;sdata=HCjruFYRNoF4bWVTCgwuxqk0h3dnxP%2FJBsq6%2Flr%2FFXw%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7Cda6c5ebaaf6c4f1619f108d7dbc08d98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219493056078139&amp;amp;sdata=HCjruFYRNoF4bWVTCgwuxqk0h3dnxP%2FJBsq6%2Flr%2FFXw%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--------------50AFB72EA680F484BCD2112C--

--===============0037268573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0037268573==--
