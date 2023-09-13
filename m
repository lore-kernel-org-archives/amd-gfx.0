Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAAEEE01F4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2BA10E4BB;
	Wed, 13 Sep 2023 17:24:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2A610E4BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFbVkBL0gO3EPowyyuE/BAUUOl8FcsniqXXy8G5zEq7i+u8h6Xp+0uhccvMd0OcgDmgsJQfVE1N63wE67qLBHm3Pl/oxV9sffNEINhIqeC2I1HoTzaVHBUXjH46XdOAEx1z3BtGNdATXtOEjl0kRr81mXILQ/hb0EnM7NUBktz7qv1E+E4xu4gdNc1diWU2fZdDp4X62+1Ob2/mEXUEGG2TlMfhKe/smAqWkawLuWua/PZS7Uin0nnP+yOihNP23p737S5CTzMG2Lvit3SqibSDzkX+mK9wqIYRd4/n7p14q6Q8wZEMioJKR5AvNQcPfRbQGThoCpWV2o1vswQ49wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09/Zr3HcMbKJi3WEcJwS/4U3ngYa31rqpRb+YWnTl38=;
 b=YSqCaoZLE18DsXu123MiokCYYAotvwZoJ1mAbJuI8Skx9OgPGckmvGk3deBSxeO3mDzfZ/dWSimACO+MCsx6U+GrkHfXW28CjpQxGpbrDu9l2iXbh7ly8hJRDEGPx5C9ake9dzqzBVza97RWUsM2Eacb0uNUk159Yf8iJKLmZNWR2MgIy3m/7JI4V8qOp6oIdE5vaE9+vo6M2OtfqDY1zx1Izs16yLdSg47ugD+gSBpdfQcvxHYuQse9qB8eGDGcvZkBBPxCr/QkZQByYaM2kWnni4UIlFV3VfcUKtJKeym4NfGOw7PSrsDYeTIJmdtb2soY6JwUfWxEBxDGc3kPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09/Zr3HcMbKJi3WEcJwS/4U3ngYa31rqpRb+YWnTl38=;
 b=v+LOTurQpCWmFQBxddyL7wOA9O5YgtUmuiv+RuaNj7BsQtaOH1jn9Sg1GL3cVki+4+feOc5Vd4p/hCIL5/7obvB78bPUQg726qAFW2px9mgV2bl5wPp9CzsSPrKpICkihQ6HMiBzE2Y1+LbsM+VNBcQt5LPpjiTkb2clQjg9H1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 13 Sep
 2023 17:24:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 17:24:12 +0000
