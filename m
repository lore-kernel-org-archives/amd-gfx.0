Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E86C2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 15:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1DD6193F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 15:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1DD6193F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FB06EDFE;
	Fri, 25 Jun 2021 15:32:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483066EDFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 15:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8cETDLMz6v2VCLLKNpjMOm85AV95mxCxw9//Qw2O8LniVyWGPLKlliEKJY/Dki45jLegnLHvaYQxZU8DztMtEJ+yg8EZfIvJj726qonTZwqXcda+WJkljC1hNjT4S9QkItzlZ8omyl23S9EEsHg7WWjYRB7M1PHtu5ECbIABpheV8nUjnCz6GFoQzcupsjIVCE8BWgHQxgoLMfd+o5bknlxIM3GoJGPPOd/gB60wQcdhCVK//I3Dyqw+aql7EEOgHyMmAJCAerBdtWMwnVbm+3J4X1xse37PN6Qb6OGlWiEHPBMB7GvWrJJ5L9db5ocrHw8gWD0Co31wM0FTiXRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnyW+q3M6ubrBdUzuyDlULp9wkGMLWDFcLk8iHFIf4o=;
 b=gfT2AVL56+22Ux39I0RL64k0MkFntOZpMnLfZi0/sS3kVetI4uu3K4KHnvHB3QbPqE8ehwbfbpEciSbUVqkgJ0rxEiv9aABda5yHI3RpID5KETdivEa5dikX+itRygpJG9/yoGiXZAGm48bDH44okdqYpwPhMrUKedeDcQUQ2T86UWlVJ7FjD6PJU11CeFO6Y5ybWqa1WdX41ACBYVxiVwL1zRhbXtizNqoylHFx1wfzb7E888ySGw2yPSOrdHldNPNnncgfqxAf3wDVh8nE4mx/8k4sHk7BZ2R2ysAfrclpYwCovJkcW7VSGCPCxpIlhscJiMl4KtXNZhwTLU9WSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnyW+q3M6ubrBdUzuyDlULp9wkGMLWDFcLk8iHFIf4o=;
 b=kj06m2+VvcUvMy7DMxvfKb+kUXh0UzgaFXvF6J+x3jmUibGt7QItoNayUQIJ2Ffr+jtFmUAxFRY9TwlZvPlwoNAmsv5i5slTsEU3HvwUpNRfU+0+kkPQTkfRD0Aqr3FqSaivDXv/5YsaH8vj4CNx4JarCkRnpQOBIADOcoQCOBM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 15:32:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 15:32:50 +0000
