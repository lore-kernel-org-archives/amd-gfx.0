Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A91C2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5BC20740
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZOXeBNMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5BC20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4C26E827;
	Wed, 25 Mar 2020 19:38:34 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0846E827
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 19:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPHCJ8BAn9dXcC04Q997oMuhItj8CY7ulJvrs49/G8ZrDmizEAC7Pe7oTiSYfyHKRtoUCSzx/PP5N8/4k8rqSi53aoy8O0wQwuV8tXPZYCNHi6Fz3yuYdLUxKD+/dbCi9D15ckzNcSAdwGc4iuApvebjO0FuotnRBtAjJESF2G1lG2nXrnliwPOMuzDQb962uxoKGp/ISKhkw1TqhDQP3SNNQt78tBa83y49toINy0RiER9JWwlswuq0fPO6GxaQO4YMAWSwAlEj2r+IrWkv2nX57K8DD7KwYxFI/UrUdIdZ35mRGiWGbMlyc6N1sDyHcAH/1dEQIprb2p6biJi/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on30aniW1n5kWS4rSGVT7ZTVTdWqP7oGAXaIJ2aPr0A=;
 b=A8CDnBhaUiUrn72ZXzvBNYz1LcHVV3VFaePIATvFgVM3AGeqpSaXTvfcV1NxxQKdCGIjHmkrGdMJds8VdoOTO9IZRr1BnYZQLreDzVp7LZaBhTcatkXKWGSp5Z3qip2VBA2MYW/BFyfMgqi4s2BWpCc5R5adJbhbSGkJ+munn3HtlS6B//u/UTfEceu0eN/PGthp8mT3oaPtiDlnDH9d4BXp8ikdKxYgsO6ZVMfTGSrVIMkCpdbOkzJR2dYJQP/Wb9up26a68q8QxyaEMt8oscskU581KUSVFGH/pthv3xTlyAWwup8eozQB+POMVGlUOZNBbu8fx5Sbfm96LDfvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on30aniW1n5kWS4rSGVT7ZTVTdWqP7oGAXaIJ2aPr0A=;
 b=ZOXeBNMId1wEl2gEc9wFTL95k36xIg//qv4jFqQxuNcuo4yBY5bKasOLbIeiB2TApawwiost5tglO+sLgit7nIJpwlm/be9s3+5fpCutLzt3BUCNc349h5Te7E42tvjUyD5r8d3e3q2/C82ZG9z98FDyK2AEfzlGIAnIBYic2Q8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 25 Mar 2020 19:38:31 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 19:38:31 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200325192221.717578-1-tom.stdenis@amd.com>
 <MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <526289ca-f68b-43e0-7f12-4bde3094f576@amd.com>
