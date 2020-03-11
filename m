Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72290C10F29
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 11:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BBD20848
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 11:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F7D4jgN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BBD20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E47C6E975;
	Wed, 11 Mar 2020 11:39:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77D06E975
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/5uPDwfSlbbHmfWlPw3sSSME4NiU5UpV7nSYuNRbje4y4sMQFc9VaPT9g7HydbxjJW+Yjvktq/zgOQXfxR44WIu8Xw256INWruEym8qv60KSPdH8WzbQ/lHVw68uEC1K2dsxU0ivFHOzd2UGDeu3AfUtuuLglT1K3nvYq5hsEnhYKsX6Hxm7f11omTilr1gbVqBUS/FGlbT3vt4qZ8xxNEbp+6Q+BGrGF15rkFco0lLXPvFvBIGK4enQBuSEMf4btF5AHsJp/9/MYIgmFJWhB9DqfPRBK8RoYMG2sJUTMLpeD8fwQP10wssQ0zMveMTrkjcDFWtpd6CiXfjr6SuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtRzHGuOHBLIoBuY9C8+mbX6XzS8+kNIBCALRrqsOrE=;
 b=ig7SUtJ+3a4iCpJEQ5VualAnEx2Z/2nqKYmKB5Crq244H7zm9mjBJQtWmJV+UoX71Zm1tOJP+nDx8e+EeMZw47IJ340siCp+9ePfRlR8JkXS7ta6L1aXYAoPnb7qjuBOC3HF3ZVd+hHiQM+T/La302HMw/a3edxAgLZhGtyGi1P/RyJRUh44v11Z/iipMh4PbEeUBGvnI1LfyZ6XJHapR2LNwtJ2CelR57QX5RGFAYNVEtQ5W0Pb4/oi76vvZV06jSaF9FUveAfMzrU7qK2OVnj/fmw8xseb/XVPH36QgFYmSWKHAAnvRHOgECl+ukJ5E4RhZz/H8Ia+QfZzpdcxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtRzHGuOHBLIoBuY9C8+mbX6XzS8+kNIBCALRrqsOrE=;
 b=F7D4jgN6vQ5lUMR+sEGF/dFQWcwyIX7loYAFe8XmyiArF6OnAJscv57dDD6+7eu5lp2q1OESqctdD8L2RUBXvYtJwhvKWcpOdKk/8bRE6FBMRqNkGr7m62OrxnYPq3EULWw/XD4cqDzVd55ThLXqt8YMHholQfUrH01UzI8yte0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 11:38:56 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.018; Wed, 11 Mar
 2020 11:38:56 +0000
Subject: Re: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583773021-15957-1-git-send-email-James.Zhu@amd.com>
 <BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <85b1ab46-178d-1fcd-bd4a-e70696efa778@amd.com>
Date: Wed, 11 Mar 2020 12:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 11:38:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3432bba1-e969-41a8-cce1-08d7c5b0c859
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB136988F2E225ED882A38378C83FC0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(6486002)(186003)(16526019)(52116002)(33964004)(66946007)(2906002)(19627405001)(2616005)(31686004)(6666004)(53546011)(8936002)(81166006)(110136005)(36756003)(81156014)(8676002)(86362001)(66556008)(316002)(66476007)(5660300002)(478600001)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eS1ReYfz7ENbwo+s8EbnqqZBqUTDshtXIijzGjYoplibphriSMt+4QNKySlMrC3JGJAjl5hNQrqjmkUEk3PNNL8Re2Nl4HC4vEkV6aIuBd8UshtnQtymjc2kcw9NgkNUAmn2h1+2ayYd2xjaXGF1+PmMmbHl8lDS+zbtDVm+Y/pbk9zUY/HMhk1OrrOcWy8cDe1Q1PJLVOKg5+81bDIJpUnOZj/v/JFIbQbVG+h+K19yH3vA9geKtlEBXor5rkMLiisiI2iqmT+EW7xAZ+63HD0TcEsaWDv1Sa/yXywGOuOm2EIhUE/yFFbpoLHiNpGRmpoAZ26xCYE0ZAY51w6tSVkjzNqitNtu2YGt6wA03pR7SOxT+2jU5uZRLeok4S7VrDvt2xUg/9f5lnEJWV7LIw+b0UXCk+SY7N5zioJmi8Nd4vvjkqfrLfV6vmJsuOX
X-MS-Exchange-AntiSpam-MessageData: pIJ6qtSY2tq7x69suwP99DEEhB+s4lKutNhJkd5hbpo9YwVdPQwWh8K0Ggtk9ncc/SggVkOzLGoaHdTvW9e1NIsnZo8MXwNUUMBmrXIWa53yBtdvoAogDyMxqvNHh4QCl7nHD7Y3st2CU534OmfD5MZzKVkDUmeZes2IMFEzxsb6ZoG1KSmp0SdfU2Lxzfn0Ks0uyR9k4Z68wY2PBdqSug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3432bba1-e969-41a8-cce1-08d7c5b0c859
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 11:38:56.8576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dizarUos4mxQDkggndfg05LsL8iLrMD+ujvHFiY/iD7PhVX9RimZhTdNZXzjPjxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
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
Content-Type: multipart/mixed; boundary="===============1547956848=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1547956848==
Content-Type: multipart/alternative;
 boundary="------------E9169938C44F7C3481496E60"
