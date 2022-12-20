Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A5CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 02:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A29810E336;
	Tue, 20 Dec 2022 02:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C0010E336
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 02:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+2fw9bPm6I5xQiN28L7k+zuqeJoxU3UCZnaAUvR6sHDGYWsItuUFS1MNufIU9kGQGF1spSVlqQBAIgTtLKZWCgtEqXhj6zRLD67Ptl6oV65+Nfalzr8noH339UVmt3qoL+PlPvksMXlCknAa6oRf3pjE3i4gu6nSrgd3z6Aoj/JVgxb7422zM6CX4YbaVWFF1pxfUb3xyoWYitU74c4F/1mIKFAEtQlLoavIIqF9I/YFBe7mwGFLgMwBoacGkLElWCcIKTEPIwfECK8MCPlT9aSpfQVV6p56fH9JnAGNpVV4btF5sJPUhSHWTkCm5snu0nBrtyMKU3JVFL0UxELKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiRrW8lhlbVlPNKcHpTqcRH7gD1AGpV4Y6uxOo8tRB8=;
 b=ctBSfeSeUt43IiPvlX9Rxusy1+TcCCSoxi0OWLHecymdOegrlss9ze8/altylzILpcCMW8jMwpbIubIAyOK5pkddzsbAFHUblphh90DPRcuz0NeOMqTF81TGAvIPlwV/SP8UvxDEr37KHMHplkMs3J5P74cYtbUk0zr7lK2hL3CjFYwvNlHOuiVBD0Rrb2pWQfTGMdsUWkMiEvRlSQHhuMgLV9+kggFpteh8PObITfDgzgYRhTBAdLr81V2uf3M+fa/2WyDsyyBvNk5pNim/KyNLfxAoyPdKWFFERBIFK2qveROUw39wKZ2cn0WbQ8U/MWP9jO9zWyb2SYtwHF51fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiRrW8lhlbVlPNKcHpTqcRH7gD1AGpV4Y6uxOo8tRB8=;
 b=T8AvWnSjzHZHlubdeQVz2RiGWdTSWPWfvaeFqlBpKrtMaFmmZOw4MT0BRtdIBAcwITy5fl+K8PEzE1hDbLRSsKrTV8Pz2Amu/HAARIsdBAu/aYQFE4tETnz0N95IFiVVH9Frj/Z03yat5MtXxpDCQJBBFrOJNo26Ld7UAneT2J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:37:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:37:39 +0000
Message-ID: <0e9aa080-9de8-a324-7311-fb6076936edc@amd.com>
Date: Mon, 19 Dec 2022 20:37:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] drm/amdgpu: skip mes self test after s0i3 resume for
 MES IP v11.0
