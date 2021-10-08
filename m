Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FADC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 06:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8320361108
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 06:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8320361108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07636E09A;
	Fri,  8 Oct 2021 06:00:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8DE6E09A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 06:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbrPSF8eowJzwMKHC9K4FiQ5gHn0tiCQcplkRpOrT+Wzv7CbBSilgqawIOpjwhvtVlv/ZtbfvgrEoL1T6Civlm7grCXpM154gSRYklQFAQXKGBOQ+YWX4ipfo9joz5brhv5SUnJtMHUonOgPQc04O2bvADvdzyBM5vSnMWhyPbGmLzyJB/1TIaLdq4K/3A29P4dLFMQntOGowoe4WYYDqFjokaLhvP0Ljo+Txf7Mbr/HF3zEgFnIJfWcLAS351rMjxrIdWHOYrmilDD5dExjlMtJAsRnDrLX+ogUsHuLEkKDadRiPOST2KKUn1eUHSAxjQtP/1vGZbiDmIk5KZT50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP3Zl4PaI8/5aiZo0TIW9aLV0scSCAPjEuVPgabmj6g=;
 b=b5+CGjVyzUvVXvmQvA6NQ8/f4SyLVhXZtSLHmyf6TCkPdB2r5jLbjcjNKNWQlseKZVSKNwr0rmVSt8njU0Z1mHB7kt7E9TEVRiRvKhqu2fX8fosVY0byT58bXy38exFWcw1JSSbBYIA//NTrYK79k0LKUsUyCacwHWcdI/aaJ+b/KiCoTF9biTyaLWmuVbQ60f9fQ4/fZZbQ6lUmI17HOa9Zg3vvsV97NQixBejs+PRfCi9BlvukFRZM5pdGPJZ1fuoT7WQIszhLdNpbgeiMnf5t7PQW5eV44x5AS0iSlW6ryhDaD/kc7BvXitFLSgduWCPaUesg3249C5VkUk7fZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP3Zl4PaI8/5aiZo0TIW9aLV0scSCAPjEuVPgabmj6g=;
 b=tLMOEBVKtitO0Z0KXTjW8VWvljcv6WH1XsRdgUokERZsuGE2if46+KCJzNQCL7tLvkJJctTUd+zYkOzTmRAGrW/fzOOjZ2TSDXBZ3IQI7irL7NQf66NUZcDJaHyfP2nE+OmGoe8O/UrwWihyaeEwJKF6sUTQ/SOcCbHfijuTtMk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 8 Oct
 2021 06:00:05 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.023; Fri, 8 Oct 2021
 06:00:05 +0000
