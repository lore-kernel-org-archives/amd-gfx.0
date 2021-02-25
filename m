Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3FD64E21
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3FD64E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B366C6EC53;
	Thu, 25 Feb 2021 07:46:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178606EC4D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 07:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyUp4QeEqhoLW85x9btTzzAQFZ2jqDvpJyepdEvFy+IdG+hvVkauGqUBq/nXJfSIxeQHimTl9x0CQsDB+CodNcyNQD6xG0zP5fIu3CTDvSiEHxC1WYZhEUe31P1w0ZTlFDIIDnITSzeWwcxsiXE0RjyVTABdrnibdsVoudevJoixW7i4I/I8AYcnAcQkSVq25CnoyxZk8zKCmSMsy+Djf+iXSz6IolZNkoT+SjcS33scTTE9mOGBX0TZUzDVwBLV5oajtECYrsEzv9B5PM3QzjOdID2/PKEOeDhTyxKVgdKfbmETKSzPunBLRRKGUr0Hr+xPhEWyBLDCy094d3SAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucU+yFy1wL8hUnanhSw1psqzPV5NH9XkZPbZBuXxgs4=;
 b=YDckiRxpdLUDt9nfijYD7ZvgxH7aCtO8uER1dxcEcJss/sooWFMYgOOAFJHZGPhtYHdNpl0mG+mJBXiBkUFr4l1aBduZ4VWD8jzhkgDFOpcwpx0QqGsy9MeAfrBDzMW1t7ziVpFzH283S5aV1HVGYnT3KDZ4dB5DNB142NEDLJU00X/8kXBzwlVBiCeryZJQDJNkSL3PBmfE0XP08BdBULfiLB0OFYaqtMrjoLpzkM/BYhGCbpnR/F/YJG54hmwZeuAn5I1lzCFe/3gaBrTjunrP9hoT51sWTy8v3U7narmRz/4nU605zq0Fgtlev5b3MywzqDYzmdGS67r5AjnO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucU+yFy1wL8hUnanhSw1psqzPV5NH9XkZPbZBuXxgs4=;
 b=nOczZSuJAHH5+3nIObiiOLgR3AWT2bPfFFpul0WHII2Lqsq37p5M0jO0kcl0zaS6JJwORWqdImMNqU166DbKWB25CDv8X3z0Qf1An62XNju19jtv+NzMYR1mNOaL3Yyt+sxja4qJLaeaqlkRS0FX/ON7Wya/6DZW3xo1m/9fTII=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 07:46:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 07:46:31 +0000
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
 <20210225052724.36412-2-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f8ce84fd-ff98-026a-c424-28338fe9e225@amd.com>
