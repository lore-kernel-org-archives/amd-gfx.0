Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C83C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 10:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E295A61AD0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 10:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E295A61AD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1206EAA2;
	Fri, 19 Nov 2021 10:52:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693516EAA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 10:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB++7fboje6PzxkR/uL0S0AKJrCD80foXM06x+L3tYNZL5jj3EqwSoSrrHlYQTXxjFmOLnVAPKXGLvc8T5zJZQ6npGBRDPY2IrzrrVanzCTQTa7FtCH1UoZMld0irNB6BN2PjOEyAxvkn30R3W+WfD4pjxk5vn/o3vFDayEt/p5QYJx/u4F5PJUQgvF11jyYvSIHLt41bahL17vxlTy1APxkEtTOZET3RtadkRf61GKdWPaa8OJAKyPK5c4dSi9XmJ0RaCCCDx9xTpAnRnDZmTvBhtKzBk5gvgADy2e6UbCJ1GGfvyVZPXJs8Bp1z18Fhzn2IXHXC7cPJWOmuwH4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmI78mrHly8CBrmWhZ7Km0V/bGo/HDi94PEqoy0anC8=;
 b=bnm+eZTHdhGx6XehjbfeEczUrRRARTUvBbhE3dxqV8NazD3xdbmTVqFuP79mFRO1QayJlO2bcVKTeXCl4Rwj6HNf5icYXkzp2dcdisek5MsQS+tSiewO6h20nJMALJx7ufjQH7n7k2hfUUUObdchTKLoFP2U92yO0V5r5Jf4POrmtH0S5VyzWofhOXt8xH9L50ZippgMChi3pB1n31IiR7DpRKZm/5m6KO1YC45LkAODeXnYKtKgMaW5cQsd3XNgvEeSgqlWJ+P7FOfALgnXcY3Kku8f3/fjKBRxgm5QA/OuW4APh6YEEnmutu8GNIaTolS55t9kw9Trevv2enPCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmI78mrHly8CBrmWhZ7Km0V/bGo/HDi94PEqoy0anC8=;
 b=Nog+iwSEkMYX8I2swsjk0vCFicErLIZRVTpN0y32I1ceq4mnmdgbE3FOSjzSJViImE8EdHvwot03+r9I8Kkw4/slAVRkDucavVegNqcg4HdiqaPYfVRA3CvLDI+5uxHjeeSXeSVi0Gp2EYSLWbHcnd9RCz9NhuvW3KADDMjgrtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4412.namprd12.prod.outlook.com
 (2603:10b6:303:58::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 10:52:11 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4690.029; Fri, 19 Nov 2021
 10:52:11 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix double free of dmabuf
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119101725.66619-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f56cbf03-6447-7774-1914-6fd19fe75dde@amd.com>
Date: Fri, 19 Nov 2021 11:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211119101725.66619-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::17) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:7c55:2711:388e:6341]
 (2a02:908:1252:fb60:7c55:2711:388e:6341) by
 AM6PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:20b:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:52:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6130290b-0339-4edd-2251-08d9ab4aa330