Subject: Re: [PATCH 0/2] v2 Add limit_type to (pptable_funcs)->set_power_limit
 signature
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006050655.6220-1-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <a1828265-668d-c55d-eba7-354f0047f78e@amd.com>
Date: Fri, 8 Oct 2021 11:29:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211006050655.6220-1-darren.powell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20 via Frontend Transport; Fri, 8 Oct 2021 06:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c41289-dd0c-4439-48af-08d98a20e02c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33073444B08FAEAE475900FD97B29@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9DwTY67JGs3eUdBAhvzzTWVlERUgxQ+6ESDMXi1KKLcybtxCg/XasabeGWUj/k3n40LGwB3R/xDpr9fd9noF2N+vtsZKLgBiKtu0I4ztAP+Pa94P5XC+qeMk4h/WK/dQrYhPsT6y6xNTZO+2oCC+XbyHmuHD3oavHbyHhsyxk31xyrGFSOR98nGdKFzhROe3/JK8LGOLS0EWO5zP2D0E8PjBAIzCHoflLhBUC3TzgypKeMFcqteD/7ee3LFptOcC29/5uuEbk5O8I4hlX8mQL5kMB8KEujhmYFMqDXoDKSyznJFcnaK3miZw+baGMb55KBfUIPgtdlwEBDTvQ1nhOx1Ko503QKi53a9ZGQsBeZ72UL6sg07+sfQD/Ls0guB9HtEST0ngR/tnAt/9d/kas8Ke3orpq8kIPGPZV67U/fj5asaowpXCwMimbeyIJOLFw9sCs9B4wUJqYl5d1asRAvEm7qWTQ0C3BHJ07E5i/bQhLqYdSKRwsh4Q1NQTZuF64SaV5/u3awIcQljDfOe/ulw1Vwwv5MVOK8KwtxCclPBWrSmfVhONHm3VnrrxCIq2ea9hwRlNNCp+HKzejAGsu1PuqVxE0hXoe+yHL6EcRH8iaomPXEUfsSA8DH5gWcBaSxnunGaN6sHyqx4ZNgkVdhtabZfRv2tlLjVjsTWak7fWbzYmadNo+nClW1whqA/m1hie4icWMggqZEhlb0LyOPBOuP3ipVTfTdlJyjiF0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(66476007)(66556008)(38100700002)(6486002)(8936002)(53546011)(2616005)(956004)(8676002)(316002)(5660300002)(66946007)(31686004)(2906002)(86362001)(508600001)(36756003)(83380400001)(6666004)(31696002)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JOM01YN1NnTzFDWDVtL0Q0ekJZaVJyNC83Rmh6d21XbVZRSExpeHJJQy9B?=
 =?utf-8?B?SUhteGxicEw0eHE1QUlwemYxZWRBWDdpUjV3RVg0bmE0V3NIWXgwc0pPbzVt?=
 =?utf-8?B?c08yM0psT1B3UmRITDlhejQ1dVBJZlJGa3VFY0xJTFBTMzJsSXhrL2hLYm9i?=
 =?utf-8?B?ZGFqckJRQUZEeWJERk1ncXd5ZjhEaFZ5eXFib05Hc1JGcTlDMUJBQm9EZmk5?=
 =?utf-8?B?ZzJEUjN6L0FxQzRSTE05MWJQUTBwTm1QaTBXZGpsbHRiUEMrWjFUZENhTkl3?=
 =?utf-8?B?QmtIMC9DS3FqTXBjU2ttMWJ3ZWhGQXMwbkdYTXVRV1lIKzE1ZjNrSkhCbjBx?=
 =?utf-8?B?ZFZWK2xGcWlBM3VLemlXNHdaZmRqcGM2TjlaYlgxblBpRUlhK2tVaExtK0R1?=
 =?utf-8?B?RmNmZ3AzcFhZSU1JNDZzOEUxQTh2QnlaOVIxaFkzQ2I1NEZGbW9XdndNWklT?=
 =?utf-8?B?ay9SdC9GNVN1ZEZLWTZRckNCcnFiN0poZlpLTW95ZS91WFlQT2d1ZGhGVkxy?=
 =?utf-8?B?UWdVMElGc0FXTkl0c2djVjFyam9SNWhwSzZqc29HWVpORTlldTNuY3BxN0Vj?=
 =?utf-8?B?emxUaEpyM3Qvd2Q5eno1NEdmQ0VqOGR2S1ZKem5wMDVVUkkvSVM3Ym9uZEk1?=
 =?utf-8?B?YWEvVkJOYXJDTjVOVnFRL1pGcVR2VmY3NWZJaTNRNmF3TWlXaU1pcC9YNEd1?=
 =?utf-8?B?N3MyazI2V0FrQkhQdE81c050WGVxY0VUU2NVWDFBQWdFNVNKaEM0YlN4OWpX?=
 =?utf-8?B?OUJLUkNLNEQ1U3ArSFpIUlRJdzB6QVdsZ3NHM0c4MVI5WWxiWmNKM3EvSklz?=
 =?utf-8?B?eFQ2cXltSnBPRk9hck1PZFF0Nm1aR2J0a0xUcWd2RkJSMWdrbmNoWVROcGd4?=
 =?utf-8?B?OFQ3MHY4VWlGZlk4NXp5aUh6SU1CNlc2K3IrRXVDaStsVXBFTXFRQmhwVVhD?=
 =?utf-8?B?YnhtY2VDZWFucC9qT2JRQlZNZmFWVDE2TUc1VmFPTEI4TzRGcW9HNU8rVVBK?=
 =?utf-8?B?dnQ5WEFuWWVsRWJ4UXRENGNWRU5TK2QwdHlsZHhPOFN6YzFXWllYVy9STDVK?=
 =?utf-8?B?cEtWaUJrUi92Ym5UL1NwQll3TCs1clIvOUxLdDRYZWJ5YXRLcWZpRDVmSXpa?=
 =?utf-8?B?dC92cWxQUTJEdWdBZFFNRXBtZHpwR21WeUVjRzlqODZROVdDK005RWQ0SUF1?=
 =?utf-8?B?bFdjU2xZd3hSZmpoQmF6U09LS3oxdDEwdE0wVUw4YlFCTUk0OEFwekZUNmha?=
 =?utf-8?B?UlBETWkzQXZucVVVUTN5U3lLOVdiYnFTMXhSZ0xYRVFoOVh3M0xlR1VjR2JQ?=
 =?utf-8?B?WmhYVGdMbm02V2RaaW1UK05NZlZZR1VtbWU0VnF3RkYxTkNMSlNzdTNTOG56?=
 =?utf-8?B?QW8rU1gwcTZxMFk4RU5SYkYxazBrSHdyNUZpMHAxSlh4MVN1NjlsY25zZW1s?=
 =?utf-8?B?bzMvTnRZaXFab3pPVmhCUFZXUWt4Z0dXZm5BMDZVTXd0OWdKYXE4UEJlTm9U?=
 =?utf-8?B?UE9LemNsdXlhWVZKNDF4US9TbWQyY2Jjb0Z1TWpldXp1V1pCK2hDMjBVU1ow?=
 =?utf-8?B?b2FiS054THRnNnQ0cFZXaXdOTHdvRUpwdGNweGYxZGRTeGdGK3p0dXo1aTVs?=
 =?utf-8?B?d1JlZHM0bUVLYnQzd2N6ODhEb3o2aDZ6WGp5NXBUTGJxM2ZWWXJOTGRjQlNO?=
 =?utf-8?B?Rzc4aVFHUjBObThaUG1OeE1HaFZWSk5ENXFhMmh3cmYxSFM5eWtjR0F4allN?=
 =?utf-8?Q?enFvgo/6002ymaIXp4PYDxhLEs7cR9OmBwU7WTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c41289-dd0c-4439-48af-08d98a20e02c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 06:00:05.5730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46h0zh36XgvuZXp2GlRtu0r8yMdVM4Gn/VocGOjgsl/tYZqQ2mlwPxeL9GE9jgbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
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