Date: Thu, 25 Feb 2021 08:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210225052724.36412-2-Jingwen.Chen2@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fc8:43:f4c0:95af]
X-ClientProxiedBy: AM0PR02CA0142.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::9) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af]
 (2a02:908:1252:fb60:fc8:43:f4c0:95af) by
 AM0PR02CA0142.eurprd02.prod.outlook.com (2603:10a6:20b:28d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 07:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c34a5fa-1ee8-4aed-179d-08d8d96177b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3790DA43B0E6BF9979832C21839E9@MN2PR12MB3790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2ZZy0nFa84eulww8E5nulSQsKGhrq8nVwgxs9W/NXApiF2avd9xAitn1kWGlAOrf+DvyBbt/w9XmLpf/nm4H/+AorpGfNPetPrG0vNs0fEfShppdqV4PPQ8X/Qs1P7YWre8bf3RM/mEKIxnAzGea9qKdQ46LQbSpkA5cyD1iNtJ4X0J1G8qBHOh+b/l0HRRirXfFqcqeeHGFdI0Q92lQCgBhcv2mNH4ObSIHju9XFc6pIl+fl+n2B2jRFFRn2dNnk8KlNy6M+EZ6dtEgKrqAQkpovrTTrYzQbU2J0ljx+Gz9WJwlq9sfuXIEmxo+JbLsm3FhF/IMKk3V9l1jjqv0Wq1ueL4BAOdr3luoIi4gZdNsbx8EL4oA9pSE7gUcVEFq8WFasiDqzrOjzIpLABdMGrdiBPJ6F4cdL7IE1vYmvWf/DldXUX0YyVn2WeIccz/YGiAqDIMM66IeCLnsraJo3jUSotTP5GwbX8z+AdpB6sOfT4cn5EsoKa6snYdufeTDu9C5UUMkAlovFKtyS55BjjcfLjHWhZ00d/f6dybvT/+EPqbUojQBUlg+PpM/OY2Sve/PXgz8mXjvT2sNhX8m0SPpULzeGnIbUnAv9uq2EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(31696002)(83380400001)(2906002)(6666004)(36756003)(5660300002)(6486002)(478600001)(52116002)(8936002)(31686004)(8676002)(16526019)(316002)(186003)(2616005)(86362001)(66556008)(66476007)(4326008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHl0WGdmNm1GdldWMFJ3S0RlU1dQTEhaWW1MVk1abmZWbUsyV0NRaFh5TGVI?=
 =?utf-8?B?SjZRWnllSGpSbU5tV3paR1YyaStDalRoRldGUk9QZUJlWjgwVE1wZWN0UU9l?=
 =?utf-8?B?Vlh4dmpLcVFkNjFSNEpPVUJxM2JjOEFoS1FKd0lVTFo5UnpWd0xCT29sSHF4?=
 =?utf-8?B?ZUJETnpmN05sQ3A3QS9YbjBMNmdlT1lOd0RLZ0lib2ZSMDhFMmJYY0IxZyt2?=
 =?utf-8?B?NUJ6eEMrR2p2Y0kxaXRob1lJckpwVTRYU0dyQlJpRUNWeEtvTlJGSzdtMnpK?=
 =?utf-8?B?U1o3N20wWGJScE10MS9maDV5Sy9tOWtlcGdTbEpIYzdVa3oyV21PQjV4SGQx?=
 =?utf-8?B?R3VDOTlhTTNOT3hWMnVDOXFTUzdPSklyTElYWXJxRnVmUFZGUjVudk82ZFUw?=
 =?utf-8?B?bXBER3RGN3pxcEhpcEVaK2xjWmRTZmRLbjlGVDRXTlhGdWVUWWNFMzhuV01K?=
 =?utf-8?B?amhtTVpMVzZMbjMrdDdOSllqSjBRM2p5ZEJhYTlyVURpakVnQWl5VXpsZ2FM?=
 =?utf-8?B?K0szdGM5bko2OE9JcWlVeXlJR3lxTjFSZEp6bzVkb0VUQzJnTjlQOTJMUGRu?=
 =?utf-8?B?NWlVby9xVHhnZFRNMExzbUdLNU5kVW1Ja0JFak8yck5JU2d0RDFGVzZGNFVN?=
 =?utf-8?B?L1MwVk13ZzhZbGxtQnpHZ3ZMWnlWRFlocWZxYUdXc3pOUWM2RldOWlhNR1Zj?=
 =?utf-8?B?V240ZDRCSi8zeTRIbStSL1MrelNTR1JINVpYayt6Y04wYmF2cmFwK2FHOU1w?=
 =?utf-8?B?RWxaTmdQakFwVmhXbWV2ditiZUU1NHVrK0xRSTJEUzV5Mzk4Z3hESFI4dGo4?=
 =?utf-8?B?MWh1ZG1wajR4ZmlhYUNOcWhMc2FycjRaaUJtYjlldGp0dUlLc09sdGg0Y3A3?=
 =?utf-8?B?VEhGNEU1eWVpeWx0dWZGcWd4SEg4ZTYwVFVJelJhRVl6SldScDNSTlZoTC9w?=
 =?utf-8?B?c01PWlp1Ni8rQ25INDN6TGc4aWMvc3hHSkpUYzZlb0VoUVFFRTlTOXJJUkpT?=
 =?utf-8?B?K1lxVXdUNjdHWG05UVlRbmZyeWFhbkVodE1lUUFCVVlyQ0tSV2t4M0ZxS3Fy?=
 =?utf-8?B?alpjcG5LZUNiaG5aWWJoY0t5b0ttUUVQRFp3aEdPYVhCVUJKU0VLeFRiZVNO?=
 =?utf-8?B?bXNKRC9Bd1pNS1ZuRklpL05kWkFxZGtuL2xQajBPaHlZWGgxdWxad1J4NmFI?=
 =?utf-8?B?djRuN2NpM0FNNXRFWmVIUXhnZzBnUzVhMmxqdEU0ZU1zRDc3MmVwQ3FFTE8v?=
 =?utf-8?B?d1R4Vi9qNWNFcHpPa3ZUVjUrbFd5ZkszdkZXSjgxNnBFaWxnc09pN05iR2Jz?=
 =?utf-8?B?azZMM2hXT2ZCcWdxQkFqMGNYTTV0eGZmdk03Ym1wTU1JWjZaQURaam9NK1BN?=
 =?utf-8?B?bUU5bUpSTHZZR0tUTTdUcWpaQ3VUZ2NwTG1tV3VKUkttYVh2Y29WQmpKWjMw?=
 =?utf-8?B?Q0F4aElNUnZrWlVSNjFxVFlKU1ZFQjF6U3hycXFRNVh0ZG1QckVMT2FDSE1n?=
 =?utf-8?B?SXc5Rnd6ZWsybGFlaHBWYW8zakZ5bmdGWkpKeGZUNGU4UWw0bmxMcGJIMVJh?=
 =?utf-8?B?SVVmNEd1RFl1c1VNTElWVEgvQ0FJTEppZWpiRWwySlBhKzJGOUo4Y28yU3hm?=
 =?utf-8?B?aVdzeGtBb0orOFhoQXQ0ZkNsK0wwTllhTThuNkVoRlQvUWpCc3dKblVRNERv?=
 =?utf-8?B?OEFzRER1bm54ZExVMFg3cGZ3YzhBOHkwN3VCTklNR2hqVmxRaE5NSlBORXZh?=
 =?utf-8?B?V21DdVowK3AyR3d2YW5UZ1dSaWNWd25MemN3V3NmOWo5OTIvRm1CdThaTjBV?=
 =?utf-8?B?QnVweWxNblJCak9UVGVBRkZTcjk5QUgybFJTSkltaDFMNjlkQldhRjZDS2N4?=
 =?utf-8?Q?uD+dnWbBMaoxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c34a5fa-1ee8-4aed-179d-08d8d96177b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 07:46:31.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TXAcUm+lGzxXOOz1pmzgXaIfVQzc5kaBqRSu2cJTxIpYnXYQxuVO/nEqxrkGg5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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
Cc: monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.02.21 um 06:27 schrieb Jingwen Chen:
> [Why]
> when a job is scheduled during TDR(after device reset count
> increase and before drm_sched_stop), this job won't do vm_flush
> when resubmit itself after GPU reset done. This can lead to
> a page fault.
>
> [How]
> Always do vm_flush for resubmit job.

NAK, what do you think amdgpu_vmid_had_gpu_reset already does?

Christian.

>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fdbe7d4e8b8b..4af2c5d15950 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1088,7 +1088,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>   
> -	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +	if (amdgpu_vmid_had_gpu_reset(adev, id)	||
> +		(job->base.flags & DRM_FLAG_RESUBMIT_JOB)) {
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