X-MS-TrafficTypeDiagnostic: MW3PR12MB4412:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44121040CE42884C696263F5839C9@MW3PR12MB4412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL/mpvSM07dxg3rg9hkrxhCK5uV/RW0Ci41+dcRDth938dw9emzP7400A2EjgbK/jSvnwVPvLcmp2LDNUo4bXaZCqCJ070K7ffwOJLBCPTMNSD+xX9J6TinG/50t23c8B2zSukrGBxhs0pX0DILJp2nKXxQFH9eLuQmyQZwwqMnBmiRBd3551qxKEGCkJYBD4ngTnd86PmOIf/xOr52SfSpIquUSNR0DJKdqze5+HPvoa1Fzzj9DYCg4EHflyMUjBEMP/W93r7Q/nH+gn8nKPSjs5jl/+7xVJQZpn6+wcSgeV/FAtZfpaxLQWNwZgdHm8rJLTWUbtd+4cQSmzWjlfwqQObRJhIrUBV79wIs8j3GwH5V51z66UI3dSfIcCgEmhkszYxeCwI4zWw3jn+wCNWMMkV6azNauxGH9WRTT/KOgom0zLOv2JJcqL88ThbP23d+jOfa5Fkl4DSH3ZVXAg/Mld9FuNutwCovvKxsMWQ60w6Pa6eFLYejOeQF0r3LpGFjBOG3xudOvMANVYQsbpB5l6fCVDR6BNbLH7jydZBho1wlhaUU0l4EB3DjR/UGqbZL4R+BU/gFCyN6ykKJrEfvRBNhZ12OFBDLW5vE6kttCRAh/0vvfZlAfWnQ6fci3zSPu2A+aDryJLu2JfSk8CGlHAfowlNhmP4lMQmvCAJ2M+W/MaVmgO1Rt4MwZtXlbZ5tw0K4/pyl33UQaep0dD8FLCSRhrtwZdL1MYUntgmFrClPKCP5vlOj1xzuEGdN1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(66946007)(6486002)(66476007)(66556008)(4326008)(86362001)(8936002)(83380400001)(186003)(8676002)(2616005)(508600001)(2906002)(31686004)(316002)(5660300002)(38100700002)(6666004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWswOHNvMlJWbFhCcUhtWllvczF2VHB0dDJQWnNUL0R3Y1lHemRoYktkbTVs?=
 =?utf-8?B?OU9sZmZQSUxYalVBNHJNb1dyaUZ5d0tTK1RFTWFCMnhRWFMvQXJlaWxGY3F5?=
 =?utf-8?B?TGxnOTA4OEVJOGpmaXdnSHZuZkdBSklyU2pvRElJR0hvYXBnUTcxbmlxRTFR?=
 =?utf-8?B?bUl1dCtHVEpEY1kzUTB4cGhIUHNMQWgwQnowSnV2dXRGUmJiOUFQSUhqT25n?=
 =?utf-8?B?MkY3NmVyeTlvaENoSlRUNHowLzRJVGxwN1c2THdLY2dMcExvRjRJSWwzR2Zy?=
 =?utf-8?B?UFY5dXB3ZWNwQkNuSXpOc1ZhM25zRGhPRHFhRjU0RGRsVnhkanlsS0hBeGNW?=
 =?utf-8?B?WEFaTldRVlN1N0k4RkRKa0hLRmhoNDJsSG5jNlFVVURyQ0VtUERuNUVESkhG?=
 =?utf-8?B?bXBLUmdzRjdNMVhnU0lsa2MveURxcmk4MkQzSlNJalBsR3Z5cm01KzBiMUUx?=
 =?utf-8?B?MFFwZFQ3LzJqS284eHNCWW11SjdRMmI5aFI0eGxxeFpObkpNYks1ZnZaeGtk?=
 =?utf-8?B?NlNqaEpKSURGNzNkbWcvMDNOSHRvblFlQjZWNjlEc0JsczdDcnpTNVRidUx0?=
 =?utf-8?B?Q3doY2RTSVE2dmR1NnUxRXVqNEFyREtUWDZIRGhPSjkvdE5iOVJmZFBmYksz?=
 =?utf-8?B?Q3ZVN2ZpNHpyblJkSGtrVnQyUTU5VnNVLzlJM3RGUG15ZWJwSCtPcThuUDh2?=
 =?utf-8?B?UU9sM01aSGIrTHVJOTNGaWFYcE5oMVBqdytjMDR3WURYdXNBN2lFdjROaVpB?=
 =?utf-8?B?dHE3cURDMU1lWE9naUx2UHlUaTUzdHBIWTM2YnJYeUpJREp2aUhFc0xhc3dx?=
 =?utf-8?B?MlllV3gweGQ0alQrMCtJWWF0SG9QeVZiWW5tYUlhSHBUL3p1ZS9EYm1pVG9O?=
 =?utf-8?B?T3gwaGJYM2M4eU1SeGNldWwrREhWcjlNYXNmREFva2ZnMExnSVFtVXdpcmVB?=
 =?utf-8?B?WCs2L1cydUNnMnQyMzhwVFlkQWJKWXZtdjlJb1hzTVdPcDczY2cxUFA4Y3Vt?=
 =?utf-8?B?clJzbXlSNlB3VzJpRkRMNm54ZFNxTnphUkFDVzlBaUQ0NFFkSzRLaFNKcTVU?=
 =?utf-8?B?bnR6SS9McUxWWWo1YmNzazlTZ2N1TVkyY1RWSFNUZlpIQUF5VWQrb2Q3Tmcv?=
 =?utf-8?B?S20vWGxhS2UvU1dWZEs3TVdDTmJzY2dsV3N3UDZFNEJJeTZkT2puRW0rNHVp?=
 =?utf-8?B?UmdwcERCTGY3ZkFzY2wvb3dzdUs3VUZhSE81RW51QWFGRjNWNjAzZzB4RFJ6?=
 =?utf-8?B?dWF2QWR4eklzZzBtdEVIcWtkZW5vZHFLSTdKT015SXd4RmQ0MDMrSXR6SU5E?=
 =?utf-8?B?OE9aeHUybEhDQ3UvKzBKV3h5dGpubFh2QklXV0ZmRUcxU2VVOVVDYWhRTUZD?=
 =?utf-8?B?UlBMTVo3WXo4Q1V1ZUhqbzRuK3pBNmxUTURCT2h6OHVhdFl6aFlrejN3K1Y4?=
 =?utf-8?B?RngraDg3azFsSlIwVS9ERHNLc3U0Y1YxOXBSeDJpUldsSWJLTTF3QlNCMFJT?=
 =?utf-8?B?QldaWlFrS082U1UxRG56bklmRWFRME5YTG9xOGxOOWE1blBYRFVkYXBpWVdw?=
 =?utf-8?B?YjZ0RUkvME41SWRhUDlzVUZ3YmJVUkMrMGMwbDl2c1g1cDkvcGJWOVNsTjJa?=
 =?utf-8?B?MTU5QWhmV1Y2ZFhMMTdiUTMxVWs5NmRzZUtOeHlLSlZadG10cm9wV2NPSzNY?=
 =?utf-8?B?RyszNDlmMk81YVI1VSszWE9RQkU0SFFITkliMzJjSXpxWjVOckFySTJXV3FI?=
 =?utf-8?B?TkQxdElMTWJqQzFGUFBuelBBamZXSlY0NHBiR1dqd2FZRWkwa25LMW1qeFJ2?=
 =?utf-8?B?UDZmT2F2UkNZTDlzR0I4Y3hRWXY1ajM1emhMMnd5S0JIbXY2ZVpOK1Q1VVNX?=
 =?utf-8?B?aWwyUUxRdW5NejBqNDVMWFNXY0pzODBQVnFKb05ybTJWcWh6ZkhVM3Y0VWxi?=
 =?utf-8?B?VmhTeVVTdW9sU1VBdWlnZDJlcmxQMklkU1N4Qk4yUDd6eU53QWY5SFNqRDhL?=
 =?utf-8?B?N3NnQ3JWRE9QUkx4NDBhazdtNDVLZUxVdytkVnBjaThjeWlnaUFkYWp6UmMv?=
 =?utf-8?B?YXRRVlY4VTFNOGlyRFU1Mk10WjVTTkRuK0dCU1BwY2FsQ3dOMDBLckI5UFpD?=
 =?utf-8?B?SEVXTkFrNlJ3STBlc1FLd0JBUXg5Q3MzNzhjSjZQYjNYb3lZK1BqeCt5VGVi?=
 =?utf-8?Q?wb2NbODgjQ18dlSm4eFkYQI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6130290b-0339-4edd-2251-08d9ab4aa330
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:52:10.8383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo9Z1d6qNEa9OKj4GK4ucZ6K5x0vejzihxK43J4Dcv9x0PhxhB5h72Ij8J8se4+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.11.21 um 11:17 schrieb xinhui pan:
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu drop dmabuf reference increased in
> amdgpu_gem_prime_export.
> amdgpu_bo_destroy drop dmabuf reference increased in
> amdgpu_gem_prime_import.
>
> So remove this extra dma_buf_put to avoid double free.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Yeah, Felix pinged me as well that the DMA-buf import code looks odd and 
he is dropping the extra reference which didn't made much sense to me.

Acked-by: Christian König <christian.koenig@amd.com> for this patch for 
now, but I'm going to take another look at this when I have time.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6c6d5d994b5d..0f68d28e002e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -665,12 +665,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	if (IS_ERR(gobj))
>   		return PTR_ERR(gobj);
>   
> -	/* Import takes an extra reference on the dmabuf. Drop it now to
> -	 * avoid leaking it. We only need the one reference in
> -	 * kgd_mem->dmabuf.
> -	 */
> -	dma_buf_put(mem->dmabuf);
> -
>   	*bo = gem_to_amdgpu_bo(gobj);
>   	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>   	(*bo)->parent = amdgpu_bo_ref(mem->bo);

