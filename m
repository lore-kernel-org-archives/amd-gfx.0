Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ACC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 02:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1772A2229C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 02:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1772A2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EC36E7D2;
	Tue, 19 Jan 2021 02:13:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0506E7D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 02:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM8QyqxDphYwLkJ2slag4gHp5W/Z4Hl6BuJH0scXr0C1QuUqGWxfT5vSu8lsxVWL8Ug7RJDKJP3trYAzshzTuH1TaKnM159k+3EMArnxgaW75AQuNqCFs76LdLBGHXs1SLY0SdGMOYNQ4I5JKnme3DuA4elw71uOYYWMbo06dwDsCtBDMHNzgpsu2bAbEduqHVApuqTHjz7gotdK6keQMsL8h1FESelg6N4BAzaixaH9Xn6AwKzaVf8oVUzXxX2tpovqnk4Drs2Nn97JNQPCTLQJIYh3GwxfIo0iKzjQhkyp7hw2jPUr0EshI2e5bG5nQ78G7p7rYicejv/k3MsdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+ps+Xr+DQ0xDneYU7r0wx9XWdoONmTNMv4WM6MpFgw=;
 b=Y6gsbehbuVHRly6hAfBcyYGinctPFC8ARJAkbn0+zLYwRz/k/T3FqDZ8VV0LQK3g1HpdylLgPDjl2tRvF5gBWWmI4/8XcneajmPtXnGkBKqyUPjs0aY0qdwpOaK8Th8pEKbuSAT9eoYd13xL9E+LmjnBbXHjWv2uJPqaVsuldBX2v12uCWIaR/f2+U2zicS7bXm1kQmLazsS6vzpw4RwXPaoflBYYwzF6VJB1vczDiKzwKtROHrLQe10GJNTSpvywcr57PppB6kbj0ErTWImwluzC5Uy/hjpU/oOKSljxLJzg2nmJoX4VAjfL8cv8Tq8mznGugQZgnpbNiDy9pb6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+ps+Xr+DQ0xDneYU7r0wx9XWdoONmTNMv4WM6MpFgw=;
 b=DqIS6ZLT4RC4yy+xDSMyznFRloXqtWoXS6JrbIKi6CjU7KOl82rlfsZdv2mxB0bJTYSvnnENgyZQ/Cl2LlMv80dxxSZZQGkiZQXcZssQEVmFOV/L1Sk8Rs4F4c2GCtHgX0EITyV5LRT3FBthq9y1qlFFn7FDr1uqb0asn+HlPQM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Tue, 19 Jan 2021 02:13:21 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9c57:59fa:b83c:2942]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9c57:59fa:b83c:2942%7]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:13:21 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Enable userptr support when KFD is
 enabled
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210118232824.32649-1-Felix.Kuehling@amd.com>
 <d11b2228-e3dd-0dcb-d497-2242ab06c917@amd.com>
 <cf411cd5-2474-8078-ce01-c3c5150e97d6@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <02a54529-56e8-6676-a3d7-e25fb5856277@amd.com>
