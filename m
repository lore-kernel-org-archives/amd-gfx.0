Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543D361A3A
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 543D361A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7B56ECFB;
	Fri,  1 Oct 2021 14:28:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6574D6ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEmJP87clszRGJXk3RKiSKwpCpBit2Mwp6X6TdX2bdjHRVtWlh9Jn4NhwoETvRCzOo6LYrl5R9l0N1T0k130UpasWCEkFdgRxvX1Ar+JvTr6tbb85fqVMhWaHWLFJZhereDLJVbb3MmkNDVhBJRewTvVFdq+pousVVgiUIlPxfTPNjDZSyXgYcRZV6Wzlfs3MEmYexxPIP0nkL/lnLPlABLTItz8bn3HzrLR0cf3D9dxI8sAcWqmqk9gzqJ71+F4Lw+rUWYe69aGuplVImCeTC1soa74uIkmkgwiY+bMjMSLkuKUJU3qg8TcENXxAWdvcK44TIRaxS5tAjglNO4XFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em4+QS263cl7L6vhfibDGT9PQH5ZGc6wO4GYDWg1/TI=;
 b=QwZb2DNtbM4YHBfRDX+lk4dzMa/4yCy+M+1AIahP/+2BUBHQDoBUF6vH6VA4azlpw2fjOdjKEyfWBXUhIPE1FAxWRTFka/vWPopmwgoc077Yvg8jBbxKw7Zt4lP8J94i711+tPw7OFzAXTjpzcKDQGN1iVMmDSBvzXDNA26OG03Ga9Hg2ht2a5RTeJTVoFFa2V3lEboNhQc+dDfl1zVVFhVBrFjOYbCBRo+0I2y5cMU/WFiT72zXmJxFfoQT5XOQ97U+UnfaB47X+yZllpNxazMJocDYGtKKEMNdc60kzhfkhP8UyXl4r7A9jnni6BoZixtjFtKg2vqIEvSmmOm4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em4+QS263cl7L6vhfibDGT9PQH5ZGc6wO4GYDWg1/TI=;
 b=4jqUyJ8w+yqKWf9aVfZ7kWyhHgYwxqqvNfR+SMHV4AXqJ/N+15IE/jy+fcFZmF56pkJQD0O7MxhCuoNEqnOWHH7Oki621i0gOqFmVKMBuTxQEzeIaeUk/ILi/8GPC+ktsdT2LTo7ktquESAM386VYlVhLyCwolxzRFboE+O6+MY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 14:28:51 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 14:28:51 +0000
Subject: Re: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20211001020000.14501-1-guchun.chen@amd.com>
 <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
 <DM5PR12MB2469D34B746A0C1927906879F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <b45147f2-9ced-23f2-5020-2ff9aff1e12d@amd.com>
Date: Fri, 1 Oct 2021 10:28:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM5PR12MB2469D34B746A0C1927906879F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:3ee6:5fc9:7b9f:84b9]
 (2607:fea8:3edf:49b0:3ee6:5fc9:7b9f:84b9) by
 YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 14:28:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1201cb68-643e-4d11-ca12-08d984e7ca10
