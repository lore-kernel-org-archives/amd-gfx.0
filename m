Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA3CC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 18:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8608320781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="USWBQ+eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8608320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D3D89B98;
	Tue, 10 Nov 2020 18:08:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF2389B98
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 18:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9AkPGBtb/FLtsa+lwLySMcYT4UP6Fxzc4VTbFr1sq5u8uGvlJYKL/3FCxKGti+GcAZX0XND46m2h0CXNIgzzyh/qz1bHzD0JB01zN/cwWsN/rc8NL+dwn/LRLxbixJsCkg03YGm0B+wzokkSYHBJKtonFM2GXfQt4U5GxBW2L6N4mrQgaC/8sqlDtDh2cQT/oHKqB596Va0rhfRmcDw37TdYy2s24rN4PRUQleBOA6KAhjeUy6has3ba4SVarjnYQVP9V7K2uM3/ymdPyo82MHjpv/bBiyvy9UEhzOiXbdfJJvub932bx/7FpE/kVGosvZ+ufb3F5kYGKRaNXORlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMMmFvInZwLD+YZhfzd/wlTFroY/woEfYm3vzsOIoa4=;
 b=AjOnHimEngQniVC1lER02oo4J5A78I4n680g3wxQb03joNnxAy96tXPioxVF3Ig3+oNj/ybL8fHv5mlmjxDKoZxSlRd4ssGdwK4+cd/PE8HU76oPRFZ7NRY0FuP113x5hoG8CngrC+ShFNxWduaWNU+6fL4DAozeEmbFLjm4stDgcZDPBhlbigafMbX1pISg2xvPmY8T507hg0hZLboAXya6Up70O1/tCPQwiLYR+YWh6cgmfWEJXFcDinU1BR6i/C8WysvdNAIZ1Ih9NTJNiQFRwEtMrtw336lxXobuGwAvZc32IteaQF9JJ1sw7iyXqvvuTbuZpvo/p3DFwL+0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMMmFvInZwLD+YZhfzd/wlTFroY/woEfYm3vzsOIoa4=;
 b=USWBQ+eu1ZMn/XliBFoi5OvH4Hoh6r6cMBHYhgcQYk/92LGJsB1gXI3eBmPu2QyVcdCti735kUap6N0v0cKjOD14Pr61QITvXfF7QBPRRaNOEZN43mDUtWxyBHDhXO4WnQn41Y/rCuE4ZIcBmgE8rIAzU58RTMuXrgxV5dqzs3o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.25; Tue, 10 Nov 2020 18:08:50 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::5454:95ca:9291:2190]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::5454:95ca:9291:2190%5]) with mapi id 15.20.3541.023; Tue, 10 Nov 2020
 18:08:50 +0000
Subject: Re: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201110032033.26249-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <aff62ff8-c0d7-4f47-5113-7caff0dfe7fa@amd.com>
Date: Tue, 10 Nov 2020 13:08:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201110032033.26249-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 18:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 494ccc4e-e9e4-4c45-8598-08d885a3aca2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18823A4D50B7DC31F422A07BE6E90@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cn/d51VJA2dKTGo3aL8yyEe5oYZMli6xKAQuXBphYXlqHkojGi6jaZcs/BOxJoSP4Y7w9CkhVMoWsmZrhM4EVumPWg9INlyzqMdDSYl2vRNMiqe/Wwmp2aR6njUvjw7bvllEEyHU2tB74fyyP0oKtInHXc3xJdQg+1IYDKXN8Q39nruAGa7h0qFwLbZ8ZOWsqvHLeCQu1ODsrlIQbiVYSRVFKhwGmPWvT7FJsiKqNWf/tGNA6wJNzFXVb8m0JFT2dMZp/t+INcgefY7sHnxFiPzOo0Yasw+ToFAiEtpKwOFgcC4NQKdsduDZTfFBP4GHWCq86yG1DYVK/bPn4slPK6EDsHGiAOmwPS0jL9E2S5KJ7mM0jbroZ+/Gg/iTIn7b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(31696002)(66946007)(31686004)(956004)(2906002)(53546011)(66556008)(36756003)(5660300002)(66476007)(52116002)(8676002)(2616005)(6486002)(83380400001)(186003)(26005)(16526019)(4326008)(478600001)(316002)(16576012)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GftBtv84xzCvP4fJJFKrlgNn11E65cHN4Ip+QxFRahICN/bBjNeya5IFpEDAiHtkNLdMBysYKeqGGv736H9c9QzaqzmnKZBcPtVz0yw34fzpoQ7+3KWyegnzqcezvupLrSN22t79tP0hBxlhjBQIrtnUAuZsDDbyWwUAAxYT7TzB2bYyGTXcTQOEQOup9Mbcu9CMt2gOjBKY6P0cMw9zoj9mL3FclFQFjoMCXSUpLYw6wqFz++zw9LmnkTEWPKfA9oQEqCqxi7098abcO8S8cyJ/eZlummgpCQ4Oyp525xB17ZRuvG6coXG1Swh0SO3U3VyzChiwHNsYVd8Uu+2afo29Pqx0AL9aF5ypZTehkyIF3LinGzDuoMlILeoHBnFCqPy6+RQdIMbN3aE1WhhojDZnm90ruaBizSYmZOjHO+aCKINwXL0cQ/BUOxcVb2p28qqSv+A/z3PvwqJkkZM3DZZ049qPJvVe+IecNtIRiYQMqqmM0DaxXqlV6zxnVjOYAptFVvrhzN3LGOZO2tjtgoFmzQGQ2D1u3lLB2LwnT8po1yOhydQOQ+GDnVOXQRoYdGWMHnzgUHhD+lXF1UNQhFP0Brux2V89R2Xiqf5oOYjqHfG7ByflJzufN3pBwLUV2QZGNxneI/dSwYEjcKmMcw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ccc4e-e9e4-4c45-8598-08d885a3aca2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 18:08:50.0987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8NzihCTvQWB9v/v7MlnH679M6N9t1gFfN2PXcUaqFSm32wpIKAsiMoXFugecczr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Felix.Kuehling@amd.com, christian.Koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0195951888=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0195951888==
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Alex,</p>
    <p>Please update vega10_ih.c as well.</p>
    <p>Thanks,<br>
    </p>
    <p>Philip<br>
    </p>
    <div class="moz-cite-prefix">On 2020-11-09 10:20 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20201110032033.26249-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">By default this timestamp is based on a 32 bit counter.
This is used by the amdgpu_gmc_filter_faults, to
avoid process the same interrupt in retry configuration.
Apparently there's a problem when the timestamp coming from
IH overflows and compares against timestamp coming from the
the hash table.
This patch only extends the time overflow from 10 minutes to
aprx 455 days.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 837769fcb35b..bda916f33805 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   RB_GPU_TS_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;asic_type &lt; CHIP_NAVI10) {
 		if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR(&quot;PSP program IH_RB_CNTL failed!\n&quot;);
@@ -109,6 +111,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;asic_type &lt; CHIP_NAVI10) {
 			if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
@@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;asic_type &lt; CHIP_NAVI10) {
 			if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
</pre>
    </blockquote>
  </body>
</html>

--===============0195951888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0195951888==--
