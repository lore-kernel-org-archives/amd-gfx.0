Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E595560F38
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E595560F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F23C6EC0D;
	Fri, 17 Sep 2021 07:43:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9696EC0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 07:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKtUVbb0lDx/IEC6a/YZaCrzcRf1twPx2vjmyaalzFyShH4+YRMpMwAEJEVMiX4noCbC2ihnObt3H3RXzEL68gO3WXuZU68za9hHPfGcFg2JSWBtUot3JwwdHfh6PYGTZVtrj8tN5yneNdnbIrd0ZtYXK669CnIRXmJD/+I3gKqzs2h4IHPK5t+B/8yO9tWSQcJXOVEckm8YUA/0w/o/0lMEjvceYWL2Q35ga/iELT8xC4UB5ZTiRxQjuhxFJ28X3ULelQ7cdWU/2PV8FQ93Awtd+6h92goIKwMh1k6VdlBEcl2/LCKAlmdiba2DGAmjGeOBLhpJZLUAmD8G58zgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dqOozFoSMjayB6BTucO+HEkqVYlmizHEdq1mAxAtB+c=;
 b=BIKG8wMp7mPfjjDvR3TkAY9huXdjY8PtftLJJDn8xbtolhUbeNc5Q4fur6JljlQgLECpyAdj0WCIm0TcpcAX2H006CX2UsijwbX+g26MnjQfJXIvJ+Cqe5B6Bv6szrTG+lMm18xSdVrXQ43qZztcswnRB2mw3ttHsdW0d49YnFQvMN35Ps1wOOCLO8gN38/TpVzJzdx3J3HlRZL0P4GhD+y6Kk6aFvnUnLnJbYkiLvrDfBo082htkFaeqG3edgC3J7E60PWwtK6frWfVAfDjZUQ3zv7NcLMyHgedIHZCHo+Axy+eHJVllIdsjyxSw/yNrGZYcLyZR1Z32EsVgO6cKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqOozFoSMjayB6BTucO+HEkqVYlmizHEdq1mAxAtB+c=;
 b=o9kVNs8qd6+rEbIOtH+69OXejjfwRNAPSYE/IgjUT6jZh60dwqac1FVqbjYavRzNJsJB4zaSjZmXOH8SN5aZucaa2VBuOMUcbM2M5xbBUy38/6OpzhHGMwyMk8XAfRWxk5iCAhxDq7lA7QCWpeX4S/LSNTNX1MtzSTrFDEdJcxw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:42:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:42:56 +0000
Subject: Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210917070444.4867-1-xinhui.pan@amd.com>
 <59a231be-f623-196e-e547-8d5c75d0f314@amd.com>
 <DM4PR12MB5165DDADEE756AA4B3BAD54987DD9@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a76d81ef-03f5-2d99-8a07-ddf5be1f2c7c@amd.com>
