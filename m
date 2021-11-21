Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A1C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Nov 2021 02:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F556E436;
	Sun, 21 Nov 2021 02:13:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46686E436
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Nov 2021 02:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdOKF2uupy27uf+7k0BfUILraQz99cEn4cWo3ISnFV+rcrhzxdRqqeWoaEpkOyaEWLs10xmKhwatmxSYDK0fyI2HCDrDsXsntFXcQAgOUsRORxwxkRWcAiFG6qM/mkQ/GTYcn/qmTwiwDIRbvo7YxZ6fldr7Cj3LR2QUaUSUoM0t7u3T3tkYh8BEBlJRD/rnWu3TCkuM/on0gAbFsOt8bGzKU225iT9a4v+HfYdl0KTqzT4gvc7RjWuekM9bKFYPMY37nxBchh5r+TxftTVvHzrX59a8+ti6Rc5Tw47RZ5Ws7GthPcuet1gHS3GK36QAlSYbB0u4gboD+hXPV2lPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubu/G615kACVw96bZjm9FikgjelY6J2c+MMrzp/RPRk=;
 b=O0h3vL87H5ch0cGidAYqs5DPzAKXpCdjCWS2IlGLx7+b+mYqaVKpylFKY4ecdFGsFD5JtGUEQwB4cSGMdALIi0F/j+MZGBKFUuvlHhe5l4GqvqCv6HZy0kJDn+taapNenfRH69bVK/FV9zqDytsHztP9YzSyAlWXl+OjQ2TH00TAjzsbSYmfeZ6Rd95LNxvCAIxXqPkOaq9ezyhDt1giY8JxOyoUFFS9MLHYFUvxzEOzl2pXjKy8aOweZ5O8B4umwwzeFJPOrIFe/W/eGkk4rTLjwEdeQKTC4ZxdBwgzXIpcy/d3rZt9opeh+0NcfsvYW8m+inc+uZV9rNpeRfTEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubu/G615kACVw96bZjm9FikgjelY6J2c+MMrzp/RPRk=;
 b=aZt06WrRb3ENUwpdTp8d40vpR9QAlJm3AeUmFNC0Q9fLIAeyTW7XTWeg92drH9nY3XHRek/klo4mS+DeI3nbOA7mtbwfeKNd95wkSKEQF/bgqt97pT42nM3EtpI1XX7mj+RrnFADQ4lvAMcoL+CQd/SLIXcmJ6RlJu+ThVupmQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Sun, 21 Nov
 2021 02:13:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 02:13:24 +0000
Subject: Re: [PATCH v2] drm/amdkfd: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119202233.13486-1-Philip.Yang@amd.com>
 <2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <3d49a81d-793f-177f-606a-2c405685036e@amd.com>