X-MS-TrafficTypeDiagnostic: DM6PR12MB4091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB409192AEAE12227CAF34EAFFEAAB9@DM6PR12MB4091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwF6687ncKxQF4P4yuixVIn2RHAdgwD8tb5sdt93PM5AYrWmbQqc9jPOKW/Y14rpU34FZpRqsj1LChiyuP31rXBDKr++svLLVaAh1josZYiCUyXz1flAtqABtJU+yDOs0I04BVTpMX4f+4TyhIOwtord8DTAlGe82GfvBV/f90eo+EoeLxOmU5xM3ud3u0wUa5d7WB8RcsA47EACsmLuJlHdNHMzYyxbjIHGt845mAf1J4+Sb527+E0kAeLez4ZEZEeTA5bfIpfJydjA8vrsrCLkUrAf+gtIYTaSEiGZSHSNCl52hPvQaM9wXJx747eXRBipehZaxWa7z23zNkVXFVKSX0+vxyuySRtr2up9C8zozi7fL6Kj++QYKis8/jXLlu9X+zugSRcGxlXioBZAoIiybvGD39Bek0MW8k4ZKJxUbutcwZ3rW0RvQAVdfA3FKrfY9aPQLoOa8uvLctxCdWsO2rCAUOr98vbmjGovTIr4amewwFkwP/a1SYou42Pq/eBe6c9nNGQ/C1QViMa99R4Qb6HoX0rhUGV9PTn4rYYxYM2ddTwE4uai7YNu7UrurPhKGvBKEgOsSVa70lNZlX7yB+/0eSJ4ILAB4vOwtCqNogaLXdJIEEu+Ct+Z1QH9mVK9K14615sx9N9TEr1YQVyWbXj/+pS5fQ6qNfWp8gG9z9RmxWoQC8SxVoMHn1531pxw26vTuH0kRgAu0lw82WW/Xy0keOJi9dsybtcaalo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(86362001)(66476007)(66556008)(6486002)(110136005)(316002)(66946007)(2906002)(83380400001)(508600001)(186003)(36756003)(5660300002)(6636002)(44832011)(53546011)(31686004)(2616005)(8676002)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dpTHBZbjNvYzdZMnFTcFZpUjIzK3VRQUtLS2pmZnJQaHhoLzZNb3FjU2ha?=
 =?utf-8?B?clRaVGhFdm0zeGFhVUo5Q29xeFlMcUN2THRHYWZzc0taR1BqcVhFTmJLeUw2?=
 =?utf-8?B?SEdObDhjemVLVVVwWjcvSi9LTWVxd01IN2FNVXE0WFN1WDdVcGZNSzRIWERu?=
 =?utf-8?B?cUdHOGtPdEwxNEY2eFlCNEJoUFA1R2wxTHRuNThNM0YxaTdhanhCVUlQdTdO?=
 =?utf-8?B?M0VMSG9Nd1J3OUpOOTVERGZJOTNZaCsxOC9IYmoyNzhvaGtRWCtSRHRnbTlk?=
 =?utf-8?B?ZDlQV2k1MkdKbUhpMlZGQjlQQTNiaHFncVRyZlIvSVNZK05jeG5LdXRIVkRv?=
 =?utf-8?B?SnZxR1hTL25hYy93OTB1cTVteWFEdEhPck1TWUIxSlpxM2hVZjRieUhFRzFr?=
 =?utf-8?B?RFdsN1ZqZHlUVDl6TlRESDBxWFVNM1NQVGJyd1cvdFRxVU13RUE1UFFJVnJH?=
 =?utf-8?B?QXFPeStBeHNiWjFFWDN2RWlnVFg2dWJrS2dCOG1mSUdISmdPOG8zeTN6Y0pn?=
 =?utf-8?B?dGcya2JJR2Z3d3VxSUdtN04zbHRNazBoOFA5S3hSakJHckhDRTZSYmdjemFD?=
 =?utf-8?B?a011L0IzV1QwNlBSV2ZPMnhDbElLS2x6ZG85MWFML3EvUDVGRFNhUHR5WC83?=
 =?utf-8?B?OTNKNVZPV0tGL2UvZ2FDVU12ZUVxYXg3aVNUVi9JL3dOUVBCTFdqNDdvaHha?=
 =?utf-8?B?SU5sUlE0eHpkaXRXWXFwbGlZelZ6T3hNaXJVSkwrWmtRdGQzVHM4VHMyejZZ?=
 =?utf-8?B?dHUrdzhDVVRHcThDdWYwQlZkWVNZa01Tcy81R0FVUi90M0xFRmdTVFRuMkMv?=
 =?utf-8?B?RnJrTnltM2JxZzNSSHZXTWNJcE0xbnRHVlU1eXRpdjFqanpXdmJPNThsWTlq?=
 =?utf-8?B?TzBWUHhsK1NQYVJpak0rOEZ6VWNoN0Jmc3plWGhJMWZQUm5mZEFRSFNFdE9o?=
 =?utf-8?B?K0R1TTZmUnBZUndnQVhxb0xzTC9BS0d0SWhDbEM0YlZrcGN3VHlpOTlUbldV?=
 =?utf-8?B?MlVnTTBJdHBqV3BCcnB5RzNWSElYbWxrcHMxUHgxdklZZWlsbHQ3cTZUa1RR?=
 =?utf-8?B?NUROUHRWT09TYlVqN0JrZkQxcGF4OHJ2Q012Sm51TkRwdm1GRVFkaHZSOGNm?=
 =?utf-8?B?WitTbEJzZkRpTDRTNFBPVXM2RWlCbHYrREI2dW1GQkZHTmZSUkhDYi9WRW5J?=
 =?utf-8?B?YmNRcHFRcitzRUZaMUVSemJ4aE9TNXNGNjBQQUpuMmFJZVNhSUptTzhPKzBl?=
 =?utf-8?B?bDBnRlVDd1VzcEtyaW1Fb3VsRmlkTm1GejV0dWw3MERGTEVIQXRjbFVZMUgw?=
 =?utf-8?B?TEg4Z1ZlUzlvaFp6MTZqdWQvbmFVOHUyaURpWlMxRkNvTFhCS1RkQ1M1di85?=
 =?utf-8?B?aksyUE40NGN2b2h3MkNxZ1hXek15SUZlWWFFc0g1ZTRzOUFMQlZHczhzeVlF?=
 =?utf-8?B?ak54ODVkS0V2YnBSOXFwYWk1b0ZXbUJqTEpQeDUzaFg4a21KM0R5LzdlRVYy?=
 =?utf-8?B?aUwxdURoMys3M2hpd2FuaFk1dzdPMFFrUTFvMlNjNWVYNmwyakFjeHVNYWdt?=
 =?utf-8?B?SkpEZG9rNFl6Si91dGJRWnVXdXQ0aWNxSzV4SGIwS3ZJOSt5MWRLbSs1M2VS?=
 =?utf-8?B?cS9OU3U5L2NGOSs1RElEK0pSaEZSeXkrZ0daQSsrZmJFYUt3aVBvQ3Zkcnl5?=
 =?utf-8?B?eFhMdGsrb0lYdjNFNWg0dW9zbmVDZUZaNEYvcVQ2MjFEMXliZDlXeURyYkp1?=
 =?utf-8?B?OURuM1EzdkY5aHliaTBEU0VuTmR3S1RXSWZZK0ZCTmlXKzJVU25lSGpSMlc5?=
 =?utf-8?B?eUZaSDg2RlpiQ0t4ek1jNTdUK3ZFdXdXWVZuTjN2VTl0UUtncWpLUmtQR1Nh?=
 =?utf-8?Q?OhlQyOmC6KV05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1201cb68-643e-4d11-ca12-08d984e7ca10
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:28:51.6063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J56eXkw6AH+cUpdw4GS9lobyqotkRYJIxiZIqJRgpE6koqy9udJLAaFDCa1lhfcK2RXIRe/kniEOzkOgRp5o6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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

