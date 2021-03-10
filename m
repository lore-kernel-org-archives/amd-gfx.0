Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D959C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3F364FE1
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3F364FE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910826E165;
	Wed, 10 Mar 2021 10:57:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 951D06E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 10:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWQ3FEwJJVB2CvRNrwaFyhEAh3hOSm8FUc9kL9tngh6oKjdYYeIjY71LM0kxj+YkcUm+0lFMX5exZpQAfaaEQy5OAga5Bngmwl3vmvLLb0EK2VI+/DtzEinj0q6FN9EeFki7pGuATtLa0e7pKgt6rPzDTsQWk4/m2YruhXeHwoVRppdZhqykN/7Ld92EAVQ/7QRMSzhnTMwez+WFokkiF3SThySLcv/YnFpvmPcoDFVpOCs/+bdAM/d+tlSZmrAD31P0CmNOS5RRsNTeyq2Bb6AsNMMthoi2GXebztqOzB0XFlHyjswOWX3jkHKBMoPBkoGp4g2AdBa9Eb5gVbW/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ7N+ohDYtcYpDfpM6Nu6ENVmswTNgJjHSLMI0EUFrU=;
 b=Sg5CcduY7QkSQkLgvNtWOaFmxsFW5EgTblKvPcC56O4FgC3cd8gqqtOOAcDkw9dGO5SxY+w6+mVoymMB7JsZAGr0Wm0rVW1uDUbMiTmJY3twx1FzkigJvrx+xFbNg/AOw8sAWWToxp86aeVXZykTC6c0/Dw/Y+7RsuXSua5wy1p1xB8RNkVemUtTAzc5mwDF41YaWmPfZrFeauLj65M4qKY6rtBd5Ezk/HhDCFr1wJta+FO7ENd2606p8DR6M/Ynx9A7oXjhy14F6Dma7i7c5NMxGOcBK1oD161qEzKHz7wxuv/qKgTpT0aVgno3eBCCKQpFhjV1YL+uGiLVNkLnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ7N+ohDYtcYpDfpM6Nu6ENVmswTNgJjHSLMI0EUFrU=;
 b=mmt2SNym8CV3dAiYmRVo17xXC4r8GOvDypsoVgo/mTaW6WXHtUSOSGaZdIZ8bBBYgHX3XnHA86GA8MQrXz7r00RW1oS1rwTJb3MeeV3at8oiwmo5uRYTUJXFbUAdlS741Tzf+CL3f0G5wK0qAPPkI5RB6xYHW3I623wM+Z6tuKg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 10:57:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 10:57:02 +0000
