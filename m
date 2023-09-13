Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7199EE01F4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8DD10E4CF;
	Wed, 13 Sep 2023 17:33:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A9910E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOokYi0RIJNojWbWC2dNQK1gtYRBezlSHFD+ts2FTVw4H980+w7ureplm3TjuUue+uk9EZ/6+kjTBRjThd3TD+1MxGIUdRzIzNJgeEaZg1Z/3qWXXPmcUkge7oInt5+PmkDQOtlYe3403lFz9BDV91c3VJQwRyfe7S+3azDh4/f9XhwKeh8XH6rbhw3/yssIzJI4YXFWQGCrndagyZstSMx703HTUWCcoZ5R3gnOckyziZ1lI/dtf2BnO77QSXkvWtHKkC8/xgAqigQQp7E57bvorTzWcQK/WWQqkcB1AjWyDEM6aDo5z58sqLoj4gP8LmvM2D3z44fxImRICJmwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoa+coqA2t2ZUazAhj0BxBhu8wi+DSW0zUV5S73dwo0=;
 b=meEM8wVoX8I6NUF5l5hY/e02x2m5SBSn/3CAlPd7p1krK8UrdfVY0Mx4cUJuR6FaMtFDFOciN3y9z7yxmVcHFATS8khOdmOejwwBgJrlEVJmPB3uUnxtn4FfcrO5/i/eFDHOpM65cAcNQwK2McuuK8ZE5oz770o4BlLpQYS82p0b2qdyrtFa2s0UBcmWda4MRdNhzE85APLifkoG93cuvd1+Ep4q25jvXujLjCotOtqR3GIUfy6eXTo7mE1OZwca4SSFbr38SQgA0uFLwvhPQOiCuJlB6hyF94uWwS2B2lpZhMtqHwkUm3zQe0gWHbrXydz9RSC30w5Cg82gQKXt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoa+coqA2t2ZUazAhj0BxBhu8wi+DSW0zUV5S73dwo0=;
 b=nUKOKwaK01S1jiEPtwn1XO9rwNKt5ravuBOlFynRlHJVOQKWZ2eMG3wmmWFXgCmJroGRG7Hob0NgRtDGY9sXVa33WTN1uxf2crmU2kfnZUCbujo0aRVa3UChbuG5wpZL2wiauod0OQ7nYPTTC7kRHsQ9yN+iQ7vvcc/2D+WdbK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 17:33:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 17:33:12 +0000
