Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C74C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 18:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5302227F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1/eNMgkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5302227F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305D46E9E8;
	Mon, 16 Nov 2020 18:06:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6926E9E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 18:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/8qTeG9cadQ9hVLeReag3LqFIz+rnDdcwQ9eXxR02aAU7I7vhiH4bPdE4JgTV+foIuafbkowvuCRTU26zA5FGBecm56a174/8gCdAtHFWQFkHOuICYAmbVuaGwaMjdFnLX9gkqDG7HOPTdPTYwQ49sVHlmY0KoKCyEuT8XbV9ytyjefelpONKoi5KYLjCg4iwv4iGHLNY/QhlugsWIg5F+2a2EYU3tGfcl0ikRDg1V0El+FLTH/xe5MvO6z02J8riISFW1SL9kiCayGUKsTyJRmbBhs/LVjrxrCi3AGyccUcERy+R1p+zT5TKWRw/V2cLzm4AV+fJht7DbgNJH85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ7HrAtekJi83OILybOFaxyVEXd+stwlq2tstUPJFZg=;
 b=dtN9JEVgl7fP9PkY/CKo13g2sMhpDp7T+6yAjNlMX3rgNe4XjnhSO5lc21we3hfozMw1mpNGmJAA4gNT3YJK2BvK0AiiFAXvv4NDJtwZhOX6q0xZsLy4PCEpOJs2LNFdf7quLVD1iMTF8qEzri2hNn94nJhBjk2u3ju98RzP6a4aOweX+yAqDlu30WM/jUqUEQzcS2TxCA43eIrYQNfa+jICYJPIzp3If9CdD9D2vypA/O12nTc+tJptQEDuXm6Ji1baSZx+Vi0Ao5ewTJdeRl2jvWrsTPoEqpzsFf+UBKJ33HHvwcRMBOQelp0DOxXAUVm4l2+7dCgvzQ0OScxuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ7HrAtekJi83OILybOFaxyVEXd+stwlq2tstUPJFZg=;
 b=1/eNMgkJzZTlunCtLf+dPIFde24MAoJVsR2VxMoz4ZULiuLx7vaBbK++lACSVqOy1ouLsulYmPZAP+PEZXanDVvVtP+Ddz78cEsiySJOLS25shAO3GmvFpuXC/Y6b3gHvacjMKvbXHFMWAORCheN8ylZ6GFzA7t7w5oadL8smGU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1306.namprd12.prod.outlook.com (2603:10b6:3:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 18:06:15 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::24ac:3d8c:c5ab:63ad]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::24ac:3d8c:c5ab:63ad%4]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 18:06:15 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume fail
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201109194101.7082-1-sonny.jiang@amd.com>
 <DM6PR12MB343394680382B27D3128528AFDE60@DM6PR12MB3433.namprd12.prod.outlook.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <9e98a11d-b9bd-35c1-73ee-c00fd6cc47af@amd.com>
