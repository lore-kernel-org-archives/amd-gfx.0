Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA94C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E62C206B7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NwfaiTaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E62C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5270A6E98C;
	Wed, 11 Mar 2020 14:16:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49FF6E98C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0i6bqK5hek0oMPecp10bORDA+n7sx3tQ5IRkDUZtrJTKeRSH3MRhe2eBnjXRaMG/PN6WXlA7+Hm5v+e1gXgBritcZiwERAotvqdri1TNRnTwUtRd4gTGldlcYxHy7lWn9SPzBZEyLWKsYvB3P/mlFCfyNXsV5XNSRjpAlUxXr53I4Rf3LZ+2nZOsEcIb7uAP+VGvarm5DJP1kjjLf6mVjgS6h6YQkJk/Jq5FEQZZzf7pgpzYGhVoyMMHvu006djGNcugyGkBxFeTezFvtU5hHZhSwFofctvW0xSoTJwLmnNtbaGje4oohVIGw6/WlD8EJhReD8lXEUZC78s4Ric6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtlVZxchYqbADJkGpcN+9yDDAS+j5cixCl9NR8yK4oY=;
 b=WXtZjdjp6eKIaUIvi5iAG4t1tvIJ43OOof/H1U/NAp+5iXFVLRdhm5b4q+9lEX1RCc/AQbFgjDkB/ydsbK/10Li2G25S70RtF9AShucPeQiL9Q+9mlEN9nBzuDhBXRLkL9/Dlv61uY7YL+kA48fzHR2xP05ESILlbisbuuMkzJsS5ZwMwfvJuHmEmHQk69EbkFviC6iue4i9XGecddl7zASerqsGhVdtzo9EygT0eOLp7zXSNCae0M6VxXBJD3As7zno+TlT1jw0Si0fM4Em8TLWCm4Z6jG5Y5owIPptTbgwlmZrm2hH6Dbu4u2k7JR9ismbbEIwBMZc4s9yq6KGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtlVZxchYqbADJkGpcN+9yDDAS+j5cixCl9NR8yK4oY=;
 b=NwfaiTaZ31VMU9Uk/bMlvFIBAcxad57MZOhMaKhJDd5SBCoSz5MSP/w7k5u1AtYK20n/ptCaEA2DEezJnNZ9CRilfI/fRprrF0JvDOM65JezdHaPxu+oZrKtg+c4BHpSRxRsRsv2iH7dgeb4Aa8NdehnDoev0GiOtBuZRqSSxfQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 14:15:58 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 14:15:58 +0000
Subject: Re: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583773021-15957-1-git-send-email-James.Zhu@amd.com>
 <BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com>
 <85b1ab46-178d-1fcd-bd4a-e70696efa778@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <4662a2f6-865a-b812-6df5-4d4703f68378@amd.com>
