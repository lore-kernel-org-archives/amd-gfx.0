Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B558CC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F5161440
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F5161440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8405E6E0EB;
	Wed, 28 Apr 2021 14:57:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F4C06E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 14:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3mcMUkJeMAvXU/U4eOd9aRExOuExyWwe0LmOG4295wDh0tlO2WQ+mcDMUt2t2tbWSRaYI/Fs1kBo3LhyL+54B7HMa8r6K1MfECb1YFdq64jcr7eT1LwErfO/ZbUZ9TV8wlcXJGyRg+NrxJbsyXJt1Inm419jsK2/99q2ik0KHZS543/BWuEw9Pp2w7UjV/Iuq9uek5o+1LRIfFhFC0KCP3CwHOtzaHUPM+crAyDB2j4Wny2hw1xAl5vJZ3tQ8QEkMhZ3otDYyM/Ey6E2NPXu+stkKk0wMrIpXMyNlsKaHCNc77s+BiKzX8EqFA/L5dzldOaQrLYlFMUBo/6QblO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpA5AFdWKpE3zjqEOVpSr2W8pihkGFharSz35oCj5JA=;
 b=dpTAWxGJh2nx0AEILe92hunBcgUoTZwtez+lY21A0KkRqCPOn/ZNkk4qvNcMXX7M+JJ5djS90rbyC+ZjshyrrakrNWkbEIXvnOtx/I46/YiCWo9V+T5uLNoZz8KsrUXouNRINMVVramUfofnmEf3v2nloxkbGYYyeWgmauBhrv6Hy5KovXoNyLSMZD+mIQWfv8ci3t7dc3MwIhWZliQJnePzQN01tg0QTeRTmv7Vi5QgUBR8uydq0fmU9PVvJKWS6rj3Xv8qjfmn6beQ4xSNp8BmVVop2cfAzb8xME5t1IUPVcFVQvFsmQUyarVsZoPBoaQVTOOLE206AaoITiXcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpA5AFdWKpE3zjqEOVpSr2W8pihkGFharSz35oCj5JA=;
 b=SuNnjxq76CsPcLs/1S3Yb4pS6SBQSzw4+K3ta7TVLZzmXLP4Jeb6oq9YTBVJURGAS77xmEgE/Vz5Af5qxAbzCWmxp4NZ+3OXnPGTZ/mEfDVZdGR3VBMn84ySyGborey4p4eupwCs2HVCW8DdTnk+yJbXW6+sAlBWUOK+k7Zh3EU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Wed, 28 Apr 2021 14:57:04 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 14:57:04 +0000
Subject: Re: [PATCH v5 4/5] drm/amdgpu: address remove from fault filter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210427145119.670-1-Philip.Yang@amd.com>
 <3c65430a-1bdb-27cb-6573-dfc9e4035e8c@amd.com>
 <cf02bd7e-f442-fd0f-4184-c50a84929095@gmail.com>
 <0ca90df0-a26a-2b62-4da6-6e49beaf052a@amd.com>
 <47a28337-1abe-4f94-b96d-3ebba32a82aa@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <07f2da7f-f162-9b6b-fe42-b1fb00c0777f@amd.com>