On 10/6/2021 10:36 AM, Darren Powell wrote:
> === Description ===
> Add limit_type to (pptable_funcs)->set_power_limit signature
> 
> plus small patch
>   Fix for incorrect power limit readback in smu11 if POWER_SOURCE_DC
> 
>   v2
>   add check for SMU_DEFAULT_PPT_LIMIT
>   dropped patch: Explicit initialization of cached power limits in smu struct
> 
> 
> === Test System ===
> * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>   + ISO(Ubuntu 20.04.3 LTS)
>   + Kernel(5.13.0-g9e50250d2084-fdoagd5f)
> 
> === Patch Summary ===
>     linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ d6119c68a46e
>      + 20e15ca8448f amdgpu/pm: (v2) add limit_type to (pptable_funcs)->set_power_limit signature
>      + 45fb82fd6129 drm/amd/pm: Fix incorrect power limit readback in smu11 if POWER_SOURCE_DC
> 
> 
> Darren Powell (2):
>    amdgpu/pm: (v2) add limit_type to (pptable_funcs)->set_power_limit
>      signature
>    drm/amd/pm: Fix incorrect power limit readback in smu11 if
>      POWER_SOURCE_DC
> 

Series is :
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        |  4 +++-
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h         |  4 +++-
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h         |  4 +++-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  5 +++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 18 ++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  7 ++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  6 ++++--
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 11 ++++++++---
>   8 files changed, 40 insertions(+), 19 deletions(-)
> 
> 
> base-commit: d6119c68a46eae0b48c77353aa81e6e38b009d24
> 