No, scheduler restart and device unlock must take place 
inamdgpu_pci_resume (see struct pci_error_handlers for the various 
states of PCI recovery). So just add a flag (probably in amdgpu_device) 
so we can remember what pci_channel_state_t we came from (unfortunately 
it's not passed to us in  amdgpu_pci_resume) and unless it's set don't 
do anything in amdgpu_pci_resume.

Andrey

On 2021-10-01 4:21 a.m., Chen, Guchun wrote:
> [Public]
>
> Hi Andrey,
>
> Do you mean to move the code of drm_sched_resubmit_jobs and drm_sched_start in amdgpu_pci_resume to amdgpu_pci_error_detected, under the case pci_channel_io_frozen?
> Then leave amdgpu_pci_resume as a null function, and in this way, we can drop the acquire/lock write lock for case of pci_channel_io_normal as well?
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, October 1, 2021 10:22 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add missed write lock for pci detected state pci_channel_io_normal
>
> On 2021-09-30 10:00 p.m., Guchun Chen wrote:
>
>> When a PCI error state pci_channel_io_normal is detectd, it will
>> report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI driver
>> will continue the execution of PCI resume callback report_resume by
>> pci_walk_bridge, and the callback will go into amdgpu_pci_resume
>> finally, where write lock is releasd unconditionally without acquiring
>> such lock.
>
> Good catch but, the issue is even wider in scope, what about drm_sched_resubmit_jobs and drm_sched_start called without being stopped before ? Better to put the entire scope of code in this function under flag that set only in pci_channel_io_frozen. As far as i remember we don't need to do anything in case of pci_channel_io_normal.
>
> Andrey
>
>
>> Fixes: c9a6b82f45e2("drm/amdgpu: Implement DPC recovery")
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bb5ad2b6ca13..12f822d51de2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5370,6 +5370,7 @@ pci_ers_result_t
>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>    
>>    	switch (state) {
>>    	case pci_channel_io_normal:
>> +		amdgpu_device_lock_adev(adev, NULL);
>>    		return PCI_ERS_RESULT_CAN_RECOVER;
>>    	/* Fatal error, prepare for slot reset */
>>    	case pci_channel_io_frozen:
