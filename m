Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7224CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 01:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E34613CC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 01:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E34613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483036EB1E;
	Fri, 23 Apr 2021 01:52:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020916EB1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 01:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfDdV6nYnC/RQjj1ZD5O4+amd4pygbqI1Af5z9zVcXM3eWag9F5rOsOEqBHfbAk4hvGJmClTJKVPLNip8VIiHPq1G0/+bFP7E0Cq8zfcIRjIUr3TgdISQUThHiFxGKawTvNDFBm4k7EuBXFZqfonqhzK2Mjl1mC0ppje2wcWyhKZpBj+4J7hgwiHS25dXX+NCGl1uwTpHf9k91l7jOOPApC9ZYUaKD8b0uedK8+MM0ccUNVbjwAr22ma4NqnelK5EItEfSvI99Pj0sMDceS0mwRFxaXHZa8AsFMf2/N9pZAIEIsAtPB+W2ENfUp64SIzdS72cRHr9sQwumgd+6+JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c6ZuPeU8oR3MmAgS8i/gMBRA7c4CM+FULQPaLcVrAQ=;
 b=TIK7RatRzctXDG03HBmRYEJKSQyzW6vScMNlK+DkWBtTFaV4NKuKTEQ/k2QH984mtrXOSOBdYEPL7DtdEnInSTnVgv/2VGdulX0lrh5MnAv2/y40vBXDIJ0cw7hhXrEitkv7WYuw/4XG8DQYheTgt73us+cfuONQeH3sL5CIjGMeNjGOzuYDPsvUa8Q0QnGh2bZa4jEn5v7nVjHrNn0WG9/dhuQ5lvP9PW3c9hxCwN6TjHEOKHbP/I3O3AB0s2diGcthJp6mnoWc+KPadxDN7QbNDCnJGwZCTcLyvezZEZi8vrZY/v1K+cjbQq+n2R74fgOiuqq0wZ9NUkRXDIdzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c6ZuPeU8oR3MmAgS8i/gMBRA7c4CM+FULQPaLcVrAQ=;
 b=OvevVyhbGUTAranYMm2AdKVoJpXCTGarW+wa7Ls3wY2IbuN/nQNgIgWuPoaR+JuSVz9IV5Zm8+5zy7iv6lSy0LxYn+FchEmAMcMEqBUAO5lv1std3U/0TsRZIW8La/ebkfSGzoE/8B+QeqGZb8pzQDU0TUh15F6HoLDabrFA6tE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 23 Apr 2021 01:52:52 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Fri, 23 Apr 2021
 01:52:52 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
 <d9ff9130-667f-1b5f-83b9-d7dc77743db3@amd.com>
 <818c1295-2340-a6fe-9b64-e7a5e74d411e@gmail.com>
 <9ea89549-afb4-ed48-4ff2-0ae740251d59@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <a7f475c2-dc81-3746-4906-24fdb77b2394@amd.com>