Content-Language: en-US

--------------E9169938C44F7C3481496E60
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.03.20 um 12:30 schrieb Zhu, James:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> ping
>
> ------------------------------------------------------------------------
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Monday, March 9, 2020 12:57 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhu, James <James.Zhu@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Subject:* [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for 
> vcn start
> Fix race condition issue when multiple vcn starts are called.
>
> v2: Removed checking the return value of cancel_delayed_work_sync()
> to prevent possible races here.
>
> v3: Add total_submission_cnt to avoid gate power unexpectedly.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index a41272f..6aafda1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>          int i, r;
>
> INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> +       mutex_init(&adev->vcn.vcn_pg_lock);
> + atomic_set(&adev->vcn.total_submission_cnt, 0);
>
>          switch (adev->asic_type) {
>          case CHIP_RAVEN:
> @@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>          }
>
>          release_firmware(adev->vcn.fw);
> + mutex_destroy(&adev->vcn.vcn_pg_lock);
>
>          return 0;
>  }
> @@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct 
> work_struct *work)
>                  fences += fence[j];
>          }
>
> -       if (fences == 0) {
> +       if (fences == 0 &&
> + likely(atomic_read(&adev->vcn.total_submission_cnt) == 0)) {
>                  amdgpu_gfx_off_ctrl(adev, true);
> amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>                         AMD_PG_STATE_GATE);
> @@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct 
> work_struct *work)
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  {
>          struct amdgpu_device *adev = ring->adev;
> -       bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       if (set_clocks) {
> -               amdgpu_gfx_off_ctrl(adev, false);
> - amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -                      AMD_PG_STATE_UNGATE);
> -       }
> + atomic_inc(&adev->vcn.total_submission_cnt);
> + cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +       mutex_lock(&adev->vcn.vcn_pg_lock);
> +       amdgpu_gfx_off_ctrl(adev, false);
> + amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +              AMD_PG_STATE_UNGATE);
>
>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
>                  struct dpg_pause_state new_state;
> @@ -345,11 +350,14 @@ void amdgpu_vcn_ring_begin_use(struct 
> amdgpu_ring *ring)
>
>                  adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>          }
> + mutex_unlock(&adev->vcn.vcn_pg_lock);
>  }
>
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>  {
> schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +       if 
> (unlikely(atomic_dec_return(&ring->adev->vcn.total_submission_cnt) < 0))
> + atomic_set(&ring->adev->vcn.total_submission_cnt, 0);

You need to decrement first and then call schedule_delayed_work() 
otherwise the work could run with the wrong counter.

And the extra check for an under run should be superfluous.

Regards,
Christian.

>  }
>
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6fe0573..111c4cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -200,6 +200,8 @@ struct amdgpu_vcn {
>          struct drm_gpu_scheduler 
> *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
>          uint32_t num_vcn_enc_sched;
>          uint32_t num_vcn_dec_sched;
> +       struct mutex             vcn_pg_lock;
> +       atomic_t total_submission_cnt;
>
>          unsigned        harvest_config;
>          int (*pause_dpg_mode)(struct amdgpu_device *adev,
> -- 
> 2.7.4
>


--------------E9169938C44F7C3481496E60
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 11.03.20 um 12:30 schrieb Zhu,
      James:<br>
    </div>
    <blockquote type="cite" cite="mid:BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          ping<br>
        </div>
        <div>
          <div id="Signature"><br>
            <div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Zhu, James
                  <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><br>
                  <b>Sent:</b> Monday, March 9, 2020 12:57 PM<br>
                  <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>;
                  Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                  <b>Subject:</b> [PATCH v3 1/4] drm/amdgpu/vcn: fix
                  race condition issue for vcn start</font>
                <div>&nbsp;</div>
              </div>
              <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="PlainText">Fix race condition issue when
                      multiple vcn starts are called.<br>
                      <br>
                      v2: Removed checking the return value of
                      cancel_delayed_work_sync()<br>
                      to prevent possible races here.<br>
                      <br>
                      v3: Add total_submission_cnt to avoid gate power
                      unexpectedly.<br>
                      <br>
                      Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><br>
                      ---<br>
                      &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22
                      &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
                      &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 2 &#43;&#43;<br>
                      &nbsp;2 files changed, 17 insertions(&#43;), 7 deletions(-)<br>
                      <br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                      index a41272f..6aafda1 100644<br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                      &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                      @@ -63,6 &#43;63,8 @@ int amdgpu_vcn_sw_init(struct
                      amdgpu_device *adev)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      INIT_DELAYED_WORK(&amp;adev-&gt;vcn.idle_work,
                      amdgpu_vcn_idle_work_handler);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_set(&amp;adev-&gt;vcn.total_submission_cnt,
                      0);<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
                      @@ -210,6 &#43;212,7 @@ int amdgpu_vcn_sw_fini(struct
                      amdgpu_device *adev)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;vcn.fw);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      mutex_destroy(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                      &nbsp;}<br>
                      @@ -307,7 &#43;310,8 @@ static void
                      amdgpu_vcn_idle_work_handler(struct work_struct
                      *work)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fences &#43;= fence[j];<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &nbsp;<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fences == 0) {<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fences == 0 &amp;&amp;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      likely(atomic_read(&amp;adev-&gt;vcn.total_submission_cnt)
                      == 0)) {<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      amdgpu_device_ip_set_powergating_state(adev,
                      AMD_IP_BLOCK_TYPE_VCN,<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
                      @@ -319,13 &#43;323,14 @@ static void
                      amdgpu_vcn_idle_work_handler(struct work_struct
                      *work)<br>
                      &nbsp;void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
                      *ring)<br>
                      &nbsp;{<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                      ring-&gt;adev;<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool set_clocks =
                      !cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);<br>
                      &nbsp;<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (set_clocks) {<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      amdgpu_device_ip_set_powergating_state(adev,
                      AMD_IP_BLOCK_TYPE_VCN,<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<br>
                      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_inc(&amp;adev-&gt;vcn.total_submission_cnt);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);<br>
                      &#43;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      amdgpu_device_ip_set_powergating_state(adev,
                      AMD_IP_BLOCK_TYPE_VCN,<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp;
                      AMD_PG_SUPPORT_VCN_DPG)&nbsp;&nbsp;&nbsp; {<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state new_state;<br>
                      @@ -345,11 &#43;350,14 @@ void
                      amdgpu_vcn_ring_begin_use(struct amdgpu_ring
                      *ring)<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.pause_dpg_mode(adev,
                      ring-&gt;me, &amp;new_state);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      mutex_unlock(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                      &nbsp;}<br>
                      &nbsp;<br>
                      &nbsp;void amdgpu_vcn_ring_end_use(struct amdgpu_ring
                      *ring)<br>
                      &nbsp;{<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.idle_work,
                      VCN_IDLE_TIMEOUT);<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(unlikely(atomic_dec_return(&amp;ring-&gt;adev-&gt;vcn.total_submission_cnt)
                      &lt; 0))<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      atomic_set(&amp;ring-&gt;adev-&gt;vcn.total_submission_cnt,
                      0);<br>
                    </div>
                  </span></font></div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    You need to decrement first and then call <font size="2"><span style="font-size:11pt">schedule_delayed_work() otherwise the
        work could run with the wrong counter.<br>
        <br>
        And the extra check for an under run should be superfluous.<br>
        <br>
        Regards,<br>
        Christian.<br>
      </span></font><br>
    <blockquote type="cite" cite="mid:BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com">
      <div>
        <div>
          <div id="Signature">
            <div>
              <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="PlainText">
                      &nbsp;}<br>
                      &nbsp;<br>
                      &nbsp;int amdgpu_vcn_dec_ring_test_ring(struct
                      amdgpu_ring *ring)<br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
                      index 6fe0573..111c4cc 100644<br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
                      &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
                      @@ -200,6 &#43;200,8 @@ struct amdgpu_vcn {<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler
                      *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      num_vcn_enc_sched;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      num_vcn_dec_sched;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_pg_lock;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      total_submission_cnt;<br>
                      &nbsp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_config;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*pause_dpg_mode)(struct
                      amdgpu_device *adev,<br>
                      -- <br>
                      2.7.4<br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------E9169938C44F7C3481496E60--

--===============1547956848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1547956848==--