Date: Sat, 20 Nov 2021 21:13:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0083.namprd02.prod.outlook.com
 (2603:10b6:208:51::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Sun, 21 Nov 2021 02:13:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e5c8e4-9721-4fef-8330-08d9ac947f7f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5152:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5152EAA7EEFB5CD35E2164EAE69E9@DM4PR12MB5152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsDBcaRGM4za/fqizLFanKMPNyFc3dMqR4Dc4BAdj106yyoNkm48GWARHtpJahzmGvc9yL+abphqgVZZKUCar4qxu7uPFoBnzCOGTkyxjMnBkyL5HtAS17O3R0T3TujJ/eX5awkO1jIz/K9r+zU9a0rIvFj9Rx1HM3XNV+UJfq+SxgoTh8jWEuaji2xpbUWJTd37XcvDVDDC2KKmoB+TayEpjLQPTnEO/baXOROU7ECEqC8TsVbo+7s4DK5fssgnNL1p0OzJJmaO0C7FGJShcIG/atSXqP5WZxMxk8Lvu7V1vzbXzpT51cnoSSc9U5YePC59IvOpFPNS4wbOr8gD993f2cqT3M0ja/sQtAvBHRW4WEx5bTr+S71z8FJvP/g2CNhCZYISOaY5wy+ond5YblNx3RTvdAWqEXKfruqgwVKbl13n/Hv9yv00do3Z33Yusv0QyFalhdGe07TEGLNsNj3tIt+4MOVDCH5+erykSryT3QdYZmEejZIv3GRm4h3FaODraTLQ4VEtJLCTxm0Y3D4qKN/bElqa9pJswGCeeyrGLar7vicRpJMza1cJ7yWjrdosxKHSArGk/1znRchAbpsbubJsz3woTWnxkxOOn5qXJmRc6hnUqA6bjbWgA2g/Cr8tCBbs9yBO/Xpkv6FrH0GFXEZZPRGyZQrcWcfaw0ahh/46YZvK1J1UeuSEBqp/oqSYNaF/lRdoNukze/rGy4bpkFqnJsc+5VoOd4wBmwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(110136005)(6486002)(66476007)(4001150100001)(4326008)(2616005)(508600001)(31696002)(16576012)(2906002)(83380400001)(316002)(956004)(66556008)(5660300002)(66946007)(186003)(53546011)(36756003)(31686004)(26005)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFV5emFhaE96YkRlcEhWWTBSMVVUQ3FuYll0TWhhSUlITVNGRmtzT0Y3QmxN?=
 =?utf-8?B?S0RyTDBYQUdVN2YzbmVJWnpZOWd2ME81SzA2R1BZakF4NnhyVG4rbnhPTUFp?=
 =?utf-8?B?TkxETXdITFRFSXBiTU5FT1Rjak4yM0ZOVlFLK3AyQkxKR044TDN1QUYzRDBN?=
 =?utf-8?B?QW5VYVVraU5HVTdIYlhlc1QwdWpSQWY3NVFZK0FBR1JwNkg3SktUdnpYMTYz?=
 =?utf-8?B?Z1p1Ukh3L0R1WXR0MVA3MzlzK3JBdW10WVJKRFVSUUVBcjE5Z0JvRDM5cHIw?=
 =?utf-8?B?NDRNeWxkc21haGRIdStoQVZpK0hIaUcwcDh3dis4Y3FXc1FycW9lUGdEaTkx?=
 =?utf-8?B?QUxoU2UvcGxSRk1oTjVJOTNBaXQrUkc0bmxOc3pWSHFXOCs0dE04bzlkdTJz?=
 =?utf-8?B?VmRMYlRmNXU1YTBNYnJwYnFPTXdXcU1zV3h0a1RQWW5BSHN1d0c4TjlpT2wx?=
 =?utf-8?B?UW5tK1gzeU5GVUgyTC9QK3NNUmJuK3l1TkxteGpseUxjQXZ2VlJRc3EzQkRN?=
 =?utf-8?B?ZXZpcFZ6cjV5Wk1oQ3puTDBCRWc5QUhVZFZWRlgxRGF4UkdZbnNvbDBENDhM?=
 =?utf-8?B?SVFUQ3dDUS9JeW5RZ3M3dlRZTUl0S3pwR0JjRXRsZ2IzL0ZORFRKaVdPQnVV?=
 =?utf-8?B?MEQ1K3ZDRTNBd0xCdzJvSVl6K0o4aWs3V3FsT1VhTkpiZXFSTzkybWVGdWw1?=
 =?utf-8?B?dTUxYnVxa3R5N2oreGxrVmVlZS82WGlSYllBTjNpRFl0dW5mZUREbU1adW52?=
 =?utf-8?B?OXhjbWI0NmdxNGYwU0hBK0VaTS83c0xUUlR5TGNVSjVFZWgraDg2c3JhREF2?=
 =?utf-8?B?U2NmTm5aSmwyVnBwNE5ROVVweXoyMWxOVTZSWTlSUFR0dVl1ZDQ5Si82VTl1?=
 =?utf-8?B?Y2VhTDdWdFFZTDRPUEc2V1hzblFsQ0lRQXJtMURlSk9wZW9nTzEzVm5FWWxl?=
 =?utf-8?B?SS9NRS9RRExZYTRYTVBjcWFoNkh1NmltUWdra1hmMmI1bzEwWEVvNjFjMnpD?=
 =?utf-8?B?Wjk3aDdUVEtqR3JvSzF6a3JtUHU4RG5rb2gxMDV1TFlGaTk1ZERBeEU4VEJX?=
 =?utf-8?B?WldpZHhoZUlndzE4M0NqSksvRWRmeVExZ24ydEhHREE0Y3pLLzVmSHBxSW9q?=
 =?utf-8?B?WXhKMVpsNU1kN2RNSDBWN0tHWk5xelMrTjVPNGpyU0hycVM0VkJORGVlcmpy?=
 =?utf-8?B?TGxUdFltSWd6RnQ5TTQ2aHVkZ1BKT1RadE04akUyVWg3aUtWcWw5NkU4Uk9O?=
 =?utf-8?B?SWVxNFJ3TVhiVzRxWitjNnNvejJLZThJa2UrYllIR2pQeXJHQzVzVmlRTE9U?=
 =?utf-8?B?WExWR3JObEQ1bmFmNUpnSG82enVtSDBpRC8yMFNRMTdvS0o5L3h4V2ZxeDg2?=
 =?utf-8?B?SGMzNXhlSXBlNGFWMjFRTGlBZ0tGb3FQWmVZa0JES3FITmN2aTRDR1pWbFVt?=
 =?utf-8?B?WlVPUUs4SzZNczRGK3V3UkxIY3lPSXM4QUJDMThKc0FWbkNvbkxsOGs4U0Vp?=
 =?utf-8?B?SHgvdDhPM0dBeGRPSHVQMUV4OXQ0YTZ3K0cybDlrVTBLUlFZeU5iM2FsMkU1?=
 =?utf-8?B?Wm0zcnBSQ25lSmZ0MjF4ek9jT1E1RlVWNU5rR3NXZWF5aG5YL2d2UFZmaDJN?=
 =?utf-8?B?V0NVNUk0c2VXa1NjbGVWL3A0bm1PcklGcmNmMFBydnIydlJWUjRMTkc0b3lS?=
 =?utf-8?B?bzBWbVR1dmxod2wvcUpSQUY2d2h0L1A2dEI2WlZNbGVWaXJjV1ZCOEVoR3RG?=
 =?utf-8?B?VjEvU01JZi9tbEU4NkxvN0U0U2dhYWhCVGl0WlEzcW4wd1ZOVGNONENlY1pY?=
 =?utf-8?B?b3dTc1Y5WXkvcXRXZlJUazVUMWVrQnlCQmFhU2ZUTzFxNDVZY3hZRUU5cFVW?=
 =?utf-8?B?UXVZVmdyampYMm5pVjExM2Vab0hnRFZ1cWQ3T2h4eXYyM09uNkNXeWxzU1dB?=
 =?utf-8?B?SVJHZWI5ejNhQW43Z2lFd2xRREhDNmZQVllHQmR6WmxRbU1ML0gvQTBHODBl?=
 =?utf-8?B?cXFmbldYQXNoY255cXF5aHV1VXlwRjR4QmFId0k4Yi9ya04rZk1xbGdXWmRw?=
 =?utf-8?B?bU80MHVaSitxTFJWYTZZYzU3S3ZPdmJyNXdmWUdlMXR6Q0l6K0I0NldlWHFj?=
 =?utf-8?Q?h1iY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e5c8e4-9721-4fef-8330-08d9ac947f7f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 02:13:24.5269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbEhmbhXwJnucLCpYtU/acZpFtha3ux1axQ5znqrHf0WFUl+zYEiofkMCZsWntTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-19 5:59 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">On
      2021-11-19 3:22 p.m., Philip Yang wrote:
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
        IV entry. drain retry fault check timestamp of rptr is larger
        than
        <br>
        timestamp of (checkpoint_wptr - 32).
        <br>
        <br>
        Add function amdgpu_ih_process1 to process IH ring1 until
        timestamp of
        <br>
        rptr is larger then timestamp of (rptr + 32).
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c&nbsp; | 98
        +++++++++++++++++++------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp; |&nbsp; 6 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; 4 files changed, 80 insertions(+), 28 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        index f3d62e196901..ad12f9d5d86a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        @@ -165,51 +165,41 @@ void amdgpu_ih_ring_write(struct
        amdgpu_ih_ring *ih, const uint32_t *iv,
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /* Waiter helper that checks current rptr matches or passes
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
        +&nbsp;&nbsp;&nbsp; /* After wakeup, ih-&gt;rptr is the entry which is being
        processed, check
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * the timestamp of previous entry which is processed.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; return checkpoint_ts &lt;= amdgpu_ih_decode_iv_ts(ih,
        ih-&gt;rptr - 32);
        <br>
      </blockquote>
      <br>
      This assumes a IV size of 32 bytes, which is not true for all
      ASICs. On GFXv8 and older GPUs it's on 16. OTOH, those chips don't
      have a ring1 and may not have a timestamp in the IV at all.
      <br>
      <br>
    </blockquote>
    ring1 process is enabled for vega10/20, navi10, not for older GPUs,
    as it is scheduled from self-irq.<br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">And I
      think you need to be better at handling when the time stamps wrap.
      Keep in mind that the number of valid bits may vary between ASICs.
      <br>
      <br>
    </blockquote>
    yes, 48bit time stamp will wrap around after 1 year, add function
    amdgpu_ih_ts_after to compare time stamp with wrap around case.<br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">
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
      </blockquote>
      <br>
      If this function is only meant to work on ring1 now, we should
      probably ensure that by checking that ih is really ring1.
      <br>
      <br>
    </blockquote>
    Add dev_WARN_ONCE(adev-&gt;dev, ih != &amp;adev-&gt;irq.ih1, &quot;not
    ring1&quot;)) to ensure this is only for ring1.<br>
    <br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">Do we need
      to keep the old solution for Vega20, which doesn't reroute
      interrupts to ring1?
      <br>
      <br>
    </blockquote>
    Vega20 is not changed, because Vega20 retry fault delegate to
    ih_soft, and wptr overflow is not enabled on ih_soft, no stale retry
    fault issue, keep old interrupt handler for ih_soft.<br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">
      <br>
      <blockquote type="cite">&nbsp; {
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
        +&nbsp;&nbsp;&nbsp; checkpoint_ts = amdgpu_ih_decode_iv_ts(ih, checkpoint_wptr
        - 32);
        <br>
      </blockquote>
      <br>
      Same as above.
      <br>
    </blockquote>
    done in v3<br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">
      <br>
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
        wait_event_interruptible(ih-&gt;wait_process,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_has_checkpoint_processed(adev, ih,
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
        @@ -253,6 +243,56 @@ int amdgpu_ih_process(struct amdgpu_device
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
        +{
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
        +&nbsp;&nbsp;&nbsp; ts = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr);
        <br>
        +&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr + 32);
        <br>
      </blockquote>
      <br>
      Same as above.
      <br>
      <br>
    </blockquote>
    Done in v3<br>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; while (ts &lt; ts_next &amp;&amp;
        --count) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts = ts_next;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr + 32);
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
        +&nbsp;&nbsp;&nbsp; if (ts &lt; amdgpu_ih_decode_iv_ts(ih, wptr - 32))
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
        @@ -298,3 +338,13 @@ void amdgpu_ih_decode_iv_helper(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wptr/rptr are in bytes! */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr += 32;
        <br>
        &nbsp; }
        <br>
        +
        <br>
        +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32
        rptr)
        <br>
      </blockquote>
      <br>
      This function needs to be in IP-version-specific code. Maybe add
      an offset parameter, that way you can handle different IV sizes in
      different ASIC generations.
      <br>
      <br>
    </blockquote>
    <p>Add decode_iv_ts function interface to amdgpu_ih_function, this
      will be used for different ASICs, to handle different IV size and
      time stamp offset. vega*, navi* ASICs use this as helper function.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com">
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t index = (rptr &amp; ih-&gt;ptr_mask) &gt;&gt; 2;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t dw1, dw2;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dw1 = ih-&gt;ring[index + 1];
        <br>
        +&nbsp;&nbsp;&nbsp; dw2 = ih-&gt;ring[index + 2];
        <br>
        +&nbsp;&nbsp;&nbsp; return dw1 | ((u64)(dw2 &amp; 0xffff) &lt;&lt; 32);
        <br>
        +}
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        index 0649b59830a5..15e8fe0e5e40 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
        <br>
        @@ -89,10 +89,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device
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
        +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih, u32
        rptr);
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
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 88360f23eb61..9e566ec54cf5 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1968,7 +1968,7 @@ static void
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
    </blockquote>
  </body>
</html>
