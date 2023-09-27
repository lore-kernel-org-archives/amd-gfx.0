Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24836E80AA9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 13:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED7810E0E5;
	Wed, 27 Sep 2023 13:59:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D327D10E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 13:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKl3xDCIIYPe1iARS8G0KVU5LJPDsl4HfT6uBviubS7TPul+dcdrwDXTJXNA9kepwHzZJ3z4HoxkhnoXvUCXGpYuIuM2DN4ywq2yXRJe1BUR6lg4ky794AXUvBIBP0111ZAY2IcHkpCNJHhYH+WrcmQTJyE14NPPJPc4R4kPWTeYwBe7nPIPxgHolU15Ud90NlXWIM2BY9LH9U3vcVDr7qYZtgzFewtJ7z/98Z8iEd51BvCPE4WKxz+MCFjHb+SU6GxK5pJxsaWb66dAZa/HZNj+7tv9Xcnc7N3EKXBmqwDdggxs6e8QHGLyxDzHl7o03fIDH4HgosWZHMS+iMY9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMxIuPQU6Xa57ruIWjfVT41t0rGIgZKi29mOOrnVlgo=;
 b=bDoeRiyytrnErcaFLgiXFxPuailrCW8cZMPiHg2S9xCaheYmfqm1Uuf5FoMkzBxOhumnuh6l6pMEh8yBbcdrRD/kNj0h3XfkmtKrKzyLt8Ht9vTLIhjK8ABCaN/egpWHjLStwv7eEBYPqPHeKTLxQcVHaqrmk0ml7uy1/uuqCVEuih4DWnOl0SPLtFv/YFnIPER4JOlf3vfdqdwKti/ZRdHSxzZ0rardiS9ZZVdvyRkIDqNhTy0eQIrnEpDnzq0pDckDPJEX35jBKUPffAukpoel4BpotaWMwK2pql4Psm9qA6cc4JrrkM9+hzKwQ+Jh2giUTh0XZCMTwsHAtKoYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMxIuPQU6Xa57ruIWjfVT41t0rGIgZKi29mOOrnVlgo=;
 b=OyJqgoCtR6tDgYYc7o9oGgX6nE3pLJFeevvwv0Z58LIBFDg/WW7XceK7hcumi0mrQzgl5a+9ff1Ovbu51evXVdkd93TQowFZWBgsySLVqXrvjVjJ8J0l6mTPfK6EltcdU+thmEQOmvA5fF/2z5vGdC3BoP2srAJHFXstK0fpF2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 13:59:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 13:59:42 +0000