Content-Language: en-US
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221220023055.2602689-1-tim.huang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20221220023055.2602689-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:806:22::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: b02ae009-75ad-4f81-06db-08dae23329af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fS5baESgjAHXt+JYVis9L6mbcq1xlIU9/7oyveVs8pLmAlwRxQYpNC/XndUlo/IGUpHMfRVz+mg/a1ne4rrqXJfHnsJZDNlM0825O9+nFY9sYgOp4xLrv8ximxhnG5r8ikPl7a3QJLvciZ4f1WQgx7COHnUe6lFcj4katOFwP7BtnfqnzRr32sKGbDPaoR2saUs4Za2N3L/bCuFHAfM6Rj5VauPPJG3VnqHPk+KHWAD83izR3NgsQB3lZXdhapFQZ2EnJju+zV/IXVEbKPNOeAiL0fY2Dre3kYOu4tZMzr8P+rG29myYI8R73C1GjBoX/1dG/9YiL3uNuuyjQKCaqs12IBpsbUtQgjvONTz/fN73KNPxxMIWaRnumzVjX0Jm5ujAml/Q+zPrNXRbRed2j6fusHTJCEIP/jzLD3dEl/sFvYeys1kcVw+YS1gI8gKWj2dCayYTiB8omxu0ot1r5l3j2eQITdAMdw/OQly5K+9DnJhCYzo05C6a8qKfzjixwXyi1jy8W1FpuNh7y3rJ6LHxBR/IEQtWYMYVLdp+U1O7J5HU2nIETTgAWMS6KJshFQUKt4o2v6lE07DIm40cAGc/FePWpFaP2cYn2e0yyNcdv3pApjIRcXU0skYups7xo4eeuvONSyWyXTybbZnkZf0yi5hzav374hkIkqqZxtyOib+XgvT0+3BrfRM2Ju/iB5kXuwapD60yY5bVnkoHTSfjrxcQqsEJcErhVbrTH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(41300700001)(2906002)(8936002)(66476007)(5660300002)(4326008)(31696002)(66946007)(86362001)(66556008)(44832011)(8676002)(316002)(53546011)(6506007)(6512007)(186003)(38100700002)(31686004)(36756003)(83380400001)(2616005)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZBMGMyK09kL3RZcTBlYnRzdzR1MEMxTUtIUTIvcWczSkQ0RFBWV2xVMmdW?=
 =?utf-8?B?UlR1SXF1RU9Xa3FERGdwOUVJbGtMbUtQV2Q5bkwzWlpTRWx1Rk9SNnowRFdr?=
 =?utf-8?B?enI4MnBRcWsvVGZMeDczSlFSYlpnQjNvd1Q3cURhdGlMOE9EOWc1QzEyN3lZ?=
 =?utf-8?B?YlU4T0xLeGRoWU5PZU5URWJ3WnBVNlVtZ21TVWV4QXpKVVBib0lmUjA0V2Vw?=
 =?utf-8?B?MExFZTdsMlJrQ3Y1QU03SVl4NTBpcnJvTGQydG1ndFBISi91QUJpdkRNcGZO?=
 =?utf-8?B?VTErL1RlZ21DdVk2WWV4cDRCSXcrSFR2MUMxaXhRVkFEN3c4dnNoTlBwWC9u?=
 =?utf-8?B?RjRKVEFLZStPbk1EaUhqQTR5Ylgzb2dtbm13dkRpMjhXakRNMzErVDVDQkln?=
 =?utf-8?B?ZU9oaFFrS2RLRU4wT0kra1I4RDkvR29hcTM0aGRaODVGKzZpVFhRVzBVNlpn?=
 =?utf-8?B?Qy9icGVNN2xsZFJZcnVpMzFzZGRLMWFzU3l0WUdidGlIN0JMSS84YzR4ZzBs?=
 =?utf-8?B?R05NWitUblp2b1pDMVRsVkI0R21yMzZlM0NicEIzRHNlVUhhdFhRYTh2ek5y?=
 =?utf-8?B?bVI1cjlTNDQxR28rQ3ZpSHBrVVZRb0JjQ3FzOFNzdVozNmNEa3RjRXNRSzFy?=
 =?utf-8?B?TTBOWDdoL1hkazg2aThBQWF6NXUwU3Zya1ROZlNPOEtOdzgyOURCK0J2R0k4?=
 =?utf-8?B?NzlrQTlrRXgyVVMweHRzQWFidEJNekZ1Q3hCWSt6OWxuVWt4REYvazZFY0xh?=
 =?utf-8?B?RFV0S2YxTlhLVmFRc015SXgxNmZNSmJ0QWZGS0hGeDc5a3BNUFFHRVk4eVJt?=
 =?utf-8?B?YTZqRWNtZUFTTVNRSWZiTk5IOEJwZmFKTW0vdk9NbE1kY1hCUGdMYkwrbk9a?=
 =?utf-8?B?d21yWHBPbWFSQ2xXRGFCb0psY052QitjTzF2YWpybWozM1luNFRPR1ZFRXBT?=
 =?utf-8?B?RzNVT0FXVEtaTGp2Rk1MNCtyVXdTMjRNS0tGYU5NSFRnOVEySTZEZDZpYlNi?=
 =?utf-8?B?eEtUUUlRMFNlOXdFbXFqeXFwc0ZmdlpPelppUDhuODE3MWFjbkpzU1RCR1JX?=
 =?utf-8?B?L1gybzFwM09BZWVMa2lVVEh3ZVdySDZ3Nmxjb0xCVUtRWFMzb3VycFFsUTZz?=
 =?utf-8?B?L0FmejJVWTJzcXRzVkN3NkRWcWZ2VHQ3OTF1OHlCNmo0QXE2S2JRcWF1RUxH?=
 =?utf-8?B?Y2dTQjJ3YWE3aFdtYm1DVWM5NzEweG1MS0JxMWdmVkF6cjJpMldLcGFFbjQ5?=
 =?utf-8?B?eTVpVzdHVnIxSEhjKzBOcEw0TzVKUXhxNjNzVUgvZnBJeW1hb3lzTEdmNXNY?=
 =?utf-8?B?dGUwYmxJWWhKMkV2R3k1dFFTdE1ZZUgzd2lGNUswazNpaXJrQWRKRWpuK2pK?=
 =?utf-8?B?c1dXWlR2ek5JbCs0R1Z5Q1lGNHpnSmo0QW5DdTl2R3pQMmNMWno2Z1R3dDlM?=
 =?utf-8?B?V0lGNS9oSzNSbVR3NUdrckN4d3NoV3JoRDBXOThDTm9ESlN0TDI0RVdEZWcx?=
 =?utf-8?B?ZklpMGE3U1ZiSmp6L3JqKytKUGQyaDNjRHBlOWJpS3RXaHJyMThkNjV1RDlQ?=
 =?utf-8?B?ZGE4djlEOE9SZzhmbnJ2dmE1clVYaUpJQjZKSXBmdXJTMG9BTC82UHRSVmZU?=
 =?utf-8?B?aG1XeEpMU3V5bWNVVENLL24yN21ZSTFCN1g4U2wrZm8zZEVpTGRiWnpXSmVT?=
 =?utf-8?B?cThSRjBvclgxbWFWY01LaFRhTjQ3c3BaVnR0OEVnMVFyTkpHWG90Q3lvNDQw?=
 =?utf-8?B?R3VhWlBCS3M3RXFQRjVhS0RCdHQ0Y2NZYXFIMG9KVmVHZmxxcnJEbU4vRWE1?=
 =?utf-8?B?R2JueXlTOXFxMlV6U0svSVlaZlJMRFlzS0lQUjJJMGRMWVdVbDRxV1BvVnZh?=
 =?utf-8?B?cXAwSzB5cVduU3I0WHlVSG04TEZXbFc5VmtYUTBZSzFDeXRSdEtsbldOdDdr?=
 =?utf-8?B?T0l1V2tZZG15bkJMMklwRWtFSE1sVFl5a1FLRVpxaFNjdGU1WC9JUXlTUTZN?=
 =?utf-8?B?bDdwcC9hdUR6d3IwWW1YN0hFbzdjTVg0S3Y2bUsxcHB2b25RMFpYUzBIVmN4?=
 =?utf-8?B?MlBRWnc5Y3ZZVFJRVitTMUpkS0pSUExieGhtZ2RkdkZ2d0JoWkpianpYMWEz?=
 =?utf-8?B?UUJRb1RLTm9kb2JaNXBwUUZ1OGFYNWtFRUFTWk9KVml6aCtoL2R2azgvTTFK?=
 =?utf-8?Q?Qu9Vg5ZVa1zuo2zdOsz/y8Ka1tou9WIGruIlMr68laoR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ae009-75ad-4f81-06db-08dae23329af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 02:37:39.8298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCnQwKxHJhwA9u6xZ44+zEFrDr4YCLo8HdAUGmkYZ0E7laWiPZ/jSh489lnNnanlFwq79n4LQCqtCDyuC9jNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 20:30, Tim Huang wrote:
