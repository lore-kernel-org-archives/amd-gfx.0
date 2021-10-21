Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328F56147F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 328F56147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9A06ECDC;
	Thu, 21 Oct 2021 16:55:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254016ECD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPctvfXmvDq8NMZh5mZjS8ud77PoWdBor8UCm58gD6aAwmZ+oSLpMr1VBbDDenCTGYB5HFgUgFxZB1I4rhG2e8EeMIre5fE57rTOfg8d4v5jiXdcTXFq8XS6oWe5aUF5Nl0rBg5zPugqe0sUPcl/gAsyCeX5Gpve6Bo/ZVVd6w5TThb/QUNRzkxxJ6FY0i450OUczwk+PXr55+98dL2Xb1dheiYutGcz8b/wBJNyUrSh6jBEYw47QUgHbX73d17kRlYBP8upzqXm7q+mBhA3KZj/c16x2qHG2PciinQTXORWSMp9j62uK7/tu3Etdic+7DasDGO3R2onysE7b8UjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUQTf/4zVTqGoPkWcghu8D7HHZu06qzRVL87GmXyxKU=;
 b=hB0U6BVkuZBt5rEUU34qnT6ENCMoSnmkIVLkQc6qhPeKTjaL4KPjMCzO6H0bsPoicp6ynVOyKXL5KAf2ChQqYPAYphvzaZ4kQxru0J2BasedQy9VnmsFqa7RWQcFpaROO5gUU0R06fpghvmjcwWY5MJRZhy7gAf4581ack/J4499732KJ70xGJHJvcZeam5zse352wt8YHSydE5GRUgCDwexJzVqaxCPOhCyGrwmZ/ZOjN+8dTb4KG2tKtj5od+lN6y81bTAvfGXzd0owa880QlzUyr2zKRta+hCToqyLNvaRI3ngB05Njz2GX37JGjDErizC4Ncj6/SQjuIiLpt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUQTf/4zVTqGoPkWcghu8D7HHZu06qzRVL87GmXyxKU=;
 b=Gat4+JopajhHmHLEN23cn7YtqTqMPRd1lGxg9a4Am6mTipiyK7Agshlk2E/nETLl/y8Q9lOOi2WbQJEHj6lZoesKWgsAUd57InO8pMTqW17gcd3TFjhNS0/L1oAQU2Tzhr+S169bSfHRLzoSs1qgRBnGx8HWIAbztljIKKctACE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB3736.namprd12.prod.outlook.com (2603:10b6:610:2b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 16:55:40 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:55:40 +0000
Message-ID: <0cdf56a3-0e0c-bc5e-5dbf-be83b9bcd44d@amd.com>
Date: Thu, 21 Oct 2021 12:55:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring
 bad page threshold
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <20211021155711.1191830-2-kent.russell@amd.com>
 <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
 <DM6PR12MB332402EACCE9F2EC589B2DF285BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <57a2fca7-0da8-55d6-d545-7c0dcf598628@amd.com>
 <DM6PR12MB33243CD65F93A887F212569A85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB33243CD65F93A887F212569A85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [10.254.34.99] (165.204.84.11) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:55:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1858eff0-eb0e-45a6-8ed8-08d994b39d29
X-MS-TrafficTypeDiagnostic: CH2PR12MB3736:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3736FFDF063DC1DB8A77B28499BF9@CH2PR12MB3736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3Wn7nbrLDCHRalKgZD3VEDie+juLNoBsy0700oqml/ui2ONMzB/XmR4GUzaWmXZhhsLeHLgpYw83peGgJ4LfB7codb2iLb1/78YL26A/DQf9QBPTf9zI9fajVgatHTwENQx5WVc9OmQs0QAKBBU07oBw87YsD2dGKyw44vbr9LLRMKIkskh4RO1tk6GY04VyX8Phs4hzTLZ+DoCSKfFGzaJjVp490yP2tNbU9Z9T+N5Qz4ztLj81XKUb3O733gIS+UtjTansXCQL5oiXYUn2q3b5zSHdhy/cxCK93K4aHSvK1DaJofSq0xmJ/8ndQJbUEJYMV23nZ88lWzw38kMzCu/uqOv+u0mKEjR+P0HfFLGaqp/kpRMQ/jhC74EpiD9A8rU1mi6tziIUu2Ir85PercLZX2byLR2w5NihliraOfZdpChpJKTXbSGYTafMMYpikfLil5DexCs2K/0xhS4+9FvwV+K0rXKCH1PjjXxVF4LLFNNRQ/mnjX2DoKgZd1ueU09rvec+NsEmuM/3bSfZRIQZwz1m4KKW6hRUfJW66/10NKKe2qqBZ6HZhsKOcx6eCoQdNtqJiBZvt7o1app03BMCNH4nGyLKjLJGAaxGjHdWzCY2pMbRsmnRle4ycKsdynwdv1tYAXNAaUm8m0UBiv2pRciRnz5AobrRUk5mz0q4tv9rZ+Y2SxpXsaIGZSnqRt7iwRb+6VEod3zNoU+jn+6wpVzIt+vgc6P30nlt9kghjIc6jmguaqlrf6PFfg0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(26005)(6486002)(5660300002)(8676002)(508600001)(31686004)(6666004)(186003)(4001150100001)(4326008)(54906003)(83380400001)(38100700002)(2906002)(86362001)(36756003)(53546011)(66556008)(110136005)(66946007)(2616005)(66476007)(956004)(316002)(16576012)(44832011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pHRzFwV2NWSXUrYXArd0xETVE2Q2lTSnBESnl3Y0NudU5hSkxjeWJISjl6?=
 =?utf-8?B?S0QzbmFDbVZGZ0tySGFFT3gzbEcrdy8rV3JRN0ZoQ3JDSi9sZTgrbUkvSTBX?=
 =?utf-8?B?RkR4NExkZWtZN2FxbzU5NjVCZUxxdkN5SXNpS092eE1OdllNaXBRb2k5amxy?=
 =?utf-8?B?Q3FHNEIxY1dtMVFqMzRnSHJSVHNYbnNiR0NOeU9BZURmbU1EYWZJTVk2YmtM?=
 =?utf-8?B?SWM4NTk5clNMby9xQjZoSnB5QkcyeCtnZ3FQMDJjdnFXS1d3SEw0RWRGMjQr?=
 =?utf-8?B?dFFOdlhNQ3oyOWRGcFJydnMxVmtYZ3JDUTBLYks4UWJoN2p4RE9WZXlESitZ?=
 =?utf-8?B?ZTBLNnUwRUZtNVdqenljd2UrZlhDdFR6VTFhVVRXdVk3MjBlcWlDb1Z2bVVZ?=
 =?utf-8?B?NGN1LzMrdm9WQ0I5bUMxaE9tVG04KzcrTnYvTHQwNTFPYlJlMEZjMTJmUEd0?=
 =?utf-8?B?bFVZTFFTL2dGQ3NyT1ZKNmV0aDdLOG95UVBvdnpkdVNHRGZlZXBBNld4WGo0?=
 =?utf-8?B?OExIdWgwOFdIZk9tTUVMYnc5ZGtKZnNMcXM5Z1FVVU92Q3lBQVM0eWR0RmMw?=
 =?utf-8?B?SFREcjVrczUvMnZaRE1BQ3pVVkcxQ3VBMjRJNnI1dFR0MStxUVNqU0tZWENV?=
 =?utf-8?B?Y2ZXdm1RajZrMThmZ3pCNHE0Mkkyb3pINUx6Uy9QenJTRU9hcmk0bTdWWFd0?=
 =?utf-8?B?M0xTSEI1UTdLOGJ5UTk3ajFMWXVvTlI4ZEZYT0hmN3BDamZON2x6QnpKeTFC?=
 =?utf-8?B?YnNQelhPZit2dGNwdm8yY0thZ0VsMWhmaXpsRmp2OXN6enZGOGprcU1iYW9Y?=
 =?utf-8?B?OXBWK3RGWjVLRW5vdjRTY3kzZjNzR0JoKyszK1VHY3VFeGsyQXQ3QVUvaFdt?=
 =?utf-8?B?NEpkb1hFRTV6cTFCS095aVUwbnp1eHVzNk50YmNaSEFXRHU1aTEzaW51MmM2?=
 =?utf-8?B?OWZhOWtHUEtGdktGRSsxMzc0UDRtM3dPbG5pMVdCeWNycnlDWGkvc3diNW9I?=
 =?utf-8?B?LzNsOVRNeTQ0bXBtd3NaeXpNcmJacW1ERXBQRlExUDlNdE9waVBTZzExZHYx?=
 =?utf-8?B?TVQ2cHNTQXBrYXl1TlFjUGROdlRlemhHMmUvMFBCWGs3RGtLT2Z5N0xYMDU1?=
 =?utf-8?B?MFhwSnNVRUkxR09QYmozbTF2VC9NdnR1cit5a3RhNlhjVmsxakJKU2JrK09i?=
 =?utf-8?B?L2d6QkhYYmpDOTNpZElsTG5hcUhMVzJ3SkdrdXdJb3NnNG5XenVDSEV4V1hm?=
 =?utf-8?B?TzR4ZVEzcWtUVEFKbGZvMENhYnUzajg2THF1NlZCc1grUFNqNzRlUkNSQzF6?=
 =?utf-8?B?KzU4UCtwNmlvR0ZWbGVBYVBBOTE0azF2WHh0VFM4eSswUnB3MXl1by91NDd2?=
 =?utf-8?B?a2NMc3ZpOVBjWmRwK1lnWVVqdWcwYjRHVnI1aW5yL1diczk2MnFXazVociti?=
 =?utf-8?B?cWMydjNBMEIybmhzeDBLNW9QWEZzS25FdTloK1ZzZDRyUER6bWdQRkF2TjFp?=
 =?utf-8?B?MzNYYkRaMDI4d1FBa1NDOFR5SlpLTTVNL3ptTmJlREtFRFJIZ3dqc0xGNjg2?=
 =?utf-8?B?R1JhL1EzZVlySlNYSEdOdnZwcWNRandDdzljZnFabjN4OEJLa3g5dUNqZE5O?=
 =?utf-8?B?ZFhPclkxQlcvT0gvcnJKejVCSldrWW1EQUZQdUx2SVlLRDRUajIxWDE1eUc4?=
 =?utf-8?B?TnZsbGRDc2Vuc0ljdW9zd0RFbXNyNEhEQ2U1bXlKRlJVWEptN1JCdnFObVkv?=
 =?utf-8?Q?FqtIxHZW1rkW1Fh6CkZVTJZQN6JFdvPq68W7nyS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1858eff0-eb0e-45a6-8ed8-08d994b39d29
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:55:40.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3736
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
    <div class="moz-cite-prefix">On 2021-10-21 12:49, Russell, Kent
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB33243CD65F93A887F212569A85BF9@DM6PR12MB3324.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only]



</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>
Sent: Thursday, October 21, 2021 12:47 PM
To: Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring bad page
threshold

On 2021-10-21 12:42, Russell, Kent wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[AMD Official Use Only]



</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>
Sent: Thursday, October 21, 2021 12:21 PM
To: Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;
Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring bad
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">page
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">threshold

On 2021-10-21 11:57, Kent Russell wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">When a GPU hits the bad_page_threshold, it will not be initialized by
the amdgpu driver. This means that the table cannot be cleared, nor can
information gathering be performed (getting serial number, BDF, etc).

If the bad_page_threshold kernel parameter is set to -2,
continue to initialize the GPU, while printing a warning to dmesg that
this action has been done

Cc: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
Cc: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Signed-off-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
Acked-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Reviewed-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 12 ++++++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">index d58e37fd01f4..b85b67a88a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">index 96bd63aeeddd..eee3cf874e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -877,7 +877,7 @@ module_param_named(reset_method,
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">amdgpu_reset_method,
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">int, 0444);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, &quot;Bad page threshold(-1 = auto(default
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">value), 0 = disable bad page retirement)&quot;);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+MODULE_PARM_DESC(bad_page_threshold, &quot;Bad page threshold(-1 = auto(default
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">value), 0 = disable bad page retirement, -2 = ignore bad page threshold)&quot;);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap=""> module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int,
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">0444);
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">
 MODULE_PARM_DESC(num_kcq, &quot;number of kernel compute queue user want to
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">setup
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">(8 if set to greater than 8 or less than 0, only affect gfx 8+)&quot;);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">index ce5089216474..bd6ed43b0df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1104,11 +1104,15 @@ int amdgpu_ras_eeprom_init(struct
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_ras_eeprom_control *control,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap=""> 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			*exceed_err_limit = true;
-			dev_err(adev-&gt;dev,
-				&quot;RAS records:%d exceed threshold:%d, &quot;
-				&quot;GPU will not be initialized. Replace this GPU or increase the
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">threshold&quot;,
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+			dev_err(adev-&gt;dev, &quot;RAS records:%d exceed threshold:%d&quot;,
 				control-&gt;ras_num_recs, ras-&gt;bad_page_cnt_threshold);
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I thought this would all go in a single set of patches. I wasn't aware a singleton patch
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">went
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">in already which changed just this line--this change was always a part of a patch set.

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Ah sorry. When you reviewed the original patch2 clarifying the message, I merged it and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">then re-submitted the remaining 3 (which pared down to 2) for review. Sorry for the
confusion, I was trying to minimize the number of moving parts.

Admittedly, now you have 3 patches, one singleton and two coming in. Would've probably
be best to submit only the current two.

No worries for now--for the future.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Thanks. For the most part, all of my previous multi-patch sets have been all-or-nothing. This is the first time that a patch in the middle got an RB before the rest, so I did the wrong thing and merged it while the rest was still moving. Thanks for bearing with me!</pre>
    </blockquote>
    <br>
    Yeah, sometimes we R-B <i>some</i> patches in a set, but we don't
    break off or submit them until they've all (the whole set has)
    gotten an R-B. We just apply the R-B to the patches which have
    gotten it and carry them around the set, and repost as you did with
    your v3 patch set.<br>
    <br>
    No big deal at the moment, but having a single consistent set is
    preferable--for the future. :-)<br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:DM6PR12MB33243CD65F93A887F212569A85BF9@DM6PR12MB3324.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

 Kent

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Luben

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
 Kent

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,
Luben

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+			if (amdgpu_bad_page_threshold == -2) {
+				dev_warn(adev-&gt;dev, &quot;GPU will be initialized due to
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">bad_page_threshold = -2.&quot;);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+				res = 0;
+			} else {
+				*exceed_err_limit = true;
+				dev_err(adev-&gt;dev, &quot;GPU will not be initialized. Replace this
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">GPU or increase the threshold.&quot;);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+			}
 		}
 	} else {
 		DRM_INFO(&quot;Creating a new EEPROM table&quot;);
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>
