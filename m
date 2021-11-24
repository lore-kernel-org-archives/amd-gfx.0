Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270CBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 15:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A029E6E91B;
	Wed, 24 Nov 2021 15:23:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB2F6E909
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 15:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm34eEovjQcbjQTmj9H/nvr5TFSAHlTuPTOI/FGQi3JSmHBfLV6hFgXlUSAjpHGLt5apeTieZXI4VXQD1ZLsYkvDnml2JKEdeWaqf74polM6lZ0JoqHg5F3na1IH7EFMCq/3pVS6XMJVb2AB2N7ap4NhwsIlV7tqmFbYjX6BSMsMuvT6RO93sJM2ZnrXa/sqMcYuovHyOJOstQRq1wB7J3LQhIksBzXQh40xDOR4ifJamMhBQaEjPBeQwhuTu4OXGge5IWo3TMdpgTE9jaRt74QiZyt/EF05CkgcW7Ua3YTPjlkMUylKMfu6XNKYkqf/sBQK+Olo45hT2WD/nzeURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/nUvjAsQXAjA3cXB+jsVTgYJNVoGUok7dlZ/6rE4EE=;
 b=nJgFmmHeNiq7lDh1lpfjDMu0B64raAe80hR3p3nFAKMRsrdBF2Mfx+4k5iG3OQ9aPmj7ntUuiDpcLMDoXHJpJNsn/2XM7P+4C0wo9luLE9O4JDfzkIMOn8gfk556tHWjkBQigCIFfmIAznuAD4jZty8uRpqLTM7LhJn/TKEGgUT9nUKGMOyNzHDzt47PMsfimCT8GNLFBuI9K196PR9bjGwDQBOW+gxHG5qAoyn/uwwYcNLm5etLbHpPC1esnF8gTEtSM+YrOYEJ8dkzxSA5AhNKqFPZXH0XHylfh3I//Iv/gfnFYFbAkabEm71wzImmHsd63rFoA7rrNR4cH2C4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/nUvjAsQXAjA3cXB+jsVTgYJNVoGUok7dlZ/6rE4EE=;
 b=TqUxzp0p4TdhM2ei0Ie6wDCJq5MqJ1fbbayx/kl/xUZ3sly2Y5z2wZNmMOsC8K8k19FMoL3dgyUaujTy16KWkzQTIDFl9eI8a2yzpRuLj4xUwWpO2LwCFiC1UoQFU9XAdRkLNJWFzp406j1AT7Yjz1I0pmHC4LVMuciMd7kTTNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 15:23:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 15:23:42 +0000
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
Date: Wed, 24 Nov 2021 10:23:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.6 via Frontend Transport; Wed, 24 Nov 2021 15:23:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57cd05f6-f165-4400-231e-08d9af5e65f2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5245:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5245104E7A72156798A99265E6619@DM4PR12MB5245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4lreCoo1lsxTpWPRuaxknLOqt25Y6TUJBNGXbNW0sFnhMQQxOmewbHDBMUP7zcujX0jDkNipLHPBKIhycedWb8HcJZo1Vc4DZwnD2R7wakkIIqyYt5Idpsm9xi4ycQHc/ebxtdIEGQHPkgAhhKW7TzlrejQVZ8EH2pHD6mvR6NfBa4gLmZBM8EG2hqllxwxKDsFTcvCOlPcyhD9fgsSULoKWwciKBfrqcVJZAesXVYrBDlRBCOGIOBB0YmKpF/6LCjG7OYhDWzlChsgoe++oU4wIrXrj8OdEPTFHnPJ5uaR/8Y0JNz4sGVwBmPrHjbzxRQkFToakxU93FX6SjI5tRTWs00/hpW0qNBXWnHTcKcTJVS9bEIN7yfxQwb2KM29O3bGza9QX/z5sTsQVu3LklM1QBlOSOClZUIrs8VK030QZpMFA26ou6X3A5j3RKvFgQZCfcE5Q45o+5PYtwUTYTCGcHHw9Md0dUJJM+rHea/2njYIyJuHMDk0MIKAd8k8MimZVv5WKcyqsGZxkrKYHbXpq2YBYenF12cqlMJaxRu5dbDnsbe7GEwIyHdd1f82wUn2e1imIXF5yGzfZic6WgiZAOEH539rSjkkkB79OH/g8dr0Bu/dqlLZdMeUvuK/alAUn4G+HnoRV8aM8JTnf7KEox7TKxWfhwEcqQz3LK4W0eE1ca8eKfgm0HDQIuuU06uWNG/rWLjtolj+EIdR1LkG4+f4y8YKyNtRez4TceU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6486002)(66946007)(31686004)(26005)(186003)(83380400001)(53546011)(66574015)(4326008)(8936002)(66556008)(66476007)(8676002)(36756003)(508600001)(2906002)(4001150100001)(16576012)(110136005)(38100700002)(316002)(31696002)(2616005)(956004)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpPeXNQY2xUV0Z2Z1JJRmsvZ0tXSDFEZy9FWmY0clhIY25qV2h4dFVmeUlv?=
 =?utf-8?B?VFU1bVdYTURwMUFKMzM0UGtDTkFuY1BDWHozZ0Y2UXNhN3ZQKzFLK25tbmwx?=
 =?utf-8?B?alViL2VLWXM3RUtxVmRDOUx2eE1rMXB4TkxYa3pkRmZlbzBwY1p4dE1QWFVT?=
 =?utf-8?B?OGNqUFUydzBkVjRkTWZDTXo1WGJxZHZMVWhDTERZSmJuQkhJdXU4WDNqbWlM?=
 =?utf-8?B?MWJlWHZ4NS9PMmQ0ZWIzNWtzN2xTc1VNMWlzNkFmUlkyVjlTeDJ2TENzdmlS?=
 =?utf-8?B?VWxFd1hBTE0raEsrNXhoa1JEU0RaMElUbXcrSWlTTGNCM1FvRlF1elB0WVRM?=
 =?utf-8?B?dGZKWWNUL1JUQnFHM0hNbm5KY09RelNqODFtWjVIUDcyd1A4a0tEVFJCNWJO?=
 =?utf-8?B?cUZaUlZCYXU2RWdWb0h5VWNqS2hiOEFMaWxWRzhKSUhUZXdzdENVdTl0K3hs?=
 =?utf-8?B?YzhaM0tCNXhGWERPR3dCNVVSQWJjQWU0VHBrR3d5RjJtZ3llZ0RCMzVXZEdR?=
 =?utf-8?B?cmx6UU5SRTlIQi9HVHJvby83bXphNDk3UGlhdFY3VjZMV0RjZjh4ZDFSSXJ1?=
 =?utf-8?B?cTkyQUFsM3ZBbzZqalVnamxKVFQ1dFd5Y1liY2g3RjUrdHo1azVNY1dNdGdh?=
 =?utf-8?B?WDNoQVhFTlBncC94OE9QSGRqN20wV0xkNitadkI2SDJ1dzNRVlpiQmR0MWFl?=
 =?utf-8?B?Y0FCUWR0SkI4VXdFbG5VVCsvY3c3a28rMER1SHdlYThabHdJeG9oNUxKSzJm?=
 =?utf-8?B?WmNrSnFqNk1Wbi8wSHJ6TU5RV3BYTTF5RUxqRTFTMTVUZjhTQVlFdXZ2d3ow?=
 =?utf-8?B?dzFWUmc0RzRzeFZQbElhdVU0SjAyaUE0d1YvTDNEWmt4cmNHT25JdDJkRjR1?=
 =?utf-8?B?a0gwSGRVZ0ZGM04zRFZrendpYU1IRXdDb3NMQjFlMFlVUm1BSm5aZzNUUHYy?=
 =?utf-8?B?amZ2ZHpPaFFoa01lMlh0RmlWNlpLY0JibjR2TmFXdUgrUU50ckZ4RVdsd01P?=
 =?utf-8?B?RG5QcEhJT1E2Mm94cjFxVFZjYlpQQjg5Q3pyc1lTZGdETFlzd2t0S3Q1NkZL?=
 =?utf-8?B?UHRKWEROQ0NFajRxNXlnd0xDNGRWeXlsWHdhZzNVUDVReExBK1VJUDBYTlBq?=
 =?utf-8?B?eUR0dlNCOTVCSWpPWkRDb2UxODZkMllKdWtNZ0x1bkZqSGdiT1UwM0tZLytO?=
 =?utf-8?B?UjZTcEpPQ09Jb0pCRFZ6YXNOUitCamVtN2crbWsrb2E0ZTZPM1duajFtRFZV?=
 =?utf-8?B?RzlGYnorQU5kMmxTd3hMODVKcEpLa1JWRXhIelpqcjlBQlZMdEtzV3Q2N3R6?=
 =?utf-8?B?R3BUZ25wVXgwMWZpWXoyUU9Nb3NqT0tWdU0xRXRKeDFZcEhiR1pjTjZGVThK?=
 =?utf-8?B?ZW9NZjgyL0JOUXErY3NVUWhtUUprdElaSXBEdmluYWxPTG5EbjI3SFk4WGkw?=
 =?utf-8?B?N2RkRzlrY09xY0JqbzR1UGM3S3JhVEJ6ancrZXRLenpyUFJzbkp4eWZJR3Vp?=
 =?utf-8?B?V3hyTWhMbExqclk1bGNaOXREeHRJWm4ydnhVS0ZUQTQ0MWhmaXZTbHNzbGdu?=
 =?utf-8?B?eTlLcFk1cHplaGJrMStmbStlcWlQYmFWVW9mMmMzZUY1ZWc5Q0NBeWJnQThP?=
 =?utf-8?B?SThVUHljdndrWit4NUh2TUIxeVprM004aFl2Q0ZMZU9lR0xpOS81Z3VFdjZB?=
 =?utf-8?B?R05oNjA5anA0SGtHNnhtU1Q0VWMrSkNKTk5ldGl0eWswVDhTZmRlMzlGUzRN?=
 =?utf-8?B?T2F5c3V4SDBRTDI4Yzl2bkhmQkx1ZHUrQ0hHcGVrV2VXWWVSUS9rZ1dMTjg4?=
 =?utf-8?B?NGMzcjNRWWppVGt3bm41Mng0Q3FzYTZLdWd5VEdpQ1BTK3VRODZrcDdTN0w1?=
 =?utf-8?B?UlJ3d2RUbVpUVXlsbkZVMmp5aDdPekNnYWl3ZEI2VUNZWXZ6aHdMOUdFV2tz?=
 =?utf-8?B?VnJ4QWpMdXloanlQbHRVOSsvRlhNVDJRUWs0V212MHU5ZHhiYys0TzR3V2Y1?=
 =?utf-8?B?dXpVUGdDUEtRRWtJNXExL1owT0tXU3l4TXRGQnRUNEhFUS9MdUJOM28zTjNC?=
 =?utf-8?B?NWdPYUlManR2WG5sb3JiL1I5S001aThiLzU0b2xkaXg0WmdOdEQ5eGF1THZJ?=
 =?utf-8?Q?SfOE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cd05f6-f165-4400-231e-08d9af5e65f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 15:23:42.5324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIXeBq22sgdvpkaxodvAiSEkJvIEhWZurMWIo0zHSiulDdrC7g6e/iqhmuD+v+ex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-24 4:37 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com">Am
      23.11.21 um 20:22 schrieb Philip Yang:
      <br>
      <blockquote type="cite">IH ring1 is used to process GPU retry
        fault, overflow is enabled to
        <br>
        drain retry fault because we want receive other interrupts while
        <br>
        handling retry fault to recover range. There is no overflow flag
        set
        <br>
        when wptr pass rptr. Use timestamp of rptr and wptr to handle
        overflow
        <br>
        and drain retry fault.
        <br>
        <br>
        Add helper function amdgpu_ih_decode_iv_ts to get 48bit
        timestamp from
        <br>
        IV entry. drain retry fault is done if processed_timestamp is
        <br>
        equal to or larger than checkpoint timestamp.
        <br>
        <br>
        Add function amdgpu_ih_process1 to process IH ring1 until
        timestamp of
        <br>
        rptr is larger then timestamp of next entry.
        <br>
        <br>
        Helper amdgpu_ih_ts_after to compare time stamps with 48bit wrap
        around.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c&nbsp; | 107
        ++++++++++++++++++------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp; |&nbsp; 13 ++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/navi10_ih.c&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/vega10_ih.c&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; 7 files changed, 99 insertions(+), 28 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        index 0c7963dfacad..30b4e0e01444 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        @@ -164,52 +164,45 @@ void amdgpu_ih_ring_write(struct
        amdgpu_ih_ring *ih, const uint32_t *iv,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; +/* return true if time stamp t2 is after t1 with 48bit wrap
        around */
        <br>
        +static inline bool amdgpu_ih_ts_after(uint64_t t1, uint64_t t2)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; return ((int64_t)(t2 &lt;&lt; 16) - (int64_t)(t1 &lt;&lt;
        16)) &gt; 0LL;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /* Waiter helper that checks current rptr matches or passes
        checkpoint wptr */
        <br>
        -static bool amdgpu_ih_has_checkpoint_processed(struct
        amdgpu_device *adev,
        <br>
        +static bool amdgpu_ih_has_checkpoint_processed_ts(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *prev_rptr)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t checkpoint_ts)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t cur_rptr = ih-&gt;rptr | (*prev_rptr &amp;
        ~ih-&gt;ptr_mask);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; /* rptr has wrapped. */
        <br>
        -&nbsp;&nbsp;&nbsp; if (cur_rptr &lt; *prev_rptr)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_rptr += ih-&gt;ptr_mask + 1;
        <br>
        -&nbsp;&nbsp;&nbsp; *prev_rptr = cur_rptr;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; /* check ring is empty to workaround missing wptr overflow
        flag */
        <br>
        -&nbsp;&nbsp;&nbsp; return cur_rptr &gt;= checkpoint_wptr ||
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cur_rptr &amp; ih-&gt;ptr_mask) ==
        amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp; return !amdgpu_ih_ts_after(ih-&gt;processed_timestamp,
        checkpoint_ts);
        <br>
      </blockquote>
      <br>
      I don't see much of a reason to keep this function, it only
      consists of a call to amdgpu_ih_ts_after() and is used only once.
      <br>
    </blockquote>
    Will remove this function.<br>
    <blockquote type="cite" cite="mid:3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com">
      <br>
      <blockquote type="cite">&nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs
        up to checkpoint
        <br>
        + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process
        IVs up to checkpoint
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * @adev: amdgpu_device pointer
        <br>
        &nbsp;&nbsp; * @ih: ih ring to process
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Used to ensure ring has processed IVs up to the checkpoint
        write pointer.
        <br>
        &nbsp;&nbsp; */
        <br>
        -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device
        *adev,
        <br>
        +int amdgpu_ih_wait_on_checkpoint_process_ts(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr, rptr;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t checkpoint_ts;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ih-&gt;enabled || adev-&gt;shutdown)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        -&nbsp;&nbsp;&nbsp; /* Order wptr with rptr. */
        <br>
        +&nbsp;&nbsp;&nbsp; /* Order wptr with ring data. */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmb();
        <br>
        -&nbsp;&nbsp;&nbsp; rptr = READ_ONCE(ih-&gt;rptr);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; /* wptr has wrapped. */
        <br>
        -&nbsp;&nbsp;&nbsp; if (rptr &gt; checkpoint_wptr)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr += ih-&gt;ptr_mask + 1;
        <br>
        +&nbsp;&nbsp;&nbsp; checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih,
        checkpoint_wptr, -1);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return wait_event_interruptible(ih-&gt;wait_process,
        <br>
      </blockquote>
    </blockquote>
    I will change this to wait_event_interruptible_timeout, found wait
    event may never returns if gpu reset, rptr=wptr=0,
    ih-&gt;processed_timestamp is not updated. Timeout value 1 second is
    long enough to drain fault.<br>
    <blockquote type="cite" cite="mid:3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com">
      <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_ih_has_checkpoint_processed(adev, ih,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr, &amp;rptr));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_has_checkpoint_processed_ts(adev, ih,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -254,6 +247,56 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/**
        <br>
        + * amdgpu_ih_process1 - interrupt handler work for IH ring1
        <br>
        + *
        <br>
        + * @adev: amdgpu_device pointer
        <br>
        + * @ih: ih ring to process
        <br>
        + *
        <br>
        + * Interrupt handler of IH ring1, walk the IH ring1.
        <br>
        + * Returns irq process return code.
        <br>
        + */
        <br>
        +int amdgpu_ih_process1(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih)
        <br>
      </blockquote>
      <br>
      I don't think we need this new function any more.
      <br>
      <br>
      The check if the timestamp goes backwards can now be done inside
      the page fault handler.
      <br>
    </blockquote>
    Do you mean to merge this into the original ring0 interrupt handler?
    Then we need add parameter (ih-&gt;overflow_enabled) and process two
    different cases in ring0 interrupt handler, I think that is not good
    to maintain later so I want to separate them.<br>
    <blockquote type="cite" cite="mid:3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com">
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t ts, ts_next;
        <br>
        +&nbsp;&nbsp;&nbsp; unsigned int count;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 wptr;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!ih-&gt;enabled || adev-&gt;shutdown)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr == wptr)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +restart_ih:
        <br>
        +&nbsp;&nbsp;&nbsp; count = AMDGPU_IH_MAX_NUM_IVS;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ts = amdgpu_ih_decode_iv_ts(adev, ih, ih-&gt;rptr, 0);
        <br>
        +&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih-&gt;rptr, 1);
        <br>
        +&nbsp;&nbsp;&nbsp; while (amdgpu_ih_ts_after(ts, ts_next) &amp;&amp; --count)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts = ts_next;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(adev, ih, ih-&gt;rptr,
        1);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * Process the last timestamp updated entry or one more
        entry
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * if count = 0, ts is timestamp of the entry.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp; wake_up_all(&amp;ih-&gt;wait_process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data */
        <br>
        +&nbsp;&nbsp;&nbsp; rmb();
        <br>
        +&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after(ts, amdgpu_ih_decode_iv_ts(adev, ih,
        wptr, -1)))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto restart_ih;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_ih_decode_iv_helper - decode an interrupt vector
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -298,4 +341,20 @@ void amdgpu_ih_decode_iv_helper(struct
        amdgpu_device *adev,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wptr/rptr are in bytes! */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr += 32;
        <br>
        +&nbsp;&nbsp;&nbsp; ih-&gt;processed_timestamp = entry-&gt;timestamp;
        <br>
        +}
        <br>
        +
        <br>
        +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring
        *ih, u32 rptr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed offset)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t iv_size = 32;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t dw1, dw2;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t index;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; rptr += iv_size * offset;
        <br>
        +&nbsp;&nbsp;&nbsp; index = (rptr &amp; ih-&gt;ptr_mask) &gt;&gt; 2;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dw1 = le32_to_cpu(ih-&gt;ring[index + 1]);
        <br>
        +&nbsp;&nbsp;&nbsp; dw2 = le32_to_cpu(ih-&gt;ring[index + 2]);
        <br>
        +&nbsp;&nbsp;&nbsp; return dw1 | ((u64)(dw2 &amp; 0xffff) &lt;&lt; 32);
        <br>
        &nbsp; }
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        index 0649b59830a5..d7e1ffeca38f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        @@ -68,6 +68,7 @@ struct amdgpu_ih_ring {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For waiting on IH processing at checkpoint. */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_queue_head_t wait_process;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processed_timestamp;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; /* provided by the ih block */
        <br>
        @@ -76,12 +77,17 @@ struct amdgpu_ih_funcs {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_wptr)(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*decode_iv)(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry);
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32
        rptr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed offset);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_rptr)(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define amdgpu_ih_get_wptr(adev, ih)
        (adev)-&gt;irq.ih_funcs-&gt;get_wptr((adev), (ih))
        <br>
        &nbsp; #define amdgpu_ih_decode_iv(adev, iv) \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;irq.ih_funcs-&gt;decode_iv((adev), (ih), (iv))
        <br>
        +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
        <br>
        +&nbsp;&nbsp;&nbsp; (WARN_ON_ONCE(!(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts) ?
        0 : \
        <br>
      </blockquote>
      <br>
      Please drop that WARN_ON_ONCE here.
      <br>
      <br>
    </blockquote>
    <p>Agree, will drop it.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com">Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;
        (adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts((ih), (rptr),
        (offset)))
        <br>
        &nbsp; #define amdgpu_ih_set_rptr(adev, ih)
        (adev)-&gt;irq.ih_funcs-&gt;set_rptr((adev), (ih))
        <br>
        &nbsp; &nbsp; int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih,
        <br>
        @@ -89,10 +95,13 @@ int amdgpu_ih_ring_init(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih,
        <br>
        &nbsp; void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        &nbsp; void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const
        uint32_t *iv,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw);
        <br>
        -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device
        *adev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
        <br>
        +int amdgpu_ih_wait_on_checkpoint_process_ts(struct
        amdgpu_device *adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
        <br>
        &nbsp; int amdgpu_ih_process(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        +int amdgpu_ih_process1(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih);
        <br>
        &nbsp; void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry);
        <br>
        +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring
        *ih, u32 rptr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed offset);
        <br>
        &nbsp; #endif
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        index e9023687dc9a..891486cca94b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
        <br>
        @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = container_of(work, struct
        amdgpu_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq.ih1_work);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; amdgpu_ih_process(adev, &amp;adev-&gt;irq.ih1);
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_ih_process1(adev, &amp;adev-&gt;irq.ih1);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        index 38241cf0e1f1..8ce5b8ca1fd7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
        <br>
        @@ -716,6 +716,7 @@ static const struct amd_ip_funcs
        navi10_ih_ip_funcs = {
        <br>
        &nbsp; static const struct amdgpu_ih_funcs navi10_ih_funcs = {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr = navi10_ih_get_wptr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .decode_iv = amdgpu_ih_decode_iv_helper,
        <br>
        +&nbsp;&nbsp;&nbsp; .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rptr = navi10_ih_set_rptr
        <br>
        &nbsp; };
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        index a9ca6988009e..3070466f54e1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
        <br>
        @@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs
        = {
        <br>
        &nbsp; static const struct amdgpu_ih_funcs vega10_ih_funcs = {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr = vega10_ih_get_wptr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .decode_iv = amdgpu_ih_decode_iv_helper,
        <br>
        +&nbsp;&nbsp;&nbsp; .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rptr = vega10_ih_set_rptr
        <br>
        &nbsp; };
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        index f51dfc38ac65..3b4eb8285943 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
        <br>
        @@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs
        = {
        <br>
        &nbsp; static const struct amdgpu_ih_funcs vega20_ih_funcs = {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr = vega20_ih_get_wptr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .decode_iv = amdgpu_ih_decode_iv_helper,
        <br>
        +&nbsp;&nbsp;&nbsp; .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rptr = vega20_ih_set_rptr
        <br>
        &nbsp; };
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 10868d5b549f..663489ae56d7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1974,7 +1974,7 @@ static void
        svm_range_drain_retry_fault(struct svm_range_list *svms)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms %p\n&quot;, i,
        svms);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_ih_wait_on_checkpoint_process(pdd-&gt;dev-&gt;adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&gt;adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;pdd-&gt;dev-&gt;adev-&gt;irq.ih1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;,
        i, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
