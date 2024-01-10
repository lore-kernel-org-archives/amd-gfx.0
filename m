Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B5C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 15:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7D210E5E1;
	Wed, 10 Jan 2024 15:29:10 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF3210E5E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 15:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeV3aU3WXR6SYGHHnje5279v0c0vJiAuSpGifKvuVzHnBNv5WZ4Uc3CKWye2wyPKGwROcT+PYsphGRs0LGDRJ7ldngMDhL7L+7c632lA+ZmnXWyNie69EXERVgYUsTtFr8DI4ArX9ZdueQk1F+Ts49HzFcvVhysKP1LoKRUYVGR22lgTm8dd3uPoZsoUcVTeVZ6N8DaRDlWdyeRducQk9Vcdedq1dQIdnHG2mGK7NKS2/zqFCdjCtT3YyUV/VxFF1Nb55StUJfG8K1vWOI7yxvpQpea8pYjIoOzzTwTrF+1wzVy+Jyg2Vt+958O33e0f4HioC07NdN1Xg141ZwfXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToygJnJhrvYx2ng+obHx/MjF0dXMP9OSBxODZKfXJUQ=;
 b=nkqr2t5AetM7P9A9qiD/RN7UNsjtVMVfiGB4a9toGmd8zp0C6fDmHkgaaXIGrIBsDDKHbltU482X1ol4dAgkY+s4KXXjtwZO7gswIUXdN2ddA6rkwfgLbQrprQ089zwroVdMUPkNYuk0Z8tEb7d/x5O/T7lMqd15auJ+sZDpBiVYay66/TtnfgyFX5LVYy1fWCyu6yQm1/s8QLUVbtEaaVTVB3U5XSGoMgx+BxCFt0hQfNKHQrpCsb/mtRwG9mG++QCvUkRkY71E/vGyUrHMoKoMsQO0Pt0lQz0HW1QTbAn1xnWgmNwdGnJii5sPgoKf3rBW4XQiYGWqVulxZBXG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToygJnJhrvYx2ng+obHx/MjF0dXMP9OSBxODZKfXJUQ=;
 b=evzbqKtATGVAGgw/OfGwcN1Xhol58JzsjW7BiG6mPwZsrx+LE7LjVVD2Ozx+5vDFwamDAIFaow2CnJhI0jn++ai+9eNLe5NPGKQzYJK+3WWroBI7EIHkNyE3u+IHU5yT8Mi9ry4UwUn6qC6c/Lv6dHzwGblLjL98NE0LK9ifUTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 15:29:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 15:29:06 +0000
