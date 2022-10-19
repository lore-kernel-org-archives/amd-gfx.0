Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BEAC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 03:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF49E10EF73;
	Wed, 19 Oct 2022 03:53:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25D410EF73
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 03:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLOu5+Mw5AWKEBDCxPKFaNYKKHOS9ivdKfLOKCIRGZsl/FWgGq2C8qpiS7lggdPNuX+L5htnaMzWNjVISLbFX1SXPAbcF0bJI+caG/4mYMsMFMTN65yK83CG/fqsQo9cg7fp8F0Eerezy8dp86Fnc9WWdQVeMi1sqcjLq+WcGy33paoxJHxE7teK4ZDfOzbW1yeXU2fMsCuV0Mm8hdSN2h17YEBsg8/lf8KlFrWMFAeTchS8nr710zFyyCGPa4CsKsH/sC5hSXNoD/fcS8gykBsM0LPRTKCNVSJ/uoinVQSV8E5gXZ+MiqpRcD4WhjNJxv6f0a0bl2Gx2v+jPSUNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+2T5DNBD1jLwwEDUUXyf9I7TNZiaFa23nrO9hiD9zk=;
 b=Kiwcobkq03S5pIDYAoWg0rgbs1V26X4UPpOdNkE2M14pM7nR5AH/CHOGOGZLZgAzZnorypNzfpeaTeP0+rsIQw7NmMSBEchQuSB7KkwmxcnPoEIoV1dpz28mqyvTFRVKFmRveCK07D2j8BdDa9RINR5FOHhYNmc9ub5RHplSp9+b8pB8EjJObywB9MI0Xf53/CwKZ7QHRLnTXuMwp7estQoDvxaje3o7p4f8t06OnDtOy2Ld8Cvl4gUUDUD9A2A/kSZJ2BznljNes2qQglu3AlagFuEzp7kxaz12EETMuslVfy1hkd0bT2jguveU9IFeF8IAAvk9SLNvDW/BbG0YCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+2T5DNBD1jLwwEDUUXyf9I7TNZiaFa23nrO9hiD9zk=;
 b=umLrF9D/iCxfGjvI1ibf/mKq75ApjK16buoL8oGyGAEpO+migq8Ywq7zM6m/bBLHbLOhD5VVZbOd+tMmtOt639dlrXSb78P2xlcUnTSkoqGrKaa9rkscxffwJNrh2+u5aVcZqcFi7G1SIwKzqeMcWcdE1TL1CI9iDXnmBJk2zss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 03:53:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 03:53:13 +0000
