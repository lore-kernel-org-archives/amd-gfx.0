Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CACC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 12:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8F10E70D;
	Mon, 11 Apr 2022 12:52:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4147310E70D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 12:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSQYva9rJEw6MCWRvYmTChtqXWXNzA1fP7JQuVuRJones/dJJwjBhXx/qpwUII+ea/YlalWTH/dhAvepTyIdX/MlilPWmxzQX9GxQtBoJJMpb8a+raYQtOuUd7LgH1GyMCBjyXO2UxeQXkFIghGIG3c2FMDilArPf/bMK0TzPmbTZbGMrmczoI0PD4S5dFlN/YGCXjlfyWZEg6dWRRuJKoNYXkF+Jj2m+KMOLQGccT/BCqT6f7Ioq8gEYwRvgL0CFubVZJiVA83U6PtPB0ATEBk1YyKJtEJEHD4ysGKz5yYazdEFTmQ51QFfdmk18y9Bm97eoAbDTcRX64zpGFqm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg0kD4npxulcVoyHjEZnPIyFbZTLv4GXTGC+m+W16Og=;
 b=V1FIwIyJ0+/3VI0pgsVkE/atSitaIAJesw2ALYFT+BDv2gELOfESCsY1Pxry6czLj61DwvakP/AkHRHLVD10SlfHFe+PnuzZh5/jkubIu9vQzvuJ/awnjJ3qBqrxE9x8c2E+hnqoo/iBhIPb6OlphaLU2NmwSarqQVmov62cGWjW3BJA0Bp6xS4H0NqwXxoy/KAwiitj6CCGsrDTAeaqYDugbcrL4lspMKwNoI5VbBiueaSRU+gy9e3nDEdK129xikSCt7S3IMhOo7hDZUW4nfqr4Ju3zW7ga61lqsuVLfQl94JqTq+j+k0nqNBhrtMwo1xu9XPZjcEYPXUvApTGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg0kD4npxulcVoyHjEZnPIyFbZTLv4GXTGC+m+W16Og=;
 b=oSFPP7pqPxrZjYrPEWKMKfgBWcOhvmsStmf6dDXVdg8BGVduE/iv/zMTkAVPEaekYb/O4iJmL8u5tIL+0TXwzHiuvImvFI9yAik+WYWKYVhTVfqoK3/RRQiAM1y6OHQ2OaVcerRkMoyHkISe92eVdQIFXAVRhhJ1QfN1hwDBy+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:52:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 12:52:52 +0000