Message-ID: <ae59f686-e187-f67f-3fdc-03691d1ba5c5@amd.com>
Date: Wed, 13 Sep 2023 13:33:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c848ef5-3456-4a2a-a7ab-08dbb47f8118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zofTI6ZfN7J1A4L9Lzyfmz9aDrwYbWSegEyycepf9ckleq+plVqJexgBoxpVXHQT4vt/BE6dQnmaxQ4BUtCqoafgh8ge9tUBS00U5FDk7Fm7V5p747x49VWD/QNRemFEBaRLBd3pzP2uBDH2oR6BS3IB6h+iBh0Mj5vrq7x0lj0DUTkmk8RzcTf61RSOUsf05fyZV5/f9bGFFulJ6JnJN7cjUKJLCTB2S8NpJpJga3gEB+BsCUiuU9+wcV+3sVe8Un3vxWjojCiIQwUHpt8n/Tg9ALQQUqUkmn/LhgnegsagVJHjVsDXhyhIXqrR1NgfsysRibMOXOfaFTXWYaxrBSJM1jitxSjYnSHdny7Vz9UzzMwJL+hUXLPSLFSH+RHzzGMNDDh1dlUbU2OcetoBJ1+9Wm0zGgiP/OdmlOGv4liSIg+MgFx90RNQibinPejWf6E8smXKSsx2OAuC2p7uSnwb7dvnAK2hOnSLWqhFMbX26V9jDyXV5fcH538HDaVPmPyK8X2Jgxs+iqKL0KfQwnvUhL7IXGfOni4eOZYCHiimzSgM3uDouuthI7Gk7YWoNau15Hf/UifTFtVKLDeOdz888d/ooQupwIMeOI+0akTrf54TQEP1bWTtXF6nrkqAB5KjFm9J4NFFBcKtSMNJuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(1800799009)(186009)(451199024)(31686004)(66899024)(6506007)(6486002)(53546011)(6666004)(36756003)(31696002)(38100700002)(26005)(15650500001)(2906002)(83380400001)(6512007)(2616005)(478600001)(5660300002)(4326008)(110136005)(8676002)(41300700001)(8936002)(66946007)(66476007)(316002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhyWnV2cDk0TDM4bFppdXc2MlZyRjZTeW1vdDhWamI3aDdINlJONGZhUEFH?=
 =?utf-8?B?RWJ2T29aODNRTUY3NmoyYXdLOGl1aW1Ja3plenNxVlRrVCtnM1lkcUtnZENN?=
 =?utf-8?B?V3VCYlZuMnNXMGZveTFEejRWV01yaW5qeUhrSmdpWXNmZmhGMHBTKzNjRFh6?=
 =?utf-8?B?MUxaaCtyeVRNaFMyWm02a1A0cytscHpXZWdLcGdaOTVMYUQxV3NpN1RGMk5Y?=
 =?utf-8?B?SFFuUitpSkpNZ0Nac1htMlVNdFlsUzhaQk9RSUNzaDhhb2U2eTArZWQ5UDZO?=
 =?utf-8?B?VjFqVDJza014RklCZlFyQ0R4ZVVOMmxRUit2ZmEzanJaUDhrbFhpY1N6QnJT?=
 =?utf-8?B?b20wTXFDMCtsWDBHb0dNZWcwSzdTWDFSR1VxUU5QbStWWGs5eGZwcDJ6Tmx1?=
 =?utf-8?B?ZXhmbW52TnY5NUFKTmxxZy8vdi9lTXdlRVFZQTB4R2FPTE5PL0Z1Y0NYMXNa?=
 =?utf-8?B?Qm9DNnhvWGRZUmxqUGROZXYyRGMxR294MjNua1F5Vjd0c29NZVBHTnN6cytQ?=
 =?utf-8?B?SENsNFNlZFF4cm5CeEsvRFc4YWprOUk0emtWTkk1OVY1S2tEMGpBcnZWNW5S?=
 =?utf-8?B?eXVzalhBN29UWnhHUHdKRGt6SERhYjEyYklRS2hqb01qZHpjVzJ4aE44QVZR?=
 =?utf-8?B?bkh3ZWZERTR0Nm8yNHF0SGZOUVBNZkxwbGZFOG04Q3BIU2F0NmlEWFZ4ZXg0?=
 =?utf-8?B?RUN4VDhWaDFyekdSTHFkZUk2c1JCVHhEM1dYNlI4SmI0UmE5UVNZdFNybzFv?=
 =?utf-8?B?aVdrdEVTcWdlYnhOWmQzOElTTVRHREoyUU5oNGMraEtwTkF5KzZ2bm8vdGlL?=
 =?utf-8?B?Q21DTVJUd2grbUZvUDRPRnZWVDRRR1lXdnRvNko4YTJTcVI3eHpVeElmTjUr?=
 =?utf-8?B?empRaGZ4cFA2RS9laTRUWEc0L0o5dERFZDhEeVFrSGdVajN3NlJTQlFiSUlJ?=
 =?utf-8?B?MDNWQ2VkNjd4MmlUQy9LVjVGblFSazdMdERwdU9tSU5ZeTRYb3lKZFlmbWtJ?=
 =?utf-8?B?WWo2elpzY01aUkZwRDZscjl0RnUyZ2RLT2VBVlNYY1JwMnZYNUduMXo5bURN?=
 =?utf-8?B?bVpoM2JlUEh1bGV5ZzhGOEZIRWNjQ0Q5WS81bkNBL0N5WUtBZ3FjUzZVS0NE?=
 =?utf-8?B?N3UwMUVleHQ4VVB6a1VjVzB6R3dRUEhRUHJBMTNHanhOS25lVTdGdWNkSFgy?=
 =?utf-8?B?RVhRWWZJaldEQm1DU25QelFGOVdJMDg5blR1a2V0SHBtbmxuVGRGWEJhNmhv?=
 =?utf-8?B?djRyMjNvZlR0SkNNa01hOWhHMk0rdTdybEludG1xTFhGWUF4SzB5b2NjL0RJ?=
 =?utf-8?B?akcvWFBmTk5FVWJhWm51T1g4ZGhqODhqWkVtU2tjdXFmNENsdXRtcFdrWWl4?=
 =?utf-8?B?MG9aNk1MbnBoMTk0T2ptWjlmSjZ1QUxPdGNETkdMSEhjZnlDaVlueVQ3Vjlz?=
 =?utf-8?B?TjBLRHc3UVRSMGZ4WVFPWS9EYTJ4UDZUVUl5L3Z3OUFQTDA3NjlhZzh3UjV0?=
 =?utf-8?B?Y05pSk15ek9CcERCNkJLR2NkdGtvank2NkQ4bXhqL2MvQ0ZWSnlOZDMyem0z?=
 =?utf-8?B?azFWRFUvNjFHeXEwZVlzK3ZwVkpYeDJXVmFlSjhyZHlUT3ZqMlV2QzRtYW1z?=
 =?utf-8?B?T3J2bXpkMUltWmJneVVNOXpRTTJZUnlhbERVSXU1Vmp4WXFKUEFpUU15citm?=
 =?utf-8?B?VnBIQm8xWlljd3dqVWZ4cXZpbVVORFhYSHZBVVkyUjRWbnpPV1Nqek9VbXht?=
 =?utf-8?B?anZyTDRaSWtlWmcvMitvNGhmelBqaENjZk1EWUJybElEUmRLZFBhZGRpQ293?=
 =?utf-8?B?eEsxR0dRaFYrRVNkMlRiamY5MTR3UGx5bUplTFdUZ0FPMTJpTDZMZUNZc1R1?=
 =?utf-8?B?cHF5bFNRV3NOWHNXNGhjOGpCL2FlbXBKNWZxQVZKc3ZSMDBidVlvakduYnJm?=
 =?utf-8?B?eUNZNmt1VkFRaXFjTTc4cXE0TkNVc2YwMFAxZ3Z1Q2ZJajZTaStSK1Q2STQx?=
 =?utf-8?B?VXFiN2plREcvTHMzNUdGcVN0RTI3U2JRSlBiWXI0QzVlZGxHQ0lPWWxCZS9M?=
 =?utf-8?B?cUtNTU9lWVJ3K1dUWVIxY0VIVFBaTlAwTUVJcTB6cjM0ZUlkSUlBSFphQjhi?=
 =?utf-8?Q?4pYJeF/XjXjP1anH0YQnLGFmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c848ef5-3456-4a2a-a7ab-08dbb47f8118
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:33:12.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yu8UzlEiTwD+fMQijxSfplIZBteGUbgAG2QqwvC7NoBFIjMdT7gE5zkzYEhnVa5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-13 12:14, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com">On
      2023-09-13 11:16, Philip Yang wrote:
      <br>
      <blockquote type="cite">If new range is added to update list,
        splited to multiple pranges with
        <br>
        max_svm_range_pages alignment, and svm validate and map returns
        error
        <br>
        for the first prange, then the caller retry should add pranges
        with
        <br>
        prange-&gt;is_error_flag or prange without
        prange-&gt;mapped_to_gpu to the
        <br>
        update list, to update GPU mapping for the entire range.
        <br>
      </blockquote>
      <br>
      It looks like the only new thing here is to remove the &quot;same
      attribute&quot; optimization for ranges that are not mapped on the GPU.
      I don't fully understand the scenario you're describing here, but
      it feels like this change has a bigger impact than it needs to
      have. Your description specifically talks about ranges split at
      max_svm_range_pages boundaries. But your patch affects all ranges
      not mapped on the GPU, even it prange-&gt;is_error_flag is not
      set.
      <br>
      <br>
      Maybe that's OK, because the expensive thing is updating existing
      mappings unnecessarily. If there is no existing mapping yet, it's
      probably not a big deal. I just don't understand the scenario that
      requires a retry&nbsp; without the prange-&gt;is_error_flag being set.
      Maybe a better fix would be to ensure that
      prange-&gt;is_error_flag gets set in your scenario.
      <br>
    </blockquote>
    <p>Another way to fix the issue, set_attr continue to call
      svm_range_validate_and_map for all pranges of update_list after
      svm_range_validate_and_map return error, this change will have
      less side-effect.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle errors
        from svm validate and map&quot;)
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        Tested-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:james.zhu@amd.com">&lt;james.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
        <br>
        &nbsp; 1 file changed, 3 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 61dd66bddc3c..8871329e9cbd 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -825,7 +825,7 @@ svm_range_is_same_attrs(struct kfd_process
        *p, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return !prange-&gt;is_error_flag;
        <br>
        +&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -2228,7 +2228,8 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = interval_tree_iter_next(node, start, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr, attrs))
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;is_error_flag &amp;&amp;
        prange-&gt;mapped_to_gpu &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_is_same_attrs(p, prange, nattr, attrs)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start || node-&gt;last
        &gt; last) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range and its
        attributes
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
