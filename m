Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C6C5517A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F9F205CB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w6X9JZUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F9F205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D5388C49;
	Tue, 10 Nov 2020 16:42:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690067.outbound.protection.outlook.com [40.107.69.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B67D88C49
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 16:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wkk8N5HVXoZKWW3Whq5Iazw7MOiklu64W/htQ42pMd97UvFsVs5Esl6Wk4MY/Hdj/jW/CEBkXYfyO/HFi7x3eEAKVplIfVUygYLrxPx6ZEG8dNlftSLOqojo7vfPVPt5+t3t0XY83LtaNdAQt9RjDgxQ9nenRwA95krYrPnBoSdZ0GnlicrKJbwv+2hxxQyFMW26u1nxl+5GTNOC+kihoWhyA1g13TMTkUaH06pjzn9oHXMn3VAUZwmw9OxAb8MqMBnSsUS0TqpSm7nVBERfpGyQbBus0biaqk/oD620ExVXh3igfWBhulhBIgpTewTEUQepbuh/03jawODNF8e+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfrrZgvRqSye/namK1rcaln9k14Q6x5J65WANYc/7Mo=;
 b=nJzQP5KyNKJhN/eTMaivJ2MlCx2yAD9ac9aPOO2JzBm8KJJjXgqblk79eMlSx2oi9+nJRygPZ85/QjwLkXptXhF1t/1phbk0fPzXL5ar9z9lWQQeH7Ooj4XotsehHG4u0Q0H9/E1q8abWN1xBknsNHngJ8V8AhHTVH+Yt3HTHqGXsNHUqVvLtTKfw/9Ui+kpe65Gg2qTuP/9oPSW7exg65kif9F/Yo8gdzs69LP2AtHdaTuluYHqWvXcMVQv36DbYSfxegSN/O8ZElH3O7B+vFlW6oo5Os62MKmf6fpMEVkiy3lGUqiVfBmEjlTgyxWzakia9gx2fnArbOLHfjlJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfrrZgvRqSye/namK1rcaln9k14Q6x5J65WANYc/7Mo=;
 b=w6X9JZUQ2tZg4hGbAky0unkXcsGitjZgrv8nj3rHL+9QISkl1EevxXiz6mwPcOBAFo+CrYpOq4kf9mSciaBDTRoufclHknQQsPB3WELD8yxzCwK2q3E1b9N7hY4V0T60s5KQinIGQOtgwuYvnb2FI/oS2/NwuCV5G5FFCuBH/KY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 16:42:33 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 16:42:33 +0000
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201110074912.54097-1-stylon.wang@amd.com>
 <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
 <MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <511c08b0-713f-2cb1-c323-5ea65a7f954a@amd.com>
Date: Tue, 10 Nov 2020 11:42:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 16:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f89618da-b645-482f-d19a-08d885979f1f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4556ABDDCF2163845CF2A5538CE90@MW3PR12MB4556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtoL8ePJVVP/nKvixx6h+YvvDG/g7ZU+txV3DGTsSAxIAFvva/NWmWPpiprY5g8/B1OG/ZOK6ApaPOezR43rU9XLoZ9Ov3mm3r0vHAx1oGTdZk1y0hw9YSRn3An9BNd4/iFdqFD+9xIXRPyK8oDGL40mrHe5T2b958R6fLnlYpb6XNe5ny5BE6pBGmQCzo8FUgefRTfV1kXKdjYFrOIbjMcdrgG3UMX/OX4FVdiJBvoAP1NUT5sgQmb9OJO3yAQlaM8/Sz5dHOOPEi9aVkzT0CYu43wURPEDWFjnNvyzQVlzDobOKop7IdTZ9BVfDm2uM6lh3nptx1zDnz4c7Jv8SvTPDvLd3TW3nyL6Tdp7aflkKhZ66guZIpZVA11oNO0S5da9Pkl/TwJxJFIc5UjipGX7QdwWtRHsyDYZZgEO+2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(44832011)(83380400001)(2616005)(478600001)(6666004)(2906002)(33964004)(8676002)(956004)(186003)(19627405001)(16526019)(26005)(8936002)(53546011)(36756003)(31686004)(66946007)(52116002)(4001150100001)(166002)(31696002)(86362001)(66556008)(66476007)(6486002)(4326008)(316002)(16576012)(5660300002)(110136005)(966005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PSl05sbnZlIYNEfFGqbOVkMJ043fNv+mno7it3CPjpTG9lQRuV8wagxpgu2z7ApnzCOj6ddtRKoWmaiDAa3lZerHUp9oJbqhyy5YDqgDfJXwgtFbRiL0CPoYmz9SOHa7FWLgSjeTg+z5JC2ZjkeqmNeKeR+OQfy3WkZeFAdPpoPRfz/V3bWWe1I5pKUW7OxTgpXQ6LkpGYe4uP3y+l9HiHkcqeppGQrrMf8Sw8GBVQAQuMB9GGdeIe4SypSpme8cD/7Z00kzlZhMb0xfNYBXVa6FPBiXDmdGP9zR5xShK1zxYQ4KGu9ln5mBeRX6L6WL7X3TMMrzZG1KTMLbpsSLijDv5m7OPs4QVF6CLoItTc2bi/r3FAc2NMH4D3jqVZEjIioz45r9KMDXZ9Okzai5BYU4dutv/RLFICq9fFEGRQ/hICO+G3STMCLQHfGU7MS5r2lmlyUNYKHiznZoHTGP6lZU8nj0Zn7lBnFCB27HuKNPswJsJfghtNNL3L9A9/ZzvULx14fPdYJNC7fNp4sz65MaQ07o1Gri0oiwGZiLtqsBmQEeYKwjKdLUKfV3nzu1UTquLemn1fzejAQ62H8KSO2OWBAnTLFiaEClK23QImW0BggCPhG1AzwdeyOn5wHU8+s8iddNcAB2J+2MbJuSrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89618da-b645-482f-d19a-08d885979f1f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 16:42:33.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYehWpncNHtwBNW7zKt1sJUv4FJm0mf8lJrO0jpteK5TW+tcDBhzmrWGddXSwLeKZ42hjgfedFeCQTru7OXprw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============2003454626=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2003454626==
Content-Type: multipart/alternative;
 boundary="------------D0F457BB606392A425E5F8D2"
Content-Language: en-US

--------------D0F457BB606392A425E5F8D2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

It's missing the "drm_connector_list_update" call which I assume is 
important.

Stylon, can you review Lee Starnes's patch? Is the 
drm_connector_list_update call maybe not needed?

Thanks,
Harry

On 2020-11-10 11:26 a.m., Deucher, Alexander wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Lee Starnes just sent the exact same patch yesterday.  Please review 
> that one:
> https://patchwork.freedesktop.org/patch/399497/ 
> <https://patchwork.freedesktop.org/patch/399497/>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Wentland, Harry <Harry.Wentland@amd.com>
> *Sent:* Tuesday, November 10, 2020 9:27 AM
> *To:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, 
> Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
> On 2020-11-10 2:49 a.m., Stylon Wang wrote:
> > EDID parsing in S3 resume pushes new display modes
> > to probed_modes list but doesn't consolidate to actual
> > mode list. This creates a race condition when
> > amdgpu_dm_connector_ddc_get_modes() re-initializes the
> > list head without walking the list and results in memory leak.
> >
> > Signed-off-by: Stylon Wang <stylon.wang@amd.com>
>
> Looks reasonable to me but haven't had a chance to understand whether
> this is the best solution.
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 0b6adf23d316..715e0bd489f8 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
> >
> > drm_connector_update_edid_property(connector,
> >                                                          aconnector->edid);
> > -                     drm_add_edid_modes(connector, aconnector->edid);
> > +                     aconnector->num_modes = 
> drm_add_edid_modes(connector, aconnector->edid);
> > + drm_connector_list_update(connector);
> >
> >                        if (aconnector->dc_link->aux_mode)
> > drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
> >


--------------D0F457BB606392A425E5F8D2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    It's missing the &quot;drm_connector_list_update&quot; call which I assume is
    important.<br>
    <br>
    Stylon, can you review Lee Starnes's patch? Is the
    drm_connector_list_update call maybe not needed?<br>
    <br>
    Thanks,<br>
    Harry<br>
    <br>
    <div class="moz-cite-prefix">On 2020-11-10 11:26 a.m., Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Lee Starnes just sent the exact same patch yesterday.&nbsp; Please
          review that one:</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <a href="https://patchwork.freedesktop.org/patch/399497/" id="LPlnk260581" moz-do-not-send="true">https://patchwork.freedesktop.org/patch/399497/</a><br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com">&lt;Harry.Wentland@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, November 10, 2020 9:27 AM<br>
            <b>To:</b> Wang, Chao-kai (Stylon)
            <a class="moz-txt-link-rfc2396E" href="mailto:Stylon.Wang@amd.com">&lt;Stylon.Wang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Kazlauskas, Nicholas
            <a class="moz-txt-link-rfc2396E" href="mailto:Nicholas.Kazlauskas@amd.com">&lt;Nicholas.Kazlauskas@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory
            leaks in S3 resume</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">On 2020-11-10 2:49 a.m., Stylon
                Wang wrote:<br>
                &gt; EDID parsing in S3 resume pushes new display modes<br>
                &gt; to probed_modes list but doesn't consolidate to
                actual<br>
                &gt; mode list. This creates a race condition when<br>
                &gt; amdgpu_dm_connector_ddc_get_modes() re-initializes
                the<br>
                &gt; list head without walking the list and results in&nbsp;
                memory leak.<br>
                &gt; <br>
                &gt; Signed-off-by: Stylon Wang
                <a class="moz-txt-link-rfc2396E" href="mailto:stylon.wang@amd.com">&lt;stylon.wang@amd.com&gt;</a><br>
                <br>
                Looks reasonable to me but haven't had a chance to
                understand whether <br>
                this is the best solution.<br>
                <br>
                Acked-by: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a><br>
                <br>
                Harry<br>
                <br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
                | 3 ++-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
                &gt; <br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; index 0b6adf23d316..715e0bd489f8 100644<br>
                &gt; ---
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; +++
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; @@ -2337,7 +2337,8 @@ void
                amdgpu_dm_update_connector_after_detect(<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_connector_update_edid_property(connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                aconnector-&gt;edid);<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_modes(connector,
                aconnector-&gt;edid);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;num_modes =
                drm_add_edid_modes(connector, aconnector-&gt;edid);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_connector_list_update(connector);<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (aconnector-&gt;dc_link-&gt;aux_mode)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_dp_cec_set_edid(&amp;aconnector-&gt;dm_dp_aux.aux,<br>
                &gt; <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------D0F457BB606392A425E5F8D2--

--===============2003454626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2003454626==--