Date: Thu, 22 Apr 2021 21:52:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <9ea89549-afb4-ed48-4ff2-0ae740251d59@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 01:52:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3f4763-2109-4de5-b7ad-08d905fa81a2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020126E91DC4098A6F43CDDAE6459@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4EzVlYhiaf7HO4ga0c1WXZdwx378xo+r902e4Ho3whYzHW5tpYa0IkGIynR38tFdw1L4tUCN1UpTLf/8FxAPKRpHBwh+8z8foEdSfjb/S9h8swmDQZSmyGB0Qm3ZEE4/RngyT4v7RpKs6yFtskBOPjdomO3h2wWotbfrLMjjjWeDVcFTfwcfDBkIz0C5jJSLPV+mnXHco9ROSJNfXv9KAS2Lk78L/cSg4qYyPpFI0nnUCyRerLPeoS4Z8bQLoXj9ZhUxV46H3dZhyDAEtHR7iM+5GmjQnwH3SQAwzo55p3Tov/bt6NqCQbjGI7yGZvU1mkS3BZ4FJmG4lyyO48ncnSNcCFyTvWLW5/X7Rh6cT3NkfKQ2GNjUu+v0wV4czklCoNC5mZJ3rFi9U9OLqby6XuxPn9e9RmbrUsRd1BOCqAESV/sjtblSxXcU0ZWoaTK/2jIKez+xzs4tjkAZnwD1VMrShIh+IUoEKgf02bacb4kUvUDj+u9Pu0X5AvIW6khYr7hpRFJ1H8ZKq+8fStgK7GojjLc55bMR6ajSJhXHUZMRYj2AYxQ7K5M09GK+jC2s9KEqhCwPSas76rsLRi86MF9ZVBN1L57tDuvsbLPNCHC5zgIGvOkDebBBr7Ku7GEYiKmHI9q8WZWh5no+cHIYIvG3R8ssuaQd5214pWAN8SQNphetciZ/45KQXocyNdzP/AvhRG9b4FvjaZ7fUvWRFQ0jLpX3dOc9iKXW1MEkFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(186003)(38100700002)(6486002)(31686004)(31696002)(16576012)(110136005)(45080400002)(5660300002)(316002)(66476007)(83380400001)(66556008)(6636002)(66946007)(53546011)(8936002)(66574015)(2906002)(26005)(956004)(36756003)(966005)(166002)(16526019)(478600001)(2616005)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YkI3N0U0WkRzZ1ExMEwrZE5IaGtNTFZFdDNaeFJXZkhQYy9wdDVpNG9WM1Nq?=
 =?utf-8?B?WGhSMUE3bWFzMmVyWkpTenN4bHIzdXdrTmhPTjZVZzNXZ1REWWhPZllQVjA4?=
 =?utf-8?B?QU1JOHNDZ2MweWtkVDFIN2NWa1lPY2lXNmx2bXMzN0dRdm8vbjdaazdKUGZY?=
 =?utf-8?B?SS9LVXQrTUNnUGt3MU9Cem1JMFFqOXFLN2xDUXZ5dmxMb0NRLzBaQkpieG9a?=
 =?utf-8?B?SFhabXN5bzZQM1JLS2drbVlEQXF3SkVTZ0JMYjlWM01WenI4dE9IbU5tZGVy?=
 =?utf-8?B?aUwzNUdKdHFYYXRkNVZ6ZzZ4TzQzbnFIdnd1VTJBeGUrdGtZdVhxTWV0NXBP?=
 =?utf-8?B?STMyYzdhQzIrV0tDeXdwK0RUdnZtWEdzdG43SElkWnNmZjFvMjZpck1hUlBq?=
 =?utf-8?B?WG51VU1TQVVwYjhGMkxoUkk3OHdCSGthMFlrMDdIblNHMXV1dVFHUGtsNFN1?=
 =?utf-8?B?Wi9mVjlrZHl6OTJPT0tjdjh0Tm9xT1BkQm1YVXkxQ1pLOWNUTXlXcW14RlN4?=
 =?utf-8?B?MEo4UHV6OEtzVm5IL0JiQzlPZkFTNkZzUkNBQ3BnTEFZMldvSjJmK3EyN0VR?=
 =?utf-8?B?TEZQV3pEbE9KeWMxZHRYTyt0cXcxNGRPcFZQYW1BQXp0cEtxK2w5MVFyM3FD?=
 =?utf-8?B?RWdXMGUvdXFoLyttNSt1bkpBSzhSb3NLVTJod0FncDRtRWdVZnM4a0pscDc2?=
 =?utf-8?B?eG0rWldVbW5yNEdldnM2b3JOczV5cjkxTkVWZ09Ld2h4aXcvTVdhMHhzOGVo?=
 =?utf-8?B?RkpCaEloZGFzdXAxK29RdWRRdzdEQWd1OUU4dURuZXZ0N3BXZVZwMVB4bHJD?=
 =?utf-8?B?Qk1nWjJHVisyRGoxak8yNUJtYWFkYTAvbC9OUEhVQkh3T3U5aFF6TEhEMkcw?=
 =?utf-8?B?YXU4ZlIvTGc3dWpSQjY4Vm5iZDBobm5kRmVyekovRE1pWHNrcnFod3dLNjZE?=
 =?utf-8?B?TCtBWDVTNWp3YzZQdjd3Ti95QlRXUXZKZkMwODIvY2NHaisxdWRCYzBIV3dj?=
 =?utf-8?B?Q2twVUhESmRaRW1pblJLS0Q2THhqaGtuR0dZcGV5WkdrdVVXYVB1V0VOME95?=
 =?utf-8?B?U0RrckJqb1JNcEhHOExPVk05Rkx3N1ZxN3NDaHk3VjNvdzYyaGFHNWFPS0RX?=
 =?utf-8?B?Y3NmNmFKYmFrN3NUckU5Tnl5YkJWVzArdnFIVzRRNERRVTdLejJEb29ndjFs?=
 =?utf-8?B?Mkt0QTNNUVNUQ3N2eXpGTEdLeFAxMjYyTDRFS1owRU0rQjdjUTltV0svRXR4?=
 =?utf-8?B?VXJSbWpjQmJaSjh1cUdpTCs5MTdvaEMvUWFOeFNMSHMrSTRZaFhNTFVsdy9o?=
 =?utf-8?B?WTJVNEovbFRCdjZDUnJFSjNLN1RhY2tmeXRiMlE2am93WWU5TmhtME4vVXc2?=
 =?utf-8?B?ZmFFQnNKSVJMMWt0NjFWWllrQ1RJL1pJeGNETWkzQ3IwZ3prc1BEa1hVZ0lq?=
 =?utf-8?B?RHlWQitRbHRqbnlEVDlnZHFCQlRvQ2tJSVRKNWNhUHhhK3FEVllHcEYybVc1?=
 =?utf-8?B?NVRHdW9WRzcvWUptMGt1cEJhZE40UnNuZ3BSamJaK0NqblNDV1QyNFRJblBB?=
 =?utf-8?B?bWp2NjhhWlBya3VJOUYzbjJpUUJVQXV0ZzlqZVZHc0pYMmgxb3NRVTVZMTkv?=
 =?utf-8?B?KzZVSnMzLzJpbERzOWYxTVB2T2lOSVhPUC9ua1FURlpHN1FxSlZ0VGtQSnRZ?=
 =?utf-8?B?RGpicENaNlBkNk52NUZ4UmtFeWpGRFIyeFhBeDg5VjJkTGtUVG1BWWk2dnUv?=
 =?utf-8?Q?DwmkL8fxP23OYOhKLiI+dthRkfGeOp7o4+dwnzF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3f4763-2109-4de5-b7ad-08d905fa81a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 01:52:52.7271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oX01OK2Rj8yvEbL3TQ52jJcrt7SRSHWN41CDou2oMViaWxEg8K10nDWMxstz9ek/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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
