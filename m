Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C38C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFF522D6D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFF522D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7576E5D1;
	Tue, 19 Jan 2021 01:01:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DCA6E5D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 01:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHvS3uP2Ws+uGIspZrt4aY6I/eljNL22nuRXZdc8NfAYxfPgF5O//fSVWTW/yBrFUNrxCDHppiqv5bdmbFsr8I6YIfSNaT0l1I4Hlb+YIXHIuOZrvrbOnYptxcWoDELvBkPVbLrk9Xyz2c+TpkYrKmTVqdIVpVq1PLAT4dZRTnKFSYuqQXF7yX+TYI3flX4J2bm+VT6fTt7DlqOd0/AKOf7BCUWOj2ROo+bG39IBzA7sfpTsuSRT5c+FWzkX2UZMrdR7wkYhRe5Da9w32fMBIpMUnR3TRaAuBaeoTT0etpuuCUYSg6DG69y03CBUpYoEik/68oeKhALcDLN6Yv3iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6WAe4TxiEJrvqjgwF0Mvn+Fz7/rDe4AQy5Q12Gh4wE=;
 b=nNT9oyFUL4ciTn7CHmHHa12oKfW0Ar4WqkkWmxyJo8VTzn/e3GPQz22mwrsFo++IDFxxE39C8G5P8ZyddHg59UdqB55L85qcEyIR2rUgTlcf+wZTQWQJ58a7uD4wS2VLFIrce3Mwow3n76JWdctGOHTgmeLT0bm/oik5/8P0n//oiuNVW7gha/vvZ8g+wDGZjSC7LZJchaEl2D0zsaEFevK4muQ+pMW5bPAc57fdZwdxGERGMoUWW/wYAJTkgztaJ1Vxq+Xs7Bqo6p9hbChWGTVnD39R4gRJw8sDFvAF81YLPvNs1pcz8+be2zUU/NRmKoN86yGw2tl9/VplU/4zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6WAe4TxiEJrvqjgwF0Mvn+Fz7/rDe4AQy5Q12Gh4wE=;
 b=ls0PGcbJqDwAgn3Jgm2n+XXZXXnTIvR9keVVv0BV4c1hPQm0/ChM2hgkE3XitcbpBhJr4E5ocCS272O0CbwJXKMBnl7qzgdN9j6RQPjLGeT8RFuBSWcIjO8Fq+bs2zPV/w7nw+89ZTFi9dWfZtVJM8df01KF+Hnzx6/SH1xHxdY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 01:01:37 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9c57:59fa:b83c:2942]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9c57:59fa:b83c:2942%7]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 01:01:37 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Enable userptr support when KFD is
 enabled
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210118232824.32649-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <d11b2228-e3dd-0dcb-d497-2242ab06c917@amd.com>
Date: Mon, 18 Jan 2021 20:01:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210118232824.32649-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 01:01:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60430822-9c2a-406b-975b-08d8bc15c5c7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02040704F797BC51D23A62B1E6A30@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW0gPLwiXKFj9D8l8l2cmSkzThe3aFzbuitA+2BBT/5Id6M0sacfFyoRQtYuQOtbEGS1L503G3W0Bg0y9ReBU8zYkMKy6boNZBxHoX7+eyX38v5X81m7XGQXIKA+Ck24iNbThHLUnBajQoXFp3MBide0KQRlaLYQWF3d/XLjFsY37gBHk4mBKphxxbin7UqU9O7kppbPC9bvGOVskbfaX0XIfCmkF1HNjy0QSViJTrJHw3NlZFv0ufOUtnEiAA+eQOLkUuJE6xSpda+ZkrXQWPyQtAkDbDgIYMn+gQ40hlCu5eRLrcFXBBTIsWBPKCNCdsAwnPfMPHf20HQxMuZR6kA3berbzC7nOMZ5gjXDYu1A8Kueq1s6Z90JjleoxihKf19F5F6dmER0mKe3+tRpj4DOv+Zl2O4bmQUq6WFjpabaGb029rLYNNz/S8lhaYrvnhQrsn2oy1M0aISFYUTBMSpEst20pwEkeocL7xLhAh07vnG+J6ratGU6UY3CdgLIZpdHVOUg2O+6e5pHOm9vXtLaabw3nt7rjWm7V+FRgiQbGLENp8o3g+Mi4+nyV8vBapKJbuHcu9eUy2F+sRS+kHiAs0IVCCIRHIeqboav2BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(2616005)(8936002)(8676002)(956004)(52116002)(6486002)(31696002)(53546011)(26005)(36756003)(16576012)(316002)(16526019)(66556008)(478600001)(2906002)(5660300002)(31686004)(83380400001)(186003)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXR6V1pjZXo0Q292cmtleXdmYzlSb1JkMFVFSFpuTllveW9XLzR0RytIalNp?=
 =?utf-8?B?MERwY0xMYU9QOE1lcjd6a21ZbzJKOG80MkJ1YWw5dGFLczZpaHl2bWFGZW9P?=
 =?utf-8?B?S0JpbnEzREpaS3VYVWhNSU5laEFWWlN2S1JadnZTN2lZR1l0S0htTVYyQVkr?=
 =?utf-8?B?amJaK1gvaFY3TzRuMnNmV3lLQkNPS3BWUVppbG5MM2x3RDhGL05JeU5zRENm?=
 =?utf-8?B?ckZTY2FZODRVTlp5OC93alNJNXF3U21XT2F2THR4cC8vZGhnWUd3OGtNYVRO?=
 =?utf-8?B?UmJoaHgyWkVOQ3J1YmFxSys0QTRVem1YbVZha00vWGw1dy9aUDl5UHA1Y2hD?=
 =?utf-8?B?WmZSLzh6Rk5aNWRqWHc1RXFXRStYTExGRGNxQ0ozMkloZHF4T3lXNUo5MjNH?=
 =?utf-8?B?dWhhRmE0dVJFQnZiWndDOUdUaVZKcXhEaXJ0dzFOVzN0MEQ5SjFVQm9BWjRu?=
 =?utf-8?B?UlYzc244QWNhVTJ2eXVLQ0JaSDI4c1NFNkdtMVlPdUlBNHFLbU5BUnVNT3BE?=
 =?utf-8?B?VUd4b3BUSmR5c0RobjZGSGxMU1pjTnprQ0V0bDVCZnJIRmRPenRta3p5SlNv?=
 =?utf-8?B?ZlI4dE1zbVY4cGFpZ3pBcHI0QWFWNm5PZTZNUXYwMlhuSjRWN0poNjdPSTUy?=
 =?utf-8?B?U0UvUXJ5NkxpQ3RjanpZVXd2OW54bi9VdDQydnFNa1pjT0RncXhiRzBRUGxv?=
 =?utf-8?B?SEIvVTZ3WGlZeDdocHVYK3RmSDZ1SFVHQk1wSVpoMTM2NVlKR2E0Y1VKbW1W?=
 =?utf-8?B?cUVlcWJmVURVc05aVUVKU1g0b2lLcURVTTFMaWVBcFlCQjRya0dhYWc1d0x6?=
 =?utf-8?B?MTl6V1pEbi9YWVRwd0ZUNGVIamVNVk5BVXBKb3FyK3JVdFUrMGhwbS9iWEdi?=
 =?utf-8?B?MDFEa3NTYUxpZGxzdXNhWkVMNHZVRy9WTEJPcTBoc01Ec3EvZ2txU1ZuczVq?=
 =?utf-8?B?dWJ3cGNXcm55bVRDeTRyOER6cEJ6cStFaTArWWF2ZDZlVWJQQmxWcW1Gd1dK?=
 =?utf-8?B?Y1BaaVhSSTVhNU9pdE01WktHNUdidGtvcEpEU0tFN1lVdE91Z2NxRXlWazlS?=
 =?utf-8?B?RzB2THY3NDRtb2NVbndXc0Fnb0ZWSGxiTjE3YVJNaTQ3Z3RMTXo5bEs3WEVt?=
 =?utf-8?B?Y0pHSlNXd0c2MEU3NDJoenN5bFNlcVVSeVg4eFowNDBvYmMzRk1SbVN0SFZr?=
 =?utf-8?B?TXBqQkhONk12clU5cGw3MzZRekVFUnNCUjVFREpxUnduWGVtc0lvU1o5YmtO?=
 =?utf-8?B?RVAzRVdiVzE5S0hLcXBQNHpkZ0xQNG5zT3YwdmFxaHY3VFZFVmpManZqamsr?=
 =?utf-8?Q?ACukSJIxyNKVdJ5zZafKoevtX8ZJVxai0I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60430822-9c2a-406b-975b-08d8bc15c5c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 01:01:37.6699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqHedMa4RHJ+uQ/XH82zWm7hiX7ZJljdyiBOPAAbHjfTeUweUEVykXrDWrr7Fru0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
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
Content-Type: multipart/mixed; boundary="===============0770926949=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0770926949==
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-01-18 6:28 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210118232824.32649-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">ROCm user mode depends on userptr support. Without it, KFD is basically
useless.

Make sure HSA_AMD selects the same options as DRM_AMDGPU_USERPTR to avoid
broken configurations where userptr gets enabled but its dependencies are
disabled.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index e8fb10c41f16..f02c938f75da 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -7,6 +7,8 @@ config HSA_AMD
 	bool &quot;HSA kernel driver for AMD GPU devices&quot;
 	depends on DRM_AMDGPU &amp;&amp; (X86_64 || ARM64 || PPC64)
 	imply AMD_IOMMU_V2 if X86_64
+	select HMM_MIRROR
 	select MMU_NOTIFIER
+	select DRM_AMDGPU_USERPTR</pre>
    </blockquote>
    <p>amd/amdgpu/Kconfig select HMM_MIRROR and MMU_NOTIFIER if
      DRM_AMDGPU_USERPTR is enabled,</p>
    <p>I guess select DRM_AMDGPU_USERPTR here is enough, HMM_MIRROR and
      MMU_NOTIFIER is redundant.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20210118232824.32649-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	help
 	  Enable this if you want to use HSA features on AMD GPU devices.
</pre>
    </blockquote>
  </body>
</html>

--===============0770926949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0770926949==--
