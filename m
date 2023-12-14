Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CAAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 18:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC1A10E20D;
	Thu, 14 Dec 2023 18:45:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A72B10E268
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 18:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd/KwXzVzCthxNM4hRZh3Z74D9IbZcVHbR7LIgzRYW4TjAPA23IxSRjMWjwW7gVh/FOKhagcBuW5OD947P+TN+yH1no/q6aQwDqqXZDmJyjcjqlhgId1ryod/pWyGpTwqPC20TI2zJvBXvv2KW8HN8gUHOySSFyRfO4eYFFSSLCS5JXql3ab1p2t5UcwDSF7Mpj6pXLTGKxBU6AhIT6m8oTOe/woM9xUS4tu+lA4Cysct2PH4QcuF1XRygkuaz6Bl0X0LvaBitfp0ijyKqF53ndb7ea8d1ppNvDT0Zw1Cin9jROEM5R0uGc1CM8bWa4XxtjvbWFQXULeqc/USzbZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBDeccwt9+8M6JeXDFy+/3Yr7116VmW8VTBcxe5OGrE=;
 b=NfyZ4VrepzW6qTs3cjAD3u77Sj3ki1K4aCxycCF8NpbR/JKFsherccJbcpmqF+I+2ZjeH3n1J0zQ8+NhwsvrSAhfHLgH8HhnpDI0CwVska9UXji0EgLDPDNcmAk8fx/3esk5PCk6t74094Z1H9kRYZU6LYKTegWz/tj/UKtY2thJasi2d8/NNfc5l6+ixipSll+fq6Jb3qteKrBMv+u/0JiXRkFAUMs55GYUFUkqL/DNyTRZ04KAccUgikU80R1Ret+JI3HQUCuQVgJ6DZwhi37vHtPKkRnESyKsex8ngL30dLYwudUgAajtIZFOGC+5kStb7tZbel3o1oemJjQzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBDeccwt9+8M6JeXDFy+/3Yr7116VmW8VTBcxe5OGrE=;
 b=3vV9Srvj+c77GUum1hBxc7avEQSfzoCKbW+PvAdhsJDNk1yG7zz0w1Qiwvg4FHBN1WulpQ14ogfM+QAovS86CzPGc4ebneXQO/XrsAUoC42eeoZzaxZaM+8BKsvfCBINKcKrtvaXn4MMSkwAJALNm8MkoN3N5v4HkBrTRKVpi84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.38; Thu, 14 Dec 2023 18:45:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:45:25 +0000