Subject: Re: [PATCH] drm/amdgpu: enable sdma0 tmz for RV/RN
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210625055812.2274077-1-aaron.liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <44d827f2-d79c-dba9-8ed3-a1a852312b6d@amd.com>
Date: Fri, 25 Jun 2021 11:32:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625055812.2274077-1-aaron.liu@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 15:32:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdac0f39-61c7-4a66-8d4a-08d937ee7dd4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42975DD48426924B7F5E749E99069@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlPAgV4Vx1NV0VnnxBk0uZDKtWv1Nd+ano/FYJ9d5UYbgOEgLdE54rjNN/+NzTYDzYbuAoQL2SyX0shl1iDAZOt+S83U8nvjxBq4QcZBT9f3fkzGRKL77fspWd96eGuL5PxxduzkW3oGC2hQW94gzY+qnrSHPHOWYzJ61VIPDlZl7d0vqtSxEw23B5AHtuO1CLFBb5AVDg48RpJgAp1Fo+u5eTJofBukOW4OOEq8vgGEAA9Y8zoy5T8MVuC5RDgGllVLhP04INAe1YWEMY1jp+eshs8xaXNLBdCg1iKEv51DiEX2ZJSPQHmD01T9Nnk3BMqGjhQYAH7whwpKtAVEQmMJPssDcClnsjKwg+mFXNWyLuhTXUxaazgD9rL8fN3SImJLIdmqOqcZBuGtvN34fmL7PWVLwMZzSBhbrJazloZVXwPJ2KLnR/pup4T2YdwoA8KJVrohemZY2Gbs2+SCR46anC3+0Z+TuIg3FaNg/gDT2zj/mLDsEBJWbNbNLGm9LwS9YB7Ag0Au2svFkSfwoX+TOPiiEDFVg4uvOwBtkgdCO9ln5ClDCDrIVrIryCY0JpxeeFAepDPaj1ry9BJ82dKiBYty6jhBgiENo4ATMoB4fZdX1tKfWk6yeCMcReKVDm/AL3QfIvbJwPtnXKbhZ4kqFkKKEuG0XhwJydv5imo4xIlGhm1Xo0JM1lgKLdRQvaiIQqgxgbaA9QfOUddN8LqsMjzuKTHR+IE/paVdznp6EexGhdGPhB8CIsDLrLWssfHej8ddsVt+5Luhuoi5EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(6486002)(36756003)(66946007)(66556008)(5660300002)(31686004)(66476007)(8676002)(956004)(83380400001)(316002)(26005)(2616005)(478600001)(31696002)(53546011)(38100700002)(44832011)(2906002)(186003)(16526019)(86362001)(8936002)(6506007)(6512007)(55236004)(4326008)(69590400013)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Y2WmZrck9pVk8zdDl4WWQ5VGwyREJYRnB3K1Bpc2hNMGMxSGFHSUJXVEF0?=
 =?utf-8?B?TVhEZnVyOGtRSUFQWjhTb1hLZWZWT3lEOFVoOVZ6MjRra0p1SVZRSStnTFU0?=
 =?utf-8?B?NkI5ZDZINXI3RkJ3bTZuWWtycTFuUGdwa2MzRTJZQ2NKUXNRS2JlZXpLUXRR?=
 =?utf-8?B?SVdRM2xoelpqWlpPS3dZZUtRWldNOFlXSU1IZ1U1a2xaZUpYclBTVjJiOU03?=
 =?utf-8?B?eUJ1QnAyUXNNbGdoTVRVdHpCS2FiR0xTT000R0x5Mno3dmJSZDlvWVo0ZC90?=
 =?utf-8?B?cVdsWEczbnFMT3p1K2hVRnREWWFEZmZNajJJQ3hmNnNhQlI0RUFBSWVsSlo0?=
 =?utf-8?B?YzUxR0hmN0JaNXZBKy9tazVjOE1SYk9jVEF1NC95Q3doK0kxbmR1YURzU2FS?=
 =?utf-8?B?N3ZuK1lsMzJJejJESm5sYnRBamhDTGdybmpqcEFlampZOGZzNXFsR2lpc0tz?=
 =?utf-8?B?UkpWb0ltdXVnS3FhU1VVRnNKTklkM0dvU0F2a2I2QzQ5WDBYYVZROStTQ3px?=
 =?utf-8?B?U1dWazZ5aHptVkM5RnQyVjFhRkkzM3Y1bE5UeW9vRGJOZk04elNodUxrUTJz?=
 =?utf-8?B?cUF2V2FqSXpNNkExVWVFUXFMblU0QUNDWmJtMUUrSUZiVW9ITWNNbXpXUTNH?=
 =?utf-8?B?dzE2bGF5Tnc1QWd6TEVYMnp3N2VTdTBURXl4eXFCbGFsR1d0VzRkSDMwbmZn?=
 =?utf-8?B?b1N2bURCbGNablVjWkovL09mVkNqNHdQeDVNZTd4WW9pUXFjbkZnL0lvc2x3?=
 =?utf-8?B?REhIbU9Vc2NmYUxPN1VVZG9vN2podDdNZzN6ZHpxYUxuMEgxTEUxd3NCMlFn?=
 =?utf-8?B?S3Q1K2xSRDZUZXdWdHJ5c29HQk1TMml6aW40eTdtalFPUXpOTFY1YTdGOTBH?=
 =?utf-8?B?RDhLeVlZbk4yMlJMc2VBd21YaXFWOWtSbXpDZlFuSlVaYXZFbWlPa0F2Njhp?=
 =?utf-8?B?eTFoNGVoZ0QvSGlZU3kvYTZEaU9RQ3ZmbU1BUlQ2NjJscGRIRndBYnVKZnRw?=
 =?utf-8?B?RHllQVZiNG52dkVhOC9OcU4wVVdmVStWRTYrb0NLdlM0VEEvQWpKUUl4YlhR?=
 =?utf-8?B?ZFBZRDJWUlVxNVYyelRVZTc2eGJvckpLcVlKZnFJSEozT1JJMU5OMWZtV2FL?=
 =?utf-8?B?OGN0emRzcjFjR25mZVM1NjJMbklmM1dsSGlieUdBekkvVS9Fc0t6clZKdm1l?=
 =?utf-8?B?b24wUWE0Ry9XZHdhM1ZGTUlteDhpY2NxWmQrLzJDNFZ5RGNORHFEMXdXL3dV?=
 =?utf-8?B?Umd2QUhMRnh5U0tuQUlheTYzaHlpQWRqaTlGQWxzeEorb1YweVNVRm92ci90?=
 =?utf-8?B?TzY4bUo1SDNlbG1OWWl1QnQ2SmMvcDA5NFlqYi82SmhqY1kvV2dyQmNyTzZ4?=
 =?utf-8?B?cnZnSkVUMUVnRUZJYThmWENpZjdHb0FETTdPdVFQbmVadzRqWDVkOTlTNThF?=
 =?utf-8?B?MlF1OTUvNG11azRBWTlnWW55T0taRDlEeldVR0xZT0FhWmhUM2lDZTA2eTJQ?=
 =?utf-8?B?RTdTZXR1WEJtcTRwZU9wakx2YVY1K3YvelpDRGNsRHN5RFpzaGhDdzZNVlBr?=
 =?utf-8?B?Y1F4Nm9nZUZpb1JKWC9STEk0Mk1WZ3BrdjAzbWZTNmdiTzdXV05hTndOelJG?=
 =?utf-8?B?Sm1aTzBvVURRa2Frd0sxZXBzNWVZSFk3RVpNcC9TMGZhb1ZHTWhrOVBIUlBU?=
 =?utf-8?B?UDhISjlwZEVSUFRXWGtMeGRjYUQwVXZzZ0RsQ2NWR2RSU0VqNjd3R0J4VjRS?=
 =?utf-8?Q?+F/aOEc/STuRxhUhLC9TTFVz4aIqnIRahPYOnaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac0f39-61c7-4a66-8d4a-08d937ee7dd4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:32:50.4310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3Lb8+hws4lVpb6Sg97SxAPSmXDXTA2jcDkbLHk5XmhHp9ym0ULe9WfLpOeo/EKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0486657334=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0486657334==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2021-06-25 1:58 a.m., Aaron Liu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210625055812.2274077-1-aaron.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">Without driver loaded, SDMA0_UTCL1_PAGE.TMZ_ENABLE is set to 1