Subject: Re: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <28138fde-01e7-cdf8-6fff-c5011ac6b88b@amd.com>
Date: Wed, 10 Mar 2021 11:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
X-ClientProxiedBy: AM3PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:207:5::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
 (2a02:908:1252:fb60:ab69:e3f0:8e97:e79b) by
 AM3PR03CA0074.eurprd03.prod.outlook.com (2603:10a6:207:5::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 10:57:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48f81925-289d-469d-ab62-08d8e3b33c05
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4335989436D5C2B47B6BDD0F83919@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMz1t/BJWipmDD9rgbeyu5mbeEexd/dFwypf9fmQWNlbNSJdZqB6ezyvlQqwS8EdMn0nKMYx64ymO5KTGD9ty3KLiLzAAbImeJZSZUfymvMgutACRcjEOZK1okz1tKdq0J7/GOD/4EzvC65kKI0+B8ESH8q7nQSOJUG8WpqLuqSPIZa6vHgP4zzl+3jTg6cthcT410aotKnzy40qzNHgv+kKxTzn76XwCAUUWJtjrGvGpiOjONiQSdOZmI2QcYMGCiaJo95iD2jWKBOtWAoCvurHXKsRR1sl4a19g2rx5dkpdwXkQ3ZfPwKNhY1ghhVxVMehGV43ge9JxzyEa8LEIYnUKZKqw8w85oCg3TnLIcON7bMKhRvXac8WO3avt4ktxMYLNfAiuio5Gl+E0W61VQGTi7RZwferUpjhLGM2g3joC0EtHNk7OnXPGVUFJM/Q0x2s9dLqwrwJpb+hWQnsqBtO7Ieg1Lk4AIpT/sVwgwsREBir8q+hgQeQ4pWQXYAO8R3Cm0RloU9ANJ/zWHrWoR0R70SBD2UQgByw9Ca7GkZGQKA6ATug1wvS6+4kftvV8cb3zKWW8U7XD81NbVFyLBkYKlfGs6EHPLLM2fxSHIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(54906003)(16526019)(186003)(110136005)(8676002)(83380400001)(4326008)(2906002)(2616005)(66946007)(6666004)(31686004)(6486002)(36756003)(5660300002)(316002)(66556008)(8936002)(86362001)(66476007)(31696002)(33964004)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K01aSFQrakwza3pOQUJJdE9sSG5GMU5KT0V4RzE1S1RzcHViMllFb1pTM0xu?=
 =?utf-8?B?TUFyangrZDR5a2llUFhLQUFmSysya3N3MDhNNUI0UTJFcnd1Y1g1ajBSS0Ri?=
 =?utf-8?B?c1ZVTFcrTXViQkEyOUQ4clFZaXFlOFRrK2U2a01DNlpTWVhHclpDRlhtY3pp?=
 =?utf-8?B?Szh6NTNWUElDNFV2UU5KbzRoaHpZckFOMmhld3A2a3NWSWRLUDh1andvZmV0?=
 =?utf-8?B?ckJVMy9ZY1hFUXpmUTR5SzFTcEovSU1ycG9CMXBxMkxHV2l5RGpxR1V3a1hK?=
 =?utf-8?B?NzVNQXJ3aWFwK2taUlg0TzhHKzNQL0Fyc1ptYVgvQVB4aWdZbnlpeFErZ2Iv?=
 =?utf-8?B?Y0lmeXRwcUdkK1lhY2NweUZKNkFHTHZEdlU2UzlTUWcxc2lBYTF2ek0wM2ps?=
 =?utf-8?B?cTQ1c3J2eTNhK24vNjB1WjE2TW1iQ1FYUzNpUGdFRUpoTHpSOHY3T1dpUVly?=
 =?utf-8?B?RHB3elBQbk53c290bWpWMEpKeFcvRkpKa0sxRStUQUJDOGYyMUdQaWZCZUFG?=
 =?utf-8?B?S3E5bWUzRXlBaHlRUC9IZlNzVGdhamI2b2p1ci81aVViRHM0ZWxJL1oxSjg2?=
 =?utf-8?B?UDF3QUtUNnRVQmE0aFl4VktVbzJJVjY5aFlxMi9PVy9TdDQyZ1RvZzBxMTlT?=
 =?utf-8?B?TzhzMGJodVl6d2NtZE5Iak9kZm1xVnAyQTZ4bWZCTXpFMjhGK3ZEMDFOa0Jy?=
 =?utf-8?B?dnJMUEpKVEJJZVdlWmhqR3BldHNkYlljczM1cHdmb0N1NDFzMGVtU0ZMYkVi?=
 =?utf-8?B?Q3lrQXN3cTBCa1lybmRhZmo0SkNUQjZEYk9jSVl6aVZJRnJMbVI0cGY2UThw?=
 =?utf-8?B?L3d3NEQvbUFyNHNTRHhyVllvMlZlOEM2UlNtQVdmN0dYVVJuc0lBK3RCcmth?=
 =?utf-8?B?OGI3ODhQUGt0TndxK2RlWk5OaFhEcDdxSStGN0Jwa0E2TXNFaUxDeTdCY1Nx?=
 =?utf-8?B?N1RQUldmbzhwUFJnSS9NZXp4SURWdGV0NS9FSWwzem5maTFSd1ppeHAwaG90?=
 =?utf-8?B?ZGlYa3A2NzBWZktDdk5nTzl5Q2xTaXFUZ3B1V1NDTjJ4eHo1UUtWd3ZwM2lF?=
 =?utf-8?B?bHF2cUdFYWUvSXIxVzNONHVmUzkzWGJJUTU1MXdLNEhucHdsN2ZQek1kZXhs?=
 =?utf-8?B?cjVCNmEzdTFja3UvMFRhSmdZTTJ0aE5uakZyWXRGMDVxb25FRk1vTUg5VWow?=
 =?utf-8?B?bmlBWTRFWGJJVXR3TThlUUd1cmo1alowZ3dRMXhRVkU4VU1tdVJXL3NkRHJT?=
 =?utf-8?B?UGJiSHFISU43ZWR6NmtxVU5ja2RKM3ZZcGNXM3lOTDN2eXRwajFDejUzM0xz?=
 =?utf-8?B?RU9Tb21XclEwTE5yRGlsTjM4RUFab0x0R1RWSVAzVmN2cS9qbDM2UDZFZW5M?=
 =?utf-8?B?SWpEOWxjNzZTMXJ3SDJXN2MwRCt2Yk5tL3BhZG1KM0lINGVJNC9KK1ZBNzZy?=
 =?utf-8?B?UHRQYzBMWSs3OWQ0TUlRVFFjZTVaMUdFbHRNR2VBKzlNdmRPY0Nmc2hKY09Y?=
 =?utf-8?B?UnpycExUaDFRSFJ2QkxHckh1Szd1S29qb3UxcGl1UW9sa3dIK1RiWUJOZVJD?=
 =?utf-8?B?NUhscjlDbUo5S2dhcHdEbllZWWR5SHo3WXJVU0dINDlGZm1wRGdwYWFNdEFR?=
 =?utf-8?B?aWduN3AwUUVEb0d6MFMrVGUxT2ZjTUE3TU8xUi9CNHpTQmU0TURQaGxsbWIv?=
 =?utf-8?B?VHdtSCtqdjA4b1BXY20zRlg4SnJqL0R5ejN3cytEQmZmVUE0eXZmTEt4Z29Q?=
 =?utf-8?B?TDg5T1h2OVBwVFpjSmRFRE9LK0phOVZnbSs1bjVRb1VNV25uQ3hHSlJPRURD?=
 =?utf-8?B?d0E3dzJld2lvMUx3YkU0VGkwVU15bHhYTElaZGVpbE5XT3dWWXpGaTVsRytL?=
 =?utf-8?Q?yjzE+3Vx9Sm56?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f81925-289d-469d-ab62-08d8e3b33c05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 10:57:02.1619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxJ3z7Sx8SQ+yiXVLH77Bv2xuL3c3ZtqGlwrVQZI4rapWemBGqZg5/P7gqYpvzhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2030282127=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2030282127==
Content-Type: multipart/alternative;
 boundary="------------7D8077DFE7F9697AE1892559"
Content-Language: en-US

--------------7D8077DFE7F9697AE1892559
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.03.21 um 11:39 schrieb Lazar, Lijo:
>
> [AMD Public Use]
>
>
> Cleanup pdb0 bo before bo_fini gets called
>
> Signed-off-by: Lijo Lazar lijo.lazar@amd.com <mailto:lijo.lazar@amd.com>
>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +--
>
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>
> index 45ba3819bb8f..e8de5145339b 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>
> @@ -1577,10 +1577,9 @@ static int gmc_v9_0_sw_fini(void *handle)
>
>         amdgpu_gem_force_release(adev);
>
>         amdgpu_vm_manager_fini(adev);
>
>         amdgpu_gart_table_vram_free(adev);
>
> + amdgpu_bo_unref(&adev->gmc.pdb0_bo);
>
>         amdgpu_bo_fini(adev);
>
>         amdgpu_gart_fini(adev);
>
> -       if (adev->gmc.pdb0_bo)
>
> - amdgpu_bo_unref(&adev->gmc.pdb0_bo);
>
>         return 0;
>
> }
>
> --
>
> 2.17.1
>


