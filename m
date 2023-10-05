Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC2CE92731
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7040A10E186;
	Thu,  5 Oct 2023 19:33:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3926210E186
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzVagGveGu6YXiMqaVUkqif2IQzNZkxVagoy9X7WNfFsPiFcgByxYZLeud+TzEMFTYkqLTap83LN8IiDF5EqNFvARQ8XPnBdEa/wXoohUkgNF8BbkAO1JRHyhkivdi2vaBq9dFQIqbhKmUhlo4pqxb0JpCzBpa5Bz4AyI3ZXyXV0AHsl8W/VjRArBwr3RJfkcbE0JLq32QaF0z/9lSro/2GNdHx+U8Z+aIO+P2pQO9YKWz9qbDfZW8JnvsbLzBgTiV62u8Oe2mqHJeZyBjd5E72N1GmHXNAPJKDhQEMcOsrHO4H9n6HGbUZm2Ov83ri8OITDFJQWLNuQJwrYtx524A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XceZRwmVGXzbJfLR0V8KLsQiysejGCyr/AW3lqZB4kE=;
 b=SAmh4ZbBpS8xtRRFnNkSv7q+uSp3yEsTrIZWO16zv8UrviUvcV3ehK3ifCwGnMM6CMSVw6bGsUqO7HdxtzL16vvIv7xCEMzxpDLZVA5Sd18tXEGbpkyh+hAbCzfNnW+mQQY78k5MO1LgtOjkNahGyda8bQPTD4o0+pHr/E4484k8e+eopkh/XCi59CBb8hetk7+3jq+9GgX0IflOLZP9Ndm3aOUiNMx/AmoC7WHG4IqnKO4yLUqQ0vsW3vWv+wk/SngOQs8KYZFgiwd90U/1GdU6VFtdudkHZaE8Gc9gYVYrZQZ+ap+FqKcCnXYCRB/vLIJ5ahDdvlWgK3Vu6bV0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XceZRwmVGXzbJfLR0V8KLsQiysejGCyr/AW3lqZB4kE=;
 b=bR0KmtcnwtIE0oWV7KEgewpIc3U9cJXGnmrQFxKhTh9RJ9FyTJ32YZiSrUq5h1WyCoHI1mhgIVwgw2xZbyGpa+falwrIM2VVg1Q0IH8x9lq6f8/tXkQSpTouYyRgnyscrZFPoBB05bKAhy0Wg7eW+vYjrBI1dh0dTZ4cBPtekLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 19:33:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:33:44 +0000