Date: Mon, 16 Nov 2020 13:06:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB343394680382B27D3128528AFDE60@DM6PR12MB3433.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:a3c0:342c:bd59:7df7:c1e8:19c0]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a3c0:342c:bd59:7df7:c1e8:19c0]
 (2607:fea8:a3c0:342c:bd59:7df7:c1e8:19c0) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 18:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b13b4ee0-0584-4683-d0b3-08d88a5a4efa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13067F590D266DF15CDB5D35E5E30@DM5PR12MB1306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43v10c8ErIQ7Zj38oxJvGCqx4qLfdnINA3JLUyPE+MwRHmnbpkumOEPKkqUfg+3nYn2+VnBP+fbIIBoKncKlKPjJVqK8rSW45knqioSYcWNsOraoNd3x1aXNSAwuEK1fIkTWA/NOfCvVREb019sWk3ulF6NuKYN8i2AlreW0YgrFH/RJI3UuS6K+Xr3SrjrM+h7pgiSWb0b/KWrjkroSoTKlHXvV9yhyc4mrxioPlpue184lxiZ+q+6JCMvivglD/M+CHzBsw1Oa+zUB5/iCglmGrIHfDegAqg1XdcxbDAtv7FpPmPPwVvhuB5iS6Ge1cJH9Zwjf35nnckviDv//VfV/MTICS1Kkj7uTgthsevs5X4cjKzXpz1L4AfJ2uSBRb8WtT6WUlTM6ItqzBNDU4cSkmJhR8C2EPPsDCqDjxNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(52116002)(19627405001)(53546011)(110136005)(316002)(15650500001)(186003)(16526019)(31696002)(31686004)(44832011)(5660300002)(66476007)(8936002)(66556008)(86362001)(2616005)(8676002)(66946007)(83380400001)(36756003)(966005)(478600001)(2906002)(6486002)(4001150100001)(45080400002)(166002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: h+T0sZVA5Bx1PTK+Ss/Bn7cHIryuKLvmX52Ir0E5dJHFhOfv4VXkhYvOADAsaBFzkVJrpHxvdq0QAJqs/3dIuy9dD+vdkjGHE5vCFhZMx9Q+mBttBfMkspnPul6IZsd0aR/DwxdG02kPmpyaQFODIRfeowEF2P38h/j5G8ffcUZEocBICJKhqrpn/L5g2jtu5uoWNsk8kQwVd1owoN5YJdECX3HEeiIHfPXZqy505ex98uRE33S/XChgScCkRdaaxghFZe0DHXdpLC/ZJFjNNmn2wfCxPn1v3jIHWq+vG6oGq9kbcQfzOcgwW9dvUy0TUxQ5+TFHmycuAs/PKEiorta76323Ux3E8VJFykzYIuUUpP4smUIOCAfJS0UH8IDizIzkIeo0SIKu9Qr6EKOl3Zg16lCex6a5mmzeiQo93rgjraZWotGNgDtMl/b8YbAONiEdS2sdxVkaQDSibS39M0i8MdDI8fQryS7A/LVS8yC4nSmMSl15OykFZ9CFZTob6sl6pM1qONOeLeTE54NrczN99QgiNKcmllCMFLzlTCjXzxIL77Zq4pyCc3tEWgEQRsQ57fo/oVbbNluesLG38S6raljfob80pW2L+qCF6Sv+8WEOMS4W8WrGp8d3HIcVvOu/8vLMY7sv3G5KOhHimDNARnow1WyEKhTy9vNk+G96HpvRGjq7Ku584+zZ1Yjtbzl3Nx0rcJBb/YHQoUY3BA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13b4ee0-0584-4683-d0b3-08d88a5a4efa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 18:06:15.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/+eXtJhZXylmWlUNZ2p4erkW0BW7bKb7UlY4vZPtCM6uSGGx8Q4vBHw4cV5uA3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
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
Content-Type: multipart/mixed; boundary="===============1452889328=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1452889328==
Content-Type: multipart/alternative;
 boundary="------------48E239069FC86F1225946064"
Content-Language: en-US

--------------48E239069FC86F1225946064
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Leo Liu <leo.liu@amd.com>