--------------7D8077DFE7F9697AE1892559
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 10.03.21 um 11:39 schrieb Lazar, Lijo:<br>
    <blockquote type="cite" cite="mid:MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheader251902e5" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#317100">[AMD
          Public Use]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">Cleanup pdb0 bo before bo_fini gets called<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Signed-off-by: Lijo Lazar <a href="mailto:lijo.lazar@amd.com" moz-do-not-send="true">
            lijo.lazar@amd.com</a></p>
      </div>
    </blockquote>
    <br>
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    <blockquote type="cite" cite="mid:MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">---<o:p></o:p></p>
        <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3
          +--<o:p></o:p></p>
        <p class="MsoNormal">1 file changed, 1 insertion(+), 2
          deletions(-)<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">diff --git
          a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
          b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></p>
        <p class="MsoNormal">index 45ba3819bb8f..e8de5145339b 100644<o:p></o:p></p>
        <p class="MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></p>
        <p class="MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></p>
        <p class="MsoNormal">@@ -1577,10 +1577,9 @@ static int
          gmc_v9_0_sw_fini(void *handle)<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gem_force_release(adev);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_manager_fini(adev);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_table_vram_free(adev);<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          amdgpu_bo_unref(&amp;adev-&gt;gmc.pdb0_bo);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_fini(adev);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_fini(adev);<o:p></o:p></p>
        <p class="MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo)<o:p></o:p></p>
        <p class="MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          amdgpu_bo_unref(&amp;adev-&gt;gmc.pdb0_bo);<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
        <p class="MsoNormal">}<o:p></o:p></p>
        <p class="MsoNormal">--<o:p></o:p></p>
        <p class="MsoNormal">2.17.1<o:p></o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7D8077DFE7F9697AE1892559--

--===============2030282127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2030282127==--