Message-ID: <d61e355b-3973-f374-cb80-b556c7dc718f@amd.com>
Date: Thu, 14 Dec 2023 13:45:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix NULL ptr for debugger mes flush on
 non-mes asics
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231214183839.129977-1-jinhuieric.huang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231214183839.129977-1-jinhuieric.huang@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dc56c2-f17d-433b-52dd-08dbfcd4d58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqz1p8/J4O8SYEMEdeopThMIfoorj/Wrp5+4iv146tqL2G1AO5w93DM1c3CgNjj8MnNa/Lhn9Y3G7KUBur2DrmJmqOlq8IfmWj0JTLPGPruSqoNbsYnJKq0smz4+9SZ90OiQGDQJYesMwQ0vSONNoMA8acekuCRkKxuA/gN0HjuNVXRuBYlRG0byAvoR7qzpN41Cg2WazGH7ma0kbXZ8+0n6VE6knUHwDK0ob8974JCKkh6QdxSt4BD4fORIh/OGxW/wvvq13Zo0UFbMZVrTn5Dy0mLZNB9lUFC10sDGwiRw6X2AMkr+mV1LrlTqLnZ3vfFgQqHfAp5f8ckKetH8PvJgX+ozCeJVcNZigq6U1wTGl6D/LUdCNL8UlFRzpYmXaE29XOmpilgUP0PyPjdlxj8puTygk1GV/9RE3t+ZeGHe3r5fB0Fi3Z+fNRTE9f5igj3byaMkAepMSYmmwg+j8/xht944R5oui8bG06ihf5HLnT/8BVY5BJqohWzDMcRuULr4wCt//QrytJFdeaGPA+VdxVMWbKdOLf0UeNkh1Z4GhePXrtPJ6mfqPPLi7wzJ13N6/ZTWmqz7+MZ3QMynP3Szk+EZBPQYETVJHMuDuagYcFosRdiBAT8cWSnEpinygseFAKePhCLdgpAloGYgJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6512007)(8936002)(8676002)(83380400001)(478600001)(31686004)(2616005)(26005)(66556008)(66476007)(66946007)(316002)(53546011)(6506007)(5660300002)(2906002)(41300700001)(31696002)(4001150100001)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUVGL3dweDREa0tjQTc3Q3V0NUVtVzE4RU1YWCtyL1cvd2FHdmp3a3ljYnBK?=
 =?utf-8?B?RnFkQlBEdEM5WThxc1NieFBLMkRhdTZTNmNTa2hocEYyeEhoWVZGbVJWNHhD?=
 =?utf-8?B?cTJyMWpEUkt4YWVzUmhpREVCdHhBRXFRODVmam1lNmFpN2pzQ0dtSGFGYWFu?=
 =?utf-8?B?Z2d3VlI2dXl3Q01xZ0RGSlMxbXBKWldwaFNDRUphUE16TERqM3J4dTM3S3Jo?=
 =?utf-8?B?eFpzMHpGeWRRWUZNbkdadytQeDNURitqVjEzZitrZW1SU294OGtKQlcrZDZR?=
 =?utf-8?B?azU3dVQwVHkvbXBTNFpCREFWdWxSUjRCSnBEVDg3VkxTa2I1ZzNTOXVrclM4?=
 =?utf-8?B?YTRlS3Rrd0Qvcit3cUMyODFXOEwzRmw0aXYyaFdaeDRmNC9vWGl5SU90eGlV?=
 =?utf-8?B?N0p3eEJnZWhXZHZuODRzdWQra2lLVW0vaUtwMmZyQ1ZrTUFXU0VKTkN0Q3NL?=
 =?utf-8?B?WmFaRWRrMVdQdGgrNitiNmJ2RnlaNXMrRDljS1YzbEtvbVFiR0g5eG40cFMy?=
 =?utf-8?B?YlNzcTlSMlA4aHVnQ0x4Nit3SjhlRk5wNjRGdFpkTEtUQVlTbURlcFZaa3c3?=
 =?utf-8?B?c0JCajdiRmV0MHhDS0ZodlhMcVdBenRlSVhJbUtuZnBCa08zVVF4NzVUU2cz?=
 =?utf-8?B?Y1pqc1VFNVl3M0hGemsxckh5NEozZHdtYm1aL3FKeUR3SXZJMzZodTUrUlEx?=
 =?utf-8?B?V1F1d0FrelVHR1dJNnh1OG1LV3FOUW5sUXUwSXRxNTI4R1R2T0FVdnBOTWpJ?=
 =?utf-8?B?anVYaEphVFB6aUpuc0U4cDdTMWtVMFVqb1BvbzVKdUt2WjhOL25YbUdJSmVF?=
 =?utf-8?B?V1RQQUxiSFQxRi9MZXc4R0ZOMENXOTdDLzNsVUNoWE5WOHlqalFRSVI1NytF?=
 =?utf-8?B?ZjArdlFFQmN0ajdQSmp1RVpDZ2VmaVpqb2ZOYmdRWENCOWplRm5TeUFEWElU?=
 =?utf-8?B?UU14SkVROTBLU2pONW5hK3RaWHdjVTBXK1Z3b1pCRjBNZ2Foc3Q1RWNPaTBE?=
 =?utf-8?B?WnRIbFBndmdLMlJWc3ZXQittUUZHUDBwODVWU3p3b2U2U2YyVGdyUXZXTW40?=
 =?utf-8?B?aWs3SkFUUmdMbjNPZGV2QXFiWEhaRkR0VjZUNVVYdVNWQ05jNzhkNDRmNmNC?=
 =?utf-8?B?cFVDVHUxWk92cjRBc3BGYSttMnFWZlM1TWJXVk9jMVhSMWZCVUo0NWdtaFhy?=
 =?utf-8?B?T2ZrWVZZOEgrVTNaTUFsbVg1NVplZVloVHVYWjlhbWJvSjdMdDlWUjJwM2pl?=
 =?utf-8?B?TjgvZmNCbyszVHVlblRHZWozN0xkdTFEWnBiMUk1WUJYOFBUWTdCa3hIL0tH?=
 =?utf-8?B?STZjSThHZHRtVDJuYS9YVm1oWFdPellSV2tsOWtkZ3NqT2Z3OWdQc2ZLaHph?=
 =?utf-8?B?UmR6Wm1SRmx6cHNmVXhCcms0R3QzQllCcnU5Y2YzSm5EVUduMm1XbCtVR2ZU?=
 =?utf-8?B?ZE9zRzdwVm1NemtGbnZTTGZPeDNlUkVOaDZuaVM5bk43U0NHeExHdDdzdkdQ?=
 =?utf-8?B?RExWa1ZBNHhHVzNQQ3ArS1dOK3hmWjN3QnRoa1Rrd09HREpMYTNuUXRJMkRX?=
 =?utf-8?B?YXpob2xNMGpLOW8zTFgxR3U3R2RKb2RXUSsrYkxES0s1bTUxVmYxRml4Tldi?=
 =?utf-8?B?T0s1ckZITGhGNEtIWExKY1o4dmxQNjJWQXFSdnp6VHp4cEd5YVZwNjdneDd3?=
 =?utf-8?B?ZGdja1dzS0lNWm9YM2U1Q0FXRFRHd0I3R0hJb2Q0UHF4Wno5VEZQUnJZWGdi?=
 =?utf-8?B?WjdvR2JqVE1oaUpCL0wwU0xtRWRFVTlyaWM3cnN6SEhtS2xLYUI3ZSszdzFX?=
 =?utf-8?B?SHRTbFdzczlFdTVjNnJsRGI0WWVpZkF3S3BBRWUxUnJmSXNYL1pzWkVkL21l?=
 =?utf-8?B?TmM5b0Jja3dJNzV0UzFDcmhaL3Uxa0FsRTVsLytiM1l6dTBRREFLNko3WFoz?=
 =?utf-8?B?bXF1a2o5eXNVVENtekJwa0pvdndKV1RTY2x4LzkvL3k5ZW0reVFvajRTOHFa?=
 =?utf-8?B?SFkvSzBZb0F1dmRuWHlMVG5IZHdtNnNtUDlxQlBjZVhSUTI5RllLZitDSEMw?=
 =?utf-8?B?NDdWckZNNUR5eVpQTDVwL3hMUU80QjJnT2pHR0hrQXFlc2s4SFJ5NVJCZ25j?=
 =?utf-8?Q?8Bb0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dc56c2-f17d-433b-52dd-08dbfcd4d58e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:45:25.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTh2/NqIBMuoBOgQa8d3//U0qFbqoCjmf2eW7wB/arL0Kd2wUQpzuSxdB68gZJHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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
    <div class="moz-cite-prefix">On 2023-12-14 13:38, Eric Huang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231214183839.129977-1-jinhuieric.huang@amd.com">
      <pre class="moz-quote-pre" wrap="">The field adev-&gt;mes.funcs is NULL in function amdgpu_mes_flush_shader_debugger
on non-mes asics, add mes enabling check for call this func to
resolve the error.

Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a>
---</pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20231214183839.129977-1-jinhuieric.huang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8e55e78fce4e..43eff221eae5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,7 +87,8 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev-&gt;dqm-&gt;ops.process_termination(dev-&gt;dqm, &amp;pdd-&gt;qpd);
-	amdgpu_mes_flush_shader_debugger(dev-&gt;adev, pdd-&gt;proc_ctx_gpu_addr);
+	if (dev-&gt;kfd-&gt;shared_resources.enable_mes)
+		amdgpu_mes_flush_shader_debugger(dev-&gt;adev, pdd-&gt;proc_ctx_gpu_addr);
 	pdd-&gt;already_dequeued = true;
 }
 
</pre>
    </blockquote>
  </body>
</html>
