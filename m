Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9340A6113D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9340A6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12ED189C51;
	Wed, 20 Oct 2021 21:47:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 462D789C51
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 21:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7sMAq1MWoCItK1GiHR4DJJBZSU4DHZEf5SXRR5SHW070H5A+H2erdPswF4Nugqigm0JKGE0xJWvkCgsDGi6i/R6Roh1idXTOB23iwsK1uU7hiAJCb6FV4SGiYw2XsUohiYCoyb+48ItUuJKOONnNgX+RGshHkpiJMSJTnuzDkC5Wiq/pPRNYKZsavaCwwPPzjj2pvTCMRMCFAGlolf22yCvGwdxA/JXpkrPqCH7EvoVsS6z0iMV8bUa7XZXdvSIQrSoNaK061sJmpa5UFxycEA/PR5rjYmgeJr05RTzy9PXpFQXji31+fQYOgJ0gaIrYmwNqmTeyGilKya1e7hlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPXMyZ/rQdH852GX7g7WuVl4lGFDogZQk5UPzEQH4Mg=;
 b=nt07qApUkOhsavOIp1JN04uGx/3p38yAIyqncexqKfIdDGM0Ro0wywEdQyzQfzntiBhVgfSZTdf1SN5eQh3QYfb10JOG9adjf4iYOVbBtaJ5JyLxTClEdc81phj4DSSNt6HLgEDjUFd1jI0JbXa42Qy6vb9jmS9T+LkosmnPqoX4UnuuphVWAQftOR2kzS64sR869jFhuycTri/2QkpxdgpxzsrK2G0VgcZ6ChadZ7nwE1AmzZ0NVRZVs+eAlJb4Cpb8zB3z/RGOypS1UuC6sZd9fvRpXwHp0KRmca9NM3tcwSLZMSd+MdBRUx2mHxjLKQngx0uOBYyeYkO4hxOrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPXMyZ/rQdH852GX7g7WuVl4lGFDogZQk5UPzEQH4Mg=;
 b=L37N45y0E9Lg+3u71EPOFznB8i5HfKF5gafRfsJRzeXxcQvE/th/FTimZrDwj0QON/Frk4wTDM0Slij/FoMSUtFfKY3pqRI/i3CEkG4lSJAE09grqhxNKHNQFbcEZZKrgllCVucnAw4mtikwqr66v49c7V2QpdvQMbMwqWsshao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 21:47:41 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 21:47:41 +0000