by default for all asic. On RV/RN, the sdma goldsetting changes</pre>
    </blockquote>
    <br>
    Ah, that's a good fix!<br>
    <br>
    A note, I'd rather have &quot;Raven/Renoir&quot; so that we don't scratch our
    heads wondering<br>
    if &quot;RV/RN&quot; means &quot;recreational vehicle/registered nurse&quot; (which is
    what those<br>
    abbreviations are used for here in North America).<br>
    <br>
    So, change this to,<br>
    <br>
    <i>&quot;On Raven/Renoir the SDMA gold-setting sets
      SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.&quot;</i><br>
    <br>
    (&quot;changes&quot; is confusing as it may be used as a plural noun or a
    verb...)<br>
    <br>
    With that change, this patch is:<br>
    <br>
    Acked-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a><br>
    <br>
    Repost it with the description change and my A-C tag and please <b>wait</b>
    for Alex to R-B it too next week, before pushing it.<br>
    <br>
    Regards,<br>
    Luben<br>
    <br>
    <blockquote type="cite" cite="mid:20210625055812.2274077-1-aaron.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.
This patch restores SDMA0_UTCL1_PAGE.TMZ_ENABLE to 1.

Signed-off-by: Aaron Liu <a class="moz-txt-link-rfc2396E" href="mailto:aaron.liu@amd.com">&lt;aaron.liu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ede82e0bbd76..97d57c52bff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -147,7 +147,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
@@ -291,7 +291,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_POWER_CNTL, 0x003fff07, 0x40000051),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x03fbe1fe)
 };
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--===============0486657334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0486657334==--
