Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F09C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 15:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311610E8DB;
	Thu, 24 Mar 2022 15:03:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0052E10E8DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 15:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1RJaSvAoCIBZn01AUZKGgk+PgjWOnshwR28xdA0FNB63GZ6Vsu+N7cp+xCp+A3tyHqXnQsXtPa/c2TNIdlNpHz2R+iUTYljQVGXSd6mfXlGjOzswUpa7KI9YptGV2XaruxDkv11n3IRk7d1V6g+mmZuvpE2vrOPsQfd0MO+YXFUfN+KZ1E0z/uP8CDsIILp43dZe8lrg7xQ1ih8v0rwWsl3a4xm93kYfabXERMxfxDh0Rs6s4fDZBBr8gx/B3g77bx9RUck8ostUOcNFA0s+QxrcS/M5eMH3VtIDOp5KHTzFFrxJ37/65MB84Oxbr1OQZ77qyoF//3iRJqYVj9bKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYhMW/Vdu3vtdvhMMZFT83/f/ZBbejNTMGu77ElzxJY=;
 b=SVs2TgmPnMIXGybwf/DH9T0zHSb1Q/FCbL7hoxLRKhNWG+p/xcmsZhOoVCbdkcQYXKJ16BfLUNUsfm8hSMGX2IlAIGGu/e4xZzj20IrOIjHIYl7g28gxmfhcr/OGeqqp/meDCzFEk0Ouoc5fXk29l4FkYKzpOltIMwp6sMXE/N0HYbsvnW/bsIHtARFyRH+AndXzRlrNGR/lyy3XV2rCJtS2FYMGLh+2+NhGpP+RoolZiCtOmAeAz5fpXKb0qX7dL6D/g84W3Y81yPHjUyph/VtEiiz5JpSlHn8hdwn/NJqZKyDs1EbGQv0GuqsdiTf1vqPmSBz3Malwh9k1oElpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYhMW/Vdu3vtdvhMMZFT83/f/ZBbejNTMGu77ElzxJY=;
 b=tn5IaQTrdbZMvj4EOR09lXHERQfTKrxxl+i/YptoS7LXMFV+WRX269v0rL4W55FAlTCDFLYYdiH2luu1Tr6RY2yubtWc1Iz9Lev2V4vpXtLj4HNCD0nFpr9Ajt+ICZMb5FIhDQtoierm2VrG8k6tHz5VoeDwt6B6BpPCj9C8zpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 15:03:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 15:03:06 +0000