Date: Wed, 28 Apr 2021 10:57:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <47a28337-1abe-4f94-b96d-3ebba32a82aa@gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Wed, 28 Apr 2021 14:57:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8309b34f-1ab1-4efd-0a00-08d90a55e2b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451A9B0AE26854BD42CCD3BE6409@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFPrnK7nAraafVmIVfZxLPgwtUhGFeTBdQ1bMTh9kN9FEYI4vTRAe6Xeq8j0nZP/HOwc8sycG8U2OyOTiAD+ec+4rPdzM/zgNZ9ts89RYKEF6ffdgt7Au6xOAkEG7eNLObg2krrbQqxD1gJSbNYocxURYEXH7120a6tv7u35Hlt2JLC3CeKO4LcHz/0RoxHK+KGjWI0TV5C7fFlA6EjglVFCs80uery8oeY+qKwnkMm8g26Dbe12xvzVEFBYSEsbiNVDEXKwDGM7dPvIFHEmhK+cA/Kj1UwRLLcwNXPlJ5LkDmpda9ZALVXbbsNMQtRA9G5wqsJl6SXZv52Drrc9j2IZvxJOqyfS4NLrmNxQEBuMUj4vuA9t+94nK2fxGC+oYav+Hx4J39SiU0QGsToJ9VPI0L5hcq3biT1fgKoloO5jPGWccfmaWm5ahH8GY4FhqwAjvHmrUkvsSmGObA6pIPZan/fw5ZfeQNeGitQ2U65tA9P77FAFKC1bkOyvwvAGFP8dCADOkhl4XZXilAR2OGECWwf6W3oDNq+zx7HSs/AtW2rGwWQ/NL4grJ3qrMmoj3fvOeh7b7mNBWVEXhoovn6JZlYvLJIFOkfveEn/lz2kZ5GjR37R2EQjRbS2vZtYwy+MJkUYeWpPmU23wiCXjn35rmatRXmvss2B6C09hh+o5mAy+bwEjJ1elGuQ9f3kg3Ei3S4JAbVo6Ql/MPhqr4U0QJu1rrVOxGR6HtkavYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(316002)(16576012)(2906002)(8676002)(6486002)(66946007)(66476007)(8936002)(36756003)(16526019)(26005)(110136005)(186003)(38100700002)(31686004)(31696002)(5660300002)(2616005)(53546011)(45080400002)(83380400001)(478600001)(956004)(66574015)(166002)(966005)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ek1US2N3VWJrZTYyaGJ1b1pmRUpBMGJMOWt2azZJQ2p6cldOa2c3UWlWcHFU?=
 =?utf-8?B?ZHFJR1Q0akFvbyt0emRDdWw0UklreTF4SzNwOFk0K1N1OHY3ZjVRZ3M5K0hO?=
 =?utf-8?B?UjVXSDlTSWlwMXVDRmhWYy9Oem9GVUFoUEhtQ2V6aEFOclZkTDFweEVoVmxY?=
 =?utf-8?B?OHNJSElRK1FBbjN6Uk5NdU1DZkRPdGtKUmxYbHVhcUZ1aGo1My9TSDl2aFhR?=
 =?utf-8?B?ZUFDQ2h2OHVwMDVtUGVabmp6ZlpCc3RDL1BPekRTYnhFWjhiaGtDbWF2aXhH?=
 =?utf-8?B?bEZuS2ZnWXRXQlVOZUJKTzNYbGlGTHNDWmZqVFJOMEJnT2tMeHp1ejF2eDJl?=
 =?utf-8?B?cjJHOU9McUhtZmFrTm1xRWoycjdVd0JVOEtrN0RTVmpndk9BcVIyclIzLzVu?=
 =?utf-8?B?Tm9laEdjZ0J4SG84Wm5zS2hHc01lVDJDVVB3YlpQYkxSTzFNV0tSS3VBTG1n?=
 =?utf-8?B?ZkxjdVVWcVg3c01kTUhxM2k1a1FHU0N5MzMxb2RMcGpQaG1wbTlqT293YnpX?=
 =?utf-8?B?T1JWdE5CZUtBSExZdHJQbVdxZ3VQTzBsWVpETE93V0E1Z1lRVzdlRDBVTm5o?=
 =?utf-8?B?MHNyd0hxNHZuK0d3d1U3RVN4YTNOVGlmYmYxSXBmV3FtQ3h2QnVpb09EMHpr?=
 =?utf-8?B?OE8zRHpwWG9VZkw5b0xENytGN3M2YnhGeWVjQmlaRmJjTk1sS2tickdoU29k?=
 =?utf-8?B?d05rRzhNNWRXbURUeHZLVkJ1RFIvdU5EZ3kvNU02OC9vVkN6MlF2VnRib2Jy?=
 =?utf-8?B?bjRiK290RDRST0JNZjZ4a3poZWFPVFZoYWM4MWIrWHFVekpzYWRwak9GMVBs?=
 =?utf-8?B?L0lLT2R2QUkvSzkrdkZTTllPRm5YYVpST1dPZDRGSGIvVllEMkNVZ0hFYXRt?=
 =?utf-8?B?STBKcE8rdUFaUzdVancraGQ3anI4OTJuQnQ1dEVJaW5iUXdsWHQ4bThNN2wx?=
 =?utf-8?B?dlpMdkxBU3ZyOHQvR0ZQekEzeWFvSCtZaDlyV01pVE9IQTFDWFg2S3RINnpk?=
 =?utf-8?B?d1dDUUJ1MGtOMC9DM2lERlZNZllFVzRRQWlmdisvRlc4WGNmWEhjVEk4cCt0?=
 =?utf-8?B?RFU2UXhmckdpRGZWT3F4d0ozZGZyRkpjUkwyZDJpeUZUYkFqenBsUmhJNWlG?=
 =?utf-8?B?Y1NFb2o0blljd1Vvak1CRGl3LzZVdnR2ZmFMTzVqS012UmJmbXNxdy9vSTVo?=
 =?utf-8?B?eW9ydlBFa3gwR0FGTENVL1o1U2dMR3dxazBJWmhxVk10enEvQUxLOUZTMXAv?=
 =?utf-8?B?d2ZCTjhLREN2ZXFubE1IUnJwOElzTnp5Vmk4SjREZUluR2ZPbHpCOER5Nys0?=
 =?utf-8?B?NGt6T3F1clJQUm9vMnFQYzRpN3BEc09ZdWR0Yi8rMURjQ2dZanNORG5DMkNF?=
 =?utf-8?B?czNhY0VVc2h4QUhpYkN5SEt4ZmJxZjhMdVRsUHpVYmxCT2RUVFhSOWZJS3dw?=
 =?utf-8?B?Wk9GRWNsNmVQTy9YczNvV0hmWmROL0dWUWI3ZWVFZ3pJbXBVbHVaTlhaSlp2?=
 =?utf-8?B?d1NwckQycGRsdlh4S05uMTRXdFFGWG1iNFptSEdTQUJOTmc2OTB3YVRTRWN4?=
 =?utf-8?B?SmUzWWUxK3F6Vk5NMDJHL0tNM3htWk1BbEs4L1hRbmRrUWp1aGVoZHRHaEpF?=
 =?utf-8?B?NXA0eWZBSFFuMU12VUtjR2NGNlV6blgyYVBmRHdsekFPMG1USWlESXppYlR5?=
 =?utf-8?B?MHg1b2RIY1lZbndYV2l0UjNGNytacmFIamJ4YUQrMitSd0ZOL0hpTzkxVnh5?=
 =?utf-8?Q?F9A7w03/AUZxr5nsfynZOpn0VxrmlfB6QSAL8U5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8309b34f-1ab1-4efd-0a00-08d90a55e2b0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 14:57:04.3100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRdWPOr6+XYjOLDSRqdndWLma7hsNQQddxzY3QVgVcjwyiD48u796fF4NmvKgajK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Content-Type: multipart/mixed; boundary="===============1601640893=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1601640893==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-28 5:00 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:47a28337-1abe-4f94-b96d-3ebba32a82aa@gmail.com">
      <br>
      <br>
      Am 28.04.21 um 09:53 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">Am 2021-04-28 um 2:54 a.m. schrieb
        Christian König:
        <br>
        <blockquote type="cite">Am 27.04.21 um 20:21 schrieb Felix
          Kuehling:
          <br>
          <blockquote type="cite">On 2021-04-27 10:51 a.m., Philip Yang
            wrote:
            <br>
            <blockquote type="cite">Add interface to remove address from
              fault filter ring by resetting
              <br>
              fault ring entry key, then future vm fault on the address
              will be
              <br>
              processed to recover.
              <br>
              <br>
              Define fault key as atomic64_t type to use atomic
              read/set/cmpxchg key
              <br>
              to protect fault ring access by interrupt handler and
              interrupt
              <br>
              deferred
              <br>
              work for vg20. Change fault-&gt;timestamp to 48-bit to
              share same uint64_t
              <br>
              with 8-bit fault-&gt;next, it is enough for 48bit IH
              timestamp.
              <br>
              <br>
              Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
              <br>
              ---
              <br>
              &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48
              <br>
              ++++++++++++++++++++++---
              <br>
              &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 6 ++--
              <br>
              &nbsp;&nbsp; 2 files changed, 48 insertions(+), 6 deletions(-)
              <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
              <br>
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
              <br>
              index c39ed9eb0987..a2e81e913abb 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
              <br>
              @@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct
              <br>
              amdgpu_device *adev, struct amdgpu_gmc *mc)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;agp_size &gt;&gt; 20,
              mc-&gt;agp_start, mc-&gt;agp_end);
              <br>
              &nbsp;&nbsp; }
              <br>
              &nbsp;&nbsp; +/**
              <br>
              + * amdgpu_gmc_fault_key - get hask key from vm fault
              address and pasid
              <br>
              + *
              <br>
              + * @addr: 48bit physical address
              <br>
              + * @pasid: 4 bit
              <br>
            </blockquote>
            This comment is misleading. The PASID is not 4-bit. It's
            16-bit. But
            <br>
            shifting the address by 4 bit is sufficient because the
            address is
            <br>
            page-aligned, which means the low 12 bits are 0. So this
            would be
            <br>
            more accurate:
            <br>
            <br>
            @addr: 48 bit physical address, page aligned (36 significant
            bits)
            <br>
            @pasid: 16 bit process address space identifier
            <br>
            <br>
            With that fixed, the patch is
            <br>
            <br>
            Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
            <br>
            <br>
            <br>
            <blockquote type="cite">+ */
              <br>
              +static inline uint64_t amdgpu_gmc_fault_key(uint64_t
              addr, uint16_t
              <br>
              pasid)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp; return addr &lt;&lt; 4 | pasid;
              <br>
              +}
              <br>
            </blockquote>
          </blockquote>
          Maybe changing this so that we have &quot;addr * ((1 &lt;&lt; 16) /
          <br>
          AMDGPU_PAGE_SIZE) | pasid&quot; would help to better document that?
          <br>
        </blockquote>
        I find this a mix of multiplication, division and bit-shift more
        <br>
        confusing. How about &quot;addr &lt;&lt; (16 - AMDGPU_GPU_PAGE_SHIFT)
        | pasid&quot;?
        <br>
      </blockquote>
      <br>
      Yeah, that is even better.
      <br>
    </blockquote>
    <p>I have pushed the patch yesterday, didn't pick this, should wait
      longer before push in future.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:47a28337-1abe-4f94-b96d-3ebba32a82aa@gmail.com">
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
        <blockquote type="cite">Christian.
          <br>
          <br>
          <blockquote type="cite">
            <blockquote type="cite">+
              <br>
              &nbsp;&nbsp; /**
              <br>
              &nbsp;&nbsp;&nbsp; * amdgpu_gmc_filter_faults - filter VM faults
              <br>
              &nbsp;&nbsp;&nbsp; *
              <br>
              @@ -348,8 +359,7 @@ bool amdgpu_gmc_filter_faults(struct
              <br>
              amdgpu_device *adev, uint64_t addr,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint64_t timestamp)
              <br>
              &nbsp;&nbsp; {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
              <br>
              -
              <br>
              -&nbsp;&nbsp;&nbsp; uint64_t stamp, key = addr &lt;&lt; 4 | pasid;
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t stamp, key = amdgpu_gmc_fault_key(addr,
              pasid);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_fault *fault;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hash;
              <br>
              &nbsp;&nbsp; @@ -365,7 +375,7 @@ bool
              amdgpu_gmc_filter_faults(struct
              <br>
              amdgpu_device *adev, uint64_t addr,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fault-&gt;timestamp &gt;= stamp) {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp;
              <br>
              &nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fault-&gt;key == key)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic64_read(&amp;fault-&gt;key) == key)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
              <br>
              &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = fault-&gt;timestamp;
              <br>
              @@ -378,7 +388,7 @@ bool amdgpu_gmc_filter_faults(struct
              <br>
              amdgpu_device *adev, uint64_t addr,
              <br>
              &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add the fault to the ring */
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault =
              &amp;gmc-&gt;fault_ring[gmc-&gt;last_fault];
              <br>
              -&nbsp;&nbsp;&nbsp; fault-&gt;key = key;
              <br>
              +&nbsp;&nbsp;&nbsp; atomic64_set(&amp;fault-&gt;key, key);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault-&gt;timestamp = timestamp;
              <br>
              &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* And update the hash */
              <br>
              @@ -387,6 +397,36 @@ bool amdgpu_gmc_filter_faults(struct
              <br>
              amdgpu_device *adev, uint64_t addr,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
              <br>
              &nbsp;&nbsp; }
              <br>
              &nbsp;&nbsp; +/**
              <br>
              + * amdgpu_gmc_filter_faults_remove - remove address from
              VM faults
              <br>
              filter
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
              fault on
              <br>
              this address
              <br>
              + * will pass to retry fault handler to recover.
              <br>
              + */
              <br>
              +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
              *adev,
              <br>
              uint64_t addr,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
              <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_fault *fault;
              <br>
              +&nbsp;&nbsp;&nbsp; uint32_t hash;
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t tmp;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
              <br>
              +&nbsp;&nbsp;&nbsp; fault =
              &amp;gmc-&gt;fault_ring[gmc-&gt;fault_hash[hash].idx];
              <br>
              +&nbsp;&nbsp;&nbsp; do {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic64_cmpxchg(&amp;fault-&gt;key, key, 0)
              == key)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = fault-&gt;timestamp;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault = &amp;gmc-&gt;fault_ring[fault-&gt;next];
              <br>
              +&nbsp;&nbsp;&nbsp; } while (fault-&gt;timestamp &lt; tmp);
              <br>
              +}
              <br>
              +
              <br>
              &nbsp;&nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device
              *adev)
              <br>
              &nbsp;&nbsp; {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              index 9d11c02a3938..6aa1d52d3aee 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              @@ -66,9 +66,9 @@ struct firmware;
              <br>
              &nbsp;&nbsp;&nbsp; * GMC page fault information
              <br>
              &nbsp;&nbsp;&nbsp; */
              <br>
              &nbsp;&nbsp; struct amdgpu_gmc_fault {
              <br>
              -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; timestamp;
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; timestamp:48;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; next:AMDGPU_GMC_FAULT_RING_ORDER;
              <br>
              -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp; key:52;
              <br>
              +&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp; key;
              <br>
              &nbsp;&nbsp; };
              <br>
              &nbsp;&nbsp; &nbsp; /*
              <br>
              @@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct
              <br>
              amdgpu_device *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *mc);
              <br>
              &nbsp;&nbsp; bool amdgpu_gmc_filter_faults(struct amdgpu_device
              *adev, uint64_t
              <br>
              addr,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint64_t timestamp);
              <br>
              +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
              *adev,
              <br>
              uint64_t addr,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid);
              <br>
              &nbsp;&nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device
              *adev);
              <br>
              &nbsp;&nbsp; void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
              <br>
              &nbsp;&nbsp; int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device
              *adev);
              <br>
            </blockquote>
            _______________________________________________
            <br>
            amd-gfx mailing list
            <br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <br>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7C2299a55733334713a8cd08d90a241de7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551972517063081%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=s20dz4IfFjBDvMJeq1ozZdr3MvE7v7HrxOoqhRInLfg%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CPhilip.Yang%40amd.com%7C2299a55733334713a8cd08d90a241de7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551972517063081%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=s20dz4IfFjBDvMJeq1ozZdr3MvE7v7HrxOoqhRInLfg%3D&amp;amp;reserved=0</a>
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--===============1601640893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1601640893==--
