Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06574C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705A810E6D3;
	Mon, 28 Mar 2022 13:35:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4C710EB60
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki+aJTKI/NcF0vQp3sJx0YHy4v9NszneCh/ifxSjXGr28jhhUuoX8YJNgoGOFYG2UCikg2fRTimJViYKcCBQ8xEkXip0Vo5w/Yf+nBGM3PpWtHIq+8aY0SPLLq0SRVuliROvH4TLIAOo1C0RT+MmtLRECJRJWFfmPyX1dPjjvU0VciJMIp4oUVfR1P0m8pG3l7pCyTaB0yLOErSoRum1TxQnJO63QNCBO7NOxbCf6bJp28iUSyHqZwmAsnFxcM0TVx9AM3sfPvGh1yoBd8n89YfBBoFZlWwDFtLBkFlOL+EBDqLdgbIF0yrM+P0ooe9tYReOnsTPvNmf70D+DMtR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuepEARzYP52AihrafaIdjMjUzBHX6bDq3GRw3i0VC0=;
 b=LF9Rf6xY8UOpWg756+XmafuVXblTNur+pmlhaEnoK9TOE3UQrYS833J+yp+N7IWmmYWd5NVxY87K98TOaofqXmxqNoMzkymWWAbzPTw4XkPePHOFf+SjZBmS+WklFA0+czWpWaSp17MYCWppcF8bdg7JNMw2b2LA+1StCfvEX3uhrs1OznxnnoPumG5kCv5xn6nLuS3Vv+Zo2WQ4UMXvgiqIUJfsEbTC7vX48g10uwiHL+pUU1sh20ndfB63o4T+Y3Fk/9JtpkS7IHzI9N4WeOMT//JsZjjG8SCVKWs4bJZxfbTHw9RGMUbG+fM8hcNZGG6aJWcPdADtjxEdVGmS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuepEARzYP52AihrafaIdjMjUzBHX6bDq3GRw3i0VC0=;
 b=sd52xNsnQJWJA/UtRSYPMrrKX0vDzH56N3M5E0OFAIpdlXjOe9Dtdv4EK2yJ2ISRuTCFPV9TurmwMgFEt3oDEWaNBWUcNbIQ+JPYayu7nE5EKkVZWFT5NGYYUd6DED8Kpsg19qgWa/IfQ4QwdC8+D/mS+njUC6/8XfQia5y8qY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB3469.namprd12.prod.outlook.com (2603:10b6:208:ca::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 13:35:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:35:06 +0000
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Correct unlocked update fence handling
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
 <9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <ff4bd255-1c0e-0a88-d23c-8d372f7a3e78@amd.com>
Date: Mon, 28 Mar 2022 09:35:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eedc764-c22f-429f-4549-08da10bfc543
X-MS-TrafficTypeDiagnostic: MN2PR12MB3469:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3469DF205234FA321FFF13BBE61D9@MN2PR12MB3469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLoq0YH2JXZ7c4o/IKS6fDQGpM3ewHg6O3ONqDH92YER0lnDDWCFojoo2vClXshspZGSe98iHHsNR1uuOzmnF0zc/OO2QUBWgml6Ls1NvGDC3Dp0I+XDaX2keMDb+7JRPnLNINc6cxdkGvnzLB01ErobZCi7hVDoxA+6fQlowL75b69bVy654VvZc0GVRJrRqg3QWRATBIC6ZBPye+YzgiMQqUDh2w7LpCwvpYQYJMfQAVLT24NXCIHau4TKIVM3NLUlImr5UDf7P0yWRJSYBHw0HnrWKNpsUFao1Ld/rwXHoGCpgDiKxrKyRn4ytpJi3Hb8sTFvGIve5Roxkn+yeW/T8z96LVYhN56LklV1tuV6KlpX1UJGnW9Wv6JsZ20ADLqHHo3Yr6BMe0HdN5mpzoZMsbE22WwifSdNslWQrNWqOO1kOHQ+1UF5YgxfNCHi6ZTxtLArbwvUr252AeHA+8m0oYUdOM1TRIp9z8e/KuYCZrkXrRL68zcm9wEAChHBXaHIxViK9ZCb0SwrkWno2Smtnjx9wj6S8k7JYPZmqWz4835yTimo3YMtYfPDw0HFJdItEIKzPEQQjEE7AqXdF/tEQ/aXpwh83GFWRNsi/Lu0CpvflDupJ0FBpvLqynYXKdpJyX9Iwr/LGPCsFAdaSuV7sdYxhcdMaVw/m/GpNhAdFSZFPupVm/UugrADQx8AqKN8oQVwAqfJOTovUY+Ba8PW6ctTBjwXw9NdMu04BLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6512007)(31686004)(38100700002)(15650500001)(6666004)(2906002)(6506007)(36756003)(83380400001)(6486002)(186003)(66556008)(66946007)(2616005)(66574015)(66476007)(26005)(53546011)(8676002)(4326008)(508600001)(316002)(110136005)(5660300002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVAvRWJNUmlsVkhJY1lqQnc1UFV6UkpJNkxyZFU0VFA5M3VqbStTdlZLeW1C?=
 =?utf-8?B?dXpOUGlsU1hlcjVZT2tETk9FZmRGQytHZmJ5QjVSQzVRUjRyUkhYdkNPa2dJ?=
 =?utf-8?B?K2ZLYXZNR2h3cGxucDJLTmR2SUZWckVJTzlrdlZDMGx6T0pGQysxWDBseVUy?=
 =?utf-8?B?UjBsWG91YVFIVUlSYzF1U1l0aENLa042aWswV1hjdHNVbi8vOWRSaTJQQm1X?=
 =?utf-8?B?T3liclVERW5lVnFSYkFaNDB0VVM2Nkt0cGFxWlRRb0xYTE16OG5sKytQQVI2?=
 =?utf-8?B?RURyZFh2WnNVRmlMbWNnZkRmZHVOYnVHdTZoZGxuTDdqYWpiRnNLc1gvbVFk?=
 =?utf-8?B?V3N4OEdhVkNIZVdNVEROU3l2Ylc2Y0RUbmY1a05nTHNESG5UeWtTTWlOOFA1?=
 =?utf-8?B?QXNBU1NKZ2JVdngzdWw1TDB1TUNqeFRNdEoyMDRpampJWUE4cXdnM1JOTWtL?=
 =?utf-8?B?dDRyQlU2ZHk0QmtHMzI1RTM1bGdMQ0hXOUUwaEtncjc0c1AxbWxBTlpTRGxH?=
 =?utf-8?B?clEzTlhIUmJXckZpcXZkb2tXTU1hZTdyV2dpK3JmaGFjMG9CeWVJK2ZiWXkw?=
 =?utf-8?B?anpUSGs1N2FEbXlVU2JVZnN2WHdjM2xpR3pDaUVacEpJNlAyVWpSQlorQlE4?=
 =?utf-8?B?UCtqU04rek1HR0ozdUY4eHFuQm1EU096eE5JcVRubkhJUzdaN05lOGw3bHhF?=
 =?utf-8?B?MTR0NnRuaUR0cnJnczZOVGtNTDIwckpiUzNpRnNQUHlyc2pydUtaUUprdlh5?=
 =?utf-8?B?bmpiTncyeldQVVRiM2dXSG83N2N2VHF0THFXMG1EeEpHZXN6QUtkMUtiUWIv?=
 =?utf-8?B?VjQ1UXM3MXhuVTlzbGNicjlKcmQzMERsTElvVHFTTlJ0Q3V2TEhZMDNNRWFv?=
 =?utf-8?B?WlppaWR6SFVmVDN1QWhHUjlaQjZpVVVScDIveEhUWTVmQ2VNc3NCeWdUTHk4?=
 =?utf-8?B?bXhuYys0UkhlZm1ENEN0QlJvRGVVaElKOVZ3Rmw4MHZaZmxFdXlxcmMyR2lV?=
 =?utf-8?B?M0w3QVV6L2FMdXZnbEJVd2o5ZC9UK0lkUlk4MmhKMWFYYkUyUWhKRXgzZU8y?=
 =?utf-8?B?VEo3ZDZhNDRxNzFoL2tJaDFvd2JPQ0FCUXduSkxsK2ZNT3YvQURyMnM5cmF6?=
 =?utf-8?B?WjMxZTNLQmhyaVhvT2FBQUpncXFoUHpIMFRwdndwK2YwbG1qVFdDU3EyaUtU?=
 =?utf-8?B?cnQwVmpmQ3ZPWUlZYXZmalFYSDJJRnVDdDVCd3l1cTJmOWtkQSsvREsvVFdu?=
 =?utf-8?B?Nko3eGFEa2x2dGVWRk1VYkhxekk5dUdNOGhWb3ova3h0L1d1VDVrYVBKQjcv?=
 =?utf-8?B?ODdDSDdXYlVwNkZOeWpqVUI3dFBWdkVsYkNOQ3M3NHZyNS9iKzdMYW1qMVNB?=
 =?utf-8?B?OVRMTVkwZE9YMS9CVDlLN1lWeEgzaE9NUTRpaG9uUWhWV0pNLzVIV1MzOEJM?=
 =?utf-8?B?Y0hJcWdpTU9YaHN3a3d0THJHcms1Sm9vbnFobXFlS0VEZHBKMGpvTStpMGxs?=
 =?utf-8?B?U3k0cUltWXAyT1ZLTXU4RHlZOFYrNStndFdTemZVbFVKd1ZrRGhQRW9hc3Fs?=
 =?utf-8?B?NG1EcW5vdm15cWVqUnRsczBhSzh6Z1Y5UmJJTHZRVjBBSVdWeDBma0IxY1JR?=
 =?utf-8?B?K2diVXc2T1A5UTNHUUdtTnRxZHAwR3pKK0luWEYra3pIV1R4UWNTcSswTzVS?=
 =?utf-8?B?WjZ3SG1zWUJXVzY3MGtndm02bDR5dzd3TktaN3RQeWtlc0xaL0gwUFRtWFp6?=
 =?utf-8?B?K1ZPczB2b2VuNExGNzY1M0VYaGkzWVRZT0hMTUYySWFoa2dITFNVWDNoM1pU?=
 =?utf-8?B?dERSM0dGUVFha0pRQmt4ZzF5RFNEVUEyWGZyN3hEVUErcW9xRUxqTnk3WDNk?=
 =?utf-8?B?RnV2bGxqdmRFM0VlUDZiNzFBZHJ5UzM1WE5wNXBsazZUTmx6WnY1MnNzaWgy?=
 =?utf-8?B?WjI0ZkRja3QwakNCY0Z3OUs1Y3NTanBpTzB6YkFscVBBTVIxYjBUbjFkZ0Rz?=
 =?utf-8?B?N2VZdDJoZjhUYTVjY3Vwa3BmbFpNQ3BEK3NUWTJlWmNiN1NJamc5QnEzOTRJ?=
 =?utf-8?B?Z3FXNktSUzB1SUlZeEFROHU3S3gwVUIwbEFGQTNSVVVoYUtEOHVUV3cwQW9E?=
 =?utf-8?B?SW5tN1FkZ3F4ZENTRmZkbnVnbWt6dDNVU2g4dFRYeUtHcXlPVEx1OEMvRXhp?=
 =?utf-8?B?d2o3NzNtbWtrejVadVBGMUVWYlZTeDBWeGdVaElHMFY3K01OTk1Jc3BjNHpu?=
 =?utf-8?B?ME10dm1wTDUwWHRQNmVDcWxzc1ZDRWN3T3ZPejJUSWljN1ltYW1CQjI3RkhW?=
 =?utf-8?B?cWRyeFlIcmNaZzBSbkVEazJUYjVmVUNMbENUTEZBaVJmMVBsTnJXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eedc764-c22f-429f-4549-08da10bfc543
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:35:06.2383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhIVEZ6LLGgZtyZM60rjwoIDxzmzUGPvPT3aiezKXsOIjLGnjQxpXEO3tRl/5qHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-28 9:14 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com">Am
      28.03.22 um 15:06 schrieb Philip Yang:
      <br>
      <blockquote type="cite">To fix two issues with unlocked update
        fence:
        <br>
        <br>
        1. vm-&gt;last_unlocked store the latest fence without taking
        refcount.
        <br>
        2. amdgpu_vm_bo_update_mapping returns old fence, not the latest
        fence.
        <br>
      </blockquote>
      <br>
      NAK, that code here is perfectly correct.
      <br>
      <br>
      vm-&gt;last_unlocked gets a reference to the last unlocked
      operation.
      <br>
      <br>
      Otherwise the last locked operation is added directly to the root
      resv object.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 +-
        <br>
        &nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
        <br>
        index dbb551762805..69fba68ff88e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
        <br>
        @@ -109,7 +109,7 @@ static int amdgpu_vm_sdma_commit(struct
        amdgpu_vm_update_params *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;unlocked) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *tmp = dma_fence_get(f);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(p-&gt;vm-&gt;last_unlocked, f);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(p-&gt;vm-&gt;last_unlocked, tmp);
        <br>
      </blockquote>
    </blockquote>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(tmp); <br>
    </p>
    <p>tmp is the new unlock fence, so this drop the new fence refcount,
      fix is to move the old fence to tmp, drop the old fence refcount,
      take the new fence reference.</p>
    <p> f is return fence, because f swap to old fence, so old fence is
      returned, not new fence, fix will not change f.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com">
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_fence(p-&gt;vm-&gt;root.bo, f, true);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