Message-ID: <6394e283-ba5e-9d9f-797b-8cae24909a98@amd.com>
Date: Thu, 5 Oct 2023 15:33:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] amd/amdkfd: Unmap range from GPUs based on granularity
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-2-Philip.Yang@amd.com>
 <af89092e-663e-6487-9c0e-048ccd715ed0@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <af89092e-663e-6487-9c0e-048ccd715ed0@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 06da5bb8-54e3-4082-0f5e-08dbc5d9fce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EUnR5KvyOxMveXrLoouoGffkgbIzNW5nKgKFfWeI33ZsCxWSPBAN/7Y1a2dhqk9nNdjiqGEjAe7wQeiT/zrRRjnmF4iWc4vkY1vD0fP6uCN7SmDEsyOk8D6B4LLK9gor09Ur8Ug1NBg0fUYCKeOzmrR0rmnSvmk9EwBGrYZieIJll/SSqdF4hQj3NSDQ0ay+PXEiY4nIAybAceMT6pC2806Ctzgo0NasOkBXbBMsRxvD8JKuJUReT2zZJZRI8Txk0+YL0c/53JSi/JDVaGY8ssvvsEUs2/08FpWSaG4qpQmSA3dlmBO+rCKHRyEI+LlTsRnCKFcCTZsMtUVVyOqmg1dz1eTuDmEtCrFwUHtg03MA0LwRLVhY6jGpalhxYyfxDfKOUziwJmXmbNdVwqnxNL1z3FyUeIgBZ0FmD0jiu7iDGGA8y9yxNbAggEM7Fa6A7yfN4vNxOP1G0br6Rn4QC1+s7Q8rwPqUZ4S/GOyTqEVermKwfTXNbhZXwDPMwy1x3f6C0G3qAg5IpRina4ZpiHe7vi71uNUbRstAWkADIPpn11nLJ/jmN9ogTKrrwbNl2Aw69Gib+dNU2ZgLK6PEofa0slNMWzMbm3Ywf8jGkUDQskiSjUcEfzbdGSb+xm2rROejwbHd0J/7iCXJrcnhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(31686004)(36756003)(6512007)(31696002)(6666004)(53546011)(6506007)(478600001)(316002)(66556008)(6486002)(2616005)(66946007)(41300700001)(38100700002)(26005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(110136005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdUcDc0UndBNjVCOWRxdHNVRjZrVXJLQ096cEoxS2FScTU2YUtrVXNvY3VJ?=
 =?utf-8?B?NjZpK0tmY1E2cFJKK0NSU1NsTW44OGUxR1E1YjFEQ3Z6NndBUkZZV2xtR29F?=
 =?utf-8?B?Ti9EdjB4SjBsejNZSER4VWxuNENac3Q4OEZGNWlOeEpxWGFKckNIenAzQ2dY?=
 =?utf-8?B?TmxpdkcrOEE4YURpWjFSY0w4SDJya2Z6UjFGYWQxaS9aQmdFOWxiVCt5dTZ0?=
 =?utf-8?B?OWN6TnVFdVk5RzhKQ1VkRjMyNUxRNHl6MTgxQnFwZzd1KzdpMHdsNWxZd0Q4?=
 =?utf-8?B?b2xyYWpuS2ZCYTRSaGN2SWVjOEVnUHA5ZzFKK2xTdlFWR2lLeEdReGtBWU9K?=
 =?utf-8?B?am9rUkowcnZ2MnlsQzZScHhKWlZLV1cxbDFoeUhkckpLd0ZJd1lGdDBjcUF4?=
 =?utf-8?B?VG5jdXF5VHBtaUNnamZmNmFMYTVTMExkMU5hSVVUaExPaUxzRG81UDl4Umpr?=
 =?utf-8?B?TDZjRjd3ZUpveVFkeUJOMFQzL3UzRXdNRmU1TFN2eDVKWXlnNmpWMFFVbFBs?=
 =?utf-8?B?b1BNK1ZXUk5KcHRVTGlIYWVBRWlsVC9BUG4yQ3czelcrY0NERXhMUmZTbW1K?=
 =?utf-8?B?Yml2Qnl0a2pXeGI0ankrZkpla05CcmZIQitlTUJ2WnhPVkFaUitaTG1IYzRY?=
 =?utf-8?B?VWw3N3h3aytFVi9qOEdGdVNIU0NOR1NOR0NZdDg0Yk1OVUZ2TW5qUm5TNi92?=
 =?utf-8?B?a3BEbDhkYUR5MjVSV2EvZm9IUyt3aWdMUjNOd05iT01VRXJyd0JCWTBoSmtT?=
 =?utf-8?B?MG1wdndRcEQyRFJLUjdlRFRVM21HZ0JkY094cWExdGNzYk4yd3JRQUZFRUtE?=
 =?utf-8?B?eERXUGdRNDFGdjJIRW5WTUl1cVRQL0hYM1oxWVNmcjdULzlHMjkxQ2ZLeDQ1?=
 =?utf-8?B?SjZwU0ZFMFpFMnFLbTNYQzhQWkhtUjdXTlcxRWtIME5MblJVWFJTU2JidnhF?=
 =?utf-8?B?b2tOT2dsa1lpMWR4QkdkNEZRbFp3eGtmRGtqYzhhWjhRUXlUQlQxK21Gditr?=
 =?utf-8?B?enJlZHhvZWtONmoxVFRDTEZmQkxPRm1TcWYzR2ZxakZkRENockxHWE1MMVR3?=
 =?utf-8?B?S2F3RmRyZWxrcURrOC9mc2VkNHFEUjRhQm9WQ3k4bFFwY1RtbXZwZVdmWlRN?=
 =?utf-8?B?RnFmeVVOaER5VlRSSk0vaVpLeHVOMGFZeXc1OXpLQ0pYajF3cUxDblBnSmRw?=
 =?utf-8?B?TWxmcU1CQjkwYnhpdi9hdFBRMWR1ajU0eU9hQzVTNTZXUHd0VGQ3WGgwQnBx?=
 =?utf-8?B?a2VFRHVjckxUSnNZV3g2UUJkNUd2aGxWZ3pTRUhRbkc0WWxOYlJPTG1WbXJY?=
 =?utf-8?B?NVREeFJhcFpTM29GYVJ4ZWpzaUZGd1RSZHE2TmRjNFE2cXUxREtDMEJ1d0gx?=
 =?utf-8?B?Y1M4UlVOOW9pTnI0MSs4VTF2dWNNdE5YWDY4Tll1VHNGR095WGgvLzQ0S2tX?=
 =?utf-8?B?Tk5JUjIvZCttdWtwMGdkSFdSZ3U4QVpvNGp1MW5sSlpmWk1RRFFvankxMmty?=
 =?utf-8?B?bjlRNkNTM0dzb1JwTy8wcFI1Rlp4VVU4dzRkaXAxckNUMlRQWkZaS05nRHY5?=
 =?utf-8?B?RjkvMSsyb2JLYURWK2J1cm1OQm5HdDg4QlUyT2RrdStPbnQzQnBFSlN6NmRV?=
 =?utf-8?B?dWdyRHljOFVacWczT2MvVksrRzlyVUs1cDZKVGxZenh0WldwdEI5cEhWM1ZE?=
 =?utf-8?B?Y01Sc09tK2ZqR0s3b3FzL2RmUUNLTndkYlJmR3JwemtGVDF4dFVoK2FWM2pk?=
 =?utf-8?B?Tk5lYUp1VHYrU2tVRUp1VGh0UTB4S0JWdHZWVjlLYW5MSjlmRkFON3pMemYz?=
 =?utf-8?B?Ty80aUtEOGhwUFA5V0lQbHlOdTU0cmlYUitwUHFPck1QR0NBQWhQV0txL28w?=
 =?utf-8?B?WW5ZbU1BOWZzZVBjaXdKUTFmUGJncERtOHhQaW5mcCtyMlBjNVF4WElVL1Ny?=
 =?utf-8?B?WjhtR09GMDZsSjZsQlhyNDdQS3o3UEE2eXV3bDViSXlja0orMWZjSkp2elVY?=
 =?utf-8?B?cEhBYys4Wm5TV3BUOXl5MWhyMkVaYTlQLzNsTkVTTzAzcDg3bDVRU3dvL3ZZ?=
 =?utf-8?B?RmZOQTVNZkRiRlIrQkdjaENLMWthdGFJOW5uU3BXWTMvK1FiM0pWVEJwMFJn?=
 =?utf-8?Q?lACo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da5bb8-54e3-4082-0f5e-08dbc5d9fce4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:33:44.5799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErvRIBBnD588SkA+X1JzahZbu8bTK/OcGAoC491L58Ad7x7I/rIp/6teZN1qldqP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-02 13:06, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:af89092e-663e-6487-9c0e-048ccd715ed0@amd.com">
      <br>
      On 9/29/2023 9:11 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Align unmap range start and last address to granularity
        boundary.
        <br>
        Skip unmap if range is already unmapped from GPUs.
        <br>
        <br>
        This also solve the rocgdb CWSR migration related issue.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35
        ++++++++++++++++++++++++----
        <br>
        &nbsp; 1 file changed, 31 insertions(+), 4 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 626e0dd4ec79..ac65bf25c685 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmput(mm);
        <br>
        &nbsp; }
        <br>
        <br>
        +static unsigned long
        <br>
        +svm_range_align_start(struct svm_range *prange, unsigned long
        start)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start_align;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_align = ALIGN_DOWN(start, 1UL &lt;&lt;
        prange-&gt;granularity);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_align = max_t(unsigned long, start_align,
        prange-&gt;start);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return start_align;
        <br>
        +}
        <br>
        +
        <br>
        +static unsigned long
        <br>
        +svm_range_align_last(struct svm_range *prange, unsigned long
        last)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last_align;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_align = ALIGN(last, 1UL &lt;&lt;
        prange-&gt;granularity) - 1;
        <br>
      </blockquote>
      <br>
      should be ALIGN(last + 1, 1UL &lt;&lt; prange-&gt;granularity) -
      1;? Here last is included last page number.
      <br>
    </blockquote>
    yes, you are right, if evicting range [0, 0x200], we should unmap
    range [0x, 0x3ff].<br>
    <blockquote type="cite" cite="mid:af89092e-663e-6487-9c0e-048ccd715ed0@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_align = min_t(unsigned long,
        last_align, prange-&gt;last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return last_align;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * svm_range_evict - evict svm range
        <br>
        &nbsp;&nbsp; * @prange: svm range structure
        <br>
        @@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long s, l;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger;
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_range_partial_mapped(prange, start,
        last)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]
        unmapped already\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms, start, last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (event == MMU_NOTIFY_MIGRATE)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger =
        KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        @@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;invalidate unmap svms 0x%p [0x%lx
        0x%lx] from GPUs\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms, start, last);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild,
        &amp;prange-&gt;child_list, child_list) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested(&amp;pchild-&gt;lock,
        1);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = max(start, pchild-&gt;start);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l = min(last, pchild-&gt;last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = svm_range_align_start(pchild,
        start);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l = svm_range_align_last(pchild, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l &gt;= s)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        svm_range_unmap_from_gpus(pchild, s, l, trigger);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pchild-&gt;lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = max(start, prange-&gt;start);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l = min(last, prange-&gt;last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = svm_range_align_start(prange, start);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l = svm_range_align_last(prange, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l &gt;= s)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unmap_from_gpus(prange, s, l,
        trigger);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        --
        <br>
        2.35.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