Content-Type: multipart/mixed; boundary="===============1066896152=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1066896152==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-21 11:29 a.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9ea89549-afb4-ed48-4ff2-0ae740251d59@amd.com">On
      2021-04-21 3:55 a.m., Christian König wrote:
      <br>
      <blockquote type="cite">Am 21.04.21 um 03:20 schrieb Felix
        Kuehling:
        <br>
        <blockquote type="cite">Am 2021-04-20 um 4:21 p.m. schrieb
          Philip Yang:
          <br>
          <blockquote type="cite">Add interface to remove address from
            fault filter ring by resetting
            <br>
            fault ring entry of the fault address timestamp to 0, then
            future vm
            <br>
            fault on the address will be processed to recover.
            <br>
            <br>
            Check fault address from fault ring, add address into fault
            ring and
            <br>
            remove address from fault ring are serialized in same
            interrupt deferred
            <br>
            work, don't have race condition.
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 24
            ++++++++++++++++++++++++
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 2 ++
            <br>
            &nbsp; 2 files changed, 26 insertions(+)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
            <br>
            index c39ed9eb0987..338e45fa66cb 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
            <br>
            @@ -387,6 +387,30 @@ bool amdgpu_gmc_filter_faults(struct
            amdgpu_device *adev, uint64_t addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
            <br>
            &nbsp; }
            <br>
            &nbsp; +/**
            <br>
            + * amdgpu_gmc_filter_faults_remove - remove address from VM
            faults filter
            <br>
            + *
            <br>
            + * @adev: amdgpu device structure
            <br>
            + * @addr: address of the VM fault
            <br>
            + * @pasid: PASID of the process causing the fault
            <br>
            + *
            <br>
            + * Remove the address from fault filter, then future vm
            fault on this address
            <br>
            + * will pass to retry fault handler to recover.
            <br>
            + */
            <br>
            +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
            *adev, uint64_t addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t key = addr &lt;&lt; 4 | pasid;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_fault *fault;
            <br>
            +&nbsp;&nbsp;&nbsp; uint32_t hash;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
            <br>
            +&nbsp;&nbsp;&nbsp; fault =
            &amp;gmc-&gt;fault_ring[gmc-&gt;fault_hash[hash].idx];
            <br>
          </blockquote>
          You need to loop over the fault ring to find a fault with the
          matching
          <br>
          key since there may be hash collisions.
          <br>
          <br>
          You also need to make sure you don't break the single link
          list of keys
          <br>
          with the same hash when you remove an entry. I think the
          easier way to
          <br>
          remove an entry without breaking this ring+closed hashing
          structure is
          <br>
          to reset the fault-&gt;key rather than the
          fault-&gt;timestamp.
          <br>
          <br>
          Finally, you need to add locking to the fault ring structure.
          Currently
          <br>
          it's not protected by any locks because only one thread (the
          interrupt
          <br>
          handler) accesses it. Now you have another thread that can
          remove
          <br>
          entries, so you need to protect it with a lock. If you are
          handling
          <br>
          retry faults, you know that the interrupt handler is really a
          worker
          <br>
          thread, so you can use a mutex or a spin-lock, but it doesn't
          need to be
          <br>
          interrupt-safe.
          <br>
        </blockquote>
        <br>
        I don't think you need a lock at all.
        <br>
        <br>
        Just using cmpxchg() to update the key should do it.
        <br>
        <br>
        Something like this:
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault =
        &amp;gmc-&gt;fault_ring[gmc-&gt;fault_hash[hash].idx];
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fault-&gt;timestamp &gt;= stamp) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cmpxchg(&amp;fault-&gt;key, key, 0);
        <br>
      </blockquote>
      <br>
      Good idea. Then we should probably use READ_ONCE and WRITE_ONCE to
      access fault-&gt;key in other places.
      <br>
    </blockquote>
    <p>I will use spinlock to protect fault ring and fault hash table
      access, as atomic_cmpxchg cannot work for 52bit key and VG20 need
      access fault ring in interrupt handler and deferred work.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9ea89549-afb4-ed48-4ff2-0ae740251d59@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = fault-&gt;timestamp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault = &amp;gmc-&gt;fault_ring[fault-&gt;next];
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if the entry was reused */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fault-&gt;timestamp &gt;= tmp)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        Regards,
        <br>
        Christian.
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          &nbsp;&nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; fault-&gt;timestamp = 0;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
            <br>
            index 9d11c02a3938..498a7a0d5a9e 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
            <br>
            @@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *mc);
            <br>
            &nbsp; bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
            uint64_t addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint64_t timestamp);
            <br>
            +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
            *adev, uint64_t addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid);
            <br>
            &nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
            <br>
            &nbsp; void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
            <br>
            &nbsp; int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device
            *adev);
            <br>
          </blockquote>
          _______________________________________________
          <br>
          amd-gfx mailing list
          <br>
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <br>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cfelix.kuehling%40amd.com%7C7d19870014ff40b6d80b08d9049ae8a0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637545885642357593%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=b0LnO9SQPgYskIRH0vCjKebvh%2FYzFfidRne15q2WIXw%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cfelix.kuehling%40amd.com%7C7d19870014ff40b6d80b08d9049ae8a0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637545885642357593%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=b0LnO9SQPgYskIRH0vCjKebvh%2FYzFfidRne15q2WIXw%3D&amp;amp;reserved=0</a>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============1066896152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1066896152==--
