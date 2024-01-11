Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5B6C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 21:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921FB10E0D6;
	Thu, 11 Jan 2024 21:36:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13F910E0D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 21:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSAjgKmBIqHxGTFAvfpN+Uglp21o+17HSzDUWFykonTlmDG44vyAumE+wtBJ0YTu9365iG1tZjKh4ArlChwvdC9wf9b1ERQ6fnUIahqx49dJ7yPP1rhxaAyXtRsTCXriFmNxOI3GSH8SccEEdpa9TCASxPqHTPASj2odMvRtAYOMU379CVBL41HCaofVqbumjGBDNUBy35/kGzbUQVlvxCBitglXWoJtiYYMRmA3g5BNVDIaKtDFtYagPiy2lUWk82DbANKHHLYkKyGyUIFWBEoGsFyFGssH4IL7Z2weOfig6vfh0JpXM6PFPs1wI6Es0OsEgLkDBV8ewQ+R3XMEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNYwBoju9cSYTxYUE+N6NasuXRmbuyIhAl3lMQn34FY=;
 b=lnxGz9PkMQrOpoB39KubGbsKWlbGwPVfNOUXkNHxlh1YiEOJXm4wR0q2Hub5u9Ur7Xyb7TfYE0iQaO99r+oKWv7CN5BOzAYfvjEnKN0B7JKYImNEs51tUncRq+V5LTs+zq1QgmcFNqR679wknz8ymHqdi2sFFChHWxjCRw9kS17SsBfWSgSGJiymYDjp6224mn8N/caw9GAZtcTuvQ5+RMDG54Zrb3WBlZo/GVaPS1JzsRYp/QMfpVV8c7tlKajF0ySc9UTt4nTg8OVoZnSGsn3mjJNnM4fCOpV4tmsp4lK7f+1IV/2B46wRYgy52B/yg2A9I5eJUOPVWWFeNjGXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNYwBoju9cSYTxYUE+N6NasuXRmbuyIhAl3lMQn34FY=;
 b=aysMZ1ueisVJBtyA3/nwWAY5Z6/SzE/Y+uGuA1MbqdzO2F8HDX2kzFIn4rwPPaP9w60beHp6tClITyY4wJcKI8IgUZfmqdmagLxQgJv0Q7G+fDXFUZpRc672rwd5ZJ7M2RN1j3grAbuWTev3NWDzbr1/tTPvRGv/HB6ZQU793Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Thu, 11 Jan
 2024 21:36:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 21:36:49 +0000