Date: Fri, 17 Sep 2021 09:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165DDADEE756AA4B3BAD54987DD9@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------CB8CC640FD9E837939987BBA"
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR06CA0132.eurprd06.prod.outlook.com (2603:10a6:208:ab::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:42:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac227611-d950-48ba-a084-08d979aec3bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB394970696B9D5F23AE34E1E683DD9@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gLyZXq6C9J4wDqunNir033IjsvVr+BBgc0OdyBSAIoitB17faRkPOnuBkNFdUsmO12Q6NB3jVRZDV5qk9SvlSUbcXZxY97r1Z/R1+uXgNnFiazwcJKC1GvtgzeAS2MdDaLBrZS6glOpuDsXbuiNbEYMfkp1uFpp7el0F1zyumXcto2R0ro+Ykf1gIzYWjxFxskQ79kVIOWC6WSJnl8XKsK7/AaD3hkLD0RTJkH1HpYHPn/AzAb9DG4s+Q6GLJ1Ek5rrD2FfU8AIIDs39n+qkEHBCT30hq3yHQgkNa6tyySWtDTFFEHM3Uk3YRZ4BkLHv9qQsGwJziFdhI3HwF4GtkENlDKHFhdiOFX91/1U48X326R+aNVpE2jDpQRO4a4nOSK56DrGmWdYuZjt3TVqPe9wyU6N6z+TETE2TB6R/G5lkQnBm7oMttRUnWKjKJ3Chnj0PCWc7uimUck6mSgyO+gSuOU3x4Timvh34w02yQqNw1POhAVNpW3CmwXb80BGFJSGM5E3zUpeZ7lF0DPYd5xeOYjRtE6rObEiVz8vqeC3OchSgcf34p3anvfj8W4bpDjXhmf1wioTx0BsK/Sk5GvrWi0MT+vIQjKgn19JwKLHJyjcxh7ep2QNz4yK6T2KQ1GcnOAjNeqVP4LQggKVVb7DkIw5+5SrUAOlNzCFA0qoAC2sM/SNbZPmf2A+SalkJF8dyVs5i73S3u30RhUKfNBxfWXc0NUItrq1t03A8xAgHl/OpTDXpUJpZKWTfVGJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(83380400001)(186003)(31686004)(6486002)(26005)(33964004)(16576012)(316002)(53546011)(86362001)(110136005)(2906002)(36756003)(66556008)(8936002)(478600001)(66476007)(66946007)(8676002)(38100700002)(5660300002)(956004)(2616005)(4326008)(31696002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RzTWJFSHBDd1ZrdDRHZTNGSDBYcFdmK1RKU1VDaHlCL1JnSXFGMVRPd21p?=
 =?utf-8?B?aHhSQ3NaSndTdWNhMlFWZGhSTU52YzN2ZHUzb1BLTVVlWUtFR0tSek9raSt0?=
 =?utf-8?B?a084ckdmUmlQY1JpOUZIMFltSGxLRm5XOVR4SGlJL252cDlmTS9OSGgwb2NT?=
 =?utf-8?B?VGRkMXJlaEUycWVlRU5QZ3FSZTFmbTJMU2hWV1pRU1pXeit2blIwRllLbUtq?=
 =?utf-8?B?cVRQb3JLeFRRS2EvMnVOcml1ZEVaSW03YlVXdG5tTk1Rd0YzeGdNMCtVRUY1?=
 =?utf-8?B?bVBxRmEycWk1SlNwb2Z0d1V4a1FOSUl5Q240bDhMUUhwWkJoV1RVaVJpcndr?=
 =?utf-8?B?R20rR0MvQ01QV295MHlEU0R6N21zMVBraXR4NlFrbld5cVdiSEFUWkNHUHdo?=
 =?utf-8?B?Y0haRWVZL1JCY01zSjMxLysyNXJCWC9rZklSN0h2L2NZTHRrMjlTSXJJZmMr?=
 =?utf-8?B?MnlRdGowdWczRkRQaUdNUVFUcVZZdjlHc0YyV2NNT054M1hDKzJpK2RmY1pY?=
 =?utf-8?B?UnZ1MzdDUXBRRVdhV3doMFVzYnJxbW5NakI0T3JKbW9OMmpxa1FiV3U4K1Jz?=
 =?utf-8?B?UHFhVlFSMzBIdndpNTU5WDVSVi9MekFHQXp2a3FybVl0eDV1aTgvSjNKZ29M?=
 =?utf-8?B?eFNTRCtXbE1Yd0NRMW5sUHFPZWJqcTAxcDJLYWhrUnN2VER6QUhUakdZc3ZR?=
 =?utf-8?B?RUd5Nm9OVmQ5OElleC9HZ29UVlg5OWR1RWpydlRISFhsREczaG8zaUJ5TFgw?=
 =?utf-8?B?K1hOL3poVVRxZUw4QXdOYWdXVU5kZzM1M2FqSjhZZUVDVEp6TVR3YmNaa0ps?=
 =?utf-8?B?YmxqR2Y3bzEzNkNEYmc4QjJUOXR1d2hEMWdOK3hQcWVHOWY2MS9mV3FONzFI?=
 =?utf-8?B?K29lR0VvU1VNR2NZU053SUs4dXUxeEZYc1BDM0VvcHpIREZjMlcwc2hjV2dG?=
 =?utf-8?B?M0ZiOVduWXQ4Y2x2RG5URjJGd0V1bjJHMW4xdTQ3UjRrWTRSR1IyUVVwRm1S?=
 =?utf-8?B?S080S1paMWgyR2loaEFnNGw1UmVxbnZGOGtVZTM2SjBNOHpPZklOVnQ2dk1v?=
 =?utf-8?B?MkoxdGIrRCs0VGlYVTBPcnJadDROSi9VYURaYWdxM25sbjBZOE8rRis4Ykk0?=
 =?utf-8?B?TnZiUHg5OFpaMTM0NUx5bzc1dGp5alZ2c0hTT1h6bzNicnR4NFVjZmhNOVNN?=
 =?utf-8?B?RE5PaTVoUG5MNlBmb042QVNJU1dUL0t1KzBIVWpEVkN1TlRPQllDN0ZDSDY1?=
 =?utf-8?B?bW15clRTRnFEL01iNGFFQWt0ZmJNSmhESGZFbDNSVW80Q2k2TlVNazR3d3hV?=
 =?utf-8?B?Zk9ENE1oeFJ0ZjVJQ3JGU1hkTnM0UGQwNk16T3MvQmJDbFAwbVZKajR6cTNu?=
 =?utf-8?B?UTkrNTdvTE5iYjN0WUtqVzZSODBDTmY5QW9nMDgzR3kvdys2N2hRaFVYVHNs?=
 =?utf-8?B?WnN4dmw5bEFyYTdSam5FOVY2TlRMdS93aG9NSnRGRkh6TVdCaWhHcmNJUlpa?=
 =?utf-8?B?OEh0VUU1cGJqMEozNzF6emZPa2o3TE44TUV6cVBsQ1VJa0JCQnFpYk80U29X?=
 =?utf-8?B?QVBUa2xTMUlTcjVFblBRWTQ2Wm1mTUxmK3BEVEhZd25KQ1hmWGZaVmkwY1VR?=
 =?utf-8?B?em9qazFsRXd1Q3gyQmlsR0YwLzU4VWZ4ZTRySU04VjByQktoZmE0TmYvZWJn?=
 =?utf-8?B?ZGIveCtreFJGeDZpNSs0am5PYXJKNjhjMDMyTnVQY0RmVGZOcmxRK3hNSHhv?=
 =?utf-8?Q?D6zarxJH5VcpH8GYJKNpOZAwXKjGXrwNAiiK1vH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac227611-d950-48ba-a084-08d979aec3bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:42:56.6728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeTgHfOiAwIAzSFc7sgUinJCf981eDVY7LAUH0Jq3Vn6cmUCY3JvO5LVzaYYrKF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------CB8CC640FD9E837939987BBA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Exactly that, yes. The idea is that we want to create at least some 
pressure on VRAM when VRAM|GTT is specified.

Essentially we would like to have that for CS as well, but it's just 
hard to find the right balance between no pressure and the full pressure 
of VRAM placement for VRAM|GTT BOs.

It's on my todo list to tackle that and I'm currently working on an 
userspace tool to better simulate those setups, but it's just a side 
project.

Christian.

Am 17.09.21 um 09:35 schrieb Pan, Xinhui:
>
> [AMD Official Use Only]
>
>
> Why? just to evict some inactive vram BOs?
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, September 17, 2021 3:06:16 PM
> *To:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
> Am 17.09.21 um 09:04 schrieb xinhui pan:
> > For any user BO, it is allowed to alloc memory in both GTT and VRAM
> > domain. That means one VRAM BO could be eviced to GTT.
> >
> > Now if device is already lack of VRAM, this BO could alloc memory from
> > GTT directly without evicting other VRAM BO. In this way we can reduce
> > memory evictions.
>
> NAK, that is intentional pressure on VRAM during allocation of new memory.
>
> Christian.
>
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 66bb8a53bb20..9a547bb38cda 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -579,7 +579,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
> >                          AMDGPU_GEM_DOMAIN_GDS))
> >                amdgpu_bo_placement_from_domain(bo, 
> AMDGPU_GEM_DOMAIN_CPU);
> >        else
> > -             amdgpu_bo_placement_from_domain(bo, bp->domain);
> > +             amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> >        if (bp->type == ttm_bo_type_kernel)
> >                bo->tbo.priority = 1;
> >
>


