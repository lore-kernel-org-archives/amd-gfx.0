Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CB810E144;
	Fri, 20 May 2022 14:06:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666E410E144
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bun8h5hFkrGtGAL8p0OPoOERGGvG9MbchpD53NeG8+2KmQDbZSMcWjvUvOrsXwSosBcx3ZarVhK2q8VTUoRrCefsWuBFjryBUjpaZFjgb/jgLA1Gh0XNkjJTdzz+G1JCtFNPhs4Qn65T7DD6bLaWIo3AC0UNcQkhlgzEREbjsRCoS35dtfdyTGz5gicF5MM2vrUDeUrU0Jkjn+WEZb3Ed6SRSEYxyvar1ns7DNilV4NaTjs62aIy/YZl5aQwltPvAJAQ49uhIAZtuWesgmFSU/+al4Hpxk51hJ5cGhCMLQs0EHWNyGqiePxwdN/a25NEEXMYBXikMAiCq4MBXYWr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxWAoQdi1v7YmV2i0XRmTF+q6rwfENFy2gaP3EVUino=;
 b=jLwbfVaKiB5IWWMYGoStNmTlZKXtjurEZx8FqfNvevRysQbpdrBqqRhWr55Uk2abNgPGKkNmDiDtliOTm9V1Pv7sdSsDIH26jY6HVYwXie/OS2ABuBCWbqMVgImaEAM9pQoGNnQVLVaoQp9bcv4tq3IA935iYEyI/zzqpbRNZUOK0KkfkAwa8SP1v6v5HED5JbEDUj2rRzWJBOGQDgR5Ty+w1hZXqkFwMPn+px0T5ekLYT1pLxPX8JYI0ZkmO4788RnvloPQdla7nrrXnrTf/5YfA0PT3srORQ/96Tw8FisohtFD7eYHRFwyxcHeZM0PeRfACnlg7nJmaR6qcV2+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxWAoQdi1v7YmV2i0XRmTF+q6rwfENFy2gaP3EVUino=;
 b=nQNtSTW/d4SIRYD1V+khiZPOfotE93Rj6R6I9nAWzeOZpj7XTGagxI7G/LKGaC8N0GbUt3aYProLbKz4MBo1w8sPIEjjBybBp/HCsi03yVzz4dvFCu94dQFs/qQcuiED1xrqUQouVFg8YLOWjPlqA9Wm00tZ/1rj6tulcz8ZX7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 14:06:43 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Fri, 20 May 2022
 14:06:43 +0000
