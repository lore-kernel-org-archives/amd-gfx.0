Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE8E784AC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 13:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830A110E2BD;
	Mon,  2 Oct 2023 13:51:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC34B10E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 13:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuD7N0nHTcyL9tTKlxZ3dzBjUT7xyZ33zdpWTakzCMbZkCpvFXfyYkZmnyvsLJGxLNv4o8AVdGrAYEDt8szr9jwcrs4PBayb69+2kACrVUuG3Bpl+a992vV3/s6j+9Uog3jxRmDx8UmyNtdJc57Zr/OsoopOe7uaMUwby9ELNAYsEH+aDw2uc0qyK5kedvpqL4bxR3zH8HuH2qL9SDE5Y1CTqQVYmlBfFVhy8slZnRC6Yq/lOlHLE9tm81Qkd0fSgFf4qx4EyM7Q51XGlNfJ301vmJ5AO5rqKlylLHjhWMVNSrSrdRfX5V3+Vj+GpnYS4yNkXOVopcm6Tx+AsFrLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE/dj6QeV7iTiqiZNMyjXvb8NbIm5wD5DNfvvQO8n3c=;
 b=irxhA9rp7shVZbX7luNaOUCg5+RIpJwXFI/pgMXJ0Z1okDK1wQ64WvKkIOMaLSICGoKYXEe2+mXEj1kN1jPHROjPUrjXJGFhAGVlKAjZU2J0MSGiKIGuQnEpsDo7JPWAXrIDzPYw6bf7+XcVZ7atsIqk0Dq9scwz9X0S8MO+yDSwhgh6rxf5hSUVVjPmc+EU5vFtJ83Kg0z0/KayOsUU4JV8t6iEemArjs2bGQeBHuI/uoZvptORIswj8VoYX87YRjYwSH3CwYduu5zmxX4XEZR+1VXrai+u6XPy79KZuxmeuQxhLbd79RJGr28Nt8W9vDIhPtHYOxeuzylXGl/xzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE/dj6QeV7iTiqiZNMyjXvb8NbIm5wD5DNfvvQO8n3c=;
 b=hN10MNNFtkdn5OF5ZeEH6RYKr3G1qs2aAjUXtxetApKvGuPLzkrqhOWxdGewpsTANZCe0d3dbCfllR7q0thF6+bM2j7mphiD9PyZWaINmQUhrHq7719sZG0a8qOviX06UtPj1dexVuf0sjXG3vtmq0SQHoen8LACEawJT1CiNbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 13:51:37 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 13:51:37 +0000
