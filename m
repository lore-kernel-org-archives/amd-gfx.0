Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6664CD37AE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 21:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2C010E686;
	Fri, 15 Sep 2023 21:20:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E1C10E686
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 21:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJGksJ5TbjLB5U4PQCMg6nyqF+Mqq1/fePHzyFteqK3hYJApBDXvDwmG1LBFUgsqcJfgHojfmKCVS960pW2OWsRLhipwfNKrf4EUjoNPlpfQCHJ2BdMajds1WtKn9Z66cgW60aaEtV96lLa+H0lBxRwa+ZHRp3c0zY1DNd47Rp07z+ZeBuvyKgCkCjQqdvqgQtVHA5t5YJ7Nw1uXbFCDo0RlsPx0Z34C77EJlE35fQzGNponsy0QiQ+aDCEW1Z/vdALMXfFFcLLUEQsceUAzj/NFKHLUiNAwbmm/X2O5cD5d5R2Fx8aeW7rVG7yXRwWkdPfnqmuIbVqWnexrvrdOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nseYkNAN4QS3/zEUCKvLuIjdYJATwUmMVGedkaTXXYU=;
 b=j7PIr+AVBx4ezTwJ/KcHNL4HdasS0L1TkeZNJVn+8e2sJ8+V6I2Jqq9d8N1zQ0EvhyVlIdjw3RwooFMecfjvjOPWKg+aK9UrlcaW+YiqNr3qwI1/1mvB8cZtp9IYse7YEwjF8a0asU6mK2c3DP/CSEyd4j4CXQlr4coEHXZzVa5d3AStfaNn8RdKtxNd/W5Mga2wEVW19nzV0PdJ95P7af0+Xs/YxC3PNYgdrva26W9Moe0NX8vkTs/+RAs7qCvcWISPuZ/K1ArCicESetv6fTdKLd9aUrMLEppPwTtH/cjhk+Rzey02cqzh9h7RbUn06b/JXyYIIdLTpxEWXcmOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nseYkNAN4QS3/zEUCKvLuIjdYJATwUmMVGedkaTXXYU=;
 b=t7fPecox6mJjiqENNc/BdVmoZ2ipgnIx07sg/NXRLLArEnYRcwt2Opvkx6SEmox541GgPCv2UQuPWG1gxKYbqi0/V8KTObXWMz70hZvPxmcLRLuJa7WbwrCqUEWM4/B0gNFay9rr5IUvibpj3Nfhx0nO5P4pxi6L3aQDaio8kc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 21:20:31 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 21:20:30 +0000