Message-ID: <170abd38-1622-8030-0029-8ae8520e07e9@amd.com>
Date: Thu, 11 Jan 2024 16:36:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240110220143.25973-1-Philip.Yang@amd.com>
 <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
 <f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 361fddfc-0696-43e1-c516-08dc12ed6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+BeCn6KQY4pDMxA/60gjLDHLbmo3pjKlZUdurtzxzoBXTgmRfbVavakKlGCFas+rcfPfiqMUZSMD9p7fXZcrhMiLDMbdBbyb2ABXTjJgpnGMhtWCmkiznRht/yYxhoLXohLtB5m0Es3sSeuOH44m8aCAJBZZDQANRNKqReFJDoJS9/+kosLJS79CcVZIms2Sie159J0/jDOJptY7b0JphUVSQpu7vX9QoGtZ86AswGVZpctMWDDkP8OI3v97mgfIKGQw5fa5NYBMOSA8hNJut8sedemPxubGkgDipl9gyA1KeDsWaxLZW485SsQe/bpSUIM6QZugsO5zMdwiMZj5vEepNjVqV8kxQZ2vhjHuvK47wTg5d1nJ0Ru6qAjaJwXDI9Bx4SyatQV5xRayobPi6ub1dlLM+hbqEt6eV0JAdopILG8yZWmeNJk4Ylj2fuBP3ieBo67e5OQ8xZXTd1LvzmZ3QCoRigKCbNG3l0alNPhNMdDd9fe4taP6c0lRMW410wLoP35qm2tOQh373RRzb6Iec62Yhah5xHxQBGsvURe39Oz8wlprSdqtRCTCjTJP4vNG9DUAwV9TAWzjd/gg1O34HZL+Jd5eDskdfH5oqJmkZv6/gmPLNh69yHDgBAXFTsCKFXd5P4+ZQRBR7aaMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(36756003)(53546011)(2616005)(478600001)(66556008)(38100700002)(66476007)(8936002)(8676002)(26005)(6506007)(316002)(110136005)(5660300002)(6666004)(6486002)(41300700001)(66946007)(2906002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENKKzJRN215L1liaHhnT01RbDhNcWJ4ZHU0Rnk4a3RFUlFWR09sc1FFU0pW?=
 =?utf-8?B?VFpHMVdOK28xZ1RSN0RjQVFzM1M1UDJ6aWVYRldSNDVmSDJzTFB1bWZzM2RO?=
 =?utf-8?B?c0F5RWVlM3UzN0JvOHdtdUl2R2YrU0NvZERudTUyMytpdVJXUFl1cTF5Tnp3?=
 =?utf-8?B?a0xKZFkvZnBza3p3aTJ0b1QvU1k1RjV3bFlvY3o3cDRWY05nR3FmWlM0N0l6?=
 =?utf-8?B?Q3BBVlo5c2g5VkY1QXZqdGxKSTNWTXJZWE11aEMyclM5QzdGcnZ5b0NOTEtC?=
 =?utf-8?B?NnBHRy9hVjNFWmxtWldYNmRJU09SSnRqcFpkT2ZJazhGWGU5bDFpbEJzLzZr?=
 =?utf-8?B?U1lROU9KMmhYalRYNU9JTnk5UHRxclUyeEZzOS9acDVxUEticTdNMlQ1SjQ2?=
 =?utf-8?B?Ny85TEJhUmNjbmRyaDlkT3BSUFg5ZlgrQ3pUUVAxQ2h1SDhtZHJIb3dxUTJ4?=
 =?utf-8?B?VkJGdHBPTlMzS0JUU0c4ZDVlbEgxU3p1Si9rUGNlbUV3LytDRjM0dDdSZ3p2?=
 =?utf-8?B?SEVad01qZDkwUTNiYVFQYk5pQ2F0OVdyT0lnSG94QUZOa0RSQTBBSFR4NFZz?=
 =?utf-8?B?bkpIOExpM0hrVlpTZXFzR2x4ZjBWaW5nTjZvV0c0VWt5dnlDZzdYY3ZxQ1VP?=
 =?utf-8?B?VEhyOG1rMkp5bG84MDVYaklXajBzTTQ1RkFEYW1SMzZTL3Z4RmVXYUUvSWpC?=
 =?utf-8?B?d3Q3REQ5aDRlYVpKSlFsK3lTRm9qSkxlTlV5R2lUbnpHODFOb01WdUg0ZEIy?=
 =?utf-8?B?NG9ESTRFeUdXYUJUOFV2WWdGVkZpdXhPZGQ1RjFrRjU4dTI3Slk1bi9zOGVE?=
 =?utf-8?B?cnh6eWtVYmtwRGwxaXVrTXJLVUExdXZxR3RpTHNFeDlDU3FxSWVhbDBlRG9G?=
 =?utf-8?B?RUVWMkd6UHZQckVldldIZ0grYnM4V1ZxUkRuakVUdHpXL2l3MXRGWVpnMXZJ?=
 =?utf-8?B?bmIrMUUzenIrRjdOVkU1bUVoZ3FNZjBjdFlNL05NYmtpN1dYKzBGdjJ0eUJz?=
 =?utf-8?B?QTBSTXZvVWtORnNxQ3pndGtpSFdQaW1TWE9FeThBUE5tS0NmNTYweTM1amVh?=
 =?utf-8?B?OG5lZCtEd1VnLzZLSDRPZldOWDIyT1JEeUdIQUZ1TkZVaElTR2p6T3FHOVJ2?=
 =?utf-8?B?MjJIb25qSmEyREhZR3F5TVhmSnRiZ0NVRXVXQkx2dnlEbXQ3ZTN4ZC9GUVV3?=
 =?utf-8?B?cjg2eWRNMDE2QXhqVXFOdU9uSTVDTnlGVUJyRTZJbTZ3VklTMkhrNVZJVlVh?=
 =?utf-8?B?WFFzL2kyZ0lheW5UeVBtT3VlUDVDR2EyNnpsL1ZmWHB5Vis3T3NRR0wvTHR5?=
 =?utf-8?B?eU9ONUU1c2plUTBCOEF4RU9Wc1UveXhtTFJtQUJXQ1FTbHBkeWk3U1psV1hk?=
 =?utf-8?B?SG1hUHBjd3k1QUQzR216VFF6YlAvbzRXbnFMYi8vSE82TXVJdVY4VVNZVWRt?=
 =?utf-8?B?dVQ2UzZHYjVwSzlKMWkyZlF3WFVIWWZKQUEyRFZZejlVaExYbUZ4RGJyc0VR?=
 =?utf-8?B?ZUxoUG1yRGVMT0Y1RWxUY1dVbkhBTjUvMEoyY0VLclZ3QjIzajlnZ0NvQVo3?=
 =?utf-8?B?RlB0RDk2S2ZwZVEwQ21YcDhRUExRS3ZkU1lIMEdEdVlMNUdUOTJZOXIwcytz?=
 =?utf-8?B?WUpWZ2E4eXRqTDJUb1djMzlLSkZaWGVSbExxMEU1TWNsSnVoSzJVL3pYQnEy?=
 =?utf-8?B?R1VWOUZNeGVwSUVQMWVUeDMxYUt1eENFcDlwdFkwQkxoL01FSVZrVjY1QTB4?=
 =?utf-8?B?NEtJaUs0WDNqaGVpL1NkbXZKU0ZMZ3JOMEZkUmx0WFdUN1paM2x5T3hWUnU3?=
 =?utf-8?B?YXJYeU1pQ0hNaHdPKzV0QmVrSndNd1ArNDZsZ1lISFZKdmxxTVhxOU1QSmMz?=
 =?utf-8?B?UXhONWRpQXdyblhyWmE0L1JvaXlaUzNzeHJFZVV1OE1lb0NNdFUyMlE2MUN4?=
 =?utf-8?B?NzYxTlF5ZDk2M1FGaEVhT3g2dEk1cjFUZmN1eWkxYWZYTS9KTXo1aGdib0h4?=
 =?utf-8?B?K2NNZGovSGRZRjdOSUlyQW8yNkdaQ2lML3dIakJ3Z2h4ZC9lMzJpcVZxOFBC?=
 =?utf-8?B?bHF6NnlDSnI3MkpxQnJFbjAyaHVpR2l1U2RSaTdoK0JDd2xqN2tpTWVCTGZz?=
 =?utf-8?Q?U5e17VYFGussaFR7xIxVRgzGQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361fddfc-0696-43e1-c516-08dc12ed6b34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 21:36:49.6328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwg1zTq45jNDGwq+Gj5M25tP2oCDMWiNwUnSI34w8P+GE1SK3cDRjU3PGe68sQNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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
    <div class="moz-cite-prefix">On 2024-01-11 12:37, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com">
      <br>
      On 1/11/2024 10:54 AM, Felix Kuehling wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 2024-01-10 17:01, Philip Yang wrote:
        <br>
        <blockquote type="cite">While svm range partial migrating to
          system memory, clear dma_addr vram
          <br>
          domain flag, otherwise the future split will get incorrect
          vram_pages
          <br>
          and actual loc.
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
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20
          +++++++++++++++++++-
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 24
          ++++++++++++++----------
          <br>
          &nbsp; 2 files changed, 33 insertions(+), 11 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          index f856901055d3..dae05f70257b 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          @@ -563,18 +563,30 @@ svm_migrate_copy_to_ram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct migrate_vma *migrate, struct dma_fence
          **mfence,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *scratch, uint64_t npages)
          <br>
          &nbsp; {
          <br>
          +&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(prange-&gt;svms,
          struct kfd_process, svms);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;
          <br>
          +&nbsp;&nbsp;&nbsp; dma_addr_t *dma_addr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *src;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *dst;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *dpage;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i = 0, j;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;
          <br>
          +&nbsp;&nbsp;&nbsp; s32 gpuidx;
          <br>
          +&nbsp;&nbsp;&nbsp; u64 offset;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms,
          prange-&gt;start,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;last);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; addr = prange-&gt;start &lt;&lt; PAGE_SHIFT;
          <br>
        </blockquote>
        <br>
        Is this another bug fix for partial migration? If so, it may be
        worth making that a separate patch.
        <br>
        <br>
      </blockquote>
      Seems it is also a bug when prange is across multiple vma. With
      partial migration it become obvious.
      <br>
    </blockquote>
    yes<br>
    <blockquote type="cite" cite="mid:f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com">
      <blockquote type="cite">
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp; gpuidx =
          kfd_process_gpuidx_from_gpuid(p, prange-&gt;actual_loc);
          <br>
          +&nbsp;&nbsp;&nbsp; if (gpuidx &lt; 0) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;no GPU id 0x%x found\n&quot;,
          prange-&gt;actual_loc);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; addr = migrate-&gt;start;
          <br>
          +&nbsp;&nbsp;&nbsp; offset = (addr &gt;&gt; PAGE_SHIFT) - prange-&gt;start;
          <br>
          +&nbsp;&nbsp;&nbsp; dma_addr = prange-&gt;dma_addr[gpuidx];
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src = (uint64_t *)(scratch + npages);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst = scratch;
          <br>
          @@ -623,6 +635,12 @@ svm_migrate_copy_to_ram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_oom;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear VRAM flag when page is migrated to ram, to
          count vram
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pages correctly when spliting the range.
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_addr &amp;&amp; (dma_addr[offset + i] &amp;
          SVM_RANGE_VRAM_DOMAIN))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[offset + i] = 0;
          <br>
          +
          <br>
        </blockquote>
        <br>
      </blockquote>
      When come here we already know the page has been moved to system
      ram, do we still need check
      <br>
      <br>
      dma_addr[offset + i] &amp; SVM_RANGE_VRAM_DOMAIN)
      <br>
      <br>
      You want to set dma_addr[offset + i] = 0 anyway.
      <br>
    </blockquote>
    I agree, dma_addr NULL and flag check is for safe purpose in case we
    may change dma_addr update after migration or prefetch later.<br>
    <blockquote type="cite" cite="mid:f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com">
      <br>
      <br>
      <blockquote type="cite">I'm not a big fan of messing with the DMA
        arrays here, but I don't have a good alternative. I think what
        bothers me is, how the DMA address array and handling of vram
        page count is now spread out across so many places. It feels
        fragile.
        <br>
        <br>
        Maybe it would be good to add a helper in kfd_svm.c:
        svm_get_dma_addr_for_page_count(prange, offset). That way you
        can keep the choice of gpuid and offset calculation in one place
        in kfd_svm.c, close to svm_range_copy_array.
        <br>
        <br>
        Other than that, the patch looks good to me.
        <br>
      </blockquote>
      <br>
      svm_migrate_copy_to_ram already has scratch which save dma
      addresses of destination pages. Maybe we can check it after
      svm_migrate_copy_to_ram, before svm_range_dma_unmap_dev, that
      looks better.
      <br>
    </blockquote>
    <p>I prefer to do it while handling migrate pages, no add a new
      separate page loop. <br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:f7fdea7a-27f2-00a9-2c7d-1b39e6d2821b@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        &nbsp; Felix
        <br>
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma
          mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] &gt;&gt; PAGE_SHIFT,
          page_to_pfn(dpage));
          <br>
          &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          index cc24f30f88fb..35ee9e648cca 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct
          svm_range_list *svms, uint64_t start,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = 0;
          <br>
          -&nbsp;&nbsp;&nbsp; prange-&gt;vram_pages = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
          <br>
          &nbsp; @@ -980,9 +979,14 @@ svm_range_split_pages(struct svm_range
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
          &nbsp; @@ -1002,13 +1006,14 @@ svm_range_split_nodes(struct
          svm_range *new, struct svm_range *old,
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
          &nbsp; @@ -1058,7 +1063,6 @@ svm_range_split_adjust(struct
          svm_range *new, struct svm_range *old,
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
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access,
          old-&gt;bitmap_access, MAX_GPU_INSTANCE);
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