Message-ID: <1b19f85d-0ac7-3559-92a7-f7c7c6571512@amd.com>
Date: Fri, 20 May 2022 16:06:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::29) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0082f7a7-544e-4fea-50a7-08da3a69f7c5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29956399EA5737DE72CBA970F2D39@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKYrY89qhZmy61GH570EzP/8ZT60ItuHRShdvorQ/7WUCXCrZs1MMv3RVhqWHf3CeWVncObHdw1QIcfrJwWkW9mNLNF1TqyYHW434CFqKtMTYZXEZ4aCWkoynQDSzWct/YmkE2aGVO0g/8Rd21M+5iOxE6JT+jhcLRuVYJuFtcx0jlsfyEsHAjwqGtbzlgD5On6/sEYu1PEQQHDXQWB4dU2zvTR1df42FuJwxXeT7DEB/NY3Bn+IDozHiwaO4cAKC6n7rL8bB2DxVrFCuP4ZlSumKD9vbXwmoaA6cFWEuIBH1cGwj9BWvPx4IlESLdb6k4mYeMnERbrSzbk26R80xTY4UVY3Gvm0sq/WgvQLitR4O+Ugt2xWJ8xct9WQKvy6UxwV0lLITO4d/d3LaWBmtz4RBAhQvXQxjRrLbu7owv1fNYcLqorh8/IlZEAvX0iZh7NtCQTtaQrJusLeWhFBiuEW9sY+vH4pq7NoET9OErBtpvQQn3pD393P+9Zafv2S4eDBvrIkEmSbCl6zVpmMuaS7dKnkciFU0DUNnqwHDKgRUDOjTZ9+yvuMmHMe/acdOG6EjD/qJ569+wYaHfN/cjVfUfa9Q4q6UHRfDFWgGHPKpHqcjO2H+qS/KnsOKVCJRXgYcHQrz+LEsOfJEZVsH5lhmkEzLRYToi2YdXZN81U7IGnwUNqBvaLBy2qVJmU/CbW+LPP1Fw2ZByMdQBtXjasQqv3txyjZu7Bb3fMl15E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(36756003)(66476007)(31686004)(316002)(83380400001)(508600001)(2616005)(66946007)(66556008)(4326008)(6486002)(186003)(31696002)(6506007)(2906002)(53546011)(6666004)(6512007)(38100700002)(5660300002)(8936002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NtUDRlZVBlSC9DMWRoTjhFOWFzeUtmbFZvZWdGWXF3R3pNbGczZWo3VXl3?=
 =?utf-8?B?elhJNGVocjFhRmw2Y2tuY0FMSFF1WmZUWDh0czFpQlc4Smowam1XbHBjUGlO?=
 =?utf-8?B?NnNTU3NLRzF6UVZaZlhEdkxseEszczVzZEpmR0pyVk9qQW8zSlRuQkJZdFBs?=
 =?utf-8?B?cmYvcldwaldYc00rWm5mYkd1ZElSS0h3eUE1V09xRGNWTFoyZDBZZXRSSlJk?=
 =?utf-8?B?TlZOdWErTmIzelBGTldiNmRmUGt4SStRL1ZvaWJwNjhCVzVEZFYraVB6YURS?=
 =?utf-8?B?SkZJMERGRUdzVjhLbUNTUkVrNzc0a0N6NkJZYUk4WUN5U0RyREZ3S3pjb0JU?=
 =?utf-8?B?c2kxUFN0SnZKckJTUWpKR1FHZzhLNWY1L2pQeHZKNEhFbldVdmVqTitDZlB2?=
 =?utf-8?B?eUhSSFc4RzBpamZNZGsreW5FWnVmTmE0enRtd0xmMEsybTNOdGNIZ2pCLy8x?=
 =?utf-8?B?MnlpRXFGSWIwcjhrRUxEK0UzNmRrd0J2b0MxNVhtZWN1Qi8wNXhqdElHOStJ?=
 =?utf-8?B?blNCNTNoRmExb21BMnZDalBBSHp3ZXJKNVhTYUdEMGxiaXIwa2ZrekR3K0JR?=
 =?utf-8?B?NlRaSW5tWXNNWjhpeW9BY2xVSmZNTFFXcTkzS3Z4VERxTStjRmxOSnh6VHUw?=
 =?utf-8?B?Ri9sYkRaYXFaRldUVlZQb28yckh5cmZNeVNlQ3M4Smk1N3JDaGxJdWZOYkg5?=
 =?utf-8?B?NUpuS25kbHpsL3Y1SVVtRDcyc3FEdHZReEhrRHBQM1dvUjE4M1hqZHo1RWpt?=
 =?utf-8?B?VmE3czE3bGlaOEZRNDRDZG5pOFU5R1hncTV5VjZvSDlzSDFhZjZUdkR4REJV?=
 =?utf-8?B?Z21XZmwwK0tTdmk0WjJXQkZpbmphQ0thSkQ5bkRldW0rTktJNElYQkZwelpP?=
 =?utf-8?B?K2JaeWl6Wk9kR3kwNEFMblRpU2dGalBwYm4wc1dXM0VlbjQ3YXZLaEs4WE9Q?=
 =?utf-8?B?NjViaEw4VXpwc2dKRGxtMmI2c01QWEJ1cE9oY3BzYnY5RTltMlNDZHB1YTJn?=
 =?utf-8?B?SWVKRVpJOXBMT3oyUDl1a0tPa3Jwd2lxZ1VDTGgxZ2psMytaQXZuY0l6QjQr?=
 =?utf-8?B?VTNwY0V1TjRsNEt6bDBpRUZOVHNxa0ZjNUZWdVYrVFpvbDFpQzdXc3V1L0Vn?=
 =?utf-8?B?VUh6ODJuV21lZzZrV3E1TWY5K3pqTnBnWWxwWTR1Y3FWWGNJSUgxcCsvTjM4?=
 =?utf-8?B?Qk5TSzVPcnZZUUVYZ01RM09hOTJwRmlyTHJJVjZ6Tnk3Rk1wemdrb3R0QkVZ?=
 =?utf-8?B?SVRnYVBrTXIvaDFRaUJoVjM1NlZNUm1SZHE3UUFQVVR0U3Y3d1Q4SnFDTDBV?=
 =?utf-8?B?RG5VTEpVZ205bEVRc1h4RUNJY0hkWnJIWnJTOXJ6bXpxM2hyNDMvajY4NHBX?=
 =?utf-8?B?K3ZVUWpMYThBWGFLSFFHRTU1dndQOExmdXlqay9VMWVuL0t6Y0xDTktiOTJ0?=
 =?utf-8?B?MDVjaE0vYXBOb01BaGMxZ1VLZ1o4Q1B4aWZwOFMzL1ZRUTVvSS83R0JZaUNa?=
 =?utf-8?B?QmtTNEd1TnJkd0RxM2x0ZkVFbFN4MWdhOE0wREdOSjMwdHZmNHRWZEpjbDgw?=
 =?utf-8?B?NG5abUFLVTVGTGtHY0J1blU3WWNUWS9ITDdRV2dIajR0Y3pFdkM0Sk5CbHFG?=
 =?utf-8?B?MHpXdmtESHNNbnhTRzliQ1dDQ0plcnJzRVVLdnZ5YmlYUmVNekRQMkozZGU4?=
 =?utf-8?B?VFFjcnV2Tkw5VlhvRm9ONjFUbFplVUVIVGxpMysvRDdWSWVzVUM2OG1DcXpU?=
 =?utf-8?B?RjFBZDNXb0RNZjJjV3FhaFNjelI0UW5RaWs1aXdWNGhEaWV2VEpXNi9pTlBq?=
 =?utf-8?B?K21KQUc5em85VnpWYSs1UHAvTy9JZk00bUVXTEhHM3pucVp4Yi9CNVJqWWFz?=
 =?utf-8?B?b3BNSlJpb0YrSUQ5aXZJNDFYTFkydHRxMEFqdVo4TFFveTA1bllVRmZZWFRH?=
 =?utf-8?B?cFpZK09sMHc3N1Y2aG9ldDd5cDBaQTBYQXBSbDJ1MCtQYUJtMTdNTWZ1K2tI?=
 =?utf-8?B?cmVkNWlKcTFWZTJ4bkQ4MElIR1c5Mlp0anRZejZPL2FvTTNNay9HcWxnOXBv?=
 =?utf-8?B?UGVSVWRXSHphNTdHM1htZ0FscG9ndjhGUWYzK3UvOVdKUkpuUmJSbFAwRDRi?=
 =?utf-8?B?RFAvZ2NoTEVTV2krNzV5cjdHV2wxb3JUdE5JcVZYZEtzNGhvRE9EV05JRlZ3?=
 =?utf-8?B?TTJaUTFBNHZGQjM2cVY4VGwya2g1bmpmTkRadVJnbTBYd3kzVXdCK1NndnVs?=
 =?utf-8?B?bVppc0NoQklLWHBjaFRyQXVPdEl0VHdQa3ZHWHU1R1RNcDR4Zkw0RzZGclRL?=
 =?utf-8?B?SnBlVHFBdlRNbThBNWJpeUpXN0hpWVRGd1FjNENSclU3ajF5Z2d4SGJ2bDl0?=
 =?utf-8?Q?5uO3gyUH2TfMrkibM/np24f86tCsDbG+s+r8b1qQ8oDO3?=
X-MS-Exchange-AntiSpam-MessageData-1: IN9aPMnFoMQFZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0082f7a7-544e-4fea-50a7-08da3a69f7c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:06:43.2365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stZHPoIAyn4b9gEfnJooIORBDDp/2hwUtsxtGqaRvvsHbad4PNTn8xyei4QZLS6cz0QnuwmnIQ5H3CMTnl8o+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Amar,

On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
> Allocate memory for register value and use the same values for devcoredump.
> Remove dump_stack reset register dumps.
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 7 +++----
>   3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 76df583663c7..c79d9992b113 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>   
>   	/* reset dump register */
>   	uint32_t                        *reset_dump_reg_list;
> +	uint32_t			*reset_dump_reg_value;
>   	int                             num_regs;
>   
>   	struct amdgpu_reset_domain	*reset_domain;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index eedb12f6b8a3..942fdbd316f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1683,7 +1683,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>   	char reg_offset[11];
> -	uint32_t *new, *tmp = NULL;
> +	uint32_t *new, *tmp = NULL, *tmp_value = NULL;
>   	int ret, i = 0, len = 0;
>   
>   	do {
> @@ -1709,17 +1709,24 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>   		i++;
>   	} while (len < size);
>   
> +	new = krealloc_array(tmp_value, i, sizeof(uint32_t), GFP_KERNEL);

tmp_value is initialized to NULL, which means krealloc_array() will 
behave like kmalloc_array(), is there any particular reason we are 
adding this variable at all just to use krealloc_array(), and why not 
use kmalloc_array() directly ?

> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
>   	ret = down_write_killable(&adev->reset_domain->sem);
>   	if (ret)
>   		goto error_free;
>   
>   	swap(adev->reset_dump_reg_list, tmp);
> +	swap(adev->reset_dump_reg_value, new);
>   	adev->num_regs = i;
>   	up_write(&adev->reset_domain->sem);
>   	ret = size;
>   
>   error_free:
>   	kfree(tmp);
> +	kfree(new);
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4daa0e893965..963c897a76e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4720,15 +4720,14 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   
>   static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   {
> -	uint32_t reg_value;
>   	int i;
>   
>   	lockdep_assert_held(&adev->reset_domain->sem);
> -	dump_stack();
This should be a part of different patch, where you can give some 
background on why are we removing this.
>   
>   	for (i = 0; i < adev->num_regs; i++) {
> -		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> -		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
> +				adev->reset_dump_reg_value[i]);
>   	}
>   
>   	return 0;

- Shashank
