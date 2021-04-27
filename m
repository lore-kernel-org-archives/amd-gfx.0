Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D4C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD5D613CA
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD5D613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B8789DF9;
	Tue, 27 Apr 2021 14:13:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8FA89DF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 14:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jujg3QRIfOb3AVQbWsIyQa52kZ0IFcZ0V/Z6gGJaASjXrSvZGafdJ8n+usDOHvmI4oWUbkuf/13OOfVGMHBEsjz+NmiM6gUpPXtQx2cHQhBmB7gfhpWE4ZwqvceMsQNJNvWPdK5Gv4BEE7xDMXGTS6TiSn1DddkiZsIGNeN4OxXI88OV3aVbHQwWzKNChLEkCBqmhQ2REx1GOUO/442lvX1Qz8aXokQSRoWQWYT7JdXDcI9S4CjycAaUZtU5HFSMSjvhBmVxCZ3DYCBoT9xIVrV446rwwSAMIWFBsrKi8TY4ZYFlA/BRzBQ8BM0LvBw/kh+m4qTBbhcKCtNve1y94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfwqjuxwFgSgnnUwzH6BuC4adxVRm6TQBoLRUblCeI8=;
 b=dc+V4x8eA/AbbAcDn3T7sdg/n3RjdKUssMrwWXxyc7xSz/YOapeAOEVIHLv7zLvhA0RpHX7xGh+NlF6xBe3PghDaRz8EhtVTB+X0Cq/gyx1H3Ttb9QoXua8jM0oEybgudD9paONLF4P5/WfZrr8f1bLoQJR+bD6IZ4Mv2q7h9xuQhydcdna/PGgIThjCGy7y82gjbWBOAJBc2QuHkJE9CnfYxVy4cjJKOFYcryzbLt1PARtB/qg0R0V0XHwtu9AJ69z8KEHKVwA/8/qOPHZ2CsgMZQB6YDI2azyCIAMcKaH7yQSFr7fZ8GYKQpORedifDYCFDYy5Z3zy5iEReE6yMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfwqjuxwFgSgnnUwzH6BuC4adxVRm6TQBoLRUblCeI8=;
 b=PzMUgt6SOnL0NP7T7GBHhHrZntI7oUS6t0ka4MnKn5pWQYfHZgX0bCxIshahqlWEfnLNbJbX6wqJc7gg12VCc/FCqxt1HCOVNS5scQNFY+PUHrl2Gum8hgUsVurFHonjGzo3JpTgKXokCsFHQXMb0HHHpytF4s2SKkDc7BtEK5Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Tue, 27 Apr 2021 14:13:00 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.025; Tue, 27 Apr 2021
 14:12:59 +0000
Subject: Re: [PATCH v4 4/5] drm/amdgpu: address remove from fault filter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210426212631.8130-1-Philip.Yang@amd.com>
 <7b3b212a-bdca-1778-2732-4260253cd45d@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <bc922d64-0002-edaa-f649-020c1aad555c@amd.com>
