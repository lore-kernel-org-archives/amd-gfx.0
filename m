Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 16:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512CD10E1F0;
	Mon,  4 Apr 2022 16:52:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A701310E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 16:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5lGeb3ZQYo8mkKrt8axPuTsOVEOmOdQ/V95ksJGoqMCZYgjzgBijxdJfiJuMWtoXomUqojh0L9QILoEIvhXXKiknmDmFEnTSe+ZuutInzKR5WKbqJgQkQzbu9Gg2Ff12p5JiQDPteCNXSTPlzqfxnd9f7LsCmk1ufYAw3EIksP3XhvpSiOAcXeqmacapyEyLmp67dTOM+jjfruUUr+F84ATZV9RPN4vwec7r25a9/FNAVrdERL06vmOKe0qU3P+T6Wz7V2WD3eDnMqJwAQnvovDt0BJucB77dXYaW0QncvghnmJ3expzy9Q3gHjqIaAsDzBhmmVZGk8H/iFhYIPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgSUX6EICF4jfjtfcWSa9QpECot6sCiHgeulNh3dTJo=;
 b=LPg+ua/slzvDt+TaPceFdDa+rMKTn9docALj1ZtfQcxgujeStxR36t/+e4Q3NbkhSBnL6b/6po1PEN0KjHhuS8nEoOWkh7rrx4K0/dRYOGG/hb51VhSE9eWzOwPz4uy/RWzF/o6+eC6gHJp9N2WdnC3e3McmDiVi0YEdVyD61JP2pO8JbllhACemzFOBBQGwskXG0wdjCWMGQAXCwGJz5ol5Yb2LJXW7TxCkQ6kWIMP2p10W124LUSDD4Ap3vBBe34RkoocckVs5gC3McfCM2O77D2F1sYWIGV8pbBcqom0bW51f0cjIoz0sGaDwq9xNwQF04ER9BL2lktRH8u0QJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgSUX6EICF4jfjtfcWSa9QpECot6sCiHgeulNh3dTJo=;
 b=dfqwM9IvB37B+i75vIYEdk4rhYgGahK3QbJzWMaX2ymSbss6lRXHSa1gxGpRWQ0tirocDi5DXhBHWf3vpdH/Kb+TgzYQycHomX3MfHrMDdayR4icRU9Ih7xupDi2HYwP5HVSIPWCqW2/xRRDYqiY3oIWJpbI/MMjbHNumfEd32E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:52:29 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::a199:80cc:7764:a069]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::a199:80cc:7764:a069%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:52:29 +0000
Message-ID: <a8a480f7-a40d-5c05-659b-d3fa68f697a0@amd.com>
Date: Mon, 4 Apr 2022 12:52:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Philip Yang <Philip.Yang@amd.com>
References: <20220401195726.21436-1-Philip.Yang@amd.com>
 <daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de>
