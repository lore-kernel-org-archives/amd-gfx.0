Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C789DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 01:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624A4610C7
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 01:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A4610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDD06EDE3;
	Fri,  2 Apr 2021 01:11:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359936EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 01:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPEzAkELzRkGDM6z5p7tcqb98mz4kOpgPvuQ8vaToC10V1U9dUTzEJytmJTQqCsmZ+iLRPJfysCLmAUejdzkxU/CyBRkcEVH79Q8f/OA4eSJIN8qhEi4w7psvPciR8uhsCUEv8NFLFweHUFvC6Nao5VJcSlYWQ5QdDUF1o9WyW1hs8pfrnzjoi0eejybWLMSyXNgrf9GtMVyOM27Wp6hX3rBAZiqeUaSQiXqRaiynLy8TqzfsIuOEvd6fRyBD9lTDkX3VuQiyZ6C2q+Lq+LbMRWyLBFmbX8FJTelW6+tAXtcIEL9eDV42o0ezmR0wJNiwgI9i7llFSa6+OEY7sWTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm7DH8fNr4XFdhP+NfShHps3Y6QcU1w90LudsNVFEU0=;
 b=cVBEHTrjuJqXZlk9Mo2d6rYPdu56D05BX5ESAgSJCUXX02BFF3l0uJoobDUg6r2m4WH/IEdeXYQF5UDCSnadV9RKi8Kn6I7FYVttGfVP7nmMN7z4LkTjJRHkBe/MuqabL5Pb8RH40PXZ0wbcicl4IzfRoGmFfpZVW5iEnDOSx/L9YIzEsIUatJK+lNtEqYtKbUhhCfI8CLIXzqDx9o3MnKGqEG/wGZHvk9JamxgeS93TcFW12D98o0lq3yzqwPaLAB+SJPWZ4ULGqVO9gZDGjq4c0ESYXqkyaKsgWjvfTVVPdPRKvI+sJZiiIptEM/Ya10QmpibdijeIncZdtywBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm7DH8fNr4XFdhP+NfShHps3Y6QcU1w90LudsNVFEU0=;
 b=Ez2sejSDtcEnL9FR15CEHoKA3Gp1OSnGzFpZwA445p2gU+IdV/R4WmbHAtxBCEpdJMe9KF8wqdVlANbIcaja55z66Uwuyir+bPIN+ILNDx64EPc0UxTlRyuJyx4tfmF56iY/A363CpKfCmoVthPZqOWRx1UedW37dYPoqwBvxJ0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 01:11:04 +0000
Received: from DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::ee:4c68:2781:e334]) by DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::ee:4c68:2781:e334%7]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 01:11:04 +0000
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, PengJu.Zhou@amd.com,
 "Emily.Deng" <Emily.Deng@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Subject: Boot error on Gfx 9 with latest amd-staging-drm-next
