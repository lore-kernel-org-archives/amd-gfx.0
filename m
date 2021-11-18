Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B480961A55
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B480961A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455066E950;
	Thu, 18 Nov 2021 16:19:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EE76E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrMMoFPzt/z5njJG2XN/aW7zdwktLdvJSvMJynkrofWqEID2rWEs3smdALWoGS+0E7csZBRdrh67Pn4XwVbSD9y4NyqrPfGmQwvQMNo77Xw6/OpXrNs93+jDTyHSenftbBvHzarTsjDdCRF540P/oOjNeOFE+MQtV871b40uExzQ0DCFm4AgRzsLmDUNC52IhNT/TfqtmgYP3uq6A/Nb4bZsR9hwAwPW6/Hzg5hsyd2sB1kpyqSoQHexqUQioJ3PnIg26efNtRC8aNg9rB74cX5FPRGzvWuid63TUYujxb+A/QjPXAgxnu2J31btxPk8HcxsB5ou2/Wb4SjUAuEFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUDEPaIWPaphQ9ebXNodensiKzl5GaOiuhp2F1AURLI=;
 b=dkfv0/RGRYjJBIB9pAMkEhMxPVtvn+aVg05k+H/jHDK0RNn+WuhCzBTlBwUcUPnBHy+uwv9aDdBU1jcOoFdfMGYYaElfPmQp6MeB7B/nJc663+lOAPHKB+JWF4dJWT73KMWsVj5Ibv89LpmIoIyvSsqfzYUb6TN1k4Ophp0vC3sMDm8HpswNPs1r+YDPjRv5NpN8nkWfKxRFd4BdLpATRxMxqvvJLRy6EIc0THpdIdDrtW7Baxfu1dmiBC2t0z+sCWKfy/WUfvAJegly4ZauCJJfI+QqSEg8N/FtrjE6onxqv2izG8ix8VffV/dOaOXQMIKsJuwLv4zCvofokGVoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUDEPaIWPaphQ9ebXNodensiKzl5GaOiuhp2F1AURLI=;
 b=IPEpWUaCLXW8o0VeqbVkw23r2jomf/8XeegNGkykXmPXIKlV62aXxqQX8KjG/cCHkE1jn8wi1TY5A6I5xXGBst9YBbPvsAF7CaDaMJGxXB8lzeiR9am9goYGCmGW0QLwvtWISnJjjdlXzUwwiFaY3p6Ymtb5V4uZpHsnt+7Uoz8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 18 Nov
 2021 16:19:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 16:19:49 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: simplify drain retry fault
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-3-Philip.Yang@amd.com>
 <71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <eac293ce-bbf5-fe59-a12c-b0113e64f66e@amd.com>