Message-ID: <ce419f99-0295-8248-925a-fd4d2d3f2c2d@amd.com>
Date: Mon, 11 Apr 2022 08:52:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Asynchronously free events
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408023907.320138-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220408023907.320138-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b9fac5-5e2d-4a42-b2e6-08da1bba307c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32779D0A43ED010AB2C7897BE6EA9@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFXpGXJfr/vvdODS1BYQhwU+9ePGEIQzbbL/jCdPeS4JLaWNXyn0oOPce+x1Dj1otnq1yV/Lhrgo7GVG0HtABmK6k0l3Ahpf1T9REQOmtLxPhus/idOB1j1CRlw9c6MC0pXZbbwZovXrLEUmJ0wETWkNe2yW8SHGFZHHICmjB77PdwVaXmFp9LSss1clxz54y3CQUV9LEkoQ8RMQeMztSgX2gB7uFYeNHUcz7kW8UdbSo8iYdi1AyF9IKoBKrYBvxnI93MmVlJ45apq5I9kYQ6Awe4t+0LGQukvFWlqYOwWeUlOb8TbFHa+z+SUdZEi7xvLcK5Fd1InkiztkY1XBA2ovw/vV8w8TkVWP5NTDD79/IUhhKIRQr7HfP5O4p0DyfKZZ4+m3qQD/PB1qQzBAzFPwdFwxi7SdC6P4XBAfzq7buqy0T50FTn6LZ518pVwbIJ5Ji780vxZRRQ0OcsFo+fhoi4SCXCCJJE9u5L++jLLhyt/jgj9310Vwg+lwP+dDF6kNlsu2r9WeDsT/E+5sjqYAaMRlzo6lAb7dC/xJcEZwcCBzDsyw8hrPcYeuBAWFJyQfdS4l+Pj1+D+DBZwakf4KPEBuVEFIm6FN2OyEgj8Vmqh+iImlccDpec0Sl6Vcq/BUHaHrvue+kj9QXQ1m4R3mKvKXZIhF556vtIelc6DnQYiZnRnPkCYPJvY0Y90x6r9jfVQ0h5LZ+5V0q2+0tDsnMad8VJnbudipU7bpBAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(316002)(2616005)(6512007)(6506007)(66556008)(8676002)(83380400001)(26005)(31686004)(53546011)(36756003)(508600001)(6486002)(66476007)(5660300002)(66946007)(38100700002)(6666004)(8936002)(2906002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0p3bm9iNkRPaG1JaXg5UlZXdHZOeHFVSUN2Yjk0bUJ0aWFRa1RQVlc2S0ls?=
 =?utf-8?B?dGc2SDVjU1dmc3FVZlljS1IwS3lsUUJuckFaME14RjcrNmhSYjlaek5oeU9o?=
 =?utf-8?B?dWhTU3o4SDhvRnd6ZFVZRnhpRW4zYkNwWEQxVUpzTHRRT3lXZXMvODFWNmJB?=
 =?utf-8?B?YnhSbVNBajBEQldrTXg3eUJHZHFMVUx4K3pkeWtEUWJiYzZmTGlOdDdHclIy?=
 =?utf-8?B?OGVLYUUzeHFRVDZyRUJuQzM0TWhIaFJ2ZWZuLzNYbi9pY1QvdU1XL3dobDh4?=
 =?utf-8?B?eTR1ZHNqRytBS0JJaUtINTBuckdnVW94b1h4dmdMRG9aSEV1c29YblJOQjhN?=
 =?utf-8?B?VmxiNTdXem5oVXJEZmhjQlp6YzIzaEwyQ0dXREhhNXdTS3VKcGhseG1PTmxi?=
 =?utf-8?B?d0g0V1ZsbDdjcUwvbmZYWDhVNjNaNjloUFRlZzJyLzlWS2c1SjBqeFFtZm5z?=
 =?utf-8?B?VEN6N1hJaExCZ2xwRUk3amxNaEtuZG1sS2ttUmcva3pjMEV1VmcvOW50VWEr?=
 =?utf-8?B?QnMwZGlIdHZyY1ZhODNsbXRMeE1Xa1VEYitmNXg5VzlUbFJaNzM0WnpZUVdF?=
 =?utf-8?B?c1F4TzB1M3h0bUlyUUZEMVRPczkvOTZZazg3Um96SHBSSGcydXpZNGZVL3U1?=
 =?utf-8?B?MkhZdWFwVHlHNHZXREJQVEtjc1NBVENGNnpGWFZpai82TlJCUytRYzhjNEZn?=
 =?utf-8?B?OEtwd1RjcXhIYTZUeWdUV1BFQnBCR1l0cUc0aVZ1ZmxyS0szeFJZZzBjbXVV?=
 =?utf-8?B?RU9uZFR3dVpWQ2dBNi9NWEs4ZEpLZFI3LzdtbWRueWg5VklNdDFPWnpKWlVI?=
 =?utf-8?B?dWZUSXNqRGRwdEtOSEIwM3BEYmN3SG45ZHlRb1M5V3g3TituRUh1Mkdja04r?=
 =?utf-8?B?WEtITm51VW9hQWhMUEt1cFE2QU1KZWV2T3QzMzY4VHBURVRSRTIySkdycFh3?=
 =?utf-8?B?S0xJUlV1WjJPV3NnWnFvbmdWU1pKZGtUK0FnOFBtaTkvMXhra3RXY0MrbzBS?=
 =?utf-8?B?MVdZeUtGeStobVlCdG9CLzFmVUszT204MFErdnpsRFhLUDA2UHhrRk84M1dJ?=
 =?utf-8?B?bm9sbGpRMVMzQkxFM1Vjcy9ROW9pSkFDYURqdlgxQitVN2wyZk1wMGtnQm9O?=
 =?utf-8?B?R0JsVGhrR1hxVUxHZHJyWXM2VTJoaFNLUHRrVU96OWs5V24vdUNEcUQzc09p?=
 =?utf-8?B?N0xPVWJ1ck1UdHI4V1A4ZVErRzBEQlQ5VUFseGJod25pRUFxSytYTjBGSXpG?=
 =?utf-8?B?Uk1EK2FLclYwK1ViUzF4d016M1loSk5mbGFGNVRYUlZMaFRjVTdFZ1I3VnA1?=
 =?utf-8?B?UmVtOXA5SjE2L21LSkVzYTdDcjhvQ0N1YnU5cWFiZEs1NjNTckFtOXhaNjkz?=
 =?utf-8?B?bGxKMEVlNm40cVZLSDdZWVRrM0FEVDM4elFpMXB4QW4ya3ZuZkNJaGU0a3dv?=
 =?utf-8?B?SWlJUklzTjFYRDVCOHhsRUo2czNIbDBhR0NtOTdpbVhxVHVVUm9qVDNSN3Z5?=
 =?utf-8?B?UkI5TWMxSTlNeDUvaW1QZTVneUZpV25yeVU5S0dVaVFpY2tMMWlJNkRnMU16?=
 =?utf-8?B?ZjVrczRWb2Y0TlpITTlRWGV6NTdHMEVwNzZmRUJUbitLTmYxL1dic2lDTkN5?=
 =?utf-8?B?c0g2Z0VQdk5wOFUvWnRnOWtaWVU3MjVSZHUyTmJoZkpLc3hVM0VwSWlNWkM2?=
 =?utf-8?B?YlNnU0pIQnlieHRKcWszZG5iZGcwUWtJbWxCaWpLbFd4MnFEeWQrRk5JcjJx?=
 =?utf-8?B?QUg2R0MvSU1QU2szdGpnWFNqY3MxWVhUeFRzemxVa2lGS1ZvTFpSOWUyak9Z?=
 =?utf-8?B?NXJTZU1RYnExOC9VUFMxaXJ2Sk0xdGg5SnpSV3laS3Q2Y0tGWXFRb3dVWExJ?=
 =?utf-8?B?dzR0L3VsbjgvcHFIYStMT0gzSzI4UkN1ZEVRZS81M1VvNzJRYU9uazlnaCtw?=
 =?utf-8?B?d2Y1ekswTGpwU0hYZUV5bGM1b2kwVGZkQ1J6cTJlZkIwVlJoWU43UjU3elEx?=
 =?utf-8?B?VDZpVGRNUk1lM2JMN1hOSVFrc0xFdVdpTTJDSlo1UTlxNnBUQTZ1OHhTbjU2?=
 =?utf-8?B?cEhJcDlHV2I5aERkT1BsaVRDc0JUVmQxajZpbXJ0ZmJkZUZ2dHI2d2FBTGVO?=
 =?utf-8?B?cGVqSUg4ckxJRzVoQkU1ampqWnpPVlFSc0VQSjNTOHhZeGFTUFphLzNZSUI3?=
 =?utf-8?B?Ym5XMTJ6T3F3UEY5YUxRQXl4RVMySkJRUVF0Z3hnMGxRTUUwdkEwbGw1S2RG?=
 =?utf-8?B?UDhGS0pPZlBwaGpWbHVkMENDQ1pTemJTZjRBc004aWw3QVRkZWNGcm1yc0pF?=
 =?utf-8?B?ckFyVlNCRlRwWDFrdUl0U2Nhd0FMMldhTGJMSEx3citvaW1lSFBVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b9fac5-5e2d-4a42-b2e6-08da1bba307c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:52:51.9410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa4ImbH7np1OkUiejgyuswsCpQbfoVmoxkyQFGo/ttConadw6o1JxIvDZHDFVMTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
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
    <div class="moz-cite-prefix">On 2022-04-07 22:39, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220408023907.320138-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">The synchronize_rcu call in destroy_events can take several ms, which
noticeably slows down applications destroying many events. Use kfree_rcu
to free the event structure asynchronously and eliminate the
synchronize_rcu call in the user thread.</pre>
    </blockquote>
    <p>Will need similar fix in kfd_smi_ev_release, as I noticed
      sometime it is slower to exit the app receiving SMI event.</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20220408023907.320138-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 0fef24b0b915..75847c5d5957 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -262,8 +262,7 @@ static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
 		p-&gt;signal_event_count--;
 
 	idr_remove(&amp;p-&gt;event_idr, ev-&gt;event_id);
-	synchronize_rcu();
-	kfree(ev);
+	kfree_rcu(ev, rcu);
 }
 
 static void destroy_events(struct kfd_process *p)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 55d376f56021..1c62c8dd6460 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -70,6 +70,8 @@ struct kfd_event {
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
 	};
+
+	struct rcu_head rcu; /* for asynchronous kfree_rcu */
 };
 
 #define KFD_EVENT_TIMEOUT_IMMEDIATE 0
</pre>
    </blockquote>
  </body>
</html>