On 2020-11-13 5:33 p.m., Jiang, Sonny wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Ping.
> ------------------------------------------------------------------------
> *From:* Jiang, Sonny <Sonny.Jiang@amd.com>
> *Sent:* Monday, November 9, 2020 2:41 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Jiang, Sonny <Sonny.Jiang@amd.com>
> *Subject:* [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume 
> fail
> The SI UVD firmware validate key is stored at the end of firmware,
> which is changed during resume while playing video. So get the key
> at sw_init and store it for fw validate using.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   | 20 +++++++++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index 5eb63288d157..edbb8194ee81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -67,6 +67,7 @@ struct amdgpu_uvd {
>          unsigned                harvest_config;
>          /* store image width to adjust nb memory state */
>          unsigned                decode_image_width;
> +       uint32_t                keyselect;
>  };
>
>  int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 7cf4b11a65c5..3a5dce634cda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -277,15 +277,8 @@ static void uvd_v3_1_mc_resume(struct 
> amdgpu_device *adev)
>   */
>  static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
>  {
> -       void *ptr;
> -       uint32_t ucode_len, i;
> -       uint32_t keysel;
> -
> -       ptr = adev->uvd.inst[0].cpu_addr;
> -       ptr += 192 + 16;
> -       memcpy(&ucode_len, ptr, 4);
> -       ptr += ucode_len;
> -       memcpy(&keysel, ptr, 4);
> +       int i;
> +       uint32_t keysel = adev->uvd.keyselect;
>
>          WREG32(mmUVD_FW_START, keysel);
>
> @@ -550,6 +543,8 @@ static int uvd_v3_1_sw_init(void *handle)
>          struct amdgpu_ring *ring;
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>          int r;
> +       void *ptr;
> +       uint32_t ucode_len;
>
>          /* UVD TRAP */
>          r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 124, 
> &adev->uvd.inst->irq);
> @@ -560,6 +555,13 @@ static int uvd_v3_1_sw_init(void *handle)
>          if (r)
>                  return r;
>
> +       /* Retrieval firmware validate key */
> +       ptr = adev->uvd.inst[0].cpu_addr;
> +       ptr += 192 + 16;
> +       memcpy(&ucode_len, ptr, 4);
> +       ptr += ucode_len;
> +       memcpy(&adev->uvd.keyselect, ptr, 4);
> +
>          ring = &adev->uvd.inst->ring;
>          sprintf(ring->name, "uvd");
>          r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> -- 
> 2.25.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cleo.liu%40amd.com%7C695a4d51b81b4a08dbe208d888242256%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637409036097906257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8u1TK45gYH0hQ8dn5x1A9ckXIYQjGCedmkp8mpt4EW4%3D&amp;reserved=0

--------------48E239069FC86F1225946064
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p>Reviewed-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu@amd.com">&lt;leo.liu@amd.com&gt;</a></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020-11-13 5:33 p.m., Jiang, Sonny
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB343394680382B27D3128528AFDE60@DM6PR12MB3433.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
          [AMD Official Use Only - Internal Distribution Only]<br>
        </p>
        <br>
        <div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
            Ping.<br>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
              Jiang, Sonny <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a><br>
              <b>Sent:</b> Monday, November 9, 2020 2:41 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b> Jiang, Sonny <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a><br>
              <b>Subject:</b> [PATCH v2] drm/amdgpu: fix SI UVD firmware
              validate resume fail</font>
            <div>&nbsp;</div>
          </div>
          <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
                <div class="PlainText">The SI UVD firmware validate key
                  is stored at the end of firmware,<br>
                  which is changed during resume while playing video. So
                  get the key<br>
                  at sw_init and store it for fw validate using.<br>
                  <br>
                  Signed-off-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonny.jiang@amd.com">&lt;sonny.jiang@amd.com&gt;</a><br>
                  ---<br>
                  &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |&nbsp; 1 +<br>
                  &nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c&nbsp;&nbsp; | 20
                  +++++++++++---------<br>
                  &nbsp;2 files changed, 12 insertions(+), 9 deletions(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                  index 5eb63288d157..edbb8194ee81 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                  @@ -67,6 +67,7 @@ struct amdgpu_uvd {<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_config;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* store image width to adjust nb memory
                  state */<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode_image_width;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keyselect;<br>
                  &nbsp;};<br>
                  &nbsp;<br>
                  &nbsp;int amdgpu_uvd_sw_init(struct amdgpu_device *adev);<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
                  b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
                  index 7cf4b11a65c5..3a5dce634cda 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
                  @@ -277,15 +277,8 @@ static void
                  uvd_v3_1_mc_resume(struct amdgpu_device *adev)<br>
                  &nbsp; */<br>
                  &nbsp;static int uvd_v3_1_fw_validate(struct amdgpu_device
                  *adev)<br>
                  &nbsp;{<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ucode_len, i;<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t keysel;<br>
                  -<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr = adev-&gt;uvd.inst[0].cpu_addr;<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr += 192 + 16;<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;ucode_len, ptr, 4);<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr += ucode_len;<br>
                  -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;keysel, ptr, 4);<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t keysel = adev-&gt;uvd.keyselect;<br>
                  &nbsp;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_FW_START, keysel);<br>
                  &nbsp;<br>
                  @@ -550,6 +543,8 @@ static int uvd_v3_1_sw_init(void
                  *handle)<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                  amdgpu_device *)handle;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ucode_len;<br>
                  &nbsp;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UVD TRAP */<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_irq_add_id(adev,
                  AMDGPU_IRQ_CLIENTID_LEGACY, 124,
                  &amp;adev-&gt;uvd.inst-&gt;irq);<br>
                  @@ -560,6 +555,13 @@ static int uvd_v3_1_sw_init(void
                  *handle)<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                  &nbsp;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Retrieval firmware validate key */<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr = adev-&gt;uvd.inst[0].cpu_addr;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr += 192 + 16;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;ucode_len, ptr, 4);<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr += ucode_len;<br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;adev-&gt;uvd.keyselect, ptr, 4);<br>
                  +<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;uvd.inst-&gt;ring;<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(ring-&gt;name, &quot;uvd&quot;);<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ring_init(adev, ring, 512,
                  &amp;adev-&gt;uvd.inst-&gt;irq, 0,<br>
                  -- <br>
                  2.25.1<br>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cleo.liu%40amd.com%7C695a4d51b81b4a08dbe208d888242256%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637409036097906257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=8u1TK45gYH0hQ8dn5x1A9ckXIYQjGCedmkp8mpt4EW4%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cleo.liu%40amd.com%7C695a4d51b81b4a08dbe208d888242256%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637409036097906257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=8u1TK45gYH0hQ8dn5x1A9ckXIYQjGCedmkp8mpt4EW4%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--------------48E239069FC86F1225946064--

--===============1452889328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1452889328==--
