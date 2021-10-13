Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E271F6112D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E271F6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873546EA65;
	Wed, 13 Oct 2021 15:10:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8B36EA0F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCk2maejGUO5b0Ca0FhvF9GErW46008ELuDEUnhG/Qi/8QfQDSLRrOkTb4DTJThfHXL9wFjGCCCL37RHg2GfyU11zf6lB4Zw0ZAewuqiiYS/maHvBnSmtdmDACpEZiFLJei41Csqdp5HzQa7MQtQk93RAXmJiJ3+sNn7b42DO1Ba8VxBRA3WuhbLzpV59neKyh74wb+Y3+4ST1w2DebZ2jQYxCufwGmW3JV/T0Kh7g67LbEQIxrIoHI6/YxWnnUW73vXdK2I4YQyRlAkByRu396DYJom1XWoFPyCI0YG7A3441DZZhxhe4NKXraBM995kGUn3DEiWuY0zZWOnXlQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGYH9qhU3eiEL/E+O+baHJZ2RilNTKUxiT0URcvel7o=;
 b=etwW3PdSc1O1P/8XzbRWR00Acl9yqI3qYH40PNY8DZd+a5a5N+zab680ByRKtM/IYxlgtUbFwNPb94fr/mz0+s+d7MKyhFncMfKwckY0oa2ylwbYCfCPUkl1Xnyhv69EtIG7UVFwvBtna9WnBiv61qYXIRt7apNCDCujyODAysVWXuE+M5OV752nuvTJROkBpq7uVMcW7UroEZC/6xg8W6/0uHHQT8WvQXnPc6qu4SdmCkizE16enAAh+u4wY8SJeGFtge/mWxibfrwDFBFVeyJUBH9sSuAGBopbcNOWDgie97G8V7BpzYyloqZtRIhUcy0uRrwKucApGJtTvrSQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGYH9qhU3eiEL/E+O+baHJZ2RilNTKUxiT0URcvel7o=;
 b=Y+JTNi11gGIaGhMnRE7cU7ajU6Xxwe/iQBExn1GjsFeTWZzY8S/aeh28aJX+56QqWFAfJuWq55umhFdnBL6EAiIIlR9pU3WGBCgPtf22dgHndJE5S5GL6Qb+RUTJFMZ2C+OGaD/cjIQ4igQD/nxXZeKFRGMsBnYaRnPxkr3/KBE=
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 15:10:26 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 15:10:26 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: release gtt bo after each move test
To: amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150457.5268-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <79852c26-2e14-398c-8d9c-243101b55e05@amd.com>
Date: Wed, 13 Oct 2021 17:10:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013150457.5268-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM9P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [172.31.54.68] (165.204.72.6) by
 AM9P193CA0009.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 15:10:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d315faa-ac19-4784-d9cb-08d98e5b960d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5478E2268784D137162F20FB8BB79@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVjkWBOMXSWBOlypFl1xG0I7crsxjmFn8Ij+WpYC3WQxFwRQG7flbwEKRdvQuFv9ahit8P+44/QqhF665uoqg8yEpLG1uiLLzenH1FDpw6NePNWaWSJpElMYfazvEGFG+eJCzgbYsh+1ccftDIsyQMS6ikZurH9MD+ACSTesBenwbEACZoU2F92FMjOl/WJwVvwu5vjHXUqjphgjk2QVdUUOofyIGcoyB9ddE6BEHxoFDSTtR3yDVkPezkcdN6K/hthkvDhJ1UZ7p2lXNJ46Esfc/6FzL9RydpUs1mT99eYs9O1E3WxNdHZrw1zGwljH+oww9guwo3pAJ4+B2JuSFRgfPWrkSMJlLGAA2ZB1z6tqn5sWjdEiHr7di3zqmGI5K52vCS/gyOj5o8xBi0i1xx4FwAvUCFSUruAejOeOITg+z5sQRoPynCi8wFaIV2ZcAZDfRfhX0N4T+6fUoQ2tnjvbOJA1mhe2LzdbxLkrejyO1hroRmm/9nRhmHYQrfmd3Pw2e7SDOmF4Anj1rIzhPbXqCsnc2kJbYMPE4TNvihHCxagqFPQWd3C+Dv9EBVBQLQ6eMQej9TN33KPRpsgnKAszL3plpfkCLFnId/eZdMZmqO34YHSBeE2f5SDTvzeJevZkPWV1aQBRL8LEeN+QDrDGuAMHuTrjxTvyLDfSqn/DuvHdFH/52Z0TyhIh8MvwGmigvV6LdsctFDL3ZB3qE1saQy0CFtRQ9gdPpDQgWDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8676002)(66556008)(8936002)(4326008)(66946007)(956004)(316002)(86362001)(2616005)(2906002)(38100700002)(5660300002)(53546011)(36756003)(6666004)(31686004)(31696002)(26005)(83380400001)(6486002)(186003)(6916009)(508600001)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFN1dGg3azNOMVRXOXk1ZUNacnYvVFdIQ0g4RzFVcG5reVlVTm9Mdk50dkZM?=
 =?utf-8?B?WWc2bnFnR0wwcUVXazlHR3VYOXl3a0lsZXFtaGdNNmNOakpkaUdoUlpqNXgr?=
 =?utf-8?B?UmcwZitPR2c2OEFTODZLM2plbmNNZlVROUVFOWFwcmNkNSt5WGo0Rmp4SDN6?=
 =?utf-8?B?S0tyQ0ZiazIxb3lYMHAvQUN4OFk5NFFUS251d1dXM0RjdEhZbUk1TjdQdTBl?=
 =?utf-8?B?ZE5wdFA5cnNBdzlxOWZqeVA2REtnZS96NzlLc290YzlaRklSajhGSzNOeXlr?=
 =?utf-8?B?ODVxSmJtbkNZbG5GR0Z1YWpoUWQrMy9IdzQ3SW1oTVpnVVNMajByVGFNRzY4?=
 =?utf-8?B?dDVTRVJjZTVXNkhBNzBockt6NlFnYnRlbGMvbm1DNmVKK2V6V3Jmek41eTlB?=
 =?utf-8?B?YmdmTStIcTR5U1ZKalZNVktxOEdEKzkzdlBrM09FUit2c0d0amhPNHEwZi8x?=
 =?utf-8?B?blVhSzZpZWJudjRnWmwwVnVBdkRBcVQ0YWN0NmtnVFc3K3NwdXhpYVhRWHo3?=
 =?utf-8?B?V0cxcGxKaS9kT0dLVU9kUkNFVGZIdDlqZWRWLzdLRjJ4YlVDWFpRcWNaMy9o?=
 =?utf-8?B?M2F4ditSOGlIYnpLbFZkS3NvQ3VwOTd0aExNTys0RnU2bDJGVGdJcFVMTHlh?=
 =?utf-8?B?SDN1c1gvNVNmZ0RzOG5iYkhaQ1Q0ME1ZZHk1N1ZZby9JQnpmU285WVNQc2Y1?=
 =?utf-8?B?U2JjVWJpbG40dFFDdXlDMFZUSFBOSktuVUNaelpJakdQYVM4eCt1N0drUVZP?=
 =?utf-8?B?cG1SVTdWc1hpMGZxVThmeHJjVWJqZzRUdVhFUUJadHNMcVF6cnNFcU1ZakxG?=
 =?utf-8?B?K0kva3hvSE43Qnl1RlpWbmtHNExQSEtXaGU1dFFFZmRjbWU4bXRmcFFiOXox?=
 =?utf-8?B?OUhOK1FqMkoyWFNaVnpoVG9wdHhFUDJ1aDk0L1VKMzJDcHRXYWNtOEhnYU5J?=
 =?utf-8?B?emN2MmV6QkIrTzdWRVVVRnQ1c09kQWF4VlBtS3p5RzhYZ205RmV6QWpvQWg3?=
 =?utf-8?B?RVJxMnBvV1ByTUFBVU83N0M5bThhYkcwSHgrNCtBcjdiU2p1amVPZmVYdnZu?=
 =?utf-8?B?eGh6NTcxU3p6TmQzWURyL3F4T1Bydk95Q2wvbDNjbkNBRGJ1bTVUTWRGRDVD?=
 =?utf-8?B?bUVVWUNGUVpKcjZqSjMzdlc0d2NkV1RJa01CNUcvSTJWUEFKTUtKUENpc1RT?=
 =?utf-8?B?ODJRWStUVHczNithZVNPVXF4ajZ1dXptd1FvTmUvUFJjUjhjaFJma1dtU3c3?=
 =?utf-8?B?RHhrZGZnbTMzOGdiSU5ueGdkM2ZHMTZPTmhVOXR2SVl1Y21XUW9hanhPZzZw?=
 =?utf-8?B?SE5xd1FVSmh5ZWNzbzVDbGVDR1V1RjlEQllPTjU2QkJ2cUdKUStlclJmRTYx?=
 =?utf-8?B?akJCalIxbDFxd1c5NkJLZ2lOMGlIN2xXYkRKNEZxb1hvNGgwZFN2cnExREdn?=
 =?utf-8?B?VUJETkRIWEE1U0NqV3JhN1pkbWhscVZ0Ymo3TlN3V3JkT3ZCdmtXQ25OdEU0?=
 =?utf-8?B?ZTFyZ0JMSzNqb3ZudzlGQzBIcDV6ckpCRGhZc2dQSmQ0Zmhib3V2NFo1OTVp?=
 =?utf-8?B?YzBreDdKMEZGOElwbmhjOFdaenAycE1pV29hbU54VGVWbkpCaldqbS9yNVJy?=
 =?utf-8?B?WW1SUTRmUTlZTXBRSTBxbEJYdTMxWFluR1lXYmxYaTRnckFER3M5a0hKd2JQ?=
 =?utf-8?B?emZhZU9ZaXV4RUViZUR2WVI1NVEwekZjYUtxTS9oSExOSTZ2SENHdzBrdGVw?=
 =?utf-8?Q?FZ4/OysQndtYbnFgUGxyvc6NCb6vwY3QBku2gbC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d315faa-ac19-4784-d9cb-08d98e5b960d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:10:26.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0A888B7Aoj81acUTe/ecpH2UsM/lEAXM9mlVaw5Hhjg1RH2GbkxR8bmJE4pO7PYT6F+EM1UvePXcTEyaQvK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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

Please ignore this!

On 10/13/2021 5:04 PM, Nirmoy Das wrote:
> When gart size is < gtt size this test will fail with
> -ENOMEM as we are not freeing gtt bo after each move test.
> This is generally not an issue when gart size >= gtt size.
>
> Reported-by: zhang <botton_zhang@163.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 909d830b513e..0cf2a560d673 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   
>   		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
>   			 gart_addr - adev->gmc.gart_start);
> -		continue;
>   
>   out_lclean_unpin:
>   		amdgpu_bo_unpin(gtt_obj[i]);
> @@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   		amdgpu_bo_unreserve(gtt_obj[i]);
>   out_lclean_unref:
>   		amdgpu_bo_unref(&gtt_obj[i]);
> +		continue;
>   out_lclean:
>   		for (--i; i >= 0; --i) {
>   			amdgpu_bo_unpin(gtt_obj[i]);