Message-ID: <88a99568-29d9-5d02-b345-59e408690dc4@amd.com>
Date: Thu, 1 Apr 2021 21:11:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM6PR12MB4108.namprd12.prod.outlook.com
 (2603:10b6:5:220::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.18.117] (165.204.54.211) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30 via Frontend
 Transport; Fri, 2 Apr 2021 01:11:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700324dc-d36b-4a6f-9a1c-08d8f5742f99
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB410548ACAD72C7F8B9F0D546FE7A9@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5HBEc5zzX4VuvJoSqCsw2e5yvC6WZX9MfclW7eTErWg3n/9xHELKhpz1VcKEwuzEIururMePthZjZZ2ZTK4ZXTvtfWeBoCIWJlxrtxu3rg8SsVMedVY//fTKD2gbsiiADgPjnDl0kvDHLFxaCW8pX3BodASz1b7x2EeErEEjS7B50LbAUPxqAUZ/3xMVTmhOqeA+AHYwtMK4+zOlE4CDWXiYxyLPtYaj45qWpM182OWB9uFpQ9BWs4zI8DG47NCf6WO9N1BYQNVIu73qdoMGHiNcRFNJEdFywicjIKsgaXluIR7oDVx5AKdNtMITPSHp2L8U2DrrNYXEcB6JAF2lhVR6aC/Fk768knXwCWAlG+XRDxWlTw+974QLe/fSNMZxWhad8O/KnNaFPOzzAOICHbMC8DmCrTillfeKvM0tYNR/JukCeKR/JwTLHJ52ckaWFJNhY+6XZvplnGkKO6u6FnMpnQAyZeSVAYjTRT43KsZF5vh1/CL5uZj5yAww+lgyu4kGYRTUafeBUV7tr+8k7TKyzauSqwYPARJHDNnjH4/qyJAZDi1CORvMUcFViCJhc7+GqQoTpUF1TQKg0hzqqIti3750yTLlnJA5MmtTxeuhfFE6HyDCIsGqpWsr1Jg49r5lgLImXdL++9CdHuk9WpjOI4AG1h2K+OyNseMOTmCGQbqejPWV27Hri0+t5QH8qj5mRcjIx1ZJquYkKaRuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(26005)(38100700001)(316002)(31686004)(66476007)(6636002)(86362001)(2906002)(8936002)(8676002)(5660300002)(4326008)(6486002)(16576012)(36756003)(110136005)(54906003)(66946007)(66556008)(16526019)(83380400001)(2616005)(956004)(478600001)(186003)(31696002)(52116002)(33964004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YkNGeEExMW9KeEw2QVc2L3I4UEVYZHNZOENBaURuenhoVVRnK1kxVmU4cGl4?=
 =?utf-8?B?ZDBEQUJ4M1FpcmhOaDEveHpMbHZ6K2dEMHBtamM5VUlVVVU1RDd4bWZScitC?=
 =?utf-8?B?YzZqSHdDaUdIbjNQY0xpMTNEZzB3cWFOdnNjYkVDWGlLY0JHSTRZZUU2V3ZV?=
 =?utf-8?B?bkJjdk5CVjVEY3drMUNrc2tpV1lMTmYvNFJSTjFoK2lRYitnYlFnZW5hTkJ6?=
 =?utf-8?B?SERmWGxnMVo1aThrczBIMHNXdzhyK200WHhBVFVJV0o2TzZaMzcxZVQ4emhv?=
 =?utf-8?B?QWdkVnNGUldYYmxGc3lKNDhGRExkSUZLQnJrWkVxRUlRUU9Db0NmdUJWOXRx?=
 =?utf-8?B?YmxZd1FpYjdrcXRmTUJ4MHhNVmhYbUZ5Z0RoYVV1U3NqZkRmY2ZTT2RyVlNs?=
 =?utf-8?B?WnNobWhxSDg4a1MrUldzZDM1UnVDdytyRXhRVlVsaUk1NnFZcHl1TzZWa3RL?=
 =?utf-8?B?aHJtQW55dHh2NzVWUFMzeGhTT2s4YkFZZmZ4ZSs4dW9pTXpLdnI0akcrWFBl?=
 =?utf-8?B?U1hRdFB3RStLMTZmVWdBdmJXMS9kN3VwZzI5NnN0bExmSEpCN1JsUFdCRmpp?=
 =?utf-8?B?MExVTUtsOHd6RkIvQWg4QzFLYU52dEY2SlZXTHAzM2ZoandCSWxxQUt1cHcw?=
 =?utf-8?B?NFBTQkhGQU1nYnJBaTVoMVUvRStocDFNWnYxMUx0ZGNzelB6NGdISTcyeWpl?=
 =?utf-8?B?KzZjRkFFQnRzc01pOXhBUGJab0k2MDdjUFdEb25zcXpSeDYrS2s0K01oN2tZ?=
 =?utf-8?B?ZWZidVdsbS9SdmpYZ2JWanJFNGhMUnFxalUvc1VUd1F0ZlMxNG8wTWZqckVW?=
 =?utf-8?B?c3pKR0ZrNnpVenl4d0dVWDVKSjNwQW1PZXdIZTBXdEZFSUoxU1hDRUV0b3dV?=
 =?utf-8?B?UEpyQlNBWHZ6R0gvcTRmQ0lEbktRZ2YwNE9hVVUzSnQ3VGxWeGhsZUJld0Zz?=
 =?utf-8?B?Y3BOR2prSzlBRW56UUNBWUJZVXRma0VlUEtiZGdjWGJqZUJkZVZCNDBmQ0pz?=
 =?utf-8?B?czNMaFZMNmNYYmE5N0JGNjMrTU9kWXNuN0FMSjFiZktEek93cWJLcnhuMDBu?=
 =?utf-8?B?WnFDV1hKU2pGeXNBQ1hTdDBhZ212RWU5Z294UU4yaGdJSHAyc2xsanExNWVJ?=
 =?utf-8?B?Z1R6Z05UM3lySGppejlHenlWSldKUm92TG5Tc292REl0a2JTK0ZaY3NiaWs4?=
 =?utf-8?B?bEJ0VDBKMnJSZ3JJYys4TFNGaXNIZjVSbUlPNFI0V2RXWE9BVE4wcEIwSW5Y?=
 =?utf-8?B?d0QxcmJlZmJWSWdLZnlDK3Vjb1hoNEYwQnJNbGdrNU5salQyT015Ty9rZHJI?=
 =?utf-8?B?dWp3S1IwL3JUeDZ3bWwxUU1saTgvaHAwaWpIYkNha0dzU0R6dmxLVXpENGFV?=
 =?utf-8?B?WVVUQk5ET21uQTFvelN0T3dKUDBrdXJ3b085TVJxK29oUWdERTd5eDBPV0FJ?=
 =?utf-8?B?NXdMZ0JKQktNcWhkMzk1SksvaUF5U1ZLbHhHNDNvVVFQdVdJMktrc01oUGl1?=
 =?utf-8?B?S2lZeVg2Z0x2bkNvdmpJUitwWWFlSkRKSUoraUw2SFhQOWMyTGRVSGtMb056?=
 =?utf-8?B?SjNySG51ZDhTZXVqMi9zYUduZnZ6SkhnWlpYemdLRndLdVR6dmFoYjBBcm9U?=
 =?utf-8?B?Y3lKUFh1QVl2N0xiWmMxbCszRE9DV3V0aHZ4LytWalVNYlMvZkFmSmp6VXMv?=
 =?utf-8?B?a2hodUlNZnM0cXArSEkrT01rUE5hc3VOWUpBRGhMZURvai95dkZpMS9oN3JR?=
 =?utf-8?Q?AGR7kBEiyXmL/JCLfN1GueNSxe7HnGKufgw6swn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700324dc-d36b-4a6f-9a1c-08d8f5742f99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 01:11:04.1072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5876TXEvranZAMV1Pf3WNq9JkG2X/3LoSC7qXnqiKyiNPyCWLM6Bw1oQHqISdc3rvKe79erDySOZGbQ75gfoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============1617600273=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1617600273==