Date: Thu, 18 Nov 2021 11:19:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:208:51::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Thu, 18 Nov 2021 16:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2087bb4b-42b2-483e-7131-08d9aaaf3ded
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5325B8E5DE829A9D2DA8794FE69B9@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zKBq1rM/qoMo5Vnov2fZT84mCVI9EXcZrZd03Pf8OuorOSDswTTceGP9ygMkE55QXXBXZI0rVo3wfNsTX46Rv0jBY70T+Pct/+i2IyZNNWf3y5Ew6HwhHnMNZNFzCWMt6Q2JIiVI01sXx4nVpslERMz0Un37TMo1FCsVO4+TXzma90o5AyLaTvT6brJikXooiELG2/WsU4Jfwfu2pye0uGXSX6NLtaR4qELrV2k6RQcPaPeobKv/4ew50LtkaOpADhSylsLUsdZIjhIHwDss0Wh/zRmMJlp3BvCXAH2xCu34aYC2/JzEY9HurJxp29nsgxa/I5IZPdRcroOZUdiHi0clIW9FHFwmE6rBZhr82+/B5qVuLtgevFkdK8Krn7sihRA16aMycqHSHHNsa5r/YnCwDPJ+toVoG3PqJQfFtKFD1UQ22JgeADPM52uQEJRTM54F3GVtKkiYluU7Gxl1NnA23M5ahS+tR7a7WnQboc+Tt4+k1TT3UkHQGTsu7XgqqUihnHvm964VYOWzG4Fry0WGqdapT21c14TT/CsrG9PEmnSZD//Cr1NL+9OnO1baGaNY1PEo+F2TkFMBev9L8oosv4meOicJMGov3QX/SGBsrc+Wp6nPHSR9vpCeCsSMTO27iHYvRLsiY88Wn/Dv+LEHMnVFGeHfR6iqhIRuNBsiWpoI9AkPYGoF7hA1jfpmRnfneoqMHVE7KHDPr7I06KjdEbd94wqThxaTse90nI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(186003)(53546011)(66476007)(36756003)(8676002)(956004)(83380400001)(2616005)(316002)(6486002)(31686004)(508600001)(110136005)(16576012)(5660300002)(31696002)(26005)(2906002)(4001150100001)(66556008)(38100700002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFp4NEJXRlJHT1Q4K2tTeng0UVFoQTFjMzR3RXZCQUxaR0J1aDhXREo2cFcz?=
 =?utf-8?B?OUUvVFAzdUFmejR2YmxpcUo5a3NabUFTVGF1N2M3N01VSysya1Mybkt1b29U?=
 =?utf-8?B?aUhQcFByL0h0anRhang2K1BxYWgzNUhCRG1LeEIyN1dZYndtOGNlTGI1cjFM?=
 =?utf-8?B?Wm1zVUhSVVkxYWt4N2RiTDZ1dGdzajJaaVVKbXVWdHgrM0ZsMUEwNWNvb3dk?=
 =?utf-8?B?QlBTb2RYanQzTHk1aXBRc0VsUmhiMEk4SDJyaEhRRTNCa2lpOWNjYXZFc0Nk?=
 =?utf-8?B?dUxaVXViY3l6NEp0b2lyMmJjclRXWXdiZGM4aDlnNVBBN0tLbDgvbU5tby9H?=
 =?utf-8?B?WFoweWdEV1lOUDI0ZFFqT0d1aUxmbnRjMXgrVHM4OVJtZUwyOUZKOGRwQTV6?=
 =?utf-8?B?QlJYckRUdEY1ZGRJOWNsL21PeDU1TUt6TVpVa3h0M2wwTmhaV0NZdVV3TzdH?=
 =?utf-8?B?NncyZjk3R1NtdUNFVGJ6U01RTU1oK3RLQlNBWU9LWGlYR0xaU0NROUdZVzBt?=
 =?utf-8?B?eHFsK0k3WDg3RStKSE53dUNCMkQ3QXhPdTY1NkhTQkpIOVR2eTZxcFRGQVNO?=
 =?utf-8?B?TEtiOGdObUxHSkJLdEt3bDJlWkdVOGRtbkxKYWtBL01GQXZ2Z0Zqc0h0UDRv?=
 =?utf-8?B?N3pBRVVUZ2pRL2VpT2lobmlWQkhUQkxiUUt6aXQ3cXdna09DYWErN1BEQmpC?=
 =?utf-8?B?ZG9sM3hpNmVjNExBdDdzOXkwNm9yTGt0clZtSW5tcGxERC9TOWszYzhxK0l3?=
 =?utf-8?B?OXBrNWxWSlVKcFUxLzYzSnduUTdVWWl4VUFZenNiNjZVVTRLR2cxb2NnSW56?=
 =?utf-8?B?U1JHd1hLQjFXN1RCTTNqYVE5Rmg1bm1hT1FRS2NtVUF4dUt3TldocGxYWmJE?=
 =?utf-8?B?NndQTWo0Zm54cUNvKzJ1YXFLVDJVV0huQzZjd3YzTVZUQTIzTjVuaWZVQzlr?=
 =?utf-8?B?QVE3QlJtcVhHRUYxcStMVmttUVRYUjdSMGlOZU04Y0p2MXIvRnl4UE96VkVX?=
 =?utf-8?B?NTNVZWRSL1E4bmFqZzhFWlJmNVIreTV0dFErUWIwS0tvVnladTUzR3d6ajlM?=
 =?utf-8?B?WjFPNWlvZ29xY2QrZTNNWlNnY1VGYzJwTTNkWXZMcTRNaEd5Y3lhL2EvNE1L?=
 =?utf-8?B?c09OUXFjd0EwS2ZaRTdFNmlQWVRjcDh0U2x6ZjFmTmdTdEFSZmxvSkJpMVRE?=
 =?utf-8?B?ZVNvOEVPV29EeGhISm9qNjlZNCtZT0xQRjZiR1lnYmdUTVRCd0I2bDFzc3lp?=
 =?utf-8?B?OTg2bGZiWmN6K2Y1cmNkNzVYVmg2RXpkZUhqY0JZenl1bGxVOUhNUGlSQzI4?=
 =?utf-8?B?aTJBNjdoWTA1b3VNNXFGOFlFK0lENUd2emxReDJ0SXRGem1zbFZkS1NJWktG?=
 =?utf-8?B?R05kMkgvSnR1WFo1RWJNUVhMamNKSXN0TzFkdndkdDBhc2oxR3E5SkszbnFS?=
 =?utf-8?B?dmpVN05ONVB1SnpHU1FrQlVPaDdnUkxoSTVJR0t0UHlEdk1MSzNDaGJtNkZD?=
 =?utf-8?B?K01rUDVCZmpDM1VzaGJVSFdiU21UOEtZd0taYSsycDRVZzBXTkhIdUJRSytw?=
 =?utf-8?B?TGR2dWpxaFBmQnc2UGZ6VDJweWpNdTRRc2dhV1Z5QnVRalp5TjRFZXJzSEZN?=
 =?utf-8?B?OWUzd0RwRktwRnZoUXFYRTc2cFhwUVdkSEFxVm1uSzF5OXY2TGgyLzV0eE8z?=
 =?utf-8?B?bjBTR2lBUHlWRGJiRmptN2l6Tzh0bHFiL0lqSWJrU0FMMEtqRDREMFFVbHBS?=
 =?utf-8?B?anZJY01PeHdvRzRjYmRwZUhMRGZneElEVHlOejhxQ1dKVjBKcUdxVHpEVHJx?=
 =?utf-8?B?UDNPM0hPZUdHU0tia1F3M05sekU4c0taYnJ2YS92UGg3QkRNMXI5ankrbzNH?=
 =?utf-8?B?eFhQRGxYS2VnbmpyRE5SZklmTjJIQitXNldFUDg4SHpRUCtrSlNtcytYMmp5?=
 =?utf-8?B?N3JMeWU1TDd0b3JUam9NWEQ2b0Y0NkxMYk53SHR4dXd1b0pSdHF3TlpJZGMx?=
 =?utf-8?B?ZFdwOXIzeSt0eVpoN2FVSVQxcGN5VEovVDNQSTJoUCsyMmtabmlOQmxlZWNZ?=
 =?utf-8?B?RVh1cTBDOE8zVHdOdEl2RDZZdS9aeTBVWk5QZGxRWUJUVkxheGlZdDFDUnIx?=
 =?utf-8?Q?4jZM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2087bb4b-42b2-483e-7131-08d9aaaf3ded
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:19:48.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fhjHTVjtXxBAv2Il2vdK5U8NT2ymLffuiBddqYwqmL5TNNoEfWo843sjmsntS0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-17 7:14 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com">
      <br>
      On 2021-11-16 10:43 p.m., Philip Yang wrote:
      <br>
      <blockquote type="cite">unmap range always set
        svms-&gt;drain_pagefaults flag to simplify both
        <br>
        parent range and child range unmap. Deferred list work takes
        mmap write
        <br>
        lock to read and clear svms-&gt;drain_pagefaults, to serialize
        with unmap
        <br>
        callback.
        <br>
        <br>
        Add atomic flag svms-&gt;draining_faults, if
        svms-&gt;draining_faults is set,
        <br>
        page fault handle ignore the retry fault, to speed up interrupt
        handling.
        <br>
      </blockquote>
      Having both svms-&gt;drain_pagefaults and svms-&gt;draining_faults
      is confusing. Do we really need both?
    </blockquote>
    <p>Using one flag, I can not find a way to handle the case, unmap
      new range. if the flag is set, restore_pages uses the flag to drop
      fault, then drain_retry_fault reset the flag after draining is
      done, we will not able to drain retry fault for the new range.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp; | 24
        ++++++++++++++++++------
        <br>
        &nbsp; 2 files changed, 19 insertions(+), 6 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 1d3f012bcd2a..4e4640b731e1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -767,6 +767,7 @@ struct svm_range_list {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deferred_list_lock;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evicted_ranges;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drain_pagefaults;
        <br>
        +&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; draining_faults;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restore_work;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *faulting_task;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 3eb0a9491755..d332462bf9d3 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1962,6 +1962,7 @@ void svm_range_drain_retry_fault(struct
        svm_range_list *svms)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(i, svms-&gt;bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = p-&gt;pdds[i];
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)
        <br>
        @@ -1975,6 +1976,7 @@ void svm_range_drain_retry_fault(struct
        svm_range_list *svms)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;adev-&gt;irq.ih1_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;,
        i, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 0);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static void svm_range_deferred_list_work(struct work_struct
        *work)
        <br>
        @@ -2002,6 +2004,7 @@ static void
        svm_range_deferred_list_work(struct work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mmap write lock to serialize with munmap notifiers.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(READ_ONCE(svms-&gt;drain_pagefaults))) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(svms-&gt;drain_pagefaults, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_drain_retry_fault(svms);
        <br>
        @@ -2049,12 +2052,6 @@ svm_range_add_list_work(struct
        svm_range_list *svms, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, enum svm_work_list_ops op)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svms-&gt;deferred_list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; /* Make sure pending page faults are drained in the
        deferred worker
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; * before the range is freed to avoid straggler interrupts
        on
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; * unmapped memory causing &quot;phantom faults&quot;.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; if (op == SVM_OP_UNMAP_RANGE)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;drain_pagefaults = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if prange is on the deferred list */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;prange-&gt;deferred_list)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;update exist prange 0x%p work op %d\n&quot;,
        prange, op);
        <br>
        @@ -2133,6 +2130,13 @@ svm_range_unmap_from_cpu(struct mm_struct
        *mm, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx
        0x%lx]\n&quot;, svms,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, prange-&gt;start, prange-&gt;last, start,
        last);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* Make sure pending page faults are drained in the
        deferred worker
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * before the range is freed to avoid straggler interrupts
        on
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * unmapped memory causing &quot;phantom faults&quot;.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; pr_debug(&quot;set range drain_pagefaults true\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; WRITE_ONCE(svms-&gt;drain_pagefaults, true);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_parent = start &lt;= prange-&gt;start &amp;&amp;
        last &gt;= prange-&gt;last;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild, &amp;prange-&gt;child_list,
        child_list) {
        <br>
        @@ -2595,6 +2599,13 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (!!atomic_read(&amp;svms-&gt;draining_faults) ||
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; READ_ONCE(svms-&gt;drain_pagefaults)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;,
        addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_mm;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt;
        vma-&gt;vm_start) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA not found for address 0x%llx\n&quot;, addr);
        <br>
        @@ -2732,6 +2743,7 @@ int svm_range_list_init(struct kfd_process
        *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;svms-&gt;lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;svms-&gt;list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;evicted_ranges, 0);
        <br>
        +&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;svms-&gt;restore_work,
        svm_range_restore_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;svms-&gt;deferred_list_work,
        svm_range_deferred_list_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