Message-ID: <ee745dec-ab0b-9ebe-3b79-dbc0e14808fe@amd.com>
Date: Wed, 20 Oct 2021 17:47:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211020163520.1167214-1-kent.russell@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 21:47:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311f8c3b-fbbc-46fb-1818-08d994133db8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28284FF95E0FDA7E999EA2F999BE9@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVFqltYXE273ePcCFu1Q8dtGLln2MizNSvvVmLPgJ6VEzv7ASqiryn5gn8+1Zla7HGNXuucmVIXpXIbHzExYMMTQsqXNJ3whP+wn2A9FqGEIb201Hlj9DSvuoQoU394JVSxgkEGmY3IdnoLCyi/rp+5NLNULxSL+G0VJYxykgMQaopW/CYb38psfiolKpDwXhmBNpXWpoYAjHPmbOAArCYIfhe7PMsFHs8w3eUilc23j7a9m4eLx2P27SCvZrLLJX3x8zbCLdU1ej2kRY+lIhapA+W9T+Lj2QBE/xvGFSCI0WIriNXhuSjgg6DRdIe3MEZNUK+69M8he8WB5ElfcvpXrDkxWYocPMhzRYDxG3/52kZd2xHCmGf+Z8HXHIQVRLIKFi+4LRxG41NCiZfh16e1c2acRcUlJMYnGdSAV+owtQyOjFOk/sAypCYtkYanYWHGId0OULVd6N08XrpPGHURIfdzE5bNTrHiO3oda412+WcxcOnS5M2bRgO22VOEifXgmKhd874w5b+BRvODYRJryDLcm4dpCmHG3zYoZnXFMKjWQUBsxRHGNe5rd/Xjn/J4fpf/5q06VYr2eoaaZmD2CMsB6N56DHrW/0uQWj5PubZR5vP9DnUOy/eB699QRNdFYzNsdJUYGg3jU3xJEDKOFyCRDwek3kDdjDqN7Fe6OihRs6D6+8HzZ8f+aMGbvbvcFrCd32SJuwc6rFik2Ix8TRQnwLjwxlCN2n6PfMi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66476007)(26005)(316002)(2906002)(6486002)(83380400001)(508600001)(53546011)(86362001)(31696002)(38100700002)(66556008)(8676002)(2616005)(956004)(44832011)(66946007)(186003)(4326008)(36756003)(5660300002)(4001150100001)(16576012)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L044M1RFSXRWWkVWN0taNS9JbWs1dW5uenpDcDIvdE5kRWlQSVRxVG8wblBa?=
 =?utf-8?B?R2NaK08yNlFzUGYybGNMYzZTbGtwYW00cUZHTGhVLzdJM2FVRlZyaTB0QW1v?=
 =?utf-8?B?cWc3ME5saGdCZWpkaXVjeXhLaDkyTEVpWU9tY0xXdGxMWHQ2ZHJkNndhNmp3?=
 =?utf-8?B?TXFtR1VNb29RKzRwYkQwdW54MHFpN0JDQkx0YmRiWHQ4UWtLU25keTJKL0FV?=
 =?utf-8?B?UVFKc2dHa2hKVFJrVFJWN25NbGh4Y29hdDFZWDIzS0Y5RmdzZVZ5ZGpSTnNu?=
 =?utf-8?B?NHRWMlhOcDhTT1MwTzRiN1dZUkFnMHRvemk4eXBqNUVkdzVsTU8wemh5TmVv?=
 =?utf-8?B?dm1IWE1HN0ZRYlZVMGN5d0NCTjM5ZWNTckl2K0N3a20xOGxHWmdDdXF3ZGpD?=
 =?utf-8?B?YU81YkV6OGZsL25YaU91cGl6YUgycW5QVHk3Y3plTzZqcWNUWWp1NGd1bkM5?=
 =?utf-8?B?M2ZqTzBaQWFKdHFvQVY0OVFCSHQrT2wzSkcxWHRFVDhqT0NLR2xlTExkUWx4?=
 =?utf-8?B?dm5JcXJ1Ull6QlhmeTZVdC9YcWxTNFp4UGNyOURmOWI2SmhkajRPMGVqbXlr?=
 =?utf-8?B?M3JLWnFjNkFqR0FZR1ZCRlZOTGVmeFlKbGpyRHBETThqVVhqYkd1b280aGxx?=
 =?utf-8?B?SGNXMGcrcUYrWmlpeE52YUxWTFpPbG1hMUlVZlN5dFR6S25MS0gvWXJlUUhI?=
 =?utf-8?B?U2p3Q3oxSkRoU1Bod09GN2tVQnBuRCsvNklJSkc5UldjaGV1VnYyeDl0NVk5?=
 =?utf-8?B?Uk1Oc0RQbXk1QTlmU0t4ZWpaczJlcWQrUEJ6Slg5a0VjTDFQUDNLVzgvMnlF?=
 =?utf-8?B?ckVadHNUQWNoNTQ1SUQrQm5hc0NjSVV6UnRmcU1tQlhtYlRrRitzTWVVaHNr?=
 =?utf-8?B?ZGMrUzRLTFpIMzkzSjIwM3gxcWFFTEdEZURzZk95c2ZieW9rQU9lUzJ0RExm?=
 =?utf-8?B?VDRDWU1oZ0tIZ0IwS2dSbnY5MklscDRtVUhCY0ZSODBmMGlCdWh1Vmdicmxh?=
 =?utf-8?B?eXg4OStzYnYzWTB5MWoxZjlHNXoyTkF4TGozRS9nOXUzbVFCWHNVekdzWE56?=
 =?utf-8?B?M0FGRURzbDcwRWVEc3JhRzc1VFBXOE5KUG1XVTY0WlBVak9Da0FQclNOUytM?=
 =?utf-8?B?TWlGZlVIcnpKbk9XeHF1UEc5R0Q3V0tJeDd4WXcvSEJiM3dtVmNGTWZyL3cw?=
 =?utf-8?B?dGZlWXhDK2FYUytUaXZ6WjVaemhMRVIvRVB3RXJycHNhNlFsajhsdEZER1pB?=
 =?utf-8?B?YW1OUG11TVo2RjAybGhLRnAzYnMrQi9ZZHM5cjhTdVVVMytCTXI1WFA5ZDcv?=
 =?utf-8?B?S25ZbFlOUENPdkpJL3JvUEQ5MlpRSmpTbWZOcW5iT3NZcTVtV1ZRbFZOUDBv?=
 =?utf-8?B?MVFFWHcwV3FxcVByQ2ZtZU13S2lUYWs1SXFGdnpVOEliVnBaTUkzT0M3V2ha?=
 =?utf-8?B?MFV3Ry93bmsrR2JoNUpNVFRvQ3R2RERsTVpsZlNpTVpqdmQ1Uzd5YS9HRTNQ?=
 =?utf-8?B?d2dKdW5KTVpWak1qR1c3eUlkemJsN01rVm1taWlUUzhrei9yQVFsNGlMSEFM?=
 =?utf-8?B?RTJGVHlXQnd0NVVzK0tCKzRnTEMyemxyY0htMVZaWDVRWUI2L3RQUTN3TkdQ?=
 =?utf-8?B?Nzl0d0Q5UlJxSjAvVVhLWnpzRUxRK3l0Snd5OGFYSTJBNFNLaitzUzhvbFhk?=
 =?utf-8?B?RDRiVFN1VHdoZTBELzlDUkpDdmhnV2NhUFkvRGZjSkxnRlpHY1l5SUVUYzlM?=
 =?utf-8?Q?G/XQ8cZPCr3wwUwh547Kkv5tNoGI4IKI7khhC3e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f8c3b-fbbc-46fb-1818-08d994133db8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 21:47:41.1769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr6RnbhwW+qV4RBYkGveGhzbocA1ZqyeiZl90XbGl9mk/T13SWBnMZcIvcQeptb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
    <div class="moz-cite-prefix">On 2021-10-20 12:35, Kent Russell
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">Currently dmesg doesn't warn when the number of bad pages approaches the</pre>
    </blockquote>
    <br>
    &quot;Currently&quot; is redundant in this sentence as it is already in
    present simple tense.<br>
    <br>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages</pre>
    </blockquote>
    <br>
    Missing full-stop (period) above.<br>
    <br>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">