Message-ID: <f6ba897d-0bd3-ecdd-1cb3-810b0b93ff84@amd.com>
Date: Wed, 10 Jan 2024 10:29:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109200527.24039-1-Philip.Yang@amd.com>
 <ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f077b7d-a34f-44cc-7588-08dc11f0e245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa/S54/NK4SlmuY4NFCeQGwqvuiffb28x8ase6t7olU2D2CcJ5XMjjzArsxH5tg6MSILot8r1d/5AUJWJzSGPGFFNtUyr997Kahs/FPB4LLagQ/prBzVvnSmvUwHaAlEyUCb8E7NBZKExEUM0V+ZwCdNapq3tAjYAa6hGV2XV5RhJTwf6uOKAMnWcAEzB/SnxXK/3HhLoj2339SLCfwW+LL/N4OfBl7J3kkknnnH8PmruwosunpJNWzrDFua60hq5SOcnu53o1KbsQyocr9rPd/OVnXeoufpC6fIBl1p5oAJZAVm38Zuqkl9wLL1YLTCumOi4+bbDKVhSBxoFeKrZy2suqvxUVW2u9Pp0LQY3/p7WqwYeCm+ea945vlNu92mWnDDYsatTCPlrsJs7O5R6b+1gbyI+qQKReOZmS+Z9Y1wIyiDMIyLdErFT/F6JQ98pS60ETwvvBiGoG3/892OI1obuIbisrOKdWL6lgL4+Y4X9BiMYoFBtk20eJ6GWCZZ84fylrmtLzwdExOCB8YgyTTI5115MITFy8JFOqYnK4FLhBdR9PXensCCN0qd16qHs6/+GhgE3dXtJ710qo3gFuufJwzwvqebRAMVIK9VcEw+OlQm+6SopAdijWsGTN9N0NbLuoiED7kxp0Zs7HMoMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(8936002)(6512007)(53546011)(36756003)(6506007)(478600001)(2616005)(6486002)(66476007)(66946007)(66556008)(38100700002)(26005)(31696002)(83380400001)(316002)(110136005)(5660300002)(2906002)(41300700001)(31686004)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5PNmFkZ0pGdU9lSnBzb0wrTndtS2dZTXBMWXEydFlTQ2xSM0ltZzdQRlRq?=
 =?utf-8?B?Wk9tM0RXSTJzL3d6SmNvQUtLNFNuQWJ2T3hJbHBUNUxZZDZuZEExMHV2N2Ew?=
 =?utf-8?B?azQ0bVQ0RzFCSDI3L2M5RnRPLzFHaWNhQUIzajh2bVVhUHhEQ1RVV0dDeUZs?=
 =?utf-8?B?M1R3elROUy83UGppM0x0UG5zV2hPR3Fzc2RFbnZEQzBHTG9ZQmsxblFhWUZp?=
 =?utf-8?B?VTA0QVhoVWwvL1cvY0dxdzFXUS9ub2JvY1ZaZ0l1dW4xU3kvOWlHZXowUTJX?=
 =?utf-8?B?QVpwd3dWcm96cXAvYitVS2lxVkRtaHR5R3htUlJDUklmbXBrdlVxUWFTdnE0?=
 =?utf-8?B?OHUwQmVJRitkS2lEamdjcU9iWkhzcTViTjBZKzBuODVIQ2FwOTRQZjZiT1RK?=
 =?utf-8?B?V2hOcmYzdG5MS3VWK28zWkZrVVdGcDh2VE5YeVV0WnNDYW5SMU5TWnF1Q3NB?=
 =?utf-8?B?NkQreHJCelEvVHRqMEhxNmo4QitxTVpEZ0hQakswN0tMZlNqaHUxNzgzMElG?=
 =?utf-8?B?SSs3cVJkUU9GNDNjZlJDZ05HSWNhU2VMd20xUzVkOHZ4elJXRGl2MVlndjc4?=
 =?utf-8?B?cnRKLzE4NDE2b3lzR2hwNm1BMy93SVcrQkYxckg0cmhpZmwxamZMdmc2bGJv?=
 =?utf-8?B?b0FURmkwR0dZOStPeDg3bkpsL09aMDNzZzRvWkJEZGtFOGF6MHJ6YkhrYTNI?=
 =?utf-8?B?dHVRaW03bml5K012UVY2Tk5CV25NVFNSTXdRTnFjVnh2cW1ISTdnKzZHcjJi?=
 =?utf-8?B?cThkVmlBMS9TQ2JlQjNWMllsa2hMMElZNDVaa2tBQjMzMGkwWVVVc1RNOGpR?=
 =?utf-8?B?REN3VXBvSFNaZ3NTK1lWTWs3RGJiaTZqSzhRRUtnRlgyNmdtRVd4dzhseVBJ?=
 =?utf-8?B?OUwxMTVmR2F2VTRWZTVNT0hpNFB6OTBTRGFKRm1kVTg1RnVnZGJtRTNmREMr?=
 =?utf-8?B?Q0dIUys5OUdCV1Q4OFBHZlh0YjVDQ1Ywdk1pWHlneW9iWVlHVUVtaVpDbUlC?=
 =?utf-8?B?TVJIMEp2REZxc29BbmpoK2h4cFdjM2t6QlNBZmRQR3ByeUJkTTNPRy94QkM5?=
 =?utf-8?B?SzNxN2FvUHhHdjFNZTVYbDd3bXNqVkp4a0RTcWxRV29BangrM3RUZlJiakVs?=
 =?utf-8?B?czRNckhQOUhQdE5HRFdPMzExOER2dkw4WXhGK1U5UUhJN3grY2p5SnVxQU9h?=
 =?utf-8?B?L2RRTy9NNmtpWi93aFROQUxyTE51QmRnRHlvazhPVEhmM0JIUzBzN1JPN0cx?=
 =?utf-8?B?MHE5Y0JKUUFxY1lYSmxJdkM1YlVBcTNJWHF1OGMvQ0s2OWVEeEdhNmNmZU9v?=
 =?utf-8?B?ckIzc3BWSUVtTkRyU1BEZzF6dUltalVPS3RkUm92bWhoTVN0cGdvTlBtQXNO?=
 =?utf-8?B?Z2tYLzNybUFPN2MvM3BQaGtZUHNZZDJzYmZJcmNwK3JKa093TG1sTG5GZVRq?=
 =?utf-8?B?eG1IK0lYMDVSVzUzbjNOYjA4MjhxVW1vMWJZWDVuanM4QmFPZHRQR2Q0aXdC?=
 =?utf-8?B?eUVSamtMWHllcHozSlZLWkM0Y05LS0hidWJ2eGJJcW9ReUlCemdSc29XSXpm?=
 =?utf-8?B?V2dJYUV3dE5nTVJTSklvSWhQTHpRU1hWYWVxVlArZmFSZTl4SW9wM1FQTk5P?=
 =?utf-8?B?K3BidWhJYmpGUldnZEwwOExiSXI2TlhUQS9mbjR3Q3dLeENLazFRSGZyaEt1?=
 =?utf-8?B?TFpGaTBXeGVUemZzcjRvbEhmMzRvK3lJWEQyS3RBc1JJQ284RFBpVHlralov?=
 =?utf-8?B?OW1jeHhyWWErKzQ2dmFJVTlqalRQT2sxZlhPN3IyY3lNNTladWp4ZFhUM3Jh?=
 =?utf-8?B?ZnFZSjBiN1Y1R0FKblFCNWdGRzhTWkozWWhEVEFCZklON2VZNTZHU2N2cHAv?=
 =?utf-8?B?ZHJXOStwRXY1VVYwUnU3R1FBVXdyV1BDVXFicVpFZm5YdkphMTJHMzNpNEN5?=
 =?utf-8?B?WjlMcHdCdURvcWpLdmgrSXp6aVllMWNweUd2RHZjNzAyclh2ZjRqMHJCbEZE?=
 =?utf-8?B?NnFSNmNjZXJ4ZjJlRnpBY0Zpc1pkZTQrQ2QvblY2QzVXMG51b2hsbjBQQmY5?=
 =?utf-8?B?NlowYWFlYWhhcFdYcFd4Z0p1UUdPWmpyT1VuajRiYnZVZzlkNCsvMjF0a0x6?=
 =?utf-8?Q?N3qY4LWCQSIfXXxYm/lrt2xxG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f077b7d-a34f-44cc-7588-08dc11f0e245
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:29:06.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVwr0GIj/zwKU/aGwQ4giiD+p1NZoxjnKuDEhYCCP91Eq3sU+NsG52go+lMNmr89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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
    <div class="moz-cite-prefix">On 2024-01-09 17:29, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com">
      <br>
      On 1/9/2024 2:05 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">After svm range partial migrating to
        system memory, unmap to cleanup the
        <br>
        corresponding dma_addr vram domain flag, otherwise the future
        split will
        <br>
        get incorrect vram_pages and actual loc.
        <br>
        <br>
        After range spliting, set new range and old range actual_loc:
        <br>
        new range actual_loc is 0 if new-&gt;vram_pages is 0.
        <br>
        old range actual_loc is 0 if old-&gt;vram_pages -
        new-&gt;vram_pages == 0.
        <br>
        <br>
        new range takes svm_bo ref only if vram_pages not equal to 0.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp; 3 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 35
        +++++++++++++++---------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-
        <br>
        &nbsp; 3 files changed, 27 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index f856901055d3..e85bcda29db6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -839,6 +839,9 @@ int svm_migrate_vram_to_ram(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange, start_mgr -
        prange-&gt;start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_mgr - start_mgr + 1);
        <br>
      </blockquote>
      <br>
      when come here we know some pages got migrated to sys ram, in
      theory we do not know if all pages got migrated.
      svm_range_dma_unmap does dma_unmap for all pages from&nbsp; start_mgr -
      prange-&gt;start to&nbsp; last_mgr - start_mgr + 1.
      <br>
      <br>
      If there are pages not migrated due to some reason(though it is
      rare) we still need keep its dma_addr, I think only hmm can tell
      that.
      <br>
    </blockquote>
    <p>For system page dma unmap_page and set dma_addr=0 after migration
      is fine because before updating GPU mapping,
      svm_range_validate_and_map calls svm_range_dma_map to update
      dma_addr for system pages.</p>
    <blockquote type="cite" cite="mid:ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com">
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r &lt; 0 ? r : 0;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cc24f30f88fb..2202bdcde057 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -254,6 +254,10 @@ void svm_range_dma_unmap_dev(struct device
        *dev, dma_addr_t *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = offset; i &lt; offset + npages; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_addr[i] &amp; SVM_RANGE_VRAM_DOMAIN) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[i] = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      same as above here set dma_addr[i]=0 unconditionally without
      knowing if the page is indeed in sys ram.
      <br>
    </blockquote>
    <p>dma_addr[i] &amp; SVM_RANGE_VRAM_DOMAIN is for device page,
      system page will still call dma_unmap_page.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com">
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i]
        &gt;&gt; PAGE_SHIFT);
        <br>
        @@ -262,7 +266,8 @@ void svm_range_dma_unmap_dev(struct device
        *dev, dma_addr_t *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; -void svm_range_dma_unmap(struct svm_range *prange)
        <br>
        +void svm_range_dma_unmap(struct svm_range *prange, unsigned
        long offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *dma_addr;
        <br>
        @@ -284,7 +289,7 @@ void svm_range_dma_unmap(struct svm_range
        *prange)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev = &amp;pdd-&gt;dev-&gt;adev-&gt;pdev-&gt;dev;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap_dev(dev, dma_addr, 0,
        prange-&gt;npages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap_dev(dev, dma_addr, offset, npages);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -299,7 +304,7 @@ static void svm_range_free(struct
        svm_range *prange, bool do_unmap)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (do_unmap)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange, 0, prange-&gt;npages);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (do_unmap &amp;&amp; !p-&gt;xnack_enabled) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unreserve prange 0x%p size: 0x%llx\n&quot;,
        prange, size);
        <br>
        @@ -362,7 +367,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        -&nbsp;&nbsp;&nbsp; prange-&gt;vram_pages = 0;
        <br>
      </blockquote>
      <br>
      still want it as the last patch? I thought you want also remove
      <br>
      <br>
      prange-&gt;validate_timestamp = 0;
      <br>
      <br>
      and
      <br>
      <br>
      atomic_set(&amp;prange-&gt;invalid, 0);
      <br>
      <br>
      that are not necessary to set afterkzalloc.
      <br>
    </blockquote>
    <p>remove the unnecessary prange-&gt;vram_pages init is because this
      patch is fixing vram_pages related issue.
      prange-&gt;validate_timestamp and prange-&gt;invalid is not
      related to this patch. We could use another patch to remove those
      init, prange-&gt;validate_timestamp will be removed in the
      following patch.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        &nbsp; @@ -980,9 +984,14 @@ svm_range_split_pages(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc)
        <br>
        +&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc &amp;&amp; new-&gt;vram_pages) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;vram_pages -= new-&gt;vram_pages;
        <br>
        -
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!old-&gt;vram_pages)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;actual_loc = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; pr_debug(&quot;new-&gt;vram_pages 0x%llx loc 0x%x
        old-&gt;vram_pages 0x%llx loc 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;vram_pages, new-&gt;actual_loc,
        old-&gt;vram_pages, old-&gt;actual_loc);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1002,13 +1011,14 @@ svm_range_split_nodes(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;offset = old-&gt;offset + npages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (new-&gt;vram_pages) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1058,7 +1068,6 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access,
        MAX_GPU_INSTANCE);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 026863a0abcd..778f108911cd 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct
        svm_range_list *svms,
        <br>
        &nbsp; void schedule_deferred_list_work(struct svm_range_list *svms);
        <br>
        &nbsp; void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t
        *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long offset, unsigned long npages);
        <br>
        -void svm_range_dma_unmap(struct svm_range *prange);
        <br>
        +void svm_range_dma_unmap(struct svm_range *prange, unsigned
        long offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages);
        <br>
        &nbsp; int svm_range_get_info(struct kfd_process *p, uint32_t
        *num_svm_ranges,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *svm_priv_data_size);
        <br>
        &nbsp; int kfd_criu_checkpoint_svm(struct kfd_process *p,
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