--------------CB8CC640FD9E837939987BBA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Exactly that, yes. The idea is that we want to create at least some
    pressure on VRAM when VRAM|GTT is specified.<br>
    <br>
    Essentially we would like to have that for CS as well, but it's just
    hard to find the right balance between no pressure and the full
    pressure of VRAM placement for VRAM|GTT BOs.<br>
    <br>
    It's on my todo list to tackle that and I'm currently working on an
    userspace tool to better simulate those setups, but it's just a side
    project.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 17.09.21 um 09:35 schrieb Pan,
      Xinhui:<br>
    </div>
    <blockquote type="cite" cite="mid:DM4PR12MB5165DDADEE756AA4B3BAD54987DD9@DM4PR12MB5165.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          Why? just to evict some inactive vram BOs?</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, September 17, 2021 3:06:16 PM<br>
            <b>To:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Let BO created in
            its allowed_domain</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 17.09.21 um 09:04 schrieb xinhui
                pan:<br>
                &gt; For any user BO, it is allowed to alloc memory in
                both GTT and VRAM<br>
                &gt; domain. That means one VRAM BO could be eviced to
                GTT.<br>
                &gt;<br>
                &gt; Now if device is already lack of VRAM, this BO
                could alloc memory from<br>
                &gt; GTT directly without evicting other VRAM BO. In
                this way we can reduce<br>
                &gt; memory evictions.<br>
                <br>
                NAK, that is intentional pressure on VRAM during
                allocation of new memory.<br>
                <br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                &gt; index 66bb8a53bb20..9a547bb38cda 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                &gt; @@ -579,7 +579,7 @@ int amdgpu_bo_create(struct
                amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GDS))<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo,
                AMDGPU_GEM_DOMAIN_CPU);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo,
                bp-&gt;domain);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo,
                bo-&gt;allowed_domains);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bp-&gt;type == ttm_bo_type_kernel)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.priority = 1;<br>
                &gt;&nbsp;&nbsp; <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------CB8CC640FD9E837939987BBA--