Content-Type: multipart/alternative;
 boundary="------------F00BE4AF179EDE2C0D71666B"
Content-Language: en-CA

--------------F00BE4AF179EDE2C0D71666B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Everyone,

On latest amd-staging-drm-next, the below patch is causing errors at 
boot time and should be reverted.

Error on boot on Vega 10.

[ +0.007084] loop1: detected capacity change from 327992 to 0
[ +0.244709] amdgpu 0000:63:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] 
*ERROR* ring kiq_2.1.0 test failed (-110)
[ +0.000220] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
[ +0.000164] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP 
block <gfx_v9_0> failed -110
[ +0.000143] amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_init failed
[ +0.000030] amdgpu 0000:63:00.0: amdgpu: Fatal error during GPU init
[ +0.000237] amdgpu: probe of 0000:63:00.0 failed with error -110


Culprit:

commit 08410e955066bb65c258ed1409f3fcbaa0b83209
Author: Peng Ju Zhou <PengJu.Zhou@amd.com>
Date: Mon Mar 22 15:18:01 2021 +0800


drm/amdgpu: indirect register access for nv12 sriov


1. expand rlcg interface for gc & mmhub indirect access
2. add rlcg interface for no kiq


Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
Reviewed-by: Emily.Deng <Emily.Deng@amd.com>


Please revert this commit.


Thanks

Rajneesh



--------------F00BE4AF179EDE2C0D71666B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Everyone,</p>
    <p>On latest amd-staging-drm-next, the below patch is causing errors
      at boot time and should be reverted.</p>
    <p>Error on boot on Vega 10.</p>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px;">[ +0.007084] loop1:
      detected capacity change from 327992 to 0<br>
      [ +0.244709] amdgpu 0000:63:00.0: [drm:amdgpu_ring_test_helper
      [amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)<br>
      [ +0.000220] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ
      enable failed<br>
      [ +0.000164] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of
      IP block &lt;gfx_v9_0&gt; failed -110<br>
      [ +0.000143] amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_init
      failed<br>
      [ +0.000030] amdgpu 0000:63:00.0: amdgpu: Fatal error during GPU
      init<br>
      [ +0.000237] amdgpu: probe of 0000:63:00.0 failed with error -110</div>
    <p><br>
    </p>
    <p>Culprit:<br>
    </p>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px;">
      <p>commit 08410e955066bb65c258ed1409f3fcbaa0b83209<br>
        Author: Peng Ju Zhou <a class="moz-txt-link-rfc2396E" href="mailto:PengJu.Zhou@amd.com">&lt;PengJu.Zhou@amd.com&gt;</a><br>
        Date: Mon Mar 22 15:18:01 2021 +0800</p>
      <p><br>
      </p>
      <p>drm/amdgpu: indirect register access for nv12 sriov</p>
      <p><br>
      </p>
      <p>1. expand rlcg interface for gc &amp; mmhub indirect access<br>
        2. add rlcg interface for no kiq</p>
      <p><br>
      </p>
      <p>Signed-off-by: Peng Ju Zhou <a class="moz-txt-link-rfc2396E" href="mailto:PengJu.Zhou@amd.com">&lt;PengJu.Zhou@amd.com&gt;</a><br>
        Reviewed-by: Emily.Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a></p>
      <p><br>
      </p>
      <p>Please revert this commit.</p>
      <p><br>
      </p>
      <p>Thanks</p>
      <p>Rajneesh<br>
      </p>
    </div>
    <p><br>
    </p>
  </body>
</html>

--------------F00BE4AF179EDE2C0D71666B--

--===============1617600273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1617600273==--