Cc: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a>
Cc: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Signed-off-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4c05ff4b26c..1ede0f0d6f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	control-&gt;ras_fri = RAS_OFFSET_TO_INDEX(control, hdr-&gt;first_rec_offset);
 
 	if (hdr-&gt;header == RAS_TABLE_HDR_VAL) {
+		int threshold = 0;
 		DRM_DEBUG_DRIVER(&quot;Found existing EEPROM table with %d records&quot;,
 				 control-&gt;ras_num_recs);
 		res = __verify_ras_table_checksum(control);
 		if (res)
 			DRM_ERROR(&quot;RAS table incorrect checksum or error:%d\n&quot;,
 				  res);
+
+		/* threshold = 0 means that page retirement is disabled, while
+		 * threshold = -1 means default behaviour
+		 */
+		if (amdgpu_bad_page_threshold == -1)
+			threshold = ras-&gt;bad_page_cnt_threshold;
+		else if (amdgpu_bad_page_threshold &gt; 0)
+			threshold = amdgpu_bad_page_threshold;</pre>
    </blockquote>
    <br>
    I believe we don't need this calculation here as it's already been
    done for us in <i>amdgpu_ras_validate_threshold()</i>, in
    amdgpu_ras.c.<br>
    <br>
    I believe you want to use &quot;ras-&gt;bad_page_cnt_threshold&quot; here
    instead. For instance of this, see a bit further down in this very
    function this check including the comment, in italics:<br>
    <br>
    <font face="monospace">&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header ==
      RAS_TABLE_HDR_BAD &amp;&amp;<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; amdgpu_bad_page_threshold != 0) {<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; res = __verify_ras_table_checksum(control);<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS Table incorrect checksum or
      error:%d\n&quot;,<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; res);<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </font><i><font face="monospace">if
        (ras-&gt;bad_page_cnt_threshold &gt; control-&gt;ras_num_recs) {<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* This means that, the threshold was increased
        since<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* the last time the system was booted, and now,<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* ras-&gt;bad_page_cnt_threshold -
        control-&gt;num_recs &gt; 0,<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* so that at least one more record can be saved,<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* before the page count threshold is reached.<br>
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/</font></i><br>
    <br>
    And on the &quot;else&quot;, a bit further down, again in italics:<br>
    <br>
    <font face="monospace">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *exceed_err_limit = true;<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <i>dev_err(adev-&gt;dev,</i><i><br>
      </i><i>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &quot;RAS records:%d exceed threshold:%d, &quot;</i><i><br>
      </i><i>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &quot;maybe retire this GPU?&quot;,</i><i><br>
      </i><i>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; control-&gt;ras_num_recs,
        ras-&gt;bad_page_cnt_threshold);</i><br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }</font><br>
    <br>
    <br>
    See how it says &quot;<i>records exceed threshold</i>&quot;--well, with this
    patch you want to say &quot;<i>records exceed </i>90%<i> of threshold.</i>&quot;
    :-) So these are the quantities we gauge each other to.<br>
    <br>
    Clarification on this below.<br>
    <br>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+		/* Since multiplcation is transitive, a = 9b/10 is the same
+		 * as 10a = 9b. Use this for our 90% limit to avoid rounding
+		 */
</pre>
    </blockquote>
    <br>
    I really like the format of the comment. But I feel that the comment
    itself isn't necessary... at least the way it is written (&quot;9b&quot; may
    mean &quot;9 bits&quot; or &quot;9 binary&quot;. I'd avoid getting into arithmetic
    theory, and remove the comment completely. Anything else (explaining
    the math) really distracts from the real purpose of what we're
    doing. (After all, this is C, not a class on arithmetic--they who
    can, will figure it out.)<br>
    <br>
    Perhaps something like:<br>
    <br>
    <font face="monospace">/* Warn if we get past 90% of the threshold.<br>
      &nbsp;*/<br>
    </font><br>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">+		if (threshold &gt; 0 &amp;&amp; ((control-&gt;ras_num_recs * 10) &gt;= (threshold * 9)))</pre>
    </blockquote>
    <br>
    Right, so here perhaps we want to do this instead:<br>
    <br>
    <font face="monospace">diff --git
      a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
      b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
      index 98732518543e53..2aab62fa488eba 100644<br>
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
      @@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct
      amdgpu_ras_eeprom_control *control,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS table incorrect checksum or
      error:%d\n&quot;,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Warn if we get past 90% of the threshold.<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (10 * control-&gt;ras_num_recs &gt;= 9 *
      ras-&gt;bad_page_cnt_threshold)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;RAS records:%u exceeds 90%% of
      threshold:%d&quot;,<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;ras_num_recs,<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras-&gt;bad_page_cnt_threshold);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header == RAS_TABLE_HDR_BAD &amp;&amp;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bad_page_threshold != 0) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res = __verify_ras_table_checksum(control);<br>
    </font><br>
    Also note that up until this point of the boot process, we don't
    qualify the boot by amdgpu_bad_page_threshold and I feel that this
    check in this embedded if-conditional shouldn't do that as well.<br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:20211020163520.1167214-1-kent.russell@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			DRM_WARN(&quot;RAS records:%u exceeds 90%% of threshold:%d&quot;,
+					control-&gt;ras_num_recs,
+					threshold);
 	} else if (hdr-&gt;header == RAS_TABLE_HDR_BAD &amp;&amp;
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
</pre>
    </blockquote>
    <br>
  </body>
</html>