Date: Wed, 11 Mar 2020 10:15:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <85b1ab46-178d-1fcd-bd4a-e70696efa778@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 14:15:57 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58f432d3-d695-4107-8467-08d7c5c6b856
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:|BYAPR12MB3590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35903152DFCA83885AFC0CD6E4FC0@BYAPR12MB3590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(66946007)(52116002)(66556008)(19627405001)(36756003)(110136005)(8676002)(36916002)(26005)(8936002)(81156014)(16576012)(66476007)(81166006)(316002)(66574012)(53546011)(33964004)(5660300002)(16526019)(478600001)(31696002)(2616005)(956004)(31686004)(6486002)(2906002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3590;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7sXng1FVQjxHlQKykXHfxKeFOunx2CRbhzurTWSSXh6xFGukS1TxaEXWwS0hi5IpCsCupyQthf6QaqW9LxJCuzKUt3mI8ivOfZuJXeM56930tSe5qnPf7Yy++afy5FnaezjZqzCA7+g7FUxWshIO9pBTq1QQuOqtNDwgAHJW2MZVZSC55EgmESrea0Pm367jHKm+awPMg56fgxO3QD6jHTHCJOLbSBSquCEgFHPquqrF42IRl/bvXiCnqB9DA0wVmpX/biWUXoYtxXWq00W4Y3HH6rV3f73I0cRrXzSfs/Uuoo2faPNo6zoXtMG4dNxbBTPH5ThkmUsIvGFw/7+bsIqMY8jRp/A/ztqJJ11otDyu+Zl/aDgf5zXpwXJluSAcOyAoJBoOqOQ6RoKXvqa8RaMJBDiMteA5NrPe4nMQTqn4o698dj3MApbIbXV/uHc
X-MS-Exchange-AntiSpam-MessageData: 5IgrcTNYmI/OiLMtA1lObWVULWZBtQhtjLMJtZldLLT27+YVUp1PXE0+sUdIJ9diHQo6nzJmObOyPCLXmBYlSLtZ03i5OOIRhpfXPsGPiHqybLeTVxAj/b/+r8IZfeEmq2tcKONWa+wOw27ZmtinoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f432d3-d695-4107-8467-08d7c5c6b856
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:15:58.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vhxg4ZPOZpkleLbyz5U/6w4jPLAI0A2UPcIB+GvJJEts8nUY+lESuLMsXA8kgFyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
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
Content-Type: multipart/mixed; boundary="===============0000058549=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0000058549==
Content-Type: multipart/alternative;
 boundary="------------762ACE4448AE78C64514027C"
Content-Language: en-US

--------------762ACE4448AE78C64514027C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020-03-11 7:38 a.m., Christian König wrote:
> Am 11.03.20 um 12:30 schrieb Zhu, James:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> ping
>>
>> ------------------------------------------------------------------------
>> *From:* Zhu, James <James.Zhu@amd.com>
>> *Sent:* Monday, March 9, 2020 12:57 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Zhu, James <James.Zhu@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>
>> *Subject:* [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue 
>> for vcn start
>> Fix race condition issue when multiple vcn starts are called.
>>
>> v2: Removed checking the return value of cancel_delayed_work_sync()
>> to prevent possible races here.
>>
>> v3: Add total_submission_cnt to avoid gate power unexpectedly.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>>  2 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index a41272f..6aafda1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>          int i, r;
>>
>> INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
>> + mutex_init(&adev->vcn.vcn_pg_lock);
>> + atomic_set(&adev->vcn.total_submission_cnt, 0);
>>
>>          switch (adev->asic_type) {
>>          case CHIP_RAVEN:
>> @@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>>          }
>>
>>          release_firmware(adev->vcn.fw);
>> + mutex_destroy(&adev->vcn.vcn_pg_lock);
>>
>>          return 0;
>>  }
>> @@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct 
>> work_struct *work)
>>                  fences += fence[j];
>>          }
>>
>> -       if (fences == 0) {
>> +       if (fences == 0 &&
>> + likely(atomic_read(&adev->vcn.total_submission_cnt) == 0)) {
>>                  amdgpu_gfx_off_ctrl(adev, true);
>> amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>>                         AMD_PG_STATE_GATE);
>> @@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct 
>> work_struct *work)
>>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>  {
>>          struct amdgpu_device *adev = ring->adev;
>> -       bool set_clocks = 
>> !cancel_delayed_work_sync(&adev->vcn.idle_work);
>>
>> -       if (set_clocks) {
>> -               amdgpu_gfx_off_ctrl(adev, false);
>> - amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>> -                      AMD_PG_STATE_UNGATE);
>> -       }
>> + atomic_inc(&adev->vcn.total_submission_cnt);
>> + cancel_delayed_work_sync(&adev->vcn.idle_work);
>> +
>> + mutex_lock(&adev->vcn.vcn_pg_lock);
>> +       amdgpu_gfx_off_ctrl(adev, false);
>> + amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>> +              AMD_PG_STATE_UNGATE);
>>
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
>>                  struct dpg_pause_state new_state;
>> @@ -345,11 +350,14 @@ void amdgpu_vcn_ring_begin_use(struct 
>> amdgpu_ring *ring)
>>
>> adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>>          }
>> + mutex_unlock(&adev->vcn.vcn_pg_lock);
>>  }
>>
>>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>>  {
>> schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>> +       if 
>> (unlikely(atomic_dec_return(&ring->adev->vcn.total_submission_cnt) < 0))
>> + atomic_set(&ring->adev->vcn.total_submission_cnt, 0);
>
> You need to decrement first and then call schedule_delayed_work() 
> otherwise the work could run with the wrong counter.
>
> And the extra check for an under run should be superfluous.

Thanks! Please check V4

James

>
> Regards,
> Christian.
>
>>  }
>>
>>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 6fe0573..111c4cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -200,6 +200,8 @@ struct amdgpu_vcn {
>>          struct drm_gpu_scheduler 
>> *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
>>          uint32_t num_vcn_enc_sched;
>>          uint32_t num_vcn_dec_sched;
>> +       struct mutex             vcn_pg_lock;
>> +       atomic_t total_submission_cnt;
>>
>>          unsigned        harvest_config;
>>          int (*pause_dpg_mode)(struct amdgpu_device *adev,
>> -- 
>> 2.7.4
>>
>

--------------762ACE4448AE78C64514027C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020-03-11 7:38 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:85b1ab46-178d-1fcd-bd4a-e70696efa778@amd.com">
      
      <div class="moz-cite-prefix">Am 11.03.20 um 12:30 schrieb Zhu,
        James:<br>
      </div>
      <blockquote type="cite" cite="mid:BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com">
        <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
        <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left"> [AMD Official Use Only - Internal Distribution
          Only]<br>
        </p>
        <br>
        <div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> ping<br>
          </div>
          <div>
            <div id="Signature"><br>
              <div>
                <hr tabindex="-1" style="display:inline-block;
                  width:98%">
                <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><br>
                    <b>Sent:</b> Monday, March 9, 2020 12:57 PM<br>
                    <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                    <b>Cc:</b> Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>;
                    Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                    <b>Subject:</b> [PATCH v3 1/4] drm/amdgpu/vcn: fix
                    race condition issue for vcn start</font>
                  <div>&nbsp;</div>
                </div>
                <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                      <div class="PlainText">Fix race condition issue
                        when multiple vcn starts are called.<br>
                        <br>
                        v2: Removed checking the return value of
                        cancel_delayed_work_sync()<br>
                        to prevent possible races here.<br>
                        <br>
                        v3: Add total_submission_cnt to avoid gate power
                        unexpectedly.<br>
                        <br>
                        Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><br>
                        ---<br>
                        &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22
                        &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
                        &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 2 &#43;&#43;<br>
                        &nbsp;2 files changed, 17 insertions(&#43;), 7
                        deletions(-)<br>
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
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        mutex_init(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        atomic_set(&amp;adev-&gt;vcn.total_submission_cnt,
                        0);<br>
                        &nbsp;<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
                        @@ -210,6 &#43;212,7 @@ int
                        amdgpu_vcn_sw_fini(struct amdgpu_device *adev)<br>
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
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev,
                        true);<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        amdgpu_device_ip_set_powergating_state(adev,
                        AMD_IP_BLOCK_TYPE_VCN,<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
                        @@ -319,13 &#43;323,14 @@ static void
                        amdgpu_vcn_idle_work_handler(struct work_struct
                        *work)<br>
                        &nbsp;void amdgpu_vcn_ring_begin_use(struct
                        amdgpu_ring *ring)<br>
                        &nbsp;{<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                        ring-&gt;adev;<br>
                        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool set_clocks =
                        !cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);<br>
                        &nbsp;<br>
                        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (set_clocks) {<br>
                        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev,
                        false);<br>
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
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        mutex_lock(&amp;adev-&gt;vcn.vcn_pg_lock);<br>
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        amdgpu_device_ip_set_powergating_state(adev,
                        AMD_IP_BLOCK_TYPE_VCN,<br>
                        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<br>
                        &nbsp;<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp;
                        AMD_PG_SUPPORT_VCN_DPG)&nbsp;&nbsp;&nbsp; {<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state
                        new_state;<br>
                        @@ -345,11 &#43;350,14 @@ void
                        amdgpu_vcn_ring_begin_use(struct amdgpu_ring
                        *ring)<br>
                        &nbsp;<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        adev-&gt;vcn.pause_dpg_mode(adev, ring-&gt;me,
                        &amp;new_state);<br>
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
        </span></font></blockquote>
    <p><font size="2">Thanks! Please check V4</font></p>
    <p><font size="2">James<br>
      </font></p>
    <blockquote type="cite" cite="mid:85b1ab46-178d-1fcd-bd4a-e70696efa778@amd.com"><font size="2"><span style="font-size:11pt"> <br>
          Regards,<br>
          Christian.<br>
        </span></font><br>
      <blockquote type="cite" cite="mid:BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com">
        <div>
          <div>
            <div id="Signature">
              <div>
                <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                      <div class="PlainText"> &nbsp;}<br>
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
    </blockquote>
  </body>
</html>

--------------762ACE4448AE78C64514027C--

--===============0000058549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0000058549==--