Message-ID: <dcf1193e-a920-8da0-0215-0cb774105c4e@amd.com>
Date: Mon, 2 Oct 2023 09:51:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: ratelimited override pte flags messages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230928222212.17006-1-Philip.Yang@amd.com>
 <82d52efe-0daa-e086-dabf-df19d4e95dc3@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <82d52efe-0daa-e086-dabf-df19d4e95dc3@gmail.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::47) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: dd81b375-02ee-4417-7ff1-08dbc34eb26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeMjKnFagGVGAVZxYtcJUMc6whaHRTDnPNeVGp2MDw7dGQp7qqeQMAf9j1ytYyJEodbEXwPtLanhpxhlVYaNR2soPxtSOyuSeaEi+mITkfM620f+wtvo1ZAo5YHWA6r8p8TbJkJhvRgu3HdAkXrLr9DlnMkrBHM1k+H067Cps0laauTheYSFA4qGtvGnsqdW+BQd4H4aZdLL3avC3DwK5fHBmLBQWjDHOXR/TM9vHS8ifdKuZwFFN5WVgUjJnsUzcoCI8/Uv7x8mn3nhUtj+h4MtZFqjsnvb7M/on+LZLriYNOEFWbjBjoCxxjZf4rEJG/GQBuXVM6N3zl49qy0J82mG5Ivf8ep++SthjmXV+5P5QrdnajPXbVIXJgXUw4IcW4NUWh2ZAcTDxgkvwuA4M+110Du9IkjYR22mC4MWxdk1pz42hkDDG9/MeXMN0s/2Ee4Rv3xzt9o2lWqbpiPYJ7NDVXLZgwfLZPeBdnv4SVNErBMt+bLHlhGXw89fKcsTKb2cMcuZVCqkVxVEqcQu2doN3ORQTHHmovlvN7zs79AHvSTtkPRfa++EVbAcsl8nsVD5/cXdFlApbj+fz2POEBjnqFAaPh6QcuypFValURJOql9ZVGZDHxpR5JF+qrfAC1fqlhDcRh/cLFTLpCR5gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(2906002)(15650500001)(5660300002)(8936002)(4326008)(8676002)(41300700001)(316002)(26005)(66946007)(66556008)(110136005)(66476007)(478600001)(6486002)(53546011)(6512007)(6666004)(2616005)(66574015)(83380400001)(6506007)(36756003)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVqSzR0RUVhS2ZsUUY0U1cyZEQvL1FDaGFqYW5vSVkrM3hENThjZDlOa2hT?=
 =?utf-8?B?R2h4RHN2ZXBGUDNTQmpkTmU0c2tvOUN2UWJod1RYd1p5VEdJOUJEOGIvQ1BV?=
 =?utf-8?B?VnQyR0IzRE5TcHhZNEtUR0hOcTZEay96eWNBaThwTko3eGZwcFExZE5vQThn?=
 =?utf-8?B?bWFiNzg5TDB1a0VScitZZy8rN050SDMwNWVWRWgrZUFiTXhQYTF2WFRXM2My?=
 =?utf-8?B?Z0pVNFR1RUFyQmlqcnZoSi9NNE8rc0pYN3lyKzdoNGgxRFNDbmoxUEYyaHQw?=
 =?utf-8?B?aXJJVXhRUk9MMlE0ajFCQXhxREpvdWhOT214NHJSVFNuMDJ0bm1ybklFSHhS?=
 =?utf-8?B?WmFtZDdHZ0d0UzhqSjlWRGU2VmhrdThtbWJibHVhWU1qVytJcUk5WTNFZm1m?=
 =?utf-8?B?NHAvQ0RPWW1QK2UxMVNrTFZ1VjFMRjhlV3hybXFCc2tPNnNXWkwrLzBQblhN?=
 =?utf-8?B?SG1vblB6dEpYOFNUWDNvZ0llSEJPQTVRQnVweTBaSnF2eTBHalpHMmJhZ3R0?=
 =?utf-8?B?bVlFbU9VcDhGSkpOL0JaWTVyUnlSQXA1cERBaGIvVWkrTGU4UzVQSlJ6dlFZ?=
 =?utf-8?B?UWZRZVhZVzdWNmMyRkdtaDZ3dm16YVV6VUNHdG9rYWlsTHdUYzZyQ2s3UUVI?=
 =?utf-8?B?S3BlWW1pd2JEbUlCVlJKc0ZLT1YvNkVYU0tLcTNZK3VwQlUzakxXbFBwVmFm?=
 =?utf-8?B?RUltUktVMGxtQ3pBVDUxd1l1cHpuempzNGNRbHVXQ0phSEk1bW5weWZyS0Vo?=
 =?utf-8?B?UC9UdnlQckxBV1BRUXZHMTRFZVI4Nmk1bFNYeEp1Ry9rY3JhVkw5anYzakpE?=
 =?utf-8?B?ZitST0lUY0pOZy9aY2ZsTVFLd2R5SC9NaGl3cFgyenkrUHltNHVqRDRWUnYz?=
 =?utf-8?B?YXovY2JWT3dxVVNGcUJUZzB5SjJOS1lJMWRRUTZWSFhmMG1TeURIWWExMi82?=
 =?utf-8?B?bVRjYkNXWUlqdjMvdjRMOElQdkZDSllpeDFjZ3RmVUJYMy8vQ0ppdWd0cVpV?=
 =?utf-8?B?TlI1WmtLcVBOcDVFK2VmSUFFLytYeE0rSTZza3ZkNVBBbzA1dXlBK2RxblhU?=
 =?utf-8?B?T1ExMmVoRXNocVNFbDJ2S1pMTGQ1WU9WQ010Yi8remNHR2lqczdkSmthbGxm?=
 =?utf-8?B?ektpNEdYc2FEdEJ3dFcwR0p4ZTByZlN3OVFUMGtMTWhhVnRzQUVrSGN3Nlpk?=
 =?utf-8?B?d0hnOFVJQkdBMFk4MXRTRlpuVG56aGtZcG90YnY2bVI5REFOZnBaa25tNjlM?=
 =?utf-8?B?ZDdpT1BNbGg4bm80QzVSUzRDT0FZZDMyVm5KMUpqZVdDOFZZODRJY2tlVVpN?=
 =?utf-8?B?ei95N3hvNmpBSXoxVmlocXJTUGpWOW9wL3dWZytDWDBjbUsvNitkby9TZmpS?=
 =?utf-8?B?ckxEd1ErVDhzRU1ES0ZoZ0Zpc0MzZW9BNG5HdHNjYkIrTUg4NnhjWmFyZzlH?=
 =?utf-8?B?LytSejVOV3BPQmprcW1ISmxiSkRnQVY0U0VwaDQycFlmVDc4QXA1WlNxQzcw?=
 =?utf-8?B?b3RFNXA2NStzRmdOL2NLWmJqNllpLzNMSHNFTHowUW94U0ZtUEhEV2pUUCto?=
 =?utf-8?B?bDdBbVc5dXBRLzRGR0tiZ2xNWHJpdkMvdE9pYXMwVStmcnVMQk1UKzJYaGdS?=
 =?utf-8?B?S1hXMGV6ODdNaUdIRVJMU21KUU5IZ3huTXFhSGY2WkZzUzMzSUpWK29iaEtY?=
 =?utf-8?B?eDBOQk1QRUpLMVVFTDJWOW5mZXAwMUFKQlZPRExkTW1uTUtCV0RGTDB6TG5a?=
 =?utf-8?B?RGxWdXE2aTNWZnpud3JPMklrbVEzTytJQUpUNjZDVm9LZDZUS1BhblhVOTF0?=
 =?utf-8?B?cG1nQmxEUzhkbG9EbjUyaXJ1WFcybE94Uk1EYVhYb1haQm80ajMwUGFNNzlP?=
 =?utf-8?B?dlJDUVJGQUgyM1l2blIvSTFtM0txY25QUTkyRHBoS25pcFhyeGdVL0h4bGM2?=
 =?utf-8?B?Y01BL3hUSk52bDV6cHJILyt3MkNGWUdyNWhNN0srTUxiNWZPanlLWUxGRVVZ?=
 =?utf-8?B?SDl1MmlLbkdxN2plR1RPN2lNSUVRdVhLVEhlbFg2RXY5K0pMOXdqcFo1UGth?=
 =?utf-8?B?aVRmbFhHTCtOVE5EOFh6dzI3RHdMUmpHOEtOMjV2NDZCeEJEZEVFMmJRazk5?=
 =?utf-8?Q?CA08=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd81b375-02ee-4417-7ff1-08dbc34eb26a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:51:37.2611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg4h0pDhfVYiaCeQFxe0kIk6N08AjwybaBIc2kR2XbmRWyA27Gozkz+SoQ+6VodB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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
    <div class="moz-cite-prefix">On 2023-10-02 06:24, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:82d52efe-0daa-e086-dabf-df19d4e95dc3@gmail.com">Am
      29.09.23 um 00:22 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Use ratelimited version of dev_dbg to
        avoid flooding dmesg log. No
        <br>
        functional change.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 16
        ++++++++--------
        <br>
        &nbsp; 2 files changed, 9 insertions(+), 9 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        index 96d601e209b8..6d2878684287 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        @@ -848,7 +848,7 @@ static void
        amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params
        *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_override_vm_pte_flags(adev,
        params-&gt;vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, &amp;flags);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;override_vm_pte_flags skipped:
        non-contiguous\n&quot;);
        <br>
      </blockquote>
      <br>
      I don't see any value in this in the first place. We should
      probably drop the message altogether.
      <br>
    </blockquote>
    ok, I will remove this line then push, thanks.<br>
    <blockquote type="cite" cite="mid:82d52efe-0daa-e086-dabf-df19d4e95dc3@gmail.com">
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
        b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
        <br>
        index 6b15677c0314..ad0d63472e17 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
        <br>
        @@ -1244,7 +1244,7 @@ static void
        gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the DMA address.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ram_is_direct_mapped) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;RAM is not direct mapped\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;RAM is not direct
        mapped\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; @@ -1253,7 +1253,7 @@ static void
        gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*flags &amp; AMDGPU_PTE_MTYPE_VG10_MASK) !=
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;MTYPE is not NC\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;MTYPE is not NC\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; @@ -1264,7 +1264,7 @@ static void
        gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.is_app_apu &amp;&amp; vm-&gt;mem_id &gt;=
        0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local_node =
        adev-&gt;gmc.mem_partitions[vm-&gt;mem_id].numa.node;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Only native mode APU is
        supported.\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;Only native mode APU
        is supported.\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; @@ -1272,12 +1272,12 @@ static void
        gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * page or NUMA nodes.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!page_is_ram(addr &gt;&gt; PAGE_SHIFT)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Page is not RAM.\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;Page is not
        RAM.\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nid = pfn_to_nid(addr &gt;&gt; PAGE_SHIFT);
        <br>
        -&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;vm-&gt;mem_id=%d, local_node=%d,
        nid=%d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;mem_id, local_node, nid);
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;vm-&gt;mem_id=%d,
        local_node=%d, nid=%d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;mem_id, local_node, nid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nid == local_node) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t old_flags = *flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int mtype_local = MTYPE_RW;
        <br>
        @@ -1289,8 +1289,8 @@ static void
        gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags = (*flags &amp; ~AMDGPU_PTE_MTYPE_VG10_MASK)
        |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_MTYPE_VG10(mtype_local);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;flags updated from %llx to
        %llx\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_flags, *flags);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot;flags updated from
        %llx to %llx\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old_flags, *flags);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; </blockquote>
      <br>
    </blockquote>
  </body>
</html>