Message-ID: <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
Date: Tue, 18 Oct 2022 23:53:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Content-Language: en-CA
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fd08e9-ff2b-4fe8-8602-08dab1857250
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwJRnrCcuT+MHz037s0bth9zOI3NrCp3iUsojIvzl9AwnLo/LGYk1e/pZvHylQpf9oXKQJCQG6NHZaOlG59hnjsoBkACeMjjfeorZ3JezjnF7uKCVXZlNJOQ2ksE166ART/B8IhGEmHkskTZTs9Qn9YfAjTvts2oaH+9718B20KHdtizs6Td2W1kLY2yeFPtUx3GqahXiTa0RP5TAmD8ER045Vz05VK5GcRpWuDqnZDHgviPpcJhwlpwAN9tYQEglrh4VksU87f7GTJiEt51+gowvdlv+45JgYjj/Jx/iM5oJ04Pb0jrlPe0rwQUn7zXkE4DotUbq5byWKeCRT/Zb79KRAHUPnev6qmu016kjc9zMT1oc2CwO3fYRraYyyXqUOSRJrtkw71HJC2gzU+s059IQ8Htd7b5ZGGrsVsJAifKsCCmYW7oHjnSaW0g1I2WfiV7E/fUeLONh1LKa6LeElfdcD9wgDurwshTfi4YI70rd6pVtJ5oYWpQDPdQCo4yE1hl/Tb0BcsacIKIIBTNb39CkvJXuTVA7b5C8Sg+ZJNu3qwNghbk5K1/oZywzfrtsyajfMkDvtFXqioUUcp4w3wKZVfD3TDlmZ2al47GP24kmFl3RMXayPzs+9wOE/es6ujY36tNYyqcE1VMgbgZ+3lFQRQ8eXC9jfwdErunGMPkEQhMNEUeeCyWInvBhKLj7dytFBZxDOb/p+czSQLRYXge5g4XVaH1CZSuhyGvyIOOzinNsbFDmbA2HEjEtdyHWbYm+0i5nDkn6vdv+Ougexqx7TuvQ3dn6y6zgdw09GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(478600001)(54906003)(6486002)(6512007)(26005)(8676002)(6666004)(66556008)(4326008)(66946007)(66476007)(44832011)(6506007)(41300700001)(53546011)(2616005)(5660300002)(8936002)(83380400001)(316002)(186003)(4001150100001)(2906002)(38100700002)(31686004)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytSOWFuakR1K3FtU0Y0N1ZxOGRJVy92QVZmRFlMTUFIRFRwNjRQdzJyTnJZ?=
 =?utf-8?B?eTIxSWdydzVwZTlCNCs0dDlkeFRucVcrczN3OHZISGpySnVad2FIVUI3QldC?=
 =?utf-8?B?elN3aXRzd1c1S0owOUpId0xYTy83NEdYM2xsNlNGc0lUak9OUGFQZU1pdkxa?=
 =?utf-8?B?azVkVnJzMUFoa0VNZGZ4ZG9BOERBMXJqTllCNmtLS21zNzRVM3lNSkJ6eWMz?=
 =?utf-8?B?dWJ5LzhET0tRd1NHMkh6ZTBGVlVqVjJmM3JIeXdIT1l3QnJEUDZaRk5SVWY3?=
 =?utf-8?B?UmNRTUpHYXRvNlZuVlg0TFl0YkJ5WnJON2w4UnpqMUpWZW43ZkVRTERZOXR3?=
 =?utf-8?B?UDJiWE9ialEyUTdwaW5sUnBqM3pIYVA2Zm16ZjRWTGUyMm9aYXhvU1RDeHI5?=
 =?utf-8?B?N1NXZ2ZoRzFmRnQvNjU0aDJCS3FSdFEwMlpQYjIzcmh4MGdKajFYbmhoVjhj?=
 =?utf-8?B?YXB2TXE0aUN6NngyMytSd2hhNEI4QTBGWGF4V3oyeUZTOU5xOWlEcmQraE1j?=
 =?utf-8?B?Qk41V0gxUkdRVGRuMVBqNWt5aUpVaUJ0c2NOWkxMZE12eXBWUElZWUpjNGdW?=
 =?utf-8?B?MlRjdnkyZTRsWVJXZHhldyt1aVB2V2dDQmpxcHV1cXprUFZ5bHBHS2o2c0tj?=
 =?utf-8?B?cVZlUG5TTlFzbGNON3dLM2ozODhRYXpQcVF1S2YxSU1uRkVTVjJkWVlJRXly?=
 =?utf-8?B?QzA4NVo4YllZcWQ4QXFIVzl5WFF6WVBaV3JwQlNwak1iVnpQM1VqU1ZmdXhW?=
 =?utf-8?B?QjVKOVRlcmtGcUxYTHBIejBzY2RDMnMwR3VUajlLOW45cWNkU0IxeDJEYWlV?=
 =?utf-8?B?LzRwL05yNnlqWW1MeHk2elVpN0FvRlNKeGJoTWw0MWlRV3pNemRNNjZJSW42?=
 =?utf-8?B?aDlycGFTSVJ2a0ZCMW5VeFNkRjRUaW5WeXI1V25RNjluWVFTaldTUmNUNkxU?=
 =?utf-8?B?UjRWc2tzazZyL2QwdGpwUVUzcURSTjVOVFZTZVlmSEF2RHVqMWRtUGJ0WG9k?=
 =?utf-8?B?bmF5TkJoOUlNWFB6WGdBekZORjQvOU13a3BwWGtsWldCYkxXVjJUWDQzOS9B?=
 =?utf-8?B?NTdkMkpnaHZFL0d0WHhTblZKNDM0WEJPK1NOMFFUanNIUjdIUzYyNmZWZEY5?=
 =?utf-8?B?MWptK2VMWGFaVFZwSjNpTHlPNWxNVUpMM2NYeGJzUHI0SjFUY3NZTncrcDJD?=
 =?utf-8?B?UDBvUFRqeEJtNWh6VXdYdE9iQjFOZkxVZk1lZDRLZDRISmZmck1mRjVKV2U1?=
 =?utf-8?B?WkNSalhXTDlzU2pKc2dDTkh2c2xheFRvYTdvaU9Id1NxdGk0TnJsc3ZjS2Nu?=
 =?utf-8?B?WTNFRnJIWjdVR3ZpL0dzdlpHVmN5L0Z5QjhOWWlkWHlsWFRHblI5emlMeGNk?=
 =?utf-8?B?QVQxUnQ1bndiNStSTXJSZnZaa0RGV2t2Kzk4Rlk4aUxTa3NWWHJBZ2NRV0U2?=
 =?utf-8?B?OThaMW1wVXNCaC9JamwxWFJ5NXRqYkNJcmFjZGlVQ25RSWxTSUdLZ05FSHhx?=
 =?utf-8?B?Q1FBSDZFTGEyeDhEM2dUbXNBMjRqYURIU0cwd0R2RncvUUJ5N2tsS2psbjBY?=
 =?utf-8?B?Vno4K0U0ZlpRdTV5L2RlNVhNc1hkVlMvNktxY3BiaUs4ZFpyeXc4RVdFRFZD?=
 =?utf-8?B?cDlqL2QydURJY2xBTWRGSURBcmpNdllhYmUzaW96b1IyRGVzeWt4ZmZkT21l?=
 =?utf-8?B?OGs3VzhVR1pPWkJJM1dKdGpHek9JSk9oWmRSWXRwb0QzRHYxUTFsWk9MMGVr?=
 =?utf-8?B?UTU3b3NtUGlzL0twZnlkczFYdnM0S1JlbkRpQ0JMSGtFa2d6Rk1EV2RUMnpL?=
 =?utf-8?B?WUhKNHgvajlBL1ZkVWRuQThpNTUxenVYbURSdTU0NW9lTGVCRjVjSEdKM21P?=
 =?utf-8?B?clpLcFRkdTNEazFncHIyQjVxclNpQm12ZzlsYVd1N0ZuYzdaQ2dGYmpSZExT?=
 =?utf-8?B?YS91Z0JaQXlJbExYSU1ua28yNG92Ykt2L0s2Qm5Kc0FEVzFNdm1naHd3cXlQ?=
 =?utf-8?B?UDBqTEJ4OHEzOFB3UUNxK1BJYVVibW1aZTZHYjg3d085SnNRSFJPTXdjZGor?=
 =?utf-8?B?MjJ1c1BHbS93VGprYzdldHo0ZXVnM0pGNEQwY3JWTm1selBJamlhL2hBUTdn?=
 =?utf-8?Q?g4efadu3M0iOauenFSPolJok3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fd08e9-ff2b-4fe8-8602-08dab1857250
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 03:53:13.4399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TBjBo9j58w4SFwLIcTqzfyrJGIOnXtQchokAE8YDGu/fqIu++ZV1adR5wmu5Jjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 23:45, YuBiao Wang wrote:
> Temporary disable mes self teset for gc 11.0.3 during gpu_recovery.
> 

Is this "temporary" as in "we'll revert this commit later", or is
it "temporary" as in the code execution itself?

> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e0445e8cc342..5b8362727226 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5381,7 +5381,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>  		}
>  
> -		if (adev->enable_mes)
> +		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3))
>  			amdgpu_mes_self_test(tmp_adev);

Is this just for this version of the IP or this and any newer versions?

Regards,
Luben

>  
>  		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