Date: Wed, 25 Mar 2020 15:38:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:404:8d::25) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR04CA0075.namprd04.prod.outlook.com (2603:10b6:404:8d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Wed, 25 Mar 2020 19:38:30 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27e4d74e-c0f5-4792-ba80-08d7d0f4196a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:|DM5PR12MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23746DCC686E443395AA96AAF7CE0@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(956004)(36756003)(2616005)(186003)(53546011)(31696002)(110136005)(16526019)(966005)(19627405001)(31686004)(81156014)(8936002)(86362001)(6486002)(81166006)(8676002)(5660300002)(6506007)(478600001)(6512007)(2906002)(66556008)(69590400007)(316002)(45080400002)(66946007)(26005)(52116002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2374;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +b/VMrLSKSfPfh3zrIyEY/XF2FpFFlKE03iexayrjCZs6qiKcWjikXNdlU1wK+kcA/S6YSsIiepTyS9c4y5sg9mYn87B/wyZEhXBVxHnJ6LRRxar+fhkXed19Irr8oU9snsK9C//+PSsbChLBf/jEWNDjVbiLYqs8483KDX2V9TcOuUbat7kpAl0qORFM3d4QXRjbhEFdLgSEth6PfoIl1KSSXPAUTi+p55Yale58hHD1i8cxggAEvYJ57HJ2L5MdJnoUEZXwFSlvUd1KYDadO2uRRvmcSeLGT/b9uxK0sReNU4GRgNyjfgYHxl1GkHok4Ck1RBlVrqlb3VKAMkcT4lnNQwW56ptIAdbm/AOREPT/76W3tvMTnBraNhpdxNSeA4BdySMucSDMFIpHZ3Utqz0Q7Y2VsEvRuNFmzaPXCcOXLRsNBx21AfPR/0sgW2BBs+N8flKAkApw4/pD34CT9bfhEYKIj12TSpXKyPB200YJ+BTIqGvKEPXEcZ9A07dUM5V6VLrovWG3NtR725cZyhSb2hUTp+OetQ5UbENEE8=
X-MS-Exchange-AntiSpam-MessageData: aPc6wKezXYJr9rxXcoDJu8jiotMUjega6vM5JTUQe7VCAOGdPcR38qt3brPPYBMMkjS3d/wlIvT7yJZ4kx5jgnyZFR6ZOg/izVC5kgB7BJJebrJEiQUJwdejDyr3cBoRXrVExiKRyGnUprXzHGhlLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e4d74e-c0f5-4792-ba80-08d7d0f4196a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 19:38:31.4206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2gZVqoGF9A1fNvDqINHjeYR6+87JPpsXjNDwNCl2BTFfp1Eq5iYb+KWVkv1969fu03C23tihzgXki8//NYkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Content-Type: multipart/mixed; boundary="===============1316356431=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1316356431==
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020-03-25 3:28 p.m., Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          While you are at it, can you clean up the local defines of
          these registers in</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          drivers/gpu/drm/amd/powerplay/smu_v12_0.c</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          and verify that the appropriate offset is used for both Renoir
          and raven?</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I can absolutely do that tomorrow.&nbsp; I'd like to get my (v2) patch
      out though since it's gating an update to umr which an internal
      team is waiting on.</p>
    <p><br>
    </p>
    <p>As for the PWR register through um how shall I say &quot;sheer luck&quot;
      it actually pans out fine.&nbsp; The Renoir code paths use the vega10
      IP offsets and the PWR block's offset.&nbsp; Segment 0 of the PWR block
      from vega10 matches segment 1 of the SMUIO (v12) block.&nbsp; So on the
      face of it the CGCG code for renoir is &quot;wrong&quot; but because it's
      using the wrong IP table (which happens to have the right offsets)
      it works out alright.</p>
    <p><br>
    </p>
    <p>int soc15_set_ip_blocks(struct amdgpu_device *adev)<br>
      {<br>
      &nbsp;&nbsp;&nbsp; /* Set IP register base before any HW register access */<br>
      &nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
      &nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
      &nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
      &nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
      &nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; vega10_reg_base_init(adev);<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>
      <br>
    </p>
    <p>Strictly speaking this is wrong since renoir has its own IP
      offset table but because it reuses a lot of the KGD
      implementations from earlier hardware (and the registers happen to
      be at the same locations) this works out fine.</p>
    <p><br>
    </p>
    <p>Tom<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex<br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Tom St Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis@amd.com">&lt;tom.stdenis@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, March 25, 2020 3:22 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> StDenis, Tom <a class="moz-txt-link-rfc2396E" href="mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR
            Confusion (v2)</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText">The PWR block was merged into the
                SMUIO block by revision 12 so we add<br>
                that to the smuio_12_0_0 headers.<br>
                <br>
                (v2): Drop nonsensical smuio_10_0_0 header<br>
                <br>
                Signed-off-by: Tom St Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis@amd.com">&lt;tom.stdenis@amd.com&gt;</a><br>
                ---<br>
&nbsp;.../gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h | 3 &#43;&#43;&#43;<br>
&nbsp;.../drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h&nbsp;&nbsp;&nbsp; | 5 &#43;&#43;&#43;&#43;&#43;<br>
                &nbsp;2 files changed, 8 insertions(&#43;)<br>
                <br>
                diff --git
                a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h<br>
                index 327b4d09f66d..9bf73284ad73 100644<br>
                ---
                a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h<br>
                &#43;&#43;&#43;
                b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h<br>
                @@ -24,4 &#43;24,7 @@<br>
                &nbsp;#define
mmSMUIO_GFX_MISC_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x00c8<br>
                &nbsp;#define
mmSMUIO_GFX_MISC_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0<br>
                &nbsp;<br>
                &#43;#define
mmPWR_MISC_CNTL_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x0183<br>
                &#43;#define
mmPWR_MISC_CNTL_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                1<br>
                &#43;<br>
                &nbsp;#endif<br>
                diff --git
                a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h<br>
                index d815452cfd15..26556fa3d054 100644<br>
                ---
                a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h<br>
                &#43;&#43;&#43;
                b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h<br>
                @@ -24,5 &#43;24,10 @@<br>
                &nbsp;//SMUIO_GFX_MISC_CNTL<br>
                &nbsp;#define
SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x00000006L<br>
                &nbsp;#define
SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x1<br>
                &#43;//PWR_MISC_CNTL_STATUS<br>
                &#43;#define
PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x0<br>
                &#43;#define
PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x1<br>
                &#43;#define
PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x00000001L<br>
                &#43;#define
PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                0x00000006L<br>
                &nbsp;<br>
                &nbsp;#endif<br>
                -- <br>
                2.25.1<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C20b8d1812aac4516419c08d7d0f1de31%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207609564642593&amp;amp;sdata=%2BT3BSejxB%2F3MsW8lfqAZ%2BiFfMXVG394Atnxi3K%2Bhjs8%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C20b8d1812aac4516419c08d7d0f1de31%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207609564642593&amp;amp;sdata=%2BT3BSejxB%2F3MsW8lfqAZ%2BiFfMXVG394Atnxi3K%2Bhjs8%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--===============1316356431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1316356431==--