> MES is part of gfxoff and MES suspend and resume are skipped for S0i3.
> But the mes_self_test call path is still in the amdgpu_device_ip_late_init.
> it's should also be skipped for s0ix as no hardware re-initialization
> happened.
> 
> Besides, mes_self_test will free the BO that triggers a lot of warning
> messages while in the suspend state.
> 
> [   81.656085] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425 amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
> [   81.679435] Call Trace:
> [   81.679726]  <TASK>
> [   81.679981]  amdgpu_mes_remove_hw_queue+0x17a/0x230 [amdgpu]
> [   81.680857]  amdgpu_mes_self_test+0x390/0x430 [amdgpu]
> [   81.681665]  mes_v11_0_late_init+0x37/0x50 [amdgpu]
> [   81.682423]  amdgpu_device_ip_late_init+0x53/0x280 [amdgpu]
> [   81.683257]  amdgpu_device_resume+0xae/0x2a0 [amdgpu]
> [   81.684043]  amdgpu_pmops_resume+0x37/0x70 [amdgpu]
> [   81.684818]  pci_pm_resume+0x5c/0xa0
> [   81.685247]  ? pci_pm_thaw+0x90/0x90
> [   81.685658]  dpm_run_callback+0x4e/0x160
> [   81.686110]  device_resume+0xad/0x210
> [   81.686529]  async_resume+0x1e/0x40
> [   81.686931]  async_run_entry_fn+0x33/0x120
> [   81.687405]  process_one_work+0x21d/0x3f0
> [   81.687869]  worker_thread+0x4a/0x3c0
> [   81.688293]  ? process_one_work+0x3f0/0x3f0
> [   81.688777]  kthread+0xff/0x130
> [   81.689157]  ? kthread_complete_and_exit+0x20/0x20
> [   81.689707]  ret_from_fork+0x22/0x30
> [   81.690118]  </TASK>
> [   81.690380] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> v2: make the comment clean and use adev->in_s0ix instead of
> adev->suspend
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 5459366f49ff..970b066b37bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1342,7 +1342,8 @@ static int mes_v11_0_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (!amdgpu_in_reset(adev) &&
> +	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
> +	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
>   	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
>   		amdgpu_mes_self_test(adev);
>   