Message-ID: <5ee60075-10a2-e3d5-4e5a-538fca90bc58@amd.com>
Date: Fri, 15 Sep 2023 17:20:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230915132804.20813-1-Philip.Yang@amd.com>
 <28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc79a57-a1ab-4ec8-8f96-08dbb63196f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8f+aBFhwveg+sBkweO8Y4UigGwLoQIZr0X0XNekfeVCgJEqF0wYYwnp36NCZ8cAaaAS/1+lRliVJ1YMBsJkapnF1kVpZg2aMIm8tKtmrSfFPjLQSVch2QupGcF7kwCv1txOZG/VhYyhD5Id8/3idVLxx90xN726a8RoAICohGmEvCROCHn13/AUMTf8+e444hgJdY2CW6l3CH+VJ2Z3Dold6rOcpoqBjJ1lPjewzSE5MOoMFiFlCxuYm05cRnzOzjDLEZnFJYtMODhm4HQ7tdgFIUNp1hsLOBRXEAJyUvLAjNtpqiZiBNvgJMkD7yObg8oqQegTiD5uPchMwVpHmnfQ1bo/8QgyIURbPT2EDdhsckY0+3cl9Vjl0ntn6ZI8m8O2tKbN52AF2BnVu/lrvE92+fg80JW2Zigo1qOJD8Lp9giatSRt9dRzmneEDWMeVXF8sEdDiscpQDtmm+OJJRuTzhT5nfEm53eS4StsIon2poFE+IOZ49q4Xkv3RukCc/D+kFw5z6bOr78FqclKoLYNeD2mMs61SKqrBfVEge7rvoWsPiF3gI4/VZFr+akJ7CL1XkSuoArnlhq9rpd7iM7zp5fcWS546NBDD6+zFRgeV5DWmDoDL6F5f2AXEz/4a2Bb5CkbvpOJ9nrVOcUUK7Rm6RQKjNNpywwuw8gjSxac69nezZEs/iHFNW0gT70+K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(186009)(451199024)(1800799009)(36756003)(8936002)(4326008)(110136005)(41300700001)(31686004)(316002)(66476007)(66946007)(66556008)(31696002)(5660300002)(38100700002)(8676002)(83380400001)(478600001)(2906002)(26005)(2616005)(6666004)(15650500001)(6512007)(6486002)(53546011)(6506007)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpScE41b0JMYkJnL1p5VVdFQm5mbHgzeE5XOHFIZk5meHFQODZ1VE9FWWJJ?=
 =?utf-8?B?czVEVjBtN29NUmh5QzdKbklsMDFYYXhDNmgwUDlTTWhPOFBsUEZNUkZQQmhL?=
 =?utf-8?B?MDRwOHRVUm1QV2ZMN2ZaK3EzalBnQnBpYXJyQVVtOElWYUVUK2FPdUxHWFhZ?=
 =?utf-8?B?ejBZaVM0QitWWjQ4L1JJMyt3L2lDQmtEb2VaTC9IdFd6alZqdm1tSWVMMVBM?=
 =?utf-8?B?RU9aRHAybDkrWXR1blRuZ3g2NmhWVUc1MHgrRHZvdlpsQVExZzBkSytxT1Ez?=
 =?utf-8?B?dVFxYis5TkpmZWMyQko0YjFPRWFLSGp0UXc0MnZFZE96M3RZQSt4SVYzT3Fw?=
 =?utf-8?B?OHhCdnFWQjJoTU10OTRSZnZKZ1lJMnVnbXlKNE9SWk9QaVZRdGs0S2F6em4z?=
 =?utf-8?B?U3RYem9XNUhiMDFjMVNVblFURE9BV0svK0t4V2w1WStwY2NQamE0Vkp2NTFy?=
 =?utf-8?B?dG1QKzlEQmtUNit0VHM4MG4zN3M4cFprVFA5Slp1YkNUcGhqK2tWcXhNMkRV?=
 =?utf-8?B?SytQZDJnTkpqQkJvM3RLWWhvVUlNL1BPbzl3dUhudzVhV1pMZy9yTkZJbHBn?=
 =?utf-8?B?OGtuT05Cek9SNzRHZUtqMjF5UjN3eXNRZ0NOM1QrN2VlREJyaklLdUY2WktB?=
 =?utf-8?B?ZndQWmpjSlF5d1NzRWliKzlTaXlWTEhXT2tKVTNlbG5tM0dDN2w1anpOVVEz?=
 =?utf-8?B?L25IdGgrV29jWlR1YkpZbUN3dVFrOC90VlFIazZpUkN2TkFXVXVwYzZ6VTIr?=
 =?utf-8?B?YVkwWTVoQ3dQK2FSSVR1RnNVTE81bDdwVDJwVWNYR0xPY2pWLzhoMU1WTlVM?=
 =?utf-8?B?WXdlQUhLTi9QMXV6U3p3bWpmNm1KK2tBbENsc3U2MVhtZThrdDNJN0hCcC85?=
 =?utf-8?B?ZzY0cDJuUER4MnR4R282T05QRTFtNW45NktOK2p0SzY3RlNiRnU1R3ZscWRQ?=
 =?utf-8?B?Y1MxZ2lUSE5CTjdrK3Z0REZqMysvaTlBQWpESm1HZG50NFdiMnhvVm00cXho?=
 =?utf-8?B?YTNqaXJZaXRUTEh3bHdhaFZoZ3RDbnAzNExaUGxRd2pZUWtaMnZrbmt5aU5a?=
 =?utf-8?B?RFNZYTF0RHVtVmZXZUdsOUNvejNuNTJNMEVLK0lsdzcwdmpTU3FxRHVrSFFG?=
 =?utf-8?B?UzBXSTZzMkZuREx6TGNVSE8yaTd1WmZONzZwcEY0NlcwZkxqM3BRYmR0MXFW?=
 =?utf-8?B?ZitEbE5VempHNVJudGlyU3pvZW02Ti9rUTJwRUFQMHVadGtld1JjMUxrNm1E?=
 =?utf-8?B?c0FwcFIxQVFKeXE0NE9LOVdhS2VDRFVkQXY0S3V6ekJQQmx1UlFkcGNHODV6?=
 =?utf-8?B?T0hFWmRVeXdCQS9NMG1Ud0FUS1pzdXdCSkVHMHVWMGtIUHBHbm90TVFLSUF3?=
 =?utf-8?B?dzBBRit5TGpPOHR2RUk0dXhyKzB5ak9iVGRzOUQ0cTFJa1UzOHI4dXIvMCta?=
 =?utf-8?B?cDFGalFzWENRR2NlVVh4SGxlWU9JZy84dEJja2YxTUhRMHNMSmc0Y0tEZEVC?=
 =?utf-8?B?ZUZvaHRNMWw4K0VleDB6Yzc1amdUR2RBOUtUMXpvS0RJb3BqTzVnRi9DcTZu?=
 =?utf-8?B?UTc3alZUWEhrQTdDVnhmcllFc1pWUEhhajczb3BmZVpteEFZQno2Q2JicHJy?=
 =?utf-8?B?N3dwM2lhU3Z2bnNhODhYTjJkRGl1MnBLRzRkTVJWTXA0M2cwbVNIYkduTm1v?=
 =?utf-8?B?Z0oyYktXckw4MFJmb01pcWtwTXJFdFlSZy9FdVJSSTEvYnJGZG9ld1dmMGVT?=
 =?utf-8?B?OFhzM3FQcGJPaXk4N0N3clpPYmRNR3kyMHhUV0ppekNGZjNNYzV4TzdKa0JQ?=
 =?utf-8?B?ZVVMVWNWNG1ZWDZDdkhOYzhRVkFvZ2tvRDUzNE0xZmdIOWR2RGNVd2Jmejdz?=
 =?utf-8?B?UUhNZHB4cGJ6b29FUFk2elZDZXlLM0ZpRnZ6T0h6T2phUDVPWXBnQmVNdjgr?=
 =?utf-8?B?cm1lcmdESjNNUkVnbk1sREw5MUc3QlNyUVZMOVBBK09JWE1ZMk5GeXFtK1I3?=
 =?utf-8?B?cXBTTUFiOUlObm1TdVh4VkF5dzkxOWR2NEF0QUxYWjA4TGRRVDh3WFphbUJE?=
 =?utf-8?B?MGNKNi9JbFMzKzY2ZThlakJyK1VhNDJpdENtU1NESll5eGwrTFdTcU5HdG1Z?=
 =?utf-8?Q?qNZzndaB3xIQqc7xwk2i36RSj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc79a57-a1ab-4ec8-8f96-08dbb63196f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:20:30.6912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmxkZjdGHuXK0CYKC5eAUdYNjJqNGXBXLdOaX7iWloxKqiiHzoAwSDlZr41iMVK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-15 17:06, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com">
      <br>
      On 9/15/2023 8:28 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        If new range is splited to multiple pranges with
        max_svm_range_pages
        <br>
        alignment and added to update_list, svm validate and map should
        keep
        <br>
        going after error to make sure maps_to_gpu flag is up to date
        for the
        <br>
        whole range.
        <br>
        <br>
        svm validate and map update set prange-&gt;mapped_to_gpu after
        mapping to
        <br>
        GPUs successfully, otherwise clear prange-&gt;mapped_to_gpu flag
        (for
        <br>
        update mapping case) instead of setting error flag, we can
        remove
        <br>
        the redundant error flag to simpliy code.
        <br>
        <br>
        Update prange-&gt;mapped_to_gpu flag inside svm_range_lock, to
        guarant we
        <br>
        always set prange invalid flag to evict queues or unmap from
        GPUs before
        <br>
        the system memory is moved.
        <br>
        <br>
        After svm validate and map return error, the caller retry will
        update
        <br>
        the mapping for the whole range.
        <br>
        <br>
        Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle errors
        from svm validate and map&quot;)
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++----------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h |&nbsp; 1 -
        <br>
        &nbsp; 2 files changed, 8 insertions(+), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 5d7ba7dbf6ce..26018b1d6138 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process
        *p, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !prange-&gt;is_error_flag;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; /**
        <br>
        @@ -1724,20 +1724,17 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait,
        flush_tlb);
        <br>
        <br>
        &nbsp; unlock_out:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = !r;
        <br>
      </blockquote>
      <br>
      I do not understand why set prange-&gt;mapped_to_gpu here? It
      handles one vma, not for all prange. If there are multiple vma and
      first vma handle is ok, and second vma handle fail at
      amdgpu_hmm_range_get_pages or svm_range_dma_map, you would get
      prange-&gt;mapped_to_gpu be true, but only part of pragne got
      mapped, right?
      <br>
    </blockquote>
    <p>If all vmas map to gpu successfully, prange-&gt;mapped_to_gpu set
      to true, otherwise, prange-&gt;mapped_to_gpu set to false, and
      then svm validate map to gpu return failed, the caller will retry
      if error code is -EAGAIN.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com">
      <br>
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unlock(prange);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr == end) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr == end)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validated_once = true;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        &nbsp; unreserve_out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(ctx);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;is_error_flag = !!r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =
        ktime_get_boottime();
        <br>
        <br>
        @@ -2106,7 +2103,8 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = interval_tree_iter_next(node, start,
        last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr,
        attrs)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr,
        attrs) &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start ||
        node-&gt;last &gt; last) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range and
        its attributes
        <br>
        @@ -3519,7 +3517,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *next;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_mapping = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool flush_tlb;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, ret = 0;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages
        0x%llx\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid, &amp;p-&gt;svms, start, start +
        size - 1, size);
        <br>
        @@ -3607,7 +3605,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp; out_unlock_range:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dynamic_svm_range_dump(svms);
        <br>
        @@ -3620,7 +3618,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] done,
        r=%d\n&quot;, p-&gt;pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;p-&gt;svms, start, start + size - 1, r);
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret ? ret : r;
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; static int
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 9e668eeefb32..91715bf3233c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -134,7 +134,6 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validated_once;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_error_flag;
        <br>
        &nbsp; };
        <br>
        <br>
        &nbsp; static inline void svm_range_lock(struct svm_range *prange)
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