Subject: Re: [PATCH] drm/amdgpu: add missing NULL check in
 amdgpu_vm_update_mapping
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
References: <20220324081337.2064-1-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <a1a7829a-66d7-c99a-ead4-3152ead1b2fc@amd.com>
Date: Thu, 24 Mar 2022 11:03:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220324081337.2064-1-christian.koenig@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0025.prod.exchangelabs.com
 (2603:10b6:207:18::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f1c552-c57a-4ef4-2141-08da0da766f4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23505DCE09319BB8D02D6EC6E6199@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGTf5xMi12QZn0YS5F5ntZE+5xRsG8/EgyVLfevX2IDSCkAunVcz1np++vGSTVTolTryJG83Lo4CiS/LdZAYAOjTXkSPMwidWuLmfNl3eOTd9jgVSdrYjUVuzcNzEKqB+g8QHrZgJhoQjokO0SDO2dD5MZCY6oziRFqLhUDYwr2qhqNCfY+HUiCWqx9H4GyIcQKFj3Kot2qAbV2R+3L6rQvl0MKJMw9IcUVEq5/d6wg7xpbFhR9FXC4d4GjX7SXRJDFLk3nO5tksz9c3Kf2qnbTYE5xLnVkwQr71G4VJvKU6gTWE3PlxvlwXjoq5ODKrKh8EcfFdjuBdLAg+rGJOMKohnl6jOfA/fRVUUpYa5WO0k4WttfOf54vAM/zGESbCySmec1gg/3O7btYTitGm0tKFGJ2z7iQnsIPZqXMPIC91ipfRh0fn2JtZecoar//8QygNa7tF+ax9+7oQAx0jAsc99UkKILwcyXb+QEI9AZ1/yx3AVpoxG0YFU4An/59K0vh3O/VPBiSLADBCSYric5fxh2dlxLeYSChnELWBmiiQwrCLda0os7UlTzk7O1l2nbX61NqDl7QriO2IwDKHAKu5pPYBHZI4XJvaFKaxIOA3Y4EwYZIsgV5dabuNJ/K2PPBC6OKOmrpAMco6hJlJNbd2mxSF8JU86Nay7Hv7pPOHsW8EEubq4Et6EncQIskfvDfmdsFQ3/wxNg2Z6H1cPIp6ABR2wmfdsgBavRQRHOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(66574015)(53546011)(4326008)(31696002)(36756003)(2906002)(6506007)(31686004)(66476007)(66556008)(66946007)(38100700002)(8936002)(5660300002)(508600001)(6486002)(6512007)(26005)(2616005)(186003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3N4cjNuVmltVmxRSm1KalpYN25obFNPakhqNlRqR2JZSjZzMTNHajloZWpm?=
 =?utf-8?B?R3ZOeW9hQUFvVTV1NGFTVlJRc0NYTGRwT21ISzR2ckp0M0FBa2pCc1doV21C?=
 =?utf-8?B?L0RYVW1pZ3dMSkkwbUFCWkl5a3hQMVBpR0dGNVhrL3hiSEhPRGhTU2ZqMk5j?=
 =?utf-8?B?MlNzZzlOaGdDbys5OE9heW1hYlJuU3FHQ255YmNQYU5WbHdRM09FdmNhVnhZ?=
 =?utf-8?B?Y1FLY25pY1JTbjN1dFVVR0lUL1BRbnBpRmZ5UEZrNEFDNkxEa3pXRFJERFhL?=
 =?utf-8?B?TFhVUzE3OTdiTjV1clVYV2FyOGxDeU5IQjAya2dldDBWajdyblBuQ0Rpa3Ev?=
 =?utf-8?B?dVBKeXVtSFVKZ0psN2ZENnl2VURacmx6VExKc1A4YmMydGxINXFrMVRYRHNj?=
 =?utf-8?B?cVNnRkExMTU0MG9GbDRmTzlYSlNLVUU3VW1rRTloSTRBVTBVdGlSQUZSK1RY?=
 =?utf-8?B?M3A3WUFSM3l4ZnlRQzJIZ0xvc2diRytielA3Mk1ZejRWZ0NIT0dwUDlPQk1Y?=
 =?utf-8?B?Smw3NXowNGtBdDk0SEhtNWplTXVnczNGakl0N0MxMnVldkw5b2QrY2NrQTJH?=
 =?utf-8?B?dmhBVmQ5cTFzQUhIeG8rdTkyQlh5QUdORUxKNkIxYk1aK1ZIRXZCU1Jiakwx?=
 =?utf-8?B?Y0tBRTRLaG5SdjhmemxsaVQrWFBDankvSG1HckplYzVFa0kvMDZSS0krYmRE?=
 =?utf-8?B?RDlLOWtsajRoOXc0Tml6YmNMK3VoK3dRTTc5dHcyc0l5SUtvNU01MjMvKzJr?=
 =?utf-8?B?WDFtenlCbFIwSkNjcGdVN3Jrc3p3V0pKcy9rTng0SXdMMXVVSHVCSjJqRmND?=
 =?utf-8?B?eVlmTmhpWWx4QXRRdXZ2eE1rdmtVcnZ0L1MwTTBHMGFEVFNLNzhIRGxJakN4?=
 =?utf-8?B?bUZ4UEVLWjdBV3RtK1BzYXY4QWQ2Sk9FSEJoa3loOFBtT05BYXFUYVVXdTZ1?=
 =?utf-8?B?Mmo0WWlrODlOMVJmR0czSWtQa25vUUYxSHg2N1JMQlpIR0UyYzk1ME1DREhI?=
 =?utf-8?B?dzl2ZkVwTEIydysrWWJ6ZkFNaWVSbGdaTU82T1lVL0FyM2FjcGFhaENDK0oy?=
 =?utf-8?B?R1RvZ3RxbU1YdHNSS25TZC82eEMrYzB3WkFvMG9tU3VWUEpEdkhYdVI5SHZU?=
 =?utf-8?B?ZzQ4UXdMdzc1ZlMwdE5XR080SnpWbXFoMHZZcWxUQ3JwZGNPQ2xycWttcTQ3?=
 =?utf-8?B?cXRXdjJpb05IUGZhQVVSbjBwcUdrd25Sd3FHQzZjZU53blBXbi92ZFVnWGVH?=
 =?utf-8?B?UU5ScldEUUxGNjNpUDFUR0pLaGhGZVhwRWo5WlQzRkVnVUZ3MFFJS3BXRzVK?=
 =?utf-8?B?Nkp3Y2NpWTZPWFZNenNodkZPdGYzNUJOQ21zdlpVamlkQTE1R0p2THhHMDVQ?=
 =?utf-8?B?MG4rSkpzT0lEZCtodHhqUjkvejlyMnViSEtodW1DN3IvK2FzbzI3STN2MGdP?=
 =?utf-8?B?VnZNa1NxZ2ZLLzhteU9JTUpNTEJQeGI0UVFYbVdlMjcvS3E3T2hYZnNIREpK?=
 =?utf-8?B?T2Vpdzg0cEI0TDQ2MHQwakhJN1pOeXhxNGVIUUE4eHY3QXA0ZWVDSlZSSXFF?=
 =?utf-8?B?ZnpxZmpORFhYUk1QbjR1aWl3Wm5VTVZXRkhmN2p2dThRbWZuRlc5VHc1Zmln?=
 =?utf-8?B?V2tjNk1zbGxiZXhzN3VLRWRVY1YyQ0N3OWZRMjV4Wi9uTGV6Rm9ZbitUYW1P?=
 =?utf-8?B?RStRSHR3cUVXeFRCZExwNEJRUytIZS9PSEc4bWxLa0VvdjUxdXBPdXVVT0M5?=
 =?utf-8?B?QnhlYXFJSzJOR2IwZTJGbGlSdjMyMTdKR3FyRzBiN2FVKzk4RDAxdGprbmEy?=
 =?utf-8?B?MVJMVlI1NDAzSTBBRlJSTXdRMXN2bzVHc0p3QnNTNUNkUWd3YXg1NmVwUkts?=
 =?utf-8?B?d0FrUGNjVEZYMnRiN3VTYno4QTh5M0YrUWNSaTRielpEUjNLTkE1Q0FLMzlQ?=
 =?utf-8?B?Q2kyalhMYm0zSDI5dllIS2xUVHVoWkpoazc2Y0MxRFZqRXJFSFdwMFNPM04v?=
 =?utf-8?B?eHNXSzFCVGdYM3QxMXhPUzRBMVp2SFBJM2hoNytPUTZETEJabnZJY1d2ZTRX?=
 =?utf-8?B?bTVwK0ZGZDJHSlh0UVRLK2dWQUZwT3VNVWhJTnlSSFNXY1AwQjk5SDM2a1ZM?=
 =?utf-8?B?L2J3b2FuRjdIWCsxc2FPUkNCeHhTQ3N2M25OZWtNcDVVL0NDblBSSDlKSk9z?=
 =?utf-8?B?Slp5ZnpEMVM3VGg4S2s1UmtYaDZEaW9ueVhSSUlHcWpvUnlDQnlhUm16Z3Yx?=
 =?utf-8?B?bnJZaHNXRE1teUtMWkEwWGpYVlZBb3l2YlpmZ1h6ZGR1aGlVRmg2Q0lPd3NQ?=
 =?utf-8?B?azl4MHE1RVlsQ29PK3o3WEJieThDMEwxenl1MTNFeFY4d0NVTHFGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1c552-c57a-4ef4-2141-08da0da766f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 15:03:06.8396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYHF2GUpcy+H2XNW6sVs1ETFkc16viYPpdu62UnrPLmFwHTzxQ2Fzj2VcY7QgJ43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Reviewed-By: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-24 4:13 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220324081337.2064-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">The fence parameter is only optional.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Fixes: 86fd5edfbdae (&quot;drm/amdgpu: rework TLB flushing&quot;)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c29b12fec863..48f326609976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -929,9 +929,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	if (!unlocked &amp;&amp; (!(flags &amp; AMDGPU_PTE_VALID) || params.table_freed)) {
 		tlb_cb-&gt;vm = vm;
-		if (!*fence || dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
-						      amdgpu_vm_tlb_seq_cb))
-			amdgpu_vm_tlb_seq_cb(*fence, &amp;tlb_cb-&gt;cb);
+		if (!fence || !*fence ||
+		    dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
+					   amdgpu_vm_tlb_seq_cb))
+			amdgpu_vm_tlb_seq_cb(NULL, &amp;tlb_cb-&gt;cb);
 		tlb_cb = NULL;
 	}
 
</pre>
    </blockquote>
  </body>
</html>