Message-ID: <2ef0414f-01fa-3446-bdc6-f8e60573947b@amd.com>
Date: Wed, 27 Sep 2023 09:59:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in
 svm code
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230927030008.278066-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230927030008.278066-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 65721f62-07f3-4895-92db-08dbbf61ff61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MonQmnGDY0E2e2UQiJoQzss7nL6BWIWXrS5S/qvh1Ix2rgxcL+yaLuLS33ZdR7NrpVkKDgl4qoM/8DVLqNEcg/ABadrPqCqsk+xmBpVBAfnJ2L6Svja9cdAD89Em42qFJ+u7tY/hk6W5X6MiPoRHCc5hwP2K0aopYjROXIYZ6CpX2f44YiwS2VhduCHWMinw6DwND3bWN4J7SZb0mdzAwOv80zbvYiMOYeISEvawf5aKlBm137qS+kQ1ZKVZ41O/mZPrQWOm5cZ/QcqIjtPUDzbz6SIJkW4qkbkAMmDDrI17XIUA6RD0UYxT9vOF6Mlv9QnV41mkHR7GiCCLnF3Pg71FQzlEqhDa7G5XVNdvIuk79MP3d5G/j1ECb0+Ch6wSTsJm8JoikCPotb7hxHwp6UOjaziW5pUdfgc6xEB66HCfw6dOPZ5twHVKMpQwXU23s1zGoXjm8KiA1g2QNSGvb0i9cgsyg/uemeDrTdNU13KVs1kDJn5fhblXC/IkIc2/OgfgPCsQ7pR7aD2/GPcjUPq41L/1qcgkM5bZJd+CA00ACnQJHHOD/sbSyMTJq1hP+ukvdTfFg0wga35IsD0rOsiM9koLc4I41T1Bg9QfjPV+z8tXnW3ueHg31fq9bSBlKCU4PGunhhOq8rh+k157cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(316002)(53546011)(4326008)(6506007)(8676002)(8936002)(31686004)(5660300002)(6512007)(6666004)(6486002)(2906002)(478600001)(66476007)(66946007)(66556008)(2616005)(26005)(83380400001)(41300700001)(38100700002)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enl4ZWNXTkFzUDJPTXZ2UDZQVTR4ZXRYTWNhUnBIZjJ4am5oeFFPRkdGK2xv?=
 =?utf-8?B?NXQ5MUhyWGNONC9ndnhzZlVyZlBBeDkwaTEyd2FLdjhwc20wVUtaZkFPTGhu?=
 =?utf-8?B?WFplS01tbEFrV1hDRzdteU1ITE9MMm55U0VsRnIzY0IzQ20wdnhGRFpyRUtN?=
 =?utf-8?B?d2ROaXRCVHhsQUZQcjNiaStOa3dIclJtKzNMZjlVL2RKOEtmZXlESzhXTlN0?=
 =?utf-8?B?TkRoSHR1ay9rWngzbjJYSFA4aDJHWGoyZzRGdm8zTXE1dHV2Tk5KYjJvZk41?=
 =?utf-8?B?SHVpZzVjY3pJVjloZFNFb2MzZEFOTVNCbHY0YjVZanFyVjRPSG42dXp2YUFX?=
 =?utf-8?B?eFpJeVlVTG5ydlpoRUhEYVZONUdVV1B2UjRadFRBa1VWRU5yOUViWWRNeHpR?=
 =?utf-8?B?eDQ4YUhocU84eXpKSEVrNWx1aDd5OWxjMExGOEVsNnJWaGFtSk5HRTZZb1Mx?=
 =?utf-8?B?M2wvN25oVmZPWGZLYU9HajRTTTJGYTRaZUE3c0tEQVBnQ1lnR1BOU0JNdGM4?=
 =?utf-8?B?NzhsS3ZLeWNhdWlOU3BDcW80TlJyenJyMXUzOEVZdWlTMlJuY2NLSmp3eDZ4?=
 =?utf-8?B?TUROTkNVQjhtTitDSWtZZ3owNUpKbVcyS01BK3N2emFVTnVqVnpUaFFsZXdv?=
 =?utf-8?B?aFhxRGJZN0JnQlRYYnZBdFN4KzVENTN4K2RXbWFvaTlWNTkycUNnTlIrTXRi?=
 =?utf-8?B?VGRjTDRHcExRS1B2cWZNbytsT3JmQk14MTBiZFc0bFpxY3lxbVROa2FnTHNv?=
 =?utf-8?B?L3M2VjNDc1g2Zmx2V3FPUWlrejJDK2prcVcvRlgrQXNxN0JUVFFmdWRHQ3BS?=
 =?utf-8?B?aFhtSWF6VHEzZnFsd1NwU3FXeVAwaHUvZ0pHeG9BbkdxdVFkZ0d0Q2o1cmht?=
 =?utf-8?B?a3F0dEkzb1JTak50dmw2cHN3V2pmN3RQVCt6QVZRaWVDN0NBbEdPdVdsZzVr?=
 =?utf-8?B?bU5PUFRiZDlkcXpOOGl5bGFyUTJJT0o0YW9xVVJwcXVBZmRzUmNqVFh0ZU82?=
 =?utf-8?B?bnk2WFFnWEprRU9IQ2JZNHpvaUtjSi9TYy9nVzNQV2FXM2plWmxKL21Nd0RT?=
 =?utf-8?B?eGtOb3NWMTlpMVZyRG5KUVJIVDIrQkpPRjg3blRyTG1CZk9yN0JSbDdBQWZX?=
 =?utf-8?B?Q0RNblViSVlHRHNOK2Q3Sk55R0prdGJQTVVCbk9MbGoyT2xXTXF3N0wzbDdB?=
 =?utf-8?B?NTkwRlowSkZtNDNuak9wRUk1Mjc1WGUyMmZRMk03YW5WWENuY0xUdGZsWUxy?=
 =?utf-8?B?aGRvNnc4Yk1HUnBsR211L0xYTlVmUVA0OVkvQnEvdEplQ0NYYWh3aWhwV3FX?=
 =?utf-8?B?K044RGpYQlRrazZuTWN2MnVhSkFKT0lFd3ZPUk5YYzE5SVZqR3NxNjFZa3I5?=
 =?utf-8?B?d3dwdk5aYUhsYWtvbyswbnZRVEJJZ0ZKYVF5TXVVUzBpa2ZvbUp5akh3Zlk3?=
 =?utf-8?B?SzRvV0x0bk4wQnQzTGdoY2Y1T1JPSFY3ZWJMNFJUMHR0YnlnSEZkK3FRLzMx?=
 =?utf-8?B?b0J5YURiaE5VWnhnRXdwQ0FFWGFSUlBxbklrVmVwTVVkZjZoZm82MmtkdXpp?=
 =?utf-8?B?aUgzR0hpUW9MaEg1MUtWN0ZzVWVYWkpYMWZsNlUyZVpBLzBRdFA0WjY5ZkNv?=
 =?utf-8?B?VkxZZnNoOVlEUHdpU2NzMlZ3OXNydzQzaWdBaDBFZDh6YmtmbE03dW9lK2xC?=
 =?utf-8?B?S0c5YUs0d240K1ZTSUZmdVlXaGlQVkpPb3hEZUw2UE5ESUxSbk1lbjNKVXdW?=
 =?utf-8?B?NFJyV1F2Y3RINkROazZyR0x3cVl0ZjV0Zm1HV1l2V3VBZE9LYzY0VEZSaFZT?=
 =?utf-8?B?ZTd1TGUra25NSjQvYktqQUJwb1Q4cWUwM1ZYWFJEUW5rM1BGKzVLV2wra2FV?=
 =?utf-8?B?K2JYQ2MwMXlVdUFuUjRlSkVsRXZZUXJBck80OGVFZUxJSml4L2FmSDd6L2NN?=
 =?utf-8?B?bWxRQTRha0FBbG5yVmFLbDhBY2NTa1dXOUhBYzFza3JkRm96YXU1V00xZmpP?=
 =?utf-8?B?OGZLKzV1VHl6RVJKUHg0bVY2ejhtL3Z3TzVCTDRud0I5L0lyZ0I5NmtDeVBI?=
 =?utf-8?B?a2M3b3pCdHlXTEF1NWtkQXkxWUhTVUdBUEtidXh0NEROMnhZVWlxclE2aFVm?=
 =?utf-8?Q?nHi8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65721f62-07f3-4895-92db-08dbbf61ff61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 13:59:42.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu7JpHgle5401OQM1mAnphr/5X21UtilUAuIwrnoQ2LwhV0nLHZ6UHTNsDVao2XG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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
Cc: Alex.Sierra@amd.com, Philip.Yang@amd.com, felix.kuehling@amd.com,
 Jesse.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-26 23:00, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230927030008.278066-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

prange-&gt;svm_bo unref can happen in both mmu callback and a callback after
migrate to system ram. Both are async call in different tasks. Sync svm_bo
unref operation to avoid random &quot;use-after-free&quot;.

Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20230927030008.278066-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 70aa882636ab..8e246e848018 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -637,6 +637,15 @@ void svm_range_vram_node_free(struct svm_range *prange)
 {
 	svm_range_bo_unref(prange-&gt;svm_bo);
 	prange-&gt;ttm_res = NULL;
+	/* serialize prange-&gt;svm_bo unref */
+	mutex_lock(&amp;prange-&gt;lock);
+	/* prange-&gt;svm_bo has not been unref */
+	if (prange-&gt;ttm_res) {
+		prange-&gt;ttm_res = NULL;
+		mutex_unlock(&amp;prange-&gt;lock);
+		svm_range_bo_unref(prange-&gt;svm_bo);
+	} else
+		mutex_unlock(&amp;prange-&gt;lock);
 }
 
 struct kfd_node *
</pre>
    </blockquote>
  </body>
</html>