From: philip yang <yangp@amd.com>
In-Reply-To: <daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0063.namprd20.prod.outlook.com
 (2603:10b6:208:235::32) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdbd1d39-4b4f-4c66-207a-08da165b815c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4341:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43416E925C0280E0AD141CAEE6E59@MN2PR12MB4341.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cf9xOjyTJ4SxpxriAHEL8H8SShXQywlOIZsbbrrU7QDAco2eTgfDG4Hs5wrzZpyrZVh09FiRwSLvVuKMEXjpvr+c3ieAx8sNfzksRzeXvJr9M2AhI794ZhKWqM6VvVdbLyKTBfrCWcZaht6wlS8qVigCx21aKil2O7wbqBp3o3LSNv6iDqPlXwgaJODUPRmn1FWq7UWo4ZqM2zz4L5L8fPN5T7G4k4VTPTQn6XV2+Dnl4WHHGS15UPLXqeOWJ4kkE9masr/k4tWcQp25xmk6bM4Nuorx5NcUf7rKsMR3FV6wkcxYnAzUabPvOV/ctZUsCFxO5qY1iFgPi0rRvja2r7tNGxnKzlmQqTVqBd1PSq/u1Ltrp1jjRcSMUYjVY9KaJimR1VRgLCtq+/qUeSpH0NiZjJR6E5DI5z605C5mYimXhmqQW03BmmpgPrmnMSpFm6fue33svdm06WSsUyg8NMQ3H0tVwr0bdH/Up9X0/e06f+x5SWdmeCh6dyCr5j7LzdAhGAf90miFRKaj+J1TDntHd0QGxbHWHzplfO6W3MUw8GR616yzcauEMl4DbdZ8feBJlvM+MyFxMS/74s3pHGpt0oTfm+VW2u8ssTLFlerGbURUht8KyG7NM4g+sEaG96xy6rCaSUW+EbaV9a2JMDTSl0ws5VgxPs19b2iGQZT1Z0ETHd4qssayob3NLZtmCe1dsTgr22fRumQvuHg4EFqhG0mMvVuKRrLbfM3nFuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(4326008)(38100700002)(53546011)(2906002)(66476007)(66556008)(8676002)(31696002)(6512007)(5660300002)(8936002)(26005)(6636002)(110136005)(6486002)(6506007)(508600001)(316002)(83380400001)(31686004)(36756003)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWQrTEFuZHY1cjNXNEZxR2N1U0JjVS9Wak1OTXRIeGlUMkZpczA4UHlSMHRF?=
 =?utf-8?B?LzhvYUtPN2RjRlZEYldoK2pxUXZIQXNka1NNNGZJVHpncElLTGRpOXdEYlhi?=
 =?utf-8?B?b3BDYnVCdzFUclBIT3M1akZQTVNwUC9lTTgxNlE3QjhxWm9IcVNiVWRXRFYy?=
 =?utf-8?B?L1NZa1ptRldwejNkYWRpbmI2Vnp5UTRqRVFiSUhpeFV5Q0NSL3FxTmdKVmRl?=
 =?utf-8?B?WHk4MVN6QVNDM24ra01SL3NVMkxZcWkzM3k1QkJhMG1yaWt2OFBMTG5iNXJm?=
 =?utf-8?B?NlFtNHFJYzA0bDJDeTQrQ2J1LzZQc1B1T1dIcUdoNFZ0RFg0TDdYYjZlWW9E?=
 =?utf-8?B?Rlk5bUhaKzFGaEt4citDa1R0d215OUd1WXBNSlo4cUVHaWR5VUtJYTZZR0Qr?=
 =?utf-8?B?azMvVDBKVDJjRGhhbDh0NTBuNWJoTzBPaGdpZnU3RFFaQkh6am92d1Zud3do?=
 =?utf-8?B?cTdaRW1QRERzS3lqRzhWYVliVTNOQjNGWFBlTmZHSVBNNW1iandNRlJDQitI?=
 =?utf-8?B?V0FTdk1odVBRSit2cjZUY01vYW4reHVyNWxoc2xBQ21wbm00czluSk04OXZE?=
 =?utf-8?B?eWltVGJnU2xMdE5xeHdsY01wN0xsMEhmRW4xaVJHdzdpRU0rMXIyZW5PcHRF?=
 =?utf-8?B?ejlCVXFLNFVhOExFeVJQWXlKc3l1VVZLa3Q4VmdHYmw2RmdQVWdSdnR5czVH?=
 =?utf-8?B?SjYycWxGZ21hTWlMSEJtTHh5YmkzZnVzVldLYjdjUVdYNWdzK2JPOTJZbURN?=
 =?utf-8?B?cm9RMVhSS1Npa200UXVnZUVLa29UK1FmeUgzQUZ0dmEvZDlFdmVranR2TG11?=
 =?utf-8?B?S21uRWkrV1BjRU5CanlwOTFKUGZLZldyZEZ1TWU2Sk00YmJUT2hicWN1eGFT?=
 =?utf-8?B?cTM3S3JFYW5UVHNWbjRmSVNEOHJNS2sxTXpYeFp4YXMxRFhFMDJIam5vVVR3?=
 =?utf-8?B?SUZrQ1lIRVpLcjM3dlZHWG9JQ3B0RG1wdzkyYjZETTR4Wnh4K2xWRkZCOTNB?=
 =?utf-8?B?dXlER1hqSEFsYlMrWFVMV1Z0SkxUSnh4N2l3TXlHR2ZiN2F0SVpmMlhuYXZ2?=
 =?utf-8?B?cnJORmRYb20zU2I5c1ArQWtFcjZFTzhUZ1RkOGVVVm9ZcXdVeGtVM1IvZGgv?=
 =?utf-8?B?WjFQZXQ3S3VpaFF5TlNheXZVWkJ1cUY5UXBoT2RiNkF3SUpFTkVtZ0RJd2Y4?=
 =?utf-8?B?VFZBNEdRSUMrd1FZMi9SVnM0TmZmTHJFRG9ZT1VlQzM1NUhzSGd0a3J6bHUr?=
 =?utf-8?B?VEFnaDk0bWhOMnBrWEcrbXN5MExPZis0NXlHcXVYMmFQOVJQTncwZHdwU3dK?=
 =?utf-8?B?WkRscEV2Nkg3ejcwazZSMWtoM0laN2J3eWRjWHpnRWpZODg5ai9MTDgwZGF4?=
 =?utf-8?B?RE5xTGh5THl3L1hMbXZxUVF2cnpVNHpQT05oRU1id2xVSW9hb3JJbndHMThU?=
 =?utf-8?B?SzI4N0FDdkNvYzdlaHcwd1FpSzIveXNDeUkzMTcxRzFCbUVGbWJWczNCWTNC?=
 =?utf-8?B?RXJrNXQ5Sk9Kc1NsdTU4S2pzbXpWSVRBMndwTUtUOWdvTko3ODhCYkpUcG5x?=
 =?utf-8?B?alVuNHdDUVREMXZNM3M3V3lzamRPNEY4WUdST3ZHQ25aMVhZekVoSnBZbXhu?=
 =?utf-8?B?Ym5YUUhZd21mK1ZOeTVhdWovVlZJQ29yUnBEYkJqS0dvRTNaTU9ZL3RUa1Rp?=
 =?utf-8?B?Zk5sN1YxUnlUSkZlT2JNcEorcUV4Q0srcUNVK201anB4T2NhMHVnREJYNjJ1?=
 =?utf-8?B?alJGb1p0eTFDWWFMdG9ZWjg5QVY2empBbUJNSXI1RUpCODEzUkhzZjFiT2lX?=
 =?utf-8?B?dEFiUXkzRVlHalE4c21uczBvUnNiaVFVV2pycFNMRHNUYllON2k3NU56d3h2?=
 =?utf-8?B?dUYxWTVGUzZGQmpuL01sMkV1Rm4vaTRibmFSL2tPTEhkWW91cGxRNkhZRFVp?=
 =?utf-8?B?Qm9DTGlNa2FxdlFHV1RFTmp6Y2ZRZnA1Z2FWaTZXQjdOTHBVaWlxODBCVEpK?=
 =?utf-8?B?M2UvNFhTUkQyWTlqeVBlaEZseEc0QU9rbklYMGpGNlNXTjYyWUtkUW5hR1BV?=
 =?utf-8?B?OENLcGlnT0lIRXl6a3Z1akZzRGFreThWZjJ6Y2hIbmhCSE9hdnlkMmxOSmpT?=
 =?utf-8?B?cmZ6SHByL0FMSXJpOHhydldwczlNV3hSb3pucUNnd3hmR2ZId281RFlHRUJl?=
 =?utf-8?B?SFhCZlFFdlFnRmMyRCtQb2RIeTMraW9NYXJuUEIvVlVEY1R3UTNXQ21KZXRj?=
 =?utf-8?B?TkU2QTA5cHNFRG9iVWwrZ0twaEJQak9SLytXUlJ2T2xUWjB0MHZ5ZWV6MVlG?=
 =?utf-8?B?TEo1LzVxaDVYQ2h1amlXVWl0TnNSa3JPazd3Y0ZMR3ZQbndQUEpLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbd1d39-4b4f-4c66-207a-08da165b815c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:52:29.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPYB3I7/qKY9RfVVmjFcLRyowdyY5hT14FqiOK7pZ+S+pIedYt7pFHUBNVS1TRvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-04 12:19, Paul Menzel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de">Dear
      Philip,
      <br>
      <br>
      <br>
      Thank you for your patch.
      <br>
      <br>
      Am 01.04.22 um 21:57 schrieb Philip Yang:
      <br>
      <blockquote type="cite">For VG20 + XGMI bridge, all mappings PTEs
        cache in TC, this may have
        <br>
        stall invalid PTEs in TC because one cache line has 8 pages.
        Need always
        <br>
      </blockquote>
      <br>
      Can you please rephrase. “may have stall …” is really hard to
      understand.
      <br>
    </blockquote>
    The patch already pushed and merged. <br>
    <blockquote type="cite" cite="mid:daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de">
      <br>
      <blockquote type="cite">flush_tlb after updating mapping.
        <br>
      </blockquote>
      <br>
      Maybe:
      <br>
      <br>
      So, always flush_tlb after updating the mapping.
      <br>
      <br>
      <blockquote type="cite">Signed-off-by: Philip Yang
        <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
        <br>
        &nbsp; 1 file changed, 6 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index f0aec04111a3..687c9a140645 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -837,6 +837,12 @@ int amdgpu_vm_update_range(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* Vega20+XGMI where PTEs get inadvertently cached in L2
        texture cache,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * heavy-weight flush TLB unconditionally.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; flush_tlb |= (adev-&gt;gmc.xgmi.num_physical_nodes
        &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] == IP_VERSION(9,
        4, 0));
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;params, 0, sizeof(params));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.adev = adev;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.vm = vm;
        <br>
      </blockquote>
      <br>
      Did you do any performance measurement, if that flushing affects
      anything?
      <br>
    </blockquote>
    <p>There was another patch to optimize TLB flush to improve map to
      GPU performance, for this config, always flush TLB after updating
      mapping is the original performance before the optimization.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:daeb333a-20b3-ca34-44e9-375f3b5ad2de@molgen.mpg.de">
      <br>
      <br>
      Kind regards,
      <br>
      <br>
      Paul
      <br>
    </blockquote>
  </body>
</html>