Date: Mon, 18 Jan 2021 21:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <cf411cd5-2474-8078-ce01-c3c5150e97d6@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Tue, 19 Jan 2021 02:13:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1804ac5-812b-4184-2b04-08d8bc1fcb42
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778E3F9B4B71C6BCD7716E2E6A30@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GlYSTln5aU5mWRHm1W5DNDPin7DBn0q5rp1MrnElvbi8/VX97bp9CoaLv1eaZWnqzrOhC1lm2JL0uPDA1J+o/ZvsJ7zEkWucgZQTbyGxIx8wpdLYH4BTO8KRh+1fR1N8KY/oOmSFntz7ExhIfbyaX0aCIOELE7By7wPvFRpbBkDuD8qXg/T7SQT3LJTqmJuN8STGfPUW/4g/5npJXGucV4TiiKwZhZUhUimSVBga9yPBBslmEYwNVh9HvC9i6i7o8buBag+lOhh0ltHd1sTKJazjNxMQPrO65zh1uTRSHLtJU5JIVHJ4szMj3/m4dY4mU01q5KwH+lAGxAjT93zoUwoaIrGeLPQpcYTyq7YG0JfWayeRiOPUSxOmuBGR+nbguf5bybhtF5Ul/Wgv3HJe2DRhZ/OyVb5H6h7d3n/iKVKQlZeIKrCTk4oRkk95Q8oaI+ygsgvDG2Pof5yDtloaOdCvzzy+sU1IrHLAjNMpd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(31696002)(6486002)(16576012)(26005)(53546011)(83380400001)(31686004)(16526019)(36756003)(8936002)(478600001)(5660300002)(316002)(52116002)(66476007)(66946007)(2906002)(186003)(8676002)(2616005)(956004)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDlZNDJEWUtQdk14bWpzbmFaV3hWTDdnZ3VHMHA0VlFnaWVhRit2c2lBVm81?=
 =?utf-8?B?Ny80NXRRbXhsMkgrVTdrU0h0V2p5V3VaMG5UMitzNnIvZ0xhVHpEVFh0c1Br?=
 =?utf-8?B?VWxna050Z3dEay9GVmk0ZG1rS1VTbHJaTlVac25ZVHVqV3FmMnN6YkRMblIz?=
 =?utf-8?B?RzNYenBDblIzTFZWSkNCMTYwL0FRWEUvNDBCcExvVHR6Zzh4K3Z4VFhsN1dC?=
 =?utf-8?B?OGVLeDBoRDhNc2t0SjJnRHVzK213K1lXVFhTb1lxano2azN2T0t3QjhxMTBM?=
 =?utf-8?B?dDQ4aDhTbmhuL3I3eDNNRG1lbnI5Z0lnK0dTTWZ2azEwcStSS3RjSC9PUVYz?=
 =?utf-8?B?SC9SWTF6YktYcVNKWU1EelVjOUVXWkV4NW01b0lWZVE3Ry9GdUNrNzFhenZR?=
 =?utf-8?B?bXl5TVpIeUxXNDdVOUpLOGt0NnlVWTVrZTQ4Q3lnZklNUzQ1RnFZMXBzUkhs?=
 =?utf-8?B?NFRCRmVXYVJWS2hZUWZKQXM0YjhQeGZiVTdvU0NjVlc4bEx3RXhIc1I1Z0xU?=
 =?utf-8?B?V1dSS2tLUFdqUm1xbTVYTituUXBDakQwZlpMdldXY3E2a1dQSFdwbk9Db2ZP?=
 =?utf-8?B?NTdVNVJsQXJTMVByZlYyVTM0VU9ZdkUxRXFqcS9TOFFKQ1MzbFl4ZmRWMkZH?=
 =?utf-8?B?U1BXdjVTUjZWM3k4YSs1SmRkZHlpZ1VIMEE3eTdmN2dGZlBWbzdwYkZBQ01O?=
 =?utf-8?B?VzZaWmoyRk9LM25jZTBUUHdPYzJIK0gyOXhYTS9hc0kxa1FKM2FjVjRtbllK?=
 =?utf-8?B?VlRINE1WUW5RUjRBV1ZvL1pNQklmSkZWQ1FQQVRDdnVQTUtVdy9SZ0NRZUxl?=
 =?utf-8?B?eDl3VkpZSkNlRnY1encxN3FwOFhBemxpczdDMUlWWlVMb1dNZ1Z6VzFsZk9t?=
 =?utf-8?B?T0V1eURpN3RtUk9yZVF3U1dBS0hyUW5GRWk5Z0owR3kyelREQXRXTzJ4dEpn?=
 =?utf-8?B?TDdMNmZ3cmhDWHc1dHB2TTQ5V1gyRHg3Q09RREJuQzBaSk92eHIrZUVmVnhv?=
 =?utf-8?B?N0VWSmhLOFlWY00zcW91T0tHWXMxQ2NQWjh4OVRzclpvOU0xMG11ekh5bS9x?=
 =?utf-8?B?VXIzVVU5RFl5STRoOTFjVldkck5rdnVqaUtpSGdnL1R2T1ZUOU5OeWZndjl1?=
 =?utf-8?B?OXlwdFd1cjJzd25YSlc1cld5UWJpTUVGZXViczFZeTl6R0RiT3NnaG12TVQy?=
 =?utf-8?B?dGlha0RuMC9kL2YxNXg0WmVkenhicXh3dzZodVdSSXNYd05CMDM0SGExWmRs?=
 =?utf-8?B?d0trQ0QwY3YwYjVINk1zZHZOakh5WVMxNElISlpnODBDY3JnaW9CWDlkam8z?=
 =?utf-8?Q?rWKSykgop9kahPE8YE16peLk2j8I6lVqWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1804ac5-812b-4184-2b04-08d8bc1fcb42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:13:21.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPaGfPuJFOfgYp93fLWRV25f9GPpxYhdoIi7z2vj+CpINW/PO5EXff7L+Ew0cKyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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
Content-Type: multipart/mixed; boundary="===============0394754336=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0394754336==
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 2021-01-18 8:20 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:cf411cd5-2474-8078-ce01-c3c5150e97d6@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-01-18 um 8:01 p.m. schrieb philip yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2021-01-18 6:28 p.m., Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">ROCm user mode depends on userptr support. Without it, KFD is basically
useless.

Make sure HSA_AMD selects the same options as DRM_AMDGPU_USERPTR to avoid
broken configurations where userptr gets enabled but its dependencies are
disabled.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index e8fb10c41f16..f02c938f75da 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -7,6 +7,8 @@ config HSA_AMD
 	bool &quot;HSA kernel driver for AMD GPU devices&quot;
 	depends on DRM_AMDGPU &amp;&amp; (X86_64 || ARM64 || PPC64)
 	imply AMD_IOMMU_V2 if X86_64
+	select HMM_MIRROR
 	select MMU_NOTIFIER
+	select DRM_AMDGPU_USERPTR
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
amd/amdgpu/Kconfig select HMM_MIRROR and MMU_NOTIFIER if
DRM_AMDGPU_USERPTR is enabled,

I guess select DRM_AMDGPU_USERPTR here is enough, HMM_MIRROR and
MMU_NOTIFIER is redundant.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">I read this warning in Documentation/kbuild/kconfig-language.rst:

&nbsp; Note:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select should be used with care. select will force
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a symbol to a value without visiting the dependencies.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; By abusing select you are able to select a symbol FOO even
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if FOO depends on BAR that is not set.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In general use select only for non-visible symbols
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (no prompts anywhere) and for symbols with no dependencies.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; That will limit the usefulness but on the other hand avoid
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the illegal configurations all over.

I'm not sure if &quot;dependencies&quot; in this context includes &quot;depends&quot; and
&quot;select&quot;. But to be sure, I'd rather make sure KFD has all it needs
without relying on indirect dependencies.

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Philip

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> 	help
 	  Enable this if you want to use HSA features on AMD GPU devices.
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0394754336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0394754336==--