Date: Tue, 27 Apr 2021 10:12:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <7b3b212a-bdca-1778-2732-4260253cd45d@gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 14:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b52aaa-f167-4cc0-b024-08d909868ffc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595BF3B004F4C32492AF2B5E6419@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLj4zJxdlHaC+/7ViYLgR1Y1w3dF0ZJCwdCktGecA8a450pQfJmN+Zw2WGdSvmbHupXbjTouOOxX/b4ZVhV0fQv5XB1nN+JAC8CxF1b2GERGBnTtclDA3DlODmBf4QjpDx/dSpYKh+ey3ztgtZGdYMwhNYOWfaayu+ZYJL9uUXWgiAuc9e0odUFfFmv9USxmOxGh9onFcHdt87OmJAcGS1m6oXj5yj20YM7u0MdJ5wLizBXAnMT8mwtUMGSTKUp2UPix/fI9fHAUQ2nlpygyMM+FVqXXCsH1RENnNwTdLVGX4Mpkw9OBuJ6k4AOX1F6y73x87sWSowi1feG2O636p+cn4NogcMCuJFCms2ISNzajar4VA/Lp2gr+OHsaLiI7WREruSiCiKDhQ6fbh/vi1t7xmDhGqQh+WHfnXm/strMf6m9B3nQnc4ngu5uTWgigFzLSHoJtYL/+o/W4KZDokJvAdppSQs0eLT3I1ezUM7pef242gZkRfzCXispDCN+RdcG/BnpxYT3ypcmamXzjf7WWJLr5WWuQr2fQv4G7gvUuVXO3WLl9RfUoJiy1NCek1FtaPNJVEu7kb+gopOdBkuH6lzsfmuo7YysN9nbg/w8bi+CCJLfgNp1GwMZM6fQZyqSfjd+nl9b+sia2wwk6DyTh/eK/dD6rYiPDbCPxejhhAkOsAiJmRgLgB+CmG1Yk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(2616005)(956004)(6486002)(316002)(38100700002)(36756003)(31686004)(31696002)(8676002)(5660300002)(2906002)(53546011)(110136005)(186003)(16526019)(66946007)(16576012)(26005)(83380400001)(478600001)(66476007)(8936002)(66574015)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?STZDVmtCMTNySzUwVG9yc21hYlBBdGUwcjUxb2lRYktRM29XNW4wSTkyWHdD?=
 =?utf-8?B?M25iT25ndXdIdW12TVU4ZUt4bEdKdWJxK0hIODJCRkdLSXRNNkFPdjVlMVRV?=
 =?utf-8?B?Y0hzUXg4a0RGUjVLMGVZbnhIUDhxWjZuNm1KYjVkb3c5T3pmMmpJd01QOTIz?=
 =?utf-8?B?bDFvc3FDbllTVnJwM1RXdHF0QzFCZFRQTHNHNGFoZ2RFUENaN0hJYWMzVVZ4?=
 =?utf-8?B?YTUxTXN3d2FadGJHNTdwcW5BVFk0U3NSTlh6YmgvT253OXpmRWNMMHFveE85?=
 =?utf-8?B?MngxaElPL2kzclh2cHk1VzRWanFmUGRFRVlJKzYzYXBCbyt3MFE5VDB3V0Vx?=
 =?utf-8?B?MUZKYzB2dStwR3FhcXBrYTQvZlpYUEZpbjU5am1zSkZiUVVhN2JmRjdSSm1L?=
 =?utf-8?B?YlUydW0zREpVZGxSNXlsUkNBRDN3WW1sMk9SNkJsMVhIcCs2YlRPYkhOR010?=
 =?utf-8?B?SmQzY01NNVhDbXNjbitjQjdEdXQ5YUFIcmVranNFRzBKSFhlUzdzV0VYZkdO?=
 =?utf-8?B?Sy9xMElBd3JEb0xnQ1lMRDRnOXR4WnJLZnVleGE3U1JMOC9pU3NITXRBMkd0?=
 =?utf-8?B?aVBBNEZMeVJzUG8vZDFPT1pwMklMMFVaTDkxM1owZERjcy9MRlVwNnV0TVBx?=
 =?utf-8?B?S0gwRFVqc0U3b3c4dEpnWWFEZEtQa25aUnJJc25qb0ttYitNb0dQazJ2Z1Fl?=
 =?utf-8?B?SjJSTEU1YStFdDE3NTNpT2FBRkZZZml6NUhoeEwwNjZQVFRPT0NJbTNtLzll?=
 =?utf-8?B?L25OVXUwQis3Yiswbk5sTDB1L0c5eU41U2FGQ2JUWVJRTkl6Qm10dUVuWHQx?=
 =?utf-8?B?RUx0SGRWcEloZXFOZjFMWGJ0UjNHWGVmYlRqWkJBQlpTNUI3QnE4TWdGdldI?=
 =?utf-8?B?cHhqbU16ZURxWnArc1gwUmw0K3hscVhpamJmbGJUUXhNWHlJdkxQbTc2TXZk?=
 =?utf-8?B?RENsdDUwTGt3US9oNkxJZ2lDMm43c2gwU09wdncxRTVqSHgxN29OMldJZ3N3?=
 =?utf-8?B?VEQ4Z0FRRDJ2M0hCZmFYdnFJV2lSTEJYclJleWlnMDFzWEtRTGdiZlFQUkh6?=
 =?utf-8?B?Y0RRL3FFS2U2V3JsSzlBaXcxSjRGU2pkcXM2QzBxbm9PcnByYnlOdERQRE5R?=
 =?utf-8?B?UVdzREhLQXJEai9wKzRENTl0dDdScHNaOHpWelBja2ZqSytSTDZWU0xzQ1dq?=
 =?utf-8?B?K20vMm1FTTJYWVdjQmU1SzJhZGNXbnpWT0lmaEY0RUhjbnVveHAwWUFhYlNL?=
 =?utf-8?B?ZlVOdFBtOFJWeHNqd2M5TmMrTk9Xbm9FTVZLcUREREJmdXNoTUNWT0JGVTly?=
 =?utf-8?B?Rm1uejExbHBVaWp5TGdDUDM2RzFBRFR5QkJ4cWRjbmRwOHFWMGN4dWF2bjRS?=
 =?utf-8?B?WDJ2SUVsQkxmOFpMZFIwV0t1Q3Bvd0gwb1l0YWc3Ui94U2FzTzlYYUZUUkVk?=
 =?utf-8?B?SmtXVi9CZkk4TmUzaG54alZ2SWJjRWhJUkdORVcvekl1SGVNNnZMZU9JcGs2?=
 =?utf-8?B?aWZraUx2T0VreHJKRC9kM3JNSmQxSmFzc0drblJ3ZTZKaldrMlR5S1lmcGwz?=
 =?utf-8?B?ZHRabDhvZEtkYWpCVStycWEyNVgwQXA2QVhNNkJpajZEelFnaVAxdGJSb0tl?=
 =?utf-8?B?MVNRR2prTUFmU0hDN1g2aXU5UGw1SDlzTG1ubGVtQW5TcTFZWDdhYTd2RGtp?=
 =?utf-8?B?WHRLMkxzMGVXRkZHa25HZy9yTVA0b1pDWlQ3dWRxODZBMm11aGM0ZG5LNW43?=
 =?utf-8?Q?sV77TTEKYx0VT0kJQ2WWCY9PyCmOpV9rMZpK3rY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b52aaa-f167-4cc0-b024-08d909868ffc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:12:59.7814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8InUo3yfIqXcy5ySuEkt9EP/ud5w9V0RDX5DYLQ2uI16zl8f5EeHeSJqVMCV4wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Content-Type: multipart/mixed; boundary="===============0703129433=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0703129433==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-27 3:25 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7b3b212a-bdca-1778-2732-4260253cd45d@gmail.com">Am
      26.04.21 um 23:26 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Add interface to remove address from fault
        filter ring by resetting
        <br>
        fault ring entry key, then future vm fault on the address will
        be
        <br>
        processed to recover.
        <br>
        <br>
        Define fault key as atomic64_t type to use atomic
        read/set/cmpxchg key
        <br>
        to protect fault ring access by interrupt handler and interrupt
        deferred
        <br>
        work for vg20. Change fault-&gt;timestamp to 56-bit to share
        same uint64_t
        <br>
        with 8-bit fault-&gt;next, it is big enough for 48bit IH
        timestamp.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 54
        +++++++++++++++++++++++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 6 ++-
        <br>
        &nbsp; 2 files changed, 55 insertions(+), 5 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        index c39ed9eb0987..888b749bd75e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        @@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct
        amdgpu_device *adev, struct amdgpu_gmc *mc)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;agp_size &gt;&gt; 20, mc-&gt;agp_start,
        mc-&gt;agp_end);
        <br>
        &nbsp; }
        <br>
        &nbsp; +/**
        <br>
        + * amdgpu_gmc_fault_key - get hask key from vm fault address
        and pasid
        <br>
        + *
        <br>
        + * @addr: 48bit physical address
        <br>
        + * @pasid: 4 bit
        <br>
        + */
        <br>
        +static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr,
        uint16_t pasid)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; return addr &lt;&lt; 4 | pasid;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_gmc_filter_faults - filter VM faults
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -349,13 +360,14 @@ bool amdgpu_gmc_filter_faults(struct
        amdgpu_device *adev, uint64_t addr,
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; uint64_t stamp, key = addr &lt;&lt; 4 | pasid;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t stamp, key = amdgpu_gmc_fault_key(addr, pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_fault *fault;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hash;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we don't have space left in the ring buffer return
        immediately */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GMC_FAULT_TIMEOUT;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gmc-&gt;fault_ring[gmc-&gt;last_fault].timestamp &gt;=
        stamp)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; @@ -365,7 +377,7 @@ bool amdgpu_gmc_filter_faults(struct
        amdgpu_device *adev, uint64_t addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fault-&gt;timestamp &gt;= stamp) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fault-&gt;key == key)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic64_read(&amp;fault-&gt;key) == key)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = fault-&gt;timestamp;
        <br>
        @@ -378,7 +390,7 @@ bool amdgpu_gmc_filter_faults(struct
        amdgpu_device *adev, uint64_t addr,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add the fault to the ring */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault = &amp;gmc-&gt;fault_ring[gmc-&gt;last_fault];
        <br>
        -&nbsp;&nbsp;&nbsp; fault-&gt;key = key;
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_set(&amp;fault-&gt;key, key);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault-&gt;timestamp = timestamp;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* And update the hash */
        <br>
        @@ -387,6 +399,42 @@ bool amdgpu_gmc_filter_faults(struct
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
        + * Remove the address from fault filter, then future vm fault
        on this address
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
        +&nbsp;&nbsp;&nbsp; uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
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
        +&nbsp;&nbsp;&nbsp; while (true) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic64_cmpxchg(&amp;fault-&gt;key, key, 0) ==
        key)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = fault-&gt;timestamp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault = &amp;gmc-&gt;fault_ring[fault-&gt;next];
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if the entry was reused */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fault-&gt;timestamp &gt;= tmp)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
      Maybe rewrite this as &quot;do { ... } while (fault-&gt;timestamp &lt;
      tmp)&quot;.
      <br>
      <br>
      <blockquote type="cite">+}
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
        index 9d11c02a3938..95e18ef83aec 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        @@ -66,9 +66,9 @@ struct firmware;
        <br>
        &nbsp;&nbsp; * GMC page fault information
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; struct amdgpu_gmc_fault {
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; timestamp;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; timestamp:56;
        <br>
      </blockquote>
      <br>
      I think 48 bits should be enough for the timestamp for current
      hardware.
      <br>
      <br>
    </blockquote>
    <p>Thanks for the advise, I will fix both and send out new patch.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:7b3b212a-bdca-1778-2732-4260253cd45d@gmail.com">Apart
      from that looks good to me now,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;
        next:AMDGPU_GMC_FAULT_RING_ORDER;
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; key:52;
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp; key;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; /*
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
      <br>
    </blockquote>
  </body>
</html>

--===============0703129433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0703129433==--