Message-ID: <9867e17c-decb-a29a-cf87-c4018bd89cbe@amd.com>
Date: Wed, 13 Sep 2023 13:24:08 -0400
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
X-ClientProxiedBy: YQBPR0101CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c8333b-cd69-40e9-ab3c-08dbb47e3efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RleVFU8kuRxxBUwnakjll7qbBT9ZUNE6e3YY+v/mpgBqNlTXgVD5o7oZ4CBmpIXDpsokWBoBOXVc64N/RCzFJHHErY/iM6lV8daCGFea7k/eVgi4DeRMqBQef0cDKswC5R8a+izctBiZzwsRSTKpr9HuXm23TojAVTbURMQ04Ur8buKczm59bo0jZD7BjKaxzgwz7Hxn+ZN6MMau5vgaS/UZWIj9UWtMrjGdK2vAJTHeNHypxYAv3qkmD7FA37Dl4zFRaCIP/3VlRGhhEOjDV3HXZywL3ryKtfAIetEP27Xmp4cHMP3KLVEXdjTkYNz8qtgDqRUPjk3X1p/t0IC33S9quRZZ1JRempQsrTK2P/syubwXs5RCi+IZQwkUwdk/KCVez2D8jPtYbR65ZfHrguMsF5vdT0oqF+3Ve8AP7NKpcmcYvR/jMxpR2qMwV9a/aDP2q8l4sny17SxlyRvZApvb18w+AB5VibinV2Vjn2f23nE21y9kfp2Y5rTAyTHqBRuYyxhE31gAPW/2nMQQsVXzrgZL0w781jq5GOMeMl9FGBXT9m5a6bozUnxX5uFD01rxbISqeQR8Qp2wreUnrnf0l/b+u3ebJ/cMVduqPv34P6oo/IiJ5Esq3piJzN58VcGi9gVd+SYEf+IKdEFs6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(36756003)(15650500001)(2906002)(66899024)(31696002)(8936002)(316002)(41300700001)(8676002)(4326008)(5660300002)(6666004)(31686004)(478600001)(26005)(2616005)(53546011)(6486002)(38100700002)(6512007)(6506007)(66476007)(83380400001)(66946007)(110136005)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNFVmMreDlxc0phYytSYzJ4cU8rN3dzL1FkM3diUXdvdTZVeU03QnIyd3NQ?=
 =?utf-8?B?bnZkNEdGbTlsSm9lWi8yeXFGemJHQVNPZUN0d3hDVjRwOTJDeXFjU0FYYURV?=
 =?utf-8?B?TG03eVcxeWV5RXB4c1hlbjB6eHArOUliSDQzN0IwY2N5ZW9SajZKNk1idkpD?=
 =?utf-8?B?QWJYL01IaE9QYzNnaHlLWm1qbWFKTTBxMjJVdGZOa3ArZGs0TjFCS3VUajh6?=
 =?utf-8?B?dmRDRmN1WnVnRWJpajkyZWRMR01nUTEwcS9Gb1ZJSThhb1REMjloYlhxcTRM?=
 =?utf-8?B?YkFUSnp2czMrMDlzNkcrb2pHaXRGUXRzaDh1bGptZUVaMjM1MTJlckxZeTJm?=
 =?utf-8?B?a2kvYWFSSWxtZytsNTJvOTJkWVBzaW9GQ2lOVVFIN0FGNXQ5aWcva1VDZ08r?=
 =?utf-8?B?SzBMQW1iZDJnZU1JRzVsNXVqMXpVYndaV1ZDVGJjbno2N00yUi9WU3VhWkZF?=
 =?utf-8?B?TnZRa0tiZU9DaHNDZFBidUFEWWFvSzdIMlk5dlk4WXcyMVBQY0hwR1c5WFp2?=
 =?utf-8?B?QkZ4TnFtMEEzM1FsL0tHOWdOM1hSVUlJOXhVS3ZMaldyZkptZUJmd1JtVGNz?=
 =?utf-8?B?ZU9iLzBySXkrQXN4eTFGL1dNRUlhSUVOTjZXcy9sVnArLzRvT2dXUVhNL25E?=
 =?utf-8?B?WHd2NUxsZlNYTk1XaGpORTlBVGlzLzdBQ1dhMGhmWWZxNmg5Zk9tN0lkc1Br?=
 =?utf-8?B?UzFrMGdWYkw2bVZNTlJ3T1hBWmhrbHZRclNsYmRXc0d5V2dackFhSVRPYTR0?=
 =?utf-8?B?Sm04V1hrRHE2ZWNiajJ3dGxFeTJtaDMvZUVzaFNmWkptV0VxNG9pRWVZOEtU?=
 =?utf-8?B?M3NYdjZzTkJXQmFxdStXRVdJLzZtOERoSUx4d3dXRFhMWi95MnpkTmVnd0hO?=
 =?utf-8?B?R0JocEtrRDg1WitRd1lBRzdLWWJWeFk2MXE4Z2l0a2N2Vklrd21JYUdJTS8w?=
 =?utf-8?B?L0ZHdUNqV1VDaktZbWdjS1dtQnd4bWdzU0U3LzBzZ042YWRJN2Q5cTM5TVl6?=
 =?utf-8?B?dEw1aXEwWWd5R1NiYWxON2pRK1ZwWUo3ditRWFF5RWIxa01VbXBrdEE2WTM4?=
 =?utf-8?B?dmJJMlU0ZW5ISnlQWlhyQVhSTVRlMkNrY3RBZ08rYVpQR0haTnZOU1lPYmpa?=
 =?utf-8?B?QmVpMnlQMzNJN0dNRy9IOEkrbjFndm5tall2Qkkyc0ZOSS9HRXh0WWNuWUZX?=
 =?utf-8?B?MXkxS1BVeldxcmlBK291U0tZM1JKbnREQ1dFeXI2bEs4T09GajlCcE9BcmFU?=
 =?utf-8?B?SWRUYzAraGhkanNwalUwRHp2REtOUVZrMitYays3WSt3aVZHNDNDWTVJWXNO?=
 =?utf-8?B?Rm0xd2lYclVrSDNNc2VoT3Nia1RES2tvNzdYTmczZkNzNmQxdDJTQ2pZZmpD?=
 =?utf-8?B?ckpsMm9vczg5ODRwVTBITGtvM1lGaHVwUGF6L1R4U3lWY2RIYXRuaXhNeE9s?=
 =?utf-8?B?RmJwN09MRkIwQ1JzanFBaXdVa0Jvemdna1BFQXlXdXllV0ZqWVFlOXpIRWYw?=
 =?utf-8?B?SVQyVWhEbG5YNGZsK1BIOTFEZjdXaXBUK1h1RERnUlZncVo3UzBEem45c1hK?=
 =?utf-8?B?ZzZSemprMnY1TWZ4QUdZQ2IwQ3ovOHk1SVRnci8xdTljK3JGK0RFdUI4K1FO?=
 =?utf-8?B?d3J2REMxeEc5N1hLbTlVT21vZ0NidDNyTHpMVEF2NjFWajNVZEVhT3BJeFFG?=
 =?utf-8?B?SkRoamM1MklrVHZQckJmQis4c0MrSm5XQVFBQ1FWemsrQlh0MlBBREFzZWor?=
 =?utf-8?B?dWZ6THZ2YlhZY0IvT3BvcG1xUjRqc3NUaFR5VlVDZWh0KzlXVzhwT3Zzd1pF?=
 =?utf-8?B?d2NOMFliaGkwbTdaVkQ1NG4rNURBQjY2TXBvZGtoemdOeG9zNFFWK1o0UHF5?=
 =?utf-8?B?Q0s5S0ZrNU11c2FBZms4NGJxOTFtc25FNWpiS2F6NU1uakJLOExFSlVkQjJC?=
 =?utf-8?B?eEJXcjgrMURYNHBGNWRqQlFxWk9acGREZjlBWUFQcHNSbW5IaEpqajkyOVVx?=
 =?utf-8?B?UGhwVnYrNUZ2enVGVHQ5UStvNEprcVVCTmswN2VlMHMvcG5oUnl3UEl3TXVl?=
 =?utf-8?B?MGRmdDVxc0VNUm15cCtBL3Nna3lsQStpd29YSndRMEZJNE9BTG12UlFEalFt?=
 =?utf-8?Q?GFZNtH6yd2I8eOENzjdCKy/DQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8333b-cd69-40e9-ab3c-08dbb47e3efd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:24:12.0245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPSPjRjB4R8y7qLCrgiWMa68r7X1a/Cjna9cmyNnwsR2nPGHhsCqXKVm1UEcjlxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
    <p>Yes, this will not affect existing mapping.</p>
    <p>For example set_attr 128MB range, split to 2 pranges at 64MB
      boundary, added to update_list, then the first prange svm validate
      and map returns error -EAGAIN because NUMA balancing, with
      prange-&gt;is_error_flag set, the second prange-&gt;is_error_flag
      is not set. Then Thunk retry set_attr,the first prange added to
      update_list, but the second prange is not added to update_list,
      with xnack off, the second prange is not mapped to GPUs, and
      generate GPU page fault later.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <br>
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
